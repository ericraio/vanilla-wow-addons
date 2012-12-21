--[[
Name: AnchorsAway-1.0
Revision:
Author: Xuerian (sky.shell@gmail.com)
Website: none
Documentation: none
SVN: 
Description: Row stacking and anchoring template
Dependencies: AceLibrary, AceEvent-2.0, AceLocale-2.2
]]

local vmajor, vminor = "AnchorsAway-1.0", "$Revision: 14544 $"

if not AceLibrary then error(vmajor .. " requires AceLibrary.") end
if not AceLibrary:IsNewVersion(vmajor, vminor) then return end
if not AceLibrary:HasInstance("AceEvent-2.0") then error(vmajor .. " requires AceEvent-2.0") end
if not AceLibrary:HasInstance("AceLocale-2.2") then error(vmajor .. " requires AceLocale-2.2") end

-------------------------------------------
-------       Localization         ----------
-------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AnchorsAway")

L:RegisterTranslations("enUS", function()
	return {
		catGrowth = "Row growth",
		catPosSelf = "Anchor point...",
		catPosTarget = "To...",
		catPosOffset = "Offset frame...",
				
		optPositioning = "Positioning",
		optLock = "Lock",
		optAnchor = "Show Anchor",
		optPosVert = "Vertically",
		optPosHoriz = "Horizontally",
		optTimeout = "Timeout",
		optThreshold = "Stack Threshold",
		
		descPositioning = "Position and attachment of rows in the stack",
		descAnchor = "Show anchor for this stack",
		descPosVert = "Offset the row vertically from the point you choose to anchor it to by a specific amount",
		descPosHoriz = "Offset the row horizontally from the point you choose to anchor it to by a specific amount",
		descTimeout = "Time before each row fades. |cFFFF5522Setting this to 0 disables timed fading entirely",
		descDirection = "Direction stacks grow",
		descThreshold = "Maximum number of rows displayed at any given time",
		
		optPos = {
			TOPLEFT = "Top left corner",
			TOP = "Top edge",
			TOPRIGHT = "Top right corner",
			RIGHT = "Right edge",
			BOTTOMRIGHT = "Bottom right corner",
			BOTTOM = "Bottom edge",
			BOTTOMLEFT = "Bottom left corner",
			LEFT = "Left edge",
			TOPLEFT = "Top left corner",
		},
	}
end)

L:RegisterTranslations("frFR", function()
	return {
		catGrowth = "Croissance des lignes",
		catPosSelf = "Point d'ancrage...",
		catPosTarget = "Vers...",
		catPosOffset = "D\195\169calage de la fen\195\170tre...",
					
		optPositioning = "Positionnement",
		optAnchor = "Afficher l'ancrage",
		optPosVert = "Verticalement",
		optPosHoriz = "Horizontalement",
		optTimeout = "Dur\195\169 d'affichage",
		optDirection = "Direction",
		optThreshold = "Nombre de ligne affich\195\169",
		
		descPositioning = "Position de chaque ligne",
		descAnchor = "Afficher l'ancrage pour cette ligne",
		descPosVert = "D\195\169cale la ligne verticalement depuis le point que vous avez choisie d'ancrer du nombre sp\195\169cifi\195\169",
		descPosHoriz = "D\195\169cale la ligne horizontalement depuis le point que vous avez choisie d'ancrer du nombre sp\195\169cifi\195\169",
		descTimeout = "Dur\195\169 avant disparition des lignes. |cFFFF5522A 0, d\195\169sactive la disparition compl\195\168tement",
		descDirection = "Direction de l'affichage des lignes de loot",
		descThreshold = "Nombre maximum de lignes affich\195\169 simultan\195\169ment",
		
		optPos = {
			TOPLEFT = "Coin sup\195\169rieur gauche",
			TOP = "Bord sup\195\169rieur",
			TOPRIGHT = "Coin sup\195\169rieur droit",
			RIGHT = "Bord droit",
			BOTTOMRIGHT = "Coin inf\195\169rieur droit",
			BOTTOM = "Bord infr\195\169rieur",
			BOTTOMLEFT = "Coin inf\195\169rieur gauche",
			LEFT = "Bord gauche",
			TOPLEFT = "Coin sup\195\169rieur gauche",
		},
	}
end)


-------------------------------------------
-------         Definition         ----------
-------------------------------------------

local AnchorsAway = { }

AceLibrary("AceEvent-2.0"):embed(AnchorsAway)

