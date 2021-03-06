--[[ include used code ]]
require "table_to_gui_transformations"

PAGE_CLOSED = 0
PAGE_DEFAULT = 1
PAGE_GUI_SETTINGS = 2
PAGE_REM_SETTINGS = 3
PAGE_ADV_SETTINGS = 4
PAGE_PLG_SETTINGS = 5
PAGE_REM_PLUGINS = 6
PAGE_DEV_BUTTONS = 10
PAGE_DEV_GLOBALS = 11

--[[ local thunderBox actions ]]
local function add_refresh_button(guiFrame, playerindex)
	local myElement = guiFrame.add( { type= "button", name= "tfrRefreshPage", caption= "refresh" } )
	myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth
	myElement.style.font_color = { r=0.5,g=0.5,b=1 }
end

local function add_bottom_frame(guiFrame, playerindex, back_button)
	local myFlow = guiFrame.add( { type="flow", direction="horizontal" } )
	myFlow.style.minimal_width = global.cfg.thunderBox_minimalWidth
	myFlow.style.top_padding = 8
	if back_button then
		local myElement = myFlow.add( { type= "button", name= "tfrBack", caption="back" } )
		myElement.style.font_color = { r=1,g=1,b=0 }
	end
	myFlow.add( { type= "button", name= "tfrClose", caption="close" } )
end

local function tb_openRenew(player, playerindex)
   local myFrame = player.gui.center.thunderBox
 	if myFrame then
      myFrame.destroy();
   end
	stg_setActionElementCaption(player, "tbnThunder", "Settings -")
	return player.gui.center.add( { type="frame", name="thunderBox",
		caption = "Settings box", style="tms_frame_compact", direction="vertical"} )
end

local function showPage_default(player, playerindex)
		local myFrame = tb_openRenew(player, playerindex)
		local myElement = myFrame.add( { type= "label", style= "tms_label", caption= cfgt_getVersionString(global.cfg.version) } )
		myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth

		local myFlow = myFrame
		if global.cfg.developerMode then
			myFlow = myFrame.add( { type="flow", direction="vertical", style="tms_flow_compact" } )
				myFlow.style.top_padding = 2
				myFlow.style.bottom_padding = 4
		end

		myElement = myFlow.add( { type= "button", name= "tbnShowGuiConfig", caption= "Gui settings" } )
		myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth

		if playerindex <= 1 or (playerindex > 1 and not global.cfg.safeMultiplayerMode) then
			myElement = myFlow.add( { type= "button", name= "tbnShowthunderConfig", caption= "Advanced settings" } )
		else
			myElement = myFlow.add( { type= "button", style= "tms_buttonInactive", caption= "Advanced settings" } )
		end
		myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth

		myElement = myFlow.add( { type= "button", name= "tbnPluginSettings", caption= "Plugin settings" } )
		myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth

		if global.cfg.developerMode then
			myFlow = myFrame.add( { type="flow", direction="vertical" } ) --$$ extra spacing

			myElement = myFlow.add( { type= "button", name= "tbnShowDevTools", caption= "developer tools" } )
			myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth
		end

		add_bottom_frame(myFrame, playerindex, false)
		global.thunderFrame_page[playerindex] = PAGE_DEFAULT
end

