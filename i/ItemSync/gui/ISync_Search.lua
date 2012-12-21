--[[--------------------------------------------------------------------------------
  ItemSyncCore Search Framework

  Author:  Derkyle
  Website: http://www.manaflux.com
-----------------------------------------------------------------------------------]]

--lets setup the parse string
local ISync_sParse_type = "";

---------------------------------------------------
-- ISync:SF_SetSelectedID
---------------------------------------------------
function ISync:SF_SetSelectedID(frame, id, names)
	UIDropDownMenu_SetSelectedID(frame, id);
	if( not frame ) then
		frame = this;
	end
	UIDropDownMenu_SetText(names[id].name, frame);
end



---------------------------------------------------
-- ISync:SF_Load()
---------------------------------------------------
function ISync:SF_Load()

	--location
	UIDropDownMenu_Initialize(ISync_Location_DropDown, ISync.Location_DD_Initialize);
	ISync:SF_SetSelectedID(ISync_Location_DropDown, 1, ISYNC_DD_LOCATION);
	UIDropDownMenu_JustifyText("LEFT", ISync_Location_DropDown)

	--rarity
	UIDropDownMenu_Initialize(ISync_Rarity_DropDown, ISync.Rarity_DD_Initialize);
	ISync:SF_SetSelectedID(ISync_Rarity_DropDown, 1, ISYNC_DD_RARITY);
	UIDropDownMenu_JustifyText("LEFT", ISync_Rarity_DropDown)	

	--weapon
	UIDropDownMenu_Initialize(ISync_Weapons_DropDown, ISync.Weapons_DD_Initialize);
	ISync:SF_SetSelectedID(ISync_Weapons_DropDown, 1, ISYNC_DD_WEAPONS);
	UIDropDownMenu_JustifyText("LEFT", ISync_Weapons_DropDown)
	
	--tradeskills
	UIDropDownMenu_Initialize(ISync_Tradeskills_DropDown, ISync.Tradeskills_DD_Initialize);
	ISync:SF_SetSelectedID(ISync_Tradeskills_DropDown, 1, ISYNC_DD_TRADESKILLS);
	UIDropDownMenu_JustifyText("LEFT", ISync_Tradeskills_DropDown)
	
	--armor
	UIDropDownMenu_Initialize(ISync_Armor_DropDown, ISync.Armor_DD_Initialize);
	ISync:SF_SetSelectedID(ISync_Armor_DropDown, 1, ISYNC_DD_ARMOR);
	UIDropDownMenu_JustifyText("LEFT", ISync_Armor_DropDown)
	
	--shield
	UIDropDownMenu_Initialize(ISync_Shield_DropDown, ISync.Shield_DD_Initialize);
	ISync:SF_SetSelectedID(ISync_Shield_DropDown, 1, ISYNC_DD_SHIELD);
	UIDropDownMenu_JustifyText("LEFT", ISync_Shield_DropDown)
	
	--Level
	UIDropDownMenu_Initialize(ISync_Level_DropDown, ISync.Level_DD_Initialize);
	ISync:SF_SetSelectedID(ISync_Level_DropDown, 1, ISYNC_DD_LEVEL);
	UIDropDownMenu_JustifyText("LEFT", ISync_Level_DropDown)
	
	
	--Setup the parser string
	ISync_sParse_type = "^";
	for i = 1, ISYNC_DB_MAX, 1 do
	
		if(i ~= ISYNC_DB_MAX) then
			ISync_sParse_type = ISync_sParse_type.."(.-)°";
		else
			ISync_sParse_type = ISync_sParse_type.."(.-)$";
		end
	
	end

	
end



---------------------------------------------------
-- ISync:Location_DD_Initialize()
---------------------------------------------------
function ISync:Location_DD_Initialize()
	local info;
	for i = 1, getn(ISYNC_DD_LOCATION), 1 do
		info = { };
		info.text = ISYNC_DD_LOCATION[i].name;
		info.func = ISync.Location_DD_OnClick;
		UIDropDownMenu_AddButton(info);
	end
info = nil;
end

function ISync:Rarity_DD_Initialize()
	local info;
	for i = 1, getn(ISYNC_DD_RARITY), 1 do
		info = { };
		info.text = ISYNC_DD_RARITY[i].name;
		info.func = ISync.Rarity_DD_OnClick;
		UIDropDownMenu_AddButton(info);
	end
info = nil;
end


function ISync:Weapons_DD_Initialize()
	local info;
	for i = 1, getn(ISYNC_DD_WEAPONS), 1 do
		info = { };
		info.text = ISYNC_DD_WEAPONS[i].name;
		info.func = ISync.Weapons_DD_OnClick;
		UIDropDownMenu_AddButton(info);
	end
info = nil;
end


