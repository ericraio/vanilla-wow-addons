-- ============================================================================
-- TTCraftAddict.lua
--
-- Copyright (c) Matthew Johnson.  All rights reserved.
--
-- This work may be freely adapted and distributed as long as this notice remains intact.
-- This work may NOT be (re)sold or included in any compilations that are (re)sold.
--
-- ============================================================================

-- ============================================================================
-- Object definitions.
-- ============================================================================
TTCA_Item =
	{
	Name = nil,
	Type = nil,
	Level = nil,
	Id = nil,
	ReagentId = nil,
	Texture = nil,
	NumAvailable = nil,
	NumRequired = nil,
	New = function (self)
		      obj = {};
		      setmetatable(obj, self);
		      self.__index = self;
		      return obj;
		  end,
	};

-- ============================================================================
-- Global variables.
-- ============================================================================
local Pre_TTCA_TradeSkillFrame_SetSelection = nil;
local Pre_TTCA_CraftFrame_SetSelection = nil;

-- The list of items in the build tree.
local vTTCA_BuildTree = nil;

-- The list of raw materials needed to build the selected item.
local vTTCA_MaterialList = nil;

-- The list of items need to be made to build the selected item.
local vTTCA_ConstructionList = nil;

-- The list of tools needed to build the selected item.
local vTTCA_ToolList = nil;

-- The currently active tab.
local vTTCA_ActiveTab = nil

-- Flag to determine if we are currently building the tree.
local vfTTCA_BuildingTree = false;

-- Flag to determine if we should watch for a bag update so we know when to
-- build the next item.
local vfTTCA_WatchForBagUpdate = false;

-- ============================================================================
-- Global defines.
-- ============================================================================
TTCA_LISTITEMS_VISIBLE = 15;
TTCA_LISTITEM_HEIGHT = 22;
TTCA_LISTITEM_WIDTH = 300;
TTCA_LISTITEM_INDENT = 15;

TTCA_TAB_BUILDTREE = 1;
TTCA_TAB_MATERIALS = 2;

local TTCA_TypeColor =
	{
	["optimal"]	= { r = 1.00, g = 0.50, b = 0.25 },
	["medium"]	= { r = 1.00, g = 1.00, b = 0.00 },
	["easy"]	= { r = 0.25, g = 0.75, b = 0.25 },
	["trivial"]	= { r = 0.50, g = 0.50, b = 0.50 },
	["reagent"]	= { r = 0.50, g = 0.50, b = 0.50 },
	["selected"]	= { r = 1.00, g = 1.00, b = 1.00 },
	["unavailable"]	= { r = 1.00, g = 0.00, b = 0.00 },
	["header"]	= { r = 0.30, g = 0.30, b = 1.00 },
	};

-- ============================================================================
-- OnLoad
--
-- Called when this addon is first loaded.
-- ============================================================================
function TTCA_OnLoad()

	-- Register events
	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("CRAFT_CLOSE");
	this:RegisterEvent("CRAFT_SHOW");
	this:RegisterEvent("CRAFT_UPDATE");
	this:RegisterEvent("SPELLCAST_INTERRUPTED");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("TRADE_SKILL_CLOSE");
	this:RegisterEvent("TRADE_SKILL_SHOW");
	this:RegisterEvent("TRADE_SKILL_UPDATE");

	--TradeSkillFrame_LoadUI();

	-- Hook
	Pre_TTCA_TradeSkillFrame_SetSelection = TradeSkillFrame_SetSelection;
	TradeSkillFrame_SetSelection = TTCA_Override_TradeSkillFrame_OnSetSelection;

	Pre_TTCA_CraftFrame_SetSelection = CraftFrame_SetSelection;
	CraftFrame_SetSelection = TTCA_Override_CraftFrame_OnSetSelection;

end

-- ============================================================================
-- OnEvent
--
-- Called to handle the events registered for this addon.
-- ============================================================================
function TTCA_OnEvent()

	if (vfTTCA_BuildingTree) then

		if ((vfTTCA_WatchForBagUpdate) and (event == "BAG_UPDATE")) then

			vfTTCA_WatchForBagUpdate = false;
			TTCA_Update();
			TTCA_BuildNextItem(vTTCA_ConstructionList);
		
		elseif (event == "SPELLCAST_INTERRUPTED") then

			-- Building was interrupted, reset the building flag.
			vfTTCA_BuildingTree = false;
			vfTTCA_WatchForBagUpdate = false;

		elseif (event == "SPELLCAST_STOP") then

			-- Finished building the current item, so build the next item in
			-- the construction list when the current item appears in the
			-- character's bag.
			vfTTCA_WatchForBagUpdate = true;

		end

	end

	if ((event == "CRAFT_CLOSE") or (event == "TRADE_SKILL_CLOSE")) then
		TTCA_OnTradeSkillClose();

	elseif ((event == "CRAFT_SHOW") or (event == "TRADE_SKILL_SHOW")) then
		TTCA_OnTradeSkillShow();

	elseif ((event == "CRAFT_UPDATE") or (event == "TRADE_SKILL_UPDATE")) then
		TTCA_OnTradeSkillUpdate();

	end

end

