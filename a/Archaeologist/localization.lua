--------------------------------------------------------------------------
-- localization.lua 
--------------------------------------------------------------------------

ARCHAEOLOGIST_SUPER_SLASH_COMMAND = "/arch";

PLAYER_GHOST 						= "Ghost";
PLAYER_WISP 						= "Wisp";
FEIGN_DEATH							= "Feign Death";

ARCHAEOLOGIST_CONFIG_SEP				= "Archaeologist";
ARCHAEOLOGIST_CONFIG_SEP_INFO			= "Archaeologist Settings";

ARCHAEOLOGIST_FEEDBACK_STRING = "%s changed to %s.";
ARCHAEOLOGIST_NOT_A_VALID_FONT = "%s is not a valid font.";
ArchaeologistLocalizedFonts = { 
	["Default"] = "Default";
	--change fist string for displayd string
	--values must match ArchaeologistFonts keys
	["GameFontNormal"] = "GameFontNormal";
	["NumberFontNormal"] = "NumberFontNormal";
	["ItemTextFontNormal"] = "ItemTextFontNormal";
};

ARCHAEOLOGIST_ON = "On";
ARCHAEOLOGIST_OFF = "Off";
ARCHAEOLOGIST_MOUSEOVER = "Mouseover";

ARCHAEOLOGIST_FONT_OPTIONS = "Font Options:"
for key, name in ArchaeologistLocalizedFonts do
	ARCHAEOLOGIST_FONT_OPTIONS = " "..ARCHAEOLOGIST_FONT_OPTIONS..key..",";
end
ARCHAEOLOGIST_FONT_OPTIONS = string.sub(ARCHAEOLOGIST_FONT_OPTIONS, 1, string.len(ARCHAEOLOGIST_FONT_OPTIONS)-1);

-- <= == == == == == == == == == == == == =>
-- => Presets
-- <= == == == == == == == == == == == == =>

ARCHAEOLOGIST_CONFIG_PRESETS = "Presets";
ARCHAEOLOGIST_CONFIG_SET = "Set";

ARCHAEOLOGIST_CONFIG_VALUES_ON_BARS				= "Values on the Bars";
ARCHAEOLOGIST_CONFIG_VALUES_NEXTTO_BARS			= "Values next to the Bars";
ARCHAEOLOGIST_CONFIG_PERCENTAGE_ON_BARS			= "Percentage on the Bars";
ARCHAEOLOGIST_CONFIG_PERCENTAGE_NEXTTO_BARS		= "Percentage next to the Bars";
ARCHAEOLOGIST_CONFIG_PERCENTAGE_ON_VALUES_NEXTTO_BARS		= "Percentage on, Values next to the Bars";
ARCHAEOLOGIST_CONFIG_VALUES_ON_PERCENTAGE_NEXTTO_BARS		= "Values on, Percentage next to the Bars";

ARCHAEOLOGIST_CONFIG_PREFIXES_OFF				= "All Prefixes Off";
ARCHAEOLOGIST_CONFIG_PREFIXES_ON				= "All Prefixes On";
ARCHAEOLOGIST_CONFIG_PREFIXES_DEFAULT			= "All Prefixes Default";

-- <= == == == == == == == == == == == == =>
-- => Player Options
-- <= == == == == == == == == == == == == =>

ARCHAEOLOGIST_CONFIG_PLAYER_SEP				= "Player Status Bar Settings";
ARCHAEOLOGIST_CONFIG_PLAYER_SEP_INFO		= "Most values, by default, can be seen on mouseover.";
		
