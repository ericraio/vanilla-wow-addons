--[[
	Helper functions for the GUI elements of FlexBar
	Last Modified
		04/09/2005	Initial version
		08/21/2005  Small change to FB_ScriptsDelete - fully delete a script
--]]

local util = Utility_Class:New()
local OldToggleGameMenu = ToggleGameMenu
local panels = {
	["FBScriptsFrame"] 		= { "FBMenuScript", "FBScriptsMenu" },
	["FBEventEditorFrame"]	= { "FBIfOpsMenu", "FBEEDDMenu" },
	["FBOptionsFrame"]		= {},
	["FBPerformanceFrame"]	= {},
	["FBAutoItemsFrame"]	= {},
}

-- Hooking GUI escape press to close my menus as I couldn't figure out how
-- to get them to behave like UI dropdowns
function ToggleGameMenu(clicked)
-- 
	local index,panel,menus
	local nomenushowing = true
	local nopanelshowing = true
	for panel,menus in pairs(panels) do
		for index2, menu in ipairs(menus) do
			if getglobal(menu):IsVisible() then 
				getglobal(menu):Hide() 
				nomenushowing = false
			end
		end
	end

	if nomenushowing then
		for panel,menus in pairs(panels) do
			if getglobal(panel):IsVisible() then
				getglobal(panel):Hide()
				nopanelshowing = false
			end
		end
	end
	
	if nopanelshowing and nomenushowing then
		if FBMenu1:IsVisible() then
			FBMenu1:Hide()
		else
			OldToggleGameMenu( clicked )
		end
	end
	
end


-- Register our panels
UIPanelWindows["FBScriptsFrame"] =		{ area = "center",	pushable = 0 };
UIPanelWindows["FBEventEditorFrame"] =		{ area = "center",	pushable = 0 };
UIPanelWindows["FBPerformanceFrame"] =		{ area = "center",	pushable = 0 };
UIPanelWindows["FBOptionsFrame"] =		{ area = "center",	pushable = 0 };
UIPanelWindows["FBAutoItemsFrame"] =		{ area = "center",	pushable = 0 };

function FB_GUI_Main_Menu()
-- display a menu of ui panels
	FB_Menu_Display("FBMenu1",FBGUIPanelsList, FB_GUIPanelsCallBack,
					5, 240, "UIParent", "CENTER", "CENTER", 0, 0)
end

function FB_GUIPanelsCallBack(value,action)
-- display appropriate panel
	if action ~= "click" then return end
	if value == "Event Editor" then
		FB_DisplayEventEditor()
	elseif value == "Script Editor" then
		FB_ShowScripts()
	elseif value == "Global Options" then
		FB_ShowGlobalOptions()
	elseif value == "Auto Items" then
		FB_DisplayAutoItems()
	elseif value == "Performance Options" then
		FB_Show_PerformanceOptions()
	end
end

function FB_Show_Scripts_Dropdown()
-- Display menu of available scripts
	local scripts = {}
	local index, value
	for index, value in pairs(FBScripts) do
		table.insert(scripts,index)
	end
	table.sort(scripts, function(v1,v2) return string.lower(v1) < string.lower(v2) end)
	
	local callback = function(value, action, name, button)
		if action == "click" then
			ScriptNameEditBox:SetText(value)
			getglobal(name):GetParent():Hide()
			if button=="RightButton" then FB_Scripts_Load() end
		end
	end
	
	FB_Menu_Display("FBMenuScript",scripts,callback,FBToggles["dropdown"],300,"ScriptNameEditBox","TOPLEFT","BOTTOMLEFT",-6,0)
	FBScriptsEditBox:ClearFocus()
	ScriptNameEditBox:ClearFocus()
end

function FB_ShowScripts()
	-- Show Scripts frame
	FBScriptsFrame:Show()
	FBScriptsEditBox:SetFocus()
end
function FB_Scripts_Delete()
-- Delete script named in ScriptNameEditBox
	local scriptname = ScriptNameEditBox:GetText()
	if scriptname and scriptname ~= "" then
		FBTextChunks[scriptname] = nil
		FBScripts[scriptname] = nil
		message("Script " .. scriptname .. " deleted")
	else
		message("Script " .. scriptname .. " not found")
	end
	FB_DisplayScripts()
end

function FB_Scripts_Save()
-- Save current text in text editor under name in ScriptNameEditBox
	local scriptname = ScriptNameEditBox:GetText()
	if scriptname and scriptname ~= "" then
		local text = FBScriptsEditBox:GetText()
		FBScripts[scriptname]=FBScriptsEditBox:GetText()
		if string.len(text) > 512 then
			FBTextChunks[scriptname] = {}
			local index
			local len = 511
			for index = 1,string.len(text),512 do
				if index + len > string.len(text) then
					len = string.len(text) - index
				end
				local chunk = string.sub(text,index,index+len)
				table.insert(FBTextChunks[scriptname], chunk)
			end
		else
			FBTextChunks[scriptname] = nil
		end
	else
		message("Please specify a script name")
	end
	FB_DisplayScripts()
