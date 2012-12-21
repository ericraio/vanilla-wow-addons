IMA_Settings = {};

local IMA_NUMITEMBUTTONS = 18;
local IMA_Playername = nil;
local IMA_AuctionFrameTab_OnClickOrig = nil;
local IMA_PickupContainerItemOrig = nil;
local IMA_ContainerFrame_UpdateOrig = nil;

function IMA_PickupContainerItem(bag, item)
	-- pass through if auction window not open or item already in
	if ( not AuctionFrame:IsVisible() ) then
		IMA_PickupContainerItemOrig(bag, item);
		return;
	end

	if ( IMA_GetItemFrame(bag, item) ) then
		return;
	end
	
	if ( not CursorHasItem() ) then
		IMA_ClearAuctionSellItem();
		IMA_AuctionFrameMassAuction.bag = bag;
		IMA_AuctionFrameMassAuction.item = item;
	end
	if ( IsAltKeyDown() and IMA_AuctionFrameMassAuction:IsVisible() and not CursorHasItem() ) then
		IMA_ClearAuctionSellItem();
		local i;
		for i = 1, IMA_NUMITEMBUTTONS, 1 do
			if ( not getglobal("IMA_Item"..i.."ItemButton").item ) then
				IMA_PickupContainerItemOrig(bag, item);
				IMA_ItemButton_OnClick(getglobal("IMA_Item"..i.."ItemButton"));
				IMA_UpdateItemButtons();
				return;
			end
		end
	elseif ( IsAltKeyDown() and not CursorHasItem() ) then
		IMA_ClearAuctionSellItem();
		IMA_PickupContainerItemOrig(bag, item);
		ClickAuctionSellItemButton();
		return;
	end
	IMA_PickupContainerItemOrig(bag, item);
	IMA_UpdateItemButtons();
end

-- Controls the 4th tab in AuctionFrame
function IMA_AuctionFrameTab_OnClick(index)
	-- no Sea req
	if ( IMA_AuctionFrameTab_OnClickOrig ~= nil ) then
		IMA_AuctionFrameTab_OnClickOrig(index);
	end
	
	if ( not index ) then 
		index = this:GetID();
	end
	
	if ( index == 4 ) then
		-- MassAuction tab
		AuctionFrameTopLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-TopLeft");
		AuctionFrameTop:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-Top");
		AuctionFrameTopRight:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-TopRight");
		AuctionFrameBotLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-BotLeft");
		AuctionFrameBot:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-Bot");
		AuctionFrameBotRight:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-BotRight");

		-- this is to fix a bug where the AuctionsFrame can't handle having auctions added without it showing first
		if (AuctionFrameAuctions.page == nil) then
			AuctionFrameAuctions.page = 0;
		end

		IMA_AuctionFrameMassAuction:Show();	
	else
		IMA_AuctionFrameMassAuction:Hide();
	end
end

function IMA_ContainerFrame_Update(frame)
	if ( IMA_ContainerFrame_UpdateOrig ~= nil ) then
		IMA_ContainerFrame_UpdateOrig(frame)
	end

	if ( not IMA_AuctionFrameMassAuction:IsVisible() ) then
		return;
	end

	local id = frame:GetID();
	local i;
	for i = 1, IMA_NUMITEMBUTTONS, 1 do
		local btn = getglobal("IMA_Item"..i.."ItemButton");
		if ( btn.item and btn.bag ) then
			if ( btn.bag == frame:GetID() ) then
				SetItemButtonDesaturated(getglobal(frame:GetName() .. "Item" .. (frame.size-btn.item)+1), 1, 0.5, 0.5, 0.5);
			end
		end
	end
end

