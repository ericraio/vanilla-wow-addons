--[[
--	//////////////////////////////////////////////
--	Variables Init
--	//////////////////////////////////////////////
]]
local rpgoCPD_TITLE			="CharacterPaperdoll";
local rpgoCPD_ABBR			="CPP";
local rpgoCPD_AUTHOR		="calvin";
local rpgoCPD_EMAIL			="calvin@rpgoutfitter.com";
local rpgoCPD_URL			="www.rpgoutfitter.com";
local rpgoCPD_DATE			="May 12, 2006";
local rpgoCPD_PROVIDER		="rpgo";
local rpgoCPD_VERSION		="1.0";
local rpgoCPDheight=35;
--[[// OnLoad
--	////////////////////////////////////////////]]
function rpgoCPD_OnLoad()
	this:RegisterEvent("SCREENSHOT_FAILED");
	this:RegisterEvent("SCREENSHOT_SUCCEEDED");
	rpgo_VerboseMsg(rpgo_ColorizeTitle(rpgoCPD_PROVIDER,rpgoCPD_TITLE).." [v" .. rpgoCPD_VERSION .. "] loaded.");
end
function rpgoCPD_PicSave()
	if ( (not CharacterFrame:IsVisible()) or (not CharacterFrame:IsVisible()) ) then return; end
	if(rpgoCPDtmp) then
		rpgoCPD_Restore();
		return;
	else
		rpgoCPDtmp={};
	end
	if(not rpgoCPD) then rpgoCPD={}; end
	local rpgoCPDres=rpgo_Arg2Ary(GetScreenResolutions());
	rpgoCPD.res=rpgoCPDres[GetCurrentResolution()];
	rpgoCPD.height=GetScreenHeight();
	rpgoCPD.width=GetScreenWidth();
	rpgoCPD.h=CharacterFrame:GetHeight();
	rpgoCPD.w=CharacterFrame:GetWidth();
	rpgoCPD.x=CharacterFrame:GetLeft();
	rpgoCPD.y=rpgoCPD.height-CharacterFrame:GetTop();
	rpgoCPD.sc=CharacterFrame:GetScale();
	rpgoCPD.sm=CharacterModelFrame:GetModelScale();
	rpgoCPD.sp=(rpgoCPD.height-rpgoCPDheight)/rpgoCPD.h;
	CharacterFrame:SetScale(rpgoCPD.sc*rpgoCPD.sp);
	CharacterModelFrame:SetModelScale(rpgoCPD.sm/rpgoCPD.sp);
	CharacterModelFrame:SetFacing(PI/8);
	rpgoCPDtmp.CFpoint=CharacterFrame:GetPoint(1);
	CharacterFrame:SetPoint("TOPLEFT",0,-rpgoCPDheight);
	CharacterModelFrameRotateLeftButton:SetScale(rpgoCPD.sm/rpgoCPD.sp);
	CharacterModelFrameRotateRightButton:SetScale(rpgoCPD.sm/rpgoCPD.sp);
	rpgoCPDtmp.CMFBLBpoint=CharacterModelFrameRotateLeftButton:GetPoint(1);
	CharacterModelFrameRotateLeftButton:SetPoint("TOPLEFT",90,40);
	CharacterAttributesFrame:Hide();
	CharacterResistanceFrame:Hide();
	CharacterFrame:Raise();
	rpgoCPD.y1=rpgoCPD.height-CharacterFrame:GetTop();
--	TakeScreenshot();
end
function rpgoCPD_Restore()
	if(not rpgoCPDtmp) then return end;
	CharacterModelFrameRotateLeftButton:SetScale(rpgoCPD.sm);
	CharacterModelFrameRotateRightButton:SetScale(rpgoCPD.sm);
	CharacterModelFrameRotateLeftButton:SetPoint(rpgoCPDtmp.CFpoint,0,0);
	CharacterAttributesFrame:Show();
	CharacterResistanceFrame:Show();
	CharacterFrame:SetScale(rpgoCPD.sc);
	CharacterModelFrame:SetModelScale(rpgoCPD.sm);
	CharacterFrame:SetPoint(rpgoCPDtmp.CMFBLBpoint, rpgoCPD.x, -rpgoCPD.y);
	rpgoCPDtmp=nil;
end

--[[//////////////////////////////////////////////
--	general rpgo functions (shared)
--	////////////////////////////////////////////]]
-- USAGE: rpgo_VerboseMsg(msg)
if (not rpgo_VerboseMsg) then
	rpgo_VerboseMsg=function(msg)
		DEFAULT_CHAT_FRAME:AddMessage(msg); end end
-- USAGE: rpgo_ColorizeTitle(provider,title)
if (not rpgo_ColorizeTitle) then
	rpgo_ColorizeTitle=function(provider,title)
		if(not rpgoColorTitle) then rpgoColorTitle="909090"; end
		if(provider and title) then return rpgo_ColorizeMsg(rpgoColorTitle,provider.."-"..title); end end end
-- USAGE: rpgo_ColorizeMsg(color,msg)
if (not rpgo_ColorizeMsg) then
	rpgo_ColorizeMsg=function(color,msg)
		if(color and msg) then return "|cff"..color..msg.."|r"; end end end
-- USAGE: rpgo_Arg2Ary(...)
if (not rpgo_SetTooltip) then
	rpgo_Arg2Ary=function(...)
	local tab={}; for i=1,arg.n,1 do tab[i]=arg[i]; end return tab; end end
-- USAGE: rpgo_SetTooltip(color,msg)
if (not rpgo_SetTooltip) then
	rpgo_SetTooltip=function()
		GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT"); end end
