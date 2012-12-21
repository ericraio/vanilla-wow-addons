--[[ 
	Author: 		Sacha Beharry
	Date Created: 	11th June 2005
	Last Update: 	13th July 2005
	
	Project 
	Version: 		See CallToArms.lua

	Project Name: 	Call To Arms

	Description:	Localized Text Resource
]]

-- Chat --

CTA_ORCISH									= "ORCISH";
CTA_COMMON									= "COMMON";
CTA_ILLEGAL_CHANNEL_WORDS 					= "Local Defense World Trade General";

-- Classes --

CTA_PRIEST									= "Priest";
CTA_MAGE		    						= "Mage";
CTA_WARLOCK	       							= "Warlock";
CTA_DRUID									= "Druid";
CTA_HUNTER									= "Hunter";
CTA_ROGUE									= "Rogue";
CTA_WARRIOR	       							= "Warrior";
CTA_PALADIN	       							= "Paladin";
CTA_SHAMAN									= "Shaman";
CTA_ANY_CLASS 								= "Any class";

-- User interface --

CTA_CALL_TO_ARMS 							= "Call To Arms";

CTA_GROUP									= "group";
CTA_PARTY									= "party";
CTA_CURRENT_SIZE 							= "Current size";
CTA_CONVERT_TO_RAID							= "Convert to raid";
CTA_PLAYER_IS_RAID_MEMBER_NOT_LEADER 		= "It appears that you are a member of a group, but not the leader. You must be the leader of a group or not in a group at all to start hosting one.";
CTA_LIST_RAIDS 								= "Find groups";
CTA_MY_RAID 								= "Host group";
CTA_SEARCH_OPTIONS 							= "Search options";
CTA_SHOW_ALL_CLASSES 						= "Show all classes";
CTA_SHOW_PVE_RAIDS 							= "Show PVE groups";
CTA_SHOW_PVP_RAIDS 							= "Show PVP groups";
CTA_SEARCH_RAID_DESCRIPTIONS 				= "Search group descriptions:";
CTA_SHOW_FULL_RAIDS 						= "Show full groups";
CTA_SHOW_EMPTY_RAIDS 						= "Show empty groups";
CTA_SHOW_PASSWORD_PROTECTED_RAIDS 			= "Show password protected groups";
CTA_SHOW_RAIDS_ABOVE_MY_LEVEL 				= "Show groups above my level";
CTA_RESULTS 								= "Results:";
CTA_UPDATE_LIST 							= "Update list";
CTA_JOIN_RAID 								= "Join group";
CTA_RAID_DESCRIPTION 						= "Group description:";
CTA_RAID_DESCRIPTION_HELP 					= "Include information such as location, purpose and other comments";
CTA_RAID_TYPE 								= "Group type:";
CTA_PLAYER_VS_PLAYER 						= "Player vs player";
CTA_PLAYER_VS_ENVIRONMENT 					= "Player vs environment";
CTA_MAXIMUM_PLAYERS 						= "Maximum players:";
CTA_MAXIMUM_PLAYERS_HELP 					= "5 - 40";
CTA_MAXIMUM_PLAYERS_HELP2 					= "For more than 5 members you must convert the party to a raid";
CTA_MINIMUM_LEVEL 							= "Minimum level:";
CTA_MINIMUM_LEVEL_HELP			 			= "1 - 60";
CTA_PASSWORD 								= "Password:";
CTA_PASSWORD_HELP 							= "No spaces in password, leave blank for none";
CTA_CLASS_DISTRIBUTION 						= "Class distribution:";
CTA_START_A_RAID 							= "Start a group";
CTA_SEND_REQUEST 							= "Send request";
CTA_CANCEL 									= "Cancel";
CTA_GO_ONLINE 								= "Go online";
CTA_GO_OFFLINE 								= "Go offline";
CTA_RAID_OFFLINE_MESSAGE 					= "THIS GROUP IS OFFLINE. Other players using Call To Arms cannot see your group.";
CTA_RAID_ONLINE_MESSAGE 					= "THIS GROUP IS ONLINE. Other players using Call To Arms can see your group.";
CTA_IS_OFFLINE 								= "Call to Arms is Offline";
CTA_IS_ONLINE 								= "Call to Arms is Online";
CTA_SEARCH_FOR_RAIDS 						= "Search for groups";
CTA_HOST_A_RAID 							= "Host a group";
CTA_HEADER_RAID_DESCRIPTION 				= "Group description";
CTA_HEADER_TYPE 							= "Type";
CTA_HEADER_SIZE 							= "Size";
CTA_HEADER_MIN_LEVEL 						= "Min level";
CTA_RESULTS_FOUND 							= "Results: Found";
CTA_RAID 									= "raid";
CTA_RAIDS 									= "raids";
CTA_MIN_LEVEL_TO_JOIN_RAID 					= "Minimum level to join group";
CTA_RAID_REQUIRES_PASSWORD 					= "A password is required to join this group."
CTA_RAID_CREATED 							= "Group created";
CTA_NO_DESCRIPTION 							= "No description given";
CTA_PVP 									= "PVP";
CTA_PVE 									= "PVE";
CTA_YES 									= "Yes";
CTA_NO 										= "No";
CTA_RAID_LEADER 							= "Group leader";
CTA_DESCRIPTION 							= "Description";
CTA_PAGE 									= "PAGE";
CTA_GROUPS									= "groups";

