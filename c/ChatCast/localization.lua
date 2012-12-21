--[[
	ChatCast 1.41 triggers, originally derived from WhisperCast. 
	Last updated 4/3/06
	]]

CCClassl,CCClass = UnitClass("player");
_,CCRace = UnitRace("player");

CCLocale = {}

BINDING_HEADER_CHATCAST= "ChatCast";
BINDING_NAME_CHATCAST_LASTLINK = "Run Last Link";

CCLocale.UI = {
	rank = "(Rank %d)", --Spell rank

	text = {
		--Options list
		loaded = "%s loaded, click link or type /chatcast, /cc for options.",
		options_on = "[ON|off]",
		options_off = "[on|OFF]",
		options_list = "%s options list:",
		options_color = "  \"/cc color [reset]\" to set link color.",
		options_brackets = "  \"/cc brackets %s\" to toggle brackets around links.",
		options_sound = "  \"/cc sound %s\" to toggle link click sounds.",
		options_feedback = "  \"/cc feedback %s\" to toggle link casting feedback text.",
		options_invites = "  \"/cc invites %s\" to toggle creation of 'invite' links.",
		options_autosend = "  \"/cc autosend %s\" to send LFM link whispers automatically or bring up an editbox.",
		options_LFM = "  \"/cc lfm <message>\" to set your whisper message when clicking an LFM link.  Use $c for your class and $l for your level.  Current message: \"%s\"",
		options_lastlink = "  \"/cc lastlink\" to change Last Link keybinding between buffs only and all links.",
		options_hitsmode = "  \"/cc hitsmode %s\" to toggle HitsMode parsing.",

		--Slash commands
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
		slash_hitsmode = "^hitsmode",

		--Options changed messages
		invites_on = "%s will now link invites.",
		invites_off = "%s no longer linking invites.",
		feedback_on = "%s feedback on.",
		feedback_off = "%s feedback off.",
		brackets_on = "%s brackets on.",
		brackets_off = "%s brackets off.",
		sound_on = "%s sound on.",
		sound_off = "%s sound off.",
		color_current = "%s color currently %s",
		color_reset = "%s color reset to %s",
		color_changed = "%s color is now %s",
		LFM_set = "%s LFM send text set to \"%s\"",
		LFMalt_on = "%s LFM will bring up chat edit box for your whisper.",
		LFMalt_off = "%s LFM will send whisper automatically.",
		LFM_default = "$l $c lfg", -- Default whisper to send when clicking a 'LFM' link
		lastlink_on = "%s Last Link keybinding will only cast buffs.",
		lastlink_off = "%s Last Link keybinding will run the last link of any type.",
		hitsmode_on = "%s now parsing HitsMode combat messages.",
		hitsmode_off = "%s no longer parsing HitsMode combat messages.",

		--Tell prefix and Trade channel prefix to stop links from appearing in outgoing tells or the Trade channel
		tell_prefix = "To |Hplayer:", --Should match the format when you send a tell to someone, such as "To [Thrall]: you there?", note that only 'To' should be translated, the '|Hplayer:' is the beginning of a link for the player's name and shouldn't need to be changed.
		trade_channel = "%[%d%. Trade%]", --Should match the format for the trade channel prefix.  This matches [2. Trade]

		--Feedback messages.  I doubt anyone actually uses feedback =)
		fb_createfail = "Item creation failed, trade cancelled.",
		fb_creating = "Creating %s",
		fb_tradefail = "Could not trade with %s",
		fb_castfail = "Could not cast %s on %s: %s", --Spell name, target name, spell error message
		fb_casting = "Casting %s on %s", --Spell name, target name
		fb_targetfail = "Cannot target %s",
		fb_unknownspell = "You don't know that spell."

		}
	}

