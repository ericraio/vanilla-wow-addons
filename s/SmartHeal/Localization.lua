-- ENGLISH VERSION
SH_SMARTHEAL="SmartHeal";
SH_RANK="Rank";
SH_SMARTHEAL_LOADED="SmartHeal is Loaded.";
SH_SPELL_NOT_AVAILABLE="SmartHeal Not Available with this Spell!";
SH_OVERHEAL="Overheal";
SH_SET_TO="set to";
SH_IS_NOT_ACTIVE_CLASS="SmartHeal is not active for this class.";
SH_IS_ACTIVE="Smartheal is active."
SH_USAGE_SMARTHEAL="Usage: /smartheal [option] [value]";
SH_BEGINS_TO_CAST="begins to cast";
SH_ALERT_HEALER_MSG="%s is casting %s on your target %s!!!";
SH_MANA="Mana";
SH_SMARTHEAL_OPTION="SmartHeal Option";
SH_EXCESSIVE_HEALING_ALERT_MSG="Excessive Healing on"
SH_DISABLED="Disabled"

-- Bindings.xml
BINDING_HEADER_SMARTHEAL_AUTO_TARGET	= "SmartHeal - AutoTarget";
BINDING_NAME_SH_AUTOTARGET_HOTKEY1	= "AutoTarget Hotkey 1";
BINDING_NAME_SH_AUTOTARGET_HOTKEY2	= "AutoTarget Hotkey 2";
BINDING_NAME_SH_AUTOTARGET_HOTKEY3	= "AutoTarget Hotkey 3";

-- ClickHeal.lua
SH_UNASSIGNED="Unassigned"

-- SmartHeal_Options.xml
SH_CLOSE="close"
SH_DEFAULT="default"
SH_GENEARL="General"    
SH_CLICKHEAL="ClickHeal"
SH_AUTOTARGET="AutoTarget"
SH_HOTLIST="HotList"

-- SmartHeal_Opt_General.xml
SH_VERSIONLABEL="Version:"
SH_HEALING_BONUS="Healing Bonus:"
SH_ENABLE_SMARTHEAL="Enable SmartHeal"
SH_SHOW_MINIMAP_BUTTON="Show Minimap Button"
SH_OVERHEAL_LABEL="% Overheal e.g. 110=overheal, 90=underheal"
SH_OVERRIDE_HOTKEY="Override Hotkey"
SH_ALTKEY_TO_SELFCAST="Alt Key to Self Cast"
SH_AUTO_SELFCAST="Auto Self Cast"
SH_ALERT_COMPETING_HEALS="Alert competing heals"
SH_ALERT_EXCESSIVE_HEALS="Alert excessive heals"
SH_EXCESSHEALALERT_LABEL="% Excessive heal alert HP ratio"
SH_OVERDRIVE_MODE="Overdrive mode (Forces Max Rank)"
SH_HEALSTACK_CTRA="HealStack (CTRA)"
SH_RCLICK_HOTKEY_TO_SELFCAST="Right Click Hotkey Button Self Cast"

-- SmartHeal_Opt_ClickHeal.xml
SH_CHARACTER_CLASS="Character Class:"
SH_ENABLE_CLICKHEAL="Enable ClickHeal"
SH_SHIFTLEFTCLICK="Shift+LeftClick:"
SH_SHIFTMIDDLECLICK="Shift+MiddleClick:"
SH_SHIFTRIGHTCLICK="Shift+RightClick:"
SH_CTRLLEFTCLICK="Ctrl+LeftClick:"
SH_CTRLMIDDLECLICK="Ctrl+MiddleClick:"
SH_CTRLRIGHTCLICK="Ctrl+RightClick:"
SH_ALTLEFTCLICK="Alt+LeftClick:"
SH_ALTMIDDLECLICK="Alt+MiddleClick:"
SH_ALTRIGHTCLICK="Alt+RightClick:"
SH_DISABLED_BY_OVERDRIVE_MODE="Disabled by Overdrive Mode"

