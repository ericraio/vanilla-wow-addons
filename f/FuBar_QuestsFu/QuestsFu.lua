local tablet = AceLibrary("Tablet-2.0")
local compost = AceLibrary("Compost-2.0")
local deformat = AceLibrary("Deformat-2.0")
local babbleclass = AceLibrary("Babble-Class-2.0")
local crayon = AceLibrary("Crayon-2.0")
local tourist = AceLibrary("Tourist-2.0")

local L = AceLibrary("AceLocale-2.0"):new("QuestsFu")

QuestsFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceHook-2.0", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")
QuestsFu:RegisterDB("QuestsFuDB")
QuestsFu:RegisterDefaults('profile', {
	showLevelsGame = true,
	showLevelsTablet = true,
	showLevelsZone = true,
	showDifficulty = true,
	showImpossible = true,
	showArea = true,
	showCurrentAreaOnly = false,
	showClassAnyway = true,
	showCurrentAreaDescriptionOnly = false,
	showDescription = true,
	showCompletedObjectives = false,
	showInItemTooltip = true,
	colorObjectives = true,
	wrapQuests = true,
	showTextOpt = {
		total = true,
		current = true,
		complete = false,
		lastmessage = true,
	},
})
QuestsFu:RegisterDefaults('char', {
	hidden = {},
	watchedQuests = {},
})

QuestsFu.version = "2.0." .. string.sub("$Revision: 10107 $", 12, -3)
QuestsFu.date = string.sub("$Date: 2006-09-04 13:31:04 -0700 (Mon, 04 Sep 2006) $", 8, 17)
QuestsFu.hasIcon = true
QuestsFu.clickableTooltip = true
QuestsFu.cannotHideText = true

local optionsTable = {
	handler = QuestsFu,
	type = 'group',
	args = {
		show = {
			type = 'group', 
			name = L["OPT_show"],
			desc = L["OPT_show_d"],
			args = {
				text = {
					type = 'group', 
					name = L["OPT_text"],
					desc = L["OPT_text_d"],
					args = {
						current = {
							type = 'toggle', 
							name = L["OPT_current"],
							desc = L["OPT_current_d"],
							get = "IsShowingTextCurrent",
							set = "ToggleShowingTextCurrent",
						},
						complete = {
							type = 'toggle', 
							name = L["OPT_complete"],
							desc = L["OPT_complete_d"],
							get = "IsShowingTextComplete",
							set = "ToggleShowingTextComplete",
						},
						total = {
							type = 'toggle', 
							name = L["OPT_total"],
							desc = L["OPT_total_d"],
							get = "IsShowingTextTotal",
							set = "ToggleShowingTextTotal",
						},
						lastmessage = {
							type = 'toggle', 
							name = L["OPT_lastmessage"],
							desc = L["OPT_lastmessage_d"],
							get = "IsShowingTextLastMessage",
							set = "ToggleShowingTextLastMessage",
						},
					}
				},
				levels = {
					type = 'group',
					name = L["OPT_levels"],
					desc = L["OPT_levels_d"],
					args = {
						game = {
							type = "toggle", name = L["OPT_levels_game"],
							desc = L["OPT_levels_game_d"],
							get = "IsShowingLevelsGame",
							set = "ToggleShowingLevelsGame",
						},
						tablet = {
							type = "toggle", name = L["OPT_levels_tablet"],
							desc = L["OPT_levels_tablet_d"],
							get = "IsShowingLevelsTablet",
							set = "ToggleShowingLevelsTablet",
						},
						zone = {
							type = "toggle", name = L["OPT_levels_zone"],
							desc = L["OPT_levels_zone_d"],
							get = "IsShowingLevelsZone",
							set = "ToggleShowingLevelsZone",
						},
					},
				},
				diff = {
					type = 'toggle', 
					name = L["OPT_diff"],
					desc = L["OPT_diff_d"],
					get = "IsShowingDifficulty",
					set = "ToggleShowingDifficulty",
				},
				impossible = {
					type = 'toggle', 
					name = L["OPT_impossible"],
					desc = L["OPT_impossible_d"],
					get = "IsShowingImpossible",
					set = "ToggleShowingImpossible",
				},
				area = {
					type = 'toggle', 
					name = L["OPT_area"],
					desc = L["OPT_area_d"],
					get = "IsShowingArea",
					set = "ToggleShowingArea",
				},
				caonly = {
					type = 'toggle', 
					name = L["OPT_caonly"],
					desc = L["OPT_caonly_d"],
					get = "IsShowingCurrentAreaOnly",
					set = "ToggleShowingCurrentAreaOnly",
				},
				classanyway = {
					type = 'toggle', 
					name = L["OPT_classanyway"],
					desc = L["OPT_classanyway_d"],
					get = "IsShowingClassAnyway",
					set = "ToggleShowingClassAnyway",
				},
				description = {
					type = 'toggle', 
					name = L["OPT_description"],
					desc = L["OPT_description_d"],
					get = "IsShowingDescription",
					set = "ToggleShowingDescription",
				},
				cadonly = {
					type = 'toggle', 
					name = L["OPT_cadonly"],
					desc = L["OPT_cadonly_d"],
					get = "IsShowingCurrentAreaDescriptionOnly",
					set = "ToggleShowingCurrentAreaDescriptionOnly",
				},
				completed= {
					type = 'toggle', 
					name = L["OPT_completed"],
					desc = L["OPT_completed_d"],
					get = "IsShowingCompletedObjectives",
					set = "ToggleShowingCompletedObjectives",
				},
				tooltip = {
					type = 'toggle', 
					name = L["OPT_tooltip"],
					desc = L["OPT_tooltip_d"],
					get = "IsShowingInItemTooltip",
					set = "ToggleShowingInItemTooltip",
				},
				colorobj = {
					type = 'toggle', 
					name = L["OPT_colorobj"],
					desc = L["OPT_colorobj_d"],
					get = "IsColoringObjectives",
					set = "ToggleColoringObjectives",
				},
				wrap = {
					type = 'toggle', 
					name = L["OPT_wrap"],
					desc = L["OPT_wrap_d"],
					get = "IsWrappingQuests",
					set = "ToggleWrappingQuests",
				},
			}
		}
	}
}

