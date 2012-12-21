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

	if (vartable["sortraidbyclass"] == 1) then
		Perl_Config_Raid_Frame_CheckButton9:SetChecked(1);
	else
		Perl_Config_Raid_Frame_CheckButton9:SetChecked(nil);
	end

	if (vartable["showpercents"] == 1) then
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

	Perl_Config_Raid_Frame_Slider1Low:SetText("Small");
	Perl_Config_Raid_Frame_Slider1High:SetText("Big");
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

function Perl_Config_Raid_Sort_By_Class_Update()
	if (Perl_Config_Raid_Frame_CheckButton9:GetChecked() == 1) then
		Perl_Raid_Set_Sort_By_Class(1);
	else
		Perl_Raid_Set_Sort_By_Class(0);
	end
end

function Perl_Config_Raid_Show_Percents_Update()
	if (Perl_Config_Raid_Frame_CheckButton10:GetChecked() == 1) then
		Perl_Raid_Set_Show_Percents(1);
	else
		Perl_Raid_Set_Show_Percents(0);
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
	if (Perl_Raid_Frame) then	-- this check is to prevent errors if you aren't using Player
		Perl_Raid_Set_Transparency(value);
	end
end