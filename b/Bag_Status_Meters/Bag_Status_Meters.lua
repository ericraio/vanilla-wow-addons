--[[
-------------------
-    Madorin's    -
-Bag Status Meters-
-     v1.3.7      -
-------------------

Author: Romualdo
Original Author: Kevin "Madorin" Hassett
Last Updated: October 15, 2005

-Patch Notes-
v1.3.7 (10/15/2005)
-TOC updated to 1800
-Fixed errors with 1800
-Fixed bug with quiver
v1.3.6 (4/04/2005):
-TOC updated to 4297
-Added support for myAddOns AddOn arrangement (separate AddOn)

v1.3.5.1 (3/03/2005):
-Fixed a bug where any bag after an ammo bag or empty slot would not be checked

v1.3.5 (2/26/2005):
-TOC updated to 4216
-Added an option to hide the background and meter on the Overall Meter

v1.3.4 (2/17/2005):
-Merged all localizations
-TOC updated to 4211
-Added German Description

v1.3.3 (2/04/2005):
-Changed some variables from local to global for dependency possibilities.
-Fixed a quest reward ammo bag, "Bandolier of the Watch", to not show up as inventory.
-Put in bank bag labels.
-Set the Overall and Dropdown frame level to LOW.
-Commented Code.

v1.3.2 (1/24/2005):
-Fixed layering issues with overlay bars/labels.
-Replaced the command system with a GUI for more customizability.
   -To access GUI, just type "/bsm" with anything or nothing following it.
-Added a key binding for BSM Options Pane.
-Added a UI button for the BSM Options Pane.
-Changed binding labels to buttons that toggle corresponding bag.
-Added an option to lock the overall meter.
-Added an option to place the overall meter at a specified location.

v1.3.1 (1/8/2005):
-Added "/bsm color" to toggle colors on/off.
-Added "/bsm totals" to toggle displaying the totals.
-Added "/bsm slots" to toggle using either free or used slots for display.
-Added "/bsm title" to toggle displaying the title on the overall meter.
-Added "/bsm notify" to toggle displaying notifications.
-Fixed "Inventory Full" notification to "Backpack Full".
-Fixed overall frame obstruction.
-Added notification when settings have changed.
-Changed color function to the one contributed by Azam.
-Added a brief readme.

v1.3 (1/5/2005):
-Fixed the small bug with ammo bags counting as inventory.
-Added alternative to use only text for displaying bag status ("/bsm none").
-Added alternative to use a dropdown frame for displaying bag status ("/bsm none").
-Added "/bsm help".
-Added ability to toggle hiding of labels ("/bsm labels").
-Added saved variables.
-Added notification when a bag becomes full.
-Huge XML overhaul.

v1.2 (1/2/2005):
-Fixed a layer problem where the meters showed up over the map frame.
-Added "/bsm hide" and "/bsm show" to hide or show the overall bag meter.
-Minor tweak to the % at which the meters turn yellow.

v1.1 (1/1/2005):
-Optimization help from Vjeux.
-Fixed a bug where a bag dragged into the bag bar from a non-inventory bag would not update.
-Added the missing line of XML to make it draggable.

Special Thanks: Vjeux for v1.1 LUA and XML optimization
                Azam for contributing an improved color function
                kiki for the french localization
                SirPennt for the german localization
                SoNeX for the german description
]]


--BSM_NumSlots: global variable that holds the total number of slots per bag
BSM_NumSlots = {0, 0, 0, 0, 0};
--BSM_UsedSlots: global variable that holds the number of used slots per bag
BSM_UsedSlots = {0, 0, 0, 0, 0};
--BSM_BagFull: global variable used for displaying notifications only once
BSM_BagFull = {false, false, false, false, false};

BSM_LOADED = false;

--Variables for UI Objects
BSM_FRAME = "BSM_Frame";
BSM_DROPDOWNS = "BSM_Dropdowns";
BSM_DROPDOWNS_BARS = "BSM_DropdownsBars";
BSM_BARS = "BSM_Bars";
BSM_COODLOWNS = "BSM_Cooldowns";
BSM_BARS_LABELS = "BSM_BarLabels";
BSM_DROPDOWNS_LABELS = "BSM_DropdownLabels";
BSM_BANK = "BSM_BankBag";

--Variables for the type of slot used to keep count
BSM_SLOTS_FREE = 0;
BSM_SLOTS_TAKEN = 1;



--BSM_SavePosition:
--    Purpose - Save the position of the Overall Meter frame
--    Parameters - None
--    Returns - Nothing
function BSM_SavePosition()
    BSM_Save.dispX = this:GetLeft();
    BSM_Save.dispY = this:GetBottom();
end

--BSM_DisableAllIndividual:
--    Purpose - Hide all the individual meters components
--    Parameters - None
--    Returns - Nothing
function BSM_DisableAllIndividual()
    getglobal(BSM_BARS_LABELS):Hide();
    getglobal(BSM_BARS):Hide();
    getglobal(BSM_DROPDOWNS):Hide();
    getglobal(BSM_DROPDOWNS_LABELS):Hide();
end
--BSM_EnableAllIndividual:
--    Purpose - Show all the individual meters components that need to be
--    Parameters - None
--    Returns - Nothing
function BSM_EnableAllIndividual()
    if BSM_Save.I.bars and BSM_Save.I.overlay then
        getglobal(BSM_BARS):Show();
    end
    if BSM_Save.I.showlabels and (BSM_Save.I.bars or BSM_Save.I.labels) and BSM_Save.I.overlay then
        getglobal(BSM_BARS_LABELS):Show();
    end
    if BSM_Save.I.dropdowns then
        getglobal(BSM_DROPDOWNS):Show();
        if BSM_Save.I.showlabels then
            getglobal(BSM_DROPDOWNS_LABELS):Show();
        end
    end
