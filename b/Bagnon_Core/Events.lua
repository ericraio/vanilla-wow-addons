--[[
	Events.lua
		The main event handler for Bagnon and Banknon.
		It controls when the frames update, and when and when they are not shown.
		
		The UI by default partially supports showing/hiding at the mailbox, and fully supports the inventory frame showing/hiding at a vendor.
		
		I've extended the behavior in the following ways:
			If a frame was previously shown by a user, it will not automatically close.
			The events of showing the bank, tradeskill, auction, and trading can also be set to open the inventory or bank windows.
--]]

bgn_atBank = nil; --a flag for if the player is at the bank or not

function BagnonEvents_OnEvent()
	--[[ 
		Events For Updating Items
	--]]
	if ( event == "BAG_UPDATE" or event == "BAG_UPDATE_COOLDOWN") then
		if( Bagnon and Bagnon:IsVisible() and Bagnon_FrameHasBag("Bagnon", arg1) ) then
			BagnonFrame_Update(Bagnon, arg1);		
		elseif( Banknon and Banknon:IsVisible() and Bagnon_FrameHasBag("Banknon", arg1) ) then
			BagnonFrame_Update(Banknon, arg1);
		end
	elseif( event == "PLAYERBANKSLOTS_CHANGED") then
		if( Banknon and Banknon:IsVisible() and Bagnon_FrameHasBag("Banknon", -1) ) then
			BagnonFrame_Update(Banknon, -1);
		end
	elseif( event == "ITEM_LOCK_CHANGED" ) then
		if( Bagnon and Bagnon:IsVisible() ) then
			BagnonFrame_UpdateLock(Bagnon);		
		end
		if( Banknon and Banknon:IsVisible() ) then
			BagnonFrame_UpdateLock(Banknon);
		end
	--the keyring's size changes based on the player's level
	elseif( event == "PLAYER_LEVEL_UP") then
		if( Bagnon and Bagnon:IsVisible() and Bagnon_FrameHasBag("Bagnon", KEYRING_CONTAINER) ) then
			BagnonFrame_Generate(Bagnon);
		end
	--[[ 
		Automatic Frame Opening/Closing Events 
	--]]
	elseif(event == "BANKFRAME_OPENED") then
		bgn_atBank = 1;
		if(BagnonSets.showBagsAtBank) then
			BagnonFrame_Open("Bagnon", 1);
		end
		
		if(BagnonSets.showBankAtBank and Bagnon_IsAddOnEnabled("Banknon")) then
			BagnonFrame_Open("Banknon", 1);
		else
			BagnonEvents_ShowBlizBank();
		end
	elseif(event == "BANKFRAME_CLOSED") then
		bgn_atBank = nil;
		if(BagnonSets.showBagsAtBank) then
			BagnonFrame_Close("Bagnon", 1);
		end		
		if(BagnonSets.showBankAtBank) then
			BagnonFrame_Close("Banknon", 1);
		end
	elseif(event == "TRADE_SHOW") then
		if(BagnonSets.showBagsAtTrade) then
			BagnonFrame_Open("Bagnon", 1);
		end		
		if(BagnonSets.showBankAtTrade) then
			BagnonFrame_Open("Banknon", 1);
		end
	elseif(event == "TRADE_CLOSED") then
		if(BagnonSets.showBagsAtTrade) then
			BagnonFrame_Close("Bagnon", 1);
		end		
		if(BagnonSets.showBankAtTrade) then
			BagnonFrame_Close("Banknon", 1);
		end
	elseif(event == "TRADE_SKILL_SHOW") then
		if(BagnonSets.showBagsAtCraft) then
			BagnonFrame_Open("Bagnon", 1);
		end		
		if(BagnonSets.showBankAtCraft) then
			BagnonFrame_Open("Banknon", 1);
		end
	elseif(event == "TRADE_SKILL_CLOSE") then
		if(BagnonSets.showBagsAtCraft) then
			BagnonFrame_Close("Bagnon", 1);
		end		
		if(BagnonSets.showBankAtCraft) then
			BagnonFrame_Close("Banknon", 1);
		end
	elseif(event == "AUCTION_HOUSE_SHOW") then
		if(BagnonSets.showBagsAtAH) then
			BagnonFrame_Open("Bagnon", 1);
		end		
		if(BagnonSets.showBankAtAH) then
			BagnonFrame_Open("Banknon", 1);
		end
	elseif(event == "AUCTION_HOUSE_CLOSED") then
		if(BagnonSets.showBagsAtAH) then
			BagnonFrame_Close("Bagnon", 1);
		end		
		if(BagnonSets.showBankAtAH) then
			BagnonFrame_Close("Banknon", 1);
		end
	elseif(event == "MAIL_SHOW") then
		if(BagnonSets.showBankAtMail) then
			BagnonFrame_Open("Banknon", 1);
		end
	elseif(event == "MAIL_CLOSED") then
		BagnonFrame_Close("Bagnon", 1);
		
		if(BagnonSets.showBankAtMail) then
			BagnonFrame_Close("Banknon", 1);
		end
	elseif(event == "MERCHANT_SHOW") then
		if(BagnonSets.showBankAtVendor) then
			BagnonFrame_Open("Banknon", 1);
		end
	elseif(event == "MERCHANT_CLOSED") then
		if(BagnonSets.showBankAtVendor) then
			BagnonFrame_Close("Banknon", 1);
		end
	--[[ Loading Event ]]--
	elseif(event == "ADDON_LOADED" and arg1 == "Bagnon_Core") then
		BagnonEvents:UnregisterEvent("ADDON_LOADED");		
		BagnonEvents_Load(this);
	end
