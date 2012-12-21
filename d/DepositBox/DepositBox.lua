--[[
	DepositBox
	Author: DarkNight. Original code by CodeMoose
	Description: DepositBox is an addon that lets you store money in a safe place where you can save up
			 cash without being able to accidentally spend it. You can deposit and withdraw
			 your saved gold using the friendly user interface, just type in the amount you want
			 and press the correct button.
			 While money is saved in the DepositBox, it will not show up in your bag nor on merchant
			 windows. This means that you can't accidentally spend money that you've stored away.
			 This gives a nice way to save up for important purchases like your epic mount :D
			 A new feature is the DirectDeposit option. Turning this on and setting a percentage
			 will automatically store away that percentage of any money you earn.

	ToDo:
		* Find a way to use the MyAddons "Options" button to open DepositBox on the options Frame.
	

	-- VERSION 1.6.0 Released "14/12/2005"
	* Updated to be compatible with WoW v1.8.4
	* Initial attempt to adopt the code by DarkNight. Still learning what everything does.
	* Fixed bug where DB could display more money stored than you actually had money in total.
	* Migrated code to be compatible with Blizzard's new per-character/per-realm SavedVariables.
	* Added a "Bag Threshold" function: All money will go to your regular account until you reach your 
		"threshold" amount, then all money above that amount will go to the deposit box.
	* MyAddOns support added.


	-- VERSION 1.5.2 Released 17/10/2005
	* Updated to be compatible with WoW v.1.8.0
	* Fixed BuyBack Bug - Thanks DarkNight


	-- VERSION 1.5.1 Released 18/09/2005
	* Updated to be compatible with WoW v1.7.0
	* Fixed bug with loading where the DB frame sometimes couldnt be seen.
	* Fixed bug where loading sometimes caused errors.
	* Changed code to allow you to use the non-titan functionality if you have TitanPanel enabled but DB not used as an AddIn.


	-- VERSION 1.5.0a Released 09/09/2005
	* Fixed bug where DepositBox wasn't saving its openning location.
	
	
	-- VERSION 1.5.0 Released 09/09/2005
	* Added TitanPanel Support
		- This means that you can now use DepositBox as an addin to TitanPanel
	* Changed DirectDeposit from 10% to 2% increments
	* Added QuickFix for InventoryHawk
	

	-- VERSION 1.4.7 Released 03/09/2005 --
	* Added Accountant Compatibility Mode to allow you to choose between the old and new working of DepositBox. 
	  This should allow people who are having problems with Bag Displays showing their total money but who do not use 
	  Addons to record money earning/losses to revert back to the older code.
		- With AC Mode Enabled, DepositBox will use the new style code that allows Accountant type Addons to
		function correctly. (This may lead to some Bag Money displaying Addons displaying your total money)
		- With AC Mode Disabled, DepositBox will use the old style code that will be most useful with Addons
		that show your Player's money. (This will most likely not function with Accountant type Addons)
		- It is advised that you perform a "/console reloadui" after changing this option
	* Added QuickFix for Nox Infobar AddOn (Thanks ImTazMan)
	* Fixed bug that would take Training Costs out of DB if you didn't have enough in your bag (Thanks Corwin Whitehorn)
	* Fixed bug that would take Trade money from DB
	* Fixed bug that would take Talent Respec money from DB
	* Fixed bug that would take Single Item Repair money from DB
	
	
	-- VERSION 1.4.6 Released 13/08/2005 --
	* Fixed bug that would cause an error for first time users


	-- VERSION 1.4.5 Released 11/08/2005 --
	* Changed Money Handling code to become more compatable with Accountant type addons
		- Hopefully the new code will allow AddOns that track how much money you make/spend to function
		  correctly. They should now provide correct feedback about your money income and outgoings regardless
		  of whether you are shifting money in/out of DepositBox or not. Before, the accountants were seeing money 
		  moved into DepositBox as a loss and money out as a gain, and the DirectDeposit feature would cause 
		  confused results.
	* Fixed bug where buying a certain quantity of items would take money from DepositBox

	
	-- VERSION 1.4.4 Released 16/07/2005 --
	* Updated to be compatible with WoW v1.6.0
	* Fixed bug with Enhanced Flight Map (Thanks Corwin Whitehorn)
	

	-- VERSION 1.4.3 Released 11/07/2005 --
	* Added Money Display Option to choose between showing the money available in your bag and the money stored in DepositBox
	* Fixed Bug where Class Trainer wasn't updating if you used DepositBox while the window was open
	* Improved Loading Code to be more consistant and help remove loading discrepancies
	* Added new slash command to allow u to reset the DepositBox Button to the center of the screen
	  - /db reset
	  - Forces the DepositBox Button to show and move to the center of your screen (incase you have lost it off an edge)
	  	
	
	-- VERSION 1.4.2a Released 13/06/2005 --
	* Fixed Typo in key bindings (Thanks m1r0)

	-- VERSION 1.4.2 Released 08/06/2005 --
	* Updated to be compatible with WoW v1.5.0
	* Added Key Binding for toggling the DepositBox screen open and closed


	-- VERSION 1.4.1 Released 30/05/2005 --
	* Added Quick fix for 'MyInventory' and 'QuickCash' Addons (Thanks Skyotic)
	* Fixed bug with '/Split'  (Hopefully)
	* Changed Money Display so that it is always visible if using the minimap button
	

	-- VERSION 1.4  Released 09/05/2005 --
	* Updated UI to provide extra options
	* Added Minimap Button option, You can now use a button around the minimap instead of the original 
	  DepositBox Button to show/hide the frame
	* Added Money Display function so that you can see your bag cash instead of "Deposit Box" 
	  (most useful when not using the minimap button)
	* Added Storage Target Option to allow you to save money up in the background until you reach your target
		- You need to have direct deposit selected for this to be enabled
		- Set the target value in the frame and then tick the box to lock it
		- You can then hide the entire depositbox by clicking the Hide button (or using /db display)
		- It will then stay hidden until it has saved upto your target amount (or until you toggle display)
	* Fixed bug where setting some frame positions with "/db l" and "/db r" wouldn't work as expected
	* Fixed bug where the frame would appear to lock in its current location
	* Fixed bug where direct deposit percentage wasn't saved for each character
	* Added quick fix for 'All In One Inventory' Addon
	
	! Note: Upgrading to this version will reset your direct deposit percentage to 0%


	-- VERSION 1.3.2  Released 29/04/2005 --
	* The display state of DepositBox is now saved when logging off, 
	  so if you log off with it hidden, it should stay hidden when you come back.
	* Added quick fix for 'Telo's InfoBar' Addon
	* Fixed bug where money could not be sent in mail


	-- VERSION 1.3.1  Released 28/04/2005 --
	* Fixed bug where negative money could occur
	* Added quick fix for the 'Titan Panel' Addon


	-- VERSION 1.3  Released 28/04/2005 --
	* Added Clear Input button to wipe the money input boxes clean
	* Added Tooltip on Bag and Stored labels to show total amount of money you own
	* Fixed bug where tooltips came up on the wrong side when changing the location of the storageframe
	* Fixed bug where setting left or right location wouldnt do anything
	* Fixed bug with DirectDeposit where merchant money counters would not refresh
	* Fixed bug with money counters not refreshing if you deposit/withdraw money with windows open
	* Fixed bug with money counters not refreshing if you deposit/withdraw money with bags open
	* Fixed buy where DepositBox wouldn't remember the copper value that you had stored
	* Fixed bug where DirectDeposit would give you 0.5 of a copper
	* Fixed bug where posting a letter would fail


	-- VERSION 1.2  Released 21/04/2005 --
	* Added Direct Deposit Feature
	  - Allows you to automatically place a percentage of what you earn into your depositbox


	-- VERSION 1.1  Released 20/04/2005 --
	* Added new commands to allow u to relocate the depositframe
	  - /db <below, above, belowright, belowleft, aboveright, aboveleft>
	  - shortened to a, b, l, r (eg. /db al = aboveleft)
	* Changed frame to a button so its harder to accidently move it and easier to open
	* Added sound command to toggle sound on and off
	  - /db sound 
	* Added help command to display the list of available commands
	  - /db help or /db


	-- VERSION 1.0  Released 19/04/2005 --
	* Stores Money And Stops You Spending It
	* Displays Bag And Store Money
	* Closable Frame To Hide Cash Store
	* Movable Frame
	* Slash Command To Hide/Display Whole Frame

	
	!! Known Bugs !!
	* Since I cannot find a way to refresh the money displays from other addons that you may be using,
	  quick fixes for these addons will have to be made one at a time as people inform me of them.


  ]]


--New SavedVariablesPerCharacter
svDepositBox_Money = nil;
svDepositBox_UsingSound = nil;
svDepositBox_Location = nil;
svDepositBox_UsingDirectDepositOption = nil;
svDepositBox_DirectDepositPercentage = nil;
svDepositBox_UsingThresholdOption = nil;
svDepositBox_MoneyThreshold = nil;
svDepositBox_Hidden = nil;
svDepositBox_UsingMiniMapButton = nil;
svDepositBox_MiniMapLocation = nil;
svDepositBox_UsingMoneyAlert = nil;
svDepositBox_MoneyAlert = nil;
svDepositBox_UsingMoneyDisplay = nil;
svDepositBox_MoneyDisplayType = nil;
svDepositBox_ACMode = nil;

--Old SavedVariables
DepositBox_Money = {};
DepositBox_UsingSound = true;
DepositBox_Location = "BELOW";
DepositBox_DirectDepositPercentage = {};
DepositBox_UsingDirectDepositOption = {};
DepositBox_Hidden = false;
DepositBox_UsingMiniMapButton = false;
DepositBox_MiniMapLocation = 1;
DepositBox_UsingMoneyAlert = {};
DepositBox_MoneyAlert = {};
DepositBox_UsingMoneyDisplay = false;
DepositBox_MoneyDisplayType = "Bag";
DepositBox_ACMode = true;


local DepositBox_VERSION = "v1.6.0";
local DepositBox_RELEASEDATE = "Dec. 14, 2005"

local DepositBox_UsingTitan = false;
local DepositBox_ButtonWidth = 0;
local DepositBox_Original_TitanPanelButton_SetComboButtonWidth = nil;
local DepositBox_Original_TitanPanelBarButton_TogglePosition = nil;
local DepositBox_Original_TitanPanel_AddButton = nil;
local DepositBox_Original_TitanPanel_RemoveButton = nil;


local DepositBox_CurrentMoney = nil;
local DepositBox_LocalStoredMoney = nil;

local DepositBox_Original_GetMoney = nil;
local DepositBox_Original_MoneyFrame_Update = nil;
local DepositBox_Original_BuyMerchantItem = nil;
local DepositBox_Original_PickupMerchantItem = nil;


local DepositBox_Original_RepairAll = nil;
local DepositBox_Original_PaperDollItemSlotButton_OnClick = nil;
local DepositBox_Original_ContainerFrameItemButton_OnClick = nil;
local DepositBox_Original_TakeTaxiNode = nil;
local DepositBox_Original_StartAuction = nil;

local DepositBox_Original_SetSendMailMoney = nil;
local DepositBox_Original_SendMail = nil;
local DepositBox_Original_PurchaseSlot = nil;

local DepositBox_Original_BuybackItem = nil;
local DepositBox_Original_CompleteQuest = nil;

