function Perl_Config_Player_Display()
	Perl_Config_Hide_All();
	if (Perl_Player_Frame) then
		Perl_Config_Player_Frame:Show();
		Perl_Config_Player_Set_Values();
	else
		Perl_Config_Player_Frame:Hide();
		Perl_Config_NotInstalled_Frame:Show();
	end
end

function Perl_Config_Player_Set_Values()
	local vartable = Perl_Player_GetVars();

	if (vartable["xpbarstate"] == 1) then
		Perl_Config_Player_Frame_CheckButton1:SetChecked(1);
		Perl_Config_Player_Frame_CheckButton2:SetChecked(nil);
		Perl_Config_Player_Frame_CheckButton15:SetChecked(nil);
		Perl_Config_Player_Frame_CheckButton3:SetChecked(nil);
	elseif (vartable["xpbarstate"] == 2) then
		Perl_Config_Player_Frame_CheckButton1:SetChecked(nil);
		Perl_Config_Player_Frame_CheckButton2:SetChecked(1);
		Perl_Config_Player_Frame_CheckButton15:SetChecked(nil);
		Perl_Config_Player_Frame_CheckButton3:SetChecked(nil);
	elseif (vartable["xpbarstate"] == 3) then
		Perl_Config_Player_Frame_CheckButton1:SetChecked(nil);
		Perl_Config_Player_Frame_CheckButton2:SetChecked(nil);
		Perl_Config_Player_Frame_CheckButton15:SetChecked(nil);
		Perl_Config_Player_Frame_CheckButton3:SetChecked(1);
	elseif (vartable["xpbarstate"] == 4) then
		Perl_Config_Player_Frame_CheckButton1:SetChecked(nil);
		Perl_Config_Player_Frame_CheckButton2:SetChecked(nil);
		Perl_Config_Player_Frame_CheckButton15:SetChecked(1);
		Perl_Config_Player_Frame_CheckButton3:SetChecked(nil);
	else
		Perl_Config_Player_Frame_CheckButton1:SetChecked(nil);
		Perl_Config_Player_Frame_CheckButton2:SetChecked(nil);
		Perl_Config_Player_Frame_CheckButton15:SetChecked(nil);
		Perl_Config_Player_Frame_CheckButton3:SetChecked(1);
	end

	if (vartable["compactmode"] == 1) then
		Perl_Config_Player_Frame_CheckButton4:SetChecked(1);
	else
		Perl_Config_Player_Frame_CheckButton4:SetChecked(nil);
	end

	if (vartable["healermode"] == 1) then
		Perl_Config_Player_Frame_CheckButton5:SetChecked(1);
	else
		Perl_Config_Player_Frame_CheckButton5:SetChecked(nil);
	end

	if (vartable["showraidgroup"] == 1) then
		Perl_Config_Player_Frame_CheckButton6:SetChecked(1);
	else
		Perl_Config_Player_Frame_CheckButton6:SetChecked(nil);
	end

	if (vartable["locked"] == 1) then
		Perl_Config_Player_Frame_CheckButton8:SetChecked(1);
	else
		Perl_Config_Player_Frame_CheckButton8:SetChecked(nil);
	end

	if (vartable["showportrait"] == 1) then
		Perl_Config_Player_Frame_CheckButton10:SetChecked(1);
	else
		Perl_Config_Player_Frame_CheckButton10:SetChecked(nil);
	end

	if (vartable["compactpercent"] == 1) then
		Perl_Config_Player_Frame_CheckButton11:SetChecked(1);
	else
		Perl_Config_Player_Frame_CheckButton11:SetChecked(nil);
	end

	if (vartable["threedportrait"] == 1) then
		Perl_Config_Player_Frame_CheckButton12:SetChecked(1);
	else
		Perl_Config_Player_Frame_CheckButton12:SetChecked(nil);
	end

	if (vartable["portraitcombattext"] == 1) then
		Perl_Config_Player_Frame_CheckButton13:SetChecked(1);
	else
		Perl_Config_Player_Frame_CheckButton13:SetChecked(nil);
	end

	if (vartable["showdruidbar"] == 1) then
		Perl_Config_Player_Frame_CheckButton14:SetChecked(1);
	else
		Perl_Config_Player_Frame_CheckButton14:SetChecked(nil);
	end

	Perl_Config_Player_Frame_Slider1Low:SetText("Small");
	Perl_Config_Player_Frame_Slider1High:SetText("Big");
	Perl_Config_Player_Frame_Slider1:SetValue(floor(vartable["scale"]*100+0.5));

	if (floor(vartable["scale"]*100+0.5) == floor(UIParent:GetScale()*100+0.5)) then
		Perl_Config_Player_Frame_CheckButton9:SetChecked(1);
	else
		Perl_Config_Player_Frame_CheckButton9:SetChecked(nil);
	end

	Perl_Config_Player_Frame_Slider2Low:SetText("0");
	Perl_Config_Player_Frame_Slider2High:SetText("100");
	Perl_Config_Player_Frame_Slider2:SetValue(vartable["transparency"]*100);