-- Slash commands --

CTA_COMMANDS 								= "Commands";
CTA_HELP 									= "help";
CTA_TOGGLE 									= "toggle";
CTA_DEFAULT_CHANNEL 						= "default channel";
CTA_SET_CHANNEL 							= "set channel";
CTA_CHANNEL_NAME 							= "channelName";
CTA_CLEAR_BLACKLIST 						= "clear blacklist";
CTA_DISSOLVE_RAID 							= "dissolve group";
CTA_CONVERT_RAID							= "convert raid";

CTA_TOGGLE_HELP 							= "Show/hide the CTA Window";
CTA_DEFAULT_CHANNEL_HELP 					= "Set the CTA Channel to the default channel";
CTA_SET_CHANNEL_HELP 						= "Sets the CTA Channel to "..CTA_CHANNEL_NAME.." (not recommended)";
CTA_CLEAR_BLACKLIST_HELP 					= "Clears the list of players that CTA is ignoring because of spamming"
CTA_DISSOLVE_RAID_HELP 						= "Totally dissolve the group by removing all players"
CTA_CONVERT_RAID_HELP						= "(Group leaders only) Convert a raid to a party";

-- Generated messages  --

CTA_CALL_TO_ARMS_LOADED						= "Call To Arms loaded. Use /cta for more commands."

CTA_QUERY_CHANNEL_IS 						= "Query channel is";
CTA_BLACKLIST_CLEARED 						= "Blacklist cleared";
CTA_ILLEGAL_CHANNEL_NAME 					= "Illegal Channel Name";
CTA_WAS_BLACKLISTED 						= "has been blacklisted for spamming";
CTA_GROUP_MEMBERS							= "Group members: ";
CTA_INVITATION_SENT_TO 						= "Invitation sent to";

CTA_DISSOLVING_RAID 						= "Dissolving group...";
CTA_MUST_BE_LEADER_TO_DISSOLVE_RAID 		= "Sorry, you must be the group leader to dissolve a group." ;
CTA_RAID_DISSOLVED 							= "Group dissolved";

CTA_CONVERTING_TO_PARTY						= "Converting group...";
CTA_CANNOT_CONVERT_TO_PARTY					= "Cannot convert to party unless raid has 5 members or less";
CTA_CONVERTING_TO_PARTY_DONE				= "Group converted";
CTA_MUST_BE_LEADER_TO_CONVERT_RAID 			= "Sorry, you must be the group leader to convert a group." ;

