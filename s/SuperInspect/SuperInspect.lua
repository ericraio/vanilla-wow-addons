--[[

	SuperInspect: ---------
		copyright 2005-2006 by Chester

]]

SUPERINSPECT_VERSION = "1.16";

BINDING_HEADER_SUPERINSPECT = "Super Inspect";
BINDING_NAME_SUPERINSPECT = "Inspect Target";

SuperInspect = {};

UIPanelWindows["SuperInspectFrame"] = { area = "left", pushable = 0 };

function SuperInspectFrame_Load_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("ADDON_LOADED");
	
	SLASH_SUPERINSPECT1 = "/superinspect";
	SlashCmdList["SUPERINSPECT"] = function(msg)
		SuperInspect_SlashCommand(msg);
	end	
end


function SuperInspectFrame_Load_OnEvent()
	if( event == "VARIABLES_LOADED" ) then
--[[	if( DEFAULT_CHAT_FRAME ) then
			DEFAULT_CHAT_FRAME:AddMessage("|cffffd200SuperInspect |cffffff00v"..SUPERINSPECT_VERSION.." loaded.");
			if (not IsAddOnLoaded("SuperInspect_UI")) then
				--DEFAULT_CHAT_FRAME:AddMessage("|cffffd200SuperInspect is not loaded");
			end
		end
	]]	
		if (not SI_Save) then
			SI_Save = { };
			SI_Save.default = 1;
		end

		InspectUnit = SuperInspect_InspectTargetHooked;
		InspectFrame_OnUpdate = SuperInspect_InspectFrame_Nothing;
		InspectTitleText = SI_DummyText;
		
		-- keeps the inspect selection from greying out on the targetframe dropdown
		UnitPopupButtons["INSPECT"] = { text = TEXT(INSPECT), dist = 0 };
	end
	if( event == "ADDON_LOADED" and arg1 == "SuperInspect_UI") then
		--DEFAULT_CHAT_FRAME:AddMessage("|cffffd200SuperInspect is loaded!");
		SuperInspectFrame.uiScale = SuperInspect_GetUIScale();
		if (SI_Save.framepos_L or SI_Save.framepos_T) then
			SuperInspectFrame:ClearAllPoints();
			SuperInspectFrame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", SI_Save.framepos_L, SI_Save.framepos_T);
		else
			SuperInspectFrame:ClearAllPoints();
			SuperInspectFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
			SI_Save.framepos_L = SuperInspectFrame:GetLeft();
			SI_Save.framepos_T = SuperInspectFrame:GetTop();
		end
	end
end

function SI_AddMessage( text )
	if (not text) then
		return;	
	end
	if (SI_Save.debug) then
		ChatFrame3:AddMessage(GREEN_FONT_COLOR_CODE..""..text.."");
	end
end

function SuperInspect_GetUIScale()
	local uiScale;
	if ( GetCVar("useUiScale") == "1" ) then
		uiScale = tonumber(GetCVar("uiscale"));
	else
		uiScale = 1.0;
	end
	return uiScale;
end

function SuperInspect_GetEffectiveScale(frame)
	return frame:GetEffectiveScale()
end

function SuperInspect_SetEffectiveScale(frame, scale, parentframe)
	frame.scale = scale;  -- Saved in case it needs to be re-calculated when the parent's scale changes.
	local parent = getglobal(parentframe);
	if ( not parent ) then
		parent = getglobal("UIParent");
	end
	scale = scale / parent:GetEffectiveScale()
	frame:SetScale(scale);
end

function SuperInspect_SlashCommand(msg)
	if( not msg or msg == "" ) then
		DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20SuperInspect Commands:");
		DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20/superinspect scale <number> |cff3366ff- scale the window between 0.25 and 2.0 (default is 0.75)");
		DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20/superinspect reset |cff3366ff- reset the frame to the center of your screen");
		DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20/superinspect defaulttoggle |cff3366ff- toggle default mode on/off (when on, SI acts like the default inspect window. when off, you can drag and scale the window)");
		DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20/superinspect itembgtoggle |cff3366ff- toggle the art used to display quality color of items");
		DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20/superinspect durabilitytoggle |cff3366ff- toggle durability info that is shown when inspecting yourself");
		DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20/superinspect sound |cff3366ff- toggle the open and close window sound");

		return;
	end
	if (string.find(msg, "scale") ~= nil) then
		for scale in string.gfind(msg, "scale%s(%d.*)") do
			SuperInspect.s = tonumber(scale);
		end
		if (SuperInspect.s) then
			if (SuperInspect.s > 2) then
				SuperInspect.s = 2;
			elseif (SuperInspect.s < 0.25) then
				SuperInspect.s = 0.25;
			end
			if (not IsAddOnLoaded("SuperInspect_UI")) then
				UIParentLoadAddOn("SuperInspect_UI");
			end
			SuperInspectFrame:SetScale(3);
			SuperInspect_SetEffectiveScale(SuperInspectFrame, SuperInspect.s, "UIParent");
			--SuperInspect_ModelFrame:SetScale(SuperInspectFrame:GetEffectiveScale());
			SuperInspect_ResetFrame();
			SuperInspect_ModelFrame:RefreshUnit();
			SI_Save.scale = SuperInspect.s;
			DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20SuperInspect: SuperInspect frame scale now set to: "..SuperInspect.s);
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20SuperInspect: Please type a scale number after 'scale' (valid numbers: 0.5-2.0, ex: /superinspect scale 0.8)");
		end
		return;
