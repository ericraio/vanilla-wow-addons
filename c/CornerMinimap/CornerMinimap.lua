--[[ CornerMinimap ]]

CornerMinimap = {
  version = 1.0
}

function CornerMinimap.OnLoad()
  this:RegisterEvent("PLAYER_ENTERING_WORLD")
end

function CornerMinimap.OnEvent()
CornerMinimap.CornerTheMap()
end

function CornerMinimap.CornerTheMap()
  -- moves the minimap
  --MinimapCluster:SetPoint("TOPRIGHT","UIParent","TOPRIGHT",15,2)
  -- nudges the zone text to center
  MinimapZoneText:SetPoint("TOP","MinimapZoneTextButton","TOP",9,1)

  -- makes clicking the zone text the "X" (toggle minimap)
  MinimapZoneTextButton:SetScript("OnClick",ToggleMinimap)
  -- sets the corner border texture
  MinimapBorder:SetTexture("Interface\\AddOns\\CornerMinimap\\CornerMinimapBorder")
  -- sets the corner title texture
  MinimapBorderTop:SetTexture("Interface\\AddOns\\CornerMinimap\\CornerMinimapBorder")
  -- sets the corner mask
  Minimap:SetMaskTexture("Interface\\AddOns\\CornerMinimap\\CornerMinimapMask")
  -- moves the tracking icon
  MiniMapTrackingFrame:SetPoint("TOPLEFT","Minimap","TOPLEFT",0,-2)
  MiniMapTrackingFrame:SetScale(.75)
end

function MiniMap_OnMouseWheel(value)
		if ( value > 0 ) then Minimap_ZoomIn()
		elseif ( value < 0 ) then Minimap_ZoomOut()
		end
end

function Minimap_ZoomIn()
	if Minimap:GetZoom() == 5 then
		Minimap:SetZoom(5);
	else
		Minimap:SetZoom(Minimap:GetZoom() + 1);
	end
end

function Minimap_ZoomOut()
	if Minimap:GetZoom() == 0 then
		Minimap:SetZoom(0);
	else
		Minimap:SetZoom(Minimap:GetZoom() - 1);
	end
end