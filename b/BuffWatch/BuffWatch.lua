-- //////////////////////////////////////////////////////////////////////////////////////
-- //
-- // BuffWatch
-- //     by Pup
-- //
-- // TODO: (possibly)
-- //
-- //     Base resize on num players visible/buffs vis (store and count when scanning)
-- //
-- //     Ignore dead / disconn in threshold count
-- //     Window doesnt always properly resize
-- //     Update ResizeWindow to run no more than once every 2 secs
-- //     Option to split into columns (previous changes might suffice)
-- //     Localisation for various bits of text
-- //     Keybinding to scan list and recast any expired buffs
-- //     Show poisons and weapon buffs for player
-- //     Lower spell rank support
-- //     Allow cleansing of debuffs
-- //     UI Scaling
-- //
-- // CHANGES:
-- //
-- //    Added option to restrict buff updates
-- //    Fixed a couple of bugs as a result of 1.11
-- //
-- //////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////////////
-- //
-- //                Variables
-- //
-- //////////////////////////////////////////////////////////////////////////////////////

BINDING_HEADER_BUFFWATCHHEADER = "BuffWatch"
BW_VERSION = "1.15"
BW_RELEASE_DATE = "June 25, 2006"
BW_SORTORDER_DROPDOWN_LIST = {
    "Raid Order",
    "Class",
    "Name"
}

BuffWatchConfig = { alpha, rightMouseSpell, show_on_startup, ShowPets,
    ShowCastableBuffs, ShowDebuffs, ShowDispellableDebuffs, DebuffsAlwaysVisible, 
    AlignBuffs, ExpiredWarning, ExpiredSound, SortOrder, BuffThreshold, HighlightPvP, 
    PreventPvPBuff, UpdPerSec, ShowUpdPerSec }

local lastspellcast
local lastgrouptype
local buttonalignposition = 0
local buttonalignid
local buffexpired
local minimized = false
local HideUnmonitored = false
local HideMonitored = false

local Player_Info = { }
local Player_Left = { }
local UNIT_IDs = { }

local GroupBuffs = { }

local BuffUpdateTime
local LastBuffStatusUpdated
local BuffUpdatePending = false
local UpdPerSec = { }
local CurrSec = 0
local SAMPLE_SIZE = 10

-- //////////////////////////////////////////////////////////////////////////////////////
-- //
-- //                Events
-- //
-- //////////////////////////////////////////////////////////////////////////////////////

function BW_OnLoad()

    this:RegisterEvent("PLAYER_LOGIN")
    this:RegisterEvent("PARTY_MEMBERS_CHANGED")
    this:RegisterEvent("RAID_ROSTER_UPDATE")
    this:RegisterEvent("SPELLCAST_START")
    this:RegisterEvent("UNIT_AURA")
    this:RegisterEvent("UNIT_PET")
    this:RegisterEvent("UNIT_PVP_UPDATE")
    this:RegisterEvent("VARIABLES_LOADED")

    SlashCmdList["BUFFWATCH"] = BW_SlashHandler
    SLASH_BUFFWATCH1 = "/buffwatch"
    SLASH_BUFFWATCH2 = "/bw"

end


