--[[
	Beastmaster by PoeticDragon

	Another 'short and sweet' addon, Beastmaster changes the way that
	beast training abilities are sorted.  Rather than displaying in
	order of rank, they're now grouped by abilities (ie dive, growl, etc).
	This way it is easier to find the ability you want, or look up what
	the highest rank known to you.

	As usual, no configuration needed.

	Future plans include standard "filter" type button like from trainers
	for Already Known, Available, and Unavailable skills.

]]--

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------

BEASTMASTER_CATG_SKILLS = {
	[1] = {1, 2, 3, 4, 5, 6, },
	[2] = {7, 8, 9, 10, 11, 12, 13, 14, },
	[3] = {15, 16, },
	[4] = {17, 18, 19, 20, 21, },
}

BEASTMASTER_SKILLS_REVERSE = {};
local i,skill;
for i,skill in BEASTMASTER_SKILLS_NAMES do
	BEASTMASTER_SKILLS_REVERSE[skill] = i;
end

-------------------------------------------------------------------------------
-- Variables
-------------------------------------------------------------------------------

Beastmaster_Sorted = {};
Beastmaster_HeaderIndex = {};
Beastmaster_IsExpanded = {true, true, true, true};
Beastmaster_Loaded = false;
Beastmaster_Selected = nil;
Beastmaster_MaxKnown = {};

-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------
function Beastmaster_OnLoad()
	this:RegisterEvent("CRAFT_SHOW");
	this:RegisterEvent("CRAFT_UPDATE");
	this:RegisterEvent("SKILL_LINES_CHANGED");
	this:RegisterEvent("UNIT_PET_TRAINING_POINTS");

	-- Hooks functions
	Beastmaster_Original_Update = CraftFrame_Update;
	CraftFrame_Update = Beastmaster_Update;

	-- Number of crafts
	Beastmaster_Original_GetNumCrafts = GetNumCrafts;
	GetNumCrafts = Beastmaster_GetNumCrafts;

	-- Opening and closing headers
	Beastmaster_Original_ExpandCraftSkillLine = ExpandCraftSkillLine;
	ExpandCraftSkillLine = Beastmaster_ExpandCraftSkillLine;
	Beastmaster_Original_CollapseCraftSkillLine = CollapseCraftSkillLine;
	CollapseCraftSkillLine = Beastmaster_CollapseCraftSkillLine;
	Beastmaster_Original_CollapseAll = TradeSkillCollapseAllButton_OnClick;
	TradeSkillCollapseAllButton_OnClick = Beastmaster_CollapseAll;

	-- Selecting a skill
	Beastmaster_Original_SetSelection = CraftFrame_SetSelection;
	CraftFrame_SetSelection = Beastmaster_SetSelection;
	Beastmaster_Original_SelectCraft = SelectCraft;
	SelectCraft = Beastmaster_SelectCraft;
	Beastmaster_Original_GetCraftSelectionIndex = GetCraftSelectionIndex;
	GetCraftSelectionIndex = Beastmaster_GetCraftSelectionIndex;

	-- Skill information
	Beastmaster_Original_GetCraftInfo = GetCraftInfo;
	GetCraftInfo = Beastmaster_GetCraftInfo;
	Beastmaster_Original_GetCraftDescription = GetCraftDescription;
	GetCraftDescription = Beastmaster_GetCraftDescription;
	Beastmaster_Original_GetCraftIcon = GetCraftIcon;
	GetCraftIcon = Beastmaster_GetCraftIcon;

	-- Skill tooltips
	Beastmaster_Original_SetCraftItem = GameTooltip.SetCraftItem;
	GameTooltip.SetCraftItem = Beastmaster_SetCraftItem;
	Beastmaster_Original_SetCraftSpell = GameTooltip.SetCraftSpell;
	GameTooltip.SetCraftSpell = Beastmaster_SetCraftSpell;

	-- Train the skill to the pet
	Beastmaster_Original_DoCraft = DoCraft;
	DoCraft = Beastmaster_DoCraft;

	Beastmaster_Loaded = true;
end

function Beastmaster_OnEvent(event)
	if (not Beastmaster_Loaded) then return; end
	if ( GetCraftName() == BEASTMASTER_TRAINING ) then
		Beastmaster_SortAbilities();
		if (CraftFrame:IsVisible()) then
			if ( GetCraftSelectionIndex() <= 1 ) then
				CraftFrame_SetSelection(2);
				FauxScrollFrame_SetOffset(CraftListScrollFrame, 0);
				CraftListScrollFrameScrollBar:SetValue(0);
				CraftFrame_Update();
			end
		end
	end
