--FlexBar_Localization.lua
--[[
(DJE) File Created 09/02/2005 
(DJE) 09/02/2005 Added basic skeleton 

]]--
--[[
This file is the future home of the localizations code and strings 

As for now I'm just gonna make a list of every string literal 
that may need localization in the .lua files to  aid in
developing a nameing convention for the strings, and to get a better idea 
how big of a job the localization will be.  

I have not looked at the xmls at all

We have to be careful, about strings like "button" only 
public strings need to be localized with things like this not internals
But i'm not sure how seperable these are


Any lines with util:print(), util:echo(), FB_ReportToUser() need altered

_Conditionals.lua
local precedence = {["or<>"] = 1, ["and<>"] = 2, ["not<>"] = 3, ["begin<>"] = 4, ["end<>"] = 5}
	and many comparisons to these values in the file 
	
90ish names of the conditionals

_UtilityClasses.lua
	color names? I'm not sure if the user can see or enter these anyplace
	
	a couple or twenty error message lines like: "Error: " .. index .. " is required")
	These could be tricky because they need to be gramarizable ... i am guessing they will need to be function calls
	ie msg = FBL_UTIL_ERROR_INDEX_REQUIRED(index)  
	in localization.lua function FBL_UTIL_ERRORMSG_INDEX_REQUIRED = 
						  function (index) return "Error: " .. index .. " is required" end

_SlashCommands.lua
	for every command a few strings for example:
	scmd:AddCommand("remap", FB_Command_ReMap, "misc",
		"/FlexBar ReMap Button=<buttons> Base=<id> [Reset='True']")
		-- populate the parameter list for this command
		-- arguments are: command, parameter name, required, strict, types, allowed, default
		scmd:AddParam("remap","button",OPTIONAL,STRICT,{"number","table"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("remap","group" ,OPTIONAL,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("remap","base"  ,REQUIRED,STRICT,{"number"},{lowerbound=1,upperbound=120}, nil)
		scmd:AddParam("remap","toggle",OPTIONAL,STRICT,{"string"},{"true"},nil)
		scmd:AddParam("remap","reset" ,OPTIONAL,NON_STRICT,{"string"},{"true"},nil)
		scmd:AddParam("remap","on"    ,OPTIONAL,NON_STRICT,{"string"},FBEventList,nil)
		scmd:AddParam("remap","target",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("remap","if"    ,OPTIONAL,NON_STRICT,{"string"},FBConditionList,nil)
		scmd:AddParam("remap","in"    ,OPTIONAL,NON_STRICT,{"number"},nil,nil)
		scmd:AddParam("remap","tname" ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("remap","ttoggle",OPTIONAL,STRICT,{"string"},{"true"},nil)
		
		we would need "remap" "/FlexBar ReMap Button=<buttons> Base=<id> [Reset='True']"
			FBL_COMMAND_NAME_REMAP="remap"
			FBL_COMMAND_CHATHELP_REMAP="/FlexBar ReMap Button=<buttons> Base=<id> [Reset='True']"
			most arguments (like "button","toggle" etc) can be reused so it's not too bad
		
		5 catagory help like 
		"For Show/Hide Grid, lock and text, group=<group> may be substituted for Button=<...>"
		
		A bunch more error messages

		
_HelperFunctions.lua
	This file is quite furry, lots of bug creating potential in here
	
	A bunch of these:
	FB_ReportToUser("<< FB_GetCoords: ReSet Button #"..buttonnum.." to ("..x..","..y..") >>"); 
	NOTE: All FB_ReportToUser strings are strictly for debugging and testing purposes and will not be displayed to the
	      average user of the program - probly no-need to localize these strings
	
	also a bunch of util:print(), util:echo() lines 
	
	Stuff like this, which will not work if we localize the commands:
	FBcmd:Dispatch("runmacro macro='"..string.sub(msg,lasti+1).."' in=".. seconds)
	
	There are a lot of other literals which I'm not sure of 
	  the function FB_ItemEnchantEvents() is crawling with them for example
			
_GUIParamInfo.lua
	just about every line in the file ;)

_GUIEventInfo.lua
	just about every line in this one too

_GUI.lua
	This file is full of stuff too
	
_Globals.lua
	lots of FBXxxList variables need to be examined by someone who actualy understands what these are for 
	
_EventHandlers.lua
	Another big one here.
	Lots of commands,events etc are refrenced with literals 
	lots of the usual echos,prints, and FBReportToUsers in here
	
_Flexbar.lua
	There are alot of literals that I am not sure of, because of ignorance about the engine
	the usual echos, prints, and FBReportToUsers 
	60 or so keybinding names

_TextSub.lua
	nearly every line, this is text substitutions after all :)
	Doesn't look too difficult really
	
_config.lua
	low priority in my opinion, but if we locolize commands the configs in here may not work.
	
]]--

--This variable is for debugging in case we want to see what translation block was exicuted
local FBL_LOCALIZATION_MODEUSED="noNE"


function FBLocalize()
--This functions should be called after variables are loaded, and before profile loading
--Sets localization strings to the local WoW is set for 

--ENGLISH
--Set all english strings first, they will be the default if WoW is later distributed in a 
--Language we don't have here, and/or until these are all translated

--
-- FlexBar SlashCommands strings
FB_NOGROUP_ERR = "No such group"
FB_MENUPOPUP_TRIGGER_ERR = "Trigger not part of group %d"
FB_MENUPOPUP_ALIGN_ERR = "Unrecognized alignment: %s"
FB_AUTOARRANGE_RPT = "%d auto-arranged"
FB_GROUP_MEMBERS_ERR = "Error: Groups must have more than one member"
FB_GROUP_ANCHOR_ERR = "Error: Anchor must be a member of the buttons being formed into a group"
FB_UNGROUP_DISBAND_RPT = "Disbanding group %d"
FB_LISTGROUPS_RPT = "The following groups are present:"
FB_LISTGROUPS_BUTTON_RPT = "Buttons in group %d :"
FB_DISPLAY_MISCHELP_ADD = "For showgrid, hidegrid, lock and text, group=<group> may be substituted for Button=<...>"
FB_DISPLAY_APPHELP_ADD = "For all commands, group=<group> may be substituted for Button=<...>"
FB_DISPLAY_GROUPHELP_ADD = "The anchor button MUST be a part of the proposed group"
FB_DISPLAY_MOVEHELP_ADD = "Once grouped, only the anchor may be locked/unlocked\nMoveXXX only takes positive arguments currently"

--OTHER LANGUAGES
	local CurLocal=GetLocale()
	if CurLocal=="deDE" then
		--German
	
	
		--Uncomment the next if any translations exist for this local
		--FBL_LOCALIZATION_MODEUSED="deDE"
	elseif CurLocal=="frFR" then
		--French
		
		
		--Uncomment the next if any translations exist for this local
		--FBL_LOCALIZATION_MODEUSED="deDE"
	
	elseif CurLocal=="koKR" then
		--Korean
		
		
		--Uncomment the next if any translations exist for this local
		--FBL_LOCALIZATION_MODEUSED="deDE"
	else
		--No translation applied
		FBL_LOCALIZATION_MODEUSED="usEN"
	end

end







