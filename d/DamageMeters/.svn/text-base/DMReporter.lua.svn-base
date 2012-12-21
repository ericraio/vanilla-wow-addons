--[[------------------------------------------------------------------------
DMREPORTER.LUA

This file is designed to be executed by a Lua interpreter.  For security 
reasons, no executable is included with this package.  However, Lua 
executables are freely available on the interweb for all platforms that
WoW runs on:

http://lua-users.org/wiki/LuaBinaries

For example, on Windows you need to put Lua.exe into the DamageMeters 
directory (or in the path, etc), go to the DamageMeters directory 
in a console window, and enter:

lua.exe DMReporter.lua

----

As delivered, this file will create .txt and .csv files with various
reports based upon the data saved in your SavedVariables.lua file.  
There is nothing hidden here, so if you desire a particular type of report 
not included here and aren't afraid of a little Lua programming, why
not give it a shot?

The Basics:
- You have access to the data: DamageMeters_tables.
- You can call some of the report functions that the mod uses, ie. DamageMeters_DoReport.
- If you choose to use the built-in report functions, not that they will 
call the function DamageMeters_SendReportMsg, located in this file.
- You have access to everything in in Localization.lua.

------------------------------------------------------------------------]]--
------------------------------------------------------------------------

-------------
-- OPTIONS --
-------------

-- For convenience the following options below can be toggled to control
-- the output.

if (nil == useSavedTable) then
--useSavedTable = true;				-- Whether or not to use the main or memory table.
end

outputFilenameBase = "DMReport";	-- The base filename for all generated files.
--useTimeStamp = true;				-- Adds date and time to the filename.
useDateStamp = true;				-- Adds date and time to the filename.
useSessionLabel = true;				-- Adds the name of the session to the filename.
filenameSuffix = ""					-- Added to the end of the filename.

doTotalReport = true;				-- Outputs a list of total values for each player.
doLeaderReport = true;  			-- Outputs lists of the leading players for each value.
doEventReport = true;				-- For this to be meaningful, you need to run with event data collection.
createCSVFile = true;				-- Outputs the table to a CSV file (for reading by Excel).
createCSVEventFile = true;   		-- Outputs events to a CSV file.
createClassCSVFile = true;  		-- Outputs class-by-class summary to a CSV file.
createPercentagesCSVFile = true;	-- Outputs percentage summary to a CSV file.
createEventTotalsCSVFile = true;	-- Outputs event-totals CSV file.

--createWinrarArchive = true;  		-- Uses WinRAR (assuming you have it installed) to zip all created reports.

-----------
-- FILES --
-----------
dofile("DMReporter_settings.lua");
dofile("DamageMeters_Globals.lua");
dofile(savedVariablesPath);
dofile("localization.lua");
dofile("DamageMeters_Report.lua");

------------------------------------------------------------------------
-- FUNCTIONS --
------------------------------------------------------------------------

-- Placeholders for built-in WOW functions.
function GetTime() return 0; end
function UnitName(unit) return "["..unit.."]"; end

function DMPrint(msg, color, bSecondChatWindow)
	io.write(msg.."\n");
end

------------------------------------------------------------------------


function DamageMeters_SendReportMsg(msg)
	-- Send the message to the output file.
	outputFileHandle:write(msg.."\n");
end

------------------------------------------------------------------------

-- This is a convenient function for output the main table data to a CSV file.
function DMReporter_OutputToCSV(outputFilename)
	-- Open the file.
	outputFileHandle = io.open(outputFilename, "w+");
	if (nil == outputFileHandle) then
		io.write("Error opening "..outputFilename);
		return;
	end
	io.write("(CSV) Reporting to "..outputFilename.."...\n");

	-- Generate header string.
	local msg, quant;
	msg = "Player,Class";
	for quant = 1, DMI_REPORT_MAX do
		msg = msg..","..DM_QUANTDEFS[quant].name..",Hits,Crits";
	end
	msg = msg..",,Net Dmg,Net Healing";
	DamageMeters_SendReportMsg(msg);

	-- Generate per-player strings.
	local index;
	for index = 1, table.getn(DamageMeters_tables[DMT_ACTIVE]) do
		local struct = DamageMeters_tables[DMT_ACTIVE][index];
		msg = struct.player..",";
		if (struct.class) then
			msg = msg..struct.class;
		end

		local quant;
		for quant = 1, DMI_REPORT_MAX do
			msg = msg..","..struct.dmiData[quant].q..","..struct.dmiData[quant].hitCount..","..struct.dmiData[quant].critCount;
		end
		
		local netDamage = struct.dmiData[DMI_DAMAGE].q - struct.dmiData[DMI_DAMAGED].q;
		local netHealing = struct.dmiData[DMI_HEALING].q - struct.dmiData[DMI_HEALED].q;
		msg = msg..",,"..netDamage..","..netHealing

		DamageMeters_SendReportMsg(msg);
	end

	-- Close the file.
	outputFileHandle:close();
