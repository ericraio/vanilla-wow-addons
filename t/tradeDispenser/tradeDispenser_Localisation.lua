-- this is the Version of TradeDispenser - shown in the messages of the game
if (not tradeDispenser_Version) then 	tradeDispenser_Version = "0.94" 	end
-- The Version of the saved datas... 	only edit, if the architecture got changed. 
if (not configDataVersion) then 		configDataVersion = "0.80"  		end



function tradeDispenser_GetEnglish()
	tradeDispenser_ProgName = "tradeDispenser";
	-- tradeDispenser_Version is defined in tradeDispenser_Initialize.lua

	tD_Loc = {
		["logon"]			= {
			["changed"]		= "Data version has changed, resetting configuration",
			["welcome"] 	= " Version "..tradeDispenser_Version.." - initialized",
		},	
		["configtitle"]		= tradeDispenser_ProgName.." V"..tradeDispenser_Version,
		["configItems"]		= "Insert Money and Items",
		["about"]		= {	-- open end. could have more than 5 lines
			[0] = "About the "..tradeDispenser_ProgName,
			[1] = "   Version:   "..tradeDispenser_Version,
			[2] = "   Author:     Kaboom  @ Arthas (EU)",
			[3] = "   Core:       Shag    @ Arthas (EU)",
			[4] = "   More:       Please read the ReadMe",
		},
		["help"]		= {	-- open end. could have more than 9 lines
			[0] = "Prefix:",
			[1] = "  /td or /tradeDispenser       Shows the Help-Text",
			[2] = "Options (use Prefix + Option)",
			[3] = "  config         Toggles the ConfigFrame",
			[4] = "  toggle         Activates/Deactivates "..tradeDispenser_ProgName,
			[5] = "  broadcast   Broadcasts your Trade",
			[6] = "  OSD           Toggles the OSD (shortcut-Buttons)",
			[7]	= "  verbose X   Sets the VerboseLevel (DebugInfo) to level X. (0=off)",
			[8] = "  resetpos      resets the position of all tD-Frames",
			[9] = "  about          Shows more informations about "..tradeDispenser_ProgName,
		},
		["whisper"]		= {		-- default messages - can be edited ingame
			[1] = {
				["short"]	= "Something's wrong",
				["default"]	= tradeDispenser_ProgName..": Something is wrong with my inventory (probably item-lag), I can't deliver items. Please try again",
			},
			[2]	= {
				["short"]	= "Spam: Out of items",
				["default"]	= tradeDispenser_ProgName..": I'm out of items, please don't trade with me anymore",
			},
			[3] = {
				["short"]	= "Stack not complete",
				["default"]	= tradeDispenser_ProgName..": I'm sorry that the last stack isn't complete, but I'm out of items. Please accept the trade",
			},
			[4]	= {
				["short"]	= "no more items",
				["default"]	= tradeDispenser_ProgName..": That's all, I don't have more",
			},
			[5] = {
				["short"]	= "i need money",
				["default"]	= tradeDispenser_ProgName..": I'll sell you these items for ", --  ...  2g 30s 00c
			},
			[6] = {
				["short"]	= "LowLevel-Message",
				["default"]	= "Your Level's too low! I won't trade with you!",
			},
			[7]	= {
				["short"]	= "You're not in Guild",
				["default"]	= "You're not a GuildMember! I won't trade with you!",
			},
			[8]	= {
				["short"]	= "You're not in Raid",
				["default"]	= "You're not a Raid/PartyMember! I won't trade with you!",
			},
			[9] = {
				["short"] 	= "Maximum reached",
				["default"]	= "You have already reached the maximum of allowed trades! I won't trade with you again!",
			},
			[10] = {
				["short"]	= "Banned Player",
				["default"]	= "You're ony my Banlist! I won't trade with you!",
			},
			[11] = {
				["short"]	= "10 sec left",
				["default"] = "Please accept the trade, i'll cancel it in 10 sec",
			},
		},
		["Broadcast"] 				= {
			[1] 					= tradeDispenser_ProgName.." enabled! Trade me and grab yourself some items!",
			[2]						= "edit this line to write a new broadcast-message",
			[3]						= "Note: you can insert items with Shift+Click",
			[4]						= "Add more messages and own the raid",	
		},
		["noItemsToTrade"]			= "Sorry, there are no items for this client-type defined. Check the profiles",
		["Opposite"]				= "Your client is:",
		["rack"]					= "Rack #",
		["RackTitle"]				= "Active Rack",
		["resetframes"]				= "Frame-Reset of "..tradeDispenser_ProgName..": DONE";
		["buttons"]			= {
			["tradecontrol"] 		= "TradeControl",
			["settings"]			= "Settings",
			["enabled"]				= "Enabled",
			["disabled"]			= "Disabled",
			["hide"]				= "Hide",
			["whispers"]			= "whispers",
			["reset"]				= "Reset",
			["banlist"]				= "Banlist",
		},
		["profile"]			= {
			["title"]		= "Show Profile",
			[1]			= "All Classes",
			[2]			= "Warrior",
			[3]			= "Rogue",
			[4]			= "Hunter",
			[5]			= "Warlock",
			[6]			= "Mage",
			[7]			= "Druid",
			[8]			= "Priest",
			[9]			= "Shmn/Pala",
			[10]		= "Melee",
			[11]		= "ManaUser",
			[12]		= "Healer",
			["Alliance"] = "Paladine",
			["Horde"]	= "Shamane",
		},
		["channel"]			= {
			["say"]			= "SAY",
			["yell"]		= "YELL",
			["guild"]		= "GUILD",
			["raid"]		= "RAID",
			["party"]		= "PARTY",
		},
		["settings"]		= {
			["title"]		= "Settings:",
			["channel"]		= "Channel",
			["broadcasttext"]="Broadcast text",
			["broadcastopt"]= "Broadcast options:",
			["bkcolor"]		= "BK-Color",		
			["border"]		= "Border",
			["horiz"]		= "Rotate",
			["osdtooltip"]	= {	-- open end. could have more than 3 lines
				[0] = "Toggle OnScreenDisplay",
				[1] = "Activate to make the",
				[2] = "small side-frame visible",
			},
			["broadcasttooltip"]	= {
				[0] = "Toggle Automatic Broadcast",
				[1] = "Could only broadcast, if",
				[2] = tradeDispenser_ProgName.." is running",
			},
			["lock"]		= "Locked",
			["scale"]		= "Scale:",
			["autobroadcast"]	= "Auto-Broadcast:",
			["once"]		= "Once",
			["randomtext"]	= "Random Text:",
			["Hint"]	= {	-- open end. could have more than 4 lines
				[0]	= "Just for information:",
				[1] = "The profiles are additive. that means:",
				[2] = "a Warrior would get the items of the",
				[3] = "profiles: All classes + warrior + melee",
				[4] = "NOTE: Healer-classes won't get items of ",
				[5] = "the profile 'ManaUser'",
			},
			["Timelimit"] = "TimeLimit",
			["TimerTooltip"] = {
				[0] = "This function will activate a timer",
				[1] = "for limiting the trade-duration",
				[2] = "before "..tradeDispenser_ProgName.." cancels",
				[3] = "the trade the client will get a warning.",
				[4] = "Note: This will only work if YOU already",
				[5] = "have accepted the trade."
			},
		},
		["OSD"]				= {
			["OSDtitle"]	= "OSD",
			["notenabled"]	= tradeDispenser_ProgName.." is not enabled",
			["broadcasttip"]	= {
				["title"] 		= "Broadcast your Trade",
				["channel"]		= "Spamed channel: ",	-- here follows the localised channel-name
				["left"]		= "LeftClick:  Broadcast instantly",
				["right"]		= "RightClick: Toggle AutoBroadcast",
			},
			["actbutton"] 	= {
				["activate"]	= "Activate "..tradeDispenser_ProgName,
				["deactivate"]	= "Deactivate "..tradeDispenser_ProgName,
				["left"]	= "LeftClick:  toggle "..tradeDispenser_ProgName,
				["right"]	= "RightClick: Reset List",
				["noright"]	= "RightClick: Reset Disabled",
			},
			["configbtn"]	= {
				["show"]	= "Show the ConfigFrame",
				["hide"]	= "Hide the ConfigFrame",
				["left"]	= "LeftClick:  open small ConfigFrame",
				["right"]	= "RightClick: open full ConfigCenter",
			},
		},	
		["control"]			= {
			["title"]		= "TradeControl:",
			["ignore"]		= "Ignore players",
			["notraid"]		= "not in Raid/Party",		
			["notinraid"]	= {	-- open end. could have more than 5 lines
				[0]			= "Ignore non Raid/PartyMembers",
				[1]			= "Ignores all trade requests of players,",
				[2]			= "which are NOT member of your Raid/Party",
				[3]			= "This function does only work, if you",
				[4]			= "joined a raid or party",
			},
			["acceptguild"]	= "accept Guild",
			["autoaccept"]	= "Auto-Accept",
			["ClientInfos"]="Show Client-Infos",
			["accguild"]	= {	-- open end. could have more than 3 lines
				[0]			= "Dont Block GuildMembers",
				[1]			= "Trade with them, even if they",
				[2]			= "are not member of your Raid/Party",
			},
			["FreeCheckBox"]= "Free for raid/guild",
			["Free4Guild"]	= {
				[0]			= "Free Items for your guild and raid",
				[1]			= "If you activate this checkbox, the",
				[2]			= "players of your raid and guild dont",
				[3]			= "have to pay money for your items.",
			},
			["leveltext"]	= "Clients Level",
			["level"]		= "at least: ",
			["register"]	= "Register Clients",
			["maxtrades"]	= "Max Trades:",
		},
		["Banlist"]			= {
			["Title"]		= "Banned Players:",
			["Import"]		= "Import Ignorelist",
			["Add"]			= "Add",
			["Remove"]		= "Remove",
		},
		["UImessages"]		= {
			["cancelled"]	= "Trade cancelled",
			["complete"]	= "Trade complete",
			["failed"]		= "Trade failed",
		},
		["KeyBindings"]		= {
			["header"]		= tradeDispenser_ProgName,
			[1]				= "Toggle tradeDispenser",
			[2]				= "Toggle ConfigFrame",
			[3]				= "Toggle OSD",
			[4]				= "Insta-Broadcast",
		},
		["activated"] 		= tradeDispenser_ProgName.." activated",
		["deactivated"] 	= tradeDispenser_ProgName.." deactivated",
		["verbose"]		= {
			["isset"]	= "Verbose-Level is: ",
			["setto"]	= "Changed Verbose-Level to ",
		},
		["Alliance"]	= "Common",
		["Horde"]       = "Orcish",
	};