end

function BagnonEvents_Load(eventFrame)
	BankFrame:UnregisterEvent("BANKFRAME_OPENED");
	
	--disable the ItemOnUpdate function for those using KCItems, since it causes a pretty bad memory leak
	if KC_Items then
		BagnonItem_OnUpdate = function() return; end;
	end
	
	BagnonEvents_LoadVariables();
	BagnonEvents_ObtainLocalizedNames();
	Infield.AddRescaleAction(BagnonEvents_RescaleAll);
	
	eventFrame:RegisterEvent("BAG_UPDATE");
	eventFrame:RegisterEvent("PLAYERBANKSLOTS_CHANGED");
	eventFrame:RegisterEvent("ITEM_LOCK_CHANGED");
	eventFrame:RegisterEvent("BAG_UPDATE_COOLDOWN");
	eventFrame:RegisterEvent("PLAYER_LEVEL_UP");
	
	eventFrame:RegisterEvent("BANKFRAME_OPENED");
	eventFrame:RegisterEvent("BANKFRAME_CLOSED");
	eventFrame:RegisterEvent("TRADE_SHOW");
	eventFrame:RegisterEvent("TRADE_CLOSED");
	eventFrame:RegisterEvent("TRADE_SKILL_SHOW");
	eventFrame:RegisterEvent("TRADE_SKILL_CLOSE");
	eventFrame:RegisterEvent("AUCTION_HOUSE_SHOW");
	eventFrame:RegisterEvent("AUCTION_HOUSE_CLOSED");
	eventFrame:RegisterEvent("MAIL_SHOW");
	eventFrame:RegisterEvent("MAIL_CLOSED");
	eventFrame:RegisterEvent("MERCHANT_SHOW");
	eventFrame:RegisterEvent("MERCHANT_CLOSED");
end

function BagnonEvents_LoadVariables()
	if(not BagnonSets) then	
		BagnonSets = {
			showBagsAtBank = 1,
			showBagsAtAH = 1,
			showBankAtBank = 1,
			showTooltips = 1,
			qualityBorders = 1,
			version = BAGNON_VERSION,
		};
		BagnonMsg(BAGNON_INITIALIZED);
	elseif(BagnonSets.version ~= BAGNON_VERSION) then
		
		if(BagnonSets.overrideBank) then
			BagnonSets.showBankAtBank = 1;
			BagnonSets.overrideBank = nil;
		end
		
		BagnonSets.version = BAGNON_VERSION;
		BagnonMsg(BAGNON_UPDATED);
	end
end

local function BagnonHasInfo()
	return (GetLocale() == "enUS" or 
			GetLocale() == "deDE" or 
			GetLocale() == "frFR" or 
			GetLocale() == "zhCN" or
			GetLocale() == "zhTW" or 
			BagnonSets.noDebug);
end

--try and get localized names, so that its possible to do special bag coloring
function BagnonEvents_ObtainLocalizedNames()
	if( not BagnonHasInfo() ) then
		BagnonMsg("Obtaining localized data.  Please report the following to where you downloaded Bagnon from.");
		BagnonMsg( GetLocale() );
	end
	
	--backpack
	local name, _, _, _, iType, subType = GetItemInfo(4500); 		
	if(name) then
		if( not BagnonHasInfo() ) then
			BagnonMsg( "Backpack:  " .. (iType or "null") .. ", " .. (subType or "null") );
		end
		if(iType) then
			BAGNON_ITEMTYPE_CONTAINER = iType;
			BAGNON_SUBTYPE_BAG = subType;
		end
	end

	--ammo	
	name, _, _, _, iType, subType = GetItemInfo(8218); 
	if(name) then
		if( not BagnonHasInfo() ) then
			BagnonMsg( "Ammo:  " .. (iType or "null") .. ", " .. (subType or "null") );
		end
		if(iType) then
			BAGNON_ITEMTYPE_QUIVER = iType;
		end
	end

	--soul pouch
	name, _, _, _, iType, subType = GetItemInfo(21340); 
	if(name) then
		if( not BagnonHasInfo() ) then
			BagnonMsg( "Soul Bag:  " .. (iType or "null") .. ", " .. (subType or "null") );
		end
		if(subType) then
			BAGNON_SUBTYPE_SOULBAG = subType;
		end
	end
end

function BagnonEvents_RescaleAll()
	if(Bagnon) then
		BagnonFrame_Reposition(Bagnon);
	end
	
	if(Banknon) then
		BagnonFrame_Reposition(Banknon);
	end
end

--[[
	Taken from Blizzard's code
	Shows the normal bank frame
--]]

function BagnonEvents_ShowBlizBank()
	BankFrameTitleText:SetText( UnitName("npc") );
	SetPortraitTexture(BankPortraitTexture,"npc");
	ShowUIPanel(BankFrame);
	
	if( not BankFrame:IsVisible() ) then
		CloseBankFrame();
	end
	UpdateBagSlotStatus();
end

--[[ Create the Event Handler Frame ]]--
CreateFrame("Frame", "BagnonEvents")
BagnonEvents:RegisterEvent("ADDON_LOADED");
BagnonEvents:SetScript("OnEvent", BagnonEvents_OnEvent);
BagnonEvents:Hide();