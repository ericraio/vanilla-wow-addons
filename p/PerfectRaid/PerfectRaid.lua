--[[---------------------------------------------------------------------------------
  Class declaration
------------------------------------------------------------------------------------]]

local elapsed = 0
local visible,frames,dirty,aura,dirtyStatus = {},{},{},{},{}
local marked,selected,sort,keys,registry= {},{},{},{},{}
local feign,soulstone,inrange,innervate,poweri = {},{},{},{},{}
local anyDirty,dirtyRoster
local force = 0

local debug = false

PerfectRaid = {
	name			= 'PerfectRaid',
	description		= "PerfectRaid is a very minimal set of configurable raid frames.",
	version			= '1.0',
	releaseDate		= '2006-02-12',
	author			= 'Cladhaire',
	email			= 'cladhaire@gmail.com',
	website			= 'http://cladhaire.wowinterface.com',

	Initialize = function(self) 
		self:Debug("Initializing PefectRaid.")
		self.poolsize = 0
		self.frames = frames
		self.visible = visible
		self.tooltip = PerfectRaidTooltip
		self.master = CreateFrame("Frame", "PerfectRaidFrame", UIParent)
		self.master:SetScript("OnEvent", self.EventHandler)
		self.master:SetScript("OnUpdate", self.OnUpdate)
		self.master:SetMovable(true)
		
		self:RegisterEvent("PLAYER_ENTERING_WORLD")
		self:RegisterEvent("RAID_ROSTER_UPDATE")
		self:RegisterEvent("ADDON_LOADED")
		
		self.defaults = { 	Align			= "left",
							Select			= "none",
							Sort			= "groupname",
							BackdropBar		= "bar 0 0 0 1",
							BackdropFrame	= "frame 0 0 0 0",
							Truncate		= true,
							LowMana			= 25,
							Scale			= 1,
							Voffset			= -5,
							Filter			= false,
							RangeCheck		= false,
						}
	end,
	
	Enable = function (self)	
		self.enabled = true
		self:RegisterEvent("UNIT_HEALTH")
		self:RegisterEvent("UNIT_AURA")
		self:RegisterEvent("PLAYER_TARGET_CHANGED")
		self:RegisterEvent("CHAT_MSG_SYSTEM")
		
		self:RangeHooks()
		
		if not self.virtualfont then
			self.virtualfont = self.master:CreateFontString(nil, "ARTWORK")
			self.virtualfont:SetFontObject(GameFontHighlightSmall)
		end

		-- Enable the OnUpdates
		self.master:Show()
		
		-- If we find WatchDog, enable click-casting
		if WatchDog_OnClick then
			PerfectRaidCustomClick = WatchDog_OnClick
		end
	end,

	Disable = function(self)
		self:UnhookAll()
		self.enabled = nil
		self.master:Hide()
	end,
	
	RangeHooks = function(self)
		if self.opt.RangeCheck and not self:IsHooked("CastSpell") then
			self:Hook("CastSpell")
			self:Hook("CastSpellByName")
			self:Hook("UseAction")
		else
			self:UnhookAll()
		end
	end,
	
	CheckVariables = function(self)
		PerfectRaidOpt = PerfectRaidOpt or {}
		self.opt = PerfectRaidOpt
		setmetatable(self.opt, {__index=self.defaults, __call=function(v) return self.opt[v] end})
		
		if not self.opt.PosX then
			self.master:ClearAllPoints()
			self.master:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
			self.master:SetWidth(100)
			self.master:SetHeight(100)
		else
			self.master:ClearAllPoints()
			self.master:SetPoint("TOPLEFT", UIParent, "TOPLEFT", self.opt.PosX, self.opt.PosY)
			self.master:SetWidth(100)
			self.master:SetHeight(100)
		end
	end,
	
	SetOpt = function(self, var, val)
		if self.defaults[var] == val then
			self.opt[var] = nil
		else
			self.opt[var] = val
		end
	end,
	
--[[---------------------------------------------------------------------------------
  Event handlers
------------------------------------------------------------------------------------]]

	ADDON_LOADED = function(self)
		self:Debug("ADDON_LOADED")	
		AceHookLib:Embed(PerfectRaid, "1.4")
		
		if string.lower(arg1) == "perfectraid" then
			self:UnregisterEvent("ADDON_LOADED")
			self:CheckVariables()
			self:RestorePosition()

			if not self.cmd then
				self:Debug("Registering chat commands.")
				self.cmd = self.AceChatCmd:new(PERFECTRAID.CHAT_COMMANDS, PERFECTRAID.CHAT_OPTIONS)
				self.cmd.app = self
				self.cmd:Register(self)
			end
		end
	end,

	PLAYER_ENTERING_WORLD = function(self)
		self:Debug("PLAYER_ENTERING_WORLD")	
		self:RAID_ROSTER_UPDATE()
	end,

	RAID_ROSTER_UPDATE = function(self)
		self:Debug("RAID_ROSTER_UPDATE")
		if GetNumRaidMembers() > 0 then
			if not self.enabled then
				self:Debug("You've joined a raid-- enabling PerfectRaid.")
			end
			self:Enable()
			dirtyRoster = true
		elseif self.enabled then
			self:Disable()
		end
	end, 
	
	UNIT_HEALTH = function(self)
		--self:Debug("UNIT_HEALTH for %s.",arg1)
		if visible[arg1] then
			anyDirty = true
			dirty[arg1] = true
		end
	end,
	
	UNIT_AURA = function(self)
		--self:Debug("UNIT_AURA for %s.",arg1)
		if visible[arg1] then
			anyDirty = true
			dirtyStatus[arg1] = true
		end
	end,

	PLAYER_TARGET_CHANGED = function(self)
		self:Debug("PLAYER_TARGET_CHANGED")
				
		for k,v in pairs(visible) do
			if UnitIsUnit(k, "target") then
				local f = frames[k]
				marked[k] = true
				f.Prefix:SetText(self.mark)
				f.Prefix:SetTextColor(1,1,0)
--[[
			elseif UnitIsUnit(k, "targettarget") then
				marked[k] = true
				f.Prefix:SetText(self.ttmark)
				f.Prefix:SetTextColor(1,1,0)
--]]
			elseif marked[k] then 
				local f = frames[k]
				marked[k] = nil
				if selected[k] then
					f.Prefix:SetTextColor(1,1,1)
					if self.opt.Select == "number" then 
						f.Prefix:SetText(f.group)
					else
						f.Prefix:SetText(">")
					end
				else
					f.Prefix:SetText()
				end
			end
		end
	end,
	
	CHAT_MSG_SYSTEM = function(self)
		if string.find(arg1, ERR_RAID_YOU_LEFT) then
			self:Disable()
		end
	end,
	
	CastSpell = function(self,a1,a2,a3) 
		rangecheck = true
		self.Hooks.CastSpell.orig(a1,a2,a3)
		
		if SpellIsTargeting() then
			for k,v in visible do
				if SpellCanTargetUnit(k) then
					frames[k]:SetAlpha(1.0)
				else
					frames[k]:SetAlpha(0.5)
				end
			end
		end
	end,
	
	CastSpellByName = function(self,a1,a2,a3) 
		rangecheck = true
		self.Hooks.CastSpellByName.orig(a1,a2,a3)
		
		if SpellIsTargeting() then
			for k,v in visible do
				if SpellCanTargetUnit(k) then
					frames[k]:SetAlpha(1.0)
				else
					frames[k]:SetAlpha(0.5)
				end
			end
		end
	end,
	
	UseAction = function(self,a1,a2,a3) 
		rangecheck = true
		self.Hooks.UseAction.orig(a1,a2,a3)
		
		if SpellIsTargeting() then
			for k,v in visible do
				if SpellCanTargetUnit(k) then
					frames[k]:SetAlpha(1.0)
				else
					frames[k]:SetAlpha(0.5)
				end
			end
		end
	end,
	
--[[---------------------------------------------------------------------------------
  Main Addon
------------------------------------------------------------------------------------]]	

	OnUpdate = function()
		elapsed = elapsed + arg1
		force = force + arg1
				
		if elapsed > 0.20 and (anyDirty or dirtyRoster) then
			local self = PerfectRaid
			elapsed = 0
			anyDirty = nil
			
			if dirtyRoster then
				self:UpdateVisibility()		
				for k,v in pairs(visible) do
					self:UpdateUnit(k)
					self:UpdateStatus(k)
				end
				dirtyRoster = nil
			end
			
			for k,v in pairs(dirty) do
				dirty[k] = nil
				self:UpdateUnit(k)
			end

			for k,v in pairs(dirtyStatus) do
				dirtyStatus[k] = nil
				self:UpdateStatus(k)
			end
		elseif force > 1.0 then
			force = 0
			elapsed = 0
			anyDirty = nil
			
			for k,v in pairs(visible) do
				dirty[k] = nil
				PerfectRaid:UpdateUnit(k)
			end
		end
	end,
	
	UpdateUnit = function(self, unit)
		if not UnitExists(unit) then return end
		
		local f = frames[unit]
		
		if UnitClass(unit) then 	
			local _,class = UnitClass(unit)
			f.Name:SetText(PERFECTRAID.CLASSES[class]..UnitName(unit).."|r")
		else
			f.Name:SetText(UnitName(unit) or "Unknown")
		end

		local hp = UnitIsConnected(unit) and UnitHealth(unit) or 0
		local hpmax = UnitHealthMax(unit)
		local hpp = (hpmax ~= 0) and floor((hp / hpmax) * 100) or 0

		if UnitPowerType(unit) == 0 then
			
			local mana = UnitMana(unit) or 0
			local max = UnitManaMax(unit) or 1
			local mpp = floor((mana / max) * 100)
			
			if max > 0 and mpp <= self.opt.LowMana and not f.lowmana then 
				dirtyStatus[unit] = true
				f.lowmana = true
				self:UpdateStatus(unit)
			elseif f.lowmana and max > 0 and mpp > self.opt.LowMana then
				f.lowmana = nil
				self:UpdateStatus(unit)
			end
		end

		if not feign[unit] then
			f.Bar:SetValue(hpp)
			f.Bar:SetStatusBarColor(self:GetHPSeverity(hp/hpmax,1))
		else
			f.Bar:SetValue(100)
			f.Bar:SetStatusBarColor(0, 0.9, 0.78)
		end
		
	end,
	
	UpdateVisibility = function(self)
		local num = GetNumRaidMembers()
		if num == 0 then return end
		
		if num >= self.poolsize then self:CreateFrame(num) end
		
		frames[1]:Show()
		visible["raid1"] = true
		
		for i=2,num do
			frames[i]:Show()
			local id = "raid"..i
			visible[id] = true			
		end
		
		for i=(num+1),self.poolsize do
			visible["raid"..i] = nil
			if not frames[i] then break end
			frames[i]:Hide()
		end
		
		for k,v in visible do
			if not UnitName(k) then
				dirtyRoster = true
				return
			end
		end
		
		self:Sort(nil, true)
		self:Align(nil, true)
		self:Select(nil, true)
		self:SetBackdrop(nil, true)
		self:SetScale(nil, true)
	end,

	UpdateStatus = function(self, unit)
	
		soulstone[unit] = nil
		feign[unit] = nil
		innervate[unit] = nil
		poweri[unit] = nil
		
		if UnitIsDead(unit) then 
			for i=1,32 do
				local texture = UnitBuff(unit, i)
				if texture == "Interface\\Icons\\Ability_Rogue_FeignDeath" then
					feign[unit] = true
					break
				end
			end
			if not feign[unit] then 
				self.frames[unit].Status:SetText("|cffff0000Dead|r")
				return
			end
		end

		if UnitIsGhost(unit) then
			self.frames[unit].Status:SetText("|cff9d9d9dGhost|r")
			return
		elseif not UnitIsConnected(unit) then
			self.frames[unit].Status:SetText("|cffff8000Offline|r")
			return
		else
			-- Clear Feign Death when it comes off
			if feign[unit] and not UnitIsDead(unit) then feign[unit] = nil end
			
			for k,v in pairs(aura) do aura[k] = nil end
	
			if UnitPowerType(unit) == 0 and not feign[unit] then
				
				local mana = UnitMana(unit) or 0
				local max = UnitManaMax(unit) or 1
				local mpp = floor((mana / max) * 100)
				
				if max > 0 and mpp <= self.opt.LowMana then 
					aura.LowMana = true
				end
			end

			-- No easy way out, so we need to scan the debuffs
				for i=1,16 do
				if UnitDebuff(unit, i) then
					PerfectRaidTooltipTextRight1:SetText("")
					PerfectRaidTooltip:SetUnitDebuff(unit, i, self.opt.Filter)
					local type = PerfectRaidTooltipTextRight1:GetText()
					if PERFECTRAID.COLORS[type] then 
						aura[type] = true
					end
				end
				for i=1,32 do
					local texture = UnitBuff(unit, i)
					if not texture then break end
					if texture == "Interface\\Icons\\Spell_Shadow_SoulGem" then
						soulstone[unit] = true
					elseif texture == "Interface\\Icons\\Spell_Nature_Lightning" then
						innervate[unit] = true
					elseif texture == "Interface\\Icons\\Spell_Holy_PowerInfusion" then
						poweri[unit] = true
					end
				end
			end
			
			local output = string.format("%s%s%s%s%s%s%s%s%s",
										(soulstone[unit] and PERFECTRAID.COLORS.Soulstone) or "",
										(innervate[unit] and PERFECTRAID.COLORS.Innervate) or "",
										(poweri[unit] and PERFECTRAID.COLORS.PowerInfusion) or "",
										(feign[unit] and PERFECTRAID.COLORS.FeignDeath) or "",
										(aura[PERFECTRAID.CURSE] and PERFECTRAID.COLORS.Curse) or "",
										(aura[PERFECTRAID.DISEASE] and PERFECTRAID.COLORS.Disease) or "",
										(aura[PERFECTRAID.MAGIC] and PERFECTRAID.COLORS.Magic) or "",
										(aura[PERFECTRAID.POISON] and PERFECTRAID.COLORS.Poison) or "",
										(aura.LowMana and PERFECTRAID.COLORS.LowMana) or "")
			self.frames[unit].Status:SetText(output)
		end
	end,
	
	OnClick = function(self)
		local unit = this.unit
		if UnitIsUnit(unit, "player") then unit = "player" end
		
		local button = arg1

		-- To enable click-casting on this frame, all anyone has to do is
		-- set PerfectRaidCustomClick
		
		if PerfectRaidCustomClick then
			PerfectRaidCustomClick(arg1, unit) 
		else
			if not UnitExists(unit) then return end
	
			if SpellIsTargeting() then
				if button == "LeftButton" then SpellTargetUnit(unit)
				elseif button == "RightButton" then	SpellStopTargeting() end
				return
			end
		
			if CursorHasItem() then
				if button == "LeftButton" then
					if unit=="player" then AutoEquipCursorItem()
					else DropItemOnUnit(unit) end
				else PutItemInBackpack() end
				return
			end
			
			TargetUnit(unit)
		end
	end,

--[[---------------------------------------------------------------------------------
  Options handlers
------------------------------------------------------------------------------------]]

	-- Type is optional and defaults to the current sort type
	Sort = function(self, msg, force)
		if GetNumRaidMembers() == 0 then return end

		-- Clear the sort table
		for k,v in pairs(sort) do sort[k] = nil table.setn(sort, 0) end
		
		-- Insert all the active raid ids in the table
		for k in visible do 
			table.insert(sort, k)
			if not UnitName(k) then return end
		end		
		
		msg = msg or self.opt.Sort
		msg = string.lower(msg)
		
		-- Sort the table based on criteria
		if msg == "class" then 
			if not force then self:Msg("Sorting by Class.") end
			table.sort(sort, function(a,b)
								keys[a] = UnitClass(a)
								keys[b] = UnitClass(b)
								if UnitClass(a) == UnitClass(b) then 
									return UnitName(a) < UnitName(b) 
								else
									return UnitClass(a) < UnitClass(b) 
								end end)

		elseif msg == "raid" then
			if not force then self:Msg("Sorting by Raid.") end
			-- We don't need to sort if we're sorting raid, since we're in order
		
		elseif msg == "name" then 
			if not force then self:Msg("Sorting by Name.") end
			table.sort(sort, function(a,b) return UnitName(a) < UnitName(b) end)
		
		elseif msg == "group" then
			if not force then self:Msg("Sorting by Group.") end
			local sortGroup = function(a,b) 
				local _,_,groupA = GetRaidRosterInfo(self.frames[a].id) 
				local _,_,groupB = GetRaidRosterInfo(self.frames[b].id) 
				keys[a] = groupA
				keys[b] = groupB
				return groupA < groupB 
			end
			table.sort(sort, sortGroup)
		
		elseif msg == "groupclass" then 
			if not force then self:Msg("Sorting by Group/Class.") end
			local sortGroupName = function(a,b) 
				local _,_,groupA = GetRaidRosterInfo(self.frames[a].id) 
				local _,_,groupB = GetRaidRosterInfo(self.frames[b].id) 
				keys[a] = groupA
				keys[b] = groupB
				if groupA == groupB then 
					return UnitClass(a) < UnitClass(b)
				else
					return groupA < groupB 
				end
			end
			table.sort(sort, sortGroupName)
		end
		
		self:SetOpt("Sort", msg)
		
		-- We need to ensure that all the frames we need exist at this point
		local f = self.frames[sort[1]]
		f:ClearAllPoints()
		f:SetPoint("TOPLEFT", PerfectRaidFrame, "TOPLEFT", 0, 0)
		local last = f
		
		local vfont = self.virtualfont
		local truncate = self.opt.Truncate
		local length
		
		if truncate then
			vfont:SetText("Spartikus")
			length = vfont:GetStringWidth() 
		else
			length = f.Name:GetStringWidth()
		end
		
		local seperator = self.opt.Voffset
		local seperate, voffset = nil, 0
		if msg == "group" or msg == "groupclass" or msg == "class" then
			seperate = true
		end
		
		for i=2,table.getn(sort) do
			local v = sort[i]
			local f = frames[v]
		
			if seperate then
				if keys[v] ~= keys[last.unit] then
					voffset = seperator
				else
					voffset = 0
				end
			else
				voffset = 0
			end
			
			if not truncate then
				vfont:SetText(UnitName(v))
				local len = vfont:GetStringWidth()
				if len > length then length = len end
			end
			
			f:ClearAllPoints()
			f:SetPoint("TOPLEFT", last, "BOTTOMLEFT", 0, voffset)
			last = self.frames[v]
		end

		for k,v in visible do
			local f = frames[k]
			f.Name:SetWidth(length + 5)
		end
	end,
	
	Select = function(self, msg, force)
		if GetNumRaidMembers() == 0 then return end

		local _,type,sub

		if msg then 
			_,_,type,sub = string.find(msg, "(%w+)%s*(%w*)")
		else
			type = self.opt.Select
			sub = self.opt.SelectSub
		end
		
		if sub then sub = string.upper(sub) end
		local num = tonumber(sub)
		
		if self.opt.Align == "right" then 
			self.mark = "<"
			self.ttmark = "<<"
		else
			self.mark = ">"
			self.ttmark = ">>"
		end

		if type == "group" and num then 
			if not force then self:Msg("Selecting group #" .. num.. ".") end
			for k,v in pairs(visible) do
				local _,_,g = GetRaidRosterInfo(self.frames[k].id)
				selected[k] = (g == num)
			end
		elseif type == "class" and PERFECTRAID.CLASSES[sub] then
			if not force then self:Msg("Selecting by class: " .. string.upper(string.sub(sub,1,1)) .. string.lower(string.sub(sub,2,-1)) .. ".") end
			for k,v in pairs(visible) do
				local _,class = UnitClass(k)
				selected[k] = (class == sub)
			end
		elseif type == "all" then 
			if not force then self:Msg("Selecting all raid members.") end
			for k,v in pairs(visible) do
				selected[k] = true
			end
		elseif type == "none" then 
			if not force then self:Msg("Selecting nothing.") end
			for k,v in pairs(visible) do
				selected[k] = false
			end
		elseif type == "number" then
			if not force then self:Msg("Showing group numbers.") end
			for k,v in pairs(visible) do
				local num = self.frames[k].id
				local _,_,g = GetRaidRosterInfo(num)
				self.frames[k].group = g
				self.frames[k].Prefix:SetText(g)
				selected[k] = true
				self:SetOpt("Select", type)
			end
			return
		end
		
		self:SetOpt("Select", type)
		if sub then self:SetOpt("SelectSub", sub) end
		
		for k,v in pairs(selected) do
			local f = self.frames[k]
			f.marked = v
			
			-- Change the direction of the mark if we're facing right			
			if v then 
				f.Prefix:SetText(self.mark) 
			else 
				f.Prefix:SetText("")
			end
		end
	end,
	
	Show = function(self) 
		if self.master then self.master:Show() end
	end,
	
	Hide = function(self)
		if self.master then self.master:Hide() end
	end,
	
	Reset = function(self)
		self:Msg("Resetting all settings to defaults.")
		
		local f = self.master
		
		f:ClearAllPoints()
		f:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
		f:Show()
		
		for k,v in pairs(self.opt) do
			self.opt[k] = nil
		end
	
		self:UpdateVisibility()
		self:SavePosition()
	end,
				
	Align = function(self, msg, force)
		msg = msg or self.opt.Align
		msg = string.lower(msg)
		local justify, point, relative, offset
		
		if msg == "left" then
			if not force then self:Msg("Aligning frames to the left.") end
			justify = "RIGHT"
			point = "LEFT"
			relative = "RIGHT"
			offset = 5

		elseif msg  == "right" then
			if not force then self:Msg("Aligning frames to the right.") end
			justify = "LEFT"
			point = "RIGHT"
			relative = "LEFT"
			offset = -5
		end
		
		for i,f in ipairs(self.frames) do
			f.Prefix:ClearAllPoints()
			f.Name:ClearAllPoints()
			f.Bar:ClearAllPoints()
			f.Status:ClearAllPoints()
			
			-- Prefix gets "LEFT, LEFT" or "RIGHT, RIGHT" since its always on the edge
			f.Prefix:SetPoint(point, f, point, 0, 0)
			f.Name:SetPoint(point, f.Prefix, relative, 0, 0)
			f.Name:SetJustifyH(justify)
			f.Bar:SetPoint(point, f.Name, relative, offset, 0)
			f.Status:SetPoint(point, f.Bar, relative, offset, 0)
			f.Status:SetJustifyH(justify)
		end
		
		-- Refresh the selection
		self:SetOpt("Align", msg)
		self:Select(nil, true)
	end,
	
	SetBackdrop = function(self, msg, force)
		if not msg then 
			self:SetBackdrop(self.opt.BackdropBar, true) 
			self:SetBackdrop(self.opt.BackdropFrame, true)
			return
		end
		
		msg = string.lower(msg)
		local _,_,type,r,g,b,a = string.find(msg, "(%a+)%s*(%d*%.?%d*)%s*(%d*%.?%d*)%s*(%d*%.?%d*)%s*(%d*%.?%d*)")
		r,g,b,a = r or 0, g or 0, b or 0, a or 0
		
		if type == "bar" then
			self:SetOpt("BackdropBar", msg)
			for k,v in visible do
				local f = frames[k]
				f.Bar:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
												tile = true, tileSize = 32,
												insets = { left = 0, right = 0, top = 0, bottom = 0 }});
				f.Bar:SetBackdropColor(r,g,b,a)	
			end
		elseif type == "frame" then
			self:SetOpt("BackdropFrame", msg)
			for k,v in visible do
				local f = frames[k]
				f:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
												tile = true, tileSize = 32,
												insets = { left = 0, right = 0, top = 0, bottom = 0 }});
				f:SetBackdropColor(r,g,b,a)	
			end
		else
			self:Msg("Usage is /praid [bar|frame] r g b a.")
			return
		end
	
		if not force then self:Msg("Setting backdrop for %s to %s, %s, %s, %s.", type, r, g, b, a) end
	end,
	
	Truncate = function(self)
		if self.opt.Truncate then
			self:Msg("Truncate names is |cFF00FF00Off|r.")
			self:SetOpt("Truncate", false)
		else
			self:Msg("Truncate names is |cFF00FF00On|r.")
			self:SetOpt("Truncate", true)
		end
		self:UpdateVisibility()
	end,
	
	SetLowMana = function(self, msg)
		if not msg then 
			self:Msg("/praid manathreshold takes a number 0-100 as its only option.")
			return
		end
		
		local num = tonumber(msg)
		if num and (num >= 0 and num <= 100) then
			self:SetOpt("LowMana", num)
			self:Msg("Setting the low mana threshold to %d", num)
		end
	end,

	SetScale = function(self, msg, force)
		if force then msg = self.opt.Scale end
		
		if not msg then 
			self:Msg("/praid scale takes a number from 0-2.")
			return
		end
		
		local num = tonumber(msg)
		if num and (num > 0 and num < 2) then
			self:SetOpt("Scale", num)
			self.master:SetScale(num)
			if not force then self:Msg("Setting the scale to %d", num) end
		end
	end,

	SetVoffset = function(self, msg)
		if not msg then msg = self.opt.Voffset end
		
		if not msg then 
			self:Msg("/praid scale takes any number greater than 0.")
			return
		end
		
		self:Msg("Setting the vertical offset to %s.", msg)
		
		local num = tonumber(msg)
		self:SetOpt("Voffset", num)
		
		self:UpdateVisibility()
	end,
	
	SortNeed = function(self, msg)

	end,
	
	ToggleFilter = function(self)
		if self.opt.Filter then
			self:Msg("Debuff filter is |cFF00FF00Off|r.")
			self:SetOpt("Filter", false)
		else
			self:Msg("Debuff filter is |cFF00FF00On|r.")
			self:SetOpt("Filter", true)
		end
		self:UpdateVisibility()
	end,		

	ToggleRangeCheck = function(self)
		if self.opt.RangeCheck then
			self:Msg("Range checking is |cFF00FF00Off|r.")
			self:SetOpt("RangeCheck", false)
			for k,v in visible do
				frames[k]:SetAlpha(1.0)
			end
		else
			self:Msg("Range checking is |cFF00FF00On|r.")
			self:SetOpt("RangeCheck", true)
		end
		
		self:RangeHooks()
	end,		

