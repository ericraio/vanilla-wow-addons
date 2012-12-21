
NURFED_GENERAL_VERS = "07.01.2006";

NURFED_GENERAL_DEFAULT = {
	repair = 1;
	repairinv = 1;
	repairlimit = 20;
	ping = 1;
	traineravailable = 1;
	timestamps = 1;
	timeoffset = 0;
	ampm = 1;
	raidgroup = 1;
	raidclass = 1;
	hidechat = 1;
	chatfade = 1;
	chatfadetime = 120;
	autoinvite = 1;
	chatprefix = 1;
	keyword = "invite";
};

ChatTypeInfo["CHANNEL"].sticky = 1;
ChatTypeInfo["OFFICER"].sticky = 1;
UnitPopupButtons["INSPECT"] = { text = TEXT(INSPECT), dist = 0 };
ManaBarColor[0] = { r = 0.00, g = 1.00, b = 1.00, prefix = TEXT(MANA) };

local utility = Nurfed_Utility:New();
local unitlib = Nurfed_Units:New();
local framelib = Nurfed_Frames:New();
local lib = Nurfed_General:New();
local options = Nurfed_Options:New();
local currtime = 0;
local pingflood = {};
local raidtarget = {
	[RAID_TARGET_1] = 1,
	[RAID_TARGET_2] = 2,
	[RAID_TARGET_3] = 3,
	[RAID_TARGET_4] = 4,
	[RAID_TARGET_5] = 5,
	[RAID_TARGET_6] = 6,
	[RAID_TARGET_7] = 7,
	[RAID_TARGET_8] = 8,
};

--------------------------------------------------------------------------------------------------
--				Slash Commands
--------------------------------------------------------------------------------------------------

SLASH_NURFEDEQUIP1 = "/nequip";
SlashCmdList["NURFEDEQUIP"] = function(msg)
	lib:itemswitch(msg);
end

SLASH_NURFEDWHISPER1 = "/wtar";
SlashCmdList["NURFEDWHISPER"] = function(msg)
	if (UnitExists("target")) then
		SendChatMessage(msg, "WHISPER", this.language, UnitName("target"));
	end
end

SLASH_NURFEDRAIDTARGET1 = "/rtar";
SlashCmdList["NURFEDRAIDTARGET"] = function(msg)
	Nurfed_RaidTarget(msg);
end

--------------------------------------------------------------------------------------------------
--	Put a -- in front of DAMAGE_TEXT_FONT to change back the damage font (cannot be in game).
--------------------------------------------------------------------------------------------------

DAMAGE_TEXT_FONT = "Fonts\\skurri.ttf";

--------------------------------------------------------------------------------------------------
--				Chat Frame Functions
--------------------------------------------------------------------------------------------------


local function Nurfed_AddMessage(this, msg, r, g, b, id)
	if (msg) then
		local prefix = options:GetOption("general", "chatprefix");
		local text = {};
		if(options:GetOption("general", "timestamps") == 1) then
			local hour, minute = GetGameTime();
			local second = GetTime() - currtime;
			if (second > 59) then
				second = 0;
			end
			hour = hour + options:GetOption("general", "timeoffset");
			if( hour > 23 ) then
				hour = hour - 24;
			elseif( hour < 0 ) then
				hour = 24 + hour;
			end
			if (options:GetOption("general", "ampm") == 1) then
				if (hour >= 12) then
					hour = hour - 12;
				end
				if (hour == 0) then
					hour = 12;
				end
			end
			local timestamp = format("[%d:%02d:%02d]", hour, minute, second);
			table.insert(text, timestamp);
		end

		if (string.find(msg, "["..RAID.."]", 1, true)) then
			local info = unitlib:GetUnit(arg2);
			if (info) then
				msg = string.gsub(msg, "%["..RAID.."%] ", "");
				if (prefix == 1) then
					table.insert(text, "["..RAID.."]");
				end
				if (options:GetOption("general", "raidgroup") == 1) then
					table.insert(text, "["..info.g.."]");
				end
				if (options:GetOption("general", "raidclass") == 1) then
					table.insert(text, "["..info.c.."]");
				end
			end
		end
		if (prefix ~= 1) then
			msg = string.gsub(msg, "%["..CHAT_MSG_OFFICER.."%] ", "");
			msg = string.gsub(msg, "%["..CHAT_MSG_GUILD.."%] ", "");
			msg = string.gsub(msg, "%["..CHAT_MSG_PARTY.."%] ", "");
			msg = string.gsub(msg, "%["..CHAT_MSG_RAID.."%] ", "");
			msg = string.gsub(msg, "%["..CHAT_MSG_RAID_LEADER.."%] ", "");
			msg = string.gsub(msg, "%["..CHAT_MSG_RAID_WARNING.."%] ", "");
		end
		table.insert(text, msg);
		this:Original_AddMessage(table.concat(text, " "), r, g, b, id);
	end
