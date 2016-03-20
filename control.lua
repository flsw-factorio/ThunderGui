--[[ include used code ]]
require "defines"

--$$ config and tools
require "config"
require "scripts.configTools"

--$$ The base gui Frame
require "superTopGui.superTopGui"
require "superTopGui.stgTools"

--$$ default interfaces from the gui
require "scripts.clockDisplay"
require "scripts.speedButton"
require "scripts.settingsButton"
require "scripts.minimizeButton"

--$$ plugins and interface
require "superTopGui.stgPlugins"
require "interface"

--[[ basic gui stuff ]]
function ctrl_remove_gui(player, playerindex)
	--$$ call OnRemoveGui from plugins
	if global.plugins then
		for key, modDataTable in pairs(global.plugins) do
			local interface = remote.interfaces[modDataTable.name]
			if modDataTable.cb_onRemoveGui and interface and interface[modDataTable.cb_onRemoveGui] then
				--player.print("calling remote OnRemoveGui")
				remote.call( modDataTable.name, modDataTable.cb_onRemoveGui, playerindex )
			end
		end
	end

	--$$ remove base
	tf_clockDisplay_remove(player, playerindex)
	tf_speedButton_remove(player, playerindex)
	tf_thunderButton_remove(player, playerindex)
	tf_minimizeButton_remove(player,playerindex)

	--$$ remove superTopGui
	stg_remove(player)
end

function ctrl_init_gui(player, playerindex)
	if player.gui.top.superTopGui then return end -- superTopGui is already created

	--$$ destroy superGui to refresh existing interface in case of mod-update..
	ctrl_remove_gui(player, playerindex)
	--$$ create superGui, exit if failed
	stg_create(player)
	if not player.gui.top.superTopGui then return end -- if failed to create superTopGui

	--$$ inserting time/clockDisplay
	tf_clockDisplay_create(player, playerindex)

	--$$ call onCreateGui from plugins
	if global.plugins then
		for key, modDataTable in pairs(global.plugins) do
			--[[
			player.print("found PlugIn: "..modDataTable.name)
			for k,v in pairs(modDataTable) do
				player.print( string.format( "%s = %q", tostring(k), v ) )
			end--]]
			if modDataTable.cb_onCreateGui then
				--player.print("calling remote OnCreateGui")
				remote.call( modDataTable.name, modDataTable.cb_onCreateGui, playerindex )
			end
		end
	end

	--$$ inserting minimizeButton
	tf_minimizeButton_create(player,playerindex)

	--$$ inserting speedbutton
	tf_speedButton_create(player, playerindex)

	--$$ inserting thunderButton
	tf_thunderButton_create(player, playerindex)
end

function ctrl_do_update(player, playerindex)
	--$$ initialize Gui
	ctrl_init_gui(player, playerindex)

	--$$ update base
	tf_clockDisplay_update(player, playerindex)

	--$$ update plugins
	if global.plugins then
		for key, modDataTable in pairs(global.plugins) do
			local interface = remote.interfaces[modDataTable.name]
			if modDataTable.cb_onUpdateGui and interface and interface[modDataTable.cb_onUpdateGui] then
				remote.call( modDataTable.name, modDataTable.cb_onUpdateGui, playerindex )
			end
		end
	end

end

--[ event onInit ]
script.on_init( function()
	if not MOD_ENABLED then return end
	--$$ initialize used variables
	cfgt_check_global_cfg()
	cfgt_playerCfg_resetAllPlayers()
end)

--[ event onLoad ]
script.on_load( function()
	--$$ check if our mod has changed(installed a new version)
	local checksDetectedOldData = false
	if cfgt_check_global_cfg() then
		checksDetectedOldData = true
		--$$ reset player configs too
		cfgt_playerCfg_resetAllPlayers()
	end
	--$$ check if our plugins have changed(installed a new version, removed mod, etc)
	if tf_check_allPlugins() then
		checksDetectedOldData = true
	end
	if checksDetectedOldData then
		--$$ old mod setup: remove, reload gui
		for playerindex, player in pairs(game.players) do
			ctrl_remove_gui(player, playerindex)
		end
	end
end)


--[ event onTick ]
script.on_event(defines.events.on_tick,
function(event)
	--$$ Update gui stuff regularly, though not every single tick.
	if game.tick % global.cfg.update_interval == 0 then
		for playerindex, player in pairs(game.players) do
			ctrl_do_update(player, playerindex)
		end
	end
end)

--[ event onplayercreated ]
--$$ multiplayer desync fix, remove warning, be carefull!! tip = create a backup before changing
script.on_event(defines.events.on_player_created,
function(event)
	--$$ give new player a config
	cfgt_playerCfg_check(event.player_index)

	--$$ refresh gui (from sp to mp) TODO: retest if it's still needed
	for locPlayerIndex, locPlayer in pairs(game.players) do
		ctrl_remove_gui(locPlayer, locPlayerIndex)
	end
end)

--[ event onguiclick ]
script.on_event(defines.events.on_gui_click,
function(event)
	--$$ Check for button clicks
	--$$ when a button is handled, the tf_#sampleName#Button_onguiclick(event) returns true
	if tf_minimizeButton_onguiclick(event) then return end
	if tf_speedButton_onguiclick(event) then return end
	if tf_thunderButton_onguiclick(event) then return end
end)


