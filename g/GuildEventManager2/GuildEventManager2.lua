--[[
  Guild Event Manager by Kiki of European Cho'gall (Alliance)
    Version 2.08
  Home Page : http://christophe.calmejane.free.fr/wow/gem/

  ---
  ChangeLog :
  ----------------
  - 2.08 :
   - April, 11th 2006 :
    - You can now configure channels from the options (but cannot see members from other channels yet)
   - March, 31th 2006 :
    - Updated TOC for 1.10
    - Fixed 'N' text in minimap icon flashing sometimes, while there is no new event
    - Increased date column width, and added date in the tooltip
    - Added a new color code in Admin list : Blue=Connected but not grouped, Green=Connected and grouped
  - 2.07 :
   - March, 16th 2006 :
    - Fixed lua error in New event if you load a template created before Auto-members additionnal code
    - Finally fixed channels init errors. Password protected channels should work too.
   - March, 15th 2006 :
    - Fixed lua error in Admin list popup if not leader
    - You can now force yourself into replacement queue
    - Fixed force titular button not working, if the player was not in replacement queue before
   - March, 13th 2006 :
    - Handling "Force titular" param in Sorting of members
   - March, 10th 2006 :
    - Added possibility to ignore a closed event (new button)
    - Fixed bug in the ignore option (a previously ignored event might reappear)
   - March, 9th 2006 :
    - Added confirmation dialog for Delete Template (New event tab)
    - Fixed wrong reset instance day, around midnight
    - Added possibility to Auto-add members to an event (NOT FINISHED YET !! NO CHECKS !)
    - Saving Auto-members to templates
    - Added possibility to move a member back and forth Replacement queue
    - Added possibility to force a member in titular list
  - 2.06 :
   - March, 7th 2006 :
    - Fixed : some events not removed from the list, when changing channel
    - Auto-purging players that didn't connect since 1 month
    - Fixed players not sending any data when they first log in the channel
    - Added Events Calendar view (not finished yet)
    - Possibility to show instances reset from the calendar view
   - March, 3rd 2006 :
    - Increased EventsList size (2 more items), needed to incoming new EventView

  [ Previous changes in readme.txt file ]

  ---
  Description :
  ----------------
  This AddOn allows you to create/schedule/manage future raid instance directly in-game. Players can register (join) and reserve a room for your instance, or cancel subscription.
  You can setup a maximum players for your event, as well as the min/max per class.
  When a player wants to join and there is no room left for his class, he is put in a *substitute* queue, waiting for someone to cancel his subscription.
  
  The leader of an event does not have to be logged in for a player to subscribe.
  
  This addon has been designed to help guilds to schedule events, and its member to say *I'll be there*, and count the number of players that are ok for an instance.
  It does work for multiple guilds (kind of Alliance of guilds), if you want, or even with your friend list.
  
  All dates are stored in universal time, and displayed in local time, so if someone creates an event in a different timezone than yours, you will see the correct time on your side.
  
  
  ---
  Installation :
  ---------------
  
  1. Extract .zip file to WorldOfWarcraft\Interface\AddOns\
  2. load up WoW check the Addon is enabled ("/gem help" should print infos)
  3. Bind a key to GuildEventManager or type "/gem toggle"
  4. in the options TAB set the channel to whichever you are going to use
  
  
  ---
  Notes :
  --------
  
  COLOR CODE :
   - Events List in Events Tab, Where column :
     - White = Old event (already displayed)
     - Green = New event (never seen)
   - Events List in Events Tab, Leader column :
     - White = Leader not connected
     - Green = Leader connected
   - Events List in Events Tab, Subscribers column :
     - White = Not subscribed
     - Purple = Level of your selected character does not match event's level range
     - DarkGrey = Subscription sent, but not ACKed yet
     - Bleu = Subscription ACKed but you are in Substitute queue
     - Green = Subscription ACKed and you are in Titular list
     - Yellow = Subscription ACKed and you are in Replacement list
     - DarkRed = You have been kicked from event (and thus unsubscribed). You can re-subscribe
     - LightRed = You have been banned from event (and thus unsubscribed). You cannot re-subscribe until you are unbanned
   - Admin List in Events Tab, Place column :
     - White = Normal subscriber
     - Green = Leader or Assistant
   - Admin List in Events Tab, Name column :
     - White = Player not connected (or external)
     - Blue = Player connected but not grouped
     - Green = Player connected and grouped
   - Members list, Guild column :
     - Green = Guild leader
     - Blue = Guild officer
     - White = Guild member
  
  TODO :
   - auto kick/ban peoples
   - REVOIR le code de groupage (detection more raid/group), et virer le warning si je suis deja dans un grp
    - Faire une verif qd on set un alias, qu'il n'existe pas deja pour un autre canal GEM
    - Pouvoir changer de reroll dans un EditEvent
    - Store ServerTimeStamp and os.time() at each startup, for each Realm
    - WDS : Pour chaque event, envoyer os.time() et ServerTimeStamp
    - Add a sorting plugin : By assigning points to someone (DKP like)
    - Add a sorting plugin : By auto adding ppl on a list for the event (only when already created, by using AddExternal)
    - Find a way to *block* people we don't want to subscribe (auto ban your ignore list, for example)
    - Add an auto-banned list (in Create new Events tab ?)
    - Option to limit event creation to officers (not possible but see CanViewOfficerNote() IsGuildLeader() )
    - Handle event restrictions (guild only) -- Tag event with a bit 'guild only'
    - Possibility to modify the subscription comment
    - GEM_COM_JoinChannel() -> Change DEFAULT_CHAT_FRAME:GetID(), by a value specified in config
    - New parameter for Events : "Can subscribe only when leader is online"
    - Handle guild channel  as GEM channel
    - Add a new type of limit : Healers (priest/druid/paladin/shaman) Dps (rogue/mage/hunter) (v666.0)
  
  TODO GUI:
    - Mettre l'option "Notify channel join/leave" par canal
    - Possibility to remove offline members from the list (right clic on them)
    - Panel transparency
  
  KNOWN BUGS:
   - Impossible de rejoindre un canal si on reco a griffon (max count 100 reached)

CODE TODO :
*--*--*--*
 * To handle multiple channels :
   GUI
   -> GEM_Players.lua : GEMPlayers_GetPlayers() must handle multiple channels (and the GUI too)


  ---
  FAQ :
  --------
  Q : I don't see events of other people, and others don't see mine
  A : Are you sure you are on the same channel (check GEM options) ? Are you sure you don't have joined more than 9 channels (there is a limit of 9 or 10 channels you can join) ? Are you sure your PC's clock is correctly set ?
      If you still don't see events, try "/gem debug 1", it will show a new TAB, look at the debug log (screenshot it) for warnings or event related messages, then contact me.
  
  Q : I see garbage on my channels, like "<GEM-1>01..."
  A : Check if the channel you see garbage is the same than the one in your GEM config. Maybe you have changed the channel with a character, and changed reroll. Leave the garbaged one with a /leave ChanNum. In v2.0, channel will be saved per char, so you will not have this problem anymore.
  
  Q : I just subscribed to an event, but I don't appear in the list, nor the titulars count has changed.
  A : If the leader of the event is not logged, all commands (subscribe, unsubscribe, ...) are stored and broadcasted to every person in the channel (and each time someone logs in). In order to see your subscription in the list (and titulars count increased/decreased), you must wait until the leader logs. When he does, all commands are flushed and he processes them, in the order they were submitted.
      Look at the color codes above, they help you know in which state you are.
  
  Q : All thoses stored commands don't flood the channel when someone (or the leader) logs in ?
  A : No, there is an algorithm that makes people to sent commands at different time when someone joins, and if a known command has just been sent, the sent from your side is canceled. There is also a  maximum of commands that can be sent per second, so you are not (less) flooded.

  Q : I don't like the subscribers sorting modes available. I want something else, custom.
  A : Well, that's where the Sorting plugin system comes in ! Look at the "GEM_sort_stamp.lua" file, there is all you need to make your own plugin (there is no need for the plugin to be installed on each player's computer, only on the leader's one). Simply make a new addon with a .toc file, that depends on GuildEventManager, and you're done. The plugin will be loaded by GEM, and you'll be able to choose your custom sorting in GEM's "Create new Event" tab.
  
  Q : I have a lua error, but I cannot tell you the file/line it occured
  A : Please install (even temporarily) ImprovedErrorFrame (http://www.curse-gaming.com/mod.php?addid=170), and you'll be able to see the full error text

  Q : When I link an item to the GEM channel, it displays the name only.
  A : For links to be sent, you must use the SlashCmd specified in GEM config. If you speak using /# (# being GEM's channel number), it will not work.
  
  Q : I don't see anybody in the Members list, and the list populates very slowly. Also, I always see "N/A" for people's location.
  A : This is to greatly reduce traffic in the channel. Each player sends his personal informations ONLY when he changes of zone, NOT when someone logs in (otherwise every single player will have to send his current info upon each login, which causes too much traffic).
      Because of this, the first time you come to a channel, we don't see anybody, you must wait for each player to move to another zone. When this happens, the player is saved and stored in your variables, so the next time, only it's current location will show as 'N/A' until he moves.
  
  Q : I'm using SlashCmd and alias, and when I try to send a message, I don't see anything in my chatframe, nor I see messages from others.
  A : Some addons are not hooking chatframe like they should.
      - If you have GuildAds : Get the latest version, it has been fixed
      - If you have flagRSP : Get the latest version, it has been fixed
      - If you have Guilded : Why do you need this one anymore ? oO
      
  Q : I don't like the way Dates are displayed. How can I change that ?
  A : Change the option "Displayed dates format" ingame, in the GEM Configuration tab with the value you want.
      You can find help on the parameters here : http://www.opengroup.org/onlinepubs/007908799/xsh/strftime.html

  Q : I don't understand the 'time offset' option
  A : When someone creates an event, the time/date for the event is (by default, if you don't change the offset in GEM config) relative to it's computer's clock (which uses international time).
      Example :
       My computer's clock is set at GMT+1, I play on a server where time is set to GMT.
       I create an event for tonight 8pm, GEM will flag (create) the event for 8pm GMT+1 (and store it using universal time value), not 8pm GMT (so not the server time).
       BUT the date will be displayed for eveybody, using their local time. For someone playing on a computer with clock set at GMT+2, the event will show for him at 9pm.
       The offset value in GEM config, is for people who want events to be shown using server time (or any other time offset), not local time.
       They can set an offset from local time to match server time. If you don't set anything, it will display/create events based on your computer time (local).

  Q : When are events removed from the list ?
  A : Events are auto removed (not closed, removed completly from GEM) 1 hour after event's date for non-leader players, and 10 hours after event's date for leader.
      Using the previous example, the event will disapear for eveybody at 9pm GMT+1 (so for the guy playing at GMT+2 time, it will disapear when his computer's clock will reachs 10pm).

]]


--------------- Default values (you can set to nil, or any string) ---------------
GEM_DEFAULT_CHANNEL = "GEMChannelDefault";
GEM_DEFAULT_PASSWORD = nil;
GEM_DEFAULT_ALIAS = nil;
GEM_DEFAULT_SLASH = nil;

--------------- Saved variables ---------------
GEM_Events = {};
GEM_Templates = {};
GEM_Players = {};

--------------- Shared variables ---------------
GEM_MAJOR = "2";
GEM_MINOR = "08";
GEM_VERSION = GEM_MAJOR.."."..GEM_MINOR;
GEM_PlayerName = nil;
GEM_Realm = nil;
GEM_DefaultSendChannel = nil;
GEM_NewMinorVersion = false;
GEM_OldVersion = false;
GEM_ConnectedPlayers = {};
GEM_YouAreDrunk = false;
GEM_ServerOffset = 666;

--------------- Local variables ---------------
local _GEM_NeedInit = true;
local _GEM_MaxJoinRetry = 10;
local _GEM_WrongChanNotified = {};

--------------- Internal functions ---------------

local function _GEM_Commands(command)
  local i,j, cmd, param = string.find(command, "^([^ ]+) (.+)$");
  if(not cmd) then cmd = command; end
  if(not cmd) then cmd = ""; end
  if(not param) then param = ""; end

  if((cmd == "") or (cmd == "help"))
  then
    GEM_ChatPrint(GEM_TEXT_USAGE);
    GEM_CMD_Help();
  else
    if(not GEM_CMD_Command(cmd,param))
    then
    GEM_ChatPrint(GEM_CHAT_CMD_UNKNOWN);
    end
  end
end

local function _GEM_CheckForJoined(channel)
  if(GEM_COM_Channels[channel].id ~= 0)
  then
    return;
  end
  -- Have we joined the channel ?
  GEM_COM_Channels[channel].id = GetChannelName(channel);
  
  if(GEM_COM_Channels[channel].id == 0)
  then
    if(GEM_COM_Channels[channel].retries > (_GEM_MaxJoinRetry/2))
    then
      GEM_ChatDebug(GEM_DEBUG_CHANNEL,"_GEM_CheckForJoined : Not in channel '"..channel.."' after "..GEM_COM_Channels[channel].retries.." retries, restarting sequence");
      GEM_InitChannels(false);
      -- Don't return, we need to reschedule
    elseif(GEM_COM_Channels[channel].retries > _GEM_MaxJoinRetry)
    then
      GEM_ChatDebug(GEM_DEBUG_CHANNEL,"_GEM_CheckForJoined : Not in channel '"..channel.."' after "..GEM_COM_Channels[channel].retries.." retries, aborting (channel password protected ?)");
      GEM_COM_Channels[channel].retries = 0;
      return;
    end
    GEM_ChatDebug(GEM_DEBUG_CHANNEL,"_GEM_CheckForJoined : Not joined yet, reschedule in 0.25 sec");
    GEM_COM_Channels[channel].retries = GEM_COM_Channels[channel].retries + 1;
    GEMSystem_Schedule(0.25,_GEM_CheckForJoined,channel); -- Re schedule in 250 msec
  else
    GEM_COM_Channels[channel].retries = 0;
    ListChannelByName(channel);
    GEM_ChatDebug(GEM_DEBUG_CHANNEL,"_GEM_CheckForJoined : Ok joined channel, time to bcast !");
    GEM_COM_AliasChannel(channel,GEM_COM_Channels[channel].alias,GEM_COM_Channels[channel].slash);
    if(GEM_COM_Channels[channel].already_bcast == nil)
    then
      GEM_QUE_BuildBroadcastQueues(channel,GEM_PlayerName);
      GEM_COM_PlayerInfosSingle(channel);
      GEM_COM_Channels[channel].already_bcast = 1;
    end
  end
end

local function _GEM_CheckPlayerLeft(channel,pl_name)
  if(GEM_ConnectedPlayers[channel] == nil)
  then
    GEM_ConnectedPlayers[channel] = {};
  end
  if(GEM_ConnectedPlayers[channel][pl_name] ~= nil)
  then
    local chaninfos = GEM_COM_Channels[channel];
    if(chaninfos and chaninfos.notify)
    then
      local alias = channel;
      if(chaninfos.alias and chaninfos.alias ~= "")
      then
        alias = chaninfos.alias;
      end
      GEM_ChatMsg(alias.." : "..string.format(GEM_TEXT_PLAYER_LEFT,pl_name));
    end
    if(GEM_Players[GEM_Realm] and GEM_Players[GEM_Realm][channel] and GEM_Players[GEM_Realm][channel][pl_name])
    then
      GEM_Players[GEM_Realm][channel][pl_name].lastleave = time();
    end
    GEM_ChatDebug(GEM_DEBUG_CHANNEL,"_GEM_CheckPlayerLeft : Player "..pl_name.." left channel "..channel);
    GEM_ConnectedPlayers[channel][pl_name] = nil;
    GEMList_Notify(GEM_NOTIFY_MY_SUBSCRIPTION,"");
  end
end

local function _GEM_StartupInitVars()
  local playerName = UnitName("player");
  if((playerName) and (playerName ~= UNKNOWNOBJECT) and (playerName ~= UKNOWNBEING))
  then
    GEM_PlayerName = playerName;
    GEM_Realm = GetCVar("realmName");
    _GEM_NeedInit = false;
    if(GEM_Events.realms == nil) -- First time module init (ever)
    then
      GEM_Events = {}; -- Reset everything
      GEM_Events.next_event_id = 0;
      GEM_Events.realms = {};
      GEM_Events.MinimapRadiusOffset = 77;
      GEM_Events.MinimapArcOffset = 296;
      GEM_Events.MinimapTexture = "Spell_Nature_TimeStop";
      GEM_Events.DateFormat = GEM_DATE_FORMAT;
      --GEM_Events.debug = 1;
      GEM_Events.debug = nil;
    end
    GEM_Events.my_bcast_offset = 2 + math.mod(time(),85); -- Change value each login
    if(GEM_Events.realms[GEM_Realm] == nil) -- First time in this realm
    then
      GEM_Events.realms[GEM_Realm] = {};
      GEM_Events.realms[GEM_Realm].events = {};
      GEM_Events.realms[GEM_Realm].commands = {};
      GEM_Events.realms[GEM_Realm].subscribed = {};
      GEM_Events.realms[GEM_Realm].my_names = {};
      GEM_Events.realms[GEM_Realm].ChannelPassword = nil;
      GEM_Events.realms[GEM_Realm].kicked = {};
      GEM_Events.realms[GEM_Realm].banned = {};
      GEM_Events.realms[GEM_Realm].forward = {};
    end
    if(GEM_Events.realms[GEM_Realm].my_closed_events == nil) -- v2.02 addition
    then
      GEM_Events.realms[GEM_Realm].my_closed_events = {};
    end
    if(GEM_Events.realms[GEM_Realm].ignore == nil) -- v2.01 addition
    then
      GEM_Events.realms[GEM_Realm].ignore = {};
      GEM_Events.realms[GEM_Realm].assistant = {};
    end
    if(GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName] == nil) -- First time with this toon in this realm
    then
      GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName] = {};
      local _,class = UnitClass("player");
      GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].class = class;
    end
    local playerGuild = GetGuildInfo("player"); -- Thanks to blizz 1.7 changes, this might not been initialized here
    GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].level = UnitLevel("player");
    GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].guild = playerGuild;
    GEMOptions_LoadChannelsConfig(GEM_PlayerName); -- Load channels config
    GEM_InitChannels(true); -- And init channels
    GEM_COM_InitRoutines();
    GEMMinimapButton_Update();
    GEM_DBG_SetDebugMode(GEM_Events.debug,false);
  end
