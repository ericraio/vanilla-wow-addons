--[[
--	//////////////////////////////////////////////
--	Variables Init
--	//////////////////////////////////////////////
]]
local rpgoGP_TITLE			="GuildProfiler";
local rpgoGP_ABBR			="GP";
local rpgoGP_AUTHOR			="calvin";
local rpgoGP_EMAIL			="calvin@rpgoutfitter.com";
local rpgoGP_URL			="www.rpgoutfitter.com";
local rpgoGP_DATE			="March 29, 2006";
local rpgoGP_PROVIDER		="rpgo";
local rpgoGP_VERSION		="1.5.1";
local rpgoGP_PROFILEDB		="1.5.1";
--	//////////////////////////////////////////////
if(not rpgoColorTitle) then rpgoColorTitle="909090"; end
if(not rpgoColorGreen) then rpgoColorGreen="00cc00"; end
if(not rpgoColorRed)   then rpgoColorRed  ="ff0000"; end
--	//////////////////////////////////////////////
local rpgoAddonsInfoGP={
	name=rpgoGP_TITLE,
	description="Export Guild Profiles for use out-of-game",
	version=rpgoGP_VERSION,
	releaseDate=rpgoGP_DATE,
	author=rpgoGP_AUTHOR,
	email=rpgoGP_EMAIL,
	website=rpgoGP_URL,
	category=MYADDONS_CATEGORY_OTHERS,
	frame="rpgoGPframe",
};
local rpgoAddonsHelpGP={
	"GuildProfileris an addon that extracts guild profile info including roster and rank info. This information can then be uploaded to your website to display your guild info.\n\n",
};
local GPprefScan={Enabled=1,SmartScan=1,Lite=1,Debug=0};
local rpgoGPlock,rpgoGPserver,rpgoGPguild;
local rpgoGPstate={};
--	//////////////////////////////////////////////
--	//////////////////////////////////////////////

