

--[[------------------------------ Development stuff start ----------------------
You schould NOT mess with this stuff you can totally kill the mod here if you don't
know what your doing, and there is NOTHING to be gained
]]--

--I do a lot (most) of development outside of WOW so here is a switch
SW_DEV_INWOW = true;

-- a util to create junk msgs to test against
SW_DEV_CREATE_JUNK_STRINGS = true;
-- just handy to have
if SW_DEV_INWOW then
	SW_DEV_CREATE_JUNK_STRINGS = false;
end
-- amount of junk do produce per regex
SW_DEV_ITEMS_PER_REGEX = 1;

-- dummy event all registered regEx will be here
SW_DEV_EVENTDUMMY = "EVENTDUMMY";
SW_DECURSEDUMMY = "DECURSEDUMMY";
--SW_DECEV = {};

SW_SpellIDLookUp = {};

-- if outside of wow add stuff here to be loaded
if not SW_DEV_INWOW then
	function GetLocale()
		return "deDE";
	end
	dofile("GlobToUseDs.lua"); -- this is not distributet with the mod (its a stripped down GlobalStrings.lua from bliz)
	--dofile("GlobalStrings-CH-xx.lua"); -- just a chinese version (core seems to work but not 100% sure)
	dofile("SW_DefaultMap.lua");
	SW_Map = SW_DefaultMap;
	dofile("console.lua");
	dofile("neutral.lua");
	--dofile("localization.DE.lua");
	dofile("init.lua");
	
	
	SW_DEV_FINDMATCH = {};
	SW_DEV_FINDCOLL = {};
	if SW_DEV_CREATE_JUNK_STRINGS then
		math.randomseed(os.time());
		SW_DEV_JUNK_STRINGS ={};
	end
	arg1="";
	
end
--added 1.4
--used to skip code while in "dev mode" this should always be true in a release
SW_LIVE_MODE = true;

-------------------------------- Development stuff END ----------------------

-- table to look up localized class names (lookup built automtically)

SW_ClassNames = {
	["DRUID"] = "",
	["HUNTER"] = "",
	["MAGE"] = "",
	["PALADIN"] = "",
	["PRIEST"] = "",
	["ROGUE"] = "",
	["SHAMAN"] = "",
	["WARLOCK"] = "",
	["WARRIOR"] = "",
};


-- the lookup table with regex generated from Blizzards global vars
-- for adding vars add them in init.lua SW_CreateRegexFromGlobals()
SW_RegEx_Lookup = {};

-- this maps events to regular expressions
-- to chage this mapping see init.lua SW_CreateEventRegexMap()
SW_EventRegexMap ={};

-- similar to SW_EventRegexMap but only with VSENVIRONMENTALDAMAGE_XXX
-- this is only checked if nothing "fit" SW_EventRegexMap
SW_EventRegexMapEnviro = {};

-- info with stuff that happened at startup
-- if in the end all was ok it will be nil
-- else it has some info to track down problems
SW_StartupLog = {};

-- this tracks events we lsten to but dont have a regex for
SW_NA_Msgs = {};

-- this is used to block the Fallback feature
-- if no regex was found for an event, the event is blocked from updating itself
-- else it would always go through all events in the event dummy 
SW_Fallback_Block = {};

-- resist stuff disabled
SW_CheckForAbsorbs = true; -- does etra check for ending (123 resisted) or (234 absorbed)etc
SW_OnlyResists = false; --if previeous is true it only does this check for resist (most interesting)

--v 0.95 added SW_S_* to saved vars 
-- table with infos
SW_S_Details = {};
-- table with heal map (who/who) info
SW_S_Healed = {};

--1.3.0 Table with spell and mana info this person casted
SW_S_SpellInfo = {};
--1.3.0 Table with mana info dmg, heal and total mana used
SW_S_ManaUsage = {};

-- "Friends" Table either self, group or raid
-- used to sperate any recorded info from people "in group"
SW_Friends = {};

-- pet to owner lookup
--SW_Pets = {}; removed 1.5 old pet mech

-- 1.5 extended pet info
SW_PetInfo = {};
SW_PetInfo["OWNER_PET"] = {};
SW_PetInfo["PET_OWNER"] = {};

--1.3.1 holds time info for DPS
--1.3.2 had to change this again time and DPS dmg are not saved anymore across sessions
SW_CombatTime = 0;
SW_CombatTimeInfo = {};
SW_DPS_Dmg =0;

SW_CombatTimeCounter =0;

--settings Table
SW_Settings = {};

-- its the player name we would look it up a LOT
SW_SELF_STRING= "";

-- the "Event Channel" - we need it a LOT
SW_Event_Channel =nil;

SW_EI_ALLOFF = false;

-- 1.5.3 used for colors of the title bars and buttons in them
SW_Registerd_BF_Titles = {};
SW_Registered_BF_TitleButtons = {};
SW_DummyColor = {1,1,1,1};

function SW_CreateSpellIDLookup()
	--SW_SpellIDLookUp = {};
	for i,v in ipairs(SW_Spellnames) do
		SW_SpellIDLookUp[v] = i;
	end
end
--------------------- START section GETINFO ---------------------------

local function SW_g1(doMe, withInfo)
	 _,_,v1 = string.find(doMe, withInfo["r"])
	 if v1 == nil then return nil; end
	return {v1};
end
local function SW_g2(doMe, withInfo)
	_,_,v1, v2 = string.find(doMe, withInfo["r"])
	if v2 == nil then return nil; end
	return {v1, v2};
end
local function SW_g3(doMe, withInfo)
	_,_,v1, v2, v3 = string.find(doMe, withInfo["r"])
	if v3 == nil then return nil; end
	return {v1, v2, v3};
end
local function SW_g4(doMe, withInfo)
	_,_,v1, v2, v3, v4 = string.find(doMe, withInfo["r"])
	if v4 == nil then return nil; end
	return {v1, v2, v3, v4};
end
local function SW_g5(doMe, withInfo)
	_,_,v1, v2, v3, v4, v5 = string.find(doMe, withInfo["r"])
	if v5 == nil then return nil; end
	return {v1, v2, v3, v4, v5};
end
local function SW_g6(doMe, withInfo)
	_,_,v1, v2, v3, v4, v5, v6 = string.find(doMe, withInfo["r"])
	if v6 == nil then return nil; end
	return {v1, v2, v3, v4, v5, v6};
end
local function SW_g7(doMe, withInfo)
	_,_,v1, v2, v3, v4, v5, v6, v7 = string.find(doMe, withInfo["r"])
	if v7 == nil then return nil; end
	return {v1, v2, v3, v4, v5, v6, v7};
end
function SW_g8(doMe, withInfo)
	_,_,v1, v2, v3, v4, v5, v6, v7, v8 = string.find(doMe, withInfo["r"])
	if v8 == nil then return nil; end
	return {v1, v2, v3, v4, v5, v6, v7, v8};
end
local function SW_g9(doMe, withInfo)
	_,_,v1, v2, v3, v4, v5, v6, v7, v8, v9 = string.find(doMe, withInfo["r"])
	if v9 == nil then return nil; end
	return {v1, v2, v3, v4, v5, v6, v7, v8, v9};
end

-- here we resort the values via the mapping that was created during the init
local function SW_sortVals(vals, withInfo)
	if vals == nil then return nil; end
	local ret = {};
	for k,v in pairs(withInfo["p"]) do
		ret[v] = vals[k];
    end
	return ret;
end

