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
-- German localization
-------------------------------------------------------------------------------

if ( GetLocale() == "deDE" ) then -- {{{

    --start added in Rc4
    DCR_ALLIANCE_NAME = 'Allianz';

    DCR_LOC_CLASS_DRUID   = 'Druide';
    DCR_LOC_CLASS_HUNTER  = 'J\195\164ger';
    DCR_LOC_CLASS_MAGE    = 'Magier';
    DCR_LOC_CLASS_PALADIN = 'Paladin';
    DCR_LOC_CLASS_PRIEST  = 'Priester';
    DCR_LOC_CLASS_ROGUE   = 'Schurke';
    DCR_LOC_CLASS_SHAMAN  = 'Schamane';
    DCR_LOC_CLASS_WARLOCK = 'Hexenmeister';
    DCR_LOC_CLASS_WARRIOR = 'Krieger';

    DCR_STR_OTHER	    = 'Sonstige';
    DCR_STR_ANCHOR	    = 'Anker';
    DCR_STR_OPTIONS	    = 'Einstellungen';
    DCR_STR_CLOSE	    = 'Schlie\195\159en';
    DCR_STR_DCR_PRIO    = 'Decursive Priorit\195\164tenliste';
    DCR_STR_DCR_SKIP    = 'Decursive Ignorierliste';
    DCR_STR_QUICK_POP   = 'Schnellbest\195\188cken';
    DCR_STR_POP	    = 'Best\195\188ckungsliste';
    DCR_STR_GROUP	    = 'Gruppe ';

    DCR_STR_NOMANA	    = 'Nicht genug Mana!';
    DCR_STR_UNUSABLE    = 'Reinigung momentan nicht m\195\182glich!';
    DCR_STR_NEED_CURE_ACTION_IN_BARS = 'Decursive hat keinen Reinigungszauber in einer Deiner Aktionsleisten gefunden. Decursive ben\195\182tigt diesen um das Mana zu \195\188berpr\195\188fen...';

    DCR_UP		    = 'HOCH';
    DCR_DOWN	    = 'RUNTER';

    DCR_PRIORITY_SHOW   = 'P';
    DCR_POPULATE	    = 'P';
    DCR_SKIP_SHOW	    = 'S';
    DCR_ANCHOR_SHOW	    = 'A';
    DCR_OPTION_SHOW	    = 'O';
    DCR_CLEAR_PRIO	    = 'C';
    DCR_CLEAR_SKIP	    = 'C';


    --end added in Rc4

    DCR_DISEASE = 'Krankheit';
    DCR_MAGIC   = 'Magie';
    DCR_POISON  = 'Gift';
    DCR_CURSE   = 'Fluch';
    DCR_CHARMED = 'Verf\195\188hrung';

    DCR_PET_FELHUNTER = "Teufelsj\195\164ger";
    DCR_PET_DOOMGUARD = "Verdammniswache";
    DCR_PET_FEL_CAST  = "Magie verschlingen";
    DCR_PET_DOOM_CAST = "Magiebannung";

    DCR_SPELL_CURE_DISEASE        = 'Krankheit heilen';
    DCR_SPELL_ABOLISH_DISEASE     = 'Krankheit aufheben';
    DCR_SPELL_PURIFY              = 'L\195\164utern';
    DCR_SPELL_CLEANSE             = 'Reinigung des Glaubens';
    DCR_SPELL_DISPELL_MAGIC       = 'Magiebannung';
    DCR_SPELL_CURE_POISON         = 'Vergiftung heilen';
    DCR_SPELL_ABOLISH_POISON      = 'Vergiftung aufheben';
    DCR_SPELL_REMOVE_LESSER_CURSE = 'Geringen Fluch aufheben';
    DCR_SPELL_REMOVE_CURSE        = 'Fluch aufheben';
    DCR_SPELL_PURGE               = 'Reinigen';
    DCR_SPELL_NO_RANK             = '';
    DCR_SPELL_RANK_1              = 'Rang 1';
    DCR_SPELL_RANK_2              = 'Rang 2';

    BINDING_NAME_DCRCLEAN   = "Reinige Gruppe";
    BINDING_NAME_DCRSHOW    = "Zeige/Verstecke die Liste der Betroffenen";

    BINDING_NAME_DCRPRADD     = "Ziel zur Priorit\195\164tenliste hinzuf\195\188gen";
    BINDING_NAME_DCRPRCLEAR   = "Priorit\195\164tenliste leeren";
    BINDING_NAME_DCRPRLIST    = "Priorit\195\164tenliste ausgeben";
    BINDING_NAME_DCRPRSHOW    = "Zeige/Verstecke die Priorit\195\164tenliste UI";

    BINDING_NAME_DCRSKADD   = "Ziel zur Ignorierliste hinzuf\195\188gen";
    BINDING_NAME_DCRSKCLEAR = "Ignorierliste leeren";
    BINDING_NAME_DCRSKLIST  = "Ignorierliste ausgeben";
    BINDING_NAME_DCRSKSHOW  = "Zeige/Verstecke die Ignorierliste UI";

    DCR_PRIORITY_LIST  = "Decursive Priorit\195\164tenliste";
    DCR_SKIP_LIST_STR  = "Decursive Ignorierliste";
    DCR_SKIP_OPT_STR   = "Decursive Einstellungen";
    DCR_POPULATE_LIST  = "Schnellbest\195\188cken der Decursive Liste";
    DCR_RREMOVE_ID     = "Entferne diesen Spieler";
    DCR_HIDE_MAIN      = "Live Liste verstecken";
    DCR_RESHOW_MSG     = "Um die Live Liste wieder anzuzeigen, /dcrshow eingeben";
    DCR_SHOW_MSG	   = "Um das Decursive Fenster anzuzeigen, /dcrshow eingeben";
    DCR_IS_HERE_MSG	   = "Decursive wurde geladen, kontrolliere bitte die Einstellungen";

    DCR_PRINT_CHATFRAME = "Nachrichten in Standardchat ausgeben";
    DCR_PRINT_CUSTOM    = "Nachrichten in der Bildschirmmitte ausgeben";
    DCR_PRINT_ERRORS    = "Fehlernachrichten ausgeben";
    DCR_AMOUNT_AFFLIC   = "Anzahl der Betroffenen zeigen: ";
    DCR_BLACK_LENGTH    = "Sekunden auf der Blacklist: ";
    DCR_SCAN_LENGTH     = "Sekunden zwischen den Scans: ";
    DCR_ABOLISH_CHECK   = "Zuvor \195\188berpr\195\188fen ob Reinigung n\195\182tig";
    DCR_BEST_SPELL      = "Immer h\195\182chsten Zauberrang benutzen";
    DCR_RANDOM_ORDER    = "Reinige in zuf\195\164lliger Reihenfolge";
    DCR_CURE_PETS       = "Scanne und reinige Pets";
    DCR_IGNORE_STEALTH  = "Getarnte Einheiten ignorieren";
    DCR_PLAY_SOUND	    = "Akustische Warnung falls Reinigung n\195\182tig";
    DCR_ANCHOR          = "Decursive Textfenster";
    DCR_CHECK_RANGE     = "Reichweite \195\188berpr\195\188fen";
    DCR_DONOT_BL_PRIO   = "Don't blacklist priority list names";


    -- $s is spell name
    -- $a is affliction name/type
    -- $t is target name
    DCR_DISPELL_ENEMY    = "Wirke '$s' auf den Gegner!";
    DCR_NOT_CLEANED      = "Nichts zu reinigen";
    DCR_CLEAN_STRING     = "Entferne \"$a\" von $t";
    DCR_SPELL_FOUND      = "Zauber $s gefunden!";
    DCR_NO_SPELLS        = "Keine kurierenden Zauber gefunden!";
    DCR_NO_SPELLS_RDY    = "Keine Zauber bereit!";
    DCR_OUT_OF_RANGE     = "$t ist au\195\159er Reichweite und sollte von $a geheilt werden!";
    DCR_IGNORE_STRING    = "$a auf $t gefunden... Ignoriert";

    DCR_INVISIBLE_LIST = {
	["Schleichen"]			= true,
	["Unsichtbarkeit"]			= true,
	["Schattenhaftigkeit"]		= true,
    }

    -- this causes the target to be ignored!!!!
    DCR_IGNORELIST = {
	["Verbannen"]			= true,
	["Phasenverschiebung"]		= true,
    };

    -- ignore this effect
    DCR_SKIP_LIST = {
	["Traumloser Schlaf"]		= true,
	["Gro\195\159er Traumloser Schlaf"]	= true,
	["Gedankensicht"]			= true,
    };

    -- ignore the effect bassed on the class
    DCR_SKIP_BY_CLASS_LIST = {
	[DCR_CLASS_WARRIOR] = {
	    ["Uralte Hysterie"]		= true,
	    ["Mana entz\195\188nden"]	= true,
	    ["Besudelte Gedanken"]		= true,
	};
	[DCR_CLASS_ROGUE] = {
	    ["Stille"]			= true;
	    ["Uralte Hysterie"]		= true,
	    ["Mana entz\195\188nden"]	= true,
	    ["Besudelte Gedanken"]		= true,
	};
	[DCR_CLASS_HUNTER] = {
	    ["Magmafesseln"]		= true,
	};
	[DCR_CLASS_MAGE] = {
	    ["Magmafesseln"]		= true,
	};
    };

end -- }}}
