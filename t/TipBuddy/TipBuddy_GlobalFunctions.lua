--[[

	TipBuddy: ---------
		copyright 2005 by Chester

]]

function TB_AddMessage( text )
	if (not text) then
		return;	
	end
	if (TipBuddy_SavedVars.debug) then
		ChatFrame3:AddMessage(GREEN_FONT_COLOR_CODE..""..text.."");
	end
end

--/script TipBuddy_SavedVars["textcolors"].nam_fri = TipBuddy_RGBToHexColor( 1, 0, 1 ); TipBuddy_InitializeTextColors();
function TipBuddy_RGBToHexColor( r, g, b, text )
	--local num = 220;
	if (not text) then
		text = "";	
	end
	--TB_AddMessage(r..g..b..text);
	r = string.format("%x", (format("%.1f", r))*255);
	g = string.format("%x", (format("%.1f", g))*255);
	b = string.format("%x", (format("%.1f", b))*255);
	if (not r or r == "0" or r == 0) then
		r = "00";	
	end
	if (not g or g == "0" or g == 0) then
		g = "00";	
	end
	if (not b or b == "0" or b == 0) then
		b = "00";	
	end
	--TB_AddMessage("cff"..r..g..b..text);
	local hex = ("|cff"..r..g..b..text);
	----TB_AddMessage(hex);
	return hex;
end

--------------------------------------------------------------------------------------------------------------------------------------
-- GET TARGET TYPE
--------------------------------------------------------------------------------------------------------------------------------------
function TipBuddy_TargetInfo_GetTargetType( unit )
	if (not unit) then
		return;
	end
	if ( ( UnitHealth(unit) <= 0 ) ) then
		return ( "corpse" );
	elseif ( ( UnitHealthMax(unit) > 0 ) ) then
		if (string.find(unit, "party.+")) then
			return ( "pc_party" );	
		end
		if (UnitPlayerControlled(unit)) then
			if (UnitIsFriend(unit, "player")) then
				if ( TipBuddy_TargetInfo_CheckPet() ) then
					return ( "pet_friend" );
				end
				
				if (UnitInParty(unit)) then
					return ( "pc_party" );
				else
					return ( "pc_friend" );
				end				
			elseif (UnitIsEnemy(unit, "player")) then
				if ( TipBuddy_TargetInfo_CheckPet() ) then
					return ( "pet_enemy" );
				else
					return ( "pc_enemy" );
				end
			else
				return ( "pet_friend" );
			end				
		else
			if (UnitIsFriend(unit, "player")) then
				if ( TipBuddy_TargetInfo_CheckPet() ) then
					return ( "pet_friend" );
				else
					return ( "npc_friend" );
				end
			elseif (UnitIsEnemy(unit, "player")) then
				if ( TipBuddy_TargetInfo_CheckPet() ) then
					return ( "pet_enemy" );
				else
					return ( "npc_enemy" );
				end
			else --neutral
				return ( "npc_neutral" );			
			end
		end	
	else
		TipBuddy_Hide( TipBuddy_Main_Frame );
		return;	
	end
end

function TB_GetHealth_Text( unit, type )
	--TipBuddy_HealthTextGTT, TipBuddy_UpdateHealthTextGTT( TipBuddy_HealthTextGTT, unit )
	--TipBuddy_HealthText
	local health, healthmax;
	if (type == "percent") then
		health = UnitHealth(unit);
		--local percent = tonumber(format("%.0f", ( (health / UnitHealthMax(unit)) * 100 ) ));
		if ( unit == "player" or UnitInParty(unit) or UnitInRaid(unit)) then
			--return health.."/"..UnitHealthMax(unit);	
			return tonumber(format("%.0f", ( (health / UnitHealthMax(unit)) * 100 ) ));
		else
			return health;
		end		
	elseif (type == "current") then
		health = UnitHealth(unit);
		if ( unit == "player" or UnitInParty(unit) or UnitInRaid(unit)) then
			return health;	
		else
			if (MobHealthDB) then
				local ppp = MobHealth_PPP(UnitName(unit)..":"..UnitLevel(unit));
				local curHP = math.floor(health * ppp + 0.5);
				local maxHP = math.floor(100 * ppp + 0.5);

				if (curHP and maxHP and maxHP ~= 0) then
					return curHP;
				else
					return health;
				end
			else
				return health;
			end
		end		
	else
		healthmax = UnitHealthMax(unit);
		if ( unit == "player" or UnitInParty(unit) or UnitInRaid(unit)) then
			return healthmax;	
		else
			if (MobHealthDB) then
				local ppp = MobHealth_PPP(UnitName(unit)..":"..UnitLevel(unit));
				local maxHP = math.floor(100 * ppp + 0.5);

				if (maxHP and maxHP ~= 0) then
					return maxHP;
				else
					return healthmax;
				end
			else
				return healthmax;
			end
		end
	end
