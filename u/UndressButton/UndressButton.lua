-- HAXNINJA
BINDING_NAME_UndressButtonName = "Open the DressUp Frame";
BINDING_HEADER_UndressButtonHeader = "Undress Button";


function UBLoad()
	if (not AuctionDressUpFrame) then
		this:RegisterEvent("ADDON_LOADED");
	end
end

function UBEvent()
	if (event == "ADDON_LOADED") then
		if (arg1 == "Blizzard_AuctionUI") then
			this:UnregisterEvent("ADDON_LOADED");
			AuctionDressUpFrameUndressButton:SetPoint("BOTTOM", "AuctionDressUpFrameResetButton", "TOP", 0, 2);
			AuctionDressUpFrameUndressButton:SetParent("AuctionDressUpModel");
			AuctionDressUpFrameUndressButton:SetFrameLevel(AuctionDressUpFrameResetButton:GetFrameLevel());
		end
	end
end

function UBReset()
	SetPortraitTexture(DressUpFramePortrait, "player");
	SetDressUpBackground();
	DressUpModel:SetUnit("player");
end

function UBDressUpTarget()
	if (not DressUpFrame:IsVisible()) then
		ShowUIPanel(DressUpFrame);
	else
		PlaySound("gsTitleOptionOK");
	end
	if(UnitIsVisible("target")) then
		SetPortraitTexture(DressUpFramePortrait, "target");
		SetDressUpTargetBackground();
		DressUpModel:SetUnit("target");
	else
		UBReset();
	end
end

function DressUpTargetTexturePath()
	local race, fileName = UnitRace("target");
	if ( fileName == "Gnome" or fileName == "GNOME" ) then
		fileName = "Dwarf";
	elseif ( fileName == "Troll" or fileName == "TROLL" ) then
		fileName = "Orc";
	end
	if ( not fileName ) then
		fileName = "Orc";
	end

	return "Interface\\DressUpFrame\\DressUpBackground-"..fileName;
end

function SetDressUpTargetBackground()
	local texture = DressUpTargetTexturePath();
	DressUpBackgroundTopLeft:SetTexture(texture..1);
	DressUpBackgroundTopRight:SetTexture(texture..2);
	DressUpBackgroundBotLeft:SetTexture(texture..3);
	DressUpBackgroundBotRight:SetTexture(texture..4);
end