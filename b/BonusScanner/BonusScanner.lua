--------------------------------------------------
-- BonusScanner v1.1
-- by Crowley <crowley@headshot.de>
-- performance improvements by Archarodim
--
-- get the latest version here:
-- http://ui.worldofwar.net/ui.php?id=1461
-- http://www.curse-gaming.com/mod.php?addid=2384
--------------------------------------------------

BONUSSCANNER_VERSION = "v1.0";


BONUSSCANNER_PATTERN_SETNAME = "^(.*) %(%d/%d%)$";
BONUSSCANNER_PATTERN_GENERIC_PREFIX = "^%+(%d+)%%?(.*)$";
BONUSSCANNER_PATTERN_GENERIC_SUFFIX = "^(.*)%+(%d+)%%?$";

BonusScanner = {
	bonuses = {};
	bonuses_details = {};

    IsUpdating		    = false; -- not sure if this check is needed but who knows with multithreading...
    MinCheckInterval	    = 1;	 -- Minimum time to wait between each scan
    CheckIntervalCounter    = 0;	 -- counter, do not change
    CheckForBonusPlease	    = 0;	 -- The flag that when set makes BonusScanner scan the equipment and call the update function
    ShowDebug		    = false; -- tells when the equipment is scanned

	active = nil;
	temp = { 
		sets = {},
		set = "",
		slot = "",
		bonuses = {},
		details = {}
	};

	types = {
		"STR", 			-- strength	
		"AGI", 			-- agility
		"STA", 			-- stamina
		"INT", 			-- intellect
		"SPI", 			-- spirit
		"ARMOR", 		-- reinforced armor (not base armor)
  
		"ARCANERES",	-- arcane resistance
		"FIRERES",  	-- fire resistance
		"NATURERES",	-- nature resistance 	
		"FROSTRES", 	-- frost resistance
		"SHADOWRES",	-- shadow resistance
	
		"FISHING",  	-- fishing skill
		"MINING",		-- mining skill
		"HERBALISM",	-- herbalism skill
		"SKINNING", 	-- skinning skill
		"DEFENSE",  	-- defense skill

		"BLOCK",    	-- chance to block
		"DODGE",		-- chance to dodge
		"PARRY",		-- chance to parry
		"ATTACKPOWER",	-- attack power
		"ATTACKPOWERUNDEAD", -- attack power against undead
		
		"CRIT",			-- chance to get a critical strike
		"RANGEDATTACKPOWER", -- ranged attack power
		"RANGEDCRIT",	-- chance to get a crit with ranged weapons
		"TOHIT",		-- chance to hit

		"DMG",			-- spell damage
		"DMGUNDEAD",	-- spell damage against undead
		
		"ARCANEDMG",	-- arcane spell damage
		"FIREDMG",		-- fire spell damage
		"FROSTDMG",		-- frost spell damage
		"HOLYDMG",		-- holy spell damage
		"NATUREDMG",	-- nature spell damage
		"SHADOWDMG",	-- shadow spell damage
		"SPELLCRIT",	-- chance to crit with spells
		"HEAL",			-- healing 
		"HOLYCRIT", 	-- chance to crit with holy spells
		"SPELLTOHIT", 	-- Chance to Hit with spells

		"SPELLPEN", 	-- amount of spell resist reduction

		"HEALTHREG",	-- health regeneration per 5 sec.
		"MANAREG",		-- mana regeneration per 5 sec.
		"HEALTH",		-- health points
		"MANA",			-- mana points
	};

	slots = {
		"Head",
		"Neck",
		"Shoulder",
		"Shirt",
		"Chest",
		"Waist",
		"Legs",
		"Feet",
		"Wrist",
		"Hands",
		"Finger0",
		"Finger1",
		"Trinket0",
		"Trinket1",
		"Back",
		"MainHand",
		"SecondaryHand",
		"Ranged",
		"Tabard",
	};
}

-- Update function to hook into. 
-- Gets called, when Equipment changes (after UNIT_INVENTORY_CHANGED)
function BonusScanner_Update()
end

function BonusScanner:GetBonus(bonus)
	if(BonusScanner.bonuses[bonus]) then
		return BonusScanner.bonuses[bonus];
	end;
	return 0;
end

function BonusScanner:GetSlotBonuses(slotname)
	local i, bonus, details;
	local bonuses = {};
	for bonus, details in BonusScanner.bonuses_details do
		if(details[slotname]) then
			bonuses[bonus] = details[slotname];
		end
	end
	return bonuses;
end

function BonusScanner:GetBonusDetails(bonus)
	if(BonusScanner.bonuses_details[bonus]) then
		return BonusScanner.bonuses_details[bonus];
	end;
	return {};
end