local DepositBox_Original_BuyTrainerService = nil;
local DepositBox_Original_SetTradeMoney = nil;
local DepositBox_Original_ConfirmTalentWipe = nil;

local DepositBox_Original_PickupPlayerMoney = nil;

local DepositBox_Original_SplitMoney = nil;

local DepositBox_Original_PlaceAuctionBid = nil;
local DepositBox_Original_AuctionFrameBrowse_Update = nil;
local DepositBox_Original_AuctionFrameBid_Update = nil;


local DepositBox_Name_Player = nil;
local DepositBox_Name_Realm = GetCVar("realmName");
local DepositBox_Initialised = nil;


local DepositBox_Move = 0;

BINDING_HEADER_DEPOSITBOX = "DepositBox"
BINDING_NAME_DEPOSITBOX_TOGGLE = "Toggle DepositBox Window";
DEPOSITBOX_TITLE = "Configure DepositBox"

-- MyAddons Support
DepositBoxDetails = {
		name = "DepositBox",
		version = DepositBox_VERSION,
		releaseDate = DepositBox_RELEASEDATE,
		author = "DarkNight, originally by CodeMoose",
		email = "depositbox@darknights-haven.com",
		website = "http://www.curse-gaming.com/mod.php?addid=1104",
		category = MYADDONS_CATEGORY_OTHERS
	};

DepositBoxHelp = {};
DepositBoxHelp[1] = "DepositBox " ..DepositBox_VERSION .."\nAuthor: DarkNight. Original code by CodeMoose.\n\n"
		.."DepositBox is an addon that lets you store money in a safe place where you can save up "
		.."cash without being able to accidentally spend it. You can deposit and withdraw "
		.."your saved gold using the friendly user interface, just type in the amount you want "
		.."and press the store or retrieve button.\n\n"
		.."While money is saved in the DepositBox, it will not show up in your bag nor on merchant "
		.."windows. This means that you can't accidentally spend money that you've stored away. "
		.."This gives a nice way to save up for important purchases like your epic mount :D\n\n"
		.."A popular feature is the DirectDeposit option. Turning this on and setting a percentage "
		.."will automatically store away that percentage of any money you earn.\n";
DepositBoxHelp[2] = "Command line options:\n\n"
		.."Enter /depositbox <command> or /db <command> in the chat window.\n"
		.."  Valid commands are:\n"
		.."     sound - Toggles sound on/off\n"
		.."     reset - Resets the DepositBox location to the center of the screen\n"
		.."     display - Toggles Hiding/Showing of DepositBox\n"
		.."     below, above, left, right - Changes the location of where the storage frame opens.\n"
		.."        Combinations can also be used, eg. aboveleft\n"
		.."";
DepositBoxHelp[3] = "Storage Tab:\n\n"
		.."The Storage Tab displays how much money is currently in your DepositBox and in your Bag "
		.."and gives you an easy way to move money between them. It also contains the options for "
		.."automatically depositing money into your DepositBox.\n\n"
		.."Stored: Displays the amount of money currently stored in the DepositBox. You cannot spend "
		.."the money stored in your DepositBox without first moving it to your Bag.\n\n"
		.."Bag: Displays the amount of money currently stored in your Bag. This is the amount that "
		.."is directly accessible to you for making purchases from vendors.\n\n"
		.."Money Input: Used for moving money from your Storage to your Bag and visa-versa. Enter "
		.."the amount you wish to transfer into the gold/silver/copper input boxes and select either "
		.."the 'store' or 'retrieve' buttons (located between the 'Stored' and 'Bag' displays) to "
		.."move the money.\n\n";
DepositBoxHelp[4] = "Storage Tab (continued):\n\n"
		.."Direct Deposit: Select this option and set a percentage on the slider to enable the 'Direct Deposit' "
		.."feature. When enabled, a percentage of any money earned will be deposited directly into "
		.."your DepositBox storage. For example, if you have 'Direct Deposit' set to 20% and you sell "
		.."an item for 1g, 80s will be deposited to your Bag and 20s will be deposited to your Storage.\n\n"
		.."Bag Threshold: Select this option to set a maximum amount of money that will be held in "
		.."your Bag. Once the threshold is reached, any further money earned will go directly into your "
		.."storage.\n\n"
		.."";
DepositBoxHelp[5] = "Options Tab:\n\n"
		.."Minimap Button: Select this option to turn on the display of the radial button on the minimap. "
		.."Choose the location of the button with the slider bar.\n\n"
		.."Money Display: Select this option to enable showing the amount of money stored in the DepositBox "
		.."titlebar. Select to diplay either 'Bag' or 'Stored' money.\n\n"
		.."Storage Target: select this option to trigger an alarm when the amount of money stored in the "
		.."DepositBox reaches the entered target level. Use this option to remind yourself that you now "
		.."have enough money to buy that item you were saving for.\n\n";
DepositBoxHelp[6] = "Options Tab (continued):\n\n"
		.."AC Mode: Accountant Compatibility. Turning this feature on will allow DepositBox to work correctly "
		.."with Addons that record your earnings/expenditure. (Although it may cause some other Addons to "
		.."show your total gold instead of just the amount not stored away)\n\n"
		.."Hide: Hides the DepositBox Window.\n\n"
		.."";


-- end of MyAddons variables

	
function DepositBox_OnLoad()

	SLASH_DEPOSITBOX1 = "/depositbox";
	SLASH_DEPOSITBOX2 = "/db"; -- A shortcut or alias
	SlashCmdList["DEPOSITBOX"] = DepositBox_SlashCommands;

	DepositBox_Original_GetMoney = GetMoney;
	--GetMoney = DepositBox_New_GetMoney;
	
	DepositBox_Original_MoneyFrame_Update = MoneyFrame_Update;
	MoneyFrame_Update = DepositBox_New_MoneyFrame_Update;

	DepositBox_Original_BuyMerchantItem = BuyMerchantItem;
	BuyMerchantItem = DepositBox_New_BuyMerchantItem;

	DepositBox_Original_PickupMerchantItem = PickupMerchantItem;
	PickupMerchantItem = DepositBox_New_PickupMerchantItem;

	DepositBox_Original_RepairAll = RepairAllItems;
	RepairAllItems = DepositBox_New_RepairAll;
	
	DepositBox_Original_PaperDollItemSlotButton_OnClick = PaperDollItemSlotButton_OnClick;
	PaperDollItemSlotButton_OnClick = DepositBox_New_PaperDollItemSlotButton_OnClick;
	
	DepositBox_Original_ContainerFrameItemButton_OnClick = ContainerFrameItemButton_OnClick;
	ContainerFrameItemButton_OnClick = DepositBox_New_ContainerFrameItemButton_OnClick;

	DepositBox_Original_TakeTaxiNode = TakeTaxiNode;
	TakeTaxiNode = DepositBox_New_TakeTaxiNode ;

	DepositBox_Original_StartAuction = StartAuction;
	StartAuction = DepositBox_New_StartAuction;

	DepositBox_Original_SetSendMailMoney = SetSendMailMoney;
	SetSendMailMoney = DepositBox_New_SetSendMailMoney;

	DepositBox_Original_SendMail = SendMail;
	SendMail = DepositBox_New_SendMail;

	DepositBox_Original_PurchaseSlot = PurchaseSlot;
	PurchaseSlot = DepositBox_New_PurchaseSlot;

	DepositBox_Original_BuybackItem = BuybackItem;
	BuybackItem = DepositBox_New_BuybackItem;

	DepositBox_Original_CompleteQuest = CompleteQuest;
	CompleteQuest = DepositBox_New_CompleteQuest;

	DepositBox_Original_PickupPlayerMoney = PickupPlayerMoney;
	PickupPlayerMoney = DepositBox_New_PickupPlayerMoney;
	
	DepositBox_Original_BuyTrainerService = BuyTrainerService;
	BuyTrainerService = DepositBox_New_BuyTrainerService;
	
	DepositBox_Original_SetTradeMoney = SetTradeMoney;
	SetTradeMoney = DepositBox_New_SetTradeMoney;
	
	DepositBox_Original_ConfirmTalentWipe = ConfirmTalentWipe;
	ConfirmTalentWipe = DepositBox_New_ConfirmTalentWipe;
	
	DepositBox_Original_SplitMoney = SplitMoney;
	SplitMoney = DepositBox_New_SplitMoney;
	
	DepositBox_Original_PlaceAuctionBid = PlaceAuctionBid;
	PlaceAuctionBid = DepositBox_New_PlaceAuctionBid;
	
	DepositBox_Original_AuctionFrameBrowse_Update = AuctionFrameBrowse_Update;
	AuctionFrameBrowse_Update = DepositBox_New_AuctionFrameBrowse_Update;

	DepositBox_Original_AuctionFrameBid_Update = AuctionFrameBid_Update;
	AuctionFrameBid_Update = DepositBox_New_AuctionFrameBid_Update;
		
	
	MoneyInputFrame_SetCopper(DepositBoxUI_DepositBox_MoneyInputFrame, 0);
	
	
	
	DepositBox_Name_Player = UnitName("player");
	DepositBox_Name_Realm = GetCVar("realmName");
	
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_MONEY");
	

	--UIErrorsFrame:AddMessage("DepositBox loaded", 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
	DEFAULT_CHAT_FRAME:AddMessage("|c00FFFFFF".."DepositBox "..DepositBox_VERSION.." Loaded".."|r");
	
end


--Titan Panel Functions

function DepositBox_Titan_OnLoad()
	
	this.registry={
		id					= "DepositBox",
		menuText			= "DepositBox",
		buttonTextFunction	= "DepositBox_Titan_GetButtonText",
		tooltipTitle		= "Deposit Box",
		tooltipTextFunction = "DepositBox_Titan_GetToolTipText",
		icon = "Interface\\AddOns\\DepositBox\\Images\\DepositBoxTitanIcon",		
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1
		}
	}
	
	DepositBox_Original_TitanPanelButton_SetComboButtonWidth = TitanPanelButton_SetComboButtonWidth;
	TitanPanelButton_SetComboButtonWidth = DepositBox_New_TitanPanelButton_SetComboButtonWidth;
	
	DepositBox_Original_TitanPanelBarButton_TogglePosition = TitanPanelBarButton_TogglePosition;
	TitanPanelBarButton_TogglePosition = DepositBox_New_TitanPanelBarButton_TogglePosition;
	
	DepositBox_Original_TitanPanel_AddButton = TitanPanel_AddButton;
	TitanPanel_AddButton = DepositBox_New_TitanPanel_AddButton;
	
	DepositBox_Original_TitanPanel_RemoveButton = TitanPanel_RemoveButton;
	TitanPanel_RemoveButton = DepositBox_New_TitanPanel_RemoveButton;

end


function DepositBox_Titan_LoadState()

	DepositBox_ButtonWidth = TitanPanelDepositBoxButton:GetWidth();
	
	-- Setup UI
	if (DepositBox_UsingTitan == true) then
		DepositBoxUI_Main_MoneyDisplayFrame:Hide();
		DepositBoxUI_Main_BlockButton:Hide();

		if (svDepositBox_UsingMiniMapButton == true) then
			DepositBoxUI_Main_MiniMapButtonFrame:Show();
		else
			DepositBoxUI_Main_MiniMapButtonFrame:Hide();
		end		
	end
	
	if (svDepositBox_UsingMoneyDisplay == true) then
		TitanPanelDepositBoxButtonGoldButton:Show();
		TitanPanelDepositBoxButtonSilverButton:Show();
		TitanPanelDepositBoxButtonCopperButton:Show();
	else
		TitanPanelDepositBoxButtonGoldButton:Hide();
		TitanPanelDepositBoxButtonSilverButton:Hide();
		TitanPanelDepositBoxButtonCopperButton:Hide();
	end

	DepositBox_UpdateCashDisplay(DepositBox_LocalStoredMoney);
	DepositBox_CheckTitanPosition();
