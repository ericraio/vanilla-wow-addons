function Tetris_OF_Button_Click ()
	local button = this:GetName();
	if (button == "Tetris_OF_b_ok") then
		Tetris_OF_Save ();
		Tetris_OF_Toggle();
	end

	if (button == "Tetris_OF_b_exit") then
		Tetris_OF_Toggle();
	end
	
end

function Tetris_OF_Toggle()
	if(Tetris_OF:IsVisible()) then
		Tetris_OF:Hide();
		Tetris_MF_Toggle();
	else
		Tetris_OF_Show();
		Tetris_OF:Show();
	end
end

function Tetris_OF_Show ()
	--variablen holen
	local textur = Tetris["options"]["texturenset"];
	local bgrosse = Tetris["options"]["b_hohe"];
	local gross = Tetris_UBE_OF_s_Text_gross;
	local klein = Tetris_UBE_OF_s_Text_klein;
	local t_bgrosse = Tetris_UBE_OF_Text_bgrosse;
	local gost = Tetris["options"]["gost"];
	local musik_track = Tetris["options"]["musik-track"];
	local sound = Tetris["options"]["sound"];
	local musik = Tetris["options"]["musik"];
	local maus = Tetris["options"]["mous"];
	--dropdownmenu
	UIDropDownMenu_Initialize(Tetris_OF_dropdown, Tetris_OF_dropdown_Initialize);
	UIDropDownMenu_SetSelectedID(Tetris_OF_dropdown, textur);
	UIDropDownMenu_SetWidth(170, Tetris_OF_dropdown);
	--m_dropdownmenu
	UIDropDownMenu_Initialize(Tetris_OF_mdropdown, Tetris_OF_mdropdown_Initialize);
	UIDropDownMenu_SetSelectedID(Tetris_OF_mdropdown, musik_track);
	UIDropDownMenu_SetWidth(170, Tetris_OF_mdropdown);
	--slider bgrosse
	Tetris_OF_s_Text_bgrosse:SetText(t_bgrosse.." "..bgrosse);
	Tetris_OF_s_bgrosse:SetMinMaxValues(10, 25);
	Tetris_OF_s_bgrosse:SetValueStep(1);
	Tetris_OF_s_bgrosse:SetValue(bgrosse);
	getglobal("Tetris_OF_s_bgrosseHigh"):SetText(gross);
	getglobal("Tetris_OF_s_bgrosseLow"):SetText(klein);
	--checkboxen
	Tetris_OF_c_gost:SetChecked(gost);
	Tetris_OF_c_sound:SetChecked(sound);
	Tetris_OF_c_musik:SetChecked(musik);
	Tetris_OF_c_mous:SetChecked(maus);
end

function Tetris_OF_mdropdown_Initialize()
	local info;
	Tetris_musik_list_create();
	for i = 1, getn(Tetris_musik_list), 1 do
		info = {
			text = Tetris_musik_list[i];
			func = Tetris_OF_mdropdown_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

function Tetris_OF_mdropdown_OnClick()
	i = this:GetID();
	UIDropDownMenu_SetSelectedID(Tetris_OF_mdropdown, i);
end

function Tetris_OF_dropdown_Initialize()
	local info;
	Tetris_textur_list_create();
	for i = 1, getn(Tetris_textur_list), 1 do
		info = {
			text = Tetris_textur_list[i];
			func = Tetris_OF_dropdown_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

function Tetris_OF_dropdown_OnClick()
	i = this:GetID();
	UIDropDownMenu_SetSelectedID(Tetris_OF_dropdown, i);
end

function Tetris_OF_Save ()
	--variablen vom frame holen und saven
	Tetris["options"]["texturenset"] = UIDropDownMenu_GetSelectedID(Tetris_OF_dropdown);
	Tetris["options"]["b_hohe"] = Tetris_OF_s_bgrosse:GetValue();
	Tetris["options"]["b_breite"] = Tetris_OF_s_bgrosse:GetValue();
	if (Tetris_OF_c_gost:GetChecked() == 1) then
		Tetris["options"]["gost"]=1;
	else
		Tetris["options"]["gost"]=0;
	end	
	if (Tetris_OF_c_musik:GetChecked() == 1) then
		Tetris["options"]["musik"]=1;
	else
		Tetris_play_musik ("stop");
		Tetris["options"]["musik"]=0;
	end	
	if (Tetris_OF_c_sound:GetChecked() == 1) then
		Tetris["options"]["sound"]=1;
	else
		Tetris["options"]["sound"]=0;
	end	
	if (Tetris_OF_c_mous:GetChecked() == 1) then
		Tetris["options"]["mous"]=1;
	else
		Tetris["options"]["mous"]=0;
	end	
	Tetris["options"]["musik-track"] = UIDropDownMenu_GetSelectedID(Tetris_OF_mdropdown);
end

function Tetris_OF_Update()
	--variablen holen
	local textur = Tetris["options"]["texturenset"];
	local t_bgrosse = Tetris_UBE_OF_Text_bgrosse;
	local s_name = this:GetName();
	--slider geändert
	if (s_name == "Tetris_OF_s_bgrosse") then
		local z = getglobal(s_name):GetValue();
		getglobal ("Tetris_OF_s_Text_bgrosse"):SetText(t_bgrosse.." "..z);
	end	
end
