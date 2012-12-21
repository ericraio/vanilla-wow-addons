--[[---------------------------------------------------------------------------------
  AH Favorites
  Saves searches from the AH in a favorites list
  
  $Revision: 1.9 $
  $Date: 2005/10/26 11:59:43 $
------------------------------------------------------------------------------------]]

--[[
	Globals:

--]]

local DEFAULT_OPTIONS = {
	autoQuery = true,
	FSL = true,
};

-- Chat commands

AHFAV_OPTIONS = {
	{
		option = AH_FAV.AUTOQUERY,
		desc = AH_FAV.AUTOQUERY_DESC,
		method = "ToggleAutoQuery"
	},
	{
		option = AH_FAV.FSL,
		desc = AH_FAV.FSL_DESC,
		method = "ToggleFSL"
	}
};

ACE_MAP_ONOFF = {[0]="|cffff5050Off|r",[1]="|cff00ff00On|r"};

StaticPopupDialogs["AHF_SAVESEARCH"] = {
	text = AH_FAV.POPUP_TEXT,
	button1 = AH_FAV.SAVE,
	button2 = AH_FAV.CANCEL,
	hasEditBox = 1,
	maxLetters = 40,
	OnAccept = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		AHFav:SaveSearch(editBox:GetText());
		this:GetParent():Hide();
	end,
	OnShow = function()
		getglobal(this:GetName().."EditBox"):SetFocus();
		getglobal(this:GetName().."EditBox"):SetText(BrowseName:GetText());
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	EditBoxOnEnterPressed = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		AHFav:SaveSearch(editBox:GetText());
		this:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1
};

