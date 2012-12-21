if ( CT_AddMovable ) then
	CT_AddMovable("CT_PlayerFrame_Drag", CT_PLAYERFRAME_MOVABLE, "TOPLEFT", "TOPLEFT", "UIParent", 97, -25, function(status)
		if ( status ) then
			CT_PlayerFrame_Drag:Show();
		else
			CT_PlayerFrame_Drag:Hide();
		end
	end);
end

function CT_PlayerFrameOnLoad()

	this:RegisterEvent("UNIT_MANA");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_RAGE");
	this:RegisterEvent("UNIT_FOCUS");
	this:RegisterEvent("UNIT_ENERGY");
	this:RegisterEvent("UNIT_DISPLAYPOWER");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("UPDATE_SHAPESHIFT_FORMS");
end

function CT_UnitFrames_LinkFrameDrag(frame, drag, point, relative, x, y)
	frame:ClearAllPoints();
	frame:SetPoint(point, drag:GetName(), relative, x, y);
end

function CT_PlayerFrameOnEvent (event)

	if ( event == "PLAYER_ENTERING_WORLD" or ( event == "UNIT_DISPLAYPOWER" and arg1 == "player" ) ) then
		CT_ShowPlayerHealth();
		CT_ShowPlayerMana();
		CT_PlayerFrame_UpdateSBT();
		return;
	end

	if( event == "UNIT_HEALTH" and arg1 == "player" ) then
		CT_ShowPlayerHealth();
		CT_PlayerFrame_UpdateSBT();
		return;
	elseif ( event == "UNIT_HEALTH" and arg1 == "pet" ) then
		CT_ChangePetHealthBar();
		return;
	end
	
	if( ( event == "UNIT_MANA" or event == "UNIT_RAGE" or event == "UNIT_FOCUS" or event == "UNIT_ENERGY" or event == "UPDATE_SHAPESHIFT_FORMS" ) and arg1 == "player" ) then
		CT_ShowPlayerMana();
		CT_PlayerFrame_UpdateSBT();
		return;
	end

	if ( event == "VARIABLES_LOADED" ) then
		CT_PlayerFrame_UpdateSBT();
	end
end

function CT_PlayerFrame_ShallDisplay(offset)
	return CT_UnitFramesOptions.styles[1][offset][1];
end

function CT_PlayerFrame_GetHealth(id)
	if ( not UnitExists("player") ) then
		return "";
	end
	if ( id == 2 ) then
		return floor(( UnitHealth("player") or 1 ) / ( UnitHealthMax("player") or 1)*100) .. "%";
	elseif ( id == 3 ) then
		local deficit = ( UnitHealth("player") or 1 ) - ( UnitHealthMax("player") or 1 );
		if ( deficit == 0 ) then
			deficit = "";
		end
		return deficit;
	elseif ( id == 4 ) then
		return ( UnitHealth("player") or "?" ) .. "/" .. ( UnitHealthMax("player") or "?" );
	end
end

function CT_PlayerFrame_GetMana(id)
	if ( not UnitExists("player") ) then
		return "";
	end
	if ( id == 2 ) then
		return floor(( UnitMana("player") or 1 ) / ( UnitManaMax("player") or 1)*100) .. "%";
	elseif ( id == 3 ) then
		local deficit = ( UnitMana("player") or 1 ) - ( UnitManaMax("player") or 1 );
		if ( deficit == 0 ) then
			deficit = "";
		end
		return deficit;
	elseif ( id == 4 ) then
		return ( UnitMana("player") or "?" ) .. "/" .. ( UnitManaMax("player") or "?" );
	end
end

function CT_ShowPlayerHealth()
	if ( not UnitExists("player") ) then
		return "";
	end
	local typeOnHealth, typeRightHealth = CT_PlayerFrame_ShallDisplay(1), CT_PlayerFrame_ShallDisplay(2);
	if ( typeOnHealth > 1 ) then
		CT_PlayerHealthBar:Show();
		CT_PlayerHealthBar:SetText(CT_PlayerFrame_GetHealth(typeOnHealth));
	else
		CT_PlayerHealthBar:Hide();
	end
	if ( typeRightHealth > 1 ) then
		CT_PlayerHealthRight:SetText(CT_PlayerFrame_GetHealth(typeRightHealth));
		CT_PlayerHealthRight:Show();
	else
		CT_PlayerHealthRight:Hide();
	end
	CT_PlayerHealthBar:SetTextColor(CT_UnitFramesOptions.styles[1][1][2], CT_UnitFramesOptions.styles[1][1][3], CT_UnitFramesOptions.styles[1][1][4], CT_UnitFramesOptions.styles[1][1][5]);
	CT_PlayerHealthRight:SetTextColor(CT_UnitFramesOptions.styles[1][2][2], CT_UnitFramesOptions.styles[1][2][3], CT_UnitFramesOptions.styles[1][2][4], CT_UnitFramesOptions.styles[1][2][5]);
	local hp = UnitHealth("player") / UnitHealthMax("player");
	local r, g = 1, 1;
	if ( hp > 0.5 ) then
		r = (1.0 - hp) * 2;
		g = 1.0;
	else
		r = 1.0;
		g = hp * 2;
	end
	if ( r < 0 ) then r = 0; elseif ( r > 1 ) then r = 1; end
	if ( g < 0 ) then g = 0; elseif ( g > 1 ) then g = 1; end
	PlayerFrameHealthBar:SetStatusBarColor(r, g, 0);
