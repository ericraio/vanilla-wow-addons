SPAMIAM_FILTERS = {
	ERR_ABILITY_COOLDOWN, 					-- Ability is not ready yet. (Ability)
	ERR_SPELL_COOLDOWN, 						-- Spell is not ready yet. (Spell)
	ERR_OUT_OF_ENERGY,							-- Not enough energy. (Err)
	OUT_OF_ENERGY,									-- Not enough energy.
	ERR_OUT_OF_RAGE,								-- Not enough rage.
	ERR_NO_ATTACK_TARGET,						-- There is nothing to attack.
	SPELL_FAILED_NO_COMBO_POINTS,		-- That ability requires combo points.
	SPELL_FAILED_TARGETS_DEAD,			-- Your target is dead.
	SPELL_FAILED_SPELL_IN_PROGRESS,	-- Another action is in progress. (Spell)
	SPELL_FAILED_TARGET_AURASTATE,	-- You can't do that yet. (TargetAura)
	SPELL_FAILED_CASTER_AURASTATE,	-- You can't do that yet. (CasterAura)
};
SPAMIAM_SPAMIAM = "SpamIam";
SPAMIAM_INIT1 = "SpamIam ";
SPAMIAM_V = "v";
SPAMIAM_INIT2 = " loaded. Type /SpamIam or /sia for options.";
SPAMIAM_STATUS1 = "[SpamIam is currently ";
SPAMIAM_STATUS2 = "]";
SPAMIAM_ENABLED = "enabled";
SPAMIAM_DISABLED = "disabled";
SPAMIAM_HELP = "help";
SPAMIAM_USAGE1 = "Type /SpamIam or /sia followed by one of the following commands:";
SPAMIAM_USAGE2 = "  enable - Enables SpamIam";
SPAMIAM_USAGE3 = "  disable - Disables SpamIam";
SPAMIAM_USAGE4 = "  toggle - Toggles SpamIam on/off";
SPAMIAM_USAGE5 = "  list - Shows the current filters and their ID number";
SPAMIAM_USAGE6 = "  add [message] - Adds [message] to the filter list";
SPAMIAM_USAGE7 = "  remove [id] - Removes the message [id] from the filter list";
SPAMIAM_USAGE8 = "  speechoff - Disables Error Speech";
SPAMIAM_USAGE9 = "  speechon - Enables Error Speech";
SPAMIAM_ENABLE = "enable";
SPAMIAM_DISABLE = "disable";
SPAMIAM_FILTERSCMD = "list";
SPAMIAM_ADD = "add";
SPAMIAM_REMOVE = "remove";
SPAMIAM_TOGGLE = "toggle";
SPAMIAM_SPEECHOFF = "speechoff";
SPAMIAM_SPEECHON = "speechon";
SPAMIAM_UNKNOWNCOMMAND = "SpamIam: Unknown command. Type /SpamIam or /sia for help.";
SPAMIAM_SPEECHTEXT1 = "SpamIam: Error Speech Disabled.";
SPAMIAM_SPEECHTEXT2 = "SpamIam: Error Speech Enabled.";
SPAMIAM_CURRENTFILTERS = "Current SpamIam filters:";
SPAMIAM_SLASHCOMMAND1 = "/spamiam";
SPAMIAM_SLASHCOMMAND2 = "/sia";
SPAMIAM_ADDUSAGE1 = "Usage: /SpamIam add [msg]";
SPAMIAM_ADDUSAGE2 = "Example: /SpamIam add Hello, world!";
SPAMIAM_ADDEDFILTER = "SpamIam added filter: ";
SPAMIAM_REMOVEUSAGE1 = "Usage: /SpamIam remove [id]";
SPAMIAM_REMOVEUSAGE2 = "Example: /SpamIam remove 2";
SPAMIAM_REMOVEUSAGE3 = "Use /SpamIam list to see the ID's of every filter";
SPAMIAM_FILTERNOTFOUND = "SpamIam: filter not found";
SPAMIAM_REMOVEDFILTER = "Removed filter ";
SPAMIAM_Version = "0.1";
SPAMIAM_Enabled = 1;
SI_NameRegistered = 0;
function SI_BCC(r, g, b)
	return string.format("|cff%02x%02x%02x", (r*255), (g*255), (b*255));
