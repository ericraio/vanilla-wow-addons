-- Purge entrys not seen since X weeks
SCCN_PURGEWEEKS = 4;

-------------------------------------------------
-- DEFAULT VARIABLES
-------------------------------------------------

	if( not SCCN_storage ) then SCCN_storage = { Skyhawk = { c=7, t=123} }; end;
	if( not SCCN_mousescroll ) then SCCN_mousescroll   = 1; end;
	if( not SCCN_hidechanname ) then SCCN_hidechanname = 0; end;
	if( not SCCN_shortchanname ) then SCCN_shortchanname = 0; end;
	if( not SCCN_colornicks ) then SCCN_colornicks   = 1; end;
	if( not SCCN_topeditbox ) then SCCN_topeditbox   = 0; end;
	if( not SCCN_timestamp ) then SCCN_timestamp     = 1; end;
	if( not SCCN_colormap )  then SCCN_colormap      = 1; end;
	if( not SCCN_hyperlinker )  then SCCN_hyperlinker = 1; end;
	if( not SCCN_selfhighlight )  then SCCN_selfhighlight = 1; end;
	if( not SCCN_clickinvite )  then SCCN_clickinvite = 1; end;
	if( not SCCN_editboxkeys )  then SCCN_editboxkeys = 1; end;
	if( not SCCN_chatstring )  then SCCN_chatstring = 1; end;
	if( not SCCN_selfhighlightmsg )  then SCCN_selfhighlightmsg = 1; end;
	if( not SCCN_ts_format ) then SCCN_ts_format     = "#33CCFF[$h:$m]"; end;
	if( not SCCN_HideChatButtons )  then SCCN_HideChatButtons = 0; end;
	if( not SCCN_Highlight_Text ) then SCCN_Highlight_Text = {}; end;
	if( not SCCN_Highlight ) then SCCN_Highlight = 0; end;
	if( not SCCN_AutoBGMap ) then SCCN_AutoBGMap = 1; end;	
	if( not SCCN_AutoGossipSkip ) then SCCN_AutoGossipSkip = 0; end;
	if( not SCCN_AutoDismount ) then SCCN_AutoDismount = 0; end;
	if( not SCCN_Chan_Replace ) then SCCN_Chan_Replace = {}; end;
	if( not SCCN_Chan_ReplaceWith ) then SCCN_Chan_ReplaceWith = {}; end;
	
	-- welcome dialog
	if( not SCCN_WELCOMESHOWED ) then SCCN_WELCOMESHOWED = 0; end;
	
	--

	
	local ChatFrame_OnEvent_Org;
	local ORG_AddMessage = nil;
	SCCN_EntrysConverted = 0;
	SCCN_INVITEFOUND = nil;
	
-- because RAID_CLASS_COLORS is not working always as intended (dont figured out why exactly) I using this.
	local SCCN_RAID_COLORS = {
	  HUNTER	= "|cffaad372",
	  WARLOCK	= "|cff9382C9",
	  PRIEST	= "|cffffffff",
	  PALADIN	= "|cfff48cba",
	  MAGE		= "|cff68ccef",
	  ROGUE		= "|cfffff468",
	  DRUID		= "|cffff7c0a",
	  SHAMAN	= "|cfff48cba",
	  WARRIOR	= "|cffc69b6d",
	  DEFAULT	= "|cffa0a0a0"};
-- Some Colors
	local COLOR = { 
		RED     = "|cffff0000",
		GREEN   = "|cff10ff10",
		BLUE    = "|cff0000ff",
		MAGENTA = "|cffff00ff",
		YELLOW  = "|cffffff00",
		ORANGE  = "|cffff9c00",
		CYAN    = "|cff00ffff",
		WHITE   = "|cffffffff",
		SILVER  = "|ca0a0a0a0"
	}
-------------------------------------------------
-- DEFAULT FUNCTIONS
-------------------------------------------------
function solColorChatNicks_OnLoad()
  	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
 	this:RegisterEvent("FRIENDLIST_UPDATE");
  	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("GUILD_ROSTER_UPDATE");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("UPDATE_WORLD_STATES"); 
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	this:RegisterEvent("GOSSIP_SHOW");

  -- Setting Slash commands  
  SlashCmdList["SCCN"] = solColorChatNicks_SlashCommand;
  SLASH_SCCN1 = "/sccn";
  SlashCmdList["TT"] = SCCN_CMD_TT;
  SLASH_TT1 = "/wt";  
end

function solColorChatNicks_OnEvent(event)
 if strsub(event, 1, 16) == "VARIABLES_LOADED" then
		-- confab compatibility
		if ( CONFAB_VERSION ) then
			SCCN_write(SCCN_CONFAB);
			SCCN_topeditbox   = 9;
		else
			-- top editbox
			SCCN_EditBox(SCCN_topeditbox);
		end
		-- chat hooks
		if ChatFrame_OnEvent_Org == nil then
			ChatFrame_OnEvent_Org = ChatFrame_OnEvent;
			ChatFrame_OnEvent = solColorChatNicks_ChatFrame_OnEvent;
		end
		if( SCCN_hyperlinker == 1 ) then
			-- catches URL's
			SCCN_Org_SetItemRef = SetItemRef;
			SetItemRef = SCCN_SetItemRef;
		end
		if( CHRONOS_REV ~= nil ) then
			Chronos.schedule(3,SCCN_write,"sOLARiZ Color Chat Nicks. v"..SCCN_VER.." loaded!");
			-- doing auto purge event 30 sec delayed
			Chronos.schedule(5,solColorChatNicks_PurgeDB);
			-- map pins
			Chronos.schedule(15,SCCN_RefreshIcons);
			-- URL ADD
			Chronos.schedule(10,SCCN_write,"Check out www.solariz.de/sccn for updates.");
		else
			-- no chronos, direct purge
			SCCN_write("sol's Color Chat Nicks. v"..SCCN_VER.." loaded!");
			-- doing auto purge event
			solColorChatNicks_PurgeDB();
			-- map pins
			SCCN_RefreshIcons();
		end
		-- refill
		if IsInGuild() then GuildRoster(); end
		if GetNumFriends() > 0 then ShowFriends(); end
		-- store original chat Editbox history buffer size
		SCCN_EditBoxKeysToggle(SCCN_editboxkeys);
		-- replacing chat some customized strings
		SCCN_CustomizeChatString(SCCN_chatstring);
		-- config dialog fillin
		SCCN_Config_OnLoad();
		-- Welcome Screen Fill in
		if( SCCN_WELCOMESHOWED ~= SCCN_VER ) then
			SCCN_WELCOMESCREEN:Show();
		end		

		
 elseif strsub(event, 1, 17) == "FRIENDLIST_UPDATE" then
	solColorChatNicks_InsertFriends();	
 elseif strsub(event, 1, 19) == "GUILD_ROSTER_UPDATE" then
	solColorChatNicks_InsertGuildMembers();
 elseif strsub(event, 1, 18) == "RAID_ROSTER_UPDATE" then
	solColorChatNicks_InsertRaidMembers();
	SCCN_RefreshIcons();
 elseif strsub(event, 1, 21) == "PARTY_MEMBERS_CHANGED" then
	solColorChatNicks_InsertPartyMembers();
	SCCN_RefreshIcons();
 elseif strsub(event, 1, 19) == "UPDATE_WORLD_STATES" then
	SCCN_RefreshIcons();
 elseif strsub(event, 1, 21) == "ZONE_CHANGED_NEW_AREA" then
	SCCN_BG_AutoMap();
 elseif event == "PLAYER_LEAVING_WORLD" then
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	-- Unregistering Events
 	this:UnregisterEvent("FRIENDLIST_UPDATE");
  	this:UnregisterEvent("RAID_ROSTER_UPDATE");
	this:UnregisterEvent("GUILD_ROSTER_UPDATE");
	this:UnregisterEvent("PARTY_MEMBERS_CHANGED");
	this:UnregisterEvent("UPDATE_WORLD_STATES"); 
	this:UnregisterEvent("ZONE_CHANGED_NEW_AREA");
	this:UnregisterEvent("GOSSIP_SHOW");
 elseif event == "PLAYER_ENTERING_WORLD" then
	-- re Register Events
 	this:RegisterEvent("FRIENDLIST_UPDATE");
  	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("GUILD_ROSTER_UPDATE");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("UPDATE_WORLD_STATES"); 
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	this:RegisterEvent("GOSSIP_SHOW");
 elseif ( event == "GOSSIP_SHOW" and not IsControlKeyDown() ) then
		SCCN_OnGOSSIP();
 end
