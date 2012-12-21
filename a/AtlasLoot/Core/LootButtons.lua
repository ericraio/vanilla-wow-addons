local GREY = "|cff999999";
local RED = "|cffff0000";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";

--------------------------------------------------------------------------------
-- Item OnEnter
-- Called when a loot item is moused over
--------------------------------------------------------------------------------
function AtlasLootItem_OnEnter()
    local yOffset;
    if(this.itemID ~= 0 and this.itemID ~= "" and this.itemID ~= nil) then
        Identifier = "Item"..this.itemID;
        DKP = AtlasLootDKPValues[Identifier];
        priority = AtlasLootClassPriority[Identifier];
    else
        DKP = nil;
        priority = nil;
    end
    --Lootlink tooltips
    if( AtlasLootOptions.LootlinkTT ) then
        --If we have seen the item, use the game tooltip to minimise same name item problems
        if(GetItemInfo(this.itemID) ~= nil) then
            AtlasLootTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
            AtlasLootTooltip:SetHyperlink("item:"..this.itemID..":0:0:0");
            if( this.droprate ~= nil) then
                AtlasLootTooltip:AddLine(ATLASLOOT_DROP_RATE..this.droprate, 1, 1, 0);
            end
            if( DKP ~= nil and DKP ~= "" ) then
                AtlasLootTooltip:AddLine(RED..DKP.." "..ATLASLOOT_DKP, 1, 1, 0);
            end
            if( priority ~= nil and priority ~= "" ) then
                AtlasLootTooltip:AddLine(GREEN..ATLASLOOT_PRIORITY.." "..priority, 1, 1, 0);
            end
            AtlasLootTooltip:Show();
        else
            AtlasLootTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
            LootLink_SetTooltip(AtlasLootTooltip, strsub(getglobal("AtlasLootItem_"..this:GetID().."_Name"):GetText(), 11), 1);
            if( this.droprate ~= nil) then
                AtlasLootTooltip:AddLine(ATLASLOOT_DROP_RATE..this.droprate, 1, 1, 0);
            end
            if( DKP ~= nil and DKP ~= "" ) then
                AtlasLootTooltip:AddLine(RED..DKP.." "..ATLASLOOT_DKP, 1, 1, 0);
            end
            if( priority ~= nil and priority ~= "" ) then
                AtlasLootTooltip:AddLine(GREEN..ATLASLOOT_PRIORITY.." "..priority, 1, 1, 0);
            end
            AtlasLootTooltip:Show();
        end
    --Item Sync tooltips
    elseif( AtlasLootOptions.ItemSyncTT ) then
        ISync:ButtonEnter();
        if( this.droprate ~= nil) then
            GameTooltip:AddLine(ATLASLOOT_DROP_RATE..this.droprate, 1, 1, 0);
            GameTooltip:Show();
        end
        if( DKP ~= nil and DKP ~= "" ) then
            AtlasLootTooltip:AddLine(RED..DKP.." "..ATLASLOOT_DKP, 1, 1, 0);
        end
        if( priority ~= nil and priority ~= "" ) then
            AtlasLootTooltip:AddLine(GREEN..ATLASLOOT_PRIORITY.." "..priority, 1, 1, 0);
        end
    --Default game tooltips
    else
        if(this.itemID ~= nil) then
            if(GetItemInfo(this.itemID) ~= nil) then
                AtlasLootTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                AtlasLootTooltip:SetHyperlink("item:"..this.itemID..":0:0:0");
                if( this.droprate ~= nil) then
                    AtlasLootTooltip:AddLine(ATLASLOOT_DROP_RATE..this.droprate, 1, 1, 0);
                end
                if( DKP ~= nil and DKP ~= "" ) then
                    AtlasLootTooltip:AddLine(RED..DKP.." "..ATLASLOOT_DKP, 1, 1, 0);
                end
                if( priority ~= nil and priority ~= "" ) then
                    AtlasLootTooltip:AddLine(GREEN..ATLASLOOT_PRIORITY.." "..priority, 1, 1, 0);
                end
                AtlasLootTooltip:Show();
            else
                AtlasLootTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                AtlasLootTooltip:ClearLines();
                AtlasLootTooltip:AddLine(RED..ATLASLOOT_ERRORTOOLTIP_L1);
                AtlasLootTooltip:AddLine(BLUE..ATLASLOOT_ERRORTOOLTIP_L2.." "..this.itemID);
                AtlasLootTooltip:AddLine(ATLASLOOT_ERRORTOOLTIP_L3);
                AtlasLootTooltip:Show();
            end
        end
    end
end

--------------------------------------------------------------------------------
-- Item OnLeave
-- Called when the mouse cursor leaves a loot item
--------------------------------------------------------------------------------
function AtlasLootItem_OnLeave()
    --Hide the necessary tooltips
    if( AtlasLootOptions.LootlinkTT ) then
        AtlasLootTooltip:Hide();
    elseif( AtlasLootOptions.ItemSyncTT ) then
        if(GameTooltip:IsVisible()) then
            GameTooltip:Hide();
        end
    else
        if(this.itemID ~= nil) then
		    AtlasLootTooltip:Hide();
            GameTooltip:Hide();
	    end
    end
end

--------------------------------------------------------------------------------
-- Item OnClick
-- Called when a loot item is clicked on
--------------------------------------------------------------------------------
function AtlasLootItem_OnClick()
	local color = strsub(getglobal("AtlasLootItem_"..this:GetID().."_Name"):GetText(), 1, 10);
	local id = this:GetID();
	local name = strsub(getglobal("AtlasLootItem_"..this:GetID().."_Name"):GetText(), 11);
	local iteminfo = GetItemInfo(this.itemID);
    --If shift-clicked, link in the chat window
	if(ChatFrameEditBox:IsVisible() and IsShiftKeyDown() and iteminfo and (AtlasLootOptions.SafeLinks or AtlasLootOptions.AllLinks)) then
    	ChatFrameEditBox:Insert(color.."|Hitem:"..this.itemID..":0:0:0|h["..name.."]|h|r");
	elseif(ChatFrameEditBox:IsVisible() and IsShiftKeyDown() and AtlasLootOptions.AllLinks) then
		ChatFrameEditBox:Insert(color.."|Hitem:"..this.itemID..":0:0:0|h["..name.."]|h|r");
    elseif(ChatFrameEditBox:IsVisible()) then
		ChatFrameEditBox:Insert(name);
    --If control-clicked, use the dressing room
    elseif(IsControlKeyDown() and iteminfo) then
        DressUpItemLink(this.itemID);
	end
end
