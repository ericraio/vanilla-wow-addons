local dewdrop = DewdropLib:GetInstance('1.0')
local tablet = TabletLib:GetInstance('1.0')

--[[
EmoteFu
by Cilraaz of Cenarion Circle

Please note that this mod is a port of TitanEmoteMenu by Dsanai of Whisperwind.  Some of the functions are largely based
on that mod.  The entire emote list is also borrowed from TitanEmoteMenu.  So a huge thanks to Dsanai for even making 
this mod possible.

Also, a special thanks to chuckg from www.wowinterface.com.  Chuckg helped in straightening out a few problem areas in
my code, as well as pointing out the DoEmote API function, which was invalueable.

Welcome to EmoteFu!  This is a FuBar port of TitanEmoteMenu.  It is meant to give players an easily
accessible menu of emotes.  The emotes have been sorted by category (ie. "Friendly", "Hostile", etc) to make it quite
simple to quickly access the emote you want.  Emotes can end up in more than one category, where applicable (ie. /dance
can be found in "Happy" and "Affection").

Emotes in the list are colorized and marked with a label (A, V, AV) if they are Animated, Voice, or Both.

It is also possible to add your own custom emotes!  To do so, simply edit the EmoteData.lua file.  You will want to 
match the format exactly or that mod may no longer function!  If that occurs, just replace the EmoteData.lua with a good
copy from the zip.

Change Log:
v0.1.5 (TOC 11200)
-- Issue from v0.1.3 (gender handling) somehow occurred again in version 0.1.4, but this has now been corrected
v0.1.4 (TOC 11200)
-- Updated TOC
v0.1.3b (TOC 11100)
-- Re-upped the archive yet again. I added the directory structure to include a folder, so that the zip only needs unzipped into the AddOns folder, rather than the user needing to create a folder for it
v0.1.3a (TOC 11100)
-- Re-upped the archive as a ZIP file, rather than a RAR file. Sorry about that all!
v0.1.3 (TOC 11100)
-- Changed gender handling to fit Blizzard's new scheme (now 1=unknown, 2=male, 3=female...was 0=male, 1=female, 2=unknown)
-- Updated TOC
v0.1.2 (TOC 11000)
-- As per feature request 839, an option has been added to the menu labeled "Toggle Slash Commands". When selected, this will cause all emotes in the menus to be prefixed with their slash command. In the case of custom emotes, they will be prefixed with "Custom: ".
v0.1.1 (TOC 11000)
-- Fixed an issue with some emotes not working properly
-- Removed an unnecessary line from EmoteFuLocals.lua
-- Fixed one emote, which was showing as having neither an action or vocal, when in fact it had an action associated with it
-- Files changed: All
v0.1.0 (TOC 11000)
-- Initial Release

To do:
-- Add localization

]]

EmoteFu = FuBarPlugin:GetInstance("1.2"):new({
	name          = EmoteFuLocals.NAME,
	description   = EmoteFuLocals.DESCRIPTION,
	version       = "0.1.2",
	releaseDate   = "06-03-2006",
	aceCompatible = 103,
	fuCompatible  = 101,
	author        = "Cilraaz",
	email         = "Cilraaz@gmail.com",
	website       = "http://cilraaz.wowinterface.com/",
	category      = "others",
	db            = AceDatabase:new("EmoteFuDB"),
	cmd           = AceChatCmd:new(EmoteFuLocals.COMMANDS, EmoteFuLocals.CMD_OPTIONS),
	loc           = EmoteFuLocals,
	data          = EmoteData,
	hasIcon       = "Interface\\Icons\\Spell_Shadow_Charm",
	hasText 	  = "EmoteFu",
	cannotDetachTooltip = TRUE
	})
	
	EmoteFu.profileCode = true;
	
function EmoteFu:IsShowingSlashCommands()
	return self.data.showSlashCommand
end

function EmoteFu:ToggleShowingSlashCommands()
	self.data.showSlashCommand = not self.data.showSlashCommand
	if loud then
		self.cmd:status(self.loc.ARGUMENT_SLASH, self.data.showSlashCommand and 1 or 0, FuBarLocals.MAP_ONOFF)
	end
	return self.data.showSlashCommand
end
	
function EmoteFu:UpdateTooltip()
	local cat = tablet:AddCategory()
		cat:AddLine(
			"text", self.loc.LMBTEXT
		)
end