-- ============================================================================
-- Override_TradeSkillFrame_OnSetSelection
--
-- This event occurs every time a selection is set within the built in craft
-- skill window.  This function is hooked into the built in function so that
-- this addon can catch the selection change events.
-- ============================================================================
function TTCA_Override_CraftFrame_OnSetSelection(id)

	Pre_TTCA_CraftFrame_SetSelection(id);

end

-- ============================================================================
-- Override_TradeSkillFrame_OnSetSelection
--
-- This event occurs every time a selection is set within the built in trade
-- skill window.  This function is hooked into the built in function so that
-- this addon can catch the selection change events.
-- ============================================================================
function TTCA_Override_TradeSkillFrame_OnSetSelection(id)

	Pre_TTCA_TradeSkillFrame_SetSelection(id);

	-- If the id is the currently selected item, don't bother reseting stuff.
	if ((vTTCA_BuildTree ~= nil) and (id ~= vTTCA_BuildTree[1].Id)) then

		-- Reset the build tree scroll frame.
		TTCA_Reset();

		-- Reset the quantity.
		TTCA_InputBox_Quantity:SetNumber(1);

	end

	-- The selection may have changed, so update the trade skill build tree.
	TTCA_Update();

end

-- ============================================================================
-- OnTradeSkillClose
--
-- This event occurs when the user closes the built in trade skill window.
-- ============================================================================
function TTCA_OnTradeSkillClose()

	-- Hide the trade skill build tree.
	TTCA_ShowBuildTree(false);

	-- Hide the trade skill show button.
	HideUIPanel(TTCA_Button_ShowBuildTree);

end

-- ============================================================================
-- OnTradeSkillShow
--
-- This event occurs when the users opens the built in trade skill window.
-- ============================================================================
function TTCA_OnTradeSkillShow()

	-- Show the trade skill tree expand button.
	TTCA_Button_ShowBuildTree:SetPoint("TOPLEFT", TTCA_GetTradeSkillOrCraftFrameName(), "TOPRIGHT", -37, -9);
	ShowUIPanel(TTCA_Button_ShowBuildTree);

	-- Reset the selected build tree item.
	TTCA_SetSelection(1);

	-- Reset the quantity.
	TTCA_InputBox_Quantity:SetNumber(1);

end

-- ============================================================================
-- OnTradeSkillUpdate
--
-- This event occurs every time the built in trade skill window fires an update
-- event.
-- ============================================================================
function TTCA_OnTradeSkillUpdate()

	-- Update the build tree frame.
	TTCA_Update();

end

-- ============================================================================
-- ShowBuildTree
--
-- Shows/Hides the trade skill build tree window.
-- ============================================================================
function TTCA_ShowBuildTree(show)

	-- If the active tab is not yet set, make it the first tab.
	if (vTTCA_ActiveTab == nil) then

		vTTCA_ActiveTab = TTCA_TAB_BUILDTREE;
		PanelTemplates_SelectTab(TTCA_Tab_BuildTree);

	end

	if (show) then

		-- Hide the expand button and show the skill tree frame.
		HideUIPanel(TTCA_Button_ShowBuildTree);
		ShowUIPanel(TTCA_MainFrame);
		TTCA_MainFrame:SetPoint("TOPLEFT", TTCA_GetTradeSkillOrCraftFrameName(), "TOPRIGHT", -35, -13);
		TTCA_Update();
		PlaySound("igCharacterInfoOpen");

	else

		-- Hide the trade skill expand frame and show the expand button.
		HideUIPanel(TTCA_MainFrame);
		ShowUIPanel(TTCA_Button_ShowBuildTree);
		PlaySound("igCharacterInfoClose");

	end

end

-- ============================================================================
-- Reset
--
-- Resets the scroll frame to its initial values.
-- ============================================================================
function TTCA_Reset()

	-- Reset the scroll frame.
	FauxScrollFrame_SetOffset(TTCA_List_ScrollFrame, 0);
	TTCA_List_ScrollFrameScrollBar:SetValue(0);

	-- Reset the buttons.
	TTCA_Button_CreateTree:Disable();
	TTCA_Button_CreateAllTree:Disable();

end

-- ============================================================================
-- Update
--
-- Calculate the build tree, required raw materials, tools, and a construction
-- list for the currently selected item.
-- ============================================================================
function TTCA_Update()

	-- If the build tree window isn't visible, don't bother updating.
	if (not TTCA_MainFrame:IsVisible()) then
		return;
	end

	-- Create the build tree.
	vTTCA_BuildTree = {};
	TTCA_CreateBuildTree(TTCA_GetSkillSelectionIndex(), vTTCA_BuildTree, nil, TTCA_InputBox_Quantity:GetNumber());

	-- Compute raw material requirements and the construction list for the currently
	-- selected item.
	vTTCA_MaterialList, vTTCA_ConstructionList, vTTCA_ToolList = TTCA_CreateMaterialConstructionToolLists(vTTCA_BuildTree, TTCA_GetSelection());

	-- Disable the create tree button.
	TTCA_Button_CreateTree:Disable();
	TTCA_Button_CreateAllTree:Disable();

	-- Update the list of items with the build tree or the material summary,
	-- depending on which tab is active.
	if (vTTCA_ActiveTab == TTCA_TAB_BUILDTREE) then

		TTCA_UpdateBuildTree(vTTCA_BuildTree);

		if (TTCA_IsItemBuildable(vTTCA_BuildTree, TTCA_GetSelection()) and (vTTCA_BuildTree[TTCA_GetSelection()].Type ~= "reagent")) then

			TTCA_Button_CreateTree:Enable();
			TTCA_Button_CreateAllTree:Enable();

		end

	elseif (vTTCA_ActiveTab == TTCA_TAB_MATERIALS) then

		TTCA_UpdateMaterials(vTTCA_MaterialList);

	end