--[[ Notes about triggers for translating:
	'$w' is a capture value for 1 word that can be used as part of a trigger
	$w triggers have to come before any similar non-$w triggers or the link will have already been made and won't be rechecked
	[^%p] will match any non-punctuation character (this is to allow numbers, spaces and letters to match)
	a '-' means to match 0 or more times, so [^%p]- means 0 or more non-punctuation characters
	a '?' means the previous character is optional
	for example: "for [^%p]-invites?" would match "for an invite", "for invites"
	"invites?%??" would match 'invite', 'invites', 'invite?' and 'invites?' (this one is for matching "i need an invite" as well as "who has invites?")
	
	Hope this helps with making triggers, visit http://www.lua.org/pil/20.2.html for information about capture patterns
	 ]]

--Hitsmode triggers.  Can't scan buffs/debuffs on enemies/non-party members to find out what type of spell happened, so using a list instead.
CCLocale.MAGIC_BUFFS =  { ".+ fortitude", ".+ of the wild", "power word: shield", "rejuvenation", "regeneration", "seal of .+", "blessing of .+", "arcane intellect", ".+ magic", "thorns", "innervate", "abolish .+", "ghost wolf", "water .+", "unending breath", "divine spirit", ".+ ward", "shadow protection", "mana shield", "frost barrier", "sacrifice", ".+ armor", "inner fire", "combustion", "arcane power", "elemental mastery", "lightning shield", "amplify .+", "barkskin", "free action" }
CCLocale.POISONS = { ".*poison.*", ".*sting.*", "blind", "brood affliction: green" }
CCLocale.DISEASES = { ".*plague.*", ".*rot.*", "brood affliction: red" }
CCLocale.MAGIC_DEBUFFS = { "blackout", "brood affliction: blue", "cause insanity", "chains of ice", "chilled", ".*concussive shot", "corruption", "drain life", "entangling roots", "entrapment", "faerie fire", "fear", "flame shock", "frost nova", "frostbite", "frostbolt", ".*polymorph", "hammer of justice", "hex&", "hibernate", "immolate", "mark of detonation", "moonfire", "screams of the past", "shadow word: pain", ".*silence.*", "sleep", "thunderclap" }
CCLocale.CURSES = { "ancient hysteria", "brood affliction: black", ".*curse.*", "discombobulate", "hex of weakness", "veil of shadow", "wracking pains" }

CCLocale.DoNotAllow = "please,this,that,again,when,anytime," --words not to allow for the $w capture, keep the trailing comma for functionality, automatically ignores words 3 characters or less
CCLocale.emote_mana = "%a+ announces that %a+ is low mana!"
CCLocale.emote_heal = "%a+ calls out for healing!"

--Priest Triggers
if CCClass == "PRIEST" then
CCLocale.PRIEST = {}
CCLocale.PRIEST.Power_Word_Fortitude = "Power Word: Fortitude"
CCLocale.PRIEST.Power_Word_Fortitude_trigger = { "fort", "single fort", "fortitude", "stam", "sta", "stamina", "buffs?" }
CCLocale.PRIEST.Prayer_of_Fortitude = "Prayer of Fortitude"
CCLocale.PRIEST.Prayer_of_Fortitude_trigger = { "group fort", "group fortitude", "group stam", "group stamina" }
CCLocale.PRIEST.Shadow_Protection = "Shadow Protection"
CCLocale.PRIEST.Shadow_Protection_trigger = { "shadow" }
CCLocale.PRIEST.Divine_Spirit = "Divine Spirit"
CCLocale.PRIEST.Divine_Spirit_trigger = { "spirit", "wis", "ds" }
CCLocale.PRIEST.Prayer_of_Spirit = "Prayer of Spirit"
CCLocale.PRIEST.Prayer_of_Spirit_trigger = { "group spirit", "group ds" }
CCLocale.PRIEST.Power_Word_Shield = "Power Word: Shield"
CCLocale.PRIEST.Power_Word_Shield_trigger = { "shield" }
CCLocale.PRIEST.Dispel_Magic = "Dispel Magic"
CCLocale.PRIEST.Dispel_Magic_trigger = { "dispel" }
CCLocale.PRIEST.Dispel_Magic_gains = CCLocale.MAGIC_BUFFS
CCLocale.PRIEST.Dispel_Magic_afflicted = CCLocale.MAGIC_DEBUFFS
CCLocale.PRIEST.Abolish_Disease = "Abolish Disease"
CCLocale.PRIEST.Abolish_Disease_trigger = { "cure disease", "disease" }
CCLocale.PRIEST.Abolish_Disease_afflicted = CCLocale.DISEASES
CCLocale.PRIEST.Cure_Disease = "Cure Disease"
CCLocale.PRIEST.Cure_Disease_trigger = { "cure disease", "disease" }
CCLocale.PRIEST.Cure_Disease_afflicted = CCLocale.DISEASES
CCLocale.PRIEST.Resurrection = "Resurrection"
CCLocale.PRIEST.Resurrection_trigger = { "rez", "ress?" }
CCLocale.PRIEST.Heal = "Flash Heal"
CCLocale.PRIEST.Heal_trigger = { "heal $w", "heals? on $w", "heal", "heals", CCLocale.emote_heal }
CCLocale.PRIEST.Fear_Ward = "Fear Ward"
CCLocale.PRIEST.Fear_Ward_trigger = { "fear", "ward" }
CCLocale.PRIEST.Silence = "Silence"
CCLocale.PRIEST.Silence_casting = { ".+" }


