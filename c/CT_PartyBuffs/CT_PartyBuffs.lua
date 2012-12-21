-- Init
CT_NUM_PARTY_BUFFS = 14;
CT_NUM_PARTY_DEBUFFS = 6;
CT_NUM_PET_BUFFS = 9;
CT_NUM_SHOWN_PARTY_BUFFS = 4;
CT_NUM_SHOWN_PET_BUFFS = 4;
CT_ShowPartyBuffs = 1;
CT_ShowPetBuffs = 1;

function CT_PartyBuffs_OnLoad()
	getglobal("PetDebuff1"):SetPoint("TOPLEFT", "PetFrame", "TOPLEFT", 48, -59);
	local frame = getglobal("PartyMemberFrame" .. this:GetID());
	this.oldHide = frame:GetScript("OnHide");
	this.oldShow = frame:GetScript("OnShow");
	frame:SetScript("OnShow", function() local frame = getglobal("CT_PartyBuffFrame" .. this:GetID()); if ( frame.oldShow ) then frame.oldShow(); end frame:Show() end);
	frame:SetScript("OnHide", function() local frame = getglobal("CT_PartyBuffFrame" .. this:GetID()); if ( frame.oldHide ) then frame.oldHide(); end frame:Hide() end);
end


function CT_PartyBuffs_RefreshBuffs(elapsed)
	this.update = this.update + elapsed;
	if ( this.update > 0.5 ) then
		this.update = 0.5 - this.update;
			local i;
		if ( CT_ShowPartyBuffs == 0 ) then
			for i = 1, CT_NUM_PARTY_BUFFS, 1 do
				getglobal(this:GetName() .. "Buff" .. i):Hide();
			end
			return;
		end
		for i = 1, CT_NUM_PARTY_BUFFS, 1 do
			if ( i > CT_NUM_SHOWN_PARTY_BUFFS ) then
				getglobal(this:GetName() .. "Buff" .. i):Hide();
			else
				local bufftexture = UnitBuff("party" .. this:GetID(), i);
				if ( bufftexture ) then
					getglobal(this:GetName() .. "Buff" .. i .. "Icon"):SetTexture(bufftexture);
					getglobal(this:GetName() .. "Buff" .. i):Show();
				else
					getglobal(this:GetName() .. "Buff" .. i):Hide();
				end
				if ( i <= CT_NUM_PARTY_DEBUFFS ) then
					local debufftexture, debuffApplications = UnitDebuff("party" .. this:GetID(), i);
					if ( debufftexture ) then
						if ( debuffApplications > 1 ) then
							getglobal(this:GetName() .. "Debuff" .. i .. "Count"):SetText(debuffApplications);
						else
							getglobal(this:GetName() .. "Debuff" .. i .. "Count"):SetText("");
						end
						getglobal(this:GetName() .. "Debuff" .. i .. "Icon"):SetTexture(debufftexture);
						getglobal(this:GetName() .. "Debuff" .. i):Show();
						if ( i <= 4 ) then
							getglobal("PartyMemberFrame" .. this:GetID() .. "Debuff" .. i):Hide();
						end
					else
						getglobal(this:GetName() .. "Debuff" .. i):Hide();
					end
				end
			end
		end
	end
end

function CT_PartyBuffs_RefreshPetBuffs(elapsed)
	this.update = this.update + elapsed;
	if ( this.update > 0.5 ) then
		this.update = 0.5 - this.update
		local i;
		if ( CT_ShowPetBuffs == 0 ) then
			for i = 1, CT_NUM_PET_BUFFS, 1 do
				getglobal(this:GetName() .. "Buff" .. i):Hide();
			end
			return;
		end
		for i = 1, CT_NUM_PET_BUFFS, 1 do
			if ( i > CT_NUM_SHOWN_PET_BUFFS ) then
				getglobal(this:GetName() .. "Buff" .. i):Hide();
			else
				local bufftexture = UnitBuff("pet", i);
				if ( bufftexture ) then
					getglobal(this:GetName() .. "Buff" .. i .. "Icon"):SetTexture(bufftexture);
					getglobal(this:GetName() .. "Buff" .. i):Show();
				else
					getglobal(this:GetName() .. "Buff" .. i):Hide();
				end
			end
		end
	end
