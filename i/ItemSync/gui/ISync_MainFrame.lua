--[[--------------------------------------------------------------------------------
  ItemSync Main GUI Framework

  Author:  Derkyle
  Website: http://www.manaflux.com
-----------------------------------------------------------------------------------]]

ISYNC_SHOWINVALID_CHK 	= 0;
ISYNC_SHOWSEARCH_CHK 	= 0;

local ItemSync_Tabs = {
	{ ISYNC_BT_SEARCH, ISYNC_BT_SEARCH, "Interface\\Icons\\INV_Misc_QuestionMark" },
	{ ISYNC_BT_OPTIONS, ISYNC_BT_OPTIONS, "Interface\\Icons\\Trade_Engineering" },
	{ ISYNC_BT_FILTERS, ISYNC_BT_FILTERS, "Interface\\Icons\\Spell_Nature_WispSplode" },
	{ ISYNC_BT_FAVORITES, ISYNC_BT_FAVORITES, "Interface\\Icons\\INV_ValentinesCard01" },
	{ ISYNC_BT_ITEMID, ISYNC_BT_ITEMID, "Interface\\Icons\\Ability_Spy" },
	{ ISYNC_BT_BAGVIEW, ISYNC_BT_BAGVIEW, "Interface\\Icons\\INV_Misc_Bag_18" },
};

---------------------------------------------------
-- ISync:MainFrame_OnLoad()
---------------------------------------------------
function ISync:MainFrame_OnLoad()

	--setup the tabs
	for i = 1, 6, 1 do
		getglobal("ISync_Tab" .. i).tipinfo = ItemSync_Tabs[i][2];
		getglobal("ISync_Tab" .. i):SetNormalTexture(ItemSync_Tabs[i][3]);
	end
	

end


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------
-- ISync:ItemDisplay_Update()
---------------------------------------------------
function ISync:ItemDisplay_Update()

	if(ISync:SetVar({"OPT","ITEMCOUNTDISPLAY"}, 1, "COMPARE")) then
		if(not ISync_ID_Frame:IsVisible()) then ISync_ID_Frame:Show(); end			
		ISync_ID_Frame_Text:SetText(""); --empty current text
		ISync_ID_Frame_Text:SetText("|c0000FF00Items:|r |c00BDFCC9"..ISync:SetVar({"OPT","ITEMCOUNT_VALID"}, 0).."|r");
	else
		ISync_ID_Frame:Hide();
	end

end


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------
-- ISync:MainFrame_Binding()
---------------------------------------------------
function ISync:MainFrame_Binding()
	if(ISYNC_LOADYES == 1) then
		if ( ISync_MainFrame:IsVisible() ) then ISync_MainFrame:Hide(); else ISync_MainFrame:Show(); end
	end
end


---------------------------------------------------
-- ISync:Main_DD_SetSelectedID()
---------------------------------------------------
function ISync:Main_DD_SetSelectedID(frame, id, names)
	UIDropDownMenu_SetSelectedID(frame, id);
	if( not frame ) then
		frame = this;
	end
	UIDropDownMenu_SetText(names[id].name, frame);
end


---------------------------------------------------
-- ISync:Main_DD_Initialize()
---------------------------------------------------
function ISync:Main_DD_Initialize()
	local info;
	for i = 1, getn(ISYNC_DD_SORT), 1 do
		info = { };
		info.text = ISYNC_DD_SORT[i].name;
		info.func = ISync.Main_DD_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end


---------------------------------------------------
-- ISync:Main_DD_Load()
---------------------------------------------------
function ISync:Main_DD_Load()
	UIDropDownMenu_Initialize(ISync_MainFrame_DropDown, ISync.Main_DD_Initialize);
	ISync:Main_DD_SetSelectedID(ISync_MainFrame_DropDown, 1, ISYNC_DD_SORT);
	UIDropDownMenu_SetWidth(80);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", ISync_MainFrame_DropDown)
end


---------------------------------------------------
-- ISync:Main_DD_OnClick()
---------------------------------------------------
function ISync:Main_DD_OnClick()
	local oldID = UIDropDownMenu_GetSelectedID(ISync_MainFrame_DropDown);
	UIDropDownMenu_SetSelectedID(ISync_MainFrame_DropDown, this:GetID());
	
	if( oldID ~= this:GetID() ) then
		ISync:SetVar({"OPT","RARITY_DD"}, ISYNC_DD_SORT[UIDropDownMenu_GetSelectedID(ISync_MainFrame_DropDown)].sortType, "TRUE"); --TRUE=force
		FauxScrollFrame_SetOffset(ISync_MainFrame_ListScrollFrame, 0);
		getglobal("ISync_MainFrame_ListScrollFrameScrollBar"):SetValue(0);
		ISync:ListSort();
		ISync:UpdateScrollFrame();
	end
