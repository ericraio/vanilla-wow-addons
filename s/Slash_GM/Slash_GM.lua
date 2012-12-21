--[[

Slash_GM
========

Description:
------------
Provides a command line mechanism to open the helpframe.

Revision History:
-----------------
04.12.05 v0.10
Initial release.

]]

function Slash_GM_OnLoad()
	SlashCmdList["SLASHGM"] = Slash_GM_Handler;
	SLASH_SLASHGM1 = "/gm";  
end

function Slash_GM_Handler()
	RunScript(ToggleHelpFrame());
	return;
end

