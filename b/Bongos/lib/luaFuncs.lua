--[[
	Lua Functions that I use for some reason or another
--]]

--[[ 
	Adapted from http://www.lua.org/pil/14.1.html
	These functions set and get global variables, with support for table.table.table access
--]]
function setfield(field, value)
	local var;
	for i in string.gfind(field, "([%w_]+)(%.?)") do
		if not var then
			if i == field then
				setglobal(i, value)
				return;
			else
				if tonumber(i) then
					i = tonumber(i);
				end
				var = getglobal(i);
			end
		elseif rest then
			if tonumber(i) then
				i = tonumber(i);
			end
			if not var[i] then
				var[i] = {};
			end
			var = var[i];
		else
			if tonumber(i) then
				i = tonumber(i);
			end
			var[i] = value;
		end
	end
end

function getfield(field)
	local var;
	for i in string.gfind(field, "([%w_]+)") do
		if not var then
			var = getglobal(i);
		else
			if tonumber(i) then
				i = tonumber(i);
			end
			var = var[i];
		end
	end
	return var;
end

--taken from http://lua-users.org/wiki/PitLibTablestuff, performs a deep table copy
function tcopy(t)
	if not t then return; end
	local copy = {}
	local lookup_table;
	for i, v in pairs(t) do
		if type(v) ~= "table" then
			copy[i] = v
		else
			lookup_table = lookup_table or {}
			lookup_table[t] = copy
			if lookup_table[v] then
				copy[i] = lookup_table[v] -- we already copied this table. reuse the copy.
			else
				copy[i] = tcopy(v,lookup_table) -- not yet copied. copy it.
			end
		end
	end
	return copy
end