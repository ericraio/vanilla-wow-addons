-- Version : German (by StarDust)
-- Last Update : 10/28/2005

if ( GetLocale() == "deDE" ) then

	PLAYER_GHOST 					= "Geist";
	PLAYER_WISP 					= "Verkleinert";
	FEIGN_DEATH					= "Totgestellt";

	ARCHAEOLOGIST_CONFIG_SEP			= "Arch\195\164ologe";
	ARCHAEOLOGIST_CONFIG_SEP_INFO			= "Einstellungen des Arch\195\164ologen";

	ARCHAEOLOGIST_FEEDBACK_STRING			= "%s ge\195\164ndert auf %s.";
	ARCHAEOLOGIST_NOT_A_VALID_FONT			= "%s ist keine g\195\188ltige Schriftart.";
	ArchaeologistLocalizedFonts = { 
		["Standard"] = "Default";
		--change fist string for displayd string
		--values must match ArchaeologistFonts keys
		["SpielSchriftNormal"] = "GameFontNormal";
		["ZahlenSchriftNormal"] = "NumberFontNormal";
		["GegenstandTextSchriftNormal"] = "ItemTextFontNormal";
	};
	
	ARCHAEOLOGIST_ON = "Ein";
	ARCHAEOLOGIST_OFF = "Aus";
	ARCHAEOLOGIST_MOUSEOVER = "Maus\195\156ber";
	
	ARCHAEOLOGIST_FONT_OPTIONS = "Schrift Optionen:"
	for key, name in ArchaeologistLocalizedFonts do
		ARCHAEOLOGIST_FONT_OPTIONS = " "..ARCHAEOLOGIST_FONT_OPTIONS..key..",";
	end
	ARCHAEOLOGIST_FONT_OPTIONS = string.sub(ARCHAEOLOGIST_FONT_OPTIONS, 1, string.len(ARCHAEOLOGIST_FONT_OPTIONS)-1);

	-- <= == == == == == == == == == == == == =>
	-- => Presets
	-- <= == == == == == == == == == == == == =>
	ARCHAEOLOGIST_CONFIG_PRESETS				= "Templates";
	ARCHAEOLOGIST_CONFIG_SET				= "Setzen";

	ARCHAEOLOGIST_CONFIG_VALUES_ON_BARS			= "Wertangaben auf den Leisten";
	ARCHAEOLOGIST_CONFIG_VALUES_NEXTTO_BARS			= "Wertangaben neben den Leisten";
	ARCHAEOLOGIST_CONFIG_PERCENTAGE_ON_BARS			= "Prozentangaben auf den Leiste";
	ARCHAEOLOGIST_CONFIG_PERCENTAGE_NEXTTO_BARS		= "Prozentangaben neben den Leiste";
	ARCHAEOLOGIST_CONFIG_PERCENTAGE_ON_VALUES_NEXTTO_BARS	= "Prozentangaben auf und\nWertangaben neben den Leiste";
	ARCHAEOLOGIST_CONFIG_VALUES_ON_PERCENTAGE_NEXTTO_BARS	= "Wertangaben auf und\nProzentangaben neben den Leiste";

	ARCHAEOLOGIST_CONFIG_PREFIXES_OFF			= "Alle Prefixe Aus";
	ARCHAEOLOGIST_CONFIG_PREFIXES_ON			= "Alle Prefixe Ein";
	ARCHAEOLOGIST_CONFIG_PREFIXES_DEFAULT			= "Alle Prefixe Standard";


	-- <= == == == == == == == == == == == == =>
	-- => Player Options
	-- <= == == == == == == == == == == == == =>
	ARCHAEOLOGIST_CONFIG_PLAYER_SEP			= "Eigenen Statusanzeige";
	ARCHAEOLOGIST_CONFIG_PLAYER_SEP_INFO		= "Die meisten Angaben werden standardm\195\164\195\159ig angezeigt, wenn der Mauszeiger \195\188ber den entsprechenden Statusbalken bewegt wird.";
			
	ARCHAEOLOGIST_CONFIG_PLAYERHP			= "Gesundheit immer anzeigen";
	ARCHAEOLOGIST_CONFIG_PLAYERHP_INFO		= "Wenn aktiviert, wird die eigene Gesundheit immer angezeigt und nicht erst wenn man den Mauszeiger \195\188ber den Gesundheitsbalken bewegt.";
	ARCHAEOLOGIST_CONFIG_PLAYERHP2			= "Gesungheit neben der Leiste immer anzeigen";
	ARCHAEOLOGIST_CONFIG_PLAYERHP2_INFO		= "Wenn aktiviert, wird die eigene Gesundheit rechts neben dem Balken immer angezeigt. (Wenn deaktiveirt, wird jene nur beim Bewegen der Maus \195\188ber den Balken angezeigt.)";
	ARCHAEOLOGIST_CONFIG_PLAYERMP			= "Mana, Wut oder Energie immer anzeigen";
	ARCHAEOLOGIST_CONFIG_PLAYERMP_INFO		= "Wenn aktiviert, wird das eigene Mana, Wut und Energie immer angezeigt und nicht erst wenn man den Mauszeiger \195\188ber den zweiten Statusbalken (unter Gesundheit) bewegt.";
	ARCHAEOLOGIST_CONFIG_PLAYERMP2			= "Mana, Wut oder Energie neben der Leiste\n immer anzeigen";
	ARCHAEOLOGIST_CONFIG_PLAYERMP2_INFO		= "Wenn aktiviert, wird das eigene Mana, Wut oder Energie rechts neben dem Balken immer angezeigt. (Wenn deaktiveirt, wird jene nur beim Bewegen der Maus \195\188ber den Balken angezeigt.)";
	ARCHAEOLOGIST_CONFIG_PLAYERXP			= "Erfahrung immer anzeigen";
	ARCHAEOLOGIST_CONFIG_PLAYERXP_INFO		= "Wenn aktiviert, wird die Erfahrung immer angezeigt und nicht erst wenn man den Mauszeiger \195\188ber den Erfahrungsbalken bewegt.";
	ARCHAEOLOGIST_CONFIG_PLAYERXPP			= "Erfahrung in Prozent anzeigen";
	ARCHAEOLOGIST_CONFIG_PLAYERXPP_INFO		= "Wenn aktiviert, wird die Erfahrung in Prozent angegeben.";
	ARCHAEOLOGIST_CONFIG_PLAYERXPV			= "Erfahrung als Wert anzeigen";
	ARCHAEOLOGIST_CONFIG_PLAYERXPV_INFO		= "Wenn aktiviert, wird die Erfahrung als genauer Wert angegeben.";
	ARCHAEOLOGIST_CONFIG_PLAYERHPINVERT		= "Gesundheit invertieren";
	ARCHAEOLOGIST_CONFIG_PLAYERHPINVERT_INFO	= "Wenn aktiviert, wird die eigene Gesundheit invertiert sodass nicht die momentane sondern die fehlende (aufs Maximum) Gesundheit angezeigt wird.";
	ARCHAEOLOGIST_CONFIG_PLAYERMPINVERT		= "Mana, Wut und Energie invertieren";
	ARCHAEOLOGIST_CONFIG_PLAYERMPINVERT_INFO	= "Wenn aktiviert, wird das eigene Mana, Wut und Energie invertiert sodass nicht die momentane sondern die fehlende (aufs Maximum) Mana, Wut und Energie angezeigt wird.";
	ARCHAEOLOGIST_CONFIG_PLAYERXPINVERT		= "Ben\195\182tigte Erfahrung bis Levelaufstig anzeigen";
	ARCHAEOLOGIST_CONFIG_PLAYERXPINVERT_INFO	= "Wenn aktiviert, wird die Anzeige der eigenen Erfahrung umgekehrt und die noch ben\195\182tigte Erfahrung bis zum Levelaufstig angezeigt und nicht die bereits in diesem Level erreichte.";
	ARCHAEOLOGIST_CONFIG_PLAYERHPNOPREFIX		= "Prefix 'Gesundheit' verbergen";
	ARCHAEOLOGIST_CONFIG_PLAYERHPNOPREFIX_INFO	= "Wenn aktiviert, wird der Prefix 'Gesundheit' im Gesundheitsbalken ausgeblendet und nur noch die Zahl angezeigt.";
	ARCHAEOLOGIST_CONFIG_PLAYERMPNOPREFIX		= "Prefix 'Mana', 'Wut' oder 'Energie' verbergen";
	ARCHAEOLOGIST_CONFIG_PLAYERMPNOPREFIX_INFO	= "Wenn aktiviert, wird der Prefix 'Mana', 'Wut' oder 'Energie' im zweiten Statusbalken (unter Gesundheit) ausgeblendet und nur noch die Zahl angezeigt.";
	ARCHAEOLOGIST_CONFIG_PLAYERXPNOPREFIX		= "Prefix 'Erfahrung' verbergen";
	ARCHAEOLOGIST_CONFIG_PLAYERXPNOPREFIX_INFO	= "Wenn aktiviert, wird der Prefix 'Erfahrung' im Erfahrungssbalken ausgeblendet und nur noch die Zahl angezeigt.";
	ARCHAEOLOGIST_CONFIG_PLAYERCLASSICON		= "Klassen-Icon anzeigen";
	ARCHAEOLOGIST_CONFIG_PLAYERCLASSICON_INFO	= "Wenn aktiviert, wird im eigenen Charakterfenster ein Icon gem\195\164\195\159 der eigene Klasse angezeigt.";	
	ARCHAEOLOGIST_CONFIG_PLAYERHPSWAP		= "Position der Gesundheit vertauschen";
	ARCHAEOLOGIST_CONFIG_PLAYERHPSWAP_INFO		= "Wenn aktiviert, wird die Angaben der Gesundheit innerhalb und rechts neben den jeweiligen Balken im eigenen Charakterportrait vertauscht.";
	ARCHAEOLOGIST_CONFIG_PLAYERMPSWAP		= "Position von Mana, Wut und Energie vertauschen";
	ARCHAEOLOGIST_CONFIG_PLAYERMPSWAP_INFO		= "Wenn aktiviert, werden die Angaben von Mana, Wut und Energie innerhalb und rechts neben den jeweiligen Balken im eigenen Charakterportrait vertauscht.";

	-- <= == == == == == == == == == == == == =>
	-- => Party Options
	-- <= == == == == == == == == == == == == =>
	ARCHAEOLOGIST_CONFIG_PARTY_SEP			= "Statusanzeigen der Gruppe";
	ARCHAEOLOGIST_CONFIG_PARTY_SEP_INFO		= "Die meisten Angaben werden standardm\195\164\195\159ig angezeigt, wenn der Mauszeiger \195\188ber den entsprechenden Statusbalken bewegt wird.";
	
	ARCHAEOLOGIST_CONFIG_PARTYHP			= "Gesundheit immer anzeigen";
	ARCHAEOLOGIST_CONFIG_PARTYHP_INFO		= "Wenn aktiviert, wird die Gesundheit von Gruppenmitgliedern immer angezeigt und nicht erst wenn man den Mauszeiger \195\188ber den jeweiligen Gesundheitsbalken bewegt.";
	ARCHAEOLOGIST_CONFIG_PARTYHP2			= "Gesungheit neben der Leiste\nimmer anzeigen";
	ARCHAEOLOGIST_CONFIG_PARTYHP2_INFO		= "Wenn aktiviert, wird die Gesundheit von Gruppenmitgliedern rechts neben dem Balken immer angezeigt. (Wenn deaktiveirt, wird jene nur beim Bewegen der Maus \195\188ber den Balken angezeigt.)";
	ARCHAEOLOGIST_CONFIG_PARTYMP			= "Mana, Wut und Energie immer anzeigen";
	ARCHAEOLOGIST_CONFIG_PARTYMP_INFO		= "Wenn aktiviert, wird das Mana, Wut und Energie von Gruppenmitgliedern immer angezeigt und nicht erst wenn man den Mauszeiger \195\188ber den jeweiligen Statusbalken bewegt.";
	ARCHAEOLOGIST_CONFIG_PARTYMP2			= "Mana, Wut oder Energie neben der Leiste\nimmer anzeigen";
	ARCHAEOLOGIST_CONFIG_PARTYMP2_INFO		= "Wenn aktiviert, wird das Mana, Wut oder Energie von Gruppenmitgliedern rechts neben dem Balken immer angezeigt. (Wenn deaktiveirt, wird jene nur beim Bewegen der Maus \195\188ber den Balken angezeigt.)";
	ARCHAEOLOGIST_CONFIG_PARTYHPINVERT		= "Gesundheit invertieren";
	ARCHAEOLOGIST_CONFIG_PARTYHPINVERT_INFO		= "Wenn aktiviert, wird die Gesundheit von Gruppenmitgliedern invertiert sodass nicht die momentane sondern die fehlende (aufs Maximum) Gesundheit angezeigt wird.";
	ARCHAEOLOGIST_CONFIG_PARTYMPINVERT		= "Mana, Wut und Energie invertieren";
	ARCHAEOLOGIST_CONFIG_PARTYMPINVERT_INFO		= "Wenn aktiviert, wird das Mana, Wut und Energie von Gruppenmitgliedern invertiert sodass nicht die momentane sondern die fehlende (aufs Maximum) Mana, Wut und Energie angezeigt wird.";
	ARCHAEOLOGIST_CONFIG_PARTYHPNOPREFIX		= "Prefix 'Gesundheit' verbergen";
	ARCHAEOLOGIST_CONFIG_PARTYHPNOPREFIX_INFO	= "Wenn aktiviert, wird der Prefix 'Gesundheit' des jeweiligen Gruppenmitglieds ausgeblendet und nur noch die Zahl angezeigt.";
	ARCHAEOLOGIST_CONFIG_PARTYMPNOPREFIX		= "Prefix 'Mana', 'Wut' oder 'Energie' verbergen";
	ARCHAEOLOGIST_CONFIG_PARTYMPNOPREFIX_INFO	= "Wenn aktiviert, wird der Prefix 'Mana', 'Wut' oder 'Energie' von Gruppenmitgliedern im jeweiligen zweiten Statusbalken (unter Gesundheit) ausgeblendet und nur noch die Zahl angezeigt.";
	ARCHAEOLOGIST_CONFIG_PARTYCLASSICON		= "Klassen-Icons anzeigen";
	ARCHAEOLOGIST_CONFIG_PARTYCLASSICON_INFO	= "Wenn aktiviert, wird im Gruppenfenster neben dem jeweiligen Charakter ein Icon f\195\188r die entsprechende Klasse angezeigt.";
	ARCHAEOLOGIST_CONFIG_PARTYHPSWAP			= "Position der Gesundheit vertauschen";
	ARCHAEOLOGIST_CONFIG_PARTYHPSWAP_INFO		= "Wenn aktiviert, werden die Angaben der Gesundheit innerhalb und rechts neben den jeweiligen Balken der jeweiligen Gruppenmitglieder vertauscht.";
	ARCHAEOLOGIST_CONFIG_PARTYMPSWAP			= "Position von Mana, Wut und Energie vertauschen";
	ARCHAEOLOGIST_CONFIG_PARTYMPSWAP_INFO		= "Wenn aktiviert, werden die Angaben von Mana, Wut und Energie innerhalb und rechts neben den jeweiligen Balken der jeweiligen Gruppenmitglieder vertauscht.";

	-- <= == == == == == == == == == == == == =>
	-- => Pet Options
	-- <= == == == == == == == == == == == == =>
	ARCHAEOLOGIST_CONFIG_PET_SEP			= "Statusanzeigen des Pet";
	ARCHAEOLOGIST_CONFIG_PET_SEP_INFO		= "Die meisten Angaben werden standardm\195\164\195\159ig angezeigt, wenn der Mauszeiger \195\188ber den entsprechenden Statusbalken bewegt wird.";

	ARCHAEOLOGIST_CONFIG_PETHP			= "Gesundheit immer anzeigen";
	ARCHAEOLOGIST_CONFIG_PETHP_INFO			= "Wenn aktiviert, wird die Zahl der Gesundheit des Pet immer angezeigt und nicht erst wenn man den Mauszeiger \195\188ber dessen Gesundheitsbalken bewegt.";
	ARCHAEOLOGIST_CONFIG_PETHP2			= "Gesundheit neben der Leiste\nimmer anzeigen";
	ARCHAEOLOGIST_CONFIG_PETHP2_INFO		= "Wenn aktiviert, wird die Gesundheit des Pet rechts neben dem Balken immer angezeigt. (Wenn deaktiveirt, wird jene nur beim Bewegen der Maus \195\188ber den Balken angezeigt.)";
	ARCHAEOLOGIST_CONFIG_PETMP			= "Mana, Wut oder Energie immer anzeigen";
	ARCHAEOLOGIST_CONFIG_PETMP_INFO			= "Wenn aktiviert, wird das Mana, Wut oder Energie des Pet immer angezeigt und nicht erst wenn man den Mauszeiger \195\188ber dessen zweiten Statusbalken (unter Gesundheit) bewegt.";
	ARCHAEOLOGIST_CONFIG_PETMP2			= "Mana neben der Leiste immer anzeigen";
	ARCHAEOLOGIST_CONFIG_PETMP2_INFO		= "Wenn aktiviert, wird das Mana des Pets rechts neben dem Balken immer angezeigt. (Wenn deaktiveirt, wird jene nur beim Bewegen der Maus \195\188ber den Balken angezeigt.)";
	ARCHAEOLOGIST_CONFIG_PETXP			= "Erfahrung anzeigen";
	ARCHAEOLOGIST_CONFIG_PETXP_INFO			= "Wenn aktiviert, wird die Erfahrung des Pet im Balken angezeigt.";
	ARCHAEOLOGIST_CONFIG_PETXPP			= "Erfahrung in Prozent anzeigen";
	ARCHAEOLOGIST_CONFIG_PETXPP_INFO		= "Wenn aktiviert, wird die Erfahrung des Pet in Prozent angegeben.";
	ARCHAEOLOGIST_CONFIG_PETXPV			= "Erfahrung als Wert anzeigen";
	ARCHAEOLOGIST_CONFIG_PETXPV_INFO		= "Wenn aktiviert, wird die Erfahrung des Pet als genauer Wert angegeben.";
	ARCHAEOLOGIST_CONFIG_PETHPINVERT		= "Gesundheit invertieren";
	ARCHAEOLOGIST_CONFIG_PETHPINVERT_INFO		= "Wenn aktiviert, wird die Gesundheit des Pet invertiert sodass nicht die momentane sondern die fehlende (aufs Maximum) Gesundheit angezeigt wird.";
	ARCHAEOLOGIST_CONFIG_PETMPINVERT		= "Mana invertieren";
	ARCHAEOLOGIST_CONFIG_PETMPINVERT_INFO		= "Wenn aktiviert, wird das Mana des Pet invertiert sodass nicht das momentane sondern das fehlende (aufs Maximum) Mana angezeigt wird.";
	ARCHAEOLOGIST_CONFIG_PETHPNOPREFIX		= "Prefix 'Gesundheit' verbergen";
	ARCHAEOLOGIST_CONFIG_PETHPNOPREFIX_INFO		= "Wenn aktiviert, wird der Prefix 'Gesundheit' des Pet ausgeblendet und nur noch die Zahl angezeigt.";
	ARCHAEOLOGIST_CONFIG_PETMPNOPREFIX		= "Prefix 'Mana' verbergen";
	ARCHAEOLOGIST_CONFIG_PETMPNOPREFIX_INFO		= "Wenn aktiviert, wird der Prefix 'Mana' des Pet in dessem zweiten Statusbalken (unter Gesundheit) ausgeblendet und nur noch die Zahl angezeigt.";
	ARCHAEOLOGIST_CONFIG_PETXPNOPREFIX		= "Prefix 'Erfahrung' verbergen";
	ARCHAEOLOGIST_CONFIG_PETXPNOPREFIX_INFO		= "Wenn aktiviert, wird der Prefix 'Erfahrung' im Erfahrungssbalken des Pet ausgeblendet und nur noch die Zahl angezeigt.";
	ARCHAEOLOGIST_CONFIG_PETHPSWAP			= "Position der Gesundheit vertauschen";
	ARCHAEOLOGIST_CONFIG_PETHPSWAP_INFO		= "Wenn aktiviert, werden die Angaben der Gesundheit innerhalb und rechts neben den jeweiligen Balken im Petportrait vertauscht.";
	ARCHAEOLOGIST_CONFIG_PETMPSWAP			= "Position des Mana vertauschen";
	ARCHAEOLOGIST_CONFIG_PETMPSWAP_INFO		= "Wenn aktiviert, werden die Angaben des Mana innerhalb und rechts neben den jeweiligen Balken im Petportrait vertauscht.";
	
	-- <= == == == == == == == == == == == == =>
	-- => Target Options
	-- <= == == == == == == == == == == == == =>
	ARCHAEOLOGIST_CONFIG_TARGET_SEP			= "Statusanzeigen des Ziels";
	ARCHAEOLOGIST_CONFIG_TARGET_SEP_INFO		= "Die meisten Angaben werden standardm\195\164\195\159ig angezeigt, wenn der Mauszeiger \195\188ber den entsprechenden Statusbalken bewegt wird.";

	ARCHAEOLOGIST_CONFIG_TARGETHP			= "Gesundheit immer anzeigen (nur in Prozent)";
	ARCHAEOLOGIST_CONFIG_TARGETHP_INFO		= "Wenn aktiviert, wird die Zahl der Gesundheit des momentanen Ziels im Zielfenster immer angezeigt und nicht erst wenn man den Mauszeiger \195\188ber dessen Gesundheitsbalken bewegt.";
	ARCHAEOLOGIST_CONFIG_TARGETHP2			= "Gesungheit neben der Leiste\nimmer anzeigen";
	ARCHAEOLOGIST_CONFIG_TARGETHP2_INFO		= "Wenn aktiviert, wird die Gesundheit des Ziels links neben dem Balken immer angezeigt. (Wenn deaktiveirt, wird jene nur beim Bewegen der Maus \195\188ber den Balken angezeigt.)";
	ARCHAEOLOGIST_CONFIG_TARGETMP			= "Mana immer anzeigen";
	ARCHAEOLOGIST_CONFIG_TARGETMP_INFO		= "Wenn aktiviert, wird das Mana, Wut oder Energie des momentanen Ziels im Zielfenster immer angezeigt und nicht erst wenn man den Mauszeiger \195\188ber dessen Statusbalken bewegt.";
	ARCHAEOLOGIST_CONFIG_TARGETMP2			= "Mana neben der Leiste immer anzeigen";
	ARCHAEOLOGIST_CONFIG_TARGETMP2_INFO		= "Wenn aktiviert, wird das Mana des Ziels links neben dem Balken immer angezeigt. (Wenn deaktiveirt, wird jene nur beim Bewegen der Maus \195\188ber den Balken angezeigt.)";
	ARCHAEOLOGIST_CONFIG_TARGETHPINVERT		= "Gesundheit invertieren";
	ARCHAEOLOGIST_CONFIG_TARGETHPINVERT_INFO	= "Wenn aktiviert, wird die Gesundheit des Ziels invertiert sodass nicht die momentane sondern die fehlende (aufs Maximum) Gesundheit angezeigt wird.";
	ARCHAEOLOGIST_CONFIG_TARGETMPINVERT		= "Mana invertieren";
	ARCHAEOLOGIST_CONFIG_TARGETMPINVERT_INFO	= "Wenn aktiviert, wird das Mana des Ziels invertiert sodass nicht das momentane sondern das fehlende (aufs Maximum) Mana angezeigt wird.";
	ARCHAEOLOGIST_CONFIG_TARGETHPNOPREFIX		= "Prefix 'Gesundheit' verbergen";
	ARCHAEOLOGIST_CONFIG_TARGETHPNOPREFIX_INFO	= "Wenn aktiviert, wird der Prefix 'Gesundheit' des momentanen Ziels im Zielfenster ausgeblendet und nur noch die Zahl angezeigt.";
	ARCHAEOLOGIST_CONFIG_TARGETMPNOPREFIX		= "Prefix 'Mana' verbergen";
	ARCHAEOLOGIST_CONFIG_TARGETMPNOPREFIX_INFO	= "Wenn aktiviert, wird der Prefix 'Mana' des momentanen Ziels im Zielfenster in dessem zweiten Statusbalken (unter Gesundheit) ausgeblendet und nur noch die Zahl angezeigt.";
	ARCHAEOLOGIST_CONFIG_TARGETCLASSICON		= "Klassen-Icon anzeigen";
	ARCHAEOLOGIST_CONFIG_TARGETCLASSICON_INFO	= "Wenn aktiviert, wird im Zielfenster ein Icon gem\195\164\195\159 der jeweiligen Klasse des Ziels angezeigt.";
	ARCHAEOLOGIST_CONFIG_TARGETHPSWAP		= "Position der Gesundheit vertauschen";
	ARCHAEOLOGIST_CONFIG_TARGETHPSWAP_INFO		= "Wenn aktiviert, werden die Angaben der Gesundheit innerhalb und links neben den jeweiligen Balken im Petportrait vertauscht.";
	ARCHAEOLOGIST_CONFIG_TARGETMPSWAP		= "Position des Mana vertauschen";
	ARCHAEOLOGIST_CONFIG_TARGETMPSWAP_INFO		= "Wenn aktiviert, werden die Angaben des Mana innerhalb und links neben den jeweiligen Balken im Petportrait vertauscht.";

	-- <= == == == == == == == == == == == == =>
	-- => Alternate Options
	-- <= == == == == == == == == == == == == =>
	ARCHAEOLOGIST_CONFIG_ALTOPTS_SEP		= "Sonstige Einstellungen";
	ARCHAEOLOGIST_CONFIG_ALTOPTS_SEP_INFO		= "Sonstige Einstellungen";

	ARCHAEOLOGIST_CONFIG_HPCOLOR			= "Farbwechsel des Gesundheitsbalken aktivieren";
	ARCHAEOLOGIST_CONFIG_HPCOLOR_INFO		= "Wenn aktiviert, \195\164ndert der Gesundheitsbalken seine Farbe je weniger Gesundheit vorhanden ist.";

	ARCHAEOLOGIST_CONFIG_DEBUFFALT			= "Alternative Position der Debufficons";
	ARCHAEOLOGIST_CONFIG_DEBUFFALT_INFO		= "Wenn aktiviert, werden Debufficons des Pet und von Gruppenmitgliedern unter deren Bufficons angezeigt. Standardm\195\164\195\159ig werden jene neben dem jeweiligen Portraitfenster angezeigt.";

	ARCHAEOLOGIST_CONFIG_TBUFFALT			= "Buff-/Debuff-Icons in Reihen zu je 8 anordnen";
	ARCHAEOLOGIST_CONFIG_TBUFFALT_INFO		= "Wenn aktiviert, werden die Buff- und Debufficons des Ziels in Reihen mit jeweils 8 Icons angeordnet.";

	ARCHAEOLOGIST_CONFIG_USEHPVALUE			= "Gesundheit des Ziels als Wert anzeigen";
	ARCHAEOLOGIST_CONFIG_USEHPVALUE_INFO		= "Wenn aktiviert, wird wenn m\195\182glich die Gesundheit des Ziels als Wert und nicht in Prozent angezeigt.";

	ARCHAEOLOGIST_CONFIG_MOBHEALTH			= "MobHealth2 f\195\188r Gesundheitsanzeige des Ziels verwenden";
	ARCHAEOLOGIST_CONFIG_MOBHEALTH_INFO		= "Verbirgt den normalen MobHealth2 Text und verwendet jenen anstelle des Textes f\195\188r die Gesundheitsanzeige im Zielfenster.";

	ARCHAEOLOGIST_CONFIG_CLASSPORTRAIT		= "Klassenportrait verwenden";
	ARCHAEOLOGIST_CONFIG_CLASSPORTRAIT_INFO		= "Wenn aktiviert, wird wenn m\195\182glich das Charakterportrait mit dem Klassenicon ersetzt.";

	-- <= == == == == == == == == == == == == =>
	-- => Font Options
	-- <= == == == == == == == == == == == == =>
	ARCHAEOLOGIST_CONFIG_FONTOPTS_SEP		= "Schriftart Einstellungen";
	ARCHAEOLOGIST_CONFIG_FONTOPTS_SEP_INFO		= "Erlaubt es die Schriftart und -gr\195\182\195\159e der Statustexte in den Balken festzulegen.";

	ARCHAEOLOGIST_CONFIG_HPMPLARGESIZE		= "Schriftgr\195\182\195\159e des\nEigenen-/Ziel-Portraits";
	ARCHAEOLOGIST_CONFIG_HPMPLARGESIZE_SLIDERTEXT   = "Schriftgr\195\182\195\159e";

	ARCHAEOLOGIST_CONFIG_HPMPLARGEFONT		= "Schriftart des\nEigenen-/Ziel-Portraits";
	ARCHAEOLOGIST_CONFIG_HPMPLARGEFONT_INFO		= ARCHAEOLOGIST_CONFIG_HPMPLARGEFONT.."\n Schriftoptionen: %s";

	ARCHAEOLOGIST_CONFIG_HPMPSMALLSIZE		= "Schriftgr\195\182\195\159e des\nGruppen-/Pet-Portraits";
	ARCHAEOLOGIST_CONFIG_HPMPSMALLSIZE_SLIDERTEXT   = "Schriftgr\195\182\195\159e";

	ARCHAEOLOGIST_CONFIG_HPMPSMALLFONT		= "Schriftart des\nGruppen-/Pet-Portraits";
	ARCHAEOLOGIST_CONFIG_HPMPSMALLFONT_INFO		= ARCHAEOLOGIST_CONFIG_HPMPSMALLFONT.."\n Schriftoptionen: %s";

	ARCHAEOLOGIST_COLOR_CHANGED			= "|c%s%s Farbe ge\195\164ndert.|r";
	ARCHAEOLOGIST_COLOR_RESET			= "|c%s%s Farbe zur\195\188ckgesetzt.|r";

	ARCHAEOLOGIST_CONFIG_COLORPHP			= "Prim\195\164re Farbe der Gesundheit\n(Standard ist wei\195\159)";
	ARCHAEOLOGIST_CONFIG_COLORPHP_INFO		= "\195\132ndert die Farbe der prim\195\164ren Gesundheitsangabe.";
	ARCHAEOLOGIST_CONFIG_COLORPHP_RESET		= "Farbe zur\195\188cksetzen";
	ARCHAEOLOGIST_CONFIG_COLORPHP_RESET_INFO	= "Setzt die Farbe der prim\195\164ren Gesundheitsangabe zur\195\188ck.";

	ARCHAEOLOGIST_CONFIG_COLORPMP			= "Prim\195\164re Farbe des Mana, Wut oder Energie\n(Standard ist wei\195\159)";
	ARCHAEOLOGIST_CONFIG_COLORPMP_INFO		= "\195\132ndert die Farbe der prim\195\164ren Mana-,Wut,Energieangabe.";
	ARCHAEOLOGIST_CONFIG_COLORPMP_RESET		= "Farbe zur\195\188cksetzen";
	ARCHAEOLOGIST_CONFIG_COLORPMP_RESET_INFO	= "Setzt die Farbe der prim\195\164ren Mana-,Wut-,Energieangabe zur\195\188ck.";

	ARCHAEOLOGIST_CONFIG_COLORSHP			= "Sekund\195\164re Farbe der Gesundheit\n(Standard ist wei\195\159)";
	ARCHAEOLOGIST_CONFIG_COLORSHP_INFO		= "\195\132ndert die Farbe der sekund\195\164ren Gesundheitsangabe.";
	ARCHAEOLOGIST_CONFIG_COLORSHP_RESET		= "Farbe zur\195\188cksetzen";
	ARCHAEOLOGIST_CONFIG_COLORSHP_RESET_INFO	= "Setzt die Farbe der sekund\195\164ren Gesundheitsangabe zur\195\188ck.";

	ARCHAEOLOGIST_CONFIG_COLORSMP			= "Sekund\195\164re Farbe des Mana, Wut oder Energie\n(Standard ist wei\195\159)";
	ARCHAEOLOGIST_CONFIG_COLORSMP_INFO		= "\195\132ndert die Farbe der sekund\195\164ren Mana-,Wut,Energieangabe";
	ARCHAEOLOGIST_CONFIG_COLORSMP_RESET		= "Farbe zur\195\188cksetzen";
	ARCHAEOLOGIST_CONFIG_COLORSMP_RESET_INFO	= "Setzt die Farbe der sekund\195\164ren Mana-,Wut-,Energieangabe zur\195\188ck.";

	-- <= == == == == == == == == == == == == =>
	-- => Party Buff Options
	-- <= == == == == == == == == == == == == =>
	ARCHAEOLOGIST_CONFIG_PARTYBUFFS_SEP		= "Buff-Einstellungen der Gruppe";
	ARCHAEOLOGIST_CONFIG_PARTYBUFFS_SEP_INFO	= "Standardm\195\164\195\159ig werden 16 Bufficons und 16 Debufficons angezeigt.";

	ARCHAEOLOGIST_CONFIG_PBUFFS			= "Buffs von Gruppenmitgliedern verbergen";
	ARCHAEOLOGIST_CONFIG_PBUFFS_INFO		= "Wenn aktiviert, werden Buffs von Gruppenmitgliedern nur angezeigt wenn man den Mauszeiger \195\188ber deren Portraitfenster bewegt.";

	ARCHAEOLOGIST_CONFIG_PBUFFNUM			= "Anzahl der angezeigten Buffs";
	ARCHAEOLOGIST_CONFIG_PBUFFNUM_INFO		= "Legt die Anzahl der angezeigten Buffs von Gruppenmitgliedern fest.";
	ARCHAEOLOGIST_CONFIG_PBUFFNUM_SLIDER_TEXT	= "Buffs";

	ARCHAEOLOGIST_CONFIG_PDEBUFFS			= "Debuffs von Gruppenmitgliedern verbergen";
	ARCHAEOLOGIST_CONFIG_PDEBUFFS_INFO		= "Wenn aktiviert, werden Debuffs von Gruppenmitgliedern nicht angezeigt.";

	ARCHAEOLOGIST_CONFIG_PDEBUFFNUM		= "Anzahl der angezeigten Debuffs";
	ARCHAEOLOGIST_CONFIG_PDEBUFFNUM_INFO		= "Legt die Anzahl der angezeigten Debuffs von Gruppenmitglied fest.";
	ARCHAEOLOGIST_CONFIG_PDEBUFFNUM_SLIDER_TEXT	= "Debuffs";

	-- <= == == == == == == == == == == == == =>
	-- => Party Pet Buff Options
	-- <= == == == == == == == == == == == == =>
	ARCHAEOLOGIST_CONFIG_PARTYPETBUFFS_SEP		= "Buff-Einstellungen der Pets der Gruppe";
	ARCHAEOLOGIST_CONFIG_PARTYPETBUFFS_SEP_INFO	= "Standardm\195\164\195\159ig werden 16 Bufficons und 16 Debufficons angezeigt.";

	ARCHAEOLOGIST_CONFIG_PPTBUFFS			= "Buffs der Pets von Gruppenmitgliedern verbergen";
	ARCHAEOLOGIST_CONFIG_PPTBUFFS_INFO		= "Wenn aktiviert, werden Buffs der Pets von Gruppenmitgliedern nur angezeigt wenn man den Mauszeiger \195\188ber deren Portraitfenster bewegt.";

	ARCHAEOLOGIST_CONFIG_PPTBUFFNUM		= "Anzahl der angezeigten Buffs";
	ARCHAEOLOGIST_CONFIG_PPTBUFFNUM_INFO		= "Legt die Anzahl der angezeigten Buffs von Pets der Gruppenmitglieder fest.";
	ARCHAEOLOGIST_CONFIG_PPTBUFFNUM_SLIDER_TEXT	= "Buffs";

	ARCHAEOLOGIST_CONFIG_PPTDEBUFFS			= "Debuffs der Pets von Gruppenmitgliedern verbergen";
	ARCHAEOLOGIST_CONFIG_PPTDEBUFFS_INFO		= "Wenn aktiviert, werden Debuffs der Pets von Gruppenmitgliedern nicht angezeigt.";

	ARCHAEOLOGIST_CONFIG_PPTDEBUFFNUM		= "Anzahl der angezeigten Debuffs";
	ARCHAEOLOGIST_CONFIG_PPTDEBUFFNUM_INFO		= "Legt die Anzahl der angezeigten Debuffs von Pets der Gruppenmitglieder fest.";
	ARCHAEOLOGIST_CONFIG_PPTDEBUFFNUM_SLIDER_TEXT	= "Debuffs";

	-- <= == == == == == == == == == == == == =>
	-- => Pet Buff Options
	-- <= == == == == == == == == == == == == =>
	ARCHAEOLOGIST_CONFIG_PETBUFFS_SEP		= "Buff-Einstellungen des Pet";
	ARCHAEOLOGIST_CONFIG_PETBUFFS_SEP_INFO		= "Standardm\195\164\195\159ig werden 16 Bufficons und 4 Debufficons angezeigt.";

	ARCHAEOLOGIST_CONFIG_PTBUFFS			= "Buffs des Pet verbergen";
	ARCHAEOLOGIST_CONFIG_PTBUFFS_INFO		= "Wenn aktiviert, werden Buffs des Pet nur angezeigt wenn man den Mauszeiger \195\188ber dessen Portraitfenster bewegt.";

	ARCHAEOLOGIST_CONFIG_PTBUFFNUM			= "Anzahl der angezeigten Buffs";
	ARCHAEOLOGIST_CONFIG_PTBUFFNUM_INFO		= "Legt die Anzahl der angezeigten Buffs des Pet fest.";
	ARCHAEOLOGIST_CONFIG_PTBUFFNUM_SLIDER_TEXT	= "Buffs";

	ARCHAEOLOGIST_CONFIG_PTDEBUFFS			= "Debuffs des Pet verbergen";
	ARCHAEOLOGIST_CONFIG_PTDEBUFFS_INFO		= "Wenn aktiviert, werden Debuffs des Pet nicht angezeigt.";

	ARCHAEOLOGIST_CONFIG_PTDEBUFFNUM		= "Anzahl der angezeigten Debuffs";
	ARCHAEOLOGIST_CONFIG_PTDEBUFFNUM_INFO		= "Legt die Anzahl der angezeigten Debuffs des Pet fest.";
	ARCHAEOLOGIST_CONFIG_PTDEBUFFNUM_SLIDER_TEXT	= "Debuffs";

	-- <= == == == == == == == == == == == == =>
	-- => Target Buff Options
	-- <= == == == == == == == == == == == == =>
	ARCHAEOLOGIST_CONFIG_TARGETBUFFS_SEP		= "Buff-Einstellungen des Ziels";
	ARCHAEOLOGIST_CONFIG_TARGETBUFFS_SEP_INFO	= "Standardm\195\164\195\159ig werden 8 Bufficons und 16 Debufficons angezeigt.";

	ARCHAEOLOGIST_CONFIG_TBUFFS			= "Buffs des Ziels verbergen";
	ARCHAEOLOGIST_CONFIG_TBUFFS_INFO		= "Wenn aktiviert, werden Buffs des angew\195\164hlten Ziels nicht angezeigt.";

	ARCHAEOLOGIST_CONFIG_TBUFFNUM			= "Anzahl der angezeigten Buffs";
	ARCHAEOLOGIST_CONFIG_TBUFFNUM_INFO		= "Legt die Anzahl der angezeigten Buffs des angew\195\164hlten Ziels fest.";
	ARCHAEOLOGIST_CONFIG_TBUFFNUM_SLIDER_TEXT	= "Buffs";

	ARCHAEOLOGIST_CONFIG_TDEBUFFS			= "Debuffs des Ziels verbergen";
	ARCHAEOLOGIST_CONFIG_TDEBUFFS_INFO		= "Wenn aktiviert, werden Debuffs des angew\195\164hlten Ziels nicht angezeigt.";

	ARCHAEOLOGIST_CONFIG_TDEBUFFNUM			= "Anzahl der angezeigten Debuffs";
	ARCHAEOLOGIST_CONFIG_TDEBUFFNUM_INFO		= "Legt die Anzahl der angezeigten Debuffs des angew\195\164hlten Ziels fest.";
	ARCHAEOLOGIST_CONFIG_TDEBUFFNUM_SLIDER_TEXT	= "Debuffs";

	ARCHAEOLOGIST_FEEDBACK_STRING			= "%s ist momentan auf %s gesetzt.";

end