function EmoteFu:MenuSettings(level, value)
	if level == 1 then
	
		for k, v in EL_Types do
		    local elType = k;
		    local label = v;

		    dewdrop:AddLine(
			'text', label,
			'value', elType,
			'hasArrow', TRUE
		    )
		end
		
		dewdrop:AddLine()
		dewdrop:AddLine(
			'text', "Toggle Slash Commands",
			'arg1', self,
			'func', "ToggleShowingSlashCommands",
			'checked', self:IsShowingSlashCommands()
		)

	elseif level == 2 then

		local hasTarget = UnitName("target");
		local genderCode = UnitSex("player");
		local genderHe = nil;
		local genderHis = nil;
		local genderhe = nil;
		local genderhis = nil;
		if (genderCode==2) then -- male
			genderHe = "He";
			genderhe = "he";
			genderHis = "His";
			genderhis = "his";
		else -- female (we hope)
			genderHe = "She";
			genderhe = "she";
			genderHis = "Her";
			genderhis = "her";
		end

		for k2, v2 in EL_Emotes do
			for k3, v3 in v2.types do
				if (value == v3) then
					local info = nil;
					if (hasTarget) then
						info = self:GetOnDemandText(v2,true);
						info = string.gsub(info,"<Target>",hasTarget);
					else
						info = self:GetOnDemandText(v2,false);
					end
				
					info = string.gsub(info,"<He>",genderHe);
					info = string.gsub(info,"<His>",genderHis);
					info = string.gsub(info,"<he>",genderhe);
					info = string.gsub(info,"<his>",genderhis);
					
					for k4, v4 in v2.custom do
						if (v4 == 1) then
							slshCmd = "Custom:  ";
						else
							slshCmd = "/"..k2..":  ";
						end
					end

					if (self.data.showSlashCommand) then
						dewdrop:AddLine(
							'text', slshCmd..info,
							'level', 2,
							'arg1', k2,
							'func', function(k2)
								self:HandleModClick(k2)
							end,
							'closeWhenClicked', true
						)
					else
						dewdrop:AddLine(
							'text', info,
							'level', 2,
							'arg1', k2,
							'func', function(k2)
								self:HandleModClick(k2)
							end,
							'closeWhenClicked', true
						)
					end
				end		
			end
		end

	end
end

function EmoteFu:GetOnDemandText(v2,hasTarget)
	local color;
	local flag = nil;
	local returnCode;
	local emoteText;
	
	if (hasTarget) then emoteText = v2.target else emoteText = v2.none end
	
	if (EL_Types[v2["types"][1]] and EL_Types[v2["types"][1]]=="Custom") then
		emoteText = UnitName("player").." "..emoteText; -- custom emote
	end
	
	if (EL_React[v2.react] == "") then 		-- None (text only) White
		color = "fffefefe";
	elseif (EL_React[v2.react] == "A") then 	-- Animated - Purple
		color = "ffa335ee";
		flag = "A";
	elseif (EL_React[v2.react] == "V") then	-- Voice - Orange
		color = "ffff8000";
		flag = "V";
	elseif (EL_React[v2.react] == "AV") then -- Both - Green
		color = "ff1eff00";
		flag = "AV";
	else 										-- Grey (Unknown)
		color = "ff9d9d9d";
	end	

	returnCode = "|c" .. color .. emoteText .. FONT_COLOR_CODE_CLOSE;
	if (flag) then returnCode = returnCode.." ["..flag.."]"; end
	return returnCode;
end

function EmoteFu:HandleModClick(k2)
	if (k2) then
		if (EL_Types[EL_Emotes[k2]["types"][1]] and EL_Types[EL_Emotes[k2]["types"][1]]=="Custom") then -- Custom emote
			local emoteText;
			local hasTarget = UnitName("target");
			local genderCode = UnitSex("player");
			local genderHe = nil;
			local genderHis = nil;
			local genderhe = nil;
			local genderhis = nil;
			if (genderCode==2) then -- male
				genderHe = "He";
				genderhe = "he";
				genderHis = "His";
				genderhis = "his";
			else -- female (we hope)
				genderHe = "She";
				genderhe = "she";
				genderHis = "Her";
				genderhis = "her";
			end
			
			if (hasTarget) then
				emoteText = EL_Emotes[k2].target;
				emoteText = string.gsub(emoteText,"<Target>",hasTarget);
			else
				emoteText = EL_Emotes[k2].none;
			end
			emoteText = string.gsub(emoteText,"<He>",genderHe);
			emoteText = string.gsub(emoteText,"<His>",genderHis);
			emoteText = string.gsub(emoteText,"<he>",genderhe);
			emoteText = string.gsub(emoteText,"<his>",genderhis);

			SendChatMessage(emoteText,"EMOTE");
		else
			emoteToken = string.upper(k2);
			if (emoteToken == "LAVISH") then
				emoteToken = "PRAISE";
			end
			if (emoteToken == "EXCITED") then
				emoteToken = "TALKEX";
			end
			if (emoteToken == "DOOM") then
				emoteToken = "THREATEN";
			end
			if (emoteToken == "SILLY") then
				emoteToken = "JOKE";
			end
			if (emoteToken == "LAY") then
				emoteToken = "LAYDOWN";
			end
			if (emoteToken == "REAR") then
				emoteToken = "SHAKE";
			end
			if (emoteToken == "BELCH") then
				emoteToken = "BURP";
			end
			if (emoteToken == "SMELL") then
				emoteToken = "STINK";
			end
			if (emoteToken == "GOODBYE") then
				emoteToken = "BYE";
			end
			if (emoteToken == "FOLLOWME") then
				emoteToken = "FOLLOW";
			end
			if (emoteToken == "ATTACKTARGET") then
				emoteToken = "ATTACKMYTARGET";
			end
			if (emoteToken == "CONGRATS") then
				emoteToken = "CONGRATULATE";
			end
			if (emoteToken == "PUZZLED") then
				emoteToken = "PUZZLE";
			end
			if (emoteToken == "QUESTION") then
				emoteToken = "TALKQ";
			end
			DoEmote(emoteToken);
		end
	end
end
	
EmoteFu:RegisterForLoad()
