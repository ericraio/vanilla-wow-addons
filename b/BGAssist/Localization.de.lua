-- Version : German
-- Last Update 06/07/11
-- German Translation assistance by

if ( GetLocale() == "deDE" ) then
	-- DISPLAY_xxx variables can be anything you want to display
	-- EVERYTHING ELSE MUST MATCH THE GAME
	BINDING_NAME_BGASSIST_TOGGLE = "BGAssist Fenster ein- oder ausblenden";
	BGAssist_Alterac_Quests = {
		["Irondeep-Vorr\195\164te"] 		= true,
		["Coldtooth-Vorr\195\164te"] 		= true,
		["Meister Rysons Allsehendes Auge"] 	= true,
		["Verwaiste St\195\164lle"] 		= true, -- Wolf/Ram turnin
		-- Horde
		["Mehr Beute!"]					= { item= 17422, min=20 },
		["Lokholar der Eislord"]			= { item= 17306, max=4 },
		["Eine Gallone Blut"]				= { item= 17306, min=5 },
		["Widderledernes Zaumzeug"]			= { item= 17642 },
		["Die Gunst der Darkspear"]			= { item= 18142 }, -- obsolete ?
		["Mehr Gnomhaar"]				= { item= 18143 }, -- obsolete ?
		["Gesucht: MEHR ZWERGE"]			= { item= 18206 },
		["Knochensplitterjagd"]				= { item= 18144 },
		["Ruf der L\195\188fte - Guses Luftflotte"]	= { item= 17326 },
		["Ruf der L\195\188fte - Jeztors Luftflotte"]	= { item= 17327 },
		["Ruf der L\195\188fte - Mulvericks Luftflotte"]= { item= 17328 },
		-- Alliance
		["Mehr R\195\188stungsfetzen"]     		= { item = 17422, min=20 },
		["Ivus der Waldf\195\188rst"]	 		= { item = 17423, max=4 },
		["Haufenweise Kristalle"]     			= { item = 17423, min=5 },
		["Widderzaumzeug"]    				= { item = 17643 },
		["Gnomeregan Kopfgeld"]     			= { item = 18145 },
		["Staghelms Requiem"]    			= { item = 18146 },
		["Gesucht: MEHR ORCS"] 				= { item = 18207 },
		["Liebe eines Mannes"]     			= { item = 18147 },
		["Ruf der L\195\188fte - Slidores Luftflotte"]	= { item = 17502 },
		["Ruf der L\195\188fte - Vipores Luftflotte"]	= { item = 17503 },
		["Ruf der L\195\188fte - Ichmans Luftflotte"]	= { item = 17504 },
 	};
	BGAssist_FlagRegexp = {
		["RESET"] = {	["regexp"] = "Die Flaggen wurden jetzt wieder an ihren St\195\188tzpunkten aufgestellt." },
		["PICKED"] = {	["one"] = "PLAYER", ["two"] = "FACTION",
				["regexp"] = "([^!]*) hat die Flagge der ([^ ]*) aufgenommen!" },
		["DROPPED"] = {	["one"] = "PLAYER", ["two"] = "FACTION",
				["regexp"] = "([^!]*) hat die Flagge der ([^ ]*) fallen lassen!" },
		["RETURNED"] ={	["one"] = "FACTION", ["two"] = "PLAYER",
				["regexp"] = "Die Flagge der ([^ ]*) wurde von ([^!]*) zu ihrem St\195\188tzpunkt zur\195\188ckgebracht!" },
		["RETURNEDALT"] ={	["one"] = "FACTION", ["two"] = "PLAYER",
				["regexp"] = "Die Flagge der ([^ ]*) wurde zu ihrem St\195\188tzpunkt zur\195\188ckgebracht!" },
		["CAPTURED"] ={	["one"] = "PLAYER", ["two"] = "FACTION",
				["regexp"] = "([^ ]*) hat die Flagge der ([^ ]*) errungen!" },
	};
	ALTERACVALLEY 	= "Alteractal";
	WARSONGGULCH 	= "Warsongschlucht";
	ARATHIBASIN 	= "Arathibecken";
	DISPLAY_MENU_LOCKWINDOW 	= "Fensterposition fixieren";
	DISPLAY_MENU_AUTOSHOW 		= "Fenster automatisch anzeigen, wenn Schlachtfeld betreten wird";
	DISPLAY_MENU_AUTORELEASE 	= "Automatisch Geist im Schlachtfeld freilassen";
	DISPLAY_MENU_AUTOQUEST 		= "Automatisch Schlachtfeld-Quests best\195\164tigen";
	DISPLAY_MENU_AUTOENTER 		= "Automatisch Schlachtfeld betreten";
	DISPLAY_MENU_TIMERSHOW 		= "Eroberungs-Timer anzeigen";
	DISPLAY_MENU_ITEMSHOW 		= "Anzahl der Schlachtfeld-Gegenst\195\164nde anzeigen";
	DISPLAY_MENU_GYCOUNTDOWN 	= "Timer f\195\188r Wiederbelebung beim Friedhof anzeigen";
	DISPLAY_MENU_FLAGTRACKING 	= "Track Flags";
	DISPLAY_MENU_TARGETTINGASSISTANCE = "Targetting Assistance Window";
	DISPLAY_MENU_AUTOACCEPTGROUP 	= "Auto accept group invites in BG";
	DISPLAY_MENU_AUTOLEAVEGROUP 	= "Auto leave group when leaving BG";
	DISPLAY_MENU_NOPREEXISTING 	= "No pre-existing instances";
	DISPLAY_TITLEDISPLAY_CAPTURE 	= "Eroberungen";
	DISPLAY_TITLEDISPLAY_ITEMS   	= "Gegenst\195\164nde";
	DISPLAY_TITLEDISPLAY_TARGETS 	= "Targets";
	DISPLAY_TEXT_CURRENTCOUNT 	= "Momentane Anzahl";
	DISPLAY_TEXT_ENTERINGBATTLEGROUNDS = "Betrete Schlachtfeld";
	DISPLAY_TEXT_LEFTBATTLEGROUNDS 	= "Verlasse Schlachtfeld";
	DISPLAY_TEXT_TIMEUNTILREZ 	= "Zeit bis zur Wiederbelebung";
	DISPLAY_TEXT_TIMELEFT 		= "Verbleibende Zeit";
	DISPLAY_TEXT_SECONDS 		= "sekunden";
	DISPLAY_TEXT_MINUTES 		= "minuten";
	DISPLAY_TEXT_NOTENTERINGAFK = "Betrete das Schlachtfeld nicht, da Ihr AFK seid";
	DISPLAY_TEXT_FLAGHOLDERNOTCLOSEENOUGH = "Flag Holder not close enough to target.";
	DISPLAY_TEXT_PREEXISTING 	= "Offered BG instance is pre-existing";
	BATTLEGROUND_GOSSIP_TEXT 	= "Ich m\195\182chte das Schlachtfeld betreten.";
	MATCHING_MARKED_AFK 		= "Ihr seid jetzt AFK: Nicht an der Tastatur";
	MATCHING_CLEARED_AFK 		= "Ihr werdet nicht mehr mit 'Nicht an der Tastatur' angezeigt.";
	FACTION_ALLIANCE 	= "Allianz";
	FACTION_HORDE 		= "Horde";
	CLASS_DRUID 	= "Druide";
	CLASS_HUNTER 	= "J\195\164ger";
	CLASS_MAGE 	= "Magier";
	CLASS_PALADIN 	= "Paladin"
	CLASS_PRIEST 	= "Priester";
	CLASS_ROGUE 	= "Schurke";
	CLASS_SHAMAN	= "Schamane";
	CLASS_WARRIOR 	= "Krieger";
	CLASS_WARLOCK 	= "Hexenmeister";
end