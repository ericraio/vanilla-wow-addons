-- German translation by MeKyle

local BGInvite_version = "2.4.5.1";
BGINVITE_TITLE = "BGInvite v"..BGInvite_version;

		BGINVITE_CHANNELS = {
		{ name = "[0] - Say", id = nil, type="SAY"; },
		{ name = "[1] - General", id = 1, type="CHANNEL" }
		};

		BGINVITE_TAB_OPTIONS = "Options"
		BGINVITE_AUTOINVITE = "Auto Invite"
		BGINVITE_AUTOPURGE = "Purge"
		BGINVITE_WHISPER = "Whisper"
		
		
		BGINVITE_MAGIC_WORD = "Magic word"
		CHANGE_BGINVITE_MAGIC_WORD = "Change Magic word"
		
		BGINVITE_CHANNEL_NOTE = "Chat location to send BGInvite messages";
		
		BGINVITE_SET = "Set"
		BGINVITE_CHANGE = "Change"
		BGINVITE_DEFAULT = "Default"
		BGINVITE_SEND_INVITES = "Send invites"
		BGINVITE_PROMOTE_ALL = "Promote All"
		BGINVITE_DEMOTE_ALL = "Demote All"
		BGINVITE_HELP = "Help"
		BGINVITE_LEAVE_YOUR_GROUP = "Please leave your group for Raid invite";
		
		BGINVITE_ADD_PLAYER_TO_BLACKLIST = "Add Player to Blacklist"
		
		BGlocal_BLANK_DECLINES_YOUR_INVITATION 		= 	"%s declines your group invitation"
		BGlocal_BLANK_DECLINES_YOUR_INVITATION_FIND	=	"^(%w+) declines your group invitation."
		BGlocal_BLANK_IS_IGNORING_YOU 			= 	"%s is ignoring you"
		BGlocal_BLANK_IS_IGNORING_YOU_FIND		= 	"^(%w+) is ignoring you."
		BGlocal_BLANK_HAS_JOINED_THE_RAID 		= 	"%w+ has joined the raid group"
		BGlocal_BLANK_HAS_JOINED_THE_RAID_FIND		=	"^(%w+) has joined the raid group"
		BGlocal_BLANK_HAS_JOINED_THE_PARTY		=	"%w+ joins the party."
		BGlocal_BLANK_HAS_JOINED_THE_PARTY_FIND		=	"^(%w+) joins the party."
		BGlocal_BLANK_IS_ALREADY_IN_GROUP		=	"%s is already in a group"
		BGlocal_BLANK_IS_ALREADY_IN_GROUP_FIND		=	"^(%w+) is already in a group."
		BGlocal_YOU_JOINED_RAID_GROUP			=	"You have joined a raid group"
		BGlocal_YOU_HAVE_INVITED			=	"You have invited %w+ to join your group."
		BGlocal_YOU_HAVE_INVITED_FIND			=	"You have invited (%w+) to join your group."
		BGlocal_BG_WARSONG				=	"Warsong Gulch"
		BGlocal_BG_ALTERAC				=	"Alterac Valley"
		BGlocal_BG_ARATHI				=	"Arathi Basin"

		BGINVITE_COOLDOWN_NOTE = "This is the amount of time\nthat must pass before BGInvite\nwill attempt to re-invite\na player to the raid\nwho previously failed to join\n(20 seconds recommended)"
		BGINVITE_COOLDOWN = "Invite Retry Cooldown";
		BGINVITE_PURGE_COOLDOWN_NOTE = "This is the amount of time\nthat must pass before BGInvite\nwill attempt to purge from the raid\na players who have left the battleground"
		BGINVITE_PURGE_COOLDOWN = "Purge Retry Cooldown";
		BGINVITE_MAX_INVITES_NOTE = "The maximum number of times BGInvite\nwill attempt to contact a user who is\nis on the blacklist";
		BGINVITE_MAX_INVITES = "Max retries";
		BGINVITE_SENDINVITES_NOTE = "Send invites to everybody on the Battleground who is not already in your raid";
		BGINVITE_INVITE_COOLDOWN_NOTE = "The number of seconds BGInvite will pause\nbetween sending out invites to players";
		BGINVITE_INVITE_COOLDOWN = "Invites Cooldown";
		BGINVITE_PROMOTE_NOTE = "Promote everybody in the raid to Officer";
		BGINVITE_DEMOTE_NOTE = "Demote everybody in the raid to member";
		BGINVITE_WHISPER_NOTE = "Send whispers to players who are\nalready in a group.";
		
		BGINVITE_DISABLE = "Disable BGInvite";
		BGINVITE_DISABLE_NOTE = "Disable BGInvite";
		
		BGINVITE_AUTOINVITE_NOTE = "Send out auto invites for players to join your raid/party";
		BGINVITE_AUTOPURGE_NOTE = "Purge players from your raid that have left the Battleground";
		
		BGINVITE_CLEAR_BLACKLIST = "Clear Blacklist";
		BGINVITE_CLEAR_BL_NOTE = "Clear the list of players on the blacklist (due to Already in Group or Declined)";
		
		BGINVITE_ALREADY_IN_GROUP = "Already in a group";
		BGINVITE_DECLINED = "Declined";
		
		BGINVITE_MANUAL_ADD = "Manually Added";
		
		BGlocal_NOW_PURGING				=	"Now purging the group whenever you check the scores! Note: Due to issues with lag, it may be necesary to refresh the scores twice for a purge to take effect."
		BGlocal_NOT_PURGING				=	"No longer purging the group"
		BGlocal_AUTO_INVITING				=	"Automatically inviting newcomers"
		BGlocal_NOT_AUTO_INVITING			=	"Not auto-inviting newcomers"
		BGlocal_BLACKLISTED_PLAYERS			=	"Blacklisted players"
		BGlocal_SAY_INVITING				=	"[BGinvite] Leave your groups if you would like invites (assuming the raid hasn't already been created)."
		BGlocal_CONVERTING_TO_RAID			=	"Converting to raid"
		BGlocal_PURGING_PLAYERS				=	"Purging old players"
		BGlocal_ERROR_SCANNING				=	"Error scanning players, please refresh scoreboard"
		BGlocal_YOU_APPEAR_GONE				=	"[BGinvite] You no longer appear to be in the BG instance and have been removed to make room for others. You will automatically be reinvited if you return."
		BGlocal_HELP_ERR				=	"Type '/bginvite help' for a listing of [BGinvite] commands"
		BINDING_NAME_BG_PROMOTE_ALL			=	"Promote all"
		BINDING_NAME_BG_DEMOTE_ALL			=	"Demote all"
		BINDING_HEADER_BGINVITE				=	"BGInvite"
		BINDING_NAME_BG_SEND_INVITE			=	"Send Invites"
		
		BGINVITE_SECONDS = " seconds";
		BGINVITE_RETRIES = " retries";

	if ( GetLocale() == "deDE" ) then
