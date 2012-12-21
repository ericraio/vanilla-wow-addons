

if (GetLocale() == "deDE") then
	XPERL_ADMIN_TITLE	= "X-Perl Schlachtzugadmin"

	XPERL_BUTTON_ADMIN_PIN		= "Pin das Fenster"
	XPERL_BUTTON_ADMIN_LOCKOPEN	= "Halte das Fenster offen"
	XPERL_BUTTON_ADMIN_SAVE1	= "Speichere die Liste"
	XPERL_BUTTON_ADMIN_SAVE2	= "Speichere die derzeitige Liste unter dem spezifischen Namen. Wenn kein Name angegeben wird, wird die aktulle Zeit als Name benutzt"
	XPERL_BUTTON_ADMIN_LOAD1	= "Lade die Liste"
	XPERL_BUTTON_ADMIN_LOAD2	= "Lade die ausgew\195\164hlte Liste. Jedes Schlachtzugsmitglied der gespeicherten Liste, welches nicht l\195\164nger im Schlachtzug ist, wird mit einem Mitglieder derselben Klasse ersetzt, welches nicht Miglied der Liste ist"
	XPERL_BUTTON_ADMIN_DELETE1	= "L\195\182sche die Liste"
	XPERL_BUTTON_ADMIN_DELETE2	= "L\195\182sche die ausgew\195\164hlte Liste"
	XPERL_BUTTON_ADMIN_STOPLOAD1	= "Stoppe das Laden"
	XPERL_BUTTON_ADMIN_STOPLOAD2	= "Breche den Ladevorgang f\195\188r die Liste ab"

	XPERL_LOAD			= "Laden"

	XPERL_SAVED_ROSTER		= "Gespeicherte Liste hei\195\159t '%s'"
	XPERL_ADMIN_DIFFERENCES		= "%d Unterschiede zur aktuellen Liste"
	XPERL_NO_ROSTER_NAME_GIVEN	= "Kein Listenname angegeben"
	XPERL_NO_ROSTER_CALLED		= "Kein gespeicherter Listenname hei\195\159t '%s'"

	XPERL_RAID_TOOLTIP_NOCTRA        = "Kein CTRA gefunden"

	-- Item Checker
	XPERL_CHECK_TITLE		= "X-Perl Item-Check"
	XPERL_CHECK_QUERY_DESC1		= "Abfrage"
	XPERL_CHECK_QUERY_DESC2		= "F\195\188hrt einen Item-Check (/raitem) auf alle angekreuzten Items durch \rQuery liefert immer die aktuelle Haltbarkeit, Widerst\195\164nde und Reagenzieninfos"
	XPERL_CHECK_LAST_DESC1		= "Letzte"
	XPERL_CHECK_LAST_DESC2		= "Kreuze die zuletzt gesuchten Items an"
	XPERL_CHECK_ALL_DESC1		= ALL		-- "Alle"
	XPERL_CHECK_ALL_DESC2		= "Alle Items ankreuzen"
	XPERL_CHECK_NONE_DESC1		= NONE		-- "Nichts"
	XPERL_CHECK_NONE_DESC2		= "W\195\164hle alle Items ab"
	XPERL_CHECK_DELETE_DESC1	= DELETE	-- "L\195\150SCHEN"
	XPERL_CHECK_DELETE_DESC2	= "Entferne immer alle angekreuzten Items von der Liste"
	XPERL_CHECK_REPORT_DESC1	= "Bericht"
	XPERL_CHECK_REPORT_DESC2	= "Zeige den Bericht der ausgew\195\164hlten Ergebnisse im Schlachtzugschannel"
	XPERL_CHECK_REPORT_WITH_DESC1	= "Mit"
	XPERL_CHECK_REPORT_WITH_DESC2	= "Melde Spieler mit dem Item (oder die, die das Item nicht tragen) im Schlachtzugschannel"
	XPERL_CHECK_REPORT_WITHOUT_DESC1= "Ohne"
	XPERL_CHECK_REPORT_WITHOUT_DESC2= "Melde Spieler ohne das Item (oder die, die das Item tragen) im Schlachtzugschannel"

	XPERL_CHECK_BROKEN		= "Zerbrochen"
	XPERL_CHECK_REPORT_DURABILITY	= "Durchschnittliche Schlachtzugshaltbarkeit: %d%% und %d Spieler mit insgesamt %d zerbrochenen Items"
	XPERL_CHECK_REPORT_RESISTS	= "Durchschnittliche Schlachtzugswiderst\195\164nde: %d "..SPELL_SCHOOL2_CAP..", %d "..SPELL_SCHOOL3_CAP..", %d "..SPELL_SCHOOL4_CAP..", %d "..SPELL_SCHOOL5_CAP..", %d "..SPELL_SCHOOL6_CAP
	XPERL_CHECK_REPORT_WITH		= " - mit (oder nicht tragend): "
	XPERL_CHECK_REPORT_WITHOUT	= " - ohne (oder tragend): "
	XPERL_CHECK_REPORT_WITHSHORT	= " : %d mit"
	XPERL_CHECK_REPORT_WITHOUTSHORT	= " : %d ohne"

	XPERL_CHECK_LASTINFO		= "Letzte Daten empfangen %s"

	XPERL_CHECK_DROPITEMTIP1	= "Ziehbare Items"
	XPERL_CHECK_DROPITEMTIP2	= "Items k\195\182nnen in diesen Frame gezogen werden und zur Liste der abfragbaren Items hinzugef\195\188gt werden.\rDu kannst auch ganz normal das /raitem Kommando benutzen und Items werden hier hinzugef\195\188gt und in der Zukunft benutzt."

	XPERL_REAGENTS			= {PRIEST = "Hochheilige Kerze", MAGE = "Arkanes Pulver", DRUID = "Wilder Dornwurz",
					SHAMAN = "Ankh", WARLOCK = "Seelensplitter", PALADIN = "Symbol der Offenbarung",
					ROGUE = "Flash Powder"}

end
