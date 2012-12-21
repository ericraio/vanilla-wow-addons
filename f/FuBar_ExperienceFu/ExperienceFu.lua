local compost = AceLibrary("Compost-2.0")
local tablet = AceLibrary("Tablet-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local abacus = AceLibrary("Abacus-2.0")

ExperienceFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "FuBarPlugin-2.0", "AceDB-2.0")
ExperienceFu.hasIcon = true
ExperienceFu:RegisterDB("ExperienceFuDB")
ExperienceFu:RegisterDefaults("profile", {
    showValue = {
        current = false,
        rest = false,
        pet = false,
    },
    showPercent = {
        current = true,
        rest = true,
        pet = true
    },
    showDepletion = {
        current = false,
        rest = false,
        pet = false,
    },
})

local L = ExperienceFuLocals

ExperienceFu.options = {
    type = "group",
    handler = ExperienceFu,
    args = {
        reset_session = {
            type = "execute",
            name = L"Reset session",
            desc = L"Reset session",
            func = "ResetSession",
            order = -1,
        },
        hidesixty = {
            hidden = function() return UnitLevel("player") ~= 60 end,
            type = "toggle",
            name = L"Hide Text at maximum level",
            desc = L"Hide Text at maximum level",
            get  = function() return ExperienceFu:IsPreSixtyOnly() end,
            set  = function() ExperienceFu:TogglePreSixtyOnly() end,
        },
        stats = {
            type = "group",
            name = L"Statistics",
            desc = L"Display various XP statistics",
            args = {
                xp_hour = {
                    type = "toggle",
                    name = L"Show XP/hour",
                    desc = L"Show XP/hour",
                    get  = function() return ExperienceFu:IsShowingXPPerHour() end,
                    set  = function() ExperienceFu:ToggleShowingXPPerHour() end,
                },
                ttl = {
                    type = "toggle",
                    name = L"Show time to level",
                    desc = L"Show time to level",
                    get  = function() return ExperienceFu:IsShowingTimeToLevel() end,
                    set  = function() ExperienceFu:ToggleShowingTimeToLevel() end,
                },
                show_by = {
                    hidden = function() return not (ExperienceFu:IsShowingXPPerHour() or ExperienceFu:IsShowingTimeToLevel()) end,
                    type = "toggle",
                    name = L"Show in relation to level",
                    desc = L"Toggle between showing experience as an absolute or in relation to time.",
                    get  = function() return ExperienceFu:IsShowingByLevel() end,
                    set  = function() ExperienceFu:ToggleShowingByLevel() end,
                    order = 999,
                },
            },
        },
        show = {
            type = "group",
            name = L"Display Values",
            desc = L"Display Value as...",
            args = {
                current = {
                    name = L"Current XP",
                    desc = L"Show current XP",
                    type = "group",
                    args = {
                        value = {
                            type = "toggle",
                            name = L"Show value",
                            desc = L"Show current XP value",
                            get  = function() return ExperienceFu:IsShowingValue("current") end,
                            set  = function() return ExperienceFu:ToggleShowingValue("current") end,
                        },
                        percent = {
                            type = "toggle",
                            name = L"Show percent",
                            desc = L"Show current XP percent",
                            get  = function() return ExperienceFu:IsShowingPercent("current") end,
                            set  = function() return ExperienceFu:ToggleShowingPercent("current") end,
                        },
                        depletion = {
                            type = "toggle",
                            name = L"View as Remaining XP",
                            desc = L"Show current XP until level",
                            get  = function() return ExperienceFu:IsShowingDepletion("current") end,
                            set  = function() return ExperienceFu:ToggleShowingDepletion("current") end,
                        },
                    },
                },
                rest = {
                    name = L"Rest XP",
                    desc = L"Show rest XP",
                    type = "group",
                    args = {
                        value = {
                            type = "toggle",
                            name = L"Show value",
                            desc = L"Show rest XP value",
                            get  = function() return ExperienceFu:IsShowingValue("rest") end,
                            set  = function() return ExperienceFu:ToggleShowingValue("rest") end,
                        },
                        percent = {
                            type = "toggle",
                            name = L"Show percent",
                            desc = L"Show rest XP percent",
                            get  = function() return ExperienceFu:IsShowingPercent("rest") end,
                            set  = function() return ExperienceFu:ToggleShowingPercent("rest") end,
                        },
                    },
                },
                pet = {
                    hidden = function() return ExperienceFu.playerClass ~= "HUNTER" end,
                    name = L"Pet XP",
                    desc = L"Show pet XP",
                    type = "group",
                    args = {
                        value = {
                            type = "toggle",
                            name = L"Show value",
                            desc = L"Show pet XP value",
                            get  = function() return ExperienceFu:IsShowingValue("pet") end,
                            set  = function() return ExperienceFu:ToggleShowingValue("pet") end,
                        },
                        percent = {
                            type = "toggle",
                            name = L"Show percent",
                            desc = L"Show pet XP percent",
                            get  = function() return ExperienceFu:IsShowingPercent("pet") end,
                            set  = function() return ExperienceFu:ToggleShowingPercent("pet") end,
                        },
                        depletion = {
                            type = "toggle",
                            name = L"View as Remaining XP",
                            desc = L"Show pet XP until level",
                            get  = function() return ExperienceFu:IsShowingDepletion("pet") end,
                            set  = function() return ExperienceFu:ToggleShowingDepletion("pet") end,
                        },
                    },
                },
            },
        },
    },
}

