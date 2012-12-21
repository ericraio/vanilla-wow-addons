WP_Registered = nil;

function myWhoPinged_OnLoad()
	if(not whopinged_cfg) then
		whopinged_cfg = {};
		whopinged_cfg["zone"] = 1;
		whopinged_cfg["IGNORE"] = {};
	end
	wpversion = "0.3";
	theypinged = nil;
	theypinged2 = nil;
	whospinging = nil;

	this:RegisterEvent("MINIMAP_PING");
	this:RegisterEvent("VARIABLES_LOADED");

	SlashCmdList["WHOPINGED"] = myWhoPinged_SlashHandler;
	SLASH_WHOPINGED1 = "/wp";

	WP_Registered = 0;
-- hook minimap ping event to show who pinged
	myWhoPinged_original_Minimap_OnEvent = Minimap_OnEvent;
	Minimap_OnEvent = myWhoPinged_Minimap_OnEvent;

-- hook sound event to assist in ignoring pings
	myWhoPinged_original_PlaySound = PlaySound;
	PlaySound = myWhoPinged_PlaySound;

	-- DEFAULT_CHAT_FRAME:AddMessage("WhoPinged " .. wpversion .. " loaded. type /wp help to see a list of commands.");
end

function myWhoPinged_PlaySound(argument1)
	if(argument1 == "MapPing" and event == "MINIMAP_PING" and arg1 ~= nil) then
		if(myWhoPinged_IsInList(string.lower(UnitName(arg1)))) then
			return;
		end
	end
	myWhoPinged_original_PlaySound(argument1);
end

function myWhoPinged_SlashHandler(cmd)
	if(cmd ~= nil) then
		cmd = string.lower(cmd);
	end
	if(string.find(cmd, " ")) then
		local sep = string.find(cmd, " ");
		local wparg1 = string.sub(cmd, 1, (sep -1));
		sep = (sep + 1);
		wparg2 = string.sub(cmd, sep);
		cmd = wparg1;
	end
	if(cmd == "last") then
		myWhoPinged_WhoPinged()
	elseif(cmd == "") then
		myWhoPinged_WhosPinging()
	elseif(cmd == "ignore") then
		myWhoPinged_IgnorePing(wparg2);
	elseif(cmd == "unignore") then
		myWhoPinged_UnIgnorePing(wparg2);
	elseif(cmd == "list") then
		myWhoPinged_ListIgnored();
	elseif(cmd == "zone") then
		myWhoPinged_ZoneToggle();
	else
		myWhoPinged_ShowHelp();
	end
	wparg2 = nil;
end

function myWhoPinged_ZoneToggle()
	if(whopinged_cfg["zone"] == 1) then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00DISABLED display of pinging player's name in zone field|r");
		whopinged_cfg["zone"] = 0;
		MinimapZoneText:SetText(GetMinimapZoneText());
	else
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00ENABLED display of pinging player's name in zone field|r");
		whopinged_cfg["zone"] = 1;
	end
end

function myWhoPinged_ListIgnored()
	if(whopinged_cfg["IGNORE"] ~= nil and table.getn(whopinged_cfg["IGNORE"]) > 0) then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Minimap pings ignored from players:|r");
		table.foreach(whopinged_cfg["IGNORE"], function(k,v) DEFAULT_CHAT_FRAME:AddMessage("-" .. v) end);
	else
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Ignore list is empty.|r");
	end
end

function myWhoPinged_ShowHelp()
	DEFAULT_CHAT_FRAME:AddMessage("|cffffff00WhoPinged " .. wpversion .. " Help:|r");
	DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00/wp|r: toggles on/off automatic ping identifying. can create lots of spam");
	DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00/wp last|r: shows the last two players to ping the map");
	DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00/wp ignore <player>|r: ignores a player's minimap pings");
	DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00/wp unignore|r <player>|r: removes a player from your minimap ping ignore list");
	DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00/wp list|r: lists players whose pings you're ignoring");
	DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00/wp zone|r: toggle to show the pinging player's name in the zone field above the minimap");
	DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00/wp help|r: shows this list of commands");
end

function myWhoPinged_UnIgnorePing(ipname)
	if(ipname ~= nil) then
		if(myWhoPinged_RemoveFromList(ipname)) then
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00No longer ignoring " .. ipname .. "'s pings.|r");
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00" .. ipname .. " not found in ignore list.|r");
		end
	else
		myWhoPinged_ShowHelp();
	end
end

