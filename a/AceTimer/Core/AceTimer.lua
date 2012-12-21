--<< ====================================================================== >>--
-- Constants                                                                  --
--<< ====================================================================== >>--
ACETIMER.COLOR = {
	AQUA    = {0.0,1.0,1.0},
	BLUE    = {0.0,0.0,1.0},
	FUCHSIA = {1.0,0.0,1.0},
	GRAY    = {0.5,0.5,0.5},
	GREEN   = {0.0,0.5,0.0},
	LIME    = {0.0,1.0,0.0},
	MAROON  = {0.5,0.0,0.0},
	NAVY    = {0.0,0.0,0.5},
	OLIVE   = {0.5,0.5,0.0},
	PURPLE  = {0.5,0.0,0.5},
	RED     = {1.0,0.0,0.0},
	TEAL    = {0.0,0.5,0.5},
	WHITE   = {1.0,1.0,1.0},
	YELLOW  = {1.0,1.0,0.0},
}

ACETIMER.COLOR_MAP = {
	[0]="OLIVE",[1]="TEAL",[2]="PURPLE",[3]="GREEN",
}

ACETIMER.COMMANDS = { 
	ACETIMER.CMD_SHORT, 
	ACETIMER.CMD_LONG, 
}

ACETIMER.CMD_OPTIONS = {
	{ option = ACETIMER.OPT_ANCHOR, method = "CareOptAnchor", desc = ACETIMER.OPT_ANCHOR_DESC,},
	{ option = ACETIMER.OPT_SCALE,  method = "CareOptScale",  desc = ACETIMER.OPT_SCALE_DESC,},
	{ option = ACETIMER.OPT_GROW,   method = "CareOptGrow",   desc = ACETIMER.OPT_GROW_DESC,},
}

ACETIMER.SPELL = 1
ACETIMER.EVENT = 2
ACETIMER.SKILL = 3

--<< ====================================================================== >>--
-- Class Setup                                                                --
--<< ====================================================================== >>--
AceTimer = AceAddon:new({
    name          = ACETIMER.NAME,
    description   = ACETIMER.DESCRIPTION, -- Optional; Ace will use the .toc Notes text
    version       = "R4",
    releaseDate   = "",
    aceCompatible = "102", -- Check ACE_COMP_VERSION in Ace.lua for current.
    author        = "Rasmus Kromann-Larsen",
    email         = "rasmus@kromann-larsen.dk",
    website       = "http://www.rasmuskl.dk",
    category      = "combat",
    --optionsFrame  = "AceTimerOptionsFrame",
    db            = AceDatabase:new("AceTimerDB"),
    --defaults      = DEFAULT_OPTIONS,
    cmd           = AceChatCmd:new(ACETIMER.COMMANDS, ACETIMER.CMD_OPTIONS),
	modules       = {},
})

function AceTimer:Initialize()
    -- Helpful closures for accessing the addon's currently loaded profile.
    self.GetOpt = function(var) return self.db:get(self.profilePath,var)    end
    self.SetOpt = function(var,val) self.db:set(self.profilePath,var,val)   end
    self.TogOpt = function(var) return self.db:toggle(self.profilePath,var) end

    self:InitModules()
end

function AceTimer:Enable()
	self.groups = {}
	self.timers = {}
	self.bars = {}
	for i = 1, 20 do self.bars[i] = {} end
	self.gs_patterns = {}
	self.gs_captured = {}
	self:InitAnchor()
	
	self:EnableModules()
end

function AceTimer:Disable()
	self:DisableModules()
	if self.gs_patterns then self.gs_patterns = nil end
	if self.gs_captured then self.gs_captured = nil end
	if self.bars then self:KillBars(); self.bars = nil end
	if self.timers then self.timers = nil end
	if self.groups then self.groups = nil end

	self:UnregisterAllEvents(self)
	self:UnhookAllScripts()
end

--<< ====================================================================== >>--
-- Timer Processing                                                           --
--<< ====================================================================== >>--
function AceTimer:AddGroup(id, forall, color)
	if color then 
		self.groups[id] = { fa=forall, cr=ACETIMER.COLOR[color] }
	else
		self.groups[id] = { fa=forall }
	end
end