end


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------
-- ISync:TabClick()
---------------------------------------------------
function ISync:TabClick()

	this:SetChecked(0);
	
	if(this:GetID() == 1) then
    		ISync_OptionsFrame:Hide();
    		ISync_FiltersFrame:Hide();
    		if ( ISync_SearchFrame:IsVisible() ) then ISync_SearchFrame:Hide(); else ISync_SearchFrame:Show(); end
	elseif(this:GetID() == 2) then
		ISync_FiltersFrame:Hide();
		ISync_SearchFrame:Hide();
		if ( ISync_OptionsFrame:IsVisible() ) then ISync_OptionsFrame:Hide(); else ISync_OptionsFrame:Show(); end
	elseif(this:GetID() == 3) then
		ISync_OptionsFrame:Hide();
		ISync_SearchFrame:Hide();
		if ( ISync_FiltersFrame:IsVisible() ) then ISync_FiltersFrame:Hide(); else ISync_FiltersFrame:Show(); end
	elseif(this:GetID() == 4) then
		if ( ISync_FavFrame:IsVisible() ) then ISync_FavFrame:Hide(); else ISync_FavFrame:Show(); end
	elseif(this:GetID() == 5) then
		ISync:ItemIDSearch_Binding();
	elseif(this:GetID() == 6) then
		ISync:BV_Binding();				    
	end

end



--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------
-- ISync:Main_Refresh()
---------------------------------------------------
function ISync:Main_Refresh()

	if(ISYNC_LOADYES == 0) then return nil; end --don't run if disabled
	
	FauxScrollFrame_SetOffset(ISync_MainFrame_ListScrollFrame, 0);
	getglobal("ISync_MainFrame_ListScrollFrameScrollBar"):SetValue(0);
	ISync:BuildIndex();
	ISync:UpdateScrollFrame();
	
end