end

local Original_ChatFrame_OnEvent = ChatFrame_OnEvent;

local function Nurfed_ChatFrame_OnEvent(event)
	if (event == "CHAT_MSG_SYSTEM" and arg1 ~= nil) then
		local _, _, name, id, days, hours, minutes, seconds = string.find(arg1, "(.+) %(ID=(%x+)%): (%d+)d (%d+)h (%d+)m (%d+)s")
		if (name ~= nil) then
			local timeTable = date("*t");
			timeTable["sec"] = timeTable["sec"] + (days * 86400) + (hours * 3600) + (minutes * 60) + seconds;
			arg1 = name.." (ID="..id.."): "..date("%A %B %d at %I:%M %p", time(timeTable)).."";
		end
		if (options:GetOption("general", "autoinvite") == 1) then
			if (string.find(arg1, ERR_GROUP_FULL, 1, true)) then
				local lastTell = ChatEdit_GetLastTellTarget(DEFAULT_CHAT_FRAME.editBox);
				SendChatMessage("Party Full", "WHISPER", this.language, lastTell);
			else
				local ingroup = utility:FormatGS(ERR_ALREADY_IN_GROUP_S, true);
				local result = { string.find(arg1, ingroup) };
				if (result[1]) then
					SendChatMessage("Drop group and resend '"..options:GetOption("general", "keyword").."'", "WHISPER", this.language, result[3]);
				end
			end
		end
	elseif (event == "CHAT_MSG_WHISPER" and arg1 ~= nil) then
		if (options:GetOption("general", "autoinvite") == 1) then
			if (IsPartyLeader() or IsRaidLeader() or IsRaidOfficer()) then
				local text = string.lower(arg1);
				local keyword = string.lower(options:GetOption("general", "keyword"));
				if (string.find(text, "^"..keyword)) then
					InviteByName(arg2);
				end
			end
		end
	elseif (event == "CHAT_MSG_WHISPER_INFORM") then
		if (string.find(arg1, "^%!ndkp")) then
			return;
		end
	end
	Original_ChatFrame_OnEvent(event);
	if(not this.Original_AddMessage) then
		this.Original_AddMessage = this.AddMessage;
		this.AddMessage = Nurfed_AddMessage;
	end
end

utility:Hook("replace", "ChatFrame_OnEvent", Nurfed_ChatFrame_OnEvent);

--------------------------------------------------------------------------------------------------
--				Buff Duration Add Seconds
--------------------------------------------------------------------------------------------------

