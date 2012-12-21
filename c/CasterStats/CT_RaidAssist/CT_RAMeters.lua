CT_RAMeters_ColorTable = {
	[CT_RA_HUNTER] = "|c00AAD372",
	[CT_RA_WARLOCK] = "|c009382c9",
	[CT_RA_PRIEST] = "|c00FFFFFF",
	[CT_RA_PALADIN] = "|c00F48CBA",
	[CT_RA_MAGE] = "|c0068CCEF",
	[CT_RA_ROGUE] = "|c00FFF468",
	[CT_RA_DRUID] = "|c00FF7C0A",
	[CT_RA_SHAMAN] = "|c00F48CBA",
	[CT_RA_WARRIOR] = "|c00C69B6D"
};
CT_RAMeters_StatsTable = {
	["Generic"] = {
		["isDead"] = 0,
		["isAfk"] = 0,
		["isOffline"] = 0
	},
	[CT_RA_WARRIOR] = { ["health"] = 0, ["mana"] = 0, ["num"] = 0 },
	[CT_RA_DRUID] = { ["health"] = 0, ["mana"] = 0, ["num"] = 0 },
	[CT_RA_MAGE] = { ["health"] = 0, ["mana"] = 0, ["num"] = 0 },
	[CT_RA_WARLOCK] = { ["health"] = 0, ["mana"] = 0, ["num"] = 0 },
	[CT_RA_ROGUE] = { ["health"] = 0, ["mana"] = 0, ["num"] = 0 },
	[CT_RA_HUNTER] = { ["health"] = 0, ["mana"] = 0, ["num"] = 0 },
	[CT_RA_PRIEST] = { ["health"] = 0, ["mana"] = 0, ["num"] = 0 },
	[CT_RA_PALADIN] = { ["health"] = 0, ["mana"] = 0, ["num"] = 0 },
	[CT_RA_SHAMAN] = { ["health"] = 0, ["mana"] = 0, ["num"] = 0 }
}
	
function CT_RAMeters_InitDropDown()
	local info;
	if ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then
		info = {};
		info.text = UIDROPDOWNMENU_MENU_VALUE;
		info.justifyH = "CENTER";
		info.isTitle = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		
		local nonManaUsers = {
			[CT_RA_ROGUE] = 1,
			[CT_RA_WARRIOR] = 1
		};
		for k, v in CT_RA_ClassPositions do
			if ( ( UIDROPDOWNMENU_MENU_VALUE == "Health Display" or UIDROPDOWNMENU_MENU_VALUE == "Raid Health" ) or not nonManaUsers[k] ) then
				if ( ( k ~= CT_RA_SHAMAN or ( UnitFactionGroup("player") and UnitFactionGroup("player") == "Horde" ) ) and ( k ~= CT_RA_PALADIN or ( UnitFactionGroup("player") and UnitFactionGroup("player") == "Alliance" ) ) ) then
					info = { };
					info.text = k;
					info.value = { UIDROPDOWNMENU_MENU_VALUE, k };
					info.checked = ( CT_RAMenu_Options["temp"]["StatusMeters"] and CT_RAMenu_Options["temp"]["StatusMeters"][UIDROPDOWNMENU_MENU_VALUE][k] );
					info.keepShownOnClick = 1;
					info.func = CT_RAMeters_DropDown_OnClick;
					UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
				end
			end
		end
		return;
	end
	info = {};
	info.text = "RaidStatus";
	info.justifyH = "CENTER";
	info.isTitle = 1;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = "Health Display";
	info.hasArrow = 1;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = "Mana Display";
	info.hasArrow = 1;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = "Raid Health";
	info.hasArrow = 1;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = "Raid Mana";
	info.hasArrow = 1;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = "AFK Count";
	info.value = "AFK Count";
	info.checked = ( CT_RAMenu_Options["temp"]["StatusMeters"] and CT_RAMenu_Options["temp"]["StatusMeters"]["AFK Count"] );
	info.keepShownOnClick = 1;
	info.func = CT_RAMeters_DropDown_OnClick;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = "Dead Count";
	info.value = "Dead Count";
	info.checked = ( CT_RAMenu_Options["temp"]["StatusMeters"] and CT_RAMenu_Options["temp"]["StatusMeters"]["Dead Count"] );
	info.keepShownOnClick = 1;
	info.func = CT_RAMeters_DropDown_OnClick;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = "Offline Count";
	info.value = "Offline Count";
	info.checked = ( CT_RAMenu_Options["temp"]["StatusMeters"] and CT_RAMenu_Options["temp"]["StatusMeters"]["Offline Count"] );
	info.keepShownOnClick = 1;
	info.func = CT_RAMeters_DropDown_OnClick;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.disabled = 1;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	if ( CT_RAMenu_Options["temp"]["StatusMeters"] and CT_RAMenu_Options["temp"]["StatusMeters"]["Lock"] ) then
		info.text = "Unlock Window";
	else
		info.text = "Lock Window";
	end
	info.value = "LockMeter";
	info.notCheckable = 1;
	info.func = CT_RAMeters_DropDown_OnClick;
	UIDropDownMenu_AddButton(info);
	
	info = { };
	info.text = "Background Color";
	info.hasColorSwatch = 1;
	info.hasOpacity = 1;
	if ( CT_RAMenu_Options["temp"]["StatusMeters"] and CT_RAMenu_Options["temp"]["StatusMeters"]["Background"] ) then
		info.r = ( CT_RAMenu_Options["temp"]["StatusMeters"]["Background"].r );
		info.g = ( CT_RAMenu_Options["temp"]["StatusMeters"]["Background"].g );
		info.b = ( CT_RAMenu_Options["temp"]["StatusMeters"]["Background"].b );
		info.opacity = ( CT_RAMenu_Options["temp"]["StatusMeters"]["Background"].a );
	else
		info.r = 0;
		info.g = 0;
		info.b = 1;
		info.opacity = 0.5;
	end
	info.notClickable = 1;
	info.swatchFunc = CT_RAMeters_DropDown_SwatchFunc;
	info.opacityFunc = CT_RAMeters_DropDown_OpacityFunc;
	info.cancelFunc = CT_RAMeters_DropDown_CancelFunc;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = "|c00FF8080Hide Window|r";
	info.value = "Hide";
	info.notCheckable = 1;
	info.func = CT_RAMeters_DropDown_OnClick;
	UIDropDownMenu_AddButton(info);