end


function DepositBox_Titan_GetButtonText(id)

	return "DepositBox", ""; 
end


function DepositBox_Titan_GetToolTipText()
	return TitanUtils_GetGreenText("Hint: Left-click to open storage"); 
end


function TitanPanelRightClickMenu_PrepareDepositBoxMenu()
	TitanPanelRightClickMenu_AddTitle("DepositBox");
	
	TitanPanelRightClickMenu_AddToggleIcon("DepositBox");
	TitanPanelRightClickMenu_AddToggleLabelText("DepositBox");
	
	
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, "DepositBox", TITAN_PANEL_MENU_FUNC_HIDE);
end


function DepositBox_New_TitanPanelButton_SetComboButtonWidth(id, setButtonWidth)
	if (id == "DepositBox") then
	
		local button = TitanUtils_GetButton(id);
		local text = getglobal(button:GetName().."Text");
		local icon = getglobal(button:GetName().."Icon");	
		local iconWidth, iconButtonWidth, newButtonWidth;
		
		-- Get icon button width
		iconButtonWidth = 0;
		if ( TitanUtils_GetPlugin(id).iconButtonWidth ) then
			iconButtonWidth = TitanUtils_GetPlugin(id).iconButtonWidth;
		elseif ( icon:GetWidth() ) then
			iconButtonWidth = icon:GetWidth();
		end

		if ( TitanGetVar(id, "ShowIcon") and ( iconButtonWidth ~= 0 ) ) then
			icon:Show();
			text:ClearAllPoints();
			text:SetPoint("LEFT", icon:GetName(), "RIGHT", 2, 1);
			
			newButtonWidth = text:GetWidth() + iconButtonWidth + 2;
		else
			icon:Hide();
			text:ClearAllPoints();
			text:SetPoint("LEFT", button:GetName(), "Left", 0, 1);
			
			newButtonWidth = text:GetWidth();
		end
		
		if (svDepositBox_UsingMoneyDisplay == true) then
			newButtonWidth = newButtonWidth + 90;
		end
		
		if ( setButtonWidth or
				button:GetWidth() == 0 or 
				button:GetWidth() - newButtonWidth > TITAN_PANEL_BUTTON_WIDTH_CHANGE_TOLERANCE or 
				button:GetWidth() - newButtonWidth < -TITAN_PANEL_BUTTON_WIDTH_CHANGE_TOLERANCE ) then
			button:SetWidth(newButtonWidth);
			TitanPanelButton_Justify();
		end			
	
		if (TitanGetVar(id, "ShowIcon") == 1 or TitanGetVar(id, "ShowLabelText") == 1 or svDepositBox_UsingMoneyDisplay == true) then
		else
			TitanSetVar(id, "ShowIcon", 1)
			TitanSetVar(id, "ShowLabelText", 1)
			TitanPanel_RemoveButton("DepositBox");
			
			if(DepositBoxUI_DepositBoxFrame:IsVisible() or DepositBoxUI_OptionsFrame:IsVisible()) then
				DepositBox_ToggleDepositBox();
			end
			
			-- Close right click menu
			TitanPanelRightClickMenu_Close();
		end

	else
	   DepositBox_Original_TitanPanelButton_SetComboButtonWidth(id, setButtonWidth);
	end
end


function DepositBox_New_TitanPanelBarButton_TogglePosition()
	DepositBox_Original_TitanPanelBarButton_TogglePosition();
	DepositBox_CheckTitanPosition();
end


function DepositBox_CheckTitanPosition()

	if (TitanPanelGetVar("Position") == nil) then
		return;
	end
	
	if (TitanPanelGetVar("Position") == TITAN_PANEL_PLACE_TOP) then
		if (svDepositBox_Location == "ABOVE" or svDepositBox_Location == "ABOVERIGHT" or svDepositBox_Location == "ABOVELEFT") then
			svDepositBox_Location = "BELOW";
		end
	else
		if (svDepositBox_Location == "BELOW" or svDepositBox_Location == "BELOWRIGHT" or svDepositBox_Location == "BELOWLEFT") then
			svDepositBox_Location = "ABOVE";
		end
	end
	
	if(DepositBoxUI_DepositBoxFrame:IsVisible() or DepositBoxUI_OptionsFrame:IsVisible()) then
		DepositBox_ToggleDepositBox();
	end
end


function DepositBox_New_TitanPanel_AddButton(id)

	DepositBox_Original_TitanPanel_AddButton(id);	

	if (id == "DepositBox") then
		if(DepositBoxUI_DepositBoxFrame:IsVisible() or DepositBoxUI_OptionsFrame:IsVisible()) then
			DepositBox_ToggleDepositBox();
		end
		DepositBox_UsingTitan = true;
		DepositBox_Titan_LoadState();
	end

end


function DepositBox_New_TitanPanel_RemoveButton(id)

	DepositBox_Original_TitanPanel_RemoveButton(id);	

	if (id == "DepositBox") then
		if(DepositBoxUI_DepositBoxFrame:IsVisible() or DepositBoxUI_OptionsFrame:IsVisible()) then
			DepositBox_ToggleDepositBox();
		end
		DepositBox_UsingTitan = false;
		DepositBox_Titan_LoadState();
		DepositBox_LoadState();
	end

end

--End of Titan Panel Functions


function DepositBox_ConvertOldSV()
	if (DepositBox_Name_Realm == nil or DepositBox_Name_Player == nil) then
		return;
	end
	if (svDepositBox_Money == nil) then
		if (DepositBox_Money[DepositBox_Name_Realm] == nil) then
			DepositBox_Money[DepositBox_Name_Realm] = {};
		end
		if (DepositBox_Money[DepositBox_Name_Realm][DepositBox_Name_Player] == nil) then
			DepositBox_Money[DepositBox_Name_Realm][DepositBox_Name_Player] = "0";
		end
		svDepositBox_Money = DepositBox_Money[DepositBox_Name_Realm][DepositBox_Name_Player];
	end
	if (svDepositBox_UsingSound == nil) then
		if (DepositBox_UsingSound == nil) then
			DepositBox_UsingSound = true;
		end
		svDepositBox_UsingSound = DepositBox_UsingSound;
	end
	if (svDepositBox_Location == nil) then
		if (DepositBox_Location == nil or (DepositBox_Location ~= "BELOW" and DepositBox_Location ~= "ABOVE" and DepositBox_Location ~= "BELOWLEFT" and DepositBox_Location ~= "BELOWRIGHT" and DepositBox_Location ~= "ABOVELEFT" and DepositBox_Location ~= "ABOVERIGHT")) then
			DepositBox_Location = "BELOW";
		end
		svDepositBox_Location = DepositBox_Location;
	end
	if (svDepositBox_DirectDepositPercentage == nil) then
		if (DepositBox_DirectDepositPercentage[DepositBox_Name_Realm] == nil) then
			DepositBox_DirectDepositPercentage[DepositBox_Name_Realm] = {};
		end
		if (DepositBox_DirectDepositPercentage[DepositBox_Name_Realm][DepositBox_Name_Player] == nil) then
			DepositBox_DirectDepositPercentage[DepositBox_Name_Realm][DepositBox_Name_Player] = 0;
		end
		svDepositBox_DirectDepositPercentage = DepositBox_DirectDepositPercentage[DepositBox_Name_Realm][DepositBox_Name_Player];
	end
	if (svDepositBox_UsingDirectDepositOption == nil) then
		if (DepositBox_UsingDirectDepositOption[DepositBox_Name_Realm] == nil) then
			DepositBox_UsingDirectDepositOption[DepositBox_Name_Realm] = {};
		end
		if (DepositBox_UsingDirectDepositOption[DepositBox_Name_Realm][DepositBox_Name_Player] == nil) then
			DepositBox_UsingDirectDepositOption[DepositBox_Name_Realm][DepositBox_Name_Player] = false;
		end
		svDepositBox_UsingDirectDepositOption = DepositBox_UsingDirectDepositOption[DepositBox_Name_Realm][DepositBox_Name_Player];
	end
	if (svDepositBox_Hidden == nil) then
		if (DepositBox_Hidden == nil) then
			DepositBox_Hidden = false;
		end
		svDepositBox_Hidden = DepositBox_Hidden;
	end
	if (svDepositBox_UsingMiniMapButton == nil) then
		if (DepositBox_UsingMiniMapButton == nil) then
			DepositBox_UsingMiniMapButton = false;
		end
		svDepositBox_UsingMiniMapButton = DepositBox_UsingMiniMapButton;
	end
	if (svDepositBox_MiniMapLocation == nil) then
		if (DepositBox_MiniMapLocation == nil) then
			DepositBox_MiniMapLocation = 1;
		end
		svDepositBox_MiniMapLocation = DepositBox_MiniMapLocation;
	end
	if (svDepositBox_UsingMoneyAlert == nil) then
		if (DepositBox_UsingMoneyAlert[DepositBox_Name_Realm] == nil) then
			DepositBox_UsingMoneyAlert[DepositBox_Name_Realm] = {};
		end
		if (DepositBox_UsingMoneyAlert[DepositBox_Name_Realm][DepositBox_Name_Player] == nil) then
			DepositBox_UsingMoneyAlert[DepositBox_Name_Realm][DepositBox_Name_Player] = false;
		end
		svDepositBox_UsingMoneyAlert = DepositBox_UsingMoneyAlert[DepositBox_Name_Realm][DepositBox_Name_Player];
	end
	if (svDepositBox_MoneyAlert == nil) then
		if (DepositBox_MoneyAlert[DepositBox_Name_Realm] == nil) then
			DepositBox_MoneyAlert[DepositBox_Name_Realm] = {};
		end
		if (DepositBox_MoneyAlert[DepositBox_Name_Realm][DepositBox_Name_Player] == nil) then
			DepositBox_MoneyAlert[DepositBox_Name_Realm][DepositBox_Name_Player] = "0";
		end
		svDepositBox_MoneyAlert = DepositBox_MoneyAlert[DepositBox_Name_Realm][DepositBox_Name_Player];
	end
	if (svDepositBox_UsingMoneyDisplay == nil) then
		if (DepositBox_UsingMoneyDisplay == nil) then
			DepositBox_UsingMoneyDisplay = false;
		end
		svDepositBox_UsingMoneyDisplay = DepositBox_UsingMoneyDisplay;
	end
	if (svDepositBox_MoneyDisplayType == nil) then
		if (DepositBox_MoneyDisplayType == nil) then
			DepositBox_MoneyDisplayType = "Bag";
		end
		svDepositBox_MoneyDisplayType = DepositBox_MoneyDisplayType;
	end
	if (svDepositBox_ACMode == nil) then
		if (DepositBox_ACMode == nil) then
			DepositBox_ACMode = true;
		end
		svDepositBox_ACMode = DepositBox_ACMode;
	end
end


