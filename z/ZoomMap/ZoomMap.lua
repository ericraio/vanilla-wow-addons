ZOOMMAPPING_TIMER = 5;
ZOOMMAPPING_FADE_TIMER = 0.5;
CURSOR_OFFSET_X = -7;
CURSOR_OFFSET_Y = -9;

function ZoomMap_OnLoad()
	ZoomMapPing.fadeOut = nil;
	this:SetSequence(0);
	this:RegisterEvent("MINIMAP_PING");
	this:RegisterEvent("MINIMAP_UPDATE_ZOOM");
	ZoomMapCluster:Hide();
end

function ToggleZoomMap(show)
	if(ZoomMapCluster:IsVisible() or show == 0) then
		PlaySound("igMiniMapClose");
		ZoomMapCluster:Hide();
		Minimap:Show();
		
		if(Minimap:GetZoom() == 0) then
			Minimap:SetZoom(Minimap:GetZoom()+1);	
			Minimap:SetZoom(Minimap:GetZoom()-1);
		else
			Minimap:SetZoom(Minimap:GetZoom()-1);	
			Minimap:SetZoom(Minimap:GetZoom()+1);
		end
		
	else
		PlaySound("igMiniMapOpen");
		Minimap:Hide();
		ZoomMapCluster:Show();
	
		if(ZoomMap:GetZoom() == 0) then
			ZoomMap:SetZoom(ZoomMap:GetZoom()+1);	
			ZoomMap:SetZoom(ZoomMap:GetZoom()-1);
		else
			ZoomMap:SetZoom(ZoomMap:GetZoom()-1);	
			ZoomMap:SetZoom(ZoomMap:GetZoom()+1);
		end
		
				
	end
end



function ZoomMap_Update()

end

function ZoomMap_OnEvent()
	if ( event == "MINIMAP_PING" ) then
		ZoomMap_SetPing(arg2, arg3, 1);
		ZoomMap.timer = MINIMAPPING_TIMER;
	elseif ( event == "MINIMAP_UPDATE_ZOOM" ) then
		ZoomMapZoomIn:Enable();
		ZoomMapZoomOut:Enable();
		local zoom = ZoomMap:GetZoom();
		if ( zoom == (ZoomMap:GetZoomLevels() - 1) ) then
			ZoomMapZoomIn:Disable();
		elseif ( zoom == 0 ) then
			ZoomMapZoomOut:Disable();
		end
	end
end

function ZoomMap_OnUpdate(elapsed)
	if ( ZoomMap.timer > 0 ) then
		ZoomMap.timer = ZoomMap.timer - elapsed;
		if ( ZoomMap.timer <= 0 ) then
			ZoomMapPing_FadeOut();
		else
			ZoomMap_SetPing(ZoomMap:GetPingPosition());
		end
	elseif ( ZoomMapPing.fadeOut ) then
		ZoomMapPing.fadeOutTimer = ZoomMapPing.fadeOutTimer - elapsed;
		if ( ZoomMapPing.fadeOutTimer > 0 ) then
			ZoomMapPing:SetAlpha(255 * (ZoomMapPing.fadeOutTimer/ZOOMMAPPING_FADE_TIMER))
		else
			ZoomMapPing.fadeOut = nil;
			ZoomMapPing:Hide();
		end
	end
 end

function ZoomMap_SetPing(x, y, playSound)
	x = x * ZoomMap:GetWidth();
	y = y * ZoomMap:GetHeight();
	
	if ( sqrt(x * x + y * y) < (ZoomMap:GetWidth() / 2) ) then
		ZoomMapPing:SetPoint("CENTER", "ZoomMap", "CENTER", x, y);
		ZoomMapPing:SetAlpha(255);
		ZoomMapPing:Show();
		if ( playSound ) then
			PlaySound("MapPing");
		end
	else
		ZoomMapPing:Hide();
	end
	
end

function ZoomMapPing_FadeOut()
	ZoomMapPing.fadeOut = 1;
	ZoomMapPing.fadeOutTimer = ZOOMMAPPING_FADE_TIMER;
end

function ZoomMap_ZoomInClick()
	ZoomMapZoomOut:Enable();
	PlaySound("igMiniMapZoomIn");
	ZoomMap:SetZoom(ZoomMap:GetZoom() + 1);
	if(ZoomMap:GetZoom() == (ZoomMap:GetZoomLevels() - 1)) then
		ZoomMapZoomIn:Disable();
	end
end

function ZoomMap_ZoomOutClick()
	ZoomMapZoomIn:Enable();
	PlaySound("igMiniMapZoomOut");
	ZoomMap:SetZoom(ZoomMap:GetZoom() - 1);
	if(ZoomMap:GetZoom() == 0) then
		ZoomMapZoomOut:Disable();
	end
end

function ZoomMap_OnClick()
	local x, y = GetCursorPosition();
	x = x / this:GetScale();
	y = y / this:GetScale();

	local cx, cy = this:GetCenter();
	x = x + CURSOR_OFFSET_X - cx;
	y = y + CURSOR_OFFSET_Y - cy;
	if ( sqrt(x * x + y * y) < (this:GetWidth() / 2) ) then
		ZoomMap:PingLocation(x, y);
	end
end

function ZoomMap_ZoomIn()
	ZoomMapZoomIn:Click();
end

function ZoomMap_ZoomOut()
	ZoomMapZoomOut:Click();
end