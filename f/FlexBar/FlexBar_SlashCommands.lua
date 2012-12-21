--[[
	Functions to implement slash commands for FlexBar
	Last Modified
		12/26/2004	Initial version
		08/12/2005  Changed calls for FB_ReformGroups to either FB_ReformGroup or FB_DisbandAllGroups - Sherkhan
		08/12/2005  Added Text3, ShadeText3, JustifyText3 Fields	- Sherkhan
--]]

local util = Utility_Class:New()
local nextcommand = 0;
local currentconfig = nil
local REQUIRED = true
local STRICT = true
local OPTIONAL = false
local NON_STRICT = false
local NO_DEFAULT = nil;

function FB_Command_AddCommands(scmd)
-- Populate the command object, scmd, with the commands we want available
-- args are command, function, group, usage
	scmd:AddCommand("info", FB_Command_ToggleButtonInfo, "misc",
		"/Flexbar Info")

	scmd:AddCommand("scripts", FB_Command_Scripts, "misc",
		"/Flexbar Scripts")

	scmd:AddCommand("events", FB_DisplayEventEditor, "misc",
		"/Flexbar Events")

	scmd:AddCommand("perf", FB_Show_PerformanceOptions, "misc",
		"/Flexbar Perf")

	scmd:AddCommand("autoitems", FB_DisplayAutoItems, "misc",
		"/Flexbar AutoItems")

	scmd:AddCommand("options", FB_ShowGlobalOptions, "misc",
		"/Flexbar Options")

	scmd:AddCommand("safeload", FB_Command_SafeLoad, "misc",
		"/Flexbar SafeLoad State=<'on' | 'off'>")
		scmd:AddParam("safeload","state",REQUIRED,STRICT,{"string"},{"on","On","off","Off"},NO_DEFAULT)
		
	scmd:AddCommand("loadprofile", FB_Command_LoadProfile, "misc",
		"/Flexbar LoadProfile Profile='profile'")
		scmd:AddParam("loadprofile","profile",REQUIRED,NON_STRICT,{"string"},nil,NO_DEFAULT)
		
	scmd:AddCommand("deleteprofile", FB_Command_DeleteProfile, "misc",
		"/Flexbar DeleteProfile Profile='profile' confirm='yes'")
		scmd:AddParam("deleteprofile","profile",REQUIRED,NON_STRICT,{"string"},nil,NO_DEFAULT)
		scmd:AddParam("deleteprofile","confirm",REQUIRED,STRICT,{"string"},{"yes","Yes"}, nil)
		
	scmd:AddCommand("saveprofile", FB_Command_SaveProfile, "misc",
		"/Flexbar SaveProfile Profile='profile'")
		scmd:AddParam("saveprofile","profile",REQUIRED,NON_STRICT,{"string"},nil,NO_DEFAULT)
		
	scmd:AddCommand("listprofiles", FB_Command_ListProfiles, "misc",
		"/FlexBar ListProfiles")
		
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
		
	scmd:AddCommand("echo", FB_Command_Echo, "misc",
		"/FlexBar Echo Button=<buttons> Base=<id> [Reset='True']")
		-- populate the parameter list for this command
		-- arguments are: command, parameter name, required, strict, types, allowed, default
		scmd:AddParam("echo","button",OPTIONAL,STRICT,{"number","table"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("echo","group" ,OPTIONAL,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("echo","base"  ,REQUIRED,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("echo","toggle",OPTIONAL,STRICT,{"string"},{"true"},nil)
		scmd:AddParam("echo","reset" ,OPTIONAL,NON_STRICT,{"string"},{"true"},nil)
		scmd:AddParam("echo","on"    ,OPTIONAL,NON_STRICT,{"string"},FBEventList,nil)
		scmd:AddParam("echo","target",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("echo","if"    ,OPTIONAL,NON_STRICT,{"string"},FBConditionList,nil)
		scmd:AddParam("echo","in"    ,OPTIONAL,NON_STRICT,{"number"},nil,nil)
		scmd:AddParam("echo","tname" ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("echo","ttoggle",OPTIONAL,STRICT,{"string"},{"true"},nil)
		
	scmd:AddCommand("advanced", FB_Command_Advanced, "misc",
		"/FlexBar Advanced Button=<buttons> state=<'on' | 'off'>")
		-- populate the parameter list for this command
		-- arguments are: command, parameter name, required, strict, types, allowed, default
		scmd:AddParam("advanced","button",OPTIONAL,STRICT,{"number","table"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("advanced","group" ,OPTIONAL,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("advanced","state" ,REQUIRED,NON_STRICT,{"string"},{"on","On","off","Off"}, nil)

	scmd:AddCommand("use", FB_Command_Use, "misc",
		"/FlexBar Use Button=<buttons>")
		-- populate the parameter list for this command
		-- arguments are: command, parameter name, required, strict, types, allowed, default
		scmd:AddParam("use","button",REQUIRED,STRICT,{"number","table"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("use","on"    ,OPTIONAL,NON_STRICT,{"string"},FBEventList,nil)
		scmd:AddParam("use","target",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("use","if"    ,OPTIONAL,NON_STRICT,{"string"},FBConditionList,nil)
		scmd:AddParam("use","in"    ,OPTIONAL,NON_STRICT,{"number"},nil,nil)
		scmd:AddParam("use","tname" ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("use","ttoggle",OPTIONAL,STRICT,{"string"},{"true"},nil)

	scmd:AddCommand("runscript", FB_Command_RunScript, "misc",
		"/FlexBar RunScript Script='scriptname'")
		-- populate the parameter list for this command
		-- arguments are: command, parameter name, required, strict, types, allowed, default
		scmd:AddParam("runscript","script",REQUIRED,NON_STRICT,{"string"},nil, nil)
		scmd:AddParam("runscript","on"    ,OPTIONAL,NON_STRICT,{"string"},FBEventList,nil)
		scmd:AddParam("runscript","target",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("runscript","if"    ,OPTIONAL,NON_STRICT,{"string"},FBConditionList,nil)
		scmd:AddParam("runscript","in"    ,OPTIONAL,NON_STRICT,{"number"},nil,nil)
		scmd:AddParam("runscript","tname" ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("runscript","ttoggle",OPTIONAL,STRICT,{"string"},{"true"},nil)
		
	scmd:AddCommand("runmacro", FB_Command_RunMacro, "misc",
		"/FlexBar RunMacro Macro='macroname'")
		-- populate the parameter list for this command
		-- arguments are: command, parameter name, required, strict, types, allowed, default
		scmd:AddParam("runmacro","macro",REQUIRED,NON_STRICT,{"string","table"},nil, nil)
		scmd:AddParam("runmacro","on"    ,OPTIONAL,NON_STRICT,{"string"},FBEventList,nil)
		scmd:AddParam("runmacro","target",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("runmacro","if"    ,OPTIONAL,NON_STRICT,{"string"},FBConditionList,nil)
		scmd:AddParam("runmacro","in"    ,OPTIONAL,NON_STRICT,{"number"},nil,nil)
		scmd:AddParam("runmacro","tname" ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("runmacro","ttoggle",OPTIONAL,STRICT,{"string"},{"true"},nil)
		
	scmd:AddCommand("resetall", FB_Command_ResetAll, "misc",
		"/FlexBar ResetAll Confirm='yes'")
		-- populate the parameter list for this command
		-- arguments are: command, parameter name, required, strict, types, allowed, default
		scmd:AddParam("resetall","confirm",REQUIRED,STRICT,{"string"},{"yes","Yes"}, nil)

	scmd:AddCommand("restore", FB_Command_Restore, "misc",
		"/FlexBar Restore Confirm='yes'")
		-- populate the parameter list for this command
		-- arguments are: command, parameter name, required, strict, types, allowed, default
		scmd:AddParam("restore","confirm",REQUIRED,STRICT,{"string"},{"yes","Yes"}, nil)

	scmd:AddCommand("loadconfig", FB_Command_LoadConfig, "misc",
		"/FlexBar LoadConfig Config='ConfigName'")
		-- populate the parameter list for this command
		-- arguments are: command, parameter name, required, strict, types, allowed, default
		scmd:AddParam("loadconfig","config",REQUIRED,NON_STRICT,{"string"},nil, nil)

	scmd:AddCommand("hidegrid", FB_Command_HideGrid, "misc",
		"/FlexBar HideGrid Button=<buttons>")
		scmd:AddParam("hidegrid","button",OPTIONAL,STRICT,{"number","table"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("hidegrid","group" ,OPTIONAL,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("hidegrid","toggle",OPTIONAL,STRICT,{"string"},{"true"},nil)

	scmd:AddCommand("showgrid", FB_Command_ShowGrid, "misc",
		"/FlexBar ShowGrid Button=<buttons>")
		scmd:AddParam("showgrid","button",OPTIONAL,STRICT,{"number","table"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("showgrid","group" ,OPTIONAL,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("showgrid","toggle",OPTIONAL,STRICT,{"string"},{"true"},nil)

	scmd:AddCommand("lockicon", FB_Command_LockIcon, "misc",
		"/FlexBar LockIcon Button=<buttons> [Off='true']")
		scmd:AddParam("lockicon","button",OPTIONAL,STRICT,{"number","table"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("lockicon","group" ,OPTIONAL,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("lockicon","off"   ,OPTIONAL,STRICT,{"string"},{"true", "True"},nil)

	scmd:AddCommand("text", FB_Command_Text, "misc",
		"/FlexBar Text Button=<buttons> Text=<text>")
		scmd:AddParam("text","button",OPTIONAL,STRICT,{"number","table"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("text","group" ,OPTIONAL,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("text","text"  ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("text","on"    ,OPTIONAL,NON_STRICT,{"string"},FBEventList,nil)
		scmd:AddParam("text","target",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("text","if"    ,OPTIONAL,NON_STRICT,{"string"},FBConditionList,nil)
		scmd:AddParam("text","in"    ,OPTIONAL,NON_STRICT,{"number"},nil,nil)
		scmd:AddParam("text","tname" ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("text","ttoggle",OPTIONAL,STRICT,{"string"},{"true"},nil)

	scmd:AddCommand("text2", FB_Command_Text2, "misc",
		"/FlexBar Text2 Button=<buttons> Text=<text>")
		scmd:AddParam("text2","button",OPTIONAL,STRICT,{"number","table"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("text2","group" ,OPTIONAL,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("text2","text"  ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("text2","on"    ,OPTIONAL,NON_STRICT,{"string"},FBEventList,nil)
		scmd:AddParam("text2","target",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("text2","if"    ,OPTIONAL,NON_STRICT,{"string"},FBConditionList,nil)
		scmd:AddParam("text2","in"    ,OPTIONAL,NON_STRICT,{"number"},nil,nil)
		scmd:AddParam("text2","tname" ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("text2","ttoggle",OPTIONAL,STRICT,{"string"},{"true"},nil)

	scmd:AddCommand("text3", FB_Command_Text3, "misc",
		"/FlexBar Text3 Button=<buttons> Text=<text>")
		scmd:AddParam("text3","button",OPTIONAL,STRICT,{"number","table"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("text3","group" ,OPTIONAL,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("text3","text"  ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("text3","on"    ,OPTIONAL,NON_STRICT,{"string"},FBEventList,nil)
		scmd:AddParam("text3","target",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("text3","if"    ,OPTIONAL,NON_STRICT,{"string"},FBConditionList,nil)
		scmd:AddParam("text3","in"    ,OPTIONAL,NON_STRICT,{"number"},nil,nil)
		scmd:AddParam("text3","tname" ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("text3","ttoggle",OPTIONAL,STRICT,{"string"},{"true"},nil)

	scmd:AddCommand("justifytext", FB_Command_JustifyText, "misc",
		"/FlexBar JustifyText Button=<buttons> Pos=<position>")
		scmd:AddParam("justifytext","button",OPTIONAL,STRICT,{"number","table"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("justifytext","group" ,OPTIONAL,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("justifytext","pos"  ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("justifytext","on"    ,OPTIONAL,NON_STRICT,{"string"},FBEventList,nil)
		scmd:AddParam("justifytext","target",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("justifytext","if"    ,OPTIONAL,NON_STRICT,{"string"},FBConditionList,nil)
		scmd:AddParam("justifytext","in"    ,OPTIONAL,NON_STRICT,{"number"},nil,nil)
		scmd:AddParam("justifytext","tname" ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("justifytext","ttoggle",OPTIONAL,STRICT,{"string"},{"true"},nil)

	scmd:AddCommand("justifytext2", FB_Command_JustifyText2, "misc",
		"/FlexBar Justifytext2 Button=<buttons> Pos=<position>")
		scmd:AddParam("justifytext2","button",OPTIONAL,STRICT,{"number","table"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("justifytext2","group" ,OPTIONAL,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("justifytext2","pos"  ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("justifytext2","on"    ,OPTIONAL,NON_STRICT,{"string"},FBEventList,nil)
		scmd:AddParam("justifytext2","target",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("justifytext2","if"    ,OPTIONAL,NON_STRICT,{"string"},FBConditionList,nil)
		scmd:AddParam("justifytext2","in"    ,OPTIONAL,NON_STRICT,{"number"},nil,nil)
		scmd:AddParam("justifytext2","tname" ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("justifytext2","ttoggle",OPTIONAL,STRICT,{"string"},{"true"},nil)

	scmd:AddCommand("justifytext3", FB_Command_JustifyText3, "misc",
		"/FlexBar Justifytext3 Button=<buttons> Pos=<position>")
		scmd:AddParam("justifytext3","button",OPTIONAL,STRICT,{"number","table"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("justifytext3","group" ,OPTIONAL,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("justifytext3","pos"  ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("justifytext3","on"    ,OPTIONAL,NON_STRICT,{"string"},FBEventList,nil)
		scmd:AddParam("justifytext3","target",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("justifytext3","if"    ,OPTIONAL,NON_STRICT,{"string"},FBConditionList,nil)
		scmd:AddParam("justifytext3","in"    ,OPTIONAL,NON_STRICT,{"number"},nil,nil)
		scmd:AddParam("justifytext3","tname" ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("justifytext3","ttoggle",OPTIONAL,STRICT,{"string"},{"true"},nil)

	scmd:AddCommand("verbose", FB_Command_Verbose, "misc",
		"/FlexBar Verbose State=<'on' | 'off'>")
		scmd:AddParam("verbose","state",REQUIRED,STRICT,{"string"},{"on","On","Off","off"},"on")
		
	scmd:AddCommand("tooltip", FB_Command_Tooltip, "misc",
		"/FlexBar Tooltip State=<'on' | 'off'>")
		scmd:AddParam("tooltip","state",REQUIRED,STRICT,{"string"},{"on","On","Off","off"},"on")
		
	scmd:AddCommand("raise", FB_Command_Raise, "misc",
		"/FlexBar Raise Event=<event> Source=<source> In=<seconds>")
		-- populate the parameter list for this command
		-- arguments are: command, parameter name, required, strict, types, allowed, default
		scmd:AddParam("raise","event" ,REQUIRED,NON_STRICT,{"string"},NO_BOUNDS,NO_DEFAULT)
		scmd:AddParam("raise","source",OPTIONAL,NON_STRICT,NO_TYPES,NO_BOUNDS,NO_DEFAULT)
		scmd:AddParam("raise","on"    ,OPTIONAL,NON_STRICT,{"string"},FBEventList,nil)
		scmd:AddParam("raise","target",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("raise","if"    ,OPTIONAL,NON_STRICT,{"string"},FBConditionList,nil)
		scmd:AddParam("raise","in"    ,OPTIONAL,STRICT,{"number"},{lowerbound=0},0)
		scmd:AddParam("raise","name"  ,REQUIRED,NON_STRICT,{"string"},nil,NO_DEFAULT)
		scmd:AddParam("raise","toggle",OPTIONAL,STRICT,{"string"},{"true"},nil)
		scmd:AddParam("raise","tname" ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("raise","ttoggle",OPTIONAL,STRICT,{"string"},{"true"},nil)
		
	scmd:AddCommand("flexscript", FB_Command_FlexScript, "appearance",
		"/FlexBar FlexScript ID=<ID> Texture='texture' Script='script' Name='Name' [Reset='true'] [Toggle='true']")
		-- populate the parameter list for this command
		-- arguments are: command, parameter name, required, strict, types, allowed, default
		scmd:AddParam("flexscript","id"  ,REQUIRED,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("flexscript","texture" ,REQUIRED,STRICT,{"string"},nil, "")
		scmd:AddParam("flexscript","toggle"  ,OPTIONAL,STRICT,{"string"},{"true"},nil)
		scmd:AddParam("flexscript","reset"   ,OPTIONAL,NON_STRICT,{"string"},{"true"},nil)
		scmd:AddParam("flexscript","name"  ,REQUIRED,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("flexscript","script",REQUIRED,NON_STRICT,{"string"},nil, nil)
		
	scmd:AddCommand("flexmacro", FB_Command_FlexMacro, "appearance",
		"/FlexBar FlexMacro ID=<ID> Texture='texture' Macro='macro' Name='Name' [Reset='true'] [Toggle='true']")
		-- populate the parameter list for this command
		-- arguments are: command, parameter name, required, strict, types, allowed, default
		scmd:AddParam("flexmacro","id"  ,REQUIRED,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("flexmacro","texture" ,REQUIRED,STRICT,{"string"},nil, "")
		scmd:AddParam("flexmacro","toggle"  ,OPTIONAL,STRICT,{"string"},{"true"},nil)
		scmd:AddParam("flexmacro","reset"   ,OPTIONAL,NON_STRICT,{"string"},{"true"},nil)
		scmd:AddParam("flexmacro","name"  ,REQUIRED,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("flexmacro","macro",REQUIRED,NON_STRICT,{"string","table"},nil, nil)
		
	scmd:AddCommand("flexpet", FB_Command_FlexPet, "appearance",
		"/FlexBar FlexPet ID=<ID> PetID=<petid> [Reset='true'] [Toggle='true']")
		-- populate the parameter list for this command
		-- arguments are: command, parameter name, required, strict, types, allowed, default
		scmd:AddParam("flexpet","id"  	,REQUIRED,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("flexpet","toggle"  ,OPTIONAL,STRICT,{"string"},{"true"},nil)
		scmd:AddParam("flexpet","reset"   ,OPTIONAL,NON_STRICT,{"string"},{"true"},nil)
		scmd:AddParam("flexpet","petid"	,REQUIRED,NON_STRICT,{"number"},nil, nil)
		
	scmd:AddCommand("clearflex", FB_Command_ClearFlex, "appearance",
		"/FlexBar ClearFlex ID=<ID>")
		-- populate the parameter list for this command
		-- arguments are: command, parameter name, required, strict, types, allowed, default
		scmd:AddParam("clearflex","id"  	,REQUIRED,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		
	scmd:AddCommand("disable", FB_Command_Disable, "misc",
		"/FlexBar Disable Button=<buttons> state=<'on' | 'off'>")
		-- populate the parameter list for this command
		-- arguments are: command, parameter name, required, strict, types, allowed, default
		scmd:AddParam("disable","button",OPTIONAL,STRICT,{"number","table"},{lowerbound=1,upperbound=FBNumButtons}, NO_DEFAULT)
		scmd:AddParam("disable","group" ,OPTIONAL,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, NO_DEFAULT)
		scmd:AddParam("disable","state" ,REQUIRED,NON_STRICT,{"string"},{"on","On","off","Off"}, NO_DEFAULT)
		scmd:AddParam("disable","toggle",OPTIONAL,STRICT,{"string"},{"true"},NO_DEFAULT)
		scmd:AddParam("disable","on"    ,OPTIONAL,NON_STRICT,{"string"},FBEventList,nil)
		scmd:AddParam("disable","target",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("disable","if"    ,OPTIONAL,NON_STRICT,{"string"},FBConditionList,nil)
		scmd:AddParam("disable","in"    ,OPTIONAL,NON_STRICT,{"number"},nil,nil)
		scmd:AddParam("disable","tname" ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("disable","ttoggle",OPTIONAL,STRICT,{"string"},{"true"},nil)

	scmd:AddCommand("hide", FB_Command_Hide, "appearance",
		"/FlexBar Hide Button=<buttons>")
		-- arguments are: command, parameter name, required, strict, types, allowed, default
		scmd:AddParam("hide","button",OPTIONAL,STRICT,{"number","table"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("hide","group" ,OPTIONAL,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("hide","toggle",OPTIONAL,STRICT,{"string"},{"true"},nil)
		scmd:AddParam("hide","on"    ,OPTIONAL,NON_STRICT,{"string"},FBEventList,nil)
		scmd:AddParam("hide","target",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("hide","if"    ,OPTIONAL,NON_STRICT,{"string"},FBConditionList,nil)
		scmd:AddParam("hide","in"    ,OPTIONAL,NON_STRICT,{"number"},nil,nil)
		scmd:AddParam("hide","tname" ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("hide","ttoggle",OPTIONAL,STRICT,{"string"},{"true"},nil)
		
	scmd:AddCommand("show", FB_Command_Show, "appearance",
		"/FlexBar Show Button=<buttons>")
		scmd:AddParam("show","button",OPTIONAL,STRICT,{"number","table"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("show","group" ,OPTIONAL,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("show","toggle",OPTIONAL,STRICT,{"string"},{"true"},nil)
		scmd:AddParam("show","on"    ,OPTIONAL,NON_STRICT,{"string"},FBEventList,nil)
		scmd:AddParam("show","target",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("show","if"    ,OPTIONAL,NON_STRICT,{"string"},FBConditionList,nil)
		scmd:AddParam("show","in"    ,OPTIONAL,NON_STRICT,{"number"},nil,nil)
		scmd:AddParam("show","tname" ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("show","ttoggle",OPTIONAL,STRICT,{"string"},{"true"},nil)
		
	scmd:AddCommand("fade", FB_Command_Fade, "appearance",
		"/FlexBar Fade Button=<buttons> Alpha=<alpha>")
		scmd:AddParam("fade","button",OPTIONAL,STRICT,{"number","table"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("fade","group" ,OPTIONAL,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("fade","alpha" ,REQUIRED,STRICT,{"number"},{lowerbound=1,upperbound=10},nil)
		scmd:AddParam("fade","toggle",OPTIONAL,STRICT,{"number"},{lowerbound=1,upperbound=10},nil)
		scmd:AddParam("fade","on"    ,OPTIONAL,NON_STRICT,{"string"},FBEventList,nil)
		scmd:AddParam("fade","target",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("fade","if"    ,OPTIONAL,NON_STRICT,{"string"},FBConditionList,nil)
		scmd:AddParam("fade","in"    ,OPTIONAL,NON_STRICT,{"number"},nil,nil)
		scmd:AddParam("fade","tname" ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("fade","ttoggle",OPTIONAL,STRICT,{"string"},{"true"},nil)
		
	scmd:AddCommand("scale", FB_Command_Scale, "appearance",
		"/FlexBar Scale Button=<buttons> Scale=<scale>")
		scmd:AddParam("scale","button",OPTIONAL,STRICT,{"number","table"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("scale","group" ,OPTIONAL,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("scale","scale" ,REQUIRED,STRICT,{"number"},{lowerbound=5,upperbound=50},nil)
		scmd:AddParam("scale","toggle",OPTIONAL,STRICT,{"number"},{lowerbound=5,upperbound=50},nil)
		scmd:AddParam("scale","reset" ,OPTIONAL,NON_STRICT,{"string"},{"true"},nil)
		scmd:AddParam("scale","on"    ,OPTIONAL,NON_STRICT,{"string"},FBEventList,nil)
		scmd:AddParam("scale","target",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("scale","if"    ,OPTIONAL,NON_STRICT,{"string"},FBConditionList,nil)
		scmd:AddParam("scale","in"    ,OPTIONAL,NON_STRICT,{"number"},nil,nil)
		scmd:AddParam("scale","tname" ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("scale","ttoggle",OPTIONAL,STRICT,{"string"},{"true"},nil)
		
	scmd:AddCommand("shade", FB_Command_Shade, "appearance",
		"/FlexBar Shade Button=<buttons> Color=<[r g b]>")
		scmd:AddParam("shade","button",OPTIONAL,STRICT,{"number","table"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("shade","group" ,OPTIONAL,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("shade","color" ,REQUIRED,STRICT,{"number","table"},{lowerbound=0,upperbound=10},nil)
		scmd:AddParam("shade","toggle",OPTIONAL,STRICT,{"number","table"},{lowerbound=0,upperbound=10},nil)
		scmd:AddParam("shade","reset" ,OPTIONAL,NON_STRICT,{"string"},{"true"},nil)
		scmd:AddParam("shade","on"    ,OPTIONAL,NON_STRICT,{"string"},FBEventList,nil)
		scmd:AddParam("shade","target",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("shade","if"    ,OPTIONAL,NON_STRICT,{"string"},FBConditionList,nil)
		scmd:AddParam("shade","iftarg",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("shade","in"    ,OPTIONAL,NON_STRICT,{"number"},nil,nil)
		scmd:AddParam("shade","tname" ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("shade","ttoggle",OPTIONAL,STRICT,{"string"},{"true"},nil)
		
	scmd:AddCommand("shadetext", FB_Command_ShadeText, "appearance",
		"/FlexBar ShadeText Button=<buttons> Color=<[r g b]>")
		scmd:AddParam("shadetext","button",OPTIONAL,STRICT,{"number","table"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("shadetext","group" ,OPTIONAL,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("shadetext","color" ,REQUIRED,STRICT,{"number","table"},{lowerbound=0,upperbound=10},nil)
		scmd:AddParam("shadetext","toggle",OPTIONAL,STRICT,{"number","table"},{lowerbound=0,upperbound=10},nil)
		scmd:AddParam("shadetext","reset" ,OPTIONAL,NON_STRICT,{"string"},{"true"},nil)
		scmd:AddParam("shadetext","on"    ,OPTIONAL,NON_STRICT,{"string"},FBEventList,nil)
		scmd:AddParam("shadetext","target",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("shadetext","if"    ,OPTIONAL,NON_STRICT,{"string"},FBConditionList,nil)
		scmd:AddParam("shadetext","iftarg",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("shadetext","in"    ,OPTIONAL,NON_STRICT,{"number"},nil,nil)
		scmd:AddParam("shadetext","tname" ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("shadetext","ttoggle",OPTIONAL,STRICT,{"string"},{"true"},nil)
		
	scmd:AddCommand("shadetext2", FB_Command_ShadeText2, "appearance",
		"/FlexBar ShadeText2 Button=<buttons> Color=<[r g b]>")
		scmd:AddParam("shadetext2","button",OPTIONAL,STRICT,{"number","table"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("shadetext2","group" ,OPTIONAL,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("shadetext2","color" ,REQUIRED,STRICT,{"number","table"},{lowerbound=0,upperbound=10},nil)
		scmd:AddParam("shadetext2","toggle",OPTIONAL,STRICT,{"number","table"},{lowerbound=0,upperbound=10},nil)
		scmd:AddParam("shadetext2","reset" ,OPTIONAL,NON_STRICT,{"string"},{"true"},nil)
		scmd:AddParam("shadetext2","on"    ,OPTIONAL,NON_STRICT,{"string"},FBEventList,nil)
		scmd:AddParam("shadetext2","target",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("shadetext2","if"    ,OPTIONAL,NON_STRICT,{"string"},FBConditionList,nil)
		scmd:AddParam("shadetext2","iftarg",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("shadetext2","in"    ,OPTIONAL,NON_STRICT,{"number"},nil,nil)
		scmd:AddParam("shadetext2","tname" ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("shadetext2","ttoggle",OPTIONAL,STRICT,{"string"},{"true"},nil)
		
	scmd:AddCommand("shadetext3", FB_Command_ShadeText3, "appearance",
		"/FlexBar ShadeText3 Button=<buttons> Color=<[r g b]>")
		scmd:AddParam("shadetext3","button",OPTIONAL,STRICT,{"number","table"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("shadetext3","group" ,OPTIONAL,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("shadetext3","color" ,REQUIRED,STRICT,{"number","table"},{lowerbound=0,upperbound=10},nil)
		scmd:AddParam("shadetext3","toggle",OPTIONAL,STRICT,{"number","table"},{lowerbound=0,upperbound=10},nil)
		scmd:AddParam("shadetext3","reset" ,OPTIONAL,NON_STRICT,{"string"},{"true"},nil)
		scmd:AddParam("shadetext3","on"    ,OPTIONAL,NON_STRICT,{"string"},FBEventList,nil)
		scmd:AddParam("shadetext3","target",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("shadetext3","if"    ,OPTIONAL,NON_STRICT,{"string"},FBConditionList,nil)
		scmd:AddParam("shadetext3","iftarg",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("shadetext3","in"    ,OPTIONAL,NON_STRICT,{"number"},nil,nil)
		scmd:AddParam("shadetext3","tname" ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("shadetext3","ttoggle",OPTIONAL,STRICT,{"string"},{"true"},nil)
		
	scmd:AddCommand("shadetooltip", FB_Command_ShadeToolTip, "appearance",
		"/FlexBar ShadeToolTip Color=<[r g b]>")
		scmd:AddParam("shadetext","color" ,REQUIRED,STRICT,{"number","table"},{lowerbound=0,upperbound=10},nil)
		scmd:AddParam("shadetext","toggle",OPTIONAL,STRICT,{"number","table"},{lowerbound=0,upperbound=10},nil)
		scmd:AddParam("shadetext","reset" ,OPTIONAL,NON_STRICT,{"string"},{"true"},nil)
		scmd:AddParam("shadetext","on"    ,OPTIONAL,NON_STRICT,{"string"},FBEventList,nil)
		scmd:AddParam("shadetext","target",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("shadetext","if"    ,OPTIONAL,NON_STRICT,{"string"},FBConditionList,nil)
		scmd:AddParam("shadetext","iftarg",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("shadetext","in"    ,OPTIONAL,NON_STRICT,{"number"},nil,nil)
		scmd:AddParam("shadetext","tname" ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("shadetext","ttoggle",OPTIONAL,STRICT,{"string"},{"true"},nil)
	
	
	scmd:AddCommand("settexture", FB_Command_SetTexture, "appearance",
		"/FlexBar SetTexture Button=<button> Texture='texture' [Reset='True']")
		-- populate the parameter list for this command
		-- arguments are: command, parameter name, required, strict, types, allowed, default
		scmd:AddParam("settexture","id"  ,REQUIRED,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("settexture","texture" ,OPTIONAL,STRICT,{"string"},nil, "")
		scmd:AddParam("settexture","toggle"  ,OPTIONAL,STRICT,{"string"},{"true"},nil)
		scmd:AddParam("settexture","reset"   ,OPTIONAL,NON_STRICT,{"string"},{"true"},nil)
		scmd:AddParam("settexture","on"      ,OPTIONAL,NON_STRICT,{"string"},FBEventList,nil)
		scmd:AddParam("settexture","target"  ,OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("settexture","if"      ,OPTIONAL,NON_STRICT,{"string"},FBConditionList,nil)
		scmd:AddParam("settexture","in"    ,OPTIONAL,NON_STRICT,{"number"},nil,nil)
		scmd:AddParam("settexture","tname" ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("settexture","ttoggle",OPTIONAL,STRICT,{"string"},{"true"},nil)
		
	scmd:AddCommand("lock", FB_Command_Lock, "movement",
		"/FlexBar Lock Button=<buttons>")
		scmd:AddParam("lock","button",OPTIONAL,STRICT,{"number","table"},{lowerbound=1,upperbound=FBNumButtons},nil)
		scmd:AddParam("lock","group" ,OPTIONAL,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons},nil)
		
	scmd:AddCommand("unlock", FB_Command_Unlock, "movement",
		"/FlexBar Unlock Button=<buttons>")
		scmd:AddParam("unlock","button",OPTIONAL,STRICT,{"number","table"},{lowerbound=1,upperbound=FBNumButtons},nil)
		scmd:AddParam("unlock","group" ,OPTIONAL,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons},nil)
		
	scmd:AddCommand("moveabs", FB_Command_MoveABS, "movement",
		"/FlexBar MoveABS Button=<button> XX=<x-coord> YY=<y-coord>")
		scmd:AddParam("moveabs","button",REQUIRED,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("moveabs","xx"    ,REQUIRED,STRICT,{"number"},nil,nil)
		scmd:AddParam("moveabs","yy"    ,REQUIRED,STRICT,{"number"},nil,nil)
		scmd:AddParam("moveabs","on"    ,OPTIONAL,NON_STRICT,{"string"},FBEventList,nil)
		scmd:AddParam("moveabs","target",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("moveabs","if"    ,OPTIONAL,NON_STRICT,{"string"},FBConditionList,nil)
		scmd:AddParam("moveabs","in"    ,OPTIONAL,NON_STRICT,{"number"},nil,nil)
		scmd:AddParam("moveabs","tname" ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("moveabs","ttoggle",OPTIONAL,STRICT,{"string"},{"true"},nil)
		
	scmd:AddCommand("moverel", FB_Command_MoveRel, "movement",
		"/FlexBar MoveRel Button=<button> trgBtn=<button> dX=<x-coord> dY=<y-coord>")
		scmd:AddParam("moverel","button",REQUIRED,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("moverel","trgbtn",REQUIRED,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("moverel","dx"    ,REQUIRED,STRICT,{"number"},nil,nil)
		scmd:AddParam("moverel","dy"    ,REQUIRED,STRICT,{"number"},nil,nil)
		scmd:AddParam("moverel","on"    ,OPTIONAL,NON_STRICT,{"string"},FBEventList,nil)
		scmd:AddParam("moverel","target",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("moverel","if"    ,OPTIONAL,NON_STRICT,{"string"},FBConditionList,nil)
		scmd:AddParam("moverel","in"    ,OPTIONAL,NON_STRICT,{"number"},nil,nil)
		scmd:AddParam("moverel","tname" ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("moverel","ttoggle",OPTIONAL,STRICT,{"string"},{"true"},nil)
		
	scmd:AddCommand("movetomouse", FB_Command_MoveToMouse, "movement",
		"/FlexBar MoveRel Button=<button> target=<button> dX=<x-coord> dY=<y-coord>")
		scmd:AddParam("movetomouse","button",REQUIRED,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("movetomouse","dx"    ,REQUIRED,STRICT,{"number"},nil,nil)
		scmd:AddParam("movetomouse","dy"    ,REQUIRED,STRICT,{"number"},nil,nil)
		scmd:AddParam("movetomouse","on"    ,OPTIONAL,NON_STRICT,{"string"},FBEventList,nil)
		scmd:AddParam("movetomouse","target",OPTIONAL,NON_STRICT,nil,nil,nil)
		scmd:AddParam("movetomouse","if"    ,OPTIONAL,NON_STRICT,{"string"},FBConditionList,nil)
		scmd:AddParam("movetomouse","in"    ,OPTIONAL,NON_STRICT,{"number"},nil,nil)
		scmd:AddParam("movetomouse","tname" ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("movetomouse","ttoggle",OPTIONAL,STRICT,{"string"},{"true"},nil)
		
	scmd:AddCommand("group", FB_Command_Group, "group",
		"/FlexBar Group Button=<buttons> Anchor=<button>")
		scmd:AddParam("group","button",REQUIRED,STRICT,{"number","table"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("group","anchor",REQUIRED,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons},nil)
		
	scmd:AddCommand("ungroup", FB_Command_Ungroup, "group",
		"/FlexBar Ungroup Group=<group>")
		scmd:AddParam("ungroup","group",REQUIRED,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		
	scmd:AddCommand("circlegroup", FB_Command_CircleGroup, "group",
		"/FlexBar CircleGroup Group=<group>")
		scmd:AddParam("circlegroup","group"  ,REQUIRED,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("circlegroup","padding",OPTIONAL,STRICT,{"number"},{lowerbound=0},0)
		
	scmd:AddCommand("horizontalgroup", FB_Command_HorizontalGroup, "group",
		"/FlexBar HorizontalGroup Group=<group> Height=<height> Padding=<pixels>")
		scmd:AddParam("horizontalgroup","group"  ,REQUIRED,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("horizontalgroup","padding",OPTIONAL,STRICT,{"number"},{lowerbound=0},0)
		scmd:AddParam("horizontalgroup","height" ,OPTIONAL,STRICT,{"number"},{lowerbound=1},1)
		
	scmd:AddCommand("verticalgroup", FB_Command_VerticalGroup, "group",
		"/FlexBar VerticalGroup Group=<group> Width=<width> Padding=<pixels>")
		scmd:AddParam("verticalgroup","group"  ,REQUIRED,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("verticalgroup","padding",OPTIONAL,STRICT,{"number"},{lowerbound=0},0)
		scmd:AddParam("verticalgroup","width" ,OPTIONAL,STRICT,{"number"},{lowerbound=1},1)
		
	scmd:AddCommand("menupopup", FB_Command_MenuPopUp, "group",
		"/FlexBar MenuPopUp Group=<group> Trigger=<button> Align=<alignment> Texture=<texture> Height=<height> Width=<width> Padding=<pixels>")
		scmd:AddParam("menupopup","group"  ,REQUIRED,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("menupopup","trigger"  ,REQUIRED,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons}, nil)
		scmd:AddParam("menupopup","align"  ,OPTIONAL,NON_STRICT,{"string"},nil,nil)
		scmd:AddParam("menupopup","padding",OPTIONAL,STRICT,{"number"},{lowerbound=0},0)
		scmd:AddParam("menupopup","height" ,OPTIONAL,STRICT,{"number"},{lowerbound=1},1)
		scmd:AddParam("menupopup","width" ,OPTIONAL,STRICT,{"number"},{lowerbound=1},1)
		scmd:AddParam("menupopup","texture" ,OPTIONAL,STRICT,{"string"},nil, "")
		
	scmd:AddCommand("listgroups", FB_Command_ListGroups, "group",
		"/FlexBar ListGroups [Group=<groups>]")
		scmd:AddParam("listgroups","group",OPTIONAL,STRICT,{"number"},{lowerbound=1,upperbound=FBNumButtons},nil)
		
	scmd:AddCommand("listevents", FB_Command_ListEvents, "events",
		"/FlexBar ListEvents")
		
	scmd:AddCommand("deleteevent", FB_Command_DeleteEvent, "events",
		"/FlexBar DeleteEvent event=<event number>")
		scmd:AddParam("deleteevent","event",REQUIRED,STRICT,{"number"},{lowerbound=1},nil)
		
	scmd:AddCommand("mischelp",  FB_Command_DisplayMisc, "main",
		"/FlexBar MiscHelp - for miscellaneous options")
	scmd:AddCommand("eventhelp", FB_Command_DisplayEvents, "main",
		"/FlexBar EventHelp - for options on events")
	scmd:AddCommand("grouphelp", FB_Command_DisplayGroup, "main",
		"/FlexBar GroupHelp - for options on grouping buttons")
	scmd:AddCommand("appearance", FB_Command_DisplayAppearance, "main",
		"/FlexBar Appearance - for options on button appearance")
	scmd:AddCommand("movement", FB_Command_DisplayMovement, "main",
		"/FlexBar Movement - for options on moving buttons")

	scmd:AddCommand("test", FB_Command_Test, "test",
		"/Flexbar Test arg1=<string> arg2=<number> arg3=<optional> arg4=<required>")
		scmd:AddParam("test","arg1",true,nil,{"string"},nil, nil)
		scmd:AddParam("test","arg2",true,nil,{"number"},{lowerbound=5, upperbound=10}, nil)
		scmd:AddParam("test","arg3",false,nil,{"number", "table"},{1,3,5}, 10)
		scmd:AddParam("test","arg4",true,true,{"string", "table"},{"true", "false"}, nil)
end

function FB_Command_Test(msg)
	local args = FBcmd:GetParameters(msg)
	if not FBcmd:CheckParams("test", args) then
		util:Print("not valid")
	else
		util:Print("valid")
	end
end

-- Usage display functions
function FB_Command_DisplayMisc()
	FBcmd:DisplayUsage("misc")
	util:Print(FB_DISPLAY_MISCHELP_ADD)
end

function FB_Command_DisplayAppearance()
	FBcmd:DisplayUsage("appearance")
	util:Print(FB_DISPLAY_APPHELP_ADD)
end

function FB_Command_DisplayGroup()
	FBcmd:DisplayUsage("group")
	util:Print(FB_DISPLAY_GROUPHELP_ADD)
end

function FB_Command_DisplayMovement()
	FBcmd:DisplayUsage("movement")
	util:Print(FB_DISPLAY_MOVEHELP_ADD)
end

function FB_Command_DisplayEvents()
	FBcmd:DisplayUsage("events")
end

-- Appearance command handlers

function FB_Command_Hide(msg)
-- Hide the buttons specified in Button=<buttons>
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args = FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("hide", args) then return end 
		-- In order to allow group= and button= interchangeably they had to both be optional
		-- check here for one or the other
		if (args["group"]==nil) and (args["button"]==nil) then
			util:Print("Error: You must specify a group or button")
		end
		-- check for event here - return if specified.  FBEvents will be updated
		if FB_GetEventMsg("hide", args) then return end
	end
	
	if FB_SetCommandTimer("hide", args) then return end

	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end

	-- get button list
	local buttons = FB_GetButtonList(args["button"])
	if (args["group"] and (type(args["group"]) == "number")) then
		buttons= FB_GetGroupMembers(args["group"])
	end
	
	local index
	for index = 1,buttons.n do
		local button, frame = FB_GetWidgets(buttons[index])
		-- Toggle code - if hidden and toggle exists then unhide
		if args["toggle"] and FBState[buttons[index]]["hidden"] then
			FBState[buttons[index]]["hidden"] = nil
		else
			FBState[buttons[index]]["hidden"] = true
		end
		-- Originally called ApplySettings at the end of the function - but the fact that
		-- On events go through here too requires that it not do potentially expensive operations
		-- So the call to apply the specific setting for only the buttons that are affected goes here
		FB_ApplyHidden(buttons[index])
		-- And we only save the changed setting
		FBSavedProfile[FBProfileName][buttons[index]].State["hidden"] = FBState[buttons[index]]["hidden"]
		FB_Report(button:GetName() .. " hidden")
	end
end

function FB_Command_Show(msg)
-- Show the buttons specified in Button=<buttons>
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("show", args) then return end 
		-- In order to allow group= and button= interchangeably they had to both be optional
		-- check here for one or the other
		if (args["group"]==nil) and (args["button"]==nil) then
			util:Print("Error: You must specify a group or button")
		end
		-- check for event here - return if specified.  FBEvents will be updated
		if FB_GetEventMsg("show", args) then return end
	end
	
	if FB_SetCommandTimer("show", args) then return end

	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end
-- get button list
	local buttons = FB_GetButtonList(args["button"])
	if (args["group"] and (type(args["group"]) == "number")) then
		buttons= FB_GetGroupMembers(args["group"])
	end

	local index
	for index = 1,buttons.n do
		local button, frame = FB_GetWidgets(buttons[index])
		-- Toggle code - if not hidden and toggle exists then hide
		if args["toggle"] and not FBState[buttons[index]]["hidden"] then
			FBState[buttons[index]]["hidden"] = true
		else
			FBState[buttons[index]]["hidden"] = nil
		end
		-- Originally called ApplySettings at the end of the function - but the fact that
		-- On events go through here too requires that it not do potentially expensive operations
		-- So the call to apply the specific setting for only the buttons that are affected goes here
		FB_ApplyHidden(buttons[index])
		-- And we only save the changed setting
		FBSavedProfile[FBProfileName][buttons[index]].State["hidden"] = FBState[buttons[index]]["hidden"]
		FB_Report(button:GetName() .. " unhidden")
	end
end

function FB_Command_Fade(msg)
-- Change the alpah for the buttons specified in Button=<buttons>
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("fade", args) then return end 
		-- In order to allow group= and button= interchangeably they had to both be optional
		-- check here for one or the other
		if (args["group"]==nil) and (args["button"]==nil) then
			util:Print("Error: You must specify a group or button")
		end
		-- check for event here - return if specified.  FBEvents will be updated
		if FB_GetEventMsg("fade", args) then return end
	end
	
	if FB_SetCommandTimer("fade", args) then return end

	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end

	local buttons = FB_GetButtonList(args["button"])
	if (args["group"] and (type(args["group"]) == "number")) then
		buttons= FB_GetGroupMembers(args["group"])
	end
	local index
	for index = 1,buttons.n do
		local button, frame = FB_GetWidgets(buttons[index])
		-- Toggle code - if toggle, and button already has the set alpha, then toggle to toggle alpha
		if FBState[buttons[index]]["alpha"] == nil then FBState[buttons[index]]["alpha"] = 1 end
		if args["toggle"] and (FBState[buttons[index]]["alpha"]*10) == args["alpha"] then
			FBState[buttons[index]]["alpha"] = args["toggle"] / 10
		else
			FBState[buttons[index]]["alpha"] = args["alpha"] / 10
		end
		-- Originally called ApplySettings at the end of the function - but the fact that
		-- On events go through here too requires that it not do potentially expensive operations
		-- So the call to apply the specific setting for only the buttons that are affected goes here
		FB_ApplyAlpha(buttons[index])
		-- And we only save the changed setting
		FBSavedProfile[FBProfileName][buttons[index]].State["alpha"] = FBState[buttons[index]]["alpha"]
		FB_Report(button:GetName() .. format(" alpha set to %.2f",args["alpha"]/10))
	end
end

function FB_Command_Scale(msg)
-- Show the buttons specified in Button=<buttons>
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("scale", args) then return end 
		-- In order to allow group= and button= interchangeably they had to both be optional
		-- check here for one or the other
		if (args["group"]==nil) and (args["button"]==nil) then
			util:Print("Error: You must specify a group or button")
		end
		-- check for event here - return if specified.  FBEvents will be updated
		if FB_GetEventMsg("scale", args) then return end
	end
	
	if FB_SetCommandTimer("scale", args) then return end

	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end

	local buttons = FB_GetButtonList(args["button"])
	if (args["group"] and (type(args["group"]) == "number")) then
		buttons= FB_GetGroupMembers(args["group"])
	end
	
	local index
	for index = 1,buttons.n do
		local button, frame = FB_GetWidgets(buttons[index])
		-- Toggle code - if toggle, and button already has the set alpha, then toggle to toggle alpha
		if FBState[buttons[index]]["scale"] == nil then FBState[buttons[index]]["scale"] = 1 end
		if args["toggle"] and (FBState[buttons[index]]["scale"]*10) == args["scale"] then
			FBState[buttons[index]]["scale"] = args["toggle"] / 10
		else
			FBState[buttons[index]]["scale"] = args["scale"] / 10
		end
		if args["reset"] then
			FBState[buttons[index]]["scale"] = nil
		end
		-- Originally called ApplySettings at the end of the function - but the fact that
		-- On events go through here too requires that it not do potentially expensive operations
		-- So the call to apply the specific setting for only the buttons that are affected goes here
		FB_ApplyScale(buttons[index])
		-- And we only save the changed setting
		FBSavedProfile[FBProfileName][buttons[index]].State["scale"] = FBState[buttons[index]]["scale"]
		if FBState[buttons[index]]["scale"] then 
			FB_Report(button:GetName() .. format(" scale set to %.2f",args["scale"]/10)) 
		else
			FB_Report(button:GetName() .. format(" scale is reset"))
		end
	end
end

local colortable = {1,1,1}
local colortable2 = {1,1,1}
function FB_Command_Shade(msg)
	local index
-- Shade the buttons specified in Button=<buttons> with the color in Color=
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("shade", args) then return end 
		-- In order to allow group= and button= interchangeably they had to both be optional
		-- check here for one or the other
		if (args["group"]==nil) and (args["button"]==nil) then
			util:Print("Error: You must specify a group or button")
		end
		-- advanced checks that aren't automatic
		if 	type(args["color"]) ~= "table" or args["color"][3] == nil or
			(args["toggle"] and (type(args["toggle"]) ~= "table" or args["toggle"][3] == nil)) then
			util:Print("Error: Color not in correct format")
			return
		end
		-- check for event here - return if specified.  FBEvents will be updated
		if FB_GetEventMsg("shade", args) then return end
	end

	if FB_SetCommandTimer("shade", args) then return end

	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end

	local buttons = FB_GetButtonList(args["button"])
	if (args["group"] and (type(args["group"]) == "number")) then
		buttons= FB_GetGroupMembers(args["group"])
	end
	local index
	for index = 1,3 do
		colortable[index] = args["color"][index] / 10
		if args["toggle"] then colortable2[index] = args["toggle"][index] / 10 end
	end
	for index = 1,buttons.n do
		local button, frame = FB_GetWidgets(buttons[index])
		-- Toggle code - if toggle, and button already the color specified, then toggle then go to toggle color
		if FBState[buttons[index]]["icon"] == nil then FBState[buttons[index]]["icon"] = {1, 1, 1} end
		if 	args["toggle"] and 
			colortable[1] == FBState[buttons[index]]["icon"][1] and
			colortable[2] == FBState[buttons[index]]["icon"][2] and
			colortable[3] == FBState[buttons[index]]["icon"][3] then
			colortable[1] = colortable2[1]
			colortable[2] = colortable2[2]
			colortable[3] = colortable2[3]
		elseif args["reset"] then
			colortable[1] = nil
			colortable[2] = nil
			colortable[3] = nil
			FBState[buttons[index]]["coloring"] = "resetting"
			FB_Report(button:GetName() .. " has had its color reset")
		end
		if colortable[1] then 
			FBState[buttons[index]]["icon"][1] = colortable[1] 
			FBState[buttons[index]]["icon"][2] = colortable[2] 
			FBState[buttons[index]]["icon"][3] = colortable[3] 
			FB_Report(button:GetName() .. format(" color set to %.2f, %.2f, %.2f",
				colortable[1],colortable[1],colortable[1]))
		else
			FBState[buttons[index]]["icon"] = nil
		end
		-- Simply having the state in effect will change the color, but save the changed setting
		-- and avoid a call to apply settings
		if FBState[buttons[index]]["icon"] then
			if not FBSavedProfile[FBProfileName][buttons[index]].State["icon"] then
				FBSavedProfile[FBProfileName][buttons[index]].State["icon"] = {}
			end
			FBSavedProfile[FBProfileName][buttons[index]].State["icon"][1] = colortable[1]
			FBSavedProfile[FBProfileName][buttons[index]].State["icon"][2] = colortable[2]
			FBSavedProfile[FBProfileName][buttons[index]].State["icon"][3] = colortable[3]
		else
			FBSavedProfile[FBProfileName][buttons[index]].State["icon"] = FBState[buttons[index]]["icon"]
		end
	end
end

function FB_Command_ShadeText(msg)
-- Shade the buttons specified in Button=<buttons> with the color in Color=
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("shadetext", args) then return end 
		-- In order to allow group= and button= interchangeably they had to both be optional
		-- check here for one or the other
		if (args["group"]==nil) and (args["button"]==nil) then
			util:Print("Error: You must specify a group or button")
		end
		-- advanced checks that aren't automatic
		if 	type(args["color"]) ~= "table" or args["color"][3] == nil or
			(args["toggle"] and (type(args["toggle"]) ~= "table" or args["toggle"][3] == nil)) then
			util:Print("Error: Color not in correct format")
			return
		end
		-- check for event here - return if specified.  FBEvents will be updated
		if FB_GetEventMsg("shadetext", args) then return end
	end

	if FB_SetCommandTimer("shadetext", args) then return end

	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end

	local buttons = FB_GetButtonList(args["button"])
	if (args["group"] and (type(args["group"]) == "number")) then
		buttons= FB_GetGroupMembers(args["group"])
	end
	local index
	for index = 1,3 do
		colortable[index] = args["color"][index] / 10
		if args["toggle"] then colortable2[index] = args["toggle"][index] / 10 end
	end
	for index = 1,buttons.n do
		local button, frame = FB_GetWidgets(buttons[index])
		-- Toggle code - if toggle, and button already the color specified, then toggle then go to toggle color
		if FBState[buttons[index]]["hotkeycolor"] == nil then FBState[buttons[index]]["hotkeycolor"] = {1, 1, 1} end
		if 	args["toggle"] and 
			colortable[1] == FBState[buttons[index]]["hotkeycolor"][1] and
			colortable[2] == FBState[buttons[index]]["hotkeycolor"][2] and
			colortable[3] == FBState[buttons[index]]["hotkeycolor"][3] then
			colortable[1] = colortable2[1]
			colortable[2] = colortable2[2]
			colortable[3] = colortable2[3]
		elseif args["reset"] then
			colortable[1] = nil
			colortable[2] = nil
			colortable[3] = nil
			FB_Report("text 1 has had its color reset")
			getglobal(button:GetName() .. "HotKey"):SetVertexColor(.6,.6,.6)
		end
		if colortable[1] then 
			FBState[buttons[index]]["hotkeycolor"][1] = colortable[1] 
			FBState[buttons[index]]["hotkeycolor"][2] = colortable[2] 
			FBState[buttons[index]]["hotkeycolor"][3] = colortable[3] 
			FB_Report(button:GetName() .. format(" color set to %.2f, %.2f, %.2f",
				colortable[1],colortable[2],colortable[3]))
		else
			FBState[buttons[index]]["hotkeycolor"] = nil
		end
		-- Simply having the state in effect will change the color, but save the changed setting
		-- and avoid a call to apply settings
		if FBState[buttons[index]]["hotkeycolor"] then
			if not FBSavedProfile[FBProfileName][buttons[index]].State["hotkeycolor"] then
				FBSavedProfile[FBProfileName][buttons[index]].State["hotkeycolor"] = {}
			end
			FBSavedProfile[FBProfileName][buttons[index]].State["hotkeycolor"][1] = colortable[1]
			FBSavedProfile[FBProfileName][buttons[index]].State["hotkeycolor"][2] = colortable[2]
			FBSavedProfile[FBProfileName][buttons[index]].State["hotkeycolor"][3] = colortable[3]
		else
			FBSavedProfile[FBProfileName][buttons[index]].State["hotkeycolor"] = FBState[buttons[index]]["hotkeycolor"]
		end
		FB_TextSub(buttons[index])
	end
end

function FB_Command_ShadeText2(msg)
-- Shade the buttons specified in Button=<buttons> with the color in Color=
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("shadetext2", args) then return end 
		-- In order to allow group= and button= interchangeably they had to both be optional
		-- check here for one or the other
		if (args["group"]==nil) and (args["button"]==nil) then
			util:Print("Error: You must specify a group or button")
		end
		-- advanced checks that aren't automatic
		if 	type(args["color"]) ~= "table" or args["color"][3] == nil or
			(args["toggle"] and (type(args["toggle"]) ~= "table" or args["toggle"][3] == nil)) then
			util:Print("Error: Color not in correct format")
			return
		end
		-- check for event here - return if specified.  FBEvents will be updated
		if FB_GetEventMsg("shadetext2", args) then return end
	end

	if FB_SetCommandTimer("shadetext2", args) then return end

	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end

	local buttons = FB_GetButtonList(args["button"])
	if (args["group"] and (type(args["group"]) == "number")) then
		buttons= FB_GetGroupMembers(args["group"])
	end
	local index
	for index = 1,3 do
		colortable[index] = args["color"][index] / 10
		if args["toggle"] then colortable2[index] = args["toggle"][index] / 10 end
	end
	for index = 1,buttons.n do
		local button, frame = FB_GetWidgets(buttons[index])
		-- Toggle code - if toggle, and button already the color specified, then toggle then go to toggle color
		if FBState[buttons[index]]["text2color"] == nil then FBState[buttons[index]]["text2color"] = {1, 1, 1} end
		if 	args["toggle"] and 
			colortable[1] == FBState[buttons[index]]["text2color"][1] and
			colortable[2] == FBState[buttons[index]]["text2color"][2] and
			colortable[3] == FBState[buttons[index]]["text2color"][3] then
			colortable[1] = colortable2[1]
			colortable[2] = colortable2[2]
			colortable[3] = colortable2[3]
		elseif args["reset"] then
			colortable[1] = nil
			colortable[2] = nil
			colortable[3] = nil
			FB_Report("text 1 has had its color reset")
			getglobal(button:GetName() .. "Text2"):SetVertexColor(.6,.6,.6)
		end
		if colortable[1] then 
			FBState[buttons[index]]["text2color"][1] = colortable[1]
			FBState[buttons[index]]["text2color"][2] = colortable[2]
			FBState[buttons[index]]["text2color"][3] = colortable[3]
			FB_Report(button:GetName() .. format(" color set to %.2f, %.2f, %.2f",
				colortable[1],colortable[2],colortable[3]))
		else
			FBState[buttons[index]]["text2color"] = nil
		end
		-- Simply having the state in effect will change the color, but save the changed setting
		-- and avoid a call to apply settings
		if FBState[buttons[index]]["text2color"] then
			if not FBSavedProfile[FBProfileName][buttons[index]].State["text2color"] then
				FBSavedProfile[FBProfileName][buttons[index]].State["text2color"] = {}
			end
			FBSavedProfile[FBProfileName][buttons[index]].State["text2color"][1] = colortable[1]
			FBSavedProfile[FBProfileName][buttons[index]].State["text2color"][2] = colortable[2]
			FBSavedProfile[FBProfileName][buttons[index]].State["text2color"][3] = colortable[3]
		else
			FBSavedProfile[FBProfileName][buttons[index]].State["text2color"] = FBState[buttons[index]]["text2color"]
		end
		FB_TextSub(buttons[index])
	end
end

function FB_Command_ShadeText3(msg)
-- Shade the buttons specified in Button=<buttons> with the color in Color=
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("shadetext3", args) then return end 
		-- In order to allow group= and button= interchangeably they had to both be optional
		-- check here for one or the other
		if (args["group"]==nil) and (args["button"]==nil) then
			util:Print("Error: You must specify a group or button")
		end
		-- advanced checks that aren't automatic
		if 	type(args["color"]) ~= "table" or args["color"][3] == nil or
			(args["toggle"] and (type(args["toggle"]) ~= "table" or args["toggle"][3] == nil)) then
			util:Print("Error: Color not in correct format")
			return
		end
		-- check for event here - return if specified.  FBEvents will be updated
		if FB_GetEventMsg("shadetext3", args) then return end
	end

	if FB_SetCommandTimer("shadetext3", args) then return end

	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end

	local buttons = FB_GetButtonList(args["button"])
	if (args["group"] and (type(args["group"]) == "number")) then
		buttons= FB_GetGroupMembers(args["group"])
	end
	local index
	for index = 1,3 do
		colortable[index] = args["color"][index] / 10
		if args["toggle"] then colortable2[index] = args["toggle"][index] / 10 end
	end
	for index = 1,buttons.n do
		local button, frame = FB_GetWidgets(buttons[index])
		-- Toggle code - if toggle, and button already the color specified, then toggle then go to toggle color
		if FBState[buttons[index]]["text3color"] == nil then FBState[buttons[index]]["text3color"] = {1, 1, 1} end
		if 	args["toggle"] and 
			colortable[1] == FBState[buttons[index]]["text3color"][1] and
			colortable[2] == FBState[buttons[index]]["text3color"][2] and
			colortable[3] == FBState[buttons[index]]["text3color"][3] then
			colortable[1] = colortable2[1]
			colortable[2] = colortable2[2]
			colortable[3] = colortable2[3]
		elseif args["reset"] then
			colortable[1] = nil
			colortable[2] = nil
			colortable[3] = nil
			FB_Report("text 1 has had its color reset")
			getglobal(button:GetName() .. "Text3"):SetVertexColor(.6,.6,.6)
		end
		if colortable[1] then 
			FBState[buttons[index]]["text3color"][1] = colortable[1]
			FBState[buttons[index]]["text3color"][2] = colortable[2]
			FBState[buttons[index]]["text3color"][3] = colortable[3]
			FB_Report(button:GetName() .. format(" color set to %.2f, %.2f, %.2f",
				colortable[1],colortable[2],colortable[3]))
		else
			FBState[buttons[index]]["text3color"] = nil
		end
		-- Simply having the state in effect will change the color, but save the changed setting
		-- and avoid a call to apply settings
		if FBState[buttons[index]]["text3color"] then
			if not FBSavedProfile[FBProfileName][buttons[index]].State["text3color"] then
				FBSavedProfile[FBProfileName][buttons[index]].State["text3color"] = {}
			end
			FBSavedProfile[FBProfileName][buttons[index]].State["text3color"][1] = colortable[1]
			FBSavedProfile[FBProfileName][buttons[index]].State["text3color"][2] = colortable[2]
			FBSavedProfile[FBProfileName][buttons[index]].State["text3color"][3] = colortable[3]
		else
			FBSavedProfile[FBProfileName][buttons[index]].State["text3color"] = FBState[buttons[index]]["text3color"]
		end
		FB_TextSub(buttons[index])
	end
end

function FB_Command_ShadeToolTip(msg)
	local index
-- Shade the buttons specified in Button=<buttons> with the color in Color=
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("shadetooltip", args) then return end 
		-- advanced checks that aren't automatic
		if 	type(args["color"]) ~= "table" or args["color"][3] == nil or
			(args["toggle"] and (type(args["toggle"]) ~= "table" or args["toggle"][3] == nil)) then
			util:Print("Error: Color not in correct format")
			return
		end
		-- check for event here - return if specified.  FBEvents will be updated
		if FB_GetEventMsg("shadetooltip", args) then return end
	end

	if FB_SetCommandTimer("shadetooltip", args) then return end

	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end

	local index
	for index = 1,3 do
		colortable[index] = args["color"][index] / 10
		if args["toggle"] then colortable2[index] = args["toggle"][index] / 10 end
	end
	-- Toggle code - if toggle, and button already the color specified, then toggle then go to toggle color
	if 	args["toggle"] and 
		colortable[1] == FBToggles["tooltipinfocolor"].r and
		colortable[2] == FBToggles["tooltipinfocolor"].g and
		colortable[3] == FBToggles["tooltipinfocolor"].b then
		colortable[1] = colortable2[1]
		colortable[2] = colortable2[2]
		colortable[3] = colortable2[3]
	elseif args["reset"] then
		colortable[1] = nil
		colortable[2] = nil
		colortable[3] = nil
		FB_Report("Tooltip info has had its color reset")
	end
	if colortable[1] then 
		FBToggles["tooltipinfocolor"].r = colortable[1] 
		FBToggles["tooltipinfocolor"].g = colortable[2] 
		FBToggles["tooltipinfocolor"].b = colortable[3] 
		FB_Report(format("Tooltip color set to %.2f, %.2f, %.2f",
			colortable[1],colortable[1],colortable[1]))
	end
end
function FB_Command_JustifyText(msg)
-- Justify Text
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("justifytext", args) then return end 
		-- Place advanced bounds checking here
		if args["pos"] and not FBAnchors[string.upper(args["pos"])] then
			util:Print("Error: pos must be one of : TOPLEFT, TOPRIGHT, TOP, BOTTOMLEFT, BOTTOMRIGHT, BOTTOM, CENTER, LEFT, RIGHT")
			return
		end
		-- check for event here - return if specified.  FBEvents will be updated
		if FB_GetEventMsg("justifytext", args) then return end
	end
	
	if FB_SetCommandTimer("justifytext", args) then return end

	-- check for conditional here
	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end

	local buttons = FB_GetButtonList(args["button"])
	if (args["group"] and (type(args["group"]) == "number")) then
		buttons= FB_GetGroupMembers(args["group"])
	end
	local index
	for index = 1,buttons.n do
		local button, frame = FB_GetWidgets(buttons[index])
		FBState[buttons[index]]["justifytext"] = args["pos"]
		if args["pos"] then 
			FB_Report(button:GetName() .. "text now in " .. args["pos"])
		else
			FB_Report(button:GetName() .. "text position reset")
		end
		FBSavedProfile[FBProfileName][buttons[index]].State["justifytext"] = args["pos"]
		FB_ApplyTextPosition(buttons[index])
	end
end 

function FB_Command_JustifyText2(msg)
-- Justify Text
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("justifytext", args) then return end 
		if args["pos"] and not FBAnchors[string.upper(args["pos"])] then
			util:Print("Error: pos must be one of : TOPLEFT, TOPRIGHT, TOP, BOTTOMLEFT, BOTTOMRIGHT, BOTTOM, CENTER, LEFT, RIGHT")
			return
		end
		-- check for event here - return if specified.  FBEvents will be updated
		if FB_GetEventMsg("justifytext2", args) then return end
	end
	
	if FB_SetCommandTimer("justifytext2", args) then return end

	-- check for conditional here
	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end

	local buttons = FB_GetButtonList(args["button"])
	if (args["group"] and (type(args["group"]) == "number")) then
		buttons= FB_GetGroupMembers(args["group"])
	end
	local index
	for index = 1,buttons.n do
		local button, frame = FB_GetWidgets(buttons[index])
		FBState[buttons[index]]["justifytext2"] = args["pos"]
		if args["pos"] then 
			FB_Report(button:GetName() .. "text2 now in " .. args["pos"])
		else
			FB_Report(button:GetName() .. "text2 position reset")
		end
		FBSavedProfile[FBProfileName][buttons[index]].State["justifytext2"] = args["pos"]
		FB_ApplyTextPosition(buttons[index])
	end
end 

function FB_Command_JustifyText3(msg)
-- Justify Text
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("justifytext", args) then return end 
		if args["pos"] and not FBAnchors[string.upper(args["pos"])] then
			util:Print("Error: pos must be one of : TOPLEFT, TOPRIGHT, TOP, BOTTOMLEFT, BOTTOMRIGHT, BOTTOM, CENTER, LEFT, RIGHT")
			return
		end
		-- check for event here - return if specified.  FBEvents will be updated
		if FB_GetEventMsg("justifytext3", args) then return end
	end
	
	if FB_SetCommandTimer("justifytext3", args) then return end

	-- check for conditional here
	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end

	local buttons = FB_GetButtonList(args["button"])
	if (args["group"] and (type(args["group"]) == "number")) then
		buttons= FB_GetGroupMembers(args["group"])
	end
	local index
	for index = 1,buttons.n do
		local button, frame = FB_GetWidgets(buttons[index])
		FBState[buttons[index]]["justifytext3"] = args["pos"]
		if args["pos"] then 
			FB_Report(button:GetName() .. "text3 now in " .. args["pos"])
		else
			FB_Report(button:GetName() .. "text3 position reset")
		end
		FBSavedProfile[FBProfileName][buttons[index]].State["justifytext3"] = args["pos"]
		FB_ApplyTextPosition(buttons[index])
	end
end 

-- Movement command handlers

function FB_Command_Lock(msg)
-- Lock the buttons specified in Button=<buttons>
	local args = FBcmd:GetParameters(msg)
-- Check basic usage
	if not FBcmd:CheckParameters("lock",args) then return end
-- check here for one or the other
	if (args["group"]==nil) and (args["button"]==nil) then
		util:Print("Error: You must specify a group or button")
	end
	local buttons = FB_GetButtonList(args["button"])
	if (args["group"] and (type(args["group"]) == "number")) then
		buttons= FB_GetGroupMembers(args["group"])
	end

	local index
	for index = 1,buttons.n do
		local button, frame = FB_GetWidgets(buttons[index])
		FBState[buttons[index]]["locked"] = true
		FB_Report(button:GetName() .. " locked")
	end
	
	FB_ApplySettings()
end

function FB_Command_Unlock(msg)
-- Unlock the buttons specified in Button=<buttons>
	local args = FBcmd:GetParameters(msg)
-- Check basic usage
	if not FBcmd:CheckParameters("lock",args) then return end
-- check here for one or the other
	if (args["group"]==nil) and (args["button"]==nil) then
		util:Print("Error: You must specify a group or button")
	end
	local buttons = FB_GetButtonList(args["button"])
	if (args["group"] and (type(args["group"]) == "number")) then
		buttons= FB_GetGroupMembers(args["group"])
	end
	local index
	for index = 1,buttons.n do
		local button, frame = FB_GetWidgets(buttons[index])
		FBState[buttons[index]]["locked"] = nil
		FB_Report(button:GetName() .. " unlocked")
	end
	
	FB_ApplySettings()
end

function FB_Command_MoveABS(msg)
-- Move the specified button to a point relative to the bottom left of the screen
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("moveabs", args) then return end 
		-- check for event here - return if specified.  FBEvents will be updated
		if FB_GetEventMsg("moveabs", args) then return end
	end
	
	if FB_SetCommandTimer("moveabs", args) then return end

	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end

	local button, frame = FB_GetWidgets(args["button"])
	
	-- if the button is in a group, but not the anchor, return
	if FBState[args["button"]]["group"] and FBState[args["button"]]["group"] ~= args["button"] then return end
	
	if FBState[args["button"]]["group"] then 
		FB_StoreGroupOffsetForMove(FBState[args["button"]]["group"])
	end
		
	FB_MoveButtonABS(args["button"], args["xx"], args["yy"])
	FB_Report(button:GetName() .. format(" moved to x=%d, y=%d", args["xx"], args["yy"]))
	if FBState[args["button"]]["group"] then 
		-- A group anchor was moved. Update Group coordinates and then Group Bounding Data
		FB_RestoreGroupOffsetAfterMove(FBState[args["button"]]["group"])
		FBGroupData[FBState[args["button"]]["group"]] = FB_GetBoundingButtons(FBState[args["button"]]["group"]) 
		FB_CheckGroups()
	end
end

function FB_Command_MoveRel(msg)
-- Move the specified button to the location relative to target
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("moverel", args) then return end 
		-- check for event here - return if specified.  FBEvents will be updated
		if FB_GetEventMsg("moverel", args) then return end
	end
	
	if FB_SetCommandTimer("moverel", args) then return end

	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end

	local button, frame = FB_GetWidgets(args["button"])
	
	-- if the button is in a group, but not the anchor, return
	if FBState[args["button"]]["group"] and FBState[args["button"]]["group"] ~= args["button"] then return end
	
	if FBState[args["button"]]["group"] then 
		FB_StoreGroupOffsetForMove(FBState[args["button"]]["group"])
	end
		
	local target, frame = FB_GetWidgets(args["trgbtn"])
	local dx = args["dx"] / UIParent:GetScale()
	local dy = args["dy"] / UIParent:GetScale()
	FB_MoveButtonRel(args["button"],args["trgbtn"], dx, dy)
	FB_Report(button:GetName() .. format(" moved to x=%d, y=%d", args["dx"], args["dy"]) .. " with respect to " .. target:GetName())
	if FBState[args["button"]]["group"] then 
		-- A group anchor was moved. Update Group coordinates and then Group Bounding Data
		FB_RestoreGroupOffsetAfterMove(FBState[args["button"]]["group"])
		FBGroupData[FBState[args["button"]]["group"]] = FB_GetBoundingButtons(FBState[args["button"]]["group"]) 
		FB_CheckGroups()
	end
end

function FB_Command_MoveToMouse(msg)
-- Move the specified button to the location relative to mouse
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("movetomouse", args) then return end 
		-- check for event here - return if specified.  FBEvents will be updated
		if FB_GetEventMsg("movetomouse", args) then return end
	end
	
	if FB_SetCommandTimer("movetomouse", args) then return end

	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end

	local button, frame = FB_GetWidgets(args["button"])

	-- if the button is in a group, but not the anchor, return
	if FBState[args["button"]]["group"] and FBState[args["button"]]["group"] ~= args["button"] then return end

	if FBState[args["button"]]["group"] then 
		FB_StoreGroupOffsetForMove(FBState[args["button"]]["group"])
	end
		
	local x,y = GetCursorPosition(UIParent)
	x = x / UIParent:GetScale()
	y = y / UIParent:GetScale()
	local dx = args["dx"] / UIParent:GetScale()
	local dy = args["dy"] / UIParent:GetScale()
	FB_MoveButtonABS(args["button"], x+dx, y+dy)
	FB_Report(button:GetName() .. format(" moved to x=%d, y=%d", x+args["dx"], y+args["dy"]))
	if FBState[args["button"]]["group"] then 
		-- A group anchor was moved. Update Group coordinates and then Group Bounding Data
		FB_RestoreGroupOffsetAfterMove(FBState[args["button"]]["group"])
		FBGroupData[FBState[args["button"]]["group"]] = FB_GetBoundingButtons(FBState[args["button"]]["group"]) 
		FB_CheckGroups()
	end
end

-- All group related slash command handlers here

function FB_Command_CircleGroup(msg)
-- Arrange the specified group into a circular formation
	local args = FBcmd:GetParameters(msg)
-- Check basic usage
	if not FBcmd:CheckParameters("circlegroup",args) then return end
	local buttonnum=args["group"]
	local button, frame = FB_GetWidgets(args["group"])
	if FBState[buttonnum]["group"] ~= FB_GetButtonNum(button) then
		util:Echo(FB_NOGROUP_ERR, "green")
		return
	end
	FB_CircularGroup(args["group"], args["padding"])
	FB_Report(string.format(FB_AUTOARRANGE_RPT, args["group"]))
end

function FB_Command_VerticalGroup(msg)
-- Arrange the specified group into a vertical formation
	local args = FBcmd:GetParameters(msg)
-- Check basic usage
	if not FBcmd:CheckParameters("verticalgroup",args) then return end
	local buttonnum=args["group"]
	local button, frame = FB_GetWidgets(args["group"])
	if FBState[buttonnum]["group"] ~= FB_GetButtonNum(button) then
		util:Echo(FB_NOGROUP_ERR, "green")
		return
	end
	FB_VerticalGroup(args["group"], args["width"], args["padding"])
	FB_Report(string.format(FB_AUTOARRANGE_RPT, args["group"]))
end

function FB_Command_HorizontalGroup(msg)
-- Arrange the specified group into a horizontal formation
	local args = FBcmd:GetParameters(msg)
-- Check basic usage
	if not FBcmd:CheckParameters("horizontalgroup",args) then return end
	local buttonnum=args["group"]
	local button, frame = FB_GetWidgets(args["group"])
	if FBState[buttonnum]["group"] ~= FB_GetButtonNum(button) then
		util:Echo(FB_NOGROUP_ERR, "green")
		return
	end
	FB_HorizontalGroup(args["group"], args["height"], args["padding"])
	FB_Report(string.format(FB_AUTOARRANGE_RPT, args["group"]))
end
function FB_Command_MenuPopUp(msg)
-- Arrange the specified group into a popout menu
	local args = FBcmd:GetParameters(msg)
-- Check basic usage
	if not FBcmd:CheckParameters("menupopup",args) then return end
	local buttonnum=args["group"]
	local alignment=string.upper(args["align"])
	local trigger=args["trigger"]
	local button, frame = FB_GetWidgets(args["group"])
	if FBState[buttonnum]["group"] ~= FB_GetButtonNum(button) then
		util:Echo(FB_NOGROUP_ERR, "green")
		return
	end
	if FBState[trigger]["group"] ~= FB_GetButtonNum(button) then
		util:Echo(string.format(FB_MENUPOPUP_TRIGGER_ERR, FB_GetButtonNum(button)), "green")
		return
	end
	if alignment == "HORIZONTAL" then
		FB_HorizontalGroup(args["group"], args["height"], args["padding"])
	elseif alignment == "VERTICAL" then
		FB_VerticalGroup(args["group"], args["width"], args["padding"])
	elseif alignment == "CIRCULAR" then
		FB_CircularGroup(args["group"], args["padding"])
	else
		util:Echo(string.format(FB_MENUPOPUP_ALIGN_ERR, args["align"]), "green")
		return
	end
	local buttonlist = FB_GetGroupMembers(buttonnum)
	local i, j, buttontext="[ "
	for i, j in pairs(buttonlist) do
		if j ~= trigger then
			buttontext = buttontext..j.." "
		end
	end
	buttontext = buttontext.."]"
	FB_Command_Show("show button="..buttontext.." on='mouseenterbutton' target="..trigger)
	FB_Command_Hide("hide button="..buttontext.." on='mouseleavegroup' target="..buttonnum)	
	if args["texture"] ~= "" then
		FB_Command_SetTexture("settexture id="..trigger.." texture="..args["texture"])
	end
end
function FB_Command_Group(msg)
-- Set a group for the buttons specified in Button=<buttons>
-- Group is anchored on button specified in Anchor=<button>
	local args = FBcmd:GetParameters(msg)
-- Check basic usage
	if not FBcmd:CheckParameters("group",args) then return end
	local buttons = FB_GetButtonList(args["button"])
-- extended checks
-- Groups must have more than one members
	if buttons.n < 2 then 
		util:Echo(FB_GROUP_MEMBERS_ERR)
		return
	end
-- Anchor must also be a member of the set of buttons being made into a group
	local index
	local goodanchor = false
	for index = 1,buttons.n do
		if args["anchor"] == buttons[index] then goodanchor = true end
	end
	
	if not goodanchor then
		util:Echo(FB_GROUP_ANCHOR_ERR)
		return
	end
	
-- Good parameters - set the group
	for index = 1,buttons.n do
		local button, frame = FB_GetWidgets(buttons[index])
		FBState[buttons[index]]["group"] = args["anchor"]
	end
	
-- Reform group
	FB_ReformGroup(args["anchor"])
	if FBVerbose then FB_Command_ListGroups("group="..args["anchor"]) end
end

function FB_Command_Ungroup(msg)
-- Ungroup the buttons specified in Button=<buttons>, and their groupmates
	local args = FBcmd:GetParameters(msg)
-- Check basic usage
	if not FBcmd:CheckParameters("ungroup",args) then return end
	local buttons = FB_GetButtonList(args["group"])
	local index
	for index = 1,buttons.n do
		if FBState[buttons[index]]["group"] == buttons[index] then
			FB_Report(string.format(FB_UNGROUP_DISBAND_RPT, buttons[index]))
			local members = FB_GetGroupMembers(FBState[buttons[index]]["group"])
			local index2
			for index2 = 1, members.n do
				FBState[members[index2]]["group"] = nil
				FBState[members[index2]]["locked"] = nil
			end
		end
	end
	FB_ReformAllGroups()
end

function FB_Command_ListGroups(msg)
-- Show buttons in the groups in Group=
-- show all groups if group= ommitted
	local args = FBcmd:GetParameters(msg)
-- Check basic usage
	if not FBcmd:CheckParameters("listgroups",args) then return end

	if (args["group"] == nil) then
		local index, value
		local groups = {}
		for index = 1, FBNumButtons do
			local button, frame = FB_GetWidgets(index)
			if FBState[index]["group"] == index then groups[index] = true end
		end
		local text = FB_LISTGROUPS_RPT
		for index = 1, FBNumButtons do
			if groups[index] then text = text .. " " .. index end
		end
		util:Print(text)
		return
	end

	if type(args["group"]) == "number" then
		buttons= FB_GetGroupMembers(args["group"])
	else
		FBcmd:DisplayUsage("group")
		return
	end
	
	local index
	local text = string.format(FB_LISTGROUPS_BUTTON_RPT, args["group"])
	for index = 1, buttons.n do
		text = text .. " " ..  buttons[index]
	end
	util:Print(text)
end

-- Event functions

function FB_Command_ListEvents(msg)
-- Show events
	local args = FBcmd:GetParameters(msg)
-- Check basic usage
	if not FBcmd:CheckParameters("listevents",args) then return end
	
	local index, event
	for index, event in ipairs(FBEvents) do
		util:Print(index .. ") On " .. event["on"] .. " " .. event["targettext"] .. " : " .. event["command"])
	end
end

function FB_Command_DeleteEvent(msg)
-- Delete specified event
	local args = FBcmd:GetParameters(msg)
-- Check basic usage
	if not FBcmd:CheckParameters("deleteevent",args) then return end
	table.remove(FBEvents,args["event"])
	FB_Report("Event " .. args["event"] .. " deleted")
	FB_CreateQuickDispatch()
	FBSavedProfile[FBProfileName].Events = util:TableCopy(FBEvents)
end

-- Miscellaneous command handlers

function FB_Command_Verbose(msg)
-- Set the feedback verbosity level
	local args = FBcmd:GetParameters(msg)
-- Check basic usage
	if not FBcmd:CheckParameters("verbose",args) then return end
	if args["state"] ~= nil then
		if string.lower(args["state"]) == "on" then
			FBVerbose = true
			util:Print("Verbose mode Active", "green")
		else
			FBVerbose = nil;
			util:Print("Verbose mode Inactive", "yellow")
		end
	else
		FBcmd:DisplayUsage("misc")
	end
end

function FB_Command_Tooltip(msg)
-- Set the feedback verbosity level
	local args = FBcmd:GetParameters(msg)
-- Check basic usage
	if not FBcmd:CheckParameters("verbose",args) then return end
	if args["state"] ~= nil then
		if string.lower(args["state"]) == "on" then
			FBNoTooltips = nil
			util:Print("Tooltips will now show", "green")
		else
			FBNoTooltips = true
			util:Print("Tooltips will not show", "yellow")
		end
	else
		FBcmd:DisplayUsage("misc")
	end
end

function FB_Command_LockIcon(msg)
-- Lock the icon to the buttons specified in Button=<buttons>
	local args = FBcmd:GetParameters(msg)
-- Check basic usage
	if not FBcmd:CheckParameters("lockicon",args) then return end
	local buttons = FB_GetButtonList(args["button"])
	if (args["group"] and (type(args["group"]) == "number")) then
		buttons= FB_GetGroupMembers(args["group"])
	end
	
	local index
	for index = 1,buttons.n do
		local button, frame = FB_GetWidgets(buttons[index])
		if args["off"] then
			FBState[buttons[index]]["lockedicon"] = nil
			FB_Report(button:GetName() .. " has it's Icon unlocked click and drag to remove")
		else
			FBState[buttons[index]]["lockedicon"] = true
			FB_Report(button:GetName() .. " has it's Icon locked - shift click to remove")
		end
	end
	
	FB_ApplySettings()
end

function FB_Command_Text(msg)
-- template for new commands
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("text", args) then return end 
		-- Place advanced bounds checking here
		if (args["group"]==nil) and (args["button"]==nil) then
			util:Print("Error: You must specify a group or button")
		end
		if (args["text"]==nil) then
			args["text"] = ""
		end
		
		-- check for event here - return if specified.  FBEvents will be updated
		if FB_GetEventMsg("text", args) then return end
	end
	
	if FB_SetCommandTimer("text", args) then return end

	-- check for conditional here
	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end

	local buttons = FB_GetButtonList(args["button"])
	if (args["group"] and (type(args["group"]) == "number")) then
		buttons= FB_GetGroupMembers(args["group"])
	end
	local index
	for index = 1,buttons.n do
		local button, frame = FB_GetWidgets(buttons[index])
		FBState[buttons[index]]["hotkeytext"] = args["text"]
		FB_TextSub(buttons[index])
		FlexBarButton_UpdateUsable(button)
		FlexBarButton_UpdateHotkeys(button)
		FB_Report(button:GetName() .. " now has " .. args["text"] .. " as it's hotkey")
		FBSavedProfile[FBProfileName][buttons[index]].State["hotkeytext"] = args["text"]
	end
end 

function FB_Command_Text2(msg)
-- template for new commands
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("text2", args) then return end 
		-- Place advanced bounds checking here
		if (args["group"]==nil) and (args["button"]==nil) then
			util:Print("Error: You must specify a group or button")
		end
		if (args["text"]==nil) then
			args["text"] = ""
		end
		
		-- check for event here - return if specified.  FBEvents will be updated
		if FB_GetEventMsg("text2", args) then return end
	end
	if FB_SetCommandTimer("text2", args) then return end

	-- check for conditional here
	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end
	local buttons = FB_GetButtonList(args["button"])
	if (args["group"] and (type(args["group"]) == "number")) then
		buttons= FB_GetGroupMembers(args["group"])
	end
	local index
	for index = 1,buttons.n do
		local button, frame = FB_GetWidgets(buttons[index])
		FBState[buttons[index]]["text2"] = args["text"]
		FB_TextSub(buttons[index])
		FlexBarButton_UpdateUsable(button)
		FlexBarButton_UpdateHotkeys(button)
		FB_Report(button:GetName() .. " now has " .. args["text"] .. " as it's hotkey")
		FBSavedProfile[FBProfileName][buttons[index]].State["text2"] = args["text"]
	end
end 

function FB_Command_Text3(msg)
-- template for new commands
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("text3", args) then return end 
		-- Place advanced bounds checking here
		if (args["group"]==nil) and (args["button"]==nil) then
			util:Print("Error: You must specify a group or button")
		end
		if (args["text"]==nil) then
			args["text"] = ""
		end
		
		-- check for event here - return if specified.  FBEvents will be updated
		if FB_GetEventMsg("text3", args) then return end
	end
	if FB_SetCommandTimer("text3", args) then return end

	-- check for conditional here
	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end
	local buttons = FB_GetButtonList(args["button"])
	if (args["group"] and (type(args["group"]) == "number")) then
		buttons= FB_GetGroupMembers(args["group"])
	end
	local index
	for index = 1,buttons.n do
		local button, frame = FB_GetWidgets(buttons[index])
		FBState[buttons[index]]["text3"] = args["text"]
		FB_TextSub(buttons[index])
		FlexBarButton_UpdateUsable(button)
		FlexBarButton_UpdateHotkeys(button)
		FB_Report(button:GetName() .. " now has " .. args["text"] .. " as it's hotkey")
		FBSavedProfile[FBProfileName][buttons[index]].State["text3"] = args["text"]
	end
end 

function FB_Command_ReMap(msg)
-- Remap the bonus buttons to the specified base
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("remap", args) then return end 
		-- Get button list
		local buttons = FB_GetButtonList(args["button"])
		if (args["group"]) then
			buttons= FB_GetGroupMembers(args["group"])
		end
		-- Another check that can't be automated
		if args["base"] + buttons.n - 1 > 120 then
			util:Print("Error: Remap would make a button ID out of bounds")
			return
		end
		-- check for event here - return if specified.  FBEvents will be updated
		if FB_GetEventMsg("remap", args) then return end
	end
	
	if FB_SetCommandTimer("remap", args) then return end

	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end

	local buttons = FB_GetButtonList(args["button"])
	if (args["group"]) then
		buttons= FB_GetGroupMembers(args["group"])
	end
	local index
	for index = 1, buttons.n do
		local button, frame = FB_GetWidgets(buttons[index])
		local id = button:GetID()
		local waspet = FBSavedProfile[FBProfileName].FlexActions[id] and FBSavedProfile[FBProfileName].FlexActions[id]["action"] == "pet"
		-- if toggle is present AND button are already mapped to anything but default OR Reset is true
		-- then map them to the default, otherwise map them to base + index - 1.
		if 	(args["toggle"] and FBState[buttons[index]]["remap"]) or args["reset"] then
			FBState[buttons[index]]["remap"] = nil
			button:SetID(FBState[buttons[index]]["oldid"])
		else
			FBState[buttons[index]]["remap"] = index + args["base"] - 1
			button:SetID(FBState[buttons[index]]["remap"])
		end
		local id = button:GetID()
		local ispet = FBSavedProfile[FBProfileName].FlexActions[id] and FBSavedProfile[FBProfileName].FlexActions[id]["action"] == "pet"
		if waspet then FB_ResetPetItems(button) end
		if ispet then FBPetActions[buttons[index]] = true end
		FlexBarButton_Update(button)
		FlexBarButton_UpdateCooldown(button)
		FlexBarButton_UpdateState(button)
		FB_MimicPetButtons()
		FBSavedProfile[FBProfileName][buttons[index]].State["remap"] = FBState[buttons[index]]["remap"]
		FB_Report(button:GetName() .. " remapped to " .. button:GetID())
	end
end

function FB_Command_Echo(msg)
-- Have the specified buttons echo a second buttondown/up/click events
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("echo", args) then return end 
		-- Get button list
		local buttons = FB_GetButtonList(args["button"])
		if (args["group"]) then
			buttons= FB_GetGroupMembers(args["group"])
		end
		-- Another check that can't be automated
		if args["base"] + buttons.n - 1 > FBNumButtons then
			util:Print("Error: echo would make a button # out of bounds")
			return
		end
		-- check for event here - return if specified.  FBEvents will be updated
		if FB_GetEventMsg("echo", args) then return end
	end
	
	if FB_SetCommandTimer("echo", args) then return end

	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end

	local buttons = FB_GetButtonList(args["button"])
	if (args["group"]) then
		buttons= FB_GetGroupMembers(args["group"])
	end
	local index
	for index = 1, buttons.n do
		local button, frame = FB_GetWidgets(buttons[index])
		-- if toggle is present AND button are already echoing anything but default OR Reset is true
		-- then map them to the default, otherwise map them to base + index - 1.
		if 	(args["toggle"] and FBState[buttons[index]]["echo"]) or args["reset"] then
			FBState[buttons[index]]["echo"] = nil
		else
			FBState[buttons[index]]["echo"] = args["base"] + index - 1
		end
		
		FBSavedProfile[FBProfileName][buttons[index]].State["echo"] = FBState[buttons[index]]["echo"]
		if FBState[buttons[index]]["echo"] then
			FB_Report(button:GetName() .. " echoing " .. FBState[buttons[index]]["echo"])
		else
			FB_Report(button:GetName() .. " no longer echoing")
		end
	end
end

function FB_Command_HideGrid(msg)
-- Hide the button background if it doesn't have an action
	local args = FBcmd:GetParameters(msg)
-- Check basic usage
	if not FBcmd:CheckParameters("hidegrid",args) then return end
-- check here for one or the other
	if (args["group"]==nil) and (args["button"]==nil) then
		util:Print("Error: You must specify a group or button")
	end
	local buttons = FB_GetButtonList(args["button"])
	if (args["group"] and (type(args["group"]) == "number")) then
		buttons= FB_GetGroupMembers(args["group"])
	end
	
	local index
	for index = 1,buttons.n do
		local button, frame = FB_GetWidgets(buttons[index])
		if args["toggle"] and (FBState[buttons[index]]["hidegrid"] or FBState[buttons[index]]["savedgrid"] )then
			FBState[buttons[index]]["hidegrid"] = nil
			FBState[buttons[index]]["savedgrid"] = nil
		elseif not FBSavedProfile[FBProfileName].FlexActions[button:GetID()] then
			FBState[buttons[index]]["hidegrid"] = true
		else
			FBState[buttons[index]]["savedgrid"] = true
		end
		if FBState[buttons[index]]["hidegrid"] then
			button.showgrid=0
			frame:DisableDrawLayer()
		else
			button.showgrid=1
			button:Show()
			frame:EnableDrawLayer()
		end
		FlexBarButton_Update(button)
		FlexBarButton_UpdateState(button)
		FB_Report(button:GetName() .. " has it's background hidden.  It will show when you drag an item")
	end
	
	FB_ApplySettings()
end

function FB_Command_ShowGrid(msg)
-- Hide the button background if it doesn't have an action
	local args = FBcmd:GetParameters(msg)
-- Check basic usage
	if not FBcmd:CheckParameters("showgrid",args) then return end
-- check here for one or the other
	if (args["group"]==nil) and (args["button"]==nil) then
		util:Print("Error: You must specify a group or button")
	end
	local buttons = FB_GetButtonList(args["button"])
	if (args["group"] and (type(args["group"]) == "number")) then
		buttons= FB_GetGroupMembers(args["group"])
	end
	
	local index
	for index = 1,buttons.n do
		local button, frame = FB_GetWidgets(buttons[index])
		if args["toggle"] and not FBState[buttons[index]]["hidegrid"] and not FBSavedProfile[FBProfileName].FlexActions[button:GetID()] then
			FBState[buttons[index]]["hidegrid"] = true
		elseif args["toggle"] and not FBState[buttons[index]]["savedgrid"] and FBSavedProfile[FBProfileName].FlexActions[button:GetID()] then
			FBState[buttons[index]]["savedgrid"] = true
		else
			FBState[buttons[index]]["hidegrid"] = nil
			FBState[buttons[index]]["savedgrid"] = nil
		end
		if FBState[buttons[index]]["hidegrid"] then
			button.showgrid=0
			frame:DisableDrawLayer()
		else
			button.showgrid=1
			button:Show()
			frame:EnableDrawLayer()
		end
		FlexBarButton_Update(button)
		FlexBarButton_UpdateState(button)
		FB_Report(button:GetName() .. " has it's background hidden.  It will show when you drag an item")
	end
	
	FB_ApplySettings()
end

function FB_Command_Advanced(msg)
-- Set it so that only a left click on this button will trigger it
	local args = FBcmd:GetParameters(msg)
	if not FBcmd:CheckParameters("advanced", args) then return end
-- check here for one or the other
	if (args["group"]==nil) and (args["button"]==nil) then
		util:Print("Error: You must specify a group or button")
	end
	local buttons = FB_GetButtonList(args["button"])
	if (args["group"] and (type(args["group"]) == "number")) then
		buttons= FB_GetGroupMembers(args["group"])
	end

	local index
	for index = 1,buttons.n do
		local button, frame = FB_GetWidgets(buttons[index])
		if string.lower(args["state"]) == "on" then
			FBState[buttons[index]]["advanced"] = true
			FB_Report(button:GetName() .. " will now only fire on a left click")
		else
			FBState[buttons[index]]["advanced"] = nil;
			FB_Report(button:GetName() .. " will now treat all clicks the same")
		end
	end
	FB_ApplySettings()
end

function FB_Command_Use(msg)
-- Use the buttons specified in Button=<buttons>
-- NOTE - this appears to ONLY work on clicks (right/left)
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("use", args) then return end 
		-- check for event here - return if specified.  FBEvents will be updated
		if FB_GetEventMsg("use", args) then return end
	end
	
	if FB_SetCommandTimer("use", args) then return end

	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end

-- get button list
	local buttons = FB_GetButtonList(args["button"])
	if (args["group"] and (type(args["group"]) == "number")) then
		buttons= FB_GetGroupMembers(args["group"])
	end
	local index
	for index = 1,buttons.n do
		local button, frame = FB_GetWidgets(buttons[index])
		local id = button:GetID()
		if(MacroFrame_SaveMacro) then
			MacroFrame_SaveMacro()
		end
		UseAction(id, 1)
	end
end

function FB_Command_ResetAll(msg)
-- Reset entire profile for character
	local args = FBcmd:GetParameters(msg)
	if not FBcmd:CheckParameters("resetall", args) then return end

	FBSavedProfile[FBProfileName] = nil
	-- Also get rid of old (pre 1.32) profile saved by name only
	FBSavedProfile[UnitName("player")] = nil
	ReloadUI()
end

function FB_Command_Restore(msg)
-- Reset entire profile for character
	local args = FBcmd:GetParameters(msg)
	if not FBcmd:CheckParameters("restore", args) then return end
	if not FBProfileBackup then
		util:Echo("No previous profile available", "yellow")
		return
	end
	
	local index
	for index = 1, FBNumButtons do
		local button = FB_GetWidgets(index)
		button:SetID(index)
	end
	FBSavedProfile[FBProfileName] = util:TableCopy(FBProfileBackup)
	ReloadUI()
end

function FB_Command_LoadConfig(msg)
-- Load a named config from the config file
-- the naive way to do this is a simple for loop - however that cause a small
-- problem by executing group commands to fast.
-- altered to do one command per second.
	local args = FBcmd:GetParameters(msg)
	if not FBcmd:CheckParameters("loadconfig", args) then return end
-- un auto-matable checks
	if type(getglobal(args["config"])) ~= "table" and not FBScripts[args["config"]] then
		util:Print("Error: " .. args["config"] .. " not a valid config file")
		return
	end

	if nextcommand ~= 0 then
		util:Echo("Error: Still processing last config file")
		return
	end
	
	FBProfileBackup = util:TableCopy(FBSavedProfile[FBProfileName])
	currentconfig = getglobal(args["config"])

	if not currentconfig then
		FB_Execute_ConfigString(FBScripts[args["config"]]) 
		return
	end
		
	local index, value
	local count = 0
	for index, value in ipairs(currentconfig) do
		count=count+1
	end
	currentconfig.n = count
	FBTimers["loadconfig"] = Timer_Class:New(2, nil, nil, nil, FB_Config) 
end

function FB_Config()
	nextcommand = nextcommand + 1
	if nextcommand > currentconfig.n then
		nextcommand = 0
		currentconfig = nil
		return
	end
	
	util:Echo(currentconfig[nextcommand], "green")
	FBcmd:Dispatch(currentconfig[nextcommand])
	FBTimers["loadconfig"] = Timer_Class:New(2, nil, nil, nil, FB_Config) 
end

function FB_Command_Disable(msg)
-- Disable the regular action on a key
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("disable", args) then return end 
		-- check for event here - return if specified.  FBEvents will be updated
		if (args["group"]==nil) and (args["button"]==nil) then
			util:Print("Error: You must specify a group or button")
		end
		if FB_GetEventMsg("disable", args) then return end
	end
	
	if FB_SetCommandTimer("disable", args) then return end

	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end

	local buttons = FB_GetButtonList(args["button"])
	if (args["group"] and (type(args["group"]) == "number")) then
		buttons= FB_GetGroupMembers(args["group"])
	end

	local index
	for index = 1,buttons.n do
		local button, frame = FB_GetWidgets(buttons[index])
		-- Toggle code - if disabled and toggle exists then enable
		if (args["toggle"] and FBState[buttons[index]]["disabled"]) or string.lower(args["state"]) == 'off' then
			FBState[buttons[index]]["disabled"] = nil
			FB_Report(button:GetName() .. " enabled")
		elseif (args["toggle"] and not FBState[buttons[index]]["disabled"]) or string.lower(args["state"]) == 'on' then
			FBState[buttons[index]]["disabled"] = true
			FB_Report(button:GetName() .. " disabled")
		end
		-- And we only save the changed setting
		FBSavedProfile[FBProfileName][buttons[index]].State["disabled"] = FBState[buttons[index]]["disabled"]
	end
end 

function FB_Command_Raise(msg)
-- Raise an event
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("raise", args) then return end 
		if args["ttoggle"] then args["toggle"] = args["ttoggle"] end
		if args["tname"] then args["name"] = args["tname"] end
		-- check for event here - return if specified.  FBEvents will be updated
		if FB_GetEventMsg("raise", args) then return end
	end
	
	-- check for conditional here

	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end

	if args["in"] then
	-- if toggle is specified and timer already exists - cancel timer
		if (args["toggle"] and FBTimers[args["name"]] and FBTimers[args["name"]]:GetRunning()) then
			FBTimers[args["name"]] = nil
		else
		-- otherwise set timer
			FBTimers[args["name"]] = Timer_Class:New(args["in"],false,nil,nil,function() FB_RaiseEvent(args["event"],args["source"]) end)
			FB_Report("Raising " .. args["event"] .. " in " .. args["in"] .. " seconds");
		end
	else
		FB_RaiseEvent(args["event"],args["source"])
		FB_Report("Raised " .. args["event"])
	end
end 

function FB_Command_SafeLoad(msg)
-- Enable Safeload
	local args = FBcmd:GetParameters(msg)
	-- basic usage test
	if not FBcmd:CheckParameters("safeload", args) then return end 

	if string.lower(args["state"]) == "on" then
		FBSafeLoad = true
		util:Echo("SAFE LOAD ENGAGED -- you will need to manually load your profile now", "green")
	else
		FBSafeLoad = nil
		util:Echo("SAFE LOAD DIS-ENGAGED -- profile will autoload now, if you experience lost configurations, re-enable safe load", "green")
	end
end 

function FB_Command_LoadProfile(msg)
-- load a profile and make current
	local args = FBcmd:GetParameters(msg)
	-- basic usage test
	if not FBcmd:CheckParameters("loadprofile", args) then return end 
	
	if not FBSavedProfile[args["profile"]] then
		util:Echo("No such profile: " .. args["profile"], "yellow")
	else
		FBSavedProfile[FBProfileName] = util:TableCopy(FBSavedProfile[args["profile"]])
		util:Echo("Making " .. args["profile"] .. " the current profile and reloading", "green")
		FB_LoadProfile()
	end
end 

function FB_Command_SaveProfile(msg)
-- Save the current profile
	local args = FBcmd:GetParameters(msg)
	-- basic usage test
	if not FBcmd:CheckParameters("saveprofile", args) then return end 
	
	FBSavedProfile[args["profile"]] = util:TableCopy(FBSavedProfile[FBProfileName])
	util:Echo("Profile: " .. args["profile"] .. " saved" )
end 
function FB_Command_DeleteProfile(msg)
-- load a profile and make current
	local args = FBcmd:GetParameters(msg)
	-- basic usage test
	if not FBcmd:CheckParameters("deleteprofile", args) then return end 
	
	if not FBSavedProfile[args["profile"]] then
		util:Echo("No such profile: " .. args["profile"], "yellow")
	else
		FBSavedProfile[args["profile"]] = nil
		util:Echo("Profile " .. args["profile"] .. " deleted.", "green")
	end
end 
function FB_Command_ListProfiles()
-- list all profiles
	local name, profile
	util:Print("FlexBar Profiles:")
	for name, profile in ipairs(FBSavedProfile) do
		util:Print("'"..name.."'")
	end
end
function FB_Command_ToggleButtonInfo()
	if FBButtonInfoShown then
		FB_RestoreButtonText()
	else
		FB_ShowButtonInfo()
	end
end

function FB_Command_Scripts()
-- toggle script editor window
	if FBScriptsFrame:IsVisible() then
		FBScriptsEditBox:ClearFocus()
		FBScriptsFrame:Hide()
	else
		FB_ShowScripts()
	end
end
function FB_Command_Events()
-- toggle script editor window

	if FBEventEditorFrame:IsVisible() then
		FBEventEditorFrame:Hide()
	else
		FB_DisplayEventEditor()
	end
end
function FB_Command_Performance()
-- toggle script editor window
	if FBPerformanceFrame:IsVisible() then
		FBPerformanceFrame:Hide()
	else
		FB_Show_PerformanceOptions()
	end
end
function FB_Command_AutoItems()
-- toggle script editor window
	if FBAutoItemsFrame:IsVisible() then
		FBAutoItemsFrame:Hide()
	else
		FB_DisplayAutoItems()
	end
end
function FB_Command_Options()
-- toggle script editor window
	if FBOptionsFrame:IsVisible() then
		FBOptionsFrame:Hide()
	else
		FB_ShowGlobalOptions()
	end
end

function FB_Command_RunScript(msg)
-- Run a script from FBScripts	
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("runscript", args) then return end 
		-- check for event here - return if specified.  FBEvents will be updated
		if FB_GetEventMsg("runscript", args) then return end
	end
	-- check for conditional here

	if FB_SetCommandTimer("runscript", args) then return end

	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end

	if FBScripts[args["script"]] then
	-- if script is in FBScripts then run from there
		RunScript(FBScripts[args["script"]])
	else
	-- otherwise assume string contains script
		RunScript(args["script"])
	end
end 

function FB_Command_RunMacro(msg)
-- Run a script from FBScripts
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("runmacro", args) then return end 
		-- check for event here - return if specified.  FBEvents will be updated
		if FB_GetEventMsg("runmacro", args) then return end
	end
	
	-- check for conditional here

	if FB_SetCommandTimer("runmacro", args) then return end

	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end

	if type(args["macro"]) == "table" then
		local index,command, longmacro
		longmacro = "\n"
		for index,command in ipairs(args["macro"]) do
			longmacro=longmacro..command.."\n"
		end
		FB_Execute_MultilineMacro(longmacro,"InLineMacro"..GetTime())
	elseif FBScripts[args["macro"]] then
	-- if macro is in FBScripts, run from there
		FB_Execute_MultilineMacro(FBScripts[args["macro"]],args["macro"])
	else
	-- otherwise assume macro is contained in the string
		FB_Execute_Command(args["macro"])
	end
end 

function FB_Command_SetTexture(msg)
-- Set a texture for an empty button.
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("settexture", args) then return end 
		-- Place advanced bounds checking here
		if string.lower(args["texture"]) == "%backpack" then
			args["texture"] = "Interface\\Buttons\\Button-BackPack-Up"
		end
		local _,_,bnum = string.find(string.lower(args["texture"]),"%%button(%d+)")
		if bnum then
			bnum = bnum + 0
			local button = FB_GetWidgets(bnum)
			if GetActionTexture(button:GetID()) then
				args["texture"] = GetActionTexture(button:GetID())
			else
				args["texture"] = ""
			end
		end
		local _,_,mnum = string.find(string.lower(args["texture"]),"%%macro(%d+)")
		if mnum then
			mnum = mnum + 0
			if mnum > GetNumMacroIcons() then 
				util:Print("Error: No such icon")
				return
			else
				args["texture"] = GetMacroIconInfo(mnum)
			end
		end
		if args["texture"] == "" then args["reset"] = "true" end
		-- check for event here - return if specified.  FBEvents will be updated
		if FB_GetEventMsg("settexture", args) then return end
	end
	
	-- check for conditional here

	if FB_SetCommandTimer("settexture", args) then return end

	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end
	
	if 	(FBSavedProfile[FBProfileName].FlexActions[args["id"]] and
		FBSavedProfile[FBProfileName].FlexActions[args["id"]]["action"] == "settexture" and 
		args["toggle"]) or 
		args["reset"] == "true" then
		FBSavedProfile[FBProfileName].FlexActions[args["id"]] = nil
	else
		FBSavedProfile[FBProfileName].FlexActions[args["id"]] = {}
		FBSavedProfile[FBProfileName].FlexActions[args["id"]]["action"] = "settexture"
		FBSavedProfile[FBProfileName].FlexActions[args["id"]]["texture"] = args["texture"]
	end
	
	local index
	for index = 1,120 do
		local button = FB_GetWidgets(index)
		if button:GetID() == args["id"] then
			FlexBarButton_Update(button)
			FlexBarButton_UpdateUsable(button)
		end
	end
end 

function FB_Command_FlexScript(msg)
-- Set a texture for an empty button.
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("flexscript", args) then return end 
		-- Place advanced bounds checking here
		if 	HasAction(args["id"]) then
			util:Print("Error: Cannot place flexscript on ID with regular action")
		end
		if string.lower(args["texture"]) == "%backpack" then
			args["texture"] = "Interface\\Buttons\\Button-BackPack-Up"
		end
		local _,_,bnum = string.find(string.lower(args["texture"]),"%%button(%d+)")
		if bnum then
			bnum = bnum + 0
			local button = FB_GetWidgets(bnum)
			if GetActionTexture(button:GetID()) then
				args["texture"] = GetActionTexture(button:GetID())
			else
				args["texture"] = ""
			end
		end
		local _,_,mnum = string.find(string.lower(args["texture"]),"%%macro(%d+)")
		if mnum then
			mnum = mnum + 0
			if mnum > GetNumMacroIcons() then 
				util:Print("Error: No such icon")
				return
			else
				args["texture"] = GetMacroIconInfo(mnum)
			end
		end
		if args["texture"] == "" then args["reset"] = "true" end
	end
	
	
	if 	(FBSavedProfile[FBProfileName].FlexActions[args["id"]] and
		FBSavedProfile[FBProfileName].FlexActions[args["id"]]["action"] == "script" and 
		args["toggle"]) or 
		args["reset"] == "true" then
		FBSavedProfile[FBProfileName].FlexActions[args["id"]] = nil
	else
		FBSavedProfile[FBProfileName].FlexActions[args["id"]] = {}
		FBSavedProfile[FBProfileName].FlexActions[args["id"]]["action"] = "script"
		FBSavedProfile[FBProfileName].FlexActions[args["id"]]["texture"] = args["texture"]
		FBSavedProfile[FBProfileName].FlexActions[args["id"]]["script"] = args["script"]
		FBSavedProfile[FBProfileName].FlexActions[args["id"]]["name"] = args["name"]
	end
	
	local index
	for index = 1,120 do
		local button = FB_GetWidgets(index)
		if button:GetID() == args["id"] then
			local profile = FBSavedProfile[FBProfileName]
			local action = profile.FlexActions[args["id"]]
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
			FB_ResetPetItems(button)
		end
	end
	FB_GeneratePetIDList()
	FB_MimicPetButtons()
end 

function FB_Command_FlexMacro(msg)
-- Set a texture for an empty button.
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("flexmacro", args) then return end 
		-- Place advanced bounds checking here
		if 	HasAction(args["id"]) then
			util:Print("Error: Cannot place flexmacro on ID with regular action")
		end
		if string.lower(args["texture"]) == "%backpack" then
			args["texture"] = "Interface\\Buttons\\Button-BackPack-Up"
		end
		local _,_,bnum = string.find(string.lower(args["texture"]),"%%button(%d+)")
		if bnum then
			bnum = bnum + 0
			local button = FB_GetWidgets(bnum)
			if GetActionTexture(button:GetID()) then
				args["texture"] = GetActionTexture(button:GetID())
			else
				args["texture"] = ""
			end
		end
		local _,_,mnum = string.find(string.lower(args["texture"]),"%%macro(%d+)")
		if mnum then
			mnum = mnum + 0
			if mnum > GetNumMacroIcons() then 
				util:Print("Error: No such icon")
				return
			else
				args["texture"] = GetMacroIconInfo(mnum)
			end
		end
		if args["texture"] == "" then args["reset"] = "true" end
	end
	
	
	if 	(FBSavedProfile[FBProfileName].FlexActions[args["id"]] and
		FBSavedProfile[FBProfileName].FlexActions[args["id"]]["action"] == "macro" and 
		args["toggle"]) or 
		args["reset"] == "true" then
		FBSavedProfile[FBProfileName].FlexActions[args["id"]] = nil
	else
		FBSavedProfile[FBProfileName].FlexActions[args["id"]] = {}
		FBSavedProfile[FBProfileName].FlexActions[args["id"]]["action"] = "macro"
		FBSavedProfile[FBProfileName].FlexActions[args["id"]]["texture"] = args["texture"]
		FBSavedProfile[FBProfileName].FlexActions[args["id"]]["macro"] = args["macro"]
		FBSavedProfile[FBProfileName].FlexActions[args["id"]]["name"] = args["name"]
	end
	
	local index
	for index = 1,120 do
		local button = FB_GetWidgets(index)
		if button:GetID() == args["id"] then
			local profile = FBSavedProfile[FBProfileName]
			local action = profile.FlexActions[args["id"]]
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
			FB_ResetPetItems(button)
		end
	end
	FB_GeneratePetIDList()
	FB_MimicPetButtons()
end 

function FB_Command_FlexPet(msg)
-- Set a texture for an empty button.
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("flexpet", args) then return end 
		-- Place advanced bounds checking here
		if 	HasAction(args["id"]) then
			util:Print("Error: Cannot place flexpet on ID with regular action")
			return
		end
	end
	
	
	if 	(FBSavedProfile[FBProfileName].FlexActions[args["id"]] and
		FBSavedProfile[FBProfileName].FlexActions[args["id"]]["action"] == "pet" and 
		args["toggle"]) or 
		args["reset"] == "true" then
		FBSavedProfile[FBProfileName].FlexActions[args["id"]] = nil
	else
		FBSavedProfile[FBProfileName].FlexActions[args["id"]] = {}
		FBSavedProfile[FBProfileName].FlexActions[args["id"]]["action"] = "pet"
		FBSavedProfile[FBProfileName].FlexActions[args["id"]]["id"] = args["petid"]
	end
	
	local index
	for index = 1,120 do
		local button = FB_GetWidgets(index)
		if button:GetID() == args["id"] then
			local profile = FBSavedProfile[FBProfileName]
			local action = profile.FlexActions[args["id"]]
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
			FB_ResetPetItems(button)
			FlexBarButton_Update(button)
			FlexBarButton_UpdateUsable(button)
		end
	end
	FB_GeneratePetIDList()
	FB_MimicPetButtons()
end 

function FB_Command_ClearFlex(msg)
-- Set a texture for an empty button.
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("clearflex", args) then return end 
		-- Place advanced bounds checking here
	end
	
	
	FBSavedProfile[FBProfileName].FlexActions[args["id"]] = nil
	
	local index
	for index = 1,120 do
		local button = FB_GetWidgets(index)
		if button:GetID() == args["id"] then
			local profile = FBSavedProfile[FBProfileName]
			local action = profile.FlexActions[args["id"]]
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
			FB_ResetPetItems(button)
			FlexBarButton_Update(button)
			FlexBarButton_UpdateUsable(button)
		end
	end
end 

function FB_Command_Template(msg)
-- template for new commands
	local args
	if FBEventArgs then
	-- if FBEventArgs is non-nil, then we are coming from raise event, and quick dispatch is in effect
		args=FBEventArgs
	else
	-- otherwise this is from the command line and regular checking needs to occur
		args = FBcmd:GetParameters(msg)
		-- basic usage test
		if not FBcmd:CheckParameters("template", args) then return end 
		-- Place advanced bounds checking here
		-- check for event here - return if specified.  FBEvents will be updated
		if FB_GetEventMsg("template", args) then return end
	end
	
	-- check for conditional here
	if args["if"] then if not FB_CheckConditional(args["if"]) then return end end

	-- perform action here
end 
