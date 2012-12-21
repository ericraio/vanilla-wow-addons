--------------------------------------------------------------------------------
-- TrackerAssist
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- global variables which get saved across sessions
--------------------------------------------------------------------------------

-- whether or not the AddOn is enabled.
TrackerAssist_ENABLED = true;

-- whether or not label delay is enabled.  if enabled, labels will only display
-- for a period of time and will then be cleared.
TrackerAssist_ENABLE_LABEL_DECAY = true;

-- if enabled track info printed in your chat window will also be sent to the
-- specified chat channel ("party", "guild", or "raid")
TrackerAssist_ENABLE_CHAT_ANNOUNCE = true;
TrackerAssist_CHAT_ANNOUNCE_CHANNEL = "party";

-- if enabled, then the label under the minimap updates by mousing over blips
TrackerAssist_ENABLE_MOUSEOVER = false;

-- if enabled, NPCs are colored based on their reaction to the player
TrackerAssist_ENABLE_NPCCOLOR = true;

--------------------------------------------------------------------------------
-- global variables
--------------------------------------------------------------------------------

-- current version
local curVersion = "v1.7";

-- the text label (FontString) currently being displayed, or nil if none
local curLabel = nil;

-- the time (returned from GetTime()) at which the currently displayed
-- label was first displayed.  used to decay the label after a period of time.
local curLabelStartTime = 0;

-- if label decay is enabled, this controls how long (in seconds) before the
-- label decays.  this is initially set to a longer time period so that the
-- announcement/version message gets displayed, but is shortened when text
-- is set via the SetTextXXX() functions.
local LABEL_DECAY_TIME = 30.0;

-- when multiple items are under the mouse, these variables are used to cycle
-- through them.
local prevLineText = "";
local prevLineItemNum = 0;
local prevLineNumItems = 0;

-- if there was already a target and the tooltip didn't contain a valid target
-- this is used to preserve the original target
local origTarget = nil;

-- indicates the new target selected as a result of processing the click
local newTarget = nil;

-- the last mouse-over tooltip text that was processed
local lastMOText = "";

-- indicates current event is a mouse-over not a click
local eventIsMouseOver = false;

-- stores original functions while processing text
local orig_TargetFrame_OnShow;
local orig_TargetFrame_OnHide;

--------------------------------------------------------------------------------
-- function which does nothing
--------------------------------------------------------------------------------
function TrackerAssist_nil()
end

--------------------------------------------------------------------------------
-- clears currently displayed label
--------------------------------------------------------------------------------
function TrackerAssist_ClearText()
   if (curLabel ~= nil) then
      curLabel:SetText("");
      curLabel = nil;
      curLabelStartTime = 0;
   end
end

--------------------------------------------------------------------------------
-- sets and shows regular message text
--------------------------------------------------------------------------------
function TrackerAssist_SetText(text)
   TrackerAssist_ClearText();
   TrackerAssistText:SetText(text);
   TrackerAssistText:SetTextColor(1.0,1.0,0.0);
   TrackerAssistText:Show();
   curLabel = TrackerAssistText;
   curLabelStartTime = GetTime();
   LABEL_DECAY_TIME = 5.0;
end

--------------------------------------------------------------------------------
-- sets and shows friendly message text
--------------------------------------------------------------------------------
function TrackerAssist_SetFriendText(text)
   TrackerAssist_ClearText();
   TrackerAssistText:SetText(text);
   TrackerAssistText:SetTextColor(0.3,1.0,0.3);
   TrackerAssistText:Show();
   curLabel = TrackerAssistText;
   curLabelStartTime = GetTime();
   LABEL_DECAY_TIME = 5.0;
end

--------------------------------------------------------------------------------
-- sets and shows hostile message text
--------------------------------------------------------------------------------
function TrackerAssist_SetFoeText(text)
   TrackerAssist_ClearText();
   TrackerAssistText:SetText(text);
   TrackerAssistText:SetTextColor(1.0,0.3,0.3);
   TrackerAssistText:Show();
   curLabel = TrackerAssistText;
   curLabelStartTime = GetTime();
   LABEL_DECAY_TIME = 5.0;
