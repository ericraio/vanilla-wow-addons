function CT_BankFrame_UpdateSlotPrice()
	local numSlots, full = GetNumBankSlots();
	MoneyFrame_Update(this:GetName() .. "MoneyFrame", GetBankSlotCost(numSlots));
end

CT_oldPurchaseSlot = PurchaseSlot;
function CT_newPurchaseSlot()
	CT_BankFrame_AcceptFrame:Show();
end
PurchaseSlot = CT_newPurchaseSlot;