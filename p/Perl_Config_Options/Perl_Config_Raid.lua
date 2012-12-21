function Perl_Config_Raid_Display()
	Perl_Config_Hide_All();
	if (Perl_Raid_Frame) then
		Perl_Config_Raid_Frame:Show();
		Perl_Config_Raid_Set_Values();
	else
		Perl_Config_Raid_Frame:Hide();
		Perl_Config_NotInstalled_Frame:Show();
	end
end

function Perl_Config_Raid_Set_Values()
	local vartable = Perl_Raid_GetVars();

	if (vartable["showgroup1"] == 1) then
		Perl_Config_Raid_Frame_CheckButton1:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton1:SetChecked(nil);
	end

	if (vartable["showgroup2"] == 1) then
		Perl_Config_Raid_Frame_CheckButton2:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton2:SetChecked(nil);
	end

	if (vartable["showgroup3"] == 1) then
		Perl_Config_Raid_Frame_CheckButton3:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton3:SetChecked(nil);
	end

	if (vartable["showgroup4"] == 1) then
		Perl_Config_Raid_Frame_CheckButton4:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton4:SetChecked(nil);
	end

	if (vartable["showgroup5"] == 1) then
		Perl_Config_Raid_Frame_CheckButton5:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton5:SetChecked(nil);
	end

	if (vartable["showgroup6"] == 1) then
		Perl_Config_Raid_Frame_CheckButton6:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton6:SetChecked(nil);
	end

	if (vartable["showgroup7"] == 1) then
		Perl_Config_Raid_Frame_CheckButton7:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton7:SetChecked(nil);
	end

	if (vartable["showgroup8"] == 1) then
		Perl_Config_Raid_Frame_CheckButton8:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton8:SetChecked(nil);
	end

	if (vartable["showgroup9"] == 1) then
		Perl_Config_Raid_Frame_CheckButton26:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton26:SetChecked(nil);
	end

	if (vartable["sortraidbyclass"] == 1) then
		Perl_Config_Raid_Frame_CheckButton9:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton9:SetChecked(nil);
	end

	if (vartable["showhealthpercents"] == 1) then
		Perl_Config_Raid_Frame_CheckButton10:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton10:SetChecked(nil);
	end

	if (vartable["locked"] == 1) then
		Perl_Config_Raid_Frame_CheckButton11:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton11:SetChecked(nil);
	end

	if (vartable["showheaders"] == 1) then
		Perl_Config_Raid_Frame_CheckButton13:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton13:SetChecked(nil);
	end

	if (vartable["showmissinghealth"] == 1) then
		Perl_Config_Raid_Frame_CheckButton14:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton14:SetChecked(nil);
	end

	if (vartable["verticalalign"] == 1) then
		Perl_Config_Raid_Frame_CheckButton15:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton15:SetChecked(nil);
	end

	if (vartable["invertedgroups"] == 1) then
		Perl_Config_Raid_Frame_CheckButton16:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton16:SetChecked(nil);
	end

	if (vartable["showraidbuffs"] == 1) then
		Perl_Config_Raid_Frame_CheckButton17:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton17:SetChecked(nil);
	end

	if (vartable["displaycastablebuffs"] == 1) then
		Perl_Config_Raid_Frame_CheckButton18:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton18:SetChecked(nil);
	end

	if (vartable["showraiddebuffs"] == 1) then
		Perl_Config_Raid_Frame_CheckButton19:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton19:SetChecked(nil);
	end

	if (vartable["colordebuffnames"] == 1) then
		Perl_Config_Raid_Frame_CheckButton20:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton20:SetChecked(nil);
	end

	if (vartable["framestyle"] == 2) then
		Perl_Config_Raid_Frame_CheckButton21:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton21:SetChecked(nil);
	end

	if (vartable["showborder"] == 1) then
		Perl_Config_Raid_Frame_CheckButton22:SetChecked(nil);
	else
		Perl_Config_Raid_Frame_CheckButton22:SetChecked(1);
	end

	if (vartable["removespace"] == 1) then
		Perl_Config_Raid_Frame_CheckButton23:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton23:SetChecked(nil);
	end

	if (vartable["hidepowerbars"] == 1) then
		Perl_Config_Raid_Frame_CheckButton24:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton24:SetChecked(nil);
	end

	if (vartable["ctrastyletip"] == 1) then
		Perl_Config_Raid_Frame_CheckButton25:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton25:SetChecked(nil);
	end

	if (vartable["showmanapercents"] == 1) then
		Perl_Config_Raid_Frame_CheckButton27:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton27:SetChecked(nil);
	end

	if (vartable["hideemptyheaders"] == 1) then
		Perl_Config_Raid_Frame_CheckButton28:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton28:SetChecked(nil);
	end

	Perl_Config_Raid_Frame_Slider1Low:SetText(PERL_LOCALIZED_CONFIG_SMALL);
	Perl_Config_Raid_Frame_Slider1High:SetText(PERL_LOCALIZED_CONFIG_BIG);
	Perl_Config_Raid_Frame_Slider1:SetValue(floor(vartable["scale"]*100+0.5));

	if (floor(vartable["scale"]*100+0.5) == floor(UIParent:GetScale()*100+0.5)) then
		Perl_Config_Raid_Frame_CheckButton12:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton12:SetChecked(nil);
	end

	Perl_Config_Raid_Frame_Slider2Low:SetText("0");
	Perl_Config_Raid_Frame_Slider2High:SetText("100");
	Perl_Config_Raid_Frame_Slider2:SetValue(vartable["transparency"]*100);
