
AllInOneInventoryItems_Cache = {};

AllInOneInventoryItems_NoItem = {
	["c"] = 0
};

local AllInOneInventoryItemsFrame_Events = {
	"BAG_UPDATE";
	"BAG_UPDATE_COOLDOWN";
	"ITEM_LOCK_CHANGED";
	"UPDATE_INVENTORY_ALERTS";
};

function AllInOneInventoryItemsFrame_OnLoad()
	local f = AllInOneInventoryItemsFrame;
	f:RegisterEvent("PLAYER_ENTERING_WORLD");
	f:RegisterEvent("PLAYER_LEAVING_WORLD");
	f:RegisterEvent("VARIABLES_LOADED");
	for k,v in AllInOneInventoryItemsFrame_Events do
		f:RegisterEvent(v);
	end
end

function AllInOneInventoryItems_GetInfo(bag, slot)
	if ( AllInOneInventoryItems_Cache[bag] ) and ( AllInOneInventoryItems_Cache[bag][slot] ) then
		local arr = AllInOneInventoryItems_Cache[bag][slot];
		if ( arr.n ) then
			return arr;
		end
	end
	return nil;
end

function AllInOneInventoryItems_UpdateBag(bag)
	bag = tonumber(bag);
	if ( not bag ) then
		for i = 0, 4 do
			AllInOneInventoryItems_UpdateBag(i);
		end
		return;
	end
	if ( not AllInOneInventoryItems_Cache[bag] ) then
		AllInOneInventoryItems_Cache[bag] = {};
	end
	local slotMax = GetContainerNumSlots(bag);
	local name, link;
	local textureName, itemCount, itemLocked, itemQuality, itemReadable;
	local ic_start, ic_duration, ic_enable;
	for slot = 1, slotMax do
		textureName, itemCount, itemLocked, itemQuality, itemReadable = GetContainerItemInfo(bag, slot);
		if ( textureName ) then
			link = GetContainerItemLink(bag, slot);
			for nameStr in string.gfind(link, "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[(.-)%]|h|r") do
				name = nameStr;
				break;
			end
			local arr = AllInOneInventoryItems_Cache[bag][slot];
			if ( not arr ) then
				arr = {};
			end
			arr.n = name;
			arr.c = itemCount;
			arr.t = textureName;
			arr.l = itemLocked;
			arr.q = itemQuality;
			arr.r = itemReadable;
			ic_start, ic_duration, ic_enable = GetContainerItemCooldown(bag, slot);
			arr.cs = ic_start;
			arr.cd = ic_duration;
			arr.ce = ic_enable;
			if ( not AllInOneInventoryItems_Cache[bag][slot] ) then
				AllInOneInventoryItems_Cache[bag][slot] = arr;
			end
		else
			AllInOneInventoryItems_Cache[bag][slot] = {};
		end
	end
	for slot = (slotMax+1), MAX_CONTAINER_ITEMS do
		AllInOneInventoryItems_Cache[bag][slot] = nil;
	end
end

function AllInOneInventoryItems_UpdateBagCooldown(bag)
	if ( not bag ) then
		for i = 0, 4 do
			AllInOneInventoryItems_UpdateBag(i);
		end
		return;
	end
	if ( not AllInOneInventoryItems_Cache[bag] ) then
		AllInOneInventoryItems_Cache[bag] = {};
	end
	local slotMax = GetContainerNumSlots(bag);
	local name, link;
	local ic_start, ic_duration, ic_enable;
	local arr;
	for slot = 1, slotMax do
		arr = AllInOneInventoryItems_Cache[bag][slot];
		if ( arr ) then
			ic_start, ic_duration, ic_enable = GetContainerItemCooldown(bag, slot);
			arr.cs = ic_start;
			arr.cd = ic_duration;
			arr.ce = ic_enable;
		end
	end
end

AllInOneInventoryItemsFrame_DoUpdate_Name = "AIOI_REFRESH";
AllInOneInventoryItemsFrame_DoUpdate_Names = {
	"AIOI_REFRESH_0",
	"AIOI_REFRESH_1",
	"AIOI_REFRESH_2",
	"AIOI_REFRESH_3",
	"AIOI_REFRESH_4"
};

function AllInOneInventoryItemsFrame_DoUpdate(bag, ignoreVisibility, noSchedule)
	AllInOneInventoryItems_UpdateBag(bag);
	AllInOneInventoryItems_UpdateFrame(ignoreVisibility);
	if ( not noSchedule ) then
		local n = AllInOneInventoryItemsFrame_DoUpdate_Name;
		if ( bag ) then n = AllInOneInventoryItemsFrame_DoUpdate_Names[bag]; end
		AIOI_ScheduleByName(n, 1.0, AllInOneInventoryItemsFrame_DoUpdate, bag, ignoreVisibility, true);
	end
end

function AllInOneInventoryItemsFrame_OnEvent(event)
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		for k,v in AllInOneInventoryItemsFrame_Events do
			AllInOneInventoryItemsFrame:RegisterEvent(v);
		end
		return;
	elseif ( event == "PLAYER_LEAVING_WORLD" ) then
		for k,v in AllInOneInventoryItemsFrame_Events do
			AllInOneInventoryItemsFrame:UnregisterEvent(v);
		end
		return;
	elseif ( event == "BAG_UPDATE" ) then
		AllInOneInventoryItemsFrame_DoUpdate(arg1);
	end
	if ( event == "BAG_UPDATE_COOLDOWN" ) then
		AllInOneInventoryItemsFrame_DoUpdate(arg1, true);
	end
	if ( event == "ITEM_LOCK_CHANGED" ) then
		AllInOneInventoryItems_UpdateFrame();
	end
	if ( event == "UPDATE_INVENTORY_ALERTS" ) then
		AllInOneInventoryItems_UpdateFrame();
	end
	if ( event == "VARIABLES_LOADED" ) then
		local f = AllInOneInventoryItemsFrame;
		f:UnregisterEvent(event);
		AllInOneInventoryItemsFrame_DoUpdate();
	end
end

function AllInOneInventoryItems_UpdateFrame(ignoreVisibility)
	local frame = getglobal("AllInOneInventoryFrame");
	if ( frame ) and ( ( frame:IsVisible() ) or ( ignoreVisibility ) ) then
		AllInOneInventoryFrame_Update(frame);
	end
end
