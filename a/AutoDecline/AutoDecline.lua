-- *:***************************************************************
-- AutoDecline
-- Automatically decline guild/party/duel invites

versionInfo = "1.3.1600"

-- ------------------------------------------------
-- Revisions

-- v1.3.1600 ** start 08-14-05
--   -Added functionality to always allow invites from your guild
--   -Moved text from configuration screen into the localization.lua file
--   -Made a change to the options screen to better indicate that checking party/guild/duel/charter meant that those types of requests would be declined
--   -Added new option to use the same settings for all characters
--   -Fixed a bug where not including on or off for an option was supposed to toggle that option, but it was not.
--   -Added functionality to perform a list of command line actions when doing a decline
--   -Lenghened last whisper history to include the last 5 names
--   -Changed party list commands
--   -Added new command to add the last player to send a party invite to the allowed list

-- v1.2.1600 ** 07/14/05
--   -Updated interface number to 1600 in .toc file.
--   -Added functionality to always allow invites from names in the friends list
--   -Added new checkbox to settings window to turn allowing invites from friends on and off
--   -Added new toggle command line option partyfriends {on|off}
--   -Added functionality to always allow invites from last player to send a whisper
--   -Added new checkbox to settings window to turn allowing invites from last whisper on and off
--   -Added new toggle command line option partywhisper {on|off}
--   -Removed DEFAULTS button from settings screen

-- v1.1.1300 ** 03/30/05 (not released)
--   -Added functionality to always allow invites from a specified list of names
--   -Added command line commands partyadd, partyremove, and partylist.

-- v1.0.1300 ** 03/23/05
--   -Updated interface number to 1300 in .toc file.
--   -Changed version numbering to include interface number

-- v1.0 ** 03/17/2005
--   -Initial Release

-- ------------------------------------------------
-- Commands
--    party/guild/duel/charter/partyfriends/partywhisper on/off - turn on or off
--    status - show status
--    /ad, /autod, or /autodecline to bring up options window

--    partyplayer add - add a name to always allow party invites list
--    partyplayer remove - remove a name from always allow party invites list
--    partyplayer list - list names to always allow party invites from
--    partyguild add - add a guild name to always allow party invites list
--    partyguild remove - remove a guild name from always allow party invites list
--    partyguild list - list guild names to always allow party invites from

-- ------------------------------------------------
-- Features in Beta
--    new party list command - clear
--    changed partyadd, partyremove, partylist to partyplayer {add|remove|list|clear}
--    new command partyguild {add|remove|list|clear}
--    new functionality - allow party invites from a specified list of guilds
--
-- ------------------------------------------------
-- Features to add at a future date:
--    New command /ad addlastinvite to add the last player who sent an invite to the allowed list.
--    GUI list of names to always allow invites from (way low on list of things to do)

-- *:***************************************************************

-- Initialize local variables
playerName = nil
playerID = nil
localPlayerID = nil
realmID = nil
showAlert = true
AutoDeclineFriends = {}
whisperNames = {}
whisperLimit = 5
debugMode = nil
optionsFrame = nil
lastInvite = nil
cancelFriendList = nil
variablesLoaded = nil
dataLoaded = nil
adCheckingGuild = nil
adLoopStop = nil

-- *:***************************************************************
-- *: AutoDecline_OnLoad
-- *: Executes when the OnLoad event occurs
-- *:***************************************************************
function AutoDecline_OnLoad()
-- *: Moved these to the AutoDecline.toc file
--   RegisterForSave("AutoDeclineConfig")
--   RegisterForSave("AutoDeclinePartyAllow")
--   RegisterForSave("AutoDeclinePartyGuildAllow")
--   RegisterForSave("AutoDeclineActions")
--   RegisterForSave("persistentDebug")

   this:RegisterEvent("VARIABLES_LOADED")
   this:RegisterEvent("GUILD_INVITE_REQUEST")
   this:RegisterEvent("PARTY_INVITE_REQUEST")
   this:RegisterEvent("DUEL_REQUESTED")
   this:RegisterEvent("PETITION_SHOW")
   this:RegisterEvent("PLAYER_ENTERING_WORLD")
   this:RegisterEvent("UNIT_NAME_UPDATE")
   this:RegisterEvent("FRIENDLIST_UPDATE")
   this:RegisterEvent("CHAT_MSG_WHISPER")
   this:RegisterEvent("FRIENDLIST_SHOW")
   this:RegisterEvent("WHO_LIST_UPDATE")
end

-- *:***************************************************************
function AutoDecline_LoadPlayerInfo()
  if not playerID then
    local tempName = UnitName("player")
    AutoDecline_Debug("Initializing playerID to " .. FormatOutput(tempName) )
    if tempName and (tempName ~= "Unknown Entity") then
      playerName = tempName
    end
  end
  if (variablesLoaded) and (not dataLoaded) and playerName then
    AutoDecline_LoadData();
	end
end