--------------------------------------------------
-- ISync:BuildIndex()
---------------------------------------------------
function ISync:BuildIndex()

	if(ISYNC_LOADYES == 0) then return nil; end --don't run if disabled
	
	--if we had a refresh check then set it back to zero
	if(ISync:SetVar({"REQUIRED","REFRESH"}, 1, "COMPARE")) then ISync:SetVar({"REQUIRED","REFRESH"}, 0, "TRUE"); end
	ISync_MainFrameUpdate:Hide();
	------------------------------------------------------
	
	local iNew, iValid, iLost, index, value, sParseLink;
	
	iValid 	= 0; --reset
	iLost 	= 0; --reset
	
	
	--start the display procedure
	if(ISYNC_SHOWSEARCH_CHK == 1) then
	
		ISync_SortIndex 	= { };
		ISync_SortIndex_Name 	= { };
		iNew = 1;
		
		if(not ISyncDB) then return nil; end
		if(not ISyncDB[ISYNC_REALM_NUM]) then return nil; end
		
		--do the loop
		for index, value in ISyncDB[ISYNC_REALM_NUM] do

				sParseLink = ISync:FetchDB(index, "subitem");

				if(not sParseLink) then
				
					--check
					local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..index..":0:0:0");

					--do we have a valid item?
					if(name_X and quality_X and ISync:SF_MatchSearch(index, name_X, quality_X)) then

						--check to see if we've already added the name
						if(not ISync_SortIndex_Name[name_X]) then

							ISync_SortIndex[iNew] = { };
							ISync_SortIndex[iNew].name = name_X;
							ISync_SortIndex[iNew].quality = quality_X;
							ISync_SortIndex[iNew].id = index..":0:0:0";
							ISync_SortIndex[iNew].idcore = index;

							ISync_SortIndex_Name[name_X] = 1;

							iNew = iNew + 1;
							iValid = iValid + 1;

						else
							ISync_SortIndex[iNew] = { };
							ISync_SortIndex[iNew].name = name_X..iNew; --add it but with a fake number at end
							ISync_SortIndex[iNew].realname = name_X; --same name item
							ISync_SortIndex[iNew].quality = quality_X;
							ISync_SortIndex[iNew].idcore = index;
							ISync_SortIndex[iNew].id = index..":0:0:0";

							ISync_SortIndex_Name[name_X..iNew] = 1;

							iNew = iNew + 1;
							iValid = iValid + 1;

						end--if(not ISync_SortIndex_Name[name_X]) then


					end--if(name_X and quality_X and ISync:SF_MatchSearch(index, name_X, quality_X)) then
			
				else

					-----------------------------------
					--ADD SUBITEMS AS WELL
					if(sParseLink and type(sParseLink) == "table") then

						for qindex, qvalue in sParseLink do

							--check
							local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..index..":0:"..qvalue..":0");

							--do we have a valid item? match with primary quality as well
							if(name_X and quality_X and ISync:SF_MatchSearch(index, name_X, quality_X)) then

								ISync_SortIndex[iNew] = { };
								ISync_SortIndex[iNew].name = name_X;
								ISync_SortIndex[iNew].quality = quality_X;
								ISync_SortIndex[iNew].id = index..":0:"..qvalue..":0";
								ISync_SortIndex[iNew].idcore = index;
								ISync_SortIndex[iNew].subid = qvalue;

								iNew = iNew + 1;
								iValid = iValid + 1;
							end

						end--for qindex, qvalue in sParseLink do

					end--if(type(sParseLink) == "table") then
					-----------------------------------
					
				end--if(not sParseLink) then
			
			
		end--for index, value in ISyncDB[ISync_RealmNum] do
		

		
	elseif(ISYNC_SHOWINVALID_CHK == 1) then
	
		ISync_SortIndex 	= { };
		ISync_SortIndex_Name 	= { };
		iNew = 1;

		if(not ISyncDB) then return nil; end
		if(not ISyncDB[ISYNC_REALM_NUM]) then return nil; end

		--do the loop
		for index, value in ISyncDB[ISYNC_REALM_NUM] do

			sParseLink = ISync:FetchDB(index, "subitem");
			
			if(not sParseLink) then --this item has no subitems, cause it's subitem value = 0
			
				local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..index..":0:0:0");
			
				if(not name_X) then 
				
						ISync_SortIndex[iNew] = { };
						
						if(ISyncDB_Names[index]) then
							ISync_SortIndex[iNew].name = ISyncDB_Names[index];
						else
							ISync_SortIndex[iNew].name = index..":0".." "..ISYNC_SHOWSUBITEM2; --add it but with a fake number at end
						end
						ISync_SortIndex[iNew].quality = 0;
						ISync_SortIndex[iNew].idcore = index;
						ISync_SortIndex[iNew].id = index..":0:0:0";
	
						iNew = iNew + 1;
						iLost = iLost + 1;
				end
				
				
			else --it has subitems
			
				--make sure it's a table
				if(type(sParseLink) == "table") then
				
					for qindex, qvalue in sParseLink do

						--check
						local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..index..":0:"..qvalue..":0");

						--do we have a valid item?
						if(not name_X) then

							ISync_SortIndex[iNew] = { };
							
							if(ISyncDB_Names[index]) then
								ISync_SortIndex[iNew].name = ISyncDB_Names[index].." "..ISYNC_SHOWSUBITEM;
							else
								ISync_SortIndex[iNew].name = index..":"..qvalue.." "..ISYNC_SHOWSUBITEM2; --add it but with a fake number at end
							end

							ISync_SortIndex[iNew].quality = 0;
							ISync_SortIndex[iNew].id = index..":0:"..qvalue..":0";
							ISync_SortIndex[iNew].idcore = index;
							ISync_SortIndex[iNew].subid = qvalue;

							iNew = iNew + 1;
							iLost = iLost + 1
						end
				
					end--for qindex, qvalue in sParseLink do
				
				end--if(type(sParseLink) == "table") then
			
			end--if(not sParseLink) then
			
		end--for index, value in ISyncDB[ISync_RealmNum] do
		
	

	else--do a regular display
	
		ISync_SortIndex 	= { };
		ISync_SortIndex_Name 	= { };
		iNew = 1;

		if(not ISyncDB) then return nil; end
		if(not ISyncDB[ISYNC_REALM_NUM]) then return nil; end

		
		--do the loop
		for index, value in ISyncDB[ISYNC_REALM_NUM] do

			sParseLink = ISync:FetchDB(index, "subitem");
			
			if(not sParseLink) then --this item has no subitems, cause it's subitem value = 0
			
				--check
				local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..index..":0:0:0");
			
				--do we have a valid item?
				if(name_X and quality_X) then
			
						--fix the quality if it needs changing, only for primary items
						if(not ISync:FetchDB(index, "quality", quality_X)) then
							ISync:SetDB(index, "quality", quality_X);
						end
						
					--check to see if we've already added the name
					if(not ISync_SortIndex_Name[name_X]) then
				
						ISync_SortIndex[iNew] = { };
						ISync_SortIndex[iNew].name = name_X;
						ISync_SortIndex[iNew].quality = quality_X;
						ISync_SortIndex[iNew].id = index..":0:0:0";
						ISync_SortIndex[iNew].idcore = index;

						ISync_SortIndex_Name[name_X] = 1;
						
						--check for stored names
						if(not ISyncDB_Names[index]) then ISyncDB_Names[index] = name_X; end
						if(name_X and ISyncDB_Names[index] and ISyncDB_Names[index] ~= name_X) then ISyncDB_Names[index] = name_X; end
						
						iNew = iNew + 1;
						iValid = iValid + 1;
						
					else
						ISync_SortIndex[iNew] = { };
						ISync_SortIndex[iNew].name = name_X..iNew; --add it but with a fake number at end
						ISync_SortIndex[iNew].realname = name_X; --same name item
						ISync_SortIndex[iNew].quality = quality_X;
						ISync_SortIndex[iNew].idcore = index;
						ISync_SortIndex[iNew].id = index..":0:0:0";
							
						ISync_SortIndex_Name[name_X..iNew] = 1;
						
						if(not ISyncDB_Names[index]) then ISyncDB_Names[index] = name_X; end
						if(name_X and ISyncDB_Names[index] and ISyncDB_Names[index] ~= name_X) then ISyncDB_Names[index] = name_X; end
						
						iNew = iNew + 1;
						iValid = iValid + 1;
					
					end--if(not ISync_SortIndex_Name[name_X]) then
					
					
				else
					iLost = iLost + 1;
				end--if(name_X and quality_X) then
				
				
			else --it has subitems
			
				--make sure it's a table
				if(type(sParseLink) == "table") then
				
					for qindex, qvalue in sParseLink do

						--check
						local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..index..":0:"..qvalue..":0");

						--do we have a valid item?
						if(name_X and quality_X) then

							ISync_SortIndex[iNew] = { };
							ISync_SortIndex[iNew].name = name_X;
							ISync_SortIndex[iNew].quality = quality_X;
							ISync_SortIndex[iNew].id = index..":0:"..qvalue..":0";
							ISync_SortIndex[iNew].idcore = index;
							ISync_SortIndex[iNew].subid = qvalue;

							iNew = iNew + 1;
							iValid = iValid + 1;

						else
							iLost = iLost + 1;
						end
				
					end--for qindex, qvalue in sParseLink do
				
				end--if(type(sParseLink) == "table") then
			
			end--if(not sParseLink) then
			
		end--for index, value in ISyncDB[ISync_RealmNum] do

			--valid, invalid nums
			ISync:SetVar({"OPT","ITEMCOUNT_VALID"}, iValid, "TRUE");
			ISync:SetVar({"OPT","ITEMCOUNT_INVALID"}, iLost, "TRUE");
			
	end--end build array
	
	
	ISync_SortIndex_Name = nil;
	
	ISync:ListSort();
	ISync_SortIndex.onePastEnd = iNew;
	ISync_SortIndex.total = (iValid+iLost);
	ISync_SortIndex.valid = iValid;
	ISync_SortIndex.invalid = iLost;

	ISync:ItemDisplay_Update();	