function AceTimer:AddTimer(kind, name, duration, targeted, isgain, selforselect, extra)
	if not self.timers[kind]       then self.timers[kind] = {}       end
	if not self.timers[kind][name] then self.timers[kind][name] = {} end
	if not extra then extra = {} end
	targeted = (targeted > 0 ) and 1 or nil
	isgain = (isgain > 0 ) and 1 or nil
	selforselect = (selforselect > 0 ) and 1 or nil
	if extra.cr then extra.cr = ACETIMER.COLOR[extra.cr] 
	elseif extra.gr and self.groups[extra.gr].cr then extra.cr = self.groups[extra.gr].cr
	else
		local ccode = (targeted and 2 or 0) + (isgain and 1 or 0)
		extra.cr = ACETIMER.COLOR[ACETIMER.COLOR_MAP[ccode]]
	end
	self.timers[kind][name] = { d=duration, k={t=targeted,g=isgain,s=selforselect}, x=extra }
end

function AceTimer:StartTimer(timer, name, target, rank)
	if not target then target = "none" end
	if not rank then rank = timer.r or 0 end
	if timer.x.gr then self:CleanGroup(timer.x.gr, target) end
	if timer.x.ea then
		for name, valid in timer.x.ea do 
			local event = self.timers[ACETIMER.EVENT][name]
			event.r = rank
			event.v = GetTime() + valid
			if target ~= "none" then event.t = target end
		end
	end
	if timer.d == 0 then return end

	local id, slot = name.."-"..target 
	for i = 1, 20 do 
		if self.bars[i].id == id then 
			TimexBar:StopBar(self.bars[i].id)
			self:StopBar(self.bars[i].id)
			break 
		end
	end
	for i = 1, 20 do if not self.bars[i].id then slot = i; break end end
	if not slot or not TimexBar:Get(id) then return end

	self.bars[slot].id     = id
	self.bars[slot].timer  = timer
	self.bars[slot].name   = name
	self.bars[slot].rank   = rank
	self.bars[slot].target = target
	self.bars[slot].group  = timer.x.gr
	self:SetPoint(id, slot)
	TimexBar:SetColor(id, unpack(timer.x.cr or ACETIMER.COLOR.GRAY))
	TimexBar:SetScale(id, self.GetOpt("Scale"))
	TimexBar:SetText(id, target == "none" and name or target)
	TimexBar:SetTexture(id, timer.x.tx or self:GetTexture(name, timer.x))
	TimexBar:SetFunction(id, self.StopBar, self, id)
	TimexBar:SetClickFunction(id, self.OnClick, self, id, timer.x.rc)
	TimexBar:Start(id, timer.x.d and self:GetDuration(timer.d, timer.x.d, rank) or timer.d)
end

function AceTimer:GetDuration(duration, record, rank)
	if record.rt then duration = record.rt[rank] or duration end
	if record.rs then duration = duration + (rank-1) * record.rs end
	if record.cp then duration = duration + (GetComboPoints() - 1) * record.cp end
	if record.tn then
		if type(record.tn) == "string" then record.tn = self:GetTalentPosition(record.tn) end
		local _,_,_,_, tr = GetTalentInfo(unpack(record.tn))
		if tr > 0 then
			local gain = record.tt and record.tt[tr] or (record.tb + (tr-1) * (record.ts or record.tb))
			duration = duration + (record.tp and (duration/100) * gain or gain)
		end
	end
	return duration
end

function AceTimer:GetTexture(name, record)
	if record.xn then name = record.xn end
	local i = 1
	while true do
		local nm = GetSpellName(i, BOOKTYPE_SPELL)
		if not nm then break
		elseif nm == name then
			record.tx = GetSpellTexture(i, BOOKTYPE_SPELL)
			return record.tx
		end
		i = i + 1
	end
	local tp = self:GetTalentPosition(name)
	if tp then 
		local _, tx = GetTalentInfo(unpack(tp))
		record.tx = tx
		return record.tx
	end
	if HasPetSpells() then
		for i =1, NUM_PET_ACTION_SLOTS do
			local nm, _, tx = GetPetActionInfo(i)
			if nm == name then record.tx = tx; return record.tx end
		end
	end
end

