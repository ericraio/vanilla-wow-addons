--[[
	CT_RaidAssist Spy

	This addon is designed to watch
	for 4 types of check made by raid
	leaders which could be considered
	an invasion of privicy. 
	These are:
		Resists
		Reagents
		Durability
		Items
]]--

local CTRASPY_VERSION = 1.4;

-- onLoad
function ctraSpy_onLoad()
	-- Register hooks
	this:RegisterEvent("VARIABLES_LOADED");
	
	-- Add slash command
	SLASH_CTRASPY1 = "/ctras";
	SlashCmdList["CTRASPY"] = ctraSpy_slash;
end

-- onEvent
function ctraSpy_onEvent(event)
	if (event == "VARIABLES_LOADED") then
		-- Make sure the options are updated
		if (ctraSpyOptions == nil or ctraSpyOptions.version ~= CTRASPY_VERSION) then
			ctraSpy_updateOptions();
		end
		ctraSpy_toggleOnOff();		
		DEFAULT_CHAT_FRAME:AddMessage('CTRA Spy v.'..CTRASPY_VERSION..' Loaded!');		
	elseif (event == "CHAT_MSG_ADDON") then
		-- Make sure the message is for us
		if ( arg1 == "CTRA" and arg3 == "RAID" ) then

			-- Check the caller's permissions
			if ctraSpy_isPriv(arg4) == nil then
				return -- message not from a member of our group
			end
			
			-- Strip the message
			local msg = string.gsub(arg2, "%$", "s");
			msg = string.gsub(msg, "§", "S");
			if (strsub(msg, strlen(msg)-7) == " ...hic!") then
				msg = strsub(msg, 1, strlen(msg)-8);
			end
			
			-- Split the message if neccesary and send it for parsing
			local message;
			if (string.find(msg, "#")) then
				local arr = ctraSpy_split(msg, "#");
				for k, v in arr do
					ctraSpy_messageIn(arg4, v)
				end
			else
				ctraSpy_messageIn(arg4, msg)
			end
		end
	end	
end

-- Update the options from a version change or new install
function ctraSpy_updateOptions()
	
	-- We will do something fun here to upgrade when we have more version numbers
	-- Note, v1.1 added sound and version to the options.
	-- Note, v1.2 added chat frame output as well as ErrorFrame and switches for enable/disable checks
	-- Note, v1.3 added no new variables
	-- Note, v1.4 added no new variables
	
	-- This will deal with new installs
	if (not ctraSpyOptions or ctraSpyOptions.version == nil ) then
		-- Default options
		ctraSpyOptions = {
			enabled = true;
			sound = true;
			chat = true;
			resistance = true;
			reagents = true;
			durability = true;
			items = true;
			version = CTRASPY_VERSION;
		}
	end
	
	-- Upgrade to 1.1
	if (ctraSpyOptions.version < 1.1) then
		ctraSpyOptions.sound = true;
		ctraSpyOptions.version = 1.1;
	end
	
	-- Upgrade to 1.2
	if (ctraSpyOptions.version < 1.2) then
		ctraSpyOptions.chat = true;
		ctraSpyOptions.resistance = true;
		ctraSpyOptions.reagents = true;
		ctraSpyOptions.durability = true;
		ctraSpyOptions.items = true;
		ctraSpyOptions.version = 1.2;
	end

	ctraSpyOptions.version = CTRASPY_VERSION;
	
	DEFAULT_CHAT_FRAME:AddMessage('CTRA Spy variables updated to v.'..CTRASPY_VERSION);
end

-- Check if the <name> is authorised to do a check
function ctraSpy_isPriv(name)
	if (GetNumRaidMembers() > 0 and name ~= playerName) then
		for x = 1, 40 do
			if (UnitName("raid" .. x) == name) then
				return true
			end
		end
	end
end