--SmartHeal_Opt_HotList.xml
SH_ENABLE_HOTLIST="Enable HotList"
SH_PRIORITY="Priority"
SH_PCT_HP_RATIO="% HP Ratio"
SH_AUTOTARGET_HOTKEY1="AutoTarget Hotkey 1"
SH_AUTOTARGET_HOTKEY2="AutoTarget Hotkey 2"
SH_AUTOTARGET_HOTKEY3="AutoTarget Hotkey 3"
SH_SET_YOUR_KEYBINDINGS_LABEL="Note: Set your hotkeys in [Option Menu]->[Key Bindings]"
SH_WILL_CAST_FIRST_ON_HOTLIST="Spell target will be the unit at the top of HotList"
SH_BG_COLOR="Background Color"
SH_ENABLE_PRIORITY="Enable Priority"
SH_TOGGLE_PRIORITY="Toggle Priority"
SH_PET="Pet"
SH_RESET_HEALSTACK="Reset HealStack(CTRA)"
SH_HIDE_HP_AT_100="Hide Unit hp@100%"

-- GroupIgnoreList.xml
SH_GROUP_IGNORE_LIST="Group Ignore List"
SH_CURRENT_TARGET_GROUP="Current Target Group:"
SH_GROUP="Group"
SH_IGNORED_GROUPS="Ignored Groups:"

-- NamedTargetList.xml
SH_CURRENT_TARGET_NAME="Current Target Name:"
SH_PRIORITY_NAMES="Priority Names:"
SH_NAMED_TARGET_LIST="Named Target List"

SH_UNITCLASS={	["DRUID"]="Druid", ["HUNTER"]="Hunter", ["MAGE"]="Mage", ["PALADIN"]="Paladin", ["PRIEST"]="Priest",
               	["ROGUE"]="Rogue", ["SHAMAN"]="Shaman", ["WARLOCK"]="Warlock", ["WARRIOR"]="Warrior",['PLAYER']="Player",["PARTY"]="Party"}
		
		
