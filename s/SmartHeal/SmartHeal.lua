SH_SMARTHEAL_VERSION= SH_SMARTHEAL.." "..SMARTHEAL_CURRENT_VERSION

function SmartHeal:Init()

	-- Hook the UseAction function and backup original UseAction
	SMARTHEAL_ORIG_USEACTION=UseAction;
	UseAction = function(slot,arg1,onself)	SmartHeal:UseAction(slot,arg1,onself);	end;

	-- set slash command
	SlashCmdList["SMARTHEAL"] = function(arg1) SmartHeal:SlashCmd(arg1); end;
	SLASH_SMARTHEAL1 = "/smartheal";
	SLASH_SMARTHEAL2 = "/smh";
	
	-- get realm and player name
	SmartHeal.realmName=GetRealmName();
	SmartHeal.playerName=UnitName("player");
	
	
	--local _,_,large_version,small_version,release_version=string.find(SmartHeal_Version,"^(%d+)%.(%d+)%.?(%d*)");
	
	--if(not SmartHeal_Config['version'] or tonumber(SmartHeal_Config['version'])<tonumber(SMARTHEAL_CURRENT_VERSION)) then
	--	SmartHeal_Config={}
	--end
	
	SmartHeal_Config['version']=SMARTHEAL_CURRENT_VERSION
	
	-- set realm record in save file
	if (not SmartHeal_Config[SmartHeal.realmName]) then
		SmartHeal_Config[SmartHeal.realmName]={};
	end

	-- set default settings for player if no record in save file
	if (not SmartHeal_Config[SmartHeal.realmName][SmartHeal.playerName]) then
		SmartHeal_Config[SmartHeal.realmName][SmartHeal.playerName]={};
		SmartHeal.InitializeSave=1
	end

end

function SmartHeal:InitMiniMapButton()

	local MinimapDefaultSettings=SmartHeal.default['minimapbutton']
	
	MinimapDefaultSettings.left = function() SH_OptionsFrame:Show() end
	MinimapDefaultSettings.right = function() ScriptErrors:Hide() end
	
	MyMinimapButton:Create('SmartHeal',SmartHeal_Config[SmartHeal.realmName][SmartHeal.playerName]['minimapbutton'],MinimapDefaultSettings)

end

function SmartHeal:isActive()
	return SmartHeal.active;
end

function SmartHeal:setDefault(defaultOption)

	if(not defaultOption) then
		for option in SmartHeal.default do
			
			if (type(SmartHeal.default[option])=="table") then
				
				local module=option
				for option2,value in SmartHeal.default[module] do
					SmartHeal:setConfig(option2,value,module);
				end
			
			else
				SmartHeal:setConfig(option,SmartHeal.default[option]);
			end
			
		end
	else
		for i,option in defaultOption do
			
			if (type(SmartHeal.default[option])=="table") then
				
				local module=option
				for option2,value in SmartHeal.default[module] do
					SmartHeal:setConfig(option2,value,module);
				end
			
			else
				SmartHeal:setConfig(option,SmartHeal.default[option]);
			end
		end
	
	end

end

function SmartHeal:setConfig(option,value,module)

	if(not SmartHeal:isActive()) then return end

	if (value==nil) then value=false end
	
	if (module and module~="" and option and option~="") then
		
		if (not SmartHeal_Config[SmartHeal.realmName][SmartHeal.playerName][module]) then
			SmartHeal_Config[SmartHeal.realmName][SmartHeal.playerName][module]={}
		end
		
		SmartHeal_Config[SmartHeal.realmName][SmartHeal.playerName][module][option]=value;
			

	else 
		if (option and option~="") then
			SmartHeal_Config[SmartHeal.realmName][SmartHeal.playerName][option]=value;
		end
	end

end

function SmartHeal:getConfig(option,module)
	
	if(not SmartHeal:isActive()) then return end
	
	if (module) then
		
		local moduleConfig=SmartHeal:getConfig(module)
		if(moduleConfig) then
			return moduleConfig[option]
		end
	
	else	
		if(SmartHeal_Config[SmartHeal.realmName][SmartHeal.playerName][option]~=nil) then
			return SmartHeal_Config[SmartHeal.realmName][SmartHeal.playerName][option];
		else
			return
		end
	end