--/script CSG_Main_Frame:SetScale(UIParent:GetScale() * 0.75);
	end
	if( msg == "reset" ) then
		if (not UIParentLoadAddOn("SuperInspect_UI")) then
			return; 
		end
		SuperInspect_ResetFrame();
		DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20SuperInspect: resetting frame to the center of the screen");
	end
	if( msg == "defaulttoggle" ) then
		if (not UIParentLoadAddOn("SuperInspect_UI")) then
			return; 
		end
		if (SI_Save.default) then
			SI_Save.default = nil;
			SuperInspect_ResetFrame();
			DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20SuperInspect: window is not longer Blizzard style (free to move and scale)");						
		else
			SI_Save.default = 1;
			SuperInspect_ResetFrame();
			DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20SuperInspect: window will now behave like the default Blizzard version (scale and position is locked)");			
		end
	end
	if( msg == "itembgtoggle" ) then
		if (not UIParentLoadAddOn("SuperInspect_UI")) then
			return; 
		end
		if (SI_Save.itembg) then
			SI_Save.itembg = nil;
			if (SuperInspectFrame:IsVisible()) then
				SuperInspectFrame:Hide();
				SuperInspectFrame:Show();
			end
			DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20SuperInspect: item quality art is now using BORDERS");						
		else
			SI_Save.itembg = 1;
			if (SuperInspectFrame:IsVisible()) then
				SuperInspectFrame:Hide();
				SuperInspectFrame:Show();
			end
			DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20SuperInspect: item quality art is now using TABS");	
		end
	end
	--SI_Save.durabilityoff
	if( msg == "durabilitytoggle" ) then
		if (not UIParentLoadAddOn("SuperInspect_UI")) then
			return; 
		end

		if (SI_Save.durabilityoff) then
			SI_Save.durabilityoff = nil;
			SuperInspect_ResetFrame();
			DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20SuperInspect: durability info will now be shown");						
		else
			SI_Save.durabilityoff = 1;
			SuperInspect_ResetFrame();
			DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20SuperInspect: durability info will no longer be shown");	
		end
	end
	if( msg == "sound" ) then
		if (not UIParentLoadAddOn("SuperInspect_UI")) then
			return; 
		end
		if (SI_Save.snd) then
			SI_Save.snd = nil;
			DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20SuperInspect: click sound OFF");						
		else
			SI_Save.snd = 1;
			PlaySound("igCharacterInfoOpen");
			DEFAULT_CHAT_FRAME:AddMessage("|cff20ff20SuperInspect: click sound ON");	
		end
	end
end

function SuperInspect_InspectFrame_Nothing()
	--what
end

function SuperInspect_InspectTarget(unit)
	if (not UIParentLoadAddOn("SuperInspect_UI")) then
		--UIParentLoadAddOn("SuperInspect_UI");
		--SuperInspect_InspectTarget(unit);
		return; 
	end
	if (not unit) then
		unit = "target";	
	end
	if (SuperInspectFrame:IsVisible()) then
		HideUIPanel(SuperInspectFrame);
		SuperInspect.isVisible = nil;
		return;
	else
		if (not UnitExists("target")) then
			TargetUnit("player");
		end
		SuperInspect_UpdateModel(unit);	
	end
end

function SuperInspect_InspectTargetHooked(unit)
	if (not UIParentLoadAddOn("SuperInspect_UI")) then
		return; 
	end
	if (not unit) then
		unit = "target";	
	end
	if (not UnitExists("target")) then
		TargetUnit("player");
	end
	SuperInspect_UpdateModel(unit);	
end