end

function Perl_Config_Raid_Show_Group_One_Update()
	if (Perl_Config_Raid_Frame_CheckButton1:GetChecked() == 1) then
		Perl_Raid_Set_Show_Group_One(1);
	else
		Perl_Raid_Set_Show_Group_One(0);
	end
end

function Perl_Config_Raid_Show_Group_Two_Update()
	if (Perl_Config_Raid_Frame_CheckButton2:GetChecked() == 1) then
		Perl_Raid_Set_Show_Group_Two(1);
	else
		Perl_Raid_Set_Show_Group_Two(0);
	end
end

function Perl_Config_Raid_Show_Group_Three_Update()
	if (Perl_Config_Raid_Frame_CheckButton3:GetChecked() == 1) then
		Perl_Raid_Set_Show_Group_Three(1);
	else
		Perl_Raid_Set_Show_Group_Three(0);
	end
end

function Perl_Config_Raid_Show_Group_Four_Update()
	if (Perl_Config_Raid_Frame_CheckButton4:GetChecked() == 1) then
		Perl_Raid_Set_Show_Group_Four(1);
	else
		Perl_Raid_Set_Show_Group_Four(0);
	end
end

function Perl_Config_Raid_Show_Group_Five_Update()
	if (Perl_Config_Raid_Frame_CheckButton5:GetChecked() == 1) then
		Perl_Raid_Set_Show_Group_Five(1);
	else
		Perl_Raid_Set_Show_Group_Five(0);
	end
end

function Perl_Config_Raid_Show_Group_Six_Update()
	if (Perl_Config_Raid_Frame_CheckButton6:GetChecked() == 1) then
		Perl_Raid_Set_Show_Group_Six(1);
	else
		Perl_Raid_Set_Show_Group_Six(0);
	end
end

function Perl_Config_Raid_Show_Group_Seven_Update()
	if (Perl_Config_Raid_Frame_CheckButton7:GetChecked() == 1) then
		Perl_Raid_Set_Show_Group_Seven(1);
	else
		Perl_Raid_Set_Show_Group_Seven(0);
	end
end

function Perl_Config_Raid_Show_Group_Eight_Update()
	if (Perl_Config_Raid_Frame_CheckButton8:GetChecked() == 1) then
		Perl_Raid_Set_Show_Group_Eight(1);
	else
		Perl_Raid_Set_Show_Group_Eight(0);
	end
end

function Perl_Config_Raid_Show_Group_Nine_Update()
	if (Perl_Config_Raid_Frame_CheckButton26:GetChecked() == 1) then
		Perl_Raid_Set_Show_Group_Nine(1);
	else
		Perl_Raid_Set_Show_Group_Nine(0);
	end
end

function Perl_Config_Raid_Sort_By_Class_Update()
	if (Perl_Config_Raid_Frame_CheckButton9:GetChecked() == 1) then
		Perl_Raid_Set_Sort_By_Class(1);
	else
		Perl_Raid_Set_Sort_By_Class(0);
	end
end

function Perl_Config_Raid_Show_Health_Percents_Update()
	if (Perl_Config_Raid_Frame_CheckButton10:GetChecked() == 1) then
		Perl_Raid_Set_Show_Health_Percents(1);
	else
		Perl_Raid_Set_Show_Health_Percents(0);
	end
end

function Perl_Config_Raid_Show_Mana_Percents_Update()
	if (Perl_Config_Raid_Frame_CheckButton27:GetChecked() == 1) then
		Perl_Raid_Set_Show_Mana_Percents(1);
	else
		Perl_Raid_Set_Show_Mana_Percents(0);
	end
end

function Perl_Config_Raid_Lock_Update()
	if (Perl_Config_Raid_Frame_CheckButton11:GetChecked() == 1) then
		Perl_Raid_Set_Lock(1);
	else
		Perl_Raid_Set_Lock(0);
	end
end

function Perl_Config_Raid_Group_Headers_Update()
	if (Perl_Config_Raid_Frame_CheckButton13:GetChecked() == 1) then
		Perl_Raid_Set_Group_Headers(1);
	else
		Perl_Raid_Set_Group_Headers(0);
	end
