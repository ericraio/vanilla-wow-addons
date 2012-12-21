--[[--------------------------------------------------------------------------------
  ItemSync Framework

  Author:  Derkyle
  Website: http://www.manaflux.com
-----------------------------------------------------------------------------------]]

ISYNC_VERSION = 12.4; --version

--EMBED
ISync =  {};

--REALM_NUM
ISYNC_REALM_NUM = 0;

--GLOBALS
ISYNC_LOADYES = 0;
ISYNC_VARLOAD = 0;
ISYNC_LOADONCE 	= 0;
ISYNC_DB_MAX = 12;


--HOOKS
local ISync_HookedMoney;
local ISync_HookedOnShow;

local ISChatRepChk = "";
local SetDB_RepeatChk = "";
local ItemSync_MouseArray = { };


---------------------------------------------------
-- ISync:PrimaryLoad()
---------------------------------------------------
function ISync:PrimaryLoad()

	--display loaded
	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("|c00A2D96FDerkyle's ItemSync Ver. ["..ISYNC_VERSION.."]|r  |cffffffffType: /itemsync  /isync  /ims  /is");
	end

	-- Register our slash command
	---------------------------------------------------
	SLASH_ITEMSYNC1 = "/itemsync";
	SLASH_ITEMSYNC2 = "/isync";
	SLASH_ITEMSYNC3 = "/ims";
	SLASH_ITEMSYNC4 = "/is";
	SlashCmdList["ITEMSYNC"] = ISync_SlashCommand;

	
	--this is for AxuItemMenus :) Thanks Axu!
	if (AxuItemMenus_AddConfigToggle) then

		AxuItemMenus_AddConfigToggle({
		id = "isync", -- this appears in my previous snippet
		default = true, -- feature enabled by default
		-- consider localizing the following:
		text = "ItemSync",
		helptext = "Enable pop-up menus in ItemSync"
		});
	end
	
	tinsert(UISpecialFrames, "ISync_MainFrame");
	
end


---------------------------------------------------
-- ISync:OnPrimaryEvent()
---------------------------------------------------
function ISync:OnPrimaryEvent(event,arg1,arg2,arg3,arg4,arg5)


	if( event == "VARIABLES_LOADED" ) then
	
		--enable primary data structure
		if( not ISyncDB ) then ISyncDB = { }; end
		if( not ISyncDB_Names ) then ISyncDB_Names = { }; end
		
		--check favorites
		if( not ISyncFav ) then ISyncFav = { }; end
		if( not ISyncFav[UnitName("player")] ) then ISyncFav[UnitName("player")] = { }; end
		
			--check for old version, if we are starting fresh add it as current
			if(ISyncOpt and ISyncOpt.Version) then
				ISync:SetVar({"ISYNC_VER","OLDVERSION"}, ISyncOpt.Version);
				ISyncOpt = nil;
				ISyncOpt = { }; --delete it so we can recreate
				
--				ISync_DBPopUp:Show();
				
			elseif(not ISync:SetVar({"ISYNC_VER","OLDVERSION"}, ISYNC_VERSION, "CHK")) then
				ISync:SetVar({"ISYNC_VER","OLDVERSION"}, ISYNC_VERSION);
				
