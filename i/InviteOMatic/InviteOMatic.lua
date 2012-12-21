--[[
	InviteOMatic is a BG Group inviter
	
	@author Gof
	@version 29-03-06
]]--

----------------------------------------------------------------------
-- Saved variable
----------------------------------------------------------------------

InviteOMaticOptions = {};

----------------------------------------------------------------------
-- Strings used in this mod
----------------------------------------------------------------------

local IOM_VERSION = "v1.16";
local IOM_IOM = "[InviteOMatic]";
local IOM_LOADED = IOM_IOM.." "..IOM_VERSION.." Loaded!";

local IOM_FIRST_INVITE_SPAM_DEFAULT = IOM_IOM.." Please leave your groups, i have the raid group, (Or at least Promote me so i can help invite =)";

local IOM_ERROR_AIG_DEFAULT = IOM_IOM.." Since you appear to already be grouped you could not be auto-invited to the raid. If you want to join the raid, please leave your group and send me a whisper with the word: invite";

local IOM_INVITE_REG_EXP = "[iI][nN][vV][iI][tT][eE]"; -- Regular expression for magic word.

----------------------------------------------------------------------
-- Local variables used to capture state
----------------------------------------------------------------------
local IOM_WHOIS = false; -- Are we doing a /who lookup?
local IOM_NAME_BY_WHO = "----"; -- The name we are currently looking up over /Who
local IOM_NAME_BY_WHO_INVITER = "----"; -- The name of the person starting the lookup over /who
local IOM_BG_ACTIVE = false; -- Are we active in a BG, or just handling group outside BG
local IOM_BG_ACTIVE_INDEX = -1; -- The index of the active BG
local IOM_INVITE_WAIT = 1; -- Time to back off before sending invites again, (in seconds)
-- local IOM_FIRST_SCHED_TIME = 2; -- Time to wait from joining BG, to sending the first invite
local IOM_LAST_INVITE = 0; -- Time since last invite cycle, to prevent spamming of invites
local IOM_INVITE_FIRST = true; -- Is this the first invite cycle in this BG?
local IOM_READY = false;

local IOM_AIG = {};
local IOM_AIG_ERROR = {};
local IOM_DECLINE = {};
local IOM_IGNORE = {};

local IOM_GROUPBUG = {};

local IOM_PURGE_TIMER = 0;
local IOM_INVITE_TIMER = 0;
local IOM_UPDATE_PURGE_TIMER = false;
local IOM_UPDATE_INVITE_TIMER = false;

----------------------------------------------------------------------
-- This function is called when the mod is first loaded.
----------------------------------------------------------------------

function InviteOMatic_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED"); -- Saved variables loaded
	this:RegisterEvent("UPDATE_BATTLEFIELD_STATUS"); -- Register event that fires when BG status changes
	this:RegisterEvent("CHAT_MSG_WHISPER"); -- Register event that fires when player receives a whisper
end

----------------------------------------------------------------------
-- Called when an event occurs (That we have registered to hear)
--
-- @param event The event that occured
----------------------------------------------------------------------
function InviteOMatic_OnEvent()

	if( event == "VARIABLES_LOADED" ) then
		InviteOMatic_VariablesLoaded();		
		
	elseif( event == "CHAT_MSG_WHISPER" ) then
		InviteOMatic_WhisperEvent(arg1, arg2);
	
	elseif( event == "UPDATE_BATTLEFIELD_STATUS" ) then
		InviteOMatic_BGEvent();
	
	elseif( event == "WHO_LIST_UPDATE" ) then
		InviteOMatic_WhoEvent();
	
	elseif( event == "CHAT_MSG_SYSTEM" ) then
		InviteOMatic_ChannelSystem(arg1);

	end
end

function InviteOMatic_VariablesLoaded()
	if( InviteOMaticOptions == nil ) then
		InviteOMaticOptions = {};
	end

	if( type(InviteOMaticOptions) ~= "table" ) then
		InviteOMaticOptions = {};
	end

	if( InviteOMaticOptions["autoInvite"] == nil ) then
		InviteOMaticOptions["autoInvite"] = true;
		InviteOMatic_KhaosSetKey("InviteOMatic", "InviteAutoInvite", "checked", InviteOMaticOptions["autoInvite"]);
	end

	if( InviteOMaticOptions["whisperInvite"] == nil ) then
		InviteOMaticOptions["whisperInvite"] = true;
		InviteOMatic_KhaosSetKey("InviteOMatic", "InviteWhisperInvite", "checked", InviteOMaticOptions["whisperInvite"]);
	end

	if( InviteOMaticOptions["autoPurge"] == nil ) then
		InviteOMaticOptions["autoPurge"] = true;
		InviteOMatic_KhaosSetKey("InviteOMatic", "InviteAutoPurge", "checked", InviteOMaticOptions["autoPurge"]);
	end

	if( InviteOMaticOptions["debug"] == nil ) then
		InviteOMaticOptions["debug"] = false;
		InviteOMatic_KhaosSetKey("InviteOMatic", "InviteDebug", "checked", InviteOMaticOptions["debug"]);
	end

	if( InviteOMaticOptions["ignoreList"] == nil ) then
		InviteOMaticOptions["ignoreList"] = {};
	end

	if( InviteOMaticOptions["aigttl"] == nil ) then
		InviteOMaticOptions["aigttl"] = 10;
		InviteOMatic_KhaosSetKey("InviteOMatic", "InviteAIGRetry", "slider", InviteOMaticOptions["aigttl"]);
	end

	if( InviteOMaticOptions["declinettl"] == nil ) then
		InviteOMaticOptions["declinettl"] = 1;
		InviteOMatic_KhaosSetKey("InviteOMatic", "InviteDeclineRetry", "slider", InviteOMaticOptions["declinettl"]);
	end

	if( InviteOMaticOptions["ignorettl"] == nil ) then
		InviteOMaticOptions["ignorettl"] = 1;
		InviteOMatic_KhaosSetKey("InviteOMatic", "InviteIgnoreRetry", "slider", InviteOMaticOptions["ignorettl"]);
	end

	if( InviteOMaticOptions["sendInviteSpam"] == nil ) then
		InviteOMaticOptions["sendInviteSpam"] = true;
		InviteOMatic_KhaosSetKey("InviteOMatic", "InviteSendSpam", "checked", InviteOMaticOptions["sendInviteSpam"]);
	end

	if( InviteOMaticOptions["sendAIGSpam"] == nil ) then
		InviteOMaticOptions["sendAIGSpam"] = true;
		InviteOMatic_KhaosSetKey("InviteOMatic", "InviteSendAIGSpam", "checked", InviteOMaticOptions["sendAIGSpam"]);
	end

	if( InviteOMaticOptions["inviteDelay"] == nil ) then
		InviteOMaticOptions["inviteDelay"] = 10;
		InviteOMatic_KhaosSetKey("InviteOMatic", "InviteDelay", "slider", InviteOMaticOptions["inviteDelay"]);
	end

	if( InviteOMaticOptions["purgeDelay"] == nil ) then
		InviteOMaticOptions["purgeDelay"] = 10;
		InviteOMatic_KhaosSetKey("InviteOMatic", "PurgeDelay", "slider", InviteOMaticOptions["purgeDelay"]);
	end

	if( InviteOMaticOptions["inviteMsg"] == nil ) then
		InviteOMaticOptions["inviteMsg"] = IOM_FIRST_INVITE_SPAM_DEFAULT;
		InviteOMatic_KhaosSetKey("InviteOMatic", "InviteSpamMsg", "value", InviteOMaticOptions["inviteMsg"]);
	end

	if( InviteOMaticOptions["aigMsg"] == nil ) then
		InviteOMaticOptions["aigMsg"] = IOM_ERROR_AIG_DEFAULT;
		InviteOMatic_KhaosSetKey("InviteOMatic", "InviteAIGSpamMsg", "value", InviteOMaticOptions["aigMsg"]);
	end

	if( InviteOMaticOptions["magicWord"] == nil ) then
		InviteOMaticOptions["magicWord"] = IOM_INVITE_REG_EXP;
		InviteOMatic_KhaosSetKey("InviteOMatic", "InviteMagicWord", "value", InviteOMaticOptions["magicWord"]);
	end

	InviteOMatic.log(IOM_LOADED);
	SlashCmdList["IOM"] = InviteOMatic_SlashHandler;
	SLASH_IOM1 = "/iom";

	IOM_READY = true;

	InviteOMatic_RegisterKhaos();