end

function Perl_Config_Raid_Missing_Health_Update()
	if (Perl_Config_Raid_Frame_CheckButton14:GetChecked() == 1) then
		Perl_Raid_Set_Missing_Health(1);
	else
		Perl_Raid_Set_Missing_Health(0);
	end
end

function Perl_Config_Raid_Vertical_Update()
	if (Perl_Config_Raid_Frame_CheckButton15:GetChecked() == 1) then
		Perl_Raid_Set_Vertical(1);
	else
		Perl_Raid_Set_Vertical(0);
	end
end

function Perl_Config_Raid_Inverted_Update()
	if (Perl_Config_Raid_Frame_CheckButton16:GetChecked() == 1) then
		Perl_Raid_Set_Inverted(1);
	else
		Perl_Raid_Set_Inverted(0);
	end
end

function Perl_Config_Raid_Buffs_Update()
	if (Perl_Config_Raid_Frame_CheckButton17:GetChecked() == 1) then
		Perl_Raid_Set_Buffs(1);
	else
		Perl_Raid_Set_Buffs(0);
	end
end

function Perl_Config_Raid_Debuffs_Update()
	if (Perl_Config_Raid_Frame_CheckButton19:GetChecked() == 1) then
		Perl_Raid_Set_Debuffs(1);
	else
		Perl_Raid_Set_Debuffs(0);
	end
end

function Perl_Config_Raid_Class_Buffs_Update()
	if (Perl_Config_Raid_Frame_CheckButton18:GetChecked() == 1) then
		Perl_Raid_Set_Class_Buffs(1);
	else
		Perl_Raid_Set_Class_Buffs(0);
	end
end

function Perl_Config_Raid_Color_Debuff_Names_Update()
	if (Perl_Config_Raid_Frame_CheckButton20:GetChecked() == 1) then
		Perl_Raid_Set_Color_Debuff_Names(1);
	else
		Perl_Raid_Set_Color_Debuff_Names(0);
	end
end

function Perl_Config_Raid_Alternate_Frame_Style_Update()
	if (Perl_Config_Raid_Frame_CheckButton21:GetChecked() == 1) then
		Perl_Raid_Set_Alternate_Frame_Style(2);
	else
		Perl_Raid_Set_Alternate_Frame_Style(1);
	end
end

function Perl_Config_Raid_Show_Border_Update()
	if (Perl_Config_Raid_Frame_CheckButton22:GetChecked() == 1) then
		Perl_Raid_Set_Show_Border(0);
	else
		Perl_Raid_Set_Show_Border(1);
	end
end

function Perl_Config_Raid_Remove_Space_Update()
	if (Perl_Config_Raid_Frame_CheckButton23:GetChecked() == 1) then
		Perl_Raid_Set_Remove_Space(1);
	else
		Perl_Raid_Set_Remove_Space(0);
	end
end

function Perl_Config_Raid_Hide_Power_Bars_Update()
	if (Perl_Config_Raid_Frame_CheckButton24:GetChecked() == 1) then
		Perl_Raid_Set_Hide_Power_Bars(1);
	else
		Perl_Raid_Set_Hide_Power_Bars(0);
	end
end

function Perl_Config_Raid_CTRA_Style_Tip_Update()
	if (Perl_Config_Raid_Frame_CheckButton25:GetChecked() == 1) then
		Perl_Raid_Set_CTRA_Style_Tip(1);
	else
		Perl_Raid_Set_CTRA_Style_Tip(0);
	end
end

function Perl_Config_Raid_Hide_Empty_Headers_Update()
	if (Perl_Config_Raid_Frame_CheckButton28:GetChecked() == 1) then
		Perl_Raid_Set_Hide_Empty_Headers(1);
	else
		Perl_Raid_Set_Hide_Empty_Headers(0);
	end
end

function Perl_Config_Raid_Set_Scale(value)
	if (Perl_Raid_Frame) then	-- this check is to prevent errors if you aren't using Raid
		if (value == nil) then
			value = floor(UIParent:GetScale()*100+0.5);
			Perl_Config_Raid_Frame_Slider1Text:SetText(value);
			Perl_Config_Raid_Frame_Slider1:SetValue(value);
		end
		Perl_Raid_Set_Scale(value);

		vartable = Perl_Raid_GetVars();
		if (floor(vartable["scale"]*100+0.5) == floor(UIParent:GetScale()*100+0.5)) then
			Perl_Config_Raid_Frame_CheckButton12:SetChecked(1);
		else
			Perl_Config_Raid_Frame_CheckButton12:SetChecked(nil);
		end
	end
end

function Perl_Config_Raid_Set_Transparency(value)
	if (Perl_Raid_Frame) then	-- this check is to prevent errors if you aren't using Raid
		Perl_Raid_Set_Transparency(value);
	end
end