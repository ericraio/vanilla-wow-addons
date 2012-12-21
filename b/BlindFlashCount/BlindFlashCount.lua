--
--  $Id: BlindFlashCount.lua 26 2005-04-17 14:46:10Z savage $
--  $Date: 2005-04-17 16:46:10 +0200 (Sun, 17 Apr 2005) $
--  $Rev: 26 $
--

-- Default display type of BlindFlashCount
BFC_Type = 1;

-- The number of powders for a "green" color indication
BFC_Max = 10;

-- Use colors?
BFC_UseColor = 1;

-- Show debug info
BFC_DebugLevel = 0;
-- -------------------------------------------
-- You shouldnt be editing anything below here
-- unless you know what you are doing.
-- -------------------------------------------
BFC_VERSION = "1.2";
BFC_ICON_VANISH = "Interface\\Icons\\Ability_Vanish";
BFC_ICON_BLIND = "Interface\\Icons\\Spell_Shadow_MindSteal";

-- Text Display Types, i removed HotKey because its ugly and doesnt work on all bars
BFC_DisplayTypes = {
	"Count", "Name",
};

BFC_BlindCount = 0;
BFC_FlashCount = 0;
BFCIcons = {};

-- Onload function, setups hook
function BlindFlashCount_OnLoad()
	-- Dont load this addon for non ROGUE classes
	local _,class = UnitClass("player");
	if (class ~= nil and class ~= "ROGUE") then
		return;
	end
	
	-- setup hook
	BlindFlashCount_SetupHook(1);
		
	-- register events
	BlindFlashCount_Register(1);
	
  	SlashCmdList["BLINDFLASHCOUNT"] = BFC_SlashCmdHandler;
  	SLASH_BLINDFLASHCOUNT1 = "/bfc";
  	SLASH_BLINDFLASHCOUNT2 = "/bf";
		
	DEFAULT_CHAT_FRAME:AddMessage("BlindFlashCount "..BFC_VERSION.." AddOn loaded. Type "..
			GREEN_FONT_COLOR_CODE.."/bfc"..FONT_COLOR_CODE_CLOSE.." for options");
end

function BlindFlashCount_Register(register)
	if (register == 1) then
		this:RegisterEvent("BAG_UPDATE");
		this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	else	
		this:UnregisterEvent("BAG_UPDATE");
		this:UnregisterEvent("UNIT_INVENTORY_CHANGED");
	end
end

function BlindFlashCount_SetupHook(enable)

	if (enable == 1) then
		-- Save original GetActionText function and hook it with ours
		if ((GetActionText ~= BFC_GetActionText) and (BFC_OriginalGetActionText == nil)) then			
			BFC_OriginalGetActionText = GetActionText;
			GetActionText = BFC_GetActionText;		
		end	
	else
		-- Unhook the function
		if (GetActionText == BFC_GetActionText) then
			GetActionText = BFC_OriginalGetActionText;
			BFC_OriginalGetActionText = nil;
		end	
	end
end

-- Something changed in our bags, update the counts
function BlindFlashCount_OnEvent()
	BFC_DebugPrint("BlindFlashCount_OnEvent() -> ".. event);
	
	if ( (event == "UNIT_INVENTORY_CHANGED") and (arg1 ~= "player") ) then
		-- inventory change did not occur on player
		return;
	end
	
	BFC_BlindCount, BFC_FlashCount = BFC_GetBlindFlashCount();
	BFC_UpdateIcons();
end