end

function DMReporter_OutputEventsToCSV(outputFilename)
	-- Open the file.
	outputFileHandle = io.open(outputFilename, "w+");
	if (nil == outputFileHandle) then
		io.write("Error opening "..outputFilename);
		return;
	end
	io.write("(CSV Events) Reporting to "..outputFilename.."...\n");

	-- Generate header string.
	local msg, quant;
	msg = "Player,Class,Quantity,Event,Total,Hits,Crits,Crit Pct,Avg,Pct of Player,Pct of Group,Dmg Type,Avg Res.";
	DamageMeters_SendReportMsg(msg);

	groupTotals = {};
	local ii;
	for ii = 1, table.getn(DamageMeters_tables[DMT_ACTIVE]) do
		local q;
		for q = 1, DMI_MAX do
			if (groupTotals[q] == nil) then
				groupTotals[q] = 0;
			end
			groupTotals[q] = groupTotals[q] + DamageMeters_tables[DMT_ACTIVE][ii].dmiData[q].q;
		end
	end

	-- Generate per-event strings.
	local struct, player, playerStruct, quantity, quantityStruct, spell, spellStruct;
	for index, struct in DamageMeters_tables[DMT_ACTIVE] do
		player = struct.player;
		for dmi = 1, DMI_MAX do
			quantityStruct = struct.dmiData[dmi].events;
			if (quantityStruct) then
				local playerClass = "";
				local fr = "";
				local playerIndex = DamageMeters_GetPlayerIndex(player);
				if (playerIndex and playerIndex > 0) then
					playerClass = DamageMeters_tables[DMT_ACTIVE][playerIndex].class;
				end
				if (nil == playerClass) then 
					playerClass = ""; 
				end

				local quantityTotal = 0;
				for spell, spellStruct in quantityStruct.spellTable do
					if (string.sub(spell, -1) ~= "*") then
						quantityTotal = quantityTotal + spellStruct.value;
					end
				end

				for spell, spellStruct in quantityStruct.spellTable do
					local average = DM_GetFraction(spellStruct.value, spellStruct.counts[1]);
					local pctCrit = 100 * DM_GetFraction(spellStruct.counts[2], spellStruct.counts[1]);
					local pctOfPlayer = 100 * DM_GetFraction(spellStruct.value, quantityTotal);
					local pctOfGroup = 100 * DM_GetFraction(spellStruct.value, groupTotals[dmi]);
					local avgRes = "";
					if (spellStruct.resistanceCount > 0) then
						avgRes = string.format("%.1f", DM_GetFraction(spellStruct.resistanceSum, spellStruct.resistanceCount));
					end

					msg = string.format("%s,%s,%s,%s,%d,%d,%.1f,%d,%.1f,%.1f,%.1f,%s,%s", 
						player, 
						playerClass,
						DMI_NAMES[dmi],
						spell,
						spellStruct.value,
						spellStruct.counts[1],
						spellStruct.counts[2],
						pctCrit,
						average,
						pctOfPlayer,
						pctOfGroup,
						(DM_DMGTYPE_DEFAULT == spellStruct.damageType) and "" or DM_DMGTYPENAMES[spellStruct.damageType],
						avgRes);
					DamageMeters_SendReportMsg(msg);
				end
			end
		end
	end

	-- Close the file.
	outputFileHandle:close();
end

