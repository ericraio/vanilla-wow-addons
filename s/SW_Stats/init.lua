-- stuff for the startup log
local SW_SL_RegExCreate = 0;
local SW_SL_RegExAdded = 0;

function SW_SL_Add(msg)
	table.insert(SW_StartupLog, msg);
end
function SW_SL_AddTrailer(msg)
	SW_StartupLog[table.getn(SW_StartupLog)] = SW_StartupLog[table.getn(SW_StartupLog)].. msg;
end
function SW_SL_SetLastOk()
	SW_SL_AddTrailer(SW_SL["OK"]);
end
function SW_SL_Finalize()
	SW_SL_Add(SW_SL["MAP_REGEX"].." "..SW_SL_RegExAdded.."/"..SW_SL_RegExCreate);
	SW_DumpTable(SW_StartupLog,nil,1,true);
	SW_StartupLog = nil;
	
end

function SW_DEV_FFN(func)
	if func == nil then return; end
	if type(func) ~= "function" then
		return "Not a function";
	end
	local ret = "??";
	local vars = getfenv();
	for k,v in pairs(vars) do
		if type(v) == "function" then
			if func == v then
				return k;
			end
		end
	end
	return ret;
end
function SW_DEV_FindVar(str, chkVal)
	local vars = getfenv();
	local sLen =string.len(str);
	SW_printStr( "------ "..str.." ------");
	for k,v in pairs(vars) do
		if chkVal then
			if type(v) == "string" then
				if string.find(v, str) then
			
					SW_printStr(k.." ==> "..v);
				end
			end
		else
			
			if string.find(k, str) then
				if type(v) == "string" then
					SW_printStr(k.." ==> "..v);
				else
					SW_printStr(k.." ("..type(v)..")");
				end
			end
		end
	end
end
function SW_DEV_CC(hideCorrectlyOrdered)
	local s1, s2;
	local headPrinted = false;
	local startS, endS;
	local problematic = {};
	local mainEnding = {};
	local mainSDI = 0;
	SW_printStr("-------------SW_DEV_CC--------------");
	-- get all problematic regex
	-- (these end in a string capture.)
	local re = "(.+)%(%.%-%)(.-)$";
	for i,toCheck in ipairs(SW_EventRegexMap[SW_DEV_EVENTDUMMY]) do
		
		s1 = SW_RegEx_Lookup[toCheck]["r"];
		_,_,startS, endS = string.find(s1, re);
		
		if endS ~= nil and string.len( endS ) <=20 then
			-- the end capture may not include another capture
			if not (string.find(endS,"%(%.%-%)") or string.find(endS,"%(%%d%+%)") ) then
			--SW_printStr(s1.."    "..endS);
				problematic[s1] = {startS, endS, toCheck};
				if mainEnding[endS] == nil then
					mainEnding[endS] = 1;
				else
					mainEnding[endS] = mainEnding[endS] + 1;
				end
			end
		end		
	end
	SW_DumpTable(mainEnding);
	
	--SW_DumpTable(problematic);
	
	for k, v in pairs(problematic) do
		headPrinted = false;
		--s2 = v[1].."(.-)"..v[2];
		s2 = v[1];
		mainSDI = SW_DEV_GetDummyIndex(k);
		
		for i,toCheck in ipairs(SW_EventRegexMap[SW_DEV_EVENTDUMMY]) do
			s1 = SW_RegEx_Lookup[toCheck]["r"];
			 
			if string.sub(s1,1,string.len(s2))== s2 then
				-- it will collide with istelf.. 
				if k ~= s1 then
					if (not hideCorrectlyOrdered) or (mainSDI < SW_DEV_GetDummyIndex(s1)) then

						if not headPrinted then
							SW_printStr(" ");
							SW_printStr("----CHECK "..v[3].." "..k);
							headPrinted = true;
						end
						SW_printStr(toCheck.."  "..s1.."  LateSort:"..((SW_RegEx_Lookup[toCheck]["ls"]) or "NO"));
						
					end
				end
			end
		end
	end
	
end
function SW_DEV_GetDummyIndex(regEx)
	
	for i,toCheck in ipairs(SW_EventRegexMap[SW_DEV_EVENTDUMMY]) do
		if regEx == SW_RegEx_Lookup[toCheck]["r"] then
			return i;
		end
	end