end


function solColorChatNicks_PurgeDB()
	SCCN_purged = 0;
	SCCN_keept  = 0;
	SCCN_EntrysConverted = 0;
	SCCN_OldStorage = SCCN_storage;
	SCCN_storage = nil;
	SCCN_storage = {};
	table.foreach(SCCN_OldStorage, solColorChatNicks_PurgeEntry);
	if( SCCN_EntrysConverted > 0 ) then
		SCCN_write("Purged: "..SCCN_purged..", Keept: "..SCCN_keept.." Converted to "..SCCN_VER.." :"..SCCN_EntrysConverted);
		SCCN_EntrysConverted = nil;
	else
		SCCN_write("Purged: "..SCCN_purged..", Keept: "..SCCN_keept);
	end	
	SCCN_write("Memory currently used by SolsColorChatNicks Addon storage: "..ceil( (SCCN_keept*60) / 1024).." Kb");
	getglobal("SCCNConfigForm".."stat1".."Label"):SetText(COLOR["SILVER"].."SCCN Knows currently "..SCCN_keept.." Chars, this are ca. "..ceil( (SCCN_keept*60) / 1024).." Kb");
	SCCN_OldStorage = nil;
	SCCN_purged = nil;
	SCCN_keept  = nil;
end

function solColorChatNicks_PurgeEntry(k,v)
		if( (SCCN_OldStorage[k]["t"] + (3600*24*7*SCCN_PURGEWEEKS) ) < time() ) then 
			SCCN_purged = SCCN_purged + 1;
		else
			SCCN_storage[k] = { t=SCCN_OldStorage[k]["t"], c=SCCN_OldStorage[k]["c"] }
			SCCN_keept = SCCN_keept + 1;
		end
		-- Convert check for old version storage pre v.0.2
		if( SCCN_storage[k] ~= nil ) then   -- 0.5 formal 126 line error workaround
			if( SCCN_storage[k]["c"] ~= nil ) then
				if( SCCN_storage[k]["c"] ~= 0 and SCCN_storage[k]["c"] ~= 1 and SCCN_storage[k]["c"] ~= 2 and SCCN_storage[k]["c"] ~= 3 and SCCN_storage[k]["c"] ~= 4 and SCCN_storage[k]["c"] ~= 5 and SCCN_storage[k]["c"] ~= 6 and SCCN_storage[k]["c"] ~= 7 and SCCN_storage[k]["c"] ~= 8 and SCCN_storage[k]["c"] ~= 9 ) then
				  SCCN_storage[k]["c"] = solColorChatNicks_ClassToNum(SCCN_storage[k]["c"]);
				  SCCN_EntrysConverted = SCCN_EntrysConverted+1;
				end
			end
		end
end

function SCCN_write(msg)
	if( msg ~= nil ) then
		DEFAULT_CHAT_FRAME:AddMessage("|cffaad372".."Sol".."|cfffff468".."CCN".."|cffffffff: "..msg);
	end
end

-------------------------------------------------
-- CHAT FRAME MANIPULATION FUNCTIONS
-------------------------------------------------
function solColorChatNicks_ChatFrame_OnEvent(event)
	 if( not this.ORG_AddMessage ) then
		this.ORG_AddMessage = this.AddMessage
		this.AddMessage = S_AddMessage
	 end;
	 if( SCCN_colornicks == 1) then 
		this.solColorChatNicks_Name = arg2;
	 end
	 -- Strip channel name
	 if arg9 and event ~= "CHAT_MSG_CHANNEL_NOTICE" then
		local _, _, strippedChannelName = string.find(arg9, "(.-)%s.*");
	 	this.solColorChatNicks_Channelname = strippedChannelName;
	 end	 
	 -- Call original handler
	 ChatFrame_OnEvent_Org(event);
end