end
local SIC = SI_BCC(1, .6, .2);
local SIW = SI_BCC(1, 1, 1);
function SI_Print(msg)
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end
end
function SPAMIAM_OnLoad()
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	SlashCmdList["SPAMIAMCOMMAND"] = Spamiam_SlashHandler;
	SLASH_SPAMIAMCOMMAND1 = SPAMIAM_SLASHCOMMAND1;
	SLASH_SPAMIAMCOMMAND2 = SPAMIAM_SLASHCOMMAND2;
	SI_Old_UIErrorsFrame_OnEvent = UIErrorsFrame_OnEvent;
	UIErrorsFrame_OnEvent = SI_New_UIErrorsFrame_OnEvent;
end
function SPAMIAM_Localize()
	if (GetLocale() == "frFR") then
		SPAMIAM_SPAMIAM = "SpamIam";
		SPAMIAM_INIT1 = "SpamIam ";
		SPAMIAM_V = "v";
		SPAMIAM_INIT2 = " charg\195\169. Ecrivez /SpamIam ou /sia pour options.";
		SPAMIAM_STATUS1 = "[SpamIam est actuellemnt ";
		SPAMIAM_STATUS2 = "]";
		SPAMIAM_ENABLED = "activ\195\169";
		SPAMIAM_DISABLED = "d\195\169sactiv\195\169";
		SPAMIAM_HELP = "aide";
		SPAMIAM_USAGE1 = "Ecrivez /SpamIam ou /sia suivit d'une des commandes suivantes :";
		SPAMIAM_USAGE2 = "  activer - Active SpamIam";
		SPAMIAM_USAGE3 = "  d\195\169sactiver - D\195\169sactive SpamIam";
		SPAMIAM_USAGE4 = "  basculer - Basculer SpamIam en Activ\195\169/D\195\169sactiv\195\169";
		SPAMIAM_USAGE5 = "  liste - Affiche les filtres actuels et leur num\195\169ro d'ID ";
		SPAMIAM_USAGE6 = "  ajouter [message] - Ajoute [message] \195\160 la liste des filtres";
		SPAMIAM_USAGE7 = "  enlever [id] - Enl\195\168ve l'[id] du message de la liste des filtres";
		SPAMIAM_USAGE8 = "  La Parole D'Erreur De Debronchements";
		SPAMIAM_USAGE9 = "  Permet La Parole D'Erreur";
		SPAMIAM_ENABLE = "activer";
		SPAMIAM_DISABLE = "d\195\169sactiver";
		SPAMIAM_FILTERSCMD = "liste";
		SPAMIAM_ADD = "ajouter";
		SPAMIAM_REMOVE = "enlever";
		SPAMIAM_TOGGLE = "basculer";
		SPAMIAM_SPEECHOFF = "speechoff";
		SPAMIAM_SPEECHON = "speechon";
		SPAMIAM_UNKNOWNCOMMAND = "SpamIam : Commande inconnue. Ecrivez /SpamIam ou /sia pour l'aide.";
		SPAMIAM_SPEECHTEXT1 = "SpamIam: Discours D'Erreur Neutralise.";
		SPAMIAM_SPEECHTEXT2 = "SpamIam: Discours D'Erreur Permis.";
		SPAMIAM_CURRENTFILTERS = "Filtres actuels de SpamIam:";
		SPAMIAM_SLASHCOMMAND1 = "/spamiam";
		SPAMIAM_SLASHCOMMAND2 = "/sia";
		SPAMIAM_ADDUSAGE1 = "Utilisation : /SpamIam ajouter [msg]";
		SPAMIAM_ADDUSAGE2 = "Exemple : /SpamIam ajouter Bonjour tout le monde !";
		SPAMIAM_ADDEDFILTER = "SpamIam ajoute le filtre : ";
		SPAMIAM_REMOVEUSAGE1 = "Utilisation : /SpamIam enl\195\168ve l'[id]";
		SPAMIAM_REMOVEUSAGE2 = "Exemple : /SpamIam enl\195\168ve 2";
		SPAMIAM_REMOVEUSAGE3 = "Utiliser /SpamIam liste, pour voir l'ID de tous les filtres";
		SPAMIAM_FILTERNOTFOUND = "SpamIam : filtre non trouv\195\169";
		SPAMIAM_REMOVEDFILTER = "Filtre enlev\195\169 ";
	elseif (GetLocale() == "deDE") then
		SPAMIAM_INIT1 = "SpamIam ";
		SPAMIAM_V = "v";
		SPAMIAM_INIT2 = " geladen. /SpamIam oder /sia zeigt die Optionen an.";
		SPAMIAM_STATUS1 = "[SpamIam ist ";
		SPAMIAM_STATUS2 = "]";
		SPAMIAM_ENABLED = "aktiv";
		SPAMIAM_DISABLED = "inaktiv";
		SPAMIAM_HELP = "Hilfe";
		SPAMIAM_USAGE1 = "/SpamIam oder /sia mit einem der folgenden Befehle eingeben:";
		SPAMIAM_USAGE2 = " aktivieren - aktiviert SpamIam";
		SPAMIAM_USAGE3 = " deaktivieren - deaktiviert SpamIam";
		SPAMIAM_USAGE4 = " toggle - toggelt den Aktivzustand von SpamIam";
		SPAMIAM_USAGE5 = " liste - zeigt die aktuellen Filter und ihre IDs an";
		SPAMIAM_USAGE6 = " add [nachricht] - F\195\188gt [message] der Filterliste hinzu";
		SPAMIAM_USAGE7 = " remove [id] - L\195\182scht die Nachricht [id] von der Filterliste";
		SPAMIAM_USAGE8 = "  Sperrungen Storung Rede";
		SPAMIAM_USAGE9 = "  Ermoglicht Storung Rede";
		SPAMIAM_ENABLE = "aktivieren";
		SPAMIAM_DISABLE = "deaktivieren";
		SPAMIAM_FILTERSCMD = "liste";
		SPAMIAM_ADD = "add";
		SPAMIAM_REMOVE = "remove";
		SPAMIAM_TOGGLE = "toggle";
		SPAMIAM_SPEECHOFF = "speechoff";
		SPAMIAM_SPEECHON = "speechon";
		SPAMIAM_UNKNOWNCOMMAND = "SpamIam: Unbekannter Befehl. /SpamIam oder /sia zeigt die Hilfe an.";
		SPAMIAM_SPEECHTEXT1 = "SpamIam: Storung Rede Sperrte.";
		SPAMIAM_SPEECHTEXT2 = "SpamIam: Storung Rede Ermoglicht.";
		SPAMIAM_CURRENTFILTERS = "Momentane SpamIam-Filter:";
		SPAMIAM_SLASHCOMMAND1 = "/spamiam";
		SPAMIAM_SLASHCOMMAND2 = "/sia";
		SPAMIAM_ADDUSAGE1 = "Benutzung: /SpamIam add [msg]";
		SPAMIAM_ADDUSAGE2 = "Beispiel: /SpamIam add Hallo!";
		SPAMIAM_ADDEDFILTER = "SpamIam f\195\188gte folgenden Filter der Liste hinzu: ";
		SPAMIAM_REMOVEUSAGE1 = "Benutzung: /SpamIam remove [id]";
		SPAMIAM_REMOVEUSAGE2 = "Beispiel: /SpamIam remove 2";
		SPAMIAM_REMOVEUSAGE3 = "/SpamIam liste um die IDs der Filter anzeigen";
		SPAMIAM_FILTERNOTFOUND = "SpamIam: Filter nicht gefunden";
		SPAMIAM_REMOVEDFILTER = "Filter gel\195\182scht ";
	end
