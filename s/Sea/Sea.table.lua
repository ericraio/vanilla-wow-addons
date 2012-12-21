--[[
--
--	Sea.table
--
--	LUA Table manipulation functions
--
--	$LastChangedBy: karlkfi $
--	$Rev: 2849 $
--	$Date: 2005-12-08 07:21:15 -0600 (Thu, 08 Dec 2005) $
--]]

Sea.table = {
	
	-- 
	-- getValueIndex(table, value)
	--
	-- 	Returns the key associated with the value in the table/list.
	--
	-- Args:
	-- 	(table t, object item)
	--	t - table to search
	--	item - item to find the index of
	--
	-- Returns: 
	-- 	nil - if empty
	-- 	index - if found
	getValueIndex = function (table, item)
		if ( table ) then 
			for k,v in table do 
				if ( v == item ) then return k; end
			end
		end
		return nil;
	end;

	--
	-- isInTable(table, value ) 
	--
	-- Returns:
	-- 	true if the item is in the list/table
	-- 	false if not in the list/table
	--
	isInTable = function(table, value)
		return (Sea.table.getValueIndex(table,value) ~= nil )
	end;

	--
	-- isStringInTableValue(table[string] table, string word)
	--
	-- Returns:
	-- 	true if word exists in a string value of table
	-- 	false if word is never used
	--
	-- Aliases:
	-- 	isWordInList()
	--
	isStringInTableValue = function (table, word) 
		if ( type(table) == "nil" ) then return false; end
		for k,v in table do
			if ( type(v) == "string" ) then 
				if ( string.find(word,v) ~= nil ) then
					return true;
				end
			end
		end
		return false;
	end;
	
	--
	-- Aliases:
	-- 	Sea.table.getIndexInList
	-- 	Sea.list.getIndexInList
	-- 
	
	-- 
	-- push( table, value )
	--
	-- 	Adds a value to the end of the table.
	--
	-- Arg:
	-- 	table - the table
	-- 	value - the value for the end of the table
	-- 
	-- Written by Thott (thott@thottbot.com)
	push = function (table,val)
		if(not table or not table.n) then
			Sea.IO.derror(nil, "Bad table passed to Sea.table.push by ", this);
			return nil;
		end
		--table.insert(table, val);
		table.n = table.n+1;
		table[table.n] = val;
	end;

	--
	-- pop ( table )
	--
	-- 	Removes an indexed value from the end of the table and returns it.
	--	Difference from table.remove: doesn't nil index - more memory usages, less GC
	--	(Good for tables that are constantly filled and emptied with a consistant number of entries)
	--
	-- Arg:
	-- 	table - the table
	--
	-- Written by Thott (thott@thottbot.com)
	pop = function (table)
		if(not table or not table.n) then
			Sea.IO.derror(nil,"Bad table passed to Sea.table.pop by ", this);
			return nil;
		end
		if ( table.n == 0 ) then 
			return nil;
		end

		local v = table[table.n];
		table.n = table.n - 1;
		--v = table.remove(table);
		return v;		
	end;
	
	--
	-- getKeyList ( table )
	--
	-- 	Returns a table of keys (integer indexing), empty table if empty table.
	--
	-- Arg:
	-- 	table - the table
	--
	-- Written by AnduinLothar (KarlKFI@cosmosui.org)
	getKeyList = function (passedTable)
		if( type(passedTable) ~= "table" ) then
			return nil;
		end
		
		local keyList = { };
		for key, value in passedTable do
			--Sea.io.print(key);
			table.insert(keyList, key)
		end
		return keyList;	
	end;

	--
	-- copy( table [, recursionList ]  )
	-- 	Copies the values of a table
	-- 	If you use tables as keys, it will probably fail. 
	-- 	
	-- args:
	-- 	table - the table you want copied
	-- 	recursionList - don't use this
	--
	-- returns:
	-- 	table - the table containing the copy of the values
	-- 	
	copy = function ( t, recursionList ) 
		if ( not recursionList ) then recursionList = {} end
		if ( type(t) ~= "table" ) then 
			return t;
		end

		local newTable = {};
		if ( recursionList[t] ) then
			return recursionList[t];
		else
			recursionList[t] = newTable;
			for k,v in t do
				--If it's a table we want to recurse.  But the second half of this if checks to see if it
				--is a reference to a frame, which looks like a table, and does a normal copy in such a
				--case
				if ( ( type(v) == "table" ) and not ( v[0] and ( type(v[0]) == "userdata" ) ) ) then 
					newTable[k] = Sea.table.copy(v, recursionList);
				else
					newTable[k] = v;
				end
			end

			return newTable;
		end
	end;

	--
	-- isEquivalent(table1, table2 [, recursedList])
	-- 	returns true if all of the keys in a single-layer 
	-- 	table point to the same values
	--
	-- 	This is not fully tested using recursive tables
	--
	-- args:
	-- 	table1 - the first table
	-- 	table2 - the second table
	-- 	
	isEquivalent = function (table1, table2, recursedList ) 
		if ( not recursedList ) then 
			recursedList = {};
		end
		if ( type ( table1 ) ~= "table" or type(table2) ~= "table" ) then
			if ( table1 == table2 ) then
				return true;
			else
				return false;
			end
		end
		recursedList[table1] = true;
		recursedList[table2] = true;

		local keyList1 = Sea.table.getKeyList(table1);
		local keyList2 = Sea.table.getKeyList(table2);

		if ( table.getn(keyList1) ~= table.getn(keyList2) ) then
			return false;
		else
			for k,v in keyList1 do 
				local t1v, t2v = table1[v], table2[v];
				
				if ( type(t1v) ~= type(t2v) ) then
					return false;
				elseif ( type(t1v) ~= 'table' ) then
					if (table1[v] ~= table2[v]) then
						return false;
					end
				else
					if ( recursedList[t1v] or recursedList[t2v] ) then 
						if ( t1v ~= t2v ) then 
							return false;
						end
					else
						if ( not Sea.table.isEquivalent(t1v, t2v, recursedList) ) then 
							return false;
						end
					end
				end
			end	
		end

		return true;
	end;
};

-- Aliases
Sea.table.getIndexInList = Sea.table.getValueIndex;
Sea.table.isWordInList = Sea.table.isStringInTableValue;
Sea.table.isInList = Sea.table.isInTable;
-- List and tables are equal in lua
Sea.list = Sea.table;