function S_AddMessage(this,text,r,g,b,id)
	  if SCCN_hidechanname == 1 and this.solColorChatNicks_Channelname then
		-- Remove channel name	
		text = string.gsub(text, ".%s" .. this.solColorChatNicks_Channelname, "", 1);
		this.solColorChatNicks_Channelname = nil;	  
	  end
	if ( (SCCN_hidechanname == 1) and text ~= nil ) then  
	-- remove Guild, Party, Raid from chat channel name  
		for i=1, table.getn(SCCN_STRIPCHAN) do
			text = string.gsub(text, "(%[)(%d?)(.?%s?"..SCCN_STRIPCHAN[i].."%s?)(%])(%s?)", SCCN_STRIPCHANNAMEFUNC,1);
		end
	elseif ( SCCN_shortchanname == 1 ) then
		-- Short Channel Names
		local temp = nil;
		if text ~= nil then
			for i = 1, 9 do
				if SCCN_Chan_Replace[i] ~= nil and SCCN_Chan_ReplaceWith[i] ~= nil then
					temp = string.gsub(text, SCCN_Chan_Replace[i].."]%s", SCCN_Chan_ReplaceWith[i].."]", 1)
					if temp ~= text then
						text = temp;
						temp = nil;
						break;
					end
				end		
			end
		end
	end
	
	-- color self in text
	  if( SCCN_selfhighlight == 1 and text ~= nil ) then
	     if( arg8 ~= 3 and arg8 ~= 4 ) then
		if( arg2 ~= nil and arg2 ~= UnitName("player") and UnitName("player") ~= nil and string.len(text) >= string.len(UnitName("player")) ) then
			if(string.find(text, UnitName("player")) or string.find(text, string.lower(UnitName("player")))) then
				-- NO CTRA and NO DMSYNC
				if(not string.find(text, "<CTRaid>") and not string.find(text, "SYNCE_") and not string.find(text, "SYNC_") ) then
					text = string.gsub(text, "([^:^%[]"..UnitName("player")..")" , " "..COLOR["YELLOW"]..">"..COLOR["RED"]..UnitName("player")..COLOR["YELLOW"].."<|r");
					text = string.gsub(text, "([^:^%[]"..string.lower(UnitName("player"))..")" , " "..COLOR["YELLOW"]..">"..COLOR["RED"]..UnitName("player")..COLOR["YELLOW"].."<|r");
					-- On Screen Msg
					if( SCCN_selfhighlightmsg == 1 ) then
						UIErrorsFrame:AddMessage(text, 1, 1, 1, 1.0, UIERRORS_HOLD_TIME);
						PlaySound("FriendJoinGame");
					end
				end
			end
		end
	     end
	  end
	-- Custom Highlight /SCCN highlight
		SCCN_Custom_Highlighted = false;
		
	   if SCCN_Custom_Highlighted == false then text = SCCN_CustomHighlightProcessor(text,SCCN_Highlight_Text[1]); end;
	   if SCCN_Custom_Highlighted == false then text = SCCN_CustomHighlightProcessor(text,SCCN_Highlight_Text[2]); end;
	   if SCCN_Custom_Highlighted == false then text = SCCN_CustomHighlightProcessor(text,SCCN_Highlight_Text[3]); end;
	
	-- color nick's
	  if this.solColorChatNicks_Name and string.len(this.solColorChatNicks_Name) > 2  and text ~= nil and arg2 ~= nil then
	    text = string.gsub(text, "(.-)"..this.solColorChatNicks_Name .. "([%]%s].*)", "%1"..solColorChatNicks_GetColorFor(this.solColorChatNicks_Name)..this.solColorChatNicks_Name.."|r%2", 1);
	  end
	  this.solColorChatNicks_Name = nil;
	-- Timestamp
	  if( SCCN_timestamp == 1 and text ~= nil ) then
		  local hour  = tonumber(string.sub(date(),  10, 11));
		  local minute= tonumber(string.sub(date(),  13, 14));
		  local second= tonumber(string.sub(date(),  16, 17));
		  local periode = "";
		  local hour12  = "";
		  if hour > 0 and hour < 12 then
			periode = "am";
			hour12  = hour;
		  else
			periode = "pm";  
			hour12  = hour-12;
		  end  		
		  -- 2 digit
		  if( string.len(tostring(hour)) < 2) then hour = "0"..tostring(hour); end
		  if( string.len(tostring(hour12)) < 2) then hour12 = "0"..tostring(hour12); end  
		  if( string.len(tostring(minute)) < 2) then minute = "0"..tostring(minute); end 
		  if( string.len(tostring(second)) < 2) then second = "0"..tostring(second); end  
		  -- setting timestamp
		  local TimeStamp = SCCN_ts_format;
		  TimeStamp = string.gsub(TimeStamp, "$h", hour);
		  TimeStamp = string.gsub(TimeStamp, "$m", minute);
		  TimeStamp = string.gsub(TimeStamp, "$s", second);
		  TimeStamp = string.gsub(TimeStamp, "$p", periode);
		  TimeStamp = string.gsub(TimeStamp, "$t", hour12);
		  TimeStamp = string.gsub(TimeStamp, "#", "|cff");
		  text = TimeStamp.."|r "..text;
	  end
 	-- URL detection
	  if( SCCN_hyperlinker == 1 and text ~= nil ) then
		  SCCN_URLFOUND = nil;
		  -- numeric IP's  123.123.123.123:12345
		  if SCCN_URLFOUND == nil then text = string.gsub(text, "(%s?)(%d%d?%d?%.%d%d?%d?%.%d%d?%d?%.%d%d?%d?:%d%d?%d?%d?%d?)(%s?)", SCCN_GetURL); end;
		  -- TeamSpeak like IP's sub.domain.org:12345  or domain.de:123
		  if SCCN_URLFOUND == nil then text = string.gsub(text, "(%s?)([%w_-]+%.?[%w_-]+%.[%w_-]+:%d%d%d?%d?%d?)(%s?)", SCCN_GetURL); end;
		  -- complete http urls  
		  if SCCN_URLFOUND == nil then text = string.gsub(text, "(%s?)(%a+://[%w_/%.%?%%=~&-]+)(%s?)", SCCN_GetURL); end;
		  -- www.URL.de
		  if SCCN_URLFOUND == nil then text = string.gsub(text, "(%s?)(www%.[%w_/%.%?%%=~&-]+)(%s?)", SCCN_GetURL); end;
		  -- test@test.de
		  if SCCN_URLFOUND == nil then text = string.gsub(text, "(%s?)([_%w-%.~-]+@[_%w-]+%.[_%w-%.]+)(%s?)", SCCN_GetURL); end;
	  end
	-- clickinvite
	  if( SCCN_clickinvite == 1 and text ~= nil and arg2 ~= nil ) then
		 SCCN_INVITEFOUND = nil; 
 		 if SCCN_INVITEFOUND == nil then text = string.gsub(text, "(%s?[^%a])(invite)[^%a](%s?)", SCCN_ClickInvite,1); end
		 if SCCN_INVITEFOUND == nil then text = string.gsub(text, "(%s)(invite)[^%a](%s?)", SCCN_ClickInvite,1); end
 		 if SCCN_INVITEFOUND == nil then text = string.gsub(text, "(%s?[^%a])(inv)[^%a](%s?)", SCCN_ClickInvite,1); end
		 if SCCN_INVITEFOUND == nil then text = string.gsub(text, "(%s)(inv)[^%a](%s?)", SCCN_ClickInvite,1); end
		 if SCCN_INVITEFOUND == nil and SCCN_CUSTOM_INV ~= nil then
		        -- custom invite word in localization
			for i=1, table.getn(SCCN_CUSTOM_INV) do
				if SCCN_INVITEFOUND == nil then text = string.gsub(text, "(%s?[^%a])("..SCCN_CUSTOM_INV[i]..")(%a?)", SCCN_ClickInvite,1); end
				if SCCN_INVITEFOUND == nil then text = string.gsub(text, "(%s)("..SCCN_CUSTOM_INV[i]..")(%s?)", SCCN_ClickInvite,1); end
			end
		 end
  	     if SCCN_INVITEFOUND == nil then text = string.gsub(text, "(%s?[^%a])(invite)(%a?)", SCCN_ClickInvite,1); end
		 if SCCN_INVITEFOUND == nil then text = string.gsub(text, "(%s?[^%a])(inv)(%a?)", SCCN_ClickInvite,1); end  
	  end
	-- output
	if (this.ORG_AddMessage ~= nil) then
		this:ORG_AddMessage(text,r,g,b,id);
	end
end