end






function tradeDispenser_GetGerman()
	tradeDispenser_ProgName = "tradeDispenser";
	-- tradeDispenser_Version is defined in tradeDispenser_Initialize.lua
	tD_Loc = {
		["logon"]			= {
			["changed"]		= "Speicher-System nicht aktuell, Configurationen werden zur\195\188ckgesetzt",
			["welcome"] 	= "Version "..tradeDispenser_Version.." initialisiert",
		},	
		["configtitle"]		= tradeDispenser_ProgName.." V"..tradeDispenser_Version,
		["configItems"]		= "Geld und Items einfügen",
		["about"]		= {	-- open end. could have more than 5 lines
			[0] = "Informationen zu "..tradeDispenser_ProgName,
			[1] = "   Version:   "..tradeDispenser_Version,
			[2] = "   Author:    Kaboom  @ Arthas (EU)",
			[3] = "   Kern:      Shag    @ Arthas (EU)",
			[4] = "   Mehr:	     Bitte lies die LiesMich.txt",
		},
		["help"]		= {	-- open end. could have more than 9 lines
			[0] = "Prefix:",
			[1] = "  /td oder /tradeDispenser       Zeigt diese Hilfestellung",
			[2] = "Optionen (Benutzung: Prefix + Option)",
			[3] = "  config         Schalter f\195\188r das ConfigFrame",
			[4] = "  toggle         Aktiviert/Deaktiviert "..tradeDispenser_ProgName,
			[5] = "  broadcast   Teilt deine Handelsabsichten mit",
			[6] = "  OSD           Schalter f\195\188r das OSD (Shortcut-Buttons)",
			[7]	= "  verbose X   Zeigt DebugInformationen. (Level X: 0=aus, 3=ALLE)",
			[8] = "  resetpos      setzt alle tD-Fenster zurück",
			[9] = "  about          Zeigt mehr Infos zu "..tradeDispenser_ProgName,
		},
		["whisper"]		= {		-- default messages - could be edited ingame
			[1] = {
				["short"]	= "irgendwas ist falsch",
				["default"]	= tradeDispenser_ProgName..": Irgendwas lief falsch im Invenar (vielleicht Item-Lag). Ich kann keine Items liefern, bitte versuch es nochmal!",
			},
			[2]	= {
				["short"]	= "Keine Items mehr (Spam)",
				["default"]	= tradeDispenser_ProgName..": Ich habe keine weiteren Items, bitte handelt nicht mehr mit mir.",
			},
			[3] = {
				["short"]	= "Stack nicht komplett",
				["default"]	= tradeDispenser_ProgName..": Sorry, dass der letzte Stack nicht komplett ist. Leider habe ich nicht mehr genug im Inventar.",
			},
			[4]	= {
				["short"]	= "Keine Items mehr",
				["default"]	= tradeDispenser_ProgName..": Keine weiteren Items an Lager!",
			},
			[5] = {
				["short"]	= "Verlange Geld!",
				["default"]	=  tradeDispenser_ProgName..": F\195\188r diese Items h\195\164tte ich gerne ",
			},
			[6] = {
				["short"]	= "Level zu niedrig",
				["default"]	= "Dein Level ist zu tief, mit dir will ich nicht handeln.",
			},
			[7]	= {
				["short"]	= "Nicht in meiner Gilde",
				["default"]	= "Du bist kein Gilden-Mitglied, mit dir will ich nicht handeln.",
			},
			[8]	= {
				["short"]	= "Nicht in meinem Raid",
				["default"]	= "Du bist kein Mitglied des Raids/Party, mit dir will ich nicht handeln.",
			},
			[9] = {
				["short"] 	= "Maximum erreicht",
				["default"]	= "Du hast bereits das Maximum der erlaubten Handelsmenge erreicht! Mit dir will ich nicht mehr handeln.",
			},
			[10] = {
				["short"]	= "Gebannter Spieler",
				["default"]	= "Du stehst auf meiner Bann-Liste! Mit dir will ich nicht handeln.",
			},			
			[11] = {
				["short"]	= "10 sec übrig",
				["default"] = "Bitte akzeptiere den Handel, ich werde ihn sonst in 10 sec abbrechen",
			},
		},
		["Broadcast"] 				= {
			[1] 					= tradeDispenser_ProgName.." aktiviert! Handel mich an, dann kriegst du was",
			[2]						= "Editiere diese Zeile, um einen weiteren Zufallstext zu erstellen",
			[3]						= "Hinweis: Man kann Items via Shift+Klick einfügen",
			[4]						= "Schreib noch mehr Texte und owne den Raid",	
		},		
		["noItemsToTrade"]			= "Sorry, es wurden keine Items für diesen Kunden-Typen definiert",
		["Opposite"]				= "Dein Kunde ist:",
		["rack"]					= "Bündel #",
		["RackTitle"]				= "Aktives Bündel",	
		["resetframes"]				= "Alle Fenster von "..tradeDispenser_ProgName.." wurden zurückgesetzt";
		["buttons"]			= {
			["tradecontrol"] 		= "TradeControl",
			["settings"]			= "Einstellungen",
			["enabled"]				= "Aktiviert",
			["disabled"]			= "Deaktiviert",
			["hide"]				= "Schliessen",
			["whispers"]			= "Geflüster",
			["reset"]				= "Reset",
			["banlist"]				= "Bann-Liste",
		},
		["profile"]			= {
			["title"]		= "Zeige Profil",
			[1]			= "Alle Klassen",
			[2]			= "Krieger",
			[3]			= "Schurke",
			[4]			= "Jäger",
			[5]			= "Hexenmeister",
			[6]			= "Magier",
			[7]			= "Druide",
			[8]			= "Priester",
			[9]			= "Shmn/Pala",
			[10]		= "Nahkämpfer",
			[11]		= "Mana-braucher",
			[12]		= "Heiler",
			["Alliance"] = "Paladin",
			["Horde"]	= "Schamane",
		},
		["channel"]			= {
			["say"]			= "SAGEN",
			["yell"]		= "SCHREIEN",
			["guild"]		= "GILDE",
			["raid"]		= "SCHLACHTZUG",
			["party"]		= "GRUPPE",
		},	
		["settings"]		= {
			["title"]		= "Einstellungen:",
			["channel"]		= "Channel",
			["broadcasttext"]="Broadcast Text",
			["broadcastopt"]= "Broadcast-Optionen:",
			["bkcolor"]		= "Hintergrund",
			["border"]		= "Rahmen",
			["horiz"]		= "Horizontal",
			["osdtooltip"]	= {	-- open end. could have more than 3 lines
				[0] = "Schalter für OnScreenDisplay",
				[1] = "Aktiviere dies, um das OSD",
				[2] = "sichtbar zu machen",
			},
			["broadcasttooltip"]	= {
				[0] = "Aktiviert Auto-Broadcast",
				[1] = "Funktioniert aber nur, wenn",
				[2] = tradeDispenser_ProgName.." aktiviert ist",
			},
			["lock"]		= "fixiert",
			["scale"]		= "Grösse:",
			["autobroadcast"]	= "Auto-Broadcast:",
			["once"]		= "Einmal",
			["randomtext"]	= "Zufalls-Text:",
			["Hint"]	= {	-- open end. could have more than 4 lines
				[0]	= "ACHTUNG:",
				[1] = "Die Profile sind Additiv. zB bekommt ein",
				[2] = "Krieger alle Items aus den Profilen",
				[3] = "Alle Klassen + Krieger + Nahkämpfer",
				[4] = "Ausserdem bekommen Heiler-Klassen keine",
				[5] = "Items aus dem Profil 'Mana-braucher'",
			},
			["Timelimit"] = "Zeitlimit",
			["TimerTooltip"] = {
				[0] = "Diese Funktion aktiviert eine Stoppuhr,",
				[1] = "welche den Handel nach Ablauf der Zeit",
				[2] = "abbrechen wird. 5 sec davor wird dein",
				[3] = "Kunde jedoch noch eine Mitteilung erhalten.",
				[4] = "Achtung: Dies wird nur dann funktionieren,",
				[5] = "wenn DU den Handel bereits angenommen hast."
			},			
		},
		["OSD"]				= {
			["OSDtitle"]	= "OSD",
			["notenabled"]	= tradeDispenser_ProgName.." ist nicht aktiv",
			["broadcasttip"]	= {
				["title"] 		= "Den Handel mitteilen",
				["channel"]		= "Gespamter Kanal: ",	-- here follows the localised channel-name
				["left"]		= "LinksKlick: Sofort mitteilen",
				["right"]		= "RechtKlick: Auto-Broadcast",
			},
			["actbutton"] 	= {
				["activate"]	= "Activiere "..tradeDispenser_ProgName,
				["deactivate"]	= "Deactiviere "..tradeDispenser_ProgName,
				["left"]	= "LinksKlick: Schalter für "..tradeDispenser_ProgName,
				["right"]	= "RechtsKlick: Liste löschen",
				["noright"]	= "RechtsKlick: Liste löschen (inaktiv)",
			},
			["configbtn"]	= {
				["show"]	= "Zeige das Config-Fenster",
				["hide"]	= "Verstecke das Config-Fenster",
				["left"]	= "LinksKlick: kleines Config-Fenster",
				["right"]	= "RechtsKlick: volles Config-Center",
			},
		},	
		["control"]			= {
			["title"]		= "TradeControl:",
			["ignore"]		= "Ignoriere Spieler",
			["notraid"]		= "ausserhalb Raids/Party",		
			["notinraid"]	= {	-- open end. could have more than 5 lines
				[0]			= "Ignoriere Player ausserhalb des Raids",
				[1]			= "Diese Funktion ignoriert Handelsanfragen",
				[2]			= "von Spielern, die nicht in deiner Gruppe sind.",
				[3]			= "Dies funktioniert nur, solange du dich in",
				[4]			= "einem Schlachtzug oder einer Gruppe befindest",
			},
			["acceptguild"]	= "Akzeptiere Gilde",
			["autoaccept"]	= "Automatisch akzeptieren",
			["ClientInfos"]="Zeige Kunden-Infos",
			["accguild"]	= {	-- open end. could have more than 3 lines
				[0]			= "Entblocke Gildenmitglieder",
				[1]			= "Gildenmitglieder können mit dir Handeln,",
				[2]			= "auch wenn diese nicht in deiner Gruppe sind",
			},
			["FreeCheckBox"]= "Gratis für Raid / Gilde",
			["Free4Guild"]	= {
				[0]			= "Gratis-Items für Raid und Gilde",
				[1]			= "Durch aktivierung dieser Checkbox",
				[2]			= "erhalten alle Gilden- und Raid-Member",
				[3]			= "ihre Items gratis, wo andere Spieler",
				[4]			= "dafür zahlen müssten.",
			},
			["leveltext"]	= "Kunden-Level",
			["level"]		= "Mindestens: ",
			["register"]	= "Registriere Kunden",
			["maxtrades"]	= "Max pro Kunde: ",
		},
		["Banlist"]			= {
			["Title"]		= "Gebannte Spieler:",
			["Import"]		= "Importiere IgnoreListe",
			["Add"]			= "Hinzufgn",
			["Remove"]		= "Löschen",
		},		
		["UImessages"]	= {
			["cancelled"]	= "Handel abgebrochen",
			["complete"]	= "Handel abgeschlossen",
			["failed"]		= "Handel fehlgeschlagen",
		},
		["KeyBindings"]		= {
			["header"]		= tradeDispenser_ProgName,
			[1]				= "Schalter für tD",
			[2]				= "Zeige Config-Frame",
			[3]				= "Zeige OSD",
			[4]				= "Sofort-Broadcast",
		},		
		["activated"] 		= tradeDispenser_ProgName.." aktiviert",
		["deactivated"] 	= tradeDispenser_ProgName.." deaktiviert",
		["verbose"]		= {
			["isset"]	= "Verbose-Level zur Zeit: ",
			["setto"]	= "Verbose-Level ist jetzt: ",
		},
		["Alliance"]		= "Gemeinsprache",
		["Horde"]			= "Orcisch",
	}
