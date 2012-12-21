--$Id: enhancedtrades.lua 2435 2006-06-07 04:26:29Z kaelten $

local locals = KC_ET_LOCALS

local toLesserEssence = {
  ["10939:0:0:0"] = "10938:0:0:0",
  ["11082:0:0:0"] = "10998:0:0:0",
  ["11135:0:0:0"] = "11134:0:0:0",
  ["11175:0:0:0"] = "11174:0:0:0",
  ["16203:0:0:0"] = "16202:0:0:0",
}

-- put in the id for a lesser and get the id for a greater
local toGreaterEssence= {
  ["10938:0:0:0"] = "10939:0:0:0",
  ["10998:0:0:0"] = "11082:0:0:0",
  ["11134:0:0:0"] = "11135:0:0:0",
  ["11174:0:0:0"] = "11175:0:0:0",
  ["16202:0:0:0"] = "16203:0:0:0",
}

local buyables = {
 -- alchemy
  ["3371:0:0:0"]	= 1,  -- Empty Vial
  ["3372:0:0:0"]	= 1,  -- Leaded Vial
  ["8925:0:0:0"]	= 1,  -- Crystal Vial
 
  -- tailoring (and leatherworking)
  ["2320:0:0:0"]	= 1,  -- Coarse Thread
  ["2321:0:0:0"]	= 1,  -- Fine Thread
  ["4291:0:0:0"]	= 1,  -- Silken Thread
  ["8343:0:0:0"]	= 1,  -- Heavy Silken Thread
  ["14341:0:0:0"]	= 1,  -- Rune Thread

  ["2324:0:0:0"]	= 1,  -- Bleach
  ["2325:0:0:0"]	= 1,  -- Black Dye
  ["6260:0:0:0"]	= 1,  -- Blue Dye
  ["2605:0:0:0"]	= 1,  -- Green Dye
  ["4342:0:0:0"]	= 1,  -- Purple Dye
  ["2604:0:0:0"]	= 1,  -- Red Dye
  ["4341:0:0:0"]	= 1,  -- Yellow Dye
  ["4340:0:0:0"]	= 1,  -- Gray Dye
  ["6261:0:0:0"]	= 1,  -- Orange Dye
  ["10290:0:0:0"]	= 1,  -- Pink Dye

  ["4289:0:0:0"]	= 1,  -- Salt

  -- mining
  ["3857:0:0:0"]	= 1,  -- Coal

  -- enchanting
  ["6217:0:0:0"]	= 1,  -- Copper Rod
  ["17034:0:0:0"]	= 1,  -- Maple Seed
  ["4470:0:0:0"]	= 1,  -- Simple Wood
  ["11291:0:0:0"]	= 1,  -- Star Wood

  -- poison
  ["2928:0:0:0"]	= 1,  -- Dust of Decay
  ["3777:0:0:0"]	= 1,  -- Lethargy Root
  ["2930:0:0:0"]	= 1,  -- Essence of Pain
  ["8923:0:0:0"]	= 1,  -- Essence of Agony
  ["5173:0:0:0"]	= 1,  -- Deathweed
  ["8924:0:0:0"]	= 1,  -- Dust of Deterioration

  -- cooking
  ["2692:0:0:0"]	= 1,  -- Hot Spices
  ["2678:0:0:0"]	= 1,  -- Mild Spices
  ["3713:0:0:0"]	= 1,  -- Soothing Spices
  ["2665:0:0:0"]	= 1,  -- Stormwind Seasoning Herbs

  ["159:0:0:0"]		= 1,  -- Refreshing Spring Water
  ["1179:0:0:0"]	= 1,  -- Ice Cold Milk
  ["2596:0:0:0"]	= 1,  -- Skin of Dwarven Stout
  ["2894:0:0:0"]	= 1,  -- Rhapsody Malt
  ["4536:0:0:0"]	= 1,  -- Shiny Red Apple

  -- blacksmithing (and engineering)
  ["3466:0:0:0"]	= 1,  -- Strong Flux
  ["2880:0:0:0"]	= 1,  -- Weak Flux

  -- engineering (some items included above)
  ["4400:0:0:0"]	= 1,  -- Heavy Stock
  ["4399:0:0:0"]	= 1,  -- Wooden Stock

  ["10647:0:0:0"]	= 1,  -- Engineer's Ink
  ["10648:0:0:0"]	= 1,  -- Blank Parchment
  
  -- fishing
  ["6530:0:0:0"]	= 1,  -- Nightcrawlers
 }

