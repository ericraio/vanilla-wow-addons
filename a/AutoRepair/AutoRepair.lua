--
-- Chat Colors
--

local STATUS_COLOR                  = "|c000066FF";
local CONNECTION_COLOR              = "|c0033FF66";
local MONEY_COLOR                   = "|c00FFCC33";
local DEBUG_COLOR                   = "|c0000FF00";
local GREY                          = "|c00909090";
local BRIGHTGREY                    = "|c00D0D0D0";
local WHITE                         = "|c00FFFFFF";
local SILVER			= "|c00C0C0C0";
local COPPER			= "|c00CC9900";
local GOLD			= "|c00FFFF66";

local AR_CurrentVersion = "0.6";
local AR_DiagOpen = false;
local AR_CB= nil;
local AR_CBV;
local AR_CBT = 0;

--
--	Event Handlers
--
function AutoRepair_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("MERCHANT_SHOW");
end

function AutoRepair_OnEvent(event)
	if ( event == "VARIABLES_LOADED" ) then
		AR_Load()
	end

	if ( event == "MERCHANT_SHOW") then
		if (CanMerchantRepair() and AR_Save.enabled) then
			AR_RepairHandler(false);
		end
	end

end

function AutoRepair_OnUpdate(dt)
	if (AR_CB) then
		AR_CBT = AR_CBT + dt
		if (AR_CBT > 1) then
			AR_CBT = 0;
			if (AR_CBV) then
				AR_CB(AR_CBV);			
			else
				AR_CB();
			end
		end
	end
end

--
--	Initialization And Configuration.
--

function AR_Load()

	AR_Chat("AutoRepair v"..AR_CurrentVersion.." loaded.");

	if (AR_Save == nil) then
		AR_SaveSetup();
	end
	
	if (AR_Save.version ~= AR_CurrentVersion) then
		AR_UpgradeFrom(AR_Save.version);
	end

	SlashCmdList["AUTOREPAIR"] = AR_SlashHandler;
	SLASH_AUTOREPAIR1 = "/autorepair";
	SLASH_AUTOREPAIR2 = "/ar";

end

function AR_UpgradeFrom(oldVersion)

	if (oldVersion == "0.5") then
		AR_Save.version = AR_CurrentVersion;
		AR_Save.verbose = true;
		AR_Save.skipInv = false;
	end
	
end


function AR_SaveSetup()
	AR_Chat("Default Variable Values Loaded.");
	AR_Chat("To Learn How To Change Settings Type /ar");
	AR_Save = {};
	AR_Save.version = AR_CurrentVersion;
	AR_Save.enabled = true;
	AR_Save.costThreshold = 0;
	AR_Save.minCost = 0;
	AR_Save.promptEnabled = true;
	AR_Save.verbose = true;
	AR_Save.skipInv = false;
end

--
--	Helper Functions
--

function AR_Chat(text)
	DEFAULT_CHAT_FRAME:AddMessage(STATUS_COLOR..text);	
end

-- function  By Turan (turan@gryffon.com) - AuctionIt!
-- http://turan.gryffon.com/wow.html -- gryphon globals.lua 
-- moved this function here since he updates his library's often
function setAmountString(amt, sep)
    local str = "";
    local gold, silver, copper;

    if (amt == 0) then
	str = COPPER .. "0 Copper" .. STATUS_COLOR;	
	return str;
    end
    if ( not sep ) then sep = " " end;
    
    copper = mod(floor(amt + .5),      100);
    silver = mod(floor(amt/100),       100);
    gold   = mod(floor(amt/(100*100)), 100);
    
    if ( gold   > 0 ) then str = GOLD .. gold .. " Gold" end;
    if ( silver > 0 ) then
        if ( str ~= "" ) then str = str .. sep end;
        str = str .. SILVER .. silver .. " Silver";
    end;
    if ( copper > 0 ) then
        if ( str ~= "" ) then str = str .. sep end;
        str = str .. COPPER .. copper .. " Copper";
    end;

    str = str .. STATUS_COLOR;
    return str;
end

