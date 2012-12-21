function tradeDispenser_ResetRegistratedChars()
	--tD_CharDatas.RegisterChars={}; 
	tD_Temp.RegUser = { 
		[0] = { ["name"]="empty",  ["trades"]=0 } 
	};	
	tradeDispenserVerbose(0," TradeList resetted");	
end


function tradeDispenser_TradeControl_Update()
	tradeDispenserTradeControlRaid:SetChecked(tD_CharDatas.Raid)
	tradeDispenserTradeControlGuild:SetChecked(tD_CharDatas.Guild)
	tradeDispenserTradeControlLevel:SetChecked(tD_CharDatas.LevelCheck)
	tradeDispenserTradeControlAccept:SetChecked(tD_CharDatas.AutoAccept)
	tradeDispenserTradeControlLevelMin:SetValue(tD_CharDatas.LevelValue)
	tradeDispenserTradeControlRegister:SetChecked(tD_CharDatas.RegisterCheck)
	tradeDispenserTradeControlRegisterMaxTrades:SetValue(tD_CharDatas.RegisterValue)
	
	if (tD_CharDatas.BanlistActive) then
		tradeDispenserTradeControlBans:SetChecked(1)
		tradeDispenserTradeControlBanlistBtn:Enable()
	else
		tradeDispenserTradeControlBans:SetChecked(0)
		tradeDispenserTradeControlBanlistBtn:Disable()
	end
	
	if ( tD_CharDatas.LevelCheck ) then
		tradeDispenserTradeControlLevelMin:Show()
	else
		tradeDispenserTradeControlLevelMin:Hide()
	end
	
	if (tradeDispenserTradeControlRaid:GetChecked()) then
		tradeDispenserTradeControlGuild:Show()
	else
		tradeDispenserTradeControlGuild:Hide()
	end
	
	if ( tD_CharDatas.RegisterCheck ) then
		tradeDispenserTradeControlRegister:SetChecked(1)
		tradeDispenserTradeControlRegisterMaxTrades:Show()
		tradeDispenserTradeControlRegisterReset:Show()
	else
		tradeDispenserTradeControlRegister:SetChecked(0)
		tradeDispenserTradeControlRegisterMaxTrades:Hide()
		tradeDispenserTradeControlRegisterReset:Hide()
	end
end
