--[[  ChatBox
   by Norbet and the [many] unsung heroes.


--
-- Change the chat groups to split out the Officer and Raid channels.
--
ChatTypeGroup["PARTY"] = {
	"CHAT_MSG_PARTY"
};

ChatTypeGroup["RAID"] = {
	"CHAT_MSG_RAID"
};
ChannelMenuChatTypeGroups[6] = "RAID";

now iterate through the chat frames and add the new raid channel..
ChatFrame_AddMessageGroup(chatFrame, "RAID");

now the hooks..

ChatBox_FCFMessageTypeDropDown_OnClick = function()
   -- For some reason the game refuses to save these in chat-cache.txt so I have to save them myself.
   if (this.value == "RAID") then
      local checked = UIDropDownMenuButton_GetChecked();
      local chatFrameName = FCF_GetCurrentChatFrame():GetName();

      if (not ChatBox[chatFrameName]) then
         ChatBox[chatFrameName] = {};
      end

      if (checked) then
         ChatBox[chatFrameName][this.value] = nil;
      else
         ChatBox[chatFrameName][this.value] = 1;
      end
   end

   CB_Orig_FCFMessageTypeDropDown_OnClick();
end


ChatBox_FCF_OpenNewWindow = function(name)
   CB_Orig_FCF_OpenNewWindow(name);

   local chatFrame;
   local chatTab;
   local frameName;

   for i=1, NUM_CHAT_WINDOWS do
      chatFrame = getglobal("ChatFrame"..i);
      chatTab = getglobal("ChatFrame"..i.."Tab");
      frameName = chatFrame:GetName();
      if (chatTab:GetText() == name) then
         ChatFrame_AddMessageGroup(chatFrame, "RAID");

         if (not ChatBox[frameName]) then
            ChatBox[frameName] = {};
         end
         ChatBox[frameName]["RAID"] = 1;
         return;
      end
   end
end

]]--





--init start vars...
ChatBox_isLoaded = nil
ChatBox_lastName = nil
CB_Orig_OnHyperlinkEnter_Table = {};
CB_Orig_OnHyperlinkLeave_Table = {};
ChatBox_frameCount = 0
ChatBox_LastTell = ""
ChatBox_actions = { banker=1, taxi=1, trainer=1, vendor=1 };


--misc stuff
local linkstring = "%s|Hxhenc:%s<XH>%s|h[%s]|h|r" -- color, arg2 (name), arg1, link
local linkstring2 = "%s|Hxhlink:%s<XH>%s|h[%s]|h|r" -- color, arg2 (name), arg1, link
local itemcapstr = "|c[%a%d]+|Hitem:%d+:%d+:%d+:%d+|h%[([^%]]+)%]|h|r"
local guildstring = "%s|Hxhguild:%s<XH>%s|h[%s]|h|r" -- color, arg2 (name), arg1, link
--TODO get rid of maybe?
local itemlinkformat = "item:"
local playerlinkformat = "player:"
local speciallinkformat = "xhenc:(%w+)<XH>(.+)"
local portallinkformat = "xhlink:(%w+)<XH>(.+)"
local hyperlinkformat = "ref:(.*)(%b[])|h"
local guildlinkformat = "xhguild:(%w+)<XH>(.+)"


local usedColors = {};
local usedNames = {};

-- Colors
GRN    ="|cff20ff20"
YEL    ="|cffffff00"
RED    ="|cffff0000"
WHT    ="|cffffffff"
BLU    ="|cff8888ff"
DRKBLU ="|cff1b0495"
ORN    ="|cffff9C00"
GRY    ="|cffA0A0A0"
END    = "|r"



local colorsubs = {
	[YEL] = {
		["%[?Ara?ca?i?n?i?t?e? ?B?a?r? ?Tran?m?s?m?u?t?e?a?t?i?o?n?%]?"] = "Arcanite Transmute",
		["Ara?ca?i?n?i?t?e? ?B?a?r? ?xmute"] = "Arcanite Transmute",
		["Transmute?i?n?g?:? ?Ara?ca?n?i?t?e? ?B?a?r?"] = "Arcanite Transmute",
	},
	[ORN] = {
		["Porta?l? ?f?t?o?r? Org?r?i?m?m?a?r?"] = "Portal: Orgrimmar",
		["Porta?l? ?f?t?o?r? Un?d?e?r?Ci?t?y?"] = "Portal: Undercity",
		["Porta?l? ?f?t?o?r? Th?u?n?d?e?r? ?Bl?u?f?f?"] = "Portal: Thunder Bluff",
		["Porta?l? ?f?t?o?r? Ir?o?n? ?Fo?r?g?e?"] = "Portal: Ironforge",
		["Porta?l? ?f?t?o?r? ST?o?r?m?Wi?n?d?"] = "Portal: Stormwind",
		["Porta?l? ?f?t?o?r? Dara?n?na?s?s?u?a?i?s?"] = "Portal: Darnassus",
	}
}

---------------------------------------------------------------------------------------------------
--Item Relinker and ChatLink
----------------------------------------------------------------------------------------------------

-- Turn CLINKs into normal item links.
function ChatBox_Decompose (chatstring)
	if chatstring then
		chatstring = string.gsub (chatstring, "{CLINK:(%x+):(%d-):(%d-):(%d-):(%d-):([^}]-)}", "|c%1|Hitem:%2:%3:%4:%5|h[%6]|h|r")
	end
	return chatstring
end

-- Turn item links into CLINKs.
function ChatBox_Compose (chatstring)
	if chatstring then
		chatstring = string.gsub (chatstring, "|c(%x+)|Hitem:(%d-):(%d-):(%d-):(%d-)|h%[([^%]]-)%]|h|r", "{CLINK:%1:%2:%3:%4:%5:%6}")
	end
	return chatstring
end

-- Translate item links into CLINKs on outgoing non-system channel messages.
function ChatBox_SendChatMessage (msg, ...)
	local chan_num, chan_name = nil
	system, language, channel = unpack (arg)

	if ChatBox.CLINK and system == "CHANNEL" then
		chan_num, chan_name = GetChannelName (channel)
		if chan_name and
		not string.find (chan_name, CB_GENERAL) and
		not string.find (chan_name, CB_TRADE) and
		not string.find (chan_name, CB_LFG) and
		not string.find (chan_name, CB_LOCALDEF) and
		not string.find (chan_name, CB_WORLDDEF) then
			msg = ChatBox_Compose (msg)
		end
	end

	-- Pass along to original function.
	CB_Orig_SendChatMessage (msg, unpack (arg))
end