function AceTimer:GetTalentPosition(name)
	for i = 1, GetNumTalentTabs() do
		for j = 1, GetNumTalents(i) do
			if GetTalentInfo(i, j) == name then return {i, j} end
		end
	end
end

--<< ====================================================================== >>--
-- Bar Processing                                                             --
--<< ====================================================================== >>--
function AceTimer:CleanGroup(group, target)
	local forall = self.groups[group].fa
	for i = 1, 20 do
		if self.bars[i].group and self.bars[i].group == group then
			if forall then 
				TimexBar:StopBar(self.bars[i].id)
				self:StopBar(self.bars[i].id)
			elseif self.bars[i].target == target then 
				TimexBar:StopBar(self.bars[i].id)
				self:StopBar(self.bars[i].id)
				break
			end
		end
	end
end

function AceTimer:SetPointTOP(id, slot)
	return TimexBar:SetPoint(id, "TOP", "AceTimerAnchor", "TOP", 0, (slot * 20))
end

function AceTimer:SetPointBOTTOM(id, slot)
	return TimexBar:SetPoint(id, "BOTTOM", "AceTimerAnchor", "BOTTOM", 0, (-5 - (slot * 20)))
end

function AceTimer:KillBar(name, unit)
	for i = 1, 20 do
		if self.bars[i].id then
			if self.bars[i].name == name then
				if not unit then 
					if self.bars[i].timer.k.t then unit = UnitName("player") else unit = "none" end
				end
				if self.bars[i].target == unit then
					TimexBar:StopBar(self.bars[i].id)
					return self:StopBar(self.bars[i].id)
				end
			end
		else 
			break
		end
	end
end

function AceTimer:KillBars(unit)
	if unit and UnitExists("target") and UnitName("target") == unit and not UnitIsDeadOrGhost("target") then return end
	for i = 1, 20 do
		if self.bars[i].id then
			if not unit or self.bars[i].target == unit then
				TimexBar:StopBar(self.bars[i].id)
				self:StopBar(self.bars[i].id)
			end
		else
			break
		end
	end
end

function AceTimer:StopBar(id)
	for i = 1, 20 do 
		if self.bars[i].id == id then 
			for k in self.bars[i] do self.bars[i][k] = nil end
		end
	end
	for i = 1, 19 do
		if not self.bars[i].id then
			local temp = self.bars[i]
			for j = i + 1, 20 do
				if self.bars[j].id then
					self.bars[i] = self.bars[j]; self.bars[j] = temp; temp = nil
					self:SetPoint(self.bars[i].id, i)
					break
				end
			end
			if temp then break end
		end
	end
end

function AceTimer:OnClick(id, reactive)
	if arg1 == "RightButton" then
		TimexBar:StopBar(id) 
		self:StopBar(id)
	elseif arg1 == "LeftButton" and reactive then
		for i = 1, 20 do 
			if self.bars[i].id == id then
				if self.bars[i].rank > 0 then
					return CastSpellByName(string.format(ACETIMER.FMT_CAST, self.bars[i].name, self.bars[i].rank))
				else
					return CastSpellByName(self.bars[i].name)
				end
			end
		end
	end
end

--<< ====================================================================== >>--
-- Globalstrings Processing                                                   --
--<< ====================================================================== >>--
-- self.gs_patterns
-- self.gs_captured
function AceTimer:FindGlobal(text, global)
	local gp = self.gs_patterns[global]
	if not gp then 
		self.gs_patterns[global] = {n=0,}
		gp = self.gs_patterns[global]
		gp.p = string.gsub(global, "([%[%]%(%)])", "%%%1")
		gp.p = string.gsub(gp.p, "%.$", "%%%.")
		gp.p = string.gsub(gp.p, "%%(%S-)([sd])", function (a1, a2) 
			gp.n = gp.n + 1
			local _,_, found = string.find(a1, "(%d)%$")
			if found then gp[gp.n] = tonumber(found) else gp[gp.n] = gp.n end
			if a2 == "s" then return "(.+)" 
			elseif a2 == "d" then return "(%d+)" 
			end
		end)
	end
	for k in self.gs_captured do self.gs_captured[k] = nil end
	return self:OrderCaptured(gp, string.find(text, gp.p))
end

