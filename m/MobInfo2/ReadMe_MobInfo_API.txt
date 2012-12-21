
--
-- This file explains in great detail all information and functions of
-- the MobInfo2 external API and the built-in MobHealth external API.
-- (API = Application Programmers Interface)
--
-- It tells you how to best check for the presence of the AddOn(s) and
-- provides functions for easy access to the MobInfo database and the
-- MobHealth database.
--
-- There are 3 sections:
--
--   Section 1 : How to best check if (any) MobHealth AddOn is available ?
--   Section 2 : Functions for accessing ALL MobHealth data 
--   Section 3 : Functions for accessing ALL MobInfo data 
--   Section 4 : Free Source Code for Accessing MobHealth in a Compatible Way


-- ==========================================================================
-- Section 1 : How to best check if (any) MobHealth AddOn is available ?
-- ==========================================================================
--
-- Info: there are at present three known AddOns that provide MobHealth
-- functionality and MobHealth data : "MobHealth by Telo", "MobHealth2
-- by Wyv" and MobInfo2. All three AddOns provide their service in
-- extremely similar, almost identical fashion.
--
-- The best way to check whether any one MobHealth service is available
-- is to add this simple "if" to your "VARIABLES_LOADED" event handler:
--
-- if  MobHealthFrame  then
--   ......
-- end
--
-- Its all that is required. If the condition is true you can rest
-- assured that one of the MobHealth AddOns is present. Please do NOT
-- place the check into the "OnLoad" event handler. That is potentially
-- unsave and error prone. "OnLoad" is called at a time where NOT all
-- AddOns have been loaded. On the other hand "VARIABLES_LOADED" is
-- invoked at a time when you can be sure that ALL AddOns have been
-- loaded and can thus be checked for and accessed.
-- ==========================================================================


-- ==========================================================================
-- Section 2 : Functions for accessing ALL MobHealth data 
-- ==========================================================================
--
-- Note that Telos MobHealth (sadly!) does not offer such interface
-- functions. They got invented by MobHealth2. They get officially supported
-- by MobInfo. I will suggest to Telo to add them to his MobHealth
-- AddOn as well for the sake of compatibility.
--
-- This is the RECOMMENDED way to access the MobHealth data. Using the
-- functions make you independant of how the data is stored internally
-- within the AddOns database. Please do NOT access the AddOns database
-- variable directly. Instead ALWAYS use one of the three functions 
-- listed below.
--
-- In the future I plan to make considerable changes to the way that
-- MobHealth stores its data. This will have great advantages for the
-- AddOn, but will result in problems for AddOns that access the database
-- variable directly. The source code for these functions is in
-- "MI2_Health.lua".
--
-- Additional compatibility note:
-- ------------------------------
-- In order to retain compatibility to Telos MobHealth you will have to
-- support both : a) the direct access to "MobHealthDB" and b) the
-- indirect access using the functions below. Here is an example of
-- how to do that (works for all 3 functions):
--
-- if  MobHealth_PPP  then
--   ... code that uses "MobHealth_PPP()"
-- else
--   ... your old code that uses "MobHealthDB"
-- end
--
-- To make it easier for you I have decided to simply supply you with the
-- entire necessary source code right here, for free. Go to section 4 and
-- simply copy the source code of the 3 local functions you find there
-- into your own AddOn. They are 100% compatible with the interface of
-- the 3 functions that I offer right here in section 2.
--
-----------------------------------------------------------------------------
-- function MobHealth_GetTargetCurHP()  
--
-- Return current health points value for the current target as an integer
-- value. Return nil if there is no current target.
--
-- Example:
--   local targetCurrentHealth = MobHealth_GetTargetCurHP();
--   if  targetCurrentHealth  then
--      .......
--   end
-----------------------------------------------------------------------------
-
-----------------------------------------------------------------------------
-- function MobHealth_GetTargetMaxHP()  
--
-- Return maximum health points value for the current target as an integer
-- value. Return nil if there is no current target.
--
-- Example:
--   local targetMaxHealth = MobHealth_GetTargetMaxHP();
--   if  targetMaxHealth  then
--      .......
--   end
-----------------------------------------------------------------------------
--
-----------------------------------------------------------------------------
-- function MobHealth_PPP( index )  
--
-- Return the Points-Per-Percent (PPP) value for a Mob identified by its index.
-- The index is the concatination of the Mob name and the Mob level (see
-- example below). 0 is returned if the PPP value is not available for
-- the given index. The example also shows how to calculate the actual
-- health points from the health percentage and the PPP value
--
-- Example:
--    local name  = UnitName("target");
--    local level = UnitLevel("target");
--    local index = name..":"..level;
--    local ppp = MobHealth_PPP( index );
--    local healthPercent = UnitHealth("target");
--    local curHealth = math.floor( healthPercent * ppp + 0.5);
--    local maxHealth = math.floor( 100 * ppp + 0.5);
-----------------------------------------------------------------------------
--
-- ==========================================================================


