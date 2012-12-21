------------------------------------------------------------------------------------------------------
-- Necrosis LdC
--
-- Créateur initial (US) : Infernal (http://www.revolvus.com/games/interface/necrosis/)
-- Implémentation de base (FR) : Tilienna Thorondor
-- Reprise du projet : Lomig & Nyx des Larmes de Cenarius, Kael'Thas
--
-- Skins et voix Françaises : Eliah, Ner'zhul
-- Version Allemande par Arne Meier et Halisstra, Lothar
-- Remerciements spéciaux pour Sadyre (JoL)
-- Version 28.06.2006-1
------------------------------------------------------------------------------------------------------



------------------------------------------------------------------------------------------------------
-- FONCTION D'INITIALISATION
------------------------------------------------------------------------------------------------------

function Necrosis_Initialize()

	-- Initilialisation des Textes (VO / VF / VA)
	if NecrosisConfig ~= {} then
		if (NecrosisConfig.NecrosisLanguage == "enUS") or (NecrosisConfig.NecrosisLanguage == "enGB") then
			Necrosis_Localization_Dialog_En();
		elseif (NecrosisConfig.NecrosisLanguage == "deDE") then
			Necrosis_Localization_Dialog_De();
		else
			Necrosis_Localization_Dialog_Fr();
		end
	elseif GetLocale() == "enUS" or GetLocale() == "enGB" then
		Necrosis_Localization_Dialog_En();
	elseif GetLocale() == "deDE" then
		Necrosis_Localization_Dialog_De();
	else
		Necrosis_Localization_Dialog_Fr();
	end


	-- On initialise ! Si le joueur n'est pas Démoniste, on cache Necrosis (chuuuut !)
	-- On indique aussi que Nécrosis est initialisé maintenant
	if UnitClass("player") ~= NECROSIS_UNIT_WARLOCK then
		HideUIPanel(NecrosisShardMenu);
		HideUIPanel(NecrosisSpellTimerButton);
		HideUIPanel(NecrosisButton);
		HideUIPanel(NecrosisPetMenuButton);
		HideUIPanel(NecrosisBuffMenuButton);
		HideUIPanel(NecrosisCurseMenuButton);
		HideUIPanel(NecrosisMountButton);
		HideUIPanel(NecrosisFirestoneButton);
		HideUIPanel(NecrosisSpellstoneButton);
		HideUIPanel(NecrosisHealthstoneButton);
		HideUIPanel(NecrosisSoulstoneButton);
		HideUIPanel(NecrosisAntiFearButton);
		HideUIPanel(NecrosisShadowTranceButton);
	else
		-- On charge (ou on crée) la configuration pour le joueur et on l'affiche sur la console
		if NecrosisConfig == nil or NecrosisConfig.Version ~= Default_NecrosisConfig.Version then
			NecrosisConfig = {};
			NecrosisConfig = Default_NecrosisConfig;
			Necrosis_Msg(NECROSIS_MESSAGE.Interface.DefaultConfig, "USER");
			NecrosisButton:ClearAllPoints();
			NecrosisShadowTranceButton:ClearAllPoints();
			NecrosisAntiFearButton:ClearAllPoints();
			NecrosisSpellTimerButton:ClearAllPoints();
			NecrosisButton:SetPoint("CENTER", "UIParent", "CENTER",0,-100);
			NecrosisShadowTranceButton:SetPoint("CENTER", "UIParent", "CENTER",100,-30);
			NecrosisAntiFearButton:SetPoint("CENTER", "UIParent", "CENTER",100,30);
			NecrosisSpellTimerButton:SetPoint("CENTER", "UIParent", "CENTER",120,340);

		else
			Necrosis_Msg(NECROSIS_MESSAGE.Interface.UserConfig, "USER");
		end
	
		-----------------------------------------------------------
		-- Exécution des fonctions de démarrage
		-----------------------------------------------------------

		-- Affichage d'un message sur la console
		Necrosis_Msg(NECROSIS_MESSAGE.Interface.Welcome, "USER");
		-- Création de la liste des sorts disponibles
		Necrosis_SpellSetup();
		-- Création de la liste des emplacements des fragments
		Necrosis_SoulshardSetup();
		-- Inventaire des pierres et des fragments possédés par le Démoniste
		Necrosis_BagExplore();
		-- Création des menus de buff et d'invocation
		Necrosis_CreateMenu();

		-- Lecture de la configuration dans le SavedVariables.lua, écriture dans les variables définies
		if (NecrosisConfig.SoulshardSort) then NecrosisSoulshardSort_Button:SetChecked(1); end
		if (NecrosisConfig.SoulshardDestroy) then NecrosisSoulshardDestroy_Button:SetChecked(1); end
		if (NecrosisConfig.ShadowTranceAlert) then NecrosisShadowTranceAlert_Button:SetChecked(1); end
		if (NecrosisConfig.ShowSpellTimers) then NecrosisShowSpellTimers_Button:SetChecked(1); end
		if (NecrosisConfig.AntiFearAlert) then NecrosisAntiFearAlert_Button:SetChecked(1); end
		if (NecrosisConfig.NecrosisLockServ) then NecrosisIconsLock_Button:SetChecked(1); end
		if (NecrosisConfig.StonePosition[1]) then NecrosisShowFirestone_Button:SetChecked(1); end
		if (NecrosisConfig.StonePosition[2]) then NecrosisShowSpellstone_Button:SetChecked(1); end
		if (NecrosisConfig.StonePosition[3]) then NecrosisShowHealthStone_Button:SetChecked(1); end
		if (NecrosisConfig.StonePosition[4]) then NecrosisShowSoulstone_Button:SetChecked(1); end
		if (NecrosisConfig.StonePosition[5]) then NecrosisShowBuffMenu_Button:SetChecked(1); end
		if (NecrosisConfig.StonePosition[6]) then NecrosisShowMount_Button:SetChecked(1); end
		if (NecrosisConfig.StonePosition[7]) then NecrosisShowPetMenu_Button:SetChecked(1); end
		if (NecrosisConfig.StonePosition[8]) then NecrosisShowCurseMenu_Button:SetChecked(1); end
		if (NecrosisConfig.NecrosisToolTip) then NecrosisShowTooltips_Button:SetChecked(1); end
		if (NecrosisConfig.Sound) then NecrosisSound_Button:SetChecked(1); end
		if (NecrosisConfig.ShowCount) then NecrosisShowCount_Button:SetChecked(1); end
		if (NecrosisConfig.BuffMenuPos == -34) then NecrosisBuffMenu_Button:SetChecked(1); end
		if (NecrosisConfig.PetMenuPos == -34) then NecrosisPetMenu_Button:SetChecked(1); end
		if (NecrosisConfig.CurseMenuPos == -34) then NecrosisCurseMenu_Button:SetChecked(1); end
		if (NecrosisConfig.NoDragAll) then NecrosisLock_Button:SetChecked(1); end
		if (NecrosisConfig.SpellTimerPos == -1) then NecrosisSTimer_Button:SetChecked(1); end
		if (NecrosisConfig.ChatMsg) then NecrosisShowMessage_Button:SetChecked(1); end
		if (NecrosisConfig.DemonSummon) then NecrosisShowDemonSummon_Button:SetChecked(1); end
		if (NecrosisConfig.SteedSummon) then NecrosisShowSteedSummon_Button:SetChecked(1); end
		if not (NecrosisConfig.ChatType) then NecrosisChatType_Button:SetChecked(1); end
		if (NecrosisConfig.Graphical) then NecrosisGraphicalTimer_Button:SetChecked(1); end
		if not (NecrosisConfig.Yellow) then NecrosisTimerColor_Button:SetChecked(1); end
		if (NecrosisConfig.SensListe == -1) then NecrosisTimerDirection_Button:SetChecked(1); end

		-- Paramètres des glissières		
		NecrosisButtonRotate_Slider:SetValue(NecrosisConfig.NecrosisAngle);
		NecrosisButtonRotate_SliderLow:SetText("0");
		NecrosisButtonRotate_SliderHigh:SetText("360");
		
		if NecrosisConfig.NecrosisLanguage == "deDE" then
			NecrosisLanguage_Slider:SetValue(3);
		elseif NecrosisConfig.NecrosisLanguage == "enUS" then
			NecrosisLanguage_Slider:SetValue(2);
		else
			NecrosisLanguage_Slider:SetValue(1);
		end
		NecrosisLanguage_SliderText:SetText("Langue / Language / Sprache");
		NecrosisLanguage_SliderLow:SetText("");
		NecrosisLanguage_SliderHigh:SetText("")

		NecrosisBag_Slider:SetValue(4 - NecrosisConfig.SoulshardContainer);
		NecrosisBag_SliderLow:SetText("5");
		NecrosisBag_SliderHigh:SetText("1");

		NecrosisCountType_Slider:SetValue(NecrosisConfig.CountType);
		NecrosisCountType_SliderLow:SetText("");
		NecrosisCountType_SliderHigh:SetText("");

		NecrosisCircle_Slider:SetValue(NecrosisConfig.Circle);
		NecrosisCircle_SliderLow:SetText("");
		NecrosisCircle_SliderHigh:SetText("");
		
		ShadowTranceScale_Slider:SetValue(NecrosisConfig.ShadowTranceScale);
		ShadowTranceScale_SliderLow:SetText("50%");
		ShadowTranceScale_SliderHigh:SetText("150%");

		if (NecrosisConfig.NecrosisColor == "Rose") then
			NecrosisColor_Slider:SetValue(1);
		elseif (NecrosisConfig.NecrosisColor == "Bleu") then
			NecrosisColor_Slider:SetValue(2);
		elseif (NecrosisConfig.NecrosisColor == "Orange") then
			NecrosisColor_Slider:SetValue(3);
		elseif (NecrosisConfig.NecrosisColor == "Turquoise") then
			NecrosisColor_Slider:SetValue(4);
		elseif (NecrosisConfig.NecrosisColor == "Violet") then
			NecrosisColor_Slider:SetValue(5);
		else
			NecrosisColor_Slider:SetValue(6);
		end
		NecrosisColor_SliderLow:SetText("");
		NecrosisColor_SliderHigh:SetText("");

		NecrosisButtonScale_Slider:SetValue(NecrosisConfig.NecrosisButtonScale);
		NecrosisButtonScale_SliderLow:SetText("50 %");
		NecrosisButtonScale_SliderHigh:SetText("150 %");

		NecrosisBanishScale_Slider:SetValue(NecrosisConfig.BanishScale);
		NecrosisBanishScale_SliderLow:SetText("100 %");
		NecrosisBanishScale_SliderHigh:SetText("200 %");

		-- On règle la taille de la pierre et des boutons suivant les réglages du SavedVariables
		NecrosisButton:SetScale(NecrosisConfig.NecrosisButtonScale/100);
		NecrosisShadowTranceButton:SetScale(NecrosisConfig.ShadowTranceScale/100);
		NecrosisAntiFearButton:SetScale(NecrosisConfig.ShadowTranceScale/100);
		NecrosisBuffMenu9:SetScale(NecrosisConfig.BanishScale/100);

		-- On définit l'affichage des Timers à gauche ou à droite du bouton
		NecrosisListSpells:ClearAllPoints();
		NecrosisListSpells:SetJustifyH(NecrosisConfig.SpellTimerJust);
		NecrosisListSpells:SetPoint("TOP"..NecrosisConfig.SpellTimerJust, "NecrosisSpellTimerButton", "CENTER", NecrosisConfig.SpellTimerPos * 23, 5);	
		ShowUIPanel(NecrosisButton);
		
		-- On définit également l'affichage des tooltips pour ces timers à gauche ou à droite du bouton
		if NecrosisConfig.SpellTimerJust == -23 then 
			AnchorSpellTimerTooltip = "ANCHOR_LEFT";
		else
			AnchorSpellTimerTooltip = "ANCHOR_RIGHT";
		end
		
		-- On vérifie que les fragments sont dans le sac défini par le Démoniste
		Necrosis_SoulshardSwitch("CHECK");

		-- Le Shard est-il vérouillé sur l'interface ?
		if NecrosisConfig.NoDragAll then
			Necrosis_NoDrag();
			NecrosisButton:RegisterForDrag("");
			NecrosisSpellTimerButton:RegisterForDrag("");
		else
			Necrosis_Drag();
			NecrosisButton:RegisterForDrag("LeftButton");
			NecrosisSpellTimerButton:RegisterForDrag("LeftButton");
		end
		
		-- Les boutons sont-ils vérouillés sur le Shard ?
		Necrosis_ButtonSetup();
		
		-- Si le démoniste a une arme une main d'équipée, on lui équipe le premier objet lié main gauche
		Necrosis_MoneyToggle();
		NecrosisTooltip:SetInventoryItem("player", 16);
		local itemName = tostring(NecrosisTooltipTextLeft2:GetText());
		if itemName == "Soulbound" then
			itemName = tostring(NecrosisTooltipTextLeft3:GetText());
		end
		Necrosis_MoneyToggle();
		if not GetInventoryItemLink("player", 17) and not string.find(itemName, NECROSIS_ITEM.Twohand) then
			Necrosis_SwitchOffHand(NECROSIS_ITEM.Offhand);
		end

		-- Initialisation des fichiers de langues -- Mise en place éventuelle du SMS
		Necrosis_LanguageInitialize();
		if NecrosisConfig.SM then
			NECROSIS_SOULSTONE_ALERT_MESSAGE = NECROSIS_SHORT_MESSAGES[1];
			NECROSIS_INVOCATION_MESSAGES = NECROSIS_SHORT_MESSAGES[2];
		end
	end
end

function Necrosis_LanguageInitialize()
	
	-- Localisation du speech.lua
	NecrosisLocalization();
		
	-- Localisation du XML
	NecrosisVersion:SetText(NecrosisData.Label);
	NecrosisShardsInventory_Section:SetText(NECROSIS_CONFIGURATION.ShardMenu);
	NecrosisShardsCount_Section:SetText(NECROSIS_CONFIGURATION.ShardMenu2);
	NecrosisSoulshardSort_Option:SetText(NECROSIS_CONFIGURATION.ShardMove);
	NecrosisSoulshardDestroy_Option:SetText(NECROSIS_CONFIGURATION.ShardDestroy);
	
	NecrosisMessageSpell_Section:SetText(NECROSIS_CONFIGURATION.SpellMenu1);
	NecrosisMessagePlayer_Section:SetText(NECROSIS_CONFIGURATION.SpellMenu2);
	NecrosisShadowTranceAlert_Option:SetText(NECROSIS_CONFIGURATION.TranseWarning);
	NecrosisAntiFearAlert_Option:SetText(NECROSIS_CONFIGURATION.AntiFearWarning);
		
	NecrosisShowTrance_Option:SetText(NECROSIS_CONFIGURATION.TranceButtonView);
	NecrosisIconsLock_Option:SetText(NECROSIS_CONFIGURATION.ButtonLock);
		
	NecrosisShowFirestone_Option:SetText(NECROSIS_CONFIGURATION.Show.Firestone);
	NecrosisShowSpellstone_Option:SetText(NECROSIS_CONFIGURATION.Show.Spellstone);
	NecrosisShowHealthStone_Option:SetText(NECROSIS_CONFIGURATION.Show.Healthstone);
	NecrosisShowSoulstone_Option:SetText(NECROSIS_CONFIGURATION.Show.Soulstone);
	NecrosisShowMount_Option:SetText(NECROSIS_CONFIGURATION.Show.Steed);
	NecrosisShowBuffMenu_Option:SetText(NECROSIS_CONFIGURATION.Show.Buff);
	NecrosisShowPetMenu_Option:SetText(NECROSIS_CONFIGURATION.Show.Demon);
	NecrosisShowCurseMenu_Option:SetText(NECROSIS_CONFIGURATION.Show.Curse);
	NecrosisShowTooltips_Option:SetText(NECROSIS_CONFIGURATION.Show.Tooltips);

	NecrosisShowSpellTimers_Option:SetText(NECROSIS_CONFIGURATION.SpellTime);
	NecrosisGraphicalTimer_Section:SetText(NECROSIS_CONFIGURATION.TimerMenu);
	NecrosisGraphicalTimer_Option:SetText(NECROSIS_CONFIGURATION.GraphicalTimer);
	NecrosisTimerColor_Option:SetText(NECROSIS_CONFIGURATION.TimerColor);
	NecrosisTimerDirection_Option:SetText(NECROSIS_CONFIGURATION.TimerDirection);
		
	NecrosisLock_Option:SetText(NECROSIS_CONFIGURATION.MainLock);
	NecrosisBuffMenu_Option:SetText(NECROSIS_CONFIGURATION.BuffMenu);
	NecrosisPetMenu_Option:SetText(NECROSIS_CONFIGURATION.PetMenu);
	NecrosisCurseMenu_Option:SetText(NECROSIS_CONFIGURATION.CurseMenu);
	NecrosisShowCount_Option:SetText(NECROSIS_CONFIGURATION.ShowCount);
	NecrosisSTimer_Option:SetText(NECROSIS_CONFIGURATION.STimerLeft);

	NecrosisSound_Option:SetText(NECROSIS_CONFIGURATION.Sound);
	NecrosisShowMessage_Option:SetText(NECROSIS_CONFIGURATION.ShowMessage);
	NecrosisShowSteedSummon_Option:SetText(NECROSIS_CONFIGURATION.ShowSteedSummon);
	NecrosisShowDemonSummon_Option:SetText(NECROSIS_CONFIGURATION.ShowDemonSummon);
	NecrosisChatType_Option:SetText(NECROSIS_CONFIGURATION.ChatType);
		
	NecrosisButtonRotate_SliderText:SetText(NECROSIS_CONFIGURATION.MainRotation);
	NecrosisCountType_SliderText:SetText(NECROSIS_CONFIGURATION.CountType);
	NecrosisCircle_SliderText:SetText(NECROSIS_CONFIGURATION.Circle);
	NecrosisBag_SliderText:SetText(NECROSIS_CONFIGURATION.BagSelect);
	NecrosisButtonScale_SliderText:SetText(NECROSIS_CONFIGURATION.NecrosisSize);
	NecrosisBanishScale_SliderText:SetText(NECROSIS_CONFIGURATION.BanishSize);
	ShadowTranceScale_SliderText:SetText(NECROSIS_CONFIGURATION.TranseSize);
	NecrosisColor_SliderText:SetText(NECROSIS_CONFIGURATION.Skin);
		
end



------------------------------------------------------------------------------------------------------
-- FONCTION GERANT LA COMMANDE CONSOLE /NECRO
------------------------------------------------------------------------------------------------------

function Necrosis_SlashHandler(arg1)
	-- Blah blah blah, le joueur est-il bien un Démoniste ? On finira par le savoir !
	if UnitClass("player") ~= NECROSIS_UNIT_WARLOCK then
		return;
	end
	if string.find(string.lower(arg1), "recall") then
		NecrosisButton:ClearAllPoints();
		NecrosisButton:SetPoint("CENTER", "UIParent", "CENTER",0,0);
		NecrosisSpellTimerButton:ClearAllPoints();
		NecrosisSpellTimerButton:SetPoint("CENTER", "UIParent", "CENTER",0,0);
		NecrosisAntiFearButton:ClearAllPoints();
		NecrosisAntiFearButton:SetPoint("CENTER", "UIParent", "CENTER",20,0);
		NecrosisShadowTranceButton:ClearAllPoints();
		NecrosisShadowTranceButton:SetPoint("CENTER", "UIParent", "CENTER",-20,0);
	elseif string.find(string.lower(arg1), "sm") then
		if NECROSIS_SOULSTONE_ALERT_MESSAGE == NECROSIS_SHORT_MESSAGES[1] then
			NecrosisConfig.SM = false;
			NecrosisLocalization();
			Necrosis_Msg("Short Messages : <red>Off", "USER");
		else
			NecrosisConfig.SM = true;
			NECROSIS_SOULSTONE_ALERT_MESSAGE = NECROSIS_SHORT_MESSAGES[1];
			NECROSIS_INVOCATION_MESSAGES = NECROSIS_SHORT_MESSAGES[2];
			Necrosis_Msg("Short Messages : <brightGreen>On", "USER");
		end
	elseif string.find(string.lower(arg1), "cast") then
		NecrosisSpellCast(string.lower(arg1));
	else
		if NECROSIS_MESSAGE.Help ~= nil then
			for i = 1, table.getn(NECROSIS_MESSAGE.Help), 1 do
				Necrosis_Msg(NECROSIS_MESSAGE.Help[i], "USER");
			end
		end
		Necrosis_Toggle();
	end
end
