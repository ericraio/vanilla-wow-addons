-- Plug-in for Titan Panel to show the raid members that are soulstoned
-- Author: Lilcure
-- Website: http://www.shadowedsoul.com
--
--
-- Version History
-- before 2.0:
--    o		in guild only testing, it's nice having guinea pigs
-- 2.0:
--		o		initial public release on wowinterface, recode from version 1.0
--				increased efficiency and a lot lower eval cost for each check of
--    		it on update
-- 2.1:
--		o		added icon to the titan panel, and made it so you can choose what shows
--        in the panel instead of just saying Soulstones: you can pick the icon, the label,
--				both or none, credit to TitanBag for learning how to do this
--
--		o		small tweak in one of the raid detection functions.
-- 2.2:
--		o		Added in the ability to show both the high and low times left
--				on the titan panel.  they are selectable from the right click menu
--		o		tweaked where build_tooltip() is called.
-- 3.0:
--      o       total record to coincide with porting to FuBar

-- Version information
local TitanCHKSTONEName = "TitanCHKSTONE";
local TitanCHKSTONEVersion = 3.1;

-- Titan Specific Constants, these are needed to make the plugin appear on the titan bars
TITAN_CHKSTONE_MENU_TEXT =    "Soulstones";
TITAN_CHKSTONE_TOOLTIP =      "Raid members with\nsoulstones\n------------------------";
TITAN_CHKSTONE_BUTTON_LABEL =  "Soulstones";
TITAN_CHKSTONE_FREQUENCY=1;

-- Colors not included in the titan sours that were needed
MAGENTA_FONT_COLOR_CODE_LIL =    "|cffdc143c";
YELLOW_FONT_COLOR_CODE_LIL =     "|cffdaa520";
GREEN_FONT_COLOR_CODE_LIL =      "|cff00FF00";
WHITE_FONT_COLOR_CODE_LIL =      "|cffFFFFFF";

-- Array and constants for the index of that array holding data for the members 
-- of the current raid data is stored in this with the UnitName as the key and
-- the first element is the time and the second element reflects whether the
-- data is good or bad
raid_members = {};
PLAYER_DATA_TIME = 1;
PLAYER_DATA_GOOD = 2;

-- Status Variables
current_high = 0;
current_low = 999999999999;

-- Saved Variables
TITAN_CHKSTONE_HIGH = false;
TITAN_CHKSTONE_LOW = false;

-- Filename of the soulstone buff, this is how we detect if it's up or nto
   BUFF_SEARCH_STRING = "Spell_Shadow_SoulGem";
-- BUFF_SEARCH_STRING = "Fortitude";

-- Variables to hold the info shown either on the titan bar or on the mouseover tooltip
CHKSTONE_TOTAL_STONED = 0;
CHKSTONE_TOOLTIP = "";
CHKSTONE_BUTTON = "";

-- OnLoad handler set the registry variable that titan needs to manage this plugin
function TitanPanelCHKSTONEButton_OnLoad()
	this.registry={
		id="CHKSTONE",
		version = tostring(TitanCHKSTONEVersion),
		menuText=TITAN_CHKSTONE_MENU_TEXT,
		buttonTextFunction="TitanPanelCHKSTONEButton_GetButtonText",
		tooltipTitle = TITAN_CHKSTONE_TOOLTIP,
		tooltipTextFunction = "TitanPanelCHKSTONEButton_GetTooltipText",
		frequency=TITAN_CHKSTONE_FREQUENCY,
		icon = "Interface\\AddOns\\TitanCheckStone\\soulstone",
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
		}
	};
	members = {}
	current_high = 0
	current_low = 999999999999
	CHKSTONE_TOTAL_STONED = 0
	update_data()
end

