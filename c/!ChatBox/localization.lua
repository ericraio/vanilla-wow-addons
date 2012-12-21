
-- english translation by ME!

-- DON'T forget to modify the other translations as well when you change something!!
-- CB_SAY CB_YELL

--added checks for random name coloring so that there won't be any confusion with class colors
--removed name coloring for anthing not [SillySam]: hello world (says, yells, emotes, lootmessages, etc.)
--possible fix for :742 nil error
--settings made global

CB_LOADED = "ChatBox loaded. Version: ";

--ONLY present in this file.
CB_VERSION = 1.20;

CB_HELPTITLE = "ChatBox help!";
CB_TS_HELPTITLE = "TimeStamp help!";
CB_OPTIONS = "options";
CB_HELP = "help";

CB_SHORTCUTS = "ShortCuts: sti, lfg, bot, thr, gthr, gos, use, edit, emo, left, name, rand, long, trunc, clink, norris";

--ONLY present in this file.
CB_STICKY = "sticky";
CB_SHORTLFG = "shortLFG";
CB_HIDEBOTTOMBUTTON = "hideBottomButton";
CB_THROTTLE = "throttle";
CB_GTHROTTLE = "gthrottle";
CB_HIDEGOSSIP = "hideGossip";
CB_USEARROWS = "useArrows";
CB_EDITATTOP = "editAtTop";
CB_HIDEEMOTEBUTTON = "hideEmoteButton";
CB_MENUSIDE = "buttonsOnLeft";
CB_COLORNAMES = "colorNames";
CB_COLORRANDOM = "colorRandom";
CB_LONGSTRINGS = "longStrings";
CB_TRUNCLENGTH = "truncLength";
CB_CLINK = "clink";
CB_NORRIS = "chuckNorris";
CB_VERBOSE = "verbose";


CB_ERRORMSG = "You have typed an invalid option. Type /chatbox or /cb to see the options";

--ONLY present in this file.
CB_STICKY_SHORT = "sti";
CB_SHORTLFG_SHORT = "lfg";
CB_HIDEBOTTOMBUTTON_SHORT = "bot";
CB_THROTTLE_SHORT = "thr";
CB_GTHROTTLE_SHORT = "gthr";
CB_HIDEGOSSIP_SHORT = "gos";
CB_USEARROWS_SHORT = "use";
CB_EDITATTOP_SHORT = "edit";
CB_HIDEEMOTEBUTTON_SHORT = "emo";
CB_MENUSIDE_SHORT = "left";
CB_COLORNAMES_SHORT = "name";
CB_COLORRANDOM_SHORT = "rand";
CB_LONGSTRINGS_SHORT = "long";
CB_TRUNCLENGTH_SHORT = "trunc";
CB_CLINK_SHORT = "clink";
CB_NORRIS_SHORT = "norris";


CB_STICKY_HELP_TEXT = " - change the default sticky behavior";
CB_SHORTLFG_HELP_TEXT = " - change the LookingForGroup channel tag to LFG";
CB_HIDEBOTTOMBUTTON_HELP_TEXT = " - hide/show the scroll-to-bottom button ";
CB_THROTTLE_HELP_TEXTA = " - change the number of words that must match for enchant nuker";
CB_THROTTLE_HELP_TEXTB = "to disable, ";
CB_THROTTLE_HELP_TEXTC = " are acceptable values ";
CB_GTHROTTLE_HELP_TEXTA = " - change the number of words that must match for guild nuker";
CB_GTHROTTLE_HELP_TEXTB = "to disable, ";
CB_GTHROTTLE_HELP_TEXTC = " are acceptable values ";
CB_HIDEGOSSIP_HELP_TEXT = " - show/hide the idle gossip frame when talking to NPC's. ";
CB_USEARROWS_HELP_TEXT = " - use the arrow keys to navigate chat edit box. ";
CB_EDITATTOP_HELP_TEXT = " - place the edit box at the top of the scroll frame. "
CB_HIDEEMOTEBUTTON_HELP_TEXT = " - show/hide the emote/language button";
CB_MENUSIDE_HELP_TEXT = " - Do you want the buttons on the left side? ";
CB_COLORNAMES_HELP_TEXT = " - names in chat colored?";
CB_COLORRANDOM_HELP_TEXT = " - names in chat colored randomly? (only if their class is unknown.)";
CB_LONGSTRINGS_HELP_TEXT = " - show [Party][Raid][Guild][Officer] in chat.";
CB_TRUNCLENGTH_HELP_TEXTA = " - change the length of channel names in chat";
CB_TRUNCLENGTH_HELP_TEXTB = "to disable, ";
CB_TRUNCLENGTH_HELP_TEXTC = " are acceptable values ";
CB_CLINK_HELP_TEXT = " - allow you to link items (as links) into custom chat channels.\n                (others must have this mod to see them.)\n";
CB_NORRIS_HELP_TEXT = " - allow you to nuke Chuck Norris spam.";