function ChatBox_OnEvent(event)

   local function updateFriendsList()
      if not ChatBox.colorNames then return end;
      local numFriends = GetNumFriends();
      for i = 1, numFriends do
         local name, _, class, _ = GetFriendInfo(i);
      	if( class and name and class ~= "Unknown" ) then
      		ChatBox_ClassData(name, class);
      	end
      end
   end

   local function updateGuildList()
      if not ChatBox.colorNames then return end;
      local numGuild = GetNumGuildMembers();
      for i = 1, numGuild do
      	local name,_,_,_,class = GetGuildRosterInfo(i);
      	if( class and name ) then
      		ChatBox_ClassData(name, class);
      	end
      end
   end

   if event == "VARIABLES_LOADED" then

      cb_display("|cffFFFFFF"..CB_LOADED .. CB_VERSION);

      if (not ChatBox) or
         (ChatBox and not ChatBox.version) or
         (ChatBox and ChatBox.version and ChatBox.version ~= CB_VERSION) then
         SetupChatVars();
         updateFriendsList();
      end

      --this purges our database of names once per month (to keep if from getting HUGE!)
      if ChatBox.date ~= date("%m") then
         cb_display(RED.. "Purging the "..YEL.."name<->color " .. RED .. "database from last month.")
         ChatBox_Names = {};
         ChatBox.date = date("%m");
      end

      --Extends the "default to last channel" <Enter> keypress to include numbered and (possible) whisper channels.
      ChatBox_SetSticky();

      --Alternative Global Strings
      ChatBox_SetStrings();

      --make the arrows work in chat.
      if ChatBox.useArrows then
         ChatFrameEditBox:SetAltArrowKeyMode(false);
      end

      --Move EditBox to the top
      if ChatBox.editAtTop then
         ChatFrameEditBox:ClearAllPoints();
         ChatFrameEditBox:SetPoint("BOTTOMLEFT", "ChatFrame1", "TOPLEFT", 0, 2);
         ChatFrameEditBox:SetPoint("BOTTOMRIGHT", "ChatFrame1", "TOPRIGHT", 0, 2);
      end

      --show/hide the emote button
      if ChatBox.hideEmoteButton then
         ChatFrameMenuButton:Hide()
      end

      -- Move the side buttons to new spot
      ChatBox_Relocate_Buttons()

      -- setup the additional data for my player link menu.
      UnitPopupButtons["WHO"]	= { text = TEXT(WHO), dist = 0 };
      UnitPopupButtons["TARGET"]	= { text = TEXT(CB_TARGET), dist = 0 };
      UnitPopupButtons["IGNORE"]	= { text = TEXT(IGNORE), dist = 0 };
      UnitPopupButtons["ADDFRIEND"]	= { text = TEXT(ADD_FRIEND), dist = 0 };
      UnitPopupButtons["UNIGNORE"]	= { text = TEXT(CB_UNIGNORE), dist = 0 };
      UnitPopupButtons["REMOVEFRIEND"]	= { text = TEXT(CB_REMOVEFRIEND), dist = 0 };

      SetupPLM();

      --to trigger the GUILD_ROSTER_UPDATE event
      GuildRoster();

   -- add current online friends
   elseif ( event == "FRIENDLIST_UPDATE" ) then
      updateFriendsList();

   --now add the people when doing a WHO
   elseif ( event == "WHO_LIST_UPDATE" ) then
   	local numWhoList = GetNumWhoResults();
	   if ( numWhoList and numWhoList > 20 ) then
	      numWhoList = 20;
	   end
	   if ( not numWhoList ) then
	      numWhoList = 2;
	   end
   	for i = 1, numWhoList do
      	local name, _, _, _, class = GetWhoInfo(i);
      	if( class ~= nil and name ~= nil ) then
      		ChatBox_ClassData(name, class);
      	end
   	end

   -- add current online guild members
   elseif ( event == "GUILD_ROSTER_UPDATE" ) then
      updateGuildList();
   end
end

function ChatBox_Relocate_Buttons()
   if ChatBox.menuOnLeft then
      spotSide  = "LEFT";
      spotEmote = "TOPLEFT";
   else
      spotSide  = "RIGHT";
      spotEmote = "TOPRIGHT";
   end

   if ChatBox_frameCount == 0 then
      return;
   end
   --put a for loop here to do all the frames.
   for i=1, 7 do
      -- Move the side buttons to new spot
      local frame1 = getglobal('ChatFrame'..i..'BottomButton');
      local frame2 = getglobal('ChatFrame'..i);
      frame1:SetPoint("RIGHT", frame2, spotSide, 0, 0);
      frame1:SetPoint("LEFT", frame2, spotSide, -32, 0);
      frame1:SetPoint("TOP", frame2, "BOTTOM", 0, 28);
      frame1:SetPoint("BOTTOM", frame2, "BOTTOM", 0, 0);

      --change the resize limits of the scroll frame
      frame2:SetMinResize(32,32);
      frame2:SetMaxResize(1600,1600);

      --set MY script so that the hylerink on enter thing does what i want.
      CB_Orig_OnHyperlinkEnter_Table["ChatFrame"..i] = getglobal("ChatFrame"..i):GetScript("OnHyperlinkEnter");
		CB_Orig_OnHyperlinkLeave_Table["ChatFrame"..i] = getglobal("ChatFrame"..i):GetScript("OnHyperlinkLeave");
		getglobal("ChatFrame"..i):SetScript("OnHyperlinkEnter", ChatBox_OnHyperlinkEnter);
		getglobal("ChatFrame"..i):SetScript("OnHyperlinkLeave", ChatBox_OnHyperlinkHide);
   end

   ChatFrameMenuButton:SetAlpha(.4);
   ChatFrameMenuButton:ClearAllPoints();
   ChatFrameMenuButton:SetPoint("TOPRIGHT", ChatFrame1, spotEmote, 0, 0);
end


function SetupChatVars()
   cb_display(GRN .. "Different Version!" .. RED.. " Checking the vars");

   if not ChatBox then
      ChatBox = {};
   end

   ChatBox.date = date("%m");
   ChatBox.version = tonumber(CB_VERSION);

   if ( ChatBox.setSticky == nil ) then
      ChatBox.setSticky = true;
   end
   if ( ChatBox.shortLFG == nil ) then
      ChatBox.shortLFG = true;
   end
   if ( ChatBox.useArrows == nil ) then
      ChatBox.useArrows = true;
   end
   if ( ChatBox.throttle == nil ) then
      ChatBox.throttle = 10;
   end
   if ( ChatBox.gthrottle == nil ) then
      ChatBox.gthrottle = 20;
   end
   if ( ChatBox.hideGossip == nil ) then
      ChatBox.hideGossip = true;
   end
   if ( ChatBox.longStrings == nil ) then
      ChatBox.longStrings = true;
   end
   if ChatBox.plm_shift == nil then
      ChatBox.plm_shift = ChatBox_specialSendWho;
      ChatBox.plm_shift_name = WHO;
   end
   if ( ChatBox.TimeStamp_Settings == nil ) then
      ChatBox.TimeStamp_Settings = {
         		color = false,
         		format = "[%H:%M:%S]",
         		frames = {
         			ChatFrame1 = CB_OFF,
         			ChatFrame2 = CB_OFF,
         			ChatFrame3 = CB_OFF,
         			ChatFrame4 = CB_OFF,
         			ChatFrame5 = CB_OFF,
         			ChatFrame6 = CB_OFF,
         			ChatFrame7 = CB_OFF,
         		   },
         		};
   end
