local LootUpdate = {};

function LootCounter_OnLoad()
	this:RegisterEvent("CHAT_MSG_LOOT");
	this:RegisterEvent("BAG_UPDATE");
end

function LootCounter_OnEvent(event)
	if event == "CHAT_MSG_LOOT" and (string.find(arg1,"You receive loot") or string.find(arg1,"Ihr bekommt Beute") or string.find(arg1,"Vous recevez")) then
		table.insert(LootUpdate,{msg = arg1, cnt = 0});
	elseif table.getn(LootUpdate) ~= 0 then
		for bagcnt = 0, 4 do
			slots = GetContainerNumSlots(bagcnt);
			for slotcnt = 1, slots do
				if GetContainerItemLink(bagcnt, slotcnt) then
					local item, rar;
					for a,b,c,d in string.gfind(GetContainerItemLink(bagcnt, slotcnt), "(%d+):(%d+):(%d+):(%d+)") do
						item = "item:"..a..":"..b..":"..c..":"..d;
					end
					item,_,rar = GetItemInfo(item);				
					for j = 1, table.getn(LootUpdate) do
						if string.find(LootUpdate[j].msg, item) then
							local _,count = GetContainerItemInfo(bagcnt, slotcnt);
							LootUpdate[j].cnt = LootUpdate[j].cnt + count;
							LootUpdate[j].msg = item;
							LootUpdate[j].rar = rar;
						end
					end
				end
			end
		end
		for j = 1, table.getn(LootUpdate) do
			if ITEM_QUALITY_COLORS[LootUpdate[j].rar] then
				SCT:DisplayCustomEvent("[Loot: "..LootUpdate[j].msg.." "..LootUpdate[j].cnt.."]",ITEM_QUALITY_COLORS[LootUpdate[j].rar]);
			end
		end
		LootUpdate = {};						
	end
end