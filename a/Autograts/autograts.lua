-- AutoGrats by Krod
--
-- version	1.3.1
-- Date		11.10.2005
--
-- Comments to: ram@catsec.com
--
-- Sends automatic congrats messages when a guild member dings...

function ag_OnLoad() -- register events
	this:RegisterEvent("GUILD_ROSTER_UPDATE");
	this:RegisterEvent("CHAT_MSG_GUILD");
	this:RegisterEvent("VARIABLES_LOADED");
	waiting_for_update=false;
end

function ag_OnEvent(event)-- check for initialization
	if (event == "VARIABLES_LOADED")then -- invoke init once all vars are loaded
		ag_Init();
	end
	if (event == "GUILD_ROSTER_UPDATE")then -- got a guild roster update event
		ag_GotRoster();
	end
	if (ag_enabled and event == "CHAT_MSG_GUILD" ) then -- got a guild text event
		ag_GuildText(arg1, arg2, arg3);
	end
end

function ag_Init() -- Initialize slash commands
	SlashCmdList["autograts"] = ag_Cmd;
	SLASH_autograts1 = "/grats";
	if (ag_enabled==nil) then
			ag_enabled=true;
	end
	ag_Print("Autograts by Krod, type: /grats help for more information");
	if (ag_enabled) then
		ag_Print("Autograts by Krod: Enabled");
	else
		ag_Print("Autograts by Krod: Disabled");
	end
	if (grats==nil) then -- a grats table does not exists - load default
		ag_Reset();
	end
	if (nicks==nil) then -- no nickname table, needs to create it
		nicks={};
	end
  ag_Version(); 
end

function ag_Version() -- version update code
	if (version==nil) then -- no version information, means version is less then 1.1
		version=1.0;
	end
	if (version<1.2) then -- version if less then 1.2, need to clear players table
		players={};
		version=1.2;
	end
end

function ag_GuildText(msg, who, lang) -- analyse guild message to find the word "ding" in it
		if (string.find(" "..string.lower(string.gsub(msg,"%p+","")).." "," ".."ding".." ") and who~=UnitName("player")) then
			ag_person=who;
			ag_lang=lang;
			waiting_for_update=true;
			waiting_for_who=false;
			GuildRoster(); -- ask for guildroster update
		end
end

