--[[
 Decursive (v 1.9.7) add-on for World of Warcraft UI
 Copyright (C) 2005 Archarodim ( http://www.2072productions.com/?to=decursive-continued.txt )
 This is the continued work of the original Decursive (v1.9.4) by Quu
 Decursive 1.9.4 is in public domain ( www.quutar.com )
 
 License:
	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
 
	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
--]]

-------------------------------------------------------------------------------
-- the constants for the mod (non localized)
-------------------------------------------------------------------------------
DCR_VERSION_STRING = "Decursive 1.9.7";
BINDING_HEADER_DECURSIVE = "Decursive";

DCR_MACRO_COMMAND  = "/decursive";
DCR_MACRO_SHOW     = "/dcrshow";
DCR_MACRO_RESET    = "/dcrreset";

DCR_MACRO_PRADD    = "/dcrpradd";
DCR_MACRO_PRCLEAR  = "/dcrprclear";
DCR_MACRO_PRLIST   = "/dcrprlist";
DCR_MACRO_PRSHOW   = "/dcrprshow";

DCR_MACRO_SKADD    = "/dcrskadd";
DCR_MACRO_SKCLEAR  = "/dcrskclear";
DCR_MACRO_SKLIST   = "/dcrsklist";
DCR_MACRO_SKSHOW   = "/dcrskshow";


-- DO NOT TRANSLATE, THOSE ARE ALWAYS ENGLISH
DCR_CLASS_DRUID   = 'DRUID';
DCR_CLASS_HUNTER  = 'HUNTER';
DCR_CLASS_MAGE    = 'MAGE';
DCR_CLASS_PALADIN = 'PALADIN';
DCR_CLASS_PRIEST  = 'PRIEST';
DCR_CLASS_ROGUE   = 'ROGUE';
DCR_CLASS_SHAMAN  = 'SHAMAN';
DCR_CLASS_WARLOCK = 'WARLOCK';
DCR_CLASS_WARRIOR = 'WARRIOR';

-------------------------------------------------------------------------------
-- English localization (Default)
-------------------------------------------------------------------------------

--start added in Rc4
DCR_ALLIANCE_NAME = 'Alliance';

DCR_LOC_CLASS_DRUID   = 'Druid';
DCR_LOC_CLASS_HUNTER  = 'Hunter';
DCR_LOC_CLASS_MAGE    = 'Mage';
DCR_LOC_CLASS_PALADIN = 'Paladin';
DCR_LOC_CLASS_PRIEST  = 'Priest';
DCR_LOC_CLASS_ROGUE   = 'Rogue';
DCR_LOC_CLASS_SHAMAN  = 'Shaman';
DCR_LOC_CLASS_WARLOCK = 'Warlock';
DCR_LOC_CLASS_WARRIOR = 'Warrior';

DCR_STR_OTHER	    = 'Other';
DCR_STR_ANCHOR	    = 'Anchor';
DCR_STR_OPTIONS	    = 'Options';
DCR_STR_CLOSE	    = 'Close';
DCR_STR_DCR_PRIO    = 'Decursive Priority';
DCR_STR_DCR_SKIP    = 'Decursive Skip';
DCR_STR_QUICK_POP   = 'Quickly Populate';
DCR_STR_POP	    = 'Populate List';
DCR_STR_GROUP	    = 'Group ';

DCR_STR_NOMANA	    = 'Not Enough Mana!';
DCR_STR_UNUSABLE    = 'Impossible to decurse now!';
DCR_STR_NEED_CURE_ACTION_IN_BARS = 'Decursive was unable to find any curing spell in one of your action bars. Decursive needs this to check the mana...';


DCR_UP		    = 'UP';
DCR_DOWN	    = 'DOWN';

DCR_PRIORITY_SHOW   = 'P';
DCR_POPULATE	    = 'P';
DCR_SKIP_SHOW	    = 'S';
DCR_ANCHOR_SHOW	    = 'A';
DCR_OPTION_SHOW	    = 'O';
DCR_CLEAR_PRIO	    = 'C';
DCR_CLEAR_SKIP	    = 'C';


--end added in Rc4

DCR_DISEASE = 'Disease';
DCR_MAGIC   = 'Magic';
DCR_POISON  = 'Poison';
DCR_CURSE   = 'Curse';
DCR_CHARMED = 'Charm';

DCR_PET_FELHUNTER = "Felhunter";
DCR_PET_DOOMGUARD = "Doomguard";
DCR_PET_FEL_CAST  = "Devour Magic";
DCR_PET_DOOM_CAST = "Dispel Magic";

DCR_SPELL_CURE_DISEASE        = 'Cure Disease';
DCR_SPELL_ABOLISH_DISEASE     = 'Abolish Disease';
DCR_SPELL_PURIFY              = 'Purify';
DCR_SPELL_CLEANSE             = 'Cleanse';
DCR_SPELL_DISPELL_MAGIC       = 'Dispel Magic';
DCR_SPELL_CURE_POISON         = 'Cure Poison';
DCR_SPELL_ABOLISH_POISON      = 'Abolish Poison';
DCR_SPELL_REMOVE_LESSER_CURSE = 'Remove Lesser Curse';
DCR_SPELL_REMOVE_CURSE        = 'Remove Curse';
DCR_SPELL_PURGE               = 'Purge';
DCR_SPELL_NO_RANK             = '';
DCR_SPELL_RANK_1              = 'Rank 1';
DCR_SPELL_RANK_2              = 'Rank 2';

BINDING_NAME_DCRCLEAN   = "Clean Group";
BINDING_NAME_DCRSHOW    = "Show or hide the afflicted list";

BINDING_NAME_DCRPRADD     = "Add target to priority list";
BINDING_NAME_DCRPRCLEAR   = "Clear the priority list";
BINDING_NAME_DCRPRLIST    = "Print the priority list";
BINDING_NAME_DCRPRSHOW    = "Show or hide the priority list";

BINDING_NAME_DCRSKADD   = "Add target to skip list";
BINDING_NAME_DCRSKCLEAR = "Clear the skip list";
BINDING_NAME_DCRSKLIST  = "Print the skip list";
BINDING_NAME_DCRSKSHOW  = "Show or hide the skip list";

DCR_PRIORITY_LIST  = "Decursive Priority List";
DCR_SKIP_LIST_STR  = "Decursive Skip List";
DCR_SKIP_OPT_STR   = "Decursive Options Menu";
DCR_POPULATE_LIST  = "Quickly populate the Decursive list";
DCR_RREMOVE_ID     = "Remove this player";
DCR_HIDE_MAIN      = "Hide live list";
DCR_RESHOW_MSG     = "To reshow the live list, type /dcrshow";
DCR_SHOW_MSG	   = "To show Decursive's frame, type /dcrshow";
DCR_IS_HERE_MSG	   = "Decursive is now initialized, remember to check the options";

DCR_PRINT_CHATFRAME = "Print messages in default chat";
DCR_PRINT_CUSTOM    = "Print messages in the window";
DCR_PRINT_ERRORS    = "Print error messages";
DCR_AMOUNT_AFFLIC   = "The amount of afflicted to show : ";
DCR_BLACK_LENGTH    = "Seconds on the blacklist : ";
DCR_SCAN_LENGTH     = "Seconds between live scans : ";
DCR_ABOLISH_CHECK   = "Check for \"Abolish\" before curing";
DCR_BEST_SPELL      = "Always use the highest spell rank.";
DCR_RANDOM_ORDER    = "Cure in a random order";
DCR_CURE_PETS       = "Scan and cure pets";
DCR_IGNORE_STEALTH  = "Ignore Stealthed Units";
DCR_PLAY_SOUND	    = "Play a sound when there is someone to cure";
DCR_ANCHOR          = "Decursive Text Anchor";
DCR_CHECK_RANGE     = "Check for range";
DCR_DONOT_BL_PRIO   = "Don't blacklist priority list names";


-- $s is spell name
-- $a is affliction name/type
-- $t is target name
DCR_DISPELL_ENEMY    = "Casting '$s' on the enemy!";
DCR_NOT_CLEANED      = "Nothing cleaned";
DCR_CLEAN_STRING     = "Removing \"$a\" on $t";
DCR_SPELL_FOUND      = "$s spell found!";
DCR_NO_SPELLS        = "No curative spells found!";
DCR_NO_SPELLS_RDY    = "No curative spells are ready to cast!";
DCR_OUT_OF_RANGE     = "$t is out of range and should be cured of $a!";
DCR_IGNORE_STRING    = "$a found on $t... ignoring";

DCR_INVISIBLE_LIST = {
    ["Prowl"]       = true,
    ["Stealth"]     = true,
    ["Shadowmeld"]  = true,
}

-- this causes the target to be ignored!!!!
DCR_IGNORELIST = {
    ["Banish"]      = true,
    ["Phase Shift"] = true,
};

-- ignore this effect
DCR_SKIP_LIST = {
    ["Dreamless Sleep"] = true,
    ["Greater Dreamless Sleep"] = true,
    ["Mind Vision"] = true,
};

-- ignore the effect bassed on the class
DCR_SKIP_BY_CLASS_LIST = {
    [DCR_CLASS_WARRIOR] = {
	["Ancient Hysteria"]   = true,
	["Ignite Mana"]        = true,
	["Tainted Mind"]       = true,
    };
    [DCR_CLASS_ROGUE] = {
	["Silence"]            = true;
	["Ancient Hysteria"]   = true,
	["Ignite Mana"]        = true,
	["Tainted Mind"]       = true,
    };
    [DCR_CLASS_HUNTER] = {
	["Magma Shackles"]     = true,
    };
    [DCR_CLASS_MAGE] = {
	["Magma Shackles"]     = true,
    };
};

