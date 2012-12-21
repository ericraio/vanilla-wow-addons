TITAN_SKILLS_VERSION = "0.09";

TITAN_SKILLS_MENU_TEXT = "Skills";
TITAN_SKILLS_RIGHT_MENU_TEXT = "Skills (Right)";
TITAN_SKILLS_BUTTON_LABEL = "Skills";
TITAN_SKILLS_BUTTON_TEXT = "%s";
TITAN_SKILLS_TOOLTIP = "Skills Info";

TITAN_SKILLS_ABOUT_TEXT = "About";
TITAN_SKILLS_ABOUT_POPUP_TEXT = TitanUtils_GetGreenText("Titan Panel [Skills]").."\n"..TitanUtils_GetNormalText("Version: ")..TitanUtils_GetHighlightText(TITAN_SKILLS_VERSION).."\n"..TitanUtils_GetNormalText("Author: ")..TitanUtils_GetHighlightText("Corgi");

TITAN_SKILLS_SECONDARY_TEXT = "Secondary Skills";
TITAN_SKILLS_WEAPON_TEXT = "Weapon Skills";
TITAN_SKILLS_CLASS_TEXT = "Class Skills";

TITAN_SKILLS_SHOW_LEVEL_TEXT = "Show Level";

-- German localization
-- by Crowley
if ( GetLocale() == "deDE" ) then
	TITAN_SKILLS_MENU_TEXT = "Fertigkeiten";
	TITAN_SKILLS_RIGHT_MENU_TEXT = "Fertigkeiten (Recht)";
	TITAN_SKILLS_BUTTON_LABEL = "Fertigkeiten";
	TITAN_SKILLS_TOOLTIP = "Fertigkeiten-Info";

	TITAN_SKILLS_ABOUT_TEXT = "\195\156ber"
	
	TITAN_SKILLS_SECONDARY_TEXT = "Sekund\195\164re Fertigkeiten";
	TITAN_SKILLS_WEAPON_TEXT = "Waffenfertigkeiten";
	TITAN_SKILLS_CLASS_TEXT = "Klassenfertigkeiten";
	
	TITAN_SKILLS_SHOW_LEVEL_TEXT = "Show Level";
end

-- French localization
-- by SenkiT
if ( GetLocale() == "frFR" ) then
	TITAN_SKILLS_MENU_TEXT = "Comp\195\169tences";
	TITAN_SKILLS_RIGHT_MENU_TEXT = "Comp\195\169tences (Droite)";
	TITAN_SKILLS_BUTTON_LABEL = "Comp\195\169tences";
	TITAN_SKILLS_TOOLTIP = "Info Comp\195\169tences";
	TITAN_SKILLS_ABOUT_TEXT = "A Propos";
	TITAN_SKILLS_SECONDARY_TEXT = "Comp\195\169tences secondaires";
	
	TITAN_SKILLS_WEAPON_TEXT = "Comp\195\169tences d\226\128\153armes";
	TITAN_SKILLS_CLASS_TEXT = "Comp\195\169tences de classe";
	
	TITAN_SKILLS_SHOW_LEVEL_TEXT = "Show Level";
end

if ( GetLocale() == "koKR" ) then
	TITAN_SKILLS_MENU_TEXT = "Skills";
	TITAN_SKILLS_RIGHT_MENU_TEXT = "Skills (Right)";
	TITAN_SKILLS_BUTTON_LABEL = "Skills";
	TITAN_SKILLS_TOOLTIP = "Skills Info";

	TITAN_SKILLS_ABOUT_TEXT = "About";
	
	TITAN_SKILLS_SECONDARY_TEXT = "Secondary Skills";
	TITAN_SKILLS_WEAPON_TEXT = "Weapon Skills";
	TITAN_SKILLS_CLASS_TEXT = "Class Skills";
	
	TITAN_SKILLS_SHOW_LEVEL_TEXT = "Show Level";
end