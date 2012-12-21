

XPERL_MSG_PREFIX	= "|c00C05050X-Perl|r "
XPERL_COMMS_PREFIX	= "X-Perl"

XPERL_TOOLTIP_ASSISTING	= "Players Assisting:"
XPERL_TOOLTIP_HEALERS	= "Healers Targetting Me:"
XPERL_TOOLTIP_ALLONME	= "All Targetting Me:"
XPERL_TOOLTIP_ENEMYONME	= "Enemy Targetting Me:"
XPERL_TOOLTIP_HELP	= "Click to open real time view"
XPERL_TOOLTIP_PET	= "%s's pet"

XPERL_LOC_DEAD		= "Dead"

BINDING_HEADER_XPERL = "X-Perl Key Bindings"
BINDING_NAME_TARGETFIRSTOTHER = "Target First Non-Tanked Target"
BINDING_NAME_SMARTASSIST = "Smart Assist"

XPERL_BUTTON_TOGGLE_STATS_DESC	= "Toggle target statistics"
XPERL_BUTTON_EXPAND_DESC	= "Expand other targets list"
XPERL_BUTTON_EXPAND_LOCK	= "Always Expand non tanked target list, otherwise only first row of targets will be displayed unless you mouse over the area."
XPERL_BUTTON_TOGGLE_LABELS	= "Toggle Target Labels"
XPERL_BUTTON_TOGGLE_TARGETS	= "Toggle Other targets showing their target"
XPERL_BUTTON_TOGGLE_MTTARGETS	= "Toggle MT targets showing their target"
XPERL_BUTTON_TOGGLE_SHOWMT	= "Toggle showing of the Main Tank"
XPERL_BUTTON_HELPER_PIN		= "Pin Window"

XPERL_STATS_NO_TARGET		= "%s with no target. Slackers!"
XPERL_STATS_NOT_ASSIST_MT1	= "%s dps not assisting %s"
XPERL_STATS_NOT_ASSIST_ANY	= "%s dps not assisting any MT"
XPERL_STATS_HEALERS_MT1		= "%s healers on %s"
XPERL_STATS_HEALERS_ANY		= "%s healers on other MTs"
XPERL_STATS_HEALERS_NON_MT	= "%s healers not on MTs"

XPERL_XS_TARGET			= "%s's target"
XPERL_NO_TARGET			= "no target"

XPERL_TITLE_MT_LONG		= "MT Targets"
XPERL_TITLE_MT_SHORT		= "MT"
XPERL_TITLE_WARRIOR_LONG	= "Warrior Targets"
XPERL_TITLE_WARRIOR_SHORT	= "Tanks"

XPERL_TITLE_OTHERS		= "Other Targets"
XPERL_TARGET_STATISTICS		= "Target Statistics"

XPERL_KEYHELP1			= "You can define a key"
XPERL_KEYHELP2			= " to target first un-tanked mob"

XPERL_FOOTER_MORE		= "%d more..."
XPERL_TO_TARGET			= "%s to target"

if ( GetLocale() == "frFR" ) then
	XPERL_LOC_DEAD = "Mort"

elseif ( GetLocale() == "koKR" ) then
	XPERL_LOC_DEAD = "죽음"
end
