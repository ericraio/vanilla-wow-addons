--Changing Anchors Routine--------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
function aftt_GameTooltip_SetDefaultAnchor(tooltip, parent)



	--Set X and Y Default Offset-------------------------------
	-----------------------------------------------------------
		if (AF_ToolTip[aftt_localUser]["PositionX"] == nil) then
			AF_ToolTip[aftt_localUser]["PositionX"] = 0;
		end
		if (AF_ToolTip[aftt_localUser]["PositionY"] == nil) then
			AF_ToolTip[aftt_localUser]["PositionY"] = 15;
		end



	--Follow Mouse---------------------------------------------
	-----------------------------------------------------------
		if (AF_ToolTip[aftt_localUser]["Anchor"] == "mouse") then
			tooltip:SetOwner(parent, "ANCHOR_CURSOR");


	
	--Top Row--------------------------------------------------
	-----------------------------------------------------------
		elseif (AF_ToolTip[aftt_localUser]["Anchor"] == "topleft") then
			tooltip:SetOwner(parent, "ANCHOR_NONE");
			tooltip:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", AF_ToolTip[aftt_localUser]["PositionX"], -AF_ToolTip[aftt_localUser]["PositionY"]);
	
		elseif (AF_ToolTip[aftt_localUser]["Anchor"] == "top") then
			tooltip:SetOwner(parent, "ANCHOR_NONE");
			tooltip:SetPoint("TOP", "UIParent", "TOP", AF_ToolTip[aftt_localUser]["PositionX"], -AF_ToolTip[aftt_localUser]["PositionY"]);
	
		elseif (AF_ToolTip[aftt_localUser]["Anchor"] == "topright") then
			tooltip:SetOwner(parent, "ANCHOR_NONE");
			tooltip:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT", -AF_ToolTip[aftt_localUser]["PositionX"], -AF_ToolTip[aftt_localUser]["PositionY"]);



	--Center Row-----------------------------------------------
	-----------------------------------------------------------
		elseif (AF_ToolTip[aftt_localUser]["Anchor"] == "left") then
			tooltip:SetOwner(parent, "ANCHOR_NONE");
			tooltip:SetPoint("LEFT", "UIParent", "LEFT", AF_ToolTip[aftt_localUser]["PositionX"], AF_ToolTip[aftt_localUser]["PositionY"]);
	
		elseif (AF_ToolTip[aftt_localUser]["Anchor"] == "center") then
			tooltip:SetOwner(parent, "ANCHOR_NONE");
			tooltip:SetPoint("CENTER", "UIParent", "CENTER", AF_ToolTip[aftt_localUser]["PositionX"], AF_ToolTip[aftt_localUser]["PositionY"]);
	
		elseif (AF_ToolTip[aftt_localUser]["Anchor"] == "right") then
			tooltip:SetOwner(parent, "ANCHOR_NONE");
			tooltip:SetPoint("RIGHT", "UIParent", "RIGHT", -AF_ToolTip[aftt_localUser]["PositionX"], AF_ToolTip[aftt_localUser]["PositionY"]);



	--Bottom Row-----------------------------------------------
	-----------------------------------------------------------
		elseif (AF_ToolTip[aftt_localUser]["Anchor"] == "bottomleft") then
			tooltip:SetOwner(parent, "ANCHOR_NONE");
			tooltip:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", AF_ToolTip[aftt_localUser]["PositionX"], AF_ToolTip[aftt_localUser]["PositionY"]);
	
		elseif (AF_ToolTip[aftt_localUser]["Anchor"] == "bottom") then
			tooltip:SetOwner(parent, "ANCHOR_NONE");
			tooltip:SetPoint("BOTTOM", "UIParent", "BOTTOM", AF_ToolTip[aftt_localUser]["PositionX"], AF_ToolTip[aftt_localUser]["PositionY"]);

		elseif (AF_ToolTip[aftt_localUser]["Anchor"] == "bottomright") then
			tooltip:SetOwner(parent, "ANCHOR_NONE");
			tooltip:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -AF_ToolTip[aftt_localUser]["PositionX"], AF_ToolTip[aftt_localUser]["PositionY"]);



	--Default--------------------------------------------------
	-----------------------------------------------------------
		else
			aftt_OriginalGameTooltip_SetDefaultAnchor(tooltip, parent);
		end
end