function DMReporter_OutputEventsTotalsCSV(outputFilename)
	-- Open the file.
	outputFileHandle = io.open(outputFilename, "w+");
	if (nil == outputFileHandle) then
		io.write("Error opening "..outputFilename);
		return;
	end
	io.write("(CSV Events) Reporting to "..outputFilename.."...\n");

	local spellTable = {};
	local quantityTotals = {};
	for quantity = 1, DMI_MAX do
		spellTable[quantity] = {};
		quantityTotals[quantity] = 0;
	end

	-- Add up all the spells.
	local index, player, playerStruct, quantity, quantityStruct, spell, spellStruct;
	for index, playerStruct in DamageMeters_tables[DMT_ACTIVE] do
		for quantity = 1, DMI_MAX do
			eventStruct = playerStruct.dmiData[quantity].events;
			if (eventStruct) then
				for spell, spellStruct in eventStruct.spellTable do
					if (string.sub(spell, -1) ~= "*") then
						if (nil == spellTable[quantity][spell]) then
							spellTable[quantity][spell] = {};
							spellTable[quantity][spell].players = 0;
							spellTable[quantity][spell].value = 0;
							spellTable[quantity][spell].counts = {};
							spellTable[quantity][spell].counts[1] = 0;
							spellTable[quantity][spell].counts[2] = 0;
						end
						spellTable[quantity][spell].players		= spellTable[quantity][spell].players + 1;
						spellTable[quantity][spell].value		= spellTable[quantity][spell].value + spellStruct.value;
						spellTable[quantity][spell].counts[1]	= spellTable[quantity][spell].counts[1] + spellStruct.counts[1];
						spellTable[quantity][spell].counts[2]	= spellTable[quantity][spell].counts[2] + spellStruct.counts[2];

						quantityTotals[quantity] = quantityTotals[quantity] + spellStruct.value;
					end
				end
			end
		end
	end

	local msg = "Quantity,Spell,Players,Total,Hits,Crits,Average,Pct. Of Total";
	DamageMeters_SendReportMsg(msg);

	for quantity = 1, DMI_MAX do
		local quantityStruct = spellTable[quantity];
		for spell, spellStruct in quantityStruct do
			local average = DM_GetFraction(spellStruct.value, spellStruct.counts[1]);
			local percent = 100 * DM_GetFraction(spellStruct.value, quantityTotals[quantity]);

			local msg = string.format("%s,%s,%d,%d,%d,%d,%.1f,%.1f",
					DMI_NAMES[quantity],
					spell,
					spellStruct.players,
					spellStruct.value,
					spellStruct.counts[1],
					spellStruct.counts[2],
					average,
					percent);
			DamageMeters_SendReportMsg(msg);
		end
	end

	-- Close the file.
	outputFileHandle:close();
end

function DMReporter_OuptutClassReportCSV(outputFilename)
	-- Open the file.
	outputFileHandle = io.open(outputFilename, "w+");
	if (nil == outputFileHandle) then
		io.write("Error opening "..outputFilename);
		return;
	end
	io.write("(CSV Class Report) Reporting to "..outputFilename.."...\n");

	--------------------

	local classTable = {};

	local ix;
	local class, classInfo;
	for ix = 1, table.getn(DamageMeters_tables[DMT_ACTIVE]) do
		local playerInfo = DamageMeters_tables[DMT_ACTIVE][ix];
		if (playerInfo.class and playerInfo.class ~= "") then
			class = DamageMeters_tables[DMT_ACTIVE][ix].class;
			if (classTable[class] == nil) then
				classTable[class] = {};
				classTable[class].count = 0;
				classTable[class].quants = {0, 0, 0, 0};
			end
			classTable[class].count = classTable[class].count + 1;

			local quant;
			for quant = 1, DMI_REPORT_MAX do
				classTable[class].quants[quant] = classTable[class].quants[quant] + playerInfo.dmiData[quant].q;
			end
		end
	end


	-- Generate header string.
	local msg, quant;
	msg = "Class,Count";
	for quant = 1, DMI_REPORT_MAX do
		msg = msg..","..DM_QUANTDEFS[quant].name..",Avg "..DM_QUANTDEFS[quant].name;
	end
	DamageMeters_SendReportMsg(msg);

	for class, classInfo in classTable do
		local msg = string.format("%s,%d,%d,%d,%d,%d,%d,%d,%d,%d", class, classInfo.count, 
		classInfo.quants[1], DM_GetFraction(classInfo.quants[1],classInfo.count), 
		classInfo.quants[2], DM_GetFraction(classInfo.quants[2],classInfo.count), 
		classInfo.quants[3], DM_GetFraction(classInfo.quants[3],classInfo.count), 
		classInfo.quants[4], DM_GetFraction(classInfo.quants[4],classInfo.count));
		DamageMeters_SendReportMsg(msg);
	end

	-- Close the file.
	outputFileHandle:close();
end