function BW_OnEvent()

    if event == "VARIABLES_LOADED" then

        -----------------------
        -- support for myAddons
        -----------------------
        if(myAddOnsFrame_Register) then
            BuffWatchDetails = {
                name = "BuffWatch",
                description = "Keeps track of party/raid buffs",
                version = BW_VERSION,
                releaseDate = BW_RELEASE_DATE,
                author = "Pup",
                category = MYADDONS_CATEGORY_OTHERS,
                frame = "BW",
                optionsframe = "BW_Options"
            }

            BuffWatchHelp = { "              - BuffWatch Usage - v " .. BW_VERSION .. "-\n\n" ..
                "  Show/Hide the BuffWatch window:\n    - Bind a keyboard button to show/hide the window\n" ..
                "    - You can also close it by right clicking the \"BuffWatch\" label (appears on mouseover)\n\n" ..
                "  Showing Buffs:\n    - Left click the BuffWatch label\n    - Also occurs automatically whenever your gain/lose a party or raid member\n\n" ..
                "  Locking a player's watched buffs:\n    - If the checkbox to the left is unchecked, buffs will be added automatically whenever they gain a buff\n" ..
                "    - If checked, buffs will not be added\n\n",
                "  Rebuffing:\n    - Left click an icon (will auto-target)\n\n" ..
                "  Right click spell:\n" ..
                "    - Cast any spell with a cast time (not instant).\n        Then type \"/bw set\"\n    - To cast it, right click any icon (will auto-target)\n\n" ..
                "  Deleting buffs:\n    - Lock the player's buffs (check the box).\n        Then [ CTRL + Right Click ] on the buff\n" ..
                "    - Optionally, [ ALT + Right Click ] to delete all but the selected one.\n\n",
                "  Slash Commands ( Use /buffwatch or /bw )\n" ..
                "    - /bw toggle : shows/hides the window\n" ..
                "    - /bw options : shows/hides the options window\n" ..
                "    - /bw : shows this help menu :)\n\n" ..
                "  Verbosity:\n" ..
                "    - Hold [ Shift ] while left or right-clicking a buff icon to send a cast message to your party\n"
            }

            myAddOnsFrame_Register(BuffWatchDetails, BuffWatchHelp)
        end

        ---------------------
        -- support for Cosmos
        ---------------------
        if EarthFeature_AddButton then
            EarthFeature_AddButton({
                id = "BuffWatch";
                name = "BuffWatch";
                subtext = "Buff monitoring";
                tooltip = "Monitor Party or Raid buffs";
                icon = "Interface\\Icons\\INV_Misc_Spyglass_03";
                callback = BW_OptionsToggle;
                test = nil
            })
        elseif Cosmos_RegisterButton then
            Cosmos_RegisterButton(
                "BuffWatch",
                "Buff monitoring",
                "Monitor Party or Raid buffs",
                "Interface\\Icons\\INV_Misc_Spyglass_03",
                BW_OptionsToggle
            )
        end

        --------------------
        -- support for CTMod
        --------------------
        if CT_RegisterMod then
            CT_RegisterMod(
                "BuffWatch",
                "Buff monitoring",
                5,
                "Interface\\Icons\\INV_Misc_Spyglass_03",
                "Monitor Party or Raid buffs",
                "switch",
                "",
                BW_OptionsToggle
            )
        end

        BW_Print("BuffWatch loaded. Please type \"/buffwatch\" or \"/bw\" for usage. Use \"/bw toggle\" to show window.", 0.2, 0.9, 0.9 )

        BW_HeaderText:SetText("BuffWatch")
        BW_HeaderText:SetTextColor(0.2, 0.9, 0.9)
        BW_Background:SetBackdropBorderColor(0, 0, 0)

        if BuffWatchConfig.alpha == nil then
            BuffWatchConfig.alpha = 0.5
        end

        BW_Background:SetAlpha(BuffWatchConfig.alpha)

        if BuffWatchConfig.show_on_startup == nil then
            BuffWatchConfig.show_on_startup = true
            BW:Show()
        elseif BuffWatchConfig.show_on_startup == true then
            BW:Show()
        elseif BuffWatchConfig.show_on_startup == false then
            BW:Hide()
        end

        if BuffWatchConfig.ShowPets == nil then
            BuffWatchConfig.ShowPets = true
        end

        if BuffWatchConfig.ShowCastableBuffs == nil then
            BuffWatchConfig.ShowCastableBuffs = false
        end

        if BuffWatchConfig.ShowDebuffs == nil then
            BuffWatchConfig.ShowDebuffs = true
        end

        if BuffWatchConfig.ShowDispellableDebuffs == nil then
            BuffWatchConfig.ShowDispellableDebuffs = false
        end
        
        if BuffWatchConfig.DebuffsAlwaysVisible == nil then
            BuffWatchConfig.DebuffsAlwaysVisible = true
        end

        if BuffWatchConfig.AlignBuffs == nil then
            BuffWatchConfig.AlignBuffs = true
        end

        if BuffWatchConfig.ExpiredWarning == nil then
            BuffWatchConfig.ExpiredWarning = true
        end

        if BuffWatchConfig.ExpiredSound == nil then
            BuffWatchConfig.ExpiredSound = false
        end

        if BuffWatchConfig.SortOrder == nil then
            BuffWatchConfig.SortOrder = BW_SORTORDER_DROPDOWN_LIST[1]
        end

        if BuffWatchConfig.BuffThreshold == nil then
            BuffWatchConfig.BuffThreshold = 0
        end

        if BuffWatchConfig.HighlightPvP == nil then
            BuffWatchConfig.HighlightPvP = false
        end

        if BuffWatchConfig.PreventPvPBuff == nil then
            BuffWatchConfig.PreventPvPBuff = false
        end

        if BuffWatchConfig.UpdPerSec == nil then
            BuffWatchConfig.UpdPerSec = 0
        end

        if BuffWatchConfig.ShowUpdPerSec == nil then
            BuffWatchConfig.ShowUpdPerSec = false
        end

        -- Mark of the Wild (Same icon as Gift of the Wild)
        GroupBuffs["Interface\\Icons\\Spell_Nature_Regeneration"] = {
            ["Greater"] = "Gift of the Wild",
            ["Type"] = "SubGroup",
            ["ByName"] = 1
        }

        -- Power Word Fortitude
        GroupBuffs["Interface\\Icons\\Spell_Holy_WordFortitude"] = {
            ["Greater"] = "Interface\\Icons\\Spell_Holy_PrayerOfFortitude",
            ["Type"] = "SubGroup"
        }
        -- Prayer of Fortitude
        GroupBuffs["Interface\\Icons\\Spell_Holy_PrayerOfFortitude"] = {
            ["Lesser"] = "Interface\\Icons\\Spell_Holy_WordFortitude",
            ["Type"] = "SubGroup"
        }
        -- Divine Spirit
        GroupBuffs["Interface\\Icons\\Spell_Holy_DivineSpirit"] = {
            ["Greater"] = "Interface\\Icons\\Spell_Holy_PrayerofSpirit",
            ["Type"] = "SubGroup"
        }
        -- Prayer of Spirit
        GroupBuffs["Interface\\Icons\\Spell_Holy_PrayerofSpirit"] = {
            ["Lesser"] = "Interface\\Icons\\Spell_Holy_DivineSpirit",
            ["Type"] = "SubGroup"
        }
        -- Shadow Protection
        GroupBuffs["Interface\\Icons\\Spell_Shadow_AntiShadow"] = {
            ["Greater"] = "Interface\\Icons\\Spell_Holy_PrayerofShadowProtection",
            ["Type"] = "SubGroup"
        }
        -- Prayer of Shadow Protection
        GroupBuffs["Interface\\Icons\\Spell_Holy_PrayerofShadowProtection"] = {
            ["Lesser"] = "Interface\\Icons\\Spell_Shadow_AntiShadow",
            ["Type"] = "SubGroup"
        }
        -- Arcane Intellect
        GroupBuffs["Interface\\Icons\\Spell_Holy_MagicalSentry"] = {
            ["Greater"] = "Interface\\Icons\\Spell_Holy_ArcaneIntellect",
            ["Type"] = "SubGroup"
        }
        -- Arcane Brilliance
        GroupBuffs["Interface\\Icons\\Spell_Holy_ArcaneIntellect"] = {
            ["Lesser"] = "Interface\\Icons\\Spell_Holy_MagicalSentry",
            ["Type"] = "SubGroup"
        }
        -- Blessing of Might
        GroupBuffs["Interface\\Icons\\Spell_Holy_FistOfJustice"] = {
            ["Greater"] = "Interface\\Icons\\Spell_Holy_GreaterBlessingofKings",
            ["Type"] = "Class"
        }
        -- Greater Blessing of Might
        GroupBuffs["Interface\\Icons\\Spell_Holy_GreaterBlessingofKings"] = {
            ["Lesser"] = "Interface\\Icons\\Spell_Holy_FistOfJustice",
            ["Type"] = "Class"
        }
        -- Blessing of Wisdom
        GroupBuffs["Interface\\Icons\\Spell_Holy_SealOfWisdom"] = {
            ["Greater"] = "Interface\\Icons\\Spell_Holy_GreaterBlessingofWisdom",
            ["Type"] = "Class"
        }
        -- Greater Blessing of Wisdom
        GroupBuffs["Interface\\Icons\\Spell_Holy_GreaterBlessingofWisdom"] = {
            ["Lesser"] = "Interface\\Icons\\Spell_Holy_SealOfWisdom",
            ["Type"] = "Class"
        }
        -- Blessing of Salvation
        GroupBuffs["Interface\\Icons\\Spell_Holy_SealOfSalvation"] = {
            ["Greater"] = "Interface\\Icons\\Spell_Holy_GreaterBlessingofSalvation",
            ["Type"] = "Class"
        }
        -- Greater Blessing of Salvation
        GroupBuffs["Interface\\Icons\\Spell_Holy_GreaterBlessingofSalvation"] = {
            ["Lesser"] = "Interface\\Icons\\Spell_Holy_SealOfSalvation",
            ["Type"] = "Class"
        }
        -- Blessing of Kings
        GroupBuffs["Interface\\Icons\\Spell_Magic_MageArmor"] = {
            ["Greater"] = "Interface\\Icons\\Spell_Magic_GreaterBlessingofKings",
            ["Type"] = "Class"
        }
        -- Greater Blessing of Kings
        GroupBuffs["Interface\\Icons\\Spell_Magic_GreaterBlessingofKings"] = {
            ["Lesser"] = "Interface\\Icons\\Spell_Magic_MageArmor",
            ["Type"] = "Class"
        }
        -- Blessing of Light
        GroupBuffs["Interface\\Icons\\Spell_Holy_PrayerOfHealing02"] = {
            ["Greater"] = "Interface\\Icons\\Spell_Holy_GreaterBlessingofLight",
            ["Type"] = "Class"
        }
        -- Greater Blessing of Light
        GroupBuffs["Interface\\Icons\\Spell_Holy_GreaterBlessingofLight"] = {
            ["Lesser"] = "Interface\\Icons\\Spell_Holy_PrayerOfHealing02",
            ["Type"] = "Class"
        }
        -- Blessing of Sanctuary
        GroupBuffs["Interface\\Icons\\Spell_Nature_LightningShield"] = {
            ["Greater"] = "Interface\\Icons\\Spell_Holy_GreaterBlessingofSanctuary",
            ["Type"] = "Class"
        }
        -- Greater Blessing of Sanctuary
        GroupBuffs["Interface\\Icons\\Spell_Holy_GreaterBlessingofSanctuary"] = {
            ["Lesser"] = "Interface\\Icons\\Spell_Nature_LightningShield",
            ["Type"] = "Class"
        }

        if LastBuffStatusUpdate == nil then
            LastBuffStatusUpdate = math.floor(GetTime())
            BuffUpdateTime = GetTime()
        end

        UpdPerSec = { }

        for i = 0, SAMPLE_SIZE - 1 do
            UpdPerSec[i] = 0
        end
    
        BW_Options_Init()

        BW_PlayersFrame:Show()

    end

    if BW:IsVisible() then

        if event == "PLAYER_LOGIN" then

            BW_Set_UNIT_IDs()
            BW_GetAllBuffs()
            BW_ResizeWindow()
        end

        if event == "SPELLCAST_START" then
            lastspellcast = arg1
        end

        if event == "UNIT_AURA" then

