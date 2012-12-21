--[[
  Contributed by Nerolabs Shadowsong Server US
  November 10th, 2005
  ]]

if ( GetLocale() == "frFR" ) then
  GEM_SORT_MEMBERSHIP_NAME = "RangGuilde";
  GEM_SORT_MEMBERSHIP_HELP = "Tri les joueurs en fonction de leur rang de guilde.";
elseif ( GetLocale() == "deDE" ) then
GEM_SORT_MEMBERSHIP_NAME = "Gildenrang";
GEM_SORT_MEMBERSHIP_HELP = "Sortiert Spieler unter Beachtung ihres Gildenranges.";
else
  GEM_SORT_MEMBERSHIP_NAME = "Membership";
  GEM_SORT_MEMBERSHIP_HELP = "Sort players using their membership level.";
end

--------------- Internal functions ---------------

local function _GEM_SORT_SortByMembershipList(tab1,tab2)
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

  if (tab1.rankindex == nil or tab2.rankindex == nil) then
     -- message ("Sorted by time");
     return tab1.stamp < tab2.stamp;
  end
  
  if (tab1.rankindex == tab2.rankindex) then
      -- message ("Equal Memberships " .. tab1.name .. tab1.rankindex .. " " .. tab2.name .. tab2.rankindex);
      return tab1.stamp < tab2.stamp;
  else
      -- message ("Non -Equal Memberships " .. tab1.name .. tonumber(tab1.rankindex) .. " " .. tab2.name .. tonumber(tab2.rankindex));
      return (tonumber(tab1.rankindex) < tonumber(tab2.rankindex));
  end

end

local function _GEM_SORT_Membership(players,limits,max_count)
  local list = {};
  local tits = {};
  local subs = {};
  local channelName = GEM_DefaultSendChannel;
  local gplayers = GEM_Players[GEM_Realm][channelName];
  local leader_guildname = GetGuildInfo("player") ;
  
  -- Create list of all players
  for name,tab in players do
    if (gplayers[name] ~= nil and gplayers[name].grank_name ~= nil and gplayers[name].grank_idx ~= nil and gplayers[name].grank_idx >= 0) then
      grank_name  = gplayers[name].grank_name; 
      grank_idx   = gplayers[name].grank_idx;
      
      -- SPECIAL LOGIC FOR OZ NZ GUILD ONLY, CAN BE REMOVED FOR OTHER GUILDS
      -- THIS ESTABLISHES PARTNER GUILD MEMBERS EQUAL TO RANK 4 IN OZ NZ
      -- AND RANK 6 FOR NON-MEMBERS OF THE GUILD
      if (leader_guildname == "OZ NZ") then
        if (gplayers[name].guild == "Gnome Liberation Front") then
          grank_idx = 4;
        elseif (gplayers[name].guild ~= "OZ NZ") then
          grank_idx = 6;
        end
      end
      -- END SPECIAL LOGIC
      
    else
      grank_name = "Unknown";
      grank_idx = 666;
    end
    
    -- message("Inserting " .. name .. grank_name .. grank_idx);
    
    if(tab.forcetit == nil) then tab.forcetit = 0; end;
    table.insert(list,{name=name; stamp = tab.update_time; class = tab.class; forcetit = tab.forcetit; rankindex = grank_idx; rankname = grank_name; });
  end

  -- Sort it by membership
  table.sort(list,_GEM_SORT_SortByMembershipList);
  
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

GEM_SORT_Membership = {
  --[[
    Name parameter. [MANDATORY]
     Displayed name of the sorting plugin.
  ]]
  Name = GEM_SORT_MEMBERSHIP_NAME;
  
  --[[
    SortType parameter. [MANDATORY]
     Internal code for the sorting type (must be unique).
  ]]
  SortType = "Membership";
  
  --[[
    Subscribers sorting function. [MANDATORY]
     Sorts all passed players in two lists.
     Params :
      - players : Array indexed by Names (STRINGS) of {update_time(INT),guild(STRING),class(STRING),level(INT)} : READ ONLY
      - limits : Array indexed by Classes (STRINGS) of {min(INT),max(INT),count(INT)} : 'min'/'max' is the min/max allowed for this class, 'count' is the current count in the class (always 0) : READ/WRITE
      - max_count : (INT) is the max titulars allowed for the event
     Returns :
      - Array of Names (STRING) : Titulars
      - Array of Names (STRING) : Substitutes
  ]]
  Sort = function(players,limits,max_count)
    return _GEM_SORT_Membership(players,limits,max_count);
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
  Help = GEM_SORT_MEMBERSHIP_HELP;
  
  --[[
    Default parameter. [MUST NOT BE SET]
     Sets this plugin as the default one. Must only be set by the "Stamp" plugin.
  ]]
  Default = false;
};

function GEM_SORT_Membership_OnLoad()
  GEM_SUB_RegisterPlugin(GEM_SORT_Membership);
end