end

----------------------------------------------------------------------------------------------------
--Tiny Chat
----------------------------------------------------------------------------------------------------

function ChatBoxFrame_OnUpdate()


   --emote icon
   if ChatBox.hideEmoteButton and ChatFrameMenuButton:IsVisible() then
      ChatFrameMenuButton:Hide()
   end

   --button icons
   local frame1 = this:GetParent():GetName().."UpButton"
   local frame2 = this:GetParent():GetName().."DownButton"
   local frame3 = this:GetParent():GetName().."BottomButton"
   local frame4 = this:GetParent():GetName()

   if (getglobal(frame1)):IsVisible() then
      getglobal(frame1):Hide()
   end
   if (getglobal(frame2)):IsVisible() then
      getglobal(frame2):Hide()
   end

   if ( (getglobal(frame4)):AtBottom() or ChatBox.hideBottomButton ) then
      if (getglobal(frame3)):IsVisible() then
         getglobal(frame3):Hide()
      end
   else
      getglobal(frame3):Show()
   end

end

function ChatBoxFrame_OnMouseWheel(chatframe, value)
   if ( value > 0 ) then
      if IsShiftKeyDown() then
         chatframe:ScrollToTop()
      elseif IsControlKeyDown() then
         chatframe:ScrollUp()
         chatframe:ScrollUp()
         chatframe:ScrollUp()
      else
         chatframe:ScrollUp()
      end
   elseif ( value < 0 ) then
      if IsShiftKeyDown() then
         chatframe:ScrollToBottom()
      elseif IsControlKeyDown() then
         chatframe:ScrollDown()
         chatframe:ScrollDown()
         chatframe:ScrollDown()
      else
         chatframe:ScrollDown()
      end
   end
end


----------------------------------------------------------------------------------------------------
-- Combined Onload
----------------------------------------------------------------------------------------------------

function ChatBoxFrame_OnLoad()

   --count how many frames we have.
   ChatBox_frameCount = ChatBox_frameCount + 1

   if (not ChatBox_isLoaded) then

      ChatBox_isLoaded = true;

      --vars loaded!!
      this:RegisterEvent("VARIABLES_LOADED")
      --anything to do with vars put there!! DOH!!!

      --to scan the guild and friend and wholist thing for class names.
      this:RegisterEvent("GUILD_ROSTER_UPDATE");
      this:RegisterEvent("FRIENDLIST_UPDATE");
      this:RegisterEvent("WHO_LIST_UPDATE");

      --hooks for the chat link relinker into other chat channels
		CB_Orig_SendChatMessage = SendChatMessage;
		SendChatMessage         = ChatBox_SendChatMessage;

      -- Hooks for the enchantments
      CB_Orig_SetItemRef = SetItemRef;
      SetItemRef         = ChatBox_SetItemRef;

      CB_Orig_ChatFrame_OnEvent = ChatFrame_OnEvent;
      ChatFrame_OnEvent         = ChatBox_ChatFrame_OnEvent;

      -- Hook gossip window
      CB_Orig_GossipFrame_OnEvent = GossipFrame_OnEvent;
      GossipFrame_OnEvent         = ChatBox_Gossip;

      -- hooks to do my own player link menu.
      CB_Orig_UnitPopup_HideButtons  = UnitPopup_HideButtons;
      UnitPopup_HideButtons          = ChatBox_UnitPopup_HideButtons;

      CB_Orig_UnitPopup_OnClick     = UnitPopup_OnClick;
      UnitPopup_OnClick     = ChatBox_UnitPopup_OnClick;

      --register the slash commands.
      SlashCmdList["CHATBOX"] = ChatBox_Commands;
      SLASH_CHATBOX1 = "/chatbox";
      SLASH_CHATBOX2 = "/cb";

      -- Enable slash commands
      SlashCmdList["TIMESTAMP"] = ChatBox_TimeStamp_Commands;
      SLASH_TIMESTAMP1 = "/timestamp";
      SLASH_TIMESTAMP2 = "/ts";

      -- Enable slash commands
      SlashCmdList["PLM"] = ChatBox_PLM_Commands;
      SLASH_PLM1 = "/playerlinkmenu";
      SLASH_PLM2 = "/plm";


      --telltarget (for those who want it..)
      SlashCmdList["TELLTARGET"] = ChatBox_TT_Commands;
      SLASH_TELLTARGET1 = "/telltarget";
      SLASH_TELLTARGET2 = "/tellt";
      SLASH_TELLTARGET3 = "/tt";

      --clear all the chatframe boxes
      SlashCmdList["CLEARCHATCOMMAND"] = ChatBox_ClearChat_SlashCommands;
		SLASH_CLEARCHATCOMMAND1 = "/clearChat";
      SLASH_CLEARCHATCOMMAND2 = "/clear";
      SLASH_CLEARCHATCOMMAND3 = "/clr";
   end
end


----------------------------------------------------------------------------------------------------
-- ChatBox ClearChat Slash Commands
----------------------------------------------------------------------------------------------------
function ChatBox_ClearChat_SlashCommands(msg)
	local command = string.lower(msg);
	if (string.lower(msg) == "" ) then
   	local chatFrame;
   	for i = 1, 7 do
   		chatFrame = getglobal("ChatFrame"..i);
   		if( (chatFrame ~= nil) and chatFrame:IsVisible() ) then
   			chatFrame:Clear();
   		end
   	end
   end
end

----------------------------------------------------------------------------------------------------
-- TellTarget
----------------------------------------------------------------------------------------------------

-- Handles a slash command
function ChatBox_TT_Commands(msg)
   local target = UnitName('target');
   if target == nil then
      msg = "You need to have someone targeted!";
      target = UnitName("player");
   end
   SendChatMessage(msg, "WHISPER", this.language, target)
end

----------------------------------------------------------------------------------------------------
-- Misc functions
----------------------------------------------------------------------------------------------------

function ChatBox_specialSendWho(name)
   SendWho("n-"..name)
end

function ChatBox_check(state)
   if state then
      if state == true then
         return CB_ON
      else
         return tostring(state)
      end
   else
      return CB_OFF
   end
end

function ChatBox_check_color()
	if ( ChatBox.TimeStamp_Settings.color ) then
		--TODO double check.
		return "|cff" .. string.lower(ChatBox.TimeStamp_Settings.color) .. CB_TS_COLOR .. "|r";
   else
      return RED .. CB_OFF
   end
end


function cb_display(output)
   local anyoutput = false;

   -- IF the output ends without a carriage return but has some in it, the entire message will not display
   for msg in string.gfind(output,"(.+)\n") do
      if (msg~=nil) then
         anyoutput = true;
      end
      DEFAULT_CHAT_FRAME:AddMessage(msg);
   end

   -- This basically means that there were no carriage returns
   if (not anyoutput) then
      DEFAULT_CHAT_FRAME:AddMessage(output);
   end
end