function IMA_AuctionFrameMassAuction_OnLoad()
	-- Igors Mass Auction makes some hooks
	--	  AuctionFrameTab_OnClick - lets us access our 4th tab
	--	  PickupContainerItem - grabs something from a bag with the mouse
	IMA_PickupContainerItemOrig = PickupContainerItem
	if ( Sea ~= nil and Sea.util ~= nil and Sea.util.hook ~= nil ) then
		Sea.util.hook("AuctionFrameTab_OnClick","IMA_AuctionFrameTab_OnClick","after");
		Sea.util.hook("PickupContainerItem","IMA_PickupContainerItem","replace");
		Sea.util.hook("ContainerFrame_Update","IMA_ContainerFrame_Update","after");
	else
		-- no Sea req code
		IMA_AuctionFrameTab_OnClickOrig = AuctionFrameTab_OnClick;
		AuctionFrameTab_OnClick = IMA_AuctionFrameTab_OnClick;
		PickupContainerItem = IMA_PickupContainerItem;
		IMA_ContainerFrame_UpdateOrig = ContainerFrame_Update;
		ContainerFrame_Update = IMA_ContainerFrame_Update;
	end
	
	for i = 1, IMA_NUMITEMBUTTONS, 1 do
		IMA_AuctionsRadioButton_OnClick(i,3);
	end

	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("AUCTION_HOUSE_CLOSED");
end

function IMA_AuctionFrameMassAuction_OnShow()
	IMA_UpdateItemButtons();

	for i = 1, IMA_NUMITEMBUTTONS, 1 do
		IMA_AuctionsRadioButton_OnClick(i,IMA_Settings["duration"..i])
	end
end

function IMA_SetItemAsAuction(itemindex)
	IMA_ClearAuctionSellItem();
	
	-- first see if something is in that slot
	but = getglobal("IMA_Item"..itemindex.."ItemButton");
	if ( but.bag == nil or but.item == nil) then return end

	-- if we have something on cursor already, remember it
	oldbag = IMA_AuctionFrameMassAuction.bag;
	olditem = IMA_AuctionFrameMassAuction.item;

	-- if we are already holding what we want
	if (but.bag == oldbag and but.item == olditem) then
		ClickAuctionSellItemButton();
		return;
	end
		
	-- put down what we had
	if ( oldbag ~= nil and olditem ~= nil) then
		IMA_PickupContainerItemOrig(oldbag,olditem);
	end
	
	-- pick up the new thing and put it in
	IMA_PickupContainerItemOrig(but.bag,but.item);
	ClickAuctionSellItemButton();
	IMA_PickupContainerItemOrig(but.bag,but.item);
	
	-- pick up what we had
	if ( oldbag ~= nil and olditem ~= nil) then
		IMA_PickupContainerItemOrig(oldbag,olditem);
	end
end

function IMA_FindAuctionItem()
	for bag = 0,4,1 do
		slots = GetContainerNumSlots(bag)
		if (slots ~= nil and slots > 0) then
			for item = 1, slots, 1 do
				local texture, itemCount, locked, quality, readable = GetContainerItemInfo(bag,item);
				local lockedstr = locked;
				if ( locked == nil ) then
					lockedstr = "nil";
				end
				if ( itemCount ~= nil and itemCount > 0 and locked ~= nil ) then
					return bag,item;
				end
			end
		end
	end
	return nil;
end

-- this function assumes that itemindex is the current active auction item
function IMA_SetInitialPrices(btn)
	local scheme = UIDropDownMenu_GetSelectedValue(IMA_PriceSchemeDropDown);
	scheme = string.gsub(scheme," ","_");

	local name, texture, count, quality, canUse, price = GetAuctionSellItemInfo();
	local start = max(100, floor(price * 1.5));
	local buyout = 0;
	
	pricefunc = getglobal("IMA_"..scheme.."_GetPriceAndBuyout");
	if (pricefunc ~= nil) then
		local start2 = nil;
		local buyout2 = nil;
		start2, buyout2 = pricefunc(btn.bag,btn.item,btn.count,btn.texture,btn.name,btn.price,start)
		if (start2 ~= nil) then
			start = start2;
		end
		if (buyout2 ~= nil) then
			buyout = buyout2;
		end
	end
	
	MoneyInputFrame_SetCopper(getglobal(btn:GetParent():GetName().."StartPrice"), start);
	MoneyInputFrame_SetCopper(getglobal(btn:GetParent():GetName().."BuyoutPrice"), buyout);
end

