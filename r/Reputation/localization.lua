-- Version : English

REPUTATION_VERSION			= "Reputation Mod Version |cff00ff00%s|r";
REPUTATION_LOADED				= REPUTATION_VERSION.." Loaded.";

--Cosmos Configuration
REPUTATION_HEADER				= "Reputation";
REPUTATION_HEADER_INFO			= "Show reputation numbers.";
REPUTATION_ENABLE				= "Enable reputation.";
REPUTATION_ENABLE_INFO			= "This will activate the reputation mod.";
REPUTATION_LOADED				= "Enable load message.";
REPUTATION_LOADED_INFO			= "Show load message on startup.";
REPUTATION_RAW				= "Enable raw numbers.";
REPUTATION_RAW_INFO			= "Show Reputations as raw numbers.";
REPUTATION_FRAME				= "Chatframe";
REPUTATION_FRAME_INFO			= "Selects which chatframe reputation messages are sent to.";
REPUTATION_NOTIFICATION			= "Reputation notification.";
REPUTATION_NOTIFICATION_INFO		= "This will show reputation notifications in chat.";
REPUTATION_STANDING			= "Next standing notification.";
REPUTATION_STANDING_INFO		= "This will show reputation needed until the next standing in chat.";
REPUTATION_REPEATING			= "Repetition notification.";
REPUTATION_REPEATING_INFO		= "This will show repetitions needed until the next standing in chat.";

--Slash Commands
REPUTATION_HELP				= "help";
REPUTATION_LIST				= "list";
REPUTATION_ON				= "on";
REPUTATION_OFF				= "off";
REPUTATION_LOAD				= "load";
REPUTATION_STATUS				= "status";
REPUTATION_PCT_RAW			= "raw";
REPUTATION_FRAME				= "frame";
REPUTATION_NOTIFY				= "notify";
REPUTATION_NEXT				= "next";
REPUTATION_REPEAT				= "repeat";
REPUTATION_DEBUG				= "debug";


--Messages
REPUTATION_MOD_ON				= "Reputation Mod |cff00ff00On|r.";
REPUTATION_MOD_OFF			= "Reputation Mod |cffff0000Off|r.";
REPUTATION_LOAD_ON			= "Load Notification |cff00ff00On|r.";
REPUTATION_LOAD_OFF			= "Load Notification |cffff0000Off|r.";
REPUTATION_RAW_NUMS			= "Raw Numbers |cff00ff00On|r.";
REPUTATION_PCT_NUMS			= "Percentages |cff00ff00On|r.";
REPUTATION_INVALID_FRAME		= "Chatframe %s invalid.";
REPUTATION_VALID_FRAMES			= "Valid Frames: 1-%d.";
REPUTATION_NOTIFY_FRAME			= "Reputation Notification now set to this frame.";
REPUTATION_SEL_FRAME			= "Printing reputation messages to: |cff00ff00ChatFrame%d|r.";
REPUTATION_NOTIFY_ON			= "Reputation Notification |cff00ff00On|r.";
REPUTATION_NOTIFY_OFF			= "Reputation Notification |cffff0000Off|r.";
REPUTATION_NEXT_ON			= "Next Standing Notification |cff00ff00On|r.";
REPUTATION_NEXT_OFF			= "Next Standing Notification |cffff0000Off|r.";
REPUTATION_REPEAT_ON			= "Repetition Notification |cff00ff00On|r.";
REPUTATION_REPEAT_OFF			= "Repetition Notification |cffff0000Off|r.";
REPUTATION_DEBUG_ON			= "Debug Info |cff00ff00On|r.";