CB_STICKY_TEXT = "Sticky is now: ";
CB_SHORTLFG_TEXT = "Short LFG tag is now: ";
CB_HIDEBOTTOMBUTTON_TEXT = "The Scroll-to-Bottom button is now: ";
CB_THROTTLE_TEXTA = "Enchanter spam nuker throttle set to: ";
CB_THROTTLE_TEXTB = "Please select a number from: ";
CB_GTHROTTLE_TEXTA = "Guild spam nuker throttle set to: ";
CB_GTHROTTLE_TEXTB = "Please select a number from: ";
CB_HIDEGOSSIP_TEXT = "The hide Gossip functionality is now: ";
CB_USEARROWS_TEXT = "Using the arrow keys to navigate chat edit box: ";
CB_EDITATTOP_TEXTA = "The editbox is now at the ";
CB_EDITATTOP_TEXTB = " of the scroll frame.";
CB_HIDEEMOTEBUTTON_TEXT = "The emote/lang. button is now: ";
CB_MENUSIDE_TEXT = "The buttons change to the left is now: ";
CB_COLORNAMES_TEXT = "The coloring of names is chat is now: ";
CB_COLORRANDOM_TEXT = "The random coloring of names is chat is now: ";
CB_LONGSTRINGS_TEXT = "Showing the [Party][Raid][Guild][Officer] in chat are now: ";
CB_TRUNCLENGTH_TEXTA = "Trunc Length is now set to: ";
CB_TRUNCLENGTH_TEXTB = "Please select a number from: ";
CB_CLINK_TEXT = "Allowing you to link items (as links) into custom channels is now: ";
CB_NORRIS_TEXT = "The Chuck Norris spam nuker is now: ";

CB_ON = "ON";
CB_OFF = "OFF";

CB_TOP = "TOP";
CB_BOTTOM = "BOTTOM";

CB_LOOKINGFORGROUPCOMM = "LookingForGroup";
CB_SHORTLFGCOMM = "LFG";
--todo add other channels too!

CB_SAY = "say";
CB_YELL = "yell";


--Stuff for the player link menu.
CB_TARGET = "Target";
CB_REMOVEFRIEND = "Remove Friend";
CB_UNIGNORE = "Unignore";


CB_PLM_HELP_TEXT = " - on/off to turn on the tweaked right-click menu.";
CB_PLM_TEXT = "The extra options right-click menu is now: ";


CB_PLM_HELPA = "To setup, type /plm AAAA BBBB, \n          where AAAA is the key you want to assign (alt, shift, ctrl)\n";
CB_PLM_HELPB = "           and BBBB is the function. ";
CB_PLM_HELPC = "(who, target, whisper, invite, ignore)";
CB_PLM_HELPD = "This will only affect the left mouse button click.";
CB_PLM_ALT     = "alt";
CB_PLM_SHIFT   = "shift";
CB_PLM_CTRL    = "ctrl";

CB_PLM_ALT_TEXT_HELP     = "The ALT hotkey is set to: ";
CB_PLM_SHIFT_TEXT_HELP   = "The SHIFT hotkey is set to: ";
CB_PLM_CTRL_TEXT_HELP    = "The CTRL hotkey is set to: ";

CB_SPAM_WTS = "wts";
CB_SPAM_WTB = "wtb";
CB_SPAM_ENCHANTING = "enchanting";
CB_SPAM_BUY = "buy";
CB_SPAM_LOOKINGFOR = "looking for";
CB_SPAM_ENCHANTMENTS = "Enchantments";
CB_SPAM_GUILD = "Guild Info";


