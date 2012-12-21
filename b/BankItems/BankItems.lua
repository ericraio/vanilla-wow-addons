--[[****************************************************************
	BankItems v10900

	Author: wow.jaslaughter.com
	****************************************************************
	Description:
		Type /bi or /bankitems to see what is currently in your
		bank.  You must visit your bank one time to initialize.

	Credits:
		Original concept from Merphle
		I look for SellValue data for the list, an addon originally
		by Sarf.  I use the version from CapnBry at http://capnbry.net/wow

	Official Site:
		wow.jaslaughter.com
	
	BankItems-10900
	****************************************************************]]

BINDING_HEADER_BANKITEMS = "BankItems Bindings";
BINDING_NAME_TOGGLEBANKITEMS = "Toggle BankItems";
BINDING_NAME_TOGGLEBANKITEMSALL = "Toggle BankItems and all Bags";
BINDING_NAME_RESETFRAMEPOS = "Reset BankItems positions";
BANKITEMS_VERSIONTEXT = "BankItems v10900";

BankItems_Save = {};
local loaded = nil;
local bankPlayer = nil;
local bankPlayerName = nil;
local allRealms = 0;
local allBags = 0;
local CONTAINER_FRAME_TABLE = {
	[0] = {"Interface\\ContainerFrame\\UI-BackpackBackground", 256, 256, 239},
	[1] = {"Interface\\ContainerFrame\\UI-Bag-1x4", 256, 128, 96},
	[2] = {"Interface\\ContainerFrame\\UI-Bag-1x4", 256, 128, 96},
	[3] = {"Interface\\ContainerFrame\\UI-Bag-1x4", 256, 128, 96},
	[4] = {"Interface\\ContainerFrame\\UI-Bag-1x4", 256, 128, 96},
	[5] = {"Interface\\ContainerFrame\\UI-Bag-1x4+2", 256, 128, 116},
	[6] = {"Interface\\ContainerFrame\\UI-Bag-1x4+2", 256, 128, 116},
	[7] = {"Interface\\ContainerFrame\\UI-Bag-1x4+2", 256, 128, 116},
	[8] = {"Interface\\ContainerFrame\\UI-Bag-2x4", 256, 256, 137},
	[9] = {"Interface\\ContainerFrame\\UI-Bag-2x4+2", 256, 256, 157},
	[10] = {"Interface\\ContainerFrame\\UI-Bag-2x4+2", 256, 256, 157},
	[11] = {"Interface\\ContainerFrame\\UI-Bag-2x4+2", 256, 256, 157},
	[12] = {"Interface\\ContainerFrame\\UI-Bag-3x4", 256, 256, 178},
	[13] = {"Interface\\ContainerFrame\\UI-Bag-3x4+2", 256, 256, 198},
	[14] = {"Interface\\ContainerFrame\\UI-Bag-3x4+2", 256, 256, 198},
	[15] = {"Interface\\ContainerFrame\\UI-Bag-3x4+2", 256, 256, 198},
	[16] = {"Interface\\ContainerFrame\\UI-Bag-4x4", 256, 256, 219},
	[18] = {"Interface\\ContainerFrame\\UI-Bag-4x4+2", 256, 256, 239},
	[20] = {"Interface\\ContainerFrame\\UI-Bag-5x4", 256, 256, 259},
};

function BankItems_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");

	this:RegisterEvent("BANKFRAME_OPENED");
	this:RegisterEvent("PLAYERBANKSLOTS_CHANGED");
	this:RegisterEvent("PLAYERBANKBAGSLOTS_CHANGED");
	this:RegisterEvent("BAG_UPDATE");

	this:RegisterEvent("PLAYER_MONEY");

	SlashCmdList["BANKITEMS"] = function(msg) BankItems_SlashHandler(msg) end;
	SLASH_BANKITEMS1 = "/bankitems";
	SLASH_BANKITEMS2 = "/bi";

	tinsert(UISpecialFrames,"BankItems_Frame");
end