function ChatBox_SetSticky()
   --Extends the "default to last channel" <Enter> keypress to include numbered and (possible) whisper channels.
   if ChatBox.setSticky then
      --ChatTypeInfo["WHISPER"].sticky = 1;
      ChatTypeInfo["CHANNEL"].sticky = 1;
      ChatTypeInfo["OFFICER"].sticky = 1;
   else
      --ChatTypeInfo["WHISPER"].sticky = 0;
      ChatTypeInfo["CHANNEL"].sticky = 0;
      ChatTypeInfo["OFFICER"].sticky = 0;
   end
end

function ChatBox_SetStrings()
   ---- Changing current global strings to more suitable ones ----
   CHAT_FLAG_AFK = "[AFK] ";
   CHAT_FLAG_DND = "[DND] ";
   CHAT_FLAG_GM = "[GM] ";
   CHAT_WHISPER_GET = "From %s:\32"; -- Whisper from player %s
   CHAT_WHISPER_INFORM_GET = "To %s:\32"; -- A whisper already sent to player %s

   if ChatBox.longStrings then
      CHAT_GUILD_GET = "[Guild] %s:\32"; -- Guild message from player %s
      CHAT_RAID_GET = "[Raid] %s:\32";   -- Raid message from player %s
      CHAT_PARTY_GET = "[Party] %s:\32"; -- Party message from player %s
      CHAT_OFFICER_GET = "[Officer] %s:\32"; -- Officer message from player %s
   elseif ChatBox.shortStrings then
      CHAT_GUILD_GET = "[G] %s:\32"; -- Guild message from player %s
      CHAT_RAID_GET = "[R] %s:\32";   -- Raid message from player %s
      CHAT_PARTY_GET = "[P] %s:\32"; -- Party message from player %s
      CHAT_OFFICER_GET = "[O] %s:\32"; -- Officer message from player %s
   else
      CHAT_GUILD_GET = "%s:\32"; -- Guild message from player %s
      CHAT_RAID_GET = "%s:\32";  -- Raid message from player %s
      CHAT_PARTY_GET = "%s:\32"; -- Party message from player %s
      CHAT_OFFICER_GET = "%s:\32"; -- Officer message from player %s
   end
end

function SetupPLM()

   --NOTE: I should be insterting, removing these from the tables instead.... so it will work with OTHER mods, and be friendly!
   if ChatBox.plm then
      UnitPopupMenus["PARTY"] = {"WHO", "WHISPER", "TARGET", "PROMOTE", "LOOT_PROMOTE", "UNINVITE", "INSPECT", "TRADE", "FOLLOW", "DUEL", "ADDFRIEND", "REMOVEFRIEND", "CANCEL" };
      UnitPopupMenus["PLAYER"] = {"WHO", "WHISPER", "INSPECT", "INVITE", "TARGET", "IGNORE", "UNIGNORE", "TRADE", "FOLLOW", "DUEL", "ADDFRIEND", "REMOVEFRIEND", "CANCEL" };
      UnitPopupMenus["RAID"] = { "RAID_LEADER", "RAID_PROMOTE", "RAID_DEMOTE", "RAID_REMOVE", "CANCEL" };
      UnitPopupMenus["FRIEND"] = { "WHO", "WHISPER", "INVITE", "TARGET", "IGNORE", "UNIGNORE", "GUILD_PROMOTE", "GUILD_LEAVE", "ADDFRIEND", "REMOVEFRIEND", "CANCEL" };
   else
      UnitPopupMenus["PARTY"] = { "WHISPER", "PROMOTE", "LOOT_PROMOTE", "UNINVITE", "INSPECT", "TRADE", "FOLLOW", "DUEL", "CANCEL" };
      UnitPopupMenus["PLAYER"] = { "WHISPER", "INSPECT", "INVITE", "TRADE", "FOLLOW", "DUEL", "CANCEL" };
      UnitPopupMenus["RAID"] = { "RAID_LEADER", "RAID_PROMOTE", "RAID_DEMOTE", "RAID_REMOVE", "CANCEL" };
      UnitPopupMenus["FRIEND"] = { "WHISPER", "INVITE", "GUILD_PROMOTE", "GUILD_LEAVE", "CANCEL" };
   end

   --Re-Set up alt key functionality
   if ( ChatBox.plm_alt_name == WHO ) then
   ChatBox.plm_alt = ChatBox_specialSendWho;
   elseif ( ChatBox.plm_alt_name == CB_TARGET) then
   ChatBox.plm_alt = TargetByName;
   elseif ( ChatBox.plm_alt_name == WHISPER ) then
   ChatBox.plm_alt = ChatFrame_SendTell;
   elseif ( ChatBox.plm_alt_name == PARTY_INVITE ) then
   ChatBox.plm_alt = InviteByName;
   elseif ( ChatBox.plm_alt_name == IGNORE ) then
   ChatBox.plm_alt = AddIgnore;
   end


   --Re-Set up the shift key functionality
   if ( ChatBox.plm_shift_name == WHO ) then
   ChatBox.plm_shift = ChatBox_specialSendWho;
   elseif ( ChatBox.plm_shift_name == CB_TARGET ) then
   ChatBox.plm_shift = TargetByName;
   elseif ( ChatBox.plm_shift_name == WHISPER ) then
   ChatBox.plm_shift = ChatFrame_SendTell;
   elseif ( ChatBox.plm_shift_name == PARTY_INVITE ) then
   ChatBox.plm_shift = InviteByName;
   elseif ( ChatBox.plm_shift_name == IGNORE ) then
   ChatBox.plm_shift = AddIgnore;
   end

   --Re-Set up change the control key functionality
   if ( ChatBox.plm_ctrl_name == WHO ) then
   ChatBox.plm_ctrl = ChatBox_specialSendWho;
   elseif ( ChatBox.plm_ctrl_name == CB_TARGET ) then
   ChatBox.plm_ctrl = TargetByName;
   elseif ( ChatBox.plm_ctrl_name == WHISPER ) then
   ChatBox.plm_ctrl = ChatFrame_SendTell;
   elseif ( ChatBox.plm_ctrl_name == PARTY_INVITE ) then
   ChatBox.plm_ctrl = InviteByName;
   elseif ( ChatBox.plm_ctrl_name == IGNORE ) then
   ChatBox.plm_ctrl = AddIgnore;
   end
end


function ChatBox_HashString(name)
  local hash = 17;
  for i = 1, string.len(name) do
    hash = hash * 37 * string.byte(name, i);
  end
  return hash;
end

