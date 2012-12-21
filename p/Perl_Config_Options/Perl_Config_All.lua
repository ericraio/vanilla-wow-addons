function Perl_Config_All_Display()
	Perl_Config_Hide_All();
	Perl_Config_All_Frame:Show();
	Perl_Config_All_Set_Values();
end

function Perl_Config_All_Set_Values()
	local vartable = Perl_Config_GetVars();

	if (vartable["texture"] ~= nil) then
		Perl_Config_All_Frame_CheckButton1:SetChecked(nil);
		Perl_Config_All_Frame_CheckButton2:SetChecked(nil);
		Perl_Config_All_Frame_CheckButton3:SetChecked(nil);
		Perl_Config_All_Frame_CheckButton4:SetChecked(nil);
		Perl_Config_All_Frame_CheckButton5:SetChecked(nil);
		Perl_Config_All_Frame_CheckButton6:SetChecked(nil);
		Perl_Config_All_Frame_CheckButton7:SetChecked(nil);

		local num = vartable["texture"];
		if (num == 0) then
			num = 7;
		end
		Perl_Config_All_Frame_CheckButton7:SetChecked(nil);
		getglobal("Perl_Config_All_Frame_CheckButton"..num):SetChecked(1);
	end

	Perl_Config_All_Frame_Slider1Low:SetText(PERL_LOCALIZED_CONFIG_SMALL);
	Perl_Config_All_Frame_Slider1High:SetText(PERL_LOCALIZED_CONFIG_BIG);
	--Perl_Config_All_Frame_Slider1:SetValue(nil);			-- Figure out how to get the slider to poof on every open
	--Perl_Config_All_Frame_CheckButton7:SetChecked(nil);		-- We want a clean scale bar when opening the frame since nothing is saved or loaded for it

	Perl_Config_All_Frame_Slider2Low:SetText("0");
	Perl_Config_All_Frame_Slider2High:SetText("100");

	Perl_Config_All_Frame_Slider3Low:SetText("0");
	Perl_Config_All_Frame_Slider3High:SetText("360");
	Perl_Config_All_Frame_Slider3:SetValue(vartable["minimapbuttonpos"]);

	if (vartable["showminimapbutton"] == 1) then
		Perl_Config_All_Frame_CheckButton8:SetChecked(1);
	else
		Perl_Config_All_Frame_CheckButton8:SetChecked(nil);
	end

	if (vartable["transparentbackground"] == 1) then
		Perl_Config_All_Frame_CheckButton9:SetChecked(1);
	else
		Perl_Config_All_Frame_CheckButton9:SetChecked(nil);
	end

	if (vartable["PCUF_CastPartySupport"] == 1) then
		Perl_Config_All_Frame_CheckButton10:SetChecked(1);
	else
		Perl_Config_All_Frame_CheckButton10:SetChecked(nil);
	end

	if (vartable["PCUF_ColorHealth"] == 1) then
		Perl_Config_All_Frame_CheckButton11:SetChecked(1);
	else
		Perl_Config_All_Frame_CheckButton11:SetChecked(nil);
	end

	if (vartable["texturedbarbackground"] == 1) then
		Perl_Config_All_Frame_CheckButton13:SetChecked(1);
	else
		Perl_Config_All_Frame_CheckButton13:SetChecked(nil);
	end

	if (vartable["PCUF_FadeBars"] == 1) then
		Perl_Config_All_Frame_CheckButton14:SetChecked(1);
	else
		Perl_Config_All_Frame_CheckButton14:SetChecked(nil);
	end

	if (vartable["PCUF_NameFrameClickCast"] == 1) then
		Perl_Config_All_Frame_CheckButton15:SetChecked(1);
	else
		Perl_Config_All_Frame_CheckButton15:SetChecked(nil);
	end

	if (vartable["PCUF_InvertBarValues"] == 1) then
		Perl_Config_All_Frame_CheckButton16:SetChecked(1);
	else
		Perl_Config_All_Frame_CheckButton16:SetChecked(nil);
	end
end

function Perl_Config_All_Texture_Update(texturenum)
	if (Perl_Config_All_Frame_CheckButton1:GetChecked() == 1 or Perl_Config_All_Frame_CheckButton2:GetChecked() == 1 or Perl_Config_All_Frame_CheckButton3:GetChecked() == 1 or Perl_Config_All_Frame_CheckButton4:GetChecked() == 1 or Perl_Config_All_Frame_CheckButton5:GetChecked() == 1 or Perl_Config_All_Frame_CheckButton6:GetChecked() == 1) then
		-- do nothing
	else
		Perl_Config_All_Frame_CheckButton7:SetChecked(1);
		texturenum = 0;
	end

	Perl_Config_Set_Texture(texturenum);		-- Go save the value and texture the bars