function SCCN_CustomHighlightProcessor(text,SCCN_Custom_Highlight_Word)
	  if ( SCCN_Highlight == 1 and SCCN_Custom_Highlight_Word and string.len(text) >= string.len(SCCN_Custom_Highlight_Word) and string.len(SCCN_Custom_Highlight_Word) > 2 ) then 
		if( string.find(text,string.lower(SCCN_Custom_Highlight_Word)) or string.find(text,SCCN_Custom_Highlight_Word) ) then
			-- NO CTRA and NO DMSYNC
			if(not string.find(text, "<CTRaid>") and not string.find(text, "SYNCE_") and not string.find(text, "SYNC_") ) then
				if( text ~= string.gsub(text, "([^:^%[]"..SCCN_Custom_Highlight_Word..")" , "")) then
					text = string.gsub(text, "([^:^%[]"..SCCN_Custom_Highlight_Word..")" , " "..COLOR["YELLOW"]..">"..COLOR["RED"]..SCCN_Custom_Highlight_Word..COLOR["YELLOW"].."<|r");
				else
					text = string.gsub(text, "([^:^%[]"..string.lower(SCCN_Custom_Highlight_Word)..")" , " "..COLOR["YELLOW"]..">"..COLOR["RED"]..string.lower(SCCN_Custom_Highlight_Word)..COLOR["YELLOW"].."<|r");
				end
				-- On Screen Msg
				UIErrorsFrame:AddMessage(text, 1, 1, 1, 1.0, UIERRORS_HOLD_TIME);
				PlaySound("FriendJoinGame");
				-- set already highlighted = True
				SCCN_Custom_Highlighted = true;
			end		
		end
	  end
	  return text;
end

function SCCN_OnMouseWheel(chatframe, value)
  if( SCCN_mousescroll == 1 ) then
	if IsShiftKeyDown()  then
		-- shift key pressed (Fast scroll)  
		if ( value > 0 ) then
			for i = 1,5 do chatframe:ScrollUp(); end;
		elseif ( value < 0 ) then
			for i = 1,5 do chatframe:ScrollDown(); end;
		end
	elseif IsControlKeyDown() then
		-- to top / to bottom
		if ( value > 0 ) then
			chatframe:ScrollToTop();
		elseif ( value < 0 ) then
			chatframe:ScrollToBottom();
		end		
	else
		-- Normal Scroll without shift key  
		if ( value > 0 ) then
			chatframe:ScrollUp();
		elseif ( value < 0 ) then
			chatframe:ScrollDown();
		end
    end 
  end
end  

function SCCN_EditBox(where)
	if(where == 1) then
		-- top
		ChatFrameEditBox:ClearAllPoints();
		ChatFrameEditBox:SetPoint("BOTTOMLEFT", "ChatFrame1", "TOPLEFT", 0, 2);
		ChatFrameEditBox:SetPoint("BOTTOMRIGHT", "ChatFrame1", "TOPRIGHT", 0, 2);
	elseif(where == 0) then
		-- bottom
		-- ChatFrameEditBox:ClearAllPoints();
		ChatFrameEditBox:SetPoint("BOTTOMLEFT", "ChatFrame1", "BOTTOMLEFT", 0, -28);
		ChatFrameEditBox:SetPoint("BOTTOMRIGHT", "ChatFrame1", "BOTTOMRIGHT", 0, -28);
	end
end

function SCCN_CustomizeChatString(status)
	if OLD_CHAT_WHISPER_GET == nil then OLD_CHAT_WHISPER_GET = CHAT_WHISPER_GET; end
	if OLD_CHAT_WHISPER_INFORM_GET == nil then OLD_CHAT_WHISPER_INFORM_GET = CHAT_WHISPER_INFORM_GET; end;
	if( status == 1 ) then
		CHAT_WHISPER_GET = SCCN_CUSTOM_CHT_FROM.." ";
		CHAT_WHISPER_INFORM_GET = SCCN_CUSTOM_CHT_TO.." ";
	else
		-- restore original
		CHAT_WHISPER_GET = OLD_CHAT_WHISPER_GET;
		CHAT_WHISPER_INFORM_GET = OLD_CHAT_WHISPER_INFORM_GET;
	end
end

function SCCN_EditBoxKeysToggle(status)
	if SCCN_OrgHistoryLines == nil then SCCN_OrgHistoryLines = ChatFrameEditBox:GetHistoryLines(); end
	if( status == 1 ) then
		ChatFrameEditBox:SetHistoryLines(250);
		ChatFrameEditBox:SetAltArrowKeyMode(false);
	else
		-- restore original
		ChatFrameEditBox:SetHistoryLines(16);
		ChatFrameEditBox:SetHistoryLines(SCCN_OrgHistoryLines);
		ChatFrameEditBox:SetAltArrowKeyMode(true);
	end		
end

function SCCN_STRIPCHANNAMEFUNC(a,b,c,d,e)
	-- a = (%[)
	-- b = (%d?)
	-- c = (.?%s?"..SCCN_STRIPCHAN[i].."%]%s?)
	-- d = (%])
	-- e = (%s?)
	if(SCCN_hidechanname == 1) then 
		if(c ~= nil and string.find(c,"%.") ) then
			return a..b..d..e;
		else
			return;
		end
	end
	--getglobal("SCCNConfigForm".."ver1".."Label"):SetText(COLOR["RED"].."A["..COLOR["WHITE"]..a..COLOR["RED"].."] B["..COLOR["WHITE"]..b..COLOR["RED"].."] C["..COLOR["WHITE"]..c..COLOR["RED"].."] D["..COLOR["WHITE"]..d..COLOR["RED"].."]");
end

function SCCN_ChatFrame_OnUpdate()
   local BottomButton	= getglobal(this:GetParent():GetName().."BottomButton");
   local DownButton	= getglobal(this:GetParent():GetName().."DownButton");
   local UpButton	= getglobal(this:GetParent():GetName().."UpButton");
   if( SCCN_HideChatButtons == 1 ) then
	   if BottomButton:IsVisible() then BottomButton:Hide(); end
	   if DownButton:IsVisible() then DownButton:Hide(); end
	   if UpButton:IsVisible() then UpButton:Hide(); end
	   if ChatFrameMenuButton:IsVisible() then ChatFrameMenuButton:Hide(); end
   else
	   if not BottomButton:IsVisible() then BottomButton:Show(); end
	   if not DownButton:IsVisible() then DownButton:Show(); end
	   if not UpButton:IsVisible() then UpButton:Show(); end
	   if not ChatFrameMenuButton:IsVisible() then ChatFrameMenuButton:Show(); end
   end

end

function SCCN_KeyBinding_ChatFrameEditBox(kommando)
	if (not ChatFrameEditBox:IsVisible()) then
		ChatFrame_OpenChat(kommando);
	else
		ChatFrameEditBox:SetText(kommando);
	end;
	ChatFrameEditBox:Show();
	ChatEdit_ParseText(ChatFrame1.editBox,0);
end

-------------------------------------------------
-- MOD INTERFACE FOR 3rd PARTY MODS
-------------------------------------------------
function SCCN_ForgottenChatNickName(Name)
	local FCcolor = solColorChatNicks_GetColorFor(Name);
	if( FCcolor ~= nil ) then
		return solColorChatNicks_GetColorFor(Name)..Name.."|r";
	else
		return Name;
	end
end

