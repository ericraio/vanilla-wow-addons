function Perl_Config_Party_Pet_Display()
	Perl_Config_Hide_All();
	if (Perl_Party_Pet_Script_Frame) then
		Perl_Config_Party_Pet_Frame:Show();
		Perl_Config_Party_Pet_Set_Values();
	else
		Perl_Config_Party_Pet_Frame:Hide();
		Perl_Config_NotInstalled_Frame:Show();
	end
end

function Perl_Config_Party_Pet_Set_Values()
	local vartable = Perl_Party_Pet_GetVars();

	Perl_Config_Party_Pet_Frame_Slider1Low:SetText("Small");
	Perl_Config_Party_Pet_Frame_Slider1High:SetText("Big");
	Perl_Config_Party_Pet_Frame_Slider1:SetValue(floor(vartable["scale"]*100+0.5));

	if (floor(vartable["scale"]*100+0.5) == floor(UIParent:GetScale()*100+0.5)) then
		Perl_Config_Party_Pet_Frame_CheckButton1:SetChecked(1);
	else
		Perl_Config_Party_Pet_Frame_CheckButton1:SetChecked(nil);
	end

	Perl_Config_Party_Pet_Frame_Slider2Low:SetText("0");
	Perl_Config_Party_Pet_Frame_Slider2High:SetText("100");
	Perl_Config_Party_Pet_Frame_Slider2:SetValue(vartable["transparency"]*100);

	Perl_Config_Party_Pet_Frame_Slider3Low:SetText("0");
	Perl_Config_Party_Pet_Frame_Slider3High:SetText("16");
	Perl_Config_Party_Pet_Frame_Slider3:SetValue(vartable["numpetbuffsshown"]);

	Perl_Config_Party_Pet_Frame_Slider4Low:SetText("0");
	Perl_Config_Party_Pet_Frame_Slider4High:SetText("16");
	Perl_Config_Party_Pet_Frame_Slider4:SetValue(vartable["numpetdebuffsshown"]);

	Perl_Config_Party_Pet_Frame_Slider5Low:SetText("1");
	Perl_Config_Party_Pet_Frame_Slider5High:SetText("50");
	Perl_Config_Party_Pet_Frame_Slider5:SetValue(vartable["buffsize"]);

	Perl_Config_Party_Pet_Frame_Slider6Low:SetText("1");
	Perl_Config_Party_Pet_Frame_Slider6High:SetText("50");
	Perl_Config_Party_Pet_Frame_Slider6:SetValue(vartable["debuffsize"]);

	Perl_Config_Party_Pet_Frame_Slider7Low:SetText("1");
	Perl_Config_Party_Pet_Frame_Slider7High:SetText("5");
	Perl_Config_Party_Pet_Frame_Slider7:SetValue(vartable["bufflocation"]);

	Perl_Config_Party_Pet_Frame_Slider8Low:SetText("1");
	Perl_Config_Party_Pet_Frame_Slider8High:SetText("5");
	Perl_Config_Party_Pet_Frame_Slider8:SetValue(vartable["debufflocation"]);

	if (vartable["showportrait"] == 1) then
		Perl_Config_Party_Pet_Frame_CheckButton2:SetChecked(1);
	else
		Perl_Config_Party_Pet_Frame_CheckButton2:SetChecked(nil);
	end

	if (vartable["threedportrait"] == 1) then
		Perl_Config_Party_Pet_Frame_CheckButton3:SetChecked(1);
	else
		Perl_Config_Party_Pet_Frame_CheckButton3:SetChecked(nil);
	end

	if (vartable["locked"] == 1) then
		Perl_Config_Party_Pet_Frame_CheckButton4:SetChecked(1);
	else
		Perl_Config_Party_Pet_Frame_CheckButton4:SetChecked(nil);
	end

	if (vartable["hiddeninraids"] == 1) then
		Perl_Config_Party_Pet_Frame_CheckButton5:SetChecked(1);
	else
		Perl_Config_Party_Pet_Frame_CheckButton5:SetChecked(nil);
	end
