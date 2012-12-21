local SUBFRAMES = {
	["FishingLocationsFrame"] = {
	   ["name"] = FishingBuddy.LOCATIONS_TAB,
	   ["tooltip"] = FishingBuddy.LOCATIONS_INFO,
	   ["toggle"] = "_LOC",
	   ["id"] = "1",
	},
	["FishingOutfitFrame"] = {
	   ["name"] = FishingBuddy.OUTFITS_TAB,
	   ["tooltip"] = FishingBuddy.OUTFITS_INFO,
	   ["toggle"] = "_OUT",
	   ["id"] = "2",
	},
	["FishingTrackingFrame"] = {
	   ["name"] = FishingBuddy.TRACKING_TAB,
	   ["tooltip"] = FishingBuddy.TRACKING_INFO,
	   ["toggle"] = "_TRK",
	   ["id"] = "3",
	},
	["FishingOptionsFrame"] = {
	   ["name"] = FishingBuddy.OPTIONS_TAB,
	   ["tooltip"] = FishingBuddy.OPTIONS_INFO,
	   ["toggle"] = "_OPT",
	   ["id"] = "4",
	}
};

local function DisableSubFrame(frameName)
   for value,info in SUBFRAMES do 
      if ( value == frameName ) then
	 local id = info.id;
	 local hideframe = string.format("FishingBuddyFrameTab%d", id);
	 local f = getglobal(hideframe);
	 if ( f ) then
	    f:Hide();
	 end
	 id = id + 1;
	 f = getglobal("FishingBuddyFrameTab"..id);
	 if ( f ) then
	    f:SetPoint("LEFT", hideframe, "LEFT", 0, 0)
	 end
      end
   end
end
FishingBuddy.DisableSubFrame = DisableSubFrame;

local function ShowSubFrame(frameName)
   for value,_ in SUBFRAMES do 
      local frame = getglobal(value);
      if ( frame ) then
	 if ( value == frameName ) then
	    frame:Show()
	 else
	    frame:Hide();	
	 end
      end
   end
end

function ToggleFishingBuddyFrame(tab)
   if ( tab == "FishingOutfitFrame" and not OutfitDisplayFrame_OnLoad and not FishingOutfitFrame:IsVisible() ) then
      return;
   end
   local subFrame = getglobal(tab);
   if ( subFrame ) then
      local id = subFrame:GetID();
      PanelTemplates_SetTab(FishingBuddyFrame, id);
      if ( FishingBuddyFrame:IsVisible() ) then
	 if ( subFrame:IsVisible() ) then
	    HideUIPanel(FishingBuddyFrame);	
	 else
	    ShowSubFrame(tab);
	 end
      else
	 ShowUIPanel(FishingBuddyFrame);
	 ShowSubFrame(tab);
      end
   end
end

local TABFRAMES = {};
function FishingBuddyFrameTab_OnClick()
   ToggleFishingBuddyFrame(TABFRAMES[this:GetName()]);
   PlaySound("igCharacterInfoTab");
end

function FishingBuddyFrame_OnLoad()
   -- Act like Blizzard windows
   UIPanelWindows["FishingBuddyFrame"] = { area = "left", pushable = 999 }; 
   -- Close with escape key
   tinsert(UISpecialFrames, "FishingBuddyFrame"); 

   -- Tab Handling code
   PanelTemplates_SetNumTabs(this, 4);
   PanelTemplates_SetTab(this, 1);

   this:RegisterEvent("VARIABLES_LOADED");
end

function FishingBuddyFrame_OnEvent(event)
   if ( event == "VARIABLES_LOADED" ) then
      -- set up mappings
      for frame,info in SUBFRAMES do
	 local f = getglobal(frame);
	 if ( f ) then
	    f:SetID(info.id);

	    local tabname = "FishingBuddyFrameTab"..info.id;
	    TABFRAMES[tabname] = frame;
	    local tab = getglobal(tabname);
	    tab:SetText(info.name);
	    tab.tooltip = info.tooltip;
	    tab.toggle = "TOGGLEFISHINGBUDDY"..info.toggle;
	 else
	    DisableSubFrame(frame);
	 end
      end
      ToggleFishingBuddyFrame("FishingLocationsFrame");
   end
end

function FishingBuddyFrame_OnShow()
	FishingBuddyFramePortrait:SetTexture("Interface\\LootFrame\\FishingLoot-Icon");
	FishingBuddyNameText:SetText(FishingBuddy.WINDOW_TITLE);
	UpdateMicroButtons();
end

function FishingBuddyFrame_OnHide()
	UpdateMicroButtons();
end
