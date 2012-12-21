--[[
  Guild Event Manager by Kiki of European Cho'gall
    Players list - By Kiki
]]

GEM_PLAYERS_SORTBY_NAME = "name";
GEM_PLAYERS_SORTBY_GUILD = "guild";
GEM_PLAYERS_SORTBY_LOCATION = "location";
GEM_PLAYERS_SORTBY_LEVEL = "level";
GEM_PLAYERS_SORTBY_CLASS = "class";

local GEM_PLAYERS_LASTLOG_MAX = 60*60*24*30;
local GEM_PLAYERS_MAXDISPLAY_EVENT = 25;
local sortTypePlayers = GEM_PLAYERS_SORTBY_NAME;
local sortDirPlayers = true;
local selectPlayer = nil;

--[[
  List Functions
]]

function GEMPlayers_PlayerOnHover()
  local pl_name = this.playerName;

  if(pl_name)
  then
    GameTooltip:SetOwner(this, "ANCHOR_CURSOR");
    GameTooltip:ClearLines();

    local color1 = "00AAFF";
    local color2 = "FFFFFF";
    local color3 = "E0C010";
    
    if(not GEM_IsPlayerConnected(GEM_DefaultSendChannel,pl_name))
    then
      color1 = "005588";
      color2 = "888888";
      color3 = "706005";
    end

    local comment = "";
    local rank_idx = -1;
    local rank_name = "";
    local version = "";
    if(GEM_Players[GEM_Realm] and GEM_Players[GEM_Realm][GEM_DefaultSendChannel] and GEM_Players[GEM_Realm][GEM_DefaultSendChannel][pl_name])
    then
      comment = GEM_Players[GEM_Realm][GEM_DefaultSendChannel][pl_name].comment;
      rank_name = GEM_Players[GEM_Realm][GEM_DefaultSendChannel][pl_name].grank_name;
      rank_idx = GEM_Players[GEM_Realm][GEM_DefaultSendChannel][pl_name].grank_idx;
      version = GEM_Players[GEM_Realm][GEM_DefaultSendChannel][pl_name].version;
    end

    local lines = 0;

    lines = GEMList_AddTooltipText("|cff" .. color1 .. pl_name,lines);

    if(version and version ~= "")
    then
      lines = GEMList_AddTooltipText("|cff" .. color2 .. GEM_TEXT_GEM_VERSION .. " : |r|cff" ..color3..version.."|r",lines,color3);
    end

    if(rank_name and rank_name ~= "")
    then
      lines = GEMList_AddTooltipText("|cff" .. color2 .. GEM_TEXT_GUILD_RANK .. " " .. rank_idx .. " : |r|cff" ..color3.. rank_name.."|r",lines,color3);
    end

    if(comment and comment ~= "")
    then
      lines = GEMList_AddTooltipText("|cff" .. color2 .. GEM_TEXT_COMMENT .. " : |r|cff" ..color3..comment.."|r",lines,color3);
    end

    if(lines > 1)
    then
      GameTooltip:Show();
    else
      GameTooltip:ClearLines();
    end
  end
end


function GEMPlayers_PlayerOnClick()
  selectPlayer = this.playerName;
  GEMPlayers_UpdatePlayersList();
end

function GEMPlayers_PredicateName(a, b)
  if (a.name < b.name) then
    return true;
  elseif (a.name > b.name) then
    return false;
  end
  
  return GEMPlayers_PredicateGuild(a, b);
end

function GEMPlayers_PredicateGuild(a, b)
  if (a.guild < b.guild) then
    return true;
  elseif (a.guild > b.guild) then
    return false;
  end
  
  return GEMPlayers_PredicateLocation(a, b);
end

function GEMPlayers_PredicateLocation(a, b)
  if (a.location < b.location) then
    return true;
  elseif (a.location > b.location) then
    return false;
  end
  
  return GEMPlayers_PredicateLevel(a, b);