function DMReporter_OutputPercentagesReportCSV(outputFilename)
	-- Open the file.
	outputFileHandle = io.open(outputFilename, "w+");
	if (nil == outputFileHandle) then
		io.write("Error opening "..outputFilename);
		return;
	end
	io.write("(CSV Class Report) Reporting to "..outputFilename.."...\n");

	--------------------

	local msg = "Player,Class"
	for ii = 1, DMI_REPORT_MAX do
		msg = string.format("%s,%s,Pct Of Total,Pct Of Leader",
			msg, DM_QUANTDEFS[ii].name);
	end
	DamageMeters_SendReportMsg(msg);

	-- Calculate totals.
	local index;
	local info;
	local totals = {0, 0, 0, 0, 0, 0};
	local peaks = {0, 0, 0, 0};
	for index,info in DamageMeters_tables[DMT_ACTIVE] do 
		local ii;
		for ii = 1, DMI_REPORT_MAX do
			msg = string.format(",%s,%s,Pct Of Total,Pct Of Leader",
				msg, DM_QUANTDEFS[ii].name);
			totals[ii] = totals[ii] + info.dmiData[ii].q;
			if (info.dmiData[ii].q > peaks[ii]) then
				peaks[ii] = info.dmiData[ii].q;
			end
		end
		totals[5] = totals[5] + info.dmiData[DMI_DAMAGE].hitCount;
		totals[6] = totals[6] + info.dmiData[DMI_DAMAGE].critCount;
	end
	DamageMeters_DetermineRanks(DMT_ACTIVE);

	for index = 1, table.getn(DamageMeters_tables[DMT_ACTIVE]) do
		local struct = DamageMeters_tables[DMT_ACTIVE][index];

		local class = struct.class and struct.class or "";
		msg = string.format("%s,%s", struct.player, class);

		for quant = 1, DMI_REPORT_MAX do
			local percentOfTotal = 100 * DM_GetFraction(struct.dmiData[quant].q, totals[quant]);
			local percentOfLeader = 100 * DM_GetFraction(struct.dmiData[quant].q, peaks[quant]);

			msg = string.format("%s,%d,%.2f,%.2f", 
				msg, struct.dmiData[quant].q, percentOfTotal, percentOfLeader);
		end
		DamageMeters_SendReportMsg(msg);
	end

	-- Close the file.
	outputFileHandle:close();
end