end

function Beastmaster_Update()
	Beastmaster_Original_Update();
	if ( GetCraftName() ~= BEASTMASTER_TRAINING ) then
		return;
	end

	local offset = FauxScrollFrame_GetOffset(CraftListScrollFrame);
	for i=1,CRAFTS_DISPLAYED do
		local button = getglobal("Craft"..i);
		local cost = getglobal("Craft"..i.."Cost");
		getglobal("Craft"..i.."Text"):SetPoint("TOPLEFT", "Craft"..i, "TOPLEFT", 21, 0);
--		getglobal("Craft"..i.."HighlightText"):SetPoint("TOPLEFT", "Craft"..i, "TOPLEFT", 21, 0);
--		getglobal("Craft"..i.."DisabledText"):SetPoint("TOPLEFT", "Craft"..i, "TOPLEFT", 21, 0);
		if (Beastmaster_HeaderIndex[button:GetID()]) then
			cost:SetText("");
		elseif (HasPetUI() and not cost:GetText() and button:GetText() and
			not string.find(button:GetText(), BEASTMASTER_SKILLS_NAMES[6])) then
			button.r = 0.9;
			button.g = 0;
			button.b = 0;
			button:SetTextColor(button.r, button.g, button.b);
			getglobal("Craft"..i.."SubText"):SetTextColor(button.r, button.g, button.b);
		elseif (HasPetUI() and cost:GetText()) then
			local orig = cost:GetText();
			local skill, _, _, _, _, points = GetCraftInfo(i + offset);
			local paid = Beastmaster_MaxKnown[BEASTMASTER_SKILLS_REVERSE[skill]];
			if ( paid ) then
				points = points - paid;
				if ( points > 0 ) then
					cost:SetText("("..points..") "..orig);
				end
			end
		end
	end
	CraftExpandButtonFrame:Hide();
end

function Beastmaster_SortAbilities()
	if ( GetCraftName() ~= BEASTMASTER_TRAINING ) then
		return;
	end

	local tempsort = {};
	local i, orig, skill, rank, heading, index, catg, display;
	local new = 0;

	Beastmaster_Sorted = {};
	Beastmaster_MaxKnown = {};
	for i=1, Beastmaster_Original_GetNumCrafts() do
		skill, rank, heading, _, _, points = GetCraftInfo(i);
		rank = string.gsub(rank, BEASTMASTER_RANK, "");
		rank = tonumber(rank);
		if ( heading ~= "header" ) then
			index = BEASTMASTER_SKILLS_REVERSE[skill];
			if (index) then
				if (not tempsort[index]) then
					tempsort[index] = {};
				end
				tempsort[index][rank]=i;
				if ( heading == "used" ) then
					if ( not Beastmaster_MaxKnown[index] or Beastmaster_MaxKnown[index] < points ) then
						Beastmaster_MaxKnown[index] = points;
					end
				end
			end
		end
	end

	Beastmaster_HeaderIndex = {};
	for heading,catg in BEASTMASTER_CATG_SKILLS do
		display = false;
		new = new + 1;

		for i=1, table.getn(catg) do
			index = catg[i];
			if (tempsort[index]) then
				if (not display) then
					Beastmaster_Sorted[new] = BEASTMASTER_CATG_NAMES[heading];
					Beastmaster_HeaderIndex[new] = heading;
					display = true;
				end

				if (not Beastmaster_IsExpanded[heading]) then
					break;
				end

				for _,orig in tempsort[index] do
					new = new + 1;
					Beastmaster_Sorted[new] = orig;
				end
			end
		end
	end

	Beastmaster_Update();
end

function Beastmaster_SortedIndex(index)
	if ( GetCraftName() == BEASTMASTER_TRAINING ) then
		local sorted = Beastmaster_Sorted[index];
		if ( sorted ) then
			index = sorted;
		end
	end
	return index;
end

function Beastmaster_GetNumCrafts()
	if ( GetCraftName() == BEASTMASTER_TRAINING ) then
		return table.getn(Beastmaster_Sorted);
	end
	return Beastmaster_Original_GetNumCrafts();
end

