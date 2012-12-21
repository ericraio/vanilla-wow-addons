function IMBA_MinimapMarkers_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);

	
	IMBA_MinimapMarkers_Title:SetText("Minimap Marker");
	IMBA_MinimapMarkers_ClearMarkers:SetText("Clear Markers");
	for i=1,8,1 do
		getglobal("IMBA_MinimapMarkers_RaidMarker"..i):SetIconTargetIndex(i);
	end

	IMBA_AddAddon("Minimap Marker", "Allows the placement of Raid Markers on the minimap for the raid", IMBA_LOCATIONS_OTHER, nil, nil,nil,"IMBA_MinimapMarkers");
	IMBA_FriendlyNeighbor_UpdateTime=0;
end
