--[[
  Healers Assist BonusScanner Localization file
]]

HA_ITEMBONUSES_SETNAME_PATTERN = "^(.*) %(%d/%d%)$";
HA_ITEMBONUSES_PREFIX_PATTERN = "^%+(%d+)%%?(.*)$";
HA_ITEMBONUSES_SUFFIX_PATTERN = "^(.*)%+(%d+)%%?$";

if ( GetLocale() == "frFR" ) then 

	-- equip and set bonus patterns:
	HA_ITEMBONUSES_EQUIP_PREFIX = "Equipé : ";
	HA_ITEMBONUSES_SET_PREFIX = "Complet : ";

	HA_ITEMBONUSES_EQUIP_PATTERNS = {
		{ pattern = "Augmente les effets des sorts de soins de (%d+) au maximum%.", effect = "HEAL" },
                { pattern = "Augmente les soins prodigués par les sorts et effets de (%d+) au maximum%.", effect = "HEAL" },
		{ pattern = "Augmente les dégâts et les soins produits par les sorts et effets magiques de (%d+) au maximum%.", effect = {"HEAL", "DMG"} },
	};

        -- White - To check
        -- +22 aux sorts de soins

	HA_ITEMBONUSES_S1 = {
	};

	HA_ITEMBONUSES_S2 = {
	};

	HA_ITEMBONUSES_TOKEN_EFFECT = {
		["Sorts de Soins"] = "HEAL",
		["sorts de soins"] = "HEAL",
		["Sorts de soins"] = "HEAL",
		["Sorts de soin"] = "HEAL",
		["Soins"] = "HEALTH",
	};

	HA_ITEMBONUSES_OTHER_PATTERNS = {
	};

elseif ( GetLocale() == "deDE" ) then

   -- equip and set bonus patterns:
   HA_ITEMBONUSES_EQUIP_PREFIX = "Anlegen: ";
   HA_ITEMBONUSES_SET_PREFIX = "Set: ";

   HA_ITEMBONUSES_EQUIP_PATTERNS = {
      { pattern = "Erh\195\182ht durch Zauber und magische Effekte zugef\195\188gten Schaden und Heilung um bis zu (%d+)%.", effect = {"HEAL", "DMG"} },
      { pattern = "Erh\195\182ht durch Zauber und Effekte verursachte Heilung um bis zu (%d+)%.", effect = "HEAL" },
      { pattern = "Erh\195\182ht die durch Zauber und Effekte verursachte Heilung um bis zu (%d+)%.", effect = "HEAL" },
   };

        -- White - To check
        -- +22 aux sorts de soins

   HA_ITEMBONUSES_S1 = {
   };

   HA_ITEMBONUSES_S2 = {
   };

   HA_ITEMBONUSES_TOKEN_EFFECT = {
      ["Heilzauber"] = "HEAL",
      ["Heilung und Zauberschaden"] = "HEAL",
   };

   HA_ITEMBONUSES_OTHER_PATTERNS = {
      { pattern = "Schwaches Zauber\195\182l", effect = "HEAL", value = 8 },
      { pattern = "Geringes Zauber\195\182l", effect = "HEAL", value = 16 },
      { pattern = "Zauber\195\182l", effect = "HEAL", value = 24 },
      { pattern = "Hervorragendes Zauber\195\182l", effect = "HEAL", value = 36 },
      { pattern = "Hervorragendes Mana\195\182l", effect = "HEAL", value = 25 }
   };

else
  -- Default English values

	-- equip and set bonus patterns:
	HA_ITEMBONUSES_EQUIP_PREFIX = "Equip: ";
	HA_ITEMBONUSES_SET_PREFIX = "Set: ";

	HA_ITEMBONUSES_EQUIP_PATTERNS = {
		{ pattern = "Increases healing done by spells and effects by up to (%d+)%.", effect = "HEAL" },
		{ pattern = "Increases damage and healing done by magical spells and effects by up to (%d+)%.", effect = {"HEAL", "DMG"} },
	};

        -- White - To check
        -- +22 aux sorts de soins

	HA_ITEMBONUSES_S1 = {
	};

	HA_ITEMBONUSES_S2 = {
	};

	HA_ITEMBONUSES_TOKEN_EFFECT = {
		["Healing Spells"] 		= "HEAL",
		["Increases Healing"] 	= "HEAL",
		["Healing and Spell Damage"] = {"HEAL", "DMG"},
		["Damage and Healing Spells"] = {"HEAL", "DMG"},
	};

	HA_ITEMBONUSES_OTHER_PATTERNS = {
		{ pattern = "Zandalar Signet of Mojo", effect = {"DMG", "HEAL"}, value = 18 },
		{ pattern = "Zandalar Signet of Serenity", effect = "HEAL", value = 33 }
	};

end