ARCHAEOLOGIST_CONFIG_PLAYERHP		= "Primary Player Health Display";
ARCHAEOLOGIST_CONFIG_PLAYERHP_INFO = "Shows player health text over the bar. (Options: On, Off, Mouseover)";
ARCHAEOLOGIST_CONFIG_PLAYERHP2		= "Secondary Player Health Display";
ARCHAEOLOGIST_CONFIG_PLAYERHP2_INFO = "Shows player health text next to the bar. (Options: On, Off, Mouseover)";
ARCHAEOLOGIST_CONFIG_PLAYERMP		= "Primary Player Mana Display";
ARCHAEOLOGIST_CONFIG_PLAYERMP_INFO = "Shows player mana text over the bar. (Options: On, Off, Mouseover)";
ARCHAEOLOGIST_CONFIG_PLAYERMP2		= "Secondary Player Mana Display";
ARCHAEOLOGIST_CONFIG_PLAYERMP2_INFO = "Shows player mana text next to the bar. (Options: On, Off, Mouseover)";
ARCHAEOLOGIST_CONFIG_PLAYERXP		= "Player Experience Display";
ARCHAEOLOGIST_CONFIG_PLAYERXP_INFO = "Shows player experience text on the bar. (Options: On, Off, Mouseover)";
ARCHAEOLOGIST_CONFIG_PLAYERXPP			= "Show Percentage on the Player XP bar";
ARCHAEOLOGIST_CONFIG_PLAYERXPP_INFO	= "Show Percentage on the Player XP bar";
ARCHAEOLOGIST_CONFIG_PLAYERXPV			= "Show Exact Value on the Player XP bar";
ARCHAEOLOGIST_CONFIG_PLAYERXPV_INFO	= "Show Exact Value on the Player XP bar";
ARCHAEOLOGIST_CONFIG_PLAYERHPINVERT			= "Show Player Health Missing";
ARCHAEOLOGIST_CONFIG_PLAYERHPINVERT_INFO	= "Invert the player health display.";
ARCHAEOLOGIST_CONFIG_PLAYERMPINVERT			= "Show Player Mana Missing";
ARCHAEOLOGIST_CONFIG_PLAYERMPINVERT_INFO	= "Invert the player mana display.";
ARCHAEOLOGIST_CONFIG_PLAYERXPINVERT			= "Show Experience Left to Level";
ARCHAEOLOGIST_CONFIG_PLAYERXPINVERT_INFO	= "Invert the player XP display";
ARCHAEOLOGIST_CONFIG_PLAYERHPNOPREFIX		= "Hide Player Health Prefix";
ARCHAEOLOGIST_CONFIG_PLAYERHPNOPREFIX_INFO	= "Turns off the 'Health' prefix on the player health bar.";
ARCHAEOLOGIST_CONFIG_PLAYERMPNOPREFIX		= "Hide Player Mana Prefix";
ARCHAEOLOGIST_CONFIG_PLAYERMPNOPREFIX_INFO	= "Turns off the 'Mana/Rage/Power' prefix on the player mana bar.";
ARCHAEOLOGIST_CONFIG_PLAYERXPNOPREFIX		= "Hide Player XP Prefix";
ARCHAEOLOGIST_CONFIG_PLAYERXPNOPREFIX_INFO	= "Turns off the 'XP' prefix on the player xp bar.";
ARCHAEOLOGIST_CONFIG_PLAYERCLASSICON		= "Show Player Class Icon";
ARCHAEOLOGIST_CONFIG_PLAYERCLASSICON_INFO	= "Turns on the class icon on the player frame.";
ARCHAEOLOGIST_CONFIG_PLAYERHPSWAP			= "Swap Player Health Percent and Value";
ARCHAEOLOGIST_CONFIG_PLAYERHPSWAP_INFO		= "Swaps Primary and Secondary Player Health Displays";
ARCHAEOLOGIST_CONFIG_PLAYERMPSWAP			= "Swap Player Mana Percent and Value";
ARCHAEOLOGIST_CONFIG_PLAYERMPSWAP_INFO		= "Swaps Primary and Secondary Player Mana Displays";

-- <= == == == == == == == == == == == == =>
-- => Party Options
-- <= == == == == == == == == == == == == =>

ARCHAEOLOGIST_CONFIG_PARTY_SEP				= "Party Status Bar Settings";
ARCHAEOLOGIST_CONFIG_PARTY_SEP_INFO			= "Most values, by default, can be seen on mouseover.";

