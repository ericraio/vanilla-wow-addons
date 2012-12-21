--[[
  Guild Event Manager by Kiki of European Cho'gall (Alliance)
    Main GUI - By Alexandre Flament & Kiki
]]

local firstShow = true;

function GEMMain_SelectTab(tab)
	PanelTemplates_SetTab(GEMMainFrame, tab);
	local TabFrames = {
			[1] = "GEMListFrame",
			[2] = "GEMNewFrame",
			[3] = "GEMPlayersFrame",
			[4] = "GEMOptionsFrame",
			[5] = "GEMDebugFrame",
		};
	for id, name in TabFrames do
		if (id == tab) then
			getglobal(name):Show();
		else
			getglobal(name):Hide();
		end
	end
end

function GEMMain_OnMouseUp()
	if ( GEMMainFrame.isMoving ) then
		GEMMainFrame:StopMovingOrSizing();
		GEMMainFrame.isMoving = false;
	end
end

function GEMMain_OnMouseDown(button)
	if ( ( ( not GEMMainFrame.isLocked ) or ( GEMMainFrame.isLocked == 0 ) ) and ( arg1 == "LeftButton" ) ) then
		GEMMainFrame:StartMoving();
		GEMMainFrame.isMoving = true;
	end
end

function GEMMain_OnHide()
	if ( GEMMainFrame.isMoving ) then
		GEMMainFrame:StopMovingOrSizing();
		GEMMainFrame.isMoving = false;
	end
end

function GEMMain_OnShow()
	if (firstShow) then
		GEMMain_SelectTab(1);
		firstShow = false;
	end;
	if(GEM_OldVersion)
	then
		GEMMainFrameTitle:SetText(GEM_TITLE.." v"..GEM_VERSION..GEM_TEXT_OBSOLETE);
	elseif(GEM_NewMinorVersion)
	then
		GEMMainFrameTitle:SetText(GEM_TITLE.." v"..GEM_VERSION..GEM_TEXT_NEW_MINOR);
	else
		GEMMainFrameTitle:SetText(GEM_TITLE.." v"..GEM_VERSION);
	end
end

function GEMMain_OnLoad()
	tinsert(UISpecialFrames,"GEMMainFrame");
	
	PanelTemplates_SetNumTabs(GEMMainFrame, 4);
	PanelTemplates_SetTab(GEMMainFrame, 1);
	GEMMinimapButton_Update();
	GEMMinimapButton:Show();
	GEMMinimapButtonText:SetText("");
	GEMMinimapButtonText:SetTextColor(1.0,0.1,0.1);
	if ButtonHole then
		ButtonHole.application.RegisterMod({id="GEMGUILDEVENTMANAGER", name="Guild Event Manager",tooltip="Easily handle and schedule planned guild events", buttonFrame="GEMMinimapButton", updateFunction="GEMMinimapButton_Update"});
	end
end

function GEM_Toggle(page)
  if (GEMMainFrame:IsVisible()) then
    GEMMainFrame:Hide();
  else
    if(page)
    then
      firstShow = false;
      GEMMain_SelectTab(page);
    end
    GEMMainFrame:Show();
  end
end


-------- Minimap button ------
function GEMMinimapButton_Update()
  if(GEM_PlayerName)
  then
    local radius = GEM_Events.MinimapRadiusOffset;
    local arc = GEM_Events.MinimapArcOffset;
    GEMMinimapButton:SetPoint( "TOPLEFT", "Minimap", "TOPLEFT",55 - ( ( radius ) * cos( arc ) ),( ( radius ) * sin( arc ) ) - 55);
    GEMMinimapButtonTexture:SetTexture("Interface\\Icons\\"..GEM_Events.MinimapTexture);
  end
end


-------- HELP ------
function GEM_Help_SetTooltip()
	local uiX, uiY = UIParent:GetCenter();
	local thisX, thisY = this:GetCenter();

	local anchor = "";
	if ( thisY > uiY ) then
		anchor = "BOTTOM";
	else
		anchor = "TOP";
	end
	
	if ( thisX < uiX  ) then
		if ( anchor == "TOP" ) then
			anchor = "TOPLEFT";
		else
			anchor = "BOTTOMRIGHT";
		end
	else
		if ( anchor == "TOP" ) then
			anchor = "TOPRIGHT";
		else
			anchor = "BOTTOMLEFT";
		end
	end
	GameTooltip:SetOwner(this, "ANCHOR_" .. anchor);
end

function GEM_Help_LoadText()
 local texts = {
    GEM_HELP_EVENTS_TAB_EVENTS,
    GEM_HELP_PLAYERS_TAB_MEMBERS,
    GEM_HELP_NEW_TAB_TEMPLATES,
    GEM_HELP_NEW_TAB_SORTING,
    GEM_HELP_NEW_TAB_CONFIG,
  };

  this.text = texts[this:GetID()];
end