--Mage Triggers
elseif CCClass == "MAGE" then
CCLocale.MAGE = {}
CCLocale.MAGE.Arcane_Intellect = "Arcane Intellect"
CCLocale.MAGE.Arcane_Intellect_trigger = { "ai", "int", "buffs?" }
CCLocale.MAGE.Arcane_Brilliance = "Arcane Brilliance"
CCLocale.MAGE.Arcane_Brilliance_trigger = { "ab", "group ai", "group int", "brilliance" }
CCLocale.MAGE.Dampen_Magic = "Dampen Magic"
CCLocale.MAGE.Dampen_Magic_trigger = { "dampen" }
CCLocale.MAGE.Amplify_Magic = "Amplify Magic"
CCLocale.MAGE.Amplify_Magic_trigger = { "amplify" }
CCLocale.MAGE.Remove_Lesser_Curse = "Remove Lesser Curse"
CCLocale.MAGE.Remove_Lesser_Curse_trigger = { "curse" }
CCLocale.MAGE.Remove_Lesser_Curse_afflicted = CCLocale.CURSES
CCLocale.MAGE.Conjure_Water = "ChatCast_InitiateTrade(\"$p\", \"_Water\", 10)" --do not localize
CCLocale.MAGE.Conjure_Water_trigger = { "water" }
CCLocale.MAGE.Conjure_Water_rankitem = { "Conjured Water", "Conjured Fresh Water", "Conjured Purified Water", "Conjured Spring Water", "Conjured Mineral Water", "Conjured Sparkling Water", "Conjured Crystal Water" }
CCLocale.MAGE.Conjure_Water_spellname = "Conjure Water"
CCLocale.MAGE.Conjure_Food = "ChatCast_InitiateTrade(\"$p\", \"_Food\", 10)" --do not localize
CCLocale.MAGE.Conjure_Food_trigger = { "bread", "food" }
CCLocale.MAGE.Conjure_Food_rankitem = { "Conjured Muffin", "Conjured Bread", "Conjured Rye", "Conjured Pumpernickel", "Conjured Sourdough", "Conjured Sweet Roll" }
CCLocale.MAGE.Conjure_Food_spellname = "Conjure Food"
CCLocale.MAGE.Counterspell = "Counterspell"
CCLocale.MAGE.Counterspell_casting = { ".+" }