end









function tradeDispenser_GetChinese()
	tradeDispenser_ProgName = "自动售货机";
	tD_Loc = {
		["logon"]			= {
			["changed"]		= "数据版本改变，重置配置文件",
			["welcome"] 	= " 版本 "..tradeDispenser_Version.." - 初始化完毕",
		},
		["configtitle"]		= tradeDispenser_ProgName.." V"..tradeDispenser_Version,
		["configItems"]		= "设置金钱及物品",
		["about"]		= {	-- open end. could have more than 5 lines
			[0] = "关于"..tradeDispenser_ProgName,
			[1] = "   版本:   "..tradeDispenser_Version,
			[2] = "   作者:     Kaboom  @ Arthas (EU)",
			[3] = "   作者:     Shag    @ Arthas (EU)",
			[4] = "   修改:     Mickey",
			[5] = "   更多:     请阅读Readme文件",
		},
		["help"]		= {	-- open end. could have more than 9 lines
			[0] = "前缀:",
			[1] = "  /td 或 /tradeDispenser    显示帮助",
			[2] = "设置命令 (使用 前缀 + 以下命令)",
			[3] = "  config        打开配置界面",
			[4] = "  toggle        启用/禁用"..tradeDispenser_ProgName,
			[5] = "  broadcast   广播交易信息",
			[6] = "  OSD          开启快捷窗口 (图标按钮)",
			[7]	= "  verbose X    设置 VerboseLevel(Debug信息)为level X. (0=关闭)",
			[8] = "  resetpos    moves all frames of tD to their default position",
			[9] = "  about        关于"..tradeDispenser_ProgName,
		},
		["whisper"]		= {
			[1] = {
				["short"]	= "出 错",
				["default"]	= tradeDispenser_ProgName..": 出了点小问题(可能是物品延迟)，没放上物品.请再试一次。",
			},
			[2]	= {
				["short"]	= "暂时缺货",
				["default"]	= tradeDispenser_ProgName..": 物品用尽，请暂时不要交易我...",
			},
			[3] = {
				["short"]	= "数量不足1组",
				["default"]	= tradeDispenser_ProgName..": 很抱歉只剩下这点了。请确认交易。",
			},
			[4]	= {
				["short"]	= "数量不足",
				["default"]	= tradeDispenser_ProgName..": OK，就是这些了，请确认交易。",
			},
			[5] = {
				["short"]	= "售 价",
				["default"]	= tradeDispenser_ProgName..": 您需要为这些东西支付 ", --  ...  2g 30s 00c
			},
			[6] = {
				["short"]	= "等级低",
				["default"]	= "你的级别不够！拒绝交易！",
			},
			[7]	= {
				["short"]	= "不是会员",
				["default"]	= "你不是本公会成员！拒绝交易！",
			},
			[8]	= {
				["short"]	= "不是队友",
				["default"]	= "你不是我的队友！拒绝交易！",
			},
			[9] = {
				["short"] 	= "交易上限",
				["default"]	= "你已达到最多交易次数！拒绝交易！",
			},
			[10] = {
				["short"]	= "屏蔽玩家",
				["default"]	= "你已经被我加入到黑名单了! 我不会再和你交易了!",
			},	
			[11] = {
				["short"]	= "10秒警告",
				["default"] = "请速度接受交易, 10秒后我将取消交易",
			},
		},
		["Broadcast"] 				= {
			[1] 					= tradeDispenser_ProgName.." 开始营业了! 交易我来换取你想要的东西!",
			[2]						= "编辑一条新的广播.",
			[3]						= "提示: Shift+点击 可以在广播中加入物品链接",
			[4]						= "添加更多广播",	
		},
		["noItemsToTrade"]			= "抱歉, 还没有这类物品的设定. 请检查物品配置",
		["Opposite"]				= "你的顾客是：",
		["rack"]					= "货架 #",
		["RackTitle"]				= "已激活",		
		["resetframes"]				= "重置 "..tradeDispenser_ProgName..": 完成";
		["buttons"]			= {
			["tradecontrol"] 		= "交易控制",
			["settings"]			= "设置",
			["enabled"]				= "已启用",
			["disabled"]			= "已禁用",
			["hide"]				= "隐藏",
			["whispers"]			= "密语",
			["reset"]				= "清空记录",
			["banlist"]				= "ۚ黑名单",
		},
		["profile"]			= {
			["title"]		= "显示配置文件",
			[1]			= "所有职业",
			[2]			= "战士",
			[3]			= "盗贼",
			[4]			= "猎人",
			[5]			= "术士",
			[6]			= "法师",
			[7]			= "德鲁伊",
			[8]			= "牧师",
			[9]			= "萨满/圣骑",
			[10]		= "近战系",
			[11]		= "魔法系",
			[12]		= "治疗系",
			["Alliance"] = "圣骑",
			["Horde"]	= "萨满",
		},
		["channel"]			= {
			["say"]			= "说",
			["yell"]		= "喊",
			["guild"]		= "公会",
			["raid"]		= "团队",
			["party"]		= "队伍",
		},
		["settings"]		= {
			["title"]		= "设置:",
			["channel"]		= "频道",
			["broadcasttext"]="广播内容",
			["broadcastopt"]= "广播选项:",
			["bkcolor"]		= "背景色",
			["border"]		= "边框",
			["horiz"]		= "旋转",
			["osdtooltip"]	= {	-- open end. could have more than 3 lines
				[0] = "开启屏幕显示",
				[1] = "勾选此选项",
				[2] = "显示快捷窗口",
			},
			["broadcasttooltip"]	= {
				[0] = "开启自动广播",
				[1] = "只能在启用了",
				[2] = tradeDispenser_ProgName.."时广播",
			},
			["lock"]		= "锁定",
			["scale"]		= "缩放:",
			["autobroadcast"]	= "自动广播:",
			["once"]		= "一次",
			["randomtext"]	= "随机广播数:",
			["Hint"]	= {	-- open end. could have more than 4 lines
				[0]	= "记住",
				[1] = "配置文件是互相叠加的。例如：",
				[2] = "一个战士会得到以下配置文件里的所有",
				[3] = "物品：所有职业 + 战士 + 近战职业",
			},
			["Timelimit"] = "交易时限",
			["TimerTooltip"] = {
				[0] = "这个选项将激活一个计时器",
				[1] = "如果设定时间内未完成交易,",
				[2] = "将会在 "..tradeDispenser_ProgName.." 取消",
				[3] = "交易前发出警告.",
				[4] = "注意: 这个功能只能在你已经接受",
				[5] = "交易后生效."
			},
		},
		["OSD"]				= {
			["OSDtitle"]	= "显示",
			["notenabled"]	= tradeDispenser_ProgName.."未启用",
			["broadcasttip"]	= {
				["title"] 		= "广播你的交易信息",
				["channel"]		= "广播频道: ",	-- here follows the localised channel-name
				["left"]		= "左键：立刻广播",
				["right"]		= "右键: 开关自动广播",
			},
			["actbutton"] 	= {
				["activate"]	= "启用 "..tradeDispenser_ProgName,
				["deactivate"]	= "禁用 "..tradeDispenser_ProgName,
				["left"]	= "左键：开关 "..tradeDispenser_ProgName,
				["right"]	= "右键: 清空交易记录",
				["noright"]	= "右键: 禁止清空",
			},
			["configbtn"]	= {
				["show"]	= "显示配置界面",
				["hide"]	= "隐藏配置界面",
				["left"]	= "左键: 打开简略配置界面",
				["right"]	= "右键: 打开完整配置中心",
			},
		},
		["control"]			= {
			["title"]		= "交易控制：",
			["ignore"]		= "忽略交易",
			["notraid"]		= "不在队内",
			["notinraid"]	= {	-- open end. could have more than 5 lines
				[0]			= "屏蔽陌生人",
				[1]			= "拒绝所有非团队及",
				[2]			= "队伍成员的交易请",
				[3]			= "求.此功能仅在加入",
				[4]			= "团队或队伍后生效",
			},
			["acceptguild"]	= "接受公会交易",
			["autoaccept"]	= "自动完成交易",
			["ClientInfos"]	="显示顾客信息",
			["accguild"]	= {	-- open end. could have more than 3 lines
				[0]			= "接受公会成员",
				[1]			= "的交易请求，即使对方",
				[2]			= "不在你的团队/队伍内",
			},
			["FreeCheckBox"]= "免费提供给团队/工会",
			["Free4Guild"]	= {
				[0]			= "如果打开次选项，物品将",
				[1]			= "免费提供给你的团队及工",
				[2]			= "会成员，他们不需要为",
				[3]			= "此支付额外的金币.",
			},			
			["leveltext"]	= "顾客级别",
			["level"]		= "等级最低：",
			["register"]	= "记录顾客",
			["maxtrades"]	= "最多交易次数:",
		},
		["Banlist"]			= {
			["Title"] 		= "屏蔽玩家:",
			["Import"] 		= "导入屏蔽列表",
			["Add"] 		= "添加",
			["Remove"] 		= "移除",
		},				
		["UImessages"]	= {
			["cancelled"]	= "交易取消",
			["complete"]	= "交易完成",
			["failed"]		= "交易失败！",
		},
		["KeyBindings"]		= {
			["header"]		= tradeDispenser_ProgName,
			[1]				= "启用/关闭自动售货机",
			[2]				= "显示/隐藏设置窗口",
			[3]				= "显示/隐藏快捷窗口",
			[4]				= "立刻广播",
		},	
		["activated"] 		= tradeDispenser_ProgName.." 已启用",
		["deactivated"] 	= tradeDispenser_ProgName.." 已禁用",
		["verbose"]		= {
			["isset"]	= "Verbose-Level is: ",
			["setto"]	= "Changed Verbose-Level to ",
		},
		["Alliance"]	= "通用语",
		["Horde"]       = "兽人语",
	}
