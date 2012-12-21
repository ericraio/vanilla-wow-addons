function Perl_Config_Party_Display()
	Perl_Config_Hide_All();
	if (Perl_Party_Frame) then
		Perl_Config_Party_Frame:Show();
		Perl_Config_Party_Set_Values();
	else
		Perl_Config_Party_Frame:Hide();
		Perl_Config_NotInstalled_Frame:Show();
	end
end

function Perl_Config_Party_Set_Values()
	local vartable = Perl_Party_GetVars();

	Perl_Config_Party_Frame_Slider2Low:SetText("-150");
	Perl_Config_Party_Frame_Slider2High:SetText("150");
	Perl_Config_Party_Frame_Slider2:SetValue(-vartable["partyspacing"]);

	if (vartable["partyhidden"] == 0) then
		Perl_Config_Party_Frame_CheckButton1:SetChecked(1);
		Perl_Config_Party_Frame_CheckButton2:SetChecked(nil);
		Perl_Config_Party_Frame_CheckButton3:SetChecked(nil);
	elseif (vartable["partyhidden"] == 1) then
		Perl_Config_Party_Frame_CheckButton1:SetChecked(nil);
		Perl_Config_Party_Frame_CheckButton2:SetChecked(nil);
		Perl_Config_Party_Frame_CheckButton3:SetChecked(1);
	elseif (vartable["partyhidden"] == 2) then
		Perl_Config_Party_Frame_CheckButton1:SetChecked(nil);
		Perl_Config_Party_Frame_CheckButton2:SetChecked(1);
		Perl_Config_Party_Frame_CheckButton3:SetChecked(nil);
	else
		Perl_Config_Party_Frame_CheckButton1:SetChecked(nil);
		Perl_Config_Party_Frame_CheckButton2:SetChecked(nil);
		Perl_Config_Party_Frame_CheckButton3:SetChecked(1);
	end

	if (vartable["compactmode"] == 1) then
		Perl_Config_Party_Frame_CheckButton4:SetChecked(1);
	else
		Perl_Config_Party_Frame_CheckButton4:SetChecked(nil);
	end

	if (vartable["healermode"] == 1) then
		Perl_Config_Party_Frame_CheckButton5:SetChecked(1);
	else
		Perl_Config_Party_Frame_CheckButton5:SetChecked(nil);
	end

	if (vartable["showpets"] == 1) then
		Perl_Config_Party_Frame_CheckButton6:SetChecked(1);
	else
		Perl_Config_Party_Frame_CheckButton6:SetChecked(nil);
	end

	if (vartable["locked"] == 1) then
		Perl_Config_Party_Frame_CheckButton8:SetChecked(1);
	else
		Perl_Config_Party_Frame_CheckButton8:SetChecked(nil);
	end

	if (vartable["verticalalign"] == 1) then
		Perl_Config_Party_Frame_CheckButton10:SetChecked(1);
	else
		Perl_Config_Party_Frame_CheckButton10:SetChecked(nil);
	end

	if (vartable["compactpercent"] == 1) then
		Perl_Config_Party_Frame_CheckButton11:SetChecked(1);
	else
		Perl_Config_Party_Frame_CheckButton11:SetChecked(nil);
	end

	if (vartable["showportrait"] == 1) then
		Perl_Config_Party_Frame_CheckButton12:SetChecked(1);
	else
		Perl_Config_Party_Frame_CheckButton12:SetChecked(nil);
	end

	if (vartable["showfkeys"] == 1) then
		Perl_Config_Party_Frame_CheckButton13:SetChecked(1);
	else
		Perl_Config_Party_Frame_CheckButton13:SetChecked(nil);
	end

	if (vartable["displaycastablebuffs"] == 1) then
		Perl_Config_Party_Frame_CheckButton14:SetChecked(1);
	else
		Perl_Config_Party_Frame_CheckButton14:SetChecked(nil);
	end

	if (vartable["threedportrait"] == 1) then
		Perl_Config_Party_Frame_CheckButton15:SetChecked(1);
	else
		Perl_Config_Party_Frame_CheckButton15:SetChecked(nil);
	end

	if (vartable["classcolorednames"] == 1) then
		Perl_Config_Party_Frame_CheckButton16:SetChecked(1);
	else
		Perl_Config_Party_Frame_CheckButton16:SetChecked(nil);
	end

	if (vartable["shortbars"] == 1) then
		Perl_Config_Party_Frame_CheckButton17:SetChecked(1);
	else
		Perl_Config_Party_Frame_CheckButton17:SetChecked(nil);
	end

	if (vartable["hideclasslevelframe"] == 1) then
		Perl_Config_Party_Frame_CheckButton18:SetChecked(1);
	else
		Perl_Config_Party_Frame_CheckButton18:SetChecked(nil);
	end

	if (vartable["showmanadeficit"] == 1) then
		Perl_Config_Party_Frame_CheckButton19:SetChecked(1);
	else
		Perl_Config_Party_Frame_CheckButton19:SetChecked(nil);
	end

	if (vartable["showpvpicon"] == 1) then
		Perl_Config_Party_Frame_CheckButton20:SetChecked(1);
	else
		Perl_Config_Party_Frame_CheckButton20:SetChecked(nil);
	end

	if (vartable["showbarvalues"] == 1) then
		Perl_Config_Party_Frame_CheckButton21:SetChecked(1);
	else
		Perl_Config_Party_Frame_CheckButton21:SetChecked(nil);
	end

	Perl_Config_Party_Frame_Slider1Low:SetText(PERL_LOCALIZED_CONFIG_SMALL);
	Perl_Config_Party_Frame_Slider1High:SetText(PERL_LOCALIZED_CONFIG_BIG);
	Perl_Config_Party_Frame_Slider1:SetValue(floor(vartable["scale"]*100+0.5));

	if (floor(vartable["scale"]*100+0.5) == floor(UIParent:GetScale()*100+0.5)) then
		Perl_Config_Party_Frame_CheckButton9:SetChecked(1);
	else
		Perl_Config_Party_Frame_CheckButton9:SetChecked(nil);
	end

	Perl_Config_Party_Frame_Slider3Low:SetText("0");
	Perl_Config_Party_Frame_Slider3High:SetText("100");
	Perl_Config_Party_Frame_Slider3:SetValue(vartable["transparency"]*100);

	Perl_Config_Party_Frame_Slider4Low:SetText("1");
	Perl_Config_Party_Frame_Slider4High:SetText("7");
	Perl_Config_Party_Frame_Slider4:SetValue(vartable["bufflocation"]);

	Perl_Config_Party_Frame_Slider5Low:SetText("1");
	Perl_Config_Party_Frame_Slider5High:SetText("7");
	Perl_Config_Party_Frame_Slider5:SetValue(vartable["debufflocation"]);

	Perl_Config_Party_Frame_Slider6Low:SetText("1");
	Perl_Config_Party_Frame_Slider6High:SetText("50");
	Perl_Config_Party_Frame_Slider6:SetValue(vartable["buffsize"]);

	Perl_Config_Party_Frame_Slider7Low:SetText("1");
	Perl_Config_Party_Frame_Slider7High:SetText("50");
	Perl_Config_Party_Frame_Slider7:SetValue(vartable["debuffsize"]);

	Perl_Config_Party_Frame_Slider8Low:SetText("0");
	Perl_Config_Party_Frame_Slider8High:SetText("16");
	Perl_Config_Party_Frame_Slider8:SetValue(vartable["numbuffsshown"]);

	Perl_Config_Party_Frame_Slider9Low:SetText("0");
	Perl_Config_Party_Frame_Slider9High:SetText("16");
	Perl_Config_Party_Frame_Slider9:SetValue(vartable["numdebuffsshown"]);