function BankItems_OnEvent(event)
	if ( event == "VARIABLES_LOADED" ) then
		loaded = 1;
	end
	if ( not loaded ) then
		return;
	end
	if ( bankPlayer == nil ) then
		bankPlayer = BankItems_GetPlayer(UnitName("player").."|"..BankItems_Trim(GetCVar("realmName")));
		BankItems_SaveMoney();
		return;
	end
	if ( event == "BANKFRAME_OPENED" or event == "PLAYERBANKSLOTS_CHANGED" or event == "PLAYERBANKBAGSLOTS_CHANGED" ) then
		BankItems_SaveItems();
		return;
	end
	if ( event == "BAG_UPDATE" and BankFrame:IsVisible() ) then
		BankItems_SaveItems();
		if ( tonumber(arg1) and tonumber(arg1) > 4 and tonumber(arg1) <= 10 ) then
			BankItems_PopulateBag(arg1);
		end
		return;
	end
	if ( event == "PLAYER_MONEY" ) then
		BankItems_SaveMoney();
		return;
	end
end

function BankItems_Frame_OnShow()
	PlaySound("igMainMenuOpen");
	if ( not BankItems_Frame.hasShown ) then
		BankItems_Frame.hasShown = 1;
		SetPortraitTexture(BankItems_Portrait, "player");
		BankItems_TotalMoneyText:ClearAllPoints();
		BankItems_TotalMoneyText:SetPoint("LEFT","BankItems_MoneyFrameTotalCopperButton","RIGHT",0,0);
	end
	BankItems_SaveMoney();
end

function BankItems_Frame_OnHide()
	for bagNum = 1, 6 do
		getglobal("BankItems_ContainerFrame"..bagNum):Hide();
	end
end

function BankItems_GetPlayer(playerName)
	if ( not BankItems_Save[playerName] or (not BankItems_Save[playerName].money and table.getn(BankItems_Save[playerName]) == 0) ) then
		BankItems_Save[playerName] = {};
	end
	BankItems_TitleText:SetText(BankItems_Split(playerName,"|")[1].." of "..BankItems_Split(playerName,"|")[2]);
	bankPlayerName = playerName;
	if ( playerName == UnitName("player").."|"..BankItems_Trim(GetCVar("realmName")) ) then
		SetPortraitTexture(BankItems_Portrait, "player");
	else
		BankItems_Portrait:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon");
	end
	return BankItems_Save[playerName];
end

function BankItems_SlashHandler(msg)
	if ( msg and strlen(msg) > 0 ) then
		msg = strlower(msg);
	end
	if ( not msg ) then
		msg = "";
	end
	if ( msg == "list" ) then
		BankItems_ListAll();
		return;
	end
	if ( msg == "resetpos" ) then
		BankItems_ResetPos();
		return;
	end
	if ( msg == "clear" ) then
		local selected = BankItems_UserDropdown_GetValue();
		if ( BankItems_Save[selected] ) then
			BankItems_Save[selected] = nil;
		end
		bankPlayer = BankItems_GetPlayer(UnitName("player").."|"..BankItems_Trim(GetCVar("realmName")));
		if ( BankFrame:IsVisible() ) then
			BankItems_SaveItems();
		end
		BankItems_SaveMoney();

		BankItems_Frame:Hide();
	end
	if ( msg == "clearall" ) then
		BankItems_Save = {};
		bankPlayer = BankItems_GetPlayer(UnitName("player").."|"..BankItems_Trim(GetCVar("realmName")));
		if ( BankFrame:IsVisible() ) then
			BankItems_SaveItems();
		end
		BankItems_SaveMoney();

		BankItems_Frame:Hide();
	end
	if ( msg == "help" ) then
		BankItems_Chat(BANKITEMS_VERSIONTEXT);
		BankItems_Chat("Type /bi or /bankitems to open BankItems");
		BankItems_Chat("-- /bi all : open BankItems and all bags");
		BankItems_Chat("-- /bi list : list contents in chat");
		BankItems_Chat("-- /bi clear : clear currently selected player's info");
		BankItems_Chat("-- /bi clearall : clear all players' info");
		BankItems_Chat("-- /bi resetpos : reset BankItems and bags position");
		return;
	end
	if ( msg == "allrealms" ) then
		if ( allRealms == 0 ) then
			allRealms = 1;
		else
			allRealms = 0;
		end
	end
	BankItems_PopulateFrame();

	if ( BankItems_Frame:IsVisible() ) then
		BankItems_Frame:Hide();
	else
		BankItems_Frame:Show();
		if ( msg == "all" ) then
			allBags = 1;
			for num = 1, 6 do
				getglobal("BankItems_ContainerFrame"..num):Hide();
				BankItems_Bag_OnClick(num + 4);
			end
		else
			allBags = 0;
		end
	end