local function showPage_guiSettings(player, playerindex)
	local myFrame = tb_openRenew(player, playerindex)
	local myElement = myFrame.add( { type= "label", style= "tms_label_title", caption= "-->Gui settings" } )
	myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth

	--$$ get selected config
	local selectedConfig = ""
	local viewPlayerSettings = false
	local cfg = global.playerCfg[playerindex]
	if cfg and ( cfg.viewPlayerSettings or (global.cfg.safeMultiplayerMode and playerindex > 1 ))then
		viewPlayerSettings = true
		cfg.viewPlayerSettings = true
		selectedConfig = "player "..tostring(playerindex)
	else
		cfg = global.cfg
		selectedConfig = "global"
	end

	local myCompactFlow = myFrame.add( { type="flow", direction="vertical", style="tms_flow_compact" } )

	local myHorizontalFlow = myCompactFlow.add( { type= "flow", direction= "horizontal", style= "tms_flow_compact" } )
	myHorizontalFlow.style.minimal_width = thunderBox_minimalWidth
		myElement = myHorizontalFlow.add( { type= "button", name= "tbnSetsPlyr", style= "tms_button", caption= "player" } )
	if playerindex <= 1 or not global.cfg.safeMultiplayerMode then
		myElement = myHorizontalFlow.add( { type= "button", name= "tbnSetsGlob", style= "tms_button", caption= "global" } )
	else
		myElement = myHorizontalFlow.add( { type= "button", style= "tms_buttonInactive", caption= "global" } )
	end

	local mySettingsFlow = myCompactFlow.add( { type= "frame", direction= "vertical", style="tms_frameAlpha" } )
	mySettingsFlow.style.bottom_padding = 8

	local myElement = mySettingsFlow.add( {type= "label", style= "tms_label_title",
			caption= string.format( "Settings from: %q", selectedConfig ) } )
	myElement.style.minimal_width = thunderBox_minimalWidth
	myElement.style.font_color = { r=0.7,g=0.7,b=1}

	if not viewPlayerSettings and #game.players > 1 then
		local myElement = mySettingsFlow.add( { type= "label", style= "tms_label",
			caption= "Changes made here will affect all players!" } )
		myElement.style.font_color= {r=1}
	end

	local myCompactFlow = mySettingsFlow.add( { type="flow", direction="vertical" } )
		myCompactFlow.style.top_padding = 2
		myCompactFlow.style.bottom_padding = 4
		myCompactFlow.style.left_padding = 10
		myCompactFlow.style.right_padding = 0

	local myHorizontalFlow = myCompactFlow.add( { type= "flow", direction= "horizontal" } )
	myHorizontalFlow.style.minimal_width = global.cfg.thunderBox_minimalWidth-10
	myElement = myHorizontalFlow.add( { type= "button", name= "tbnTglClockEnabled", style= "tms_button", caption= "toggle" } )
	myElement = myHorizontalFlow.add( {type= "label", style= "tms_label",
			caption= string.format( "show clock = %s", tostring(cfg.showClock) ) } )


	myHorizontalFlow = myCompactFlow.add( { type= "flow", direction= "horizontal" } )
	myHorizontalFlow.style.minimal_width = global.cfg.thunderBox_minimalWidth-10
	myElement = myHorizontalFlow.add( { type= "button", name= "tbnTglSpeedBtnEnabled", style= "tms_button", caption= "toggle" } )
	myElement = myHorizontalFlow.add( { type= "label", style= "tms_label",
			caption= string.format( "show Speed+ button = %s", tostring(cfg.showSpeedButton) ) } )


	if cfg.showSettingsButton then
		myElement = mySettingsFlow.add( { type= "button", name= "tbnShowRemoveThunderPage", caption= "remove settings+ button" } )
		myElement.style.font_color = { r=1,g=0.5,b=0 }
		myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth
	else
		myElement = mySettingsFlow.add( { type= "button", name= "tbnToggleThunderButton", caption= "show settings+ button" } )
		myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth
	end

	add_bottom_frame(myFrame, playerindex, true)
	global.thunderFrame_page[playerindex] = PAGE_GUI_SETTINGS
end

