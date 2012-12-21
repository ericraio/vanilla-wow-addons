SCCN_VER = "1.8";
SCCN_LOCAL_CLASS = {};
SCCN_HELP = {};
SCCN_CMDSTATUS = {};
SCCN_STRIPCHAN = {};
SCCN_CUSTOM_INV = {};
SCCN_LOCAL_ZONE = {};
-- key binding header
BINDING_HEADER_SCCNKEY			= "|cffaad372".."Sol".."|cfffff468".."CCN".."|cffffffff Key Bindings";
BINDING_NAME_SAYMESSAGE      	= "/say";
BINDING_NAME_YELLMESSAGE      	= "/yell";
BINDING_NAME_PARTYMESSAGE     	= "/party";
BINDING_NAME_GUILDMESSAGE     	= "/guild";
BINDING_NAME_RAIDMESSAGE      	= "/raid";
BINDING_NAME_OFFICERMESSAGE     = "/officer";
BINDING_NAME_CC6_MESSAGE		= "/6";
BINDING_NAME_CC7_MESSAGE		= "/7";
BINDING_NAME_CC8_MESSAGE		= "/8";
BINDING_NAME_CC9_MESSAGE		= "/9";
BINDING_NAME_CC10_MESSAGE		= "/10";
BINDING_NAME_WT_MESSAGE			= "/wt (whisper Target)";



-- General info, could be overwritten by translation:
SCCN_WELCOME = "|cff68ccefAddon:|cffCDCDCD Solariz Color Chat Nick's\n";
SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefVersion:|cffCDCDCD "..SCCN_VER.."\n\n";	
SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefAbout:|cffCDCDCD\nThank's for using SCCN. As far as you now nearly every WOW addon is coded in a privat persons sparetime so if you like it feel free to tell others about it, if you dislike something please poste me a short note on my webpage or on the curse Gaming SCCN Projekt page.\n\nYou can find the Curse projekt page by typing SCCN into the searchbox on www.curse-gaming.com or on my private webpage www.soalriz.de\n\nIf you find this Addon usefull please give me a vote @ curse !\n\nFor Information how to use this Addon, please type: |cffFF0000/SCCN\n\n\n";
SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefAuthor:|cffCDCDCD Marco `sOLARiZ`Goetze\n";
SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefAuthor's Webpage:|cffCDCDCD www.SOLARIZ.de\n";
SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefAuthor's Realm:|cffCDCDCD EU-Aegwynn\n";
SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefAuthor's Charname:|cffCDCDCD SkyHawk\n";
SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefAuthor's Class:|cffCDCDCD Druid\n";
SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefAuthor's Guild:|cffCDCDCD United, Alliance\n";
SCCN_LASTCHANGED = "|cff68ccefChanges for Version "..SCCN_VER.."\n\n|cffCDCDCD";
-- NEW
SCCN_LASTCHANGED = SCCN_LASTCHANGED.."|cff10ff10";
SCCN_LASTCHANGED = SCCN_LASTCHANGED.."- new: Added GUI for specifying own channel replacement words. (shortchanname)\n";
SCCN_LASTCHANGED = SCCN_LASTCHANGED.."- new: Added option for toggeling gossip skip to GUI\n";
SCCN_LASTCHANGED = SCCN_LASTCHANGED.."- new: same for Autodismount\n";
SCCN_LASTCHANGED = SCCN_LASTCHANGED.."- new: command /SCCN autodismount\n";
SCCN_LASTCHANGED = SCCN_LASTCHANGED.."- new: command /SCCN autogossipskip\n";

-- UPD
SCCN_LASTCHANGED = SCCN_LASTCHANGED.."|cff68ccef";
SCCN_LASTCHANGED = SCCN_LASTCHANGED.."- upd: diz. text of invite and <alt> was swapped\n";
SCCN_LASTCHANGED = SCCN_LASTCHANGED.."- upd: removed Zoning Time display, if you need it use catalyst\n";
SCCN_LASTCHANGED = SCCN_LASTCHANGED.."- upd: added KeyBindung for Chat /9 & /10\n";
SCCN_LASTCHANGED = SCCN_LASTCHANGED.."- upd: Gossip Taxi detected msg removed\n";
SCCN_LASTCHANGED = SCCN_LASTCHANGED.."- upd: guild channel was not hidden in hidechannames\n";



