function CT_CoordMod_OnUpdate()
	local cX, cY = GetCursorPosition();
	local pX, pY = GetPlayerMapPosition("player");
	local ceX, ceY = WorldMapFrame:GetCenter();
	local wmfw, wmfh = WorldMapButton:GetWidth(), WorldMapButton:GetHeight();
	
	cX = ( ( ( cX / WorldMapFrame:GetScale() ) - ( ceX - wmfw / 2 ) ) / wmfw + 22/10000 );
	cY = ( ( ( ( ceY + wmfh / 2 ) - ( cY / WorldMapFrame:GetScale() ) ) / wmfh ) - 262/10000 );

	if ( cX < 0 ) then
		cX = "0";
	end
	if ( cY < 0 ) then
		cY = "0";
	end
	CT_CoordX:SetText("Cursor X,Y: |c00FFFFFF" .. floor(cX*100) .. "|r,|c00FFFFFF" .. floor(cY*100) .. "|r");
	CT_CoordY:SetText("Player X,Y: |c00FFFFFF" .. floor(pX*100) .. "|r,|c00FFFFFF" .. floor(pY*100) .. "|r");
end