-- TODO: Make this work
function IMA_AuctionsFrameAuctions_ValidateAuction(itemindex)
	--IMA_AuctionsCreateAuctionButton:Disable();
	--IMA_AuctionsBuyoutErrorText:Hide();
	-- No item
	if ( not GetAuctionSellItemInfo() ) then
		return;
	end
	-- Buyout price is less than the start price
	--if ( MoneyInputFrame_GetCopper(IMA_BuyoutPrice) > 0 and MoneyInputFrame_GetCopper(IMA_StartPrice) > MoneyInputFrame_GetCopper(IMA_BuyoutPrice) ) then
		--IMA_AuctionsBuyoutErrorText:Show();
		--return;
	--end
	-- Start price is 0
	--if ( MoneyInputFrame_GetCopper(IMA_StartPrice) < 1 ) then
		--return;
	--end
	--IMA_AuctionsCreateAuctionButton:Enable();
end

function IMA_AuctionsRadioButton_OnClick(itemindex,index)
	if index == nil then
		index = 3;
	end

	getglobal("IMA_Item"..itemindex.."ShortAuction"):SetChecked(nil)
	getglobal("IMA_Item"..itemindex.."MediumAuction"):SetChecked(nil)
	getglobal("IMA_Item"..itemindex.."LongAuction"):SetChecked(nil)
	if ( index == 1 ) then
		getglobal("IMA_Item"..itemindex.."ShortAuction"):SetChecked(1)
		getglobal("IMA_Item"..itemindex).duration = 120;
	elseif ( index ==2 ) then
		getglobal("IMA_Item"..itemindex.."MediumAuction"):SetChecked(1)
		getglobal("IMA_Item"..itemindex).duration = 480;
	else
		getglobal("IMA_Item"..itemindex.."LongAuction"):SetChecked(1)
		getglobal("IMA_Item"..itemindex).duration = 1440;
	end

	IMA_Settings["duration"..itemindex] = index;

	-- maybe sure this is the current item before we update
	IMA_SetItemAsAuction(itemindex);
	IMA_UpdateDeposit(itemindex);
end

function IMA_UpdateDeposit(itemindex, amount)
	if ( amount == nil ) then
		amount = CalculateAuctionDeposit(getglobal("IMA_Item"..itemindex).duration);
	end
	if ( amount == nil ) then
		amount = 0;
	end
	
	MoneyFrame_Update("IMA_Item"..itemindex.."DepositCharge",amount)
end

-- this function assumes you don't have something on the cursor already
function IMA_ClearAuctionSellItem()
	if ( GetAuctionSellItemInfo() ~= nil ) then
		ClickAuctionSellItemButton();
		local bag, item = IMA_FindAuctionItem();
		IMA_PickupContainerItemOrig(bag, item);
	end
end

-- Handles the draggin of items
function IMA_ItemButton_OnClick(button)
	if ( not button ) then 
		button = this; 
	end

	if ( CursorHasItem() ) then
		local bag = IMA_AuctionFrameMassAuction.bag;
		local item = IMA_AuctionFrameMassAuction.item;
		
		if ( not bag or not item ) then return; end

		-- put it in auction slot while we're holding it
		ClickAuctionSellItemButton();

		-- We'll still be holding the item if it fails
		if (CursorHasItem()) then
			IMA_PickupContainerItemOrig(bag, item);
			return;
		end
		
		-- put the item back
		IMA_PickupContainerItemOrig(bag, item);

		if ( this.bag and this.item ) then
			-- There's already an item there
			IMA_PickupContainerItemOrig(button.bag, button.item);
			IMA_AuctionFrameMassAuction.bag = button.bag;
			IMA_AuctionFrameMassAuction.item = button.item;
		else
			IMA_AuctionFrameMassAuction.bag = nil;
			IMA_AuctionFrameMassAuction.item = nil;
		end

		local texture, count = GetContainerItemInfo(bag, item);

		getglobal(button:GetName() .. "IconTexture"):Show();
		getglobal(button:GetName() .. "IconTexture"):SetTexture(texture);

		if ( count > 1 ) then
			getglobal(button:GetName() .. "Count"):SetText(count);
			getglobal(button:GetName() .. "Count"):Show();
		else
			getglobal(button:GetName() .. "Count"):Hide();
		end

		local name, texture, count, quality, canUse, price = GetAuctionSellItemInfo();
		button.bag = bag;
		button.item = item;
		button.texture = texture;
		button.count = count;
		button.name = name;
		button.price = price;

		-- set our item count based on the first item
		if (button:GetParent():GetID() == 1) then
			IMA_AllSamePriceFrameStackSize:SetText(count);
		end
							   
		IMA_UpdateDeposit(button:GetParent():GetID());
		IMA_SetInitialPrices(button);
		
	elseif ( button.item and button.bag ) then
		IMA_ClearAuctionSellItem();
	
		IMA_PickupContainerItemOrig(button.bag, button.item);
		
		getglobal(button:GetName() .. "IconTexture"):Hide();
		getglobal(button:GetName() .. "Count"):Hide();

		IMA_AuctionFrameMassAuction.bag = button.bag;
		IMA_AuctionFrameMassAuction.item = button.item;

		button.item = nil;
		button.bag = nil;
		button.count = nil;
		button.texture = nil;
		button.name = nil;
		button.price = nil;
	end
	IMA_UpdateItemButtons();

	-- TODO: Display the total deposit
	
	for i = 1, NUM_CONTAINER_FRAMES, 1 do
		if ( getglobal("ContainerFrame" .. i):IsVisible() ) then
			ContainerFrame_Update(getglobal("ContainerFrame" .. i));
		end
	end
