local _DEBUG = false;
local downTime = nil;
local fe = nil;
local profile = nil;
local fishingID = nil;
local mainHandSlotID = nil;
local offHandSlotID = nil;
local gloveSlotID = nil;
local hatSlotID = nil;
local bootSlotID = nil;
local clickToMove = nil;

local function Print(msg)
	if (not msg) then return; end
	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(msg,1.0,1.0,1.0);
	end
end
local function Debug(msg)
	if (not _DEBUG) then return; end
	if (not msg) then return; end
	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("FE: "..GetTime()..": "..msg,1.0,0.0,0.0);
	end
end

function FE_OnLoad()

	Old_TurnOrActionStart = TurnOrActionStart;
	TurnOrActionStart = FE_TurnOrActionStart;
	Old_TurnOrActionStop = TurnOrActionStop;
	TurnOrActionStop = FE_TurnOrActionStop;

	-- create slash commands
	SlashCmdList["FESLASH"] = FE_ChatCommandHandler;
	SLASH_FESLASH1 = "/fishease";
	SLASH_FESLASH2 = "/fe";

	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("SPELLS_CHANGED");

end

local function FE_LearnFishingSkill()
	-- reset the fishingID in case they un-learned it
	fishingID = nil;

	--Loop through only the General tab looking for the Fishing skill
	local _, _, off, num = GetSpellTabInfo(1);
	local sIcon = nil;
	for i=(off+1), (off+num) do
		sIcon = GetSpellTexture(i,1);
		if (sIcon and sIcon == "Interface\\Icons\\Trade_Fishing") then
			fishingID = i;
			break;
		end
	end
end

function FE_OnEvent(event)
	if (event == "VARIABLES_LOADED") then

		if (not fe) then

			if (not FishEase_Cfg) then
				FishEase_Cfg = {};
			end

			if (FishEase_Cfg['version'] ~= FE_ADDON_VER) then
				-- do older version cleanup here?
				FishEase_Cfg['version'] = FE_ADDON_VER;
			end

			profile = UnitName("player").." of "..GetCVar("RealmName");
			if (not FishEase_Cfg[profile]) then
				FishEase_Cfg[profile] = {
					['EasyCast'] = true,
					['FastCast'] = true,
					['ShiftCast'] = false,
				};
				Debug("Setting FishEase defaults");
			end
			fe = FishEase_Cfg[profile];
		end

		mainHandSlotID = GetInventorySlotInfo("MainHandSlot");
		offHandSlotID  = GetInventorySlotInfo("SecondaryHandSlot");
		gloveSlotID    = GetInventorySlotInfo("HandsSlot");
		hatSlotID      = GetInventorySlotInfo("HeadSlot");
		bootSlotID     = GetInventorySlotInfo("FeetSlot");

		FE_LearnFishingSkill();

	elseif (event == "SPELLS_CHANGED") then

		FE_LearnFishingSkill();

	end
end

local function FE_ShowToggleStatus(optName, optOutString)
	if (fe[optName]) then
		Print(string.format(FE_OUT_ENABLED, optOutString));
	else
		Print(string.format(FE_OUT_DISABLED, optOutString));
	end
end

-- FishEase command handler
function FE_ChatCommandHandler(msg)
	if (not msg) then return; end
	local args = {};
	for arg in string.gfind(msg, "([%w]+)") do
		table.insert(args, arg);
	end
	if (not args[1]) then
		FE_ShowToggleStatus('EasyCast', FE_OUT_EASYCAST);
		FE_ShowToggleStatus('FastCast', FE_OUT_FASTCAST);
		FE_ShowToggleStatus('ShiftCast', FE_OUT_SHIFTCAST);
	elseif (args[1] and args[1] == FE_CMD_EASYCAST) then
		FE_OptionToggle(args[2], 'EasyCast', FE_SYNTAX_EASYCAST, FE_OUT_EASYCAST);
	elseif (args[1] and args[1] == FE_CMD_FASTCAST) then
		FE_OptionToggle(args[2], 'FastCast', FE_SYNTAX_FASTCAST, FE_OUT_FASTCAST);
	elseif (args[1] and args[1] == FE_CMD_SHIFTCAST) then
		FE_OptionToggle(args[2], 'ShiftCast', FE_SYNTAX_SHIFTCAST, FE_OUT_SHIFTCAST);
	elseif (args[1] and args[1] == FE_CMD_SWITCH) then
		FE_Switch();
	elseif (args[1] and args[1] == FE_CMD_RESET) then
		FE_Reset();
	elseif (args[1] and args[1] == "debug") then
		FE_ToggleDebug();
	else
		for index, value in FE_COMMAND_HELP do
			Print(value);
		end
	end
end

