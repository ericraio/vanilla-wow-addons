--
-- Define the basic styles.
--
local ConfabStyles = {
[0] = {
   info = CONFAB_STYLE1_INFO,
   style = 0,
   docked = true,
   dockpoints = {
     [0] = {
        point = "TOPLEFT", 
        relto = "ChatFrame1",
	relpoint = "BOTTOMLEFT",
	xoff = -5,
	yoff = -1
     },
     [1] = {
        point = "TOPRIGHT",
	relto = "ChatFrame1",
	relpoint = "BOTTOMRIGHT",
	xoff = 5,
	yoff = -1
     }
   }
},
[1] = {
   info = CONFAB_STYLE2_INFO,
   style = 1,
   autohide = true,   -- overrides the /conflag autohide option
   docked = true,
   dockpoints = {
     [0] = {
        point = "BOTTOMLEFT", 
        relto = "ChatFrame1",
	relpoint = "BOTTOMLEFT",
	xoff = -5,
	yoff = -14
     },
     [1] = {
        point = "BOTTOMRIGHT",
	relto = "ChatFrame1",
	relpoint = "BOTTOMRIGHT",
	xoff = 5,
	yoff = -14
     }
   }
},
[2] = {
   info = CONFAB_STYLE3_INFO,
   style = 2,
   autohide = true,   -- overrides the /conflag autohide option
   docked = true,
   dockpoints = {
     [0] = {
        point = "TOPLEFT", 
        relto = "ChatFrame1",
	relpoint = "TOPLEFT",
	xoff = -5,
	yoff = 10
     },
     [1] = {
        point = "TOPRIGHT",
	relto = "ChatFrame1",
	relpoint = "TOPRIGHT",
	xoff = 5,
	yoff = 10
     }
   }
},
[3] = {
   info = CONFAB_STYLE4_INFO,
   style = 3,
   docked = true,
   dockpoints = {
     [0] = {
        point = "BOTTOMLEFT", 
        relto = "ChatFrame1",
	relpoint = "TOPLEFT",
	xoff = -5,
	yoff = -3
     },
     [1] = {
        point = "BOTTOMRIGHT",
	relto = "ChatFrame1",
	relpoint = "TOPRIGHT",
	xoff = 5,
	yoff = -3
     }
   }
},
["undock"] = {
   info = CONFAB_UNDOCKED_INFO,
   docked = false,
   locked = false
}
};



--
-- Change the chat groups to split out the Officer and Raid channels.
--
ChatTypeGroup["PARTY"] = {
	"CHAT_MSG_PARTY"
};

ChatTypeGroup["RAID"] = {
	"CHAT_MSG_RAID"
};

ChatTypeGroup["GUILD"] = {
	"CHAT_MSG_GUILD",
	"GUILD_MOTD"
};
ChatTypeGroup["OFFICER"] = {
	"CHAT_MSG_OFFICER"
};

--
-- Add them to the channel filter menu
--
ChannelMenuChatTypeGroups[6] = "RAID";
ChannelMenuChatTypeGroups[7] = "OFFICER";


--
-- Define some local variables
--
local OldEditBox = nil;
local OldChatFrameEditBox = nil;

local PlayerName = nil;
local SLASH_TT = "/tt";
local SLASH_TELLTARGET = "/telltarget";
local SLASH_RT = "/rt";
local SLASH_RETELL = "/retell";
local LastSentTellTarget = nil;
local ShowFlag = false;
local InitDone = false;

--
-- Define global variables
--
CONFAB_VERSION = "1.77";  -- obligatory version
ConfabUser = {};          -- table user data is saved in 
ConfabDetails = {
	name = "Confab",
	description = "Customize the look and placement of the chat edit box",
	version = CONFAB_VERSION,
	releaseDate = "July 20, 2005",
	author = "Kulyeh",
	--email = "",
	website = "http://www.curse-gaming.com",
	category = MYADDONS_CATEGORY_CHAT,
	frame = "Confab",
	--optionsframe = "HelloWorldOptionsFrame"
};

ConfabHelp = {};
ConfabHelp[1] = string.format(CONFAB_USAGE, "/confab").."\n"..CONFAB_HELP1..
"\n|cffffffff style1|cff00ff00|||cffffffffstyle2|cff00ff00|||cffffffffstyle3|cff00ff00|||cffffffffstyle4 |cff00ff00"..
"\n|cffffffff chatsticky off|cff00ff00|||cffffffffdefault|cff00ff00|||cffffffffconfab|cff00ff00|||cffffffffparty|cff00ff00|||cffffffffguild|cff00ff00|||cffffffffraid|cff00ff00|||cffffffffofficer|cff00ff00|||cffffffffsay|cff00ff00|||cffffffff1-10 |cff00ff00"..
"\n|cffffffff autohide on|cff00ff00|||cffffffffoff |cff00ff00\n|cffffffff undock |r|cff00ff00\n|cffffffff dock |cff00ff00[|cffffffffframe|cff00ff00] |cff00ff00"..
"\n|cffffffff autodock on|cff00ff00|||cffffffffoff |cff00ff00\n|cffffffff lock |cff00ff00\n|cffffffff unlock |cff00ff00"..
"\n|cffffffff enableArrowKeys |cff00ff00\n|cffffffff disableArrowKeys |cff00ff00\n|cffffffff texture |cff00ff00\n|cffffffff alpha |cff00ff00\n\n"..CONFAB_HELP14..
"\n|cffffffff /tt |cff00ff00\n|cffffffff /targettell |cff00ff00\n|cffffffff /telltarget |cff00ff00\n|cffffffff /rt, /retell |cff00ff00"..
"\n|cffffffff /targetsave, /tsave |cff00ff00\n|cffffffff /targetrestore, /trestore |cff00ff00";



function Confab_OnLoad()

   if (not DEFAULT_CHAT_FRAME) then
      DEFAULT_CHAT_FRAME = ChatFrame1;		
   end

   if (not SELECTED_CHAT_FRAME) then
      SELECTED_CHAT_FRAME = ChatFrame1;
   end

   if (DEFAULT_CHAT_FRAME.editBox) then
      OldEditBox = DEFAULT_CHAT_FRAME.editBox;
      OldChatFrameEditBox = ChatFrameEditBox;
   end


   SLASH_CONFAB1 = "/confab";
   SLASH_CONFAB2 = "/cf";
   SlashCmdList["CONFAB"] = function(msg)
      ConfabSlashHandler(msg);
   end
    

   if (SlashCmdList["RT"] == nil) then
      SLASH_RT1 = SLASH_RT;
      SLASH_RT2 = SLASH_RETELL;
      SlashCmdList["RT"] = function(msg)
         --Confab_ReTell()
      end
   end

   SLASH_TT1 = SLASH_TT;
   SlashCmdList["TT"] = function(msg)
      Confab_TT(msg);
   end

   SLASH_TARGETTELL1 = "/targettell";
   SlashCmdList["TARGETTELL"] = function(msg)
      Confab_TT();
   end

   SLASH_TELLTARGET1 = SLASH_TELLTARGET;
   SlashCmdList["TELLTARGET"] = function(msg)
      if (msg ~= nil and strlen(msg) > 0) then
         Confab_TT(msg);
      end;
   end

   SLASH_SAVETARGET1 = "/targetsave";
   SLASH_SAVETARGET2 = "/tsave"; 
   SlashCmdList["SAVETARGET"] = function(msg)
      Confab_SaveTarget();
   end

   SLASH_LOADTARGET1 = "/targetrestore";
   SLASH_LOADTARGET2 = "/trestore";
   SlashCmdList["LOADTARGET"] = function(msg)
      Confab_LoadTarget();
   end


   this:RegisterEvent("VARIABLES_LOADED");
   this:RegisterEvent("UNIT_NAME_UPDATE");