end

--------------------------------------------------------------------------------
-- prints message text of the specified color to the chat window
--------------------------------------------------------------------------------
function TrackerAssist_PrintColoredMsg(msg,r,g,b)
   if(ChatFrame1) then
      ChatFrame1:AddMessage(msg, r, g, b);
   end
end

--------------------------------------------------------------------------------
-- prints regular message text to the chat window
--------------------------------------------------------------------------------
function TrackerAssist_Print(msg)
   TrackerAssist_PrintColoredMsg(msg,1.0,1.0,0.0);
end

--------------------------------------------------------------------------------
-- prints NPC message text to the chat window
--------------------------------------------------------------------------------
function TrackerAssist_PrintNPC(msg)
   TrackerAssist_PrintColoredMsg(msg,1.0,1.0,0.0);
end

--------------------------------------------------------------------------------
-- prints friendly message text to the chat window
--------------------------------------------------------------------------------
function TrackerAssist_PrintFriend(msg)
   TrackerAssist_PrintColoredMsg(msg,0.3,1.0,0.3);
end

--------------------------------------------------------------------------------
-- prints hostile message text to the chat window
--------------------------------------------------------------------------------
function TrackerAssist_PrintFoe(msg)
   TrackerAssist_PrintColoredMsg(msg,1.0,0.3,0.3);
end

--------------------------------------------------------------------------------
-- called when the AddOn is loaded.  Performs initialization tasks.
--------------------------------------------------------------------------------
function TrackerAssist_OnLoad()
   -- register for minimap ping (mouse click on minimap) events
   this:RegisterEvent("MINIMAP_PING");

   -- create slash "/" command
   SlashCmdList["TRACKERASSIST"] = TrackerAssist_Command;
   SLASH_TRACKERASSIST1 = "/trackerassist";
   SLASH_TRACKERASSIST2 = "/ta";

   -- set text label to right/top-justified
   TrackerAssistText:SetJustifyH("right");
   TrackerAssistText:SetJustifyV("top");

   -- show initial welcome text
   TrackerAssist_SetText("TrackerAssist " .. curVersion);
   -- TrackerAssist_Print("TrackerAssist " .. curVersion .. " loaded");
end

--------------------------------------------------------------------------------
-- called on each visual update
--------------------------------------------------------------------------------
function TrackerAssist_OnUpdate()
   -- if a label is currently being displayed and if label decay is enabled   
   if ((curLabel ~= nil) and
       (TrackerAssist_ENABLE_LABEL_DECAY)) then
      -- if the label has been displayed for longer than the decay time
      if ((GetTime() - curLabelStartTime) > LABEL_DECAY_TIME) then
         -- clear the label
         TrackerAssist_ClearText();
         lastMOText = "";
      end
   end
   
   -- only process event if enabled
   if (TrackerAssist_ENABLED) then
      -- only process if mouseover processing is enabled
      if (TrackerAssist_ENABLE_MOUSEOVER) then
         if (TrackerAssist_MouseCheck()) then
            -- only proceed if tooltip is showing
            if (GameTooltip:IsVisible()) then
               TrackerAssist_Process_Tooltip_MouseOver();
            end
         end
      end
   end
end

--------------------------------------------------------------------------------
-- checks if the mouse should be processed
--------------------------------------------------------------------------------
function TrackerAssist_MouseCheck()
   local result = false;
   
   -- if the mouse is over the visible minimap or zoomed minimap and its not
   -- over any of the edge buttons (clock, mail, etc) then process
   if ((MinimapCluster and MouseIsOver(MinimapCluster) and MinimapCluster:IsVisible() and
        MiniMapTrackingFrame and (not MouseIsOver(MiniMapTrackingFrame)) and
        MiniMapMailFrame and (not MouseIsOver(MiniMapMailFrame)) and
        MinimapZoomIn and (not MouseIsOver(MinimapZoomIn)) and
        MinimapZoneTextButton and (not MouseIsOver(MinimapZoneTextButton)) and
        MinimapZoomOut and (not MouseIsOver(MinimapZoomOut)) and
        GameTimeFrame and (not MouseIsOver(GameTimeFrame))) or
       (ZoomMapCluster and MouseIsOver(ZoomMapCluster) and ZoomMapCluster:IsVisible())) then
       result = true;
   end
   
   return result;