end


--------------- From XML functions ---------------

function GEM_OnEvent()
  if(event == "VARIABLES_LOADED")
  then
    if(_GEM_NeedInit)
    then
      _GEM_StartupInitVars();
    end
    return;
  end

  local channel = nil;
  if(arg9)
  then
    channel = strlower(arg9);
  end

  -- Check events
  if(event == "CHAT_MSG_CHANNEL" and channel and GEM_Realm)
  then
    if(GEM_IsChannelInList(channel)) -- Channel joined, process
    then
      if(strsub(arg1, strlen(arg1)-7) == " ...hic!") then
        arg1 = strsub(arg1, 1, strlen(arg1)-8);
      end
      if(string.find(arg1,"^<GEM")) -- Process only GEM messages
      then
        GEM_COM_ParseChannelMessage(channel,arg2,arg1);
      elseif(UnitName("player") ~= arg2 and GEMOptions_MustBip(arg1))
      then
        GEM_ChatDebug(GEM_DEBUG_CHANNEL,"Found your name in the channel, COIN !");
        PlaySoundFile("Interface\\AddOns\\GuildEventManager2\\coin.wav");
      end
    --[[else
      if(string.find(arg1,"^<GEM")) -- Got a GEM message on another channel ?
      then
        if(_GEM_WrongChanNotified[channel] == nil)
        then
          GEM_ChatPrint("Warning : Found a GEM command From "..tostring(arg2).." on Channel '"..channel.."' but it is not the channel set in GEM configuration. You can leave this chan, but if you have this message by mistake, please inform Kiki");
          _GEM_WrongChanNotified[channel] = 1;
        end
      end]]
    end
  elseif(event == "CHAT_MSG_CHANNEL_NOTICE" and channel and GEM_Realm)
  then
    if(arg1 and GEM_COM_Channels and GEM_COM_Channels[channel])
    then
      if(arg1 == "YOU_LEFT" and GEM_COM_Channels[channel].id ~= 0)
      then
        GEM_COM_Channels[channel].id = 0;
        GEM_ChatDebug(GEM_DEBUG_CHANNEL,"Leaving by hand "..channel);
      elseif(arg1 == "YOU_JOINED" and GEM_COM_Channels[channel].id == 0 and not GEM_COM_Channels[channel].already_bcast)
      then
        GEM_ChatDebug(GEM_DEBUG_CHANNEL,"Re-joining by hand "..channel);
        _GEM_CheckForJoined(channel);
      elseif(arg1 == "WRONG_PASSWORD")
      then
        if(GEM_COM_Channels[channel].password and GEM_COM_Channels[channel].password ~= "") -- Had a password
        then
          if(GEM_COM_Channels[channel].retries and GEM_COM_Channels[channel].retries > 2) -- More than 2 retries, try without a password
          then
            GEM_ChatPrint("You set a password ("..GEM_COM_Channels[channel].password..") for channel '"..channel.."' but it is not correct, retrying without password...");
            GEM_ChatDebug(GEM_DEBUG_CHANNEL,"You set a password ("..GEM_COM_Channels[channel].password..") for channel '"..channel.."' but it is not correct, retrying without password...");
            GEM_COM_Channels[channel].password = "";
            GEMSystem_Schedule(1,GEM_InitChannels,false); -- Schedule retry in 1sec
          end
        else -- No password -> Print error
          GEM_COM_Channels[channel].retries = _GEM_MaxJoinRetry + 1;
          GEM_ChatPrint("Incorrect password for channel '"..channel.."'");
        end
      end
    end
  elseif(event == "UNIT_NAME_UPDATE")
  then
    if((arg1) and (arg1 == "player"))
    then
      GEM_CheckPlayerGuild();
    end
  elseif(event == "CHAT_MSG_CHANNEL_JOIN" and channel)
  then
    if(GEM_IsChannelInList(channel))
    then
      GEM_CheckPlayerJoined(channel,arg2,true);
      GEM_QUE_BuildBroadcastQueues(channel,arg2);
    end
  elseif(event == "CHAT_MSG_CHANNEL_LEAVE" and channel)
  then
    if(GEM_IsChannelInList(channel))
    then
      _GEM_CheckPlayerLeft(channel,arg2);
    end
  elseif(event == "CHAT_MSG_CHANNEL_LIST" and channel)
  then
    if(GEM_IsChannelJoined(channel))
    then
      local users = {};
        for value in string.gfind(arg1,"[^,]+") do
        table.insert(users, value);
      end
      for k,v in users do 
        k2 = string.gsub(v, "%s*%@*%**([^%s]+)", "%1");
        GEM_CheckPlayerJoined(channel,k2,false);
      end
      local count = 0;
      for n in GEM_ConnectedPlayers[channel]
      do
        count = count + 1;
        if(count >=2) then break; end
      end
      if(count == 1 and GEM_COM_Channels[channel].password and GEM_COM_Channels[channel].password ~= "") -- I'm alone, and there is a password for this channel
      then
        SetChannelPassword(channel,GEM_COM_Channels[channel].password);
        GEM_ChatDebug(GEM_DEBUG_CHANNEL,"I'm alone in channel '"..channel.."' and I must set a password... setting it to "..GEM_COM_Channels[channel].password);
      end
    end
  elseif(event == "PARTY_MEMBERS_CHANGED")
  then
    if(GetNumPartyMembers() == 0)
    then
      GEMList_CurrentGroupIDMustReset = true;
    else
      GEMList_CurrentGroupIDMustReset = false;
    end
    if(GEMList_CurrentGroupID ~= nil and GEMList_CurrentGroupIDMustReset ~= true)
    then
      if(GEMList_MustConvertToRaid == true)
      then
        ConvertToRaid();
        GEMList_CurrentGroupIsRaid = true;
        GEM_ChatDebug(GEM_DEBUG_GLOBAL,"Converted to raid !");
        GEMList_MustConvertToRaid = false;
      end
      if(GEMList_CurrentGroupIsRaid == false and GEM_Events.realms[GEM_Realm].events[GEMList_CurrentGroupID] and GEM_Events.realms[GEM_Realm].events[GEMList_CurrentGroupID].max_count > 5) -- A raid
      then
        GEMList_MustConvertToRaid = true;
        GEM_ChatDebug(GEM_DEBUG_GLOBAL,"Must convert to raid !");
      end
    end
  elseif(event == "ZONE_CHANGED_NEW_AREA")
  then
    GEM_COM_PlayerInfos(); -- Send an update of my infos
    GEM_NotifyGUI(GEM_NOTIFY_PLAYER_INFOS);

    -- Check channel IDs
    for name,chantab in GEM_COM_Channels
    do
      local id = GetChannelName(name);
      if(GEM_COM_Channels[name].id ~= 0 and GEM_COM_Channels[name].id ~= id) -- If channel ID has changed
      then
        --GEM_ChatWarning("ZONE_CHANGED_NEW_AREA : ChannelID for '"..name.."' has changed from "..GEM_COM_Channels[name].id.." to "..id);
        GEM_COM_Channels[name].id = id;
      end
    end
  elseif(event == "CHAT_MSG_SYSTEM")
  then
    for i=1,GEM_DRUNK_MESSAGES_COUNT
    do
      if(arg1 == GEM_DRUNK_MESSAGES[i])
      then
        GEM_YouAreDrunk = true;
        break;
      end
    end
    if(arg1 == GEM_DRUNK_NORMAL)
    then
      GEM_YouAreDrunk = false;
    end
  end