function BonusScanner:GetSlotBonus(bonus, slotname)
	if(BonusScanner.bonuses_details[bonus]) then
		if(BonusScanner.bonuses_details[bonus][slotname]) then
			return BonusScanner.bonuses_details[bonus][slotname];
		end;
	end;
	return 0;
end


function BonusScanner:OnLoad()
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
end

function BonusScanner:OnEvent()

    BonusScanner:Debug(event);

    if ((event == "UNIT_INVENTORY_CHANGED") and BonusScanner.active) then
		BonusScanner.CheckForBonusPlease = 1;
	return;
    end
	if (event == "PLAYER_ENTERING_WORLD") then
		BonusScanner.active = 1;
		BonusScanner.CheckForBonusPlease = 1;
		this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	return;
	end
	if (event == "PLAYER_LEAVING_WORLD") then
		this:UnregisterEvent("UNIT_INVENTORY_CHANGED");
	return;
    end	
end


-- A little debug function
function BonusScanner:Debug( Message )
    if (BonusScanner.ShowDebug) then
	DEFAULT_CHAT_FRAME:AddMessage("Bonnus-Scanner: " .. Message, 0.5, 0.8, 1);
	end	
end

-- The use of the <OnUpdate></OnUpdate> *feature* avoid freezes and lags caused by the useless repeated call of BonusScanner:ScanEquipment()...
function BonusScanner:OnUpdate (elapsed)

    -- BonusScanner:Debug(elapsed);
    if (BonusScanner.IsUpdating) then
		return;
    end

    BonusScanner.IsUpdating = true;

    -- if the equipment has changed then check if we are allowed to test for bonuses
    if (BonusScanner.CheckForBonusPlease == 1) then

	BonusScanner.CheckIntervalCounter = BonusScanner.CheckIntervalCounter + elapsed;

	-- if we have wait long enough then proceed...
	if (BonusScanner.CheckIntervalCounter > BonusScanner.MinCheckInterval) then
	    BonusScanner.CheckForBonusPlease = 2; -- means we are currently checking
	    BonusScanner:ScanEquipment(); -- scan the equiped items
	    BonusScanner_Update();	  -- call the update function (for the mods using this library)
	    if (BonusScanner.CheckForBonusPlease ~= 1) then -- if no other update has been requested
		BonusScanner.CheckForBonusPlease = 0;
	    end
	    BonusScanner.CheckIntervalCounter = 0;
	end
    end

    BonusScanner.IsUpdating = false;
end

function BonusScanner:ScanEquipment()
	local slotid, slotname, hasItem, i;

	BonusScannerTooltip:SetOwner(UIParent, "ANCHOR_NONE");

    BonusScanner:Debug("Scanning Equipment has requested");

	BonusScanner.temp.bonuses = {};
	BonusScanner.temp.details = {};
	BonusScanner.temp.sets = {};
	BonusScanner.temp.set = "";

	for i, slotname in BonusScanner.slots do
		slotid, _ = GetInventorySlotInfo(slotname.. "Slot");
		hasItem = BonusScannerTooltip:SetInventoryItem("player", slotid);
	
		if ( hasItem ) then
			BonusScanner.temp.slot = slotname;
			BonusScanner:ScanTooltip();
			-- if set item, mark set as already scanned
			if(BonusScanner.temp.set ~= "") then
				BonusScanner.temp.sets[BonusScanner.temp.set] = 1;
			end;
		end
	end
	BonusScanner.bonuses = BonusScanner.temp.bonuses;
	BonusScanner.bonuses_details = BonusScanner.temp.details;
end

function BonusScanner:ScanItem(itemlink)
	local name = GetItemInfo(itemlink);
	if(name) then
		BonusScanner.temp.bonuses = {};
		BonusScanner.temp.sets = {};
		BonusScanner.temp.set = "";
		BonusScanner.temp.slot = "";
		BonusScannerTooltip:SetHyperlink(itemlink);
		BonusScanner:ScanTooltip();
		return BonusScanner.temp.bonuses;
	end
	return false;
end

function BonusScanner:ScanTooltip()
	local tmpTxt, line;
	local lines = BonusScannerTooltip:NumLines();

	for i=2, lines, 1 do
		tmpText = getglobal("BonusScannerTooltipTextLeft"..i);
		val = nil;
		if (tmpText:GetText()) then
			line = tmpText:GetText();
			BonusScanner:ScanLine(line);
		end
	end
end