function FE_OptionToggle(togVar, optName, optSyntax, optOutString)
	if (not togVar) then
		fe[optName] = not fe[optName];
	elseif (string.lower(togVar) == "on") then
		fe[optName] = true;
	elseif (togVar == "off") then
		fe[optName] = false;
	else
		Print(FE_SYNTAX_ERROR);
		Print(optSyntax);
		return;
	end
	if (fe[optName]) then
		Print(string.format(FE_OUT_ENABLED, optOutString));
	else
		Print(string.format(FE_OUT_DISABLED, optOutString));
	end
end

--[[ Keeping this for reference
FE_POLES = {
	6256,	-- Fishing Pole
	6365,	-- Strong Fishing Pole
	6366,	-- Darkwood Fishing Pole
	6367,	-- Big Iron Fishing Pole
	12225,	-- Blump Family Fishing Pole
	19022,	-- Nat Pagle\'s Extreme Angler FC-5000
	19970,  -- Arcanite Fishing Pole
}]]
local function FE_IsFishingPoleEquipped()
	local itemIcon = GetInventoryItemTexture("player", mainHandSlotID);
	if (itemIcon and string.find(itemIcon, "INV_Fishingpole")) then
		return true;
	else
		return nil;
	end
end

local function FE_GetInvSlotItemID(slotID)
	local link = GetInventoryItemLink("player", slotID);
	local id = nil;
	if (link) then
		for id in string.gfind(link, "item:(%d+):") do
			return tonumber(id);
		end
	end
	return id;
end

local function FE_GetEquipped()
	local mainHandID, offHandID, gloveID, hatID, bootID = nil, nil, nil, nil, nil;
	mainHandID = FE_GetInvSlotItemID(mainHandSlotID);
	offHandID  = FE_GetInvSlotItemID(offHandSlotID);
	gloveID    = FE_GetInvSlotItemID(gloveSlotID);
	hatID      = FE_GetInvSlotItemID(hatSlotID);
	bootID     = FE_GetInvSlotItemID(bootSlotID);
	return mainHandID, offHandID, gloveID, hatID, bootID;
end

function FE_TurnOrActionStart(arg1)

	-- Disable Click-to-Move if they have a fishing pole equipped
	if (fe['EasyCast'] and GetCVar("autointeract") == "1" and FE_IsFishingPoleEquipped()) then
		clickToMove = "1";
		SetCVar("autointeract", "0");
	end

	-- Pass the call through
	if (Old_TurnOrActionStart) then
		Old_TurnOrActionStart(arg1);
	end

	-- Set the mouse down time
	if (fe['EasyCast']) then
		if (not fe['FastCast'] and (GameTooltip:IsVisible() and (getglobal("GameTooltipTextLeft1"):GetText() == FE_BOBBER_NAME))) then
			downTime = 0;
		else
			downTime = GetTime();
		end
	end
end

function FE_TurnOrActionStop(arg1)

	-- Pass the call through
	if (Old_TurnOrActionStop) then
		Old_TurnOrActionStop(arg1);
	end

	-- Cast if we need to
	if (fe['EasyCast']) then
		local pressTime = GetTime() - downTime;
		if (fishingID and pressTime <= 0.2) then
			if (not fe['ShiftCast'] or (fe['ShiftCast'] and IsShiftKeyDown())) then
				if (FE_IsFishingPoleEquipped()) then
					CastSpell(fishingID, BOOKTYPE_SPELL);
				end
			end
		end
	end

	-- Re-enable Click-to-Move if we changed it
	if (clickToMove and (GetCVar("autointeract") == "0")) then
		SetCVar("autointeract", "1");
	end
end

function FE_FindContainerItem(itemID, searchReverse)
	if (not itemID) then return nil,nil; end

	local foundBag = nil;
	local foundSlot = nil;
	local numSlots = 0;

	local startBag, endBag, bagStep = 0, NUM_BAG_FRAMES, 1;
	if (searchReverse) then
		startBag, endBag, bagStep = NUM_BAG_FRAMES, 0, -1;
	end

	-- check each of the bags on the player
	for i=startBag, endBag, bagStep do

		-- get the number of slots in the bag (0 if no bag)
		numSlots = GetContainerNumSlots(i);
		if (numSlots > 0) then

			-- check each slot in the bag
			local startSlot, endSlot, slotStep = 1, numSlots, 1;
			if (searchReverse) then
				startSlot, endSlot, slotStep = numSlots, 1, -1;
			end
			for j=startSlot, endSlot, slotStep do

				itemLink = GetContainerItemLink(i,j);
				if (itemLink) then

					-- check for the specified itemID
					if (string.find(itemLink, "item:"..itemID..":")) then
						foundBag = i;
						foundSlot = j;
						Debug("Found "..itemLink.." at bag"..foundBag.." slot"..foundSlot);
						-- break out of the slot loop
						break;
					end

				end
			end

			-- break out of the bag loop if we found the item
			if (foundBag) then break; end
		end
	end

	return foundBag, foundSlot;