end

--BSM_command:
--    Purpose - Show the Options frame for any "/bsm" command
--    Parameters - the message following "/bsm "
--    Returns - Nothing
local function BSM_command(msg)
    msg = string.lower(msg);

    if not getglobal("BSM_Options"):IsVisible() then
        getglobal("BSM_Options"):Show();
    else
        getglobal("BSM_Options"):Hide();
    end
end

--BSM_initCommands:
--    Purpose - Register the "/bsm" slash command
--    Parameters - None
--    Returns - Nothing
function BSM_initCommands()
    SlashCmdList["BSMCOMMAND"] = BSM_command;
    SLASH_BSMCOMMAND1 = "/bsm";
end

--BSM_loadVariables:
--    Purpose - Initialize the save vairiables if they don't exist and hide/show appropriate things
--    Parameters - None
--    Returns - Nothing
function BSM_loadVariables()
    --Register with myAddOns
    if(myAddOnsFrame) then
        myAddOnsList.BagStatusMeters = {name = "Bag Status Meters", 
                                        description = "Use bar/text overlays for bag status",
                                        version = BSM_VERSION, 
                                        category = MYADDONS_CATEGORY_INVENTORY, 
                                        frame = BSM_FRAME, 
                                        optionsframe = "BSM_Options"};
    end

    --If any of the key save elements does not exist, create a new save
    if not BSM_Save or not BSM_Save.I or not BSM_Save.O then
        --BSM_Save: the saved variable for everything
        BSM_Save = { };
        --BSM_Save.I: the saved variables used for individual meters
        BSM_Save.I = { };
        --BSM_Save.O: the saved variables used for the overall meter
        BSM_Save.O = { };
        --BSM_Save.I.enable: enables/disables all of the individual meters
        BSM_Save.I.enable = true;
        --BSM_Save.I.overlay: enables/disables the individual meters displayed over the bag slots
        BSM_Save.I.overlay = true;
        --BSM_Save.I.bars: set the display mode for the overlay meters to include the bar
        BSM_Save.I.bars = true;
        --BSM_Save.I.bars: set the display mode for the overlay meters to only text
        BSM_Save.I.labels = false;
        --BSM_Save.I.dropdowns: enables/disables the dropdown meters from the overall meter
        BSM_Save.I.dropdowns = false;
        --BSM_Save.I.bindings: enables/disables the binding buttons next to the dropdown meters that open the bags
        BSM_Save.I.bindings = true;
        --BSM_Save.I.showlabels: enables/disables the use of any labels on the individual meters
        BSM_Save.I.showlabels = true;
        --BSM_Save.I.color: enables/disables color changing of the individual bars
        BSM_Save.I.color = true;
        --BSM_Save.I.totals: enables/disables displaying the total slots on the labels
        BSM_Save.I.totals = true;
        --BSM_Save.I.slots: determines whether to use free or used slots in the labels
        BSM_Save.I.slots = BSM_SLOTS_FREE;
        --BSM_Save.O.enable: enables/disables the entire overall meter
        BSM_Save.O.enable = true;
        --BSM_Save.O.title: enables/disables displaying the title over the overall meter
        BSM_Save.O.title = true;
        --BSM_Save.O.back: hides/shows the background and meter for the overall meter so there's only text
        BSM_Save.O.back = true;
        --BSM_Save.O.showlabels: enables/disables the use of the label on the overall meter
        BSM_Save.O.showlabels = true;
        --BSM_Save.O.color: enables/disables color changing of the overall bar
        BSM_Save.O.color = true;
        --BSM_Save.O.totals: enables/disables displaying the total slots on the label
        BSM_Save.O.totals = true;
        --BSM_Save.O.slots: determines whether to use free or used slots in the overall label
        BSM_Save.O.slots = BSM_SLOTS_USED;
        --BSM_Save.O.lock: locks/unlocks the overall meter from dragging
        BSM_Save.O.lock = false;
        --BSM_Save.dispX/dispY: the position of the overall meter relative to the bottom left of the screen
        BSM_Save.dispX = GetScreenWidth()/2 + 150;
        BSM_Save.dispY = 50;
        --BSM_Save.notify: enables/disables notifications when bags are full
        BSM_Save.notify = true;
        --BSM_Save.optbutton: enables/disables displaying the options button next to the overall meter
        BSM_Save.optbutton = true;
    end

    BSM_DisableAllIndividual();
    if BSM_Save.I.enable then
        BSM_EnableAllIndividual();
    end
    
    if not BSM_Save.I.bindings then
        for i = 0, 4, 1 do
            getglobal(BSM_DROPDOWNS..i.."Key"):Hide();
        end
    else
    end

    if not BSM_Save.O.enable then
        getglobal(BSM_FRAME):Hide();
    end
    if not BSM_Save.O.showlabels then
        getglobal("BSM_FrameText"):Hide();
    end
    if not BSM_Save.O.title then
        getglobal("BSM_FrameButtonLabel"):Hide();
    end
    if not BSM_Save.optbutton then
        getglobal("BSM_OptionsButton"):Hide();
    end
    if not BSM_Save.O.back then
        getglobal(BSM_FRAME.."BackAlpha"):Hide();
        getglobal(BSM_FRAME.."Border"):Hide();
        BSM_FrameStatus:Hide();
    end
    
    --Set the position of the Overall Meter frame relative to the bottom left of the screen
    getglobal(BSM_FRAME):ClearAllPoints();
    getglobal(BSM_FRAME):SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", BSM_Save.dispX, BSM_Save.dispY);

    BSM_LOADED = true;
    BSM_updateFreeSlots();
