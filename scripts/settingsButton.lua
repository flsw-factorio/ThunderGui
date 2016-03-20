--[[ include used code ]]
require "thunderBox"

--[[ PUBLIC stuff ]]
function tf_thunderButton_remove(player, playerindex)
	stg_destroyActionElement(player, "tbnThunder")
	thunderBox_remove(player, playerindex)
end

function tf_thunderButton_create(player, playerindex)
	--$$ button
	local cfg = global.playerCfg[playerindex]
	if cfg.showSettingsButton then
		if player.gui.center.thunderBox then
			stg_createActionButton(player, "tbnThunder", "Settings -")
		else
			stg_createActionButton(player, "tbnThunder", "Settings +")
		end
	end
	--$$ frame
	thunderBox_pageUpdate(player, playerindex)
end

function tf_thunderButton_onguiclick(event)
	local playerindex = event.player_index
	local player = game.players[playerindex]

	--$$ regular used buttons
	if event.element.name == "tbnThunder" then
		thunderBox_openClose(player, playerindex) --show_default_page()
	elseif event.element.name == "tfrClose" then
		thunderBox_close(player, playerindex)
	elseif event.element.name == "tfrBack" then
		thunderBox_pageReturn(player, playerindex)
	elseif event.element.name == "tfrRefreshPage" then
		thunderBox_pageUpdate(player, playerindex)

	--$$ pages
	elseif event.element.name == "tbnShowGuiConfig" then
		--show_guiOptions_page(player, playerindex)
		thunderBox_showPage(player, playerindex, PAGE_GUI_SETTINGS)
	elseif event.element.name == "tbnShowthunderConfig" then
		--show_ThunderModOptions_page(player, playerindex)
		thunderBox_showPage(player, playerindex, PAGE_ADV_SETTINGS)
	elseif event.element.name == "tbnShowRemoveThunderPage" then
		--show_removeThunder_page(player, playerindex)
		thunderBox_showPage(player, playerindex, PAGE_REM_SETTINGS)
	elseif event.element.name == "tbnPluginSettings" then
		--show_pluginSettings_page(player, playerindex)
		thunderBox_showPage(player, playerindex, PAGE_PLG_SETTINGS)
	elseif event.element.name == "tbnShowAdvPlugins" then
		--show_Advancedplugin_page(player, playerindex)
		thunderBox_showPage(player, playerindex, PAGE_REM_PLUGINS)
	elseif event.element.name == "tbnShowDevTools" then
		--show_devTools_page(player, playerindex)
		thunderBox_showPage(player, playerindex, PAGE_DEV_BUTTONS)
	elseif event.element.name == "tbnShowGlobTables" then
		--show_devGlobTables_page(player, playerindex)
		thunderBox_showPage(player, playerindex, PAGE_DEV_GLOBALS)

	--$$ Select Settings table
	elseif event.element.name == "tbnSetsPlyr" then
		local cfg = global.playerCfg[playerindex]
		if cfg and not cfg.viewPlayerSettings then
			cfg.viewPlayerSettings = true
		end
		thunderBox_pageUpdate(player, playerindex)

	elseif event.element.name == "tbnSetsGlob" then
		local cfg = global.playerCfg[playerindex]
		if cfg and cfg.viewPlayerSettings then
			cfg.viewPlayerSettings = false
		end
		thunderBox_pageUpdate(player, playerindex)

	--$$ toggle global.cfg or global.playerCfg and refresh gui and/or page
	elseif event.element.name == "tbnToggleThunderButton" then
		local cfg = global.playerCfg[event.player_index]
		local updatePlayerOnly = true
		if not cfg or not cfg.viewPlayerSettings then
			cfg = global.cfg
			updatePlayerOnly = false
		end

		cfg.showSettingsButton = not cfg.showSettingsButton
		show_guiOptions_page(player, playerindex)
		--tf_thunderButton_remove(player, playerindex)
		if updatePlayerOnly then
			stg_update(player, playerindex)
		else
			for locPlayerindex, locPlayer in pairs(game.players) do
				global.playerCfg[locPlayerindex].showSettingsButton = cfg.showSettingsButton
				stg_update(locPlayer, locPlayerindex)
			end
		end
	elseif event.element.name == "tbnTglClockEnabled" then
		local cfg = global.playerCfg[event.player_index]
		local updatePlayerOnly = true
		if not cfg or not cfg.viewPlayerSettings then
			cfg = global.cfg
			updatePlayerOnly = false
		end

		cfg.showClock = not cfg.showClock
		thunderBox_pageUpdate(player, playerindex)
		if updatePlayerOnly then
			if cfg.showClock then
				stg_update(player, playerindex)
			else
				tf_clockDisplay_remove(player, playerindex)
			end
		else
			if cfg.showClock then
				for locPlayerindex, locPlayer in pairs(game.players) do
					global.playerCfg[locPlayerindex].showClock = cfg.showClock
					stg_update(locPlayer, locPlayerindex)
				end
			else
				for locPlayerindex, locPlayer in pairs(game.players) do
					global.playerCfg[locPlayerindex].showClock = cfg.showClock
					tf_clockDisplay_remove(locPlayer, locPlayerindex)
				end
			end
		end
	elseif event.element.name == "tbnTglSpeedBtnEnabled" then
		local cfg = global.playerCfg[event.player_index]
		local updatePlayerOnly = true
		if not cfg or not cfg.viewPlayerSettings then
			cfg = global.cfg
			updatePlayerOnly = false
		end

		cfg.showSpeedButton = not cfg.showSpeedButton
		thunderBox_pageUpdate(player, playerindex)
		if updatePlayerOnly then
			if cfg.showSpeedButton then
				stg_update(player, playerindex)
			else
				tf_speedButton_remove(player, playerindex)
			end
		else
			if cfg.showSpeedButton then
				for locPlayerindex, locPlayer in pairs(game.players) do
					global.playerCfg[locPlayerindex].showSpeedButton = cfg.showSpeedButton
					stg_update(locPlayer, locPlayerindex)
				end
			else
				for locPlayerindex, locPlayer in pairs(game.players) do
					global.playerCfg[locPlayerindex].showSpeedButton = cfg.showSpeedButton
					tf_speedButton_remove(locPlayer, locPlayerindex)
				end
			end
		end
	elseif event.element.name == "tbnTglSafeMode" then
		global.cfg.safeMultiplayerMode = not global.cfg.safeMultiplayerMode
		for locPlayerindex, locPlayer in pairs(game.players) do
			if locPlayerindex == 1 then
				thunderBox_pageUpdate(locPlayer, locPlayerindex)
			else
				stg_update(locPlayer, locPlayerindex)
			end
		end
	elseif event.element.name == "tbnTglDevMode" then
		global.cfg.developerMode = not global.cfg.developerMode
		thunderBox_pageUpdate(player, playerindex)
	elseif event.element.name == "tbnTglRemoveOnSave" then
		global.cfg.removeGui_onSave = not global.cfg.removeGui_onSave
		thunderBox_pageUpdate(player, playerindex)
	elseif event.element.name == "tbnTglRemLeftOfSuper" then
		global.cfg.removeElementsLeftOfSuperGui = not global.cfg.removeElementsLeftOfSuperGui
		if global.cfg.removeElementsLeftOfSuperGui then
			stg_updateAll()
		end
		thunderBox_pageUpdate(player, playerindex)

	--$$ TUps and TDowns
	elseif event.element.name == "tbnTUpInterval" then
		if global.cfg.update_interval < 3600 then -- one minute
			global.cfg.update_interval = global.cfg.update_interval + 10
			thunderBox_pageUpdate(player, playerindex)
		end
	elseif event.element.name == "tbnTDnInterval" then
		if global.cfg.update_interval > 10 then
			global.cfg.update_interval = global.cfg.update_interval - 10
			thunderBox_pageUpdate(player, playerindex)
		end
	elseif event.element.name == "tbnTUpTBoxW" then
		if global.cfg.thunderBox_minimalWidth < 800 then -- one minute
			global.cfg.thunderBox_minimalWidth = global.cfg.thunderBox_minimalWidth + 20
			thunderBox_pageUpdate(player, playerindex)
		end
	elseif event.element.name == "tbnTDnTBoxW" then
		if global.cfg.thunderBox_minimalWidth > 200 then
			global.cfg.thunderBox_minimalWidth = global.cfg.thunderBox_minimalWidth - 20
			thunderBox_pageUpdate(player, playerindex)
		end

	--$$ special buttons
	elseif event.element.name == "tbnResetCfg" then
		cfgt_cfg_reset(global.cfg)
		cfgt_playerCfg_resetAllPlayers()
		stg_updateAll()
		thunderBox_pageUpdate(player, playerindex)

	elseif event.element.name == "tbnRemovePlugins" then
		for locPlayerindex, locPlayer in pairs(game.players) do
			ctrl_remove_gui(locPlayer, locPlayerindex)
		end
		tf_remove_allPlugins()
		thunderBox_pageUpdate(player, playerindex)

	elseif event.element.name == "tbnDestroySuperGui" then
		stg_update(player, playerindex)
		if SLOW_GUI_UPDATE_MODE then
			thunderBox_pageUpdate(player, playerindex)
		end

	--$$ Remove plugin and else/return false case
	else
		local pos = string.find(event.element.name, "tbnRemPI_")
		if pos == nil or pos ~= 1 then return false end --$$ did not recognize button

		pluginName = string.sub(event.element.name, 10)
		if pluginName == nil then return true end --$$ did recognize button, but shit hits the fan

		for locPlayerindex, locPlayer in pairs(game.players) do
			ctrl_remove_gui(locPlayer, locPlayerindex)
		end
		tf_remove_plugin(pluginName)
		thunderBox_pageUpdate(player, playerindex)
	end
	return true ----$$ recognized button, we (shoudl have) handled it
end