end

function Confab_RegisterUltimateUI()
	UltimateUI_RegisterConfiguration(
		"UUI_CONFAB",
		"SECTION",
		"Confab",
		"Options to configure your chat edit box."
	);
	UltimateUI_RegisterConfiguration(
		"UUI_CONFAB_SEPARATOR",
		"SEPARATOR",
		"Confab",
		"Options to configure your chat edit box."
	);
	UltimateUI_RegisterConfiguration(
		"UUI_CONFAB_UNLOCK",
		"CHECKBOX",
		"Unlock edit box",
		"Check to allow dragging of the edit box.",
		Confab_Toggle,
		1
	);
end

function Confab_Toggle(arg)
	if( arg == 1 ) then
		if (ConfabUser[PlayerName].currentstyle.docked) then
			if (ConfabUser[PlayerName].autodock) then
				ConfabUser[PlayerName].autodock = false;
				Confab:Hide();
			end
			Confab_SetStyle(ConfabStyles["undock"], ConfabUser[PlayerName].autohide);
		end
		if (ConfabUser[PlayerName].currentstyle.locked) then
			ConfabUser[PlayerName].currentstyle.locked = false;
			Confab_SetStyle(ConfabUser[PlayerName].currentstyle, ConfabUser[PlayerName].autohide);
		end
	elseif( arg == 0) then
		if (not ConfabUser[PlayerName].currentstyle.locked) then
			ConfabUser[PlayerName].currentstyle.locked = true;
			Confab_SetStyle(ConfabUser[PlayerName].currentstyle, ConfabUser[PlayerName].autohide);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Confab_Toggle(arg) returned invalid arg.");
	end
end

local variablesLoaded = false;
function Confab_OnEvent(event)
   if (event == "VARIABLES_LOADED") then
		Confab_RegisterUltimateUI();
      variablesLoaded = true;
      if (not PlayerName) then
         local playerName = UnitName("player");
         if (playerName ~= UKNOWNBEING and playerName ~= UNKNOWNOBJECT) then
             PlayerName = playerName .. ":"..GetCVar("realmName");
             Confab_Init();
	 end
      else
         Confab_Init();
      end
      if(myAddOnsFrame_Register) then
         -- Register the addon in myAddOns
         myAddOnsFrame_Register(ConfabDetails, ConfabHelp);
      end
   elseif (event == "UNIT_NAME_UPDATE" and arg1 == "player") then
      local playerName = UnitName("player");
      if (playerName ~= UKNOWNBEING and playerName ~= UNKNOWNOBJECT) then
         if (PlayerName == nil) then
            PlayerName = playerName .. ":"..GetCVar("realmName");
	    
	    if (variablesLoaded) then
               Confab_Init();
	    end
	 end
      end
   end
end


-- used for the autodock option.
function Confab_OnUpdate(elapsed)
   if (InitDone) then
      local chatFrame, chatTab;

      for j=1, NUM_CHAT_WINDOWS do
         chatFrame = getglobal("ChatFrame"..j);
         chatTab = getglobal("ChatFrame"..j.."Tab");
         local tabname = chatTab:GetText();

         if (tabname ~= COMBAT_LOG and chatFrame:IsVisible() and MouseIsOver(chatFrame, 45, -10, -5, 5)) then
            local name = chatFrame:GetName();

            if (chatFrame.isDocked) then
	       if (SELECTED_DOCK_FRAME == chatFrame) then
	          if (chatFrame.editBox.dockedTo and chatFrame.editBox.dockedTo ~= name) then
                     Confab_SetStyle(ConfabUser[PlayerName].currentstyle, ConfabUser[PlayerName].autohide, name);
                     Confab_SetChannelSticky(chatFrame.editBox);
		  end
		  return;
	       end
            else
               if (chatFrame.editBox.dockedTo and chatFrame.editBox.dockedTo ~= name) then
	          Confab_SetStyle(ConfabUser[PlayerName].currentstyle, ConfabUser[PlayerName].autohide, name);
                  Confab_SetChannelSticky(chatFrame.editBox);
	       end
	       return;
            end
         end
      end
   end
end


function Confab_SetEditBox(editBox)
   -- copy over some of the basic stuff from the old editbox to the new one.
   editBox.chatType = ChatFrameEditBox.chatType;
   editBox.channelTarget = ChatFrameEditBox.channelTarget;
   editBox.stickyType = ChatFrameEditBox.stickyType;
   editBox.lastTell = ChatFrameEditBox.lastTell;
   editBox.tellTarget = ChatFrameEditBox.tellTarget;

   if (ChatFrameEditBox.Org_IsVisible) then
      ChatFrameEditBox.IsVisible = ChatFrameEditBox.Org_IsVisible;
      ChatFrameEditBox.Org_IsVisible = nil;
   end

   if (ChatFrameEditBox.Org_Hide) then
      ChatFrameEditBox.Hide = ChatFrameEditBox.Org_Hide;
      ChatFrameEditBox.Org_Hide = nil;
   end

   -- re-assign the global variable to the new edit box.
   ChatFrameEditBox = editBox;

   -- Since I have to muck with these to make the default Blizzard code to correctly work
   -- with autohide off, save the originals off and re-assign
   ChatFrameEditBox.Org_IsVisible = ChatFrameEditBox.IsVisible;
   ChatFrameEditBox.IsVisible = Confab_IsVisible;

   ChatFrameEditBox.Org_Hide = ChatFrameEditBox.Hide;
   ChatFrameEditBox.Hide = Confab_Hide;


   local chatFrame = nil;
   local chatFrameName = nil;
   local chatTab = nil;

   -- Iterate through each of the chatframes and assign the editbox to the new one.
   for i=1, NUM_CHAT_WINDOWS do
      chatFrameName = "ChatFrame"..i;
      chatTab = getglobal(chatFrameName.."Tab");
      chatFrame = getglobal(chatFrameName);

      chatFrame.editBox = editBox;
     
      -- Since we are iterating through the chatframes, initialize the filter menu to correctly 
      -- assign the Raid and Officer filters (since I have to save that info myself).
      if (ConfabUser[PlayerName][chatFrameName]) then
         if (ConfabUser[PlayerName][chatFrameName]["RAID"]) then
            ChatFrame_AddMessageGroup(chatFrame, "RAID");
	 end
         if (ConfabUser[PlayerName][chatFrameName]["OFFICER"]) then
            ChatFrame_AddMessageGroup(chatFrame, "OFFICER");
	 end
      end

      -- Again, since we are iterating through the chatframes, set the chatframe sticky based on the chat tab text. 
      Confab_SetChatFrameSticky(chatFrame, chatTab:GetText());
   end
   
   -- Save which editbox we are using
   ConfabUser.editbox = editBox:GetName();
end

