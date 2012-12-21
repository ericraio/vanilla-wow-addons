--[[---------------------------------------------------------------------------------
    Localisation for English
----------------------------------------------------------------------------------]]

local L = AceLibrary("AceLocale-2.0"):new("Clique")

L:RegisterTranslations("enUS", function()
    return {
        RANK						= "Rank",
        MANA_PATTERN                = "(%d+) Mana",
        HEALTH_PATTERN              = "(%d+) .+ (%d+)",
        
        ["Lesser Heal"]             = "Lesser Heal",
        ["Heal"]                    = "Heal",
        ["Greater Heal"]            = "Greater Heal",
        ["Flash Heal"]              = "Flash Heal",
        ["Healing Touch"]           = "Healing Touch",
        ["Regrowth"]                = "Regrowth",
        ["Healing Wave"]            = "Healing Wave",
        ["Lesser Healing Wave"]     = "Lesser Healing Wave",
        ["Holy Light"]              = "Holy Light",
        ["Flash of Light"]          = "Flash of Light",

        DUAL_HOLY_SHOCK		        = "Holy Shock",
        DUAL_MIND_VISION            = "Mind Vision",
        
        FREE_INNER_FIRE             = "Inner Fire",

        CURE_CURE_DISEASE  	        = "Cure Disease",
        CURE_ABOLISH_DISEASE        = "Abolish Disease",
        CURE_PURIFY		    	    = "Purify",
        CURE_CLEANSE  			    = "Cleanse",
        CURE_DISPEL_MAGIC 		    = "Dispel Magic",
        CURE_CURE_POISON	    	= "Cure Poison",
        CURE_ABOLISH_POISON    	    = "Abolish Poison",
        CURE_REMOVE_LESSER_CURSE	= "Remove Lesser Curse",
        CURE_REMOVE_CURSE			= "Remove Curse",

        BUFF_PWF					= "Power Word: Fortitude",
        BUFF_PWS					= "Power Word: Shield",
        BUFF_SP					    = "Shadow Protection",
        BUFF_DS					    = "Divine Spirit",
        BUFF_RENEW				    = "Renew",
        BUFF_MOTW				    = "Mark of the Wild",
        BUFF_THORNS				    = "Thorns",
        BUFF_REJUVENATION	    	= "Rejuvenation",
        BUFF_REGROWTH			    = "Regrowth",
        BUFF_AI					    = "Arcane Intellect",
        BUFF_DM					    = "Dampen Magic",
        BUFF_AM					    = "Amplify Magic",
        BUFF_BOM					= "Blessing of Might",
        BUFF_BOP					= "Blessing of Protection",
        BUFF_BOW					= "Blessing of Wisdom",
        BUFF_BOS					= "Blessing of Sanctuary",
        BUFF_BOL					= "Blessing of Light",
        BUFF_BOSFC				    = "Blessing of Sacrifice", 

        DEFAULT_FRIENDLY            = "Default Friendly",
        DEFAULT_HOSTILE             = "Default Hostile",

        BINDING_NOT_DEFINED         = "Binding not defined",
        COULD_NOT_FIND_MODULE       = "Could not find module named \"%s\"",
        COULD_NOT_FIND_FRAME        = "Could not find frame \"%s\" when enabling module \"%s\"",
        PLUGIN_NOT_PROPER           = "The plugin for \"%s\" doesn't appear to have a framelist or an enable function.",
        NO_UNIT_FRAME               = "Could not determine which unit corresponds to frame \"%s\"",
        CUSTOM_SCRIPT               = "Custom Script",
        ERROR_SCRIPT				= "|cff00ff33Clique: There was an |cffff3333error|r |cff00ff33compiling your script:|r %s",
        ENABLED_MODULE			    = "|cff00ff33Clique: Enabled a module for|r %s" ,

        TT_DROPDOWN                 = "Selects which clickcasting \"set\" you are currently editing",
        TT_LIST_ENTRY               = "Double-click to edit, or single-click to select",
        TT_DEL_BUTTON               = "Click to delete the selected entry",
        TT_MAX_BUTTON               = "Click to change this spell to always cast the MAX RANK",
        TT_NEW_BUTTON               = "Create a new custom script",
        TT_EDIT_BUTTON              = "Edit a click-cast entry",
        TT_OK_BUTTON                = "Exit the Clique config screen",
        TT_EDIT_BINDING             = "Perform a click-cast here to change the binding",
        TT_NAME_EDITBOX             = "The name of the custom script",
        TT_SAVE_BUTTON              = "Save your changes",
        TT_CANCEL_BUTTON            = "Cancel your changes",
        TT_TEXT_EDITBOX             = "Type custom LUA code here",
        TT_PULLOUT_TAB              = "Click to open/close the Clique configuration screen" ,
    }
end)