end
-- this function is used to create "junk" for testing
--[[
-- need this to map var names to var values
local SW_G_VARS = getfenv();
-- note to self check GetCVar
local junkIndex =0;

SW_DEV_JUNK_STRINGS ={};

local function SW_CreateJunk(varName)
	local strMain = getglobal(varName);
	local str ="";
	
	if strMain == nil then return end;
	
	for i=1,SW_DEV_ITEMS_PER_REGEX do
		
		--[[
		str = string.gsub(strMain, '(%%(%d?)$?([sd]))',
			function(all,num,type)
				if type == 's' then
					return (string.rep(string.char(math.random(97,122)), math.random(3,5)));
				else
					return (math.random(1000));
				end
			end);
		--]]
		str = string.gsub(strMain, '(%%(%d?)$?([sd]))',
			function(all,num,type)
				if type == 's' then
					return ("STRING");
				else
					return (12345);
				end
			end);
		table.insert(SW_DEV_JUNK_STRINGS, str);
	end
end
--]]
--[[
 used this to find ending collisions
 only "bad" one found in en,de,fr is  en: PERIODICAURAHEALSELFSELF
 fr has some with extra attack messages, but not using these atm
SW_EndingTest = {};
SW_EndingCol = {};

function SW_TestEnding(str)
	local tmpStr = string.gsub(str, "(%%%d?$?s%.)$", "");
	
	for k,v in pairs(SW_EndingTest) do
		if string.sub(k,1,string.len(tmpStr))==tmpStr then
			if SW_EndingCol[tmpStr] == nil then
				SW_EndingCol[tmpStr] = 1;
			else
				SW_EndingCol[tmpStr] = SW_EndingCol[tmpStr] +1;
			end
			
		end
	end
	if SW_EndingTest[str] == nil then
		SW_EndingTest[str] = 0;
	end
end
--]]
--this converts a GlobalVariable to a regex we can use  
-- and add it to SW_RegEx_Lookup
local function SW_InitVar(varName,types,fromSelf,toSelf,isCrit,lateSort)
	local str = getglobal(varName);
	--SW_TestEnding(str);
	--check if we are trying to work on a global thats not available
	if str == nil then 
		SW_printStr("SW_InitVar varName NIL: "..varName);
		return 
	end;
	--SW_CreateJunk(varName);
	
	if types == nil then return end;
	
	--fixes ambiguous strings
	-- fix log strings is a localized function
	local strTmp = SW_FixLogStrings(str);
	if str ~= strTmp then
		setglobal(varName, strTmp);
		str = strTmp;
	end
	
	SW_SL_RegExCreate = SW_SL_RegExCreate +1;
	SW_RegEx_Lookup[varName] ={};
	
	-- "p"	stands for positions maps found for numbered vals (e.g. %3$s)
	-- in a different langugage these might be used in a different order
	SW_RegEx_Lookup[varName]["p"] ={}; 
	
	SW_RegEx_Lookup[varName]["types"] = types; 
	if lateSort then
		SW_RegEx_Lookup[varName]["ls"] = 1;
	end
	if fromSelf then
		SW_RegEx_Lookup[varName]["fromSelf"] = 1;
	end
	if toSelf then
		SW_RegEx_Lookup[varName]["toSelf"] = 1;
	end
	if isCrit then
		SW_RegEx_Lookup[varName]["isCrit"] = 1;
	end
	local index=0;
	local needPosLookup = false;
	
	
	-- first we have to "sanitze" the string  ^()%.[]*+-?  are special chars in a regex (dont escape the $ and %)
	-- so we are escaping these with %
	str = string.gsub(str, "([%.%(%)%+%-%?%[%]%^])", "%%%1");
	
	-- the inner function actually does the work
	str = string.gsub(str, '(%%(%d?)$?([sd]))',
		function(all,num,type) -- e.g. %3$s all = %3$s  num=3 type=s
			index = index+1;
			--1.0.2 , fixed the french version bug through "tonumber .. omg DOH .. oh well
			-- this will help all non englisch versions
			SW_RegEx_Lookup[varName]["p"][index] = tonumber(num);
			if num ~= "" then 
				-- if num is "" then the string e.g. only used %s and not %1$s
			    -- and we dont need a lookup - its already in order
			    needPosLookup = true;
			end
			
			--this is the actual replacement that makes the regex
			-- use non greedy for strings
			if type == 's' then
				return ('(.-)');
			else
				return ('(%d+)');
			end
		end);
		
	-- saves how many captures to expect later using this regex
	SW_RegEx_Lookup[varName]["i"] = index; 
	
	--generate maps for heal dmg etc info
	if index == getn(types) then
		local playerName = "";
		local mm = {};
		local medm = {};
		local i;
		local max = getn(types);

		--1 = target
		--2 = caster/attacker/initiator
		--3 = someString (normally spell names, or item names)
		-- 51 = dmg 52 = heal
		--{from,to,dmg,heal, what}
		for i, val in ipairs(types) do
			if val == 2 then
				mm[1] = i;
				medm[1] = i;
			elseif val == 1 then
				mm[2] = i;
				medm[2] = i;
			elseif val == 51 then
				mm[3] = i;
				medm[3] = i;
			elseif val == 52 then
				mm[4] = i;
				medm[4] = i;
			elseif val == 3 then
				mm[5] = i;
				medm[5] = i;
			elseif val == 7 then
				mm[6] = i;
				medm[6] = i;
			end
		end
		if fromSelf then
			mm[1]= -1;
		end
		if toSelf then
			mm[2]= -1;
		end	
		
		
		SW_RegEx_Lookup[varName]["basicInfo"] = mm;
		--SW_RegEx_Lookup[varName]["fullInfo"] = medm;	
	else
		SW_printStr(RED_FONT_COLOR_CODE.."SW_InitVar "..varName.." "..index.."~="..getn(types).." caputerN~=TypeN" , 1);
	end
	
	if  needPosLookup then
		-- check if we really do need it
		-- could be in order anyways
		needPosLookup = false;
		for k, v in pairs(SW_RegEx_Lookup[varName]["p"]) do 
			-- make k, v numbers, so they will compare
			-- k,v are of different types so this wouldn't work otherwise
			k = k+0;
			v = v+0;
			if k~=v then
				needPosLookup = true;
				break;
			end
		end
	end
	-- now we are sure if we need it or not
	if not needPosLookup then
		-- %s %d etc. used info is "in order"
		-- or %1$s %2$d etc. was used but all in correct order
		-- just junk it
		SW_RegEx_Lookup[varName]["p"] = nil;
	end

	--if string.sub(str,1,1) == "(" then
		--SW_RegEx_Lookup[varName]["r"] = str; -- the regex
	--else
		SW_RegEx_Lookup[varName]["r"] = "^"..str; -- the regex
	--end
	--[[ Interesting have to comment this out so wow will work??
		maybe because this is a local function ?
	if SW_DEV_CREATE_JUNK_STRINGS then
		SW_CreateJunk(varName);
	end
	]]--
end