end

function SmartHeal:SlashCmd(arg1)

	if (not SmartHeal:isActive()) then
		SmartHeal:ErrorMsg(SH_IS_NOT_ACTIVE_CLASS)
		return;
	end;

	if(not SH_OptionsFrame:IsShown()) then
		SH_OptionsFrame:Show()
	end
	
end

function SmartHeal:doCast(spell,rank)

	if (not spell) then return; end;
	
	local spell_with_rank=spell;
	SmartHeal.CastedSpell=spell;
	
	if (rank and rank~="") then
		spell_with_rank=spell.."("..SH_RANK.." "..rank..")"
		SmartHeal.CastedRank=rank;
	end
	
	SmartHeal.CacheUnitId=SmartHeal:TargetUnitId()
	
	if (SmartHeal.selfCast==1) then SmartHeal.CacheUnitId="player" end
	
	CastSpellByName(spell_with_rank,SmartHeal.selfCast);
	
	SmartHeal.selfCast=nil
	
end

function SmartHeal:TargetUnitId()

	local targetunitId

	if (not UnitExists("target")) then 
		return
	end

	if(UnitInRaid("target")) then
	
		for i=1,40 do
			if UnitIsUnit("raid"..i,"target") then
				targetunitId="raid"..i
				break
			end
		end
		
	elseif(UnitInParty("target") and not UnitIsUnit("player","target")) then
	
		for i=1,4 do
			if UnitIsUnit("party"..i,"target") then
				targetunitId="party"..i
				break
			end
		end
	
	elseif (UnitIsUnit("target","player")) then
		
		targetunitId="player"
	
	end
	
	return targetunitId

end

function SmartHeal:PlayerHasSpell(spell) 
	
	local HasSpell=false
	local i = 1
	while true do
		local sName , sRank = GetSpellName(i, BOOKTYPE_SPELL)
		if not sName then
			do break end
		else
			if (sName==spell) then
				HasSpell=true
				break
			end
		end

	i = i + 1
	end

	return HasSpell;
end

function SmartHeal:Cast(spell_fullname,ForceTarget)


	local _,_,spell,rankCap=string.find(spell_fullname,"(.+)%("..SH_RANK.." (%d+)%)")
	
	if (not spell) then
		spell=spell_fullname
	end
	
	if (not SmartHeal:isActive()) then
		SmartHeal:ErrorMsg(SH_IS_NOT_ACTIVE_CLASS)
		return
	end;

	if (	not SmartHeal:getConfig("enable") or spell=="" or not spell) then
		return
	end

	if (not SmartHeal.selfCast) then
		SmartHeal.selfCast=SmartHeal:isSelfCast(spell)
		if (IsAltKeyDown() and SmartHeal:getConfig("altselfcast")) then
		   	SmartHeal.selfCast=1
		elseif(SmartHeal.HotkeyMouseButton=="RightButton" and SmartHeal:getConfig("RClickHotKeySelfCast")) then
			SmartHeal.selfCast=1
		elseif (
			--SmartHeal.selfCast==1 and not SmartHeal:getConfig("autoselfcast") or 
			((UnitCanAttack("player","target") and ForceTarget))
		
		) then
			SmartHeal.selfCast=0
			SmartHeal:doCast(spell,rankCap)
			return
		end
	end
	
	local rank
	
	if (SmartHeal.buffList[spell]~=nil) then
		SmartHeal.isBuff=true
		SmartHeal.isHeal=false
		rank=SmartHeal:buffRank(spell)
	elseif (SmartHeal.spellList[spell]~=nil) then
		SmartHeal.isBuff=false
		SmartHeal.isHeal=true
		rank=SmartHeal:healRank(spell)
	else
		SmartHeal:doCast(spell,rankCap)
	end
	
	if (spell==SH_LESSER_GREATER_HEALS) then
		if (rank<=3) then
			spell=SH_LESSER_HEAL
		elseif (rank<=7) then
			spell=SH_HEAL
			rank=rank-3
		else
			spell=SH_GREATER_HEAL
			rank=rank-7
		end
	end
	
	if(rankCap) then
		rank=min(rank,tonumber(rankCap))
	end
	
	SmartHeal:doCast(spell,rank);