-- ==========================================================================
-- Section 3 : Functions for accessing ALL MobInfo data 
-- ==========================================================================
--
-- Please ALWAYS use these functions for accessing the data in the MobInfo
-- database. This is the only safe and reliable way to access the MobInfo
-- data. For reasons of optimisation or extension the database variable(s)
-- might change spontaneously in layout and/or name. Using the interface
-- functions gives you the guarantee that you always get returned the
-- correct data.
--
-----------------------------------------------------------------------------
-- MI2_GetMobData( mobName, mobLevel [, unitId] )
--
-- Get and return all the data that MobInfo knows about a given mob.
-- This is an externally available interface function that can be
-- called by other AddOns to access MobInfo data. It should be fast,
-- efficient, and easy to use
--
-- The data describing a Mob is returned in table form as described below.
--
-- To identify the mob you must supply its name and level. You can
-- optionally supply a "unitId" to get additional info:
--   mobName : name of mob, eg. "Forest Lurker"
--   mobLevel : mob level as integer number
--   unitId : optional WoW unit identification, should be either
--            "target" or "mouseover"
--
-- Examples:
--    A.   mobData = MI2_GetMobData( "Forest Lurker", 10 )
--    B.   mobData = MI2_GetMobData( "Forest Lurker", 10, "target" )
--
-- Return Value:
-- The return value is a LUA table with one table entry for each value that
-- MobInfo can know about a Mob. Note that table entries exist ONLY if the
-- corresponding value has actually been collected for the given Mob.
-- Unrecorded values do NOT exist in the table and thus evaluate to a NIL
-- expression.
--
-- Values you can get without "unitId" (as per Example A above):
--    mobData.healthMax  :  health maximum
--    mobData.xp         :  experience value
--    mobData.kills      :  number of times current player has killed this mob
--    mobData.minDamage  :  minimum damage done by mob
--    mobData.maxDamage  :  maximum damage done by mob
--    mobData.dps        :  dps of Mon against current player
--    mobData.loots      :  number of times this mob has been looted
--    mobData.emptyLoots :  number of times this mob gave empty loot
--    mobData.clothCount :  number of times this mob gave cloth loot
--    mobData.copper     :  total money loot of this mob as copper amount
--    mobData.itemValue  :  total item value loot of this mob as copper amount
--    mobData.mobType    :  mob type for special mobs: 1=normal, 2=rare/elite, 3=boss
--    mobData.r1         :  number of rarity 1 loot items (grey)
--    mobData.r2         :  number of rarity 2 loot items (white)
--    mobData.r3         :  number of rarity 3 loot items (green)
--    mobData.r4         :  number of rarity 4 loot items (blue)
--    mobData.r5         :  number of rarity 5 loot items (purple)
--    mobData.itemList   :  table that lists all recorded items looted from this mob
--                          table entry index gives WoW item ID, 
--                          table entry value gives item amount
--
-- Additional values you will get with "unitId" (as per Example B above):
--    mobData.class      :  class of mob as localized text
--    mobData.healthCur  :  current health of given unit
--    mobData.manaCur    :  current mana of given unit
--    mobData.manaMax    :  maximum mana for given unit
--
-- Code Example:
--    
--    local mobData = MI2_GetMobData( "Forest Lurker", 10 )
--    
--    if mobData.xp then
--        DEFAULT_CHAT_FRAME:AddMessage( "XP = "..mobData.xp ) 
--    end
--    
--    if mobData.copper and mobData.loots then
--        local avgLoot = mobData.copper / mobData.loots
--        DEFAULT_CHAT_FRAME:AddMessage( "average loot = "..avgLoot ) 
--    end
-----------------------------------------------------------------------------
--
-- ==========================================================================