end

function FB_Scripts_Load()
-- Load named script into script editor
	local scriptname = ScriptNameEditBox:GetText()
	if scriptname and scriptname ~= "" then
		FBScriptsEditBox:SetText(FBScripts[scriptname])
		FBScriptsEditBox:SetFocus();
	else
		message("Script " .. scriptname .. " not found")
	end
end

function FB_Scripts_List()
-- Show scripts list - OBSOLETE
	if FBScriptsMenu:IsVisible() then
		FBScriptsMenu:Hide()
	else
		FBScriptsMenu:Show()
		FB_DisplayScripts()
	end
end

function FB_Scripts_Import()
-- Search for config from FBScripts and import into straight text format
	local temp = getglobal(ScriptNameEditBox:GetText())
	if not temp then
		message(ScriptNameEditBox .. " not found")
	else
		local index, value
		local text = ""
		for index, value in ipairs(temp) do
			text = text .. value .. "\n"
		end
		FBScriptsEditBox:SetText(text)
	end
end

function FB_Scripts_TextChanged(editbox)
-- Text changed, cursor may have changed, reset scroll frame
	local scrollframe = editbox:GetParent():GetParent()
	local scrollbar = getglobal(scrollframe:GetName().."ScrollBar")
	scrollframe:UpdateScrollChildRect();
	local scrollmin, scrollmax = scrollbar:GetMinMaxValues();
	if ( scrollmax > 0 and (this.max ~= scrollmax) ) then
		this.max = scrollmax;
--		scrollbar:SetValue(scrollmax);
	end
end

function FB_Scripts_OnCursorChanged(editbox)
-- Cursor has moved, scroll frame appropriately
	local scrollframe = editbox:GetParent():GetParent()
	local scrollbar = getglobal(scrollframe:GetName().."ScrollBar")
	local scrollamt = scrollbar:GetValue()/arg4
	local scrollmin, scrollmax = scrollbar:GetMinMaxValues()
	local linenumber = -(arg2/arg4)
	if linenumber-math.floor(linenumber) > .5 then 
		linenumber = math.ceil(linenumber)
	else
		linenumber = math.floor(linenumber)
	end
	
	local page = math.floor(linenumber/17) + 1
	
	scrollbar:SetValue((page-1) * 17 * arg4)
	
	if ((page-1)*17*arg4) > (scrollmax - (arg4/2)) then
		scrollbar:SetValue(scrollmax)
	end
	
	editbox.pagenumber = page
	editbox.linenumber = linenumber
	local status = "(%d | %d)"
	FBScriptsStatusText:SetText(format(status,editbox.linenumber+1,editbox:GetNumLetters()))
	scrollframe:UpdateScrollChildRect();

end

function FB_Scripts_ExportEvents()
	local i, j, k, target, subtarget, event, text
	text = ""
	for i, event in ipairs(FBEvents) do
		text = text..tostring(event["command"]).." on='"..tostring(event["on"]).."'"
		if event["target"] ~= nil then 
			text = text.." target='[ "
			for j, target in pairs(event["target"]) do
			    if type(target) == "string" then text = text.."\""..target.."\" "
				elseif type(target) == "number" then text = text..target.." " end
			end
			text = text.."]'"
		end
		text = text.."\n"		
	end
	FBScriptsEditBox:SetText(text)
end
function FB_Scripts_ExportPositions()
    local btn, state, export
    export = ''
    for btn, state in pairs(FBState) do
		if type(state) == "table" then
			export = export.. string.format("moveabs button=%d xx=%d yy=%d\n", btn, state.xcoord, state.ycoord)
		end
    end
    FBScriptsEditBox:SetText(export)    