function setEnabledString(enabled)
	if (enabled) then
		return "Enabled.";
	else
		return "Disabled.";
	end
end
--
--	Slash Command Handlers
--

function AR_SlashHandler(msg)

   local _,_,command,options = string.find(msg,"([%w%p]+)%s*(.*)$");
	
   if (command) then
   	command = string.lower(command);
   end
   if (command == nil or command == "") then
	AR_Chat("Current Settings:");
	AR_Chat("MinCost: ".. WHITE .. setAmountString(AR_Save.minCost));
	AR_Chat("Threshold: " .. WHITE .. setAmountString(AR_Save.costThreshold));
	AR_Chat("Prompts: " .. WHITE .. setEnabledString(AR_Save.promptEnabled));
	AR_Chat("Verbose: " .. WHITE .. setEnabledString(AR_Save.verbose));
	AR_Chat("Skipping Inventory: " .. WHITE .. setEnabledString(AR_Save.skipInv));
	AR_Chat("Available Commands:");
	AR_Chat("/ar MinCost <number>  -- " .. WHITE .."Sets the minimal ammount you wish to ever auto repair for.  This is compared to the total repair costs.");
	AR_Chat("/ar Threshold <number> -- " .. WHITE .."Sets the most your willing to pay for without being prompt.  If your total repair bill is less then your threshold and more than your min. then you'll automatically repair everything.");
	AR_Chat("/ar Prompts -- " .. WHITE .."This toggles showing prompts.  If prompts are disabled Auto Repair will still repair your stuff as long as you can afford it.");
	AR_Chat("/ar Enable -- " .. WHITE .."This turns AutoRepair on and off.");
	AR_Chat("/ar Verbose -- " .. WHITE .. "This toggles showing repair ammounts in the chat area after repair has been done.");
	AR_Chat("/ar SkipInv -- " .. WHITE .. "This toggles skipping inventory check/repair.  If enabled, AR will NOT check your inventory.");

   elseif (command == 'enable')		then AR_EnableHandler();
   elseif (command == 'mincost')	then AR_MinCostHandler(options);
   elseif (command == 'threshold')	then AR_ThresholdHandler(options);
   elseif (command == 'prompt')		then AR_PromptHandler();
   elseif (command == 'verbose')	then AR_VerboseHandler();
   elseif (command == 'skipinv')	then AR_SkipInvHandler();
   end

end

function AR_SkipInvHandler()
	if (AR_Save.skipInv) then
		AR_Save.skipInv = false;
		AR_Chat("Auto Repair will NOW check your inventory and offer to repair it.  Type /ar skipinv to turn this off.");
	else
		AR_Save.skipInv = true;
		AR_Chat("Auto Repair will NO LONGER check your inventory and offer to repair it.  Type /ar skipinv to turn this back on.");
	end
end

function AR_VerboseHandler()
	if (AR_Save.verbose) then
		AR_Save.verbose = false;
		AR_Chat("Auto Repair's verbose mode has been disabled.  Type /ar verbose to enable it.");
	else
		AR_Save.verbose = true;
		AR_Chat("Auto Repair's verbose mode has been enabled.  type /ar verbose to disable it.");
	end
end

function AR_PromptHandler()
	if (AR_Save.promptEnabled) then
		AR_Save.promptEnabled = false;
		AR_Chat("Auto Repair prompts have been disabled.  Type /ar prompt to enable them.");
		AR_Chat("Please note that this dosn't disable Auto Repair and if the ammount is affordable and over your minimal cost, your equipment will still be repaired.");
	else
		AR_Save.promptEnabled = true;
		AR_Chat("Auto Repair prompts have been enabled.  type /ar prompt to disable them.");
	end
end

function AR_EnableHandler()
	if (AR_Save.enabled) then
		AR_Save.enabled= false;
		AR_Chat("Auto Repair has been disabled.  Type /ar enable to turn it back on.");
	else
		AR_Save.enabled= true;
		AR_Chat("Auto Repair has been enabled.  type /ar enable to turn it off.");
	end
end