REPUTATION_HELP_TEXT0			= " ";
REPUTATION_HELP_TEXT1			= "Reputation mod help:";
REPUTATION_HELP_TEXT2			= "/reputation or /rep without any arguments displays this message.";
REPUTATION_HELP_TEXT3			= "/reputation <command> or /rep <command> to perform the following commands:";
REPUTATION_HELP_TEXT4			= "|cff00ff00"..REPUTATION_HELP.."|r: Also displays this message.";
REPUTATION_HELP_TEXT5			= "|cff00ff00"..REPUTATION_LIST.."|r: Shows current reputation values.";
REPUTATION_HELP_TEXT6			= "|cff00ff00"..REPUTATION_ON.."|r: Turns Reputation mod on.";
REPUTATION_HELP_TEXT7			= "|cff00ff00"..REPUTATION_OFF.."|r: Turns Reputation mod off.";
REPUTATION_HELP_TEXT8			= "|cff00ff00"..REPUTATION_LOAD.."|r: Toggle to display load message on startup.";
REPUTATION_HELP_TEXT9			= "|cff00ff00"..REPUTATION_STATUS.."|r: Show if reputation messaging is on or not.";
REPUTATION_HELP_TEXT10			= "|cff00ff00"..REPUTATION_PCT_RAW.."|r: Toggle between raw and percentage values.";
REPUTATION_HELP_TEXT11			= "|cff00ff00"..REPUTATION_FRAME.." #|r: Selects which chat window reputation messages are printed.";
REPUTATION_HELP_TEXT12			= "|cff00ff00"..REPUTATION_NOTIFY.."|r: Toggle to display reputation notifications.";
REPUTATION_HELP_TEXT13			= "|cff00ff00"..REPUTATION_NEXT.."|r: Toggle to display next standing information in notifications.";
REPUTATION_HELP_TEXT14			= "|cff00ff00"..REPUTATION_REPEAT.."|r: Toggle to display repetition information in notifications.";

REPUTATION_HELP_TEXT = {
	REPUTATION_HELP_TEXT0,
	REPUTATION_HELP_TEXT1,
	REPUTATION_HELP_TEXT2,
	REPUTATION_HELP_TEXT3,
	REPUTATION_HELP_TEXT4,
	REPUTATION_HELP_TEXT5,
	REPUTATION_HELP_TEXT6,
	REPUTATION_HELP_TEXT7,
	REPUTATION_HELP_TEXT8,
	REPUTATION_HELP_TEXT9,
	REPUTATION_HELP_TEXT10,
	REPUTATION_HELP_TEXT11,
	REPUTATION_HELP_TEXT12,
	REPUTATION_HELP_TEXT13,
	REPUTATION_HELP_TEXT14
};

--0=percentage, 1=raw numbers
REPUTATION_LOST0				= "Your reputation with %s has decreased by %.4f%%.";
REPUTATION_LOST1				= "Your reputation with %s has decreased by %d.";
REPUTATION_GAINED0			= "Your reputation with %s has increased by %.4f%%.";
REPUTATION_GAINED1			= "Your reputation with %s has increased by %d.";
REPUTATION_NEEDED0			= "%.4f%% reputation needed until %s with %s.";
REPUTATION_NEEDED1			= "%d reputation needed until %s with %s.";
REPUTATION_LEFT0				= "%.4f%% reputation left until %s with %s.";
REPUTATION_LEFT1				= "%d reputation left until %s with %s.";

REPUTATION_REPEATS			= "%d repetitions left until %s with %s.";

REPUTATION_REACHED			= "%s reputation reached with %s.";