end
function SPAMIAM_Toggle()
	if (SPAMIAM_Enabled == 1) then
		SPAMIAM_Enabled = 0;
	else
		SPAMIAM_Enabled = 1;
	end
	SI_PrintStatus();
end
function SI_Initialize()
	this:UnregisterEvent("UNIT_NAME_UPDATE");
	this:UnregisterEvent("PLAYER_ENTERING_WORLD");
	SPAMIAM_Localize();
	if(myAddOnsList) then
		myAddOnsList.SpamIam = {
			name = "SpamIam",
			description = "",
			version = SPAMIAM_Version,
			frame = "SpamIamFrame",
			category = MYADDONS_CATEGORY_CLASS
		};
	end
	SI_Print(SIC..SPAMIAM_INIT1..SIW..SPAMIAM_V..SPAMIAM_Version..SIC..SPAMIAM_INIT2);
end
function SPAMIAM_OnEvent()
	if (event == "UNIT_NAME_UPDATE" and arg1 == "player") or (event=="PLAYER_ENTERING_WORLD") then
		if (SI_NameRegistered == 1) then
			return;
		end
		local playerName = UnitName("player");
		if (playerName ~= UNKNOWNBEING and playerName ~= "Unknown Entity" and playerName ~= nil ) then
			SI_NameRegistered = 1;
			SI_Initialize();
		end
	end