ARCHAEOLOGIST_CONFIG_PARTYHP		= "Primary Party Health Display";
ARCHAEOLOGIST_CONFIG_PARTYHP_INFO = "Shows party health text over the bar. (Options: On, Off, Mouseover)";
ARCHAEOLOGIST_CONFIG_PARTYHP2		= "Secondary Party Health Display";
ARCHAEOLOGIST_CONFIG_PARTYHP2_INFO = "Shows party health text next to the bar. (Options: On, Off, Mouseover)";
ARCHAEOLOGIST_CONFIG_PARTYMP		= "Primary Party Mana Display";
ARCHAEOLOGIST_CONFIG_PARTYMP_INFO = "Shows party mana text over the bar. (Options: On, Off, Mouseover)";
ARCHAEOLOGIST_CONFIG_PARTYMP2		= "Secondary Party Mana Display";
ARCHAEOLOGIST_CONFIG_PARTYMP2_INFO = "Shows party mana text next to the bar. (Options: On, Off, Mouseover)";
ARCHAEOLOGIST_CONFIG_PARTYHPINVERT			= "Show Party Health Missing";
ARCHAEOLOGIST_CONFIG_PARTYHPINVERT_INFO	= "Invert the party health display.";
ARCHAEOLOGIST_CONFIG_PARTYMPINVERT			= "Show Party Mana Missing";
ARCHAEOLOGIST_CONFIG_PARTYMPINVERT_INFO	= "Invert the party mana display.";
ARCHAEOLOGIST_CONFIG_PARTYHPNOPREFIX		= "Hide Party Health Prefix";
ARCHAEOLOGIST_CONFIG_PARTYHPNOPREFIX_INFO	= "Turns off the 'Health' prefix on the party health bars.";
ARCHAEOLOGIST_CONFIG_PARTYMPNOPREFIX		= "Hide Party Mana Prefix";
ARCHAEOLOGIST_CONFIG_PARTYMPNOPREFIX_INFO	= "Turns off the 'Mana/Rage/Power' prefix on the party mana bars.";
ARCHAEOLOGIST_CONFIG_PARTYCLASSICON			= "Show Party Class Icons";
ARCHAEOLOGIST_CONFIG_PARTYCLASSICON_INFO	= "Turns on the class icons on the party member frames.";
ARCHAEOLOGIST_CONFIG_PARTYHPSWAP			= "Swap Party Health Percent and Value";
ARCHAEOLOGIST_CONFIG_PARTYHPSWAP_INFO		= "Swaps Primary and Secondary Party Health Displays";
ARCHAEOLOGIST_CONFIG_PARTYMPSWAP			= "Swap Party Mana Percent and Value";
ARCHAEOLOGIST_CONFIG_PARTYMPSWAP_INFO		= "Swaps Primary and Secondary Party Mana Displays";

-- <= == == == == == == == == == == == == =>
-- => Pet Options
-- <= == == == == == == == == == == == == =>

ARCHAEOLOGIST_CONFIG_PET_SEP				= "Pet Status Bar Settings";
ARCHAEOLOGIST_CONFIG_PET_SEP_INFO			= "Most values, by default, can be seen on mouseover.";

