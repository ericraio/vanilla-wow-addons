---------------------
-- Helper Function --
---------------------

-- ReagentData_Flatten(table)
--
-- This function takes a two-dimensional table and flattens it.  This is
-- necessary due to the way profession tables are built (to assist in
-- maintainability).  If necessary, this function can be extended to an 
-- n-dimensional table by way of recursion, though this requires a minor
-- logic change and will not be done unless necessary.

function ReagentData_Flatten(table)
     if (type(table) ~= "table") then
	  return;
     end

     local returnTable = {};

     for key,value in table do
	  if (type(value) == "table") then
	       for subKey, subValue in value do
		    tinsert(returnTable, subValue);
	       end
	  else
	       tinsert(returnTable, value);
	  end
     end

     return returnTable;
end

ReagentData = {};
ReagentData['crafted'] = {};

-- Reagent Data: Version
ReagentData['version'] = "2.4.0c";

-- Now perform localizations if needed
if (GetLocale() == "deDE") then
     ReagentData_LoadGerman();
elseif (GetLocale() == "frFR") then
     ReagentData_LoadFrench();
elseif (GetLocale() == "zhCN") then
	 ReagentData_LoadChinese();
else
     ReagentData_LoadEnglish();
end

---------------
-- Functions --
---------------

------------------------
-- EXTERNAL FUNCTIONS --
------------------------

-- ReagentData_ClassSpellReagent(item)
--
-- This function takes an item name (such as "Fish Oil") and returns
-- an array of classes that use the reagent {"Shaman"}.  It returns the
-- translated text version of the name.

function ReagentData_ClassSpellReagent(item)
     if (item == nil or ReagentData['spellreagents'] == nil) then
	  return;
     end
     
     local returnArray = {};

     for class, subtable in ReagentData['spellreagents'] do
	  for key, value in subtable do
	       if (value == item) then
		    tinsert(returnArray, class);
	       end
	  end
     end

     return returnArray;
end

-- ReagentData_GatheredBy(item)
--
-- This function takes an item name (such as "Light Leather") and returns
-- an array of gather skills that are used to gather the item.  For example, 
-- calling ReagentData_GatheredBy("Light Leather") on an English client
-- will return {"Skinning"}.  Results are not sorted, so be sure to run them 
-- through table.sort if you want them in alphabetical order.
--
-- I can't think of any items that are gathered by more than one skill, but 
-- this way the function behaves the same as other API calls and is flexible 
-- in case we  can one day skin herbs or something.

function ReagentData_GatheredBy(item)
     if (item == nil) then
	  return;
     end

     local returnArray = {};

     for profession in ReagentData['gathering'] do
	  if (ReagentData[profession] ~= nil) then
	       for key, value in ReagentData[profession] do
		    if (value == item) then 
			 tinsert(returnArray, ReagentData['gathering'][profession]);
			 break;
		    end
	       end
	  end
     end

     return returnArray;	  
end

-- ReagentData_GetItemClass(class)
--
-- Returns the data array for the requested item class.  This is the 
-- Reagent Data name for the item, NOT the translated name.  This means
-- you'll need to run it through ReagentData['reverseprofessions'] or
-- ReagentData['reversegatherskills'] first.  This function does NOT
-- flatten the returned function either, so keep that in mind when loading
-- professions; it doesn't apply to base classes such as ReagentData['bar'].
--
-- Most authors will simply want to access the ReagentData tables directly
-- instead of using this function, but it's provided anyway.

function ReagentData_GetItemClass(class)
     if (class == nil or ReagentData[class] == nil) then
	  return;
     end

     return ReagentData[class];
end

-- ReagentData_GetProfessions(item)
--
-- Returns a table that contains a translated list of all professions
-- that use the specified item.  For example, calling
-- ReagentData_GetProfessions("Light Leather") on an English client
-- will return {"Blacksmithing", "Engineering", "Leatherworking", "Tailoring"}.
-- Results are not sorted, so be sure to run them through table.sort if you
-- want them in alphabetical order.

function ReagentData_GetProfessions(item)
     if (item == nil) then
	  return;
     end

     local returnArray = {};

     for profession in ReagentData['professions'] do
	  if (ReagentData[profession] ~= nil) then
	       for key, value in ReagentData[profession] do
		    if (value == item) then 
			 tinsert(returnArray, ReagentData['professions'][profession]);
			 break;
		    end
	       end
	  end
     end

     return returnArray;
