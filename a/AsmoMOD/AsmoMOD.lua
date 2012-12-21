--AsmoMOD made by Asmodius, Arthas Server
--All rights reserved.

-- Declare Needed Variables
local AsmoMOD_Color = "|c000566FF";
local AsmoMOD_ColorR = "|c00FF0000";
local ResetGroup = 0;
local Reseter;
local didWotf = 0;
local RipID = 0;
local RipAction = 0;
local opID = 0;
local opAction = 0;
local WotfID = 0;
local healID = 0;
local LightID = 0;
local touchID = 0;
local feignID = 0;
local trapID = 0;
local nsID = 1;
local inCombat = false;
local herbID = 0;
local mineID = 0;
local nshealme = 0;
local SaveMe = 0;
local herbmineme = 0;
local nslightning = 0;
local feigntrap = 0;
local justenabled = 0;

-- Show the Option Menu
function AsmoMOD_showMenu()
	PlaySound("igMainMenuOpen");
	AsmoMODOptions:Show();
end

-- Load Event
function AsmoMOD_OnLoad()

	this:RegisterEvent("PLAYER_ENTERING_WORLD")
	this:RegisterEvent("PLAYER_DEAD");
	this:RegisterEvent("UPDATE_BATTLEFIELD_STATUS");
        this:RegisterEvent("MERCHANT_SHOW");
	this:RegisterEvent("RESURRECT_REQUEST");
	this:RegisterEvent("CONFIRM_SUMMON");
	this:RegisterEvent("PARTY_INVITE_REQUEST");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("PLAYER_CONTROL_LOST");
	this:RegisterEvent("PLAYER_CONTROL_GAINED");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("PLAYER_UNGHOST");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	AsmoMOD_Chat("AsmoMOD v1.82 loaded.");
	
	if ( AsmoMOD_Save == nil ) then
		AsmoMOD_Save = {};
		AsmoMOD_Save.bgrelenabled = true;
		AsmoMOD_Save.bgjoinenabled = true;
		AsmoMOD_Save.repairenabled = true;
		AsmoMOD_Save.rezenabled = true;
		AsmoMOD_Save.summonenabled = true;
		AsmoMOD_Save.groupenabled = true;
		AsmoMOD_Save.trinketenabled = true;
		AsmoMOD_Save.riposteenabled = false;
		AsmoMOD_Save.nsenabled = false;
		AsmoMOD_Save.lightenabled = false;
		AsmoMOD_Save.executeenabled = false;
		AsmoMOD_Save.overpowerenabled = false;
		AsmoMOD_Save.conserveenabled = false;
		AsmoMOD_Save.herbmineenabled = false;
		AsmoMOD_Save.nspercent = 20;
		AsmoMOD_Save.conservepercent = 80;
	end
	
	SLASH_Asmo1 = "/Asmo";
	SlashCmdList["Asmo"] = AsmoMOD_showMenu;

	SLASH_Asinvite1 = "/Asinvite";
	SlashCmdList["Asinvite"] = function(msg)
		Asmo_HandleInvite(msg);
	end

	SLASH_nsheal1 = "/nsheal";
	SlashCmdList["nsheal"] = AsmoMOD_nsheal;

	SLASH_nslight1 = "/nslight";
	SlashCmdList["nslight"] = AsmoMOD_nslight;

	SLASH_feigntrap1 = "/feigntrap";
	SlashCmdList["feigntrap"] = AsmoMOD_feigntrap;

	SLASH_timer1 = "/timer";
	SlashCmdList["timer"] = ExecuteCheck;

	-- Add my options frame to the global UI panel list
	UIPanelWindows["AsmoMODOptions"] = {area = "center", pushable = 0};
end	