end

function GEMPlayers_PredicateLevel(a, b)
  if (a.level < b.level) then
    return true;
  elseif (a.level > b.level) then
    return false;
  end
  
  return GEMPlayers_PredicateClass(a, b);
end

function GEMPlayers_PredicateClass(a, b)
  if (a.class < b.class) then
    return true;
  elseif (a.class > b.class) then
    return false;
  end
  
  return false;
end

function GEMPlayers_Predicate(a, b)
  -- a ou b est nil
  if (a == nil) then
    if (b == nil) then
      return false;
    else
      return true;
    end
  elseif (b == nil) then
    return false;
  end

  GEM_SORTBY = {
    [GEM_PLAYERS_SORTBY_NAME] = GEMPlayers_PredicateName,
    [GEM_PLAYERS_SORTBY_GUILD] = GEMPlayers_PredicateGuild,
    [GEM_PLAYERS_SORTBY_LOCATION] = GEMPlayers_PredicateLocation,
    [GEM_PLAYERS_SORTBY_LEVEL] = GEMPlayers_PredicateLevel,
    [GEM_PLAYERS_SORTBY_CLASS] = GEMPlayers_PredicateClass
  };

  predicate = GEM_SORTBY[sortTypePlayers];
  return predicate(a,b);
end

function GEMPlayers_SortBy(aSortType, aSortDir)
  sortTypePlayers = aSortType;
  sortDirPlayers = aSortDir;
  GEMPlayers_UpdatePlayersList();
end

function GEMPlayers_OnSeeOfflineClick()
  GEM_Events.realms[GEM_Realm].SeeOffline = GEMPlayersFrameSeeOffline:GetChecked();
  GEMPlayers_UpdatePlayersList();
end

function GEMPlayers_GetPlayers(channel)
  local players = {};
  local shownotconnected = GEMPlayersFrameSeeOffline:GetChecked() == 1;
  local c_off = 0;
  local c_on = 0;

  for name,playertab in GEM_Players[GEM_Realm][channel]
  do
    if(playertab.guild == nil) then playertab.guild = ""; end;
    if(GEM_IsPlayerConnected(channel,name)) -- Connected
    then
      c_on = c_on + 1;
      tinsert(players, {name=name; guild=playertab.guild; location=playertab.location; level=playertab.level; class=playertab.class, connected=true, officer=playertab.officer });
    else
      c_off = c_off + 1;
      if(shownotconnected) -- Not connected
      then
        tinsert(players, {name=name; guild=playertab.guild; location=GEM_NA_FORMAT; level=playertab.level; class=playertab.class, connected=false, officer=playertab.officer });
      end
    end
  end
  table.sort(players,GEMPlayers_Predicate);
  if(not sortDirPlayers)
  then
    players = GEMList_InvertList(players);
  end
  return players,c_on,c_off;
end