function BonusScanner:AddValue(effect, value)
	local i,e;
	
	if(type(effect) == "string") then
		if(BonusScanner.temp.bonuses[effect]) then
			BonusScanner.temp.bonuses[effect] = BonusScanner.temp.bonuses[effect] + value;
		else
			BonusScanner.temp.bonuses[effect] = value;
		end
		
		if(BonusScanner.temp.slot) then
			if(BonusScanner.temp.details[effect]) then
				if(BonusScanner.temp.details[effect][BonusScanner.temp.slot]) then
					BonusScanner.temp.details[effect][BonusScanner.temp.slot] = BonusScanner.temp.details[effect][BonusScanner.temp.slot] + value;
				else
					BonusScanner.temp.details[effect][BonusScanner.temp.slot] = value;
				end
			else
				BonusScanner.temp.details[effect] = {};
				BonusScanner.temp.details[effect][BonusScanner.temp.slot] = value;
			end
		end;
	else 
	-- list of effects
		if(type(value) == "table") then
			for i,e in effect do
				BonusScanner:AddValue(e, value[i]);
			end
		else
			for i,e in effect do
				BonusScanner:AddValue(e, value);
			end
		end
	end
end;

function BonusScanner:ScanLine(line)
	local tmpStr, found;
	-- Check for "Equip: "
	if(string.sub(line,0,string.len(BONUSSCANNER_PREFIX_EQUIP)) == BONUSSCANNER_PREFIX_EQUIP) then

		tmpStr = string.sub(line,string.len(BONUSSCANNER_PREFIX_EQUIP)+1);
		BonusScanner:CheckPassive(tmpStr);

	-- Check for "Set: "
	elseif(string.sub(line,0,string.len(BONUSSCANNER_PREFIX_SET)) == BONUSSCANNER_PREFIX_SET
			and BonusScanner.temp.set ~= "" 
			and not BonusScanner.temp.sets[BonusScanner.temp.set]) then

		tmpStr = string.sub(line,string.len(BONUSSCANNER_PREFIX_SET)+1);
		BonusScanner.temp.slot = "Set";
		BonusScanner:CheckPassive(tmpStr);

	-- any other line (standard stats, enchantment, set name, etc.)
	else
		-- Check for set name
		_, _, tmpStr = string.find(line, BONUSSCANNER_PATTERN_SETNAME);
		if(tmpStr) then
			BonusScanner.temp.set = tmpStr;
		else
			found = BonusScanner:CheckGeneric(line);
			if(not found) then
				BonusScanner:CheckOther(line);
			end;
		end
	end
end;


-- Scans passive bonuses like "Set: " and "Equip: "
function BonusScanner:CheckPassive(line)
	local i, p, value, found;

	found = nil;
	for i,p in BONUSSCANNER_PATTERNS_PASSIVE do
		_, _, value = string.find(line, "^" .. p.pattern);
		if(value) then
			BonusScanner:AddValue(p.effect, value)
			found = 1;
			break; -- prevent duplicated patterns to cause bonuses to be counted several times
		end
	end
	if(not found) then
BonusScanner:Debug("\"" .. line .. "\"");
		BonusScanner:CheckGeneric(line);
	end
end


-- Scans generic bonuses like "+3 Intellect" or "Arcane Resistance +4"
function BonusScanner:CheckGeneric(line)
	local value, token, pos, tmpStr, found;

	-- split line at "/" for enchants with multiple effects
	found = false;
	while(string.len(line) > 0) do
		pos = string.find(line, "/", 1, true);
		if(pos) then
			tmpStr = string.sub(line,1,pos-1);
			line = string.sub(line,pos+1);
		else
			tmpStr = line;
			line = "";
		end

		-- trim line
	    tmpStr = string.gsub( tmpStr, "^%s+", "" );
   	    tmpStr = string.gsub( tmpStr, "%s+$", "" );
       	tmpStr = string.gsub( tmpStr, "%.$", "" );

		_, _, value, token = string.find(tmpStr, BONUSSCANNER_PATTERN_GENERIC_PREFIX);
		if(not value) then
			_, _,  token, value = string.find(tmpStr, BONUSSCANNER_PATTERN_GENERIC_SUFFIX);
		end
		if(token and value) then
			-- trim token
		    token = string.gsub( token, "^%s+", "" );
    	    token = string.gsub( token, "%s+$", "" );
	       	token = string.gsub( token, "%.$", "" );
	
			if(BonusScanner:CheckToken(token,value)) then
				found = true;
			end
		end
	end
	return found;
end


-- Identifies simple tokens like "Intellect" and composite tokens like "Fire damage" and 
-- add the value to the respective bonus. 
-- returns true if some bonus is found
function BonusScanner:CheckToken(token, value)
	local i, p, s1, s2;
	
	if(BONUSSCANNER_PATTERNS_GENERIC_LOOKUP[token]) then
		BonusScanner:AddValue(BONUSSCANNER_PATTERNS_GENERIC_LOOKUP[token], value);
		return true;
	else
		s1 = nil;
		s2 = nil;
		for i,p in BONUSSCANNER_PATTERNS_GENERIC_STAGE1 do
			if(string.find(token,p.pattern,1,1)) then
				s1 = p.effect;
			end
		end	
		for i,p in BONUSSCANNER_PATTERNS_GENERIC_STAGE2 do
			if(string.find(token,p.pattern,1,1)) then
				s2 = p.effect;
			end
		end	
		if(s1 and s2) then
			BonusScanner:AddValue(s1..s2, value);
			return true;
		end 
	end
	return false;