end

function BankItems_ResetPos()
	BankItems_Frame:ClearAllPoints();
	BankItems_Frame:SetPoint("TOPLEFT","UIParent","TOPLEFT",50,-104);

	BankItems_ContainerFrame1:ClearAllPoints();
	BankItems_ContainerFrame1:SetPoint("TOPLEFT","BankItems_Frame","TOPRIGHT",0,-260);

	BankItems_ContainerFrame2:ClearAllPoints();
	BankItems_ContainerFrame2:SetPoint("TOPLEFT","BankItems_Frame","TOPRIGHT",0,0);

	BankItems_ContainerFrame3:ClearAllPoints();
	BankItems_ContainerFrame3:SetPoint("TOPLEFT","BankItems_Frame","TOPRIGHT",0,-520);

	BankItems_ContainerFrame4:ClearAllPoints();
	BankItems_ContainerFrame4:SetPoint("TOPLEFT","BankItems_Frame","TOPRIGHT",256,0);

	BankItems_ContainerFrame5:ClearAllPoints();
	BankItems_ContainerFrame5:SetPoint("TOPLEFT","BankItems_Frame","TOPRIGHT",256,-260);

	BankItems_ContainerFrame6:ClearAllPoints();
	BankItems_ContainerFrame6:SetPoint("TOPLEFT","BankItems_Frame","TOPRIGHT",256,-520);
end

function BankItems_SaveMoney()
	if ( UnitName("player") and BankItems_Trim(GetCVar("realmName")) ) then
		if ( BankItems_Save[UnitName("player").."|"..BankItems_Trim(GetCVar("realmName"))] ) then
			BankItems_Save[UnitName("player").."|"..BankItems_Trim(GetCVar("realmName"))]["money"] = GetMoney();
		end
		if ( BankItems_MoneyFrame:IsVisible() ) then
			MoneyFrame_Update("BankItems_MoneyFrame", bankPlayer.money);
		end
	end
end

function BankItems_UpdateTotalMoney()
	BankItems_SaveMoney();
	local totalMula = 0;

	if ( allRealms == 1 ) then
		for key, value in BankItems_Save do
			if ( BankItems_Save[key].money ) then
				totalMula = totalMula + BankItems_Save[key].money;
			end
		end
	else
		for key, value in BankItems_Save do
			local thisRealmPlayers = BankItems_Split(key, "|")[2];
			if ( thisRealmPlayers == BankItems_Trim(GetCVar("realmName")) and (table.getn(BankItems_Save[key]) > 0 or BankItems_Save[key].money) ) then
				if ( BankItems_Save[key].money ) then
					totalMula = totalMula + BankItems_Save[key].money;
				end
			end
		end
	end
	MoneyFrame_Update("BankItems_MoneyFrameTotal", totalMula);
end