end

----------------------------------------------------------------------
-- Slash command handler
----------------------------------------------------------------------
function InviteOMatic_SlashHandler(msg)
	if( not IOM_READY ) then
		return;
	end
	
	if( InviteOMatic_IsDisabled() ) then
		return;
	end
	
	local oldmsg = msg;
	msg = string.lower(msg);
	
	InviteOMatic.debug("Slashcommand: ("..msg..")");
	
	_, _, option, value = string.find(msg, "(%w*)%s*(%w*)");
	
	InviteOMatic.debug("Option: ("..option.."), Value: ("..value..")");
	
	if( option == "autoinvite" ) then
		if( value == "on" ) then
			InviteOMaticOptions["autoInvite"] = true;
		elseif( value == "off" ) then
			InviteOMaticOptions["autoInvite"] = false;
		else
			InviteOMaticOptions["autoInvite"] = not InviteOMaticOptions["autoInvite"];
		end
		InviteOMatic.log("Auto invite set to: "..tostring(InviteOMaticOptions["autoInvite"]));
		InviteOMatic_KhaosSetKey("InviteOMatic", "InviteAutoInvite", "checked", InviteOMaticOptions["autoInvite"]);
		if( IOM_BG_ACTIVE ) then
			IOM_UPDATE_INVITE_TIMER = InviteOMaticOptions["autoInvite"];
		end
		
	elseif( option == "whisperinvite" ) then
		if( value == "on" ) then
			InviteOMaticOptions["whisperInvite"] = true;
		elseif( value == "off" ) then
			InviteOMaticOptions["whisperInvite"] = false;
		else
			InviteOMaticOptions["whisperInvite"] = not InviteOMaticOptions["whisperInvite"];
		end
		InviteOMatic.log("Whisper invite set to: "..tostring(InviteOMaticOptions["whisperInvite"]));
		InviteOMatic_KhaosSetKey("InviteOMatic", "InviteWhisperInvite", "checked", InviteOMaticOptions["whisperInvite"]);

	elseif( option == "autopurge" ) then
		if( value == "on" ) then
			InviteOMaticOptions["autoPurge"] = true;
		elseif( value == "off" ) then
			InviteOMaticOptions["autoPurge"] = false;
		else
			InviteOMaticOptions["autoPurge"] = not InviteOMaticOptions["autoPurge"];
		end
		InviteOMatic.log("Auto purge set to: "..tostring(InviteOMaticOptions["autoPurge"]));
		InviteOMatic_KhaosSetKey("InviteOMatic", "InviteAutoPurge", "checked", InviteOMaticOptions["autoPurge"]);
		if( IOM_BG_ACTIVE ) then
			IOM_UPDATE_PURGE_TIMER = InviteOMaticOptions["autoPurge"];
		end
		
	elseif( option == "spam" ) then
		if( value == "on" ) then
			InviteOMaticOptions["sendInviteSpam"] = true;
		elseif( value == "off") then
			InviteOMaticOptions["sendInviteSpam"] = false;
		else
			InviteOMaticOptions["sendInviteSpam"] = not InviteOMaticOptions["sendInviteSpam"];
		end
		InviteOMatic.log("Invite spam set to: "..tostring(InviteOMaticOptions["sendInviteSpam"]));
		InviteOMatic_KhaosSetKey("InviteOMatic", "InviteSendSpam", "checked", InviteOMaticOptions["sendInviteSpam"]);
	
	elseif( option == "debug" ) then
		if( value == "on" ) then
			InviteOMaticOptions["debug"] = true;
		elseif( value == "off") then
			InviteOMaticOptions["debug"] = false;
		else
			InviteOMaticOptions["debug"] = not InviteOMaticOptions["debug"];
		end
		InviteOMatic.log("Debug messages set to: "..tostring(InviteOMaticOptions["debug"]));
		InviteOMatic_KhaosSetKey("InviteOMatic", "InviteDebug", "checked", InviteOMaticOptions["debug"]);

	elseif( option == "ignore" ) then
		if( value ~= nil ) then
			local lowerName = string.lower(value);
			InviteOMaticOptions["ignoreList"][lowerName] = lowerName;
		else
			InviteOMatic.log("You need to specify a playername you wish to add to the ignore-list, /iom ignore playername");
		end
		InviteOMatic.log(value.." added to ignore list");

	elseif( option == "removeignore" ) then
		if( value ~= nil ) then
			local lowerName = string.lower(value);
			InviteOMaticOptions["ignoreList"][lowerName] = nil;
		else
			InviteOMatic.log("You need to specify a playername you wish to remove from the ignore-list, /iom ignore playername");
		end
		InviteOMatic.log(value.." removed from ignore list");

	elseif( option == "spammsg" ) then
		if( value == "default" ) then
			InviteOMaticOptions["inviteMsg"] = IOM_FIRST_INVITE_SPAM_DEFAULT;
			InviteOMatic.log("First spam msg set to default: "..InviteOMaticOptions["inviteMsg"]);
			InviteOMatic_KhaosSetKey("InviteOMatic", "InviteSpamMsg", "value", InviteOMaticOptions["inviteMsg"]);
			return;
		end
		
		sS, sE = string.find(msg, "\".*\"");
		
		if( not sS ) then
			InviteOMatic.log("You need to specify a new message ex. /iom spammsg \"newmsg\"");
			return;
		end
		
		newmsg = string.sub(oldmsg, sS+1, sE-1);
		InviteOMatic.debug("New message is: ("..newmsg..")");
		InviteOMaticOptions["inviteMsg"] = newmsg;
		InviteOMatic.log("First spam msg set to: "..InviteOMaticOptions["inviteMsg"]);
		InviteOMatic_KhaosSetKey("InviteOMatic", "InviteSpamMsg", "value", InviteOMaticOptions["inviteMsg"]);

	elseif( option == "aigmsg" ) then
		if( value == "default" ) then
			InviteOMaticOptions["aigMsg"] = IOM_ERROR_AIG_DEFAULT;
			InviteOMatic.log("AIG spam msg set to default: "..InviteOMaticOptions["aigMsg"]);
			InviteOMatic_KhaosSetKey("InviteOMatic", "InviteAIGSpamMsg", "value", InviteOMaticOptions["aigMsg"]);
			return;
		end

		sS, sE = string.find(msg, "\".*\"");

		if( not sS ) then
			InviteOMatic.log("You need to specify a new message ex. /iom aigmsg \"newmsg\"");
			return;
		end

		newmsg = string.sub(oldmsg, sS+1, sE-1);
		InviteOMatic.debug("New message is: ("..newmsg..")");
		InviteOMaticOptions["aigMsg"] = newmsg;
		InviteOMatic.log("AIG spam msg set to: "..InviteOMaticOptions["aigMsg"]);
		InviteOMatic_KhaosSetKey("InviteOMatic", "InviteAIGSpamMsg", "value", InviteOMaticOptions["aigMsg"]);

	elseif( option == "magicword" ) then
		if( value == "default" ) then
			InviteOMaticOptions["magicWord"] = IOM_INVITE_REG_EXP;
			InviteOMatic.log("Magic word set to default: "..InviteOMaticOptions["magicWord"]);
			InviteOMatic_KhaosSetKey("InviteOMatic", "InviteMagicWord", "value", InviteOMaticOptions["magicWord"]);
			return;
		end

		sS, sE = string.find(msg, "\".*\"");

		if( not sS ) then
			InviteOMatic.log("You need to specify a new magic word ex. /iom aigmsg \"[iI][nN][vV]\"");
			return;
		end

		newmsg = string.sub(oldmsg, sS+1, sE-1);
		InviteOMatic.debug("New magic word is: ("..newmsg..")");
		InviteOMaticOptions["magicWord"] = newmsg;
		InviteOMatic.log("Magic word set to: "..InviteOMaticOptions["magicWord"]);
		InviteOMatic_KhaosSetKey("InviteOMatic", "InviteMagicWord", "value", InviteOMaticOptions["magicWord"]);

	elseif( option == "resetaiglist" ) then
		InviteOMatic_ResetAIG();
		InviteOMatic.log("Already in group list reset");

	elseif( option == "promote" ) then
		InviteOMatic_PromoteAll();
	
	elseif( option == "demote" ) then
		InviteOMatic_DemoteAll();

	elseif( option == "aigttl" ) then
		if( value ) then
			local num = tonumber(value);
			if( num ) then
				if( num >= 0 and num <= 20 ) then
					InviteOMaticOptions["aigttl"] = num;
					InviteOMatic.log("Already in group retries set to: "..InviteOMaticOptions["aigttl"]);
					InviteOMatic_KhaosSetKey("InviteOMatic", "InviteAIGRetry", "slider", InviteOMaticOptions["aigttl"]);
				else
					InviteOMatic.log("Number must be between 0 and 20");
				end
			end
		end
	elseif( option == "ignorettl" ) then
		if( value ) then
			local num = tonumber(value);
			if( num ) then
				if( num >= 0 and num <= 10 ) then
					InviteOMaticOptions["ignorettl"] = num;
					InviteOMatic.log("Ignore retries set to: "..InviteOMaticOptions["ignorettl"]);
					InviteOMatic_KhaosSetKey("InviteOMatic", "InviteIgnoreRetry", "slider", InviteOMaticOptions["ignorettl"]);
				else
					InviteOMatic.log("Number must be between 0 and 10");
				end
			end
		end

	elseif( option == "declinettl" ) then
		if( value ) then
			local num = tonumber(value);
			if( num ) then
				if( num >= 0 and num <= 10 ) then
					InviteOMaticOptions["declinettl"] = num;
					InviteOMatic.log("Decline retries set to: "..InviteOMaticOptions["declinettl"]);
					InviteOMatic_KhaosSetKey("InviteOMatic", "InviteDeclineRetry", "slider", InviteOMaticOptions["declinettl"]);
				else
					InviteOMatic.log("Number must be between 0 and 10");
				end
			end
		end

	else
		InviteOMatic.log("Unknown option: "..option);
		InviteOMatic.log("Usage: /iom option value");
		InviteOMatic.log("Options:");
		InviteOMatic.log(" autoinvite on|off -- Turns autoinvite on/off");
		InviteOMatic.log(" autopurge on|off -- Turns autopurge on/off");
		InviteOMatic.log(" whisperinvite on|off -- Turns whisperinvite on/off");
		InviteOMatic.log(" debug on|off -- Turns debug messages on/off");
		InviteOMatic.log(" spam on|off -- Turns the invite spam on/off");
		InviteOMatic.log(" spammsg default|\"newmsg\" -- Sets invite msg to newmsg");
		InviteOMatic.log(" aigmsg default|\"newmsg\" -- Sets AIG msg to newmsg");
		InviteOMatic.log(" magicword default|\"word\" -- Sets the magic invite word (REGEXP)");
		InviteOMatic.log(" resetaiglist -- Resets the already in group list");
		InviteOMatic.log(" ignore playername -- Puts the player on the ignorelist (Will not be invited)");
		InviteOMatic.log(" removeignore playername -- Puts the player on the ignorelist (Will not be invited)");
		InviteOMatic.log(" promote -- Promotes all members of the raidgroup");
		InviteOMatic.log(" demote -- Demotes all members of the raidgroup");
		InviteOMatic.log(" aigttl num -- Set number of already in group retries to num");
		InviteOMatic.log(" ignorettl num -- Set number of ignore retries to num");
		InviteOMatic.log(" declinettl num -- Set number of decline retries to num");
	end
	