end

-- Last fallback for non generic enchants, like "Mana Regen x per 5 sec."
function BonusScanner:CheckOther(line)
	local i, p, value, start, found;

	for i,p in BONUSSCANNER_PATTERNS_OTHER do
		start, _, value = string.find(line, "^" .. p.pattern);
		if(start) then
			if(p.value) then
				BonusScanner:AddValue(p.effect, p.value)
			elseif(value) then
				BonusScanner:AddValue(p.effect, value)
			end
			return true;
		end
	end
	return false;
end



-- Slash Command functions

function BonusScanner_Cmd(cmd)

	local _, _, itemlink, itemid = string.find(cmd, "|c%x+|H(item:(%d+):%d+:%d+:%d+)|h%[.-%]|h|r");
	if(itemid) then
  		local name = GetItemInfo(itemid);
		if(name) then
			DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT_COLOR_CODE .. "Item bonuses of: " .. HIGHLIGHT_FONT_COLOR_CODE .. name);
			local bonuses = BonusScanner:ScanItem(itemlink);
			if(not bonuses) then
				DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT_COLOR_CODE .. "error scanning item (probably not cached)");
			else
	  			BonusScanner:PrintInfo(bonuses);
			end
  		end
  		return;
  	end
  	if(string.lower(cmd) == "show") then
	  	DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT_COLOR_CODE .. "Current equipment bonuses:");
		BonusScanner:PrintInfo(BonusScanner.bonuses);
  		return;
  	end
  	if(string.lower(cmd) == "details") then
	  	DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT_COLOR_CODE .. "Current equipment bonus details:");
		BonusScanner:PrintInfoDetailed();
  		return;
  	end
	for i, slotname in BonusScanner.slots do
		if(string.lower(cmd) == string.lower(slotname)) then
		  	DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT_COLOR_CODE .. "Bonuses of '"..LIGHTYELLOW_FONT_COLOR_CODE .. slotname .. GREEN_FONT_COLOR_CODE .. "' slot:");
		  	local bonuses = BonusScanner:GetSlotBonuses(slotname);
		  	BonusScanner:PrintInfo(bonuses);
		  	return
		end;
	end
  	DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT_COLOR_CODE .. "BonusScanner " .. BONUSSCANNER_VERSION .. " by Crowley");
  	DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT_COLOR_CODE .. "/bscan show - shows all bonus of the current equipment");
  	DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT_COLOR_CODE .. "/bscan details - shows bonuses with slot distribution");
  	DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT_COLOR_CODE .. "/bscan <itemlink> - shows bonuses of linked item (insert link with Shift-Click)");
  	DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT_COLOR_CODE .. "/bscan <slotname> - shows bonuses of given equipment slot");
end

SLASH_BONUSSCANNER1 = "/bonusscanner";
SLASH_BONUSSCANNER2 = "/bscan";
SlashCmdList["BONUSSCANNER"] = BonusScanner_Cmd;


function BonusScanner:PrintInfoDetailed()
	local bonus, name, i, j, slot, first, s;
	for i, bonus in BonusScanner.types do
		if(BonusScanner.bonuses[bonus]) then
			first = true;
			s = "(";
			for j, slot in BonusScanner.slots do 
				if(BonusScanner.bonuses_details[bonus][slot]) then
					if(not first) then
						s = s .. ", ";
					else
						first = false;
					end
					s = s .. 	LIGHTYELLOW_FONT_COLOR_CODE .. slot .. 
								HIGHLIGHT_FONT_COLOR_CODE .. ": " .. BonusScanner.bonuses_details[bonus][slot];
				end
			end;
			if(BonusScanner.bonuses_details[bonus]["Set"]) then
				if(not first) then
					s = s .. ", ";
				end
				s = s .. 	LIGHTYELLOW_FONT_COLOR_CODE .. "Set" .. 
							HIGHLIGHT_FONT_COLOR_CODE .. ": " .. BonusScanner.bonuses_details[bonus]["Set"];
				end
			s = s .. ")";
			DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT_COLOR_CODE .. BONUSSCANNER_NAMES[bonus] .. ": " .. HIGHLIGHT_FONT_COLOR_CODE .. BonusScanner.bonuses[bonus] .. " " .. s);
		end
	end
end

function BonusScanner:PrintInfo(bonuses)
	local bonus, i;
	for i, bonus in BonusScanner.types do
		if(bonuses[bonus]) then
			DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT_COLOR_CODE .. BONUSSCANNER_NAMES[bonus] .. ": " .. HIGHLIGHT_FONT_COLOR_CODE .. bonuses[bonus]);
		end
	end
end
