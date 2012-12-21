AD_VERSION_INFO = "Version %s"
AD_BYLINE = "By Pacer Dawn (pacer.dawn@earthlink.net)"
AD_LOAD_MSG = "Loaded - v%s"
AD_TAG = "AutoDecline:"
AD_DEBUG_TAG = "AD:DEBUG:"

AD_SYNTAX = "Syntax: /ad [guild {on|off}|party {on|off}|duel {on|off}|charter {on|off}|alert {on|off}|partyplayer {add||remove} {name}|partyplayer list|partyguild {on|off}|partyfriends {on|off}|partywhisper {on|off}|{partyaction|guildaction|duelaction|charteraction} {action||remove action#|list}|addlastinvite|options|status|about]"
AD_HELP = "/ad, /autod, or /autodecline to bring up options window"
AD_PARTY_INVITE = "Party invite from %s was declined."
AD_GUILD_INVITE = "Guild invite from %s to guild %s was declined."
AD_DUEL_REQUEST = "Duel request from %s was declined."
AD_PETITION_REQUEST = "Charter request from %s for %s was denied."

-- This is no longer used
-- AD_STATUS = "Status - Party: %s, Guild: %s, Duel: %s, Charter: %s, Party Friends: %s, Alert: %s"

AD_OFF = "Off"
AD_ON = "On"

AD_ALERT_ON = "Alerts are ON (show alerts)"
AD_ALERT_OFF = "Alerts are OFF (quiet mode)"
AD_DUEL_OFF = "Duel is OFF (accepting duel requests)"
AD_DUEL_ON = "Duel is ON (declining duel requests)"
AD_PARTY_OFF = "Party is OFF (accepting party requests)"
AD_PARTY_ON = "Party is ON (declining party requests)"
AD_GUILD_OFF = "Guild is OFF (accepting guild invites)"
AD_GUILD_ON = "Guild is ON (declining guild invites)"
AD_CHARTER_OFF = "Charter is OFF (accepting charters)"
AD_CHARTER_ON = "Charter is ON (declining charters)"
AD_PARTYFRIENDS_ON = "Allowing party invites from friends"
AD_PARTYFRIENDS_OFF = "Not allowing party invites from friends"
AD_PARTYWHISPER_ON = "Allowing party invites from last player to whisper"
AD_PARTYWHISPER_OFF = "Not allowing party invites from last player to whisper"

AD_ALLCHARS_OFF = "Using the current settings for all characters"
AD_ALLCHARS_ON = "No longer using the current settings for all characters"

AD_NAME_NOT_FOUND = "ERROR: Your player name was not found, addon unloading"

AD_PARTYPLAYER_ADD = "Always allowing party invites from player '%s'."
AD_PARTYPLAYER_REMOVE = "No longer always allowing party invites from player '%s'."
AD_PARTYPLAYER_LIST = "Invites are allowed from the following people:"
AD_PARTYPLAYER_CLEAR = "The list of players to allow party invites from has been cleared."

AD_PARTYGUILD_ADD = "Always allowing party invites from guild '%s'."
AD_PARTYGUILD_REMOVE = "No longer always allowing party invites from guild '%s'."
AD_PARTYGUILD_LIST = "Invites are allowed from the following guilds:"
AD_PARTYGUILD_CLEAR = "The list of guilds to allow party invites from has been cleared."

AD_CHECK_GUILD = "Guild Invites"
AD_CHECK_PARTY = "Party Invites"
AD_CHECK_DUEL = "Duel Requests"
AD_CHECK_CHARTER = "Charter Requests"

AD_TIP_CHARTER = "Check to automatically close all guild charter petitions"
AD_TIP_GUILD = "Check to automatically decline all guild invites"
AD_TIP_PARTY = "Check to automatically decline all party invites"
AD_TIP_DUEL = "Check to automatically decline all duel requests"

AD_CHECK_ALLOWPARTYFRIEND = "Allow Party Invites From Friends"
AD_CHECK_ALLOWPARTYWHISPER = "Allow Party Invites From Last Whisper"

AD_TIP_ALLOWPARTYFRIEND = "Check to always allow invites from friends on the friends list."
AD_TIP_ALLOWPARTYWHISPER = "Check to always allow invites from the last player to send you a whisper/tell."

AD_CHECK_SHOWALERTS = "Show Alerts"
AD_TIP_SHOWALERT = "Check to show an alert when something is automatically declined"

AD_DIALOG_HEADER = "AutoDecline Options"
AD_DIALOG_CHECKHEADER = "AutoDecline the following:"

AD_BUTTON_CANCEL = "Cancel"
AD_BUTTON_OKAY = "Save"

AD_CHECK_ALLCHARS = "Use these settings for all characters"
AD_TIP_ALLCHARS = "Check to use the current toggle settings for all characters on this account."

AD_DISPLAYACTION_NONE = "No actions defined for decline type %s."
AD_DISPLAYACTION_HEADER = "Current actions for decline type %s:"

AD_ADDACTION = " actions for decline type %s:"
AD_ADDACTION_REMOVE = "Removing" .. AD_ADDACTION
AD_ADDACTION_ADD = "Adding" .. AD_ADDACTION
AD_ADDACTION_CLEAR = "Clearing all" .. AD_ADDACTION

AD_ADDACTION_ERROR = "Unknown action command: %s"

AD_LASTINVITE_ADD = "Now allowing party invites from %s."
AD_LASTINVITE_NONE = "You have received no party invites this session."

AD_PARTYGUILD_ON = "Allowing party invites from guild members"
AD_PARTYGUILD_OFF = "Not allowing party invites from guild members"
AD_CHECK_ALLOWPARTYGUILD = "Allow Party Invites From Guild Members"
AD_TIP_ALLOWPARTYGUILD = "Check to always allow invites from guild members."

AD_NONE_SPECIFIED = "(none specified)"