function myWhoPinged_IgnorePing(ipname)
	if(ipname ~= nil) then
		if(not myWhoPinged_AddToList(ipname)) then
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Already ignoring " .. ipname .. "'s pings.|r");
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Now ignoring " .. ipname .. "'s pings.|r");
		end
	else
		myWhoPinged_ListIgnored();
	end
end

function myWhoPinged_WhoPinged()
	if(theypinged ~= nil) then
		if(theypinged2 ~= nil) then
			DEFAULT_CHAT_FRAME:AddMessage(theypinged .. " and " .. theypinged2 .. " last pinged the minimap.");
		else
			DEFAULT_CHAT_FRAME:AddMessage(theypinged .. " last pinged the minimap.");
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("no recorded minimap pings.");
	end
end

function myWhoPinged_IsInList(ipname)
	ipname = string.lower(ipname);
	if(whopinged_cfg["IGNORE"] ~= nil) then
		for i, v in whopinged_cfg["IGNORE"] do
			if(v == ipname) then
				return i;
			end
		end
		return false;
	else
		return false;
	end
end

function myWhoPinged_AddToList(ipname)
	ipname = string.lower(ipname);
	if(not myWhoPinged_IsInList(ipname)) then
		table.insert(whopinged_cfg.IGNORE, ipname)
		return true;
	else
		return false;
	end
end

function myWhoPinged_RemoveFromList(ipname)
	ipname = string.lower(ipname);
	tempo = myWhoPinged_IsInList(ipname);
	if(tempo) then
		table.remove(whopinged_cfg.IGNORE, tempo);
		return true;
	else
		return false;
	end
	tempo = nil;
end

function WP_RegisterUltimateUI()
	UltimateUI_RegisterConfiguration(
		"UUI_WHOPINGED",
		"SECTION",
		"WhoPinged",
		"Find out who pinged the minimap!"
	);
	UltimateUI_RegisterConfiguration(
		"UUI_WHOPINGED_SEPARATOR",
		"SEPARATOR",
		"WhoPinged",
		"Find out who pinged the minimap!"
	);
	UltimateUI_RegisterConfiguration(
		"UUI_SELFCAST_ENABLE",
		"CHECKBOX",
		"Enable SelfCast",
		"Check this box to enable WhoPinged.",
		myWhoPinged_WhosPinging,
		0
	);
	UltimateUI_RegisterConfiguration(
		"UUI_SELFCAST_ZONE",
		"CHECKBOX",
		"Zone output",
		"Will show who pinged in the minimap zone text area.",
		myWhoPinged_ZoneToggle,
		0
	);
	UltimateUI_RegisterConfiguration(
		"UUI_SELFCAST_LISTIGNORED",
		"BUTTON",
		"",
		"",
		myWhoPinged_ListIgnored,
		0,
		0,
		0,
		0,
		"List Ignored"
	);
	UltimateUI_RegisterConfiguration(
		"UUI_SELFCAST_COMMANDS",
		"BUTTON",
		"",
		"",
		myWhoPinged_ShowHelp,
		0,
		0,
		0,
		0,
		"Command List"
	);
	WP_Registered = 1;
end

function myWhoPinged_Minimap_OnEvent()
	--if(event == "VARIABLES_LOADED" ) then
	if( WP_Registered == 0 ) then
		if ( UltimateUI_RegisterButton ) then
			WP_RegisterUltimateUI();
		end
	end
	--end
	if(event == "MINIMAP_PING" and arg1 ~= nil) then
		if(myWhoPinged_IsInList(string.lower(UnitName(arg1)))) then
			return;
		end
	end
	myWhoPinged_original_Minimap_OnEvent();
	if(event == "MINIMAP_PING" and arg1 ~= nil) then
		if(whopinged_cfg["zone"] == 1) then
			MinimapZoneText:SetText(UnitName(arg1));
		end
		if(theypinged ~= nil and theypinged ~= UnitName(arg1)) then
			theypinged2 = theypinged;
			theypinged = UnitName(arg1);
			if(whospinging == 1) then
				DEFAULT_CHAT_FRAME:AddMessage(theypinged .. " pinged the minimap!");
			end
		else
			theypinged = UnitName(arg1);
			if(whospinging == 1) then
				DEFAULT_CHAT_FRAME:AddMessage(theypinged .. " pinged the minimap!");
			end
		end
	end
end

function myWhoPinged_WhosPinging()
	if(whospinging == nil) then
		whospinging = 1;
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00ENABLED minimap ping identifying. type /wp to disable|r");
	else
		whospinging = nil;
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00DISABLED minimap ping identifying. type /wp to enable|r");
	end
end