end

function Perl_Config_Party_Pet_Portrait_Update()
	if (Perl_Config_Party_Pet_Frame_CheckButton2:GetChecked() == 1) then
		Perl_Party_Pet_Set_Portrait(1);
	else
		Perl_Party_Pet_Set_Portrait(0);
	end
end

function Perl_Config_Party_Pet_3D_Portrait_Update()
	if (Perl_Config_Party_Pet_Frame_CheckButton3:GetChecked() == 1) then
		Perl_Party_Pet_Set_3D_Portrait(1);
	else
		Perl_Party_Pet_Set_3D_Portrait(0);
	end
end

function Perl_Config_Party_Pet_Lock_Update()
	if (Perl_Config_Party_Pet_Frame_CheckButton4:GetChecked() == 1) then
		Perl_Party_Pet_Set_Lock(1);
	else
		Perl_Party_Pet_Set_Lock(0);
	end
end

function Perl_Config_Party_Pet_Hidden_Update()
	if (Perl_Config_Party_Pet_Frame_CheckButton5:GetChecked() == 1) then
		Perl_Party_Pet_Set_Hidden(1);
	else
		Perl_Party_Pet_Set_Hidden(0);
	end
end

function Perl_Config_Party_Pet_Set_Buffs(value)
	if (Perl_Party_Pet_Script_Frame) then		-- this check is to prevent errors if you aren't using Party_Pet
		Perl_Party_Pet_Set_Buffs(value);
	end
end

function Perl_Config_Party_Pet_Set_Debuffs(value)
	if (Perl_Party_Pet_Script_Frame) then		-- this check is to prevent errors if you aren't using Party_Pet
		Perl_Party_Pet_Set_Debuffs(value);
	end
end

function Perl_Config_Party_Pet_Set_Buff_Size(value)
	if (Perl_Party_Pet_Script_Frame) then		-- this check is to prevent errors if you aren't using Party_Pet
		Perl_Party_Pet_Set_Buff_Size(value);
	end
end

function Perl_Config_Party_Pet_Set_Debuff_Size(value)
	if (Perl_Party_Pet_Script_Frame) then		-- this check is to prevent errors if you aren't using Party_Pet
		Perl_Party_Pet_Set_Debuff_Size(value);
	end
end

function Perl_Config_Party_Pet_Set_Buff_Location(value)
	if (Perl_Party_Pet_Script_Frame) then		-- this check is to prevent errors if you aren't using Party_Pet
		Perl_Party_Pet_Set_Buff_Location(value);
	end
end

function Perl_Config_Party_Pet_Set_Debuff_Location(value)
	if (Perl_Party_Pet_Script_Frame) then		-- this check is to prevent errors if you aren't using Party_Pet
		Perl_Party_Pet_Set_Debuff_Location(value);
	end
end

function Perl_Config_Party_Pet_Set_Scale(value)
	if (Perl_Party_Pet_Script_Frame) then		-- this check is to prevent errors if you aren't using Party_Pet
		if (value == nil) then
			value = floor(UIParent:GetScale()*100+0.5);
			Perl_Config_Party_Pet_Frame_Slider1Text:SetText(value);
			Perl_Config_Party_Pet_Frame_Slider1:SetValue(value);
		end
		Perl_Party_Pet_Set_Scale(value);

		vartable = Perl_Party_Pet_GetVars();
		if (floor(vartable["scale"]*100+0.5) == floor(UIParent:GetScale()*100+0.5)) then
			Perl_Config_Party_Pet_Frame_CheckButton1:SetChecked(1);
		else
			Perl_Config_Party_Pet_Frame_CheckButton1:SetChecked(nil);
		end
	end
end

function Perl_Config_Party_Pet_Set_Transparency(value)
	if (Perl_Party_Pet_Script_Frame) then		-- this check is to prevent errors if you aren't using Party_Pet
		Perl_Party_Pet_Set_Transparency(value);
	end
end