end
function FB_Scripts_ExportSetup()
    local i, j, btn, state, formatb, masscommands, attrib, key, val, export
    export = "show button=1-120\ndisable button=1-120 state='off'\n"
    masscommands = {}
    masscommands.hidden = {}
	masscommands.scale = {}
    masscommands.locked = {}
    masscommands.lockedicon = {}
    masscommands.hotkeytext = {}
    masscommands.text2 = {}
    masscommands.text3 = {}
    masscommands.group = {}
    masscommands.justifytext = {}
    masscommands.justifytext2 = {}
    masscommands.justifytext3 = {}
    masscommands.icon = {}
    masscommands.hotkeycolor = {}
    masscommands.text2color = {}
    masscommands.text3color = {}
    masscommands.hidegrid = {}
	masscommands.disabled = {}
    formatb = {}
    formatb.hotkeytext = "text button=[ %s ] text='%s'\n"
    formatb.text2 = "text2 button=[ %s ] text='%s'\n"
    formatb.text3 = "text3 button=[ %s ] text='%s'\n"
    formatb.hidden = "hide button=[ %s ]\n"
	formatb.scale = "scale button=[ %s ] scale=%s\n"
    formatb.fade = "fade button=[ %s ] alpha=%d\n"
    formatb.icon = "shade button=[ %s ] color=[ %s]\n"
    formatb.justifytext = "justifytext button=[ %s ] pos='%s'\n"
    formatb.justifytext2 = "justifytext2 button=[ %s ] pos='%s'\n"
    formatb.justifytext3 = "justifytext3 button=[ %s ] pos='%s'\n"
    formatb.hotkeycolor = "shadetext button=[ %s ] color=[ %s]\n"
    formatb.text2color = "shadetext2 button=[ %s ] color=[ %s]\n"
    formatb.text3color = "shadetext3 button=[ %s ] color=[ %s]\n"
    formatb.hidegrid = "hidegrid button=[ %s ]\n"
    formatb.locked = "lock button=[ %s ]\n"
    formatb.lockedicon = "lockicon button=[ %s ]\n"
    formatb.disabled = "disable button=[ %s ] state='on'\n"
    formatb.remap = "remap button=[ %s ] base=%d\n"
    formatb.group = "group button=[ %s ] anchor=%d\n"
    for btn, state in pairs(FBState) do
		if type(state)=="table" then
			for key, val in pairs(state) do
				if masscommands[key] ~= nil then
					if key == "scale" then val = val * 10 end
					if type(val) == "table" then
						local tempval = ''
						i = 1
						while i <= table.getn(val) do
							tempval = tempval .. val[i]*10 .." "
							i = i + 1
						end
						val = tempval
					end
					if masscommands[key][val] == nil then
						masscommands[key][val] = {}
					end
					table.insert(masscommands[key][val], btn)                
				end
			end
		end
    end
    for attrib, val in pairs(masscommands) do
		--FB_ReportToUser("'"..attrib.."'")
        for state, key in val do
			btn = ''
			--FB_ReportToUser("  ".. tostring(state))
			for i, j in pairs(key) do
				btn = btn..j.." "
			end
			if state ~= nil and state ~= '' then
				export = export..string.format(formatb[attrib], btn, state)
			end
		end
    end
    FBScriptsEditBox:SetText(export)
    
end
function FB_Scripts_ExportActions()
	local i, action, text
	text = ""
	--FB_ReportToUser("Exporting Actions")
	for i, action in pairs(FBSavedProfile[FBProfileName].FlexActions) do
		-- Ensure the target button is cleared
		text = text..string.format("runscript script='PickupAction(%d);PutItemInBackpack();'\nclearflex id=%d\n", i, i)
		--FB_ReportToUser("Action "..i)
		if action.action == "script" then
			text = text..string.format("flexscript id=%d script='%s' texture='%s' name='%s'\n", 
				i, 
				string.gsub(action.script, "'", "\'"), 
				string.gsub(action.texture, "'", "\'"), 
				string.gsub(action.name, "'", "\'"))
		elseif action.action == "macro" then
			text = text..string.format("flexmacro id=%d macro='%s' texture='%s' name='%s'\n", 
				i, 
				string.gsub(action.macro, "'", "\'"), 
				string.gsub(action.texture, "'", "\'"), 
				string.gsub(action.name, "'", "\'"))
		elseif action.action == "pet" then
			text = text..string.format("flexpet id=%d petid=%d\n", i, action.id)
		elseif action.action == "settexture" then
			text = text..string.format("settexture id=%d texture='%s'\n", i, action.texture)
		end
	end
	FBScriptsEditBox:SetText(text)