--BW_Print("UNIT_AURA for " .. arg1)

            for k, v in Player_Info do

                if arg1 == v.UNIT_ID then
--BW_Print(arg1 .. " found as " .. v.Name)
                    BW_Player_GetBuffs(v)
                    BW_Player_AdjustBuffs(v)
                    BW_ResizeWindow()
                    break
                end

            end

            BW_UpdateBuffStatus()

        end

        if event == "PARTY_MEMBERS_CHANGED" or event == "RAID_ROSTER_UPDATE" or (event == "UNIT_PET" and BuffWatchConfig.ShowPets == true) then

            BW_Set_UNIT_IDs()
            BW_GetAllBuffs()
            BW_ResizeWindow()

        end

        if event == "UNIT_PVP_UPDATE" then

            local unitpet = BW_GetPetUnitID(arg1)

            for k, v in Player_Info do

                if arg1 == v.UNIT_ID or unitpet == v.UNIT_ID then
                    BW_Player_ColourName(v)
                end

            end

        end

    end

end


-- //////////////////////////////////////////////////////////////////////////////////////
-- //
-- //                Main Functions
-- //
-- //////////////////////////////////////////////////////////////////////////////////////

-- Setup basic list of possible UNIT_IDs
function BW_Set_UNIT_IDs(forced)

    local numRaidMembers = GetNumRaidMembers()

    if numRaidMembers > 0 then

        if lastgrouptype ~= "raid" or forced == true then

            UNIT_IDs = { }

            for i = 1, 40 do
                UNIT_IDs[i] = "raid" .. i
            end

            if BuffWatchConfig.ShowPets == true then
                for i = 1, 40 do
                    UNIT_IDs[i+40] = "raidpet" ..    i
                end
            end

            lastgrouptype = "raid"

        end

    elseif lastgrouptype ~= "party" or forced == true then

        UNIT_IDs = { }

        UNIT_IDs[1] = "player"
        UNIT_IDs[2] = "party1"
        UNIT_IDs[3] = "party2"
        UNIT_IDs[4] = "party3"
        UNIT_IDs[5] = "party4"

        if BuffWatchConfig.ShowPets == true then
            UNIT_IDs[6] = "pet"
            UNIT_IDs[7] = "partypet1"
            UNIT_IDs[8] = "partypet2"
            UNIT_IDs[9] = "partypet3"
            UNIT_IDs[10] = "partypet4"
        end

        lastgrouptype = "party"

    end

    BW_GetPlayerInfo()

end