function AR_MinCostHandler(option)

   if(option == nil or option == "") then
		AR_Chat("AutoRepair: Min. Repair Cost: "..setAmountString(AR_Save.minCost)..".");
		AR_Chat("To Change MinCost Use:");		
		AR_Chat("/ar mincost <number>");		
		AR_Chat("<number> must be greater than Zero.");		
		AR_Chat("<number> is entered in copper.");	   
   else
	num = tonumber(option);
	if (num < 0) then
		AR_Chat("AutoRepair: Min. Repair Cost Set Error.");		
		AR_Chat("Correct Usage:");		
		AR_Chat("/ar mincost <number>");		
		AR_Chat("<number> must be greater than Zero.");		
		AR_Chat("<number> is entered in copper.");		
	else
		AR_Save.minCost = num;
		AR_Chat("AutoRepair: Min. Repair Cost Set To: "..setAmountString(AR_Save.minCost)..".");		
	end

   end

end

function AR_ThresholdHandler(option)

   if(option == nil or option == "") then
		AR_Chat("AutoRepair: Threshold Amount: "..setAmountString(AR_Save.costThreshold)..".");
		AR_Chat("To Change Threshold Use:");		
		AR_Chat("/ar threshold <number>");		
		AR_Chat("<number> must be greater than Zero.");		
		AR_Chat("<number> is entered in copper.");	   
   else
	num = tonumber(option);
	if (num < 0) then
		AR_Chat("AutoRepair: Threshold Set Error.");		
		AR_Chat("Correct Usage:");		
		AR_Chat("/ar threshold <number>");		
		AR_Chat("<number> must be greater than Zero.");		
		AR_Chat("<number> is entered in copper.");		
	else
		AR_Save.costThreshold = num;
		AR_Chat("AutoRepair: Threshold Amount Set To: "..setAmountString(AR_Save.costThreshold)..".");		

	end

   end

end

-- 
--	Repair Functions
--

function AR_RepairHandler(skip_equip)
	if (AR_Save.promptEnabled and CanMerchantRepair()) then		 
		local AR_EquipCost = GetRepairAllCost();
		local AR_InvCost = AR_GetInventoryCost();
		local AR_Funds = GetMoney();
		local AR_TotalCost = AR_EquipCost + AR_InvCost;
		
		local AR_Afford = AR_TotalCost < AR_Funds;
		local AR_UnderThreshold = AR_TotalCost < AR_Save.costThreshold;
		local AR_OverMin = AR_TotalCost > AR_Save.minCost;
		local AR_Needed = AR_TotalCost > 0;
		 
		if (AR_Afford and AR_UnderThreshold and AR_OverMin and AR_Needed) then
			AR_RepairEquipment();
			
			if (AR_Save.skipInv) then
				AR_TotalCost = AR_EquipCost;
			else
				AR_RepairInventory();	
			end
			return;
		end
		if (not skip_equip) then
			AR_Afford = AR_EquipCost < AR_Funds;
			AR_OverMin = AR_EquipCost > AR_Save.minCost;
			AR_Needed = AR_EquipCost > 0;
		 
			if (AR_Afford and AR_OverMin and AR_Needed) then
				AR_ShowEquipPrompt(AR_EquipCost);
				if (not AR_Save.skipInv) then
					AR_CB= AR_RepairHandler;
					AR_CBV = true;
					AR_CBT = 0;
				end
			end
		end

		if (AR_DiagOpen) then
			return;
		else
			AR_CB= nil;
			AR_CBV = nil;
			AR_CBT = 0;
		end
		 
		AR_Funds = GetMoney();
		AR_Afford = AR_InvCost < AR_Funds;
		AR_OverMin = AR_InvCost > AR_Save.minCost;
		AR_Needed = AR_InvCost > 0;
		AR_Wanted = not AR_Save.skipInv;

		if (AR_Afford and AR_OverMin and AR_Needed and AR_Wanted) then
			AR_ShowInvPrompt(AR_InvCost);
		end
		
	elseif (CanMerchantRepair()) then
		local AR_EquipCost = GetRepairAllCost();
		local AR_InvCost = AR_GetInventoryCost();
		local AR_Funds = GetMoney();
		local AR_TotalCost = AR_EquipCost + AR_InvCost;
		
		local AR_Afford = AR_TotalCost < AR_Funds;
		local AR_OverMin = AR_TotalCost > AR_Save.minCost;
		local AR_Needed = AR_TotalCost > 0;
		if (AR_Afford and AR_OverMin and AR_Needed) then
			AR_RepairEquipment();
			if (AR_Save.skipInv) then
				AR_TotalCost = AR_EquipCost;
			else
				AR_RepairInventory();					
			end
		end
	end 
