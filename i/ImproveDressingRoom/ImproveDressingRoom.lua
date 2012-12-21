-- Title: ImproveDressingRoom v1.2
-- Author: TotalPackage
-- Date: 05/21/2006


function ImproveAHDressingRoomModel_Load()
	if( not AuctionDressUpModel ) then
		this:RegisterEvent("ADDON_LOADED");
	else
		ImproveAHDressingRoomFrame:SetParent("AuctionDressUpFrame");
		ImproveAHDressingRoomFrame:SetFrameLevel(AuctionDressUpFrame:GetFrameLevel() + 1);
		ImproveAHDressingRoomFrame:SetPoint("BOTTOM", "AuctionDressUpFrame", "BOTTOM", 0, 3);
		ImproveAHDressingRoomFrame:Show();
		AuctionDressUpModelRotateRightButton:Hide();
		AuctionDressUpModelRotateLeftButton:Hide();
		AuctionDressUpModel:SetHeight(370);
		AuctionDressUpModel:SetPoint("BOTTOM", "AuctionDressUpFrame", "BOTTOM", 0, 10);
		AuctionDressUpFrameResetButton:SetPoint("BOTTOM", "AuctionDressUpFrame", "BOTTOM", 0, 15);
	end
end


function ImproveAHDressingRoomModel_Event()
	if (event == "ADDON_LOADED") then
		if (arg1 == "Blizzard_AuctionUI") then
			this:UnregisterEvent("ADDON_LOADED");
			ImproveAHDressingRoomFrame:SetParent("AuctionDressUpFrame");
			ImproveAHDressingRoomFrame:SetFrameLevel(AuctionDressUpFrame:GetFrameLevel() + 1);
			ImproveAHDressingRoomFrame:SetPoint("BOTTOM", "AuctionDressUpFrame", "BOTTOM", 0, 3);
			ImproveAHDressingRoomFrame:Show();
			AuctionDressUpModelRotateRightButton:Hide();
			AuctionDressUpModelRotateLeftButton:Hide();
			AuctionDressUpModel:SetHeight(370);
			AuctionDressUpModel:SetPoint("BOTTOM", "AuctionDressUpFrame", "BOTTOM", 0, 10);
			AuctionDressUpFrameResetButton:SetPoint("BOTTOM", "AuctionDressUpFrame", "BOTTOM", 0, 15);
		end
	end
end


function ImproveDressingRoomModel_OnLoad()
	idu_ismoving = nil;
	idu_ispaning = nil;
end


function ImproveDressingRoom_OnMouseDown(arg1)
	if (arg1 == "LeftButton") then
		idu_ismoving = 1;
		previousx, previousy = GetCursorPosition();
	end
	if (arg1 == "RightButton") then
		idu_ispaning = 1;
		previousx, previousy = GetCursorPosition();
	end
end


function ImproveDressingRoom_OnMouseUp(arg1,frameName)
	if (arg1 == "LeftButton") then
		idu_ismoving = nil;
	end
	if (arg1 == "RightButton") then
		idu_ispaning = nil;
	end
end


function ImproveDressingRoom_OnMouseWheel(value,frameName)
	if (frameName == "ImproveDressingRoomFrame") then
		local cz, cx, cy = DressUpModel:GetPosition();
		if ( value > 0 ) then
			idu_zoom = cz + 0.75;
		else
			idu_zoom = cz - 0.75;
		end
		DressUpModel:SetPosition(idu_zoom, cx, cy);
	elseif (frameName == "ImproveAHDressingRoomFrame") then
		local cz, cx, cy = AuctionDressUpModel:GetPosition();
		if ( value > 0 ) then
			idu_ahzoom = cz + 0.75;
		else
			idu_ahzoom = cz - 0.75;
		end
		AuctionDressUpModel:SetPosition(idu_ahzoom, cx, cy);
	end
end


function ImproveDressingRoom_OnUpdate(elapsedTime)
	if ( idu_ismoving ) then
		local currentx, currenty = GetCursorPosition();
		if (ImproveAHDressingRoomFrame:IsVisible()) then
			idu_rotation = AuctionDressUpModel:GetFacing() + ((currentx - previousx)/50);
			AuctionDressUpModel:SetFacing(idu_rotation);
		elseif (ImproveDressingRoomFrame:IsVisible()) then
			idu_rotation = DressUpModel:GetFacing() + ((currentx - previousx)/50);
			DressUpModel:SetFacing(idu_rotation);
		end
		previousx, previousy = GetCursorPosition();
	elseif ( idu_ispaning ) then
		local currentx, currenty = GetCursorPosition();
		if (ImproveAHDressingRoomFrame:IsVisible()) then
			local cz, cx, cy = AuctionDressUpModel:GetPosition();
			idu_ahpositionx = cx + ((currentx - previousx)/50);
			idu_ahpositiony = cy + ((currenty - previousy)/50);
			AuctionDressUpModel:SetPosition(cz, idu_ahpositionx, idu_ahpositiony);
		elseif (ImproveDressingRoomFrame:IsVisible()) then
			local cz, cx, cy = DressUpModel:GetPosition();
			idu_positionx = cx + ((currentx - previousx)/50);
			idu_positiony = cy + ((currenty - previousy)/50);
			DressUpModel:SetPosition(cz, idu_positionx, idu_positiony);
		end
		previousx, previousy = GetCursorPosition();
	end
end