--Druid Triggers
elseif CCClass == "DRUID" then
CCLocale.DRUID = {}
CCLocale.DRUID.Mark_of_the_Wild = "Mark of the Wild"
CCLocale.DRUID.Mark_of_the_Wild_trigger = { "motw", "mark", "buffs?" }
CCLocale.DRUID.Gift_of_the_Wild = "Gift of the Wild"
CCLocale.DRUID.Gift_of_the_Wild_trigger = { "gotw", "gift", "group mark" }
CCLocale.DRUID.Thorns = "Thorns"
CCLocale.DRUID.Thorns_trigger = { "thorns" }
CCLocale.DRUID.Remove_Curse = "Remove Curse"
CCLocale.DRUID.Remove_Curse_trigger = { "curse" }
CCLocale.DRUID.Remove_Curse_afflicted = CCLocale.CURSES
CCLocale.DRUID.Abolish_Poison = "Abolish Poison"
CCLocale.DRUID.Abolish_Poison_trigger = { "cure poison", "poison" }
CCLocale.DRUID.Abolish_Poison_afflicted = CCLocale.POISONS
CCLocale.DRUID.Cure_Poison = "Cure Poison"
CCLocale.DRUID.Cure_Poison_trigger = { "cure poison", "poison" }
CCLocale.DRUID.Cure_Poison_afflicted = CCLocale.POISONS
CCLocale.DRUID.Rebirth = "Rebirth"
CCLocale.DRUID.Rebirth_trigger = { "rez", "ress?" }
CCLocale.DRUID.Heal = "Regrowth"
CCLocale.DRUID.Heal_trigger = { "heal $w", "heals? on $w", "heal", "heals", CCLocale.emote_heal }
CCLocale.DRUID.Innervate = "Innervate"
CCLocale.DRUID.Innervate_trigger = { "innervate", "oom", CCLocale.emote_mana }
CCLocale.DRUID.Hibernate = "Hibernate"
CCLocale.DRUID.Hibernate_gains = { "Ghost Wolf", "Cat Form", "Bear Form", "Dire Bear Form", "Travel Form", "Aquatic Form" }