end

-- ============================================================================
-- UpdateBuildTree
-- ============================================================================
function TTCA_UpdateBuildTree(buildTree)

	-- Find the total number of items in the build tree.
	local cBuildTreeItems = getn(buildTree);

	-- Find the scroll offset for the faux scroll frame.
	local iListItemOffset = FauxScrollFrame_GetOffset(TTCA_List_ScrollFrame);

	-- Update the scroll frame.
	FauxScrollFrame_Update(TTCA_List_ScrollFrame, cBuildTreeItems, TTCA_LISTITEMS_VISIBLE, TTCA_LISTITEM_HEIGHT, nil, nil, nil, TTCA_ListItem_HighlightFrame, 300, 300);

	-- Hide the highlight frame until we know where it is appearing.
	TTCA_ListItem_HighlightFrame:Hide();

	-- Loop through our visible list items and update each one.
	for i=1, TTCA_LISTITEMS_VISIBLE, 1 do

		local listItem = getglobal("TTCA_ListItem" .. i);
		local listItemIndent = getglobal("TTCA_ListItem" .. i .. "_Indent");
		local listItemTexture = getglobal("TTCA_ListItem" .. i .. "_Texture");
		local listItemTooltipTriggerFrame = getglobal("TTCA_ListItem" .. i .. "_TooltipTriggerFrame");

		local iBuildTreeIndex = i + iListItemOffset;

		if (iBuildTreeIndex <= cBuildTreeItems) then

			local buildTreeItem = buildTree[iBuildTreeIndex];

			if (buildTreeItem.Name ~= nil) then

				-- Indent the item by its level.
				listItemIndent:SetWidth(TTCA_LISTITEM_INDENT * (buildTreeItem.Level-1) + 1);

				-- Set the texture.
				listItemTexture:SetTexture(buildTreeItem.Texture);
				listItemTexture:SetWidth(20);
				listItemTexture:Show();

				-- Set the name, number required, and number available.
				local itemText = buildTreeItem.Name .. "  ";
				local itemNumText = "(" .. buildTreeItem.NumAvailable .. "/" .. buildTreeItem.NumRequired .. ")";
				local itemNumBuildableText = "";
				local itemNumTextColor;

				-- If this item is not a reagent, compute how many we can build based on the num available.
				if (buildTreeItem.Type ~= "reagent") then
					itemNumBuildableText = "  [" .. floor(buildTreeItem.NumAvailable / buildTreeItem.NumRequired) .. "]";
				end

				-- If the number available is >= the number required, then color the text differently.
				if (buildTreeItem.NumAvailable >= buildTreeItem.NumRequired) then
					itemNumTextColor = HIGHLIGHT_FONT_COLOR_CODE;
				else
					itemNumTextColor = GRAY_FONT_COLOR_CODE;
				end
				listItem:SetText(itemText .. itemNumTextColor .. itemNumText .. itemNumBuildableText .. FONT_COLOR_CODE_CLOSE);

				-- Set the color of the text.
				local listItemColor = TTCA_TypeColor[buildTreeItem.Type];
				listItem:SetTextColor(listItemColor.r, listItemColor.g, listItemColor.b);

				-- Set the Id so we know which button gets selected on clicks.
				listItem.Index = iBuildTreeIndex;

				-- Set some values on the texture so we can show tooltips for each item.
				listItemTooltipTriggerFrame.Id = buildTreeItem.Id;
				listItemTooltipTriggerFrame.ReagentId = buildTreeItem.ReagentId;
				listItemTooltipTriggerFrame:Show();

				-- Set some values on the item so we can link it when shift-clicked.
				listItem.Id = buildTreeItem.Id;
				listItem.ReagentId = buildTreeItem.ReagentId;

				-- Update the highlight frame.
				if (TTCA_GetSelection() == iBuildTreeIndex) then

					-- Set the selected item's text color.
					local listItemTextColor = TTCA_TypeColor["selected"];
					listItem:SetTextColor(listItemTextColor.r, listItemTextColor.g, listItemTextColor.b);

					-- Set the color and location of the highlight frame.
					TTCA_ListItem_Highlight:SetVertexColor(listItemColor.r, listItemColor.g, listItemColor.b);
					TTCA_ListItem_HighlightFrame:SetPoint("TOPLEFT", "TTCA_ListItem" .. i, "TOPLEFT", -3, 0);
					TTCA_ListItem_HighlightFrame:Show();

				end

				-- Show the button.
				listItem:Show();

			end

		else

			-- Hide the button since it is unused.
			listItem:Hide();

		end

	end

end