ARCHAEOLOGIST_CONFIG_PETHP		= "Primary Pet Health Display";
ARCHAEOLOGIST_CONFIG_PETHP_INFO = "Shows pet health text over the bar. (Options: On, Off, Mouseover)";
ARCHAEOLOGIST_CONFIG_PETHP2		= "Secondary Pet Health Display";
ARCHAEOLOGIST_CONFIG_PETHP2_INFO = "Shows pet health text next to the bar. (Options: On, Off, Mouseover)";
ARCHAEOLOGIST_CONFIG_PETMP		= "Primary Pet Mana Display";
ARCHAEOLOGIST_CONFIG_PETMP_INFO = "Shows pet mana text over the bar. (Options: On, Off, Mouseover)";
ARCHAEOLOGIST_CONFIG_PETMP2		= "Secondary Pet Mana Display";
ARCHAEOLOGIST_CONFIG_PETMP2_INFO = "Shows pet mana text next to the bar. (Options: On, Off, Mouseover)";
ARCHAEOLOGIST_CONFIG_PETXP		= "Pet Experience Display";
ARCHAEOLOGIST_CONFIG_PETXP_INFO = "Shows pet experience text on the bar. (Options: On, Off, Mouseover)";
ARCHAEOLOGIST_CONFIG_PETXPP			= "Show Percentage on the Pet XP bar";
ARCHAEOLOGIST_CONFIG_PETXPP_INFO	= "Show Percentage on the Pet XP bar";
ARCHAEOLOGIST_CONFIG_PETXPV			= "Show Exact Value on the Pet XP bar";
ARCHAEOLOGIST_CONFIG_PETXPV_INFO	= "Show Exact Value on the Pet XP bar";
ARCHAEOLOGIST_CONFIG_PETHPINVERT			= "Show Pet Health Missing";
ARCHAEOLOGIST_CONFIG_PETHPINVERT_INFO	= "Invert the pet health display.";
ARCHAEOLOGIST_CONFIG_PETMPINVERT			= "Show Pet Mana Missing";
ARCHAEOLOGIST_CONFIG_PETMPINVERT_INFO	= "Invert the pet mana display.";
ARCHAEOLOGIST_CONFIG_PETHPNOPREFIX			= "Hide Pet Health Prefix";
ARCHAEOLOGIST_CONFIG_PETHPNOPREFIX_INFO	= "Turns off the 'Health' prefix on the pet health bar.";
ARCHAEOLOGIST_CONFIG_PETMPNOPREFIX			= "Hide Pet Mana Prefix";
ARCHAEOLOGIST_CONFIG_PETMPNOPREFIX_INFO	= "Turns off the 'Mana/Rage/Power' prefix on the bet mana bar.";
ARCHAEOLOGIST_CONFIG_PETXPNOPREFIX		= "Hide Pet XP Prefix";
ARCHAEOLOGIST_CONFIG_PETXPNOPREFIX_INFO	= "Turns off the 'XP' prefix on the pet xp bar.";
ARCHAEOLOGIST_CONFIG_PETHPSWAP			= "Swap Pet Health Percent and Value";
ARCHAEOLOGIST_CONFIG_PETHPSWAP_INFO		= "Swaps Primary and Secondary Pet Health Displays";
ARCHAEOLOGIST_CONFIG_PETMPSWAP			= "Swap Pet Mana Percent and Value";
ARCHAEOLOGIST_CONFIG_PETMPSWAP_INFO		= "Swaps Primary and Secondary Pet Mana Displays";

-- <= == == == == == == == == == == == == =>
-- => Target Options
-- <= == == == == == == == == == == == == =>

ARCHAEOLOGIST_CONFIG_TARGET_SEP				= "Target Status Bar Settings";
ARCHAEOLOGIST_CONFIG_TARGET_SEP_INFO		= "Most values, by default, can be seen on mouseover.";

ARCHAEOLOGIST_CONFIG_TARGETHP		= "Primary Target Health Display";
ARCHAEOLOGIST_CONFIG_TARGETHP_INFO = "Shows target health text over the bar. (Options: On, Off, Mouseover)";
ARCHAEOLOGIST_CONFIG_TARGETHP2		= "Secondary Target Health Display";
ARCHAEOLOGIST_CONFIG_TARGETHP2_INFO = "Shows target health text next to the bar. (Options: On, Off, Mouseover)";
ARCHAEOLOGIST_CONFIG_TARGETMP		= "Primary Target Mana Display";
ARCHAEOLOGIST_CONFIG_TARGETMP_INFO = "Shows target mana text over the bar. (Options: On, Off, Mouseover)";
ARCHAEOLOGIST_CONFIG_TARGETMP2		= "Secondary Target Mana Display";
ARCHAEOLOGIST_CONFIG_TARGETMP2_INFO = "Shows target mana text next to the bar. (Options: On, Off, Mouseover)";
ARCHAEOLOGIST_CONFIG_TARGETHPINVERT			= "Show Target Health Missing";
ARCHAEOLOGIST_CONFIG_TARGETHPINVERT_INFO	= "Invert the target health display.";
ARCHAEOLOGIST_CONFIG_TARGETMPINVERT			= "Show Target Mana Missing";
ARCHAEOLOGIST_CONFIG_TARGETMPINVERT_INFO	= "Invert the target mana display.";
ARCHAEOLOGIST_CONFIG_TARGETHPNOPREFIX		= "Hide Target Health Prefix";
ARCHAEOLOGIST_CONFIG_TARGETHPNOPREFIX_INFO	= "Turns off the 'Health' prefix on the target health bar.";
ARCHAEOLOGIST_CONFIG_TARGETMPNOPREFIX		= "Hide Target Mana Prefix";
ARCHAEOLOGIST_CONFIG_TARGETMPNOPREFIX_INFO	= "Turns off the 'Mana/Rage/Power' prefix on the target mana bar.";
ARCHAEOLOGIST_CONFIG_TARGETCLASSICON		= "Show Target Class Icon";
ARCHAEOLOGIST_CONFIG_TARGETCLASSICON_INFO	= "Turns on the class icon on the target frame.";
ARCHAEOLOGIST_CONFIG_TARGETHPSWAP			= "Swap Target Health Percent and Value";
ARCHAEOLOGIST_CONFIG_TARGETHPSWAP_INFO		= "Swaps Primary and Secondary Target Health Displays";
ARCHAEOLOGIST_CONFIG_TARGETMPSWAP			= "Swap Target Mana Percent and Value";
ARCHAEOLOGIST_CONFIG_TARGETMPSWAP_INFO		= "Swaps Primary and Secondary Target Mana Displays";

