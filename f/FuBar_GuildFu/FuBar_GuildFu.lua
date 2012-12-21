local compost = AceLibrary("Compost-2.0")
local tablet = AceLibrary("Tablet-2.0")
local BC = AceLibrary("Babble-Class-2.0")
local T = AceLibrary("Tourist-2.0")
local R = AceLibrary("RosterLib-2.0")
local L = AceLibrary("AceLocale-2.0"):new("FuBar_GuildFu")

FuBar_GuildFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")
FuBar_GuildFu.hasIcon = true
FuBar_GuildFu.hasNoColor = true
FuBar_GuildFu.clickableTooltip = true
FuBar_GuildFu:RegisterDB("FuBar_GuildFuDB")
FuBar_GuildFu:RegisterDefaults("profile", {
	text = {
		show_displayed = true,
		show_online = true,
		show_total = true,
	},
	tooltip = {
		sort = "ZONE",
		group_show = true,
		name_color = "CLASS",
		name_status = true,
		class_show = false,
		level_show = true,
		level_color = "RELATIVE",
		zone_show = true,
		zone_color = "FACTION",
		note_showpublic = true,
		note_showofficer = true,
		note_showauldlangsyne = true,
		rank_show = true,
	},
	filter = {
		class_druid = true,
		class_hunter = true,
		class_mage = true,
		class_paladin = true,
		class_priest = true,
		class_rogue = true,
		class_shaman = true,
		class_warlock = true,
		class_warrior = true,
		level_0109 = true,
		level_1019 = true,
		level_2029 = true,
		level_3039 = true,
		level_4049 = true,
		level_5059 = true,
		level_60 = true,
		zone_bg = true,
		zone_inst = true,
		zone_open = true,
	}
})

function FuBar_GuildFu:OnInitialize()
	self.lastUpdate = 0
end

function FuBar_GuildFu:OnEnable()
	self:RegisterEvent("PLAYER_GUILD_UPDATE")

	R:Enable()
	self:RegisterEvent("RosterLib_RosterChanged", "UpdateTooltip")
	
	if IsInGuild() then
		self:ScheduleRepeatingEvent("ScheduledGuildRoster", GuildRoster, 15)
		self:RegisterEvent("GUILD_ROSTER_UPDATE")
		GuildRoster()
	end
end

function FuBar_GuildFu:GUILD_ROSTER_UPDATE()
	if not arg1 or (arg1 and arg7 and arg8) then
--		print("[GuildFu] GUILD_ROSTER_UPDATE fired with args...", arg1)
		self:Update()
	end
end

function FuBar_GuildFu:PLAYER_GUILD_UPDATE()
	if IsInGuild() then
		if not self:IsEventRegistered("GUILD_ROSTER_UPDATE") then
			self:ScheduleRepeatingEvent("ScheduledGuildRoster", GuildRoster, 15)
			self:RegisterEvent("GUILD_ROSTER_UPDATE")
		end
		GuildRoster()
	else
		if self:IsEventRegistered("GUILD_ROSTER_UPDATE") then
			self:CancelScheduledEvent("ScheduledGuildRoster")
			self:UnregisterEvent("GUILD_ROSTER_UPDATE")
		end
	end
end

function FuBar_GuildFu:OnDisable()
	R:Disable()
end

local function table_multiinsert(...)
	if arg.n < 2 or type(arg[1]) ~= "table" then
		return
	end
	for i = 2, arg.n, 1 do
		table.insert(arg[1], arg[i])
	end
end