-------------------------------------------------
-- INFORMATION GATHERING FUNCTIONS
-------------------------------------------------
-- Color management
function solColorChatNicks_GetColorFor(name)
	-- Default color
	color = "";
	-- Check if unit name exists in storage
	if( SCCN_storage[name] ~= nil ) then
		color = solColorChatNicks_GetClassColor(SCCN_storage[name]["c"]);
	elseif( name == UnitName("player") ) then
	 -- You are the person. That's easy
		local _, class = UnitClass("player");
		local class = solColorChatNicks_ClassToNum(class);
		color = solColorChatNicks_GetClassColor(class);
		SCCN_storage[name] = { c = class, t=time() };
	end
   
	return color;
end
		
function solColorChatNicks_InsertFriends()
  -- add current online friends
  for i = 1, GetNumFriends() do
    local name, _, class, _ = GetFriendInfo(i);
	local class = solColorChatNicks_ClassToNum(class);
	if( class ~= nil and name ~= nil ) then
		SCCN_storage[name] = { c = class, t=time() };
	end
  end
end	

function solColorChatNicks_InsertGuildMembers()
  -- add current online guild members
  for i = 1, GetNumGuildMembers() do
	local name,_,_,_,class = GetGuildRosterInfo(i);  
	local class = solColorChatNicks_ClassToNum(class);
	if( class ~= nil and name ~= nil ) then
		SCCN_storage[name] = { c = class, t=time() };
	end
  end
end

function solColorChatNicks_InsertRaidMembers()
  for i = 1, GetNumRaidMembers() do
    local name, _, _, _, _, class = GetRaidRosterInfo(i);
	local class = solColorChatNicks_ClassToNum(class);
	if( class ~= nil and name ~= nil ) then
		SCCN_storage[name] = { c = class, t=time() };
	end
  end	
end

function solColorChatNicks_InsertPartyMembers()
  for i = 1, GetNumPartyMembers() do
    local unit = "party" .. i;
    local _, class = UnitClass(unit);
	local name     = UnitName(unit);
 	local class = solColorChatNicks_ClassToNum(class);
	if( class ~= nil and name ~= nil ) then
		SCCN_storage[name] = { c = class, t=time() };
	end   
  end	
end

-------------------------------------------------
-- CONVERTER / GET FROM ARRAY   FUNCTIONS
-------------------------------------------------
function solColorChatNicks_ClassToNum(class)
	if(class == "WARLOCK" or class == SCCN_LOCAL_CLASS["WARLOCK"]) then
		return 1;
	elseif(class == "HUNTER" or class == SCCN_LOCAL_CLASS["HUNTER"]) then
		return 2;
	elseif(class == "PRIEST" or class == SCCN_LOCAL_CLASS["PRIEST"]) then
		return 3;
	elseif(class == "PALADIN" or class == SCCN_LOCAL_CLASS["PALADIN"]) then		
		return 4;
	elseif(class == "MAGE" or class == SCCN_LOCAL_CLASS["MAGE"]) then	
		return 5;
	elseif(class == "ROGUE" or class == SCCN_LOCAL_CLASS["ROGUE"]) then
		return 6;
	elseif(class == "DRUID" or class == SCCN_LOCAL_CLASS["DRUID"]) then
		return 7;
	elseif(class == "SHAMAN" or class == SCCN_LOCAL_CLASS["SHAMAN"]) then
		return 8;
	elseif(class == "WARRIOR" or class == SCCN_LOCAL_CLASS["WARRIOR"]) then
		return 9;
	end
	return 0;
end

function solColorChatNicks_ClassNumToRGB(classnum)
	if(classnum == 1) then return {r=100,g=0,b=112}
	elseif(classnum == 2) then return {r=81,g=140,b=11}
	elseif(classnum == 3) then return {r=1,g=1,b=1}
	elseif(classnum == 4) then return {r=255,g=0,b=255}
	elseif(classnum == 5) then return {r=0,g=180,b=240}
	elseif(classnum == 6) then return {r=220,g=200,b=0}
	elseif(classnum == 7) then return {r=240,g=136,b=0}
	elseif(classnum == 8) then return {r=255,g=0,b=255}
	elseif(classnum == 9) then return {r=147,g=112,b=67}
	else return {r=0,g=0,b=0}; end
end

function solColorChatNicks_GetClassColor(class)
	if(class == 1) 		then return SCCN_RAID_COLORS["WARLOCK"];
	elseif(class == 2) 	then return SCCN_RAID_COLORS["HUNTER"];
	elseif(class == 3) 	then return SCCN_RAID_COLORS["PRIEST"];
	elseif(class == 4) 	then return SCCN_RAID_COLORS["PALADIN"];
	elseif(class == 5) 	then return SCCN_RAID_COLORS["MAGE"];
	elseif(class == 6) 	then return SCCN_RAID_COLORS["ROGUE"];
	elseif(class == 7) 	then return SCCN_RAID_COLORS["DRUID"];
	elseif(class == 8) 	then return SCCN_RAID_COLORS["SHAMAN"];
	elseif(class == 9) 	then return SCCN_RAID_COLORS["WARRIOR"];
	end
	return SCCN_RAID_COLORS["DEFAULT"];
end

-------------------------------------------------
-- Map Stuff
-------------------------------------------------
function SCCN_RefreshIcons()
 if( UnitInRaid("player") and SCCN_colormap == 1 and GetNumRaidMembers() > 0 ) then
	local classcolor = {}
	local icon = "Interface\\AddOns\\solColorChatNicks\\gfx\\Icon";
	local icon2 = icon.."2";
    for i=1, MAX_RAID_MEMBERS do
		-- Full WorldMap colored Icons
			local raidMemberFrame = getglobal("WorldMapRaid"..i);
			if ( UnitInRaid(raidMemberFrame.unit) ) then
				for x=1, GetNumRaidMembers() do
					local name, _, _, _, _, class = GetRaidRosterInfo(x);
					if ( name == UnitName(raidMemberFrame.unit) ) then
						getglobal(raidMemberFrame:GetName().."Icon"):SetTexture(icon2);
						local iconColor = RAID_CLASS_COLORS[class];
						getglobal(raidMemberFrame:GetName().."Icon"):SetVertexColor(iconColor.r, iconColor.g, iconColor.b);
						break;
					end
				end  				
			else
				getglobal(raidMemberFrame:GetName().."Icon"):SetTexture(icon);
				getglobal(raidMemberFrame:GetName().."Icon"):SetVertexColor(0.6, 0.6, 0.6);
			end
		-- BattleField Minimap colored icons
		if ( IsAddOnLoaded("Blizzard_BattlefieldMinimap")  ) then		
			local BFMMFrame = getglobal("BattlefieldMinimapRaid"..i);
			if ( UnitInRaid(BFMMFrame.unit) ) then
				for x=1, GetNumRaidMembers() do
					local name, _, _, _, _, class = GetRaidRosterInfo(x);
					if ( name == UnitName(BFMMFrame.unit) ) then
						local iconColor = RAID_CLASS_COLORS[class];
						getglobal(BFMMFrame:GetName().."Icon"):SetTexture(icon2);
						getglobal(BFMMFrame:GetName().."Icon"):SetVertexColor(iconColor.r, iconColor.g, iconColor.b);
						break;
					end
				end    
			else
				getglobal(BFMMFrame:GetName().."Icon"):SetTexture(icon);
				getglobal(BFMMFrame:GetName().."Icon"):SetVertexColor(0.6, 0.6, 0.6);
			end
		end
	end    
  end  