--[[
	Class Setup

--]]

    AHFav = AceAddon:new({
        name          = AH_FAV.NAME,
        description   = AH_FAV.DESCRIPTION,
        version       = "1800.2",
        releaseDate   = "10-26-2005",
        aceCompatible = "102",
        author        = "Narwick",
        email         = "narwick@somewhere.com",
        website       = "http://",
        category      = "others",
        optionsFrame  = nil,
        db            = AceDatabase:new("AHFavDB"),
        defaults      = DEFAULT_OPTIONS,
        cmd           = AceChatCmd:new(AH_FAV.COMMANDS, AHFAV_OPTIONS),
    })

    function AHFav:Initialize()
		self.GetOpt = function(var) local v=self.db:get(self.profilePath,var) return v end
		self.SetOpt = function(var,val) self.db:set(self.profilePath,var,val)	end
		self.TogOpt = function(var) return self.db:toggle(self.profilePath,var) end
		
		if (self.GetOpt("autoQuery") == nil) then
			self.SetOpt("autoQuery", DEFAULT_OPTIONS.autoQuery);
		end
		

		if (self.GetOpt("FSL") == nil) then
			self.SetOpt("FSL", DEFAULT_OPTIONS.FSL);
		end

		-- setup search accessor/setter
		self.GetSearch = function(key)
			local v=self.db:get({self.profilePath, "AHFavSearches"}, key)
			return v 
		end
		self.SetSearch = function(key, val) self.db:set({self.profilePath, "AHFavSearches"}, key, val) end;
		self.AllSearches = function() 
			local v = self.db:get(self.profilePath, "AHFavSearches");
			if (v == nill) then
				return {}
			end
			return v;
		end
		
		-- register to be notified when AH interface comes up
		self:RegisterEvent("AUCTION_HOUSE_SHOW", "Position")
		
		-- Tell the user we're initialized
		DEFAULT_CHAT_FRAME:AddMessage(AH_FAV.INITMSG, 0.8, 0.8, 0.2);
    end

	-- Enable disable simply show or hide the frame
    function AHFav:Enable()
		DEFAULT_CHAT_FRAME:AddMessage(AH_FAV.ENABLE_MSG, 0.8, 0.8, 0.2);
		AHFavs:Show();
    end

    function AHFav:Disable()
		DEFAULT_CHAT_FRAME:AddMessage(AH_FAV.DISABLE_MSG, 0.8, 0.8, 0.2);
		AHFavs:Hide();
    end

	-- Toggle AutoQuery
	function AHFav:ToggleAutoQuery()
		self.TogOpt("autoQuery");
		if (self.GetOpt("autoQuery")) then
			DEFAULT_CHAT_FRAME:AddMessage(AH_FAV.AUTOQUERY_ENABLE_MSG, 0.8, 0.8, 0.2);
		else
			DEFAULT_CHAT_FRAME:AddMessage(AH_FAV.AUTOQUERY_DISABLE_MSG, 0.8, 0.8, 0.2);
		end
	end
	
	-- Toggle FSL integration
	function AHFav:ToggleFSL()
		self.TogOpt("FSL");
		if (self.GetOpt("FSL")) then
			DEFAULT_CHAT_FRAME:AddMessage(AH_FAV.FSL_ENABLE_MSG, 0.8, 0.8, 0.2);
		else
			DEFAULT_CHAT_FRAME:AddMessage(AH_FAV.FSL_DISABLE_MSG, 0.8, 0.8, 0.2);
		end
	end

	function AHFav:GetFSL()
		if (self.GetOpt) then
			local v = self.GetOpt("FSL")
			return v
		else
			return nil
		end
	end
	
	-- Save the current search criteria
	function AHFav:SaveSearch(searchName)

		-- Gather up the fields
		local lastSearch = { 
			name = BrowseName:GetText(), 
			minLevel = BrowseMinLevel:GetText(), 
			maxLevel = BrowseMaxLevel:GetText(), 
			invTypeIndex = AuctionFrameBrowse.selectedInvtypeIndex, 
			classIndex = AuctionFrameBrowse.selectedClassIndex,
			subclassIndex = AuctionFrameBrowse.selectedSubclassIndex,
			subclass = AuctionFrameBrowse.selectedSubclass,
			isUsable = IsUsableCheckButton:GetChecked(),
			showOnPlayer = ShowOnPlayerCheckButton:GetChecked(),
			qualityIndex = UIDropDownMenu_GetSelectedValue(BrowseDropDown)
		}
		
		-- now save them
		self.SetSearch(searchName, lastSearch);
		
		-- reinitialize the popup to set the new value in the proper place
		UIDropDownMenu_Initialize(AHFavs, SearchesDropDown_Initialize);

		-- set the popup list to the newly saved entry
		
		-- This is the way to do it looking at the API, but when
		-- a pseudo dropdown is being used, an internal call
		-- to SetText in UIDropDown.lua fails because there
		-- is no currently selected label.
--		UIDropDownMenu_SetSelectedName(AHFavs, searchName);

		-- Instead, set the internal vars directly.  This may blow up at
		-- some point in the future, but oh well.
		AHFavs.selectedName = searchName;
		AHFavs.selectedID = nil;
		AHFavs.selectedValue = nil;

	end
	
	function AHFav:LoadSearch(searchName, clear)

		-- initialze for a blank search
		local lastSearch = { 
			name = "",
			minLevel = "",
			maxLevel = "",
			qualityIndex = -1,
		};
		
		-- Get the selected search		
		if (not clear) then 
			lastSearch = self.GetSearch(searchName);
		end
				
		-- Load the fields
		BrowseName:SetText(lastSearch["name"]);
		BrowseMinLevel:SetText(lastSearch["minLevel"]);
		BrowseMaxLevel:SetText(lastSearch["maxLevel"]);
		AuctionFrameBrowse.selectedInvtypeIndex = lastSearch["invTypeIndex"];
		AuctionFrameBrowse.selectedClassIndex = lastSearch["classIndex"];
		AuctionFrameBrowse.selectedClass = CLASS_FILTERS[lastSearch["classIndex"]];
		AuctionFrameBrowse.selectedSubclassIndex = lastSearch["subclassIndex"];
		AuctionFrameBrowse.selectedSubclass = lastSearch["subclass"];
		IsUsableCheckButton:SetChecked(lastSearch["isUsable"]);
		ShowOnPlayerCheckButton:SetChecked(lastSearch["showOnPlayer"]);
		UIDropDownMenu_SetSelectedValue(BrowseDropDown, lastSearch["qualityIndex"]);
		
		-- Tell the filters to update
		AuctionFrameFilters_Update();
		
		-- Tell the rarity pulldown to update
		UIDropDownMenu_Refresh(BrowseDropDown, false);
		
		-- Update the popup to the current search, or clear it
		if (not clear) then
			-- See notes in SaveSearch