QuestsFu:RegisterChatCommand({"/questsfu", "/fuq" }, optionsTable)
QuestsFu.OnMenuRequest = optionsTable

function QuestsFu:ToggleShowingTextComplete()
	self.db.profile.showTextOpt.complete = not self.db.profile.showTextOpt.complete
	self:UpdateText()
	return self.db.profile.showTextOpt.complete
end
function QuestsFu:ToggleShowingTextCurrent()
	self.db.profile.showTextOpt.current = not self.db.profile.showTextOpt.current
	self:UpdateText()
	return self.db.profile.showTextOpt.current
end
function QuestsFu:ToggleShowingTextTotal()
	self.db.profile.showTextOpt.total = not self.db.profile.showTextOpt.total
	self:UpdateText()
	return self.db.profile.showTextOpt.total
end
function QuestsFu:ToggleShowingTextLastMessage()
	self.db.profile.showTextOpt.lastmessage = not self.db.profile.showTextOpt.lastmessage
	self:UpdateText()
	return self.db.profile.showTextOpt.lastmessage
end

function QuestsFu:IsShowingTextComplete()
	return self.db.profile.showTextOpt.complete
end
function QuestsFu:IsShowingTextCurrent()
	return self.db.profile.showTextOpt.current
end
function QuestsFu:IsShowingTextTotal()
	return self.db.profile.showTextOpt.total
end
function QuestsFu:IsShowingTextLastMessage()
	return self.db.profile.showTextOpt.lastmessage
end

function QuestsFu:IsShowingLevelsGame()
	return self.db.profile.showLevelsGame
end

function QuestsFu:IsShowingLevelsTablet()
	return self.db.profile.showLevelsTablet
end

function QuestsFu:IsShowingLevelsZone()
	return self.db.profile.showLevelsZone
end

function QuestsFu:ToggleShowingLevelsGame(silent)
	self.db.profile.showLevelsGame = not self.db.profile.showLevelsGame
	if self.db.profile.showLevelsGame then
		self:RegisterEvent("GOSSIP_SHOW", "OnGossipShow")
		self:RegisterEvent("QUEST_GREETING", "OnQuestGreeting")
		self:Hook("GetQuestLogTitle")
	else
		self:UnregisterEvent("GOSSIP_SHOW", "OnGossipShow")
		self:UnregisterEvent("QUEST_GREETING", "OnQuestGreeting")
		self:Unhook("GetQuestLogTitle")
	end
	self:UpdateData()
	return self.db.profile.showLevelsGame
end

function QuestsFu:ToggleShowingLevelsTablet(silent)
	self.db.profile.showLevelsTablet = not self.db.profile.showLevelsTablet
	self:UpdateTooltip()
	return self.db.profile.showLevelsTablet
end

function QuestsFu:ToggleShowingLevelsZone(silent)
	self.db.profile.showLevelsZone = not self.db.profile.showLevelsZone
	self:UpdateTooltip()
	return self.db.profile.showLevelsZone
end

function QuestsFu:IsShowingDifficulty()
	return self.db.profile.showDifficulty
end

function QuestsFu:ToggleShowingDifficulty(silent)
	self.db.profile.showDifficulty = not self.db.profile.showDifficulty
	self:UpdateTooltip()
	return self.db.profile.showDifficulty
end

function QuestsFu:IsShowingImpossible()
	return self.db.profile.showImpossible
end

function QuestsFu:ToggleShowingImpossible(silent)
	self.db.profile.showImpossible = not self.db.profile.showImpossible
	self:UpdateTooltip()
	return self.db.profile.showImpossible
end

function QuestsFu:IsShowingArea()
	return self.db.profile.showArea
