
assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRAPItem")

-- DO NOT translate these, use the locale tables below
local reagents = {
	["PRIEST"] = "SacredCandle",
	["MAGE"] = "ArcanePowder",
	["DRUID"] = "WildThornroot",
	["WARLOCK"] = "SoulShard",
	["SHAMAN"] = "Ankh",
	["PALADIN"] = "SymbolofDivinity",
	["ROGUE"] = "FlashPowder",
}

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["itemparticipant"] = true,
	["item"] = true,
	["Item"] = true,
	["Options for item checks."] = true,
	["SacredCandle"] = "Sacred Candle",
	["ArcanePowder"] = "Arcane Powder",
	["WildThornroot"] = "Wild Thornroot",
	["Ankh"] = "Ankh",
	["SoulShard"] = "Soul Shard",
	["SymbolofDivinity"] = "Symbol of Divinity",
	["FlashPowder"] = "Flash Powder",
	["Participant/Item"] = true,
	["Disable Checks"] = true,
	["Disable"] = true,
	["Disable Responding to Item Checks."] = true,
} end )

L:RegisterTranslations("koKR", function() return {

	["Item"] = "아이템",
	["Options for item checks."] = "아이템 확인 설정",
	["SacredCandle"] = "성스러운 양초",
	["ArcanePowder"] = "불가사의한 가루",
	["WildThornroot"] = "야생 가시",
	["Ankh"] = "십자가",
	["SoulShard"] = "영혼의 조각",
	["SymbolofDivinity"] = "신앙의 징표",
	["FlashPowder"] = "섬광 화약",
	["Participant/Item"] = "부분/아이템",
	["Disable Checks"] = "확인 응답 안함",
	["Disable"] = "사용안함",
	["Disable Responding to Item Checks."] = "아이템 확인에 대한 응답을 하지 않습니다.",
} end )

L:RegisterTranslations("zhCN", function() return {
	["itemparticipant"] = "itemparticipant",
	["item"] = "物品",
	["Options for item checks."] = "物品检查选项",
	["SacredCandle"] = "神圣蜡烛",
	["ArcanePowder"] = "魔粉",
	["WildThornroot"] = "野生棘根草",
	["Ankh"] = "十字章",
	["SoulShard"] = "灵魂碎片",
	["SymbolofDivinity"] = "神圣符印",
	["FlashPowder"] = "闪光粉",
	["Participant/Item"] = "Participant/Item",
	["Disable Checks"] = "禁止检查",
	["Disable"] = "禁止",
	["Disable Responding to Item Checks."] = "禁止回复物品检查",
} end )


L:RegisterTranslations("zhTW", function() return {
	["itemparticipant"] = "itemparticipant",
	["item"] = "物品",
	["Options for item checks."] = "物品檢查選項",
	["SacredCandle"] = "神聖蠟燭",
	["ArcanePowder"] = "魔粉",
	["WildThornroot"] = "野生棘根草",
	["Ankh"] = "十字章",
	["SoulShard"] = "靈魂碎片",
	["SymbolofDivinity"] = "神聖符印",
	["FlashPowder"] = "閃光粉",
	["Participant/Item"] = "隊員/物品",
	["Disable Checks"] = "停用檢查",
	["Disable"] = "停用",
	["Disable Responding to Item Checks."] = "停止回應物品檢查。",
} end )

L:RegisterTranslations("deDE", function() return {
	["SacredCandle"] = "Hochheilige Kerze",
	["ArcanePowder"] = "Arkanes Pulver",
	["WildThornroot"] = "Wilder Dornwurz",
	["Ankh"] = "Ankh",
	["SymbolofDivinity"] = "Symbol der Offenbarung",
	["FlashPowder"] = "Blitzstrahlpulver",
	["SoulShard"] = "Seelensplitter",
} end )

L:RegisterTranslations("frFR", function() return {
	--["itemparticipant"] = true,
	--["item"] = true,
	["Item"] = "Objet",
	["Options for item checks."] = "Options concernant les v\195\169rifications des objets.",
	["SacredCandle"] = "Bougie sacr\195\169e",
	["ArcanePowder"] = "Poudre des arcanes",
	["WildThornroot"] = "Ronceterre sauvage",
	["Ankh"] = "Ankh",
	["SoulShard"] = "Fragment d'\195\162me",
	["SymbolofDivinity"] = "Symbole de divinit\195\169",
	["FlashPowder"] = "Poudre aveuglante",
	["Participant/Item"] = "Participant/Objet",
	["Disable Checks"] = "D\195\169sactiver les v\195\169rifications",
	["Disable"] = "D\195\169sactiver",
	["Disable Responding to Item Checks."] = "D\195\169sactive l'envoi d'une r\195\169ponse lors des v\195\169rifications des objets.",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

oRAPItem = oRA:NewModule(L["itemparticipant"])
oRAPItem.defaults = {
	disable = false,
}
oRAPItem.participant = true
oRAPItem.name = L["Participant/Item"]
oRAPItem.consoleCmd = L["item"]
oRAPItem.consoleOptions = {
 	type = "group",
 	desc = L["Options for item checks."],
	name = L["Item"],
 	args = {
		[L["Disable"]] = {
			type = "toggle",
			name = L["Disable Checks"],
			desc = L["Disable Responding to Item Checks."],
			get = function() return oRAPItem.db.profile.disable end,
			set = function(v) oRAPItem.db.profile.disable = v end,
		},
		
	}
}

------------------------------
--      Initialization      --
------------------------------

function oRAPItem:OnEnable()
	self:RegisterCheck("ITMC", "oRA_ItemCheck")
	self:RegisterCheck("REAC", "oRA_ReagentCheck")
end

function oRAPItem:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterCheck("ITMC")
	self:UnregisterCheck("REAC")
end


-------------------------
--   Event Handlers    --
-------------------------

function oRAPItem:oRA_ItemCheck( msg, author)
	if not self:IsValidRequest(author) then return end
	msg = self:CleanMessage(msg)
	local _, _, itemname = string.find(msg, "^ITMC (.+)$")
	if itemname then
		if self.db.profile.disable then
			self:SendMessage("ITM -1 "..itemname.." "..author)
		else
			local numitems = self:GetItems(itemname)
			if numitems and numitems > 0 then
				self:SendMessage("ITM "..numitems.." "..itemname.." "..author)
			end
		end
	end

end

function oRAPItem:oRA_ReagentCheck(msg, author)
	if not self:IsValidRequest(author) then return end
	msg = self:CleanMessage(msg)
	if self.db.profile.disable then 
		self:SendMessage("REA -1 "..author )
	else
		local numitems = self:GetReagents()
		if numitems and numitems > 0 then
			self:SendMessage("REA " .. numitems .. " " .. author )
		end
	end
end


-------------------------
--  Utility Functions  --
-------------------------

function oRAPItem:GetItems( itemname )
	local numitems = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag)
		if size > 0 then
			for slot=1, size, 1 do
				local ilink = GetContainerItemLink(bag,slot)
				if ilink then
					local _, _, name = string.find(ilink, "%[(.+)%]")
					
					if string.find(name, itemname) then
						local _, itemcount, _, _, _ = GetContainerItemInfo(bag,slot)
						numitems = numitems + itemcount
					end
				end
			end
		end
	end
	return numitems
end

function oRAPItem:GetReagents()
	local numitems = -1
	if UnitClass("player") then
		local _,class = UnitClass("player")
		if reagents[class] then
			numitems = self:GetItems( L[reagents[class]] )
		end
	end
	return numitems
end
