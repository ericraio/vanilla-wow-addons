local locals = KC_ITEMS_LOCALS.modules.linkview
local cross = locals.adv.cross

local frame = AceGUI:new()
local config = {
	name	  = "KC_AdvSearchFrame",
	type	  = ACEGUI_DIALOG,
	title	  = locals.adv.title,
	isSpecial = TRUE,
	width	  = 375,
	height	  = 260,
	OnShow	  = "OnShow",
	OnHide	  = "OnHide",
	anchors	 = {
		topleft = {relTo = "KC_LinkviewFrame", relPoint = "topright", xOffset = 0, yOffset = 0}
	},
	elements = {
		SearchBox	 = {
			type	 = ACEGUI_OPTIONSBOX,
			title	 = "",
			width	 = 251,
			height	 = 50,
			anchors	 = {
				bottomleft	= {relPoint = "bottomleft", xOffset = 12, yOffset = 16}
			},
			elements = {
				SearchText = {
					type	  = ACEGUI_INPUTBOX,
					title	  = locals.gui.searchtxt,
					width	  = 243,
					height	  = 26,
					anchors	  = {
						left  = {relPoint = "left", xOffset = 12, yOffset = -5}					
					},
					disabled = FALSE,
					OnEnterPressed	= "AdvSearch"
				},
				ExtSearch = {
					type     = ACEGUI_CHECKBOX,
					title    = locals.adv.ext,
					disabled = FALSE,
					width	 = 18,
					height	 = 18,
					anchors	 = {
						bottomleft = {relTo = "$parentSearchText", relPoint = "topleft", xOffset = 95, yOffset = -5}
					},
					OnClick	 = "TogExtSearch",
				},
			},
		},
		ConfigBox	 = {
			type	 = ACEGUI_OPTIONSBOX,
			title	 = locals.adv.options,
			width	 = 351,
			height	 = 150,
			anchors	 = {
				topleft	= {xOffset = 12, yOffset = -37}
			},
			elements = {
				Quality = {
					type	 = ACEGUI_DROPDOWN,
					title	 = locals.gui.quality,
					width	 = 150,
					height	 = 26,
					anchors	 = {
						topleft = {xOffset = 15, yOffset = -20}
					},
					fill	 = "FillQualities",
				},
				MinLevel = {
					type	 = ACEGUI_DROPDOWN,
					title	 = locals.gui.level,
					width	 = 150,
					height	 = 26,
					anchors	 = {
						topleft = {relTo = "$parentQuality", xOffset = 0, yOffset = -45}
					},
					fill	 = "FillLevels",
				},
				Location = {
					type	 = ACEGUI_DROPDOWN,
					title	 = locals.gui.slot,
					width	 = 150,
					height	 = 26,
					anchors	 = {
						topleft = {relTo = "$parentMinLevel", xOffset = 85, yOffset = -45}
					},
					fill	 = "FillSlots",
				},
				Class = {
					type	 = ACEGUI_DROPDOWN,
					title	 = locals.gui.class,
					width	 = 150,
					height	 = 26,
					anchors	 = {
						topleft = {relTo = "$parentQuality",  relPoint = "topright", xOffset = 23, yOffset = 0}
					},
					fill	 = "FillClasess",
					OnSelect = "OnClassSelect"
				},
				SubClass = {
					type	 = ACEGUI_DROPDOWN,
					title	 = locals.gui.type,
					width	 = 150,
					height	 = 26,
					anchors	 = {
						topleft = {relTo = "$parentClass", xOffset = 0, yOffset = -45}
					},
					fill	 = "FillSubClasses",
					OnSelect = "OnSubClassSelect",
				},
			},
		},
		SearchButton  = {
			type	 = ACEGUI_BUTTON,
			title	 = locals.gui.search,
			width	 = 98,
			height	 = 22,
			anchors	 = {
				bottomleft = {relTo = "$parentClose", relPoint = "topleft", xOffset = 0, yOffset = -1}
			},
			disabled = FALSE,
			OnClick	 = "AdvSearch"
		},
		Reset  = {
			type	 = ACEGUI_BUTTON,
			title	 = locals.adv.reset,
			width	 = 78,
			height	 = 20,
			anchors	 = {
				topright = {relPoint = "topright", xOffset = -10, yOffset = -18}
			},
			disabled = FALSE,
			OnClick	 = "Reset"
		},
	}
}

frame:Initialize(KC_Linkview, config)
KC_Linkview.advsearch = frame

function frame:FillClasess()
	return {
	{val="Armor",			tip="Only shows armor."},
	{val="Container",		tip="Only shows containers."},
	{val="Key",				tip="Only shows keys."},
	{val="Miscellaneous",	tip="Only shows miscellaneous items."},
	{val="Projectile",		tip="Only shows projectiles."},
	{val="Quest",			tip="Only shows quests."},
	{val="Quiver",			tip="Only shows quivers."},
	{val="Reagent",			tip="Only shows reagents."},
	{val="Recipe",			tip="Only shows recipes."},
	{val="Trade Goods",		tip="Only shows trade goods."},
	{val="Weapon",			tip="Only shows weapons."},
}
end