end

function GEM_OnLoad()
  -- Print init message
  GEM_ChatPrint("Version "..GEM_VERSION.." "..GEM_CHAT_MISC_LOADED);

  -- Register events
  this:RegisterEvent("VARIABLES_LOADED");
  this:RegisterEvent("ADDON_LOADED");
  this:RegisterEvent("CHAT_MSG_CHANNEL");
  this:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
  this:RegisterEvent("CHAT_MSG_CHANNEL_JOIN");
  this:RegisterEvent("CHAT_MSG_CHANNEL_LEAVE");
  this:RegisterEvent("CHAT_MSG_CHANNEL_LIST");
  this:RegisterEvent("CHAT_MSG_SYSTEM");
  this:RegisterEvent("UNIT_NAME_UPDATE");
  this:RegisterEvent("PARTY_MEMBERS_CHANGED");
  this:RegisterEvent("ZONE_CHANGED_NEW_AREA");

  -- Initialize Slash commands
  SLASH_GEM1 = "/gem";
  SlashCmdList["GEM"] = function(msg)
    _GEM_Commands(msg);
  end
  
  tinsert(UISpecialFrames, "GEMMainFrame");
  tinsert(UISpecialFrames, "GEMCalendarFrame");
  tinsert(UISpecialFrames, "GEMExternalFrame");
  tinsert(UISpecialFrames, "GEMListBannedFrame");
  tinsert(UISpecialFrames, "GEMNewAutoMembersFrame");