function BFC_SlashCmdHandler(msg)
	local GREEN = GREEN_FONT_COLOR_CODE;
	local CLOSE = FONT_COLOR_CODE_CLOSE;
	local NORMAL = NORMAL_FONT_COLOR_CODE;
	
	if ( (not msg) or (strlen(msg) <= 0 ) or (msg == "help") ) then
		DEFAULT_CHAT_FRAME:AddMessage(NORMAL.."BlindFlashCount "..BFC_VERSION.." usage:"..CLOSE);
		DEFAULT_CHAT_FRAME:AddMessage(GREEN.." /bfc help    "..CLOSE.." - This screen");
		DEFAULT_CHAT_FRAME:AddMessage(GREEN.." /bfc on | off"..CLOSE.." - Enable/Disable BlindFlashCount");
		DEFAULT_CHAT_FRAME:AddMessage(GREEN.." /bfc color   "..CLOSE.." - Toggle use of color indication");
		DEFAULT_CHAT_FRAME:AddMessage(GREEN.." /bfc type    "..CLOSE.." - Toggle count indication type (count/name)");
	elseif (msg == "on") then	
		BlindFlashCount_SetupHook(1);		
		BlindFlashCount_Register(1);
		
		BFC_UpdateIcons(1);
		BFC_UpdateIcons();
				
		DEFAULT_CHAT_FRAME:AddMessage("BlindFlashCount is now "..GREEN.."Enabled"..CLOSE);
		
	elseif (msg == "off") then
		BlindFlashCount_SetupHook(0);
		BlindFlashCount_Register(0);
				
		BFC_UpdateIcons(1);
		
		DEFAULT_CHAT_FRAME:AddMessage("BlindFlashCount is now "..GREEN.."Disabled"..CLOSE);
		
	elseif (msg == "color") then
		if (BFC_UseColor == 1) then
			BFC_UseColor = 0;			
			DEFAULT_CHAT_FRAME:AddMessage("BlindFlashCount's Color Indicator is now turned "..GREEN.."Off"..CLOSE);
		else
			BFC_UseColor = 1;			
			DEFAULT_CHAT_FRAME:AddMessage("BlindFlashCount's Color Indicator is now turned "..GREEN.."On"..CLOSE);
		end
		
		BFC_UpdateIcons();
	elseif (msg == "type") then
		
		if (BFC_Type >= getn(BFC_DisplayTypes)) then
			BFC_Type = 1;
		else
			BFC_Type = BFC_Type + 1;
		end
	
		DEFAULT_CHAT_FRAME:AddMessage("BlindFlashCount's DisplayType is set to "..
					      GREEN..BFC_DisplayTypes[BFC_Type]..CLOSE);
		BFC_UpdateIcons(1);
		BFC_UpdateIcons();
	elseif (msg == "debug") then
		if (BFC_DebugLevel == nil or BFC_DebugLevel == 0) then
			BFC_DebugLevel = 1;
			DEFAULT_CHAT_FRAME:AddMessage("BlindFlashCount Debug Information "..
						      GREEN.."ON"..CLOSE);
		else
			BFC_DebugLevel = 0;
			DEFAULT_CHAT_FRAME:AddMessage("BlindFlashCount Debug Information "..
						      GREEN.."OFF"..CLOSE);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Unknown BlindFlashCount command: "..GREEN..msg..CLOSE..
					      ", try "..GREEN.."/bfc help"..CLOSE);
	end
end

-- Hook function for GetActionText
function BFC_GetActionText(slot)
	
	--local slotCount = getglobal(this:GetName().."Count");
	--local slotName = getglobal(this:GetName().."Name");
	--local slotHotKey = getglobal(this:GetName().."HotKey");
		
	if (this == nil) then
		-- the "this" reference is nil, that means we cant get the button's name, so bail out.
		return BFC_OriginalGetActionText(slot);
	end
		
	local texture = GetActionTexture(slot);		
	local slotText = getglobal(this:GetName()..BFC_DisplayTypes[BFC_Type]);
	local buttonName = this:GetName();
	
	if (slotText == nil) then
		-- sometimes the button doesnt have a full name yet, so we are trying to guess it
		slotText = getglobal(this:GetName().."Button"..slot..BFC_DisplayTypes[BFC_Type]);
		buttonName = this:GetName().."Button"..slot;
		if (slotText == nil) then
			-- failed, lets just bail out before something goes wrong
			return BFC_OriginalGetActionText(slot);
		end
	end
		
	if (texture == BFC_ICON_VANISH or texture == BFC_ICON_BLIND) then
		-- Add this button/slot to icon table so it can be updated later
		BFC_AddButtonSlotToIconTable(slot, buttonName);
		
		local count = BFC_FlashCount;
		if (texture == BFC_ICON_BLIND) then
			count = BFC_BlindCount;
		end
		
		BFC_SetColor(slotText, count);
				
		if (BFC_DisplayTypes[BFC_Type] == "Name") then
			-- GetActionText is called from a "Name" button.
			-- return the count, so it gets updated with SetText.
			return count;
		else
			slotText:SetText(count);
		end
	end

	return BFC_OriginalGetActionText(slot);
end