--==============
--=   GERMAN   =
--==============
if ( GetLocale() == "deDE" ) then
	SCCN_GUI_HIGHLIGHT1				= "In diesem Dialog können Wörter angegeben werden welche SCCN hervorheben soll.";
	SCCN_LOCAL_CLASS["WARLOCK"] 	= "Hexenmeister";
	SCCN_LOCAL_CLASS["HUNTER"] 		= "J\195\164ger";
	SCCN_LOCAL_CLASS["PRIEST"] 		= "Priester";
	SCCN_LOCAL_CLASS["PALADIN"] 	= "Paladin";
	SCCN_LOCAL_CLASS["MAGE"] 		= "Magier";
	SCCN_LOCAL_CLASS["ROGUE"] 		= "Schurke";
	SCCN_LOCAL_CLASS["DRUID"] 		= "Druide";
	SCCN_LOCAL_CLASS["SHAMAN"] 		= "Schamane";
	SCCN_LOCAL_CLASS["WARRIOR"] 	= "Krieger";
	SCCN_LOCAL_ZONE["alterac"]	= "Alteractal";
	SCCN_LOCAL_ZONE["warsong"]	= "Warsongschlucht";
	SCCN_LOCAL_ZONE["arathi"]	= "Arathibecken";
	SCCN_CONFAB					= "|cffff0000Das 'confab' Addon wurde gefunden. SCCN Editbox Kontrolle wurde aus kompatibilitätsgründen deaktiviert!";
	SCCN_HELP[1]					= "Sol's Color chat Nicks - Command Hilfe:";
	SCCN_HELP[2]					= "|cff68ccef".."/SCCN hidechanname ".."|cffffffff".." Chat Kanalname wird ein/ausgeblendet";
	SCCN_HELP[3]					= "|cff68ccef".."/SCCN colornicks ".."|cffffffff".." Chat Nicknames nach Klasse färben  ein/ausschalten";
	SCCN_HELP[4]					= "|cff68ccef".."/SCCN purge".."|cffffffff".." Datenbank aufräumen. |cffa0a0a0(passiert auch automatisch wenn das Addon geladen wird)";
	SCCN_HELP[5]					= "|cff68ccef".."/SCCN killdb".."|cffffffff".." Datenbank komplett leeren. (kann nicht rückgängig gemacht werden)";
	SCCN_HELP[6]					= "|cff68ccef".."/SCCN mousescroll".."|cffffffff".." Im Chatfenster per Mausrad Scrollen ein/ausschalten. |cffa0a0a0(SHIFT-Mausrad = Schnelles scrollen, STRG-Mausrad = Anfang, Ende)";
	SCCN_HELP[7]					= "|cff68ccef".."/SCCN topeditbox".."|cffffffff".." Chat Eingabefeld oberhalb des chatfensters.";	
	SCCN_HELP[8]					= "|cff68ccef".."/SCCN timestamp".."|cffffffff".." Zeigt eine 24h Timestamp vor Chatnachrichten. SS:MM";
	SCCN_HELP[9]					= "|cff68ccef".."/SCCN colormap".."|cffffffff".." Raidmitglieder auf der Karte in Klassenfarbe darstellen.";	
	SCCN_HELP[10]					= "|cff68ccef".."/SCCN hyperlink".."|cffffffff".." Hyperlinks im Chat klickbar machen.";
	SCCN_HELP[11]					= "|cff68ccef".."/SCCN selfhighlight".."|cffffffff".." Eigenen namen in Chats hervorheben.";	
	SCCN_HELP[12]					= "|cff68ccef".."/SCCN clickinvite".."|cffffffff".." Macht das Wort [invite] im Chat klickbar. (Einladung bei Klick).";	
	SCCN_HELP[13]					= "|cff68ccef".."/SCCN editboxkeys".."|cffffffff".." Chat Editbox tasten ohne <ALT> nutzen & History buffer vergößern.";
	SCCN_HELP[14]					= "|cff68ccef".."/SCCN chatstring".."|cffffffff".." Angepasste Chat Zeichenketten.";	
	SCCN_HELP[15]					= "|cff68ccef".."/SCCN selfhighlightmsg".."|cffffffff".." OnScreen Ausgabe von Chatmeldungen mit eigenem Nickname.";	
	SCCN_HELP[16]					= "|cff68ccef".."/SCCN hidechatbuttons".."|cffffffff".." Chat Buttons ausblenden.";	
	SCCN_HELP[17]					= "|cff68ccef".."/SCCN highlight".."|cffffffff".." Angepasste Filter zur Hervorhebung von Worten im Chat.";
	SCCN_HELP[18]					= "|cff68ccef".."/SCCN AutoBGMap".."|cffffffff".." BGMinimap Autopupup.";
	SCCN_HELP[19]					= "|cff68ccef".."/SCCN shortchanname ".."|cffffffff".." Chat Kanalname wird verkürzt dargestellt";
	SCCN_HELP[20]					= "|cff68ccef".."/SCCN autogossipskip ".."|cffffffff".." Die info Fenster bei NPC's werden übersprungen. |cffa0a0a0(<STRG> drücken um kurzzeitig zu deaktivieren)";
	SCCN_HELP[21]					= "|cff68ccef".."/SCCN autodismount ".."|cffffffff".." Bei Flugpunkt NPC's wird automatisch vom Reittier abgestiegen.";
	SCCN_HELP[99]					= "|cff68ccef".."/SCCN status".."|cffffffff".." Aktuelle Einstellungen zeigen.";
	SCCN_TS_HELP					= "|cff68ccef".."/SCCN timestamp |cffFF0000FORMAT|cffffffff\n".."FORMAT:\n$h = Stunde (0-24) \n$t = Stunde (0-12) \n$m = Minute \n$s = Sekunde \n$p = Periode (am / pm)\n".."|cff909090Beispiel: /SCCN timestamp [$t:$m:$s $p]";
	SCCN_CMDSTATUS[1]				= "Kanalname ausblenden:";
	SCCN_CMDSTATUS[2]				= "Chat Nicknames in Klassenfarbe:";
	SCCN_CMDSTATUS[3]				= "Im Chat per Mausrad Scrollen:";
	SCCN_CMDSTATUS[4]				= "Chat Eingabefeld oben:";
	SCCN_CMDSTATUS[5]				= "Chat Timestamp:";
	SCCN_CMDSTATUS[6]				= "Spielerpins auf Karte in Klassenfarbe:";
	SCCN_CMDSTATUS[7]				= "Klickbare Hyperlinks:";
	SCCN_CMDSTATUS[8]				= "Eigenen Namen hervorheben:";
	SCCN_CMDSTATUS[9]				= "Click Invite:";
	SCCN_CMDSTATUS[10]				= "Chat Editbox Tasten ohne <alt> nutzen:";
	SCCN_CMDSTATUS[11]				= "Angepasste Chat Zeichenkette.";
	SCCN_CMDSTATUS[12]				= "Chatnachrichten OnScreen:";
	SCCN_CMDSTATUS[13]				= "Chat Buttons ausblenden:";
	SCCN_CMDSTATUS[14]				= "Automatischer Popup der Schlachtfeld MiniKarte:";
	SCCN_CMDSTATUS[15]				= "Angepasster Highlightfilter:";
	SCCN_CMDSTATUS[16]				= "Kanalname verkürzen:";
	SCCN_CMDSTATUS[17]				= "Auto Gossip Skip:";
	SCCN_CMDSTATUS[18]				= "Auto Dismount:";
	
	
	
	-- cursom invite word in the local language
	SCCN_CUSTOM_INV[0] 				= "einladen";	
	SCCN_CUSTOM_INV[1] 				= "inviten";
	-- Whispers customized
	SCCN_CUSTOM_CHT_FROM			= "von %s:";
	SCCN_CUSTOM_CHT_TO				= "zu %s:";		
	-- hide this channels aditional, feel free to add your own	
	SCCN_STRIPCHAN[1]				= "Gilde";
	SCCN_STRIPCHAN[2]				= "Schlachtzug";
	SCCN_STRIPCHAN[3]				= "Gruppe";
	SCCN_STRIPCHAN[4]				= "WeltVerteidigung";
	SCCN_STRIPCHAN[5]				= "Offizier";
	SCCN_WELCOME = "|cff68ccefAddon:|cffCDCDCD Solariz Color Chat Nick's\n";
	SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefVersion:|cffCDCDCD "..SCCN_VER.."\n\n";	
	SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefÜber:|cffCDCDCD\nDanke das Du SCCN nutzt. Wie Du sicherlich weisst wurde nahezu jedes WOW Addon durch eine private Person in deren Freizeit unentgeldlich programmiert. Daher; Wenn dir dieses Addon gefällt erzähle bitte anderen davon, gibt es Funktionen die dir nicht gefallen so bitte ich Dich mir eine kurze Notiz darüber zu hinterlassen. Dies kannst du entweder auf meiner Webseite www.solariz.de oder auf der www.Curse-Gaming.com Projektseite. (Dort einfach nach SCCN suchen)\n\nFindest du dieses Addon nützlich vote bitte für mich auf Curse-Gaming !\n\nFür Info's zur Bedienung des Addons gibt bitte folgendes Kommando ein: |cffFF0000/SCCN\n\n\n";
	SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefAutor:|cffCDCDCD Marco `sOLARiZ`Goetze\n";
	SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefAutor's Webseite:|cffCDCDCD www.SOLARIZ.de\n";
	SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefAutor's Realm:|cffCDCDCD EU-Aegwynn\n";
	SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefAutor's Charname:|cffCDCDCD SkyHawk\n";
	SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefAutor's Klass:|cffCDCDCD Druid\n";
	SCCN_WELCOME = SCCN_WELCOME.."|cff68ccefAutor's Gilde:|cffCDCDCD United, Alliance\n";


	

