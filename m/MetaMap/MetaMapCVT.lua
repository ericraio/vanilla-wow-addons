-- MetaKB Import Module
-- Written by MetaHawk aka Urshurak

MMCVT_MAPNOTES = "MapNotes";
MMCVT_MAPMOD = "MapMod";
MMCVT_USERKB = "UserKB";
MMCVT_USERNOTES = "UserNotes";
MMCVT_BLT = "Default";

local MetaMap_TempData = {};
local Import_MapNotes = false;
local Import_MapMod = false;
local Import_UserKB = false;
local Import_UserNotes = false;
local Import_BLT = false;

function MetaMapCVT_CheckData()
	local found = false;
	local fileInfo = "MetaMap Imports module loaded."
	if(MetaMap_NoteData) then
		MetaMap_InstanceImportButton:Enable();
		found = true;
	end
	if(MapNotes_Data) then
		MetaMap_MapNotesImportButton:Enable();
		Import_MapNotes = true;
		found = true;
	end
	if(CT_UserMap_Notes) then
		MetaMap_MapNotesImportButton:Enable();
		Import_MapMod = true;
		found = true;
	end
	if(MyKB_Data) then
		if(not IsAddOnLoaded("MetaMapWKB")) then
			LoadAddOn("MetaMapWKB");
		end
		if(IsAddOnLoaded("MetaMapWKB")) then
			if(MyKB_Data[MetaKB_dbID]) then
				MetaMap_KBImportButton:Enable();
				Import_UserKB = true;
				found = true;
			end
		end
	end
	if(MyNotes_Data) then
		MetaMap_KBImportButton:Enable();
		Import_UserNotes = true;
		found = true;
	end
	if(MetaMapBLTDefaultData) then
		if(not IsAddOnLoaded("MetaMapBLT")) then
			LoadAddOn("MetaMapBLT");
		end
		if(IsAddOnLoaded("MetaMapBLT")) then
			MetaMap_BLTImportButton:Enable();
			Import_BLT = true;
			found = true;
		end
	end
	if(not found) then
		fileInfo = fileInfo.."\nNo data files found";
	end
	MetaMap_ImportHeader:SetTextColor(1,1,1);
	MetaMap_ImportHeader:SetText(fileInfo);
	MetaMap_LoadImportsButton:Disable();
end

function MetaMap_ImportOptions(mode)
	local ShowFrame = true;
	if(mode == 1) then
		Import_MetaMapData();
		ShowFrame = false;
	elseif(mode == 2) then
		MetaMap_SelectionButton1:SetText(MMCVT_MAPNOTES);
		MetaMap_SelectionButton2:SetText(MMCVT_MAPMOD);
		if(not Import_MapNotes) then
			MetaMap_SelectionButton1:Disable();
		end
		if(not Import_MapMod) then
			MetaMap_SelectionButton2:Disable();
		end
	elseif(mode == 3) then
		MetaMap_SelectionButton1:SetText(MMCVT_USERKB);
		MetaMap_SelectionButton2:SetText(MMCVT_USERNOTES);
		if(not Import_UserKB) then
			MetaMap_SelectionButton1:Disable();
		end
		if(not Import_UserNotes) then
			MetaMap_SelectionButton2:Disable();
		end
	elseif(mode == 4) then
		MetaMapBLT_ImportDefault();
		ShowFrame = false;
	end
	if(ShowFrame) then
		MetaMap_ConfirmationHeader:SetText(METAMAPBLT_CONFIRM_IMPORT);
		MetaMap_ConfirmationDialog:Show();
	end
end

function MetaMap_SelectedImport(mode)
	if(mode == MMCVT_MAPNOTES) then
		MetaMap_ImportMapNotes();
	elseif(mode == MMCVT_MAPMOD) then
		MetaMap_ImportMapMod();
	elseif(mode == MMCVT_USERKB) then
		MetaMap_ImportUserKB();
	elseif(mode == MMCVT_USERNOTES) then
		MetaMap_ImportMetaNotes();
	elseif(mode == MMCVT_BLT) then
		MetaMapBLT_ImportDefault();
	end
	MetaMap_ConfirmationDialog:Hide();
