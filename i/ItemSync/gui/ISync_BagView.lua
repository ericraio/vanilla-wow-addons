--[[--------------------------------------------------------------------------------
  ItemSyncCore BagView Framework

  Author:  Derkyle
  Website: http://www.manaflux.com
-----------------------------------------------------------------------------------]]

local ISync_BVList 	= { };

---------------------------------------------------
-- ISync:BV_Load
---------------------------------------------------
function ISync:BV_Load()
	---------------------------------------------------
	-- Register our slash command
	SLASH_ISYNCBAGVIEW1 = "/bagview";
	SLASH_ISYNCBAGVIEW2 = "/bv";
	SLASH_ISYNCBAGVIEW3 = "/bagv";
	SlashCmdList["ISYNCBAGVIEW"] = function(msg)

		if(ISYNC_LOADYES == 1) then
			if ( ISync_BV_Frame:IsVisible() ) then ISync_BV_Frame:Hide(); else ISync_BV_Frame:Show(); end
		end
	end
	tinsert(UISpecialFrames, "ISync_BV_Frame");  
end

---------------------------------------------------
-- ISync:BV_Binding
---------------------------------------------------
function ISync:BV_Unload()
	ISync_BVList = nil;
end


---------------------------------------------------
-- ISync:BV_Binding
---------------------------------------------------
function ISync:BV_Binding()
	if(ISYNC_LOADYES == 1) then
		if ( ISync_BV_Frame:IsVisible() ) then ISync_BV_Frame:Hide(); else ISync_BV_Frame:Show(); end
	end
end


---------------------------------------------------
-- ISync:BV_Refresh()
---------------------------------------------------
function ISync:BV_Refresh()

	ISync_BVList = nil; --reset
	
	local offset = FauxScrollFrame_GetOffset(ISync_IC_ScrollFrame);
	
	if( offset ) then
		--set to last offset
		FauxScrollFrame_SetOffset(ISync_IC_ScrollFrame, offset);	
	else
		--set to zero offset
		FauxScrollFrame_SetOffset(ISync_IC_ScrollFrame, 0);
	end
	
	ISync:BV_BuildIndex();
	ISync:BV_UpdateScrollFrame();

end


---------------------------------------------------
-- ISync:BV_BuildIndex()
---------------------------------------------------
function ISync:BV_BuildIndex()

	if(not ISyncDB) then return nil; end
	if(not ISyncDB[ISYNC_REALM_NUM]) then return nil; end
		
	--reset inven array
	ISync_BVList =  nil;
	ISync_BVList = { };

	local iNew = 1;
    	local costOfItem, sColor, sParseLink;
    	
    	--do the loops through all the bags
	for bag=0,NUM_BAG_FRAMES do
		for slot=1,GetContainerNumSlots(bag) do
		    local link = GetContainerItemLink(bag, slot);

		    if (link) then

			local sID = ISync:GetCoreID(link);
			local name = ISync:NameFromLink(link);
			local link = ISync:GetItemID(link);
			
			if(ISync:FetchDB(sID, "price")) then
			
				--grab the item information from the bag, slot
				local texture, itemCount, locked, quality, readable = GetContainerItemInfo(bag, slot);
				
				--we have to have an item count
				if(itemCount) then

					costOfItem = 0;
					costOfItem = tonumber(ISync:FetchDB(sID, "price"));
					
					--show stacked
					if(costOfItem > 0 and itemCount > 0 and ISync:SetVar({"BAGVIEW","SHOWSTACKED"}, 1, "COMPARE")) then
						 costOfItem = floor(tonumber(costOfItem) * tonumber(itemCount));
					end
					
					if(not costOfItem or costOfItem < 1 and ISync:SetVar({"BAGVIEW","SHOWNIL"}, 1, "COMPARE")) then
						--do nothing cause we want to hide value for this item
					else
						if(not costOfItem or costOfItem < 1) then costOfItem = 0; end
						--insert into table
						ISync_BVList[iNew] = { };
						ISync_BVList[iNew].name = name;
						ISync_BVList[iNew].money = costOfItem;
						ISync_BVList[iNew].bag = bag;
						ISync_BVList[iNew].slot = slot;
						ISync_BVList[iNew].count = itemCount;
						ISync_BVList[iNew].quality = tonumber(ISync:FetchDB(sID, "quality"));
						ISync_BVList[iNew].texture = texture;
						ISync_BVList[iNew].link = link;
						ISync_BVList[iNew].coreID = sID;

						iNew = iNew + 1;

					end
					

				end--if(itemCount) then

			end--if(name and name ~= "") then


		    end--if (link and link ~= "") then

		end--end for
	end--end for
    
    
    	ISync_BVList.onePastEnd = iNew;

	ISync:BV_Sort();
  
  
