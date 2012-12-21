--------------------------------------------------------
-- Ralak's Needy List
-- a UI modification by Ralak of Kel'Thuzad
-- German Localization by Nitram from DE-Azshara
-- French Localization by Olivier Bockstal
--------------------------------------------------------
NL_CURRENT_VERSION = 2.05;

NL_DEBUG_MODE = false;

NL_MAX_TOOLTIP_BUFFS = 16;
NL_MAX_TOOLTIP_DEBUFFS = 16;
NL_MAX_NEEDS = 12;
NL_BLACK_LIST = {};
NL_MINIMIZED = false;
NL_SLOTS = {};
NL_NUM_NEEDY_UNITS = 0;

NL_PLAYERCLASS = "";
NL_ITERATOR = 1;

NeedyListDetails = {
	name = 'Ralak\'s Needy List',
	description = 'Monitor needy units in your party or raid group.',
	version = NL_CURRENT_VERSION,
	releaseDate = 'June 25, 2006',
	author = 'Carson Knittig',
	email = 'needylist@gmail.com',
	category = MYADDONS_CATEGORY_RAID,
	frame = 'NLMainFrame',
	optionsframe = 'NLConfigFrame'
};

NL_CLASS_COLORS = {};
NL_CLASS_COLORS[NL_PRIEST_NAME] = {r = 1.0, g = 1.0, b = 1.0};
NL_CLASS_COLORS[NL_DRUID_NAME] = {r = 0.0, g = 1.0, b = 0.0};
NL_CLASS_COLORS[NL_MAGE_NAME] = {r = 0.0, g = 0.0, b = 1.0};
NL_CLASS_COLORS[NL_PALADIN_NAME] = {r = 1.0, g = 1.0, b = 0.0};
NL_CLASS_COLORS[NL_WARLOCK_NAME] = {r = 0.5, g = 0.25, b = 0.6};
NL_CLASS_COLORS[NL_ROGUE_NAME] = {r = 0.5, g = 0.5, b = 0.5};
NL_CLASS_COLORS[NL_SHAMAN_NAME] = {r = 1.0, g = 1.0, b = 0.0};
NL_CLASS_COLORS[NL_WARRIOR_NAME] = {r = 1.0, g = 0.0, b = 0.0};
NL_CLASS_COLORS[NL_BEAST_NAME] = {r = 0.5, g = 0.4, b = 0.25};
NL_CLASS_COLORS[NL_DEMON_NAME] = {r = 1.0, g = 0.6, b = 0.25};
NL_CLASS_COLORS["Default"] = {r = 0.25, g = 0.25, b = 0.25};

NL_WEAKENED_SOUL = "Interface\\Icons\\Spell_Holy_AshesToAshes";
NL_BANISH = "Interface\\Icons\\Spell_Shadow_Cripple";
NL_PHASE_SHIFT = "Interface\\Icons\\Spell_Shadow_ImpPhaseShift";
NL_MINDCONTROL = "Interface\\Icons\\Spell_Shadow_ShadowWordDominate";
NL_MINDCONTROLCAP = "Interface\\Icons\\Spell_Magic_MageArmor";
NL_FEIGNDEATH = "Interface\\Icons\\Ability_Rogue_FeignDeath";

NL_CLICK_INDICES = {LeftButton = 1, RightButton = 2, MiddleButton = 3, Button4 = 4, Button5 = 5};

NL_ICON_LOCATION = "Interface\\Icons\\";

NLAnchors = { {
AnchorPoint = "TOPLEFT",
ReferenceAnchorPoint = "BOTTOMLEFT",
Offset = -1,
},
{
AnchorPoint = "BOTTOMLEFT",
ReferenceAnchorPoint = "TOPLEFT",
Offset = 1,
}
};

