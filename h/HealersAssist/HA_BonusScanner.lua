HA_BonusScanner_bonuses = {};
HA_BonusScanner_currentset = "";
HA_BonusScanner_sets = {};


function HA_BonusScanner_ScanAll()

	local slotNames = {
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

	local i, slotName
	local id, hasItem;
	local itemName, tmpText, tmpStr, tmpSet, val, lines, set;

	HA_BonusScanner_bonuses = {};
	HA_BonusScanner_sets = {};
	HA_BonusScanner_currentset = "";

	for i, slotName in slotNames do
		id, _ = GetInventorySlotInfo(slotName.. "Slot");
		HealersAssistTooltip:Hide()
		HealersAssistTooltip:SetOwner(this, "ANCHOR_LEFT");
		hasItem = HealersAssistTooltip:SetInventoryItem("player", id);
	
		if ( not hasItem ) then
			HealersAssistTooltip:ClearLines()
		else
			itemName = HealersAssistTooltipTextLeft1:GetText();
			lines = HealersAssistTooltip:NumLines();

			for i=2, lines, 1 do
				tmpText = getglobal("HealersAssistTooltipTextLeft"..i);
				val = nil;
				if (tmpText:GetText()) then
					tmpStr = tmpText:GetText();
					HA_BonusScanner_ScanLine(tmpStr);
				end
			end
			-- if set item, mark set as already scanned
			if(HA_BonusScanner_currentset ~= "") then
				HA_BonusScanner_sets[HA_BonusScanner_currentset] = 1;
			end;
		end
	end
	HealersAssistTooltip:Hide()
end

function HA_BonusScanner_AddValue(effect, value)
	local i,e;
	if(type(effect) == "string") then
		if(HA_BonusScanner_bonuses[effect]) then
			HA_BonusScanner_bonuses[effect] = HA_BonusScanner_bonuses[effect] + value;
		else
			HA_BonusScanner_bonuses[effect] = value;
		end
	else 
	-- list of effects
		for i,e in effect do
			if(HA_BonusScanner_bonuses[e]) then
				HA_BonusScanner_bonuses[e] = HA_BonusScanner_bonuses[e] + value;
			else
				HA_BonusScanner_bonuses[e] = value;
			end
		end
	end
end;

function HA_BonusScanner_ScanLine(line)
	local tmpStr, found;
	
	-- Check for "Equip: "
	if(string.sub(line,0,string.len(HA_ITEMBONUSES_EQUIP_PREFIX)) == HA_ITEMBONUSES_EQUIP_PREFIX) then

		tmpStr = string.sub(line,string.len(HA_ITEMBONUSES_EQUIP_PREFIX)+1);
		HA_BonusScanner_ScanPassive(tmpStr);

	-- Check for "Set: "
	elseif(string.sub(line,0,string.len(HA_ITEMBONUSES_SET_PREFIX)) == HA_ITEMBONUSES_SET_PREFIX
			and HA_BonusScanner_currentset ~= "" 
			and not HA_BonusScanner_sets[HA_BonusScanner_currentset]) then

		tmpStr = string.sub(line,string.len(HA_ITEMBONUSES_SET_PREFIX)+1);
		HA_BonusScanner_ScanPassive(tmpStr);

	-- any other line (standard stats, enchantment, set name, etc.)
	else
		-- Check for set name
		_, _, tmpStr = string.find(line, HA_ITEMBONUSES_SETNAME_PATTERN);
		if(tmpStr) then
			HA_BonusScanner_currentset = tmpStr;
		else
			found = HA_BonusScanner_ScanGeneric(line);
			if(not found) then
				HA_BonusScanner_ScanOther(line);
			end;
		end
	end
end;


-- Scans passive bonuses like "Set: " and "Equip: "
function HA_BonusScanner_ScanPassive(line)
	local i, p, value, found;

	found = nil;
	for i,p in HA_ITEMBONUSES_EQUIP_PATTERNS do
		_, _, value = string.find(line, "^" .. p.pattern);
		if(value) then
			HA_BonusScanner_AddValue(p.effect, value)
			found = 1;
		end
	end
	if(not found) then
		HA_BonusScanner_ScanGeneric(line);
	end
end


-- Scans generic bonuses like "+3 Intellect" or "Arcane Resistance +4"
function HA_BonusScanner_ScanGeneric(line)
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

		_, _, value, token = string.find(tmpStr, HA_ITEMBONUSES_PREFIX_PATTERN);
		if(not value) then
			_, _,  token, value = string.find(tmpStr, HA_ITEMBONUSES_SUFFIX_PATTERN);
		end
		if(token and value) then
			-- trim token
		    token = string.gsub( token, "^%s+", "" );
    	    token = string.gsub( token, "%s+$", "" );
	
			if(HA_BonusScanner_ScanToken(token,value)) then
				found = true;
			end
		end
	end
	return found;
end


-- Identifies simple tokens like "Intellect" and composite tokens like "Fire damage" and 
-- add the value to the respective bonus.
function HA_BonusScanner_ScanToken(token, value)
	local i, p, s1, s2;
	
	if(HA_ITEMBONUSES_TOKEN_EFFECT[token]) then
		HA_BonusScanner_AddValue(HA_ITEMBONUSES_TOKEN_EFFECT[token], value);
		return true;
	else
		s1 = nil;
		s2 = nil;
		for i,p in HA_ITEMBONUSES_S1 do
			if(string.find(token,p.pattern,1,1)) then
				s1 = p.effect;
			end
		end	
		for i,p in HA_ITEMBONUSES_S2 do
			if(string.find(token,p.pattern,1,1)) then
				s2 = p.effect;
			end
		end	
		if(s1 and s2) then
			HA_BonusScanner_AddValue(s1..s2, value);
			return true;
		end 
	end
	return false;
end

-- Scans last fallback for not generic enchants, like "Mana Regen x per 5 sec."
function HA_BonusScanner_ScanOther(line)
	local i, p, value, start, found;

	found = nil;
	for i,p in HA_ITEMBONUSES_OTHER_PATTERNS do
		start, _, value = string.find(line, "^" .. p.pattern);
		if(start) then
			if(p.value) then
				HA_BonusScanner_AddValue(p.effect, p.value)
			elseif(value) then
				HA_BonusScanner_AddValue(p.effect, value)
			end
		end
	end
end