end



---------------------------------------------------
-- ISync:ListSort()
---------------------------------------------------
function ISync:ListSort()

	if( ISYNC_DD_SORT[UIDropDownMenu_GetSelectedID(ISync_MainFrame_DropDown)].sortType ) then
	
		local sortType = ISYNC_DD_SORT[UIDropDownMenu_GetSelectedID(ISync_MainFrame_DropDown)].sortType;

		if( ISync:SetVar({"OPT","RARITY_DD"}, "name") == "name" ) then
		
			ISync:Main_DD_SetSelectedID(ISync_MainFrame_DropDown, 1, ISYNC_DD_SORT);
		
			table.sort(ISync_SortIndex, ISync_SortByName);

		elseif( ISync:SetVar({"OPT","RARITY_DD"}, "name") == "rarity" ) then
		
			ISync:Main_DD_SetSelectedID(ISync_MainFrame_DropDown, 2, ISYNC_DD_SORT);
			
			table.sort(ISync_SortIndex, ISync_SortColor);
			
		end
		
		
	end
	
	
end



---------------------------------------------------
-- ISync_SortByName()
---------------------------------------------------
function ISync_SortByName(elem1, elem2)

    return elem1.name < elem2.name;
    
end

---------------------------------------------------
-- ISync_SortColor()
---------------------------------------------------
function ISync_SortColor(elem1, elem2)
	local color1, color2;

	--get the corresponding quality
	color1 = elem1.quality;
	color2 = elem2.quality;
	
	color1 = tonumber(color1);
	color2 = tonumber(color2);
	
	if(color1 and color2) then
	
		--this sorts the name if the colors match
		--that way the rarity are also alphabatized within the same rarity
		if( color1 == color2 ) then
			return elem1.name < elem2.name;
		end
	
		--return the color if it doesn't match
		return color2 < color1;
	
	else
		return nil;
	end
	
