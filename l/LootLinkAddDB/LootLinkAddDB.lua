-- update code by Brodrick (aka Kirov)
-- database based off of one posted here http://ui.worldofwar.net/users.php?id=163022, cleaned up duplicated links.

local function CopyTable(copyTable)
	if ( not copyTable ) then return; end
	if ( type(copyTable) ~= "table" ) then
		return copyTable;
	end
	
	local returnTable = {};
	for k, v in copyTable do
		if type(v) == "table" then
			returnTable[k] = CopyTable(v);
		else
			returnTable[k] = v;
		end
	end
	return returnTable;
end

function UpdateLootLinkDB()
	ScriptErrors:Hide();
	LootLinkAddDB_Frame:Hide();
	if ( LootLinkState["DataVersion"] == 110 ) then
	
	if ( not LLDBItemLinks ) then
		message( "This has already been run once this session, it cannot be run a second time. Reenable mod and reload if you really want to use it again." );
		return;
	end
	
	
	local items, newitems, newvals, servers = 0, 0, 0;
	if ( not LLS_SPOOF ) then
		DEFAULT_CHAT_FRAME:AddMessage("LootLinkAddDB: Using LootLink Enhanced!");
		if ( LootLinkState.ServerNamesToIndices ) then
			for k, v in LootLinkState.ServerNamesToIndices do
				if ( servers ) then
					servers = servers.." "..v;
				else
					servers = v;
				end
			end
		end
	end
	
	for k, v in LLDBItemLinks do
		items = items+1;
		if ( not ItemLinks[k] ) then
			ItemLinks[k] = CopyTable(v);
			newitems = newitems + 1;
			if ( servers ) then
				ItemLinks[k].s = servers;
			end
		else
			for key, val in LLDBItemLinks[k] do
				if ( key == "s" and servers ) then
					ItemLinks[k].s = servers;
				elseif ( key == "m" and LSS_SPOOF ) then
					ItemLinks[k].m = CopyTable(val);
					newitems = newitems + getn(val);
				elseif ( key == "t" ) then
					if ( ItemLinks[k].t and ItemLinks[k].t == "" ) then
						ItemLinks[k].t = val;
						newvals = newvals + 1;
					end
				elseif ( not ItemLinks[k][key] ) then
					ItemLinks[k][key] = CopyTable(val);
					newvals = newvals + 1;
				end
			end
		end
	end
	LootLinkAddDB_Saved = 1;
	message( "|cffffffffDone updating LootLink 1.9+\n"..newitems.." new items added\nLootLink Database Adder should be removed or disabled." )
	DEFAULT_CHAT_FRAME:AddMessage("LootLinkAddDB: "..newitems.." new items added, updated "..newvals.." existing items with missing information.")
	LLDBItemLinks = nil;
	else
		message( "Your LootLink is the wrong version, this addon will only work with LootLink 1.9 and compatible versions." );
	end
end
