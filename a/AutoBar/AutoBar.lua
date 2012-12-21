--
--  AutoBar
--  Copyright 2004, 2005, 2006 original author. 
--  Copyright is expressly not transferred to Blizzard.
-- 
--  Configurable set of 12 buttons that seeks out configured items 
--  in your pack for use. Intended primarily for consumables. Not 
--  for use with spells, skills, trinkets, or powers.
--
--  Author: Marc aka Saien on Hyjal
--  WOWSaien@gmail.com
--  http://64.168.251.69/wow
--
--  2006.03.31
--    Minor category changes
--  2006.02.10
--    Enriched Manna Biscuit/Alterac Manna Biscuit (which is usable everywhere) 
--      moved to their own category("Food & Water Combo") - Update your buttons
--    Custom items can now appear on multiple buttons, as intended.
--  2006.01.28
--    Oils fixed.
--    Custom items got broken by selfcast config. Fixed. 
--  2006.01.20
--    Will no longer fallback to zone-restricted items when all items in a button are ineligible.
--    Fixed bug where hitting keybinding for a button that has no items found will popup an error
--    Buttons will skip items too high in level for character
--  2006.01.12
--    Selfcast is back
--    AutoBar re-parented so it hides with an Alt-Z
--    Configuration checkbox to hide Keybind text 
--    Configuration checkbox to hide Count text
--    Configuration checkbox to show empty buttons
--    Keybind text and count text scales with button width.
--    Can now open configuration while dead.
--    "Num Pad" key bindings are now shortened to just N in display.
--    Removed /ab as a shortcut for the depreciated slash commands.
--    Fixed Mana potion hp restriction - should be mana restriction
--    Minimum button width/height set to 9 pixels instead of 18.
--  2006.01.06
--    Release of complete re-write.
--

AUTOBAR_VERSION = "2006.02.10" -- Notice the cleverly disguised date.
------------------------------------
BINDING_HEADER_AUTOBAR_SEP = "Auto Bar";
BINDING_NAME_AUTOBAR_CONFIG = "Configuration Window";
BINDING_NAME_AUTOBAR_BUTTON1 = "Button 1";
BINDING_NAME_AUTOBAR_BUTTON2 = "Button 2";
BINDING_NAME_AUTOBAR_BUTTON3 = "Button 3";
BINDING_NAME_AUTOBAR_BUTTON4 = "Button 4";
BINDING_NAME_AUTOBAR_BUTTON5 = "Button 5";
BINDING_NAME_AUTOBAR_BUTTON6 = "Button 6";
BINDING_NAME_AUTOBAR_BUTTON7 = "Button 7";
BINDING_NAME_AUTOBAR_BUTTON8 = "Button 8";
BINDING_NAME_AUTOBAR_BUTTON9 = "Button 9";
BINDING_NAME_AUTOBAR_BUTTON10 = "Button 10";
BINDING_NAME_AUTOBAR_BUTTON11 = "Button 11";
BINDING_NAME_AUTOBAR_BUTTON12 = "Button 12";
------------------------------------
AUTOBAR_MAXBUTTONS = 12;
-----------------------------------
AutoBar_Debug = nil;
AutoBar_Player = nil; -- global
--
local AutoBar_ConfigLoaded = nil;
AutoBar_SearchedForItems = {};
local AutoBar_ButtonItemList = {};
local AutoBar_ButtonItemList_Reversed = {};
local AutoBar_Buttons_CurrentItems = {};
--
local AutoBar_InWorld = nil;
local AutoBar_InCombat = nil; -- For item use restrictions
------------------------------------

local function AutoBar_LinkDecode(link)
	if (link) then
		local _, _, id, name = string.find(link,"|Hitem:(%d+):%d+:%d+:%d+|h%[([^]]+)%]|h|r$");
		if (id and name) then
			return name, tonumber(id);
		end
	end
end

