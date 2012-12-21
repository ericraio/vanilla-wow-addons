--[[
Name: Jostle-2.0
Revision: $Rev: 9867 $
Author(s): ckknight (ckknight@gmail.com)
Website: http://ckknight.wowinterface.com/
Documentation: http://wiki.wowace.com/index.php/Jostle-2.0
SVN: http://svn.wowace.com/root/trunk/JostleLib/Jostle-2.0
Description: A library to handle rearrangement of blizzard's frames when bars are added to the sides of the screen.
Dependencies: AceLibrary, AceOO-2.0, AceEvent-2.0
]]

local MAJOR_VERSION = "Jostle-2.0"
local MINOR_VERSION = "$Revision: 9867 $"

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

local AceEvent

local Jostle = {}
local blizzardFrames = {
	'PlayerFrame',
	'TargetFrame',
	'MinimapCluster',
	'PartyMemberFrame1',
	'TicketStatusFrame',
	'WorldStateAlwaysUpFrame',
	'MainMenuBar',
	'MultiBarRight',
	'CT_PlayerFrame_Drag',
	'CT_TargetFrame_Drag',
	'Gypsy_PlayerFrameCapsule',
	'Gypsy_TargetFrameCapsule',
	'TemporaryEnchantFrame',
	'DEFAULT_CHAT_FRAME',
	'ChatFrame2',
	'GroupLootFrame1',
	'TutorialFrameParent',
	'FramerateLabel',
	'QuestTimerFrame',
	'DurabilityFrame',
	'CastingBarFrame',
}
local blizzardFramesData = {}

local _G = getfenv(0)

function Jostle:PLAYER_AURAS_CHANGED()
	self:ScheduleEvent(self.Refresh, 0, self)
end

function Jostle:AceEvent_FullyInitialized()
	for k,v in pairs(blizzardFramesData) do
		blizzardFramesData[k] = nil
	end
	self:ScheduleEvent(self.Refresh, 0, self)
end

function Jostle:ToggleWorldMap(orig)
	orig()
	self:Refresh()
end

function Jostle:TicketStatusFrame_OnEvent(orig)
	orig()
	self:Refresh(TicketStatusFrame, TemporaryEnchantFrame)
end

function Jostle:FCF_UpdateDockPosition(orig)
	orig()
	self:Refresh(DEFAULT_CHAT_FRAME)
end

function Jostle:FCF_UpdateCombatLogPosition(orig)
	orig()
	self:Refresh(ChatFrame2)
end

function Jostle:UIParent_ManageFramePositions(orig)
	orig()
	self:Refresh(GroupLootFrame1, TutorialFrameParent, FramerateLabel, QuestTimerFrame, DurabilityFrame)
end

function Jostle:WorldMapFrameCloseButton_OnClick(orig)
	orig()
	self:Refresh()
end

function Jostle:UIParent_ManageRightSideFrames(orig)
	for _,frame in ipairs(blizzardFrames) do
		frame = _G[frame]
		local frameData = blizzardFramesData[frame]
		if frameData and not (frameData.lastX and frameData.lastY and (frameData.lastX ~= frame:GetLeft() or frameData.lastY ~= frame:GetTop())) then
			frameData.lastX = nil
			frameData.lastY = nil
		end
	end
	orig()
	self:Refresh()
end

function Jostle:GetScreenTop()
	local bottom = GetScreenHeight()
	for _,frame in ipairs(self.topFrames) do
		if frame.IsVisible and frame:IsVisible() and frame.GetBottom and frame:GetBottom() and frame:GetBottom() < bottom then
			bottom = frame:GetBottom()
		end
	end
	return bottom
end

function Jostle:GetScreenBottom()
	local top = 0
	for _,frame in ipairs(self.bottomFrames) do
		if frame.IsVisible and frame:IsVisible() and frame.GetTop and frame:GetTop() and frame:GetTop() > top then
			top = frame:GetTop()
		end
	end
	return top
end

function Jostle:RegisterTop(frame)
	for k,f in ipairs(self.bottomFrames) do
		if f == frame then
			table.remove(self.bottomFrames, k)
			break
		end
	end
	for _,f in ipairs(self.topFrames) do
		if f == frame then
			return
		end
	end
	table.insert(self.topFrames, frame)
	self:Refresh()
	return true
end