--==============
--= FRENCH =
--==============
-- French Translation by Sasmira
-- Sasmira's Profile: http://forums.curse-gaming.com/member.php?u=2633
-- Last Update 01/31/2006
-- Thank's alot !!!
elseif ( GetLocale() == "frFR" ) then
	SCCN_GUI_HIGHLIGHT1				= "In this Dialogue you can enter Words which SCCN should Highlight. Each Line is one Word.";
	SCCN_LOCAL_CLASS["WARLOCK"] = "D\195\169moniste";
	SCCN_LOCAL_CLASS["HUNTER"] = "Chasseur";
	SCCN_LOCAL_CLASS["PRIEST"] = "Pr\195\170tre";
	SCCN_LOCAL_CLASS["PALADIN"] = "Paladin";
	SCCN_LOCAL_CLASS["MAGE"] = "Mage";
	SCCN_LOCAL_CLASS["ROGUE"] = "Voleur";
	SCCN_LOCAL_CLASS["DRUID"] = "Druide";
	SCCN_LOCAL_CLASS["SHAMAN"] = "Chaman";
	SCCN_LOCAL_CLASS["WARRIOR"] = "Guerrier";
	-- Zones, partly Translation Needed
	SCCN_LOCAL_ZONE["alterac"]	= "Vall\195\169e d'Alterac";
	SCCN_LOCAL_ZONE["warsong"]	= "Goulet des Warsong";
	SCCN_LOCAL_ZONE["arathi"]	= "Arathi Basin";
	-- Translation completed
	SCCN_CONFAB = "|cffff0000L\'Addon Confab a \195\169t\195\169 trouv\195\169. Les fonctions SCCN Editbox ont \195\169t\195\169 d\195\169sactiv\195\169es par soucis de compatibilit\195\169";
	SCCN_HELP[1] = "Sol's Color chat Nicks - Aide, ligne de commandes:";
	SCCN_HELP[2] = "|cff68ccef".."/SCCN hidechanname ".."|cffffffff".." [ON/OFF] supression du nom du canal";
	SCCN_HELP[3] = "|cff68ccef".."/SCCN colornicks ".."|cffffffff".." [ON/OFF] Coloration par classe du nom du joueur dans le Chat";
	SCCN_HELP[4] = "|cff68ccef".."/SCCN purge".."|cffffffff".." Lancement d\'une purge standard de Base de Donn\195\169es. |cffa0a0a0(S\'ex\195\169cute automatiquement \195\160 chaque lancement de l\'addon)";
	SCCN_HELP[5] = "|cff68ccef".."/SCCN killdb".."|cffffffff".." Supprime compl\195\168tement la Base de Donn\195\169es. (D\195\169finitif)";
	SCCN_HELP[6] = "|cff68ccef".."/SCCN mousescroll".."|cffffffff".." [ON/OFF] chat scroll avec la molette de la souris. |cffa0a0a0(<SHIFT>-Molette = Scroll Rapide, <STRG>-Molette = Top, Bottom)";
	SCCN_HELP[7] = "|cff68ccef".."/SCCN topeditbox".."|cffffffff".." D\195\169placer le menu du Chat en haut de la fen\195\170tre de Chat.";
	SCCN_HELP[8] = "|cff68ccef".."/SCCN timestamp".."|cffffffff".." Afficher en 24h le Timestamp dans la fen\195\170tre de Chat. HH:MM";
	SCCN_HELP[9] = "|cff68ccef".."/SCCN colormap".."|cffffffff".." Coloration des membres du Raid par classe dans la Map.";
	SCCN_HELP[10] = "|cff68ccef".."/SCCN hyperlink".."|cffffffff".." Rendre les Hypertextes clicable dans le Chat.";
	SCCN_HELP[11] = "|cff68ccef".."/SCCN selfhighlight".."|cffffffff".." Highlight sur le nom de votre personnage dans les Chats.";
	SCCN_HELP[12] = "|cff68ccef".."/SCCN clickinvite".."|cffffffff".." Rendre le mot [invite] clicable dans les chats (invite sur clic).";
	SCCN_HELP[13] = "|cff68ccef".."/SCCN editboxkeys".."|cffffffff".." Utiliser les cl\195\169s du menu de Chat sans presser la touche <ALT> & augmenter le cache de l\'historique.";
	SCCN_HELP[14] = "|cff68ccef".."/SCCN chatstring".."|cffffffff".." Personnalisation des lignes de Chat.";
	SCCN_HELP[15] = "|cff68ccef".."/SCCN selfhighlightmsg".."|cffffffff".." Afficher \195\160 l\'\195\169cran les messages contenants votre nom \195\160 l\'\195\169cran.";
	SCCN_HELP[16] = "|cff68ccef".."/SCCN hidechatbuttons".."|cffffffff".." Hide Chat Buttons.";	
	SCCN_HELP[17] = "|cff68ccef".."/SCCN highlight".."|cffffffff".." Custom filter dialogue for highlighting Words in Chat.";	
	SCCN_HELP[18] = "|cff68ccef".."/SCCN AutoBGMap".."|cffffffff".." BGMinimap Autopupup.";		
	SCCN_HELP[19] = "|cff68ccef".."/SCCN shortchanname ".."|cffffffff".." Displays Short channelname.";	
	SCCN_HELP[20] = "|cff68ccef".."/SCCN autogossipskip ".."|cffffffff".." Skip the gossip Window automaticaly. |cffa0a0a0(Press <CTRL> to deactivate skip)";
	SCCN_HELP[21] = "|cff68ccef".."/SCCN autodismount ".."|cffffffff".." Auto Dismounts at taxi NPCs";
	SCCN_HELP[99] = "|cff68ccef".."/SCCN status".."|cffffffff".." Afficher la configuration courante.";
	SCCN_TS_HELP = "|cff68ccef".."/SCCN timestamp |cffFF0000FORMAT|cffffffff\n".."FORMAT:\n$h = heure (0-24) \n$t = heure (0-12) \n$m = minutes \n$s = secondes \n$p = periode (am / pm)\n".."|cff909090Exemple: /SCCN timestamp [$t:$m:$s $p]";
	SCCN_CMDSTATUS[1] = "Suppression du nom du canal:";
	SCCN_CMDSTATUS[2] = "Coloration par classe du nom dans le Chat:";
	SCCN_CMDSTATUS[3] = "Scroll Chat avec la molette de la souris:";
	SCCN_CMDSTATUS[4] = "Menu du canal en haut:";
	SCCN_CMDSTATUS[5] = "Chat Timestamp:";
	SCCN_CMDSTATUS[6] = "Coloration des membres du Raid par classe dans la Map:";
	SCCN_CMDSTATUS[7] = "Hypertextes Clicables:";
	SCCN_CMDSTATUS[8] = "Highlight sur soi-m\195\170me:";
	SCCN_CMDSTATUS[9] = "Invite sur clic:";
	SCCN_CMDSTATUS[10] = "Utilisation des cl\195\169s du menu de Chat sans presser la touche <ALT>:";
	SCCN_CMDSTATUS[11] = "Personnalisation des lignes de Chat:";
	SCCN_CMDSTATUS[12] = "Affichage \195\160 l\'\195\169cran les messages contenants votre nom:";
	SCCN_CMDSTATUS[13] = "Hide Chat Buttons:";
	SCCN_CMDSTATUS[14] = "BG Minimap Autopopup:";
	SCCN_CMDSTATUS[15] = "Custom Highlight:";
	SCCN_CMDSTATUS[16] = "Short du canal:";
	SCCN_CMDSTATUS[17]				= "Auto Gossip Skip:";
	SCCN_CMDSTATUS[18]				= "Auto Dismount:";	
	-- cursom invite word in the local language
	SCCN_CUSTOM_INV[0] = "invite";
	-- Whispers customized
	SCCN_CUSTOM_CHT_FROM = "de %s:";
	SCCN_CUSTOM_CHT_TO = "à %s:";
	-- hide this channels aditional, feel free to add your own
	SCCN_STRIPCHAN[1] = "Guilde";
	SCCN_STRIPCHAN[2] = "Raid";
	SCCN_STRIPCHAN[3] = "Groupe";