end

function CT_RAMeters_DropDown_SwatchFunc()
	if ( not CT_RAMenu_Options["temp"]["StatusMeters"] ) then
		CT_RAMenu_Options["temp"]["StatusMeters"] = {
			["Health Display"] = { },
			["Mana Display"] = { },
			["Raid Health"] = { },
			["Raid Mana"] = { },
			["Background"] = {
				["r"] = 0,
				["g"] = 0,
				["b"] = 1,
				["a"] = 0.5
			}
		};
	end
	local r, g, b = ColorPickerFrame:GetColorRGB();
	CT_RAMenu_Options["temp"]["StatusMeters"]["Background"]["r"] = r;
	CT_RAMenu_Options["temp"]["StatusMeters"]["Background"]["g"] = g;
	CT_RAMenu_Options["temp"]["StatusMeters"]["Background"]["b"] = b;
	CT_RAMetersFrame:SetBackdropColor(r, g, b, CT_RAMenu_Options["temp"]["StatusMeters"]["Background"]["a"]);
end

function CT_RAMeters_DropDown_OpacityFunc()
	if ( not CT_RAMenu_Options["temp"]["StatusMeters"] ) then
		CT_RAMenu_Options["temp"]["StatusMeters"] = {
			["Health Display"] = { },
			["Mana Display"] = { },
			["Raid Health"] = { },
			["Raid Mana"] = { },
			["Background"] = {
				["r"] = 0,
				["g"] = 0,
				["b"] = 1,
				["a"] = 0.5
			}
		};
	end
	local a = OpacitySliderFrame:GetValue();
	CT_RAMenu_Options["temp"]["StatusMeters"]["Background"]["a"] = a;
	CT_RAMetersFrame:SetBackdropColor(CT_RAMenu_Options["temp"]["StatusMeters"]["Background"].r, CT_RAMenu_Options["temp"]["StatusMeters"]["Background"].g, CT_RAMenu_Options["temp"]["StatusMeters"]["Background"].b, a);
	CT_RAMetersFrame:SetBackdropBorderColor(1, 1, 1, a);
