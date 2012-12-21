--[[--------------------------------------------------------------------------------
  ItemSync Filters Framework

  Author:  Derkyle
  Website: http://www.manaflux.com
-----------------------------------------------------------------------------------]]

---------------------------------------------------
-- ISync:Filter_DD_SetSelectedID
---------------------------------------------------
function ISync:Filter_DD_SetSelectedID(frame, id, names)
	UIDropDownMenu_SetSelectedID(frame, id);
	if( not frame ) then
		frame = this;
	end
	UIDropDownMenu_SetText(names[id].name, frame);
end



---------------------------------------------------
-- ISync:Filter_DD_Load
---------------------------------------------------
function ISync:Filter_DD_Load()

	--rarity
	UIDropDownMenu_Initialize(ISync_FilterPurgeRare_DropDown, ISync.Filter_DD_Initialize);
	ISync:Filter_DD_SetSelectedID(ISync_FilterPurgeRare_DropDown, 1, ISYNC_DD_RARITY);
	UIDropDownMenu_JustifyText("LEFT", ISync_FilterPurgeRare_DropDown)	
end




---------------------------------------------------
-- ISync:Filter_DD_Initialize
---------------------------------------------------
function ISync:Filter_DD_Initialize()
	local info;
	for i = 1, getn(ISYNC_DD_RARITY), 1 do
		info = { };
		info.text = ISYNC_DD_RARITY[i].name;
		info.func = ISync.Filter_DD_OnClick;
		UIDropDownMenu_AddButton(info);
	end
	
	info = nil;
end


---------------------------------------------------
-- ISync:Filter_DD_OnClick
---------------------------------------------------
function ISync:Filter_DD_OnClick()
	UIDropDownMenu_SetSelectedID(ISync_FilterPurgeRare_DropDown, this:GetID());
end



--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------
--ISync:FilterPurgeInvalid
---------------------------------------------------
function ISync:FilterPurgeInvalid()

	--make sure we have stuff to work with duh
	if(not ISyncDB or not ISYNC_REALM_NUM) then return nil; end
	if(not ISyncDB[ISYNC_REALM_NUM]) then return nil; end
	
	local index, value;

	--do the loop
	for index, value in ISyncDB[ISYNC_REALM_NUM] do

		sParseLink = ISync:FetchDB(index, "subitem");

		if(not sParseLink) then --this item has no subitems, cause it's subitem value = 0

			local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..index..":0:0:0");

			if(not name_X) then 
			
				ISyncDB[ISYNC_REALM_NUM][index] = nil;
			end


		else --it has subitems

			--make sure it's a table
			if(type(sParseLink) == "table") then

				for qindex, qvalue in sParseLink do

					--check
					local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..index..":0:"..qvalue..":0");

					--do we have a valid item?
					if(not name_X) then

						ISync:SetDB(index, "subitem", qvalue, "TRUE"); --remove it from array
					end

				end--for qindex, qvalue in sParseLink do
				
				--check again if we removed all of the subitems
				sParseLink = ISync:FetchDB(index, "subitem");
				
				if(not sParseLink) then --this item has no subitems, cause it's subitem value = 0

					local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..index..":0:0:0");

					if(not name_X) then 

						ISyncDB[ISYNC_REALM_NUM][index] = nil;
					end

				end
		

			end--if(type(sParseLink) == "table") then

		end--if(not sParseLink) then

	end--for index, value in ISyncDB[ISync_RealmNum] do
	
	
	--call a refresh
	ISync:Main_Refresh();

	DEFAULT_CHAT_FRAME:AddMessage("|c00A2D96FItemSync: "..ISYNC_INVALIDPURGESUCCESS..".|r");

end



---------------------------------------------------
-- ISync:FilterPurge
---------------------------------------------------
function ISync:FilterPurge()
local storeRarity, sParseLink;

	--make sure we have stuff to work with duh
	if(not ISyncDB or not ISYNC_REALM_NUM) then return nil; end
	if(not ISyncDB[ISYNC_REALM_NUM]) then return nil; end
	
	local index, value;

	--grab rarity
	if( ISYNC_DD_RARITY[UIDropDownMenu_GetSelectedID(ISync_FilterPurgeRare_DropDown)].sortType ) then
	
			local sortType = ISYNC_DD_RARITY[UIDropDownMenu_GetSelectedID(ISync_FilterPurgeRare_DropDown)].sortType;
			
			if( sortType == "NONE" ) then
				storeRarity = nil;
			else
				storeRarity = sortType;
			end
			
			
	end
	
	storeRarity = tonumber(storeRarity);
	
	if(not storeRarity) then
		DEFAULT_CHAT_FRAME:AddMessage("|c00A2D96FItemSync: "..ISYNC_FILTERINVALIDSELECTION..".|r");
		return nil;
	end
	
	--do the loop
	for index, value in ISyncDB[ISYNC_REALM_NUM] do

		sParseLink = ISync:FetchDB(index, "subitem");

		if(not sParseLink) then --this item has no subitems, cause it's subitem value = 0

			local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..index..":0:0:0");

			if(quality_X and quality_X == storeRarity) then 
			
				ISyncDB[ISYNC_REALM_NUM][index] = nil;
			end


		else --it has subitems

			--make sure it's a table
			if(type(sParseLink) == "table") then

				for qindex, qvalue in sParseLink do

					--check
					local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..index..":0:"..qvalue..":0");

					--do we have a valid item?
					if(quality_X and quality_X == storeRarity) then

						ISync:SetDB(index, "subitem", qvalue, "TRUE"); --remove it from array
					end

				end--for qindex, qvalue in sParseLink do
				
				--check again if we removed all of the subitems
				sParseLink = ISync:FetchDB(index, "subitem");
				
				if(not sParseLink) then --this item has no subitems, cause it's subitem value = 0

					local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..index..":0:0:0");

					if(quality_X and quality_X == storeRarity) then

						ISyncDB[ISYNC_REALM_NUM][index] = nil;
					end

				end
		

			end--if(type(sParseLink) == "table") then

		end--if(not sParseLink) then

	end--for index, value in ISyncDB[ISync_RealmNum] do
	
	
	--call a refresh
	ISync:Main_Refresh();

	DEFAULT_CHAT_FRAME:AddMessage("|c00A2D96FItemSync: "..ISYNC_FILTERPURGESUCCESS..".|r");

end




---------------------------------------------------
--ISync:Filter_MergeDB
---------------------------------------------------
function ISync:Filter_MergeDB()
	
	local ICountServ = 0;

	for ICountServ=0, tonumber(ISync:SetVar({"REALMS","REALMCOUNT"}, 0)) do
	
		--make sure it's not zero because zero is used a universal database number
		if(ICountServ ~= 0) then
		
			--make sure we have a database to work with
			if(ISyncDB and ISyncDB[ICountServ] and ISyncDB[0]) then
			
				for index, value in ISyncDB[ICountServ] do
				
					--now check to see if we have in the universal database, if we don't add it
					--if we do then delete from other server
					if(not ISyncDB[0][index]) then
						
						--add it to universal zero
						ISyncDB[0][index] = value;

					end
					
				
				end
				
					--now delete it
					ISyncDB[ICountServ] = nil;
			end
		
		end
	
	end


	DEFAULT_CHAT_FRAME:AddMessage("|c00A2D96FItemSync: "..ISYNC_OPTIONS_SERVER_MERGECOMPLETE.."|r");
end