function DepositBox_LoadState()

	if (svDepositBox_Money == nil) then
		svDepositBox_Money = "0";
	end
	if (svDepositBox_UsingSound == nil) then
		svDepositBox_UsingSound = true;
	end
	if (svDepositBox_Location == nil or (svDepositBox_Location ~= "BELOW" and svDepositBox_Location ~= "ABOVE" and svDepositBox_Location ~= "BELOWLEFT" and svDepositBox_Location ~= "BELOWRIGHT" and svDepositBox_Location ~= "ABOVELEFT" and svDepositBox_Location ~= "ABOVERIGHT")) then
		svDepositBox_Location = "BELOW";
	end
	if (svDepositBox_UsingDirectDepositOption == nil) then
		svDepositBox_UsingDirectDepositOption = false;
	end
	if (svDepositBox_DirectDepositPercentage == nil) then
		svDepositBox_DirectDepositPercentage = 0;
	end
	if (svDepositBox_UsingThresholdOption == nil) then
		svDepositBox_UsingThresholdOption = false;
	end
	if (svDepositBox_MoneyThreshold == nil) then
		svDepositBox_MoneyThreshold = "0";
	end
	if (svDepositBox_Hidden == nil) then
		svDepositBox_Hidden = false;
	end
	if (svDepositBox_UsingMiniMapButton == nil) then
		svDepositBox_UsingMiniMapButton = false;
	end
	if (svDepositBox_MiniMapLocation == nil) then
		svDepositBox_MiniMapLocation = 1;
	end
	if (svDepositBox_UsingMoneyAlert == nil) then
		svDepositBox_UsingMoneyAlert = false;
	end
	if (svDepositBox_MoneyAlert == nil) then
		svDepositBox_MoneyAlert = "0";
	end
	if (svDepositBox_UsingMoneyDisplay == nil) then
		svDepositBox_UsingMoneyDisplay = false;
	end
	if (svDepositBox_MoneyDisplayType == nil) then
		svDepositBox_MoneyDisplayType = "Bag";
	end
	if (svDepositBox_ACMode == nil) then
		svDepositBox_ACMode = true;
	end

	--Setup UI

	DepositBoxPercentageText:SetText(svDepositBox_DirectDepositPercentage.."%");
	DepositBoxUI_DepositBox_PercentageSlider:SetValue(svDepositBox_DirectDepositPercentage);
	if (svDepositBox_UsingDirectDepositOption == true) then
		DepositBoxUI_DepositBox_DirectCheckButton:SetChecked(1);
		DepositBoxUI_Options_MoneyAlertCheckButton:Enable();
		DepositBoxUI_Options_MoneyInputFrame:Show();
		
	else
		DepositBoxUI_DepositBox_DirectCheckButton:SetChecked(0);
		DepositBoxUI_Options_MoneyAlertCheckButton:Disable();
		DepositBoxUI_Options_MoneyAlertCheckButton:SetChecked(0);

		MoneyInputFrame_ResetMoney(DepositBoxUI_Options_MoneyInputFrame);
		MoneyInputFrame_ClearFocus(DepositBoxUI_Options_MoneyInputFrame);
		DepositBoxUI_Options_MoneyInputFrame:Hide();

	end

	if (svDepositBox_UsingThresholdOption == true) then
		DepositBoxUI_DepositBox_ThresholdCheckButton:SetChecked(1);
		MoneyInputFrame_SetCopper(DepositBoxUI_DepositBox_ThresholdInputFrame, tonumber(svDepositBox_MoneyThreshold));
		DepositBoxUI_DepositBox_ThresholdInputFrame:Hide();
		
	else
		DepositBoxUI_DepositBox_ThresholdCheckButton:SetChecked(0);
		MoneyInputFrame_SetCopper(DepositBoxUI_DepositBox_ThresholdInputFrame, 0);
	end

	if (svDepositBox_UsingMoneyAlert == true) then
		DepositBoxUI_Options_MoneyAlertCheckButton:SetChecked(1);
		MoneyInputFrame_SetCopper(DepositBoxUI_Options_MoneyInputFrame, tonumber(svDepositBox_MoneyAlert));
		DepositBoxUI_Options_MoneyInputFrame:Hide();
		
	else
		DepositBoxUI_Options_MoneyAlertCheckButton:SetChecked(0);
		MoneyInputFrame_SetCopper(DepositBoxUI_Options_MoneyInputFrame, 0);
		
	end



	DepositBoxUI_Options_MiniMapSliderText:SetText(svDepositBox_MiniMapLocation);
	DepositBoxUI_Options_MiniMapSlider:SetValue(svDepositBox_MiniMapLocation);
	if (svDepositBox_UsingMiniMapButton == true) then
		DepositBoxUI_Options_MiniMapCheckButton:SetChecked(1);
		DepositBoxUI_Main_MiniMapButtonFrame:Show();
		DepositBoxUI_Main_BlockButton:Hide();
	else
		DepositBoxUI_Options_MiniMapCheckButton:SetChecked(0);
		DepositBoxUI_Main_MiniMapButtonFrame:Hide();
		DepositBoxUI_Main_BlockButton:Show();
	end
	DepositBox_MiniMapButton_UpdatePosition();


	if (svDepositBox_MoneyDisplayType == "Bag") then
		DepositBoxUI_Options_MoneyDisplay_BagCheckButton:SetChecked(1); 
		DepositBoxUI_Options_MoneyDisplay_BoxCheckButton:SetChecked(0);
	else
		DepositBoxUI_Options_MoneyDisplay_BagCheckButton:SetChecked(0); 
		DepositBoxUI_Options_MoneyDisplay_BoxCheckButton:SetChecked(1);
	end
	
	if (svDepositBox_UsingMoneyDisplay == false) then
		DepositBoxUI_Main_MoneyDisplayFrame:Hide();
		DepositBoxUI_BlockButtonText:Show();
		DepositBoxUI_Options_MoneyDisplayCheckButton:SetChecked(0);

		DepositBoxUI_Options_MoneyDisplay_BagCheckButton:Disable(); 
		DepositBoxUI_Options_MoneyDisplay_BoxCheckButton:Disable();
	else
		DepositBoxUI_Main_MoneyDisplayFrame:Show();
		DepositBoxUI_BlockButtonText:Hide();
		DepositBoxUI_Options_MoneyDisplayCheckButton:SetChecked(1); 

		DepositBoxUI_Options_MoneyDisplay_BagCheckButton:Enable(); 
		DepositBoxUI_Options_MoneyDisplay_BoxCheckButton:Enable();
	end
	

	if (svDepositBox_ACMode == false) then
		DepositBoxUI_Options_CompatableCheckButton:SetChecked(0); 
		GetMoney = DepositBox_New_GetMoney;
	else
		DepositBoxUI_Options_CompatableCheckButton:SetChecked(1); 
		GetMoney = DepositBox_Original_GetMoney;
	end


	if (svDepositBox_Hidden == true) then
		DepositBoxUI_Main_BlockButton:Hide();
		DepositBoxUI_Main_MiniMapButtonFrame:Hide();
		DepositBoxUI_OptionsFrame:Hide();
		DepositBoxUI_DepositBoxFrame:Hide();
	else
		if (svDepositBox_UsingMiniMapButton == true) then
			DepositBoxUI_Main_MiniMapButtonFrame:Show();
			if (svDepositBox_UsingMoneyDisplay == false) then
				DepositBoxUI_Main_BlockButton:Hide();
			else
				DepositBoxUI_Main_BlockButton:Show();
			end
		else
			DepositBoxUI_Main_MiniMapButtonFrame:Hide();
			DepositBoxUI_Main_BlockButton:Show();
		end
		DepositBoxUI_OptionsFrame:Hide();
		DepositBoxUI_DepositBoxFrame:Hide();
	end

	DepositBox_CheckLocation();
	
	
	
	--Override every Player MoneyFrame to show just the unstored amount
	MoneyTypeInfo["PLAYER"].UpdateFunc = function()
		return (DepositBox_New_GetMoney() - GetCursorMoney() - GetPlayerTradeMoney());
	end
	
	--Complex Stage QuickFixes
	if (NoxInformationBarFormats ~= nil) then
		NoxInformationBar_GetMoney = function ()
			return DepositBox_New_GetMoney();
		end
		NoxInformationBar_GetGold = function ()
			return  floor (DepositBox_New_GetMoney() / 10000);
		end
		NoxInformationBar_GetSilver = function ()
			return  floor ( math.mod ( DepositBox_New_GetMoney ( ), 10000 ) / 100 );
		end
		NoxInformationBar_GetCopper = function ()
			return  math.mod ( DepositBox_New_GetMoney ( ), 100 );
		end 
		NoxInformationBar_GetAllMoney= function ()
			return  NoxInformationBar_FormatMoney ( DepositBox_New_GetMoney ( ) );
		end 
	end
	
	
	if (IWMoneyDisplay_UpdateMoneyDisplay ~= nil) then
		
		IWMoneyDisplay_UpdateMoneyDisplay = function ()
			IWMyGoldButton:Show();
			IWMySilverButton:Show();
			IWMyCopperButton:Show();
			local currentMoney = 0;
			currentMoney = DepositBox_New_GetMoney();
			
			local gold = math.floor(currentMoney / COPPER_PER_GOLD);
			currentMoney = currentMoney - gold * COPPER_PER_GOLD;
			local silver = math.floor(currentMoney / COPPER_PER_SILVER);
			currentMoney = currentMoney - silver * COPPER_PER_SILVER;
			local copper = currentMoney;
			IWMyGoldButtonText:SetText(gold);
			IWMySilverButtonText:SetText(silver);
			IWMyCopperButtonText:SetText(copper);
		end	
	end
	
	--End Complex Stage QuickFixes
		
end


function DepositBox_OnEvent()
	if (event == "ADDON_LOADED") then
		if(myAddOnsFrame_Register) then
			-- Register the addon in myAddOns
			myAddOnsFrame_Register(DepositBoxDetails, DepositBoxHelp);
		end
	end
	
	if (event == "VARIABLES_LOADED") then
		--DEFAULT_CHAT_FRAME:AddMessage("|c00FFFFFF".."Debug: DepositBox_OnEvent: VARIABLES_LOADED".."|r");
		DepositBox_ConvertOldSV();
		DepositBox_LoadState();
		DepositBox_LocalStoredMoney = DepositBox_LoadLocalStoredMoney();
	end
	
	if (event == "PLAYER_ENTERING_WORLD") then

		if (DepositBox_CurrentMoney == nil) then
			DepositBox_CurrentMoney = DepositBox_New_GetMoney();
		end	

		if (TitanPanelBarButton ~= nil) then
			if ( TitanPanel_IsPluginShown("DepositBox") ) then
				DepositBox_UsingTitan = true;
			else
				DepositBox_UsingTitan = false;
			end
			DepositBox_Titan_LoadState();
		end
		
		DepositBox_UpdateCashDisplay(DepositBox_LocalStoredMoney);		
	end
	
	if (event == "PLAYER_MONEY") then
		if (DepositBox_New_GetMoney() + DepositBox_LocalStoredMoney > DepositBox_Original_GetMoney()) then
			DepositBox_SetLocalStoredMoney(DepositBox_Original_GetMoney());
			DepositBox_UpdateCashDisplay(DepositBox_LocalStoredMoney);
		else
			local newcash = 0;
			local toDeposit = 0;
			if (svDepositBox_UsingDirectDepositOption == true) then
				newcash = DepositBox_New_GetMoney() - DepositBox_CurrentMoney;
				if (newcash > 0) then
					toDeposit = floor((newcash / 100) * svDepositBox_DirectDepositPercentage);
					DepositBox_SetLocalStoredMoney (toDeposit + DepositBox_LocalStoredMoney);
				end
			end
			if (svDepositBox_UsingThresholdOption == true) then
				if (DepositBox_New_GetMoney() > tonumber(svDepositBox_MoneyThreshold)) then
					toDeposit = DepositBox_New_GetMoney() - tonumber(svDepositBox_MoneyThreshold);
					DepositBox_SetLocalStoredMoney (toDeposit + DepositBox_LocalStoredMoney);
				end
			end
			DepositBox_UpdateCashDisplay(DepositBox_LocalStoredMoney);
		end
		
		DepositBox_CurrentMoney = DepositBox_New_GetMoney();

		DepositBox_CheckForAlert();

	end
	
		
