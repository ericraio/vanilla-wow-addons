function ChatCast_Trade_OnLoad()
	this:RegisterEvent("TRADE_SHOW");
	this:RegisterEvent("TRADE_REQUEST");
	this:RegisterEvent("TRADE_UPDATE");
	this:RegisterEvent("TRADE_ACCEPT_UPDATE")
	this:RegisterEvent("TRADE_CLOSED")
	this:RegisterEvent("TRADE_REQUEST_CANCELLED")
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_INTERRUPTED");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("SPELLCAST_FAILED");
end

function ChatCast_Trade_OnEvent()
	if (event == "TRADE_SHOW" or event == "TRADE_REQUEST") then
		ChatCast_DoTrade();
	elseif (event == "TRADE_UPDATE" or event == "TRADE_ACCEPT_UPDATE") then
		ChatCast_FinishTrade();
	elseif (event ==  "TRADE_CLOSED" or event == "TRADE_REQUEST_CANCELLED") then
		ChatCast.Trading = nil;
	elseif (event == "SPELLCAST_STOP") then
		if (ChatCast.Trading) then
			if (ChatCast.Trading.creating == 1) then
				ChatCast.Trading.creating = 3.5
			end
		end
	elseif (event ==  "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPT") then
		if (ChatCast.Trading) then ChatCast.Trading = nil
			if (ChatCast.Feedback) then DEFAULT_CHAT_FRAME:AddMessage(CCLocale.UI.text.fb_createfail .. "  " .. arg1 .. ".") end
		end
	elseif (event == "UI_ERROR_MESSAGE") then
		if (ChatCast.Feedback) then
			if arg1 == "Interrupted" then DEFAULT_CHAT_FRAME:AddMessage(CCLocale.UI.text.fb_createfail .. "  " .. arg1 .. ".")
			elseif arg1 == "Trade target is too far away." then DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.fb_tradefail,ChatCast.Trading.name) .. "  " .. arg1)
			end
		end
		if (ChatCast.Trading) then ChatCast.Trading = nil end
	end
end
-- Trade functions
function ChatCast_FindItem(item,quantity)
	for container=0,NUM_CONTAINER_FRAMES do
		for slot=1,GetContainerNumSlots(container) do
			local _, count, _, _ = GetContainerItemInfo(container, slot)
			if (count and count >= quantity) then
				GameTooltip:SetBagItem(container,slot)
				if item == getglobal("GameTooltipTextLeft1"):GetText() then
					return container, slot;
				end
			end 
		end
	end
	return nil,nil
end;

function ChatCast_LookupItem(info, item)
	local target_rank, spellName, spellRank, iclass, inumber, target_rankt
	local j = 0
	if item == "_Healthstone" then iclass, inumber, target_rankt = "WARLOCK", 4, 10
	elseif item == "_Soulstone" then iclass, inumber, target_rankt = "WARLOCK", 5, 60
	elseif item == "_Water" then iclass, inumber, target_rankt = "MAGE", 6, 5
	elseif item == "_Food" then iclass, inumber, target_rankt = "MAGE", 7, 7
	end
	DEFAULT_CHAT_FRAME:AddMessage(item)
	if ChatCast_SpellLibrary[iclass][inumber] then
		for i=1, table.getn(ChatCast_SpellLibrary[iclass][inumber].rank), 1 do
			if UnitLevel("player") >= ChatCast_SpellLibrary[iclass][inumber].rank[i] and UnitLevel("target") >= ChatCast_SpellLibrary[iclass][inumber].rank[i] - target_rankt then
				target_rank = i
			end
		end
		if info == "item" then return ChatCast_SpellLibrary[iclass][inumber].rankitem[target_rank]
		elseif info == "spell" then
			if target_rank then
				if item == "_Water" or item == "_Food" then return ChatCast_SpellLibrary[iclass][inumber].spellname .. string.format(CCLocale.UI.rank, target_rank) end
				local i = 1
				while true do
					spellName, spellRank = GetSpellName(i, 1)
					if not spellName then
						break
					elseif spellName == ChatCast_SpellLibrary[iclass][inumber].spellname[target_rank] then
						return i
					end
				i = i + 1
				end
			end
		end
	end
	return nil
end

