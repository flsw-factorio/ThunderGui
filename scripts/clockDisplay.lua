--[[ PUBLIC functions ]]
function tf_clockDisplay_remove(player, playerindex)
	local stGui = player.gui.top.superTopGui
	if stGui and stGui.stg_infoPanel and stGui.stg_infoPanel.clockDisp then
		player.gui.top.superTopGui.stg_infoPanel.clockDisp.destroy()
	end
end

function tf_clockDisplay_create(player, playerindex)
	local cfg = global.playerCfg[playerindex]
 	if not cfg or not cfg.showClock or not player.gui.top.superTopGui then return end
	local myFlow = player.gui.top.superTopGui.stg_infoPanel.add({type= "flow", name= "clockDisp", style= "tms_flow_compact", direction= "vertical" })

	if not myFlow.tdlTotal then
		local myElement = myFlow.add( { type= "label", name= "tdlTotal", style= "tms_label" } )
	end

	--[[if not myFlow.tdlGame then
		myElement = myFlow.add( { type= "label", name= "tdlGame", style= "tms_label" } )
		--.style.font = "default-frame" --$$ big font
	end--]]
end

function tf_clockDisplay_update(player, playerindex)
 	if not player.gui.top.superTopGui or not player.gui.top.superTopGui.stg_infoPanel.clockDisp then return end
	local myFlow = player.gui.top.superTopGui.stg_infoPanel.clockDisp
	local time_normal = game.daytime*24
	--$$ flip time around, 0.5 is midnight ugh
	if time_normal > 12 then
		time_normal = time_normal - 12
	else
		time_normal = time_normal + 12
	end

	--$$ total game time caption
	local run_time_s = math.floor(game.tick/60)
	local run_time_minutes = math.floor(run_time_s/60)
	local run_time_hours = math.floor(run_time_minutes/60)
	local run_time_days = math.floor(run_time_hours/24)
	run_time_hours = run_time_hours % 24
	if run_time_hours > 0 then
		local days = ""
		if run_time_days > 0 then
			if run_time_days > 1 then
				days = string.format("%d days,", run_time_days)
			else
				days = "1 day,"
			end
		end

		myFlow.tdlTotal.caption = string.format(
				"total time: %s %dh %dm",
				days,
				run_time_hours,
				run_time_minutes % 60 )
	else
		myFlow.tdlTotal.caption = string.format(
				"total time: %dm %ds",
				run_time_minutes % 60,
				run_time_s % 60 )
	end

	--[[$$ virtual game time/clock caption
	local raw_mins = math.floor((time_normal % 1)*60)
		myFlow.tdlGame.caption = string.format(
				"game time %2d:%2d",
				math.floor(time_normal),
				raw_mins - raw_mins % global.cfg.clock_gt_minuteRounding_Value )
	--]]
end