function GEMPlayers_UpdatePlayersList()
  if(not GEMPlayersFrame:IsVisible())
  then
    return;
  end
  local players,c_on,c_off = GEMPlayers_GetPlayers(GEM_DefaultSendChannel);
  local size = table.getn(players);

  local enableActions = false;
  local offset = FauxScrollFrame_GetOffset(GEMPlayerItemScrollFrame);
  numButtons = GEM_PLAYERS_MAXDISPLAY_EVENT;
  i = 1;
  GEMPlayersFrameWhisper:Disable();
  GEMPlayersFrameInvite:Disable();

  while (i <= numButtons)
  do
    local j = i + offset
    local prefix = "GEMPlayerItem"..i;
    local button = getglobal(prefix);

    if (j <= size)
    then
      local player = players[j];

      button.playerName = player.name;
      getglobal(prefix.."Name"):SetText(player.name);
      getglobal(prefix.."Guild"):SetText(player.guild);
      getglobal(prefix.."Location"):SetText(player.location);
      getglobal(prefix.."Level"):SetText(player.level);
      getglobal(prefix.."Class"):SetText(player.class);
      if(player.connected)
      then
        getglobal(prefix.."Name"):SetTextColor(0.9,0.8,0.10);
        if(player.officer and player.officer ~= 0)
        then
          if(player.officer == 2) -- Guild leader
          then
            getglobal(prefix.."Guild"):SetTextColor(0.1,0.9,0.1);
          elseif(player.officer == 1) -- Guild officer
          then
            getglobal(prefix.."Guild"):SetTextColor(0.3,0.3,0.9);
          end
        else -- Normal member
          getglobal(prefix.."Guild"):SetTextColor(1,1,1);
        end
        getglobal(prefix.."Location"):SetTextColor(1,1,1);
        getglobal(prefix.."Level"):SetTextColor(1,1,1);
        getglobal(prefix.."Class"):SetTextColor(1,1,1);
      else
        getglobal(prefix.."Name"):SetTextColor(0.3,0.3,0.3);
        getglobal(prefix.."Guild"):SetTextColor(0.3,0.3,0.3);
        getglobal(prefix.."Location"):SetTextColor(0.3,0.3,0.3);
        getglobal(prefix.."Level"):SetTextColor(0.3,0.3,0.3);
        getglobal(prefix.."Class"):SetTextColor(0.3,0.3,0.3);
      end
      button:Show();

      -- selected
      if (selectPlayer == player.name and selectPlayer ~= GEM_PlayerName)
      then
        button:LockHighlight();
        if(player.connected)
        then
          enableActions = true;
        end
      else
        button:UnlockHighlight();
      end
    else
      button.playerName = nil;
      button:Hide();
    end
    i = i + 1;
  end
  
  GEMPlayersFrameCountString:SetText(string.format(GEM_TEXT_PLAYERS_COUNT,c_on,c_on+c_off));

  FauxScrollFrame_Update(GEMPlayerItemScrollFrame, size, GEM_PLAYERS_MAXDISPLAY_EVENT, 17);
  if(enableActions)
  then
    GEMPlayersFrameWhisper:Enable();
    GEMPlayersFrameInvite:Enable();
  end
end

function GEMPlayers_OnShow()
  if(GEM_Events.realms[GEM_Realm].SeeOffline)
  then
    GEMPlayersFrameSeeOffline:SetChecked(1);
  else
    GEMPlayersFrameSeeOffline:SetChecked(0);
  end

  GEMPlayers_UpdatePlayersList();
end

function GEMPlayers_OnLoad()
end

function GEMPlayers_WhisperOnClick()
  if ( not ChatFrameEditBox:IsVisible() ) then
    ChatFrame_OpenChat("/w "..selectPlayer.." ");
  else
    ChatFrameEditBox:SetText("/w "..selectPlayer.." ");
  end
  ChatEdit_ParseText(ChatFrame1.editBox, 0);
end

function GEMPlayers_InviteOnClick()
  InviteByName(selectPlayer);
end

--------------- Exported functions ---------------