-- ============================================================================
-- UpdateMaterials
-- ============================================================================
function TTCA_UpdateMaterials(materialList)

	-- Find the total number of items in the material list.
	local cMaterialItems = getn(materialList);

	-- Find the scroll offset for the faux scroll frame.
	local iListItemOffset = FauxScrollFrame_GetOffset(TTCA_List_ScrollFrame);

	-- Update the scroll frame.
	FauxScrollFrame_Update(TTCA_List_ScrollFrame, cMaterialItems, TTCA_LISTITEMS_VISIBLE, TTCA_LISTITEM_HEIGHT, nil, nil, nil, TTCA_ListItem_HighlightFrame, 300, 300);

	-- Hide the highlight frame since it isn't used for this view.
	TTCA_ListItem_HighlightFrame:Hide();

	-- Loop through our material list.
	for i=1, TTCA_LISTITEMS_VISIBLE, 1 do

		local listItem = getglobal("TTCA_ListItem" .. i);
		local listItemIndent = getglobal("TTCA_ListItem" .. i .. "_Indent");
		local listItemTexture = getglobal("TTCA_ListItem" .. i .. "_Texture");
		local listItemTooltipTriggerFrame = getglobal("TTCA_ListItem" .. i .. "_TooltipTriggerFrame");

		local iMaterialListIndex = i + iListItemOffset;

		if (iMaterialListIndex <= cMaterialItems) then

			local materialListItem = materialList[iMaterialListIndex];

			if (materialListItem.Name ~= nil) then

				-- Indent the item by its level.
				listItemIndent:SetWidth(TTCA_LISTITEM_INDENT * (materialListItem.Level-1) + 1);

				-- Set the texture, if one exists.
				if (materialListItem.Texture) then
					listItemTexture:SetTexture(materialListItem.Texture);
					listItemTexture:SetWidth(20);
					listItemTexture:Show();
				else
					listItemTexture:SetWidth(1);
					listItemTexture:Hide();
				end

				-- Set the name.
				local wzName = materialListItem.Name;

				-- Set the number required and available, if they exist.
				if (materialListItem.NumAvailable and materialListItem.NumRequired) then
					wzName = wzName .. "  (" .. materialListItem.NumAvailable .. "/" .. materialListItem.NumRequired .. ")";
				end

				-- Set the text on the list item.
				listItem:SetText(wzName);

				-- Set the color of the text.
				local listItemColor = TTCA_TypeColor["reagent"];

				-- If the number required and available exists, then color the item if we have enough.
				if (materialListItem.NumAvailable and materialListItem.NumRequired) then

					if (materialListItem.NumAvailable >= materialListItem.NumRequired) then
						listItemColor = TTCA_TypeColor["selected"];
					end

				elseif (materialListItem.Type) then

					listItemColor = TTCA_TypeColor[materialListItem.Type];

				end

				listItem:SetTextColor(listItemColor.r, listItemColor.g, listItemColor.b);

				-- Set some values on the texture so we can show tooltips for each item.  But if the
				-- texture isn't set, don't bother doing this.
				if (materialListItem.Texture) then

					listItemTooltipTriggerFrame.Id = materialListItem.Id;
					listItemTooltipTriggerFrame.ReagentId = materialListItem.ReagentId;
					listItemTooltipTriggerFrame:Show();

				else

					listItemTooltipTriggerFrame:Hide();

				end

				-- Set some values on the item so we can link it when shift-clicked.
				listItem.Id = materialListItem.Id;
				listItem.ReagentId = materialListItem.ReagentId;

				-- Show the button.
				listItem:Show();

			end

		else

			-- Hide the button since it is unused.
			listItem:Hide();

		end

	end

end

-- ============================================================================
-- GetSelection
--
-- Returns the item currently selected in the build tree tab.
-- ============================================================================
function TTCA_GetSelection()

	return TTCA_MainFrame.SelectionIndex;

end

-- ============================================================================
-- SetSelection
--
-- Makes the item at the given build tree index the currently selected item.
-- ============================================================================
function TTCA_SetSelection(index)

	TTCA_MainFrame.SelectionIndex = index;
	TTCA_Update();

end

-- ============================================================================
-- FindTradeSkillIdByName
--
-- Iterates through all of the player's trade skills and returns the index of
-- the first trade skill that matches the given name.  If no match is found
-- then nil is returned.
-- ============================================================================
function TTCA_FindTradeSkillIdByName(tradeSkillName)

	local cTradeSkills = TTCA_GetNumSkills();

	for i=1, cTradeSkills, 1 do

		local name = TTCA_GetSkillInfo(i);

		if (tradeSkillName == name) then
			return i;
		end

	end

	return nil;

end