FuBar_GuildFu.sorts ={
	NAME =	function(a,b)
				return a[1]<b[1]
			end,
	CLASS =	function(a,b)
				if a[5]<b[5] then
					return true
				elseif a[5]>b[5] then
					return false
				else
					if a[4]<b[4] then
						return true
					elseif a[4]>b[4] then
						return false
					else
						return FuBar_GuildFu.sorts.NAME(a, b)
					end
				end
			end,
	LEVEL =	function(a,b)
				if a[4]<b[4] then
					return true
				elseif a[4]>b[4] then
					return false
				else
					if a[5]<b[5] then
						return true
					elseif a[5]>b[5] then
						return false
					else
						return FuBar_GuildFu.sorts.NAME(a, b)
					end
				end
			end,
	ZONE =	function(a,b)
				if a[6]<b[6] then
					return true
				elseif a[6]>b[6] then
					return false
				else
					return FuBar_GuildFu.sorts.CLASS(a, b)
				end
			end,
	RANK = function(a,b)
				if a[3]<b[3] then
					return true
				elseif a[3]>b[3] then
					return false
				else
					return FuBar_GuildFu.sorts.CLASS(a, b)
				end
			end,
}

function FuBar_GuildFu:OnDataUpdate()
	if time() <= self.lastUpdate + 1 then return end
	self.lastUpdate = time()

	if self.players then
		self.players = compost.Reclaim(self.players, 1)
	end
	self.players = compost:Acquire()
	self.playersShown = 0
	self.playersOnline = 0
	self.playersTotal = 0

	if IsInGuild() then
		SetGuildRosterShowOffline(1)
		local numGuildMembers = GetNumGuildMembers()
		local name, rank, rankIndex, level, class, zone, note, officernote, online, status
		for i = 1, numGuildMembers, 1 do
			name, rank, rankIndex, level, class, zone, note, officernote, online, status = GetGuildRosterInfo(i)
			if note == "" then note = nil end
			if officernote == "" then officernote = nil end
			if not zone then zone = UNKNOWN end
			if online then
				self.playersOnline = self.playersOnline + 1
				if self:checkFilter(class, level, zone) then
					self.playersShown = self.playersShown + 1
					table.insert(self.players, compost:Acquire(name, rank, rankIndex, level, class, zone, status, note, officernote))
				end
			end
		end
		table.sort(self.players, self.sorts[self.db.profile.tooltip.sort])
		self.playersTotal = numGuildMembers
		SetGuildRosterShowOffline(SHOW_OFFLINE_GUILD_MEMBERS)
	end
end

function FuBar_GuildFu:OnTextUpdate()
	if not IsInGuild() then
		self:SetText(L"No Guild")
		return
	end
	if self.playersTotal == 0 then
		self:SetText(L"Updating...")
		return
	end

	local temptext = ""
	if self.db.profile.text.show_displayed then
		temptext = temptext..self.playersShown
	end
	if self.db.profile.text.show_online then
		if temptext ~= "" then
			temptext = temptext.."/"
		end
		temptext = temptext..self.playersOnline
	end
	if self.db.profile.text.show_total then
		if temptext ~= "" then
			temptext = temptext.."/"
		end
		temptext = temptext..self.playersTotal
	end
	if temptext ~= "" then
		self:SetText(temptext)
	else
		self:SetText("")
	end
end

function FuBar_GuildFu:OnTooltipUpdate()
	if not IsInGuild() then
		local cat = tablet:AddCategory(
			'columns', 1,
			'text', L"You aren't in a guild.",
			'hideBlankLine', true,
			'showWithoutChildren', true
		)
		return
	end

	if self.playersShown == 0 then
		local cat = tablet:AddCategory(
			'columns', 1,
			'text', L"All guild mates offline or filtered.",
			'hideBlankLine', true,
			'showWithoutChildren', true
		)
		return
	end

	local AuldLangSyne_loaded = IsAddOnLoaded("AuldLangSyne")
	
	local cols = compost:Acquire()
	table.insert(cols, L"Name")
	if self.db.profile.tooltip.class_show then
		table.insert(cols, L"Class")
	end
	if self.db.profile.tooltip.level_show then
		table.insert(cols, L"Level")
	end
	if self.db.profile.tooltip.zone_show then
		table.insert(cols, L"Zone")
	end
	if self.db.profile.tooltip.note_showpublic or (self.db.profile.tooltip.note_showofficer and CanViewOfficerNote()) or (AuldLangSyne_loaded and self.db.profile.tooltip.note_showauldlangsyne) then
		table.insert(cols, L"Notes")
	end
	if self.db.profile.tooltip.rank_show then
		table.insert(cols, L"Rank")
	end

	local cat = tablet:AddCategory(
		'columns', table.getn(cols)
	)
	local header = compost:Acquire()
	for i = 1, table.getn(cols) do
		if i == 1 then