function ag_Cmd(msg) -- process command line
	if (not msg or msg=="") then
		msg="help";
	end
	local args=ag_Spliter(msg);  -- split command line arguments into words
	local i;
	if (strlower(msg)=="off") then -- turn autograts off
		ag_enabled=false;
		ag_Print("Autograts Disabled");
	elseif (strlower(msg)=="on") then -- turn autograts on
   	ag_enabled=true;
  	ag_Print("Autograts Enabled")
	elseif (strlower(msg)=="players") then -- show players list
   	ag_Print("Registered players:");
  	table.foreach(players,function(i,l) ag_Print(i.."  ("..l..")") end);
  elseif (strlower(msg)=="who") then -- show who leveled and update the list
		waiting_for_who=true;
		waiting_for_update=false;
		GuildRoster();
	elseif (strlower(msg)=="list") then -- show grats list
   	ag_Print("Showing grats list");
   	if (grats) then
   		for i=1,table.getn(grats),1 do
				ag_Print(i..". Level range: "..grats[i][1].." - "..grats[i][2].." : "..grats[i][3]);
			end
		else
			ag_Print("***Empty***");
		end
	elseif (strlower(msg)=="reset") then 	-- Reset all grats to Defaults
		ag_Print("Reseting all grats to defaults");
		grats=nil;
		ag_Reset();
	elseif (strlower(args[1])=="nick") then -- process nickname commands
		if (args[2]) then
			if (strlower(args[2])=="clear") then -- removing all nicknames
				nicks={};
				ag_Print("All nicknames cleared");
			elseif (strlower(args[2])=="list") then -- List all nicknames
				ag_Print("Nicknames:");
				table.foreach(nicks,function(p,n) ag_Print("Player: "..p.." is nicknamed: '"..n.."'.") end);
			elseif (args[3]) then -- Set A players nickname
				local p=args[2];
				local n=args[3];
				nicks[p]=n;
				ag_Print("Player: "..p.." is now nicknamed: '"..n.."'.");
			else 	-- No third argument was specified: try to remove the nickname speficied in the second argument
				local p=args[2];
				if (nicks[p]) then -- the Nickname specified in the second argument exists - erase it
					nicks[p]=nil;
					ag_Print("Removed nickname for: "..p..".");
				else -- the Nickname specified in the second argument do not exist - show error
					ag_Print("Couldn't remove nickname for: "..p..", Player not found.");
				end
			end
		else
			ag_Print("Syntax Error, use /grats nick {clear/list/{player name}}");
		end
	elseif (strlower(args[1])=="remove") then -- remove a grats line
		if (args[2]) then -- a second argument was specified
			if (strlower(args[2])=="all") then -- removing all grats
				grats=nil;
				ag_Print("All grats removed");
			else -- remove specific grats line
				local ln=tonumber(args[2]);
				if (grats[ln]) then -- found the line number
					table.remove(grats,ln);
					ag_Print("Removed Line: "..ln);
				else -- line number was not found
					ag_Print("No such line");
				end
			end
		else
			ag_Print("syntax error: use /grats remove {all/line number}");
		end

	elseif (strlower(args[1])=="add") then -- add a grats line
		if (args[2] and args[3] and args[4]) then -- if all command line arguments exists
			valid=true;
			errstr=""; -- low level argument (second argument)
			low=tonumber(args[2]);
			if (low<1 or low>60) then -- low level bellow or above the range
				valid=false;
				errstr="lower level out of range.";
			end
			if (grats) then -- a grats table exists
				for i=1,table.getn(grats) do -- check for valid range for the 'low' argument
					if (low>=grats[i][1] and low<=grats[i][2]) then -- conflicts found...
						valid=false;
						errstr="lower level conflicts with another message (line"..i..")";
					end
				end
			end
			high=tonumber(args[3]); -- high level argument (third argument)
			if (high<1 or high>60 or high<low) then -- low level bellow or above the range
				valid=false;
				errstr="high level out of range.";
			end
			if (grats) then -- a grats table exists
				for i=1,table.getn(grats) do -- check for valid range for the 'high' argument
					if (high>=grats[i][1] and high<=grats[i][2]) then -- conflicts found...
						valid=false;
						errstr="high level collides with another message (line"..i..")";
					end
				end
			end
			if (valid) then -- if the command line is valid insert the new message at the correct spot
				local place=1;
				if (grats) then
					for i=1,table.getn(grats) do
						if (low>grats[i][1]) then
							place=i;
						end
					end
					if (place==table.getn(grats)) then
						table.insert(grats,{low,high,table.concat(args," ",4)});
					else
						table.insert(grats,place,{low,high,table.concat(args," ",4)});
					end
				else
					grats={[1]={low,high,table.concat(args," ",4)}}
				end
				ag_Print("Autograts message added");
			else
				ag_Print("syntax error: "..errstr);
			end
		else -- Error in "Add" parameters
				ag_Print("syntax error: use /grats add {low} {high} {message}");
		end
	else -- show help
  	ag_Print("/grats on - turns autograts on");
  	ag_Print("/grats off - turns autograts off");
  	ag_Print("/grats players - list all known players");
  	ag_Print("/grats list - list all messages");
  	ag_Print("/grats reset - reset messages to the default ones");
  	ag_Print("/grats remove all - removes all messages");
  	ag_Print("/grats remove {line} - removes the specified message line (N=line number");
  	ag_Print("/grats who - shows you all guild members who leveled since you were last online");
  	ag_Print("/grats nick {player} {nickname} - sets the {nickname} for {player}");
  	ag_Print("/grats nick list - lists all nicknames");
  	ag_Print("/grats nick clear - clears all nicknames");
  	ag_Print("/grats nick {player} - clears the nickname for {player}");
  	ag_Print("/grats add {low} {high} {message} - adds a message for the specified level range:");
  	ag_Print("    in {message} the following will be replaced by autograts:");
  	ag_Print("    @c will be replaced by the player who dinged Class");
  	ag_Print("    @p will be replaced by the player who dinged Name or nickname");
  	ag_Print("    @l will be replaced by the player who dinged Level");
  	ag_Print("    @t will be replaced by number of levels left till 60");
  	ag_Print("example: /grats add 1 60 Woohoo @p you are a great @c. will yield: 'Woohoo Krod you are a great Hunter'");
  end