function BankItems_SaveItems()
	local itemLink,icon,quantity,bagNum_Slots;
	local currPlayer = BankItems_Save[UnitName("player").."|"..BankItems_Trim(GetCVar("realmName"))];
	if ( BankFrame:IsVisible() ) then
		for num = 1, 24 do
			itemLink = GetContainerItemLink(BANK_CONTAINER, num);
			icon, quantity = GetContainerItemInfo(BANK_CONTAINER, num);
			if ( itemLink ) then
				currPlayer[num] = {
					["icon"] = icon,
					["count"] = quantity,
					["link"] = itemLink
				};
			else
				currPlayer[num] = nil;
			end
		end
		for bagNum = 5, 10 do
			bagNum_Slots = GetContainerNumSlots(bagNum);
			bagNum_ID = BankButtonIDToInvSlotID(bagNum, 1);
			itemLink = GetInventoryItemLink("player", bagNum_ID);
			icon = GetInventoryItemTexture("player", bagNum_ID);

			if ( icon ) then
				currPlayer["Bag"..bagNum] = {
					["link"] = itemLink,
					["icon"] = icon,
					["size"] = bagNum_Slots
				};
			else
				currPlayer["Bag"..bagNum] = nil;
				getglobal("BankItems_ContainerFrame"..(bagNum - 4)):Hide();
				break;
			end

			itemLink = nil;

			for bagItem = 1, bagNum_Slots do
				itemLink = GetContainerItemLink(bagNum, bagItem);
				icon, quantity = GetContainerItemInfo(bagNum, bagItem);
				if ( itemLink ) then
					currPlayer["Bag"..bagNum][bagItem] = {
						["link"] = itemLink,
						["icon"] = icon,
						["count"] = quantity
					};
				else
					currPlayer["Bag"..bagNum][bagItem] = nil;
				end
			end
		end
	end
	BankItems_SaveMoney();
	if ( BankItems_Frame:IsVisible() ) then
		BankItems_PopulateFrame();
	end
	currPlayer = nil;
end

function BankItems_ListAll()
	local sellValue;
	if ( bankPlayer ) then
		for num = 1, 24 do
			if ( bankPlayer[num] and bankPlayer[num].link ) then
				if ( sellValues ) then
					sellValue = BankItem_ParseMoney(SellValues[BankItems_ParseLink(bankPlayer[num].link)]);
				elseif ( ItemLinks ) then
					sellValue = BankItem_ParseMoney(ItemLinks[BankItems_ParseLink(bankPlayer[num].link)].p);
				end
				if ( sellValue ) then
					BankItems_Chat("Item "..num..": "..bankPlayer[num].link.." x"..bankPlayer[num].count.." (Sells for "..sellValue.." each)");
				else
					BankItems_Chat("Item "..num..": "..bankPlayer[num].link.." x"..bankPlayer[num].count);
				end
			end
		end
		for bagNum = 5, 10 do
			if ( bankPlayer["Bag"..bagNum] and bankPlayer["Bag"..bagNum].size > 0 ) then
				for bagItem = 1, bankPlayer["Bag"..bagNum].size do
					if ( bankPlayer["Bag"..bagNum][bagItem] and bankPlayer["Bag"..bagNum][bagItem].link ) then
						if ( sellValues ) then
							sellValue = BankItem_ParseMoney(SellValues[BankItems_ParseLink(bankPlayer["Bag"..bagNum][bagItem].link)]);
						elseif ( ItemLinks ) then
							sellValue = BankItem_ParseMoney(ItemLinks[BankItems_ParseLink(bankPlayer["Bag"..bagNum][bagItem].link)].p);
						end
						if ( sellValue ) then
							BankItems_Chat("Bag "..(bagNum - 4).." Item "..bagItem..": "..bankPlayer["Bag"..bagNum][bagItem].link.." x"..bankPlayer["Bag"..bagNum][bagItem].count.." (Sells for "..sellValue.." each)");
						else
							BankItems_Chat("Bag "..(bagNum - 4).." Item "..bagItem..": "..bankPlayer["Bag"..bagNum][bagItem].link.." x"..bankPlayer["Bag"..bagNum][bagItem].count);
						end
					end
				end
			end
		end
	end
end