function NL_Msg(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end

function NL_DebugMsg(msg)
	if( NL_DEBUG_MODE ) then
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end
end

function NL_PrintTable()
	local test1, test2, test3, test4 = NLMemberplayer:GetPoint("TOPLEFT");
	table.foreach( test2, NL_Msg );
	NL_Msg( test3 .. test4 );
end

function NL_OnLoad()
	-- Register Events
	NLMainFrame:RegisterEvent("UNIT_NAME_UPDATE");
	NLMainFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
	NLMainFrame:RegisterEvent("UNIT_HEALTH");
	NLMainFrame:RegisterEvent("UNIT_MANA");
	NLMainFrame:RegisterEvent("UNIT_RAGE");
	NLMainFrame:RegisterEvent("UNIT_FOCUS");
	NLMainFrame:RegisterEvent("UNIT_ENERGY");
	NLMainFrame:RegisterEvent("UNIT_AURA");
	NLMainFrame:RegisterEvent("PARTY_MEMBERS_CHANGED");
	NLMainFrame:RegisterEvent("RAID_ROSTER_UPDATE");
	NLMainFrame:RegisterEvent("UNIT_PET");
	NLMainFrame:RegisterEvent("VARIABLES_LOADED");
	NLMainFrame:RegisterEvent("PLAYER_TARGET_CHANGED");

	-- Add Slash Commands
	SlashCmdList["NLCONFIG"] = NL_Configure;
	SLASH_NLCONFIG1 = "/nlconfig";

	-- get this player's class so we know which buffs and debuffs to notify him/her of
	NL_PLAYERCLASS = UnitClass("player");

	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(NL_STR_INTRO_PREFIX..NL_CURRENT_VERSION..NL_STR_INTRO_SUFFIX);
		DEFAULT_CHAT_FRAME:AddMessage(NL_STR_INTRO_DESC);
	end
	
	-- set the units on each frame so they never have to be set again
	NLMemberplayer.Unit = "player";
	NLMemberpet.Unit = "pet";
	NLMembertarget.Unit = "target";
	for NL_ITERATOR=1, 4 do
		getglobal("NLMemberparty"..NL_ITERATOR).Unit = "party"..NL_ITERATOR;
		getglobal("NLMemberpartypet"..NL_ITERATOR).Unit = "partypet"..NL_ITERATOR;
	end
	for NL_ITERATOR=1, 40 do
		getglobal("NLMemberraid"..NL_ITERATOR).Unit = "raid"..NL_ITERATOR;
		getglobal("NLMemberraidpet"..NL_ITERATOR).Unit = "raidpet"..NL_ITERATOR;
	end
end

function NL_CheckIfEnabled()
	local bRaid = GetNumRaidMembers() > 0;
	local bParty = UnitExists("party1") and not bRaid;
	local bSolo = not ( bParty or bRaid );

	if( ( bRaid and NLConfig.UseInRaid == 1 ) or ( bParty and NLConfig.UseInParty == 1 ) or ( bSolo and NLConfig.UseWhenSolo == 1 ) ) then
		NL_Enable();
	else
		NL_Disable();
	end
end

function NL_Disable()
	NL_ENABLED = false;

	NLHeader:Hide();

	getglobal("NLMemberplayer"):Hide();
	getglobal("NLMemberpet"):Hide();
	for NL_ITERATOR=1, 4 do
		getglobal("NLMemberparty"..NL_ITERATOR):Hide();
		getglobal("NLMemberpartypet"..NL_ITERATOR):Hide();
	end
	for NL_ITERATOR=1, 40 do
		getglobal("NLMemberraid"..NL_ITERATOR):Hide();
		getglobal("NLMemberraidpet"..NL_ITERATOR):Hide();
	end
end

function NL_Enable()
	NL_ENABLED = true;

	NLHeader:Show();

	NLMember_CheckAllUnits();
end

function NL_Configure()
	NLConfigFrame:Show();
end

function NL_OnEvent(event, arg1)
	
	--Player loaded completely
	if ( event == "UNIT_NAME_UPDATE" and arg1 == "player" ) or (event=="PLAYER_ENTERING_WORLD") then
		-- get the configs for this player
		NLConfig = NL_GetConfigForCurrentPlayer( false );

		NL_CheckIfEnabled();
		if( not NL_ENABLED ) then
			return;
		end

		NLHeader:Show();

		NLMember_CheckAllUnits();

		return;
	end

	if( NLConfig == nil ) then
		return;
	end

	-- this check is only for enabling the needy list based on party status
	if( event == "PARTY_MEMBERS_CHANGED" or event == "RAID_ROSTER_UPDATE" ) then
		NL_CheckIfEnabled();
	end

	if( not NL_ENABLED ) then
		return;
	end

	if( event == "PLAYER_TARGET_CHANGED" ) then
		NL_CheckTarget();
		return;
	end
	
	-- if this is a stat or buff change on a unit
	if ( event == "UNIT_HEALTH" or event == "UNIT_MANA" or event == "UNIT_RAGE" or event == "UNIT_FOCUS" or event == "UNIT_ENERGY" or event == "UNIT_AURA" ) then
		-- if the unit is blacklisted or never shown, just return
		if( arg1 ~= "target" ) then
			for NL_ITERATOR = 1, table.getn(NL_BLACK_LIST) do
				if( NL_BLACK_LIST[NL_ITERATOR].Unit == arg1 ) then
					return;
				end
			end
		end

		-- if I'm in a raid group, only use units with raid in their name
		local criteria;
		if( GetNumRaidMembers() > 0 ) then
			criteria = string.find( arg1, "raid" ) ~= nil;
		elseif( GetNumPartyMembers() > 0 ) then
			criteria = string.find( arg1, "party" ) ~= nil or arg1 == "player" or arg1 == "pet";
		else
			criteria = arg1 == "player" or arg1 == "pet";
		end

		-- if this player is in the raid or party, or is the default player
		if( criteria or (arg1 == "target" and UnitIsFriend("target", "player") and NLConfig.ShowTargetFrame == 1)) then
			if( getglobal("NLMember"..arg1).TopNeed and getglobal("NLMember"..arg1).TopNeed == 0 ) then
				return;
			end
		
			if( not NL_CheckForResurrectionNeed( arg1 ) ) then
				if( NLConfig.ResurrectionNeedIndex ) then
					if( getglobal("NLMember"..arg1).Needs[NLConfig.ResurrectionNeedIndex] ) then
						getglobal("NLMember"..arg1).Needs[NLConfig.ResurrectionNeedIndex] = false;
						NL_CheckAllNeeds(arg1);
						return;
					end
				end
				
				if( event == "UNIT_HEALTH" ) then
					if( NL_CheckHealth( arg1 ) ) then
						NL_AddToList( arg1 );
					else
						NL_RemoveFromList( arg1 );
					end
				elseif( event == "UNIT_AURA" ) then
					if( NL_CheckAura( arg1 ) ) then
						NL_AddToList( arg1 );
						if( getglobal("NLMember"..arg1):IsShown() ) then
							NL_UpdateAura( arg1 );
						end
					else
						NL_RemoveFromList( arg1 );
					end
				else
					if( NL_CheckMana( arg1 ) ) then
						NL_AddToList( arg1 );
					else
						NL_RemoveFromList( arg1 );
					end
				end
				if( getglobal("NLMember"..arg1):IsShown() ) then
					NL_UpdateUnit( arg1 );
				end
			end
		end

		return;
	end

	if( event == "UNIT_PET" ) then
		local criteria;
		local prefix;
		local suffix;
		if( GetNumRaidMembers() > 0 ) then
			criteria = string.find( arg1, "raid" ) ~= nil;
			prefix = "raid";
			suffix = string.sub( arg1, 5 );
		else
			-- the reason we only check the player here is because in a raid, the player is treated as a raid member as well as the player
			-- no sense updating twice!
			if( arg1 == "player" ) then
				NL_CheckAllNeeds( "pet" );
				return;
			else
				criteria = string.find( arg1, "party" ) ~= nil;
				prefix = "party";
				suffix = string.sub( arg1, 6 );
			end
		end

		-- if we're in a raid, check raid members
		-- if not, check party members, or do nothing if we already found the player
		if( criteria ) then
			local petUnit = prefix .. "pet" .. suffix;
			NL_DebugMsg( "pet event for "..petUnit .. " was caught");
			NL_CheckAllNeeds( petUnit );
		end
		return;
	end

	if( event == "PARTY_MEMBERS_CHANGED" or event == "RAID_ROSTER_UPDATE" ) then
		NLMember_CheckAllUnits();
		return;
	end

	if( event == "VARIABLES_LOADED" ) then
		-- Register the addon in myAddOns
		if(myAddOnsFrame_Register) then
			myAddOnsFrame_Register(NeedyListDetails);
		end

		return;
	end
end

function NL_UnitPassesFilter( unit, filter )
	if( filter == nil or filter.Type == "Everyone" ) then
		return true;
	end

	if( filter.Type == "Units" ) then
		if( string.find( filter.Names, UnitName( unit ) ) ) then
			local foundName = string.sub( filter.Names, string.find( filter.Names, UnitName( unit ) ) );
			if( string.find( foundName, "," ) ) then
				foundName = string.sub( foundName, string.find( foundName, "," ) - 1 );
			end
			if( foundName == UnitName( unit ) ) then
				return true;
			end
		end
	end

	-- if the filter is by party, use the unit name to determine which party and check if that party is being monitored
	-- party filter is only valid in raids, so if you're not in a raid, pretend filter is everyone
	if( filter.Type == "Multi" ) then
		local bPassedPartyCheck = false;
		if( unit == "target" ) then
			bPassedPartyCheck = true;
		else
			if( ( UnitInParty(unit) or string.find( unit, "partypet" ) or unit == "pet" ) and filter.Names["My Party"] ) then
				bPassedPartyCheck = true;
			elseif( string.find( unit, "raid" ) ~= nil ) then
				local raidIndex;
				if( string.find( unit, "raidpet" ) ~= nil ) then
					raidIndex = string.sub( unit, 8 );
				else
					raidIndex = string.sub( unit, 5 );
				end
	
				local name, rank, subgroup = GetRaidRosterInfo(raidIndex);
	
				if( filter.Names["Party " .. subgroup] ) then
					bPassedPartyCheck = true;
				end
			end
		end

		if( bPassedPartyCheck ) then
			if( string.find( unit, "pet" ) ~= nil ) then
				if( filter.Names[UnitCreatureType( unit )] ) then
					return true;
				end
			else
				if( filter.Names[UnitClass( unit )] ) then
					return true;
				end
			end
		end
	end

	return false;
end

function NL_ClearNeedDetails(member)
	-- clear the need buttons in the needdetails frame
	local frameName = "NLMember" .. member;
	for NL_ITERATOR=1, NL_MAX_NEEDS do
		getglobal(frameName .. "NeedsDetailsNeed" .. NL_ITERATOR):Hide();
	end
	getglobal(frameName .. "NeedsDetails"):Hide();
end

function NL_GetUnitBuffsAndDebuffs( member )
	local buffList = {};
	local debuffList = {};
	local debuffTypeList = {};

	NL_ITERATOR = 1;
	local buff = UnitBuff(member, NL_ITERATOR);
	while( buff ~= nil ) do
		buffList[buff] = true;
		NL_ITERATOR = NL_ITERATOR + 1;
		buff = UnitBuff(member, NL_ITERATOR);
	end

	NL_ITERATOR = 1;
	local debuff = UnitDebuff(member, NL_ITERATOR);

	while( debuff ~= nil ) do
		-- do not add the ignored debuffs to the debuff lists
		if( debuff ~= NL_ICON_LOCATION.."Spell_Holy_MindVision" ) then
			debuffList[debuff] = true;

			NL_BuffTooltipTextRight1:SetText(nil);
			NL_BuffTooltip:SetUnitDebuff( member, NL_ITERATOR );
			local debuffType = NL_BuffTooltipTextRight1:GetText();

			if( debuffType ) then
				debuffTypeList[debuffType] = true;
			end
		end

		NL_ITERATOR = NL_ITERATOR + 1;
		debuff = UnitDebuff(member, NL_ITERATOR);
	end

	if( string.find( member, "pet" ) and ((buffList and buffList[NL_PHASE_SHIFT]) or (debuffList and debuffList[NL_BANISH] )) ) then
		NL_RemoveFromList( member );
		return nil;
	end
	if( debuffList and (debuffList[NL_MINDCONTROL] or debuffList[NL_MINDCONTROLCAP]) and UnitIsFriend("player", member) ) then
		NL_RemoveFromList( member );
		return nil;
	end
	
	return buffList, debuffList, debuffTypeList;
end

function NL_CheckAura( member )
	local buffList, debuffList, debuffTypeList = NL_GetUnitBuffsAndDebuffs( member );
	
	if( buffList == nil ) then
		return false;
	end

	local foundNewTopNeed = false;

	local unitFrame = getglobal("NLMember"..member);
	
	-- 0 and 1 are never show and sticky, so don't need to go thru them here
	for NL_ITERATOR = 2, NLConfig.NumNeeds - 1 do
		local CurrentNeed = NLConfig.Needs[NL_ITERATOR];
		if( CurrentNeed.Toggle == 1 and NL_UnitPassesFilter( member, CurrentNeed.Filter ) ) then
			local FoundNeed = false;
			if( CurrentNeed.Name == "WellFed" ) then
				if( not buffList[NL_ICON_LOCATION .. NL_OTHER.WellFed.Icon] ) then
					FoundNeed = true;
				end
			elseif( CurrentNeed.Type == "BUFF" and debuffList ) then
				if( not NL_FindInBuffList( CurrentNeed.Name, buffList ) ) then
					-- if the buff is power word shield, need to look for the weakened soul debuff before finding need
					if( CurrentNeed.Name == "PWShield" ) then
						if( not debuffList[NL_WEAKENED_SOUL] ) then
							FoundNeed = true;
						end
					else
						-- didn't find buff on unit, need it
						FoundNeed = true;
					end
				end
			elseif( CurrentNeed.Type == "ENCHANT" ) then
				local hasMainHandEnchant, mainHandExpiration, mainHandCharges,
					hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo()
				if( NL_PLAYERCLASS == NL_SHAMAN_NAME ) then
					if( hasMainHandEnchant ~= 1 ) then
						FoundNeed = true;
					end
				elseif( NL_PLAYERCLASS == NL_ROGUE_NAME ) then
					if( ( CurrentNeed.Name == "MainhandPoison" and hasMainHandEnchant ~= 1 ) or
						( CurrentNeed.Name == "OffhandPoison" and hasOffHandEnchant ~= 1 ) ) then
						FoundNeed = true;
					end
				end
			elseif( CurrentNeed.Type == "DEBUFF" and debuffTypeList ) then
				if( debuffTypeList[CurrentNeed.Name] ) then
					-- found debuff on unit, this is the highest priority need
					FoundNeed = true;
				end
			end

			if( FoundNeed ) then
				unitFrame.Needs[NL_ITERATOR] = true;
				if( not foundNewTopNeed ) then
					NL_SetNewTopNeed( unitFrame, NL_ITERATOR );
					foundNewTopNeed = true;
				end
			elseif( NL_ITERATOR ~= NLConfig.HealthNeedIndex and NL_ITERATOR ~= NLConfig.ManaNeedIndex and NL_ITERATOR ~= NLConfig.ResurrectionNeedIndex ) then
				unitFrame.Needs[NL_ITERATOR] = false;
				if( unitFrame.TopNeed == NL_ITERATOR ) then
					NL_SetNewTopNeed( unitFrame, NL_ITERATOR );
				end
			end
		end
	end

	if( unitFrame.TopNeed and unitFrame.TopNeed > 0 ) then
		return true;
	end
	
	return false;
end

function NL_CheckHealth( member )
	if( not NL_GetUnitBuffsAndDebuffs( member ) ) then
		return false;
	end
	
	local unitFrame = getglobal("NLMember"..member);
	unitFrame.CurrentHealth = UnitHealth( member ) / UnitHealthMax( member ) * 100;

	if( not NLConfig.HealthNeedIndex ) then
		if( unitFrame.TopNeed and unitFrame.TopNeed > 0 ) then
			return true;
		end
		return false;
	end
	
	local HealthNeed = NLConfig.Needs[NLConfig.HealthNeedIndex];
	if( HealthNeed.Toggle == 1 and NL_UnitPassesFilter( member, HealthNeed.Filter ) ) then
		if(unitFrame.CurrentHealth < HealthNeed.Threshold or 
			(unitFrame.CurrentHealth < min(HealthNeed.Threshold + 5,99) and unitFrame.SlotIndex and
			unitFrame.TopNeed == NLConfig.HealthNeedIndex ) ) then
			-- needs health
			unitFrame.Needs[NLConfig.HealthNeedIndex] = true;
		else
			unitFrame.Needs[NLConfig.HealthNeedIndex] = false;
		end
	else
		unitFrame.Needs[NLConfig.HealthNeedIndex] = false;
	end
	
	return NL_SetNewTopNeed( unitFrame, NLConfig.HealthNeedIndex );
end

function NL_CheckMana( member )
	if( not NL_GetUnitBuffsAndDebuffs( member ) ) then
		return false;
	end

	local unitFrame = getglobal("NLMember"..member);
	unitFrame.CurrentMana = UnitMana( member ) / UnitManaMax( member ) * 100;

	if( not NLConfig.ManaNeedIndex ) then
		if( unitFrame.TopNeed and unitFrame.TopNeed > 0 ) then
			return true;
		end
		return false;
	end
	
	local ManaNeed = NLConfig.Needs[NLConfig.ManaNeedIndex];
	if( ManaNeed.Toggle == 1 and NL_UnitPassesFilter( member, ManaNeed.Filter ) ) then
		if( UnitPowerType(member) == 0 and (unitFrame.CurrentMana < ManaNeed.Threshold or 
			(unitFrame.CurrentMana < min(ManaNeed.Threshold + 5,99) and unitFrame:IsShown() and
			NLConfig.ManaNeedIndex and unitFrame.TopNeed == NLConfig.ManaNeedIndex ) ) ) then
			-- needs mana
			unitFrame.Needs[NLConfig.ManaNeedIndex] = true;
		else
			unitFrame.Needs[NLConfig.ManaNeedIndex] = false;
		end
	else
		unitFrame.Needs[NLConfig.ManaNeedIndex] = false;
	end

	return NL_SetNewTopNeed( unitFrame, NLConfig.ManaNeedIndex );
end

function NL_SetNewTopNeed( unitFrame, index )
	if( unitFrame.Needs[index] == true and (not unitFrame.TopNeed or unitFrame.TopNeed > index) ) then
		unitFrame.TopNeed = index;
	elseif( unitFrame.Needs[index] == false and unitFrame.TopNeed == index ) then
		-- the next need is the new top need because health is no longer a need
		-- find the first true need in the unit's needs
		for NL_ITERATOR = 1, NLConfig.NumNeeds - 1 do
			if( unitFrame.Needs[NL_ITERATOR] ) then
				unitFrame.TopNeed = NL_ITERATOR;
				return true;
			end
		end
		
		-- if we got here, there is no longer a top need, so this unit can be removed
		unitFrame.TopNeed = nil;
		return false;
	end

	return true;
end

function NL_CheckAllNeeds( member )
	-- first, make sure the unit exists
	if( not UnitExists( member ) or UnitName( member ) == "" or UnitName( member ) == nil or not UnitIsConnected( member ) ) then
		NL_RemoveFromList( member );
		return;
	end

	-- check if never show
	if( NLConfig.Needs[0].Toggle == 1 and NL_UnitPassesFilter( getglobal("NLMember"..member).Unit, NLConfig.Needs[0].Filter ) ) then
		getglobal("NLMember"..member).TopNeed = 0;
		return;
	end
	
	-- check if stickied
	if( NLConfig.Needs[1].Toggle == 1 and NL_UnitPassesFilter( getglobal("NLMember"..member).Unit, NLConfig.Needs[1].Filter ) ) then
		getglobal("NLMember"..member).TopNeed = 1;
		getglobal("NLMember"..member).Needs[1] = true;
	end

	if( NL_CheckForResurrectionNeed( member ) ) then
		return;
	end

	-- make sure to set the resurrection need to false if we got here
	if( NLConfig.ResurrectionNeedIndex ) then
		if( getglobal("NLMember"..member).TopNeed == NLConfig.ResurrectionNeedIndex ) then
			getglobal("NLMember"..member).TopNeed = nil;
		end
		getglobal("NLMember"..member).Needs[NLConfig.ResurrectionNeedIndex] = false;
	end

	NL_CheckHealth( member );
	NL_CheckMana( member );
	NL_CheckAura( member );
	if( getglobal("NLMember"..member).TopNeed and getglobal("NLMember"..member).TopNeed > 0 ) then
		NL_AddToList( member );
	else
		NL_RemoveFromList( member );
	end
end

function NL_CheckForResurrectionNeed( member )
	-- if the unit is dead or a ghost, they either have
	if( UnitIsDead(member) or UnitIsGhost(member) or UnitHealth(member) <= 0 ) then
		if( UnitClass(member) == "Hunter" ) then
			local buffList = NL_GetUnitBuffsAndDebuffs( member );
		
			if( buffList and buffList[NL_FEIGNDEATH] ) then
				return false;
			end
		end
		-- if unit is the player, then do not monitor resurrection need, because a) can't rez yourself  b) it's obvious when you need a rez
		if( NLConfig.ResurrectionNeedIndex and NLConfig.Needs[NLConfig.ResurrectionNeedIndex].Toggle == 1 ) then
			if( not UnitIsUnit( member, "player" ) ) then
				if( getglobal("NLMember"..member).TopNeed ~= 1 ) then
					getglobal("NLMember"..member).TopNeed = NLConfig.ResurrectionNeedIndex;
				end
				getglobal("NLMember"..member).Needs[NLConfig.ResurrectionNeedIndex] = true;
				NL_AddToList( member );
				if( getglobal("NLMember"..member):IsShown() ) then
					NL_UpdateAura( member );
					NL_UpdateUnit( member );
				end
				return true;
			end
		end
		if( getglobal("NLMember"..member).TopNeed ~= 1 ) then
			NL_RemoveFromList( member );
		end
		return true;
	end

	return false;