function ISync:Tradeskills_DD_Initialize()
	local info;
	for i = 1, getn(ISYNC_DD_TRADESKILLS), 1 do
		info = { };
		info.text = ISYNC_DD_TRADESKILLS[i].name;
		info.func = ISync.Tradeskills_DD_OnClick;
		UIDropDownMenu_AddButton(info);
	end
info = nil;
end


function ISync:Armor_DD_Initialize()
	local info;
	for i = 1, getn(ISYNC_DD_ARMOR), 1 do
		info = { };
		info.text = ISYNC_DD_ARMOR[i].name;
		info.func = ISync.Armor_DD_OnClick;
		UIDropDownMenu_AddButton(info);
	end
info = nil;
end

function ISync:Shield_DD_Initialize()
	local info;
	for i = 1, getn(ISYNC_DD_SHIELD), 1 do
		info = { };
		info.text = ISYNC_DD_SHIELD[i].name;
		info.func = ISync.Shield_DD_OnClick;
		UIDropDownMenu_AddButton(info);
	end
info = nil;
end


function ISync:Level_DD_Initialize()
	local info;
	for i = 1, getn(ISYNC_DD_LEVEL), 1 do
		info = { };
		info.text = ISYNC_DD_LEVEL[i].name;
		info.func = ISync.Level_DD_OnClick;
		UIDropDownMenu_AddButton(info);
	end
info = nil;
end



---------------------------------------------------
-- ISync:Location_DD_OnClick()
---------------------------------------------------
function ISync:Location_DD_OnClick()
	UIDropDownMenu_SetSelectedID(ISync_Location_DropDown, this:GetID());
end
function ISync:Rarity_DD_OnClick()
	UIDropDownMenu_SetSelectedID(ISync_Rarity_DropDown, this:GetID());
end
function ISync:Weapons_DD_OnClick()
	UIDropDownMenu_SetSelectedID(ISync_Weapons_DropDown, this:GetID());
end
function ISync:Tradeskills_DD_OnClick()
	UIDropDownMenu_SetSelectedID(ISync_Tradeskills_DropDown, this:GetID());
end
function ISync:Armor_DD_OnClick()
	UIDropDownMenu_SetSelectedID(ISync_Armor_DropDown, this:GetID());
end
function ISync:Shield_DD_OnClick()
	UIDropDownMenu_SetSelectedID(ISync_Shield_DropDown, this:GetID());
end
function ISync:Level_DD_OnClick()
	UIDropDownMenu_SetSelectedID(ISync_Level_DropDown, this:GetID());
end



---------------------------------------------------
-- ISync:SF_MatchSearch()
---------------------------------------------------
function ISync:SF_MatchSearch(sID, sName, sQuality)
local sRarity = 0;
local sRarity_string = nil;
local sWL = 0;
local sWT = 0;
local sTS = 0;
local sAT = 0;
local sST = 0;

local sLvl1 = 0;
local sLvl2 = 0;

