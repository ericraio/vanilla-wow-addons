---------------------------------------------
-- Hook functions to track picked up items --
---------------------------------------------
SAS_original_PickupAction = PickupAction;
function SAS_PickupAction(slot)
	local PlrName = SASFrame.PlrName;
	local itemInfo = SAS_GetMissingItemInfo( slot );
	if ( not SAS_SwappingSet ) then
		SAS_SavedPickup = SAS_BuildActionInfo(SAS_GetActionInfo(slot));
		if ( SAS_SavedPickup ) then
			SASDebug("Picked up action "..SAS_ParseActionInfo(SAS_SavedPickup, 1).." from slot "..slot );
			SAS_ReturnAction = slot;
			SASFakeDrag_Drop(1);
		end
	end
	if ( itemInfo and HasAction(slot) ) then
		SASDebug( "Removing missing item from action "..slot..". Attempted to pick up." );
		SAS_Saved[PlrName]["MissingItems"][slot] = nil;
		SAS_ForceUpdate( slot );
	end
	SAS_original_PickupAction(slot);
end
PickupAction = SAS_PickupAction;

SAS_original_PlaceAction = PlaceAction;
function SAS_PlaceAction(slot)
	if ( not SAS_SwappingSet ) then
		SAS_ReturnAction = nil;
		SASDebug("Place action "..slot);
		SAS_SavedPickup = SAS_BuildActionInfo(SAS_GetActionInfo(slot));
		if ( SAS_SavedPickup ) then
			SASDebug("Placed action "..SAS_ParseActionInfo(SAS_SavedPickup, 1).." from slot "..slot );
			SASFakeDrag_Drop(1);
		end
	end
	SAS_original_PlaceAction(slot);
end
PlaceAction = SAS_PlaceAction;

SAS_original_UseAction = UseAction;
function SAS_UseAction(slot, check, onSelf)
	if ( not SAS_SwappingSet ) then
		SAS_ReturnAction = nil;
		SAS_SavedPickup = SAS_BuildActionInfo(SAS_GetActionInfo(slot));
		if ( SAS_SavedPickup ) then
			SASFakeDrag_Drop(1);
			SASDebug("Use action "..SAS_ParseActionInfo(SAS_SavedPickup, 1).." from slot "..slot );
		end
	end
	SAS_original_UseAction(slot, check, onSelf);
end
UseAction = SAS_UseAction;

SAS_original_PickupContainerItem = PickupContainerItem;
function SAS_PickupContainerItem( bag, slot )
	if ( not SAS_SwappingSet ) then
		SAS_ReturnAction = nil;
		local itemLink = GetContainerItemLink( bag, slot );
		if ( itemLink ) then
			local name = SAS_FindName(itemLink);
			local link = SAS_FindLink(itemLink);
			local texture = GetContainerItemInfo( bag, slot );
			SAS_SavedPickup = SAS_BuildActionInfo( name, texture, nil, link );
			SASFakeDrag_Drop(1);
			SASDebug("Pick up container item "..name.." from "..bag..", "..slot );
		end
	end
	SAS_original_PickupContainerItem( bag, slot );
end
PickupContainerItem = SAS_PickupContainerItem;

SAS_original_PickupInventoryItem = PickupInventoryItem;
function SAS_PickupInventoryItem(index)
	if ( not SAS_SwappingSet ) then
		SAS_ReturnAction = nil;
		local itemLink = GetInventoryItemLink( "player", index );
		if ( itemLink ) then
			local name = SAS_FindName(itemLink);
			local link = SAS_FindLink(itemLink);
			local texture = GetInventoryItemTexture( "player", index );
			SAS_SavedPickup = SAS_BuildActionInfo( name, texture, nil, link );
			SASFakeDrag_Drop(1);
			SASDebug("Pick up inventory item "..name.." from "..index );
		end
	end
	SAS_original_PickupInventoryItem(index);
end
PickupInventoryItem = SAS_PickupInventoryItem;

SAS_original_PickupMacro = PickupMacro;
function SAS_PickupMacro(index)
	if ( not SAS_SwappingSet ) then
		SAS_ReturnAction = nil;
		local name, texture = GetMacroInfo(index);
		local macro = GetMacroIndexByName(name);
		if ( name ) then
			SAS_SavedPickup = SAS_BuildActionInfo( name, texture, nil, nil, macro );
			SASFakeDrag_Drop(1);
			SASDebug("Pick up macro "..name.." from "..index );
		end
	end
	SAS_original_PickupMacro(index);
