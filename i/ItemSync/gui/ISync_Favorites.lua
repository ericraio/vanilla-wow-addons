--[[--------------------------------------------------------------------------------
  ItemSync Favorites Framework

  Author:  Derkyle
  Website: http://www.manaflux.com
-----------------------------------------------------------------------------------]]

local DD_NameCount = 1;

---------------------------------------------------
-- ISync:FavFrame_Binding()
---------------------------------------------------
function ISync:FavFrame_Binding(sOpt)
	if(ISYNC_LOADYES == 1) then
		if ( sOpt and sOpt == 1) then
			ISync_FavFrame:Hide();
			return nil;
		end
		if ( ISync_FavFrame:IsVisible() ) then ISync_FavFrame:Hide(); else ISync_FavFrame:Show(); end
	end
end


---------------------------------------------------
-- ISync:Fav_DD_SetSelectedID()
---------------------------------------------------
function ISync:Fav_DD_SetSelectedID(frame, id, names)
	UIDropDownMenu_SetSelectedID(frame, id);
	if( not frame ) then
		frame = this;
	end
	UIDropDownMenu_SetText(names, ISync_FavFrame_DropDown);
end


---------------------------------------------------
-- ISync:Fav_DD_Initialize()
---------------------------------------------------
function ISync:Fav_DD_Initialize()
	local info;
	local sCount = 1;

	for sKey, sVar in ISyncFav do
		info = { };
		info.text = sKey;
		info.func = ISync.Fav_DD_OnClick;
		UIDropDownMenu_AddButton(info);
		if( string.lower(sKey) == string.lower(UnitName("player")) ) then DD_NameCount = sCount; end
		sCount = sCount + 1;
	end

end


---------------------------------------------------
-- ISync:Fav_DD_Load()
---------------------------------------------------
function ISync:Fav_DD_Load()
	UIDropDownMenu_Initialize(ISync_FavFrame_DropDown, ISync.Fav_DD_Initialize);
	ISync:Fav_DD_SetSelectedID(ISync_FavFrame_DropDown, DD_NameCount, UnitName("player"));
	UIDropDownMenu_JustifyText("LEFT", ISync_FavFrame_DropDown)
end


---------------------------------------------------
-- ISync:Fav_DD_OnClick()
---------------------------------------------------
function ISync:Fav_DD_OnClick()
	local oldID = UIDropDownMenu_GetSelectedID(ISync_FavFrame_DropDown);
	UIDropDownMenu_SetSelectedID(ISync_FavFrame_DropDown, this:GetID());
	
	if( oldID ~= this:GetID() ) then
		FauxScrollFrame_SetOffset(ISync_FavFrame_ListScrollFrame, 0);
		getglobal("ISync_FavFrame_ListScrollFrameScrollBar"):SetValue(0);
		ISync:Fav_Refresh();
	end

end

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------
-- ISync:Fav_OnEvent()
---------------------------------------------------
function ISync:Fav_OnEvent()

	if( event == "VARIABLES_LOADED" ) then
		ISync:Fav_DD_Load();
	end

end

---------------------------------------------------
-- ISync:Fav_Refresh()
---------------------------------------------------
function ISync:Fav_Refresh()

	if(ISYNC_LOADYES == 0) then return nil; end --don't run if disabled
	
	FauxScrollFrame_SetOffset(ISync_FavFrame_ListScrollFrame, 0);
	getglobal("ISync_FavFrame_ListScrollFrameScrollBar"):SetValue(0);
	ISync:Fav_BuildIndex();
	ISync:Fav_UpdateScrollFrame();
	
end


--------------------------------------------------
-- ISync:Fav_BuildIndex()
---------------------------------------------------
function ISync:Fav_BuildIndex()

	if(ISYNC_LOADYES == 0) then return nil; end --don't run if disabled
	------------------------------------------------------
	
	local sUser = UIDropDownMenu_GetText(ISync_FavFrame_DropDown);
	if(not sUser) then return nil; end
	if(not ISyncFav or not ISyncFav[sUser]) then return nil; end
	
	local iNew, xPL1, xPL2;
	
	ISync_Fav_SortIndex 		= { };
	iNew = 1;

	--do the loop
	for sKey, sVar in ISyncFav[sUser] do
		
		xPL1 = string.gsub(sKey, "^(%d+):(%d+)$", "%1");
		xPL2 = string.gsub(sKey, "^(%d+):(%d+)$", "%2");
		
		local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..xPL1..":0:"..xPL2..":0");
		
		if(name_X) then
			ISync_Fav_SortIndex[iNew] = { };
			ISync_Fav_SortIndex[iNew].name = name_X;
			ISync_Fav_SortIndex[iNew].id = sKey;
			ISync_Fav_SortIndex[iNew].quality = quality_X;
		else
			ISync_Fav_SortIndex[iNew] = { };
			ISync_Fav_SortIndex[iNew].name = ISYNC_SHOWINVALID..": ["..sKey.."]";
			ISync_Fav_SortIndex[iNew].id = sKey;
			ISync_Fav_SortIndex[iNew].quality = -99;
		end
		
		iNew = iNew + 1;
		
	end--for index, value in ISyncDB[ISync_RealmNum] do
		
	table.sort(ISync_Fav_SortIndex, ISync_SortByName); --use the sortbyname from the main gui
	ISync_Fav_SortIndex.onePastEnd = iNew;