end

--------------- Exported functions ---------------

function GEM_ComputeServerOffset()
  if(GEM_Events.realms[GEM_Realm] and GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName] and GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].ForceHourOffset)
  then
    GEM_ServerOffset = GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].ForceHourOffset;
    return;
  end
  if(GEM_ServerOffset == 666)
  then
    local hour = GetGameTime();
    if(hour == nil or tonumber(hour) == -1)
    then
      return;
    end
    local today = date("*t");
    local offset = hour - today.hour;
  
    if(math.abs(offset) > 12)
    then
      if(offset > 0)
      then
        offset = offset - 24; 
      else
        offset = offset + 24; 
      end
    end
    GEM_ServerOffset = offset;
  end
end

function GEM_ComputeHourOffset()
  if(GEM_ServerOffset == 666)
  then
    GEM_ComputeServerOffset();
  end
  if(GEM_Events == nil or GEM_Events.realms == nil or GEM_Events.realms[GEM_Realm] == nil or GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].UseServerTime ~= 1 or GEM_ServerOffset == 666)
  then
    return 0;
  end
  return GEM_ServerOffset * 60 * 60;
end

-- Checks if 'name' is one of my rerolls
function GEM_IsMyReroll(name)
  if(GEM_Events.realms[GEM_Realm].my_names[name] ~= nil)
  then
    return true;
  end
  return false;