local SW_MAX_ARGS = 9;
-- a functionLookup mapping # returned arguments to a specific function
local SW_Func_Lookup = {SW_g1,SW_g2,SW_g3,SW_g4,SW_g5,SW_g6,SW_g7,SW_g8,SW_g9};
-- this actually performs the search on a string 
function SW_getInfo(doMe, withInfo )
	-- if we don't have a function  or # of captures is invlid return nil
	if withInfo["r"] == nil or withInfo["i"] > SW_MAX_ARGS or withInfo["i"] < 1  then return nil; end
	
	
	-- resort if we have to
	if withInfo["p"] == nil then
		return SW_Func_Lookup[withInfo["i"]](doMe, withInfo);
		
		--return SW_Func_Lookup[withInfo["i"]](doMe, withInfo);
	else
		return SW_sortVals(SW_Func_Lookup[withInfo["i"]](doMe, withInfo), withInfo);
	end
end

-- at the end of dmg messages there can be blocked absobed etc messages
--this returns the globalVarName, the value absorbed
-- TODO this isnt correct.. there can be multiple endings
function getEndingInfo(strIn)
	--even do the check ?
	--if not SW_CheckForAbsorbs then return nil; end  --add this on a outer level

	-- assumption here, abosrbs etc end with a ")" (seems to be true)
	if string.sub(strIn,-1)~=")" then return nil; end
	
	s,e = string.find(strIn, SW_RegEx_Lookup["RESIST_TRAILER"]["r"])
	if s ~= nil then return "RESIST_TRAILER", SW_getInfo(strIn, SW_RegEx_Lookup["RESIST_TRAILER"])[1]; end
	
	if SW_OnlyResists then return nil; end
		
	s,e = string.find(strIn, SW_RegEx_Lookup["ABSORB_TRAILER"]["r"])
	if s ~= nil then return "ABSORB_TRAILER", SW_getInfo(strIn, SW_RegEx_Lookup["ABSORB_TRAILER"])[1]; end
	s,e = string.find(strIn, SW_RegEx_Lookup["BLOCK_TRAILER"]["r"])
	if s ~= nil then return "BLOCK_TRAILER", SW_getInfo(strIn, SW_RegEx_Lookup["BLOCK_TRAILER"])[1]; end
	s,e = string.find(strIn, SW_RegEx_Lookup["VULNERABLE_TRAILER"]["r"])
	if s ~= nil then return "VULNERABLE_TRAILER", SW_getInfo(strIn, SW_RegEx_Lookup["VULNERABLE_TRAILER"])[1]; end

	return nil;
end
--------------------- END section GETINFO ---------------------------

function SW_Stats_OnLoad()
	SW_SL_Add(SW_SL["START"]);
	
	SlashCmdList["SW_STATS"] = function(msg)
		SW_SlashCommand(msg);
	end
	SLASH_SW_STATS1 = SW_RootSlashes[1];
	SLASH_SW_STATS2 = SW_RootSlashes[2];
	
	SW_CreateRegexFromGlobals();
	SW_RegisterEvents();
end