end

local function FE_Equip(itemID, equipSlot)
	-- fail if something's on the cursor
	if (CursorHasItem()) then
		return false;
	end
	-- make sure it's not already equipped
	local currentLink = GetInventoryItemLink("player",equipSlot);
	if (currentLink and string.find(currentLink, "item:"..itemID..":")) then
		return true;
	end
	-- try to find the item in their bags
	local bag, slot;
	if (equipSlot == mainHandSlotID and fe['normMain'] == fe['normOff']) then
		bag, slot = FE_FindContainerItem(itemID, true);
	else
		bag, slot = FE_FindContainerItem(itemID);
	end
	if (bag and slot) then
		PickupContainerItem(bag, slot);
		if (equipSlot) then
			PickupInventoryItem(equipSlot);
		else
			AutoEquipCursorItem();
		end
		return true;
	end
	return false;
end

local function FE_SaveSwitchItem(itemID, slotID, saveName, setString)
	if (itemID and itemID ~= fe[saveName]) then
		fe[saveName] = itemID;
		if (itemID) then
			Print(string.format(setString,GetInventoryItemLink("player",slotID)));
		end
	end
end

local function FE_SwapSlot(saveName, slotID, setString)
	if (fe[saveName]) then
		if (not FE_Equip(fe[saveName],slotID)) then
			-- couldn't equip item
			Debug("couldn't equip "..saveName.."("..fe[saveName]..") into slot "..slotID);
			fe[saveName] = nil;
		end
	end
	if (not fe[saveName] and setString) then
		Print(setString);
	end
end

function FE_Switch()

	local mainHandID, offHandID, gloveID, hatID, bootID = FE_GetEquipped();

	if (FE_IsFishingPoleEquipped()) then

		-- Save our current fishing gear
		FE_SaveSwitchItem(mainHandID, mainHandSlotID, 'fishPole', FE_OUT_SET_POLE);
		FE_SaveSwitchItem(gloveID, gloveSlotID, 'fishGlove', FE_OUT_SET_FISHING_GLOVES);
		FE_SaveSwitchItem(hatID, hatSlotID, 'fishHat', FE_OUT_SET_FISHING_HAT);
		FE_SaveSwitchItem(bootID, bootSlotID, 'fishBoot', FE_OUT_SET_FISHING_BOOT);

		-- Swap to normal gear
		FE_SwapSlot('normMain', mainHandSlotID, FE_OUT_NEED_SET_NORMAL);
		FE_SwapSlot('normOff', offHandSlotID, nil);
		FE_SwapSlot('normGlove', gloveSlotID, nil);
		FE_SwapSlot('normHat', hatSlotID, nil);
		FE_SwapSlot('normBoot', bootSlotID, nil);

	else

		-- Save our current normal gear
		FE_SaveSwitchItem(mainHandID, mainHandSlotID, 'normMain', FE_OUT_SET_MAIN);
		FE_SaveSwitchItem(offHandID, offHandSlotID, 'normOff', FE_OUT_SET_SECONDARY);
		FE_SaveSwitchItem(gloveID, gloveSlotID, 'normGlove', FE_OUT_SET_GLOVES);
		FE_SaveSwitchItem(hatID, hatSlotID, 'normHat', FE_OUT_SET_HAT);
		FE_SaveSwitchItem(bootID, bootSlotID, 'normBoot', FE_OUT_SET_BOOT);

		-- Swap to fishing gear
		FE_SwapSlot('fishPole', mainHandSlotID, FE_OUT_NEED_SET_POLE);
		FE_SwapSlot('fishGlove', gloveSlotID, nil);
		FE_SwapSlot('fishHat', hatSlotID, nil);
		FE_SwapSlot('fishBoot', bootSlotID, nil);

	end
end

function FE_CastPole()

	-- switch to pole if needed
	if (not FE_IsFishingPoleEquipped()) then
		FE_Switch();
	else
		CastSpell(fishingID, BOOKTYPE_SPELL);
	end

end

function FE_Reset()
	fe['normMain']  = nil;
	fe['normOff']   = nil;
	fe['normGlove'] = nil;
	fe['normHat']   = nil;
	fe['fishPole']  = nil;
	fe['fishGlove'] = nil;
	fe['fishHat']   = nil;
	fe['fishBoot']  = nil;
	Print(FE_OUT_RESET);
end

function FE_ToggleDebug()
	_DEBUG = not _DEBUG;
	if (_DEBUG) then
		Print("Debug output is now on.");
	else
		Print("Debug output is now off.");
	end
end