end

--------------------------------------------------------------------------------
-- responds to the slash "/" command
--------------------------------------------------------------------------------
function TrackerAssist_Command(cmd)

   if (string.len(cmd) == 0) then
      TrackerAssist_Print("\nTrackerAssist " .. curVersion .. "\n\n");

      if (TrackerAssist_ENABLED) then
         TrackerAssist_Print("TrackerAssist is ENABLED\n");
      else
         TrackerAssist_Print("TrackerAssist is DISABLED\n");
      end

      if (TrackerAssist_ENABLE_LABEL_DECAY) then
         TrackerAssist_Print("Label Decay is ENABLED\n");
      else
         TrackerAssist_Print("Label Decay is DISABLED\n");
      end
      
      if (TrackerAssist_ENABLE_CHAT_ANNOUNCE) then
         TrackerAssist_Print("Chat Announce is ENABLED\n");
      else
         TrackerAssist_Print("Chat Announce is DISABLED\n");
      end
      
      TrackerAssist_Print("Chat Announce Channel is " .. 
         TrackerAssist_CHAT_ANNOUNCE_CHANNEL .. "\n");

      if (TrackerAssist_ENABLE_MOUSEOVER) then
         TrackerAssist_Print("Mouse Over is ENABLED\n");
      else
         TrackerAssist_Print("Mouse Over is DISABLED\n");
      end

      if (TrackerAssist_ENABLE_NPCCOLOR) then
         TrackerAssist_Print("NPC color is ENABLED\n");
      else
         TrackerAssist_Print("NPC color is DISABLED\n");
      end

      TrackerAssist_Print("\n/trackerassist enabled - toggles whether or not " ..
                          "the TrackerAssist AddOn is enabled\n");
      TrackerAssist_Print("/trackerassist decay - toggles decay of the " ..
                          "label under the minimap\n");
      TrackerAssist_Print("/trackerassist announce - toggles " ..
                          "announcement of track info on the specified chat channel\n");
      TrackerAssist_Print("/trackerassist channel <chan> - sets the chat channel used " ..
                          "to announce track info (must be party, guild, or raid)\n");
      TrackerAssist_Print("/trackerassist mouseover - toggles whether " ..
                          "or not mouseover is enabled.\n");
      TrackerAssist_Print("/trackerassist npccolor - toggles whether " ..
                          "or not NPC text is color-coded based on the unit " ..
                          "reaction to the player.\n\n");
                          
   else
      if (cmd == "enabled") then
         TrackerAssist_ENABLED = not TrackerAssist_ENABLED;

         if (TrackerAssist_ENABLED) then
            TrackerAssist_Print("TrackerAssist is ENABLED\n");
         else
            TrackerAssist_Print("TrackerAssist is DISABLED\n");
            TrackerAssist_ClearText();
         end
      elseif (cmd == "decay") then
         TrackerAssist_ENABLE_LABEL_DECAY = 
            not TrackerAssist_ENABLE_LABEL_DECAY;

         if (TrackerAssist_ENABLE_LABEL_DECAY) then
            TrackerAssist_Print("Label Decay is ENABLED\n");
         else
            TrackerAssist_Print("Label Decay is DISABLED\n");
         end      
      elseif (cmd == "announce") then
         TrackerAssist_ENABLE_CHAT_ANNOUNCE = 
            not TrackerAssist_ENABLE_CHAT_ANNOUNCE;

         if (TrackerAssist_ENABLE_CHAT_ANNOUNCE) then
            TrackerAssist_Print("Chat Announce is ENABLED\n");
         else
            TrackerAssist_Print("Chat Announce is DISABLED\n");
         end         
      elseif (cmd == "channel party") then
         TrackerAssist_CHAT_ANNOUNCE_CHANNEL = "party";
         TrackerAssist_Print("Chat Announce Channel is " .. 
            TrackerAssist_CHAT_ANNOUNCE_CHANNEL .. "\n");         
      elseif (cmd == "channel guild") then
         TrackerAssist_CHAT_ANNOUNCE_CHANNEL = "guild";
         TrackerAssist_Print("Chat Announce Channel is " .. 
            TrackerAssist_CHAT_ANNOUNCE_CHANNEL .. "\n");         
      elseif (cmd == "channel raid") then
         TrackerAssist_CHAT_ANNOUNCE_CHANNEL = "raid";
         TrackerAssist_Print("Chat Announce Channel is " .. 
            TrackerAssist_CHAT_ANNOUNCE_CHANNEL .. "\n");         
      elseif (cmd == "mouseover") then
         TrackerAssist_ENABLE_MOUSEOVER = 
            not TrackerAssist_ENABLE_MOUSEOVER;

         if (TrackerAssist_ENABLE_MOUSEOVER) then
            TrackerAssist_Print("Mouse Over is ENABLED\n");
         else
            TrackerAssist_Print("Mouse Over is DISABLED\n");
         end
      elseif (cmd == "npccolor") then
         TrackerAssist_ENABLE_NPCCOLOR = 
            not TrackerAssist_ENABLE_NPCCOLOR;

         if (TrackerAssist_ENABLE_NPCCOLOR) then
            TrackerAssist_Print("NPC color is ENABLED\n");
         else
            TrackerAssist_Print("NPC color is DISABLED\n");
         end
      end
   end