end

function SCCN_BG_AutoMap(event)
	if( SCCN_AutoBGMap == 1 ) then
		local zone_text = GetZoneText()
		if (zone_text == SCCN_LOCAL_ZONE["alterac"] or zone_text == SCCN_LOCAL_ZONE["warsong"] or zone_text == SCCN_LOCAL_ZONE["arathi"]) then
			SCCN_write("Zone change into '"..zone_text.."' detected. AutoToggle BGMiniMap...");
			ToggleBattlefieldMinimap();
		end
	end
end


--------------------------------------------------
-- Hyperlink and make clickable in chat Stuff
--------------------------------------------------
function SCCN_HyperlinkWindow(url)
	if( url ~= nil ) then
		getglobal( "solHyperlinkerEditBox" ):SetText( url );
		-- solHyperlinkerForm:Hide();
		solHyperlinkerForm:Show();
	end
end

function SCCN_GetURL(before, URL, after)
	SCCN_URLFOUND = 1;
	return before.."|cff".."9999EE".. "|Href:" .. URL .. "|h[".. URL .."]|h|r" ..  after;
end

function SCCN_SetItemRef(link, text, button)
	if (string.sub(link, 1 , 3) == "ref") then
		SCCN_HyperlinkWindow(string.sub(link,5));
		return;
	elseif (string.sub(link, 1 , 3) == "inv") then 
		InviteByName(string.sub(link,5));
	else
		SCCN_Org_SetItemRef(link, text, button);
	end
end

function SCCN_ChanRewrite(before, msg, after)
	-- maybe doing something special herein later
	-- my Idea is to switch from highlighting to hiding or shortening
	
--	after = string.gsub(after , "]", "");
	return before..after;
end

function SCCN_ClickInvite(before, msg, after)
	if( string.len(after) > 0 and string.sub(after,1,1) ~= " " ) then
		return before..msg..after;
	end
	SCCN_INVITEFOUND = true;
	return before.."|Hinv:" .. arg2 .. "|h["..msg.."]|h"..after;
end

--------------------------------------------------
-- Slash Command handlers
--------------------------------------------------
function SCCN_CMD_TT(msg)
	if( UnitName("target") == nil ) then
		SCCN_write("No Target for /tt");
		return false;
	end
	if( msg ~= nil and string.len(msg) > 1 ) then	
		-- send a whisper to your target
		SendChatMessage(msg, "WHISPER", this.language, UnitName("target"));
	else
		SCCN_write("Use: /tt This is a example!");
	end
end