--------------------- the global vars to define a regex for -------------------------------
function SW_CreateRegexFromGlobals()
	-- take these out while finding matches and collisions
	--SW_InitVar("VULNERABLE_TRAILER");
	--SW_InitVar("ABSORB_TRAILER");
	--SW_InitVar("BLOCK_TRAILER");
	--SW_InitVar("RESIST_TRAILER");
	SW_SL_Add(SW_SL["REGEX"]);
	--[[ new way, a lot more info
		name of string var,
		Arrray of types 
			The array is mapped 1 to 1 to the captures AFTER the captures have been sorted
			(for different languages they may be in different order)
			
			1 = target
			2 = caster/attacker/initiator
			3 = someString (normally spell names, or item names)
			4 = unused 
			5x = Number
			6x = number 2
				where x
				1= Damage
				2 = Heal
				3 = Other
				4 = LeechFrom amount(victim of leech )
				5 = LeechTo amount (leech transferred to)
			7 = School
			8 = LeechFrom (String what is leeched health, mana, etc)
			9 = LeechTo	(string what has been transferred healt, mana, etc)
			10 = Leech benefit (the person the got the "good side" of the leech
			(leech and drain use the same types, some fields are just not set)
		After the array:
		fromself, (did one self start the cast/attack? )
		toself, (did one self get the heal/hit...)
		iscrit, (is this a crit?)
		lateSort (special indicated to check these last; used in recuCheck, 
				used to push back some regex that capture to early)
				
	note to self... new in 1.9 true if this locale:
	LOCALE_enGB, LOCALE_enUS, LOCALE_frFR, LOCALE_deDE, LOCALE_koKR, LOCALE_zhCN, LOCALE zhTW 
			
	]]--
	if (LOCALE_frFR) then
		-- captures to early in fr version
		SW_InitVar("COMBATHITCRITOTHEROTHER",{2,1,51},nil,nil,true,true);
		SW_InitVar("COMBATHITCRITSCHOOLOTHEROTHER",{2,1,51,7},nil,nil,true,true);
	else
		SW_InitVar("COMBATHITCRITOTHEROTHER",{2,1,51},nil,nil,true,nil);
		SW_InitVar("COMBATHITCRITSCHOOLOTHEROTHER",{2,1,51,7},nil,nil,true,nil);
	end
	
	SW_InitVar("COMBATHITCRITOTHERSELF",{2,51},nil,true,true,nil);
	SW_InitVar("COMBATHITCRITSCHOOLOTHERSELF",{2,51,7},nil,true,true,nil);
	SW_InitVar("COMBATHITCRITSCHOOLSELFOTHER",{1,51,7},true,nil,true,nil);
	SW_InitVar("COMBATHITCRITSELFOTHER",{1,51},true,nil,true,nil);
	
	if (LOCALE_zhCN or LOCALE_zhTW) then
		SW_InitVar("COMBATHITOTHEROTHER",{2,1,51},nil,nil,nil,true);
		SW_InitVar("COMBATHITSCHOOLOTHEROTHER",{2,1,51,7},nil,nil,nil,true);
		SW_InitVar("COMBATHITSCHOOLOTHERSELF",{2,51,7},nil,true,nil,true);
	else
		SW_InitVar("COMBATHITOTHEROTHER",{2,1,51},nil,nil,nil,nil);
		SW_InitVar("COMBATHITSCHOOLOTHEROTHER",{2,1,51,7},nil,nil,nil,nil);
		SW_InitVar("COMBATHITSCHOOLOTHERSELF",{2,51,7},nil,true,nil,nil);
	end
	
	SW_InitVar("COMBATHITOTHERSELF",{2,51},nil,true,nil,nil);
	SW_InitVar("COMBATHITSCHOOLSELFOTHER",{1,51,7},true,nil,nil,nil);
	SW_InitVar("COMBATHITSELFOTHER",{1,51},true,nil,nil,nil);
	SW_InitVar("DAMAGESHIELDOTHEROTHER",{2,51,7,1},nil,nil,nil,nil);
	SW_InitVar("DAMAGESHIELDOTHERSELF",{2,51,7},nil,true,nil,nil);
	SW_InitVar("DAMAGESHIELDSELFOTHER",{51,7,1},true,nil,nil,nil);
	SW_InitVar("ERR_COMBAT_DAMAGE_SSI",{2,1,51},nil,nil,nil,true);
	SW_InitVar("HEALEDCRITOTHEROTHER",{2,3,1,52},nil,nil,true,nil);
	SW_InitVar("HEALEDCRITOTHERSELF",{2,3,52},nil,true,true,nil);
	SW_InitVar("HEALEDCRITSELFOTHER",{3,1,52},true,nil,true,nil);
	SW_InitVar("HEALEDCRITSELFSELF",{3,52},true,true,true,nil);
	SW_InitVar("HEALEDOTHEROTHER",{2,3,1,52},nil,nil,nil,nil);
	SW_InitVar("HEALEDOTHERSELF",{2,3,52},nil,true,nil,nil);
	SW_InitVar("HEALEDSELFOTHER",{3,1,52},true,nil,nil,nil);
	SW_InitVar("HEALEDSELFSELF",{3,52},true,true,nil,nil);
	SW_InitVar("PERIODICAURADAMAGEOTHEROTHER",{1,51,7,2,3},nil,nil,nil,nil);
	SW_InitVar("PERIODICAURADAMAGEOTHERSELF",{51,7,2,3},nil,true,nil,nil);
	SW_InitVar("PERIODICAURADAMAGESELFOTHER",{1,51,7,3},true,nil,nil,nil);
	SW_InitVar("PERIODICAURADAMAGESELFSELF",{51,7,3},true,true,nil,nil);
	SW_InitVar("PERIODICAURAHEALOTHEROTHER",{1,52,2,3},nil,nil,nil,nil);
	SW_InitVar("PERIODICAURAHEALOTHERSELF",{52,2,3},nil,true,nil,nil);
	SW_InitVar("PERIODICAURAHEALSELFOTHER",{1,52,3},true,nil,nil,nil);
	
	if LOCALE_enGB or LOCALE_enUS then
		-- captures to early in en versions
		SW_InitVar("PERIODICAURAHEALSELFSELF",{52,3},true,true,nil,true);
	else
		SW_InitVar("PERIODICAURAHEALSELFSELF",{52,3},true,true,nil,nil);
	end
	
	SW_InitVar("PET_DAMAGE_PERCENTAGE",{53},nil,nil,nil,nil);
	SW_InitVar("SPELLEXTRAATTACKSOTHER",{1,53,3},nil,nil,nil,nil);
	SW_InitVar("SPELLEXTRAATTACKSOTHER_SINGULAR",{1,53,3},nil,nil,nil,nil);
	SW_InitVar("SPELLEXTRAATTACKSSELF",{53,3},nil,true,nil,nil);
	SW_InitVar("SPELLEXTRAATTACKSSELF_SINGULAR",{3,53},nil,true,nil,nil);
	SW_InitVar("SPELLHAPPINESSDRAINOTHER",{1,2,53},nil,nil,nil,nil);
	SW_InitVar("SPELLHAPPINESSDRAINSELF",{1,53},true,nil,nil,nil);
	SW_InitVar("SPELLLOGCRITOTHEROTHER",{2,3,1,51},nil,nil,true,nil);
	SW_InitVar("SPELLLOGCRITOTHERSELF",{2,3,51},nil,true,true,nil);
	SW_InitVar("SPELLLOGCRITSCHOOLOTHEROTHER",{2,3,1,51,7},nil,nil,true,nil);
	SW_InitVar("SPELLLOGCRITSCHOOLOTHERSELF",{2,3,51,7},nil,true,true,nil);
	SW_InitVar("SPELLLOGCRITSCHOOLSELFOTHER",{3,1,51,7},true,nil,true,nil);
	SW_InitVar("SPELLLOGCRITSCHOOLSELFSELF",{3,51,7},true,true,true,nil);
	SW_InitVar("SPELLLOGCRITSELFOTHER",{3,1,51},true,nil,true,nil);
	SW_InitVar("SPELLLOGCRITSELFSELF",{3,51},true,true,true,nil);
	SW_InitVar("SPELLLOGOTHEROTHER",{2,3,1,51},nil,nil,nil,nil);
	SW_InitVar("SPELLLOGOTHERSELF",{2,3,51},nil,true,nil,nil);
	SW_InitVar("SPELLLOGSCHOOLOTHEROTHER",{2,3,1,51,7},nil,nil,nil,nil);
	SW_InitVar("SPELLLOGSCHOOLOTHERSELF",{2,3,51,7},nil,true,nil,nil);
	SW_InitVar("SPELLLOGSCHOOLSELFOTHER",{3,1,51,7},true,nil,nil,nil);
	SW_InitVar("SPELLLOGSCHOOLSELFSELF",{3,51,7},true,true,nil,nil);
	SW_InitVar("SPELLLOGSELFOTHER",{3,1,51},true,nil,nil,nil);
	SW_InitVar("SPELLLOGSELFSELF",{3,51},true,true,nil,nil);
	
	if LOCALE_enGB or LOCALE_enUS then
		SW_InitVar("SPELLPOWERDRAINOTHEROTHER",{2,3,54,8,1},nil,nil,nil,true);
		SW_InitVar("SPELLPOWERDRAINOTHERSELF",{2,3,54,8},nil,true,nil,true);
	else
		SW_InitVar("SPELLPOWERDRAINOTHEROTHER",{2,3,54,8,1},nil,nil,nil,nil);
		SW_InitVar("SPELLPOWERDRAINOTHERSELF",{2,3,54,8},nil,true,nil,nil);
	end
	SW_InitVar("SPELLPOWERDRAINSELFOTHER",{3,54,8,1},true,nil,nil,nil);
	SW_InitVar("SPELLPOWERLEECHOTHEROTHER",{2,3,54,8,1,10,65,9},nil,nil,nil,nil);
	SW_InitVar("SPELLPOWERLEECHOTHERSELF",{2,3,54,8,10,65,9},nil,true,nil,nil);
	SW_InitVar("SPELLPOWERLEECHSELFOTHER",{3,54,8,1,65,9},true,nil,nil,nil);
	SW_InitVar("SPELLSPLITDAMAGEOTHEROTHER",{2,3,1,51},nil,nil,nil,nil);
	SW_InitVar("SPELLSPLITDAMAGEOTHERSELF",{2,3,51},nil,true,nil,nil);
	SW_InitVar("SPELLSPLITDAMAGESELFOTHER",{2,1,51},nil,nil,nil,nil);
	SW_InitVar("VSENVIRONMENTALDAMAGE_DROWNING_OTHER",{1,51},nil,nil,nil,nil);
	SW_InitVar("VSENVIRONMENTALDAMAGE_DROWNING_SELF",{51},nil,true,nil,nil);
	SW_InitVar("VSENVIRONMENTALDAMAGE_FALLING_OTHER",{1,51},nil,nil,nil,nil);
	SW_InitVar("VSENVIRONMENTALDAMAGE_FALLING_SELF",{51},nil,true,nil,nil);
	SW_InitVar("VSENVIRONMENTALDAMAGE_FATIGUE_OTHER",{1,51},nil,nil,nil,nil);
	SW_InitVar("VSENVIRONMENTALDAMAGE_FATIGUE_SELF",{51},nil,true,nil,nil);
	SW_InitVar("VSENVIRONMENTALDAMAGE_FIRE_OTHER",{1,51},nil,nil,nil,nil);
	SW_InitVar("VSENVIRONMENTALDAMAGE_FIRE_SELF",{51},nil,true,nil,nil);
	SW_InitVar("VSENVIRONMENTALDAMAGE_LAVA_OTHER",{1,51},nil,nil,nil,nil);
	SW_InitVar("VSENVIRONMENTALDAMAGE_LAVA_SELF",{51},nil,true,nil,nil);
	SW_InitVar("VSENVIRONMENTALDAMAGE_SLIME_OTHER",{1,51},nil,nil,nil,nil);
	SW_InitVar("VSENVIRONMENTALDAMAGE_SLIME_SELF",{51},nil,true,nil,nil);

	--1.4 removed in wow 1.10
	-- it doesn't hurt to leave them in for easy transition 1.9->1.10
	--[[
	SW_InitVar("POWERGAIN_OTHER",{1,53,3},nil,nil,nil,true);
	SW_InitVar("POWERGAIN_SELF",{53,3},nil,true,nil,true);
	SW_InitVar("GENERICPOWERGAIN_OTHER",{1,53,3},nil,nil,nil,true);
	SW_InitVar("GENERICPOWERGAIN_SELF",{53,3},nil,true,nil,true);
	--]]
	
	--1.4 wow 1.10 changed powergain stuff
	-- mana/ health etc isnt really a "LeechTo" but this fits best
	-- 1.5.1 selfself and selfother changed to late sort
	SW_InitVar("POWERGAINOTHEROTHER",{1,53,9,2,3},nil,nil,nil,nil);
	SW_InitVar("POWERGAINOTHERSELF",{53,9,2,3},nil,true,nil,nil);
	SW_InitVar("POWERGAINSELFOTHER",{1,53,9,3},true,nil,nil,true);
	SW_InitVar("POWERGAINSELFSELF",{53,9,3},true,true,nil,true);
	--1.4  wow 1.10 aura stuff
	SW_InitVar("AURAAPPLICATIONADDEDOTHERHARMFUL",{1,3,53},nil,nil,nil,nil);
	SW_InitVar("AURAAPPLICATIONADDEDOTHERHELPFUL",{1,3,53},nil,nil,nil,nil);
	SW_InitVar("AURAAPPLICATIONADDEDSELFHARMFUL",{3,53},nil,true,nil,nil);
	SW_InitVar("AURAAPPLICATIONADDEDSELFHELPFUL",{3,53},nil,true,nil,nil);
	
	-- 1.5.1 for decursing (could be used for more)
	SW_InitVar("SIMPLECASTOTHEROTHER",{2,3,1},nil,nil,nil,nil);
	SW_InitVar("SIMPLECASTOTHERSELF",{2,3},nil,true,nil,nil);
	SW_InitVar("SIMPLECASTSELFOTHER",{3,1},true,nil,nil,nil);
	SW_InitVar("SIMPLECASTSELFSELF",{3},true,true,nil,true);
	
	-- this one is very generic %s casts %s
	-- could use this to count totem placement
	--SW_InitVar("SPELLCASTGOOTHER",{2,3},nil,nil,nil,true);
	
	-- 1.5.3.beta.1 Added but not used, but will cause blocking events w/o
	-- noticed this through the curse patchwerk kill video ;)
	SW_InitVar("COMBATLOG_HONORGAIN",{1,3,53},true,nil,nil,nil);
	
	SW_SL_SetLastOk();