end

function SmartHeal:healRank(spell)

	local SpellStats=SmartHeal.spellList[spell];

	local target="target";
	if(SmartHeal.selfCast==1) then
		target="player";
	end
	
	local ignoreMana=false
	if (UnitIsDead("player")) then ignoreMana=true end
	
	local maxrank=SmartHeal:SpellMaxRank(spell,ignoreMana)
	if (not maxrank) then return end
	
	-- target max acceptable rank or optimal rank whichever is lower
	local rank = min(SmartHeal:targetRank(target,spell),maxrank)

	if (	SpellStats.HoT==1 
		or (not UnitInParty(target) and not UnitInRaid(target) and not UnitIsUnit("player",target)) 
		or (SmartHeal:ClickHeal_IsOverdrive()) -- overdrive mode ignore hp deficit
	) then
		
		if(SpellStats.HoT~=1) then
			SmartHeal.HealedValue=SmartHeal:AdjustHealValue(spell,rank)
		end
		
		return rank
	end
	
	-- find the best spell rank for the health deficit
	local hpDeficit=0;
	local TotalHeal=0
	local rank2=1
	if (SpellStats.group==1) then
		for i=1,4 do
			hpDeficit=max(hpDeficit,UnitHealthMax("party"..i)-UnitHealth("party"..i));
		end
		hpDeficit=max(hpDeficit, (UnitHealthMax("player")-UnitHealth("player")) )
	else
		hpDeficit=UnitHealthMax(target)-UnitHealth(target);
	end

	
	for r=1,table.getn(SpellStats.value) do

		rank2=r
		TotalHeal=SmartHeal:AdjustHealValue(spell,r)
		if (TotalHeal>hpDeficit*SmartHeal:getConfig('overheal')/100) then
			SmartHeal.HealedValue=TotalHeal
			break
		end

	end
	
	return min(rank,rank2)

end

function SmartHeal:isSelfCast(spell)

	if (not UnitExists("target") or not UnitIsFriend("target","player")) then
		return 1
	else
		return 0
	end

end

function SmartHeal:targetRank(target,spell)

	local targetRank=1;
	local SpellStats

	
	if (SmartHeal.isBuff) then
		SpellStats=SmartHeal.buffList[spell];
	elseif (SmartHeal.isHeal) then
		SpellStats=SmartHeal.spellList[spell];
	end
	
	-- find target acceptable rank
	for i=table.getn(SpellStats.level),1,-1 do
		if (UnitLevel(target)>=SpellStats.level[i]-10) then
			targetRank=i;
			break;
			
		end
	end

	return targetRank
end

function SmartHeal:AdjustHealValue(spell,rank)

	-- calculate bonus offsets
	local EquipmentBonus=0
	if (BonusScanner) then
		EquipmentBonus=tonumber(BonusScanner:GetBonus("HEAL"))
	end
	
	-- Adjust Talent
	local talent_multiplier,talent_adder=SmartHeal:TalentAdjust(spell)
	
	local healvalue=(SmartHeal.spellList[spell].value[rank]*talent_multiplier)+talent_adder+(EquipmentBonus*SmartHeal:bonusAdjust(spell,rank));
	
	return healvalue or 0

end