end

function Import_MetaMapData()
	MetaMap_TempData = {};
	MetaMap_TempData[0] = MetaMapNotes_Data[0];
	MetaMapNotes_Data[0] = {};
	MetaMapNotes_Data[0] = MetaMap_NoteData[0];
	for zone, zoneTable in MetaMap_TempData[0] do
		for index, value in MetaMap_TempData[0][zone] do
			local oldData = MetaMap_TempData[0][zone][index];
			if(oldData["lootid"] == nil) then
				MetaMapNotes_AddNewNote(0, zone, oldData.xPos, oldData.yPos, oldData.name, oldData.inf1, oldData.inf2, oldData.creator, oldData.icon, oldData.ncol, oldData.in1c, oldData.in2c)
			end
		end
	end
	for i=1, 2, 1 do
		for zone, zoneTable in MetaMapNotes_Data[i] do
			for index, value in MetaMapNotes_Data[i][zone] do
				if(MetaMapNotes_Data[i][zone][index]["lootid"] ~= nil) then
					MetaMapNotes_Data[i][zone][index] = nil;
				end
			end
		end
	end
	for i=1, 2, 1 do
		for zone, zoneTable in MetaMap_WorldNoteData[i] do
			for index, value in MetaMap_WorldNoteData[i][zone] do
				local shiftedZone = MetaMapNotes_ZoneShift[i][zone];
				MetaMapNotes_Data[i][shiftedZone][index] = value;
			end
		end
	end
	MetaMapNotes_MapUpdate();
	MetaMap_ImportHeader:SetTextColor(0,1,0);
	MetaMap_ImportHeader:SetText("Default instance data imported successfully");
end

function MetaMap_ImportMapNotes()
	local noteTotal = 0;
	local noteImport = 0;
	local noteDupe = 0;
	local newCheck = false;
	for continent=1, 2, 1 do
		for zone, zoneTable in MapNotes_Data[continent] do
			for i, value in MapNotes_Data[continent][zone] do
				noteTotal = noteTotal +1;
				local newNote = MapNotes_Data[continent][zone][i];
				newCheck = MetaMapNotes_AddNewNote(continent, zone, newNote.xPos, newNote.yPos, newNote.name, newNote.inf1, newNote.inf2, newNote.creator, newNote.icon, newNote.ncol, newNote.in1c, newNote.in2c)
				if(newCheck) then
					noteImport = noteImport +1;
					local zoneTable = MapNotes_Lines[continent][zone]
					for i, value in zoneTable do
						if(zoneTable[i].x1 == newNote.xPos and zoneTable[i].y1 == newNote.yPos) then
							MetaMapNotes_ToggleLine(continent, zone, zoneTable[i].x1, zoneTable[i].y1, zoneTable[i].x2, zoneTable[i].y2)
						end
					end
				else
					noteDupe = noteDupe +1;
				end
			end
		end
	end
	local msg = "Imported "..noteImport.." notes from MapNotes from a total of "..noteTotal.." with "..noteDupe.." duplicates not imported";
	MetaMap_ImportHeader:SetTextColor(0,1,0);
	MetaMap_ImportHeader:SetText(msg);
end

function MetaMap_ImportMapMod()
	local noteTotal = 0;
	local noteImport = 0;
	local noteDupe = 0;
	for zoneName in CT_UserMap_Notes do
		for index in CT_UserMap_Notes[zoneName] do
			noteTotal = noteTotal +1;
			if(CT_UserMap_Notes[zoneName][index].set < 6) then
				local newNote = CT_UserMap_Notes[zoneName][index];
				local continent, zone = MetaMap_NameToZoneID(zoneName, 1);
				newCheck = MetaMapNotes_AddNewNote(continent, zone, newNote.x, newNote.y, newNote.name, newNote.descript, "", UnitName("Player"), newNote.set, newNote.set, 0, 0)
				if(newCheck) then
					noteImport = noteImport +1;
				else
					noteDupe = noteDupe +1;
				end
			end
		end
	end
	local msg = "Imported "..noteImport.." notes from MapMod from a total of "..noteTotal.." with "..noteDupe.." positions already occupied";
	MetaMap_ImportHeader:SetTextColor(0,1,0);
	MetaMap_ImportHeader:SetText(msg);
