remote.add_interface("ThunderGui",
{
	--$$ add/register plugin
	registerPlugin =
	function(pluginName, dataTable)
		tf_register_plugin(pluginName, dataTable)
	end,

	--$$ remove plugin
	removePlugin =
	function(pluginName)
		local pluginData = tf_get_pluginData(pluginName)
		if pluginData then
			--$$ callBack onRemove
			for locPlayerIndex, locPlayer in pairs(game.players) do
				local interface = remote.interfaces[pluginData.name]
				if modDataTable.cb_onRemoveGui and interface and interface[pluginData.cb_onRemoveGui] then
					--player.print("calling remote OnRemoveGui")
					remote.call( pluginData.name, pluginData.cb_onRemoveGui, locPlayerIndex )
				end--remove_gui(locPlayer, locPlayerIndex)
			end

			--$$ remove pluginData
			tf_remove_plugin(pluginName)

			--$$ update Gui ??
			--stg_updateAll()
		end
	end,

	--$$ update Gui
	updateGui =
	function(playerindex)
		if playerindex and playerindex <= #game.players and playerindex > 0 and #game.players > 0 then
			stg_update(game.players[playerindex], playerindex)
		else
			stg_updateAll()
		end
	end,

	--$$ re-create Gui	(Depricated,namechange:updateGui)
	reCreateGui =
	function(playerindex)
		if playerindex and playerindex <= #game.players and playerindex > 0 and #game.players > 0 then
			stg_update(game.players[playerindex], playerindex)
		else
			stg_updateAll()
		end
	end,

	--$$ get config properties
	getCfgProp =
	function(varName)
		if varName and type(varName) == "string" then
			return global.cfg[varName]
		end
		return nil
	end,

	--$$ activate or deactivate mod
	setEnabled =
	function(value)
		if value then
			global.cfg.enabled = true
		else
			global.cfg.enabled = false
			stg_updateAll()
		end
	end
})