local function SW_handleMatch(event, regExName, caps)
	local re = SW_RegEx_Lookup[regExName];
	local reBI= re["basicInfo"];
	local from = reBI[1];
	local to = reBI[2];
	local what = reBI[5];
	local school = reBI[6];
	local tmp;
	local pFrom, pFromTotal, pFromWhat, pFromSchool;
	local pTo, pToWhat, pToSchool, pToRec;
	local isCrit = (re["isCrit"] ~= nil);
	
	local scrapDmg = false;
	
	--[[ START SETUP
		setup all vars from to etc
		make sure the vars are initialized
	--]]
	if from == nil then
		from = SW_PRINT_ITEM_WORLD;
	else
		if from == -1 then from = SW_SELF_STRING; else from = caps[from]; end
		if from == nil then from = "??"; end
	end 
	if to == nil then
		to = SW_PRINT_ITEM_WORLD;
	else
		if to == -1 then to = SW_SELF_STRING; else to = caps[to] end
		if to == nil then to = "??"; end
	end 
	-- 1.1.0 dont count dmg from self to self
	if reBI[3] then
		if from == to then
			scrapDmg = true;
		end
		--1.3.1 start dps timer
		if SW_CombatTimeInfo.awaitingStart and from == SW_SELF_STRING then
			SW_CombatTimeInfo.awaitingStart = false;
			SW_CombatTimeInfo.awaitingEnd = true;
		end
	end
	if what == nil then 
		what = SW_PRINT_ITEM_NORMAL;
	else
		what = caps[ reBI[5] ];
		if what == nil then what = "??"; end
	end 
	--[[ usefull for finding wrong captures
	if string.find (what, "'s") then
		SW_printStr("--START--");
		SW_printStr(what);
		SW_printStr(arg1);
		SW_printStr(regExName);
		SW_printStr(re[r]);
		SW_DumpTable(caps);
		SW_printStr("--END--");
	end
	--]]
	if school == nil then
		school = SW_PRINT_ITEM_NON_SCHOOL;
	else
		school = caps[school];
		if school == nil then school = "??"; end
	end

	pFrom = SW_S_Details[from];
	if pFrom == nil then 
		SW_S_Details[from] ={}; 
		pFrom = SW_S_Details[from];
		pFrom[SW_PRINT_ITEM_TOTAL_DONE] = {0,0};  --first = dmg; sec = heal
		pFrom[SW_PRINT_ITEM_RECIEVED] = {0,0};  --first = dmg; sec = heal
		pFrom[SW_PRINT_ITEM_TYPE] = {}; -- school info	
	end

	pFromTotal = pFrom[SW_PRINT_ITEM_TOTAL_DONE];
	
	pTo= SW_S_Details[to];
	if pTo == nil then 
		SW_S_Details[to] = {};
		pTo = SW_S_Details[to];
		pTo[SW_PRINT_ITEM_TOTAL_DONE] = {0,0};  --first = dmg; sec = heal
		pTo[SW_PRINT_ITEM_RECIEVED] = {0,0};  --first = dmg; sec = heal
		pTo[SW_PRINT_ITEM_TYPE] = {}; -- school info
	end

	pToRec = pTo[SW_PRINT_ITEM_RECIEVED];
	
	pFromWhat = pFrom[what];
	if pFromWhat == nil then 
		pFrom[what] ={0,0,0,0,0,0,0}; --dmg, heal, maxDmg, usedcount (or tick count with dots) - 1.4.1beta2 added ,maxHeal, critcountDmg, critcountHeal
		pFromWhat = pFrom[what];
	end 
	
	-- this can happen now because of the sync channel
	if pFrom[SW_PRINT_ITEM_TYPE] == nil then
		pFrom[SW_PRINT_ITEM_TYPE] = {}; 
	end
	pFromSchool = pFrom[SW_PRINT_ITEM_TYPE][school];
	if pFromSchool == nil then 
		pFrom[SW_PRINT_ITEM_TYPE][school] ={0,0,0,0,0,0}; --dmgDone, Donemax, usedCount, dmgRecieved, recivedMax, recievedCount
		pFromSchool = pFrom[SW_PRINT_ITEM_TYPE][school];
	end 
	
	-- this can happen now because of the sync channel
	if pTo[SW_PRINT_ITEM_TYPE] == nil then
		pTo[SW_PRINT_ITEM_TYPE] = {};
	end
	pToSchool = pTo[SW_PRINT_ITEM_TYPE][school];
	if pToSchool == nil then 
		pTo[SW_PRINT_ITEM_TYPE][school] ={0,0,0,0,0,0}; --dmgDone, Donemax, usedCount, dmgRecieved, recivedMax, recievedCount
		pToSchool = pTo[SW_PRINT_ITEM_TYPE][school];
	end 
	
	-- END SETUP
	
	
	-- count usage up by 1
	pFromWhat[4] = pFromWhat[4] + 1;
	
	-- dmg or heal ?
	if reBI[3] then
		
		local dmg = tonumber(caps[ reBI[3] ]);
		
		if not scrapDmg and (SW_Friends[from] ~= nil or SW_PetInfo["PET_OWNER"][from] ~= nil) then
			SW_RPS:validEvent();
		end
		if not scrapDmg then
		
			-- added 1.5 is this a pet?
			if SW_PetInfo["PET_OWNER"][from] ~= nil then
				SW_HandlePetEvent(from, true, dmg, 0);
			end
			--1.3.2 added extra counter for dps dmg
			if from == SW_SELF_STRING then
				SW_DPS_Dmg = SW_DPS_Dmg + dmg;
			end
			pFromTotal[1] = pFromTotal[1] + dmg;
			pFromWhat[1] = pFromWhat[1] + dmg;
			if dmg > pFromWhat[3] then
				pFromWhat[3] = dmg;
			end
			
			--1.4.1 beta 2 added
			if isCrit then
				pFromWhat[6] = pFromWhat[6] + 1;
			end
		end
		-- added 1.5 is this a pet?
		if SW_PetInfo["PET_OWNER"][to] ~= nil then
			SW_HandlePetEvent(to, false, dmg, 0);
		end
		pToRec[1] = pToRec[1] + dmg;
		
		if not scrapDmg then
			pFromSchool[1] = pFromSchool[1] +dmg;
			if dmg > pFromSchool[2] then
				pFromSchool[2] = dmg;
			end
			pFromSchool[3] = pFromSchool[3] + 1;
		end
		
		pToSchool[4] = pToSchool[4] + dmg;
		if dmg > pToSchool[5] then
			pToSchool[5] = dmg;
		end
		pToSchool[6] = pToSchool[6] + 1;
		
	elseif reBI[4] then
		local heal = tonumber(caps[ reBI[4] ]);
		-- added 1.5 is this a pet?
		if SW_PetInfo["PET_OWNER"][from] ~= nil then
			SW_HandlePetEvent(from, true, 0, heal);
		end
		if SW_PetInfo["PET_OWNER"][to] ~= nil then
			SW_HandlePetEvent(to, false, 0, heal);
		end
		if SW_Friends[to] ~= nil then
			--1.4.1 added nil check is this the cause of the rare error ?
			-- TODO (low prio) noticed while working on 1.5 no OH count from pets as target
			local info = SW_Friends[to]["UnitID"];
			if info == nil then
				SW_RebuildFriendList();
				if SW_Friends[to] == nil or SW_Friends[to]["UnitID"] == nil then
					SW_printStr("UnitHealthMax(nil) - SW FriendList rebuilt-- didn't help");
					return;
				end
				SW_printStr("UnitHealthMax(nil) - SW FriendList rebuilt - OK");
				
			end
			info = SW_Friends[to]["UnitID"];
			local num = UnitHealthMax(info) - UnitHealth(info) - heal;
			if num < 0 then
				num = num * (-1);
				
				if SW_S_Healed[from] == nil then
					SW_S_Healed[from] = {};
				end
				
				if SW_S_Healed[from][SW_OVERHEAL] == nil then
					SW_S_Healed[from][SW_OVERHEAL] = 0;
				end
				
				SW_S_Healed[from][SW_OVERHEAL] = SW_S_Healed[from][SW_OVERHEAL] + num;
				--SW_printStr("Over Heal in cast from "..from.." to "..to.." "..num);
			end
		end
		pFromTotal[2] = pFromTotal[2] + heal;
		pFromWhat[2] = pFromWhat[2] + heal;
		
		if heal > pFromWhat[5] then
			pFromWhat[5] = heal;
		end
		--1.4.1 beta 2 added
		if isCrit then
			pFromWhat[7] = pFromWhat[7] + 1;
		end
			
		pToRec[2] = pToRec[2] + heal;
		
		-- heal map
		
		if SW_S_Healed[from] == nil then
			SW_S_Healed[from] = {};
			SW_S_Healed[from][to] = 0;
		else
			if SW_S_Healed[from][to] == nil then
				SW_S_Healed[from][to] = 0;
			end
		end
		SW_S_Healed[from][to] = SW_S_Healed[from][to] + heal;
	end
	
	if SW_EI_ALLOFF then return; end
	--[[ --]]
	if SW_Settings["EI_ShowEvent"] then
		SW_Event_Channel:AddMessage(GREEN_FONT_COLOR_CODE..event.."->"..regExName);
	end
	if SW_Settings["EI_ShowRegEx"] then
		SW_Event_Channel:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE..SW_RegEx_Lookup[regExName]["r"]);
	end
	if SW_Settings["EI_ShowOrigStr"] then
		SW_Event_Channel:AddMessage(arg1);
	end

	
	if SW_Settings["EI_ShowMatch"] then
		if from == nil then
			from = "?";
		end
		if to == nil then
			to="?";
		end
		local sOut = string.format(SW_PRINT_INFO_FROMTO, from, to);
		
		if reBI[3] then
			if caps[ reBI[3] ] == nil then
				caps[ reBI[3] ] = "??";
			end			
			if scrapDmg then
				sOut = sOut..string.format(SW_PRINT_ITEM, SW_PRINT_ITEM_DMG, caps[ reBI[3] ]).." ("..SW_PRINT_ITEM_IGNORED..")";
			else
				sOut = sOut..string.format(SW_PRINT_ITEM, SW_PRINT_ITEM_DMG, caps[ reBI[3] ]);
			end
		end
		if reBI[4] then
			if caps[ reBI[4] ] == nil then
				caps[ reBI[4] ] = "??";
			end
			sOut = sOut..string.format(SW_PRINT_ITEM, SW_PRINT_ITEM_HEAL, caps[ reBI[4] ]);
		end
		if reBI[5] then
			if caps[ reBI[5] ] == nil then
				caps[ reBI[5] ] = "??";
			end
			sOut = sOut..string.format(SW_PRINT_ITEM, SW_PRINT_ITEM_THROUGH, caps[ reBI[5] ]);
		end
		if reBI[6] then
			if caps[ reBI[6] ] == nil then
				caps[ reBI[6] ] = "??";
			end
			sOut = sOut..string.format(SW_PRINT_ITEM, SW_PRINT_ITEM_TYPE, caps[ reBI[6] ]);
		end
		if isCrit then
			sOut = sOut..SW_PRINT_ITEM_CRIT;
		end
		SW_Event_Channel:AddMessage(sOut);
	end
	
	
end

