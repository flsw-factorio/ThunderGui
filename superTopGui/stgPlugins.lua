
function tf_register_plugin( pluginName, pluginData )
	local player = game.players[1]

	if not pluginName then
		if player then player.print("Error: plugin name is nil") end
		return
	end
	tf_remove_plugin( pluginName ) -- remove old-plugin data

	if not pluginData then
		if player then player.print( string.format("Error: Plugin %q missing DataTable", pluginName) ) end
		return
	end

	if not glob.plugins then 
		glob.plugins = {}
	end
	
	--[[
	if player then 
		for k,v in pairs(pluginData) do
			player.print( string.format( "%s = %q", tostring(k), v ) )
		end
	end--]]

	local DataTable = {}
	DataTable.name = pluginName
	DataTable.cb_onCreateGui = pluginData.cb_onCreateGui-- callback interface_functionName when creating the SuperTopGui
	DataTable.cb_onRemoveGui = pluginData.cb_onRemoveGui-- callback interface_functionName when removing the SuperTopGui
	DataTable.cb_onUpdateGui = pluginData.cb_onUpdateGui-- callback interface_functionName when updating the SuperTopGui
	DataTable.settingsBtn_name = pluginData.settingsBtn_name-- name for the Settings button in "Thunder+" --> "Plugin settings"

	--$$ data correct? update, refresh gui
	if tf_check_plugin( DataTable ) then return end
	
	if player and glob.cfg.developerMode then 
		player.print( string.format( "ThunderGui: adding Plugin %q", pluginName ) )
	end
	glob.plugins[#glob.plugins+1] = DataTable
	stg_updateAll()
end

function tf_remove_plugin( pluginName )
	local player = game.players[1]
	if glob.plugins then
		for key, pluginData in pairs(glob.plugins) do
			if pluginData.name == pluginName then
				if player then game.players[1].print( string.format( "ThunderGui: removing Plugin %q", pluginName ) ) end
				glob.plugins[key] = nil
				break
			end
		end
	end
end

function tf_get_pluginData( pluginName )
	local player = game.players[1]
	if glob.plugins then
		for key, pluginData in pairs(glob.plugins) do
			if pluginData.name == pluginName then				
				return glob.plugins[key]
			end
		end
	end
	return nil
end
function tf_check_plugin( dataTable )
	local player = game.players[1]
	local plugInterface = remote.interfaces[dataTable.name]

	if not plugInterface then
		if player then player.print("Error: Plugin has no callback-interface: "..dataTable.name) end
		return true
	end

	if dataTable.cb_onCreateGui and not plugInterface[dataTable.cb_onCreateGui] then
		if player then player.print("Error: Plugin is missing onCreate callback-function "..dataTable.cb_onCreateGui) end
		return true
	end
	if dataTable.cb_onRemoveGui and not plugInterface[dataTable.cb_onRemoveGui] then
		if player then player.print("Error: Plugin is missing onRemove callback-function "..dataTable.cb_onRemoveGui) end
		return true
	end
	if dataTable.cb_onUpdateGui and not plugInterface[dataTable.cb_onUpdateGui] then
		if player then player.print("Error: Plugin is missing onUpdate callback-function "..dataTable.cb_onUpdateGui) end
		return true
	end

	return false
end

function tf_check_allPlugins()
	local removedPlugin = false
	if glob.plugins then
		for key, pluginData in pairs(glob.plugins) do
			if tf_check_plugin( pluginData ) then
				tf_remove_plugin( pluginData.name )
				removedPlugin =  true
			end
		end
	end
	return removedPlugin
end

function tf_remove_allPlugins()
	if glob.plugins then
		glob.plugins = nil;
	end
end