local Org_ChatEdit_OnSpacePressed = ChatEdit_OnSpacePressed;
local Org_ChatEdit_OnEscapePressed = ChatEdit_OnEscapePressed;
local Org_ChatEdit_ParseText = ChatEdit_ParseText;
local Org_ChatFrame_OpenChat = ChatFrame_OpenChat;
local Org_ChatFrame_OnEvent = ChatFrame_OnEvent;
local Org_FCF_Close = FCF_Close;
local Org_FCFMessageTypeDropDown_OnClick = FCFMessageTypeDropDown_OnClick;
local Org_FCF_OpenNewWindow = FCF_OpenNewWindow;
local Org_FCF_SetWindowName = FCF_SetWindowName;
local Org_FCF_Tab_OnClick = FCF_Tab_OnClick;
local Org_FCF_UnDockFrame = FCF_UnDockFrame;
local Org_FCF_DockFrame = FCF_DockFrame;
local Org_FCF_OnUpdate = FCF_OnUpdate;

local Org_ChatLock_OpenChat = ChatLock_OpenChat;

-- Confab main init method.
function Confab_Init()
   -- hide the main frame so events and updates are turned off
   Confab:Hide();

   -- don't need these anymore, so might as well unregister them
   this:UnregisterEvent("VARIABLES_LOADED"); 
   this:UnregisterEvent("UNIT_NAME_UPDATE");

   if (Sea) then
      Sea.util.hook("ChatEdit_OnSpacePressed", "Confab_ChatEdit_OnSpacePressed", "hide");
      Sea.util.hook("ChatEdit_OnEscapePressed", "Confab_ChatEdit_OnEscapePressed", "replace");
      Sea.util.hook("ChatEdit_ParseText", "Confab_ChatEdit_ParseText", "before");
      Sea.util.hook("ChatFrame_OpenChat", "Confab_ChatFrame_OpenChat", "replace");
      Sea.util.hook("ChatFrame_OnEvent", "Confab_ChatFrame_OnEvent", "after");
      Sea.util.hook("FCF_Close", "Confab_FCF_Close", "before");
      Sea.util.hook("FCFMessageTypeDropDown_OnClick", "Confab_FCFMessageTypeDropDown_OnClick", "before");
      Sea.util.hook("FCF_OpenNewWindow", "Confab_FCF_OpenNewWindow", "after");
      Sea.util.hook("FCF_SetWindowName", "Confab_FCF_SetWindowName", "after");
      Sea.util.hook("FCF_Tab_OnClick", "Confab_FCF_Tab_OnClick", "replace");  -- Might have to change this to "hide"
      Sea.util.hook("FCF_UnDockFrame", "Confab_FCF_UnDockFrame", "after");
      Sea.util.hook("FCF_DockFrame", "Confab_FCF_DockFrame", "after");
      Sea.util.hook("FCF_OnUpdate", "Confab_FCF_OnUpdate", "before");
   else
      -- Reset these as they might have changed since being loaded.
      Org_ChatEdit_OnSpacePressed = ChatEdit_OnSpacePressed; 
      Org_ChatEdit_OnEscapePressed = ChatEdit_OnEscapePressed;
      Org_ChatEdit_ParseText = ChatEdit_ParseText;
      Org_ChatFrame_OpenChat = ChatFrame_OpenChat;
      Org_ChatFrame_OnEvent = ChatFrame_OnEvent;
      Org_FCF_Close = FCF_Close;
      Org_FCFMessageTypeDropDown_OnClick = FCFMessageTypeDropDown_OnClick;
      Org_FCF_OpenNewWindow = FCF_OpenNewWindow;
      Org_FCF_SetWindowName = FCF_SetWindowName;
      Org_FCF_Tab_OnClick = FCF_Tab_OnClick;
      Org_FCF_UnDockFrame = FCF_UnDockFrame;
      Org_FCF_DockFrame = FCF_DockFrame;
      Org_FCF_OnUpdate = FCF_OnUpdate;

      ChatEdit_OnSpacePressed = Confab_ChatEdit_OnSpacePressed;
      ChatEdit_OnEscapePressed = Confab_ChatEdit_OnEscapePressed;
      ChatEdit_ParseText = Confab_ChatEdit_ParseText;
      ChatFrame_OpenChat = Confab_ChatFrame_OpenChat;
      ChatFrame_OnEvent = Confab_ChatFrame_OnEvent;
      FCF_Close = Confab_FCF_Close;
      FCFMessageTypeDropDown_OnClick = Confab_FCFMessageTypeDropDown_OnClick;
      FCF_OpenNewWindow = Confab_FCF_OpenNewWindow;
      FCF_SetWindowName = Confab_FCF_SetWindowName;
      FCF_Tab_OnClick = Confab_FCF_Tab_OnClick;
      FCF_UnDockFrame = Confab_FCF_UnDockFrame;
      FCF_DockFrame = Confab_FCF_DockFrame;
      FCF_OnUpdate = Confab_FCF_OnUpdate;
   end


   -- ChatLock mod Fix: replace ChatLock_OpenChat from the Chatlock mod with a corrected version.
   if (ChatLock_OpenChat and CHATLOCK_VERSION) then
      local version = tonumber(CHATLOCK_VERSION);

      if (version and version <= 2.1) then
        ChatLock_OpenChat = Confab_ChatLock_OpenChatFix;
      end
   end

   -- is this a new player, if it is create the entry and make some default assignments
   if (not ConfabUser[PlayerName]) then
      ConfabUser[PlayerName] = {};
   end
   
   if (not ConfabUser[PlayerName].currentstyle) then
      ConfabUser[PlayerName].currentstyle = ConfabStyles[0];
   end

   if (ConfabUser[PlayerName].autohide == nil) then
      ConfabUser[PlayerName].autohide = true;
   end

   -- set the default sticky and reset some of the depricated sicky values from prior versions
   if (not ConfabUser[PlayerName].sticky or ConfabUser[PlayerName].sticky == "auto") then
      ConfabUser[PlayerName].sticky = "default";
   elseif (ConfabUser[PlayerName].sticky == "on") then
      ConfabUser[PlayerName].sticky = "off";
   elseif (ConfabUser[PlayerName].sticky == "confab") then
      ChatTypeInfo["OFFICER"].sticky = 1;
      ChatTypeInfo["CHANNEL"].sticky = 1;
   end

   -- set the Raid and Officer menu check boxs to be selected by default
   if (not ConfabUser[PlayerName]["ChatFrame1"]) then
       ConfabUser[PlayerName]["ChatFrame1"] = {};
       ConfabUser[PlayerName]["ChatFrame1"]["RAID"] = 1;
       ConfabUser[PlayerName]["ChatFrame1"]["OFFICER"] = 1;
   end

   if (not ConfabUser.editbox) then
      ConfabUser.editbox = "ConfabEditBoxArrowsEnabled"
   end

   Confab_SetEditBox(getglobal(ConfabUser.editbox));

   if (ConfabUser[PlayerName].alpha ~= nil) then
      ConfabSetAlpha(ConfabUser[PlayerName].alpha);
   end

   if (ConfabUser[PlayerName].texture) then
      ConfabSetTexture(ConfabUser[PlayerName].texture);
   end

   local relto = ConfabUser[PlayerName].relto;
   local chatFrame = getglobal(relto);
   local selDockFrame = SELECTED_DOCK_FRAME:GetName();

   if (relto and chatFrame.isDocked and selDockFrame ~= relto) then
      Confab_SetStyle(ConfabUser[PlayerName].currentstyle, ConfabUser[PlayerName].autohide, selDockFrame);
   else
      Confab_SetStyle(ConfabUser[PlayerName].currentstyle, ConfabUser[PlayerName].autohide);
   end

   Confab_SetChannelSticky(ChatFrameEditBox)

   if (ConfabUser[PlayerName].autodock) then
      Confab:Show();
   end

   if (SELECTED_DOCK_FRAME ~= ChatFrame1) then
      FCF_SelectDockFrame(ChatFrame1);
      ChatFrameEditBox.chatFrame = ChatFrame1;
   end

   InitDone = true;
