
-- This is a function calling array for any other addons that wish to "tap-in" to these tooltips
LINK_WRANGLER_CALLER = {};

-- Credit Legorol

IRR_LINK_COLOR_OPEN		= "|cff";
IRR_LINK_COLORS = {};
IRR_LINK_COLORS[0]		= "9d9d9d";	-- grey
IRR_LINK_COLORS[1]		= "ffffff"; -- white
IRR_LINK_COLORS[2]		= "1eff00"; -- green
IRR_LINK_COLORS[3]		= "0070dd"; -- blue
IRR_LINK_COLORS[4]		= "a335ee"; -- purple
IRR_LINK_COLORS[5]		= "ff8000"; -- gold (legendary)
IRR_LINK_HYPERLINK_OPEN	= "|H";
IRR_LINK_LINK_OPEN		= "|h[";
IRR_LINK_LINK_CLOSE		= "]|h";
IRR_LINK_COLOR_CLOSE	= "|r";

IRR_MIN_HEIGHT = 132;

-------------------------------------------------------------------------------------------
-- GLOBALS
-------------------------------------------------------------------------------------------
IRR_ItemTypes = {
	[INVTYPE_WEAPONMAINHAND]	= {[1] = 16},		-- Main Hand
	[INVTYPE_2HWEAPON]			= {[1] = 16,[2] = 17},		-- Two-Hand
	[INVTYPE_WEAPON]			= {[1] = 16,[2] = 17},		-- One-Hand
	[INVTYPE_WEAPON_OTHER]		= {[1] = 16,[2] = 17},		-- One-Hand_other
	[INVTYPE_SHIELD]			= {[1] = 17},		-- Off Hand
	[INVTYPE_WEAPONOFFHAND]		= {[1] = 17},		-- Off Hand
	[INVTYPE_HOLDABLE]			= {[1] = 17},		-- Held In Off-hand
	[INVTYPE_HEAD]				= {[1] = 1},		-- Head
	[INVTYPE_WAIST]				= {[1] = 6},		-- Waist
	[INVTYPE_SHOULDER]			= {[1] = 3},		-- Shoulder
	[INVTYPE_LEGS]				= {[1] = 7},		-- Legs
	[INVTYPE_CLOAK]				= {[1] = 15},		-- Back
	[INVTYPE_FEET]				= {[1] = 8},		-- Feet
	[INVTYPE_CHEST]				= {[1] = 5},		-- Chest
	[INVTYPE_ROBE]				= {[1] = 5},		-- Chest
	[INVTYPE_WRIST]				= {[1] = 9},		-- Wrist
	[INVTYPE_HAND]				= {[1] = 10},		-- Hands
	[INVTYPE_RANGED]			= {[1] = 18},		-- Ranged
	[INVTYPE_BODY]				= {[1] = 4},		-- Shirt
	[INVTYPE_TABARD]			= {[1] = 19},		-- Tabard
	[INVTYPE_FINGER]			= {[1] = 11,[2] = 12},		-- Finger
	[INVTYPE_FINGER_OTHER]		= {[1] = 12,[2] = 12},		-- Finger_other
	[INVTYPE_NECK]				= {[1] = 2},		-- Neck
	[INVTYPE_TRINKET]			= {[1] = 13,[2] = 14},		-- Trinket
	[INVTYPE_TRINKET_OTHER]		= {[1] = 13,[2] = 14},		-- Trinket_other
	[INVTYPE_WAND]				= {[1] = 18},		-- Wand
	[INVTYPE_GUN]				= {[1] = 18},		-- Gun
	[INVTYPE_GUNPROJECTILE]		= {[1] = 0},		-- Projectile
	[INVTYPE_BOWPROJECTILE]		= {[1] = 0}			-- Projectile
};

IRR_SlotIDtoSlotName = {
	[0] = AMMOSLOT,		-- 0
	HEADSLOT,			-- 1
	NECKSLOT,			-- 2
	SHOULDERSLOT,		-- 3
	SHIRTSLOT,			-- 4
	CHESTSLOT,			-- 5
	WAISTSLOT,			-- 6
	LEGSSLOT,			-- 7
	FEETSLOT,			-- 8
	WRISTSLOT,			-- 9
	HANDSSLOT,			-- 10
	FINGER0SLOT,		-- 11
	FINGER1SLOT,		-- 12
	TRINKET0SLOT,		-- 13
	TRINKET1SLOT,		-- 14
	BACKSLOT,			-- 15
	MAINHANDSLOT,		-- 16
	SECONDARYHANDSLOT,	-- 17
	RANGEDSLOT,			-- 18
	TABARDSLOT,			-- 19
};


