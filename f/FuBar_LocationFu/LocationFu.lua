local L = AceLibrary("AceLocale-2.0"):new("FuBar_LocationFu")
local Tourist = AceLibrary("Tourist-2.0")
local Tablet = AceLibrary("Tablet-2.0")
local Jostle = AceLibrary("Jostle-2.0")

LocationFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0")

LocationFu.version = "2.0" .. string.sub("$Revision: 7853 $", 12, -3)
LocationFu.date = string.sub("$Date: 2006-08-12 12:15:59 -1000 (Sat, 12 Aug 2006) $", 8, 17)
LocationFu.hasIcon = true

local table_insert = table.insert

LocationFu:RegisterDB("LocationFuDB")
LocationFu:RegisterDefaults("profile", {
	showMapCoords = true,
	showCoords = true,
	showSubZoneName = true,
	showZoneName = false,
	showRecZones = true,
	showMapOverlay = true,
	showLevelRange = true,
})
function LocationFu:IsShowingCoords()
	return self.db.profile.showCoords
end

function LocationFu:ToggleShowingCoords()
	self.db.profile.showCoords = not self.db.profile.showCoords
	self:UpdateText()
end

function LocationFu:IsShowingZoneName()
	return self.db.profile.showZoneName
end

function LocationFu:ToggleShowingZoneName()
	self.db.profile.showZoneName = not self.db.profile.showZoneName
	self:UpdateText()
end

function LocationFu:IsShowingSubZoneName()
	return self.db.profile.showSubZoneName
end

function LocationFu:ToggleShowingSubZoneName()
	self.db.profile.showSubZoneName = not self.db.profile.showSubZoneName
	self:UpdateText()
end

function LocationFu:IsShowingLevelRange()
	return self.db.profile.showLevelRange
end

function LocationFu:ToggleShowingLevelRange()
	self.db.profile.showLevelRange = not self.db.profile.showLevelRange
	self:UpdateText()
end

function LocationFu:IsShowingMinimapBar()
	return self.db.profile.minimapBar
end

function LocationFu:ToggleShowingMinimapBar()
	self.db.profile.minimapBar = not self.db.profile.minimapBar
	if not self.db.profile.minimapBar then
		MinimapBorderTop:Hide()
		MinimapToggleButton:Hide()
		MinimapZoneTextButton:Hide()
	else
		MinimapBorderTop:Show()
		MinimapToggleButton:Show()
		MinimapZoneTextButton:Show()
	end
	Jostle:Refresh()
end

function LocationFu:IsShowingMapCoords()
	return self.db.profile.showMapCoords
end

function LocationFu:ToggleShowingMapCoords()
	self.db.profile.showMapCoords = not self.db.profile.showMapCoords
	if not self.db.profile.showMapCoords then
		LocationFuMapFrameCursorCoords:Hide()
		LocationFuMapFramePlayerCoords:Hide()
	else
		LocationFuMapFrameCursorCoords:Show()
		LocationFuMapFramePlayerCoords:Show()
	end
end

function LocationFu:IsShowingRecommendedZones()
	return self.db.profile.showRecZones
end

function LocationFu:ToggleShowingRecommendedZones()
	self.db.profile.showRecZones = not self.db.profile.showRecZones
	self:UpdateTooltip()
end

function LocationFu:IsShowingMapOverlay()
	return self.db.profile.showMapOverlay
end

function LocationFu:ToggleShowingMapOverlay()
	self.db.profile.showMapOverlay = not self.db.profile.showMapOverlay
	if not self.db.profile.showMapOverlay then
		LocationFuMapFrameText:Hide()
		WorldMapFrameAreaLabel:SetTextColor(1, 1, 1)
	else
		LocationFuMapFrameText:Show()
	end
	return self.db.profile.showMapOverlay
end