function Jostle:RegisterBottom(frame)
	for k,f in ipairs(self.topFrames) do
		if f == frame then
			table.remove(self.topFrames, k)
			break
		end
	end
	for _,f in ipairs(self.bottomFrames) do
		if f == frame then
			return
		end
	end
	table.insert(self.bottomFrames, frame)
	self:Refresh()
	return true
end

function Jostle:Unregister(frame)
	for k,f in ipairs(self.topFrames) do
		if f == frame then
			table.remove(self.topFrames, k)
			self:Refresh()
			return true
		end
	end
	for k,f in ipairs(self.bottomFrames) do
		if f == frame then
			table.remove(self.bottomFrames, k)
			self:Refresh()
			return true
		end
	end
end

function Jostle:IsTopAdjusting()
	return self.topAdjust
end

function Jostle:EnableTopAdjusting()
	if not self.topAdjust then
		self.topAdjust = not self.topAdjust
		self:Refresh()
	end
end

function Jostle:DisableTopAdjusting()
	if self.topAdjust then
		self.topAdjust = not self.topAdjust
		self:Refresh()
	end
end

function Jostle:IsBottomAdjusting()
	return self.bottomAdjust
end

function Jostle:EnableBottomAdjusting()
	if not self.bottomAdjust then
		self.bottomAdjust = not self.bottomAdjust
		self:Refresh()
	end
end

function Jostle:DisableBottomAdjusting()
	if self.bottomAdjust then
		self.bottomAdjust = not self.bottomAdjust
		self:Refresh()
	end
end

local function getsecond(_, value)
	return value
end