-- GERMAN VERSION
if ( GetLocale() == "deDE" ) then

	-- Umlaute
	-- "ä" -> "\195\164"
	-- "Ä" -> "\195\132"
	-- "ö" -> "\195\182"
	-- "Ö" -> "\195\150"
	-- "ü" -> "\195\188"
	-- "Ü" -> "\195\156"
	-- "ß" -> "\195\159"
	
	
	
	SH_SMARTHEAL="SmartHeal";
	SH_RANK="Rang";
	SH_SMARTHEAL_LOADED="SmartHeal ist geladen...";
	SH_SPELL_NOT_AVAILABLE="SmartHeal ist f\195\188r diesen Spell nicht verf\195\188gbar!";
	SH_OVERHEAL="Overheal";
	SH_SET_TO="set to";
	SH_IS_NOT_ACTIVE_CLASS="SmartHeal ist f\195\188r diese Klasse nicht aktiv.";
	SH_IS_ACTIVE="Smartheal ist aktiv."
	SH_USAGE_SMARTHEAL="Usage: /smartheal [option] [wert]";
	SH_BEGINS_TO_CAST="beginnt zu zaubern";
	SH_ALERT_HEALER_MSG="%s zaubert %s auf dein Ziel %s!!!";
	SH_MANA="Mana";
	SH_SMARTHEAL_OPTION="SmartHeal Optionen";
	SH_EXCESSIVE_HEALING_ALERT_MSG="Warnung !!!\195\188berm\195\164ssige Heilung"
	SH_DISABLED="deaktiviert"
	
	-- Bindings.xml
    BINDING_HEADER_SMARTHEAL_AUTO_TARGET	= "SmartHeal - AutoTarget";
    BINDING_NAME_SH_AUTOTARGET_HOTKEY1	= "AutoTarget Hotkey 1";
    BINDING_NAME_SH_AUTOTARGET_HOTKEY2	= "AutoTarget Hotkey 2";
    BINDING_NAME_SH_AUTOTARGET_HOTKEY3	= "AutoTarget Hotkey 3";

	-- ClickHeal.lua
    SH_UNASSIGNED="nicht gesetzt"

    -- SmartHeal_Options.xml
    SH_CLOSE="schlie\195\159en"
    SH_DEFAULT="standard"
    SH_GENEARL="Allgemein"    
    SH_CLICKHEAL="ClickHeal"
    SH_AUTOTARGET="AutoTarget"
    SH_HOTLIST="Priorit\195\164tsliste"

    -- SmartHeal_Opt_General.xml
    SH_VERSIONLABEL="Version:"
    SH_HEALING_BONUS="Heil Bonus:"
    SH_ENABLE_SMARTHEAL="SmartHeal aktivieren"
    SH_SHOW_MINIMAP_BUTTON="Minimap Symbol anzeigen"
    SH_OVERHEAL_LABEL="% Overheal z.B. 110=overheal, 90=underheal"
    SH_OVERRIDE_HOTKEY="Hotkey's \195\188berschreiben"
    SH_ALTKEY_TO_SELFCAST="Alt Taste f\195\188r Self Cast"
    SH_AUTO_SELFCAST="Automatischer Self Cast"
    SH_ALERT_COMPETING_HEALS="Meldung bei Konkurrierender Heilung"
    SH_ALERT_EXCESSIVE_HEALS="Meldung bei \195\188berm\195\164ssiger Heilung von Spielern"
    SH_EXCESSHEALALERT_LABEL="%-wert(hp) ab dem \195\188berm\195\164ssige Heilung gemeldet wird "
    SH_OVERDRIVE_MODE="\195\156bermodus (forciert Max. Rang)"
    SH_HEALSTACK_CTRA="HealStack (CTRA)"
    SH_RCLICK_HOTKEY_TO_SELFCAST="Rechte Maustaste Hotkey Button Self Cast"
    
    -- SmartHeal_Opt_ClickHeal.xml
    SH_CHARACTER_CLASS="Character Klasse:"
    SH_ENABLE_CLICKHEAL="Aktiviere ClickHeal"
    SH_SHIFTLEFTCLICK="Shift+Linke Maustaste:"
    SH_SHIFTMIDDLECLICK="Shift+Mittlere Maustaste:"
    SH_SHIFTRIGHTCLICK="Shift+Rechte Maustaste:"
    SH_CTRLLEFTCLICK="Strg+Linke Maustaste:"
    SH_CTRLMIDDLECLICK="Strg+Mittlere Maustaste:"
    SH_CTRLRIGHTCLICK="Strg+Rechte Maustaste:"
    SH_ALTLEFTCLICK="Alt+Linke Maustaste:"
    SH_ALTMIDDLECLICK="Alt+Mittlere Maustaste:"
    SH_ALTRIGHTCLICK="Alt+Rechte Maustaste:"
    SH_DISABLED_BY_OVERDRIVE_MODE="Durch \195\156bermodus-Modus deaktiviert"
    
    --SmartHeal_Opt_HotList.xml
    SH_ENABLE_HOTLIST="aktiviere Priorit\195\164tsliste"
    SH_PRIORITY="Priorit\195\164t"
    SH_PCT_HP_RATIO="%-wert hp"
    SH_AUTOTARGET_HOTKEY1="AutoTarget Hotkey 1"
    SH_AUTOTARGET_HOTKEY2="AutoTarget Hotkey 2"
    SH_AUTOTARGET_HOTKEY3="AutoTarget Hotkey 3"
    SH_SET_YOUR_KEYBINDINGS_LABEL="Note: Setzt eure Hotkeys unter [Hauptmen\195\188]->[Tastenbelegung]"
    SH_WILL_CAST_FIRST_ON_HOTLIST="Ziel eurer Zauber wird das mit der h\195\182chsten priorit\195\164t sein"
    SH_BG_COLOR="Hintergrundfarbe"
    SH_ENABLE_PRIORITY="aktiviere Priorit\195\164t"
    SH_TOGGLE_PRIORITY="Toggle Priorit\195\164t"
    SH_PET="Haustiere"
    SH_RESET_HEALSTACK="Zur\195\188ckstellen HealStack(CTRA)"
    SH_HIDE_HP_AT_100="Fellma\195\159einheit hp@100%"
    
    -- SmartHeal_Opt_Autotarget.xml
    SH_COMING_SOON="in Planung";
    
    -- GroupIgnoreList.xml
    SH_GROUP_IGNORE_LIST="Gruppe Ignorieren Liste"
    SH_CURRENT_TARGET_GROUP="gegenw\195\164rtig Ziel Gruppe:"
    SH_GROUP="Gruppe"
    SH_IGNORED_GROUPS="Ignoriert Gruppen:"
    SH_NAMED_TARGET_LIST="Named Target List:"

    
    SH_UNITCLASS={["DRUID"]="Druide", ["HUNTER"]="J\195\164ger", ["MAGE"]="Magier", ["PALADIN"]="Paladin", ["PRIEST"]="Priester",
               ["ROGUE"]="Schurke", ["SHAMAN"]="Schamane", ["WARLOCK"]="Hexenmeister", ["WARRIOR"]="Krieger",}

