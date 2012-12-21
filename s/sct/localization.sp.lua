-- SCT localization information
-- Spanish Locale
-- Translation by JSR1976

if GetLocale() ~= "spSP" then return end

-- Static Messages
SCT.LOCALS.LowHP= "Salud Baja!";					-- Message to be displayed when HP is low
SCT.LOCALS.LowMana= "Mana Bajo!";					-- Message to be displayed when Mana is Low
SCT.LOCALS.SelfFlag = "*";								-- Icon to show self hits
SCT.LOCALS.Combat = "+Combate";						-- Message to be displayed when entering combat
SCT.LOCALS.NoCombat = "-Combate";					-- Message to be displayed when leaving combat
SCT.LOCALS.ComboPoint = "CP";			  		-- Message to be displayed when gaining a combo point
SCT.LOCALS.FiveCPMessage = "Acabalo!"; -- Message to be displayed when you have 5 combo points
SCT.LOCALS.ExtraAttack = "Extra Attack!"; -- Message to be displayed when time to execute

--Option messages
SCT.LOCALS.STARTUP = "Scrolling Combat Text "..SCT.Version.." AddOn cargado. Escribe /sct para opciones.";
SCT.LOCALS.Option_Crit_Tip = "Haz aparecer este evento siempre como CRITICO.";
SCT.LOCALS.Option_Msg_Tip = "Haz aparecer este evento com un MENSAJE. Invalida Criticos.";
SCT.LOCALS.Frame1_Tip = "Make this event always appear in ANIMATION FRAME 1.";
SCT.LOCALS.Frame2_Tip = "Make this event always appear in ANIMATION FRAME 2";

--Warnings
SCT.LOCALS.Version_Warning= "|cff00ff00SCT ADVIRTIENDO|r\n\nsus variables ahorradas son de una versi\195\179n anticuada de SCT. Si usted encuentra errores o comportamiento extra\195\177o, REAJUSTE por favor sus opciones usando el bot\195\179n del reajuste o por /sctreset que mecanograf\195\173a";
SCT.LOCALS.Load_Error = "|cff00ff00Error Loading SCT Options. It may be disabled.|r";

--nouns
SCT.LOCALS.TARGET = "Objetivo ";
SCT.LOCALS.PROFILE = "SCT Profile Cargado: |cff00ff00";
SCT.LOCALS.PROFILE_DELETE = "SCT Profile Borrado: |cff00ff00";
SCT.LOCALS.PROFILE_NEW = "SCT New Profile Creado: |cff00ff00";
SCT.LOCALS.WARRIOR = "Guerrero";
SCT.LOCALS.ROGUE = "Picaro";
SCT.LOCALS.HUNTER = "Cazador";
SCT.LOCALS.MAGE = "Mago";
SCT.LOCALS.WARLOCK = "Brujo";
SCT.LOCALS.DRUID = "Druida";
SCT.LOCALS.PRIEST = "Clerigo";
SCT.LOCALS.SHAMAN = "Chaman";
SCT.LOCALS.PALADIN = "Paladin";

--Useage
SCT.LOCALS.DISPLAY_USEAGE = "Uso: \n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "/sctdisplay 'message' (for white text)\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "/sctdisplay 'message' red(0-10) green(0-10) blue(0-10)\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "Example: /sctdisplay 'Heal Me' 10 0 0\nThis will display 'Heal Me' in bright red\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "Some Colors: red = 10 0 0, green = 0 10 0, blue = 0 0 10,\nyellow = 10 10 0, magenta = 10 0 10, cyan = 0 10 10";

--Fonts
SCT.LOCALS.FONTS = { 
	[1] = { name="Por Defecto", path="Fonts\\FRIZQT__.TTF"},
	[2] = { name="TwCenMT", path="Interface\\Addons\\sct\\fonts\\Tw_Cen_MT_Bold.TTF"},
	[3] = { name="Adventura", path="Interface\\Addons\\sct\\fonts\\Adventure.ttf"},
	[4] = { name="Enigma", path="Interface\\Addons\\sct\\fonts\\Enigma__2.TTF"},
}

-- Cosmos button
SCT.LOCALS.CB_NAME			= "Scrolling Combat Text".." "..SCT.Version;
SCT.LOCALS.CB_SHORT_DESC	= "Traducido por Jsr1976";
SCT.LOCALS.CB_LONG_DESC	= "Pops up useful combat messages above your head - try it!";
SCT.LOCALS.CB_ICON			= "Interface\\Icons\\Spell_Shadow_EvilEye"; -- "Interface\\Icons\\Spell_Shadow_FarSight"