end

PartyBuffsFunction = function (modId, text)
	local val = CT_Mods[modId]["modValue"];
	if ( val == "1" ) then
		val = "2";
		CT_ShowPartyBuffs = 1;
		CT_ShowPetBuffs = 0;
	elseif ( val == "2" ) then
		val = "3";
		CT_ShowPartyBuffs = 0;
		CT_ShowPetBuffs = 1;
	elseif ( val == "3" ) then
		val = "4";
		CT_ShowPartyBuffs = 0;
		CT_ShowPetBuffs = 0;
	elseif ( val == "4" ) then
		val = "1";
		CT_ShowPartyBuffs = 1;
		CT_ShowPetBuffs = 1;
	end

	if ( text and val ) then text:SetText(val); end
	CT_Mods[modId]["modValue"] = val;
	CT_Print("<CTMod> " .. CT_PARTYBUFFS_TOGGLE[val], 1, 1, 0);
end

PartyBuffsInitFunction = function(modId)
	val = CT_Mods[modId]["modValue"];
	if ( val == "1" ) then
		CT_ShowPartyBuffs = 1;
		CT_ShowPetBuffs = 1;
	elseif ( val == "2" ) then
		CT_ShowPartyBuffs = 1;
		CT_ShowPetBuffs = 0;
	elseif ( val == "3" ) then
		CT_ShowPartyBuffs = 0;
		CT_ShowPetBuffs = 1;
	elseif ( val == "4" ) then
		CT_ShowPartyBuffs = 0;
		CT_ShowPetBuffs = 0;
	end	
end

CT_RegisterMod(CT_PARTYBUFFS_MODNAME1, CT_PARTYBUFFS_SUBNAME1, 3, "Interface\\Icons\\Spell_Holy_PrayerOfHealing02", CT_PARTYBUFFS_TOOLTIP1, "switch", "1", PartyBuffsFunction, PartyBuffsInitFunction);

BuffNumberFunction = function (modId, text)
	local val = CT_Mods[modId]["modValue"];
	if ( val == "4" ) then
		val = "6";
	elseif ( val == "6" ) then
		val = "8";
	elseif ( val == "8" ) then
		val = "10";
	elseif ( val == "10" ) then
		val = "12";
	elseif ( val == "12" ) then
		val = "14";
	elseif ( val == "14" ) then
		val = "4";
	end

	if ( text and val ) then text:SetText(val); end
	CT_Mods[modId]["modValue"] = val;
	CT_NUM_SHOWN_PARTY_BUFFS = tonumber(val);
	if ( tonumber(val) <= 9 ) then
		CT_NUM_SHOWN_PET_BUFFS = tonumber(val);
	else
		CT_NUM_SHOWN_PET_BUFFS = 9;
	end

	CT_Print("<CTMod> " .. format(CT_PARTYBUFFS_NUMSHOWN, val), 1.0, 1.0, 0.0);
end

BuffNumberInitFunction = function(modId)
	val = CT_Mods[modId]["modValue"];
	CT_NUM_SHOWN_PARTY_BUFFS = tonumber(val);
	if ( tonumber(val) <= 9 ) then
		CT_NUM_SHOWN_PET_BUFFS = tonumber(val);
	else
		CT_NUM_SHOWN_PET_BUFFS = 9;
	end
end

CT_RegisterMod(CT_PARTYBUFFS_MODNAME2, CT_PARTYBUFFS_SUBNAME2, 3, "Interface\\Icons\\Spell_Holy_PrayerOfHealing02", CT_PARTYBUFFS_TOOLTIP2, "switch", "4", BuffNumberFunction, BuffNumberInitFunction);

CT_oldPartyMemberBuffTooltip_Update = PartyMemberBuffTooltip_Update;
function CT_newPartyMemberBuffTooltip_Update(pet)
	CT_oldPartyMemberBuffTooltip_Update(pet);
	if ( ( pet and CT_ShowPetBuffs == 1 ) or ( not pet and CT_ShowPartyBuffs == 1 ) ) then
		PartyMemberBuffTooltip:Hide();
	end
end
PartyMemberBuffTooltip_Update = CT_newPartyMemberBuffTooltip_Update;