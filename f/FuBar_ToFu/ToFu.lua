local tablet = AceLibrary("Tablet-2.0")
local abacus = AceLibrary("Abacus-2.0")

local L = AceLibrary("AceLocale-2.2"):new("FuBar_ToFu")
ToFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceHook-2.0", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")

ToFu:RegisterDB("ToFuDB")
ToFu:RegisterDefaults('account', {
	paths = {
		Alliance = {['*']={}},
		Horde = {['*']={}},
	},
})
ToFu:RegisterDefaults('profile', {
	hook = {
		oCD = false,
		oCB = false,
		BigWigs = false,
		Chronometer = false,
	},
})
local optionsTable = {
	handler = ToFu,
	type = 'group',
	args = {
		hook = {
			type = 'group', name = L['Hooks'],
			desc = L['Other addons to hook into'],
			args = {
				oCD = {
					type = 'toggle', name = 'oCD',
					desc = 'otravi_CoolDown',
					get = function() return ToFu.db.profile.hook.oCD end,
					set = function(t) ToFu.db.profile.hook.oCD = t end,
					disabled = function()
						if oCD then return false
						else return true end
					end,
				},
				oCB = {
					type = 'toggle', name = 'oCB',
					desc = 'otravi_CastBar',
					get = function() return ToFu.db.profile.hook.oCB end,
					set = function(t) ToFu.db.profile.hook.oCB = t end,
					disabled = function()
						if oCB then return false
						else return true end
					end,
				},
				BigWigs = {
					type = 'toggle', name = 'BigWigs',
					desc = 'BigWigs_CustomBar',
					get = function() return ToFu.db.profile.hook.BigWigs end,
					set = function(t) ToFu.db.profile.hook.BigWigs = t end,
					disabled = function()
						if BigWigs and BigWigsCustomBar then return false
						else return true end
					end,
				},
				Chronometer = {
					type = 'toggle', name = 'Chronometer',
					desc = 'Chronometer',
					get = function() return ToFu.db.profile.hook.Chronometer end,
					set = function(t) ToFu.db.profile.hook.Chronometer = t end,
					disabled = function()
						if Chronometer then return false
						else return true end
					end,
				},
			},
		},
		data = {
			type = 'group', name = L['Data'],
			desc = L["Various options to do with saved flight data"],
			args = {
				clear = {
					type = 'execute', name = L['Clear Data'],
					desc = L["Delete *ALL* saved flight path data for your faction."],
					func = "ClearData",
				},
				default = {
					type = 'execute', name = L['Default Data'],
					desc = L["Load the default flight-time dataset."],
					func = function() ToFu:LoadDefaults() end, disabled = function() return type(ToFu.LoadDefaults) ~= 'function' end,
				},
			},
		},
	},
}

ToFu:RegisterChatCommand({"/tofu",}, optionsTable)
ToFu.OnMenuRequest = optionsTable

ToFu.version = "2.0." .. string.sub("$Revision: 15647 $", 12, -3)
ToFu.date = string.sub("$Date: 2006-10-31 20:34:49 -0500 (Tue, 31 Oct 2006) $", 8, 17)
ToFu.hasIcon = "Interface\\TaxiFrame\\UI-Taxi-Icon-Green"
ToFu.hideWithoutStandby = true