end

-- FRENCH VERSION
if ( GetLocale() == "frFR" ) then

	SH_SMARTHEAL="SmartHeal";
	SH_RANK="Rang";
	SH_SMARTHEAL_LOADED="SmartHeal est charg\195\169.";
	SH_SPELL_NOT_AVAILABLE="SmartHeal n'est pas disponible pour ce sort!";
	SH_OVERHEAL="Overheal";
	SH_SET_TO="set to";
	SH_IS_NOT_ACTIVE_CLASS="SmartHeal n'est pas actif pour cette classe.";
	SH_IS_ACTIVE="Smartheal est actif."
	SH_USAGE_SMARTHEAL="Usage: /smartheal [option] [value]";
	SH_BEGINS_TO_CAST="commence \195\160 lancer";
	SH_ALERT_HEALER_MSG="%s incante %s sur votre cible %s!!!";
	SH_MANA="Mana";
	SH_SMARTHEAL_OPTION="SmartHeal Option";
	SH_EXCESSIVE_HEALING_ALERT_MSG="Soins en exces sur"
	SH_DISABLED="D\195\169sactiv\195\169"

	-- Bindings.xml
	BINDING_HEADER_SMARTHEAL_AUTO_TARGET	= "SmartHeal - AutoTarget";
	BINDING_NAME_SH_AUTOTARGET_HOTKEY1	= "AutoTarget Hotkey 1";
	BINDING_NAME_SH_AUTOTARGET_HOTKEY2	= "AutoTarget Hotkey 2";
	BINDING_NAME_SH_AUTOTARGET_HOTKEY3	= "AutoTarget Hotkey 3";

	-- ClickHeal.lua
	SH_UNASSIGNED="Non assign\195\169"

	-- SmartHeal_Options.xml
	SH_CLOSE="Fermer"
	SH_DEFAULT="Par d\195\169faut"
	SH_GENEARL="G\195\169n\195\169ral"    
	SH_CLICKHEAL="ClickHeal"
	SH_AUTOTARGET="AutoTarget"
	SH_HOTLIST="HotList"

	-- SmartHeal_Opt_General.xml
	SH_VERSIONLABEL="Version:"
	SH_HEALING_BONUS="Bonus au soins:"
	SH_ENABLE_SMARTHEAL="Enable SmartHeal"
	SH_SHOW_MINIMAP_BUTTON="Show Minimap Button"
	SH_OVERHEAL_LABEL="% Overheal e.g. 110=overheal, 90=underheal"
	SH_OVERRIDE_HOTKEY="Override Hotkey"
	SH_ALTKEY_TO_SELFCAST="Alt Key to Self Cast"
	SH_AUTO_SELFCAST="Auto Self Cast"
	SH_ALERT_COMPETING_HEALS="Alert competing heals"
	SH_ALERT_EXCESSIVE_HEALS="Alert excessive heals"
	SH_EXCESSHEALALERT_LABEL="% Excessive heal alert HP ratio"
	SH_OVERDRIVE_MODE="Overdrive mode (Forces Max Rank)"
	SH_HEALSTACK_CTRA="HealStack (CTRA)"
	SH_RCLICK_HOTKEY_TO_SELFCAST="Right Click Hotkey Button Self Cast"

	-- SmartHeal_Opt_ClickHeal.xml
	SH_CHARACTER_CLASS="Character Class:"
	SH_ENABLE_CLICKHEAL="Enable ClickHeal"
	SH_SHIFTLEFTCLICK="Shift+LeftClick:"
	SH_SHIFTMIDDLECLICK="Shift+MiddleClick:"
	SH_SHIFTRIGHTCLICK="Shift+RightClick:"
	SH_CTRLLEFTCLICK="Ctrl+LeftClick:"
	SH_CTRLMIDDLECLICK="Ctrl+MiddleClick:"
	SH_CTRLRIGHTCLICK="Ctrl+RightClick:"
	SH_ALTLEFTCLICK="Alt+LeftClick:"
	SH_ALTMIDDLECLICK="Alt+MiddleClick:"
	SH_ALTRIGHTCLICK="Alt+RightClick:"
	SH_DISABLED_BY_OVERDRIVE_MODE="Disabled by Overdrive Mode"

	--SmartHeal_Opt_HotList.xml
	SH_ENABLE_HOTLIST="Enable HotList"
	SH_PRIORITY="Priority"
	SH_PCT_HP_RATIO="% HP Ratio"
	SH_AUTOTARGET_HOTKEY1="AutoTarget Hotkey 1"
	SH_AUTOTARGET_HOTKEY2="AutoTarget Hotkey 2"
	SH_AUTOTARGET_HOTKEY3="AutoTarget Hotkey 3"
	SH_SET_YOUR_KEYBINDINGS_LABEL="Note: Set your hotkeys in [Option Menu]->[Key Bindings]"
	SH_WILL_CAST_FIRST_ON_HOTLIST="Spell target will be the unit at the top of HotList"
	SH_BG_COLOR="Background Color"
	SH_ENABLE_PRIORITY="Enable Priority"
	SH_TOGGLE_PRIORITY="Toggle Priority"
	SH_PET="Animaux de compagnie"
	SH_RESET_HEALSTACK="Remettre \195\160 z\195\169ro HealStack(CTRA)"
	SH_HIDE_HP_AT_100="Unit\195\169 de peau hp@100%"

	-- GroupIgnoreList.xml
	SH_GROUP_IGNORE_LIST="La liste de l'Ignor\195\169"
	SH_CURRENT_TARGET_GROUP="Groupe Cible Courant:"
	SH_GROUP="Groupe"
	SH_IGNORED_GROUPS="Groupes Ignor\195\169:"
	SH_NAMED_TARGET_LIST="Named Target List:"
	
	SH_UNITCLASS={	["DRUID"]="Druide", ["HUNTER"]="Chasseur", ["MAGE"]="Mage", ["PALADIN"]="Paladin", ["PRIEST"]="Pr\195\170tre",
			["ROGUE"]="Voleur", ["SHAMAN"]="Chaman", ["WARLOCK"]="D\195\169moniste", ["WARRIOR"]="Guerrier",['PLAYER']="Joueur",["PARTY"]="Groupe"}

end