-- <= == == == == == == == == == == == == =>
-- => Alternate Options
-- <= == == == == == == == == == == == == =>

ARCHAEOLOGIST_CONFIG_ALTOPTS_SEP			= "Alternate Options";
ARCHAEOLOGIST_CONFIG_ALTOPTS_SEP_INFO		= "Alternate Options";

ARCHAEOLOGIST_CONFIG_HPCOLOR			= "Turn On Health Bar Color Change";
ARCHAEOLOGIST_CONFIG_HPCOLOR_INFO		= "Healthbar changes color as it decreases.";

ARCHAEOLOGIST_CONFIG_DEBUFFALT			= "Alternate Pet/Party Debuff Location";
ARCHAEOLOGIST_CONFIG_DEBUFFALT_INFO		= "Moves Pet and Party Debuffs to below the Buffs.\nDefault: show to the right of the unit frame.";

ARCHAEOLOGIST_CONFIG_TBUFFALT			= "Wrap Target Buff/Debuffs in rows of 8";
ARCHAEOLOGIST_CONFIG_TBUFFALT_INFO		= "Show two rows of 8 target buffs and two rows of 8 target debuffs.";

ARCHAEOLOGIST_CONFIG_USEHPVALUE			= "Use Target HP Values When Possible";
ARCHAEOLOGIST_CONFIG_USEHPVALUE_INFO	= "Will replace the target percent display with actual values when possible.";

ARCHAEOLOGIST_CONFIG_MOBHEALTH			= "Use MobHealth2 for Target HP";
ARCHAEOLOGIST_CONFIG_MOBHEALTH_INFO		= "Hides the regular MobHealth2 text and uses it in place of the HP text on the Target Frame.";

ARCHAEOLOGIST_CONFIG_CLASSPORTRAIT		= "Class Portrait";
ARCHAEOLOGIST_CONFIG_CLASSPORTRAIT_INFO = "Replace unit portraits with class icons when applicable.";

-- <= == == == == == == == == == == == == =>
-- => Font Options
-- <= == == == == == == == == == == == == =>

ARCHAEOLOGIST_CONFIG_FONTOPTS_SEP			= "Font Options";
ARCHAEOLOGIST_CONFIG_FONTOPTS_SEP_INFO		= "Font Options";

ARCHAEOLOGIST_CONFIG_HPMPLARGESIZE		= "Set Player/Target Text Size.";
ARCHAEOLOGIST_CONFIG_HPMPLARGESIZE_SLIDER_TEXT   = "Font Size";

ARCHAEOLOGIST_CONFIG_HPMPLARGEFONT		= "Set Player/Target Text Font.";
ARCHAEOLOGIST_CONFIG_HPMPLARGEFONT_INFO = ARCHAEOLOGIST_CONFIG_HPMPLARGEFONT.."\n Font Options: %s";

ARCHAEOLOGIST_CONFIG_HPMPSMALLSIZE		= "Set Pet/Party Text Size";
ARCHAEOLOGIST_CONFIG_HPMPSMALLSIZE_SLIDER_TEXT   = "Font Size";

ARCHAEOLOGIST_CONFIG_HPMPSMALLFONT		= "Set Pet/Party Text Font";
ARCHAEOLOGIST_CONFIG_HPMPSMALLFONT_INFO = ARCHAEOLOGIST_CONFIG_HPMPSMALLFONT.."\n Font Options: %s";

ARCHAEOLOGIST_COLOR_CHANGED				= "|c%s%s color changed.|r";
ARCHAEOLOGIST_COLOR_RESET				= "|c%s%s color reset.|r";

