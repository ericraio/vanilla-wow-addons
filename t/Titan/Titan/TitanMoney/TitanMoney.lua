TITAN_MONEY_ID = "Money";
TITAN_MONEY_FREQUENCY = 1;

local startMoney;
local startSessionTime;

function TitanPanelMoneyButton_OnLoad()
	this.registry = { 
		id = TITAN_MONEY_ID,
		builtIn = 1,
		version = TITAN_VERSION,
		menuText = TITAN_MONEY_MENU_TEXT, 
		tooltipTitle = TITAN_MONEY_TOOLTIP,
		tooltipTextFunction = "TitanPanelMoneyButton_GetTooltipText",
		frequency = TITAN_MONEY_FREQUENCY,
		updateType = TITAN_PANEL_UPDATE_TOOLTIP,
	};

	SmallMoneyFrame_OnLoad();
	this:RegisterEvent("PLAYER_ENTERING_WORLD");

	WoW_OpenCoinPickupFrame = OpenCoinPickupFrame;	
	OpenCoinPickupFrame = Titan_OpenCoinPickupFrame;
end

function TitanPanelMoneyButton_OnEvent() 
	MoneyFrame_OnEvent()
	if (event == "PLAYER_ENTERING_WORLD") then
		MoneyFrame_UpdateMoney();
		if (not startMoney) then
			startMoney = GetMoney();
			startSessionTime = 0;
		end
	end
end

function TitanPanelMoneyCopperButton_OnClick(button)
	if (button == "LeftButton") then
		local parent = this:GetParent();
		OpenCoinPickupFrame(1, MoneyTypeInfo[parent.moneyType].UpdateFunc(), parent);
		parent.hasPickup = 1;
	end
end

function TitanPanelMoneySilverButton_OnClick(button)
	if (button == "LeftButton") then
		local parent = this:GetParent();
		OpenCoinPickupFrame(COPPER_PER_SILVER, MoneyTypeInfo[parent.moneyType].UpdateFunc(), parent);
		parent.hasPickup = 1;
	end
end

function TitanPanelMoneyGoldButton_OnClick(button)
	if (button == "LeftButton") then
		local parent = this:GetParent();
		OpenCoinPickupFrame(COPPER_PER_GOLD, MoneyTypeInfo[parent.moneyType].UpdateFunc(), parent);
		parent.hasPickup = 1;
	end
end

function TitanPanelMoneyButton_GetTooltipText()
	local sessionTime = TitanUtils_GetSessionTime() - startSessionTime;
	local initialMoney = startMoney;
	local fluctMoney = GetMoney() - initialMoney;
	local fluctMoneyPerHour = TitanPanelMoneyButton_GetMoneyPerHour(fluctMoney, sessionTime);
	
	if fluctMoneyPerHour == nil then
		fluctMoneyPerHour = 0;
	end
	-- Current money Text
	local currentMoneyRichText = TITAN_MONEY_TOOLTIP_CURRENT.."\t"..
			TitanUtils_GetHighlightText(format(TITAN_MONEY_FORMAT, TitanPanelMoneyButton_BreakMoney(GetMoney())));

	-- Initial money Text
	local initialMoneyRichText = TITAN_MONEY_TOOLTIP_INITIAL.."\t"..
			TitanUtils_GetHighlightText(format(TITAN_MONEY_FORMAT, TitanPanelMoneyButton_BreakMoney(initialMoney)));
	
	-- Money Fluctuation Text
	local fluctMoneyRichText;
	local fluctMoneyPerHourRichText;
	if (fluctMoney < 0) then		
		fluctMoneyRichText = TITAN_MONEY_TOOLTIP_LOST.."\t"..
			TitanUtils_GetRedText(format(TITAN_MONEY_FORMAT, TitanPanelMoneyButton_BreakMoney(0 - fluctMoney)));
		fluctMoneyPerHourRichText = TITAN_MONEY_TOOLTIP_LOST_HOUR.."\t"..
			TitanUtils_GetRedText(format(TITAN_MONEY_FORMAT, TitanPanelMoneyButton_BreakMoney(0 - fluctMoneyPerHour)));
	elseif (fluctMoney == 0) then
		fluctMoneyRichText = TITAN_MONEY_TOOLTIP_EARNED.."\t"..
			TitanUtils_GetHighlightText(format(TITAN_MONEY_FORMAT, TitanPanelMoneyButton_BreakMoney(0)));
		fluctMoneyPerHourRichText = TITAN_MONEY_TOOLTIP_EARNED_HOUR.."\t"..
			TitanUtils_GetHighlightText(format(TITAN_MONEY_FORMAT, TitanPanelMoneyButton_BreakMoney(0)));
	else
		fluctMoneyRichText = TITAN_MONEY_TOOLTIP_EARNED.."\t"..
			TitanUtils_GetGreenText(format(TITAN_MONEY_FORMAT, TitanPanelMoneyButton_BreakMoney(fluctMoney)));
		fluctMoneyPerHourRichText = TITAN_MONEY_TOOLTIP_EARNED_HOUR.."\t"..
			TitanUtils_GetGreenText(format(TITAN_MONEY_FORMAT, TitanPanelMoneyButton_BreakMoney(fluctMoneyPerHour)));
	end
	
	return ""..
		currentMoneyRichText.."\n"..
		initialMoneyRichText.."\n"..
		fluctMoneyRichText.."\n"..
		fluctMoneyPerHourRichText.."\n"..
		TitanUtils_GetGreenText(TITAN_MONEY_TOOLTIP_HINTS);