end

function Perl_Config_Player_XPMode_Update()
	if (Perl_Config_Player_Frame_CheckButton1:GetChecked() == 1) then
		Perl_Player_XPBar_Display(1);
	elseif (Perl_Config_Player_Frame_CheckButton2:GetChecked() == 1) then
		Perl_Player_XPBar_Display(2);
	elseif (Perl_Config_Player_Frame_CheckButton3:GetChecked() == 1) then
		Perl_Player_XPBar_Display(3);
	elseif (Perl_Config_Player_Frame_CheckButton15:GetChecked() == 1) then
		Perl_Player_XPBar_Display(4);
	else
		Perl_Config_Player_Frame_CheckButton3:SetChecked(1);
		Perl_Player_XPBar_Display(3);
	end
end

function Perl_Config_Player_Compact_Update()
	if (Perl_Config_Player_Frame_CheckButton4:GetChecked() == 1) then
		Perl_Player_Set_Compact(1);
	else
		Perl_Player_Set_Compact(0);
	end
end

function Perl_Config_Player_Healer_Update()
	if (Perl_Config_Player_Frame_CheckButton5:GetChecked() == 1) then
		Perl_Player_Set_Healer(1);
	else
		Perl_Player_Set_Healer(0);
	end
end

function Perl_Config_Player_Raid_Update()
	if (Perl_Config_Player_Frame_CheckButton6:GetChecked() == 1) then
		Perl_Player_Set_RaidGroupNumber(1);
	else
		Perl_Player_Set_RaidGroupNumber(0);
	end
end

function Perl_Config_Player_Lock_Update()
	if (Perl_Config_Player_Frame_CheckButton8:GetChecked() == 1) then
		Perl_Player_Set_Lock(1);
	else
		Perl_Player_Set_Lock(0);
	end
end

function Perl_Config_Player_Portrait_Update()
	if (Perl_Config_Player_Frame_CheckButton10:GetChecked() == 1) then
		Perl_Player_Set_Portrait(1);
	else
		Perl_Player_Set_Portrait(0);
	end
end

function Perl_Config_Player_Compact_Percent_Update()
	if (Perl_Config_Player_Frame_CheckButton11:GetChecked() == 1) then
		Perl_Player_Set_Compact_Percent(1);
	else
		Perl_Player_Set_Compact_Percent(0);
	end
end

function Perl_Config_Player_3D_Portrait_Update()
	if (Perl_Config_Player_Frame_CheckButton12:GetChecked() == 1) then
		Perl_Player_Set_3D_Portrait(1);
	else
		Perl_Player_Set_3D_Portrait(0);
	end
end

function Perl_Config_Player_Portrait_Combat_Text_Update()
	if (Perl_Config_Player_Frame_CheckButton13:GetChecked() == 1) then
		Perl_Player_Set_Portrait_Combat_Text(1);
	else
		Perl_Player_Set_Portrait_Combat_Text(0);
	end
end

function Perl_Config_Player_DruidBar_Update()
	if (Perl_Config_Player_Frame_CheckButton14:GetChecked() == 1) then
		Perl_Player_Set_DruidBar(1);
	else
		Perl_Player_Set_DruidBar(0);
	end
end

function Perl_Config_Player_Set_Scale(value)
	if (Perl_Player_Frame) then	-- this check is to prevent errors if you aren't using Player
		if (value == nil) then
			value = floor(UIParent:GetScale()*100+0.5);
			Perl_Config_Player_Frame_Slider1Text:SetText(value);
			Perl_Config_Player_Frame_Slider1:SetValue(value);
		end
		Perl_Player_Set_Scale(value);

		vartable = Perl_Player_GetVars();
		if (floor(vartable["scale"]*100+0.5) == floor(UIParent:GetScale()*100+0.5)) then
			Perl_Config_Player_Frame_CheckButton9:SetChecked(1);
		else
			Perl_Config_Player_Frame_CheckButton9:SetChecked(nil);
		end
	end
end

function Perl_Config_Player_Set_Transparency(value)
	if (Perl_Player_Frame) then	-- this check is to prevent errors if you aren't using Player
		Perl_Player_Set_Transparency(value);
	end
end