function BankItems_PopulateFrame()
	local texture,button;
	if ( bankPlayer ) then
		for num = 1, 24 do
			button = getglobal("BankItems_Item"..num);
			texture = getglobal("BankItems_Item"..num.."IconTexture");
			if ( bankPlayer[num] ) then
				texture:SetTexture(bankPlayer[num].icon);
				SetItemButtonCount(button,bankPlayer[num].count);
			else
				texture:SetTexture("");
				SetItemButtonCount(getglobal("BankItems_Item"..num),nil);
			end
		end
		for bagNum = 5, 10 do
			button = getglobal("BankItems_Bag"..(bagNum - 4));
			texture = getglobal(button:GetName().."IconTexture");
			if ( bankPlayer["Bag"..bagNum] and bankPlayer["Bag"..bagNum].icon ) then
				texture:SetTexture(bankPlayer["Bag"..bagNum].icon);
				SetItemButtonTextureVertexColor(button, 1.0,1.0,1.0);
			else
				texture:SetTexture("Interface\\PaperDoll\\UI-PaperDoll-Slot-Bag");
				SetItemButtonTextureVertexColor(button, 1.0,0.1,0.1);
			end
			button:Show();
		end
		if ( bankPlayer.money ) then
			MoneyFrame_Update("BankItems_MoneyFrame", bankPlayer.money);
			BankItems_MoneyFrame:Show();
		else
			BankItems_MoneyFrame:Hide();
		end
	end
	BankItems_UpdateTotalMoney();
end

function BankItems_Button_OnEnter()
	if ( not bankPlayer[this:GetID()] ) then
		return;
	end

	local myLink = bankPlayer[this:GetID()].link;
	if ( myLink and strlen(myLink) > 0 ) then
		GameTooltip:SetOwner(this,"ANCHOR_RIGHT");
		_,_,myLink = strfind(myLink,"|H(item:%d+:%d+:%d+:%d+)|");
		GameTooltip:SetHyperlink(myLink);
	end
end

function BankItems_BagItem_OnEnter()
	local bagID = "Bag"..this:GetParent():GetID();
	if ( not bankPlayer[bagID].link ) then
		return;
	end
	local itemID = bankPlayer[bagID].size - ( this:GetID() - 1 );
	if ( bankPlayer[bagID][itemID] ) then
		local myLink = bankPlayer[bagID][itemID].link;
		if ( myLink and strlen(myLink) > 0 ) then
			GameTooltip:SetOwner(this,"ANCHOR_RIGHT");
			_,_,myLink = strfind(myLink,"|H(item:%d+:%d+:%d+:%d+)|");
			GameTooltip:SetHyperlink(myLink);
		end
	end
end

