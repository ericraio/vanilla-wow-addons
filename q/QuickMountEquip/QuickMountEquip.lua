--[[
 QuickMountEquip
    By Robert Jenkins (Merrem@Perenolde / Flarin@Sen'Jin)
  
  Automates equipping of items when mounting/dismounting

	UI based on Totem Stomper by AlexYoshi
  
]]
QME_Registered = nil;
QuickMount_Version = "2.20";

QuickMount_ConfigMap = nil;
QuickMount_Disabled = false;

-- Current Player information...
QMCP = "";

QuickMount_SavedBagFunc = nil;
QuickMount_SavedInvFunc = nil;
QuickMount_SavedUseFunc = nil;

local combat_flag = false;
local attack_button = 0;

local MOUNT = 1;
local UNMOUNT = 2;
local QM_SET_COUNT = 2;
local QM_SET_SIZE = 5;
local IGNORE_SWITCH = false;

local QM_NIL = -100;

local QuickMount_CurrentID = QM_NIL;
local QuickMount_CurrentBag = QM_NIL;
local QuickMount_CurrentSlot = QM_NIL;
local QuickMount_CurrentName = "";
local QuickMount_CurrentTexture = "";

local QuickMount_AutoDetect = false;

function QuickMount_RegisterEvents()
	this:RegisterEvent("VARIABLES_LOADED")		-- configuration loading
	if not Fetch_Frame then
		this:RegisterEvent("UNIT_NAME_UPDATE")	-- configuration loading
	end
	this:RegisterEvent("PLAYER_AURAS_CHANGED")	-- mount buff check
	this:RegisterEvent("ACTIONBAR_UPDATE_USABLE")	-- flight path check
	this:RegisterEvent("PLAYER_REGEN_DISABLED")	-- combat check
	this:RegisterEvent("PLAYER_REGEN_ENABLED")	-- combat check
	this:RegisterEvent("DELETE_ITEM_CONFIRM")		-- delete check
end

function QuickMount_UnregisterEvents()
	this:UnregisterEvent("PLAYER_AURAS_CHANGED")    -- mount buff check
	this:UnregisterEvent("ACTIONBAR_UPDATE_USABLE") -- flight path check
	this:UnregisterEvent("PLAYER_REGEN_DISABLED")   -- combat check
	this:UnregisterEvent("PLAYER_REGEN_ENABLED")    -- combat check
end

function QuickMount_ShowUsage()
	QM_Print("/mountequip on | off | quiet | verbose | flightpoint [on/off] | auto-reconfig [on/off] | config | status | load profileName | save profileName | delete profileName | profiles | detect\n");
end

function QuickMount_Toggle()
	QuickMount_Config("config");
end

-- Show/hide the Main Frame
function QuickMount_Config(msg)
	if QuickMount_CheckPlayer() == false then
		QM_Print("Sorry, QuickMountEquip variables aren't loaded yet.");
		return;
	end
	if msg == nil or msg == "" then
		msg = "config";
	end

	local args = {n=0}
	local function helper(word) table.insert(args, word) end
	string.gsub(msg, "[_%w]+", helper);

	if args[1] == 'off' then
		QuickMount_Disabled = true;
		QM_Print("QuickMountEquip disabled.");
	elseif args[1] == 'on' then
		QuickMount_Disabled = false;
		QM_Print("QuickMountEquip enabled.");
	elseif args[1] == 'quiet' then
		QuickMount_ConfigMap[QMCP]["Quiet"] = true;
		QM_Print("QuickMountEquip verbosity off.");
	elseif args[1] == 'verbose' then
		QuickMount_ConfigMap[QMCP]["Quiet"] = false;
		QM_Print("QuickMountEquip verbosity on.");
	elseif args[1] == 'flightpoint' or args[1] == 'flightpath' then
		if ( args[2] == nil or args[2] == '' or ( args[2] ~= 'on' and args[2] ~= 'off' ) ) then
			QM_Print("Do you want to turn flightpoint checking on or off?");
		else
			if args[2] == 'on' then
				QuickMount_ConfigMap[QMCP]["FlightPoint"] = true;
				QM_Print("QuickMountEquip Flight Point checking on.");
			else
				QuickMount_ConfigMap[QMCP]["FlightPoint"] = false;
				QM_Print("QuickMountEquip Flight Point checking off.");
			end
		end
	elseif args[1] == 'save' then
		if args[2] == nil or args[2] == '' then
			QM_Print("No profile name specified.");
		else
			QuickMount_ConfigMap["Profile" .. args[2]] = QuickMount_ConfigMap[QMCP];
			QM_Print("QuickMountEquip profile '" .. args[2] .. "' saved.");
		end
      elseif args[1] == 'load' then
		if args[2] == nil or args[2] == '' then
			QM_Print("No profile name specified.");
		else
			if QuickMount_ConfigMap["Profile" .. args[2]] then
				local last_action = QuickMount_ConfigMap[QMCP]["last_action"];
				QuickMount_ConfigMap[QMCP] = QuickMount_ConfigMap["Profile" .. args[2]];
				QuickMount_ConfigMap[QMCP]["last_action"] = last_action;
				QM_Print("QuickMountEquip profile '" .. args[2] .. "' loaded.");
			else
				QM_Print("QuickMountEquip profile '" .. args[2] .. "' not found!");
			end
		end
      elseif args[1] == 'delete' then
		if args[2] == nil or args[2] == '' then
			QM_Print("No profile name specified.");
		else
			if QuickMount_ConfigMap["Profile" .. args[2]] then
				QuickMount_ConfigMap["Profile" .. args[2]] = nil;
				QM_Print("QuickMountEquip profile '" .. args[2] .. "' deleted.");
			else
				QM_Print("QuickMountEquip profile '" .. args[2] .. "' not found!");
			end
		end
	elseif args[1] == 'profiles' then
		QM_Print("Profiles:");
		table.foreach(QuickMount_ConfigMap, function(k,v) if string.find(k, "Profile") then QM_Print(string.gsub(k, "Profile", '')) end end);
	elseif args[1] == 'detect' then
		if args[2] == nil or args[2] == '' then
			QM_Print("** Experimental / Advanced **");
			QM_Print("Do '/mountequip detect now' to attempt to detect the name of your mount. You should be unmounted and have zero buffs when you attempt this.");
			QM_Print("Then do '/mountequip detect on' to use the detected mount when mounting");
			QM_Print("Or '/mountequip detect off' to turn off the use of the detected mount");
			QM_Print("Or '/mountequip detect clear' to clear the detected setting completely");
			QM_Print("NOTE: If doing this fixes your mounting problem, please let the author know, so it can be automatically included in the next release.");
		elseif args[2] == 'now' then
			QM_Print("This will attempt to detect the name of your mount. The next buff that appears will be assumed to be your mount. This works best if you start out with zero buffs. You should mount up NOW.");
			QuickMount_AutoDetect = true;
			QuickMount_ConfigMap[QMCP]["DetectedIcon"] = nil;
			QuickMount_ConfigMap[QMCP]["UseDetectedIcon"] = false;
		elseif args[2] == 'on' then
			if QuickMount_ConfigMap[QMCP]["DetectedIcon"] ~= nil then
				QuickMount_ConfigMap[QMCP]["UseDetectedIcon"] = true;
				QM_Print("Auto-Detected mount option turned on");
			else
				QM_Print("Can't turn on use of the detected icon, since detection hasn't been done yet.");
			end
		elseif args[2] == 'off' then
			QuickMount_ConfigMap[QMCP]["UseDetectedIcon"] = false;
			QM_Print("Auto-Detected mount option turned off");
		elseif args[2] == 'clear' then
			QuickMount_ConfigMap[QMCP]["DetectedIcon"] = nil;
			QuickMount_ConfigMap[QMCP]["UseDetectedIcon"] = false;
			QM_Print("Cleared detect options.");
		end
	elseif args[1] == 'auto-reconfig' then
		local status = "";
		if args[2] == nil or args[2] == '' then
			if QuickMount_ConfigMap[QMCP]["auto-reconfig"] == true then
				QuickMount_ConfigMap[QMCP]["auto-reconfig"] = false;
				status = "toggled OFF";
			else
				QuickMount_ConfigMap[QMCP]["auto-reconfig"] = true;
				status = "toggled ON";
			end 
		elseif args[2] == 'on' then
			QuickMount_ConfigMap[QMCP]["auto-reconfig"] = true;
			status = "ON";
		elseif args[2] == 'off' then
			QuickMount_ConfigMap[QMCP]["auto-reconfig"] = false;
			status = "OFF";
		end
		QM_Print("Auto-reconfiguring is now " .. status);
	elseif args[1] == 'status' then
		QuickMount_ShowUsage();
		local status = "QuickMountEquip is currently";
		if QuickMount_Disabled == true then
			status = status .. " disabled";
		else
			status = status .. " enabled";
		end
		status = status .. ", flight point checking is";
		if QuickMount_ConfigMap[QMCP]["FlightPoint"] == false then
			status = status .. " off";
		else
			status = status .. " on";
		end
		status = status .. ", use of detected mount icon ";
		if QuickMount_ConfigMap[QMCP]["DetectedIcon"] ~= nil then
			status = status .. "(" .. QuickMount_ConfigMap[QMCP]["DetectedIcon"] .. ") is";
		else
			status = status .. "is";
		end
		if QuickMount_ConfigMap[QMCP]["UseDetectedIcon"] == false then
			status = status .. " off";
		else
			status = status .. " on";
		end
		status = status .. ", auto-reconfigure is";
		if QuickMount_ConfigMap[QMCP]["auto-reconfig"] == false then
			status = status .. " off";
		else
			status = status .. " on";
		end
		if QuickMount_ConfigMap[QMCP]["Quiet"] == false then
			status = status .. ", and is in verbose mode.";
		else
			status = status .. ", and is in quiet mode.";
		end
		QM_Print(status);
	elseif args[1] == 'config' then
            -- Reset attack_button, just in case they rearranged hot keys.
		attack_button = 0
		if ( QuickMountFrame ) then 
			if ( QuickMountFrame:IsVisible() ) then 
				HideUIPanel(QuickMountFrame);
			else	
				ShowUIPanel(QuickMountFrame);
			end
		else
			QM_Print("QuickMountEquip did not load. Please check your logs/FrameXML.log file and report this error");
		end
	else
		QuickMount_ShowUsage();
	end
end

function QuickMount_CheckPlayer()
	if QMCP == "" then
		local playername;
		if Fetch_Frame then
			if not Fetch_Done then
				return false;
			else
				playername = Fetch_PlayerName
			end
		else
			playername = UnitName("player");
			if playername == nil or playername == UKNOWNBEING or playername == UNKNOWNOBJECT then
				return false;
			end
		end
		QMCP = GetCVar("realmName") .. "." .. playername;
		-- Convert old config
		if QuickMount_ButtonMap ~= nil and QuickMount_ButtonMap[1] ~= nil then
			QuickMount_ConfigMap = {};
			QuickMount_ConfigMap[QMCP] = QuickMount_ButtonMap;
			QuickMount_ConfigMap[QMCP]["Quiet"] = false;
			QuickMount_ConfigMap[QMCP]["FlightPoint"] = false;
			QuickMount_ConfigMap[QMCP]["auto-reconfig"] = false;
		end
		if QuickMount_ConfigMap == nil or QuickMount_ConfigMap[QMCP] == nil then
			QuickMount_Reset();
		end
		if QuickMount_ConfigMap[QMCP]["FlightPoint"] == nil then
			QuickMount_ConfigMap[QMCP]["FlightPoint"] = false;
		end
		if QuickMount_ConfigMap[QMCP]["UseDetectedIcon"] == nil then
			QuickMount_ConfigMap[QMCP]["UseDetectedIcon"] = false;
		end
		if QuickMount_ConfigMap[QMCP]["auto-reconfig"] == nil then
			QuickMount_ConfigMap[QMCP]["auto-reconfig"] = false;
		end
		QuickMount_UpdateAllSets();
	end
	if QMCP == "" or QMCP == "NONE" then
		return false;
	else
		return true;
	end
end

-- Reset QuickMount
function QuickMount_Reset()
	if QuickMount_CheckPlayer() == false then
		return;
      end
	if QuickMount_ConfigMap == nil then
		QuickMount_ConfigMap = {};
	end
	QuickMount_ConfigMap[QMCP]={index=nil;};
	for i=1,QM_SET_COUNT,1 do
		QuickMount_ConfigMap[QMCP][i]={index=nil;};
		for j=1,QM_SET_SIZE,1 do
			QuickMount_ConfigMap[QMCP][i][j]= {id=QM_NIL;bag=QM_NIL;slot=QM_NIL;texture="";name="";};
		end
		QuickMount_ConfigMap[QMCP]["Quiet"] = false;
		QuickMount_ConfigMap[QMCP]["FlightPoint"] = false;
		QuickMount_ConfigMap[QMCP]["UseDetectedIcon"] = false;
		QuickMount_ConfigMap[QMCP]["DetectedIcon"] = nil;
		QuickMount_ConfigMap[QMCP]["auto-reconfig"] = false;
	end
end

function QuickMount_GetBuffName(buffIndex)
	local x, y = GetPlayerBuff(buffIndex, "HELPFUL");
	QuickMountTooltip:SetUnitBuff("player", buffIndex);
      local Bname = QuickMountTooltipTextLeft1:GetText();
	if ( Bname ~= nil ) then
		return Bname;
	end
	return nil;
end

function QuickMount_GetItemName(bag, slot)
	local bagNumber = bag;
	local name = "";
	if ( type(bagNumber) ~= "number" ) then
		bagNumber = tonumber(bag);
	end
	if (bagNumber <= QM_NIL) then
		QuickMountTooltip:SetInventoryItem("player", slot);
	else
		QuickMountTooltip:SetBagItem(bag, slot);
	end
	name = QuickMountTooltipTextLeft1:GetText();
	if name == nil then
		name = "";
	end
	return name;
end

function QuickMount_PickupContainerItem(bag, slot)
	local empty = true;
	local autoflag = false;
	local name = '';
	-- If we are set to auto-reconfigure, and we're unmounted and they are manually swapping items, configure.
	if ( QuickMount_CheckPlayer() == true and IGNORE_SWITCH == false and QuickMount_ConfigMap[QMCP]["auto-reconfig"] == true and QuickMount_ConfigMap[QMCP]["last_action"] ~= true and QuickMount_CurrentBag == QM_NIL and QuickMount_CurrentName ~= '' and CursorHasItem() ) then
		autoflag = true;
	end
	if ( QuickMount_SavedBagFunc ) then
		QuickMount_SavedBagFunc(bag, slot);
	end
	local texture, itemCount, locked = GetContainerItemInfo(bag, slot);
	if ( texture ) then
      	name = QuickMount_GetItemName(bag, slot)
	end
	if IGNORE_SWITCH == false and CursorHasItem() then
		QuickMount_PickupItem(bag, slot, name, texture)
		empty = false
	end
	if ( autoflag and not CursorHasItem() and name ~= nil and name ~= '') then
		-- Check the UNMOUNT config for this item, swap if found
		for i in QuickMount_ConfigMap[QMCP][UNMOUNT] do
               	if QuickMount_ConfigMap[QMCP][UNMOUNT][i].id > 0 and QuickMount_ConfigMap[QMCP][UNMOUNT][i].name == QuickMount_CurrentName then
				QuickMount_PickupItem(bag, slot, name, texture);
				QuickMount_ConfigMap[QMCP][UNMOUNT][i] = {id=QuickMount_CurrentID,bag=QuickMount_CurrentBag,slot=QuickMount_CurrentSlot,name=QuickMount_CurrentName,texture=QuickMount_CurrentTexture};
				QuickMount_UpdateSet("QuickMountButtonSet",UNMOUNT,QM_SET_SIZE);
			end
		end
	end
	if empty then
		QuickMount_ResetItem();
	end
end

function QuickMount_PickupInventoryItem(slot)
	local empty = true;
	local autoflag = false;
	local name = '';
	-- If we are set to auto-reconfigure, and we're unmounted and they are manually swapping items, configure.
	if ( QuickMount_CheckPlayer() == true and IGNORE_SWITCH == false and QuickMount_ConfigMap[QMCP]["auto-reconfig"] == true and QuickMount_ConfigMap[QMCP]["last_action"] ~= true and QuickMount_CurrentBag ~= QM_NIL and CursorHasItem() ) then
		autoflag = true;
	end
	if ( QuickMount_SavedInvFunc ) then
      		QuickMount_SavedInvFunc(slot);
	end
	local texture = GetInventoryItemTexture("player", slot);
	if ( texture ) then
		name = QuickMount_GetItemName(QM_NIL, slot)
	end
	if IGNORE_SWITCH == false and CursorHasItem() and name ~= '' then
		QuickMount_PickupItem(QM_NIL, slot, name, texture)
		empty = false
	end
	if ( autoflag and not CursorHasItem() and name ~= nil and name ~= '') then
		-- Check the UNMOUNT config for this item, swap if found
		for i in QuickMount_ConfigMap[QMCP][UNMOUNT] do
               	if QuickMount_ConfigMap[QMCP][UNMOUNT][i].id > 0 and QuickMount_ConfigMap[QMCP][UNMOUNT][i].name == name then
				QuickMount_ConfigMap[QMCP][UNMOUNT][i] = {id=QuickMount_CurrentID,bag=QuickMount_CurrentBag,slot=QuickMount_CurrentSlot,name=QuickMount_CurrentName,texture=QuickMount_CurrentTexture};
				QuickMount_UpdateSet("QuickMountButtonSet",UNMOUNT,QM_SET_SIZE);
			end
		end
	end
	if empty then
		QuickMount_ResetItem();
	end
end

function QuickMount_UseContainerItem(bag, slot)
	local empty = true;
	local autoflag = false;
	local name_before = '';
	local name_after = '';

	if ( bag >= 0 and QuickMount_CheckPlayer() == true and IGNORE_SWITCH == false and QuickMount_ConfigMap[QMCP]["auto-reconfig"] == true and QuickMount_ConfigMap[QMCP]["last_action"] ~= true and QuickMount_CurrentBag == QM_NIL and QuickMount_CurrentName == '' and CursorHasItem() ~= true ) then
		autoflag = true;

		-- local texture_before, itemCount_before, locked_before = GetContainerItemInfo(bag, slot);
		-- if ( texture_before ) then
      		-- name_before = QuickMount_GetItemName(bag, slot)
		-- end
	end

	if ( QuickMount_SavedUseFunc ) then
		QuickMount_SavedUseFunc(bag, slot);
	end

	if ( autoflag ) then
		local texture_after, itemCount_after, locked_after = GetContainerItemInfo(bag, slot);
		if ( texture_after ) then
      		name_after = QuickMount_GetItemName(bag, slot)
		end

		if ( not CursorHasItem() and name_before ~= name_after and name_before ~= nil and name_before ~= '' and name_after ~= nil and name_after ~= '' ) then
			-- Check the UNMOUNT config for this item, swap if found
			for i in QuickMount_ConfigMap[QMCP][UNMOUNT] do
               		if QuickMount_ConfigMap[QMCP][UNMOUNT][i].id > 0 and QuickMount_ConfigMap[QMCP][UNMOUNT][i].name == name_after then
					QuickMount_PickupItem(bag, slot, name_before, texture_before);
					QuickMount_ConfigMap[QMCP][UNMOUNT][i] = {id=QuickMount_CurrentID,bag=QuickMount_CurrentBag,slot=QuickMount_CurrentSlot,name=QuickMount_CurrentName,texture=QuickMount_CurrentTexture};
					QuickMount_UpdateSet("QuickMountButtonSet",UNMOUNT,QM_SET_SIZE);
				end
			end
		end
	end
end

function QuickMount_OnLoad()
	-- Set the header
	local name = this:GetName();
	local header = getglobal(name.."TitleText");

	if ( header ) then 
		header:SetText("|cFFee9966Mount Equipment|r");
	end

      QuickMount_Reset();
	-- RegisterForSave("QuickMount_ConfigMap");
	QuickMount_RegisterEvents();

	local temp = PickupContainerItem;
	if ( QuickMount_HookFunction("PickupContainerItem", "QuickMount_PickupContainerItem") ) then
		QuickMount_SavedBagFunc = temp;
	end
	
	local temp = PickupInventoryItem;
	if ( QuickMount_HookFunction("PickupInventoryItem", "QuickMount_PickupInventoryItem") ) then
		QuickMount_SavedInvFunc = temp;
	end

	local temp = UseContainerItem;
	if ( QuickMount_HookFunction("UseContainerItem", "QuickMount_UseContainerItem") ) then
		QuickMount_SavedUseFunc = temp;
	end

	-- Slash Commands
	SlashCmdList["MOUNTEQUIP"] = function(msg) QuickMount_Config(msg); end
	setglobal("SLASH_MOUNTEQUIP1", "/mountequip");

  QME_Registered = 0;
end

function QuickMount_HookFunction(func, newfunc)
	local oldValue = getglobal(func);
	if ( oldValue ~= getglobal(newfunc) ) then
		setglobal(func, getglobal(newfunc));
		return true;
	end
	return false;
end

function QuickMount_ShowHelp()
	local helptext = getglobal("QuickMountFrameHelpText");
	if helptext then
		helptext:SetText("Drag Equipment you want auto-equipped into the squares. (Spurs, etc.) Shift click to clear item. Items that go in the same inventory slot should 'line up'. (Boots in slot 1, Trinkets in slot 2, etc.)");
	end
end

function QuickMount_Enable_Toggle(which)
	if which then
		QuickMount_Disabled = false;
	else
		QuickMount_Disabled = true;
	end 
end

function QuickMount_Quiet_Toggle(which)
	QuickMount_ConfigMap[QMCP]["Quiet"] = which;
end

function QuickMount_FlightPoint_Toggle(which)
	QuickMount_ConfigMap[QMCP]["FlightPoint"] = which;
end


function QuickMount_UseDetectedIcon_Toggle(which)
	QuickMount_ConfigMap[QMCP]["UseDetectedIcon"] = which;
end

function QuickMount_AutoReconfig_Toggle(which)
	QuickMount_ConfigMap[QMCP]["auto-reconfig"] = which;
end

function QuickMount_OnShow()
	local checked;

	QuickMount_ShowHelp()

	-- Configure checkboxes
	if (QuickMount_Disabled == false) then
		checked = 1;
	else
		checked = 0;
	end
		
	QuickMountCheck1:SetChecked(checked);
	QuickMountCheck1Text:SetText("QuickMountEquip enabled.");
	QuickMountCheck1.myToolTip = "Check to enable QuickMountEquip.";
	QuickMountCheck1.ExecuteCommand = QuickMount_Enable_Toggle;

	if (QuickMount_ConfigMap[QMCP]["Quiet"] == true) then
		checked = 1;
	else
		checked = 0;
	end

	QuickMountCheck2:SetChecked(checked);
	QuickMountCheck2Text:SetText("Don't show equip message spam.");
	QuickMountCheck2.myToolTip = "Check to disable equip messages.";
	QuickMountCheck2.ExecuteCommand = QuickMount_Quiet_Toggle;

	if (QuickMount_ConfigMap[QMCP]["FlightPoint"] == true) then
		checked = 1;
	else
		checked = 0;
	end

	QuickMountCheck3:SetChecked(checked);
	QuickMountCheck3Text:SetText("Griffin / FlightPoint check enabled.");
      QuickMountCheck3.myToolTip = "Check to enable Griffin / FlightPoint checking.\n(Might also trigger on druid shapeshifting, or\nwhenever your attack button gets disabled outside\nof combat.)";
	QuickMountCheck3.ExecuteCommand = QuickMount_FlightPoint_Toggle;

	if (QuickMount_ConfigMap[QMCP]["UseDetectedIcon"] == true and QuickMount_ConfigMap[QMCP]["DetectedIcon"] ~= nil) then
		checked = 1;
	else
		checked = 0;
	end

      local ourIcon = QuickMount_ConfigMap[QMCP]["DetectedIcon"];
	if ourIcon == nil then
		ourIcon = 'NOT DETECTED YET';
	end
	QuickMountCheck4:SetChecked(checked);
	QuickMountCheck4Text:SetText("Use auto-detected mount icon");
      QuickMountCheck4.myToolTip = "Check to enable the mount auto-detected by\n/mountequip detect\n\nCurrently: " .. ourIcon .. "\n\n** Usually shouldn't be necessary. **";
	QuickMountCheck4.ExecuteCommand = QuickMount_UseDetectedIcon_Toggle;

	if (QuickMount_ConfigMap[QMCP]["auto-reconfig"] == true) then
		checked = 1;
	else
		checked = 0;
	end

	QuickMountCheck5:SetChecked(checked);
	QuickMountCheck5Text:SetText("Auto-reconfigure.");
      QuickMountCheck5.myToolTip = "Check to enable Auto-reconfiguring.\nThis will automatically reconfigure the add-on if you\nmanually swap a configured item with another.\nOnly works while unmounted and with the\nunmounted equipment line.";
	QuickMountCheck5.ExecuteCommand = QuickMount_AutoReconfig_Toggle;

end

function QuickMount_OnHide()
	QuickMount_DropItem();
	if MYADDONS_ACTIVE_OPTIONSFRAME == this then
		ShowUIPanel(myAddOnsFrame);
	end
end

function QME_RegisterUltimateUI()
		UltimateUI_RegisterButton (
			"Mount Equipment",
			"Auto-Equip",
			"|cFF00CC00QuickMountEquip|r\nAllows you to select \nequipment to be auto-equipped \nas you mount/dismount",
			"Interface\\Icons\\Ability_Mount_RidingHorse",
			QuickMount_Toggle,
			function()
				return true; -- The button is enabled
			end
		);
	QME_Registered = 1;
end

function QuickMount_OnEvent(event)
  local mounted = false
  local sheeped = false
  local clogged = false

  if event == "VARIABLES_LOADED" then
    QMCP = "";
    clogged = true;
    -- Add myAddOns support
    if myAddOnsList then
      myAddOnsList.QuickMountEquip = {name = "QuickMountEquip", description = "Automatically switches gear when you mount", version = QuickMount_Version, frame = "QuickMountFrame", optionsframe = "QuickMountFrame"};
    end
	if( QME_Registered == 0 ) then
		if ( UltimateUI_RegisterButton ) then
			QME_RegisterUltimateUI();
		end
	end
  end

  if event == "UNIT_NAME_UPDATE" and arg1 == "player" then
    QMCP = "";
    clogged = true;
  end

  if QuickMount_CheckPlayer() == false then
    return;
  end

  if clogged == true or QuickMount_Disabled == true then
    return;
  end

  if event == "DELETE_ITEM_CONFIRM" then
    -- If the GUI frame is open, don't let them delete anything.
    if ( QuickMountFrame and QuickMountFrame:IsVisible() ) then 
      QuickMount_DropItem();
    end
    return;
  end

  if event == "PLAYER_REGEN_DISABLED" then
    combat_flag = true
  end
  if event == "PLAYER_REGEN_ENABLED" then
    combat_flag = false
  end

  -- Can't switch inventory while in combat, so ignore if in combat
  if combat_flag == false then
    local _, Pclass = UnitClass("player");
    local detectedIcon = nil;
    for i = 1,16 do
	local buff_texture = UnitBuff("player", i)
	local debuff_texture = UnitDebuff("player", i)
	if QuickMount_AutoDetect == true then
		if buff_texture then
			local parts = {n=0}
			local function helper(word) table.insert(parts, word) end
			string.gsub(buff_texture, "[_%w]+", helper);

			QuickMount_ConfigMap[QMCP]["DetectedIcon"] = parts[parts.n];
		end
	else
      	if debuff_texture and string.find(debuff_texture, "Polymorph") then
        		sheeped = true
        		return;
      	end
		if Pclass == "PALADIN" or Pclass == "WARLOCK" then
        		-- Paladin/Warlock Mount... Hopefully no other buff uses the same texture...
	  		if buff_texture and string.find(buff_texture, "Spell_Nature_Swiftness") then
	    			mounted = true
          			break;
        		end
      	end
		if QuickMount_ConfigMap[QMCP]["UseDetectedIcon"] == true and QuickMount_ConfigMap[QMCP]["DetectedIcon"] ~= nil then
			detectedIcon = QuickMount_ConfigMap[QMCP]["DetectedIcon"];
		end
      	if buff_texture and ( string.find(buff_texture, "Mount") or string.find(buff_texture, "Foot_Kodo") or ( detectedIcon ~= nil and string.find(buff_texture, detectedIcon) ) ) then
        		-- Make sure it isn't "Aspect of the xxx" or "Tiger's Fury"
        		local BuffName = QuickMount_GetBuffName(i);
        		local Skip = false;
        		if BuffName and ( string.find(BuffName, "Aspect") or string.find(BuffName, "Aspekt") or string.find(BuffName, "Tiger's Fury") ) then
          			Skip = true
        		end
        		if Skip == false then
          			mounted = true
          			break;
        		end
      	end
	end
    end

    if QuickMount_AutoDetect == true then
      if QuickMount_ConfigMap[QMCP]["DetectedIcon"] ~= nil then
	  QuickMount_AutoDetect = false;
	  -- QuickMount_ConfigMap[QMCP]["UseDetectedIcon"] = true;
	  QM_Print("Detected mount icon of: " .. QuickMount_ConfigMap[QMCP]["DetectedIcon"]);
	end
	return;
    end

    -- Test for flight path. Search for an attack button and see if it's disabled. This assumes the
    --   only time attack is disabled outside of combat is because of flight paths.
    --     Whoops... Polymorph takes them out of combat, *and* disables attack. Bleh.
    if QuickMount_ConfigMap[QMCP]["FlightPoint"] == true and mounted == false and sheeped == false and attack_button ~= QM_NIL then
	if attack_button == 0 then
        attack_button = QM_NIL
        -- Search for an attack button, and remember it.
        for i = 1,72 do
          if IsAttackAction(i) then
            attack_button = i
            break;
          end
        end
      end
	if attack_button ~= QM_NIL then
        local isusable, mana = IsUsableAction(attack_button)
        if isusable == nil or isusable == false then
          mounted = true
        end
      end
    end

    -- Only attempt to equip if it's different from last time.
    if QuickMount_ConfigMap[QMCP]["last_action"] == nil or QuickMount_ConfigMap[QMCP]["last_action"] ~= mounted then
      QuickMount_ConfigMap[QMCP]["last_action"] = mounted
      local row1, row2;
      if mounted then
        row1 = MOUNT;
	  row2 = UNMOUNT;
      else
        row1 = UNMOUNT;
	  row2 = MOUNT;
      end     
      IGNORE_SWITCH = true;   
      items = "";
      for i in QuickMount_ConfigMap[QMCP][row1] do
	  local x, y;
          x = QM_NIL; y = QM_NIL;
	  if QuickMount_ConfigMap[QMCP][row1][i].id > 0 and QuickMount_ConfigMap[QMCP][row2][i].id > 0 and QuickMount_ConfigMap[QMCP][row1][i].name ~= QuickMount_ConfigMap[QMCP][row2][i].name then
          -- Swap Items
	    x, y = QuickMount_FindInvItem(QuickMount_ConfigMap[QMCP][row2][i].name, true);
	    if CursorHasItem() then
            x, y = QuickMount_FindBagItem(QuickMount_ConfigMap[QMCP][row1][i].name, true);
            if CursorHasItem() then
              y = QM_NIL;
              AutoEquipCursorItem();
            end
          else 
            x, y = QuickMount_FindBagItem(QuickMount_ConfigMap[QMCP][row1][i].name, true, true);
          end
        elseif QuickMount_ConfigMap[QMCP][row1][i].id > 0 then
          x, y = QuickMount_FindBagItem(QuickMount_ConfigMap[QMCP][row1][i].name, true, true);
        end
        if y >= 0 then
          items = items .. ' "' .. QuickMount_ConfigMap[QMCP][row1][i].name .. '"';
        end
      end
      if items ~= "" and QuickMount_ConfigMap[QMCP]["Quiet"] == false then
	      QM_Print("Equipped" .. items);
      end
      IGNORE_SWITCH = false;
    end -- last_action
  end -- combat_flag
end

function QM_Print(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end

function QuickMount_ButtonLoad()
	this:RegisterForDrag("LeftButton", "RightButton");
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp");	
end

function QuickMount_FindBagItem(name, pickup, equip)
	if name == nil then
		return QM_NIL, QM_NIL;
	end
	-- Look in bags.
	for i = 0, 4, 1 do
		local numSlot = GetContainerNumSlots(i);
		for y = 1, numSlot, 1 do
			if (strupper(QuickMount_GetItemName(i, y)) == strupper(name)) then
				if pickup or equip then
					PickupContainerItem(i,y);
					if equip then
						AutoEquipCursorItem();
					end
				end
				return i,y;
			end
		end
	end

	return QM_NIL, QM_NIL;
end

function QuickMount_FindInvItem(name, pickup)
	if name == nil then
		return QM_NIL, QM_NIL;
	end

	-- Look in inventory.
	for i = 1, 19, 1 do
		if (strupper(QuickMount_GetItemName(QM_NIL, i)) == strupper(name)) then
			if pickup then
				PickupInventoryItem(i);
			end
			return QM_NIL, i;
		end
	end 

	return QM_NIL, QM_NIL;
end

function QuickMount_FindItem(bag, slot, name, pickup, equip)
	if name == nil then
		return QM_NIL, QM_NIL;
	end
	-- First look where it's suggested we look.
--[[  NOT WORKING... Cacheing problem?
	if (strupper(QuickMount_GetItemName(bag,slot)) == strupper(name)) then
		if pickup then
			if bag >= 0 then
				PickupContainerItem(bag,slot);
			else
				PickupInventoryItem(slot);
			end
		end
		return bag, slot;
	end
]]

      local x, y = QuickMount_FindBagItem(name, pickup, equip);
	
	if equip then
		return x, y;
	end

      if x < 0 then
		x, y = QuickMount_FindInvItem(name, pickup);
	end
	
	return x, y;
end

-- Erases the old button with the hand
function QuickMount_SetButton(row, col) 
	if QuickMount_CheckPlayer() == false then
		return;
	end
	-- Set the new button
	QuickMount_ConfigMap[QMCP][row][col] = {id=QuickMount_CurrentID,bag=QuickMount_CurrentBag,slot=QuickMount_CurrentSlot,name=QuickMount_CurrentName,texture=QuickMount_CurrentTexture};
	QuickMount_DropItem();

	QuickMount_ButtonUpdate(this);	
end

-- Swaps the specified button into hand
function QuickMount_SwapButton(row,col)
	if QuickMount_CheckPlayer() == false then
		return;
	end
	-- Store the old value if one exists
	local temp = nil;
	if ( QuickMount_ConfigMap[QMCP][row][col].id > 0 ) then 
		temp = QuickMount_ConfigMap[QMCP][row][col];
	end

	-- Drop the current button
	QuickMount_SetButton(row, col);
	
	-- Load the old one into the cursor
	if ( temp ) then 
		if ( temp.id > 0 ) then
			local bag, slot = QuickMount_FindItem(temp.bag, temp.slot, temp.name, true);
			QuickMount_PickupItem(bag, slot, temp.name, temp.texture);
		end
	end
end


-- Button Event Handler
function QuickMount_ButtonEvent(event)
end

-- Move the Equipment around
function QuickMount_ButtonDragStart()
	local col, row = QuickMount_GetCurrentLocation(this);		

	-- Pick up the current item
	QuickMount_SwapButton(row,col);
end

--
-- Swap or pick up if clicked with or without a full hand
-- 
function QuickMount_ButtonClick(button)
	if QuickMount_CheckPlayer() == false then
		return;
	end
	local col, row = QuickMount_GetCurrentLocation(this);		

      if IsShiftKeyDown() then
		QuickMount_ConfigMap[QMCP][row][col] = {id=QM_NIL;bag=QM_NIL;slot=QM_NIL;texture="";name="";};
		QuickMount_ButtonUpdate(this);
	elseif IsAltKeyDown() then
		-- PrintTable(QuickMount_ConfigMap[QMCP][row][col]);
	else
		-- Pick up the current item
		QuickMount_SwapButton(row,col);
	end
end

function QuickMount_ButtonDragEnd()
	if QuickMount_CheckPlayer() == false then
		return;
	end
	if( QuickMount_CurrentID > 0 ) then
		local col, row = QuickMount_GetCurrentLocation(this);		
		QuickMount_SwapButton(row,col);
	end
end

-- Displays the tooltip of the item in the box.
function QuickMount_ButtonEnter()
	if QuickMount_CheckPlayer() == false then
		return;
	end
	local col, row = QuickMount_GetCurrentLocation(this);		

	local id = QuickMount_ConfigMap[QMCP][row][col].id;
	local tooltip = QuickMount_ConfigMap[QMCP][row][col].name;

	if ( id > 0 ) then 
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		if ( GameTooltip:SetText(tooltip) ) then
			this.updateTooltip = TOOLTIP_UPDATE_TIME;
		else
			this.updateTooltip = nil;
		end	
	end
end

function QuickMount_ButtonLeave()
	GameTooltip:Hide();
end

function QuickMount_ButtonLoad()
end

-- Self Texture Button
function QuickMount_SetSelfTexture(button, row, col)
	if QuickMount_CheckPlayer() == false then
		return;
	end 
	local name = button:GetName();	
	local icon = getglobal(name.."Icon");

	if (  QuickMount_ConfigMap[QMCP][row] == nil ) then return end
	local id = QuickMount_ConfigMap[QMCP][row][col].id;

	if ( id > 0 ) then 
		-- Set the pretty texture
		local texture = QuickMount_ConfigMap[QMCP][row][col].texture;
		if ( texture ) then
			icon:SetTexture(texture);
			icon:Show();
		else
			icon:Hide();
		end
	else
		icon:Hide();
	end
end	

-- Button Update
function QuickMount_ButtonUpdate(button)
	-- Check the button
	if ( button == nil ) then return; end
	
	-- Uncheck it
	button:SetChecked("false");
	local col, row = QuickMount_GetCurrentLocation(button);

	-- Check for errors
	if ( col == nil or row == nil ) then return; end
	
	-- Enable the button
	button:Enable();
	QuickMount_SetSelfTexture(button, row, col);
end

function QuickMount_UpdateSet(setbasename,set,size)
	if set == nul then return; end

	for i=1,size,1 do
		QuickMount_ButtonUpdate(getglobal(setbasename..set..i));
	end
end

function QuickMount_UpdateAllSets()
	for set=1,QM_SET_COUNT,1 do
		QuickMount_UpdateSet("QuickMountButtonSet",set,QM_SET_SIZE);
	end
end

-- Tracks the last item picked up
function QuickMount_PickupItem(bag, slot, name, texture) 
	QuickMount_CurrentID = 1;
	QuickMount_CurrentBag = bag;
	QuickMount_CurrentSlot = slot;
	QuickMount_CurrentName = name;
	QuickMount_CurrentTexture = texture;
end

function QuickMount_ResetItem()
	QuickMount_CurrentID = QM_NIL;
	QuickMount_CurrentBag = QM_NIL;
	QuickMount_CurrentSlot = QM_NIL;
	QuickMount_CurrentName = "";
	QuickMount_CurrentTexture = "";
end

function QuickMount_DropItem()
	if CursorHasItem() then
		if QuickMount_CurrentBag >= 0 then
			PickupContainerItem(QuickMount_CurrentBag,QuickMount_CurrentSlot);
      	elseif QuickMount_CurrentSlot >= 0 then
			PickupInventoryItem(QuickMount_CurrentSlot);
		end
	end
	QuickMount_ResetItem();
end

function QuickMountCheckButton_OnClick()
	if (this:GetChecked()) then
		this.ExecuteCommand(true);
	else
		this.ExecuteCommand(false);
	end
end

function QuickMountCheckButton_OnEnter()
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	if ( GameTooltip:SetText(this.myToolTip) ) then
		this.updateTooltip = TOOLTIP_UPDATE_TIME;
	else
		this.updateTooltip = nil;
	end	
end

function QuickMountCheckButton_OnLeave()
	GameTooltip:Hide();
end

-- Returns the current button location
function QuickMount_GetCurrentLocation(object)
	return object:GetID(), object:GetParent():GetID();
end