function LocationFu:OnInitialize()
	local mapFrame = CreateFrame("Frame", "LocationFuMapFrame", WorldMapFrame)
	mapFrame:SetScript("OnUpdate", self.MapFrame_OnUpdate)
	local cursorCoords = mapFrame:CreateFontString("LocationFuMapFrameCursorCoords", "ARTWORK")
	cursorCoords:SetFont(GameFontNormal:GetFont())
	cursorCoords:SetTextColor(GameFontNormal:GetTextColor())
	cursorCoords:SetShadowColor(GameFontNormal:GetShadowColor())
	cursorCoords:SetShadowOffset(GameFontNormal:GetShadowOffset())
	cursorCoords:SetPoint("RIGHT", WorldMapFrame, "CENTER", -80, -367)
	
	local playerCoords = mapFrame:CreateFontString("LocationFuMapFramePlayerCoords", "ARTWORK")
	playerCoords:SetFont(GameFontNormal:GetFont())
	playerCoords:SetTextColor(GameFontNormal:GetTextColor())
	playerCoords:SetShadowColor(GameFontNormal:GetShadowColor())
	playerCoords:SetShadowOffset(GameFontNormal:GetShadowOffset())
	playerCoords:SetPoint("RIGHT", WorldMapFrame, "CENTER", 80, -367)
	
	local text = mapFrame:CreateFontString("LocationFuMapFrameText", "OVERLAY")
	local font, size = GameFontHighlightLarge:GetFont()
	text:SetFont(font, size, "OUTLINE")
	text:SetTextColor(GameFontHighlightLarge:GetTextColor())
	text:SetShadowColor(GameFontHighlightLarge:GetShadowColor())
	text:SetShadowOffset(GameFontHighlightLarge:GetShadowOffset())
	text:SetPoint("TOP", WorldMapFrameAreaDescription, "BOTTOM", 0, -5)
end

function LocationFu:OnEnable()
	self:RegisterEvent("ZONE_CHANGED", "UpdateData")
	self:RegisterEvent("ZONE_CHANGED_INDOORS", "UpdateData")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	self:RegisterEvent("MINIMAP_ZONE_CHANGED", "UpdateData")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	
	if not self:IsShowingMinimapBar() then
		self.db.profile.minimapBar = not self.db.profile.minimapBar
		self:ToggleShowingMinimapBar()
	end
	
	if not self:IsShowingMapCoords() then
		self.db.profile.showMapCoords = not self.db.profile.showMapCoords
		self:ToggleShowingMapCoords()
	end
	
	local x, y = GetPlayerMapPosition("player")
	if x == 0 and y == 0 then -- instance
		self:ScheduleRepeatingEvent("LocationFu", self.UpdateDisplay, 60, self)
	else
		self:ScheduleRepeatingEvent("LocationFu", self.UpdateDisplay, 0.1, self)
	end
end

function LocationFu:OnDisable()
	if not self:IsShowingMinimapBar() then
		self:ToggleShowingMinimapBar()
		self.db.profile.minimapBar = not self.db.profile.minimapBar
	end
	if self:IsShowingMapCoords() then
		self:ToggleShowingMapCoords()
		self.db.profile.showMapCoords = not self.db.profile.showMapCoords
	end
	LocationFuMapFrameText:SetText("")
end

local options = {
	type = 'group',
	args = {
		map = {
			order = 97,
			type = 'execute',
			name = L"Open world map",
			desc = L"Open world map",
			func = function() ToggleWorldMap() end
		},
		atlas = {
			order = 98,
			type = 'execute',
			name = L"Open Atlas",
			desc = L"Open Atlas",
			func = function() Atlas_Toggle() end,
			hidden = function() return not Atlas_Toggle end,
		},
		["-blank-"] = {
			order = 99,
			type = 'header',
		},
		coords = {
			type = 'toggle',
			name = L"Show coordinates",
			desc = L"Toggle the coordinates in the text of this plugin",
			get = "IsShowingCoords",
			set = "ToggleShowingCoords",
		},
		subzone = {
			type = 'toggle',
			name = L"Show subzone name",
			desc = L"Show subzone name",
			get = "IsShowingSubZoneName",
			set = "ToggleShowingSubZoneName",
		},
		zone = {
			type = 'toggle',
			name = L"Show zone name",
			desc = L"Toggle the zone name in the text of this plugin",
			get = "IsShowingZoneName",
			set = "ToggleShowingZoneName",
		},
		levelRange = {
			type = 'toggle',
			name = L"Show level range",
			desc = L"Show level range",
			get = "IsShowingLevelRange",
			set = "ToggleShowingLevelRange",
		},
		minimapBar = {
			type = 'toggle',
			name = L"Show minimap bar",
			desc = L"Show the bar above the minimap that tells the location and allows you to close minimap",
			get = "IsShowingMinimapBar",
			set = "ToggleShowingMinimapBar",
		},
		mapCoords = {
			type = 'toggle',
			name = L"Show coodinates on map",
			desc = L"Show the coordinates of your cursor and your player on the world map",
			get = "IsShowingMapCoords",
			set = "ToggleShowingMapCoords",
		},
		overlay = {
			type = 'toggle',
			name = L"Show map overlay",
			desc = L"Show the overlay on the map which shows the level range and instances available",
			get = "IsShowingMapOverlay",
			set = "ToggleShowingMapOverlay",
		},
		recommend = {
			type = 'toggle',
			name = L"Show recommended zones",
			desc = L"Show your recommended zones in the tooltip",
			get = "IsShowingRecommendedZones",
			set = "ToggleShowingRecommendedZones",
		},
	}
}
LocationFu:RegisterChatCommand(L:GetTable("AceConsole-options"), options)
LocationFu.OnMenuRequest = options