end

function IMA_UpdateItemButtons(frame)
	local i;
	local num = 0;
	local totalDeposit = 0;
	for i = 1, IMA_NUMITEMBUTTONS, 1 do
		local btn = getglobal("IMA_Item"..i.."ItemButton");
		if ( not frame or btn ~= frame ) then
			local texture, count;
			if ( btn.item and btn.bag ) then
				texture, count = GetContainerItemInfo(btn.bag, btn.item);
			end
			if ( not texture ) then
				getglobal(btn:GetName() .. "IconTexture"):Hide();
				getglobal(btn:GetName() .. "Count"):Hide();
				btn.item = nil; 
				btn.bag = nil; 
				btn.count = nil; 
				btn.texture = nil;
				btn.name = nil;
				btn.price = nil;
				IMA_UpdateDeposit(btn:GetParent():GetID(),0);
				MoneyInputFrame_SetCopper(getglobal(btn:GetParent():GetName().."StartPrice"), 0);
				MoneyInputFrame_SetCopper(getglobal(btn:GetParent():GetName().."BuyoutPrice"), 0);
			else
				num = num + 1
				local deposit = getglobal(btn:GetParent():GetName().."DepositCharge").staticMoney;
				if ( deposit ~= nil ) then
					totalDeposit = totalDeposit + deposit;
				end
				btn.count = count;
				btn.texture = texture;
				getglobal(btn:GetName() .. "IconTexture"):Show();
				getglobal(btn:GetName() .. "IconTexture"):SetTexture(texture);
				if ( count > 1 ) then
					getglobal(btn:GetName() .. "Count"):Show();
					getglobal(btn:GetName() .. "Count"):SetText(count);
				else
					getglobal(btn:GetName() .. "Count"):Hide();
				end
			end
		end
	end
	IMA_AuctionFrameMassAuction.num = num;
	IMA_AuctionFrameMassAuction.totalDeposit = totalDeposit;
	if ( num > 0 ) then
		IMA_AuctionsClearButton:Enable();
		IMA_AuctionsSubmitButton:Enable();
	else
		IMA_AuctionsClearButton:Disable();
		IMA_AuctionsSubmitButton:Disable();
	end
end

function IMA_GetItemFrame(bag, item)
	local i;
	for i = 1, IMA_NUMITEMBUTTONS, 1 do
		local btn = getglobal("IMA_Item"..i.."ItemButton");
		if ( btn.item == item and btn.bag == bag ) then
			return btn;
		end
	end
	return nil;
end