----------------------------------------------------------------------------------------------------
-- ChatBox_AddMessage (for timestamp and shortening the channel name)
----------------------------------------------------------------------------------------------------
function ChatBox_AddMessage(this, msg, r, g, b, id)

   if (not msg) then
      return;
   end

   --remove chuck norris spam. It's annoying as hell.
   if (msg ~= nil and ChatBox.chuckNorris) then
      if string.find(string.lower(msg), "%s*chu?c?k?%s*nor?r?i?s?") and not (string.find(msg, CB_NORRIS_HELP_TEXT) or string.find(msg, CB_NORRIS_TEXT)) then
         if ChatBox.chuckNorris == CB_VERBOSE then
            msg = DRKBLU .. "[Something stupid about Chuck Norris]";
         else
            return;
         end
      end
   end

   -- URL detection (from SCCN)
   if (msg ~= nil) then
	   local urlFound = nil;

      local function GetURL(before, URL, after)
      	urlFound = true;
      	return before .. YEL .. "|Href:" .. URL .. "|h[".. URL .."]|h|r" ..  after;
      end

   	-- numeric IP's  123.123.123.123:12345
   	if ( not urlFound ) then
   	   msg = string.gsub(msg, "(%s?)(%d%d?%d?%.%d%d?%d?%.%d%d?%d?%.%d%d?%d?:%d%d?%d?%d?%d?)(%s?)", GetURL);
   	end;
   	-- numeric IP's  123.123.123.123
   	if ( not urlFound ) then
   	   msg = string.gsub(msg, "(%s?)(%d%d?%d?%.%d%d?%d?%.%d%d?%d?%.%d%d?%d?)(%s?)", GetURL);
   	end;
   	-- TeamSpeak like IP's sub.domain.org:12345  or domain.com:123
   	if ( not urlFound ) then
   	    msg = string.gsub(msg, "(%s?)([%w_-]+%.?[%w_-]+%.[%w_-]+:%d%d%d?%d?%d?)(%s?)", GetURL);
   	end;
   	-- complete http urls
   	if ( not urlFound ) then
   	   msg = string.gsub(msg, "(%s?)(%a+://[%w_/%.%?%%=~&-]+)(%s?)", GetURL);
   	end;
   	-- www.URL.com
   	if ( not urlFound ) then
   	    msg = string.gsub(msg, "(%s?)(www%.[%w_/%.%?%%=~&-]+)(%s?)", GetURL);
   	end;
   	-- test@test.com
      if ( not urlFound ) then
         msg = string.gsub(msg, "(%s?)([_%w-%.~-]+@[_%w-]+%.[_%w-%.]+)(%s?)", GetURL);
      end;
   end

   -- Change LookingForGroup channel name to LFG
   if ChatBox.shortLFG then
      if (msg) then
         msg = string.gsub(msg, CB_LOOKINGFORGROUPCOMM, CB_SHORTLFGCOMM);
      end
   end

   --truncate channel names over 8 chars
   if ChatBox.truncLength and ChatBox.truncLength < 21 then
      if (msg ~= nil) then
         msg = string.gsub(msg, "%b[]",
            function(s)
               if string.find(s, "^%[%d") then
                  s = string.gsub(s, "%a+",
                     function (s)
                        return string.sub(s, 1, ChatBox.truncLength)
                     end)
                  return s
               else
                  return s;
               end
            end, 1 )
      end
   end

   -- Translate CLINKs back into normal links on incoming messages. (from...CLINK!)
   if (ChatBox.CLINK and msg ~= nil) then
   	msg = ChatBox_Decompose (msg)
   end

   --do the name coloring thing here! (sorta my own thing..)
   if (msg ~= nil and (this and getglobal(this:GetName() .. "TabText") and not string.find(getglobal(this:GetName() .. "TabText"):GetText(), "Combat")) and ( ChatBox.colorNames or ChatBox.colorRandom) ) then
      local _, _, _, name, _, type = string.find(msg, "(|Hplayer:.-|h%[)(%a+)(%])(.*:%s)");

      if name and not string.find(name, "%s") and
         (type and not (string.find(type, CB_SAY) or string.find(type, CB_YELL)) ) then
         msg = string.gsub(msg, "(|Hplayer:.-|h%[)([%w]+)(%])", "%1" .. ChatBox_SetNameColor(nil, name) .. "%2|r%3");
      end
   end

   -- Add the ChatBox_TimeStamp (TimeStamp stuff taken from TimeStamp!)
   if ( ChatBox.TimeStamp_Settings.frames[this:GetName()] == CB_ON ) then

		-- Generate the timestamp
      local stamp = date(ChatBox.TimeStamp_Settings.format);

		if (ChatBox.TimeStamp_Settings.color) then
			-- The timestamp should be colored
		   msg = "|cff" .. string.lower(ChatBox.TimeStamp_Settings.color) .. stamp .. END .. msg;
		else
			-- The timestamp should use the same color as the message
			msg = stamp .. " " .. msg;
		end
	end

   this:Original_AddMessage(msg, r, g, b, id); --call the real AddMessage function
end



----------------------------------------------------------------------------------------------------
-- ChatBox Tell Target (from TellTrack)
----------------------------------------------------------------------------------------------------
function ChatBox_TargetTell(name)
	if name then
	   ChatFrame_SendTell(name);
	end
end


----------------------------------------------------------------------------------------------------
-- Player Link Menu Woot! TONS smaller (only 4k) than every OTHER ONE OUT THERE!! more efficient too!
----------------------------------------------------------------------------------------------------

function ChatBox_UnitPopup_HideButtons()
	CB_Orig_UnitPopup_HideButtons();

	local dropdownMenu = getglobal(UIDROPDOWNMENU_INIT_MENU);

	for index, value in UnitPopupMenus[dropdownMenu.which] do

		if ( value == "WHO" or value == "TARGET" ) then
			if ( dropdownMenu.name == UnitName("player") ) then
				UnitPopupShown[index] = 0;
			else
			   UnitPopupShown[index] = 1;
			end
	   elseif ( value == "IGNORE" ) then
	      --kinda backasswards, but it works.
	      if ( dropdownMenu.name == UnitName("player") or ChatBox_isOnIgnoreList(dropdownMenu.name) ) then
				UnitPopupShown[index] = 0;
			else
			   UnitPopupShown[index] = 1;
			end
	   elseif ( value == "UNIGNORE" ) then
	      if ( dropdownMenu.name == UnitName("player") or not ChatBox_isOnIgnoreList(dropdownMenu.name) ) then
				UnitPopupShown[index] = 0;
			else
			   UnitPopupShown[index] = 1;
			end
	   elseif ( value == "ADDFRIEND" ) then
	      if ( dropdownMenu.name == UnitName("player") or ChatBox_isPlayerFriend(dropdownMenu.name) ) then
				UnitPopupShown[index] = 0;
			else
			   UnitPopupShown[index] = 1;
			end
	   elseif ( value == "REMOVEFRIEND" ) then
	      if ( dropdownMenu.name == UnitName("player") or not ChatBox_isPlayerFriend(dropdownMenu.name) ) then
				UnitPopupShown[index] = 0;
			else
			   UnitPopupShown[index] = 1;
			end
	   end
	end
end