end

function QuestsFu:ToggleShowingArea(silent)
	self.db.profile.showArea = not self.db.profile.showArea
	self:UpdateTooltip()
	return self.db.profile.showArea
end

function QuestsFu:IsShowingCurrentAreaOnly()
	return self.db.profile.showCurrentAreaOnly
end

function QuestsFu:ToggleShowingCurrentAreaOnly(silent)
	self.db.profile.showCurrentAreaOnly = not self.db.profile.showCurrentAreaOnly
	self:UpdateTooltip()
	return self.db.profile.showCurrentAreaOnly
end

function QuestsFu:IsShowingClassAnyway()
	return self.db.profile.showClassAnyway
end

function QuestsFu:ToggleShowingClassAnyway(silent)
	self.db.profile.showClassAnyway = not self.db.profile.showClassAnyway
	self:UpdateTooltip()
	return self.db.profile.showClassAnyway
end

function QuestsFu:IsShowingCurrentAreaDescriptionOnly()
	return self.db.profile.showCurrentAreaDescriptionOnly
end

function QuestsFu:ToggleShowingCurrentAreaDescriptionOnly(silent)
	self.db.profile.showCurrentAreaDescriptionOnly = not self.db.profile.showCurrentAreaDescriptionOnly
	self:UpdateTooltip()
	return self.db.profile.showCurrentAreaDescriptionOnly
end

function QuestsFu:IsShowingDescription()
	return self.db.profile.showDescription
end

function QuestsFu:ToggleShowingDescription(silent)
	self.db.profile.showDescription = not self.db.profile.showDescription
	self:UpdateTooltip()
	return self.db.profile.showDescription
end

function QuestsFu:IsColoringObjectives()
	return self.db.profile.colorObjectives
end

function QuestsFu:ToggleColoringObjectives(silent)
	self.db.profile.colorObjectives = not self.db.profile.colorObjectives
	self:UpdateTooltip()
	return self.db.profile.colorObjectives
end

function QuestsFu:IsShowingCompletedObjectives()
	return self.db.profile.showCompletedObjectives
end

function QuestsFu:ToggleShowingCompletedObjectives(silent)
	self.db.profile.showCompletedObjectives = not self.db.profile.showCompletedObjectives
	self:UpdateTooltip()
	return self.db.profile.showCompletedObjectives
end

function QuestsFu:IsShowingInItemTooltip()
	return self.db.profile.showInItemTooltip
end

function QuestsFu:ToggleShowingInItemTooltip(silent)
	self.db.profile.showInItemTooltip = not self.db.profile.showInItemTooltip
	self:UpdateTooltip()
	return self.db.profile.showInItemTooltip
end

function QuestsFu:IsWrappingQuests()
	return self.db.profile.wrapQuests
end

function QuestsFu:ToggleWrappingQuests(silent)
	self.db.profile.wrapQuests = not self.db.profile.wrapQuests
	self:UpdateTooltip()
	return self.db.profile.wrapQuests
end

function QuestsFu:OnInitialize()
	if type(self.db.profile.showText) == 'table' then
		--FuBarPlugin-2.0 appropriated .showText.  Switch it out.
		self.db.profile.showTextOps = self.db.profile.showText
		self.db.profile.showText = nil
	end
	
	self.numQuests = 0
	self.numEntries = 0
	self.zones = {}
	self.zone_quests = {}
	self.quests = {}
	self.items = {}
	self.mobs = {}
	self.lastuimessage = ""
	self.lastquestmessage = ""

	self.allowedToUpdate = true
	
	self.loadedWatchedQuests = false
end

function QuestsFu:OnEnable()
	self:RegisterEvent("QUEST_LOG_UPDATE", "OnQuestLogUpdate")
	self:RegisterEvent("PLAYER_LEVEL_UP", "UpdateTooltip") -- Quest difficulty colors can change on level; just redraw the tooltip in case they have it open while levelling.
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "UpdateTooltip")
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "OnMouseOverUnit")
	self:RegisterEvent("UI_INFO_MESSAGE","OnUIInfoMessage")
	self:Hook("ContainerFrameItemButton_OnEnter", "OnItemTooltip")
	self:Hook("AddQuestWatch", "OnAddQuestWatch")
	self:Hook("RemoveQuestWatch", "OnRemoveQuestWatch")
	
	self:ScheduleEvent(self.LoadWatchedQuests, 1, self)
	
	if self:IsShowingLevelsGame() then
		self:RegisterEvent("GOSSIP_SHOW", "OnGossipShow")
		self:RegisterEvent("QUEST_GREETING", "OnQuestGreeting")
		self:Hook("GetQuestLogTitle")
	end
end

function QuestsFu:Disable()
	metro:Unregister(self.name)
end

