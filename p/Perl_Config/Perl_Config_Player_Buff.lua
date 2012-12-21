function Perl_Config_Player_Buff_Display()
	Perl_Config_Hide_All();
	if (Perl_Player_Buff_Script_Frame) then
		Perl_Config_Player_Buff_Frame:Show();
		Perl_Config_Player_Buff_Set_Values();
	else
		Perl_Config_Player_Buff_Frame:Hide();
		Perl_Config_NotInstalled_Frame:Show();
	end
end

function Perl_Config_Player_Buff_Set_Values()
	local vartable = Perl_Player_Buff_GetVars();

	if (vartable["showbuffs"] == 1) then
		Perl_Config_Player_Buff_Frame_CheckButton1:SetChecked(1);
	else
		Perl_Config_Player_Buff_Frame_CheckButton1:SetChecked(nil);
	end

	if (vartable["buffalerts"] == 1) then
		Perl_Config_Player_Buff_Frame_CheckButton2:SetChecked(1);
	else
		Perl_Config_Player_Buff_Frame_CheckButton2:SetChecked(nil);
	end

	Perl_Config_Player_Buff_Frame_Slider1Low:SetText("Small");
	Perl_Config_Player_Buff_Frame_Slider1High:SetText("Big");
	Perl_Config_Player_Buff_Frame_Slider1:SetValue(floor(vartable["scale"]*100+0.5));

	if (floor(vartable["scale"]*100+0.5) == floor(UIParent:GetScale()*100+0.5)) then
		Perl_Config_Player_Buff_Frame_CheckButton3:SetChecked(1);
	else
		Perl_Config_Player_Buff_Frame_CheckButton3:SetChecked(nil);
	end
end

function Perl_Config_Player_Buff_ShowBuffs_Update()
	if (Perl_Config_Player_Buff_Frame_CheckButton1:GetChecked() == 1) then
		Perl_Player_Buff_Set_ShowBuffs(1);
	else
		Perl_Player_Buff_Set_ShowBuffs(0);
	end
end

function Perl_Config_Player_Buff_Alerts_Update()
	if (Perl_Config_Player_Buff_Frame_CheckButton2:GetChecked() == 1) then
		Perl_Player_Buff_Set_Alerts(1);
	else
		Perl_Player_Buff_Set_Alerts(0);
	end
end

function Perl_Config_Player_Buff_Set_Scale(value)
	if (Perl_Player_Buff_Script_Frame) then	-- this check is to prevent errors if you aren't using Player_Buff
		if (value == nil) then
			value = floor(UIParent:GetScale()*100+0.5);
			Perl_Config_Player_Buff_Frame_Slider1Text:SetText(value);
			Perl_Config_Player_Buff_Frame_Slider1:SetValue(value);
		end
		Perl_Player_Buff_Set_Scale(value);

		vartable = Perl_Player_Buff_GetVars();
		if (floor(vartable["scale"]*100+0.5) == floor(UIParent:GetScale()*100+0.5)) then
			Perl_Config_Player_Buff_Frame_CheckButton3:SetChecked(1);
		else
			Perl_Config_Player_Buff_Frame_CheckButton3:SetChecked(nil);
		end
	end
end