end


function DepositBox_SetLocalStoredMoney (money)
	DepositBox_LocalStoredMoney = money;
	svDepositBox_Money = ""..DepositBox_LocalStoredMoney;
end


function DepositBox_LoadLocalStoredMoney ()
	local cashToLoad = tonumber(svDepositBox_Money);
	
	if (cashToLoad == nil) then
		cashToLoad = 0;
	end
	
	return cashToLoad;
end


function DepositBox_UpdateCashDisplay(money)
	-- Breakdown the money into denominations
	local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD));
	local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
	local copper = mod(money, COPPER_PER_SILVER);

	local silverZero = "";
	local copperZero = "";

	if (silver < 10) then
		silverZero = "0";
	end
	if (copper < 10) then
		copperZero = "0";
	end

	--Set the text
	DepositBoxUI_DepositBox_MoneyStoredGoldText:SetText(gold);
	DepositBoxUI_DepositBox_MoneyStoredSilverText:SetText(silverZero..""..silver);
	DepositBoxUI_DepositBox_MoneyStoredCopperText:SetText(copperZero..""..copper);

	--Set the text on money display too

	if (svDepositBox_MoneyDisplayType == "Box") then
		if (DepositBox_UsingTitan == true) then
			TitanPanelDepositBoxButtonGoldButton:SetText(gold);
			TitanPanelDepositBoxButtonSilverButton:SetText(silverZero..""..silver);
			TitanPanelDepositBoxButtonCopperButton:SetText(copperZero..""..copper);	
		else
			DepositBoxUI_Main_MoneyDisplayGoldText:SetText(gold);
			DepositBoxUI_Main_MoneyDisplaySilverText:SetText(silverZero..""..silver);
			DepositBoxUI_Main_MoneyDisplayCopperText:SetText(copperZero..""..copper);	
		end
	end


			
	--Update the bag display too
	DepositBox_UpdateBagCashDisplay(DepositBox_New_GetMoney() - GetCursorMoney());
	
end


function DepositBox_UpdateBagCashDisplay(money)

	-- Breakdown the money into denominations
	local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD));
	local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
	local copper = mod(money, COPPER_PER_SILVER);

	local silverZero = "";
	local copperZero = "";

	if (silver < 10) then
		silverZero = "0";
	end
	if (copper < 10) then
		copperZero = "0";
	end

	--Set the text
	DepositBoxUI_DepositBox_MoneyBagGoldText:SetText(gold);
	DepositBoxUI_DepositBox_MoneyBagSilverText:SetText(silverZero..""..silver);
	DepositBoxUI_DepositBox_MoneyBagCopperText:SetText(copperZero..""..copper);
	
	--Set the text on money display too
	if (svDepositBox_MoneyDisplayType == "Bag") then
		if (DepositBox_UsingTitan == true) then
			TitanPanelDepositBoxButtonGoldButton:SetText(gold);
			TitanPanelDepositBoxButtonSilverButton:SetText(silverZero..""..silver);
			TitanPanelDepositBoxButtonCopperButton:SetText(copperZero..""..copper);	
		else
			DepositBoxUI_Main_MoneyDisplayGoldText:SetText(gold);
			DepositBoxUI_Main_MoneyDisplaySilverText:SetText(silverZero..""..silver);
			DepositBoxUI_Main_MoneyDisplayCopperText:SetText(copperZero..""..copper);	
		end
	end

	--Refresh windows as well
	DepositBox_RefreshWindows();
	
end


function DepositBox_RefreshWindows()
	--Refresh All Windows

	if (IsBagOpen(0)) then
		for i=1, NUM_CONTAINER_FRAMES, 1 do
			local containerFrame = getglobal("ContainerFrame"..i);
			if ( containerFrame:IsVisible() and (containerFrame:GetID() == 0) ) then
				MoneyFrame_Update("ContainerFrame"..i.."MoneyFrame", DepositBox_New_GetMoney() - GetCursorMoney());
				break;
			end
		end
	end

	local frame = GetLeftFrame();
	local centerframe = GetCenterFrame();
	local doubleframe = GetDoublewideFrame();

	if (frame ~= nil) then
		local name = frame:GetName();
		if (name == "MerchantFrame") then
			MoneyFrame_Update("MerchantMoneyFrame", DepositBox_New_GetMoney() - GetCursorMoney());
			MerchantFrame_Update();
		elseif (name == "BankFrame") then
			MoneyFrame_Update("BankFrameMoneyFrame", DepositBox_New_GetMoney() - GetCursorMoney());
			UpdateBagSlotStatus();
		elseif (name == "MailFrame") then
			MoneyFrame_Update("SendMailMoneyFrame", DepositBox_New_GetMoney() - GetCursorMoney());
			SendMailFrame_Update();
		elseif (name == "ClassTrainerFrame") then
			MoneyFrame_Update("ClassTrainerMoneyFrame", DepositBox_New_GetMoney() - GetCursorMoney());
			ClassTrainer_SelectFirstLearnableSkill();		
			ClassTrainerFrame_Update();	
		end
	end
	if (centerframe ~= nil) then
		local name = centerframe:GetName();
		if (name == "MerchantFrame") then
			MoneyFrame_Update("MerchantMoneyFrame", DepositBox_New_GetMoney() - GetCursorMoney());
			MerchantFrame_Update();
		elseif (name == "BankFrame") then
			MoneyFrame_Update("BankFrameMoneyFrame", DepositBox_New_GetMoney() - GetCursorMoney());
			UpdateBagSlotStatus();
		elseif (name == "MailFrame") then
			MoneyFrame_Update("SendMailMoneyFrame", DepositBox_New_GetMoney() - GetCursorMoney());
			SendMailFrame_Update();
		elseif (name == "ClassTrainerFrame") then
			MoneyFrame_Update("ClassTrainerMoneyFrame", DepositBox_New_GetMoney() - GetCursorMoney());
			ClassTrainer_SelectFirstLearnableSkill();		
			ClassTrainerFrame_Update();		
		end
	end
	if (doubleframe ~= nil) then
		local name = doubleframe:GetName();
		if (name == "AuctionFrame") then
			MoneyFrame_Update("AuctionFrameMoneyFrame", DepositBox_New_GetMoney() - GetCursorMoney());
			AuctionFrameBid_Update();
			AuctionFrameBrowse_Update();

			DepositBox_RefreshAuction("list");
			DepositBox_RefreshAuction("bidder");
		end
	end


	-- Quick fixes 
	if (TitanPanelMoneyButton ~= nil) then
		MoneyFrame_Update("TitanPanelMoneyButton", DepositBox_New_GetMoney() - GetCursorMoney());
	end
	if (IB_MoneyMoney ~= nil) then
		MoneyFrame_Update("IB_MoneyMoney", DepositBox_New_GetMoney() - GetCursorMoney());
	end
	if (AllInOneInventoryFrameMoneyFrame ~= nil) then
		MoneyFrame_Update("AllInOneInventoryFrameMoneyFrame", DepositBox_New_GetMoney() - GetCursorMoney());
	end
	if (SmallMoneyFrameTemplate ~= nil) then
		MoneyFrame_Update("SmallMoneyFrameTemplate", DepositBox_New_GetMoney() - GetCursorMoney());
	end
	if (NOX_MoneyFrame ~= nil) then
		MoneyFrame_Update("NOX_MoneyFrame", DepositBox_New_GetMoney() - GetCursorMoney());
	end
	if (IWMyGoldButton ~= nil or IWMySilverButton ~= nil or IWMyCopperButton ~= nil) then
		IWMoneyDisplay_UpdateMoneyDisplay();
	end
	
	
end


function DepositBox_StoreCash()

	local toStore = MoneyInputFrame_GetCopper(DepositBoxUI_DepositBox_MoneyInputFrame);
	if (toStore > DepositBox_New_GetMoney()) then
		toStore = DepositBox_New_GetMoney();
		MoneyInputFrame_SetCopper(DepositBoxUI_DepositBox_MoneyInputFrame, toStore);
	end
	

	--Clear the focus
	DepositBoxUI_DepositBox_MoneyInputFrameGold:ClearFocus();
	DepositBoxUI_DepositBox_MoneyInputFrameSilver:ClearFocus();
	DepositBoxUI_DepositBox_MoneyInputFrameCopper:ClearFocus();

	if (toStore > 0) then
		if (svDepositBox_UsingSound) then
			PlaySound("LOOTWINDOWCOINSOUND");
		end

		DepositBox_SetLocalStoredMoney(toStore + DepositBox_LocalStoredMoney);

		DepositBox_UpdateCashDisplay(DepositBox_LocalStoredMoney);

	end

	DepositBox_CurrentMoney = DepositBox_New_GetMoney();

	DepositBox_CheckForAlert();

end


function DepositBox_RetrieveCash()
	local toGet = MoneyInputFrame_GetCopper(DepositBoxUI_DepositBox_MoneyInputFrame);
	if (toGet > DepositBox_LocalStoredMoney) then
		toGet = DepositBox_LocalStoredMoney;
		MoneyInputFrame_SetCopper(DepositBoxUI_DepositBox_MoneyInputFrame, toGet);
	end
	

	--Clear the focus
	DepositBoxUI_DepositBox_MoneyInputFrameGold:ClearFocus();
	DepositBoxUI_DepositBox_MoneyInputFrameSilver:ClearFocus();
	DepositBoxUI_DepositBox_MoneyInputFrameCopper:ClearFocus();

	if (toGet > 0) then
		if (svDepositBox_UsingSound) then
			PlaySound("LOOTWINDOWCOINSOUND");
		end

		DepositBox_SetLocalStoredMoney(DepositBox_LocalStoredMoney - toGet);

		DepositBox_UpdateCashDisplay(DepositBox_LocalStoredMoney);

	end

	DepositBox_CurrentMoney = DepositBox_New_GetMoney();
	DepositBox_CheckForAlert();

end


function DepositBox_New_GetMoney()
	local realmoney = DepositBox_Original_GetMoney();

	if (svDepositBox_Money == nil) then
		DepositBox_LocalStoredMoney = DepositBox_LoadLocalStoredMoney();
	end

	if (DepositBox_LocalStoredMoney == nil) then
		DepositBox_LocalStoredMoney = 0;
	end

	if (realmoney < DepositBox_LocalStoredMoney) then
		DepositBox_LocalStoredMoney = realmoney;
	end

	return realmoney - DepositBox_LocalStoredMoney;
end