-- Event Handler	
function AsmoMOD_OnEvent(event)
	
	-- Load Base Variables and Auto-Cast find herbs/minerals
	if(event == "PLAYER_ENTERING_WORLD") then
		AsmoMOD_Load();
		if(AsmoMOD_Save.herbmineenabled) then
			herbmineme = 1;
		end
	end

	-- Determine if player is in combat
	if (event == "PLAYER_REGEN_ENABLED") then 
		inCombat = false;
	end
	if (event == "PLAYER_REGEN_DISABLED") then 
		inCombat = true;
	end

	-- Auto-release to the GY
	if ( event == "PLAYER_DEAD" ) then
		AsmoMOD_Release();
	end

	-- Auto-join the BG when its your turn
	if ( event == "UPDATE_BATTLEFIELD_STATUS" ) then
		AsmoMOD_bgJoin();
	end

	-- Auto-Repair when you see a merchant
	if ( event == "MERCHANT_SHOW") then
		AsmoMOD_RepairInventory();
		AsmoMOD_RepairEquipment();
	end		

	-- Auto-Ressurect
	if ( event == "RESURRECT_REQUEST" ) then
		AsmoMOD_Resurrect();
	end
	
	-- Auto-Summon
	if ( event == "CONFIRM_SUMMON" ) then
		AsmoMOD_Summon();
	end

	-- Auto-Group
	if (event == "PARTY_INVITE_REQUEST") then
		AsmoMOD_Group();
	end

	-- Reset-Group
	if (event == "PARTY_MEMBERS_CHANGED") then
		if(ResetGroup == 1) then
			ResetGroup = 2;
			return;
		end
		if(ResetGroup == 2) then
			PromoteByName(Reseter);
  			LeaveParty();
			ResetGroup = 0;
		end
	end

	-- Restore Control Fear
	if (event == "PLAYER_CONTROL_GAINED") then 
		SaveMe = 0;
	end	

	-- Auto-Trinket Fear Detect
	if (event == "PLAYER_CONTROL_LOST") then 
		if(not GetBattlefieldWinner()) then
			SaveMe = 1;
		end
	end

	-- Wotf Succeed
	if(event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS") then
		if(arg1 == "You gain Will of the Forsaken.") then
			didWotf = 0;
		end
	end
	
	-- Auto-Trinket Charm Detect
	if(event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE") then
		if(arg1 == "You are afflicted by Seduction.") then
			SaveMe = 1;
		elseif(arg1 == "You are afflicted by Repentence.") then
			SaveMe = 1;
		elseif(arg1 == "You are afflicted by Reckless Charge.") then
			SaveMe = 1;
		elseif(arg1 == "You are afflicted by Intimidating Shout.") then
			SaveMe = 1;
		end
	end
		
	-- Restore Control Charm
	if(event == "CHAT_MSG_SPELL_AURA_GONE_SELF") then
		if(arg1 == "Seduction fades from you.") then
			SaveMe = 0;
		elseif(arg1 == "Repentence fades from you.") then
			SaveMe = 0;
		elseif(arg1 == "Reckless Charge fades from you.") then
			SaveMe = 0;
		elseif(arg1 == "Intimidating Shout fades from you.") then
			SaveMe = 0;
		end
	end

	-- Auto-NSheal
	if((event == "UNIT_HEALTH") and AsmoMOD_Save.nsenabled) then
		--Check to see if the player is below nspercent
 		local ppercent;
		ppercent = (UnitHealth("player") / UnitHealthMax("player")) * 100;
		if(ppercent <= AsmoMOD_Save.nspercent) then
			nshealme = 1;
		else
			nshealme = 0;
		end
	end

	-- Auto-Herb/Mine
	if((event == "PLAYER_UNGHOST") and AsmoMOD_Save.herbmineenabled) then
		herbmineme = 1;
	end
end

-- Load Needed Variables
function AsmoMOD_Load()

	--If users switching between accounts, protect nill errors
	if ( AsmoMOD_Save == nil ) then
		AsmoMOD_Save = {};
		AsmoMOD_Save.bgrelenabled = true;
		AsmoMOD_Save.bgjoinenabled = true;
		AsmoMOD_Save.repairenabled = true;
		AsmoMOD_Save.rezenabled = true;
		AsmoMOD_Save.summonenabled = true;
		AsmoMOD_Save.groupenabled = true;
		AsmoMOD_Save.trinketenabled = true;
		AsmoMOD_Save.riposteenabled = false;
		AsmoMOD_Save.overpowerenabled = false;
		AsmoMOD_Save.nsenabled = false;
		AsmoMOD_Save.lightenabled = false;
		AsmoMOD_Save.executeenabled = false;
		AsmoMOD_Save.conserveenabled = false;
		AsmoMOD_Save.herbmineenabled = false;
		AsmoMOD_Save.nspercent = 20;
		AsmoMOD_Save.conservepercent = 80;
	end

	-- Find all spell IDs
	local a = 1
	while true do
		local spellName, spellRank = GetSpellName(a, BOOKTYPE_SPELL)
		if not spellName then
      			do break end
   		end

		-- Find Riposte ID
		if (spellName == "Riposte") then
			texture = GetSpellTexture(a, BOOKTYPE_SPELL)
			RipID = a
			-- Find Action Bar Number for Riposte
			local j;
			for j=1,72, 1 do
				if ( HasAction(j) ) then
					local actiontexture = GetActionTexture(j);
					if ( actiontexture == texture ) then
						RipAction = j
						do break end
					end	
				end
			end
		end

		-- Find Overpower ID
		if (spellName == "Overpower") then
			texture = GetSpellTexture(a, BOOKTYPE_SPELL)
			opID = a
			-- Find Action Bar Number for Overpower
			local j;
			for j=1,108, 1 do
				if ( HasAction(j) ) then
					local actiontexture = GetActionTexture(j);
					if ( actiontexture == texture ) then
						opAction = j
						do break end
					end	
				end
			end
		end	
		
		-- Find Will of the Forsaken
		if (spellName == "Will of the Forsaken") then
			WotfID = a
		end

		-- Find Healing Wave ID
		if (spellName == "Healing Wave") then
			healID = a
		end

		-- Find Chain Lightning ID
		if (spellNamed == "Chain Lightning") then
			LightID = a
		end

		--Find Healing Touch
		if (spellName == "Healing Touch") then
			touchID = a	
		end
	
		-- Find NS for Shaman and Druid
		if (spellName == "Nature's Swiftness") then
			nsID = a
		end

		-- Find Feign ID
		if (spellName == "Feign Death") then
			feignID = a
		end

		-- Find Trap ID
		if (spellName == "Freezing Trap") then
			trapID = a
		end

		-- Find Herb ID
		if (spellName == "Find Herbs") then
			herbID = a
		end

		-- Find Minerals ID
		if (spellName == "Find Minerals") then
			mineID = a
		end

		a = a + 1;
	end

	-- Correct options frame to saved values
	if(AsmoMOD_Save.bgrelenabled) then
		bgrelenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.bgjoinenabled) then
		bgjoinenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.rezenabled) then
		RessEnabled:SetChecked(1);
	end
	if(AsmoMOD_Save.summonenabled) then
		SummonEnabled:SetChecked(1);
	end
	if(AsmoMOD_Save.repairenabled) then
		repairenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.groupenabled) then
		groupenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.trinketenabled) then
		trinketenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.riposteenabled) then
		riposteenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.nsenabled) then
		nshealenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.executeenabled) then
		executeenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.conserveenabled) then
		conserveenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.herbmineenabled) then
		herbmineenabled:SetChecked(1);
	end
	if(AsmoMOD_Save.overpowerenabled) then
		openabled:SetChecked(1);
	end
	nshealpercentage:SetValue(AsmoMOD_Save.nspercent);
	conservepercentage:SetValue(AsmoMOD_Save.conservepercent);
