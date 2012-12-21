--[[--------------------------------------------------------------------------------
  ItemSync ItemID Tool Framework

  Author:  Derkyle
  Website: http://www.manaflux.com
-----------------------------------------------------------------------------------]]


---------------------------------------------------
-- ISync:ItemIDSearch_Binding()
---------------------------------------------------
function ISync:ItemIDSearch_Binding()
	if(ISYNC_LOADYES == 1) then
		if ( ISync_ItemIDFrame:IsVisible() ) then ISync_ItemIDFrame:Hide(); else ISync_ItemIDFrame:Show(); end
	end
end

---------------------------------------------------
--ISync:ItemIDSearch()
---------------------------------------------------
function ISync:ItemIDSearch()

	local _, _, userLink = string.find(ISync_ItemIDFrameEdit:GetText(), "(%d+:?%d*:?%d*:?%d*)");
	
	if userLink then
		
		local isInLocalDatabase = GetItemInfo("item:" .. userLink);
			
			if isInLocalDatabase then
				UIParent.TooltipButton = 1;
				GameTooltip:SetOwner(UIParent, "ANCHOR_BOTTOMRIGHT");
				GameTooltip:SetHyperlink("item:" .. userLink);
				GameTooltip:Hide();
			else
				UIParent.TooltipButton = 1;
				GameTooltip:SetOwner(UIParent, "ANCHOR_BOTTOMRIGHT");
				GameTooltip:SetHyperlink("item:" .. userLink);
				GameTooltip:Hide();
			end
			
			local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:" .. userLink);
			
			if(name_X and link_X and quality_X) then
				
				local sItem = ISync:GetItemID(link_X);
			
				if (sItem and ISync:SetVar({"FILTERS",quality_X}, 1, "COMPARE")) then --check filter

					local sPL  = string.gsub(sItem, "^(%d+):(%d+):(%d+):(%d+)$", "%1:0:%3:0");
					local xPL1 = string.gsub(sItem, "^(%d+):(%d+):(%d+):(%d+)$", "%1");
					local xPL2 = string.gsub(sItem, "^(%d+):(%d+):(%d+):(%d+)$", "%3");

					if(not sPL or not xPL1 or not xPL2) then
						DEFAULT_CHAT_FRAME:AddMessage("|c00A2D96FItemSync: No Item");
						return nil;
					end --don't bother

					xPL1 = tonumber(xPL1);
					xPL2 = tonumber(xPL2);
			
					if(not ISync:FetchDB(xPL1, "chk")) then
					
						ISync:SetDB(xPL1, "subitem", xPL2);
						ISync:SetDB(xPL1, "quality", quality_X);
						ISync:SetDB(xPL1, "idchk", 1);

						--parse it
						ISync:Do_Parse(UIParent, ISyncTooltip, xPL1, link_X);

					--check if we have it as a subitem, if not add it
					elseif(xPL2 ~= 0 and not ISync:FetchDB(xPL1, "subitem", xPL2)) then

						ISync:SetDB(xPL1, "subitem", xPL2);

					end--if(not ISync:FetchDB(name_X, "item")) then
				
					--now show it if we haven't disconnected yet
					DEFAULT_CHAT_FRAME:AddMessage("|c00A2D96FItemSync: "..name_X.." <<>> |r|c"..ISync:ReturnHexColor(quality_X).."|H"..link_X.."|h["..name_X.."]|h|r");
					
				else
					DEFAULT_CHAT_FRAME:AddMessage("|c00A2D96FItemSync: "..ISYNC_SHOWINVALID);
					
				end--if (link_X and quality_X and name_X and not ISyncDB[ISync_RealmNum][name_X] and ISync:CheckFilter(quality_X) == 1) then
				

			else
				DEFAULT_CHAT_FRAME:AddMessage("|c00A2D96FItemSync: "..ISYNC_SHOWINVALID);
				
			end--if(name_X and link_X and quality_X) then

	end

	ISync_ItemIDFrameEdit:SetText(""); --reset

end