end


---------------------------------------------------
-- ISync:Fav_UpdateScrollFrame()
---------------------------------------------------
function ISync:Fav_UpdateScrollFrame()

local ISYNC_HEIGHT 		= 16;
local ISYNC_SHOWN 		= 23;
local LAST_SHOWN		= 1;
	
	if(ISYNC_LOADYES == 0) then return nil; end --don't run if disabled
	
	if( not ISync_Fav_SortIndex or not ISync_Fav_SortIndex.onePastEnd) then
		 ISync:Fav_BuildIndex();
	end
	
	--double check
	if(not ISync_Fav_SortIndex.onePastEnd) then return nil; end

	--Since patch 1.4 the 5th arguement must be nill or an error will occur
	FauxScrollFrame_Update(ISync_FavFrame_ListScrollFrame, ISync_Fav_SortIndex.onePastEnd - 1, ISYNC_SHOWN, ISYNC_HEIGHT, nil);
	
	--do loop until all slots are filled, or we are out of information
	for iItem = 1, ISYNC_SHOWN, 1 do

		local itemIndex = iItem + FauxScrollFrame_GetOffset(ISync_FavFrame_ListScrollFrame);
		local FavItemObj = getglobal("ISync_FavItem"..iItem);
		local FavItemObj_Button = getglobal("ISync_FavRemItem"..iItem);

		if(FavItemObj) then
		
			--check if were still within bounds
			if( itemIndex < ISync_Fav_SortIndex.onePastEnd) then
				
				if(ISync_Fav_SortIndex[itemIndex].quality ~= -99) then
					
					FavItemObj:SetText(ISync_Fav_SortIndex[itemIndex].name);

					local grabColor = ITEM_QUALITY_COLORS[tonumber(ISync_Fav_SortIndex[itemIndex].quality)];
					if( grabColor) then
						FavItemObj:SetTextColor(grabColor.r, grabColor.g, grabColor.b);
						FavItemObj.r = grabColor.r;
						FavItemObj.g = grabColor.g;
						FavItemObj.b = grabColor.b;
					else
						FavItemObj.r = 0;
						FavItemObj.g = 0;
						FavItemObj.b = 0;
					end
						
				else
					FavItemObj:SetText("|c00FC5252"..ISync_Fav_SortIndex[itemIndex].name.."|r");
				end
				
				FavItemObj.storeID = ISync_Fav_SortIndex[itemIndex].id;
				FavItemObj_Button.storeID = ISync_Fav_SortIndex[itemIndex].id;
				FavItemObj_Button.name = ISync_Fav_SortIndex[itemIndex].name;
				FavItemObj_Button.quality = ISync_Fav_SortIndex[itemIndex].quality;
				
				FavItemObj:Show();
				FavItemObj_Button:Show();
			else
			
				FavItemObj.storeID = nil;
				FavItemObj_Button.storeID = nil;
				FavItemObj_Button.name = nil;
				FavItemObj_Button.quality = nil;
				
				FavItemObj:SetText("");
				FavItemObj:Hide();
				FavItemObj_Button:Hide();
			
			end--if( itemIndex < ISync_Fav_SortIndex.onePastEnd ) then
			
		end--if(FavItemObj) then
			
	end--for iItem = 1, ISYNC_SHOWN, 1 do

end



---------------------------------------------------
-- ISync:Fav_ButtonEnter()
---------------------------------------------------
function ISync:Fav_ButtonEnter()
	
	if(not this.storeID) then return nil; end
	
	local xPL1, xPL2;
	
	xPL1 = string.gsub(this.storeID, "^(%d+):(%d+)$", "%1");
	xPL2 = string.gsub(this.storeID, "^(%d+):(%d+)$", "%2");
	
	if(not xPL1 or not xPL2) then return nil; end
		
	local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X, invType_X, icon_X  = GetItemInfo("item:"..xPL1..":0:"..xPL2..":0");

	if(name_X) then
		ISync_FavFrame.TooltipButton = this:GetID();
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		GameTooltip:SetHyperlink(link_X);
		ISync:Do_Parse(UIParent, ISyncTooltip, tonumber(xPL1), "item:"..xPL1..":0:"..xPL2..":0");
		ISync:SendtoMods(GameTooltip, name_X, "item:"..xPL1..":0:"..xPL2..":0", 1, quality_X);
	else
		ISync_FavFrame.TooltipButton = this:GetID();
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		GameTooltip:AddLine(" ", 0, 0, 0);
		GameTooltip:AddLine("|c00FF0000"..ISYNC_ITEMISINVALID_TOOLTIP1.."|r", 0, 0, 0);
		GameTooltip:AddLine("|c00A2D96F"..ISYNC_ITEMISINVALID_TOOLTIP2.."|r", 0, 0, 0);
		GameTooltip:AddLine("|c00FF0000"..ISYNC_ITEMISINVALID_TOOLTIP3.."|r", 0, 0, 0);
		GameTooltip:AddLine(" ", 0, 0, 0);
		GameTooltip:AddLine("|c0000FF00"..ISYNC_BT_ITEMID..":|r |c00BDFCC9"..xPL1.."|r", 0, 0, 0);
		GameTooltip:SetHyperlink("item:"..xPL1..":0:"..xPL2..":0");
		GameTooltip:Show();
	end