function frame:FillSubClasses()
	return {
		{val="-= Armor =-",			tip="Header for the armor class"},
		{val="Cloth",				tip="Only shows cloth armor."},
		{val="Leather",				tip="Only shows leather armor."},
		{val="Mail",				tip="Only shows mail armor."},
		{val="Plate",				tip="Only shows plate armor."},
		{val="Shields",				tip="Only shows shields."},
		{val="Miscellaneous",		tip="Only shows miscellaneous armor."},

		{val="-= Container =-",		tip="Header for the container class"},		
		{val="Bag",					tip="Only shows bags."},
		{val="Soul Bag",			tip="Only shows soul bags."},
		
		{val="-= Projectile =-",	tip="Header for the projectile class"},
		{val="Arrow",				tip="Only shows arrows."},
		{val="Bullet",				tip="Only shows bullets."},

		{val="-= Quiver =-",		tip="Header for the quiver class"},
		{val="Quiver",				tip="Only shows quivers."},
		{val="Ammo Pouch",			tip="Only shows ammo pouches."},

		{val="-= Recipe =-",		tip="Header for the recipe class"},
		{val="Alchemy",				tip="Only shows alchemy recipes."},
		{val="Blacksmithing",		tip="Only shows blacksmithign recipes."},
		{val="Book",				tip="Only shows books."},
		{val="Cooking",				tip="Only shows cooking recipes."},
		{val="Enchanting",			tip="Only shows enchanting recipes."},
		{val="Engineering",			tip="Only shows engineering recipes."},
		{val="First Aid",			tip="Only shows first aid recipes."},
		{val="Fishing",				tip="Only shows fishing recipes."},
		{val="Leatherworking",		tip="Only shows leatherworking recipes."},
		{val="Tailoring",			tip="Only shows tailoring recipes."},

		{val="-= Trade Goods =-",	tip="Header for the trade goods class"},
		{val="Explosives",			tip="Only shows explosives."},
		{val="Devices",				tip="Only shows devices."},
		{val="Trade Goods",			tip="Only shows general trade goods."},
		{val="Parts",				tip="Only shows paters."},		

		{val="-= Weapons =-",		tip="Header for the weapons class"},
		{val="Bows",				tip="Only shows bows."},		
		{val="Crossbows",			tip="Only shows crossbows."},
		{val="Daggers",				tip="Only shows daggers."},
		{val="Fist Weapons",		tip="Only shows fist weapons."},
		{val="Fishing Pole",		tip="Only shows fishing poles."},
		{val="Guns",				tip="Only shows guns."},
		{val="One-Handed Axes",		tip="Only shows one-handed axes."},
		{val="One-Handed Maces",	tip="Only shows one-handed maces."},
		{val="One-Handed Swords",	tip="Only shows one-handed swords."},
		{val="Polearms",			tip="Only shows polearms."},
		{val="Staves",				tip="Only shows staves."},
		{val="Thrown",				tip="Only shows thrown weapons."},
		{val="Two-Handed Axes",		tip="Only shows two-handed axes."},
		{val="Two-Handed Maces",	tip="Only shows two-handed maces."},
		{val="Two-Handed Swords",	tip="Only shows two-handed swords."},
		{val="Wands",				tip="Only shows wands."},
	}
end

function frame:FillQualities()
	local results = {}

	for i = 0, 6 do
		local color = ITEM_QUALITY_COLORS[i].hex..getglobal(format("ITEM_QUALITY%s_DESC", i))
		results[i] = {val=color, tip=format("Only shows %s |rquality items.", strlower(color))}
	end

	return results
end

function frame:FillLevels()
	local results = {}

	for i = 0, 60 do
		results[i] = {val=i, tip=format("Only shows items a level %s can wear.", i)}
	end

	return results
end

function frame:FillSlots()
	local slots = {
		[1] = "INVTYPE_SHOULDER",
		[2] = "INVTYPE_TRINKET",
		[3] = "INVTYPE_FINGER",
		[4] = "INVTYPE_WEAPON",
		[5] = "INVTYPE_CHEST",
		[6] = "INVTYPE_WAIST",
		[7] = "INVTYPE_NECK",
		[8] = "INVTYPE_FEET",
		[9] = "INVTYPE_2HWEAPON",
		[10] = "INVTYPE_WRIST",
		[11] = "INVTYPE_LEGS",
		[12] = "INVTYPE_HEAD",
		[13] = "INVTYPE_WEAPONMAINHAND",
		[14] = "INVTYPE_CLOAK",
		[15] = "INVTYPE_HOLDABLE",
		[16] = "INVTYPE_HAND",
		[17] = "INVTYPE_BODY",
		[18] = "INVTYPE_RANGED",
		[19] = "INVTYPE_BAG",
		[20] = "INVTYPE_WEAPONOFFHAND",
		[21] = "INVTYPE_TABARD",
	}
	local results = {}
	
	for i,v in slots do
		slots[i] = getglobal(v)
	end

	sort(slots)
	
	for i,v in slots do
		results[i] = {val=v, tip=format("Only shows items that go in the %s location.", strlower(v))}
	end
	
	return results