--[[---------------------------------------------------------------------------------
  Utility functions
------------------------------------------------------------------------------------]]
	
	-- Type is stored in TextRight1
	--local type = PerfectRaidTooltipTextRight1:GetText()
	
	CreateFrame = function(self, num)
		-- We need to allocate up to num frames
		
		if self.poolsize >= num then return end

--[[
		local mem,thr = gcinfo()
		self:Msg("Memory Usage Before: %s [%s].", mem, thr)
--]]
		local side = self.opt.Align
		
		local justify,point,relative,offset
		
		if side == "left" then
			justify = "RIGHT"
			point = "LEFT"
			relative = "RIGHT"
			offset = 5
		elseif side == "right" then
			justify = "LEFT"
			point = "RIGHT"
			relative = "LEFT"
			offset = -5
		end
		
		for i=(self.poolsize + 1),num do
			local frame = CreateFrame("Button", nil, PerfectRaidFrame)
			frame:EnableMouse(true)
			frame.unit = "raid"..i
			frame.id = i
			frame:SetWidth(225)
			frame:SetHeight(13)
			frame:SetMovable(true)
			frame:RegisterForDrag("LeftButton")
			frame:SetScript("OnDragStart", function() self["master"]:StartMoving() end)
			frame:SetScript("OnDragStop", function() self["master"]:StopMovingOrSizing() self:SavePosition() end)
			frame:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up")
			frame:SetScript("OnClick", self.OnClick)
			frame:SetParent(self.master)

			local font = frame:CreateFontString(nil, "ARTWORK")
			font:SetFontObject(GameFontHighlightSmall)
			font:SetText("WW")
			font:SetJustifyH("CENTER")
			font:SetWidth(font:GetStringWidth())
			font:SetHeight(14)
			font:Show()
			font:ClearAllPoints()
			font:SetPoint(point, frame, relative,0, 0)
			-- Add this font string to the frame
			frame.Prefix = font
			
			font = frame:CreateFontString(nil, "ARTWORK")
			font:SetFontObject(GameFontHighlightSmall)
			font:SetText()
			font:SetJustifyH(justify)
			font:SetWidth(55)
			font:SetHeight(12)
			font:Show()
			font:ClearAllPoints()
			font:SetPoint(point, frame.Prefix, relative, offset, 0)
			-- Add this font string to the frame
			frame.Name = font
			
			local bar = CreateFrame("StatusBar", nil, frame)
			bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
			bar:SetMinMaxValues(0,100)
			bar:ClearAllPoints()
			bar:SetPoint(point, frame.Name, relative, offset, 0)
			bar:SetWidth(60)
			bar:SetHeight(7)
			bar:Show()
			-- Add this status bar to the frame
			frame.Bar = bar
			
			font = frame:CreateFontString(nil, "ARTWORK")
			font:SetFontObject(GameFontHighlightSmall)
			font:SetText("")
			font:SetJustifyH(justify)
			font:SetWidth(font:GetStringWidth())
			font:SetHeight(12)
			font:Show()
			font:ClearAllPoints()
			font:SetPoint(point, frame.Bar, relative, offset, 0)
			-- Add this font string to the frame
			frame.Status = font
			
			-- Lets set the frame in the indexed array
			frames[i] = frame
			frames["raid"..i] = frame
			self.poolsize = i
		end
		
		mem2,thr2 = gcinfo()