end
function FB_Set_PerformanceOptions()
-- Set labels and initial values from performance options table
	local index, value

	FBEventToggleInfo["sortlist"] = {}
	for index,value in pairs(FBEventToggleInfo) do
		if index ~= "sortlist" then
			table.insert(FBEventToggleInfo["sortlist"],{ index, value["desc"] })
		end
	end
	table.sort(FBEventToggleInfo["sortlist"],function(v1,v2) return v1[2] < v2[2] end)
	
	local count = 1
	for index,value in pairs(FBEventToggleInfo["sortlist"]) do
		if count > 34 then break end
		local event = FBEventToggleInfo[value[1]]
		if string.sub(event["desc"],1,3) ~= "XXX" then
			local button = getglobal("FBPerfBtn"..count)
			local label = getglobal("FBPerfBtn"..count.."Label")
			label:SetText(string.sub(event["desc"],5))
			button:SetText(FBEventToggles[value[1]])
			if FBEventToggles[value[1]] == "off" and event["timer"] then
				FBTimers[event["timer"]]:Pause()
			elseif FBEventToggles[value[1]] ~= "off" and event["timer"] then
				FBTimers[event["timer"]]:Start()
			end
			button:Show()
			count = count+1
		end
	end
	for index = count,34 do
		local button = getglobal("FBPerfBtn"..index)
		button:Hide()
	end
end

function FB_Show_PerformanceOptions()
-- Show Performance Options frame
	table.sort(FBEventToggles, function(v1,v2) return v1["desc"] < v2["desc"] end)
	FB_Set_PerformanceOptions()
	FBPerformanceFrame:Show()
end

function FB_Performance_Changed(button)
-- set new performance level for event group
	local label = getglobal(button:GetName().."Label")
	local index,value
	FBEventToggleInfo["sortlist"]["lowlist"] = nil
	for index,value in pairs(FBEventToggleInfo["sortlist"]) do
		if string.sub(value[2],5) == label:GetText() then
			if FBEventToggles[value[1]] == "off" then
				FBEventToggles[value[1]] = "low"
			elseif FBEventToggles[value[1]] == "low" then
				FBEventToggles[value[1]] = "high"
			else
				FBEventToggles[value[1]] = "off"
			end
		end
	end
	FB_Set_PerformanceOptions()
end

function FB_LoadOptionsClick(button)
-- Set loadtype
	local label = getglobal(button:GetName() .. "Label")
	if button:GetText() == "safe" then
		button:SetText("std")
	elseif button:GetText() == "std" then 
		button:SetText("fast")
	else
		button:SetText("safe")
	end
	FBToggles["loadtype"] = string.lower(button:GetText())
end

function FB_DropDownOptionsClick(button)
-- Set loadtype
	local label = getglobal(button:GetName() .. "Label")
	if button:GetText() == "5" then
		button:SetText("10")
	elseif button:GetText() == "10" then 
		button:SetText("15")
	else
		button:SetText("5")
	end
	FBToggles["dropdown"] = tonumber(button:GetText())
end

function FB_ShowGlobalOptions()
-- load global options
	FBOptionsFrame:Show()

	if FBToggles["notooltips"] and not FBTooltipsOption:GetChecked() then 
		FBTooltipsOption:SetChecked(1) 
	end
	if FBToggles["verbose"] and not FBVerboseOption:GetChecked() then 
		FBVerboseOption:SetChecked(1) 
	end
	if FBToggles["forceshading"] and not FBShadingOption:GetChecked() then 
		FBShadingOption:SetChecked(1) 
	end
	if FBToggles["autoperf"] and not FBAutoPerformanceOption:GetChecked() then 
		FBAutoPerformanceOption:SetChecked(1) 
	end
	FBLoadOptionsButton:SetText(FBToggles["loadtype"])
	FBDropDownOptionsButton:SetText(FBToggles["dropdown"])
end

