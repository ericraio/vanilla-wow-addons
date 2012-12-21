-- localization strings for DeShift

humanoid_form = "Humanoid Form" --Seems to be the same for all localisations

Wantspeak = "speak"
Wantstandup = "You must be standing to do that" --stands up for you if you want to make an action you must not sit for
Wanttarget = "You have no target" -- tries to target nearest enemy
WantBearSkillOne = "Must be in Bear Form"
WantBearSkillTwo = "Not enough rage"
WantCatSkillOne = "Must be in Cat Form"
WantCatSkillTwo = "Not enough energy"
WantHumanoidSkill = "while shapeshifted"
WantHumanoidSkillTwo = "shapeshift form"

cat_form = "Cat Form"
bear_form = "Bear Form"
water_form = "Water Form"
travel_form = "Travel Form"

if(GetLocale() == "deDE") then 
	Wantspeak = "solange Eure Gestalt" --sprechen, items
	Wantstandup = "im Stehen" 
	Wanttarget = "Ihr habt kein Ziel"
	WantBearSkillOne = "Muss in Bärengestalt"
	WantBearSkillTwo = "Nicht genug Wut"
	WantCatSkillOne = "Muss in Katzengestalt"
	WantCatSkillTwo = "Nicht genug Energie"
	WantHumanoidSkill = "Eure Gestalt ist verwandelt" --zauber
	WantHumanoidSkillTwo = "Eure Gestalt ist verwandelt" -- post
	
	--Priest
	WantToLeaveShadowForm = "Das kann nicht benutzt werden in Formgestalt"
	
	cat_form = 'Katzengestalt' 
	bear_form = 'Bärengestalt' 
	water_form = 'Wassergestalt' 
	travel_form = 'Reisegestalt' 
end

if(GetLocale() == "frFR") then
	speak = "parle"
	cat_form = "Forme de f\195\169lin" 
	bear_form = "Forme d'ours"
	water_form = "Forme aquatique"
	travel_form = "Forme de voyage"
end