end

function GEM_IsChannelInList(channel)
  if(GEM_COM_Channels and GEM_COM_Channels[channel])
  then
    --[[if(GEM_COM_Channels[channel].id == 0)
    then
      if(GEM_COM_Channels[channel].already_bcast) -- Channel is in my list, but was left by hand !
      then
        return true;
      end
      GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEM_IsChannelInList : ChannelID for '"..tostring(channel).."' not found, calling InitChannels(false)");
      GEM_InitChannels(false);
    end
    return GEM_COM_Channels[channel].id ~= 0;]]
    return true;
  end
  return false;
end

function GEM_IsChannelInRerollList(pl_name,channel)
  if(GEM_Events.realms[GEM_Realm].my_names[pl_name] and GEM_Events.realms[GEM_Realm].my_names[pl_name].channels)
  then
    for i,chantab in GEM_Events.realms[GEM_Realm].my_names[pl_name].channels
    do
      if(strlower(chantab.name) == channel)
      then
        return true;
      end
    end
  end
  return false;
end

function GEM_IsChannelJoined(channel)
  if(GEM_COM_Channels and GEM_COM_Channels[channel] and GEM_COM_Channels[channel].id ~= 0)
  then
    return true;
  end
  return false;
end

function GEM_CheckEventHasChannel(event)
  if(event and event.channel == nil) -- Never set, set it now
  then
    event.channel = GEM_DefaultSendChannel;
  end
