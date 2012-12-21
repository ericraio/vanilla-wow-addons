tinsert(UISpecialFrames, "CT_ResetFrame");
CT_ResetFrame_NumButtons = 10;

CT_ResetFrame_ResetFrames = { };

function CT_ResetFrame_Update()
	local numEntries = getn(CT_MovableFrames);

	FauxScrollFrame_Update(CT_ResetFrameScrollFrame, numEntries, CT_ResetFrame_NumButtons, 32);

	for i = 1, CT_ResetFrame_NumButtons, 1 do
		local button = getglobal("CT_ResetFrameBackdropButton" .. i);
		local index = i + FauxScrollFrame_GetOffset(CT_ResetFrameScrollFrame);
		if ( i <= numEntries and CT_MovableFrames[index]["name"] ) then
			button:Show();
			getglobal(button:GetName() .. "Name"):SetText(CT_MovableFrames[index]["name"]);
			if ( CT_ResetFrame_ResetFrames[CT_MovableFrames[index]["frame"]] ) then
				getglobal(button:GetName() .. "CheckButton"):SetChecked(1);
			else
				getglobal(button:GetName() .. "CheckButton"):SetChecked(nil);
			end
		else
			button:Hide();
			getglobal(button:GetName() .. "CheckButton"):SetChecked(nil);
		end
	end

end

function CT_ResetFrame_Check()
	local name = CT_MovableFrames[this:GetParent():GetID() + FauxScrollFrame_GetOffset(CT_ResetFrameScrollFrame)]["frame"];
	CT_ResetFrame_ResetFrames[name] = this:GetChecked();

	for i = 1, CT_ResetFrame_NumButtons, 1 do
		if ( not getglobal("CT_ResetFrameBackdropButton" .. i .. "CheckButton"):GetChecked() ) then
			CT_ResetFrameAllChecked:SetChecked(nil);
			return;
		else
			CT_ResetFrameAllChecked:SetChecked(1);
		end
	end
end

function CT_ResetFrame_CheckAll(check)
	CT_ResetFrameAllChecked:SetChecked(check);
	CT_ResetFrame_ResetFrames = { };
	for i = 1, CT_ResetFrame_NumButtons, 1 do
		getglobal("CT_ResetFrameBackdropButton" .. i .. "CheckButton"):SetChecked(check);
	end
	if ( check ) then
		for k, v in CT_MovableFrames do
			CT_ResetFrame_ResetFrames[v["frame"]] = 1;
		end
	end
end
			
function CT_ResetFrame_ResetSelected()
	local num = 0;
	for k, v in CT_ResetFrame_ResetFrames do
		CT_ResetFrameByName(k);
		num = num + 1;
	end
	if ( num == 1 ) then
		CT_Print(CT_MASTERMOD_RESET1, 1, 1, 0);
	elseif ( num > 1 ) then
		CT_Print(format(CT_MASTERMOD_RESET2, num), 1, 1, 0);
	end
end	
