--[[

	TipBuddy: ---------
		copyright 2005 by Chester

]]


function TipBuddy_OnLoad()

	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_LOGIN");

	this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
	this:RegisterEvent("UNIT_LEVEL");
	this:RegisterEvent("UNIT_FACTION");
	this:RegisterEvent("UNIT_DYNAMIC_FLAGS");
	this:RegisterEvent("UNIT_CLASSIFICATION_CHANGED");
	this:RegisterEvent("PLAYER_PVPLEVEL_CHANGED");
	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("PLAYER_FLAGS_CHANGED");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_MAXHEALTH");
	this:RegisterEvent("UNIT_MANA");
	this:RegisterEvent("UNIT_RAGE");
	this:RegisterEvent("UNIT_FOCUS");
	this:RegisterEvent("UNIT_ENERGY");
	this:RegisterEvent("UNIT_HAPPINESS");
	this:RegisterEvent("UNIT_MAXMANA");
	this:RegisterEvent("UNIT_MAXRAGE");
	this:RegisterEvent("UNIT_MAXFOCUS");
	this:RegisterEvent("UNIT_MAXENERGY");
	this:RegisterEvent("UNIT_MAXHAPPINESS");
	this:RegisterEvent("UNIT_DISPLAYPOWER");
	this:RegisterEvent("UNIT_PVP_UPDATE");
	this:RegisterEvent("UPDATE_SHAPESHIFT_FORMS");

	SLASH_TIPBUDDY1 = "/tipbuddy";
	SLASH_TIPBUDDY2 = "/tbuddy";
	SLASH_TIPBUDDY3 = "/tip";
	SlashCmdList["TIPBUDDY"] = function(msg)
		TipBuddy_SlashCommand(msg);
	end
	
	-- commented out cause it fucked up my buttons
	-- Add TipBuddy_OptionsFrame to the UIPanelWindows list
	--UIPanelWindows['TipBuddy_OptionsFrame'] = {area = 'center', pushable = 0};
end