--			table_multiinsert(header, 'text', cols[i], 'textR', 1, 'textG', 1, 'textB', 1, 'justify', "CENTER")
			table_multiinsert(header, 'text', cols[i], 'justify', "CENTER")
		else
--			table_multiinsert(header, 'text'..i, cols[i], 'text'..i..'R', 1, 'text'..i..'G', 1, 'text'..i..'B', 1, 'justify'..i, "CENTER")
			table_multiinsert(header, 'text'..i, cols[i], 'justify'..i, "CENTER")
		end
	end
	cat:AddLine(unpack(header))
	cols = compost:Reclaim(cols)
	header = compost:Reclaim(header)
	local line
	local colcount
	local temptext
	local classcolorR, classcolorG, classcolorG
	local levelcolor
	local zonecolorR, zonecolorG, zonecolorB
	for i = 1, table.getn(self.players) do
		classcolorR, classcolorG, classcolorB = BC:GetColor(self.players[i][5])
		levelcolor = GetDifficultyColor(self.players[i][4])
		line = compost:Acquire()
		if self.db.profile.tooltip.name_status and self.players[i][7] ~= "" then
			table_multiinsert(line, 'text', self.players[i][7].." "..self.players[i][1])
		else
			table_multiinsert(line, 'text', self.players[i][1])
		end
		if self.db.profile.tooltip.name_color == "CLASS" then
			table_multiinsert(line, 'textR', classcolorR, 'textG', classcolorG, 'textB', classcolorB)
		else
			table_multiinsert(line, 'textR', 1, 'textG', 1, 'textB', 0)
		end
		colcount = 1
		if self.db.profile.tooltip.class_show then
			colcount = colcount + 1
			table.insert(line, 'text'..colcount)
			table.insert(line, self.players[i][5])
			table_multiinsert(line, 'text'..colcount..'R', classcolorR, 'text'..colcount..'G', classcolorG, 'text'..colcount..'B', classcolorB)
		end
		if self.db.profile.tooltip.level_show then
			colcount = colcount + 1
			table.insert(line, 'text'..colcount)
			table.insert(line, self.players[i][4])
			table_multiinsert(line, 'text'..colcount..'R', levelcolor.r, 'text'..colcount..'G', levelcolor.g, 'text'..colcount..'B', levelcolor.b)
		end
		if self.db.profile.tooltip.zone_show then
			colcount = colcount + 1
			table.insert(line, 'text'..colcount)
			table.insert(line, self.players[i][6])
			if self.db.profile.tooltip.zone_color == "FACTION" then
				zonecolorR, zonecolorG, zonecolorB = T:GetFactionColor(self.players[i][6])
			elseif self.db.profile.tooltip.zone_color == "LEVEL" then
				zonecolorR, zonecolorG, zonecolorB = T:GetLevelColor(self.players[i][6])
			else
				zonecolorR, zonecolorG, zonecolorB = 1, 1, 0
			end
			table_multiinsert(line, 'text'..colcount..'R', zonecolorR, 'text'..colcount..'G', zonecolorG, 'text'..colcount..'B', zonecolorB)
		end
		if self.db.profile.tooltip.note_showpublic or (self.db.profile.tooltip.note_showofficer and CanViewOfficerNote()) or (AuldLangSyne_loaded and self.db.profile.tooltip.note_showauldlangsyne) then
			colcount = colcount + 1
			table.insert(line, 'text'..colcount)
			temptext = ""
			if self.db.profile.tooltip.note_showpublic then
				temptext = ((self.players[i][8] and (" ["..self.players[i][8].."] ")) or " - ")
			end
			if self.db.profile.tooltip.note_showofficer and CanViewOfficerNote() then
				temptext = temptext..((self.players[i][9] and (" ["..self.players[i][9].."] ")) or " - ")
			end
			if AuldLangSyne_loaded and self.db.profile.tooltip.note_showauldlangsyne then
				temptext = temptext ..((AuldLangSyne.db.realm.guild[self.players[i][1]] and (" {"..AuldLangSyne.db.realm.guild[self.players[i][1]].."} ")) or "")
			end
			table.insert(line, temptext)
			table_multiinsert(line, 'text'..colcount..'R', 1, 'text'..colcount..'G', 1, 'text'..colcount..'B', 0)
		end
		if self.db.profile.tooltip.rank_show then
			colcount = colcount + 1
			table.insert(line, 'text'..colcount)
			table.insert(line, self.players[i][2])
			table_multiinsert(line, 'text'..colcount..'R', 1, 'text'..colcount..'G', 1, 'text'..colcount..'B', 0)
		end
		table_multiinsert(line, 'func', 'OnNameClick', 'arg1', self, 'arg2', self.players[i][1])
		if self.db.profile.tooltip.group_show then
			table_multiinsert(line, 'hasCheck', true, 'checked', R:GetUnitIDFromName(self.players[i][1]) and true)