end

--------------------------------------------------------------------------------
-- called when events occur
--------------------------------------------------------------------------------
function TrackerAssist_OnEvent()
   -- only process event if enabled
   if (TrackerAssist_ENABLED) then
      -- look for minimap ping events
      if (event == "MINIMAP_PING") then
         if (TrackerAssist_MouseCheck()) then
            -- only proceed if tooltip is showing
            if (GameTooltip:IsVisible()) then
               TrackerAssist_Process_Tooltip();
            end
         end
      end
   end
end

--------------------------------------------------------------------------------
-- process the tooltip resulting from a mouse click
--------------------------------------------------------------------------------
function TrackerAssist_Process_Tooltip()
   -- for purposes of targeting blips on the map, we only need
   -- the first tooltip line.  when there are multiple blips
   -- being represented, they're all actually in the first tooltip
   -- line as a string which itself has multiple lines
   numLines = GameTooltip:NumLines();
   if (numLines > 0) then
      local tttext = GameTooltipTextLeft1:GetText();
      if (tttext ~= nil) then
         TrackerAssist_Process_TooltipLine(tttext);
      end
   end
end

--------------------------------------------------------------------------------
-- process the tooltip resulting from a mouse over
--------------------------------------------------------------------------------
function TrackerAssist_Process_Tooltip_MouseOver()
   numLines = GameTooltip:NumLines();
   if (numLines > 0) then
      local motext = GameTooltipTextLeft1:GetText();
      if (motext ~= nil) then         
         local moline = TrackerAssist_GetLine(motext,1);
         if (string.len(moline) > 0) then
            -- if the first line of the tooltip text has changed since we last
            -- did this, then process it
            if (moline ~= lastMOText) then            

               -- hook these to avoid the targeting sound
               orig_TargetFrame_OnShow = TargetFrame_OnShow;
               orig_TargetFrame_OnHide = TargetFrame_OnHide;
               TargetFrame_OnShow = TrackerAssist_nil;
               TargetFrame_OnHide = TrackerAssist_nil;

               eventIsMouseOver = true;

               lastMOText = moline;
               TrackerAssist_Process_TooltipLine(moline);            

               -- restore or clear target, since mouse-over shouldn't affect
               -- targeting
               if (origTarget ~= nil) then
                  TargetByName(origTarget);
               else
                  ClearTarget();
               end

               eventIsMouseOver = false;

               -- unhook
               TargetFrame_OnShow = orig_TargetFrame_OnShow;
               TargetFrame_OnHide = orig_TargetFrame_OnHide;
            end
         end
      end
   end