local lGameTooltip_OnEvent_Orig;
local lGameTooltip_OnShow_Orig;
local lGameTooltip_FadeOut_Orig;
function TipBuddy_OnEvent()
	if( event == "VARIABLES_LOADED" ) then
		--TB_AddMessage(TB_WHT_TXT.."VARIABLES_LOADED");
		TipBuddy_Variable_Initialize();
		TB_GameTooltip_IniHooks();

		TipBuddy.uiscale = TipBuddy_GetUIScale();
		
		--hooking GameTooltip's OnEvent
		lGameTooltip_OnEvent_Orig = GameTooltip:GetScript("OnEvent");
		GameTooltip:SetScript( "OnEvent", TipBuddy_GameTooltip_OnEvent );

		--hooking GameTooltip's OnShow
		lGameTooltip_OnShow_Orig = GameTooltip:GetScript("OnShow");
		GameTooltip:SetScript( "OnShow", TipBuddy_GameTooltip_OnShow );

		if (TipBuddy_SavedVars["general"].framepos_L or TipBuddy_SavedVars["general"].framepos_T) then
			TipBuddy_Header_Frame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", TipBuddy_SavedVars["general"].framepos_L, TipBuddy_SavedVars["general"].framepos_T);
		end
		if (not TipBuddy_SavedVars["general"].delaytime) then
			TipBuddy_SavedVars["general"].delaytime = "0.5";
		end
		if (not TipBuddy_SavedVars["general"].fadetime) then
			TipBuddy_SavedVars["general"].fadetime = "0.3";
		end
		if (not TipBuddy_SavedVars["general"].gtt_anchored) then
			TipBuddy_SavedVars["general"].gtt_anchored = 0;	
		end

		if (TipBuddy_SavedVars["general"].anchored == 1) then
			if (not TipBuddy_SavedVars["general"].anchor_vis_first or TipBuddy_SavedVars["general"].anchor_vis == 1) then
				TipBuddy_SavedVars["general"].anchor_vis_first = 1;
				TipBuddy_Header_Frame:Show();
			else
				TipBuddy_Header_Frame:Show();
				TipBuddy_Header_Frame:Hide();
			end
			TipBuddy.anchor, TipBuddy.fanchor, TipBuddy.offset = TipBuddy_GetFrameAnchorPos();
			this:SetPoint(TipBuddy.anchor, "TipBuddy_Header_Frame", TipBuddy.fanchor, 0, 1);
		else
			if (not TipBuddy_SavedVars["general"].anchor_vis_first) then
				TipBuddy_ResetAnchorPos();
				TipBuddy_Header_Frame:Hide();
			else
				TipBuddy_Header_Frame:Show();
				TipBuddy_Header_Frame:Hide();
			end
		end

		if( DEFAULT_CHAT_FRAME ) then
			DEFAULT_CHAT_FRAME:AddMessage("|cffffd200TipBuddy |cffffff00v"..TIPBUDDY_VERSION.." loaded.");
		end

		TipBuddy_InitializeTextColors();

	elseif( event == "PLAYER_LOGIN" ) then	
		-- Add TipBuddy to myAddOns addons list
		if (myAddOnsFrame) then	
			myAddOnsList.TipBuddy = {
					name = "|cff20ff20TipBuddy", 
					description = "Enhanced, configurable unit tooltip.", 
					version = "|cffffff00"..TIPBUDDY_VERSION,
					author = "chester",
					email = "chester.dent@gmail.com",
					category = MYADDONS_CATEGORY_OTHERS, 
					frame = "TipBuddy_OptionsFrame",
					optionsframe = "TipBuddy_OptionsFrame"
					};
		end

		TipBuddy.xpoint, TipBuddy.xpos, TipBuddy.ypos = TipBuddy_GetFrameCursorOffset();
		TipBuddy.anchor, TipBuddy.fanchor, TipBuddy.offset = TipBuddy_GetFrameAnchorPos();
		GameTooltip:SetOwner(UIParent, "ANCHOR_RIGHT"); 
		GameTooltip:SetPoint("BOTTOM", "TipBuddy_Parent_Frame", "CENTER", 0, 0);
		GameTooltip:SetText(" ");
		GameTooltip:SetBackdrop({bgFile="Interface\\AddOns\\TipBuddy\\gfx\\UI-Tooltip-Background",edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",tile=true,tileSize=32,edgeSize=16,insets={ left = 4, right = 4, top = 4, bottom = 4 }});
		GameTooltip:Hide();
		TipBuddyTooltip:SetOwner(UIParent, "ANCHOR_RIGHT"); 
		TipBuddyTooltip:SetPoint("BOTTOM", "TipBuddy_Parent_Frame", "CENTER", 0, 0);
		TipBuddyTooltip:SetText("  ");
		TipBuddyTooltip:SetBackdrop({bgFile="Interface\\AddOns\\TipBuddy\\gfx\\UI-Tooltip-Background",edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",tile=true,tileSize=32,edgeSize=16,insets={ left = 4, right = 4, top = 4, bottom = 4 }});
		TipBuddyTooltip:Hide();
		--TB_AddMessage("loading:  ("..TipBuddyTooltip:GetTop()..")");
		TipBuddy_Main_Frame:SetBackdrop({bgFile="Interface\\AddOns\\TipBuddy\\gfx\\UI-Tooltip-Background",edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",tile=true,tileSize=32,edgeSize=8,insets={ left = 2, right = 2, top = 2, bottom = 2 }});

--/script TipBuddyTooltip:SetOwner(TipBuddy_Parent_Frame); TipBuddyTooltip:SetPoint("BOTTOM", "TipBuddy_Parent_Frame", "CENTER", 0, 0); TipBuddyTooltip:SetText("player");
--/script TipBuddyTooltip:SetOwner(TipBuddy_Parent_Frame); TipBuddyTooltip:SetPoint("BOTTOM", "TipBuddy_Parent_Frame"); TipBuddyTooltip:SetText("player");

--/script TipBuddyTooltip:SetPoint("BOTTOM", "TipBuddy_Parent_Frame", "CENTER", 0, 0);	
	
	elseif (event == "UPDATE_MOUSEOVER_UNIT" or 
		event == "UNIT_LEVEL" or
		event == "UNIT_FACTION" or
		event == "PLAYER_PVPLEVEL_CHANGED" or
		event == "UNIT_DYNAMIC_FLAGS" or
		event == "UNIT_MAXHEALTH") then
		if (UnitExists("mouseover")) then
			--TB_AddMessage(TB_WHT_TXT.."UPDATE_MOUSEOVER_UNIT");
			TipBuddy.hasTarget = 1;
			TipBuddy_ShowUnitTooltip();
		elseif (TipBuddy.targetUnit and TipBuddy.targetUnit == arg1) then
			TipBuddy.hasTarget = 1;
			TipBuddy_ShowUnitTooltip();
		end
	
	--this fires after mouseover_unit when buffs change
	elseif ( event == "UNIT_AURA" and (arg1 == "mouseover" or string.find(arg1, "party"))) then
		if ((arg1 == "mouseover") or (TipBuddy.targetUnit and TipBuddy.targetUnit == arg1)) then
			----TB_AddMessage(TB_WHT_TXT.."UNIT_AURA");
			TipBuddy_TargetBuffs_Update( TipBuddy.targetType, arg1 );	
		end
	elseif ( event == "UNIT_HEALTH" ) then
		if ((arg1 == "mouseover") or (TipBuddy.targetUnit and TipBuddy.targetUnit == arg1)) then
			----TB_AddMessage(TB_WHT_TXT.."UNIT_HEALTH or UNIT_MAXHEALTH");
			if (UnitHealth(arg1) <= 0) then
				TipBuddy_ShowUnitTooltip();
				return;
			end
			
			if (TipBuddy.compactvis) then
				TipBuddy_UpdateHealthText( TipBuddy_HealthText, TipBuddy.targetType, arg1 );
				TipBuddy_UpdateManaText( TipBuddy_ManaText, TipBuddy.targetType, arg1 );
				TipBuddy_TargetInfo_FindExtras( arg1 );
			else
				TipBuddyTooltipStatusBar:SetValue(UnitHealth(arg1));
				TipBuddy_UpdateHealthText( TipBuddy_HealthTextGTT, TipBuddy.targetType, arg1 );
				TipBuddy_UpdateManaText( TipBuddy_ManaTextGTT, TipBuddy.targetType, arg1 );
			end
		end
	elseif ( event == "UNIT_MANA" or event == "UNIT_RAGE" or event == "UNIT_FOCUS" or event == "UNIT_ENERGY" or event == "UNIT_HAPPINESS" or event == "UNIT_MAXMANA" or event == "UNIT_MAXRAGE" or event == "UNIT_MAXFOCUS" or event == "UNIT_MAXENERGY" or event == "UNIT_MAXHAPPINESS" or event == "UNIT_DISPLAYPOWER" or event == "UPDATE_SHAPESHIFT_FORMS") then
		if ( arg1 == "mouseover" or UnitIsPlayer("mouseover")) then
			----TB_AddMessage("UNIT_MANA");
			if (not TipBuddy.targetType) then
				TipBuddy.targetType = TipBuddy_TargetInfo_GetTargetType( arg1 );	
			end
			if (not TipBuddy_SavedVars[TipBuddy.targetType]) then
				return;
			elseif ( TipBuddy_SavedVars[TipBuddy.targetType].off ~= 0 ) then
				------TB_AddMessage(TB_WHT_TXT.."UNIT_MANA - go");
				TipBuddy_SetFrame_Visibility( TipBuddy.targetType, arg1, 1 );
				TipBuddy_SetFrame_BackgroundColor( TipBuddy.targetType, arg1 );
			end
		end
	end
end

function TipBuddy_SlashCommand(msg)
	if( not msg or msg == "" ) then
		TipBuddy_ToggleOptionsFrame();
	end
	if( msg == "rankname" ) then
		if (TipBuddy_SavedVars["general"].rankname == 1) then
			TipBuddy_SavedVars["general"].rankname = 0;
			DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20TipBuddy: No longer showing full rank title in name.");
		else
			TipBuddy_SavedVars["general"].rankname = 1;
			DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20TipBuddy: Showing full rank titles in name.");
		end
	end
	if( msg == "resetanchor" ) then
		TipBuddy_ResetAnchorPos();
		DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20TipBuddy: Resetting TipBuddyAnchor position.");
	end
	if( msg == "report" ) then
		TipBuddy_ReportVarStats();
	end
	if( msg == "blizdefault" ) then
		if (TipBuddy_SavedVars["general"].blizdefault == 1) then
			TipBuddy_SavedVars["general"].blizdefault = 0;
			DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20TipBuddy: Default tooltips are now enhanced.");
		else
			TipBuddy_SavedVars["general"].blizdefault = 1;
			DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20TipBuddy: Default tooltips are no longer enhanced.");
		end
	end
	if (string.find(msg, "extras") ~= nil) then
		local type = "";
		for type in string.gfind(msg, "extras%s(.+)") do
			type = TipBuddy_ToggleExtras(type);
			----TB_AddMessage(type);
		end
		if (not type) then
			DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20TipBuddy: Please specify a target type (ex: /tip extras pc_friend)");
			return;
		end
		return;
	end
	if (string.find(msg, "scale") ~= nil) then
		--local i, s = string.find(msg, "%d+");
		for scale in string.gfind(msg, "scale%s(%d.*)") do
			TipBuddy.s = tonumber(scale);
		end
		if (TipBuddy.s) then
			if (TipBuddy.s > 2) then
				TipBuddy.s = 2;
			elseif (TipBuddy.s < 0.25) then
				TipBuddy.s = 0.25;
			end
			GameTooltip:SetScale(2);
			TipBuddyTooltip:SetScale(2);
			--GameTooltip:SetScale(UIParent:GetScale() * TipBuddy.s);
			TipBuddy_SetEffectiveScale(GameTooltip, TipBuddy.s, UIParent);
			TipBuddy_SetEffectiveScale(TipBuddyTooltip, TipBuddy.s, UIParent);
			--TipBuddy_SavedVars["general"].gtt_scale = (UIParent:GetScale() * TipBuddy.s);
			TipBuddy_SavedVars["general"].gtt_scale = TipBuddy.s;
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20TipBuddy: Please type a scale number after 'scale' (valid numbers: 0.25-2)");
		end
		return;
	end

end



function TipBuddy_ShowUnitTooltip(unit, refresh)
	if (not unit) then
		unit = "mouseover";	
	end
	if (not refresh) then
		TipBuddy.targetUnit = unit;
		TipBuddy.uName = UnitName(unit);
		TipBuddy.uLevel = UnitLevel(unit);
		TipBuddy.uClass = UnitClass(unit);
		TipBuddy.uRace = UnitRace(unit);
		TipBuddy.uGuild = GetGuildInfo(unit);
		TipBuddy.uReaction = TipBuddy_GetUnitReaction(unit);

		--TB_AddMessage("ShowUnitTooltip");
		TipBuddy.targetType = TipBuddy_TargetInfo_GetTargetType( unit );
	else
		--TB_AddMessage("ShowUnitTooltip -- refresh!");
	end
		
	TipBuddy_SetFrame_Visibility( TipBuddy.targetType, unit, refresh );
	TipBuddy_SetFrame_BackgroundColor( TipBuddy.targetType, unit );
	TipBuddy_ShowRank( TipBuddy.targetType, unit );
	TipBuddy_TargetBuffs_Update( TipBuddy.targetType, unit );
	
	--local text = getglobal("GameTooltipTextLeft1");
	--if (not text or not TipBuddy.uName or not string.find(text:GetText(), TipBuddy_FixMagicChars(TipBuddy.uName)) ) then
	--end
end

--------------------------------------------------------------------------------------------------------------------------------------
-- CHECK PET
--------------------------------------------------------------------------------------------------------------------------------------
--[[
UNITNAME_TITLE_CHARM = "%s's Minion"; -- %s is the name of the unit's charmer
UNITNAME_TITLE_CREATION = "%s's Creation";
UNITNAME_TITLE_GUARDIAN = "%s's Guardian";
UNITNAME_TITLE_MINION = "%s's Minion";
UNITNAME_TITLE_PET = "%s's Pet"; -- %s is the name of the unit's summoner
]]--
function TipBuddy_TargetInfo_CheckPet() 
	for i=1, (GameTooltip:NumLines()), 1 do
		local tipstring = getglobal("GameTooltipTextLeft"..i);
		if (not tipstring or not tipstring:GetText()) then
			return;
		end
		if ( string.find(tipstring:GetText(), TB_minion) ) then
			return 1;
		end
		if ( string.find(tipstring:GetText(), TB_creation) ) then
			return 1;
		end
		if ( string.find(tipstring:GetText(), TB_guardian) ) then
			return 1;
		end
		if ( string.find(tipstring:GetText(), TB_pet) ) then
			return 1;
		end
	end
	return;
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
				if ( UnitIsUnit(unit, "pet") or TipBuddy_TargetInfo_CheckPet() ) then
					TB_AddMessage("1 - pet_friend");
					return ( "pet_friend" );
				end
				
				if (UnitInParty(unit)) then
					TB_AddMessage("1 - pc_party");
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
				TB_AddMessage("2 - pet_friend");
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

--------------------------------------------------------------------------------------------------------------------------------------
-- GET EXTRAS
--------------------------------------------------------------------------------------------------------------------------------------

function TipBuddy_TargetInfo_FindExtras( unit )
	TipBuddy_GTT_GetExtraLines(20, unit);	
	TipBuddy_TargetInfo_ShowExtras();
end

function TipBuddy_TargetInfo_ShowExtras()
	----TB_AddMessage("SHOWING_EXTRAS");
	if (TipBuddy.gtt_xtra) then
		local lineL, LineR;
		for i=1, 20, 1 do
			getglobal("TipBuddy_Xtra"..i.."_Text"):Hide();	
			getglobal("TipBuddy_Xtra"..i.."_Text"):SetText("");	
			getglobal("TipBuddy_XtraR"..i.."_Text"):Hide();
			getglobal("TipBuddy_XtraR"..i.."_Text"):SetText("");
		end
		for i=1, table.getn(TipBuddy.gtt_xtra), 1 do
			lineL = getglobal("TipBuddy_Xtra"..i.."_Text");
			----TB_AddMessage(TEXT(TipBuddy.gtt_xtra[i]))
			if (TipBuddy.gtt_xtra[i.."color"]) then
				lineL:SetVertexColor(TipBuddy.gtt_xtra[i.."color"].r, TipBuddy.gtt_xtra[i.."color"].g, TipBuddy.gtt_xtra[i.."color"].b);
			else
				lineL:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			end
			if (TipBuddy.gtt_xtraR[i.."color"]) then
				lineR:SetVertexColor(TipBuddy.gtt_xtraR[i.."color"].r, TipBuddy.gtt_xtraR[i.."color"].g, TipBuddy.gtt_xtraR[i.."color"].b);
			else
				lineR:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			end
			if (TipBuddy.gtt_xtraR) then
				lineL:SetText(TEXT(TipBuddy.gtt_xtra[i]));
				lineL:Show();
				lineR = getglobal("TipBuddy_XtraR"..i.."_Text");
				------TB_AddMessage(TEXT(TipBuddy.gtt_xtraR[i]))
				lineR:SetText(TEXT(TipBuddy.gtt_xtraR[i]));
				lineR:Show();
			else
				lineL:SetText(TEXT(TipBuddy.gtt_xtra[i]));
				lineL:Show();	
			end
		end
	end
end

function TipBuddy_GTT_GetExtraLines( numlines, unit )
	TB_AddMessage("getting extra lines");
	if (not numlines) then
		return;	
	end	
	TipBuddy.gtt_xtra = {};
	TipBuddy.gtt_xtraR = {};
	if (not TipBuddy.gtt_lastline) then
		if (GameTooltip:IsVisible()) then
			TipBuddy.gtt_lastline = GameTooltip:NumLines();	
		else
			TipBuddy.gtt_lastline = 2;
		end
	end
		TB_AddMessage("!! lastline: "..TipBuddy.gtt_lastline..", numlines (stored): "..TipBuddy.gtt_numlines..", numlines (real): "..GameTooltip:NumLines());
	if (numlines > TipBuddy.gtt_lastline) then
		TB_AddMessage("numlines > TipBuddy.gtt_lastline");
		--/script GameTooltipTextLeft1:SetText(GameTooltipTextLeft1:GetText().."\nSecondLine");GameTooltip:Show();
		local line, text;
		local j = 1;
		for i=TipBuddy.gtt_lastline + 1, numlines, 1 do
			line = getglobal("GameTooltipTextLeft"..i);
			lineR = getglobal("GameTooltipTextRight"..i);
			if (not line or not line:GetText() or string.find(line:GetText(), PVP_ENABLED)) then
				return;
			else
				TipBuddy.gtt_xtra[j.."color"] = {};
				TipBuddy.gtt_xtra[j.."color"].r, TipBuddy.gtt_xtra[j.."color"].g, TipBuddy.gtt_xtra[j.."color"].b = line:GetTextColor();
				text = line:GetText();
			end
			--GREEN_FONT_COLOR_CODE..PVP_RANK_CIVILIAN..FONT_COLOR_CODE_CLOSE
			TipBuddy.gtt_xtra[j] = text;
			if (lineR:GetText() and lineR:IsShown()) then
				TipBuddy.gtt_xtraR[j.."color"] = {};
				TipBuddy.gtt_xtraR[j.."color"].r, TipBuddy.gtt_xtraR[j.."color"].g, TipBuddy.gtt_xtraR[j.."color"].b = lineR:GetTextColor();
				TipBuddy.gtt_xtraR[j] = lineR:GetText();
			else
				TipBuddy.gtt_xtraR[j] = "";
			end
			TB_AddMessage(line:GetText());
			j = j + 1;
			--/script ----TB_AddMessage(GameTooltipTextLeft2:GetText());
		end		
	else
		return;
	end
end

function TipBuddy_GTT_AddExtras()
	if (TipBuddy.gtt_xtra) then
		--TB_AddMessage(TB_WHT_TXT.."Adding Extras");
		for i=1, table.getn(TipBuddy.gtt_xtra), 1 do
			local lCr, lCg, lCb, rCr, rCg, rCb;
			if (TipBuddy.gtt_xtra[i.."color"]) then
				lCr, lCg, lCb = TipBuddy.gtt_xtra[i.."color"].r, TipBuddy.gtt_xtra[i.."color"].g, TipBuddy.gtt_xtra[i.."color"].b;
			else
				lCr, lCg, lCb = HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b;
			end
			if (TipBuddy.gtt_xtraR and TipBuddy.gtt_xtraR[i.."color"]) then
				rCr, rCg, rCb = TipBuddy.gtt_xtraR[i.."color"].r, TipBuddy.gtt_xtraR[i.."color"].g, TipBuddy.gtt_xtraR[i.."color"].b;
			else
				rCr, rCg, rCb = HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b;
			end

			if (TipBuddy.gtt_xtraR) then
				TipBuddyTooltip:AddDoubleLine(TipBuddy.gtt_xtra[i], TipBuddy.gtt_xtraR[i], lCr, lCg, lCb, rCr, rCg, rCb);
			else
				TipBuddyTooltip:AddLine(TipBuddy.gtt_xtra[i], lCr, lCg, lCb);
			end					
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
-- VISIBILITY
--------------------------------------------------------------------------------------------------------------------------------------
-- Target Types are:
-- pc_friend
-- pc_party
-- pc_enemy
-- npc_friend
-- npc_neutral
-- npc_enemy
-- pet_friend
-- pet_enemy

function TipBuddy_SetFrame_Visibility( type, unit, refresh )
	if (not type or not unit) then
		return;	
	end

	local targettype = TipBuddy_SavedVars[type];
	if (not targettype) then
		----TB_AddMessage("BUG! NO SAVED VARS FOR: "..type);
		TipBuddy_SetFrame_BackgroundColor( "corpse", unit );
		return;	
	end

	local targettype = TipBuddy_SavedVars[type];
	----TB_AddMessage("1: "..GameTooltipTextLeft2:GetText());
	if (TipBuddy_SavedVars["general"].blizdefault == 1) then

	elseif ( targettype.off == 1 ) then

		TipBuddy_ForceHide(TipBuddy_Main_Frame);
		if (not TipBuddy_Main_Frame:IsVisible()) then		
			TipBuddy_Main_Frame:Show();
			TipBuddy_Main_Frame:SetAlpha(1);
		end
		TipBuddy.compactvis = 1;
	else
		TipBuddy_ForceHide( TipBuddy_Main_Frame );
	end
	TipBuddy_SetFrame_TargetType( type, unit, refresh );
	TipBuddy.vis = 1;
	TipBuddy.gotextras = 1;
end

function TipBuddy_TargetInfo_CheckName( type, unit )

	TipBuddy.gtt_namecolor = "";
	local targettype = TipBuddy_SavedVars[type];
	if (targettype.off == 2) then
		return;
	end

	if (not type or not unit) then
		TipBuddy.gtt_namecolor = tbcolor_unknown;
		if (UnitName(unit)) then
			TipBuddy.gtt_name = UnitName(unit);
		else
			TipBuddy.gtt_name = TB_notspecified;	
		end
		return;	
	end

	if (UnitHealth(unit) <= 0) then
		TipBuddy.gtt_namecolor = tbcolor_corpse;	
	elseif (TipBuddy.uReaction) then
		TipBuddy.gtt_namecolor = getglobal("tbcolor_nam_"..TipBuddy.uReaction);
	elseif ( UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) ) then
		TipBuddy.gtt_namecolor = (tbcolor_nam_tappedother.." >");
	elseif (UnitIsTappedByPlayer(unit)) then
		TipBuddy.gtt_namecolor = (tbcolor_nam_tappedplayer);
	else
		TipBuddy.gtt_namecolor = tbcolor_unknown;
	end
	
	if (TipBuddy.refresh == 1 and TipBuddy.gtt_name ~= nil) then
		return;
	end

	if (TipBuddy.uName) then
		TipBuddy.gtt_name = TipBuddy.uName;
	else
		TipBuddy.gtt_name = TB_notspecified;	
	end
	if (UnitPlayerControlled(unit) and targettype.rnm == 1) then
		if (unit == "player" or unit == "mouseover" or unit == "target" ) then
			TipBuddy.gtt_name = UnitPVPName(unit);
		elseif (getglobal("GameTooltipTextLeft1"):GetText()) then
			TipBuddy.gtt_name = getglobal("GameTooltipTextLeft1"):GetText(); 
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
-- GET TARGET's TARGET
--------------------------------------------------------------------------------------------------------------------------------------

function TipBuddy_TargetInfo_TargetsTarget( type, unit )
	if (not TipBuddy.gtt_target) then
		TipBuddy.gtt_target = "";	
	end
	if (TipBuddy_SavedVars[type].trg == 0 and TipBuddy_SavedVars[type].off ~= 2) then
		------TB_AddMessage("TT for "..type.." is turned off");
		return;	
	end
	local tunit = unit.."target";
	local target = UnitName(tunit);
	if (target) then
		if (target == UNKNOWNOBJECT) then
			return;
		end
		local treaction = TipBuddy_GetUnitReaction( tunit );
		local tcolor = "";
		TipBuddy.tt = 1;
		if (target == UnitName("player")) then
			tcolor = TB_WHT_TXT;
			if (TipBuddy_SavedVars[type].trg_2l and TipBuddy_SavedVars[type].trg_2l == 1) then
				TipBuddy.gtt_target = "\n"..tcolor.." [YOU]";
			else
				TipBuddy.gtt_target = tcolor.." : [YOU]";
			end
			------TB_AddMessage("target = "..tcolor.." [YOU]");
			return;
		elseif (target == UnitInParty(tunit)) then
			if (TipBuddy_SavedVars[type].trg_pa == 0) then
				return;
			else
				tcolor = TB_PNK_TXT;
			end
		elseif (UnitHealth(tunit) <= 0) then
			tcolor = TB_DGY_TXT;	
		--elseif (treaction) then
		elseif ( UnitPlayerControlled(tunit) ) then
		--[[
TB_NML_TXT = "|cffffd200"
TB_WHT_TXT = "|cffffffff"
TB_GRY_TXT = "|cffC0C0C0"
TB_DGY_TXT = "|cff585858"
TB_RED_TXT = "|cffff2020"
TB_GRN_TXT = "|cff20ff20"
TB_YLW_TXT = "|cffffff00"
TB_BLE_TXT = "|cff3366ff"
TB_PNK_TXT = "|cffff00ff"
TB_DBL_TXT = "|cff3399ff"
TB_DGN_TXT = "|cff339900"
TB_DRD_TXT = "|cffcc0000"
]]
			if ( UnitCanAttack(tunit, "player") or UnitCanAttack("player", tunit) ) then
				if (TipBuddy_SavedVars[type].trg_en == 0) then
					return;
				else
					tcolor = TB_RED_TXT;
				end
				--return "hostile";
			else
				-- All other players are green
				if (TipBuddy_SavedVars[type].trg_pl == 0) then
					return;
				else
					tcolor = TB_GRN_TXT;	
					--return "friendly";
				end
			end
		elseif ( UnitIsEnemy(tunit, "player") ) then
			if (TipBuddy_SavedVars[type].trg_en == 0) then
				return;
			else
				tcolor = TB_RED_TXT;	
				--return "pvp";
			end
		else
			if (TipBuddy_SavedVars[type].trg_np == 0) then
				return;
			else
				tcolor = TB_BLE_TXT;
			end
		end
		--TipBuddy.gtt_target = tcolor.."  ["..TB_WHT_TXT..UnitName(unit.."target")..tcolor.."]";
		if (TipBuddy_SavedVars[type].trg_2l and TipBuddy_SavedVars[type].trg_2l == 1) then
			TipBuddy.gtt_target = "\n"..TB_WHT_TXT.." "..tcolor.."["..UnitName(unit.."target").."]";
		else
			TipBuddy.gtt_target = TB_WHT_TXT.." : "..tcolor.."["..UnitName(unit.."target").."]";
			------TB_AddMessage("target = "..tcolor.."["..UnitName(unit.."target").."]");
		end
	else
		TipBuddy.tt = 0;
	end
end

function TipBuddy_Adv_TargetsTarget( unit )
	local tunit = unit.."target";
	local target = UnitName(tunit);
	if (target) then
		local treaction = TipBuddy_GetUnitReaction( tunit );
		local tcolor = "";
		if (target == UnitName("player")) then
			return "YOU", TB_WHT_TXT;
		elseif (target == UnitInParty(tunit)) then
			return target, TB_PNK_TXT;
		elseif (UnitHealth(tunit) <= 0) then
			return target, TB_DGY_TXT;
		elseif ( UnitPlayerControlled(tunit) ) then
			if ( UnitCanAttack(tunit, "player") or UnitCanAttack("player", tunit) ) then
				--return "hostile";
				return target, TB_RED_TXT;
			else
				--return "friendly";
				return target, TB_GRN_TXT;
			end
		elseif ( UnitIsEnemy(tunit, "player") ) then
			--return "pvp";
			return target, TB_RED_TXT;
		else
			return target, TB_BLE_TXT;
		end
	else
		return "", "";
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
-- GET GUILD
--------------------------------------------------------------------------------------------------------------------------------------
function TipBuddy_TargetInfo_GetGuild( type, unit )
	if (not unit or not type) then
		return;	
	end
	if (TipBuddy.refresh == 1) then
		------TB_AddMessage("REFRESH == 1");
		if (TipBuddy.gtt_guild == "" or TipBuddy.gtt_guild == nil) then
			return;	
		end
	end

	--/script GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);GameTooltip:SetUnit("partypet1"); ----TB_AddMessage(GameTooltipTextLeft2:GetText());
	local targettype = TipBuddy_SavedVars[type];
	TipBuddy.gtt_guildcolor = "";
	if (targettype.off ~= 2) then
		if (TipBuddy.uGuild and GetGuildInfo("player") and TipBuddy.uGuild == GetGuildInfo("player")) then
			TipBuddy.gtt_guildcolor = tbcolor_gld_mate;
		elseif ( UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) ) then
			TipBuddy.gtt_guildcolor = (tbcolor_gld_tappedother);
		elseif (UnitIsTappedByPlayer(unit)) then
			TipBuddy.gtt_guildcolor = (tbcolor_gld_tappedplayer);
		elseif (TipBuddy.uReaction) then
			TipBuddy.gtt_guildcolor = getglobal("tbcolor_gld_"..TipBuddy.uReaction);
		else
			TipBuddy.gtt_guildcolor = tbcolor_unknown;
		end
		if (TipBuddy.refresh == 1) then
			return;	
		end
	end

	if (unit == "party1" or unit == "partypet1" or unit == "party2" or unit == "partypet2" or unit == "party3" or unit == "partypet3" or unit == "party4" or unit == "partypet4" or unit == "party5" or unit == "partypet5" ) then
		if ( TipBuddy.uGuild ) then
			TipBuddy.gtt_guild = TipBuddy.uGuild;
			------TB_AddMessage(GetGuildInfo(unit));
		end
		if (not TipBuddy.gtt_guild) then
			TipBuddy.gtt_guild = "";	
		end
		return;
	elseif (UnitPlayerControlled(unit) or (GameTooltipTextLeft2:GetText() and string.find(GameTooltipTextLeft2:GetText(), PLAYER ) ) ) then
		if ( type == "pet_friend" or type == "pet_enemy" ) then
			TipBuddy.gtt_guild = (GameTooltipTextLeft2:GetText());
			------TB_AddMessage("player pet guild: "..TipBuddy.gtt_guild);
			return;
		elseif ( TipBuddy.uGuild ) then
			TipBuddy.gtt_guild = TipBuddy.uGuild;
			------TB_AddMessage("player guild: "..TipBuddy.gtt_guild);
		end
		return;
	else
		------TB_AddMessage("GUILD: npc, testing...");
		if (not GameTooltipTextLeft2:GetText()) then
			------TB_AddMessage("GUILD: npc, line 2 is blank");
			return;	
		end
		if ( type == "pet_friend" or type == "pet_enemy" ) then
			TipBuddy.gtt_guild = (GameTooltipTextLeft2:GetText());
			------TB_AddMessage("pet guild: "..TipBuddy.gtt_guild);
			return;
		end		
		if (string.find(GameTooltipTextLeft2:GetText(), TB_level ) ) then
			------TB_AddMessage("GUILD: npc, line 2 is level");
			return;
		else
			TipBuddy.gtt_guild = (GameTooltipTextLeft2:GetText());
			----TB_AddMessage("title guild: "..TipBuddy.gtt_guild);
		end
	end

end

--------------------------------------------------------------------------------------------------------------------------------------
-- GET CLASS/TYPE
--------------------------------------------------------------------------------------------------------------------------------------
function TipBuddy_TargetInfo_GetClass( type, unit )
	--TipBuddy.uClass
	local targettype = TipBuddy_SavedVars[type];
	TipBuddy.gtt_classlvlcolor = "";
	TipBuddy.gtt_classcorpse = "";
	TipBuddy.gtt_classcolor = "";
	TipBuddy.gtt_class = "";
	TipBuddy.gtt_race = "";
	if (targettype.off == 2) then
		return;
	elseif (TipBuddy_SavedVars["general"].classcolor == 1) then
		TipBuddy.gtt_classlvlcolor = "";
	elseif ( UnitCanAttack(unit, "player") or UnitCanAttack("player", unit) or UnitIsPVP(unit) ) then
		-- Hostile Units, use con color system
		TipBuddy.gtt_classlvlcolor = TipBuddy_GetDifficultyColor(TipBuddy.uLevel);
	else
		-- Friendly (non-PvP flagged) Units, we don't want to use the con color cause we don't care
		TipBuddy.gtt_classlvlcolor = tbcolor_lvl_same_faction;
	end
	if (UnitHealth(unit) <= 0) then
		TipBuddy.gtt_classlvlcolor = tbcolor_corpse;
		TipBuddy.gtt_classcorpse = " "..CORPSE.."|r";
	end

	if ( UnitPlayerControlled(unit) or TipBuddy.uRace) then
		if (targettype.rac == 1 and TipBuddy.uRace ~= nil) then
			TipBuddy.gtt_race = (tbcolor_race..TipBuddy.uRace.." |r");
		else
			TipBuddy.gtt_race = "|r";
		end

		--coloring class text
		if (UnitClass(unit) == TB_mage) then
			TipBuddy.gtt_classcolor = tbcolor_cls_mage;
		elseif (UnitClass(unit) == TB_warlock) then
			TipBuddy.gtt_classcolor = tbcolor_cls_warlock;
		elseif (UnitClass(unit) == TB_priest) then
			TipBuddy.gtt_classcolor = tbcolor_cls_priest;
		elseif (UnitClass(unit) == TB_druid) then
			TipBuddy.gtt_classcolor = tbcolor_cls_druid;
		elseif (UnitClass(unit) == TB_shaman) then
			TipBuddy.gtt_classcolor = tbcolor_cls_shaman;
		elseif (UnitClass(unit) == TB_paladin) then
			TipBuddy.gtt_classcolor = tbcolor_cls_paladin;
		elseif (UnitClass(unit) == TB_rogue) then
			TipBuddy.gtt_classcolor = tbcolor_cls_rogue;
		elseif (UnitClass(unit) == TB_hunter) then
			TipBuddy.gtt_classcolor = tbcolor_cls_hunter;
		elseif (UnitClass(unit) == TB_warrior) then
			TipBuddy.gtt_classcolor = tbcolor_cls_warrior;
		else
			TipBuddy.gtt_classcolor = tbcolor_cls_other;
		end
	else
		TipBuddy.gtt_classcolor = tbcolor_cls_other;
	end
	--/script ----TB_AddMessage(UnitCreatureFamily("mouseover"));
	if ( type == "pet_friend" or type == "pet_enemy" ) then
		TipBuddy.gtt_race = "";
		if (UnitCreatureFamily(unit)) then
			TipBuddy.gtt_class = UnitCreatureFamily(unit).."|r";
			return;
		else
			TipBuddy.gtt_class = "|r";
		end
		return;
	end

	------TB_AddMessage("Get Class - "..unit);
--	/script ----TB_AddMessage(UnitCreatureType(unit));
	if ( UnitPlayerControlled(unit) or TipBuddy.uRace) then
		TipBuddy.gtt_class = TipBuddy.uClass.."|r";
	elseif ( UnitCreatureFamily(unit) ) then
		TipBuddy.gtt_class = UnitCreatureFamily(unit).."|r";
	else
		if ( UnitCreatureType(unit) == TB_notspecified) then
			TipBuddy.gtt_class = TB_creature.."|r";
		else
			if (not UnitCreatureType(unit)) then
				TipBuddy.gtt_class = "|r";
			else
				TipBuddy.gtt_class = UnitCreatureType(unit).."|r";	
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
-- GET LEVEL
--------------------------------------------------------------------------------------------------------------------------------------
function TipBuddy_TargetInfo_GetLevel( type, unit )
	local targettype = TipBuddy_SavedVars[type];
	if (not unit or targettype.off == 2) then
		return;	
	end

	local targetLevel = TipBuddy.uLevel;
	if ( targetLevel == -1 ) then
		targetLevel = 100;
	end

	-- Color level number
	local color;
	if (UnitHealth(unit) <= 0) then
		color = tbcolor_corpse;
		------TB_AddMessage("level color = corpse");
	elseif ( UnitCanAttack(unit, "player") or UnitCanAttack("player", unit) or UnitIsPVP(unit) ) then
		-- Hostile unit of friendly unit flagged for PvP
		color = TipBuddy_GetDifficultyColor(targetLevel);
		------TB_AddMessage("level color = hostile or pvp");
	else
		color = tbcolor_lvl_same_faction;
		------TB_AddMessage("level color = same fac");
	end
	
	if ( targetLevel == 100 ) then
		targetLevel = "??";
	end

	TipBuddy.classification = UnitClassification(unit);
	if ( not targetLevel or targetLevel == 0 ) then
		TipBuddy.gtt_level = ("|r");
		TipBuddy_TargetLevel_Text:SetText(TipBuddy.gtt_level);
	elseif ( TipBuddy.classification == "worldboss" ) then
		TipBuddy.gtt_level = (color..targetLevel..tbcolor_elite_worldboss.." ("..TB_worldboss..")|r");
		TipBuddy_TargetLevel_Text:SetText(TipBuddy.gtt_level);
	elseif ( TipBuddy.classification == "rareelite"  ) then
		TipBuddy.gtt_level = (color.."+"..targetLevel..tbcolor_elite_rare.." ("..TB_rare..")|r");
		TipBuddy_TargetLevel_Text:SetText(TipBuddy.gtt_level);
	elseif ( TipBuddy.classification == "elite"  ) then
		TipBuddy.gtt_level = (color.."+"..targetLevel.."|r");
		TipBuddy_TargetLevel_Text:SetText(TipBuddy.gtt_level);
	elseif ( TipBuddy.classification == "rare"  ) then
		TipBuddy.gtt_level = (color..targetLevel..tbcolor_elite_rare.." ("..TB_rare..")|r");
		TipBuddy_TargetLevel_Text:SetText(TipBuddy.gtt_level);
	else
		TipBuddy.gtt_level = (color..targetLevel.."|r");
		TipBuddy_TargetLevel_Text:SetText(TipBuddy.gtt_level);
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
-- GET/SHOW CITY FACTION
--------------------------------------------------------------------------------------------------------------------------------------
function TipBuddy_TargetInfo_ShowCityFaction( type, unit )
	if (UnitPlayerControlled(unit) or unit == "player" or unit == "party1" or unit == "partypet1" or unit == "party2" or unit == "partypet2" or unit == "party3" or unit == "partypet3" or unit == "party4" or unit == "partypet4" or unit == "party5" or unit == "partypet5" ) then
		------TB_AddMessage("CityFac: found a player");
		return;
	end
	local line;
	for i=1, (GameTooltip:NumLines()), 1 do
		local tipline = getglobal("GameTooltipTextLeft"..i);
		if (not tipline or not tipline:GetText()) then
			------TB_AddMessage("tipline: "..i.." is empty");
			return;	
		end
		if ( string.find(tipline:GetText(), TB_level..".+") ) then
			line = getglobal("GameTooltipTextLeft"..(i + 1));
			if (line:GetText() == "\n" or line:GetText() == nil) then
				------TB_AddMessage("Line after Level is empty");
				break;
			end

			if (string.find(line:GetText(), PVP_ENABLED) or line:GetText() == nil) then
				------TB_AddMessage("CityFac: found PvP or something");
				break;
			else
				local first = string.sub(line:GetText(), 0 , 1);
				if (first and TB_Factions[first]) then
					------TB_AddMessage("testing cityfac: ("..line:GetText()..")  Line: "..(i+1));
					for j=1, table.getn(TB_Factions[first]), 1 do
						if (line:GetText() == TB_Factions[first][j]) then
							------TB_AddMessage("found cityfac: ("..line:GetText()..")  Line: "..(i+1));
							TipBuddy.gtt_lastline = i+1;
							TipBuddy.gtt_cityfac = tbcolor_cityfac..line:GetText();
							break;			
						end
					end
				end
			end				
		end	
	end
end

function TipBuddy_ConfirmLastLine(unit)
	local line;
	if (not unit) then
		unit = "mouseover";
		TipBuddy.targetUnit = unit;
	end
	if (not TipBuddy.gtt_numlines) then
		if (GameTooltip:IsVisible()) then
			TipBuddy.gtt_numlines = GameTooltip:NumLines();	
		else
			TipBuddy.gtt_numlines = 2;
		end
	end
	for i=TipBuddy.gtt_numlines, 1, -1 do
		line = getglobal("GameTooltipTextLeft"..i);
		if (not line or not line:GetText()) then
			return;	
		end
		----TB_AddMessage("LASTLINE: i = "..i..", text: "..line:GetText());
		if (string.find(line:GetText(), PVP_ENABLED) 
		or string.find(line:GetText(), TB_level ) 
		or (TipBuddy.gtt_cityfac ~= "" and string.find(line:GetText(), TipBuddy.gtt_cityfac ) ) ) then
			if (i > TipBuddy.gtt_lastline) then
				TipBuddy.gtt_lastline = i;
				------TB_AddMessage("i>LL: "..TipBuddy.gtt_lastline);
				break;
			else
				------TB_AddMessage("i!>LL: "..TipBuddy.gtt_lastline);
				break;
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
-- HEALTH / MANA
--------------------------------------------------------------------------------------------------------------------------------------
function TipBuddy_UnitFrame_UpdateHealth( unit )
	UnitFrameHealthBar_Update(TipBuddy_TargetFrameHealthBar, unit);
end

function TipBuddy_UnitFrame_UpdateMana( unit )

	local manatype = UnitPowerType(unit);
	local info = ManaBarColor[manatype];

	info = ManaBarColor[manatype];
	TipBuddy_TargetFrameManaBar:SetStatusBarColor(info.r, info.g, info.b);	
	UnitFrameManaBar_Update(TipBuddy_TargetFrameManaBar, unit);
end

--------------------------------------------------------------------------------------------------------------------------------------
-- HEALTH TEXT
--------------------------------------------------------------------------------------------------------------------------------------
function TipBuddy_UpdateHealthText( frame, type, unit )
	if (not type) then
		if (frame) then
			frame:Hide();	
		end
		return;
	elseif (not frame) then
		return
	elseif (not TipBuddy_SavedVars[type] or not TipBuddy_SavedVars[type].txt_hth or TipBuddy_SavedVars[type].txt_hth == 0) then
		TipBuddy_SavedVars[type].txt_hth = 0;
		frame:Hide();
		return;	
	end
	--/script DEFAULT_CHAT_FRAME:AddMessage(UnitInParty("target"));
	--TipBuddy_HealthTextGTT, TipBuddy_UpdateHealthTextGTT( TipBuddy_HealthTextGTT, unit )
	--TipBuddy_HealthText
	local health = UnitHealth(unit);
	--local percent = tonumber(format("%.0f", ( (health / UnitHealthMax(unit)) * 100 ) ));
	local text = getglobal(frame:GetName().."Text");
	TB_AddMessage("health of:  "..unit);
	if ( unit == "player" or UnitInParty(unit) or UnitInRaid(unit) ) then
		text:SetText( health.." / "..UnitHealthMax(unit) );	
	elseif ( type == "pet_friend" and UnitName("mouseover") == UnitName("pet") ) then
		text:SetText( health.." / "..UnitHealthMax(unit) );
		--/script DEFAULT_CHAT_FRAME:AddMessage(UnitName("partypet1"));
	else
		if (MobHealthDB) then
			local ppp = MobHealth_PPP(UnitName(unit)..":"..UnitLevel(unit));
			local curHP = math.floor(health * ppp + 0.5);
			local maxHP = math.floor(100 * ppp + 0.5);

			if (curHP and maxHP and maxHP ~= 0) then
				text:SetText( curHP.." / "..maxHP );
				------TB_AddMessage(curHP.." / "..maxHP);
			else
				text:SetText( health.."%" );
			end
		else
			text:SetText( health.."%" );
		end
	end
	frame:Show();
end

function TipBuddy_UpdateManaText( frame, type, unit )
	if (not frame or not unit or TipBuddy_SavedVars[type].txt_mna == 0) then
		return;
	end
	frame:Hide();
	--local percent = (UnitMana(unit) / UnitManaMax(unit)) * 100;
	--local mana = UnitMana(unit);
	local text = getglobal(frame:GetName().."Text");
	if (UnitMana(unit) and UnitMana(unit) > 0) then
		frame:Show();
		text:SetText( UnitMana(unit).." / "..UnitManaMax(unit) );	
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
-- GET/SHOW BUFFS
--------------------------------------------------------------------------------------------------------------------------------------
function TipBuddy_TargetBuffs_Initialize()
	local frame, bframe;
	for i=1, 8 do
		frame = "TipBuddy_BuffFrame";
		bframe = getglobal(frame.."B"..i);
		bframe:Hide();
		bframe = getglobal(frame.."D"..i);
		bframe:Hide();
		frame = "TipBuddy_BuffFrameGTT";
		bframe = getglobal(frame.."B"..i);
		bframe:Hide();
		bframe = getglobal(frame.."D"..i);
		bframe:Hide();
	end
end

function TipBuddy_TargetBuffs_Update( type, unit )
	if (not unit or not type) then
		TipBuddy_TargetBuffs_Initialize(type, unit);
		return;	
	end
	local debuff, buff;
	local frame, bframe;
	local targettype = TipBuddy_SavedVars[type];
	if ( TipBuddy_SavedVars["general"].blizdefault == 1 or targettype.off ~= 1 ) then
		frame = "TipBuddy_BuffFrameGTT";
	else
		frame = "TipBuddy_BuffFrame";
	end
	for i=1, 8 do
		buff = UnitBuff(unit, i);
		bframe = getglobal(frame.."B"..i);
		if ( buff ) then
			--/script ----TB_AddMessage(UnitCreatureFamily("mouseover"));
			----TB_AddMessage(buff);
			if ( targettype.bff == 1 ) then
				getglobal(frame.."B"..i.."Icon"):SetTexture(buff);
				bframe:Show();
				bframe.id = i;	
				--TB_AddMessage(buff);
			else
				bframe:Hide();	
			end
		else
			bframe:Hide();
		end
	end
	for i=1, 8 do
		debuff = UnitDebuff(unit, i);
		bframe = getglobal(frame.."D"..i);
		if ( debuff ) then
			if ( targettype.bff == 1 ) then
				getglobal(frame.."D"..i.."Icon"):SetTexture(debuff);
				bframe:Show();
			else
				bframe:Hide();
			end
		else
			bframe:Hide();
		end
		bframe.id = i;
	end
end


function TipBuddy_ShowRank( type, unit )
	------TB_AddMessage("TipBuddy_ShowRank");
	TipBuddy_RankFrameGTT:Hide();
	TipBuddy_RankFrame:Hide();

	if (not type or not unit or ( TipBuddy_SavedVars[type].rnk == 0 )) then
		------TB_AddMessage("no type or unit");
		return;				
	end

	local rankName, rankNumber = GetPVPRankInfo(UnitPVPRank(unit));
	local rankFrame, srankFrame;

	if ( TipBuddy_SavedVars[type].off == 1 ) then
		rankFrame = getglobal("TipBuddy_RankFrame");
		srankFrame = "TipBuddy_RankFrame";
	else
		rankFrame = getglobal("TipBuddy_RankFrameGTT");
		srankFrame = "TipBuddy_RankFrameGTT";		
	end
	local rankFrameIcon = getglobal(srankFrame.."Icon");
	
	-- /script DEFAULT_CHAT_FRAME:AddMessage(UnitPVPRank("target"));
	if (not UnitPlayerControlled(unit) or rankNumber == 0) then
		rankFrame:Hide();
		return;	
	end
	-- Set icon
	if ( rankNumber > 0 ) then
		rankFrameIcon:SetTexture(format("%s%02d","Interface\\PvPRankBadges\\PvPRank",rankNumber));
		rankFrame:Show();	
	else
		rankFrame:Hide();
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
-- GET/SHOW FACTION
--------------------------------------------------------------------------------------------------------------------------------------
function TipBuddy_TargetInfo_ShowFaction( type, unit )
	TipBuddy_FactionFrameGTT:Hide();
	TipBuddy_FactionFrame:Hide();
	if (not unit) then
		return;
	end

	local factionGroup = UnitFactionGroup(unit);
	if (not factionGroup) then
		return;
	end

	local frame, sframe;
	if ( TipBuddy_SavedVars[TipBuddy.targetType].off == 1 ) then
		frame = getglobal("TipBuddy_FactionFrame");
		sframe = "TipBuddy_FactionFrame";
	else
		frame = getglobal("TipBuddy_FactionFrameGTT");
		sframe = "TipBuddy_FactionFrameGTT";		
	end
	local frameIcon = getglobal(sframe.."Icon");
	local frameText = getglobal(sframe.."Text");
	--how in the world does this happen?

	if ( UnitIsPVPFreeForAll(unit) ) then
		frameIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA");
		frame:Show();
		if (TipBuddy_SavedVars[TipBuddy.targetType].txt_pvp == 1) then
			frameIcon:Hide();
			frameText:Show();
			frameText:SetText("FFA");
		else
			frameIcon:Show();
			frameText:Hide();			
		end
	elseif ( UnitIsPVP(unit) ) then
		------TB_AddMessage("txt_pvp = "..TipBuddy_SavedVars[TipBuddy.targetType].txt_pvp);
		frameIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..factionGroup);
		frame:Show();
		if (TipBuddy_SavedVars[TipBuddy.targetType].txt_pvp == 1) then
			frameIcon:Hide();
			frameText:Show();
			frameText:SetText("PvP");
		else
			frameIcon:Show();
			frameText:Hide();			
		end
	else
		frame:Hide();
	end
end

function TipBuddy_SetFrame_TargetType( type, unit, refresh )		

	if (TipBuddy_SavedVars.debug == 1 and TipBuddy.uName) then
		------TB_AddMessage(TipBuddy.uName.." == TT: "..GameTooltipTextLeft1:GetText());	
	end

	local targettype = TipBuddy_SavedVars[type];
	if (TipBuddy_SavedVars["general"].blizdefault ~= 1) then
		if (refresh) then
			------TB_AddMessage("!! lastline: "..TipBuddy.gtt_lastline..", numlines (stored): "..TipBuddy.gtt_numlines..", numlines (real): "..GameTooltip:NumLines());
			TipBuddy.refresh = 1;
			----TB_AddMessage("!! REFRESH");
		else
			----TB_AddMessage("!! CLEARING ALL DATA");
			TipBuddy.refresh = nil;
			TipBuddy.gtt_numlines = GameTooltip:NumLines();
			TipBuddy.gtt_lastline = 1;
			TipBuddy.gtt_xtra = nil;
			TipBuddy.gtt_name = "";
			TipBuddy.gtt_target = "";
			TipBuddy.gtt_guild = "";
			TipBuddy.gtt_level = "";
			TipBuddy.gtt_race = "";
			TipBuddy.gtt_class = "";
			TipBuddy.gtt_cityfac = "";
		end

		if (not TipBuddy.gtt_numlines) then
			TipBuddy.gtt_numlines = 0;	
		end

		TipBuddy_TargetInfo_CheckName( type, unit );
		TipBuddy_TargetInfo_TargetsTarget( type, unit );
		TipBuddy_TargetInfo_GetGuild( type, unit );
		TipBuddy_TargetInfo_GetClass( type, unit );
		TipBuddy_TargetInfo_GetLevel( type, unit );
		if (TipBuddy.refresh ~= 1) then
			TipBuddy_TargetInfo_ShowCityFaction( type, unit );
			TipBuddy_ConfirmLastLine(unit);
			if ( targettype.off ~= 1 ) then
				TipBuddy_GTT_GetExtraLines(TipBuddy.gtt_numlines);
			end
		end		
	end

	if ( targettype.off == 1 ) then
		if (TipBuddy_SavedVars["general"].blizdefault == 1) then
			TipBuddy_ClearFade(TipBuddyTooltip, 1);
			TipBuddyTooltip:SetUnit(unit);	
			TipBuddy_GTT_AddExtras();
			TipBuddyTooltip:Show();
		else
			TipBuddy_TargetName_Text:SetText(TipBuddy.gtt_namecolor..TipBuddy.gtt_name..TipBuddy.gtt_target);
			TipBuddy_TargetName_Text:Show();

			if ( targettype.gld == 1 ) then
				if (TipBuddy.gtt_guildcolor and TipBuddy.gtt_guild and TipBuddy.gtt_guild ~= "" ) then
					----TB_AddMessage(TB_RED_TXT.."Guild text = "..TB_YLW_TXT..TipBuddy.gtt_guild);
					TipBuddy_TargetGuild_Text:SetText(TipBuddy.gtt_guildcolor.."<"..TipBuddy.gtt_guild..TipBuddy.gtt_guildcolor..">");
					TipBuddy_TargetGuild_Text:Show();				
				else
					TipBuddy_TargetGuild_Text:Hide();
				end
			else
				TipBuddy_TargetGuild_Text:Hide();
			end
			if ( targettype.hth == 1 ) then
				TipBuddy_TargetFrameHealthBar:Show();
				------TB_AddMessage(unit);
				if (UnitMana( unit ) > 0) then
					TipBuddy_TargetFrameManaBar:Show();
				else
					TipBuddy_TargetFrameManaBar:Hide();
				end
				TipBuddy_UnitFrame_UpdateHealth( unit );
				TipBuddy_UnitFrame_UpdateMana( unit );
				TipBuddy_UpdateHealthText( TipBuddy_HealthText, type, unit );
				TipBuddy_UpdateManaText( TipBuddy_ManaText, type, unit );
			else
				TipBuddy_TargetFrameHealthBar:Hide();
				TipBuddy_TargetFrameManaBar:Hide();
			end
			if ( targettype.cfc == 1 and TipBuddy.gtt_cityfac ~= "" ) then
				TipBuddy_TargetCityFac_Text:SetText(tbcolor_cityfac..TipBuddy.gtt_cityfac);
				TipBuddy_TargetCityFac_Text:Show();
			else
				TipBuddy_TargetCityFac_Text:Hide();
			end
			if ( targettype.cls == 1 ) then
				if (TipBuddy.gtt_class == "" and TipBuddy.gtt_level == "") then
					TipBuddy_TargetClass_Text:Hide();
					TipBuddy_TargetLevel_Text:Hide();				
				elseif (TipBuddy.gtt_class and TipBuddy.gtt_class ~= "" ) then
					TipBuddy_TargetClass_Text:SetText(TipBuddy.gtt_race..TipBuddy.gtt_classcolor..TipBuddy.gtt_classlvlcolor..TipBuddy.gtt_class..TipBuddy.gtt_classcorpse);		
					TipBuddy_TargetClass_Text:Show();			
				else
					TipBuddy_TargetClass_Text:Hide();
					TipBuddy_TargetLevel_Text:Hide();			
				end

				TipBuddy_TargetLevel_Text:Show();
			else
				TipBuddy_TargetClass_Text:Hide();
				TipBuddy_TargetLevel_Text:Hide();
			end
			TipBuddy_TargetInfo_FindExtras( unit );

			TipBuddy_FrameHeights_Initialize(type);
			TipBuddy_SetFrame_Width();
		end
	else
		--TB_AddMessage(getglobal("TipBuddyTooltipTextLeft1"):GetText());
		TipBuddy_ClearFade(TipBuddyTooltip, 1);
		TipBuddyTooltip:SetUnit(unit);
		----TB_AddMessage("setunit show:  ("..TipBuddyTooltip:GetTop()..")");

		--/script TipBuddy_SavedVars.npc_friend.off = 2
		if (TipBuddy_SavedVars["general"].blizdefault == 1) then

		elseif (targettype.off == 2) then
			GameTooltip.variables1 = {};
			GameTooltip.variables2 = {};
			if (not targettype.ebx1) then
				targettype.ebx1 = "";	
			end
			if (not targettype.ebx2) then
				targettype.ebx2 = "";	
			end
			local ebtext1 = targettype.ebx1;
			local ebtext2 = targettype.ebx2;
			for variable, value in TB_VARIABLE_FUNCTIONS do
				if (string.find(ebtext1, variable)) then
					GameTooltip.variables1[variable] = true;			
				end
				if (string.find(ebtext2, variable)) then
					GameTooltip.variables2[variable] = true;			
				end
			end
			
			local maxchar = 256;
			TipBuddyTooltipTextLeft1:SetTextColor(1, 1, 1);
			if ((not ebtext1) or ebtext1 == "") then 
				TipBuddyTooltip:SetText("     ");
				--TipBuddyTooltipTextLeft1:Show();
			else
				for var in GameTooltip.variables1 do
					ebtext1 = TB_VARIABLE_FUNCTIONS[var].func(ebtext1, unit);
				end
				if (maxchar and string.len(ebtext1) > maxchar) then
					ebtext1 = string.sub(ebtext1, 1, maxchar);
				end
				TipBuddyTooltip:SetText(ebtext1);	
				--TipBuddyTooltipTextLeft1:Show();
			end

			maxchar = 2048;
			if ((not ebtext2) or ebtext2 == "") then 
				--TipBuddyTooltipTextLeft2:SetText(" ");
				--TipBuddyTooltipTextLeft1:Show();
			else
				for var in GameTooltip.variables2 do
					ebtext2 = TB_VARIABLE_FUNCTIONS[var].func(ebtext2, unit);
				end
				if (maxchar and string.len(ebtext2) > maxchar) then
					ebtext2 = string.sub(ebtext2, 1, maxchar);
				end

				--strip out the empty lines
				ebtext2 = string.gsub(ebtext2, "|r\n|r\n", "|r\n");
				ebtext2 = string.gsub(ebtext2, "^|r\n", "");

				TipBuddyTooltip:AddLine(ebtext2);
				TipBuddyTooltipTextLeft2:SetTextColor(1, 1, 1);
			end
		else

			TipBuddyTooltip:SetText(TipBuddy.gtt_namecolor..TipBuddy.gtt_name..TipBuddy.gtt_target);

			if ( targettype.gld == 1 and TipBuddy.gtt_guild and TipBuddy.gtt_guild ~= "" ) then
				if (TipBuddy.gtt_guild ~= nil) then
					TipBuddyTooltip:AddLine(TipBuddy.gtt_guildcolor.."<"..TipBuddy.gtt_guild..TipBuddy.gtt_guildcolor..">".."|r");
				end
			end
			if ( targettype.cls == 1 ) then
				if (TipBuddy.gtt_class == nil) then
					TipBuddy.gtt_class = "";	
				end
				if (TipBuddy.gtt_class == "" and TipBuddy.gtt_level == "") then
					
				else
					TipBuddyTooltip:AddLine(TipBuddy.gtt_level.."|r  "..TipBuddy.gtt_race..TipBuddy.gtt_classcolor..TipBuddy.gtt_classlvlcolor..TipBuddy.gtt_class..TipBuddy.gtt_classcorpse.."|r");
				end
			end
			if ( targettype.cfc == 1 and TipBuddy.gtt_cityfac ~= "" ) then
				TipBuddyTooltip:AddLine(TipBuddy.gtt_cityfac.."|r");
			end
		end
		
		TipBuddy_GTT_AddExtras();
		
		if ( targettype.hth == 1 ) then
			TipBuddyTooltipStatusBar:Show();
		else
			TipBuddyTooltipStatusBar:Hide();
		end

		TipBuddyTooltip:Show();
		TipBuddy_UpdateHealthText( TipBuddy_HealthTextGTT, type, unit );
	end
	if ( targettype.fac == 1 ) then
		TipBuddy_TargetInfo_ShowFaction( type, unit );
	else
		TipBuddy_FactionFrameGTT:Hide();
		TipBuddy_FactionFrame:Hide();
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
-- SET BACKGROUND COLOR
--------------------------------------------------------------------------------------------------------------------------------------
function TipBuddy_SetFrame_BackgroundColor( type, unit )
	--TB_AddMessage(TB_WHT_TXT.."Background Color");
	if (not unit or not type) then
		TipBuddy_SetFrame_NonUnit_BackgroundColor( type );
		------TB_AddMessage("NO UNIT OR TYPE - SETTING BG");
		return;
	end
	local targettype = TipBuddy_SavedVars[type];
	local r, br, g, bg, b, bb, a, ba;

	if (not targettype.c_bdp) then
		targettype.c_bdp = 0;	
	end
	if (not targettype.c_bdb) then
		targettype.c_bdb = 0;	
	end

	----TB_AddMessage("bdp = "..targettype.c_bdp);
	if (GetGuildInfo("player") and GetGuildInfo(unit) == GetGuildInfo("player")) then
		type = "guild";
		targettype = TipBuddy_SavedVars[type];
		r, g, b, a = targettype.bgcolor.r, targettype.bgcolor.g, targettype.bgcolor.b, targettype.bgcolor.a; 	
		----TB_AddMessage("setting BG color to Guild");		
	elseif (targettype.c_bdp and targettype.c_bdp == 1) then
	--[[
	tbcolor_lvl_impossible =		TipBuddy_RGBToHexColor(colors.lvl_imp.r, colors.lvl_imp.g, colors.lvl_imp.b);
	tbcolor_lvl_verydifficult =		TipBuddy_RGBToHexColor(colors.lvl_vdf.r, colors.lvl_vdf.g, colors.lvl_vdf.b);
	tbcolor_lvl_difficult =			TipBuddy_RGBToHexColor(colors.lvl_dif.r, colors.lvl_dif.g, colors.lvl_dif.b);
	tbcolor_lvl_standard =			TipBuddy_RGBToHexColor(colors.lvl_stn.r, colors.lvl_stn.g, colors.lvl_stn.b);
	tbcolor_lvl_trivial =			TipBuddy_RGBToHexColor(colors.lvl_trv.r, colors.lvl_trv.g, colors.lvl_trv.b);
	]]		
		local levelDiff = UnitLevel(unit) - UnitLevel("player");
		local colors = TipBuddy_SavedVars["textcolors"];
		if ( levelDiff >= 5 ) then
			r, g, b = colors.lvl_imp.r, colors.lvl_imp.g, colors.lvl_imp.b; 
		elseif ( levelDiff >= 3 ) then
			r, g, b = colors.lvl_vdf.r, colors.lvl_vdf.g, colors.lvl_vdf.b; 
		elseif ( levelDiff >= -2 ) then
			r, g, b = colors.lvl_dif.r, colors.lvl_dif.g, colors.lvl_dif.b;
		elseif ( -levelDiff <= GetQuestGreenRange() ) then
			r, g, b = colors.lvl_stn.r, colors.lvl_stn.g, colors.lvl_stn.b; 
		else
			r, g, b = colors.lvl_trv.r, colors.lvl_trv.g, colors.lvl_trv.b;
		end
		r, g, b = TB_NoNegative(r - 0.35), TB_NoNegative(g - 0.35), TB_NoNegative(b - 0.35);
		a = targettype.bgcolor.a; 
	elseif (targettype.c_bdp and targettype.c_bdp == 2) then
		local reaction = TipBuddy_GetUnitReaction( unit );
		local colors = TipBuddy_SavedVars["textcolors"];
		----TB_AddMessage("reaction = "..reaction);
--[[	tbcolor_nam_hostile =			TipBuddy_RGBToHexColor(colors.nam_hos.r, colors.nam_hos.g, colors.nam_hos.b);
	tbcolor_nam_neutral =			TipBuddy_RGBToHexColor(colors.nam_neu.r, colors.nam_neu.g, colors.nam_neu.b);
	tbcolor_nam_friendly =			TipBuddy_RGBToHexColor(colors.nam_fri.r, colors.nam_fri.g, colors.nam_fri.b);
	tbcolor_nam_caution =			TipBuddy_RGBToHexColor(colors.nam_cau.r, colors.nam_cau.g, colors.nam_cau.b);
	tbcolor_nam_pvp =			TipBuddy_RGBToHexColor(colors.nam_pvp.r, colors.nam_pvp.g, colors.nam_pvp.b);
	tbcolor_nam_tappedplayer =		TipBuddy_RGBToHexColor(colors.nam_tpp.r, colors.nam_tpp.g, colors.nam_tpp.b);
	tbcolor_nam_tappedother =		TipBuddy_RGBToHexColor(colors.nam_tpo.r, colors.nam_tpo.g, colors.nam_tpo.b);]]
		if (reaction == "hostile") then
			r, g, b = colors.nam_hos.r, colors.nam_hos.g, colors.nam_hos.b;
		elseif (reaction == "neutral") then
			r, g, b = colors.nam_neu.r, colors.nam_neu.g, colors.nam_neu.b;
		elseif (reaction == "friendly") then
			r, g, b = colors.nam_fri.r, colors.nam_fri.g, colors.nam_fri.b;
		elseif (reaction == "caution") then
			r, g, b = colors.nam_cau.r, colors.nam_cau.g, colors.nam_cau.b;
		elseif (reaction == "pvp") then
			r, g, b = colors.nam_pvp.r, colors.nam_pvp.g, colors.nam_pvp.b;
		elseif (reaction == "tappedplayer") then
			r, g, b = colors.nam_tpp.r, colors.nam_tpp.g, colors.nam_tpp.b;
		elseif (reaction == "tappedother") then
			r, g, b = colors.nam_tpo.r, colors.nam_tpo.g, colors.nam_tpo.b;
		else
			r, g, b = targettype.bgcolor.r, targettype.bgcolor.g, targettype.bgcolor.b;
		end
		r, g, b = TB_NoNegative(r - 0.35), TB_NoNegative(g - 0.35), TB_NoNegative(b - 0.35);
		a = targettype.bgcolor.a; 
	else
		r, g, b, a = targettype.bgcolor.r, targettype.bgcolor.g, targettype.bgcolor.b, targettype.bgcolor.a; 	
		----TB_AddMessage("setting BG color to Custom");
	end

	if (targettype.c_bdb and targettype.c_bdb == 1) then
	--[[
	tbcolor_lvl_impossible =		TipBuddy_RGBToHexColor(colors.lvl_imp.r, colors.lvl_imp.g, colors.lvl_imp.b);
	tbcolor_lvl_verydifficult =		TipBuddy_RGBToHexColor(colors.lvl_vdf.r, colors.lvl_vdf.g, colors.lvl_vdf.b);
	tbcolor_lvl_difficult =			TipBuddy_RGBToHexColor(colors.lvl_dif.r, colors.lvl_dif.g, colors.lvl_dif.b);
	tbcolor_lvl_standard =			TipBuddy_RGBToHexColor(colors.lvl_stn.r, colors.lvl_stn.g, colors.lvl_stn.b);
	tbcolor_lvl_trivial =			TipBuddy_RGBToHexColor(colors.lvl_trv.r, colors.lvl_trv.g, colors.lvl_trv.b);
	]]		
		local levelDiff = UnitLevel(unit) - UnitLevel("player");
		local colors = TipBuddy_SavedVars["textcolors"];
		if ( levelDiff >= 5 ) then
			br, bg, bb = colors.lvl_imp.r, colors.lvl_imp.g, colors.lvl_imp.b; 
		elseif ( levelDiff >= 3 ) then
			br, bg, bb = colors.lvl_vdf.r, colors.lvl_vdf.g, colors.lvl_vdf.b; 
		elseif ( levelDiff >= -2 ) then
			br, bg, bb = colors.lvl_dif.r, colors.lvl_dif.g, colors.lvl_dif.b;
		elseif ( -levelDiff <= GetQuestGreenRange() ) then
			br, bg, bb = colors.lvl_stn.r, colors.lvl_stn.g, colors.lvl_stn.b; 
		else
			br, bg, bb = colors.lvl_trv.r, colors.lvl_trv.g, colors.lvl_trv.b;
		end
		ba = targettype.bgbcolor.a; 
	elseif (targettype.c_bdb and targettype.c_bdb == 2) then
		local reaction = TipBuddy_GetUnitReaction( unit );
		local colors = TipBuddy_SavedVars["textcolors"];
--[[	tbcolor_nam_hostile =			TipBuddy_RGBToHexColor(colors.nam_hos.r, colors.nam_hos.g, colors.nam_hos.b);
	tbcolor_nam_neutral =			TipBuddy_RGBToHexColor(colors.nam_neu.r, colors.nam_neu.g, colors.nam_neu.b);
	tbcolor_nam_friendly =			TipBuddy_RGBToHexColor(colors.nam_fri.r, colors.nam_fri.g, colors.nam_fri.b);
	tbcolor_nam_caution =			TipBuddy_RGBToHexColor(colors.nam_cau.r, colors.nam_cau.g, colors.nam_cau.b);
	tbcolor_nam_pvp =			TipBuddy_RGBToHexColor(colors.nam_pvp.r, colors.nam_pvp.g, colors.nam_pvp.b);
	tbcolor_nam_tappedplayer =		TipBuddy_RGBToHexColor(colors.nam_tpp.r, colors.nam_tpp.g, colors.nam_tpp.b);
	tbcolor_nam_tappedother =		TipBuddy_RGBToHexColor(colors.nam_tpo.r, colors.nam_tpo.g, colors.nam_tpo.b);]]
		if (reaction == "hostile") then
			br, bg, bb = colors.nam_hos.r, colors.nam_hos.g, colors.nam_hos.b;
		elseif (reaction == "neutral") then
			br, bg, bb = colors.nam_neu.r, colors.nam_neu.g, colors.nam_neu.b;
		elseif (reaction == "friendly") then
			br, bg, bb = colors.nam_fri.r, colors.nam_fri.g, colors.nam_fri.b;
		elseif (reaction == "caution") then
			br, bg, bb = colors.nam_cau.r, colors.nam_cau.g, colors.nam_cau.b;
		elseif (reaction == "pvp") then
			br, bg, bb = colors.nam_pvp.r, colors.nam_pvp.g, colors.nam_pvp.b;
		elseif (reaction == "tappedplayer") then
			br, bg, bb = colors.nam_tpp.r, colors.nam_tpp.g, colors.nam_tpp.b;
		elseif (reaction == "tappedother") then
			br, bg, bb = colors.nam_tpo.r, colors.nam_tpo.g, colors.nam_tpo.b;
		else
			br, bg, bb = targettype.bgcolor.r, targettype.bgcolor.g, targettype.bgcolor.b;
		end
		ba = targettype.bgbcolor.a; 
	else
		targettype = TipBuddy_SavedVars[type];
		if (not targettype.bgbcolor) then
			targettype.bgbcolor = {};
			targettype.bgbcolor.r = 0.8;
			targettype.bgbcolor.g = 0.8;
			targettype.bgbcolor.b = 0.9;
			targettype.bgbcolor.a = 1;	
		end
		br, bg, bb, ba = targettype.bgbcolor.r, targettype.bgbcolor.g, targettype.bgbcolor.b, targettype.bgbcolor.a; 	
	end

	--if (TipBuddy_SavedVars["general"].blizdefault == 1) then
	--	GameTooltip:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b, 1);
	--	GameTooltip:SetBackdropBorderColor(0.8, 0.8, 0.9, 1);
	if (TipBuddy.compactvis) then
		TipBuddy_Main_Frame:SetBackdropColor( r, g, b, a );
		TipBuddy_Main_Frame:SetBackdropBorderColor( 0, 0, 0, 0.9 );
	else
		TipBuddyTooltip:SetBackdropColor( r, g, b, a );
		--/script GameTooltip:SetBackdropBorderColor( 1, 1, 1, 1 );
		TipBuddyTooltip:SetBackdropBorderColor( br, bg, bb, ba );
	end
	if (TipBuddy_SavedVars["general"].blizdefault == 1) then
		TipBuddyTooltipTextLeft1:SetTextColor(GameTooltip_UnitColor(unit));
	end
	----TB_AddMessage(r.." - "..g.." - "..b.." - "..a);
end

--------------------------------------------------------------------------------------------------------------------------------------
-- SET NON-UNIT BACKGROUND COLOR
--------------------------------------------------------------------------------------------------------------------------------------
function TipBuddy_SetFrame_NonUnit_BackgroundColor( type )
	if (not type) then
		type = "general";	
	end
	local targettype = TipBuddy_SavedVars[type];
	if (not targettype.bgcolor) then
		targettype.bgcolor = {};
		targettype.bgcolor.r = 0.1;
		targettype.bgcolor.g = 0.1;
		targettype.bgcolor.b = 0.1;
		targettype.bgcolor.a = 0.78;	
	end
	if (not targettype.bgbcolor) then
		targettype.bgbcolor = {};
		targettype.bgbcolor.r = 0.8;
		targettype.bgbcolor.g = 0.8;
		targettype.bgbcolor.b = 0.9;
		targettype.bgbcolor.a = 1;	
	end

	--TB_AddMessage("NU: "..targettype.bgcolor.r.." - "..targettype.bgcolor.g.." - "..targettype.bgcolor.b.." - "..targettype.bgcolor.a);
	GameTooltip:SetBackdropColor( targettype.bgcolor.r, targettype.bgcolor.g, targettype.bgcolor.b, targettype.bgcolor.a );
	GameTooltip:SetBackdropBorderColor( targettype.bgbcolor.r, targettype.bgbcolor.g, targettype.bgbcolor.b, targettype.bgbcolor.a );
end


--------------------------------------------------------------------------------------------------------------------------------------
-- PARENT ON UPDATE
--------------------------------------------------------------------------------------------------------------------------------------
function TipBuddy_ParentTip_OnUpdate()
	--if (TipBuddy_Main_Frame:IsVisible() or GameTooltip:IsVisible()) then
	this:ClearAllPoints();

	local x, y = TipBuddy_PositionFrameToCursor();

	if (not TipBuddy.xpoint or not TipBuddy.xpos or not TipBuddy.anchor or not TipBuddy.fanchor) then
		TipBuddy.xpoint, TipBuddy.xpos, TipBuddy.ypos = TipBuddy_GetFrameCursorOffset();
		TipBuddy.anchor, TipBuddy.fanchor, TipBuddy.offset = TipBuddy_GetFrameAnchorPos();				
	end

	if ( UnitExists("mouseover") or TipBuddy.anchorparent == "UIParent") then
		if (TipBuddy_SavedVars["general"].anchored == 1) then
			this:SetPoint(TipBuddy.anchor, "TipBuddy_Header_Frame", TipBuddy.fanchor, 0, 0);
		else
			this:SetPoint(TipBuddy.xpoint, "UIParent", "BOTTOMLEFT", x, y);
		end
	else
		if (TipBuddy_SavedVars["general"].nonunit_anchor == 0) then
			this:SetPoint(TipBuddy.xpoint, "UIParent", "BOTTOMLEFT", x, y);				
		elseif (TipBuddy_SavedVars["general"].nonunit_anchor == 1) then
			this:SetPoint(TipBuddy.anchor, "TipBuddy_Header_Frame", TipBuddy.fanchor, 0, 0);
		else
			this:SetPoint(TipBuddy.xpoint, "UIParent", "BOTTOMLEFT", x, y);	
		end
		--/script TipBuddyTooltipx:SetOwner(TipBuddy_Parent_Frame, "ANCHOR_RIGHT"); TipBuddyTooltipx:SetUnit("player");
	end

	if ( UnitExists("mouseover") or TipBuddy.unitframe == 1) then
		if (TipBuddy.hasTarget and TipBuddy.hasTarget == 1) then
			--TB_AddMessage(TB_WHT_TXT.."ParentTip_OnUpdate");
			GameTooltip:SetAlpha(0);
		end
	elseif (TipBuddy.hasTarget == 1) then
		local text1 = getglobal("GameTooltipTextLeft1"):GetText();
		--TB_AddMessage(tbcolor_nam_hostile..TipBuddy.uName.." - "..getglobal("GameTooltipTextLeft1"):GetText());
		if (text1 == nil or TipBuddy.gtt_name == nil or string.find(text1, TipBuddy_FixMagicChars(TipBuddy.gtt_name))) then
			GameTooltip:Hide();
			------TB_AddMessage(TEXT(text1).." - "..TEXT(TipBuddy.gtt_name));
			if (TipBuddy_SavedVars["general"].gtt_fade == 1) then
				--TipBuddyTooltip:FadeOut();
				----TB_AddMessage("fading tt");

				TipBuddy_Hide( TipBuddyTooltip );	
			else
				TipBuddy_ForceHide( TipBuddyTooltip );
				--TB_AddMessage("hiding tt");
			end
		end
		--/script GameTooltipTextLeft1:SetTextColor(GameTooltip_UnitColor("mouseover"));
		if (TipBuddy_Main_Frame:IsVisible()) then
			TipBuddy_Hide( TipBuddy_Main_Frame );	
		end

		TipBuddy.hasTarget = 0;
		--TB_AddMessage("TipBuddy.hasTarget = 0");
		TipBuddy.uName = nil;
		TipBuddy.vis = nil;
	end
	
	if (not TipBuddy.first) then
		GameTooltip.default = nil;
		TipBuddy.first = 1;	
		--TB_AddMessage("first time:  ("..TipBuddyTooltip:GetTop()..")");
	end
end

function TipBuddyTooltip_OnUpdate()
	if ( this.fadingout ) then
		if ( this:GetAlpha() <= 0 ) then
			TipBuddy_FadeOut_Finished(this);
		end
	elseif ( this.fadingin ) then
		if ( this:GetAlpha() >= 1 ) then
			TipBuddy_FadeIn_Finished(this);
		end
	end
	if (this:IsVisible()) then
		if ((TipBuddy.hasTarget ~= 1) and (not this.fadingout)) then

			if (not this.startTime or not this.endTime) then
				TipBuddy_ForceHide( this );
				return;
			end
			GameTooltip:SetAlpha(0);
			local fraction = (GetTime() - this.startTime) / (this.endTime - this.startTime);
			if ( fraction >= 1.0 ) then
				TipBuddy_FadeOut( this );
			end	
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
-- MAIN ON UPDATE
--------------------------------------------------------------------------------------------------------------------------------------
function TipBuddy_MainTip_OnUpdate()
	--/script TipBuddy_SavedVars["general"].cursorpos = 1;
	--/script TipBuddy_SavedVars["general"].cursorpos = 0;

	if ( this.fadingout ) then
		if ( this:GetAlpha() <= 0 ) then
			TipBuddy_FadeOut_Finished(this);
		end
	elseif ( this.fadingin ) then
		if ( this:GetAlpha() >= 1 ) then
			TipBuddy_FadeIn_Finished(this);
		end
	end
	if (this:IsVisible()) then
		if ((TipBuddy.hasTarget ~= 1) and (not this.fadingout)) then
			TipBuddy.compactvis = nil;
			--/script ----TB_AddMessage(TipBuddy_Main_Frame.fadingout);
			if (not this.startTime or not this.endTime) then
				TipBuddy_SetFrame_NonUnit_BackgroundColor();
				TipBuddy_ForceHide( this );
				return;
			end
			GameTooltip:SetAlpha(0);
			local fraction = (GetTime() - this.startTime) / (this.endTime - this.startTime);
			if ( fraction >= 1.0 ) then
				TipBuddy_FadeOut( this );
			elseif (GameTooltip:IsVisible() and TipBuddy.compactvis ~= 1) then	
				TipBuddy_SetFrame_NonUnit_BackgroundColor();
				TipBuddy_ForceHide( this );
			end	
		elseif (GameTooltip:IsVisible() and TipBuddy.compactvis ~= 1) then	
			TipBuddy_SetFrame_NonUnit_BackgroundColor();
			TipBuddy_ForceHide( this );
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
-- SET ANCHOR
--------------------------------------------------------------------------------------------------------------------------------------
-- if it is set to be anchored, anchor it to TipBuddyAnchor
-- otherwise, set it to the cursor
function TipBuddy_SetFrame_Anchor( frame )
	--TB_AddMessage(TB_WHT_TXT.."SetFrame_Anchor");
	if (not TipBuddy.xpoint or not TipBuddy.anchor) then
		TipBuddy.xpoint, TipBuddy.xpos, TipBuddy.ypos = TipBuddy_GetFrameCursorOffset();
		TipBuddy.anchor, TipBuddy.fanchor, TipBuddy.offset = TipBuddy_GetFrameAnchorPos();				
	end
	frame:ClearAllPoints();
	if (TipBuddy_SavedVars["general"].anchored == 1) then
		frame:SetPoint(TipBuddy.anchor, "TipBuddy_Parent_Frame", TipBuddy.fanchor, 0, TipBuddy.offset);
	else
		frame:SetPoint(TipBuddy.xpoint, "TipBuddy_Parent_Frame", "CENTER", 0, 0);
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
-- SET HEIGHTS (COMPACT)
--------------------------------------------------------------------------------------------------------------------------------------
-- /script TipBuddy_SavedVars["general"].scalemod = "1";
-- /script TipBuddy_SavedVars["general"].scalemod = "0";

function TipBuddy_FrameHeights_Initialize( type )
	local scale = TipBuddy_SavedVars["general"].scalemod;

	TipBuddy_FactionFrameIcon:SetHeight( 30 + (scale * 1.5) );
	TipBuddy_FactionFrameIcon:SetWidth( 30 + (scale * 1.5) );

	TipBuddy_TargetName_Text:SetTextHeight( 11 + scale );
	TipBuddy_TargetName_TextR:SetTextHeight( 11 + scale );
	if (type and TipBuddy.tt and TipBuddy.tt == 1 and TipBuddy_SavedVars[type] and TipBuddy_SavedVars[type].trg_2l and TipBuddy_SavedVars[type].trg_2l == 1) then
		TipBuddy_TargetName_Text:SetHeight( (11 + scale) * 2);
		TipBuddy_TargetName_TextR:SetHeight( (11 + scale) * 2);
	else
		TipBuddy_TargetName_Text:SetHeight( 11 + scale );
		TipBuddy_TargetName_TextR:SetHeight( 11 + scale );
	end

	TipBuddy_TargetGuild_Text:SetTextHeight( 8 + scale );
	TipBuddy_TargetGuild_Text:SetHeight( 8 + scale );
	TipBuddy_TargetGuild_TextR:SetTextHeight( 8 + scale );
	TipBuddy_TargetGuild_TextR:SetHeight( 8 + scale );

	TipBuddy_TargetLevel_Text:SetTextHeight( 10 + scale );
	TipBuddy_TargetLevel_Text:SetHeight( 10 + scale );
	--TipBuddy_TargetLevel_Text:SetTextHeight( 8 + scale );
	--TipBuddy_TargetLevel_Text:SetHeight( 8 + scale );
	TipBuddy_TargetClass_Text:SetTextHeight( 10 + scale );
	TipBuddy_TargetClass_Text:SetHeight( 10 + scale );

	TipBuddy_TargetCityFac_Text:SetTextHeight( 8 + scale );
	TipBuddy_TargetCityFac_Text:SetHeight( 8 + scale );
	TipBuddy_TargetCityFac_TextR:SetTextHeight( 8 + scale );
	TipBuddy_TargetCityFac_TextR:SetHeight( 8 + scale );

	for i=1, 20, 1 do
		local line;
		line = getglobal("TipBuddy_Xtra"..i.."_Text");
		line:SetTextHeight( 8 + scale );
		line:SetHeight( 8 + scale );
		line = getglobal("TipBuddy_XtraR"..i.."_Text");
		line:SetTextHeight( 8 + scale );
		line:SetHeight( 8 + scale );
	end

	TipBuddy_TargetFrameHealthBar:SetHeight( 5 + scale );
	TipBuddy_TargetFrameManaBar:SetHeight( 3 + scale );
	TipBuddy_HealthTextText:SetTextHeight( TipBuddy_TargetFrameHealthBar:GetHeight() + 6 );
	TipBuddy_ManaTextText:SetTextHeight( TipBuddy_TargetFrameManaBar:GetHeight() + 3.5 );

	TipBuddy_RankFrameIcon:SetHeight( 12 + scale );
	TipBuddy_RankFrameIcon:SetWidth( 12 + scale );

-- hack to fix the fonts scaling badly
	TipBuddy_Main_Frame:SetScale(2);
	TipBuddy_Main_Frame:SetScale(1);

	TipBuddy_SetFrame_Height();
end

function TipBuddy_SetFrame_Width()
	local scale = TipBuddy_SavedVars["general"].scalemod;
	
	local targetNameLength = TipBuddy_TargetName_Text:GetStringWidth() + (4 + scale); 
	local targetClassLength = (TipBuddy_TargetClass_Text:GetStringWidth() + TipBuddy_TargetLevel_Text:GetStringWidth() + (scale + 10)); 
	local targetGuildLength = TipBuddy_TargetGuild_Text:GetStringWidth() + (4 + scale); 

	if (not TipBuddy_TargetClass_Text:IsVisible()) then
		targetClassLength = 1;	
	end
	if (not TipBuddy_TargetGuild_Text:IsVisible()) then
		targetGuildLength = 1;	
	end

	if (targetNameLength > targetGuildLength) then
		if (targetNameLength < targetClassLength) then
			targetNameLength = targetClassLength;
		end
	elseif (targetGuildLength > targetClassLength) then
		targetNameLength = targetGuildLength;
	else
		targetNameLength = targetClassLength;
	end

	local t1 = targetNameLength;
	local t2;
	for i=1, 20, 1 do
		t2 = (getglobal("TipBuddy_Xtra"..i.."_Text"):GetStringWidth() + (5 + scale)) + (getglobal("TipBuddy_XtraR"..i.."_Text"):GetStringWidth() + (12 + scale));
		if (t1 < t2) then
			t1 = t2;	
		end		
	end

	if (t1 < 72) then
		t1 = 72;
	end
	TipBuddy_Main_Frame:SetWidth(t1 + scale);

	TipBuddy_TargetFrameHealthBar:SetWidth(TipBuddy_Main_Frame:GetWidth() - 6);
	TipBuddy_TargetFrameManaBar:SetWidth(TipBuddy_Main_Frame:GetWidth() - 6);
end

--/script foc = GetMouseFocus(); DEFAULT_CHAT_FRAME:AddMessage(foc:GetName());

function TipBuddy_SetFrame_Height()
	local scale = TipBuddy_SavedVars["general"].scalemod;
	local nameFrame = TipBuddy_TargetName_Text:GetHeight();
	local guildFrame = TipBuddy_TargetGuild_Text:GetHeight();
	local classFrame = TipBuddy_TargetLevel_Text:GetHeight();
	local healthFrame = TipBuddy_TargetFrameHealthBar:GetHeight();
	local manaFrame = TipBuddy_TargetFrameManaBar:GetHeight();
	local cityfacFrame = TipBuddy_TargetCityFac_Text:GetHeight();
	local lastparent = "TipBuddy_TargetName_Text";
	local lastparentr = "TipBuddy_TargetName_TextR";

	if (TipBuddy_TargetName_Text:IsVisible()) then
		nameFrame = TipBuddy_TargetName_Text:GetHeight();
	else
		nameFrame = 0;	
	end

	if (TipBuddy_TargetGuild_Text:IsVisible()) then
		guildFrame = TipBuddy_TargetGuild_Text:GetHeight();
		TipBuddy_TargetGuild_Text:SetPoint("TOPLEFT", lastparent, "BOTTOMLEFT", 0, 1);
		TipBuddy_TargetGuild_TextR:SetPoint("TOPRIGHT", lastparentr, "BOTTOMRIGHT", 0, 1);
		lastparent = "TipBuddy_TargetGuild_Text";
		lastparentr = "TipBuddy_TargetGuild_TextR";
	else
		guildFrame = 0;	
	end

	if (TipBuddy_TargetFrameHealthBar:IsVisible()) then
		healthFrame = (TipBuddy_TargetFrameHealthBar:GetHeight() + 5);
		TipBuddy_TargetFrameHealthBar:SetPoint("TOPLEFT", lastparent, "BOTTOMLEFT", 2, -4);
		lastparent = "TipBuddy_TargetFrameHealthBar";
		lastparentr = "TipBuddy_TargetFrameHealthBar";
	else
		healthFrame = 0;	
	end

	if (TipBuddy_TargetFrameManaBar:IsVisible()) then
		manaFrame = (TipBuddy_TargetFrameManaBar:GetHeight() + 4);
		lastparent = "TipBuddy_TargetFrameManaBar";
		lastparentr = "TipBuddy_TargetFrameManaBar";
	else
		manaFrame = 0;	
	end

	if (TipBuddy_TargetCityFac_Text:IsVisible()) then
		------TB_AddMessage(lastparent);
		cityfacFrame = TipBuddy_TargetCityFac_Text:GetHeight();
		TipBuddy_TargetCityFac_Text:SetPoint("TOPLEFT", lastparent, "BOTTOMLEFT", 0, 0);
		TipBuddy_TargetCityFac_TextR:SetPoint("TOPRIGHT", lastparentr, "BOTTOMRIGHT", 0, 0);
		lastparent = "TipBuddy_TargetCityFac_Text";
		lastparentr = "TipBuddy_TargetCityFac_TextR";
	else
		cityfacFrame = 0;	
	end

	if (TipBuddy_TargetLevel_Text:IsVisible()) then
	------TB_AddMessage(lastparent);
		classFrame = (TipBuddy_TargetLevel_Text:GetHeight() + 1);
		TipBuddy_TargetLevel_Text:SetPoint("TOPLEFT", lastparent, "BOTTOMLEFT", 0, -1);
		TipBuddy_TargetClass_Text:SetPoint("TOPRIGHT", lastparentr, "BOTTOMRIGHT", 0, -1);
		lastparent = "TipBuddy_TargetLevel_Text";
		lastparentr = "TipBuddy_TargetClass_Text";
	else
		classFrame = 0;	
	end

	if (TipBuddy_Xtra1_Text:IsVisible()) then
		TipBuddy_Xtra1_Text:SetPoint("TOPLEFT", lastparent, "BOTTOMLEFT", 0, -3);
		TipBuddy_XtraR1_Text:SetPoint("TOPRIGHT", lastparentr, "BOTTOMRIGHT", 0, -3);
	end

	local xtraHeight = 0;
	for i=1, 20, 1 do
		local xtraLineL = getglobal("TipBuddy_Xtra"..i.."_Text");
		local xtraLineR = getglobal("TipBuddy_XtraR"..i.."_Text");
		if (xtraLineL:IsVisible()) then
			xtraHeight = ( xtraHeight + xtraLineL:GetHeight() + 1 );
		else
			if (xtraLineR:IsVisible()) then
				xtraHeight = ( xtraHeight + xtraLineL:GetHeight() + 1 );
			end
		end
	end
	if (xtraHeight ~= 0) then	
		xtraHeight = xtraHeight + 2;	
	end

	local tipFrameHeight = ((nameFrame + guildFrame + classFrame + healthFrame + manaFrame + cityfacFrame + xtraHeight) + 4);
	TipBuddy_Main_Frame:SetHeight(tipFrameHeight);
end

--------------------------------------------------------------------------------------------------------------------------------------
-- POSITIONING
--------------------------------------------------------------------------------------------------------------------------------------

--/script ----TB_AddMessage(UIParent:GetWidth()..", "..UIParent:GetHeight()); local x, y = GetCursorPosition(UIParent); ----TB_AddMessage(x..", "..y);
function TipBuddy_PositionFrameToCursor()

	local x, y = GetCursorPosition(UIParent);

	x = (x / TipBuddy.uiscale) + TipBuddy.xpos;
	y = (y / TipBuddy.uiscale) + TipBuddy.ypos;

	local x1, x2, y1, y2, tip;
	if (TipBuddyTooltip:IsVisible()) then
		tip = getglobal("TipBuddyTooltip");
	elseif (TipBuddy_Main_Frame:IsVisible()) then
		tip = getglobal("TipBuddy_Main_Frame");
	else
		tip = getglobal("GameTooltip");
	end

	if ( TipBuddy.xpoint == "LEFT" ) then
		x1 = 0;
		x2 = (TipBuddy.uiwidth - tip:GetWidth());
	elseif ( TipBuddy.xpoint == "RIGHT" ) then
		x1 = tip:GetWidth();
		x2 = TipBuddy.uiwidth;
	else
		x1 = tip:GetWidth() * 0.5;
		x2 = (TipBuddy.uiwidth - x1);
	end

	y1 = (TipBuddy.uiheight - tip:GetHeight());
	if ( TipBuddy.xpoint == "TOP" ) then
		y2 = tip:GetHeight();
	elseif ( xpoint == "BOTTOM" ) then
		y2 = 0;
	else
		y2 = (tip:GetHeight() * 0.5);
	end

------TB_AddMessage(x1..", "..y2);
	if ( x < x1 ) then
		x = x1;
	end
	if ( x > x2 ) then
		x = x2;
	end
	if ( y > y1 ) then
		y = y1;
	end
	if ( y < y2 ) then
		y = y2;
	end
	
	return x, y;
end

function TipBuddy_GetIconAnchorPos( frame )
	local x, y = TipBuddy_PositionFrameToCursor();

	if (not frame or not frame:GetLeft()) then
		return;	
	end
	if (not TipBuddy.uiwidth) then
		TipBuddy.uiscale = UIParent:GetScale();
		TipBuddy.uiwidth = UIParent:GetWidth() / TipBuddy.uiscale;
		TipBuddy.uiheight = UIParent:GetHeight() / TipBuddy.uiscale;			
	end	
	if (y > (TipBuddy.uiheight * 0.75)) then
		--topright
		if (x > (TipBuddy.uiwidth * 0.75)) then
			if (frame and frame:GetLeft() <= (TipBuddy.uiwidth * 0.2)) then
				------TB_AddMessage("ANCHOR_NONE");
				return "ANCHOR_NONE", "BOTTOM", "TOP";
			end
			------TB_AddMessage("ANCHOR_BOTTOMLEFT");
			return "ANCHOR_BOTTOMLEFT", "TOPRIGHT", "BOTTOMLEFT";
		--topmidright
		elseif (x > (TipBuddy.uiwidth * 0.5)) then
			if (frame and frame:GetLeft() <= (TipBuddy.uiwidth * 0.2)) then
				------TB_AddMessage("ANCHOR_NONE");
				return "ANCHOR_NONE", "BOTTOM", "TOP";
			end
			------TB_AddMessage("ANCHOR_BOTTOMLEFT");
			return "ANCHOR_BOTTOMLEFT", "TOPRIGHT", "BOTTOMRIGHT";
		--cursor is topmidleft
		elseif (x > (TipBuddy.uiwidth * 0.25)) then
			if (frame and frame:GetRight() >= (TipBuddy.uiwidth * 0.8)) then
				------TB_AddMessage("ANCHOR_NONE");
				return "ANCHOR_NONE", "BOTTOM", "TOP";
			end
			------TB_AddMessage("ANCHOR_BOTTOMRIGHT");
			return "ANCHOR_BOTTOMRIGHT", "TOPLEFT", "BOTTOMLEFT";
		--cursor is topleft
		else
			if (frame and frame:GetRight() >= (TipBuddy.uiwidth * 0.8)) then
				------TB_AddMessage("ANCHOR_NONE");
				return "ANCHOR_NONE", "BOTTOM", "TOP";
			end
			------TB_AddMessage("ANCHOR_BOTTOMRIGHT");
			return "ANCHOR_BOTTOMRIGHT", "TOPLEFT", "BOTTOMRIGHT";
		end

	elseif (y > (TipBuddy.uiheight * 0.25)) then
		--midright
		if (x > (TipBuddy.uiwidth * 0.75)) then
			if (frame and frame:GetLeft() <= (TipBuddy.uiwidth * 0.2)) then
				------TB_AddMessage("ANCHOR_NONE");
				return "ANCHOR_NONE", "BOTTOM", "TOP";
			end
			------TB_AddMessage("ANCHOR_NONE");
			return "ANCHOR_NONE", "BOTTOMRIGHT", "BOTTOMLEFT";
		else
			if (frame and frame:GetRight() >= (TipBuddy.uiwidth * 0.8)) then
				------TB_AddMessage("ANCHOR_NONE");
				return "ANCHOR_NONE", "BOTTOM", "TOP";
			end
			------TB_AddMessage("ANCHOR_NONE");
			return "ANCHOR_NONE", "BOTTOMLEFT", "BOTTOMRIGHT";
		end
	else

		if (x > (TipBuddy.uiwidth * 0.75)) then
			if (frame and frame:GetLeft() <= (TipBuddy.uiwidth * 0.2)) then
				------TB_AddMessage("ANCHOR_NONE");
				return "ANCHOR_NONE", "BOTTOM", "TOP";
			end
			------TB_AddMessage("ANCHOR_LEFT");
			return "ANCHOR_LEFT", "BOTTOMRIGHT", "TOPLEFT";
		else
			if (frame and frame:GetRight() >= (TipBuddy.uiwidth * 0.8)) then
				------TB_AddMessage("ANCHOR_NONE");
				return "ANCHOR_NONE", "BOTTOM", "TOP";
			end
			------TB_AddMessage("ANCHOR_RIGHT");
			return "ANCHOR_RIGHT", "BOTTOMLEFT", "TOPRIGHT";
		end		
	end
end

function TipBuddy_GetFrameCursorOffset()
	local curpos = TipBuddy_SavedVars["general"].cursorpos;
	TipBuddy.uiscale = UIParent:GetScale();
	TipBuddy.uiwidth = UIParent:GetWidth() / TipBuddy.uiscale;
	TipBuddy.uiheight = UIParent:GetHeight() / TipBuddy.uiscale;

	-- set the position of the tooltip in relation to the cursor
	if (curpos == "Top") then
		xpoint = "BOTTOM";
	elseif (curpos == "Right") then
		xpoint = "LEFT";		
	elseif (curpos == "Left") then
		xpoint = "RIGHT";
	elseif (curpos == "Bottom") then
		xpoint = "TOP";
	else
		xpoint = "BOTTOM";
	end
	return xpoint, TipBuddy_SavedVars["general"].offset_x, TipBuddy_SavedVars["general"].offset_y;
end

function TipBuddy_GetFrameAnchorPos()
	local anchorpos = TipBuddy_SavedVars["general"].anchor_pos;

	if (anchorpos == "Top Right") then
		anchor = "BOTTOMRIGHT";
		fanchor = "TOPRIGHT";
		offset = -2;
	elseif (anchorpos == "Top Left") then
		anchor = "BOTTOMLEFT";
		fanchor = "TOPLEFT";
		offset = -2;
	elseif (anchorpos == "Bottom Right") then
		anchor = "TOPRIGHT";
		fanchor = "BOTTOMRIGHT";
		offset = 2;
	elseif (anchorpos == "Bottom Left") then
		anchor = "TOPLEFT";
		fanchor = "BOTTOMLEFT";
		offset = 2;
	elseif (anchorpos == "Top Center") then
		anchor = "BOTTOM";
		fanchor = "TOP";
		offset = -2;
	elseif (anchorpos == "Bottom Center") then
		anchor = "TOP";
		fanchor = "BOTTOM";
		offset = 2;
	end
	return anchor, fanchor, offset;
end

--------------------------------------------------------------------------------------------------------------------------------------
-- FADING
--------------------------------------------------------------------------------------------------------------------------------------

function TipBuddy_Hide( frame )
	------TB_AddMessage("TipBuddy_Hide");
	TipBuddy.hasTarget = 0;
	--TB_AddMessage("TipBuddy.hasTarget = 0");

	if (frame:GetName() == "TipBuddy_Main_Frame") then
		if (GameTooltip:IsVisible() and TipBuddy.compactvis ~= 1 and not UnitExists("mouseover")) then
			TipBuddy_ForceHide(frame);
			return;
		elseif (UnitExists("mouseover")) then
			TipBuddy_ForceHide(frame);
			return;
		elseif ( frame.fadingout ) then
			return;
		end
	end

	local delayTime;
	if (TipBuddy_SavedVars["general"].delaytime) then
		delayTime = TipBuddy_SavedVars["general"].delaytime;
	else
		delayTime = 0;
	end
	TipBuddy.uName = nil;

	frame.startTime = GetTime();
	frame.endTime = frame.startTime + (0.01 + delayTime);
end

function TipBuddy_FadeOut( frame, func )
	--TB_AddMessage("TipBuddy_FadeOut");
	if (frame:GetName() == "TipBuddy_Main_Frame") then
		TipBuddy.compactvis = nil;
	end
	if ( frame.fadingout ) then
		return;
	end

	frame.fadingout = 1;
	frame.fadingin = nil;
	frame.targetalpha = 0;
	frame.animfunc_fade = func;

	local fadeTime;
	if (TipBuddy_SavedVars["general"].fadetime) then
		fadeTime = TipBuddy_SavedVars["general"].fadetime;
	else
		fadeTime = 0;
	end
	UIFrameFadeRemoveFrame(frame);
	UIFrameFadeOut( frame, (0.01 + fadeTime), frame:GetAlpha(), frame.targetalpha );
end

function TipBuddy_FadeOut_Finished()
	--TB_AddMessage("TipBuddy_FadeOut_Finished");
	this:Hide();
	this:SetAlpha( 1 );

	this.fadingout = nil;
	if ( this.animfunc_fade ) then
		this.animfunc_fade();
	end
end

function TipBuddy_FadeIn( frame, func )
	------TB_AddMessage("TipBuddy_FadeIn");
	if ( frame.fadingin ) then
		return;
	end
	if ( frame.fadingout ) then
		UIFrameFadeRemoveFrame(frame);
	end

	frame.fadingin = 1;
	frame.fadingout = nil;
	frame.targetalpha = 1;
	frame.animfunc_fade = func;
	UIFrameFadeRemoveFrame(frame);
	UIFrameFadeIn( frame, 0.01, 0.9, frame.targetalpha );
end

function TipBuddy_FadeIn_Finished()
	------TB_AddMessage("TipBuddy_FadeIn_Finished");
	this:SetAlpha( 1 );

	this.fadingin = nil;
	if ( this.animfunc_fade ) then
		this.animfunc_fade();
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
-- GAMETOOLTIP
--------------------------------------------------------------------------------------------------------------------------------------
function TB_GameTooltip_IniHooks()
		TB_AddMessage("GameTooltip_OnLoad");
		--hooking GameTooltip's AddLine
		if( not GameTooltip.tborgAddLine ) then
			GameTooltip.tborgAddLine = GameTooltip.AddLine;
			GameTooltip.AddLine = TipBuddy_GameTooltip_AddLine;
		end
		--hooking GameTooltip's AddDoubleLine
		if( not GameTooltip.tborgAddDoubleLine ) then
			GameTooltip.tborgAddDoubleLine = GameTooltip.AddDoubleLine;
			GameTooltip.AddDoubleLine = TipBuddy_GameTooltip_AddDoubleLine;
			----TB_AddMessage("adding double line hook");
		end
		--hooking GameTooltip's SetUnit
		if( not GameTooltip.orgSetUnit ) then
			GameTooltip.orgSetUnit = GameTooltip.SetUnit;
			GameTooltip.SetUnit = TipBuddy_GameTooltip_SetUnit;
		end
		--hooking GameTooltip's FadeOut
		if( not GameTooltip.orgFadeOut ) then
			GameTooltip.orgFadeOut = GameTooltip.FadeOut;
			GameTooltip.FadeOut = TipBuddy_GameTooltip_FadeOut;
		end
		--hooking GameTooltip's SetOwner
		if( not GameTooltip.orgSetOwner ) then
			--TB_AddMessage( tbcolor_nam_hostile.."hooking setowner" )
			GameTooltip.orgSetOwner = GameTooltip.SetOwner;
			GameTooltip.SetOwner = TipBuddy_GameTooltip_SetOwner;
		end
		--hooking GameTooltip's SetPoint
		if( not GameTooltip.orgSetPoint ) then
			--TB_AddMessage( tbcolor_nam_hostile.."hooking setpoint" )
			GameTooltip.orgSetPoint = GameTooltip.SetPoint;
			GameTooltip.SetPoint = TipBuddy_GameTooltip_SetPoint;
		end	
end
--hook
local originalGameTooltip_SetDefaultAnchor;
originalGameTooltip_SetDefaultAnchor = GameTooltip_SetDefaultAnchor;
function GameTooltip_SetDefaultAnchor(tooltip, parent)
	TB_AddMessage(TB_WHT_TXT.."GTT SETANCHOR");
	TipBuddy.defanch = 1;
	originalGameTooltip_SetDefaultAnchor( tooltip, parent );
	if (tooltip:GetName() ~= "GameTooltip" and tooltip:GetName() ~= "TipBuddyTooltip") then
		TipBuddy.defanch = nil;
		return;
	end
	if (parent) then
		TipBuddy.anchorparent = parent:GetName();
		--TB_AddMessage("GTT_PARENT = "..parent:GetName());
	else
		--TB_AddMessage("GTT HAS NO PARENT ");
	end
	--/script GameTooltip:SetOwner(PetActionButton5, "ANCHOR_NONE");
	if (not TipBuddy.first) then
		tooltip:Show();	
	end
	if (not TipBuddy.xpoint or not TipBuddy.anchor) then
		TipBuddy.xpoint, TipBuddy.xpos, TipBuddy.ypos = TipBuddy_GetFrameCursorOffset();
		TipBuddy.anchor, TipBuddy.fanchor, TipBuddy.offset = TipBuddy_GetFrameAnchorPos();				
	end
	TipBuddyTooltip:ClearAllPoints();
	GameTooltip:ClearAllPoints();
	TB_AddMessage("GameTooltip:ClearAllPoints()");
	if (UnitExists("mouseover") or TipBuddy.unitframe == 1) then
		GameTooltip:orgSetOwner(parent, "ANCHOR_NONE");
		GameTooltip:orgSetPoint("TOPLEFT", "UIParent", "BOTTOMRIGHT", 256, -256);
		GameTooltip.default = 0;
		TB_AddMessage("GameTooltip:orgSetPoint");
		local newparent = TipBuddy_Parent_Frame;
		if (parent.unit) then
			GameTooltip:SetUnit(parent.unit);
			TB_AddMessage(parent:GetName());
			newparent = parent;
		end
		if ( TipBuddy_SavedVars["general"].anchored == 1) then
			TB_AddMessage("GTT-ANCHORED = 1  "..TipBuddy.offset);
			TipBuddyTooltip:SetOwner(newparent, "ANCHOR_NONE");
			TipBuddyTooltip:SetPoint(TipBuddy.anchor, "TipBuddy_Parent_Frame", TipBuddy.fanchor, 0, TipBuddy.offset);	
		else
			TipBuddyTooltip:SetOwner(newparent, "ANCHOR_NONE");
			TipBuddyTooltip:SetPoint(TipBuddy.xpoint, "TipBuddy_Parent_Frame", "CENTER", 0, 0);
			TB_AddMessage("GTT-ANCHORED = 0   "..TipBuddy.xpoint);
		end
	else
		if (parent == getglobal("UIParent")) then
			if ( TipBuddy_SavedVars["general"].anchored == 1) then
				TB_AddMessage("GTT-ANCHORED = 1");
				tooltip:SetOwner(parent, "ANCHOR_NONE");
				tooltip:SetPoint(TipBuddy.anchor, "TipBuddy_Parent_Frame", TipBuddy.fanchor, 0, TipBuddy.offset);	
				tooltip.default = nil;
			else
				if (TipBuddy_SavedVars["general"].gtt_fade == 1) then
					tooltip:SetOwner(parent, "ANCHOR_NONE");
					tooltip:SetPoint(TipBuddy.xpoint, "TipBuddy_Parent_Frame", "CENTER", 0, 0);
					tooltip.default = nil;	
					TB_AddMessage("GTT-ANCHORED = 0");
				else
					TB_AddMessage("GTT-ANCHORED = CURSOR");
					tooltip:SetOwner(parent, "ANCHOR_CURSOR");
					tooltip.default = nil;
				end
			end
		elseif (TipBuddy_SavedVars["general"].nonunit_anchor == 0) then
	--		-- Or to the cursor
			tooltip:SetOwner(parent, "ANCHOR_NONE");
			tooltip:SetPoint(TipBuddy.xpoint, "TipBuddy_Parent_Frame", "CENTER", 0, 0);
			tooltip.default = nil;	
			TB_AddMessage("GTT-NONUNIT_ANCHOR = 0");
		elseif (TipBuddy_SavedVars["general"].nonunit_anchor == 1) then
			tooltip:SetOwner(parent, "ANCHOR_NONE");
			tooltip:SetPoint(TipBuddy.anchor, "TipBuddy_Parent_Frame", TipBuddy.fanchor, 0, TipBuddy.offset);	
			tooltip.default = nil;	
			TB_AddMessage("GTT-NONUNIT_ANCHOR = xxx");
		elseif (TipBuddy_SavedVars["general"].nonunit_anchor == 2) then
			local oanchor, ganchor, panchor = TipBuddy_GetIconAnchorPos(parent);
			tooltip:ClearAllPoints();
			tooltip:SetOwner(parent, oanchor);
			tooltip:SetPoint(ganchor, parent:GetName(), panchor, 0, 0);
			tooltip.default = nil;	
		end	
		TipBuddy_ForceHide( TipBuddyTooltip );
	end
	TipBuddy.defanch = nil;
end

function TipBuddy_GTT_ClearExtras()
	TipBuddy.gotextras = nil;
	TipBuddy.gtt_xtra = nil;
	TipBuddy.gtt_xtraR = nil;
	TipBuddy.vis = nil;
end

-- hook for GameTooltip_OnShow
function TipBuddy_GameTooltip_OnShow()
	TB_AddMessage(TB_WHT_TXT.."GTT OnShow");
	TipBuddy.xpoint, TipBuddy.xpos, TipBuddy.ypos = TipBuddy_GetFrameCursorOffset();
	TipBuddy.anchor, TipBuddy.fanchor, TipBuddy.offset = TipBuddy_GetFrameAnchorPos();

	if (lGameTooltip_OnShow_Orig) then
		lGameTooltip_OnShow_Orig();	
	end		
	TB_AddMessage(TB_WHT_TXT.."end GTT OnShow");
	if (TipBuddy_SavedVars["general"].reposmods and TipBuddy_SavedVars["general"].reposmods == 1) then
		--this adjusts the xy of the tooltip position ONLY if GameTooltip_SetDefaultAnchor hasn't 
		--been called and then ONLY if it extends off the screen.
		if (TipBuddy.d_own and (TipBuddy.d_own):GetName()) then
			local owner = TipBuddy.d_own or this:GetParent();
			TB_AddMessage("reposmods");
			if (UnitExists("mouseover") or TipBuddy.unitframe == 1) then

			else
				--local x2, y2 = TipBuddy_PositionFrameToCursor();
				if (not TipBuddy.uiwidth or not TipBuddy.uiheight) then
					TipBuddy.uiscale = UIParent:GetScale();
					TipBuddy.uiwidth = UIParent:GetWidth() / TipBuddy.uiscale;
					TipBuddy.uiheight = UIParent:GetHeight() / TipBuddy.uiscale;			
				end	
				if (GameTooltip:IsVisible() and GameTooltip:GetLeft()) then
					local scale = TipBuddy_SavedVars["general"].gtt_scale;
					local left = GameTooltip:GetLeft()* scale;
					local right = GameTooltip:GetRight()* scale;
					local top = GameTooltip:GetTop()* scale;
					local bottom = GameTooltip:GetBottom()* scale;
					local x, y = 0, 0;
					local off = false;
					if (left and left < -4) then
						x = (left * -1)/scale;
						off = true;
					elseif (right and right > TipBuddy.uiwidth+8) then
						x = (TipBuddy.uiwidth - right)/scale;
						off = true;
					end
					if (top and top > TipBuddy.uiheight+16) then
						y = (TipBuddy.uiheight - top)/scale;
						off = true;
					elseif (bottom and bottom < -4) then
						y = (bottom * -1)/scale;
						off = true;
					end
					TB_AddMessage("scale="..scale.."  x="..x.."  -  y="..y.."  -  top="..top.."  -  height="..TipBuddy.uiheight);
					--only readjust it if it extends off the screen
					if (owner and owner:GetName() and off == true) then
						TB_AddMessage("GameTooltip off edge");
						--local _, ganchor, panchor = TipBuddy_GetIconAnchorPos(owner);
						GameTooltip:ClearAllPoints();
						GameTooltip:SetPoint(TipBuddy.d_anch1, owner:GetName(), TipBuddy.d_anch2, x, y);
						--GameTooltip:orgSetPoint(ganchor, owner:GetName(), panchor, 0, 0);
						--/script GameTooltip:ClearAllPoints();GameTooltip:SetPoint(TipBuddy.anchor, this:GetParent():GetName(), TipBuddy.fanchor, 100, 0);
						--GameTooltip.default = nil;				
					end
				end		
				TipBuddy_ForceHide( TipBuddyTooltip );
			end
		end
	end
	if (not UnitExists("mouseover") and TipBuddy.unitframe ~= 1) then
		TipBuddy_SetFrame_BackgroundColor();
		TipBuddy_ForceHide( TipBuddyTooltip );
	end
end

--hook
local originalGameTooltip_OnHide;
originalGameTooltip_OnHide = GameTooltip_OnHide;
function GameTooltip_OnHide()
	originalGameTooltip_OnHide();
	TipBuddy_GTT_ClearExtras();
	TipBuddy.d_own = nil;
	TipBuddy.d_point = nil;
	
	--TipBuddyTooltip:Hide();
	TB_AddMessage("hiding GTT");

	--TipBuddy_TargetBuffs_Update();
	--TipBuddy_ShowRank( TipBuddy.targetType, this.unit );
	--TipBuddy_TargetInfo_ShowFaction( TipBuddy.targetType, this.unit );
end

-- hook for GameTooltip_OnEvent
function TipBuddy_GameTooltip_OnEvent()
	lGameTooltip_OnEvent_Orig(event);
	--TB_AddMessage("GTT_0NEVENT called");
end

-- hook for GameTooltip_SetUnit
function TipBuddy_GameTooltip_SetUnit(this, unit)
	--TB_AddMessage( "SET UNIT!!" )
	TipBuddy_GTT_ClearExtras();
	GameTooltip:orgSetUnit(unit);
end

-- hook for GameTooltip_FadeOut
function TipBuddy_GameTooltip_FadeOut()
	TB_AddMessage( "FadeOut" )
	GameTooltip:orgFadeOut();	
end

-- hook for GameTooltip_SetOwner
function TipBuddy_GameTooltip_SetOwner( this, owner, position, x, y )
	TipBuddy.d_own = nil;
	TipBuddy.d_point = nil;
	GameTooltip:orgSetOwner(owner, position, x, y);	
	TB_AddMessage(TB_WHT_TXT.."SetOwner");
	--if this tooltip has had its default anchor set, then don't modify it any further
	if (TipBuddy_SavedVars["general"].gtt_scale) then
		GameTooltip:SetScale(2);
		local ttScale = TipBuddy_SavedVars["general"].gtt_scale;
		if (EnhancedTooltip and EnhancedTooltip:IsVisible()) then
			ttScale = 1.0;
		end
		TipBuddy_SetEffectiveScale(GameTooltip, ttScale, UIParent);
	end
	if (TipBuddy.defanch) then
		return;	
	end
	--/script if (GameTooltip:IsOwned(BrowseButton1Item)) then TB_AddMessage("0wn3d")end;
	TB_AddMessage(TB_WHT_TXT.."SetOwner Modify");
	if (owner and owner:GetName() and TipBuddy_SavedVars["general"].reposmods and TipBuddy_SavedVars["general"].reposmods == 1) then	
		--need to check for the position because some mods don't set a position
		if (position) then
			TB_AddMessage(position..GetTime());
			position = string.gsub(position, "ANCHOR_", "");
			--TB_AddMessage(position);
			if (TB_ANCHOR[position]) then
				TipBuddy.d_anch1 = TB_ANCHOR[position].a;
				TipBuddy.d_anch2 = TB_ANCHOR[position].b;	
			elseif (position == "NONE") then
				--don't do anything
				return;
			else
				TipBuddy.d_anch1 = "BOTTOMRIGHT";
				TipBuddy.d_anch2 = "BOTTOMLEFT";
			end				
		else
			--if no positioned was passed, use the default position for anchoring
			TipBuddy.d_anch1 = "BOTTOMRIGHT";
			TipBuddy.d_anch2 = "BOTTOMLEFT";
		end
		--TB_AddMessage(owner:GetName());
		TipBuddy.d_own = owner;
		--we have to set the anchor to NONE because otherwise, we can't reposition it with SetPoint
		GameTooltip:orgSetOwner(owner, "ANCHOR_NONE");
		if (not x) then
			x = 0;	
		end
		if (not y) then
			y = 0;	
		end
		GameTooltip:ClearAllPoints();
		GameTooltip:orgSetPoint(TipBuddy.d_anch1, owner:GetName(), TipBuddy.d_anch2, x, y);	
		--TB_AddMessage(TipBuddy.d_anch1);
	end
	TB_AddMessage(TB_WHT_TXT.."endSetOwner");
	--"ANCHOR_NONE"
end

-- hook for GameTooltip_SetPoint
function TipBuddy_GameTooltip_SetPoint( this, pos1, parent, pos2, x, y )
	if (not pos1 or not parent) then
		return;	
	end
	TipBuddy.d_point = 1;
	if (TipBuddy_SavedVars["general"].gtt_scale) then
		TipBuddyTooltip:SetScale(2);	
		TipBuddy_SetEffectiveScale(TipBuddyTooltip, TipBuddy_SavedVars["general"].gtt_scale, UIParent);
		TB_AddMessage("SCALE = "..TipBuddy_SavedVars["general"].gtt_scale);
	end
	GameTooltip:orgSetPoint(pos1, parent, pos2, x, y);
	TB_AddMessage(TB_WHT_TXT.."SetPoint");
end

--/script GameTooltip:AddDoubleLine("text", "something", 1, 0, 1, 0, 0, 1);
function TipBuddy_GameTooltip_AddLine( frame, text, r, g, b, nowrap )
	if (not TipBuddy.targetUnit) then
		TipBuddy.targetUnit = "mouseover";	
	end

	GameTooltip:tborgAddLine(text, r, g, b, nowrap);
	if (not text or text == "") then
		return;	
	end
	--TB_AddMessage("GTTADDLINE!!!!!!!!!:  adding = "..string.gsub(text, " ", "_"));
	if (not TipBuddyTooltip:IsVisible() and not TipBuddy_Main_Frame:IsVisible() and not TipBuddy.vis) then
		if (TipBuddy_SavedVars["general"].blizdefault == 1 and not TipBuddy.gotextras) then
			if (not TipBuddy.gtt_xtra) then
				TipBuddy.gtt_xtra = {};
			end
			for i=1, 32, 1 do
				if (not TipBuddy.gtt_xtra[i]) then
					TipBuddy.gtt_xtra[i.."color"] = {};
					TipBuddy.gtt_xtra[i.."color"].r, TipBuddy.gtt_xtra[i.."color"].g, TipBuddy.gtt_xtra[i.."color"].b = r, g, b;
					TipBuddy.gtt_xtra[i] = text;
					--TB_AddMessage("GTTADDLINE!!!!!!!!!:  adding = "..text);
					break;
				end
			end				
		end
		return;
	end

	if (not TipBuddy.targetType) then
		TipBuddy.targetType = TipBuddy_TargetInfo_GetTargetType( TipBuddy.targetUnit );	
	end
	--TB_AddMessage("GTTADDLINE!!!!!!!!!:  "..TipBuddy.targetType.." = '"..string.gsub(text, " ", "_").."'");

	if (TipBuddy_Main_Frame:IsVisible()) then
		local line;
		for i=1, 20, 1 do	
			line = getglobal("TipBuddy_Xtra"..i.."_Text");
			if (line:GetText() and line:IsShown()) then
				----TB_AddMessage("line:  "..i.." = occupied");
				--return;	
			else
				----TB_AddMessage("line:  "..i.." = free.....setting text: "..text);
				line:SetText(text);
				if (not r) then
					r, g, b = NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b;	
				end
				line:SetTextColor(r, g, b);
				line:Show();
				break;
			end
		end

		TipBuddy_FrameHeights_Initialize(TipBuddy.targetType);
		TipBuddy_SetFrame_Width();		
	else
		if (text == " ") then
			return;	
		end
		TipBuddyTooltip:AddLine(text, r, g, b, nowrap);
		TipBuddyTooltip:Show();
	end

end

--/script GameTooltip:AddDoubleLine("text", "something", 1, 0, 1, 0, 0, 1);
function TipBuddy_GameTooltip_AddDoubleLine( frame, textL, textR, Lr, Lg, Lb, Rr, Rg, Rb )
	if (not TipBuddy.targetUnit) then
		TipBuddy.targetUnit = "mouseover";	
	end

	GameTooltip:tborgAddDoubleLine(textL, textR, Lr, Lg, Lb, Rr, Rg, Rb);
	if (not textL or textL == "") then
		return;	
	end
	--TB_AddMessage("GTTADDDOUBLELINE!!!!!!!!!:  adding = "..textL);
	if (not TipBuddyTooltip:IsVisible() and not TipBuddy_Main_Frame:IsVisible() and not TipBuddy.vis) then
		if (TipBuddy_SavedVars["general"].blizdefault == 1 and not TipBuddy.gotextras) then
			if (not TipBuddy.gtt_xtra) then
				TipBuddy.gtt_xtra = {};
			end
			if (not TipBuddy.gtt_xtraR) then
				TipBuddy.gtt_xtraR = {};
			end
			for i=1, 32, 1 do
				if (not TipBuddy.gtt_xtra[i]) then
					TipBuddy.gtt_xtra[i.."color"] = {};
					TipBuddy.gtt_xtra[i.."color"].r, TipBuddy.gtt_xtra[i.."color"].g, TipBuddy.gtt_xtra[i.."color"].b = Lr, Lg, Lb;
					TipBuddy.gtt_xtra[i] = textL;
					if (textR) then
						TipBuddy.gtt_xtraR[i.."color"] = {};
						TipBuddy.gtt_xtraR[i.."color"].r, TipBuddy.gtt_xtraR[i.."color"].g, TipBuddy.gtt_xtraR[i.."color"].b = Rr, Rg, Rb;
						TipBuddy.gtt_xtraR[i] = textR;
					end	
					--TB_AddMessage("GTTADDDOUBLELINE!!!!!!!!!:  adding = "..textL.." : "..textR);
					break;
				end
			end				
		end
		return;
	end
	if (not TipBuddy.targetType) then
		TipBuddy.targetType = TipBuddy_TargetInfo_GetTargetType( TipBuddy.targetUnit );	
	end
	----TB_AddMessage("GTTADDDOUBLELINE!!!!!!!!!:  "..TipBuddy.targetType.." = "..textL.." : "..textR);

	if (TipBuddy_Main_Frame:IsVisible()) then
		local lineL, lineR;
		for i=1, 20, 1 do	
			lineL = getglobal("TipBuddy_Xtra"..i.."_Text");
			lineR = getglobal("TipBuddy_XtraR"..i.."_Text");
			if (lineL:GetText() and lineL:IsShown()) then
				--return;	
			else
				lineL:SetText(textL);
				if (not Lr) then
					Lr, Lg, Lb = NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b;	
				end
				lineL:SetTextColor(Lr, Lg, Lb);
				lineL:Show();
				lineR:SetText(textR);
				if (not Rr) then
					Rr, Rg, Rb = NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b;	
				end
				lineR:SetTextColor(Rr, Rg, Rb);
				lineR:Show();
				break;		
			end
		end
		TipBuddy_FrameHeights_Initialize(TipBuddy.targetType);
		TipBuddy_SetFrame_Width();
	else
		TipBuddyTooltip:AddDoubleLine(textL, textR, Lr, Lg, Lb, Rr, Rg, Rb);
		TipBuddyTooltip:Show();
		--/script TipBuddyTooltip:AddDoubleLine("what", "the fuck");TipBuddyTooltip:Show();
	end
end


--------------------------------------------------------------------------------------------------------------------------------------
-- UNITFRAME HOOKS
--------------------------------------------------------------------------------------------------------------------------------------
--hook
local originalUnitFrame_OnEnter;
originalUnitFrame_OnEnter = UnitFrame_OnEnter;
function UnitFrame_OnEnter()
	originalUnitFrame_OnEnter();
	this.elapsed = 1.0;

	TipBuddy.unitframe = 1;
	TipBuddy.hasTarget = 1;
	TipBuddy.targetUnit = this.unit;	
	----TB_AddMessage("entering unit frame: "..this.unit);
	--TipBuddy.targetType = TipBuddy_TargetInfo_GetTargetType( this.unit );

	GameTooltip_SetDefaultAnchor(TipBuddyTooltip, this);
	--GameTooltip:SetUnit(this.unit);
	TipBuddy_ShowUnitTooltip(this.unit);
	--/script TipBuddy_ShowUnitTooltip("target");

	-- hiding health and mana bars because they won't update
	if ( TipBuddy_SavedVars[TipBuddy.targetType].off == 1 ) then
		TipBuddy_TargetFrameHealthBar:Hide();
		TipBuddy_TargetFrameManaBar:Hide();
		-- setting frame size again
		TipBuddy_FrameHeights_Initialize(TipBuddy.targetType);
		TipBuddy_SetFrame_Width();
	end
end

--hook
local originalUnitFrame_OnLeave;
originalUnitFrame_OnLeave = UnitFrame_OnLeave;
function UnitFrame_OnLeave()
	originalUnitFrame_OnLeave();
	TipBuddy.unitframe = 0;
	TipBuddy.hasTarget = 0;
	TipBuddy.targetUnit = nil;
	------TB_AddMessage("leaving unit frame");
	TipBuddy.uName = nil;
	TipBuddy.vis = nil;
end

--hook
local originalUnitFrame_OnUpdate;
originalUnitFrame_OnUpdate = UnitFrame_OnUpdate;
function UnitFrame_OnUpdate(elapsed)
	originalUnitFrame_OnUpdate(elapsed);

	if ( TipBuddy.unitframe == 1 and TipBuddyTooltip:IsOwned(this)) then
		this.elapsed = this.elapsed - elapsed;
		if ( this.elapsed <= 0 ) then
			this.elapsed = 1.0;
			--TB_AddMessage(this.unit);

			TipBuddy_ShowUnitTooltip(this.unit, 1);
			-- hiding health and mana bars because they won't update
			TipBuddy_TargetFrameHealthBar:Hide();
			TipBuddy_TargetFrameManaBar:Hide();
			-- setting frame size again
			TipBuddy_FrameHeights_Initialize(TipBuddy.targetType);
			TipBuddy_SetFrame_Width();

			TipBuddy.hasTarget = 1;
			----TB_AddMessage("TipBuddy.hasTarget = 1");
		end
	end
end

--hook
local originalPlayerFrame_OnUpdate;
originalPlayerFrame_OnUpdate = PlayerFrame_OnUpdate;
function PlayerFrame_OnUpdate(elapsed)
	originalPlayerFrame_OnUpdate(elapsed);

	if ( TipBuddy.unitframe == 1 and TipBuddyTooltip:IsOwned(this)) then
		this.elapsed = this.elapsed - elapsed;
		if ( this.elapsed <= 0 ) then
			this.elapsed = 1.0;
			------TB_AddMessage(this.unit);
			TipBuddy_ShowUnitTooltip(this.unit, 1);
			-- hiding health and mana bars because they won't update
			TipBuddy_TargetFrameHealthBar:Hide();
			TipBuddy_TargetFrameManaBar:Hide();
			-- setting frame size again
			TipBuddy_FrameHeights_Initialize(TipBuddy.targetType);
			TipBuddy_SetFrame_Width();
			TipBuddy.hasTarget = 1;
			----TB_AddMessage("TipBuddy.hasTarget = 1");
		end
	end
end