end

--BSM_updateFreeSlots:
--    Purpose - Update the BSM_NumSlots and BSM_UsedSlots to accurately reflect the inventory
--              Also updates all meters that need to be updated
--    Parameters - None
--    Returns - Nothing
function BSM_updateFreeSlots()
    --totalSlots: the number of slots in all bags
	local totalSlots = 0;
	--totalUsedSlots: the number of used slots in all bags
	local totalUsedSlots = 0;
	--slotsText: the text that is to be displayed on the meter labels
	local slotsText = 0;
	--isAmmo:  true if the current bag is one of the recognized ammo bags
	local isAmmo = false;

    --Loop through for every bag
	for bag = 0, 4, 1 do
        --Save the number of total slots in the current bag to the global variable
		BSM_NumSlots[bag+1] = GetContainerNumSlots(bag);
		
		isAmmo = false;
		
		--Check if the current bag is an ammo bag or can't get the bag name
		if ( not GetBagName(bag) ) then
            isAmmo = true;
		else
    		for i = 1, table.getn( BSM_AMMO ), 1 do
                if ( string.find( GetBagName(bag), BSM_AMMO[i] ) ) then
                    isAmmo = true;
                    break;
                end
    		end
		end

		--If there is no bag in the current bag slot or it is an ammo bag, hide all of its meters and don't count it in the total
		if (BSM_NumSlots[bag+1] == 0 or isAmmo) then
			getglobal(BSM_BARS..bag):Hide();
			getglobal(BSM_BARS_LABELS..bag):Hide();
			getglobal(BSM_DROPDOWNS..bag):Hide();
			getglobal(BSM_DROPDOWNS_LABELS..bag):Hide();
			getglobal(BSM_DROPDOWNS_BARS..bag):Hide();
			BSM_BagFull[bag+1] = false;
		else
			totalSlots = totalSlots + BSM_NumSlots[bag+1];
			
			--Reset the used slots global variable and
            --loop through every slot in the current bag and 
            --increment the variable if an item exists
			BSM_UsedSlots[bag+1] = 0;
			for slot = 1, BSM_NumSlots[bag+1], 1 do
				if (GetContainerItemInfo(bag, slot)) then
					BSM_UsedSlots[bag+1] = BSM_UsedSlots[bag+1] + 1;
					totalUsedSlots = totalUsedSlots + 1;
				end
			end

            --If free slots are used in the individual labels, subtract the used slots from the free slots and
            --use that number in the slots text instead of used slots
			if BSM_Save.I.slots == BSM_SLOTS_FREE then
                slotsText = BSM_NumSlots[bag+1] - BSM_UsedSlots[bag+1];
			else
                slotsText = BSM_UsedSlots[bag+1];
			end
			--If the totals are shown in the individual labels, concatenate it onto the end of the text
			if BSM_Save.I.totals then
                slotsText = slotsText.."/"..BSM_NumSlots[bag+1];
			end

            --Show the current bag text and reset the text color
            getglobal(BSM_BARS_LABELS..bag):Show();
			getglobal(BSM_BARS_LABELS..bag):SetText(slotsText);
            getglobal(BSM_BARS_LABELS..bag):SetTextColor(1.0, 1.0, 1.0, 1.0);
            getglobal(BSM_DROPDOWNS_LABELS..bag):Show();
			getglobal(BSM_DROPDOWNS_LABELS..bag):SetText(slotsText);

            --status: a temporary variable to hold the current meter being updated
			local status;
			--If the bars are shown and the overlay is enabled, update the meter/label over the current bag
			if BSM_Save.I.bars and BSM_Save.I.overlay then
                --Set status to the meter that is over the current bag
                status = getglobal(BSM_BARS..bag);
                --Set the meter's min, max, and current values accordingly
    			status:SetMinMaxValues(0, BSM_NumSlots[bag+1]);
    			status:SetValue(BSM_UsedSlots[bag+1]);
    			--If color is enabled, color the bar according to the ratio of used slots to total slots
    			--Otherwise make it a gray color
    			if BSM_Save.I.color then
        			status:SetStatusBarColor(BSM_GetColor(BSM_NumSlots[bag+1] - BSM_UsedSlots[bag+1], BSM_NumSlots[bag+1], 0.6));
        		else
        			status:SetStatusBarColor(0.5, 0.5, 0.5, 0.6);
        		end
                status:Show();
            end

            --If the overlay display is set to just labels and the overlay is enabled, update only the label
    		if BSM_Save.I.labels and BSM_Save.I.overlay then
                --If color is disabled or the bag is less than half full, keep the label white
                --Otherwise color the label according to the ratio of used slots to total slots
                if not BSM_Save.I.color then
                    getglobal(BSM_BARS_LABELS..bag):SetTextColor(1.0, 1.0, 1.0, 1.0);
                elseif BSM_UsedSlots[bag+1] / BSM_NumSlots[bag+1] >= 0.5 then
                    getglobal(BSM_BARS_LABELS..bag):SetTextColor(BSM_GetColor(BSM_NumSlots[bag+1] - BSM_UsedSlots[bag+1], BSM_NumSlots[bag+1], 1.0));
                else
                    getglobal(BSM_BARS_LABELS..bag):SetTextColor(1.0, 1.0, 1.0, 1.0);
                end
            end

            --If the dropdown meters are enabled, update them
			if BSM_Save.I.dropdowns then
                --Set status to the dropdown meter that is for the current bag
                status = getglobal(BSM_DROPDOWNS_BARS..bag);
                --Set the meter's min, max, and current values accordingly
    			status:SetMinMaxValues(0, BSM_NumSlots[bag+1]);
    			status:SetValue(BSM_UsedSlots[bag+1]);
    			--If color is enabled, color the bar according to the ratio of used slots to total slots
    			--Otherwise make it a gray color
    			if BSM_Save.I.color then
        			status:SetStatusBarColor(BSM_GetColor(BSM_NumSlots[bag+1] - BSM_UsedSlots[bag+1], BSM_NumSlots[bag+1], 1.0));
        		else
        			status:SetStatusBarColor(0.5, 0.5, 0.5, 1.0);
        		end
                status:Show();
                getglobal(BSM_DROPDOWNS..bag):Show()
            end

            --If the current bag is full and notifications are enabled, check if a notification should be given
            if BSM_UsedSlots[bag+1] == BSM_NumSlots[bag+1] and BSM_Save.notify then
                --If the bag was not full last check, give a notification and
                --set the full bag variable to true
                --Otherwise keep the full bag variable false
                if not BSM_BagFull[bag+1] then
                    if bag == 0 then
                        UIErrorsFrame:AddMessage(BSM_BACKPACK..BSM_FULL, 1.0, 0.1, 1.0, 1.0, UIERRORS_HOLD_TIME);
                        DEFAULT_CHAT_FRAME:AddMessage(BSM_MSG.."|cffff0fff"..BSM_BACKPACK..BSM_FULL.."|r");
                    else
                        UIErrorsFrame:AddMessage(BSM_BAG..bag..BSM_FULL, 1.0, 0.1, 1.0, 1.0, UIERRORS_HOLD_TIME);
                        DEFAULT_CHAT_FRAME:AddMessage(BSM_MSG.."|cffff0fff"..BSM_BAG..bag..BSM_FULL.."|r");
                    end
                    BSM_BagFull[bag+1] = true;
                end
            else
                BSM_BagFull[bag+1] = false;
            end
		end
	end

    --Update the bindings for all of the dropdown meter buttons
    getglobal(BSM_DROPDOWNS.."0Key"):SetText(GetBindingText(GetBindingKey("TOGGLEBACKPACK"), "KEY_"));
    getglobal(BSM_DROPDOWNS.."4Key"):SetText(GetBindingText(GetBindingKey("TOGGLEBAG1"), "KEY_"));
    getglobal(BSM_DROPDOWNS.."3Key"):SetText(GetBindingText(GetBindingKey("TOGGLEBAG2"), "KEY_"));
    getglobal(BSM_DROPDOWNS.."2Key"):SetText(GetBindingText(GetBindingKey("TOGGLEBAG3"), "KEY_"));
    getglobal(BSM_DROPDOWNS.."1Key"):SetText(GetBindingText(GetBindingKey("TOGGLEBAG4"), "KEY_"));

    --If the overall meter is disabled, then everything else can be ignored
    if not BSM_Save.O.enable then return; end

    --totalFreeSlots: free slots in all of the bags
	local totalFreeSlots = totalSlots - totalUsedSlots;

    --If free slots are used in the overall label, use that number in the slots text instead of used slots
	if BSM_Save.O.slots == BSM_SLOTS_FREE then
        slotsText = totalFreeSlots;
	else
        slotsText = totalUsedSlots;
	end
	--If the totals are shown in the overall label, concatenate it onto the end of the text
	if BSM_Save.O.totals then
        slotsText = slotsText.."/"..totalSlots;
	end

    --Update the text and
    --min, max, and current values of the overall bar
	BSM_FrameText:SetText(slotsText);
	BSM_FrameStatus:SetMinMaxValues(0, totalSlots);
	BSM_FrameStatus:SetValue(totalUsedSlots);
	--If color is enabled, color the bar according to the ratio of used slots to total slots
    --Otherwise make it a gray color
    if BSM_Save.O.color then
    	BSM_FrameStatus:SetStatusBarColor(BSM_GetColor(totalFreeSlots, totalSlots, 1.0));
    else
        BSM_FrameStatus:SetStatusBarColor(0.5, 0.5, 0.5, 1.0);
    end

    --Update the bank bars if the Bank frame is open
	--[[if getglobal("BSM_Bank_Bars"):IsVisible() then
    	BSM_updateBankBags();
	end]]
