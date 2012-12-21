function Perl_Config_Target_Target_Display()
	Perl_Config_Hide_All();
	if (Perl_Target_Target_Script_Frame) then
		Perl_Config_Target_Target_Frame:Show();
		Perl_Config_Target_Target_Set_Values();
	else
		Perl_Config_Target_Target_Frame:Hide();
		Perl_Config_NotInstalled_Frame:Show();
	end
end

function Perl_Config_Target_Target_Set_Values()
	local vartable = Perl_Target_Target_GetVars();

	if (vartable["totsupport"] == 1) then
		Perl_Config_Target_Target_Frame_CheckButton1:SetChecked(1);
	else
		Perl_Config_Target_Target_Frame_CheckButton1:SetChecked(nil);
	end

	if (vartable["tototsupport"] == 1) then
		Perl_Config_Target_Target_Frame_CheckButton2:SetChecked(1);
	else
		Perl_Config_Target_Target_Frame_CheckButton2:SetChecked(nil);
	end

	if (vartable["alertmode"] == 1) then
		Perl_Config_Target_Target_Frame_CheckButton8:SetChecked(1);
		Perl_Config_Target_Target_Frame_CheckButton9:SetChecked(nil);
		Perl_Config_Target_Target_Frame_CheckButton10:SetChecked(nil);
	elseif (vartable["alertmode"] == 2) then
		Perl_Config_Target_Target_Frame_CheckButton8:SetChecked(nil);
		Perl_Config_Target_Target_Frame_CheckButton9:SetChecked(1);
		Perl_Config_Target_Target_Frame_CheckButton10:SetChecked(nil);
	elseif (vartable["alertmode"] == 3) then
		Perl_Config_Target_Target_Frame_CheckButton8:SetChecked(nil);
		Perl_Config_Target_Target_Frame_CheckButton9:SetChecked(nil);
		Perl_Config_Target_Target_Frame_CheckButton10:SetChecked(1);
	else
		Perl_Config_Target_Target_Frame_CheckButton8:SetChecked(nil);
		Perl_Config_Target_Target_Frame_CheckButton9:SetChecked(nil);
		Perl_Config_Target_Target_Frame_CheckButton10:SetChecked(nil);
	end

	if (vartable["alertsound"] == 1) then
		Perl_Config_Target_Target_Frame_CheckButton7:SetChecked(1);
	else
		Perl_Config_Target_Target_Frame_CheckButton7:SetChecked(nil);
	end

	if (vartable["alertsize"] == 0) then
		Perl_Config_Target_Target_Frame_CheckButton11:SetChecked(1);
		Perl_Config_Target_Target_Frame_CheckButton12:SetChecked(nil);
		Perl_Config_Target_Target_Frame_CheckButton13:SetChecked(nil);
	elseif (vartable["alertsize"] == 1) then
		Perl_Config_Target_Target_Frame_CheckButton11:SetChecked(nil);
		Perl_Config_Target_Target_Frame_CheckButton12:SetChecked(1);
		Perl_Config_Target_Target_Frame_CheckButton13:SetChecked(nil);
	elseif (vartable["alertsize"] == 2) then
		Perl_Config_Target_Target_Frame_CheckButton11:SetChecked(nil);
		Perl_Config_Target_Target_Frame_CheckButton12:SetChecked(nil);
		Perl_Config_Target_Target_Frame_CheckButton13:SetChecked(1);
	else
		Perl_Config_Target_Target_Frame_CheckButton11:SetChecked(nil);
		Perl_Config_Target_Target_Frame_CheckButton12:SetChecked(nil);
		Perl_Config_Target_Target_Frame_CheckButton13:SetChecked(1);
	end

	if (vartable["mobhealthsupport"] == 1) then
		Perl_Config_Target_Target_Frame_CheckButton3:SetChecked(1);
	else
		Perl_Config_Target_Target_Frame_CheckButton3:SetChecked(nil);
	end

	if (vartable["locked"] == 1) then
		Perl_Config_Target_Target_Frame_CheckButton5:SetChecked(1);
	else
		Perl_Config_Target_Target_Frame_CheckButton5:SetChecked(nil);
	end

	Perl_Config_Target_Target_Frame_Slider1Low:SetText("Small");
	Perl_Config_Target_Target_Frame_Slider1High:SetText("Big");
	Perl_Config_Target_Target_Frame_Slider1:SetValue(floor(vartable["scale"]*100+0.5));

	if (floor(vartable["scale"]*100+0.5) == floor(UIParent:GetScale()*100+0.5)) then
		Perl_Config_Target_Target_Frame_CheckButton6:SetChecked(1);
	else
		Perl_Config_Target_Target_Frame_CheckButton6:SetChecked(nil);
	end

	Perl_Config_Target_Target_Frame_Slider2Low:SetText("0");
	Perl_Config_Target_Target_Frame_Slider2High:SetText("100");
	Perl_Config_Target_Target_Frame_Slider2:SetValue(vartable["transparency"]*100);