end

--
-- code that determines whether you want to move or resize the editbox
-- If the cursor is in the left most region it resizes to the left
-- If the cursor is in the right most region it resizes to the right
-- Otherwise the cursor is somewhere in the middle, so do a move
--
function ConfabMoveOrResize()
   if (MouseIsOver(ChatFrameEditBox)) then
      local cx, cy = GetCursorPosition();
      local scale = ChatFrameEditBox:GetScale();

      local left = ChatFrameEditBox:GetLeft() * scale;
      local right = ChatFrameEditBox:GetRight() * scale;

      local phi = math.floor((right-left)/5); 

      if (cx < (left+phi) and ChatFrameEditBox:IsResizable()) then
         ChatFrameEditBox:StartSizing("LEFT");
	 return;
      end
 
      if (cx > (right-phi) and ChatFrameEditBox:IsResizable()) then
         ChatFrameEditBox:StartSizing("RIGHT");
	 return;
      end
      
      if (ChatFrameEditBox:IsMovable()) then
         ChatFrameEditBox:StartMoving()
      end
   end
end

--
-- Save the current frame position so we can put it back there on relog 
--
function ConfabSavePosition()
   if (not ConfabUser[PlayerName].currentstyle.docked) then
      ConfabUser[PlayerName].currentstyle.left = ChatFrameEditBox:GetLeft();
      ConfabUser[PlayerName].currentstyle.top = ChatFrameEditBox:GetTop();
      ConfabUser[PlayerName].currentstyle.width = ChatFrameEditBox:GetWidth();
   end
end

--
-- function to handle the Confab slash commands
--
function ConfabSlashHandler(orgMsg)
   msg = string.lower(orgMsg);
   if (msg == "style1") then
      Confab_SetStyle(ConfabStyles[0], ConfabUser[PlayerName].autohide);
   elseif (msg == "style2") then
      Confab_SetStyle(ConfabStyles[1], ConfabUser[PlayerName].autohide);
   elseif (msg == "style3") then
      Confab_SetStyle(ConfabStyles[2], ConfabUser[PlayerName].autohide);
   elseif (msg == "style4") then
      Confab_SetStyle(ConfabStyles[3], ConfabUser[PlayerName].autohide);
   elseif (string.find(msg, "^(texture)")) then
      local _, _, _, _, value = string.find(orgMsg, "^(%a+)(%s+)([^%s]+)");
      if (not value) then
          DEFAULT_CHAT_FRAME:AddMessage(CONFAB_TEXTURE_SETTO..ConfabUser[PlayerName].texture);
      else
         ConfabSetTexture(value);
      end
   elseif (string.find(msg, "^(alpha)")) then
      local _, _, _, value = string.find(msg, "alpha(%s+)([^%s]+)");
      local num = tonumber(value);
      if (num ~= nil) then
          ConfabSetAlpha(num);
      else
         DEFAULT_CHAT_FRAME:AddMessage(CONFAB_ALPHA_SETTO..ChatFrameEditBox:GetAlpha());
      end
   elseif (string.find(msg, "^(autohide)")) then
      local _, _, _, flag = string.find(msg, "autohide(%s+)([^%s]+)");
      if (flag == nil) then
         if (ConfabUser[PlayerName].autohide) then
           DEFAULT_CHAT_FRAME:AddMessage(CONFAB_AUTOHIDE_ON);
	 else
           DEFAULT_CHAT_FRAME:AddMessage(CONFAB_AUTOHIDE_OFF);
	 end
      elseif (flag == "on") then
         ConfabUser[PlayerName].autohide = true;
         Confab_SetStyle(ConfabUser[PlayerName].currentstyle, true);
      elseif (flag == "off") then
         ConfabUser[PlayerName].autohide = false;
         Confab_SetStyle(ConfabUser[PlayerName].currentstyle, false);
      end
   elseif (msg == "undock") then
       if (ConfabUser[PlayerName].currentstyle.docked) then
          if (ConfabUser[PlayerName].autodock) then
             ConfabUser[PlayerName].autodock = false;
             Confab:Hide();
			end
          Confab_SetStyle(ConfabStyles["undock"], ConfabUser[PlayerName].autohide);
       end
   elseif (string.find(msg, "^(autodock)")) then
      local _, _, _, flag = string.find(msg, "autodock(%s+)([^%s]+)");
      if (flag == nil) then
         if (Confab:IsVisible()) then
	    DEFAULT_CHAT_FRAME:AddMessage(CONFAB_AUTODOCK_ON);
	 else
	    DEFAULT_CHAT_FRAME:AddMessage(CONFAB_AUTODOCK_OFF);
	 end
      elseif (flag == "on") then
         if (ConfabUser[PlayerName].currentstyle.docked) then
            Confab:Show();
	 elseif (not ConfabUser[PlayerName].autodock) then
            ConfabUser[PlayerName].relto = nil
            Confab_SetStyle(ConfabStyles[ConfabUser[PlayerName].oldstyle], ConfabUser[PlayerName].autohide);
            Confab:Show();
	 end
	 ConfabUser[PlayerName].autodock = true;
      elseif (flag == "off") then
         ConfabUser[PlayerName].autodock = false;
         Confab:Hide();
      end
   elseif (string.find(msg, "^(dock)")) then
      local _, _, _, _, frame = string.find(orgMsg, "^(%a+)(%s+)([^%s]+)"); 

      if (frame) then
         Confab_SetStyle(ConfabStyles[1], ConfabUser[PlayerName].autohide, frame);
      elseif ((not ConfabUser[PlayerName].currentstyle.docked)) then
         Confab_SetStyle(ConfabStyles[ConfabUser[PlayerName].oldstyle], ConfabUser[PlayerName].autohide, SELECTED_DOCK_FRAME:GetName());
      end
   elseif (msg == "lock") then
      if (not ConfabUser[PlayerName].currentstyle.locked) then
         ConfabUser[PlayerName].currentstyle.locked = true;
         Confab_SetStyle(ConfabUser[PlayerName].currentstyle, ConfabUser[PlayerName].autohide);
      end
   elseif (msg == "unlock") then
      if (ConfabUser[PlayerName].currentstyle.locked) then
         ConfabUser[PlayerName].currentstyle.locked = false;
         Confab_SetStyle(ConfabUser[PlayerName].currentstyle, ConfabUser[PlayerName].autohide);
      end
   elseif (msg == "enablearrowkeys") then
      Confab_SetEditBox(ConfabEditBoxArrowsEnabled);
      Confab_SetStyle(ConfabUser[PlayerName].currentstyle, ConfabUser[PlayerName].autohide);
   elseif (msg == "disablearrowkeys") then
      Confab_SetEditBox(ConfabEditBoxArrowsDisabled);
      Confab_SetStyle(ConfabUser[PlayerName].currentstyle, ConfabUser[PlayerName].autohide);
   elseif (string.find(msg, "^(chatsticky)")) then
      ChatTypeInfo["OFFICER"].sticky = 0;
      ChatTypeInfo["CHANNEL"].sticky = 0;
      local _, _, _, flag = string.find(msg, "chatsticky(%s+)([^%s]+)");
      if (flag == nil) then
         local tmp = string.gsub(ConfabUser[PlayerName].sticky, "%a+(%d%d?)", "%1");
         if (tmp == ConfabUser[PlayerName].sticky) then
            DEFAULT_CHAT_FRAME:AddMessage(CONFAB_STICKY_CURRENTLY_SETTO.. ConfabUser[PlayerName].sticky.."'");
	 else
            local channelNum, channelName = GetChannelName(tmp);
            DEFAULT_CHAT_FRAME:AddMessage(CONFAB_STICKY_CURRENTLY_SETTO.. channelName.."'");
	 end
      elseif (flag == "off") then
         ConfabUser[PlayerName].sticky = "off";
         ChatFrameEditBox.stickyType = "SAY";   -- need to set the sticky to something other then what it was even though its not used
         DEFAULT_CHAT_FRAME:AddMessage(CONFAB_STICKY_SETTO.."off'");
      elseif (flag == "default") then
         ConfabUser[PlayerName].sticky = "default";
         ChatFrameEditBox.stickyType = "SAY";
         DEFAULT_CHAT_FRAME:AddMessage(CONFAB_STICKY_SETTO.."default'");
      elseif (flag == "guild" or flag == "officer" or flag == "party" or flag == "raid" or flag == "say") then
         ConfabUser[PlayerName].sticky = string.upper(flag);
         DEFAULT_CHAT_FRAME:AddMessage(CONFAB_STICKY_SETTO.. flag.."'");
      elseif (flag >= "0" and flag <= "9") then
         local channelNum, channelName = GetChannelName(flag);
	 if ( channelNum > 0 ) then
            ConfabUser[PlayerName].sticky = "CHANNEL"..flag;
            ChatFrameEditBox.stickyType = "SAY";
            DEFAULT_CHAT_FRAME:AddMessage(CONFAB_STICKY_SETTO.. channelName.."'");
	 end
      elseif (flag == "confab") then
         ChatTypeInfo["OFFICER"].sticky = 1;
         ChatTypeInfo["CHANNEL"].sticky = 1;
         ConfabUser[PlayerName].sticky = "confab";
         ChatFrameEditBox.stickyType = "SAY";
         DEFAULT_CHAT_FRAME:AddMessage(CONFAB_STICKY_SETTO.."confab'");
      end
   else
      Confab_Help();
   end