-- Automated chat messages --

CTA_WRONG_LEVEL_OR_CLASS 					= "Sorry, your Level and/or Class do not meet the requirements needed to join this group.";
CTA_DISSOLVING_THE_RAID_CHAT_MESSAGE 		= "The group is now being dissolved. Thank you for your participation.";
CTA_CONVERTING_TO_PARTY_MESSAGE				= "Converting to party, accept invitation to join.";
CTA_INVITATION_SENT_MESSAGE					= "Hello, an invitation to join my group has been sent to you.";
CTA_INCORRECT_PASSWORD_MESSAGE 				= "You have sent an incorrect password for this group.";
CTA_NO_SPACE_MESSAGE 						= "Sorry, this group already has the maximum number of players.";
CTA_PASSWORD_REQURED_TO_JOIN_MESSAGE 		= "A password is required to join this group.";

-- Tooltips --

CTA_MAXIMUM_PLAYERS_ALLOWED 				= "Maximum players allowed";
CTA_PLAYERS_IN_RAID 						= "Players currently in group";
CTA_NUMBER_OF_PLAYERS_NEEDED 				= "Number of players needed";
CTA_ANY_CLASS_TOOLTIP 						= "The maximum number of players of any class allowed to join the group.";
CTA_MINIMUM_PLAYERS_WANTED 					= "Minimum players wanted";
CTA_LFM_ANY_CLASS 							= "Need more players of any class.";
CTA_LFM_CLASSLIST 							= "Need more players of these classes: ";
CTA_CLASS_TOOLTIP							= "The minimum number of players of this class allowed to join the group. If this minimum is exceeded the extra players are counted as \'Any Class\' players.";

CTA_GenTooltips = {
	
	CTA_SearchFrameShowClassCheckButton = { 
		tooltip1 							= "Show all classes", 
		tooltip2 							= "When checked, results will include groups that are looking for more players of classes other than your own." 
	},
	
	CTA_SearchFrameShowPVPCheckButton = { 
		tooltip1 							= "Show player vs player groups", 
		tooltip2 							= "When checked, results will include groups for player versus player combat." 
	},
	
	CTA_SearchFrameShowPVECheckButton = { 
		tooltip1 							= "Show player vs environment groups", 
		tooltip2 							= "When checked, results will include player versus environment and quest related groups." 
	},
	
	CTA_SearchFrameShowFullCheckButton = { 
		tooltip1 							= "Show full groups", 
		tooltip2 							= "When checked, results will include groups which are full and do not need any more players." 
	},
	
	CTA_SearchFrameShowEmptyCheckButton = { 
		tooltip1 							= "Show empty groups", 
		tooltip2 							= "When checked, results will include groups which are \'empty\' and do not have more than one player." 
	},
	
	CTA_SearchFrameShowPasswordCheckButton = { 
		tooltip1 							= "Show groups which require a password", 
		tooltip2 							= "When checked, results will include groups which require a password to join." 
	},
	
	CTA_SearchFrameShowLevelCheckButton = { 
		tooltip1 							= "Show groups above my level", 
		tooltip2 							= "When checked, results will include groups which require players to have a level higher that your own." 
	},
	
	CTA_SearchFrameDescriptionEditBox = { 
		tooltip1 							= "Search descriptions", 
		tooltip2 							= "Many groups have a short description created by the group leader. If keywords are entered in this box, only groups with matches in the description will be included in the results." 
	},
	
};


-- New for R3 features

CTA_CURRENT									= "Current";
CTA_PENDING									= "Pending";
CTA_SIZE									= "Size";

CTA_LOG										= "Log";
CTA_HELP_TAB								= "Help";

CTA_SETTINGS								= "Settings";
CTA_MINIMAP_ICON_SETTINGS					= "Minimap icon settings";
CTA_COMM_SETTINGS							= "Communication settings";
CTA_LOG_AND_MONITOR							= "System log and chat monitor (Beta)"