--			UIDropDownMenu_SetSelectedName(AHFavs, searchName);
			AHFavs.selectedName = searchName;
			AHFavs.selectedID = nil;
			AHFavs.selectedValue = nil;
		else
			-- See notes in SaveSearch
--			UIDropDownMenu_ClearAll(AHFavs);
			AHFavs.selectedName = nil;
			AHFavs.selectedID = nil;
			AHFavs.selectedValue = nil;
		end
		
		-- auto run the loaded search
		if ((not clear) and self.GetOpt("autoQuery") and CanSendAuctionQuery()) then
			AuctionFrameBrowse_Search()
		end
		
	end
	
	function AHFav:DeleteSearch(searchName)
	
		-- check if nothing is selected, return if so
		if (searchName == nil) then
			return
		end
		
		-- Remove the search
		self.SetSearch(searchName, nil);
		
		-- Clear the previously selected search
		-- See notes in SaveSearch
--		UIDropDownMenu_ClearAll(AHFavs);
		AHFavs.selectedName = nil;
		AHFavs.selectedID = nil;
		AHFavs.selectedValue = nil;
	end

	
	-- Ace report
	function AHFav:Report()
		self.cmd:report({
			{text=AH_FAV.AUTOQUERY, val=self.GetOpt("autoQuery"), map=ACE_MAP_ONOFF},
			{text=AH_FAV.FSL_NAME, val=self.GetOpt("FSL"), map=ACE_MAP_ONOFF},
		})
	end
	
	-- GUI Functions
	
	function AHFav:SearchesDropDown_OnLoad()
		UIDropDownMenu_Initialize(this:GetParent(), SearchesDropDown_Initialize);
		UIDropDownMenu_SetAnchor(-124, 0, this:GetParent(), "TOPLEFT", this:GetName(), "BOTTOMRIGHT")
	end
	
	function SearchesDropDown_Initialize()
	
		-- Skip everything if AHFav object hasn't loaded yet
		if (not AHFav) then
			return
		end
		
		local info = {};
		local searches = {};

		-- Add a title item
		local favoritesTitle = {};
		favoritesTitle.text = AH_FAV.FAVORITES;
		favoritesTitle.notClickable = true;
		favoritesTitle.notCheckable = true;
		
		UIDropDownMenu_AddButton(favoritesTitle);
		
		-- Add all the saved searches
		if (AHFav.AllSearches) then
			searches = AHFav:AllSearches();
		end
						
		for i,v in pairsByKeys(searches) do
			info.text = i;
			local staticText = i;
			info.func = function () AHFav:LoadSearch(staticText); end;
			info.checked = false;
			UIDropDownMenu_AddButton(info);
		end
		
		-- Separator
		local separator = {};
		separator.text = "--------";
		separator.notClickable = true;
		separator.notCheckable = true;
		
		UIDropDownMenu_AddButton(separator);
		
		-- Save Button
		info.text = AH_FAV.SAVE;
		info.func = function () StaticPopup_Show("AHF_SAVESEARCH"); end;
		info.notCheckable = true;
		info.checked = false;

		UIDropDownMenu_AddButton(info);
		
		-- Delete Button
		info.text = AH_FAV.DELETE;
		info.func = function ()
			currentSearch = UIDropDownMenu_GetSelectedName(AHFavs);
			AHFav:DeleteSearch(currentSearch); 
		end;
		info.notCheckable = true;
		info.checked = false;
		
		UIDropDownMenu_AddButton(info);

		-- Clear Button
		info.text = AH_FAV.CLEAR;
		info.func = function ()
			AHFav:LoadSearch(nil, true); 
		end;
		info.notCheckable = true;
		info.checked = false;
		
		UIDropDownMenu_AddButton(info);
		
		-- Add ShoppingList if enabled
		
		if (AHFav:GetFSL()) then
			-- check if FSL is enabled
			if (FSL_Config and FSL_Config.Enabled) then
			
				-- Add a separator
				UIDropDownMenu_AddButton(separator);
			
				-- Add ShoppingList Header
				local SLseparator = {};
				SLseparator.text = AH_FAV.FSL_SHORT;
				SLseparator.notClickable = true;
				SLseparator.notCheckable = true;
				
				UIDropDownMenu_AddButton(SLseparator);
				
				-- Get the ShoppingList
				local realm = GetCVar("realmName");
				local realmList = FSL_ShoppingList[realm];

				if realmList == nil then return; end

				-- Loop through and add items
				for _, itemLink in realmList do
					-- Get the name
					local name = GetItemInfo(itemLink);
					local staticItemLink = itemLink;

					info.value = itemLink
					info.func = function () AHFav:LoadSLSearch(staticItemLink) end
					info.checked = false
					info.notCheckable = false

					-- Totally lame that GetItemInfo doesn't return if not in local cache
					-- do this hack to get the name in that case
					-- technique stolen from LootLink
					if (not name) then
						for litem, lname in string.gfind(itemLink, "|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h") do
							info.text = lname
						end
					else
						info.text = name
					end
					UIDropDownMenu_AddButton(info);
				end
			end
		end

	end
	
	function AHFav:LoadSLSearch(itemLink)

		local name = GetItemInfo(itemLink);
		
		if (not name) then
			for litem, lname in string.gfind(itemLink, "|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h") do
				name = lname
			end		
		end
		
		-- Load the fields
		BrowseName:SetText(name);
		BrowseMinLevel:SetText("");
		BrowseMaxLevel:SetText("");
		AuctionFrameBrowse.selectedInvtypeIndex = nil;
		AuctionFrameBrowse.selectedClassIndex = nil;
		AuctionFrameBrowse.selectedClass = nil;
		AuctionFrameBrowse.selectedSubclassIndex = nil;
		AuctionFrameBrowse.selectedSubclass = nil;
		IsUsableCheckButton:SetChecked(nil);
		UIDropDownMenu_SetSelectedValue(BrowseDropDown, nil);
		
		-- Tell the filters to update
		AuctionFrameFilters_Update();
		
		-- Update the popup to the current search, or clear it
		-- See notes in SaveSearch
