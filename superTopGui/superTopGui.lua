--[[ PUBLIC init & remove gui superGui ]]function stg_remove(player)
	if player.gui.top.superTopGui then
		local top = player.gui.top
		if global.cfg.developerMode then
			player.print( "ThunderGui: removing superTopGui" )
		end
		top.superTopGui.destroy()
	end
end

function stg_create(player)
	--$$ system-ready state check
	--if not player then return end --$$ if not player_found_in_the_game then return -or- if in_menus then return
	local top = player.gui.top
	if top.superTopGui then return end --$$ if already_created then return
	if global.cfg.developerMode then
		player.print( "ThunderGui: (re-)creating superTopGui" )
	end

	--$$ creating superTopGui
	local superTopGui = top.add( {type= "frame", name= "superTopGui", style= "tms_superGui_frame", direction= "horizontal"} )

	--$$-flow- for descriptions
	superTopGui.add( { type= "flow", name= "stg_infoPanel",
			style= "tms_flow_compact", direction= "horizontal" } )

	--$$-flow- for buttons
	superTopGui.add( { type= "flow", name= "stg_actionPanel",
				caption= "", direction= "horizontal"} )

	--$$-flow- for Xtra buttons etc on the right side
	superTopGui.add( { type= "flow", name= "stg_backPanel",
				caption= "", direction= "horizontal"} )

	--$$ destroy leading frames
	if global.cfg.removeElementsLeftOfSuperGui then
		--local framePosition = 0
		for index, ElementName in pairs(top.children_names) do
			if ElementName == "superTopGui" then
				--framePosition = index
				break;
			end
			--player.print( string.format( "%s = %s", index, ElementName ) )
			local element = top[ElementName]
			if element then
				if global.cfg.developerMode then
					player.print( string.format( "ThunderGui: calling: gui.top.%s.destroy()", ElementName ) )
				end
				element.destroy()
			end
		end
		--player.print( string.format( "%d = %s", framePosition, "superTopGui" ) )
	end
end