end

-- ReagentData_GetSpellReagents(class)
--
-- Returns a table that contains all spell reagents used by the specified
-- class.  For example, calling ReagentData_GetSpellReagents("shaman"}
-- will return {"Ankh", "Fish Oil", "Shiny Fish Scales"}.  If class
-- is omitted or specified as "all", all classes and spell reagents will
-- be returned in a multi-dimensional array.

function ReagentData_GetSpellReagents(class)
     if (class == nil) then
	  class = "all";
     end

     if (class == "all") then
	  return ReagentData['spellreagents'];
     end

     for key, value in ReagentData['spellreagents'] do
	  if (key == class) then
	       return value;
	  end
     end

     return nil;
end

-- ReagentData_IsMonsterDrop(item)
--
-- A Boolean function that indicates if the specified item is primarily 
-- obtained from monster drops.  Item is expected to be a localized string 
-- such as "Tiger Meat".

function ReagentData_IsMonsterDrop(item)
     if (item == nil or ReagentData['monsterdrops'] == nil) then
	  return false;
     end

     for key, value in ReagentData['monsterdrops'] do
	  if (value == item) then
	       return true;
	  end
     end

     return false;     
end

-- ReagentData_IsUsedByProfession(item, profession)
--
-- A Boolean function that indicates if the specified profession
-- uses the specified item.  Both profession and item are expected
-- to be the localized text version of the name (such as
-- "Copper Bar" and "Blacksmithing").

function ReagentData_IsUsedByProfession(item, profession)
     -- If we have nil arguments, just return false.
     if (item == nil or profession == nil) then
	  return false;
     end

     -- Now make sure we were passed a valid profession
     if (ReagentData['reverseprofessions'] == nil or ReagentData['reverseprofessions'][profession] == nil) then
	  return false;
     end

     -- Check to see if the requested item is in the array.  If so, return true.
     for key, value in ReagentData[ReagentData['reverseprofessions'][profession]] do
	  if (value == item) then
	       return true;
	  end
     end

     -- If we've gotten here, it's not in the requested profession, so return false.
     return false;
end

-- ReagentData_IsVendorItem(item)
--
-- A Boolean function that indicates if the specified item is primarily
-- obtained from vendors.  Item is expected to be a localized string such as "Heavy Stock".

function ReagentData_IsVendorItem(item)
     if (item == nil or ReagentData['vendor'] == nil) then
	  return false;
     end

     for key, value in ReagentData['vendor'] do
	  if (value == item) then
	       return true;
	  end
     end

     return false;
end

------------------------
-- INTERNAL FUNCTIONS --
------------------------

-- Not only do you not need to touch these function, but they're localized
-- to Reagent Data to prevent any confusion.  :-)

-- ReagentData_CreateReverseProfessions()
--
-- Creates the ReagentData['reverseprofessions'] array.

local function ReagentData_CreateReverseProfessions()
     if (ReagentData['professions'] == nil) then
	  return;
     end

     local returnArray = {};

     for key, profession in ReagentData['professions'] do
	  returnArray[profession] = key;
     end

     return returnArray;
end

-- ReagentData_CreateReverseGatherSkills()
--
-- Creates the ReagentData['reversegathering'] array.

local function ReagentData_CreateReverseGatherSkills()
     if (ReagentData['gathering'] == nil) then
	  return;
     end

     local returnArray = {};

     for key, profession in ReagentData['gathering'] do
	  returnArray[profession] = key;
     end

     return returnArray;
end

---------------------
-- Execution Block --
---------------------

-- ReagentData['reverseprofessions'] 
--
-- This array allows you to translated the localized text version of a profession
-- into the index used by Reagent Data.  This is useful if your addon has the localized
-- version ("Blacksmithing") and would like to access the associated data array.  You 
-- could do this via ReagentData[ReagentData['reverseprofessions']["Blacksmithing"]].

ReagentData['reverseprofessions'] = ReagentData_CreateReverseProfessions();

-- ReagentData['reversegathering'] 
--
-- This array allows you to translated the localized text version of a gather skill
-- into the index used by Reagent Data.  This is useful if your addon has the localized
-- version ("Mining") and would like to access the associated data array.  You 
-- could do this via ReagentData[ReagentData['reversegathering']["Mining"]].

ReagentData['reversegathering'] = ReagentData_CreateReverseGatherSkills();