if ( GetLocale() == "frFR" ) then

  -- Version : French by Eto DemerZel
  --[[
    translation helpers:
    ' = \226\128\153
    é = \195\169
    è = \195\168
    ê = \195\170
    à = \195\160
  ]]-- 
	
  REPUTATION_VERSION			= "Version de l\226\128\153add-on Reputation |cff00ff00%s|r";
  REPUTATION_LOADED			= REPUTATION_VERSION.." Charg\195\169.";

  --Cosmos Configuration
  REPUTATION_HEADER			= "R\195\169putation";
  REPUTATION_HEADER_INFO		= "Montrer les valeurs de r\195\169putation.";
  REPUTATION_ENABLE			= "Activer l\226\128\153add-on r\195\169putation.";
  REPUTATION_ENABLE_INFO		= "Ceci activera l\226\128\153add-on R\195\169putation.";
  REPUTATION_LOADED			= "Activer message de d\195\169marrage.";
  REPUTATION_LOADED_INFO		= "Afficher le message de d\195\169marrage.";
  REPUTATION_RAW				= "Afficher les valeurs en nombres enti\195\168rs.";
  REPUTATION_RAW_INFO			= "Montre la valeur de r\195\169putation en nombres entiers.";
  REPUTATION_FRAME			= "Canal de discussion";
  REPUTATION_FRAME_INFO			= "Choisir dans quel canal de discussion s\226\128\153affichent les messages de r\195\169putation.";
  REPUTATION_NOTIFICATION		= "Notification de changement de r\195\169putation.";
  REPUTATION_NOTIFICATION_INFO	= "Afficher les notifications de changement de r\195\169putation dans le canal de discussion.";
  REPUTATION_STANDING			= "Prochain niveau de r\195\169putation.";
  REPUTATION_STANDING_INFO		= "Afficher la valeur du prochain niveau de r\195\169putation dans le canal de discussion.";
  REPUTATION_REPEATING			= "Notification des r\195\169p\195\169titions.";
  REPUTATION_REPEATING_INFO		= "Affiche le nombre de r\195\169p\195\169tition n\195\169c\195\169ssaire pour atteindre le prochain rang.";

  --Slash Commands
  REPUTATION_HELP				= "aide";
  REPUTATION_LIST				= "liste";
  REPUTATION_ON				= "on";
  REPUTATION_OFF				= "off";
  REPUTATION_LOAD				= "charge";
  REPUTATION_STATUS			= "etat";
  REPUTATION_PCT_RAW			= "entier";
  REPUTATION_FRAME			= "canal";
  REPUTATION_NOTIFY			= "notification";
  REPUTATION_NEXT				= "prochain";
  REPUTATION_REPEAT			= "repeat";
  REPUTATION_DEBUG			= "debug";

  --Messages
  REPUTATION_MOD_ON			= "Add-On R\195\169putation |cff00ff00Activ\195\169|r.";
  REPUTATION_MOD_OFF			= "Add-On R\195\169putation |cffff0000D\195\169sactiv\195\169|r.";
  REPUTATION_LOAD_ON			= "Notification de chargement |cff00ff00On|r.";
  REPUTATION_LOAD_OFF			= "Notification de chargement |cffff0000Off|r.";
  REPUTATION_RAW_NUMS			= "Valeurs Enti\195\168res |cff00ff00Activ\195\169|r.";
  REPUTATION_PCT_NUMS			= "Valeur en Pourcentage |cff00ff00Activ\195\169|r.";
  REPUTATION_INVALID_FRAME		= "Canal de Discussion %s invalide.";
  REPUTATION_VALID_FRAMES		= "Canaux de discussions valides : 1-%d.";
  REPUTATION_NOTIFY_FRAME		= "Les Notifications de r\195\169patation s\226\128\153affichent dans ce canal de discussion.";
  REPUTATION_SEL_FRAME			= "Ecrire les messages de r\195\169putation dans : |cff00ff00ChatFrame%d|r.";
  REPUTATION_NOTIFY_ON			= "Notification de changement de r\195\169putation |cff00ff00Activ\195\169|r.";
  REPUTATION_NOTIFY_OFF			= "Notification de changement de r\195\169putation |cffff0000D\195\169sactiv\195\169|r.";
  REPUTATION_NEXT_ON			= "Prochain niveau de r\195\169putation |cff00ff00Activ\195\169|r.";
  REPUTATION_NEXT_OFF			= "Prochain niveau de r\195\169putation |cffff0000D\195\169sactiv\195\169|r.";
  REPUTATION_REPEAT_ON			= "Notification des r\195\169p\195\169titions |cff00ff00On|r.";
  REPUTATION_REPEAT_OFF			= "Notification des r\195\169p\195\169titions |cffff0000Off|r.";
  REPUTATION_DEBUG_ON			= "Information de d\195\169bugage |cff00ff00Activ\195\169|r.";

  REPUTATION_HELP_TEXT0			= " ";
  REPUTATION_HELP_TEXT1			= "Aide de l\226\128\153Add-On R\195\169putation:";
  REPUTATION_HELP_TEXT2			= "/reputation ou /rep sans arguments affiche ce message.";
  REPUTATION_HELP_TEXT3			= "/reputation <command> ou /rep <command> pour ex\195\169cuter les commandes suivantes:";
  REPUTATION_HELP_TEXT4			= "|cff00ff00"..REPUTATION_HELP.."|r: Affiche aussi ce message.";
  REPUTATION_HELP_TEXT5			= "|cff00ff00"..REPUTATION_LIST.."|r: Affiche les valeurs courantes de r\195\169putation.";
  REPUTATION_HELP_TEXT6			= "|cff00ff00"..REPUTATION_ON.."|r: Active l\226\128\153add-on R\195\169putation.";
  REPUTATION_HELP_TEXT7			= "|cff00ff00"..REPUTATION_OFF.."|r: D\195\169sactive l\226\128\153add-on R\195\169putation.";
  REPUTATION_HELP_TEXT8			= "|cff00ff00"..REPUTATION_LOAD.."|r: Active le message de d\195\169marrage.";
  REPUTATION_HELP_TEXT9			= "|cff00ff00"..REPUTATION_STATUS.."|r: Affiche l\226\128\153\195\169tat de l\226\128\153add-on R\195\169putation.";
  REPUTATION_HELP_TEXT10		= "|cff00ff00"..REPUTATION_PCT_RAW.."|r: Bascule entre l\226\128\153affichage des valeur en Nombres Entiers ou Pourcentage.";
  REPUTATION_HELP_TEXT11		= "|cff00ff00"..REPUTATION_FRAME.." #|r: Choisir dans quel canal de discussion s\226\128\153affichent les informations de r\195\169putation.";
  REPUTATION_HELP_TEXT12		= "|cff00ff00"..REPUTATION_NOTIFY.."|r: Bascule l\226\128\153affichage des notifications de r\195\169putation.";
  REPUTATION_HELP_TEXT13		= "|cff00ff00"..REPUTATION_NEXT.."|r: Bascule l\226\128\153affichage du prochain niveau de r\195\169putation.";
  REPUTATION_HELP_TEXT14		= "|cff00ff00"..REPUTATION_REPEAT.."|r: Active l'affichage des informations de r\195\169p\195\169titions.";

  REPUTATION_HELP_TEXT = {
  	REPUTATION_HELP_TEXT0,
  	REPUTATION_HELP_TEXT1,
  	REPUTATION_HELP_TEXT2,
  	REPUTATION_HELP_TEXT3,
  	REPUTATION_HELP_TEXT4,
  	REPUTATION_HELP_TEXT5,
  	REPUTATION_HELP_TEXT6,
  	REPUTATION_HELP_TEXT7,
  	REPUTATION_HELP_TEXT8,
  	REPUTATION_HELP_TEXT9,
  	REPUTATION_HELP_TEXT10,
  	REPUTATION_HELP_TEXT11,
  	REPUTATION_HELP_TEXT12,
  	REPUTATION_HELP_TEXT13,
  	REPUTATION_HELP_TEXT14
  };

  --0=percentage, 1=raw numbers
  REPUTATION_LOST0			= "La r\195\169putation avec %s a d\195\169crue de %.4f%%.";
  REPUTATION_LOST1			= "La r\195\169putation avec %s a d\195\169crue de %d.";
  REPUTATION_GAINED0			= "La r\195\169putation avec %s a augment\195\169 de %.4f%%.";
  REPUTATION_GAINED1			= "La r\195\169putation avec %s a augment\195\169 de %d.";
  REPUTATION_NEEDED0			= "%.4f%% de r\195\169putation n\195\169c\195\169ssaire pour devenir %s avec %s.";
  REPUTATION_NEEDED1			= "%d de r\195\169putation n\195\169c\195\169ssaire pour devenir %s avec %s.";
  REPUTATION_LEFT0			= "%.4f%% r\195\169putation restantes jusqu\226\128\153\195\160 devenir %s with %s.";
  REPUTATION_LEFT1			= "%d r\195\169putation restantes jusqu\226\128\153\195\160 devenir %s with %s.";

  REPUTATION_REPEATS			= "%d r\195\169p\195\169titions restantes jusqu\226\128\153\195\160 devenir %s avec %s.";

  REPUTATION_REACHED			= "Vous \195\170tes maintenant %s avec %s.";