function IMA_ClearItems()
	local i;
	local num = 0;
	for i = 1, IMA_NUMITEMBUTTONS, 1 do
		local item = getglobal("IMA_Item"..i);
		local btn = getglobal(item:GetName().."ItemButton");
		MoneyInputFrame_SetCopper(getglobal(item:GetName().."StartPrice"), 0);
		MoneyInputFrame_SetCopper(getglobal(item:GetName().."BuyoutPrice"), 0);
		IMA_UpdateDeposit(i,0);
		btn.item = nil;
		btn.count = nil;
		btn.bag = nil;
		btn.texture = nil;
		btn.name = nil;
		btn.price = nil;
	end
	IMA_UpdateItemButtons();
	IMA_ClearAuctionSellItem();
end

function IMA_ClearItem(bag,item)
	local i;
	for i = 1, IMA_NUMITEMBUTTONS, 1 do
		local item = getglobal("IMA_Item"..i);
		local btn = getglobal(item:GetName().."ItemButton");
		if (btn.bag == bag and btn.item == item) then
			MoneyInputFrame_SetCopper(getglobal(item:GetName().."StartPrice"), 0);
			MoneyInputFrame_SetCopper(getglobal(item:GetName().."BuyoutPrice"), 0);
			IMA_UpdateDeposit(i,0);
			btn.item = nil;
			btn.count = nil;
			btn.bag = nil;
			btn.texture = nil;
			btn.name = nil;
			btn.price = nil;
			return;
		end
	end
	IMA_UpdateItemButtons();
end

function IMA_OnEvent()
	if (( event == "UNIT_NAME_UPDATE" ) and (arg1 == "player")) then
		local playername = UnitName("player");
		IMA_Playername = playername;
	elseif ( event == "AUCTION_HOUSE_CLOSED" ) then
		IMA_ClearItems();
		IMA_GlobalFrame.total = 0;
		IMA_GlobalFrame.queue = { };
	end
end

function IMA_AcceptSendFrame_OnShow()
	getglobal(this:GetName().."Info"):Show();
	getglobal(this:GetName().."InfoString"):Show();
	getglobal(this:GetName().."MoneyFrame"):Show();
	getglobal(this:GetName().."InfoItems"):SetText(IMA_AuctionFrameMassAuction.num .. " " .. IMA_ITEMS);
	getglobal(this:GetName().."SubmitButton"):Enable();
	IMA_UpdateItemButtons();
	MoneyFrame_Update(this:GetName() .. "MoneyFrame", IMA_AuctionFrameMassAuction.totalDeposit);
end

function IMA_AcceptSendFrameSubmitButton_OnClick()
	IMA_GlobalFrame.queue = IMA_FillItemTable();
	IMA_GlobalFrame.total = getn(IMA_GlobalFrame.queue);
	IMA_GlobalFrame.sent = 0;
	getglobal(this:GetParent():GetName().."Info"):Hide();
	getglobal(this:GetParent():GetName().."InfoString"):Hide();
	getglobal(this:GetParent():GetName().."MoneyFrame"):Hide();
	this:Disable();
end

function IMA_AcceptSendFrameCancelButton_OnClick()
	this:GetParent():Hide();
	IMA_GlobalFrame.queue = {};
	IMA_GlobalFrame.total = 0;
	IMA_GlobalFrame.sent = 0;
end

function IMA_FillItemTable()
	local arr = { };
	for i = 1, IMA_NUMITEMBUTTONS, 1 do
		local item = getglobal("IMA_Item"..i);
		local btn = getglobal(item:GetName().."ItemButton");
		local price = MoneyInputFrame_GetCopper(getglobal(item:GetName().."StartPrice"));
		local buyout = MoneyInputFrame_GetCopper(getglobal(item:GetName().."BuyoutPrice"));
		if ( btn.item and btn.bag ) then
			tinsert(arr, { ["item"] = btn.item, ["bag"] = btn.bag, ["price"] = price,
						   ["buyout"] = buyout, ["duration"] = item.duration });
		end
	end
	return arr;
end