-- ============================================================================
-- CreateMaterialConstructionToolLists
--
-- Generates a list of raw materials required in order to create the selected
-- item.  If no item is selected, it creates a summary for the first item.
-- ============================================================================
function TTCA_CreateMaterialConstructionToolLists(buildTree, index)

	if ((index <= 0) or (index > getn(buildTree))) then
		index = 1;
	end

	local materialList = {};
	local constructionList = {};
	local toolList = {};
	local finalizedMaterialList = {};

	TTCA_CreateMaterialConstructionToolListsSub(materialList, constructionList, toolList, buildTree, index, buildTree[index].NumRequired);

	-- Sort the material list alphabetically.
	materialList = TTCA_Sort(materialList);

	-- Sort the tool list alphabetically.
	toolList = TTCA_Sort(toolList);

	-- Construct the final version of the material list.
	-- Format: selected item, tools, materials.

	-- Add the selected item as the first item in the material list.
	local selectedItem = TTCA_Item:New();
	selectedItem.Name = buildTree[index].Name;
	selectedItem.Type = buildTree[index].Type;
	selectedItem.Texture = buildTree[index].Texture;
	selectedItem.Id = buildTree[index].Id;
	selectedItem.ReagentId = buildTree[index].ReagentId;
	selectedItem.Level = 1;
	tinsert(finalizedMaterialList, selectedItem);

	-- Add the tools to the material list.
	if (getn(toolList) > 0) then

		-- Add a tool header if there is at least one tool.
		local toolHeaderItem = TTCA_Item:New();
		toolHeaderItem.Name = TTCA_TEXT_REQUIREDTOOLS;
		toolHeaderItem.Type = "header";
		toolHeaderItem.Level = 2;
		tinsert(finalizedMaterialList, toolHeaderItem);

		-- Now add the tools.
		for i=1, getn(toolList), 1 do

			local toolItem = TTCA_Item:New()
			toolItem.Name = toolList[i].Name;
			toolItem.Type = toolList[i].Type;
			toolItem.Level = 3;
			tinsert(finalizedMaterialList, toolItem);

		end

	end

	-- Add the materials to the material list.
	if (getn(materialList) > 0) then

		-- Add a material header if there is at least on material.
		local materialHeaderItem = TTCA_Item:New();
		materialHeaderItem.Name = TTCA_TEXT_REQUIREDMATERIALS;
		materialHeaderItem.Type = "header";
		materialHeaderItem.Level = 2;
		tinsert(finalizedMaterialList, materialHeaderItem);

		-- Now add the materials.
		for i=1, getn(materialList), 1 do
		
			local materialItem = materialList[i];
			materialItem.Level = 3;
			tinsert(finalizedMaterialList, materialItem);

		end

	end

	return finalizedMaterialList, constructionList, toolList;

end

-- ============================================================================
-- CreateMaterialConstructionToolListsSub
-- ============================================================================
function TTCA_CreateMaterialConstructionToolListsSub(materialList, constructionList, toolList, buildTree, index, iNumRequired)

	local currentItem = buildTree[index];

	-- If this item is a reagent, add it to the summary.
	if (currentItem.Type == "reagent") then

		if (currentItem.Name == nil) then
			return;
		end

		-- Initialize this reagent information if it hasn't been in the summary
		-- before.
		if (materialList[currentItem.Name] == nil) then
			materialList[currentItem.Name] = {};
			materialList[currentItem.Name].NumRequired = 0;
		end

		-- Add this reagent's information to the summary.
		materialList[currentItem.Name].Name = currentItem.Name;
		materialList[currentItem.Name].Type = currentItem.Type;
		materialList[currentItem.Name].NumAvailable = currentItem.NumAvailable;
		materialList[currentItem.Name].NumRequired = materialList[currentItem.Name].NumRequired + currentItem.NumRequired;
		materialList[currentItem.Name].Texture = currentItem.Texture;
		materialList[currentItem.Name].Id = currentItem.Id;
		materialList[currentItem.Name].ReagentId = currentItem.ReagentId;

	else

		-- This is not a reagent, so add it to the construction list.
		tinsert(constructionList, currentItem);

		-- Get the tools required for this item.
		TTCA_AppendToolsToList(toolList, GetTradeSkillTools(currentItem.Id));

		-- This is not a reagent, so recurse over its reagents.
		local cBuildItems = getn(buildTree);

		for i=index+1, cBuildItems, 1 do

			if (i <= cBuildItems) then

				if (currentItem.Level + 1 == buildTree[i].Level)  then

					TTCA_CreateMaterialConstructionToolListsSub(materialList, constructionList, toolList, buildTree, i, iNumRequired);

				elseif (currentItem.Level == buildTree[i].Level) then

					return;

				end

			end

		end

	end

end

-- ============================================================================
-- AppendToolsToList
-- ============================================================================
function TTCA_AppendToolsToList(list, ...)

	if (not list) then
		return;
	end

	-- Loop over the tools and add each one to the tool list.
	for i=1, arg.n, 2 do

		local toolDetails = {};

		if (arg[i+1] == 1) then
			toolDetails.Type = "selected";
		else
			toolDetails.Type = "unavailable";
		end

		toolDetails.Name = arg[i];
		list[toolDetails.Name] = toolDetails;

	end

end