--==============
--= CHINA =
--==============
-- Chinese Simplified by q09q09
-- q09q09' Profile: http://forums.curse-gaming.com/member.php?u=43339
-- Last Update 04/02/2006
-- Thank's alot !!!
elseif ( GetLocale() == "zhCN" ) then
	SCCN_GUI_HIGHLIGHT1				= "In this Dialogue you can enter Words which SCCN should Highlight. Each Line is one Word.";
	SCCN_LOCAL_CLASS["WARLOCK"] 	= "术士";
	SCCN_LOCAL_CLASS["HUNTER"] 	= "猎人";
	SCCN_LOCAL_CLASS["PRIEST"] 	= "牧师";
	SCCN_LOCAL_CLASS["PALADIN"] 	= "圣骑士";
	SCCN_LOCAL_CLASS["MAGE"] 	= "法师";
	SCCN_LOCAL_CLASS["ROGUE"] 	= "盗贼";
	SCCN_LOCAL_CLASS["DRUID"] 	= "德鲁伊";
	SCCN_LOCAL_CLASS["SHAMAN"] 	= "萨满祭司";
	SCCN_LOCAL_CLASS["WARRIOR"] 	= "战士";
	SCCN_CONFAB			= "|cffff0000你有安装Confab。为了兼容性，SCCN的输入框相关功能取消！";
	SCCN_HELP[1]			= "Sol's Color chat Nicks - 指令说明:";
	SCCN_HELP[2]			= "|cff68ccef".."/SCCN hidechanname".."|cffffffff".." 隐藏频道名称";
	SCCN_HELP[3]			= "|cff68ccef".."/SCCN colornicks".."|cffffffff".." 以职业颜色显示玩家名字";
	SCCN_HELP[4]			= "|cff68ccef".."/SCCN purge".."|cffffffff".." 整理SCCN数据库。 |cffa0a0a0(每次载入此ui时都会自动执行这个动作。)";
	SCCN_HELP[5]			= "|cff68ccef".."/SCCN killdb".."|cffffffff".." 完整地把SCCN数据库清除。 (无法复原)";
	SCCN_HELP[6]			= "|cff68ccef".."/SCCN mousescroll".."|cffffffff".." 使用鼠标滚轮滚动对话框。 |cffa0a0a0(按住<SHIFT>-鼠标滚轮=快翻，按住<CTRL>-鼠标滚轮=翻至尽头, <STRG>-Molette = Top, Bottom)";
	SCCN_HELP[7]			= "|cff68ccef".."/SCCN topeditbox".."|cffffffff".." 对话输入框显示在聊天窗口的上面。";	
	SCCN_HELP[8]			= "|cff68ccef".."/SCCN timestamp".."|cffffffff".." 显示时间戳在每条信息之前。输入|cffa0a0a0 /SCCN timestamp ?|cffffffff 显示更改格式说明。";
	SCCN_HELP[9]			= "|cff68ccef".."/SCCN colormap".."|cffffffff".." 小地图上的团队成员以职业颜色标记。";	
	SCCN_HELP[10]			= "|cff68ccef".."/SCCN hyperlink".."|cffffffff".." 让对话消息里的URL可被选择复制！";
	SCCN_HELP[11]			= "|cff68ccef".."/SCCN selfhighlight".."|cffffffff".." 在对话消息中把自己名字明显标示！";
	SCCN_HELP[12]			= "|cff68ccef".."/SCCN clickinvite".."|cffffffff".." 让对话消息中的[邀请]能直接被点选以加入队伍。";	
	SCCN_HELP[13] 			= "|cff68ccef".."/SCCN editboxkeys".."|cffffffff".." 在对话输入框里不需要按住<ALT>键就能用方向键做编辑 & 历史纪录缓冲区增加至256行！";
	SCCN_HELP[14] 			= "|cff68ccef".."/SCCN chatstring".."|cffffffff".." 简化密语字串。";
	SCCN_HELP[15] 			= "|cff68ccef".."/SCCN selfhighlightmsg".."|cffffffff".." 包含自己名字的对话消息会另外显示在屏幕上方，须开启 /SCCN selfhighlight";	
	SCCN_HELP[16]			= "|cff68ccef".."/SCCN hidechatbuttons".."|cffffffff".." 隐藏聊天按钮。";	
	SCCN_HELP[17]			= "|cff68ccef".."/SCCN highlight".."|cffffffff".." Custom filter dialogue for highlighting Words in Chat.";	
	SCCN_HELP[18]			= "|cff68ccef".."/SCCN AutoBGMap".."|cffffffff".." BGMinimap Autopupup.";	
	SCCN_HELP[19] = "|cff68ccef".."/SCCN shortchanname ".."|cffffffff".." Displays Short channelname.";	
	SCCN_HELP[20] = "|cff68ccef".."/SCCN autogossipskip ".."|cffffffff".." Skip the gossip Window automaticaly. |cffa0a0a0(Press <CTRL> to deactivate skip)";
	SCCN_HELP[21] = "|cff68ccef".."/SCCN autodismount ".."|cffffffff".." Auto Dismounts at taxi NPCs";	
	SCCN_HELP[99]			= "|cff68ccef".."/SCCN status".."|cffffffff".." 显示目前设置。";
	SCCN_TS_HELP  			= "|cff68ccef".."/SCCN timestamp |cffFF0000FORMAT|cffffffff\n".."FORMAT:\n$h = 小时 (0-24) \n$t = 小时 (0-12) \n$m = 分钟 \n$s = 秒 \n$p = 上午/下午 (am / pm)\n".."|cff909090Example: /SCCN timestamp [$t:$m:$s $p]";
	SCCN_CMDSTATUS[1]		= "隐藏频道名称:";
	SCCN_CMDSTATUS[2]		= "以职业颜色显示玩家名字:";
	SCCN_CMDSTATUS[3]		= "使用鼠标滚轮滚动对话框:";
	SCCN_CMDSTATUS[4]		= "对话输入框顶置:";
	SCCN_CMDSTATUS[5]		= "加入消息时间:";
	SCCN_CMDSTATUS[6]		= "小地图上的队伍成员以职业颜色标记:";
	SCCN_CMDSTATUS[7]		= "URL可点选复制:";
	SCCN_CMDSTATUS[8]		= "明显标示自己的名字:";
	SCCN_CMDSTATUS[9]		= "对话框中的邀请信息可以被点选:";
	SCCN_CMDSTATUS[10]		= "对话编辑不需按住<ALT>:";
	SCCN_CMDSTATUS[11]		= "自定密语消息:";
	SCCN_CMDSTATUS[12]		= "额外显示包含自己名字的消息:";
	SCCN_CMDSTATUS[13]		= "隐藏聊天按钮:";
	SCCN_CMDSTATUS[14] 		= "BG Minimap Autopopup:";
	SCCN_CMDSTATUS[15] 		= "Custom Highlight:";
	SCCN_CMDSTATUS[16] 		= "Short Channelname:";
	SCCN_CMDSTATUS[17]				= "Auto Gossip Skip:";
	SCCN_CMDSTATUS[18]				= "Auto Dismount:";
	-- cursom invite word in the local language
	SCCN_CUSTOM_INV[0]		= "邀请";
	SCCN_CUSTOM_INV[1] 		= "邀请";
	-- Whispers customized
	SCCN_CUSTOM_CHT_FROM		= "%s说：";
	SCCN_CUSTOM_CHT_TO		= "密%s：";	
	-- hide this channels aditional, feel free to add your own
	SCCN_STRIPCHAN[1]		= "工会";
	SCCN_STRIPCHAN[2]		= "团队";
	SCCN_STRIPCHAN[3]		= "小队";		
	SCCN_STRIPCHAN[4]		= "世界防务";
	SCCN_STRIPCHAN[5]		= "官员";