end
PickupMacro = SAS_PickupMacro;

SAS_original_PickupSpell = PickupSpell;
function SAS_PickupSpell(id, bookType)
	if ( not SAS_SwappingSet ) then
		SAS_ReturnAction = nil;
		local name, rank = GetSpellName( id, bookType );
		local texture = GetSpellTexture( id, bookType );
		if ( name ) then
			SAS_SavedPickup = SAS_BuildActionInfo( name, texture, rank );
			SASFakeDrag_Drop(1);
			SASDebug("Pick up spell "..name.." from "..id);
			local passive = IsSpellPassive( id, bookType );
			if ( passive ) then
				SASDebug("Spell is passive? Why can we pick this up?");
			end
			SAS_SavedPickup = SAS_BuildActionInfo( name, texture, rank, nil, nil, passive );
		end
	end
	SAS_original_PickupSpell(id, bookType);
end
PickupSpell = SAS_PickupSpell;


--------------------------------------------
-- Hook functions to drop fake drag frame --
--------------------------------------------

SAS_original_WorldFrameOnMouseDown = WorldFrame:GetScript("OnMouseDown");
WorldFrame:SetScript("OnMouseDown", function()
	SASFakeDrag_Drop(1);
	if ( SAS_original_WorldFrameOnMouseDown ) then
		SAS_original_WorldFrameOnMouseDown();
	end
end);

-------------------------------------------
-- Hook functions to show missing items --
-------------------------------------------

SAS_original_GetActionTexture = GetActionTexture;
function SAS_GetActionTexture( id )
	local PlrName = SASFrame.PlrName;
	local texture = SAS_original_GetActionTexture( id );
	local itemInfo = SAS_GetMissingItemInfo( id );
	if ( itemInfo ) then
		if ( texture ) then
			SASDebug( "Removing missing item from action "..id..". Real action exists." );
			SAS_Saved[PlrName]["MissingItems"][id] = nil;
			SAS_ForceUpdate( id );
		else
			return SAS_FullPath(SAS_ParseActionInfo(itemInfo, 2));
		end
	end
	return texture;
end
GetActionTexture = SAS_GetActionTexture;

SAS_original_IsConsumableAction = IsConsumableAction;
function SAS_IsConsumableAction( id )
	if ( SAS_GetMissingItemInfo( id ) ) then
		return 1;
	end
	return SAS_original_IsConsumableAction( id );
end
IsConsumableAction = SAS_IsConsumableAction;

SAS_original_HasAction = HasAction;
function SAS_HasAction( id )
	if ( SAS_GetMissingItemInfo( id ) ) then
		return 1;
	end
	return SAS_original_HasAction( id );
end
HasAction = SAS_HasAction;

SAS_original_SetAction = GameTooltip.SetAction;
function SAS_SetAction( this, id )
	local PlrName = SASFrame.PlrName;
	local itemInfo = SAS_GetMissingItemInfo( id );
	if ( itemInfo ) then
		local name, link = SAS_ParseActionInfo( itemInfo, 1, 4);
		if ( link and GetItemInfo("item:"..link) ) then
			TooltipReturn = GameTooltip:SetHyperlink("item:"..link);
			if ( not SAS_Saved[PlrName]["HideFakeItemTooltips"] ) then
				SASTooltipAddLine( SAS_TEXT_TOOLTIP_GENERATEDACTION );
				if ( IsShiftKeyDown() or SAS_IsValidAction ) then
					SASTooltipAddLine( SAS_TEXT_TOOLTIP_FAKEACTIONWARN );
				end
			end
			GameTooltip:Show();
			--return 1;
			return;
		else
			TooltipReturn = GameTooltip:SetText( name, 1, 1, 1 );
			SASTooltipAddLine( SAS_TEXT_TOOLTIP_NOTVALID );
			if ( not SAS_Saved[PlrName]["HideFakeItemTooltips"] ) then
				SASTooltipAddLine( SAS_TEXT_TOOLTIP_GENERATEDACTION );
				if ( IsShiftKeyDown() or SAS_IsValidAction ) then
					SASTooltipAddLine( SAS_TEXT_TOOLTIP_FAKEACTIONWARN );
				end
			end
			GameTooltip:Show();
			--return 1;
			return;
		end
	end
	return SAS_original_SetAction( this, id );
end
GameTooltip.SetAction = SAS_SetAction;