KC_EnhancedTrades = KC_ItemsModule:new({
	type		 = "trades",
	name		 = locals.name,
	desc		 = locals.description,
	cmdOptions	 = locals.chat,
	dependencies = {"common", "bank", "inventory"},
	compost		 = CompostLib:GetInstance("compost-1"),
	sebags		 = SpecialEventsEmbed:GetInstance("Bags 1"),
	sebank		 = SpecialEventsEmbed:GetInstance("Bank 1"),
})

KC_Items:Register(KC_EnhancedTrades)

function KC_EnhancedTrades:Enable()
	self:RegisterEvent("CRAFT_SHOW")
	self:RegisterEvent("TRADE_SKILL_SHOW")
	self:RegisterEvent("CRAFT_CLOSE")
	self:RegisterEvent("TRADE_SKILL_CLOSE")
	
	if (not self:GetOpt({"trades", "options"}, "installed")) then
		self:SetOpt({"trades", "options"}, 1, true)
		self:SetOpt({"trades", "options"}, 2, true)
		self:SetOpt({"trades", "options"}, 3, true)
		self:SetOpt({"trades", "options"}, 4, true)
		self:SetOpt({"trades", "options"}, 5, true)
		self:SetOpt({"trades", "options"}, 6, false)
		self:SetOpt({"trades", "options"}, "installed", true)
	end
	
	self:BuildLegend()
end

function KC_EnhancedTrades:TRADE_SKILL_SHOW()
	if (not self.Hooks or not self.Hooks["TradeSkillFrame_Update"]) then
		self:Hook("TradeSkillFrame_SetSelection" , function (id) self:SetSelection(id)	end)
		self:Hook("TradeSkillFrame_Update", function () self:Update() end)
		self.sebags:RegisterEvent(self, "SPECIAL_BAGSLOT_UPDATE", "BagUpdate")
		self.sebank:RegisterEvent(self, "SPECIAL_BANKBAGSLOT_UPDATE", "BagUpdate")
		self:RegisterEvent("KCI_BANK_DATA_UPDATE", "BankDataUpdate")
	end
	
	self.tsf.frame:SetParents();
	self.tsf.frame:Initialize(self, self.tsf.config)	
	
	if (self.opt.frame.initialized) then
		self.opt.frame:UpdateAnchor()		
	end

	self:Update()
end

function KC_EnhancedTrades:CRAFT_SHOW()

	if (not self.Hooks or not self.Hooks["CraftFrame_Update"]) then
		self:Hook("CraftFrame_SetSelection" , function (id) self:SetSelection(id, true)	end)
		self:Hook("CraftFrame_Update", function () self:Update(true) end)
		self.sebags:RegisterEvent(self, "SPECIAL_BAGSLOT_UPDATE", "BagUpdate")
		self.sebank:RegisterEvent(self, "SPECIAL_BANKBAGSLOT_UPDATE", "BagUpdate")
		self:RegisterEvent("KCI_BANK_DATA_UPDATE", "BankDataUpdate")
	end

	self.cf.frame:SetParents();
	self.cf.frame:Initialize(self, self.cf.config)	
	
	if (self.opt.frame.initialized) then
		self.opt.frame:UpdateAnchor()		
	end

	self:Update(true)
end

function KC_EnhancedTrades:TRADE_SKILL_CLOSE()
	if (self.opt.frame.initialized) then
		self.opt.frame:UpdateAnchor()		
	end
end