--Paladin Triggers
elseif CCClass == "PALADIN" then
CCLocale.PALADIN = {}
CCLocale.PALADIN.Blessing_of_Might = "Blessing of Might"
CCLocale.PALADIN.Blessing_of_Might_trigger = { "might", "bom" }
CCLocale.PALADIN.Blessing_of_Wisdom = "Blessing of Wisdom"
CCLocale.PALADIN.Blessing_of_Wisdom_trigger = { "wisdom", "wis", "bow" }
CCLocale.PALADIN.Blessing_of_Freedom = "Blessing of Freedom"
CCLocale.PALADIN.Blessing_of_Freedom_trigger = { "freedom" }
CCLocale.PALADIN.Blessing_of_Light = "Blessing of Light"
CCLocale.PALADIN.Blessing_of_Light_trigger = { "light", "bol" }
CCLocale.PALADIN.Blessing_of_Sacrifice = "Blessing of Sacrifice"
CCLocale.PALADIN.Blessing_of_Sacrifice_trigger = { "sacrifice" }
CCLocale.PALADIN.Blessing_of_Kings = "Blessing of Kings"
CCLocale.PALADIN.Blessing_of_Kings_trigger = { "kings", "king", "bok" }
CCLocale.PALADIN.Blessing_of_Salvation = "Blessing of Salvation"
CCLocale.PALADIN.Blessing_of_Salvation_trigger = { "salvation", "bos" }
CCLocale.PALADIN.Blessing_of_Sanctuary = "Blessing of Sanctuary"
CCLocale.PALADIN.Blessing_of_Sanctuary_trigger = { "sanctuary", "bosa", "bon" }
CCLocale.PALADIN.Blessing_of_Protection = "Blessing of Protection"
CCLocale.PALADIN.Blessing_of_Protection_trigger = { "protection" }
CCLocale.PALADIN.Cleanse = "Cleanse"
CCLocale.PALADIN.Cleanse_trigger = { "cleanse", "dispel", "cure" }
CCLocale.PALADIN.Cleanse_afflicted = CCLocale.MAGIC_DEBUFFS
CCLocale.PALADIN.Purify = "Purify"
CCLocale.PALADIN.Purify_trigger = { "purify", "poison", "disease" }
CCLocale.PALADIN.Purify_afflicted = CCLocale.POISONS
CCLocale.PALADIN.Redemption = { "Redemption" }
CCLocale.PALADIN.Redemption_trigger = { "rez", "ress?" }
CCLocale.PALADIN.Heal = "Flash of Light"
CCLocale.PALADIN.Heal_trigger = { "heal $w", "heals? on $w","heal", "heals", CCLocale.emote_heal }
CCLocale.PALADIN.Greater_Blessing_of_Might = "Greater Blessing of Might"
CCLocale.PALADIN.Greater_Blessing_of_Might_trigger = { "gbom", "gmight" }
CCLocale.PALADIN.Greater_Blessing_of_Kings = "Greater Blessing of Kings"
CCLocale.PALADIN.Greater_Blessing_of_Kings_trigger = { "gbok", "gkings", "gking" }
CCLocale.PALADIN.Greater_Blessing_of_Wisdom = "Greater Blessing of Wisdom"
CCLocale.PALADIN.Greater_Blessing_of_Wisdom_trigger = { "gbow", "gwis", "gwisdom" }
CCLocale.PALADIN.Greater_Blessing_of_Light = "Greater Blessing of Light"
CCLocale.PALADIN.Greater_Blessing_of_Light_trigger = { "gbol", "glight" }
CCLocale.PALADIN.Greater_Blessing_of_Salvation = "Greater Blessing of Salvation"
CCLocale.PALADIN.Greater_Blessing_of_Salvation_trigger = { "gbos", "gsal", "gsalvation" }
CCLocale.PALADIN.Greater_Blessing_of_Sanctuary = "Greater Blessing of Sanctuary"
CCLocale.PALADIN.Greater_Blessing_of_Sanctuary_trigger = { "gbosa", "gsan", "gsanctuary", "gbon" }

--Shaman Triggers
elseif CCClass == "SHAMAN" then
CCLocale.SHAMAN = {}
CCLocale.SHAMAN.Cure_Poison = "Cure Poison"
CCLocale.SHAMAN.Cure_Poison_trigger = { "cure poison", "poison" }
CCLocale.SHAMAN.Cure_Poison_afflicted = CCLocale.POISONS
CCLocale.SHAMAN.Cure_Disease = "Cure Disease"
CCLocale.SHAMAN.Cure_Disease_trigger = { "cure disease", "disease" }
CCLocale.SHAMAN.Cure_Disease_afflicted = CCLocale.DISEASES
CCLocale.SHAMAN.Water_Breathing = "Water Breathing"
CCLocale.SHAMAN.Water_Breathing_trigger = { "water%s?breath%a-" }
CCLocale.SHAMAN.Ancestral_Spirit = "Ancestral Spirit"
CCLocale.SHAMAN.Ancestral_Spirit_trigger = { "rez", "ress?" }
CCLocale.SHAMAN.Heal = "Lesser Healing Wave"
CCLocale.SHAMAN.Heal_trigger = { "heal $w", "heals? on $w", "heal", "heals", CCLocale.emote_heal }
CCLocale.SHAMAN.Water_Walking = "Water Walking"
CCLocale.SHAMAN.Water_Walking_trigger = { "water%s?walk%a-" }
CCLocale.SHAMAN.Mana_Tide = "Mana Tide"
CCLocale.SHAMAN.Mana_Tide_trigger = { "mana%s?tide", "oom", "tide", CCLocale.emote_mana }
CCLocale.SHAMAN.Purge = "Purge"
CCLocale.SHAMAN.Purge_gains = CCLocale.MAGIC_BUFFS
CCLocale.SHAMAN.Earth_Shock = "Earth Shock"
CCLocale.SHAMAN.Earth_Shock_casting = { ".+" }

