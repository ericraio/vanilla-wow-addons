--[[---------------------------------------------------------------------------------
    Localisation for French
----------------------------------------------------------------------------------]]

local L = AceLibrary("AceLocale-2.0"):new("Clique")

L:RegisterTranslations("frFR", function()
    return {
        RANK 						= "Rang",
        MANA_PATTERN                = "Mana : (%d+)",
        HEALTH_PATTERN              = "(%d+) .+ (%d+)",
        
        ["Lesser Heal"]             = "Soins inf\195\169rieurs",
        ["Heal"]                    = "Soins",
        ["Greater Heal"]            = "Soins sup\195\169rieurs",
        ["Flash Heal"]              = "Soins rapides",
        ["Healing Touch"]           = "Toucher gu\195\169risseur",
        ["Regrowth"]                = "R\195\169tablissement",
        ["Healing Wave"]            = "Vague de soins",
        ["Lesser Healing Wave"]     = "Vague de soins inf\195\169rieurs",
        ["Holy Light"]              = "Lumi\195\168re sacr\195\169e",
        ["Flash of Light"]          = "Eclair lumineux",

        DUAL_HOLY_SHOCK		        = "Holy Shock",
        DUAL_MIND_VISION            = "Vision t\195\169l\195\169pathique",

        CURE_CURE_DISEASE  	        = "Gu\195\169rison des Maladies",
        CURE_ABOLISH_DISEASE        = "Abolir Maladie",
        CURE_PURIFY		    	    = "Purification",
        CURE_CLEANSE  	    		= "Epuration",
        CURE_DISPEL_MAGIC 	    	= "Dissiper Magie",
        CURE_CURE_POISON	    	= "Gu\195\169rison du Poison",
        CURE_ABOLISH_POISON     	= "Abolir le Poison",
        CURE_REMOVE_LESSER_CURSE	= "D\195\169livrance de la Mal\195\169diction Mineure",
        CURE_REMOVE_CURSE			= "D\195\169livrance de la Mal\195\169diction",

        BUFF_PWF  		    		= "Mot de pouvoir : Robustesse",
        BUFF_PWS	    	   		= "Mot de pouvoir : Bouclier",
        BUFF_SP		    	    	= "Protection contre l\'ombre",
        BUFF_DS			         	= "Feu Int\195\169rieur",
        BUFF_RENEW    		    	= "R\195\169novation",
        BUFF_MOTW		    	   	= "Marque du fauve",
        BUFF_THORNS		     	    = "Epines",
        BUFF_REJUVENATION	        = "R\195\169cup\195\169ration",
        BUFF_REGROWTH	    		= "R\195\169tablissement",
        BUFF_AI   			    	= "Intelligence des arcanes",
        BUFF_DM	    		    	= "Att\195\169nuer la Magie",
        BUFF_AM		    	    	= "Amplifier la Magie",
        BUFF_BOM			    	= "B\195\169n\195\169diction de puissance",
        BUFF_BOP	    			= "B\195\169n\195\169diction de protection",
        BUFF_BOW		    		= "B\195\169n\195\169diction de sagesse",
        BUFF_BOS			    	= "B\195\169n\195\169diction du Sanctuaire",
        BUFF_BOL				    = "B\195\169n\195\169diction de lumi\195\168re",
        BUFF_BOSFC			        = "B\195\169n\195\169diction de Sacrifice",
    }
end)