-- 'checkIcon', self.factions[i].isCollapsed and "Interface\\Buttons\\UI-PlusButton-Up" or "Interface\\Buttons\\UI-MinusButton-Up",
		end

		cat:AddLine(unpack(line))
		line = compost:Reclaim(line)
	end
end

function FuBar_GuildFu:OnClick()
	ToggleFriendsFrame(3) 
end

function FuBar_GuildFu:OnNameClick(name)
	if not name then return end
	if IsAltKeyDown() then
		InviteByName(name)
	else
		SetItemRef("player:"..name, "|Hplayer:"..name.."|h["..name.."|h", "LeftButton")
	end
end

function FuBar_GuildFu:checkFilter(class, level, zone)
	if not self.db.profile.filter.class_druid and class == BC"Druid" then return false end
	if not self.db.profile.filter.class_hunter and class == BC"Hunter" then return false end
	if not self.db.profile.filter.class_mage and class == BC"Mage" then return false end
	if not self.db.profile.filter.class_paladin and class == BC"Paladin" then return false end
	if not self.db.profile.filter.class_priest and class == BC"Priest" then return false end
	if not self.db.profile.filter.class_rogue and class == BC"Rogue" then return false end
	if not self.db.profile.filter.class_shaman and class == BC"Shaman" then return false end
	if not self.db.profile.filter.class_warlock and class == BC"Warlock" then return false end
	if not self.db.profile.filter.class_warrior and class == BC"Warrior" then return false end
	
	if not self.db.profile.filter.level_0109 and level < 10 then return false end
	if not self.db.profile.filter.level_1019 and level >= 10 and level < 20 then return false end
	if not self.db.profile.filter.level_2029 and level >= 20 and level < 30 then return false end
	if not self.db.profile.filter.level_3039 and level >= 30 and level < 40 then return false end
	if not self.db.profile.filter.level_4049 and level >= 40 and level < 50 then return false end
	if not self.db.profile.filter.level_5059 and level >= 50 and level < 60 then return false end
	if not self.db.profile.filter.level_60 and level == 60 then return false end
	
	if not self.db.profile.filter.zone_bg and T:IsBattleground(zone) then return false end
	if not self.db.profile.filter.zone_inst and T:IsInstance(zone) and not T:IsBattleground(zone) then return false end
	if not self.db.profile.filter.zone_open and T:IsZone(zone) then return false end
	
	return true
end