function ChatBox_UnitPopup_OnClick()
	local index = this.value;
	local dropdownFrame = getglobal(UIDROPDOWNMENU_INIT_MENU);
	local button = UnitPopupMenus[this.owner][index];
	local unit = dropdownFrame.unit;
	local name = dropdownFrame.name;
   local notFound = false;

	if ( button == "WHO" ) then
		SendWho("n-"..name);
	elseif ( button == "TARGET" ) then
		TargetByName(name);
	elseif ( button == "IGNORE" ) then
   	AddIgnore(name);
   elseif ( button == "UNIGNORE" ) then
		DelIgnore(name);
   elseif ( button == "ADDFRIEND" ) then
		AddFriend(name);
	elseif ( button == "REMOVEFRIEND" ) then
		RemoveFriend(name);
	else
	   notFound = true;
	end

	if notFound then
		CB_Orig_UnitPopup_OnClick();
	else
	   PlaySound("UChatScrollButton");
	end
end

function ChatBox_isOnIgnoreList(checkname)
	local ignores = GetNumIgnores();

	for i=1, ignores do
		local name = GetIgnoreName(i);
		if(name == checkname) then
		   return true;
		end
	end

	return false;
end

function ChatBox_isPlayerFriend(checkname)
	local friends = GetNumFriends();
	for i=1, friends do
		local name, level, class, area, connected = GetFriendInfo(i);
		if(name == checkname) then
		   return true;
      end
	end

	return false;
end


----------------------------------------------------------------------------------------------------
-- AutoSelect
----------------------------------------------------------------------------------------------------

function ChatBox_Gossip()
    if( event == "GOSSIP_SHOW" and ChatBox.hideGossip and not IsControlKeyDown() and not GetGossipAvailableQuests() and not GetGossipActiveQuests() ) then
      if(ChatBox_Gossip_Action()) then
         return;
      end
    end
    CB_Orig_GossipFrame_OnEvent();
end

function ChatBox_Gossip_Action()
    local list = {GetGossipOptions()};
    for i = 2,getn(list),2 do
      if(ChatBox_actions[list[i]]) then
        SelectGossipOption(i/2);
        return true;
      end
    end
end

----------------------------------------------------------------------------------------------------
-- Custom Set ItemRef.
----------------------------------------------------------------------------------------------------

-- called on hyperlink enter
function ChatBox_OnHyperlinkEnter()
   if (CB_Orig_OnHyperlinkEnter_Table and CB_Orig_OnHyperlinkEnter_Table[this:GetName()]) then
		CB_Orig_OnHyperlinkEnter_Table[this:GetName()]();
	end

	local link = arg1;
	local text = arg2;
	local button = arg3;

   if not (IsShiftKeyDown() or IsControlKeyDown() or IsAltKeyDown()) then
      return;
   end

	if ( string.find(link, itemlinkformat) ) then
		ShowUIPanel(GameTooltip);
		GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR");
		GameTooltip:SetHyperlink(link);
	elseif string.find(link, speciallinkformat) then
		for name, msg in string.gfind( link, speciallinkformat ) do
         ChatBox_lastName = name;

         ShowUIPanel(GameTooltip);

         GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR");

         GameTooltip:ClearLines();

         if (not IsControlKeyDown() ) then
            msg = formatText(msg)
         end

         GameTooltip:AddLine( " ", 0.5, 0.5, 1 );
         GameTooltip:AddLine( name );
         GameTooltip:AddLine( msg, 1, 1, 1, 1, 1 );

         GameTooltip:Show();
      end
   elseif string.find(link, portallinkformat) then
      for name, msg in string.gfind( link, portallinkformat ) do
         ChatBox_lastName = name;

         ShowUIPanel(GameTooltip);

         GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR");

         GameTooltip:ClearLines();

         GameTooltip:AddLine( " ", 0.5, 0.5, 1 );
         GameTooltip:AddLine( name );
         GameTooltip:AddLine( msg, 1, 1, 1, 1, 1 );

         GameTooltip:Show();
   	end
   end
end


-- called on hyperlink leave
function ChatBox_OnHyperlinkHide()
	if (CB_Orig_OnHyperlinkLeave_Table[this:GetName()]) then
		CB_Orig_OnHyperlinkLeave_Table[this:GetName()]();
	end

	HideUIPanel(GameTooltip);
end


function ChatBox_SetItemRef(link, text, button)

   if ( IsControlKeyDown() and string.find(link, itemlinkformat) ) then
      DressUpItemLink(text);
      return;
   elseif ( IsShiftKeyDown() and ChatFrameEditBox:IsVisible() and string.find(link, itemlinkformat) ) then
      ChatFrameEditBox:Insert(text);
      return;
   elseif ( IsShiftKeyDown() and MacroFrameText and MacroFrameText:IsVisible() and string.find(link, itemlinkformat) ) then
      MacroFrameText:Insert(text);
      return;
   end

   if ( string.find(link, playerlinkformat) ) then
		local name = strsub(link, 8);
		if ( name and (strlen(name) > 0) ) then
			name = gsub(name, "([^%s]*)%s+([^%s]*)%s+([^%s]*)", "%3");
			name = gsub(name, "([^%s]*)%s+([^%s]*)", "%2");

         if ( button == "RightButton" ) then
				FriendsFrame_ShowDropdown(name, 1);
            return;
         end
			if ( IsShiftKeyDown() ) then
				-- execute a function action
            if type(ChatBox.plm_shift) == 'function' then
               ChatBox.plm_shift(name);
               return;
            end

         elseif ( IsControlKeyDown() )then
            -- execute a function action
            if type(ChatBox.plm_ctrl) == 'function' then
               ChatBox.plm_ctrl(name);
               return;
            end

         elseif ( IsAltKeyDown() ) then
            -- execute a function action
            if type(ChatBox.plm_alt) == 'function' then
               ChatBox.plm_alt(name);
               return;
            end

         else
				ChatFrame_SendTell(name);
				return;
         end
		end
		return;
	end

   --this is to setup the urlCopy functionality.
   for url in string.gfind( text, hyperlinkformat ) do
      getglobal( "ChatBoxHyperlinkerFormEditBox" ):SetText( url );
      ChatBoxHyperlinkerForm:Show();
      return;
   end

   --this is to setup the enchanter spam link...
   for name, msg in string.gfind( link, speciallinkformat ) do
      if( ItemRefTooltip:IsVisible() and ChatBox_lastName and ChatBox_lastName == name ) then

         HideUIPanel(ItemRefTooltip);
         ChatBox_lastName = nil;

      else
         ChatBox_lastName = name;

         ShowUIPanel(ItemRefTooltip);
         if ( not ItemRefTooltip:IsVisible() ) then
            ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE");
         end

         ItemRefTooltip:ClearLines();

         if (not IsControlKeyDown() ) then
            msg = formatText(msg)
         end

         ItemRefTooltip:AddLine( " ", 0.5, 0.5, 1 );
         ItemRefTooltip:AddLine( name );
         ItemRefTooltip:AddLine( msg, 1, 1, 1, 1, 1 );

         ItemRefTooltip:Show();
      end
      return
   end

   --this is to setup the guild spam link...
   for name, msg in string.gfind( link, guildlinkformat ) do
      if( ItemRefTooltip:IsVisible() and ChatBox_lastName and ChatBox_lastName == name ) then

         HideUIPanel(ItemRefTooltip);
         ChatBox_lastName = nil;

      else
         ChatBox_lastName = name;

         ShowUIPanel(ItemRefTooltip);
         if ( not ItemRefTooltip:IsVisible() ) then
            ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE");
         end

         ItemRefTooltip:ClearLines();

         ItemRefTooltip:AddLine( " ", 0.5, 0.5, 1 );
         ItemRefTooltip:AddLine( name );
         ItemRefTooltip:AddLine( msg, 1, 1, 1, 1, 1 );

         ItemRefTooltip:Show();
      end
      return
   end

   --this is to special links (portals, xmutes, etc...)
   for name, msg in string.gfind( link, portallinkformat ) do
      if( ItemRefTooltip:IsVisible() and ChatBox_lastName and ChatBox_lastName == name ) then

         HideUIPanel(ItemRefTooltip);
         ChatBox_lastName = nil;

      else
         ChatBox_lastName = name;

         ShowUIPanel(ItemRefTooltip);
         if ( not ItemRefTooltip:IsVisible() ) then
            ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE");
         end

         ItemRefTooltip:ClearLines();

         ItemRefTooltip:AddLine( " ", 0.5, 0.5, 1 );
         ItemRefTooltip:AddLine( name );
         ItemRefTooltip:AddLine( msg, 1, 1, 1, 1, 1 );

         ItemRefTooltip:Show();
      end
      return
   end

   ChatBox_lastName = nil;
   --this still around for legacy reasons (other mods might also have hooks in this...)
   CB_Orig_SetItemRef(link, text, button);
