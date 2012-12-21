--[[
  Guild Event Manager by Kiki of European Cho'gall
    Subscribers sorting - By stamp - By Kiki
]]


if ( GetLocale() == "frFR" ) then
GEM_SORT_NAME = "Date";
GEM_SORT_HELP = "Tri les joueurs en fonction de leur date d'inscription.";
elseif ( GetLocale() == "deDE" ) then
GEM_SORT_NAME = "Datum";
GEM_SORT_HELP = "Sortiert Spieler unter Beachtung ihrer Anmeldezeit.";
else
GEM_SORT_NAME = "Date";
GEM_SORT_HELP = "Sort players using their subscription time.";
end
--------------- Internal functions ---------------

local function _GEM_SORT_SortList(tab1,tab2)
  if(tab1.forcetit == 1)
  then
    if(tab2.forcetit == 0)
    then
      return true;
    end
  else
    if(tab2.forcetit == 1)
    then
      return false;
    end
  end
  return tab1.stamp < tab2.stamp;
end

local function _GEM_SORT_Sort(players,limits,max_count)
  local list = {};
  local tits = {};
  local subs = {};

  -- Create list of all players
  for name,tab in players do
    if(tab.forcetit == nil) then tab.forcetit = 0; end;
    table.insert(list,{name=name; stamp = tab.update_time; class = tab.class; forcetit = tab.forcetit });
  end

  -- Sort it by stamp
  table.sort(list,_GEM_SORT_SortList);
  
  -- Fill tits and subs, using limits
  for i,tab in list do
    if(table.getn(tits) >= max_count or limits[tab.class].count >= limits[tab.class].max) -- Over the global or class limit ?
    then
      table.insert(subs,tab.name);
    else
      table.insert(tits,tab.name);
      limits[tab.class].count = limits[tab.class].count + 1;
    end
  end
  
  -- Return lists
  return tits,subs;
end


--------------- Plugin structure ---------------

GEM_SORT_Stamp = {
  --[[
    Name parameter. [MANDATORY]
     Displayed name of the sorting plugin.
  ]]
  Name = GEM_SORT_NAME;
  
  --[[
    SortType parameter. [MANDATORY]
     Internal code for the sorting type (must be unique).
  ]]
  SortType = "Stamp";
  
  --[[
    Subscribers sorting function. [MANDATORY]
     Sorts all passed players in two lists.
     Params :
      - players : Array indexed by Names (STRINGS) of {update_time(INT),guild(STRING),class(STRING),level(INT),forcetit(INT)} : READ ONLY
      - limits : Array indexed by Classes (STRINGS) of {min(INT),max(INT),count(INT)} : 'min'/'max' is the min/max allowed for this class, 'count' is the current count in the class (always 0) : READ/WRITE
      - max_count : (INT) is the max titulars allowed for the event
     Returns :
      - Array of Names (STRING) : Titulars
      - Array of Names (STRING) : Substitutes
  ]]
  Sort = function(players,limits,max_count)
    return _GEM_SORT_Sort(players,limits,max_count);
  end;
  
  --[[
    Subscribers recover function. [MANDATORY]
     Gives the plugin a chance to re-initialize its internal data (lost when leader crashed), based on the passed 'players' structure.
     The "Sort" function will be called just after this call, so your data must be initialized.
     Params :
      - players : Array indexed by Names (STRINGS) of {update_time(INT),guild(STRING),class(STRING),level(INT)} : READ ONLY
                  WARNING : 'update_time' and 'guild' values are not accurate here, don't rely on them !
      - limits : Array indexed by Classes (STRINGS) of {min(INT),max(INT),count(INT)} : 'min'/'max' is the min/max allowed for this class, 'count' is the current count in the class (always 0) : READ/WRITE
      - max_count : (INT) is the max titulars allowed for the event
  ]]
  Recover = function(players,limits,max_count)
    -- Nothing to do, no internal data
  end;
  
  --[[
    Configure function. [OPTIONAL]
     Configures the plugin.
  ]]
  --Configure = function()
  --end;

  --[[
    Help parameter. [OPTIONAL]
     Help string displayed when you mouse over the sort type.
  ]]
  Help = GEM_SORT_HELP;
  
  --[[
    Default parameter. [MUST NOT BE SET]
     Sets this plugin as the default one. Must only be set by the "Stamp" plugin.
  ]]
  Default = true;
};

function GEM_SORT_OnLoad()
  GEM_SUB_RegisterPlugin(GEM_SORT_Stamp);
end