end

--BSM_GetColor:
--    Purpose - Get the appropriate color for the bar being updated
--    Parameters - freeSlots: free slots in the bag
--                 totalSlots: number of slots in the bag
--                 alpha: desired opacity of the color
--    Returns - Color for the bar (red, green, blue, alpha)
function BSM_GetColor(freeSlots, totalSlots, alpha)
    local pct = freeSlots / totalSlots;
    local r, g;
    r = 1.0;
    g = 1.0;
	if  pct < 0.5 then
        --r = 1.0;
		g = pct * 2;
	elseif pct > 0.5 then
        r = 1.0 - (pct-0.5) * 2;
        --g = 1.0;
	--elseif pct == 0.5 then
		--Do nothing, both already 1.0
	end
	
	return r, g, 0.0, alpha;
end



--BSM_updateBankBags:
--    Purpose - Update the bank bars when the bank frame is open
--    Parameters - None
--    Returns - Nothing
function BSM_updateBankBags()
    --num: number of slots in the current bank bag
    local num = 0;
    --used: number of used slots in the current bank bag
    local used = 0;
    --slotsText: the text that is to be displayed on the meter labels
	local slotsText = 0;
	--status: the current bar being updated
	local status;

    --Loop through for every bank bag
	for bag = 5, 10, 1 do
        --set status to the current bar and get the number of slots in the current bank bag
        status = getglobal(BSM_BANK..(bag-4));
		num = GetContainerNumSlots(bag);
		--if there is no bag in the current bank bag slot, then hide the bar
		if num == 0 then
            status:Hide();
		else
            --Reset the used slots and
            --loop through every slot in the current bank bag and
            --increment the variable if an item exists
			used = 0;
			for slot = 1, num, 1 do
				if GetContainerItemInfo(bag, slot) then
					used = used + 1;
				end
			end

            --[[--bar: the bar to the current bank bag
            local bar = getglobal(status:GetName().."Bar");
            --Set the meter's min, max, and current values accordingly
    		bar:SetMinMaxValues(0, num);
    		bar:SetValue(used);
    		--If color is enabled, color the bar according to the ratio of used slots to total slots
    		--Otherwise make it a gray color
    		if BSM_Save.I.color then
        		bar:SetStatusBarColor(BSM_GetColor(num - used, num, 0.6));
        	else
        		bar:SetStatusBarColor(0.5, 0.5, 0.5, 0.6);
        	end]]

			if BSM_Save.I.slots == BSM_SLOTS_FREE then
                slotsText = num - used;
			else
                slotsText = used;
			end
			
			if BSM_Save.I.totals then
                slotsText = slotsText.."/"..num;
			end

            status:Show();
            getglobal(status:GetName().."Label"):SetText(slotsText);
		end
	end