--				ISync_DBPopUp:Show();
			end
			
		--reset
		GameTooltip.isDisplayDone = nil;
		GameTooltip.SendtoMods = nil;
		
		--options check and set
		ISync:SetVar({"OPT","PRICE"}, 1);
		ISync:SetVar({"OPT","VENDOR"}, 1);
		ISync:SetVar({"OPT","MONEYSET"}, 1);
		ISync:SetVar({"OPT","ITEMCOUNTDISPLAY"}, 0);
		ISync:SetVar({"OPT","RARITY_DD"}, "name");
		ISync:SetVar({"OPT","SHOWMONEYICONS"}, 0);
		ISync:SetVar({"OPT","ITEMCOUNT_VALID"}, 0);
		ISync:SetVar({"OPT","ITEMCOUNT_INVALID"}, 0);
		ISync:SetVar({"OPT","MINIMAP_SHOW"}, 0);
		ISync:SetVar({"OPT","MINIMAP_LOC"}, 305);
		ISync:SetVar({"OPT","TOOLTIPITEMICONS"}, 1);
		ISync:SetVar({"OPT","LINKFETCH"}, 0);
		ISync:SetVar({"OPT","MOUSEOVERINSPECT"}, 1);
		--layout
		ISync:SetVar({"LAYOUT","GOLD"}, "|c00FFFFFF%s|r|c00E2CD54"..ISYNC_OPTGOLD1.."|r ");
		ISync:SetVar({"LAYOUT","SILVER"}, "|c00FFFFFF%s|r|c00AEAEAE"..ISYNC_OPTSILVER1.."|r ");
		ISync:SetVar({"LAYOUT","COPPER"}, "|c00FFFFFF%s|r|c00D7844D"..ISYNC_OPTCOPPER1.."|r");
		--alerts
		ISync:SetVar({"ALERT","QUALITY"}, 0);
		ISync:SetVar({"ALERT","INVALID"}, 0);
		--mods
		ISync:SetVar({"MOD","AMAS"}, 0);
		ISync:SetVar({"MOD","AUCTIONEER"}, 0);
		ISync:SetVar({"MOD","REAGENTINFO"}, 0);
		--filters
		ISync:SetVar({"FILTERS",0}, 1);
		ISync:SetVar({"FILTERS",1}, 1);
		ISync:SetVar({"FILTERS",2}, 1);
		ISync:SetVar({"FILTERS",3}, 1);
		ISync:SetVar({"FILTERS",4}, 1);
		ISync:SetVar({"FILTERS",5}, 1);
		--bagview
		ISync:SetVar({"BAGVIEW","SHOWSTACKED"}, 1);
		ISync:SetVar({"BAGVIEW","SHOWNIL"}, 0);
		ISync:SetVar({"BAGVIEW","SORT_VALUE"}, 1);
		ISync:SetVar({"BAGVIEW","SORT_RARITY"}, 0);
		--required refresh for new items
		ISync:SetVar({"REQUIRED","REFRESH"}, 0);
		

		--check for data
		if (not ISync:GrabDataProfile() ) then
			ISYNC_LOADYES = 0;
			DEFAULT_CHAT_FRAME:AddMessage("|c00A2D96FItemSync:|r |cffffffffNo profile could be generated.  ItemSync has been halted.|r");
		else
			ISYNC_LOADYES = 1;
			ISYNC_REALM_NUM = ISync:GrabDataProfile();
		end--if (not ISync:GrabDataProfile() ) then
		
		
		ISync:Fav_DD_Load();
		ISync:MiniMapButton_Init();
		
			

	elseif( event == "PLAYER_TARGET_CHANGED" ) then

		--check first
		if(ISYNC_LOADYES == 1) then
			if(not UnitIsUnit("target", "player") and UnitIsPlayer("target") ) then 
				ISync:InspectTarget("target"); 
			end
		end
		
	--mouseover
	elseif( event == "UPDATE_MOUSEOVER_UNIT" ) then

		--check first
		if(ISYNC_LOADYES == 1) then
			--check to see if the user allowed it
			if(ISync:SetVar({"OPT","MOUSEOVERINSPECT"}, 1, "COMPARE")) then
				if(not UnitIsUnit("mouseover", "player") and UnitIsPlayer("mouseover") ) then 
					ISync:InspectTarget("mouseover"); 
				end
			end
		end
		
	--the inventory has been updated so lets check it again
	elseif( event == "UNIT_INVENTORY_CHANGED" ) then

		if(ISYNC_LOADYES == 1 and arg1 == "player" ) then  ISync_CoreFrame.unitinvchanged = .2; end
		
	--bank frame opened so lets scan that too
	elseif( event == "BANKFRAME_OPENED" ) then

		if(ISYNC_LOADYES == 1) then ISync:ScanBank(); end
		
	--scan auction window
	elseif( event == "AUCTION_ITEM_LIST_UPDATE" ) then

		if(ISYNC_LOADYES == 1) then ISync:ScanAuction(); end

	--scan merchant window
	elseif( event == "MERCHANT_SHOW" ) then
        	
		if(ISYNC_LOADYES == 1) then ISync:MerchantMoneyScan(this); end
		if(ISYNC_LOADYES == 1) then ISync:VendorScan(); end
		if(ISYNC_LOADYES == 1) then ISync:BV_Refresh(); end
		
	--scan tooltip money
	elseif( event == "BAG_UPDATE" ) then
	
		if(ISYNC_LOADYES == 1) then ISync_CoreFrame.bagupdate = .2; end
		
	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
	
		if(ISYNC_LOADYES == 1 and ISYNC_LOADONCE == 0) then
		
		
			---VERSION CHECKS
			----------------------------------------------------------
		
			ISync:SetVar({"ISYNC_VER","VERSION"}, ISYNC_VERSION); --create if it doesn't exist

			--check update
			if(tonumber(ISync:SetVar({"ISYNC_VER","VERSION"}, ISYNC_VERSION)) < ISYNC_VERSION) then

				ISync:CleanupDB(nil, nil); --force it

				ISync:SetVar({"ISYNC_VER","VERSION"}, ISYNC_VERSION, "TRUE");

			end
			----------------------------------------------------------
			
		
			ISync:InspectTarget("player");
			ISync:ScanInv();
			ISync:ItemDisplay_Update();
			ISYNC_LOADONCE = 1;
			
		end

	--rest
	else
		
		--send to parse, it's chat information to be parsed
		--since sometimes chat informations loves to send doubles lets check for that
		if(ISYNC_LOADYES == 1 and arg1) then
		
			--check for repeats
      			if(ISChatRepChk ~= event..arg1) then
				ISChatRepChk =  event..arg1;
				ISync:ProcessLinks(arg1, "CHAT", nil, nil);
			end
			
		end

	end--end event checks


end