function IMA_ProcessQueue(elapsed)
	if ( this.bag ~= nil and this.item ~= nil ) then
		if ( GetContainerItemInfo(this.bag, this.item) == nil ) then
			this.sent = this.sent + 1;
			IMA_ClearItem(this.bag,this.item);
			this.bag = nil;
			this.item = nil;
			if (this.sent == this.total) then
				IMA_AcceptSendFrame:Hide();
			end
		end
	end
	
	if ( this.total == 0 ) then
		return;
	end

	if ( this.bag == nil and this.item == nil ) then
		IMA_StartAuction();
		IMA_AcceptSendFrameInfoItems:SetText(
			IMA_POSTING_ITEM..(this.sent+1)..IMA_OF..this.total.."...")
	end
end

function IMA_StartAuction()
	IMA_ClearAuctionSellItem();
	
	key, val = next(this.queue);
	if (key == nil) then
		this.total = 0;
		this.bag = nil;
		this.item = nil;
		this.queue = { };
		return;
	end
	
	this.bag = val.bag;
	this.item = val.item;
	
	-- put down what we picked up so things don't mess up
	if ( CursorHasItem() and IMA_AuctionFrameMassAuction.bag and IMA_AuctionFrameMassAuction.item ) then
		PickupContainerItem(IMA_AuctionFrameMassAuction.bag, IMA_AuctionFrameMassAuction.item);
		IMA_AuctionFrameMassAuction.bag = nil;
		IMA_AuctionFrameMassAuction.item = nil;
	end

	IMA_PickupContainerItemOrig(val.bag, val.item);

	ClickAuctionSellItemButton();

	local name, texture, count, quality, canUse, price = GetAuctionSellItemInfo();

	if ( not name ) then 
		DEFAULT_CHAT_FRAME:AddMessage("<MassAuction> " .. IMA_ERROR, 1, 0, 0);
	else
		-- these 3 lines help with compatability
		MoneyInputFrame_SetCopper(StartPrice, val.price);
		MoneyInputFrame_SetCopper(BuyoutPrice, val.buyout);
		AuctionFrameAuctions.duration = val.duration;

		StartAuction(val.price, val.buyout, val.duration);
	end

	this.queue[key] = nil;
	return;
end

-- SET PRICES DROPDOWN CODE

function IMA_PriceSchemeDropDown_OnShow()
	IMA_PriceSchemeDropDown_OnLoad();
	
	-- set default if none
	if IMA_Settings.DropDown == nil then
		IMA_Settings.DropDown = "Default";
	end
	
	getglobal("IMA_" .. IMA_Settings.DropDown .. "_function")();
end

function IMA_PriceSchemeDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, IMA_PriceSchemeDropDown_Initialize);
end

function IMA_ClearTopFrame()
	if IMA_MultiplierFrame then
		IMA_MultiplierFrame:Hide();
		IMA_AllSamePriceFrame:Hide();
		IMA_EasyAuctionFrame:Hide();
	end
end

function IMA_Default_function()
	UIDropDownMenu_SetSelectedValue(IMA_PriceSchemeDropDown, "Default");
	IMA_ClearTopFrame();
	IMA_Settings.DropDown = "Default";
end
	
function IMA_Multiplier_function()
	UIDropDownMenu_SetSelectedValue(IMA_PriceSchemeDropDown, "Multiplier");
	IMA_ClearTopFrame();
	IMA_MultiplierFrame:Show();
	IMA_Settings.DropDown = "Multiplier";
end
	
function IMA_AllSamePrice_function()
	UIDropDownMenu_SetSelectedValue(IMA_PriceSchemeDropDown, "AllSamePrice");
	IMA_ClearTopFrame();
	IMA_AllSamePriceFrame:Show();
	IMA_Settings.DropDown = "AllSamePrice";
end

function IMA_EasyAuction_function()
	UIDropDownMenu_SetSelectedValue(IMA_PriceSchemeDropDown, "EasyAuction");
	IMA_ClearTopFrame();
	IMA_EasyAuctionFrame:Show();
	IMA_Settings.DropDown = "EasyAuction";
end

function IMA_PriceSchemeDropDown_Initialize()
	local info = {};
	info.text = IMA_DEFAULT;
	info.value = "Default";
	info.func = IMA_Default_function;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = IMA_VALUE_MULTIPLIER;
	info.value = "Multiplier";
	info.func = IMA_Multiplier_function;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = IMA_ALL_SAME_PRICE;
	info.value = "AllSamePrice";
	info.func = IMA_AllSamePrice_function;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = IMA_EASY_AUCTION;
	info.value = "EasyAuction";
	info.func = IMA_EasyAuction_function;
	UIDropDownMenu_AddButton(info);