end

function TitanPanelRightClickMenu_PrepareMoneyMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_MONEY_ID].menuText);
	TitanPanelRightClickMenu_AddCommand(TITAN_MONEY_MENU_RESET_SESSION, TITAN_MONEY_ID, "TitanPanelMoneyButton_ResetSession");
	TitanPanelRightClickMenu_AddSpacer();	
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_MONEY_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanPanelMoneyButton_ResetSession()
	startMoney = GetMoney();
	startSessionTime = TitanUtils_GetSessionTime();
end

function TitanPanelMoneyButton_GetMoneyPerHour(money, session)
	if (money and session and session > 0) then
		return money / session * 3600;
	end
end

function TitanPanelMoneyButton_BreakMoney(money)
	-- Non-negative money only
	if (money >= 0) then
		local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD));
		local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
		local copper = mod(money, COPPER_PER_SILVER);
		return gold, silver, copper;
	end
end

function Titan_OpenCoinPickupFrame(multiplier, maxMoney, parent)
	if ( CoinPickupFrame.owner ) then
		CoinPickupFrame.owner.hasPickup = 0;
	end

	if ( GetCursorMoney() > 0 ) then
		if ( CoinPickupFrame.owner ) then
			MoneyTypeInfo[parent.moneyType].DropFunc();
			PlaySound("igBackPackCoinSelect");
		end
		CoinPickupFrame:Hide();
		return;
	end

	CoinPickupFrame.multiplier = multiplier;
	CoinPickupFrame.maxMoney = floor(maxMoney / multiplier);
	if ( CoinPickupFrame.maxMoney == 0 ) then
		CoinPickupFrame:Hide();
		return;
	end

	CoinPickupFrame.owner = parent;
	CoinPickupFrame.money = 1;
	CoinPickupFrame.typing = 0;
	CoinPickupText:SetText(CoinPickupFrame.money);
	CoinPickupLeftButton:Disable();
	CoinPickupRightButton:Enable();

	if ( multiplier == 1 ) then
		CoinPickupCopperIcon:Show();
	else
		CoinPickupCopperIcon:Hide();
	end

	if ( multiplier == COPPER_PER_SILVER ) then
		CoinPickupSilverIcon:Show();
	else
		CoinPickupSilverIcon:Hide();
	end

	if ( multiplier == (COPPER_PER_GOLD) ) then
		CoinPickupGoldIcon:Show();
	else
		CoinPickupGoldIcon:Hide();
	end

	position = TitanUtils_GetRealPosition(TITAN_MONEY_ID);


	local scale = TitanPanelGetVar("Scale");
	if scale == nil then scale = 1; end

	if (parent:GetName() == "TitanPanelMoneyButton") then
		if (position == TITAN_PANEL_PLACE_TOP) then 
			CoinPickupFrame:ClearAllPoints();
			CoinPickupFrame:SetPoint("TOPLEFT", parent:GetName(), "BOTTOMLEFT", -10, -4 * scale);
		else
			CoinPickupFrame:ClearAllPoints();
			CoinPickupFrame:SetPoint("BOTTOMLEFT", parent:GetName(), "TOPLEFT", -10, 0);
		end		
	else
		CoinPickupFrame:ClearAllPoints();
		CoinPickupFrame:SetPoint("BOTTOMRIGHT", parent:GetName(), "TOPRIGHT", 0, 0);
		if (position == TITAN_PANEL_PLACE_TOP) then 
			CoinPickupFrame:ClearAllPoints();
			CoinPickupFrame:SetPoint("TOPLEFT", parent:GetName(), "BOTTOMLEFT", -10, -4 * scale);
		else
			CoinPickupFrame:ClearAllPoints();
			CoinPickupFrame:SetPoint("BOTTOMLEFT", parent:GetName(), "TOPLEFT", -10, 0);
		end		
	end
	CoinPickupFrame:Show();
	PlaySound("igBackPackCoinSelect");
end