end

-- Cast spells
function ExecuteCheck()

	-- Auto-PvP Trinket and WoTF
	if ((AsmoMOD_Save.trinketenabled) and (UnitOnTaxi("player") ~= 1)) then

		-- Use WoTF if it is active
		if (UnitRace("player") == "Undead") then
			local duration;
			if((SaveMe == 1) and (didWotf == 0)) then
				duration = GetSpellCooldown(WotfID, 1);
				if(duration == 0) then 
					CastSpell(WotfID, BOOKTYPE_SPELL);
					didWotf = 1;
					return;
				end
			end
		end

		didWotf = 0;

		-- Use PvP Trinket if it is equipped and active
		if(SaveMe == 1) then
			myTrinket0 =  GetInventoryItemLink("player", GetInventorySlotInfo("Trinket0Slot"))
			myTrinket1 =  GetInventoryItemLink("player", GetInventorySlotInfo("Trinket1Slot"))

			if (myTrinket0 == nil) then myTrinket0 = "empty" end
			if (myTrinket1 == nil) then myTrinket1 = "empty" end
			
			if ((string.find(myTrinket0, "Insignia of the Horde") ~= nil) or (string.find(myTrinket0, "Insignia of the Alliance") ~= nil)) then
				myTrinketUse = GetInventorySlotInfo("Trinket0Slot")
			elseif ((string.find(myTrinket1, "Insignia of the Horde") ~= nil) or (string.find(myTrinket1, "Insignia of the Alliance") ~= nil)) then
				myTrinketUse = GetInventorySlotInfo("Trinket1Slot")
			else
				myTrinketUse = nil
			end
			if(myTrinketUse ~= nil) then
				UseInventoryItem(myTrinketUse);
			end
		end
	end

	-- Auto-Riposte
	if(AsmoMOD_Save.riposteenabled and (UnitClass("player") == "Rogue")) then
		duration = GetSpellCooldown(RipID, 1);
		if(IsUsableAction(RipAction)) then
			if(duration == 0) then 
				CastSpellByName("Riposte");
			end
		end
	end

	-- Auto-Overpower
	if(AsmoMOD_Save.overpowerenabled and (UnitClass("player") == "Warrior")) then
		duration = GetSpellCooldown(opID, 1);
		if(IsUsableAction(opAction)) then
			if(duration == 0) then 
				CastSpellByName("Overpower(Rank 4)");
			end
		end
	end

	-- Auto-Execute
	if((AsmoMOD_Save.executeenabled) and (UnitClass("player") == "Warrior")) then
		--Check to see if the target is at 20% or less
		local tpercent;
		tpercent = (UnitHealth("target") / UnitHealthMax("target")) * 100;
		if(tpercent <= 20) then
			if(UnitMana("player") >= 15) then 
				CastSpellByName("Execute(Rank 5)");
			end
		end
	end

	-- Auto-NSheal
	if((nshealme >= 1) and (AsmoMOD_Save.nsenabled)) then
		duration = GetSpellCooldown(nsID, 1);
		if(duration == 0) then 
			CastSpellByName("Nature's Swiftness");
		end
		SpellStopCasting();
		local i = 1;
		local nsup = false;
		while true do
			buff = UnitBuff("player", i);
			if not buff then
      				do break end;
   			end
			if(string.find(buff, "Spell_Nature_RavenForm") ~= nil) then
				nsup = true;
			end
			i = i + 1;
		end
		if(nsup == false) then
			return;
		end
		if((UnitClass("player") == "Druid")) then
			duration = GetSpellCooldown(touchID, 1);
			if(duration == 0) then 
				nshealme = 2;
				if(UnitIsEnemy("target", "player")) then
					TargetUnit("player");
					CastSpellByName("Healing Touch(Rank 10)");
					TargetLastEnemy();
					if (UnitIsDead("target") == 1) or ( UnitExists("target") ~= 1) then
						TargetNearestEnemy()
					end
				else
					TargetUnit("player");
					CastSpellByName("Healing Touch(Rank 10)");
				end
			end
		elseif((UnitClass("player") == "Shaman")) then
			duration = GetSpellCooldown(healID, 1);
			if(duration == 0) then 
				nshealme = 2;
				if(UnitIsEnemy("target", "player")) then
					TargetUnit("player");
					CastSpellByName("Healing Wave(Rank 9)");
					TargetLastEnemy();
					if (UnitIsDead("target") == 1) or ( UnitExists("target") ~= 1) then
						TargetNearestEnemy()
					end
				else
					TargetUnit("player");
					CastSpellByName("Healing Wave(Rank 9)");
				end
			end
		end
	end	

	-- Mana Conserve
	if(AsmoMOD_Save.conserveenabled and UnitIsFriend("target", "player")) then		
		local cpercent;
		cpercent = (UnitHealth("target") / UnitHealthMax("target")) * 100;
		if(cpercent >= AsmoMOD_Save.conservepercent) then
			SpellStopCasting();
		end
	end

	-- Auto-Find herbs/minerals
	if(AsmoMOD_Save.herbmineenabled and herbmineme == 1) then
		local _, _, instanceID = GetBattlefieldStatus(1);
		if ( instanceID == 0 ) and (not UnitOnTaxi("player")) and (not UnitIsDeadOrGhost("player")) and (not inCombat)  then
			if(herbID ~= 0) then
				CastSpellByName("Find Herbs");
			end
			if(mineID ~= 0) then
				CastSpellByName("Find Minerals");
			end
			herbmineme = 0;
		end
	end