end

function InviteOMatic_KhaosSetKey(set, key, type, value)
	if(Khaos) then
		if(Khaos.getSetKey(set,key)) then
			Khaos.setSetKeyParameter(set, key, type, value);
		end
	end
end

----------------------------------------------------------------------
-- Should this person be invited? (Do checks)
----------------------------------------------------------------------
function InviteOMatic_ShouldInvite(name)
	if( not IOM_READY ) then
		return;
	end
	if( InviteOMatic_IsDisabled() ) then
		return;
	end

	if( name ~= nil ) then
	  local lowerName = string.lower(name);
	
		if( InviteOMaticOptions["ignoreList"][lowerName] ~= nil ) then
			-- This player is ignored, so dont invite
			InviteOMatic.debug("Player "..charname.." is on ignore list, so will not get invited");
			return false;
		end

		-- Do checks on this specefic name (Will only reject, not accept)
		
		if( IOM_AIG[name] and IOM_AIG[name] >= InviteOMaticOptions["aigttl"] ) then
			
			if( not IOM_AIG_ERROR[name] ) then
				IOM_AIG_ERROR[name] = true;
				if( InviteOMaticOptions["sendAIGSpam"] ) then
					SendChatMessage(InviteOMaticOptions["aigMsg"], "WHISPER",this.language,name);
				end
			end
			
			return false;

		end
		if( IOM_DECLINE[name] and IOM_DECLINE[name] >= InviteOMaticOptions["declinettl"] ) then
			return false;
		end
		
		if( IOM_IGNORE[name] and IOM_IGNORE[name] >= InviteOMaticOptions["ignorettl"] ) then
			return false;
		end
	end	
	
	--Do general checks( Accept and reject )
	
	-- If raid officer or leader then ok
	if( IsRaidLeader() or IsRaidOfficer() or IsPartyLeader() ) then
		return true;
	elseif( IOM_BG_ACTIVE and ((GetNumPartyMembers() > 0) or (GetNumRaidMembers() > 0)) ) then
		--We are in a BG, but not able to invite
		return false;
	end

	return true;
end