end

function AR_OpenDiagToggle()
	if (AR_DiagOpen) then
		AR_DiagOpen = false;
	else
		AR_DiagOpen = true;
	end
	
end

function AR_ShowEquipPrompt(cost) 
	local AR_CostText = setAmountString(cost);	
	StaticPopupDialogs["REPAIR_EQUIP_BIND"] = {
		text = TEXT(STATUS_COLOR.."AutoRepair v"..AR_CurrentVersion.." (Kael Cycle)\n\n\nIt Will Cost "..AR_CostText.." To Fix Your Equipment.\n\nDo You Wish To Repair Your Equipment?"),
		button1 = TEXT(OKAY),
		button2 = TEXT(CANCEL),
		OnAccept = function()
			AR_RepairEquipment();
		end,
		OnShow = function()
			AR_OpenDiagToggle();
		end,
		OnHide = function()
			AR_OpenDiagToggle();
		end,
		showAlert = 1,
		timeout = 0,
		exclusive = 0,
		whileDead = 1,
		interruptCinematic = 1
	};
	PlaySound("QUESTADDED");
	StaticPopup_Show("REPAIR_EQUIP_BIND");
end

function AR_ShowInvPrompt(cost) 
	local AR_CostText = setAmountString(cost);	
	StaticPopupDialogs["REPAIR_INV_BIND"] = {
		text = TEXT(STATUS_COLOR.."AutoRepair v"..AR_CurrentVersion.." (Kael Cycle)\n\n\nIt Will Cost "..AR_CostText.." To Fix The Items In Your Inventory.\n\nDo You Wish To Repair Your Items?"),
		button1 = TEXT(OKAY),
		button2 = TEXT(CANCEL),
		OnAccept = function()
			AR_RepairInventory();
		end,
		OnShow = function()
			AR_OpenDiagToggle();
		end,
		OnHide = function()
			AR_OpenDiagToggle();
		end,
		showAlert = 1,
		timeout = 0,
		exclusive = 0,
		whileDead = 1,
		interruptCinematic = 1
	};
	PlaySound("QUESTADDED");
	StaticPopup_Show("REPAIR_INV_BIND");
end

function AR_GetInventoryCost()
	
	local AR_InventoryCost = 0;

	for bag = 0,4,1 do	
		for slot = 1, GetContainerNumSlots(bag) , 1 do
			local hasCooldown, repairCost = GameTooltip:SetBagItem(bag,slot);
			if (repairCost) then
				AR_InventoryCost = AR_InventoryCost + repairCost;
			end
		end
	end

	return AR_InventoryCost;
end

function AR_RepairEquipment()
	RepairAllItems();
	if (AR_Save.verbose) then
		local cost = GetRepairAllCost();
		AR_Chat("Your repair bill for work done to your equipment was: " .. setAmountString(cost) .. ".");
		
	end
end

function AR_RepairInventory()
	ShowRepairCursor();
	for bag = 0,4,1 do	
		for slot = 1, GetContainerNumSlots(bag) , 1 do
			local hasCooldown, repairCost = GameTooltip:SetBagItem(bag,slot);
			if (repairCost and repairCost > 0) then
				UseContainerItem(bag,slot);
			end
		end
	end
	HideRepairCursor();
	if (AR_Save.verbose) then
		local cost = AR_GetInventoryCost();
		AR_Chat("Your repair bill for work done to your inventory was: " .. setAmountString(cost) .. ".");
		
	end
end