end

--Invite Handler
function Asmo_HandleInvite(msg)
	local disabled = 0;
	if ( msg ) then
		msg = string.lower(msg);
	end

	Reseter = msg;
	InviteByName(msg);
	ResetGroup = 1;
end

-- Various Toggle Functions
function AsmoMOD_RezToggle()
	if ( AsmoMOD_Save.rezenabled ) then
		AsmoMOD_Save.rezenabled = false;
		AsmoMOD_ChatR("Auto Ressurect has been disabled.");
	else
		AsmoMOD_Save.rezenabled = true;
		AsmoMOD_Chat("Auto Ressurect has been enabled.");
	end
end

function AsmoMOD_SummonToggle()
	if ( AsmoMOD_Save.summonenabled ) then
		AsmoMOD_Save.summonenabled = false;
		AsmoMOD_ChatR("Auto Summon has been disabled.");
	else
		AsmoMOD_Save.summonenabled = true;
		AsmoMOD_Chat("Auto Summon has been enabled.");
	end
end

function AsmoMOD_bgreltoggle()
	if ( AsmoMOD_Save.bgrelenabled ) then
		AsmoMOD_Save.bgrelenabled = false;
		AsmoMOD_ChatR("Auto BG Release has been disabled.");
	else
		AsmoMOD_Save.bgrelenabled = true;
		AsmoMOD_Chat("Auto BG Release has been enabled.");
	end