end

--
-- Confab help
--
function Confab_Help()
   DEFAULT_CHAT_FRAME:AddMessage(string.format(CONFAB_USAGE, "/confab"));
   DEFAULT_CHAT_FRAME:AddMessage(CONFAB_HELP1);
   DEFAULT_CHAT_FRAME:AddMessage("|cffffffff style1|cff00ff00|||cffffffffstyle2|cff00ff00|||cffffffffstyle3|cff00ff00|||cffffffffstyle4 |cff00ff00"..CONFAB_HELP2);
   DEFAULT_CHAT_FRAME:AddMessage("|cffffffff autohide on|cff00ff00|||cffffffffoff |cff00ff00"..CONFAB_HELP6);
   DEFAULT_CHAT_FRAME:AddMessage("|cffffffff undock |r|cff00ff00"..CONFAB_HELP7);
   DEFAULT_CHAT_FRAME:AddMessage("|cffffffff dock |cff00ff00[|cffffffffframe|cff00ff00] |cff00ff00"..CONFAB_HELP8);
   DEFAULT_CHAT_FRAME:AddMessage("|cffffffff autodock on|cff00ff00|||cffffffffoff |cff00ff00"..CONFAB_HELP5);
   DEFAULT_CHAT_FRAME:AddMessage("|cffffffff lock |cff00ff00"..CONFAB_HELP9);
   DEFAULT_CHAT_FRAME:AddMessage("|cffffffff unlock |cff00ff00"..CONFAB_HELP10);
   DEFAULT_CHAT_FRAME:AddMessage("|cffffffff chatsticky off|cff00ff00|||cffffffffdefault|cff00ff00|||cffffffffparty|cff00ff00|||cffffffffguild|cff00ff00|||cffffffffraid|cff00ff00|||cffffffffofficer|cff00ff00|||cffffffffsay|cff00ff00|||cffffffff1-10 |cff00ff00"..CONFAB_HELP11);
   DEFAULT_CHAT_FRAME:AddMessage("|cffffffff enableArrowKeys |cff00ff00"..CONFAB_HELP12);
   DEFAULT_CHAT_FRAME:AddMessage("|cffffffff disableArrowKeys |cff00ff00"..CONFAB_HELP13);
   DEFAULT_CHAT_FRAME:AddMessage("|cffffffff texture |cff00ff00"..CONFAB_HELP21);
   DEFAULT_CHAT_FRAME:AddMessage("|cffffffff alpha |cff00ff00"..CONFAB_HELP22);
   DEFAULT_CHAT_FRAME:AddMessage(CONFAB_HELP14);
   DEFAULT_CHAT_FRAME:AddMessage("|cffffffff /tt |cff00ff00"..CONFAB_HELP15);
   DEFAULT_CHAT_FRAME:AddMessage("|cffffffff /targettell |cff00ff00"..CONFAB_HELP16);
   DEFAULT_CHAT_FRAME:AddMessage("|cffffffff /telltarget |cff00ff00"..CONFAB_HELP20);
   DEFAULT_CHAT_FRAME:AddMessage("|cffffffff /rt, /retell |cff00ff00"..CONFAB_HELP17);
   DEFAULT_CHAT_FRAME:AddMessage("|cffffffff /targetsave, /tsave |cff00ff00"..CONFAB_HELP18);
   DEFAULT_CHAT_FRAME:AddMessage("|cffffffff /targetrestore, /trestore |cff00ff00"..CONFAB_HELP19);
end