end

local function SW_AddToMap(eventName, regexName, map)
	if map == nil then map = SW_EventRegexMap; end
	
	-- first check if we have the info needed
	--added this for WOW 1.10 POWERGAINXX changes
	if SW_RegEx_Lookup[regexName] == nil then
		--DEFAULT_CHAT_FRAME:AddMessage(regexName);
		
		return;
	end
	if SW_RegEx_Lookup[regexName]["r"] == nil then return; end
	
	if map[eventName] == nil then
		map[eventName] ={};
	end
	--use insert we want to sort this later using table.sort 
	table.insert(map[eventName], regexName);	
	
	SW_SL_RegExAdded = SW_SL_RegExAdded +1;
end

--[[ this resorts SW_EventRegexMap based on the regular expression
	to be used
	This is done to minimize the chance of a collision
	rule 1 -> anything that starts with a string and not a capture goes first
	rule 2 -> if it starts with a capture not followed by a space it goes first
	rule 3 - > less captures go first
	rule 4 -> longer strings go first
]]--
local function recuCheck(a, b, opt)

	local l = SW_RegEx_Lookup[a]["r"];
	local r = SW_RegEx_Lookup[b]["r"];
	
	if opt == nil then
		local sl = string.sub(l,2,2);
		local sr = string.sub(r,2,2);
		if sl == "(" then
			if sr == "(" then
				return recuCheck(a, b, 1);
			else
				return false;
			end
		else
			if sr == "(" then
				return true;
			else
				return recuCheck(a, b, 1);
			end
		end
	elseif opt == 1 then
		if SW_RegEx_Lookup[a]["ls"] and SW_RegEx_Lookup[b]["ls"] then
			return recuCheck(a, b, 2);
		end
		if SW_RegEx_Lookup[a]["ls"] then 
			return false;
		end
		if SW_RegEx_Lookup[b]["ls"] then 
			return true;
		end
		return recuCheck(a, b, 2);
	elseif opt == 2 then
		local sl = string.sub(l,1,5);
		local sr = string.sub(r,1,5);
		local slf = string.sub(l,1,2);
		
		if sl == sr and slf == "^(" then
			
			sl = string.sub(l,6,6);
			sr = string.sub(r,6,6);
			if sl == sr then
				return recuCheck(a, b, 3);
			else
				if sl == " " then
					return false;
				elseif sr == " " then
					return true;
				else
					return recuCheck(a, b, 3);
				end
			end
		else
			return recuCheck(a, b, 3);
		end
		
	elseif opt == 3 then
		if  SW_RegEx_Lookup[a]["i"] == SW_RegEx_Lookup[b]["i"] then
			return recuCheck(a, b, 4);
		else 
			return SW_RegEx_Lookup[a]["i"] < SW_RegEx_Lookup[b]["i"];
		end
	elseif opt == 4 then
			return  string.len(l) > string.len(r);
			
	else
		return false;
	end