function solColorChatNicks_SlashCommand(cmd)
	-- This function handle the Help and general Option calls
	local cmd = string.lower(cmd);
	if    ( cmd == "hidechanname") then
		if SCCN_hidechanname == 0 then 
			SCCN_hidechanname = 1;
			SCCN_write(SCCN_CMDSTATUS[1].."|cff00ff00".." ON");
		else 
			SCCN_hidechanname = 0; 
			SCCN_write(SCCN_CMDSTATUS[1].."|cffff0000".." OFF");
		end;
	elseif( cmd == "colornicks") then
		if SCCN_colornicks == 0 then 
			SCCN_colornicks = 1;
			SCCN_write(SCCN_CMDSTATUS[2].."|cff00ff00".." ON");
		else 
			SCCN_colornicks = 0; 
			SCCN_write(SCCN_CMDSTATUS[2].."|cffff0000".." OFF");
		end;
	elseif( cmd == "mousescroll") then
		if SCCN_mousescroll == 0 then 
			SCCN_mousescroll = 1;
			SCCN_write(SCCN_CMDSTATUS[3].."|cff00ff00".." ON");
		else 
			SCCN_mousescroll = 0; 
			SCCN_write(SCCN_CMDSTATUS[3].."|cffff0000".." OFF");
		end;
	elseif( cmd == "topeditbox") then
		if( CONFAB_VERSION ) then SCCN_write(SCCN_CONFAB); return false; end;
  	    if( SCCN_topeditbox == 1 ) then
			SCCN_topeditbox = 0;
			SCCN_EditBox(0);
			SCCN_write(SCCN_CMDSTATUS[4].."|cffff0000".." OFF");
		else
			SCCN_topeditbox = 1;
			SCCN_EditBox(1);
			SCCN_write(SCCN_CMDSTATUS[4].."|cff00ff00".." ON");
		end
	elseif( cmd == "colormap") then
  	    if( SCCN_colormap == 1 ) then
			SCCN_colormap = 0;
			SCCN_write(SCCN_CMDSTATUS[6].."|cffff0000".." OFF");
		else
			SCCN_colormap = 1;
			SCCN_write(SCCN_CMDSTATUS[6].."|cff00ff00".." ON");
			SCCN_RefreshIcons();
		end		
	elseif( strsub(cmd, 1, 9) == "timestamp") then
		if(string.len(cmd) > 9) then
		 -- more then just the toggleswitch
		  local more = strsub(cmd, 11);
			if more then
				if(more == "?" or more == "help") then
					SCCN_write(SCCN_TS_HELP);
				else  
					SCCN_ts_format = more;
					SCCN_write("Timestamp format changed to: "..SCCN_ts_format);
				end
			else
				SCCN_write(SCCN_TS_HELP);
			end
	    else
			if SCCN_timestamp == 0 then 
				SCCN_timestamp = 1;
				SCCN_write(SCCN_CMDSTATUS[5].."|cff00ff00".." ON");
			else 
				SCCN_timestamp = 0; 
				SCCN_write(SCCN_CMDSTATUS[5].."|cffff0000".." OFF");
			end;
		end
	elseif( cmd == "selfhighlight") then
		if SCCN_selfhighlight == 0 then 
			SCCN_selfhighlight = 1;
			SCCN_write(SCCN_CMDSTATUS[8].."|cff00ff00".." ON");
		else 
			SCCN_selfhighlight = 0; 
			SCCN_write(SCCN_CMDSTATUS[8].."|cffff0000".." OFF");
		end;
	elseif( cmd == "clickinvite") then
		if SCCN_clickinvite == 0 then 
			SCCN_clickinvite = 1;
			SCCN_write(SCCN_CMDSTATUS[9].."|cff00ff00".." ON");
		else 
			SCCN_clickinvite = 0; 
			SCCN_write(SCCN_CMDSTATUS[9].."|cffff0000".." OFF");
		end;
	elseif( cmd == "editboxkeys") then
		if SCCN_editboxkeys == 0 then
			SCCN_EditBoxKeysToggle(1);
			SCCN_editboxkeys = 1;
			SCCN_write(SCCN_CMDSTATUS[10].."|cff00ff00".." ON");
		else 
			SCCN_EditBoxKeysToggle(0);
			SCCN_editboxkeys = 0; 
			SCCN_write(SCCN_CMDSTATUS[10].."|cffff0000".." OFF");
		end;
	elseif( cmd == "selfhighlightmsg") then
		if SCCN_selfhighlightmsg == 0 then 
			SCCN_selfhighlightmsg = 1;
			SCCN_write(SCCN_CMDSTATUS[12].."|cff00ff00".." ON");
		else 
			SCCN_selfhighlightmsg = 0; 
			SCCN_write(SCCN_CMDSTATUS[12].."|cffff0000".." OFF");
		end;		
	elseif( cmd == "chatstring") then
		if SCCN_chatstring == 0 then 
			SCCN_chatstring = 1;
			SCCN_write(SCCN_CMDSTATUS[11].."|cff00ff00".." ON");
			SCCN_CustomizeChatString(1);
		else 
			SCCN_chatstring = 0; 
			SCCN_write(SCCN_CMDSTATUS[11].."|cffff0000".." OFF");
			SCCN_CustomizeChatString(0);
		end;	
	elseif( cmd == "hyperlink") then
		if SCCN_hyperlinker == 0 then 
			SCCN_hyperlinker = 1;
			SCCN_write(SCCN_CMDSTATUS[7].."|cff00ff00".." ON");
			SCCN_Org_SetItemRef = SetItemRef;
			SetItemRef = SCCN_SetItemRef;			
		else
			SCCN_hyperlinker = 0; 
			SCCN_write(SCCN_CMDSTATUS[7].."|cffff0000".." OFF");
			if( SCCN_Org_SetItemRef ) then
				SetItemRef = SCCN_Org_SetItemRef;
			end
		end;		
	elseif( cmd == "purge" ) then 
		solColorChatNicks_PurgeDB();
	elseif( cmd == "hidechatbuttons" ) then
		if(SCCN_HideChatButtons == 1) then
			SCCN_HideChatButtons = 0;
			SCCN_write(SCCN_CMDSTATUS[13].."|cffff0000".." OFF");
		else
			SCCN_HideChatButtons = 1;
			SCCN_write(SCCN_CMDSTATUS[13].."|cff00ff00".." ON");
		end
	elseif( cmd == "killdb" ) then
		SCCN_write("Whiped complete Database.");
		SCCN_storage = {};
		SCCN_OldStorage = {};
		solColorChatNicks_PurgeDB();
	elseif( cmd == "highlight" ) then
		if(SCCN_Highlight == 1) then
			SCCN_Highlight = 0;
			SCCN_write(SCCN_CMDSTATUS[15].."|cffff0000".." OFF");
		else
			SCCN_Highlight = 1;
			SCCN_write(SCCN_CMDSTATUS[15].."|cff00ff00".." ON");
		end		
	elseif( cmd == "autobgmap" ) then 
		if(SCCN_AutoBGMap == 1) then
			SCCN_AutoBGMap = 0;
			SCCN_write(SCCN_CMDSTATUS[14].."|cffff0000".." OFF");
		else
			SCCN_AutoBGMap = 1;
			SCCN_write(SCCN_CMDSTATUS[14].."|cff00ff00".." ON");
		end
	elseif( cmd == "autogossipskip" ) then 
		if(SCCN_AutoGossipSkip == 1) then
			SCCN_AutoGossipSkip = 0;
			SCCN_write(SCCN_CMDSTATUS[17].."|cffff0000".." OFF");
		else
			SCCN_AutoGossipSkip = 1;
			SCCN_write(SCCN_CMDSTATUS[17].."|cff00ff00".." ON");
		end		
	elseif( cmd == "autodismount" ) then 
		if(SCCN_AutoDismount == 1) then
			SCCN_AutoDismount = 0;
			SCCN_write(SCCN_CMDSTATUS[18].."|cffff0000".." OFF");
		else
			SCCN_AutoDismount = 1;
			SCCN_write(SCCN_CMDSTATUS[18].."|cff00ff00".." ON");
		end			
	elseif( cmd == "shortchanname" ) then 
		if(SCCN_shortchanname == 1) then
			SCCN_shortchanname = 0;
			SCCN_write(SCCN_CMDSTATUS[16].."|cffff0000".." OFF");
		else
			SCCN_shortchanname = 1;
			SCCN_write(SCCN_CMDSTATUS[16].."|cff00ff00".." ON");
		end
	elseif( cmd == "about" ) then
		SCCN_WELCOMESCREEN:Show();
	elseif( cmd == "status" ) then
		SCCN_write("|cff006CFF ---[sOLARiZ Color Chat Nick's Status]---");
		if( SCCN_colornicks == 1) then 	SCCN_write(SCCN_CMDSTATUS[2].."|cff00ff00".." ON");
		else		SCCN_write(SCCN_CMDSTATUS[2].."|cffff0000".." OFF"); end;
		if( SCCN_hidechanname == 1) then 	SCCN_write(SCCN_CMDSTATUS[1].."|cff00ff00".." ON");
		else		SCCN_write(SCCN_CMDSTATUS[1].."|cffff0000".." OFF"); end;
		if( SCCN_mousescroll == 1) then 	SCCN_write(SCCN_CMDSTATUS[3].."|cff00ff00".." ON");
		else		SCCN_write(SCCN_CMDSTATUS[3].."|cffff0000".." OFF"); end;	
		if( SCCN_topeditbox == 1) then 	SCCN_write(SCCN_CMDSTATUS[4].."|cff00ff00".." ON");
		else		SCCN_write(SCCN_CMDSTATUS[4].."|cffff0000".." OFF"); end;			
		if( SCCN_timestamp == 1) then 	SCCN_write(SCCN_CMDSTATUS[5].."|cff00ff00".." ON");
		else		SCCN_write(SCCN_CMDSTATUS[5].."|cffff0000".." OFF"); end;
		if( SCCN_colormap == 1) then 	SCCN_write(SCCN_CMDSTATUS[6].."|cff00ff00".." ON");
		else		SCCN_write(SCCN_CMDSTATUS[6].."|cffff0000".." OFF"); end;
		if( SCCN_hyperlinker == 1) then 	SCCN_write(SCCN_CMDSTATUS[7].."|cff00ff00".." ON");
		else		SCCN_write(SCCN_CMDSTATUS[7].."|cffff0000".." OFF"); end;
		if( SCCN_selfhighlight == 1) then 	SCCN_write(SCCN_CMDSTATUS[8].."|cff00ff00".." ON");
		else		SCCN_write(SCCN_CMDSTATUS[8].."|cffff0000".." OFF"); end;		
		if( SCCN_clickinvite == 1) then 	SCCN_write(SCCN_CMDSTATUS[9].."|cff00ff00".." ON");
		else		SCCN_write(SCCN_CMDSTATUS[9].."|cffff0000".." OFF"); end;		
		if( SCCN_editboxkeys == 1) then 	SCCN_write(SCCN_CMDSTATUS[10].."|cff00ff00".." ON");
		else		SCCN_write(SCCN_CMDSTATUS[10].."|cffff0000".." OFF"); end;
		if( SCCN_chatstring == 1) then 	SCCN_write(SCCN_CMDSTATUS[11].."|cff00ff00".." ON");
		else		SCCN_write(SCCN_CMDSTATUS[11].."|cffff0000".." OFF"); end;
		if( SCCN_selfhighlightmsg == 1) then 	SCCN_write(SCCN_CMDSTATUS[12].."|cff00ff00".." ON");
		else		SCCN_write(SCCN_CMDSTATUS[12].."|cffff0000".." OFF"); end;
		if( SCCN_HideChatButtons == 1) then 	SCCN_write(SCCN_CMDSTATUS[13].."|cff00ff00".." ON");
		else		SCCN_write(SCCN_CMDSTATUS[13].."|cffff0000".." OFF"); end;
		if( SCCN_AutoBGMap == 1) then 	SCCN_write(SCCN_CMDSTATUS[14].."|cff00ff00".." ON");
		else		SCCN_write(SCCN_CMDSTATUS[14].."|cffff0000".." OFF"); end;
		if( SCCN_shortchanname == 1) then 	SCCN_write(SCCN_CMDSTATUS[16].."|cff00ff00".." ON");
		else		SCCN_write(SCCN_CMDSTATUS[16].."|cffff0000".." OFF"); end;
		if( SCCN_AutoGossipSkip == 1) then 	SCCN_write(SCCN_CMDSTATUS[17].."|cff00ff00".." ON");
		else		SCCN_write(SCCN_CMDSTATUS[17].."|cffff0000".." OFF"); end;
		if( SCCN_AutoDismount == 1) then 	SCCN_write(SCCN_CMDSTATUS[18].."|cff00ff00".." ON");
		else		SCCN_write(SCCN_CMDSTATUS[18].."|cffff0000".." OFF"); end;