function GEM_PLAY_GetMyPlayerInfos(channel)
  local name = GEM_PlayerName;
  local guild,grank_name,grank_idx = GetGuildInfo("player");
  local officer = 0;
  local location = GetRealZoneText();
  local comment = GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].comment;
  if(location == nil)
  then
    location = GEM_NA_FORMAT;
  end
  local level = UnitLevel("player");
  local _,class = UnitClass("player");
  if(IsGuildLeader() == 1)
  then
    officer = 2;
  elseif(CanViewOfficerNote() == 1)
  then
    officer = 1;
  end
  
  if(guild == nil) -- No guild, set rank idx at -1
  then
    grank_idx = -1;
  end
  GEM_CheckPlayerGuild();
  GEM_ChatDebug(GEM_DEBUG_GLOBAL,"GEM_PLAY_GetMyPlayerInfos : Channel "..tostring(channel).." for Player "..GEM_PlayerName);
  if(GEM_Players[GEM_Realm][channel][GEM_PlayerName] == nil)
  then
    GEM_Players[GEM_Realm][channel][GEM_PlayerName] = {};
  end
  GEM_Players[GEM_Realm][channel][GEM_PlayerName].guild = guild;
  GEM_Players[GEM_Realm][channel][GEM_PlayerName].location = location;
  GEM_Players[GEM_Realm][channel][GEM_PlayerName].level = level;
  GEM_Players[GEM_Realm][channel][GEM_PlayerName].class = GEM_Classes[class];
  GEM_Players[GEM_Realm][channel][GEM_PlayerName].officer = officer;
  GEM_Players[GEM_Realm][channel][GEM_PlayerName].grank_name = grank_name;
  GEM_Players[GEM_Realm][channel][GEM_PlayerName].grank_idx = grank_idx;
  GEM_Players[GEM_Realm][channel][GEM_PlayerName].version = GEM_VERSION;
  GEM_Players[GEM_Realm][channel][GEM_PlayerName].comment = comment;
  GEM_Players[GEM_Realm][channel][GEM_PlayerName].lastlog = time();
  
  return name,guild,location,level,class,officer,grank_name,grank_idx,GEM_VERSION,comment;
end

function GEM_PLAY_FillPlayerInfos(channel,name,guild,location,level,class,officer,grank_name,grank_idx,version,comment)
  if(name == nil) -- Me
  then
    GEM_PLAY_GetMyPlayerInfos(channel);
    return;
  end

  if(guild == nil)
  then
    guild = "";
  end
  
  if(GEM_Players[GEM_Realm][channel][name] == nil)
  then
    GEM_Players[GEM_Realm][channel][name] = {};
  end
  GEM_Players[GEM_Realm][channel][name].guild = guild;
  GEM_Players[GEM_Realm][channel][name].location = location;
  GEM_Players[GEM_Realm][channel][name].level = level;
  GEM_Players[GEM_Realm][channel][name].class = GEM_Classes[class];
  GEM_Players[GEM_Realm][channel][name].officer = officer;
  GEM_Players[GEM_Realm][channel][name].grank_name = grank_name;
  GEM_Players[GEM_Realm][channel][name].grank_idx = grank_idx;
  GEM_Players[GEM_Realm][channel][name].version = version;
  GEM_Players[GEM_Realm][channel][name].comment = comment;
  GEM_Players[GEM_Realm][channel][name].lastlog = time();
end

function GEM_PLAY_GetLastLeave(channel,pl_name)
  if(channel == nil or pl_name == nil or GEM_Players[GEM_Realm] == nil or GEM_Players[GEM_Realm][channel] == nil or GEM_Players[GEM_Realm][channel][pl_name] == nil or GEM_Players[GEM_Realm][channel][pl_name].lastleave == nil)
  then
    return 0;
  end
  return GEM_Players[GEM_Realm][channel][pl_name].lastleave;
end

function GEMPlayers_CheckExpiredPlayers(channel)
  if(GEM_Players[GEM_Realm] == nil or GEM_Players[GEM_Realm][channel] == nil)
  then
    return;
  end

  GEM_ChatDebug(GEM_DEBUG_GLOBAL,"GEMPlayers_CheckExpiredPlayers : Checking expired players in channel "..channel);
  local tim = time();
  
  for name,playertab in GEM_Players[GEM_Realm][channel]
  do
    if((playertab.lastlog + GEM_PLAYERS_LASTLOG_MAX) < tim)
    then
      GEM_ChatDebug(GEM_DEBUG_GLOBAL,"GEMPlayers_CheckExpiredPlayers : Too long since last log from player "..name.." in channel "..channel..", Removing !");
      GEM_Players[GEM_Realm][channel][name] = nil;
    end
  end
end