end




function tradeDispenser_GetFrench()
	tradeDispenser_ProgName = "tradeDispenser";
	tD_Loc = {
		["logon"]			= {
			["changed"]		= "La version a changé. Remise à zéro de la configuration.",
			["welcome"] 	= " Version "..tradeDispenser_Version.." - initialisée",
		},	
		["configtitle"]		= tradeDispenser_ProgName.." V"..tradeDispenser_Version,
		["configItems"]		= "Insérez le Prix et les Objets",
		["about"]		= {	-- open end. could have more than 5 lines
			[0] = "About the "..tradeDispenser_ProgName,
			[1] = "   Version:   "..tradeDispenser_Version,
			[2] = "   Auteur:   	 Kaboom    @ Arthas (EU)",
			[3] = "   coeur:         Shag      @ Arthas (EU)",
			[4] = "   Traduction:   Balzebeth @ Conseil des Ombres (EU)",
			[5] = "   Autres:        Lire le ReadMe",
		},
		["help"]		= {	-- open end. could have more than 9 lines
			[0] = "Préfixe:",
			[1] = "  /td ou /tradeDispenser       Montre le texte d'aide",
			[2] = "Options (utilisation: Préfixe + Option)",
			[3] = "  config         Montre/Cache la Fenêtre de Configuration",
			[4] = "  toggle         Active/Désactive "..tradeDispenser_ProgName,
			[5] = "  broadcast   Diffuser votre annonce",
			[6] = "  OSD           Montrer/Cacher l'OSD (Boutons de Raccourcis)",
			[7] = "  verbose X   Niveau d'informations affiché par Debuginfo (0=désactivé)",
			[8] = "  resetpos      Remise à zéro de la position de toutes les fenêtres",
			[9] = "  about          Montre plus d'informations à propos de "..tradeDispenser_ProgName,
		},
		["whisper"]		= {		-- default messages - can be edited ingame
			[1] = {
				["short"]	= "Problème",
				["default"]	= tradeDispenser_ProgName..": Quelque chose ne fonctionne pas correctement avec mon inventaire (certainement du lag objet). Je ne peux échanger d'objets. Essaye à nouveau.",
			},
			[2]	= {
				["short"]	= "Plus d'objets",
				["default"]	= tradeDispenser_ProgName..": Je n'ai plus d'objets. Merci de ne plus faire d'échanges avec moi.",
			},
			[3] = {
				["short"]	= "Pile non complète",
				["default"]	= tradeDispenser_ProgName..": Désolé mais la dernière pile d'objets n'est pas complète. Néanmoins, accepte l'échange STP.",
			},
			[4]	= {
				["short"]	= "Pas d'autres objets",
				["default"]	= tradeDispenser_ProgName..": C'est tout ce que j'ai !",
			},
			[5] = {
				["short"]	= "J'ai besoin d'argent",
				["default"]	= tradeDispenser_ProgName..": Je vends ces objets pour ",
			},
			[6] = {
				["short"]	= "Trop bas niveau",
				["default"]	= "Ton niveau est trop bas! Je ne ferai pas d'échanges avec toi!",
			},
			[7]	= {
				["short"]	= "Pas dans la guilde",
				["default"]	= "Tu ne fais pas partie de ma guilde! Je ne ferai pas d'échanges avec toi!",
			},
			[8]	= {
				["short"]	= "Pas dans le raid",
				["default"]	= "Tu ne fais pas partie de mon Groupe/Raid! Je ne ferai pas d'échanges avec toi!",
			},
			[9] = {
				["short"] 	= "Echanges max. atteints",
				["default"]	= "Tu as déjà atteint le maximum d'échanges permis! Je ne ferai plus d'échanges avec toi!",
			},
			[10] = {
				["short"]	= "Joueur Banni",
				["default"]	= "Tu es sur ma liste de joueurs bannis! je ne ferai pas d'échanges avec toi!",
			},
			[11] = {
				["short"]	= "il reste 10s",
				["default"] = "Accepte l'échange STP, je l'annulerai dans 10 secondes",
			},
		},
		["Broadcast"] 				= {
			[1] 					= tradeDispenser_ProgName.." activé! Ouvrez une fenêtre d'échange avec moi et recevez vos objets!",
			[2]						= "éditez cette ligne pour définir votre annonce",
			[3]						= "Note: vous pouvez insérer des objets avec MAJ+click",
			[4]						= "Ajoutez d'autres messages",	
		},
		["noItemsToTrade"]			= "Désolé, pas d'objets définis pour ce type de client. Vérifiez les profils.",
		["Opposite"]				= "Votre client est:",
		["rack"]					= "Casier #",
		["RackTitle"]				= "Casier Actif",
		["resetframes"]				= "RAZ des fenêtre de "..tradeDispenser_ProgName..": faite";
		["buttons"]			= {
			["tradecontrol"] 		= "Contrôle",
			["settings"]			= "Paramètres",
			["enabled"]				= "Activé",
			["disabled"]			= "Désactivé",
			["hide"]				= "Cacher",
			["whispers"]			= "Chuchoter",
			["reset"]				= "Reset",
			["banlist"]				= "Bannis",
		},
		["profile"]			= {
			["title"]		= "Profils",
			[1]			= "Tout le monde",
			[2]			= "Guerrier",
			[3]			= "Voleur",
			[4]			= "Chasseur",
			[5]			= "Démoniste",
			[6]			= "Mage",
			[7]			= "Druide",
			[8]			= "Prêtre",
			[9]			= "Chamy/Pal",
			[10]		= "Mêlée",
			[11]		= "Util. Mana",
			[12]		= "Soigneur",
			["Alliance"] = "Paladin",
			["Horde"]	= "Chaman",
		},
		["channel"]			= {
			["say"]			= "DIRE",
			["yell"]		= "CRIER",
			["guild"]		= "GUILDE",
			["raid"]		= "RAID",
			["party"]		= "GROUPE",
		},
		["settings"]		= {
			["title"]		= "Paramètres:",
			["channel"]		= "Canal",
			["broadcasttext"]="Annonce",
			["broadcastopt"]= "Options des annonces:",
			["bkcolor"]		= "Couleur Fond",		
			["border"]		= "Bordure",
			["horiz"]		= "Rotation H/V",
			["osdtooltip"]	= {	-- open end. could have more than 3 lines
				[0] = "Montrer/Cacher OSD",
				[1] = "Activez ceci pour",
				[2] = "montrer l'OSD",
			},
			["broadcasttooltip"]	= {
				[0] = "Activer/Désactiver l'Annonce",
				[1] = "N'annonce que si",
				[2] = tradeDispenser_ProgName.." est en marche",
			},
			["lock"]		= "Ancré",
			["scale"]		= "Echelle:",
			["autobroadcast"]	= "Annonce Auto.:",
			["once"]		= "Une seule fois",
			["randomtext"]	= "Texte aléatoire:",
			["Hint"]	= {	-- open end. could have more than 4 lines
				[0]	= "Pour information:",
				[1] = "Les profils sont additifs, càd:",
				[2] = "Un guerrier recevrait les objets des profils:",
				[3] = "'Tout le monde' + 'Guerrier' + 'Mêlée'.",
				[4] = "NOTE: les Soigneurs ne recevront pas les objets ",
				[5] = "du profil 'Util. Mana'.",
			},
			["Timelimit"] = "Limite de temps",
			["TimerTooltip"] = {
				[0] = "Cette fonction active un chronomètre",
				[1] = "pour limiter la durée d'un échange",
				[2] = "avant que "..tradeDispenser_ProgName.." ne l'annule.",
				[3] = "Le client recevra un avertissement.",
				[4] = "Note: Ne fonctionne que si VOUS",
				[5] = "avez déjà accepté l'échange."
			},
		},
		["OSD"]				= {
			["OSDtitle"]	= "OSD",
			["notenabled"]	= tradeDispenser_ProgName.." is not enabled",
			["broadcasttip"]	= {
				["title"] 		= "Annoncer vos échanges",
				["channel"]		= "Canal de l'annonce: ",	-- here follows the localised channel-name
				["left"]		= "Clic Gauche:  Annonce instantannée",
				["right"]		= "Clic Droit: Activer/Désactiver l'annonce automatique",
			},
			["actbutton"] 	= {
				["activate"]	= "Activer "..tradeDispenser_ProgName,
				["deactivate"]	= "Désactiver "..tradeDispenser_ProgName,
				["left"]	= "Clic Gauche:  Activer/Désactiver "..tradeDispenser_ProgName,
				["right"]	= "Clic Droit: RAZ de la liste des clients enregistrés",
				["noright"]	= "Clic Droit: RAZ Désactivée",
			},
			["configbtn"]	= {
				["show"]	= "Montrer la fenêtre de configuration",
				["hide"]	= "Cacher la fenêtre de configuration",
				["left"]	= "Clic Gauche:  ouvrir la petite fenêtre de configuration",
				["right"]	= "Clic Droit: ouvrir le panneau de configuration complet",
			},
		},	
		["control"]			= {
			["title"]		= "Contrôle des échanges:",
			["ignore"]		= "Joueurs ignorés",
			["notraid"]		= "hors Raid/Groupe",		
			["notinraid"]	= {	-- open end. could have more than 5 lines
				[0]			= "Ignore les non-menbres du Raid/Groupe",
				[1]			= "Ignore toute requête d'échange",
				[2]			= "des non-membres de votre Raid/Groupe.",
				[3]			= "Ne fonctionne que si vous avez",
				[4]			= "rejoint un Raid/Groupe.",
			},
			["acceptguild"]	= "accepte Guilde",
			["autoaccept"]	= "Accepter auto.",
			["ClientInfos"]="Montrer les infos clients",
			["accguild"]	= {	-- open end. could have more than 3 lines
				[0]			= "Ne pas bloquer les membres de la guilde",
				[1]			= "Echange avec eux même s'ils",
				[2]			= "ne font pas partie de votre Raid/Groupe",
			},
			["FreeCheckBox"]= "Gratuit pour Raid/Guilde",
			["Free4Guild"]	= {
				[0]			= "Objets gratuits pour votre Raid/Guilde",
				[1]			= "Si vous activez cette option, les",
				[2]			= "membres de votre Raid/Guilde n'auront",
				[3]			= "pas à payer pour vos échanges.",
			},
			["leveltext"]	= "Niveau des clients",
			["level"]	= "au moins: ",
			["register"]	= "Enregistrer Clients",
			["maxtrades"]	= "Echanges Max:",
		},
		["Banlist"]			= {
			["Title"]		= "Joueurs Bannis:",
			["Import"]		= "Importer liste",
			["Add"]			= "Ajouter",
			["Remove"]		= "Enlever",
		},
		["UImessages"]		= {
			["cancelled"]	= "Echange annulé",
			["complete"]	= "Echange terminé",
			["failed"]		= "Echange échoué",
		},
		["KeyBindings"]		= {
			["header"]		= tradeDispenser_ProgName,
			[1]				= "Activer/Désactiver tradeDispenser",
			[2]				= "Montrer/Cacher fenêtre de configuration",
			[3]				= "Montrer/Cacher OSD",
			[4]				= "Annonce instantannée",
		},
		["activated"] 		= tradeDispenser_ProgName.." activé",
		["deactivated"] 	= tradeDispenser_ProgName.." désactivé",
		["verbose"]		= {
			["isset"]	= "Niveau d'informations affiché: ",
			["setto"]	= "Changer le niveau d'information affiché ",
		},
		["Alliance"]	= "Commun",
		["Horde"]       = "Orc",
	};
end