CB_CLASS_MAGE     =	"MAGE";
CB_CLASS_WARLOCK  =	"WARLOCK";
CB_CLASS_PRIEST   =	"PRIEST";
CB_CLASS_DRUID    =	"DRUID";
CB_CLASS_SHAMAN   =	"SHAMAN";
CB_CLASS_PALADIN  =	"PALADIN";
CB_CLASS_ROGUE    =	"ROGUE";
CB_CLASS_HUNTER   =	"HUNTER";
CB_CLASS_WARRIOR  =	"WARRIOR";


CB_TS_COLOR    = "color";
CB_TS_FORMAT   = "format";
CB_TS_FRAMES   = "frames";
CB_TS_RESET    = "reset";

CB_TS_FORMAT_TEXT  = "TimeStamp format is : "
--CB_TS_ENABLE_TEXT  = "Global TimeStamps are : "
CB_TS_RESET_TEXT   = "TimeStamps have been RESET!";

CB_TS_COLOR_HELP_TEXT  = " - Change the color of the timestamps (off to disable)";
CB_TS_FORMAT_HELP_TEXTA = " - Changes the format of the timestamp.";
CB_TS_FORMAT_HELP_TEXTB = "           (%H: 24-hour, %I: 12-hour, %M: minute, %S: second, %p: AM/PM)";
CB_TS_RESET_HELP_TEXT  = " - Resets the timestamps to their default behavior.";

CB_TS_ENABLE_HELP_TEXT = " - ON or OFF will change this behaviour."

CB_TIMESTAMP_FRAMEENABLED   =  "Timestamps have been enabled for '%s'.";
CB_TIMESTAMP_FRAMEDISABLED  =  "Timestamps have been disabled for '%s'.";
CB_TIMESTAMP_FRAME_HELP1    =  "Only type the number of the frame you want to change.";
CB_TIMESTAMP_FRAME_HELP2    =  "/ts on 3  -  This will enable timestamps for ChatFrame3";
CB_TS_FRAMESTATUS_TEXT      =  "Timestamps for %1$s are : %2$s.";
CB_TS_COLOR_TEXT            =  "Timestamp coloring is now : ";


-- System channel names.
--todo integrate this with ShortLGF?
CB_GENERAL = "General";
CB_TRADE = "Trade";
CB_LFG = "LookingForGroup";
CB_LOCALDEF = "LocalDefense";
CB_WORLDDEF = "WorldDefense";



--key binding stuff
BINDING_HEADER_CHATBOX = "ChatBox";
BINDING_NAME_CHATBOXTELLTARGET = "Tell Target";
BINDING_NAME_CHATBOXRETELL = "ReTell";


ChatBoxWords = {
      ["misc"] = {
         "ench",
         "1h",
         "2h",
      },
      ["equip"] = {
         "bracer",
         "chest",
         "boots",
         "gloves",
         "back",
         "weapon",
         "shield",
      },
      ["types"] = {
         "beast",
         "fire",
         "fiery",
         "icy",
         "ice",
         "chill",
         "demon",
         "slaying",
         "beast",
         "crusader",
         "unholy",
      },
      ["colors"] = {
         "glow",
         "blue",
         "green",
      },
      ["stats"] = {
         "agi",
         "str",
         "sta",
         "int",
         "spi",
         "spt",
         "agil",
         "stam",
         "stm",
         "intl",
         "spr",
         "stats",
      },
      ["category"] = {
         "health",
         "hp",
         "mana",
         "mp",
         "armor",
         "def",
         "res",
      },
      ["bonusdmg"] = {
         "dmg",
         "attack",
         "speed",
      },
      ["riding"] = {
         "riding";
         "skill";
         "running";
      }
   }

--Guild words!
ChatBoxGuildWords = {
      "new",
      "guild",
      "members?",
      "level",
      "raids?",
      "instances?",
      "battlegrounds?",
      "PST",
      "active",
      "tabbard",
      "apply",
      "week[ly]?",
      "quest[ing]?",
      "people",
      "adivice",
      "join",
      "end",
      "game",
      "players?",
      "welcome",
      "class[es]?",
      "professions?",
      "website",
      "runs?",
      "ventrilo",
      "vent",
      "teamspeak",
      "forums?",
      "private",
      "intereset[ed]?",
      "instances",
      "accept[ing]?",
      "gear[ing]?",
   }