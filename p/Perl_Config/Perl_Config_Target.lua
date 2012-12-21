function Perl_Config_Target_Display()
	Perl_Config_Hide_All();
	if (Perl_Target_Frame) then
		Perl_Config_Target_Frame:Show();
		Perl_Config_Target_Set_Values();
	else
		Perl_Config_Target_Frame:Hide();
		Perl_Config_NotInstalled_Frame:Show();
	end
end

function Perl_Config_Target_Set_Values()
	local vartable = Perl_Target_GetVars();

	Perl_Config_Target_Frame_Slider2Low:SetText("0");
	Perl_Config_Target_Frame_Slider2High:SetText("16");
	Perl_Config_Target_Frame_Slider2:SetValue(vartable["numbuffsshown"]);

	Perl_Config_Target_Frame_Slider3Low:SetText("0");
	Perl_Config_Target_Frame_Slider3High:SetText("16");
	Perl_Config_Target_Frame_Slider3:SetValue(vartable["numdebuffsshown"]);

	if (vartable["showclassicon"] == 1) then
		Perl_Config_Target_Frame_CheckButton1:SetChecked(1);
	else
		Perl_Config_Target_Frame_CheckButton1:SetChecked(nil);
	end

	if (vartable["showpvprank"] == 1) then
		Perl_Config_Target_Frame_CheckButton2:SetChecked(1);
	else
		Perl_Config_Target_Frame_CheckButton2:SetChecked(nil);
	end

	if (vartable["showpvpicon"] == 1) then
		Perl_Config_Target_Frame_CheckButton3:SetChecked(1);
	else
		Perl_Config_Target_Frame_CheckButton3:SetChecked(nil);
	end

	if (vartable["showclassframe"] == 1) then
		Perl_Config_Target_Frame_CheckButton4:SetChecked(1);
	else
		Perl_Config_Target_Frame_CheckButton4:SetChecked(nil);
	end

	if (vartable["showcp"] == 1) then
		Perl_Config_Target_Frame_CheckButton5:SetChecked(1);
	else
		Perl_Config_Target_Frame_CheckButton5:SetChecked(nil);
	end

	if (vartable["mobhealthsupport"] == 1) then
		Perl_Config_Target_Frame_CheckButton6:SetChecked(1);
	else
		Perl_Config_Target_Frame_CheckButton6:SetChecked(nil);
	end

	if (vartable["locked"] == 1) then
		Perl_Config_Target_Frame_CheckButton8:SetChecked(1);
	else
		Perl_Config_Target_Frame_CheckButton8:SetChecked(nil);
	end

	if (vartable["showportrait"] == 1) then
		Perl_Config_Target_Frame_CheckButton10:SetChecked(1);
	else
		Perl_Config_Target_Frame_CheckButton10:SetChecked(nil);
	end

	if (vartable["threedportrait"] == 1) then
		Perl_Config_Target_Frame_CheckButton11:SetChecked(1);
	else
		Perl_Config_Target_Frame_CheckButton11:SetChecked(nil);
	end

	if (vartable["portraitcombattext"] == 1) then
		Perl_Config_Target_Frame_CheckButton12:SetChecked(1);
	else
		Perl_Config_Target_Frame_CheckButton12:SetChecked(nil);
	end

	if (vartable["showrareeliteframe"] == 1) then
		Perl_Config_Target_Frame_CheckButton13:SetChecked(1);
	else
		Perl_Config_Target_Frame_CheckButton13:SetChecked(nil);
	end

	if (vartable["nameframecombopoints"] == 1) then
		Perl_Config_Target_Frame_CheckButton14:SetChecked(1);
	else
		Perl_Config_Target_Frame_CheckButton14:SetChecked(nil);
	end

	if (vartable["comboframedebuffs"] == 1) then
		Perl_Config_Target_Frame_CheckButton15:SetChecked(1);
	else
		Perl_Config_Target_Frame_CheckButton15:SetChecked(nil);
	end

	if (vartable["framestyle"] == 2) then
		Perl_Config_Target_Frame_CheckButton16:SetChecked(1);
	else
		Perl_Config_Target_Frame_CheckButton16:SetChecked(nil);
	end

	if (vartable["compactmode"] == 1) then
		Perl_Config_Target_Frame_CheckButton17:SetChecked(1);
	else
		Perl_Config_Target_Frame_CheckButton17:SetChecked(nil);
	end

	if (vartable["compactpercent"] == 1) then
		Perl_Config_Target_Frame_CheckButton18:SetChecked(1);
	else
		Perl_Config_Target_Frame_CheckButton18:SetChecked(nil);
	end

	if (vartable["hidebuffbackground"] == 1) then
		Perl_Config_Target_Frame_CheckButton19:SetChecked(1);
	else
		Perl_Config_Target_Frame_CheckButton19:SetChecked(nil);
	end

	Perl_Config_Target_Frame_Slider1Low:SetText("Small");
	Perl_Config_Target_Frame_Slider1High:SetText("Big");
	Perl_Config_Target_Frame_Slider1:SetValue(floor(vartable["scale"]*100+0.5));

	if (floor(vartable["scale"]*100+0.5) == floor(UIParent:GetScale()*100+0.5)) then
		Perl_Config_Target_Frame_CheckButton9:SetChecked(1);
	else
		Perl_Config_Target_Frame_CheckButton9:SetChecked(nil);
	end

	Perl_Config_Target_Frame_Slider4Low:SetText("0");
	Perl_Config_Target_Frame_Slider4High:SetText("100");
	Perl_Config_Target_Frame_Slider4:SetValue(vartable["transparency"]*100);

	Perl_Config_Target_Frame_Slider5Low:SetText("Small");
	Perl_Config_Target_Frame_Slider5High:SetText("Big");
	Perl_Config_Target_Frame_Slider5:SetValue(floor(vartable["buffdebuffscale"]*100+0.5));