-- Parse an incoming message
function ctraSpy_messageIn(nick, msg)		
	if (msg == "RSTC" and ctraSpyOptions.resistance) then -- Resists
		ctraSpy_out(nick, 'is doing a Resistance Check');
	elseif (msg == "REAC" and ctraSpyOptions.reagents) then -- Reagents
		ctraSpy_out(nick, 'is doing a Reagents Check');
	elseif (msg == "DURC" and ctraSpyOptions.durability) then --Durabillity
		ctraSpy_out(nick, 'is doing a Durability Check');
	elseif (string.find(msg, "^ITMC ") and ctraSpyOptions.items) then -- Items
		local _, _, itemName = string.find(msg, "^ITMC (.+)$");
		if (itemName) then
			ctraSpy_out(nick, 'is doing an Item Check for '..itemName);
		end
	end
end

-- Default output message formatter
function ctraSpy_out(nick, text)
	if (ctraSpyOptions.sound) then
		PlaySoundFile("Sound\\Spells\\PVPFlagTaken.wav");
	end
	if (ctraSpyOptions.chat) then
		DEFAULT_CHAT_FRAME:AddMessage('<CTRASpy> '..nick..' '..text);
	end
	UIErrorsFrame:AddMessage(nick..' '..text, 1.0, 0.12, 0.12, 1.0, UIERRORS_HOLD_TIME);
end

-- Register/Unregister the message event
function ctraSpy_toggleOnOff()
	if (ctraSpyOptions.enabled) then
		this:RegisterEvent("CHAT_MSG_ADDON");
	else
		this:UnregisterEvent("CHAT_MSG_ADDON");
	end
end

-- Handle the slash command to enable/disable
function ctraSpy_slash(msg)
	local frame = getglobal('CTRA_SpyOptionsFrame');
	if (frame) then
	      frame:Show();
	end
end

-- Split messages
function ctraSpy_split(msg, char)
	local arr = { };
	while (string.find(msg, char) ) do
		local iStart, iEnd = string.find(msg, char);
		tinsert(arr, strsub(msg, 1, iStart-1));
		msg = strsub(msg, iEnd+1, strlen(msg));
	end
	if ( strlen(msg) > 0 ) then
		tinsert(arr, msg);
	end
	return arr;
end

-- Initialize each of the checkboxes on the options form
function ctraSpyOptions_initialize()
	ctraSpyOptions_onClick(1, ctraSpyOptions.enabled);
	ctraSpyOptions_onClick(2, ctraSpyOptions.sound);
	ctraSpyOptions_onClick(3, ctraSpyOptions.chat);
	ctraSpyOptions_onClick(4, ctraSpyOptions.resistance);
	ctraSpyOptions_onClick(5, ctraSpyOptions.reagents);
	ctraSpyOptions_onClick(6, ctraSpyOptions.durability);
	ctraSpyOptions_onClick(7, ctraSpyOptions.items);
	
end

-- Handle clicks on the options form checkboxes
function ctraSpyOptions_onClick(id, checked)
	if (id == 1) then
		ctraSpyOptions.enabled = checked;
		getglobal("CTRA_SpyOptionsFrameEnableCB"):SetChecked(checked);
	elseif (id == 2) then
		ctraSpyOptions.sound = checked;
		getglobal("CTRA_SpyOptionsFramePlaySoundsCB"):SetChecked(checked); 
	elseif (id == 3) then
		ctraSpyOptions.chat = checked;
		getglobal("CTRA_SpyOptionsFrameShowChatCB"):SetChecked(checked);
	elseif (id == 4) then
		ctraSpyOptions.resistance = checked;
		getglobal("CTRA_SpyOptionsFrameResistancesCB"):SetChecked(checked);
	elseif (id == 5) then
		ctraSpyOptions.reagents = checked;
		getglobal("CTRA_SpyOptionsFrameReagentsCB"):SetChecked(checked);
	elseif (id == 6) then
		ctraSpyOptions.durability = checked;
		getglobal("CTRA_SpyOptionsFrameDurabilityCB"):SetChecked(checked);
	elseif (id == 7) then
		ctraSpyOptions.items = checked;
		getglobal("CTRA_SpyOptionsFrameItemsCB"):SetChecked(checked);
	end
end