end


---------------------------------------------------
-- ISync:BV_Sort()
---------------------------------------------------
function ISync:BV_Sort()

	if not ISync_BVList then return; end

	if(ISync:SetVar({"BAGVIEW","SORT_VALUE"}, 1, "COMPARE")) then
		table.sort(ISync_BVList, ISync_BV_SortByValue);
	elseif(ISync:SetVar({"BAGVIEW","SORT_RARITY"}, 1, "COMPARE")) then
		table.sort(ISync_BVList, ISync_BV_SortByRarity);
	else
		table.sort(ISync_BVList, ISync_BV_SortByName);
	end

end


---------------------------------------------------
-- ISync_BV_SortByName
---------------------------------------------------
function ISync_BV_SortByName(a,b)

    return a.name < b.name;
    
end

---------------------------------------------------
-- ISync_BV_SortByValue
---------------------------------------------------
function ISync_BV_SortByValue(a,b)

	if(a.money and b.money) then
		return b.money < a.money;
	end

end

---------------------------------------------------
-- ISync_BV_SortByRarity
---------------------------------------------------
function ISync_BV_SortByRarity(elem1, elem2)

	local color1, color2;

	--get the corresponding quality
	color1 = elem1.quality;
	color2 = elem2.quality
	
	if(color1 and color2) then
	
		if( color1 == color2 ) then
			return elem1.name < elem2.name;
		end
	
		return color2 < color1;
	
	else
		return nil;
	end
	
end


---------------------------------------------------
-- ISync:BV_UpdateScrollFrame()
---------------------------------------------------
function ISync:BV_UpdateScrollFrame()

	local iItem;

	if (not ISync_BV_Frame:IsVisible()) then return; end
	if (not ISync_BVList) then ISync:BV_BuildIndex(); end --make sure
	if (not ISync_BVList or not ISync_BVList.onePastEnd) then return nil; end

	--start the scroll process
	--15 items and height of 16 each
	FauxScrollFrame_Update(ISync_IC_ScrollFrame, ISync_BVList.onePastEnd - 1, 15, 16);

	--loop through the 15 frames
	for iItem = 1, 15, 1 do

		--grab the current item index and then get the itembar object itself
		local itemIndex = iItem + FauxScrollFrame_GetOffset(ISync_IC_ScrollFrame);
		local ISyncItemObj = getglobal("ISync_BrowseButton"..iItem);

		--if it's still within boundaries then procezz
		if( itemIndex < ISync_BVList.onePastEnd ) then

			--make sure the item is even in the array and that it has an sID
			if(ISync_BVList[itemIndex] and ISync_BVList[itemIndex].link) then

				ISyncItemObj.storeID = ISync_BVList[itemIndex].link;

				if(ISync_BVList[itemIndex].name) then
					getglobal("ISync_BrowseButton"..iItem.."Name"):SetText(ISync_BVList[itemIndex].name);
				end

				--set color
				local color = { };
				if(ISync_BVList[itemIndex].quality) then
					color = ITEM_QUALITY_COLORS[tonumber(ISync_BVList[itemIndex].quality)];
					getglobal("ISync_BrowseButton"..iItem.."Name"):SetTextColor(color.r, color.g, color.b);
					getglobal("ISync_BrowseButton"..iItem.."Name").r = color.r;
					getglobal("ISync_BrowseButton"..iItem.."Name").g = color.g;
					getglobal("ISync_BrowseButton"..iItem.."Name").b = color.b;
				else
					getglobal("ISync_BrowseButton"..iItem.."Name").r = 0;
					getglobal("ISync_BrowseButton"..iItem.."Name").g = 0;
					getglobal("ISync_BrowseButton"..iItem.."Name").b = 0;
				end


				local moneyFrame = getglobal("ISync_BrowseButton"..iItem.."MoneyFrame");

				--set price if available
				if(ISync_BVList[itemIndex].money and moneyFrame) then

					MoneyFrame_Update(moneyFrame:GetName(), ISync_BVList[itemIndex].money);
					moneyFrame:Show();
				end


				--set texture
				if(ISync_BVList[itemIndex].texture) then
					getglobal("ISync_BrowseButton"..iItem.."ItemIconTexture"):SetTexture(ISync_BVList[itemIndex].texture);
				end

				--show stacked items
				if(ISync_BVList[itemIndex].count > 1 and ISync:SetVar({"BAGVIEW","SHOWSTACKED"}, 1, "COMPARE") == 1) then
					getglobal("ISync_BrowseButton"..iItem.."ItemCount"):SetText(ISync_BVList[itemIndex].count);
					getglobal("ISync_BrowseButton"..iItem.."ItemCount"):Show();
					
					--store the count
					ISyncItemObj.storeCount = ISync_BVList[itemIndex].count;

				else
					getglobal("ISync_BrowseButton"..iItem.."ItemCount"):Hide();
					ISyncItemObj.storeCount = 1; --default
				end
				
				
				--store the item array in both the item bar and texture
				ISyncItemObj.itemInfo = ISync_BVList[itemIndex];
				
				
				--show the item
				ISyncItemObj:Show(); 

			else
				--nothing to show then hide it
				ISyncItemObj:Hide();


			end

		else
			--error occured hide it
			ISyncItemObj:Hide();

		end

	end --end for
	

