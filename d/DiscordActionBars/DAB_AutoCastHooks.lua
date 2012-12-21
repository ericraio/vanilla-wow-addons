function DAB_Hook_Keybinding(funcName)
	local func = getglobal(funcName);
	setglobal("DAB_Old_"..funcName, func);
	RunScript("function "..funcName.."()\nDAB_AutoCast();\nDAB_Old_"..funcName.."();\nend");
end

DAB_Hook_Keybinding("MoveForwardStart");
DAB_Hook_Keybinding("MoveBackwardStart");
DAB_Hook_Keybinding("TurnLeftStart");
DAB_Hook_Keybinding("TurnRightStart");
DAB_Hook_Keybinding("StrafeLeftStart");
DAB_Hook_Keybinding("StrafeRightStart");
DAB_Hook_Keybinding("Jump");
DAB_Hook_Keybinding("ToggleAutoRun");
DAB_Hook_Keybinding("ToggleRun");