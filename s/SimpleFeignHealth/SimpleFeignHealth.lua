--
-- Simple Feign Health - by Brodrick ( aka Kirov )
-- Version 2.0
--
-- Continues to show the player's health and mana values after they've feigned death.
-- Also attempts to show party / raid hunters' health and mana after they FD using
-- last known valid numbers.
--
-- Attempts to keep track of a player's mana regen, as well as mana gains or drains.
-- Show accurate health for all FDed hunters in the player's group.
--


SimpleFeignHealth_Saved = {};

-- local vars
local ValidUnits = {};
--SFH_ValidUnits = ValidUnits; -- for debugging
local manaRegen,
	manaRegenLast,
	manaRegenStart,
	
	player,
	playerUnit,
	
	cacheUnit,
	cacheMana,
	cacheHealth,
	
	frame,
	tooltip,
	statusbar;

-- hooked functions
local oldUnitHealth = UnitHealth;
local oldUnitMana = UnitMana;
local oldUnitIsDead = UnitIsDead;

-- local references for often used globals
local unitManaMax = UnitManaMax;
local unitStat = UnitStat;
local unitName = UnitName;
local getTime = GetTime;

local function print( msg )
	DEFAULT_CHAT_FRAME:AddMessage( msg );
end

-- hack to prevent needless recalculation of the player's mana regen
-- which gets around the OnEvent order problem causing mis-matched results.
local function clearCache()
	cacheHealth = nil;
	cacheMana = nil;
	this:GetScript("OnUpdate", nil);
end

-- all grouped units' health --
-------------------------------
local function getHealth(unit)
	if ( tooltip ) then
		if ( not cacheUnit or cacheUnit ~= unit ) then
			if ( not cacheUnit ) then
				frame:SetScript("OnUpdate", clearCache);
			end
			tooltip:SetUnit(unit);
			cacheUnit = unit;
			cacheHealth = nil;
		end
		if ( not cacheHealth ) then
			cacheHealth = statusbar:GetValue();
		end
		return cacheHealth;
	end
	return 0;
end

-- player's mana regen --
-------------------------
local function getManaRegen()
	if ( not cacheMana ) then
		cacheMana = playerUnit[2];
		if ( manaRegenTime ) then
			if ( manaRegenLast ) then
				manaRegenTime = manaRegenTime + getTime() - manaRegenLast;
				manaRegenLast = getTime();
			end
			local base, spirit = unitStat("player", 5);
			local time = (manaRegenTime - mod(manaRegenTime, 2));
			manaRegenTime = manaRegenTime - time;
			local regen = max(floor((spirit * time / 2 * 0.2) + ( time / 2 * 15 )),0);
			cacheMana = min( cacheMana + regen, unitManaMax("player") );
			playerUnit[2] = cacheMana;
			manaRegen = manaRegen + regen;
		end
		frame:SetScript("OnUpdate",clearCache);
	end
	return cacheMana;
end

-- add hunters to valid list --
-------------------------------
local function checkForHunters()
	if ( SimpleFeignHealth_Saved["noparty"] ) then return; end
	local raidNum = GetNumRaidMembers();
	local partyNum = GetNumPartyMembers();
	if ( raidNum > 0 ) then
		for i=1, raidNum do
			local unit = "raid"..i;
			local _,class = UnitClass(unit);
			if ( class == "HUNTER" ) then
				local name = unitName( unit );
				if ( not ValidUnits[name] ) then
					ValidUnits[name] = {unit,oldUnitMana(unit)};
				elseif ( name ~= player ) then
					ValidUnits[name][1] = unit;
				end
			end
		end
	elseif ( partyNum > 0 ) then
		for i=1, partyNum do
			local unit = "party"..i;
			local _,class = UnitClass(unit);
			if ( class == "HUNTER" ) then
				local name = unitName(unit);
				if ( not ValidUnits[name] ) then
					ValidUnits[name] = {unit,oldUnitMana(unit)};
				elseif ( name ~= player ) then
					ValidUnits[name][1] = unit;
				end
			end
		end
	else -- cull all but player from list
		for k, v in pairs(ValidUnits) do
			if ( k ~= player ) then
				v = nil;
			end
		end
	end
end


-- check for fd --
------------------
local function checkFeign( unit )
	local i, name, texture = 1, unitName(unit);
	repeat
		texture = UnitBuff( unit, i );
		if ( texture == "Interface\\Icons\\Ability_Rogue_FeignDeath" ) then
			ValidUnits[name][3] = 1;
			return 1;
		end
		i = i + 1;
	until not texture;
	ValidUnits[name][3] = nil;
end


-- initialization --
--------------------
frame = CreateFrame("frame","SFH_Frame");
frame:RegisterEvent("PLAYER_ENTERING_WORLD");

local function enable()
	local _,class = UnitClass("player");
	if ( class == "HUNTER" ) then
		frame:RegisterEvent("MIRROR_TIMER_START");
		frame:RegisterEvent("MIRROR_TIMER_STOP");
		player = unitName("player");
		ValidUnits[player] = {"player", oldUnitMana("player")};
		playerUnit = ValidUnits[player];
		--SFH_PlayerUnit = ValidUnits[player]; -- for debugging
	end
	checkForHunters();
	frame:RegisterEvent("UNIT_MANA");
	frame:RegisterEvent("UNIT_AURA");
	frame:RegisterEvent("PARTY_MEMBERS_CHANGED");
	if ( not tooltip ) then
		tooltip = CreateFrame("GameTooltip","SFH_Tooltip",UIParent,"GameTooltipTemplate");
		tooltip:SetOwner(tooltip,"ANCHOR_NONE");
		statusbar = tooltip:GetChildren();
	end