end


function AsmoMOD_bgjointoggle()
	if ( AsmoMOD_Save.bgjoinenabled ) then
		AsmoMOD_Save.bgjoinenabled = false;
		AsmoMOD_ChatR("Auto BG Join has been disabled.");
	else
		AsmoMOD_Save.bgjoinenabled = true;
		AsmoMOD_Chat("Auto BG Join has been enabled.");
	end
end

function AsmoMOD_repairtoggle()
	if ( AsmoMOD_Save.repairenabled ) then
		AsmoMOD_Save.repairenabled = false;
		AsmoMOD_ChatR("Auto Repair has been disabled.");
	else
		AsmoMOD_Save.repairenabled = true;
		AsmoMOD_Chat("Auto Repair has been enabled.");
	end
end

function AsmoMOD_grouptoggle()
	if ( AsmoMOD_Save.groupenabled ) then
		AsmoMOD_Save.groupenabled = false;
		AsmoMOD_ChatR("Auto-accept invites has been disabled.");
	else
		AsmoMOD_Save.groupenabled = true;
		AsmoMOD_Chat("Auto-accept invites has been enabled.");
	end
end

function AsmoMOD_trinkettoggle()
	if ( AsmoMOD_Save.trinketenabled ) then
		AsmoMOD_Save.trinketenabled = false;
		AsmoMOD_ChatR("Auto-use of the PvP trinket has been disabled.");
	else
		AsmoMOD_Save.trinketenabled = true;
		AsmoMOD_Chat("Auto-use of the PvP trinket has been enabled.");
	end
end

function AsmoMOD_ripostetoggle()
	if ( AsmoMOD_Save.riposteenabled ) then
		AsmoMOD_Save.riposteenabled = false;
		AsmoMOD_ChatR("Auto-use of riposte has been disabled.");
	else
		AsmoMOD_Save.riposteenabled = true;
		AsmoMOD_Chat("Auto-use of riposte has been enabled.");
		AsmoMOD_Load();
	end
end

function AsmoMOD_executetoggle()
	if ( AsmoMOD_Save.executeenabled ) then
		AsmoMOD_Save.executeenabled = false;
		AsmoMOD_ChatR("Auto-use of execute has been disabled.");
	else
		AsmoMOD_Save.executeenabled = true;
		AsmoMOD_Chat("Auto-use of execute has been enabled.");
		AsmoMOD_Load();
	end
end

