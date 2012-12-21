-- Localization

-- English
INVTYPE_WEAPON_OTHER		= INVTYPE_WEAPON.."_other";
INVTYPE_FINGER_OTHER		= INVTYPE_FINGER.."_other";
INVTYPE_TRINKET_OTHER		= INVTYPE_TRINKET.."_other";
INVTYPE_WAND				= "Wand";
INVTYPE_GUN					= "Gun";
INVTYPE_GUNPROJECTILE		= "Bullet";
INVTYPE_BOWPROJECTILE		= "Arrow";

IRR_ARMOR					= "Armor";
IRR_WEAPON					= "Weapon";

BINDING_HEADER_LINKWRANGLER = "Link Wrangler";

-- Tootlips
IRR_TEXT_MINIMIZE			= "Minimize this window";
IRR_TEXT_CLOSE				= "Close this window and its child windows.\n(Shift-Click to close all windows)";
IRR_TEXT_COMPARE			= "Compare Equipped Items";
IRR_TEXT_WHISPER			= "Whisper to link originator";
IRR_TEXT_RELINK				= "Relink this item";
IRR_TEXT_LINK				= "Link this item";
IRR_TEXT_DR					= "View this item in the Dressing Room";


if ( GetLocale() == "deDE" ) then
	INVTYPE_WAND				= "Zauberstab";
	INVTYPE_GUN					= "Schusswaffe";
	INVTYPE_GUNPROJECTILE		= "Projektil";
	INVTYPE_BOWPROJECTILE		= "Pfeil";

	IRR_ARMOR					= "R\195\188stung";
	IRR_WEAPON					= "Waffe";

	-- Tootlips
	IRR_TEXT_MINIMIZE			= "Dies Fenster minimieren";
	IRR_TEXT_CLOSE				= "Dies Fenster und alle Unterfenster schlie\195\159en.\n(Shift-Klick um alle Fenster zu schlie\195\159en)";
	IRR_TEXT_COMPARE			= "Vergleiche angelegten Gegenstand";
	IRR_TEXT_WHISPER			= "Link-Poster anfl\195\188stern";
	IRR_TEXT_RELINK				= "Dies Item erneut verlinken";
	IRR_TEXT_LINK				= "Dies Item verlinken";
	IRR_TEXT_DR					= "Diesen Gegenstand anprobieren"

elseif (GetLocale() == "frFR") then
	INVTYPE_WAND				= "Wand";
	INVTYPE_GUN					= "Gun";
	INVTYPE_GUNPROJECTILE		= "Bullet";
	INVTYPE_BOWPROJECTILE		= "Arrow";

	IRR_ARMOR					= "Armor";
	IRR_WEAPON					= "Weapon";

	-- Tootlips
	IRR_TEXT_MINIMIZE			= "Minimize this window";
	IRR_TEXT_CLOSE				= "Close this window and its child windows.\n(Shift-Click to close all windows)";
	IRR_TEXT_COMPARE			= "Compare Equipped Items";
	IRR_TEXT_WHISPER			= "Whisper to link originator";
	IRR_TEXT_RELINK				= "Relink this item";
	IRR_TEXT_LINK				= "Link this item";
	IRR_TEXT_DR					= "View this item in the Dressing Room";
end