function AnchorsAway:NewStack(stackname, icon, db)
	db.AnchorsAway = db.AnchorsAway or {}
	if not db.AnchorsAway[stackname] then 
		db.AnchorsAway[stackname] = { lock = false, anchor = true, attach = { self = "TOPLEFT", target = "BOTTOMLEFT", x = 0, y = 0 }, scale = 1, timeout = 15, threshold = 6, pos = {} }
	end
	local stackdb = db.AnchorsAway[stackname]
	if not self.stacks then self.stacks = { } end
	self.stacks[stackname] =  { 
				rows = {}, 
				rowstack = {}, 
				built = 0,
				shown = 0,
				index = 'key',
				db = stackdb,
				dismissable = true,
				detachable = false,
				icon = icon
				}
	return self.stacks[stackname]
end

function AnchorsAway:Restack(stack, sortkey)
	sortkey = sortkey or stack.index
	for k, v in pairs(stack.rowstack) do
		v:ClearAllPoints()
		if not v:IsVisible() then
			table.remove(stack.rowstack, k)
		end
	end
	for k, v in iteratetable(stack.rowstack, sortkey) do
		self:StackRow(stack, stack.rowstack[k], k == 1 and stack.frame or  stack.rowstack[k-1], k)
		stack:SizeRow(stack, v)
	end
end

function AnchorsAway:StackRow(stack, row, target)
	row:ClearAllPoints()
	row:SetPoint(stack.db.attach.self, target, stack.db.attach.target, stack.db.attach.x, stack.db.attach.y)
end

function AnchorsAway:AcquireRow(stack)
	local nextkey = table.getn(stack.rowstack) + 1
	stack.shown = stack.shown +1
	local id
	if table.getn(stack.rows) < nextkey then
		stack:BuildRow(stack, nextkey)
		id = nextkey
	else	
		for i = 1, table.getn(stack.rows) do
			if stack.rows[i] and not stack.rows[i].active then
				id = i
				break
			end
		end
	end
	stack.rows[id].active = true
	return stack.rows[id], id
end

function AnchorsAway:PushRow(stack)
	local row, id = self:AcquireRow(stack)
	local db = stack.db
	
	table.insert(stack.rowstack, 1, row)
	
	if stack.rowstack[2] and stack.rowstack[2] ~= stack.rowstack[1] then
		self:StackRow(stack, stack.rowstack[2], stack.rowstack[1], 2)
	elseif stack.rowstack[2] then
		--DevTools_Dump(stack.rowstack)
		return nil
	end
	self:StackRow(stack, stack.rowstack[1], stack.frame, 1)
		
	row:Show()

	if stack.shown > db.threshold then
		self:PopRow(stack, nil, nil, db.threshold+1)
	end
	
	UIFrameFadeIn(row, 0.5, 0, 1)
	if db.timeout > 0 then
		row.event = self:ScheduleEvent(tostring(id), self.PopRow, db.timeout, self, stack, id, true)
	end
	row.key = self.uid
	self.uid = self.uid + 1
	return row
end

function AnchorsAway:PopRow(stack, id, event, stackid, time, func)
	if not id then
		id = stack.rowstack[stackid].id
	end
	
	if stack.rows[id].event and not event then 
		self:CancelScheduledEvent(stack.rows[id].event)
	end
	
	UIFrameFadeIn(stack.rows[id], time or 1, 1, 0)
	stack.rows[id].fadeInfo.finishedFunc = function() self:RemoveRow(stack, stack.rows[id]) if func then func() end end
end

function AnchorsAway:RemoveRow(stack, row)
	row:ClearAllPoints()
	stack.shown = stack.shown -1
	row:Hide()
	self:ClearRow(stack, row.id)
	for k,v in ipairs(stack.rowstack) do 
		if v == row then
			table.remove(stack.rowstack, k)
			break
		end
	end
end

function AnchorsAway:ClearRow(stack, id)
	local row = stack.rows[id]
	if row.event then
		self:CancelScheduledEvent(row.event)
	end
	row.active = false
	row:ClearAllPoints()
	if stack.clear then stack.clear(row) end
end

function AnchorsAway:DragStart(stack, culprit) 
	if not stack.db.lock then 
		stack.frame:StartMoving() 
		if culprit then
			culprit.dragging = true
		end
	end
end

function AnchorsAway:DragStop(stack, culprit)
	stack.frame:StopMovingOrSizing()
	if culprit then
		culprit.dragging = false
	end
	if not stack.db.lock then 
		stack.db.pos = { x = stack.frame:GetLeft(), y = stack.frame:GetTop() }
	end
end 