--
-- Set style
--
function Confab_SetStyle(style, autohide, newrelto)
   if (newrelto) then
      ConfabUser[PlayerName].relto = newrelto;
   end

   if (style) then
      ChatFrameEditBox:ClearAllPoints();

      if (style.docked) then
	 style.locked = true;  -- Docked is always locked, so override the style
         local points = style.dockpoints;

         local cnt = 0;
         local point = {};

         if (points) then
            point = points[cnt];
         end

         while (point) do
            local basepoint = point.point;
	    if (basepoint == nil) then basepoint = "CENTER"; end;

            local relto = point.relto;
            if (relto == nil) then relto = "UIParent"; end;

	    local relpoint = point.relpoint;
	    if (relpoint == nil) then relpoint = "CENTER"; end;

	    local xoff = point.xoff;
	    local yoff = point.yoff;
	    if (xoff == nil) then xoff = 0; end;
	    if (yoff == nil) then yoff = 0; end;


            if (ConfabUser[PlayerName].relto) then
               local s, m = pcall(ChatFrameEditBox.SetPoint,ChatFrameEditBox, basepoint, ConfabUser[PlayerName].relto, relpoint, xoff, yoff); 

               if (not s) then   -- If we had an error (like invalid framename) then use the template frame name.
	          ConfabUser[PlayerName].relto = nil;
	          DEFAULT_CHAT_FRAME:AddMessage(m);
                  ChatFrameEditBox:SetPoint(basepoint, relto, relpoint, xoff, yoff);
	       else
                  relto = ConfabUser[PlayerName].relto;
	       end
            else
               ChatFrameEditBox:SetPoint(basepoint, relto, relpoint, xoff, yoff);
	    end

	    ChatFrameEditBox.dockedTo = relto;
            ChatFrameEditBox.chatFrame = getglobal(relto);
            cnt = cnt + 1;
            point = points[cnt]
         end
      else 
          ChatFrameEditBox.chatFrame = SELECTED_DOCK_FRAME;
          ChatFrameEditBox.dockedTo = nil;

          if (style.left and style.top) then
	     ChatFrameEditBox:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT", style.left, style.top);
          else
             ChatFrameEditBox:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);  -- default undocked placement
	  end

          if (style.width) then
             ChatFrameEditBox:SetWidth(style.width);
	  else
             ChatFrameEditBox:SetWidth(400); -- default width
	  end
      end


      if (style.info == nil) then style.info = CONFAB_STYLE_UNKNOWN; end;
      style.text = style.info;

      if (autohide == nil) then autohide = true; end; 
      if (style.autohide ~= nil) then autohide = style.autohide; end;

      ConfabUser[PlayerName].autohide = autohide;

      if (not autohide and not ShowFlag) then
         ChatFrameEditBox:EnableKeyboard(false);
         ChatFrameEditBox:Show();
         Confab_ClearHeader(ChatFrameEditBox);
         style.text = style.text .. CONFAB_STYLE_NOAUTOHIDE;
      end

      if (style.locked) then
          ChatFrameEditBox:SetMovable(false);
          ChatFrameEditBox:SetResizable(false);
          style.text = style.text .. CONFAB_STYLE_LOCKED;
      else
          ChatFrameEditBox:SetMovable(true);
          ChatFrameEditBox:SetResizable(true);
          style.text = style.text .. CONFAB_STYLE_UNLOCKED
      end

      if (ConfabUser[PlayerName].currentstyle.style ~= nil) then
         ConfabUser[PlayerName].oldstyle = ConfabUser[PlayerName].currentstyle.style;   -- remember previous style so we use it when we redock
      end

      ConfabUser[PlayerName].currentstyle = style;
   end
end

--
-- Set editbox artwork alpha (0 is transparent, 1 is full opaque)
--
function ConfabSetAlpha(alpha)
   if (alpha < 0 or alpha > 1) then
      return;
   end

   getglobal(ConfabUser.editbox.."Left"):SetAlpha(alpha);
   getglobal(ConfabUser.editbox.."Middle"):SetAlpha(alpha);
   getglobal(ConfabUser.editbox.."Right"):SetAlpha(alpha);

   ConfabUser[PlayerName].alpha = alpha;
end

--
-- Set editbox artwork texture
--
function ConfabSetTexture(tname)
   if (tname == nil) then
      return;
   end

   local path = nil;
   
   if (string.find(tname, "\\")) then
      path = tname;
   else
      path = "Interface\\AddOns\\Confab\\Textures\\"..tname;
   end
  
   -- clear the current textures so we can reload an existing texture
   getglobal(ConfabUser.editbox.."Left"):SetTexture("");
   getglobal(ConfabUser.editbox.."Middle"):SetTexture("");
   getglobal(ConfabUser.editbox.."Right"):SetTexture("");

   -- load the new artwork texture
   getglobal(ConfabUser.editbox.."Left"):SetTexture(path);
   getglobal(ConfabUser.editbox.."Middle"):SetTexture(path);
   getglobal(ConfabUser.editbox.."Right"):SetTexture(path);

   -- save the pathname to the artwork
   ConfabUser[PlayerName].texture = tname;
end

--
-- Set the frame sticky based on the name
-- name can be in the players locale or english
--
function Confab_SetChatFrameSticky(chatframe, name) 
   if (chatframe ~= ChatFrame1) then
      chatframe.sticky = nil;
      local tmp = strupper(name);

      if (tmp == strupper(CHAT_MSG_GUILD) or tmp == "GUILD") then
         chatframe.sticky = "GUILD";
      elseif (tmp == strupper(CHAT_MSG_PARTY) or tmp == "PARTY") then
         chatframe.sticky = "PARTY";
      elseif (tmp == strupper(CHAT_MSG_RAID) or tmp == "RAID") then
         chatframe.sticky = "RAID";
      elseif (tmp == strupper(CHAT_MSG_OFFICER) or tmp == "OFFICER") then
         chatframe.sticky = "OFFICER";
      else
          local tell = gsub(CHAT_WHISPER_SEND, "%%s", "");	-- get rid of the %s
	  tell = gsub(tell, "%s", "");				-- get rid of all the whitespace
          tell = gsub(tell, "(%a+):", "%1");			-- match the text that is left minus the :
          if (string.find(tmp, strupper(tell)) or string.find(tmp, "^(TELL)")) then
             chatframe.sticky = "WHISPER";
          end
       end
    end
end


function Confab_SetChannelSticky(editBox)
   if (editBox.chatFrame) then
      local chatFrameSticky = editBox.chatFrame.sticky;
      if (chatFrameSticky) then
         if (chatFrameSticky ~= editBox.chatType) then
            local tmp = editBox.chatType;
            editBox.chatType = chatFrameSticky;

            if (chatFrameSticky == "WHISPER") then
               local lastTell = ChatEdit_GetLastTellTarget(editBox);

               if (strlen(lastTell) > 0) then
                  editBox.tellTarget = lastTell;
	       elseif (not editBox.tellTarget) then
                  editBox.chatType = tmp;
	       end
            end

            if (ShowFlag) then
	       ChatEdit_UpdateHeader(editBox);
            end
         end
      elseif (PlayerName and (ConfabUser[PlayerName].sticky == "default" or ConfabUser[PlayerName].sticky == "confab")) then
         if (editBox.chatFrame.oldChatType) then
            editBox.chatType = editBox.chatFrame.oldChatType;
	 else
	    editBox.chatType = editBox.stickyType;
	 end

         if (ShowFlag) then
            ChatEdit_UpdateHeader(editBox);
         end
      elseif (PlayerName and ConfabUser[PlayerName].sticky ~= "off") then
         local tmp = string.gsub(ConfabUser[PlayerName].sticky, "%a+(%d%d?)", "%1");

         if (tmp == ConfabUser[PlayerName].sticky) then
            editBox.chatType = ConfabUser[PlayerName].sticky;
         else
            editBox.channelTarget = tonumber(tmp);
            editBox.chatType = "CHANNEL"
         end

         if (ShowFlag) then
            ChatEdit_UpdateHeader(editBox);
         end
      end
   end
end


local prevTarget = nil;
local isPlayer = nil;
local isFriend = nil;
function Confab_SaveTarget()
   if (UnitExists("target")) then
	prevTarget = UnitName("target");
	isPlayer = UnitIsPlayer("target");
        isFriend = UnitIsFriend("player", "target");
   else
	prevTarget = nil;
	isPlayer = nil;
        isFriend = nil;
   end