--[[ Get details of each player we find in the UNIT_IDs list

    Player_Info[Name] props :

    ID - Unique number for this player, determines which playerframe to use
    UNIT_ID - UNIT_ID of this player
    Name - Players name (same as key, but useful if we are just looping array)
    Class - Players Class (for colouring name)
    IsPet - true if a pet (pets are sorted last, and can be hidden)
    SubGroup - 1 if in party, or 1-8 if in raid (Used for sorting)
    Checked - Used only in this function to determine players that are no longer present
]] --
function BW_GetPlayerInfo()

    local getnewalignpos = false

    for i = 1, table.getn(UNIT_IDs) do

        local unitname = UnitName(UNIT_IDs[i])

        if unitname ~= nil and unitname ~= "Unknown Entity" then

            -- Check if we know about this person already, if not capture basic details
            if not Player_Info[unitname] then

                local id = BW_GetNextID(unitname)
                local namebutton = getglobal("BW_Player" .. id .. "_Name")
                local nametext = getglobal("BW_Player" .. id .. "_NameText")

                Player_Info[unitname] = { }
                Player_Info[unitname]["ID"] = id
                Player_Info[unitname]["Name"] = unitname

                local _, classname = UnitClass(UNIT_IDs[i])

                if classname then
                    Player_Info[unitname]["Class"] = classname
                else
                    Player_Info[unitname]["Class"] = ""
                end

                if (lastgrouptype == "party" and i > 5) or (lastgrouptype == "raid" and i > 40) then
                    Player_Info[unitname]["IsPet"] = 1
                    Player_Info[unitname]["Class"] = ""
                else
                    Player_Info[unitname]["IsPet"] = 0
                end

                nametext:SetText(unitname)
                namebutton:SetWidth(nametext:GetStringWidth())

                if buttonalignposition < nametext:GetStringWidth() then
                    buttonalignposition = nametext:GetStringWidth()
                    buttonalignid = id
                end

                Player_Info[unitname]["UNIT_ID"] = UNIT_IDs[i]
                BW_Player_ColourName(Player_Info[unitname])

            end

            -- Update any information that may have changed about this person,
            --    if we captured before, or take for first time
            Player_Info[unitname]["UNIT_ID"] = UNIT_IDs[i]

            if lastgrouptype == "raid" then
                local j = math.mod(i, 40)
                if j == 0 then j = 40 end
                _, _, Player_Info[unitname]["SubGroup"] = GetRaidRosterInfo(j)
            else
                Player_Info[unitname]["SubGroup"] = 1
            end

            Player_Info[unitname]["Checked"] = 1

        end

    end

    -- Remove players that are no longer in the group
    for k, v in Player_Info do

        if v.Checked == 1 then
            v.Checked = 0
        else
            getglobal("BW_Player" .. v.ID):Hide()
            getglobal("BW_Player" .. v.ID .. "_NameText"):SetText(nil)

            if v.ID == buttonalignid then
                getnewalignpos = true
            end

            -- Add ID to temp array in case they come back
            -- (useful for dismissed or dead pets, or if a player leaves group briefly)
            Player_Left[v.Name] = v.ID

            Player_Info[k] = nil
        end

    end

    if getnewalignpos == true then

        buttonalignposition = 0

        for k, v in Player_Info do

            local nametext = getglobal("BW_Player" .. v.ID .. "_NameText")

            if buttonalignposition < nametext:GetStringWidth() then
                buttonalignposition = nametext:GetStringWidth()
                buttonalignid = v.ID
            end

        end

    end

end

function BW_GetAllBuffs()

    -- Setup temp array for sorting, and get buffs for all players
    for k, v in Player_Info do
        BW_Player_GetBuffs(v)
    end

-- ***** Does this need to be called here?
    BW_Player_AdjustFrames()

    -- Adjust buff icon positions
    for k, v in Player_Info do
        BW_Player_AdjustBuffs(v)
    end

end


function BW_Player_AdjustFrames()

    -- Only bother to sort player frames if we can see them
    if not minimized then

        local firstplayer = true
        local previousplayer
        local Player_Copy = { }

        for k, v in Player_Info do
            table.insert(Player_Copy, v)
        end

        -- Sort the player list in temp array
        if BuffWatchConfig.SortOrder == "Class" then

            table.sort(Player_Copy,
            function(a,b)

                if a.IsPet == b.IsPet then

                    if a.Class == b.Class then
                        return a.Name < b.Name
                    else
                        return a.Class < b.Class
                    end

                else
                    return a.IsPet < b.IsPet
                end

            end)

        elseif BuffWatchConfig.SortOrder == "Name" then

            table.sort(Player_Copy,
            function(a,b)

                if a.IsPet == b.IsPet then
                    return a.Name < b.Name
                else
                    return a.IsPet < b.IsPet
                end

            end)

        else -- Default

            table.sort(Player_Copy,
            function(a,b)

                if a.IsPet == b.IsPet then

                    if a.SubGroup == b.SubGroup then
                        return a.UNIT_ID < b.UNIT_ID
                    else
                        return a.SubGroup < b.SubGroup
                    end

                else
                    return a.IsPet < b.IsPet
                end

            end)
        end

        -- Position the player frames
        for k, v in Player_Copy do

            local playerframe = getglobal("BW_Player" .. v.ID)

            playerframe:ClearAllPoints()

            if playerframe:IsVisible() then

                if firstplayer then
                    playerframe:SetPoint("TOPLEFT", "BW_Background", "TOPLEFT", 1, -16)
                    previousplayer = v.ID
                    firstplayer = false
                else
                    playerframe:SetPoint("TOPLEFT", "BW_Player" .. previousplayer, "BOTTOMLEFT", 0, 0)
                    previousplayer = v.ID
                end

            end

        end

    end

end


function BW_Player_GetBuffs(v)

    local curr_lock = getglobal("BW_Player" .. v.ID .. "_Lock")

    if not curr_lock:GetChecked() then

        for j = 1, 16 do

            local texture = UnitBuff(v.UNIT_ID, j, BuffWatchConfig.ShowCastableBuffs)
            local curr_buff = getglobal("BW_Player" .. v.ID .. "_Buff" .. j)
            local curr_buff_icon = getglobal("BW_Player" .. v.ID .. "_Buff" .. j .. "Icon")

            if texture == nil then

                curr_buff:Hide()
                curr_buff_icon:SetTexture(nil)

            elseif texture then

                curr_buff:Show()
                curr_buff_icon:SetTexture(texture)

            end

        end

    end

    for j = 1, 8 do

        local curr_buff = getglobal("BW_Player" .. v.ID .. "_Debuff" .. j)

        if BuffWatchConfig.ShowDebuffs == false then

            curr_buff:Hide()

        else

            local texture = UnitDebuff(v.UNIT_ID, j, BuffWatchConfig.ShowDispellableDebuffs)
            local curr_buff_icon = getglobal("BW_Player" .. v.ID .. "_Debuff" .. j .. "Icon")

            if texture == nil then

                curr_buff:Hide()

            elseif texture then

                curr_buff:Show()
                curr_buff_icon:SetTexture(texture)

            end

        end

    end

end


function BW_Player_AdjustBuffs(v)

    local firstbutton = true
    local previousbutton

    for j = 1, 16 do

        local curr_buff = getglobal("BW_Player" .. v.ID .. "_Buff" .. j)

        if curr_buff:IsVisible() then

-- ***** Add code to sort this when buffs get hidden/shown, rather than refreshing all each time?
            curr_buff:ClearAllPoints()

            if firstbutton then
                if BuffWatchConfig.AlignBuffs == false then
                    curr_buff:SetPoint("TOPLEFT", "BW_Player" .. v.ID .. "_NameText", "TOPRIGHT", 5, 2)
                else
                    curr_buff:SetPoint("TOPLEFT", "BW_Player" .. v.ID .. "_NameText", "TOPLEFT", buttonalignposition + 5, 2)
                end
                firstbutton = false
                previousbutton = j
            else
                curr_buff:SetPoint("TOPLEFT", "BW_Player" .. v.ID .. "_Buff" .. previousbutton, "TOPRIGHT", 0, 0)
                previousbutton = j
            end

        end

    end

    local firstdebuff = true
    local previousdebuff

    for j = 1, 8 do

        local curr_debuff = getglobal("BW_Player" .. v.ID .. "_Debuff" .. j)

        if curr_debuff:IsVisible() then