function BankItems_Button_OnClick(arg1)
	if ( bankPlayer[this:GetID()] ) then
		if ( IsControlKeyDown() ) then
			DressUpItemLink(bankPlayer[this:GetID()].link);
		elseif ( arg1 == "LeftButton" and ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:Insert(bankPlayer[this:GetID()].link);
		end
	end
end

function BankItems_BagItem_OnClick(arg1)
	local bagID = "Bag"..this:GetParent():GetID();
	local itemID = bankPlayer[bagID].size - ( this:GetID() - 1 );
	if ( bankPlayer[bagID][itemID] ) then
		if ( IsControlKeyDown() ) then
			DressUpItemLink(bankPlayer[bagID][itemID].link);
		elseif ( arg1 == "LeftButton" and ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:Insert(bankPlayer[bagID][itemID].link);
		end
	end
end

function BankItems_Bag_OnEnter()
	if ( bankPlayer["Bag"..this:GetID()] and bankPlayer["Bag"..this:GetID()].link ) then
		local myLink = bankPlayer["Bag"..this:GetID()].link;
		if ( myLink and strlen(myLink) > 0 ) then
			GameTooltip:SetOwner(this,"ANCHOR_RIGHT");
			_,_,myLink = strfind(myLink,"|H(item:%d+:%d+:%d+:%d+)|");
			GameTooltip:SetHyperlink(myLink);
		end
	end
end

function BankItems_Bag_OnClick(bagID)
	if ( not bankPlayer["Bag"..bagID] or not bankPlayer["Bag"..bagID].link ) then
		return;
	end
	if ( bankPlayer["Bag"..bagID].size == 0 ) then
		if ( GetContainerNumSlots(bagID) > 0 and BankFrame:IsVisible() ) then
			BankItems_SaveItems();
		else
			BankItems_Chat("Bank bag is empty, and not initialized.");
			return;
		end
	end
	local theBag = bankPlayer["Bag"..bagID];
	local bagFrame = getglobal("BankItems_ContainerFrame"..(bagID - 4));
	local bagName = bagFrame:GetName();

	if ( bagFrame:IsVisible() ) then
		bagFrame:Hide();
		return;
	end

	getglobal(bagName.."Name"):SetText(BankItems_ParseLink(theBag.link));
	getglobal(bagName.."Portrait"):SetTexture(theBag.icon);

	-- Generate the frame
	local frameSettings = CONTAINER_FRAME_TABLE[theBag.size];
	local frameBG = getglobal(bagName.."BackgroundTexture");
	local columns = NUM_CONTAINER_COLUMNS;
	local rows = ceil(theBag.size / columns);
	local button,item,idx;

	bagFrame:SetWidth(CONTAINER_WIDTH);
	bagFrame:SetHeight(frameSettings[4]);
	frameBG:SetTexture(frameSettings[1]);
	frameBG:SetWidth(frameSettings[2]);
	frameBG:SetHeight(frameSettings[3]);

	for bagItem = 1, theBag.size do
		idx = theBag.size - (bagItem - 1);
		item = theBag[idx];
		button = getglobal(bagName.."Item"..bagItem);

		if ( bagItem == 1 ) then
			button:SetPoint("BOTTOMRIGHT", bagName, "BOTTOMRIGHT", -11, 9);
		else
			if ( mod((bagItem-1), columns) == 0 ) then
				button:SetPoint("BOTTOMRIGHT", bagName.."Item"..(bagItem - columns), "TOPRIGHT", 0, 4);	
			else
				button:SetPoint("BOTTOMRIGHT", bagName.."Item"..(bagItem - 1), "BOTTOMLEFT", -5, 0);	
			end
		end
		button:Show();
	end
	for bagItem = theBag.size + 1, 20 do
		getglobal(bagName.."Item"..bagItem):Hide();
	end
	BankItems_PopulateBag(bagID);
	bagFrame:Show();
	PlaySound("igBackPackOpen");
end

function BankItems_PopulateBag(bagID)
	local item,theBag,idx;
	if ( bankPlayer["Bag"..bagID].size ) then
		theBag = bankPlayer["Bag"..bagID];
		for bagItem = 1, theBag.size do
			idx = theBag.size - (bagItem - 1);
			item = theBag[idx];
			button = getglobal("BankItems_ContainerFrame"..(bagID - 4).."Item"..bagItem);

			if ( item ) then
				SetItemButtonTexture(button, item.icon);
				SetItemButtonCount(button, item.count);
			else
				SetItemButtonTexture(button,"");
				SetItemButtonCount(button, nil);
			end
		end
	end
end

function BankItems_Bag_OnShow()
	getglobal("BankItems_Bag"..(this:GetID() - 4).."HighlightFrameTexture"):Show();
end

function BankItems_Bag_OnHide()
	getglobal("BankItems_Bag"..(this:GetID() - 4).."HighlightFrameTexture"):Hide();
end

function BankItems_ParseLink(link)
	if (string.find(link, "[", 1, true)) then
		local _,_,name = string.find(link, "^.*%[(.*)%].*$");
		return name;
	else
		return link;
	end
end

function BankItems_Chat(msg)
	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("<BankItems> "..msg, 1.0, 1.0, 0.0);
	end
end

function BankItem_ParseMoney(money)
	local disp = "";
	if ( money ) then
		local g,s,c;
		g = math.floor(money / 10000);
		money = math.mod(money,10000);
		s = math.floor(money / 100);
		money = math.mod(money,100);
		c = math.mod(money, 100);
		if ( g and g > 0 ) then
			disp = g.."g ";
		end
		if ( s and s > 0 ) then
			disp = disp..s.."s ";
		end
		if ( c and c > 0) then
			disp = disp..c.."c";
		end
		if ( strlen(disp) > 0 ) then
			return disp;
		else
			return nil;
		end
	else
		return nil;
	end
end

function BankItems_UserDropdown_GetValue()
	if ( bankPlayerName ) then
		return bankPlayerName;
	else
		return (UnitName("player").."|"..BankItems_Trim(GetCVar("realmName")));
	end
end

function BankItems_UserDropdown_OnLoad()
	UIDropDownMenu_Initialize(this, BankItems_UserDropdown_Initialize);
	UIDropDownMenu_SetSelectedValue(this, BankItems_UserDropdown_GetValue());
	BankItems_UserDropdown.tooltip = "You are viewing this player's bank contents.";
	UIDropDownMenu_SetWidth(140, BankItems_UserDropdown);
	OptionsFrame_EnableDropDown(BankItems_UserDropdown);
end

function BankItems_UserDropdown_OnClick()
	if ( not bankPlayer ) then
		return;
	end
	UIDropDownMenu_SetSelectedValue(BankItems_UserDropdown, this.value);
	if ( this.value ) then
		bankPlayer = BankItems_GetPlayer(this.value);
	end
	BankItems_Frame_OnHide();
	BankItems_PopulateFrame();

	if ( allBags == 1 ) then
		for num = 1, 6 do
			getglobal("BankItems_ContainerFrame"..num):Hide();
			BankItems_Bag_OnClick(num + 4);
		end
	end
end

function BankItems_UserDropdown_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(BankItems_UserDropdown);
	local info;

	if ( allRealms == 1 ) then
		for key, value in BankItems_Save do
			if ( table.getn(BankItems_Save[key]) > 0 or BankItems_Save[key].money ) then
				info = {};
				info.text = BankItems_Split(key,"|")[1].." of "..BankItems_Split(key,"|")[2];
				info.value = key;
				info.func = BankItems_UserDropdown_OnClick;
				if ( selectedValue == info.value ) then
					info.checked = 1;
				else
					info.checked = nil;
				end
				UIDropDownMenu_AddButton(info);
			end
		end
	else
		for key, value in BankItems_Save do
			local thisRealmPlayers = BankItems_Split(key, "|")[2];
			if ( thisRealmPlayers == BankItems_Trim(GetCVar("realmName")) and (table.getn(BankItems_Save[key]) > 0 or BankItems_Save[key].money) ) then
				info = {};
				info.text = BankItems_Split(key,"|")[1].." of "..BankItems_Split(key,"|")[2];
				info.value = key;
				info.func = BankItems_UserDropdown_OnClick;
				if ( selectedValue == info.value ) then
					info.checked = 1;
				else
					info.checked = nil;
				end
				UIDropDownMenu_AddButton(info);
			end
		end
	end
end

function BankItems_Split(toCut, separator)
	local splitted = {};
	local i = 0;
	local regEx = "([^" .. separator .. "]*)" .. separator .. "?";

	for item in string.gfind(toCut .. separator, regEx) do
		i = i + 1;
		splitted[i] = BankItems_Trim(item) or '';
	end
	if ( splitted[i] == '' ) then
		splitted[i] = nil;
	end
	return splitted;
end

function BankItems_Trim (s)
	return (string.gsub(s, "^%s*(.-)%s*$", "%1"));
end

function BankItems_ShowAllRealms_CheckOnClick()
	if ( BankItems_Frame:IsVisible() ) then
		BankItems_Frame:Hide();
	end
	BankItems_SlashHandler("allrealms");
end

function BankItems_ShowAllRealms_CheckOnLoad()
	if ( allRealms == 1 ) then
		this.checked = 1;
	else
		this.checked = nil;
	end
	OptionsFrame_EnableCheckBox(this);
	this:SetChecked(this.checked);
	getglobal(this:GetName().."Text"):SetText("Show All Realms");
	this.tooltipText = "Check to show all saved characters, regardless of realm.";
end