----------------------------------------------------------------------
-- Invite the player with the given name, if its ok
----------------------------------------------------------------------
function InviteOMatic_InvitePlayer(name)
	if( not IOM_READY ) then 
		return;
	end
	if( InviteOMatic_IsDisabled() ) then
		return;
	end

	if( name == nil ) then
		return;
	end

  local lowerName = string.lower(name);

	if( InviteOMaticOptions["ignoreList"][lowerName] ~= nil ) then
		-- This player is ignored, so dont invite
		InviteOMatic.debug("Player "..lowerName.." is on ignore list, so will not get invited");
		return;
	end
	
	InviteOMatic.debug("Checking invite: ("..name..")");
	
	local ok = InviteOMatic_ShouldInvite(name);
	
	if( ok ) then
		InviteOMatic.debug("("..name..") checked ok, inviting");
	
		if( IOM_GROUPBUG[name] ~= nil ) then
			InviteOMatic.debug("Group bug2 maybee found. Uninviting first...");
			
			UninviteByName(name);
		end
	
		InviteByName(name);
		
		IOM_GROUPBUG[name] = true;
		
	else	
		InviteOMatic.debug("("..name..") failed check!");
	end
end

----------------------------------------------------------------------
-- Convert to Raid
----------------------------------------------------------------------
function InviteOMatic_MakeRaid()
	if( not IOM_READY ) then 
		return;
	end
	if( InviteOMatic_IsDisabled() ) then
		return;
	end

	local raidMembers = GetNumRaidMembers();
	local isLeader = IsPartyLeader();
	
	if( (raidMembers == 0) and isLeader ) then
		
		InviteOMatic.debug("Converting to raid...");
		
		ConvertToRaid();
	end
end

----------------------------------------------------------------------
-- Function to handle enter world event
----------------------------------------------------------------------
function InviteOMatic_BGEvent()
	InviteOMatic.debug("Battlefield status changed...");
	
	NUMBER_OF_BATTLEFIELDS = 3;
	
	if( not IOM_BG_ACTIVE ) then
		for i=1,NUMBER_OF_BATTLEFIELDS do
		status, mapName, instanceID = GetBattlefieldStatus(i);
			
			InviteOMatic.debug("Status: "..status..", MapName: "..mapName..", InstanceID: "..instanceID);
			
			if( status == "active" ) then
				
				InviteOMatic_EnteredBG(i);
				
			end
		end
	else
		status, mapName, instanceID = GetBattlefieldStatus(IOM_BG_ACTIVE_INDEX);
		if( status ~= "active" ) then
			-- You have left BG
				InviteOMatic_LeftBG(IOM_BG_ACTIVE_INDEX);
		end
	end
end

----------------------------------------------------------------------
-- Function to handle whisper events
----------------------------------------------------------------------
function InviteOMatic_WhisperEvent(text, name)
	if( not IOM_READY ) then 
		return;
	end
	if( InviteOMatic_IsDisabled() ) then
		return;
	end

	InviteOMatic.debug("Tell recieved...");
	
	--If whisper invites isnt enabled, just return
	if( not InviteOMaticOptions["whisperInvite"] ) then
		return;
	end
	
	--Check if tell contains the magic word invite
	
	sStart, sEnd = string.find(text, InviteOMaticOptions["magicWord"], 1);
	if( sStart ~= nil ) then
		
		--Check if the word just after invite is a player
		sStart2, sEnd2 = string.find(text, "%s[^%s%?%.!]+", sEnd);
		
		if( sStart2 ~= nil ) then
			local foundName = string.lower( string.sub(text, sStart2+1, sEnd2) );
		
			if( foundName == "me" or foundName == "please" or foundName == "plz" or foundName == "plez" or foundName == "pleaz") then
				IOM_AIG[name] = nil;
				IOM_AIG_ERROR[name] = nil;
				IOM_IGNORE[name] = nil;
				IOM_DECLINE[name] = nil;
				InviteOMatic.invite(name);
			else
				InviteOMatic.debug(name.." wants you to invite ("..foundName..")");
				
				IOM_WHOIS = true;
				
				this:RegisterEvent("WHO_LIST_UPDATE");
				FriendsFrame:UnregisterEvent("WHO_LIST_UPDATE");
				SetWhoToUI(1);
				
				-- Do lookup via Who command.
				IOM_NAME_BY_WHO = string.lower(foundName);
				IOM_NAME_BY_WHO_INVITER = name;
				
				SendWho("n-\""..foundName.."\"");
			end
		else
			IOM_AIG[name] = nil;
			IOM_AIG_ERROR[name] = nil;
			IOM_IGNORE[name] = nil;
			IOM_DECLINE[name] = nil;
			InviteOMatic.invite(name);
		end
	end
end

----------------------------------------------------------------------
-- Function to handle who events
----------------------------------------------------------------------
function InviteOMatic_WhoEvent()

	if( IOM_WHOIS ) then 
		InviteOMatic.debug("WHO_LIST_UPDATED - ("..IOM_NAME_BY_WHO..")");

		local invited = false;

		-- We saw our who, so reset everything back

		SetWhoToUI(0);
		FriendsFrame:RegisterEvent("WHO_LIST_UPDATE"); 			
		this:UnregisterEvent("WHO_LIST_UPDATE");
		IOM_WHOIS = false;
		
		-- Now process the who list
		local length = GetNumWhoResults();
		
		for i=1,length do
			charname, guildname, level, race, class, zone, unknown = GetWhoInfo(i);
			
			InviteOMatic.debug("Found: "..charname);
			
			charname = string.lower(charname);
			
			if( charname == IOM_NAME_BY_WHO ) then
				if( InviteOMaticOptions["ignoreList"][charname] ~= nil ) then
					-- This player is ignored, so dont invite
					InviteOMatic.log("Player "..charname.." is on ignore list, so will not get invited");
					return;
				end

				IOM_AIG[IOM_NAME_BY_WHO] = nil;
				IOM_AIG_ERROR[IOM_NAME_BY_WHO] = nil;
				IOM_IGNORE[IOM_NAME_BY_WHO] = nil;
				IOM_DECLINE[IOM_NAME_BY_WHO] = nil;
				InviteOMatic.invite(IOM_NAME_BY_WHO);
				invited = true;
			end
		end
		
		if( not invited ) then
			if( InviteOMaticOptions["ignoreList"][IOM_NAME_BY_WHO_INVITER] ~= nil ) then
				-- This player is ignored, so dont invite
				InviteOMatic.log("Player "..charname.." is on ignore list, so will not get invited");
				return;
			end

			IOM_AIG[IOM_NAME_BY_WHO_INVITER] = nil;
			IOM_AIG_ERROR[IOM_NAME_BY_WHO_INVITER] = nil;
			IOM_IGNORE[IOM_NAME_BY_WHO_INVITER] = nil;
			IOM_DECLINE[IOM_NAME_BY_WHO_INVITER] = nil;

			InviteByName(IOM_NAME_BY_WHO_INVITER);
		end
		
		-- Done processing, reset IOM_NAME_BY_WHO, IOM_NAME_BY_WHO_INVITER
		IOM_NAME_BY_WHO = "----";
		IOM_NAME_BY_WHO_INVITER = "----";
	end
end