--[[
		self:Msg("Memory Usage After: %s [%s].", mem2, thr2)
		self:Msg("Frame creation change: %s [%s].", mem2 - mem, thr2 - thr)
--]]
	end,
	
	GetHPSeverity = function(self, percent,smooth)
		if (percent<=0 or percent>1.0) then return 0.35,0.35,0.35 end
	
			if smooth then	
			if (percent >= 0.5) then
				return (1.0-percent)*2, 1.0, 0.0
			else
				return 1.0, percent*2, 0.0
			end
		else
			return 0,1,0
		end
	end,
	
	SavePosition = function(self)	
		local f = self.master
		local x,y = f:GetLeft(), f:GetTop()
		local s = f:GetEffectiveScale()
		
		x,y = x*s,y*s
		
		self:SetOpt("PosX", x)
		self:SetOpt("PosY", y)
	end,

	RestorePosition = function(self)
		local x = self.opt.PosX
		local y = self.opt.PosY
		
		if not x or not y then return end
				
		local f = PerfectRaidFrame
		local s = f:GetEffectiveScale()
	
		x,y = x/s,y/s
	
		f:ClearAllPoints()
		f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)
	end,
	
	RegisterEvent = function(self, event)
		registry[event] = event
		self.master:RegisterEvent(event)
	end,
	
	UnregisterEvent = function(self, event)
		registry[event] = nil
		self.master:UnregisterEvent(event)
	end,
	
	UnregisterAllEvents = function(self)
		for k,v in pairs(registry) do
			registry[k] = nil
			self.master:UnregisterEvent(k)
		end
	end,
	
	EventHandler = function()
		local self = PerfectRaid
		if registry[event] then
			if self[event] then
				self[event](self)
			end
		end
	end,	
	
	Msg = function(self,msg,a1,a2,a3,a4,a5,a6,a7,a8,a9)
		if not msg then return end
		local output
		if a1 then output = string.format(msg,a1,a2,a3,a4,a5,a6,a7,a8,a9) end
		DEFAULT_CHAT_FRAME:AddMessage(string.format("|cffffff78PerfectRaid:|r %s", output or msg))
	end,
	
	Debug = function(self,msg,a1,a2,a3,a4,a5,a6,a7,a8,a9)
		if not msg or not debug then return end
		local output
		if a1 then output = string.format(msg,a1,a2,a3,a4,a5,a6,a7,a8,a9) end
		DEFAULT_CHAT_FRAME:AddMessage(string.format("|cFF00E6C6PerfectRaid:|r %s", output or msg))
	end,
	
	Test = function(self, command, args)
		self:Msg("Test Command: %s Args: %s.", tostring(command), tostring(args))
	end,

	SortNeed = function(self, command, args)
		self:Msg("SortNeed Command: %s Args: %s.", tostring(command), tostring(args))
	end,	
}

PerfectRaid:Initialize()
p = PerfectRaid