function DepositBox_CheckForAlert() 

	if (svDepositBox_UsingMoneyAlert == true) then

		if (DepositBox_LocalStoredMoney >= tonumber(svDepositBox_MoneyAlert)) then
			
				if (DepositBox_UsingTitan == true) then
					
					if (svDepositBox_UsingSound) then
						PlaySound("igMiniMapOpen");
					end
					DepositBoxUI_DepositBoxFrame:Show();
					DepositBoxUI_Main_TabsFrame:Show();
					DepositBox_CheckLocation();				
					
				else
					if (svDepositBox_UsingMiniMapButton == true) then
						DepositBoxUI_Main_MiniMapButtonFrame:Show();
					else
						DepositBoxUI_Main_BlockButton:Show();
					end
				end
				
				svDepositBox_Hidden = false;
				DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00".."DepositBox Has Reached The Storage Target".."|r");
		end

	end
end


function DepositBox_UpdateMoneyAlertDisplay()
	if (DepositBox_Name_Realm == nil or DepositBox_Name_Player == nil) then
		return;
	end
	
	local text = svDepositBox_MoneyAlert;
	if (text == nil) then
		return
	end
	
	local money = tonumber(text);

	-- Breakdown the money into denominations
	local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD));
	local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
	local copper = mod(money, COPPER_PER_SILVER);

	local silverZero = "";
	local copperZero = "";

	if (silver < 10) then
		silverZero = "0";
	end
	if (copper < 10) then
		copperZero = "0";
	end

	--Set the text
	DepositBoxUI_Options_MoneyAlertGoldText:SetText(gold);
	DepositBoxUI_Options_MoneyAlertSilverText:SetText(silverZero..""..silver);
	DepositBoxUI_Options_MoneyAlertCopperText:SetText(copperZero..""..copper);

end


function DepositBox_UpdateThresholdDisplay()
	if (DepositBox_Name_Realm == nil or DepositBox_Name_Player == nil) then
		return;
	end

	local text = svDepositBox_MoneyThreshold;

	if (text == nil) then
		return
	end

	local money = tonumber(text);

	-- Breakdown the money into denominations
	local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD));
	local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
	local copper = mod(money, COPPER_PER_SILVER);

	local silverZero = "";
	local copperZero = "";

	if (silver < 10) then
		silverZero = "0";
	end
	if (copper < 10) then
		copperZero = "0";
	end

	--Set the text
	DepositBoxUI_DepositBox_ThresholdGoldText:SetText(gold);
	DepositBoxUI_DepositBox_ThresholdSilverText:SetText(silverZero..""..silver);
	DepositBoxUI_DepositBox_ThresholdCopperText:SetText(copperZero..""..copper);

end


function DepositBox_ToggleDepositBox()

	if (DepositBox_UsingTitan == true) then
	
		-- Titan Panel Enabled
		if(DepositBoxUI_DepositBoxFrame:IsVisible() or DepositBoxUI_OptionsFrame:IsVisible()) then
			if (svDepositBox_UsingSound) then
				PlaySound("igMiniMapClose");
			end
			DepositBoxUI_DepositBoxFrame:Hide();
			DepositBoxUI_OptionsFrame:Hide();
			DepositBoxUI_Main_TabsFrame:Hide();

		else
			if (svDepositBox_UsingSound) then
				PlaySound("igMiniMapOpen");
			end
			DepositBoxUI_DepositBoxFrame:Show();
			DepositBoxUI_Main_TabsFrame:Show();
	
			DepositBox_CheckLocation();
		end		
		
	
	
		return
	end
	

	if (svDepositBox_UsingMiniMapButton == true) then

		-- MiniMap Operation

		if(DepositBoxUI_DepositBoxFrame:IsVisible() or DepositBoxUI_OptionsFrame:IsVisible()) then
			if (svDepositBox_UsingSound) then
				PlaySound("igMiniMapClose");
			end
			DepositBoxUI_DepositBoxFrame:Hide();
			DepositBoxUI_OptionsFrame:Hide();
			DepositBoxUI_Main_TabsFrame:Hide();
			if (svDepositBox_UsingMoneyDisplay == false) then
				DepositBoxUI_Main_BlockButton:Hide();
			end
		else
			if (svDepositBox_UsingSound) then
				PlaySound("igMiniMapOpen");
			end
			DepositBoxUI_DepositBoxFrame:Show();
			DepositBoxUI_Main_BlockButton:Show();
			DepositBoxUI_Main_TabsFrame:Show();
	
			DepositBox_CheckLocation();
		end
		

	else

		-- Normal Operation

		if(DepositBoxUI_DepositBoxFrame:IsVisible() or DepositBoxUI_OptionsFrame:IsVisible()) then
			if (svDepositBox_UsingSound) then
				PlaySound("igMiniMapClose");
			end
			DepositBoxUI_DepositBoxFrame:Hide();
			DepositBoxUI_OptionsFrame:Hide();
			DepositBoxUI_Main_TabsFrame:Hide();
		else
			if (svDepositBox_UsingSound) then
				PlaySound("igMiniMapOpen");
			end
			DepositBoxUI_DepositBoxFrame:Show();
			DepositBoxUI_Main_TabsFrame:Show();
	
			DepositBox_CheckLocation();
		end
	end

end


function DepositBox_ToggleUsingDirectDeposit ()
	
	local checkedValue = DepositBoxUI_DepositBox_DirectCheckButton:GetChecked(); 


	if (checkedValue == nil ) then
		--Turned Off
		if (svDepositBox_UsingSound) then
			PlaySound("igMainMenuOptionCheckBoxOff");
		end
		svDepositBox_UsingDirectDepositOption = false;
--[[
		DepositBoxUI_Options_MoneyAlertCheckButton:Disable();
		DepositBoxUI_Options_MoneyAlertCheckButton:SetChecked(0);
		svDepositBox_UsingMoneyAlert = false;
		svDepositBox_MoneyAlert = "0";
		
		DepositBoxUI_Options_MoneyInputFrame:Hide();

		MoneyInputFrame_ResetMoney(DepositBoxUI_Options_MoneyInputFrame);
		MoneyInputFrame_ClearFocus(DepositBoxUI_Options_MoneyInputFrame);
]]
	else	
		--Turned On
		if (svDepositBox_UsingSound) then
			PlaySound("igMainMenuOptionCheckBoxOn");
		end
		svDepositBox_UsingDirectDepositOption = true;
--[[
		DepositBoxUI_Options_MoneyAlertCheckButton:Enable();
		DepositBoxUI_Options_MoneyInputFrame:Show();
]]
	end

end


function DepositBox_ToggleMiniMapButton ()
	
	local checkedValue = DepositBoxUI_Options_MiniMapCheckButton:GetChecked(); 


	if (checkedValue == nil ) then
		--Turned Off
		if (svDepositBox_UsingMiniMapButton) then
			PlaySound("igMainMenuOptionCheckBoxOff");
		end
		svDepositBox_UsingMiniMapButton = false;
		DepositBoxUI_Main_MiniMapButtonFrame:Hide();
	else	
		--Turned On
		if (svDepositBox_UsingMiniMapButton) then
			PlaySound("igMainMenuOptionCheckBoxOn");
		end
		svDepositBox_UsingMiniMapButton = true;
		DepositBoxUI_Main_MiniMapButtonFrame:Show();
	end

end


function DepositBox_ToggleUsingThreshold ()
	local checkedValue = DepositBoxUI_DepositBox_ThresholdCheckButton:GetChecked(); 
	if (checkedValue == nil ) then
		--Turned Off
		if (svDepositBox_UsingSound) then
			PlaySound("igMainMenuOptionCheckBoxOff");
		end
		svDepositBox_UsingThresholdOption = false;
		MoneyInputFrame_ResetMoney(DepositBoxUI_DepositBox_ThresholdInputFrame);
		MoneyInputFrame_ClearFocus(DepositBoxUI_DepositBox_ThresholdInputFrame);
		DepositBoxUI_DepositBox_ThresholdInputFrame:Show();
	else	
		--Turned On
		if (svDepositBox_UsingSound) then
			PlaySound("igMainMenuOptionCheckBoxOn");
		end
		svDepositBox_UsingThresholdOption = true;
		svDepositBox_MoneyThreshold = ""..MoneyInputFrame_GetCopper(DepositBoxUI_DepositBox_ThresholdInputFrame);
		MoneyInputFrame_ClearFocus(DepositBoxUI_DepositBox_ThresholdInputFrame);
		DepositBoxUI_DepositBox_ThresholdInputFrame:Hide();
	end
end


function DepositBox_ToggleUsingMoneyAlert ()
	local checkedValue = DepositBoxUI_Options_MoneyAlertCheckButton:GetChecked(); 
	if (checkedValue == nil ) then
		--Turned Off
		if (svDepositBox_UsingSound) then
			PlaySound("igMainMenuOptionCheckBoxOff");
		end
		svDepositBox_UsingMoneyAlert = false;
		MoneyInputFrame_ResetMoney(DepositBoxUI_Options_MoneyInputFrame);
		MoneyInputFrame_ClearFocus(DepositBoxUI_Options_MoneyInputFrame);
		DepositBoxUI_Options_MoneyInputFrame:Show();
	else	
		--Turned On
		if (svDepositBox_UsingSound) then
			PlaySound("igMainMenuOptionCheckBoxOn");
		end
		svDepositBox_UsingMoneyAlert = true;
		svDepositBox_MoneyAlert = ""..MoneyInputFrame_GetCopper(DepositBoxUI_Options_MoneyInputFrame);
		MoneyInputFrame_ClearFocus(DepositBoxUI_Options_MoneyInputFrame);
		DepositBoxUI_Options_MoneyInputFrame:Hide();
	end
end


function DepositBox_ToggleUsingMoneyDisplay()

	local checkedValue = DepositBoxUI_Options_MoneyDisplayCheckButton:GetChecked(); 

	if (checkedValue == nil) then

		svDepositBox_UsingMoneyDisplay = false;
		DepositBoxUI_Main_MoneyDisplayFrame:Hide();
		DepositBoxUI_BlockButtonText:Show();
		DepositBoxUI_Options_MoneyDisplay_BoxCheckButton:Disable();
		DepositBoxUI_Options_MoneyDisplay_BagCheckButton:Disable();
		
		if (DepositBox_UsingTitan == true) then
			TitanPanelDepositBoxButtonGoldButton:Hide();
			TitanPanelDepositBoxButtonSilverButton:Hide();
			TitanPanelDepositBoxButtonCopperButton:Hide();
			
			DepositBox_New_TitanPanelButton_SetComboButtonWidth("DepositBox", true);			
		end

	else

		svDepositBox_UsingMoneyDisplay = true;
		DepositBoxUI_Main_MoneyDisplayFrame:Show();
		DepositBoxUI_BlockButtonText:Hide();
		DepositBoxUI_Options_MoneyDisplay_BoxCheckButton:Enable();
		DepositBoxUI_Options_MoneyDisplay_BagCheckButton:Enable();

		if (DepositBox_UsingTitan == true) then
			TitanPanelDepositBoxButtonGoldButton:Show();
			TitanPanelDepositBoxButtonSilverButton:Show();
			TitanPanelDepositBoxButtonCopperButton:Show();
			
			DepositBox_New_TitanPanelButton_SetComboButtonWidth("DepositBox", true);
		end
	end
	
end