function FB_Menu_Display(menuname, valuelist, callback, maxitems, width, parentframe, menuanchor, parentanchor, dx, dy)
-- Show a menu with the attached list of values and using the provided callback.
local menu = getglobal(menuname)
if not menu then return end
if not valuelist and not menu.list then return end
if not callback and not menu.callback then return end
	local index
	
	if valuelist then 
		menu.CurrentItem = 1
		menu.list = util:TableCopy(valuelist)
		local index, value
		menu.list.n = 0
		for index, value in ipairs(menu.list) do
			menu.list.n = menu.list.n + 1
		end
	end
	if maxitems then
		if maxitems < 3 then maxitems = 3 end
		if maxitems > 25 then maxitems = 25 end
		menu.maxitems = maxitems
	end
	
	if callback then menu.callback = callback end

	if maxitems then
		if menu.list.n <= maxitems then maxitems = menu.list.n end
		menu:SetHeight((maxitems * 15) + 20)
		local index
		for index = maxitems+1,25 do
			local item = getglobal(menu:GetName()..index)
			item:Hide()
		end
	end

	getglobal(menu:GetName().."ScrollDown"):Show()
	getglobal(menu:GetName().."ScrollUp"):Show()

	if maxitems and (menu.list.n <= maxitems) then 
		getglobal(menu:GetName().."ScrollDown"):Hide()
		getglobal(menu:GetName().."ScrollUp"):Hide()
	end
	
	if width then
		if width < 100 then width = 100 end
		menu:SetWidth(width)
		local index
		for index = 1, menu.maxitems do
			local item = getglobal(menu:GetName()..index)
			local text = getglobal(item:GetName().."Label")
			item:SetWidth(width - 32)
			text:SetWidth(width - 32)
		end
	end
	
	if parentframe then
		if not menuanchor then menuanchor = "TOPLEFT" end
		if not parentanchor then parentanchor = "TOPLEFT" end
		if not dx then dx = 0 end
		if not dy then dy = 0 end
		menu:ClearAllPoints()
		menu:SetPoint(menuanchor, parentframe, parentanchor, dx, dy)
		menu:SetFrameLevel(getglobal(parentframe):GetFrameLevel() + 50)
		local index
		getglobal(menu:GetName().."ScrollUp"):SetFrameLevel(menu:GetFrameLevel()+5)
		getglobal(menu:GetName().."ScrollDown"):SetFrameLevel(menu:GetFrameLevel()+5)
		getglobal(menu:GetName().."CloseButton"):SetFrameLevel(menu:GetFrameLevel()+5)
		for index = 1, menu.maxitems do
			local item = getglobal(menu:GetName()..index)
			local text = getglobal(item:GetName().."Label")
			item:SetFrameLevel(menu:GetFrameLevel()+5)
		end
	end
	
	if (menu.CurrentItem + (menu.maxitems - 1)) > menu.list.n then menu.CurrentItem = menu.list.n - (menu.maxitems - 1) end
	if menu.CurrentItem < 1 then menu.CurrentItem = 1 end
	
	for index = 0, menu.maxitems - 1 do
		local button = getglobal(menu:GetName()..(index+1))
		local label = getglobal(button:GetName().."Label")
		if menu.list[index+menu.CurrentItem] then
			label:SetText(menu.list[index+menu.CurrentItem])
			button:Show()
		else
			button:Hide()
		end
	end

	menu:Show()
end

-- Functions for the Event Editor

function FB_DisplayEventEditor()
-- Load event list into Event editor
	if FBEvents.n < 11 then FBEventEditorFrame.FirstEvent = 1 end
	if 	FBEventEditorFrame.FirstEvent > 1 and 
		FBEventEditorFrame.FirstEvent + 9 > FBEvents.n then
		FBEventEditorFrame.FirstEvent = FBEvents.n - 9
	end
	if FBEventEditorFrame.FirstEvent < 1 then FBEventEditorFrame.FirstEvent = 1 end
	
	local index
	for index = 0,9 do
		local eventframe = getglobal("FBEventEditorFrame"..index+1)
		local eventnum = getglobal(eventframe:GetName().."Number")
		if FBEvents[index+FBEventEditorFrame.FirstEvent] then
			local event = FBEvents[index+FBEventEditorFrame.FirstEvent]
			eventnum:SetText(tostring(index+FBEventEditorFrame.FirstEvent))
			local eventon = getglobal(eventframe:GetName().."Event")
			eventon:SetText(tostring(event["on"]))
			local eventtarget = getglobal(eventframe:GetName().."Target")
			eventtarget:SetText(string.gsub(tostring(event["targettext"]),"Target=",""))
			local eventcommand = getglobal(eventframe:GetName().."Command")
			eventcommand:SetText(tostring(event["command"]))
			eventframe:Show()
		else
			eventframe:Hide()
		end
	end
	FB_EventEditor_DisplayNewEvent()
	FBEventEditorFrame:Show()
end

function FB_MoveEventDown(eventnumber)
-- move an event down the list
	if eventnumber < FBEvents.n then
		local temp = FBEvents[eventnumber+1]
		FBEvents[eventnumber+1] = FBEvents[eventnumber]
		FBEvents[eventnumber] = temp
	end
	FBSavedProfile[FBProfileName].Events = util:TableCopy(FBEvents)
	FB_CreateQuickDispatch()
	FB_DisplayEventEditor()
end

function FB_MoveEventUp(eventnumber)
-- move an event Up the list
	if eventnumber > 1 then
		local temp = FBEvents[eventnumber-1]
		FBEvents[eventnumber-1] = FBEvents[eventnumber]
		FBEvents[eventnumber] = temp
	end
	FBSavedProfile[FBProfileName].Events = util:TableCopy(FBEvents)
	FB_CreateQuickDispatch()
	FB_DisplayEventEditor()
end

function FB_DeleteEvent(eventnumber)
-- move an event down the list
	table.remove(FBEvents, eventnumber)
	FBSavedProfile[FBProfileName].Events = util:TableCopy(FBEvents)
	FB_CreateQuickDispatch()
	FB_DisplayEventEditor()
	FBEventEditorFrameEventEdit:SetFocus()