-- ==========================================================================
-- Section 4 : Free Source Code for Accessing MobHealth in a Compatible Way
-- ==========================================================================
--
-- Simply copy the entire 3 function source code given below into your own
-- AddOn and then call the 3 functions whenever you have to access MobHealth
-- data.
--


-----------------------------------------------------------------------------
-- My_MobHealth_PPP( index )  
--
-- Return the Points-Per-Percent (PPP) value for a Mob identified by its index.
-- The index is the concatination of the Mob name and the Mob level (see
-- example below). 0 is returned if the PPP value is not available for
-- the given index. The example also shows how to calculate the actual
-- health points from the health percentage and the PPP value
--
-- Example:
--    local name  = UnitName("target");
--    local level = UnitLevel("target");
--    local index = name..":"..level;
--    local ppp = MobHealth_PPP( index );
--    local healthPercent = UnitHealth("target");
--    local curHealth = math.floor( healthPercent * ppp + 0.5);
--    local maxHealth = math.floor( 100 * ppp + 0.5);
-----------------------------------------------------------------------------
local function My_MobHealth_PPP( index )
  if  MobHealth_PPP  then
    return MobHealth_PPP( index );
  else
	if( index and MobHealthDB[index] ) then
		local s, e, pts, pct = string.find(MobHealthDB[index], "^(%d+)/(%d+)$");
		if( pts and pct ) then
			pts = pts + 0;
			pct = pct + 0;
			if( pct ~= 0 ) then
				return pts / pct;
			end
		end
	end
	return 0;
  end
end  -- of My_MobHealth_PPP


-----------------------------------------------------------------------------
-- My_MobHealth_GetTargetCurHP()  
--
-- Return current health points value for the current target as an integer
-- value. Return nil if there is no current target.
--
-- Example:
--   local targetCurrentHealth = MobHealth_GetTargetCurHP();
--   if  targetCurrentHealth  then
--      .......
--   end
-----------------------------------------------------------------------------
local function My_MobHealth_GetTargetCurHP()
  if  MobHealth_GetTargetCurHP  then
    return MobHealth_GetTargetCurHP();
  else
    local name  = UnitName("target");
    local level = UnitLevel("target");
    local healthPercent = UnitHealth("target");
    if  name  and  level  and  healthPercent  then
      local index = name..":"..level;
      local ppp = MobHealth_PPP( index );
      return math.floor( healthPercent * ppp + 0.5);
    end
  end
  return 0;
end  -- of My_MobHealth_GetTargetCurHP()


-----------------------------------------------------------------------------
-- My_MobHealth_GetTargetMaxHP()  
--
-- Return maximum health points value for the current target as an integer
-- value. Return nil if there is no current target.
--
-- Example:
--   local targetMaxHealth = MobHealth_GetTargetMaxHP();
--   if  targetMaxHealth  then
--      .......
--   end
-----------------------------------------------------------------------------
local function My_MobHealth_GetTargetMaxHP()
  if  MobHealth_GetTargetMaxHP  then
    return MobHealth_GetTargetMaxHP();
  else
    local name  = UnitName("target");
    local level = UnitLevel("target");
    if  name  and  level  then
      local index = name..":"..level;
      local ppp = MobHealth_PPP( index );
      return math.floor( 100 * ppp + 0.5);
    end
  end
  return 0;
end  -- of My_MobHealth_GetTargetMaxHP()

--
-- ==========================================================================