---------------------------------------------------
-- ISync:OnUpdateTriggered()
---------------------------------------------------
function ISync:OnUpdateTriggered(elapsed)

	--BAG_UPDATE
	if(ISync_CoreFrame.bagupdate) then
	
		--update the laspe
		ISync_CoreFrame.bagupdate = ISync_CoreFrame.bagupdate - elapsed;
		
		--check if the timer ran out
		if ( ISync_CoreFrame.bagupdate <= 0 ) then
			
			ISync:BV_Refresh();
			ISync_CoreFrame.bagupdate = nil;

		end

	end
	
	
	--UNIT_INVENTORY_CHANGED
	if(ISync_CoreFrame.unitinvchanged) then
	
		--update the laspe
		ISync_CoreFrame.unitinvchanged = ISync_CoreFrame.unitinvchanged - elapsed;
		
		--check if the timer ran out
		if ( ISync_CoreFrame.unitinvchanged <= 0 ) then
			
			--inspect user and inventory
			ISync:InspectTarget("player");
			ISync:ScanInv();
			ISync:BV_Refresh();
			ISync_CoreFrame.unitinvchanged = nil;
			
		end

	end

end



-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------


---------------------------------------------------
-- ISync:ProcessLinks()
---------------------------------------------------
function ISync:ProcessLinks(sText, sEvent, sVendorPrice, sVendorQty)
	
	if(ISYNC_LOADYES == 0) then return nil; end --don't run if the profile didn't load
	if(not sText) then return nil; end --no data no parsing
	if(not ISyncDB) then return nil; end --the database should have been created
	if(not ISyncDB[ISYNC_REALM_NUM]) then return nil; end --don't even bother

	--locals
	local item, name, color, sPL, xPL1, xPL2;

	--do the loop
	for color, item, name in string.gfind(sText, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r") do
			
		--make sure we have data to process
		if( color and item and name ) then
		
			sPL  = string.gsub(item, "^(%d+):(%d+):(%d+):(%d+)$", "%1:0:%3:0");
			xPL1 = string.gsub(item, "^(%d+):(%d+):(%d+):(%d+)$", "%1");
			xPL2 = string.gsub(item, "^(%d+):(%d+):(%d+):(%d+)$", "%3");
			
			if(not sPL or not xPL1 or not xPL2) then return nil; end --don't bother
			
			xPL1 = tonumber(xPL1);
			xPL2 = tonumber(xPL2);
			
			--sometimes in chat the information isnt grabbed because not been clicked on
			--but we can get around this by setting it to the tooltip
			-----------------------------------------------------------------------
			if(sEvent and sEvent == "CHAT") then

				local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X, equipType_X, iconTexture_X  = GetItemInfo("item:"..sPL);
				
				if(not name_X) then
					ISync_MainFrame.TooltipButton = this:GetID();
					GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
					GameTooltip:SetHyperlink("item:"..sPL);
					GameTooltip:Hide();
				end
				
			end
			-----------------------------------------------------------------------
			
			--grab the info
			local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X, equipType_X, iconTexture_X  = GetItemInfo("item:"..sPL);
			
			
			--check
			if(name_X and link_X and quality_X and ISync:SetVar({"FILTERS",quality_X}, 1, "COMPARE")) then
				
				
				--if we don't have it then add it
				if(not ISync:FetchDB(xPL1, "chk")) then
					
					
					--check for SPOOFS
					if(not ISync:CheckSpoof(item, equipType_X, quality_X)) then return nil; end

					--add the item
					ISync:SetDB(xPL1, "subitem", xPL2);
					ISync:SetDB(xPL1, "quality", quality_X);

					--parse it
					ISync:Do_Parse(UIParent, ISyncTooltip, xPL1, link_X);
				
				--check if we have it as a subitem, if not add it
				elseif(xPL2 ~= 0 and not ISync:FetchDB(xPL1, "subitem", xPL2)) then
				
					ISync:SetDB(xPL1, "subitem", xPL2);
	
				end--if(not ISync:FetchDB(name_X, "item")) then
				
				
				-------------------------------------------------
				--VENDOR INFORMATION
				if(sVendorPrice or sVendorQty) then

					--check vendor stuff
					if(sVendorPrice) then
						ISync:SetDB(xPL1, "vendor", sVendorPrice);
					end
					if(sVendorQty) then
						ISync:SetDB(xPL1, "vendorqty", sVendorQty);
					end

				end
				-------------------------------------------------
				
				
			end--if(name_X) then
			
		end--if( color and item and name ) then
		
	end--for color, item, name 

end


---------------------------------------------------
-- ISync:CheckSpoof()
-- This code is inspired by Brodrick
---------------------------------------------------
--sLink cannot have itemid: in the front
function ISync:CheckSpoof(sLink, sEquipT, sQuality)

	--check
	if(not sLink or not sEquipT or not sQuality) then return nil; end
	
	--folks were starting to use empty values to create spoofs.
	if(sLink == "0:0:0:0") then return nil; end
	

	--grab the item information based on it's string id
	local _, _, sItemID, sEnchant, sItemStat, sSetBonus = string.find( sLink, "(%d+):(%d+):(%d+):(%d+)" );

	
	--make sure
	if(not sEnchant or not sItemID or not sItemStat) then return nil; end
	
	
	--grab array of items that can't have items stats
	local ChkItem = {
		[""] = 2,
		["INVTYPE_TRINKET"] = 2,
		["INVTYPE_AMMO"] = 2,
		["INVTYPE_THROWN"] = 2,
		["INVTYPE_BAG"] = 2,
		["INVTYPE_TABARD"] = 2,
		["INVTYPE_BODY"] = 2, --INVTYPE_BODY is not INVTYPE_CHEST or INVTYPE_ROBE
		["INVTYPE_HOLDABLE"] = 1,
		["INVTYPE_FINGER"] = 1,
		["INVTYPE_WAIST"] = 1,
	}


	--first check the stats
	if ( sItemStat and tonumber(sItemStat) > 0 ) then

		--check quality, greens, blues and one epic are allowed to have 'of the' only
		if ( sQuality ~= 2 and sQuality ~= 3 and sItemID ~= "20039" ) then
			--20039: is dark iron boots which is an exception

			--error this item is invalid return nil
			return nil;

		--only certain items can have bonues 'of the'
		elseif( ChkItem[sEquipT] == 2 ) then

			--error this item is invalid return nil
			return nil;
		end


	end


	--check for enchants
	if ( sEnchant and tonumber(sEnchant) > 0 ) then

		--only armor and weapons can have enchants
		if ( ChkItem[sEquipT] ) then

			return nil;

		end
	end


	--everything checks out so return true
	return 1;	
	
	
end


-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

---------------------------------------------------
-- ISync:InspectTarget()
---------------------------------------------------
function ISync:InspectTarget(sTarget)
	
	if(sTarget == "mouseover") then
		--we don't want to check the user over and over and over again
		
		local sName = UnitName(sTarget); --get their name
		local sGetTime = GetTime(); --get current time
		local sLastScan = ItemSync_MouseArray[sName]; --get last time scanned if any
		
		if ( sLastScan and sGetTime - sLastScan < 120 ) then --check if we have scanned them anytime soon
			return nil; --we did so return nil
		end
		
		--initiate if not there
		ItemSync_MouseArray.iCount = (ItemSync_MouseArray.iCount or 0);
		if(ItemSync_MouseArray.iCount and ItemSync_MouseArray.iCount < 0) then ItemSync_MouseArray.iCount = 0; end
		
		
		--we didn't so lets add them to the array
		--first fix the array if we have exceeded our limit
		if( ItemSync_MouseArray.iCount > 100 ) then
			
			--clean array
			for xKey, xVar in ItemSync_MouseArray do
				
				if(xKey ~= "iCount") then
				
					if(xVar and (GetTime() - xVar) > 120) then --time expired so lets remove
						ItemSync_MouseArray[xKey] = nil;
						ItemSync_MouseArray.iCount = ItemSync_MouseArray.iCount - 1; --decrease
					end
				
				end
			end

		end
		
		--if for some reason it's still bigger then limit, then reset it.  We don't want a memory leak.
		if(ItemSync_MouseArray.iCount > 100) then
			ItemSync_MouseArray = nil;
			ItemSync_MouseArray = { };
		end
		
		ItemSync_MouseArray[sName] = GetTime();
		ItemSync_MouseArray.iCount = (ItemSync_MouseArray.iCount or 0) + 1;
	
	end--if(sTarget == "mouseover") then


	for i = 1, 19, 1 do
		local link = GetInventoryItemLink(sTarget, i);
		if( link ) then
			ISync:ProcessLinks(link, nil, nil, nil)
		end
	end--for i = 1, 19, 1 do
	
end



---------------------------------------------------
-- ISync:ScanInv()
---------------------------------------------------
function ISync:ScanInv()

	local bagid, size, slotid, link;
	
	for bagid=0,NUM_BAG_FRAMES,1 do
	
		size = GetContainerNumSlots(bagid);
		
		if( size ) then
			for slotid = size, 1, -1 do
				link = GetContainerItemLink(bagid, slotid);
				if( link ) then ISync:ProcessLinks(link, nil, nil, nil); end
			end
		end
	end
	
end


---------------------------------------------------
-- ISync:ScanBank()
---------------------------------------------------
function ISync:ScanBank()

	local bagid, size, slotid, link;
	
	--Bank Container
	size = GetContainerNumSlots(BANK_CONTAINER);
	for slotid = size, 1, -1 do
		link = GetContainerItemLink(BANK_CONTAINER, slotid);
		if( link ) then ISync:ProcessLinks(link, nil, nil, nil); end
	end
	
	--Bank Bag Containers
	for bagid= NUM_BAG_SLOTS + 1, (NUM_BAG_SLOTS + NUM_BANKBAGSLOTS), 1 do
	
		size = GetContainerNumSlots(bagid);
		if( size ) then
			for slotid = size, 1, -1 do
				link = GetContainerItemLink(bagid, slotid);
				if( link ) then ISync:ProcessLinks(link, nil, nil, nil); end
			end
		end
	end
	
end


---------------------------------------------------
-- ISync:ScanAuction()
---------------------------------------------------
function ISync:ScanAuction()
	local numBatchAuctions, totalAuctions = GetNumAuctionItems("list");
	local auctionid;
	local link;

	if( numBatchAuctions > 0 ) then
		for auctionid = 1, numBatchAuctions do
			link = GetAuctionItemLink("list", auctionid);
			if( link ) then ISync:ProcessLinks(link, nil, nil, nil); end
		end
	end
	
end




---------------------------------------------------
-- ISync:VendorScan()
---------------------------------------------------
function ISync:VendorScan()

	--only do if merchant window is opened
	if(not MerchantFrame:IsVisible()) then return nil; end
	
	local numMerchantItems = GetMerchantNumItems();
	local name, texture, price, quantity, numAvailable, isUsable;
	
	for i=1, MERCHANT_ITEMS_PER_PAGE, 1 do
		local index = (((MerchantFrame.page - 1) * MERCHANT_ITEMS_PER_PAGE) + i);

		if ( index <= numMerchantItems ) then
			name, texture, price, quantity, numAvailable, isUsable = GetMerchantItemInfo(index);
		
			--get the link for the item
			local link = GetMerchantItemLink(index)
			
			--if there is a link, quantity, and a price then set it to be stored with
			--vendor price and information
			if (link and quantity and price) then
				
				ISync:ProcessLinks(link, nil , price, quantity);
				
			--for some reason there isn't any so lets just add it anyways
			elseif (link) then
			
				ISync:ProcessLinks(link, nil, nil, nil);
			end
		
		end--if ( index <= numMerchantItems ) then
		
	end--for i=1, MERCHANT_ITEMS_PER_PAGE, 1 do
	
end





---------------------------------------------------
-- ISync:MerchantMoneyScan()
---------------------------------------------------
function ISync:MerchantMoneyScan(frame)

	local costOfItem;

	GameTooltip:Hide();

	for bag=0,NUM_BAG_FRAMES do
		for slot=1,GetContainerNumSlots(bag) do

		    local link = GetContainerItemLink(bag, slot);

			if (link and link ~= "") then

				--get the name of the link
				local sID = ISync:GetCoreID(link);

				if(sID) then

					--reset
					ISYNC_ITEMCOST = 0;
					costOfItem = 0;

					--we had to change it to gametooltip because that is what is processing the money
					GameTooltip:SetBagItem(bag, slot); --set the bag slot to grab tooltip

					--hide again
					GameTooltip:Hide();

					local texture, itemCount, locked, quality, readable = GetContainerItemInfo(bag, slot);
					
					if( itemCount and itemCount > 0 and tonumber(ISYNC_ITEMCOST)) then --anything divided by 1 is itself
						costOfItem = floor(ISYNC_ITEMCOST / itemCount);
					end


					if(costOfItem and costOfItem ~= 0 and tonumber(costOfItem)) then

						ISync:SetDB(sID, "price", costOfItem);

					elseif(tonumber(costOfItem) and costOfItem < 1) then

						--it equals zero so lets put n for the nosellprice to show
						ISync:SetDB(sID, "price", -1);
					end

				end--if(sName) then

			end--if (link and link ~= "") then

		end--for slot=1,GetContainerNumSlots(bag) do
		
	end--for bag=0,NUM_BAG_FRAMES do
	
end


-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------


---------------------------------------------------
-- ISync:FetchDB()
---------------------------------------------------
function ISync:FetchDB(sID, SDelimiter, sCompare)

	if(not sID or not SDelimiter) then return nil; end
	if(not ISyncDB) then return nil; end
	if(not ISyncDB[ISYNC_REALM_NUM]) then return nil; end
	if(not ISyncDB[ISYNC_REALM_NUM][sID]) then return nil; end
	if(ISYNC_LOADYES == 0) then return nil; end
	if(not tonumber(sID)) then return nil; end --only allow numbers to store

	sID = tonumber(sID); --convert to number
	
	if(SDelimiter == "chk") then return 1; end
	
	--set the delimiters
	if(SDelimiter == "quality") then SDelimiter = 1;
	elseif(SDelimiter == "price") then SDelimiter = 2;
	elseif(SDelimiter == "wl") then SDelimiter = 3;
	elseif(SDelimiter == "wt") then SDelimiter = 4;
	elseif(SDelimiter == "ts") then SDelimiter = 5;
	elseif(SDelimiter == "at") then SDelimiter = 6;
	elseif(SDelimiter == "st") then SDelimiter = 7;
	elseif(SDelimiter == "level") then SDelimiter = 8;
	elseif(SDelimiter == "vendor") then SDelimiter = 9;
	elseif(SDelimiter == "vendorqty") then SDelimiter = 10;
	elseif(SDelimiter == "idchk") then SDelimiter = 11;
	elseif(SDelimiter == "subitem") then SDelimiter = 12;
	else return nil; end
	
	local sArray = ISync:SplitData(ISyncDB[ISYNC_REALM_NUM][sID], "�");
	
	--convert to strings
	if(sCompare and type(sCompare) ~= "string") then sCompare = tostring(sCompare); end

	--do loop
	for i = 1, ISYNC_DB_MAX do
	
		--check
		if(i == SDelimiter) then
		
			--make sure we have something to return and that its
			--not the subitems array
			if(sArray and sArray[i] and i ~= 12) then --12 = subitems
			
				--we have something now check to see if we want to compare
				if(sCompare) then
					
					--check compare
					if(sArray[i] == sCompare) then 
						return sArray[i];
					else
						return nil;
					end
				
				--we don't want to compare so just send regular
				else
					return sArray[i];
				end
			
				--there was an error
				return nil;
			
			--it is the subitems they want
			elseif(sArray and sArray[i] and i == 12) then --12 = subitems
			
				--check if we have an empty
				if(sArray[i] == "0" or tonumber(sArray[i]) and tonumber(sArray[i]) == 0) then
					return nil;
				end
				
				local yArray = ISync:SplitData(sArray[12], "�"); --12 = subitems
				
				--check if we are comparing
				if(sCompare) then
				
					--loop
					for sKey, sVar in yArray do
						if(sVar == sCompare) then return sVar; end
					end
					
					--there was an error
					return nil;
		
				else
					if(not yArray) then return nil; else return yArray; end
				end
			
				--there was an error
				return nil;
				
			--something went wrong
			else
				return nil;
				
			end--if(sArray and sArray[i] and i ~= 12)
			

			break; --break out of for loop
			
		
		end--if(i == SDelimiter) then

	end--for i = 1, ISYNC_DB_MAX do
	

	--return empty space
	return nil;
end


---------------------------------------------------
-- ISync:SetDB()
---------------------------------------------------
function ISync:SetDB(sID, SDelimiter, sValue, sOpt)

	if(not sID or not SDelimiter or not sValue) then return nil; end
	if(not ISyncDB) then return nil; end
	if(not ISyncDB[ISYNC_REALM_NUM]) then return nil; end
	if(ISYNC_LOADYES == 0) then return nil; end
	if(not tonumber(sID)) then return nil; end --only allow numbers to store

	sID = tonumber(sID); --convert to number
	
	
	--check for repeating to add to db, this causes lag
	---------------------------------------------
	local sSdx = "";
	
		if(sID) then
			sSdx = sSdx..tostring(sID);
		end
		if(SDelimiter) then
			sSdx = sSdx..tostring(SDelimiter);
		end
		if(sValue) then
			sSdx = sSdx..tostring(sValue);
		end
		if(sOpt) then
			sSdx = sSdx..tostring(sOpt);
		end	
	
		if(sSdx == SetDB_RepeatChk) then return nil; end
		
		SetDB_RepeatChk = sSdx; --set it
	
	---------------------------------------------
	
	--check the filter
	if(SDelimiter and SDelimiter == "quality" and tonumber(sValue)) then
		if(not ISync:SetVar({"FILTERS",tonumber(sValue)}, 1, "COMPARE")) then return nil; end
	end
	

	--set the delimiters
	if(SDelimiter == "quality") then SDelimiter = 1;
	elseif(SDelimiter == "price") then SDelimiter = 2;
	elseif(SDelimiter == "wl") then SDelimiter = 3;
	elseif(SDelimiter == "wt") then SDelimiter = 4;
	elseif(SDelimiter == "ts") then SDelimiter = 5;
	elseif(SDelimiter == "at") then SDelimiter = 6;
	elseif(SDelimiter == "st") then SDelimiter = 7;
	elseif(SDelimiter == "level") then SDelimiter = 8;
	elseif(SDelimiter == "vendor") then SDelimiter = 9;
	elseif(SDelimiter == "vendorqty") then SDelimiter = 10;
	elseif(SDelimiter == "idchk") then SDelimiter = 11;
	elseif(SDelimiter == "subitem") then SDelimiter = 12;
	else return nil; end
	
	--since we use a string we must convert numerics to strings as well
	if(type(sValue) == "number") then sValue = tostring(sValue); end
	
	--create if doesn't exist
	if(not ISyncDB[ISYNC_REALM_NUM][sID]) then
		ISyncDB[ISYNC_REALM_NUM][sID] = 0;
		
		--increment
		ISync:SetVar({"OPT","ITEMCOUNT_VALID"},(tonumber(ISync:SetVar({"OPT","ITEMCOUNT_VALID"},0))+1), "TRUE");
		ISync:ItemDisplay_Update();
		--set that we require a refresh if we have a new item
		if(ISync_SortIndex) then ISync:SetVar({"REQUIRED","REFRESH"}, 1, "TRUE"); end

	end
	
	local sArray = ISync:SplitData(ISyncDB[ISYNC_REALM_NUM][sID], "�");
	local finalStr = "";
	local subItemStr;
	
	----------------------------------------------
	--before we continue lets fix the subitems if we have too
	--basically this is to remove a value from the array ;)
	if(sArray and sArray[12] and SDelimiter == 12 and sOpt and string.upper(sOpt) == "TRUE") then
	
		local yArray = ISync:SplitData(sArray[12], "�");
		
		--loop
		for sKey, sVar in yArray do
			if(not subItemStr and  sVar ~= sValue) then 
				subItemStr = sVar;
			elseif(subItemStr and  sVar ~= sValue) then 
				subItemStr = subItemStr.."�"..sVar;
			end
		end
		
		--if nothing then default
		if(not subItemStr) then subItemStr = 0; end
		
		--change the value to store it below and store back into array
		sArray[12] = subItemStr;
		sValue = subItemStr;
		

	elseif(sArray and sArray[12] and SDelimiter == 12 and sOpt and string.upper(sOpt) == "REPLACE") then
	
		--they want to replace the entire subitem string
		sArray[12] = sValue;
		
	--else just add to end
	elseif(sArray and sArray[12] and SDelimiter == 12 and not sOpt) then
		
		
		--check if we have this already in the array
		local yArray = ISync:SplitData(sArray[12], "�");
		
		--loop
		for sKey, sVar in yArray do
			if(sVar == sValue) then 
				return nil; --don't do it cause we have this # already
			end
		end
		

		--save the array for processing
		local sOld = sArray[12];
		
		--check for empty (in case were starting off)
		if(sOld == "0" or tonumber(sOld) and tonumber(sOld) == 0) then
			sValue = sValue; --update value to be stored below
			sArray[12] = sValue; --update array
		else
			sValue = sOld.."�"..sValue; --update value to be stored below
			sArray[12] = sOld.."�"..sValue; --update array
		end
		
		
		sOld = nil; --reset
		
	end
	----------------------------------------------
	
	
	--do loop
	for i = 1, ISYNC_DB_MAX do
		
		--do not add the delimiter to the end duh
		if(i ~= ISYNC_DB_MAX) then
			
			--if the delimiter matches then replace
			if(i == SDelimiter) then 
				finalStr = finalStr..sValue.."�";
			else
				--if it doesn't then check for old and add, if not then add zero
				if(sArray and sArray[i]) then
					finalStr = finalStr..sArray[i].."�";
				else
					finalStr = finalStr.."0�";
				end
			end
			
		--it does equal the last
		--don't add a delimiter at end
		else
		
			--if the delimiter matches then replace
			if(i == SDelimiter) then 
				finalStr = finalStr..sValue;
			else
				--if it doesn't then check for old and add, if not then add zero
				if(sArray and sArray[i]) then
					finalStr = finalStr..sArray[i];
				else
					finalStr = finalStr.."0";
				end
			end
			
		
		end--if(i ~= ISYNC_DB_MAX) then
		
	
	end--for i = 1, ISYNC_DB_MAX do
	
	
	--store it
	ISyncDB[ISYNC_REALM_NUM][sID] = finalStr;
	
	
	--reset
	sArray = nil;
	if(yArray) then yArray = nil; end
	
	--return value and delimiter num
	return SDelimiter, sValue;
	
