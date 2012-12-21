-- Version : French
-- Last Update 06/07/11
-- French Translation assistance by

if ( GetLocale() == "frFR" ) then
	-- DISPLAY_xxx variables can be anything you want to display
	-- EVERYTHING ELSE MUST MATCH THE GAME
	BINDING_NAME_BGASSIST_TOGGLE = "Toggle BGAssist Window";
	BGAssist_Alterac_Quests = {
		["Fournitures d'Irondeep"] 		 = true,
		["Fournitures de Coldtooth"] 		 = true,
		["L'Oeil qui voit tout de maître Ryson"] = true,
		["Ecuries vides"]			 = true,
		-- Horde
		["Plus de butin !"] 				= { item = 17422, min=20 },
		["Lokholar le Seigneur des Glaces"] 		= { item = 17306, max=4 },
		["Quelques litres de sang"] 			= { item = 17306, min=5 },
		["Harnais en cuir de bélier"] 			= { item = 17642 },
		["La défense des Darkspear"] 			= { item = 18142 },
		["Pour une poignée de cheuveux"] 		= { item = 18143 },
		["On recherche : PLUS DE NAINS !"] 		= { item = 18206 },
	["I've Got A Fever For More Bone Chips"]= { item = 18144 },
		["L'appel des airs - l'escadrille de Guse"]	= { item = 17326 },
		["L'appel des airs - l'escadrille de Jeztor"]	= { item = 17327 },
		["L'appel des airs - l'escadrille de Mulverick"]= { item = 17328 },
	-- Alliance
		["Plus de morceaux d'armure !"] 		= { item = 17422, min=20 },
		["Ivus le Seigneur des for\195\170ts"]		= { item = 17423, max=4 },
	["Crystal Cluster"] 			= { item = 17423, min=5 },
		["Harnais pour b\195\169liers"] 		= { item = 17643 },
		["Chasse aux sabots !"] 			= { item = 18145 },
		["La collection de mojos de Staghelm"]		= { item = 18146 },
		["On recherche : PLUS D'ORCS !"] 		= { item = 18207 },
		["L'amour d'un homme"] 				= { item = 18147 },
		["L'appel des airs - l'escadrille de Slidore"]	= { item = 17502 },
		["L'appel des airs - l'escadrille de Vipore"]	= { item = 17503 },
		["L'appel des airs - l'escadrille d'Ichman"]	= { item = 17504 },
	};
	BGAssist_FlagRegexp = {
		["RESET"] = {	["regexp"] = "The flags are now placed at their bases." },
		["PICKED"] = {	["one"] = "FACTION", ["two"] = "PLAYER",
				["regexp"] = "The ([^ ]*) flag was picked up by ([^!]*)!" },
		["DROPPED"] = {	["one"] = "FACTION", ["two"] = "PLAYER",
				["regexp"] = "The ([^ ]*) flag was dropped by ([^!]*)!" },
		["RETURNED"] ={	["one"] = "FACTION", ["two"] = "PLAYER",
				["regexp"] = "The ([^ ]*) flag was returned to its base by ([^!]*)!" },
		["CAPTURED"] ={	["one"] = "PLAYER", ["two"] = "FACTION",
				["regexp"] = "([^ ]*) captured the ([^ ]*) flag!" },
	};
	ALTERACVALLEY 	= "Vall\195\169e d'Alterac";
	WARSONGGULCH 	= "Goulet des Warsong";
	ARATHIBASIN 	= "Arathi Basin";
	DISPLAY_MENU_LOCKWINDOW 	= "Verrouiller la position de la fen\195\170tre de BGAssist";
	DISPLAY_MENU_AUTOSHOW 		= "Afficher automatiquement la fen\195\170tre de BGAssist dans le BG";
	DISPLAY_MENU_AUTORELEASE 	= "R\195\169surrection automatique au cimeti\195\168re";
	DISPLAY_MENU_AUTOQUEST 		= "Confirmer automatiquement les qu\195\170tes";
	DISPLAY_MENU_AUTOENTER 		= "Entrer automatiquement dans le BG";
	DISPLAY_MENU_TIMERSHOW 		= "Afficher le temps de capture des cimeti\195\168res et des tours";
	DISPLAY_MENU_ITEMSHOW 		= "Afficher le nombre d'items de qu\195\170tes que vous poss\195\169dez";
	DISPLAY_MENU_GYCOUNTDOWN 	= "Afficher le temps restant avant r\195\169surrection au cimeti\195\168re";
	DISPLAY_MENU_FLAGTRACKING 	= "Track Flags";
	DISPLAY_MENU_TARGETTINGASSISTANCE = "Targetting Assistance Window";
	DISPLAY_MENU_AUTOACCEPTGROUP 	= "Auto accept group invites in BG";
	DISPLAY_MENU_AUTOLEAVEGROUP 	= "Auto leave group when leaving BG";
	DISPLAY_MENU_NOPREEXISTING 	= "No pre-existing instances";
	DISPLAY_TITLETEXT_CAPTURE 	= "Capture";
	DISPLAY_TITLETEXT_ITEMS 	= "Items";
	DISPLAY_TITLEDISPLAY_TARGETS 	= "Targets";
	DISPLAY_TEXT_ENTERINGBATTLEGROUNDS = "Vous entrez dans le BG";
	DISPLAY_TEXT_LEFTBATTLEGROUNDS 	= "Vous quittez le BG";
	DISPLAY_TEXT_TIMELEFT 		= "Temps restant";
	DISPLAY_TEXT_SECONDS 		= "secondes";
	DISPLAY_TEXT_MINUTES 		= "minutes";
	DISPLAY_TEXT_NOTENTERINGAFK 	= "N'entre pas dans le BG pendant que vous \195\170tes ABS";
	DISPLAY_TEXT_FLAGHOLDERNOTCLOSEENOUGH = "Flag Holder not close enough to target.";
	DISPLAY_TEXT_PREEXISTING 	= "Offered BG instance is pre-existing";
	BATTLEGROUND_GOSSIP_TEXT 	= "I would like to go to the battleground.";
	MATCHING_MARKED_AFK 		= "You are now AFK";
	MATCHING_CLEARED_AFK 		= "You are no longer AFK.";
	FACTION_ALLIANCE 	= "Alliance";
	FACTION_HORDE 		= "Horde";
	CLASS_DRUID 	= "Druide";
	CLASS_HUNTER 	= "Chasseur";
	CLASS_MAGE 	= "Mage";
	CLASS_PALADIN 	= "Paladin"
	CLASS_PRIEST 	= "Prêtre";
	CLASS_ROGUE 	= "Voleur";
	CLASS_SHAMAN 	= "Chaman";
	CLASS_WARRIOR 	= "Guerrier";
	CLASS_WARLOCK 	= "Démoniste";
end
