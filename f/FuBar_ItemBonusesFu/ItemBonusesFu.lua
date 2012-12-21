ItemBonusesFu = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceHook-2.1", "AceEvent-2.0", "AceDebug-2.0", "FuBarPlugin-2.0")

local L = AceLibrary("AceLocale-2.2"):new("ItemBonusesFu")
local tablet = AceLibrary("Tablet-2.0")
local crayon = AceLibrary("Crayon-2.0")
local compost = AceLibrary("Compost-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local bonus = AceLibrary("ItemBonusLib-1.0")

local const = {
	ItemBonuses_colors = {
		X = 'FFD200',  -- attributes
		Y = '20FF20',  -- skills
		M = 'FFFFFF',  -- melee
		R = '00C0C0',  -- ranged
		C = 'FFFF00',  -- spells
		A = 'FF60FF',  -- arcane
		I = 'FF3600',  -- fire
		F = '00C0FF',  -- frost
		H = 'FFA400',  -- holy
		N = '00FF60',  -- nature
		S = 'AA12AC',  -- shadow
		L = '20FF20',  -- life
		P = '6060FF',  -- mana
	},
   
	ITEMBONUSES_EFFECTS = {
		{ effect = "STR",	format = "+%d",	short = "STR",	color = "X",	cat = "ATT" },
		{ effect = "AGI",	format = "+%d",	short = "AGI",	color = "X",	cat = "ATT" },
		{ effect = "STA",	format = "+%d",	short = "STA",	color = "X",	cat = "ATT" },
		{ effect = "INT",	format = "+%d",	short = "INT",	color = "X",	cat = "ATT" },
		{ effect = "SPI",	format = "+%d",	short = "SPI",	color = "X",	cat = "ATT" },
		{ effect = "ARMOR",	format = "+%d",	short = "ARM",	color = "X",	cat = "ATT" },

		{ effect = "ARCANERES",	format = "+%d",	short = "R",	color = "A",	cat = "RES" },
		{ effect = "FIRERES",	format = "+%d",	short = "R",	color = "I",	cat = "RES" },
		{ effect = "NATURERES",	format = "+%d",	short = "R",	color = "N",	cat = "RES" },
		{ effect = "FROSTRES",	format = "+%d",	short = "R",	color = "F",	cat = "RES" },
		{ effect = "SHADOWRES",	format = "+%d",	short = "R",	color = "S",	cat = "RES" },

		{ effect = "DEFENSE",	format = "+%d",	short = "DEF",	color = "Y",	cat = "SKILL" },
		{ effect = "MINING",	format = "+%d",	short = "MIN",	color = "Y",	cat = "SKILL" },
		{ effect = "HERBALISM",	format = "+%d",	short = "HER",	color = "Y",	cat = "SKILL" },
		{ effect = "SKINNING",	format = "+%d",	short = "SKI",	color = "Y",	cat = "SKILL" },
		{ effect = "FISHING",	format = "+%d",	short = "FIS",	color = "Y",	cat = "SKILL" },

		{ effect = "ATTACKPOWER",	format = "+%d",		short = "AP",	color = "M",	cat = "BON" },
		{ effect = "ATTACKPOWERUNDEAD",	format = "+%d",		short = "APU",	color = "M",	cat = "BON" },
		{ effect = "ATTACKPOWERFERAL",	format = "+%d",		short = "APF",	color = "M",	cat = "BON" },
		{ effect = "CRIT",		format = "+%d%%",	short = "C",	color = "M",	cat = "BON" },
		{ effect = "BLOCK",		format = "+%d%%",	short = "B",	color = "M",	cat = "BON" },
		{ effect = "BLOCKVALUE",	format = "+%d",		short = "BV",	color = "M",	cat = "BON" },
		{ effect = "DODGE",		format = "+%d%%",	short = "D",	color = "M",	cat = "BON" },
		{ effect = "PARRY",		format = "+%d%%",	short = "P",	color = "M",	cat = "BON" },
		{ effect = "TOHIT",		format = "+%d%%",	short = "H",	color = "M",	cat = "BON" },
		{ effect = "RANGEDATTACKPOWER", format = "+%d",		short = "A",	color = "R",	cat = "BON" },
		{ effect = "RANGEDCRIT",	format = "+%d%%",	short = "C",	color = "R",	cat = "BON" },

		{ effect = "DMG",		format = "+%d",		short = "D",	color = "C",	cat = "SBON" },
		{ effect = "HEAL",		format = "+%d",		short = "H",	color = "C",	cat = "SBON"},
		{ effect = "HOLYCRIT", 		format = "+%d%%",	short = "HC",	color = "C",	cat = "SBON" },
		{ effect = "SPELLCRIT", 	format = "+%d%%",	short = "SC",	color = "C",	cat = "SBON" },
		{ effect = "SPELLTOHIT",	format = "+%d%%",	short = "SH",	color = "C",	cat = "SBON" },
		{ effect = "ARCANEDMG", 	format = "+%d",		short = "D",	color = "A",	cat = "SBON" },
		{ effect = "FIREDMG", 		format = "+%d",		short = "D",	color = "I",	cat = "SBON" },
		{ effect = "FROSTDMG",		format = "+%d",		short = "D",	color = "F",	cat = "SBON" },
		{ effect = "HOLYDMG",		format = "+%d",		short = "D",	color = "H",	cat = "SBON" },
		{ effect = "NATUREDMG",		format = "+%d",		short = "D",	color = "N",	cat = "SBON" },
		{ effect = "SHADOWDMG",		format = "+%d",		short = "D",	color = "S",	cat = "SBON" },
		{ effect = "DMGUNDEAD",		format = "+%d",		short = "D",	color = "S",	cat = "SBON" },
		{ effect = "SPELLPEN",		format = "+%d",		short = "SP",	color = "C",	cat = "SBON" },

		{ effect = "HEALTH",	format = "+%d",		short = "P",	color = "L",	cat = "OBON" },
		{ effect = "HEALTHREG",	format = "%d HP/5s",	short = "R",	color = "L",	cat = "OBON" },
		{ effect = "MANA",	format = "+%d",		short = "P",	color = "P",	cat = "OBON" },
		{ effect = "MANAREG",	format = "%d MP/5s",	short = "R",	color = "P",	cat = "OBON" },
    },
    ITEMBONUSES_CATEGORIES = {ATT='Attributes', BON='Melee and ranged combat', SBON='Spells', RES='Resistance', SKILL='Skills', OBON='Life and mana'},
}

ItemBonusesFu.version = "2.0." .. string.sub("$Revision: 9785 $", 12, -3)
ItemBonusesFu.date = string.sub("$Date: 2006-09-02 03:25:39 +0200 (Sa, 02 Sep 2006) $", 8, 17)
ItemBonusesFu.hasIcon = "Interface\\Icons\\Spell_Nature_EnchantArmor.blp"
ItemBonusesFu.hasNoColor = true
ItemBonusesFu.independentProfile = true

function ItemBonusesFu:OnInitialize()
	self:RegisterDB("FuBar_ItemBonusesDB")
end

function ItemBonusesFu:OnEnable()
	self:RegisterEvent("ItemBonusLib_Update", "Update", 1)
end

function ItemBonusesFu:UpdateData()
	self:Debug("Updating Data")
	local check
	for i,e in pairs(const.ITEMBONUSES_EFFECTS) do
		if self.db.profile[e.effect] then
			check = true
		end
	end
	if not check then
		self.db.profile.display_none = true
	end
end

function ItemBonusesFu:UpdateText()
	self:Debug("Updating Text")
	if self.db.profile.display_none then
		if self.db.profile.short_display then
			self:SetText(L["IB"])
		else
			self:SetText(L["Item Bonuses"])
		end
	else
		if not bonus:IsActive() then
		self:Debug("BonusScanner not active!")
			self:SetText(crayon:Red(L["BonusScanner N/A"]))
		else
			local text = compost:Acquire()
			for i,e in ipairs(const.ITEMBONUSES_EFFECTS) do
				if self.db.profile[e.effect] then
					table.insert(text, self:GetBonusText(e, false))
				end
			end
			self:SetText(table.concat(text, " "))
			compost:Reclaim(text)
		end
	end
end

function ItemBonusesFu:OnTooltipUpdate()
	self:Debug("Updating Tooltip")
	if not bonus:IsActive() then
		self:Debug("BonusScanner not active!")
		local TabCat = tablet:AddCategory(
			'columns', 1,
			'child_textR', 1,
			'child_textG', 0,
			'child_textB', 0
		)
		TabCat:AddLine('text', L["BonusScanner N/A"])
	else
		local TabCat = compost:Acquire()
		for i,itemcat in pairs(const.ITEMBONUSES_CATEGORIES) do
			TabCat[i] = tablet:AddCategory(
				'text', L[itemcat],
				'columns', 2,
				'textR', 0,
				'textG', 1,
				'textB', 0,
				'child_textR', 1,
				'child_textG', 1,
				'child_textB', 0,
				'child_text2R', 1,
				'child_text2G', 1,
				'child_text2B', 1
			)
		end
		
		for i,e in pairs(const.ITEMBONUSES_EFFECTS) do
			local b = bonus:GetBonus(e.effect)
			self:Debug(e.effect .. " = " .. b)
			if b == 0 then
				self:Debug("GetBonus returned 0, skipping")
			else
				local val
				if e.format then
		   			val = format(e.format,b)
				else
					val = b
				end
				TabCat[e.cat]:AddLine(
					'text', bonus:GetBonusFriendlyName(e.effect),
					'text2', val
				)
			end
		end

		compost:Reclaim(TabCat)
	end
end

function ItemBonusesFu:OnMenuRequest(level, value)
	if level == 1 then
		dewdrop:AddLine(
			'text', L["Display none"],
			'func', function() self:ToggleOption("display_none", true) end,
			'checked', self.db.profile.display_none
		)
		for  i,e in pairs(const.ITEMBONUSES_CATEGORIES) do
			dewdrop:AddLine(
				'text', L[e],
				'hasArrow', true,
				'value', i
			)
		end
		dewdrop:AddLine()
		dewdrop:AddLine(
			'text', L["Brief label text"],
			'func', function() self:ToggleOption("short_display", true) end,
			'checked', self.db.profile.short_display
		)
		dewdrop:AddLine(
			'text', L["Show Colored text"],
			'func', function() self:ToggleOption("colored", true) end,
			'checked', self.db.profile.colored
		)
	elseif level == 2 then
		for i,e in pairs(const.ITEMBONUSES_EFFECTS) do
			if e.cat == value then
				local my_e = e
				dewdrop:AddLine(
					'text', self:GetBonusText(my_e, true),
					'func', function() self.db.profile.display_none = false; self:ToggleOption(my_e.effect, true) end,
					'checked', self.db.profile[my_e.effect]
				)
			end
		end
	end
end

function ItemBonusesFu:ToggleOption(var, doUpdate)
	self.db.profile[var] = not self.db.profile[var]
	if doUpdate then
		self:Update()
	end
	return self.db.profile[var]
end

function ItemBonusesFu:GetBonusText(EffectTable, forMenu)
	local t = compost:Acquire()
	local val
	local b = bonus:GetBonus(EffectTable.effect)
	local b_fn = bonus:GetBonusFriendlyName(EffectTable.effect)
	if b == 0 then
		self:Debug("GetBonus returned " .. b .. ", skipping")
	else
		val = format(EffectTable.format, b)
	end
	if forMenu then
		table.insert(t, "[" .. crayon:Colorize(const.ItemBonuses_colors[EffectTable.color], EffectTable.short) .. "] " .. b_fn)
	else
		if self.db.profile.short_display then
			table.insert(t, crayon:Colorize(const.ItemBonuses_colors[EffectTable.color], EffectTable.short))
		else
			table.insert(t, crayon:Colorize(const.ItemBonuses_colors[EffectTable.color], b_fn))
		end
	end
	if not val then
		if not forMenu then
			val = format(EffectTable.format, 0)
		else
			local text = table.concat(t)
			compost:Reclaim(t)
			return text
		end
	end
	if self.db.profile.colored then
		val = crayon:Colorize(const.ItemBonuses_colors[EffectTable.color], val)
	else
		val = crayon:White(val)
	end
	if forMenu then
		table.insert(t, " (" .. val .. ")")
	else
		table.insert(t, 1, " ")
		table.insert(t, val)
	end
	local text = table.concat(t)
	compost:Reclaim(t)
	return text
end