local function AutoBar_ConfigInit()
	if (not AutoBar_Config) then AutoBar_Config = {}; end
	if (not AutoBar_Config[AutoBar_Player]) then AutoBar_Config[AutoBar_Player] = {}; end
	---
	if (AutoBar_Config[AutoBar_Player].docked and AutoBar_Config[AutoBar_Player].scaling and 
	    AutoBar_Config[AutoBar_Player].rows and AutoBar_Config[AutoBar_Player].columns) then
		-- Config is from pre re-write. Not upgrading.
 		AutoBar_Config[AutoBar_Player] = {};
		AutoBar_Msg("Config for this character is old version. Clearing. No attempt to upgrade config is being done.");
	end
	---
	if (not AutoBar_Config[AutoBar_Player].buttons) then
		local _,class = UnitClass("player");
		AutoBar_Config[AutoBar_Player].buttons = {};
		AutoBar_Config[AutoBar_Player].buttons[1] = { "BANDAGES", "ALTERAC_BANDAGES", "WARSONG_BANDAGES", "ARATHI_BANDAGES", "UNGORO_RESTORE"};
		AutoBar_Config[AutoBar_Player].buttons[2] = { "HEALPOTIONS", "REJUVENATION_POTIONS", "WHIPPER_ROOT", "NIGHT_DRAGONS_BREATH", "PVP_HEALPOTIONS", "ALTERAC_HEAL", "HEALTHSTONE" };
		if (class == "WARRIOR") then
			AutoBar_Config[AutoBar_Player].buttons[3] = "RAGEPOTIONS";
		elseif (class == "ROGUE") then
			AutoBar_Config[AutoBar_Player].buttons[3] = "ENERGYPOTIONS";
		elseif (class == "MAGE") then
			AutoBar_Config[AutoBar_Player].buttons[3] = { "MANAPOTIONS", "REJUVENATION_POTIONS", "NIGHT_DRAGONS_BREATH", "PVP_MANAPOTIONS", "ALTERAC_MANA", "MANASTONE" };
		else
			AutoBar_Config[AutoBar_Player].buttons[3] = { "MANAPOTIONS", "REJUVENATION_POTIONS", "NIGHT_DRAGONS_BREATH", "PVP_MANAPOTIONS", "ALTERAC_MANA"  };
		end
		if (class ~= "ROGUE" and class ~= "WARRIOR") then
			AutoBar_Config[AutoBar_Player].buttons[4] = { "WATER", "WATER_CONJURED" };
		end
		AutoBar_Config[AutoBar_Player].buttons[5] = { "FOOD", "FOOD_STAMINA", "FOOD_CONJURED" };
		AutoBar_Config[AutoBar_Player].buttons[AUTOBAR_MAXBUTTONS] = "HEARTHSTONE";
	end
	if (not AutoBar_Config[AutoBar_Player].display) then
		AutoBar_Config[AutoBar_Player].display = {};
	end
	AutoBar_ConfigUpdated();
end

local function AutoBar_BuildItemList()
	local function AddItemInfo(identifier, buttonnum)
		if (AutoBar_Category_Info[identifier] and AutoBar_Category_Info[identifier].items) then
			local idx,j;
			for idx, j in AutoBar_Category_Info[identifier].items do
				if (AutoBar_SearchedForItems[j]) then
					table.insert(AutoBar_SearchedForItems[j], buttonnum);
				else
					AutoBar_SearchedForItems[j] = { buttonnum, identifier, idx };
				end
				table.insert(AutoBar_ButtonItemList[buttonnum], j);
			end
		else
			if (AutoBar_SearchedForItems[identifier]) then
				table.insert(AutoBar_SearchedForItems[identifier], buttonnum);
			else
				AutoBar_SearchedForItems[identifier] = { buttonnum, identifier, 0 };
			end
			table.insert(AutoBar_ButtonItemList[buttonnum], identifier);
		end
	end
	AutoBar_SearchedForItems = {};
	AutoBar_ButtonItemList_Reversed = {};
	local idx;
	for idx = 1, AUTOBAR_MAXBUTTONS, 1 do
		if (AutoBar_Config[AutoBar_Player].buttons[idx]) then
			local i, j;
			AutoBar_ButtonItemList[idx] = {};
			AutoBar_ButtonItemList_Reversed[idx] = {};
			if (type(AutoBar_Config[AutoBar_Player].buttons[idx]) == "table") then
				for i, j in AutoBar_Config[AutoBar_Player].buttons[idx] do
					AddItemInfo (j, idx);
				end
			else
				AddItemInfo (AutoBar_Config[AutoBar_Player].buttons[idx], idx);
			end
			for i, j in AutoBar_ButtonItemList[idx] do
				AutoBar_ButtonItemList_Reversed[idx][j] = i;
			end
		end
	end
end