-- ***** Add code to sort this when buffs get hidden/shown, rather than refreshing all each time?
            curr_debuff:ClearAllPoints()

            if firstbutton then

                if BuffWatchConfig.AlignBuffs == false then
                    curr_debuff:SetPoint("TOPLEFT", "BW_Player" .. v.ID .. "_NameText", "TOPRIGHT", 5, 2)
                else
                    curr_debuff:SetPoint("TOPLEFT", "BW_Player" .. v.ID .. "_NameText", "TOPLEFT", buttonalignposition + 5, 2)
                end
                firstbutton = false
                previousbutton = j
                firstdebuff = false
                previousdebuff = j

            elseif firstdebuff then

                curr_debuff:SetPoint("TOPLEFT", "BW_Player" .. v.ID .. "_Buff" .. previousbutton, "TOPRIGHT", 0, 0)
                firstdebuff = false
                previousdebuff = j

            else

                curr_debuff:SetPoint("TOPLEFT", "BW_Player" .. v.ID .. "_Debuff" .. previousdebuff, "TOPRIGHT", 0, 0)
                previousdebuff = j

            end

        end

    end

end


function BW_ColourAllNames()

    for k, v in Player_Info do
        BW_Player_ColourName(v)
    end

end


function BW_Player_ColourName(v)

    local nametext = getglobal("BW_Player" .. v.ID .. "_NameText")

    if BuffWatchConfig.HighlightPvP and UnitIsPVP(v.UNIT_ID) then

        nametext:SetTextColor(0.0, 1.0, 0.0)

    else

        if v.Class ~= "" then

            local color = RAID_CLASS_COLORS[v.Class]

            if color then
                nametext:SetTextColor(color.r, color.g, color.b)
            else
                nametext:SetTextColor(1.0, 0.9, 0.8)
            end

        else
            nametext:SetTextColor(1.0, 0.9, 0.8)
        end

    end

end


function BW_ResizeWindow()

    local bottomcoord = 0
    local height = 0
    local rightcoord = 0
    local width = 0

    for k, v in Player_Info do

        if not minimized then
            local playerframe = getglobal("BW_Player" .. v.ID)

            if playerframe:GetBottom() ~= nil and playerframe:IsVisible() then
                if bottomcoord > playerframe:GetBottom() or bottomcoord == 0 then
                    bottomcoord = playerframe:GetBottom()
                end
            end
        end

        for j = 1, 16 do
            local curr_buff = getglobal("BW_Player" .. v.ID .. "_Buff" .. j)

            if curr_buff:IsShown() and curr_buff:GetRight() then
                if curr_buff:GetRight() > rightcoord then
                    rightcoord = curr_buff:GetRight()
                end
            end
        end

        for j = 1, 8 do
            local curr_buff = getglobal("BW_Player" .. v.ID .. "_Debuff" .. j)

            if curr_buff:IsShown() and curr_buff:GetRight() then
                if curr_buff:GetRight() > rightcoord then
                    rightcoord = curr_buff:GetRight()
                end
            end
        end

    end

    if minimized then
        height = 20
    else
        if bottomcoord and bottomcoord ~= 0 then
            if BuffWatchConfig.ShowUpdPerSec == true then
                height = BW_Background:GetTop() - bottomcoord + 25
            else
                height = BW_Background:GetTop() - bottomcoord + 15
            end
            if height < 65 then height = 65 end
        else
            height = 65
        end
    end

    if rightcoord and rightcoord ~= 0 then
        width = rightcoord - BW_Background:GetLeft() + 20
        if width < 100 then width = 100 end
    else
        width = 100
    end

    BW_Background:SetHeight(height)
    BW:SetHeight(height)  

    BW_Background:SetWidth(width)
    BW:SetWidth(width)

end

function BW_UpdateUPS()

    local TimeDiff = math.floor(GetTime() - LastBuffStatusUpdate)

    if TimeDiff == 0 then
        UpdPerSec[CurrSec] = UpdPerSec[CurrSec] + 1
    elseif TimeDiff < SAMPLE_SIZE then

        for i = 0, TimeDiff - 2 do

            CurrSec = math.mod(CurrSec + 1, SAMPLE_SIZE)

            UpdPerSec[CurrSec] = 0

        end

        CurrSec = math.mod(CurrSec + 1, SAMPLE_SIZE)

        UpdPerSec[CurrSec] = 1

    else

        for i = 0, SAMPLE_SIZE - 1 do
            UpdPerSec[i] = 0
        end

        CurrSec = math.mod(CurrSec + TimeDiff, SAMPLE_SIZE)

        UpdPerSec[CurrSec] = 1

    end

    LastBuffStatusUpdate = math.floor(GetTime())
    
    if BuffWatchConfig.ShowUpdPerSec == true then

        local UPS = 0

        for i = 0, SAMPLE_SIZE - 1 do

            UPS = UPS + UpdPerSec[i]

        end

        UPS = UPS / SAMPLE_SIZE

        BW_UPS:SetText("UPS = " .. format("%4.1f", UPS))
    
    end

end


