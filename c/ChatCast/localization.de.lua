--German translation (turboPasqual)
--Last updated 1/23/06

if ( GetLocale() == "deDE" ) then
	CCLocale.UI = {
		rank = "(Rang %d)",
	
		text = {
			loaded = "%s geladen, klicke auf den Link oder gib /chatcast, /cc f\195\188r die Optionen ein.",
			options_on = "[ON|off]",
			options_off = "[on|OFF]",
			options_list = "%s Optionen:",
			options_color = "  \"/cc color [reset]\" Farbauswahl f\195\188r den Link.",
			options_brackets = "  \"/cc brackets %s\" Klammern um Links an-/ausschalten.",
			options_sound = "  \"/cc sound %s\" Link-Klick-Sound an-/ausschalten.",
			options_feedback = "  \"/cc feedback %s\" Zauber-Feedback an-/ausschalten.",
			options_invites = "  \"/cc invites %s\" Erstellung von 'Einladen'-Links an-/ausschalten.",
			options_autosend = "  \"/cc autosend %s\" Bei 'Mitglieder-Such'-Links direkt anfl\195\188stern, oder Text zum Editieren \195\182ffnen.",
			options_LFM = "  \"/cc lfm <message>\" Festlegen der Fl\195\188sternachricht f\195\188r die 'Mitglieder-Such'-Links.  Benutze $c f\195\188r deine Klasse und $l f\195\188r deinen Level.  Derzeitiger Text: \"%s\"",
			options_lastlink = "  \"/cc lastlink\" Welche letzten Links sollen durch einen Tastendruck ausgel\195\182st werden: Nur Verst\195\164rkungszauber oder alle?",
			
			slash_color = "^color",
			slash_brackets = "^brackets",
			slash_sound = "^sound",
			slash_feedback = "^feedback",
			slash_invites = "^invites",
			slash_arg_on = "on",
			slash_arg_off = "off",
			slash_arg_reset = "reset",
			slash_arg_reset2 = "default",
			slash_lfm = "^autosend",
			slash_lfmtext = "^lfm",
			slash_lastlink = "^lastlink",
	
			invites_on = "%s verlinkt jetzt Einladungen.",
			invites_off = "%s verlinkt jetzt keine Einladungen.",
			feedback_on = "%s Feedback angeschaltet.",
			feedback_off = "%s Feedback ausgeschaltet.",
			brackets_on = "%s Klammern angeschaltet.",
			brackets_off = "%s Klammern ausgeschaltet.",
			sound_on = "%s Sound angeschaltet.",
			sound_off = "%s Sound ausgeschaltet.",
			color_current = "%s Derzeitige Farbe: %s",
			color_reset = "%s Farbe wird zur\195\188ckgesetzt auf %s",
			color_changed = "%s Farbe ist jetzt %s",
			LFM_set = "%s 'Mitglieder-Such'-Nachricht gesetzt auf: \"%s\"",
			LFMalt_on = "%s Ein Klick auf 'Mitglieder-Such'-Links \195\182ffnet einen Text zum Editieren.",
			LFMalt_off = "%s Ein Klick auf 'Mitglieder-Such'-Links sendet eine automatische Fl\195\188sternachricht.",
			LFM_default = "Ich bin dabei. $c, Level $l.", -- Default whisper to send when clicking a 'LFM' link
			lastlink_on = "%s Tastendruck f\195\188r den letzten Link l\195\182st nur Verst\195\164rkungszauber aus.",
			lastlink_off = "%s Tastendruck f\195\188r den letzten Link l\195\182st alle Links aus.",
	
			tell_prefix = "Zu |Hplayer:", --Should match the format when you send a tell to someone, such as "To [Thrall]: you there?", note that only 'To' should be translated, the '|Hplayer:' is the beginning of a link for the player's name and shouldn't need to be changed.
			trade_channel = "%[%d%. Handel%]", --Should match the format for the trade channel prefix.  This matches [2. Trade]
	
			fb_createfail = "Erstellung des Gegenstandes fehlgeschlagen, Handel abgebrochen.",
			fb_creating = "Erstelle %s.",
			fb_tradefail = "Handel mit %s nicht m\195\182glich.",
			fb_castfail = "Zaubern fehlgeschlagen. Zauber: %s  , Ziel: %s  , Fehlermeldung: %s", --Spell name, target name, spell error message
			fb_casting = "Zaubere %s auf %s.", --Spell name, target name
			fb_targetfail = "Kann %s nich ausw\195\164hlen.",
			fb_unknownspell = "Ihr kennt diesen Zauber nicht."
	
		}
	}

	if CCClass == "PRIEST" then
		CCLocale.PRIEST = {}
		CCLocale.PRIEST.Power_Word_Fortitude = "Machtwort: Seelenst\195\164rke"
		CCLocale.PRIEST.Power_Word_Fortitude_trigger = { "seelenst\195\164rke", "machtwort", "ausdauer", "stamina", "buffs?" }
		CCLocale.PRIEST.Prayer_of_Fortitude = "Gebet der Seelenst\195\164rke"
		CCLocale.PRIEST.Prayer_of_Fortitude_trigger = { "gruppe.?%d? [^%p]- seelenst\195\164rke", "gruppe.?%d? [^%p]- ausdauer", "seelenst\195\164rke [^%p]- gruppe.?%d?", "ausdauer [^%p]- gruppe.?%d?", "gebet" }
		CCLocale.PRIEST.Shadow_Protection = "Schattenschutz"
		CCLocale.PRIEST.Shadow_Protection_trigger = { "schatten", "schattenschutz" }
		CCLocale.PRIEST.Divine_Spirit = "G\195\182ttlicher Willen"
		CCLocale.PRIEST.Divine_Spirit_trigger = { "willen", "weisheit" }
		CCLocale.PRIEST.Power_Word_Shield = "Machtwort: Schild"
		CCLocale.PRIEST.Power_Word_Shield_trigger = { "schild" }
		CCLocale.PRIEST.Dispel_Magic = "Magiebannung"
		CCLocale.PRIEST.Dispel_Magic_trigger = { "bannen", "magie" }
		CCLocale.PRIEST.Abolish_Disease = "Krankheit aufheben"
		CCLocale.PRIEST.Abolish_Disease_trigger = { "krankheit", "krank" }
		CCLocale.PRIEST.Cure_Disease = "Krankheit heilen"
		CCLocale.PRIEST.Cure_Disease_trigger = { "krankheit", "krank" }
		CCLocale.PRIEST.Resurrection = "Wiederbelebung"
		CCLocale.PRIEST.Resurrection_trigger = { "%a-beleben", "rez",  "ress?", "tot" }
		CCLocale.PRIEST.Heal = "Blitzheilung"
		CCLocale.PRIEST.Heal_trigger = { "heil%a-" }
		if CCRace == "Dwarf" then --Do not translate 'Dwarf'
			CCLocale.PRIEST.Fear_Ward = "Furcht-Zauberschutz"
			CCLocale.PRIEST.Fear_Ward_trigger = { "furcht", "zauberschutz", "furchtbarriere", "barriere", "furchtschutz" }
		end
	
	elseif CCClass == "MAGE" then
		CCLocale.MAGE = {}
		CCLocale.MAGE.Arcane_Intellect = "Arkane Intelligenz"
		CCLocale.MAGE.Arcane_Intellect_trigger = { "ai", "int", "intelligen%a?", "buffs?" }
		CCLocale.MAGE.Arcane_Brilliance = "Arkane Brillanz"
		CCLocale.MAGE.Arcane_Brilliance_trigger = { "ab", "gruppen ai", "gruppen int", "gruppe.?%d? [^%p]- int", "gruppe.?%d? [^%p]- intelligen%a?", "int [^%p]- gruppe%d?", "intelligen%a? [^%p]- gruppe%d?" }
		CCLocale.MAGE.Dampen_Magic = "Magied\195\164mpfer"
		CCLocale.MAGE.Dampen_Magic_trigger = { "magied\195\164mpfer" }
		CCLocale.MAGE.Amplify_Magic = "Magie verst\195\164rken"
		CCLocale.MAGE.Amplify_Magic_trigger = { "verst\195\164rken" }
		CCLocale.MAGE.Remove_Lesser_Curse = "Geringen Fluch aufheben"
		CCLocale.MAGE.Remove_Lesser_Curse_trigger = { "fluch" }
		CCLocale.MAGE.Conjure_Water = "ChatCast_InitiateTrade(\"$p\", \"_Water\", 10)" --do not localize
		CCLocale.MAGE.Conjure_Water_trigger = { "wasser" }
		CCLocale.MAGE.Conjure_Water_rankitem = { "Herbeigezaubertes Wasser", "Herbeigezaubertes frisches Wasser", "Herbeigezaubertes gel\195\164utertes Wasser", "Herbeigezaubertes Quellwasser", "Herbeigezaubertes Mineralwasser", "Herbeigezaubertes Sprudelwasser", "Herbeigezaubertes Kristallwasser" }
		CCLocale.MAGE.Conjure_Water_spellname = "Wasser herbeizaubern"

	elseif CCClass == "DRUID" then
		CCLocale.DRUID = {}
		CCLocale.DRUID.Mark_of_the_Wild = "Mal der Wildnis"
		CCLocale.DRUID.Mark_of_the_Wild_trigger = { "mal", "mdw", "buffs?" }
		CCLocale.DRUID.Gift_of_the_Wild = "Gabe der Wildnis"
		CCLocale.DRUID.Gift_of_the_Wild_trigger = { "gdw", "gabe", "gruppe.?%d? [^%p]- mdw", "mdw [^%p]- gruppe%d?" }
		CCLocale.DRUID.Thorns = "Dornen"
		CCLocale.DRUID.Thorns_trigger = { "dornen" }
		CCLocale.DRUID.Innervate = "Anregen"
		CCLocale.DRUID.Innervate_trigger = { "anregen" }
		CCLocale.DRUID.Remove_Curse = "Fluch aufheben"
		CCLocale.DRUID.Remove_Curse_trigger = { "fluch" }
		CCLocale.DRUID.Abolish_Poison = "Vergiftung aufheben"
		CCLocale.DRUID.Abolish_Poison_trigger = { "gift" }
		CCLocale.DRUID.Cure_Poison = "Vergiftung heilen"
		CCLocale.DRUID.Cure_Poison_trigger = { "gift" }
		CCLocale.DRUID.Rebirth = "Wiedergeburt"
		CCLocale.DRUID.Rebirth_trigger = { "%a-beleben", "rez",  "ress?", "tot" }
		CCLocale.DRUID.Heal = "Nachwachsen"
		CCLocale.DRUID.Heal_trigger = { "heil%a-" }
	
	elseif CCClass == "PALADIN" then
		CCLocale.PALADIN = {}
		CCLocale.PALADIN.Blessing_of_Might = "Segen der Macht"
		CCLocale.PALADIN.Blessing_of_Might_trigger = { "macht", "sdm" }
		CCLocale.PALADIN.Blessing_of_Wisdom = "Segen der Weisheit"
		CCLocale.PALADIN.Blessing_of_Wisdom_trigger = { "weisheit", "sdw" }
		CCLocale.PALADIN.Blessing_of_Freedom = "Segen der Freiheit"
		CCLocale.PALADIN.Blessing_of_Freedom_trigger = { "freiheit", "sdf" }
		CCLocale.PALADIN.Blessing_of_Light = "Segen des Lichts"
		CCLocale.PALADIN.Blessing_of_Light_trigger = { "licht", "sdl" }
		CCLocale.PALADIN.Blessing_of_Sacrifice = "Segen der Opferung"
		CCLocale.PALADIN.Blessing_of_Sacrifice_trigger = { "opferung", "opfer", "opfern", "sdo" }
		CCLocale.PALADIN.Blessing_of_Kings = "Segen der K\195\182nige"
		CCLocale.PALADIN.Blessing_of_Kings_trigger = { "k\195\182nige?", "sdk" }
		CCLocale.PALADIN.Blessing_of_Salvation = "Segen der Rettung"
		CCLocale.PALADIN.Blessing_of_Salvation_trigger = { "rettung", "sdr" }
		CCLocale.PALADIN.Blessing_of_Sanctuary = "Segen des Refugiums"
		CCLocale.PALADIN.Blessing_of_Sanctuary_trigger = { "refugium", "ref", "sdref" }
		CCLocale.PALADIN.Blessing_of_Protection = "Segen des Schutzes"
		CCLocale.PALADIN.Blessing_of_Protection_trigger = { "schutz", "sds" }
		CCLocale.PALADIN.Cleanse = "Reinigung des Glaubens"
		CCLocale.PALADIN.Cleanse_trigger = { "bannen", "magie" }
		CCLocale.PALADIN.Purify = "L\195\164utern"
		CCLocale.PALADIN.Purify_trigger = { "gift", "krankheit", "krank", "l\195\164utern?" }
		CCLocale.PALADIN.Redemption = { "Erl\195\182sung" }
		CCLocale.PALADIN.Redemption_trigger = { "%a-beleben", "rez",  "ress?", "tot" }
		CCLocale.PALADIN.Heal = "Lichtblitz"
		CCLocale.PALADIN.Heal_trigger = { "heil%a-" }
		CCLocale.PALADIN.Greater_Blessing_of_Might = "Gro\195\159er Segen der Macht"
		CCLocale.PALADIN.Greater_Blessing_of_Might_trigger = { "gsdm", "gro\195\159er sdm" }
		CCLocale.PALADIN.Greater_Blessing_of_Kings = "Gro\195\159er Segen der K\195\182nige"
		CCLocale.PALADIN.Greater_Blessing_of_Kings_trigger = { "gsdk", "gro\195\159er sdk" }
		CCLocale.PALADIN.Greater_Blessing_of_Wisdom = "Gro\195\159er Segen der Weisheit"
		CCLocale.PALADIN.Greater_Blessing_of_Wisdom_trigger = { "gsdw", "gro\195\159er sdw" }
		CCLocale.PALADIN.Greater_Blessing_of_Light = "Gro\195\159er Segen des Lichts"
		CCLocale.PALADIN.Greater_Blessing_of_Light_trigger = { "gsdl", "gro\195\159er sdl" }
		CCLocale.PALADIN.Greater_Blessing_of_Salvation = "Gro\195\159er Segen der Rettung"
		CCLocale.PALADIN.Greater_Blessing_of_Salvation_trigger = { "gsdr", "gro\195\159er sdr" }
		CCLocale.PALADIN.Greater_Blessing_of_Sanctuary = "Gro\195\159er Segen des Refugiums"
		CCLocale.PALADIN.Greater_Blessing_of_Sanctuary_trigger = { "gsdref", "gro\195\159er sdref" }
	
	
	elseif CCClass == "SHAMAN" then
		CCLocale.SHAMAN = {}
		CCLocale.SHAMAN.Cure_Poison = "Vergiftung heilen"
		CCLocale.SHAMAN.Cure_Poison_trigger = { "gift" }
		CCLocale.SHAMAN.Cure_Disease = "Krankheit heilen"
		CCLocale.SHAMAN.Cure_Disease_trigger = { "krankheit", "krank" }
		CCLocale.SHAMAN.Water_Breathing = "Wasseratmung"
		CCLocale.SHAMAN.Water_Breathing_trigger = { "%a-atmung", "%a-atem", "tauchen" }
		CCLocale.SHAMAN.Ancestral_Spirit = "Reinkarnation"
		CCLocale.SHAMAN.Ancestral_Spirit_trigger = { "%a-beleben", "rez",  "ress?", "tot" }
		CCLocale.SHAMAN.Heal = "Geringe Welle der Heilung"
		CCLocale.SHAMAN.Heal_trigger = { "heil%a-" }

	elseif CCClass == "WARLOCK" then
		CCLocale.WARLOCK = {}
		CCLocale.WARLOCK.Unending_Breath = "Unendlicher Atem"
		CCLocale.WARLOCK.Unending_Breath_trigger = { "%a-atmung", "%a-atem", "tauchen"  }
		CCLocale.WARLOCK.Detect_Greater_Invisibility = "Gro\195\159e Unsichtbarkeit entdecken"
		CCLocale.WARLOCK.Detect_Greater_Invisibility_trigger = { "unsichtbar%a-" }
		CCLocale.WARLOCK.Ritual_of_Summoning = "Ritual der Beschw\195\182rung"
		CCLocale.WARLOCK.Ritual_of_Summoning_trigger = { "portet? $w", "$w porten", "portest du $w", "portes?t", "porte?n?" } --$w triggers have to come before any similar non-$w triggers or the link will have already been made
		CCLocale.WARLOCK.Healthstone = "ChatCast_InitiateTrade(\"$p\", \"_Healthstone\", 1)" --do not localize this line
		CCLocale.WARLOCK.Healthstone_trigger = { "heilstein", "stein", "gesundheitsstein" }
		CCLocale.WARLOCK.Healthstone_rankitem = { "Schwacher Gesundheitsstein", "Geringer Gesundheitsstein", "Gesundheitsstein", "Gro\195\159er Gesundheitsstein", "Erheblicher Gesundheitsstein" }
		CCLocale.WARLOCK.Healthstone_spellname = { "Gesundheitsstein herstellen (schwach)", "Gesundheitsstein herstellen (gering)", "Gesundheitsstein herstellen", "Gesundheitsstein herstellen (gro\195\159)", "Gesundheitsstein herstellen (erheblich)" }
		CCLocale.WARLOCK.Soulstone = "ChatCast_Soulstone(\"$p\")"
		CCLocale.WARLOCK.Soulstone_trigger = { "seelenstein", "seele" }
		CCLocale.WARLOCK.Soulstone_rankitem = { "Schwacher Seelenstein", "Geringer Seelenstein", "Seelenstein", "Gro\195\159er Seelenstein", "Erheblicher Seelenstein" }
		CCLocale.WARLOCK.Soulstone_spellname = { "Seelenstein herstellen (schwach)", "Seelenstein herstellen (gering)", "Seelenstein herstellen", "Seelenstein herstellen (gro\195\159)", "Seelenstein herstellen (erheblich)" }
	end

	CCLocale.GENERAL.AskInvite = "SendChatMessage(\"einladen\", \"WHISPER\", nil, \"$p\")"
	CCLocale.GENERAL.AskInvite_trigger = { "autos", "for [^%p]-invites?", "auto.-invites?", "tell [^%p]-invites?", "pst [^%p]-invites?", "msg [^%p]-invites?", "[\"']invite[\"']" }
	CCLocale.GENERAL.Invite_Target = "InviteByName(\"$w\")"
	CCLocale.GENERAL.Invite_Target_trigger = { "$w einladen" }
	CCLocale.GENERAL.Invite = "InviteByName(\"$p\")"
	CCLocale.GENERAL.Invite_trigger = { "lfg", "einladen", "l\195\164dt ein", "ladet", "l\195\164dst", "anschluss", "anschlu\195\159", "suchen? [^%p]-gruppe", "suchen? [^%p]-raid", "sucht [^%p]-gruppe", "sucht [^%p]-raid", "[^%p]-gruppe gesucht", "suchen? [^%p]-grp", "sucht [^%p]-grp", "[^%p]-grp gesucht" }
	CCLocale.GENERAL.ChatCast = "ChatCast_Options()"
	CCLocale.GENERAL.ChatCast_trigger = { "chatcast" }
	CCLocale.GENERAL.PST = "ChatFrame_SendTell(\"$p\")"
	CCLocale.GENERAL.PST_trigger = { "/?wm", "/?w me", "whisper", "anfl\195\188stern?", "fl\195\188ster[^%p]- an", "melde[^%p]-" }
	CCLocale.GENERAL.LFM_alt = "ChatFrame_OpenChat(\"/w $p \" .. gsub(gsub(ChatCast.LFM,\"$l\", UnitLevel(\"player\")), \"$c\", CCClassl))"
	CCLocale.GENERAL.LFM = "SendChatMessage(gsub(gsub(ChatCast.LFM,\"$l\", UnitLevel(\"player\")), \"$c\", CCClassl), \"WHISPER\", nil, \"$p\")"
	CCLocale.GENERAL.LFM_trigger = { "lf%d?m", "mitst?reiter", "mitschreiter", "mitglieder", "gruppe sucht", "f\195\188r [^%p]-gruppe", "suchen? [^%p]-leute", string.lower(string.sub (CCClassl, 1, 4)) .. "%a-" }

	CCLocale.DoNotAllow = "bitte,mich,schnell,eben," --words not to allow for the $w capture, keep the trailing comma for functionality, automatically ignores words 3 characters or less
end