function KC_EnhancedTrades:CRAFT_CLOSE()
	if (self.opt.frame.initialized) then
		self.opt.frame:UpdateAnchor()		
	end
end

function KC_EnhancedTrades:BankDataUpdate()
	if (self.Hooks["TradeSkillFrame_SetSelection"]) then
		self:SetSelection(self.tsfid)
	end

	if (self.Hooks["CraftFrame_SetSelection"]) then
		self:SetSelection(self.cfid, true)
	end
end

function KC_EnhancedTrades:BagUpdate(bag, slot, itemlink, stack, oldlink)
	if ((not itemlink and not oldlink)) then
		return
	end
	
	self:ClearCacheItem(itemlink)
	self:ClearCacheItem(oldlink)
	
end

function KC_EnhancedTrades:ClearCacheItem(link)
	if (not link) then return end
	local code = self.common:GetCode(link, true)
	
	if (self.cross[code]) then
		for k,v in self.cross[code] do
			self.cache[k] = nil
		end	
		
		if (self.Hooks["TradeSkillFrame_Update"]) then
			self:Update()
			getglobal("TradeSkillFrameTitleText"):SetText(self.legend)
		end

		if (self.Hooks["CraftFrame_Update"]) then
			self:Update(true)
			getglobal("CraftFrameTitleText"):SetText(self.legend)
		end
	end
end

function KC_EnhancedTrades:Update(craft)
	
	self.Hooks[craft and "CraftFrame_Update" or "TradeSkillFrame_Update"].orig()
	
	if (self:GetOpt({"trades", "options"}, 1)) then
		local skillname = craft and GetCraftDisplaySkillLine() or GetTradeSkillLine()
		getglobal(craft and "CraftFrameTitleText" or "TradeSkillFrameTitleText"):SetText(format("%s %s", skillname, self.legend))
	end

	if (craft and not CraftRankFrame:IsVisible()) then
		return
	end

	if (not self.cache) then 
		self.cache = {}
	end

	for i=1, (craft and CRAFTS_DISPLAYED or TRADE_SKILLS_DISPLAYED) do
		local button = getglobal((craft and "Craft" or "TradeSkillSkill")..i)
		local skill = button:GetID()

		local skillName, skillType

		if (craft) then
			skillName, _, skillType = GetCraftInfo(skill)
		else
			skillName, skillType  = GetTradeSkillInfo(skill)
		end
		
		if (not skillName) then return end

		if (not self.cache[skillName] and skillType ~= "header") then
			self:BuildData(skill, skillName, craft)
		end

		if (skillType ~= "header") then
			button:SetText(format(" %s [%s]", skillName or "", self.cache[skillName] or ""))
		end
	end
end

function KC_EnhancedTrades:SetSelection(id, craft)
	if (craft) then self.cfid = id else	self.tsfid = id	end
	self.Hooks[craft and "CraftFrame_SetSelection" or "TradeSkillFrame_SetSelection"].orig(id)
	
	local skillName, skillType 

	if (craft) then
		skillName, _, skillType = GetCraftInfo(id)
	else
		skillName, skillType = GetTradeSkillInfo(id)
	end
	
	if (skillType == "header") then
		return
	end
	
	for i=1, (craft and GetCraftNumReagents(id) or GetTradeSkillNumReagents(id)) do
		local reagentName = craft and GetCraftReagentInfo(id, i) or GetTradeSkillReagentInfo(id, i)
		if (not reagentName) then break end

		local code = self.common:GetCode((craft and GetCraftReagentItemLink(id, i) or GetTradeSkillReagentItemLink(id,i)), true)
		local count = self.app.bank:Count(code) 

		local text = format(count > 0 and "%s [%s] %s" or "%s %s", reagentName, count > 0 and count or (buyables[code] and locals.buyable or ""), buyables[code] and locals.buyable or "")
		
		getglobal(format((craft and "CraftReagent%sName" or "TradeSkillReagent%sName"),i)):SetText(text)
	end

end