function ToFu:OnInitialize()
	self.start = nil
	self.destination = nil
	self.inFlight = false
	self.timeFlown = 0
	self.avgTime = nil
	self.last, self.nodes, self.steps = {}, {}, {}

	--Stolen from AceDB
	local _,race = UnitRace("player")
	if race == "Orc" or race == "Scourge" or race == "Troll" or race == "Tauren" then
		self.faction = 'Horde'
	else
		self.faction = 'Alliance'
	end

	if not self.db.account.version then
		self:ScheduleEvent(function()
			--Check to see whether we need to shrink the database.
			for faction, data in self.db.account.paths do
				self:Print('Upgrading', faction, 'flight data')
				--Convert the old data to the new format, and clear out the old DB in the process.
				if type(data) ~= 'table' then data = nil
				else
					local newdata = {}
					for start,dests in pairs(data) do
						local newstart = self:LessName(start)
						newdata[newstart] = {}
						if type(dests) == 'table' then
							for dest, info in pairs(dests) do
								newdata[newstart][self:LessName(dest)] = info
								data[start][dest] = nil
							end
						end
						data[start] = nil
					end
					--Now apply the new data to the DB.
					--(Can't merge this with the previous step, as it would be editing the table while looping over it.)
					for start, dests in pairs(newdata) do
						for dest, info in pairs(dests) do
							if not self.db.account.paths[start] then self.db.account.paths[start] = {} end
							self.db.account.paths[start][dest] = info
						end
					end
				end
			end
			
			self.db.account.version = 1
		end, 1)
	end
end

function ToFu:OnEnable()
	self:RegisterEvent("TAXIMAP_OPENED")
	self:Hook("TakeTaxiNode")
	self:Hook("TaxiNodeOnButtonEnter")
end


function ToFu:OnTextUpdate()
	if self.inFlight then
		if self.timeAvg ~= 0 then
			--Time remaining, if we've taken this path before.
			self:SetText(abacus:FormatDurationCondensed(self.timeAvg - self.timeFlown, true))
		else
			--Time flown so far.
			self:SetText(abacus:FormatDurationCondensed(self.timeFlown, true))
		end
	else
		self:SetText('')
	end
end

function ToFu:OnTooltipUpdate()
	local cat = tablet:AddCategory(
		'columns', 2,
		'text', L["Current Flight"],
		'child_textR', 1, 'child_textG', 0.82, 'child_textB', 0,
		'child_text2R', 1, 'child_text2G', 1, 'child_text2B', 1
	)
	if self.inFlight then
		cat:AddLine('text', L["From"], 'text2', self.start)
		cat:AddLine('text', L["To"], 'text2', self.destination)
		cat:AddLine('text', L["Time Taken"], 'text2', abacus:FormatDurationCondensed(self.timeFlown, true))
		cat:AddLine('text', L["Average Time"], 'text2', abacus:FormatDurationCondensed(self.timeAvg, true))
		cat:AddLine('text', L["Cost"], 'text2', abacus:FormatMoneyCondensed(self.cost, true))
	else
		cat:AddLine('text', L["Not in flight"])
	end

	cat = tablet:AddCategory(
		'columns', 2,
		'text', L["Previous Flight"],
		'child_textR', 1, 'child_textG', 0.82, 'child_textB', 0,
		'child_text2R', 1, 'child_text2G', 1, 'child_text2B', 1
	)
	if self.last.start ~= nil then
		cat:AddLine('text', L["From"], 'text2', self.last.start)
		cat:AddLine('text', L["To"], 'text2', self.last.destination)
		cat:AddLine('text', L["Time Taken"], 'text2', abacus:FormatDurationCondensed(self.last.time, true))
		cat:AddLine('text', L["Cost"], 'text2', abacus:FormatMoneyCondensed(self.last.cost, true))
	else
		cat:AddLine('text', L["No previous flight"])
	end

	if self.inFlight then
		tablet:SetHint(L["Click to copy the time remaining in flight to the chatbox."])
	end
end

function ToFu:OnClick()
	-- Paste time remaining to chatbox.
	if ChatFrameEditBox:IsVisible() and self.inFlight then
		local text = ""
		local _, time = self:GetFlightData(self.start, self.destination)

		if time ~= 0 then
			--Time remaining, if we've taken this path before.
			text = abacus:FormatDurationFull(time - self.timeFlown, false)
		else
			--Time flown so far.
			text = string.format("??? (%s %s)", abacus:FormatDurationFull(self.timeFlown, false), L["So Far"])
		end

		ChatFrameEditBox:Insert(text)
	end
end


function ToFu:OnUpdate(timeSinceLast)
	self.timeFlown = self.timeFlown + timeSinceLast
	if (UnitOnTaxi("player") ~= 1) and (self.timeFlown > 5) then
		-- Cheap test to make sure that we don't do all this right at the beginning of a flight
		self:CancelScheduledEvent(self.name)
		self.inFlight = false

		local cost, time, taken = self:GetFlightData(self.start, self.destination)

		--Average time this route has taken (there's a chance we'll be getting inaccuracies, etc.):
		if time ~= 0 then
			time = (time + self.timeFlown) / 2
			
			if self.db.profile.hook.oCB and oCB then
				oCB:SpellStop(true)
			end
		else
			time = self.timeFlown
		end

		self:SaveFlightData(self.start, self.destination, cost, time, taken + 1)

		self.last.start = self.start
		self.last.destination = self.destination
		self.last.time = self.timeFlown
		self.last.cost = cost

		self.start = nil
		self.destination = nil
		self.timeFlown = nil
	end
	self:UpdateDisplay()
end


function ToFu:TAXIMAP_OPENED()
	local numNodes = NumTaxiNodes()
	-- Have to scan all the slots first to get the "CURRENT" slot.
	for i=1, numNodes do
		if TaxiNodeGetType(i) == "CURRENT" then
			self.start = TaxiNodeName(i)
		else
			local x,y = TaxiNodePosition(i)
			self.nodes[x..':'..y] = i
		end
	end
end

function ToFu:TakeTaxiNode(slot)
	if TaxiNodeGetType(slot) == "REACHABLE" then
		self.destination = TaxiNodeName(slot)
		self.timeFlown = 0
		self.inFlight = true

		self.cost, self.timeAvg = self:GetFlightData(self.start, self.destination)

		if self.timeAvg ~= 0 then
			if self.db.profile.hook.oCD and oCD then
				--oCD:StartBar(id, time, text, icon)
				oCD:StartBar('ToFu', self.timeAvg, self:LessName(self.destination), "Interface\\TaxiFrame\\UI-Taxi-Icon-Green")
			end
			if self.db.profile.hook.oCB and oCB then
				--oCB:SpellStart(text, time, inSeconds, dontRegister)
				oCB:SpellStart(self:LessName(self.destination), self.timeAvg, true, true)
			end
			if self.db.profile.hook.BigWigs and BigWigs and BigWigsCustomBar then
				--BWCB(seconds, message)
				BWLCB(self.timeAvg, "Flying to "..self:LessName(self.destination))
			end
			if self.db.profile.hook.Chronometer and Chronometer then
				-- Chronometer:AddTimer(kind, name, duration, targeted, isgain, selforselect, extra)
				if not Chronometer.timers[Chronometer.SPELL]['ToFu'] then Chronometer:AddTimer(Chronometer.SPELL, 'ToFu', self.timeAvg, 0, 0, 0) end
				Chronometer:StartTimer(Chronometer.timers[Chronometer.SPELL]['ToFu'], self:LessName(self.destination))
			end
		end

		for key in pairs(self.nodes) do self.nodes[key] = nil end

		self:ScheduleRepeatingEvent(self.name, self.OnUpdate, 1, self, 1)
	end
	self.hooks["TakeTaxiNode"].orig(slot)
end

function ToFu:TaxiNodeOnButtonEnter(button)
	self.hooks["TaxiNodeOnButtonEnter"].orig(button)

	local index = button:GetID()
	if TaxiNodeGetType(index) == "REACHABLE" then
		local destination, cost = TaxiNodeName(index), TaxiNodeCost(index)
		local oldcost, time, taken = self:GetFlightData(self.start, destination)
		if oldcost ~= cost then self:SaveFlightData(self.start, destination, cost, time, taken) end

		local estimate = ''
		if time == 0 then
			--Try to estimate.  This is mainly stolen from Blizzard's TaxiFrame.lua, which uses a much more in-depth version of this to draw the lines.
			local _,reversetime = self:GetFlightData(destination, self.start)
			if reversetime > 0 then
				time = reversetime
				estimate = L['reversed']
			else
				local numRoutes = GetNumRoutes(index)
				if numRoutes > 1 then
					TaxiNodeSetCurrent(index) --This is magic -- it renumbers the 'hops' between index and current so the for loop below works.
					self.steps[1] = self.start

					local length = 0
					for i=1, numRoutes do
						local l, dx, dy = self:LineLength(index, i)
						length = length + l 
						
						self.steps[i+1] = TaxiNodeName(self.nodes[dx..':'..dy])
					end

					local skipped = 0
					local node = 1
					while node <= numRoutes do
						--self.steps[node] is the 'current' node.
						--Step backwards through self.steps to find the longest interval that gives us a time.
						local nnode = numRoutes+1
						while nnode > node do
							local _,t = self:GetFlightData(self.steps[node], self.steps[nnode])
							if t==0 then _,t = self:GetFlightData(self.steps[nnode], self.steps[node]) end
							nnode = nnode - 1
							if t > 0 then
								-- We know this!  Add it to the time and skip the rest of the loops.
								time = time + t
								break
							elseif nnode == node then
								-- We have no idea.  Mark down that we skipped this.
								skipped = skipped + self:LineLength(index, node-1) -- Is 'node-1' right here?
								break
							end
						end
						node = nnode + 1
					end
					if time > 0 then
						if skipped > 0 then time = time + ((time/(length-skipped)) * skipped) end
						estimate = ' '..L['estimated']
					end

					for key in pairs(self.steps) do self.steps[key] = nil end
				end
			end
		end

		GameTooltip:AddLine(L["Takes"]..": "..abacus:FormatDurationCondensed(time)..estimate, 1, 1, 1)
		GameTooltip:AddLine(string.format(L["Flown %s times"], taken), 1, 1, 1)
		GameTooltip:SetHeight(GameTooltip:GetHeight() + 28)
	end
end

function ToFu:LessName(s)
	--For "Thelsamar, Loch Modan" return "Thelsamar".
    if not s then return '' end
	if ( GetLocale() ~= "koKR" ) then
		local c = string.find(s, ', ')
		if c then s = string.sub(s, 1, c-1) end
	else
		local c = string.find(s, ' %(')
		if c then _,_,s = string.find(s, "(.-) %(") end
	end
	return s
end

-- Data in format: ":1000:120:3:"
-- Means: "cost 1000 copper, taking 120 seconds, taken 3 times."

function ToFu:GetFlightData(start, destination, faction)
	-- cost, time, taken = ToFu:GetFlightData(start, destination, faction)
	-- Fetches the saved information about a flight path, from [start] to [destination].
	-- If any arguments are left as nil, the current value of self.<<argument>> will be used.
	local s = self.db.account.paths[faction or self.faction][self:LessName(start or self.start)][self:LessName(destination or self.destination)]
	if type(s) ~= 'string' then return 0,0,0 end
	local _, _, cost, time, taken = string.find(s, ":(%d+):(%d+):(%d+):")
	return (tonumber(cost) or 0), (tonumber(time) or 0), (tonumber(taken) or 0), self:LessName(start or self.start), self:LessName(destination or self.destination)
end

function ToFu:SaveFlightData(start, destination, cost, time, taken, faction)
	self.db.account.paths[faction or self.faction][self:LessName(start)][self:LessName(destination)] = ':'..(cost or 0)..':'..math.floor((time and tonumber(time) or 0))..':'..(taken or 0)..':'
	return true
end

function ToFu:ClearData()
	self.db.account.paths[self.faction] = {}
end

function ToFu:LineLength(index, i)
	--Start node:
	local sx = TaxiGetSrcX(index, i)
	local sy = TaxiGetSrcY(index, i)
	--End node:
	local ex = TaxiGetDestX(index, i)
	local ey = TaxiGetDestY(index, i)
	-- Determine dimensions
	local dx,dy = ex - sx, ey - sy;
	-- Normalize direction if necessary
	if (dx < 0) then
		dx,dy = -dx,-dy;
	end
	-- Return length and endpoint coords.
	return sqrt((dx * dx) + (dy * dy)), ex, ey
end