-- MetaMap Export Module
-- Written by MetaHawk aka Urshurak

MMEXP_USERKB = "UserKB";
MMEXP_USERNOTES = "UserNotes";

local Export_KB = "MetaKB";
local Export_Notes = "MetaNotes";
local KBcount = 0;
local Notecount = 0;

function MetaMapEXP_CheckData()
	MetaMap_ImportHeader:SetTextColor(1,1,1);
	MetaMap_ImportHeader:SetText("MetaMap Exports module loaded");
	MetaMap_ConfirmationHeader:SetText(METAMAPBLT_CONFIRM_EXPORT);
	MetaMap_SelectionButton1:SetText(MMEXP_USERKB);
	MetaMap_SelectionButton2:SetText(MMEXP_USERNOTES);
	MetaMap_SelectionButton3:SetText("Both");
	if(not IsAddOnLoaded("MetaMapWKB")) then
		LoadAddOn("MetaMapWKB");
	end
	if(not IsAddOnLoaded("MetaMapWKB")) then
		MetaMap_SelectionButton1:Disable();
		MetaMap_SelectionButton3:Disable();
	end
	MetaMap_ConfirmationDialog:Show();
end

function MetaMap_SelectedExport(mode)
	local msg = ""; KBcount = 0; Notecount = 0;
	if(mode == MMEXP_USERKB) then
		MyNotes_Data = nil;
		MyLines_Data = nil;
		MetaMap_ExportKB();
		msg = format(METAMAPEXP_KB_EXPORTED, KBcount);		
	elseif(mode == MMEXP_USERNOTES) then
		MyKB_Data = nil;
		MetaMap_ExportMetaNotes();
		msg = format(METAMAPEXP_NOTES_EXPORTED, Notecount);		
	elseif(mode == "Both") then
		MetaMap_ExportKB();
		MetaMap_ExportMetaNotes();
		msg = format(METAMAPEXP_KB_EXPORTED, KBcount).."\n"..format(METAMAPEXP_NOTES_EXPORTED, Notecount);		
	end
	MetaMap_ConfirmationDialog:Hide();
	MetaMap_ImportHeader:SetTextColor(0,1,0);
	MetaMap_ImportHeader:SetText(msg);
end

function MetaMap_ExportKB()
	MyKB_Data = {};
	MyKB_Data[MetaKB_dbID] = {};
	for name, zone in MetaKB_Data[MetaKB_dbID] do
		MyKB_Data[MetaKB_dbID][name] = MetaKB_Data[MetaKB_dbID][name];
		KBcount = KBcount +1;
	end
end

function MetaMap_ExportMetaNotes()
	MyNotes_Data = {};
	MyLines_Data = {};
	for continent=1, 2, 1 do
		MyNotes_Data[continent] = {};
		for zone, zoneTable in MetaMapNotes_Data[continent] do
			MyNotes_Data[continent][zone] = {};
			for i, value in MetaMapNotes_Data[continent][zone] do
				MyNotes_Data[continent][zone][i] = MetaMapNotes_Data[continent][zone][i];
				Notecount = Notecount +1;
			end
		end
	end
	for continent=1, 2, 1 do
		MyLines_Data[continent] = {};
		for zone, zoneTable in MetaMapNotes_Lines[continent] do
			MyLines_Data[continent][zone] = {};
			for i, value in MetaMapNotes_Lines[continent][zone] do
				MyLines_Data[continent][zone][i] = MetaMapNotes_Lines[continent][zone][i];
			end
		end
	end
end
