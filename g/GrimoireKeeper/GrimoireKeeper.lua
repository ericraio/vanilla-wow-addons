-- GrimoireKeeper.lua

GrimoireKeeperData = {};
local GKOld_MerchantFrame_UpdateMerchantInfo;

function GrimoireKeeper_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	GKOld_MerchantFrame_UpdateMerchantInfo = MerchantFrame_UpdateMerchantInfo;
	MerchantFrame_UpdateMerchantInfo = GrimoireKeeper_ColorMerchantInfo;
end

function GrimoireKeeper_OnEvent(event)
	if event == "VARIABLES_LOADED" then
		this:RegisterEvent("PET_BAR_UPDATE");
	elseif event == "PET_BAR_UPDATE" then 
		GrimoireKeeper_ParsePetSkills();
	end
end

function GrimoireKeeper_ParsePetSkills()
	local hasPetSpells, petToken = HasPetSpells();
	if hasPetSpells ~= nil and petToken == "DEMON" then
		local i = 1;
		local name, rank = GetSpellName(i, BOOKTYPE_PET)
		while name ~= nil do
			_,_,rank = string.find(rank, "(%d)")
			if rank == nil then rank = "0" end;
			GrimoireKeeperData[name] = tonumber(rank);
			i = i + 1;
			name, rank = GetSpellName(i, BOOKTYPE_PET);
		end
	else return;
	end
end

function GrimoireKeeper_ColorMerchantInfo()
	GKOld_MerchantFrame_UpdateMerchantInfo();
	local total = GetMerchantNumItems();
	local name, item;
	for i=1, MERCHANT_ITEMS_PER_PAGE, 1 do
		local index = (((MerchantFrame.page - 1) * MERCHANT_ITEMS_PER_PAGE) + i);
		if (index <= total) then
			item = GetMerchantItemInfo(index);
			if item == nil then return end;
			if string.find(item, "Grimoire") then
				_,_,name, rank = string.find(item, "Grimoire of ([%w%s]+) %(Rank (%d+)%)");
				if name == nil then _,_,name = string.find(item, "Grimoire of ([%w%s]+)") end;
				if name ~= nil and GrimoireKeeperData[name] ~= nil then
					local itemButton = getglobal("MerchantItem"..i.."ItemButton");
					local merchantButton = getglobal("MerchantItem"..i);
					if rank ~= nil then rank = tonumber(rank) end;
					if (rank == nil) or (rank <= GrimoireKeeperData[name]) then 
						SetItemButtonNameFrameVertexColor(merchantButton, 0, 0.75, 0.75);
						SetItemButtonSlotVertexColor(merchantButton, 0, 0.75, 0.75);
						SetItemButtonTextureVertexColor(itemButton, 0, 0.65, 0.65);
						SetItemButtonNormalTextureVertexColor(itemButton, 0, 0.65, 0.65);
					end
				end
			end
		end
	end
end