----------------------------------------------------------------------
-- Called when InviteOMatic detects that you have entered a BG
--
-- Sets up the events we want to listen for while in BG, and starts invite script
----------------------------------------------------------------------
function InviteOMatic_EnteredBG(index)
	IOM_BG_ACTIVE_INDEX = index;
	IOM_BG_ACTIVE = true;

	status, mapName, instanceID = GetBattlefieldStatus(index);
	
	local runtime = GetBattlefieldInstanceRunTime();
	
	InviteOMatic.debug("You entered "..mapName.." Runtime: "..runtime);
	
	if( InviteOMaticOptions["autoInvite"] ) then
		IOM_UPDATE_INVITE_TIMER = true;
	end
	
	if( InviteOMaticOptions["autoPurge"] ) then
		IOM_UPDATE_PURGE_TIMER = true;
	end
	
	this:RegisterEvent("CHAT_MSG_SYSTEM");
end

----------------------------------------------------------------------
-- This function purges players that are offline or has left the BG
----------------------------------------------------------------------
function InviteOMatic_DoPurge()
	if( not IOM_READY ) then 
		return;
	end
	if( InviteOMatic_IsDisabled() ) then
		return;
	end

	if( not InviteOMaticOptions["autoPurge"] ) then
		return;
	end

	for i=1,GetNumRaidMembers() do
		--do som check for each member determing if he is online, if he isnt, purge him
	end
end

----------------------------------------------------------------------
-- Promotes all memebers of a raid group
----------------------------------------------------------------------
function InviteOMatic_PromoteAll()
	if( not IOM_READY ) then 
		return;
	end
	if( InviteOMatic_IsDisabled() ) then
		return;
	end

	for i=1,GetNumRaidMembers() do
		local name = GetRaidRosterInfo(i);
		
		if( IsRaidLeader() ) then
			PromoteToAssistant(name);
		end
		
	end
end

----------------------------------------------------------------------
-- Demotes all memebers of a raid group
----------------------------------------------------------------------
function InviteOMatic_DemoteAll()
	if( not IOM_READY ) then 
		return;
	end
	if( InviteOMatic_IsDisabled() ) then
		return;
	end

	for i=1,GetNumRaidMembers() do
		local name = GetRaidRosterInfo(i);
		
		if( IsRaidLeader() ) then
			DemoteAssistant(name);
		end
		
	end
end

----------------------------------------------------------------------
-- Disbands the raid group uninviting every member
----------------------------------------------------------------------
function InviteOMatic_DisbandRaidGroup()
	if( not IOM_READY ) then 
		return;
	end
	if( InviteOMatic_IsDisabled() ) then
		return;
	end

	for i=1,GetNumRaidMembers() do
		--Remove player from raid
		local name = GetRaidRosterInfo(i);
		
		if( IsRaidLeader() or IsRaidOfficer() or IsPartyLeader() ) then
			UninviteByName(name);
		end
		
	end

	for i=1,GetNumPartyMembers() do
		--Remove player from group
	end
end

----------------------------------------------------------------------
-- This function tries to invite everyone that is not already in our group
----------------------------------------------------------------------
function InviteOMatic_SendInvites()
	if( not IOM_READY ) then 
		return;
	end
	if( InviteOMatic_IsDisabled() ) then
		return;
	end

	if( not InviteOMaticOptions["autoInvite"] ) then
		return;
	end

	local bfCount = GetNumBattlefieldPositions();
	
	if( bfCount == 0 ) then
		return;
	end

	InviteOMatic.debug("Sending invites - InviteOMatic_SendInvites()");
	
	if( not IOM_BG_ACTIVE ) then
		InviteOMatic.debug("Not in a BG");
		return;
	end
	
	local now = GetTime();
	
	local delta = now - IOM_LAST_INVITE;
	
	if( delta < IOM_INVITE_WAIT ) then
		InviteOMatic.debug("Wait a little longer...("..delta..")");
		return;
	end

	if( not InviteOMatic_ShouldInvite(nil) ) then
		-- We got a negative from ShouldInvite, so we stop here
		return;
	end

	if( IOM_INVITE_FIRST ) then
		IOM_INVITE_FIRST = false;

		if( InviteOMaticOptions["sendInviteSpam"] ) then
			SendChatMessage(InviteOMaticOptions["inviteMsg"], "SAY");
		end
	end
	
	-- Convert to raid if any members is in party
	InviteOMatic_MakeRaid();
	
	local count = GetNumBattlefieldPositions(); -- Number of players not in our raid
	
	if( (count > 4) and (GetNumRaidMembers() == 0) ) then
		-- Not a raid yet so only invite 4 people
		count = 5 - GetNumPartyMembers();
	end

	for i=1,count do
		posX, posY, name = GetBattlefieldPosition(i);
		
		InviteOMatic.invite(name);
	end

	IOM_LAST_INVITE = GetTime();
	
end

----------------------------------------------------------------------
-- Function to handle system messages
----------------------------------------------------------------------
function InviteOMatic_ChannelSystem(arg1)
	if( not IOM_READY ) then 
		return;
	end
	if( InviteOMatic_IsDisabled() ) then
		return;
	end

	local name = "";

	if( string.find(arg1, "has joined the battle") ) then
		sS, sE = string.find(arg1, "%[");
		sS2, sE2 = string.find(arg1, "%]");
		name = string.sub(arg1,sS+1,sS2-1);
		InviteOMatic_PlayerJoinedBattle(name);

	elseif( string.find(arg1, "has left the battle") ) then
		sS, sE = string.find(arg1, "[^%s%!%?]+");
		name = string.sub(arg1,sS,sE);
		InviteOMatic_PlayerLeftBattle(name);

	elseif( string.find(arg1, "declines your group invitation") ) then
		sS, sE = string.find(arg1, "[^%s%!%?]+");
		name = string.sub(arg1,sS,sE);
		InviteOMatic_PlayerDeclined(name);

	elseif( string.find(arg1, "is ignoring you") ) then
		sS, sE = string.find(arg1, "[^%s%!%?]+");
		name = string.sub(arg1,sS,sE);
		InviteOMatic_PlayerIgnores(name);

	elseif( string.find(arg1, "is already in a group") ) then
		sS, sE = string.find(arg1, "[^%s%!%?]+");
		name = string.sub(arg1,sS,sE);
		InviteOMatic_PlayerAlreadyGrouped(name);

	elseif( string.find(arg1, "joins the party") ) then
		sS, sE = string.find(arg1, "[^%s%!%?]+");
		name = string.sub(arg1,sS,sE);
		InviteOMatic_PlayerJoinedGroup(name);

	elseif( string.find(arg1, "has joined the raid group") ) then
		sS, sE = string.find(arg1, "[^%s%!%?]+");
		name = string.sub(arg1,sS,sE);
		InviteOMatic_PlayerJoinedGroup(name);
	
	elseif( string.find(arg1, "You have invited") ) then
		sS, sE = string.find(arg1, "You have invited");
		sS2, sE2 = string.find(arg1, "[^%s%!%?]+", sE+1);
		name = string.sub(arg1,sS2,sE2);
		InviteOMatic_PlayerInvitedEvent(name);

	else
		InviteOMatic.debug("Unhandled sysmsg: "..arg1);
	
	end
	
end

----------------------------------------------------------------------
-- Remove this player from the groupbug table
----------------------------------------------------------------------
function InviteOMatic_PlayerInvitedEvent(name)
	InviteOMatic.debug("You invited: ("..name..")");
	
	IOM_GROUPBUG[name] = nil;
end

----------------------------------------------------------------------
-- Resets AIG list
----------------------------------------------------------------------
function InviteOMatic_ResetAIG()
	if( not IOM_READY ) then 
		return;
	end
	if( InviteOMatic_IsDisabled() ) then
		return;
	end

	InviteOMatic.debug("Resetting AIG list...");
	IOM_AIG = {};
	IOM_AIG_ERROR = {};