IR_MOD_ITEMREF_WINDOWS = {};
IR_MOD_CHAT_BUFFER = {};
IR_MOD_CHAT_NAMES_BUFFER = {};
IR_MOD_CHAT_BUFFER_MAX = 60;
IR_MOD_CHAT_BUFFER_INDEX = 1;

IR_MOD_AUCTIONEER_INDEX = 0;
IR_MOD_AUCTIONEER_POS = 0;

-------------------------------------------------------------------------------------------
-- UTILITY
-------------------------------------------------------------------------------------------
local function dout(msg)
	if( DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(msg,1.0,0,0);
	end
end

-------------------------------------------------------------------------------------------
-- ADDON SUPPORT
-------------------------------------------------------------------------------------------
function LinkWrangler_AddonContent(func, addonName, index)
	local frame = IR_MOD_ITEMREF_WINDOWS[index].window;
	local link = IR_MOD_ITEMREF_WINDOWS[index].itemRefID;
	
	if (func ~= nil) then
		--dout(func);
		local caller = getglobal(func);
		
		if (caller ~= nil) then
			caller(frame,link);
			frame:Show();
		else
			dout("Link Wrangler Error: Attempt to call appender \""..func.."\" for AddOn: \""..addonName.."\" failed.");
		end
	else
		dout("Link Wrangler Error: Attempt to call appender for AddOn: \""..addonName.."\" failed.");
	end
end

function IRR_DoAuctioneerFrame(index)
	if (IsAddOnLoaded("Auctioneer") ~= nil) then
		--dout("IRR_DoAuctioneerFrame");
		if (IR_MOD_ITEMREF_WINDOWS[index].minimized == nil) then
			local frame = IR_MOD_ITEMREF_WINDOWS[index].window;

			local link = IR_MOD_ITEMREF_WINDOWS[index].itemRefID;
			
			if (frame:IsVisible()) then
				local itemText = getglobal(IR_MOD_ITEMREF_WINDOWS[index].windowName.."TextLeft1");
				local name = itemText:GetText();
				if (name) then
					local fabricatedLink = "|cff000000|H"..link.."|h["..name.."]|h|r";
									
					if (AuctionConfig.filters['embed'] == "on") then
						frame:SetHyperlink("item:1710:0:0:0");
						frame:SetHyperlink(IR_MOD_ITEMREF_WINDOWS[index].itemRefID);
					end

					if (TT_Clear) then
						TT_Clear();
						TT_TooltipCall(frame, name, fabricatedLink, -1, 1, 0);
						TT_Show(frame);
					elseif (EnhTooltip.TooltipCall) then -- requires LW version of EnhTooltip
						EnhTooltip.ClearTooltip();
						EnhTooltip.TooltipCall(frame, name, fabricatedLink, -1, 1, 0);
					end
						
					if (IR_MOD_ITEMREF_WINDOWS[index].firstTimeAuc == 1) then
						IR_MOD_ITEMREF_WINDOWS[index].firstTimeAuc = 0;
					else
						if (AuctionConfig.filters['embed'] == "on") then
							table.foreach(LINK_WRANGLER_CALLER, function(k,v) LinkWrangler_AddonContent(v,k,index); end);
						end
					end
					
					IR_MOD_AUCTIONEER_POS = EnhancedTooltip:GetLeft();
					IR_MOD_AUCTIONEER_INDEX = index;
				end
			end
		end
	end
end



-------------------------------------------------------------------------------------------
-- UTILITY
-------------------------------------------------------------------------------------------
function IRR_CompareItem(index)
	--dout("slot: "..GetInventorySlotInfo("RangedSlot"));
	
	local itemComp1 = getglobal("IRR_ItemCompTooltip"..index);
	local itemComp1Name = "IRR_ItemCompTooltip"..index;
	local itemComp2 = getglobal("IRR_ItemCompTool"..index+10);
	local itemComp2Name = "IRR_ItemCompTool"..index+10;
	
	if (IR_MOD_ITEMREF_WINDOWS[index].compare == 0) then
		IR_MOD_ITEMREF_WINDOWS[index].compare = 1;
		
		--local slotID = IRR_GetCompareItemIndex(IR_MOD_ITEMREF_WINDOWS[index].windowName);
		local slots = IR_MOD_ITEMREF_WINDOWS[index].slots;
		
		if (slots == nil) then
			return;
		end

		ShowUIPanel(itemComp1);
		itemComp1:SetOwner(UIParent, "ANCHOR_NONE");
		itemComp1:SetPoint("BOTTOMLEFT",IR_MOD_ITEMREF_WINDOWS[index].windowName,"TOPLEFT",0,10);
		itemComp1:SetInventoryItem("player",slots[1]);
				
		if (table.getn(slots) > 1) then
			--dout("more");
			ShowUIPanel(itemComp2);
			itemComp2:SetOwner(UIParent, "ANCHOR_NONE");
			itemComp2:SetPoint("BOTTOMLEFT","IRR_ItemCompTooltip"..index,"TOPLEFT",0,10);
			itemComp2:SetInventoryItem("player",slots[2]);
		end
	else
		IR_MOD_ITEMREF_WINDOWS[index].compare = 0;
		HideUIPanel(itemComp1);
		HideUIPanel(itemComp2);
	end
end


function IRR_GetCompareItemIndex(frame)
	--local tooltip = getglobal(frame);

	for i=1,6 do
		--dout(i);
		local typeText = getglobal(frame.."TextLeft"..i);
		local type = typeText:GetText();
		local checkType = 1;
		if (type == nil) then
			checkType = 0;
		end

		if (checkType == 1) then
			--dout("type: "..type)
			
			local retVal =  IRR_ItemTypes[type];

			if (retVal ~= nil) then
				--dout("returning")
				return retVal;
			end
			--dout("not returning")
		end
	end
end

function IRR_CloseAllWindows()
	-- Next deal with the no windows open logic
	for i=1,table.getn(IR_MOD_ITEMREF_WINDOWS) do
		local info = IR_MOD_ITEMREF_WINDOWS[i];

		info.state = 0;
		info.link = 0;
		info.compare = 0;
		info.whisper = nil;
		info.textlink = nil;
		info.itemRefID = nil;
		info.itemID = nil;
		info.quality = nil;
		info.name = nil;
		info.firstTimeAuc = 1;
		
		HideUIPanel(info.window);

		local comp1 = getglobal("IRR_ItemCompTooltip"..i);
		HideUIPanel(comp1);

		local comp2 = getglobal("IRR_ItemCompTool"..i+10);
		HideUIPanel(comp2);
	end

	GameTooltip:Hide();
end

function IRR_GetWindowIndex(link)
	-- First check if the item is already displayed
	for i=1,table.getn(IR_MOD_ITEMREF_WINDOWS) do
		local info = IR_MOD_ITEMREF_WINDOWS[i];

		if (info.link == link) then
			IRR_ItemRefTooltip_OnClick(i);
			return 0;
		end
	end

	
	-- Next check for open windows to display item in
	for i=1,table.getn(IR_MOD_ITEMREF_WINDOWS) do
		local info = IR_MOD_ITEMREF_WINDOWS[i];

		if (info.state == 0) then
			info.state = 1;
			info.link = link;
			return info.index;
		end
	end

	IRR_CloseAllWindows();

	local info = IR_MOD_ITEMREF_WINDOWS[1];
	info.state = 1;
	info.link = link;
	return 1;
end

function IRR_GetItemTextLink(item,linkStr,index,itemName)
	local startPos,endPos = string.find(linkStr,item,1,true);
	local startBound = "|cff";
	local endBound = "|r";

	-- check for colored links first
	local lastLinkStart;
	local linkStart = string.find(linkStr,startBound,1,true);
	
	local whisperButton = getglobal("ItemRefWhisperButton"..index);
	whisperButton:SetButtonState("NORMAL");

	if (linkStart == nil) then -- link is from loot
		-- disable the whisper button
		whisperButton:SetButtonState("DISABLED");
			
		local bag,slot = IRR_FindItem(itemName, skipcount);
		
		if (bag and slot) then
			link = GetContainerItemLink(bag, slot);
			return link;
		else
			return nil;
		end
	end

	--dout("linkstart: "..linkStart);
	while (linkStart ~= nil) and (linkStart < startPos) do
		lastLinkStart = linkStart;
		linkStart = string.find(linkStr,startBound,(lastLinkStart+1),true);
	end

	linkStart = lastLinkStart;

	local linkEnd = string.find(linkStr,endBound,endPos,true);

	if (linkEnd == nil) then
		return;
	end

	linkEnd = linkEnd + 1;

	local link = strsub(linkStr, linkStart, linkEnd);
	--dout(link);
	
	--IRR_DecryptLink("mine: "..link);

	return link;

end


function IRR_SetWhisperPlayerAndLink(index,frame)
	--local itemText = getglobal(frame.."TextLeft1");
	local itemName = IR_MOD_ITEMREF_WINDOWS[index].name;

	local item = "["..itemName.."]";
	
	--if (item == nil) then
		--dout("nil returning");
	--	return;
	--end
	--dout("item: "..item);
	
	-- 
	local foundIndex = 0;
	for i=1,table.getn(IR_MOD_CHAT_BUFFER) do
		local startPos,endPos = string.find(IR_MOD_CHAT_BUFFER[i],item,1,true);

		--dout("chatbuf: "..IR_MOD_CHAT_BUFFER[i]);
		if (startPos ~= nil) then
			foundIndex = i;
			--dout("found");
		end
	end

	local whisperButton = getglobal("ItemRefWhisperButton"..index);
	whisperButton:SetButtonState("DISABLED");
	if (foundIndex > 0) then
		local member = IR_MOD_CHAT_NAMES_BUFFER[foundIndex];

		if (string.len(member) > 0) then
			IR_MOD_ITEMREF_WINDOWS[index].whisper = member;
			whisperButton:SetButtonState("NORMAL");
		else
			whisperButton:SetButtonState("DISABLED");
			IR_MOD_ITEMREF_WINDOWS[index].whisper = "";
		end
			
	end

	-- New link
	local textLink = IRR_LINK_COLOR_OPEN;
	textLink = textLink..IRR_LINK_COLORS[IR_MOD_ITEMREF_WINDOWS[index].quality];
	textLink = textLink..IRR_LINK_HYPERLINK_OPEN;
	textLink = textLink..IR_MOD_ITEMREF_WINDOWS[index].itemRefID;
	textLink = textLink..IRR_LINK_LINK_OPEN;
	textLink = textLink..IR_MOD_ITEMREF_WINDOWS[index].name;
	textLink = textLink..IRR_LINK_LINK_CLOSE;
	textLink = textLink..IRR_LINK_COLOR_CLOSE;

	IR_MOD_ITEMREF_WINDOWS[index].textlink = textLink;

	--IRR_DecryptLink(linkStr);
	--IRR_DecryptLink(textLink);
	--dout("quality: "..iiRarity);
	--ITEM_QUALITY_COLORS
end

function IRR_DecryptLink(link)
	local dString = "";

	for i=1,string.len(link) do
		dString = dString.."-"..string.char(string.byte(link,i));
	end

	dout(dString);
end


function IRR_DoWhisperPlayer(index)
	local member = IR_MOD_ITEMREF_WINDOWS[index].whisper;

	if (member ~= nil) then
		if ( not ChatFrameEditBox:IsVisible() ) then
			ChatFrame_OpenChat("/w "..member.." ");
		else
			ChatFrameEditBox:SetText("/w "..member.." ");
		end
	end
end

function IRR_DoRelinkItem(index)
	local link = IR_MOD_ITEMREF_WINDOWS[index].textlink;
	--IRR_DecryptLink("chat edit: "..link);

	if (link ~= nil) then
		if ( not ChatFrameEditBox:IsVisible() ) then
			ChatFrame_OpenChat(link);
		else
			ChatFrameEditBox:SetText(ChatFrameEditBox:GetText()..link);
		end
	end
end

function IRR_DoRelinkCompItem(index,compWindow)
	local link = IR_MOD_ITEMREF_WINDOWS[index].compareLinks[compWindow];
	--IRR_DecryptLink("chat edit: "..link);

	if (link ~= nil) then
		if ( not ChatFrameEditBox:IsVisible() ) then
			ChatFrame_OpenChat(link);
		else
			ChatFrameEditBox:SetText(ChatFrameEditBox:GetText()..link);
		end
	end
end

function IRR_DoDressingRoom(index)
	--dout(IR_MOD_ITEMREF_WINDOWS[index].itemID);
	--dout(IR_MOD_ITEMREF_WINDOWS[index].itemRefID);
	--dout("dress up");
	--ShowUIPanel(DressUpFrame);
	--DressUpModel:Dress();
	--DressUpModel:TryOn(IR_MOD_ITEMREF_WINDOWS[index].itemID);

	DressUpItemLink(IR_MOD_ITEMREF_WINDOWS[index].itemRefID);
	
end

function IRR_GetItemID(link)
	return string.sub(link,6,string.find(link,":",6)-1);
end

function IRR_FindItem(name, skipcount)
	skipcount = skipcount or 0;
	
	for i=NUM_BAG_FRAMES,0,-1 do
		for j=GetContainerNumSlots(i),1,-1 do
			if (IRR_GetItemName(i,j) == name) then 
				if skipcount == 0 then 
					return i,j; 
				end
				skipcount = skipcount - 1;
			end
		end
	end
end

function IRR_GetItemName(bag, slot)
	local linktext = nil;

	linktext = GetContainerItemLink(bag, slot);
	
	if linktext then
		local _,_,name = string.find(linktext, "^.*%[(.*)%].*$");
		return name;
	else
		return "";
	end
end

function IRR_DoEllipses(text,maxWidth)
	local s = text:GetText();
	s = string.sub(s,1,string.len(s)-7);
	
	return s.."...";
end

function IRR_ClearAllFields(index)
	for i=2,30 do
		local text1 = getglobal(IR_MOD_ITEMREF_WINDOWS[index].windowName.."TextLeft"..i);
		local text2 = getglobal(IR_MOD_ITEMREF_WINDOWS[index].windowName.."TextRight"..i);

		text1:SetText("");
		text2:SetText("");
	end
end

function IRR_DoMinimize(index)
	if (IR_MOD_ITEMREF_WINDOWS[index].minimized ~= nil) then
		--dout("restore");
		IR_MOD_ITEMREF_WINDOWS[index].minimized = nil;
		
		for i=2,30 do
			local text1 = getglobal(IR_MOD_ITEMREF_WINDOWS[index].windowName.."TextLeft"..i);
			local text2 = getglobal(IR_MOD_ITEMREF_WINDOWS[index].windowName.."TextRight"..i);

			local text1Str = text1:GetText();
			--local text2Str = text2:GetText();
			
			if (IR_MOD_ITEMREF_WINDOWS[index].fontStringStatus1[i] == 1) then
				text1:Show();
			end

			if (IR_MOD_ITEMREF_WINDOWS[index].fontStringStatus2[i] == 1) then
				text2:Show();
			end
		end

		local compareButt = getglobal("ItemRefCompButton"..index);
		local whisperButt = getglobal("ItemRefWhisperButton"..index);
		local relinkButt = getglobal("ItemRefRelinkButton"..index);
		local DRButt = getglobal("ItemRefDRButton"..index);

		compareButt:Show();
		whisperButt:Show();
		relinkButt:Show();
		DRButt:Show();

		local text1 = getglobal(IR_MOD_ITEMREF_WINDOWS[index].windowName.."TextLeft1");
		text1:SetText(IR_MOD_ITEMREF_WINDOWS[index].name);

		-- move min button
		local minButton = getglobal("ItemRefMinButton"..index);
		minButton:SetPoint("TOPRIGHT","ItemRefCloseButton"..index,"TOPRIGHT",0,-20);
		
		if (AUCTIONEER_VERSION ~= nil or ENCHANTRIX_VERSION ~= nil) then
			IRR_DoAuctioneerFrame(index);
		end
	else
		--dout("minimize");
		IR_MOD_ITEMREF_WINDOWS[index].minimized = 1;
			
		for i=2,30 do
			local text1 = getglobal(IR_MOD_ITEMREF_WINDOWS[index].windowName.."TextLeft"..i);
			local text2 = getglobal(IR_MOD_ITEMREF_WINDOWS[index].windowName.."TextRight"..i);

			if (text1:IsVisible()) then
				IR_MOD_ITEMREF_WINDOWS[index].fontStringStatus1[i] = 1;
			else
				IR_MOD_ITEMREF_WINDOWS[index].fontStringStatus1[i] = 0;
			end

			if (text2:IsVisible()) then
				IR_MOD_ITEMREF_WINDOWS[index].fontStringStatus2[i] = 1;
			else
				IR_MOD_ITEMREF_WINDOWS[index].fontStringStatus2[i] = 0;
			end

			text1:Hide();
			text2:Hide();
		end

		--dout("Window Width: "..IR_MOD_ITEMREF_WINDOWS[index].window:GetWidth());
		--local text1 = getglobal(IR_MOD_ITEMREF_WINDOWS[index].windowName.."TextLeft1");
		--dout("String width: "..text1:GetStringWidth());

		local windowWidth = IR_MOD_ITEMREF_WINDOWS[index].window:GetWidth() -37 - 32;
		local text1 = getglobal(IR_MOD_ITEMREF_WINDOWS[index].windowName.."TextLeft1");
		local stringWidth = text1:GetStringWidth();

		if (stringWidth >= windowWidth) then
			text1:SetText(IRR_DoEllipses(text1,windowWidth));
		end

		-- move min button
		local minButton = getglobal("ItemRefMinButton"..index);
		minButton:SetPoint("TOPRIGHT","ItemRefCloseButton"..index,"TOPRIGHT",-20,0);
		
		local compareButt = getglobal("ItemRefCompButton"..index);
		local whisperButt = getglobal("ItemRefWhisperButton"..index);
		local relinkButt = getglobal("ItemRefRelinkButton"..index);
		local DRButt = getglobal("ItemRefDRButton"..index);

		compareButt:Hide();
		whisperButt:Hide();
		relinkButt:Hide();
		DRButt:Hide();

		local compFrame1 = getglobal("IRR_ItemCompTooltip"..index);
		local compFrame2 = getglobal("IRR_ItemCompTool"..index+10);
		IR_MOD_ITEMREF_WINDOWS[index].compare = 0;

		compFrame1:Hide();
		compFrame2:Hide();

		if (AUCTIONEER_VERSION ~= nil or ENCHANTRIX_VERSION ~= nil) then
			if (TT_Clear) then
				TT_Clear();
			elseif(EnhTooltip.ClearTooltip) then
				EnhTooltip.ClearTooltip();
			end
		end
	end
end

-------------------------------------------------------------------------------------------
-- EVENT HANDLERS
-------------------------------------------------------------------------------------------
function IRR_OnLoad()
	this:RegisterEvent("CHAT_MSG_GUILD");
	this:RegisterEvent("CHAT_MSG_PARTY");
	this:RegisterEvent("CHAT_MSG_CHANNEL");
	this:RegisterEvent("CHAT_MSG_WHISPER");
	this:RegisterEvent("CHAT_MSG_RAID");
	this:RegisterEvent("CHAT_MSG_OFFICER");
	this:RegisterEvent("CHAT_MSG_SAY");
	this:RegisterEvent("CHAT_MSG_LOOT");
	this:RegisterEvent("CHAT_MSG_YELL");
end

function IRR_OnEvent(event,arg1,arg2)
	IR_MOD_CHAT_BUFFER[IR_MOD_CHAT_BUFFER_INDEX] = nil;
	IR_MOD_CHAT_BUFFER[IR_MOD_CHAT_BUFFER_INDEX] = arg1;
	IR_MOD_CHAT_NAMES_BUFFER[IR_MOD_CHAT_BUFFER_INDEX] = nil;
	IR_MOD_CHAT_NAMES_BUFFER[IR_MOD_CHAT_BUFFER_INDEX] = arg2;
	
	IR_MOD_CHAT_BUFFER_INDEX = IR_MOD_CHAT_BUFFER_INDEX + 1;

	if (IR_MOD_CHAT_BUFFER_INDEX > IR_MOD_CHAT_BUFFER_MAX) then
		IR_MOD_CHAT_BUFFER_INDEX = 1;
	end

	--dout("stored: "..IR_MOD_CHAT_NAMES_BUFFER[IR_MOD_CHAT_BUFFER_INDEX-1]..": "..IR_MOD_CHAT_BUFFER[IR_MOD_CHAT_BUFFER_INDEX-1]);
end


function IRR_EscPressed()
	dout("Escape");
end

function IRR_ItemRefTooltip_OnLoad(index)
	local windowInfo = {};

	local itemFrame = getglobal("IRR_ItemRefTooltip"..index);
	local itemFrameName = "IRR_ItemRefTooltip"..index;
	local compFrame = getglobal("IRR_ItemCompTooltip"..index);
	local compFrameName = "IRR_ItemCompTooltip"..index;
	
	windowInfo.window = itemFrame;
	windowInfo.windowName = itemFrameName;
	
	windowInfo.index = index;
	windowInfo.state = 0;
	windowInfo.link = 0;
	windowInfo.compare = 0;
	windowInfo.compareWindow = compFrame;
	windowInfo.compareWindowName = compFrameName;
	windowInfo.slots = nil;
	windowInfo.whisper = nil;
	windowInfo.textlink = nil;
	windowInfo.itemRefID = nil;
	windowInfo.itemID = nil;
	windowInfo.quality = nil;
	windowInfo.name = nil;
	windowInfo.minimized = nil;
	windowInfo.originalHeight = nil;
	windowInfo.compareLinks = {};
	windowInfo.firstTimeAuc = 1;
	windowInfo.fontStringStatus1 = {};
	windowInfo.fontStringStatus2 = {};
	
	IR_MOD_ITEMREF_WINDOWS[index] = windowInfo;

	this.index = index;
end


function IRR_ItemRefTooltip_OnClick(index,isCompFrame)
	local itemFrame;
	local masterButton = 0;

	if (IsShiftKeyDown() == 1) then
		IRR_CloseAllWindows();
	else
		if (isCompFrame == nil) then
			itemFrame = getglobal("IRR_ItemRefTooltip"..index);
			
			IR_MOD_ITEMREF_WINDOWS[index].state = 0;
			IR_MOD_ITEMREF_WINDOWS[index].link = 0;
			IR_MOD_ITEMREF_WINDOWS[index].firstTimeAuc = 1;

			HideUIPanel(itemFrame);
			masterButton = 1;

			IR_MOD_ITEMREF_WINDOWS[index].minimized = nil;
		end

		if (index <= 10 or masterButton == 1) then
			local compFrame = getglobal("IRR_ItemCompTooltip"..index);
			IR_MOD_ITEMREF_WINDOWS[index].compare = 0;
			HideUIPanel(compFrame);
		end

		if (masterButton == 1) then
			index = index + 10;
		end

		if (index > 10) then
			local compFrame = getglobal("IRR_ItemCompTool"..index);
			HideUIPanel(compFrame);

			IR_MOD_ITEMREF_WINDOWS[index-10].compare = 0;
		end

		GameTooltip:Hide();
	end
end


function IRR_SetWindowHeight(itemRef)
	if (IR_MOD_ITEMREF_WINDOWS[itemRef.index].minimized ~= nil) then
		itemRef:SetHeight(37);
	else
		if (IR_MOD_ITEMREF_WINDOWS[itemRef.index].originalHeight) then
			itemRef:SetHeight(IR_MOD_ITEMREF_WINDOWS[itemRef.index].originalHeight);
		end
	end
end

function IRR_SetWindowWidth()
	if (AUCTIONEER_VERSION ~= nil or ENCHANTRIX_VERSION ~= nil) then
		local itemRefFrame = IR_MOD_ITEMREF_WINDOWS[IR_MOD_AUCTIONEER_INDEX].window;

		local fWidth = itemRefFrame:GetWidth();
		local aWidth = EnhancedTooltip:GetWidth();

		if (EnhancedTooltip:GetLeft() == IR_MOD_AUCTIONEER_POS) then
			if (fWidth > aWidth) then
				EnhancedTooltip:SetWidth(fWidth);
			else
				itemRefFrame:SetWidth(aWidth);
			end
		end
	end
end

function IRR_DoTooltipUpdate(elapse)
	IRR_SetWindowHeight(this);
	IRR_SetWindowWidth();
end

function IRR_BetterShiftClick(link,text,button,osir)
	local iiName,iiLink,iiRarity,_,iiType,_,_,iiEquip = GetItemInfo(link);

	if (not iiRarity) then
		--dout("Original");
		osir(link,text,button);
		return; end
	
	local textLink = IRR_LINK_COLOR_OPEN;
	textLink = textLink..IRR_LINK_COLORS[iiRarity];
	textLink = textLink..IRR_LINK_HYPERLINK_OPEN;
	textLink = textLink..link;
	textLink = textLink..IRR_LINK_LINK_OPEN;
	textLink = textLink..iiName;
	textLink = textLink..IRR_LINK_LINK_CLOSE;
	textLink = textLink..IRR_LINK_COLOR_CLOSE;

	--dout("link: "..textLink);

	if (textLink ~= nil) then
		if ( not ChatFrameEditBox:IsVisible() ) then
			ChatFrame_OpenChat(textLink);
		else
			ChatFrameEditBox:SetText(ChatFrameEditBox:GetText()..textLink);
		end
	end
end

function IRR_DoTooltipShow(index)
	local itemRef = this;

	--IRR_SetWindowHeight(itemRef);
		
	local iiName,iiLink,iiRarity,_,iiType,_,_,iiEquip = GetItemInfo(IR_MOD_ITEMREF_WINDOWS[index].itemRefID);
	IR_MOD_AUCTIONEER_INDEX = index;		-- Make the tooltip index available to other mods.

	IR_MOD_ITEMREF_WINDOWS[index].name = iiName;
	IR_MOD_ITEMREF_WINDOWS[index].quality = iiRarity;

		-- Set the whisper/link stuff
	IRR_SetWhisperPlayerAndLink(index,"IRR_ItemRefTooltip"..index);
	
	local slots = IRR_GetCompareItemIndex("IRR_ItemRefTooltip"..index);

	local compButton = getglobal("ItemRefCompButton"..index);
	local DRButton = getglobal("ItemRefDRButton"..index);
			
	if (slots == nil) then
		--HideUIPanel(compButton);
		--HideUIPanel(whisperButton);
		IR_MOD_ITEMREF_WINDOWS[index].slots = nil;
		slots = {};
		--dout("NOT an equippable item...");
	end
	
	local empty = 1;
	
	for i=1,table.getn(slots) do
		local check = GetInventoryItemLink("player", slots[i]);

		if (check ~= nil) then
			empty = 0;
			--do break end;
		end
		
		--dout(check);
		IR_MOD_ITEMREF_WINDOWS[index].compareLinks[i] = check;
	end

	if (empty == 1 or slots == nil) then
		compButton:SetButtonState("DISABLED");
		if (empty == 1) then
			--dout("No equipped item...");
		end
	else
		compButton:SetButtonState("NORMAL");
		IR_MOD_ITEMREF_WINDOWS[index].slots = slots;
	end

	--dout(iiType.."*");
	if (iiType == IRR_ARMOR or iiType == IRR_WEAPON) then
		DRButton:SetButtonState("NORMAL");
	else
		--dout("disabling DR");
		DRButton:SetButtonState("DISABLED");
	end

	IR_MOD_ITEMREF_WINDOWS[index].minimized = 1;
	IRR_DoMinimize(index);

	-- Auctioneer
	IR_MOD_ITEMREF_WINDOWS[index].firstTimeAuc = 1;
	IRR_DoAuctioneerFrame(index);
		
	table.foreach(LINK_WRANGLER_CALLER, function(k,v) LinkWrangler_AddonContent(v,k,index); end);
		
	return;
end

function IRR_SizeChanged(index)
	if (IR_MOD_ITEMREF_WINDOWS[index].minimized == nil) then
		--dout("size changed");
		IR_MOD_ITEMREF_WINDOWS[index].originalHeight = this:GetHeight();

		if (this:GetHeight() < IRR_MIN_HEIGHT) then
			IR_MOD_ITEMREF_WINDOWS[index].originalHeight = IRR_MIN_HEIGHT;
		end
	end
end

-------------------------------------------------------------------------------------------
-- Hook functions
-------------------------------------------------------------------------------------------
local originalSetItemRef;
originalSetItemRef = SetItemRef;
function SetItemRef(link, text, button)
	--IRR_DecryptLink(link);
	--dout("link: "..link)

	if (IsControlKeyDown()) then
		originalSetItemRef(link,text,button);
		return;
	end
	
	if ( strsub(link, 1, 4) == "item" ) then
		if (IsShiftKeyDown()) then
			IRR_BetterShiftClick(link,text,button,originalSetItemRef);
			return; end
		
		local index = IRR_GetWindowIndex(link);
		
		if (index == 0) then -- ignore
			--dout("index is 0.  Returning...?");
			return;
		end

		local itemRef = IR_MOD_ITEMREF_WINDOWS[index].window;
		
		IR_MOD_ITEMREF_WINDOWS[index].itemRefID = link;
		--IR_MOD_ITEMREF_WINDOWS[index].itemID = IRR_GetItemID(link);
			
		ShowUIPanel(itemRef);
		if ( not itemRef:IsVisible() ) then
			itemRef:SetOwner(UIParent, "ANCHOR_PRESERVE");
		end

		IRR_ClearAllFields(index);
		itemRef:SetHyperlink(link);
		
		if (ChatBox_Names) then
			--originalSetItemRef(link,text,button);
		end
	else
		-- Call original if not handled above
		originalSetItemRef(link,text,button);
		--dout("using original");		
	end
end