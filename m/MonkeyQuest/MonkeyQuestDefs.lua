--[[

	MonkeyQuest:
	Displays your quests for quick viewing.
	
	Website:	http://wow.visualization.ca/
	Author:		Trentin (monkeymods@gmail.com)
	
	
	Contributors:
	Celdor
		- Help with the Quest Log Freeze bug
		
	Diungo
		- Toggle grow direction
		
	Pkp
		- Color Quest Titles the same as the quest level
	
	wowpendium.de
		- German translation
		
	MarsMod
		- Valid player name before the VARIABLES_LOADED event bug
		- Settings resetting bug

	Juki
		- French translation
	
	Global
		- PvP Quests

--]]


-- default "constants" like #define in C :)
MONKEYQUEST_DELAY							= 0.3;
MONKEYQUEST_PADDING							= 25;
MONKEYQUEST_MAX_BUTTONS						= 40;

-- default settings
MONKEYQUEST_DEFAULT_ALPHA					= 0.5;
MONKEYQUEST_DEFAULT_FRAME_ALPHA				= 1.0;
MONKEYQUEST_DEFAULT_WIDTH					= 255;
MONKEYQUEST_DEFAULT_LEFT					= 216;
MONKEYQUEST_DEFAULT_TOP						= 864;
MONKEYQUEST_DEFAULT_BOTTOM					= 832;
MONKEYQUEST_DEFAULT_QUESTTITLECOLOUR		= "|cFFFFFFFF";
MONKEYQUEST_DEFAULT_HEADEROPENCOLOUR		= "|cFFBFBFFF";
MONKEYQUEST_DEFAULT_HEADERCLOSEDCOLOUR		= "|cFF9F9FFF";
MONKEYQUEST_DEFAULT_OVERVIEWCOLOUR			= "|cFF7F7F7F";
MONKEYQUEST_DEFAULT_SPECIALOBJECTIVECOLOUR	= "|cFFFFFF00";
MONKEYQUEST_DEFAULT_INITIALOBJECTIVECOLOUR	= "|cFFD82619";
MONKEYQUEST_DEFAULT_MIDOBJECTIVECOLOUR		= "|cFFFFFF00";
MONKEYQUEST_DEFAULT_COMPLETEOBJECTIVECOLOUR	= "|cFF00FF19";
MONKEYQUEST_DEFAULT_ZONEHILIGHTCOLOUR		= "|cff494961";
MONKEYQUEST_DEFAULT_CRASHCOLOUR				= { r = 1.0, g = 0.6901960784313725, b = 0.0 };
MONKEYQUEST_DEFAULT_SHOWNOOBTIPS			= true;
MONKEYQUEST_DEFAULT_QUESTPADDING			= 1;
MONKEYQUEST_DEFAULT_SHOWZONEHIGHLIGHT		= true;
MONKEYQUEST_DEFAULT_SHOWQUESTLEVEL			= true;