function BW_UpdateBuffStatus(forced)

    if BuffWatchConfig.UpdPerSec > 0 then

        if (BuffUpdateTime + (1 / BuffWatchConfig.UpdPerSec) < GetTime()) or forced == true then
            BuffUpdateTime = GetTime()
            BuffUpdatePending = false
        else
            BuffUpdatePending = true
            return
        end
    
    end
    
    local hasbuffexpired = false
    local playerframechanges = false
    
    BW_UpdateUPS()

    for k, v in Player_Info do

        local player = "BW_Player" .. v.ID
        local playerframe = getglobal(player)
        local playerbuffexpired = false
        local playerhasbuffs = false
        local playerhasdebuffs = false
        local showframe = true

        if getglobal(player .. "_Lock"):GetChecked() then

            for j = 1, 16 do

                -- Check if there is a buff in this slot
                if getglobal(player .. "_Buff" .. j):IsShown() then

                    playerhasbuffs = true

                    -- If player is linkdead or dead in game, grey buffs out so user doesnt try to buff them
                    if UnitIsDeadOrGhost(v.UNIT_ID) or UnitIsConnected(v.UNIT_ID) == nil then

                        getglobal(player .. "_Buff" .. j .. "Icon"):SetVertexColor(0.4,0.4,0.4)

                    else

                        local Flag_BuffFound = false
                        local texture = getglobal(player .. "_Buff" .. j .. "Icon"):GetTexture()

                        -- See if we can find this buff on the player still
                        for j_2 = 1, 16 do
                            if UnitBuff(v.UNIT_ID, j_2) == texture then
                                Flag_BuffFound = true
                                break
                            end
                        end

                        -- If not found, check if lesser or greater exists instead
                        if Flag_BuffFound == false then

                            if GroupBuffs[texture] and not GroupBuffs[texture].ByName then

                                if GroupBuffs[texture].Lesser then

                                    texture = GroupBuffs[texture].Lesser

                                elseif GroupBuffs[texture].Greater then

                                    texture = GroupBuffs[texture].Greater

                                end

                                for j_2 = 1, 16 do
                                    if UnitBuff(v.UNIT_ID, j_2) == texture then
                                        Flag_BuffFound = true
                                        getglobal(player .. "_Buff" .. j .. "Icon"):SetTexture(texture)
                                        break
                                    end
                                end

                            end

                        end

                        -- If buff has expired, highlight it red
                        if Flag_BuffFound then
                            getglobal(player .. "_Buff" .. j .. "Icon"):SetVertexColor(1,1,1)
                        else
                            getglobal(player .. "_Buff" .. j .. "Icon"):SetVertexColor(1,0,0)

                            if BuffWatchConfig.ExpiredWarning and buffexpired ~= true then
                                UIErrorsFrame:AddMessage("A buffwatch monitored buff has expired!", 0.2, 0.9, 0.9, 1.0, 2.0)
                                buffexpired = true
                                
                                if BuffWatchConfig.ExpiredSound then
                                    PlaySound("igQuestFailed")
                                end

                                if minimized then
                                    BW_HeaderText:SetTextColor(1, 0, 0)
                                end

                            end
                            hasbuffexpired = true
                            playerbuffexpired = true
                        end

                    end

                end

            end
            
            if BuffWatchConfig.DebuffsAlwaysVisible == true then
            
                for j = 1, 8 do

                    -- Check if there is a debuff in this slot
                    if getglobal(player .. "_Debuff" .. j):IsShown() then
                        playerhasdebuffs = true
                        break
                    end

                end
                
            end
            
            -- Determine whether we should show or hide this player
            if playerhasdebuffs == true then
                showframe = true
            else
            
                if HideMonitored == true then

                    if HideUnmonitored == false then

                        if playerhasbuffs == true then
                            showframe = playerbuffexpired
                        else
                            showframe = true
                        end

                    else
                        showframe = playerbuffexpired
                    end

                else

                    if HideUnmonitored == false then
                        -- We are not hiding monitored or unmonitored, so show the playerframe
                        showframe = true
                    else

                        -- Just hiding Unmonitored, so determine if any buffs are locked
                        if playerhasbuffs == true then
                            showframe = true
                        else
                            showframe = false
                        end

                    end

                end
                
            end

        else
            -- Player is unchecked, so show
            showframe = true

            -- Make sure buffs are not highlighted
            for j = 1, 16 do

                -- Check if there is a buff in this slot
                if getglobal(player .. "_Buff" .. j):IsShown() then
                    getglobal(player .. "_Buff" .. j .. "Icon"):SetVertexColor(1,1,1)
                end

            end

        end

        if showframe == true then
            if not playerframe:IsShown() then
                playerframe:Show()
                playerframechanges = true
            end
        else
            if playerframe:IsShown() then
                playerframe:Hide()
                playerframechanges = true
            end
        end

    end

    buffexpired = hasbuffexpired

    if buffexpired == false then
        BW_HeaderText:SetTextColor(0.2, 0.9, 0.9)
    end

    if playerframechanges == true then
        BW_Player_AdjustFrames()
    end

end

-- //////////////////////////////////////////////////////////////////////////////////////
-- //
-- //                Slash Commands
-- //
-- //////////////////////////////////////////////////////////////////////////////////////

function BW_SlashHandler(msg)

    msg = string.lower(msg)

    if msg == "toggle" then

        BW_Toggle()

    elseif msg == "set" then

        BW_SetRightMouse()

    elseif msg == "options" then

        BW_OptionsToggle()

    elseif msg == "" or msg == "help" then

        BW_ShowHelp()

    else

        BW_Print("BuffWatch: Invalid Command or Parameter")

    end

end

-- //////////////////////////////////////////////////////////////////////////////////////
-- //
-- //                Mouse Events
-- //
-- //////////////////////////////////////////////////////////////////////////////////////

function BW_OnMouseDown(arg1)
    if arg1 == "LeftButton" then
        BW:StartMoving()
    end
end


function BW_OnMouseUp(arg1)
    if arg1 == "LeftButton" then
        BW:StopMovingOrSizing()
    end
end


function BW_MouseIsOverFrame()

    if MouseIsOver(BW) then

        BW_MinimizeButton:Show()

        if not minimized then

            BW_OptionsButton:Show()
            BW_HideUnmonitoredButton:Show()
            BW_HideMonitoredButton:Show()
            BW_Lock_All:Show()

            for k, v in Player_Info do
                getglobal("BW_Player" .. v.ID .. "_Lock"):Show()
            end

        else
            BW_Lock_All:Hide()
        end

    else

        if not minimized then

            BW_MinimizeButton:Hide()
            BW_OptionsButton:Hide()
            BW_HideUnmonitoredButton:Hide()
            BW_HideMonitoredButton:Hide()

            for k, v in Player_Info do
                getglobal("BW_Player" .. v.ID .. "_Lock"):Hide()
            end
        end

        BW_Lock_All:Hide()

    end

end


function BW_Check_Clicked()

    local checked = this:GetChecked()

    if checked then

        for k, v in Player_Info do

            local curr_lock = getglobal("BW_Player" .. v.ID .. "_Lock")

--            if curr_lock:IsVisible() then
                if not curr_lock:GetChecked() then
                    checked = nil
                    break
                end
--            end

        end

        if checked then
            BW_Lock_All:SetChecked(true)
        end

    else
        BW_Lock_All:SetChecked(false)
    end

end


function BW_Name_Clicked(button)

    local id = this:GetParent():GetID()

    local playername = getglobal("BW_Player" .. id .. "_NameText"):GetText()

    if button == "LeftButton" then
        TargetByName(playername)
    elseif button == "RightButton" then
        AssistByName(playername)
    end

end


