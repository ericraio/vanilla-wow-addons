-- Version : French
-- Maintained by Sasmira
-- (First version by beWRage)
-- Last Update : 06/16/2005

if (GetLocale() == "frFR") then
	-- "Bonus" inventory types
	-- WARNING: these lines must match the text displayed by the client exactly.
	-- Can't use arbitrary phrases. Edit and translate with care.
	EQUIPCOMPARE_INVTYPE_WAND = "Baguette";
	EQUIPCOMPARE_INVTYPE_GUN = "Arme \195\160 feu";
	EQUIPCOMPARE_INVTYPE_GUNPROJECTILE = "Projectile";
	EQUIPCOMPARE_INVTYPE_BOWPROJECTILE = "Projectile";
	EQUIPCOMPARE_INVTYPE_CROSSBOW = "Arbal\195\168te";
	EQUIPCOMPARE_INVTYPE_THROWN = "Armes de jet";

	-- Usage text
	EQUIPCOMPARE_USAGE_TEXT = { "Utilisation d\'EquipCompare  "..EQUIPCOMPARE_VERSIONID..":",
								"Passez la souris sur les objets afin de les comparer avec ceux actuellement \195\169quip\195\169s.",
								"Lignes de commande :",
								"/eqc 	       - ON/OFF EquipCompare",
								"/eqc [on|off] - ON/OFF EquipCompare",
								"/eqc control  - ON/OFF la Touche de fonction CTRL",
							  	"/eqc cv       - ON/OFF Int\195\169gration avec CharactersViewer",
							  	"/eqc alt      - ON/OFF la Touche de fonction ALT",
								"/eqc shift    - ON/OFF D\195\169caler la Bulle d\'aide de comparaison vers le haut",
								"/eqc help     - Ce texte",
								"(Vous pouvez utiliser /equipcompare \195\160 la place de /eqc)" };

	-- Feedback text
	EQUIPCOMPARE_HELPTIP = "( Taper /equipcompare help pour obtenir l\'aide)";
	EQUIPCOMPARE_TOGGLE_ON = "EquipCompare est maintenant Activ\195\169.";
	EQUIPCOMPARE_TOGGLE_OFF = "EquipCompare est maintenant D\195\169sactiv\195\169.";
	EQUIPCOMPARE_TOGGLECONTROL_ON = "EquipCompare - Touche de fonction CTRL Activ\195\169e.";
	EQUIPCOMPARE_TOGGLECONTROL_OFF = "EquipCompare - Touche de fonction CTRL D\195\169sactiv\195\169e.";
	EQUIPCOMPARE_TOGGLECV_ON = "EquipCompare - Int\195\169gration avec CharactersViewer Activ\195\169.";
	EQUIPCOMPARE_TOGGLECV_OFF = "EquipCompare - Int\195\169gration avec CharactersViewer D\195\169sactiv\195\169.";
	EQUIPCOMPARE_TOGGLEALT_ON = "EquipCompare - Touche de fonction ALT Activ\195\169e.";
	EQUIPCOMPARE_TOGGLEALT_OFF = "EquipCompare - Touche de fonction ALT D\195\169sactiv\195\169e.";
	EQUIPCOMPARE_SHIFTUP_ON = "EquipCompare - D\195\169caler la Bulle d\'aide de comparaison vers le haut.";
	EQUIPCOMPARE_SHIFTUP_OFF = "EquipCompare - Ne d\195\169cale plus la Bulle d\'aide de comparaison vers le haut.";
	
	-- Cosmos configuration texts
	EQUIPCOMPARE_COSMOS_SECTION = "EquipCompare";
	EQUIPCOMPARE_COSMOS_SECTION_INFO = "Options des bulles d\'aide de Comparaison d\'\195\137quipement";
	
	EQUIPCOMPARE_COSMOS_HEADER = "EquipCompare "..EQUIPCOMPARE_VERSIONID;
	EQUIPCOMPARE_COSMOS_HEADER_INFO = "Options des bulles d\'aide de Comparaison d\'\195\137quipement";
	
	EQUIPCOMPARE_COSMOS_ENABLE = "Active les bulles d\'aide de Comparaison d\'\195\137quipement";
	EQUIPCOMPARE_COSMOS_ENABLE_INFO = "En activant cette option, lorsque vous passez la souris sur un objet, "..
		"une bulle d\'aide suppl\195\169mentaire affiche les statistiques de l\'objet de m\195\170me type "..
		"actuellement \195\169quip\195\169.";
		
	EQUIPCOMPARE_COSMOS_CONTROLMODE = "Activer la touche CTRL";
	EQUIPCOMPARE_COSMOS_CONTROLMODE_INFO = "En activant cette option, la bulle d\'aide suppl\195\169mentaire "..
		"ne s\'affiche que lorsque vous pressez la touche CTRL.";
		
	EQUIPCOMPARE_COSMOS_CVMODE = "Activer l\'int\195\169gration avec CharactersViewer ( si pr\195\169sent )";
	EQUIPCOMPARE_COSMOS_CVMODE_INFO = "Si activ\195\169, la comparaison sera visible dans l\'inventaire du "..
										"Personnage s\195\169lectionn\195\169 dans CharactersViewer, au lieu de "..
										"l\'inventaire du personnage.";
	EQUIPCOMPARE_COSMOS_ALTMODE = "Activer la touche ALT pour CharactersViewer";
	EQUIPCOMPARE_COSMOS_ALTMODE_INFO = "Si activ\195\169, vous obtenez une bulle d\'aide de comparaison "..
										"pour le caract\195\168re choisi dans CharactersViewer seulement si "..
										"vous maintenez la touche ALT.";
	EQUIPCOMPARE_COSMOS_SHIFTUP = "D\195\169caler la bulle d\'aide de comparaison vers le haut si n\195\169cessaire"
	EQUIPCOMPARE_COSMOS_SHIFTUP_INFO = "Si activ\195\169, la bulle d\'aide de comparaison se d\195\169calera "..
										"vers le haut si son bas venez a \195\170tre en dessous de celui "..
										"de la Bulle d\'aide principale.";
	EQUIPCOMPARE_COSMOS_SLASH_DESC = "Permet d\'activer/d\195\169sactiver EquipCompare. Tapez /equipcompare help pour plus d\'infos.";

	-- Misc labels
	EQUIPCOMPARE_EQUIPPED_LABEL = "Actuellement \195\169quip\195\169";
	EQUIPCOMPARE_GREETING = "EquipCompare "..EQUIPCOMPARE_VERSIONID.." Lanc\195\169. Amusez vous bien !.";

end
