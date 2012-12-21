--[[
	DynamicData

	By sarf

	This mod allows you to access dynamic data in WoW without being forced to rely on strange Blizzard functions

	Thanks goes to the UltimateUI team, the nice (but strange) people at #ultimateuitesters and Blizzard.
	
	UltimateUIUI URL:
	http://www.ultimateuiui.org/forums/viewtopic.php?t=NOT_YET_ANNOUNCED
	
   ]]

function DynamicDataItemScriptFrame_OnLoad()
	-- item events
	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("BAG_UPDATE_COOLDOWN");
	this:RegisterEvent("ITEM_LOCK_CHANGED");
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	this:RegisterEvent("UPDATE_INVENTORY_ALERTS");

	DynamicData.item.OnLoad();
end

function DynamicDataItemScriptFrame_OnEvent(event)
	-- item events
	if ( event == "BAG_UPDATE" ) then
		DynamicData.item.updateItems(arg1);
	end
	if ( event == "BAG_UPDATE_COOLDOWN" ) then
		DynamicData.item.updateItemCooldowns();
	end
	if ( event == "ITEM_LOCK_CHANGED" ) then
		DynamicData.item.updateItemLocks();
	end
	if ( event == "UNIT_INVENTORY_CHANGED" ) then
		if ( arg1 == "player" ) then
			DynamicData.item.updateItems(-1);
		end
	end
	if ( event == "UPDATE_INVENTORY_ALERTS" ) then
		DynamicData.item.updateItemAlerts();
	end
end


