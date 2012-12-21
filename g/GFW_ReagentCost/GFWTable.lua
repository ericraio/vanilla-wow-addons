------------------------------------------------------
-- GFWTable.lua
-- Utilities for manipulating tables 
------------------------------------------------------

GFWTABLE_THIS_VERSION = 5;

------------------------------------------------------

-- Mean: returns the mean value of a table of numbers
function GFWTable_temp_Mean(aTable)
	if (aTable == nil or table.getn(aTable) == 0) then
		return nil;
	end
	return GFWTable.Sum(aTable) / table.getn(aTable);
end

-- Sum: returns the sum of a table of numbers
function GFWTable_temp_Sum(aTable)
	if (aTable == nil or table.getn(aTable) == 0) then
		return nil;
	end
	local sum = 0;
	for i=1, table.getn(aTable) do
		if (tonumber(aTable[i])) then
			sum = sum + aTable[i];
		end
	end
	return sum;
end

-- Median: returns the median value (most useful in a table of numbers, but usable in any sorted table)
function GFWTable_temp_Median(aTable)
	if (aTable == nil or table.getn(aTable) == 0) then 
		return nil; 
	end
	if (table.getn(aTable) == 1) then
		return aTable[1];
	end
	local sortedTable = GFWTable.Copy(aTable); -- leave the original table in whatever order it's in
	table.sort(sortedTable);
	local count = table.getn(sortedTable);
	local median;
	if (math.mod(count, 2) == 0) then -- even table size
		local middleIndex1 = count / 2;
		local middleIndex2 = middleIndex1 + 1;
		median = (sortedTable[middleIndex1] + sortedTable[middleIndex2]) / 2; --average the two middle values
	else -- the table size is odd
		local trueMiddleIndex = (count + 1) / 2; -- calculate the middle index
		median = sortedTable[trueMiddleIndex];
	end
	return median;
end

-- Merge: returns the union of two tables (without repeated elements)
function GFWTable_temp_Merge(table1, table2)
	local newTable = { };
	if (table1) then
		for i=1, table.getn(table1) do
			table.insert(newTable, table1[i]);
		end
	end
	if (table2) then
		for i=1, table.getn(table2) do
			if (GFWTable.IndexOf(newTable, table2[i]) == 0) then
				table.insert(newTable, table2[i]);
			end
		end
	end
	return newTable;
end

-- Diff: returns the difference of two tables (those elements which occur in either but not both)
function GFWTable_temp_Diff(table1, table2)
	local newTable = { };
	if (table1 == nil) then
		table1 = {};
	end
	if (table2 == nil) then
		table2 = {};
	end
	for i=1, table.getn(table1) do
		if (GFWTable.IndexOf(table2, table1[i]) == 0) then
			table.insert(newTable, table1[i]);
		end
	end
	for i=1, table.getn(table2) do
		if (GFWTable.IndexOf(table1, table2[i]) == 0) then
			table.insert(newTable, table2[i]);
		end
	end
	return newTable;
end

-- Subtract: returns a table containing those items in table1 not present in table2
function GFWTable_temp_Subtract(table1, table2)
	local newTable = { };
	if (table1 == nil or table.getn(table1) == 0) then return newTable; end
	if (table2 == nil or table.getn(table2) == 0) then return table1; end
	for i=1, table.getn(table1) do
		if (GFWTable.IndexOf(table2, table1[i]) == 0) then
			table.insert(newTable, table1[i]);
		end
	end
	return newTable;
end

-- IndexOf: returns the index (1-based) of an item in a table
function GFWTable_temp_IndexOf(aTable, item)
	return GFWTable.KeyOf(aTable, item) or 0;
end

-- KeyOf: returns the key to an item in a table with numeric or non-numeric keys, or nil if not found
function GFWTable_temp_KeyOf(aTable, item)
	if (aTable == nil or type(aTable) ~= "table") then
		return nil; -- caller probably won't expect this, causing traceable error in their code
	end
	for key, value in aTable do
		if (item == value) then
			return key;
		end
	end
	return nil;
end

-- Copy: copies one table's elements into a new table (useful if you want to change them while preserving the first table). 
--       Not a deep copy.
function GFWTable_temp_Copy(aTable)
	local newTable = { };
	for i=1, table.getn(aTable) do
		newTable[i] = aTable[i];
	end
	return newTable;
end

-- Count: returns number of items in a table regardless of whether it has numeric indices.
function GFWTable_temp_Count(aTable)
	if (aTable == nil or type(aTable) ~= "table") then
		return nil; -- caller probably won't expect this, causing traceable error in their code
	end
	local count = 0;
	for key, value in aTable do
		count = count + 1;
	end
	return count;
end

------------------------------------------------------
-- load only if not already loaded
------------------------------------------------------

if (GFWTable == nil) then
	GFWTable = {};
end
local G = GFWTable;
if (G.Version == nil or (tonumber(G.Version) ~= nil and G.Version < GFWTABLE_THIS_VERSION)) then

	-- Functions
	G.Mean = GFWTable_temp_Mean;
	G.Sum = GFWTable_temp_Sum;
	G.Median = GFWTable_temp_Median;
	G.Merge = GFWTable_temp_Merge;
	G.Diff = GFWTable_temp_Diff;
	G.Subtract = GFWTable_temp_Subtract;
	G.IndexOf = GFWTable_temp_IndexOf;
	G.KeyOf = GFWTable_temp_KeyOf;
	G.Copy = GFWTable_temp_Copy;
	G.Count = GFWTable_temp_Count;
	
	-- Set version number
	G.Version = GFWTABLE_THIS_VERSION;
end