--1.5.1 Decurse Counting
local function SW_CheckDecurse(event)
	local re;
	local reBI;
	local from;
	local to;
	local what;
	local spellID;
	local r;
	
	for _,v  in ipairs(SW_EventRegexMap[SW_DECURSEDUMMY]) do
		r = SW_getInfo(arg1, SW_RegEx_Lookup[v]);
		if r~=nil then
			re = SW_RegEx_Lookup[v];
			reBI= re["basicInfo"];
			from = reBI[1];
			to = reBI[2];
			what = reBI[5];
			
			if what == nil then 
				what = SW_PRINT_ITEM_NORMAL;
			else
				what = r[what];
				if what == nil then what = "??"; end
			end 
			
			-- this isn't perfect "what" can still be a number of false captures
			-- the lookup makes it safe though
			spellID = SW_SpellIDLookUp[what];
			if spellID ~= nil then
				if from == nil then
					from = SW_PRINT_ITEM_WORLD;
				else
					if from == -1 then from = SW_SELF_STRING; else from = r[from]; end
					if from == nil then from = "??"; end
				end 
				if to == nil then
					to = SW_PRINT_ITEM_WORLD;
				else
					if to == -1 then to = SW_SELF_STRING; else to = r[to] end
					if to == nil then to = "??"; end
				end
				
				if SW_S_SpellInfo[from] == nil then
					SW_S_SpellInfo[from] = {};
				end
				if SW_S_SpellInfo[from][SW_DECURSEDUMMY] == nil then
					SW_S_SpellInfo[from][SW_DECURSEDUMMY] = {};
				end
				if SW_S_SpellInfo[from][SW_DECURSEDUMMY]["total"] == nil then
					SW_S_SpellInfo[from][SW_DECURSEDUMMY]["total"] = 1;
				else
					SW_S_SpellInfo[from][SW_DECURSEDUMMY]["total"] = SW_S_SpellInfo[from][SW_DECURSEDUMMY]["total"] + 1;
				end
				if SW_S_SpellInfo[from][SW_DECURSEDUMMY][what] == nil then
					SW_S_SpellInfo[from][SW_DECURSEDUMMY][what] = 1;
				else
					SW_S_SpellInfo[from][SW_DECURSEDUMMY][what] = SW_S_SpellInfo[from][SW_DECURSEDUMMY][what] + 1;
				end
				--[[
				if SW_DECEV[event] == nil then
					SW_DECEV[event] = {};
				end
				table.insert(SW_DECEV[event], {from .. "; to '" .. to .. "'; " .. what, SW_RegEx_Lookup[v][r], arg1} );
				--]]
				return true;
			end	
			
		end
	end
	return false;
end
local function findEventMatch(event)
	-- only interested in stuff with numbers
	-- V0.92 Changed this regex
	--V 1.1.0 Added () -- fix for french crit vals
	-- 1.4.2 made regex a var to be localized see neutral.lua 
	if not string.find (arg1, SW_PRE_REGEX) then
		SW_CheckDecurse(event);
		return false, "NUMBER";
	end
	
	
	--[[SW_TmpMap 
		if you change this change SW_CreateEventRegexMap
		Its a map of regex to check first, point is if we find the 
		default map had erros we put these here first to enable transition
		to a new default map, why here?.. becaue here we add messages that would be handeld by other regexp
	
	if SW_TmpMap ~= nil then
		for _,v  in ipairs(SW_TmpMap) do
			r = SW_getInfo(arg1, SW_RegEx_Lookup[v]);
			if r~=nil then
				SW_lateAdd(event, v, SW_EventRegexMap, SW_Map, true);
			end
		end
	end
	--]]
	local r;
	if SW_EventRegexMap[event] ~= nil then
		for _,v  in ipairs(SW_EventRegexMap[event]) do
			r = SW_getInfo(arg1, SW_RegEx_Lookup[v]);
			if r~=nil then
				SW_handleMatch(event, v, r);
				return true;
			end
		end
	else 
		SW_printStr(RED_FONT_COLOR_CODE..SW_EMPTY_EVENT..event, 1);
	end
	local r;
	-- if we get here see if it was env dmg
	if SW_EventRegexMapEnviro[event] ~= nil then
		for _,v  in ipairs(SW_EventRegexMapEnviro[event]) do
			r = SW_getInfo(arg1, SW_RegEx_Lookup[v]);
			if r~=nil then
				SW_handleMatch(event, v, r);
				return true;
			end
		end
	end
	return false, "NF";
	
end
local function doFallback(event)
	-- we didn't find a regex that fits
	-- the SW_DEV_EVENTDUMMY has all defined that we are "listening" to
	local r;
	for _,v  in ipairs(SW_EventRegexMap[SW_DEV_EVENTDUMMY]) do
		r = SW_getInfo(arg1, SW_RegEx_Lookup[v]);
		if r~=nil then
			if string.sub(v,1,string.len("VSENVIRONMENTALDAMAGE"))=="VSENVIRONMENTALDAMAGE" then
				SW_lateAdd(event, v, SW_EventRegexMapEnviro, SW_EnviroMap);
			else
				SW_lateAdd(event, v, SW_EventRegexMap, SW_Map);
			end
				SW_handleMatch(event, v, r);
			return true;
		end
	end
	return false;
end
function SW_DoEvent(event)
	if arg1 == nil then
		SW_printStr("arg1 NIL For:"..event);
		return;
	end
	local isOk, reason = findEventMatch(event);

	if not isOk and reason == "NF" then
		SW_printStr(RED_FONT_COLOR_CODE..event, 2);
		SW_printStr(RED_FONT_COLOR_CODE.."      "..arg1, 2);
				
		if SW_Fallback_Block[event] == nil then
			
			if doFallback(event) then
				SW_printStr(GREEN_FONT_COLOR_CODE.."      "..SW_CONSOLE_FALLBACK, 2);
			else
				SW_printStr(RED_FONT_COLOR_CODE.."      "..SW_CONSOLE_NOREGEX, 2);
				SW_Fallback_Block[event] = arg1;
			end
		else
			SW_printStr(RED_FONT_COLOR_CODE.."      "..SW_FALLBACK_BLOCK_INFO, 2);
			SW_printStr(RED_FONT_COLOR_CODE.."      "..SW_CONSOLE_NOREGEX, 2);
			SW_printStr(RED_FONT_COLOR_CODE.."      "..SW_Fallback_Block[event], 2);
		end
		
	end
	
end
function SW_Test(subMap)

	if subMap == nil then
		for k,v in pairs(SW_EventRegexMap) do
			SW_printStr (k);
			for _,x in ipairs(v) do
				SW_printStr("    "..x.." ---- "..SW_RegEx_Lookup[x]["r"]);
			end
		end
	else
		SW_printStr (subMap);
		for _,x in ipairs(SW_EventRegexMap[subMap]) do
			SW_printStr("    "..x.." ---- "..SW_RegEx_Lookup[x]["r"]);
		end
	end
end

-- 1.5 new pet mechanics
function SW_PetHasOwner(petName)
	local petInfo = SW_PetInfo["PET_OWNER"][petName];
	if petInfo ~= nil and petInfo["currentOwners"] ~= nil then 
		for k, v in pairs(petInfo["currentOwners"]) do
			return true;
		end
	end
	return false;
end
-- resets current petownership to nothing
function SW_PetsResetOwners()
	for k, v in pairs(SW_PetInfo["OWNER_PET"]) do
		v["currentPet"] = nil;
	end
	for k, v in pairs(SW_PetInfo["PET_OWNER"]) do
		v["currentOwners"] = {};
	end