end



---------------------------------------------------
-- ISync:SplitData()
---------------------------------------------------
function ISync:SplitData(sData, sDelimiter)

	--first check for data
	if(not sData) then return nil; end
	
	--now check for a delimiter
	if(not sDelimiter) then return nil; end
	
	--make sure the data is a string
	if (type(sData) ~= "string") then return nil; end
	
	
	  local list = {}
	  local pos = 1
	  if strfind("", sDelimiter, 1) then -- this would result in endless loops
	  end
	  while 1 do
	    local first, last = strfind(sData, sDelimiter, pos)
	    if first then -- found?

		--do not insert empty values
		if(strsub(sData, pos, first-1) ~= "") then

			tinsert(list, strsub(sData, pos, first-1))

		end
	      pos = last+1
	    else

		--do not insert empty values
		if(strsub(sData, pos) ~= "") then

			tinsert(list, strsub(sData, pos))

		end

	      break
	    end
	  end
	  return list
	  
end


-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

---------------------------------------------------
-- ISync:SlashCommand
---------------------------------------------------
function ISync_SlashCommand(msg)


	if (msg == nil) then 
	
		if(ISYNC_LOADYES == 1) then
		
			ISync:MainFrame_Binding();
		end
		
		return nil;
	end
	
	
	local num, offset, command, args = string.find (msg, "^(%w+)%s*(.*)$");
	

	if (command == nil) then 

		if(ISYNC_LOADYES == 1) then
		
			ISync:MainFrame_Binding();
		end
		
		return nil;

	--the user is preforming a search
	elseif (string.lower(command) == "search" and args ~= nil or args ~= "") then

		
		if(ISync.SF_Reset and ISync_TextEditBox and ISYNC_LOADYES == 1 ) then
			
			--reset first
			ISync:SF_Reset();
			
				ISync_TextEditBox:SetText(args);
				
				ISYNC_SHOWSEARCH_CHK = 1;
				
				--only show if it's hidden
				if ( not ISync_MainFrame:IsVisible() ) then 
					ISync_MainFrame:Show();
				end
				
				ISync:Main_Refresh();
				

		end
		

	--the user is preforming a search (with just s instead of search)
	elseif (string.lower(command) == "s" and args ~= nil or args ~= "") then

		
		if(ISync.SF_Reset and ISync_TextEditBox and ISYNC_LOADYES == 1 ) then
			
			--reset first
			ISync:SF_Reset();
			
				ISync_TextEditBox:SetText(args);
				
				ISYNC_SHOWSEARCH_CHK = 1;
				
				--only show if it's hidden
				if ( not ISync_MainFrame:IsVisible() ) then 
					ISync_MainFrame:Show();
				end
				
				ISync:Main_Refresh();
				
		end
		
	--the user is preforming a search
	elseif (string.lower(command) == "itemid") then

		ISync:ItemIDSearch_Binding();
		
	--the user is preforming a search
	elseif (string.lower(command) == "fav" or string.lower(command) == "favorites") then
	
		if(ISYNC_LOADYES == 1) then
		
			ISync:FavFrame_Binding();
		end
		
		
		
	--the user is reseting the windows
	elseif (string.lower(command) == "resetwindow") then	
		
		getglobal("ISync_MainFrame"):ClearAllPoints(); getglobal("ISync_MainFrame"):SetPoint("CENTER", UIParent, "CENTER", 0, 0);
		getglobal("ISync_BV_Frame"):ClearAllPoints(); getglobal("ISync_BV_Frame"):SetPoint("CENTER", UIParent, "CENTER", 0, 0);	
		getglobal("ISync_ItemIDFrame"):ClearAllPoints(); getglobal("ISync_ItemIDFrame"):SetPoint("CENTER", UIParent, "CENTER", 0, 0);
		getglobal("ISync_ID_Frame"):ClearAllPoints(); getglobal("ISync_ID_Frame"):SetPoint("CENTER", UIParent, "CENTER", 0, 0);	

		getglobal("ISync_FavFrame"):ClearAllPoints(); getglobal("ISync_FavFrame"):SetPoint("CENTER", UIParent, "CENTER", 400, 0);
		getglobal("ISync_OptionsFrame"):ClearAllPoints(); getglobal("ISync_OptionsFrame"):SetPoint("CENTER", UIParent, "CENTER", 400, 0);
		getglobal("ISync_FiltersFrame"):ClearAllPoints(); getglobal("ISync_FiltersFrame"):SetPoint("CENTER", UIParent, "CENTER", 400, 0);
		getglobal("ISync_SearchFrame"):ClearAllPoints(); getglobal("ISync_SearchFrame"):SetPoint("CENTER", UIParent, "CENTER", 400, 0);
		getglobal("ISync_HelpFrame"):ClearAllPoints(); getglobal("ISync_HelpFrame"):SetPoint("CENTER", UIParent, "CENTER", 400, 0);


	--the user is preforming a search
	elseif (string.lower(command) == "help") then
	
		if( DEFAULT_CHAT_FRAME ) then
			DEFAULT_CHAT_FRAME:AddMessage("|c00FFFF00ItemSync Ver. ["..ISYNC_VERSION.."]|r");
			DEFAULT_CHAT_FRAME:AddMessage("|c00FFFF00/itemsync, /isync, /ims, /is, /bagview, /bv, /bagv|r");
			DEFAULT_CHAT_FRAME:AddMessage("|c00FFFF00 |r");
			DEFAULT_CHAT_FRAME:AddMessage("|c00FFFF00ItemSync "..ISYNC_BT_SEARCH..":   /is search itemname, /is s itemname|r");
			DEFAULT_CHAT_FRAME:AddMessage("|c00FFFF00ItemSync "..ISYNC_BT_ITEMID..":   /is itemid|r");
			DEFAULT_CHAT_FRAME:AddMessage("|c00FFFF00ItemSync "..ISYNC_BT_FAVORITES..":   /is fav, /is favorites|r");
			DEFAULT_CHAT_FRAME:AddMessage("|c00FFFF00ItemSync "..ISYNC_SLASHRESETWINDOWS..":   /is resetwindow|r");
		end
	    
		
	else
	
		if(ISYNC_LOADYES == 1) then
		
			ISync:MainFrame_Binding();
		end
		
	end
	

