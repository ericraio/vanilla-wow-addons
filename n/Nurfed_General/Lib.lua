
if (not Nurfed_General) then

	local items = Nurfed_Items:New();

	Nurfed_General = {};

	Nurfed_General.mounts = {
		18243,
		13328,
		2411,
		18247,
		18244,
		18241,
		8595,
		13332,
		5656,
		15290,
		5872,
		13333,
		5655,
		13335,
		13329,
		15277,
		5864,
		18794,
		18795,
		18793,
		15292,
		13321,
		13334,
		12351,
		18245,
		1041,
		5668,
		5665,
		19029,
		1134,
		5663,
		18796,
		18798,
		18797,
		1132,
		13327,
		12354,
		2414,
		18791,
		8563,
		13331,
		18248,
		1133,
		8630,
		18242,
		12302,
		8633,
		12303,
		8632,
		8631,
		8629,
		18766,
		18767,
		18902,
		13086,
		19030,
		18788,
		18786,
		18777,
		18787,
		18772,
		18789,
		18790,
		18776,
		19872,
		18773,
		18785,
		18778,
		18774,
		19902,
		15293,
		13322,
		18246,
		8588,
		13317,
		8586,
		8591,
		8592,
		13326,
		5873,
		12353,
		21176,
	};

	Nurfed_General.aqmounts = {
		21176,
		21324,
		21323,
		21218,
		21321,
	};

	Nurfed_General.useablemounts = {};
	Nurfed_General.useableaqmounts = {};
	Nurfed_General.randmount = false;

	function Nurfed_General:New()
		local object = {};
		setmetatable(object, self);
		self.__index = self;
		return object;
	end

	function Nurfed_General:repair(limit, inv)
		limit = tonumber(limit);
		local money = GetMoney();
		local g = math.floor(money / COPPER_PER_GOLD);
		if (g < limit) then
			return;
		end

		local repairbill = 0;
		local repairAllCost, canRepair = GetRepairAllCost();

		if (canRepair) then
			repairbill = repairbill + repairAllCost;
			RepairAllItems();
		end

		if (inv ~= 0) then
			ShowRepairCursor();
			for bag = 0,4,1 do
				for slot = 1, GetContainerNumSlots(bag) , 1 do
					local hasCooldown, repairCost = GameTooltip:SetBagItem(bag,slot);
					if (InRepairMode() and (repairCost and repairCost > 0)) then
						UseContainerItem(bag,slot);
						repairbill = repairbill + repairCost;
					end
				end
			end
			HideRepairCursor();
		end

		if (repairbill > 0) then
			local gold = floor(repairbill / (COPPER_PER_SILVER * SILVER_PER_GOLD));
			local silver = floor((repairbill - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
			local copper = mod(repairbill, COPPER_PER_SILVER);
			DEFAULT_CHAT_FRAME:AddMessage("|cffffffffSpent|r |c00ffff66"..gold.."g|r |c00c0c0c0"..silver.."s|r |c00cc9900"..copper.."c|r |cffffffffOn Repairs.|r");
		end
	end

	function Nurfed_General:itemswitch(item, slotnum)
		local bag, slot = items:getslot(item);
		if (bag and slot) then
			if (not CursorHasItem()) then
				PickupContainerItem(bag, slot);
				if (slotnum) then
					PickupInventoryItem(slotnum);
				else
					AutoEquipCursorItem();
				end
			end
		end
	end

	function Nurfed_General:updatemount()
		self.useablemounts = {};
		for k, v in self.mounts do
			local bagnum, slotnum = items:getslot(v);
			if (bagnum and slotnum) then
				local i = table.getn(self.useablemounts) + 1;
				table.setn(self.useablemounts, i);
				self.useablemounts[i] = { itemid = v, bag = bagnum, slot = slotnum };
			end
		end
	end

	function Nurfed_General:updateaqmount()
		self.useableaqmounts = {};
		for k, v in self.aqmounts do
			local bagnum, slotnum = items:getslot(v);
			if (bagnum and slotnum) then
				local i = table.getn(self.useableaqmounts) + 1;
				table.setn(self.useableaqmounts, i);
				self.useableaqmounts[i] = { itemid = v, bag = bagnum, slot = slotnum };
			end
		end
	end

	function Nurfed_General:getmount()
		local i, bufftex, mounttable;
		local _, eclass = UnitClass("player");
		for i = 0 , 20, 1 do
			bufftex = GetPlayerBuffTexture(i);
			if (bufftex and (string.find(bufftex, "_Mount_", 1, true) or string.find(bufftex, "_QirajiCrystal_", 1, true))) then
				if (not eclass == "HUNTER") then
					CancelPlayerBuff(i);
					return nil;
				else
					if (not string.find(bufftex, "_JungleTiger", 1, true)) then
						CancelPlayerBuff(i);
						return nil;
					end
				end
			end
		end

		if (GetZoneText() == "Ahn'Qiraj") then
			mounttable = self.useableaqmounts;
		else
			mounttable = self.useablemounts;
		end
		if (table.getn(mounttable) == 0) then
			self:updatemount();
			self:updateaqmount();
		end
		local count = table.getn(mounttable);
		if (count ~= 0) then
			local mount = math.random(count);
			local item = mounttable[mount];
			if (item) then
				itemLink = GetContainerItemLink(item.bag, item.slot);
				if (itemLink) then
					_, itemID = items:linkdecode(itemLink);
					if (itemID == item.itemid) then
						return item.bag, item.slot;
					else
						table.remove(mounttable, mount);
					end
				else
					table.remove(mounttable, mount);
				end
			end
		end
		return nil;
	end
end