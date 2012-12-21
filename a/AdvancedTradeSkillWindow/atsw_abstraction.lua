-- Advanced Trade Skill Window v0.4.0
-- copyright 2006 by Rene Schneider (Slarti on EU-Blackhand)

-- Blizzard API abstraction code

function ATSW_GetTradeSkillSelectionIndex()
	if(atsw_oldmode) then
		return GetCraftSelectionIndex();
	else
		return GetTradeSkillSelectionIndex();
	end
end

function ATSW_GetNumTradeSkills()
	if(atsw_oldmode) then
		return GetNumCrafts();
	else
		return GetNumTradeSkills();
	end
end

function ATSW_GetTradeSkillLine()
	local tradeskillName, currentLevel, maxLevel;
	if(atsw_oldmode) then
		tradeskillName, currentLevel, maxLevel = GetCraftDisplaySkillLine();
	else
		tradeskillName, currentLevel, maxLevel = GetTradeSkillLine();
	end
	return tradeskillName, currentLevel, maxLevel;
end

function ATSW_GetFirstTradeSkill()
	if(atsw_oldmode) then
		return 1;
	else
		return GetFirstTradeSkill();
	end
end

function ATSW_ExpandTradeSkillSubClass(index)
	if(atsw_oldmode) then
		return ExpandCraftSkillLine(index);
	else
		return ExpandTradeSkillSubClass(index);
	end		
end

function ATSW_CollapseTradeSkillSubClass(index)
	if(atsw_oldmode) then
		return CollapseCraftSkillLine(index);
	else
		return CollapseTradeSkillSubClass(index);
	end		
end

function ATSW_GetTradeSkillInfo(index)
	local skillName, skillType, numAvailable, isExpanded;
	if(atsw_oldmode) then
		skillName, craftSubSpellName, skillType, numAvailable, isExpanded = GetCraftInfo(index);
	else
		skillName, skillType, numAvailable, isExpanded = GetTradeSkillInfo(index);
	end
	return skillName, skillType, numAvailable, isExpanded;
end

function ATSW_SelectTradeSkill(index)
	if(atsw_oldmode) then
		return SelectCraft(index);
	else
		return SelectTradeSkill(index);
	end	
end

function ATSW_GetTradeSkillCooldown(index)
	if(atsw_oldmode) then
		return nil;
	else
		return GetTradeSkillCooldown(index);
	end
end

function ATSW_GetTradeSkillNumMade(index)
	local minMade, maxMade;
	if(atsw_oldmode) then
		minMade=1;
		maxMade=1;
	else
		minMade, maxMade = GetTradeSkillNumMade(index);
	end
	return minMade, maxMade;	
end

function ATSW_GetTradeSkillIcon(index)
	if(atsw_oldmode) then
		return GetCraftIcon(index);
	else
		return GetTradeSkillIcon(index);
	end	
end

function ATSW_GetTradeSkillNumReagents(index)
	if(atsw_oldmode) then
		return GetCraftNumReagents(index);
	else
		return GetTradeSkillNumReagents(index);
	end
end

function ATSW_GetTradeSkillReagentInfo(index, reagentIndex)
	local reagentName, reagentTexture, reagentCount, playerReagentCount;
	if(atsw_oldmode) then
		reagentName, reagentTexture, reagentCount, playerReagentCount = GetCraftReagentInfo(index, reagentIndex);
	else
		reagentName, reagentTexture, reagentCount, playerReagentCount = GetTradeSkillReagentInfo(index, reagentIndex);
	end
	return reagentName, reagentTexture, reagentCount, playerReagentCount;
end

function ATSW_GetTradeSkillReagentItemLink(index, reagentIndex)
	if(atsw_oldmode) then
		return GetCraftReagentItemLink(index, reagentIndex);
	else
		return GetTradeSkillReagentItemLink(index, reagentIndex);
	end	
end

function ATSW_GetTradeSkillItemLink(index)
	if(atsw_oldmode) then
		return GetCraftItemLink(index);
	else
		return GetTradeSkillItemLink(index);
	end	
end

function ATSW_GetTradeSkillTools(index)
	if(atsw_oldmode) then
		return GetCraftSpellFocus(index);
	else
		return GetTradeSkillTools(index);
	end	
end