function BW_Buff_Clicked(button)

    local buffid = this:GetID()
    local playerid = this:GetParent():GetID()
    local playername = getglobal("BW_Player" .. playerid .. "_NameText"):GetText()
    local playerframe =  "BW_Player" .. playerid

    if button == "LeftButton" then

        local spellid = nil
        local spelltexture = getglobal(this:GetName() .. "Icon"):GetTexture()

        for i = 1, 300 do
            if GetSpellTexture(i, 1) == spelltexture then
                spellid = i
            end
        end

        if spellid then

            if BuffWatchConfig.PreventPvPBuff and UnitIsPVP(Player_Info[playername].UNIT_ID) then

                BW_Print(playername .. " is PvP Flagged, aborted casting.")

            elseif UnitIsVisible(Player_Info[playername].UNIT_ID) then

                if UnitName("target") and not UnitIsEnemy("target","player") then
                    if UnitName("target") ~= playername then
                        TargetByName(playername)
                    end
                end

                if IsShiftKeyDown() then
                    SendChatMessage(format("BW: Casting %s on %s", GetSpellName(spellid,1), playername), "PARTY")
                end

                -- Check if it's a group buff or a lesser version.
                if GroupBuffs[spelltexture] then

                    local castgreater = false
                    local newspelltexture = nil

                    -- Check Buff Threshold for whether to cast single or group
                    if BuffWatchConfig.BuffThreshold > 0 and
                        (GetNumPartyMembers() >= (BuffWatchConfig.BuffThreshold - 1) or GetNumRaidMembers() >= BuffWatchConfig.BuffThreshold) then

                        local castcount = 0
                        local otherspelltexture
                        local pvpflagfound

                        if GroupBuffs[spelltexture].Greater then
                            otherspelltexture = GroupBuffs[spelltexture].Greater
                        else
                            otherspelltexture = GroupBuffs[spelltexture].Lesser
                        end

                        -- Check if we have other spell, and save OtherSpellID
                        if not GroupBuffs[spelltexture].OtherSpellID then

                            if GroupBuffs[spelltexture].ByName then

                                for i = 1, 300 do
                                    local spellName, _ = GetSpellName(i, 1)
                                    if spellName == otherspelltexture then
                                        GroupBuffs[spelltexture].OtherSpellID = i
                                    end
                                end

                            else

                                for i = 1, 300 do
                                    if GetSpellTexture(i, 1) == otherspelltexture then
                                        GroupBuffs[spelltexture].OtherSpellID = i
                                    end
                                end

                            end

                            if not GroupBuffs[spelltexture].OtherSpellID then
                                -- Player doesnt have greater spell
                                GroupBuffs[spelltexture].OtherSpellID = 0
                            end

                        end

                        -- Check whether to cast greater or lesser. If we dont have greater, then skip.
                        if GroupBuffs[spelltexture].OtherSpellID ~= 0 then

                            for k, v in Player_Info do

                                local Flag_BuffFound = false

                                -- Find players with same SubGroup/Class
                                if Player_Info[v.Name].IsPet == 0 and v[GroupBuffs[spelltexture].Type] == Player_Info[playername][GroupBuffs[spelltexture].Type] then

                                    if BuffWatchConfig.PreventPvPBuff then

                                        if UnitIsPVP(v.UNIT_ID) then
                                            pvpflagfound = v.Name -- Enforce a single buff to be cast
                                        end

                                    end

                                    -- Check for missing buff
                                    for j = 1, 16 do
                                        if UnitBuff(v.UNIT_ID, j) == spelltexture or UnitBuff(v.UNIT_ID, j) == otherspelltexture then
                                            Flag_BuffFound = true
                                            break
                                        end
                                    end

                                    if Flag_BuffFound == false then
                                        castcount = castcount + 1
                                    end

                                end

                            end

                            if castcount >= BuffWatchConfig.BuffThreshold then
                                if pvpflagfound then
                                    BW_Print(pvpflagfound .. " is PvP Flagged, casting single version buff.")
                                else
                                    castgreater = true
                                end
                            end

                        end

                    end

                    if castgreater then
                        newspelltexture = GroupBuffs[spelltexture].Greater
                    else
                        newspelltexture = GroupBuffs[spelltexture].Lesser
                    end

                    if newspelltexture then

                        if GroupBuffs[spelltexture].OtherSpellID then

                            spellid = GroupBuffs[spelltexture].OtherSpellID

                        else

                            for i = 1, 300 do
                                if GetSpellTexture(i, 1) == newspelltexture then
                                    spellid = i
                                    GroupBuffs[spelltexture].OtherSpellID = i
                                end
                            end

                        end

                    end

                end

                CastSpell(spellid, 1)

                if SpellIsTargeting() then
                    TargetByName(playername)
                end

            else

                BW_Print(playername .. " is out of range or not visible.")

            end

        end

    elseif button == "RightButton" then

        if getglobal(playerframe .. "_Lock"):GetChecked() and IsControlKeyDown() then

            this:Hide()
            BW_Player_AdjustBuffs(Player_Info[playername])
            BW_ResizeWindow()

        elseif getglobal(playerframe .. "_Lock"):GetChecked() and IsAltKeyDown() then

            for i = 1, 16 do
                if i ~= buffid then
                    getglobal(playerframe .. "_Buff" .. i):Hide()
                end
            end

            BW_Player_AdjustBuffs(Player_Info[playername])
            BW_ResizeWindow()

        else

            if BuffWatchConfig.rightMouseSpell then
                if UnitName("target") and not UnitIsEnemy("target","player") then
                    if UnitName("target") ~= playername then
                        TargetByName(playername)
                    end
                end

                if IsShiftKeyDown() then
                    SendChatMessage(format("BW: Casting %s on %s", GetSpellName(BuffWatchConfig.rightMouseSpell,1), playername), "PARTY")
                end

                CastSpell(BuffWatchConfig.rightMouseSpell,1)

                if SpellIsTargeting() then
                    TargetByName(playername)
                end

            else

                BW_Print("     BuffWatch: Right mouse button spell has not yet been set.")
                BW_Print("                Cast any spell with a duration. Then type \"/bw set\"")

            end

        end

    end

end


function BW_Buff_Tooltip()

    local playername = getglobal("BW_Player" .. this:GetParent():GetID() .. "_NameText"):GetText()
    local buffbuttonid = nil
    local debuffbuttonid = nil
    local texture = getglobal(this:GetName() .. "Icon"):GetTexture()

    for i = 1, 16 do
        if UnitBuff(Player_Info[playername]["UNIT_ID"], i) == texture then
            buffbuttonid = i
            break
        end
    end

    if buffbuttonid == nil then
        for i_2 = 1, 8 do
            if UnitDebuff(Player_Info[playername]["UNIT_ID"], i_2) == texture then
                debuffbuttonid = i_2
                break
            end
        end
    end

    if buffbuttonid then
        GameTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT")
        GameTooltip:SetUnitBuff(Player_Info[playername]["UNIT_ID"], buffbuttonid)
    elseif debuffbuttonid then
        GameTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT")
        GameTooltip:SetUnitDebuff(Player_Info[playername]["UNIT_ID"], debuffbuttonid)
    end