end

function CT_ShowPlayerMana()
	if ( not UnitExists("player") ) then
		return "";
	end
	local typeOnMana, typeRightMana = CT_PlayerFrame_ShallDisplay(3), CT_PlayerFrame_ShallDisplay(4);
	if ( typeOnMana > 1 ) then
		CT_PlayerManaBar:SetText(CT_PlayerFrame_GetMana(typeOnMana));
		CT_PlayerManaBar:Show();
	else
		CT_PlayerManaBar:Hide();
	end
	if ( typeRightMana > 1 ) then
		CT_PlayerManaRight:SetText(CT_PlayerFrame_GetMana(typeRightMana));
		CT_PlayerManaRight:Show();
	else
		CT_PlayerManaRight:Hide();
	end
	CT_PlayerManaBar:SetTextColor(CT_UnitFramesOptions.styles[1][3][2], CT_UnitFramesOptions.styles[1][3][3], CT_UnitFramesOptions.styles[1][3][4], CT_UnitFramesOptions.styles[1][3][5]);
	CT_PlayerManaRight:SetTextColor(CT_UnitFramesOptions.styles[1][4][2], CT_UnitFramesOptions.styles[1][4][3], CT_UnitFramesOptions.styles[1][4][4], CT_UnitFramesOptions.styles[1][4][5]);
end

function CT_ChangePetHealthBar()
	if ( not UnitExists("pet") ) then
		return;
	end
	local hp = UnitHealth("pet") / UnitHealthMax("pet");
	local r, g = 1, 1;
	if ( hp ) then
		if ( hp > 0 ) then
			if ( hp > 0.5 ) then
				r = (1.0 - hp) * 2;
				g = 1.0;
			else
				r = 1.0;
				g = hp * 2;
			end
		else
			r = 0; g = 1;
		end
	else
		r = 0; g = 1;
	end
	if ( r < 0 ) then r = 0; elseif ( r > 1 ) then r = 1; end
	if ( g < 0 ) then g = 0; elseif ( g > 1 ) then g = 1; end
	PetFrameHealthBar:SetStatusBarColor(r, g, 0);
end

CT_oldTSB_OE = TextStatusBar_OnEvent;

function CT_TextStatusBar_OnEvent(cvar, value)
	if ( event == "CVAR_UPDATE" and cvar == "STATUS_BAR_TEXT" and ( this == PlayerFrameHealthBar or this == PlayerFrameManaBar ) ) then
		CT_PlayerFrame_UpdateSBT();
		return;
	end
	CT_oldTSB_OE(cvar, value);
end

TextStatusBar_OnEvent = CT_TextStatusBar_OnEvent;

function CT_PlayerFrame_UpdateSBT()
	local bar1 = PlayerFrameHealthBar;
	local bar2 = PlayerFrameManaBar;

	local shallDisplay = true;
	if ( CT_PlayerFrame_ShallDisplay(1) > 1 ) then
		bar1.textLockable = nil;
		bar1.TextString:Hide();
		shallDisplay = false;
	end
	if ( CT_PlayerFrame_ShallDisplay(3) > 1 ) then
		bar2.textLockable = nil;
		bar2.TextString:Hide();
		shallDisplay = false;
	end
	if ( GetCVar("STATUSBARTEXT") == "0" ) then

		bar1.textLockable = nil;
		bar2.textLockable = nil;

		bar1.TextString:Hide();
		bar2.TextString:Hide();

	elseif ( GetCVar("STATUSBARTEXT") == "1" and shallDisplay ) then

		bar1.textLockable = 1;
		bar2.textLockable = 1;

		bar1.TextString:Show();
		bar2.TextString:Show();
		
		ShowTextStatusBarText(PlayerFrameHealthBar);
		ShowTextStatusBarText(PlayerFrameManaBar);

	end
end

CT_OldShowTextStatusBarText = ShowTextStatusBarText;
function CT_ShowTextStatusBarText(bar)
	if ( ( bar ~= PlayerFrameManaBar and bar ~= PlayerFrameHealthBar ) or ( CT_PlayerFrame_ShallDisplay(1) == 1 and bar == PlayerFrameHealthBar ) or ( CT_PlayerFrame_ShallDisplay(3) == 1 and bar == PlayerFrameManaBar ) ) then
		CT_OldShowTextStatusBarText(bar);
	end
end
ShowTextStatusBarText = CT_ShowTextStatusBarText;