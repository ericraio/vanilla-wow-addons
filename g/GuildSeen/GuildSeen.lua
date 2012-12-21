-- GuildSeen by Altariel

local VERSION = "1.8.0";
local RELEASEDATE = "October 13, 2005";

-- myAddons support variables
GuildSeenDetails = {
	name = "GuildSeen",
	description = "Adds a /seen command for looking up last online times of guild members.",
	version = VERSION,
	releaseDate = RELEASEDATE,
	author = "Altariel",
	email = "altariel@subpop.net",
	website = "http://wow.subpop.net/",
	category = MYADDONS_CATEGORY_GUILD,
	frame = "GuildSeenFrame",
};

function GuildSeen_OnLoad()
	SLASH_GUILDSEEN1 = "/seen";
	SLASH_GUILDSEEN2 = "/gseen";
	SlashCmdList["GUILDSEEN"] = GuildSeen_SlashCmd;

	this:RegisterEvent("VARIABLES_LOADED");

	if ( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("GuildSeen " .. VERSION .. " loaded.");
	end
	GuildRoster();
end

function GuildSeen_OnEvent()
	if(event == "VARIABLES_LOADED") then
		-- Register the addon in myAddOns
		if(myAddOnsFrame_Register) then
			myAddOnsFrame_Register(GuildSeenDetails, nil);
		end
	end
end

function GuildSeen_SlashCmd(player)
	if(player == "") then
		DEFAULT_CHAT_FRAME:AddMessage("GuildSeen version " .. VERSION);
		return;
	end
	
	-- Much of this code is inspired by CT_MailMod's Guild Roster parsing
	local oldOffline = GuildFrameLFGButton:GetChecked();
	SetGuildRosterShowOffline(1);

	local numGuildMembers = GetNumGuildMembers();
	if ( numGuildMembers > 0 ) then
		for i=1, numGuildMembers do
			name, rank, rankIndex, level, class, zone, group, note, officernote, online = GetGuildRosterInfo(i);
			if ( strfind(strupper(name), strupper(player)) ) then
				if ( online ) then
					DEFAULT_CHAT_FRAME:AddMessage(name .. " is currently online.");
				else
					yearsOffline, monthsOffline, daysOffline, hoursOffline = GetGuildRosterLastOnline(i);
					DEFAULT_CHAT_FRAME:AddMessage("Last seen " .. name .. ": " .. monthsOffline .. " months, " .. daysOffline .. " days, " .. hoursOffline .. " hours ago.");
				end
			end
		end
	end

	-- Revert to old scanning
	SetGuildRosterShowOffline(oldOffline);
end
