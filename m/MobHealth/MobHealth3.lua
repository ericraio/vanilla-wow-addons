--[[
	$Id: MobHealth3.lua 14223 2006-10-18 10:49:11Z hshh $
	MobHealth3!
		"Man, this mofo lasts forever!" "Dude, it only has 700hp and you're a paladin -_-"

	By Neronix of Hellscream EU
		With tons of contributions by Mikk

	Special thanks to the following:
		Mikk for writing the algorithm used now, helping with the metamethod proxy and for some optimisation info
		Vika for creating the algorithm used in the frst 4 generations of this mod. Traces of it still remain today
		Cladhaire, the current WatchDog maintainer for giving me permission to use Vika's algorithm
		Ckknight for the pseudo event handler idea used in the second generation
		Mikma for risking wiping his UBRS raid while testing the really borked first generation
		Subyara of Hellscream EU for helping me test whether UnitPlayerControlled returns 1 for MC'd mobs
		Iceroth for his feedback on how to solve the event handler order problem in the first generation
		AndreasG for his feedback on how to solve the event handler order problem in the first generation and for being the first person to support MH3 in his mod
		Worf for his input on what the API should be like
		All the idlers in #wowace for testing and feedback

	API Documentation: http://wiki.wowace.com/index.php/MobHealth3_API_Documentation
--]]

MobHealth3 = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0")

--[[
	File-scope local vars
--]]

local MH3Cache = {}

local AccumulatorHP = {} -- Keeps Damage-taken data for mobs that we've actually poked during this session
local AccumulatorPerc = {} -- Keeps Percentage-taken data for mobs that we've actually poked during this session
local calculationUnneeded = {} -- Keeps a list of things that don't need calculation (e.g. Beast Lore'd mobs)

local currentAccHP
local currentAccPerc

local targetName, targetLevel, targetIndex
local recentDamage, totalDamage = 0, 0
local startPercent, lastPercent = 100, 100

local defaults = {
    saveData = false,
    precision = 10,
    stableMax = false,
}

-- Metatable that provides compat for mods that index MobHealthDB directly
local compatMT ={
    __index = function(t, k)
        return MH3Cache[k] and MH3Cache[k].."/100";
    end
}

-- Debug function. Not for Joe Average
function GetMH3Cache() return MH3Cache end


--[[
	Init/Enable methods
--]]

function MobHealth3:OnInitialize()
	-- If config savedvars don't exist, create them
	MobHealth3Config = MobHealth3Config or defaults

	-- If the user is saving data, then load it into the cache
	if MobHealth3DB and MobHealth3Config.saveData then
		MH3Cache = MobHealth3DB
	elseif (MobHealth3Config.saveData) then
		MobHealth3DB = MH3Cache
	end

	self:RegisterChatCommand({"/mobhealth3", "/mh3"}, {
		type = "group",
		args = {
			save = {
				name = "Save Data",
				desc = "Save data across sessions. This is optional, and |cff00ff00not really needed|r. A cache is always kept that has data for every enemy you fought this session. Remember, recalculating an enemy's health is |cff00ff00TRIVIAL|r",
				type = "toggle",
				get = function() return not not MobHealth3DB end, -- "Double negatives for the not lose!" -Wobin
				set = function(val)
					if val == false then
						MobHealth3DB = nil
						MobHealth3Config.saveData = val
					else
						MobHealth3DB = MH3Cache
						MobHealth3Config.saveData = val
					end
				end,
			},
			precision = {
				name = "Estimation Precision",
				desc = "Adjust how accurate you want MobHealth3 to be (A number 2-99). This is how many percent a mob's health needs to to change before we will trust the estimated maximum health and display it. The lower this value is, the quicker you'll see a value and the less accurate it will be. Raiding players may want to turn this down a bit. If you don't care about accuracy and want info ASAP, set this to 1.",
				type = "range",
				step = 1,
				min = 1,
				max = 99,
				get = function() return MobHealth3Config.precision end,
				set = function(val) MobHealth3Config.precision = tonumber(val) end,
			},
            stablemax = {
                name = "Stable Max",
                desc = "When turned on, the max HP only updates once your target changes. If data for the target is unknown, MH3 will update once during the battle when the precision percentage is reached",
                type = "toggle",
                get = function() return MobHealth3Config.stableMax end,
                set = function(val) MobHealth3Config.stableMax = val end,
            },
            reset = {
                name = "Reset Cache/DB",
                desc = "Reset the session cache and the DB if you have saving turned on",
                type = "execute",
                func = function()
                    MH3Cache = {}
                    AccumulatorHP = {}
                    AccumulatorPerc = {}
                    MobHealth3DB = MobHealth3Config.saveData and {} or nil
                    self:Print("Cache/Database reset")
                end,
            },
		},
	})

    -- MH/MH2 database converter. MI2 too if the user follows the instructions
    if MobHealthDB and not MobHealthDB.thisIsADummyTable then
        -- Turn on saving
        MobHealth3DB = MH3Cache
        MobHealth3Config.saveData = true

        for k,v in pairs(MobHealthDB) do
            local _, _, pts, pct = string.find(v, "(%d+)/(%d+)")
            if pts then
                local maxHP = math.floor(pts/pct * 100 + 0.5)
                MH3Cache[k] = maxHP
            end
        end
        self:Print("Old MobHealth/MobHealth2/MobInfo2 database detected and converted. MH3 has also automatically turned on saving for you to preserve the data")
    end

    MobHealthDB = { thisIsADummyTable = true }
    setmetatable(MobHealthDB, compatMT) -- Metamethod proxy ENGAGE!! </cheesiness>