end

function FB_InsertEvent(eventnumber)
-- Insert an event in the list
	FBEventEditorFrameModeLabel:SetText("Inserting")
	FBEventEditorFrameEventNumberLabel:SetText(tostring(eventnumber))
	FB_Clear_Fields()
	FB_Hide_Parameters()
	FBEventEditorFrameTargetMenu:Hide()
	FBEventEditorFrameEventEdit:SetFocus()
end

function FB_EditEvent(eventnumber,name)
-- Edit an event in the list
	local list = {"Event","Target","If","In","TName","TToggle","P1","P2","P3","P4","P5","P6","P7","P8","P9","P10"}
	FBEventEditorFrameModeLabel:SetText("Editing")
	FBEventEditorFrameEventNumberLabel:SetText(tostring(eventnumber))
	FB_Clear_Fields()
	FB_Hide_Parameters()
	local commandtext = getglobal(name.."Command"):GetText()
	local target = getglobal(name.."Target"):GetText()
	local event = getglobal(name.."Event"):GetText()
	local firsti,lasti,command = string.find(commandtext,"(%w+) ")
	local msg = string.sub(commandtext,lasti+1)
	local args = FBcmd:GetParameters(msg)
	args["target"] = FBEvents[eventnumber]["target"]
	FBEventEditorFrameEventEdit:SetText("'"..string.lower(event).."'")
	FBEventEditorFrameCommandEdit:SetText(string.lower(command))
	FB_Set_Parameters(command)
	local index,value
	local i,v
	for i,v in ipairs(list) do
		local label = getglobal("FBEventEditorFrame"..v.."Label"):GetText()
		if string.sub(label,-1,-1) == "=" then label = string.sub(label,1,-2) end
		if string.sub(label,1,1) == "[" then label = string.sub(label,2,-2) end
		if args[string.lower(label)] then
			if type(args[string.lower(label)]) == "string" then
				getglobal("FBEventEditorFrame"..v.."Edit"):SetText("'"..args[string.lower(label)].."'")
			elseif type(args[string.lower(label)]) == "number" then
				getglobal("FBEventEditorFrame"..v.."Edit"):SetText(args[string.lower(label)])
			elseif type(args[string.lower(label)]) == "table" then
				local i2, v2
				local text = "["
				for i2,v2 in args[string.lower(label)] do
					if type(v2) == "string" then
						text = text .. "'"..v2.."' "
					else
						text = text .. tostring(v2) .. " "
					end
				end
				text = text .. "]"
				getglobal("FBEventEditorFrame"..v.."Edit"):SetText(text)
			end
				
			getglobal("FBEventEditorFrame"..v.."Label"):Show()
			getglobal("FBEventEditorFrame"..v.."Edit"):Show()
			if getglobal("FBEventEditorFrame"..v.."Menu") then getglobal("FBEventEditorFrame"..v.."Menu"):Show() end
		end
	end
	if IsShiftKeyDown() then
		FB_EventEditor_DisplayNewEvent(true)
	FBEventEditorFrameModeLabel:SetText("Inserting")
	else
		FBEventEditorFrameP1Edit:SetFocus()
		FBEventEditorFrameTargetMenu:Show()
	end
end

local fieldlist = {"Event","Target","If","Command","In","TName","TToggle","P1","P2","P3","P4","P5","P6","P7","P8","P9","P10"}
function FB_EventEditor_MenuDropDown(name)
-- drop menu down for named dropdown button
	if FBEEDDMenu:IsVisible() then 
		FBEEDDMenu:Hide()
		FBIfOpsMenu:Hide()
		return
	end
	
	local label = string.gsub(name,"Menu","Label")
	local editbox = getglobal(string.gsub(name,"Menu","Edit"))
	local labeltext = string.lower(getglobal(label):GetText())
	if string.sub(labeltext,-1,-1) == "=" then labeltext = string.sub(labeltext,1,-2) end
	if string.sub(labeltext,1,1) == "[" then labeltext = string.sub(labeltext,2,-2) end
	FBEventEditorFrame.CurrentEdit = editbox
	FB_Menu_Display("FBEEDDMenu",FBGUIParamValues[labeltext](),
								 FBGUIParamCallbacks[labeltext],
								 FBToggles["dropdown"],200,name,"TOPRIGHT","BOTTOMRIGHT",0,0)
	if labeltext == "if" then
		FB_Menu_Display("FBIfOpsMenu",FBGUIParamValues[labeltext.."ops"](),
									  FBGUIParamCallbacks[labeltext],
									  FBToggles["dropdown"],50,name,"TOPRIGHT","BOTTOMRIGHT",-200,0)
	end
	local index,field
	for index, field in ipairs(fieldlist) do
		getglobal("FBEventEditorFrame"..field.."Edit"):ClearFocus()
	end