end


---------------------------------------------------
-- ISync:UpdateScrollFrame()
---------------------------------------------------
function ISync:UpdateScrollFrame()

local ISYNC_HEIGHT 		= 16;
local ISYNC_SHOWN 		= 23;
local LAST_SHOWN		= 1;
	
	if(ISYNC_LOADYES == 0) then return nil; end --don't run if disabled
	
	if( not ISync_SortIndex or not ISync_SortIndex.onePastEnd) then
		 ISync:BuildIndex();
	end
	
	--double check
	if(not ISync_SortIndex.onePastEnd) then return nil; end

	--valid count and invalid count
	if(ISYNC_SHOWINVALID_CHK == 1) then
		ISync_MainFrameInfo:SetText("|c0000FF00"..ISYNC_SHOWVALID..":|r    |c00BDFCC90|r\n|c00FF0000"..ISYNC_SHOWINVALID..":|r |c00BDFCC9"..ISync_SortIndex.invalid.."|r");	
	else
		ISync_MainFrameInfo:SetText("|c0000FF00"..ISYNC_SHOWVALID..":|r    |c00BDFCC9"..ISync_SortIndex.valid.."|r\n|c00FF0000"..ISYNC_SHOWINVALID..":|r |c00BDFCC9"..ISync_SortIndex.invalid.."|r");
	end

	--Since patch 1.4 the 5th arguement must be nill or an error will occur
	FauxScrollFrame_Update(ISync_MainFrame_ListScrollFrame, ISync_SortIndex.onePastEnd - 1, ISYNC_SHOWN, ISYNC_HEIGHT, nil);
	
	--do loop until all slots are filled, or we are out of information
	for iItem = 1, ISYNC_SHOWN, 1 do

		local itemIndex = iItem + FauxScrollFrame_GetOffset(ISync_MainFrame_ListScrollFrame);
		local IMItemObj = getglobal("ISyncItem"..iItem);
		local IMItemObj_Text = getglobal("ISyncItem"..iItem.."Text");
		local IMItemObj_Indexed = getglobal("ISyncItem"..iItem.."SubItem");
		local IMItemObj_GB = getglobal("ISync_ItemIDGB_Button"..iItem);
		local IMItemObj_GB_Blip = getglobal("ISync_ItemIDGB_Button"..iItem.."_BlipTexture");


		if(IMItemObj) then
		
			--check if were still within bounds
			if( itemIndex < ISync_SortIndex.onePastEnd and ISync_SortIndex[itemIndex]) then
					
					--if not subitem then process normally
					if(not ISync_SortIndex[itemIndex].realname) then
						
						IMItemObj_Text:SetPoint( "LEFT",  19, 1 );
						IMItemObj_Indexed:Hide();
						if(ISYNC_SHOWINVALID_CHK == 0) then
							IMItemObj:SetText(ISync_SortIndex[itemIndex].name);
						else
							IMItemObj:SetText("|c00FC5252"..ISync_SortIndex[itemIndex].name.."|r");
						end
						IMItemObj.storeID = ISync_SortIndex[itemIndex].id; --store the itemid
						IMItemObj.storeCore = ISync_SortIndex[itemIndex].idcore;
						
					--its a subitem
					else
						IMItemObj_Text:SetPoint( "LEFT",  29, 1 );
						IMItemObj_Indexed:Show();
						if(ISYNC_SHOWINVALID_CHK == 0) then
							IMItemObj:SetText(ISync_SortIndex[itemIndex].realname);
						else
							IMItemObj:SetText("|c00FC5252"..ISync_SortIndex[itemIndex].realname.."|r");
						end
						IMItemObj.storeID = ISync_SortIndex[itemIndex].id; --store the itemid
						IMItemObj.storeCore = ISync_SortIndex[itemIndex].idcore;
						
					end
					
					--store the subitem for items to allow for deletion
					if(ISync_SortIndex[itemIndex].subid) then
						IMItemObj.storeSubID = ISync_SortIndex[itemIndex].subid;
					else
						IMItemObj.storeSubID = nil;
					end
					IMItemObj.itemIndex = itemIndex; --store the itemindex for deletion

					--color accordingly (only when not invalid view)
					if(ISYNC_SHOWINVALID_CHK == 0) then
						local grabColor = ITEM_QUALITY_COLORS[tonumber(ISync_SortIndex[itemIndex].quality)];
						if( grabColor) then
							IMItemObj:SetTextColor(grabColor.r, grabColor.g, grabColor.b);
							IMItemObj.r = grabColor.r;
							IMItemObj.g = grabColor.g;
							IMItemObj.b = grabColor.b;
						else
							IMItemObj.r = 0;
							IMItemObj.g = 0;
							IMItemObj.b = 0;
						end
					end
								
					--check user inputted (only when not invalid view)
					if(ISYNC_SHOWINVALID_CHK == 0) then
						if(ISync:FetchDB(ISync_SortIndex[itemIndex].idcore, "idchk", 1)) then

							IMItemObj_GB_Blip:SetTexture("Interface\\AddOns\\ItemSync\\images\\ISync_ItemID_ItemPic");
							ISYNC_ITEMID_GREENBUTTON_WARNING2 = ISYNC_ITEMID_GREENBUTTON_WARNING;
							IMItemObj_GB:Show();
							IMItemObj_GB.Obj = nil;
						else
							IMItemObj_GB:Hide();
						end
					else
							IMItemObj_GB_Blip:SetTexture("Interface\\AddOns\\ItemSync\\images\\ISync_Invalid_ItemPic");
							ISYNC_ITEMID_GREENBUTTON_WARNING2 = "|c00FF0000"..ISYNC_ITEMISINVALID_TOOLTIP1.."|r";
							IMItemObj_GB:Show();
							IMItemObj_GB.Obj = IMItemObj;
					end
						
					--show it
					IMItemObj:Show();
			
			--we deleted an item
			elseif( itemIndex < ISync_SortIndex.onePastEnd and not ISync_SortIndex[itemIndex]) then
				
				IMItemObj.storeID = nil;
				IMItemObj.storeCore = nil;
				IMItemObj.storeSubID = nil;
				IMItemObj.itemIndex = nil;
				IMItemObj:SetText("|c00FC5252"..ISYNC_DELETE_ITEMMSG.."|r");
				IMItemObj:Show();
				IMItemObj_Indexed:Hide();
				IMItemObj_GB:Hide();
				
			else
				IMItemObj.storeID = nil;
				IMItemObj.storeCore = nil;
				IMItemObj.storeSubID = nil;
				IMItemObj.itemIndex = nil;
				IMItemObj:SetText("");
				IMItemObj:Hide();
				IMItemObj_Indexed:Hide();
				IMItemObj_GB:Hide();
			
			
			end--if( itemIndex < ISync_SortIndex.onePastEnd ) then
			
		end--if(IMItemObj) then
			
	end--for iItem = 1, ISYNC_SHOWN, 1 do

	