-- Many thanks to Ninjamask for supplying the German translation
-- German Character replace table for Localisation:
-- \195\132 Ä -- \195\164 ä
-- \195\150 Ö -- \195\182 ö
-- \195\156 Ü -- \195\188 ü
-- \195\159 ß
		BGINVITE_CHANNELS = {
		{ name = "[0] - Say", id = nil, type="SAY"; },
		{ name = "[1] - Allgemein", id = 1, type="CHANNEL" }
		};

		BGINVITE_TAB_OPTIONS 		= "Optionen"
		BGINVITE_AUTOINVITE		= "Autom. einladen"
		BGINVITE_AUTOPURGE 		= "Autom. entfernen"
		BGINVITE_WHISPER 		= "Fl\195\188stern"
		
		BGINVITE_CHANNEL_NOTE 		= "Chatchannel f\195\188r [BGInvite] Nachrichten";
		
		BGINVITE_MAGIC_WORD 		= "Magisches Wort"
		CHANGE_BGINVITE_MAGIC_WORD 	= "Magisches Word \195\164ndern"
		
		BGINVITE_SET 			= "Setzen"
		BGINVITE_CHANGE 		= "\195\132ndern"
		BGINVITE_DEFAULT 		= "Standard"
		BGINVITE_SEND_INVITES 		= "Sende Einladungen"
		BGINVITE_PROMOTE_ALL 		= "Alle bef\195\182rdern"
		BGINVITE_DEMOTE_ALL 		= "Alle herabstufen"
		BGINVITE_HELP 			= "Hilfe"
		BGINVITE_LEAVE_YOUR_GROUP 	= "Bitte verlasse deine Gruppe, damit du in die Schlachtgruppe eingeladen werden kannst.";
		
		BGINVITE_ADD_PLAYER_TO_BLACKLIST = "Spieler zur schwarzen Liste hinzuf\195\188gen."
		
		BGlocal_BLANK_DECLINES_YOUR_INVITATION		=   "%s lehnt Eure Einladung in die Gruppe ab."
		BGlocal_BLANK_DECLINES_YOUR_INVITATION_FIND	=   "^(%w+) lehnt Eure Einladung in die Gruppe ab."
		BGlocal_BLANK_IS_IGNORING_YOU			=   "%s ignoriert Euch."
		BGlocal_BLANK_IS_IGNORING_YOU_FIND		=   "^(%w+) ignoriert Euch."
		BGlocal_BLANK_HAS_JOINED_THE_RAID		=   "%w+ hat sich der Schlachtgruppe angeschlossen."
		BGlocal_BLANK_HAS_JOINED_THE_RAID_FIND		=   "^(%w+) hat sich der Schlachtgruppe angeschlossen."
		BGlocal_BLANK_HAS_JOINED_THE_PARTY		=   "%w+ schlie\195\159t sich der Gruppe an."
		BGlocal_BLANK_HAS_JOINED_THE_PARTY_FIND		=   "^(%w+) schlie\195\159t sich der Gruppe an."
		BGlocal_BLANK_IS_ALREADY_IN_GROUP		=   "%s geh\195\182rt bereits zu einer Gruppe."
		BGlocal_BLANK_IS_ALREADY_IN_GROUP_FIND		=   "^(%w+) geh\195\182rt bereits zu einer Gruppe."
		BGlocal_YOU_JOINED_RAID_GROUP			=   "Ihr habt Euch einer Schlachtgruppe angeschlossen."
		BGlocal_YOU_HAVE_INVITED 			=   "Ihr habt %w+ eingeladen, sich Eurer Gruppe anzuschlie\195\159en."
		BGlocal_YOU_HAVE_INVITED_FIND			=   "Ihr habt (%w+) eingeladen, sich Eurer Gruppe anzuschlie\195\159en."
		BGlocal_BG_WARSONG				=   "Warsongschlucht"
		BGlocal_BG_ALTERAC				=   "Alteractal"
		BGlocal_BG_ARATHI				=   "Arathibecken"

		BGINVITE_COOLDOWN_NOTE 		= "This is the amount of time\nthat must pass before BGInvite\nwill attempt to re-invite\na player to the raid\nwho previously failed to join\n(20 seconds recommended)"
		BGINVITE_COOLDOWN 		= "Invite Retry Cooldown";
		BGINVITE_PURGE_COOLDOWN_NOTE 	= "This is the amount of time\nthat must pass before BGInvite\nwill attempt to purge from the raid\na players who have left the battleground"
		BGINVITE_PURGE_COOLDOWN 	= "Purge Retry Cooldown";
		BGINVITE_MAX_INVITES_NOTE 	= "Die maximale Anzahl an Versuchen die BGInvite versucht einen Spieler zu kontaktieren, welcher nicht auf der schwarzen Liste ist.";
		BGINVITE_MAX_INVITES 		= "Max Wiederholungen";
		BGINVITE_SENDINVITES_NOTE 	= "Sende Einladungen an jeden im Schlachtfeld der noch nicht in deiner Raidgruppe ist.";
		BGINVITE_INVITE_COOLDOWN_NOTE 	= "Die Anzahl der Sekunden, die BGInvite pausiert zwischen\ndem versenden von Einladungen an Spieler.";
		BGINVITE_INVITE_COOLDOWN 	= "Einladungen alle:";
		BGINVITE_PROMOTE_NOTE 		= "Bef\195\182rdert alle in der Schlachtgruppe zum Offizier.";
		BGINVITE_DEMOTE_NOTE 		= "Stuft alle in der Schlachtgruppe zum Mitglied zur\195\188ck.";
		BGINVITE_WHISPER_NOTE 		= "Fl\195\188stere Spieler an die bereits in einer Gruppe sind.";
		BGINVITE_DISABLE 		= "BGInvite aus";
		BGINVITE_DISABLE_NOTE 		= "Schaltet BGInvite aus.";

		BGINVITE_AUTOINVITE_NOTE 	= "Versende Einladungen an Spieler die deiner Raidgruppe beitreten k\195\182nnen.";
		BGINVITE_AUTOPURGE_NOTE 	= "Entferne Spieler von deiner Raidgruppe die das Schlachtfeld verlassen haben.";
		
		BGINVITE_CLEAR_BLACKLIST 	= "Schwarze Liste leeren";
		BGINVITE_CLEAR_BL_NOTE 		= "Leert die schwarze Liste.";

		BGINVITE_ALREADY_IN_GROUP 	= "Schon in einer Gruppe";
		BGINVITE_DECLINED 		= "Abgelehnt";
		
		BGINVITE_MANUAL_ADD 		= "Manuell hinzugef\195\188gt";
		
		BGlocal_NOW_PURGING				=   "Gruppe wird nun bereinigt sobald du die Punktetafel \195\182ffnest! Hinfeis: Bei lag's, k\195\182nnte es notwendig sein die Punktetafel zwei mal zu aktualisieren, damit die bereinigung wirkt."
		BGlocal_NOT_PURGING				=   "Gruppe wird nicht mehr bereinigt"
		BGlocal_AUTO_INVITING				=   "Automatisches Einladen von Neuank\195\182mmlingen"
		BGlocal_NOT_AUTO_INVITING			=   "Kein automatisches Einladen von Neuank\195\182mmlingen"
		BGlocal_BLACKLISTED_PLAYERS			=   "Blacklisted Spieler"
		BGlocal_SAY_INVITING				=   "[BGinvite] Verlasst eure Gruppen wenn ihr eingeladen werden wollt (Sofern der Raid nicht bereits erstellt wurde)."
		BGlocal_CONVERTING_TO_RAID			=   "Konvertiere zu Raid"
		BGlocal_PURGING_PLAYERS				=   "Bereinige alte Spieler"
		BGlocal_ERROR_SCANNING				=   "Fehler beim Spieler scan, Bitte Anzeigetafel aktualisieren"
		BGlocal_YOU_APPEAR_GONE				=   "[BGinvite] Du scheinst dich nicht l\195\164nger in der Schlachtfeld-Instanz zu befinden und wurdest entfernt um platz f\195\188r andere Spieler zu schaffen. Du wirst automatisch erneut eingeladen sobald du zur\195\188ckkehrst."
		BGlocal_HELP_ERR				=   "Tippe '/bginvite help' f\195\188r eine Auflistung von [BGinvite] commands"

		BINDING_NAME_BG_PROMOTE_ALL	= "Alle bef\195\182rdern"
		BINDING_NAME_BG_DEMOTE_ALL	= "Alle zur\195\188ckstufen"
		BINDING_HEADER_BGINVITE		= "BGInvite"
		BINDING_NAME_BG_SEND_INVITE	= "Sende Einladungen"

		BGINVITE_SECONDS = " Sek.";
		BGINVITE_RETRIES = " mal";		
	end