end


-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

--MODDERS NEED TO UPDATE!  THESE FUNCTIONS WILL BE REMOVED IN FUTURE UPDATES OF ITEMSYNC!


--hookback functions (THESE ARE OLD AND SHOULD BE REMOVED BY MODDERS)
--ISync:SetData()
function ISync:SetData(sID, SDelimiter, sValue, sOpt)

	--users the numbered system
	if(tonumber(sID)) then
		
		return ISync:SetDB(sID, SDelimiter, sValue, sOpt);
		
	--uses old names
	else
		for index, value in ISyncDB_Names do

			if(string.lower(sID) == string.lower(sID)) then

				return ISync:SetDB(sID, SDelimiter, sValue, sOpt);
				
			end--if(string.lower(value) == string.lower(text)) then

		end
		
		
	end
	
	return nil;
end
--ISync:GetData()
function ISync:GetData(sID, SDelimiter, sOpt)


	--users the numbered system
	if(tonumber(sID)) then
		
		 return ISync:FetchDB(sID, SDelimiter, sOpt);
		
	--uses old names
	else
		for index, value in ISyncDB_Names do

			if(string.lower(sID) == string.lower(sID)) then

				return ISync:FetchDB(sID, SDelimiter, sOpt);
				
			end--if(string.lower(value) == string.lower(text)) then

		end
		
		
	end
	
	return nil;
	
end

