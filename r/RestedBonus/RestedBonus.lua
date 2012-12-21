--[[ RestedBonus: Displays rested bonus information.
    Written by Vincent of Blackhand, (copyright 2005 by D.A.Down)

    Version history:
    1.0 - WoW 1.10 update.
    0.9 - WoW 1.9 update.
    0.8.1 - Added ignore and percent options.
    0.8 - WoW 1.8 update, added delete command.
    0.7.5 - WoW 1.7 update, replaced game time with system time.
    0.7.4 - added level up flag, grey on low rest, key bindings.
    0.7.3 - added player level, /rbs shortcut.
    0.7.2 - WoW 1.6 update, uses current chat window.
    0.7.1 - Color coded the display.
    0.7 - Initial public release.
]]

local Server,Player,Del;
local FCg = "|cffbbbbbb";
local FCw = "|cffffffff";
local FCy = "|cffffff10";
local FCo = "|cffff9050";
local FCr = "|cffff4040";
local LGreen = {r=0.5; g=1.0; b=0.0};
local function rgb(c) return c.r, c.g, c.b; end
local function print(msg) SELECTED_CHAT_FRAME:AddMessage("RB: "..msg, rgb(LGreen)); end

RestedBonus_Data = {}
RestedBonus_Percent = 100

function RestedBonus_Init()
    -- add our chat commands
    SlashCmdList["RESTEDBONUS"] = RestedBonus_Cmd;
    SLASH_RESTEDBONUS1 = "/restedbonus";
    SLASH_RESTEDBONUS2 = "/rb";
    SlashCmdList["RESTEDBONUSS"] = function() RestedBonus_Cmd('server'); end;
    SLASH_RESTEDBONUSS1 = "/rbs";
    SlashCmdList["RESTEDBONUSD"] = RestedBonus_Delete;
    SLASH_RESTEDBONUSD1 = "/rbd";
    Player = UnitName("player");
    Server = GetCVar("realmName");
    if(not RestedBonus_Data[Server]) then RestedBonus_Data[Server]={}; end
    -- Hook player logout
    RestedBonus_Logout_Save = Logout;
    Logout = function() RestedBonus_Logout(); RestedBonus_Logout_Save(); end
    -- Hook player quit
    RestedBonus_Quit_Save = Quit;
    Quit = function() RestedBonus_Logout(); RestedBonus_Quit_Save(); end;
end

function RestedBonus_Logout()
    if(RestedBonus_Save(true)) then print("Rested data saved."); end
end

function RestedBonus_Save(logout)
    if(Del and logout) then return; end
    if(RestedBonus_Data[Server][Player] and RestedBonus_Data[Server][Player].lvl==0) then return; end
    local bonus = GetXPExhaustion();
    local curXP = UnitXP("player");
    local maxXP = UnitXPMax("player");
    local level = UnitLevel("player");
    if(not bonus) then bonus = 0; end
    local data = {bonus=bonus;maxXP=maxXP;time=time(),rest=IsResting(),lvl=level};
    data.lvlXP = maxXP-curXP;
    RestedBonus_Data[Server][Player] = data;
    return data;
end

local function find_name(data,str)
    local name = strlower(str);
    local match = function(k,v) return name==strlower(k) and {k,v} or nil; end
    local svr = foreach(data,match);
    if(svr) then return svr[1],svr[2]; end
end

local function RB_Delete(player,server)
    if(not RestedBonus_Data[server]) then
      local name = find_name(RestedBonus_Data,server);
      if(name) then server = name;
      else print(FCr.."Unknown server, '"..server.."'"); return; end
    end
    if(not RestedBonus_Data[server][player]) then
      local name = find_name(RestedBonus_Data[server],player);
      if(name) then player = name;
      else print(FCr.."Unknown player, '"..player.."'"); return; end
    end
    RestedBonus_Data[server][player] = nil;
    if(not next(RestedBonus_Data[server])) then
      RestedBonus_Data[server] = nil;
    end
    print("Deleted "..player.." on "..server);
end

function RestedBonus_Delete(msg)
    if(msg=='') then RB_Delete(Player,Server); Del=1; return; end
    local s,e,player,server = strfind(msg,'^(%S+)%s+(%S+)$');
    if(s) then RB_Delete(player,server);
    else RB_Delete(msg,Server); end
end

-- handle our chat command
function RestedBonus_Cmd(msg)
    local data = RestedBonus_Save();
    if(msg=='') then
      RestedBonus_Display(Player,data);
    elseif(msg=='server') then
      RestedBonus_Server(Server,RestedBonus_Data[Server]);
    elseif(msg=='all') then
      foreach(RestedBonus_Data,RestedBonus_Server);
    elseif(msg=='ignore') then
      if(RestedBonus_Data[Server][Player].lvl>0) then
        RestedBonus_Data[Server][Player].lvl = 0
        print(Player.." will be ignored in reports.")
        return
      end
      RestedBonus_Data[Server][Player].lvl = UnitLevel("player")
      print(Player.." will be included in reports.");
    elseif(msg=='percent') then
      RestedBonus_Percent = 250 - RestedBonus_Percent;
      print("Full bonus percent is now "..RestedBonus_Percent);
    else
      local svr,list = find_name(RestedBonus_Data,msg);
      if(svr) then RestedBonus_Server(svr,list);
      else print(FCr.."Unknown server, '"..msg.."'"); end
    end
end

function RestedBonus_Server(svr,list)
    print(FCw..svr.." characters:");
    foreach(list,RestedBonus_Display);
end

function RestedBonus_Display(name,data)
    if(not data) then return; end
    local bonus,maxBonus,fc,lvl,flag = data.bonus, data.maxXP*1.5, '', '', '';
    if(data.time<1e9) then
      print(name..FCr.." has old time data; log to update.");
      return;
    end
    if(not bonus) then bonus = 0; end
    local speed = data.rest and 1 or 4;
    if(data.time<time()) then
      bonus = bonus+floor((time()-data.time)*maxBonus/864000/speed/2)*2;
      if(bonus>maxBonus) then bonus = maxBonus; end
    end
    local pct = floor(bonus/maxBonus*RestedBonus_Percent);
    if(data.lvlXP and bonus>=data.lvlXP) then flag = '+'; end
    if(data.lvl) then
      if(data.lvl==0) then return; end
      if(data.lvlXP) then
        lvl = data.lvl+floor(10-10*data.lvlXP/data.maxXP)/10;
        lvl = format(" (%1.1f%s)",lvl,flag);
      else lvl = format(" (%d%s)",data.lvl,flag); end
    end
    msg = format("%s%s is %d%% rested (RB=%d)",name,lvl,pct,bonus);
    if(bonus<maxBonus) then
      secs = floor((1-bonus/maxBonus)*864000*speed);
      if(secs<86400) then fc = FCy;
      elseif(bonus/maxBonus<0.16 and flag=='') then fc = FCg; end
      local duration = SecondsToTime(secs);
      if(data.rest or name~=Player) then
        msg = msg..", fully rested in "..duration;
      else msg = msg..", can camp for "..duration; end
    else fc = FCo; end
    if(data.time>time()) then fc = FCr; end
    print(fc..msg..'.');
end