end
function SW_HandlePetEvent(petName, petsAction, dmg, heal)
	local petInfo = SW_PetInfo["PET_OWNER"][petName];
	local tmpInfo = nil;
	local oneOwner = nil;
	local hadOwner = false;
	
	if petInfo == nil then return; end
	if petInfo["currentOwners"] == nil then return; end
	
	for k, v in pairs(petInfo["currentOwners"]) do
		hadOwner = true;
		oneOwner = SW_PetInfo["OWNER_PET"][k];
		if oneOwner ~= nil then
			
			if oneOwner["currentPet"] == petName then -- through setup should always be true
				
				if petsAction then
					tmpInfo = oneOwner["pets"][petName][SW_PRINT_ITEM_TOTAL_DONE];
				else
					tmpInfo = oneOwner["pets"][petName][SW_PRINT_ITEM_RECIEVED];
				end
				tmpInfo[1] = tmpInfo[1] + dmg;
				tmpInfo[2] = tmpInfo[2] + heal;
				if petsAction then
					tmpInfo = oneOwner[SW_PRINT_ITEM_TOTAL_DONE];
				else
					tmpInfo = oneOwner[SW_PRINT_ITEM_RECIEVED];
				end
				tmpInfo[1] = tmpInfo[1] + dmg;
				tmpInfo[2] = tmpInfo[2] + heal;
			end
		end
	end
	
	if hadOwner then
		if petsAction then
			tmpInfo = petInfo[SW_PRINT_ITEM_TOTAL_DONE];
		else
			tmpInfo = petInfo[SW_PRINT_ITEM_RECIEVED];
		end
		tmpInfo[1] = tmpInfo[1] + dmg;
		tmpInfo[2] = tmpInfo[2] + heal;
	end
end
function SW_UpdatePet(ownerID)
	local ownerName = UnitName(ownerID);
	local unitPetName = nil;
	local unitPetID = nil;
	local localizedClass, englishClass;
	
	if ownerName == nil then return; end
	
	-- translate target to raid/ group id
	-- cant seem to get the pet of a  "target" id
	if ownerID == "target" then
		if SW_Friends[ownerName] ~= nil then
			-- should always be true just an extra check
			if UnitIsUnit(SW_Friends[ownerName]["UnitID"], "target") then
				ownerID = SW_Friends[ownerName]["UnitID"];
			else
				ownerID = nil;
			end
		else
			ownerID = nil;
		end
	end
	if (ownerID == nil) then return; end
	
	-- here we have an id we can really use
	if ownerID == "player" then
		unitPetID = "pet";
	elseif string.find(ownerID, "party") then
		unitPetID = string.gsub(ownerID, "party", "partypet");
	elseif string.find(ownerID, "raid") then
		unitPetID =  string.gsub(ownerID, "raid", "raidpet");
	else
		SW_printStr("SW_UpdatePet error ownerID is:"..ownerID);
		return;
	end
	
	unitPetName = UnitName(unitPetID);
	
	-- this tends to happen when logging in
	-- once inside the game zoning and reloadui shouldn't trigger this
	if unitPetName == UNKNOWNOBJECT then
		--SW_printStr("Started UNKNOWNOBJECT timer");
		SW_Timed_Calls.retryUnknownObject = true;
		return;
	end
	
	-- no pet
	if unitPetName == nil then
		-- remove the owner
		for k,v in pairs(SW_PetInfo["PET_OWNER"]) do
			if v["currentOwners"] ~= nil then
				v["currentOwners"][ownerName] = nil;
			end
		end
		if SW_PetInfo["OWNER_PET"][ownerName] ~= nil then
			SW_PetInfo["OWNER_PET"][ownerName]["currentPet"] = nil;
		end
	end
	if unitPetName ~= nil and unitPetName ~= UNKNOWNOBJECT then
		-- setup pet owner
		if SW_PetInfo["PET_OWNER"][unitPetName] == nil then
			SW_PetInfo["PET_OWNER"][unitPetName] = {};
			SW_PetInfo["PET_OWNER"][unitPetName][SW_PRINT_ITEM_TOTAL_DONE] = {0,0};
			SW_PetInfo["PET_OWNER"][unitPetName][SW_PRINT_ITEM_RECIEVED] = {0,0};
			SW_PetInfo["PET_OWNER"][unitPetName]["currentOwners"] = {};
			SW_PetInfo["PET_OWNER"][unitPetName]["currentOwners"][ownerName] = true;
			localizedClass, englishClass = UnitClass(unitPetID);
			if englishClass ~= nil and localizedClass ~= nil then 
				SW_ClassNames[englishClass] = localizedClass;
			end
			-- englishClass might be nill but thats fine
			SW_PetInfo["PET_OWNER"][unitPetName]["CLASSE"] = englishClass;
		else
			-- need this check because of sync channel
			if SW_PetInfo["PET_OWNER"][unitPetName]["currentOwners"] == nil then
				SW_PetInfo["PET_OWNER"][unitPetName]["currentOwners"] = {};
			end
			SW_PetInfo["PET_OWNER"][unitPetName]["currentOwners"][ownerName] = true;
			-- sometimes class info doesn't carry over (pet is to far away)
			-- so recheck it
			if SW_PetInfo["PET_OWNER"][unitPetName]["CLASSE"] == nil then
				localizedClass, englishClass = UnitClass(unitPetID);
				if englishClass ~= nil and localizedClass ~= nil then 
					SW_ClassNames[englishClass] = localizedClass;
				end
				SW_PetInfo["PET_OWNER"][unitPetName]["CLASSE"] = englishClass;
			end
		end
		-- setup owner pet
		if SW_PetInfo["OWNER_PET"][ownerName] == nil then
			SW_PetInfo["OWNER_PET"][ownerName] = {};
			SW_PetInfo["OWNER_PET"][ownerName]["pets"] = {};
			SW_PetInfo["OWNER_PET"][ownerName][SW_PRINT_ITEM_TOTAL_DONE] = {0,0};
			SW_PetInfo["OWNER_PET"][ownerName][SW_PRINT_ITEM_RECIEVED] = {0,0};
		end
		-- very odd had a report so added this, why would this be needed?
		-- ah ok if its inited through the sync channel this is needed.
		if SW_PetInfo["OWNER_PET"][ownerName]["pets"] == nil then
			SW_PetInfo["OWNER_PET"][ownerName]["pets"] = {};
		end
		
		if SW_PetInfo["OWNER_PET"][ownerName]["pets"][unitPetName] == nil then
			SW_PetInfo["OWNER_PET"][ownerName]["pets"][unitPetName] = {};
			SW_PetInfo["OWNER_PET"][ownerName]["pets"][unitPetName][SW_PRINT_ITEM_TOTAL_DONE] = {0,0};
			SW_PetInfo["OWNER_PET"][ownerName]["pets"][unitPetName][SW_PRINT_ITEM_RECIEVED] = {0,0};
		end
		SW_PetInfo["OWNER_PET"][ownerName]["currentPet"] = unitPetName;
	
		--SW_Pets[unitPetName] = ownerName;
		if SW_Friends[ownerName] == nil then
			SW_Friends[ownerName] = {};
			SW_Friends[ownerName]["PETS"] = {};
		elseif SW_Friends[ownerName]["PETS"] == nil then
			SW_Friends[ownerName]["PETS"] = {};
		end
		SW_Friends[ownerName]["PETS"][unitPetName] = 1;
	end	