end


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------
-- ISync:ButtonEnter()
---------------------------------------------------
function ISync:ButtonEnter()

	if(not this.storeID) then return nil; end
	
	local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X, invType_X, icon_X  = GetItemInfo("item:"..this.storeID);

	if(name_X) then
		ISync_MainFrame.TooltipButton = this:GetID();
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		GameTooltip:SetHyperlink(link_X);
		ISync:Do_Parse(UIParent, ISyncTooltip, this.storeCore, "item:"..this.storeID);
		ISync:SendtoMods(GameTooltip, name_X, "item:"..this.storeID, 1, quality_X);
	else
		ISync_MainFrame.TooltipButton = this:GetID();
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		GameTooltip:SetHyperlink("item:"..this.storeID);

		--something went wrong so lets show a message
		if(not GameTooltip:IsVisible()) then
		
			ISync_MainFrame.TooltipButton = this:GetID();
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
			GameTooltip:AddLine(" ", 0, 0, 0);
			GameTooltip:AddLine("|c00FF0000"..ISYNC_ITEMISINVALID_TOOLTIP1.."|r", 0, 0, 0);
			GameTooltip:AddLine("|c00A2D96F"..ISYNC_ITEMISINVALID_TOOLTIP2.."|r", 0, 0, 0);
			GameTooltip:AddLine("|c00FF0000"..ISYNC_ITEMISINVALID_TOOLTIP3.."|r", 0, 0, 0);
			GameTooltip:AddLine(" ", 0, 0, 0);
			GameTooltip:AddLine("|c0000FF00"..ISYNC_BT_ITEMID..":|r |c00BDFCC9"..this.storeID.."|r", 0, 0, 0);
			GameTooltip:AddLine(ISYNC_ITEMISINVALID_TOOLTIP4);
			GameTooltip:Show();
			
		elseif(GameTooltip:IsVisible()) then
		
			GameTooltip:AddLine(" ", 0, 0, 0);
			GameTooltip:AddLine("|c00FF0000"..ISYNC_ITEMISINVALID_TOOLTIP1.."|r", 0, 0, 0);
			GameTooltip:AddLine("|c00A2D96F"..ISYNC_ITEMISINVALID_TOOLTIP2.."|r", 0, 0, 0);
			GameTooltip:AddLine("|c00FF0000"..ISYNC_ITEMISINVALID_TOOLTIP3.."|r", 0, 0, 0);
			GameTooltip:AddLine(" ", 0, 0, 0);
			GameTooltip:AddLine("|c0000FF00"..ISYNC_BT_ITEMID..":|r |c00BDFCC9"..this.storeID.."|r", 0, 0, 0);
			GameTooltip:AddLine(ISYNC_ITEMISINVALID_TOOLTIP4);
			GameTooltip:Show();
		
		end

	end