function DepositBox_ToggleMoneyDisplayType(button)

	if (button == "Bag") then
		
		svDepositBox_MoneyDisplayType = "Bag";
		DepositBoxUI_Options_MoneyDisplay_BagCheckButton:SetChecked(1);
		DepositBoxUI_Options_MoneyDisplay_BoxCheckButton:SetChecked(0);

	else
	
		svDepositBox_MoneyDisplayType = "Box";
		DepositBoxUI_Options_MoneyDisplay_BagCheckButton:SetChecked(0);
		DepositBoxUI_Options_MoneyDisplay_BoxCheckButton:SetChecked(1);
			
	end
	
	DepositBox_UpdateCashDisplay(DepositBox_LocalStoredMoney);
	
end


function DepositBox_ToggleACMode()
	local checkedValue = DepositBoxUI_Options_CompatableCheckButton:GetChecked(); 
	local msg = "DepositBox Acountant Compatibility Mode ";

	if (checkedValue == nil) then
		GetMoney = DepositBox_New_GetMoney;
		svDepositBox_ACMode = false;
		msg = msg.."Disabled. ";
	else
		GetMoney = DepositBox_Original_GetMoney;
		svDepositBox_ACMode = true;
		msg = msg.."Enabled. ";
	end
	
	msg = msg.."It is advised that you perform '/console reloadui'";

	DEFAULT_CHAT_FRAME:AddMessage("|c00FFFF00".. msg .."|r");
end


function DepositBox_PerformTargetHide()

	local msgok;

	if (svDepositBox_UsingMiniMapButton == true) then
		if (DepositBoxUI_Main_MiniMapButtonFrame:IsShown()) then
			DepositBoxUI_Main_BlockButton:Hide();
			DepositBoxUI_Main_MiniMapButtonFrame:Hide();
			DepositBoxUI_DepositBoxFrame:Hide();
			DepositBoxUI_OptionsFrame:Hide();
			DepositBoxUI_Main_TabsFrame:Hide();
		
			msgok = "DepositBox Hidden";
			svDepositBox_Hidden = true;
		end
	else
		if (DepositBoxUI_Main_BlockButton:IsShown()) then
			DepositBoxUI_Main_BlockButton:Hide();
			DepositBoxUI_Main_MiniMapButtonFrame:Hide();
			DepositBoxUI_DepositBoxFrame:Hide();
			DepositBoxUI_OptionsFrame:Hide();
			DepositBoxUI_Main_TabsFrame:Hide();

			msgok = "DepositBox Hidden";
			svDepositBox_Hidden = true;
		end
	end
	
	if (msgok ~= nil) then
		DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00"..msgok.."|r");
	end

end


function DepositBox_OnValueChanged()
	local value = DepositBoxUI_DepositBox_PercentageSlider:GetValue();

	if (svDepositBox_DirectDepositPercentage == nil) then
		return;
	end
	
	svDepositBox_DirectDepositPercentage = value;
	DepositBoxPercentageText:SetText(value.."%");
end


function DepositBox_MiniMapOnValueChanged()

		local value = DepositBoxUI_Options_MiniMapSlider:GetValue();

		svDepositBox_MiniMapLocation = value;
		DepositBoxUI_Options_MiniMapSliderText:SetText(value);

		DepositBox_MiniMapButton_UpdatePosition();
end


function DepositBox_MiniMapButton_UpdatePosition()
	DepositBoxUI_Main_MiniMapButtonFrame:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		52 - (80 * cos(svDepositBox_MiniMapLocation)),
		(80 * sin(svDepositBox_MiniMapLocation)) - 52
	);
end


function DepositBox_ShowTotalMoney()
	local money = DepositBox_Original_GetMoney();
	local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD));
	local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
	local copper = mod(money, COPPER_PER_SILVER);

	local moneytext = gold.."g "..silver.."s "..copper.."c"
	if (svDepositBox_Location == "ABOVELEFT" or svDepositBox_Location == "BELOWLEFT") then
		GameTooltip:SetOwner(DepositBoxUI_DepositBoxFrame, "ANCHOR_TOPLEFT");
	else
		GameTooltip:SetOwner(DepositBoxUI_DepositBoxFrame, "ANCHOR_TOPRIGHT");
	end
	GameTooltip:SetText("Total Money: "..moneytext);

end


function DepositBox_CheckLocation()
	local width = DepositBoxUI_DepositBoxFrame:GetWidth();
	local halfwidth = width / 2;
	local height = DepositBoxUI_DepositBoxFrame:GetHeight();

	local tabwidth = DepositBoxUI_Main_TabsFrame:GetWidth();
	local tabheight = DepositBoxUI_Main_TabsFrame:GetHeight();
	
	
	local button = "DepositBoxUI_Main_BlockButton";
	local frame = "DepositBoxUI_DepositBoxFrame";
	local offset = 0;
	
	if (DepositBox_UsingTitan == true) then
		button = "TitanPanelDepositBoxButton";
		offset = 3;
	end
	
	if (svDepositBox_Location == "BELOWRIGHT") then
		--LEFT TOP
		DepositBoxUI_DepositBoxFrame:ClearAllPoints();
		DepositBoxUI_DepositBoxFrame:SetPoint("TOPLEFT", button, "BOTTOMLEFT", 0, -offset);
		DepositBoxUI_DepositBoxFrame:SetPoint("TOPRIGHT", button, "BOTTOMLEFT", width, -offset);

		DepositBoxUI_Main_TabsFrame:ClearAllPoints();
		DepositBoxUI_Main_TabsFrame:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 0, 7);
		DepositBoxUI_Main_TabsFrame:SetPoint("TOPRIGHT", frame, "BOTTOMLEFT", tabwidth, 7-tabheight);

	elseif (svDepositBox_Location == "ABOVERIGHT") then
		-- LEFT BOTTOM
		DepositBoxUI_DepositBoxFrame:ClearAllPoints();
		DepositBoxUI_DepositBoxFrame:SetPoint("BOTTOMLEFT", button, "TOPLEFT", 0, offset);
		DepositBoxUI_DepositBoxFrame:SetPoint("BOTTOMRIGHT", button, "TOPLEFT", width, offset);

		DepositBoxUI_Main_TabsFrame:ClearAllPoints();
		DepositBoxUI_Main_TabsFrame:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, -7);
		DepositBoxUI_Main_TabsFrame:SetPoint("BOTTOMRIGHT", frame, "TOPLEFT", tabwidth, -7+tabheight);

	elseif (svDepositBox_Location == "BELOWLEFT") then
		--RIGHT TOP
		DepositBoxUI_DepositBoxFrame:ClearAllPoints();
		DepositBoxUI_DepositBoxFrame:SetPoint("TOPLEFT", button, "BOTTOMRIGHT", -width, -offset);
		DepositBoxUI_DepositBoxFrame:SetPoint("TOPRIGHT", button, "BOTTOMRIGHT", 0, -offset);

		DepositBoxUI_Main_TabsFrame:ClearAllPoints();
		DepositBoxUI_Main_TabsFrame:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 0, 7);
		DepositBoxUI_Main_TabsFrame:SetPoint("TOPRIGHT", frame, "BOTTOMLEFT", tabwidth, 7-tabheight);

	elseif (svDepositBox_Location == "ABOVELEFT") then
		--RIGHT BOTTOM
		DepositBoxUI_DepositBoxFrame:ClearAllPoints();
		DepositBoxUI_DepositBoxFrame:SetPoint("BOTTOMLEFT", button, "TOPRIGHT", -width, offset);
		DepositBoxUI_DepositBoxFrame:SetPoint("BOTTOMRIGHT", button, "TOPRIGHT", 0, offset);

		DepositBoxUI_Main_TabsFrame:ClearAllPoints();
		DepositBoxUI_Main_TabsFrame:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, -7);
		DepositBoxUI_Main_TabsFrame:SetPoint("BOTTOMRIGHT", frame, "TOPLEFT", tabwidth, -7+tabheight);

	elseif (svDepositBox_Location == "RIGHT") then
		--LEFT
		DepositBoxUI_DepositBoxFrame:ClearAllPoints();
		DepositBoxUI_DepositBoxFrame:SetPoint("TOPLEFT", button, "BOTTOMLEFT", 0, 0);
		DepositBoxUI_DepositBoxFrame:SetPoint("TOPRIGHT", button, "BOTTOMLEFT", width, 0);

	elseif (svDepositBox_Location == "LEFT") then
		--RIGHT
		DepositBoxUI_DepositBoxFrame:ClearAllPoints();
		DepositBoxUI_DepositBoxFrame:SetPoint("TOPLEFT", button, "BOTTOMRIGHT", -width, 0);
		DepositBoxUI_DepositBoxFrame:SetPoint("TOPRIGHT", button, "BOTTOMRIGHT", 0, 0);

	elseif (svDepositBox_Location == "BELOW") then
		--TOP
		DepositBoxUI_DepositBoxFrame:ClearAllPoints();
		DepositBoxUI_DepositBoxFrame:SetPoint("TOPLEFT", button, "BOTTOM", -halfwidth, -offset);
		DepositBoxUI_DepositBoxFrame:SetPoint("TOPRIGHT", button, "BOTTOM", halfwidth, -offset);

		DepositBoxUI_Main_TabsFrame:ClearAllPoints();
		DepositBoxUI_Main_TabsFrame:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 0, 7);
		DepositBoxUI_Main_TabsFrame:SetPoint("TOPRIGHT", frame, "BOTTOMLEFT", tabwidth, 7-tabheight);

	elseif (svDepositBox_Location == "ABOVE") then
		--BOTTOM
		DepositBoxUI_DepositBoxFrame:ClearAllPoints();
		DepositBoxUI_DepositBoxFrame:SetPoint("BOTTOMLEFT", button, "TOP", -halfwidth, offset);
		DepositBoxUI_DepositBoxFrame:SetPoint("BOTTOMRIGHT", button, "TOP", halfwidth, offset);

		DepositBoxUI_Main_TabsFrame:ClearAllPoints();
		DepositBoxUI_Main_TabsFrame:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, -7);
		DepositBoxUI_Main_TabsFrame:SetPoint("BOTTOMRIGHT", frame, "TOPLEFT", tabwidth, -7+tabheight);
	end


end


function DepositBox_New_MoneyFrame_Update (frame, money)
	if (money == GetMoney()) then
		return DepositBox_Original_MoneyFrame_Update(frame, DepositBox_New_GetMoney() - GetCursorMoney() );
	else
		DepositBox_Original_MoneyFrame_Update(frame, money);
	end
end


function DepositBox_New_BuyMerchantItem(index, qty)
	--message("buy");
	local name, texture, price, quantity, numAvailable, isUsable = GetMerchantItemInfo(index);

	local total = price;
	if (qty ~= nil) then
		total = price * qty;
	end
	
	if (DepositBox_CheckBalance( total ) == true) then
		DepositBox_Original_BuyMerchantItem(index, qty);
	end
end


function DepositBox_New_PickupMerchantItem(index)
	--message("pickup");
	local name, texture, price, quantity, numAvailable, isUsable = GetMerchantItemInfo(index);

	if (DepositBox_CheckBalance(price) == true) then
		DepositBox_Original_PickupMerchantItem(index);
	end
end


function DepositBox_New_RepairAll()

	if (DepositBox_CheckBalance(GetRepairAllCost()) == true) then
		DepositBox_Original_RepairAll();
	end
end