end

----------------------------------------------------------------------
-- Resets DECLINE list
----------------------------------------------------------------------
function InviteOMatic_ResetDecline()
	if( not IOM_READY ) then 
		return;
	end
	if( InviteOMatic_IsDisabled() ) then
		return;
	end

	InviteOMatic.debug("Resetting Decline list...");
	IOM_DECLINE = {};
end

----------------------------------------------------------------------
-- Resets IGNORE list
----------------------------------------------------------------------
function InviteOMatic_ResetIgnore()
	if( not IOM_READY ) then 
		return;
	end
	if( InviteOMatic_IsDisabled() ) then
		return;
	end

	InviteOMatic.debug("Resetting Ignore list...");
	IOM_IGNORE = {};
end

----------------------------------------------------------------------
-- Player Joined Group
----------------------------------------------------------------------
function InviteOMatic_PlayerJoinedGroup(name)
	if( IOM_BG_ACTIVE ) then
		InviteOMatic_MakeRaid();
		
		IOM_AIG[name] = nil;
		IOM_AIG_ERROR[name] = nil;
		IOM_IGNORE[name] = nil;
		IOM_DECLINE[name] = nil;
		
	end
end

----------------------------------------------------------------------
-- Player Joined Battle
----------------------------------------------------------------------
function InviteOMatic_PlayerJoinedBattle(name)
	
	if( InviteOMaticOptions["autoInvite"] ) then
		InviteOMatic.invite(name);
	end
end

----------------------------------------------------------------------
-- Player Left Battle
----------------------------------------------------------------------
function InviteOMatic_PlayerLeftBattle(name)
	-- If purge is enabled, then uninvite this player

	if( InviteOMaticOptions["autoPurge"] ) then
		if( IsRaidLeader() or IsRaidOfficer() or IsPartyLeader() ) then
			for i=1,GetNumRaidMembers() do
				--Remove player from raid
				local name2 = GetRaidRosterInfo(i);
				if( name == name2 ) then
					UninviteByName(name);
					return;
				end
			end
			if( GetNumRaidMembers() == 0 ) then
				UninviteByName(name);
			end
		end
	end
end

----------------------------------------------------------------------
-- Player Declined
----------------------------------------------------------------------
function InviteOMatic_PlayerDeclined(name)
	-- Player declined our group invite
	if( IOM_DECLINE[name] == nil ) then
		IOM_DECLINE[name] = 1;
	else
		IOM_DECLINE[name] = IOM_DECLINE[name] + 1;
		
		if( IOM_DECLINE[name] > InviteOMaticOptions["declinettl"] ) then
			IOM_DECLINE[name] = InviteOMaticOptions["declinettl"];
		end
	end

	InviteOMatic.debug(name.." declined invitation "..(InviteOMaticOptions["declinettl"] - IOM_DECLINE[name]).." retries left");

end

----------------------------------------------------------------------
-- Player Ignores
----------------------------------------------------------------------
function InviteOMatic_PlayerIgnores(name)
	-- Player ignored you
	if( IOM_IGNORE[name] == nil ) then
		IOM_IGNORE[name] = 0;
	else
		IOM_IGNORE[name] = IOM_IGNORE[name] + 1;
		
		if( IOM_IGNORE[name] > InviteOMaticOptions["ignorettl"] ) then
			IOM_IGNORE[name] = InviteOMaticOptions["ignorettl"];
		end
	end

	InviteOMatic.debug(name.." ingored you "..(InviteOMaticOptions["ignorettl"] - IOM_IGNORE[name]).." retries left");

end

----------------------------------------------------------------------
-- Player Already in group
----------------------------------------------------------------------
function InviteOMatic_PlayerAlreadyGrouped(name)
	-- Player is already grouped
	if( IOM_AIG[name] == nil ) then
		IOM_AIG[name] = 0;
	else
		IOM_AIG[name] = IOM_AIG[name] + 1;
		
		if( IOM_AIG[name] > InviteOMaticOptions["aigttl"] ) then
			IOM_AIG[name] = InviteOMaticOptions["aigttl"];
		end
	end

	InviteOMatic.debug(name.." was already in group "..(InviteOMaticOptions["aigttl"] - IOM_AIG[name]).." retries left");

end

----------------------------------------------------------------------
-- Called when InviteOMatic detects that you have left a BG
----------------------------------------------------------------------
function InviteOMatic_LeftBG()
	IOM_BG_ACTIVE_INDEX = -1;
	IOM_BG_ACTIVE = false;
	IOM_LAST_INVITE = 0;
	IOM_INVITE_FIRST = true;

	IOM_AIG = {};
	IOM_AIG_ERROR = {};
	IOM_DECLINE = {};
	IOM_IGNORE = {};

	IOM_GROUPBUG = {};


	InviteOMatic.debug("You left the BattleGround");
	
	IOM_UPDATE_PURGE_TIMER = false;
	IOM_UPDATE_INVITE_TIMER = false;

	this:UnregisterEvent("CHAT_MSG_SYSTEM");
end

----------------------------------------------------------------------
-- Called On_Update
----------------------------------------------------------------------
function InviteOMatic_OnUpdate(dt)
	if( not IOM_READY ) then 
		return;
	end
	if( InviteOMatic_IsDisabled() ) then
		return;
	end
	
	if( dt == nil ) then
		return;
	end
	
	if( not IOM_READY ) then
		return;
	end

	if( IOM_UPDATE_INVITE_TIMER ) then
		IOM_INVITE_TIMER = IOM_INVITE_TIMER - dt;
		if( IOM_INVITE_TIMER <= 0 ) then
			InviteOMatic.debug("Invite Timer fired...");
			IOM_INVITE_TIMER = InviteOMaticOptions.inviteDelay;
			if( InviteOMaticOptions.autoInvite ) then
				InviteOMatic_SendInvites();
			end
		end
	end

	if( IOM_UPDATE_PURGE_TIMER ) then	
		IOM_PURGE_TIMER = IOM_PURGE_TIMER - dt;
		if( IOM_PURGE_TIMER <= 0 ) then
			InviteOMatic.debug("Purge Timer fired...");
			IOM_PURGE_TIMER = InviteOMaticOptions.purgeDelay;
			if( InviteOMaticOptions.autoPurge ) then
				InviteOMatic_DoPurge();
			end
		end
	end
end

----------------------------------------------------------------------
-- Logs the msg to the default chat frame
--
-- @param msg The message to output
----------------------------------------------------------------------
function IOM_PrintMsg(msg)
	if( not IOM_READY ) then 
		return;
	end
	if( InviteOMatic_IsDisabled() ) then
		return;
	end

	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end
end

----------------------------------------------------------------------
-- Logs the debug msg to the default chat frame
--
-- @param msg The message to output
----------------------------------------------------------------------
function IOM_PrintDebugMsg(msg)
	if( InviteOMaticOptions["debug"] ) then
		InviteOMatic.log("IOM Debug - "..msg);
	end
end

----------------------------------------------------------------------
-- Checks if addon has been disabled in Khaos, and disables addon accordingly :)
----------------------------------------------------------------------
function InviteOMatic_IsDisabled()
	if( Khaos ) then
		return not Khaos.getSetEnabled("InviteOMatic");
	else
		-- InviteOMatic.log("Khaos not detected, so cant check status");
	  return false;
	end
end


