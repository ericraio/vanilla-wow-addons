--[[---------------------------------------------------------------------------------
    Localisation for German
----------------------------------------------------------------------------------]]

local L = AceLibrary("AceLocale-2.0"):new("Clique")

L:RegisterTranslations("deDE", function()
    return {
        RANK 						= "Rang",
        MANA_PATTERN                = "(%d+) Mana",
        HEALTH_PATTERN              = "(%d+) .+ (%d+)",
        
        ["Lesser Heal"]             = "Geringes Heilen",
        ["Heal"]                    = "Heilen",
        ["Greater Heal"]            = "Gro\195\159e Heilung",
        ["Flash Heal"]              = "Blitzheilung",
        ["Healing Touch"]           = "Heilende Ber\195\188hrung",
        ["Regrowth"]                = "Nachwachsen",
        ["Healing Wave"]            = "Welle der Heilung",
        ["Lesser Healing Wave"]     = "Geringe Welle der Heilung",
        ["Holy Light"]              = "Heiliges Licht",
        ["Flash of Light"]          = "Lichtblitz",

        DUAL_HOLY_SHOCK		        = "Heiliger Schock",
        DUAL_MIND_VISION            = "Gedankensicht",

        CURE_CURE_DISEASE  	        = "Krankheit heilen",
        CURE_ABOLISH_DISEASE        = "Krankheit neutralisieren",
        CURE_PURIFY		    	    = "L\195\164utern",
        CURE_CLEANSE  			    = "Reinigen",
        CURE_DISPEL_MAGIC 		    = "Magiebannung",
        CURE_CURE_POISON	    	= "Vergiftung heilen",
        CURE_ABOLISH_POISON     	= "Vergiftung aufheben",
        CURE_REMOVE_LESSER_CURSE	= "Geringen Fluch entfernen",
        CURE_REMOVE_CURSE			= "Fluch aufheben",

        BUFF_PWF		    		= "Machtwort: Seelenst\195\164rke",
        BUFF_PWS	    			= "Machtwort: Schild",
        BUFF_SP   	    			= "Schattenschutz",
        BUFF_DS			    	    = "Inneres Feuer",
        BUFF_RENEW		        	= "Erneuerung",
        BUFF_MOTW		    		= "Mal der Wildnis",
        BUFF_THORNS   		    	= "Dornen",
        BUFF_REJUVENATION		    = "Verj\195\188ngung",
        BUFF_REGROWTH		    	= "Nachwachsen",
        BUFF_AI			        	= "Arkaner Intellekt",
        BUFF_DM		    	    	= "Magied\195\164mpfer",
        BUFF_AM			    	    = "Magie verst\195\164rken",
        BUFF_BOM			    	= "Segen der Macht",
        BUFF_BOP		    		= "Segen des Schutzes",
        BUFF_BOW	    			= "Segen der Weisheit",
        BUFF_BOS  			    	= "Segen des Refugiums",
        BUFF_BOL				    = "Segen des Lichts",
        BUFF_BOSFC			        = "Segen der Opferung",
    }
end)