function ExperienceFu:OnInitialize()
    self.initialXP = UnitXP("player")
    self.accumulatedXP = 0
    self.sessionXP = 0
    self.entranceTime = time()
    self.levelUpTime = time()
    self.totalTime = time()
    self.levelTime = time()

end

function ExperienceFu:OnEnable()
    self.timeSinceLastUpdate = 0

    self:RegisterEvent("PLAYER_XP_UPDATE", "OnPlayerXpUpdate")
    self:RegisterEvent("PLAYER_LEVEL_UP", "OnPlayerLevelUp")
    self:RegisterEvent("TIME_PLAYED_MSG", "OnTimePlayedMsg")

    RequestTimePlayed()

    self:ScheduleRepeatingEvent("ExperienceFu_Update", self.Update, 1, self)

    _, self.playerClass = UnitClass("player")
end

function ExperienceFu:OnDisable()
    self:CancelScheduledEvent("ExperienceFu_Update")
    self:UnregisterEvent("PLAYER_XP_UPDATE")
    self:UnregisterEvent("PLAYER_LEVEL_UP")
    self:UnregisterEvent("TIME_PLAYED_MSG")
end

function ExperienceFu:OnMenuRequest()
    dewdrop:FeedAceOptionsTable(self.options)
end

function ExperienceFu:IsShowingValue(setting)
    return self.db.profile.showValue[setting]
end

function ExperienceFu:ToggleShowingValue(setting, loud)
    self.db.profile.showValue[setting] = not self.db.profile.showValue[setting]
    self:UpdateText()
    return self.db.profile.showValue[setting]
end

function ExperienceFu:IsShowingPercent(setting)
    return self.db.profile.showPercent[setting]
end

function ExperienceFu:ToggleShowingPercent(setting, loud)
    self.db.profile.showPercent[setting] = not self.db.profile.showPercent[setting]
    self:UpdateText()
    return self.db.profile.showPercent[setting]
end

function ExperienceFu:IsShowingDepletion(setting)
    return self.db.profile.showDepletion[setting]
end

function ExperienceFu:ToggleShowingDepletion(setting, loud)
    self.db.profile.showDepletion[setting] = not self.db.profile.showDepletion[setting]
    self:UpdateText()
    return self.db.profile.showDepletion[setting]
end

function ExperienceFu:IsShowingXPPerHour()
    return self.db.profile.xpPerHour
end

function ExperienceFu:ToggleShowingXPPerHour(loud)
    self.db.profile.xpPerHour = not self.db.profile.xpPerHour
    self:UpdateText()
    return self.db.profile.xpPerHour
end

function ExperienceFu:IsShowingTimeToLevel()
    return self.db.profile.timeToLevel
end

function ExperienceFu:ToggleShowingTimeToLevel(loud)
    self.db.profile.timeToLevel = not self.db.profile.timeToLevel
    self:UpdateText()
    return self.db.profile.timeToLevel
end

function ExperienceFu:IsShowingByLevel()
    return self.db.profile.byLevel
end

