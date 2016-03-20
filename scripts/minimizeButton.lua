local function tf_minimize_actionPanel(player,playerindex)
	local stGui = player.gui.top.superTopGui
	if glob.playerCfg[playerindex].minAP then
		--$$ re-open actionPanel
		glob.playerCfg[playerindex].minAP = false
		stg_update(player, playerindex)
		--[[
		if stGui then
			--$$ panel
			stGui.destroy()
			ctrl_do_update(player, playerindex)
		end
		--]]
	else
		glob.playerCfg[playerindex].minAP = true
		--$$ close actionPanel
		if stGui then
			--$$ panel
			if stGui.stg_actionPanel then
				stGui.stg_actionPanel.destroy()
			end

			--$$ button
			if stGui.stg_backPanel and stGui.stg_backPanel.tbnMinimize then
				stGui.stg_backPanel.tbnMinimize.caption = ">>"
			end
		end
	end
end

--[[ PUBLIC stuff ]]
function tf_minimizeButton_create(player,playerindex)
	--$$ memory
	local stGui = player.gui.top.superTopGui
	local txt = "<<"
	if glob.playerCfg[playerindex].minAP then
		txt = ">>"
		if stGui and stGui.stg_actionPanel then
			stGui.stg_actionPanel.destroy()
		end
	else
		glob.minimizedPanel = {}
		glob.minimizedPanel[playerindex] = false
	end

	--$$ create button
	if stGui and stGui.stg_backPanel and not stGui.stg_backPanel.tbnMinimize then
		stGui.stg_backPanel.add( { type= "button", name= "tbnMinimize", style= "tms_buttonInvis", caption= txt } )
	end
end

function tf_minimizeButton_remove(player,playerindex)
	local stGui = player.gui.top.superTopGui
	if stGui and stGui.stg_backPanel and stGui.stg_backPanel.tbnMinimize then
		stGui.stg_backPanel.tbnMinimize.destroy()
	end
end

function tf_minimizeButton_onguiclick(event)
	if event.element.name == "tbnMinimize" then
		tf_minimize_actionPanel(game.players[event.playerindex], event.playerindex)
	else 
		return false
	end
	return true
end
