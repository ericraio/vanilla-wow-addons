-- MetaMapZSM (ZoneShifter for German and French clients)
-- Written by MetaHawk - aka Urshurak

function MetaMapZSM_Init()
	MetaMapZSM_InfoHeader:SetText(METAMAPZSM_NEW_VERSION);
	for index, versions in MetaMapZSM_VersionData do
		for version, value in versions do
			local setButton = false;
			if(GetLocale() == "deDE") then
				if(DE_ZoneShift[version] ~= nil) then
					setButton = true;
				end
			elseif(GetLocale() == "frFR") then
				if(FR_ZoneShift[version] ~= nil) then
					setButton = true;
				end
			end
			if(setButton) then
				getglobal("MetaMapZSM_ZoneShiftButton"..index):SetText("ZoneShift from "..value.old.." to "..value.new);
				getglobal("MetaMapZSM_ZoneShiftButton"..index.."Version"):SetText(value.old);
				getglobal("MetaMapZSM_ZoneShiftButton"..index):Show();
				if(MetaMapOptions.ZoneShiftVersion >= value.new) then
					getglobal("MetaMapZSM_ZoneShiftButton"..index):Disable();
					getglobal("MetaMapZSM_ZoneShiftButton"..index.."SkipShift"):Hide();
				else
					getglobal("MetaMapZSM_ZoneShiftButton"..index):Enable();
					getglobal("MetaMapZSM_ZoneShiftButton"..index.."SkipShift"):Show();
				end
			end
		end
	end
	if(MetaMapOptions.ZoneShiftVersion == METAMAP_TOC) then
		MetaMapZSM_InfoHeader:SetText(METAMAPZSM_NO_SHIFT);
		MetaMapZSM_Update:Disable();
	end
end

function MetaMapZSM_OnClick(id, button)
	if(not IsAddOnLoaded("MetaMapWKB")) then
		LoadAddOn("MetaMapWKB");
	end
	local newShift = MetaMapZSM_VersionData[button][id].new;
	MetaMapZSM_Convert(newShift);
	MetaMapOptions.ZoneShiftVersion = newShift;
	MetaMapZSM_Init();
end

function MetaMapZSM_Convert(newShift)
	local temp = {}
	for z=1, 2, 1 do
		for index, value in MetaMapNotes_Data[z] do
			if(GetLocale() == "deDE" and type(z) ~= "string") then
				temp[DE_ZoneShift[newShift][z][index]] = value;
			elseif(GetLocale() == "frFR" and type(z) ~= "string") then
				temp[FR_ZoneShift[newShift][z][index]] = value;
			end
		end
		MetaMapNotes_Data[z] = {};
		for index, value in temp do
			MetaMapNotes_Data[z][index] = value;
		end
		temp = {};
	end
	temp = {};
	for z=1, 2, 1 do
		for index, value in MetaMapNotes_Lines[z] do
			if(GetLocale() == "deDE") then
				temp[DE_ZoneShift[newShift][z][index]] = value;
			elseif(GetLocale() == "frFR") then
				temp[FR_ZoneShift[newShift][z][index]] = value;
			end
		end
		MetaMapNotes_Lines[z] = {};
		for index, value in temp do
			MetaMapNotes_Lines[z][index] = value;
		end
		temp = {};
	end
	temp = {};
	if(MetaKB_Data) then
		for name, continentTable in MetaKB_Data[MetaKB_dbID] do
			for continent, zoneTable in continentTable do
				for zone, value in zoneTable do
					if(GetLocale() ~= "deDE") then
						temp[DE_ZoneShift[newShift][continent][zone]] = value;
					elseif(GetLocale() == "frFR") then
						temp[FR_ZoneShift[newShift][continent][zone]] = value;
					end
				end
				MetaKB_Data[MetaKB_dbID][name][continent] = {};
				for index, value in temp do
					MetaKB_Data[MetaKB_dbID][name][continent][index] = value;
				end
				temp = {};
			end
		end
	end
	MetaMapZSM_InfoHeader:SetText(format(METAMAPZSM_UPDATE_DONE, newShift));
end

MetaMapZSM_VersionData = {
	[1] = {
		[11000] = {
			["old"] = 11000,
			["new"] = 11100,
		},
	},
	[2] = {
		[11100] = {
			["old"] = 11100,
			["new"] = 11200,
		},
	},
}

-- German ZoneShift
DE_ZoneShift = {
	[11000] = {
		[0] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 },
		[1] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21 },
		[2] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 },
	},
	[11100] = {
		[0] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 },
		[1] = { 1, 2, 4, 3, 14, 20, 5, 9, 6, 7, 8, 10, 11, 12, 13, 15, 17, 18, 16 ,19, 21 },
		[2] = { 1, 2, 7, 10, 15, 24, 6, 13, 21, 16, 20, 3, 12, 19, 23, 25, 4, 5, 8, 9, 14, 11, 17, 18, 22 },
	},
	[11200] = {
		[0] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 },
		[1] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21 },
		[2] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 },
	},
}
-- French ZoneShift
FR_ZoneShift = {
	[11000] = {
		[0] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 },
		[1] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21 },
		[2] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 },
	},
	[11100] = {
		[0] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 },
		[1] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21 },
		[2] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 },
	},
	[11200] = {
		[0] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 },
		[1] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21 },
		[2] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 },
	},
}