-- Called by the Titan Panel base addon to setup a right click
-- options menu, at present it just lets the user choose the appearance
-- in the main menu.
function TitanPanelRightClickMenu_PrepareCHKSTONEMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins["CHKSTONE"].menuText);

	TitanPanelRightClickMenu_AddSpacer();	

	local info = {};
	info.text = "Show High Time"
	info.func = ToggleHigh
	if(TITAN_CHKSTONE_HIGH == true) then
		info.checked = 1;
	else
		info.checked = nil;
	end
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = "Show Low Time"
	info.func = ToggleLow
	if(TITAN_CHKSTONE_LOW == true) then
		info.checked = 1;
	else
		info.checked = nil;
	end
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();	

	TitanPanelRightClickMenu_AddToggleIcon("CHKSTONE");
	TitanPanelRightClickMenu_AddToggleLabelText("CHKSTONE");
end

-- Toggle functions to decide whether or not to show the high and low
-- times in the button bar
function ToggleHigh()
	if(TITAN_CHKSTONE_HIGH == true) then
		TITAN_CHKSTONE_HIGH = false;
	else
		TITAN_CHKSTONE_HIGH = true;
	end
end
function ToggleLow()
	if(TITAN_CHKSTONE_LOW == true) then
		TITAN_CHKSTONE_LOW = false;
	else
		TITAN_CHKSTONE_LOW = true;
	end
end

