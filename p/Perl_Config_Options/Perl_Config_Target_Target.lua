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

	if (vartable["showtotbuffs"] == 1) then
		Perl_Config_Target_Target_Frame_CheckButton14:SetChecked(1);
	else
		Perl_Config_Target_Target_Frame_CheckButton14:SetChecked(nil);
	end

	if (vartable["showtototbuffs"] == 1) then
		Perl_Config_Target_Target_Frame_CheckButton15:SetChecked(1);
	else
		Perl_Config_Target_Target_Frame_CheckButton15:SetChecked(nil);
	end

	if (vartable["hidepowerbars"] == 1) then
		Perl_Config_Target_Target_Frame_CheckButton16:SetChecked(1);
	else
		Perl_Config_Target_Target_Frame_CheckButton16:SetChecked(nil);
	end

	if (vartable["showtotdebuffs"] == 1) then
		Perl_Config_Target_Target_Frame_CheckButton17:SetChecked(1);
	else
		Perl_Config_Target_Target_Frame_CheckButton17:SetChecked(nil);
	end

	if (vartable["showtototdebuffs"] == 1) then
		Perl_Config_Target_Target_Frame_CheckButton18:SetChecked(1);
	else
		Perl_Config_Target_Target_Frame_CheckButton18:SetChecked(nil);
	end

	if (vartable["displaycastablebuffs"] == 1) then
		Perl_Config_Target_Target_Frame_CheckButton19:SetChecked(1);
	else
		Perl_Config_Target_Target_Frame_CheckButton19:SetChecked(nil);
	end

	if (vartable["classcolorednames"] == 1) then
		Perl_Config_Target_Target_Frame_CheckButton20:SetChecked(1);
	else
		Perl_Config_Target_Target_Frame_CheckButton20:SetChecked(nil);
	end

	if (vartable["showfriendlyhealth"] == 1) then
		Perl_Config_Target_Target_Frame_CheckButton21:SetChecked(1);
	else
		Perl_Config_Target_Target_Frame_CheckButton21:SetChecked(nil);
	end

	Perl_Config_Target_Target_Frame_Slider1Low:SetText(PERL_LOCALIZED_CONFIG_SMALL);
	Perl_Config_Target_Target_Frame_Slider1High:SetText(PERL_LOCALIZED_CONFIG_BIG);
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

function Perl_Config_Target_Target_Buff_Update()
	if (Perl_Config_Target_Target_Frame_CheckButton14:GetChecked() == 1) then
		Perl_Target_Target_Set_Buffs(1);
	else
		Perl_Target_Target_Set_Buffs(0);
	end
end

function Perl_Config_Target_Target_Target_Buff_Update()
	if (Perl_Config_Target_Target_Frame_CheckButton15:GetChecked() == 1) then
		Perl_Target_Target_Target_Set_Buffs(1);
	else
		Perl_Target_Target_Target_Set_Buffs(0);
	end
end

function Perl_Config_Target_Target_Debuff_Update()
	if (Perl_Config_Target_Target_Frame_CheckButton17:GetChecked() == 1) then
		Perl_Target_Target_Set_Debuffs(1);
	else
		Perl_Target_Target_Set_Debuffs(0);
	end
end

function Perl_Config_Target_Target_Target_Debuff_Update()
	if (Perl_Config_Target_Target_Frame_CheckButton18:GetChecked() == 1) then
		Perl_Target_Target_Target_Set_Debuffs(1);
	else
		Perl_Target_Target_Target_Set_Debuffs(0);
	end
end

function Perl_Config_Target_Target_Hide_Power_Bars_Update()
	if (Perl_Config_Target_Target_Frame_CheckButton16:GetChecked() == 1) then
		Perl_Target_Target_Set_Hide_Power_Bars(1);
	else
		Perl_Target_Target_Set_Hide_Power_Bars(0);
	end
end

function Perl_Config_Target_Target_Class_Buffs_Update()
	if (Perl_Config_Target_Target_Frame_CheckButton19:GetChecked() == 1) then
		Perl_Target_Target_Set_Class_Buffs(1);
	else
		Perl_Target_Target_Set_Class_Buffs(0);
	end
end

function Perl_Config_Target_Target_Class_Colored_Names_Update()
	if (Perl_Config_Target_Target_Frame_CheckButton20:GetChecked() == 1) then
		Perl_Target_Target_Set_Class_Colored_Names(1);
	else
		Perl_Target_Target_Set_Class_Colored_Names(0);
	end
end

function Perl_Config_Target_Target_Show_Friendly_Health_Update()
	if (Perl_Config_Target_Target_Frame_CheckButton21:GetChecked() == 1) then
		Perl_Target_Target_Set_Show_Friendly_Health(1);
	else
		Perl_Target_Target_Set_Show_Friendly_Health(0);
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
	if (Perl_Target_Target_Script_Frame) then	-- this check is to prevent errors if you aren't using Target_Target
		Perl_Target_Target_Set_Transparency(value);
	end
end