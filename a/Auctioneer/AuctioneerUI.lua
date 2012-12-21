--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 3.6.1 (Platypus)
	Revision: $Id: AuctioneerUI.lua 735 2006-03-03 04:04:26Z vindicator $

	Auctioneer UI manager

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
]]

-------------------------------------------------------------------------------
-- Data members
-------------------------------------------------------------------------------
CursorItem = nil;

MoneyTypeInfo["AUCTIONEER"] = {
	UpdateFunc = function()
		return this.staticMoney;
	end,

	collapse = 1,
	fixedWidth = 1,
	showSmallerCoins = 1
};

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctioneerUI_OnLoad()
	Stubby.RegisterFunctionHook("PickupContainerItem", 200, AuctioneerUI_PickupContainerItemHook)
end

-------------------------------------------------------------------------------
-- Called after Blizzard's AuctionFrameTab_OnClick() method.
-------------------------------------------------------------------------------
function AuctioneerUI_AuctionFrameTab_OnClickHook(_, _, index)
	if (not index) then
		index = this:GetID();
	end

	-- Hide the Auctioneer tabs
	AuctionFrameSearch:Hide();
	AuctionFramePost:Hide();
	
	-- Show an Auctioneer tab if its the one clicked
	local tab = getglobal("AuctionFrameTab"..index);
	if (tab) then
		if (tab:GetName() == "AuctionFrameTabSearch") then
			AuctionFrameTopLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-TopLeft");
			AuctionFrameTop:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-Top");
			AuctionFrameTopRight:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-TopRight");
			AuctionFrameBotLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-BotLeft");
			AuctionFrameBot:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-Bot");
			AuctionFrameBotRight:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-BotRight");
			AuctionFrameSearch:Show();
		elseif (tab:GetName() == "AuctionFrameTabPost") then
			AuctionFrameTopLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-TopLeft");
			AuctionFrameTop:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-Top");
			AuctionFrameTopRight:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-TopRight");
			AuctionFrameBotLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-BotLeft");
			AuctionFrameBot:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-Bot");
			AuctionFrameBotRight:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-BotRight");
			AuctionFramePost:Show();
		end
	end
end

-------------------------------------------------------------------------------
-- Called after Blizzard's PickupContainerItem() method in order to capture
-- which item is on the cursor.
-------------------------------------------------------------------------------
function AuctioneerUI_PickupContainerItemHook(_, _, bag, slot)
	if (CursorHasItem()) then
		CursorItem = { bag = bag, slot = slot };
		--EnhTooltip.DebugPrint("Picked up item "..CursorItem.bag..", "..CursorItem.slot);
	else
		CursorItem = nil;
		--EnhTooltip.DebugPrint("Dropped item "..bag..", "..slot);
	end
	AuctioneerUI_GetCursorContainerItem();
end

-------------------------------------------------------------------------------
-- Gets the bag and slot number of the item on the cursor.
-------------------------------------------------------------------------------
function AuctioneerUI_GetCursorContainerItem()
	if (CursorHasItem() and CursorItem) then
		return CursorItem;
	end
	return nil;
end

-------------------------------------------------------------------------------
-- Wrapper for UIDropDownMenu_SetSeletedID() that sets 'this' before calling
-- UIDropDownMenu_SetSelectedID().
-------------------------------------------------------------------------------
function AuctioneerDropDownMenu_SetSelectedID(dropdown, index)
	local oldThis = this;
	this = dropdown;
	local newThis = this;
	UIDropDownMenu_SetSelectedID(dropdown, index);
	-- Double check that the value of 'this' didn't change... this can screw us
	-- up and prevent the reason for this method!
	if (newThis ~= this) then
		EnhTooltip.DebugPrint("WARNING: The value of this changed during AuctioneerDropDownMenu_SetSelectedID()");
	end
	this = oldThis;
end

-------------------------------------------------------------------------------
-- Wrapper for UIDropDownMenu_Initialize() that sets 'this' before calling
-- UIDropDownMenu_Initialize().
-------------------------------------------------------------------------------
function AuctioneerDropDownMenu_Initialize(dropdown, func)
	-- Hide all the buttons to prevent any calls to Hide() inside
	-- UIDropDownMenu_Initialize() which will screw up the value of this.
	local button, dropDownList;
	for i = 1, UIDROPDOWNMENU_MAXLEVELS, 1 do
		dropDownList = getglobal("DropDownList"..i);
		if ( i >= UIDROPDOWNMENU_MENU_LEVEL or frame:GetName() ~= UIDROPDOWNMENU_OPEN_MENU ) then
			dropDownList.numButtons = 0;
			dropDownList.maxWidth = 0;
			for j=1, UIDROPDOWNMENU_MAXBUTTONS, 1 do
				button = getglobal("DropDownList"..i.."Button"..j);
				button:Hide();
			end
		end
	end

	-- Call the UIDropDownMenu_Initialize() after swapping in a value for 'this'.
	local oldThis = this;
	this = getglobal(dropdown:GetName().."Button");
	local newThis = this;
	UIDropDownMenu_Initialize(dropdown, func);
	-- Double check that the value of 'this' didn't change... this can screw us
	-- up and prevent the reason for this method!
	if (newThis ~= this) then
		EnhTooltip.DebugPrint("WARNING: The value of this changed during UIDropDownMenu_Initialize()");
	end
	this = oldThis;
end