end

function TipBuddy_ReportVarStats()
	if (TipBuddy_Main_Frame:IsVisible()) then
		--TB_AddMessage("MainFrame Visible, alpha: "..TipBuddy_Main_Frame:GetAlpha());
	else
		--TB_AddMessage("MainFrame NOT Visible");
	end
	if (GameTooltip:IsVisible()) then
		--TB_AddMessage("GTT Visible");
		--TB_AddMessage("GTT Bottom = "..GameTooltip:GetBottom());
	else
		--TB_AddMessage("GTT NOT Visible");
	end
	if (TipBuddy.hasTarget == 1) then
		--TB_AddMessage("TB has target");
	else
		--TB_AddMessage("TB does NOT have target");
	end
end

function TipBuddy_GetUIScale()
	local uiScale;
	if ( GetCVar("useUiScale") == "1" ) then
		uiScale = tonumber(GetCVar("uiscale"));
		if ( uiScale > 0.9 ) then
			uiScale = 0.9;	
		end
	else
		uiScale = 0.9;
	end
	return uiScale;
end

function TipBuddy_GetEffectiveScale(frame)
    return frame:GetEffectiveScale()
end

function TipBuddy_SetEffectiveScale(frame, scale, parentframe)
    frame.scale = scale;  -- Saved in case it needs to be re-calculated when the parent's scale changes.
    local parent = getglobal(parentframe);
    if ( parent ) then
        scale = scale / GetEffectiveScale(parent);
    end
    frame:SetScale(scale);
end


function TipBuddy_GetDifficultyColor(level)
	local levelDiff = level - UnitLevel("player");
	local color, text;
	if ( levelDiff >= 5 ) then
		color = tbcolor_lvl_impossible;
		text = "Impossible";
	elseif ( levelDiff >= 3 ) then
		color = tbcolor_lvl_verydifficult;
		text = "Very Difficult";
	elseif ( levelDiff >= -2 ) then
		color = tbcolor_lvl_difficult;
		text = "Difficult";
	elseif ( -levelDiff <= GetQuestGreenRange() ) then
		color = tbcolor_lvl_standard;
		text = "Standard";
	else
		color = tbcolor_lvl_trivial;
		text = "Trivial";
	end
	return color, text;
end

function TipBuddy_ForceHide(frame)
	------TB_AddMessage("TipBuddy_ForceHide");
	UIFrameFadeRemoveFrame(frame);
	frame.fadingout = nil;
	frame.fadingin = nil;
	frame:SetAlpha(0);
	frame:Hide();
end

function TipBuddy_ClearFade(frame, alpha)
	------TB_AddMessage("TipBuddy_ForceHide");
	UIFrameFadeRemoveFrame(frame);
	frame.fadingout = nil;
	frame.fadingin = nil;
	frame:SetAlpha(alpha);
end

function TipBuddy_FixMagicChars(text)
	text = string.gsub(text, "%%", "%%%%");
	text = string.gsub(text, "%^", "%%%^");
	text = string.gsub(text, "%$", "%%%$");
	text = string.gsub(text, "%.", "%%%.");
	text = string.gsub(text, "%*", "%%%*");
	text = string.gsub(text, "%+", "%%%+");
	text = string.gsub(text, "%-", "%%%-");
	text = string.gsub(text, "%?", "%%%?");
	return text;
