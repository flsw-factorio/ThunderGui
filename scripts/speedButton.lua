--[[ speedFrame actions ]]
local function create_speedFrame(player, playerindex)
	local myFrame = player.gui.left.add({ type="frame", name= "tfrSpeed",
		caption = "Speed: ", style="tms_frame_compact", direction="horizontal" })
	if game.speed <= 10 then
		myFrame.caption = string.format("Speed: %d%%", game.speed*100 )
	else
		myFrame.caption = string.format("Speed: 100%% * %g", game.speed )
	end
	myFrame.style.bottom_padding = 4

	if ( playerindex == 1 ) or ( not global.cfg.safeMultiplayerMode and playerindex > 1 ) then
		--$$ create buttons
		local myFlow = myFrame.add({type= "flow", style= "tms_flow_compact" })
		local myElement = myFlow.add({type= "button", name= "tbnSpdSlow", caption= "||<", style= "tms_buttonAlpha" })
		myElement = myFlow.add({type= "button", name= "tbnSpdDown", caption= "<<", style= "tms_buttonAlpha" })
		myElement = myFlow.add({type= "button", name= "tbnSpdNormal", caption= "normal", style= "tms_buttonAlpha" })
		myElement = myFlow.add({type= "button", name= "tbnSpdUp", caption= ">>", style= "tms_buttonAlpha" })
		myElement = myFlow.add({type= "button", name= "tbnSpdXUp", caption= ">>>", style= "tms_buttonAlpha" })
	end

	global.speedFrame_open[playerindex] = true
end

local function speedButton_changeCaption(player, caption)
	stg_setActionElementCaption(player, "tbnSpeed", caption)
	--[[
	local stGui = player.gui.top.superTopGui
	if stGui and stGui.stg_actionPanel then
		local button = stGui.stg_actionPanel.tbnSpeed
		if button then
			button.caption= caption
		end
	end
	--]]
end

local function speedFrame_openClose(player, playerindex)
	if player.gui.left.tfrSpeed then
		--$$close
		player.gui.left.tfrSpeed.destroy()
		global.speedFrame_open[playerindex] = false
		speedButton_changeCaption(player, "Speed +")
	else
		--$$open
		create_speedFrame(player, playerindex)
		speedButton_changeCaption(player, "Speed -")
	end
end

local function speedFrame_openRenew(player, playerindex)
 	if player.gui.left.tfrSpeed then
     	player.gui.left.tfrSpeed.destroy()
   end
   speedFrame_openClose(player, playerindex)
end

local function tf_close_speedFrame(player, playerindex)
	if player.gui.left.tfrSpeed then
		player.gui.left.tfrSpeed.destroy()
	end
	speedButton_changeCaption(player, "Speed +")
	global.speedFrame_open[playerindex] = false
end

--[[ PUBLIC stuff ]]
function speedButton_updateFrame()
	for playerindex, player in pairs(game.players) do
		--$$ update caption
		if player.gui.left.tfrSpeed and global.speedFrame_open[playerindex] then
			local myFrame = player.gui.left.tfrSpeed
			if game.speed <= 10 then
				myFrame.caption = string.format("Speed: %d%%", game.speed*100 )
			else
				myFrame.caption = string.format("Speed: 100%% * %g", game.speed )
			end
		end
	end
end

function tf_speedButton_remove(player, playerindex)
	stg_destroyActionElement(player, "tbnSpeed")

	if player.gui.left.tfrSpeed then
		player.gui.left.tfrSpeed.destroy()
	end
end

function tf_speedButton_create(player, playerindex)
	local cfg = global.playerCfg[playerindex]
	--$$ button
	if cfg and cfg.showSpeedButton then
		local stGui = player.gui.top.superTopGui
		if stGui and stGui.stg_actionPanel and not stGui.stg_actionPanel.tbnSpeed then
			stGui.stg_actionPanel.add( { type= "button", name= "tbnSpeed", style= "tms_buttonAlpha", caption= "Speed +" } )
		end
	end
	--$$ frame
	if not global.speedFrame_open then
		global.speedFrame_open = {}
		global.speedFrame_open[playerindex] = false
	elseif global.speedFrame_open[playerindex] then
		speedFrame_openRenew(player, playerindex)
	end
end

function tf_speedButton_onguiclick(event)

	if event.element.name == "tbnSpeed" then
		local playerindex = event.player_index
		--local player = game.players[playerindex]
		speedFrame_openClose(game.players[playerindex], playerindex)
	elseif event.element.name == "tbnSpdNormal" then
		game.speed = 1
		speedButton_updateFrame()
	elseif event.element.name == "tbnSpdSlow" then
		game.speed = 0.1
		speedButton_updateFrame()
	elseif event.element.name == "tbnSpdUp"  then
		game.speed = game.speed + 0.1
		speedButton_updateFrame()
	elseif event.element.name == "tbnSpdXUp" then
		game.speed = game.speed + 1
		speedButton_updateFrame()
	elseif event.element.name == "tbnSpdDown" then
		if game.speed >= 0.2 then
			game.speed = game.speed - 0.1
		else
			game.speed = 0.1
		end
		speedButton_updateFrame()
	else
		return false
	end
	return true
end