local function showPage_removeSettingsButton(player, playerindex)
	local myFrame = tb_openRenew(player, playerindex)

	--$$ get selected config
	local selectedConfig = ""
	local viewPlayerSettings = false
	local cfg = global.playerCfg[playerindex]
	if cfg and ( cfg.viewPlayerSettings or (global.cfg.safeMultiplayerMode and playerindex > 1 ))then
		viewPlayerSettings = true
		cfg.viewPlayerSettings = true
		selectedConfig = "player "..tostring(playerindex)
	else
		cfg = global.cfg
		selectedConfig = "global"
	end

	local myElement = myFrame.add( { type= "label", style= "tms_label_title", caption= "-->Gui settings-->Remove settings+ button:" } )
	myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth

	myElement = myFrame.add( { type= "label", style= "tms_label",
			caption= "Are you really sure?" } )
	myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth
	myElement.style.font= "default-frame"
	myElement.style.font_color = { r=1,g=0.25,b=0 }
	myElement = myFrame.add( { type= "label", style= "tms_label",
			caption= string.format("Remove the settings button from %s?", selectedConfig) } )
	myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth
	myElement.style.font= "default-frame"
	myElement.style.font_color = { r=1,g=0.0,b=0 }

	if viewPlayerSettings then
		myElement = myFrame.add( { type= "label", style= "tms_label",
				caption= " 4 ways to bring the button back:" } )
		myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth

		myElement = myFrame.add( { type= "label", style= "tms_label",
				caption= "-> changing global settings at a different player" } )
	else
		myElement = myFrame.add( { type= "label", style= "tms_label",
				caption= " 3 ways to bring the button back:" } )
	end
	myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth

	myElement = myFrame.add( { type= "label", style= "tms_label",
			caption= "-> changing/reseting settings before closing settings" } )
	myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth
	myElement = myFrame.add( { type= "label", style= "tms_label",
			caption= "-> use a different version of the ThunderGui mod" } )
	myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth
	myElement = myFrame.add( { type= "label", style= "tms_label",
			caption= "-> hacking" } )
	myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth
	myElement.style.bottom_padding = 10

	myElement = myFrame.add( { type= "button", name= "tbnToggleThunderButton", caption= "Yes, remove settings+ button!!" } )
	myElement.style.font_color = { r=1,g=0,b=0}
	myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth

	add_bottom_frame(myFrame, playerindex, true)
	global.thunderFrame_page[playerindex] = PAGE_REM_SETTINGS
end