local function Nurfed_SecondsToTimeAbbrev(seconds)
	local time = "";
	local tempTime;
	local tempTime2;
	if ( seconds > 86400  ) then
		tempTime = ceil(seconds / 86400);
		time = tempTime.." "..DAY_ONELETTER_ABBR;
		return time;
	end
	if ( seconds > 3600  ) then
		tempTime = ceil(seconds / 3600);
		time = tempTime.." "..HOUR_ONELETTER_ABBR;
		return time;
	end
	if ( seconds > 60  ) then
		tempTime = floor(seconds / 60);
		tempTime2 = floor(seconds-(tempTime)*60);
		time = format("%02d:%02d", tempTime, tempTime2);
		return time;
	end
	time = format("00:%02d", seconds);
	return time;
end

SecondsToTimeAbbrev = Nurfed_SecondsToTimeAbbrev;

--------------------------------------------------------------------------------------------------
--				Create Frame
--------------------------------------------------------------------------------------------------

-- adds guild info to a line in the inspect frame
local function Nurfed_InspectOnShow()
	InspectPaperDollFrame_OnShow();
	local guildname, guildtitle = GetGuildInfo("target");
	if(guildname and guildtitle) then
		InspectTitleText:SetText(format(TEXT(GUILD_TITLE_TEMPLATE), guildtitle, guildname));
		InspectTitleText:Show();
	else
		InspectTitleText:Hide();
	end
end

local orig_chatframeOnShow = ChatFrame1:GetScript("OnShow");

local function togglechat()
	local hidden = options:GetOption("general", "hidechat");
	local fade = options:GetOption("general", "chatfade");
	local fadetime = options:GetOption("general", "chatfadetime");
	for i = 1, 7 do
		local chatframe = getglobal("ChatFrame"..i);
		local up = getglobal("ChatFrame"..i.."UpButton");
		local down = getglobal("ChatFrame"..i.."DownButton");
		local bottom = getglobal("ChatFrame"..i.."BottomButton");
		if (hidden == 1) then
			chatframe:SetScript("OnShow", function() SetChatWindowShown(this:GetID(), 1) end);
				up:Hide();
				down:Hide();
				bottom:Hide();
			if (i == 1) then
				ChatFrameMenuButton:Hide();
			end
		else
			chatframe:SetScript("OnShow", orig_chatframeOnShow);
				up:Show();
				down:Show();
				bottom:Show();
			if (i == 1) then
				ChatFrameMenuButton:Show();
			end
		end
		chatframe:SetFading(fade);
		chatframe:SetTimeVisible(fadetime);
	end
end

local function Nurfed_General_OnEvent()
	if (event == "PLAYER_ENTERING_WORLD") then
		this:UnregisterEvent(event);
		togglechat();
	elseif (event == "TRAINER_SHOW") then
		if(options:GetOption("general", "traineravailable") == 1) then
			SetTrainerServiceTypeFilter("unavailable",0);
		end
	elseif (event == "MERCHANT_SHOW") then
		if (options:GetOption("general", "repair") == 1) then
			lib:repair(options:GetOption("general", "repairlimit"), options:GetOption("general", "repairinv"));
		end
	elseif (event == "MINIMAP_PING") then
		if(options:GetOption("general", "ping") == 1) then
			local name = UnitName(arg1);
			if (name ~= UnitName("player") and not pingflood[name]) then
				utility:Print(name.." Ping.", 1, 1, 1, 0);
				pingflood[name] = GetTime();
			end
		end
	elseif (event == "ADDON_LOADED" and arg1 == "Blizzard_InspectUI") then
		InspectPaperDollFrame:SetScript("OnShow", Nurfed_InspectOnShow);
	end
end

function Nurfed_General_OnUpdate(arg1)
	this.update = this.update + arg1;
	if (this.update > 0.5) then
		local hour, minute = GetGameTime();
		if (minute ~= this.lastmin) then
			currtime = GetTime();
			this.lastmin = minute;
		end

		local svol = GetCVar("MasterVolume")+0;
		if (svol > 0.5) then
			SetCVar("MasterVolume", svol-0.05);
		else
			SetCVar("MasterVolume", svol+0.05);
		end
		SetCVar("MasterVolume", svol);

		for n, t in pingflood do
			if (GetTime() - t > 1) then
				pingflood[n] = nil;
			end
		end
	end