function AutoBar_Button_GetDisplayItem(buttonnum)
	local idx, bag, slot, rank, itemid, category, categoryidx, acceptable, cooldowntime, level;
	local cooldownidx, start, duration, enable, fallback;
	if (AutoBar_Buttons_CurrentItems[buttonnum]) then
		idx = table.getn(AutoBar_Buttons_CurrentItems[buttonnum]);
	else
		idx = 0;
	end
	while (idx > 0 and not acceptable) do
		bag = AutoBar_Buttons_CurrentItems[buttonnum][idx].items[1][1];
		slot = AutoBar_Buttons_CurrentItems[buttonnum][idx].items[1][2];
		rank = AutoBar_Buttons_CurrentItems[buttonnum][idx].rank;
		itemid = AutoBar_ButtonItemList[buttonnum][rank];
		if (type(itemid) == "number") then
			_,_,_,level = GetItemInfo(itemid);
		else
			level = 0;
		end
		if (AutoBar_SearchedForItems[itemid]) then 
			category = AutoBar_SearchedForItems[itemid][2];
			categoryidx = AutoBar_SearchedForItems[itemid][3];
		else
			category = nil;
			categoryidx = nil;
		end
		--
		start, duration, enable = GetContainerItemCooldown(bag, slot);
		if (start > 0 and duration > 0) then
			local tmp = start - GetTime() + duration;
			if (not cooldowntime or tmp < cooldowntime) then
				cooldowntime = tmp;
				cooldownidx = idx;
			end
			idx = idx - 1;
		elseif (level > UnitLevel("player")) then
			idx = idx - 1;
		elseif (AutoBar_Category_Info[category] and AutoBar_Category_Info[category].location and AutoBar_Category_Info[category].location ~= GetZoneText()) then
			idx = idx - 1;
		elseif (AutoBar_Category_Info[category]) then
			if (not fallback) then 
				fallback = idx; 
			end
			if (AutoBar_Category_Info[category].combatonly and not AutoBar_InCombat) then
				idx = idx - 1;
			elseif (AutoBar_Category_Info[category].noncombat and AutoBar_InCombat) then
				idx = idx - 1;
			elseif (AutoBar_Category_Info[category].limit) then
				local losthp = UnitHealthMax("player") - UnitHealth("player");
				local lostmana = UnitManaMax("player") - UnitMana("player");
				if (UnitPowerType("player") ~= 0 ) then
					--if (UnitClass("player") == "Druid") then
						-- Can't check mana in druid forms
					--	lostmana = 0;
					--else
						-- Class doesn't have mana, don't limit
						lostmana = 10000;
					--end
				end
				if (AutoBar_Category_Info[category].limit.downhp and AutoBar_Category_Info[category].limit.downhp[categoryidx] > losthp) then
					idx = idx - 1
				elseif (AutoBar_Category_Info[category].limit.downmana and AutoBar_Category_Info[category].limit.downmana[categoryidx] > lostmana) then
					idx = idx - 1
				else
					acceptable = true;
				end
			else
				acceptable = true;
			end
		else
			acceptable = true;
		end
	end
	if (not acceptable) then
		if (fallback) then
			idx = fallback;
		elseif (cooldownidx) then
			idx = cooldownidx;
		elseif (AutoBar_Buttons_CurrentItems[buttonnum]) then
			idx = table.getn(AutoBar_Buttons_CurrentItems[buttonnum]);
		else
			idx = nil;
		end
	end
	--
	if (idx) then
		bag = AutoBar_Buttons_CurrentItems[buttonnum][idx].items[1][1];
		slot = AutoBar_Buttons_CurrentItems[buttonnum][idx].items[1][2];
		rank = AutoBar_Buttons_CurrentItems[buttonnum][idx].rank;
	else
		bag = nil; slot = nil; rank = nil;
	end
	if (AutoBar_ButtonItemList[buttonnum]) then
		itemid = AutoBar_ButtonItemList[buttonnum][rank];
		if (AutoBar_SearchedForItems[itemid]) then 
			category = AutoBar_SearchedForItems[itemid][2];
			categoryidx = AutoBar_SearchedForItems[itemid][3];
		else
			category = nil;
			categoryidx = nil;
		end
	else
		itemid = nil; category = nil; categoryidx = nil;
	end
	return bag, slot, rank, itemid, category, categoryidx, idx, acceptable, cooldowntime;
end