function LocationFu:ZONE_CHANGED_NEW_AREA()
	SetMapToCurrentZone()
	self:UpdateData()
end

function LocationFu:PLAYER_ENTERING_WORLD()
	self:UpdateData()
	local x, y = GetPlayerMapPosition("player")
	if x == 0 and y == 0 then -- instance
		self:ScheduleRepeatingEvent("LocationFu", self.UpdateDisplay, 60, self)
	else
		self:ScheduleRepeatingEvent("LocationFu", self.UpdateDisplay, 0.1, self)
	end
	self:UpdateDisplay()
end

local subZoneText, zoneText, zoneColor, pvpType, isArena

function LocationFu:OnDataUpdate()
	subZoneText = GetSubZoneText()
	zoneText = GetZoneText()
	if subZoneText == "" then
		subZoneText = zoneText
	end
	zoneColor = "YELLOW"
	pvpType,_,isArena = GetZonePVPInfo()
	local faction = UnitFactionGroup("player")
	if isArena or pvpType == "hostile" then
		zoneColor = "RED"
	elseif pvpType == "friendly" then
		zoneColor = "GREEN"
	elseif Tourist:IsHostile(zoneText) then
		zoneColor = "RED"
	elseif Tourist:IsFriendly(zoneText) then
		zoneColor = "GREEN"
	end
	if Atlas_Toggle and Tourist:IsInstance(zoneText) then
		self:SetIcon("Interface\\AddOns\\Atlas\\Images\\AtlasIcon")
	else
		self:SetIcon(true)
	end
end

local t = {}
function LocationFu:OnTextUpdate()
	local text
	local r, g, b = Tourist:GetFactionColor(zoneText)
	if self:IsShowingZoneName() and self:IsShowingSubZoneName() then
		if subZoneText == zoneText then
			table_insert(t, string.format("|cff%02x%02x%02x%s|r", r*255, g*255, b*255, zoneText))
		else
			table_insert(t, string.format("|cff%02x%02x%02x%s: %s|r", r*255, g*255, b*255, zoneText, subZoneText))
		end
	elseif self:IsShowingZoneName() then
		table_insert(t, string.format("|cff%02x%02x%02x%s|r", r*255, g*255, b*255, zoneText))
	elseif self:IsShowingSubZoneName() then
		table_insert(t, string.format("|cff%02x%02x%02x%s|r", r*255, g*255, b*255, subZoneText))
	end
	local x, y = GetPlayerMapPosition("player")
	if self:IsShowingCoords() and x ~= 0 and y ~= 0 then
		table_insert(t, string.format("|cff%02x%02x%02x(%.0f, %.0f)|r", r*255, g*255, b*255, x * 100, y * 100))
	end
	local low, high = Tourist:GetLevel(zoneText)
	if self:IsShowingLevelRange() and low > 0 and high > 0 then
		local r, g, b = Tourist:GetLevelColor(zoneText)
		table_insert(t, string.format("|cff%02x%02x%02x[%d-%d]|r", r*255, g*255, b*255, low, high))
	end
	self:SetText(table.concat(t, " "))
	for k in pairs(t) do
		t[k] = nil
	end
	table.setn(t, 0)
end