local function showPage_advancedSettings(player, playerindex)
	local myFrame = tb_openRenew(player, playerindex)
	local myElement = myFrame.add( { type= "label", style= "tms_label_title", caption= "-->Advanced settings: (global)" } )
	myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth

	local btnWidth = 42
	local myFlow = myFrame.add( { type= "flow", direction= "horizontal" } )
	myFlow.style.minimal_width = global.cfg.thunderBox_minimalWidth
	local myCompactFlow = myFlow.add( { type= "flow", direction= "horizontal", style= "tms_flow_compact" } )
	myElement = myCompactFlow.add( { type= "button", name= "tbnTUpInterval", style= "tms_button", caption= "up" } )
	myElement.style.minimal_width = btnWidth
	myElement = myCompactFlow.add( { type= "button", name= "tbnTDnInterval", style= "tms_button", caption= "dn" } )
	myElement.style.minimal_width = btnWidth
	myElement = myFlow.add( {type= "label", style= "tms_label",
			caption= string.format( "update interval = %d", global.cfg.update_interval ) } )

	myFlow = myFrame.add( { type= "flow", direction= "horizontal" } )
	myFlow.style.minimal_width = global.cfg.thunderBox_minimalWidth
	local myCompactFlow = myFlow.add( { type= "flow", direction= "horizontal", style= "tms_flow_compact" } )
	myElement = myCompactFlow.add( { type= "button", name= "tbnTUpTBoxW", style= "tms_button", caption= "up" } )
	myElement.style.minimal_width = btnWidth
	myElement = myCompactFlow.add( { type= "button", name= "tbnTDnTBoxW", style= "tms_button", caption= "dn" } )
	myElement.style.minimal_width = btnWidth
	myElement = myFlow.add( {type= "label", style= "tms_label",
			caption= string.format( "settingsBox min. width = %d", global.cfg.thunderBox_minimalWidth ) } )

	myFlow = myFrame.add( { type= "flow", direction= "horizontal" } )
	myFlow.style.minimal_width = global.cfg.thunderBox_minimalWidth
	myElement = myFlow.add( { type= "button", name= "tbnTglRemoveOnSave", style= "tms_button", caption= "toggle" } )
	myElement.style.minimal_width = btnWidth*2
	myElement = myFlow.add( { type= "label", style= "tms_label",
			caption= string.format( "remove gui before saving = %s", tostring(global.cfg.removeGui_onSave) ) } )

	myFlow = myFrame.add( { type= "flow", direction= "horizontal" } )
	myFlow.style.minimal_width = global.cfg.thunderBox_minimalWidth
	myElement = myFlow.add( { type= "button", name= "tbnTglDevMode", style= "tms_button", caption= "toggle" } )
	myElement.style.minimal_width = btnWidth*2
	myElement.style.font_color = { r=1,g=0.5,b=0 }
	myElement = myFlow.add( {type= "label", style= "tms_label",
			caption= string.format( "developer mode = %s", tostring(global.cfg.developerMode) ) } )

	myFlow = myFrame.add( { type= "flow", direction= "horizontal" } )
	myFlow.style.minimal_width = global.cfg.thunderBox_minimalWidth
	myElement = myFlow.add( { type= "button", name= "tbnTglSafeMode", style= "tms_button", caption= "toggle" } )
	myElement.style.minimal_width = btnWidth*2
	myElement.style.font_color = { r=1,g=0,b=0 }
	myElement = myFlow.add( {type= "label", style= "tms_label",
			caption= string.format( "safe multiplayer mode = %s", tostring(global.cfg.safeMultiplayerMode) ) } )

	local myHorizontalFlow = myFrame.add( { type= "flow", direction= "horizontal" } )
	myHorizontalFlow.style.minimal_width = global.cfg.thunderBox_minimalWidth
	myElement = myHorizontalFlow.add( { type= "button", name= "tbnTglRemLeftOfSuper", style= "tms_button", caption= "toggle" } )
	myElement.style.minimal_width = btnWidth*2
	myElement.style.font_color = { r=1,g=0,b=0 }
	myHorizontalFlow = myHorizontalFlow.add( { type= "flow", direction= "vertical", style="tms_flow_compact" } )
		myElement = myHorizontalFlow.add( {type= "label", style= "tms_label",
				caption= string.format( "remove items on the left of topGui = %s", tostring(global.cfg.removeElementsLeftOfSuperGui) ) } )
		myElement = myHorizontalFlow.add( { type= "label", style= "tms_label", caption= "( can cause crashes in other mods )" } )
		myElement.style.font_color = { r=1,g=0,b=0 }

	myElement = myFrame.add( { type= "button", name= "tbnResetCfg", caption= "reset ThunderGui configuration" } )
	myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth
	myElement.style.font_color = { r=1,g=0.5,b=0}

	add_bottom_frame(myFrame, playerindex, true)
	global.thunderFrame_page[playerindex] = PAGE_ADV_SETTINGS
end

local function showPage_pluginSettings(player, playerindex)
	local myFrame = tb_openRenew(player, playerindex)
	local myElement = myFrame.add( { type= "label", style= "tms_label_title", caption= "-->Plugin settings: " } )
	myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth

	if global.plugins and #global.plugins > 0 then
		local myFlow = myFrame.add( { type= "flow", direction= "vertical" } )
		myFlow.style.minimal_width = global.cfg.thunderBox_minimalWidth
		local missingSettingsButton = false

		for key, modDataTable in pairs(global.plugins) do
			if modDataTable.settingsBtn_name then
				myElement = myFlow.add( { type= "button", name= modDataTable.settingsBtn_name, caption= modDataTable.name } )
				myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth
			else
				missingSettingsButton = true
			end
		end

		if missingSettingsButton then
			local myFlow = myFrame.add( { type= "flow", direction= "vertical" } )
			myFlow.style.minimal_width = global.cfg.thunderBox_minimalWidth
			myElement = myFlow.add( { type= "label", style= "tms_label", caption= "plugins without settings:" } )
			myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth

			for key, modDataTable in pairs(global.plugins) do
				if not modDataTable.settingsBtn_name then
					myElement = myFlow.add( { type= "label", caption= modDataTable.name } )
					myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth
					myElement.style.left_padding = 20
				end
			end
		end

		if playerindex <= 1 or (playerindex > 1 and not global.cfg.safeMultiplayerMode) then
			myElement = myFrame.add( { type= "button", name= "tbnShowAdvPlugins", caption= "remove plugins" } )
			myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth
			myElement.style.font_color = { r=1,g=0.5,b=0}
		end
	else
		myFrame.add( { type= "label", style= "tms_label", caption= "no plugins installed" } )
	end

	add_bottom_frame(myFrame, playerindex, true)
	global.thunderFrame_page[playerindex] = PAGE_PLG_SETTINGS
