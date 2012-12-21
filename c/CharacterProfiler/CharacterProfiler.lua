--[[
--	//////////////////////////////////////////////
--	Variables Init
--	//////////////////////////////////////////////
]]
local rpgoCP_TITLE			="CharacterProfiler";
local rpgoCP_ABBR			="CP";
local rpgoCP_AUTHOR			="calvin";
local rpgoCP_EMAIL			="calvin@rpgoutfitter.com";
local rpgoCP_URL			="www.rpgoutfitter.com";
local rpgoCP_DATE			="June 20, 2006";
local rpgoCP_PROVIDER		="rpgo";
local rpgoCP_VERSION		="1.5.4a";
local rpgoCP_PROFILEDB		="1.5.4a";
local rpgoCP_TOOLTIP		="rpgoCPtooltip";
local rpgoCP_OPTION			="";
--	//////////////////////////////////////////////
if(not rpgoColorTitle) then rpgoColorTitle="909090"; end
if(not rpgoColorGreen) then rpgoColorGreen="00cc00"; end
if(not rpgoColorRed)   then rpgoColorRed  ="ff0000"; end
--	//////////////////////////////////////////////
local timeWait=3;
local timePlayed=-1;
local timeLevelPlayed=-1;
local TradeSkillCode={optimal=4,medium=3,easy=2,trivial=1,header=0};
local UnitPower={"Rage","Focus","Energy","Happiness"};UnitPower[0]="Mana";
local UnitSlots={"Head","Neck","Shoulder","Shirt","Chest","Waist","Legs","Feet","Wrist","Hands","Finger0","Finger1","Trinket0","Trinket1","Back","MainHand","SecondaryHand","Ranged","Tabard"};UnitSlots[0]="Ammo";
local UnitStatName={"Strength","Agility","Stamina","Intellect","Spirit"};
local UnitResistName={"Holy","Fire","Nature","Frost","Shadow","Arcane"};
local CPevents={"PLAYER_LOGIN","PLAYER_ENTERING_WORLD","PLAYER_LEVEL_UP","TIME_PLAYED_MSG",
	"CRAFT_SHOW","CRAFT_CLOSE","CRAFT_UPDATE","SPELLS_CHANGED","TRADE_SKILL_SHOW","TRADE_SKILL_UPDATE","TRADE_SKILL_CLOSE",
	"BANKFRAME_CLOSED","MAIL_SHOW","MAIL_INBOX_UPDATE","MAIL_CLOSED","MERCHANT_CLOSED","MINIMAP_ZONE_CHANGED","GOSSIP_SHOW","GOSSIP_CLOSED",
	"PLAYER_CONTROL_LOST","PLAYER_CONTROL_GAINED","QUEST_FINISHED","PET_STABLE_CLOSED"};
local CPprefs={
	enabled=true,tooltipshtml=true,reagenthtml=true,talentsfull=true,questsfull=false,lite=true,debug=false,honorold=true,ver=010500,
	scan={inventory=true,talents=true,honor=true,reputation=true,spells=true,pet=true,equipment=true,mail=true,professions=true,skills=true,quests=true,bank=true}
};
local rpgoCP_Usage={
	{"/cp","-- usage/help"},
	{"/cp [on|off]","-- turns on|off"},
	{"/cp export","-- force export"},
	{"/cp show","-- show current session scan"},
	{"/cp lite [on|off]","-- turns on|off lite scanning","this will disable scanning while in raid or instance"},
	{"/cp purge [all|server|char]","-- purge info"}
};

