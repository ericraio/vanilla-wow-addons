-------------------------------------------------------------------------------
-- English localization
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
--User Interface Strings
-------------------------------------------------------------------------------
-- this is the key bidning string
BINDING_NAME_QSATARGET  = "Target Last Caster";
-- what a totem is called
QSA_TOTEM               = "Totem";

QSA_MACRO_STATUS = "status";
QSA_MACRO_STATUS_DESC = "This displays the current settings";
QSA_MACRO_TOGGLE = "toggle";
QSA_MACRO_TOGGLE_DESC = "This toggles Quu Spell Alert on and off";
QSA_MACRO_REPORT = "report";
QSA_MACRO_REPORT_DESC = "This reports important events into party/raid";
QSA_MACRO_TARGET = "target";
QSA_MACRO_TARGET_DESC = "This will attempt to target the last name displayed";
QSA_MACRO_SHOW   = "show";
QSA_MACRO_SHOW_DESC = "This shows the anchor";
QSA_MACRO_EMOTE  = "emote";
QSA_MACRO_EMOTE_DESC = "This toggles the displaying of emotes";
QSA_MACRO_GAIN   = "gain";
QSA_MACRO_GAIN_DESC = "This toggles the displaying of 'gains'";
QSA_MACRO_FADE   = "fade";
QSA_MACRO_FADE_DESC = "This toggles the displaying of 'fades'";
QSA_MACRO_COMBAT = "combat";
QSA_MACRO_COMBAT_DESC = "This toggles the combat only mode";
QSA_MACRO_TRGNLY = "trgonly";
QSA_MACRO_TRGNLY_DESC = "This toggles the target only mode";
QSA_MACRO_SHORT = "short";
QSA_MACRO_SHORT_DESC = "This toggles the short display mode";
QSA_MACRO_AFFL = "affliction";
QSA_MACRO_AFFL_DESC = "This toggles the displaying of afflictions on and off";
QSA_MACRO_TEST   = "test";
QSA_MACRO_TEST_DESC = "This shows a test message... good for moving";

QSA_MACRO_ERROR = "Unknown QSA command!";

QSA_STATUS_ENABLED  = " Quu Spell Alert enabled.";
QSA_STATUS_DISBALED = " Quu Spell Alert disabled.";
QSA_REPORT_ENABLED  = " Reporting for group enabled.";
QSA_EMOTE_ENABLED   = " Emote mode enabled.";
QSA_GAIN_ENABLED    = " Gain mode enabled.";
QSA_FADE_ENABLED    = " Fade mode enabled.";
QSA_COMBAT_ENABLED  = " Combat only mode enabled.";
QSA_TRGONLY_ENABLED = " Target only mode enabled.";
QSA_SHORT_ENABLED   = " Short display mode enabled.";
QSA_AFFL_ENABLED    = " Afflicted mode enabled.";

QSA_BUTTON_ENABLE  = "Enable Quu Spell Alert";
QSA_BUTTON_REPORT  = "Enable reports to Raid/Party";
QSA_BUTTON_GAIN    = "Enable alerts for effects 'Gained'";
QSA_BUTTON_FADE    = "Enable alerts for effects 'Lost'";
QSA_BUTTON_EMOTE   = "Enable alerts for emotes";
QSA_BUTTON_AFFLIC  = "Enable the reporting of afflictions";
QSA_BUTTON_COMBAT  = "Enable combat only mode";
QSA_BUTTON_TRGONLY = "Enable target only mode";
QSA_BUTTON_SHORT   = "Enable alert 'short' format";

-------------------------------------------------------------------------------
-- output settings
-------------------------------------------------------------------------------
-- Short Form banner messages
-- for all of these... $c = caster, $e = effect
QSA_CASTING_BANNER = "$e ($c)";
QSA_GAIN_BANNER    = "*$e* ($c)";
QSA_FADE_BANNER    = "(-)$e(-) ($c)";
QSA_EMOTE_BANNER   = "$c $e";


-------------------------------------------------------------------------------
-- the logic arrays... ignored effects and important effects
-------------------------------------------------------------------------------
QSA_IgnoreSpells = {
	-- stuff from the original Spell Alert
	["Abolish Poision"] = true,
	["Aimed Shot"] = true,
	["Arcane Shot"] = true,
	["Argent Dawn Commission"] = true,
	["Aspect of the Cheetah"] = true,
	["Aspect of the Hawk"] = true,
	["Aspect of the Monkey"] = true,
	["Attack"] = true,
	["Battle Shout"] = true,
	["Bloodrage"] = true,
	["Blood Craze"] = true,
	["Blood Pact"] = true,
	["Battle Stance"] = true,
	["Berserker Stance"] = true,
	["Blade Flurry"] = true,
	["Blink"] = true,
	["Clearcasting"] = true,
	["Concussive Shot"] = true,
	["Dash"] = true,
	["Defensive Stance"] = true,
	["Detect Traps"] = true,
	["Devotion Aura"] = true,
	["Enrage"] = true,
	["Evasion"] = true,
	["Explosive Shot"] = true,
	["Fade"] = true,
	-- mages would care about this
	-- ["Fire Resistance Aura"] = true,
	["Flurry"] = true,
	["Focused Casting"] = true,
	["Haste"] = true,
	["Holy Strength"] = true,
	["Inspiration"] = true,
	["Julie's Blessing"] = true,
	["Serpent Sting"] = true,
	["Scatter Shot"] = true,
	["Spirit of Redemption"] = true,
	["Spirit Tap"] = true,
	["Sprint"] = true,
	["Stealth"] = true,
	["Swiftshifting"] = true,
	["Travel Form"] = true,
	["Viper Sting"] = true,

	["Stoneclaw Totem"] = true, -- um... a player would not care about a taunt totem

	["Taunt"] = true,
	-- this should be consumed with SPELLEXTRAATTACKSOTHER but it is not
	["2 extra attacks through Thrash"] = true,

	["attempts to run away in fear!"] = true, -- i hate the run away messages
	["grumbles."] = true, -- LBRS
	["cries."] = true, -- LBRS
	["cries for help."] = true, -- UBRS

	-- CTRA settings
	["takes in a deep breath..."] = true, -- Onyxia's big attack... from CQOnyxia mod by sudo
	["goes into a killing frenzy!"] = true, -- Magmadar frenzy ability from CQMagmadar from sudo
}
QSA_ImportantSpells = {
	-- this are cast spells
	["Fear"] = true,
	["Entangling Roots"] = true,
	["Polymorph"] = true,
	["Silence"] = true,
	["Dominate Mind"] = true,
	["Mind Control"] = true,
	["Frenzy"] = true, -- magnamar
}

QSA_Alert_Afflictions = {
	["Dominate Mind"] = true,
	["Mind Control"] = true,
}



-- the re targeting stuff
QSA_FEIGN_DEATH = "Feign Death";
QSA_RETARGET_MSG = "QuuSpellAlert is trying to retarget after $e : $c"
QSA_ReTarget_Afflictions = {
	["Scatter Shot"] = true,
	["Fear"] = true,
	["Intimidating Shout"] = true,
	["Psychic Scream"] = true,
	["Panic"] = true,
	["Bellowing Roar"] = true,
	["Ancient Despair"] = true,
	["Terrifying Screech"] = true,
	["Polymorph"] = true,
}

if ( GetLocale() == "deDE_DISABLED" ) then
-------------------------------------------------------------------------------
-- German localization
-------------------------------------------------------------------------------
elseif ( GetLocale() == "frFR_DISABLED" ) then
-------------------------------------------------------------------------------
-- French localization
-------------------------------------------------------------------------------
end