end

local function showPage_removePlugins(player, playerindex)
	local myFrame = tb_openRenew(player, playerindex)
	local myElement = myFrame.add( { type= "label", style= "tms_label_title", caption= "-->Plugin settings:-->remove:" } )
	myElement.style.font_color = { r=1,g=0.5,b=0}
	myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth

	local myElement = myFrame.add( { type= "label", style= "tms_label_fat", caption= "Warning:" } )
	myElement.style.font_color = { r=1,g=0.0,b=0}
	myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth
	local myElement = myFrame.add( { type= "label", style= "tms_label_fat", caption= "A removed plugin can't be restored!" } )
	myElement.style.font_color = { r=1,g=0.0,b=0}
	myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth

	if global.plugins and #global.plugins > 0 then
		local myFlow = myFrame.add( { type= "flow", direction= "vertical" } )
		myFlow.style.minimal_width = global.cfg.thunderBox_minimalWidth

		for key, modDataTable in pairs(global.plugins) do
			myElement = myFlow.add( { type= "button", name= string.format( "tbnRemPI_%s", modDataTable.name ), caption= modDataTable.name } )
			myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth
		end

		--$$ remove plugins
		myElement = myFrame.add( { type= "button", name= "tbnRemovePlugins", caption= "remove all plugins" } )
		myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth
		myElement.style.font_color = { r=1,g=0,b=0}
	end

	add_bottom_frame(myFrame, playerindex, true)
	global.thunderFrame_page[playerindex] = PAGE_REM_PLUGINS
end

local function showPage_devTools(player, playerindex)
	local myFrame = tb_openRenew(player, playerindex)
	local myElement = myFrame.add( { type= "label", style= "tms_label_title", caption= "-->Developer tools: " } )
	myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth

	local myFlow = myFrame.add( { type="flow", direction="vertical" --[[, style="tms_flow_compact"--]] } )
		myFlow.style.bottom_padding = 4

	myFlow = myFrame.add( { type="flow", direction="vertical", style="tms_flow_compact" } )

	myElement = myFlow.add( { type= "button", name= "tbnShowGlobTables", caption= "glob cfg" } )
	myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth

	myElement = myFlow.add( { type= "button", name= "tbnDestroySuperGui", caption= "destroy superTopGui" } )
	myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth
	myElement.style.font_color = { r=0.2,g=1,b=0.2 }

	add_bottom_frame(myFrame, playerindex, true)
	global.thunderFrame_page[playerindex] = PAGE_DEV_BUTTONS
end

local function showPage_devGlobCfg(player, playerindex)
	local myFrame = tb_openRenew(player, playerindex)
	local myElement = myFrame.add( { type= "label", style= "tms_label_title", caption= "-->Dev-->glob cfg:" } )
	myElement.style.minimal_width = global.cfg.thunderBox_minimalWidth

	transform_keys_to_labels(global, "global", myFrame)
	transform_keysvaluepairs_to_labels(global.cfg, "global.cfg", myFrame)

	add_refresh_button(myFrame, playerindex)
	add_bottom_frame(myFrame, playerindex, true)
	global.thunderFrame_page[playerindex] = PAGE_DEV_GLOBALS