------------------------------------------------------------------------
-- REPORT CODE GOES HERE --
------------------------------------------------------------------------

	-- See if we are using the "saved" (memory) table, rather than the main table.
	if (useSavedTable) then
		io.write("Using Saved Table: Switching active index from "..DMT_ACTIVE.." to ");
		DMT_ACTIVE = (DMT_ACTIVE == DM_TABLE_B) and DM_TABLE_A or DM_TABLE_B;
		io.write(DMT_ACTIVE.."\n");
	end

	-- Sort functions use the visible table, so make sure it refers
	-- to the active table, not the fight table.
	DMT_VISIBLE = DMT_ACTIVE;

	-- Update DMI_MAX to reflect plugin data.
	for plugin, dmi in DamageMeters_pluginDMITable do
		if (dmi > DMI_MAX) then
			DMI_NAMES[dmi] = plugin;
			DMI_MAX = dmi;
		end
	end

	-- Verify that the table has data.
	if (nil == DamageMeters_tables[DMT_ACTIVE] or 0 == table.getn(DamageMeters_tables[DMT_ACTIVE])) then
		io.write("Table is empty.");
		return;
	end

	local filenameList = {};
	local sessionLabel = "";
	if (useSessionLabel) then
		if (DamageMeters_tableInfo[DMT_VISIBLE].sessionLabel) then
			sessionLabel = "_"..DamageMeters_tableInfo[DMT_VISIBLE].sessionLabel;
		end
	end

	-- Build a string which contains the current date and time so that we can 
	-- uniquely name our report files.
	local dateTimeString = "";
	if (useDateStamp or useTimeStamp) then
		local dateTable = os.date("*t");
		if (useDateStamp) then
			dateTimeString = string.format("_%d%02d%02d", dateTable.year, dateTable.month, dateTable.day);
		end
		if (useTimeStamp) then
			dateTimeString = dateTimeString..string.format("_%02d%02d%02d", dateTable.hour, dateTable.min, dateTable.sec);
		end
	end

	local fullSuffix = dateTimeString..sessionLabel..filenameSuffix;

	if (doTotalReport or doLeaderReport or doEventReport) then

		-- Open a file for writing to.
		outputFilename = outputFilenameBase..fullSuffix..".txt";
		outputFileHandle = io.open(outputFilename, "w+");
		if (nil == outputFileHandle) then
			io.write("Error opening "..outputFilename);
			return;
		end
		table.insert(filenameList, outputFilename);
		io.write("Writing report to "..outputFilename.."...\n");

		----------------

		-- Total Report:
		if (doTotalReport) then
			DamageMeters_DoReport(DamageMeters_ReportQuantity_Total, "BUFFER", false, 1, table.getn(DamageMeters_tables[DMT_ACTIVE]), nil);
			DamageMeters_SendReportMsg("\n");
		end

		-- Leader Report:
		if (doLeaderReport) then
			DamageMeters_DoReport(DamageMeters_ReportQuantity_Leaders, "BUFFER", false, 1, table.getn(DamageMeters_tables[DMT_ACTIVE]), nil);
			DamageMeters_SendReportMsg("\n");
		end

		-- Event Report:
		if (doEventReport) then
			DamageMeters_DoReport(DamageMeters_ReportQuantity_Events, "BUFFER", false, 1, table.getn(DamageMeters_tables[DMT_ACTIVE]), nil);
			DamageMeters_SendReportMsg("\n");
		end

		-- Close the file.
		outputFileHandle:close();
	end

	-- Dump table to a CSV file.
	if (createCSVFile) then
		outputFilename = outputFilenameBase..fullSuffix..".csv";
		table.insert(filenameList, outputFilename);
		DMReporter_OutputToCSV(outputFilename);
	end

	-- Dump event table to a CSV file.
	if (createCSVEventFile) then
		outputFilename = outputFilenameBase.."_Events"..fullSuffix..".csv";
		table.insert(filenameList, outputFilename);
		DMReporter_OutputEventsToCSV(outputFilename);
	end

	-- Dump Class Info to a CSV file.
	if (createClassCSVFile) then
		outputFilename = outputFilenameBase.."_Class"..fullSuffix..".csv";
		table.insert(filenameList, outputFilename);
		DMReporter_OuptutClassReportCSV(outputFilename);
	end

	-- Dump Percentage Info to a CSV file
	if (createPercentagesCSVFile) then
		outputFilename = outputFilenameBase.."_Percentages"..fullSuffix..".csv";
		table.insert(filenameList, outputFilename);
		DMReporter_OutputPercentagesReportCSV(outputFilename);
	end

	-- Dump event-totals to a CSV file.
	if (createEventTotalsCSVFile) then
		outputFilename = outputFilenameBase.."_EventTotals"..fullSuffix..".csv";
		table.insert(filenameList, outputFilename);
		DMReporter_OutputEventsTotalsCSV(outputFilename);
	end


	---------------------------------

	if (createWinrarArchive) then
		local archiveName = outputFilenameBase..fullSuffix..".zip";
		local commandLine = "start winrar.exe a -df -- "..archiveName;
		for index, filename in filenameList do
			commandLine = commandLine.." "..filename;
		end
		io.write("Creating archive using command line:\n");
		io.write(commandLine.."\n");
		os.execute(commandLine);
	end

	---------------------------------

	if (nil ~= DM_eventCaseTableDebug) then
		outputFileHandle = io.open("DM_eventCaseTableDebug.txt", "w+");

		outputFileHandle:write("Unparsed Messages in EventCaseTable:\n");
		for msgType, msgTable in DM_eventCaseTableDebug do
			outputFileHandle:write("  "..msgType.."\n");
			for event, eventTable in msgTable do
				--DM_DUMP_TABLE(eventTable);
				
				outputFileHandle:write("    "..event.." ("..eventTable.parseCount.."/"..eventTable.hitCount..")\n");
				for caseIndex, case in eventTable do
					if (type(caseIndex) == "number") then
						outputFileHandle:write("      "..case.n.." ("..case.hitCount..")\n");
						if (nil ~= case.parsed) then
							for parseIx, parse in case.parsed do
								outputFileHandle:write("        "..parse.."\n");
							end
						end
					end
				end

				if (eventTable.unparsed ~= nil) then
					outputFileHandle:write("      [Unparsed]:\n");
					for index, message in eventTable.unparsed do
						outputFileHandle:write("        "..message.."\n");
					end
				end
			end
		end

		io.close(outputFileHandle);
	end

	---------------------------------