end

function FB_EventEditor_NextEditBox(name)
-- find the next edit box to go to.
	local index, value
	local found = false
	for index,value in ipairs(fieldlist) do
		if found and getglobal("FBEventEditorFrame"..value.."Label"):IsVisible() then 
			getglobal("FBEventEditorFrame"..value.."Edit"):SetFocus()
			return
		end
		if string.find(string.sub(name,19),value.."Edit") then
			found = true
			if value == "Command" and FBEventEditorFrameCommandEdit:GetText() then
				FB_Set_Parameters(string.lower(FBEventEditorFrameCommandEdit:GetText()))
			elseif value == "Event" and FBEventEditorFrameEventEdit:GetText() then
				FBEventEditorFrameTargetMenu:Show()
			end
		end
	end
	getglobal("FBEventEditorFrameEventEdit"):SetFocus()
end

function FB_EventEditor_DisplayNewEvent(fromedit)
-- Set up for adding a new event
	if not FBEvents.n then FBEvents.n = 0 end
	local nextevent = FBEvents.n + 1
	FBEventEditorFrameEventNumberLabel:SetText(tostring(nextevent))
	if not fromedit then
		FB_Clear_Fields()
		FB_Hide_Parameters()
		FBEventEditorFrameTargetMenu:Hide()
	end
	FBEventEditorFrameEventEdit:SetFocus()
	FBEventEditorFrameModeLabel:SetText("Adding")
end

function FB_Hide_Parameters()
-- hide the parameter list until it is populated
	local index
	for index = 1,10 do
		getglobal("FBEventEditorFrameP"..index.."Label"):Hide()
		getglobal("FBEventEditorFrameP"..index.."Edit"):Hide()
		getglobal("FBEventEditorFrameP"..index.."Menu"):Hide()
	end
end

function FB_Clear_Fields()
-- clear all fields of values
	local list = {"Event","Target","If","In","TName","TToggle","P1","P2","P3","P4","P5","P6","P7","P8","P9","P10"}
	local index, value
	for index,value in ipairs(list) do
		getglobal("FBEventEditorFrame"..value.."Edit"):SetText("")
	end
	FBEventEditorFrameCommandEdit:SetText("")
end

function FB_Set_Parameters(value)
-- Set up the parameters for the given command
	FB_Hide_Parameters()
	local command,param,index
	for index,param in ipairs(FBGUIParamList[value]) do
		getglobal("FBEventEditorFrameP"..index.."Label"):Show()
		getglobal("FBEventEditorFrameP"..index.."Label"):SetText(param)
		getglobal("FBEventEditorFrameP"..index.."Edit"):Show()
		getglobal("FBEventEditorFrameP"..index.."Edit"):SetText("")
		getglobal("FBEventEditorFrameP"..index.."Menu"):Show()
	end
end

function FB_EventEditor_SaveEvent()
-- Create an event command from the current fields
	local list = {"Event","Target","If","In","TName","TToggle","P1","P2","P3","P4","P5","P6","P7","P8","P9","P10"}
	local ef = FBEventEditorFrame:GetName()
	local command = getglobal(ef.."CommandEdit"):GetText() .. " "
	local value, index
	for index,value in pairs(list) do	
		local label = getglobal(ef..value.."Label"):GetText()
		local edit = getglobal(ef..value.."Edit"):GetText()
		if getglobal(ef..value.."Label"):IsVisible() and label and label ~="" then
			if string.sub(label,1,1) == "[" then label = string.sub(label,2,-2) end
			if string.sub(label,-1,-1) ~= "=" then label = label.."=" end
			command = command .. label ..  edit .. " "
		end
	end
	FBcmd:Dispatch(command)
	local eventnum = tonumber(getglobal(ef.."EventNumberLabel"):GetText())
	local mode = getglobal(ef.."ModeLabel"):GetText()
	if mode == "Editing" then
		FBEvents[eventnum] = FBEvents[FBEvents.n]
		table.remove(FBEvents, FBEvents.n)
	elseif mode == "Inserting" then
		table.insert(FBEvents,eventnum,FBEvents[FBEvents.n])
		table.remove(FBEvents, FBEvents.n)
	end
	FBSavedProfile[FBProfileName].Events = util:TableCopy(FBEvents)
	FB_CreateQuickDispatch()
	getglobal(ef.."ModeLabel"):SetText("Adding")
	FB_EventEditor_DisplayNewEvent()
	FB_DisplayEventEditor()
end