ARCHAEOLOGIST_CONFIG_COLORPHP			= "Primary Health Color (Default is white):";
ARCHAEOLOGIST_CONFIG_COLORPHP_INFO		= "Changes the color of the primary health text.";
ARCHAEOLOGIST_CONFIG_COLORPHP_RESET			= "Reset the Primary Health Color";
ARCHAEOLOGIST_CONFIG_COLORPHP_RESET_INFO	= "Resets the color of the primary health text to white.";

ARCHAEOLOGIST_CONFIG_COLORPMP			= "Primary Mana Color (Default is white):";
ARCHAEOLOGIST_CONFIG_COLORPMP_INFO		= "Changes the color of the primary mana text.";
ARCHAEOLOGIST_CONFIG_COLORPMP_RESET			= "Reset the Primary Mana Color";
ARCHAEOLOGIST_CONFIG_COLORPMP_RESET_INFO	= "Resets the color of the primary mana text to white.";

ARCHAEOLOGIST_CONFIG_COLORSHP			= "Secondary Health Color (Default is white):";
ARCHAEOLOGIST_CONFIG_COLORSHP_INFO		= "Changes the color of the secondary health text.";
ARCHAEOLOGIST_CONFIG_COLORSHP_RESET			= "Reset the Secondary Health Color";
ARCHAEOLOGIST_CONFIG_COLORSHP_RESET_INFO	= "Resets the color of the secondary health text to white.";

ARCHAEOLOGIST_CONFIG_COLORSMP			= "Secondary Mana Color (Default is white):";
ARCHAEOLOGIST_CONFIG_COLORSMP_INFO		= "Changes the color of the secondary mana text.";
ARCHAEOLOGIST_CONFIG_COLORSMP_RESET			= "Reset the Secondary Mana Color";
ARCHAEOLOGIST_CONFIG_COLORSMP_RESET_INFO	= "Resets the color of the secondary mana text to white.";


-- <= == == == == == == == == == == == == =>
-- => Party Buff Options
-- <= == == == == == == == == == == == == =>

ARCHAEOLOGIST_CONFIG_PARTYBUFFS_SEP			= "Party Buff Settings";
ARCHAEOLOGIST_CONFIG_PARTYBUFFS_SEP_INFO	= "By default 16 buffs and 16 debuffs are visible.";

ARCHAEOLOGIST_CONFIG_PBUFFS					= "Hide the party buffs ";
ARCHAEOLOGIST_CONFIG_PBUFFS_INFO			= "Removes the party's spell buffs from view unless you mouse-over their portrait.";

ARCHAEOLOGIST_CONFIG_PBUFFNUM				= "Number of party buffs ";
ARCHAEOLOGIST_CONFIG_PBUFFNUM_INFO			= "Set the number of party buffs to show.";
ARCHAEOLOGIST_CONFIG_PBUFFNUM_SLIDER_TEXT  = "Buffs Visible";

ARCHAEOLOGIST_CONFIG_PDEBUFFS				= "Hide the party debuffs ";
ARCHAEOLOGIST_CONFIG_PDEBUFFS_INFO			= "Removes the party's spell debuffs from view.";

ARCHAEOLOGIST_CONFIG_PDEBUFFNUM			= "Number of party debuffs ";
ARCHAEOLOGIST_CONFIG_PDEBUFFNUM_INFO		= "Set the number of party debuffs to show.";
ARCHAEOLOGIST_CONFIG_PDEBUFFNUM_SLIDER_TEXT = "Debuffs Visible";

-- <= == == == == == == == == == == == == =>
-- => Party Pet Buff Options
-- <= == == == == == == == == == == == == =>

ARCHAEOLOGIST_CONFIG_PARTYPETBUFFS_SEP			= "Party Pet Buff Settings";
ARCHAEOLOGIST_CONFIG_PARTYPETBUFFS_SEP_INFO	= "By default 16 buffs and 16 debuffs are visible.";

ARCHAEOLOGIST_CONFIG_PPTBUFFS					= "Hide the party pet buffs ";
ARCHAEOLOGIST_CONFIG_PPTBUFFS_INFO			= "Removes the party pet's spell buffs from view unless you mouse-over their portrait.";