end

function GEM_CheckCommandHasChannel(cmdstab)
  if(cmdstab.channel == nil) -- Never set, set it now
  then
    cmdstab.channel = GEM_DefaultSendChannel;
  end
end

function GEM_CheckPlayerJoined(channel,pl_name,mustprint)
  if(GEM_ConnectedPlayers[channel] == nil)
  then
    GEM_ConnectedPlayers[channel] = {};
  end
  if(GEM_ConnectedPlayers[channel][pl_name] == nil)
  then
    local chaninfos = GEM_COM_Channels[channel];
    if(mustprint and chaninfos and chaninfos.notify)
    then
      local alias = channel;
      if(chaninfos.alias and chaninfos.alias ~= "")
      then
        alias = chaninfos.alias;
      end
      GEM_ChatMsg(alias.." : "..string.format(GEM_TEXT_PLAYER_JOINED,pl_name));
    end
    GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEM_CheckPlayerJoined : Player "..pl_name.." joined "..channel);
    if(GEM_Players[GEM_Realm] and GEM_Players[GEM_Realm][channel] and GEM_Players[GEM_Realm][channel][pl_name])
    then
      GEM_Players[GEM_Realm][channel][pl_name].location = GEM_NA_FORMAT; -- Reset location
    end
    GEM_ConnectedPlayers[channel][pl_name] = 1;
    GEM_COM_LastJoinerTime = time();
    GEMList_Notify(GEM_NOTIFY_MY_SUBSCRIPTION,"");
  end