function LocationFu:OnTooltipUpdate()
	local cat = Tablet:AddCategory(
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 1
	)
	
	cat:AddLine(
		'text', L"Zone:",
		'text2', zoneText
	)
	
	if subZoneText ~= zoneText then
		cat:AddLine(
			'text', L"Subzone:",
			'text2', subZoneText
		)
	end
	
	local text
	local r, g, b = 1, 1, 0
	if isArena then
		text = L"Arena"
		g = 0
	elseif zoneColor == "GREEN" then
		text = L"Friendly"
		r = 0
	elseif zoneColor == "YELLOW" then
		text = L"Contested"
	elseif zoneColor == "RED" then
		text = L"Hostile"
		g = 0
	end
	
	cat:AddLine(
		'text', L"Status:",
		'text2', text,
		'text2R', r,
		'text2G', g,
		'text2B', b
	)
	
	local x, y = GetPlayerMapPosition("player")
	cat:AddLine(
		'text', L"Coordinates:",
		'text2', string.format("%.0f, %.0f", x*100, y*100)
	)
	
	local low, high = Tourist:GetLevel(zoneText)
	if low >= 1 and high >= 1 then
		local r, g, b = Tourist:GetLevelColor(zoneText)
		cat:AddLine(
			'text', L"Level range:",
			'text2', string.format("%d-%d", low, high),
			'text2R', r,
			'text2G', g,
			'text2B', b
		)
	end
	
	if Tourist:DoesZoneHaveInstances(zoneText) then
		cat = Tablet:AddCategory(
			'columns', 2,
			'text', L"Instances",
			'child_textR', 1,
			'child_textG', 1,
			'child_textB', 0
		)
		
		for instance in Tourist:IterateZoneInstances(zoneText) do
			local low, high = Tourist:GetLevel(instance)
			local r, g, b = Tourist:GetLevelColor(instance)
			cat:AddLine(
				'text', instance,
				'text2', string.format("%d-%d", low, high),
				'text2R', r,
				'text2G', g,
				'text2B', b
			)
		end
	end
	if self:IsShowingRecommendedZones() then
		cat = Tablet:AddCategory(
			'columns', 2,
			'text', L"Recommended zones"
		)
		
		for zone in Tourist:IterateRecommendedZones() do
			local low, high = Tourist:GetLevel(zone)
			local r1, g1, b1 = Tourist:GetFactionColor(zone)
			local r2, g2, b2 = Tourist:GetLevelColor(zone)
			cat:AddLine(
				'text', zone,
				'textR', r1,
				'textG', g1,
				'textB', b1,
				'text2', string.format("%d-%d", low, high),
				'text2R', r2,
				'text2G', g2,
				'text2B', b2
			)
		end
		
		if Tourist:HasRecommendedInstances() then
			cat = Tablet:AddCategory(
				'columns', 2,
				'text', L"Recommended instances"
			)
			
			for instance in Tourist:IterateRecommendedInstances() do
				local low, high = Tourist:GetLevel(instance)
				local r1, g1, b1 = Tourist:GetFactionColor(instance)
				local r2, g2, b2 = Tourist:GetLevelColor(instance)
				cat:AddLine(
					'text', instance,
					'textR', r1,
					'textG', g1,
					'textB', b1,
					'text2', string.format("%d-%d", low, high),
					'text2R', r2,
					'text2G', g2,
					'text2B', b2
				)
			end
		end
	end
	
	if Atlas_Toggle then
		if Tourist:IsInstance(zoneText) then
			Tablet:SetHint(L"Atlas-hint" .. "\n" .. L"Shift-hint" .. "\n" .. L"Ctrl-hint")
		else
			Tablet:SetHint(L"Standard-hint" .. "\n" .. L"Shift-hint" .. "\n" .. L"Ctrl-Atlas-hint")
		end
	else
		Tablet:SetHint(L"Standard-hint" .. "\n" .. L"Shift-hint")
	end
end

local lastZone