-- Called each second to build the tool tip and store it to the global variable
-- CHKSTONE_TOOLTIP
function build_tooltip()
		CHKSTONE_TOOLTIP = "";
		size = getn(members)
		for k=1, size do
			if(members[k][2] ~= 0) then
				if(members[k][3] == 1) then
					local time_left = calculate_time_left(members[k][2])
												CHKSTONE_TOOLTIP = CHKSTONE_TOOLTIP..WHITE_FONT_COLOR_CODE_LIL..members[k][1]..": "..GREEN_FONT_COLOR_CODE_LIL..time_left..FONT_COLOR_CODE_CLOSE.."\n";
										else
												CHKSTONE_TOOLTIP = CHKSTONE_TOOLTIP..WHITE_FONT_COLOR_CODE_LIL..members[k][1]..": "..YELLOW_FONT_COLOR_CODE_LIL.."UNKNOWN"..FONT_COLOR_CODE_CLOSE.."\n";
				end
			end
		end
	end

	function update_data()
		local numraid = GetNumRaidMembers()
		local numparty = GetNumPartyMembers()
		local member_number = 0
		local button_output = ""
		local stone_colored_output
		current_high = 0
		current_low = 999999999999
		CHKSTONE_TOTAL_STONED = 0
		if(numraid > 1) then
			for i=1, numraid do
				local current_raid_member = "raid"..i
				member_number = check_member_number(current_raid_member)
				check_stone_status(current_raid_member,member_number)
				check_highs_lows(member_number)
			end
		else
			for i=1, numparty do
				local current_raid_member = "party"..i
				member_number = check_member_number(current_raid_member)
				check_stone_status(current_raid_member,member_number)
				check_highs_lows(member_number)
			end
			member_number = check_member_number("player")
			check_stone_status("player",member_number)
			check_highs_lows(member_number)
		end
		if(CHKSTONE_TOTAL_STONED == 0) then
			stone_colored_output = MAGENTA_FONT_COLOR_CODE_LIL..CHKSTONE_TOTAL_STONED
		elseif(CHKSTONE_TOTAL_STONED < 2) then
			stone_colored_output = YELLOW_FONT_COLOR_CODE_LIL..CHKSTONE_TOTAL_STONED
		else
			stone_colored_output = GREEN_FONT_COLOR_CODE_LIL..CHKSTONE_TOTAL_STONED
		end
		button_output = stone_colored_output
		if(TITAN_CHKSTONE_HIGH == true) then
			if(current_high ~= 0) then
				button_output = button_output..WHITE_FONT_COLOR_CODE_LIL.." High: "..calculate_time_left(current_high)
			else
				button_output = button_output..WHITE_FONT_COLOR_CODE_LIL.." High: ".."UNKNOWN"
			end
		end
		if(TITAN_CHKSTONE_LOW == true) then
			if(current_low ~= 999999999999) then
				button_output = button_output..WHITE_FONT_COLOR_CODE_LIL.." Low: "..calculate_time_left(current_low)
			else
				button_output = button_output..WHITE_FONT_COLOR_CODE_LIL.." Low: ".."UNKNOWN"
			end
		end
		CHKSTONE_BUTTON = button_output
	end
	
	function check_member_number(unit)
		local size = getn(members)
		local found = -1
		if(members == nil or size == 0) then
			found = -99
		else
			for i=1,size do
				if(members[i][1] == UnitName(unit)) then
					found = i
				end
			end
		end
		if(found == -99) then
			members = {}
			found = -1
		end
		if(found == -1) then
			if(check_buff_present(unit) == 1) then
				members[getn(members)+1] = { UnitName(unit), time(), 0 }
			else
				members[getn(members)+1] = { UnitName(unit), 0, 0 }
			end
			found = getn(members)
		end
	  return found
	end
	
	function check_buff_present(current_raid_member)
		local buff_found = 0
		local buff_ittr = 1
		while (UnitBuff(current_raid_member, buff_ittr)) do
			if (string.find(UnitBuff(current_raid_member,buff_ittr), BUFF_SEARCH_STRING)) then
				buff_found = 1
			end
 			buff_ittr = buff_ittr + 1
		end
	  return buff_found
	end
	
	function calculate_time_left(recorded_time)
		local elapsed_seconds = time() - recorded_time
		local total_seconds = 1800 - elapsed_seconds
		local leftover_seconds = mod(total_seconds,60)
		local total_minutes = (total_seconds - leftover_seconds) / 60
		local seconds_string = ""
		local minutes_string = ""
		if(leftover_seconds < 10) then
				seconds_string = "0"..leftover_seconds
		else
				seconds_string = leftover_seconds
		end
		if(total_minutes == 0) then
				minutes_string = "00"
		else
				minutes_string = total_minutes
		end
	  return minutes_string..":"..seconds_string
	end
	
	function check_stone_status(unit, number)
		if(check_buff_present(unit) == 1) then
			CHKSTONE_TOTAL_STONED = CHKSTONE_TOTAL_STONED + 1
			if(members[number][2] == 0) then
				members[number] = { UnitName(unit) , time(), 1 }
			end
		else
			if(members[number][2] ~= 0) then
				announce_lost_stone(number)
				members[number] = { UnitName(unit), 0, 1 }
			end
		end
	end
	
	function check_highs_lows(number)
		if(members[number][2] ~= 0) then
			if(members[number][3] ~= 0) then
				if(members[number][2] > current_high) then
					current_high = members[number][2]
				end
				if(members[number][2] < current_low) then
					current_low = members[number][2]
				end
			end
		end
	end
		
	function announce_lost_stone(number)
		if(DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage("*** "..members[number][1].." has lost their SOULSTONE! ***", 1, 1, 1, 1, 5)
		end
		if(CT_RAMessageFrame) then
			CT_RAMessageFrame:AddMessage("*** "..members[number][1].." has lost their SOULSTONE! ***", 1, 1, 1, 1, 5)
		end
	end
			

-- Called each second by the titan panel plugin to update the raid member array and
-- to update both the button and the tooltip text.  It returns number of soulstones
-- colored based on how many there are.
function TitanPanelCHKSTONEButton_GetButtonText(id)
	local total_stones_text = "";
		update_data();
		build_tooltip();
	return TITAN_CHKSTONE_BUTTON_LABEL, ": "..CHKSTONE_BUTTON;
end

-- Calls for the tooltip to be built and returns it to the titan panel addon
function TitanPanelCHKSTONEButton_GetTooltipText()
	return TitanUtils_GetHighlightText(CHKSTONE_TOOLTIP);
end