end

--------------------------------------------------------------------------------
-- processes the specified tooltip line (which may contain multiple units)
--------------------------------------------------------------------------------
function TrackerAssist_Process_TooltipLine(line)

   -- store current target, if any and initialize new target variable
   origTarget = UnitName("target");
   newTarget = nil;

   -- temporarily clear some error messages which could be shown
   local orig_ERR_UNIT_NOT_FOUND = ERR_UNIT_NOT_FOUND;
   ERR_UNIT_NOT_FOUND = "";
   local orig_ERR_GENERIC_NO_TARGET = ERR_GENERIC_NO_TARGET;
   ERR_GENERIC_NO_TARGET = "";   

   -- gets rid of any items which can not be a target.
   -- when the mouse is over multiple items, clicking multiple
   -- times cycles through them.  if there are non-targetable items
   -- included in this cycling, then extra clicks would be needed
   -- to cycle through the valid targets.  this avoids that.
   line = TrackerAssist_StripNontargets(line);

   local idx = string.find(line,"\n");
   if (idx == nil) then
      -- if there's only a single item, then process it and
      -- clear out the variables used for cycling through multiple items
      prevLineText = "";
      prevLineItemNum = 0;
      prevLineNumItems = 0;
      TrackerAssist_Process_Unit(line);
   else
      -- if there are multiple items and this is the
      -- first time this particular set of items was clicked
      -- initialize the variables used for cycling through the items
      if (line ~= prevLineText) then
         prevLineText = line;
         prevLineItemNum = 0;
         prevLineNumItems = TrackerAssist_NumLines(line);
      end
      -- advance to next item in the set of items
      prevLineItemNum = prevLineItemNum + 1;
      if (prevLineItemNum > prevLineNumItems) then
         prevLineItemNum = 1;
      end
      -- process the next item in the set of items
      TrackerAssist_Process_Unit(TrackerAssist_GetLine(line,prevLineItemNum));
   end
   
   -- if we didn't select a new target and if there was previously
   -- a target, then restore that target
   if ((origTarget ~= nil) and
       (newTarget == nil)) then
      TargetByName(origTarget);
   end

   -- restore error messages
   ERR_UNIT_NOT_FOUND = orig_ERR_UNIT_NOT_FOUND;
   ERR_GENERIC_NO_TARGET = orig_ERR_GENERIC_NO_TARGET;
end

--------------------------------------------------------------------------------
-- counts the # of lines in the specified string
--------------------------------------------------------------------------------
function TrackerAssist_NumLines(s)
   local idx = string.find(s,"\n");
   if (idx == nil) then
      return 1;
   else
      return 1 + TrackerAssist_NumLines(string.sub(s,idx+1,string.len(s)));
   end
end

--------------------------------------------------------------------------------
-- retrieves the specified line from the string
--------------------------------------------------------------------------------
function TrackerAssist_GetLine(s,line)
   local tmp = s;
   local curLineNum = 0;
   local result = "";
   while (curLineNum < line) do
      curLineNum = curLineNum + 1;
      local idx = string.find(tmp,"\n");
      if (idx == null) then
         result = tmp;
         break;
      else
         result = string.sub(tmp,1,idx-1);
         tmp = string.sub(tmp,idx+1,string.len(tmp));
      end
   end   
   if (curLineNum ~= line) then
      result = "";
   end
   return result;
end