end

--BSM_DividerOnShow:
--    Purpose - Set the text of a header depending on its name
--    Parameters - h: the header that's being shown
--    Returns - Nothing
function BSM_DividerOnShow(h)
    local name = h:GetName();

    if name == "BSM_Divider_Individual" then
        getglobal(name.."HeaderText"):SetText(BSM_OPTIONS_INDIVID);
        getglobal(name.."Header"):SetWidth(250);
    elseif name == "BSM_Divider_Overall" then
        getglobal(name.."HeaderText"):SetText(BSM_OPTIONS_OVERALL);
        getglobal(name.."Header"):SetWidth(220);
    elseif name == "BSM_Divider_Global" then
        getglobal(name.."HeaderText"):SetText(BSM_OPTIONS_GLOBAL);
        getglobal(name.."Header"):SetWidth(128);
    end
end

--BSM_EnableIndividualChecks:
--    Purpose - Enables all the check boxes having to do with individual meters
--    Parameters - None
--    Returns - Nothing
function BSM_EnableIndividualChecks()
    getglobal("BSM_Check_Overlay"):Enable();
    getglobal("BSM_Check_Bars"):Enable();
    getglobal("BSM_Check_Labels"):Enable();
    getglobal("BSM_Check_Dropdown"):Enable();
    getglobal("BSM_Check_IndvLabels"):Enable();
    getglobal("BSM_Check_IndvColor"):Enable();
    getglobal("BSM_Check_IndvTotals"):Enable();
    getglobal("BSM_Check_IndvSlots"):Enable();
    getglobal("BSM_Check_Bindings"):Enable();
end

--BSM_DisableIndividualChecks:
--    Purpose - Disables all the check boxes having to do with individual meters
--    Parameters - None
--    Returns - Nothing
function BSM_DisableIndividualChecks()
    getglobal("BSM_Check_Overlay"):Disable();
    getglobal("BSM_Check_Bars"):Disable();
    getglobal("BSM_Check_Labels"):Disable();
    getglobal("BSM_Check_Dropdown"):Disable();
    getglobal("BSM_Check_IndvLabels"):Disable();
    getglobal("BSM_Check_IndvColor"):Disable();
    getglobal("BSM_Check_IndvTotals"):Disable();
    getglobal("BSM_Check_IndvSlots"):Disable();
    getglobal("BSM_Check_Bindings"):Disable();
end