-- Sets the color of the powder count
function BFC_SetColor(button, count)
	local r, g, b;
	
	if ((count == "") or (BFC_UseColor == 0)) then
		button:SetTextColor(1.0, 1.0, 1.0);
		return;
	end
	
	if ( (count < 0) or (count > BFC_Max) ) then
		count = BFC_Max
	end	
	count = count / BFC_Max;
	
	if(count > 0.5) then
		r = (1.0 - count) * 2;
		g = 1.0;
	else
		r = 1.0;
		g = count * 2;
	end

	b = 0.0;
	button:SetTextColor(r, g, b);
end;

-- Returns the itemname for bag, slot (code from CapnBry)
function BFC_GetItemName(bag, slot)
	local linktext = nil;
  
	if (bag == -1) then
		linktext = GetInventoryItemLink("player", slot);
  	else
		linktext = GetContainerItemLink(bag, slot);
	end

	if linktext then
		local _,_,name = string.find(linktext, "^.*%[(.*)%].*$");
		return name;
	else
		return "";
	end;
end;

-- Returns blind, flash count
function BFC_GetBlindFlashCount()
	local blind = 0;
	local flash = 0;

	for bag = 0, 4, 1 do
		for slot = 1, GetContainerNumSlots(bag), 1 do
			local name = BFC_GetItemName(bag, slot);
			-- check if item is a blinding powder
			if (name == BFC_ITEM_BLIND) then
				local _, itemCount = GetContainerItemInfo(bag, slot);
				blind = blind + itemCount;
			-- check if item is a flash powder
			elseif (name == BFC_ITEM_FLASH) then
				local _, itemCount = GetContainerItemInfo(bag, slot);
				flash = flash + itemCount;
			end
		end
	end

	return blind, flash;
end


-- Updates the buttons in the icon table with the new blind/flash count
-- mode 1 = refresh all text labels, used when changing display type
-- mode 2 = clear all text, used for turning off BlindFlashCount
function BFC_UpdateIcons(clear)
	local newIcons = BFCIcons;
		
	for k, v in BFCIcons do		
		--local slot = getglobal(button):GetID();
		local slot = v[1];
		local slotText = getglobal(v[2]..BFC_DisplayTypes[BFC_Type]);
		
		local texture = GetActionTexture(slot);
		local count = "";
		if (texture == BFC_ICON_VANISH) then
			BFC_DebugPrint("!!updating button: ".. v[2] .. " id: "..slot);
			count = BFC_FlashCount;
		elseif (texture == BFC_ICON_BLIND) then
			BFC_DebugPrint("!!updating button: ".. v[2] .. " id: "..slot);
			count = BFC_BlindCount;
		else
			-- icon became something else, remove from table
			BFC_DebugPrint("--removing stale icon ".. v[2] .. " id: "..slot);
			tremove(newIcons, key);
		end
		
		if (clear == 1) then
			for k, displaytype in BFC_DisplayTypes do
				local oldText = getglobal(v[2]..displaytype);
				BFC_DebugPrint("****Name: " .. oldText:GetName());
				oldText:SetText("");
				oldText:SetTextColor(1.0, 1.0, 1.0);
			end
		else		
			slotText:SetText(count);
			BFC_SetColor(slotText, count);
		end
	end
	
	BFCIcons = newIcons;
end

-- Adds a button + slot to the icon table, so it can be updated later
function BFC_AddButtonSlotToIconTable(slot, button)
	if (slot == nil or button == nil) then
		return;
	end
	
	BFC_DebugPrint("++Adding button: " .. button .. " id: " .. slot);

	for k, v in BFCIcons do
		if (v[1] == slot and v[2] == button) then
			BFCIcons[k] = {slot, button};
			BFC_DebugPrint("**Duplicate Button: " .. button .. " id: " .. slot);
			return;
		end
	end	
	
	if (not BFCIcons) then
		BFCIcons = {};
	end
	
	tinsert(BFCIcons, {slot, button});
end

-- some debug functions
--
function BFC_DebugPrint(msg, level)
	if (not BFC_DebugLevel) then
		BFC_DebugLevel = 0;
	end
	
	if (not level) then
		level = 1;
	end
	
	if (BFC_DebugLevel >= level) then
		DEFAULT_CHAT_FRAME:AddMessage("|cff00caca[BFC]|r " .. msg);
	end
end

function BFC_SetBlindCount(count)
	BFC_BlindCount = count;
	BFC_UpdateIcons();
end

function BFC_SetFlashCount(count)
	BFC_FlashCount = count;
	BFC_UpdateIcons();
end

function BFC_SetMax(max)
	BFC_Max = max;
	BFC_UpdateIcons();
end

function BFC_SetDebug(level)
	BFC_DebugLevel = level;
end