elseif ( GetLocale() == "deDE" ) then


  -- Version : German by Lunox
  --[[
    translation helpers:
    ä = \195\164
    ü = \195\188
    ö = \195\182
  ]]--

  REPUTATION_VERSION			= "Reputation Mod Version |cff00ff00%s|r";
  REPUTATION_LOADED			= REPUTATION_VERSION.." geladen.";

  --Cosmos Configuration
  REPUTATION_HEADER			= "Reputation Mod";
  REPUTATION_HEADER_INFO		= "Ruf in Zahlen anzeigen.";
  REPUTATION_ENABLE			= "Reputation aktivieren.";
  REPUTATION_ENABLE_INFO		= "Dies aktiviert die Reputation Mod.";
  REPUTATION_LOADED			= "Aktiviere Lade-Nachricht.";
  REPUTATION_LOADED_INFO		= "Zeige Lade-Nachricht beim Start.";
  REPUTATION_RAW				= "Absolute Zahlen.";
  REPUTATION_RAW_INFO			= "Zeige den Ruf in absoluten Zahlen (anstatt Prozentwerten).";
  REPUTATION_FRAME			= "Chatfenster";
  REPUTATION_FRAME_INFO			= "Auswahl, in welchem Chatfenster die Rufmeldungen dargestellt werden.";
  REPUTATION_NOTIFICATION		= "Meldungen: Ruf erhalten.";
  REPUTATION_NOTIFICATION_INFO	= "Wenn aktiviert, wird im Chatfenster angezeigt, wie viel Ruf gerade erworben/verloren wurde.";
  REPUTATION_STANDING			= "Meldungen: N\195\164chste (Ruf-)Stufe.";
  REPUTATION_STANDING_INFO		= "Wenn aktiviert, wird im Chatfenster angezeigt, wie viel Ruf noch bis zur n\195\164chsten Stufe ben\195\182tigt wird.";
  REPUTATION_REPEATING			= "Meldungen: ben\195\182tigte Wiederholungen.";
  REPUTATION_REPEATING_INFO		= "Wenn aktiviert, wird im Chatfenster angezeigt, wieviele Wiederholungen bis zur n\195\164chsten Stufe n\195\182tig sind.";

  --Slash Commands
  REPUTATION_HELP				= "hilfe";
  REPUTATION_LIST				= "liste";
  REPUTATION_ON				= "an";
  REPUTATION_OFF				= "aus";
  REPUTATION_LOAD				= "load";
  REPUTATION_STATUS			= "status";
  REPUTATION_PCT_RAW			= "absolute zahlen";
  REPUTATION_FRAME			= "chatfenster";
  REPUTATION_NOTIFY			= "meldungen";
  REPUTATION_NEXT				= "stufen";
  REPUTATION_REPEAT			= "wiederholungen";
  REPUTATION_DEBUG			= "debug";


  --Messages
  REPUTATION_MOD_ON			= "Reputation Mod |cff00ff00An|r.";
  REPUTATION_MOD_OFF			= "Reputation Mod |cffff0000Aus|r.";
  REPUTATION_LOAD_ON			= "Lade-Nachricht |cff00ff00An|r.";
  REPUTATION_LOAD_OFF			= "Lade-Nachricht |cffff0000Aus|r.";
  REPUTATION_RAW_NUMS			= "Absolute Zahlen |cff00ff00An|r.";
  REPUTATION_PCT_NUMS			= "Prozentzahlen |cff00ff00An|r.";
  REPUTATION_INVALID_FRAME		= "Chatfenster %s ist ung\195\188ltig.";
  REPUTATION_VALID_FRAMES		= "G\195\188ltige Fenster: 1-%d.";
  REPUTATION_NOTIFY_FRAME		= "Rufmeldungen werden in diesem Chatfenster ausgegeben.";
  REPUTATION_SEL_FRAME			= "Ausgabe der Ruf-Meldungen in: |cff00ff00ChatFrame%d|r.";
  REPUTATION_NOTIFY_ON			= "Rufmeldungen |cff00ff00An|r.";
  REPUTATION_NOTIFY_OFF			= "Rufmeldungen |cffff0000Aus|r.";
  REPUTATION_NEXT_ON			= "Meldungen: N\195\164chste Stufe |cff00ff00An|r.";
  REPUTATION_NEXT_OFF			= "Meldungen: N\195\164chste Stufe |cffff0000Aus|r.";
  REPUTATION_REPEAT_ON			= "Meldungen: ben. Wiederholungen |cff00ff00An|r.";
  REPUTATION_REPEAT_OFF			= "Meldungen: ben. Wiederholungen |cffff0000Aus|r.";
  REPUTATION_DEBUG_ON			= "Debug Info |cff00ff00An|r.";


  REPUTATION_HELP_TEXT0			= " ";
  REPUTATION_HELP_TEXT1			= "Reputation Mod Hilfe:";
  REPUTATION_HELP_TEXT2			= "/reputation oder /rep ohne Parameter zeigt diese Meldung.";
  REPUTATION_HELP_TEXT3			= "/reputation <Befehl> oder /rep <Befehl> um die folgenden Befehle auszuf\195\188hren:";
  REPUTATION_HELP_TEXT4			= "|cff00ff00"..REPUTATION_HELP.."|r: zeigt diese Meldung.";
  REPUTATION_HELP_TEXT5			= "|cff00ff00"..REPUTATION_LIST.."|r: zeigt die aktuellen Ansehenswerte.";
  REPUTATION_HELP_TEXT6			= "|cff00ff00"..REPUTATION_ON.."|r: schaltet Reputation Mod an.";
  REPUTATION_HELP_TEXT7			= "|cff00ff00"..REPUTATION_OFF.."|r: schaltet Reputation Mod aus.";
  REPUTATION_HELP_TEXT8			= "|cff00ff00"..REPUTATION_LOAD.."|r: schaltet Lade-Nachricht an/aus.";
  REPUTATION_HELP_TEXT9			= "|cff00ff00"..REPUTATION_STATUS.."|r: zeigt, ob Ansehensmeldungen aktiviert sind oder nicht.";
  REPUTATION_HELP_TEXT10		= "|cff00ff00"..REPUTATION_PCT_RAW.."|r: schaltet zwischen Prozent- und absoluter Anzeige um.";
  REPUTATION_HELP_TEXT11		= "|cff00ff00"..REPUTATION_FRAME.." #|r: w\195\164hlt aus, in welchem Chatfenster die Meldungen angezeigt werden.";
  REPUTATION_HELP_TEXT12		= "|cff00ff00"..REPUTATION_NOTIFY.."|r: schaltet die Anzeige der erhaltenen/verlorenen Rufpunkte an/aus.";
  REPUTATION_HELP_TEXT13		= "|cff00ff00"..REPUTATION_NEXT.."|r: schaltet die Anzeige der verbleibenden Rufpunkte bis zur n\195\164chsten Rufstufe an/aus.";
  REPUTATION_HELP_TEXT14		= "|cff00ff00"..REPUTATION_REPEAT.."|r: schaltet die Anzeige der ben\195\182tigten Wiederholungen an/aus.";

  REPUTATION_HELP_TEXT = {
  	REPUTATION_HELP_TEXT0,
  	REPUTATION_HELP_TEXT1,
  	REPUTATION_HELP_TEXT2,
  	REPUTATION_HELP_TEXT3,
  	REPUTATION_HELP_TEXT4,
  	REPUTATION_HELP_TEXT5,
  	REPUTATION_HELP_TEXT6,
  	REPUTATION_HELP_TEXT7,
  	REPUTATION_HELP_TEXT8,
  	REPUTATION_HELP_TEXT9,
  	REPUTATION_HELP_TEXT10,
  	REPUTATION_HELP_TEXT11,
  	REPUTATION_HELP_TEXT12,
  	REPUTATION_HELP_TEXT13,
  	REPUTATION_HELP_TEXT14
  };

  --0=percentage, 1=raw numbers
  REPUTATION_LOST0			= "Euer Ruf bei %s ist um %.4f%% gesunken.";
  REPUTATION_LOST1			= "Euer Ruf bei %s ist um %d gesunken.";
  REPUTATION_GAINED0			= "Euer Ruf bei %s ist um %.4f%% gestiegen.";
  REPUTATION_GAINED1			= "Euer Ruf bei %s ist um %d gestiegen.";
  REPUTATION_NEEDED0			= "Noch %.4f%% Ruf f\195\188r %s bei %s ben\195\182tigt.";
  REPUTATION_NEEDED1			= "Noch %d Ruf f\195\188r %s bei %s ben\195\182tigt.";
  REPUTATION_LEFT0			= "Noch %.4f%% Ruf \195\188brig bevor %s bei %s erreicht wird.";
  REPUTATION_LEFT1			= "Noch %d Ruf \195\188brig bevor %s bei %s erreicht wird.";

  REPUTATION_REPEATS			= "%d Wiederholungen f\195\188r %s bei %s ben\195\182tigt.";

  REPUTATION_REACHED			= "%s bei %s erreicht.";

end