end

function ag_Print(printout) -- print messages
	DEFAULT_CHAT_FRAME:AddMessage(printout,0.5,1,1);
end

function ag_GetInfo(guild_member)
   local g = GetNumGuildMembers();
   local i;
   for i=1,g do
      local name, rank, rankIndex, level, class, zone, group, note, officernote, online = GetGuildRosterInfo(i);
      if (name == guild_member) then
	 			return level,class;
      end
   end
   return 0, "none";
end

function ag_GotRoster() -- invoked when Guild Roster is updated
	if (waiting_for_who) then -- waiting for the /grats who
		waiting_for_who=false;
		local g = GetNumGuildMembers();
		local i;
		local f=false;
   	for i=1,g do
      local name, rank, rankIndex, level, class, zone, group, note, officernote, online = GetGuildRosterInfo(i);
     	if (players[name]~=level) then
     		players[name]=level;
     		f=true;
     		ag_Print(name.." had leveled since you were last online.");
     	end
    end
    if (not f) then
    	ag_Print("No online guild member had leveled since you were last online.");
    end
  end

	if (waiting_for_update) then -- get information on the player (level,class)
		local l,c=ag_GetInfo(ag_person);
		local t=60-l;
		local s;
		local m=ag_GetMsg(l); -- get the right message to the player's level
		if (players[ag_person]~=l) then -- if the player does not appear in the table or the players level is NOT the same as registered then send congrats
			if (m) then -- if a personalized message exists:
				local s=grats[m][3]; 
				if (nicks[ag_person]) then
					s=string.gsub(s,"@p",nicks[ag_person]);
				else
					s=string.gsub(s,"@p",ag_person);
				end
				s=string.gsub(s,"@l",l);
				s=string.gsub(s,"@t",t);
				s=string.gsub(s,"@c",c);
				SendChatMessage(s, "GUILD", ag_lang); -- send the message
			else -- message does not exist, send default grats
				SendChatMessage("Grats!", "GUILD", ag_lang);
			end
			players[ag_person]=l;
		end
		waiting_for_update=false;
	end
end

function ag_GetMsg(level) -- get the corresponding message to the players level
	if (grats==nil) then -- No grats table: return nil
		return nil;
	end
	local i;
	for i=1,table.getn(grats),1 do -- search grats table a line matching the dingers level
		local low=grats[i][1];
		local high=grats[i][2];
		if (level>=low and level<=high) then -- line found, return it
			return i;
		end
	end
	return nil; -- no level range found, return nil
end

function ag_Spliter(str) -- split a string into a table 
  local t = {};
  for word in string.gfind(str, "%S+") do
  	table.insert(t, word)
  end
  return t;
end

function ag_Reset() -- define default grats table
	grats={
	[1]={1,9,"*cough* Well.. Hmm.. grats I guess. Surely you're the mightiest @c in the world."},
	[2]={10,49,"Grats @p, only @t to go :-)"},
	[3]={50,59,"WOW! Grats @p, only @t to go ... almost there!"},
	[4]={60,60,"WOW! @p, you're 60!!! that calls for a party!"},
	}
end