-- ============================================================================
-- CreateBuildTree
-- ============================================================================
function TTCA_CreateBuildTree(tradeSkillId, buildTree, level, numRequired)

	if ((tradeSkillId <= 0) or (buildTree == nil)) then
		return nil;
	end

	if (level == nil) then
		level = 1;
	end

	if (numRequired == nil) then
		numRequired = 1;
	end

	-- Create a new trade skill item.
	local tradeSkillItem = TTCA_Item:New();
	tradeSkillItem.Name, tradeSkillItem.Type, tradeSkillItem.NumAvailable = TTCA_GetSkillInfo(tradeSkillId);
	tradeSkillItem.Level = level;
	tradeSkillItem.Id = tradeSkillId;
	tradeSkillItem.Texture = TTCA_GetSkillIcon(tradeSkillId);
	tradeSkillItem.NumRequired = numRequired;

	-- Add this item to the trade skill tree.
	tinsert(buildTree, tradeSkillItem);

	-- Create the reagent information for this trade skill.
	local cReagents = TTCA_GetSkillNumReagents(tradeSkillId);

	for i=1, cReagents, 1 do

		-- Get the reagent name.
		local reagentName = TTCA_GetSkillReagentInfo(tradeSkillId, i);

		-- Figure out if the reagent is craftable as a trade skill item.
		local iReagentTradeSkillId = TTCA_FindTradeSkillIdByName(reagentName);

		if (not (iReagentTradeSkillId == nil)) then

			-- Figure out how many are required.
			local name, texture, reagentNumRequired = TTCA_GetSkillReagentInfo(tradeSkillId, i);

			-- The reagent is a craftable item, so create a trade skill item for it.
			local tradeSkillReagentItem = TTCA_CreateBuildTree(iReagentTradeSkillId, buildTree, level + 1, reagentNumRequired * tradeSkillItem.NumRequired);

			-- Initialize some other reagent information.
			tradeSkillReagentItem.Name, tradeSkillReagentItem.Texture, tradeSkillReagentItem.NumRequired, tradeSkillReagentItem.NumAvailable = TTCA_GetSkillReagentInfo(tradeSkillId, i);

			-- Modify the number required by the quantity entered.
			tradeSkillReagentItem.NumRequired = tradeSkillReagentItem.NumRequired * tradeSkillItem.NumRequired;

		else

			-- The reagent is not a craftable item, so get the reagent info for it.

			-- Create a new trade skill item for this reagent.
			local tradeSkillReagentItem = TTCA_Item:New();
			tradeSkillReagentItem.Name, tradeSkillReagentItem.Texture, tradeSkillReagentItem.NumRequired, tradeSkillReagentItem.NumAvailable = TTCA_GetSkillReagentInfo(tradeSkillId, i);
			tradeSkillReagentItem.Level = level + 1;
			tradeSkillReagentItem.Id = tradeSkillId;
			tradeSkillReagentItem.ReagentId = i;
			tradeSkillReagentItem.Type = "reagent";

			-- Sometimes NumAvailable can be nil.  Not yet sure why or how, but let's add some code for when it does.
			if (tradeSkillReagentItem.NumAvailable == nil) then

				DEFAULT_CHAT_FRAME:AddMessage("Congrats!  You've encountered a bug that I'm trying to track down.  Please go to www.wowinterface.com and send a message to twig314159 with the following information:");
				DEFAULT_CHAT_FRAME:AddMessage("ItemName = " .. tradeSkillItem.Name);
				DEFAULT_CHAT_FRAME:AddMessage("ReagentName = " .. tradeSkillReagentItem.Name);
				DEFAULT_CHAT_FRAME:AddMessage("ReagentNumAvailable = " .. tradeSkillReagentItem.NumAvailable);

				-- Fix up NumAvailable if it does happen to be nil.
				tradeSkillReagentItem.NumAvailable = 0;

			end

			-- Modify the number required by the quantity entered.
			tradeSkillReagentItem.NumRequired = tradeSkillReagentItem.NumRequired * tradeSkillItem.NumRequired;

			-- Add this item to the trade skill tree.
			tinsert(buildTree, tradeSkillReagentItem);

		end

	end

	return tradeSkillItem;

end

-- ============================================================================
-- ListItem_OnClick
-- ============================================================================
function TTCA_ListItem_OnClick(button)

	if (button == "LeftButton") then

		local fShift = IsShiftKeyDown();
		local fAlt = IsAltKeyDown();

		-- If the user shift-clicked the item, insert a link to it.
		if (fShift and not fAlt) then

			if (ChatFrameEditBox:IsVisible()) then
				ChatFrameEditBox:Insert(TTCA_GetItemLink(this.Id, this.ReagentId));
			end

		-- If the user alt-clicked the item, link the entire dependency tree.
		-- If the build tree is active, then link all dependencies of the alt-clicked item.
		-- If the materials tree is active, then link only the materials listed in that view.
		elseif (fAlt and not fShift) then

			-- If the chat edit box is not visible, just bail so we don't waste time
			-- iterating only to do nothing.
			if (not ChatFrameEditBox:IsVisible()) then
				return;
			end

			-- The chat box is visible, so figure out who/what we're chatting with
			-- so we can send each item as a seperate message and make sure it goes
			-- to the right destination.
			ChatEdit_ParseText(ChatFrameEditBox, 0);
			local chatType = ChatFrameEditBox.chatType;
			local chatLanguage = ChatFrameEditBox.language;
			local chatTarget = nil;

			-- Set the chat target.
			if (chatType == "WHISPER") then
				chatTarget = ChatFrameEditBox.tellTarget;
			elseif (chatType == "CHANNEL") then
				chatTarget = ChatFrameEditBox.channelTarget;
			end

			-- Link the dependency tree.
			if (vTTCA_ActiveTab == TTCA_TAB_BUILDTREE) then

				local cBuildItems = getn(vTTCA_BuildTree);

				-- Loop through the build tree so we can link each item that this item depends on.
				for i=this.Index, cBuildItems, 1 do

					local buildTreeItem = vTTCA_BuildTree[i];

					if (buildTreeItem ~= nil) then

						local text = "";

						-- Generate a nice little header first.
						if (i == this.Index) then

							text = TTCA_TEXT_MATERIALSFOR .. TTCA_GetItemLink(buildTreeItem.Id, buildTreeItem.ReagentId);

						else

							-- If we arrive back at the same level we started, then we're done!
							if (buildTreeItem.Level == vTTCA_BuildTree[this.Index].Level) then
								return;
							end

							-- Otherwise, ident the item and dump it to the chat window.
							for n=vTTCA_BuildTree[this.Index].Level, buildTreeItem.Level, 1 do
								text = text .. "  ";
							end

							text = text .. TTCA_GetItemLink(buildTreeItem.Id, buildTreeItem.ReagentId) .. " x" .. buildTreeItem.NumRequired;

						end
						
						if (text ~= nil) then

							-- Now send the text and add it to the chat history.
							SendChatMessage(text, chatType, chatLanguage, chatTarget);
							ChatFrameEditBox:AddHistoryLine(text);

						end

					end

				end				

			-- Link all the raw materials.
			elseif (vTTCA_ActiveTab == TTCA_TAB_MATERIALS) then

				-- Find the total number of materials.
				local cMaterialItems = getn(vTTCA_MaterialList);

				-- Loop through the material list so we can link each one.
				for i=1, cMaterialItems, 1 do

					local materialListItem = vTTCA_MaterialList[i];

					if (materialListItem.Name ~= nil) then

						local text = nil;

						-- Generate a nice little header first.
						if (i == 1) then
							text = TTCA_TEXT_MATERIALSFOR .. TTCA_GetItemLink(materialListItem.Id, materialListItem.ReagentId);
						end

						-- We want to link only reagents (not headers, tools, etc).
						if (materialListItem.Type == "reagent") then

							text = "  " .. TTCA_GetItemLink(materialListItem.Id, materialListItem.ReagentId) .. " x" .. materialListItem.NumRequired;

						end

						if (text ~= nil) then

							-- Now send the text and add it to the chat history.
							SendChatMessage(text, chatType, chatLanguage, chatTarget);
							ChatFrameEditBox:AddHistoryLine(text);

						end

					end

				end

			end			

		-- Otherwise, just make the item the currently selected item.
		else

			if (vTTCA_ActiveTab == TTCA_TAB_BUILDTREE) then

				TTCA_SetSelection(this.Index);
				TTCA_Update();

			end

		end

	end

