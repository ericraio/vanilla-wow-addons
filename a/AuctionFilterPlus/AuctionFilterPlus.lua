--[[
		ADDON  INFORMATION
		Name: AuctionFilterPlus
		Purpose: Adds flyout filters and a reset button to the auction house.
		Command-line: NONE
		Author: Dsanai of The Crimson Knights on Whisperwind

Thank you to the authors of AuctionFilterRL (Joshaze), AH_Reset (AnduinLothar), and AH_Wipe (Neriak), as these mods formed the base for this extension.

I've added a few more filters that I always wished I'd had when shopping (such as only-20-piece stacks, and exact search), changed it to a low-clutter Flyout display, added the ability to clear and save one's filter settings,  merged the two mods into one, and added tooltips so users have more information about what each filter does.

FEATURES
-- Adds a Filter button and a Reset button to the AuctionHouse frame.
-- Pressing the Filter button will cause a Flyout menu to appear.
-- The filter checkboxes on the flyout allow you to limit your AH results or change the display of certain information.
-- You can clear your filter settings with a single click.
-- You can clear your Auction House search boxes with a single click.
-- You can save your filter settings as your default setup, which will persist across sessions, characters, and servers.
-- You can clear your settings temporarily and then reload them without relogging.
-- Each of the filter checkboxes has an explanatory tooltip.
-- Ready for localization (please help do so, if you are German- or French-speaking). You will be credited!
-- Compatible with Auctioneer.

NOT DONE YET
-- Fixed Dressing Room bug. Should now show the correct item even if filters are turned on.
-- Fixed Chat Link bug. Should now link the correct item in chat.

VERSION HISTORY

v10900-1
-- Fixed slash command (courtesy Aingnale@WorldOfWar)
-- Added "Grey Out Unbid Items" option. Will grey out the prices for items that have not been bid on yet. (idea courtesy myShowBid by mhsin)
-- Show Best Deals now takes into account Greater Essences (will be valued as 3 items when competing against Lesser Essences)
-- Fixed so that Auctioneer Beta will also be supported (variable name courtesy barryj@Curse)

v1800-6
-- Added AuctionSort functionality (courtesy Abraha)
-- Added Show Best Deals, which will evaluate prices and tell you how an item fares against the average for the search results.
-- Show Best Deals will also take into account how many pieces of cloth were used to create bolts of cloth, when rating its value.

v1800-5
-- DE translation reworked (courtesy dan2507@Curse)
-- Increased the width of the flyout panel, and of the Clear button, so localized strings should fit.
-- Can be set to color known recipes, plans, schematics, etc. (courtesy LeisureLarry@Curse)
-- Added command-line to open flyout panel, if the button is unclickable due to other mods.

v1800-4
-- Really disables itself when KC_Items is scanning. Thanks, Sharky@Curse.
-- Globalized the "Already Known" string, so all clients should now be able to use that filter. Thanks, Olivier@Curse.

v1800-3
-- Disables itself when KC_Items is scanning.
-- German localization completed (courtesy Dan2507 and Naboradd)
-- Localized checkbox description text.
-- Attempt to fix the occasional tooltip error on line 492. Let me know if tooltips show the wrong item.

v1800-2
-- Disables itself when Auctioneer is scanning.

v1800-1
-- Initial release

POTENTIAL FUTURE ADDITIONS (Subject to change)
-- Filter: Don't show auctions listed by people I've Ignored. (Don't fund the idiots.)
-- Filter: Only show items that haven't been bid on yet. (Try to find ones I can snag at a bargain, without a bidding war.)
-- Filter: Only show XX quality items. (Blizzard quality filter shows that level AND higher.) NOTE: Read Blizzard dropdown.

]]

afp_OriginalAuctionFrameBrowse_Update = nil;
afp_BrowseList = {};
local afp_OldSetWidth = nil;

function AuctionFilterPlus_OnLoad()
	this:RegisterEvent("AUCTION_ITEM_LIST_UPDATE");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("AUCTION_HOUSE_SHOW");
	-- Set localization for buttons (NOW DONE INTERNALLY)
	-- if (afp_FlyoutButton) then afp_FlyoutButton:SetText(AFP_BUTTON_TEXT_FILTER); end
	SlashCmdList["AUCTIONFILTERPLUS"] = afp_SlashHandler;
	SLASH_AUCTIONFILTERPLUS1 = "/auctionfilterplus"; -- Fixed by Aingnale@WorldOfWar
	SLASH_AUCTIONFILTERPLUS2 = "/afp";
end

function AuctionFilterPlus_OnEvent()

	if (event == "AUCTION_ITEM_LIST_UPDATE") then
		afp_AuctionFrameBrowse_Update();
		
	elseif event == "VARIABLES_LOADED" then
		afp_FlyoutLoad_OnClick();

	elseif (event == "AUCTION_HOUSE_SHOW" and IsAddOnLoaded("Blizzard_AuctionUI")) then
		if (not afp_OriginalAuctionFrameBrowse_Update) then
			afp_OriginalAuctionFrameBrowse_Update = AuctionFrameBrowse_Update;
			AuctionFrameBrowse_Update = afp_AuctionFrameBrowse_Update;

			afp_OriginalBrowseButton_OnClick = BrowseButton_OnClick;
			BrowseButton_OnClick = afp_BrowseButton_OnClick;
	
			afp_OriginalAuctionFrameItem_OnEnter = AuctionFrameItem_OnEnter;
			AuctionFrameItem_OnEnter = afp_AuctionFrameItem_OnEnter;

			afp_OptionButton_PricePerUnit:SetParent(afp_FlyoutFrame);
			afp_OptionButton_HideNoBuyout:SetParent(afp_FlyoutFrame);
			afp_OptionButton_HideUnaffordable:SetParent(afp_FlyoutFrame);
			afp_OptionButton_HideKnown:SetParent(afp_FlyoutFrame);
			afp_OptionButton_StacksOf20:SetParent(afp_FlyoutFrame);
			afp_OptionButton_StacksOf10:SetParent(afp_FlyoutFrame);
			afp_OptionButton_StacksOf5:SetParent(afp_FlyoutFrame);
			afp_OptionButton_ExactName:SetParent(afp_FlyoutFrame);
			afp_OptionButton_ColorKnown:SetParent(afp_FlyoutFrame);
			afp_OptionButton_ShowBestDeals:SetParent(afp_FlyoutFrame);
			afp_OptionButton_GreyUnbid:SetParent(afp_FlyoutFrame);
			
			afp_FlyoutButton:ClearAllPoints()
			afp_FlyoutButton:SetParent(AuctionFrameBrowse);
			afp_FlyoutButton:SetPoint("TOPRIGHT","AuctionFrameBrowse","TOPRIGHT",-13,-14);
			afp_FlyoutButton:Show();
			
			if (AH_ResetButton and AH_ResetButton:IsVisible()) then
				AH_ResetButton:Hide();
			end
			afp_ResetButton:ClearAllPoints()
			afp_ResetButton:SetParent(afp_FlyoutButton);
			afp_ResetButton:SetPoint("LEFT","afp_FlyoutButton","RIGHT",-1,0);
			afp_ResetButton:Show();
		end
		
		-- AuctionSort
		if (not afp_OldSetWidth and BrowseCurrentBidSort) then
			BrowseBuyoutSort:ClearAllPoints();
			BrowseBuyoutSort:SetParent(AuctionFrameBrowse);
			BrowseBuyoutSort:SetPoint("LEFT","BrowseCurrentBidSort","RIGHT",-2,0);
			BrowseBuyoutSort:Show();

			BrowseNameSort:ClearAllPoints();
			BrowseNameSort:SetParent(AuctionFrameBrowse);
			BrowseNameSort:SetPoint("TOPLEFT", "AuctionFrameBrowse", "TOPLEFT", 186, -82);
			BrowseNameSort:Show();

			BrowseQualitySort:ClearAllPoints();
			BrowseQualitySort:SetPoint("LEFT","BrowseNameSort","RIGHT",-2,0);
			BrowseQualitySort:Show();

			afp_OldSetWidth = BrowseCurrentBidSort.SetWidth;

			BrowseCurrentBidSort.SetWidth = afp_SetWidth;
			BrowseCurrentBidSort:SetWidth(207);
			BrowseQualitySort:SetWidth(BrowseQualitySort:GetWidth() - BrowseNameSort:GetWidth());
    end
	end
	
end

function afp_SetWidth(obj, width)
  if (width >= 184) then
    width = width - BrowseBuyoutSort:GetWidth() + 2;
  end
  afp_OldSetWidth(obj, width);
end

function SortBuyoutButton_UpdateArrow(button, type, sort)
	if ( not IsAuctionSortReversed(type, sort) ) then
		getglobal(button:GetName().."Arrow"):SetTexCoord(0, 0.5625, 1.0, 0);
	else
		getglobal(button:GetName().."Arrow"):SetTexCoord(0, 0.5625, 0, 1.0);
	end
end

function afp_FixParents()
	afp_OptionText_HideUnaffordable:ClearAllPoints()
	afp_OptionText_HideKnown:ClearAllPoints()
	afp_OptionText_HideNoBuyout:ClearAllPoints()
	afp_OptionText_PricePerUnit:ClearAllPoints()
	afp_OptionText_StacksOf20:ClearAllPoints()
	afp_OptionText_StacksOf10:ClearAllPoints()
	afp_OptionText_StacksOf5:ClearAllPoints()
	afp_OptionText_ExactName:ClearAllPoints()
	afp_OptionText_ColorKnown:ClearAllPoints()
	afp_OptionText_ShowBestDeals:ClearAllPoints()
	afp_OptionText_GreyUnbid:ClearAllPoints()

	afp_OptionText_HideUnaffordable:SetPoint("LEFT","afp_OptionButton_HideUnaffordable","RIGHT",2,1);
	afp_OptionText_HideKnown:SetPoint("LEFT","afp_OptionButton_HideKnown","RIGHT",2,1);
	afp_OptionText_HideNoBuyout:SetPoint("LEFT","afp_OptionButton_HideNoBuyout","RIGHT",2,1);
	afp_OptionText_PricePerUnit:SetPoint("LEFT","afp_OptionButton_PricePerUnit","RIGHT",2,1);
	afp_OptionText_StacksOf20:SetPoint("LEFT","afp_OptionButton_StacksOf20","RIGHT",2,1);
	afp_OptionText_StacksOf10:SetPoint("LEFT","afp_OptionButton_StacksOf10","RIGHT",2,1);
	afp_OptionText_StacksOf5:SetPoint("LEFT","afp_OptionButton_StacksOf5","RIGHT",2,1);
	afp_OptionText_ExactName:SetPoint("LEFT","afp_OptionButton_ExactName","RIGHT",2,1);
	afp_OptionText_ColorKnown:SetPoint("LEFT","afp_OptionButton_ColorKnown","RIGHT",2,1);
	afp_OptionText_ShowBestDeals:SetPoint("LEFT","afp_OptionButton_ShowBestDeals","RIGHT",2,1);
	afp_OptionText_GreyUnbid:SetPoint("LEFT","afp_OptionButton_GreyUnbid","RIGHT",2,1);
end

function afp_Tooltip(arg1,arg2,arg3,arg4,arg5,arg6)
	if (not arg3) then arg3 = "ANCHOR_LEFT"; end
	if (not arg4) then arg4 = 0; end
	if (not arg5) then arg5 = -40; end
	if (not arg6) then arg6 = afp_FlyoutFrame; end -- can use the reserved word "this" as arg6 if you want
	GameTooltip:SetOwner(arg6, arg3, arg4, arg5);
  GameTooltip:SetText(arg1);
  GameTooltip:AddLine("\n"..arg2, .75, .75, .75, 1);
  GameTooltip:Show();
end

function afp_AuctionFrameBrowse_OnEnter()
	local frame = this:GetName();
	if (not frame) then return; end
	if (frame == "afp_OptionButton_HideUnaffordable") then
		afp_Tooltip(AFP_TOOLTIP_TITLE_UNAFFORD, AFP_TOOLTIP_TEXT_UNAFFORD);
	elseif (frame == "afp_OptionButton_HideKnown") then
		afp_Tooltip(AFP_TOOLTIP_TITLE_HIDEKNOWN, AFP_TOOLTIP_TEXT_HIDEKNOWN);
	elseif (frame == "afp_OptionButton_HideNoBuyout") then
		afp_Tooltip(AFP_TOOLTIP_TITLE_NOBUYOUT, AFP_TOOLTIP_TEXT_NOBUYOUT);
	elseif (frame == "afp_OptionButton_PricePerUnit") then
		afp_Tooltip(AFP_TOOLTIP_TITLE_PERUNIT, AFP_TOOLTIP_TEXT_PERUNIT);
	elseif (frame == "afp_OptionButton_StacksOf20") then
		afp_Tooltip(AFP_TOOLTIP_TITLE_STACK20, AFP_TOOLTIP_TEXT_STACK20);
	elseif (frame == "afp_OptionButton_StacksOf10") then
		afp_Tooltip(AFP_TOOLTIP_TITLE_STACK10, AFP_TOOLTIP_TEXT_STACK10);
	elseif (frame == "afp_OptionButton_StacksOf5") then
		afp_Tooltip(AFP_TOOLTIP_TITLE_STACK5, AFP_TOOLTIP_TEXT_STACK5);
	elseif (frame == "afp_OptionButton_ExactName") then
		afp_Tooltip(AFP_TOOLTIP_TITLE_EXACTNAME, AFP_TOOLTIP_TEXT_EXACTNAME);
	elseif (frame == "afp_OptionButton_ColorKnown") then
		afp_Tooltip(AFP_TOOLTIP_TITLE_COLORKNOWN, AFP_TOOLTIP_TEXT_COLORKNOWN);
	elseif (frame == "afp_OptionButton_ShowBestDeals") then
		afp_Tooltip(AFP_TOOLTIP_TITLE_SHOWBESTDEALS, AFP_TOOLTIP_TEXT_SHOWBESTDEALS);
	elseif (frame == "afp_OptionButton_GreyUnbid") then
		afp_Tooltip(AFP_TOOLTIP_TITLE_GREYUNBID, AFP_TOOLTIP_TEXT_GREYUNBID);
	end
end

function afp_Reset_OnClick()
		PlaySound("igMainMenuOptionCheckBoxOn")
		IsUsableCheckButton:SetChecked()
		UIDropDownMenu_SetSelectedValue(BrowseDropDown, -1)
		AuctionFrameBrowse.selectedClass = nil
		AuctionFrameBrowse.selectedClassIndex = nil
		AuctionFrameFilters_Update()
		BrowseName:SetText("")
		--BrowseName:SetFocus()
		BrowseMinLevel:SetText("")
		BrowseMaxLevel:SetText("")
		AuctionDressUpModel:Dress()
		if (false) then
			ShowOnPlayerCheckButton:SetChecked()
			SHOW_ON_CHAR = "0"
			HideUIPanel(AuctionDressUpFrame)
		end
		afp_Print(AFP_OPTEXT_RESET);
end

function afp_FlyoutClear_OnClick()
	afp_OptionButton_PricePerUnit:SetChecked(0);
	afp_OptionButton_HideNoBuyout:SetChecked(0);
	afp_OptionButton_HideUnaffordable:SetChecked(0);
	afp_OptionButton_HideKnown:SetChecked(0);
	afp_OptionButton_StacksOf20:SetChecked(0);
	afp_OptionButton_StacksOf10:SetChecked(0);
	afp_OptionButton_StacksOf5:SetChecked(0);
	afp_OptionButton_ExactName:SetChecked(0);
	afp_OptionButton_ColorKnown:SetChecked(0);
	afp_OptionButton_ShowBestDeals:SetChecked(0);
	afp_OptionButton_GreyUnbid:SetChecked(0);
	afp_Print(AFP_OPTEXT_CLEARED);
end

function afp_FlyoutSave_OnClick()
	afp_SavedSettings = {};
	afp_SavedSettings["afp_OptionButton_PricePerUnit"] = afp_OptionButton_PricePerUnit:GetChecked();
	afp_SavedSettings["afp_OptionButton_HideNoBuyout"] = afp_OptionButton_HideNoBuyout:GetChecked();
	afp_SavedSettings["afp_OptionButton_HideUnaffordable"] = afp_OptionButton_HideUnaffordable:GetChecked();
	afp_SavedSettings["afp_OptionButton_HideKnown"] = afp_OptionButton_HideKnown:GetChecked();
	afp_SavedSettings["afp_OptionButton_StacksOf20"] = afp_OptionButton_StacksOf20:GetChecked();
	afp_SavedSettings["afp_OptionButton_StacksOf10"] = afp_OptionButton_StacksOf10:GetChecked();
	afp_SavedSettings["afp_OptionButton_StacksOf5"] = afp_OptionButton_StacksOf5:GetChecked();
	afp_SavedSettings["afp_OptionButton_ExactName"] = afp_OptionButton_ExactName:GetChecked();
	afp_SavedSettings["afp_OptionButton_ColorKnown"] = afp_OptionButton_ColorKnown:GetChecked();
	afp_SavedSettings["afp_OptionButton_ShowBestDeals"] = afp_OptionButton_ShowBestDeals:GetChecked();
	afp_SavedSettings["afp_OptionButton_GreyUnbid"] = afp_OptionButton_GreyUnbid:GetChecked();
	afp_Print(AFP_OPTEXT_SAVED);
end

function afp_FlyoutLoad_OnClick()
		if (afp_SavedSettings) then
			if (afp_SavedSettings["afp_OptionButton_PricePerUnit"]) then
				afp_OptionButton_PricePerUnit:SetChecked(afp_SavedSettings["afp_OptionButton_PricePerUnit"]);
			end
			if (afp_SavedSettings["afp_OptionButton_HideNoBuyout"]) then
				afp_OptionButton_HideNoBuyout:SetChecked(afp_SavedSettings["afp_OptionButton_HideNoBuyout"]);
			end
			if (afp_SavedSettings["afp_OptionButton_HideUnaffordable"]) then
				afp_OptionButton_HideUnaffordable:SetChecked(afp_SavedSettings["afp_OptionButton_HideUnaffordable"]);
			end
			if (afp_SavedSettings["afp_OptionButton_HideKnown"]) then
				afp_OptionButton_HideKnown:SetChecked(afp_SavedSettings["afp_OptionButton_HideKnown"]);
			end
			if (afp_SavedSettings["afp_OptionButton_StacksOf20"]) then
				afp_OptionButton_StacksOf20:SetChecked(afp_SavedSettings["afp_OptionButton_StacksOf20"]);
			end
			if (afp_SavedSettings["afp_OptionButton_StacksOf10"]) then
				afp_OptionButton_StacksOf10:SetChecked(afp_SavedSettings["afp_OptionButton_StacksOf10"]);
			end
			if (afp_SavedSettings["afp_OptionButton_StacksOf5"]) then
				afp_OptionButton_StacksOf5:SetChecked(afp_SavedSettings["afp_OptionButton_StacksOf5"]);
			end
			if (afp_SavedSettings["afp_OptionButton_ExactName"]) then
				afp_OptionButton_ExactName:SetChecked(afp_SavedSettings["afp_OptionButton_ExactName"]);
			end
			if (afp_SavedSettings["afp_OptionButton_ColorKnown"]) then
				afp_OptionButton_ColorKnown:SetChecked(afp_SavedSettings["afp_OptionButton_ColorKnown"]);
			end
			if (afp_SavedSettings["afp_OptionButton_ShowBestDeals"]) then
				afp_OptionButton_ShowBestDeals:SetChecked(afp_SavedSettings["afp_OptionButton_ShowBestDeals"]);
			end
			if (afp_SavedSettings["afp_OptionButton_GreyUnbid"]) then
				afp_OptionButton_GreyUnbid:SetChecked(afp_SavedSettings["afp_OptionButton_GreyUnbid"]);
			end
		end
end

function afp_AuctionFrameBrowse_Update()

	-- Trap for, and prevent, filters from doing anything while Auctioneer is scanning.
	if ((Auctioneer_isScanningRequested and Auctioneer_isScanningRequested==true) or (Auctioneer and Auctioneer.Scanning and Auctioneer.Scanning.IsScanningRequested and Auctioneer.Scanning.IsScanningRequested==true)) then
		return;
	end
	-- Trap for, and prevent, filters from doing anything while KCI is scanning.
	if (KC_ItemsAuction and KC_ItemsAuction.scanning) then
		return;
	end
	
	local numBatchAuctions, totalAuctions = GetNumAuctionItems("list");
	local button, buttonName, iconTexture, itemName, color, itemCount, moneyFrame, buyoutMoneyFrame, buyoutText, buttonHighlight;
	local offset = FauxScrollFrame_GetOffset(BrowseScrollFrame);
	local index;
	local isLastSlotEmpty;
	local name, texture, count, quality, canUse, minBid, minIncrement, buyoutPrice, duration, bidAmount, highBidder, owner;
	BrowseBidButton:Disable();
	BrowseBuyoutButton:Disable();
	-- Update sort arrows
	SortButton_UpdateArrow(BrowseQualitySort, "list", "quality");
	SortButton_UpdateArrow(BrowseLevelSort, "list", "level");
	SortButton_UpdateArrow(BrowseDurationSort, "list", "duration");
	SortButton_UpdateArrow(BrowseHighBidderSort, "list", "status");
	SortButton_UpdateArrow(BrowseCurrentBidSort, "list", "bid");

	-- Show the no results text if no items found
	if ( numBatchAuctions == 0 ) then
		BrowseNoResultsText:Show();
	else
		BrowseNoResultsText:Hide();
	end
	
	local baseAve = 0; bestAve = 0; worstAve = 0;
	local baseAveTable = {};
	-- Get the highest non-outlier value (only when Exact Name is turned on)
	if (afp_OptionButton_ShowBestDeals:GetChecked()) then
	--if (afp_OptionButton_ExactName:GetChecked() and BrowseName and BrowseName:GetText() ~= "") then
		for i=1, NUM_BROWSE_TO_DISPLAY do
			--for n=1,NUM_AUCTION_ITEMS_PER_PAGE do
				name,_,count,_,_,_,minBid,_,buyoutPrice,bidAmount,_,_ =  GetAuctionItemInfo("list", i); -- name, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner
				if (name and BrowseName and string.lower(name) == string.lower(BrowseName:GetText())) or not afp_OptionButton_ExactName:GetChecked() then
					-- Account for crafted Bolts of Cloth
					if (name==AFP_ITEM_BOLT_LINEN) then
						count = count * 2;
					elseif (name==AFP_ITEM_BOLT_WOOL) then
						count = count * 3;
					elseif (name==AFP_ITEM_BOLT_SILK) then
						count = count * 4;
					elseif (name==AFP_ITEM_BOLT_MAGEWEAVE) then
						count = count * 5;
					elseif (name==AFP_ITEM_BOLT_RUNECLOTH) then
						count = count * 5;
					elseif (name==AFP_ITEM_ESSENCE_ETERNAL) then
						count = count * 3;
					elseif (name==AFP_ITEM_ESSENCE_NETHER) then
						count = count * 3;
					elseif (name==AFP_ITEM_ESSENCE_MYSTIC) then
						count = count * 3;
					elseif (name==AFP_ITEM_ESSENCE_ASTRAL) then
						count = count * 3;
					elseif (name==AFP_ITEM_ESSENCE_MAGIC) then
						count = count * 3;
					end
					if ( buyoutPrice > 0 ) then
						table.insert(baseAveTable, buyoutPrice/count);
					elseif (not afp_OptionButton_HideNoBuyout:GetChecked()) then
						-- Don't use bids if HideNoBuyout is on!
						if ( bidAmount == 0 ) then
							table.insert(baseAveTable, minBid/count);
						else
							table.insert(baseAveTable, bidAmount/count);
						end
					end
				end
			--end
		end
	--end
	end
	if (table.getn(baseAveTable) > 0) then
		table.sort(baseAveTable);
		baseAve = baseAveTable[math.floor(table.getn(baseAveTable)/2)];
		bestAve = baseAveTable[1];
		worstAve = baseAveTable[table.getn(baseAveTable)];
--afp_Print("baseAveTable rows="..table.getn(baseAveTable)..", baseAve="..baseAve..", bestAve="..bestAve..", worstAve="..worstAve);
	end
	if (not baseAve) then baseAve = 0; end
	
	for i=1, NUM_BROWSE_TO_DISPLAY do
		if (afp_OptionButton_HideKnown:GetChecked() or afp_OptionButton_HideNoBuyout:GetChecked() or afp_OptionButton_HideUnaffordable:GetChecked() or afp_OptionButton_StacksOf20:GetChecked() or afp_OptionButton_StacksOf10:GetChecked() or afp_OptionButton_StacksOf5:GetChecked() or afp_OptionButton_ExactName:GetChecked() or afp_OptionButton_ColorKnown:GetChecked() or afp_OptionButton_GreyUnbid:GetChecked()) then
			local skipItem;
			for n=1,NUM_AUCTION_ITEMS_PER_PAGE do
				AFHiddenTooltip:ClearLines();
				name,_,count,quality,_,_,_,_,buyoutPrice,_,_,owner =  GetAuctionItemInfo("list", offset + i); -- name, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner
				AFHiddenTooltip:SetAuctionItem("list", offset + i);
				skipItem = 0;
				if (afp_OptionButton_HideKnown:GetChecked()) then
					if ((AFHiddenTooltipTextLeft3:GetText() == ITEM_SPELL_KNOWN) and (AFHiddenTooltip:NumLines() >= 3)) then
						skipItem = 1;
					elseif ((AFHiddenTooltipTextLeft4:GetText() == ITEM_SPELL_KNOWN) and (AFHiddenTooltip:NumLines() >= 4)) then
						skipItem = 1;
					end
				end
				if ((buyoutPrice == 0) and (afp_OptionButton_HideNoBuyout:GetChecked())) then
					skipItem = 1;
				end
				if ((GetMoney() < buyoutPrice) and (afp_OptionButton_HideUnaffordable:GetChecked())) then
					skipItem = 1;
				end
				if (count ~= 20 and afp_OptionButton_StacksOf20:GetChecked()) then
					skipItem = 1;
				end
				if (count ~= 10 and afp_OptionButton_StacksOf10:GetChecked()) then
					skipItem = 1;
				end
				if (count ~= 5 and afp_OptionButton_StacksOf5:GetChecked()) then
					skipItem = 1;
				end
				if (BrowseName and name and BrowseName:GetText() and string.lower(name) ~= string.lower(BrowseName:GetText()) and afp_OptionButton_ExactName:GetChecked()) then
					skipItem = 1;
				end
				if (skipItem == 1) then
					offset = offset + 1;
				else
					afp_BrowseList[i] = offset;
				end
			end
		else
			for n=1,NUM_BROWSE_TO_DISPLAY do
				afp_BrowseList[n] = offset;
			end
		end
		index = offset + i + (NUM_AUCTION_ITEMS_PER_PAGE * AuctionFrameBrowse.page);
		button = getglobal("BrowseButton"..i);
		-- Show or hide auction buttons
		if ( index > (numBatchAuctions + (NUM_AUCTION_ITEMS_PER_PAGE * AuctionFrameBrowse.page)) ) then
			button:Hide();
			--button:SetVertexColor(0,0,0);
			-- If the last button is empty then set isLastSlotEmpty var
			if ( i == NUM_BROWSE_TO_DISPLAY ) then
				isLastSlotEmpty = 1;
			end
		else -- EMERALD: BlackOut (if skipItem==1 then BlackOut)
			button:Show();
			buttonName = "BrowseButton"..i;
			name, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner =  GetAuctionItemInfo("list", offset + i);
			duration = GetAuctionItemTimeLeft("list", offset + i);
			-- Resize button if there isn't a scrollbar
			buttonHighlight = getglobal("BrowseButton"..i.."Highlight");
			if ( numBatchAuctions <= NUM_BROWSE_TO_DISPLAY ) then
				button:SetWidth(625);
				buttonHighlight:SetWidth(589);
				BrowseCurrentBidSort:SetWidth(207);
			elseif ( numBatchAuctions == NUM_BROWSE_TO_DISPLAY and totalAuctions <= NUM_BROWSE_TO_DISPLAY ) then
				button:SetWidth(625);
				buttonHighlight:SetWidth(589);
				BrowseCurrentBidSort:SetWidth(207);
			else
				button:SetWidth(600);
				buttonHighlight:SetWidth(562);
				BrowseCurrentBidSort:SetWidth(184);
			end
			-- Set name and quality color
			color = ITEM_QUALITY_COLORS[quality];
			itemName = getglobal(buttonName.."Name");
			local newName;
			local thisPrice = 0;
			local thisCount = 0;
			newName = GetHex(color.r,color.g,color.b)..name..FONT_COLOR_CODE_CLOSE;
			if (afp_OptionButton_ShowBestDeals:GetChecked()) then
				if (baseAve ~= 0) then
					-- Account for crafted Bolts of Cloth
					if (name==AFP_ITEM_BOLT_LINEN) then
						thisCount = count * 2;
					elseif (name==AFP_ITEM_BOLT_WOOL) then
						thisCount = count * 3;
					elseif (name==AFP_ITEM_BOLT_SILK) then
						thisCount = count * 4;
					elseif (name==AFP_ITEM_BOLT_MAGEWEAVE) then
						thisCount = count * 5;
					elseif (name==AFP_ITEM_BOLT_RUNECLOTH) then
						thisCount = count * 5;
					else
						thisCount = count;
					end
					if ( buyoutPrice > 0 ) then
						thisPrice = afp_Round(buyoutPrice/thisCount);
					else
						if ( bidAmount == 0 ) then
							thisPrice = afp_Round(minBid/thisCount);
						else
							thisPrice = afp_Round(bidAmount/thisCount);
						end
					end
					newName = newName.." ";
--afp_Print("thisPrice="..thisPrice..", best="..(bestAve * 1.2)..", worst="..(worstAve / 1.2)..", base="..baseAve);
--afp_Print("thisPrice="..thisPrice..", base="..baseAve);
					--if (thisPrice <= bestAve * 1.05) then -- Best Price
					--if (thisPrice <= bestAve) then -- Best Price
					if (thisPrice <= (baseAve / 2.2) or thisPrice <= bestAve) then -- Best Price
						newName = newName..GetHex(0.6,1,0.6).."(Best)";
					--elseif (thisPrice >= worstAve / 1.05) then -- Worst Price
					--elseif (thisPrice >= worstAve) then -- Worst Price
					elseif (thisPrice) >= (baseAve * 2.5) then -- Worst Price
						newName = newName..GetHex(1,0,0).."(Worst)+"..math.floor((thisPrice/baseAve)*100).."%";
					elseif (thisPrice) >= (baseAve * 1.8) then -- Bad Price
						newName = newName..GetHex(1,0.3,0.3).."(Worse)+"..math.floor((thisPrice/baseAve)*100).."%";
					elseif (thisPrice) >= (baseAve * 1.4) then -- Bad Price
						newName = newName..GetHex(1,0.6,0.6).."(Bad)+"..math.floor((thisPrice/baseAve)*100).."%";
					elseif (thisPrice <= (baseAve / 1.5)) then -- Great Price
						newName = newName..GetHex(0.3,1,0.3).."(Great)";
					elseif (thisPrice < baseAve) then -- Good Price
						newName = newName..GetHex(0,1,0).."(Good)";
					else -- Median Price
						newName = newName..GetHex(1,1,0).."(Average)";
					end
					newName = newName..FONT_COLOR_CODE_CLOSE;
				end
			end
			itemName:SetText(newName);
			--itemName:SetVertexColor(color.r, color.g, color.b);
			--if (skipItem==1) then itemName:SetVertexColor(0,0,0); end
			-- Set level
			if ( level > UnitLevel("player") ) then
				getglobal(buttonName.."Level"):SetText(RED_FONT_COLOR_CODE..level..FONT_COLOR_CODE_CLOSE);
			else
				getglobal(buttonName.."Level"):SetText(level);
			end
			--if (skipItem==1) then getglobal(buttonName.."Level"):SetVertexColor(0,0,0); end
			-- Set closing time
			getglobal(buttonName.."ClosingTimeText"):SetText(AuctionFrame_GetTimeLeftText(duration));
			getglobal(buttonName.."ClosingTime").tooltip = AuctionFrame_GetTimeLeftTooltipText(duration);
			--if (skipItem==1) then getglobal(buttonName.."ClosingTimeText"):SetVertexColor(0,0,0); end
			--if (skipItem==1) then getglobal(buttonName.."ClosingTime"):SetVertexColor(0,0,0); end
			-- Set item texture, count, and usability
			iconTexture = getglobal(buttonName.."ItemIconTexture");
			iconTexture:SetTexture(texture);
			if ( not canUse ) then
				iconTexture:SetVertexColor(1.0, 0.1, 0.1);
			else
				iconTexture:SetVertexColor(1.0, 1.0, 1.0);
			end
			itemCount = getglobal(buttonName.."ItemCount");
			if ( count > 1 ) then
				itemCount:SetText(count);
				itemCount:Show();
			else
				itemCount:Hide();
			end
			-- Color known recipe (courtesy LeisureLarry@Curse)
			if (afp_OptionButton_ColorKnown:GetChecked() and (AFHiddenTooltip:NumLines() >= 3)) then
				if (AFHiddenTooltipTextLeft3:GetText() == ITEM_SPELL_KNOWN) then
					-- Set color of icon to blue to make it easy to see that you already know it.
					iconTexture = getglobal("BrowseButton"..i.."ItemIconTexture");
					iconTexture:SetVertexColor(0, 0, 0.8);
				elseif ((AFHiddenTooltip:NumLines() >= 4) and (AFHiddenTooltipTextLeft4:GetText() == ITEM_SPELL_KNOWN)) then
					-- Set color of icon to blue to make it easy to see that you already know it.
					iconTexture = getglobal("BrowseButton"..i.."ItemIconTexture");
					iconTexture:SetVertexColor(0, 0, 0.8);
				end
			end
			--if (skipItem==1) then iconTexture:SetVertexColor(0,0,0); end
			-- Set high bid
			moneyFrame = getglobal(buttonName.."MoneyFrame");
			yourBidText = getglobal(buttonName.."YourBidText");
			buyoutMoneyFrame = getglobal(buttonName.."BuyoutMoneyFrame");
			buyoutText = getglobal(buttonName.."BuyoutText");
			-- If not bidAmount set the bid amount to the min bid
			if ( bidAmount == 0 ) then
				if (afp_OptionButton_PricePerUnit:GetChecked()) then
					MoneyFrame_Update(moneyFrame:GetName(), afp_Round(minBid/count));
				else
					MoneyFrame_Update(moneyFrame:GetName(), minBid);
				end
			else
				if (afp_OptionButton_PricePerUnit:GetChecked()) then
					MoneyFrame_Update(moneyFrame:GetName(), afp_Round(bidAmount/count));
				else
					MoneyFrame_Update(moneyFrame:GetName(), bidAmount);
				end
				if (afp_OptionButton_GreyUnbid:GetChecked()) then -- myShowBid functionality
					moneyFrame:SetAlpha(0.5);
				else
					moneyFrame:SetAlpha(1.0);
				end
			end
--if (skipItem==1) then moneyFrame:Hide(); end
			if ( highBidder ) then
				yourBidText:Show();
			else
				yourBidText:Hide();
			end
--if (skipItem==1) then yourBidText:Hide(); end
			if ( buyoutPrice > 0 ) then
				moneyFrame:SetPoint("RIGHT", buttonName, "RIGHT", 10, 10);
				if (afp_OptionButton_PricePerUnit:GetChecked()) then
					MoneyFrame_Update(buyoutMoneyFrame:GetName(), afp_Round(buyoutPrice/count));
				else
					MoneyFrame_Update(buyoutMoneyFrame:GetName(), buyoutPrice);
				end
				buyoutMoneyFrame:Show();
				buyoutText:Show();
			else
				moneyFrame:SetPoint("RIGHT", buttonName, "RIGHT", 10, 3);
				buyoutMoneyFrame:Hide();
				buyoutText:Hide();
			end
--if (skipItem==1) then buyoutMoneyFrame:Hide(); buyoutText:Hide(); end
			-- Set high bidder
			--if ( not highBidder ) then
			--	highBidder = RED_FONT_COLOR_CODE..NO_BIDS..FONT_COLOR_CODE_CLOSE;
			--end
			getglobal(buttonName.."HighBidder"):SetText(owner);
			--if (skipItem==1) then getglobal(buttonName.."HighBidder"):SetVertexColor(0,0,0); end
			-- Set highlight
			if ( GetSelectedAuctionItem("list") and (offset + i) == GetSelectedAuctionItem("list") ) then
				button:LockHighlight();

				if ( buyoutPrice > 0 and buyoutPrice >= minBid and GetMoney() >= buyoutPrice ) then
					BrowseBuyoutButton:Enable();
					AuctionFrame.buyoutPrice = buyoutPrice;
				else
					AuctionFrame.buyoutPrice = nil;
				end
				-- Set bid
				if ( bidAmount > 0 ) then
					bidAmount = bidAmount + minIncrement ;
					MoneyInputFrame_SetCopper(BrowseBidPrice, bidAmount);
				else
					MoneyInputFrame_SetCopper(BrowseBidPrice, minBid);
				end

				if ( not highBidder and GetMoney() >= MoneyInputFrame_GetCopper(BrowseBidPrice) ) then
					BrowseBidButton:Enable();
				end
			else
				button:UnlockHighlight();
			end
			
		end
	end

	-- Update scrollFrame
	-- If more than one page of auctions show the next and prev arrows when the scrollframe is scrolled all the way down
	if ( totalAuctions > NUM_AUCTION_ITEMS_PER_PAGE ) then
		if ( isLastSlotEmpty ) then
			BrowsePrevPageButton:Show();
			BrowseNextPageButton:Show();
			BrowseSearchCountText:Show();
			local itemsMin = AuctionFrameBrowse.page * NUM_AUCTION_ITEMS_PER_PAGE + 1;
			local itemsMax = itemsMin + numBatchAuctions - 1;
			BrowseSearchCountText:SetText(format(NUMBER_OF_RESULTS_TEMPLATE, itemsMin, itemsMax, totalAuctions ));
			if ( AuctionFrameBrowse.page == 0 ) then
				BrowsePrevPageButton.isEnabled = nil;
			else
				BrowsePrevPageButton.isEnabled = 1;
			end
			if ( AuctionFrameBrowse.page == (ceil(totalAuctions/NUM_AUCTION_ITEMS_PER_PAGE) - 1) ) then
				BrowseNextPageButton.isEnabled = nil;
			else
				BrowseNextPageButton.isEnabled = 1;
			end
		else
			BrowsePrevPageButton:Hide();
			BrowseNextPageButton:Hide();
			BrowseSearchCountText:Hide();
		end

		-- Artifically inflate the number of results so the scrollbar scrolls one extra row
		numBatchAuctions = numBatchAuctions + 1;
	else
		BrowsePrevPageButton:Hide();
		BrowseNextPageButton:Hide();
		BrowseSearchCountText:Hide();
	end
	FauxScrollFrame_Update(BrowseScrollFrame, numBatchAuctions, NUM_BROWSE_TO_DISPLAY, AUCTIONS_BUTTON_HEIGHT);
end

function afp_BrowseButton_OnClick(button)
	if ( not button ) then
		button = this;
	end
	--afp_Print("OnClick");
	--if ( IsControlKeyDown() ) then -- Dressing Room (THIS DOESN'T WORK, and I don't know why)
		--DressUpItemLink(GetAuctionItemLink("list", button:GetID() + afp_BrowseList[button:GetID()]));
		--afp_Print("DressUpItemLink");
	--elseif ( IsShiftKeyDown() ) then -- Text link
		--if ( ChatFrameEditBox:IsVisible() ) then
			--ChatFrameEditBox:Insert(GetAuctionItemLink("list", button:GetID() + afp_BrowseList[button:GetID()]));
			--afp_Print("ChatFrameEditBox");
		--end
	--else
		SetSelectedAuctionItem("list", button:GetID() + afp_BrowseList[button:GetID()]);
		afp_AuctionFrameBrowse_Update();
		--afp_Print("Else");
	--end
end

function afp_AuctionFrameItem_OnEnter(type, index)
	if (this:GetParent():GetID()) then -- EMERALD: Test
		index = this:GetParent():GetID();
	end
	if (afp_BrowseList and afp_BrowseList[this:GetParent():GetID()]) then
		index = index + afp_BrowseList[this:GetParent():GetID()];
	end
  afp_OriginalAuctionFrameItem_OnEnter(type, index)
end

function afp_FlyoutButton_OnClick()
	if (afp_FlyoutButton and afp_FlyoutButton:IsVisible()) then
		if (afp_FlyoutFrame and afp_FlyoutFrame:IsVisible()) then
			afp_FlyoutFrame:Hide();
			afp_FlyoutClear:Hide();
			afp_FlyoutSave:Hide();
			--afp_Print("afDEBUG: Hiding Flyout");
		elseif (afp_FlyoutFrame) then
			--CHANGE SIZE BASED ON NUMBER OF VISIBLE LINES (height=lines*19)
			afp_FlyoutFrame:SetHeight(13*19); -- Currently: 13 Lines
			afp_FlyoutFrame:SetParent(AuctionFrameBrowse);
			--afp_FlyoutFrame:SetPoint("TOPLEFT","AuctionFrameBrowse","TOPRIGHT",70,40);
			afp_FlyoutFrame:SetPoint("TOPLEFT","AuctionFrame","TOPRIGHT",4,-9);
			afp_FlyoutFrame:Show();
			afp_FlyoutClear:SetParent(afp_FlyoutFrame);
			afp_FlyoutClear:SetPoint("TOPLEFT","afp_FlyoutFrame","BOTTOMLEFT",1,0);
			afp_FlyoutClear:Show();
			afp_FlyoutSave:SetParent(afp_FlyoutFrame);
			afp_FlyoutSave:SetPoint("TOPRIGHT","afp_FlyoutFrame","BOTTOMRIGHT",-1,0);
			afp_FlyoutSave:Show();
			afp_FlyoutLoad:SetParent(afp_FlyoutFrame);
			afp_FlyoutLoad:SetPoint("TOPRIGHT","afp_FlyoutSave","BOTTOMRIGHT",0,0);
			afp_FlyoutLoad:Show();
			--afp_Print("afDEBUG: Showing Flyout");
		else
			--afp_Print("afDEBUG: ERROR: NO STATE!");
		end
	end
end

--[[ COMMON FUNCTIONS ]]

function afp_SlashHandler(msg)
	if (msg=="show" or msg=="hide") then msg = ""; end
	if (not msg or msg=="") then
		--Base command
		if (afp_FlyoutButton and afp_FlyoutButton:IsVisible()) then
			afp_FlyoutButton_OnClick();
		else
			afp_Print("The Flyout cannot be shown if the Auction window is not on the Browse tab.");
		end
	end
end

function afp_Print(message) -- Send Message to Chat Frame
	DEFAULT_CHAT_FRAME:AddMessage("[AuctionFilterPlus] "..message, 1.0, 1.0, 1.0);
end

function afp_PrintError(message) -- Send Error to Chat Frame
	DEFAULT_CHAT_FRAME:AddMessage("[AuctionFilterPlus] ERROR: "..message, 1.0, 0, 0);
end

function afp_Round(x)
	if (x - math.floor(x) > 0.5) then
		x = x + 0.5;
	end
	return math.floor(x);
end

--courtesy watchdog:
function GetHex(r,g,b)

	if g then
		return string.format("|cFF%02X%02X%02X", (255*r), (255*g), (255*b));
	elseif r then
		return string.format("|cFF%02X%02X%02X", (255*r.r), (255*r.g), (255*r.b));
	else
		return "";
	end

end