end

function Perl_Config_Target_Set_Buffs(value)
	if (Perl_Target_Frame) then	-- this check is to prevent errors if you aren't using Target
		Perl_Target_Set_Buffs(value);
	end
end

function Perl_Config_Target_Set_Debuffs(value)
	if (Perl_Target_Frame) then	-- this check is to prevent errors if you aren't using Target
		Perl_Target_Set_Debuffs(value);
	end
end

function Perl_Config_Target_Class_Icon_Update()
	if (Perl_Config_Target_Frame_CheckButton1:GetChecked() == 1) then
		Perl_Target_Set_Class_Icon(1);
	else
		Perl_Target_Set_Class_Icon(0);
	end
end

function Perl_Config_Target_PvP_Rank_Icon_Update()
	if (Perl_Config_Target_Frame_CheckButton2:GetChecked() == 1) then
		Perl_Target_Set_PvP_Rank_Icon(1);
	else
		Perl_Target_Set_PvP_Rank_Icon(0);
	end
end

function Perl_Config_Target_PvP_Status_Icon_Update()
	if (Perl_Config_Target_Frame_CheckButton3:GetChecked() == 1) then
		Perl_Target_Set_PvP_Status_Icon(1);
	else
		Perl_Target_Set_PvP_Status_Icon(0);
	end
end

function Perl_Config_Target_Class_Frame_Update()
	if (Perl_Config_Target_Frame_CheckButton4:GetChecked() == 1) then
		Perl_Target_Set_Class_Frame(1);
	else
		Perl_Target_Set_Class_Frame(0);
	end
end

function Perl_Config_Target_Combo_Points_Update()
	if (Perl_Config_Target_Frame_CheckButton5:GetChecked() == 1) then
		Perl_Target_Set_Combo_Points(1);
	else
		Perl_Target_Set_Combo_Points(0);
	end
end

function Perl_Config_Target_MobHealth_Update()
	if (Perl_Config_Target_Frame_CheckButton6:GetChecked() == 1) then
		Perl_Target_Set_MobHealth(1);
	else
		Perl_Target_Set_MobHealth(0);
	end
end

function Perl_Config_Target_Lock_Update()
	if (Perl_Config_Target_Frame_CheckButton8:GetChecked() == 1) then
		Perl_Target_Set_Lock(1);
	else
		Perl_Target_Set_Lock(0);
	end
end

function Perl_Config_Target_Portrait_Update()
	if (Perl_Config_Target_Frame_CheckButton10:GetChecked() == 1) then
		Perl_Target_Set_Portrait(1);
	else
		Perl_Target_Set_Portrait(0);
	end
