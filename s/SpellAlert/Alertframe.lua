--[[
SpellAlert (modified again)
Author:______Sent
Thanks:______Awen_(Original_Author)
_____________Mithryn_(versions_up_to_1.65)
]]

-- ------------------- --
-- alertframe function --
-- ------------------- --

function SA_Drag_OnLoad(num)
	local saDrag = getglobal("SA_Drag"..num);
	saDrag:ClearAllPoints();
	saDrag:SetPoint("CENTER", UIParent, "CENTER", SAVars["alert"..num].left, SAVars["alert"..num].top);
end

function SA_SMF_OnLoad(num)
	SA_SMF_UpdateLook(num);
	SA_Drag_OnUpdate(num);
	getglobal("SA_Drag"..num):Hide();
	getglobal("SA_SMF"..num):AddMessage("SpellAlert Loaded!");
end

function SA_Drag_OnUpdate(num)
	SA_SMF_Adjust(num)
	getglobal("SA_SMF"..num):AddMessage(SA_STR_PROVERB);
end

function SA_SMF_Adjust(num)
	local saDrag = getglobal("SA_Drag"..num);
	local smf = getglobal("SA_SMF"..num);
	smf:ClearAllPoints();
	if ((saDrag:GetLeft()+32) < (GetScreenWidth()/3)) then
		smf:SetPoint("LEFT", saDrag, "LEFT", 0, -30);
		smf:SetJustifyH("LEFT");
	elseif ((saDrag:GetLeft()+32) < (GetScreenWidth()/1.5)) then
		smf:SetPoint("CENTER", saDrag, "CENTER", 0, -30);
		smf:SetJustifyH("CENTER");
	else
		smf:SetPoint("RIGHT", saDrag, "RIGHT", 0, -30);
		smf:SetJustifyH("RIGHT");
	end
end

function SA_SMF_UpdateLook(num)
	local smf = getglobal("SA_SMF"..num);
	local alert = "alert"..num;
	smf:SetFont(SAVars[alert].font, SAVars[alert].size, SAVars[alert].outline);
	smf:SetHeight((SAVars[alert].lines * 2) * (SAVars[alert].size + SAVars[alert].space));
	smf:SetSpacing(SAVars[alert].space);
	smf:SetMaxLines(SAVars[alert].lines);
	smf:SetTimeVisible(SAVars[alert].holdTime);
	smf:SetFadeDuration(SAVars[alert].fadeTime);
	smf:SetAlpha(SAVars[alert].alpha);
end