end


---------------------------------------------------
-- ISync:ButtonClick()
---------------------------------------------------
function ISync:ButtonClick(sButton)

	if(not this.storeID) then return nil; end
	

	if(ISYNC_SHOWINVALID_CHK > 0) then

		ISync_ItemIDFrameEdit:SetText(this.storeID);
		ISync_ItemIDFrame:Show();

		return nil;
	end

	--special thanks to Axu for the code :)  Support for AxuItemMenus
	if (AxuItemMenus_EvocationTest and this.storeID and AxuItemMenus_EvocationTest(sButton, "isync")) then
		
		AxuItemMenus_FillFromLink("item:"..this.storeID);
		AxuItemMenus_OpenMenu();
	
	elseif (sButton == "LeftButton") then
	

		if( ChatFrameEditBox:IsVisible() and this.storeID) then

				local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..this.storeID);

				if(name_X and link_X and quality_X) then

					ChatFrameEditBox:Insert("|c"..ISync:ReturnHexColor(quality_X).."|H"..link_X.."|h["..name_X.."]|h|r");
				end

		elseif( IsShiftKeyDown() and ChatFrameEditBox:IsVisible() and this.storeID) then

				local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..this.storeID);

				if(name_X and link_X and quality_X) then

					ChatFrameEditBox:Insert("|c"..ISync:ReturnHexColor(quality_X).."|H"..link_X.."|h["..name_X.."]|h|r");
				end

		elseif( IsControlKeyDown() and this.storeID) then

				local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..this.storeID);

				if(name_X and link_X and quality_X) then
					DressUpItemLink(link_X);
				end

		end--end checks

		
		
	elseif (sButton == "RightButton") then

		if(IsAltKeyDown() and this.storeCore and this.storeID and this.itemIndex and ISync:FetchDB(this.storeCore, "chk")) then
		
			local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..this.storeID);
				
			if(name_X and link_X and quality_X) then

				local newText = string.format(ISYNC_DELETE_MSGRETAKE, "|c"..ISync:ReturnHexColor(quality_X)..name_X.."|r");
				
				if(newText) then
					
					ISync_MainFrame.DEL_ItemIndex = this.itemIndex;
					ISync_MainFrame.DEL_CoreID = this.storeCore;
					if(this.storeSubID) then ISync_MainFrame.DEL_SubID = this.storeSubID; end
					
					StaticPopupDialogs["ISYNC_DELETEITEM_CONFIRM"].text = TEXT(newText);
					StaticPopup_Show("ISYNC_DELETEITEM_CONFIRM");
				end
				
			end--if(name_X and link_X and quality_X) then
			
		--add to favorites
		elseif(IsShiftKeyDown() and IsControlKeyDown() and this.storeCore and this.storeID and this.itemIndex) then
		
			if(not ISyncFav or not ISyncFav[UnitName("player")]) then return nil; end
		
			local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..this.storeID);
				
			if(name_X and link_X and quality_X) then
			
				if(this.storeSubID) then
					ISyncFav[UnitName("player")][this.storeCore..":"..this.storeSubID] = 1;
				else
					ISyncFav[UnitName("player")][this.storeCore..":0"] = 1;
				end

				
				ISync:Print("|c00A2D96FItemSync:|r "..ISYNC_ADDEDTOFAV.." <<>> |r|c"..ISync:ReturnHexColor(quality_X)..this:GetText().."|r");
				ISync:Fav_Refresh();
				
			end
			
		end--	if(IsAltKeyDown() and this.storeCore and this.storeID and ISync:FetchDB(this.storeCore, "chk")) then
		
		
	end

end