function FB_GetItems()
-- Generate a list of items in ID slots
	local index
	local autoitemlist = {}
	FB_MoneyToggle();	
	for index = 1,120 do
		local count = GetActionCount(index)
		if count and count > 0 then
			FlexBarTooltip:SetAction(index)
			local name = FlexBarTooltipTextLeft1:GetText()
			table.insert(autoitemlist,{index,name,count})
		elseif	FBSavedProfile[FBProfileName].FlexActions[index] and
				FBSavedProfile[FBProfileName].FlexActions[index]["action"] == "autoitem" then
				table.insert(autoitemlist,{index,
											FBSavedProfile[FBProfileName].FlexActions[index]["name"],
											0 })
		end
	end
	FB_MoneyToggle();	
	autoitemlist.n = 0
	for index in ipairs(autoitemlist) do
		autoitemlist.n = index
	end
	return autoitemlist
end

function FB_DisplayAutoItems()
-- display current items in frame
	
	if not FBAutoItemsFrame.FirstItem then FBAutoItemsFrame.FirstItem = 1 end
	local items = FB_GetItems()
	if FBAutoItemsFrame.FirstItem + 4 > items.n then FBAutoItemsFrame.FirstItem = items.n - 4 end
	if FBAutoItemsFrame.FirstItem < 1 then FBAutoItemsFrame.FirstItem = 1 end
	local first = FBAutoItemsFrame.FirstItem
	
	local index
	for index = 1,5 do
		local pos = index+first-1
		if items[pos] then
			local checkbox = getglobal("FBAutoItemsFrame"..index.."On")
			local label = getglobal("FBAutoItemsFrame"..index.."Label")
			local idlabel = getglobal("FBAutoItemsFrame"..index.."IDLabel")
			local countlabel = getglobal("FBAutoItemsFrame"..index.."CountLabel")
			if 	FBSavedProfile[FBProfileName].FlexActions[items[pos][1]] and 
				FBSavedProfile[FBProfileName].FlexActions[items[pos][1]]["action"] == "autoitem" then
				checkbox:SetChecked(1)
			else
				checkbox:SetChecked(0)
			end
			label:SetText(items[pos][2])
			countlabel:SetText(items[pos][3])
			idlabel:SetText(items[pos][1])
			getglobal("FBAutoItemsFrame"..index):Show()
		else
			getglobal("FBAutoItemsFrame"..index):Hide()
		end
	end
	FBAutoItemsFrame:Show()
end

function FB_AutoItemOnClick(number,checkbox,parent)
-- Toggle auto item
	local first = FBAutoItemsFrame.FirstItem or 1
	local pos = number+first-1
	if checkbox:GetChecked() then
		local name = getglobal(parent:GetName().."Label"):GetText()
		local idlabel = getglobal(parent:GetName().."IDLabel"):GetText()
		local id = tonumber(idlabel)
		local countlabel = getglobal(parent:GetName().."CountLabel"):GetText()
		local count = tonumber(countlabel)
		if not FBSavedProfile[FBProfileName].FlexActions[id] then 
			FBSavedProfile[FBProfileName].FlexActions[id] = {}
		end
		FBSavedProfile[FBProfileName].FlexActions[id]["action"] = "autoitem"
		FBSavedProfile[FBProfileName].FlexActions[id]["name"] = name
		FBSavedProfile[FBProfileName].FlexActions[id]["count"] = count
		FBSavedProfile[FBProfileName].FlexActions[id]["texture"] = GetActionTexture(id)
	else
		local idlabel = getglobal(parent:GetName().."IDLabel"):GetText()
		local id = tonumber(idlabel)
		FBSavedProfile[FBProfileName].FlexActions[id] = nil
		local buttonnum
		for buttonnum = 1,FBNumButtons do
			local button = FB_GetWidgets(buttonnum)
			if button:GetID() == id then
				FlexBarButton_Update(button)
				FlexBarButton_UpdateUsable(button)
			end
		end
		FB_DisplayAutoItems()
	end
	local id = tonumber(idlabel)
	local index
	for index = 1,120 do
		local button = FB_GetWidgets(index)
		if button:GetID() == id then
			local profile = FBSavedProfile[FBProfileName]
			local action = profile.FlexActions[id]
			local state = profile[index].State
			if action then 
				state["savedgrid"] = state["hidegrid"] 
				state["hidegrid"] = nil
			else
				state["hidegrid"] = state["savedgrid"]
				state["savedgrid"] = nil
			end
			FBState[index]["savedgrid"] = state["savedgrid"]
			FBState[index]["hidegrid"] = state["hidegrid"]
			FB_ApplyGrid(index)
			FlexBarButton_Update(button)
			FlexBarButton_UpdateUsable(button)
		end
	end

end
