--[[ PUBLIC stuff ]]
function cfgt_getVersionString(version)
	if version == nil then return "version: unkown" end
	local version_prime = math.floor(version)
	local version_second = (version-version_prime)*10 
	local version_third = (version_second- math.floor(version_second))*10
	return string.format("version: %d.%d.%d", version_prime, math.floor(version_second), version_third )
end

function cfgt_check_global_cfg()
	--$$ (re-)Load config (if running game is using old mod-settings)
	if not glob.cfg or glob.cfg.version == nil or glob.cfg.version ~= MOD_VERSION then  --undefined or version change
		if glob.cfg then --version change
			--$$ inform players of the changes made/why
			for _, player in pairs(game.players) do
				player.print( string.format( 
						"ThunderGui: mod-version change detected(%s). Loading configuration defaults(%s)", 
						cfgt_getVersionString(glob.cfg.version), cfgt_getVersionString(MOD_VERSION) ) )
			end
		end
		glob.cfg = {}
		cfgt_cfg_reset(glob.cfg)
		return true
	end
	return false
end

function cfgt_cfg_reset(cfg)--$$ can be used to create/refresh glob.cfg and (future) playerData[id].cfg (playerSpecific Options)
	--$$ create cfg table ... should already be done!! 
	--cfg = {}

	cfg.version = MOD_VERSION
	cfg.update_interval = MOD_UPDATE_INTERVAL
	cfg.thunderBox_minimalWidth = DEFAULT_THUNDERBOX_WIDTH

	cfg.viewPlayerSettings = SHOW_PLAYER_SETTINGS
	cfg.showClock = SHOW_CLOCK_PANEL
	cfg.showSpeedButton = SHOW_SPEED_BUTTON
	cfg.showSettingsButton = SHOW_SETTINGS_BUTTON

	cfg.removeElementsLeftOfSuperGui = REMOVE_ELEMENTS_LEFT_OF_SUPER_TOP_GUI
	cfg.removeGui_onSave = REMOVE_GUI_ON_SAVE
	cfg.developerMode = DEVELOPER_MODE
	cfg.safeMultiplayerMode = SAFE_MULTIPLAYER_MODE
end 


function cfgt_playerCfg_reset(player_cfg)
	--$$ create cfg table ... should already be done!! 
	--player_cfg = {}

	player_cfg.minAP = DEFAULT_ACTION_PANEL_MINIMIZED
	player_cfg.viewPlayerSettings = glob.cfg.viewPlayerSettings --$$ show player/glob settings : true/false
	player_cfg.showClock = glob.cfg.showClock --$$ show clock
	player_cfg.showSpeedButton = glob.cfg.showSpeedButton --$$ show speed+ button
	player_cfg.showSettingsButton = glob.cfg.showSettingsButton --$$ show thunder+ button
end

function cfgt_playerCfg_resetAllPlayers()
	if glob.playerCfg == nil then
		glob.playerCfg = {}
	end
	for PIndex, player in pairs(game.players) do
		if glob.playerCfg[PIndex] == nil then
			glob.playerCfg[PIndex] = {}
		end
		cfgt_playerCfg_reset( glob.playerCfg[PIndex] )
	end
end

function cfgt_playerCfg_check(playerindex)
	if glob.playerCfg == nil then
		glob.playerCfg = {}
	end
	if glob.playerCfg[playerindex] == nil then
		glob.playerCfg[playerindex] = {}
		cfgt_playerCfg_reset( glob.playerCfg[playerindex] )
	end
end
