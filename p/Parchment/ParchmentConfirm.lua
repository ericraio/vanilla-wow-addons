function ParchmentConfirmedAction()
	if(PARCHMENT_CONFIRM_ACTION == "clear") then
		ParchmentEditBox:SetText("");
	else -- Deleting the Chapter
		Parchment_Data[PARCHMENT_PLAYER] = nil;
		PARCHMENT_PLAYER = "General";
		ParchmentSetText();
		Parchment_Update();
		ChatFrame1:AddMessage("This character's Chapter is now deleted");
	end
end