end


function TB_NoNegative(num)
	if (num < 0) then
		num = 0;
		return num;
	else
		return num;
	end
end

-- Start the countdown on a frame
function TipBuddyPopup_StartCounting(frame)
	if ( frame.parent ) then
		TipBuddyPopup_StartCounting(frame.parent);
	else
		frame.showTimer = TB_POPUP_TIMER;
		frame.isCounting = 1;
	end
end

-- Stop the countdown on a frame
function TipBuddyPopup_StopCounting(frame)
	if ( frame.parent ) then
		TipBuddyPopup_StopCounting(frame.parent);
	else
		frame.isCounting = nil;
	end
end

function TipBuddy_GetUnitReaction( unit )
	if ( UnitPlayerControlled(unit) ) then
		if ( UnitCanAttack(unit, "player") ) then
			-- Hostile players are red
			if ( not UnitCanAttack("player", unit) ) then
				return "caution";
			else
				return "hostile";
			end
		elseif ( UnitCanAttack("player", unit) ) then
			-- Players we can attack but which are not hostile are yellow
				return "neutral";
		elseif ( UnitIsPVP(unit) ) then
			-- Players we can assist but are PvP flagged are green
				return "pvp";
		else
			-- All other players are blue (the usual state on the "blue" server)
				return "friendly";
		end
	elseif ( UnitIsFriend(unit, "player") and UnitIsPVP(unit) ) then
		return "pvp";
	elseif ( UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) ) then
		return "tappedother";
	elseif ( UnitIsTappedByPlayer(unit) ) then
		return "tappedplayer";
	else
		local reaction = UnitReaction(unit, "player");
		--/script DEFAULT_CHAT_FRAME:AddMessage(UnitReaction("target", "player"));
		--/script DEFAULT_CHAT_FRAME:AddMessage(TipBuddyUnitReaction[4].r);
		if ( reaction ) then
			return TipBuddyUnitReaction[reaction].r;
		else
				return "friendly";
		end
	end
end

function TipBuddy_ToggleExtras(type, quiet)
	if (type == "on") then
		TipBuddy_SavedVars["pc_friend"].xtr = 1;
		TipBuddy_SavedVars["pc_enemy"].xtr = 1;
		TipBuddy_SavedVars["pc_party"].xtr = 1;
		TipBuddy_SavedVars["pet_friend"].xtr = 1;
		TipBuddy_SavedVars["pet_enemy"].xtr = 1;
		TipBuddy_SavedVars["npc_friend"].xtr = 1;
		TipBuddy_SavedVars["npc_enemy"].xtr = 1;
		TipBuddy_SavedVars["npc_neutral"].xtr = 1;
		if (not quiet) then
			DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20TipBuddy: Extras for all target types are now ON");	
		end
		return type;
	elseif (type == "off") then
		TipBuddy_SavedVars["pc_friend"].xtr = 0;
		TipBuddy_SavedVars["pc_enemy"].xtr = 0;
		TipBuddy_SavedVars["pc_party"].xtr = 0;
		TipBuddy_SavedVars["pet_friend"].xtr = 0;
		TipBuddy_SavedVars["pet_enemy"].xtr = 0;
		TipBuddy_SavedVars["npc_friend"].xtr = 0;
		TipBuddy_SavedVars["npc_enemy"].xtr = 0;
		TipBuddy_SavedVars["npc_neutral"].xtr = 0;
		if (not quiet) then
			DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20TipBuddy: Extras for all target types are now OFF");
		end
		return type;
	elseif (type ~= nil) then
		if (not TipBuddy_SavedVars[type]) then
			DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20TipBuddy: Could not recognize target type: "..type);
			return nil;
		else
			if (TipBuddy_SavedVars[type].xtr == 1) then
				TipBuddy_SavedVars[type].xtr = 0;
				DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20TipBuddy: No longer showing extras for target type: "..type);
				return type;
			else
				TipBuddy_SavedVars[type].xtr = 1;
				DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20TipBuddy: Now showing extras for target type: "..type);						
				return type;
			end
		end
	end
end