--BSM_CheckOnShow:
--    Purpose - Set the text of a check box depending on its name
--              Also makes the necessary checks for enabling/disabling child check boxes
--    Parameters - b: the check box that's being shown
--    Returns - Nothing
function BSM_CheckOnShow(b)
    local name = b:GetName();
    
    if name == "BSM_Check_Individual" then
        getglobal(name.."Text"):SetText(BSM_TEXT_INDIVIDUAL);
        if BSM_Save.I.enable then
            b:SetChecked(1);
        else
            b:SetChecked(0);
        end
        if b:GetChecked() == 1 then
            BSM_EnableIndividualChecks();
        else
            BSM_DisableIndividualChecks();
        end
    elseif name == "BSM_Check_Overlay" then
        getglobal(name.."Text"):SetText(BSM_TEXT_OVERLAY);
        if BSM_Save.I.overlay then
            b:SetChecked(1);
        else
            b:SetChecked(0);
        end
        if b:GetChecked() == 1 and BSM_Save.I.enable then
            getglobal("BSM_Check_Bars"):Enable();
            getglobal("BSM_Check_Labels"):Enable();
        else
            getglobal("BSM_Check_Bars"):Disable();
            getglobal("BSM_Check_Labels"):Disable();
        end
    elseif name == "BSM_Check_Bars" then
        getglobal(name.."Text"):SetText(BSM_TEXT_BAR);
        if BSM_Save.I.bars then
            b:SetChecked(1);
        else
            b:SetChecked(0);
        end
    elseif name == "BSM_Check_Labels" then
        getglobal(name.."Text"):SetText(BSM_TEXT_LABELSTAT);
        if BSM_Save.I.labels then
            b:SetChecked(1);
        else
            b:SetChecked(0);
        end
    elseif name == "BSM_Check_Dropdown" then
        getglobal(name.."Text"):SetText(BSM_TEXT_DROPDOWN);
        if BSM_Save.I.dropdowns then
            b:SetChecked(1);
        else
            b:SetChecked(0);
        end
        if b:GetChecked() == 1 and BSM_Save.I.enable then
            getglobal("BSM_Check_Bindings"):Enable();
        else
            getglobal("BSM_Check_Bindings"):Disable();
        end
    elseif name == "BSM_Check_Bindings" then
        getglobal(name.."Text"):SetText(BSM_TEXT_BINDINGS);
        if BSM_Save.I.bindings then
            b:SetChecked(1);
        else
            b:SetChecked(0);
        end
    elseif name == "BSM_Check_IndvLabels" then
        getglobal(name.."Text"):SetText(BSM_TEXT_LABELS);
        if BSM_Save.I.showlabels then
            b:SetChecked(1);
        else
            b:SetChecked(0);
        end
    elseif name == "BSM_Check_IndvColor" then
        getglobal(name.."Text"):SetText(BSM_TEXT_COLOR);
        if BSM_Save.I.color then
            b:SetChecked(1);
        else
            b:SetChecked(0);
        end
    elseif name == "BSM_Check_IndvTotals" then
        getglobal(name.."Text"):SetText(BSM_TEXT_TOTALS);
        if BSM_Save.I.totals then
            b:SetChecked(1);
        else
            b:SetChecked(0);
        end
    elseif name == "BSM_Check_IndvSlots" then
        getglobal(name.."Text"):SetText(BSM_TEXT_SLOTS);
        if BSM_Save.I.slots == BSM_SLOTS_FREE then
            b:SetChecked(1);
        else
            b:SetChecked(0);
        end

    elseif name == "BSM_Check_Overall" then
        getglobal(name.."Text"):SetText(BSM_TEXT_OVERALL);
        if BSM_Save.O.enable then
            b:SetChecked(1);
        else
            b:SetChecked(0);
        end
        if b:GetChecked() == 1 then
            getglobal("BSM_Check_Title"):Enable();
            getglobal("BSM_Check_Back"):Enable();
            getglobal("BSM_Check_OverallLabels"):Enable();
            getglobal("BSM_Check_OverallColor"):Enable();
            getglobal("BSM_Check_OverallTotals"):Enable();
            getglobal("BSM_Check_OverallSlots"):Enable();
        else
            getglobal("BSM_Check_Title"):Disable();
            getglobal("BSM_Check_Back"):Disable();
            getglobal("BSM_Check_OverallLabels"):Disable();
            getglobal("BSM_Check_OverallColor"):Disable();
            getglobal("BSM_Check_OverallTotals"):Disable();
            getglobal("BSM_Check_OverallSlots"):Disable();
        end
    elseif name == "BSM_Check_Title" then
        getglobal(name.."Text"):SetText(BSM_TEXT_TITLE);
        if BSM_Save.O.title then
            b:SetChecked(1);
        else
            b:SetChecked(0);
        end
    elseif name == "BSM_Check_Back" then
        getglobal(name.."Text"):SetText(BSM_TEXT_BACK);
        if BSM_Save.O.back then
            b:SetChecked(1);
        else
            b:SetChecked(0);
        end
    elseif name == "BSM_Check_OverallLabels" then
        getglobal(name.."Text"):SetText(BSM_TEXT_LABELS);
        if BSM_Save.O.showlabels then
            b:SetChecked(1);
        else
            b:SetChecked(0);
        end
    elseif name == "BSM_Check_OverallColor" then
        getglobal(name.."Text"):SetText(BSM_TEXT_COLOR);
        if BSM_Save.O.color then
            b:SetChecked(1);
        else
            b:SetChecked(0);
        end
    elseif name == "BSM_Check_OverallTotals" then
        getglobal(name.."Text"):SetText(BSM_TEXT_TOTALS);
        if BSM_Save.O.totals then
            b:SetChecked(1);
        else
            b:SetChecked(0);
        end
    elseif name == "BSM_Check_OverallSlots" then
        getglobal(name.."Text"):SetText(BSM_TEXT_SLOTS);
        if BSM_Save.O.slots == BSM_SLOTS_FREE then
            b:SetChecked(1);
        else
            b:SetChecked(0);
        end
    elseif name == "BSM_Check_OverallLock" then
        getglobal(name.."Text"):SetText(BSM_TEXT_OVERALLLOCK);
        if BSM_Save.O.lock then
            b:SetChecked(1);
        else
            b:SetChecked(0);
        end
    elseif name == "BSM_Options_Position" then
        getglobal(name.."Text"):SetText(BSM_TEXT_OVERALLPOS);

    elseif name == "BSM_Check_Notify" then
        getglobal(name.."Text"):SetText(BSM_TEXT_NOTIFY);
        if BSM_Save.notify then
            b:SetChecked(1);
        else
            b:SetChecked(0);
        end
    elseif name == "BSM_Check_OptionsButton" then
        getglobal(name.."Text"):SetText(BSM_TEXT_OPTBUTTON);
        if BSM_Save.optbutton then
            b:SetChecked(1);
        else
            b:SetChecked(0);
        end
    end
end