end

function NL_GetMaxRankPlayerCanCast( spellName )
	NL_ITERATOR = 1;
	local foundSpellName, foundSpellRank;
	local highestMatch = nil;

	repeat
		foundSpellName, foundSpellRank = GetSpellName(NL_ITERATOR, BOOKTYPE_SPELL);
		if( spellName == foundSpellName ) then
			if( foundSpellRank == nil ) then
				return nil;
			end
			highestMatch = tonumber(string.sub( foundSpellRank, 6 ));
		end
		NL_ITERATOR = NL_ITERATOR + 1;
	until not foundSpellName

	return highestMatch;
end

function NL_GetMaxRankUnitCanReceive( spellRanks, unitLevel )
	NL_ITERATOR = 1;
	while spellRanks[NL_ITERATOR] and unitLevel + 10 >= spellRanks[NL_ITERATOR] do
		NL_ITERATOR = NL_ITERATOR + 1;
	end

	return NL_ITERATOR - 1;
end

function NL_CureNeedOnUnit( needName, unit, mousebutton )
	-- once in a while the interface can miss an event, leaving you with a unit whose needs have already been fixed
	-- do a check needs before casting, to make sure this is still a need on this unit
	NL_CheckAllNeeds(unit);
	NL_ITERATOR = 1;
	local needFrame = getglobal("NLMember".. unit .. "NeedsDetailsNeed"..NL_ITERATOR);
	while( needFrame and needFrame.NeedName and needFrame.NeedName ~= needName ) do
		NL_ITERATOR = NL_ITERATOR + 1;
		needFrame = getglobal("NLMember".. unit .. "NeedsDetailsNeed"..NL_ITERATOR);
	end

	-- if it wasn't found as a need, it's been cured, so just return
	if( not needFrame or needFrame.NeedName == nil ) then
		return;
	end

	local spellName = nil;
	local spellRanks = nil;
	local spellCanTargetEnemy = false;
	local spellNeedsNoTarget = false;
	local isBuff = false;

	local clickIndex = NL_CLICK_INDICES[mousebutton];

	-- find a cure spell that I can cast for this problem based on the player's level
	if( NL_BUFF_SPELLS[NL_PLAYERCLASS] and NL_BUFF_SPELLS[NL_PLAYERCLASS][needName] ) then
		spellName = NL_BUFF_SPELLS[NL_PLAYERCLASS][needName][clickIndex];
		spellRanks = NL_BUFF_SPELLS[NL_PLAYERCLASS][needName].Ranks;
		spellCanTargetEnemy = NL_BUFF_SPELLS[NL_PLAYERCLASS][needName].CanTargetEnemy;
		spellNeedsNoTarget = NL_BUFF_SPELLS[NL_PLAYERCLASS][needName].NoTarget;
		isBuff = true;
	elseif( NL_CURE_SPELLS[NL_PLAYERCLASS] and NL_CURE_SPELLS[NL_PLAYERCLASS][needName] ) then
		-- it's a debuff, find the cure spell for it
		spellName = NL_CURE_SPELLS[NL_PLAYERCLASS][needName][clickIndex];
		spellRanks = NL_CURE_SPELLS[NL_PLAYERCLASS][needName].Ranks;
		spellCanTargetEnemy = NL_CURE_SPELLS[NL_PLAYERCLASS][needName].CanTargetEnemy;
	elseif( NL_ENCHANT_SPELLS[NL_PLAYERCLASS] and NL_ENCHANT_SPELLS[NL_PLAYERCLASS][needName] ) then
		if( NL_PLAYERCLASS == "Rogue" ) then
			return;
		end

		spellName = NL_ENCHANT_SPELLS[NL_PLAYERCLASS][needName][clickIndex];
		spellRanks = NL_ENCHANT_SPELLS[NL_PLAYERCLASS][needName].Ranks;
		spellCanTargetEnemy = NL_ENCHANT_SPELLS[NL_PLAYERCLASS][needName].CanTargetEnemy;
	elseif( needName == "Health" ) then
		if( NLConfig.HealSpells ) then
			spellName = NLConfig.HealSpells[clickIndex];
		end
	elseif( needName == "Mana" ) then
		spellName = "Innervate";
	end

	if( spellName ) then
		local hadTarget = false;

		-- cast pet spells here
		-- fire shield seems unique in that it requires your target to actually change
		-- most other spells don't require a target to start casting
		-- therefore Fire Shield is the only spell that will not add units to the blacklist
		if( spellName == "Fire Shield" ) then
			local switchedTarget = false;
			local targetWasEnemy = false;
			local friendlyTargetName = "";
			if( UnitExists( "target" ) ) then
				hadTarget = true;
			end

			if( UnitIsEnemy( "player", "target" ) ) then
				targetWasEnemy = true;
			else
				friendlyTargetName = UnitName("target");
			end
			TargetUnit( unit );
			switchedTarget = true;
			-- find the action on the pet bar that matches this spell name
			NL_ITERATOR = 1;
			while( spellName ~= GetPetActionInfo(NL_ITERATOR) and NL_ITERATOR < 12 ) do
				NL_ITERATOR = NL_ITERATOR + 1;
			end

			if( spellName == GetPetActionInfo(NL_ITERATOR) ) then
				CastPetAction(NL_ITERATOR);
			end

			if( hadTarget == false ) then
				ClearTarget();
			elseif( switchedTarget ) then
				if( targetWasEnemy ) then
					TargetLastEnemy();
				else
					TargetByName(friendlyTargetName);
				end
			end
		-- cast the highest ranked spell based on player level
		elseif( string.sub( spellName, 0, 1 ) ~= "[" ) then
			-- if the unit is not already the target
			-- AND
			-- if the spell needs a target
			-- and the player has a target
			-- and
				-- the spell can target enemies OR (the spell can't target the enemy AND the target is friendly)
			-- Clear the target
			if( unit ~= "target" and (not spellNeedsNoTarget and UnitExists( "target" ) and (spellCanTargetEnemy or (not spellCanTargetEnemy and UnitIsFriend("player","target"))))) then
				hadTarget = true;
				ClearTarget();
			end
			
			-- figure out the rank of the spell to cast based on level
			if( not spellNeedsNoTarget ) then
				if( spellRanks ) then
					local validRank = NL_GetMaxRankPlayerCanCast( spellName );
					if( validRank ) then
						local allowedRank = validRank;
						if( isBuff ) then
							allowedRank = NL_GetMaxRankUnitCanReceive( spellRanks, UnitLevel(unit) );
						end
						if( validRank > 0 and allowedRank > 0 ) then
							-- cast the maximum rank of this spell
							CastSpellByName( spellName .. "("..NL_LANG_RANK.." " .. min(validRank,allowedRank) .. ")" );
						end
					else
						CastSpellByName( spellName );
					end
				else
					CastSpellByName( spellName );
				end
			else
				-- the spell needs no target, so just cast it.  The game will find the correct rank to cast.
				CastSpellByName( spellName );
			end
		else
			if( unit ~= "target" and UnitExists( "target" ) and UnitIsFriend("player","target")) then
				hadTarget = true;
				ClearTarget();
			end

			local bagNum, slotNum;
			local done = false;
			for bagNum = 0, NUM_BAG_FRAMES do
				local numSlots = GetContainerNumSlots(bagNum);
				for slotNum = 1, numSlots do
					local itemLink = GetContainerItemLink(bagNum, slotNum);
					local itemName = string.sub(spellName, 2, string.len(spellName) - 1);
					if( itemLink and string.find(itemLink, itemName) ) then
						UseContainerItem(bagNum, slotNum);
						done = true;
						break;
					end
				end
				if( done ) then
					break;
				end
			end
		end

		if( not spellNeedsNoTarget ) then
			if ( SpellIsTargeting() ) then
				if( SpellCanTargetUnit(unit) ) then
					-- message the person we're casting on, if notifications are enabled
					if( NLConfig.SpellNotify == 1 ) then
						SendChatMessage( "I'm casting "..spellName.." on you.", "WHISPER", this.language, UnitName(unit) );
					end
					SpellTargetUnit(unit);
				else
					-- blacklist the unit, so they drop to the end of the list for however long the 'out of range' timer is set for
					-- for now, remove them from the list and set a timer on them
					SpellStopTargeting();
					-- ONLY if the unit isn't stickied and the blacklist delay is above 0
					if( getglobal("NLMember"..unit).TopNeed ~= 1 and NLConfig.BlackListDelay > 0 ) then
						NLBlacklistUnit( unit );
					end
				end
			end

			if( hadTarget == true ) then
				TargetLastTarget();
			end
		end
	end
end

function NL_PulloutIfInvisible( unit )
	-- previous frame won't be nil on a frame that has been removed already but not pulled out
	if( getglobal( "NLMember"..unit ).PendingRemoval ) then
		NL_RemoveFromList( unit );
		getglobal( "NLMember"..unit ).PendingRemoval = false;
	end
end

function NL_PulloutAllInvisibleFrames()
	if( GetNumRaidMembers() > 0 ) then
		-- iterate through all frames
		for NL_ITERATOR = 1, 40 do
			NL_PulloutIfInvisible( "raid" .. NL_ITERATOR );
			NL_PulloutIfInvisible( "raidpet" .. NL_ITERATOR );
		end
	else
		-- iterate through all frames
		NL_PulloutIfInvisible( "player" );
		NL_PulloutIfInvisible( "pet" );

		for NL_ITERATOR = 1, 4 do
			NL_PulloutIfInvisible( "party" .. NL_ITERATOR );
			NL_PulloutIfInvisible( "partypet" .. NL_ITERATOR );
		end
	end
end

function NL_ResortSingleUnit( unit )
	if( not UnitExists(unit) ) then
		return;
	end

	-- if the frame has a slot index it has a need
	if( getglobal("NLMember"..unit).SlotIndex ) then
		getglobal("NLMember"..unit).SlotIndex = nil;
		if( getglobal("NLMember"..unit).TopNeed ) then
			NL_AddToList(unit);
		end
	end
end

function NL_SortAllVisibleFrames()
	NL_NUM_NEEDY_UNITS = 0;
	NL_SLOTS = {};
	
	if( GetNumRaidMembers() > 0 ) then
		-- iterate through all frames
		for NL_ITERATOR = 1, 40 do
			NL_ResortSingleUnit( "raid" .. NL_ITERATOR );
			NL_ResortSingleUnit( "raidpet" .. NL_ITERATOR );
		end
	else
		-- iterate through all frames
		NL_ResortSingleUnit( "player" );
		NL_ResortSingleUnit( "pet" );

		for NL_ITERATOR = 1, 4 do
			NL_ResortSingleUnit( "party" .. NL_ITERATOR );
			NL_ResortSingleUnit( "partypet" .. NL_ITERATOR );
		end
	end
end

function NL_OnUpdate( elapsed )
	if( not NL_MOUSE_IN_FRAME and not NL_LIST_IS_SORTED ) then
		-- do a generic sort of all visible units
		if( NLConfig.AutoSort == 1 ) then
			NL_PulloutAllInvisibleFrames();
			NL_SortAllVisibleFrames();
		else
			NL_PulloutAllInvisibleFrames();
		end

		NL_LIST_IS_SORTED = true;
	end

	NL_ITERATOR = 1;
	while( NL_BLACK_LIST[NL_ITERATOR] ) do
		NL_BLACK_LIST[NL_ITERATOR].Time = NL_BLACK_LIST[NL_ITERATOR].Time - elapsed;

		if( NL_BLACK_LIST[NL_ITERATOR].Time <= 0 ) then
			-- check needs and remove this unit from the blacklist
			local member = NL_BLACK_LIST[NL_ITERATOR].Unit;
			table.remove(NL_BLACK_LIST, NL_ITERATOR);
			NL_CheckAllNeeds( member );
		else
			NL_ITERATOR = NL_ITERATOR + 1;
		end
	end
end

function NL_FindInBuffList( needName, buffList )
	if( NL_BUFF_SPELLS[ NL_PLAYERCLASS ] ) then
		if( NL_BUFF_SPELLS[ NL_PLAYERCLASS ][needName] ) then
			if( NL_BUFF_SPELLS[ NL_PLAYERCLASS ][needName].Icons[1] and buffList[NL_ICON_LOCATION..NL_BUFF_SPELLS[ NL_PLAYERCLASS ][needName].Icons[1]] ) then
				return true;
			elseif( NL_BUFF_SPELLS[ NL_PLAYERCLASS ][needName].Icons[2] and buffList[NL_ICON_LOCATION..NL_BUFF_SPELLS[ NL_PLAYERCLASS ][needName].Icons[2]] ) then
				return true;
			end
		end
	end

	return false;
end

function NL_AddToList(member)
	if( not UnitExists(member) or UnitName(member) == nil or UnitName(member) == "" or UnitName(member) == "Unknown Entity" ) then
		NL_RemoveFromList(member);
		return nil;
	end
	
	getglobal("NLMember"..member.."Name"):SetText( string.sub(UnitName(member),1,NLConfig.FrameWidth/8) );
	local frame = getglobal("NLMember"..member);

	if( frame.TopNeed == nil ) then
		return;
	end

	if( frame.PendingRemoval ) then
		frame.PendingRemoval = false;
		frame:Show();
	end

	if( NLConfig.ColorByClass == 1 ) then
		local class = "";
		if( string.find( member, "pet" ) ~= nil ) then
			class = UnitCreatureType(member);
		else
			class = UnitClass(member);
		end
		
		if( NL_CLASS_COLORS[class] ) then
			frame:SetBackdropColor(NL_CLASS_COLORS[class].r, NL_CLASS_COLORS[class].g, NL_CLASS_COLORS[class].b, 1);
		else
			frame:SetBackdropColor(NL_CLASS_COLORS["Default"].r, NL_CLASS_COLORS["Default"].g, NL_CLASS_COLORS["Default"].b, 1);
		end
	elseif( NLConfig.Needs[frame.TopNeed] ~= nil ) then
		frame:SetBackdropColor(NLConfig.Needs[frame.TopNeed].BGColor.r, NLConfig.Needs[frame.TopNeed].BGColor.g, NLConfig.Needs[frame.TopNeed].BGColor.b, 0.8);
	end

	-- target has special treatment, as it should not be in the list
	if( member == "target" ) then
		frame:Show();
		return frame;
	end
	
	if( not frame.SlotIndex ) then
		frame.SlotIndex = NL_NUM_NEEDY_UNITS;
		NL_SLOTS[NL_NUM_NEEDY_UNITS] = frame;
		NL_NUM_NEEDY_UNITS = NL_NUM_NEEDY_UNITS + 1;
		NLAnchorFrame( frame );
	end

	if( NLConfig.AutoSort == 1 and not NL_MOUSE_IN_FRAME ) then
		NLSortFrameIntoList(frame);
	end

	if( NL_MINIMIZED ) then
		NLHeaderMinimized:Show();
	else
		NLHeader:Show();
	end

	return frame;
end

function NLAnchorFrame( frame )
	if( frame ~= NL_SLOTS[frame.SlotIndex] ) then
		NLBlacklistUnit(frame.Unit);
	end
	
	if( frame.SlotIndex < NLConfig.MaxUnits ) then
		if( not frame:IsShown() ) then
			-- draw the details of the frame, because it's now being made visible
			frame:Show();
		end
		frame:ClearAllPoints();
		frame:SetPoint( NLAnchors[NLConfig.InvertList+1].AnchorPoint, NLHeader, NLAnchors[NLConfig.InvertList+1].ReferenceAnchorPoint, 0, NLAnchors[NLConfig.InvertList+1].Offset * (frame:GetHeight() - 5) * frame.SlotIndex - (5 * NLAnchors[NLConfig.InvertList+1].Offset) );
	else
		frame:Hide();
	end
end

function NLBlacklistUnit( unit )
	NL_RemoveFromList(unit);
	local newBlackListItem = {};
	newBlackListItem.Unit = unit;
	newBlackListItem.Time = NLConfig.BlackListDelay;
	table.insert(NL_BLACK_LIST, newBlackListItem);
end

function NLSortFrameDown( frame )
	local nextFrame = nil;
	while( frame.SlotIndex < NL_NUM_NEEDY_UNITS - 1 and NL_SLOTS[frame.SlotIndex+1] and NL_SLOTS[frame.SlotIndex+1].Unit and not NL_SLOTS[frame.SlotIndex+1].TopNeed ) do
		NL_DebugMsg("Removing " .. NL_SLOTS[frame.SlotIndex+1].Unit .. " from list because its TopNeed is nil");
		NL_RemoveFromList(NL_SLOTS[frame.SlotIndex+1].Unit);
		-- at this point, the removed frame should shift the rest up, and this frame can still be sorted downward
	end
	while( frame.SlotIndex < NL_NUM_NEEDY_UNITS - 1 and ( NL_SLOTS[frame.SlotIndex].TopNeed > NL_SLOTS[frame.SlotIndex+1].TopNeed 
		or (NL_SLOTS[frame.SlotIndex].TopNeed == NL_SLOTS[frame.SlotIndex+1].TopNeed and 
		( ( NL_SLOTS[frame.SlotIndex].TopNeed == NLConfig.HealthNeedIndex and NL_SLOTS[frame.SlotIndex].CurrentHealth > NL_SLOTS[frame.SlotIndex+1].CurrentHealth ) or
		( ( NLConfig.ManaNeedIndex and NL_SLOTS[frame.SlotIndex].TopNeed == NLConfig.ManaNeedIndex and NL_SLOTS[frame.SlotIndex].CurrentMana > NL_SLOTS[frame.SlotIndex+1].CurrentMana ) ) ) ) ) ) do
		nextFrame = NL_SLOTS[frame.SlotIndex+1];
		nextFrame.SlotIndex = frame.SlotIndex;
		frame.SlotIndex = frame.SlotIndex + 1;
		NL_SLOTS[frame.SlotIndex] = frame;
		NL_SLOTS[nextFrame.SlotIndex] = nextFrame;

		NLAnchorFrame( frame );
		NLAnchorFrame( nextFrame );

		if( frame.SlotIndex < NL_NUM_NEEDY_UNITS - 1 and NL_SLOTS[frame.SlotIndex+1] and NL_SLOTS[frame.SlotIndex+1].Unit and not NL_SLOTS[frame.SlotIndex+1].TopNeed ) then
			NL_DebugMsg("Removing " .. NL_SLOTS[frame.SlotIndex+1].Unit .. " from list because its TopNeed is nil");
			NL_RemoveFromList(NL_SLOTS[frame.SlotIndex+1].Unit);
			-- at this point, the removed frame should shift the rest up, and this frame can still be sorted downward
		end
	end
end

function NLSortFrameUp( frame )
	local previousFrame = nil;
	while( frame.SlotIndex > 0 and NL_SLOTS[frame.SlotIndex-1] and NL_SLOTS[frame.SlotIndex-1].Unit and not NL_SLOTS[frame.SlotIndex-1].TopNeed ) do
		NL_DebugMsg("Removing " .. NL_SLOTS[frame.SlotIndex-1].Unit .. " from list because its TopNeed is nil");
		NL_RemoveFromList(NL_SLOTS[frame.SlotIndex-1].Unit);
		-- at this point, the removed frame should shift the rest up, and this frame can still be sorted upward
	end
	while( frame.SlotIndex > 0 and ( NL_SLOTS[frame.SlotIndex].TopNeed < NL_SLOTS[frame.SlotIndex-1].TopNeed 
		or (NL_SLOTS[frame.SlotIndex].TopNeed == NL_SLOTS[frame.SlotIndex-1].TopNeed and 
		( ( NL_SLOTS[frame.SlotIndex].TopNeed == NLConfig.HealthNeedIndex and NL_SLOTS[frame.SlotIndex].CurrentHealth < NL_SLOTS[frame.SlotIndex-1].CurrentHealth ) or
		( NLConfig.ManaNeedIndex and NL_SLOTS[frame.SlotIndex].TopNeed == NLConfig.ManaNeedIndex and NL_SLOTS[frame.SlotIndex].CurrentMana < NL_SLOTS[frame.SlotIndex-1].CurrentMana ) ) ) ) ) do
		previousFrame = NL_SLOTS[frame.SlotIndex-1];
		previousFrame.SlotIndex = frame.SlotIndex;
		frame.SlotIndex = frame.SlotIndex - 1;
		NL_SLOTS[frame.SlotIndex] = frame;
		NL_SLOTS[previousFrame.SlotIndex] = previousFrame;

		NLAnchorFrame( frame );
		NLAnchorFrame( previousFrame );
		
		if( frame.SlotIndex > 0 and NL_SLOTS[frame.SlotIndex-1] and NL_SLOTS[frame.SlotIndex-1].Unit and not NL_SLOTS[frame.SlotIndex-1].TopNeed ) then
			NL_DebugMsg("Removing " .. NL_SLOTS[frame.SlotIndex-1].Unit .. " from list because its TopNeed is nil");
			NL_RemoveFromList(NL_SLOTS[frame.SlotIndex-1].Unit);
			-- at this point, the removed frame should shift the rest up, and this frame can still be sorted upward
		end
	end
end

function NLSortFrameIntoList(frame)
	NLSortFrameUp( frame );
	NLSortFrameDown( frame );
end

function NLShiftRemainingUp( index )
	while( index < NL_NUM_NEEDY_UNITS - 1 ) do
		NL_SLOTS[index] = NL_SLOTS[index+1];
		NL_SLOTS[index].SlotIndex = index;

		NLAnchorFrame( NL_SLOTS[index] );
		
		index = index + 1;
	end
end

function NL_RemoveFromList(member)
	-- sort to bottom of list (so all other units shift up)
	if( not member ) then
		return;
	end
	
	local frame = getglobal("NLMember"..member);

	-- target has special treatment, as it should not be in the list
	if( member == "target" ) then
		frame:Hide();
		return;
	end
	
	if( NL_MOUSE_IN_FRAME ) then
		frame.PendingRemoval = true;
		frame:Hide();
		return;
	end

	if( frame.SlotIndex ) then
		NL_SLOTS[frame.SlotIndex] = nil;
		frame:Hide();
		NLShiftRemainingUp( frame.SlotIndex );
		NL_NUM_NEEDY_UNITS = NL_NUM_NEEDY_UNITS - 1;
		frame.SlotIndex = nil;
		frame.TopNeed = nil;
	end

	if( NLConfig.HideHeader == 1 and NL_NUM_NEEDY_UNITS == 0 ) then
		NLHeader:Hide();
		NLHeaderMinimized:Hide();
	end
end

function NL_MouseEnteredFrame()
	NL_MOUSE_IN_FRAME = true;
	NL_LIST_IS_SORTED = false;
end

function NL_MouseLeftFrame()
	NL_MOUSE_IN_FRAME = false;
end

function NL_UpdateUnit(id)
	NL_UpdateNeeds( id );
	local frame = "NLMember" .. id;
	if( NLConfig.ShowHealthNum == 1 ) then
		if( NLConfig.ShowHealthLost == 1 ) then
			getglobal(frame .. "HealthNum"):SetText(UnitHealth(id)-UnitHealthMax(id));
		else
			getglobal(frame .. "HealthNum"):SetText(UnitHealth(id) .. "/" .. UnitHealthMax(id));
		end
		getglobal(frame .. "HealthNum"):Show();
	elseif( getglobal(frame .. "HealthNum"):IsShown() ) then
		getglobal(frame .. "HealthNum"):Hide();
	end

	if( UnitIsDead(id) or UnitIsGhost(id) or UnitHealth(id) == 0 ) then
		getglobal(frame .. "HPBar"):Hide();
		getglobal(frame .. "MPBar"):Hide();
		if( NLConfig.ShowHealth == 1 or NLConfig.ShowMana == 1 ) then
			if( UnitIsGhost(id) ) then
				getglobal(frame .. "Status"):SetText("Ghost");
			elseif( UnitIsDead(id) or UnitHealth(id) == 0 ) then
				getglobal(frame .. "Status"):SetText("Dead");
			end
			getglobal(frame .. "Status"):Show();
		end
		return;
	else
		getglobal(frame .. "Status"):Hide();
		if( NLConfig.ShowHealth == 1 ) then
			getglobal(frame .. "HPBar"):Show();
		else
			getglobal(frame .. "HPBar"):Hide();
		end
		-- determine the color for the power bar
		local info = ManaBarColor[UnitPowerType(id)];
		getglobal(frame .. "MPBar"):SetStatusBarColor(info.r, info.g, info.b);
		if( NLConfig.ShowMana == 1 ) then
			getglobal(frame .. "MPBar"):Show();
		else
			getglobal(frame .. "MPBar"):Hide();
		end
	end

	-- set the name in the frame
	if( getglobal(frame).CurrentHealth ) then
		local percent = floor(getglobal(frame).CurrentHealth);
		if ( percent and percent > 0 ) then
			if ( percent > 100 ) then
				percent = 100;
			end
			getglobal(frame .. "HPBar"):SetValue(percent);
			local hppercent = percent/100;
			local r, g;
			if ( hppercent > 0.5 and hppercent <= 1) then
				g = 1;
				r = (1.0 - hppercent) * 2;
			elseif ( hppercent >= 0 and hppercent <= 0.5 ) then
				r = 1.0;
				g = hppercent * 2;
			else
				r = 0;
				g = 1;
			end
			getglobal(frame .. "HPBar"):SetStatusBarColor(r, g, 0);
		end
	end

	-- get the class of the player and update the mana bar appropriately
	if( UnitManaMax(id) == 0 ) then
		getglobal(frame .. "MPBar"):SetValue(0);
	else
		if( getglobal(frame).CurrentMana ) then
			local percent = floor(getglobal(frame).CurrentMana);
			getglobal(frame .. "MPBar"):SetValue(percent);
		end
	end
end

function NL_UpdateAura( unit )
	if( not UnitExists(unit) ) then
		return;
	end

	local frame = "NLMember" .. unit;

	if( NLConfig.ShowBuffs == 0 and NLConfig.ShowHealBuffs == 0 ) then
		getglobal(frame .. "BuffsDetails"):SetWidth( 5 );
		getglobal(frame .. "BuffsDetails"):Hide();
	else
		local buff;
		local numBuffs = 0;
		local index = 1;
		for NL_ITERATOR=1, NL_MAX_TOOLTIP_BUFFS do
			buff = UnitBuff(unit, NL_ITERATOR);
			if ( buff and (NLConfig.ShowBuffs == 1 or (NLConfig.ShowHealBuffs == 1 and 
				(buff == NL_ICON_LOCATION .. "Spell_Nature_Rejuvenation" or
				buff == NL_ICON_LOCATION .. "Spell_Nature_ResistNature" or
				buff == NL_ICON_LOCATION .. "Spell_Holy_Renew" )
				) ) ) then
				getglobal(frame .. "BuffsDetailsBuff"..index):SetNormalTexture(buff);
				getglobal(frame .. "BuffsDetailsBuff"..index):Show();
				getglobal(frame .. "BuffsDetailsBuff"..index):SetID(index);
				if( getglobal(frame .. "BuffsDetailsBuff"..index) == NL_MOUSE_OVER_FRAME ) then
					GameTooltip:SetUnitBuff( getglobal(frame).Unit, NL_ITERATOR );
				end
				index = index + 1;
				numBuffs = numBuffs + 1;
			end
		end
		for NL_ITERATOR=index, NL_MAX_TOOLTIP_BUFFS do
			getglobal(frame .. "BuffsDetailsBuff"..NL_ITERATOR):Hide();
		end
	
		getglobal(frame .. "BuffsDetailsBuff1"):ClearAllPoints();
		getglobal(frame .. "BuffsDetailsBuff1"):SetPoint( "TOPLEFT", frame .. "BuffsDetails", "TOPLEFT", 5, -5 );
		getglobal(frame .. "BuffsDetails"):SetHeight( 26 );
		-- Size the tooltip
		if ( numBuffs > 0 ) then
			getglobal(frame .. "BuffsDetails"):SetWidth( (numBuffs * 17) + 9 );
			getglobal(frame .. "BuffsDetails"):Show();
		else
			getglobal(frame .. "BuffsDetails"):SetWidth( 5 );
			getglobal(frame .. "BuffsDetails"):Hide();
		end
	end

	if( NLConfig.ShowDebuffs == 0 ) then
		getglobal(frame .. "DebuffsDetails"):SetWidth( 5 );
		getglobal(frame .. "DebuffsDetails"):Hide();
	else
		local buff;
		local numDebuffs = 0;
		local index = 1;
		for NL_ITERATOR=1, NL_MAX_TOOLTIP_DEBUFFS do
			buff = UnitDebuff(unit, NL_ITERATOR);
			
			if ( buff ) then
				getglobal(frame .. "DebuffsDetailsDebuff"..index):SetNormalTexture(buff);
				getglobal(frame .. "DebuffsDetailsDebuff"..index):Show();
				getglobal(frame .. "DebuffsDetailsDebuff"..index):SetID(index);
				if( getglobal(frame .. "DebuffsDetailsDebuff"..index) == NL_MOUSE_OVER_FRAME ) then
					GameTooltip:SetUnitDebuff( getglobal(frame).Unit, NL_ITERATOR );
				end
				index = index + 1;
				numDebuffs = numDebuffs + 1;
			end
		end
		for NL_ITERATOR=index, NL_MAX_TOOLTIP_DEBUFFS do
			getglobal(frame .. "DebuffsDetailsDebuff"..NL_ITERATOR):Hide();
		end
	
		getglobal(frame .. "DebuffsDetailsDebuff1"):ClearAllPoints();
		getglobal(frame .. "DebuffsDetailsDebuff1"):SetPoint( "TOPLEFT", frame .. "DebuffsDetails", "TOPLEFT", 5, -5 );
		getglobal(frame .. "DebuffsDetails"):SetHeight( 26 );
		-- Size the tooltip
		if ( numDebuffs > 0 ) then
			getglobal(frame .. "DebuffsDetails"):SetWidth( (numDebuffs * 17) + 9 );
			getglobal(frame .. "DebuffsDetails"):Show();
		else
			getglobal(frame .. "DebuffsDetails"):SetWidth( 5 );
			getglobal(frame .. "DebuffsDetails"):Hide();
		end
	end
end

function NL_UpdateNeeds( member )
	local frame = getglobal( "NLMember"..member );
	if( not frame or not frame.TopNeed or frame.TopNeed < 1 or NLConfig.ShowNeeds == 0 ) then
		NL_ClearNeedDetails( member );
		return;
	end

	local needFrameIndex = 1;
	
	-- if resurrection is a need of this unit
	if( frame.Needs[NLConfig.ResurrectionNeedIndex] ) then
		if( NL_CURE_SPELLS[NL_PLAYERCLASS] and NL_CURE_SPELLS[NL_PLAYERCLASS].Resurrection ) then
			iconName = NL_CURE_SPELLS[NL_PLAYERCLASS].Resurrection.Icon;
			if( iconName ~= "" ) then
				local needFrame = getglobal(frame:GetName() .. "NeedsDetailsNeed"..needFrameIndex);
				if( NLConfig.LargeNeedIcons == 1 ) then
					getglobal(frame:GetName() .. "NeedsDetailsNeed"..needFrameIndex):SetWidth( 22 );
					getglobal(frame:GetName() .. "NeedsDetailsNeed"..needFrameIndex):SetHeight( 22 );
				else
					getglobal(frame:GetName() .. "NeedsDetailsNeed"..needFrameIndex):SetWidth( 16 );
					getglobal(frame:GetName() .. "NeedsDetailsNeed"..needFrameIndex):SetHeight( 16 );
				end
				needFrame:SetNormalTexture(NL_ICON_LOCATION .. iconName);
				needFrame.NeedName = "Resurrection";
				needFrame:Show();
				if( needFrame == NL_MOUSE_OVER_FRAME ) then
					NL_MouseOverNeedButton(needFrame);
				end
				needFrameIndex = needFrameIndex + 1;
			end
		end
	else
		for NL_ITERATOR=2, NLConfig.NumNeeds - 1 do
			local iconName = "";
			if( frame.Needs[NL_ITERATOR] ) then
				if( NL_BUFF_SPELLS[NL_PLAYERCLASS] and NL_BUFF_SPELLS[NL_PLAYERCLASS][NLConfig.Needs[NL_ITERATOR].Name] ) then
					iconName = NL_BUFF_SPELLS[NL_PLAYERCLASS][NLConfig.Needs[NL_ITERATOR].Name].Icons[1];
				elseif( NL_CURE_SPELLS[NL_PLAYERCLASS] and NL_CURE_SPELLS[NL_PLAYERCLASS][NLConfig.Needs[NL_ITERATOR].Name] ) then
					iconName = NL_CURE_SPELLS[NL_PLAYERCLASS][NLConfig.Needs[NL_ITERATOR].Name].Icon;
				elseif( NL_ENCHANT_SPELLS[NL_PLAYERCLASS] and NL_ENCHANT_SPELLS[NL_PLAYERCLASS][NLConfig.Needs[NL_ITERATOR].Name] ) then
					iconName = NL_ENCHANT_SPELLS[NL_PLAYERCLASS][NLConfig.Needs[NL_ITERATOR].Name].Icon;
				elseif( NL_OTHER[NLConfig.Needs[NL_ITERATOR].Name] ) then
					iconName = NL_OTHER[NLConfig.Needs[NL_ITERATOR].Name].Icon;
				end
	
				if( iconName ~= "" ) then
					local needFrame = getglobal(frame:GetName() .. "NeedsDetailsNeed"..needFrameIndex);
					if( NLConfig.LargeNeedIcons == 1 ) then
						getglobal(frame:GetName() .. "NeedsDetailsNeed"..needFrameIndex):SetWidth( 22 );
						getglobal(frame:GetName() .. "NeedsDetailsNeed"..needFrameIndex):SetHeight( 22 );
					else
						getglobal(frame:GetName() .. "NeedsDetailsNeed"..needFrameIndex):SetWidth( 16 );
						getglobal(frame:GetName() .. "NeedsDetailsNeed"..needFrameIndex):SetHeight( 16 );
					end
					needFrame:SetNormalTexture(NL_ICON_LOCATION .. iconName);
					needFrame.NeedName = NLConfig.Needs[NL_ITERATOR].Name;
					needFrame:Show();
					if( needFrame == NL_MOUSE_OVER_FRAME ) then
						NL_MouseOverNeedButton(needFrame);
					end
					needFrameIndex = needFrameIndex + 1;
					if( needFrameIndex > NL_MAX_NEEDS ) then
						-- this is a break condition, we don't need to see more needs
						NL_ITERATOR = NLConfig.NumNeeds;
					end
				end
			end
		end
	end

	local needCount = needFrameIndex - 1;
	
	for NL_ITERATOR=needFrameIndex, NL_MAX_NEEDS - 1 do
		getglobal(frame:GetName() .. "NeedsDetailsNeed"..NL_ITERATOR):Hide();
	end

	if( NLConfig.LargeNeedIcons == 1 ) then
		getglobal(frame:GetName() .. "NeedsDetails"):SetWidth( needCount * 23 + 9 );
		getglobal(frame:GetName() .. "NeedsDetails"):SetHeight( 32 );
	else
		getglobal(frame:GetName() .. "NeedsDetails"):SetWidth( needCount * 17 + 9 );
		getglobal(frame:GetName() .. "NeedsDetails"):SetHeight( 26 );
	end
	getglobal(frame:GetName() .. "NeedsDetailsNeed1"):ClearAllPoints();
	getglobal(frame:GetName() .. "NeedsDetailsNeed1"):SetPoint( "TOPLEFT", frame:GetName() .. "NeedsDetails", "TOPLEFT", 5, -5 );
	if( needCount > 0 ) then
		getglobal(frame:GetName() .. "NeedsDetails"):Show();
	else
		getglobal(frame:GetName() .. "NeedsDetails"):Hide();
	end
end

function NL_SetTooltipOwner( frame, anchor )
	if( NLConfig.ShowTooltips == 1 ) then
		GameTooltip:SetOwner(frame, anchor);
	else
		GameTooltip:Hide();
	end
end

function NLMember_OnEnter(frame)
	NL_SetTooltipOwner( frame, "ANCHOR_TOPLEFT" );
	GameTooltip:SetUnit( frame.Unit );
end

function NLMember_OnLeave(frame)
	GameTooltip:Hide();
end

function NLMember_OnClick(button, frame)
	if( NLConfig.UseCastParty == 1 and CastParty_OnClickByUnit ~= nil ) then
		CastParty_OnClickByUnit( button, frame.Unit );
	else
		if ( button == "LeftButton" ) then
			-- determine which unit was clicked
			if ( SpellIsTargeting() ) then
				SpellTargetUnit(frame.Unit);
			elseif ( CursorHasItem() ) then
				DropItemOnUnit(frame.Unit);
			else
				TargetUnit(frame.Unit);
			end
		else
			if( SpellIsTargeting() ) then
				SpellStopTargeting();
				return;
			end
		end
	end
end

function NLMember_CheckAllUnits()
	NL_NUM_NEEDY_UNITS = 0;
	if( NLConfig.HideHeader == 1 ) then
		NLHeader:Hide();
	end
	
	NL_SLOTS = {};

	-- hide all frames
	NLMemberplayer:Hide();
	NLMemberplayer.SlotIndex = nil;
	NLMemberplayer.TopNeed = nil;
	NLMemberplayer.Needs = {};
	NLMemberpet:Hide();
	NLMemberpet.SlotIndex = nil;
	NLMemberpet.TopNeed = nil;
	NLMemberpet.Needs = {};

	for NL_ITERATOR = 1, 4 do
		getglobal("NLMemberparty"..NL_ITERATOR):Hide();
		getglobal("NLMemberparty"..NL_ITERATOR).SlotIndex = nil;
		getglobal("NLMemberparty"..NL_ITERATOR).TopNeed = nil;
		getglobal("NLMemberparty"..NL_ITERATOR).Needs = {};
		getglobal("NLMemberpartypet"..NL_ITERATOR):Hide();
		getglobal("NLMemberpartypet"..NL_ITERATOR).SlotIndex = nil;
		getglobal("NLMemberpartypet"..NL_ITERATOR).TopNeed = nil;
		getglobal("NLMemberpartypet"..NL_ITERATOR).Needs = {};
	end
	for NL_ITERATOR = 1, 40 do
		getglobal("NLMemberraid"..NL_ITERATOR):Hide();
		getglobal("NLMemberraid"..NL_ITERATOR).SlotIndex = nil;
		getglobal("NLMemberraid"..NL_ITERATOR).TopNeed = nil;
		getglobal("NLMemberraid"..NL_ITERATOR).Needs = {};
		getglobal("NLMemberraidpet"..NL_ITERATOR):Hide();
		getglobal("NLMemberraidpet"..NL_ITERATOR).SlotIndex = nil;
		getglobal("NLMemberraidpet"..NL_ITERATOR).TopNeed = nil;
		getglobal("NLMemberraidpet"..NL_ITERATOR).Needs = {};
	end
	
	-- if player in a raid, check all 40 units, otherwise just check player and party
	if( GetNumRaidMembers() > 0 ) then
		for NL_ITERATOR = 1, 40 do
			if( UnitExists( "raid" .. NL_ITERATOR ) ) then
				NL_CheckAllNeeds( "raid" .. NL_ITERATOR );
				if( UnitExists( "raidpet" .. NL_ITERATOR ) ) then
					NL_CheckAllNeeds( "raidpet" .. NL_ITERATOR );
				end
			end
		end
	else
		if( UnitExists( "player" ) ) then
			NL_CheckAllNeeds( "player" );
			if( UnitExists( "pet" ) ) then
				NL_CheckAllNeeds( "pet" );
			end
		end

		for NL_ITERATOR = 1, 4 do
			if( UnitExists( "party" .. NL_ITERATOR ) ) then
				NL_CheckAllNeeds( "party" .. NL_ITERATOR );
				if( UnitExists( "partypet" .. NL_ITERATOR ) ) then
					NL_CheckAllNeeds( "partypet" .. NL_ITERATOR );
				end
			end
		end
	end

	NL_CheckTarget();
end

function NL_CheckTarget()
	NLMembertarget.Needs = {};
	NLMembertarget.TopNeed = nil;
	NLMembertarget:Hide();

	if( NLConfig.ShowTargetFrame == 1 ) then
		if( UnitExists( "target" ) and UnitIsFriend( "target", "player" ) ) then
			NL_CheckAllNeeds( "target" );
		else
			NLMembertarget:Hide();
		end
	end
end

function NL_MouseOverNeedButton(frame)
	NL_SetTooltipOwner(frame:GetParent():GetParent(), "ANCHOR_TOPLEFT");
	local tooltipText = "";
	if( NL_BUFF_SPELLS[NL_PLAYERCLASS] and NL_BUFF_SPELLS[NL_PLAYERCLASS][frame.NeedName] and NL_BUFF_SPELLS[NL_PLAYERCLASS][frame.NeedName][1] ) then
		if( NL_BUFF_SPELLS[NL_PLAYERCLASS] and NL_BUFF_SPELLS[NL_PLAYERCLASS][frame.NeedName] ) then
			if( NL_BUFF_SPELLS[NL_PLAYERCLASS][frame.NeedName][1] ) then
				tooltipText = "Left-click to cast " .. NL_BUFF_SPELLS[NL_PLAYERCLASS][frame.NeedName][1] .. ".";
			end
			if( NL_BUFF_SPELLS[NL_PLAYERCLASS][frame.NeedName][2] ) then
				tooltipText = tooltipText .. "\nRight-click to cast " .. NL_BUFF_SPELLS[NL_PLAYERCLASS][frame.NeedName][2] .. ".";
			end
		end
	elseif( NL_ENCHANT_SPELLS[NL_PLAYERCLASS] and NL_ENCHANT_SPELLS[NL_PLAYERCLASS][frame.NeedName] and NL_ENCHANT_SPELLS[NL_PLAYERCLASS][frame.NeedName][1] ) then
		if( NL_PLAYERCLASS == "Rogue" ) then
			tooltipText =  "Needs " .. NL_ENCHANT_SPELLS[NL_PLAYERCLASS][frame.NeedName][1] .. ".";
		else
			tooltipText = "Needs " .. NL_ENCHANT_SPELLS[NL_PLAYERCLASS][frame.NeedName][1] .. ".\nClick here to fix.";
		end
	elseif( frame.NeedName == "Resurrection" ) then
		if( NL_CURE_SPELLS[NL_PLAYERCLASS] and NL_CURE_SPELLS[NL_PLAYERCLASS].Resurrection ) then
			tooltipText = "Left-click to cast " .. NL_CURE_SPELLS[NL_PLAYERCLASS].Resurrection[1] .. ".";
		end
	elseif( frame.NeedName == "WellFed" ) then
		tooltipText = "Needs to be well fed.";
	elseif( frame.NeedName == "Health" ) then
		tooltipText = "Needs healing.";
		if( NLConfig.HealSpells ) then
			if( NLConfig.HealSpells[1] ) then
				tooltipText = tooltipText .. "\nLeft-click to cast " .. NLConfig.HealSpells[1] .. ".";
			end
			if( NLConfig.HealSpells[2] ) then
				tooltipText = tooltipText .. "\nRight-click to cast " .. NLConfig.HealSpells[2] .. ".";
			end
			if( NLConfig.HealSpells[3] ) then
				tooltipText = tooltipText .. "\nMiddle-click to cast " .. NLConfig.HealSpells[3] .. ".";
			end
			if( NLConfig.HealSpells[4] ) then
				tooltipText = tooltipText .. "\nClick button 4 to cast " .. NLConfig.HealSpells[4] .. ".";
			end
			if( NLConfig.HealSpells[5] ) then
				tooltipText = tooltipText .. "\nClick button 5 to cast " .. NLConfig.HealSpells[5] .. ".";
			end
		end
		if( tooltipText == "Needs healing." ) then
			tooltipText = tooltipText .. "\nUse 'Configure Spells' from the configuration window to add heal spells.";
		end
	elseif( frame.NeedName == "Mana" ) then
		tooltipText = "Needs mana.\nLeft-click to cast Innervate.";
	else
		tooltipText = "Needs cure for " .. frame.NeedName .. ".";
		if( NL_CURE_SPELLS[NL_PLAYERCLASS] and NL_CURE_SPELLS[NL_PLAYERCLASS][frame.NeedName] ) then
			if( NL_CURE_SPELLS[NL_PLAYERCLASS][frame.NeedName][1] ) then
				tooltipText = tooltipText .. "\nLeft-click to cast " .. NL_CURE_SPELLS[NL_PLAYERCLASS][frame.NeedName][1] .. ".";
			end
			if( NL_CURE_SPELLS[NL_PLAYERCLASS][frame.NeedName][2] ) then
				tooltipText = tooltipText .. "\nRight-click to cast " .. NL_CURE_SPELLS[NL_PLAYERCLASS][frame.NeedName][2] .. ".";
			end
		end
	end
	GameTooltip:SetText( tooltipText );
end

function NL_CureTopNeed(button)
	for NL_ITERATOR = 0, NL_NUM_NEEDY_UNITS - 1 do
		if( NL_SLOTS[NL_ITERATOR] and NL_SLOTS[NL_ITERATOR].TopNeed and NL_SLOTS[NL_ITERATOR].TopNeed > 1 and NL_SLOTS[NL_ITERATOR].Unit ) then
			NL_CureNeedOnUnit( NLConfig.Needs[NL_SLOTS[NL_ITERATOR].TopNeed].Name, NL_SLOTS[NL_ITERATOR].Unit, button );
			return;
		end
	end
end

function NL_SortList()
	if( NL_MOUSE_IN_FRAME ) then
		NL_MOUSE_IN_FRAME = false;
		NL_SortAllVisibleFrames();
		NL_MOUSE_IN_FRAME = true;
	else
		NL_SortAllVisibleFrames();
	end
end