-- *:***************************************************************
function AutoDecline_OnEvent(event)
--   AutoDecline_Debug(format("%s firing", event) )
   if (event == "VARIABLES_LOADED") then
     AutoDecline_Debug(format("%s firing", event) )
     variablesLoaded = true
     AutoDecline_Init()
   end

   if (event == "PLAYER_ENTERING_WORLD") or (event == "VARIABLES_LOADED") or (event == "UNIT_NAME_UPDATE") then
     AutoDecline_Debug(format("%s firing", event) )
     AutoDecline_LoadPlayerInfo()
   end

   if dataLoaded then

   if (event == "GUILD_INVITE_REQUEST") then
     AutoDecline_Debug(format("%s firing", event) )
     AutoDecline_Guild(arg1, arg2)
   end

   if (event == "PARTY_INVITE_REQUEST") then
     AutoDecline_Debug(format("%s firing", event) )
     AutoDecline_Party(arg1)
   end

   if (event == "PETITION_SHOW") then
     AutoDecline_Debug(format("%s firing", event) )
     AutoDecline_Charter()
   end

   if (event == "DUEL_REQUESTED") then
     AutoDecline_Debug(format("%s firing", event) )
     AutoDecline_Duel(arg1)
   end

   if (event == "FRIENDLIST_UPDATE" ) then
--     AutoDecline_Debug(format("%s firing", event) )
     AutoDecline_LoadFriendsList()
   end

   if (event == "CHAT_MSG_WHISPER" ) then
--     AutoDecline_Debug(format("%s firing", event) )
     AutoDecline_SetLastWhisper(arg2)
   end

   if (event == "FRIENDLIST_SHOW") then
     AutoDecline_Debug(format("%s firing", event) )
      AutoDecline_Debug("cancelFriendList = " .. FormatOutput(cancelFriendList))
      if cancelFriendList then
        AutoDecline_HideWindow("FriendsFrame")
        cancelFriendList = nil
      end
   end

   if (event == "WHO_LIST_UPDATE") then
--    adCheckingGuild
--     AutoDecline_Debug(format("%s firing", event) )
     AutoDecline_Debug("WHO_LIST_UPDATE fired")
   end

   end
end

-- *:***************************************************************
function AutoDecline_Init()
  AutoDecline_Debug("AutoDecline_Init() firing")

  SlashCmdList["AUTOD"] = AutoDecline_Commands
  SLASH_AUTOD1 = "/autodecline"
  SLASH_AUTOD2 = "/autod"
  SLASH_AUTOD3 = "/ad"
end

-- *:***************************************************************
function AutoDecline_LoadData()
 AutoDecline_Debug("AutoDecline_LoadData() firing")
 AutoDecline_Debug("variablesLoaded = " .. FormatOutput(variablesLoaded) )

-- if (playerName ~= nil and playerName ~= "Unknown Entity") and variablesLoaded then
if (type(playerName) == "string" and playerName ~= "Unknown Entity") and variablesLoaded then
  dataLoaded = true
  realmID = GetCVar("realmName")
  playerID = playerName .. "@" .. realmID
  localPlayerID = playerID

  AutoDecline_Debug("Setting playerID to " .. playerID )
  AutoDecline_LoadFriendsList()

  debugMode = AUTODECLINE_DEBUG
  optionsFrame = getglobal("ADOptionsFrame")

  -- Initialize configuration
  -- If this has been populated before, then it was loaded in the OnEvent
  -- subroutine.  Otherwise, we need to initialize it.

  if (not AutoDeclineConfig) then
    AutoDecline_Debug("Initializing AutoDeclineConfig")
    AutoDeclineConfig = {}
  end

  if AutoDeclineConfig["allChars"] then
     playerID = "allChars"