--BSM_Chk_Individual:
--    Purpose - Enables/Disables all individual meter elements in options and in UI when the "Enable Individual" option is clicked
--    Parameters - b: the "Enable Individual" check box
--    Returns - Nothing
function BSM_Chk_Individual(b)
    if b:GetChecked() == 1 then
        BSM_EnableIndividualChecks();
        BSM_Save.I.enable = true;
        BSM_EnableAllIndividual();
        BSM_updateFreeSlots();
    else
        BSM_DisableIndividualChecks();
        BSM_Save.I.enable = false;
        BSM_DisableAllIndividual();
    end
end

--BSM_Chk_Overall:
--    Purpose - Enables/Disables all overall meter elements in options and in UI when the "Enable Overall" option is clicked
--    Parameters - b: the "Enable Overall" check box
--    Returns - Nothing
function BSM_Chk_Overall(b)
    if b:GetChecked() == 1 then
        getglobal("BSM_Check_Title"):Enable();
        getglobal("BSM_Check_Back"):Enable();
        getglobal("BSM_Check_OverallLabels"):Enable();
        getglobal("BSM_Check_OverallColor"):Enable();
        getglobal("BSM_Check_OverallTotals"):Enable();
        getglobal("BSM_Check_OverallSlots"):Enable();
        getglobal("BSM_Check_OverallLock"):Enable();
        getglobal("BSM_Options_PositionSet"):Enable();
        BSM_Save.O.enable = true;
        getglobal(BSM_FRAME):Show();
        BSM_updateFreeSlots();
    else
        getglobal("BSM_Check_Title"):Disable();
        getglobal("BSM_Check_Back"):Disable();
        getglobal("BSM_Check_OverallLabels"):Disable();
        getglobal("BSM_Check_OverallColor"):Disable();
        getglobal("BSM_Check_OverallTotals"):Disable();
        getglobal("BSM_Check_OverallSlots"):Disable();
        getglobal("BSM_Check_OverallLock"):Disable();
        getglobal("BSM_Options_PositionSet"):Disable();
        BSM_Save.O.enable = false;
        getglobal(BSM_FRAME):Hide();
    end
end