function LocationFu.MapFrame_OnUpdate(t)
	local self = LocationFu
	if self:IsActive() then
		if self:IsShowingMapCoords() then
			local OFFSET_X = 0.0022
			local OFFSET_Y = -0.0262
			
			local x, y = GetCursorPosition()
			x = x / WorldMapFrame:GetScale()
			y = y / WorldMapFrame:GetScale()
		
			local px, py = GetPlayerMapPosition("player")
			local centerX, centerY = WorldMapFrame:GetCenter()
			local width = WorldMapButton:GetWidth()
			local height = WorldMapButton:GetHeight()
			local adjustedX = (x - (centerX - (width/2))) / width
			local adjustedY = (centerY + (height/2) - y ) / height
			local cx = (adjustedX + OFFSET_X)
			local cy = (adjustedY + OFFSET_Y)
			
			local cursorCoordsText = string.format("%.0f, %.0f", 100 * cx, 100 * cy)
			local playerCoordsText = string.format("%.0f, %.0f", 100 * px, 100 * py);			
			LocationFuMapFrameCursorCoords:SetText(format("%s: %.0f, %.0f", L"Cursor:", 100 * cx, 100 * cy))
			LocationFuMapFramePlayerCoords:SetText(format("%s: %.0f, %.0f", L"Player:", 100 * px, 100 * py))
		end
		
		if self:IsShowingMapOverlay() then
			local underAttack = false
			local zone = WorldMapFrameAreaLabel:GetText()
			if zone then
				zone = string.gsub(WorldMapFrameAreaLabel:GetText(), " |cff.+$", "")
				if WorldMapFrameAreaDescription:GetText() then
					underAttack = true
					zone = string.gsub(WorldMapFrameAreaDescription:GetText(), " |cff.+$", "")
				end
			end
			if GetCurrentMapContinent() == 0 then
				local c1, c2 = GetMapContinents()
				if zone == c1 or zone == c2 then
					WorldMapFrameAreaLabel:SetTextColor(1, 1, 1)
					LocationFuMapFrameText:SetText("")
					return
				end
			end
			if not zone or not Tourist:IsZoneOrInstance(zone) then
				zone = WorldMapFrame.areaName
			end
			WorldMapFrameAreaLabel:SetTextColor(1, 1, 1)
			if zone ~= nil and Tourist:IsZoneOrInstance(zone) then
				if not underAttack then
					WorldMapFrameAreaLabel:SetTextColor(Tourist:GetFactionColor(zone))
					WorldMapFrameAreaDescription:SetTextColor(1, 1, 1)
				else
					WorldMapFrameAreaLabel:SetTextColor(1, 1, 1)
					WorldMapFrameAreaDescription:SetTextColor(Tourist:GetFactionColor(zone))
				end
				local low, high = Tourist:GetLevel(zone)
				if low ~= nil and high ~= nil and low ~= -6 and high ~= -6 then
					local r, g, b = Tourist:GetLevelColor(zone)
					if not underAttack then
						local text = string.gsub(WorldMapFrameAreaLabel:GetText(), " |cff.+$", "")
						text = text .. string.format(" |cff%02x%02x%02x(%d-%d)|r", r * 255, g * 255, b * 255, low, high)
						WorldMapFrameAreaLabel:SetText(text)
					else
						local text = string.gsub(WorldMapFrameAreaDescription:GetText(), " |cff.+$", "")
						text = text .. string.format(" |cff%02x%02x%02x(%d-%d)|r", r * 255, g * 255, b * 255, low, high)
						WorldMapFrameAreaDescription:SetText(text)
					end
				end
				
				if Tourist:DoesZoneHaveInstances(zone) then
					if lastZone ~= zone then
						lastZone = zone
						local mapText = string.format("|cffffff00%s:|r", L"Instances")
						for instance in Tourist:IterateZoneInstances(zone) do
							local low, high = Tourist:GetLevel(instance)
							local r1, g1, b1 = Tourist:GetFactionColor(instance)
							local r2, g2, b2 = Tourist:GetLevelColor(instance)
							mapText = mapText .. "\n" .. string.format("|cff%02x%02x%02x%s|r |cff%02x%02x%02x(%d-%d)|r", r1 * 255, g1 * 255, b1 * 255, instance, r2 * 255, g2 * 255, b2 * 255, low, high)
						end
						LocationFuMapFrameText:SetText(mapText)
					end
				else
					lastZone = nil
					LocationFuMapFrameText:SetText("")
				end
			elseif zone == nil then
				lastZone = nil
				LocationFuMapFrameText:SetText("")
			end
		end
	end
end

function LocationFu:OnClick()
	if IsShiftKeyDown() then
		if ChatFrameEditBox:IsVisible() then
			local x, y = GetPlayerMapPosition("player")
			local message
			local coords = string.format("%.0f, %.0f", x * 100, y * 100)
			if not self:IsShowingZoneName() and not self:IsShowingSubZoneName() then
				message = coords
			elseif self:IsShowingZoneName() and self:IsShowingSubZoneName() then
				if zoneText ~= subZoneText then
					message = string.format("%s: %s (%s)", zoneText, subZoneText, coords)
				else
					message = string.format("%s (%s)", zoneText, coords)
				end
			elseif self:IsShowingZoneName() then
				message = string.format("%s (%s)", zoneText, coords)
			elseif self:IsShowingSubZoneName() then
				message = string.format("%s (%s)", subZoneText, coords)
			end
			ChatFrameEditBox:Insert(message)
		end
	elseif Atlas_Toggle then
		if IsControlKeyDown() then
			if not Tourist:IsInstance(zoneText) then
				Atlas_Toggle()
			else
				ToggleWorldMap()
			end
		else
			if Tourist:IsInstance(zoneText) then
				Atlas_Toggle()
			else
				ToggleWorldMap()
			end
		end
	else
		ToggleWorldMap()
	end
end