function AnchorsAway:OnRowHide(stack, culprit)
	if culprit.dragging then
		self:DragStop(stack, culprit)
	end
end

function AnchorsAway:NewAnchor(stackname, anchorname, icon, db, dewdrop)
	local stack = self:NewStack(stackname, icon, db)
	stack.frame = CreateFrame("Frame", "AnchorsAway_"..stackname.."_Anchor", UIParent)
	stack.frame.anchortext = stack.frame:CreateFontString("AnchorsAway_"..stackname.."_AnchorText", "ARTWORK", "GameFontNormal")
	stack.frame:SetMovable(1)
	
	stack.frame:RegisterForDrag("LeftButton")
	stack.frame:SetScript("OnDragStart", function() self:DragStart(stack) end)
	stack.frame:SetScript("OnDragStop", function() self:DragStop(stack) end)

	local anchor = anchorname or stackname
		
	stack.frame.anchortext:ClearAllPoints()
	stack.frame.anchortext:SetAllPoints(stack.frame)
	stack.frame.anchortext:SetJustifyH("CENTER")
	stack.frame.anchortext:SetJustifyV("MIDDLE")
	stack.frame.anchortext:SetText("|cAAAAAAAA"..anchor)
	stack.frame:SetWidth(150)
	stack.frame:SetHeight(20)

	stack.frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", stack.db.pos.x or GetScreenWidth()/2, stack.db.pos.y or GetScreenWidth()/2) 	
	
	stack.frame:SetBackdrop({r = 0, g = 0, b = 0, a = 0.9})
	stack.frame:SetBackdropBorderColor(.5, .5, .5, 1)
	
	stack.name = stackname
	stack.anchorname = anchorname

	if dewdrop then
		stack.opts = self:Opts(stack)
		dewdrop:Register(stack.frame, 'children', function() dewdrop:FeedAceOptionsTable({ type = "group", args = stack.opts}) end, 'cursorX', true, 'cursorY', true)
	end

	stack.frame:Show()
	if stack.db.anchor then
		stack.frame:EnableMouse(1)
		UIFrameFadeIn(stack.frame, 0.5, 0, 1)
	else
		stack.frame:EnableMouse(0)
		stack.frame:SetAlpha(0)
	end
	return stack
end

local hcolor = "|cFF77BBFF"
local specialmenu = "|cFF44EE66"

function AnchorsAway:Opts(stack)
	if stack.opts then return stack.opts end
	local db = stack.db
	local skeleton = {
					header = {
						type = "header",
						icon = stack.icon,
						iconWidth = 24,
						iconHeight = 24,
						name = hcolor..stack.anchorname,
						order = 1					
					},
					anchor = {
						type = "toggle",
						name = L["optAnchor"],
						desc = L["optAnchor"],
						set = function()
							db.anchor = not db.anchor
							stack.frame:EnableMouse(db.anchor)
							if db.anchor then
								if stack.frame:GetAlpha() < 1 then
									UIFrameFadeIn(stack.frame, 0.5, 0, 1)
								end
							elseif stack.frame:GetAlpha() > 0 then
								UIFrameFadeIn(stack.frame, 0.5, 1, 0)
							end
						end,
						get = function() return db.anchor end,
						order = 2,
					},
					lock = {
						type = "toggle",
						name = L["optLock"],
						desc = L["optLock"],
						get = function()
							return db.lock
							end,
						set = function(v)
							db.lock = v
							end,
						order = 4
					},
					spacer = {
						type = "header",
						order = 6
					},
					positioning = {
						type = "group",
						name = L["optPositioning"],
						desc = L["descPositioning"],
						args = {
							offset = {
								type = "header",
								name = hcolor..L["catPosOffset"],
								order = 1
							},
							horiz = {
								type = "range",
								icon = "Interface\\Buttons\\UI-SliderBar-Button-Vertical",
								iconHeight = 24,
								iconWidth = 24,
								name = L["optPosHoriz"],
								desc = L["descPosHoriz"],
								get = function()
									return db.attach.x
									end,
								set = function(v)
									db.attach.x = v
									end,
								min = -20,
								max = 20,
								step = 1,
								order = 2
							},
							vert = {
								type = "range",
								name = L["optPosVert"],
								icon = "Interface\\Buttons\\UI-SliderBar-Button-Horizontal",
								iconHeight = 24,
								iconWidth = 24,
								desc = L["descPosVert"],
								get = function()
									return db.attach.y
									end,
								set = function(v)
									db.attach.y = v
									end,
								min = -20,
								max = 20,
								step = 1,
								order = 3
							},
							spacer = {
								type = "header",
								order = 5
							},
							self = {
								type = "header",
								name = hcolor..L["catPosSelf"],
								order = 10
							},
							spacer2 = {
								type = "header",
								order = 20
							},
							target = {
								type = "header",
								name = hcolor..L["catPosTarget"],
								order = 30
							},
						},
						order = 8
					},
					timeout = {
						type = "range",
						name = L["optTimeout"],
						desc = L["descTimeout"],
						get = function()
							return db.timeout
							end,
						set = function(v)
							db.timeout = v
							end,
						min = 0,
						max = 200,
						step = 5,
						order = 12
					},
					threshold = {
						type = "range",
						name = L["optThreshold"],
						desc = L["descThreshold"],
						get = function()
							return db.threshold
							end,
						set = function(v)
							db.threshold = v
							end,
						min = 1,
						max = 40,
						step = 1,
						order = 14
					},
				}
		local selfattach = self:AttachMenu(11, stack, "self")
		local targetattach = self:AttachMenu(31, stack, "target")
		for k, v in pairs(selfattach) do
			skeleton.positioning.args["self"..v.point] = v
		end
		for k, v in pairs(targetattach) do
			skeleton.positioning.args["target"..v.point] = v
		end
		return skeleton
