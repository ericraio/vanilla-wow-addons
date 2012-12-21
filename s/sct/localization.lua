--Version
SCT.Version = "5.0";

--Locals
SCT.LOCALS = {}
SCT.LOCALS.EXAMPLE = "SCT";
SCT.LOCALS.EXAMPLE2 = "SCT2";
SCT.LOCALS.MSG_EXAMPLE = "SCT Message";

--Everything From here on would need to be translated and put
--into if statements for each specific language.

--***********
--ENGLISH
--***********

-- Static Messages
SCT.LOCALS.LowHP= "Low Health!";					-- Message to be displayed when HP is low
SCT.LOCALS.LowMana= "Low Mana!";					-- Message to be displayed when Mana is Low
SCT.LOCALS.SelfFlag = "*";								-- Icon to show self hits
SCT.LOCALS.Combat = "+Combat";						-- Message to be displayed when entering combat
SCT.LOCALS.NoCombat = "-Combat";					-- Message to be displayed when leaving combat
SCT.LOCALS.ComboPoint = "CP";			  		-- Message to be displayed when gaining a combo point
SCT.LOCALS.FiveCPMessage = "Finish It!"; -- Message to be displayed when you have 5 combo points
SCT.LOCALS.ExtraAttack = "Extra Attack!"; -- Message to be displayed when time to execute

--Option messages
SCT.LOCALS.STARTUP = "Scrolling Combat Text "..SCT.Version.." AddOn loaded. Type /sct for options.";
SCT.LOCALS.Option_Crit_Tip = "Make this event always appear as a CRITICAL.";
SCT.LOCALS.Option_Msg_Tip = "Make this event always appear as a MESSAGE. Overrides Criticals.";
SCT.LOCALS.Frame1_Tip = "Make this event always appear in ANIMATION FRAME 1.";
SCT.LOCALS.Frame2_Tip = "Make this event always appear in ANIMATION FRAME 2";

--Warnings
SCT.LOCALS.Version_Warning= "|cff00ff00SCT WARNING|r\n\nYour saved variables are from an outdated version of SCT. If you encounter errors or strange behavior, please RESET your options using the Reset button or by typing /sctreset";
SCT.LOCALS.Load_Error = "|cff00ff00Error Loading SCT Options. It may be disabled.|r Error: ";

--nouns
SCT.LOCALS.TARGET = "Target ";
SCT.LOCALS.PROFILE = "SCT Profile Loaded: |cff00ff00";
SCT.LOCALS.PROFILE_DELETE = "SCT Profile Deleted: |cff00ff00";
SCT.LOCALS.PROFILE_NEW = "SCT New Profile Created: |cff00ff00";
SCT.LOCALS.WARRIOR = "Warrior";
SCT.LOCALS.ROGUE = "Rogue";
SCT.LOCALS.HUNTER = "Hunter";
SCT.LOCALS.MAGE = "Mage";
SCT.LOCALS.WARLOCK = "Warlock";
SCT.LOCALS.DRUID = "Druid";
SCT.LOCALS.PRIEST = "Priest";
SCT.LOCALS.SHAMAN = "Shaman";
SCT.LOCALS.PALADIN = "Paladin";

--Useage
SCT.LOCALS.DISPLAY_USEAGE = "Useage: \n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "/sctdisplay 'message' (for white text)\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "/sctdisplay 'message' red(0-10) green(0-10) blue(0-10)\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "Example: /sctdisplay 'Heal Me' 10 0 0\nThis will display 'Heal Me' in bright red\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "Some Colors: red = 10 0 0, green = 0 10 0, blue = 0 0 10,\nyellow = 10 10 0, magenta = 10 0 10, cyan = 0 10 10";

--Fonts
SCT.LOCALS.FONTS = { 
	[1] = { name="Default", path="Fonts\\FRIZQT__.TTF"},
	[2] = { name="TwCenMT", path="Interface\\Addons\\sct\\fonts\\Tw_Cen_MT_Bold.TTF"},
	[3] = { name="Adventure", path="Interface\\Addons\\sct\\fonts\\Adventure.ttf"},
	[4] = { name="Enigma", path="Interface\\Addons\\sct\\fonts\\Enigma__2.TTF"},
}

-- Cosmos button
SCT.LOCALS.CB_NAME			= "Scrolling Combat Text".." "..SCT.Version;
SCT.LOCALS.CB_SHORT_DESC	= "by Grayhoof";
SCT.LOCALS.CB_LONG_DESC	= "Click to open SCT options menu";
SCT.LOCALS.CB_ICON			= "Interface\\Icons\\Spell_Shadow_EvilEye"; -- "Interface\\Icons\\Spell_Shadow_FarSight"