--		UIDropDownMenu_SetSelectedName(AHFavs, name);
		
		AHFavs.selectedName = name;
		AHFavs.selectedID = nil;
		AHFavs.selectedValue = nil;
		
		-- auto run the loaded search
		if (self.GetOpt("autoQuery") and CanSendAuctionQuery()) then
			AuctionFrameBrowse_Search()
		end

	end
	
	-- repositions AHFav dropdown with dynamic loaded AH interface
	function AHFav:Position()
		AHFavs:ClearAllPoints()
		AHFavs:SetParent("AuctionFrameBrowse")
		AHFavs:SetFrameStrata("HIGH")
		AHFavs:SetPoint("TOPLEFT", "AuctionFrameBrowse", "TOPLEFT", 195, -45)
		AHFavsButton:Show()
		AHFavs:Show()
	end
	
	-- Utility function to sort searches
	-- Lifted from LUA book online
	function pairsByKeys (t, f)
		local a = {}
		for n in pairs(t) do table.insert(a, n) end
		table.sort(a, f)
		local i = 0      -- iterator variable
		local iter = function ()   -- iterator function
			i = i + 1
			if a[i] == nil then return nil
			else return a[i], t[a[i]]
			end
		end
		return iter
    end

--[[
	register the class

--]]

    AHFav:RegisterForLoad()