CTA_START_PARTY								= "Start a party";
CTA_START_RAID								= "Start a raid";
CTA_PLAYER_CAN_START_A_GROUP				= "Start hosting a new group";
CTA_CONVERT_TO_PARTY						= "Convert to party";
CTA_STOP_HOSTING							= "Stop hosting";
CTA_SEARCH_MATCH							= "Search score";
CTA_NO_MORE_PLAYERS_NEEDED					= "No more players needed";

CTA_PLAYER_LIST								= "Blacklist";
CTA_EDIT_PLAYER								= "Edit player information";
CTA_DELETE									= "Delete";
CTA_SAVE									= "Save";
CTA_ADD_PLAYER								= "Add player";

CTA_PLAYER_NOTE								= "Note";
CTA_PLAYER_STATUS							= "Status";
CTA_DEFAULT_PLAYER_NOTE						= "New player added. Click here to edit this note."
CTA_DEFAULT_STATUS							= ""
CTA_DEFAULT_IMPORTED_IGNORED_PLAYER_NOTE	= "Imported from ignored players. Click here to edit this note.";
CTA_DEFAULT_RATING							= "";
CTA_BLACKLISTED_NOTE						= "Temporarily blacklisted by CTA. Edit note to make permanent.";
CTA_OK										= "Ok";
CTA_ADD_PLAYER								= "Add player";
CTA_ENTER_PLAYER_NAME						= "Enter the name of the player to be blacklisted:";

CTA_ICON									= "Minimap icon";
CTA_ICON_TEXT								= "Icon text";
CTA_ADJUST_ANGLE							= "Adjust angle";
CTA_ADJUST_RADIUS							= "Adjust radius";



-- New for R5

CTA_MAXIMUM_PLAYERS_ALLOWED 				= "Group space allowed";
CTA_PLAYERS_IN_RAID 						= "Players currently in group";
CTA_NUMBER_OF_PLAYERS_NEEDED 				= "Number of players needed";
CTA_ANY_CLASS_TOOLTIP 						= "The number of unreserved spaces in the group. Players of any class are allowed to fill these spaces.";
CTA_MINIMUM_PLAYERS_WANTED 					= "Group space reserved";
CTA_LFM_ANY_CLASS 							= "Need more players of any class.";
CTA_LFM_CLASSLIST 							= "Need more players of these classes: ";
CTA_CLASS_TOOLTIP							= "The number of spaces reserved for players of this class set in group. If this space is exceeded the extra players are counted as \'Any Class\' players.";
CTA_ANNOUNCE_GROUP							= "announce";
CTA_ANNOUNCE_GROUP_HELP						= "Sends a public LFG/M message. Use: \'cta announce <channel number>\'";
CTA_WAIT_TO_ANNOUNCE						= "Please wait a moment before announcing your group."
CTA_TOGGLE_CHAT_MONITORING					= "Monitor chat messages";
CTA_LOG_AND_MONITOR							= "Log Entries";
CTA_LAST_UPDATE								= "Last update";

CTA_LFM										= "LFM";
CTA_LFG										= "LFG";

-- R6

CTA_EDIT_ACID_CLASSES						= "Edit the classes for this rule:";
CTA_NAME									= "Name";

-- P7B1
CTA_NON_CTA_GROUP_MESSAGE					= "Non-CTA Group";
CTA_NON_CTA_PLAYER_MESSAGE					= "Non-CTA Player";
CTA_NEW_LFX									= "New LFx found";
CTA_PRE_R7_USER								= "Version R6 or older";
CTA_VERSION									= "Version";
CTA_CURRENT_GROUP_CLASSES					= "Classes in group";
CTA_TOGGLE_MINIMAP							= "minimap";
CTA_LFG_FRAME								= "Looking for Group";
CTA_ANNOUNCE_LFG							= "Broadcast this LFG message over the CTAChannel.";
CTA_ANNOUNCE_INFO_TEXT						= "This LFG message will be sent over the CTAChannel only if you are not already advertising a group with Call To Arms.\n\nUse \'/cta announce <channel>\' to automatically send your LFG/M message to a local channel every 100 seconds and \'/cta announce off\' to stop.";
CTA_AUTO_ANNOUNCE_OFF						= "announce off";