end

function MobHealth3:OnEnable()
	self:RegisterEvent("UNIT_COMBAT")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("UNIT_HEALTH")
end

--[[
	Dummy MobHealthFrame. Some mods use this to detect MH/MH2/MI2
--]]

CreateFrame("frame", "MobHealthFrame")

--[[
    Event Handlers
--]]

function MobHealth3:UNIT_COMBAT()
	if arg1=="target" and currentAccHP then
		recentDamage = recentDamage + arg4
		totalDamage = totalDamage + arg4
	end
end

function MobHealth3:PLAYER_TARGET_CHANGED()
    if MobHealth3Config.stableMax and currentAccHP and currentAccHP > 0 and currentAccPerc > 0 then
        -- Save now if we have actual values (0 /0 --> 1.#IND == BAD)
        MH3Cache[targetIndex] = math.floor( currentAccHP / currentAccPerc * 100 + 0.5 )
    end

	-- Is target valid?
	-- We ignore pets. There's simply far too many pets that share names with players so we let players take priority

	local creatureType = UnitCreatureType("target") -- Saves us from calling it twice
	if UnitCanAttack("player", "target") and not UnitIsDead("target") and not UnitIsFriend("player", "target") and not ( (creatureType == MOBHEALTH_UnitCreatureType_Beast or creatureType == MOBHEALTH_UnitCreatureType_Demon) and UnitPlayerControlled("target") ) then

		targetName = UnitName("target")
		targetLevel = UnitLevel("target")

		targetIndex = string.format("%s:%d", targetName, targetLevel)

		--self:Debug("Acquired valid target: index: %s, in db: %s", targetIndex, not not MH3Cache[targetIndex])

		recentDamage, totalDamage = 0, 0, 0
		startPercent = UnitHealth("target")
		lastPercent = startPercent

		currentAccHP = AccumulatorHP[targetIndex]
		currentAccPerc = AccumulatorPerc[targetIndex]

		if not UnitIsPlayer("target") then
			-- Mob: keep accumulated percentage below 200% in case we hit mobs with different hp
			if not currentAccHP then
				if MH3Cache[targetIndex] then
					-- We claim that this previous value that we have is from seeing percentage drop from 100 to 0
					AccumulatorHP[targetIndex] = MH3Cache[targetIndex]
					AccumulatorPerc[targetIndex] = 100
				else
					-- Nothing previously known. Start fresh.
					AccumulatorHP[targetIndex] = 0
					AccumulatorPerc[targetIndex] = 0
				end
				currentAccHP = AccumulatorHP[targetIndex]
				currentAccPerc = AccumulatorPerc[targetIndex]
			end

			if currentAccPerc>200 then
				currentAccHP = currentAccHP / currentAccPerc * 100
				currentAccPerc = 100
			end

		else
			-- Player health can change a lot. Different gear, buffs, etc.. we only assume that we've seen 10% knocked off players previously
			if not currentAccHP then
				if MH3Cache[targetIndex] then
					AccumulatorHP[targetIndex] = MH3Cache[targetIndex]*0.1
					AccumulatorPerc[targetIndex] = 10
				else
					AccumulatorHP[targetIndex] = 0
					AccumulatorPerc[targetIndex] = 0
				end
				currentAccHP = AccumulatorHP[targetIndex]
				currentAccPerc = AccumulatorPerc[targetIndex]
			end

			if currentAccPerc>10 then
				currentAccHP = currentAccHP / currentAccPerc * 10
				currentAccPerc = 10
			end

		end

	else
		--self:Debug("Acquired invalid target. Ignoring")
		currentAccHP = nil
		currentAccPerc = nil
	end
end

function MobHealth3:UNIT_HEALTH()
	if currentAccHP and arg1=="target" then
		self:CalculateMaxHealth(UnitHealth("target"), UnitHealthMax("target"))
	end
end

--[[
	The meat of the machine!
--]]

function MobHealth3:CalculateMaxHealth(current, max)

	if calculationUnneeded[targetIndex] then return;

    elseif current==startPercent or current==0 then
	--self:Debug("Targetting a dead guy?")

    elseif max > 100 then
        -- zOMG! Beast Lore! We no need no stinking calculations!
        MH3Cache[targetIndex] = max
        -- print(string.format("We got beast lore! Max is %d", max))
        calculationUnneeded[targetIndex] = true

	elseif current > lastPercent or startPercent>100 then
		-- Oh noes! It healed! :O
		lastPercent = current
		startPercent = current
		recentDamage=0
		totalDamage=0
		--self:Debug("O NOES IT HEALED!?")

	elseif recentDamage>0 then

		if current~=lastPercent then
			currentAccHP = currentAccHP + recentDamage
			currentAccPerc = currentAccPerc + (lastPercent-current)
			recentDamage = 0
			lastPercent = current

			if currentAccPerc >= MobHealth3Config.precision and not (MobHealth3Config.stableMax and MH3Cache[targetIndex]) then
				MH3Cache[targetIndex] = math.floor( currentAccHP / currentAccPerc * 100 + 0.5 )
				--self:Debug("Caching %s as %d", targetIndex, MH3Cache[targetIndex])
			end

		end

	end
end

--[[
	Compatibility for functions MobHealth2 introduced
--]]

function MobHealth_GetTargetMaxHP()
	local currHP, maxHP, found = MobHealth3:GetUnitHealth("target", UnitHealth("target"), UnitHealthMax("target"), UnitName("target"), UnitLevel("target"))
	return found and maxHP or nil
end

function MobHealth_GetTargetCurHP()
	local currHP, maxHP, found = MobHealth3:GetUnitHealth("target", UnitHealth("target"), UnitHealthMax("target"), UnitName("target"), UnitLevel("target"))
	return found and currHP or nil
end

--[[
	Compatibility for MobHealth_PPP()
--]]

function MobHealth_PPP(index)
	return MH3Cache[index] and MH3Cache[index]/100 or 0
end

--[[
	MobHealth3 API

	I'm using MediaWiki formatting for the docs here so I can easily copy/paste if I make modifications
--]]

--[[
== MobHealth3:GetUnitHealth(unit[,current][, max][, name][, level]) ==
Returns the current and max health of the specified unit

=== Args ===
; unit : The unitID you want health for
; [current] : (optional) The value of UnitHealth(unit). Passing this if your mod knows it saves MH3 from having to call UnitHealth itself<br>
; [max] : (optional) The value of UnitHealthMax(unit). Passing this if your mod knows it saves MH3 from having to call UnitHealthMax itself<br>
; [name] : (optional) The name of the unit. Passing this if your mod knows it saves MH3 from having to call UnitName itself<br>
; [level] : (optional) The level of the unit. Passing this if your mod knows it saves MH3 from having to call UnitLevel itself

=== Returns ===
If the specified unit is alive, hostile and its true max health unknown, the absolute current and max value based on the cache's current entry<br>
If the specified unit's friendly or data was not found, returns UnitHealth(unit) and UnitHealthMax(unit)

A third return value is a boolean stating whether an estimation was found

=== Remarks ===
Remember, args 2-5 are optional and passing the args if your mod already knows them saves MH3 from having to find the data itself<br>
Don't pass level as a string. Please.<br>
MobHealth3 does the target-validty checking for you

=== Example ===
 function YourUnitFrames:UpdateTargetFrame()
 	local name, level = UnitName("target"), UnitLevel("target")
 	local cur, max, found
 	if MobHealth3 then
 		cur, max, found = MobHealth3:GetUnitHealth("target", UnitHealth("target"), UnitHealthMax("target"), name, level)
 	else
 		cur, max = UnitHealth("target"), UnitHealthMax("target")
 	end
 	YourTargetFrame.HealthText:SetText(cur .. "/" .. max)
 	YourTargetFrame.NameText:SetText(name)
 	YourTargetFrame.LevelText:SetText(level)
 end
--]]
function MobHealth3:GetUnitHealth(unit, current, max, name, level)
	if not UnitExists(unit) then return 0, 0, false; end

	current = current or UnitHealth(unit)
	max = max or UnitHealthMax(unit)
	name = name or UnitName(unit)
	level = level or UnitLevel(unit)

	-- Mini validity check.
	-- No need to do the full thing because indexing the cache and getting nil back is much faster.
	-- Remember, an invalid target should never be in the cache
	-- The only parts we actually have to do are:
        -- Pet check
        -- Beast Lore check (Does UnitHealthMax give us the real value?)

	local creatureType = UnitCreatureType(unit) -- Saves us from calling it twice
	if max == 100 and not ( (creatureType == MOBHEALTH_UnitCreatureType_Demon or creatureType == MOBHEALTH_UnitCreatureType_Beast) and UnitPlayerControlled(unit) ) then
		local maxHP = MH3Cache[string.format("%s:%d", name, level)]

		if maxHP then return math.floor(current/100 * maxHP + 0.5), maxHP, true; end
	end

	-- If not maxHP or we're dealing with an invalid target
	return current, max, false;
end