end

function CT_RAMeters_DropDown_CancelFunc(val)
	CT_RAMenu_Options["temp"]["StatusMeters"]["Background"] = { 
		["r"] = val.r,
		["g"] = val.g,
		["b"] = val.b,
		["a"] = val.opacity
	};
	CT_RAMetersFrame:SetBackdropColor(val.r, val.g, val.b, val.opacity);
	CT_RAMetersFrame:SetBackdropBorderColor(1, 1, 1, val.opacity);
end

function CT_RAMeters_OnLoad()
	this:SetBackdropColor(0, 0, 1, 0.5);
end

function CT_RAMeters_DropDown_OnLoad()
	UIDropDownMenu_Initialize(this, CT_RAMeters_InitDropDown, "MENU");
end

function CT_RAMeters_DropDown_OnClick()
	-- Create the table if we haven't already
	if ( not CT_RAMenu_Options["temp"]["StatusMeters"]  ) then
		CT_RAMenu_Options["temp"]["StatusMeters"] = {
			["Health Display"] = { },
			["Mana Display"] = { },
			["Raid Health"] = { },
			["Raid Mana"] = { },
			["Background"] = {
				["r"] = 0,
				["g"] = 0,
				["b"] = 1,
				["a"] = 0.5
			}
		};
	end
	if ( this.value == "LockMeter" ) then
		CT_RAMenu_Options["temp"]["StatusMeters"]["Lock"] = not CT_RAMenu_Options["temp"]["StatusMeters"]["Lock"];
		return;
	elseif ( this.value == "Hide" ) then
		CT_RAMenuFrameGeneralMiscShowMetersCB:SetChecked(false);
		CT_RAMenu_Options["temp"]["StatusMeters"]["Show"] = nil;
		CT_RAMetersFrame:Hide();
		return;
	end
	
	if ( type(this.value) == "table" ) then
		-- We have either HP or Mana Display/Totals
		CT_RAMenu_Options["temp"]["StatusMeters"][this.value[1]][this.value[2]] = not CT_RAMenu_Options["temp"]["StatusMeters"][this.value[1]][this.value[2]];
	else
		-- Just AFK Count/Dead Count
		CT_RAMenu_Options["temp"]["StatusMeters"][this.value] = not CT_RAMenu_Options["temp"]["StatusMeters"][this.value];
	end
	CT_RAMeters_UpdateWindow();
end