----------------------------------------------------------------------
-- Register a Khaos config
----------------------------------------------------------------------
function InviteOMatic_RegisterKhaos()
	if( Khaos ) then
		Khaos.registerFolder( 
       {
           id = "invite";
           text = "Invite";
           helptext = "Invite helpers";
           difficulty = 1;
       }
    );
   local optionSet =
       {
           id="InviteOMatic";
           text="InviteOMatic";
           helptext="Invite Helper, with a twist!";
           difficulty=1;
           options = {
               {
                   id="InviteHeader";
                   text="InviteOMatic Settings";
                   helptext="InviteOMatic";
                   type = K_HEADER;
               };
               {
                   id="InviteAutoInvite";
                   text="Auto Invite";
                   helptext="Automatically invites everyone in a BG instance.";
                   type = K_TEXT;
                   check = true;
                   callback = InviteOMatic_InviteAutoInviteCheck;
                   feedback = function(state) end;
                   default = {
                     checked = true;
                   };
                   disabled = {
                   		 checked = false;
                   };
               };
               {
                   id="InviteAutoPurge";
                   text="Auto Purge";
                   helptext="Automatically purges offline players, and players that leaves the BG.";
                   type = K_TEXT;
                   check = true;
                   callback = InviteOMatic_InviteAutoPurgeCheck;
                   feedback = function(state) end;
                   default = {
                     checked = true;
                   };
                   disabled = {
                   		 checked = false;
                   };
               };
               {
                   id="InviteWhisperInvite";
                   text="Whisper Invite";
                   helptext="Automatically invites people whispering you the magic word 'invite'";
                   type = K_TEXT;
                   check = true;
                   callback = InviteOMatic_InviteWhisperCheck;
                   feedback = function(state) end;
                   default = {
                     checked = true;
                   };
                   disabled = {
                   		 checked = false;
                   };
               };
               {
                   id="InviteDelay";
                   key="InviteDelay";
                   value=true;
                   text="Time between invites:";
                   helptext="This value represents the time InviteOMatic will wait between each invite cycle, the value is in seconds.";
                   type = K_SLIDER;
                   check = false;
                   setup = {
                       sliderMin = 1;
                       sliderMax = 20;
                       sliderLowText = "Fast";
                       sliderHighText = "Slow";
                       sliderStep = 1;
                       sliderText = "Invite Cycle";
                       sliderDisplayfunc = function (state) return state.slider; end;                        
                   };
                   callback = InviteOMatic_InviteCycleSliderCallback;
                   feedback = function(state) end;
                   default = {
                       slider = 10;
                   };
                   disabled = {
                   		 slider = 10;
                   };
               };
               {
                   id="PurgeDelay";
                   key="PurgeDelay";
                   value=true;
                   text="Time between purges:";
                   helptext="This value represents the time InviteOMatic will wait between each purge cycle, the value is in seconds.";
                   type = K_SLIDER;
                   check = false;
                   setup = {
                       sliderMin = 1;
                       sliderMax = 20;
                       sliderLowText = "Fast";
                       sliderHighText = "Slow";
                       sliderStep = 1;
                       sliderText = "Purge Cycle";
                       sliderDisplayfunc = function (state) return state.slider; end;                        
                   };
                   callback = InviteOMatic_PurgeCycleSliderCallback;
                   feedback = function(state) end;
                   default = {
                       slider = 10;
                   };
                   disabled = {
                   		 slider = 10;
                   };
               };
               {
                   id="InviteRetryHeader";
                   text="InviteOMatic Retry Settings";
                   helptext="InviteOMatic";
                   type = K_HEADER;
               };
               {
                   id="InviteAIGRetry";
                   value=true;
                   text="Already in group retries:";
                   helptext="Number of retries to invite people that are already in group.";
                   type = K_SLIDER;
                   check = false;
                   setup = {
                       sliderMin = 0;
                       sliderMax = 20;
                       sliderLowText = "None";
                       sliderHighText = "Many";
                       sliderStep = 1;
                       sliderText = "Number of Retries";
                       sliderDisplayfunc = function (state) return state.slider; end;                        
                   };
                   callback = InviteOMatic_InviteAIGRetry;
                   feedback = function(state) end;
                   default = {
                       slider = 10;
                   };
                   disabled = {
                   		 slider = 10;
                   };
               };
               {
                   id="InviteDeclineRetry";
                   key="InviteDeclineRetry";
                   value=true;
                   text="Decline retries:";
                   helptext="Number of retries to invite people that decline an invitation.";
                   type = K_SLIDER;
                   check = false;
                   setup = {
                       sliderMin = 0;
                       sliderMax = 10;
                       sliderLowText = "None";
                       sliderHighText = "Many";
                       sliderStep = 1;
                       sliderText = "Number of Retries";
                       sliderDisplayfunc = function (state) return state.slider; end;                        
                   };
                   callback = InviteOMatic_InviteDeclineRetry;
                   feedback = function(state) end;
                   default = {
                       slider = 1;
                   };
                   disabled = {
                   		 slider = 1;
                   };
               };
               {
                   id="InviteIgnoreRetry";
                   key="InviteIgnoreRetry";
                   value=true;
                   text="Ignore retries:";
                   helptext="Number of retries to invite people that are ignoring you.";
                   type = K_SLIDER;
                   check = false;
                   setup = {
                       sliderMin = 0;
                       sliderMax = 10;
                       sliderLowText = "None";
                       sliderHighText = "Many";
                       sliderStep = 1;
                       sliderText = "Number of Retries";
                       sliderDisplayfunc = function (state) return state.slider; end;                        
                   };
                   callback = InviteOMatic_InviteIgnoreRetry;
                   feedback = function(state) end;
                   default = {
                       slider = 1;
                   };
                   disabled = {
                   		 slider = 1;
                   };
               };
               {
                   id="InviteMagicHeader";
                   text="InviteOMatic Magic Word";
                   helptext="InviteOMatic";
                   type = K_HEADER;
               };
               {
                   id="InviteMagicWord";
                   value={IOM_INVITE_REG_EXP};
                   text="Magic Word (REGEXP)";
                   helptext="A reqular expression for the magic invite word.";
                   type = K_EDITBOX;
                   callback = InivteOMatic_InviteMagicWord;
                   feedback = function(state) end;
                   
                   setup = {
                       callOn = {"enter"};
                       multiLine = true;
                   };
                   default = {
                       value = IOM_INVITE_REG_EXP;
                   };
                   disabled = {
                       value = "";
                   };
               };
               {
                   id="InviteMsgHeader";
                   text="InviteOMatic Messages";
                   helptext="InviteOMatic";
                   type = K_HEADER;
               };
               {
                   id="InviteSendSpam";
                   text="Send spam message at invite";
                   helptext="Should the addon send a spam message over SAY when doing first invite.";
                   type = K_TEXT;
                   check = true;
                   callback = InviteOMatic_SendSpamOption;
                   feedback = function(state) end;
                   default = {
                     checked = true;
                   };
                   disabled = {
                   		 checked = false;
                   };
               };
               {
                   id="InviteSpamMsg";
                   value={IOM_FIRST_INVITE_SPAM_DEFAULT};
                   text="Invite Spam Message";
                   helptext="Message to spam when doing first invite round.";
                   type = K_EDITBOX;
                   callback = InivteOMatic_InviteSpamMsg;
                   feedback = function(state) end;
                   
                   setup = {
                       callOn = {"enter"};
                       multiLine = true;
                   };
                   default = {
                       value = IOM_FIRST_INVITE_SPAM_DEFAULT;
                   };
                   disabled = {
                       value = "";
                   };
               };
               {
                   id="InviteSendAIGSpam";
                   text="Send AIG spam";
                   helptext="Should a message be sent to a player who has reached the max number of Already in group retries.";
                   type = K_TEXT;
                   check = true;
                   callback = InviteOMatic_SendAIGSpamOption;
                   feedback = function(state) end;
                   default = {
                     checked = true;
                   };
                   disabled = {
                   		 checked = false;
                   };
               };
							 {
                   id="InviteAIGSpamMsg";
                   value={IOM_ERROR_AIG_DEFAULT};
                   text="AIG Spam Message";
                   helptext="Message to send to a player who reaches the maximum number of Already in group retries.";
                   type = K_EDITBOX;
                   callback = InivteOMatic_AIGSpamMsg;
                   feedback = function(state) end;
                   setup = {
                       callOn = {"enter"};
                       multiLine = true;
                   };
                   default = {
                       value = IOM_ERROR_AIG_DEFAULT;
                   };
                   disabled = {
                       value = "";
                   };
               };
               {
                   id="InviteDebug";
                   text="Show debug messages";
                   helptext="Disable/Enable showing of debug strings, messages. (Mostly used for development)";
                   type = K_TEXT;
                   check = true;
                   callback = InviteOMatic_InviteDebugCheck;
                   feedback = function(state) end;
                   default = {
                     checked = false;
                   };
                   disabled = {
                   		 checked = false;
                   };
               };
               {
                   id="InviteClearHeader";
                   text="InviteOMatic Clear Lists";
                   helptext="InviteOMatic";
                   type = K_HEADER;
               };
               {
                   id="InviteResetAIG";
                   text="Reset Already in group";
                   helptext="Resets the list of players that are already in a group";
                   type = K_BUTTON;
                   callback = InviteOMatic_ResetAIG;
									 setup={buttonText="Reset AIG"};
               };
               {
                   id="InviteResetDecline";
                   text="Reset Decline";
                   helptext="Resets the list of players that declined the invite";
                   type = K_BUTTON;
                   callback = InviteOMatic_ResetDecline;
									 setup={buttonText="Reset Declines"};
							 };
               {
                   id="InviteResetIgnore";
                   text="Reset Ignore";
                   helptext="Resets the list of players that ignored you";
                   type = K_BUTTON;
                   callback = InviteOMatic_ResetIgnore;
									 setup={buttonText="Reset Ignores"};
               };
           };
           default = true;
       };
       
	   Khaos.registerOptionSet(
	       "invite", optionSet
	   );
  else
		InviteOMatic.debug("Khaos not found");
	end