end

local function SW_finalizeMap()
	SW_SL_Add(SW_SL["MAP_SORT"]);
	
	for k,v in pairs(SW_EventRegexMap) do
		table.sort(v, 
			function(a,b)
				return recuCheck(a,b);
			end);
	end
	
	SW_SL_SetLastOk();
	
end

function SW_CreateEventRegexMap()
	SW_SL_Add(SW_SL["MAP"]);
	
	-- first we need the "dummy" for non handeled events
	-- added an extra "dummy" for text only events --SW_DECURSEDUMMY
	for k,_ in pairs(SW_RegEx_Lookup) do
		if string.sub(k,1,string.len("SIMPLECAST"))=="SIMPLECAST" or string.sub(k,1,string.len("SPELLCASTGO"))=="SPELLCASTGO" then
			SW_AddToMap(SW_DECURSEDUMMY, k);
		else
			SW_AddToMap(SW_DEV_EVENTDUMMY, k);
		end
	end
	
	for k,v in pairs(SW_Map) do
		for _, regExName in pairs(v) do
			SW_AddToMap(k, regExName);
		end
	end
	for k,v in pairs(SW_EnviroMap) do
		for _, regExName in pairs(v) do
			SW_AddToMap(k, regExName, SW_EventRegexMapEnviro);
		end
	end
	
	SW_SL_SetLastOk();
	SW_finalizeMap();
	
	-- pulling the SW_TmpMap info here, its already sorted
	--[[
	for i,v in ipairs(SW_EventRegexMap[SW_DEV_EVENTDUMMY]) do
		local tmp = string.sub(SW_RegEx_Lookup[v]["r"],1,4);
		if tmp == "(.+)" then
			tmp = string.sub(SW_RegEx_Lookup[v]["r"],5,5);
			if tmp ~= " " then
				if SW_TmpMap == nil then SW_TmpMap = {}; end
				table.insert(SW_TmpMap, v);	
			end
		end
	end
	--]]