--[[//////////////////////////////////////////////
--	rpgoCP Core Functions
--    OnLoad,RegisterEvents,LoadVar,EventHandler,InitState,InitPrefs
--	////////////////////////////////////////////]]

--[[// OnLoad
--	////////////////////////////////////////////]]
function rpgoCP_OnLoad()
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("VARIABLES_LOADED");
	SLASH_RPGOCP1="/cp";
	SLASH_RPGOCP2="/rpgocp";
	SLASH_RPGOCP3="/profiler";
	SlashCmdList["RPGOCP"]=function(msg) rpgoCP_ChatCommand(msg); end
	rpgo_VerboseMsg(rpgo_ColorizeTitle(rpgoCP_PROVIDER,rpgoCP_TITLE).." [v" .. rpgoCP_VERSION .. "] loaded.");
end

--[[// RegisterEvents
--	////////////////////////////////////////////]]
function rpgoCP_RegisterEvents()
	rpgoCP_debug("CP: RegisterEvents");
	if(rpgoCPpref and rpgoCPpref["enabled"]) then
		rpgoCP_debug("    Events Registered");
		for index,event in CPevents do
			rpgoCPframe:RegisterEvent(event);
		end
	else
		rpgoCP_debug("    Events Unregistered");
		for index,event in CPevents do
			rpgoCPframe:UnregisterEvent(event);
		end
	end
end

--[[// EventHandler
--	////////////////////////////////////////////]]
function rpgoCP_EventHandler(event,arg1,arg2)
	--if(rpgoDebugArg and event) then rpgoDebugArg(rpgoCP_ABBR,event,arg1,arg2); end
	if(event=="ADDON_LOADED" and arg1==rpgoCP_TITLE) then
		rpgoCP_myAddons();
		this:UnregisterEvent("ADDON_LOADED");
		return;
	elseif(event=="VARIABLES_LOADED") then
		rpgoCP_InitState();
		rpgoCP_InitPref();
		rpgoCP_RegisterEvents();
		rpgoCP_LoadVar();
		this:UnregisterEvent("VARIABLES_LOADED");
		return;
	elseif(event=="PLAYER_LOGIN") then
		return;
	elseif(event=="PLAYER_ENTERING_WORLD") then
		return;
	elseif(event=="CRAFT_UPDATE") then
		rpgoCP_TradeTimer(event,arg1)
		return;
	elseif(event=="TRADE_SKILL_UPDATE") then
		rpgoCP_TradeTimer(event,arg1)
		return;
	elseif(not event) then
		return;
	end

	if(not rpgoCPpref or not rpgoCPpref["enabled"]) then return; end
	if(event=="SPELLS_CHANGED" and not rpgoCPstate["_loaded"]) then
		return;
	elseif(event=="MINIMAP_ZONE_CHANGED" and not rpgoCPstate["_loaded"]) then
		return;
	elseif(event=="PLAYER_LEAVING_WORLD" and not rpgoCPstate["_loaded"]) then
		return;
	elseif(event=="BAG_UPDATE") then
		rpgoCP_UpdateBagScan(arg1);
	elseif(event=="MAIL_SHOW") then

	elseif(event=="TIME_PLAYED_MSG") then
		rpgoCP_UpdatePlayed(arg1,arg2);
		return;
	elseif(event=="PLAYER_CONTROL_LOST") then
		this:UnregisterEvent("MINIMAP_ZONE_CHANGED");
		return;
	elseif(event=="PLAYER_CONTROL_GAINED") then
		this:RegisterEvent("MINIMAP_ZONE_CHANGED");
		if(rpgoCPstate["_loaded"]) then rpgoCP_UpdateZone(); end
		return;
	end
	if(rpgo_LiteScan(rpgoCPpref["lite"]) and event~="RPGOCP_EXPORT") then return; end
	debugprofilestart();
	if(not rpgoCPstate["_lock"] and rpgoCPplayer) then
		rpgoCPstate["_lock"]=1;
		if(not rpgoCPstate["_loaded"]) then
			rpgoCP_InitProfile();
			rpgoCP_LoadProfile();
		end
		if(event=="RPGOCP_SCAN") then
			rpgoCP_UpdateProfile();
		elseif(event=="PLAYER_LEAVING_WORLD") then
			rpgoCP_UpdateProfile();
		elseif(event=="RPGOCP_EXPORT") then
			rpgoCP_ForceExport();
		elseif(event=="MINIMAP_ZONE_CHANGED") then
			rpgoCP_UpdateZone();
		elseif(event=="SPELLS_CHANGED" and arg1=="LeftButton") then
			rpgoCP_GetSpellBook();
			rpgoCP_GetPetSpellBook();
		elseif(event=="BANKFRAME_CLOSED") then
			rpgoCP_GetBank();
			rpgoCP_GetEquipment();
			rpgoCP_GetInventory();
		elseif(event=="MAIL_CLOSED") then
			rpgoCP_GetMail();
			rpgoCP_GetEquipment();
			rpgoCP_GetInventory();
		elseif(event=="MERCHANT_CLOSED") then
			rpgoCP_GetEquipment();
			rpgoCP_GetInventory();
		elseif(event=="TRADE_SKILL_SHOW") then
			rpgoCP_GetSkills();
			rpgoCP_GetTradeSkill();
		elseif(event=="CRAFT_SHOW") then
			rpgoCP_GetSkills();
			rpgoCP_GetCraft();
		elseif(event=="PLAYER_LEVEL_UP") then
			rpgoCP_LoadProfile();
		elseif(event=="QUEST_FINISHED") then
			rpgoCP_GetQuests(force);
		elseif(event=="PET_STABLE_CLOSED") then
			rpgoCP_ScanPetStable();
		end
		rpgoCPstate["_lock"]=nil;
	end
	--rpgoCP_debug("time: "..debugprofilestop().."ms");
end

--[[// InitState
--	////////////////////////////////////////////]]
function rpgoCP_InitState(arg)
	local ttFrame=getglobal(rpgoCP_TOOLTIP);
	ttFrame:SetOwner(UIParent,"ANCHOR_NONE");
	rpgoCP_debug("CP: InitState");
	local _,tmpClass=UnitClass("player");
	rpgoCPstate={
		_vars=nil,_loaded=nil,_lock=nil,_bagevent=nil,
		_player=UnitName("player"),_server=GetRealmName(),_class=tmpClass,
		_skills={},
		Equipment=0, EquipmentKey=0,
		Guild=nil, GuildNum=nil,
		Inventory={},
		Bag={},
		Bank={}, BankTime=0,
		Skills=0,
		Talents=0,
		SpellBook={},
		Professions={},
		Reputation=0,
		Quests=0, QuestsLog=0,
		Mail=nil, MailTime=0,
		Honor=0,
		Stable={},
		Pets={}, PetSpell={},
	};
end

--[[// InitPrefs
--	////////////////////////////////////////////]]
function rpgoCP_InitPref()
	rpgoCP_debug("CP: InitPref");
	if(not CPprefs) then return; end
	if(not rpgoCPpref) then
		rpgoCPpref={};
	elseif(rpgoCPpref and (not rpgoCPpref["ver"] or rpgoCPpref["ver"] < 010500) ) then
		rpgoCP_ConvertPref();
	end
	rpgo_TidyPref(rpgoCPpref,CPprefs);
	rpgo_InitPref(rpgoCPpref,CPprefs);
end

--[[// ConvertPrefs
--	////////////////////////////////////////////]]
function rpgoCP_ConvertPref()
	if(not rpgoCPprefNew) then
		rpgoCPprefNew={};
	end
	if(rpgoCPpref and (not rpgoCPpref["ver"] or rpgoCPpref["ver"] < 010500) ) then
		rpgoCP_ConvertPrefSub(rpgoCPpref,rpgoCPprefNew);
	end
	rpgoCPpref=rpgoCPprefNew;
	rpgoCPpref["ver"]=010500;
end

--[[// LoadVar
--	////////////////////////////////////////////]]
function rpgoCP_LoadVar()
	rpgoCP_debug("CP: LoadVar");
	rpgoCPserver=GetRealmName();
	rpgoCPplayer=UnitName("player");
	_,rpgoCPclass=UnitClass("player");
	rpgoCPstate["_vars"]=1;
end

--[[// OverLoaded functions
--     PLAYER_QUITTING/PLAYER_LEAVING_WORLD
--     PetAbandon - to grab drop of pet
--	////////////////////////////////////////////]]
rpgoOldQuit=Quit;
function Quit()
	if(rpgoCPpref and rpgoCPpref["enabled"] and rpgoCPstate["_loaded"]) then
		rpgoCP_EventHandler('RPGOCP_SCAN');
		RequestTimePlayed();
	end
	return rpgoOldQuit();
end

rpgoOldLogout=Logout;
function Logout()
	if(rpgoCPpref and rpgoCPpref["enabled"] and rpgoCPstate["_loaded"]) then
		rpgoCP_EventHandler('RPGOCP_SCAN');
		RequestTimePlayed();
	end
	return rpgoOldLogout();
end

rpgoOldPetAbandon=PetAbandon;
function PetAbandon()
	if(rpgoCPpref and rpgoCPpref["enabled"]) then
		petName=UnitName("pet");
		if (rpgoCPstate["Stable"][petName]) then
			rpgoCPstate["Stable"][petName]=nil; end
		if (rpgoCPstate["Pets"][petName]) then
			rpgoCPstate["Pets"][petName]=nil; end
		if (rpgoCPstate["PetSpell"][petName]) then
			rpgoCPstate["PetSpell"][petName]=nil; end
		if (myProfile[rpgoCPserver][rpgoCPplayer]["Pets"] and myProfile[rpgoCPserver][rpgoCPplayer]["Pets"][petName]) then
			myProfile[rpgoCPserver][rpgoCPplayer]["Pets"][petName]=nil; end
	end
	return rpgoOldPetAbandon();
end

--[[// ChatCommand
--	////////////////////////////////////////////]]
function rpgoCP_ChatCommand(argline)
	arg=rpgo_Str2Ary(argline);
	if(arg[2]) then
		arg[2]=string.lower(arg[2]);
	end
	if(arg[1]) then
		arg[1]=string.lower(arg[1]);
		if(arg[1]=="off") then
			rpgoCP_Toggle(false);
			return;
		elseif(arg[1]=="on") then
			rpgoCP_Toggle(true);
			return;
		elseif(arg[1]=="show") then
			rpgoCP_Show();
			return;
		elseif(arg[1]=="export") then
			rpgoCP_EventHandler('RPGOCP_EXPORT');
			return;
		elseif(arg[1]=="debug") then
			rpgoCP_TogglePref("Debug",arg[2]);
			return;
		elseif(arg[1]=="purge") then
			rpgoCP_Purge(arg[2]);
			return;
		elseif(CPprefs[arg[1]]) then
			rpgoCP_TogglePref(arg[1],arg[2]);
			return;
		end
	end
	rpgo_VerboseMsg(rpgo_ColorizeTitle(rpgoCP_PROVIDER,rpgoCP_TITLE).." Usage [v" .. rpgoCP_VERSION .. "]");
	for index=1,table.getn(rpgoCP_Usage),1 do
		rpgo_VerboseMsg(rpgo_AssempleHelp(rpgoCP_Usage[index]));
	end
	rpgoCP_TogglePref("enabled");
end

--[[// Toggle
--	////////////////////////////////////////////]]
function rpgoCP_Toggle(val)
	--local valold=rpgoCPpref["enabled"];
	if(rpgoCPpref["enabled"]~=val) then
		rpgoCP_TogglePref("enabled",val);
		rpgoCP_RegisterEvents();
		if(val) then
			rpgoCP_InitState(1);
			rpgoCP_LoadVar();
			if(not rpgoCPstate["_loaded"]) then
				rpgoCP_InitProfile();
				rpgoCP_LoadProfile();
			end
		else
			rpgoCPstate=nil;
		end
	else
		rpgoCP_TogglePref("enabled",val);
	end
end

function rpgoCP_TogglePref(pref,val)
	local msg="["..pref.."]";
	if(val=="on") then val=true;
	elseif(val=="off") then val=false; end
	if(type(val)=="boolean" and rpgoCPpref[pref]~=val) then
		rpgoCPpref[pref]=val; msg=msg.." changed";
	else msg=msg.." currently"; end
	rpgo_VerboseMsg(rpgo_ColorizeTitle(rpgoCP_PROVIDER,rpgoCP_ABBR)..": "..msg..": "..rpgo_ColorizePref(rpgoCPpref[pref]));
end

--[[// Show
--	////////////////////////////////////////////]]
function rpgoCP_Show()
	if(rpgoCPpref["enabled"]) then
		if(rpgoCPplayer and rpgoCPstate["_loaded"]) then
			local msg="";
			local item=nil;
			local count=0;
			rpgo_VerboseMsg(rpgo_ColorizeTitle(rpgoCP_PROVIDER,rpgoCP_ABBR)..": character info scanned this session");

				msg="Profile for: " .. rpgoCPplayer .. "@" .. rpgoCPserver;
				if(myProfile[rpgoCPserver][rpgoCPplayer]["Level"]) then
					msg=msg.." (lvl "..myProfile[rpgoCPserver][rpgoCPplayer]["Level"]..")"
				end
			rpgo_VerboseMsg("  "..msg);
				msg="Zone: ";
				if(myProfile[rpgoCPserver][rpgoCPplayer]["Zone"]) then
					msg=msg..myProfile[rpgoCPserver][rpgoCPplayer]["Zone"];
					if(myProfile[rpgoCPserver][rpgoCPplayer]["SubZone"] and myProfile[rpgoCPserver][rpgoCPplayer]["SubZone"]~="") then
						msg=msg.."/"..myProfile[rpgoCPserver][rpgoCPplayer]["SubZone"];
					end
				else
					msg=msg..rpgo_ColorizeMsg(rpgoColorRed," not scanned");
				end
			rpgo_VerboseMsg("  "..msg);

				msg="Guild Info:  ";
				if(rpgoCPstate["Guild"]==0) then
					msg=msg.."not in a guild";
				elseif(rpgoCPstate["Guild"]) then
					if(myProfile[rpgoCPserver][rpgoCPplayer]["Guild"]["GuildName"] and myProfile[rpgoCPserver][rpgoCPplayer]["Guild"]["Title"]) then
						msg=msg.."Name:"..myProfile[rpgoCPserver][rpgoCPplayer]["Guild"]["Name"].."  Title:"..myProfile[rpgoCPserver][rpgoCPplayer]["Guild"]["Title"];
					else
						msg=msg..rpgo_ColorizeMsg(rpgoColorRed," not scanned1");
					end
				else
					msg=msg..rpgo_ColorizeMsg(rpgoColorRed," not scanned2");
				end
			rpgo_VerboseMsg("  " .. msg);

				msg="";
				msg=msg .. "Equipment:"..rpgoCPstate["Equipment"].."/"..table.getn(UnitSlots);
				msg=msg .. "  Skills:" ..rpgoCPstate["Skills"];
				msg=msg .. "  Talents:" ..rpgoCPstate["Talents"];
				if(rpgoCPstate["Mail"]) then
					msg=msg .. "  Mail:" ..rpgoCPstate["Mail"];
				end
			rpgo_VerboseMsg("  " .. msg);

				msg="";
				msg=msg .. "Quests:" ..rpgoCPstate["Quests"];
				msg=msg .. "  Reputation: " ..rpgoCPstate["Reputation"];
				if(rpgoCPstate["Honor"]~=0 and myProfile[rpgoCPserver][rpgoCPplayer]["Honor"]["RankName"]) then
					msg=msg .. "  Honor: " ..myProfile[rpgoCPserver][rpgoCPplayer]["Honor"]["RankName"];
				else
					msg=msg .. "  Honor: "..NONE;
				end
			rpgo_VerboseMsg("  " .. msg);

				count=0;
				msg="Professions:";
				for item in rpgoCPstate["Professions"] do
					msg=msg .. " " .. item..":"..rpgoCPstate["Professions"][item];
					count=count+1;
				end
				if(count==0) then
					msg=msg..rpgo_ColorizeMsg(rpgoColorRed," not scanned")..".   to scan: open each profession";
				end
			rpgo_VerboseMsg("  " .. msg);

				count=0;
				msg="SpellBook:";
				for item in rpgoCPstate["SpellBook"] do
					msg=msg .. " " .. item..":"..rpgoCPstate["SpellBook"][item];
					count=count+1;
				end
				if(count==0) then
					msg=msg..rpgo_ColorizeMsg(rpgoColorRed," not scanned")..".   to scan: open your spellbook";
				end
			rpgo_VerboseMsg("  " .. msg);

				count=0;
				msg="Inventory:";
				for item in rpgoCPstate["Inventory"] do
					msg=msg .. " Bag" .. item..":"..rpgoCPstate["Inventory"][item]["inv"].."/"..rpgoCPstate["Inventory"][item]["slot"];
					count=count+1;
				end
				if(count==0) then
					msg=msg..rpgo_ColorizeMsg(rpgoColorRed," not scanned")..".   to scan: open your bank or 'character info'";
				end
			rpgo_VerboseMsg("  " .. msg);
				count=0;
				msg="Bank:";
				for item in rpgoCPstate["Bank"] do
					msg=msg .. " Bag" .. item .. ":".. rpgoCPstate["Bank"][item]["inv"].."/"..rpgoCPstate["Bank"][item]["slot"];
					count=count+1;
				end
				if(count==0) then
					msg=msg..rpgo_ColorizeMsg(rpgoColorRed," not scanned")..".   to scan: open your bank";
				end
			rpgo_VerboseMsg("  " .. msg);
			if((rpgoCPclass=="HUNTER" and UnitLevel("player")>9) or rpgoCPclass=="WARLOCK") then
				count=0;
				msg="Pets: ";
				for item in rpgoCPstate["Pets"] do
					msg=msg..item.." ";
					if(rpgoCPstate["PetSpell"][item]) then
						msg=msg.."(spells:"..rpgoCPstate["PetSpell"][item]..") ";
					end
					count=count+1;
				end
				if(count==0) then
					msg=msg..rpgo_ColorizeMsg(rpgoColorRed," not scanned");
				end
				rpgo_VerboseMsg("  " .. msg);
			end
			if(rpgoCPclass=="HUNTER" and UnitLevel("player")>9) then
				count=0;
				msg="Stable: ";
				for item in rpgoCPstate["Stable"] do
					msg=msg..rpgoCPstate["Stable"][item].." ";
					count=count+1;
				end
				if(count==0) then
					msg=msg..rpgo_ColorizeMsg(rpgoColorRed," not scanned")..".   to scan: open the stable";
				end
				rpgo_VerboseMsg("  " .. msg);
			end
		else
			rpgo_VerboseMsg(rpgo_ColorizeTitle(rpgoCP_PROVIDER,rpgoCP_ABBR)..": "..rpgo_ColorizeMsg(rpgoColorRed,"no character scanned"));
		end
	else
		rpgoCP_TogglePref("enabled");
	end
end

--[[//////////////////////////////////////////////
--	InitProfile
--	////////////////////////////////////////////]]
function rpgoCP_InitProfile()
	if ( not myProfile ) then
		myProfile={};
	end
	if ( not myProfile[rpgoCPserver] ) then
		myProfile[rpgoCPserver]={};
	end
	if ( not myProfile[rpgoCPserver][rpgoCPplayer] ) then
		myProfile[rpgoCPserver][rpgoCPplayer]={};
	end
end

--[[//////////////////////////////////////////////
--	UpdateProfile
--	////////////////////////////////////////////]]
function rpgoCP_UpdateProfile()
	rpgoCP_GetGuild(force);
	rpgoCP_GetBuffs(myProfile[rpgoCPserver][rpgoCPplayer]);
	rpgoCP_GetEquipment();
	rpgoCP_GetInventory();
	rpgoCP_GetTalents();
	rpgoCP_GetSkills();
	rpgoCP_GetReputation();
	rpgoCP_GetQuests();
	rpgoCP_GetHonor();
	rpgoCP_UpdateZone();
	rpgoCP_ScanPetInfo();
	rpgoCP_UpdatePlayed();
	rpgoCP_UpdateDate();
end

--[[//////////////////////////////////////////////
--	ForceExport
--	////////////////////////////////////////////]]
function rpgoCP_ForceExport()
	local tmpState=rpgoCPstate;
	rpgoCP_InitState(1);
	rpgoCPstate["Bank"]=tmpState["Bank"];
	rpgoCPstate["Professions"]=tmpState["Professions"];
	rpgoCPstate["SpellBook"]=tmpState["SpellBook"];
	rpgoCPstate["Stable"]=tmpState["Stable"];
	rpgoCPstate["Pets"]=tmpState["Pets"];
	rpgoCPstate["PetSpell"]=tmpState["PetSpell"];
	rpgoCPstate["Mail"]=tmpState["Mail"];
	rpgoCP_InitProfile();
	rpgoCP_LoadProfile();
	rpgoCP_UpdateProfile();
	rpgoCP_ScanPetInfo();
	rpgoCP_Show();
end

--[[//////////////////////////////////////////////
--	Purge
--	////////////////////////////////////////////]]
function rpgoCP_Purge(arg)
	if(arg) then
		if(arg=="char" and myProfile and myProfile[rpgoCPserver]) then
			myProfile[rpgoCPserver][rpgoCPplayer]=nil;
		elseif(arg=="server" and myProfile) then
			myProfile[rpgoCPserver]=nil;
		elseif(arg=="all") then
			myProfile=nil;
		end
		rpgoCP_InitState(1);
		rpgo_VerboseMsg(rpgo_ColorizeTitle(rpgoCP_PROVIDER,rpgoCP_ABBR)..": "..arg.." info purged");
	else
		rpgo_VerboseMsg(rpgo_ColorizeTitle(rpgoCP_PROVIDER,rpgoCP_ABBR)..": "..arg.." was not purged");
	end

end

--[[//////////////////////////////////////////////
--	LoadProfile
--	////////////////////////////////////////////]]
function rpgoCP_LoadProfile()
	local structChar=myProfile[rpgoCPserver][rpgoCPplayer];
	structChar["ProfilerVersion"]=rpgoCP_PROFILEDB;
	structChar["CPversion"]=rpgoCP_VERSION;
	structChar["CPprovider"]=rpgoCP_PROVIDER;
	structChar["DBversion"]=rpgoCP_PROFILEDB;

	structChar["Name"]=rpgoCPplayer;
	structChar["Server"]=rpgoCPserver;
	structChar["Locale"]=GetLocale();
	structChar["Race"]=UnitRace("player");
	structChar["Class"]=UnitClass("player");
	structChar["Sex"]=rpgo_UnitSexString("player");
	_,structChar["Faction"]=UnitFactionGroup("player");
	structChar["Hearth"]=GetBindLocation();
	structChar["Zone"]=GetZoneText();
	structChar["SubZone"]=GetSubZoneText();
	structChar["TalentPoints"]=UnitCharacterPoints("player");
	structChar["TimePlayed"]=timePlayed;
	structChar["TimeLevelPlayed"]=timeLevelPlayed;
	rpgoCP_GetGuild();
	rpgoCP_GetEquipment();
	rpgoCP_UpdateZone();
	rpgoCP_UpdateDate();
	rpgoCPstate["_loaded"]=1;
end

--[[//////////////////////////////////////////////
--	rpgoCP Extract functions
--	////////////////////////////////////////////]]
function rpgoCP_GetGuild(force)
	local isGuildMember=IsInGuild();
	if(not isGuildMember) then
		rpgoCPstate["Guild"]=0;
		myProfile[rpgoCPserver][rpgoCPplayer]["Guild"]=nil;
	else
		local numGuildMembers=GetNumGuildMembers();
		if(force or not rpgoCPstate["Guild"] or rpgoCPstate["GuildNum"]~=numGuildMembers) then
			myProfile[rpgoCPserver][rpgoCPplayer]["Guild"]={} ;
			local structGuild=myProfile[rpgoCPserver][rpgoCPplayer]["Guild"];
			local guildName,guildRankName,guildRankIndex=GetGuildInfo("player");
			if(guildName) then
				structGuild["Name"]=guildName;
				structGuild["Title"]=guildRankName;
				structGuild["Rank"]=guildRankIndex;
				rpgoCPstate["Guild"]=1;
				rpgoCPstate["GuildNum"]=numGuildMembers;
				--toRemove
				structGuild["GuildName"]=structGuild["Name"];
			end
		end
	end
end

function rpgoCP_GetSkills()
	if(rpgoCPpref["scan"]["skills"]) then
		local count=GetNumSkillLines();
		if(rpgoCPstate["Skills"]~=count) then
			myProfile[rpgoCPserver][rpgoCPplayer]["Skills"]={};
			local structSkill=myProfile[rpgoCPserver][rpgoCPplayer]["Skills"];
			local skillheader="";
			local order=1;
			rpgoCPstate["Skills"]=0;
			for i=1,GetNumSkillLines(),1 do
				local skillName,isHeader,isExpanded,skillRank,numTempPoints,skillModifier,skillMaxRank,isAbandonable,stepCost,rankCost,minLevel,skillCostType=GetSkillLineInfo(i);
				if(isHeader==1) then
					skillheader=skillName;
					structSkill[skillheader]={};
					structSkill[skillheader]["Order"]=order;
					order=order+1;
				else
					structSkill[skillheader][skillName]=skillRank..":"..skillMaxRank;
					if(skillMaxRank~=1) then
						rpgoCPstate["_skills"][skillName]=skillRank;
					end
				end
				rpgoCPstate["Skills"]=rpgoCPstate["Skills"]+1;
			end
		end
	elseif(myProfile[rpgoCPserver][rpgoCPplayer]) then
		myProfile[rpgoCPserver][rpgoCPplayer]["Skills"]=nil;
	end
end

function rpgoCP_GetReputation()
	if(rpgoCPpref["scan"]["reputation"]) then
		local numFactions=GetNumFactions();
		if(rpgoCPstate["Reputation"]~=numFactions) then
			local thisHeader,name,description,standingID,barMin,barMax,barValue,atWar,canToggle,isHeader,isCollapsed;
			rpgoCPstate["Reputation"]=0;
			myProfile[rpgoCPserver][rpgoCPplayer]["Reputation"]={};
			local structRep=myProfile[rpgoCPserver][rpgoCPplayer]["Reputation"];
			structRep["Count"]=numFactions;
			thisHeader=NONE;
			for index=1,numFactions do
				name,description,standingID,barMin,barMax,barValue,atWar,canToggle,isHeader,isCollapsed=GetFactionInfo(index);
				if(not atWar) then atWar=0; end
				if(isHeader) then
					thisHeader=name;
					structRep[thisHeader]={};
				elseif(standingID) then
					structRep[thisHeader][name]={};
					structRep[thisHeader][name]["Standing"]=getglobal("FACTION_STANDING_LABEL"..standingID);
					structRep[thisHeader][name]["AtWar"]=atWar;
					structRep[thisHeader][name]["Value"]=barValue-barMin.."/"..barMax-barMin;
				end
				rpgoCPstate["Reputation"]=rpgoCPstate["Reputation"]+1;
			end
		end
	elseif(myProfile[rpgoCPserver][rpgoCPplayer]) then
		myProfile[rpgoCPserver][rpgoCPplayer]["Reputation"]=nil;
	end
end

function rpgoCP_GetHonor()
	if(rpgoCPpref["scan"]["honor"]) then
		local lifetimeHK,lifetimeDK,lifetimeHighestRank=GetPVPLifetimeStats();
		if(rpgoCPstate["Honor"]~=lifetimeHK) then
			local hk,dk,contrib,rank;
			local currRankName,currRankNumber,currRankDesc,currRankIcon,currRankProgress;
			local lifetimeRankName,lifetimeRankNumber=GetPVPRankInfo(lifetimeHighestRank);
			if ( not lifetimeRankName ) then
				lifetimeRankName=NONE; end
			local currRankName,currRankNumber=GetPVPRankInfo(UnitPVPRank("player"));
			if ( not currRankName ) then
				currRankName=NONE; end
			currRankIcon="";
			if ( currRankNumber > 0 ) then
				currRankIcon=format("%s%02d","Interface\\PvPRankBadges\\PvPRank",currRankNumber);
			end
			currRankDesc="("..RANK.." "..currRankNumber..")";
			currRankProgress=format("%02.02f",GetPVPRankProgress()*100);

			myProfile[rpgoCPserver][rpgoCPplayer]["Honor"]={};
			local structHonor=myProfile[rpgoCPserver][rpgoCPplayer]["Honor"];
			structHonor["Current"]=rpgo_Arg2Tab("Rank","Icon","Description","Progress",currRankName,currRankIcon,currRankDesc,currRankProgress);
			structHonor["Lifetime"]=rpgo_Arg2Tab("Rank","Name","HK","DK",lifetimeHighestRank,lifetimeRankName,lifetimeHK,lifetimeDK);
			structHonor["LastWeek"]=rpgo_Arg2Tab("HK","DK","Contribution","Rank",GetPVPLastWeekStats());
			structHonor["ThisWeek"]=rpgo_Arg2Tab("HK","Contribution",GetPVPThisWeekStats());
			structHonor["Yesterday"]=rpgo_Arg2Tab("HK","DK","Contribution",GetPVPYesterdayStats());
			structHonor["Session"]=rpgo_Arg2Tab("HK","DK",GetPVPSessionStats());

			--toRemove
			if(rpgoCPpref["honorold"]) then
				structHonor["RankName"]=currRankName;
				structHonor["RankInfo"]=currRankDesc;
				structHonor["RankIcon"]=currRankIcon;

				structHonor["LifetimeHighestRank"]=lifetimeHighestRank;
				structHonor["LifetimeRankName"]=lifetimeRankName;
				structHonor["LifetimeHK"]=lifetimeHK;
				structHonor["LifetimeDK"]=lifetimeDK;

				hk,dk,contrib,rank=GetPVPLastWeekStats();
				structHonor["LastWeekHK"]=hk;
				structHonor["LastWeekDK"]=dk;
				structHonor["LastWeekContribution"]=contrib;
				structHonor["LastWeekRank"]=rank;

				hk,contrib=GetPVPThisWeekStats();

				hk,dk,contrib=GetPVPYesterdayStats();
				structHonor["YesterdayHK"]=hk;
				structHonor["YesterdayDK"]=dk;
				structHonor["YesterdayContribution"]=contrib;

				hk,dk=GetPVPSessionStats();
				structHonor["SessionHK"]=hk;
				structHonor["SessionDK"]=dk;
			end
			rpgoCPstate["Honor"]=lifetimeHK;
		end
	elseif(myProfile[rpgoCPserver][rpgoCPplayer]) then
		myProfile[rpgoCPserver][rpgoCPplayer]["Honor"]=nil;
	end
end

function rpgoCP_GetTalents()
	if(rpgoCPpref["scan"]["talents"] and UnitLevel("player") > 9 ) then
		local numTabs=GetNumTalentTabs();
		if(rpgoCPstate["Talents"]~=numTabs) then
			local numTalents,tabIndex,talentIndex
			local tabName,texture,points,fileName;
			local nameTalent,iconTexture,iconX,iconY,currentRank,maxRank;
			myProfile[rpgoCPserver][rpgoCPplayer]["Talents"]={};
			local structTalent=myProfile[rpgoCPserver][rpgoCPplayer]["Talents"];
			rpgoCPstate["Talents"]=0;
			for tabIndex=1,numTabs do
				numTalents=GetNumTalents(tabIndex);
				tabName,texture,points,fileName=GetTalentTabInfo(tabIndex);
				structTalent[tabName]={};
				structTalent[tabName]["PointsSpent"]=points;
				structTalent[tabName]["Background"]="Interface\\TalentFrame\\" .. fileName;
				structTalent[tabName]["Order"]=tabIndex;
				for talentIndex=1,numTalents do
					nameTalent,iconTexture,iconX,iconY,currentRank,maxRank=GetTalentInfo(tabIndex,talentIndex);
					if(currentRank > 0 or rpgoCPpref["talentsfull"]) then
						structTalent[tabName][nameTalent]={ };
						structTalent[tabName][nameTalent]["Rank"]=currentRank..":"..maxRank;
						structTalent[tabName][nameTalent]["Location"]=iconX..":"..iconY;
						structTalent[tabName][nameTalent]["Texture"]=iconTexture;
					end
					if(rpgoCPpref["talentsfull"]) then
						if(not structTalent[tabName][nameTalent]) then
							structTalent[tabName][nameTalent]={};
						end
						rpgoCPtooltip:SetTalent(tabIndex,talentIndex)
						structTalent[tabName][nameTalent]["Tooltip"]=rpgo_TooltipScan();
					end
				end
				rpgoCPstate["Talents"]=rpgoCPstate["Talents"]+1;
			end
		end
	elseif(myProfile[rpgoCPserver][rpgoCPplayer]) then
		myProfile[rpgoCPserver][rpgoCPplayer]["Talents"]=nil;
	end
end

function rpgoCP_GetQuests(force)
	if(rpgoCPpref["scan"]["quests"]) then
		local numEntries,numQuests=GetNumQuestLogEntries();
		if(force or rpgoCPstate["QuestsLog"]~=numEntries) then
			local header=UNKNOWN;
			myProfile[rpgoCPserver][rpgoCPplayer]["Quests"]={};
			local structQuest=myProfile[rpgoCPserver][rpgoCPplayer]["Quests"];
			local slot,index,num,j; slot=1;
			rpgoCPstate["Quests"]=0;
			for index=1,numEntries,1 do
				local questTitle,level,questTag,isHeader,isCollapsed,isComplete=GetQuestLogTitle(index);
				if(isHeader) then
					header=questTitle;
					structQuest[header]={}
				elseif(questTitle) then
					structQuest[header][slot]={}
					structQuest[header][slot]["Title"]=questTitle;
					structQuest[header][slot]["Level"]=level;
					structQuest[header][slot]["Complete"]=isComplete;
					if(questTag) then
						structQuest[header][slot]["Tag"]=questTag;
					end
					SelectQuestLogEntry(index);
					if(rpgoCPpref["questsfull"]) then
						structQuest[header][slot]["Description"],structQuest[header][slot]["Objective"]=GetQuestLogQuestText(index);
					elseif(structQuest[header][slot]["Description"]) then
						structQuest[header][slot]["Description"]=nil;
						structQuest[header][slot]["Objective"]=nil;
					end
					num=GetNumQuestLeaderBoards(index);
					if(num and num > 0) then
						structQuest[header][slot]["Tasks"]={};
						for j=1,num,1 do
							structQuest[header][slot]["Tasks"][j]=rpgo_Arg2Tab("Note","Type","Done",GetQuestLogLeaderBoard(j,index));
						end
					end
					num=GetQuestLogRewardMoney(index);
					if(num and num~=0) then
						structQuest[header][slot]["RewardMoney"]=num;
					end
					num=GetNumQuestLogRewards(index);
					if(num and num > 0) then
						structQuest[header][slot]["Rewards"]={};
						for j=1,num,1 do
							_,_,numItems,_,_=GetQuestLogRewardInfo(j);
							table.insert(structQuest[header][slot]["Rewards"],rpgoCP_ScanItemInfo(GetQuestLogItemLink("reward",j),nil,numItems));
						end
					end
					num=GetNumQuestLogChoices(index);
					if(num and num > 0) then
						structQuest[header][slot]["Choice"]={};
						for j=1,num,1 do
							_,_,numItems,_,_=GetQuestLogChoiceInfo(j);
							table.insert(structQuest[header][slot]["Choice"],rpgoCP_ScanItemInfo(GetQuestLogItemLink("choice",j),nil,numItems));
						end
					end



					slot=slot+1;
					rpgoCPstate["Quests"]=rpgoCPstate["Quests"]+1;
				end
				rpgoCPstate["QuestsLog"]=rpgoCPstate["QuestsLog"]+1;
			end
		end
	elseif ( myProfile[rpgoCPserver][rpgoCPplayer] ) then
		myProfile[rpgoCPserver][rpgoCPplayer]["Quests"]=nil;
	end
end

function rpgoCP_GetStats(structStats,unit)
	if(not unit) then unit="player"; end
	structStats["Level"]=UnitLevel(unit);
	structStats["Health"]=UnitHealthMax(unit);
	structStats["Mana"]=UnitManaMax(unit);
	structStats["Power"]=UnitPower[UnitPowerType(unit)];
	structStats["Stats"]={};
	for i=1,table.getn(UnitStatName),1 do
		local stat,effectiveStat,posBuff,negBuff=UnitStat(unit,i);
		structStats["Stats"][UnitStatName[i]]=(stat - posBuff - negBuff)..":"..effectiveStat..":"..posBuff..":"..negBuff;
	end
	local baseArm,effectiveArmor,armor,positiveArm,negativeArm=UnitArmor(unit);
	structStats["Armor"]=baseArm..":"..effectiveArmor..":"..positiveArm;
	structStats["Stats"]["Armor"]=baseArm..":"..effectiveArmor..":"..positiveArm..":"..negativeArm;
	local base,modifier = UnitDefense(unit);
	structStats["Defense"]=base;
	structStats["Stats"]["Defense"]=base..":"..base+modifier..":"..modifier..":0";
	structStats["Resists"]={};
	for i=1,table.getn(UnitResistName),1 do
		local base,resistance,positive,negative=UnitResistance(unit,i);
		structStats["Resists"][UnitResistName[i]]=base..":"..resistance..":"..positive..":"..negative;
	end
	if(unit=="player") then
		structStats["Money"]=rpgo_Arg2Tab("Gold","Silver","Copper",rpgo_GetMoney());
		structStats["TalentPoints"]=UnitCharacterPoints("player");
		structStats["Experience"]=UnitXP("player")..":"..UnitXPMax("player");
		local XPrest=GetXPExhaustion();
		if(not XPrest) then XPrest=0; end
		structStats["XP"]=structStats["Experience"]..":"..XPrest;
		structStats["DodgePercent"]=format("%02.02f",GetDodgeChance());
		structStats["BlockPercent"]=format("%02.02f",GetBlockChance());
		if(not structStats["CritPercent"]) then
			structStats["CritPercent"]="0";
		end
		if(not structStats["ParryPercent"]) then
			structStats["ParryPercent"]="0";
		end
		local mitigation=(effectiveArmor)/((85 * structStats["Level"])+400);
			mitigation=100*(mitigation/(mitigation+1));
		structStats["MitigationPercent"]=format("%02.02f",mitigation);
		local spellIndex=1;
		local spellName,subSpellName=GetSpellName(spellIndex,BOOKTYPE_SPELL);
		local tmpStr=nil;
		local scanAttack=true;
		local scanParry=true;
		while spellName do
			if(spellName==ATTACK) then
				rpgoCPtooltip:SetSpell(spellIndex,BOOKTYPE_SPELL);
				if(rpgoCPtooltipTextLeft2:GetText()) then
					local ttText=rpgoCPtooltipTextLeft2:GetText();
					local startString,endString=string.find(ttText,'(%d+\.%d+)%% ');
					if(startString) then
						tmpStr=string.sub(ttText,startString,endString-2);
						structStats["CritPercent"]=tmpStr;
					end
				end
				rpgoCPtooltip:ClearLines();
				scanAttack=nil;
			elseif(spellName==PARRY) then
				structStats["ParryPercent"]=format("%02.02f",GetParryChance());
				scanParry=nil;
			end
			if(not scanAttack and not scanParry) then break; end
			spellIndex=spellIndex+1;
			spellName,subSpellName=GetSpellName(spellIndex,BOOKTYPE_SPELL);
		end
	end
end

function rpgoCP_CharacterDamageFrame(unit,prefix)
	if(not unit) then unit="player"; end
	if(not prefix) then prefix="Character"; end
	local damageFrame = getglobal(prefix.."DamageFrame");
	rpgoCPtooltip:ClearLines();
	rpgoCPtooltip:SetText(INVTYPE_WEAPONMAINHAND);
	rpgoCPtooltip:AddDoubleLine(ATTACK_SPEED_COLON, format("%.2f", damageFrame.attackSpeed));
	rpgoCPtooltip:AddDoubleLine(DAMAGE_COLON, damageFrame.damage);
	rpgoCPtooltip:AddDoubleLine(DAMAGE_PER_SECOND, format("%.1f", damageFrame.dps));
	-- Check for offhand weapon
	if ( damageFrame.offhandAttackSpeed ) then
		rpgoCPtooltip:AddLine(" ");
		rpgoCPtooltip:AddLine(INVTYPE_WEAPONOFFHAND);
		rpgoCPtooltip:AddDoubleLine(ATTACK_SPEED_COLON, format("%.2f", damageFrame.offhandAttackSpeed));
		rpgoCPtooltip:AddDoubleLine(DAMAGE_COLON, damageFrame.offhandDamage);
		rpgoCPtooltip:AddDoubleLine(DAMAGE_PER_SECOND, format("%.1f", damageFrame.offhandDps));
	end
end

function rpgoCP_CharacterRangedDamageFrame(unit,prefix)
	if(not unit) then unit="player"; end
	if(not prefix) then prefix="Character"; end
	local damageFrame = getglobal(prefix.."RangedDamageFrame");
	if (not damageFrame.damage) then return; end
	rpgoCPtooltip:ClearLines();
	rpgoCPtooltip:SetText(INVTYPE_RANGED);
	rpgoCPtooltip:AddDoubleLine(ATTACK_SPEED_COLON, format("%.2f", damageFrame.attackSpeed));
	rpgoCPtooltip:AddDoubleLine(DAMAGE_COLON, damageFrame.damage);
	rpgoCPtooltip:AddDoubleLine(DAMAGE_PER_SECOND, format("%.1f", damageFrame.dps));
end

function rpgoCP_GetAttackRating(structAttack,unit,prefix)
	if(not unit) then unit="player"; end
	if(not prefix) then prefix="Character"; end
	PaperDollFrame_SetDamage(unit,prefix);
	PaperDollFrame_SetAttackPower(unit,prefix);
	PaperDollFrame_SetAttackBothHands(unit,prefix);
	local damageFrame = getglobal(prefix.."DamageFrame");
	local damageText = getglobal(prefix.."DamageFrameStatText");
	local mainHandAttackBase,mainHandAttackMod = UnitAttackBothHands(unit);

	structAttack["Melee Attack"]={};
	structAttack["Melee Attack"]["AttackSpeed"]=format("%.2f", damageFrame.attackSpeed);
	structAttack["Melee Attack"]["AttackDPS"]=format("%.1f", damageFrame.dps);
	structAttack["Melee Attack"]["AttackRating"]=mainHandAttackBase+mainHandAttackMod;
	local tt=damageText:GetText();

	if(string.find(tt,'|c%x%x%x%x%x%x%x%x')) then
		structAttack["Melee Attack"]["DamageRange"]=string.gsub(tt,"^|c%x%x%x%x%x%x%x%x?(%d+)%s?-%s?(%d+)|r?$","%1:%2");
	else
		structAttack["Melee Attack"]["DamageRange"]=string.gsub(tt,"^(%d+)%s?-%s?(%d+)$","%1:%2");
	end
	tt=damageFrame.damage;
	if(string.find(tt,'|c%x%x%x%x%x%x%x%x')) then
		structAttack["Melee Attack"]["DamageRangeBase"]=string.gsub(tt,"^(%d+)%s?-%s?(%d+)|c%x%x%x%x%x%x%x%x x%d+%%|r?$","%1:%2");
	else
		structAttack["Melee Attack"]["DamageRangeBase"]=string.gsub(tt,"^(%d+)%s?-%s?(%d+)$","%1:%2");
	end
	rpgoCP_CharacterDamageFrame();
	local tt=rpgo_TooltipScan();
	if(rpgoCPpref.tooltipshtml) then
		tt=string.gsub(tt,"|c%x%x%x%x%x%x%x%x(.+)|r","%1");
	end
	structAttack["Melee Attack"]["DamageRangeTooltip"]=tt;
	if ( damageFrame.offhandAttackSpeed ) then
		structAttack["Melee Attack"]["AttackSpeed2"]=format("%.2f", damageFrame.offhandAttackSpeed);
		structAttack["Melee Attack"]["AttackDPS2"]=format("%.1f", damageFrame.offhandDps);
		tt=damageFrame.offhandDamage;
		if(string.find(tt,'|c%x%x%x%x%x%x%x%x')) then
			structAttack["Melee Attack"]["DamageRange2"]=string.gsub(tt,"^(%d+)%s?-%s?(%d+)|c%x%x%x%x%x%x%x%x x%d+%%|r","%1:%2");
		else
			structAttack["Melee Attack"]["DamageRange2"]=string.gsub(tt,"^(%d+)%s?-%s?(%d+)","%1:%2");
		end
	end
	local base,posBuff,negBuff = UnitAttackPower(unit);
	apDPS=max((base+posBuff+negBuff),0)/ATTACK_POWER_MAGIC_NUMBER;
	structAttack["Melee Attack"]["AttackPower"]=base+posBuff+negBuff;
	structAttack["Melee Attack"]["AttackPower2"]=base..":"..base+posBuff+negBuff..":"..posBuff..":"..negBuff;
	structAttack["Melee Attack"]["AttackPowerDPS"]=format("%.1f",apDPS);
	structAttack["Melee Attack"]["AttackPowerTooltip"]=format(MELEE_ATTACK_POWER_TOOLTIP,apDPS);

	if(unit=="player") then
		local rangedTexture = GetInventoryItemTexture("player",18);
		if ( not rangedTexture ) then
			structAttack["Ranged Attack"]=nil;
		else
			PaperDollFrame_SetRangedAttack(unit,prefix);
			PaperDollFrame_SetRangedDamage(unit,prefix);
			PaperDollFrame_SetRangedAttackPower(unit,prefix);
			local damageFrame = getglobal(prefix.."RangedDamageFrame");
			local damageText = getglobal(prefix.."RangedDamageFrameStatText");
			if(PaperDollFrame.noRanged) then
				structAttack["Ranged Attack"]=nil;
			else
				structAttack["Ranged Attack"]={};
				structAttack["Ranged Attack"]["AttackSpeed"]=format("%.2f", damageFrame.attackSpeed);
				structAttack["Ranged Attack"]["AttackDPS"]=format("%.1f", damageFrame.dps);
				structAttack["Ranged Attack"]["AttackRating"]=UnitRangedAttack(unit);
				tt=damageText:GetText();
				if(string.find(tt,'|c%x%x%x%x%x%x%x%x')) then
					structAttack["Ranged Attack"]["DamageRange"]=string.gsub(tt,"^(%d+)%s?-%s?(%d+)|c%x%x%x%x%x%x%x%x x%d+%%|r","%1:%2");
				else
					structAttack["Ranged Attack"]["DamageRange"]=string.gsub(tt,"^(%d+)%s?-%s?(%d+)","%1:%2");
				end
				tt=damageFrame.damage;
				if(string.find(tt,'|c%x%x%x%x%x%x%x%x')) then
					structAttack["Ranged Attack"]["DamageRangeBase"]=string.gsub(tt,"^(%d+)%s?-%s?(%d+)|c%x%x%x%x%x%x%x%x x%d+%%|r?$","%1:%2");
				else
					structAttack["Ranged Attack"]["DamageRangeBase"]=string.gsub(tt,"^(%d+)%s?-%s?(%d+)$","%1:%2");
				end
				rpgoCP_CharacterRangedDamageFrame();
				local tt=rpgo_TooltipScan();
				if(rpgoCPpref.tooltipshtml) then
					tt=string.gsub(tt,"|c%x%x%x%x%x%x%x%x(.+)|r","%1");
				end
				structAttack["Ranged Attack"]["DamageRangeTooltip"]=tt;
				if( HasWandEquipped() ) then
					structAttack["Ranged Attack"]["AttackPower"]=nil;
					structAttack["Ranged Attack"]["AttackPowerDPS"]=nil;
					structAttack["Ranged Attack"]["AttackPowerTooltip"]=nil;
				else
					local base,pos,neg=UnitRangedAttackPower(unit);
					apDPS=base/ATTACK_POWER_MAGIC_NUMBER;
					structAttack["Ranged Attack"]["AttackPower"]=base+pos+neg;
					structAttack["Ranged Attack"]["AttackPowerDPS"]=format("%.1f",apDPS);
					structAttack["Ranged Attack"]["AttackPowerTooltip"]=format(RANGED_ATTACK_POWER_TOOLTIP,apDPS);
				end
			end
		end
	end
end

function rpgoCP_GetBuffs(structBuffs,unit)
	if(not unit) then unit="player"; end
	local index=1;
	local buffTexture;
	if(UnitBuff(unit,index)) then
		structBuffs["Buffs"]={};
		while(UnitBuff(unit,index)) do
			buffTexture=UnitBuff(unit,index);
			rpgoCPtooltip:SetUnitBuff(unit,index);
			structBuffs["Buffs"][index]={};
			structBuffs["Buffs"][index]["Name"]=rpgo_GetItemInfoTT();
			structBuffs["Buffs"][index]["Tooltip"]=rpgo_TooltipScan();
			structBuffs["Buffs"][index]["Texture"]=buffTexture;
			index=index+1
		end
	else
		structBuffs["Buffs"]=nil;
	end
	index=1;
	if(UnitDebuff(unit,index)) then
		structBuffs["Debuffs"]={};
		while(UnitDebuff(unit,index)) do
			buffTexture=UnitDebuff(unit,index);
			rpgoCPtooltip:SetUnitDebuff(unit,index);
			structBuffs["Debuffs"][index]={};
			structBuffs["Debuffs"][index]["Name"]=rpgo_GetItemInfoTT();
			structBuffs["Debuffs"][index]["Tooltip"]=rpgo_TooltipScan();
			structBuffs["Debuffs"][index]["Texture"]=buffTexture;
			index=index + 1
		end
	else
		structBuffs["Debuffs"]=nil;
	end
end

function rpgoCP_GetEquipment(force)
	if(rpgoCPpref["scan"]["equipment"]) then
		if( force or rpgoCPstate["Equipment"]==0 or rpgoCPstate["EquipmentKey"]~=rpgoCP_GetEQKey() ) then
			local id,curItemLink,curItemTexture,curItemName,curItemColor,index,slot;
			rpgoCPstate["Equipment"]=0;
			rpgoCPstate["EquipmentKey"]=0;
			myProfile[rpgoCPserver][rpgoCPplayer]["Equipment"]={};
			local structEquip=myProfile[rpgoCPserver][rpgoCPplayer]["Equipment"];
			for index,slot in UnitSlots do
				curItemTexture=GetInventoryItemTexture("player",index);
				if(index==0) then
					--AmmoSlot magik
					if(curItemTexture) then
						rpgoCPtooltip:SetInventoryItem("player",index);
						curItemName,curItemColor=rpgo_GetItemInfoTT();
						if(curItemName) then
							curItemLink="|c"..curItemColor.."|Hitem:0:0:0:0|h["..curItemName.."]|h|r";
							id=1;
						end
					end
				else
					curItemLink=GetInventoryItemLink("player",index);
					_,id,_=rpgo_GetItemID(curItemLink);
				end
				if(curItemLink) then
					rpgoCPtooltip:SetInventoryItem("player",index);
					structEquip[slot]=rpgoCP_ScanItemInfo(curItemLink,curItemTexture,nil,rpgo_TooltipScan());
					rpgoCPstate["Equipment"]=rpgoCPstate["Equipment"]+1;
					rpgoCPstate["EquipmentKey"]=rpgoCPstate["EquipmentKey"]+id;
					curItemLink=nil;
				end
			end
		end
	elseif(myProfile[rpgoCPserver][rpgoCPplayer]) then
		structEquip=nil;
	end
	rpgoCP_GetStats(myProfile[rpgoCPserver][rpgoCPplayer]);
	rpgoCP_GetAttackRating(myProfile[rpgoCPserver][rpgoCPplayer]);
end

function rpgoCP_GetMail()
	if(rpgoCPpref["scan"]["mail"]) then
		numMessages=GetInboxNumItems();
		if( (not rpgoCPstate["Mail"]) or (rpgoCPstate["Mail"]~=numMessages and numMessages~=0) ) then
			rpgoCPstate["Mail"]=0;
			myProfile[rpgoCPserver][rpgoCPplayer]["MailBox"]={};
			local structMail=myProfile[rpgoCPserver][rpgoCPplayer]["MailBox"];
			for index=1,numMessages do
				local _,_,mailSender,mailSubject,mailCoin,_,mailDays=GetInboxHeaderInfo(index);
				local itemName,itemIcon,itemQty,_,_=GetInboxItem(index);
				if(not mailSender) then mailSender=UNKNOWN; end
				structMail[index]={};
				structMail[index]["Sender"]=mailSender;
				structMail[index]["Subject"]=mailSubject;
				structMail[index]["Coin"]=mailCoin;
				structMail[index]["CoinIcon"]=GetCoinIcon(mailCoin);
				structMail[index]["Days"]=mailDays;
				structMail[index]["Item"]={};
				structMail[index]["Item"]["Name"]=itemName;
				structMail[index]["Item"]["Icon"]=itemIcon;
				structMail[index]["Item"]["Quantity"]=itemQty;
				rpgoCPtooltip:SetInboxItem(index);
				structMail[index]["Item"]["Tooltip"]=rpgo_TooltipScan();
				rpgoCPstate["Mail"]=rpgoCPstate["Mail"]+1;
			end
			myProfile[rpgoCPserver][rpgoCPplayer]["MailDateUTC"]=date("!%m/%d/%y %H:%M:%S");
		end
	elseif(myProfile[rpgoCPserver][rpgoCPplayer]) then
		myProfile[rpgoCPserver][rpgoCPplayer]["MailBox"]=nil;
		myProfile[rpgoCPserver][rpgoCPplayer]["MailDateUTC"]=nil;
	end
end

function rpgoCP_GetInventory()
	local bagNum=0;
	if(rpgoCPpref["scan"]["inventory"]) then
		if(not bagContainerText) then bagContainerText=""; end
		if(not myProfile[rpgoCPserver][rpgoCPplayer]["Inventory"]) then
			myProfile[rpgoCPserver][rpgoCPplayer]["Inventory"]={};
			rpgoCPstate["Inventory"]={};
		end
		local structInventory=myProfile[rpgoCPserver][rpgoCPplayer]["Inventory"];
		for bag=0,4,1 do
			bagName="Bag" .. bag;
			local bagname,link,texture,color,item,itemname;
			if(bag==0) then
				bagname=GetBagName(bag);
				baglink="|cffffffff|Hitem:0:0:0:0|h["..bagname.."]|h|r";
				texture="Interface\\Buttons\\Button-Backpack-Up";
				rpgoCPtooltip:SetText(bagname);
				rpgoCPtooltip:AddLine(format(CONTAINER_SLOTS,rpgoCP_GetContainerNumSlots(bag),bagContainerText));
			else
				baglink=GetInventoryItemLink("player",(ContainerIDToInventoryID(bag)));
				texture=GetInventoryItemTexture("player",(ContainerIDToInventoryID(bag)));
				rpgoCPtooltip:SetInventoryItem("player",(ContainerIDToInventoryID(bag)))
			end
			if(baglink) then
				local bagContentsTemp=nil;
				if(structInventory[bagName] and structInventory[bagName]["Contents"]) then
					bagContentsTemp=structInventory[bagName]["Contents"];
				end
				structInventory[bagName]=rpgoCP_ScanBagInfo(bag,baglink,texture,rpgo_TooltipScan());
				if(not rpgoCPstate["Inventory"][bag] or not rpgoCPstate["Bag"][bag]) then
					structInventory[bagName]["Contents"]=rpgoCP_GetContainerItems("Inventory",bag,bag);
					rpgoCPstate["Bag"][bag]=1;
				else
					structInventory[bagName]["Contents"]=bagContentsTemp;
					bagContentsTemp=nil;
				end
			else
				structInventory[bagName]=nil;
			end
			bagNum=bag;
		end
		if(HasKey and HasKey()) then
			local bag,bagname,link,texture,color,item,itemname;
			bag=bagNum+1;
			bagName="Bag" .. bag;
			texture="Interface\\Buttons\\UI-Button-KeyRing";
			baglink="|cffffffff|Hitem:0:0:0:0|h["..KEYRING.."]|h|r";
			rpgoCPtooltip:SetText(KEYRING);
			rpgoCPtooltip:AddLine(format(CONTAINER_SLOTS,rpgoCP_GetContainerNumSlots(KEYRING_CONTAINER),bagContainerText));
			local bagContentsTemp=nil;
			if(structInventory[bagName] and structInventory[bagName]["Contents"]) then
				bagContentsTemp=structInventory[bagName]["Contents"];
			end
			structInventory[bagName]=rpgoCP_ScanBagInfo(KEYRING_CONTAINER,baglink,texture,rpgo_TooltipScan());
			structInventory[bagName]["Name"]=KEYRING;
			if(not rpgoCPstate["Inventory"][bag] or not rpgoCPstate["Bag"][bag]) then
				structInventory[bagName]["Contents"]=rpgoCP_GetContainerItems("Inventory",KEYRING_CONTAINER,bag);
				rpgoCPstate["Bag"][bag]=1;
			else
				structInventory[bagName]["Contents"]=bagContentsTemp;
				bagContentsTemp=nil;
			end
			rpgoCPstate["Bag"][bag]=1;
		end
	elseif(myProfile[rpgoCPserver][rpgoCPplayer]) then
		myProfile[rpgoCPserver][rpgoCPplayer]["Inventory"]=nil;
		rpgoCPstate["Inventory"]={};
	end
end

function rpgoCP_GetBank()
	if(rpgoCPpref["scan"]["bank"]) then
		if(rpgoCPstate["BankTime"] < GetTime()-timeWait) then
			if(not myProfile[rpgoCPserver][rpgoCPplayer]["Bank"]) then
				myProfile[rpgoCPserver][rpgoCPplayer]["Bank"]={};
				rpgoCPstate["Bank"]={};
			end
			local structBank=myProfile[rpgoCPserver][rpgoCPplayer]["Bank"];
			local bag,bagnum;
			bag=BANK_CONTAINER;
			bagnum=0;
			local bagContentsTemp=nil;
			if(structBank["Contents"]) then
				bagContentsTemp=structBank["Contents"];
			end
			local bankKey=rpgoCP_GetBagKey(BANK_CONTAINER);
			if(not rpgoCPstate["Bank"][bagnum] or not rpgoCPstate["Bank"][bagnum]["key"] or rpgoCPstate["Bank"][bagnum]["key"]~=bankKey) then
				structBank["Contents"]=rpgoCP_GetContainerItems("Bank",BANK_CONTAINER,bagnum);
				rpgoCPstate["Bank"][bagnum]["key"]=bankKey;
			else
				structBank["Contents"]=bagContentsTemp;
				bagContentsTemp=nil;
			end
			local bag,size,slot,link;
			for bagnum=1,GetNumBankSlots() do
				bag=bagnum+4;
				bagName="Bag" .. bagnum;
				baglink=GetInventoryItemLink("player",(ContainerIDToInventoryID(bag)));
				texture=GetInventoryItemTexture("player",(ContainerIDToInventoryID(bag)));
				if(baglink) then
					bagContentsTemp=nil;
					if(structBank[bagName] and structBank[bagName]["Contents"]) then
						bagContentsTemp=structBank[bagName]["Contents"];
					end
					rpgoCPtooltip:SetInventoryItem("player",(ContainerIDToInventoryID(bag)))
					structBank[bagName]=rpgoCP_ScanBagInfo(bag,baglink,texture,rpgo_TooltipScan());
					if(not rpgoCPstate["Bank"][bagnum] or not rpgoCPstate["Bag"][bag]) then
						structBank[bagName]["Contents"]=rpgoCP_GetContainerItems("Bank",bag,bagnum);
						rpgoCPstate["Bag"][bag]=1;
					else
						structBank[bagName]["Contents"]=bagContentsTemp;
						bagContentsTemp=nil;
					end
				else
					rpgoCPstate["Bank"][bagnum]=nil;
					structBank[bagName]=nil;
				end
			end
			rpgoCPstate["BankTime"]=GetTime();
		end
	elseif(myProfile[rpgoCPserver][rpgoCPplayer]) then
		myProfile[rpgoCPserver][rpgoCPplayer]["Bank"]=nil;
		rpgoCPstate["Bank"]={};
	end
end

function rpgoCP_GetContainerItems(container,bagID,bagnum)
	local bagContents={};
	local itemlink,texture;
	rpgoCPstate[container][bagnum]={};
	rpgoCPstate[container][bagnum]["slot"]=0;
	rpgoCPstate[container][bagnum]["inv"]=0;
	for slot=1,rpgoCP_GetContainerNumSlots(bagID) do
		itemlink=GetContainerItemLink(bagID,slot);
		texture,itemCount,locked,quality=GetContainerItemInfo(bagID,slot);
		if(itemlink) then
			if(bagID==BANK_CONTAINER) then
				rpgoCPtooltip:SetInventoryItem("player",BankButtonIDToInvSlotID(slot));
			else
				rpgoCPtooltip:SetBagItem(bagID,slot);
			end
			bagContents[slot]=rpgoCP_ScanItemInfo(itemlink,texture,itemCount,rpgo_TooltipScan());
			rpgoCPstate[container][bagnum]["inv"]=rpgoCPstate[container][bagnum]["inv"]+1;
		end
		rpgoCPstate[container][bagnum]["slot"]=rpgoCPstate[container][bagnum]["slot"]+1;
	end
	if(not rpgoCPstate["_bagevent"]) then
		this:RegisterEvent("BAG_UPDATE");
		rpgoCPstate["_bagevent"]=1;
	end
	--rpgoCP_debug("GetInventory: "..container.."|"..bagID.."|"..bagnum);
	return bagContents;
end

function rpgoCP_GetContainerNumSlots(bagID)
	if(bagID == KEYRING_CONTAINER) then
		return GetKeyRingSize();
	else
		return GetContainerNumSlots(bagID);
	end
end

function rpgoCP_GetTradeSkill()
	if(rpgoCPpref["scan"]["professions"]) then
		local reagentsUnknown=nil;
		local skillLineName,skillLineRank,skillLineMaxRank=GetTradeSkillLine();
		if(not skillLineName) then
			return;
		elseif ( (skillLineName=="") or (skillLineName==UNKNOWN) ) then
			return;
		end
		-- expand the tree so we can see all the recipes
		ExpandTradeSkillSubClass(0);
		if(not rpgoCPstate["Professions"][skillLineName]) then
			rpgoCPstate["Professions"][skillLineName]={};
		end
		if ( not myProfile[rpgoCPserver][rpgoCPplayer]["Professions"] ) then
			myProfile[rpgoCPserver][rpgoCPplayer]["Professions"]={};
		end
		local structProf=myProfile[rpgoCPserver][rpgoCPplayer]["Professions"];

		-- get the number of recipes and loop through each one
		local numTradeSkills=GetNumTradeSkills();
		local skillHeader=nil;
		if(numTradeSkills>0 and (not rpgoCPstate["Professions"][skillLineName] or numTradeSkills~=rpgoCPstate["Professions"][skillLineName]) ) then
			local TradeSkillTemp=nil;
			if(not structProf[skillLineName]) then
				structProf[skillLineName]={};
			elseif(structProf[skillLineName]) then
				TradeSkillTemp=structProf[skillLineName];
				structProf[skillLineName]={};
			end
			rpgoCPstate["Professions"][skillLineName]=0;
			for itemIndex=1,numTradeSkills,1 do
				local skillName,skillDifficulty,numAvailable,isExpanded=GetTradeSkillInfo(itemIndex);
				local cooldown,reagents;
				if(skillDifficulty=="header" and skillName~="" and isExpanded) then
					skillHeader=skillName;
					structProf[skillLineName][skillHeader]={};
					rpgoCPstate["Professions"][skillLineName]=rpgoCPstate["Professions"][skillLineName]+1;
				elseif(skillDifficulty=="header" and not isExpanded) then
					skillHeader=nil;
				elseif(skillHeader and skillName and skillName~="" ) then
					local skillIcon=GetTradeSkillIcon(itemIndex);
					if(not skillIcon) then skillIcon=""; end
					local Color,_,Link,_=rpgo_GetItemInfo(GetTradeSkillItemLink(itemIndex));
					structProf[skillLineName][skillHeader][skillName]={};
					structProf[skillLineName][skillHeader][skillName]["Texture"]=skillIcon;
					structProf[skillLineName][skillHeader][skillName]["Difficulty"]=TradeSkillCode[skillDifficulty];
					structProf[skillLineName][skillHeader][skillName]["Color"]=Color;
					structProf[skillLineName][skillHeader][skillName]["Item"]=Link;
					rpgoCPtooltip:SetTradeSkillItem(itemIndex);
					if(GetTradeSkillCooldown(itemIndex)) then
						structProf[skillLineName][skillHeader][skillName]["Cooldown"]=GetTradeSkillCooldown(itemIndex);
						structProf[skillLineName][skillHeader][skillName]["DateUTC"]=date("!%m/%d/%y %H:%M:%S");
						rpgoCPtooltip:AddLine(COOLDOWN_REMAINING.." "..SecondsToTime(structProf[skillLineName][skillHeader][skillName]["Cooldown"]));
					elseif(structProf[skillLineName][skillHeader][skillName]["Cooldown"]) then
						structProf[skillLineName][skillHeader][skillName]["Cooldown"]=nil;
					end
					structProf[skillLineName][skillHeader][skillName]["Tooltip"]=rpgo_TooltipScan();
					local numReagents=GetTradeSkillNumReagents(itemIndex);
					if(rpgoCPpref["reagenthtml"]) then
						reagents="";
					else
						reagents={};
					end
					for reagentIndex=1,numReagents,1 do
						local reagentName,reagentTexture,reagentCount,playerReagentCount=GetTradeSkillReagentInfo(itemIndex,reagentIndex);
						if(not reagentTexture) then reagentTexture=""; end
						if(not reagentName) then reagentName=UNKNOWN; reagentsUnknown=1; end
						if(rpgoCPpref["reagenthtml"]) then
							if(reagentIndex==numReagents) then
								reagents=reagents .. reagentName .. " x" .. reagentCount;
							else
								reagents=reagents .. reagentName .. " x" .. reagentCount .. "<br>";
							end
						else
							local _,itemID,_ = rpgo_GetItemID(GetTradeSkillReagentItemLink(itemIndex,reagentIndex));
							reagents[reagentIndex]={};
							reagents[reagentIndex]["Name"]=reagentName;
							reagents[reagentIndex]["Count"]=reagentCount;
							reagents[reagentIndex]["itemID"]=itemID;
						end
					end
					structProf[skillLineName][skillHeader][skillName]["Reagents"]=reagents;
					rpgoCPstate["Professions"][skillLineName]=rpgoCPstate["Professions"][skillLineName]+1;
				end
			end
			if(rpgoCPstate["Professions"][skillLineName]==0) then
				_skillError=1;
				structProf[skillLineName]=TradeSkillTemp;
				rpgo_VerboseMsg(rpgo_ColorizeTitle(rpgoCP_PROVIDER,rpgoCP_ABBR)..": "..skillLineName..rpgo_ColorizeMsg(rpgoColorRed," not scanned, rescanning or open again"));
				rpgoCPtrade:Show();
			elseif(reagentsUnknown) then
				_skillError=1
				structProf[skillLineName]=TradeSkillTemp;
				rpgoCPstate["Professions"][skillLineName]=0;
				rpgo_VerboseMsg(rpgo_ColorizeTitle(rpgoCP_PROVIDER,rpgoCP_ABBR)..": "..skillLineName..rpgo_ColorizeMsg(rpgoColorRed," reagents not scanned, rescanning or open again"));
				rpgoCPtrade:Show();
			else
				if(_skillError) then
					rpgo_VerboseMsg(rpgo_ColorizeTitle(rpgoCP_PROVIDER,rpgoCP_ABBR)..": "..skillLineName.." rescanned successfully");
					_skillError=nil;
				end
				rpgoCPtrade:Hide();
			end
			TradeSkillTemp=nil;
		end
		rpgoCP_TidyProfessions();
	elseif(myProfile[rpgoCPserver][rpgoCPplayer]) then
		myProfile[rpgoCPserver][rpgoCPplayer]["Professions"]=nil;
		rpgoCPstate["Professions"]={};
	end
end

function rpgoCP_GetCraft()
	if(rpgoCPpref["scan"]["professions"]) then
		local reagentsUnknown=nil;
		local skillLineName,skillLineRank,skillLineMaxRank=GetCraftDisplaySkillLine();
		if(not skillLineName) then
			return;
		elseif ( (skillLineName=="") or (skillLineName==UNKNOWN) ) then
			return;
		end
		-- get the number of recipes and loop through each one
		local numCrafts=GetNumCrafts();
		if ( not myProfile[rpgoCPserver][rpgoCPplayer]["Professions"] ) then
			myProfile[rpgoCPserver][rpgoCPplayer]["Professions"]={};
		end
		local structProf=myProfile[rpgoCPserver][rpgoCPplayer]["Professions"];
		local skillHeader=nil;
		if(numCrafts>0 and (not rpgoCPstate["Professions"][skillLineName] or numCrafts~=rpgoCPstate["Professions"][skillLineName]) ) then
			local TradeSkillTemp=nil;
			if(not structProf[skillLineName]) then
				structProf[skillLineName]={};
			elseif(structProf[skillLineName]) then
				TradeSkillTemp=structProf[skillLineName];
				structProf[skillLineName]={};
			end
			rpgoCPstate["Professions"][skillLineName]=0;
			skillHeader=skillLineName;
			for itemIndex=1,numCrafts,1 do
				local skillName,craftSubSpellName,skillDifficulty,numAvailable,isExpanded=GetCraftInfo(itemIndex);
				if( skillDifficulty=="header" and skillName~="" ) then
					skillHeader=skillName;
					structProf[skillLineName][skillHeader]={};
					rpgoCPstate["Professions"][skillLineName]=rpgoCPstate["Professions"][skillLineName]+1;
				elseif( skillHeader and skillName and skillName~="" ) then
					if(not structProf[skillLineName][skillHeader]) then
						structProf[skillLineName][skillHeader]={};
					end
					local skillIcon=GetCraftIcon(itemIndex);
					if(not skillIcon) then skillIcon=""; end
					local Color,_,Link,_=rpgo_GetItemInfo(GetTradeSkillItemLink(itemIndex));
					local numReagents=GetCraftNumReagents(itemIndex);
					local reagents="";
					structProf[skillLineName][skillHeader][skillName]={};
					structProf[skillLineName][skillHeader][skillName]["Texture"]=skillIcon;
					structProf[skillLineName][skillHeader][skillName]["Difficulty"]=TradeSkillCode[skillDifficulty];
					structProf[skillLineName][skillHeader][skillName]["Color"]=Color;
					structProf[skillLineName][skillHeader][skillName]["Item"]=Link;
					structProf[skillLineName][skillHeader][skillName]["Tooltip"]=GetCraftDescription(itemIndex);
					if(rpgoCPpref["reagenthtml"]) then
						reagents="";
					else
						reagents={};
					end
					for reagentIndex=1,numReagents,1 do
						local reagentName,reagentTexture,reagentCount,playerReagentCount=GetCraftReagentInfo(itemIndex,reagentIndex);
						if(not reagentTexture) then reagentTexture=""; end
						if(not reagentName) then reagentName=UNKNOWN; reagentsUnknown=1; end
						if(rpgoCPpref["reagenthtml"]) then
							if(reagentIndex==numReagents) then
								reagents=reagents .. reagentName .. " x" .. reagentCount;
							else
								reagents=reagents .. reagentName .. " x" .. reagentCount .. "<br>";
							end
						else
							local _,itemID,_ = rpgo_GetItemID(GetCraftReagentItemLink(itemIndex,reagentIndex));
							reagents[reagentIndex]={};
							reagents[reagentIndex]["Name"]=reagentName;
							reagents[reagentIndex]["Count"]=reagentCount;
							reagents[reagentIndex]["itemID"]=itemID;
						end
					end
					structProf[skillLineName][skillHeader][skillName]["Reagents"]=reagents;
					rpgoCPstate["Professions"][skillLineName]=rpgoCPstate["Professions"][skillLineName]+1;
				end
			end
			if(rpgoCPstate["Professions"][skillLineName]==0) then
				_skillError=1;
				structProf[skillLineName]=TradeSkillTemp;
				rpgo_VerboseMsg(rpgo_ColorizeTitle(rpgoCP_PROVIDER,rpgoCP_ABBR)..": "..skillLineName..rpgo_ColorizeMsg(rpgoColorRed," not scanned, rescanning or open again"));
				rpgoCPcraft:Show();
			elseif(reagentsUnknown) then
				_skillError=1;
				structProf[skillLineName]=TradeSkillTemp;
				rpgoCPstate["Professions"][skillLineName]=0;
				rpgo_VerboseMsg(rpgo_ColorizeTitle(rpgoCP_PROVIDER,rpgoCP_ABBR)..": "..skillLineName..rpgo_ColorizeMsg(rpgoColorRed," reagents not scanned, rescanning or open again"));
				rpgoCPcraft:Show();
			else
				if(_skillError) then
					rpgo_VerboseMsg(rpgo_ColorizeTitle(rpgoCP_PROVIDER,rpgoCP_ABBR)..": "..skillLineName.." rescanned successfully");
					_skillError=nil;
				end
				rpgoCPcraft:Hide();
			end
			TradeSkillTemp=nil;
		end
		rpgoCP_TidyProfessions();
	elseif(myProfile[rpgoCPserver][rpgoCPplayer]) then
		myProfile[rpgoCPserver][rpgoCPplayer]["Professions"]=nil;
		rpgoCPstate["Professions"]={};
	end
end

function rpgoCP_TidyProfessions()
	if(rpgoCPstate["_loaded"]) then
		for skillName,_ in myProfile[rpgoCPserver][rpgoCPplayer]["Professions"] do
			if(not rpgoCPstate["_skills"][skillName]) then
				myProfile[rpgoCPserver][rpgoCPplayer]["Professions"][skillName]=nil;
			end
		end
	end
end

function rpgoCP_GetSpellBook()
	if(rpgoCPpref["scan"]["spells"]) then
		if ( not myProfile[rpgoCPserver][rpgoCPplayer]["SpellBook"] ) then
			myProfile[rpgoCPserver][rpgoCPplayer]["SpellBook"]={};
		end
		local structSpell=myProfile[rpgoCPserver][rpgoCPplayer]["SpellBook"];
		for spelltab=1,GetNumSpellTabs(),1 do
			local spelltabname,spelltabtexture,offset,numSpells=GetSpellTabInfo(spelltab);
			if(not rpgoCPstate["SpellBook"][spelltabname] or rpgoCPstate["SpellBook"][spelltabname]~=numSpells) then
				if ( not structSpell[spelltabname] ) then
					structSpell[spelltabname]={};
				end
				structSpell[spelltabname]["Texture"]=spelltabtexture;
				if ( not structSpell[spelltabname]["Spells"] ) then
					structSpell[spelltabname]["Spells"]={};
				end
				rpgoCPstate["SpellBook"][spelltabname]=0;
				for spellId=offset + 1,numSpells + offset,1 do
					spellName,spellRank=GetSpellName( spellId,BOOKTYPE_SPELL );
					spellTexture=GetSpellTexture( spellId,spelltab );
					if ( not structSpell[spelltabname]["Spells"][spellName] ) then
						structSpell[spelltabname]["Spells"][spellName]={};
					end
					structSpell[spelltabname]["Spells"][spellName]["Rank"]=spellRank;
					structSpell[spelltabname]["Spells"][spellName]["Texture"]=spellTexture;
					rpgoCPtooltip:SetSpell(spellId,BOOKTYPE_SPELL);
					structSpell[spelltabname]["Spells"][spellName]["Tooltip"]=rpgo_TooltipScan();
					rpgoCPstate["SpellBook"][spelltabname]=rpgoCPstate["SpellBook"][spelltabname]+1;
				end
				structSpell[spelltabname]["Count"]=numSpells;
			end
		end
	elseif(myProfile[rpgoCPserver][rpgoCPplayer]) then
		myProfile[rpgoCPserver][rpgoCPplayer]["SpellBook"]=nil;
		rpgoCPstate["SpellBook"]={};
	end
end

function rpgoCP_ScanPetInit(name)
	if(not myProfile[rpgoCPserver][rpgoCPplayer]["Pets"]) then
		myProfile[rpgoCPserver][rpgoCPplayer]["Pets"]={};
	end
	if(not myProfile[rpgoCPserver][rpgoCPplayer]["Pets"][name]) then
		myProfile[rpgoCPserver][rpgoCPplayer]["Pets"][name]={};
	end
end

function rpgoCP_ScanPetStable()
	if(rpgoCPpref["scan"]["pet"] and (rpgoCPclass=="HUNTER" and UnitLevel("player")>9)) then
		local structPets;
		for petIndex=0,GetNumStableSlots(),1 do
			local petIcon,petName,petLevel,petType,petLoyalty=GetStablePetInfo(petIndex);
			if(petName) then
				rpgoCP_ScanPetInit(petName);
				structPets=myProfile[rpgoCPserver][rpgoCPplayer]["Pets"];
				structPets[petName]["Slot"]=petIndex;
				structPets[petName]["Icon"]=petIcon;
				structPets[petName]["Name"]=petName;
				structPets[petName]["Level"]=petLevel;
				structPets[petName]["Type"]=petType;
				structPets[petName]["Loyalty"]=petLoyalty;
			end
			rpgoCPstate["Stable"][petIndex]=petName;
		end
		rpgoCP_ScanPetInfo();
	elseif(myProfile[rpgoCPserver][rpgoCPplayer]) then
		myProfile[rpgoCPserver][rpgoCPplayer]["Pets"]=nil;
		rpgoCPstate["Pets"]={};
	end
end

function rpgoCP_ScanPetInfo()
	if(rpgoCPpref["scan"]["pet"]) then
		if(HasPetUI()) then
			petName=UnitName("pet");
			rpgoCP_ScanPetInit(petName);
			local structPet=myProfile[rpgoCPserver][rpgoCPplayer]["Pets"][petName];
			structPet["Name"]=petName;
			structPet["Type"]=UnitCreatureFamily("pet");
			structPet["TalentPoints"],structPet["TalentPointsUsed"]=GetPetTrainingPoints();
			local currXP,nextXP=GetPetExperience();
			structPet["Experience"]=currXP..":"..nextXP;

			rpgoCP_GetStats(structPet,"pet");
			rpgoCP_GetAttackRating(structPet,"pet");
			rpgoCP_GetBuffs(structPet,"pet");
			rpgoCP_GetPetSpellBook();
			rpgoCPstate["Pets"][petName]=1;
		end
	elseif(myProfile[rpgoCPserver][rpgoCPplayer]) then
		myProfile[rpgoCPserver][rpgoCPplayer]["Pets"]=nil;
		rpgoCPstate["Pets"]={};
	end
end

function rpgoCP_GetPetSpellBook()
	if(rpgoCPpref["scan"]["spells"]) then
		numSpells,_=HasPetSpells();
		petName=UnitName("pet");
		if(numSpells) then
			rpgoCP_ScanPetInit(petName);
			if (not myProfile[rpgoCPserver][rpgoCPplayer]["Pets"][petName]["SpellBook"]) then
				myProfile[rpgoCPserver][rpgoCPplayer]["Pets"][petName]["SpellBook"]={};
			end
			local structPetSpell=myProfile[rpgoCPserver][rpgoCPplayer]["Pets"][petName]["SpellBook"];
			for petSpellId=1,numSpells,1 do
				local spellName,spellRank=GetSpellName(petSpellId,BOOKTYPE_PET);
				local spellTexture=GetSpellTexture(petSpellId,BOOKTYPE_PET);
				if (spellName==nil) then break; end
				if (not structPetSpell["Spells"]) then
					structPetSpell["Spells"]={};
				end
				structPetSpell["Spells"][spellName]={};
				structPetSpell["Spells"][spellName]["Rank"]=spellRank;
				structPetSpell["Spells"][spellName]["Texture"]=spellTexture;
				structPetSpell["Count"]=petSpellId;
			end
			rpgoCPstate["PetSpell"][petName]=numSpells;
		end
	end
end

function rpgoCP_TradeTimer(event,arg1)
	local skill;
	if(not rpgoCPstate["ProfTimer"]) then rpgoCPstate["ProfTimer"]={}; end
	if(event=="CRAFT_UPDATE") then
		skill=GetCraftDisplaySkillLine();
	elseif(event=="TRADE_SKILL_UPDATE") then
		skill=GetTradeSkillLine();
	end
	if(skill) then
		if( (not arg1) or (not rpgoCPstate["ProfTimer"][skill]) ) then
			rpgoCPstate["ProfTimer"][skill]=0;
		elseif(tonumber(arg1)) then
			rpgoCPstate["ProfTimer"][skill]=rpgoCPstate["ProfTimer"][skill]+arg1;
		end
		if(rpgoCPstate["ProfTimer"][skill] > 1) then
			rpgoCPstate["ProfTimer"][skill]=nil;
			rpgoCP_EventHandler(string.gsub(event,'_UPDATE','_SHOW'),arg1);
		end
	end
end

function rpgoCP_ScanMCattune(arg1,arg2)
	if(not myProfile[rpgoCPserver][rpgoCPplayer]["Info"]) then
		myProfile[rpgoCPserver][rpgoCPplayer]["Info"]={};
	end
end

function rpgoCP_UpdatePlayed(arg1,arg2)
	if(arg1 and arg2) then timePlayed=arg1; timeLevelPlayed=arg2; end
	if(rpgoCPstate["_loaded"] and myProfile[rpgoCPserver][rpgoCPplayer]) then
		myProfile[rpgoCPserver][rpgoCPplayer]["TimePlayed"]=timePlayed;
		myProfile[rpgoCPserver][rpgoCPplayer]["TimeLevelPlayed"]=timeLevelPlayed;
	end
end

function rpgoCP_UpdateZone()
	myProfile[rpgoCPserver][rpgoCPplayer]["Zone"]=GetZoneText();
	myProfile[rpgoCPserver][rpgoCPplayer]["SubZone"]=GetSubZoneText();
end

function rpgoCP_UpdateBagScan(arg1)
	if(arg1 and rpgoCPstate["Bag"][arg1]) then
		local x=0;
		rpgoCPstate["Bag"][arg1]=nil;
		for i,j in rpgoCPstate["Bag"] do x=1;break; end
		if(x==0) then
			rpgoCPstate["_bagevent"]=nil;
			this:UnregisterEvent("BAG_UPDATE");
		end
	end
end

function rpgoCP_UpdateDate()
	myProfile[rpgoCPserver][rpgoCPplayer]["Date"]=date();
	myProfile[rpgoCPserver][rpgoCPplayer]["DateUTC"]=date("!%m/%d/%y %H:%M:%S");
	local currHour,currMinute=GetGameTime();
	myProfile[rpgoCPserver][rpgoCPplayer]["ServerTime"]=format("%02d:%02d",currHour,currMinute);
	--toRemove
	myProfile[rpgoCPserver][rpgoCPplayer]["DateUpdated"]=myProfile[rpgoCPserver][rpgoCPplayer]["Date"];
end

--[[//////////////////////////////////////////////
--	general functions
--	////////////////////////////////////////////]]
function rpgoCP_ScanItemInfo(itemlink,itemtexture,itemcount,itemtooltip)
	local itemColor,itemLink,itemID,itemName=rpgo_GetItemInfo(itemlink);
	--local itemName,itemLink,itemRarity,itemMinLeveL,itemType,itemSubType,itemStackCount,itemEquipLoc=GetItemInfo(itemLink);
	local itemBlock={};
	itemBlock["Name"]=itemName;
	itemBlock["Item"]=itemID;
	itemBlock["Color"]=itemColor;
	itemBlock["Quantity"]=itemcount;
	itemBlock["Texture"]=itemtexture;
	itemBlock["Tooltip"]=itemtooltip;
	return itemBlock;
end

function rpgoCP_ScanBagInfo(bagindex,baglink,bagtexture,bagtooltip)
	local itemColor,bagLink,itemID,itemName=rpgo_GetItemInfo(baglink);
	local itemName,itemLink,itemRarity,itemMinLeveL,itemType,itemSubType,itemStackCount,itemEquipLoc=GetItemInfo(bagLink);
	local bagBlock={};
	bagBlock["Name"]=GetBagName(bagindex);
	bagBlock["Slots"]=rpgoCP_GetContainerNumSlots(bagindex);
	bagBlock["Item"]=itemID;
	bagBlock["Color"]=itemColor;
	bagBlock["Texture"]=bagtexture;
	bagBlock["Tooltip"]=bagtooltip;
	bagContainerText=itemType;
	return bagBlock;
end

function rpgoCP_GetBagKey(bag)
	local key,slot;
	key=0;
	for slot=1,rpgoCP_GetContainerNumSlots(bag) do
		local _,itemCount,_,quality=GetContainerItemInfo(bag,slot);
		if(itemCount and quality) then key=key+rpgoCP_CalcItemKey(itemCount,quality,slot); end
	end
	return(key);
end

function rpgoCP_GetEQKey()
	local link,id,index,key;
	key=0;
	for index in UnitSlots do
		id=nil;
		if(index==0) then
			link=GetInventoryItemTexture("player",index);
			if(link) then id=1; end
		else
			link=GetInventoryItemLink("player",index);
			if(link) then _,id,_=rpgo_GetItemID(link); end
		end
		if(id) then key=key+id; end
	end
	return(key);
end

function rpgoCP_CalcItemKey(c,q,s) return((c*q)+s); end

--[function] msg:string
function rpgoCP_debug(msg)
	if (rpgoCPpref and rpgoCPpref["debug"]) then
		if(rpgoDebug) then rpgoDebug(rpgoCP_ABBR,msg);
		else rpgo_VerboseMsg(rpgo_ColorizeTitle(rpgoCP_PROVIDER,rpgoCP_ABBR)..": ".."[" .. msg .. "]",1,0,0); end end
end

--[function] rpgoCP_myAddons
function rpgoCP_myAddons()
	if(myAddOnsFrame_Register) then
		rpgoCP_debug("myAddons: init");
		local rpgoAddonsInfoCP={
			name=rpgoCP_TITLE,
			version=rpgoCP_VERSION,
			releaseDate=rpgoCP_DATE,
			author=rpgoCP_AUTHOR,
			email=rpgoCP_EMAIL,
			website=rpgoCP_URL,
			category=MYADDONS_CATEGORY_OTHERS,
			frame="rpgoCPframe",
		};
		local rpgoAddonsUsageCP={};
		if(rpgoCP_Usage) then
			table.insert(rpgoAddonsUsageCP,rpgoCP_PROVIDER.."-"..rpgoCP_ABBR.." Usage (slash commands)");
			for index=1,table.getn(rpgoCP_Usage),1 do
				table.insert(rpgoAddonsUsageCP,rpgo_AssempleHelp(rpgoCP_Usage[index]));
			end
		end
		local rpgoAddonsHelpCP={
			"CharacterProfiler is an addon that extracts character info including stats, equipment, inventory, trade skills, spellbook.  This information can then be uploaded to your website to display your character info.\n\n"..table.concat(rpgoAddonsUsageCP,"\n"),
		};
		myAddOnsFrame_Register(rpgoAddonsInfoCP,rpgoAddonsHelpCP);
	end
end

--[[// general rpgo functions: unit
--	////////////////////////////////////////////]]
--[function] arg1:unit
function rpgo_UnitSexString(arg1)
	local version,buildnum,builddate = GetBuildInfo();
	local _,_,vVersion,vMajor,vMinor=string.find(version,"(%d+).(%d+).(%d+)");
	vVersion=tonumber(vVersion);
	vMajor=tonumber(vMajor);
	if ( vVersion == 1 and vMajor >= 11 ) then
		local UnitSexLabel={UNKNOWN,MALE,FEMALE};
		return UnitSexLabel[UnitSex(arg1)];
	else
		local UnitSexLabel={MALE,FEMALE,UNKNOWN};
		return UnitSexLabel[UnitSex(arg1)+1];
	end
	return UNKNOWN;
end


--[function] rpgo_GetMoney()
function rpgo_GetMoney()
	local money=GetMoney();
	local gold,silver,copper;
	local CopperPerGold=COPPER_PER_SILVER * SILVER_PER_GOLD;
	gold=floor(money/CopperPerGold);
		money=mod(money,CopperPerGold);
	silver=floor(money/COPPER_PER_SILVER);
		money=mod(money,CopperPerGold);
	copper=mod(money,COPPER_PER_SILVER);
	return gold,silver,copper;
end

--[[// general rpgo functions: item
--	////////////////////////////////////////////]]
--[function] itemlink
function rpgo_GetItemID(itemlink)
	local item,id,rid;
	if(itemlink) then _,_,item,id,rid=string.find(itemlink,"item:((%d+):%d+:(%d+):%d+)|"); end
	return item,id,rid;
end
--[function] itemlink
function rpgo_GetItemInfo(itemlink)
	local c,l,i,n;
	if(itemlink) then _,_,c,l,i,n=string.find(itemlink,"|c(%x+)|H(item:(%d+:%d+:%d+:%d+))|h%[(.-)%]|h|r"); end
	return c,l,i,n;
end
--[function] tooltip iteminfo
function rpgo_GetItemInfoTT(tooltipName)
	local nTT,cTT,r,g,b;
	if(tooltipName==nil) then tooltipName="rpgoCPtooltip"; end
	ttText=getglobal(tooltipName.."TextLeft1");
	nTT=ttText:GetText();
	if(nTT) then r,g,b=ttText:GetTextColor(); cTT=string.format("ff%x%x%x",r*256,g*256,b*256); end
	return nTT,cTT;
end

--[[// general rpgo functions: tooltip
--	////////////////////////////////////////////]]
--[function] tooltipName
function rpgo_TooltipScan(tooltipName)
	if(tooltipName==nil) then tooltipName=rpgoCP_TOOLTIP; end
	tooltipFrame=getglobal(tooltipName);
	local ttTextScan={};
	for idx=1,tooltipFrame:NumLines() do
		local ttTextBuff=nil;
		ttText=getglobal(tooltipName.."TextLeft"..idx);
		if(ttText and ttText:IsShown()) then
			ttTextBuff=ttText:GetText();
			if (ttText) then
				ttTextBuff=string.gsub(ttTextBuff,"\n","<br>");
				ttTextBuff=string.gsub(ttTextBuff,"\r","");
			end
		end
		ttText=getglobal(tooltipName.."TextRight"..idx);
		if(ttText and ttText:IsShown()) then
			if (ttText) then
				ttTextBuff=ttTextBuff.."\t"..ttText:GetText();
			end
		end
		if(ttTextBuff) then table.insert(ttTextScan,ttTextBuff); end
	end
	tooltipFrame:ClearLines();
	if(rpgoCPpref["tooltipshtml"]) then return table.concat(ttTextScan,"<br>");
	else return ttTextScan; end
end

--[[//////////////////////////////////////////////
--	general rpgo functions (shared)
--	////////////////////////////////////////////]]
--[function] str
function rpgo_Str2Ary(str)
	local tab={n=0};
	local function S2Ahelper(word) table.insert(tab,word) end
	if not string.find(string.gsub(str,"%w+",S2Ahelper),"%S") then return tab end end
--[function] str
function rpgo_Str2Abbr(str)
	local abbr='';
	local function S2Ahelper(word) abbr=abbr..string.sub(word,1,1) end
	if not string.find(string.gsub(str,"%w+",S2Ahelper),"%S") then return abbr end end
--[function] arg:key1,key2,val1,val2
function rpgo_Arg2Tab(...)
	local tab={};
	local split=floor(arg.n/2);
	for i=1,split,1 do tab[arg[i]]=arg[i+split]; end
	return tab; end
--[function] arg:arg1,arg2...
function rpgo_Arg2Ary(...)
	local tab={};
	for i=1,arg.n,1 do tab[i]=arg[i]; end
	return tab; end
--[function]
function rpgo_SetTooltip()
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT"); end
--[function] pref
function rpgo_LiteScan(pref)
	if(not pref) then return false; end
	if(pref) then
	local msg;
		if(UnitInRaid("player")) then msg="raid";
		elseif(rpgo_IsInInstance()) then msg="instance"; end
		if(msg) then
			if(not rpgoCPstate["_litemsg"]) then
				rpgoCPstate["_litemsg"]=true;
				rpgo_VerboseMsg(rpgo_ColorizeTitle(rpgoCP_PROVIDER,rpgoCP_ABBR)..": scan skipped: character is in "..msg);
			end return 1; end end
	return nil; end
--[function]
function rpgo_IsInInstance()
	SetMapToCurrentZone();
	a,b=GetPlayerMapPosition("player");
	if(a==0 and b==0) then return 1; else return nil; end end
--[function] msg
function rpgo_VerboseMsg(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg); end
--[function] pref
function rpgo_ColorizePref(pref)
	if(pref) then return rpgo_ColorizeMsg(rpgoColorGreen,"on|r")
	else return rpgo_ColorizeMsg(rpgoColorRed,"off|r") end end
--[function] helpline
function rpgo_AssempleHelp(helpline)
	local msg; if(type(helpline)=="table") then
		msg="  |cff"..rpgoColorTitle..helpline[1].."|r     "..helpline[2];
		if(helpline[3]) then msg=msg.."\n     "..helpline[3]; end
		else msg=helpline; end
		return msg; end
--[function] structPref,structDefault
function rpgo_InitPref(structPref,structDefault)
	for pref,val in structDefault do
		if(type(structDefault[pref])=="table") then if(not structPref[pref]) then structPref[pref]={}; end rpgo_InitPref(structPref[pref],structDefault[pref]);
		elseif(structPref[pref] == nil) then structPref[pref]=val; end end end
--[function] structPref,structDefault
function rpgo_TidyPref(structPref,structDefault)
	for pref,val in structPref do
		if(type(structDefault[pref])=="table") then rpgo_TidyPref(structPref[pref],structDefault[pref]);
		elseif(structDefault[pref] == nil) then structPref[pref]=nil; end end end
--[function] structPref
function rpgoCP_ConvertPrefSub(structPref,structPrefConv)
	local valNew,prefNew;
	for pref,val in structPref do
		prefNew=strlower(pref);
		if(type(structPref[pref])=="table") then
			if(not structPrefConv[pref]) then structPrefConv[pref]={}; end
			rpgoCP_ConvertPrefSub(structPref[pref],structPrefConv[pref]);
			structPrefConv[prefNew]=structPrefConv[pref];
			structPrefConv[pref]=nil;
		else
			if(val==1) then valNew=true;
			elseif(val==0) then valNew=false; end
			structPrefConv[prefNew]=valNew;
		end
	end
end
--[function] provider,title
function rpgo_ColorizeTitle(provider,title)
		if(provider and title) then return rpgo_ColorizeMsg(rpgoColorTitle,provider.."-"..title); end end
--[function] color,msg
function rpgo_ColorizeMsg(color,msg)
		if(color and msg) then return "|cff"..color..msg.."|r"; end end