function ExperienceFu:ToggleShowingByLevel(loud)
    self.db.profile.byLevel = not self.db.profile.byLevel
    self:UpdateText()
    return self.db.profile.byLevel
end

function ExperienceFu:IsPreSixtyOnly()
    return self.db.profile.preSixtyOnly
end

function ExperienceFu:TogglePreSixtyOnly()
    self.db.profile.preSixtyOnly = not self.db.profile.preSixtyOnly
    if (self.db.profile.preSixtyOnly) then self:SetText("") end
    self:UpdateText()
    return self.db.profile.preSixtyOnly
end

function ExperienceFu:ResetSession()
    self.initialXP = UnitXP("player")
    self.accumulatedXP = 0
    self.sessionXP = 0
    self.entranceTime = time()
    RequestTimePlayed()
end

function ExperienceFu:GetLevelDuration()
    return time() - self.levelUpTime
end

function ExperienceFu:GetTotalDuration()
    return time() - self.totalTime
end

function ExperienceFu:GetSessionDuration()
    return time() - self.entranceTime
end

function ExperienceFu:OnPlayerXpUpdate()
    self.sessionXP = UnitXP("player") - self.initialXP + self.accumulatedXP
end

function ExperienceFu:OnPlayerLevelUp()
    self.accumulatedXP = self.accumulatedXP + UnitXPMax("player") - self.initialXP
    self.initialXP = 0
    self.levelUpTime = time()
end

function ExperienceFu:OnTimePlayedMsg()
    self.totalTime = time() - arg1
    self.levelUpTime = time() - arg2
end

function ExperienceFu:UpdateText()
    if (self.entranceTime == nil or (self:IsPreSixtyOnly() and UnitLevel("player") == 60)) then
        return
    end
    local t = compost:Acquire()
    if self:IsShowingValue("current") then
        local val = UnitXP("player")
        local max = UnitXPMax("player")
        if self:IsShowingDepletion("current") then
            val = max - val
        end
        table.insert(t, format("|cffffffff%d|r XP", val))
        if self:IsShowingPercent("current") then
            table.insert(t, format("(|cffffffff%.1f%%|r)", val/max * 100))
        end
    elseif self:IsShowingPercent("current") then
        local val = UnitXP("player")
        local max = UnitXPMax("player")
        if self:IsShowingDepletion("current") then
            val = max - val
        end
        table.insert(t, format("|cffffffff%.1f%%|r", val/max * 100))
    end
    if self:IsShowingValue("rest") then
        local val = GetXPExhaustion() or 0
        if val ~= 0 then
            local max = UnitXPMax("player")
            table.insert(t, format("R: |cffffffff%d|r XP", val))
            if self:IsShowingPercent("rest") then
                table.insert(t, format("(|cffffffff%.1f%%|r)", val/max * 100))
            end
        end
    elseif self:IsShowingPercent("rest") then
        local val = GetXPExhaustion() or 0
        if val ~= 0 then
            local max = UnitXPMax("player")
            table.insert(t, format("R: |cffffffff%.1f%%|r", val/max * 100))
        end
    end
    local _,class = UnitClass("player")
    if class == "HUNTER" and UnitExists("pet") then
        if self:IsShowingValue("pet") then
            local val, max = GetPetExperience()
            if self:IsShowingDepletion("pet") then
                val = max - val
            end
            table.insert(t, format("P: |cffffffff%d|r XP", val))
            if self:IsShowingPercent("pet") then
                table.insert(t, format("(|cffffffff%.1f%%|r)", val/max * 100))
            end
        elseif self:IsShowingPercent("pet") then
            local val, max = GetPetExperience()
            if self:IsShowingDepletion("pet") then
                val = max - val
            end
            table.insert(t, format("P: |cffffffff%.1f%%|r", val/max * 100))
        end
    end
    if self:IsShowingXPPerHour() then
        if self:IsShowingByLevel() then
            local xpPerHourByLevel = floor(UnitXP("player") / self:GetLevelDuration() * 3600)
            table.insert(t, format("|cffffffff%d|r XP/h", xpPerHourByLevel))
        else
            local xpPerHourBySession = floor(self.sessionXP / (time() - self.entranceTime) * 3600)
            table.insert(t, format("|cffffffff%d|r XP/h", xpPerHourBySession))
        end
    end
    if self:IsShowingTimeToLevel() then
        if self:IsShowingByLevel() then
            local timeToLevelByLevel = (UnitXPMax("player") - UnitXP("player")) * self:GetLevelDuration() / UnitXP("player")
            table.insert(t, abacus:FormatDurationShort(timeToLevelByLevel, true))
        else
            local timeToLevelBySession = (UnitXPMax("player") - UnitXP("player")) * (time() - self.entranceTime) / self.sessionXP
            table.insert(t, abacus:FormatDurationShort(timeToLevelBySession, true))
        end
    end
    self:SetText(table.concat(t, " "))
    compost:Reclaim(t)