end
-- creats the "friends" list
-- self, group members, or raid members 
function SW_Make_Friends(gType)
	local name, rank,sg,lev;
	local namePet;
	local playerClass, englishClass = UnitClass("player");
	SW_ClassNames[englishClass] = playerClass;
	
	SW_Friends = {[SW_SELF_STRING]=
		{["CLASS"] = playerClass, ["CLASSE"] = englishClass, ["UnitID"]="player", ["L"] = UnitLevel("player")},
	};
	--1.4.2 add rank info when we are alone will be overwritten if in raid/group
	SW_Friends[SW_SELF_STRING]["Rank"] = 0;
	
	--update pet info
	SW_PetsResetOwners();
	SW_UpdatePet("player");
	
	--[[
		1.4.2 Changed to GetRaidRosterInfo need rank info now
		probably could use class and fileName instead of UnitClass(...)
	--]]
	if gType == "RAID" then
		for i=1, GetNumRaidMembers() do
			--name =UnitName("raid"..i);
			--name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i)
			name, rank,sg,lev = GetRaidRosterInfo(i);
			if name ~= nil then
				playerClass, englishClass = UnitClass("raid"..i);
				if englishClass ~= nil and playerClass ~= nil then
					SW_ClassNames[englishClass] = playerClass;
					SW_Friends[name] = {["CLASS"] = playerClass, ["CLASSE"] = englishClass, ["UnitID"]="raid"..i, ["Rank"]=rank, ["L"] = lev };
				end
				
				SW_UpdatePet("raid"..i);
			end
			
		end
		return;
	end	
	
	if gType == "GROUP" then
		for i=1, GetNumPartyMembers() do
			name =UnitName("party"..i);
			if name ~= nil then
				playerClass, englishClass = UnitClass("party"..i);
				if UnitIsPartyLeader("party"..i) then
					rank = 2;
				else
					rank = 0;
				end
				if englishClass ~= nil and playerClass ~= nil then
					SW_ClassNames[englishClass] = playerClass;
					SW_Friends[name] = {["CLASS"] = playerClass, ["CLASSE"] = englishClass, ["UnitID"]="party"..i, ["Rank"]=rank, ["L"] = UnitLevel("party"..i)};
				end
				
				SW_UpdatePet("party"..i);
			end
		end
		--1.4.2 check self as party leader
		if IsPartyLeader() then
			SW_Friends[SW_SELF_STRING]["Rank"] = 2;
		end
		return;
	end
	
end

--[[
SW_TestState = {
	_memberVar,
	Test = function (self, test)
		self._memberVar = test;
		x=0;
		for i=1, 1000000 do
			x=x+1;
			
		end
		if self._memberVar == test then
			SW_printStr(test.." OK");
		else
			SW_printStr(test.." FAILED");
		end
	end,
}
--]]

SW_Timed_Calls = {

	deltaPending = 0.5, -- 1.4 beta 5 increased + 0.1
	passedPendig =0,
	pendingActive = false,
	
	deltaResize = 0.5,
	passedResize = 0,
	
	deltaSySend = 1.1, -- + 0.1 in 1.2.4 a few more checks going on
	passedSySend = 0,
	
	deltaSyDo = 5,
	passedSyDo = 0,
	
	deltaSyLI = 100, -- lowerd to 100
	passedSyLI = 0,
	
	retryUnknownObject = false, -- added in 1.5 pet mechanics using SyDo timer
	pendingJoin = false, -- added in 1.5 for sync joining, using SySend timer 
	checkJoin = false, -- added in 1.5 for checking if we REALLY are in the chan, using SySend timer
	
	OnUpdate = function (self, elapsed)
		self.passedResize = self.passedResize + elapsed;
		self.passedSySend = self.passedSySend + elapsed;
		self.passedSyDo = self.passedSyDo + elapsed;
		self.passedSyLI = self.passedSyLI + elapsed;
		
		if (SW_CombatTimeInfo.awaitingEnd) then
			SW_CombatTime = SW_CombatTime + elapsed;
		end
		if self.pendingActive then
			self.passedPendig = self.passedPendig + elapsed;
			if self.passedPendig > self.deltaPending then
				self.pendingActive = false;
				self.passedPendig = 0;
				SW_AcceptPendingCast();
			end
		end
		if self.passedResize > self.deltaResize then
			if SW_SomethingResizing then
				SW_BarLayoutRegisterdOnResize();
			end
			self.passedResize = 0;
		end
		if self.passedSySend > self.deltaSySend then
		
			-- added 1.5.3 for raid per second info
			SW_RPS:updateInfo();
			
			-- added in 1.5 joining a chan is now on a short timer 
			-- to allow exit of old sync chan first
			if self.checkJoin then
				self.checkJoin = false;
				SW_SyncJoinedCheck();
			end
			if self.pendingJoin then
				self.pendingJoin = false;
				SW_SyncJoinPending();
			end
			
			SW_SyncSend();
			-- added 1.5.beta.1 for voting system
			SW_UpdateVoteTimers(self.deltaSySend);
			
			
			if not SW_SomethingResizing then
				SW_UpdateBars();
			end
			self.passedSySend = 0;
		end
		if self.passedSyDo > self.deltaSyDo then
			-- added in 1.5 this should only happen when logging in
			if self.retryUnknownObject then
				self.retryUnknownObject = false;
				--SW_printStr("UNKNOWNOBJECT timer fired");
				SW_RebuildFriendList();
			end
			SW_SyncDo();
			self.passedSyDo = 0;
		end
		if self.passedSyLI > self.deltaSyLI then
			SW_SyncCheckAlive();
			self.passedSyLI = 0;
		end
	end,
	
	StopPending = function (self)
		self.pendingActive = false;
		self.passedPendig = 0;
	end,
	StartPending = function (self)
		self.pendingActive = true;
	end,
	
	StartJoinChanPending = function (self)
		self.passedSySend = 0;
		self.pendingJoin = true;
	end,
	StopJoinChanPending = function (self)
		self.pendingJoin = false;
	end,
	StartCheckChan = function (self)
		self.passedSySend = 0;
		self.checkJoin = true;
	end,
	StopCheckChan = function (self)
		self.checkJoin = false;
	end,
};
-- this doesnt work like intended, eg talking to nef starts this oO
--[[
function SW_RaidInfightUpdate()
	local indi = getglobal("SW_BarFrame1_Title_InFight");
	for k,v in pairs(SW_Friends) do
		if v["UnitID"] ~= nil then
			if UnitAffectingCombat(v["UnitID"]) then
				indi.NormalT:SetVertexColor(0,1,0,1);
				return;
			end
		end
	end
	indi.NormalT:SetVertexColor(1,0,0,1);
end
--]]
function SW_AddDeath(name)
	if name == nil then return; end
	
	if SW_S_Details[name] == nil then
		SW_S_Details[name] = {};
		SW_S_Details[name][SW_PRINT_ITEM_TOTAL_DONE] = {0,0}; 
		SW_S_Details[name][SW_PRINT_ITEM_RECIEVED] = {0,0};  
		SW_S_Details[name][SW_PRINT_ITEM_TYPE] = {}; 
	end
	if SW_S_Details[name][SW_PRINT_ITEM_DEATHS] == nil then
		SW_S_Details[name][SW_PRINT_ITEM_DEATHS] = 1;
	else
		SW_S_Details[name][SW_PRINT_ITEM_DEATHS] = SW_S_Details[name][SW_PRINT_ITEM_DEATHS] + 1;
	end
end
function SW_HandleDeath(msg)
	if msg == nil then return; end
	
	if msg == UNITDIESSELF then
		SW_AddDeath(SW_SELF_STRING);
	else
		local _,_, deadGuy = string.find(msg, SW_DeathRegEx);
		SW_AddDeath(deadGuy); 
	end
end