function AutoBar_Button_UpdateButtons()
	local buttonnum, i, button, icon, normaltexture, counttxt, bag, slot, idx, items;
	local hotkey, count, tmpcount, keyText, actioncommand;
	for buttonnum = 1, AUTOBAR_MAXBUTTONS, 1 do
		button = getglobal("AutoBar_Button"..buttonnum);
		icon = getglobal("AutoBar_Button"..buttonnum.."Icon");
		normaltexture = getglobal("AutoBar_Button"..buttonnum.."NormalTexture");
		counttxt = getglobal("AutoBar_Button"..buttonnum.."Count");
		hotkey = getglobal("AutoBar_Button"..buttonnum.."HotKey");
		if (not button.forcehidden and button.effectiveButton) then
			button:Show();
			bag, slot,_,_,_,_,idx,enabled = AutoBar_Button_GetDisplayItem(button.effectiveButton)
			if (bag and slot) then
				items = AutoBar_Buttons_CurrentItems[button.effectiveButton][idx].items
				count = 0;
				for i, bagslot in items do
					_, tmpcount = GetContainerItemInfo(bagslot[1], bagslot[2]);
					if (tmpcount) then
						count = count + tmpcount;
					end
				end
				icon:SetTexture(GetContainerItemInfo(bag,slot));
				if (count > 1) then
					counttxt:SetText(count);
				else
					counttxt:SetText("");
				end
				if (enabled) then
					icon:SetVertexColor(1,1,1);
					normaltexture:SetVertexColor(1,1,1);
				else
					icon:SetVertexColor(0.4,0.4,0.4);
					normaltexture:SetVertexColor(1,1,1);
				end
				actioncommand = "AUTOBAR_BUTTON"..button.effectiveButton;
				if (actioncommand) then
					keyText = GetBindingKey(actioncommand);
					if (keyText) then
						keyText = string.gsub(keyText, "CTRL", "C");
						keyText = string.gsub(keyText, "ALT", "A");
						keyText = string.gsub(keyText, "SHIFT", "S");
						keyText = string.gsub(keyText, "NUMPAD", "N");
						hotkey:SetText(keyText);
					else
						hotkey:SetText("");
					end
				end
			else
				icon:SetTexture("");
				counttxt:SetText("");
				hotkey:SetText("");
			end
		else
			button:Hide();
		end
	end
end

local function AutoBar_AssignButtons()
	local displayButton = 0;
	local buttonidx, buttoninfo, rankidx, items;
	for buttonidx = 1, AUTOBAR_MAXBUTTONS, 1 do
		if (AutoBar_Config[AutoBar_Player].display.showemptybuttons or AutoBar_Buttons_CurrentItems[buttonidx]) then
			displayButton = displayButton + 1;
			local button = getglobal("AutoBar_Button"..displayButton);
			button.effectiveButton = buttonidx;
		end
	end
	for buttonidx = displayButton+1, AUTOBAR_MAXBUTTONS, 1 do
		local button = getglobal("AutoBar_Button"..buttonidx);
		button.effectiveButton = nil;
	end
	AutoBar_Button_UpdateButtons();
end

local function AutoBar_UpdateCategoryNameToID(name,id)
	local buttonnum, idx;
	for buttonnum = 1, AUTOBAR_MAXBUTTONS, 1 do
		if (AutoBar_Config[AutoBar_Player].buttons[buttonnum]) then
			if (type(AutoBar_Config[AutoBar_Player].buttons[buttonnum]) == "table") then
				for idx in AutoBar_Config[AutoBar_Player].buttons[buttonnum] do
					if (AutoBar_Config[AutoBar_Player].buttons[buttonnum][idx] == name) then
						AutoBar_Config[AutoBar_Player].buttons[buttonnum][idx] = id;
						AutoBar_Msg("Updating multi item button #",buttonnum," item #",idx," to use itemid instead of item name.");
					end
				end
			elseif (AutoBar_Config[AutoBar_Player].buttons[buttonnum] == name) then
				AutoBar_Config[AutoBar_Player].buttons[buttonnum] = id;
				AutoBar_Msg("Updating single item button #",buttonnum," to use itemid instead of item name.");
			end
		end
	end
end