else
		SCCNConfigForm:Show();
		SCCN_write(SCCN_HELP[1]);
		SCCN_write(SCCN_HELP[4]);
		SCCN_write(SCCN_HELP[5]);
		SCCN_write(SCCN_HELP[8]);
		SCCN_write(SCCN_HELP[14]);
		SCCN_write(SCCN_HELP[99]);
	end
end

-----------------------------------------------
-- SCCN Config GUI Stuff
-----------------------------------------------
function SCCN_Config_OnLoad()
	-- Setzen der UI Eigenschaften
	-- * Version	
		getglobal("SCCNConfigForm".."ver1".."Label"):SetText(COLOR["SILVER"].."ver."..SCCN_VER);
	-- * Help Einträge
		getglobal("SCCNShortchanForm".."HLP1".."Label"):SetText(SCCN_HELP[2]);
		getglobal("SCCNShortchanForm".."HLP2".."Label"):SetText(SCCN_HELP[19]);
		getglobal("SCCNConfigForm".."HLP2".."Label"):SetText(SCCN_HELP[3]);
		getglobal("SCCNConfigForm".."HLP3".."Label"):SetText(SCCN_HELP[6]);
		getglobal("SCCNConfigForm".."HLP4".."Label"):SetText(SCCN_HELP[7]);
		getglobal("SCCNConfigForm".."HLP5".."Label"):SetText(SCCN_HELP[9]);
		getglobal("SCCNConfigForm".."HLP6".."Label"):SetText(SCCN_HELP[10]);
		
		getglobal("SCCNConfigForm".."HLP8".."Label"):SetText(SCCN_HELP[12]);
		getglobal("SCCNConfigForm".."HLP9".."Label"):SetText(SCCN_HELP[13]);
		--getglobal("SCCNConfigForm".."HLP10".."Label"):SetText(SCCN_HELP[15]);
		getglobal("SCCNConfigForm".."HLP11".."Label"):SetText(SCCN_HELP[16]);
		getglobal("SCCNConfigForm".."HLP12".."Label"):SetText(SCCN_HELP[20]);
		getglobal("SCCNConfigForm".."HLP13".."Label"):SetText(SCCN_HELP[21]);
		
		getglobal("SCCN_Highlight_Form".."HLP0".."Label"):SetText(SCCN_HELP[17]);
		getglobal("SCCN_Highlight_Form".."HLP1".."Label"):SetText(SCCN_HELP[11]);
		getglobal("SCCN_Highlight_Form".."HLP2".."Label"):SetText(SCCN_HELP[15]);
		
		
	-- * Button Config auslesen und setzen
		SCCN_Config_SetButtonState(SCCN_hidechanname,1);
		SCCN_Config_SetButtonState(SCCN_shortchanname,7);
		SCCN_Config_SetButtonState(SCCN_colornicks,2);
		SCCN_Config_SetButtonState(SCCN_mousescroll,3);
		SCCN_Config_SetButtonState(SCCN_topeditbox,4);
		SCCN_Config_SetButtonState(SCCN_colormap,5);
		SCCN_Config_SetButtonState(SCCN_hyperlinker,6);
		--SCCN_Config_SetButtonState(SCCN_selfhighlight,7);
		SCCN_Config_SetButtonState(SCCN_clickinvite,8);
		SCCN_Config_SetButtonState(SCCN_editboxkeys,9);
		SCCN_Config_SetButtonState(SCCN_HideChatButtons,11);
		SCCN_Config_SetButtonState(SCCN_AutoGossipSkip,12);
		SCCN_Config_SetButtonState(SCCN_AutoDismount,13);
		
		SCCN_Config_SetButtonState(SCCN_Highlight,100);
		SCCN_Config_SetButtonState(SCCN_selfhighlight,101);
		SCCN_Config_SetButtonState(SCCN_selfhighlightmsg,102);
		
end 

function SCCN_Config_SetButtonState(val,buttonnr)
	if(val == 0 or val == false or val == nil) then
		getglobal( "SCCN_CONF_CHK"..buttonnr ):SetChecked(0);
	else
		getglobal( "SCCN_CONF_CHK"..buttonnr ):SetChecked(1);
	end
end

--------------------------------------------------------
-- Misc functions
--------------------------------------------------------

function SCCN_OnGOSSIP()
	if SCCN_AutoGossipSkip == 1 then	
		local GossipOptions = {};
		local append = ".";
		--SelectGossipOption(1);
		_,GossipOptions[1],_,GossipOptions[2],_,GossipOptions[3],_,GossipOptions[4],_,GossipOptions[5]=  GetGossipOptions()
		for i=1, getn(GossipOptions) do
			if (GossipOptions[i] == "taxi") then SCCN_Dismount(); append=", Dismounting." end;
			if (GossipOptions[i] == "battlemaster" or GossipOptions[i] == "taxi" or GossipOptions[i] == "banker" or GossipOptions[i] == "trainer") then
				--SCCN_write("Skip Gossip: '"..GossipOptions[i].."' detected, Autoselecting Option "..i..append);
				SelectGossipOption(i);
			end
		end
	end
end

function SCCN_Dismount()
	if SCCN_AutoDismount == 1 then
		for i=0,15 do
			local buffIndex, untilCancelled = GetPlayerBuff(i, "HELPFUL");
			if GetPlayerBuffTexture(buffIndex) then
				if string.find(GetPlayerBuffTexture(buffIndex),"Mount") then
					CancelPlayerBuff(buffIndex);
				end
			end
		end
	end
end