function SmartHeal:UseAction(slot, arg2, onself)

	-- Hack to get the spell name
	SmartHealSpellTooltip:SetAction(slot)
	local spell = getglobal("SmartHealSpellTooltipTextLeft1"):GetText()
	local rankTemp = getglobal("SmartHealSpellTooltipTextRight1"):GetText()
	local _,rankCap
	if(rankTemp) then
		_,_,rankCap=string.find(rankTemp,"^"..SH_RANK.." (%d+)")
	end
	
	SmartHeal.HotkeyMouseButton=arg1
	
	if ( (SmartHeal.spellList[spell]~=nil or SmartHeal.buffList[spell]~=nil)
		and SmartHeal:getConfig("override") and SmartHeal:getConfig("enable")) then
		
		if (rankCap) then
			SmartHeal:Cast(spell.."("..SH_RANK.." "..rankCap..")")
		else
			SmartHeal:Cast(spell)
		end
	
	else
		
		SmartHeal.selfCast=onself
			
		-- Check for alt self cast
		if (IsAltKeyDown() and SmartHeal:getConfig("altselfcast")) then
			SmartHeal.selfCast=1
		
		elseif(SmartHeal.HotkeyMouseButton=="RightButton" and SmartHeal:getConfig("RClickHotKeySelfCast")) then
			
			SmartHeal.selfCast=1
		
		elseif(	SmartHeal:isSelfCast(spell)==1 and SmartHeal:getConfig("autoselfcast") and
			(SmartHeal.spellList[spell]~=nil or SmartHeal.buffList[spell]~=nil)
		
		) then
			SmartHeal.selfCast=1
		end
		
		SmartHeal.CacheUnitId=SmartHeal:TargetUnitId()

		if (rankCap and SmartHeal.spellList[spell]~=nil and SmartHeal.spellList[spell].HoT~=1) then
			SmartHeal.HealedValue=SmartHeal:AdjustHealValue(spell,tonumber(rankCap))
		end
		
		-- do default button action if the spell is not listed in the healing spells list
		SMARTHEAL_ORIG_USEACTION(slot, arg2, SmartHeal.selfCast)
		
		SmartHeal.selfCast=nil
	end
	

end

function SmartHeal:SpellMaxRank(spellname,ignoreMana)
	local maxRank=1;
	local manatooltip;
	local spells={[1]=spellname}
	
	if(spellname==SH_LESSER_GREATER_HEALS) then
		spells={[1]=SH_LESSER_HEAL, [4]=SH_HEAL, [8]=SH_GREATER_HEAL,}
	end
	
	
	for r,spell in spells do
		local i = 1
		while true do
			local sName , sRank = GetSpellName(i, BOOKTYPE_SPELL)
			if not sName then
				do break end
			elseif (sName==spells[r]) then
				local _,_,rankNumber=string.find(sRank,"^"..SH_RANK.." (%d+)")
				if (rankNumber and rankNumber~="") then
					rankNumber=tonumber(rankNumber)
					SmartHealSpellTooltip:SetSpell(i,BOOKTYPE_SPELL)
					manatooltip = getglobal("SmartHealSpellTooltipTextLeft2"):GetText()
					local _,_,mana=string.find(manatooltip,"^(%d+) "..SH_MANA);	
					if ((mana and UnitMana('player')>tonumber(mana)) or not mana or ignoreMana) then
						maxRank=max(maxRank,rankNumber+(r-1))
					end
				else
					return
				end
			end
			
			i = i + 1
		end -- end of while loop
	end -- end of for loop
	return maxRank
end

