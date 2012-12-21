function Perl_Config_ArcaneBar_Display()
	Perl_Config_Hide_All();
	if (Perl_ArcaneBar_Frame_Loaded_Frame) then
		Perl_Config_ArcaneBar_Frame:Show();
		Perl_Config_ArcaneBar_Set_Values();
	else
		Perl_Config_ArcaneBar_Frame:Hide();
		Perl_Config_NotInstalled_Frame:Show();
	end
end

function Perl_Config_ArcaneBar_Set_Values()
	local vartable = Perl_ArcaneBar_GetVars();

	if (vartable["enabled"] == 1) then
		Perl_Config_ArcaneBar_Frame_CheckButton1:SetChecked(1);
	else
		Perl_Config_ArcaneBar_Frame_CheckButton1:SetChecked(nil);
	end

	if (vartable["showtimer"] == 1) then
		Perl_Config_ArcaneBar_Frame_CheckButton2:SetChecked(1);
	else
		Perl_Config_ArcaneBar_Frame_CheckButton2:SetChecked(nil);
	end

	if (vartable["hideoriginal"] == 1) then
		Perl_Config_ArcaneBar_Frame_CheckButton3:SetChecked(1);
	else
		Perl_Config_ArcaneBar_Frame_CheckButton3:SetChecked(nil);
	end

	if (vartable["namereplace"] == 1) then
		Perl_Config_ArcaneBar_Frame_CheckButton4:SetChecked(1);
	else
		Perl_Config_ArcaneBar_Frame_CheckButton4:SetChecked(nil);
	end

	if (vartable["lefttimer"] == 1) then
		Perl_Config_ArcaneBar_Frame_CheckButton5:SetChecked(1);
	else
		Perl_Config_ArcaneBar_Frame_CheckButton5:SetChecked(nil);
	end

	Perl_Config_ArcaneBar_Frame_Slider1Low:SetText("0");
	Perl_Config_ArcaneBar_Frame_Slider1High:SetText("100");
	Perl_Config_ArcaneBar_Frame_Slider1:SetValue(vartable["transparency"]*100);
end

function Perl_Config_ArcaneBar_Enabled_Update()
	if (Perl_Config_ArcaneBar_Frame_CheckButton1:GetChecked() == 1) then
		Perl_ArcaneBar_Set_Enabled(1);
	else
		Perl_ArcaneBar_Set_Enabled(0);
	end
end

function Perl_Config_ArcaneBar_Show_Timer_Update()
	if (Perl_Config_ArcaneBar_Frame_CheckButton2:GetChecked() == 1) then
		Perl_ArcaneBar_Set_Timer(1);
	else
		Perl_ArcaneBar_Set_Timer(0);
	end
end

function Perl_Config_ArcaneBar_Hide_Original_Update()
	if (Perl_Config_ArcaneBar_Frame_CheckButton3:GetChecked() == 1) then
		Perl_ArcaneBar_Set_Hide(1);
	else
		Perl_ArcaneBar_Set_Hide(0);
	end
end

function Perl_Config_ArcaneBar_Name_Replace_Update()
	if (Perl_Config_ArcaneBar_Frame_CheckButton4:GetChecked() == 1) then
		Perl_ArcaneBar_Set_Name_Replace(1);
	else
		Perl_ArcaneBar_Set_Name_Replace(0);
	end
end

function Perl_Config_ArcaneBar_Left_Timer_Update()
	if (Perl_Config_ArcaneBar_Frame_CheckButton5:GetChecked() == 1) then
		Perl_ArcaneBar_Set_Left_Timer(1);
	else
		Perl_ArcaneBar_Set_Left_Timer(0);
	end
end

function Perl_Config_ArcaneBar_Set_Transparency(value)
	if (Perl_ArcaneBar_Frame_Loaded_Frame) then	-- this check is to prevent errors if you aren't using ArcaneBar
		Perl_ArcaneBar_Set_Transparency(value);
	end
end