function AceTimer:OrderCaptured(gp, s, e, ...)
	if s then 
		for i = 1, gp.n do self.gs_captured[gp[i]] = arg[i] end
		return TRUE
	end
end

--<< ====================================================================== >>--
-- Anchor Processing                                                          --
--<< ====================================================================== >>--
function AceTimer:InitAnchor()
	local test = {d=10, x={cr=ACETIMER.COLOR.GRAY, tx="Interface\\Icons\\INV_Misc_QuestionMark"} }
	AceTimerAnchorText:SetText(ACETIMER.NAME) 
	AceTimerAnchorTest:SetText(ACETIMER.WORD_TEST)
	AceTimerAnchorTest:SetScript("OnClick", function () return self:StartTimer(test, ACETIMER.WORD_TEST, "none", 0) end)
	AceTimerAnchorHide:SetText(ACETIMER.WORD_HIDE)
	AceTimerAnchorHide:SetScript("OnClick", function () return self:CareOptAnchor() end)
	if not self.GetOpt("Scale") then self.SetOpt("Scale", 0.80) end
	AceTimerAnchorScaleLow:SetText("0.5")
	AceTimerAnchorScaleHigh:SetText("1.5")
	AceTimerAnchorScale:SetScript("OnValueChanged", function() return self:OnScaleChanged() end)
	AceTimerAnchorScale:SetValue(self.GetOpt("Scale"))
	self:SetBarGrowth()
	if not self.GetOpt("AnchorHidden") then AceTimerAnchor:Show() end
end

function AceTimer:OnScaleChanged()
	local scale = AceTimerAnchorScale:GetValue()
	AceTimerAnchorScaleText:SetText(string.format("%.2f", scale))
	self.SetOpt("Scale", scale)
	for i = 1, 20 do
		if self.bars[i].id and TimexBar:CheckBar(self.bars[i].id) then 
			TimexBar:SetScale(self.bars[i].id, scale) 
		end
	end
end

function AceTimer:OnTestClicked()
	self:StartBar(ACETIMER.WORD_TEST.." 1", "none", 0, nil, 15, nil, ACETIMER.COLOR.RED)
	self:StartBar(ACETIMER.WORD_TEST.." 2", "none", 0, nil, 10, nil, ACETIMER.COLOR.GREEN)
	self:StartBar(ACETIMER.WORD_TEST.." 3", "none", 0, nil,  5, nil, ACETIMER.COLOR.BLUE)
end

function AceTimer:SetBarGrowth()
	if self.GetOpt("GrowUp") then 
		self.SetPoint = self.SetPointTOP
	else
		self.SetPoint = self.SetPointBOTTOM
	end
end

--<< ====================================================================== >>--
-- Command Handlers                                                           --
--<< ====================================================================== >>--
function AceTimer:CareOptAnchor()
	if self.TogOpt("AnchorHidden") then 
		AceTimerAnchor:Hide() else AceTimerAnchor:Show() 
	end
end

function AceTimer:CareOptScale(scale)
	scale = tonumber(scale)
	if not scale then scale = 0.80 else 
		if scale < 0.50 then scale = 0.50 elseif scale > 1.50 then scale = 1.50 end
	end
	AceTimerAnchorScale:SetValue(tonumber(string.format("%.2f", scale)))
	self.cmd:result(ACETIMER.OPT_SCALE_TEXT, "|cfff5f530" .. string.format("%.2f", self.GetOpt("Scale")) .. "|r")
end

function AceTimer:CareOptGrow()
	self.cmd:result(ACETIMER.OPT_GROW_TEXT, ACETIMER.MAP_DOWNUP[self.TogOpt("GrowUp") or 0])
	self:SetBarGrowth()
end

function AceTimer:Report()
	self.cmd:report({})
	self.cmd:result(ACETIMER.OPT_SCALE_TEXT, "|cfff5f530" .. string.format("%.2f", self.GetOpt("Scale")) .. "|r")
	self.cmd:result(ACETIMER.OPT_GROW_TEXT, ACETIMER.MAP_DOWNUP[self.GetOpt("GrowUp") or 0])
	self:ReportModules()
end

--<< ====================================================================== >>--
-- Register the Addon                                                         --
--<< ====================================================================== >>--
AceTimer:RegisterForLoad()
