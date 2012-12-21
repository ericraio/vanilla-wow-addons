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
-- French localization {{{
-------------------------------------------------------------------------------
if ( GetLocale() == "frFR" ) then
    --start added in Rc4
    DCR_ALLIANCE_NAME = 'Alliance';

    DCR_LOC_CLASS_DRUID   = 'Druide';
    DCR_LOC_CLASS_HUNTER  = 'Chasseur';
    DCR_LOC_CLASS_MAGE    = 'Mage';
    DCR_LOC_CLASS_PALADIN = 'Paladin';
    DCR_LOC_CLASS_PRIEST  = 'Prêtre';
    DCR_LOC_CLASS_ROGUE   = 'Voleur';
    DCR_LOC_CLASS_SHAMAN  = 'Shaman';
    DCR_LOC_CLASS_WARLOCK = 'Démoniste';
    DCR_LOC_CLASS_WARRIOR = 'Guerrier';

    DCR_STR_OTHER	    = 'Autre';
    DCR_STR_ANCHOR	    = 'Ancre';
    DCR_STR_OPTIONS	    = 'Options de Decursive';
    DCR_STR_CLOSE	    = 'Fermer';
    DCR_STR_ASSISTANT	    = 'Assistant';
    DCR_STR_DCR_PRIO	    = 'Priorités de Decursive';
    DCR_STR_DCR_SKIP	    = 'Exlusions de Decursive';
    DCR_STR_QUICK_POP	    = 'Remplir rapidememt';
    DCR_STR_POP		    = 'Remplir la liste';
    DCR_STR_GROUP	    = 'Groupe ';


    DCR_STR_NOMANA	    = 'Pas assez de mana!';
    DCR_STR_UNUSABLE	    = 'Impossible de guérir maintenant !';
    DCR_STR_NEED_CURE_ACTION_IN_BARS = "Decursive n'a put trouver aucun sort de guérison dans vos barres d'actions. Il en a besoin pour tester le mana...";

    DCR_UP		    = 'H.';
    DCR_DOWN		    = 'BAS';

    DCR_PRIORITY_SHOW	    = 'P';
    DCR_POPULATE	    = 'R';
    DCR_SKIP_SHOW	    = 'S';
    DCR_ANCHOR_SHOW	    = 'A';
    DCR_OPTION_SHOW	    = 'O';
    DCR_CLEAR_PRIO	    = 'E';
    DCR_CLEAR_SKIP	    = 'E';


    --end added in Rc4
    DCR_DISEASE = 'Maladie';
    DCR_MAGIC   = 'Magie';
    DCR_POISON  = 'Poison';
    DCR_CURSE   = 'Malédiction';
    DCR_CHARMED = 'Contrôle mentale';

    DCR_PET_FELHUNTER = "Chasseur corrompu";
    DCR_PET_DOOMGUARD = "Garde funeste";
    DCR_PET_FEL_CAST  = "Dévorer la magie";
    DCR_PET_DOOM_CAST = "Dissipation de la magie";

    DCR_SPELL_CURE_DISEASE        = 'Guérison des maladies';
    DCR_SPELL_ABOLISH_DISEASE     = 'Abolir maladie';
    DCR_SPELL_PURIFY              = 'Purification';
    DCR_SPELL_CLEANSE             = 'Epuration';
    DCR_SPELL_DISPELL_MAGIC       = 'Dissipation de la magie';
    DCR_SPELL_CURE_POISON         = 'Guérison du poison';
    DCR_SPELL_ABOLISH_POISON      = 'Abolir le poison';
    DCR_SPELL_REMOVE_LESSER_CURSE = 'Délivrance de la malédiction mineure';
    DCR_SPELL_REMOVE_CURSE        = 'Délivrance de la malédiction';
    DCR_SPELL_PURGE               = 'Expiation';
    DCR_SPELL_RANK_1              = 'Rang 1';
    DCR_SPELL_RANK_2              = 'Rang 2';

    BINDING_NAME_DCRCLEAN		= "Guérison (DoT, Poisons et Malédictions)";
    BINDING_NAME_DCRSHOW		= "Afficher\\Cacher la Liste";

    BINDING_NAME_DCRPRADD		= "Ajouter la Cible à la Liste des Priorités";
    BINDING_NAME_DCRPRCLEAR		= "Effacer la Liste des Priorités";
    BINDING_NAME_DCRPRLIST		= "Afficher la Liste des Priorités";
    BINDING_NAME_DCRPRSHOW		= "Fermer la Liste des Priorités";

    BINDING_NAME_DCRSKADD		= "Ajouter la Cible à la Liste des Exceptions";
    BINDING_NAME_DCRSKCLEAR		= "Effacer la Liste des Exceptions";
    BINDING_NAME_DCRSKLIST		= "Afficher la Liste des Exceptions";
    BINDING_NAME_DCRSKSHOW		= "Fermer la Liste des Exceptions";

    DCR_PRIORITY_LIST		= "Liste des Priorités";
    DCR_SKIP_LIST_STR		= "Liste des Exceptions";
    DCR_SKIP_OPT_STR		= "Options de Decursive";
    DCR_POPULATE_LIST		= "Liste des Groupes";
    DCR_RREMOVE_ID			= "Effacer ce Personnage";
    DCR_HIDE_MAIN			= "Fermer Decursive";
    DCR_RESHOW_MSG			= "Pour afficher la Liste de Decursive, tapez /dcrshow.";
    DCR_SHOW_MSG			= "Pour afficher la fenêtre de Decursive, tapez /dcrshow.";
    DCR_IS_HERE_MSG			= "Decursive est initialisé, rappelez-vous de vérifier les options disponibles";

    DCR_PRINT_CHATFRAME		= "Afficher dans le Canal par Défaut";
    DCR_PRINT_CUSTOM		= "Afficher dans la Fenêtre";
    DCR_PRINT_ERRORS		= "Afficher les Messages d'Erreurs";
    DCR_AMOUNT_AFFLIC		= "Nombre de Personnages à Afficher : ";
    DCR_BLACK_LENGTH		= "Délais (Secs) sur la Blacklist : ";
    DCR_SCAN_LENGTH		= "Délais (Secs) entre les Scans : ";
    DCR_ABOLISH_CHECK		= "Voir si \"Abolir\" sur la cible avant de Guérir"; -- XXX
    DCR_BEST_SPELL		= "Utiliser le Sort de Plus Haut Rang";
    DCR_RANDOM_ORDER		= "Guérir Aléatoirement";
    DCR_CURE_PETS		= "Vérifier et Guérir les Pets";
    DCR_IGNORE_STEALTH		= "Ignorer les Unités camouflées";
    DCR_PLAY_SOUND		= "Jouer un son si vous devez guérir quelqu'un";
    DCR_ANCHOR			= "Ancre du Texte";
    DCR_CHECK_RANGE		= "Tester si la cible est à portée";
    DCR_DONOT_BL_PRIO		= "Ne pas blaclister les gens prioritaires";

    -- $s is spell name
    -- $a is affliction name/type
    -- $t is target name
    DCR_DISPELL_ENEMY		= "Lance '$s' sur $t";
    DCR_NOT_CLEANED			= "Rien à nettoyer !";
    -- DCR_CLEAN_STRING		= "Lance $s sur $t (dissipation de $a)";
    DCR_CLEAN_STRING		= "Dissipation de \"$a\" sur $t";
    DCR_SPELL_FOUND			= "$t trouvé.";
    DCR_NO_SPELLS			= "Aucun sort trouvé...";
    DCR_NO_SPELLS_RDY		= "Aucun sort prêt à utiliser !";
    DCR_OUT_OF_RANGE		= "$t est hors de portée et Devrait être soigné contre $a !";
    DCR_IGNORE_STRING		= "$a trouvé sur $t - $t ignoré.";

    DCR_INVISIBLE_LIST = {
	["Rôder"]		= true,
	["Camouflage"]			= true,
	["Camouflage dans lombre"]	= true,
    }

    DCR_IGNORELIST = {
	["Bannir"]      = true,
	["Changement de phase"]	= true,
    };

    DCR_SKIP_LIST = {
	["Sommeil sans rêve"] = true,
	["Sommeil sans rêve supérieur"] = true,
	["Vision Télépathique"] = true,
    };

    DCR_SKIP_BY_CLASS_LIST = {
	[DCR_CLASS_WARRIOR] = {
	    ["Hystérie ancienne"] = true,
	    ["Enflammer le mana"] = true,
	    ["Esprit corrompu"] = true,
	};
	[DCR_CLASS_ROGUE] = {
	    ["Silence"] = true;
	    ["Hystérie ancienne"] = true,
	    ["Enflammer le mana"] = true,
	    ["Esprit corrompu"] = true,
	};
	[DCR_CLASS_HUNTER] = {
	    ["Entraves de magma"] = true,
	};
	[DCR_CLASS_MAGE] = {
	    ["Entraves de magma"] = true,
	};
    };

    -- for cut and paste ease
    -- DCR_CLASS_DRUID
    -- DCR_CLASS_HUNTER
    -- DCR_CLASS_MAGE
    -- DCR_CLASS_PALADIN
    -- DCR_CLASS_PRIEST
    -- DCR_CLASS_ROGUE
    -- DCR_CLASS_SHAMAN
    -- DCR_CLASS_WARLOCK
    -- DCR_CLASS_WARRIOR
    -- }}}
end
