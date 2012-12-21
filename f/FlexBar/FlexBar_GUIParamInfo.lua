-- functions that will return a list of appropriate values for  the parameters - if they exist
--[[
	PROCEDURE FOR ADDING COMMANDS
	1.  Insert the command in the FBGUICommandList
	2.  Insert a list of paramaters for your command in FBGUIParamList - you can use [ and ] to denote optional parameters
	3.  For any parameters that are not already in FBGUIParamValues do the following:
		A.  Insert a function in FBGUIParamValues to return a list of possible values for the parameter.
		B.  Insert a callback function to insert the chosen value into the editbox - see examples.
	NOTE - for any paramters for which it is impossible to iterate potential values, put in "No Values Available" and
	have the callback simply hide.

	08/12/2005  Added text3 field		- Sherkhan
	
--]]
-- List of commands available in On=
	FBGUICommandList = {"show","hide","fade","shade","scale","moveabs","moverel","movetomouse",
						"remap","echo","use","runscript","runmacro","text","text2", "text3","raise","settexture",
						"shadetext","shadetext2","shadetext3"}
-- for each command, a list of parameters unique to them -- [] mean optional
	FBGUIParamList = {
		["show"]	=	{"[button]","[group]","[toggle]"},
		["hide"]	=	{"[button]","[group]","[toggle]"},
		["fade"]	=	{"[button]","[group]","alpha","[toggle]"},
		["shade"]	=	{"[button]","[group]","color","[toggle]","[reset]"},
		["scale"]	=	{"[button]","[group]","scale","[toggle]"},
		["moveabs"]	=	{"button","xx","yy"},
		["moverel"]	=	{"button","trgbtn","dx","dy"},
		["movetomouse"]={"button","dx","dy"},
		["remap"]	=	{"[button]","[group]","base","[toggle]","[reset]"},
		["echo"]	=	{"[button]","[group]","base","[toggle]","[reset]"},
		["use"]		=	{"button"},
		["runscript"]=	{"script"},
		["runmacro"]=	{"macro"},
		["text"]	=	{"[button]","[group]","[text]"},
		["text2"]	=	{"[button]","[group]","[text]"},
		["text3"]	=	{"[button]","[group]","[text]"},
		["raise"]	=	{"event","[source]"},
		["settexture"]=	{"button","[texture]","[toggle]","[reset]"},
		["textshade"]=	{"[button]","[group]","color","[toggle]","[reset]"},
		["textshade2"]=	{"[button]","[group]","color","[toggle]","[reset]"},
		["textshade3"]=	{"[button]","[group]","color","[toggle]","[reset]"},
	}

	FBGUIParamValues = {}
	FBGUIParamValues["scale"] = 
		function()
			return FBCompleteScaleList
		end
	FBGUIParamValues["base"] = 
		function()
			return FBCompleteIDList
		end
	FBGUIParamValues["alpha"] =
		function()
			return FBCompleteAlphaList
		end
	FBGUIParamValues["trgbtn"] =
		function()
			return FBCompleteButtonList
		end
	FBGUIParamValues["button"] =
		function()
			return FBCompleteButtonList
		end
	FBGUIParamValues["script"] = 
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBScripts) do
				table.insert(returnvalue,"'"..i.."'")
			end
			table.sort(returnvalue,function(v1,v2) return string.lower(v1)<string.lower(v2) end)
			return returnvalue
		end
	FBGUIParamValues["macro"] =
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBScripts) do
				table.insert(returnvalue,"'"..i.."'")
			end
			table.sort(returnvalue,function(v1,v2) return string.lower(v1)<string.lower(v2) end)
			return returnvalue
		end
	FBGUIParamValues["texture"] = 
		function() 
			return FBCompleteTextureList
		end
	FBGUIParamValues["group"] = 
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBGroupData) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIParamValues["text"] = 
		function() 
			return FBCompleteTextVarList
		end
	FBGUIParamValues["color"] = 
		function() 
			return FBColorList
		end
	FBGUIParamValues["on"] =
		function()
			local returnvalue = {}
			local i,v
			for i,v in pairs(FBEventGroups) do
				table.insert(returnvalue,"'"..i.."'")
			end
			table.sort(returnvalue,function(v1,v2) return string.lower(v1)<string.lower(v2) end)
			return returnvalue
		end
	FBGUIParamValues["if"] =
		function()
			local returnvalue = {}
			local i,v
			for i,v in pairs(FBConditions) do
				table.insert(returnvalue,i)
			end
			table.sort(returnvalue,function(v1,v2) return string.lower(v1)<string.lower(v2) end)
			return returnvalue
		end
	FBGUIParamValues["ifops"] = 
		function()
			return FBIfOpsList
		end
	FBGUIParamValues["target"] =
		function()
			return FBGUIEventTargets[string.sub(string.lower(FBEventEditorFrameEventEdit:GetText()),2,-2)]()
		end
	FBGUIParamValues["command"] = function() return FBGUICommandList end
	FBGUIParamValues["reset"] = function() return FBTrueList end
	FBGUIParamValues["toggle"] = function() return FBTrueList end
	FBGUIParamValues["ttoggle"] = function() return FBTrueList end
	FBGUIParamValues["event"] = function() return FBNoValuesList end
	FBGUIParamValues["source"] = function() return FBNoValuesList end
	FBGUIParamValues["xx"] = function() return FBNoValuesList end
	FBGUIParamValues["yy"] = function() return FBNoValuesList end
	FBGUIParamValues["dx"] = function() return FBNoValuesList end
	FBGUIParamValues["dy"] = function() return FBNoValuesList end

	
	-- Call backs for each parameter menu
	FBGUIParamCallbacks = {}
	FBGUIParamCallbacks["if"]	=	
		function(value,action,name)
			if action ~= "click" then return end
			local text = FBEventEditorFrame.CurrentEdit:GetText()
			if not FB_InTable(value,{"and","not","or","(",")"}) then value = value.."<>" end
			if string.sub(text,1,1) == "'" then text = string.sub(text,2) end
			if string.sub(text,1,1) == " " then text = string.sub(text,2) end
			if string.sub(text,-1,-1) == "'" then text = string.sub(text,1,-2) end
			text = "'"..text.." "..value.."'"
			FBEventEditorFrame.CurrentEdit:SetText(text)
			FBEventEditorFrame.CurrentEdit:SetFocus()
		end
	FBGUIParamCallbacks["target"]	=	
		function(value,action,name)
			if action ~= "click" then return end
			if value == "No Target Needed" then return end
			local text = FBEventEditorFrame.CurrentEdit:GetText()
			if string.sub(text,1,1) == "[" then
				text = string.sub(text,2,-2)
			end
			text = "["..text..value.." ".."]"
			FBEventEditorFrame.CurrentEdit:SetText(text)
			FBEventEditorFrame.CurrentEdit:SetFocus()
		end
	FBGUIParamCallbacks["alpha"]	=	
		function(value,action,name)
			if action ~= "click" then return end
			FBEventEditorFrame.CurrentEdit:SetText(value)
			getglobal(name):GetParent():Hide()
			FBEventEditorFrame.CurrentEdit:SetFocus()
		end
	FBGUIParamCallbacks["base"]	=	
		function(value,action,name)
			if action ~= "click" then return end
			FBEventEditorFrame.CurrentEdit:SetText(value)
			getglobal(name):GetParent():Hide()
			FBEventEditorFrame.CurrentEdit:SetFocus()
		end
	FBGUIParamCallbacks["button"]	=	
		function(value,action,name)
			if action ~= "click" then return end
			local text = FBEventEditorFrame.CurrentEdit:GetText()
			if string.sub(text,1,1) == "[" then
				text = string.sub(text,2,-2)
			end
			text = "["..text..value.." ".."]"
			FBEventEditorFrame.CurrentEdit:SetText(text)
			FBEventEditorFrame.CurrentEdit:SetFocus()
		end
	FBGUIParamCallbacks["color"]	=	
		function(value,action,name)
			if action ~= "click" then return end
			local firsti = string.find(value," %- ")
			value = string.sub(value,1,firsti - 1)
			FBEventEditorFrame.CurrentEdit:SetText(value)
			getglobal(name):GetParent():Hide()
			FBEventEditorFrame.CurrentEdit:SetFocus()
		end
	FBGUIParamCallbacks["command"]	=	
		function(value,action,name)
			if action ~= "click" then return end
			FBEventEditorFrame.CurrentEdit:SetText(value)
			getglobal(name):GetParent():Hide()
			FB_Set_Parameters(value)
			FBEventEditorFrame.CurrentEdit:SetFocus()
		end
	FBGUIParamCallbacks["dx"]	=	
		function(value,action,name)
			if action ~= "click" then return end
			getglobal(name):GetParent():Hide()
			FBEventEditorFrame.CurrentEdit:SetFocus()
		end
	FBGUIParamCallbacks["dy"]	=	
		function(value,action,name)
			if action ~= "click" then return end
			getglobal(name):GetParent():Hide()
			FBEventEditorFrame.CurrentEdit:SetFocus()
		end
	FBGUIParamCallbacks["event"]	=	
		function(value,action,name)
			if action ~= "click" then return end
			FBEventEditorFrame.CurrentEdit:SetText(value)
			getglobal(name):GetParent():Hide()
			FBEventEditorFrame.CurrentEdit:SetFocus()
		end
	FBGUIParamCallbacks["on"]	=	
		function(value,action,name)
			if action ~= "click" then return end
			FBEventEditorFrame.CurrentEdit:SetText(value)
			getglobal(name):GetParent():Hide()
			FBEventEditorFrameTargetMenu:Show()
			FBEventEditorFrame.CurrentEdit:SetFocus()
		end
	FBGUIParamCallbacks["group"]	=	
		function(value,action,name)
			if action ~= "click" then return end
			FBEventEditorFrame.CurrentEdit:SetText(value)
			getglobal(name):GetParent():Hide()
			FBEventEditorFrame.CurrentEdit:SetFocus()
		end
	FBGUIParamCallbacks["macro"]	=	
		function(value,action,name)
			if action ~= "click" then return end
			FBEventEditorFrame.CurrentEdit:SetText(value)
			getglobal(name):GetParent():Hide()
			FBEventEditorFrame.CurrentEdit:SetFocus()
		end
	FBGUIParamCallbacks["reset"]	=	
		function(value,action,name)
			if action ~= "click" then return end
			FBEventEditorFrame.CurrentEdit:SetText(value)
			getglobal(name):GetParent():Hide()
			FBEventEditorFrame.CurrentEdit:SetFocus()
		end
	FBGUIParamCallbacks["scale"]	=	
		function(value,action,name)
			if action ~= "click" then return end
			FBEventEditorFrame.CurrentEdit:SetText(value)
			getglobal(name):GetParent():Hide()
			FBEventEditorFrame.CurrentEdit:SetFocus()
		end
	FBGUIParamCallbacks["script"]	=	
		function(value,action,name)
			if action ~= "click" then return end
			FBEventEditorFrame.CurrentEdit:SetText(value)
			getglobal(name):GetParent():Hide()
			FBEventEditorFrame.CurrentEdit:SetFocus()
		end
	FBGUIParamCallbacks["source"]	=	
		function(value,action,name)
			if action ~= "click" then return end
			getglobal(name):GetParent():Hide()
			FBEventEditorFrame.CurrentEdit:SetFocus()
		end
	FBGUIParamCallbacks["text"]	=	
		function(value,action,name)
			if action ~= "click" then return end
			FBEventEditorFrame.CurrentEdit:SetText(value)
			getglobal(name):GetParent():Hide()
			FBEventEditorFrame.CurrentEdit:SetFocus()
		end
	FBGUIParamCallbacks["texture"]	=	
		function(value,action,name)
			if action ~= "click" then return end
			FBEventEditorFrame.CurrentEdit:SetText(value)
			getglobal(name):GetParent():Hide()
			FBEventEditorFrame.CurrentEdit:SetFocus()
		end
	FBGUIParamCallbacks["toggle"]	=	
		function(value,action,name)
			if action ~= "click" then return end
			FBEventEditorFrame.CurrentEdit:SetText(value)
			getglobal(name):GetParent():Hide()
			FBEventEditorFrame.CurrentEdit:SetFocus()
		end
	FBGUIParamCallbacks["ttoggle"]	=	
		function(value,action,name)
			if action ~= "click" then return end
			FBEventEditorFrame.CurrentEdit:SetText(value)
			getglobal(name):GetParent():Hide()
			util:Print(name)
			FBEventEditorFrame.CurrentEdit:SetFocus()
		end
	FBGUIParamCallbacks["trgbtn"]	=	
		function(value,action,name)
			if action ~= "click" then return end
			local text = FBEventEditorFrame.CurrentEdit:GetText()
			if string.sub(text,1,1) == "[" then
				text = string.sub(text,2,-2)
			end
			text = "["..text..value.." ".."]"
			FBEventEditorFrame.CurrentEdit:SetText(text)
			FBEventEditorFrame.CurrentEdit:SetFocus()
		end
	FBGUIParamCallbacks["xx"]	=	
		function(value,action,name)
			if action ~= "click" then return end
			getglobal(name):GetParent():Hide()
			FBEventEditorFrame.CurrentEdit:SetFocus()
		end
	FBGUIParamCallbacks["yy"]	=	
		function(value,action,name)
			if action ~= "click" then return end
			getglobal(name):GetParent():Hide()
			FBEventEditorFrame.CurrentEdit:SetFocus()
		end
