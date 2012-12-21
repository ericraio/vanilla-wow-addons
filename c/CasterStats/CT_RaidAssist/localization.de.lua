if ( GetLocale() == "deDE" ) then
	-- Version : German ( by Hjörvarör )
	-- Last Update : 06/01/2005
	CT_RAMENU_INSTALLATION = "CT_RaidAssist ist ein Mod geschaffen um deinem Raid in verschiedenen Situationen zu helfen. Er erlaubt dir Gesundheit & Mana/Energie/Wut von jedem in deinem Raid sowie Gesundheit & Mana der Ziele von bis zu 5 Leuten zu \195\188berwachen.  Du kannst bis zu 4 Buffs deiner Wahl anzeigen lassen, dir anzeigen lassen wenn ein Spieler einen Debuff erh\195\164lt und dich benachrichtigen lassen zu heilen oder Buffs neu zu zaubern.";

	CT_RAMENU_STEP1 = "1) Erstelle einen Channel\n|c00FFFFFFDr\195\188cke unten den Button General Options und lege einen Channel zum \195\188berwachen fest. Beachte das jeder Benutzer dieses Mods im Raid den selben Channel w\195\164hlen muss. Beachte auch das der Mod einen Standard-Channel namens |rCTGuildName |c00FFFFFF(ohne Leerzeichen) w\195\164hlt.|r";

	CT_RAMENU_STEP2 = "2) In den Channel einklinken\n|c00FFFFFFDr\195\188cke den Button Join Channel sobald dein Channel festgelegt ist um sicherzugehen das du im Channel bist.  Anf\195\188hrer/Bef\195\182rderte k\195\182nnen den Channel an den Raid Chat senden wodurch bei jedem der korrekten Channel festlegt wird, alles was sie dann zu tun haben ist |r/raidassist join|c00FFFFFF einzugeben um sich einzuklinken.|r";

	CT_RAMENU_STEP3 = "3) F\195\188hle die Magie!\n|c00FFFFFFDer Mod sollte nun richtig konfiguriert und einsatzbereit sein. Du kannst ausw\195\164hlen welche Gruppen angezeigt werden sollen indem du die entsprechenden Gruppen im CTRaid Fenster markierst. Um weitere Einstellungen vorzunehmen nutze die folgenden Optionsbereiche:";

	CT_RAMENU_BUFFSDESCRIPT = "W\195\164hle die Buffs und Debuffs welche du anzeigen lassen m\195\182chtest. Maximal 4 Buffs k\195\182nnen gleichzeitig angezeigt werden. Debuffs werden die Farbe des Fenster zu der Farbe \195\164ndern, die du ausw\195\164hlst.";
	CT_RAMENU_BUFFSTOOLTIP = "Benutze die Pfeile um Buffs nach oben oder unten zu verschieben. Wenn mehr als das Limit angezeigt wird haben die oberen Priorit\195\164t.";
	CT_RAMENU_DEBUFFSTOOLTIP = "Benutze die Pfeile um Debuffs nach oben oder unten zu verschieben. Wenn mehr als das Limit angezeigt wird haben die oberen Priorit\195\164t.";
	CT_RAMENU_GENERALDESCRIPT = "Untenstehend findest du Optionen um die Art der Anzeige zu \195\164ndern. Einschalten eines Unit Targets wird dir das Ziel der Spieler zeigen, die als Assist Targets festgelegt sind. Anf\195\188hrer und Bef\195\182rderte k\195\182nnen einen Spieler im CTRaid Fenster rechtsklicken und ihn als Assist Target festlegen. Bis zu 5 Leute gleichzeitig k\195\182nnen ihre Ziele angezeigt bekommen lassen. Raid-Anf\195\188hrer und Bef\195\182rderte k\195\182nnen den Button Update Status dr\195\188cken um Gesundheit, Mana und Buffs aller im Raid zu aktualisieren.";
	CT_RAMENU_MISCDESCRIPT = "Mana Conserve erlaubt es dir Heilzauber automatisch abzubrechen wenn das Ziel mehr als X% Gesundheit hat wenn der Zauber wirken sollte |c00FFFFFFand und du dich im Kampf befindest|r. Beachte das du w\195\164hrend des gesamten Zaubervorgangs dasselbe Ziel behalten musst damit dies richtig funktioniert.";
	CT_RAMENU_REPORTDESCRIPT = "Das Markieren eines Button wird dir Gesundheit und Mana der Person die du markiert hast anzeigen. Wenn du oder die Person die Gruppe verl\195\164sst wird dir automatisch nichts mehr angezeigt.";

	BINDING_HEADER_CT_RAIDASSIST = "CT_RaidAssist";
	BINDING_NAME_CT_CUREDEBUFF = "Entferne Raid Debuffs"; 
	BINDING_NAME_CT_RECASTRAIDBUFF = "Zaubere Raid Buffs neu";
	BINDING_NAME_CT_SHOWHIDE = "Zeige/Verstecke Raid Fenster";
	BINDING_NAME_CT_TOGGLEDEBUFFS = "Schalte Buff/Debuff-Anzeige um";
	BINDING_NAME_CT_ASSISTMT1 = "Assist MT 1";
	BINDING_NAME_CT_ASSISTMT2 = "Assist MT 2";
	BINDING_NAME_CT_ASSISTMT3 = "Assist MT 3";
	BINDING_NAME_CT_ASSISTMT4 = "Assist MT 4";
	BINDING_NAME_CT_ASSISTMT5 = "Assist MT 5";

	CT_RAMENU_FAQ1 = "F. Kann man CTRaid Gruppenpositionen verschieben?";
	CT_RAMENU_FAQANSWER1 = "Versichere dich das \"Lock Group Positions\" in den General Options nicht markiert und das \"Show Group Names\" eingeschaltet ist, dann klicke und verschiebe den 'Group#' Text.";
	CT_RAMENU_FAQ2 = "F. Wie sende ich CTRaid Alarmnachrichten?";
	CT_RAMENU_FAQANSWER2 = "Raid Anf\195\188hrer und Bef\195\182rderte k\195\182nnen mit Hilfe des Mods einen Alarm auf den Bildschirm aller Raid-Mitglieder senden, indem sie /rs <Text> eingeben, wobei <Text> die eigentlich Nachricht ist. Jede Person kann die Farbe in der ihre Alarmnachricht erscheint \195\164ndern.";
	CT_RAMENU_FAQ3 = "F. Wie kann ich die Einladungsfeatures benutzen?"
	CT_RAMENU_FAQANSWER3 = "Raid Anf\195\188hrer/Bef\195\182rderte k\195\182nnen /rainvite xx-yy (/rainvite 58-60) benutzen um alle Leute ihrer Gilde im angegebenen Levelbereich einzuladen.  /rakeyword setzt ein Schl\195\188sselwort so dass jemand automatisch eingeladen wird wenn er dich mit diesem Wort anfl\195\188stert.";
	CT_RAMENU_FAQ4 = "F. Wie zaubere ich schnell abklingende Buffs neu oder entferne Debuffs?";
	CT_RAMENU_FAQANSWER4 = "Dr\195\188cke Escape um das Spielmen\195\188 anzuzeigen, klicke dann auf Tastaturbelegung.  Gegen Ende der Tastaturk\195\188rzel siehst du die Optionen f\195\188r CT_RaidAssist.  Belege die Tasten die du verwenden m\195\182chtest, dann klicke auf OK.";
	CT_RAMENU_FAQ5 = "F. Die Namen von Leuten blinken in verschiedenen Farben, warum?";
	CT_RAMENU_FAQANSWER5 = "Wenn jemand einen Debuff erh\195\164lt \195\164ndert sich die Hintergrundfarbe des Fensters zu der Farbe die du in den Buff Optionen ausgew\195\164hlt hast.  Wenn du nicht sehen m\195\182chtest wenn jemand einen Debuff erh\195\164lt, deaktiviere einfach die Debuff Optionen.";
	CT_RAMENU_FAQ6 = "F. Bei Masseneinladungen werden nicht alle eingeladen, wie kommt das?";
	CT_RAMENU_FAQANSWER6 = "Das Spiel erh\195\164lt keine Informationen \195\188ber deine Gildenmitglieder bevor du die Gilden\195\188bersicht ge\195\182ffnet hast. \195\182ffne die Gilden\195\188bersicht und versuche dann noch einmal deine Masseneinladung.";
	CT_RAMENU_FAQ12 = "F\195\188r mehr Informationen \195\188ber CT Mods oder f\195\188r Ratschl\195\164ge, Kommentare oder Fragen die hier nicht beantwortet wurden, besuche uns bitte auf http://www.ctmod.net";
	
	CT_RA_WARRIOR = "Krieger";
	CT_RA_ROGUE = "Schurke";
	CT_RA_HUNTER = "J\195\164ger";
	CT_RA_MAGE = "Magier";
	CT_RA_WARLOCK = "Hexenmeister";
	CT_RA_DRUID = "Druide";
	CT_RA_PRIEST = "Priester";
	CT_RA_SHAMAN = "Schamane";
	CT_RA_PALADIN = "Paladin";
	
	CT_RA_AFKMESSAGE = "Ihr seid jetzt AFK: (.+)";
	CT_RA_DNDMESSAGE = "Ihr seid jetzt DND: (.+)%.";
	
	-- Buffs
	CT_RA_POWERWORDFORTITUDE = {  "Machtwort: Seelenst\195\164rke", "Gebet der Seelenst\195\164rke" };
	CT_RA_MARKOFTHEWILD = { "Mal der Wildnis", "Gabe der Wildnis" };
	CT_RA_ARCANEINTELLECT = { "Arkane Intelligenz", "Arkane Brillanz" };
	CT_RA_ADMIRALSHAT = "Admiralshut";
	CT_RA_SHADOWPROTECTION = "Schattenschutz";
	CT_RA_POWERWORDSHIELD = "Machtwort: Schild";
	CT_RA_SOULSTONERESURRECTION = "Seelenstein-Auferstehung";
	CT_RA_DIVINESPIRIT =  "G\195\182ttlicher Willen";
	CT_RA_THORNS = "Dornen";
	CT_RA_FEARWARD = "Furchtbarriere";
	CT_RA_BLESSINGOFMIGHT = "Segen der Macht";
	CT_RA_BLESSINGOFWISDOM= "Segen der Weisheit";
	CT_RA_BLESSINGOFKINGS = "Segen der K\195\182nige";
	CT_RA_BLESSINGOFSALVATION = "Segen der Rettung";
	CT_RA_BLESSINGOFLIGHT = "Segen des Lichts";
	CT_RA_BLESSINGOFSANCTUARY = "Segen des Refugiums";
	CT_RA_REGROWTH = "Nachwachsen";
	CT_RA_REJUVENATION = "Verj\195\188ngung";
	CT_RA_RENEW = "Erneuerung";
	CT_RA_AMPLIFYMAGIC = "Magie verst\195\164rken";
	CT_RA_DAMPENMAGIC = "Magied\195\164mpfer";
	
	CT_RA_MAGIC = "Magie";
	CT_RA_DISEASE = "Krankheit";
	CT_RA_POISON = "Gift";
	CT_RA_CURSE = "Fluch";
	CT_RA_WEAKENEDSOUL = "Geschw\195\164chte_Seele";
	CT_RA_RECENTLYBANDAGED = "K\195\188rzlich_bandagiert";
	
	-- Cures
	CT_RA_DISPELMAGIC = "Magiebannung";
	CT_RA_ABOLISHDISEASE = "Krankheit aufheben";
	CT_RA_ABOLISHPOISON = "Vergiftung aufheben";
	CT_RA_CLEANSE = "Reinigung des Glaubens";
	CT_RA_PURIFY = "L\195\164utern";
	CT_RA_CUREDISEASE = "Krankheit heilen";
	CT_RA_CUREPOISON = "Vergiftung heilen";
	CT_RA_REMOVECURSE = "Fluch aufheben";
	CT_RA_REMOVELESSERCURSE = "Geringen Fluch aufheben";
	
	-- Resurrections
	CT_RA_RESURRECTION = "Auferstehung";
	CT_RA_REDEMPTION = "Erl\195\182sung";
	CT_RA_REBIRTH = "Wiedergeburt";
	CT_RA_ANCESTRALSPIRIT = "Geist der Ahnen";
	
	
	-- RAReg/RADur (Thanks to Bandis for this localization)
	CT_RA_DURABILITY = "^Haltbarkeit (%d+) / (%d+)$";
	CT_REG_PRIEST = "Hochheilige Kerze";
	CT_REG_PRIEST_SPELL = "Gebet der Seelenst\195\164rke";
	CT_REG_MAGE = "Arkanes Pulver";
	CT_REG_MAGE_SPELL= "Arkane Brillanz";
	CT_REG_DRUID = "Wilder Dornwurz";
	CT_REG_DRUID_SPELL = "Gabe der Wildnis";
	CT_REG_WARLOCK = "Seelensplitter";
end
CT_RA_FEIGNDEATH["de"] = "Totstellen";