end

function Perl_Config_Target_Target_ToT_Update()
	if (Perl_Config_Target_Target_Frame_CheckButton1:GetChecked() == 1) then
		Perl_Target_Target_Set_ToT(1);
	else
		Perl_Target_Target_Set_ToT(0);
	end
end

function Perl_Config_Target_Target_ToToT_Update()
	if (Perl_Config_Target_Target_Frame_CheckButton2:GetChecked() == 1) then
		Perl_Target_Target_Set_ToToT(1);
	else
		Perl_Target_Target_Set_ToToT(0);
	end
end

function Perl_Config_Target_Target_Mode_Update()
	if (Perl_Config_Target_Target_Frame_CheckButton8:GetChecked() == 1) then
		Perl_Target_Target_Set_Mode(1);
	elseif (Perl_Config_Target_Target_Frame_CheckButton9:GetChecked() == 1) then
		Perl_Target_Target_Set_Mode(2);
	elseif (Perl_Config_Target_Target_Frame_CheckButton10:GetChecked() == 1) then
		Perl_Target_Target_Set_Mode(3);
	else
		Perl_Target_Target_Set_Mode(0);
	end
end

function Perl_Config_Target_Target_Sound_Update()
	if (Perl_Config_Target_Target_Frame_CheckButton7:GetChecked() == 1) then
		Perl_Target_Target_Set_Sound_Alert(1);
	else
		Perl_Target_Target_Set_Sound_Alert(0);
	end
end

function Perl_Config_Target_Target_Alert_Size_Update()
	if (Perl_Config_Target_Target_Frame_CheckButton11:GetChecked() == 1) then
		Perl_Target_Target_Set_Alert_Size(0);
	elseif (Perl_Config_Target_Target_Frame_CheckButton12:GetChecked() == 1) then
		Perl_Target_Target_Set_Alert_Size(1);
	elseif (Perl_Config_Target_Target_Frame_CheckButton13:GetChecked() == 1) then
		Perl_Target_Target_Set_Alert_Size(2);
	else
		Perl_Config_Target_Target_Frame_CheckButton13:SetChecked(1);
		Perl_Target_Target_Set_Alert_Size(2);
	end
end

function Perl_Config_Target_Target_MobHealth_Update()
	if (Perl_Config_Target_Target_Frame_CheckButton3:GetChecked() == 1) then
		Perl_Target_Target_Set_MobHealth(1);
	else
		Perl_Target_Target_Set_MobHealth(0);
	end
end

function Perl_Config_Target_Target_Lock_Update()
	if (Perl_Config_Target_Target_Frame_CheckButton5:GetChecked() == 1) then
		Perl_Target_Target_Set_Lock(1);
	else
		Perl_Target_Target_Set_Lock(0);
	end
end

function Perl_Config_Target_Target_Set_Scale(value)
	if (Perl_Target_Target_Script_Frame) then	-- this check is to prevent errors if you aren't using Target_Target
		if (value == nil) then
			value = floor(UIParent:GetScale()*100+0.5);
			Perl_Config_Target_Target_Frame_Slider1Text:SetText(value);
			Perl_Config_Target_Target_Frame_Slider1:SetValue(value);
		end
		Perl_Target_Target_Set_Scale(value);

		vartable = Perl_Target_Target_GetVars();
		if (floor(vartable["scale"]*100+0.5) == floor(UIParent:GetScale()*100+0.5)) then
			Perl_Config_Target_Target_Frame_CheckButton6:SetChecked(1);
		else
			Perl_Config_Target_Target_Frame_CheckButton6:SetChecked(nil);
		end
	end
end

function Perl_Config_Target_Target_Set_Transparency(value)
	if (Perl_Target_Target_Script_Frame) then	-- this check is to prevent errors if you aren't using Player
		Perl_Target_Target_Set_Transparency(value);
	end
end