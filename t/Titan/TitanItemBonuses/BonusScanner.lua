BonusScanner_bonuses = {};
BonusScanner_currentset = "";
BonusScanner_sets = {};


function BonusScanner_ScanAll()

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

	BonusScanner_bonuses = {};
	BonusScanner_sets = {};
	BonusScanner_currentset = "";

	for i, slotName in slotNames do
		id, _ = GetInventorySlotInfo(slotName.. "Slot");
		TPIBonTooltip:Hide()
		TPIBonTooltip:SetOwner(this, "ANCHOR_LEFT");
		hasItem = TPIBonTooltip:SetInventoryItem("player", id);
	
		if ( not hasItem ) then
			TPIBonTooltip:ClearLines()
		else
			itemName = TPIBonTooltipTextLeft1:GetText();
			lines = TPIBonTooltip:NumLines();

			for i=2, lines, 1 do
				tmpText = getglobal("TPIBonTooltipTextLeft"..i);
				val = nil;
				if (tmpText:GetText()) then
					tmpStr = tmpText:GetText();
					BonusScanner_ScanLine(tmpStr);
				end
			end
			-- if set item, mark set as already scanned
			if(BonusScanner_currentset ~= "") then
				BonusScanner_sets[BonusScanner_currentset] = 1;
			end;
		end
	end
	TPIBonTooltip:Hide()
end

function BonusScanner_AddValue(effect, value)
	local i,e;
	if(type(effect) == "string") then
		if(BonusScanner_bonuses[effect]) then
			BonusScanner_bonuses[effect] = BonusScanner_bonuses[effect] + value;
		else
			BonusScanner_bonuses[effect] = value;
		end
	else 
	-- list of effects
		for i,e in effect do
			if(BonusScanner_bonuses[e]) then
				BonusScanner_bonuses[e] = BonusScanner_bonuses[e] + value;
			else
				BonusScanner_bonuses[e] = value;
			end
		end
	end
end;

function BonusScanner_ScanLine(line)
	local tmpStr, found;
	
	-- Check for "Equip: "
	if(string.sub(line,0,string.len(TITAN_ITEMBONUSES_EQUIP_PREFIX)) == TITAN_ITEMBONUSES_EQUIP_PREFIX) then

		tmpStr = string.sub(line,string.len(TITAN_ITEMBONUSES_EQUIP_PREFIX)+1);
		BonusScanner_ScanPassive(tmpStr);

	-- Check for "Set: "
	elseif(string.sub(line,0,string.len(TITAN_ITEMBONUSES_SET_PREFIX)) == TITAN_ITEMBONUSES_SET_PREFIX
			and BonusScanner_currentset ~= "" 
			and not BonusScanner_sets[BonusScanner_currentset]) then

		tmpStr = string.sub(line,string.len(TITAN_ITEMBONUSES_SET_PREFIX)+1);
		BonusScanner_ScanPassive(tmpStr);

	-- any other line (standard stats, enchantment, set name, etc.)
	else
		-- Check for set name
		_, _, tmpStr = string.find(line, TITAN_ITEMBONUSES_SETNAME_PATTERN);
		if(tmpStr) then
			BonusScanner_currentset = tmpStr;
		else
			found = BonusScanner_ScanGeneric(line);
			if(not found) then
				BonusScanner_ScanOther(line);
			end;
		end
	end
end;


-- Scans passive bonuses like "Set: " and "Equip: "
function BonusScanner_ScanPassive(line)
	local i, p, value, found;

	found = nil;
	for i,p in TITAN_ITEMBONUSES_EQUIP_PATTERNS do
		_, _, value = string.find(line, "^" .. p.pattern);
		if(value) then
			BonusScanner_AddValue(p.effect, value)
			found = 1;
		end
	end
	if(not found) then
		BonusScanner_ScanGeneric(line);
	end
end


-- Scans generic bonuses like "+3 Intellect" or "Arcane Resistance +4"
function BonusScanner_ScanGeneric(line)
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

		_, _, value, token = string.find(tmpStr, TITAN_ITEMBONUSES_PREFIX_PATTERN);
		if(not value) then
			_, _,  token, value = string.find(tmpStr, TITAN_ITEMBONUSES_SUFFIX_PATTERN);
		end
		if(token and value) then
			-- trim token
		    token = string.gsub( token, "^%s+", "" );
    	    token = string.gsub( token, "%s+$", "" );
	
			if(BonusScanner_ScanToken(token,value)) then
				found = true;
			end
		end
	end
	return found;
end


-- Identifies simple tokens like "Intellect" and composite tokens like "Fire damage" and 
-- add the value to the respective bonus.
function BonusScanner_ScanToken(token, value)
	local i, p, s1, s2;
	
	if(TITAN_ITEMBONUSES_TOKEN_EFFECT[token]) then
		BonusScanner_AddValue(TITAN_ITEMBONUSES_TOKEN_EFFECT[token], value);
		return true;
	else
		s1 = nil;
		s2 = nil;
		for i,p in TITAN_ITEMBONUSES_S1 do
			if(string.find(token,p.pattern,1,1)) then
				s1 = p.effect;
			end
		end	
		for i,p in TITAN_ITEMBONUSES_S2 do
			if(string.find(token,p.pattern,1,1)) then
				s2 = p.effect;
			end
		end	
		if(s1 and s2) then
			BonusScanner_AddValue(s1..s2, value);
			return true;
		end 
	end
	return false;
end

-- Scans last fallback for not generic enchants, like "Mana Regen x per 5 sec."
function BonusScanner_ScanOther(line)
	local i, p, value, start, found;

	found = nil;
	for i,p in TITAN_ITEMBONUSES_OTHER_PATTERNS do
		start, _, value = string.find(line, "^" .. p.pattern);
		if(start) then
			if(p.value) then
				BonusScanner_AddValue(p.effect, p.value)
			elseif(value) then
				BonusScanner_AddValue(p.effect, value)
			end
		end
	end
end