end;
-- this is called if there was no direct Event->Regexp entry
-- and a regex was found using the event dummy
function SW_lateAdd(eventName, regexName, map, saveToMap, checkDupes)
	if checkDupes then
		for _,v  in ipairs(map[eventName]) do
			if v == regexName then return; end
		end
	end
	SW_AddToMap(eventName, regexName, map);
	table.sort(map[eventName], 
			function(a,b)
				return recuCheck(a,b);
			end);
	-- now add it to the map thats saved
	if saveToMap ~= nil then
		if saveToMap[eventName] == nil then
			saveToMap[eventName] ={};
		end
		table.insert(saveToMap[eventName], regexName);	
	end
	
end
------------------------- Events to listen to --------------------------------

--[[ 
	1.5 added pausing and unpausing of data collection
	so changed the event definition here and split it into 2 parts
	events that have to be on always, and events that can be switched
--]]
SW_EventCollection = {
	SW_EventsMandatory = {
		"PLAYER_TARGET_CHANGED",
		"VARIABLES_LOADED",
		--"UNIT_COMBAT", hmm i wasn't using this?
		"UNIT_PET",
		"PARTY_MEMBERS_CHANGED",
		"PARTY_LEADER_CHANGED",
		"RAID_ROSTER_UPDATE",
		"PLAYER_ENTERING_WORLD",
		
		-- for joining
		"CHAT_MSG_GUILD",
		"CHAT_MSG_OFFICER",
		"CHAT_MSG_PARTY",
		"CHAT_MSG_RAID",
		"CHAT_MSG_CHANNEL",
		-- 1.5.3 added in wow 1.11
		"CHAT_MSG_RAID_LEADER",
		
		-- 1.5.beta.2 this better not be off DOH 
		"SPELLS_CHANGED",
	},
	SW_EventsSwitched = {
		"CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS",
		"CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_MISSES",
		"CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS",
		"CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES",
		"CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS",
		"CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES",
		"CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS",
		"CHAT_MSG_COMBAT_FRIENDLYPLAYER_MISSES",
		"CHAT_MSG_COMBAT_FRIENDLY_DEATH",
		"CHAT_MSG_COMBAT_HONOR_GAIN",
		"CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS",
		"CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES",
		"CHAT_MSG_COMBAT_HOSTILE_DEATH",
		"CHAT_MSG_COMBAT_LOG_ERROR",
		"CHAT_MSG_COMBAT_LOG_MISC_INFO",
		"CHAT_MSG_COMBAT_PARTY_HITS",
		"CHAT_MSG_COMBAT_PARTY_MISSES",
		"CHAT_MSG_COMBAT_PET_HITS",
		"CHAT_MSG_COMBAT_PET_MISSES",
		"CHAT_MSG_COMBAT_SELF_HITS",
		"CHAT_MSG_COMBAT_SELF_MISSES",
		"CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF",
		"CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE",
		"CHAT_MSG_SPELL_CREATURE_VS_PARTY_BUFF",
		"CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE",
		"CHAT_MSG_SPELL_CREATURE_VS_SELF_BUFF",
		"CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE",
		"CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS",
		"CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF",
		"CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF",
		"CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE",
		"CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF",
		"CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE",
		"CHAT_MSG_SPELL_PARTY_BUFF",
		"CHAT_MSG_SPELL_PARTY_DAMAGE",
		"CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS",
		"CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE",
		"CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS",
		"CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE",
		"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS",
		"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE",
		"CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS",
		"CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE",
		"CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS",
		"CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE",
		"CHAT_MSG_SPELL_PET_BUFF",
		"CHAT_MSG_SPELL_PET_DAMAGE",
		"CHAT_MSG_SPELL_SELF_BUFF",
		"CHAT_MSG_SPELL_SELF_DAMAGE",
		"PLAYER_REGEN_DISABLED",
		"PLAYER_REGEN_ENABLED",
		
		-- added for 1.3.0 to get mana efficiency
		"SPELLCAST_CHANNEL_START",
		"SPELLCAST_STOP",
		"SPELLCAST_FAILED",
		"SPELLCAST_INTERRUPTED",
		 
		-- added 1.4 for death count
		"CHAT_MSG_COMBAT_FRIENDLY_DEATH",
		"CHAT_MSG_COMBAT_HOSTILE_DEATH",
	},
	
}
function SW_UnpauseEvents()
	local coreFrame = getglobal("SW_CoreFrame");
	for i, val in ipairs(SW_EventCollection.SW_EventsSwitched) do
		coreFrame:RegisterEvent(val);
	end
	
