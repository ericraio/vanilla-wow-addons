--[[
	DynamicData

	By sarf

	This mod allows you to access dynamic data in WoW without being forced to rely on strange Blizzard functions

	Thanks goes to the UltimateUI team, the nice (but strange) people at #ultimateuitesters and Blizzard.
	
	UltimateUIUI URL:
	http://www.ultimateuiui.org/forums/viewtopic.php?t=NOT_YET_ANNOUNCED
	
   ]]

function DynamicDataScriptFrame_OnLoad()

	-- variable events
	this:RegisterEvent("VARIABLES_LOADED");

	DynamicData.util.OnLoad();
end

function DynamicDataScriptFrame_OnEvent(event)
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
	-- variable events
	if ( event == "VARIABLES_LOADED" ) then
		DynamicData.util.variablesLoaded();
	end
end



function DynamicDataScriptFrame_OnUpdate(elapsed)
	DynamicData.util.notifyWhateverHandlers(DynamicData.util.onUpdateHandlers, elapsed);
end