end

function InviteOMatic_InviteAutoInviteCheck(state)
	if( state.checked ) then
		InviteOMatic.debug("Auto invite enabled");
		InviteOMaticOptions["autoInvite"] = true;
		
		if( IOM_BG_ACTIVE ) then
			IOM_UPDATE_INVITE_TIMER = true;
		end
		
	else
		InviteOMatic.debug("Auto invite disabled");
		InviteOMaticOptions["autoInvite"] = false;

		IOM_UPDATE_INVITE_TIMER = false;
	end
end

function InviteOMatic_InviteWhisperCheck(state)
	if( state.checked ) then
		InviteOMatic.debug("Whisper invite enabled");
		InviteOMaticOptions["whisperInvite"] = true;
		
	else
		InviteOMatic.debug("Whisper invite disabled");
		InviteOMaticOptions["whisperInvite"] = false;
	end
end

function InviteOMatic_InviteAutoPurgeCheck(state)
	if( state.checked ) then
		InviteOMatic.debug("Auto purge enabled");
		InviteOMaticOptions["autoPurge"] = true;

		if( IOM_BG_ACTIVE ) then
			IOM_UPDATE_PURGE_TIMER = true;
		end

	else
		InviteOMatic.debug("Auto purge disabled");
		InviteOMaticOptions["autoPurge"] = false;

		IOM_UPDATE_PURGE_TIMER = false;
	end
end

function InviteOMatic_InviteIgnoreRetry(state)
	InviteOMatic.debug("Ignore retries set to: "..state.slider);
	InviteOMaticOptions["ignorettl"] = state.slider;
	
	-- Update old TTL values, if one is bigger
	
end

function InviteOMatic_InviteDeclineRetry(state)
	InviteOMatic.debug("Decline retries set to: "..state.slider);
	InviteOMaticOptions["declinettl"] = state.slider;
	
	-- Update old TTL values, if one is bigger
	
end

function InviteOMatic_InviteAIGRetry(state)
	InviteOMatic.debug("Already in group retries set to: "..state.slider);
	InviteOMaticOptions["aigttl"] = state.slider;
	
	-- Update old TTL values, if one is bigger
	
end

function InviteOMatic_SendAIGSpamOption(state)
	if( state.checked ) then
		InviteOMatic.debug("Sending spam message when max aig retries is reached.");
		InviteOMatic.sendAIGSpam = true;
	else
		InviteOMatic.debug("Not sending spam message when max aig retries is reached.");
		InviteOMatic.sendAIGSpam = false;
	end
end

function InviteOMatic_SendSpamOption(state)
	if( state.checked ) then
		InviteOMatic.debug("Sending spam message at first invite");
		InviteOMaticOptions["sendInviteSpam"] = true;
	else
		InviteOMatic.debug("Not sending spam message at first invite");
		InviteOMaticOptions["sendInviteSpam"] = false;
	end
end

function InviteOMatic_InviteDebugCheck(state)
	if( state.checked ) then
		InviteOMatic.debug("Debug output enabled.");
		InviteOMaticOptions["debug"] = true;
	else
		InviteOMatic.debug("Debug output disabled.");
		InviteOMaticOptions["debug"] = false;
	end
end

function InviteOMatic_PurgeCycleSliderCallback(state)
	InviteOMatic.debug("Purge Cycle set to: "..state.slider.." seconds");
	InviteOMaticOptions["purgeDelay"] = state.slider;

	IOM_PURGE_TIMER = InviteOMaticOptions["purgeDelay"];
end;

function InviteOMatic_InviteCycleSliderCallback(state)
	InviteOMatic.debug("Invite Cycle set to: "..state.slider.." seconds");
	InviteOMaticOptions["inviteDelay"] = state.slider;

	IOM_INVITE_TIMER = InviteOMaticOptions["inviteDelay"];

end;

function InivteOMatic_InviteMagicWord(state)
	InviteOMaticOptions["magicWord"] = state.value;
	InviteOMatic.debug("Magic word regexp set to: "..InviteOMaticOptions["magicWord"]);
end;

function InivteOMatic_InviteSpamMsg(state)
	InviteOMaticOptions["inviteMsg"] = state.value;
	InviteOMatic.debug("First spam message set to: "..InviteOMaticOptions["inviteMsg"]);
end;

function InivteOMatic_AIGSpamMsg(state)
	InviteOMaticOptions["aigMsg"] = state.value;
	InviteOMatic.debug("AIG spam message set to: "..InviteOMaticOptions["aigMsg"]);
end;

InviteOMatic = {
	log = IOM_PrintMsg,
	debug = IOM_PrintDebugMsg,
	invite = InviteOMatic_InvitePlayer,
	sendInvites = InviteOMatic_SendInvites,
	disbandGroup = InviteOMatic_DisbandRaidGroup,
}