local tmp = {}
function Jostle:Refresh(f1, f2, f3, f4, f5, f6, f7, f8)
	if not AceEvent then
		self:error("%s requires AceEvent-2.0", MAJOR_VERSION)
	end
	if not AceEvent:IsFullyInitialized() then
		return
	end
	local frames
	if f1 then
		for k in pairs(tmp) do
			tmp[k] = nil
		end
		tmp.n = 0
		table.insert(tmp, f1)
		table.insert(tmp, f2)
		table.insert(tmp, f3)
		table.insert(tmp, f4)
		table.insert(tmp, f5)
		table.insert(tmp, f6)
		table.insert(tmp, f7)
		table.insert(tmp, f8)
		frames = tmp
	else
		frames = blizzardFrames
	end
	local screenHeight = GetScreenHeight()
	for _,frame in ipairs(frames) do
		if type(frame) == "string" then
			frame = _G[frame]
		end
		if frame and not blizzardFramesData[frame] and frame.GetTop and frame:GetCenter() and getsecond(frame:GetCenter()) then
			if getsecond(frame:GetCenter()) <= screenHeight / 2 or frame == MultiBarRight then
				blizzardFramesData[frame] = {y = frame:GetBottom(), top = false}
			else
				blizzardFramesData[frame] = {y = frame:GetTop() - screenHeight, top = true}
			end
		end
	end
	
	local topOffset = self:IsTopAdjusting() and self:GetScreenTop() or GetScreenHeight()
	local bottomOffset = self:IsBottomAdjusting() and self:GetScreenBottom() or 0
	
	for _,frame in ipairs(frames) do
		if type(frame) == "string" then
			frame = _G[frame]
		end
		if ((frame and frame.IsUserPlaced and not frame:IsUserPlaced()) or ((frame == DEFAULT_CHAT_FRAME or frame == ChatFrame2) and SIMPLE_CHAT == "1") or frame == FramerateLabel) and (frame ~= ChatFrame2 or SIMPLE_CHAT == "1") then
			local frameData = blizzardFramesData[frame]
			if (getsecond(frame:GetPoint(1)) ~= UIParent and getsecond(frame:GetPoint(1)) ~= WorldFrame) then
				-- do nothing
			elseif frame == PlayerFrame and (CT_PlayerFrame_Drag or Gypsy_PlayerFrameCapsule) then
				-- do nothing
			elseif frame == TargetFrame and (CT_TargetFrame_Drag or Gypsy_TargetFrameCapsule) then
				-- do nothing
			elseif frame == PartyMemberFrame1 and (CT_MovableParty1_Drag or Gypsy_PartyFrameCapsule) then
				-- do nothing
			elseif frame == MainMenuBar and Gypsy_HotBarCapsule then
				-- do nothing
			elseif frame == DurabilityFrame and DurabilityFrame:IsShown() and (DurabilityFrame:GetLeft() > GetScreenWidth() or DurabilityFrame:GetRight() < 0 or DurabilityFrame:GetBottom() > GetScreenHeight() or DurabilityFrame:GetTop() < 0) then
				DurabilityFrame:Hide()
			elseif frame == FramerateLabel and ((frameData.lastX and frameData.lastX ~= frame:GetLeft()) or WorldFrame:GetHeight() ~= UIParent:GetHeight())  then
				-- do nothing
			elseif frame == TemporaryEnchantFrame or frame == CastingBarFrame or frame == TutorialFrameParent or frame == FramerateLabel or frame == QuestTimerFrame or frame == DurabilityFrame or frame == QuestWatchFrame or not (frameData.lastX and frameData.lastY and (frameData.lastX ~= frame:GetLeft() or frameData.lastY ~= frame:GetTop())) then
				local anchor
				local anchorAlt
				local width, height = GetScreenWidth(), GetScreenHeight()
				local x
				if frame:GetRight() and frame:GetLeft() then
					local anchorFrame = UIParent
					if frame == MainMenuBar or frame == GroupLootFrame1 then
						x = 0
						anchor = ""
					elseif frame:GetRight() <= width / 2 then
						x = frame:GetLeft()
						anchor = "LEFT"
					else
						x = frame:GetRight() - width
						anchor = "RIGHT"
					end
					local y = blizzardFramesData[frame].y
					local offset = 0
					if blizzardFramesData[frame].top then
						anchor = "TOP" .. anchor
						offset = topOffset - screenHeight
					else
						anchor = "BOTTOM" .. anchor
						offset = bottomOffset
					end
					if frame == MinimapCluster and not MinimapBorderTop:IsShown() then
						offset = offset + MinimapBorderTop:GetHeight() * 3/5
					elseif frame == TemporaryEnchantFrame and TicketStatusFrame:IsVisible() then
						offset = offset - TicketStatusFrame:GetHeight()
					elseif frame == DEFAULT_CHAT_FRAME then
						y = MainMenuBar:GetHeight() + 32
						if PetActionBarFrame:IsVisible() or ShapeshiftBarFrame:IsVisible() then
							offset = offset + ShapeshiftBarFrame:GetHeight()
						end
						if MultiBarBottomLeft:IsVisible() then
							offset = offset + MultiBarBottomLeft:GetHeight() - 21
						end
					elseif frame == ChatFrame2 then
						y = MainMenuBar:GetHeight() + 32
						if MultiBarBottomRight:IsVisible() then
							offset = offset + MultiBarBottomRight:GetHeight() - 21
						end
					elseif frame == CastingBarFrame then
						y = MainMenuBar:GetHeight() + 17
						if PetActionBarFrame:IsVisible() or ShapeshiftBarFrame:IsVisible() then
							offset = offset + ShapeshiftBarFrame:GetHeight()
						end
						if MultiBarBottomLeft:IsVisible() or MultiBarBottomRight:IsVisible() then
							offset = offset + MultiBarBottomLeft:GetHeight()
						end
					elseif frame == GroupLootFrame1 or frame == TutorialFrameParent or frame == FramerateLabel then
						if MultiBarBottomLeft:IsVisible() or MultiBarBottomRight:IsVisible() then
							offset = offset + MultiBarBottomLeft:GetHeight()
						end
					elseif frame == QuestTimerFrame or frame == DurabilityFrame or frame == QuestWatchFrame then
						anchorFrame = MinimapCluster
						x = 0
						y = 0
						offset = 0
						if frame ~= QuestTimerFrame and QuestTimerFrame:IsVisible() then
							y = y - QuestTimerFrame:GetHeight()
						end
						if frame == QuestWatchFrame and DurabilityFrame:IsVisible() then
							y = y - DurabilityFrame:GetHeight()
						end
						if frame == DurabilityFrame then
							x = -20
						end
						anchor = "TOPRIGHT"
						anchorAlt = "BOTTOMRIGHT"
						if MultiBarRight:IsVisible() then
							x = x - MultiBarRight:GetWidth()
							if MultiBarLeft:IsVisible() then
								x = x - MultiBarLeft:GetWidth()
							end
						end
					end
					if frame == FramerateLabel then
						anchorFrame = WorldFrame
					end
					frame:ClearAllPoints()
					frame:SetPoint(anchor, anchorFrame, anchorAlt or anchor, x, y + offset)
					blizzardFramesData[frame].lastX = frame:GetLeft()
					blizzardFramesData[frame].lastY = frame:GetTop()
				end
			end
		end
	end