end

-- ============================================================================
-- ListItem_OnEnter
-- ============================================================================
function TTCA_ListItem_OnEnter()

	if (this.Id) then

		GameTooltip:SetOwner(this, "ANCHOR_UPPERLEFT");

		if (TTCA_IsCraftFrameVisible()) then
			GameTooltip:SetCraftItem(this.Id, this.ReagentId);
		else
			GameTooltip:SetTradeSkillItem(this.Id, this.ReagentId);
		end

	end

end

-- ============================================================================
-- ListItem_OnLeave
-- ============================================================================
function TTCA_ListItem_OnLeave()

	GameTooltip:Hide();

end

-- ============================================================================
-- CreateTree_OnClick
-- ============================================================================
function TTCA_CreateTree_OnClick(createAll)

	-- Set the building tree flag.
	vfTTCA_BuildingTree = true;

	-- Set the flag that says we're trying to build as many as we can.
	vfTTCA_BuildingAll = createAll;

	TTCA_BuildNextItem(vTTCA_ConstructionList);

end

-- ============================================================================
-- Tab_OnClick
-- ============================================================================
function TTCA_Tab_OnClick(activateTab)

	if (vTTCA_ActiveTab ~= activateTab) then

		-- Reset the scroll frame.
		TTCA_Reset();

		-- Deselect all of the tabs.
		PanelTemplates_DeselectTab(TTCA_Tab_BuildTree);
		PanelTemplates_DeselectTab(TTCA_Tab_Materials);

		-- Select the tab the user clicked.
		vTTCA_ActiveTab = activateTab;
		PanelTemplates_SelectTab(this);

		-- Update the frame list.
		TTCA_Update();

	end

end

-- ============================================================================
-- IncrementQuantity_OnClick
-- ============================================================================
function TTCA_IncrementQuantity_OnClick(delta)

	local iNewNumber = TTCA_InputBox_Quantity:GetNumber() + delta;

	if ((iNewNumber > 0) and (iNewNumber < 100)) then

		TTCA_InputBox_Quantity:SetNumber(iNewNumber);

		-- Since the number has changed, we need to update our build tree.
		TTCA_Update();

	end

end

-- ============================================================================
-- BuildNextItem
-- ============================================================================
function TTCA_BuildNextItem(constructionList)

	local cItems = getn(constructionList);

	-- Loop through each item in the list and build it if we have all the
	-- reagents available.
	for i=1, cItems, 1 do

		local currentItem = constructionList[i];

		local tradeSkillDetails = {};
		tradeSkillDetails.Name, tradeSkillDetails.Type, tradeSkillDetails.NumAvailable = TTCA_GetSkillInfo(currentItem.Id);

		if ((tradeSkillDetails.NumAvailable > 0) and (currentItem.NumAvailable <= currentItem.NumRequired) and (i==1)) then

			-- If we built the first item in the list and not building as many as
			-- we can, then we're done!
			if (not vfTTCA_BuildingAll) then
				vfTTCA_BuildingTree = false;
			end

			TTCA_DoSkill(currentItem.Id, 1);

			-- This means we built our intended target.  So, decrement the quantity by 1.
			-- If it would be zero, then we really are done.  If not, keep building.
			if (TTCA_InputBox_Quantity:GetNumber() - 1 > 0) then

				TTCA_IncrementQuantity_OnClick(-1);
				vfTTCA_BuildingTree = true;

			end

			return;

		elseif ((tradeSkillDetails.NumAvailable > 0) and (currentItem.NumAvailable < currentItem.NumRequired)) then

			TTCA_DoSkill(currentItem.Id, 1);

			return;

		end

	end

	-- If we made it here, then we went through the whole build list and found
	-- nothing to build, so stop trying.
	vfTTCA_BuildingTree = false;
	vfTTCA_BuildingAll = false;