end

local function disable()
	ValidUnits = {};
	frame:UnregisterEvent("MIRROR_TIMER_START");
	frame:UnregisterEvent("MIRROR_TIMER_STOP");
	frame:UnregisterEvent("UNIT_MANA");
	frame:UnregisterEvent("UNIT_AURA");
	frame:UnregisterEvent("PARTY_MEMBERS_CHANGED");
end

local function init()
	print( "SimpleFeignHealh : loaded - /sfh" );

	SLASH_SFEIGNHEALTH1 = "/sfh";
	SLASH_SFEIGNHEALTH2 = "/simplefeignhealth";
	SLASH_SFEIGNHEALTH3 = "/feignhealth";
	SlashCmdList["SFEIGNHEALTH"] = SimpleFeignHealth_Console;
	
	if ( not SimpleFeignHealth_Saved["disable"] ) then
		enable();
	end
end


-- event catching --
--------------------
frame:SetScript("OnEvent", function()
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		this:UnregisterEvent("PLAYER_ENTERING_WORLD");
		init();
	elseif ( event == "MIRROR_TIMER_START" ) then
		if ( arg1 == "FEIGNDEATH" ) then
			this:RegisterEvent("COMBAT_TEXT_UPDATE");
			manaRegenLast = getTime();
			manaRegenTime = -4;
			manaRegen = 0;
		end
	elseif ( event == "MIRROR_TIMER_STOP" ) then
		if ( arg1 == "FEIGNDEATH" ) then
			this:UnregisterEvent("COMBAT_TEXT_UPDATE");
		end
	elseif ( event == "PARTY_MEMBERS_CHANGED" ) then
		-- Find hunters in party / raid
		checkForHunters();
	elseif ( event == "COMBAT_TEXT_UPDATE" ) then
		if ( not playerUnit[3] ) then return; end
		if ( arg1 == "MANA" ) then
			playerUnit[2] = max(min(playerUnit[2] + arg2,unitManaMax("player")),0);
		end
	else
		local name = unitName(arg1);
		if ( event == "UNIT_MANA" ) then
			if ( ValidUnits[name] ) then
				local mana = oldUnitMana( arg1 );
				if ( mana > 0 ) then
					-- Keep track of all valid units' mana before FD
					ValidUnits[name][2] = mana;
				end
			end
		elseif ( event == "UNIT_AURA" ) then
			if ( ValidUnits[name] ) then
				checkFeign(arg1);
			end
		end
	end
end
);


-- console commands --
----------------------
function SimpleFeignHealth_Console( msg )
	if ( string.sub( strlower( msg ), 1, 5 ) == "party" ) then
		if ( SimpleFeignHealth_Saved["noparty"] ) then
			SimpleFeignHealth_Saved["noparty"] = nil;
			checkForHunters();
			print( "SimpleFeignHealh : enabled for party hunters" );
		else
			SimpleFeignHealth_Saved["noparty"] = 1;
			for k, v in ValidUnits do
				if ( k ~= player ) then
					ValidUnits[k] = nil;
				end
			end
			print( "SimpleFeignHealh : disabled for party hunters" );
		end
	elseif ( string.sub( strlower( msg ), 1, 2 ) == "on" ) then
		enable();
		SimpleFeignHealth_Saved["disable"] = nil;
		print( "SimpleFeignHealh : enabled" );
	elseif ( string.sub( strlower( msg ), 1, 3 ) == "off" ) then
		disable();
		SimpleFeignHealth_Saved["disable"] = 1;
		print( "SimpleFeignHealh : disabled" );
	elseif ( string.sub( strlower( msg ), 1, 6 ) == "toggle" ) then
		if ( SimpleFeignHealth_Saved["disable"] ) then
			SimpleFeignHealth_Saved["disable"] = nil;
			enable();
			print( "SimpleFeignHealh : enabled" );
		else
			SimpleFeignHealth_Saved["disable"] = 1;
			disable();
			print( "SimpleFeignHealh : disabled" );
		end
	else
		if ( SimpleFeignHealth_Saved["disable"] ) then
			print( "SimpleFeignHealh : /sfh : currently disabled" );
		else
			print( "SimpleFeignHealh : /sfh : currently enabled" );
		end
		print( "on / off / toggle - enable and disable this mod" );
		if ( SimpleFeignHealth_Saved["noparty"] ) then
			print( "party hunters disabled" );
		else
			print( "party hunters enabled" );
		end
		print( "party - toggle showing heath / mana values for partied hunters" );
	end
end


-- hook functions --
--------------------
function UnitHealth( unit )
	local health = oldUnitHealth( unit );
	local name = unitName(unit);
	if ( health == 0 and ValidUnits[name] and (ValidUnits[name][3] or checkFeign(unit)) ) then
		return getHealth(unit);
	end
	return health;
end

function UnitMana( unit )
	local mana = oldUnitMana( unit );
	local name = unitName(unit);
	if ( mana == 0 and ValidUnits[name] and (ValidUnits[name][3] or checkFeign(unit)) ) then
		if ( player and name == player ) then
			return getManaRegen();
		elseif ( ValidUnits[name][3] ) then
			return ValidUnits[name][2];
		end
	end
	return mana;
end

function UnitIsDead( unit )
	local dead = oldUnitIsDead( unit );
	local name = unitName(unit);
	if ( dead and ValidUnits[name] and (ValidUnits[name][3] or checkFeign(unit)) ) then
		return;
	end
	return dead;
end