--==============
--= TAIWAN =
--==============
-- Chinese Translation by Chris
-- Chris' Profile: http://forums.curse-gaming.com/member.php?u=47448
-- Last Update 01/31/2006
-- Thank's alot !!!
elseif ( GetLocale() == "zhTW" ) then
	SCCN_GUI_HIGHLIGHT1				= "In this Dialogue you can enter Words which SCCN should Highlight. Each Line is one Word.";
	SCCN_LOCAL_CLASS["WARLOCK"] 	= "術士";
	SCCN_LOCAL_CLASS["HUNTER"] 	= "獵人";
	SCCN_LOCAL_CLASS["PRIEST"] 	= "牧師";
	SCCN_LOCAL_CLASS["PALADIN"] 	= "聖騎士";
	SCCN_LOCAL_CLASS["MAGE"] 	= "法師";
	SCCN_LOCAL_CLASS["ROGUE"] 	= "盜賊";
	SCCN_LOCAL_CLASS["DRUID"] 	= "德魯伊";
	SCCN_LOCAL_CLASS["SHAMAN"] 	= "薩滿";
	SCCN_LOCAL_CLASS["WARRIOR"] 	= "戰士";
	-- Zones, Translation Needed
	SCCN_LOCAL_ZONE["alterac"]	= "Alterac Valley";
	SCCN_LOCAL_ZONE["warsong"]	= "Warsong Gulch";
	SCCN_LOCAL_ZONE["arathi"]	= "Arathi Basin";
	SCCN_CONFAB			= "|cffff0000你有安裝Confab。為了相容性，SCCN的輸入框相關功能取消！";
	SCCN_HELP[1]			= "Sol's Color chat Nicks - 指令說明:";
	SCCN_HELP[2]			= "|cff68ccef".."/SCCN hidechanname".."|cffffffff".." 隱藏頻道名稱";
	SCCN_HELP[3]			= "|cff68ccef".."/SCCN colornicks".."|cffffffff".." 以職業顏色顯示玩家名字";
	SCCN_HELP[4]			= "|cff68ccef".."/SCCN purge".."|cffffffff".." 整理SCCN資料庫。 |cffa0a0a0(每次載入此ui時都會自動做這個動作。)";
	SCCN_HELP[5]			= "|cff68ccef".."/SCCN killdb".."|cffffffff".." 完整地把SCCN資料庫清除。 (無法復原)";
	SCCN_HELP[6]			= "|cff68ccef".."/SCCN mousescroll".."|cffffffff".." 用滑鼠滾輪捲動對話欄。 |cffa0a0a0(按著<SHIFT>-滑鼠滾輪=快捲，按著<CTRL>-滑鼠滾輪=捲至盡頭)";
	SCCN_HELP[7]			= "|cff68ccef".."/SCCN topeditbox".."|cffffffff".." 對話輸入框顯示在聊天視窗的最上頭。";	
	SCCN_HELP[8]			= "|cff68ccef".."/SCCN timestamp".."|cffffffff".." 顯示時間戳記在每列訊息之前。鍵入|cffa0a0a0 /SCCN timestamp ?|cffffffff 顯示更改格式說明。";
	SCCN_HELP[9]			= "|cff68ccef".."/SCCN colormap".."|cffffffff".." 小地圖上的團隊成員以職業顏色標記。";	
	SCCN_HELP[10]			= "|cff68ccef".."/SCCN hyperlink".."|cffffffff".." 讓對話訊息裡的網頁連結可被點選複製！";
	SCCN_HELP[11]			= "|cff68ccef".."/SCCN selfhighlight".."|cffffffff".." 在對話訊息中把自己名字明顯標示！";
	SCCN_HELP[12]			= "|cff68ccef".."/SCCN clickinvite".."|cffffffff".." 讓對話訊息中的[邀請]能直接被點選以加入隊伍。";	
	SCCN_HELP[13] 			= "|cff68ccef".."/SCCN editboxkeys".."|cffffffff".." 在對話輸入框裡不需按著<ALT>鍵就能用方向鍵做編輯 & 歷史記錄緩衝區增加至256行！";
	SCCN_HELP[14] 			= "|cff68ccef".."/SCCN chatstring".."|cffffffff".." 簡化密語字串。";
	SCCN_HELP[15] 			= "|cff68ccef".."/SCCN selfhighlightmsg".."|cffffffff".." 包含自己名字的對話訊息會另外顯示在螢幕上方，須開啟 /SCCN selfhighlight";	
	SCCN_HELP[16]			= "|cff68ccef".."/SCCN hidechatbuttons".."|cffffffff".." Hide Chat Buttons.";	
	SCCN_HELP[17]					= "|cff68ccef".."/SCCN highlight".."|cffffffff".." Custom filter dialogue for highlighting Words in Chat.";	
	SCCN_HELP[18]					= "|cff68ccef".."/SCCN AutoBGMap".."|cffffffff".." BGMinimap Autopupup.";	
	SCCN_HELP[19] = "|cff68ccef".."/SCCN shortchanname ".."|cffffffff".." Displays Short channelname.";	
	SCCN_HELP[20] = "|cff68ccef".."/SCCN autogossipskip ".."|cffffffff".." Skip the gossip Window automaticaly. |cffa0a0a0(Press <CTRL> to deactivate skip)";
	SCCN_HELP[21] = "|cff68ccef".."/SCCN autodismount ".."|cffffffff".." Auto Dismounts at taxi NPCs";	
	SCCN_HELP[99]			= "|cff68ccef".."/SCCN status".."|cffffffff".." 顯示目前設置。";
	SCCN_TS_HELP  			= "|cff68ccef".."/SCCN timestamp |cffFF0000FORMAT|cffffffff\n".."FORMAT:\n$h = 小時 (0-24) \n$t = 小時 (0-12) \n$m = 分鐘 \n$s = 秒 \n$p = 午前/午後 (am / pm)\n".."|cff909090Example: /SCCN timestamp [$t:$m:$s $p]";
	SCCN_CMDSTATUS[1]		= "隱藏頻道名稱:";
	SCCN_CMDSTATUS[2]		= "以職業顏色顯示名字:";
	SCCN_CMDSTATUS[3]		= "使用滑鼠滾輪捲動聊天視窗:";
	SCCN_CMDSTATUS[4]		= "對話輸入欄置頂:";
	SCCN_CMDSTATUS[5]		= "加入訊息時間:";
	SCCN_CMDSTATUS[6]		= "小地圖上的隊伍成員以職業顏色標記:";
	SCCN_CMDSTATUS[7]		= "網頁連結可點選複製:";
	SCCN_CMDSTATUS[8]		= "明顯標示自己的名字:";
	SCCN_CMDSTATUS[9]		= "對話欄中的邀請訊息可被點選:";
	SCCN_CMDSTATUS[10]		= "對話編輯不需按住<ALT>:";
	SCCN_CMDSTATUS[11]		= "自定密語訊息:";
	SCCN_CMDSTATUS[12]		= "額外顯示包含自己名字的訊息:";
	SCCN_CMDSTATUS[13]		= "Hide Chat Buttons:";
	SCCN_CMDSTATUS[14] 		= "BG Minimap Autopopup:";
	SCCN_CMDSTATUS[15] 		= "Custom Highlight:";
	SCCN_CMDSTATUS[16] 		= "Short Channelname:";
	SCCN_CMDSTATUS[17]				= "Auto Gossip Skip:";
	SCCN_CMDSTATUS[18]				= "Auto Dismount:";	
	-- cursom invite word in the local language
	SCCN_CUSTOM_INV[0]		= "++";
	-- Whispers customized
	SCCN_CUSTOM_CHT_FROM		= "%s說：";
	SCCN_CUSTOM_CHT_TO		= "密%s：";	
	-- hide this channels aditional, feel free to add your own
	SCCN_STRIPCHAN[1]		= "公會";
	SCCN_STRIPCHAN[2]		= "團隊";
	SCCN_STRIPCHAN[3]		= "小隊";	