end


function Confab_LoadTarget()
   if (SpellIsTargeting()) then
      SpellStopTargeting()
   end;

   if (prevTarget == nil) then
      ClearTarget();
   elseif (isPlayer or (not isPlayer and isFriend)) then
      TargetByName(prevTarget)

      if (UnitName("target") ~= prevTarget) then
         ClearTarget();
      end
   else
      TargetLastEnemy()
   end
end


function Confab_GetFriendlyTarget()
   local target = UnitName("target");
   if (target) then
      if (UnitIsFriend("player", "target") and UnitIsPlayer("target") and UnitExists("target")) then
         return target;
      end
   end

   return nil;
end


-- The SlashCmdList half of /tt function and for /targettell key bind
function Confab_TT(msg)
   if (msg ~= nil and strlen(msg) > 0) then
      local target = Confab_GetFriendlyTarget();
      if (target) then
         SendChatMessage(msg, "WHISPER", GetLanguageByIndex(0), target);
      end
      return;
   end

   local lastname = ChatEdit_GetLastTellTarget(DEFAULT_CHAT_FRAME.editBox);

   if (strlen(lastname) > 0) then
      Confab_SaveTarget();

      TargetByName(lastname); 

      if (UnitName("target") ~= lastname) then
         Confab_LoadTarget();
         DEFAULT_CHAT_FRAME:AddMessage(CONFAB_UNABLE_TO_TARGET..lastname);
      end
   end
end


-- Function for /telltarget key bind
function Confab_TellTarget(target)
   if (not target) then
      target = Confab_GetFriendlyTarget();
   end

   if (target) then
       ChatFrameEditBox.tellTarget = target;
       ChatFrameEditBox.chatType = "WHISPER";
       ChatEdit_UpdateHeader(ChatFrameEditBox);
       ChatFrame_OpenChat("");
   end
end


-- Function for /tt key bind
function Confab_TTKeyBind() 
   local target = Confab_GetFriendlyTarget();
   if (target) then
      Confab_TellTarget(target);
   else
      Confab_TT()
   end
end


-- Function for /rt key bind
function Confab_ReTell()  
   if (LastSentTellTarget) then
       ChatFrameEditBox.tellTarget = LastSentTellTarget;
       ChatFrameEditBox.chatType = "WHISPER";
       ChatEdit_UpdateHeader(ChatFrameEditBox);
       ChatFrame_OpenChat("");
   end
end


function Confab_OnShow()
   if (ShowFlag) then
      -- This is needed because of the way Blizzard checks for whether your in a party or not in ChatEdit_OnShow actually doesn't work.
      if (this.chatType == "PARTY" and (GetNumPartyMembers() == 0)) then
	 this.chatType = "SAY";
      end
      ChatEdit_OnShow();
   end
end


function Confab_ClearHeader(editBox)
   local header = getglobal(editBox:GetName().."Header");
   if (header) then
      header:SetText("");
      editBox:SetTextInsets(-3000, 0, 0, 0);    -- since I can't (or don't know how to) disable the cursor, I'll just move it off the scrren
   end
end


------------------------------------------------------------------------------------------------------------
-- start of the function hook methods
------------------------------------------------------------------------------------------------------------
function Confab_IsVisible(obj)
   return ShowFlag;
end


function Confab_Hide(obj)
   if (ConfabUser[PlayerName].autohide) then
      obj:Org_Hide();
   else
      obj:ClearFocus()
      Confab_ClearHeader(obj);
      obj:EnableKeyboard(false);
   end
end


-- Function from the Chatlock mod, this is a corrected version of it.
function Confab_ChatLock_OpenChatFix()
   ChatFrame_OpenChat();
   Org_ChatLock_OpenChat();
end


-- This makes editing most command history lines possible otherwise ChatEdit_ParseText eats the text.
local SpacePressedFlag = false;
Confab_ChatEdit_OnSpacePressed = function()
   local text = ChatFrameEditBox:GetText();
   local spccnt = 0;
   
   for w in string.gfind(text, "%s+") do
    spccnt = spccnt + 1;
      if (spccnt > 2) then return false; end;
   end

   SpacePressedFlag = true;

   if (not Sea) then
      Org_ChatEdit_OnSpacePressed()
   else
      return true;
   end
end


Confab_ChatEdit_OnEscapePressed = function(editBox)
   if (editBox.chatFrame and not editBox.chatFrame.sticky) then
      if (ConfabUser[PlayerName].sticky == "default" or ConfabUser[PlayerName].sticky == "confab") then
         editBox.chatType = editBox.stickyType;
      elseif (ConfabUser[PlayerName].sticky == "off") then
         editBox.stickyType = "SAY";
      else
         Confab_SetChannelSticky(editBox)
         editBox.stickyType = "SAY";
      end
   else
      Confab_SetChannelSticky(editBox);
      editBox.stickyType = "SAY";
   end


   if (not Sea) then
      local chatType = editBox.chatType;
      Org_ChatEdit_OnEscapePressed(editBox)
      editBox.chatType = chatType;
   else
      editBox:SetText("");
      editBox:Hide();
   end

   ShowFlag = false;
end


Confab_ChatEdit_ParseText = function(editBox, send)
   local text = editBox:GetText();

   if (strlen(text) > 0 and strsub(text, 1, 1) ~= "/") then
      if (send == 1 and editBox.chatType == "WHISPER") then
         LastSentTellTarget = editBox.tellTarget;
      end
   end

   if (strlen(text) > 0 and send == 0 and SpacePressedFlag) then
      SpacePressedFlag = false;
      local command = strupper(gsub(text, "/([^%s]+)(.*)", "/%1", 1));
      if (command == strupper(SLASH_TT) or command == strupper(SLASH_TELLTARGET)) then
         local target = Confab_GetFriendlyTarget();
         if (target) then
             editBox.tellTarget = target;
             editBox.chatType = "WHISPER";
             editBox:SetText("");
             ChatEdit_UpdateHeader(editBox);
         end
      elseif (command == strupper(SLASH_RT) or command == strupper(SLASH_RETELL)) then
         if (LastSentTellTarget) then
            editBox.tellTarget = LastSentTellTarget;
            editBox.chatType = "WHISPER";
            editBox:SetText("");
            ChatEdit_UpdateHeader(editBox);
         end
      end
   end

   if (not Sea) then
      Org_ChatEdit_ParseText(editBox, send);
   end
end