--     playerID = AutoDeclineConfig["allChars"]
--     AutoDecline_Debug( "AutoDeclineConfig['allChars'] = " .. FormatOutput(AutoDeclineConfig["allChars"]) )
--     AutoDecline_Debug( "playerID = " .. FormatOutput(playerID) )
  end

  if (not AutoDeclineConfig[playerID]) then
    AutoDecline_Debug(format("Initializing AutoDeclineConfig[%s]",playerID))
    AutoDeclineConfig[playerID] = {}
  end

  if AutoDeclineConfig["allChars"] then
     AutoDeclineConfig[localPlayerID] = AutoDeclineConfig[playerID]
  end

  if (not AutoDeclinePartyAllow) then
    AutoDecline_Debug("Initializing AutoDeclinePartyAllow")
    AutoDeclinePartyAllow = {}
  end
  if (not AutoDeclinePartyAllow[realmID]) then
    AutoDecline_Debug(format("Initializing AutoDeclinePartyAllow[%s]",realmID))
    AutoDeclinePartyAllow[realmID] = {}
  end

  if (not AutoDeclinePartyGuildAllow) then
    AutoDecline_Debug("Initializing AutoDeclinePartyGuildAllow")
    AutoDeclinePartyGuildAllow = {}
  end
  if (not AutoDeclinePartyGuildAllow[realmID]) then
    AutoDecline_Debug(format("Initializing AutoDeclinePartyGuildAllow[%s]",realmID))
    AutoDeclinePartyGuildAllow[realmID] = {}
  end

  if (not AutoDeclineActions) then
    AutoDecline_Debug("Initializing AutoDeclineActions")
    AutoDeclineActions = {}
  end

  -- set the defaults
  -- default all to be on (decline)
  if (AutoDeclineConfig[playerID].guildToggle == nil) then
    AutoDeclineConfig[playerID].guildToggle = true
  end
  if (AutoDeclineConfig[playerID].partyToggle == nil) then
    AutoDeclineConfig[playerID].partyToggle = true
  end
  if (AutoDeclineConfig[playerID].duelToggle == nil) then
    AutoDeclineConfig[playerID].duelToggle = true
  end
  if (AutoDeclineConfig[playerID].charterToggle == nil) then
    AutoDeclineConfig[playerID].charterToggle = true
  end

  -- default showAlert to be on (display message when an auto decline occurs)
  if (AutoDeclineConfig[playerID].showAlert == nil) then
    AutoDeclineConfig[playerID].showAlert = true
  end

  -- default partyFriends to true (allow from friends)
  if (AutoDeclineConfig[playerID].partyFriends == nil) then
    AutoDeclineConfig[playerID].partyFriends = true
  end

  -- default partyFriends to true (allow from friends)
  if (AutoDeclineConfig[playerID].partyGuild == nil) then
    AutoDeclineConfig[playerID].partyGuild = true
  end

  -- default partyWhisper to false (don't allow from last whisper)
  if (AutoDeclineConfig[playerID].partyWhisper == nil) then
    AutoDeclineConfig[playerID].partyWhisper = false
  end

  --display AddOn loaded message at startup
  AutoDecline_Display(format(AD_LOAD_MSG, versionInfo))
  AutoDecline_Display(AD_HELP)
  AutoDecline_Display(AD_SYNTAX)
--  AutoDecline_Commands("status")

 end
end

-- *:***************************************************************
function AutoDecline_Unload()
   this:UnregisterEvent("VARIABLES_LOADED")
   this:UnregisterEvent("GUILD_INVITE_REQUEST")
   this:UnregisterEvent("PARTY_INVITE_REQUEST")
   this:UnregisterEvent("DUEL_REQUESTED")
   this:UnregisterEvent("PETITION_SHOW")
   this:UnregisterEvent("PLAYER_ENTERING_WORLD")
   this:UnregisterEvent("UNIT_NAME_UPDATE")
   this:UnregisterEvent("FRIENDLIST_UPDATE")
   this:UnregisterEvent("CHAT_MSG_WHISPER")
   this:UnregisterEvent("FRIENDLIST_SHOW")
   this:UnregisterEvent("WHO_LIST_UPDATE")

   SlashCmdList["AUTOD"] = nil
end

-- *:***************************************************************
function AutoDecline_Commands(commandLine)

  local commandLineProcessed = false
  commandLine = TrimSpace(commandLine)

  actionVerb, argArray, argString = GetCommand(commandLine, ",")

  if (actionVerb == "debug") then
     if string.lower(argArray[1]) == "on" then
       AutoDecline_Display( "Debug mode ON" )
       debugMode = true
     elseif (string.lower(argArray[1]) == "persistent") then
       AUTODECLINE_DEBUG = (not AUTODECLINE_DEBUG)
       if AUTODECLINE_DEBUG then
         AutoDecline_Display( "Persistent debug mode ON"  )
       else
         AutoDecline_Display( "Persistent debug mode OFF"  )
       end
       debugMode = AUTODECLINE_DEBUG
     else
       AutoDecline_Display( "Debug mode OFF" )
       debugMode = false
     end
  else

  if not playerID then
    AutoDecline_LoadPlayerInfo()
  end

  if playerID then
-- *: I can't think of any reason where this would be useful as a command line option,
-- *: so I'm going to leave it as a GUI check box only.
--  elseif actionVerb == "allchars" then

  if (actionVerb == "about") then
    AutoDecline_Display(format(AD_VERSION_INFO, versionInfo))
    AutoDecline_Display(AD_BYLINE)

  elseif (commandLine == "") or (actionVerb == "options") then
    if not optionsFrame:IsVisible() then
        optionsFrame:Show();
    else
        optionsFrame:Hide();
    end

  elseif (actionVerb == "status") or (actionVerb == "s") then
    AutoDecline_ShowStatus()

  elseif (actionVerb == "alert") or (actionVerb == "a") then
    AutoDeclineConfig[playerID].showAlert = AutoDecline_SetStatus(argArray[1], AutoDeclineConfig[playerID].showAlert)
    AutoDecline_Display(iif(AutoDeclineConfig[playerID].showAlert, AD_ALERT_ON, AD_ALERT_OFF))

  elseif (actionVerb == "guild") or (actionVerb == "g") then
    AutoDeclineConfig[playerID].guildToggle = AutoDecline_SetStatus(argArray[1], AutoDeclineConfig[playerID].guildToggle)
    AutoDecline_Display(iif(AutoDeclineConfig[playerID].guildToggle, AD_GUILD_ON, AD_GUILD_OFF))

  elseif (actionVerb == "party") or (actionVerb == "p") then
    AutoDeclineConfig[playerID].partyToggle = AutoDecline_SetStatus(argArray[1], AutoDeclineConfig[playerID].partyToggle)
    AutoDecline_Display(iif(AutoDeclineConfig[playerID].partyToggle, AD_PARTY_ON, AD_PARTY_OFF))

  elseif (actionVerb == "duel") or (actionVerb == "d") then
    AutoDeclineConfig[playerID].duelToggle = AutoDecline_SetStatus(argArray[1], AutoDeclineConfig[playerID].duelToggle)
    AutoDecline_Display(iif(AutoDeclineConfig[playerID].duelToggle, AD_DUEL_ON, AD_DUEL_OFF))

  elseif (actionVerb == "charter") or (actionVerb == "c") then
    AutoDeclineConfig[playerID].charterToggle = AutoDecline_SetStatus(argArray[1], AutoDeclineConfig[playerID].charterToggle)
    AutoDecline_Display(iif(AutoDeclineConfig[playerID].charterToggle, AD_CHARTER_ON, AD_CHARTER_OFF))

  elseif (actionVerb == "partyfriends") or (actionVerb == "pf") then
    AutoDeclineConfig[playerID].partyFriends = AutoDecline_SetStatus(argArray[1], AutoDeclineConfig[playerID].partyFriends)
    AutoDecline_Display(iif(AutoDeclineConfig[playerID].partyFriends, AD_PARTYFRIENDS_ON, AD_PARTYFRIENDS_OFF))

  elseif (actionVerb == "partywhisper") or (actionVerb == "pw") then
    AutoDeclineConfig[playerID].partyWhisper = AutoDecline_SetStatus(argArray[1], AutoDeclineConfig[playerID].partyWhisper)
    AutoDecline_Display(iif(AutoDeclineConfig[playerID].partyWhisper, AD_PARTYWHISPER_ON, AD_PARTYWHISPER_OFF))

  elseif (actionVerb == "addlastinvite") or (actionVerb == "ali") then
    if lastInvite then
      AutoDecline_AddList(AutoDeclinePartyAllow, { lastInvite }, AD_LASTINVITE_ADD)
    else
      AutoDecline_Display( AD_LASTINVITE_NONE )
    end

  elseif (actionVerb == "partyplayer") or (actionVerb == "pp") then
     subVerb, argArray, argString = GetCommand(argString, ",")
     if (subVerb == "add") or (subVerb == "a")then
       AutoDecline_AddList(AutoDeclinePartyAllow, argArray, AD_PARTYPLAYER_ADD)
     elseif (subVerb == "remove") or (subVerb == "r") then
       for argIndex,argValue in argArray do
         if (type(argValue) == "string") and (string.len(argValue) > 0) then
           AutoDeclinePartyAllow[realmID][string.lower(argValue)] = false
           AutoDecline_Display(format(AD_PARTYPLAYER_REMOVE, argValue))
         end
       end
     elseif (subVerb == "list") or (subVerb == "l") then
       AutoDecline_Display(AD_PARTYPLAYER_LIST)
       for personName in AutoDeclinePartyAllow[realmID] do
         if AutoDeclinePartyAllow[realmID][personName] then
           AutoDecline_Display("  " .. personName)
         end
       end
     elseif (subVerb == "clear") or (subVerb == "c") then
       AutoDeclinePartyAllow[realmID] = {}
       AutoDecline_Display(AD_PARTYPLAYER_CLEAR)
     end

  elseif (actionVerb == "partyguild") then
    AutoDeclineConfig[playerID].partyGuild = AutoDecline_SetStatus(argArray[1], AutoDeclineConfig[playerID].partyGuild)
    AutoDecline_Display(iif(AutoDeclineConfig[playerID].partyGuild, AD_PARTYGUILD_ON, AD_PARTYGUILD_OFF))

--[[
-- This doesn't work, the WoW AI currently does not support a good way of
-- getting the guild name of a player given the players name.  This will have
-- to wait until some future time when and if they do support that.
     subVerb, argArray, argString = GetCommand(argString, ",")
     if (subVerb == "add") or (subVerb == "a") then
       AutoDecline_AddList(AutoDeclinePartyGuildAllow, argArray, AD_PARTYGUILD_ADD )
     elseif (subVerb == "remove") or (subVerb == "r") then
       for argIndex,argValue in argArray do
         if (type(argValue) == "string") and (string.len(argValue) > 0) then
           AutoDecline_Debug("argValue = >" .. argValue .. "<")
           AutoDecline_Debug("string.len(argValue) = " .. string.len(argValue))
           AutoDeclinePartyGuildAllow[realmID][string.lower(argValue)] = false
           AutoDecline_Display(format(AD_PARTYGUILD_REMOVE, argValue))
         end
       end
     elseif (subVerb == "list") or (subVerb == "l") then
       AutoDecline_Display(AD_PARTYGUILD_LIST)
       for guildName in AutoDeclinePartyGuildAllow[realmID] do
         if AutoDeclinePartyGuildAllow[realmID][guildName] then
          AutoDecline_Display("  " .. guildName)
         end
       end
     elseif (subVerb == "clear") or (subVerb == "c") then
       AutoDeclinePartyAllow[realmID] = {}
       AutoDecline_Display(AD_PARTYGUILD_CLEAR)
     end
]]--

    elseif (actionVerb == "partyaction") or (actionVerb == "pa") then
       AutoDecline_AddAction("PARTY", argString)
    elseif (actionVerb == "duelaction") or (actionVerb == "da") then
       AutoDecline_AddAction("DUEL", argString)
    elseif (actionVerb == "guildaction") or (actionVerb == "ga") then
       AutoDecline_AddAction("GUILD", argString)
    elseif (actionVerb == "charteraction") or (actionVerb == "ca") then
       AutoDecline_AddAction("CHARTER", argString)

  elseif (actionVerb == "listfriends") and debugMode then
     AutoDecline_Debug("List of friends")
     for personName in AutoDeclineFriends[realmID] do
        AutoDecline_Debug("  " .. personName)
     end

-- *: Manually perform actions for testing
  elseif (actionVerb == "doaction") and debugMode then
     if (argArray[1] == "charter") then
        AutoDecline_DoAction( AutoDeclineActions["CHARTER"], {player=argArray[2],guild=argArray[3]} )
     elseif (argArray[1] == "party") then
        AutoDecline_DoAction( AutoDeclineActions["PARTY"], {player=argArray[2],guild=""} )
     elseif (argArray[1] == "guild") then
        AutoDecline_DoAction( AutoDeclineActions["GUILD"], {player=argArray[2],guild=argArray[3]} )
     elseif (argArray[1] == "duel") then
        AutoDecline_DoAction( AutoDeclineActions["DUEL"], {player=argArray[2],guild=""} )
     else
        AutoDecline_Debug( "Unknown action:  " .. FormatOutput(argArray[1]) )
     end

  elseif (actionVerb == "listwindows") and debugMode then
     AutoDecline_ListWindows()

  elseif (actionVerb == "hidewin") and debugMode then
    AutoDecline_Debug(format("Hiding window %s", argString))
    AutoDecline_HideWindow(argString)

  elseif (actionVerb == "charinfo") and debugMode then
    SetWhoToUI(1)
    SendWho( argArray[1] )
    AutoDecline_Debug("AutoDecline_CheckGuild(" .. argArray[1] .. ") = " .. FormatOutput(AutoDecline_CheckGuild(argArray[1])))

  elseif (actionVerb == "showvars") and debugMode then
    AutoDecline_ShowVars()

  else
    AutoDecline_Display(AD_SYNTAX)
  end
 else
   AutoDecline_Display(AD_NAME_NOT_FOUND)
   AutoDecline_Unload()
 end

 end

end

-- *:***************************************************************
function AutoDecline_Charter()
  if AutoDeclineConfig[playerID].charterToggle then
    local petitionType, title, bodyText, maxSignatures, originatorName, isOriginator = GetPetitionInfo();
    if (petitionType == "charter") then
      ClosePetition()
      AutoDecline_Display(format(AD_PETITION_REQUEST, originatorName, title))
    end
    if AutoDeclineActions["CHARTER"] then
       AutoDecline_DoAction( AutoDeclineActions["CHARTER"], {player=originatorName, guild=title} )
    end
  end
end

-- *:***************************************************************
function AutoDecline_Duel(player)
  if AutoDeclineConfig[playerID].duelToggle then
    CancelDuel()
    AutoDecline_Display(format(AD_DUEL_REQUEST, player))
    AutoDecline_HideWindow("DUEL_REQUESTED")
    if AutoDeclineActions["DUEL"] then
       AutoDecline_DoAction( AutoDeclineActions["DUEL"], {player=player, guild=""} )
    end
  end
end

-- *:***************************************************************
function AutoDecline_Guild(player,guild)
  if AutoDeclineConfig[playerID].guildToggle then
    DeclineGuild()
    AutoDecline_Display(format(AD_GUILD_INVITE, player, guild))
    AutoDecline_HideWindow("GUILD_INVITE")
    if AutoDeclineActions["GUILD"] then
       AutoDecline_DoAction( AutoDeclineActions["GUILD"], {player=player, guild=guild} )
    end
  end
end

-- *:***************************************************************
function AutoDecline_Party(player)
  playerCheck = string.lower(player)
  lastInvite = playerCheck

-- *: This doesn't work, GetGuildInfo doesn't take a player name, it takes a key value.
--  guildName, guildRankName, guildRankIndex = GetGuildInfo(player);

  AutoDecline_Debug( "AutoDeclinePartyAllow[realmID][playerCheck] = " .. FormatOutput(AutoDeclinePartyAllow[realmID][playerCheck]) )
  AutoDecline_Debug( "AutoDeclineConfig[playerID].partyFriends = " .. FormatOutput(AutoDeclineConfig[playerID].partyFriends) )
  AutoDecline_Debug( "AutoDeclineConfig[playerID].partyGuild = " .. FormatOutput(AutoDeclineConfig[playerID].partyGuild) )
  AutoDecline_Debug( "AutoDeclineConfig[playerID].partyWhisper = " .. FormatOutput(AutoDeclineConfig[playerID].partyWhisper) )
  AutoDecline_Debug( "AutoDeclineFriends[realmID][playerCheck] = " .. FormatOutput(AutoDeclineFriends[realmID][playerCheck]) )
  AutoDecline_Debug( "playerCheck = " .. FormatOutput(playerCheck) )
  AutoDecline_Debug( "whisperNames = " .. FormatOutput(whisperNames) )
  AutoDecline_Debug( "AutoDeclineConfig[playerID].partyToggle = " .. FormatOutput(AutoDeclineConfig[playerID].partyToggle) )

  bypassCheck = AutoDeclinePartyAllow[realmID][playerCheck]

  if AutoDeclineConfig[playerID].partyFriends and (not bypassCheck) then
    bypassCheck = bypassCheck or AutoDeclineFriends[realmID][playerCheck]
  end

  if AutoDeclineConfig[playerID].partyWhisper and whisperNames[playerCheck] and (not bypassCheck) then
    bypassCheck = true
  end

  if AutoDeclineConfig[playerID].partyGuild and (not bypassCheck) then
    bypassCheck = bypassCheck or AutoDecline_CheckGuild(playerCheck)
  end
-- bypassCheck or AutoDeclinePartyGuildAllow[realmID][guildName]

  AutoDecline_Debug( "bypassCheck = " .. FormatOutput(bypassCheck) )

  if AutoDeclineConfig[playerID].partyToggle and (not bypassCheck) then
    DeclineGroup();
    AutoDecline_Display(format(AD_PARTY_INVITE, player))
    AutoDecline_HideWindow("PARTY_INVITE")
    if AutoDeclineActions["PARTY"] then
       AutoDecline_DoAction( AutoDeclineActions["PARTY"], {player=player, guild=""} )
    end
  end
end

-- *:***************************************************************
function AutoDecline_Display(displayText)
  if DEFAULT_CHAT_FRAME and displayText then
    DEFAULT_CHAT_FRAME:AddMessage(AD_TAG .. " " ..  displayText)
  end
end

-- *:***************************************************************
function AutoDecline_ShowAlert(alertMessage)
  if AutoDeclineConfig[playerID].showAlert then
     AutoDecline_Display(alertMessage)
  end
end

-- *:***************************************************************
function AutoDecline_ListWindows()
  AutoDecline_Display("Listing open windows:")
  for windowIndex = 1,STATICPOPUP_NUMDIALOGS do
    local currentFrame = getglobal("StaticPopup" .. windowIndex)
    if currentFrame:IsVisible() then
       isVisible = ""
    else
       isVisible = " (invisible)"
    end
    AutoDecline_Display("   " .. FormatOutput(currentFrame.which) .. isVisible )
  end
end

function test()
--  currentFrame = getglobal("FriendsFrame")
--    if currentFrame and currentFrame:IsVisible() then
--      currentFrame:Hide()
--    end
end

-- *:***************************************************************
function AutoDecline_HideWindow(windowToHide)
  local windowIndex, hidWindow
  hidWindow = nil
  for windowIndex = 1, STATICPOPUP_NUMDIALOGS do
    local currentFrame = getglobal("StaticPopup" .. windowIndex)
    if currentFrame:IsVisible() and (currentFrame.which == windowToHide) then
      currentFrame:Hide()
      hidWindow = true
    end
  end

  if (not hidWindow) then
    local currentFrame = getglobal(windowToHide)
    if currentFrame and currentFrame:IsVisible() then
      currentFrame:Hide()
      hidWindow = true
    else
      if (not currentFrame) then
        AutoDecline_Debug(format("Frame %s not found.", windowToHide))
      else
        AutoDecline_Debug(format("Frame %s found, but it is hidden already.", windowToHide))
      end
    end
  end

  if not hidWindow then
    AutoDecline_Debug(format("Window %s not found.", windowToHide))
  end
end

-- *:***************************************************************
function AutoDecline_ShowToggle(toggleValue)
   local toggleResult
   if toggleValue then
     toggleResult = AD_ON
   else
     toggleResult = AD_OFF
   end
   return toggleResult
end

-- *:***************************************************************
function AutoDecline_SetStatus(statusString, origValue)
   returnResult = origValue
   statusString = string.lower(statusString)

   if statusString == "on" then
      returnResult = true
   elseif statusString == "off" then
      returnResult = false
   elseif statusString == "" then
      returnResult = not returnResult
   end
   return returnResult
end

-- *:***************************************************************
function AutoDecline_GetValue(valueKey)
   returnValue = ""
   if not playerID then
      AutoDecline_Display("GetValue ERROR: Invalid playerID = " .. FormatOutput(playerID))
   elseif not valueKey then
      AutoDecline_Display("GetValue ERROR: Invalid valueKey = " .. FormatOutput(valueKey))
   else
     if valueKey == "allChars" then
       returnValue = AutoDeclineConfig[valueKey]
     else
       returnValue = AutoDeclineConfig[playerID][valueKey]
     end
   end
--   end
   return returnValue
end

-- *:***************************************************************
function AutoDecline_SetValue(valueKey, newValue)
   if valueKey == "allChars" then
     if playerID ~= "allChars" then
       AutoDeclineConfig["allChars"] = AutoDeclineConfig[playerID]
     end
   else
   if not playerID then
      AutoDecline_Display("SetValue ERROR: Invalid playerID = " .. FormatOutput(playerID))
   elseif not valueKey then
      AutoDecline_Display("SetValue ERROR: Invalid valueKey = " .. FormatOutput(valueKey))
   else
      AutoDeclineConfig[playerID][valueKey] = newValue
   end
   end
end

-- *:***************************************************************
function AutoDecline_SetAllChars()
   if playerID ~= "allChars" then
     AutoDecline_Debug( "Setting AllChars")
     AutoDeclineConfig["allChars"] = AutoDeclineConfig[playerID]
     playerID = "allChars"
   end
end

-- *:***************************************************************
function AutoDecline_SetLocalChars()
   if playerID ~= localPlayerID then
     AutoDecline_Debug( "Restoring local character settings")
     playerID = localPlayerID
     AutoDeclineConfig[playerID] = AutoDeclineConfig["allChars"]
     AutoDeclineConfig["allChars"] = nil
   end
end

-- *:***************************************************************
function AutoDecline_LoadFriendsList()
   if realmID then
      AutoDeclineFriends[realmID] = {}
      numberOfFriends = GetNumFriends()
      for friendIndex = 1, numberOfFriends do
         friendName, friendLevel, friendClass, friendArea, friendConnected = GetFriendInfo(friendIndex)
         if friendName then
           friendName = string.lower(friendName)
           AutoDeclineFriends[realmID][friendName] = true
         end
      end
   end
end

-- *:***************************************************************
function AutoDecline_SetLastWhisper(playerName)
   local newName = string.lower(playerName)
   if not whisperNames then
     whisperNames = {}
   end
   inList = table.foreach(whisperNames, function (index,value)
                                          if (newName == value) then
                                            return 1
                                          end
                                        end)

   if (not inList) then
     table.insert(whisperNames, newName)
     AutoDecline_Debug(format("Adding %s to whisperNames.", newName))
     if table.getn(whisperNames) > whisperLimit then
        AutoDecline_Debug(format("Removing %s to whisperNames.", whisperNames[1]))
        table.remove(whisperNames, 1)
     end
   end
end

-- *:***************************************************************
function AutoDecline_CheckGuild(playerName)
   returnValue = nil

   for guildIndex = 1,GetNumGuildMembers() do
     memberName, _, _, _, _, _, _, _, _, _ = GetGuildRosterInfo(guildIndex);
     if playerName == string.lower(memberName) then
       returnValue = true
       break
     end
   end


--[[

-- This doesn't work, to be implemented in the future when WoW supports a good way
-- to get the guild name given a players name.
   adCheckingGuild = true

--   SetWhoToUI(1)
--   SendWho( playerName )

   AutoDecline_Debug( "Waiting for FriendsFrame to be visible." )
   friendsFrame = getglobal( "FriendsFrame" )

--   while friendsFrame and (not friendsFrame:IsVisible()) and (not adLoopStop) do
--   end

   if adLoopStop then
     AutoDecline_Debug( "Waiting for FriendsFrame to be visible." )
   else
     if friendsFrame then
       AutoDecline_Debug( "FriendsFrame is visible!" )
       AutoDecline_HideWindow( "FriendsFrame" )
     else
       AutoDecline_Debug( "FriendsFrame not found." )
     end
   end

   whoCount = GetNumWhoResults()
   AutoDecline_Debug( "Got " .. whoCount .. " who results back." )
   for whoIndex = 1,whoCount do
     whoName, guildName, playerLevel, playerRace, playerClass, playerZone, unknown = GetWhoInfo( whoIndex );

     AutoDecline_Debug( "whoName = " .. FormatOutput(whoName) )
     AutoDecline_Debug( "guildName = " .. FormatOutput(guildName) )
     AutoDecline_Debug( "playerLevel = " .. FormatOutput(playerLevel) )
     AutoDecline_Debug( "playerRace = " .. FormatOutput(playerRace) )
     AutoDecline_Debug( "playerClass = " .. FormatOutput(playerClass) )
     AutoDecline_Debug( "playerZone = " .. FormatOutput(playerZone) )
     AutoDecline_Debug( "unknown = " .. FormatOutput(unknown) )

     if string.lower( whoName ) == playerName then
       whoIndex = whoCount
     else
       guildName = nil
     end
   end

   if guildName then
     returnValue = AutoDeclinePartyGuildAllow[realmID][string.lower(guildName)]
   else
     returnValue = ""
   end

   AutoDecline_HideWindow( "FriendsFrame" )
   cancelFriendList = true
]]--

   return returnValue
end

-- *:***************************************************************
function AutoDecline_ShowStatus()
    AutoDecline_Display("Status")
    AutoDecline_Display("   " .. iif(AutoDeclineConfig[playerID].guildToggle, AD_GUILD_ON, AD_GUILD_OFF))
    AutoDecline_Display("   " .. iif(AutoDeclineConfig[playerID].partyToggle, AD_PARTY_ON, AD_PARTY_OFF))
    AutoDecline_Display("   " .. iif(AutoDeclineConfig[playerID].duelToggle, AD_DUEL_ON, AD_DUEL_OFF))
    AutoDecline_Display("   " .. iif(AutoDeclineConfig[playerID].charterToggle, AD_CHARTER_ON, AD_CHARTER_OFF))
    AutoDecline_Display("   " .. iif(AutoDeclineConfig[playerID].partyFriends, AD_PARTYFRIENDS_ON, AD_PARTYFRIENDS_OFF))
    AutoDecline_Display("   " .. iif(AutoDeclineConfig[playerID].partyGuild, AD_PARTYGUILD_ON, AD_PARTYGUILD_OFF))
    AutoDecline_Display("   " .. iif(AutoDeclineConfig[playerID].partyWhisper, AD_PARTYWHISPER_ON, AD_PARTYWHISPER_OFF))
    AutoDecline_Display("   " .. iif(AutoDeclineConfig[playerID].showAlert, AD_ALERT_ON, AD_ALERT_OFF))

    if AUTODECLINE_DEBUG then
      AutoDecline_Display("   ** Persistant debug mode is ON")
    end
    if debugMode then
      AutoDecline_Display("   ** Debug mode is ON")
    end

    AutoDecline_Display("")
    AutoDecline_DisplayActions("PARTY")
    AutoDecline_DisplayActions("DUEL")
    AutoDecline_DisplayActions("CHARTER")
    AutoDecline_DisplayActions("GUILD")
end

-- *:***************************************************************
function AutoDecline_DisplayActions(declineType)
  if AutoDeclineActions[declineType] then
    AutoDecline_Display(format(AD_DISPLAYACTION_HEADER, declineType))
    for actionIndex,eachAction in AutoDeclineActions[declineType] do
      AutoDecline_Display(format("%4s",actionIndex) .. ": " .. eachAction)
    end
  else
    AutoDecline_Display(format(AD_DISPLAYACTION_NONE, declineType))
  end
end

-- *:***************************************************************
function AutoDecline_DoAction( actionList, argList )
if debugMode then
  if actionList then
     AutoDecline_Debug("actionList: " .. table.concat(actionList,"::"))
  else
     AutoDecline_Debug("actionList: (nil)")
  end
end

  if actionList then
    for actionIndex,eachAction in actionList do
      eachAction = string.gsub(eachAction, "%$(%w+)", function (actionType)
                                                        return argList[actionType]
                                                      end)
      AutoDecline_Debug( "Performing action " .. eachAction )
      chatFrame = DEFAULT_CHAT_FRAME
      chatFrame.editBox:SetText( eachAction )
  		ChatEdit_SendText(chatFrame.editBox)
	  	ChatEdit_OnEscapePressed(chatFrame.editBox)
    end
  end
end

-- *:***************************************************************
function AutoDecline_AddAction(declineType, actionText)
  local removedAction = nil

  if actionText then
    actionText = TrimSpace(actionText)
    subAction, actionValue = GetCommand(string.lower(actionText))

    if string.sub(actionText,1,1) == "/" then
      if type(AutoDeclineActions[declineType]) == "table" then
        table.insert( AutoDeclineActions[declineType], actionText )
      else
        AutoDeclineActions[declineType] = { actionText }
      end
      AutoDecline_Display(format(AD_ADDACTION_ADD, declineType))
      AutoDecline_Display("  " .. actionText)

    elseif subAction == "clear" then
      AutoDecline_Display(format(AD_ADDACTION_CLEAR, declineType))
      AutoDeclineActions[declineType] = nil

    elseif subAction == "list" then
      AutoDecline_DisplayActions(declineType)

    elseif subAction == "remove" then
      if AutoDeclineActions[declineType] then
        actionValue = tonumber(actionValue)
        if actionValue and actionValue <= table.getn(AutoDeclineActions[declineType]) then
          AutoDecline_Display(format(AD_ADDACTION_REMOVE, declineType))
          AutoDecline_Display("  " .. AutoDeclineActions[declineType][actionValue])
          table.remove(AutoDeclineActions[declineType], actionValue)
        end
      end

    else
--      if actionText == "" then
--        actionText = AD_NONE_SPECIFIED
--      end
      AutoDecline_Display(format(AD_ADDACTION_ERROR, actionText))

    end
  end
end

-- *:***************************************************************
function AutoDecline_Debug(displayText)
  if debugMode then
    if DEFAULT_CHAT_FRAME and displayText then
      DEFAULT_CHAT_FRAME:AddMessage(AD_DEBUG_TAG .. " " ..  displayText)
    end
  end
end


-- *:***************************************************************
function AutoDecline_AddList( listArray, argArray, messageText )
  for argIndex,argValue in argArray do
    if (type(argValue) == "string") and (string.len(argValue) > 0) then
      listArray[realmID][string.lower(argValue)] = true
      AutoDecline_Display(format(messageText, argValue))
    end
  end
end


-- *:***************************************************************
-- *:***************************************************************
-- *:***************************************************************
-- *: Generic functions
-- *:***************************************************************
-- *:***************************************************************
-- *:***************************************************************

-- *:***************************************************************
-- *: Trims leading and trailing spaces from a string, and collapses
-- *: groups of spaces into a single space.
function TrimSpace(paramString)
	return string.gsub(string.gsub(paramString, "^%s*(.-)%s*$", "%1"), "%s+"," ")
end

-- *:***************************************************************
-- *: Returns the action verb and arguments from a command line
-- *:
-- *: Parameters:
-- *: commandLine - the command line
-- *: argSeperator - seperator for each argument.  if nil, all arguments
-- *:    are passed back as a single string.  Also, if a seperator
-- *:    is declared, all arguments are lower cased.
-- *:
-- *: Returns:
-- *: actionVerb - The action verb
-- *: parmsResult - The parameters, as a string or array depending
-- *:    if sep was declared.
function GetCommand(commandLine, argSeperator)
   actionVerb = nil
   parmsResult = nil
   argString = nil

   commandLine = TrimSpace(commandLine)
   regexString = "^%s*(%w+)%s*(.-)$"
   _, _, actionVerb, argString = string.find(commandLine, regexString)

   if argString and argSeperator then
      parmsResult = {}
      for eachArgument in string.gfind(argString .. argSeperator,"(.-)" .. argSeperator) do
--         table.insert( parmsResult, TrimSpace(string.lower(eachArgument)) )
         eachArgument = TrimSpace(string.lower(eachArgument))
         table.insert(parmsResult, eachArgument)
      end
   else
      parmsResult = argString
   end

   if actionVerb then
      actionVerb = string.lower(actionVerb)
   end
   return actionVerb, parmsResult, argString
end

-- *:***************************************************************
function iif( ifCondition, thenResult, elseResult )
   if ifCondition then
      return thenResult
   else
      return elseResult
   end
end

-- *:***************************************************************
function FormatOutput( outputToFormat )
  local returnResult = ""

  if type(outputToFormat) == "nil" then
    returnResult = "(nil)"
  elseif type(outputToFormat) == "table" then
    returnResult = table.concat(outputToFormat, "::")
  elseif type(outputToFormat) == "boolean" then
    if outputToFormat then
      returnResult = "Yes"
    else
      returnResult = "No"
    end
  elseif (type(outputToFormat) == "number") then
    returnResult = string.format( "%s", outputToFormat )
  elseif (type(outputToFormat) == "string") then
    returnResult = outputToFormat
  else
    returnResult = outputToFormat
  end

  return returnResult
end


