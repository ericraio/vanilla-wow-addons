--[[
  Healers Assist by Kiki of European Cho'gall (Alliance)
    Regexpr functions
    Taken from SWStats by Artack - Thanks !
]]

--------------- Constantes ---------------

--------------- Shared variables ---------------

HA_RegEx_Lookup = {};

--------------- Local variables ---------------

local HA_SL_RegExCreate = 0;
local HA_SL_RegExAdded = 0;
local HA_MAX_ARGS = 4;

HA_DefaultMap= {
  ["CHAT_MSG_SPELL_SELF_BUFF"] = {
    [1] = "HEALEDCRITSELFSELF",
    [2] = "HEALEDCRITSELFOTHER",
    [3] = "HEALEDSELFSELF",
    [4] = "HEALEDSELFOTHER",
  },
  ["CHAT_MSG_SPELL_PARTY_BUFF"] = {
    [1] = "HEALEDCRITOTHERSELF",
    [2] = "HEALEDCRITOTHEROTHER",
    [3] = "HEALEDOTHERSELF",
    [4] = "HEALEDOTHEROTHER",
  },
  ["CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF"] = {
    [1] = "HEALEDCRITOTHERSELF",
    [2] = "HEALEDCRITOTHEROTHER",
    [3] = "HEALEDOTHERSELF",
    [4] = "HEALEDOTHEROTHER",
  },
  ["CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF"] = {
    [1] = "HEALEDCRITOTHERSELF",
    [2] = "HEALEDCRITOTHEROTHER",
    [3] = "HEALEDOTHERSELF",
    [4] = "HEALEDOTHEROTHER",
  },
  ["CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS"] = {
    [1] = "PERIODICAURAHEALSELFSELF",
  },
  ["CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS"] = {
    [1] = "PERIODICAURAHEALSELFOTHER",
  },
  ["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS"] = {
    [1] = "PERIODICAURAHEALSELFOTHER",
  },
};

--------------- Internal functions ---------------

local function HA_g1(doMe, withInfo)
  _,_,v1 = string.find(doMe, withInfo["r"])
  if v1 == nil then return nil; end
  return {v1};
end
local function HA_g2(doMe, withInfo)
  _,_,v1, v2 = string.find(doMe, withInfo["r"])
  if v2 == nil then return nil; end
  return {v1, v2};
end
local function HA_g3(doMe, withInfo)
  _,_,v1, v2, v3 = string.find(doMe, withInfo["r"])
  if v3 == nil then return nil; end
  return {v1, v2, v3};
end
local function HA_g4(doMe, withInfo)
  _,_,v1, v2, v3, v4 = string.find(doMe, withInfo["r"])
  if v4 == nil then return nil; end
  return {v1, v2, v3, v4};
end

local HA_Func_Lookup = {HA_g1,HA_g2,HA_g3,HA_g4}; -- Must be declared after functions

-- here we resort the values via the mapping that was created during the init
local function HA_sortVals(vals, withInfo)
  if vals == nil then return nil; end
  local ret = {};
  for k,v in pairs(withInfo["p"]) do
    ret[v] = vals[k];
  end
  return ret;
end

function HA_getInfo(doMe, withInfo )
  -- if we don't have a function  or # of captures is invlid return nil
  if withInfo["r"] == nil or withInfo["i"] > HA_MAX_ARGS or withInfo["i"] < 1  then return nil; end

  -- resort if we have to
  if withInfo["p"] == nil then
    return HA_Func_Lookup[withInfo["i"]](doMe, withInfo);
  else
    return HA_sortVals(HA_Func_Lookup[withInfo["i"]](doMe, withInfo), withInfo);
  end
end