function QuestsFu:MakeTag(level, tag)
	if tag then
		if tag == L["ELITE"] then tag = L["TAG_ELITE"]
		elseif tag == L["DUNGEON"] then tag = L["TAG_DUNGEON"]
		elseif tag == L["PVP"] then tag = L["TAG_PVP"]
		elseif tag == L["RAID"] then tag = L["TAG_RAID"]
		end
	else
		tag = ''
	end
	return "[" .. level .. tag .. "] "
end

function QuestsFu:GetQuestLogTitle(index)
	local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete = self.hooks["GetQuestLogTitle"].orig(index)
	if not isHeader and level then
		if questLogTitleText then
			questLogTitleText = self:MakeTag(level, questTag) .. questLogTitleText
		end
	end
	return questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete
end

--This is pretty much how Minimalist does it, which it credits to AutoSelect.
function QuestsFu:OnGossipShow()
	local buttonindex = 1
	local list, button
	if (GetGossipAvailableQuests()) then
		list = compost:Acquire(GetGossipAvailableQuests())
		for i = 2,getn(list),2 do
			button = getglobal("GossipTitleButton"..(buttonindex))
			button:SetText(format('[%d] %s',list[i],list[i-1]))
			buttonindex = buttonindex + 1
		end
		buttonindex = buttonindex + 1
		compost:Reclaim(list)
	end
	if (GetGossipActiveQuests()) then
		list = compost:Acquire(GetGossipActiveQuests())
		for i = 2,getn(list),2 do
			button = getglobal("GossipTitleButton"..(buttonindex))
			button:SetText(format('[%d] %s',list[i],list[i-1]))
			buttonindex = buttonindex + 1
		end
		compost:Reclaim(list)
	end
end

--This is pretty much how Minimalist does it, which it credits to AutoSelect.
function QuestsFu:OnQuestGreeting()
	local numactive,numavailable = GetNumActiveQuests(), GetNumAvailableQuests()
	local title, level, button
	local o,GetTitle,GetLevel = 0,GetActiveTitle,GetActiveLevel
	for i=1, numactive + numavailable do
		if i == numactive + 1 then
			o,GetTitle,GetLevel = numactive,GetAvailableTitle,GetAvailableLevel
		end
		title,level = GetTitle(i-o), GetLevel(i-o)
		button = getglobal("QuestTitleButton"..i)
		button:SetText(format('[%d] %s',level,title))
	end
end

function QuestsFu:OnAddQuestWatch(id)
	self.hooks["AddQuestWatch"].orig(id)
	self:SaveWatchedQuests()
end

function QuestsFu:OnRemoveQuestWatch(id)
	self.hooks["RemoveQuestWatch"].orig(id)
	self:SaveWatchedQuests()
end

function QuestsFu:OnUIInfoMessage()
	self.lastuimessage = arg1
	self:ScheduleEvent(self.ClearUIInfoMessage, 0.5, self)
end

function QuestsFu:ClearUIInfoMessage()
	self.lastuimessage = ""
end

function QuestsFu:OnQuestLogUpdate()
	if self.allowedToUpdate then self.lastquestmessage = self.lastuimessage end
	self.allowedToUpdate = false
	self:ScheduleEvent("ThrottleUpdate", function(self)
		self.allowedToUpdate = true
		self:Update()
	end, 1, self)
end

function QuestsFu:OnMouseOverUnit()
	-- Make sure that this is wanted, and that the tooltip is actually read/writeable.
	if self:IsShowingInItemTooltip() and self:CanMessWithGameTooltip() then
		--Comes with color codes.  Strip 'em out.
		local thisMob = string.gsub(getglobal('GameTooltipTextLeft1'):GetText(),"|c........(.*)|?r?","%1")
		if self.mobs[thisMob] then
			self:AddToGameTooltipAndFixHeight(self.mobs[thisMob].quest..": "..self.mobs[thisMob].needed, self.mobs[thisMob].colorr, self.mobs[thisMob].colorg, self.mobs[thisMob].colorb)
		end
	end
end

function QuestsFu:OnItemTooltip()
	self.hooks["ContainerFrameItemButton_OnEnter"].orig()
	if self:IsShowingInItemTooltip() and self:CanMessWithGameTooltip() then
		--Comes with color codes.  Strip 'em out.
		local thisItem = string.gsub(getglobal('GameTooltipTextLeft1'):GetText(),"|c........(.*)|r","%1")
		if self.items[thisItem] then
			self:AddToGameTooltipAndFixHeight(self.items[thisItem].quest..": "..self.items[thisItem].needed, self.items[thisItem].colorr, self.items[thisItem].colorg, self.items[thisItem].colorb)
		end
	end
end

function QuestsFu:CanMessWithGameTooltip()
	if GameTooltip and getglobal('GameTooltipTextLeft1'):IsVisible() and getglobal('GameTooltipTextLeft1'):GetText() ~= nil then
		return true
	else
		return false
	end
end