end

function ExperienceFu:OnTooltipUpdate()
    local totalXP = UnitXPMax("player")
    local currentXP = UnitXP("player")
    local toLevelXP = totalXP - currentXP
    local sessionXP = self.sessionXP
    local sessionTime = time() - self.entranceTime
    local levelTime = self:GetLevelDuration()
    local xpPerHourByLevel = floor(currentXP / levelTime * 3600)
    local timeToLevelByLevel = toLevelXP * levelTime / currentXP
    local xpPerHourBySession = floor(sessionXP / sessionTime * 3600)
    local timeToLevelBySession = toLevelXP * sessionTime / sessionXP
    local restXP = GetXPExhaustion() or 0

    local cat = tablet:AddCategory(
    'columns', 2,
    'child_textR', 1,
    'child_textG', 1,
    'child_textB', 0,
    'child_text2R', 1,
    'child_text2G', 1,
    'child_text2B', 1
    )

    cat:AddLine(
    'text', L"Total time played" .. ":",
    'text2', abacus:FormatDurationFull(self:GetTotalDuration())
    )

    cat:AddLine(
    'text', L"Time this level" .. ":",
    'text2', abacus:FormatDurationFull(self:GetLevelDuration())
    )

    cat:AddLine(
    'text', L"Time this session" .. ":",
    'text2', abacus:FormatDurationFull(self:GetSessionDuration())
    )

    cat = tablet:AddCategory(
    'columns', 2,
    'child_textR', 1,
    'child_textG', 1,
    'child_textB', 0,
    'child_text2R', 1,
    'child_text2G', 1,
    'child_text2B', 1
    )

    cat:AddLine(
    'text', L"Level" .. ":",
    'text2', UnitLevel("player")
    )

    cat:AddLine(
    'text', L"Total XP this level" .. ":",
    'text2', totalXP
    )

    cat:AddLine(
    'text', L"Gained" .. ":",
    'text2', format("%d (%.1f%%)", currentXP, currentXP / totalXP * 100)
    )

    cat:AddLine(
    'text', L"Remaining" .. ":",
    'text2', format("%d (%.1f%%)", toLevelXP, toLevelXP / totalXP * 100)
    )

    cat:AddLine(
    'text', L"Total XP this session" .. ":",
    'text2', sessionXP
    )

    cat:AddLine(
    'text', L"Rest XP" .. ":",
    'text2', format("%d (%.1f%%)", restXP, restXP / totalXP * 100)
    )

    local _,class = UnitClass("player")
    if class == "HUNTER" and UnitExists("pet") then
        local currXP, nextXP = GetPetExperience()
        if currXP and nextXP and nextXP > 0 then
            cat:AddLine(
            'text', L"Pet XP" .. ":",
            'text2', format("%d (%.1f%%)", currXP, currXP / nextXP * 100)
            )
        end
    end

    local cat = tablet:AddCategory(
    'columns', 2,
    'child_textR', 1,
    'child_textG', 1,
    'child_textB', 0,
    'child_text2R', 1,
    'child_text2G', 1,
    'child_text2B', 1
    )

    cat:AddLine(
    'text', L"XP/hour this level" .. ":",
    'text2', xpPerHourByLevel
    )

    cat:AddLine(
    'text', L"XP/hour this session" .. ":",
    'text2', xpPerHourBySession
    )

    cat:AddLine(
    'text', L"Time to level for this level" .. ":",
    'text2', abacus:FormatDurationFull(timeToLevelByLevel)
    )

    cat:AddLine(
    'text', L"Time to level for this session" .. ":",
    'text2', abacus:FormatDurationFull(timeToLevelBySession)
    )
end
