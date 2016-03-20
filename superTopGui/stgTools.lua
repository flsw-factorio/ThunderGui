
--[[ PUBLIC  update superTopGui ]]
function stg_updateAll()
	for playerindex, player in pairs(game.players) do
		if player.gui.top.superTopGui then
			if glob.cfg.developerMode then
				player.print( "ThunderGui: updating superTopGui" )
			end
			player.gui.top.superTopGui.destroy()
		end
		if not SLOW_GUI_UPDATE_MODE then
			ctrl_do_update(player, playerindex)
		end
	end
end

function stg_update(player,playerindex)
	if player.gui.top.superTopGui then
		player.gui.top.superTopGui.destroy()
	end
	if not SLOW_GUI_UPDATE_MODE then
		ctrl_do_update(player, playerindex)
	end
end

--[[ PUBLIC  update superTopGui Actionelements ]]
function stg_setActionElementCaption(player, elementName, caption)
	local stGui = player.gui.top.superTopGui
	if stGui and stGui.stg_actionPanel then
		local guiElement = stGui.stg_actionPanel[elementName]
		if guiElement then
			guiElement.caption= caption
		end
	end
end

function stg_createActionButton(player, buttonName, buttonCaption)
	local stGui = player.gui.top.superTopGui
	if stGui and stGui.stg_actionPanel and not stGui.stg_actionPanel[buttonName] then
		stGui.stg_actionPanel.add( { type= "button", name= buttonName, style= "tms_buttonAlpha", caption= buttonCaption } )
	end
end

function stg_destroyActionElement(player, elementName)
	local stGui = player.gui.top.superTopGui
	if stGui and stGui.stg_actionPanel then
		local guiElement = stGui.stg_actionPanel[elementName]
		if guiElement then
			guiElement.destroy()
		end
	end
end

