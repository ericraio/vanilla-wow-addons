local SlotIdText = {
		[1]  = "HeadSlot",
		[2]  = "NeckSlot", 
		[3]  = "ShoulderSlot",
		[4]  = "ShirtSlot",
		[5]  = "ChestSlot",
		[6]  = "WaistSlot",
		[7]  = "LegsSlot",
		[8]  = "FeetSlot",
		[9]  = "WristSlot",
		[10] = "HandsSlot",
		[11] = "Finger0Slot",
		[12] = "Finger1Slot",
		[13] = "Trinket0Slot",
		[14] = "Trinket1Slot",
		[15] = "BackSlot",
		[16] = "MainHandSlot",
		[17] = "SecondaryHandSlot",
		[18] = "RangedSlot",
		[19] = "TabardSlot",
			};
		-- [19] = "AmmoSlot",

GuildAdsInspect = {};

local function DEBUG_MSG(msg)
	if (GUILDADS_DEBUG)
	then
		ChatFrame1:AddMessage(msg, 0.9, 0.9, 0.7);
	end
end

function GuildAdsInspectItemSlotButton_OnClick(button)
	if ( button == "LeftButton" ) then
		if ( IsShiftKeyDown() ) then
			if ( ChatFrameEditBox:IsVisible() ) then
				ChatFrameEditBox:Insert(GuildAdsInspect[this:GetID()]);
			end
		end
	end
end

function GuildAdsInspectItemSlotButton_OnEnter()
	if (GuildAdsInspect[this:GetID()] ~= nil) then
		GuildAdsInspect_SetTooltipItem(GuildAdsInspect[this:GetID()]);
	end
end

function GuildAdsInspectItemSlotButton_OnLeave()
	GameTooltip:Hide();
end

function GuildAdsInspect_SetAuthor(author, title)
	GuildAdsInspectName:SetText(author);
	GuildAdsInspectTitle:SetText(title);
	GuildAdsInspectTime:SetText("");
	GuildAdsInspectAuthor = author;
	for slot=1,19,1 do
		GuildAdsInspectItemSlotButton_Update(author, slot, nil, nil, 0);
	end
	GuildAdsInspectFrame:Show();
end

function GuildAdsInspect_SetTime(author, inspectTime)
	if (author ~= GuildAdsInspectAuthor) then
		return;
	end
	GuildAdsInspectTime:SetText(inspectTime);
end

function GuildAdsInspectItemSlotButton_OnLoad()
	local slotName = this:GetName();
	local id;
	local textureName;
	id, textureName = GetInventorySlotInfo(strsub(slotName,16));
	this:SetID(id);
	local texture = getglobal(slotName.."IconTexture");
	texture:SetTexture(textureName);
	this.backgroundTextureName = textureName;
end

function GuildAdsInspect_SetTooltipItem(itemRef)
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	if (itemRef) then
		GameTooltip:SetHyperlink(itemRef);
		GuildAds_GameTooltip_AddTT(nil, itemRef, nil, 1);
	end
end

function GuildAdsInspectItemSlotButton_Update(author, slot, itemRef, textureName, count)
	if (author ~= GuildAdsInspectAuthor) then
		return;
	end
	DEBUG_MSG("[GuildAdsInspectItemSlotButton_Update] slot: "..slot);
	button = getglobal("GuildAdsInspect"..SlotIdText[slot]);
	if ( textureName ) then
		SetItemButtonTexture(button, textureName);
		SetItemButtonCount(button, count);
		GuildAdsInspect[slot]= itemRef;
	else
		SetItemButtonTexture(button, button.backgroundTextureName);
		SetItemButtonCount(button, 0);
		GuildAdsInspect[slot] = nil;
	end
	
	if ( GameTooltip:IsOwned(button) ) then
		if ( textureName ) then
			GuildAdsInspect_SetTooltipItem(itemRef);
		else
			GameTooltip:Hide();
		end
	end
end

function GuildAdsInspectUser(user)
	-- Init GuildAdsInspect
	local title = GuildAds_GetPlayerInfo(user);
	GuildAdsInspect_SetAuthor(user, title);
	GuildAdsInspect_SetTime(user, "");
		
	-- Set inventory to the cache value
	timeToSet = true;
	local inventory = GAS_ProfileGetInventory(user);
	for slot, data in inventory do
		if (slot == "creationtime") then
			GuildAdsInspect_SetTime(user, GAS_timeToString(data));
		else
			GuildAdsInspectItemSlotButton_Update(user, slot, data.ref, data.texture, data.count);
		end
	end
	-- Send inspect request
	GAC_SendRequestInspect(user);
end