--[[//////////////////////////////////////////////
--	rpgoGP Core Functions
--    OnLoad,LoadVar,RegisterEvents,InitState,OnEvent
--	////////////////////////////////////////////]]

--[[// OnLoad
--	////////////////////////////////////////////]]
function rpgoGP_OnLoad()
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("VARIABLES_LOADED");
	SLASH_RPGOGP1="/gp";
	SlashCmdList["RPGOGP"]=rpgoGP_ChatCommand;
	DEFAULT_CHAT_FRAME:AddMessage(rpgo_ColorizeTitle(rpgoGP_PROVIDER,rpgoGP_TITLE).." [v" .. rpgoGP_VERSION .. "] loaded.");
	rpgoGP_debug(rpgo_ColorizeTitle(rpgoGP_PROVIDER,rpgoGP_ABBR).." running in DEBUG MODE.");
end

--[[// LoadVar
--	////////////////////////////////////////////]]
function rpgoGP_LoadVar(toggle)
	rpgoGP_InitState();
	rpgoGP_InitPrefs();
	rpgoGP_RegisterEvents();
	rpgoGPserver=GetCVar("realmName");
	rpgoGPstate={}
	rpgoGPstate["LoadedVar"]=1;
end

--[[// RegisterEvents
--	////////////////////////////////////////////]]
function rpgoGP_RegisterEvents()
	local flagMode=0;
	if(rpgoGPpref["Enabled"]==1 and rpgoGPpref["SmartScan"]==1) then
		flagMode=1;
	end
	if(flagMode==1)then
		rpgoGPframe:RegisterEvent("GUILD_MOTD");
		rpgoGPframe:RegisterEvent("GUILD_ROSTER_SHOW");
		rpgoGPframe:RegisterEvent("GUILD_ROSTER_CLOSED");
		rpgoGPframe:RegisterEvent("GUILD_ROSTER_UPDATE");
		rpgoGP_debug("RegisterEvents");
	else
		rpgoGPframe:UnregisterEvent("GUILD_MOTD");
		rpgoGPframe:UnregisterEvent("GUILD_ROSTER_SHOW");
		rpgoGPframe:UnregisterEvent("GUILD_ROSTER_CLOSED");
		rpgoGPframe:UnregisterEvent("GUILD_ROSTER_UPDATE");
		rpgoGP_debug("UnregisterEvent");
	end
--[[
event:GUILD_ROSTER_UPDATE
arg1:nil ==> system?
arg1:c ==> offline?
--]]
	flagMode=nil;
end


--[[// EventHandler
--	////////////////////////////////////////////]]
function rpgoGP_EventHandler(event,arg1)
	if(rpgoDebugArg) then rpgoDebugArg(rpgoGP_ABBR,event,arg1); end
	if(event=="ADDON_LOADED" and arg1==rpgoGP_TITLE) then
		rpgo_myAddons(rpgoAddonsInfoGP,rpgoAddonsHelpGP);
		rpgoGPframe:UnregisterEvent("ADDON_LOADED");
		return;
	elseif(event=="VARIABLES_LOADED") then
		rpgoGP_LoadVar();
		rpgoGPframe:UnregisterEvent("VARIABLES_LOADED");
		return;
	end
	if(rpgoGPpref["Enabled"]==0) then return; end
	--if(rpgoLiteScan(rpgoGPpref["Lite"])) then return; end

	debugprofilestart();
	if(event=="CHAT_MSG_SYSTEM") then
		rpgoGP_ScanGuildInfo(arg1);
	end
	if(not rpgoGPlock and rpgoGPserver) then
		rpgoGPlock=1;
		if(not rpgoGPstate["Loaded"]) then
			rpgoGP_InitProfile();
		end
		if(event=="RPGOGP_SCAN") then
			rpgoGP_UpdateProfile();
		elseif(event=="RPGOGP_EXPORT") then
			rpgoGP_ForceExport();
		end
		rpgoGPlock=nil;
	end
	rpgoGP_debug("time: "..debugprofilestop().."ms");
end

--[[// InitState
--	////////////////////////////////////////////]]
function rpgoGP_InitState(arg)
	rpgoGPstate={};
	rpgoGPstate["Loaded"]=nil;
	rpgoGPstate["LoadedVar"]=arg;
	rpgoGPstate["Guild"]=nil;
	rpgoGPstate["GuildNum"]=nil;
	rpgoGPstate["GuildInfo"]=nil;
	rpgoGPstate["OfficerNote"]=nil;
end

--[[// InitPrefs
--	////////////////////////////////////////////]]
function rpgoGP_InitPrefs()
	local pref,val;
	if(not rpgoGPpref) then
		rpgoGPpref={};
	end
	for pref,val in GPprefScan do
		if(not rpgoGPpref[pref]) then
			rpgoGPpref[pref]=val;
		end
	end
		--cleanup
		for pref,val in rpgoGPpref do
			if(not GPprefScan[pref]) then
				rpgoGPpref[pref]=nil;
			end
		end
end

--[[//////////////////////////////////////////////
--	InitProfile
--	////////////////////////////////////////////]]
function rpgoGP_InitProfile()
	if (not rpgoGPstate["Loaded"]) then
		if ( not myProfile ) then
			myProfile={};
		end
		if ( not myProfile[rpgoGPserver] ) then
			myProfile[rpgoGPserver]={};
		end
	end
	rpgoGPstate["Loaded"]=1;
end

--[[//////////////////////////////////////////////
--	UpdateProfile
--	////////////////////////////////////////////]]
function rpgoGP_UpdateProfile()
	rpgoGP_InitProfile();
	rpgoGP_InitProfile();
	rpgoGP_GetGuildInfo();
end

--[[//////////////////////////////////////////////
--	ForceExport
--	////////////////////////////////////////////]]
function rpgoGP_ForceExport()
	rpgoGP_InitState(1);
	rpgoGP_InitProfile();
	rpgoGP_GetGuildInfo();
	rpgoGP_Show();
end

--[[// ChatCommand
--	////////////////////////////////////////////]]
function rpgoGP_ChatCommand(msg)
	if(msg)then
		msg=string.lower(msg);
		if (msg=="off") then
			rpgoGP_Toggle(0);
			return;
		elseif (msg=="on") then
			rpgoGP_Toggle(1);
			return;
		elseif (msg=="show") then
			rpgoGP_Show();
			return;
		elseif (msg=="export") then
			rpgoGP_EventHandler('RPGOGP_EXPORT');
			return;
		elseif (msg=="smart on") then
			rpgoGP_TogglePref("SmartScan",1);
			return;
		elseif (msg=="smart off") then
			rpgoGP_TogglePref("SmartScan",0);
			return;
		elseif (msg=="debug") then
			rpgoGP_Debug();
			return;
		end
	end
	DEFAULT_CHAT_FRAME:AddMessage(rpgo_ColorizeTitle(rpgoGP_PROVIDER,rpgoGP_TITLE).." Usage [v" .. rpgoGP_VERSION .. "]");
	DEFAULT_CHAT_FRAME:AddMessage("   /gp                        -- This Message");
	DEFAULT_CHAT_FRAME:AddMessage("   /gp on                   -- Turns GuildProfiler on");
	DEFAULT_CHAT_FRAME:AddMessage("   /gp off                   -- Turns GuildProfiler off");
	DEFAULT_CHAT_FRAME:AddMessage("   /gp show");
	DEFAULT_CHAT_FRAME:AddMessage("   /gp export");
	if(rpgoGPpref["Enabled"]==1) then
		DEFAULT_CHAT_FRAME:AddMessage(rpgo_ColorizeTitle(rpgoGP_PROVIDER,rpgoGP_ABBR)..": currently "..rpgo_ColorizeMsg(rpgoColorGreen,"enabled"));
		if(rpgoGPpref["SmartScan"]==1) then
			DEFAULT_CHAT_FRAME:AddMessage(rpgo_ColorizeTitle(rpgoGP_PROVIDER,rpgoGP_ABBR)..": smart mode "..rpgo_ColorizeMsg(rpgoColorGreen,"enabled"));
		else
			DEFAULT_CHAT_FRAME:AddMessage(rpgo_ColorizeTitle(rpgoGP_PROVIDER,rpgoGP_ABBR)..": smart mode "..rpgo_ColorizeMsg(rpgoColorRed,"disabled"));
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage(rpgo_ColorizeTitle(rpgoGP_PROVIDER,rpgoGP_ABBR)..": currently "..rpgo_ColorizeMsg(rpgoColorRed,"disabled"));
	end
end

--[[// Toggle
--	////////////////////////////////////////////]]
function rpgoGP_Toggle(toggle)
	rpgoGPpref["Enabled"]=toggle;
	if(toggle==1) then
		if (rpgoGPserver) then rpgoGPserver=GetCVar("realmName"); end
		rpgoGP_InitState(1);
	elseif(toggle==0) then
		rpgoGPstate=nil;
	end
	if(rpgoGPpref["Enabled"]==1) then
		DEFAULT_CHAT_FRAME:AddMessage(rpgo_ColorizeTitle(rpgoGP_PROVIDER,rpgoGP_ABBR)..": "..rpgo_ColorizeMsg(rpgoColorGreen,"enabled"));
		if(rpgoGPpref["SmartScan"]==1) then
			DEFAULT_CHAT_FRAME:AddMessage(rpgo_ColorizeTitle(rpgoGP_PROVIDER,rpgoGP_ABBR)..": smart mode "..rpgo_ColorizeMsg(rpgoColorGreen,"enabled"));
		else
			DEFAULT_CHAT_FRAME:AddMessage(rpgo_ColorizeTitle(rpgoGP_PROVIDER,rpgoGP_ABBR)..": smart mode "..rpgo_ColorizeMsg(rpgoColorRed,"disabled"));
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage(rpgo_ColorizeTitle(rpgoGP_PROVIDER,rpgoGP_ABBR)..": "..rpgo_ColorizeMsg(rpgoColorRed,"disabled"));
	end
	rpgoGP_RegisterEvents();
	if ( (rpgoGPpref["Enabled"]==0) and myProfile["Guild"] ) then
		myProfile[rpgoGPserver]["Guild"]=nil;
	end
end

--[[// Toggle
--	////////////////////////////////////////////]]
function rpgoGP_TogglePref(pref,toggle)
	if(rpgoGPpref[pref] and toggle) then
		rpgoGPpref[pref]=toggle;
	end
	if(rpgoGPpref and rpgoGPpref[pref]==1) then
		DEFAULT_CHAT_FRAME:AddMessage(rpgo_ColorizeTitle(rpgoGP_PROVIDER,rpgoGP_ABBR)..": "..pref.." "..rpgo_ColorizeMsg(rpgoColorGreen,"on"));
	else
		DEFAULT_CHAT_FRAME:AddMessage(rpgo_ColorizeTitle(rpgoGP_PROVIDER,rpgoGP_ABBR)..": "..pref.." "..rpgo_ColorizeMsg(rpgoColorRed,"off"));
	end
	if(pref=="SmartScan") then
		rpgoGP_RegisterEvents();
		rpgoGP_Toggle(rpgoGPpref["Enabled"]);
	end
end

--[[// Debug
--	////////////////////////////////////////////]]
function rpgoGP_Debug()
	if (rpgoGPpref["Debug"]==1) then
		rpgoGPpref["Debug"]=0;
	else
		rpgoGPpref["Debug"]=1;
		rpgoGP_debug("Debug Mode: enabled");
	end
end

--[[// Show
--	////////////////////////////////////////////]]
function rpgoGP_Show()
	if( rpgoGPpref["Enabled"]==1) then
		if(rpgoGPstate["Loaded"]==1 and rpgoGPstate["Guild"]) then
			local msg="";
			DEFAULT_CHAT_FRAME:AddMessage(rpgo_ColorizeTitle(rpgoGP_PROVIDER,rpgoGP_ABBR)..":  guild info scanned this session");
			if(rpgoGPstate["Guild"]==1) then
				DEFAULT_CHAT_FRAME:AddMessage("    Profile for: '" .. rpgoGPguild .. "' on " .. rpgoGPserver);
				if(rpgoGPstate["GuildNum"]) then
					DEFAULT_CHAT_FRAME:AddMessage("    Members: " .. rpgoGPstate["GuildNum"]);
				else
					DEFAULT_CHAT_FRAME:AddMessage("    Members: not scanned");
				end
			else
				DEFAULT_CHAT_FRAME:AddMessage("    you are not in a guild");
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage(rpgo_ColorizeTitle(rpgoGP_PROVIDER,rpgoGP_ABBR)..": "..rpgo_ColorizeMsg(rpgoColorRed," no guild info scanned this session"));
			DEFAULT_CHAT_FRAME:AddMessage("    open your guild roster to scan guild information ('O'->'Guild')");
			DEFAULT_CHAT_FRAME:AddMessage("    or force the export with '/gp export'");
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage(rpgo_ColorizeTitle(rpgoGP_PROVIDER,rpgoGP_ABBR)..": currently "..rpgo_ColorizeMsg(rpgoColorRed,"disabled"));
	end
end

--[[//////////////////////////////////////////////
--	rpgoGP Extract functions
--	////////////////////////////////////////////]]
function rpgoGP_GetGuildInfo()
	GuildRoster();
	local isGuildMember=IsInGuild();
	local numGuildMembers=GetNumGuildMembers(true);
	local showOfflineTemp=GetGuildRosterShowOffline();
	SetGuildRosterShowOffline(true);
	if(not isGuildMember) then
		rpgoGPstate["Guild"]=0;
	elseif(rpgoGPstate["Guild"]~=isGuildMember or rpgoGPstate["GuildNum"]~=numGuildMembers) then
		rpgoGPstate["Guild"]=isGuildMember;
		local currHour, currMinute=GetGameTime();
		local pTime=GetTime();
		local name, rank, rankIndex, level, class, zone, group, note, officernote, online;
		local yearsOffline, monthsOffline, daysOffline, hoursOffline;
		local guildName, guildRankName, guildRankIndex=GetGuildInfo("player");
		local guildMemberTemp=nil;
		local guildMemberNumTemp=nil;
		if(myProfile[rpgoGPserver]["Guild"] and myProfile[rpgoGPserver]["Guild"]["Members"]) then
			guildMemberTemp=myProfile[rpgoGPserver]["Guild"]["Members"];
			guildMemberNumTemp=myProfile[rpgoGPserver]["Guild"]["NumMembers"];
		end
		myProfile[rpgoGPserver]["Guild"]= {};
		myProfile[rpgoGPserver]["Guild"]["Version"]=rpgoGP_PROFILEDB;
		myProfile[rpgoGPserver]["Guild"]["GPversion"]=rpgoGP_VERSION;
		myProfile[rpgoGPserver]["Guild"]["GPprovider"]=rpgoGP_PROVIDER;
		myProfile[rpgoGPserver]["Guild"]["DBversion"]=rpgoGP_PROFILEDB;
		myProfile[rpgoGPserver]["Guild"]["Guild"]=guildName;
		myProfile[rpgoGPserver]["Guild"]["Motd"]=GetGuildRosterMOTD();
		myProfile[rpgoGPserver]["Guild"]["Info"]=GetGuildInfoText();
		myProfile[rpgoGPserver]["Guild"]["Hour"]=currHour;
		myProfile[rpgoGPserver]["Guild"]["Minute"]=currMinute;
		myProfile[rpgoGPserver]["Guild"]["DateExtracted"]=date();
		myProfile[rpgoGPserver]["Guild"]["Date"]=date();
		myProfile[rpgoGPserver]["Guild"]["DateUTC"]=date("!%m/%d/%y %H:%M:%S");
		myProfile[rpgoGPserver]["Guild"]["Locale"]=GetLocale();
		myProfile[rpgoGPserver]["Guild"]["Members"]=guildMemberTemp;
		local _,faction=UnitFactionGroup("player");
		myProfile[rpgoGPserver]["Guild"]["Faction"]=faction;
		if(numGuildMembers~=0) then
			myProfile[rpgoGPserver]["Guild"]["NumMembers"]=numGuildMembers;
		else
			myProfile[rpgoGPserver]["Guild"]["NumMembers"]=guildMemberNumTemp;
		end
		guildMemberTemp=nil;
		guildMemberNumTemp=nil;
		rpgoGPguild=guildName;
		rpgoGP_GetGuildMembers(numGuildMembers);
	end
	SetGuildRosterShowOffline(showOfflineTemp);
	if(not rpgoGPstate["GuildInfo"]) then
		rpgoGPframe:RegisterEvent("CHAT_MSG_SYSTEM");
		GuildInfo();
		rpgoGPstate["GuildInfo"]=1;
	end
	rpgoGP_GuildControl();
end

function rpgoGP_GuildControl()
	myProfile[rpgoGPserver]["Guild"]["Ranks"]={};
	myProfile[rpgoGPserver]["Guild"]["Ranks"]["Headers"]={};
	for i=1,MAX_GUILDCONTROL_OPTIONS do
		myProfile[rpgoGPserver]["Guild"]["Ranks"]["Headers"]["Control"..i]=getglobal("GUILDCONTROL_OPTION"..i);
	end
	myProfile[rpgoGPserver]["Guild"]["Ranks"]["Index"]={};
	for i=1,GuildControlGetNumRanks() do
		GuildControlSetRank(i);
		myProfile[rpgoGPserver]["Guild"]["Ranks"]["Index"]["Rank"..i]={};
		myProfile[rpgoGPserver]["Guild"]["Ranks"]["Index"]["Rank"..i]["Index"]=i;
		myProfile[rpgoGPserver]["Guild"]["Ranks"]["Index"]["Rank"..i]["Title"]=GuildControlGetRankName(i);
		myProfile[rpgoGPserver]["Guild"]["Ranks"]["Index"]["Rank"..i]["Control"]=rpgoGP_GuildControlFlags(GuildControlGetRankFlags());
	end
end

function rpgoGP_GuildControlFlags(...)
	local flags='';
	for i=1,arg.n,1 do
		if(i>1) then flags=flags..':'; end
		if(arg[i]) then
			flags=flags..arg[i];
		else
			flags=flags..0;
		end
	end
	return(flags);
end

function rpgoGP_GetGuildMembers(numMembers)
	rpgoGPstate["OfficerNote"]=CanViewOfficerNote();
	if(numMembers > 0 and (rpgoGPstate["GuildNum"]~=numMembers)) then
		rpgoGPstate["GuildNum"]=0;
		local guildMemberTemp=nil;
		if(myProfile[rpgoGPserver]["Guild"] and myProfile[rpgoGPserver]["Guild"]["Members"]) then
			guildMemberTemp=myProfile[rpgoGPserver]["Guild"]["Members"];
		end
		myProfile[rpgoGPserver]["Guild"]["Members"]={};
		for i=1,numMembers do
			name,rank,rankIndex,level,class,zone,note,officernote,online,status=GetGuildRosterInfo(i);
			yearsOffline,monthsOffline,daysOffline,hoursOffline=GetGuildRosterLastOnline(i);
			if(name~=nil)then
				myProfile[rpgoGPserver]["Guild"]["Members"][name]={};
				myProfile[rpgoGPserver]["Guild"]["Members"][name]["Name"]=name;
				myProfile[rpgoGPserver]["Guild"]["Members"][name]["Rank"]=rank;
				myProfile[rpgoGPserver]["Guild"]["Members"][name]["RankIndex"]=rankIndex;
				myProfile[rpgoGPserver]["Guild"]["Members"][name]["Level"]= level;
				myProfile[rpgoGPserver]["Guild"]["Members"][name]["Class"]= class;
				myProfile[rpgoGPserver]["Guild"]["Members"][name]["Zone"]= zone;
				myProfile[rpgoGPserver]["Guild"]["Members"][name]["Group"]="no";
				myProfile[rpgoGPserver]["Guild"]["Members"][name]["Status"]=status;
				myProfile[rpgoGPserver]["Guild"]["Members"][name]["Note"]= note;
				if(rpgoGPstate["OfficerNote"] and officernote~="") then
					myProfile[rpgoGPserver]["Guild"]["Members"][name]["OfficerNote"]=officernote;
				elseif((guildMemberTemp) and guildMemberTemp[name]) then
					myProfile[rpgoGPserver]["Guild"]["Members"][name]["OfficerNote"]=guildMemberTemp[name]["OfficerNote"];
				else
					myProfile[rpgoGPserver]["Guild"]["Members"][name]["OfficerNote"]=officernote;
				end
				if(online) then
					myProfile[rpgoGPserver]["Guild"]["Members"][name]["Online"]=online;
				else
					myProfile[rpgoGPserver]["Guild"]["Members"][name]["LastOnline"]= {};
					myProfile[rpgoGPserver]["Guild"]["Members"][name]["LastOnline"]["Hour"]= hoursOffline;
					myProfile[rpgoGPserver]["Guild"]["Members"][name]["LastOnline"]["Day"]= daysOffline;
					myProfile[rpgoGPserver]["Guild"]["Members"][name]["LastOnline"]["Month"]= monthsOffline;
					myProfile[rpgoGPserver]["Guild"]["Members"][name]["LastOnline"]["Year"]= yearsOffline;
				end
				rpgoGPstate["GuildNum"]=rpgoGPstate["GuildNum"]+1;
			end
		end
		if(numMembers ~= rpgoGPstate["GuildNum"]) then
			myProfile[rpgoGPserver]["Guild"]["Members"]=guildMemberTemp;
		end
		guildMemberTemp=nil;
	end
end

function rpgoGP_ScanGuildInfo(msg)
	rpgoGP_debug("scanGI "..msg);
	local d,p,a;
	if(msg) then
		_,_,d,p,a=string.find(msg,"%w+ (%d+[-.]%d+[-.]%d+), (%d+) %w+, (%d+) %w+");
		if(d and p and a) then
			rpgoGP_debug("scanGI "..d.." "..p.." "..a);
			myProfile[rpgoGPserver]["Guild"]["Created"]=d;
			myProfile[rpgoGPserver]["Guild"]["NumAccounts"]=a;
			rpgoGPframe:UnregisterEvent("CHAT_MSG_SYSTEM");
		end
	end
end

--[[//////////////////////////////////////////////
--	general functions
--	////////////////////////////////////////////]]
function rpgoOfficerNote(oNote,oldNote)
	if(rpgoGPstate["OfficerNote"]) then
		return oNote;
	elseif(oldNote) then
		return oldNote;
	else
		return "";
	end
end

--[[//////////////////////////////////////////////
--	general rpgo functions
--	////////////////////////////////////////////]]
--[function] msg:string
function rpgoGP_debug(msg)
	if(rpgoGPpref and rpgoGPpref["Debug"]==1) then
		if(rpgoDebug) then rpgoDebug(rpgoGP_ABBR,msg);
		else rpgo_VerboseMsg(rpgo_ColorizeTitle(rpgoGP_PROVIDER,rpgoGP_ABBR)..": ".."[" .. msg .. "]",1,0,0); end end
end

-- USAGE: rpgo_ColorizeTitle(provider,title)
if (not rpgo_ColorizeTitle) then rpgo_ColorizeTitle=function(provider,title) if(provider and title) then return rpgo_ColorizeMsg(rpgoColorTitle,provider.."-"..title); end end end
-- USAGE: rpgo_ColorizeMsg(color,msg)
if (not rpgo_ColorizeMsg) then rpgo_ColorizeMsg=function(color,msg) if(color and msg) then return "|cff"..color..msg.."|r"; end end end
-- Register the addon in myAddOns
if (not rpgo_myAddons) then rpgo_myAddons=function(info,help) if(myAddOnsFrame_Register) then myAddOnsFrame_Register(info, help); end end end