end

function GEM_IsPlayerConnected(channel,pl_name)
  if(GEM_ConnectedPlayers[channel] and GEM_ConnectedPlayers[channel][pl_name] ~= nil)
  then
    return true;
  end
  return false;
end

function GEM_CheckPlayerGuild()
  if(GEM_Realm == nil)
  then
    GEM_ChatWarning("GEM_CheckPlayerGuild : GEM_Realm is nil. Aborting");
    return;
  end

  local playerName = UnitName("player");
  if((playerName) and (playerName ~= UNKNOWNOBJECT) and (playerName ~= UKNOWNBEING))
  then
    local playerGuild = GetGuildInfo("player");
    GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].level = UnitLevel("player");
    GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].guild = playerGuild;
    GEM_ChatDebug(GEM_DEBUG_GLOBAL,"GEM_CheckPlayerGuild : Player "..playerName.." level "..GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].level.." from guild "..tostring(GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].guild));
  end
end

local _GEM_ScheduledChannelsInitDone = false;
local _GEM_InitChannelsCount = 0;
function GEM_InitChannels(schedule)
  GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEM_InitChannels : Starting channel Initialization (reschedule="..tostring(schedule).." count=".._GEM_InitChannelsCount..")");
  _GEM_InitChannelsCount = _GEM_InitChannelsCount + 1;
  
  if(_GEM_InitChannelsCount == 1000)
  then
    GEM_ChatWarning("GEM_InitChannels : _GEM_InitChannelsCount reached 1000, you might be in flight");
  end

  if(schedule and _GEM_ScheduledChannelsInitDone)
  then
    GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEM_InitChannels : Returning, schedule="..tostring(schedule).." and _GEM_ScheduledChannelsInitDone="..tostring(_GEM_ScheduledChannelsInitDone));
    return;
  end

  -- Check for general channels
  local firstChannelNumber = GetChannelList();
  if(firstChannelNumber == nil)
  then
    if(schedule)
    then
      GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEM_InitChannels : Main channels not init yet, reschedule init in 2 sec");
      GEMSystem_Schedule(2,GEM_InitChannels,schedule); -- Re schedule in 2 sec
    else
      GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEM_InitChannels : Main channels not init yet, but not rescheduling.");
    end
    return;
  end

  _GEM_InitChannelsCount = 0;
  GEM_EVT_CheckExpiredEvents();
  GEM_CMD_CheckExpiredCommands();

  -- Join our channels
  for name,chantab in GEM_COM_Channels
  do
    GEMPlayers_CheckExpiredPlayers(name);
    if(chantab.id == 0) -- If this channel is not init
    then
      GEM_COM_JoinChannel(name,chantab.password);
      -- Wait for our channel joined
      GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEM_InitChannels : Join request sent, prepare _GEM_CheckForJoined schedule ? : "..tostring(chantab.retries));
      if(chantab.retries == 0) -- Not already in a schedule check
      then
        GEMSystem_Schedule(3,_GEM_CheckForJoined,name); -- Schedule in 3 sec
      end
    end
  end
  if(schedule)
  then
    _GEM_ScheduledChannelsInitDone = true;
  end
end

