---- unitFromPlayerName(string name) returns string unit or false if not in group
function unitFromPlayerName(name)
	name = string.gsub(name, "(-.*)", "")

	if UnitName("player") == name then 
		return "player" 
	end
	if GetNumRaidMembers() == 0 then
		for i=1,GetNumPartyMembers() do
			if(UnitName("party"..i) == name) then
				return "party"..i
			end
		end
	else
		for i=1,GetNumRaidMembers() do
			if(UnitName("raid"..i) == name) then
				return "raid"..i
			end
		end
	end
	return false
end

function tokenizestring(str, values)
	sgsub = string.gsub
	for k, v in values do
		str = sgsub(str, "%["..k.."%]", (type(v) == "function" and v() or v))
	end
	return str
end

---- nilTable(table tableToNil) returns empty tableToNil
tsetn = XLoot.compat and function() end or table.setn
function nilTable(tableToNil) -- MentalPower
	if (not (type(tableToNil) == "table")) then
		return tableToNil;
	end

	for key, value in pairs(tableToNil) do
		if type(value) == "table" then
			nilTable(value)
		end
		tableToNil[key] = nil;
	end

	tsetn(tableToNil, 0);
	return tableToNil;
end


---- iteratetable, rewrite of iterateTable by ckknight with fancy metatable voodoo
---- for k, v in iteratetable(table, optional string key, optional boolean reverse)
do
	local mySort = function(a, b)
		if not a then
			return false
		end
		if not b then
			return true
		end
		
		if type(a) == "string" then
			return string.upper(a) < string.upper(b)
		else
			return a < b
		end
	end

	local mySort_reverse = function(a, b)
		if not b then
			return false
		end
		if not a then
			return true
		end
		
		if type(a) == "string" then
			return string.upper(a) > string.upper(b)
		else
			return a > b
		end
	end

	local current
	local sorts = setmetatable({}, {__index=function(self, sortBy)
		local x = function(a, b)
			if not a or not b then
				return false
			elseif type(current[a][sortBy]) == "string" then
				return string.upper(current[a][sortBy]) < string.upper(current[b][sortBy])
			else
				return current[a][sortBy] < current[b][sortBy]
			end
		end
		self[sortBy] = x
		return x
	end})
	local sorts_reverse = setmetatable({}, {__index=function(self, sortBy)
		local x = function(a, b)
			if not a or not b then
				return false
			elseif type(current[a][sortBy]) == "string" then
				return string.upper(current[a][sortBy]) > string.upper(current[b][sortBy])
			else
				return current[a][sortBy] > current[b][sortBy]
			end
		end
		self[sortBy] = x
		return x
	end})

	local iters; iters = setmetatable({}, {__index=function(self, t)
		local q; q = function(tab)
			local position = t['#'] + 1
			
			local x = t[position]
			if not x then
				for k in pairs(t) do
					t[k] = nil
				end
				tsetn(t, 0)
				iters[t] = q
				return
			end
			
			t['#'] = position
			
			return x, tab[x]
		end
		return q
	end, __mode='k'})

	function iteratetable(tab, key, reverse)
		local t = next(iters) or {}
		local iter = iters[t]
		iters[t] = nil
		for k, v in pairs(tab) do
			table.insert(t, k)
		end
		
		if not key then
			table.sort(t, reverse and mySort_reverse or mySort)
		else
			current = tab
			table.sort(t, reverse and sorts_reverse[key] or sorts[key])
			current = nil
		end
		
		t['#'] = 0
		
		return iter, tab
	end
end