local storeLVL;
local sParseLink;
		
		--check for stuff first
		if(not sID) then return nil; end
		if(not tonumber(sID)) then return nil; end
		
		sID = tonumber(sID);

		if(not ISyncDB) then return nil; end --the database should have been created
		if(not ISyncDB[ISYNC_REALM_NUM][sID]) then return nil; end --don't even bother

		

		ISYNC_SHOWSEARCH_CHK = 1; --set search activated


	--------------------------------------------
	--check rarity
	if( ISYNC_DD_RARITY[UIDropDownMenu_GetSelectedID(ISync_Rarity_DropDown)].sortType ) then
	
			local sortType = ISYNC_DD_RARITY[UIDropDownMenu_GetSelectedID(ISync_Rarity_DropDown)].sortType;
			
			if( sortType == "NONE" ) then
				sRarity = 0;
				sRarity_string = nil; --just to make sure
			else
				sRarity = 1;
				sRarity_string = sortType;
			end
			
			
	end
	
	
	
	--------------------------------------------
	--check weapon location
	if( ISYNC_DD_LOCATION[UIDropDownMenu_GetSelectedID(ISync_Location_DropDown)].sortType ) then
	
			local sortType = ISYNC_DD_LOCATION[UIDropDownMenu_GetSelectedID(ISync_Location_DropDown)].sortType;
			
			if( sortType == "NONE" ) then
				sWL = 0;
			else
				sWL = ISYNC_WeaponLocation[sortType];
			end
	end
	
	
	--------------------------------------------
	
	--------------------------------------------
	--check weapon type
	if( ISYNC_DD_WEAPONS[UIDropDownMenu_GetSelectedID(ISync_Weapons_DropDown)].sortType ) then
	
			local sortType = ISYNC_DD_WEAPONS[UIDropDownMenu_GetSelectedID(ISync_Weapons_DropDown)].sortType;
			
			if( sortType == "NONE" ) then
				sWT = 0;
			else
				sWT = ISYNC_WeaponTypes[sortType];
			end
	end
	--------------------------------------------
	

	--------------------------------------------
	--check tradeskill
	if( ISYNC_DD_TRADESKILLS[UIDropDownMenu_GetSelectedID(ISync_Tradeskills_DropDown)].sortType ) then
	
			local sortType = ISYNC_DD_TRADESKILLS[UIDropDownMenu_GetSelectedID(ISync_Tradeskills_DropDown)].sortType;
			
			if( sortType == "NONE" ) then
				sTS = 0;
			else
				sTS = ISYNC_TradeSkills[sortType];
			end
	end
	--------------------------------------------
	
	
	--------------------------------------------
	--check armor type
	if( ISYNC_DD_ARMOR[UIDropDownMenu_GetSelectedID(ISync_Armor_DropDown)].sortType ) then
	
			local sortType = ISYNC_DD_ARMOR[UIDropDownMenu_GetSelectedID(ISync_Armor_DropDown)].sortType;
			
			if( sortType == "NONE" ) then
				sAT = 0;
			else
				sAT = ISYNC_ArmorTypes[sortType];
			end
	end
	--------------------------------------------


	--------------------------------------------
	--check shield type
	if( ISYNC_DD_SHIELD[UIDropDownMenu_GetSelectedID(ISync_Shield_DropDown)].sortType ) then
	
			local sortType = ISYNC_DD_SHIELD[UIDropDownMenu_GetSelectedID(ISync_Shield_DropDown)].sortType;
			
			if( sortType == "NONE" ) then
				sST = 0;
			else
				sST = ISYNC_ShieldTypes[sortType];
			end
	end
	--------------------------------------------
	
	
	--------------------------------------------
	--check level
	if( ISYNC_DD_LEVEL[UIDropDownMenu_GetSelectedID(ISync_Level_DropDown)].sortType ) then
	
			local sortType = ISYNC_DD_LEVEL[UIDropDownMenu_GetSelectedID(ISync_Level_DropDown)].sortType;
			
			if( sortType == "NONE" ) then
				sLvl1 = 0;
				sLvl2 = 0;
			else
				if(sortType == 0) then
					sLvl1 = 1;
					sLvl2 = 5;
				elseif(sortType == 1) then
					sLvl1 = 5;
					sLvl2 = 10;
				elseif(sortType == 2) then
					sLvl1 = 10;
					sLvl2 = 15;
				elseif(sortType == 3) then
					sLvl1 = 15;
					sLvl2 = 20;
				elseif(sortType == 4) then
					sLvl1 = 20;
					sLvl2 = 25;
				elseif(sortType == 5) then
					sLvl1 = 25;
					sLvl2 = 30;
				elseif(sortType == 6) then
					sLvl1 = 30;
					sLvl2 = 35;
				elseif(sortType == 7) then
					sLvl1 = 35;
					sLvl2 = 40;
				elseif(sortType == 8) then
					sLvl1 = 40;
					sLvl2 = 45;
				elseif(sortType == 9) then
					sLvl1 = 45;
					sLvl2 = 50;
				elseif(sortType == 10) then
					sLvl1 = 50;
					sLvl2 = 55;
				elseif(sortType == 11) then
					sLvl1 = 55;
					sLvl2 = 60;
				end
			end
	end
	
	
	--------------------------------------------


--Check Text
--------------------------------------
--------------------------------------		
	
		if(ISync_TextEditBox:GetText() and ISync_TextEditBox:GetText() ~= "") then
		
			ISync_QuickSearch:SetText("");

			if not string.find( string.lower(sName), string.lower( ISync_TextEditBox:GetText() ) )  then
				return nil;
			end
			
		elseif(ISync_QuickSearch:GetText() and ISync_QuickSearch:GetText() ~= "") then
		
			ISync_TextEditBox:SetText("");
		
			if not string.find( string.lower(sName), string.lower( ISync_QuickSearch:GetText() ) )  then
				return nil;
			end

		end
		
		
		
	
--------------------------------------
--------------------------------------	



--Check Rarity
--------------------------------------
--------------------------------------		
	
		if(sRarity > 0 and sRarity_string ~= nil) then

			if ( tonumber(sQuality) ~= tonumber(sRarity_string)) then
				return nil;
			end
			

		end
	
--------------------------------------
--------------------------------------	


local sStorePattern = ISyncDB[ISYNC_REALM_NUM][sID];



--Check Weapon Location
--------------------------------------
--------------------------------------		
	
		if(sWL > 0) then
		
			sParseLink = nil; --reset
			sParseLink = string.gsub(sStorePattern, ISync_sParse_type, "%3");
			
			if (tonumber(sParseLink) and tonumber(sParseLink) ~= tonumber(sWL)) then
				return nil;
			end
			

		end
	