function KC_EnhancedTrades:BuildData(skill, skillName, craft)
	if (not self.cross) then 
		self.cross = {}
	end

	local i		= self.compost:GetTable()
	local iv	= self.compost:GetTable()
	local ib	= self.compost:GetTable()
	local ivb	= self.compost:GetTable()
	local ivba	= self.compost:GetTable()
	
	for reag = 1, (craft and GetCraftNumReagents(skill) or GetTradeSkillNumReagents(skill)) do
		local code = self.common:GetCode((craft and GetCraftReagentItemLink(skill, reag) or GetTradeSkillReagentItemLink(skill,reag)), true)
		
		if (not code) then
			break
		end

		if (not self.cross[code]) then
			self.cross[code] = {}
		end
		
		if (not self.cross[code][skillName]) then
			self.cross[code][skillName] = 1			
		end
		
		local qty, icount
		
		if (craft) then
			_, _, qty, icount = GetCraftReagentInfo(skill, reag)
		else
			_, _, qty, icount = GetTradeSkillReagentInfo(skill, reag)
		end

		
		local bcount = self.app.bank:Count(code)
		local acount = 0

		if (self:GetOpt({"trades", "options"}, 6)) then
			acount = self:AltCount(code)
		end

		tinsert(i, floor(icount/qty))
		tinsert(ib, floor((icount + bcount)/qty))
		
		if (not buyables[code]) then
			tinsert(iv, floor(icount/qty))
			tinsert(ivb, floor((icount + bcount)/qty))
			tinsert(ivba, floor((icount + bcount + acount)/qty))
		end
	end
		
	local num = function(array)
		sort(array)
		return math.min(unpack(array) or 0)
	end
	
	numI	= num(i)
	numIv	= num(iv)
	numIb	= num(ib)
	numIvb	= num(ivb)
	numIvba	= num(ivba)
	
	if (self:GetOpt({"trades", "options"}, 2) and numI == numIv and numI == numIb and numI == numIvb and numI == numIvba) then
		self.cache[skillName] = numI
	else	
		local data = self.compost:GetTable()
		local mask = "%s" 

		if (self:GetOpt({"trades", "options"}, 3)) then
			mask = mask .. "/%s"
			tinsert(data, numIv)
		end

		if (self:GetOpt({"trades", "options"}, 4)) then
			mask = mask .. "/%s"
			tinsert(data, numIb)
		end
		
		if (self:GetOpt({"trades", "options"}, 5)) then
			mask = mask .. "/%s"
			tinsert(data, numIvb)
		end
		
		if (self:GetOpt({"trades", "options"}, 6)) then
			mask = mask .. "/%s"
			tinsert(data, numIvba)
		end

		self.cache[skillName] = format(mask, numI, unpack(data))

		self.compost:Reclaim(data)
	end

	
	self.compost:Reclaim(i)
	self.compost:Reclaim(iv)
	self.compost:Reclaim(ib)
	self.compost:Reclaim(ivb)
	self.compost:Reclaim(ivba)	
end

function KC_EnhancedTrades:AltCount(code)
	if (not self.peeps) then
		self.peeps = self.common:GetCharList(ace.char.realm, ace.char.faction)	
		self.peeps[ace.char.id] = nil
	end
	
	local total = 0

	for k,v in self.peeps do
		total = total + self.app.bank:Count(code, v.faction, k)	+ self.app.inventory:Count(code, v.faction, k)
	end
	
	return total
end

function KC_EnhancedTrades:BuildLegend()
	local legend = "|cff00aa00i"

	if (self:GetOpt({"trades", "options"}, 3)) then
		legend = legend .. "/i+v"
	end

	if (self:GetOpt({"trades", "options"}, 4)) then
		legend = legend .. "/i+b"
	end
	
	if (self:GetOpt({"trades", "options"}, 5)) then
		legend = legend .. "/i+v+b"
	end
	
	if (self:GetOpt({"trades", "options"}, 6)) then
		legend = legend .. "/ivb+alts"
	end

	self.legend = legend
end