end

-- ============================================================================
-- IsItemBuildable
-- ============================================================================
function TTCA_IsItemBuildable(buildTree, index, iNumRequired)

	if (iNumRequired == nil) then
		iNumRequired = 1;
	end

	local currentItem = buildTree[index];

	if (currentItem == nil) then
		return false;
	end

	-- If this item is a reagent, report that it is buildable as long as we
	-- have enough.
	if (currentItem.Type == "reagent") then

		if (currentItem.NumAvailable >= currentItem.NumRequired) then

			return true;

		end

	else

		-- This item is not a regeant, so only report it is buildable if all of
		-- its children are buildable or we already have enough of them.
		local fIsBuildable = true;

		if (currentItem.NumAvailable >= currentItem.NumRequired) then

			return fIsBuildable;

		end

		local cBuildItems = getn(buildTree);

		for i=index+1, cBuildItems, 1 do

			if (i <= cBuildItems) then

				if (currentItem.Level + 1 == buildTree[i].Level) then

					if (not TTCA_IsItemBuildable(buildTree, i, currentItem.NumRequired)) then

						fIsBuildable = false;

					end

				elseif (currentItem.Level == buildTree[i].Level) then

					return fIsBuildable;

				end

			end

		end

		return fIsBuildable;

	end

	return false;

end

-- ============================================================================
-- Sort
-- ============================================================================
function TTCA_Sort(dictionary)

	local sortedList = {};

	-- Convert out dictionary list into an array.
	for key, value in dictionary do
		tinsert(sortedList, value);
	end

	-- Sort the array by the .Name property.
	sort(sortedList, function(a, b) return a.Name < b.Name end);

	return sortedList;

end

-- ============================================================================
-- LinkItem
--
-- Returns a link to the given item.  This link can then be used in a chat box.
-- ============================================================================
function TTCA_GetItemLink(itemId, reagentId)

	if (itemId and reagentId == nil) then
		return TTCA_GetSkillItemLink(itemId);
	elseif (itemId and reagentId) then
		return TTCA_GetSkillReagentItemLink(itemId, reagentId);
	end

	return nil;

end

function TTCA_IsCraftFrameVisible()

	return (CraftFrame ~= nil and CraftFrame:IsVisible());

end

function TTCA_GetTradeSkillOrCraftFrameName()

	if (TradeSkillFrame ~= nil and TradeSkillFrame:IsVisible()) then
		return TradeSkillFrame:GetName();
	elseif (CraftFrame ~= nil and CraftFrame:IsVisible()) then
		return CraftFrame:GetName();
	else
		return nil;
	end

end

function TTCA_GetSkillSelectionIndex()

	if (TTCA_IsCraftFrameVisible()) then
		return GetCraftSelectionIndex();
	else
		return GetTradeSkillSelectionIndex();
	end

end

function TTCA_GetNumSkills()

	if (TTCA_IsCraftFrameVisible()) then
		return GetNumCrafts();
	else
		return GetNumTradeSkills();
	end

end

function TTCA_GetSkillInfo(i)

	local name, subName, type, numAvailable, isExpanded;

	if (TTCA_IsCraftFrameVisible()) then
		name, subName, type, numAvailable, isExpanded = GetCraftInfo(i);
	else
		name, type, numAvailable, isExpanded = GetTradeSkillInfo(i);
	end

	return name, type, numAvailable, isExpanded;

end

function TTCA_GetSkillIcon(i)

	if (TTCA_IsCraftFrameVisible()) then
		return GetCraftIcon(i);
	else
		return GetTradeSkillIcon(i);
	end

end

function TTCA_GetSkillNumReagents(i)

	if (TTCA_IsCraftFrameVisible()) then
		return GetCraftNumReagents(i);
	else
		return GetTradeSkillNumReagents(i);
	end

end

function TTCA_GetSkillReagentInfo(index, reagentIndex)

	if (TTCA_IsCraftFrameVisible()) then
		return GetCraftReagentInfo(index, reagentIndex);
	else
		return GetTradeSkillReagentInfo(index, reagentIndex);
	end

end

function TTCA_DoSkill(i, n)

	if (TTCA_IsCraftFrameVisible()) then
		return DoCraft(i);
	else
		return DoTradeSkill(i, n);
	end

end

function TTCA_GetSkillItemLink(itemId)

	if (TTCA_IsCraftFrameVisible()) then
		return GetCraftItemLink(itemId);
	else
		return GetTradeSkillItemLink(itemId);
	end

end

function TTCA_GetSkillReagentItemLink(itemId, reagentId)

	if (TTCA_IsCraftFrameVisible()) then
		return GetCraftReagentItemLink(itemId, reagentId);
	else
		return GetTradeSkillReagentItemLink(itemId, reagentId);
	end

end