end

local tbl = {
	type = "Frame",
	events = {
		"PLAYER_ENTERING_WORLD",
		"MINIMAP_PING",
		"ADDON_LOADED",
		"TRAINER_SHOW",
		"MERCHANT_SHOW"
	},
	OnEvent = function() Nurfed_General_OnEvent() end,
	OnUpdate = function() Nurfed_General_OnUpdate(arg1) end,
	vars = { update = 0, lastmin = 0 },
};

local config = {
	type = "Frame",
	Anchor = { "TOP", "$parenttitlebg", "BOTTOM", 0, -1 },
	children = {
		check1 = {
			template = "Nurfed_OptionCheck",
			properties = {
				Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 0, 0 },
				vars = {
					text = NRF_AUTOREPAIR,
					option = "repair",
				},
			},
		},
		check2 = {
			template = "Nurfed_OptionCheck",
			properties = {
				Anchor = { "TOPLEFT", "$parentcheck1", "BOTTOMLEFT", 0, -3 },
				vars = {
					text = NRF_INVREPAIR,
					option = "repairinv",
				},
			},
		},
		check3 = {
			template = "Nurfed_OptionCheck",
			properties = {
				Anchor = { "TOPLEFT", "$parentcheck2", "BOTTOMLEFT", 0, -3 },
				vars = {
					text = NRF_PINGWARNING,
					option = "ping",
				},
			},
		},
		check4 = {
			template = "Nurfed_OptionCheck",
			properties = {
				Anchor = { "TOPLEFT", "$parentcheck3", "BOTTOMLEFT", 0, -3 },
				vars = {
					text = NRF_UNTRAINABLE,
					option = "traineravailable",
				},
			},
		},
		check5 = {
			template = "Nurfed_OptionCheck",
			properties = {
				Anchor = { "TOPLEFT", "$parentcheck4", "BOTTOMLEFT", 0, -3 },
				vars = {
					text = NRF_CHATTIMESTAMPS,
					option = "timestamps",
				},
			},
		},
		check6 = {
			template = "Nurfed_OptionCheck",
			properties = {
				Anchor = { "TOPLEFT", "$parentcheck5", "BOTTOMLEFT", 0, -3 },
				vars = {
					text = NRF_TWELVEHOUR,
					option = "ampm",
				},
			},
		},
		check7 = {
			template = "Nurfed_OptionCheck",
			properties = {
				Anchor = { "TOPLEFT", "$parentcheck6", "BOTTOMLEFT", 0, -3 },
				vars = {
					text = NRF_RAIDGROUP,
					option = "raidgroup",
				},
			},
		},
		check8 = {
			template = "Nurfed_OptionCheck",
			properties = {
				Anchor = { "TOPLEFT", "$parentcheck7", "BOTTOMLEFT", 0, -3 },
				vars = {
					text = NRF_RAIDCLASS,
					option = "raidclass",
				},
			},
		},
		check9 = {
			template = "Nurfed_OptionCheck",
			properties = {
				Anchor = { "TOPLEFT", "$parentcheck8", "BOTTOMLEFT", 0, -3 },
				vars = {
					text = NRF_CHATBUTTONS,
					option = "hidechat",
					func = function() togglechat() end,
				},
			},
		},
		check10 = {
			template = "Nurfed_OptionCheck",
			properties = {
				Anchor = { "TOPLEFT", "$parentcheck9", "BOTTOMLEFT", 0, -3 },
				vars = {
					text = NRF_CHATPREFIX,
					option = "chatprefix",
				},
			},
		},

		slider1 = {
			template = "Nurfed_OptionSlider",
			properties = {
				Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -2, -12 },
				vars = {
					text = NRF_REPAIRLIMIT,
					option = "repairlimit",
					max = 100,
					min = 0,
					step = 1,
					format = "%.0f",
				},
			},
		},
		slider2 = {
			template = "Nurfed_OptionSlider",
			properties = {
				Anchor = { "TOPRIGHT", "$parentslider1", "BOTTOMRIGHT", 0, -15 },
				vars = {
					text = NRF_TIMEOFFSET,
					option = "timeoffset",
					max = 12,
					min = -12,
					step = 0.5,
					format = "%.1f",
				},
			},
		},
		check11 = {
			template = "Nurfed_OptionCheck",
			properties = {
				Anchor = { "TOPRIGHT", "$parentslider2", "BOTTOMRIGHT", 0, -14 },
				vars = {
					right = true,
					text = NRF_AUTOINVITE,
					option = "autoinvite",
				},
			},
		},
		input1 = {
			template = "Nurfed_OptionInput",
			properties = {
				Anchor = { "TOPRIGHT", "$parentcheck11", "BOTTOMRIGHT", 0, 3 },
				vars = {
					text = NRF_KEYWORD,
					option = "keyword",
				},
			},
		},
		check12 = {
			template = "Nurfed_OptionCheck",
			properties = {
				Anchor = { "TOPRIGHT", "$parentinput1", "BOTTOMRIGHT", 0, -10 },
				vars = {
					right = true,
					text = NRF_CHATFADE,
					option = "chatfade",
					func = function() togglechat() end,
				},
			},
		},
		slider3 = {
			template = "Nurfed_OptionSlider",
			properties = {
				Anchor = { "TOPRIGHT", "$parentcheck12", "BOTTOMRIGHT", 0, -15 },
				vars = {
					text = NRF_CHATFADETIME,
					option = "chatfadetime",
					max = 250,
					min = 0,
					step = 1,
					format = "%.0f",
					func = function() togglechat() end,
				},
			},
		},
	},
	vars = { width = 350, height = 240 },
};