local function _HA_InitVar(varName,types,fromSelf,toSelf,isCrit)
  local str = getglobal(varName);
  if str == nil then return end;
  if types == nil then return end;
  
  --fixes ambiguous strings
  -- fix log strings is a localized function
  local strTmp = HA_FixLogStrings(str);
  if(str ~= strTmp)
  then
    setglobal(varName, strTmp);
    str = strTmp;
  end
  
  HA_SL_RegExCreate = HA_SL_RegExCreate +1;
  HA_RegEx_Lookup[varName] ={};
  
  -- "p"	stands for positions maps found for numbered vals (e.g. %3$s)
  -- in a different langugage these might be used in a different order
  HA_RegEx_Lookup[varName]["p"] ={}; 
  
  HA_RegEx_Lookup[varName]["types"] = types; 
  if(fromSelf)
  then
    HA_RegEx_Lookup[varName]["fromSelf"] = 1;
  end
  if(toSelf)
  then
    HA_RegEx_Lookup[varName]["toSelf"] = 1;
  end
  if(isCrit)
  then
    HA_RegEx_Lookup[varName]["isCrit"] = 1;
  end

  local index=0;
  local needPosLookup = false;
  -- first we have to "sanitze" the string  ^()%.[]*+-?  are special chars in a regex (dont escape the $ and %)
  -- so we are escaping these with %
  str = string.gsub(str, "([%.%(%)%+%-%?%[%]%^])", "%%%1");

  -- the inner function actually does the work
  str = string.gsub(str,'(%%(%d?)$?([sd]))',
    function(all,num,type) -- e.g. %3$s all = %3$s  num=3 type=s
      index = index+1;
      --1.0.2 , fixed the french version bug through "tonumber .. omg DOH .. oh well
      -- this will help all non english versions
      HA_RegEx_Lookup[varName]["p"][index] = tonumber(num);
      if(num ~= "")
      then 
        -- if num is "" then the string e.g. only used %s and not %1$s
        -- and we dont need a lookup - its already in order
        needPosLookup = true;
      end

      --this is the actual replacement that makes the regex
      -- use non greedy for strings
      if(type == 's')
      then
        return ('(.-)');
      else
        return ('(%d+)');
      end
    end
  );

  -- saves how many captures to expect later using this regex
  HA_RegEx_Lookup[varName]["i"] = index; 

  --generate maps for heal dmg etc info
  if(index == getn(types))
  then
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
    for i, val in ipairs(types)
    do
      if(val == 2)
      then
        mm[1] = i;
        medm[1] = i;
      elseif(val == 1)
      then
        mm[2] = i;
        medm[2] = i;
      elseif(val == 51)
      then
        mm[3] = i;
        medm[3] = i;
      elseif(val == 52)
      then
        mm[4] = i;
        medm[4] = i;
      elseif(val == 3)
      then
        mm[5] = i;
        medm[5] = i;
      elseif(val == 7)
      then
        mm[6] = i;
        medm[6] = i;
      end
    end

    if(fromSelf)
    then
      mm[1]= -1;
    end
    if(toSelf)
    then
      mm[2]= -1;
    end	
    HA_RegEx_Lookup[varName]["basicInfo"] = mm;
  else
    HA_ChatWarning("_HA_InitVar "..varName.." "..index.."~="..getn(types).." caputerN~=TypeN");
  end

  if (needPosLookup)
  then
    -- check if we really do need it
    -- could be in order anyways
    needPosLookup = false;
    for k, v in pairs(HA_RegEx_Lookup[varName]["p"])
    do 
      -- make k, v numbers, so they will compare
      -- k,v are of different types so this wouldn't work otherwise
      k = k+0;
      v = v+0;
      if(k ~= v)
      then
        needPosLookup = true;
        break;
      end
    end
  end
  -- now we are sure if we need it or not
  if(not needPosLookup)
  then
    -- %s %d etc. used info is "in order"
    -- or %1$s %2$d etc. was used but all in correct order
    -- just junk it
    HA_RegEx_Lookup[varName]["p"] = nil;
  end

  HA_RegEx_Lookup[varName]["r"] = "^"..str; -- the regex
end
  
--------------- Shared functions ---------------

function HA_findEventMatch(event,callback)
  -- only interested in stuff with numbers
  -- V0.92 Changed this regex
  --V 1.1.0 Added () -- fix for french crit vals
  if (not arg1 or not string.find (arg1, "[%s%.%:%(]%d+[%s%.%)]")) then
    return;
  end
  
  if(HA_DefaultMap[event] ~= nil)
  then
    for _,v  in ipairs(HA_DefaultMap[event])
    do
      r = HA_getInfo(arg1,HA_RegEx_Lookup[v]);
      if(r ~= nil)
      then
        local re = HA_RegEx_Lookup[v];
        local reBI= re["basicInfo"];
        local from = reBI[1];
        local to = reBI[2];
        local what = reBI[5];
        local school = reBI[6];
        local heal = tonumber(r[reBI[4]]);
        local crit = false;
        if from == -1 then from = HA_PlayerName; else from = r[from]; end
        if to == -1 then to = HA_PlayerName; else to = r[to] end
        if(re["isCrit"] == 1) then crit = true; end
        if(what) then what = r[what]; end
        callback(event, from, to, what, heal, crit);
        return;
      end
    end
  end
end

function HA_CreateRegexFromGlobals()
  HA_RegEx_Lookup = {};
  HA_SL_RegExCreate = 0;
  HA_SL_RegExAdded = 0;
  
    --1 = target
    --2 = caster/attacker/initiator
    --3 = someString (normally spell names, or item names)
    -- 51 = dmg 52 = heal
    --{from,to,dmg,heal, what}
  _HA_InitVar("HEALEDSELFSELF",{3,52},true,true,nil);
  _HA_InitVar("HEALEDSELFOTHER",{3,1,52},true,nil,nil);
  _HA_InitVar("HEALEDCRITSELFSELF",{3,52},true,true,true);
  _HA_InitVar("HEALEDCRITSELFOTHER",{3,1,52},true,nil,true);
  _HA_InitVar("HEALEDOTHERSELF",{2,3,52},nil,true,nil);
  _HA_InitVar("HEALEDOTHEROTHER",{2,3,1,52},nil,nil,nil);
  _HA_InitVar("HEALEDCRITOTHERSELF",{2,3,52},nil,true,true);
  _HA_InitVar("HEALEDCRITOTHEROTHER",{2,3,1,52},nil,nil,true);
  -- Hots
  _HA_InitVar("PERIODICAURAHEALSELFSELF",{52,3},true,true,nil);
  _HA_InitVar("PERIODICAURAHEALSELFOTHER",{1,52,3},true,nil,nil);

  --SPELLFAILCASTSELF
end