end
function SI_PrintStatus()
	s = SIC..SPAMIAM_STATUS1..SIW;
	if (SPAMIAM_Enabled == 1) then
		s = s..SPAMIAM_ENABLED;
	else
		s = s..SPAMIAM_DISABLED;
	end
	s = s..SIC..SPAMIAM_STATUS2;
	SI_Print(s);
end
function Spamiam_SlashHandler(msg, arg1, arg2)
	local omsg = msg;
	if (msg) then
		msg = string.lower(msg);
		if (msg == "" or msg == SPAMIAM_HELP) then
			SI_Print(SIC..SPAMIAM_USAGE1);
			SI_Print(SIC..SPAMIAM_USAGE2);
			SI_Print(SIC..SPAMIAM_USAGE3);
			SI_Print(SIC..SPAMIAM_USAGE4);
			SI_Print(SIC..SPAMIAM_USAGE5);
			SI_Print(SIC..SPAMIAM_USAGE6);
			SI_Print(SIC..SPAMIAM_USAGE7);
			SI_Print(SIC..SPAMIAM_USAGE8);
			SI_Print(SIC..SPAMIAM_USAGE9);
			SI_PrintStatus();
		elseif (msg == SPAMIAM_SPEECHOFF) then	
			SetCVar("EnableErrorSpeech", 0);
			SI_Print(SPAMIAM_SPEECHTEXT1);
		elseif (msg == SPAMIAM_SPEECHON) then
			SetCVar("EnableErrorSpeech", 1);
			SI_Print(SPAMIAM_SPEECHTEXT2);
		elseif (msg == SPAMIAM_DISABLE) then
			SPAMIAM_Enabled = 0;
			SI_PrintStatus();
		elseif (msg == SPAMIAM_ENABLE) then
			SPAMIAM_Enabled = 1;
			SI_PrintStatus();
		elseif (msg == SPAMIAM_FILTERSCMD) then
			SI_Print(SIW..SPAMIAM_CURRENTFILTERS);
			for key, text in SPAMIAM_FILTERS do
				SI_Print(SIC.."  ["..SIW..key..SIC.."] "..text);
			end
		elseif (msg == SPAMIAM_TOGGLE) then
			SPAMIAM_Toggle();
		elseif (string.sub(msg, 1, string.len(SPAMIAM_ADD)) == SPAMIAM_ADD) then
			if (string.sub(msg, 1, (string.len(SPAMIAM_ADD)+1)) ~= (SPAMIAM_ADD.." ")) then
				SI_Print(SPAMIAM_ADDUSAGE1);
				SI_Print(SPAMIAM_ADDUSAGE2);
			else
				str = string.sub(omsg, (string.len(SPAMIAM_ADD)+2), -1);
				table.insert(SPAMIAM_FILTERS, str);
				SI_Print(SIC..SPAMIAM_ADDEDFILTER..SIW..str);
			end
		elseif (string.sub(msg, 1, string.len(SPAMIAM_REMOVE)) == SPAMIAM_REMOVE) then
			if (string.sub(msg, 1, (string.len(SPAMIAM_REMOVE)+1)) ~= (SPAMIAM_REMOVE.." ")) then
				SI_Print(SPAMIAM_REMOVEUSAGE1);
				SI_Print(SPAMIAM_REMOVEUSAGE2);
				SI_Print(SPAMIAM_REMOVEUSAGE3);
			else
				str = string.sub(omsg, (string.len(SPAMIAM_REMOVE)+2), -1);
				for key, text in SPAMIAM_FILTERS do
					if (key == tonumber(str)) then
						table.remove(SPAMIAM_FILTERS, key);
						SI_Print(SIC..SPAMIAM_REMOVEDFILTER..SIW..text);
						return;
					end
				end
				SI_Print(SPAMIAM_FILTERNOTFOUND);
			end
		else
			SI_Print(SPAMIAM_UNKNOWNCOMMAND);
		end
	end
end
function SI_New_UIErrorsFrame_OnEvent(event, message, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
	if (SPAMIAM_Enabled == 1) then
		for key, text in SPAMIAM_FILTERS do
			if (text and message) then if (message == text) then return; end end
		end
	end
	SI_Old_UIErrorsFrame_OnEvent(event, message, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
end