end

function Perl_Config_Party_Set_Space(value)
	if (Perl_Party_Frame) then		-- this check is to prevent errors if you aren't using Party
		Perl_Party_Set_Space(value);
	end
end

function Perl_Config_Party_Set_Buff_Location(value)
	if (Perl_Party_Frame) then		-- this check is to prevent errors if you aren't using Party
		Perl_Party_Set_Buff_Location(value);
	end
end

function Perl_Config_Party_Set_Debuff_Location(value)
	if (Perl_Party_Frame) then		-- this check is to prevent errors if you aren't using Party
		Perl_Party_Set_Debuff_Location(value);
	end
end

function Perl_Config_Party_Set_Buff_Size(value)
	if (Perl_Party_Frame) then		-- this check is to prevent errors if you aren't using Party
		Perl_Party_Set_Buff_Size(value);
	end
end

function Perl_Config_Party_Set_Debuff_Size(value)
	if (Perl_Party_Frame) then		-- this check is to prevent errors if you aren't using Party
		Perl_Party_Set_Debuff_Size(value);
	end
end

function Perl_Config_Party_Hidden_Update()
	if (Perl_Config_Party_Frame_CheckButton1:GetChecked() == 1) then
		Perl_Party_Set_Hidden(0);
	elseif (Perl_Config_Party_Frame_CheckButton2:GetChecked() == 1) then
		Perl_Party_Set_Hidden(2);
	elseif (Perl_Config_Party_Frame_CheckButton3:GetChecked() == 1) then
		Perl_Party_Set_Hidden(1);
	else
		Perl_Config_Party_Frame_CheckButton3:SetChecked(1);
		Perl_Party_Set_Hidden(1);
	end
end

function Perl_Config_Party_Compact_Update()
	if (Perl_Config_Party_Frame_CheckButton4:GetChecked() == 1) then
		Perl_Party_Set_Compact(1);
	else
		Perl_Party_Set_Compact(0);
	end
end

function Perl_Config_Party_Healer_Update()
	if (Perl_Config_Party_Frame_CheckButton5:GetChecked() == 1) then
		Perl_Party_Set_Healer(1);
	else
		Perl_Party_Set_Healer(0);
	end
end

function Perl_Config_Party_Pets_Update()
	if (Perl_Config_Party_Frame_CheckButton6:GetChecked() == 1) then
		Perl_Party_Set_Pets(1);
	else
		Perl_Party_Set_Pets(0);
	end