end

function Perl_Config_Target_3D_Portrait_Update()
	if (Perl_Config_Target_Frame_CheckButton11:GetChecked() == 1) then
		Perl_Target_Set_3D_Portrait(1);
	else
		Perl_Target_Set_3D_Portrait(0);
	end
end

function Perl_Config_Target_Portrait_Combat_Text_Update()
	if (Perl_Config_Target_Frame_CheckButton12:GetChecked() == 1) then
		Perl_Target_Set_Portrait_Combat_Text(1);
	else
		Perl_Target_Set_Portrait_Combat_Text(0);
	end
end

function Perl_Config_Target_Rare_Elite_Update()
	if (Perl_Config_Target_Frame_CheckButton13:GetChecked() == 1) then
		Perl_Target_Set_Rare_Elite(1);
	else
		Perl_Target_Set_Rare_Elite(0);
	end
end

function Perl_Config_Target_Combo_Name_Frame_Update()
	if (Perl_Config_Target_Frame_CheckButton14:GetChecked() == 1) then
		Perl_Target_Set_Combo_Name_Frame(1);
	else
		Perl_Target_Set_Combo_Name_Frame(0);
	end
end

function Perl_Config_Target_Combo_Frame_Debuffs_Update()
	if (Perl_Config_Target_Frame_CheckButton15:GetChecked() == 1) then
		Perl_Target_Set_Combo_Frame_Debuffs(1);
	else
		Perl_Target_Set_Combo_Frame_Debuffs(0);
	end
end

function Perl_Config_Target_Alternate_Frame_Style_Update()
	if (Perl_Config_Target_Frame_CheckButton16:GetChecked() == 1) then
		Perl_Target_Set_Frame_Style(2);
	else
		Perl_Target_Set_Frame_Style(1);
	end
end

function Perl_Config_Target_Compact_Mode_Update()
	if (Perl_Config_Target_Frame_CheckButton17:GetChecked() == 1) then
		Perl_Target_Set_Compact_Mode(1);
	else
		Perl_Target_Set_Compact_Mode(0);
	end
end

function Perl_Config_Target_Compact_Percents_Update()
	if (Perl_Config_Target_Frame_CheckButton18:GetChecked() == 1) then
		Perl_Target_Set_Compact_Percents(1);
	else
		Perl_Target_Set_Compact_Percents(0);
	end
end

function Perl_Config_Target_Buff_Background_Update()
	if (Perl_Config_Target_Frame_CheckButton19:GetChecked() == 1) then
		Perl_Target_Set_Buff_Debuff_Background(1);
	else
		Perl_Target_Set_Buff_Debuff_Background(0);
	end
end

function Perl_Config_Target_Set_Scale(value)
	if (Perl_Target_Frame) then	-- this check is to prevent errors if you aren't using Target
		if (value == nil) then
			value = floor(UIParent:GetScale()*100+0.5);
			Perl_Config_Target_Frame_Slider1Text:SetText(value);
			Perl_Config_Target_Frame_Slider1:SetValue(value);
		end
		Perl_Target_Set_Scale(value);

		vartable = Perl_Target_GetVars();
		if (floor(vartable["scale"]*100+0.5) == floor(UIParent:GetScale()*100+0.5)) then
			Perl_Config_Target_Frame_CheckButton9:SetChecked(1);
		else
			Perl_Config_Target_Frame_CheckButton9:SetChecked(nil);
		end
	end
end

function Perl_Config_Target_Set_BuffDebuff_Scale(value)
	if (Perl_Target_Frame) then	-- this check is to prevent errors if you aren't using Target
		if (value == nil) then
			value = floor(UIParent:GetScale()*100+0.5);
			Perl_Config_Target_Frame_Slider5Text:SetText(value);
			Perl_Config_Target_Frame_Slider5:SetValue(value);
		end
		Perl_Target_Set_BuffDebuff_Scale(value);
	end
end

function Perl_Config_Target_Set_Transparency(value)
	if (Perl_Target_Frame) then	-- this check is to prevent errors if you aren't using Player
		Perl_Target_Set_Transparency(value);
	end
end