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
	if not global.cfg or global.cfg.version == nil or global.cfg.version ~= MOD_VERSION then  --undefined or version change
		if global.cfg then --version change
			--$$ inform players of the changes made/why
			for _, player in pairs(game.players) do
				player.print( string.format(
						"ThunderGui: mod-version change detected(%s). Loading configuration defaults(%s)",
						cfgt_getVersionString(global.cfg.version), cfgt_getVersionString(MOD_VERSION) ) )
			end
		end
		global.cfg = {}
		cfgt_cfg_reset(global.cfg)
		return true
	end
	return false
end

function cfgt_cfg_reset(cfg)--$$ can be used to create/refresh global.cfg and (future) playerData[id].cfg (playerSpecific Options)
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
	player_cfg.viewPlayerSettings = global.cfg.viewPlayerSettings --$$ show player/global settings : true/false
	player_cfg.showClock = global.cfg.showClock --$$ show clock
	player_cfg.showSpeedButton = global.cfg.showSpeedButton --$$ show speed+ button
	player_cfg.showSettingsButton = global.cfg.showSettingsButton --$$ show thunder+ button
end

function cfgt_playerCfg_resetAllPlayers()
	if global.playerCfg == nil then
		global.playerCfg = {}
	end
	for PIndex, player in pairs(game.players) do
		if global.playerCfg[PIndex] == nil then
			global.playerCfg[PIndex] = {}
		end
		cfgt_playerCfg_reset( global.playerCfg[PIndex] )
	end
end

function cfgt_playerCfg_check(playerindex)
	if global.playerCfg == nil then
		global.playerCfg = {}
	end
	if global.playerCfg[playerindex] == nil then
		global.playerCfg[playerindex] = {}
		cfgt_playerCfg_reset( global.playerCfg[playerindex] )
	end
end