--==============
--=   ENGLISH  =
--==============
else
	SCCN_GUI_HIGHLIGHT1				= "In this Dialogue you can enter Words which SCCN should Highlight. Each Line is one Word.";
	SCCN_LOCAL_CLASS["WARLOCK"] 	= "Warlock";
	SCCN_LOCAL_CLASS["HUNTER"] 		= "Hunter";
	SCCN_LOCAL_CLASS["PRIEST"] 		= "Priest";
	SCCN_LOCAL_CLASS["PALADIN"] 	= "Paladin";
	SCCN_LOCAL_CLASS["MAGE"] 		= "Mage";
	SCCN_LOCAL_CLASS["ROGUE"] 		= "Rogue";
	SCCN_LOCAL_CLASS["DRUID"] 		= "Druid";
	SCCN_LOCAL_CLASS["SHAMAN"] 		= "Shaman";
	SCCN_LOCAL_CLASS["WARRIOR"] 	= "Warrior";
	-- Zones
	SCCN_LOCAL_ZONE["alterac"]	= "Alterac Valley";
	SCCN_LOCAL_ZONE["warsong"]	= "Warsong Gulch";
	SCCN_LOCAL_ZONE["arathi"]	= "Arathi Basin";
	SCCN_CONFAB						= "|cffff0000The Confab Addon was found. SCCN Editbox functions are disabled due to compatibility!";
	SCCN_HELP[1]					= "Sol's Color chat Nicks - Command Help:";
	SCCN_HELP[2]					= "|cff68ccef".."/SCCN hidechanname ".."|cffffffff".." Toggle chatname supression";
	SCCN_HELP[3]					= "|cff68ccef".."/SCCN colornicks ".."|cffffffff".." Toggle Chatname coloring in chatters class";
	SCCN_HELP[4]					= "|cff68ccef".."/SCCN purge".."|cffffffff".." Start a standard DB purge. |cffa0a0a0(done automaticaly each time the addon is loaded)";
	SCCN_HELP[5]					= "|cff68ccef".."/SCCN killdb".."|cffffffff".." Flushes the Database completly. (no undo)";
	SCCN_HELP[6]					= "|cff68ccef".."/SCCN mousescroll".."|cffffffff".." Toggle chat scrolling with mousewheel. |cffa0a0a0(<SHIFT>-MouseWheel  = Fast Scroll, <STRG>-MWheel = Top, Bottom)";
	SCCN_HELP[7]					= "|cff68ccef".."/SCCN topeditbox".."|cffffffff".." Move the chat editbox on top of the chatframe.";
	SCCN_HELP[8]					= "|cff68ccef".."/SCCN timestamp".."|cffffffff".." Show 24h Timestamp in Chatwindow.  HH:MM";
	SCCN_HELP[9]					= "|cff68ccef".."/SCCN colormap".."|cffffffff".." Color raidmembers on map in classcolor.";
	SCCN_HELP[10]					= "|cff68ccef".."/SCCN hyperlink".."|cffffffff".." Make Hyperlinks in Chat clickable.";
	SCCN_HELP[11]					= "|cff68ccef".."/SCCN selfhighlight".."|cffffffff".." Highlight own charname in chats.";
	SCCN_HELP[12]					= "|cff68ccef".."/SCCN clickinvite".."|cffffffff".." Make the word [invite] clickable in chats (invite on click).";
	SCCN_HELP[13] 					= "|cff68ccef".."/SCCN editboxkeys".."|cffffffff".." Use Chat Editbox keys without pressing <ALT> & increase History Buffer.";
	SCCN_HELP[14] 					= "|cff68ccef".."/SCCN chatstring".."|cffffffff".." Custom chat Strings.";
	SCCN_HELP[15] 					= "|cff68ccef".."/SCCN selfhighlightmsg".."|cffffffff".." Print OnScreen msg containing own nick on Screen.";	
	SCCN_HELP[16]					= "|cff68ccef".."/SCCN hidechatbuttons".."|cffffffff".." Hide Chat Buttons.";	
	SCCN_HELP[17]					= "|cff68ccef".."/SCCN highlight".."|cffffffff".." Custom filter dialogue for highlighting Words in Chat.";	
	SCCN_HELP[18]					= "|cff68ccef".."/SCCN AutoBGMap".."|cffffffff".." BGMinimap Autopupup.";	
	SCCN_HELP[19] = "|cff68ccef".."/SCCN shortchanname ".."|cffffffff".." Displays Short channelname.";	
	SCCN_HELP[20] = "|cff68ccef".."/SCCN autogossipskip ".."|cffffffff".." Skip the gossip Window automaticaly. |cffa0a0a0(Press <CTRL> to deactivate skip)";
	SCCN_HELP[21] = "|cff68ccef".."/SCCN autodismount ".."|cffffffff".." Auto Dismounts at taxi NPCs";	
	SCCN_HELP[99]					= "|cff68ccef".."/SCCN status".."|cffffffff".." Show current configuration.";	
	SCCN_TS_HELP  					= "|cff68ccef".."/SCCN timestamp |cffFF0000FORMAT|cffffffff\n".."FORMAT:\n$h = hour (0-24) \n$t = hour (0-12) \n$m = minute \n$s = second \n$p = periode (am / pm)\n".."|cff909090Example: /SCCN timestamp [$t:$m:$s $p]";
	SCCN_CMDSTATUS[1]				= "Supress Channelname:";
	SCCN_CMDSTATUS[2]				= "Chat nicknames in classcolor:";
	SCCN_CMDSTATUS[3]				= "Scroll Chat with Mousewheel:";
	SCCN_CMDSTATUS[4]				= "Chat Editbox onTop:";
	SCCN_CMDSTATUS[5]				= "Chat Timestamp:";
	SCCN_CMDSTATUS[6]				= "Class colored Map pins:";
	SCCN_CMDSTATUS[7]				= "Clickable Hyperlinks:";
	SCCN_CMDSTATUS[8]				= "Self Highlight:";
	SCCN_CMDSTATUS[9]				= "Click Invite:";
	SCCN_CMDSTATUS[10]  			= "Use Editbox Keys without <ALT>:";
	SCCN_CMDSTATUS[11] 				= "Custom chat strings:";
	SCCN_CMDSTATUS[12]				= "Self Highlight On Screen:";
	SCCN_CMDSTATUS[13]				= "Hide Chat Buttons:";
	SCCN_CMDSTATUS[14] 				= "BG Minimap Autopopup:";
	SCCN_CMDSTATUS[15] 				= "Custom Highlight:";
	SCCN_CMDSTATUS[16] 				= "Short Channelname:";
	SCCN_CMDSTATUS[17]				= "Auto Gossip Skip:";
	SCCN_CMDSTATUS[18]				= "Auto Dismount:";	
	-- cursom invite word in the local language
	SCCN_CUSTOM_INV[0] 				= "1nv1t3"; --   :D
	-- Whispers customized
	SCCN_CUSTOM_CHT_FROM			= "From %s:";
	SCCN_CUSTOM_CHT_TO				= "To %s:";
	-- hide this channels aditional, feel free to add your own
	SCCN_STRIPCHAN[1]				= "Guild";
	SCCN_STRIPCHAN[2]				= "Raid";
	SCCN_STRIPCHAN[3]				= "Party";	
end