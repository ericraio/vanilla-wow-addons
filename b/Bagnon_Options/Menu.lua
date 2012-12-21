function BagnonOptions_OnShow()
	local frameName = this:GetName();
	
	getglobal(frameName .. "Tooltips"):SetChecked(BagnonSets.showTooltips);
	getglobal(frameName .. "Quality"):SetChecked(BagnonSets.qualityBorders);
	
	getglobal(frameName .. "ShowBagnon1"):SetChecked(BagnonSets.showBagsAtBank);
	--getglobal(frameName .. "ShowBagnon2"):SetChecked(BagnonSets.showBagsAtVendor);
	getglobal(frameName .. "ShowBagnon3"):SetChecked(BagnonSets.showBagsAtAH);
	--getglobal(frameName .. "ShowBagnon4"):SetChecked(BagnonSets.showBagsAtMail);
	getglobal(frameName .. "ShowBagnon5"):SetChecked(BagnonSets.showBagsAtTrade);
	getglobal(frameName .. "ShowBagnon6"):SetChecked(BagnonSets.showBagsAtCraft);
	
	getglobal(frameName .. "ShowBanknon1"):SetChecked(BagnonSets.showBankAtBank);
	getglobal(frameName .. "ShowBanknon2"):SetChecked(BagnonSets.showBankAtVendor);
	getglobal(frameName .. "ShowBanknon3"):SetChecked(BagnonSets.showBankAtAH);
	getglobal(frameName .. "ShowBanknon4"):SetChecked(BagnonSets.showBankAtMail);
	getglobal(frameName .. "ShowBanknon5"):SetChecked(BagnonSets.showBankAtTrade);
	getglobal(frameName .. "ShowBanknon6"):SetChecked(BagnonSets.showBankAtCraft);
end

function BagnonOptions_ShowAtBank(enable, bank)
	if(bank) then
		if(enable) then
			BagnonSets.showBankAtBank= 1;
		else
			BagnonSets.showBankAtBank = nil;
		end
	else
		if(enable) then
			BagnonSets.showBagsAtBank= 1;
		else
			BagnonSets.showBagsAtBank = nil;
		end
	end
end

function BagnonOptions_ShowAtVendor(enable, bank)
	if(bank) then
		if(enable) then
			BagnonSets.showBankAtVendor= 1;
		else
			BagnonSets.showBankAtVendor = nil;
		end
	else
		if(enable) then
			BagnonSets.showBagsAtVendor= 1;
		else
			BagnonSets.showBagsAtVendor = nil;
		end
	end
end

function BagnonOptions_ShowAtAH(enable, bank)
	if(bank) then
		if(enable) then
			BagnonSets.showBankAtAH= 1;
		else
			BagnonSets.showBankAtAH = nil;
		end
	else
		if(enable) then
			BagnonSets.showBagsAtAH= 1;
		else
			BagnonSets.showBagsAtAH = nil;
		end
	end
end

function BagnonOptions_ShowAtMail(enable, bank)
	if(bank) then
		if(enable) then
			BagnonSets.showBankAtMail = 1;
		else
			BagnonSets.showBankAtMail = nil;
		end
	else
		if(enable) then
			BagnonSets.showBagsAtMail = 1;
		else
			BagnonSets.showBagsAtMail = nil;
		end
	end
end

function BagnonOptions_ShowAtTrade(enable, bank)
	if(bank) then
		if(enable) then
			BagnonSets.showBankAtTrade= 1;
		else
			BagnonSets.showBankAtTrade = nil;
		end
	else
		if(enable) then
			BagnonSets.showBagsAtTrade= 1;
		else
			BagnonSets.showBagsAtTrade = nil;
		end
	end
end

function BagnonOptions_ShowAtCrafting(enable, bank)
	if(bank) then
		if(enable) then
			BagnonSets.showBankAtCraft = 1;
		else
			BagnonSets.showBankAtCraft = nil;
		end
	else
		if(enable) then
			BagnonSets.showBagsAtCraft= 1;
		else
			BagnonSets.showBagsAtCraft = nil;
		end
	end
end

function BagnonOptions_ShowTooltips(enable)
	if(enable) then
		BagnonSets.showTooltips = 1;
	else
		BagnonSets.showTooltips = nil;
	end
end

function BagnonOptions_ShowQualityBorders(enable)
	if(enable) then
		BagnonSets.qualityBorders = 1;
	else
		BagnonSets.qualityBorders = nil;
	end
	
	if(Bagnon and Bagnon:IsShown() ) then
		BagnonFrame_Generate(Bagnon);
	end
	
	if(Banknon and Banknon:IsShown() ) then
		BagnonFrame_Generate(Banknon);
	end
end