end

--[[ PUBLIC stuff ]]
function thunderBox_remove(player)
	if player.gui.center.thunderBox then
		player.gui.center.thunderBox.destroy()
	end
end

function thunderBox_openClose(player, playerindex)
	if global.thunderFrame_page == nil then -- table-base is nil
		global.thunderFrame_page = {}
	end
	if not player.gui.center.thunderBox then
		showPage_default(player, playerindex)
		stg_setActionElementCaption(player, "tbnThunder", "Settings -")
	else
		player.gui.center.thunderBox.destroy()
		global.thunderFrame_page[playerindex] = PAGE_CLOSED
		stg_setActionElementCaption(player, "tbnThunder", "Settings +")
	end
end

function thunderBox_close(player, playerindex)
	thunderBox_remove(player)
	if global.thunderFrame_page then
		global.thunderFrame_page[playerindex] = PAGE_CLOSED
	end
	stg_setActionElementCaption(player, "tbnThunder", "Settings +")
end

function thunderBox_pageReturn(player, playerindex)
	if global.thunderFrame_page[playerindex] then
		if global.thunderFrame_page[playerindex] == PAGE_REM_SETTINGS then --$$ from remove settings+ page
			showPage_guiSettings(player, playerindex)
		elseif global.thunderFrame_page[playerindex] == PAGE_REM_PLUGINS then --$$ from remove plugins page
			showPage_pluginSettings(player, playerindex)
		elseif global.thunderFrame_page[playerindex] > PAGE_DEV_BUTTONS then--$$ from dev-glob page
			showPage_devTools(player, playerindex)
		elseif global.thunderFrame_page[playerindex] > PAGE_DEFAULT then
			showPage_default(player, playerindex)
		else
			thunderBox_remove(player, playerindex)
		end
	else
		thunderBox_remove(player, playerindex)
	end
end

function thunderBox_pageUpdate(player, playerindex)
	if global.thunderFrame_page == nil then -- table-base is nil
		global.thunderFrame_page = {}
		global.thunderFrame_page[playerindex] = PAGE_CLOSED
		return
	elseif not global.thunderFrame_page[playerindex] or global.thunderFrame_page[playerindex] <= 0 then --$$ nills and negatives, WTF
		global.thunderFrame_page[playerindex] = PAGE_CLOSED
		thunderBox_remove(player, playerindex)
	elseif global.thunderFrame_page[playerindex] == PAGE_DEFAULT then
		showPage_default(player, playerindex)
	elseif global.thunderFrame_page[playerindex] == PAGE_GUI_SETTINGS then
		showPage_guiSettings(player, playerindex)
	elseif global.thunderFrame_page[playerindex] == PAGE_REM_SETTINGS then
		showPage_removeSettingsButton(player, playerindex)
	elseif global.thunderFrame_page[playerindex] == PAGE_ADV_SETTINGS then
		showPage_advancedSettings(player, playerindex)
	elseif global.thunderFrame_page[playerindex] == PAGE_PLG_SETTINGS then
		showPage_pluginSettings(player, playerindex)
	elseif global.thunderFrame_page[playerindex] == PAGE_REM_PLUGINS then
		showPage_removePlugins(player, playerindex)
	elseif global.thunderFrame_page[playerindex] == PAGE_DEV_BUTTONS then
		showPage_devTools(player, playerindex)
	elseif global.thunderFrame_page[playerindex] == PAGE_DEV_GLOBALS then
		showPage_devGlobCfg(player, playerindex)
	else
		global.thunderFrame_page[playerindex] = PAGE_CLOSED
		thunderBox_remove(player, playerindex)
	end
end

function thunderBox_showPage(player, playerindex, pageNumber )
	if pageNumber == nil then return end
	if global.thunderFrame_page == nil then
		global.thunderFrame_page = {}
	end
	global.thunderFrame_page[playerindex] = pageNumber
	thunderBox_pageUpdate(player, playerindex)
end