--------------------------------------
--------------------------------------	


--Check Weapon Type
--------------------------------------
--------------------------------------		
	
		if(sWT > 0) then
		
			--get id
			sParseLink = nil; --reset
			sParseLink = string.gsub(sStorePattern, ISync_sParse_type, "%4");
			

			if ( tonumber(sParseLink) and tonumber(sParseLink) ~= tonumber(sWT)) then
				return nil;
			end
			

		end
	
--------------------------------------
--------------------------------------	


--Check Tradeskill
--------------------------------------
--------------------------------------		
	
		if(sTS > 0) then
		
			--get id
			sParseLink = nil; --reset
			sParseLink = string.gsub(sStorePattern, ISync_sParse_type, "%5");


			if ( tonumber(sParseLink) and tonumber(sParseLink) ~= tonumber(sTS)) then
				return nil;
			end
			

		end
	
--------------------------------------
--------------------------------------	
	



--Check Armor Type
--------------------------------------
--------------------------------------		
	
		if(sAT > 0) then

		
			--get id
			sParseLink = nil; --reset
			sParseLink = string.gsub(sStorePattern, ISync_sParse_type, "%6");
			
			
			if ( tonumber(sParseLink) and tonumber(sParseLink) ~= tonumber(sAT)) then
				return nil;
			end
			

		end
	
--------------------------------------
--------------------------------------	
		
		
--Check Shield Type
--------------------------------------
--------------------------------------		
	
		if(sST > 0) then


			--get id
			sParseLink = nil; --reset
			sParseLink = string.gsub(sStorePattern, ISync_sParse_type, "%7");
			
			
			if ( tonumber(sParseLink) and tonumber(sParseLink)~= tonumber(sST)) then
				return nil;
			end
			

		end
	
--------------------------------------
--------------------------------------	


--Check Level
--------------------------------------
--------------------------------------		
	
		if(sLvl1 > 0 and sLvl2 > 0) then
		
			--get id
			sParseLink = nil; --reset
			sParseLink = string.gsub(sStorePattern, ISync_sParse_type, "%8");
	
			if (tonumber(sParseLink) and tonumber(sParseLink) >= sLvl1 and tonumber(sParseLink) <= sLvl2) then
				--do nothing
			else
				return nil;
			end
			

		end
	
--------------------------------------
--------------------------------------	



	--if EVERYTHING checks out then return yes
	--return yes
	return 1;


end




---------------------------------------------------
-- ISync:SF_Close()
---------------------------------------------------
function ISync:SF_Close()

	HideUIPanel(ISync_SearchFrame);
	ISYNC_SHOWSEARCH_CHK = 0; --reset and refresh
	
	--reset all to NONE
	ISync:SF_SetSelectedID(ISync_Location_DropDown, 1, ISYNC_DD_LOCATION);
	ISync:SF_SetSelectedID(ISync_Rarity_DropDown, 1, ISYNC_DD_RARITY);
	ISync:SF_SetSelectedID(ISync_Weapons_DropDown, 1, ISYNC_DD_WEAPONS);
	ISync:SF_SetSelectedID(ISync_Tradeskills_DropDown, 1, ISYNC_DD_TRADESKILLS);
	ISync:SF_SetSelectedID(ISync_Armor_DropDown, 1, ISYNC_DD_ARMOR);
	ISync:SF_SetSelectedID(ISync_Shield_DropDown, 1, ISYNC_DD_SHIELD);
	ISync:SF_SetSelectedID(ISync_Level_DropDown, 1, ISYNC_DD_LEVEL);
	
	ISync_TextEditBox:SetText("");

end



---------------------------------------------------
-- ISync:SF_Reset()
---------------------------------------------------
function ISync:SF_Reset()


	--reset all to NONE
	ISync:SF_SetSelectedID(ISync_Location_DropDown, 1, ISYNC_DD_LOCATION);
	ISync:SF_SetSelectedID(ISync_Rarity_DropDown, 1, ISYNC_DD_RARITY);
	ISync:SF_SetSelectedID(ISync_Weapons_DropDown, 1, ISYNC_DD_WEAPONS);
	ISync:SF_SetSelectedID(ISync_Tradeskills_DropDown, 1, ISYNC_DD_TRADESKILLS);
	ISync:SF_SetSelectedID(ISync_Armor_DropDown, 1, ISYNC_DD_ARMOR);
	ISync:SF_SetSelectedID(ISync_Shield_DropDown, 1, ISYNC_DD_SHIELD);
	ISync:SF_SetSelectedID(ISync_Level_DropDown, 1, ISYNC_DD_LEVEL);
	
	ISync_TextEditBox:SetText("");
	
	
end