function AutoBar_ScanBags(specificbag)
	local function ClearOutBag(bag)
		local buttonnum, idx, i, bagslot, newitemlist, newranks;
		for buttonnum = 1, AUTOBAR_MAXBUTTONS, 1 do
			if (AutoBar_Buttons_CurrentItems[buttonnum]) then 
				newranks = {};
				for idx in AutoBar_Buttons_CurrentItems[buttonnum] do
					newitemlist = {};
					for i, bagslot in AutoBar_Buttons_CurrentItems[buttonnum][idx].items do
						if (bag ~= bagslot[1]) then
							table.insert(newitemlist,bagslot); 
						end
					end
					if (table.getn(newitemlist) > 0) then
						AutoBar_Buttons_CurrentItems[buttonnum][idx].items = newitemlist;
						table.insert(newranks,AutoBar_Buttons_CurrentItems[buttonnum][idx]);
					end
				end
				if (table.getn(newranks) == 0) then
					AutoBar_Buttons_CurrentItems[buttonnum] = nil;
				else
					AutoBar_Buttons_CurrentItems[buttonnum] = newranks;
				end
			end
		end
	end
	local function AddItem(buttonnum, rank, bag, slot)
		if (AutoBar_Buttons_CurrentItems[buttonnum]) then 
			local idx, rec, findRank;
			for idx, rec in AutoBar_Buttons_CurrentItems[buttonnum] do
				if (rec.rank == rank) then
					findRank = idx;
				end
			end
			if (findRank) then
				table.insert(AutoBar_Buttons_CurrentItems[buttonnum][findRank].items, { bag, slot } );
			else
				table.insert(AutoBar_Buttons_CurrentItems[buttonnum],
					{
				 		["rank"] = rank,
				 		["items"] = { { bag, slot } }
					}
				);
			end
		else
			AutoBar_Buttons_CurrentItems[buttonnum] = {
				[1] = {
					["rank"] = rank,
					["items"] = { { bag, slot } }
				},
			};
		end
	end
	local function SortByRank(a,b)
		if (a and b and a.rank and b.rank) then
			return a.rank < b.rank;
		else
			return true;
		end
	end

	local bag, slot, name, id, i;
	local minbag,maxbag = 0, 4;
	if (specificbag) then 
		minbag = specificbag; 
		maxbag = specificbag; 
		ClearOutBag(specificbag);
	else
		AutoBar_Buttons_CurrentItems = {};
	end
	-- AutoBar_Buttons_CurrentItems = {
	--	buttonnum = {
	--		idx = {
	--			"rank" = ranknum,
	--			"items" = { {bag,slot}, {bag,slot}, {bag, slot} }
	--		},
	--	},
	--};
	for bag = minbag, maxbag, 1 do
		for slot = 1, GetContainerNumSlots(bag), 1 do
			name, id = AutoBar_LinkDecode(GetContainerItemLink(bag,slot));
			if (name and AutoBar_SearchedForItems[name] and id) then
				if (not AutoBar_SearchedForItems[id]) then
					AutoBar_SearchedForItems[id] = { AutoBar_SearchedForItems[name][1], AutoBar_SearchedForItems[name][2], AutoBar_SearchedForItems[name][3] };
				end
				AutoBar_UpdateCategoryNameToID(name,id);
				AutoBar_SearchedForItems[name] = nil;
			end
			if (id and AutoBar_SearchedForItems[id]) then
				local button = AutoBar_SearchedForItems[id][1];
				local rank = AutoBar_ButtonItemList_Reversed[button][id];
				AddItem(button, rank, bag, slot)
				if (AutoBar_SearchedForItems[id][4]) then
					for i = 4, table.getn(AutoBar_SearchedForItems[id]), 1 do
						button = AutoBar_SearchedForItems[id][i];
						rank = AutoBar_ButtonItemList_Reversed[button][id];
						AddItem(button, rank, bag, slot)
					end
				end
			end
		end
	end
	local buttonnum;
	for buttonnum = 1, AUTOBAR_MAXBUTTONS, 1 do
	 	if (AutoBar_Buttons_CurrentItems[buttonnum]) then
			table.sort(AutoBar_Buttons_CurrentItems[buttonnum], SortByRank);
	 	end
	end
	AutoBar_AssignButtons();
end

------------------------------------

function AutoBar_OnLoad()
	AutoBar_Player = UnitName("player").." - "..GetCVar("realmName");

	this:RegisterEvent("PLAYER_ENTERING_WORLD"); 
	this:RegisterEvent("PLAYER_LEAVING_WORLD"); 
	--
	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("UPDATE_BINDINGS");
	-- 
	-- For item use restrictions
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("UNIT_MANA");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("PLAYER_ALIVE");
	this:RegisterEvent("BAG_UPDATE_COOLDOWN");
	--
end