Confab_ChatFrame_OpenChat = function(text, chatFrame)
   if ( not chatFrame ) then
      chatFrame = DEFAULT_CHAT_FRAME;
   end

   if (chatFrame.editBox.chatType == "CHANNEL") then
      local channelNum, channelName = GetChannelName(chatFrame.editBox.channelTarget);
      if (channelNum <= 0) then
      	 DEFAULT_CHAT_FRAME:AddMessage(CONFAB_STICKY_CHAN_INVALID1);
	 DEFAULT_CHAT_FRAME:AddMessage(CONFAB_STICKY_CHAN_INVALID2);
         chatFrame.editBox.chatType = "SAY"
         local tmp = string.gsub(ConfabUser[PlayerName].sticky, "%a+(%d%d?)", "%1");
	 if (tmp >= "0" and tmp <= "9") then
	    DEFAULT_CHAT_FRAME:AddMessage(CONFAB_STICKY_CHAN_INVALID3);
            ConfabUser[PlayerName].sticky = "default";
	 end
      end
   end

   ShowFlag = true;
   chatFrame.editBox:EnableKeyboard(true);
   chatFrame.editBox:SetFocus();

   if (not Sea) then
      local type = chatFrame.editBox.chatType;
      local sticky = chatFrame.editBox.stickyType;

      chatFrame.editBox.stickyType = "SAY";
      Org_ChatFrame_OpenChat(text, chatFrame);

      chatFrame.editBox.stickyType = sticky;
      chatFrame.editBox.chatType = type;
   else
      chatFrame.editBox.setText = 1;
      chatFrame.editBox.text = text;
   end

   if (not ConfabUser[PlayerName].autohide) then
      local tmp = this;
      this = chatFrame.editBox;
      Confab_OnShow();
      this = tmp;
   else
      chatFrame.editBox:Show();
   end

   if ((chatFrame.editBox.stickyType == "PARTY") and (GetNumPartyMembers() == 0) ) then
      if (chatFrame.editBox.chatType ~= "WHISPER") then  -- Fix for the reply bug after leaving a party when using the default chat sticky setting
	chatFrame.editBox.chatType = "SAY";
        ChatEdit_UpdateHeader(chatFrame.editBox);
      end
   elseif ((chatFrame.editBox.stickyType == "RAID") and (GetNumRaidMembers() == 0) ) then
      if (chatFrame.editBox.chatType ~= "WHISPER") then  -- Fix for the reply bug after leaving a party when using the default chat sticky setting
	chatFrame.editBox.chatType = "SAY";
        ChatEdit_UpdateHeader(chatFrame.editBox);
      end
   end
end


-- makes sure the GM help ticket editbox gets focus
local OrgHelpFrameOpenTicketShow = HelpFrameOpenTicket.Show;
HelpFrameOpenTicket.Show = function(obj)
    OrgHelpFrameOpenTicketShow(obj);
    HelpFrameOpenTicketText:SetFocus();
end;


Confab_ChatFrame_OnEvent = function(event)
   if (not Sea) then
      Org_ChatFrame_OnEvent(event);
   end

   if ((event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_GUILD" or 
       event == "CHAT_MSG_OFFICER" or event == "CHAT_MSG_RAID") and this ~= ChatFrame1) then
      FCF_FlashTab();
   end
end


Confab_FCF_Close = function(frame)
   if ( not frame ) then
      frame = FCF_GetCurrentChatFrame();
   end

   -- Check to see if we are closing the window the edit box is docked to.
   if (frame.editBox.dockedTo == frame:GetName()) then
      ConfabUser[PlayerName].relto = nil;
      Confab_SetStyle(ConfabStyles[ConfabUser[PlayerName].oldstyle], ConfabUser[PlayerName].autohide);
   elseif (frame.editBox.chatFrame == frame) then
      frame.editBox.chatFrame = ChatFrame1;
      Confab_SetChannelSticky(ChatFrameEditBox);
   end

   if (not Sea) then
      Org_FCF_Close(frame);
   end
end


Confab_FCFMessageTypeDropDown_OnClick = function()
   -- For some reason the game refuses to save these in chat-cache.txt so I have to save them myself.
   if (this.value == "RAID" or this.value == "OFFICER") then
      local checked = UIDropDownMenuButton_GetChecked();
      local chatFrameName = FCF_GetCurrentChatFrame():GetName();

      if (not ConfabUser[PlayerName][chatFrameName]) then
         ConfabUser[PlayerName][chatFrameName] = {};
      end

      if (checked) then
         ConfabUser[PlayerName][chatFrameName][this.value] = nil;
      else
         ConfabUser[PlayerName][chatFrameName][this.value] = 1;
      end
   end

   if (not Sea) then
      Org_FCFMessageTypeDropDown_OnClick();
   end
end


Confab_FCF_OpenNewWindow = function(name)
   if (not Sea) then
      Org_FCF_OpenNewWindow(name);
   end

   local chatFrame;
   local chatTab;
   local frameName;

   for i=1, NUM_CHAT_WINDOWS do
      chatFrame = getglobal("ChatFrame"..i);
      chatTab = getglobal("ChatFrame"..i.."Tab");
      frameName = chatFrame:GetName();
      if (chatTab:GetText() == name) then
         ChatFrame_AddMessageGroup(chatFrame, "OFFICER");
         ChatFrame_AddMessageGroup(chatFrame, "RAID"); 

         if (not ConfabUser[PlayerName][frameName]) then
            ConfabUser[PlayerName][frameName] = {};
         end
         ConfabUser[PlayerName][frameName]["RAID"] = 1;
	 ConfabUser[PlayerName][frameName]["OFFICER"] = 1;
         return;
      end
   end
end


Confab_FCF_SetWindowName = function(frame, name, doNotSave)
   if (not Sea) then
      Org_FCF_SetWindowName(frame, name, doNotSave);
   end
   Confab_SetChatFrameSticky(frame, name);
   Confab_SetChannelSticky(ChatFrameEditBox);
end


local prevChatFrameTab = nil;
Confab_FCF_Tab_OnClick = function(button)
   if (button == "RightButton" and FCF_Get_ChatLocked()) then
      return;
   end

   --if (not Sea) then
      Org_FCF_Tab_OnClick(button);
   --end

   if (prevChatFrameTab) then
      prevChatFrameTab:EnableMouse(true);
      prevChatFrameTab = nil;
   end

   local chatFrame = getglobal("ChatFrame"..this:GetID());
   local buttonState = this:GetButtonState();

   if ((buttonState == "NORMAL" and chatFrame.isDocked) or
       (buttonState == "PUSHED" and FCF_Get_ChatLocked() and chatFrame.isDocked)) then
      if (not ChatFrameEditBox.chatFrame.sticky) then
         ChatFrameEditBox.chatFrame.oldChatType = ChatFrameEditBox.chatType;
      end
      ChatFrameEditBox.chatFrame = chatFrame;
      Confab_SetChannelSticky(ChatFrameEditBox);
   end

   if (FCF_Get_ChatLocked()) then
      prevChatFrameTab = this;
      this:EnableMouse(false);
   end
end


Confab_FCF_UnDockFrame = function(frame)
   if (not Sea) then
      Org_FCF_UnDockFrame(frame);
   end

   if (ChatFrameEditBox.dockedTo ~= frame:GetName()) then
      ChatFrameEditBox.chatFrame = SELECTED_DOCK_FRAME;
      Confab_SetChannelSticky(ChatFrameEditBox);
   end
end


Confab_FCF_DockFrame = function(frame, index)
   if (not Sea) then
      Org_FCF_DockFrame(frame, index);
   end

   ChatFrameEditBox.chatFrame = SELECTED_DOCK_FRAME;
   Confab_SetChannelSticky(ChatFrameEditBox);
end


Confab_FCF_OnUpdate = function(elapsed)
   if (prevChatFrameTab and not FCF_Get_ChatLocked()) then
      prevChatFrameTab:EnableMouse(true);
      prevChatFrameTab = nil;
   end

   if (not Sea) then
      Org_FCF_OnUpdate(elapsed);
   end
end