end

function IMA_SetAllPricesButton_OnClick()
	local scheme = UIDropDownMenu_GetSelectedValue(IMA_PriceSchemeDropDown);
	scheme = string.gsub(scheme," ","_");

	pricefunc = getglobal("IMA_"..scheme.."_GetPriceAndBuyout");
	if (pricefunc == nil) then
		return;
	end
	
	IMA_ClearAuctionSellItem();
	for i = 1, IMA_NUMITEMBUTTONS, 1 do
		local item = getglobal("IMA_Item"..i);
		local btn = getglobal(item:GetName().."ItemButton");
		
		if (btn.bag ~= nil and btn.item ~= nil) then
			if (true and true) then -- put checkbox code here
				price, buyout = pricefunc(btn.bag,btn.item,btn.count,btn.texture,btn.name,btn.price,
										  MoneyInputFrame_GetCopper(getglobal(item:GetName().."StartPrice")))
				if (price ~= nil) then
					MoneyInputFrame_SetCopper(getglobal(item:GetName().."StartPrice"),price);
				end
				if (buyout ~= nil) then	
					MoneyInputFrame_SetCopper(getglobal(item:GetName().."BuyoutPrice"),buyout);
				end
			end
		end
	end
end

function IMA_Default_GetPriceAndBuyout(bag, item, count, texture, name, price, currentstart)
	start = MoneyInputFrame_GetCopper(StartPrice);
	buyout = MoneyInputFrame_GetCopper(BuyoutPrice);

	return start, buyout;
end

function IMA_Multiplier_GetPriceAndBuyout(bag, item, count, texture, name, price, currentstart)
	local retprice = nil;
	local retbuyout = nil;
	
	if (IMA_MultiplierFramePriceCheckButton:GetChecked()) then
		pricepercent = IMA_MultiplierFramePriceMultiplier:GetText() + 0;
		if (pricepercent >= 1 and pricepercent <= 9999) then
			retprice = max(100,floor(price * pricepercent / 100.0));
			currentstart = retprice + 0;
		end
	end

	if (IMA_MultiplierFrameBuyoutCheckButton:GetChecked()) then
		buyoutpercent = IMA_MultiplierFrameBuyoutMultiplier:GetText() + 0;
		if (buyoutpercent >= 1 and buyoutpercent <= 9999) then
			retbuyout = floor(currentstart * buyoutpercent / 100.0);
		end
	end
	
	return retprice,retbuyout
end

function IMA_AllSamePrice_GetPriceAndBuyout(bag, item, count, texture, name, price, currentstart)
	local price = MoneyInputFrame_GetCopper(IMA_AllSamePriceFrameStartPrice);
	local buyout = MoneyInputFrame_GetCopper(IMA_AllSamePriceFrameBuyoutPrice);
	local basecount = IMA_AllSamePriceFrameStackSize:GetText() + 0;

	if (basecount > 0 and count ~= basecount) then
		price = floor(price / basecount * count);
		buyout = floor(buyout / basecount * count);
	end

	return price,buyout;
end

function IMA_EasyAuction_GetPriceAndBuyout(bag, item, count, texture, name, price, currentstart)
	local start = nil;
	local buyout = nil;
	
	if (EasyAuction_Prices ~= nil and EasyAuction_PersonalPrices ~= nil) then
		local lastauction = nil;
		if (IMA_Playername ~= nil and EasyAuction_PersonalPrices[IMA_Playername] ~= nil
				and EasyAuction_PersonalPrices[IMA_Playername][name] ~= nil) then
			lastauction = EasyAuction_PersonalPrices[IMA_Playername][name];
		else
			if (EasyAuction_Prices[name] ~= nil) then
				lastauction = EasyAuction_Prices[name];
			end
		end
		if (lastauction ~= nil) then
			start = lastauction.bid * count;
			buyout = lastauction.buyout * count;
		end
	end	

	return start,buyout;
end