function QuestsFu:AddToGameTooltipAndFixHeight(text, r, g, b)
	GameTooltip:AddLine(text, r, g, b)

	-- Fix up the width of the tooltip
	length = getglobal(GameTooltip:GetName() .. "TextLeft" .. GameTooltip:NumLines()):GetStringWidth()
	-- Space for right-border:
	length = length + 22

	GameTooltip:SetHeight(GameTooltip:GetHeight() + 14)
	if length > GameTooltip:GetWidth() then
		GameTooltip:SetWidth(length)
	end
end

function QuestsFu:OnDataUpdate()
	--UpdateText and UpdateTooltip both need to know things about the questlog.  Better to do this once.
	compost:Reclaim(self.quests, 3)
	compost:Reclaim(self.zone_quests, 1)
	self.quests, self.zone_quests = nil, nil

	local startingQuestLogSelection = GetQuestLogSelection()
	local numEntries, numQuests = GetNumQuestLogEntries()
	local numQuestsDone = 0
	local quests = compost:Acquire()
	local zones = compost:Erase(self.zones)
	--LEVELS--local level_quests = {}
	local zone_quests = compost:Acquire()
	local items = compost:Erase(self.items)
	local mobs = compost:Erase(self.mobs)
	local zoneIndex = "OMG NONE" --The first item in the quest log should always be a header, so this should always be replaced.  But just in case.

	if numEntries > 0 and self.allowedToUpdate then
		local questid
		for questid = 1, numEntries do
			local strQuestLogTitleText, strQuestLevel, strQuestTag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(questid)
			local q = compost:Acquire()

			if isHeader then
				zoneIndex = strQuestLogTitleText
				table.insert(zones, zoneIndex)
				zone_quests[zoneIndex] = compost:Acquire()
			else
				q.zone = zoneIndex
				q.tag = strQuestTag

				SelectQuestLogEntry(questid)

				if isComplete == 1 then
					isComplete = L["QUEST_DONE"]
					numQuestsDone = numQuestsDone + 1
				elseif isComplete == -1 then
					isComplete = L["QUEST_FAILED"]
				else
					isComplete = nil
				end

				q.title = strQuestLogTitleText
				q.level = strQuestLevel
				q.complete = isComplete

				local lb = compost:Acquire()
				if GetNumQuestLeaderBoards() > 0 then
					local ii
					for ii=1, GetNumQuestLeaderBoards() do
						local desc, qtype, done = GetQuestLogLeaderBoard(ii)
						local itemName,mobName,numNeeded,numItems,factionName,factionCurrent,factionNeeded

						if qtype == 'item' then
							itemName,numItems,numNeeded = deformat(desc, QUEST_OBJECTS_FOUND)
							desc = itemName
						elseif qtype == 'monster' then
							mobName,numItems,numNeeded = deformat(desc, QUEST_MONSTERS_KILLED)
							if mobName == nil or numItems == nil or numNeeded == nil then
								--Sometimes we get objectives like "Find Mankrik's Wife: 0/1", which are listed as "monster".
								mobName, numItems, numNeeded = deformat(desc, QUEST_OBJECTS_FOUND)
							end
							desc = mobName
						elseif qtype == 'reputation' then
							factionName,factionCurrent,factionNeeded = deformat(desc, QUEST_FACTION_NEEDED)
							numItems = self:GetReactionLevel(factionCurrent)
							numNeeded = self:GetReactionLevel(factionNeeded)
							desc = factionName
						end

						local r,g,b
						if numItems ~= nil then
							-- This quest involves items!
							r, g, b = crayon:GetThresholdColor(numItems / numNeeded)
						end

						if qtype == 'item' then
							items[itemName] = compost:AcquireHash('quest', strQuestLogTitleText, 'item', itemName, 'needed', string.format("%s/%s",numItems,numNeeded), 'colorr', r, 'colorg', g, 'colorb', b)
						elseif qtype == 'monster' then
							mobs[mobName] = compost:AcquireHash('quest', strQuestLogTitleText, 'mob', mobName, 'needed', string.format("%s/%s",numItems,numNeeded), 'colorr', r, 'colorg', g, 'colorb', b)
						end

						if done then
							done = L["QUEST_DONE"]
						elseif numItems and numNeeded then
							if qtype == 'reputation' then
								done = string.format("%s/%s",factionCurrent,factionNeeded)
							else
								done = string.format("%s/%s",numItems,numNeeded)
							end
						else
							--I think this shouldn't happen.  ...but I haven't seen every quest out there.
							done = ""
						end

						table.insert(lb, compost:AcquireHash('description', desc, 'done', done, 'colorr', r, 'colorg', g, 'colorb', b))
					end
				else
					local strQuestDescription, strQuestObjectives = GetQuestLogQuestText(questid)
					--q.objective = self.superwrap(strQuestObjectives, 50, 0, 2)
					q.objective = strQuestObjectives
				end
				q.leaderboard = lb
				q.id = questid

				quests[questid] = q
				table.insert(zone_quests[zoneIndex], questid)
				--LEVELS--table.insert(level_quests[tonumber(strQuestLevel)], questid)
			end
		end
	end

	self.quests = quests
	self.zones = zones
	--LEVELS--self.level_quests = level_quests
	self.zone_quests = zone_quests
	self.items = items
	self.mobs = mobs
	self.numQuests = numQuests
	self.numEntries = numEntries
	self.numQuestsDone = numQuestsDone

	SelectQuestLogEntry(startingQuestLogSelection)

	self:SaveWatchedQuests() --A watched quest may have gone away because of the update.  (The game doesn't call RemoveQuestWatch for it...)
end

function QuestsFu:OnTextUpdate()
	local text = ""
	local maxQuests = 20
	if self.allowedToUpdate then
		local r,g,b = GameFontNormal:GetTextColor()
		local color = string.format("%02X%02X%02X", r * 255, g * 255, b * 255)
		if self:IsShowingTextComplete() then
			color = crayon:GetThresholdHexColor(self.numQuestsDone / self.numQuests)
			text = text .. crayon:Colorize(color,self.numQuestsDone)
		end
		if self:IsShowingTextComplete() and (self:IsShowingTextCurrent() or self:IsShowingTextTotal()) then
			text = text .. crayon:Colorize(color,"/")
		end
		if self:IsShowingTextCurrent() then
			color = crayon:GetThresholdHexColor((maxQuests - self.numQuests) / maxQuests)
			text = text .. crayon:Colorize(color,self.numQuests)
		end
		if self:IsShowingTextCurrent() and self:IsShowingTextTotal() then
			text = text .. crayon:Colorize(color,"/")
		end
		if self:IsShowingTextTotal() then
			text = text .. crayon:Colorize(color,maxQuests)
		end
		if (self:IsShowingTextTotal() or self:IsShowingTextComplete() or self:IsShowingTextCurrent()) and self:IsShowingTextLastMessage() and self.lastquestmessage ~= "" then
			text = text .. " m: "
		end
		if self:IsShowingTextLastMessage() and self.lastquestmessage ~= "" then
			text = text .. self.lastquestmessage
		end
	else
		text = L["TEXT_LOADING"]
	end
	self:SetText(text)
end

function QuestsFu:OnTooltipUpdate()
	if self.numQuests > 0 and self.allowedToUpdate then
		if table.getn(self.zones) then
			local currentZone = GetZoneText()
			local zonename, zone
			local cat
			if not self:IsShowingArea() then
				cat = tablet:AddCategory('columns', 2)
				local sortedQuests = self:SortQuests(self.quests)
				for _,quest in sortedQuests do
					self:AddQuestToTooltip(cat, quest, true)
				end
				compost:Reclaim(sortedQuests)
			else
				for _,zone in self.zones do
					-- If showing area headers and either not showing only the current area's quests or this is the current area.
					if self:IsShowingArea() and ((currentZone == zone) or not self:IsShowingCurrentAreaOnly() or (self:IsShowingClassAnyway() and UnitClass("player") == zone)) then
						local r,g,b = 0.749,1,0.749
						zonename = zone
						if zone == UnitClass("player") then 
							r, g, b = babbleclass:GetColor(zone)
						else
							if self:IsShowingLevelsZone() and tourist:IsZoneOrInstance(zone) then
								local high, low = tourist:GetLevel(zone)
								if high > 0 and low > 0 then
									zonename = string.format("%s (%d-%d)", zone, high, low)
								end
							end
							if self:IsShowingDifficulty() and tourist:IsZoneOrInstance(zone) then
								r, g, b = tourist:GetLevelColor(zone)
							end
						end
						cat = tablet:AddCategory(
							'id', zone,
							'text', zonename,
							'columns', 2,
							'hideBlankLine', true,
							'showWithoutChildren', true,
							'checked', true, 'hasCheck', true, 'checkIcon', self.db.char.hidden[zone] and "Interface\\Buttons\\UI-PlusButton-Up" or "Interface\\Buttons\\UI-MinusButton-Up",
							'func', 'ToggleCategory', 'arg1', self, 'arg2', zone,
							'textR', r,
							'textG', g,
							'textB', b,
							'child_func', 'QuestClick',
							'child_arg1', self
						)
					end
					-- If we're not hiding the zone and it's either the current zone or we're not showing only the current zone.
					if (not self.db.char.hidden[zone]) and ((not self:IsShowingCurrentAreaOnly()) or (currentZone == zone) or (self:IsShowingClassAnyway() and UnitClass("player") == zone)) and (table.getn(self.zone_quests[zone]) > 0) then
						local questid
						for _,questid in self.zone_quests[zone] do
							self:AddQuestToTooltip(cat, self.quests[questid], false)
						end
					end
				end
			end
		end
	end
	tablet:SetHint(L["TOOLTIP_HINT"])
end

function QuestsFu:MembersOnQuest(questid)
	--Return the number of party members on a quest.  Returns zero if not in a party.
	local n = 0
	local party = GetNumPartyMembers()
	if party > 0 then
		for i = 1,party do
			n = n + (IsUnitOnQuest(questid, "party"..i) and 1 or 0)
		end
	end
	return n
end

function QuestsFu:AddQuestToTooltip(cat, quest, appendZone)
	--Are we hiding impossible quests, and is this quest impossible?
	local questImpossible = (GetDifficultyColor(quest.level) == QuestDifficultyColor.impossible)
	if not questImpossible or (questImpossible and self:IsShowingImpossible()) then
		local thisQuest, thisQuestColor
		local questLevel, questZone = "",""
		local currentZone = GetZoneText()

		local questShared = QuestsFu:MembersOnQuest(quest.id)
		
		if questShared == 0 then
			questShared = ""
		end
		
		if appendZone then
			questZone = format(" (%s)", quest.zone)
		end
		
		if self:IsShowingLevelsTablet() and not self:IsShowingLevelsGame() then
			questLevel = self:MakeTag(quest.level, quest.tag)
		end
		
		thisQuest = questLevel..quest.title..questZone..((questShared ~= "") and "|c0000ff00<"..questShared..">|r" or '')

		if self:IsShowingDifficulty() then
			thisQuestColor = GetDifficultyColor(quest.level)
		end

		cat:AddLine(
			'text', thisQuest, 'wrap', self:IsWrappingQuests(),
			'text2', quest.complete,
			'textR', (thisQuestColor and thisQuestColor.r) or 1, 'textG', (thisQuestColor and thisQuestColor.g) or 1, 'textB', (thisQuestColor and thisQuestColor.b) or 1,
			'text2R', (quest.complete == L["QUEST_FAILED"]) and 1 or 0, 'text2G', (quest.complete == L["QUEST_DONE"]) and 1 or 0, 'text2B', 0,
			'func', 'QuestClick',
			'arg1', self,
			'arg2', quest.id,
			'indentation', 6,
			'checked', IsQuestWatched(quest.id),
			'hasCheck', IsQuestWatched(quest.id)
		)

		-- If we're showing descriptions/objectives and it's either the current zone or we're not showing descriptions only for the current zone.
		if self:IsShowingDescription() and ((currentZone == quest.zone) or not self:IsShowingCurrentAreaDescriptionOnly()) then
			-- If we know of leaderboard objectives:
			if table.getn(quest.leaderboard) > 0 then
				local i, goal
				for i,goal in quest.leaderboard do
					if not (goal.done == L["QUEST_DONE"] and not self:IsShowingCompletedObjectives()) then
						local r,g,b
						if self:IsColoringObjectives() then
							r,g,b = goal.colorr, goal.colorg, goal.colorb
						end
						cat:AddLine(
							'text', '  '..goal.description,
							'text2', goal.done,
							'textR', r or ((thisQuestColor and thisQuestColor.r) or 1), 'textG', g or ((thisQuestColor and thisQuestColor.g) or 1), 'textB', b or ((thisQuestColor and thisQuestColor.b) or 1),
							'text2R', r or ((thisQuestColor and thisQuestColor.r) or 1), 'text2G', g or ((thisQuestColor and thisQuestColor.g) or 1), 'text2B', b or ((thisQuestColor and thisQuestColor.b) or 1),
							'size', tablet:GetNormalFontSize()-2, 'size2', tablet:GetNormalFontSize()-2,
							'arg2', quest.id,
							'indentation', 12
						)
					end
				end
			-- Otherwise, if the quest is incomplete (or complete and we're showing completed objectives), add the generic objective.
			elseif not (quest.complete and not self:IsShowingCompletedObjectives()) then
				cat:AddLine(
					'text', quest.objective,
					'wrap', true,
					'textR', (thisQuestColor and thisQuestColor.r) or 1,
					'textG', (thisQuestColor and thisQuestColor.g) or 1,
					'textB', (thisQuestColor and thisQuestColor.b) or 1,
					'size', tablet:GetNormalFontSize()-2,
					'arg2', quest.id,
					'indentation', 12
				)
			end
		end
	end
end

function QuestsFu:ToggleCategory(id, button)
	if self.db.char.hidden[id] then
		self.db.char.hidden[id] = false
	else
		self.db.char.hidden[id] = true
	end
	-- Refresh in place
	self:UpdateTooltip()
end

--TheFly contributed the base of this, and it's still using much of the logic he provided
function QuestsFu:QuestClick(questid, button)
	if IsAltKeyDown() then
		-- Shift-click toggles quest-watch on this quest.
		if IsQuestWatched(questid) then
			RemoveQuestWatch(questid)
			QuestWatch_Update()
		else
			-- Set error if no objectives
			if GetNumQuestLeaderBoards(questid) == 0 then
				UIErrorsFrame:AddMessage(QUEST_WATCH_NO_OBJECTIVES, 1.0, 0.1, 0.1, 1.0, UIERRORS_HOLD_TIME)
				return
			end
			-- Set an error message if trying to show too many quests
			if GetNumQuestWatches() >= MAX_WATCHABLE_QUESTS then
				UIErrorsFrame:AddMessage(format(QUEST_WATCH_TOO_MANY, MAX_WATCHABLE_QUESTS), 1.0, 0.1, 0.1, 1.0, UIERRORS_HOLD_TIME)
				return
			end
			AddQuestWatch(questid)
			QuestWatch_Update()
		end
	elseif IsShiftKeyDown() and IsControlKeyDown() and ChatFrameEditBox:IsVisible() then
		-- Add the quest objectives to the chat editbox, if it's open.
		for i,goal in pairs(self.quests[questid].leaderboard) do
			ChatFrameEditBox:Insert(string.format("{%s %s} ", goal.description, goal.done))
		end
	elseif IsShiftKeyDown() and ChatFrameEditBox:IsVisible() then
		-- Add quest title to the chat editbox if it's open.
		ChatFrameEditBox:Insert(self.quests[questid].title)
	elseif IsControlKeyDown() then
		-- Share the quest with party members.
		local wasSelected = GetQuestLogSelection()
		SelectQuestLogEntry(questid)
		if (GetQuestLogPushable() and GetNumPartyMembers() > 0) then
			QuestLogPushQuest()
		end
		SelectQuestLogEntry(questid)
	else
		if QuestLogFrame:IsVisible() then
			if self.lastIndex == questid then
				HideUIPanel(QuestLogFrame)
			end
		else
			ShowUIPanel(QuestLogFrame)
		end
		if (self.numEntries > QUESTS_DISPLAYED) then
			if (questid < self.numEntries - QUESTS_DISPLAYED) then
				FauxScrollFrame_SetOffset(QuestLogListScrollFrame, questid - 1)
				QuestLogListScrollFrameScrollBar:SetValue((questid - 1) * QUESTLOG_QUEST_HEIGHT)
			else
				FauxScrollFrame_SetOffset(QuestLogListScrollFrame, self.numEntries - QUESTS_DISPLAYED)
				QuestLogListScrollFrameScrollBar:SetValue((self.numEntries - QUESTS_DISPLAYED) * QUESTLOG_QUEST_HEIGHT)
			end
		end

		SelectQuestLogEntry(questid)
		QuestLog_SetSelection(questid)
		self.lastIndex = questid
	end
end

function QuestsFu:OnClick()
	ToggleQuestLog()
end

function QuestsFu:GetReactionLevel(leveltext)
	if leveltext == FACTION_STANDING_LABEL1 then --Hated
		return 1
	elseif leveltext == FACTION_STANDING_LABEL2 then --Hostile
		return 2
	elseif leveltext == FACTION_STANDING_LABEL3 then --Unfriendly
		return 3
	elseif leveltext == FACTION_STANDING_LABEL4 then --Neutral
		return 4
	elseif leveltext == FACTION_STANDING_LABEL5 then --Friendly
		return 5
	elseif leveltext == FACTION_STANDING_LABEL6 then --Honored
		return 6
	elseif leveltext == FACTION_STANDING_LABEL7 then --Revered
		return 7
	elseif leveltext == FACTION_STANDING_LABEL8 then --Exalted
		return 8
	end
end

function QuestsFu:LoadWatchedQuests()
	if not (GetNumQuestWatches() > 0) then
		for _,questId in self.db.char.watchedQuests do
			AddQuestWatch(questId)
		end
	end
	QuestWatch_Update()
	
	self.loadedWatchedQuests = true
end

function QuestsFu:SaveWatchedQuests()
	if self.loadedWatchedQuests then
		self.db.char.watchedQuests = compost:Erase(self.db.char.watchedQuests)
		for i = 1, GetNumQuestWatches() do
			table.insert(self.db.char.watchedQuests, GetQuestIndexForWatch(i))
		end
	end
end

-- Sorts a table of quests by level, with quests of the same level ordered
-- by elite, dungeon or raid tags, i.e. normal < elite < dungeon < raid.
-- Quests of the same level and tag are sorted alphabetically by title.
-- Returns a new table of the sorted quests. Original table is unchanged.
function QuestsFu:SortQuests(quests)
	-- Make a copy of the table, without keys
	local sortedQuests = compost:Acquire()
	table.foreach(self.quests,
		function(k,v)
			table.insert(sortedQuests, v)
		end
	)

	table.sort(sortedQuests,
		function(a,b)
			local aa = a.level*4
			local bb = b.level*4
			if a.tag == L["TAG_ELITE"] then aa = aa+1 end
			if a.tag == L["TAG_DUNGEON"] then aa = aa+2 end
			if a.tag == L["TAG_RAID"] then aa = aa+3 end
			if b.tag == L["TAG_ELITE"] then bb = bb+1 end
			if b.tag == L["TAG_DUNGEON"] then bb = bb+2 end
			if b.tag == L["TAG_RAID"] then bb = bb+3 end
			if aa == bb then
				return a.title < b.title
			end
			return aa < bb;
		end
	)

	return sortedQuests
end