local function chatOnMouseWheel()
	if (IsShiftKeyDown()) then
		if (arg1 > 0) then
			this:PageUp()
		elseif (arg1 < 0) then
			this:PageDown();
		end
	elseif (IsControlKeyDown()) then
		if (arg1 > 0) then
			this:ScrollToTop()
		elseif (arg1 < 0) then
			this:ScrollToBottom();
		end
	else
		if (arg1 > 0) then
			this:ScrollUp();
		elseif (arg1 < 0) then
			this:ScrollDown();
		end
	end
end

function Nurfed_General_Init()
	framelib:ObjectInit("Nurfed_GeneralFrame", tbl, UIParent);
	framelib:ObjectInit("Nurfed_General_Menu", config, Nurfed_OptionsFrame);
	tbl = nil;
	config = nil;
	lib:updatemount();
	lib:updateaqmount();

	for i = 1, 7 do
		local chatframe = getglobal("ChatFrame"..i);
		chatframe:EnableMouseWheel(1);
		chatframe:SetScript("OnMouseWheel", function() chatOnMouseWheel(); end);
	end
end

--------------------------------------------------------------------------------------------------
--				Misc Functions
--------------------------------------------------------------------------------------------------

function Nurfed_Mount()
	local bag, slot = lib:getmount();
	if (bag and slot) then
		UseContainerItem(bag, slot);
	end
end

function Nurfed_RaidTarget(tar)
	if (not string.find(tar, "[1-9]")) then
		tar = string.lower(tar);
		tar = string.gsub(tar, "^%l", string.upper);
		if (raidtarget[tar]) then
			tar = raidtarget[tar];
		end
	end
	tar = tonumber(tar);
	for i = 1, GetNumRaidMembers() do
		local unit = "raid"..i;
		local target = "raid"..i.."target";
		if (UnitExists(unit) and UnitExists(target)) then
			if (GetRaidTargetIndex(target) == tar) then
				TargetUnit(target);
				return;
			end
		end
	end
end