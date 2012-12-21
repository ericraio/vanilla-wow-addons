--[[--------------------------------------------------------------------------------
  ItemSync ISync_MiniMapButton

  Author:  Derkyle
  Website: http://www.manaflux.com
-----------------------------------------------------------------------------------]]


---------------------------------------------------
-- ISync:MiniMapButton_Toggle
---------------------------------------------------
function ISync:MiniMapButton_Toggle()

	if ( ISync_MainFrame:IsVisible() ) then 
		ISync_MainFrame:Hide();
	else
		ISync_MainFrame:Show();
	end
			
end


---------------------------------------------------
-- ISync:MiniMapButton_Init
---------------------------------------------------
function ISync:MiniMapButton_Init()

	if(ISync:SetVar({"OPT","MINIMAP_SHOW"}, 1, "COMPARE")) then--show the tooltip icon
		ISync_MiniMapButtonFrame:Show();
	else
		ISync_MiniMapButtonFrame:Hide();
	end
	
	ISync:MiniMapButton_UpdatePosition();
	
end


---------------------------------------------------
-- ISync:MiniMapButton_UpdatePosition
---------------------------------------------------
function ISync:MiniMapButton_UpdatePosition()
			
	ISync_MiniMapButton:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		54 - (78 * cos(ISync:SetVar({"OPT","MINIMAP_LOC"}, 305))),
		(78 * sin(ISync:SetVar({"OPT","MINIMAP_LOC"}, 305))) - 55
	);
	
	
end