end


function ChatBox_ChatFrame_OnEvent()

   --does the whole name color thing.
   if ( ChatBox.colorNames and strsub(event, 1, 8) == "CHAT_MSG" and arg2) then
      ChatBox_SetNameColor(event, arg2);
   end

   --saves who I talked to last (for tell target)
   if ( event == "CHAT_MSG_WHISPER_INFORM" ) then
      ChatBox_LastTell = arg2;
   end


--hook this function, so I can disable the flashing of tabs?
   --   FCF_FlashTab();


   --if we haven't already done so, hook the AddMessage function
   if(not this.Original_AddMessage) then
      this.Original_AddMessage = this.AddMessage;
      this.AddMessage = ChatBox_AddMessage;
   end

   if ( (event == "CHAT_MSG_CHANNEL") or (event == "CHAT_MSG_SAY") or (event == "CHAT_MSG_YELL") and not (string.find(arg9, "LookingForGroup") or string.find(arg9, "Defense")) ) then
      --this is an ENCHANT... (from Enchanter Ad Shrinker by sacha)
      --need to have a check if there are any other links in the msg. it will screw up if there are.
      if ( ChatBox_IsEnch(arg1) ) then
         arg1 = string.gsub(arg1, "|", "")

         arg1 = string.format(linkstring, BLU, arg2, arg1, CB_SPAM_ENCHANTMENTS)

         if ((string.find(string.lower(arg1), CB_SPAM_WTS)) or (string.find(string.lower(arg1), CB_SPAM_ENCHANTING))) then
            arg1 = string.upper(CB_SPAM_WTS).." "..arg1
         elseif ((string.find(string.lower(arg1), CB_SPAM_WTB)) or (string.find(string.lower(arg1), CB_SPAM_BUY)) or (string.find(string.lower(arg1), CB_SPAM_LOOKINGFOR))) then
            arg1 = string.upper(CB_SPAM_WTB).." "..arg1
         end
      --is this GUILD spam???
      --if there are item links in the text, it messes up.
      elseif ( ChatBox_IsGuild(arg1) ) then
         arg1 = string.format(guildstring, ORN, arg2, arg1, CB_SPAM_GUILD)
      else
         --lets color certain combination of words. (portals, lockpicks, etc...)
         for color,wordset in colorsubs do
            for word,sub in wordset do
               local a, b = string.find(string.lower(arg1), string.lower(word));
               if (a and b) then
                  local _, _, _, a1 = string.find(arg1, "xhenc:(.+)<XH>(.+)");
                  if (not a1) then
                     a1 = string.gsub(arg1, itemcapstr, "[%1]");
                     a1 = string.gsub(a1, "|", "")
                     arg1 = string.sub(arg1, 1, a-1).. string.format(linkstring2, color, arg2, a1, sub).. string.sub(arg1, b+1);
                  end
               end
            end
         end
      end
   end

   CB_Orig_ChatFrame_OnEvent(event)
end


function ChatBox_IsEnch(str)

   if string.find(str, itemlinkformat) then
      return false;
   end

   local totalFound = 0
   local numFound = 0
   local text = string.lower(str)

--   text = string.gsub(text, "|hitem:%d+:%d+:%d+:%d+|h[[][^]]+[]]|h", "")
   for key1,val1 in ChatBoxWords do
     for key2,val2 in val1 do
        if (string.find(text, val2)) then
            text, numFound = string.gsub(text, val2, " ")
            totalFound = totalFound + numFound
         end
      end
   end

   if ChatBox.throttle and totalFound >= ChatBox.throttle then
      return true
   else
      return false
   end
end

function ChatBox_IsGuild(str)

   if string.find(str, itemlinkformat) then
      return false;
   end

   local totalFound = 0
   local numFound = 0
   local text = string.lower(str)

--   text = string.gsub(text, "|hitem:%d+:%d+:%d+:%d+|h[[][^]]+[]]|h", "")
   for key1,val1 in ChatBoxGuildWords do
     if (string.find(text, val1)) then
         text, numFound = string.gsub(text, val1, " ")
         totalFound = totalFound + numFound
      end
   end

   if ChatBox.gthrottle and totalFound >= ChatBox.gthrottle then
      return true;
   else
      return false;
   end
end

function ChatBox_SetNameColor(event, arg2)
   --the only time information is added to my DBase, is with party/raid events.
   if ( event ) then
      if ( event == "CHAT_MSG_PARTY" ) then
         local numParty = GetNumPartyMembers();
         for i=1, numParty do
      		if ( UnitName("party"..i) == arg2 ) then
      			localizedClass, englishClass = UnitClass("party"..i);
      			ChatBox_ClassData(arg2, englishClass);
      		elseif ( UnitName("player") == arg2 ) then
      		   localizedClass, englishClass = UnitClass("player");
      			ChatBox_ClassData(arg2, englishClass);
      		end
      	end
      end
      if ( event == "CHAT_MSG_RAID" ) then
      	for i=1, MAX_RAID_MEMBERS do
      		local name, _, _, _, class = GetRaidRosterInfo(i);
      		if ( name and name == arg2 ) then
      			ChatBox_ClassData(arg2, class);
      		end
      	end
      end
   else
      return ChatBox_ClassData(arg2);
   end
end