--Warlock Triggers
elseif CCClass == "WARLOCK" then
CCLocale.WARLOCK = {}
CCLocale.WARLOCK.Unending_Breath = "Unending Breath"
CCLocale.WARLOCK.Unending_Breath_trigger = { "water breath%a-" }
CCLocale.WARLOCK.Detect_Greater_Invisibility = "Detect Greater Invisibility"
CCLocale.WARLOCK.Detect_Greater_Invisibility_trigger = { "invis", "invisible" }
CCLocale.WARLOCK.Ritual_of_Summoning = "Ritual of Summoning"
CCLocale.WARLOCK.Ritual_of_Summoning_trigger = { "summon $w", "summon" }
CCLocale.WARLOCK.Healthstone = "ChatCast_InitiateTrade(\"$p\", \"_Healthstone\", 1)" --do not localize this line
CCLocale.WARLOCK.Healthstone_trigger = { "healthstone", "hs" }
CCLocale.WARLOCK.Healthstone_rankitem = { "Minor Healthstone", "Lesser Healthstone", "Healthstone", "Greater Healthstone", "Major Healthstone" }
CCLocale.WARLOCK.Healthstone_spellname = { "Create Healthstone (Minor)", "Create Healthstone (Lesser)", "Create Healthstone", "Create Healthstone (Greater)", "Create Healthstone (Major)" }
CCLocale.WARLOCK.Soulstone = "ChatCast_Soulstone(\"$p\")"
CCLocale.WARLOCK.Soulstone_trigger = { "soulstone", "ss" }
CCLocale.WARLOCK.Soulstone_rankitem = { "Minor Soulstone", "Lesser Soulstone", "Soulstone", "Greater Soulstone", "Major Soulstone" }
CCLocale.WARLOCK.Soulstone_spellname = { "Create Soulstone (Minor)", "Create Soulstone (Lesser)", "Create Soulstone", "Create Soulstone (Greater)", "Create Soulstone (Major)" }
end

--General Triggers
CCLocale.GENERAL = {}
CCLocale.GENERAL.AskInvite = "SendChatMessage(\"invite\", \"WHISPER\", nil, \"$p\")" --"invite" should be translated in this line
CCLocale.GENERAL.AskInvite_trigger = { "autos", "for [^%p]-invites?", "auto.-invites?", "tell [^%p]-invites?", "pst [^%p]-invites?", "msg [^%p]-invites?", "message [^%p]-invites?", "whisp[^%p]- invites?", "/w[^%p]- invites?", "[\"']invite[\"']" }
CCLocale.GENERAL.Invite_Target = "InviteByName(\"$w\")"
CCLocale.GENERAL.Invite_Target_trigger = { "invite $w" }
CCLocale.GENERAL.Invite = "InviteByName(\"$p\")"
CCLocale.GENERAL.Invite_trigger = { "invites?%??", "lfg", "has joined the battle", "inv" }
CCLocale.GENERAL.ChatCast = "ChatCast_Options()"
CCLocale.GENERAL.ChatCast_trigger = { "chatcast" }
CCLocale.GENERAL.PST = "ChatFrame_SendTell(\"$p\")"
CCLocale.GENERAL.PST_trigger = { "pst" }
CCLocale.GENERAL.LFM_alt = "ChatFrame_OpenChat(\"/w $p \" .. gsub(gsub(ChatCast.LFM,\"$l\", UnitLevel(\"player\")), \"$c\", CCClassl))"
CCLocale.GENERAL.LFM = "SendChatMessage(gsub(gsub(ChatCast.LFM,\"$l\", UnitLevel(\"player\")), \"$c\", CCClassl), \"WHISPER\", nil, \"$p\")"
CCLocale.GENERAL.LFM_trigger = { "lf%d?m" }
--CCLocale.GENERAL.Target = "ChatCast_Target(\"$p\", 1)" --exists for HitsMode functionality