function AutoBar_OnEvent(event)
	if (event == "PLAYER_ENTERING_WORLD") then
		AutoBar_InCombat = nil;
		if (not AutoBar_ConfigLoaded) then
			AutoBar_ConfigInit();
			AutoBar_ConfigLoaded = 1;
			AutoBar_ScanBags();
		end
		if (not AutoBar_InWorld) then
			AutoBar_InWorld = 1;
			AutoBar_ScanBags();
			AutoBar_Button_UpdateButtons();
		end
	elseif (event == "PLAYER_LEAVING_WORLD") then
		AutoBar_InWorld = nil;
	elseif (AutoBar_InWorld) then
		if (event == "BAG_UPDATE") then
			if (arg1 < 5) then
				AutoBar_ScanBags(arg1);
			end
		elseif (event == "UPDATE_BINDINGS") then
			AutoBar_Button_UpdateButtons();
		elseif (event == "PLAYER_ALIVE") then
			AutoBar_Button_UpdateButtons();
		elseif ((event == "UNIT_MANA" or event == "UNIT_HEALTH") and arg1=="player") then
			AutoBar_Button_UpdateButtons();
		elseif (event == "PLAYER_REGEN_ENABLED") then
			AutoBar_InCombat = nil;
			AutoBar_Button_UpdateButtons();
		elseif (event == "PLAYER_REGEN_DISABLED") then
			AutoBar_InCombat = 1;
			AutoBar_Button_UpdateButtons();
		elseif (event == "ZONE_CHANGED_NEW_AREA") then
			AutoBar_Button_UpdateButtons();
		elseif (event == "BAG_UPDATE_COOLDOWN") then
			AutoBar_Button_UpdateButtons();
		end
	end
end

------------------------------------

function AutoBar_UseButton(num)
	local bag, slot, rank, itemid, category, categoryidx, idx, acceptable = AutoBar_Button_GetDisplayItem(num);
	if (bag and slot) then
		UseContainerItem(bag,slot);
		if (AutoBar_Category_Info[category] and AutoBar_Category_Info[category].targetted == "WEAPON" and SpellIsTargeting()) then
			PickupInventoryItem(GetInventorySlotInfo("MainHandSlot"));
		elseif (AutoBar_Category_Info[category] and AutoBar_Category_Info[category].targetted and AutoBar_Config[AutoBar_Player].smartselfcast and AutoBar_Config[AutoBar_Player].smartselfcast[category] and SpellIsTargeting()) then
			SpellTargetUnit("player");
		end
	end
end


function AutoBar_Button_OnClick(mousebutton, updown, override)
	local button;
	if (override) then
		button = getglobal("AutoBar_Button"..override);
	else
		button = this;
	end
	button:SetChecked(0);
	if (AutoBar.moving) then
		if (updown == "CLICK") then
			AutoBar.moving = nil;
			AutoBar:StopMovingOrSizing();
			AutoBar_Config[AutoBar_Player].display.position = {};
			AutoBar_Config[AutoBar_Player].display.position.x, 
			AutoBar_Config[AutoBar_Player].display.position.y = AutoBar:GetCenter();
			AutoBar:SetMovable(0);
		end
	elseif (updown == "CLICK") then
		local bag, slot, rank, itemid, category, categoryidx, idx, acceptable = AutoBar_Button_GetDisplayItem(button.effectiveButton);
		if (bag and slot) then
			UseContainerItem(bag,slot);
			if (AutoBar_Category_Info[category] and AutoBar_Category_Info[category].targetted == "WEAPON" and SpellIsTargeting()) then
				if (mousebutton == "LeftButton") then
					PickupInventoryItem(GetInventorySlotInfo("MainHandSlot"));
				elseif (mousebutton == "RightButton") then
					PickupInventoryItem(GetInventorySlotInfo("SecondaryHandSlot"));
				end
			elseif (AutoBar_Category_Info[category] and AutoBar_Category_Info[category].targetted and AutoBar_Config[AutoBar_Player].smartselfcast and AutoBar_Config[AutoBar_Player].smartselfcast[category] and SpellIsTargeting()) then
				SpellTargetUnit("player");
			end
		end
	elseif (mousebutton == "RightButton" and updown == "DOWN" and IsControlKeyDown()) then
		if (not AutoBar_Config[AutoBar_Player].display.docking) then
			AutoBar.moving = true;
			AutoBar:SetMovable(1);
			AutoBar:StartMoving();
		end
	end
end

