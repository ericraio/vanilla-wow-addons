-- // OnFoo Functions // --
function CT_PartyFrameSlider_OnLoad()
	getglobal(this:GetName().."Text"):SetText(CT_UFO_PARTYTEXTSIZE);
	getglobal(this:GetName().."High"):SetText(CT_UFO_PARTYTEXTSIZE_LARGE);
	getglobal(this:GetName().."Low"):SetText(CT_UFO_PARTYTEXTSIZE_SMALL);
	this:SetMinMaxValues(1, 5);
	this:SetValueStep(1);
	this.tooltipText = "Allows you to change the text size of the party health & mana texts.";
end

function CT_PartyFrame_ShallDisplay(offset)
	return CT_UnitFramesOptions.styles[2][offset][1];
end

function CT_PartyFrame_GetHealth(unit, id)
	if ( id == 1 ) then
		return "";
	end
	if ( not UnitExists(unit) or not UnitExists("player") ) then
		return "";
	end
	if ( (UnitHealth(unit) <= 0) and UnitIsConnected(unit) ) then
		return "";
	end
	if ( UnitHealthMax(unit) == 100 ) then
		id = 2;
	end
	if ( id == 2 ) then
		return floor(( UnitHealth(unit) or 1 ) / ( UnitHealthMax(unit) or 1)*100) .. "%";
	elseif ( id == 3 ) then
		local deficit = ( UnitHealth(unit) or 1 ) - ( UnitHealthMax(unit) or 1 );
		if ( deficit == 0 ) then
			deficit = "";
		end
		return deficit;
	elseif ( id == 4 ) then
		return ( UnitHealth(unit) or "?" ) .. "/" .. ( UnitHealthMax(unit) or "?" );
	end
end

function CT_PartyFrame_GetMana(unit, id)
	if ( id == 1 ) then
		return "";
	end
	if ( not UnitExists(unit) or not UnitExists("player") ) then
		return "";
	end
	if ( UnitPowerType(unit) > 0 or UnitManaMax(unit) == 0 or ( UnitIsDead(unit) and UnitIsConnected(unit) ) ) then
		return "";
	end
	if ( id == 2 ) then
		return floor(( UnitMana(unit) or 1 ) / ( UnitManaMax(unit) or 1)*100) .. "%";
	elseif ( id == 3 ) then
		local deficit = ( UnitMana(unit) or 1 ) - ( UnitManaMax(unit) or 1 );
		if ( deficit == 0 ) then
			deficit = "";
		end
		return deficit;
	elseif ( id == 4 ) then
		return ( UnitMana(unit) or "?" ) .. "/" .. ( UnitManaMax(unit) or "?" );
	end
end

-- // Update Party Member's Health // --
function CT_PartyFrame_UpdateMember(unit, health)
	if ( not UnitExists(unit) ) then
		return;
	end
	local i = strsub(unit, 6, 6);
	getglobal("CT_PartyFrame" .. i .. "HealthBar"):SetTextHeight( ( CT_UnitFramesOptions.partyTextSize or 3 ) + 7);
	local color = CT_UnitFramesOptions.styles[2];
	getglobal("CT_PartyFrame" .. i .. "HealthBar"):SetTextColor(color[1][2], color[1][3], color[1][4], color[1][5]);
	getglobal("CT_PartyFrame" .. i .. "HealthRight"):SetTextHeight( ( CT_UnitFramesOptions.partyTextSize or 3 ) + 7);
	getglobal("CT_PartyFrame" .. i .. "HealthRight"):SetTextColor(color[2][2], color[2][3], color[2][4], color[2][5]);
	getglobal("CT_PartyFrame" .. i .. "ManaBar"):SetTextHeight( ( CT_UnitFramesOptions.partyTextSize or 3 ) + 7);
	getglobal("CT_PartyFrame" .. i .. "ManaBar"):SetTextColor(color[3][2], color[3][3], color[3][4], color[3][5]);
	getglobal("CT_PartyFrame" .. i .. "ManaRight"):SetTextHeight( ( CT_UnitFramesOptions.partyTextSize or 3 ) + 7);
	getglobal("CT_PartyFrame" .. i .. "ManaRight"):SetTextColor(color[4][2], color[4][3], color[4][4], color[4][5]);
	if ( health ) then
		local hp = getglobal("PartyMemberFrame" .. i).unitHPPercent;
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
		getglobal("PartyMemberFrame" .. i .. "HealthBar"):SetStatusBarColor(r, g, 0);
		local typeOnHealth, typeRightHealth = CT_PartyFrame_ShallDisplay(1), CT_PartyFrame_ShallDisplay(2);
		getglobal("CT_PartyFrame" .. i .. "HealthBar"):SetText(CT_PartyFrame_GetHealth(unit, typeOnHealth));
		getglobal("CT_PartyFrame" .. i .. "HealthRight"):SetText(CT_PartyFrame_GetHealth(unit, typeRightHealth));
	else
		local typeOnMana, typeRightMana = CT_PartyFrame_ShallDisplay(3), CT_PartyFrame_ShallDisplay(4);
		getglobal("CT_PartyFrame" .. i .. "ManaBar"):SetText(CT_PartyFrame_GetMana(unit, typeOnMana));
		getglobal("CT_PartyFrame" .. i .. "ManaRight"):SetText(CT_PartyFrame_GetMana(unit, typeRightMana));
	end
end

function CT_PartyFrame_Update(unit, event)
	if ( event == "PARTY_MEMBERS_CHANGED" or event == "VARIABLES_LOADED" ) then
		for i = 1, GetNumPartyMembers(), 1 do
			CT_PartyFrame_UpdateMember("party" .. i, 1);
			CT_PartyFrame_UpdateMember("party" .. i, nil);
		end
	elseif ( string.find(unit, "^party%d$") ) then
		if ( event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH" or event == "UNIT_DISPLAYPOWER"  ) then
			CT_PartyFrame_UpdateMember(unit, 1);
		else
			CT_PartyFrame_UpdateMember(unit, nil);
		end
	end
end