end

function frame:BuildAdvancedSearchTable(pattern)

	local quality	= self.ConfigBox.Quality:GetValue()
	local class		= self.ConfigBox.Class:GetValue()
	local level		= tonumber(self.ConfigBox.MinLevel:GetValue()) or 60
	local type		= self.ConfigBox.SubClass:GetValue()
	local slot		= self.ConfigBox.Location:GetValue()

	local id, name, matches
	self.app.gui.totalLinks		= 0
	self.app.gui.goodLinks		= 0
	self.app.gui.matchedLinks	= 0
	self.app.gui.searchTable	= {}

	if (self.app:GetOpt(self.app.optPath, "ExtSearch")) then
		for id in KC_ItemsDB do
			if (tonumber(id)) then
				for i,v in self.app.common:GetCodes(id) do
					local info = self.app.common:GetItemInfo(v)
					local matches = true
					name = info.cname

					self.app.gui.totalLinks = self.app.gui.totalLinks + 1
					self.app.gui.goodLinks = name and self.app.gui.goodLinks + 1 or self.app.gui.goodLinks
					
					matches = not quality and true or (ITEM_QUALITY_COLORS[info.quality or -1].hex..getglobal(format("ITEM_QUALITY%s_DESC", info.quality or 6)) == quality)
					matches = (not class  and matches)	and true or (class == info.class and matches)
					matches = (not level  and matches)	and true or (level >= (info.minlevel or 60) and matches)
					matches = (not type   and matches)	and true or (type == info.subclass and matches)
					matches = (not slot   and matches)	and true or (slot == info.location and matches)

					if (matches and name and strfind(strlower(name or ""), strlower(pattern or ""))) then
						self.app.gui.searchTable[v] = name
						self.app.gui.matchedLinks = self.app.gui.matchedLinks + 1
						table.setn(self.app.gui.searchTable, self.app.gui.matchedLinks)
					end
				end
			end
		end
	else
		for id in KC_ItemsDB do
			if (tonumber(id)) then
				local info = self.app.common:GetItemInfo(tostring(id))
				local matches = true
				name = info.cname

				self.app.gui.totalLinks = self.app.gui.totalLinks + 1
				self.app.gui.goodLinks = name and self.app.gui.goodLinks + 1 or self.app.gui.goodLinks
				
				matches = not quality and true or (ITEM_QUALITY_COLORS[info.quality or -1].hex..getglobal(format("ITEM_QUALITY%s_DESC", info.quality or 6)) == quality)
				matches = (not class  and matches)	and true or (class == info.class and matches)
				matches = (not level  and matches)	and true or (level >= (info.minlevel or 60) and matches)
				matches = (not type   and matches)	and true or (type == info.subclass and matches)
				matches = (not slot   and matches)	and true or (slot == info.location and matches)

				if (matches and name and strfind(strlower(name or ""), strlower(pattern or ""))) then
					self.app.gui.searchTable[id] = name
					self.app.gui.matchedLinks = self.app.gui.matchedLinks + 1
					table.setn(self.app.gui.searchTable, self.app.gui.matchedLinks)
				end
			end
		end
	end
	self.app.gui:Build()
end

function frame:AdvSearch()
	local pattern = self.SearchBox.SearchText:GetValue()
	pattern = pattern and ace.trim(pattern) or nil
	self:BuildAdvancedSearchTable(pattern)
	self.app.gui:BuildSortedTable()
	self.app.gui.Items:ClearList()
	self.app.gui.Items:Update()
end

function frame:OnHide()
	self.app.gui.SearchBox.SearchText:Enable()
	self.app.gui.SearchBox.SearchButton:Enable()
	self:Reset()
end

function frame:OnClassSelect()
	local class		= self.ConfigBox.Class:GetValue()
	local type		= self.ConfigBox.SubClass:GetValue()

	if (type and not strfind(cross[class] or "", type)) then
		self.ConfigBox.SubClass:SetValue()
	end
	
end

function frame:OnSubClassSelect()
	local x, y = self.app.common:Split(self.ConfigBox.SubClass:GetValue(), " ")
	local type = y or x

	if (strfind(type, "-=")) then
		local _,_,x = string.find(type, "-= (%w+) =-")
		self.ConfigBox.Class:SetValue(x)
		self.ConfigBox.SubClass:SetValue()
		return
	end

	for i,v in cross do
		if (strfind(v, type)) then
			self.ConfigBox.Class:SetValue(i)
			return
		end
	end

end

function frame:TogExtSearch()
	self.app:TogOpt(self.app.optPath, "ExtSearch")
end

function frame:OnShow()
	self.SearchBox.ExtSearch:SetValue(self.app:GetOpt(self.app.optPath, "ExtSearch"))
end

function frame:Reset()
	local quality	= self.ConfigBox.Quality:SetValue()
	local class		= self.ConfigBox.Class:SetValue()
	local level		= self.ConfigBox.MinLevel:SetValue()
	local type		= self.ConfigBox.SubClass:SetValue()
	local slot		= self.ConfigBox.Location:SetValue()
end