end
function SW_PauseEvents()
	local coreFrame = getglobal("SW_CoreFrame");
	for i, val in ipairs(SW_EventCollection.SW_EventsSwitched) do
		coreFrame:UnregisterEvent(val);
	end
end
function SW_RegisterEvents()
	SW_SL_Add(SW_SL["EVENTS"]);
	
	for i, val in ipairs(SW_EventCollection.SW_EventsMandatory) do
		this:RegisterEvent(val);
	end
	
	--[[
	-- used to check what kinds of targets are tracked
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	--this:RegisterEvent("CHAT_MSG_CHANNEL_LIST");
	
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UNIT_COMBAT");
	this:RegisterEvent("UNIT_PET");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	-- 1.4.2 added leader change
	this:RegisterEvent("PARTY_LEADER_CHANGED");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	--this:RegisterEvent("CHAT_MSG_AFK");
	--this:RegisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE");
	--this:RegisterEvent("CHAT_MSG_BG_SYSTEM_HORDE");
	--this:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL");
	--this:RegisterEvent("CHAT_MSG_CHANNEL_LIST");
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_MISSES");
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES");
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES");
	this:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLYPLAYER_MISSES");
	this:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLY_DEATH");
	this:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN");
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES");
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
	this:RegisterEvent("CHAT_MSG_COMBAT_LOG_ERROR");
	this:RegisterEvent("CHAT_MSG_COMBAT_LOG_MISC_INFO");
	--this:RegisterEvent("CHAT_MSG_COMBAT_MISC_INFO");
	this:RegisterEvent("CHAT_MSG_COMBAT_PARTY_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_PARTY_MISSES");
	this:RegisterEvent("CHAT_MSG_COMBAT_PET_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_PET_MISSES");
	this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_SELF_MISSES");
	--this:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN");
	--this:RegisterEvent("CHAT_MSG_DND");
	--this:RegisterEvent("CHAT_MSG_EMOTE");
	this:RegisterEvent("CHAT_MSG_GUILD");
	--this:RegisterEvent("CHAT_MSG_IGNORED");
	--this:RegisterEvent("CHAT_MSG_LOOT");
	--this:RegisterEvent("CHAT_MSG_MONSTER_EMOTE");
	--this:RegisterEvent("CHAT_MSG_MONSTER_SAY");
	--this:RegisterEvent("CHAT_MSG_MONSTER_WHISPER");
	--this:RegisterEvent("CHAT_MSG_MONSTER_YELL");
	this:RegisterEvent("CHAT_MSG_OFFICER");
	this:RegisterEvent("CHAT_MSG_PARTY");
	this:RegisterEvent("CHAT_MSG_RAID");
	this:RegisterEvent("CHAT_MSG_CHANNEL");
	--this:RegisterEvent("CHAT_MSG_SKILL");
	
	--this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
	--this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_PARTY");
	--this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
	--this:RegisterEvent("CHAT_MSG_SPELL_BREAK_AURA");
	
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS");
	this:RegisterEvent("CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF");
	
	this:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");
	
	this:RegisterEvent("CHAT_MSG_SPELL_PARTY_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PET_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_PET_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	
	--this:RegisterEvent("CHAT_MSG_SPELL_TRADESKILLS");
	--this:RegisterEvent("CHAT_MSG_SYSTEM");
	--this:RegisterEvent("CHAT_MSG_TEXT_EMOTE");
	--this:RegisterEvent("CHAT_MSG_WHISPER");
	--this:RegisterEvent("CHAT_MSG_WHISPER_INFORM");
	--this:RegisterEvent("CHAT_MSG_SAY");
	
	--this:RegisterEvent("SPELLCAST_STOP");
	--this:RegisterEvent("UNIT_HEALTH");
	
	-- added for 1.3.0 to get mana efficiency
	
	this:RegisterEvent("SPELLCAST_CHANNEL_START");
	--this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("SPELLCAST_FAILED");
	this:RegisterEvent("SPELLCAST_INTERRUPTED");
	this:RegisterEvent("SPELLS_CHANGED");
	 
	 this:RegisterEvent("PLAYER_REGEN_DISABLED");
	 this:RegisterEvent("PLAYER_REGEN_ENABLED");
	   
	-- added 1.4 for death count
	this:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLY_DEATH");
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
	--this:RegisterEvent("SPELLCAST_DELAYED");
	--this:RegisterEvent("SPELLCAST_CHANNEL_START");
	--this:RegisterEvent("SPELLCAST_CHANNEL_UPDATE");
	--]]
	SW_SL_SetLastOk();
end

--[[
	A wrapper arround timing
	If added to saved variables (and inited again)
	will retain cross session seconds ( and milliseconds)
	
	to save it accross sessions add myTimer to SavedVariables AND IN
	VARIABLES_LOADED: myTimer = SW_C_Timer:new(myTimer);
	
--]]
SW_C_Timer = {
	-- epoch time at init
	epochInit = time(),
	-- system up time at init
	upTimeInit = GetTime(),
	
	new = function (self, o)
		o = o or {};
		setmetatable(o, self);
		self.__index = self;
		
		if o.epochTS ~= nil then
			o.uTS = (o.epochTS + o.msO) - self.epochInit ;
		else
			self.setToNow(o);
		end
		return o;
	end,
		
	setToNow = function(self)
		self.epochTS = time();
		self.uTS = GetTime() - self.upTimeInit;
		-- store the millisecond offset
		self.msO = self.uTS - (self.epochTS - self.epochInit);
	end,
	
	-- now return value is not to be used cross session (don't save it)
	now = function(self)
		return GetTime() - self.upTimeInit;
	end,
	
	elapsed = function(self)
		return self.msRound((GetTime() - self.upTimeInit) - self.uTS);	
	end,
	
	-- one must be a timer object, the other value may be a number
	-- only numbers recieved through :now() make sense
	__sub = function(lh, rh)
		if type(rh) == "number" then
			return lh.uTS - rh;
		elseif type(lh) == "number" then
			return lh - rh.uTS;
		else
			return lh.msRound(lh.uTS - rh.uTS);
		end
	end,
	
	msRound = function(val)
		return math.floor((val) * 1000 + 0.5)/1000;
	end,
	absDiff = function(self, rh)
		local ret = self - rh;
		if ret < 0 then ret = -ret; end
		return ret; 
	end,
	
	-- seconds since startup
	SSS = function(self)
		return GetTime() - self.upTimeInit;
	end,
	
	dump = function(self)
		SW_DumpTable(self);
	end,
}
--------- My fun function so don't complain
SW_RND_Strings = { 
	["CWATER"] = {
		"pinkelt in eine Flasche...",
		"erleichtert sich.",
		"machts euch in Kirschgeschmack.",
		"denkt 'Wasser, ja Wasser wollte Ich schon immer machen.'",
		"macht euch ein POWER drink.",
		"ahhh, besser!",
		"sammelt seine Tr\195\164nen in einer Flasche",
		"macht noch mehr Blubberwasser.",
		"sagt euch da\195\159 Er kein Bier herbeizaubern kann.",
		"machts euch in Pfirsichgeschmack",
		"zieht die Nase hoch...",
		"kriegt ein mulmiges Gefuehl im Magen.",
	},
	["CBREAD"] = {
		"backe backe BROT!",
		"schmei\195\159t euch Brot an den Kopf!",
		"hat einen eigenartigen Gesichtsausdruck.",
		"PLOP!",
		"transmutiert Luft zu Brot.",
		"sucht sich ein B\195\164ckermeister.",
		
	},
};

function SW_GetRndString(baseIndex)
	if SW_RND_Strings[baseIndex] == nil then return; end
	local index = math.random(table.getn(SW_RND_Strings[baseIndex]));
	SendChatMessage(SW_RND_Strings[baseIndex][index], "EMOTE");
end
-------------------------- Dump Functions mostly for dev --------------------

function SW_printStr(str, toChannelNR)
	local chNR =1;
	if SW_DEV_INWOW then
		if toChannelNR ~= nil then chNR = toChannelNR; end
		local con = getglobal("SW_FrameConsole_Text"..chNR.."_MsgFrame");
		if con ~= nil then
			if str == nil then
				con:AddMessage("NIL");
			elseif type(str) == "boolean" then
				local v2 = "Bool:false";
				if str then
					v2 = "Bool:true";
				end
				SW_printStr (v2);
			else
				con:AddMessage(str);
			end
			
			--con:ScrollToBottom();
		end
	else
		print(str);
	end
end

function SW_DumpKeys(table)
	if table ==nil then return; end
	if type(table) ~= "table" then return; end
	SW_printStr("-- KEYS -- ");
	for k, v in pairs (table) do 
		SW_printStr(k);
		
	end
end
function SW_DumpTable(table, ds, ch, hideKey)
	if ch == nil then ch = 1; end
	if table ==nil then return "table is nil"; end
	if ds == nil then 
		ds="" 
		SW_printStr("----------------------");
	end
	
	for k, v in pairs (table) do 
		if type(v) ~= "table" then
			if v == nil then
				if hideKey then
					SW_printStr (ds.."NIL", ch);
				else
					SW_printStr (ds.."["..k.."]=NIL", ch);
				end
			elseif type(v) == "boolean" then
				local v2 = "Bool:false";
				if v then
					v2 = "Bool:true";
				end
				if hideKey then
					SW_printStr (ds..v2, ch);
				else
					SW_printStr (ds.."["..k.."]="..v2, ch);
				end
			elseif type(v) == "function" then
				if hideKey then
					SW_printStr (ds.."function", ch);
				else
					SW_printStr (ds.."["..k.."]=function", ch);
				end
			else
				if hideKey then
					SW_printStr (ds..v, ch);
				else
					SW_printStr (ds.."["..k.."]="..v, ch);
				end
			end
		else
		
			if not hideKey then
				SW_printStr (ds.."["..k.."]=", ch);
			end 
			SW_DumpTable(v, ds.."       ");
		end
		
	end

end

function SW_DumpRegs()
	for k,v in pairs (SW_RegEx_Lookup) do
		if v["r"] == nil then
			SW_printStr(k.."  EMPTY <- No global found with this name");
		else
			SW_printStr(k.." "..v["r"]);
		end
		
	end
end
function SW_DumpResultList(...)
	local i = 1;
	local ret = "";
	while arg[i] ~= nil do
		ret = ret..arg[i].." "; 
		i = i + 1;
	end
	SW_printStr(ret);
end

function SW_DumpFMAsVar()
	SW_printStr("SW_DefaultMap={");
	for k, v in pairs (SW_DEV_FINDMATCH) do 
		SW_printStr("\t[\""..k.."\"] = {") ;
		for e, _ in pairs (v) do
			-- dont add VSENVIRONMENTALDAMAGE
			if string.sub(e,1,string.len("VSENVIRONMENTALDAMAGE"))~="VSENVIRONMENTALDAMAGE" then
				SW_printStr("\t\t\""..e.."\",") ;
			end

			
		end
		SW_printStr("\t},") ;
	end
	SW_printStr("}");
end