--------------------------------------------------------------------------------
-- removes all lines from the string which do not represent valid targets
--------------------------------------------------------------------------------
function TrackerAssist_StripNontargets(line)
   local newline = "";
   local curLineNum = 0;
   local numLines = TrackerAssist_NumLines(line);
   while (curLineNum < numLines) do
      curLineNum = curLineNum + 1;
      local s = TrackerAssist_GetLine(line,curLineNum);
      ClearTarget();
      TargetByName(s);
      local name = UnitName("target");
      if (name ~= nil) then
         newline = newline .. s;
         if (curLineNum < numLines) then
            newline = newline .. "\n";
         end
      end
   end
   ClearTarget();
   return newline;
end

--------------------------------------------------------------------------------
-- called once a targetable unit has been identified in the tooltip text
--------------------------------------------------------------------------------
function TrackerAssist_Process_Unit(line)
   ClearTarget();
   TargetByName(line);

   local s, x, name, level, race, class, guildname, guildstatust, guildstatusn,
         reaction;

   name = UnitName("target");
   if (name ~= nil) then
      newTarget = name;
      s = "TRACK INFO: ";

      if (UnitIsPlayer("target")) then
         s = s .. "PLAYER: ";
      else
         s = s .. "NPC: ";
      end

      s = s .. name;

      level = UnitLevel("target");
      if (level ~= nil) then
         s = s .. ", " .. level;
      end

      if (UnitIsPlayer("target")) then      
         race = UnitRace("target");
         if (race ~= nil) then
            s = s .. " " .. race;
         end

         class = UnitClass("target");
         if (class ~= nil) then
            s = s .. " " .. class;
         end         
      end

      if (UnitIsPlayer("target")) then
         x = name .. " " .. level .. " " .. race .. " " .. class;

         guildname,guildstatust,guildstatusn = GetGuildInfo("target");
         if (guildname ~= nil) then
            x = x .. "\n<" .. guildname .. ">";
            s = s .. " <" .. guildname .. ">";
         end
         
         local factionT, groupT = UnitFactionGroup("target");
         local factionP, groupP = UnitFactionGroup("player");

         if (factionT == factionP) then
            TrackerAssist_SetFriendText(x);
            if (not eventIsMouseOver) then
               TrackerAssist_PrintFriend(s);
            end
         else
            TrackerAssist_SetFoeText(x);
            if (not eventIsMouseOver) then
               TrackerAssist_PrintFoe(s);
            end
         end
      else
         x = name .. " " .. level .. " NPC";
         
         if (TrackerAssist_ENABLE_NPCCOLOR) then
            reaction = UnitReaction("target","player");

            if (reaction < 4) then
               TrackerAssist_SetFoeText(x);
               if (not eventIsMouseOver) then
                  TrackerAssist_PrintFoe(s);
               end
            elseif (reaction > 4) then
               TrackerAssist_SetFriendText(x);
               if (not eventIsMouseOver) then
                  TrackerAssist_PrintFriend(s);
               end
            else
               TrackerAssist_SetText(x);
               if (not eventIsMouseOver) then
                  TrackerAssist_PrintNPC(s);
               end
            end         
         else
            TrackerAssist_SetText(x);
            if (not eventIsMouseOver) then
               TrackerAssist_PrintNPC(s);         
            end
         end
      end
      
      if (TrackerAssist_ENABLE_CHAT_ANNOUNCE and (not eventIsMouseOver)) then
         if (TrackerAssist_CHAT_ANNOUNCE_CHANNEL == "party") then
            if (GetNumPartyMembers() > 0) then
               SendChatMessage(s,"party");
            end
         elseif (TrackerAssist_CHAT_ANNOUNCE_CHANNEL == "guild") then
            guildname,guildstatust,guildstatusn = GetGuildInfo("player");
            if (guildname ~= nil) then
               SendChatMessage(s,"guild");
            end
         elseif (TrackerAssist_CHAT_ANNOUNCE_CHANNEL == "raid") then         
            if (GetNumRaidMembers() > 0) then
               SendChatMessage(s,"raid");
            end
         end
      end
   end
end
