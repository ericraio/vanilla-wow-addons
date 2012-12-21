NL_NEED_FRAME_LEFT_INDENT = 20
NL_NEED_FRAME_TOP_INDENT = 30
NL_NEED_FRAME_SPACING = 25

NLNeedFrameName = "NLConfigNeedsFrame";
NLMainFrameName = "NLConfigFrame";



--------------------------------------------------------
-- NL_GetConfigForCurrentPlayer
--------
-- Get the configuration for this player.
--------------------------------------------------------
function NL_GetConfigForCurrentPlayer( doDefaults )
	if( NL_CONFIGS == nil ) then
		NL_CONFIGS = {};
	end

	local sName = UnitName("player") .. " " .. GetCVar("realmName");

	if( doDefaults or NL_CONFIGS[sName] == nil or NL_CONFIGS[sName].Version == nil or NL_CONFIGS[sName].Version < 2 ) then
		NL_CONFIGS[sName] = {};
		if( NL_CONFIGS[sName].Version and NL_CONFIGS[sName].Version < 2 ) then
			NL_Msg("IMPORTANT NOTE: Version 2.00 of Needy List has reset your Needy List configuration.");
		end
		NL_CONFIGS[sName].Needs = {};

		local NeedsList = NL_CONFIGS[sName].Needs;
		local numNeeds = 0;

		-- top priority need is always STICKIED
		NeedsList[numNeeds] = {Name="NeverShow",Toggle=0,BGColor={r = 0.0, g = 0.0, b = 1.0, opacity = 0.5},Filter={Type="Units",Names=""}};
		numNeeds = numNeeds + 1;

		NeedsList[numNeeds] = {Name="Sticky",Toggle=0,BGColor={r = 0.0, g = 0.0, b = 1.0, opacity = 0.5},Filter={Type="Units",Names=""}};
		numNeeds = numNeeds + 1;

		NeedsList[numNeeds] = {Name="Health",Toggle=1,BGColor={r = 1.0, g = 0.0, b = 0.0, opacity = 0.8},Threshold=75,Filter={Type="Everyone"}};
		NL_CONFIGS[sName].HealthNeedIndex = numNeeds;
		numNeeds = numNeeds + 1;

		if( NL_PLAYERCLASS == NL_PRIEST_NAME or NL_PLAYERCLASS == NL_PALADIN_NAME ) then
			NeedsList[numNeeds] = {Name="Magic",Type="DEBUFF",Toggle=1,BGColor={r = 1.0, g = 0.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;
		end

		if( NL_PLAYERCLASS == NL_SHAMAN_NAME or NL_PLAYERCLASS == NL_DRUID_NAME or NL_PLAYERCLASS == NL_PALADIN_NAME ) then
			NeedsList[numNeeds] = {Name="Poison",Type="DEBUFF",Toggle=1,BGColor={r = 1.0, g = 1.0, b = 0.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;
		end

		if( NL_PLAYERCLASS == NL_SHAMAN_NAME or NL_PLAYERCLASS == NL_PRIEST_NAME or NL_PLAYERCLASS == NL_PALADIN_NAME ) then
			NeedsList[numNeeds] = {Name="Disease",Type="DEBUFF",Toggle=1,BGColor={r = 0.0, g = 1.0, b = 0.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;
		end

		if( NL_PLAYERCLASS == NL_MAGE_NAME or NL_PLAYERCLASS == NL_DRUID_NAME ) then
			NeedsList[numNeeds] = {Name="Curse",Type="DEBUFF",Toggle=1,BGColor={r = 0.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;
		end

		-- for priests specifically
		if( NL_PLAYERCLASS == NL_PRIEST_NAME ) then

			NeedsList[numNeeds] = {Name="Fortitude",Type="BUFF",Toggle=1,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="ShadowProt",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 1.0, b = 0.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="PWShield",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 0.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="DivineSpirit",Type="BUFF",Toggle=0,BGColor={r = 0.5, g = 0.5, b = 1.0, opacity = 0.8}};
			NeedsList[numNeeds].Filter = NLGetSpecialFilter(true, false);
			numNeeds = numNeeds + 1;

			if( UnitRace("player") == NL_DWARF_NAME ) then
				NeedsList[numNeeds] = {Name="FearWard",Type="BUFF",Toggle=0,BGColor={r = 0.5, g = 1.0, b = 0.5, opacity = 0.8},Filter={Type="Everyone"}};
				numNeeds = numNeeds + 1;
			elseif( UnitRace("player") == NL_UNDEAD_NAME ) then
				NeedsList[numNeeds] = {Name="TouchOfWeakness",Type="BUFF",Toggle=0,BGColor={r = 0.0, g = 1.0, b = 0.5, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
				numNeeds = numNeeds + 1;
			elseif( UnitRace("player") == NL_HUMAN_NAME ) then
				NeedsList[numNeeds] = {Name="Feedback",Type="BUFF",Toggle=0,BGColor={r = 0.8, g = 0.0, b = 1.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
				numNeeds = numNeeds + 1;
			elseif( UnitRace("player") == NL_TROLL_NAME ) then
				NeedsList[numNeeds] = {Name="Shadowguard",Type="BUFF",Toggle=0,BGColor={r = 0.8, g = 0.0, b = 1.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
				numNeeds = numNeeds + 1;
			end

			NeedsList[numNeeds] = {Name="InnerFire",Type="BUFF",Toggle=1,BGColor={r = 1.0, g = 0.5, b = 0.5, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			numNeeds = numNeeds + 1;
		end

		-- for druids specifically
		if( NL_PLAYERCLASS == NL_DRUID_NAME ) then
			NeedsList[numNeeds] = {Name="Mark",Type="BUFF",Toggle=1,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="Thorns",Type="BUFF",Toggle=0,BGColor={r = 0.0, g = 1.0, b = 0.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="Clarity",Type="BUFF",Toggle=0,BGColor={r = 0.4, g = 0.4, b = 1.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="Mana",Toggle=0,BGColor={r = 0.5, g = 0.5, b = 1.0, opacity = 0.8},Threshold=25};
			NeedsList[numNeeds].Filter = NLGetSpecialFilter(true, false);
			NL_CONFIGS[sName].ManaNeedIndex = numNeeds;
			numNeeds = numNeeds + 1;
		end

		-- for paladins specifically
		if( NL_PLAYERCLASS == NL_PALADIN_NAME ) then
			NeedsList[numNeeds] = {Name="BlessMight",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="BlessWisdom",Type="BUFF",Toggle=0,BGColor={r = 0.5, g = 0.5, b = 1.0, opacity = 0.8}};
			NeedsList[numNeeds].Filter = NLGetSpecialFilter(true, false);
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="BlessKings",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="BlessSalvation",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="BlessLight",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="BlessSanctuary",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;
		end

		-- for mages specifically
		if( NL_PLAYERCLASS == NL_MAGE_NAME ) then
			NeedsList[numNeeds] = {Name="Intellect",Type="BUFF",Toggle=1,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8}};
			NeedsList[numNeeds].Filter = NLGetSpecialFilter(true, false);
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="MageArmor",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="FrostArmor",Type="BUFF",Toggle=0,BGColor={r = 0.5, g = 0.5, b = 1.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="IceArmor",Type="BUFF",Toggle=1,BGColor={r = 0.5, g = 0.5, b = 1.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="DampenMagic",Type="BUFF",Toggle=0,BGColor={r = 0.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="AmplifyMagic",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 0.5, b = 0.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="ManaShield",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			numNeeds = numNeeds + 1;
		end

		-- for warlocks specifically
		if( NL_PLAYERCLASS == NL_WARLOCK_NAME ) then
			NeedsList[numNeeds] = {Name="Soulstone",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="DemonArmor",Type="BUFF",Toggle=1,BGColor={r = 1.0, g = 0.0, b = 0.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="DemonSkin",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 0.0, b = 0.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="UnendingBreath",Type="BUFF",Toggle=0,BGColor={r = 0.5, g = 0.5, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="DetectLesserInvis",Type="BUFF",Toggle=0,BGColor={r = 0.5, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="DetectInvis",Type="BUFF",Toggle=0,BGColor={r = 0.5, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="DetectGreaterInvis",Type="BUFF",Toggle=0,BGColor={r = 0.5, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Everyone"}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="FireShield",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 0.5, b = 0.5, opacity = 0.8}};
			NeedsList[numNeeds].Filter = NLGetSpecialFilter(false, true);
			NeedsList[numNeeds].Filter.Demon = false;
			numNeeds = numNeeds + 1;
		end

		-- for rogues specifically
		if( NL_PLAYERCLASS == NL_ROGUE_NAME ) then
			NeedsList[numNeeds] = {Name="DetectTraps",Type="BUFF",Toggle=1,BGColor={r = 1.0, g = 1.0, b = 1.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="MainhandPoison",Type="ENCHANT",Toggle=0,BGColor={r = 0.0, g = 1.0, b = 0.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="OffhandPoison",Type="ENCHANT",Toggle=0,BGColor={r = 0.0, g = 1.0, b = 0.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			numNeeds = numNeeds + 1;
		end

		-- for shaman specifically
		if( NL_PLAYERCLASS == NL_SHAMAN_NAME ) then
			NeedsList[numNeeds] = {Name="LightningShield",Type="BUFF",Toggle=0,BGColor={r = 0.5, g = 0.5, b = 1.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="Rockbiter",Type="ENCHANT",Toggle=0,BGColor={r = 0.5, g = 0.5, b = 0.5, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			numNeeds = numNeeds + 1;
			
			NeedsList[numNeeds] = {Name="Flametongue",Type="ENCHANT",Toggle=0,BGColor={r = 1.0, g = 0.5, b = 0.5, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			numNeeds = numNeeds + 1;
			
			NeedsList[numNeeds] = {Name="Frostbrand",Type="ENCHANT",Toggle=0,BGColor={r = 0.5, g = 0.5, b = 1.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			numNeeds = numNeeds + 1;

			NeedsList[numNeeds] = {Name="Windfury",Type="ENCHANT",Toggle=0,BGColor={r = 0.75, g = 0.75, b = 0.75, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			numNeeds = numNeeds + 1;
		end

		if( NL_PLAYERCLASS == NL_PRIEST_NAME or NL_PLAYERCLASS == NL_DRUID_NAME or NL_PLAYERCLASS == NL_PALADIN_NAME or NL_PLAYERCLASS == NL_SHAMAN_NAME ) then
			NeedsList[numNeeds] = {Name="Resurrection",Toggle=1,BGColor={r = 0.5, g = 0.5, b = 0.5, opacity = 0.8},Filter={Type="Everyone"}};
			NL_CONFIGS[sName].ResurrectionNeedIndex = numNeeds;
			numNeeds = numNeeds + 1;
		end

		if( NL_PLAYERCLASS == NL_WARRIOR_NAME ) then
			NeedsList[numNeeds] = {Name="BattleShout",Type="BUFF",Toggle=0,BGColor={r = 1.0, g = 0.5, b = 0.5, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
			numNeeds = numNeeds + 1;
		end

		NeedsList[numNeeds] = {Name="WellFed",Toggle=0,BGColor={r = 1.0, g = 1.0, b = 0.0, opacity = 0.8},Filter={Type="Units",Names=UnitName("player")}};
		numNeeds = numNeeds + 1;

		NL_CONFIGS[sName].NumNeeds = numNeeds;
	end

	if( not NL_CONFIGS[sName].ShowHealth ) then NL_CONFIGS[sName].ShowHealth = 1; end
	if( not NL_CONFIGS[sName].ShowMana ) then NL_CONFIGS[sName].ShowMana = 0; end
	if( not NL_CONFIGS[sName].FrameWidth ) then NL_CONFIGS[sName].FrameWidth = 80; end
	if( not NL_CONFIGS[sName].MaxUnits ) then NL_CONFIGS[sName].MaxUnits = 10; end
	if( not NL_CONFIGS[sName].UseWhenSolo ) then NL_CONFIGS[sName].UseWhenSolo = 1; end
	if( not NL_CONFIGS[sName].UseInParty ) then NL_CONFIGS[sName].UseInParty = 1; end
	if( not NL_CONFIGS[sName].UseInRaid ) then NL_CONFIGS[sName].UseInRaid = 1; end
	if( not NL_CONFIGS[sName].AutoSort ) then NL_CONFIGS[sName].AutoSort = 1; end
	if( not NL_CONFIGS[sName].ShowTooltips ) then NL_CONFIGS[sName].ShowTooltips = 1; end
	if( not NL_CONFIGS[sName].LargeNeedIcons ) then NL_CONFIGS[sName].LargeNeedIcons = 1; end
	if( not NL_CONFIGS[sName].UseCastParty ) then NL_CONFIGS[sName].UseCastParty = 1; end
	if( not NL_CONFIGS[sName].ShowHealthNum ) then NL_CONFIGS[sName].ShowHealthNum = 0; end
	if( not NL_CONFIGS[sName].ShowNeeds ) then NL_CONFIGS[sName].ShowNeeds = 1; end
	if( not NL_CONFIGS[sName].ShowBuffs ) then NL_CONFIGS[sName].ShowBuffs = 0; end
	if( not NL_CONFIGS[sName].ShowHealBuffs ) then NL_CONFIGS[sName].ShowHealBuffs = 0; end
	if( not NL_CONFIGS[sName].ShowDebuffs ) then NL_CONFIGS[sName].ShowDebuffs = 0; end
	if( not NL_CONFIGS[sName].SwapNeedsAndDetails ) then
		NL_CONFIGS[sName].SwapNeedsAndDetails = 0;
	elseif( NL_CONFIGS[sName].SwapNeedsAndDetails == 1 ) then
			-- change the anchor points on all the needs and details frames
		NLAnchorDetails("target", false);
		NLAnchorDetails("player", false);
		NLAnchorDetails("pet", false);
		for i=1, 4 do
			NLAnchorDetails("party"..i, false);
			NLAnchorDetails("partypet"..i, false);
		end
		for i=1, 40 do
			NLAnchorDetails("raid"..i, false);
			NLAnchorDetails("raidpet"..i, false);
		end
	end
	if( not NL_CONFIGS[sName].InvertList ) then NL_CONFIGS[sName].InvertList = 0; end
	if( not NL_CONFIGS[sName].ColorByClass ) then NL_CONFIGS[sName].ColorByClass = 0; end
	if( not NL_CONFIGS[sName].BlackListDelay ) then NL_CONFIGS[sName].BlackListDelay = 5; end
	if( not NL_CONFIGS[sName].ShowTargetFrame ) then NL_CONFIGS[sName].ShowTargetFrame = 0; end
	if( not NL_CONFIGS[sName].ResurrectionNeedIndex ) then
		for i=1, NL_CONFIGS[sName].NumNeeds - 1 do
			if( NL_CONFIGS[sName].Needs[i].Name == "Resurrection" ) then
				NL_CONFIGS[sName].ResurrectionNeedIndex = i;
			end
		end
	end

	NL_CONFIGS[sName].Version = NL_CURRENT_VERSION;

	return NL_CONFIGS[sName];
end

function NLGetSpecialFilter(manaUsersOnly, myPartyOnly)
	local newFilter = {};

	newFilter.Type="Multi";
	newFilter.Names = {};
	newFilter.Names[NL_PRIEST_NAME]=true;
	newFilter.Names[NL_MAGE_NAME]=true;
	newFilter.Names[NL_HUNTER_NAME]=true;
	newFilter.Names[NL_WARLOCK_NAME]=true;
	newFilter.Names[NL_DRUID_NAME]=true;
	newFilter.Names[NL_DEMON_NAME]=true;
	if( not manaUsersOnly ) then
		newFilter.Names[NL_WARRIOR_NAME] = true;
		newFilter.Names[NL_ROGUE_NAME] = true;
		newFilter.Names[NL_BEAST_NAME] = true;
	end
	if( UnitFactionGroup( "player" ) == "Horde" ) then
		newFilter.Names[NL_SHAMAN_NAME] = true;
	else
		newFilter.Names[NL_PALADIN_NAME] = true;
	end
	if( not myPartyOnly ) then
		newFilter.Names["Party 1"] = true;
		newFilter.Names["Party 2"] = true;
		newFilter.Names["Party 3"] = true;
		newFilter.Names["Party 4"] = true;
		newFilter.Names["Party 5"] = true;
		newFilter.Names["Party 6"] = true;
		newFilter.Names["Party 7"] = true;
		newFilter.Names["Party 8"] = true;
	end
	newFilter.Names["My Party"] = true;

	return newFilter;
end

function NL_InitializeConfigFrame()
	getglobal(NLMainFrameName .. "_CheckButtonUseWhenSolo"):SetChecked(NLConfig.UseWhenSolo);
	getglobal(NLMainFrameName .. "_CheckButtonUseInParty"):SetChecked(NLConfig.UseInParty);
	getglobal(NLMainFrameName .. "_CheckButtonUseInRaid"):SetChecked(NLConfig.UseInRaid);
	getglobal(NLMainFrameName .. "_CheckButtonShowHealth"):SetChecked(NLConfig.ShowHealth);
	getglobal(NLMainFrameName .. "_CheckButtonShowMana"):SetChecked(NLConfig.ShowMana);
	getglobal(NLMainFrameName .. "_CheckButtonShowNeeds"):SetChecked(NLConfig.ShowNeeds);
	getglobal(NLMainFrameName .. "_CheckButtonShowBuffs"):SetChecked(NLConfig.ShowBuffs);
	getglobal(NLMainFrameName .. "_CheckButtonShowHealBuffs"):SetChecked(NLConfig.ShowHealBuffs);
	getglobal(NLMainFrameName .. "_CheckButtonShowDebuffs"):SetChecked(NLConfig.ShowDebuffs);
	getglobal(NLMainFrameName .. "_CheckButtonSwapNeedsAndDetails"):SetChecked(NLConfig.SwapNeedsAndDetails);
	getglobal(NLMainFrameName .. "_CheckButtonUseCastParty"):SetChecked(NLConfig.UseCastParty);
	getglobal(NLMainFrameName .. "_CheckButtonShowHealthNum"):SetChecked(NLConfig.ShowHealthNum);
	getglobal(NLMainFrameName .. "_CheckButtonShowHealthLost"):SetChecked(NLConfig.ShowHealthLost);
	getglobal(NLMainFrameName .. "_CheckButtonAutoSort"):SetChecked(NLConfig.AutoSort);
	getglobal(NLMainFrameName .. "_CheckButtonInvertList"):SetChecked(NLConfig.InvertList);
	getglobal(NLMainFrameName .. "_CheckButtonShowTooltips"):SetChecked(NLConfig.ShowTooltips);
	getglobal(NLMainFrameName .. "_CheckButtonLargeNeedIcons"):SetChecked(NLConfig.LargeNeedIcons);
	getglobal(NLMainFrameName .. "_CheckButtonSpellNotify"):SetChecked(NLConfig.SpellNotify);
	getglobal(NLMainFrameName .. "_CheckButtonHideHeader"):SetChecked(NLConfig.HideHeader);
	getglobal(NLMainFrameName .. "_CheckButtonColorByClass"):SetChecked(NLConfig.ColorByClass);
	getglobal(NLMainFrameName .. "_SliderFrameWidth"):SetValue(NLConfig.FrameWidth);
	getglobal(NLMainFrameName .. "_BlackListDelay"):SetNumber(NLConfig.BlackListDelay);
	getglobal(NLMainFrameName .. "_MaxUnits"):SetNumber(NLConfig.MaxUnits);
	getglobal(NLMainFrameName .. "_CheckButtonShowTargetFrame"):SetChecked(NLConfig.ShowTargetFrame);
end

function NL_SaveConfig()
	if( getglobal(NLMainFrameName .. "_CheckButtonUseWhenSolo"):GetChecked() == nil ) then
		NLConfig.UseWhenSolo = 0;
	else
		NLConfig.UseWhenSolo = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonUseInParty"):GetChecked() == nil ) then
		NLConfig.UseInParty = 0;
	else
		NLConfig.UseInParty = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonUseInRaid"):GetChecked() == nil ) then
		NLConfig.UseInRaid = 0;
	else
		NLConfig.UseInRaid = 1;
	end

	if( getglobal(NLMainFrameName .. "_CheckButtonShowHealth"):GetChecked() == nil ) then
		NLConfig.ShowHealth = 0;
	else
		NLConfig.ShowHealth = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonShowMana"):GetChecked() == nil ) then
		NLConfig.ShowMana = 0;
	else
		NLConfig.ShowMana = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonShowNeeds"):GetChecked() == nil ) then
		NLConfig.ShowNeeds = 0;
	else
		NLConfig.ShowNeeds = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonShowBuffs"):GetChecked() == nil ) then
		NLConfig.ShowBuffs = 0;
	else
		NLConfig.ShowBuffs = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonShowHealBuffs"):GetChecked() == nil ) then
		NLConfig.ShowHealBuffs = 0;
	else
		NLConfig.ShowHealBuffs = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonShowDebuffs"):GetChecked() == nil ) then
		NLConfig.ShowDebuffs = 0;
	else
		NLConfig.ShowDebuffs = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonUseCastParty"):GetChecked() == nil ) then
		NLConfig.UseCastParty = 0;
	else
		NLConfig.UseCastParty = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonShowHealthNum"):GetChecked() == nil ) then
		NLConfig.ShowHealthNum = 0;
	else
		NLConfig.ShowHealthNum = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonShowHealthLost"):GetChecked() == nil ) then
		NLConfig.ShowHealthLost = 0;
	else
		NLConfig.ShowHealthLost = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonAutoSort"):GetChecked() == nil ) then
		NLConfig.AutoSort = 0;
	else
		NLConfig.AutoSort = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonSpellNotify"):GetChecked() == nil ) then
		NLConfig.SpellNotify = 0;
	else
		NLConfig.SpellNotify = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonHideHeader"):GetChecked() == nil ) then
		NLConfig.HideHeader = 0;
	else
		NLConfig.HideHeader = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonShowTooltips"):GetChecked() == nil ) then
		NLConfig.ShowTooltips = 0;
	else
		NLConfig.ShowTooltips = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonLargeNeedIcons"):GetChecked() == nil ) then
		NLConfig.LargeNeedIcons = 0;
	else
		NLConfig.LargeNeedIcons = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonSwapNeedsAndDetails"):GetChecked() == nil ) then
		-- change the anchor points on all the needs and details frames
		NLAnchorDetails("target", true);
		NLAnchorDetails("player", true);
		NLAnchorDetails("pet", true);
		for i=1, 4 do
			NLAnchorDetails("party"..i, true);
			NLAnchorDetails("partypet"..i, true);
		end
		for i=1, 40 do
			NLAnchorDetails("raid"..i, true);
			NLAnchorDetails("raidpet"..i, true);
		end
		NLConfig.SwapNeedsAndDetails = 0;
	else
		-- change the anchor points on all the needs and details frames
		NLAnchorDetails("target", false);
		NLAnchorDetails("player", false);
		NLAnchorDetails("pet", false);
		for i=1, 4 do
			NLAnchorDetails("party"..i, false);
			NLAnchorDetails("partypet"..i, false);
		end
		for i=1, 40 do
			NLAnchorDetails("raid"..i, false);
			NLAnchorDetails("raidpet"..i, false);
		end
		NLConfig.SwapNeedsAndDetails = 1;
	end
	if( getglobal(NLMainFrameName .. "_CheckButtonInvertList"):GetChecked() == nil ) then
		NLConfig.InvertList = 0;
	else
		NLConfig.InvertList = 1;
	end

	if( getglobal(NLMainFrameName .. "_CheckButtonColorByClass"):GetChecked() == nil ) then
		NLConfig.ColorByClass = 0;
	else
		NLConfig.ColorByClass = 1;
	end

	if( getglobal(NLMainFrameName .. "_CheckButtonShowTargetFrame"):GetChecked() == nil ) then
		NLConfig.ShowTargetFrame = 0;
	else
		NLConfig.ShowTargetFrame = 1;
	end

	NLConfig.FrameWidth = getglobal(NLMainFrameName .. "_SliderFrameWidth"):GetValue();
	NLConfig.BlackListDelay = getglobal(NLMainFrameName .. "_BlackListDelay"):GetNumber();
	NLConfig.MaxUnits = getglobal(NLMainFrameName .. "_MaxUnits"):GetNumber();


	NL_CheckIfEnabled();

	if( NL_ENABLED ) then
		NLHeader:Hide();
		NLHeader:Show();
	end
end

function NLAnchorDetails( member, side )
	if( side ) then
		getglobal("NLMember" .. member .. "BuffsDetails"):ClearAllPoints();
		getglobal("NLMember" .. member .. "BuffsDetails"):SetPoint("BOTTOMRIGHT", "NLMember" .. member, "BOTTOMLEFT", 5, 0);
		getglobal("NLMember" .. member .. "DebuffsDetails"):ClearAllPoints();
		getglobal("NLMember" .. member .. "DebuffsDetails"):SetPoint("BOTTOMRIGHT", "NLMember" .. member .. "BuffsDetails", "BOTTOMLEFT", 5, 0);
		getglobal("NLMember" .. member .. "NeedsDetails"):ClearAllPoints();
		getglobal("NLMember" .. member .. "NeedsDetails"):SetPoint("BOTTOMLEFT", "NLMember" .. member, "BOTTOMRIGHT", -5, 0);
	else
		getglobal("NLMember" .. member .. "BuffsDetails"):ClearAllPoints();
		getglobal("NLMember" .. member .. "BuffsDetails"):SetPoint("BOTTOMLEFT", "NLMember" .. member, "BOTTOMRIGHT", -5, 0);
		getglobal("NLMember" .. member .. "DebuffsDetails"):ClearAllPoints();
		getglobal("NLMember" .. member .. "DebuffsDetails"):SetPoint("BOTTOMLEFT", "NLMember" .. member .. "BuffsDetails", "BOTTOMRIGHT", -5, 0);
		getglobal("NLMember" .. member .. "NeedsDetails"):ClearAllPoints();
		getglobal("NLMember" .. member .. "NeedsDetails"):SetPoint("BOTTOMRIGHT", "NLMember" .. member, "BOTTOMLEFT", 5, 0);
	end
end

function NL_InitializeConfigSpellsFrame()
	if( not NLConfig.HealSpells ) then
		return;
	end

	if( NLConfig.HealSpells[1] ) then
		getglobal("NLConfigSpellsFrameHeal1"):SetText(NLConfig.HealSpells[1]);
	else
		getglobal("NLConfigSpellsFrameHeal1"):SetText("");
	end
	if( NLConfig.HealSpells[2] ) then
		getglobal("NLConfigSpellsFrameHeal2"):SetText(NLConfig.HealSpells[2]);
	else
		getglobal("NLConfigSpellsFrameHeal2"):SetText("");
	end
	if( NLConfig.HealSpells[3] ) then
		getglobal("NLConfigSpellsFrameHeal3"):SetText(NLConfig.HealSpells[3]);
	else
		getglobal("NLConfigSpellsFrameHeal3"):SetText("");
	end
	if( NLConfig.HealSpells[4] ) then
		getglobal("NLConfigSpellsFrameHeal4"):SetText(NLConfig.HealSpells[4]);
	else
		getglobal("NLConfigSpellsFrameHeal4"):SetText("");
	end
	if( NLConfig.HealSpells[5] ) then
		getglobal("NLConfigSpellsFrameHeal5"):SetText(NLConfig.HealSpells[5]);
	else
		getglobal("NLConfigSpellsFrameHeal5"):SetText("");
	end
end

function NL_SaveSpellsConfig()
	if( not NLConfig.HealSpells ) then
		NLConfig.HealSpells = {};
	end
	if( getglobal("NLConfigSpellsFrameHeal1"):GetText() == "" ) then
		NLConfig.HealSpells[1] = nil;
	else
		NLConfig.HealSpells[1] = getglobal("NLConfigSpellsFrameHeal1"):GetText();
	end
	if( getglobal("NLConfigSpellsFrameHeal2"):GetText() == "" ) then
		NLConfig.HealSpells[2] = nil;
	else
		NLConfig.HealSpells[2] = getglobal("NLConfigSpellsFrameHeal2"):GetText();
	end
	if( getglobal("NLConfigSpellsFrameHeal3"):GetText() == "" ) then
		NLConfig.HealSpells[3] = nil;
	else
		NLConfig.HealSpells[3] = getglobal("NLConfigSpellsFrameHeal3"):GetText();
	end
	if( getglobal("NLConfigSpellsFrameHeal4"):GetText() == "" ) then
		NLConfig.HealSpells[4] = nil;
	else
		NLConfig.HealSpells[4] = getglobal("NLConfigSpellsFrameHeal4"):GetText();
	end
	if( getglobal("NLConfigSpellsFrameHeal5"):GetText() == "" ) then
		NLConfig.HealSpells[5] = nil;
	else
		NLConfig.HealSpells[5] = getglobal("NLConfigSpellsFrameHeal5"):GetText();
	end
end

function NL_InitializeConfigNeedsFrame()
	-- loop through all allowed need monitors for this char
	for i = 0, NLConfig.NumNeeds - 1 do
		local CurrentNeed = NLConfig.Needs[i];
		if( CurrentNeed == nil ) then
			return;
		end

		if( CurrentNeed.Name == "Health" ) then
			NLConfigNeedsFrameNeedHealth_EditBox:SetNumber( CurrentNeed.Threshold );
		end

		if( CurrentNeed.Name == "Mana" ) then
			NLConfigNeedsFrameNeedMana_EditBox:SetNumber( CurrentNeed.Threshold );
		end

		local frame = getglobal(NLNeedFrameName .. "Need" .. CurrentNeed.Name);

		frame:ClearAllPoints();
		frame:SetPoint("TOPLEFT", NLNeedFrameName, "TOPLEFT", NL_NEED_FRAME_LEFT_INDENT, -NL_NEED_FRAME_TOP_INDENT - i * NL_NEED_FRAME_SPACING );
		getglobal(NLNeedFrameName .. "Need" .. CurrentNeed.Name .. "_CheckButton"):SetChecked(CurrentNeed.Toggle);

		frame.r = CurrentNeed.BGColor.r;
		frame.g = CurrentNeed.BGColor.g;
		frame.b = CurrentNeed.BGColor.b;
		getglobal(NLNeedFrameName .. "Need" .. CurrentNeed.Name .. "_ColorSwatchNormalTexture"):SetVertexColor( frame.r, frame.g, frame.b );
		frame.swatchFunc = function() NLConfig_SetColor(CurrentNeed.Name); end;
		frame.cancelFunc = function() NLConfig_CancelColor(CurrentNeed.Name); end;

		getglobal(NLNeedFrameName .. "Need" .. CurrentNeed.Name):Show();
		getglobal(NLNeedFrameName .. "Need" .. CurrentNeed.Name).Priority = i;

		if( CurrentNeed.Filter ~= nil ) then
			getglobal(NLNeedFrameName .. "Need" .. CurrentNeed.Name).Filter = CurrentNeed.Filter;
		end
	end
end

function NL_SaveNeedsConfig()
	-- if the frame's priority doesn't match the need priority, update the need priority
	for i = 0, NLConfig.NumNeeds - 1 do
		local frame = getglobal( NLNeedFrameName .. "Need" .. NLConfig.Needs[i].Name );
		-- move the frame that was
		if( frame.Priority ~= i ) then
			local tempNeed = NLConfig.Needs[frame.Priority];
			NLConfig.Needs[frame.Priority] = NLConfig.Needs[i];
			NLConfig.Needs[i] = tempNeed;
			i = i - 1;
		end
	end

	for i = 0, NLConfig.NumNeeds - 1 do
		local CurrentNeed = NLConfig.Needs[i];
		if( CurrentNeed == nil ) then
			return;
		end

		if( CurrentNeed.Name == "Health" ) then
			 CurrentNeed.Threshold = getglobal(NLNeedFrameName .. "NeedHealth_EditBox"):GetNumber();
			 NLConfig.HealthNeedIndex = i;
		end

		if( CurrentNeed.Name == "Mana" ) then
			 CurrentNeed.Threshold = getglobal(NLNeedFrameName .. "NeedMana_EditBox"):GetNumber();
			 NLConfig.ManaNeedIndex = i;
		end

		if( CurrentNeed.Name == "Resurrection" ) then
			 NLConfig.ResurrectionNeedIndex = i;
		end
		
		if( getglobal(NLNeedFrameName .. "Need" .. CurrentNeed.Name .. "_CheckButton"):GetChecked() == nil ) then
			CurrentNeed.Toggle = 0;
		else
			CurrentNeed.Toggle = 1;
		end

		local frame = getglobal( NLNeedFrameName .. "Need" .. CurrentNeed.Name );

		CurrentNeed.BGColor.r = frame.r;
		CurrentNeed.BGColor.g = frame.g;
		CurrentNeed.BGColor.b = frame.b;

		if( getglobal( NLNeedFrameName .. "Need" .. CurrentNeed.Name ).Filter ~= nil ) then
			CurrentNeed.Filter = getglobal(NLNeedFrameName .. "Need" .. CurrentNeed.Name).Filter;
		end
	end
end

function NL_OpenColorPicker(button)
	CloseMenus();
	if ( not button ) then
		button = this;
	end
	ColorPickerFrame.func = button.swatchFunc;
	ColorPickerFrame:SetColorRGB(button.r, button.g, button.b);
	ColorPickerFrame.previousValues = {r = button.r, g = button.g, b = button.b, opacity = button.opacity};
	ColorPickerFrame.cancelFunc = button.cancelFunc;
	ColorPickerFrame:Show();
end

function NLConfig_SetColor(needName)
	local frame = getglobal( NLNeedFrameName .. "Need" .. needName );
	local r,g,b = ColorPickerFrame:GetColorRGB();
	getglobal( NLNeedFrameName .. "Need" .. needName .. "_ColorSwatchNormalTexture"):SetVertexColor(r,g,b);
	frame.r = r;
	frame.g = g;
	frame.b = b;
end

function NLConfig_CancelColor(needName)
	local frame = getglobal( NLNeedFrameName .. "Need" .. needName );
	local CurrentNeed = NLConfig.Needs[frame.Priority];

	frame.r = CurrentNeed.BGColor.r;
	frame.g = CurrentNeed.BGColor.g;
	frame.b = CurrentNeed.BGColor.b;
	getglobal( NLNeedFrameName .. "Need" .. needName .. "_ColorSwatchNormalTexture"):SetVertexColor( frame.r, frame.g, frame.b );
end

function NL_SwapNeedFrames( frame1, frame2 )
	-- swap these frames
	local tempPriority = frame1.Priority;
	frame1.Priority = frame2.Priority;
	frame2.Priority = tempPriority;

	frame1:ClearAllPoints();
	frame1:SetPoint("TOPLEFT", NLNeedFrameName, "TOPLEFT", NL_NEED_FRAME_LEFT_INDENT, -NL_NEED_FRAME_TOP_INDENT - frame1.Priority * NL_NEED_FRAME_SPACING );
	frame2:ClearAllPoints();
	frame2:SetPoint("TOPLEFT", NLNeedFrameName, "TOPLEFT", NL_NEED_FRAME_LEFT_INDENT, -NL_NEED_FRAME_TOP_INDENT - frame2.Priority * NL_NEED_FRAME_SPACING );
end

function NL_PopulateUnitFilterFrame( filter )
	if( filter == nil or filter.Type ~= "Units" ) then
		return;
	end

	if( filter.Names ~= nil ) then
		NLFilterListFrameUnitsSubframeNames:SetText( filter.Names );
	else
		NLFilterListFrameUnitsSubframeNames:SetText( "" );
	end
end

function NL_PopulatePartyFilterFrame( filter )
	if( filter == nil or filter.Type ~= "Multi" ) then
		return;
	end

	if( filter.Names == nil ) then
		filter.Names = {};
	end

	for i=1, 8 do
		local frame = getglobal( "NLFilterListFrameMultiSubframeParty" .. i );
		if( filter.Names["Party "..i] ) then
			frame:SetBackdropColor(0.5, 0.5, 1, 1);
			frame.Flagged = true;
		else
			frame:SetBackdropColor(0, 0, 0.5, 1);
			frame.Flagged = false;
		end
	end

	if( filter.Names["My Party"] ) then
		NLFilterListFrameMultiSubframeParty9:SetBackdropColor(0.5, 0.5, 1, 1);
		NLFilterListFrameMultiSubframeParty9.Flagged = true;
	else
		NLFilterListFrameMultiSubframeParty9:SetBackdropColor(0, 0, 0.5, 1);
		NLFilterListFrameMultiSubframeParty9.Flagged = false;
	end
end

function NL_SelectAllPartyFilterFrame()
	for i=1, 9 do
		local frame = getglobal( "NLFilterListFrameMultiSubframeParty" .. i );
		frame:SetBackdropColor(0.5, 0.5, 1, 1);
		frame.Flagged = true;
		getglobal(NLFilterListFrame.NeedFrame).Filter.Names[ getglobal( frame:GetName() .. "Text" ):GetText() ] = true;
	end
end

function NL_SelectNonePartyFilterFrame()
	for i=1, 9 do
		local frame = getglobal( "NLFilterListFrameMultiSubframeParty" .. i );
		frame:SetBackdropColor(0, 0, 0.5, 1);
		frame.Flagged = false;
		getglobal(NLFilterListFrame.NeedFrame).Filter.Names[ getglobal( frame:GetName() .. "Text" ):GetText() ] = false;
	end
end

function NL_PopulateClassFilterFrame( filter )
	if( filter == nil or filter.Type ~= "Multi" ) then
		return;
	end

	if( filter.Names == nil ) then
		filter.Names = {};
	end

	for i = 1, 10 do
		local frame = getglobal( "NLFilterListFrameMultiSubframeClass" .. i );
		
		local class = NLClassLists[i][UnitFactionGroup("player")];
		if( filter.Names[class] ) then
			frame:SetBackdropColor(0.5, 0.5, 1, 1);
			frame.Flagged = true;
		else
			frame:SetBackdropColor(0, 0, 0.5, 1);
			frame.Flagged = false;
		end
		frame:Show();
	end
end

function NL_SelectAllClassFilterFrame()
	for i = 1, 10 do
		local frame = getglobal( "NLFilterListFrameMultiSubframeClass" .. i );
		frame:SetBackdropColor(0.5, 0.5, 1, 1);
		frame.Flagged = true;
		getglobal(NLFilterListFrame.NeedFrame).Filter.Names[ getglobal( frame:GetName() .. "Text" ):GetText() ] = true;
	end
end

function NL_SelectNoneClassFilterFrame()
	for i = 1, 10 do
		local frame = getglobal( "NLFilterListFrameMultiSubframeClass" .. i );
		frame:SetBackdropColor(0, 0, 0.5, 1);
		frame.Flagged = false;
		getglobal(NLFilterListFrame.NeedFrame).Filter.Names[ getglobal( frame:GetName() .. "Text" ):GetText() ] = true;
	end
end