function AutoBar_Button_SetTooltip(button, elapsed)
	if (not button) then button = this; end
	if (button:GetParent().updateTooltip and elapsed) then
		button.updateTooltip = button.updateTooltip - elapsed;
		if (button.updateTooltip > 0) then return; end
	end

	if (button.effectiveButton) then
		if (GetCVar("UberTooltips") == "1") then
			GameTooltip_SetDefaultAnchor(GameTooltip, button);
		else
			GameTooltip:SetOwner(button, "ANCHOR_RIGHT");
		end
		button.updateTooltip = nil;

		local bag, slot, rank, itemid, category, categoryidx = AutoBar_Button_GetDisplayItem(button.effectiveButton)
		if (bag and slot) then
			GameTooltip:SetBagItem(bag, slot);
			if (AutoBar_Debug) then
				if (rank) then
					GameTooltip:AddLine("DISPLAYED RANK: "..rank);
				end
				if (itemid) then
					GameTooltip:AddLine("DISPLAYED ITEMID: "..itemid);
				end
				if (category) then
					GameTooltip:AddLine("DISPLAYED CATEGORY: "..category);
				end
				if (categoryidx) then
					GameTooltip:AddLine("DISPLAYED CATEGORYIDX: "..categoryidx);
				end
			end
			local start, duration, enable = GetContainerItemCooldown(bag, slot);
			if (start > 0 and duration > 0) then
				button.updateTooltip = TOOLTIP_UPDATE_TIME;
			end
	
			GameTooltip:AddLine("");
			local rankidx, idx, itemident, bagslot, count, tmpcount, name, itemid, msg;
			local start, duration, enable;
			for rankidx, itemident in AutoBar_Buttons_CurrentItems[button.effectiveButton] do
				count = 0;
				for idx, bagslot in itemident.items do
					_, tmpcount = GetContainerItemInfo(bagslot[1], bagslot[2]);
					count = count + tmpcount;
				end
				name,itemid = AutoBar_LinkDecode(GetContainerItemLink(itemident.items[1][1], itemident.items[1][2]));
				category = AutoBar_SearchedForItems[itemid][2];
				start, duration, enable = GetContainerItemCooldown(itemident.items[1][1], itemident.items[1][2]);
				msg = name.." (Count: "..count..")";
				if (AutoBar_Debug) then
					msg = msg.." ["..itemident.items[1][1]..","..itemident.items[1][2].."]";
					if (rank) then
						msg = msg.." rank="..itemident.rank;
					end
					if (cat) then
						msg = msg.." cat="..category;
					end
				end
				if (category == itemid and categoryidx == 0) then
					msg = msg.." [Custom Item]"
				end
				if (AutoBar_Category_Info[category]) then
					if (AutoBar_Category_Info[category].combatonly) then
						msg=msg.." [In Combat Only]";
					end
					if (AutoBar_Category_Info[category].noncombat) then
						msg=msg.." [Non Combat Only]";
					end
					if (AutoBar_Category_Info[category].limit) then
						msg=msg.." [Limited Usage]";
					end
				end
				if (start > 0 and duration > 0) then
					msg = msg.." [Cooldown]";
				end
				GameTooltip:AddLine(msg);
				if (category and AutoBar_Category_Info[category] and AutoBar_Category_Info[category].targetted == "WEAPON") then
					GameTooltip:AddLine("\n(Left Click to apply to Main Hand weapon\nRight Click to apply to OffHand weapon)");
				end
			end
			GameTooltip:Show();
		end
	end
end

------------------------------------

function AutoBar_GetTexture(id)
	if (not id) then return ""; end
	if (type(id) == "table" and id[1]) then id = id[1]; end
	if (id and AutoBar_Category_Info[id]) then
		if (AutoBar_Category_Info[id].texture) then
			return "Interface\\Icons\\"..AutoBar_Category_Info[id].texture;
		else
			id = AutoBar_Category_Info[id].items[1];
		end
	end
	if (type(id)=="number" and id > 0) then
		local _,_,_,_,_,_,_,_,texture = GetItemInfo(tonumber(id));
		if (texture) then return texture; end
	end
	return "Interface\\Icons\\INV_Misc_Gift_01";
end

function AutoBar_Msg(...)
	local message = "";
	for i = 1, arg.n, 1 do
		if (type(arg[i]) == "string" or type(arg[i]) == "number") then
			message = message..arg[i];
		else
			message = message..string.upper(type(arg[i]));
		end
	end
	ChatFrame1:AddMessage("AutoBar: "..message);
end

function AutoBar_ConfigUpdated()
	AutoBar_BuildItemList();
	AutoBar_ScanBags();
	AutoBar_SetupVisual();
end