function ChatBox_ClassData(arg2, class )

   if arg2 then
      arg2 = string.upper(arg2);
   end

   if class then
      class = string.upper(class);
   end

   if not ChatBox then
        cb_display(RED.."Error #A1 in ClassData! " .. WHT .. "Please report this in the ChatBox forums at ui.worldofwar.net!!");
        ChatBox = {};
      end

	if not ChatBox_Names then
	   ChatBox_Names = {};
	end

	if not arg2 then
	   return "";
	end

	-- this retrieves the data.
	if not class then
   	--this pulls the class color from the dbase!
   	if ChatBox.colorNames then
      	for name, color in ChatBox_Names do
      	   if name == arg2 then
      	      return color;
      	   end
      	end
      end
   	-- then we can assign them random colors!
   	if ChatBox.colorRandom then --(From CleanChat)
         if not usedNames[arg2] then
            local hash = ChatBox_HashString(arg2);

            local rgb = { math.floor(math.mod(hash, 255)),
                         math.floor(math.mod(hash * 3, 255)),
                         math.floor(math.mod(hash / 17, 255)) };

            local i;

            -- Make color bright if to dark
            if rgb[1] < 190 and rgb[2] < 190 and rgb[3] < 190 then
               i = math.mod(hash, 3) + 1;
               while rgb[i] < 190 do
                  rgb[i] = rgb[i] + 60;
               end
            end

            local color = "|cff" .. string.lower(string.format("%02X%02X%02X", rgb[1], rgb[2], rgb[3] ));

            i = 1;
            -- max five loops to find new color, otherwise use default as fallback
            while usedColors[color] or (  color == ChatBox_GetClassColor(CB_CLASS_MAGE) or
                                          color == ChatBox_GetClassColor(CB_CLASS_WARLOCK) or
                                          color == ChatBox_GetClassColor(CB_CLASS_PRIEST) or
                                          color == ChatBox_GetClassColor(CB_CLASS_DRUID) or
                                          color == ChatBox_GetClassColor(CB_CLASS_SHAMAN) or
                                          color == ChatBox_GetClassColor(CB_CLASS_PALADIN) or
                                          color == ChatBox_GetClassColor(CB_CLASS_ROGUE) or
                                          color == ChatBox_GetClassColor(CB_CLASS_HUNTER) or
                                          color == ChatBox_GetClassColor(CB_CLASS_WARRIOR))
                  and i < 6 do
               color = "|cff" .. string.lower(string.format("%02X%02X%02X", rgb[1], rgb[2], rgb[3] ));
               i = i + 1;
            end

            usedColors[color] = true;

            --now color their name.
            usedNames[arg2] = color
         end
         return usedNames[arg2];
      end
   else
      --have to check if I already have the name there...
      local found;
      for name, color in ChatBox_Names do
   	   if name == arg2 then
   	      found = true;
   	   end
   	end
      --only get here if I don't find the name in my dbase.
      if not found then
         local color = ChatBox_GetClassColor( class );
         ChatBox_Names[arg2] = color;
      end
   end

   -- never retrieved a color, so...
   return "";
end


function ChatBox_GetClassColor( class )

   --class is CAPS!!
   --from IdentiChat.
	local classcolor = "";
	--coloring class text
	if (class == CB_CLASS_MAGE) then
		classcolor = "|cff7fffff";
	elseif (class == CB_CLASS_WARLOCK) then
		classcolor = "|cff7f4ce5";
	elseif (class == CB_CLASS_PRIEST) then
		classcolor = "|cffcccccc";
	elseif (class == CB_CLASS_DRUID) then
		classcolor = "|cffe59919";
	elseif (class == CB_CLASS_SHAMAN) then
		classcolor = "|cffe566b2";
	elseif (class == CB_CLASS_PALADIN) then
		classcolor = "|cffff6699";
	elseif (class == CB_CLASS_ROGUE) then
		classcolor = "|cffe5e519";
	elseif (class == CB_CLASS_HUNTER) then
		classcolor = "|cff19cc19";
	elseif (class == CB_CLASS_WARRIOR) then
		classcolor = "|cffb27f4c";
	end
	return classcolor;
end



function formatText(msg)

   --DEFAULT_CHAT_FRAME:AddMessage(":"..msg)

   msg = string.lower(msg);

   msg = string.gsub(msg, ":", "")
   msg = string.gsub(msg, "=", "")

   --this gray's out the price of the enchant (or tries to)
   msg = string.gsub(msg, "%b()",
      function(s)
         if string.find(s, "%d+") then
            return GRY..s..END;
         else
            return s;
         end
      end )

   --this removes all double spaces.
   msg = string.gsub(msg, "%s+", " ");


   --have to seperate letters and parenthesis
   --do it for letter as a prefix to the paren.
   start_search = 1
   for w in string.gfind(msg, "%(") do
      local a, b = string.find(msg, "%w%(", start_search);
      if a and b then
         msg = string.sub(msg, 1, b-1) .. " " .. string.sub(msg, b, string.len(msg));
         start_search = b+1;
      end
   end
   --do it for letter as a prefix to the paren.
   start_search = 1;
   for w in string.gfind(msg, "%)") do
      local a, b = string.find(msg, "%)%w", start_search);
      if a and b then
         msg = string.sub(msg, 1, a) .. " " .. string.sub(msg, a+1, string.len(msg));
         start_search = b+1;
      end
   end

   newmsg = "";

   for w1, word, w4, space in string.gfind(msg, "(%p*)(%w+)(%p*)(%s?)") do

      --DEFAULT_CHAT_FRAME:AddMessage(":"..w1..word..w4)
      --DEFAULT_CHAT_FRAME:AddMessage(":"..word)

      --have to seperate letters and numbers *except for "g", "h", etc...
      --do it for number as a prefix.
      for n, w in string.gfind(word, "(%d+)(%a+)") do
         if not string.find(word, "cff") then
            if string.len(w) > 1 then
               word = n .. " " .. w;
            end
         end
      end
      --do it for number as a suffix.
      for w, n in string.gfind(word, "(%a+)(%d+)") do
         if not string.find(word, "cff") then
            if string.len(w) > 1 then
               word = w .. " " .. n;
            end
         end
      end

      for key1,val1 in ChatBoxWords.equip do
         local temp_word = string.lower(val1);
         local a, b = string.find(word, temp_word);

         if a and b then
            if string.sub(word, a, b+1) == temp_word .. "s" then
               temp_word = temp_word .. "s";
            end

         word = string.gsub(word, temp_word, ORN.."\n\n"..string.upper(temp_word)..": "..END);
         end

      end

      for key1,val1 in ChatBoxWords.stats do
         if word == val1 then
            word = string.gsub(word, val1, YEL..val1..END);
         end
      end

      for key1,val1 in ChatBoxWords.riding do
         if word == val1 then
            word = string.gsub(word, val1, GRN..val1..END);
         end
      end

      for key1,val1 in ChatBoxWords.bonusdmg do
         word = string.gsub(word, val1, RED..val1..END);
      end

      newmsg = newmsg..w1..word..w4..space;
   end

   return newmsg;
end