--P7B3
CTA_FIND_PLAYERS_AND_GROUPS					= "Find players and groups";
CTA_LFG_FRAME								= "Flag myself as LFG";
CTA_CANNOT_LFG								= "You cannot flag yourself as looking for a group if you are already in a group."
CTA_MANAGE_GROUP							= "Manage my group";
CTA_SEARCH									= "Search";
CTA_CLOSE									= "Close";
CTA_LFG										= "LFG"; -- LFG = 'Looking For Group'

CTA_LFG_TRIGGER								= "Trigger word(s) for \'Looking For Group\' messages";
CTA_LFM_TRIGGER								= "Trigger word(s) for \'Looking For More\' messages";
CTA_FILTER_GROUP_RESULTS					= "Group Filters";
CTA_FILTER_PLAYER_RESULTS					= "Player Filters";

CTA_SEARCH_RESULTS							= "Search Results";
CTA_SEARCH_OPTIONS							= "Search Options";

CTA_SHOW_PLAYERS_AND_GROUPS					= "Show players and groups";
CTA_SHOW_PLAYERS_ONLY						= "Show players only";
CTA_SHOW_GROUPS_ONLY						= "Show groups only";
CTA_CTA_PLAYER								= "CTA Player";
CTA_CTA_GROUP								= "CTA Group";
CTA_FORWARD_LFX								= "Monitor local channels and forward all local LFG/M messages to the CTAChannel";

CTA_MORE_FEATURES							= "More";


CTA_ANNOUNCE_SUMMARY_PROMPT					= " > For more info, type \'/w "..(UnitName( "player" )).." details\'";
CTA_ANNOUNCE_DETAILS_PROMPT					= " > To join, type \'/w "..(UnitName( "player" )).." inviteme\'";
CTA_ANNOUNCE_JOIN_PROMPT					= " > For more info, type \'/w "..(UnitName( "player" )).." cta?\'";
CTA_PROMO									= "Welcome to the group! This group is managed with the CallToArms add-on";
CTA_ABOUT_CTA_MESSAGE						= "The \'CallToArms\' LFG mod makes it very easy to form groups in WoW and is available at www.curse-gaming.com, ui.worldofwar.net, www.wowguru.com and www.wowinterface.com"


-- R7 BETA 4

BINDING_HEADER_CALL_TO_ARMS				 	= "Call To Arms";
BINDING_NAME_CTA_SHOW_FRAME					= "Show main window";

CTA_CHANNEL_MONITORING						= "Channel Monitoring and Forwarding";
CTA_CHANNEL_MONITORING_NOTE					= "Trigger words must be at least 3 characters in length and are used by CTA to identify LFG and LFM messages in local chat. Choose trigger words carefully, as local LFx messages that are picked up by CTA using these trigger words will be broadcasted to other CTA users. Change the default words ONLY if your realm uses different acronyms when looking for a group or more players.";

CTA_SHOW_NON_CTA_RESULTS					= "Show local LFx messages (Non-CTA results)";
CTA_SHOW_LFX_OPTIONS						= "Local LFx Options";
CTA_ADJUST_TRANSPARENCY						= "Adjust window transparency";

CTA_CTA_GROUP_FILTERS						= "CallToArms Group Filters";
CTA_OTHER_FILTERS							= "Other Filters";
CTA_PLAYER_FILTERS							= "Player Filters";
CTA_UPDATE_LFX								= "Apply";	
CTA_ERROR_REPORT							= "- Error Report -\nCopy the text below and include it when reporting this error.";