end

function Perl_Config_Party_Lock_Update()
	if (Perl_Config_Party_Frame_CheckButton8:GetChecked() == 1) then
		Perl_Party_Set_Lock(1);
	else
		Perl_Party_Set_Lock(0);
	end
end

function Perl_Config_Party_VerticalAlign_Update()
	if (Perl_Config_Party_Frame_CheckButton10:GetChecked() == 1) then
		Perl_Party_Set_VerticalAlign(1);
	else
		Perl_Party_Set_VerticalAlign(0);
	end
end

function Perl_Config_Party_Compact_Percent_Update()
	if (Perl_Config_Party_Frame_CheckButton11:GetChecked() == 1) then
		Perl_Party_Set_Compact_Percent(1);
	else
		Perl_Party_Set_Compact_Percent(0);
	end
end

function Perl_Config_Party_Short_Bars_Update()
	if (Perl_Config_Party_Frame_CheckButton17:GetChecked() == 1) then
		Perl_Party_Set_Short_Bars(1);
	else
		Perl_Party_Set_Short_Bars(0);
	end
end

function Perl_Config_Party_Portrait_Update()
	if (Perl_Config_Party_Frame_CheckButton12:GetChecked() == 1) then
		Perl_Party_Set_Portrait(1);
	else
		Perl_Party_Set_Portrait(0);
	end
end

function Perl_Config_Party_FKeys_Update()
	if (Perl_Config_Party_Frame_CheckButton13:GetChecked() == 1) then
		Perl_Party_Set_FKeys(1);
	else
		Perl_Party_Set_FKeys(0);
	end
end

function Perl_Config_Party_Class_Buffs_Update()
	if (Perl_Config_Party_Frame_CheckButton14:GetChecked() == 1) then
		Perl_Party_Set_Class_Buffs(1);
	else
		Perl_Party_Set_Class_Buffs(0);
	end
end

function Perl_Config_Party_3D_Portrait_Update()
	if (Perl_Config_Party_Frame_CheckButton15:GetChecked() == 1) then
		Perl_Party_Set_3D_Portrait(1);
	else
		Perl_Party_Set_3D_Portrait(0);
	end
end

function Perl_Config_Party_Class_Colored_Names_Update()
	if (Perl_Config_Party_Frame_CheckButton16:GetChecked() == 1) then
		Perl_Party_Set_Class_Colored_Names(1);
	else
		Perl_Party_Set_Class_Colored_Names(0);
	end
end

function Perl_Config_Party_Hide_Class_Level_Frame_Update()
	if (Perl_Config_Party_Frame_CheckButton18:GetChecked() == 1) then
		Perl_Party_Set_Hide_Class_Level_Frame(1);
	else
		Perl_Party_Set_Hide_Class_Level_Frame(0);
	end
end

function Perl_Config_Party_Mana_Deficit_Update()
	if (Perl_Config_Party_Frame_CheckButton19:GetChecked() == 1) then
		Perl_Party_Set_Mana_Deficit(1);
	else
		Perl_Party_Set_Mana_Deficit(0);
	end
end

function Perl_Config_Party_PvP_Icon_Update()
	if (Perl_Config_Party_Frame_CheckButton20:GetChecked() == 1) then
		Perl_Party_Set_PvP_Icon(1);
	else
		Perl_Party_Set_PvP_Icon(0);
	end
end

function Perl_Config_Party_Show_Bar_Values_Update()
	if (Perl_Config_Party_Frame_CheckButton21:GetChecked() == 1) then
		Perl_Party_Set_Show_Bar_Values(1);
	else
		Perl_Party_Set_Show_Bar_Values(0);
	end
end

function Perl_Config_Party_Set_Buffs(value)
	if (Perl_Party_Frame) then		-- this check is to prevent errors if you aren't using Party
		Perl_Party_Set_Buffs(value);
	end
end

function Perl_Config_Party_Set_Debuffs(value)
	if (Perl_Party_Frame) then		-- this check is to prevent errors if you aren't using Party
		Perl_Party_Set_Debuffs(value);
	end
end

function Perl_Config_Party_Set_Scale(value)
	if (Perl_Party_Frame) then		-- this check is to prevent errors if you aren't using Party
		if (value == nil) then
			value = floor(UIParent:GetScale()*100+0.5);
			Perl_Config_Party_Frame_Slider1Text:SetText(value);
			Perl_Config_Party_Frame_Slider1:SetValue(value);
		end
		Perl_Party_Set_Scale(value);

		vartable = Perl_Party_GetVars();
		if (floor(vartable["scale"]*100+0.5) == floor(UIParent:GetScale()*100+0.5)) then
			Perl_Config_Party_Frame_CheckButton9:SetChecked(1);
		else
			Perl_Config_Party_Frame_CheckButton9:SetChecked(nil);
		end
	end
end

function Perl_Config_Party_Set_Transparency(value)
	if (Perl_Party_Frame) then		-- this check is to prevent errors if you aren't using Party
		Perl_Party_Set_Transparency(value);
	end
end