function Beastmaster_SetSelection(index)
	Beastmaster_Original_SetSelection(index);
	if ( GetCraftName() ~= BEASTMASTER_TRAINING or not HasPetUI() ) then
		return;
	end

	local skill, _, heading, _, _, points = GetCraftInfo(index);
	if (heading == "header") then
		return;
	end

	if ( points == 0 and skill ~= BEASTMASTER_SKILLS_NAMES[6]) then
		CraftHighlight:SetVertexColor(0.9, 0, 0);
	end

	local paid = Beastmaster_MaxKnown[BEASTMASTER_SKILLS_REVERSE[skill]];
	local orig = points;
	if ( paid ) then
		points = points - paid;
	end

	local total, spent = GetPetTrainingPoints();
	local usable = total - spent;
	if ( points > 0 ) then
		local display = orig;
		if ( points ~= orig ) then
			display = "("..points..") "..display;
		end
		if ( usable < points ) then
			display = RED_FONT_COLOR_CODE..display..FONT_COLOR_CODE_CLOSE;
		end
		CraftCost:SetText(COSTS_LABEL.." "..display.." "..TRAINING_POINTS_LABEL);
		CraftCost:Show();
	else
		CraftCost:Hide();
	end
end

function Beastmaster_SelectCraft(index)
	if ( GetCraftName() ~= BEASTMASTER_TRAINING or index <= Beastmaster_Original_GetNumCrafts() ) then
		Beastmaster_Selected = nil;
		return Beastmaster_Original_SelectCraft(index);
	end
	Beastmaster_Selected = index;
end

function Beastmaster_GetCraftSelectionIndex()
	if (Beastmaster_Selected) then
		return Beastmaster_Selected;
	end
	return Beastmaster_Original_GetCraftSelectionIndex();
end

function Beastmaster_ExpandCraftSkillLine(index)
	if ( GetCraftName() ~= BEASTMASTER_TRAINING ) then
		return Beastmaster_Original_ExpandCraftSkillLine(index);
	end

	if (index ~= 0) then
		Beastmaster_IsExpanded[Beastmaster_HeaderIndex[index]] = true;
		Beastmaster_SortAbilities();
	end
end

function Beastmaster_CollapseCraftSkillLine(index)
	if ( GetCraftName() ~= BEASTMASTER_TRAINING ) then
		return Beastmaster_Original_CollapseCraftSkillLine(index);
	end

	if (index ~= 0) then
		Beastmaster_IsExpanded[Beastmaster_HeaderIndex[index]] = false;
		Beastmaster_SortAbilities();
	end
end

function Beastmaster_CollapseAll()
	if ( GetCraftName() ~= BEASTMASTER_TRAINING ) then
		return Beastmaster_Original_CollapseAll();
	end
	return CraftCollapseAllButton_OnClick();
end

function Beastmaster_AdjustPoints(index)

end

function Beastmaster_Dummy(origfunc, index, ...)
	local sorted = Beastmaster_SortedIndex(index);
	if ( type(sorted) == "number" ) then
		if (origfunc == Beastmaster_Original_SetCraftItem or origfunc == Beastmaster_Original_SetCraftSpell) then
			return origfunc(arg[1], sorted, arg[2]);
		else
			return origfunc(sorted);
		end
	else
		if (origfunc == Beastmaster_Original_GetCraftInfo) then
			return sorted, "", "header", 0, Beastmaster_IsExpanded[Beastmaster_HeaderIndex[index]], 0;
		elseif (origfunc == Beastmaster_Original_GetCraftIcon) then
			return "Interface\Icons\Ability_Hunter_BeastCall02";
		else
			return nil;
		end
	end
end

function Beastmaster_GetCraftInfo(index)
	return Beastmaster_Dummy(Beastmaster_Original_GetCraftInfo, index);
end

function Beastmaster_GetCraftDescription(index)
	return Beastmaster_Dummy(Beastmaster_Original_GetCraftDescription, index);
end

function Beastmaster_GetCraftIcon(index)
	return Beastmaster_Dummy(Beastmaster_Original_GetCraftIcon, index);
end

function Beastmaster_SetCraftItem(tooltip, index, reagent)
	return Beastmaster_Dummy(Beastmaster_Original_SetCraftItem, index, tooltip, reagent);
end

function Beastmaster_SetCraftSpell(tooltip, index, reagent)
	return Beastmaster_Dummy(Beastmaster_Original_SetCraftSpell, index, tooltip, reagent);
end

function Beastmaster_DoCraft(index)
	Beastmaster_Dummy(Beastmaster_Original_DoCraft, index);
	Beastmaster_SortAbilities();
	CraftFrame_Update();
end