---------------------------------------------------
-- ISync:BlipClick()
---------------------------------------------------
function ISync:BlipClick(sButton)

	if(ISYNC_SHOWINVALID_CHK > 0) then
		
		local getObj = getglobal((this:GetParent()):GetName());
		if(not getObj) then return nil; end
		
		getObj = getObj.Obj;
		if(not getObj) then return nil; end
		
		local newText = string.format(ISYNC_DELETE_MSGRETAKE, "|c00FC5252"..getObj:GetText().."|r");

		if(newText) then
		
			ISync_MainFrame.DEL_ItemIndex = getObj.itemIndex;
			ISync_MainFrame.DEL_CoreID = getObj.storeCore;
			if(getObj.storeSubID) then ISync_MainFrame.DEL_SubID = getObj.storeSubID; end

			StaticPopupDialogs["ISYNC_DELETEITEM_CONFIRM"].text = TEXT(newText);
			StaticPopup_Show("ISYNC_DELETEITEM_CONFIRM");
		end

	end

end


---------------------------------------------------
-- ISync:DeleteItem()
---------------------------------------------------
function ISync:DeleteItem()

	--first check to see if we have something
	if(not ISync_MainFrame.DEL_ItemIndex) then return nil; end
	
	--it's a sub item
	if(ISync_MainFrame.DEL_SubID) then
		ISync:SetDB(ISync_MainFrame.DEL_CoreID, "subitem", ISync_MainFrame.DEL_SubID, "TRUE");
		ISync_SortIndex[ISync_MainFrame.DEL_ItemIndex] = nil; --delete to show as deleted
		if(ISYNC_SHOWINVALID_CHK > 0) then
			ISync_SortIndex.invalid = ISync_SortIndex.invalid - 1; --decrease
		else
			ISync_SortIndex.valid = ISync_SortIndex.valid - 1; --decrease
		end
		ISync:UpdateScrollFrame(); --refresh it
	else
		ISyncDB[ISYNC_REALM_NUM][ISync_MainFrame.DEL_CoreID] = nil;
		ISync_SortIndex[ISync_MainFrame.DEL_ItemIndex] = nil; --delete to show as deleted
		if(ISYNC_SHOWINVALID_CHK > 0) then
			ISync_SortIndex.invalid = ISync_SortIndex.invalid - 1; --decrease
		else
			ISync_SortIndex.valid = ISync_SortIndex.valid - 1; --decrease
		end
		ISync:UpdateScrollFrame(); --refresh it
	end


end


---------------------------------------------------
-- ISync:SendtoMods()
---------------------------------------------------
function ISync:SendtoMods(sTooltip, sName, sLink, sQty, sQuality)

	if(not sTooltip or not sName or not sQty) then return nil; end
	if(sTooltip.SendtoMods) then return nil; end
		
	--AuctionMatrix/AuctionSync
	if(AuctionMatrix_AddTooltipMoney and ISync:SetVar({"MOD","AMAS"}, 1, "COMPARE")) then
		AuctionMatrix_AddTooltipMoney(sName, sTooltip, sQty);
	end
	if(AuctionSync_AddTooltip and ISync:SetVar({"MOD","AMAS"}, 1, "COMPARE")) then
		AuctionSync_AddTooltip(sTooltip, sName, sLink, sQuality, sQty, nil);
	end
	
	--Auctioneer
	if(ENHTOOLTIP_VERSION and not EnhTooltip and ISync:SetVar({"MOD","AUCTIONEER"}, 1, "COMPARE")) then
	
		local Dlink = "|c"..ISync:ReturnHexColor(sQuality).. "|H"..sLink.."|h["..sName.."]|h|r";
		if (TT_Clear and TT_TooltipCall and TT_Show) then
			TT_Clear();
			TT_TooltipCall(sTooltip, sName, Dlink, sQuality, sQty, 0);
			TT_Show(sTooltip);
		end
		
	elseif(ENHTOOLTIP_VERSION and EnhTooltip and ISync:SetVar({"MOD","AUCTIONEER"}, 1, "COMPARE")) then
	
		if(EnhancedTooltip:IsVisible()) then return nil; end
		
		local Dlink = "|c"..ISync:ReturnHexColor(sQuality).. "|H"..sLink.."|h["..sName.."]|h|r";
		EnhTooltip.ClearTooltip();
		EnhTooltip.TooltipCall(sTooltip, sName, Dlink, sQuality, sQty, 0);
		EnhTooltip.ShowTooltip(sTooltip);

	end
	
	--ReagentInfo
	if(ReagentInfo_AddTooltipInfo and ISync:SetVar({"MOD","REAGENTINFO"}, 1, "COMPARE")) then
		ReagentInfo_AddTooltipInfo(sTooltip, sName);
	end
	
	sTooltip.SendtoMods = nil;

end


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