function AutoBar_SetupVisual()
	local rows = AutoBar_Config[AutoBar_Player].display.rows;
	local columns = AutoBar_Config[AutoBar_Player].display.columns;
	local gapping = AutoBar_Config[AutoBar_Player].display.gapping;
	local alpha = AutoBar_Config[AutoBar_Player].display.alpha;
	local buttonwidth = AutoBar_Config[AutoBar_Player].display.buttonwidth;
	local buttonheight = AutoBar_Config[AutoBar_Player].display.buttonheight;
	local dockshiftx = AutoBar_Config[AutoBar_Player].display.dockshiftx;
	local dockshifty = AutoBar_Config[AutoBar_Player].display.dockshifty;
	--
	if (not rows) then rows = 1; end
	if (not columns) then columns = 6; end
	if (not gapping) then gapping = 6; end
	if (not alpha) then alpha = 1; end
	if (not buttonwidth) then buttonwidth = 36 end
	if (not buttonheight) then buttonheight = 36; end
	if (not dockshiftx) then dockshiftx = 0; end
	if (not dockshifty) then dockshifty = 0; end
	--
	AutoBar:Show();
	AutoBar:ClearAllPoints();
	if (AutoBar_Config[AutoBar_Player].display.framestrata) then
		AutoBar:SetFrameStrata(AutoBar_Config[AutoBar_Player].display.framestrata);
	else
		if (AutoBar_Config[AutoBar_Player].display.docking == "MAINMENU") then
			AutoBar:SetFrameStrata("HIGH");
		else
			AutoBar:SetFrameStrata("LOW");
		end
	end
	if (AutoBar_Config[AutoBar_Player].display.docking) then
		if (AutoBar_Config[AutoBar_Player].display.docking == "MAINMENU") then
			AutoBar:SetPoint("BOTTOMLEFT","MainMenuBarArtFrame","BOTTOMLEFT",546+dockshiftx,38+dockshifty);
		else
			AutoBar_Config[AutoBar_Player].display.docking = nil;
		end
	elseif (AutoBar_Config[AutoBar_Player].display.position) then
		AutoBar:SetPoint("CENTER","UIParent","BOTTOMLEFT",
		AutoBar_Config[AutoBar_Player].display.position.x,
		AutoBar_Config[AutoBar_Player].display.position.y);
	else
		AutoBar:SetPoint("CENTER","UIParent","CENTER",0,0);
	end
	local i, texture, counttxt, hotkey, fonttext, fontsize, fontoptions, percent;
	percent = buttonwidth / 36;
	if (percent > 1) then percent = 1; end
	for i = 1, AUTOBAR_MAXBUTTONS, 1 do
		local button = getglobal("AutoBar_Button"..i);
		if (i > (rows*columns)) then
			button:Hide();
			button.forcehidden = 1;
		else
			texture = getglobal("AutoBar_Button"..i.."NormalTexture");
			counttxt = getglobal("AutoBar_Button"..i.."Count");
			hotkey = getglobal("AutoBar_Button"..i.."HotKey");
			button.forcehidden = nil;
			button:SetAlpha(alpha);
			texture:SetAlpha(alpha);
			button:SetWidth(buttonwidth);
			texture:SetWidth(buttonwidth*1.833);
			button:SetHeight(buttonheight);
			texture:SetHeight(buttonheight*1.833);
			if (AutoBar_Config[AutoBar_Player].display.hidekeytext) then
				hotkey:Hide();
			else
				hotkey:Show();
				fonttext, fontsize, fontoptions = hotkey:GetFont();
				hotkey:SetFont(fonttext, 12*percent, fontoptions);
				hotkey:SetPoint("TOPLEFT","AutoBar_Button"..i,"TOPLEFT",-10,-2);
			end
			if (AutoBar_Config[AutoBar_Player].display.hidecount) then
				counttxt:Hide();
			else
				counttxt:Show();
				fonttext, fontsize, fontoptions = counttxt:GetFont();
				counttxt:SetFont(fonttext, 14*percent, fontoptions);
			end
			button:ClearAllPoints();
			if (i == 1) then
				button:SetPoint("TOPLEFT","AutoBar","TOPLEFT",0,0);
			elseif (columns == 1) then
				if (AutoBar_Config[AutoBar_Player].display.reversebuttons) then
					button:SetPoint("BOTTOM","AutoBar_Button"..(i-1),"TOP",0,gapping);
				else
					button:SetPoint("TOP","AutoBar_Button"..(i-1),"BOTTOM",0,gapping*-1);
				end
			elseif (math.mod(i,columns) == 1) then
				local row = math.floor(i/columns);
				if (AutoBar_Config[AutoBar_Player].display.reversebuttons) then
					button:SetPoint("BOTTOM","AutoBar_Button"..(i-columns),"TOP",0,gapping);
				else
					button:SetPoint("TOP","AutoBar_Button"..(i-columns),"BOTTOM",0,gapping*-1);
				end
			else
				if (AutoBar_Config[AutoBar_Player].display.reversebuttons) then
					button:SetPoint("RIGHT","AutoBar_Button"..(i-1),"LEFT",gapping*-1,0);
				else
					button:SetPoint("LEFT","AutoBar_Button"..(i-1),"RIGHT",gapping,0);
				end
			end
		end
	end
	AutoBar_AssignButtons();
	AutoBar_Button_UpdateButtons();
end