end


function BW_Set_AllChecks(checked)

    for k, v in Player_Info do
        getglobal("BW_Player" .. v.ID .. "_Lock"):SetChecked(checked)
    end

end


function BW_Header_Clicked(button)

    if button == "LeftButton" then
        BW_Set_UNIT_IDs()
        BW_GetAllBuffs()
        BW_UpdateBuffStatus()
        BW_ResizeWindow()
    end

    if button == "RightButton" then
        BW_Toggle()
    end

end


function BW_MinimizeButton_Clicked()

    minimized = not minimized

    if minimized == true then
        BW_PlayersFrame:Hide()
    else
        BW_PlayersFrame:Show()
    end

    BW_ResizeWindow()
    BW_MouseIsOverFrame()

end

function BW_HideUnmonitored_Clicked()

    HideUnmonitored = not HideUnmonitored

    BW_Player_AdjustFrames()
    BW_ResizeWindow()

    BW_HideUnmonitored_OnEnter()

end

function BW_HideUnmonitored_OnEnter()

    GameTooltip:SetOwner(this, "ANCHOR_BOTTOM")

    if HideUnmonitored == true then
        GameTooltip:SetText("Hiding Unmonitored")
    else
        GameTooltip:SetText("Showing Unmonitored")
    end

end

function BW_HideMonitored_Clicked()

    HideMonitored = not HideMonitored

    BW_Player_AdjustFrames()
    BW_ResizeWindow()

    BW_HideMonitored_OnEnter()

end

function BW_HideMonitored_OnEnter()

    GameTooltip:SetOwner(this, "ANCHOR_BOTTOM")

    if HideMonitored == true then
        GameTooltip:SetText("Hiding Monitored")
    else
        GameTooltip:SetText("Showing Monitored")
    end

end

-- //////////////////////////////////////////////////////////////////////////////////////
-- //
-- //                Miscellaneous
-- //
-- //////////////////////////////////////////////////////////////////////////////////////

function BW_Toggle()

    if BW:IsVisible() then
        HideUIPanel(BW)
    else
        ShowUIPanel(BW)
    end

end


function BW_OptionsToggle()

    if not BW_Options:IsVisible() then
        ShowUIPanel(BW_Options)
    else
        HideUIPanel(BW_Options)
    end

end


function BW_SetRightMouse()

    if lastspellcast == nil then

        BW_Print("     BuffWatch: You have not cast any timed spells yet:")
        BW_Print("                        Cast one, and then try \"/bw set\" again")

    else

        for i = 1, 300 do
            if GetSpellName(i,1) == lastspellcast then
                BuffWatchConfig.rightMouseSpell = i
--                    break
            end
        end

        if BuffWatchConfig.rightMouseSpell then
            BW_Print( format("BuffWatch: Right mouse button set to %s (%s)",
              GetSpellName(BuffWatchConfig.rightMouseSpell,1) ), 0.2, 0.9, 0.9 )
        end

    end

end


function GetLen(arr)

    local len = 0

    if arr ~= nil then

        for k, v in arr do
            len = len + 1
        end

    end

    return len
end


function BW_GetNextID(unitname)

    local i = 1

    if GetLen(Player_Info) == 0 then

        return i

    else

        local oldID = Player_Left[unitname]

        if oldID then

            local found = false

            for k, v in Player_Info do
                if v.ID == oldID then
                    found = true
                    break
                end
            end

            Player_Left[unitname] = nil

            if found == false then
--                getglobal("BW_Player" .. oldID):Show()
                return oldID
            end

        end

        local Player_Copy = { }

        for k, v in Player_Info do
            table.insert(Player_Copy, v)
        end

        table.sort(Player_Copy, function(a,b)
            return a.ID < b.ID
            end)

        for k, v in Player_Copy do

            if i ~= v.ID then
                break
            end

            i = i + 1

        end

        Player_Copy = nil

    end

    getglobal("BW_Player" .. i .. "_Lock"):SetChecked(false)

    return i

end


function BW_GetPetUnitID(unitid)

--    if lastgrouptype == "party" then

        if unitid == "player" then
            return "pet", 1
        end

        return string.gsub(unitid, "([a-z]+)([0-9]+)", "%1pet%2")

--[[        return "partypet" .. string.sub(unitid, -1)

    else
        return "raidpet" .. string.sub(unitid, 5)
    end
]]--
end


-- //////////////////////////////////////////////////////////////////////////////////////
-- //
-- //    BuffWatch Print Function
-- //
-- //////////////////////////////////////////////////////////////////////////////////////

function BW_Print(msg, R, G, B)

    DEFAULT_CHAT_FRAME:AddMessage(msg, R, G, B);

end

-- //////////////////////////////////////////////////////////////////////////////////////
-- //
-- //    BuffWatch Help
-- //
-- //////////////////////////////////////////////////////////////////////////////////////

function BW_ShowHelp()

    BW_HelpFrame:Show()
    BW_HelpFrame:ClearAllPoints()
    BW_HelpFrame:SetPoint("CENTER","UIParent","CENTER",0,-32)

    BW_HelpFrameText:SetText(

"        - BuffWatch Usage - v " .. BW_VERSION .. " - " .. [[

        Show/Hide the BuffWatch window:
             - Bind a keyboard button to show/hide the window
             - You can also close it by right clicking the "BuffWatch" label (appears on mouseover)

        Showing Buffs:
             - Left click the BuffWatch label
             - Also occurs automatically whenever your gain/lose a party or raid member

        Locking a player's watched buffs:
             - If the checkbox to the left is unchecked, buffs will be added automatically whenever they gain a buff
             - If checked, buffs will not be added, or removed

        Rebuffing:
             - Left click an icon (will auto-target)

        Right click spell:
             - Cast any spell with a cast time (not instant). Then type "/bw set"
             - To cast it, right click any icon (will auto-target)

        Deleting buffs:
             - Lock the player's buffs (check the box). Then [ CTRL + Right Click ] on the buff
             - Optionally, [ ALT + Right Click ] to delete all but the selected one.

        Slash Commands ( Use /buffwatch or /bw )
             - /bw toggle : shows/hides the window
             - /bw options : shows/hides the options window
             - /bw : shows this help menu :)

        Verbosity:
             - Hold [ Shift ] while left or right-clicking a buff icon to send a cast message to your party
        ]] )

end

-- //////////////////////////////////////////////////////////////////////////////////////
