--[[

        TalentSafe:
        Confirm choices when learning a talent.

        Bima, aka Tale, aka David C Lawrence <reg+wow-addons@dd.org>

]]

local LEARN

if (GetLocale() == "frFR") then
        LEARN = "Apprenez"
elseif (GetLocale() == "deDE") then
        LEARN = "Erlernen"
else
        LEARN = "Learn"
end

--- 
--- Redefines the standard Blizzard function from FrameXML/TalenFrame.lua
--- Honestly, figuring out whether a talent is learnable is more painful
--- than it should be.
--- 
function TalentSafe_OnClick()
    if (TalentFrame.talentPoints < 1) then
        return
    end

    local tab = PanelTemplates_GetSelectedTab(TalentFrame)
    local talent = this:GetID()

    local name, texture, tier, column, rank, maxrank, exceptional, prereqok =
        GetTalentInfo(tab, talent)

    if (rank == maxrank) then
        return
    end

    if ((tier - 1) * 5 >  TalentFrame.pointsSpent) then 
        return
    end

    -- I have no idea how come the 8th return value from GetTalentInfo,
    -- which the standard TalentFrame.lua names "meetsPrereq", declares
    -- a true value when in fact prereqs are not met.  Furthermore,
    -- why does TalentFrame.lua process the return values from
    -- GetTalentPrereqs as though there can be more than one tuple?
    -- Is there ever more than one prereq talent for any other talent?
    local prereqs = { GetTalentPrereqs(tab, talent) }

    local i;
    for i = 1, table.getn(prereqs), 3 do
        if (not prereqs[i+2]) then
            return
        end
    end

    local ranktext
    if (maxrank > 1) then
        ranktext = " (" .. (rank + 1) .. "/" .. maxrank .. ")"
    else
        ranktext = ""
    end

    StaticPopupDialogs["TALENTSAFE"] = {
        text = LEARN .. " " .. name .. ranktext .. "?",
        button1 = YES,
        button2 = NO,
        OnAccept = function()
            LearnTalent(tab, talent)
        end,
        timeout = 0,
        exclusive = 1,
        whileDead = 1,
        interruptCinematic = 1
    };
    StaticPopup_Show("TALENTSAFE");
end