ARCHAEOLOGIST_CONFIG_PPTBUFFNUM				= "Number of party pet buffs ";
ARCHAEOLOGIST_CONFIG_PPTBUFFNUM_INFO			= "Set the number of party pet buffs to show.";
ARCHAEOLOGIST_CONFIG_PPTBUFFNUM_SLIDER_TEXT  = "Buffs Visible";

ARCHAEOLOGIST_CONFIG_PPTDEBUFFS				= "Hide the party pet debuffs ";
ARCHAEOLOGIST_CONFIG_PPTDEBUFFS_INFO			= "Removes the party pet's spell debuffs from view.";

ARCHAEOLOGIST_CONFIG_PPTDEBUFFNUM			= "Number of party pet debuffs ";
ARCHAEOLOGIST_CONFIG_PPTDEBUFFNUM_INFO		= "Set the number of party pet debuffs to show.";
ARCHAEOLOGIST_CONFIG_PPTDEBUFFNUM_SLIDER_TEXT = "Debuffs Visible";

-- <= == == == == == == == == == == == == =>
-- => Pet Buff Options
-- <= == == == == == == == == == == == == =>

ARCHAEOLOGIST_CONFIG_PETBUFFS_SEP			= "Pet Buff Settings";
ARCHAEOLOGIST_CONFIG_PETBUFFS_SEP_INFO		= "By default 16 buffs and 4 debuffs are visible.";

ARCHAEOLOGIST_CONFIG_PTBUFFS				= "Hide the pet buffs ";
ARCHAEOLOGIST_CONFIG_PTBUFFS_INFO			= "Removes the pet's spell buffs from view unless you mouse-over their portrait.";

ARCHAEOLOGIST_CONFIG_PTBUFFNUM				= "Number of pet buffs ";
ARCHAEOLOGIST_CONFIG_PTBUFFNUM_INFO			= "Set the number of pet buffs to show.";
ARCHAEOLOGIST_CONFIG_PTBUFFNUM_SLIDER_TEXT  = "Buffs Visible";

ARCHAEOLOGIST_CONFIG_PTDEBUFFS				= "Hide the pet debuffs ";
ARCHAEOLOGIST_CONFIG_PTDEBUFFS_INFO			= "Removes the pet's spell debuffs from view.";

ARCHAEOLOGIST_CONFIG_PTDEBUFFNUM			= "Number of pet debuffs ";
ARCHAEOLOGIST_CONFIG_PTDEBUFFNUM_INFO		= "Set the number of pet debuffs to show.";
ARCHAEOLOGIST_CONFIG_PTDEBUFFNUM_SLIDER_TEXT = "Debuffs Visible";

-- <= == == == == == == == == == == == == =>
-- => Target Buff Options
-- <= == == == == == == == == == == == == =>

ARCHAEOLOGIST_CONFIG_TARGETBUFFS_SEP		= "Target Buff Settings";
ARCHAEOLOGIST_CONFIG_TARGETBUFFS_SEP_INFO   = "By default 8 buffs and 16 debuffs are visible.";

ARCHAEOLOGIST_CONFIG_TBUFFS					= "Hide the target buffs ";
ARCHAEOLOGIST_CONFIG_TBUFFS_INFO			= "Removes the target's spell buffs from view.";

ARCHAEOLOGIST_CONFIG_TBUFFNUM				= "Number of target buffs ";
ARCHAEOLOGIST_CONFIG_TBUFFNUM_INFO			= "Set the number of target buffs to show.";
ARCHAEOLOGIST_CONFIG_TBUFFNUM_SLIDER_TEXT   = "Buffs Visible";

ARCHAEOLOGIST_CONFIG_TDEBUFFS				= "Hide the target debuffs ";
ARCHAEOLOGIST_CONFIG_TDEBUFFS_INFO			= "Removes the target's spell debuffs from view.";

ARCHAEOLOGIST_CONFIG_TDEBUFFNUM				= "Number of target debuffs ";
ARCHAEOLOGIST_CONFIG_TDEBUFFNUM_INFO		= "Set the number of target debuffs to show.";
ARCHAEOLOGIST_CONFIG_TDEBUFFNUM_SLIDER_TEXT = "Debuffs Visible";

ARCHAEOLOGIST_FEEDBACK_STRING = "%s is currently set to %s.";