function ChatCast_CreateItem(item)
	if item == "_Healthstone" or item == "_Soulstone" or item == "_Water" or item == "_Food" then
		local spellid = ChatCast_LookupItem("spell", item)
		if spellid then
			if ChatCast.Trading then ChatCast.Trading.creating = 1 end
			if (ChatCast.Feedback) then DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.fb_creating, (ChatCast.Trading and ChatCast.Trading.itemname or item))) end
			if item == "_Healthstone" or item == "_Soulstone" then
				CastSpell(spellid,BOOKTYPE_SPELL)
			elseif item == "_Water" or item == "_Food" then
				CastSpellByName(spellid)
			end
		end
    end
end

function ChatCast_Soulstone(name)
	if not name then return end
	local itemname = ChatCast_LookupItem("item", "_Soulstone")
	local container, slot = ChatCast_FindItem(itemname, 1)
	if container and slot then
		local oldtarget
		if UnitName("target") then oldtarget = UnitName("target") end
		if ChatCast_Target(name) then
			UseContainerItem(container, slot)
		end
	else
		ChatCast_CreateItem("_Soulstone")
	end
end

function ChatCast_InitiateTrade(name, item, quantity)
	if not name or not item or not quantity then return nil end
	local oldtarget, itemname = nil,nil
	if UnitName("target") then oldtarget = UnitName("target") end
	if ChatCast_Target(name) then
		if item == "_Healthstone" or item == "_Water" or item == "_Food" then itemname = ChatCast_LookupItem("item", item) else itemname = item end
		local cca, ccb = ChatCast_FindItem(itemname, quantity)
		ChatCast.Trading = {
			name = name,
			itemname = itemname,
			time = 4,
			quantity = quantity,
			creating = nil
		}
		ChatCastFrame:Show()
		if cca and ccb then
			InitiateTrade("target")
--			if ChatCast.Feedback then DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.fb_trading, name)) end
		else
			ChatCast_CreateItem(item)
		end
	else
		if ChatCast.Feedback then DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.fb_targetfail, name)) end
		ChatCast.Trading = nil
	end
	if oldtarget then ChatCast_Target(oldtarget) else ClearTarget() end
end

function ChatCast_DoTrade()
	if ChatCast.Trading then
		if ChatCast.Trading.time > 0.1 then
			if not ChatCast.Trading.container or not ChatCast.Trading.slot then 
				ChatCast.Trading.container, ChatCast.Trading.slot = ChatCast_FindItem(ChatCast.Trading.itemname, ChatCast.Trading.quantity)
			end
			if ChatCast.Trading.container and ChatCast.Trading.slot then
				PickupContainerItem(ChatCast.Trading.container, ChatCast.Trading.slot)
				ClickTradeButton(1)
				ChatCast.Trading.ready = 1.5
				if CursorHasItem() then
					PickupContainerItem(ChatCast.Trading.container, ChatCast.Trading.slot);
					return;
				end
			end
		end
	end
end

function ChatCast_FinishTrade()
	if ChatCast.Trading then
		AcceptTrade()
		ChatCast.Trading = nil
	end
end

function ChatCast_Trade_OnUpdate()
	if CC_AttackTimer and CC_AttackTimer > 0 then
		CC_AttackTimer = CC_AttackTimer - arg1 
		if CC_AttackTimer < 0 then
			AttackTarget()
			ChatCastFrame:Hide()
		end
	elseif ChatCast.Trading then
		if not ChatCast.Trading.creating then
			if TradeFrame:IsShown() and ChatCast.Trading.ready then
				if ChatCast.Trading.ready < 0.1 then
					ChatCast_FinishTrade()
				else 
					ChatCast.Trading.ready = ChatCast.Trading.ready - arg1
				end
			elseif ChatCast.Trading.time < 0.1 then
				if ChatCast.Feedback then DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.fb_tradefail, ChatCast.Trading.name)) end
				ChatCast.Trading = nil
			else 
				ChatCast.Trading.time = ChatCast.Trading.time - arg1
			end
		elseif ChatCast.Trading.creating > 2 then
			ChatCast.Trading.creating = ChatCast.Trading.creating - arg1
			if ChatCast.Trading.creating <= 2 then
				ChatCast_InitiateTrade(ChatCast.Trading.name, ChatCast.Trading.itemname, ChatCast.Trading.quantity)
			end
		end
	else ChatCastFrame:Hide()
	end
end