--BSM_CheckOnClick:
--    Purpose - Makes the necessary checks for enabling/disabling child check boxes and sets necessary variables
--    Parameters - b: the check box that's being clicked
--    Returns - Nothing
function BSM_CheckOnClick(b)
    local name = b:GetName();
    
    if name == "BSM_Check_Individual" then
        BSM_Chk_Individual(b);
    elseif name == "BSM_Check_Overlay" then
        if b:GetChecked() == 1 then
            getglobal("BSM_Check_Bars"):Enable();
            getglobal("BSM_Check_Labels"):Enable();
            BSM_Save.I.overlay = true;
            --if BSM_Save.I.enabled then
                if BSM_Save.I.bars then
                    getglobal(BSM_BARS):Show();
                end
                if BSM_Save.I.showlabels and (BSM_Save.I.bars or BSM_Save.I.labels) then
                    getglobal(BSM_BARS_LABELS):Show();
                end
                BSM_updateFreeSlots();
            --end
        else
            getglobal("BSM_Check_Bars"):Disable();
            getglobal("BSM_Check_Labels"):Disable();
            BSM_Save.I.overlay = false;
            getglobal(BSM_BARS_LABELS):Hide();
            getglobal(BSM_BARS):Hide();
        end
    elseif name == "BSM_Check_Bars" then
        b:SetChecked(1);
        getglobal("BSM_Check_Labels"):SetChecked(0);
        BSM_Save.I.bars = true;
        BSM_Save.I.labels = false;
        --if BSM_Save.I.enabled then
            if BSM_Save.I.showlabels then
                getglobal(BSM_BARS_LABELS):Show();
            end
            getglobal(BSM_BARS):Show();
            BSM_updateFreeSlots();
        --end
    elseif name == "BSM_Check_Labels" then
        b:SetChecked(1);
        getglobal("BSM_Check_Bars"):SetChecked(0);
        BSM_Save.I.labels = true;
        BSM_Save.I.bars = false;
        getglobal(BSM_BARS):Hide();
        --if BSM_Save.I.enabled then
            if BSM_Save.I.showlabels then
                getglobal(BSM_BARS_LABELS):Show();
                BSM_updateFreeSlots();
            end
        --end
    elseif name == "BSM_Check_Dropdown" then
        if b:GetChecked() == 1 then
            getglobal("BSM_Check_Bindings"):Enable();
            BSM_Save.I.dropdowns = true;
            --if BSM_Save.I.enabled then
                getglobal(BSM_DROPDOWNS):Show();
                if BSM_Save.I.showlabels then
                    getglobal(BSM_DROPDOWNS_LABELS):Show();
                end
                BSM_updateFreeSlots();
            --end
        else
            getglobal("BSM_Check_Bindings"):Disable();
            BSM_Save.I.dropdowns = false;
            getglobal(BSM_DROPDOWNS):Hide();
            getglobal(BSM_DROPDOWNS_LABELS):Hide();
        end
    elseif name == "BSM_Check_Bindings" then
        if b:GetChecked() == 1 then
            BSM_Save.I.bindings = true;
            --if BSM_Save.I.enabled then
                if BSM_Save.I.bindings then
                    for i = 0, 4, 1 do
                        getglobal(BSM_DROPDOWNS..i.."Key"):Show();
                    end
                end
            --end
        else
            BSM_Save.I.bindings = false;
            for i = 0, 4, 1 do
                getglobal(BSM_DROPDOWNS..i.."Key"):Hide();
            end
        end
    elseif name == "BSM_Check_IndvLabels" then
        if b:GetChecked() == 1 then
            BSM_Save.I.showlabels = true;
            --if BSM_Save.I.enabled then
                if (BSM_Save.I.bars or BSM_Save.I.labels) and BSM_Save.I.overlay then
                    getglobal(BSM_BARS_LABELS):Show();
                end
                getglobal(BSM_DROPDOWNS_LABELS):Show();
                BSM_updateFreeSlots();
            --end
        else
            BSM_Save.I.showlabels = false;
            getglobal(BSM_BARS_LABELS):Hide();
            getglobal(BSM_DROPDOWNS_LABELS):Hide();
        end
    elseif name == "BSM_Check_IndvColor" then
        if b:GetChecked() == 1 then
            BSM_Save.I.color = true;
        else
            BSM_Save.I.color = false;
        end
        BSM_updateFreeSlots();
    elseif name == "BSM_Check_IndvTotals" then
        if b:GetChecked() == 1 then
            BSM_Save.I.totals = true;
        else
            BSM_Save.I.totals = false;
        end
        BSM_updateFreeSlots();
    elseif name == "BSM_Check_IndvSlots" then
        if b:GetChecked() == 1 then
            BSM_Save.I.slots = BSM_SLOTS_FREE;
        else
            BSM_Save.I.slots = BSM_SLOTS_USED;
        end
        BSM_updateFreeSlots();

    elseif name == "BSM_Check_Overall" then
        BSM_Chk_Overall(b);
    elseif name == "BSM_Check_Title" then
        if b:GetChecked() == 1 then
            BSM_Save.O.title = true;
            --if BSM_Save.O.enabled then
                getglobal("BSM_FrameButtonLabel"):Show();
            --end
        else
            BSM_Save.O.title = false;
            getglobal("BSM_FrameButtonLabel"):Hide();
        end
    elseif name == "BSM_Check_Back" then
        if b:GetChecked() == 1 then
            BSM_Save.O.back = true;
            --if BSM_Save.O.enabled then
                getglobal(BSM_FRAME.."BackAlpha"):Show();
                getglobal(BSM_FRAME.."Border"):Show();
                BSM_FrameStatus:Show();
            --end
        else
            BSM_Save.O.back = false;
            getglobal(BSM_FRAME.."BackAlpha"):Hide();
            getglobal(BSM_FRAME.."Border"):Hide();
            BSM_FrameStatus:Hide();
        end
    elseif name == "BSM_Check_OverallLabels" then
        if b:GetChecked() == 1 then
            BSM_Save.O.showlabels = true;
            --if BSM_Save.O.enabled then
                getglobal("BSM_FrameText"):Show();
                BSM_updateFreeSlots();
            --end
        else
            BSM_Save.O.showlabels = false;
            getglobal("BSM_FrameText"):Hide();
        end
    elseif name == "BSM_Check_OverallColor" then
        if b:GetChecked() == 1 then
            BSM_Save.O.color = true;
        else
            BSM_Save.O.color = false;
        end
        BSM_updateFreeSlots();
    elseif name == "BSM_Check_OverallTotals" then
        if b:GetChecked() == 1 then
            BSM_Save.O.totals = true;
        else
            BSM_Save.O.totals = false;
        end
        BSM_updateFreeSlots();
    elseif name == "BSM_Check_OverallSlots" then
        if b:GetChecked() == 1 then
            BSM_Save.O.slots = BSM_SLOTS_FREE;
        else
            BSM_Save.O.slots = BSM_SLOTS_USED;
        end
        BSM_updateFreeSlots();
    elseif name == "BSM_Check_OverallLock" then
        if b:GetChecked() == 1 then
            BSM_Save.O.lock = true;
        else
            BSM_Save.O.lock = false;
        end
    
    elseif name == "BSM_Check_Notify" then
        if b:GetChecked() == 1 then
            BSM_Save.notify = true;
        else
            BSM_Save.notify = false;
        end
    elseif name == "BSM_Check_OptionsButton" then
        if b:GetChecked() == 1 then
            BSM_Save.optbutton = true;
            getglobal("BSM_OptionsButton"):Show();
        else
            BSM_Save.optbutton = false;
            getglobal("BSM_OptionsButton"):Hide();
        end
    end
end

--BSM_SetPosition:
--    Purpose - Sets the position of the Overall Meter frame according to what is in the X/Y text boxes in the Options frame
--    Parameters - None
--    Returns - Nothing
function BSM_SetPosition()
    local x, y;
    
    --convert the text in the text boxes to numbers
    x = tonumber(getglobal("BSM_Options_PositionX"):GetText());
    y = tonumber(getglobal("BSM_Options_PositionY"):GetText());
    --if the text converted correctly to a number, set the position of the Overall Meter
    if x then
        BSM_Save.dispX = x;
    end
    if y then
        BSM_Save.dispY = y;
    end
    getglobal(BSM_FRAME):ClearAllPoints();
    getglobal(BSM_FRAME):SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", BSM_Save.dispX, BSM_Save.dispY);
end

--BSM_openBag:
--    Purpose - Opens the appropriate bag when hitting a key binding button
--    Parameters - b: the button that was pressed
--    Returns - Nothing
function BSM_openBag(b)
    --name: the name of the button that was pressed
    local name = b:GetName();
    
    --Find the number in the button's name
    name = string.sub( name, string.len(BSM_DROPDOWNS)+1, string.len(BSM_DROPDOWNS)+1 );
    
    --Convert the number string to an actual number and toggle that bag
    ToggleBag( tonumber(name) );
end