function SmartHeal:TalentAdjust(spell)

	local _, playerClass = UnitClass("player");
	local rank
	local multiplier_factor=1
	local additional_factor=0;

	if (playerClass=="PRIEST") then

		-- Improved Renew (renew only) 5% per point
		_, _, _, _, rank,_= GetTalentInfo(2,2);
		if (spell==SH_RENEW) then multiplier_factor=multiplier_factor*(1+(rank*0.05)); end;

		-- Spiritual Healing (all healing) 2% per point
		_, _, _, _, rank,_= GetTalentInfo(2,15);
		multiplier_factor=multiplier_factor*(1+(rank*0.02));

		-- Spiritual Guidance (all healing) 5% per point, based on total spirit
		_, _, _, _, rank,_= GetTalentInfo(2,14);
		
		local spirit=0;
		if (BonusScanner) then
			spirit=tonumber(BonusScanner:GetBonus("SPI"));	
		end
		
		additional_factor=additional_factor+spirit*(rank*0.05)

	elseif (playerClass=="PALADIN") then

		-- Healing Light (healing light and flash light) 4% per point
		_, _, _, _, rank,_= GetTalentInfo(1,5);
		if (spell==SH_HEALING_LIGHT or spell==SH_FLASH_OF_LIGHT) then multiplier_factor=multiplier_factor*(1+(rank*0.04)); end;

	elseif (playerClass=="DRUID") then

		-- Improved Rejuvenation (rejuvenation only) 5% per point
		_, _, _, _, rank,_= GetTalentInfo(3,10);
		if (spell==SH_REJUVENATION) then multiplier_factor=multiplier_factor*(1+(rank*0.05)); end;

		-- Gift of Nature (all healing spells) 2% per point
		_, _, _, _, rank,_= GetTalentInfo(3,12);
		multiplier_factor=multiplier_factor*(1+(rank*0.02));

	elseif (playerClass=="SHAMAN") then

		-- Purification 2% per point
		_, _, _, _, rank,_= GetTalentInfo(3,10);
		multiplier_factor=multiplier_factor*(1+(rank*0.02));

	end

	return multiplier_factor,additional_factor

end

function SmartHeal:bonusAdjust(spell,rank)

	local SpellStats=SmartHeal.spellList[spell];
	local bonus=1;
	local castTimeBonus=1;
	local lowlevelBonus=1;
	local HoTBonus=1;

	-- cast time discount,  ActualBenefit = AdvertisedBenefit * (CastingTime / 3.5)
	if (SpellStats.castTime[rank]<3.5 and SpellStats.value[rank]>0) then
		castTimeBonus=SpellStats.castTime[rank]/3.5;
	end

	-- Low level discount , EffectiveBonus = (1-((20-LevelLearnt)*0.0375))*AdvertisedBonus
	if (SpellStats.level[rank]<20) then
		lowlevelBonus=(1-((20-SpellStats.level[rank])*0.0375))
	end

	-- Heal+HoT discount
	if (SpellStats.HoTvalue~=nil) then
		if (SpellStats.value[rank]>0 and SpellStats.HoTvalue[rank]>0) then
			HoTBonus=SpellStats.value[rank]/(SpellStats.value[rank]+SpellStats.HoTvalue[rank])
		end
	end
	bonus=bonus*castTimeBonus*lowlevelBonus*HoTBonus;

	return bonus;
end

function SmartHeal:buffRank(spell)

	local BuffStats=SmartHeal.buffList[spell];
	local targetRank=1;
	local target="target";

	if(SmartHeal.selfCast==1) then
		target="player";
	end

	local maxrank=SmartHeal:SpellMaxRank(spell)
	
	if(not maxrank) then return end
	
	if (BuffStats.group==0) then -- target buff
		targetRank=SmartHeal:targetRank(target,spell);

	elseif (BuffStats.group==1) then -- group member buff

		for i=1,4 do
			targetRank=max(targetRank,SmartHeal:targetRank("party"..i,spell));
		end

		targetRank=max(targetRank,SmartHeal:targetRank("player",spell));

	elseif (BuffStats.group==2) then -- paladin unit class blessings

		local _, targetClass = UnitClass(target);
		local thisUnitClass;

		if SmartHeal:inRaid() then

			for i=1,40 do

				_, thisUnitClass = UnitClass("raid"..i);
				if (thisUnitClass==targetClass) then
					targetRank=max(targetRank,SmartHeal:targetRank("raid"..i,spell));
				end

			end

		elseif SmartHeal:inParty() then

			for i=1,4 do

				_, thisUnitClass = UnitClass("party"..i);
				if (thisUnitClass==targetClass) then
					targetRank=max(targetRank,SmartHeal:targetRank("party"..i,spell));
				end

			end
			targetRank=max(targetRank,SmartHeal:targetRank("player",spell));

		end

	else
		targetRank=SmartHeal:targetRank(target,spell); -- treat as target only buff
	end
	
	-- target max acceptable rank or player max rank whichever is lower
	return min(targetRank,maxrank);