end

function AnchorsAway:AttachMenu(offset, stack, point)
	local points = { "TOPLEFT", "TOP", "TOPRIGHT", "RIGHT", "BOTTOMRIGHT", "BOTTOM", "BOTTOMLEFT", "LEFT" }
	local toggles = { }
	for key, val in pairs(points) do
		local tempval = val
		local tmp = { 
					type = "toggle", 
					name =L["optPos"][tempval], 
					desc = L["optPos"][tempval], 
					isRadio = true,
					checked = variable == tempval,
					set = function(v)
						variable = tempval; 
						stack.db.attach[point] = tempval
						self:Restack(stack)
						end,
					get = function()
							return stack.db.attach[point] == tempval
						end,
					point = tempval,
					order = offset + key - 1,
					}
		table.insert(toggles, tmp)
	end
	return toggles
end

local function activate(self, oldLib, oldDeactivate)
	self.stacks = oldLib and oldLib.stacks or {}
	self.uid = oldLib and oldLib.uid or 1
end


-- Spread the voodoo. Thanks to ckk.
do
	local mySort = function(a, b)
		if not a then
			return false
		end
		if not b then
			return true
		end
		
		if type(a) == "string" then
			return string.upper(a) < string.upper(b)
		else
			return a < b
		end
	end

	local mySort_reverse = function(a, b)
		if not b then
			return false
		end
		if not a then
			return true
		end
		
		if type(a) == "string" then
			return string.upper(a) > string.upper(b)
		else
			return a > b
		end
	end

	local current
	local sorts = setmetatable({}, {__index=function(self, sortBy)
		local x = function(a, b)
			if not a or not b then
				return false
			elseif type(current[a][sortBy]) == "string" then
				return string.upper(current[a][sortBy]) < string.upper(current[b][sortBy])
			else
				return current[a][sortBy] < current[b][sortBy]
			end
		end
		self[sortBy] = x
		return x
	end})
	local sorts_reverse = setmetatable({}, {__index=function(self, sortBy)
		local x = function(a, b)
			if not a or not b then
				return false
			elseif type(current[a][sortBy]) == "string" then
				return string.upper(current[a][sortBy]) > string.upper(current[b][sortBy])
			else
				return current[a][sortBy] > current[b][sortBy]
			end
		end
		self[sortBy] = x
		return x
	end})

	local iters; iters = setmetatable({}, {__index=function(self, t)
		local q; q = function(tab)
			local position = t['#'] + 1
			
			local x = t[position]
			if not x then
				for k in pairs(t) do
					t[k] = nil
				end
				tsetn(t, 0)
				iters[t] = q
				return
			end
			
			t['#'] = position
			
			return x, tab[x]
		end
		return q
	end, __mode='k'})

	function iteratetable(tab, key, reverse)
		local t = next(iters) or {}
		local iter = iters[t]
		iters[t] = nil
		for k, v in pairs(tab) do
			table.insert(t, k)
		end
		
		if not key then
			table.sort(t, reverse and mySort_reverse or mySort)
		else
			current = tab
			table.sort(t, reverse and sorts_reverse[key] or sorts[key])
			current = nil
		end
		
		t['#'] = 0
		
		return iter, tab
	end
end

AceLibrary:Register(AnchorsAway, vmajor, vminor, activate)
AnchorsAway = nil