--[[
	Note to self, add HPS aswell
--]]
SW_C_RPS ={
	filters = {["SF"] = "SW_Filter_EverGroup", ["PF"] = "SW_PF_VPR"},
	
	new = function (self, o)
		local doResetInit = true;
		if o then
			doResetInit = false;
		else
			o = {};
		end
		setmetatable(o, self);
		self.__index = self;
		
		o.baseTimer = SW_C_Timer:new(o.baseTimer);
		o.startTimer = SW_C_Timer:new(o.startTimer);
		
		if doResetInit then
			o:resetDPS();
		end
		return o;
	end,
	resetDPS = function(self)
		self.isRunning = false;
		self.allowLastFightUpdate = false;
		self.currentSecs = 0;
		self.totalSecs = 0;
		self.lastFightSecs = 0;
		self.startDmg = 0;
		self.maxDPS = 0;
		self.lastFightDmg = 0;
		self.uglyTruthStarted = false;
		self.resetPoint = self:getDmg();
		SW_BarFrame1_Title_SyncIcon:UpdateColor(SW_Settings["Colors"]["Heal"]);
	end,
	
	validEvent = function (self)
		self.lastEvent = self.baseTimer:now();
		
		-- even with the ugly truth time be so nice to wait for first dmg
		if not self.uglyTruthStarted then
			self.uglyTruthStarted = true;
			self.baseTimer:setToNow();
		end
		if not self.isRunning then
			self.startTimer:setToNow();
			self.allowLastFightUpdate = false;
			self.startDmg = self:getDmg();
			self.isRunning = true;
			SW_BarFrame1_Title_SyncIcon:UpdateColor(SW_Settings["Colors"]["Damage"]);
		end
	end,
	updateInfo = function (self)
		if not self.isRunning then return; end
		local deltaT = self.startTimer:now() - self.lastEvent;
		if  deltaT > 6 then -- a buffer to keep you "in fight" 1.5.3.beta.1 changed from 5 to 6 (late sync msgs)
			self.isRunning = false;
			self.currentSecs = 0;
			deltaT = self.lastEvent - self.startTimer;
			if deltaT < 1 then deltaT = 1; end -- 1 sec minimum fight time
			self.totalSecs = self.totalSecs + deltaT;
			self.lastFightSecs = deltaT;
			self.allowLastFightUpdate = true;
			SW_BarFrame1_Title_SyncIcon:UpdateColor(SW_Settings["Colors"]["Heal"]);
		else
			self.currentSecs = self.startTimer:elapsed();
			SW_BarFrame1_Title_SyncIcon:UpdateColor(SW_Settings["Colors"]["Damage"]);
		end 
	end,
	
	getDmg = function(self)
		local snap = SW_GetDmgInfo("SW_Filter_EverGroup", nil, "SW_PF_VPR", self.filters);
		local total = 0;
		for i,v in ipairs(snap) do
			total = total + v[2];
		end
		return total;
	end,
	
	getVals = function (self)
		local ret = {};
		local currDmg = self:getDmg();
		local currDelta = currDmg - self.startDmg;
		
		if self.currentSecs == 0 then
			ret[1] = 0;
		else
			if self.currentSecs < 1 then
				ret[1] = math.floor(currDelta *100 + 0.5)/100;
			else
				ret[1] = math.floor((currDelta / self.currentSecs) *100 + 0.5)/100;
			end
		end
		
		if self.totalSecs == 0 and self.currentSecs == 0 then
			ret[2] = 0;
		else
			--SW_printStr((currDmg - self.resetPoint)..".."..(self.totalSecs + self.currentSecs));
			ret[2] = math.floor(((currDmg - self.resetPoint) / (self.totalSecs + self.currentSecs)) *100 + 0.5)/100;
		end
		
		if self.lastFightSecs == 0 then 
			ret[3] = 0;
		else
			if self.allowLastFightUpdate then
				-- only point of this is to accept late sync messages
				-- in testing this made (almost) no difference
				self.lastFightDmg = currDelta;
			end
			ret[3] = math.floor((self.lastFightDmg / self.lastFightSecs) *100 + 0.5)/100;
		end
		
		if self.uglyTruthStarted then
			ret[4] = math.floor(((currDmg - self.resetPoint) / self.baseTimer:elapsed()) *100 + 0.5)/100;
		end
		
		if not self.isRunning or self.currentSecs > 5 then
			for i,v in ipairs(ret) do
				if v > self.maxDPS then
					self.maxDPS = v;	
				end
			end
		end
		return ret;
	end,
	
	
	dump = function (self)
		SW_DumpTable(self);
	end,	
}