function AsmoMOD_nshealtoggle()
	if ( AsmoMOD_Save.nsenabled ) then
		AsmoMOD_Save.nsenabled = false;
		AsmoMOD_ChatR("Auto-use of nsheal has been disabled.");
	else
		AsmoMOD_Save.nsenabled = true;
		AsmoMOD_Chat("Auto-use of nsheal has been enabled.");
		AsmoMOD_Load();
	end
end

function AsmoMOD_conservetoggle()
	if ( AsmoMOD_Save.conserveenabled ) then
		AsmoMOD_Save.conserveenabled = false;
		AsmoMOD_ChatR("Auto-cancelling of heals has been disabled.");
	else
		AsmoMOD_Save.conserveenabled = true;
		AsmoMOD_Chat("Auto-cancelling of heals has been enabled.");
		AsmoMOD_Load();
	end
end

function AsmoMOD_herbminetoggle()
	if ( AsmoMOD_Save.herbmineenabled ) then
		AsmoMOD_Save.herbmineenabled = false;
		AsmoMOD_ChatR("Auto-casting of find herbs/minerals has been disabled.");
	else
		AsmoMOD_Save.herbmineenabled = true;
		AsmoMOD_Chat("Auto-casting of find herbs/minerals has been enabled.");
		AsmoMOD_Load();
	end
end

function AsmoMOD_overpowertoggle()
	if ( AsmoMOD_Save.overpowerenabled ) then
		AsmoMOD_Save.overpowerenabled = false;
		AsmoMOD_ChatR("Auto-casting of overpower has been disabled.");
	else
		AsmoMOD_Save.overpowerenabled = true;
		AsmoMOD_Chat("Auto-casting of overpower has been enabled.");
		AsmoMOD_Load();
	end
end

-- Auto-Release Implimentation
function AsmoMOD_Release()
	if( AsmoMOD_Save.bgrelenabled ) then
	local _, _, instanceID = GetBattlefieldStatus(1);
		if ( instanceID ~= 0 ) then
			RepopMe();
		end
		return;
	end
end

-- Auto-Join BG Implimentation
function AsmoMOD_bgJoin()
	if( AsmoMOD_Save.bgjoinenabled ) then
	for i=1, MAX_BATTLEFIELD_QUEUES do
		local status, _, _ = GetBattlefieldStatus(i);
			if (status == "confirm") then
				PlaySoundFile("Sound\\Doodad\\BellTollAlliance.wav");
				AcceptBattlefieldPort(i, 1);
				getglobal("StaticPopup1"):Hide();
			end	
		end
	end
end

-- Auto-Ressurect Implimentation
function AsmoMOD_Resurrect()
	if ( AsmoMOD_Save.rezenabled ) then
		AcceptResurrect();
		getglobal("StaticPopup1"):Hide();
	else
		AsmoMOD_ChatR("Auto Resurrect is set to off. Use the options menu to change this.");
	end
end

-- Auto-Repair Equipment Implimentation
function AsmoMOD_RepairEquipment()
	if( (AsmoMOD_Save.repairenabled) and (CanMerchantRepair()) ) then
		RepairAllItems();	
	end
end

-- Auto-Repair Inventory Implimentation
function AsmoMOD_RepairInventory()
	if( (AsmoMOD_Save.repairenabled) and (CanMerchantRepair()) ) then
		local total = GetRepairAllCost();
		total = total + AsmoMOD_GetInventoryCost();
		total = total / 10000;
		AsmoMOD_Chat("All items repaired. Total Cost: " .. total .. " gold.");

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
	end
end

-- Get Cost of Repairing Inventory
function AsmoMOD_GetInventoryCost()
	
	local AsmoMOD_InventoryCost = 0;

	for bag = 0,4,1 do	
		for slot = 1, GetContainerNumSlots(bag) , 1 do
			local hasCooldown, repairCost = GameTooltip:SetBagItem(bag,slot);
			if (repairCost) then
				AsmoMOD_InventoryCost = AsmoMOD_InventoryCost + repairCost;
			end
		end
	end

	return AsmoMOD_InventoryCost;
end

-- Auto-Join Group Implimentation
function AsmoMOD_Group()
	if( AsmoMOD_Save.groupenabled ) then
		AcceptGroup();
		AsmoMOD_HideWindow("PARTY_INVITE");
	end
end

