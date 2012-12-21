-- **************************************************************************
-- * TitanSoulShardCounter.lua
-- **************************************************************************
-- * by Candar @ Darkspear <candar-at-fornander,com>
-- *
-- * Credits: based on code from evil.oz, Pieter Walsweer, Kefka D'Arden
-- **************************************************************************


-- ************************************* Const / defines *************************************
TITAN_SOULSHARDSCOUNTER_ID = "SoulShardCounter";
TITAN_SOULSHARDSCOUNTER_COUNT_FORMAT = "%d";
TITAN_SOULSHARDSCOUNTER_TOOLTIP = "SoulShardCounter Tooltip";
TITAN_SOULSHARDSCOUNTER_ICON = "Interface\\Icons\\INV_Misc_Gem_Amethyst_02.blp"

-- ************************************* Variables *******************************************
numSoulShard = 0;
timer = 0;


-- ************************************* Functions *******************************************
-- *******************************************************************************************
-- Name: TitanPanelSoulShardCounterButton_OnLoad
-- Desc: This function registers SoulShardCounter Addon.
-- *******************************************************************************************
function TitanPanelSoulShardCounterButton_OnLoad()
	this.registry = {
		id = TITAN_SOULSHARDSCOUNTER_ID,
		menuText = TITAN_SOULSHARDSCOUNTER_MENU_TEXT,
		buttonTextFunction = "TitanPanelSoulShardCounterButton_GetButtonText",
		tooltipTitle = TITAN_SOULSHARDSCOUTER_TOOLTIP,
		category = "Information",
		tooltipTextFunction = "TitanPanelSoulShardCounterButton_GetTooltipText",
		icon = TITAN_SOULSHARDSCOUNTER_ICON,
		iconWidth = 16,
		frequency = 1,
		savedVariables = {
			ShowLabelText = 1,
			ShowIcon = 1,
			WarnWhenLow = 1,
			WarnThreshold = 1,
			WarnTimer = 60
		}
	};
	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	this:RegisterEvent("VARIABLES_LOADED");
end


-- *******************************************************************************************
-- Name: TitanPanelSoulShardCounterButton_GetButtonText
-- Desc: Gets our button text, the text that appears on the actual bar, all the time.
-- *******************************************************************************************
function TitanPanelSoulShardCounterButton_GetButtonText(id)
	-- Update timer
	timer = timer + 1;

	-- If id not nil, return corresponding plugin button
	-- Otherwise return this button and derive the real id
	local button, id = TitanUtils_GetButton(id, true);

	-- Business logic goes here
	numSoulShard = SoulShardCounter_CountSoulShard();

	-- Warn if low on shards
	if ( 	TitanGetVar(TITAN_SOULSHARDSCOUNTER_ID, "WarnThreshold") >= numSoulShard and 
			TitanGetVar(TITAN_SOULSHARDSCOUNTER_ID, "WarnTimer") <= timer and
			TitanGetVar(TITAN_SOULSHARDSCOUNTER_ID, "WarnWhenLow") )
	then
		TitanPanelSoulShardCounter_WarningFrame:AddMessage(TITAN_SOULSHARDSCOUNTER_ITEMNAME, 1.0, 0, 0, 1.0, 1);		
		PlaySoundFile("Sound\\interface\\mapping.wav")
		timer = 0;
	end

	local countText = format(TITAN_SOULSHARDSCOUNTER_COUNT_FORMAT, numSoulShard);
	local richText;

	if ( 	TitanGetVar(TITAN_SOULSHARDSCOUNTER_ID, "WarnThreshold") >= numSoulShard ) then
		richText = TitanUtils_GetColoredText(countText, RED_FONT_COLOR);
	else
		richText = countText;
	end

	return TITAN_SOULSHARDSCOUNTER_BUTTON_LABEL, richText;
end


-- *******************************************************************************************
-- Name: TitanPanelSoulShardCounterButton_GetTooltipText
-- Desc: Gets our tool-tip text, what appears when we hover over our item on the Titan bar.
-- *******************************************************************************************
function TitanPanelSoulShardCounterButton_GetTooltipText()
	return TITAN_SOULSHARDSCOUNTER_TOOLTIPTEXT;
end


-- *******************************************************************************************
-- Name: SoulShardCounter_CountSoulShard
-- Desc: Counts number of Sacred SoulShard currently in player's bag.
-- *******************************************************************************************
function SoulShardCounter_CountSoulShard()
	local shards = 0;
	local bag, slot = 0;
	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
		local itemName = GetContainerItemLink(bag, slot);
			if itemName then
				if string.find(itemName, "%["..TITAN_SOULSHARDSCOUNTER_ITEMNAME.."%]") then
					local texture, count = GetContainerItemInfo(bag, slot);
					shards = shards + count;
				end
			end
		end
	end
	return shards;
end


-- *******************************************************************************************
-- Name: TitanPanelRightClickMenu_PrepareSoulShardCounterMenu
-- Desc: Builds the config menu
-- *******************************************************************************************
function TitanPanelRightClickMenu_PrepareSoulShardCounterMenu()
	-- Menu title
	TitanPanelRightClickMenu_AddTitle(TITAN_SOULSHARDSCOUNTER_ITEMNAME);	
	
	-- A blank line in the menu
	TitanPanelRightClickMenu_AddSpacer();	
	
	-- Low warning on or off
	TitanPanelRightClickMenu_AddToggleVar(TITAN_SOULSHARDSCOUNTER_WARN_LOW, TITAN_SOULSHARDSCOUNTER_ID, "WarnWhenLow");	

	-- A blank line in the menu
	TitanPanelRightClickMenu_AddSpacer();	

	-- Generic function to toggle and hide
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_SOULSHARDSCOUNTER_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_SOULSHARDSCOUNTER_ID);
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_SOULSHARDSCOUNTER_ID, TITAN_PANEL_MENU_FUNC_HIDE);


end