function SW_Stats_OnEvent()
	if (event == "VARIABLES_LOADED") then
		-- init code will go here considering saved vars
		-- 1.5 Current pet ownership reset, will be updated through other events on login
		SW_PetsResetOwners();
		
		-- 1.5.1 decurseing, could be used for more
		SW_CreateSpellIDLookup();
		-- 1.5 added pausing, default to running for old versions and new installs
		if SW_Settings["IsRunning"] == nil then
			SW_Settings["IsRunning"] = true;
		end
		if SW_Settings["IsRunning"] then
			SW_UnpauseEvents();
		end
		
		if SW_Map == nil then
			SW_Map = SW_DefaultMap;
		else
			if SW_Settings["LAST_V_RUN"] == nil then
				SW_Map = SW_DefaultMap;
				SW_Fallback_Block = {};
			else
				if SW_Settings["LAST_V_RUN"] ~= SW_VERSION then
					SW_Map = SW_DefaultMap;
					SW_Fallback_Block = {};
					SW_ResetInfo();
				end
			end
		end
		
		SW_DefaultMap = nil;
		if SW_EnviroMap == nil then
			SW_EnviroMap ={};
		end
		SW_CreateEventRegexMap();
		SW_SL_Finalize();
		SW_SELF_STRING = UnitName("player");
		
		if SW_Settings["SyncBCTarget"] == nil then
			SW_Settings["SyncBCTarget"] = "SW_BarSyncFrame_OptRaid";
		end
		-- sets the checkboxes to saved values
		SW_SetChkStates(); 
		SW_Event_Channel = getglobal("SW_FrameConsole_Text2_MsgFrame");
		SW_EI_ALLOFF = not (SW_Settings["EI_ShowRegEx"] or  SW_Settings["EI_ShowMatch"]
							or SW_Settings["EI_ShowEvent"] or SW_Settings["EI_ShowOrigStr"]);
							
		SW_Settings["LAST_V_RUN"] = SW_VERSION;
		if SW_Settings["QuickOptCount"] == nil then
			SW_Settings["QuickOptCount"] = 5;
		end
		SW_UpdateOptVis();
		
		-- wow what a headache, an addon called sweep overwrites this with a number oO
		-- causing all sorts of problems
		-- it's not great just to skip it but we can get along without seeding the generator
		if type(math.randomseed) == "function" then
			math.randomseed( time() );
		else
			SW_printStr("math.randomseed is not a funtion... it should be");
		end
		-- localize gui
		for k,v in pairs(SW_GUI) do
			--if its not a table the key is a direct map to the string
			if type(v) ~= "table" then
				getglobal(k):SetText(v);
			else
				--[[v["f"] is the function 
					k is the identifier for the function
					v["s"] is the string
				]]--
				v["f"](k,v["s"]);	 
			end
			
		end
		-- done localizing gui.. drop table
		SW_GUI = nil;
		-- do layout of items
		SW_DoLayout();
		SW_SyncInit();
		if SW_Settings["ReportAmount"] == nil then
			SW_Settings["ReportAmount"] = 5;
		end
		if SW_Settings["Colors"] == nil then
			SW_Settings["Colors"] = {};
		end
		for k,v in pairs(SW_Default_Colors) do
			if SW_Settings["Colors"][k] == nil then
				SW_Settings["Colors"][k] = v;
			end
		end
	
		
		if ButtonHole then
			ButtonHole.application.RegisterMod({id="SW_STATS_BH_HOOK", 
                                        name="SW Stats", 
                                        tooltip="SW Stats", 
                                        buttonFrame="SW_IconFrame", 
                                        updateFunction="SW_UpdateIconPos"});
        else
			SW_UpdateIconPos();
		end
		
		--1.5.3 default color mechaniks changed
		if SW_Settings["Colors"]["TitleBars"] == nil then
			SW_Settings["Colors"]["TitleBars"] = {1,0,0,1};
		end
		SW_UpdateTitleColor(SW_Settings["Colors"]["TitleBars"]);
		if SW_Settings["Colors"]["TitleBarsFont"] == nil then
			SW_Settings["Colors"]["TitleBarsFont"] = {1,1,1,1};
		end
		SW_UpdateTitleTextColor(SW_Settings["Colors"]["TitleBarsFont"]);
		if SW_Settings["Colors"]["Backdrops"] == nil then
			SW_Settings["Colors"]["Backdrops"] = {SW_COLOR_ACT["r"],SW_COLOR_ACT["g"],SW_COLOR_ACT["b"],1};
		end
		SW_UpdateFrameBackdrops(SW_Settings["Colors"]["Backdrops"]);
		if SW_Settings["Colors"]["MainWinBack"] == nil then
			SW_Settings["Colors"]["MainWinBack"] = {0,0,0,0.6};
		end
		SW_UpdateMainWinBack(SW_Settings["Colors"]["MainWinBack"])
		
		-- 1.5.3 Sync Icon
		if SW_Settings["SYNCLastChan"] ~= nil then
			SW_BarFrame1_Title_SyncIcon:Show();
			SW_BarFrame1_Title_SyncIcon:UpdateColor(SW_Settings["Colors"]["Heal"]);
		end
		--1.5.3 retaining vis of the main window
		if SW_Settings["SHOWMAIN"] then
			SW_BarFrame1:Show();
		end
		-- 1.5.3.beta.1 locking frames
		SW_LockFrames(SW_Settings["BFLocked"]);
		
		-- 1.5.3 Raid dps info
		SW_RPS = SW_C_RPS:new(SW_RPS);
		--SW_ToggleConsole();
	elseif (event == "PLAYER_TARGET_CHANGED") then
		local unitName = UnitName("target");
		if unitName == nil then return; end
		local localizedClass, englishClass = UnitClass("target");
		--1.0.2 added this, could happen with far away pets
		if localizedClass == nil or englishClass == nil then return; end
		
		SW_ClassNames[englishClass] = localizedClass;
		
		-- ignore if we dont have info
		if SW_S_Details[unitName] == nil then return; end
		
		SW_S_Details[unitName]["CLASSE"] = englishClass;
		
		--1.5 added GPC and GPET
		if UnitPlayerControlled("target") then
			if SW_Friends[unitName] ~= nil then
				SW_S_Details[unitName]["UTYPE"] = "GPC";
			elseif SW_PetInfo["PET_OWNER"][from] ~= nil then
				-- don't mark MC'd mobs as gpet
				if SW_S_Details[unitName]["UTYPE"] ~= "NPC" then
					SW_S_Details[unitName]["UTYPE"] = "GPET";
				end
			else
				SW_S_Details[unitName]["UTYPE"] = "PC";
			end
		else
			SW_S_Details[unitName]["UTYPE"] = "NPC";
		end
		--[[
		if UnitIsEnemy("player", "target") then
			SW_printStr("ENEMY");
		else
			SW_printStr("Friend");
		end
		--]]
	elseif (event == "SPELLS_CHANGED") then
		-- update if we learn new spells
		if arg1 == nil then
			SW_UpdateCastByNameLookup();
		end
	elseif (event == "SPELLCAST_CHANNEL_START") then
		--SW_printStr("-CHANNELSTART-");
		SW_AcceptSelectedCast();
	--[[elseif (event == "SPELLCAST_START") then	
		SW_printStr("-START-"); ]]--
	elseif (event == "SPELLCAST_STOP") then	
		--SW_printStr("-SPELLCAST_STOP-   :");
		--SW_printStr(SW_SelectedSpell[1]);
		if SW_SelectedSpell[1] ~= nil then
			--SW_printStr("-SPELLCAST_STOP:"..SW_SelectedSpell[1]);
			-- is this an instant ?
			if SW_SelectedSpell[3] then
				SW_AcceptSelectedCast();
			else
				SW_PendingCast[1] = SW_SelectedSpell[1];
				SW_PendingCast[2] = SW_SelectedSpell[2];
				SW_SelectedSpell = {};
				--SW_printStr("-STOP NP-"..SW_PendingCast[1]);
				SW_Timed_Calls:StartPending();
			end
		end
	elseif event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED" then
		--SW_printStr("-SPELLCAST_FAIL-");
		SW_Timed_Calls:StopPending();
		SW_SelectedSpell = {};
		SW_PendingCast = {};
	elseif (event == "CHAT_MSG_GUILD") then
		SW_SyncCheckMsgForChan(arg1,arg2);
	elseif (event == "CHAT_MSG_OFFICER") then
		SW_SyncCheckMsgForChan(arg1,arg2);
	elseif (event == "CHAT_MSG_PARTY") then
		SW_SyncCheckMsgForChan(arg1,arg2);
	elseif (event == "CHAT_MSG_RAID") then	
		SW_SyncCheckMsgForChan(arg1,arg2);
	elseif (event == "CHAT_MSG_RAID_LEADER") then	
		SW_SyncCheckMsgForChan(arg1,arg2);	
	elseif (event == "CHAT_MSG_CHANNEL") then	
		if arg8 == SW_SyncChanID then
			SW_SyncHandleMsg(arg1, arg2);
		end
	--elseif (event == "CHAT_MSG_SAY") then	
	--	SW_SyncCheckMsgForChan(arg1,arg2);
		
	elseif (event == "PLAYER_ENTERING_WORLD") then
		--bar layout needs to go here, only then the "saved (layout-cache.txt)" layout is loaded already
		SW_BarLayoutRegisterd();
		if  GetNumRaidMembers() > 0 then
			SW_Make_Friends("RAID");
		elseif GetNumPartyMembers() > 0 then
			SW_Make_Friends("GROUP");
		else
			SW_Make_Friends();
		end
		SW_UpdateCastByNameLookup();
		
	elseif (event == "UNIT_PET") then
		--SW_printStr("UNIT_PET "..arg1);
		SW_UpdatePet(arg1);
	elseif (event == "PARTY_MEMBERS_CHANGED") or (event == "PARTY_LEADER_CHANGED") then
		--SW_printStr("PARTY_MEMBERS_CHANGED ");
		if UnitInRaid("player") then
			return;
		end
		SW_Make_Friends("GROUP");
	elseif (event == "RAID_ROSTER_UPDATE") then
		SW_Make_Friends("RAID");
		local sf = getglobal("SW_BarSyncFrame");
		if sf:IsVisible() then
			sf:UpdateARPVis();
		end
	elseif (event == "CHAT_MSG_COMBAT_FRIENDLY_DEATH") then
		SW_HandleDeath(arg1);
	elseif (event == "CHAT_MSG_COMBAT_HOSTILE_DEATH") then
		SW_HandleDeath(arg1);
	elseif (event == "PLAYER_REGEN_DISABLED") then
		SW_CombatTimeInfo.awaitingStart = true;
	elseif (event == "PLAYER_REGEN_ENABLED") then
		SW_CombatTimeInfo.awaitingStart = false;
		SW_CombatTimeInfo.awaitingEnd = false;
	else
		SW_DoEvent(event);
	end
end
if not SW_DEV_INWOW then
	SW_SL_Add(SW_SL["START"]);
	SW_CreateRegexFromGlobals();
	SW_CreateEventRegexMap();
	SW_SL_Finalize();
	SW_Test();
end