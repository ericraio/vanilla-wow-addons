-- MetaMapBKP (Backup & Restore module for MetaMap)
-- Written by MetaHawk - aka Urshurak

local MetaKB_Loaded = false;

function MetaMapBKP_OnEvent(event)
	if(event == "ADDON_LOADED" and arg1 == "MetaMapBKP") then
		MetaMapBKP_Init();
	end
end

function MetaMapBKP_Init()
	if(BKP_MetaMapNotes_Data == nil) then
		MetaMapBKP_Restore:Disable();
	else
		MetaMapBKP_Restore:Enable();
	end
	if(not IsAddOnLoaded("MetaMapWKB")) then
		LoadAddOn("MetaMapWKB");
	end
	if(IsAddOnLoaded("MetaMapWKB")) then
		MetaKB_Loaded = true;
	end
end

function MetaMapBKP_BackupData()
	local info = METAMAPBKP_BACKUP_DONE;
	BKP_MetaMapNotes_Data = {};
	BKP_MetaMapNotes_Lines = {};
	BKP_MetaKB_Data = {};
	BKP_MetaMapNotes_Data = MetaMapNotes_Data;
	BKP_MetaMapNotes_Lines = MetaMapNotes_Lines;
	if(MetaKB_Loaded) then
		BKP_MetaKB_Data = MetaKB_Data;
	else
		info = info.."\n"..METAMAP_NOKBDATA;
	end
	MetaMapBKP_InfoHeader:SetText(info)
end

function MetaMapBKP_RestoreData()
	local info = METAMAPBKP_RESTORE_DONE;
	if(BKP_MetaMapNotes_Data ~= nil) then
		MetaMapNotes_Data = {};
		MetaMapNotes_Data = BKP_MetaMapNotes_Data;
	end
	if(BKP_MetaMapNotes_Lines ~= nil) then
		MetaMapNotes_Lines = {};
		MetaMapNotes_Lines = BKP_MetaMapNotes_Lines;
	end
	if(BKP_MetaKB_Data[MetaKB_dbID] ~= nil and MetaKB_Loaded) then
		MetaKB_Data = {};
		MetaKB_Data[MetaKB_dbID] = {};
		MetaKB_Data[MetaKB_dbID] = BKP_MetaKB_Data[MetaKB_dbID];
	else
		info = info.."\n"..METAMAP_NOKBDATA;
	end
	MetaMapBKP_InfoHeader:SetText(info)
end