end

local function activate(self, oldLib, oldDeactivate)
	Jostle = self
	if oldLib then
		self.hooks = oldLib.hooks
		self.topFrames = oldLib.topFrames
		self.bottomFrames = oldLib.bottomFrames
		self.topAdjust = oldLib.topAdjust
		self.bottomAdjust = oldLib.bottomAdjust
	end
	
	if not self.hooks then
		self.hooks = {}
	end
	if not self.topFrames then
		self.topFrames = {}
	end
	if not self.bottomFrames then
		self.bottomFrames = {}
	end
	if self.topAdjust == nil then
		self.topAdjust = true
	end
	if self.bottomAdjust == nil then
		self.bottomAdjust = true
	end
	
	if not self.hooks.ToggleWorldMap then
		self.hooks.ToggleWorldMap = true
		local orig = ToggleWorldMap
		function ToggleWorldMap()
			if self.ToggleWorldMap then
				return self.ToggleWorldMap(self, orig)
			else
				return orig()
			end
		end
	end
	
	if not self.hooks.WorldMapFrameCloseButton_OnClick then
		self.hooks.WorldMapFrameCloseButton_OnClick = true
		local orig = WorldMapFrameCloseButton:GetScript("OnClick")
		WorldMapFrameCloseButton:SetScript("OnClick", function()
			if self.WorldMapFrameCloseButton_OnClick then
				return self.WorldMapFrameCloseButton_OnClick(self, orig)
			else
				return orig()
			end
		end)
	end
	
	if not self.hooks.TicketStatusFrame_OnEvent then
		self.hooks.TicketStatusFrame_OnEvent = true
		local orig = TicketStatusFrame_OnEvent
		function TicketStatusFrame_OnEvent()
			if self.TicketStatusFrame_OnEvent then
				return self.TicketStatusFrame_OnEvent(self, orig)
			else
				return orig()
			end
		end
	end
	
	if not self.hooks.FCF_UpdateDockPosition then
		self.hooks.FCF_UpdateDockPosition = true
		local orig = FCF_UpdateDockPosition
		function FCF_UpdateDockPosition()
			if self.FCF_UpdateDockPosition then
				return self.FCF_UpdateDockPosition(self, orig)
			else
				return orig()
			end
		end
	end
	
	if not self.hooks.FCF_UpdateCombatLogPosition then
		self.hooks.FCF_UpdateCombatLogPosition = true
		local orig = FCF_UpdateCombatLogPosition
		function FCF_UpdateCombatLogPosition()
			if self.FCF_UpdateCombatLogPosition then
				return self.FCF_UpdateCombatLogPosition(self, orig)
			else
				return orig()
			end
		end
	end
	
	if not self.hooks.UIParent_ManageFramePositions then
		self.hooks.UIParent_ManageFramePositions = true
		local orig = UIParent_ManageFramePositions
		function UIParent_ManageFramePositions()
			if self.UIParent_ManageFramePositions then
				return self.UIParent_ManageFramePositions(self, orig)
			else
				return orig()
			end
		end
	end
	
	if not self.hooks.UIParent_ManageRightSideFrames then
		self.hooks.UIParent_ManageRightSideFrames = true
		local orig = UIParent_ManageRightSideFrames
		function UIParent_ManageRightSideFrames()
			if self.UIParent_ManageRightSideFrames then
				return self.UIParent_ManageRightSideFrames(self, orig)
			else
				return orig()
			end
		end
	end
	
	if oldDeactivate then
		oldDeactivate(oldLib)
	end
end

local function external(self, major, instance)
	if major == "AceEvent-2.0" then
		AceEvent = instance
		instance:embed(self)
		
		self:UnregisterAllEvents()
		self:CancelAllScheduledEvents()
		self:RegisterEvent("PLAYER_AURAS_CHANGED")
		if instance:IsFullyInitialized() then
			self:ScheduleEvent(self.Refresh, 0, self)
		else
			self:RegisterEvent("AceEvent_FullyInitialized")
		end
	end
end

AceLibrary:Register(Jostle, MAJOR_VERSION, MINOR_VERSION, activate, nil, external)
