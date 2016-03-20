local list_leftpadding = 12
local list_count_per_label = 4-- a value of 4 will give 3
local flow_toppadding = 2
local flow_bottompadding = 6
local mySeperator = ", "

function transform_keys_to_labels(myTable, tableName, guiFrame)
	if myTable and tableName and guiFrame and type(myTable) == "table" then
		local myFlow = guiFrame.add( { type="flow", direction="vertical", style="tms_flow_compact" } )
		myFlow.style.minimalwidth = glob.cfg.thunderBox_minimalWidth
		myFlow.style.toppadding = flow_toppadding
		myFlow.style.bottompadding = flow_bottompadding
		--$$ title of the list to label
		local myElement = myFlow.add( { type= "label", style= "tms_label",
				caption= string.format( "keys in %s table: #%d", tableName, #tableName ) } )
		--myElement.style.minimalwidth = glob.cfg.thunderBox_minimalWidth
		--$$ declare used variables
		local casheTable = {} --$$ casheTable to store keys for fast concatinating
		local indexer = 0
		for key, value in pairs(myTable) do
			--$$ loop through all the keys in given table
			indexer = indexer + 1
			if indexer % list_count_per_label == 0 then --$$ limit the amount of keys per label
				--$$ print what we have in casheTable
				myElement = myFlow.add( { type= "label", style= "tms_label",
						caption= string.format( "%s,", table.concat(casheTable, mySeperator) ) } )
				--myElement.style.minimalwidth = glob.cfg.thunderBox_minimalWidth
				myElement.style.leftpadding = list_leftpadding
				--$$ clean casheTable
				for k in pairs (casheTable) do
					casheTable[k] = nil
				end
				--$$ reset indexer
				indexer = 1
			end
			--$$ store key in casheTable if its not a table
			--if type(key) ~= "table" then
				casheTable[indexer] =  string.format( "%q", key )
			--end
		end
		--$$ print what we have in table
		myElement = myFlow.add( { type= "label", style= "tms_label",
				caption= string.format( "%s", table.concat(casheTable, mySeperator) ) } )
		--myElement.style.minimalwidth = glob.cfg.thunderBox_minimalWidth
		myElement.style.leftpadding = list_leftpadding
	elseif tableName and guiFrame then
		if myTable then
			guiFrame.add( { type= "label", style= "tms_label", 
					caption= string.format( "%q is not a table; it = %s", tableName, tostring(myTable)) } )
		else
			guiFrame.add( { type= "label", style= "tms_label", caption= string.format( "table %s = nil", tableName ) } )
		end
	end
end

function transform_keysvaluepairs_to_labels(myTable, tableName, guiFrame)
	if myTable and tableName and guiFrame and type(myTable) == "table" then
		local myFlow = guiFrame.add( { type="flow", direction="vertical", style="tms_flow_compact" } )
		myFlow.style.minimalwidth = glob.cfg.thunderBox_minimalWidth
		myFlow.style.toppadding = flow_toppadding
		myFlow.style.bottompadding = flow_bottompadding
		--$$ title of the list to label
		local myElement = myFlow.add( { type= "label", style= "tms_label",
				caption= string.format( "key&value pairs in %s table: #%d", tableName, #tableName ) } )
		--myElement.style.minimalwidth = glob.cfg.thunderBox_minimalWidth
		for key, value in pairs(myTable) do
				myElement = myFlow.add( { type= "label", style= "tms_label" } )
				local valueType = type(value)
				if valueType == "string" then
					myElement.caption = string.format( "%s = %q", tostring(key), value )
				elseif valueType == "number" or valueType == "boolean" then
					myElement.caption = string.format( "%s = %s", tostring(key), tostring(value) )
				elseif valueType ~= "userdata" and valueType ~= "table" then
					myElement.caption = string.format( "%s = type %s %q", tostring(key), type(value), tostring(value) )
				else
					myElement.caption = string.format( "%s = type %s", tostring(key), type(value) )
				end
				--myElement.style.minimalwidth = glob.cfg.thunderBox_minimalWidth
				myElement.style.leftpadding = list_leftpadding
		end
	elseif tableName and guiFrame then
		if myTable then
			guiFrame.add( { type= "label", style= "tms_label", 
					caption= string.format( "%q is not a table; it = %s", tableName, tostring(myTable)) } )
		else
			guiFrame.add( { type= "label", style= "tms_label", caption= string.format( "table %q = nil", tableName ) } )
		end
	end
end

function transform_values_to_labels(myTable, tableName, guiFrame)
	if myTable and tableName and guiFrame and type(myTable) == "table" then
		local myFlow = guiFrame.add( { type="flow", direction="vertical", style="tms_flow_compact" } )
		myFlow.style.minimalwidth = glob.cfg.thunderBox_minimalWidth
		myFlow.style.toppadding = flow_toppadding
		myFlow.style.bottompadding = flow_bottompadding
		--$$ title of the list to label
		local myElement = myFlow.add( { type= "label", style= "tms_label",
				caption= string.format( "values in %s table: #%d", tableName, #tableName ) } )
		--myElement.style.minimalwidth = glob.cfg.thunderBox_minimalWidth
		--$$ declare used variables
		local casheTable = {} --$$ casheTable to store keys for fast concatinating
		local indexer = 0
		for key, value in pairs(myTable) do
			--$$ loop through all the keys in given table
			indexer = indexer + 1
			if indexer % list_count_per_label == 0 then --$$ limit the amount of keys per label
				--$$ print what we have in casheTable
				myElement = myFlow.add( { type= "label", style= "tms_label",
						caption= string.format( "%s,", table.concat(casheTable, mySeperator) ) } )
				--myElement.style.minimalwidth = glob.cfg.thunderBox_minimalWidth
				myElement.style.leftpadding = list_leftpadding
				--$$ clean casheTable
				for k in pairs (casheTable) do
					casheTable[k] = nil
				end
				--$$ reset indexer
				indexer = 1
			end
			--$$ store key-value in casheTable if its not a table
			if type(value) == "string" then
				casheTable[indexer] = string.format( "%q", value )
			elseif type(value) ~= "table" and type(value) ~= "userdata" then
				casheTable[indexer] = string.format( "%s %q", type(value), value )
			else
				casheTable[indexer] = type(value)
			end
		end
		--$$ print what we have in table
		myElement = myFlow.add( { type= "label", style= "tms_label",
				caption= string.format( "%s", table.concat(casheTable, mySeperator) ) } )
		--myElement.style.minimalwidth = glob.cfg.thunderBox_minimalWidth
		myElement.style.leftpadding = list_leftpadding
	elseif tableName and guiFrame then
		if myTable then
			guiFrame.add( { type= "label", style= "tms_label", 
					caption= string.format( "%q is not a table; it = %s", tableName, tostring(myTable)) } )
		else
			guiFrame.add( { type= "label", style= "tms_label", caption= string.format( "table %s = nil", tableName ) } )
		end
	end
end