-- Automatic Accept Summon Implimentation
function AsmoMOD_Summon()
	if ( AsmoMOD_Save.summonenabled ) then
		ConfirmSummon();
		getglobal("StaticPopup1"):Hide();
	else
		AsmoMOD_ChatR("Auto Summon is set to off. Use the options menu to change this.");
	end
end

-- NS-Heal Start
function AsmoMOD_nsheal()
	duration = GetSpellCooldown(nsID, 1);
	if(duration == 0) then 
		CastSpellByName("Nature's Swiftness")
	end
	SpellStopCasting();
	if((UnitClass("player") == "Druid")) then
		duration = GetSpellCooldown(touchID, 1);
		if(duration == 0) then 
			if(UnitIsEnemy("target", "player")) then
				TargetUnit("player");
				CastSpellByName("Healing Touch(Rank 10)");
				TargetLastEnemy();
				if (UnitIsDead("target") == 1) or ( UnitExists("target") ~= 1) then
					TargetNearestEnemy()
				end
			elseif(UnitIsFriend("target", "player")) then
				CastSpellByName("Healing Touch(Rank 10)");
			else
				TargetUnit("player");
				CastSpellByName("Healing Touch(Rank 10)");
			end
		end
	elseif((UnitClass("player") == "Shaman")) then
		duration = GetSpellCooldown(healID, 1);
		if(duration == 0) then 
			if(UnitIsEnemy("target", "player")) then
				TargetUnit("player");
				CastSpellByName("Healing Wave(Rank 9)");
				TargetLastEnemy();
				if (UnitIsDead("target") == 1) or ( UnitExists("target") ~= 1) then
					TargetNearestEnemy()
				end
			elseif(UnitIsFriend("target", "player")) then
				CastSpellByName("Healing Wave(Rank 9)");
			else
				TargetUnit("player");
				CastSpellByName("Healing Wave(Rank 9)");
			end
		end
	end
end

-- NS Lightning Start
function AsmoMOD_nslight()
	duration = GetSpellCooldown(nsID, 1);
	if(duration == 0) then 
		CastSpellByName("Nature's Swiftness")
		nslightning = 1;
	end
	SpellStopCasting();
	duration = GetSpellCooldown(LightID, 1);
	if(duration == 0) then 
		if(nslightning == 2) then
			nslightning = 0;
			return;
		end
		nslightning = 2;
		if(UnitIsEnemy("target", "player")) then
			CastSpellByName("Chain Lightning(Rank 4)");
		else
			TargetNearestEnemy();
			CastSpellByName("Chain Lightning(Rank 4)");
		end
	end
end

-- Feign-Trap Start
function AsmoMOD_feigntrap()
	PetFollow();
	duration = GetSpellCooldown(feignID, 1);
	if(duration == 0) then 
		CastSpellByName("Feign Death")
		feigntrap = 1;
	end
	SpellStopCasting();
	duration = GetSpellCooldown(trapID, 1);
	if(duration == 0) then 
		if(feigntrap == 2) then
			feigntrap = 0;
			return;
		end
		feigntrap = 2;
		CastSpellByName("Freezing Trap(Rank 3)");
	end
end

-- Hide Popupbox Implimentation
function AsmoMOD_HideWindow(windowToHide)
	local windowIndex
		for windowIndex = 1, STATICPOPUP_NUMDIALOGS do
			local currentFrame = getglobal("StaticPopup" .. windowIndex)
				if currentFrame:IsVisible() and (currentFrame.which == windowToHide) then
					currentFrame:Hide();
				end
		end
end

-- Basic Text send function
function AsmoMOD_Chat(text)
		DEFAULT_CHAT_FRAME:AddMessage(AsmoMOD_Color..text);
end

function AsmoMOD_ChatR(text)
	DEFAULT_CHAT_FRAME:AddMessage(AsmoMOD_ColorR..text);
end

--Options Functions
function AsmoMOD_PercentageChanged()
	AsmoMOD_Save.nspercent = this:GetValue();
	nstext:SetText("NSHeal Percent: ".. AsmoMOD_Save.nspercent .. "%");
end

function AsmoMOD_ConserveChanged()
	AsmoMOD_Save.conservepercent = this:GetValue();
	conservetext:SetText("Conserve Percent: ".. AsmoMOD_Save.conservepercent .. "%");
end