end

function Perl_Config_All_Set_Scale(value)
	if (value == nil) then
		value = floor(UIParent:GetScale()*100+0.5);
		Perl_Config_All_Frame_Slider1Text:SetText(value);
		Perl_Config_All_Frame_Slider1:SetValue(value);
	end

	if (floor(value+0.5) == floor(UIParent:GetScale()*100+0.5)) then
		Perl_Config_All_Frame_CheckButton12:SetChecked(1);
	else
		Perl_Config_All_Frame_CheckButton12:SetChecked(nil);
	end

	if (Perl_CombatDisplay_Frame) then
		Perl_CombatDisplay_Set_Scale(value);
	end

	if (Perl_Party_Frame) then
		Perl_Party_Set_Scale(value);
	end

	if (Perl_Party_Pet_Script_Frame) then
		Perl_Party_Pet_Set_Scale(value);
	end

	if (Perl_Party_Target_Script_Frame) then
		Perl_Party_Target_Set_Scale(value);
	end

	if (Perl_Player_Frame) then
		Perl_Player_Set_Scale(value);
	end

	if (Perl_Player_Buff_Script_Frame) then
		Perl_Player_Buff_Set_Scale(value);
	end

	if (Perl_Player_Pet_Frame) then
		Perl_Player_Pet_Set_Scale(value);
	end

	if (Perl_Raid_Frame) then
		Perl_Raid_Set_Scale(value);
	end

	if (Perl_Target_Frame) then
		Perl_Target_Set_Scale(value);
	end

	if (Perl_Target_Target_Script_Frame) then
		Perl_Target_Target_Set_Scale(value);
	end
end

function Perl_Config_All_Set_Transparency(value)
	Perl_Config_Set_Transparency(value);
end

function Perl_Config_All_Set_MiniMap_Button()
	if (Perl_Config_All_Frame_CheckButton8:GetChecked() == 1) then
		Perl_Config_Set_MiniMap_Button(1);
	else
		Perl_Config_Set_MiniMap_Button(0);
	end
end

function Perl_Config_All_Set_MiniMap_Position(value)
	Perl_Config_Set_MiniMap_Position(value);
end

function Perl_Config_All_Set_Transparent_Background()
	if (Perl_Config_All_Frame_CheckButton9:GetChecked() == 1) then
		Perl_Config_Set_Background(1);
	else
		Perl_Config_Set_Background(0);
	end
end

function Perl_Config_All_Set_CastParty_Support()
	if (Perl_Config_All_Frame_CheckButton10:GetChecked() == 1) then
		Perl_Config_Set_CastParty_Support(1);
	else
		Perl_Config_Set_CastParty_Support(0);
	end
end

function Perl_Config_All_Set_Color_Health()
	if (Perl_Config_All_Frame_CheckButton11:GetChecked() == 1) then
		Perl_Config_Set_Color_Health(1);
	else
		Perl_Config_Set_Color_Health(0);
	end
end

function Perl_Config_All_Set_Textured_Bar_Background()
	if (Perl_Config_All_Frame_CheckButton13:GetChecked() == 1) then
		Perl_Config_Set_Textured_Bar_Background(1);
	else
		Perl_Config_Set_Textured_Bar_Background(0);
	end
end

function Perl_Config_All_Set_Fade_Bars()
	if (Perl_Config_All_Frame_CheckButton14:GetChecked() == 1) then
		Perl_Config_Set_Fade_Bars(1);
	else
		Perl_Config_Set_Fade_Bars(0);
	end
end

function Perl_Config_All_Set_Name_Frame_Click_Cast()
	if (Perl_Config_All_Frame_CheckButton15:GetChecked() == 1) then
		Perl_Config_Set_Name_Frame_Click_Cast(1);
	else
		Perl_Config_Set_Name_Frame_Click_Cast(0);
	end
end

function Perl_Config_All_Set_Invert_Bar_Values()
	if (Perl_Config_All_Frame_CheckButton16:GetChecked() == 1) then
		Perl_Config_Set_Invert_Bar_Values(1);
	else
		Perl_Config_Set_Invert_Bar_Values(0);
	end
end