end



--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------
-- ISync:BV_ItemEnter()
---------------------------------------------------
function ISync:BV_ItemEnter()
local iItem;

	if(not ISyncDB) then return nil; end
	if(not ISyncDB[ISYNC_REALM_NUM]) then return nil; end
	
	local storeID;
	local sFrame;

	--get the item info
	if(this.itemInfo) then
		iItem = this.itemInfo;
		storeID = this.storeID;
		sFrame = this;
	elseif(this:GetParent():GetName()) then
		iItem = getglobal(this:GetParent():GetName()).itemInfo;
		storeID =  getglobal(this:GetParent():GetName()).storeID;
		sFrame = getglobal(this:GetParent():GetName());
	else
		return nil;
	end
	
	if(not iItem) then return; end

	if(storeID) then
	
		local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..storeID);

		if(link_X) then
		
			--show the sell cursor
			if(MerchantFrame:IsVisible() and not InRepairMode()) then
				ShowContainerSellCursor(iItem.bag, iItem.slot);
			elseif(not MerchantFrame:IsVisible() and InRepairMode()) then
				ResetCursor();
			end

			ISync_BV_Frame.TooltipButton = sFrame:GetID();
			GameTooltip:SetOwner(sFrame, "ANCHOR_RIGHT");
			GameTooltip:SetHyperlink(link_X);

			--update the search information
			ISync:Do_Parse(UIParent, ISyncTooltip, iItem.coreID, "item:"..storeID);
			
			--check counter
			if(ISync_AddTooltip and sFrame.storeCount) then
				
				--update another mod if available
				ISync:SendtoMods(GameTooltip, name_X, "item:"..storeID, sFrame.storeCount, quality_X);
				ISync:AddTooltipInfo(GameTooltip, "item:"..storeID, sFrame.storeCount, 1);
			else
				--update another mod if available
				ISync:SendtoMods(GameTooltip, name_X, "item:"..storeID, 1, quality_X);
				ISync:AddTooltipInfo(GameTooltip, "item:"..storeID, 1, 1);
			end

		end
			
	end--end
	
end



---------------------------------------------------
-- ISync:BV_ItemClick()
---------------------------------------------------
function ISync:BV_ItemClick(sButton)
local iItem;

	if(not ISyncDB) then return nil; end
	if(not ISyncDB[ISYNC_REALM_NUM]) then return nil; end

	--get the item info
	if(this.itemInfo) then
		iItem = this.itemInfo;
	elseif(this:GetParent():GetName()) then
		iItem = getglobal(this:GetParent():GetName()).itemInfo;
	else
		iItem = nil;
	end

	if(not iItem) then return; end
	
	--special thanks to Axu for the code :)  Support for AxuItemMenus
	if (AxuItemMenus_EvocationTest and AxuItemMenus_EvocationTest(sButton, "isync")) then
		
		AxuItemMenus_FillFromLink(GetContainerItemLink(iItem.bag, iItem.slot));
		AxuItemMenus_OpenMenu();
	
	elseif sButton == "LeftButton" then
	
		if IsShiftKeyDown() then
		
		    if ChatFrameEditBox:IsVisible() then
			local link = GetContainerItemLink(iItem.bag, iItem.slot);
			if link then ChatFrameEditBox:Insert(link); end
		    end
		    
		elseif( IsControlKeyDown()) then

			DressUpItemLink(GetContainerItemLink(iItem.bag, iItem.slot));
		else
		    	PickupContainerItem(iItem.bag, iItem.slot);
		end
		
	elseif sButton == "RightButton" then
		UseContainerItem(iItem.bag, iItem.slot);
	end
	
end