end

function MetaMapBLT_ImportDefault()
	LoadAddOn("MetaMapBLT");
	if(not IsAddOnLoaded("MetaMapBLT")) then
		MetaMap_ImportHeader:SetTextColor(1,0,0);
		MetaMap_ImportHeader:SetText(METAMAPBLT_NOT_ENABLED);
		return;
	end
	MetaMapBLTData = {};
	MetaMapBLTData = MetaMapBLTDefaultData;
	MetaMap_ImportHeader:SetTextColor(0,1,0);
	MetaMap_ImportHeader:SetText(METAMAPBLT_IMPORT_DONE);
end

function MetaMap_ImportUserKB()
	MetaMap_TempData[MetaKB_dbID] = {};
	local dupe = false;
	local unknown = false;
	local totalCount = 0;
	local importCount = 0;
	local dupeCount = 0;
	local unknownCount = 0;
	for import, continentTable in MyKB_Data[MetaKB_dbID] do
		for continent, zoneTable in continentTable do
			for zone in zoneTable do
				totalCount = totalCount +1;
				for name in MetaKB_Data[MetaKB_dbID] do
					if(name == import) then
						dupeCount = dupeCount +1;
						dupe = true;
					end
				end
				if(not dupe) then
					MetaMap_TempData[MetaKB_dbID][import] = {};
					MetaMap_TempData[MetaKB_dbID][import][continent] = {};
					MetaMap_TempData[MetaKB_dbID][import][continent][zone] = {};
					local TempData = MetaMap_TempData[MetaKB_dbID][import][continent][zone];
					local ImportData = MyKB_Data[MetaKB_dbID][import][continent][zone];
					TempData["inf1"] = ImportData.inf1;
					TempData["inf2"] = ImportData.inf2;
					TempData["icon"] = ImportData.icon;
					TempData[1] = ImportData[1];
					TempData[2] = ImportData[2];
					TempData[3] = ImportData[3];
					TempData[4] = ImportData[4];
					importCount = importCount +1;
				end
				dupe = false;
			end
		end
	end
	for index in MetaMap_TempData[MetaKB_dbID] do
		MetaKB_Data[MetaKB_dbID][index] = MetaMap_TempData[MetaKB_dbID][index];
	end
	MetaMap_TempData = {};
	MetaMap_ImportHeader:SetTextColor(0,1,0);
	MetaMap_ImportHeader:SetText(format(METAKB_IMPORT_SUCCESSFUL, importCount, totalCount, unknownCount, dupeCount));
end

function MetaMap_ImportMetaNotes()
	local noteTotal = 0;
	local noteImport = 0;
	local noteDupe = 0;
	local newCheck = false;
	for continent=1, 2, 1 do
		for zone, zoneTable in MyNotes_Data[continent] do
			for i, value in MyNotes_Data[continent][zone] do
				noteTotal = noteTotal +1;
				local newNote = MyNotes_Data[continent][zone][i];
				newCheck = MetaMapNotes_AddNewNote(continent, zone, newNote.xPos, newNote.yPos, newNote.name, newNote.inf1, newNote.inf2, newNote.creator, newNote.icon, newNote.ncol, newNote.in1c, newNote.in2c)
				if(newCheck) then
					noteImport = noteImport +1;
					local zoneTable = MyLines_Data[continent][zone]
					for i, value in zoneTable do
						if(zoneTable[i].x1 == newNote.xPos and zoneTable[i].y1 == newNote.yPos) then
							MetaMapNotes_ToggleLine(continent, zone, zoneTable[i].x1, zoneTable[i].y1, zoneTable[i].x2, zoneTable[i].y2)
						end
					end
				else
					noteDupe = noteDupe +1;
				end
			end
		end
	end
	local msg = "Imported "..noteImport.." notes from MetaNotes from a total of "..noteTotal.." with "..noteDupe.." duplicates not imported";
	MetaMap_ImportHeader:SetTextColor(0,1,0);
	MetaMap_ImportHeader:SetText(msg);
end