end


---------------------------------------------------
-- ISync:Fav_ButtonClick()
---------------------------------------------------
function ISync:Fav_ButtonClick(sButton)

	if(not this.storeID) then return nil; end

	local xPL1, xPL2;
	
	xPL1 = string.gsub(this.storeID, "^(%d+):(%d+)$", "%1");
	xPL2 = string.gsub(this.storeID, "^(%d+):(%d+)$", "%2");
	
	if(not xPL1 or not xPL2) then return nil; end
	

	--special thanks to Axu for the code :)  Support for AxuItemMenus
	if (AxuItemMenus_EvocationTest and this.storeID and AxuItemMenus_EvocationTest(sButton, "isync_fav")) then
		
		AxuItemMenus_FillFromLink("item:"..xPL1..":0:"..xPL2..":0");
		AxuItemMenus_OpenMenu();
	
	elseif (sButton == "LeftButton") then
	
		if( ChatFrameEditBox:IsVisible()) then

				local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X, invType_X, icon_X  = GetItemInfo("item:"..xPL1..":0:"..xPL2..":0");
				
				if(name_X and link_X and quality_X) then
	
					ChatFrameEditBox:Insert("|c"..ISync:ReturnHexColor(quality_X).."|H"..link_X.."|h["..name_X.."]|h|r");
				else
					ChatFrameEditBox:Insert("["..this:GetText().."]");
				end
				
		elseif( IsShiftKeyDown() and ChatFrameEditBox:IsVisible() and this.storeID) then

				local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X, invType_X, icon_X  = GetItemInfo("item:"..xPL1..":0:"..xPL2..":0");
				
				if(name_X and link_X and quality_X) then
	
					ChatFrameEditBox:Insert("|c"..ISync:ReturnHexColor(quality_X).."|H"..link_X.."|h["..name_X.."]|h|r");
				else
					ChatFrameEditBox:Insert("["..this:GetText().."]");
				end
						    
		elseif( IsControlKeyDown() and this.storeID) then
		
				local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X, invType_X, icon_X  = GetItemInfo("item:"..xPL1..":0:"..xPL2..":0");
				
				if(name_X and link_X and quality_X) then DressUpItemLink(link_X); end
				
		end--end checks
		
	end

end


---------------------------------------------------
-- ISync:FavRem_Click()
---------------------------------------------------
function ISync:FavRem_Click(sFrame)

	if(not sFrame.storeID) then return nil; end
	
	local sUser = UIDropDownMenu_GetText(ISync_FavFrame_DropDown);
	if(not sUser) then return nil; end
	if(not ISyncFav or not ISyncFav[sUser]) then return nil; end
	
	ISyncFav[sUser][sFrame.storeID] = nil; --delete it and refresh
	
	if(sFrame.quality ~=  -99) then
		ISync:Print("|c00A2D96FItemSync:|r "..ISYNC_REMFAV.." <<>> |r|c"..ISync:ReturnHexColor(sFrame.quality)..sFrame.name.."|r");
	else
		ISync:Print("|c00A2D96FItemSync:|r "..ISYNC_REMFAV.." <<>> |r|c00FC5252"..sFrame.name.."|r");
	end
	
	ISync:Fav_Refresh();

end


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------
-- ISync:FavPurge_Chk()
---------------------------------------------------
function ISync:FavPurge_Chk()

	local sUser = UIDropDownMenu_GetText(ISync_FavFrame_DropDown);
	if(not sUser) then return nil; end
	if(not ISyncFav or not ISyncFav[sUser]) then return nil; end
	
	StaticPopupDialogs["ISYNC_PURGEFAVITEM_CONFIRM"].text = TEXT(ISYNC_FAV_PURGECHK.."\n\n|c00FFFFFF"..sUser.."|r");
	StaticPopup_Show("ISYNC_PURGEFAVITEM_CONFIRM");

end


---------------------------------------------------
-- ISync:Fav_Purge()
---------------------------------------------------
function ISync:Fav_Purge()

	local sUser = UIDropDownMenu_GetText(ISync_FavFrame_DropDown);
	if(not sUser) then return nil; end
	if(not ISyncFav or not ISyncFav[sUser]) then return nil; end
	
	ISyncFav[sUser] = nil; --delete it
	ISyncFav[sUser] = { }; --recreate

	ISync:Fav_Refresh();
end