function DepositBox_New_PaperDollItemSlotButton_OnClick(button, ignoreShift)
	
	if (InRepairMode()) then
		local hasItem, hasCooldown, repairCost = GameTooltip:SetInventoryItem("player", this:GetID());
		if (hasItem and repairCost and (repairCost > 0)) then
			if (DepositBox_CheckBalance(repairCost) == true) then
				DepositBox_Original_PaperDollItemSlotButton_OnClick(button, ignoreShift);
			end
		end
	else
		DepositBox_Original_PaperDollItemSlotButton_OnClick(button, ignoreShift);
	end
end


function DepositBox_New_ContainerFrameItemButton_OnClick(button, ignoreShift)

	if (InRepairMode()) then
		local hasCooldown, repairCost = GameTooltip:SetBagItem(this:GetParent():GetID(), this:GetID());
		if (repairCost and (repairCost > 0)) then
			if (DepositBox_CheckBalance(repairCost) == true) then
				DepositBox_Original_ContainerFrameItemButton_OnClick(button, ignoreShift);
			end
		end
	else
		DepositBox_Original_ContainerFrameItemButton_OnClick(button, ignoreShift);
	end
end


function DepositBox_New_TakeTaxiNode(slot)
	if (TaxiNodeGetType(slot) == "NONE") then
		return;
	end
	
	if (DepositBox_CheckBalance(TaxiNodeCost(slot)) == true) then
		DepositBox_Original_TakeTaxiNode(slot);
	end
end


function DepositBox_New_StartAuction(minBid, buyoutPrice, runTime)

	if (DepositBox_CheckBalance(CalculateAuctionDeposit(runTime)) == true) then
		DepositBox_Original_StartAuction(minBid, buyoutPrice, runTime);
	end
end


function DepositBox_New_SetSendMailMoney(amount)

	if (DepositBox_CheckBalance(amount) == true) then
		DepositBox_UpdateCashDisplay(DepositBox_LocalStoredMoney);
		return DepositBox_Original_SetSendMailMoney(amount);
	else
		--ClearSendMail();
	end
end


function DepositBox_New_SendMail(target, subject, body)

	if (DepositBox_CheckBalance(GetSendMailPrice()) == true) then
		DepositBox_Original_SendMail(target, subject, body);
		DepositBox_UpdateCashDisplay(DepositBox_LocalStoredMoney);
	else
		--ClearSendMail();
	end

end


function DepositBox_New_PurchaseSlot()

	if (DepositBox_CheckBalance(GetBankSlotCost(GetNumBankSlots()+1)) == true) then
		DepositBox_Original_PurchaseSlot();
	end
end


function DepositBox_New_BuybackItem(slot)
	local buybackName, buybackTexture, buybackPrice, buybackQuantity, buybackNumAvailable, buybackIsUsable = GetBuybackItemInfo(slot);
	if (DepositBox_CheckBalance(buybackPrice) == true) then
		DepositBox_Original_BuybackItem(slot);
	end
end


function DepositBox_New_CompleteQuest()
	if (DepositBox_CheckBalance(GetQuestMoneyToGet()) == true) then
		DepositBox_Original_CompleteQuest();
	end
end


function DepositBox_New_PickupPlayerMoney(amount)
	DepositBox_Original_PickupPlayerMoney(amount);
	DepositBox_UpdateBagCashDisplay(DepositBox_New_GetMoney() - amount);
end


function DepositBox_New_BuyTrainerService(id)
	if (DepositBox_CheckBalance(GetTrainerServiceCost(id)) == true) then
		DepositBox_Original_BuyTrainerService(id);
	end
end


function DepositBox_New_SetTradeMoney(copper)
	if (DepositBox_CheckBalance(copper) == true) then
		DepositBox_Original_SetTradeMoney(copper);
	else
		MoneyInputFrame_SetCopper(TradePlayerInputMoneyFrame, GetPlayerTradeMoney());
	end
end


function DepositBox_New_ConfirmTalentWipe()
	local popupFrame = StaticPopup_Visible("CONFIRM_TALENT_WIPE");
	
	if (popupFrame ~= nil) then
	
		local moneyFrame = getglobal(popupFrame.."MoneyFrame");
		local cost = moneyFrame.staticMoney;
		
		if (DepositBox_CheckBalance(cost) == true) then
			DepositBox_Original_ConfirmTalentWipe();
		end
	end
	
end


function DepositBox_New_PlaceAuctionBid(type, index, bid)
	if (DepositBox_CheckBalance(bid) == true) then
		DepositBox_Original_PlaceAuctionBid(type, index, bid);
	else
		BrowseBidButton:Disable();
		BrowseBuyoutButton:Disable();
	end
end


function DepositBox_New_AuctionFrameBrowse_Update()
	DepositBox_Original_AuctionFrameBrowse_Update();
	DepositBox_RefreshAuction("list");
end


function DepositBox_New_AuctionFrameBid_Update()
	DepositBox_Original_AuctionFrameBid_Update();
	DepositBox_RefreshAuction("bidder");
end


function DepositBox_RefreshAuction(type)
	local name, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner = GetAuctionItemInfo(type, GetSelectedAuctionItem(type));
	if (buyoutPrice == 0 or buyoutPrice > DepositBox_New_GetMoney()) then
	
		if (type == "list") then
			BrowseBuyoutButton:Disable();	
		elseif (type == "bidder") then
			BidBuyoutButton:Disable();	
		end
	end
	if (minBid > DepositBox_New_GetMoney()) then
		if (type == "list") then
			BrowseBidButton:Disable();	
		elseif (type == "bidder") then
			BidBidButton:Disable();	
		end
	end
end


function DepositBox_New_SplitMoney(amount)
	
	if (amount == nil) then
		amount = 0;
	else
		amount = tonumber(amount);
	end
	
	--message (amount);
	
	if ( amount <= 0 ) then 
		return nil; 
	end
	
	if (DepositBox_CheckBalance(amount) == true) then
		--message ("Split: "..amount);
		return DepositBox_Original_SplitMoney(amount);
		--DepositBox_UpdateBagCashDisplay(DepositBox_New_GetMoney() - GetCursorMoney());
	else
		return nil;	
	end
end


function DepositBox_CheckBalance(cost)
	if (cost > DepositBox_New_GetMoney()) then
		UIErrorsFrame:AddMessage("You cannot afford that", 1.0, 0.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
		return false;
	else
		return true;
	end	
end


function DepositBox_SlashCommands(cmd)
	
	local msgok = nil;

	if (cmd == "display") then
		if (DepositBox_UsingTitan == true) then
		
			DepositBox_ToggleDepositBox();
		
		else
		
			if (svDepositBox_UsingMiniMapButton == true) then
				if (DepositBoxUI_Main_MiniMapButtonFrame:IsShown()) then
					DepositBoxUI_Main_BlockButton:Hide();
					DepositBoxUI_Main_MiniMapButtonFrame:Hide();
					DepositBoxUI_DepositBoxFrame:Hide();
					DepositBoxUI_OptionsFrame:Hide();
					DepositBoxUI_Main_TabsFrame:Hide();
				
					msgok = "DepositBox Hidden";
					svDepositBox_Hidden = true;
				else	
					DepositBoxUI_Main_MiniMapButtonFrame:Show();
				
					msgok = "DepositBox Shown";
					svDepositBox_Hidden = false;
				end
			else
				if (DepositBoxUI_Main_BlockButton:IsShown()) then
					DepositBoxUI_Main_BlockButton:Hide();
					DepositBoxUI_Main_MiniMapButtonFrame:Hide();
					DepositBoxUI_DepositBoxFrame:Hide();
					DepositBoxUI_OptionsFrame:Hide();
					DepositBoxUI_Main_TabsFrame:Hide();
		
					msgok = "DepositBox Hidden";
					svDepositBox_Hidden = true;
				else	
					DepositBoxUI_Main_BlockButton:Show();
				
					msgok = "DepositBox Shown";
					svDepositBox_Hidden = false;
				end
			end
		end
	end

	if (cmd == "sound") then
		if (svDepositBox_UsingSound == true) then
			svDepositBox_UsingSound = false;
			msgok = "DepositBox Sounds Disabled";
		else
			svDepositBox_UsingSound = true;
			msgok = "DepositBox Sounds Enabled";
		end
	end
	if (cmd == "below" or cmd == "b") then
		svDepositBox_Location = "BELOW";
		msgok = "DepositBox Location set to Below";
	end
	if (cmd == "above" or cmd == "a") then
		svDepositBox_Location = "ABOVE";
		msgok = "DepositBox Location set to Above";
	end
	if (cmd == "belowright" or cmd == "br") then
		svDepositBox_Location = "BELOWRIGHT";
		msgok = "DepositBox Location set to BelowRight";
	end
	if (cmd == "belowleft" or cmd == "bl") then
		svDepositBox_Location = "BELOWLEFT";
		msgok = "DepositBox Location set to BelowLeft";
	end
	if (cmd == "aboveright" or cmd == "ar") then
		svDepositBox_Location = "ABOVERIGHT";
		msgok = "DepositBox Location set to AboveRight";
	end
	if (cmd == "aboveleft" or cmd == "al") then
		svDepositBox_Location = "ABOVELEFT";
		msgok = "DepositBox Location set to AboveLeft";
	end
	if (cmd == "right" or cmd == "r") then
		if (svDepositBox_Location == "ABOVELEFT" or svDepositBox_Location == "ABOVE" or svDepositBox_Location == "ABOVERIGHT") then 
			svDepositBox_Location = "ABOVERIGHT";
			msgok = "DepositBox Location set to AboveRight";
		else
			svDepositBox_Location = "BELOWRIGHT";
			msgok = "DepositBox Location set to BelowRight";
		end
	end
	if (cmd == "left" or cmd == "l") then
		if (svDepositBox_Location == "ABOVELEFT" or svDepositBox_Location == "ABOVE" or svDepositBox_Location == "ABOVERIGHT") then 
			svDepositBox_Location = "ABOVELEFT";
			msgok = "DepositBox Location set to AboveLeft";
		else
			svDepositBox_Location = "BELOWLEFT";
			msgok = "DepositBox Location set to BelowLeft";
		end
	end
	if (cmd == "reset") then
		if (DepositBox_UsingTitan == true) then
			DepositBox_CheckTitanPosition();
			msgok = "DepositBox Location Reset";
		else
			DepositBoxUI_Main_BlockButton:ClearAllPoints();
			DepositBoxUI_Main_BlockButton:SetPoint("CENTER", DepositBoxUI_Main_BlockButton:GetParent():GetName(), "CENTER", 0, 0);
			DepositBoxUI_Main_BlockButton:Show();
			msgok = "DepositBox Location Reset to center";
		end
	end

	if (msgok ~= nil) then
		DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00"..msgok.."|r");
		DepositBox_CheckLocation();
	end

	if (cmd == "" or cmd == "help") then
		local help = "DepositBox "..DepositBox_VERSION.." - By CodeMoose|n"..
				 "/depositbox <command> or /db <command>|n"..
				 "commands:|n"..
				 "sound - Toggles sound on/off|n"..
				 "reset - Resets the DepositBox location to the center of the screen|n"..
				 "display - Toggles Hiding/Showing of DepositBox|n"..
				 "below, above, left, right - Changes the location of where the storage frame opens. Combinations can also be used, eg. aboveleft|n"

		DEFAULT_CHAT_FRAME:AddMessage("|c00FFFF00"..help .."|r");
	end

end