end

function SmartHeal:inRaid()
	if GetNumRaidMembers()>0 then
		return true
	else
		return false
	end
end

function SmartHeal:inParty()
	if GetNumPartyMembers()>0 then
		return true
	else
		return false
	end
end

function SmartHeal:ErrorMsg(msg,r,g,b)
	if (not r and not g and not b) then
		r=1;g=0;b=0;
	end
	DEFAULT_CHAT_FRAME:AddMessage(msg,r,g,b);
end

function SmartHeal:doDebug()

	SmartHeal:ErrorMsg("SmartHeal Casted: "..SmartHeal.CastedSpell.."(Rank "..SmartHeal.CastedRank..")")
	
	if (SMARTHEAL_HEALTABLE[SmartHeal.playerClass] ~= nil) then
		SmartHeal_DebugMsg['talent']=SmartHeal:getAllTalent()
	end

end

function SmartHeal:AlertHealer(arg1)
	
	if (not UnitExists("target") or not UnitIsFriend("player","target")) then 
		return 
	end
	
	local current_targetName=UnitName("target")
	
	local _,_,casterName,spell=string.find(arg1,"(.+) "..SH_BEGINS_TO_CAST.." (.+).")
	if(not casterName or not spell) then return end
	
	TargetByName(casterName)
	
	if (UnitName("target")==casterName and UnitName("targettarget")==current_targetName) then
		
		local _, casterClass = UnitClass("target");
		
		if (UnitName("target")~= current_targetName) then
			TargetLastTarget()
		end
		
		local alert_msg=string.format(SH_ALERT_HEALER_MSG, casterName, spell, current_targetName);
		local holdtime=UIERRORS_HOLD_TIME;
		local casterspellList=SMARTHEAL_HEALTABLE[casterClass];
		
		if (casterspellList) then
			local spellStats=casterspellList[spell];
			if (spellStats) then
				if (spellStats.castTime[1]) then
					holdtime=spellStats.castTime[1]; -- take the rank 1 cast time as holdtime
				end
		
				UIErrorsFrame:AddMessage(alert_msg, 0, 1.0, 0, 1.0, holdtime);
			end
			
		end
	
	else
		
		if (UnitName("target")~= current_targetName) then
			TargetLastTarget()
		end
	end
	
end

-- cannot stop cast onupdate after 1.10 , using warning alert instead 
function SmartHeal:StopCasting_OnUpdate(arg1)
	
	--if (not SmartHeal.SpellIsCasting and not SmartHeal.SpellIsChanneling) then return end

	if (not SmartHeal.HealUnitId or not SmartHeal.DoExcessHealAlert or not SmartHeal:getConfig("excesshealalert")) then 
		return
	end

	if (SmartHeal.SpellIsCasting) then
		SmartHeal.timer=SmartHeal.timer-(arg1*1000)
	end
	
	if(SmartHeal.timer<1000) then
	
		local hp_ratio=UnitHealth(SmartHeal.HealUnitId)/UnitHealthMax(SmartHeal.HealUnitId)*100
			
		if (hp_ratio>=SmartHeal:getConfig("excesshealalerttrigger")) then
			UIErrorsFrame:AddMessage(SH_EXCESSIVE_HEALING_ALERT_MSG.." "..UnitName(SmartHeal.HealUnitId).."!!!", 1, 0, 1, 1.0,3);
		end

		SmartHeal.DoExcessHealAlert=nil
	
	end
	
end

-- for debug purposes, use when talent tree is changed by Blizzard
function SmartHeal:getAllTalent()

	local _, playerClass = UnitClass("player");
	local numTabs = GetNumTalentTabs();
	local talent={}
	talent[playerClass]={}
	for t=1, numTabs do
		local numTalents = GetNumTalents(t);
		talent[playerClass][t]={}
		for i=1, numTalents do
			local nameTalent, _, _, _, currRank, maxRank= GetTalentInfo(t,i);
			talent[playerClass][t][i]={name=nameTalent, rank=currRank,max=maxRank}
		end
	end

	return talent
end