function CT_RAMeters_UpdateWindow()
	if ( not CT_RAMenu_Options["temp"]["StatusMeters"] or GetNumRaidMembers() == 0 ) then
		CT_RAMetersFrameText:SetText("No stats to track");
		CT_RAMetersFrame:SetWidth(125);
		CT_RAMetersFrame:SetHeight(41);
		return;
	end
	CT_RAMeters_StatsTable = {
		["Generic"] = {
			["isDead"] = 0,
			["isAfk"] = 0,
			["isOffline"] = 0
		},
		[CT_RA_WARRIOR] = { ["health"] = 0, ["mana"] = 0, ["num"] = 0 },
		[CT_RA_DRUID] = { ["health"] = 0, ["mana"] = 0, ["num"] = 0 },
		[CT_RA_MAGE] = { ["health"] = 0, ["mana"] = 0, ["num"] = 0 },
		[CT_RA_WARLOCK] = { ["health"] = 0, ["mana"] = 0, ["num"] = 0 },
		[CT_RA_ROGUE] = { ["health"] = 0, ["mana"] = 0, ["num"] = 0 },
		[CT_RA_HUNTER] = { ["health"] = 0, ["mana"] = 0, ["num"] = 0 },
		[CT_RA_PRIEST] = { ["health"] = 0, ["mana"] = 0, ["num"] = 0 },
		[CT_RA_PALADIN] = { ["health"] = 0, ["mana"] = 0, ["num"] = 0 },
		[CT_RA_SHAMAN] = { ["health"] = 0, ["mana"] = 0, ["num"] = 0 }
	};
	local stats = {
		["hpDisplay"] = { "", 0 },
		["mpDisplay"] = { "", 0 },
		["raidHp"] = { "", 1 },
		["raidMp"] = { "", 1 },
		["deadCount"] = { "", 1 },
		["afkCount"] = { "", 1 },
		["offlineCount"] = { "", 1 }
	};
	
	-- Get all the stats
	for i = 1, GetNumRaidMembers(), 1 do
		local id = "raid" .. i;
		if ( UnitIsConnected(id) ) then
			local name = UnitName(id);
			local class, health, mana, isDead, isAfk = UnitClass(id), 0, 0, ( ( UnitIsDead(id) or UnitIsGhost(id) ) and ( not CT_RA_Stats[name] or not CT_RA_Stats[name]["FD"] ) ), ( CT_RA_Stats[name] and CT_RA_Stats[name]["AFK"] );
			if ( class and CT_RAMeters_StatsTable[class] ) then
				if ( 
					( CT_RAMenu_Options["temp"]["StatusMeters"]["Raid Health"] and CT_RAMenu_Options["temp"]["StatusMeters"]["Raid Health"][class] ) or
					( CT_RAMenu_Options["temp"]["StatusMeters"]["Health Display"] and CT_RAMenu_Options["temp"]["StatusMeters"]["Health Display"][class] )
				) then
					health = UnitHealth(id)/UnitHealthMax(id);
				end
				if ( 
					( CT_RAMenu_Options["temp"]["StatusMeters"]["Raid Mana"] and CT_RAMenu_Options["temp"]["StatusMeters"]["Raid Mana"][class] ) or
					( CT_RAMenu_Options["temp"]["StatusMeters"]["Mana Display"] and CT_RAMenu_Options["temp"]["StatusMeters"]["Mana Display"][class] )
				) then
					mana = UnitMana(id)/UnitManaMax(id);
				end
				CT_RAMeters_StatsTable[class]["health"] = CT_RAMeters_StatsTable[class]["health"] + health;
				CT_RAMeters_StatsTable[class]["mana"] = CT_RAMeters_StatsTable[class]["mana"] + mana;
				if ( isDead ) then
					CT_RAMeters_StatsTable["Generic"]["isDead"] = CT_RAMeters_StatsTable["Generic"]["isDead"] + 1;
				end
				if ( isAfk ) then
					CT_RAMeters_StatsTable["Generic"]["isAfk"] = CT_RAMeters_StatsTable["Generic"]["isAfk"] + 1;
				end
				CT_RAMeters_StatsTable[class]["num"] = CT_RAMeters_StatsTable[class]["num"] + 1;
			end
		else
			CT_RAMeters_StatsTable["Generic"]["isOffline"] = CT_RAMeters_StatsTable["Generic"]["isOffline"] + 1;
		end
	end
	
	-- Raid Health
	if ( CT_RAMenu_Options["temp"]["StatusMeters"]["Raid Health"] ) then
		local combinedHealth, numHealth = 0, 0;
		for k, v in CT_RAMenu_Options["temp"]["StatusMeters"]["Raid Health"] do
			if ( v and CT_RAMeters_StatsTable[k] and CT_RAMeters_StatsTable[k]["num"] > 0 ) then
				combinedHealth, numHealth = combinedHealth + CT_RAMeters_StatsTable[k]["health"], numHealth + CT_RAMeters_StatsTable[k]["num"];
			end
		end
		if ( numHealth > 0 ) then
			combinedHealth = floor(combinedHealth/numHealth*100+0.5);
			stats["raidHp"][1] = "Raid Health: " .. combinedHealth .. "%";
		end
	end
	
	-- Raid Mana
	if ( CT_RAMenu_Options["temp"]["StatusMeters"]["Raid Mana"] ) then
		local combinedMana, numMana = 0, 0;
		for k, v in CT_RAMenu_Options["temp"]["StatusMeters"]["Raid Mana"] do
			if ( v and CT_RAMeters_StatsTable[k] and CT_RAMeters_StatsTable[k]["num"] > 0 ) then
				combinedMana = combinedMana + CT_RAMeters_StatsTable[k]["mana"];
				numMana = numMana + CT_RAMeters_StatsTable[k]["num"];
			end
		end
		if ( numMana > 0 ) then
			combinedMana = floor(combinedMana/numMana*100+0.5);
			stats["raidMp"][1] = "Raid Mana: " .. combinedMana .. "%";
		end
	end
	
	-- AFK Count
	if ( CT_RAMenu_Options["temp"]["StatusMeters"]["AFK Count"] ) then
		stats["afkCount"][1] = "AFK Count: " .. CT_RAMeters_StatsTable["Generic"]["isAfk"];
	end
	
	-- Dead Count
	if ( CT_RAMenu_Options["temp"]["StatusMeters"]["Dead Count"] ) then
		stats["deadCount"][1] = "Dead Count: " .. CT_RAMeters_StatsTable["Generic"]["isDead"];
	end
	
	-- Offline Count
	if ( CT_RAMenu_Options["temp"]["StatusMeters"]["Offline Count"] ) then
		stats["offlineCount"][1] = "Offline Count: " .. CT_RAMeters_StatsTable["Generic"]["isOffline"];
	end
	
	-- Health Display
	if ( CT_RAMenu_Options["temp"]["StatusMeters"]["Health Display"] ) then
		for k, v in CT_RAMenu_Options["temp"]["StatusMeters"]["Health Display"] do
			if ( v and CT_RAMeters_StatsTable[k] and CT_RAMeters_StatsTable[k]["num"] > 0 ) then
				if ( strlen(stats["hpDisplay"][1]) > 0 ) then
					stats["hpDisplay"][1] = stats["hpDisplay"][1] .. "\n";
				end
				stats["hpDisplay"][1] = stats["hpDisplay"][1] .. CT_RAMeters_ColorTable[k] .. k .. " Health: " .. floor(CT_RAMeters_StatsTable[k]["health"]/CT_RAMeters_StatsTable[k]["num"]*100+0.5) .. "%|r";
				stats["hpDisplay"][2] = stats["hpDisplay"][2] + 1;
			end
		end
	end
	
	-- Mana Display
	if ( CT_RAMenu_Options["temp"]["StatusMeters"]["Mana Display"]) then
		for k, v in CT_RAMenu_Options["temp"]["StatusMeters"]["Mana Display"] do
			if ( v and CT_RAMeters_StatsTable[k] and CT_RAMeters_StatsTable[k]["num"] > 0 ) then
				if ( strlen(stats["mpDisplay"][1]) > 0 ) then
					stats["mpDisplay"][1] = stats["mpDisplay"][1] .. "\n";
				end
				stats["mpDisplay"][1] = stats["mpDisplay"][1] .. CT_RAMeters_ColorTable[k] .. k .. " Mana: " .. floor(CT_RAMeters_StatsTable[k]["mana"]/CT_RAMeters_StatsTable[k]["num"]*100+0.5) .. "%|r";
				stats["mpDisplay"][2] = stats["mpDisplay"][2] + 1;
			end
		end
	end
	
	-- Add together all the stats
	local out, numLines = "", 0;
	local order = {
		{ "raidHp", "|c00FF2222", "|r" },
		{ "raidMp", "|c006666FF", "|r" },
		{ "hpDisplay", "", "" },
		{ "mpDisplay", "", "" },
		{ "deadCount", "|c00666666", "|r" },
		{ "afkCount", "|c00CCCCCC", "|r" },
		{ "offlineCount", "|c00999999", "|r" }
	};
	for i = 1, 7, 1 do
		local val = stats[order[i][1]];
		if ( strlen(val[1]) > 0 ) then
			if ( strlen(out) > 0 ) then
				out = out .. "\n";
			end
			out = out .. order[i][2] .. val[1] .. order[i][3];
			numLines = numLines + val[2];
		end
	end
	if ( out == "" ) then
		numLines = 1;
		CT_RAMetersFrameText:SetText("No stats to track");
	else
		CT_RAMetersFrameText:SetText(out);
	end
	local width = CT_RAMetersFrameText:GetStringWidth();
	if ( width < 109 ) then
		width = 109;
	end
	CT_RAMetersFrame:SetWidth(width+16);
	CT_RAMetersFrame:SetHeight(25+(numLines*16));
end

function CT_RAMeters_OnUpdate(elapsed)
	this.update = this.update - elapsed;
	if ( this.update <= 0 ) then
		this.update = 2;
		CT_RAMeters_UpdateWindow();
	end
end