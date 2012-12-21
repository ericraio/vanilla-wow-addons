--------------------------------------------------------------------------
-- IsMounted.lua 
--------------------------------------------------------------------------
--[[
IsMounted

author: AnduinLothar KarlKFI@cosmosui.org

-Mini-Library that maintains a list of who's mounted.

Note: Information gathered from this addon is only correct for friendly units or units that you can see the buffs of.

Change Log:
v1.61
-Fixed nil find string error
v1.6
-Player mounted check now uses the PlayerBuff functions rather than UnitBuff.
-Player Buff ID returned now coresponds to the buff index returned from GetPlayerBuff(i, "HELPFUL|PASSIVE") and can be used directly by CancelPlayerBuff.
-Dismount now works correctly with debuffs.
-Localed a few internal functions for quicker indexing
v1.5
- Mounted status now accurate when called from PLAYER_AURAS_CHANGED and not cleared on UNIT_AURA
(UNIT_AURA w/ arg1=="player" is always called after PLAYER_AURAS_CHANGED.) 
v1.4
- Changed tooltip scan to use IsShown to work with 1.9
v1.3
- Added French and German Localizations
v1.2
- Added Function: Dismount()
- Added Function: UnitMountSpeed(unit)
- Added Function: UnitMountBuffID( string unit )
- Changed all refrences of 'buff slot' to 'id' 
Note: id is the id of the buff in terms of Tooltip/Texture index that starts at 1 while the Buff/Frame index starts at 0. So you might have to subtract 1 till blizz fixes it next patch, depending on your usage.
v1.1
- Fixed but that would throw error when UNIT_AURA triggered for 'mouseover' unit. (I Didn't know it caught mouseover O.o)
v1.0
- Initial Release
]]--

--------------------------------------------------
-- Globals
--------------------------------------------------

IsMounted = {};

-- Predictibly consistant units
IsMounted.UnitTable = {
	player = {};
	target = {};
}
for i=1, 4 do IsMounted.UnitTable["party"..i] = {} end
for i=1, 40 do IsMounted.UnitTable["raid"..i] = {} end

--------------------------------------------------
-- Internal Functions
--------------------------------------------------

IsMounted.OnLoad = function()
	IsMountedFrame:RegisterEvent("PLAYER_AURAS_CHANGED");
	IsMountedFrame:RegisterEvent("UNIT_AURA");
	IsMountedFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
	IsMountedFrame:RegisterEvent("PARTY_MEMBERS_CHANGED");
	IsMountedFrame:RegisterEvent("RAID_ROSTER_UPDATE");
	IsMountedFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
	IsMountedTooltip:SetOwner(UIParent, "ANCHOR_NONE");
end

-- Nils predictibly consistant stored values when the unit or its buffs change
IsMounted.OnEvent = function(event)
	if (event == "PLAYER_ENTERING_WORLD") then
		IsMounted.UnitTable["player"].speed = nil;
		IsMounted.UnitTable["player"].id = nil;
	elseif (event == "PLAYER_AURAS_CHANGED") then
		--Sea.io.print("player IsMounted mount state nilled.");
		IsMounted.UnitTable["player"].speed = nil;
		IsMounted.UnitTable["player"].id = nil;
	elseif (event == "UNIT_AURA") then
		if (not IsMounted.UnitTable[arg1]) then
			--Triggered by 'mouseover' buff change
			--Sea.io.print("UNIT_AURA: ", arg1);
		elseif (arg1 ~= "player") then
			--Sea.io.print(arg1, " IsMounted mount state nilled.");
			IsMounted.UnitTable[arg1].speed = nil;
			IsMounted.UnitTable[arg1].id = nil;
		end
	elseif (event == "PLAYER_TARGET_CHANGED") then
		IsMounted.UnitTable["target"].speed = nil;
		IsMounted.UnitTable["target"].id = nil;
	elseif (event == "PARTY_MEMBERS_CHANGED") then
		for i=1, 4 do
			IsMounted.UnitTable["party"..i].speed = nil;
			IsMounted.UnitTable["party"..i].id = nil;
		end
	elseif (event == "RAID_ROSTER_UPDATE") then
		for i=1, 40 do
			IsMounted.UnitTable["raid"..i].speed = nil;
			IsMounted.UnitTable["raid"..i].id = nil;
		end
	end
end

-- Sets stored values of predictibly consistant units and returns the speed and id of the mount buff.
local GetUpdatedUnitTable = function(unit)
	local speed, id = IsMounted.GetUpdatedMountBuffInfo(unit);
	if (IsMounted.UnitTable[unit]) then
		--Sea.io.print("Updating UnitTable for ".. unit..": ", speed, ", ", id); -- debug msg
		IsMounted.UnitTable[unit].speed = speed;
		IsMounted.UnitTable[unit].id = id;
	end
	return speed, id;
end


-- Gets speed and id of player mount buff according to GetPlayerBuff
local GetPlayerMountBuffInfo = function()
	-- Check the tooltips of the player's active buffs for the key string.
	local text, buffIndex, untilCancelled, _, speed;
	for i = 0, 23 do
		buffIndex, untilCancelled = GetPlayerBuff(i, "HELPFUL|PASSIVE");
		if ( buffIndex < 0 ) then
			break;
		elseif ( untilCancelled ) then
			IsMountedTooltip:SetPlayerBuff(buffIndex);
			if (IsMountedTooltipTextLeft2:IsShown()) then
				text = IsMountedTooltipTextLeft2:GetText();
				if (text) then
					_, _, speed = string.find(text, ISMOUNTED_SPEED_INCREASED_BY);
					if (speed) then
						return tonumber(speed), buffIndex;
					end
				end
			end
		end
	end
	return false;
end

-- Gets speed and id of non-player mount buff according to UnitBuff
local GetNonPlayerMountBuffInfo = function(unit)
	-- Check the tooltips of the unit's active buffs for the key string.
	local text, _, speed;
	for i = 1, 24 do
		if (not UnitBuff(unit, i)) then
			break;
		end
		IsMountedTooltip:SetUnitBuff(unit, i);
		if (IsMountedTooltipTextLeft2:IsShown()) then
			text = IsMountedTooltipTextLeft2:GetText();
			if (text) then
				--Sea.io.print("Checking text: ".. text); -- debug msg
				_, _, speed = string.find(text, ISMOUNTED_SPEED_INCREASED_BY);
				if (speed) then
					return tonumber(speed), i;
				end
			end
		end
	end
	return false;
end

--------------------------------------------------
-- User Functions
--------------------------------------------------

-- 
-- UnitIsMounted( string unit )
--
--	EX: if (UnitIsMounted("player")) then doSomething(); end
--
-- Returns: 
-- 	(Boolean isMounted)
--	isMounted - 1 if mounted, else nil
-- 
function UnitIsMounted(unit)
	if (IsMounted.GetMountBuffInfo(unit)) then
		return 1;
	end
end

-- 
-- Dismount()
--
--	EX: if (Dismount()) then print("I'm Dismounting"); end
--	Macro EX: /dismount
--
-- Returns: 
-- 	(Boolean wasMounted)
--	wasMounted - 1 if was mounted, else nil
-- 
function Dismount()
	local speed, id = IsMounted.GetMountBuffInfo("player");
	if (speed) then
		CancelPlayerBuff(id);
		return 1;
	end
end

SlashCmdList["DISMOUNT"] = Dismount;
SLASH_DISMOUNT1 = "/dismount";

--[[
SlashCmdList["LAG"] = function(msg) 
	local n, _, t, spell = strfind(msg, "(%d-[%.%d]%d-) (.*)", 1);
	if (not n) then
		n, _, t = strfind(msg, "(%d-[%.%d]%d-)", 1);
	end
	local endTime = GetTime() + t;
	while (GetTime() < endTime)  do
	end
	if (spell) then
		CastSpellByName(spell);
	end
end
SLASH_LAG1 = "/lag";
]]--

-- 
-- UnitMountSpeed( string unit )
--
--	EX: local speed = UnitMountSpeed("target")
--
-- Returns: 
-- 	(Number speed)
-- 	speed - percent speed increase of the mount (60 or 100) if unit is mounted,
--			false if mount is not found
-- 
function UnitMountSpeed(unit)
	local speed, id = IsMounted.GetMountBuffInfo(unit);
	return speed;
end

-- 
-- UnitMountBuffID( string unit )
--
--	EX: local id = UnitMountBuffID("target")
--
-- Returns: 
-- 	(Number id)
-- 	id - the buff id id of the mount, nil if mount is not found or unit doesn't exist
-- 
function UnitMountBuffID(unit)
	local speed, id = IsMounted.GetMountBuffInfo(unit);
	return id;
end

-- 
-- IsMounted.GetMountBuffInfo( string unit )
-- 
--	EX: local speed, id = IsMounted.GetMountBuffInfo("player")
--
-- Returns: 
-- 	(Number speed, Number id)
-- 	speed - percent speed increase of the mount (60 or 100) if unit is mounted,
--			false if mount is not found
--	id - the buff id id of the mount, nil if mount is not found or unit doesn't exist
--
IsMounted.GetMountBuffInfo = function(unit)
	if (IsMounted.UnitTable[unit]) and (IsMounted.UnitTable[unit].speed ~= nil) then
		return IsMounted.UnitTable[unit].speed, IsMounted.UnitTable[unit].id;
	end
	return GetUpdatedUnitTable(unit);
end

-- 
-- IsMounted.GetUpdatedMountBuffInfo( string unit )
-- 
--	Gets Updated Mount Buff Info (duh!)
--
-- Returns: 
-- 	(Number speed, Number id)
-- 	speed - percent speed increase of the mount (60 or 100) if unit is mounted,
--			false if mount is not found (so that we know it's been checked since last changed)
--	id - the buff id id of the mount, nil if mount is not found or unit doesn't exist
--
IsMounted.GetUpdatedMountBuffInfo = function(unit)
	if (UnitIsPlayer(unit)) then
		if ( (not IsMounted.UnitTable[unit]) or (unit == "target") ) and (UnitIsFriend("player", unit)) then
			-- This unit check will always check 46 stored tables for saved speed, but it should hopefully still be faster than setting and checking the tooltips of the unit's active buffs.
			for u, i in IsMounted.UnitTable do
				if (i.speed ~= nil) and (UnitIsUnit(unit, u)) then
					--Sea.io.print(unit, " is ", u);	-- debug msg
					if (unit == "target") then
						--only store the info for the unit if it is predictibly consistant
						IsMounted.UnitTable.target.speed = i.speed;
						IsMounted.UnitTable.target.id = i.id;
					end
					return i.speed, i.id;
				end
			end
		end
		
		if (unit == "player") then
			return GetPlayerMountBuffInfo();
		else
			return GetNonPlayerMountBuffInfo(unit);
		end
	end
	return false;
end
