function Tetris_CF_Toggle()
	if(Tetris_CF:IsVisible()) then
		Tetris_CF:Hide();
	else
		Tetris_CF_Show();
		Tetris_CF:Show();
	end
end

function Tetris_CF_Show()
	--variablen holen und setzen
	local x = Tetris["options"]["breite"];
	local y = Tetris["options"]["hohe"];
	local t_y = Tetris_UBE_CF_Text_hohe;
	local t_x = Tetris_UBE_CF_Text_breite;
	local viel = Tetris_UBE_CF_s_Text_viel;
	local wenig = Tetris_UBE_CF_s_Text_wenig;
	local r_on = Tetris_UBE_CF_Text_r_lines_on;
	local r_off = Tetris_UBE_CF_Text_r_lines_off;
	local r_lines = Tetris["options"]["r_lines"];
	local r_act = Tetris["options"]["r_lines_activ"];
	local gametyp = Tetris["options"]["gametyp"];

	--slider höhe
	Tetris_CF_s_Text_hohe:SetText(t_y.." "..y);
	Tetris_CF_s_hohe:SetMinMaxValues(8, 50);
	Tetris_CF_s_hohe:SetValueStep(1);
	Tetris_CF_s_hohe:SetValue(y);
	getglobal("Tetris_CF_s_hoheHigh"):SetText(viel);
	getglobal("Tetris_CF_s_hoheLow"):SetText(wenig);		
	--slider breite
	Tetris_CF_s_Text_breite:SetText(t_x.." "..x);
	Tetris_CF_s_breite:SetMinMaxValues(4, 50);
	Tetris_CF_s_breite:SetValueStep(1);
	Tetris_CF_s_breite:SetValue(x);
	getglobal("Tetris_CF_s_breiteHigh"):SetText(viel);
	getglobal("Tetris_CF_s_breiteLow"):SetText(wenig);
	--slider r_linien und checkbox
	--falls r_linien abgeschaltet ist
	if (r_act==0) then
		Tetris_CF_s_Text_r_lines:SetText(r_off);	
		Tetris_CF_c_r_lines:SetChecked(0);
	else
		Tetris_CF_s_Text_r_lines:SetText(r_on.." "..r_lines);
		Tetris_CF_c_r_lines:SetChecked(1);
	end
	Tetris_CF_s_r_lines:SetMinMaxValues(1, y-5);
	Tetris_CF_s_r_lines:SetValueStep(1);
	Tetris_CF_s_r_lines:SetValue(r_lines);
	getglobal("Tetris_CF_s_r_linesHigh"):SetText(viel);
	getglobal("Tetris_CF_s_r_linesLow"):SetText(wenig);
	--dropdownmenu
	UIDropDownMenu_Initialize(Tetris_CF_dropdown, Tetris_CF_dropdown_Initialize);
	UIDropDownMenu_SetSelectedID(Tetris_CF_dropdown, gametyp);
	UIDropDownMenu_SetWidth(170, Tetris_CF_dropdown);
end

function Tetris_CF_dropdown_Initialize()
	local info;
	Tetris_gametyp_list_create();
	for i = 1, getn(Tetris_gametyp_list), 1 do
		info = {
			text = Tetris_gametyp_list[i];
			func = Tetris_CF_dropdown_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

function Tetris_CF_dropdown_OnClick()
	i = this:GetID();
	UIDropDownMenu_SetSelectedID(Tetris_CF_dropdown, i);
end

function Tetris_CF_Update()
	--variablen holen und setzen
	local t_y = Tetris_UBE_CF_Text_hohe;
	local t_x = Tetris_UBE_CF_Text_breite;
	local r_on = Tetris_UBE_CF_Text_r_lines_on;
	local r_off = Tetris_UBE_CF_Text_r_lines_off;
	local s_name = this:GetName();
	--name des veränderten slider updaten
	if (s_name == "Tetris_CF_s_hohe") then
		local z = getglobal(s_name):GetValue();
		getglobal ("Tetris_CF_s_Text_hohe"):SetText(t_y.." "..z);
		--höhe hat sich geändert, ist die einstellung von r_lines zuläsig?
		if	(Tetris_CF_s_r_lines:GetValue()>(z-5)) then
			Tetris_CF_s_r_lines:SetValue(z-5);
		end
		Tetris_CF_s_r_lines:SetMinMaxValues(1, z-5);
	end
	if (s_name == "Tetris_CF_s_breite") then
		local z = getglobal(s_name):GetValue();
		getglobal ("Tetris_CF_s_Text_breite"):SetText(t_x.." "..z);
	end
	if (s_name == "Tetris_CF_s_r_lines") then
		local z = getglobal(s_name):GetValue();
		local checkstatus = Tetris_CF_c_r_lines:GetChecked();
		if (checkstatus == 1) then
			Tetris_CF_s_Text_r_lines:SetText(r_on.." "..z);
		end
	end	
	--wenn c_r_lines geändert wurde
	if (s_name == "Tetris_CF_c_r_lines") then
		local checkstatus = Tetris_CF_c_r_lines:GetChecked();
		if (checkstatus == 1) then
			local value = Tetris_CF_s_r_lines:GetValue();
			Tetris_CF_s_Text_r_lines:SetText(r_on.." "..value);
		else
			Tetris_CF_s_Text_r_lines:SetText(r_off);
		end
	end	
end

function Tetris_CF_b_Click()
	--variablen holen und setzen
	local b_name = this:GetName();
	
	--saven und spiel starten
	if (b_name == "Tetris_CF_b_Ok") then
		Tetris_CF_Save();
		Tetris_newgame_custom();
		Tetris_CF_Toggle();
		Tetris_GF_Toggle();
	end
	--exit ohne save
	if (b_name == "Tetris_CF_b_Exit") then
		Tetris_CF_Toggle();
		Tetris_MF_Toggle();	
	end
	--stone menu anzeigen
	if (b_name == "Tetris_CF_b_StoneSetup") then
		Tetris_CF_Save();
		Tetris_CF_Toggle();
		Tetris_SOF_Toggle();		
	end
	
end

function Tetris_CF_Save()
	--variablen vom frame holen und saven
	Tetris["options"]["hohe"] = Tetris_CF_s_hohe:GetValue();
	Tetris["options"]["breite"] = Tetris_CF_s_breite:GetValue();
	Tetris["options"]["r_lines"] = Tetris_CF_s_r_lines:GetValue();
	if (Tetris_CF_c_r_lines:GetChecked() == 1) then
		Tetris["options"]["r_lines_activ"] = 1;
	else
		Tetris["options"]["r_lines_activ"] = 0;
	end	
	Tetris["options"]["gametyp"] = UIDropDownMenu_GetSelectedID(Tetris_CF_dropdown);
end
