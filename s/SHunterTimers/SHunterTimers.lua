--[[ 
Hunter Timers, by Sorren of Bleeding Hollow (versions up to 1.2)
Version 1.6.11 (by Kharthus of Deathwing)

v1.6.11
	-Added Spanish translation (thanks Geran)
	-Fixed issues with bar/frame fading and transparency
	-Added oCB support
v1.6.10
	-Fixed French trap messages
	-Fixed traptimemult nil issues
	-Cleanup code for freezing/immolation trap resists
v1.6.9
	-Fixed French flare translation
	-Allowed eCastingBar/otravi to be used with all other HUDs
v1.6.8
	-Fixed another German typo
	-Allowed ArcHUD2 and eCastingBar to work at the same time
v1.6.7
	-Fixed German trap messages
v1.6.6
	-Added MetaHud support
v1.6.5
	-Better fix for Clever Traps
	-Added otravi_CastingBar support
v1.6.4
	-Fixed Clever Traps talent detection
v1.6.3
	-Added ArcHUD2 support (thanks to Mapelli0)
	-Added Nurfed support
	-Added Bongos support
	-Added Perl Arcane Bar support
	-Cleaned up CastTime and eCastingBar support
	-Localization updates for all languages
v1.6.2
	-GUI cleanup
	-Added checkbox for bar growth up/down
v1.6.1
	-Fixes for ZHM and Devilsaur Eye
	-Reset function correctly resets any active spells
	-Cleaned up lua tables for future lua versions (5.1)
v1.6.0
	-Added Berserking (thanks to AxelRod for the equation)
	-Added Devilsaur Eye
	-Added Zandalarian Hero Medallion
	-Added Earthstrike
	-Added Badge of the Swarmguard
	-Added Kiss of the Spider
v1.5.7
	-Added Jom Gabbar
v1.5.6
	-Updated toc for patch 1.12
v1.5.5
	-Added Simple and Traditional Chinese translations
	-Escape key will now close the options screen
	-Added command line option to clear settings
v1.5.4
	-Fixed bug with Aimed Shot timer when Rapid Fire/Quick Shots bars were disabled
	-Fixed Rapid Fire length when 2-piece CS bonus is active
	-Added Gluth to Frenzy list
v1.5.3
	-Default localization is now enUS (previously only loaded if actually in enUS)
	-Fixed spell misses
v1.5.2
	-Added French translation for Hunter's Mark
	-Fixed mob name parsing
v1.5.1
	-Restricted loading to only hunters
	-Fixed Aimed Shot cast timer
v1.5
	-Added auto shot timer (thanks to Sorren for the hard part)
	-Added Apply button to options screen
	-Cleaned up button XML for 1.11 patch
	-Major GUI/code cleanup
v1.4.2
	-Fixed Feign Death/Trap macros
	-Fixed Aimed Shot timer resetting
v1.4.1
	-Added a few German translations
v1.4
	-Added Hunter's Mark
	-Added Primal Blessing
	-Added Entrapment
	-Fixed Clever Traps being incorrectly applied to all traps
	-Fixed target name with Concussive Shot
v1.3.3
	-Fixed Intimidation (really)
v1.3.2
	-Fixed Intimidation
v1.3.1
	-Fixed German death message translation
	-Optimized UNIT_AURA event handling
v1.3
	-Fixes for 1.10 tooltips
	-Increased duration on Quick Shots
	-Added Expose Weakness
	-Added Princess Huhuran to frenzy list
	-Quick Shots will now properly refresh when you regain it during the buff
	-Fixed bug with Imp Wing Clip expiring that was clearing Wing Clip
	-Fixed Imp Concussive Shot
v1.2
	-Added icons
	-Added a switch to append the name
	-Dynamic resizing to account for the name space
	-Added opacities
	-Added the ability to change the border opacity/color
	-Added the ability to change text colors
	-Added even more options, look for yourself
	-Moved some of the variables I had in localization to globals. These are mostly arrays that contain localised variables, so don't worry about them.
	-Should properly auto-cascade now.
v1.1a
	-Fixed a trap error, thanks Malathis
	-Added an option to reset the position of the bars to the center of the screen
v1.1
	-Thank you Flimflam for helping me out.
	-Added per target debuffs! Stings etc. will now be added per target, mouseover a bar to see the target
	-Added support for fear beast
	-Fixed a bug with scatter shot
	-Quick shots will now properly refresh when you regain it during the buff
v1.0d
	-The survival tree continues to mock me.
v1.0c
	-Broke improved wingclip while trying to make it localisable, fixed
	-Broke improved concussive while trying to make it localisable, fixed
v1.0b
	-Deterrence is 10 seconds. weee.
	-I broke the slash commands by accident. Fixed.
v1.0a
	-Fixed Scorpid Sting
	-ALL macros should now work!
	-Fixed an issue with CT_mods casting bar
v1.0
	-New Shiny gui configuration!
	-Fixed a crapton of bugs
	-Should now detect macros and casts from the spellbook
	-Should no longer explode during frenzy
	-You can now turn stuff on and off
	-You can now specify the precision of the time
	-You can now change the spacing between the bars
	-Fixed conflict with nurfed casting bar(hopefully discord too)
v0.3
	-Diminshing returns theoretically works!
	-Fixed an issue with scaling
	-Wyvern sting works in theory, couldn't find anyone to test
v0.2a
	-Fixed some action bar issues
v0.2
	-Fixed more bugs
	-Added color changing
	-Added flashing when the timer is about to expire
	-updated the slash commands
v0.1g
	-Fixed a bunch of bugs
	-Can now have it grow up or down
	-Can now lock/unlock
v0.1f
	-Scaling through /sht scale 0-100 (100 being 100%)
	-Detect trap resists
	-can now set an extra delay on the aimed shot casting(for those of us who lag a bit) via /sht delay ## where # is miliseconds.
	-Fix some minor bugs
v0.1d
	-Imp. Wing Clip
	-Imp. Conc shot
	-Counterattack
	-various bugs
	-minor fade detection
v0.1c fixed Bestial wrath, fixed conflict with CastingTimeBar
	-Added quick shots
	-added rapid fire
	-made both affect aimed shot cast time
v0.1b fixed an conflict with CT_RaidTracker
v0.1a fixed an error with concussive shot
v0.1 initial release

--]]

local checkForTargetDeath = 0;
local checkForTarget = nil;
local checkForSpell = 0;
local targetDebuffs = {};
local playerBuffs = {};
local checkForSpellFail = nil;
local checkForSpellName = nil;
local trapTimer = nil;
local dimin = {};
local shtautoshot = false;
local shttimeleft = nil;
local shtcasting = false;
local shtautotime = 0;
local autodelta = 0;
local shtdebug = false;
local currentHealth = nil;
local maxHealth = nil;
local percentHealth = nil;
local berserkValue = nil;

function SHunterTimers_OnLoad()
	local playerClass, englishClass = UnitClass("player");
	if(englishClass ~= "HUNTER") then
		return;
	end
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("SPELLS_CHANGED");
	this:RegisterEvent("CHARACTER_POINTS_CHANGED");
	this:RegisterEvent("PLAYER_ALIVE");
	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_PET_DAMAGE");
	this:RegisterEvent("CHAT_MSG_MONSTER_EMOTE");
	this:RegisterEvent("START_AUTOREPEAT_SPELL");
	this:RegisterEvent("STOP_AUTOREPEAT_SPELL");
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("SPELLCAST_FAILED");
	--this:RegisterEvent("SPELLCAST_INTERRUPTED");
	--this:RegisterAllEvents(); 
	
	tinsert(UISpecialFrames,"SHunterTimersOptions");
	
	if(DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("Sorren's Hunter Timers "..SHT_VERSION.." Loaded", 1, 0, 0 );
	end
	
	SlashCmdList["SHUNTERTIMERS"] = function (msg)
		SHunterTimers_SlashCmd(msg);
	end
	SLASH_SHUNTERTIMERS1 = "/shuntertimers";
	SLASH_SHUNTERTIMERS2 = "/sht";
	
	targetDebuffs["numDebuffs"] = 0;
	playerBuffs["numBuffs"] = 0;

end

function SHunterTimers_SlashCmd(msg)
	if( msg == "showvars" ) then
		if( SHTvars["exposeweak"] ) then
			DEFAULT_CHAT_FRAME:AddMessage("exposeweak", 1, 0, 0 );
		else
			DEFAULT_CHAT_FRAME:AddMessage("exposeweak "..SHT_OFF, 1, 0, 0 );
		end
		return;
	elseif( msg == "menu" ) then
		SHunterTimers_ShowOptions();
		return;
	elseif( msg == "reset" ) then
		for num = 1, 11, 1 do
			frame = getglobal("SHunterTimersStatus"..num);
			frame.endTime = 0;
		end
		SHunterTimers_ClearActiveSpells();
		return;
	elseif( msg == "clear all" ) then
		SHunterTimers_ResetOptions();
		DEFAULT_CHAT_FRAME:AddMessage("SHT options reset to defaults.", 1, 0, 0);
		return;
	elseif( msg == "debug" ) then
		if ( shtdebug ) then
			shtdebug = false;
			DEFAULT_CHAT_FRAME:AddMessage("SHT debugging mode disabled.", 1, 0, 0);
		else
			shtdebug = true;
			DEFAULT_CHAT_FRAME:AddMessage("SHT debugging mode enabled.", 1, 0, 0);
		end
		return;
	elseif( msg == SHT_ON ) then
		if( SHTvars[SHT_ON] ) then
			DEFAULT_CHAT_FRAME:AddMessage("SHT already "..SHT_ON, 1, 0, 0);
			return;
		else
			UseAction = SHunterTimers_OnUseAction;
			CastSpellByName = SHunterTimers_OnCastSpellByName;
			CastSpell = SHunterTimers_OnCastSpell;
			SHTvars[SHT_ON] = true;
			DEFAULT_CHAT_FRAME:AddMessage("SHT "..SHT_ON, 1, 0, 0);
			return;
		end
	elseif( msg == SHT_OFF ) then
		if( SHTvars[SHT_ON] ) then
			UseAction = SHunterTimers_Real_UseAction;
			CastSpellByName = SHunterTimers_Real_CastSpellByName;
			CastSpell = SHunterTimers_Real_CastSpell;
			SHTvars[SHT_ON] = false;
			DEFAULT_CHAT_FRAME:AddMessage("SHT "..SHT_OFF, 1, 0, 0);
			return;
		else
			DEFAULT_CHAT_FRAME:AddMessage("SHT not "..SHT_ON, 1, 0, 0);
			return;
		end
	elseif( string.find( msg, "setbgcolor" ) ) then
		for r, g, b, a in string.gfind( msg, "setcolor (%d+) (%d+) (%d+) (%d+)" ) do
			SHTvars["bg"].r = r/10;
			SHTvars["bg"].g = g/10;
			SHTvars["bg"].b = b/10;
			SHTvars["bg"].a = a/10;
			SHunterTimersFrame:SetBackdropColor( r/10, g/10, b/10, a/10 );
		end
		return;
	elseif( string.find( msg, "aimed" ) )then
		if( string.find(msg, SHT_ON ) )then
			SHTvars["skills"][SHT_AIMED_SHOT] = true;
			DEFAULT_CHAT_FRAME:AddMessage("SHT: Aimed Shot Casting Bar "..SHT_ON);
		elseif( string.find( msg, SHT_OFF ) ) then
			SHTvars["skills"][SHT_AIMED_SHOT] = false;
			DEFAULT_CHAT_FRAME:AddMessage("SHT: Aimed Shot Casting Bar "..SHT_OFF);
		else
			if( SHTvars["skills"][SHT_AIMED_SHOT] ) then
				SHTvars["skills"][SHT_AIMED_SHOT] = false;
				DEFAULT_CHAT_FRAME:AddMessage("SHT: Aimed Shot Casting Bar "..SHT_OFF);
			else
				SHTvars["skills"][SHT_AIMED_SHOT] = true;
				DEFAULT_CHAT_FRAME:AddMessage("SHT: Aimed Shot Casting Bar "..SHT_ON);
			end
		end
	elseif( string.find(msg, "aimeddelay" ) ) then
		for ms in string.gfind(msg, "aimeddelay (%d+)") do
			SHTvars["aimeddelay"] = ms;
			DEFAULT_CHAT_FRAME:AddMessage("Aimed delay set to "..ms.."ms");
		end
	elseif( string.find(msg, "delay" ) ) then
		for ms in string.gfind(msg, "delay (%d+)") do
			SHTvars["shotdelay"] = ms;
			DEFAULT_CHAT_FRAME:AddMessage("Shot delay set to "..ms.."ms");
		end
	elseif( string.find(msg, "scale" ) ) then
		for scale in string.gfind( msg, "scale (%d+)" ) do
			if( (scale/100) < 0.1 ) then
				scale = 10;
			end
			scale = scale * UIParent:GetScale();
			SHTvars["scale"] = scale/100;
		end
		SHunterTimersFrame:SetScale( SHTvars["scale"] );
		for i=1, 11 do
			getglobal("SHunterTimersStatus"..i):SetScale( SHTvars["scale"] );
		end
	elseif( string.find(msg, "down") ) then
		SHTvars["down"] = true;
		SHunterTimersFrame:ClearAllPoints();
		SHunterTimersFrame:SetPoint( "TOPLEFT", "SHunterTimersAnchor", "BOTTOMRIGHT" );
		DEFAULT_CHAT_FRAME:AddMessage("SHT: Growing down");
	elseif( string.find(msg, "up" ) ) then
		SHTvars["down"] = false;
		SHunterTimersFrame:ClearAllPoints();
		SHunterTimersFrame:SetPoint( "BOTTOMLEFT", "SHunterTimersAnchor", "TOPRIGHT" );
		DEFAULT_CHAT_FRAME:AddMessage("SHT: Growing up");
	elseif( msg == "unlock" ) then
		SHTvars["locked"] = false;
		SHunterTimersAnchor:Show();
	elseif( msg == "lock" ) then
		SHTvars["locked"] = true;
		SHunterTimersAnchor:Hide();
	elseif( string.find(msg, "colorchange" ) ) then
		for on in string.gfind(msg, "colorchange (%a+)") do
			if( on == SHT_ON ) then
				SHTvars["colorchange"] = true;
			elseif( on == SHT_OFF ) then
				SHTvars["colorchange"] = false;
			end
			if( on == SHT_ON) or ( on == SHT_OFF ) then
				DEFAULT_CHAT_FRAME:AddMessage( "SHT: Colorchange is: "..on);
			end
		end
	elseif( string.find( msg, "barcolor" ) ) then
		for r, g, b in string.gfind(msg, "barcolor ([%d.]+) ([%d.]+) ([%d.]+)") do
			local red, green, blue = unpack( SHTvars["barstartcolor"] );
			SHTvars["barstartcolor"][1] = r;
			SHTvars["barstartcolor"][2] = g;
			SHTvars["barstartcolor"][3] = b;
			
			local rd, gd, bd = unpack( SHTvars["bardelta"] );
			red = rd + red;
			blue = bd + blue;
			green = gd + green;
			
			red = red - r;
			green = green - g;
			blue = blue - b;
			
			SHTvars["bardelta"][1] = red;
			SHTvars["bardelta"][2] = green;
			SHTvars["bardelta"][3] = blue;
			DEFAULT_CHAT_FRAME:AddMessage( "SHT: Barcolor set to: "..SHTColor(r, g, b)..r..", "..g..", "..b.."|r");
		end
	elseif( string.find( msg, "barendcolor" ) ) then
		for red, green, blue in string.gfind(msg, "barendcolor ([%d.]+) ([%d.]+) ([%d.]+)") do
			local r, g, b = unpack( SHTvars["barstartcolor"] );
			
			r = red - r;
			g = green - g;
			b = blue - b;
			
			SHTvars["bardelta"][1] = r;
			SHTvars["bardelta"][2] = g;
			SHTvars["bardelta"][3] = b;
			DEFAULT_CHAT_FRAME:AddMessage( "SHT: Barendcolor set to: "..SHTColor(red, green, blue)..red..", "..green..", "..blue.."|r");
		end
	elseif( string.find( msg, "flash" ) ) then
		for flash in string.gfind( msg, "flash (%d+)" ) do
			flash = flash * 1;
			SHTvars["flash"] = flash;
			if( flash == 0 ) then
				DEFAULT_CHAT_FRAME:AddMessage("SHT: Bar flash "..SHT_OFF);
			else
				DEFAULT_CHAT_FRAME:AddMessage("SHT: Bar flash set to: "..flash.." seconds");
			end
		end
	elseif( string.find( msg, "step" ) ) then
		for step in string.gfind( msg, "step ([%d.]+)" ) do
			SHTvars["step"] = step
			DEFAULT_CHAT_FRAME:AddMessage("SHT: Step set to: "..step);
		end
	elseif( msg == "resetpos" ) then
		SHunterTimersAnchor:ClearAllPoints();
		SHunterTimersAnchor:SetPoint("CENTER", "UIParent", "CENTER", 0, 0 );
	elseif( string.find( msg, "(%a+) (%d+)" ) ) then
		for cmd1, cmd2 in string.gfind( msg, "(%a+) (%d+)" ) do
			--DEFAULT_CHAT_FRAME:AddMessage(cmd1.."-"..cmd2, 1, 0, 0);
			SHunterTimersFrame_add( cmd2, cmd1 );
		end
	elseif( msg == "status" ) then

		local statusstring = "";
		local statusstring1 = "";
		local statusstring2 = "";
		
		if( SHTvars[SHT_ON] ) then
			statusstring1 = SHT_ON;
		else
			statusstring1 = SHT_OFF;
		end
		if( SHTvars["skills"][SHT_AIMED_SHOT] ) then
			statusstring2 = SHT_ON;
		else
			statusstring2 = SHT_OFF;
		end
		DEFAULT_CHAT_FRAME:AddMessage(SHT_STATUS_STRINGS[1]);
		DEFAULT_CHAT_FRAME:AddMessage(format(SHT_STATUS_STRINGS[2], statusstring1, statusstring2));
		DEFAULT_CHAT_FRAME:AddMessage(format(SHT_STATUS_STRINGS[3], SHTvars["shotdelay"], SHTvars["aimeddelay"]));
		DEFAULT_CHAT_FRAME:AddMessage(format(SHT_STATUS_STRINGS[4], SHTvars["flash"], SHTvars["step"]));

		local r, g, b = unpack( SHTvars["barstartcolor"] );
		local rd, gd, bd = unpack( SHTvars["bardelta"] );
		statusstring1 = SHTColor(r,g,b)..r..", "..g..", "..b.."|r";
		statusstring2 = SHTColor(r+rd, g+gd, b+bd)..(r+rd)..", "..(b+bd)..", "..(g+gd).."|r";
		DEFAULT_CHAT_FRAME:AddMessage(format(SHT_STATUS_STRINGS[5], statusstring1, statusstring2));
		
		if( SHTvars["colorchange"] ) then
			statusstring1 = SHT_ON;
		else
			statusstring1 = SHT_OFF;
		end
		if( SHTvars["down"] ) then
			statusstring2 = "down";
		else
			statusstring2 = "up";
		end
		DEFAULT_CHAT_FRAME:AddMessage(format(SHT_STATUS_STRINGS[6], statusstring1, statusstring2));
		DEFAULT_CHAT_FRAME:AddMessage(format(SHT_STATUS_STRINGS[7], (SHTvars["scale"]/UIParent:GetScale()*100) ) );
	else
		for key,val in pairs(SHT_SLASH_HELP) do
			DEFAULT_CHAT_FRAME:AddMessage(val, 1, 1, 0);
		end
	end
	
end

function SHunterTimersFrame_add( spellDuration, spellName, target )
	if( SHTvars["numBars"] < 0 ) then
		SHTvars["numBars"] = 0;
	end
	
	local allReadyActive = false;
	local bar;
	
	if( SHT_sfind( spellName, SHT_STING ) or string.find( spellName, SHT_CONC_SHOT ) ) then
		spellDuration = spellDuration + SHTvars["shotdelay"];
	end
	
	if( spellName == SHT_INTIM ) then
		--DEFAULT_CHAT_FRAME:AddMessage("Intim", 1, 1, 0 );
		if( SHTvars["petIntim"] ) then
			--DEFAULT_CHAT_FRAME:AddMessage("Pet Intim", 1, 1, 0 );
			for num = 1, SHTvars["numBars"], 1 do
				local barframe = getglobal("SHunterTimersStatus"..num);
				local textBar = getglobal("SHunterTimersStatus"..num.."BarLeftText"):GetText();
				--DEFAULT_CHAT_FRAME:AddMessage("Intim: "..textBar, 1, 1, 0 );
				if( string.find( textBar, SHT_PET_INTIM ) ) then
					--barframe.endTime = 0;
					allReadyActive = true;
					bar = num;
					break;
				end
			end
		end
	elseif( string.find( spellName, SHT_PRIMED ) ) then
		if( trapTimer ) then
			for num = 1, SHTvars["numBars"], 1 do
				local textBar = getglobal("SHunterTimersStatus"..num.."BarLeftText"):GetText();
				--DEFAULT_CHAT_FRAME:AddMessage("Intim: "..textBar, 1, 1, 0 );
				if( string.find(textBar, SHT_PRIMED ) ) then
					allReadyActive = true;
					bar = num;
					break;
				end
			end
		end
	elseif( SHT_sfind( spellName, SHT_STING ) ) then
		for num = 1, SHTvars["numBars"] do
			local barframe = getglobal("SHunterTimersStatus"..num);
			if( SHT_sfind( barframe.spell, SHT_STING ) and ( barframe.target == target ) ) then
				allReadyActive = true;
				bar = num;
				break;
			end
		end
	elseif( SHT_sfind( spellName, SHT_HUNTERS_MARK ) ) then
		for num = 1, SHTvars["numBars"] do
			local barframe = getglobal("SHunterTimersStatus"..num);
			if( SHT_sfind( barframe.spell, SHT_HUNTERS_MARK ) ) then
				allReadyActive = true;
				bar = num;
				break;
			end
		end
	elseif( spellName == SHT_AUTO_SHOT ) and SHTvars["sticky"]  then
		if( SHunterTimersStatus1.spell == SHT_AUTO_SHOT ) then
			allReadyActive = true;
			bar = 1;
		else
			SHunterTimers_shift(1);
			allReadyActive = true;
			SHTvars["numBars"] = SHTvars["numBars"] + 1;
			bar = 1;
		end
	elseif( not string.find( spellName, SHT_FLARE ) ) then
		for num = 1, SHTvars["numBars"], 1 do
			local barframe = getglobal("SHunterTimersStatus"..num);
			if( barframe.spell == spellName ) and (barframe.target == target)then
				allReadyActive = true;
				bar = num;
				break;
			end
		end
	end
	
	local num = bar;
	if( allReadyActive ) then
		if( SHTvars["numBars"] == 0 ) then
			SHTvars["numBars"] = 1;
		end
	else
		if( SHTvars["numBars"] == 11 ) then
			return;
		end
		SHTvars["numBars"] = SHTvars["numBars"] + 1;
		num = SHTvars["numBars"];
	end
	
	local icon = getglobal("SHunterTimersStatus"..num.."Icon");
	local barframe = getglobal("SHunterTimersStatus"..num);
	local bar = getglobal("SHunterTimersStatus"..num.."Bar");
	local leftText = getglobal("SHunterTimersStatus"..num.."BarLeftText");
	local rightText = getglobal("SHunterTimersStatus"..num.."BarRightText");
	
	if( not barframe ) then
		--DEFAULT_CHAT_FRAME:AddMessage("WTFBBQ line 214");
		return;
	end
	local texture;
	if( spellName == SHT_IMP_CONC_SHORT ) then
		texture = SHTvars["textures"][SHT_CONC_SHOT];
	elseif( spellName == SHT_IMP_WC_SHORT ) then
		texture = SHTvars["textures"][SHT_WING_CLIP];
	elseif( string.find( spellName, SHT_TRAP ) ) then
		if( string.find( spellName, SHT_FREEZING_TRAP ) )then
			texture = SHTvars["textures"][SHT_FREEZING_TRAP]
		elseif( string.find( spellName, SHT_IMMO_TRAP ) ) then
			texture = SHTvars["textures"][SHT_IMMO_TRAP]
		elseif( string.find( spellName, SHT_FROST_TRAP ) ) then
			texture = SHTvars["textures"][SHT_FROST_TRAP]
		elseif( string.find( spellName, SHT_EXPL_TRAP ) ) then
			texture = SHTvars["textures"][SHT_EXPL_TRAP]
		end
	elseif( string.find( spellName, SHT_PET_INTIM ) ) then
		texture = SHTvars["textures"][SHT_INTIM];
	elseif( spellName == SHT_AUTO_SHOT ) then
		texture = GetInventoryItemTexture("player", 18);
	else
		texture = SHTvars["textures"][spellName];
	end
	icon:SetTexture(texture);
	barframe.spell = spellName;
	barframe.texture = texture;
	barframe.target = target;
	barframe.startTime = GetTime();
	barframe.duration = spellDuration / 1000;
	barframe.endTime = barframe.startTime + barframe.duration;
	bar:SetMinMaxValues(barframe.startTime, barframe.endTime);
	bar:SetValue( barframe.endTime );
	local spellText = SHTColor(unpack(SHTvars["skillcolor"]))..spellName;
	if( SHTvars["append"] ) and (barframe.target) then
		spellText = spellText.."|r - "..SHTColor(unpack(SHTvars["targetcolor"]))..barframe.target;
	end
	leftText:SetText( spellText );
	local text;
	if( SHTvars["mili"] == 0 ) then
		text = string.format( SHTColor(unpack(SHTvars["timecolor"])).."%ds", barframe.duration );
	else
		text = string.format( SHTColor(unpack(SHTvars["timecolor"])).."%."..SHTvars["mili"].."f", barframe.duration );
	end
	rightText:SetText( text );
	barframe.channeling = true;
	barframe.fadeOut = false;
	SHunterTimersFrame:SetAlpha(SHTvars["overallalpha"]);
	SHT_SetHeight();
	if( not SHunterTimersFrame:IsVisible() ) then
		SHunterTimersFrame:Show();
	end
	local r, g, b, a = unpack( SHTvars["barstartcolor"] );
	bar:SetStatusBarColor(r, g, b, a );
	getglobal("SHunterTimersStatus"..num.."BGBar"):SetStatusBarColor(r, g, b, 0.25*a);
	barframe:SetAlpha(SHTvars["overallalpha"]);
	SHunterTimers_SetWidths();
	barframe:Show();
end

function SHunterTimers_SetWidths()	
	local largestwidth = 180;
	if( SHTvars["showtex"] ) then
		if( SHTvars["largetex"] ) and (SHTvars["barheight"] < 16 ) then
			largestwidth = largestwidth - 16;
		else
			largestwidth = largestwidth - SHTvars["barheight"];
		end
		if( SHTvars["gap"] ) then
			largestwidth = largestwidth - 5;
		end
	end
	local tarwidth = largestwidth;
	local extrawidth = 0;
	for i=1, SHTvars["numBars"] do
		local width = getglobal("SHunterTimersStatus"..i.."BarLeftText"):GetWidth() + getglobal("SHunterTimersStatus"..i.."BarRightText"):GetWidth();
		if( width > largestwidth ) then
			largestwidth = width;
		end
	end
	if( largestwidth > tarwidth ) and (not SHTvars["hidetext"]) then
		largestwidth = largestwidth + 40;
		if( SHTvars["showtex"] ) then
			extrawidth = SHTvars["barheight"];
			if( SHTvars["largetex"] ) and ( SHTvars["barheight"] < 16 ) then
				extrawidth = 16;
			end
			if( SHTvars["gap"] ) then
				extrawidth = extrawidth + 5;
			end
		end
		for i=1, SHTvars["numBars"] do
			getglobal("SHunterTimersStatus"..i):SetWidth(largestwidth + extrawidth);
			getglobal("SHunterTimersStatus"..i.."Bar"):SetWidth(largestwidth);
			getglobal("SHunterTimersStatus"..i.."BGBar"):SetWidth(largestwidth);
		end
		if( SHTvars["padding"] ) then
			SHunterTimersFrame:SetWidth(largestwidth + extrawidth + 20);
		else
			SHunterTimersFrame:SetWidth(largestwidth + extrawidth + 10);
		end
	else
		if( SHTvars["padding"] ) then
			SHunterTimersFrame:SetWidth( 240 );
		else
			SHunterTimersFrame:SetWidth( 230 );
		end
		local width = 220;
		if( SHTvars["showtex"] ) then
			if( SHTvars["largetex"] ) and ( SHTvars["barheight"] < 16) then
				width = width - 16;
			else
				width = width - SHTvars["barheight"];
			end
			if( SHTvars["gap"] ) then
				width = width - 5;
			end
		end
		for i=1, SHTvars["numBars"] do
			getglobal("SHunterTimersStatus"..i):SetWidth(220);
			getglobal("SHunterTimersStatus"..i.."Bar"):SetWidth(width);
			getglobal("SHunterTimersStatus"..i.."BGBar"):SetWidth(width);
		end
	end
end
			
			

function SHunterTimers_OnUpdateBar( id )
	if( not SHunterTimersFrame:IsVisible() ) then
		SHunterTimersFrame:Show();
	end
	local barframe = getglobal("SHunterTimersStatus"..id);
	if( barframe.channeling ) then
		local time = GetTime();
		local bartext = getglobal( "SHunterTimersStatus"..id.."BarRightText");
		local text = barframe.spell;

		if( barframe.spell == SHT_AUTO_SHOT ) then
			if(( not shtautoshot ) or ( shtcasting )) and ( not barframe.movetime ) and ( (barframe.endTime - time) <= 0.7 ) then
				barframe.movetime = time;
				--DEFAULT_CHAT_FRAME:AddMessage("1 d");
			elseif( barframe.movetime ) and (( shtautoshot ) and ( not shtcasting )) then
				local deltaTime = time - barframe.movetime;
				--DEFAULT_CHAT_FRAME:AddMessage("2 d");
				--DEFAULT_CHAT_FRAME:AddMessage(barframe.endTime.." "..deltaTime.." "..barframe.movetime);
				barframe.startTime = barframe.startTime + deltaTime;
				barframe.endTime = barframe.endTime + deltaTime;
				getglobal("SHunterTimersStatus"..id.."Bar"):SetMinMaxValues(barframe.startTime, barframe.endTime);
				barframe:SetAlpha(SHTvars["overallalpha"]);
				barframe.movetime = nil;
			elseif(( not shtautoshot ) or ( shtcasting )) and ( barframe.movetime ) then
				if( time - barframe.movetime) > 7 then
					barframe.channeling = false;
					barframe.fadeOut = true;
					barframe.movetime = nil;
				elseif( time - barframe.movetime ) > 4 then
					local alpha = barframe:GetAlpha() - SHTvars["step"];
					if( alpha > (0.3*SHTvars["overallalpha"]) ) then
						barframe:SetAlpha(alpha);
					end
				end					
				return;
			end
		end
		
		if( time >= barframe.endTime ) then
			if( barframe.spell == SHT_AUTO_SHOT ) then
				return;
			end
			barframe.channeling = false;
			barframe.fadeOut = true;
			barframe.step = 0;
			barframe.target = nil;
			bartext:SetText( SHT_DONE );
			if( SHTvars["concuss"] ) and ( text == SHT_CONC_SHOT ) then
				SHTvars["concuss"] = false;
			elseif( SHTvars["impconc"] ) and ( text == SHT_IMP_CONC_SHORT ) then
				SHTvars["impconc"] = false;
			elseif( SHTvars["rapid"] ) and ( text == SHT_RAPID_FIRE ) then
				SHTvars["rapid"] = false;
			elseif( SHTvars["quick"] ) and ( text == SHT_QUICK_SHOTS ) then
				SHTvars["quick"] = false;
			elseif( SHTvars["petIntim"] ) and ( text == SHT_PET_INTIM ) then
				SHTvars["petIntim"] = false;
			elseif( SHTvars["intimidate"] ) and ( text == SHT_INTIM ) then
				SHTvars["intimidate"] = false;
			elseif( SHTvars["deterrence"] ) and ( text == SHT_DETERRENCE ) then
				SHTvars["deterrence"] = false;
			elseif( trapTimer ) and string.find( text, SHT_PRIMED ) then
				trapTimer = false;
			elseif( SHTvars["wingclip"] ) and ( text == SHT_WING_CLIP ) then
				SHTvars["wingclip"] = false;
			elseif( SHTvars["impwing"] ) and ( text == SHT_IMP_WC_SHORT ) then
				SHTvars["impwing"] = false;
			elseif( SHTvars["freezing"] ) and ( text == SHT_FREEZING_TRAP ) then
				SHTvars["freezing"] = false;
			elseif( SHTvars["scatter"] ) and ( text == SHT_SCATTER ) then
				SHTvars["scatter"] = false;
			elseif( SHTvars["wyvern"] ) and ( text == SHT_WYVERN_TEXT ) then
				SHTvars["wyvern"] = false;
			elseif( SHTvars["fearbeast"] ) and ( text == SHT_FEAR_BEAST ) then
				SHTvars["fearbeast"] = false;
			elseif( SHTvars["exposeweak"] ) and ( text == SHT_EXPOSE_WEAKNESS ) then
				SHTvars["exposeweak"] = false;
			elseif( SHTvars["huntersmark"] ) and ( text == SHT_HUNTERS_MARK ) then
				SHTvars["huntersmark"] = false;
			elseif( SHTvars["primalblessing"] ) and ( text == SHT_PRIMAL_BLESSING ) then
				SHTvars["primalblessing"] = false;
			elseif( SHTvars["entrapment"] ) and ( text == SHT_ENTRAPMENT ) then
				SHTvars["entrapment"] = false;
			elseif( SHTvars["berserking"] ) and ( text == SHT_BERSERKING ) then
				SHTvars["berserking"] = false;
			elseif( SHTvars["devilsaur"] ) and ( text == SHT_DEVILSAUR ) then
				SHTvars["devilsaur"] = false;
			elseif( SHTvars["zhm"] ) and ( text == SHT_ZHM ) then
				SHTvars["zhm"] = false;
			elseif( SHTvars["earthstrike"] ) and ( text == SHT_EARTHSTRIKE ) then
				SHTvars["earthstrike"] = false;
			elseif( SHTvars["swarmguard"] ) and ( text == SHT_SWARMGUARD ) then
				SHTvars["swarmguard"] = false;
			elseif( SHTvars["jomgabbar"] ) and ( text == SHT_JOM_GABBAR ) then
				SHTvars["jomgabbar"] = false;
			elseif( SHTvars["spider"] ) and ( text == SHT_KISS_SPIDER ) then
				SHTvars["spider"] = false;
			end
			return;
		elseif ( SHTvars["quick"] and text == SHT_QUICK_SHOTS and SHTvars["skills"][SHT_QUICK_SHOTS] ) then
			local i = 1;
			while( UnitBuff("player", i ) ) do
				local time = GetTime();
				local duration = GetPlayerBuffTimeLeft( GetPlayerBuff( i-1 ) );
				SHuntersTooltip:ClearLines();
				SHuntersTooltip:SetPlayerBuff( i-1 );
				playerBuffs[i] = SHuntersTooltipTextLeft1:GetText();
				if ( string.find( playerBuffs[i], SHT_QUICK_SHOTS ) ) then
					if ( duration > 11 ) then
						--DEFAULT_CHAT_FRAME:AddMessage(i.." "..playerBuffs[i].." "..duration, 1, 0, 0 );
						SHunterTimersFrame_add( duration*1000, SHT_QUICK_SHOTS );
					end
					break;
				end
				i = i + 1;
			end
		elseif ( SHTvars["rapid"] and text == SHT_RAPID_FIRE and SHTvars["skills"][SHT_RAPID_FIRE] ) then
			local i = 1;
			while( UnitBuff("player", i ) ) do
				local time = GetTime();
				local duration = GetPlayerBuffTimeLeft( GetPlayerBuff( i-1 ) );
				SHuntersTooltip:ClearLines();
				SHuntersTooltip:SetPlayerBuff( i-1 );
				playerBuffs[i] = SHuntersTooltipTextLeft1:GetText();
				if ( string.find( playerBuffs[i], SHT_RAPID_FIRE ) ) then
					if ( duration > 18 ) then
						--DEFAULT_CHAT_FRAME:AddMessage(i.." "..playerBuffs[i].." "..duration, 1, 0, 0 );
						SHunterTimersFrame_add( duration*1000, SHT_RAPID_FIRE );
					end
					break;
				end
				i = i + 1;
			end
		elseif ( SHTvars["primalblessing"] and text == SHT_PRIMAL_BLESSING and SHTvars["skills"][SHT_PRIMAL_BLESSING] ) then
			local i = 1;
			while( UnitBuff("player", i ) ) do
				local time = GetTime();
				local duration = GetPlayerBuffTimeLeft( GetPlayerBuff( i-1 ) );
				SHuntersTooltip:ClearLines();
				SHuntersTooltip:SetPlayerBuff( i-1 );
				playerBuffs[i] = SHuntersTooltipTextLeft1:GetText();
				if ( string.find( playerBuffs[i], SHT_PRIMAL_BLESSING ) ) then
					if ( duration > 11 ) then
						--DEFAULT_CHAT_FRAME:AddMessage(i.." "..playerBuffs[i].." "..duration, 1, 0, 0 );
						SHunterTimersFrame_add( duration*1000, SHT_PRIMAL_BLESSING );
					end
					break;
				end
				i = i + 1;
			end
		end

		local bar = getglobal("SHunterTimersStatus"..id.."Bar");
		local value = barframe.startTime + barframe.endTime - time;
		bar:SetValue( value );
		local timeleft = barframe.duration - (time - barframe.startTime);
		local timeleftstring;
		if( SHTvars["mili"] == 0 ) then
			timeleftstring = string.format( SHTColor(unpack(SHTvars["timecolor"])).."%ds", timeleft );
		else
			timeleftstring = string.format( SHTColor(unpack(SHTvars["timecolor"])).."%."..SHTvars["mili"].."f", timeleft );
		end
		getglobal("SHunterTimersStatus"..id.."BarRightText"):SetText(timeleftstring);
		if( SHTvars["colorchange"] ) then
			local percent = (time - barframe.startTime)/(barframe.endTime - barframe.startTime);
			local r, g, b, a = unpack( SHTvars["barstartcolor"] );
			local redd, greend, blued, alphad = unpack( SHTvars["bardelta"] );
			redd = r + redd*percent;
			greend = g + greend*percent;
			blued = b + blued*percent;
			alphad = a + alphad*percent;
			bar:SetStatusBarColor( redd, greend, blued, alphad );
			getglobal("SHunterTimersStatus"..id.."BGBar"):SetStatusBarColor( redd, greend, blued, 0.25*alphad );
		end
		
		if( timeleft < SHTvars["flash"] ) and ( barframe.spell ~= SHT_AUTO_SHOT ) then
			if( barframe.step == 0 ) then
				barframe.step = -SHTvars["step"];
			end
			
			local alpha = barframe:GetAlpha() + barframe.step;
			if( alpha < 0.2 ) then
				barframe.step = SHTvars["step"];
			elseif( alpha > SHTvars["overallalpha"] ) then
				barframe.step = -SHTvars["step"];
			end
			barframe:SetAlpha(alpha);
		end
			
			
	elseif( barframe.fadeOut ) then
		if( trapTimer ) then
			local textBar = getglobal("SHunterTimersStatus"..id.."BarLeftText"):GetText();
			if( string.find( textBar, "primed" ) ) then
				trapTimer = false;
			end
		end
		
		local alpha = barframe:GetAlpha() - 0.05;
		if( alpha > 0 ) then
			barframe:SetAlpha(alpha);
		else
			barframe.fadeOut = false;
			barframe:Hide();
			SHTvars["numBars"] = SHTvars["numBars"] - 1;
			SHunterTimers_AutoCascade( 1, false );
		end
	end
end

function SHunterTimersFrame_OnUpdate(elapsed)
	if( (elapsed - this.updateTime) > 1 ) then
		this.updateTime = elapsed;
		
		SHunterTimersFrame:SetScale( SHTvars["scale"] );
		for i=1, SHT_NUM_BARS do
			getglobal("SHunterTimersStatus"..i):SetScale( SHTvars["scale"] );
		end
		for key, val in pairs(dimin) do
			if( (elapsed - dimin[key]["time"]) > 20 ) then
				dimin[key] = nil;
			end
		end
		SHT_SetHeight();
	end
	
	if ( SHTvars["numBars"] > 0 ) then
		SHunterTimersFrame:Show();
		SHunterTimersFrame:SetAlpha( SHTvars["overallalpha"] );
	else
		local alpha = SHunterTimersFrame:GetAlpha() - 0.05;
		if( alpha > 0 ) then
			SHunterTimersFrame:SetAlpha(alpha);
		else
			SHunterTimersFrame:Hide();
		end
	end
end
function SHT_init()
	if( not SHTvars ) then
		SHTvars = {};
		SHTvars["bg"] = { r=0, g=0, b=0, a=7 };
	end
	if( SHTvars[SHT_ON] == nil ) then
		SHTvars[SHT_ON] = true;
	end
	if( not SHTvars["borderalpha"] ) then
		SHTvars["borderalpha"] = {
			[1] = 1;
			[2] = 1;
			[3] = 1;
			[4] = 1;
		};
	end
	SHunterTimersFrame:SetBackdropColor( SHTvars["bg"].r, SHTvars["bg"].g, SHTvars["bg"].b, SHTvars["bg"].a );
	SHunterTimersFrame:SetBackdropBorderColor( unpack(SHTvars["borderalpha"]) );
	SHTvars["numBars"] = 0;
	SHunterTimers_Real_UseAction = UseAction;
	SHunterTimers_Real_CastSpellByName = CastSpellByName;
	SHunterTimers_Real_CastSpell = CastSpell;
	if( not SHTvars["skills"] ) then
		SHTvars["skills"] = {};
	end

	for i=1, SHT_NUM_TIMERS do
		if( SHTvars["skills"][SHT_OPTIONS_TIMERS[i]] == nil ) then
			SHTvars["skills"][SHT_OPTIONS_TIMERS[i]] = true;
		end
	end
	
	if( not SHTvars["shotdelay"] ) then
		SHTvars["shotdelay"] = 200;
	end
	if( not SHTvars["aimeddelay"] ) then
		SHTvars["aimeddelay"] = 200;
	end
	
	if( not SHTvars["scale"] ) then
		SHTvars["scale"] = UIParent:GetScale();
	end
	
	if( SHTvars["locked"] == nil ) then
		SHTvars["locked"] = false;
	end
	
	if( not SHTvars["locked"] ) then
		SHunterTimersAnchor:Show();
	else
		SHunterTimersAnchor:Hide();
	end
	
	if( not SHTvars["mili"] ) then
		SHTvars["mili"] = 2;
	end
	
	if( SHTvars["flash"] == nil ) then
		SHTvars["flash"] = 5;
	end
	
	if( not SHTvars["skillcolor"] ) then
		local r, g, b = SHunterTimersStatus1BarLeftText:GetTextColor();
		--local a = SHunterTimersStatus1BarLeftText:GetAlpha();
		SHTvars["skillcolor"] = {
			[1] = r,
			[2] = g,
			[3] = b,
			[4] = 1
		};
	end
	
	if( not SHTvars["timecolor"] ) then
		local r, g, b = SHunterTimersStatus1BarRightText:GetTextColor();
		--local a = SHunterTimersStatus1BarRightText:GetAlpha();
		SHTvars["timecolor"] = {
			[1] = r,
			[2] = g,
			[3] = b,
			[4] = 1
		};
	end
	
	if( not SHTvars["targetcolor"] ) then
		local r, g, b = SHunterTimersStatus1BarLeftText:GetTextColor();
		--local a = SHunterTimersStatus1BarRightText:GetAlpha();
		SHTvars["targetcolor"] = {
			[1] = r,
			[2] = g,
			[3] = b,
			[4] = 1
		};
	end
	
	if( not SHTvars["barstartcolor"] ) then
		SHTvars["barstartcolor"] = {
			[1] = 0,
			[2] = 0.8,
			[3] = 0,
			[4] = 1 };
	end
	if( not SHTvars["barstartcolor"][4] ) then
		SHTvars["barstartcolor"][4] = 1;
	end
	if( not SHTvars["bardelta"] ) then
		SHTvars["bardelta"] = {
			[1] = 0.8,
			[2] = -0.8,
			[3] = 0,
			[4] = 0};
	end
	if( not SHTvars["bardelta"][4] ) then
		SHTvars["bardelta"][4] = 0;
	end
	if( SHTvars["step"] == nil ) then
		SHTvars["step"] = 0.015;
	end
	if( SHTvars["colorchange"] == nil ) then
		SHTvars["colorchange"] = false;
	end
	if( not SHTvars["bardistance"] ) then
		SHTvars["bardistance"] = 10;
	end
	
	if( SHTvars["down"] == nil ) then
		SHTvars["down"] = true;
	end
	
	if( SHTvars["down"] ) then
		SHunterTimersFrame:ClearAllPoints();
		SHunterTimersFrame:SetPoint( "TOPLEFT", "SHunterTimersAnchor", "BOTTOMRIGHT" );
	else
		SHunterTimersFrame:ClearAllPoints();
		SHunterTimersFrame:SetPoint( "BOTTOMLEFT", "SHunterTimersAnchor", "TOPRIGHT" );
	end
	
	if( SHTvars["append"] == nil ) then
		SHTvars["append"] = false;
	end
	
	if( not SHTvars["overallalpha"] ) then
		SHTvars["overallalpha"] = 1;
	end
	
	SHunterTimers_ClearActiveSpells();
	
	for i=1, SHT_NUM_TIMERS do --Check boxes
		getglobal("SHunterTimersOptionsTimersCheckButton"..i.."Text"):SetText(SHT_OPTIONS_TIMERS[i]);
	end
	
	for i=1, SHT_NUM_OPTIONS do --Check boxes
		getglobal("SHunterTimersOptionsBarsCheckButton"..i.."Text"):SetText(SHT_OPTIONS_BARS[i]);
	end
	
	for i=1, SHT_NUM_SLIDERS do  --Sliders
		getglobal("SHunterTimersOptionsBarsSlider"..i.."SliderTitle"):SetText(SHT_OPTIONS_SLIDER[i]);
		getglobal("SHunterTimersOptionsBarsSlider"..i.."SliderLow"):SetText(SHT_OPTIONS_SLIDER_ENDS[i][1])
		getglobal("SHunterTimersOptionsBarsSlider"..i.."SliderHigh"):SetText(SHT_OPTIONS_SLIDER_ENDS[i][2]);
	end
	
	if( not SHTvars["textures"] ) then
		SHTvars["textures"] = {};
	end
	
	if( SHTvars["showtex"] == nil ) then
		SHTvars["showtex"] = true;
	end
	if( SHTvars["largetex"] == nil ) then
		SHTvars["largetex"] = false;
	end
	
	if( SHTvars["hidetext"] == nil ) then
		SHTvars["hidetext"] = false;
	end
	
	if( SHTvars["hidetime"] == nil ) then
		SHTvars["hidetime"] = false;
	end
	
	if( SHTvars["gap"] == nil ) then
		SHTvars["gap"] = true;
	end
	
	if( SHTvars["padding"] == nil ) then
		SHTvars["padding"] = true;
	end
	
	if( not SHTvars["barheight"] ) then
		SHTvars["barheight"] = 10;
	end
	
	if( SHTvars["sticky"] == nil ) then
		SHTvars["sticky"] = true;
	end
	
	if( SHTvars["traptimemult"] == nil ) then
		SHTvars["traptimemult"] = 1;
	end
	
	getglobal("SHunterTimersOptionsTimersLabel1Label"):SetText(SHT_OPTIONS_TIMERS_TEXT);

	for i=1, SHT_NUM_LABELS do
		getglobal("SHunterTimersOptionsBarsLabel"..i.."Label"):SetText(SHT_OPTIONS_LABELS[i]);
	end
	
	getglobal("SHunterTimersOptionsTitleString"):SetText("Sorren's Hunter Timers "..SHT_VERSION);
	
	SHunterTimers_SetSettings();
	
	SHunterTimersOptions:SetScale(UIParent:GetScale()*0.8);
end

function SHunterTimersFrame_OnEvent()
	if ( shtdebug ) then
		if ( arg1 ) then
			DEFAULT_CHAT_FRAME:AddMessage(event.." "..arg1, 1, 0, 0 );
		else
			DEFAULT_CHAT_FRAME:AddMessage(event, 1, 0, 0 );
		end
	end
	
	if( event == "VARIABLES_LOADED" ) then
		SHT_init();
		return;
	end
	if( event == "SPELLS_CHANGED" ) then
		SHunterTimers_UpdateSpells();
		return;
	end
	if( event == "CHARACTER_POINTS_CHANGED" or event == "PLAYER_ALIVE" ) then
		local _, _, _, _, rank = GetTalentInfo( 3, 7 ); --Clever traps
		SHTvars["traptimemult"] = 1 + (rank * 0.15);
		return;
	end
	if( not SHTvars[SHT_ON] ) then
		return;
	end
	if( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE" ) or ( event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE" ) then
		if( string.find( arg1, SHT_TRAP ) ) then
			if( trapTimer ) then
				for mob, effect in string.gfind( arg1, SHT_TRAP_AFFLICT_STRING ) do
					--DEFAULT_CHAT_FRAME:AddMessage(effect.." "..mob);
					SHunterTimers_addDebuff( effect, mob );
				end
			end
		elseif( string.find( arg1, SHT_FEAR_BEAST ) ) then
			for mob, effect in string.gfind( arg1, SHT_AFFLICT_STRING ) do
				--DEFAULT_CHAT_FRAME:AddMessage(effect.." "..mob);
				if( string.find(effect, SHT_FEAR_BEAST) ) and ( mob == UnitName("target") ) then
					SHTvars["fearbeast"] = true;
					SHunterTimers_addDebuff( SHT_FEAR_BEAST, mob );
				end
			end
		elseif( string.find( arg1, SHT_EXPOSE_WEAKNESS ) ) then
			for mob, effect in string.gfind( arg1, SHT_AFFLICT_STRING ) do
				--DEFAULT_CHAT_FRAME:AddMessage(effect.." "..mob);
				if( string.find(effect, SHT_EXPOSE_WEAKNESS) ) and ( mob == UnitName("target") ) then
					SHTvars["exposeweak"] = true;
					SHunterTimers_addDebuff( SHT_EXPOSE_WEAKNESS, mob );
				end
			end
		elseif( string.find( arg1, SHT_ENTRAPMENT ) ) then
			for mob, effect in string.gfind( arg1, SHT_AFFLICT_STRING ) do
				--DEFAULT_CHAT_FRAME:AddMessage(effect.." "..mob);
				if( string.find(effect, SHT_ENTRAPMENT) ) and ( mob == UnitName("target") ) then
					SHTvars["entrapment"] = true;
					SHunterTimers_addDebuff( SHT_ENTRAPMENT, mob );
				end
			end
		end
	elseif( event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS" ) then
		--DEFAULT_CHAT_FRAME:AddMessage(event.." "..arg1, 1, 0, 0 );
		if( string.find( arg1, SHT_QUICK_SHOTS ) ) then
			SHTvars["quick"] = true;
			SHTvars["quicktime"] = GetTime();
			if(SHTvars["skills"][SHT_QUICK_SHOTS]) then
				SHunterTimersFrame_add( 12000, SHT_QUICK_SHOTS );
			end
		elseif( string.find( arg1, SHT_RAPID_FIRE ) ) then
			SHTvars["rapid"] = true;
			SHTvars["rapidtime"] = GetTime();
			if (SHTvars["skills"][SHT_RAPID_FIRE]) then
				SHunterTimersFrame_add( 15000, SHT_RAPID_FIRE );
			end
		elseif( string.find( arg1, SHT_PRIMAL_BLESSING ) ) then
			SHTvars["primalblessing"] = true;
			if (SHTvars["skills"][SHT_PRIMAL_BLESSING]) then
				SHunterTimersFrame_add( 12000, SHT_PRIMAL_BLESSING );
			end
		elseif( string.find( arg1, SHT_DETERRENCE ) and SHTvars["skills"][SHT_DETERRENCE] ) then
			SHTvars["deterrence"] = true;
			SHunterTimersFrame_add( 10000, SHT_DETERRENCE );
		elseif( string.find( arg1, SHT_BERSERKING ) ) then
			SHTvars["berserking"] = true;
			currentHealth = UnitHealth("player");
			maxHealth = UnitHealthMax("player");
			percentHealth = currentHealth / maxHealth;
			if(percentHealth >= 0.40) then
				berserkValue = (1.30 - percentHealth)/3;
			else
				berserkValue = 0.30;
			end
			if (SHTvars["skills"][SHT_BERSERKING]) then
				SHunterTimersFrame_add( 10000, SHT_BERSERKING );
			end
		elseif( string.find( arg1, SHT_DEVILSAUR_PROC ) ) then
			if ( SHTvars["skills"][SHT_DEVILSAUR] ) then
				SHunterTimersFrame_add( 20000, SHT_DEVILSAUR );
				SHTvars["devilsaur"] = true;
			end
		elseif( string.find( arg1, SHT_ZHM_PROC ) ) then
			if ( SHTvars["skills"][SHT_ZHM] ) then
				SHunterTimersFrame_add( 20000, SHT_ZHM );
				SHTvars["zhm"] = true;
			end
		elseif( string.find( arg1, SHT_EARTHSTRIKE ) ) then
			if ( SHTvars["skills"][SHT_EARTHSTRIKE] ) then
				SHunterTimersFrame_add( 20000, SHT_EARTHSTRIKE );
				SHTvars["earthstrike"] = true;
			end
		elseif( string.find( arg1, SHT_SWARMGUARD ) ) then
			if ( SHTvars["skills"][SHT_SWARMGUARD] ) then
				SHunterTimersFrame_add( 30000, SHT_SWARMGUARD );
				SHTvars["swarmguard"] = true;
			end
		elseif( string.find( arg1, SHT_JOM_GABBAR ) ) then
			if ( SHTvars["skills"][SHT_JOM_GABBAR] and not SHTvars["jomgabbar"] ) then
				SHunterTimersFrame_add( 20000, SHT_JOM_GABBAR );
				SHTvars["jomgabbar"] = true;
			end
		elseif( string.find( arg1, SHT_KISS_SPIDER ) ) then
			SHTvars["spider"] = true;
			if (SHTvars["skills"][SHT_KISS_SPIDER]) then
				SHunterTimersFrame_add( 15000, SHT_KISS_SPIDER );
			end
		end
	elseif( event == "CHAT_MSG_SPELL_PET_DAMAGE" ) then
		if( string.find( arg1, SHT_RESIST ) or string.find( arg1, SHT_IMMUNE) ) then
			if( string.find( arg1, SHT_INTIM ) ) then
				for i=1, SHTvars["numBars"] do
					local text = getglobal("SHunterTimersStatus"..i).spell;
					if( string.find( text, SHT_PET_INTIM ) ) then
						getglobal("SHunterTimersStatus"..i).endTime = 0;
					end
				end
			else
				for trap in string.gfind( arg1, SHT_FIND_TRAP_FAILED ) do
					if( trapTimer ) and ( string.find( trap, SHT_FREEZING_TRAP ) or string.find( trap, SHT_IMMO_TRAP ) )then
						for i=1, SHTvars["numBars"] do
							local text = getglobal("SHunterTimersStatus"..i.."BarLeftText"):GetText();
							if( string.find( text, trap.." "..SHT_PRIMED ) ) then
								getglobal("SHunterTimersStatus"..i).endTime = 0;
							end
						end
					end
				end
			end
		end
	elseif( event == "CHAT_MSG_SPELL_SELF_DAMAGE" ) then
		if(SHTvars["skills"][SHT_WING_CLIP]) and ( string.find( arg1, SHT_YOUR..SHT_WING_CLIP ) ) and ( string.find( arg1, SHT_HITS ) or string.find(arg1, SHT_CRITS ) ) then
			SHTvars["wingclip"] = true;
			local name = UnitName("target");
			SHunterTimersFrame_add( 10000, SHT_WING_CLIP, name );
		elseif( string.find( arg1, SHT_FAILED ) ) then
			local name = UnitName("target");
			for spell in string.gfind( arg1, SHT_FAILED_STRING) do
				--DEFAULT_CHAT_FRAME:AddMessage(spell);
				for i=1, SHTvars["numBars"] do
					local barframe = getglobal("SHunterTimersStatus"..i);
					--local text = getglobal("SHunterTimersStatus"..i.."BarLeftText"):GetText();
					if( barframe.spell == spell ) and ( barframe.target == name )then
						getglobal("SHunterTimersStatus"..i).endTime = 0;
					end
				end
			end
		elseif( string.find(arg1, SHT_MISSES ) ) then
			local name = UnitName("target");
			for spell in string.gfind( arg1, SHT_MISSES_STRING ) do
				for i=1, SHTvars["numBars"] do
					local barframe = getglobal("SHunterTimersStatus"..i);
					--local text = getglobal("SHunterTimersStatus"..i.."BarLeftText"):GetText();
					if( barframe.spell == spell ) and ( barframe.target == name )then
						getglobal("SHunterTimersStatus"..i).endTime = 0;
					end
				end
			end
		elseif(SHTvars["skills"][SHT_COUNTER]) and ( string.find( arg1, SHT_YOUR..SHT_COUNTER ) and (string.find( arg1, SHT_HITS ) or string.find( arg1, SHT_CRITS )) )then
			SHunterTimersFrame_add( 5000, SHT_COUNTER, UnitName("target") );
		end
	elseif( event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" ) then
		if( SHTvars["numBars"] > 0 ) then
			for target in string.gfind( arg1, SHT_DIES ) do
				checkForTarget = target;
			end
			checkForTargetDeath = GetTime();
		end
	elseif( event == "CHAT_MSG_MONSTER_EMOTE" ) then
		if( SHTvars["skills"][SHT_FRENZY] and (string.find(arg1, SHT_FRENZY_EMOTE ) or string.find(arg1, SHT_FRENZY_FLAMEGOR ) )) then
			if( arg2 == SHT_CHROMAGGUS ) then
				SHunterTimersFrame_add( 15000, SHT_FRENZY, SHT_CHROMAGGUS );
			elseif( arg2 == SHT_FLAMEGOR ) then
				SHunterTimersFrame_add( 10000, SHT_FRENZY, SHT_FLAMEGOR );
			elseif( arg2 == SHT_MAGMADAR ) then
				SHunterTimersFrame_add( 15000, SHT_FRENZY, SHT_MAGMADAR );
			elseif( arg2 == SHT_HUHURAN ) then
				SHunterTimersFrame_add( 10000, SHT_FRENZY, SHT_HUHURAN );
			elseif( arg2 == SHT_GLUTH ) then
				SHunterTimersFrame_add( 10000, SHT_FRENZY, SHT_GLUTH );
			end
		end
	elseif( event == "PLAYER_TARGET_CHANGED" ) then
		if(SHTvars["numBars"]== 0 ) then
			return;
		end
		local time = GetTime();
		if( time - checkForTargetDeath < 1 ) then
			for num = 1, SHTvars["numBars"], 1 do
				--local text = getglobal("SHunterTimersStatus"..num.."BarLeftText"):GetText();
				local barframe = getglobal("SHunterTimersStatus"..num);
				if( barframe.target == checkForTarget ) then
					barframe.endTime = 0;
				end
			end
		end
	elseif( event == "SPELLCAST_START" ) then
		--DEFAULT_CHAT_FRAME:AddMessage(event.." "..arg1, 1, 0, 0 );
		checkForSpellFail = true;
		checkForTarget = UnitName("target");
		checkForSpellName = arg1;
	elseif( event == "SPELLCAST_FAILED" ) then
		if( checkForSpellFail ) then
			if( SHTvars["skills"][SHT_AIMED_SHOT] and ( checkForSpellName == SHT_AIMED_SHOT ) ) then
				SHTvars["aimed"] = false;
			end
			checkForSpellFail = false;
			checkForSpellName = nil;
		end
	elseif( event == "SPELLCAST_STOP" ) then
		--DEFAULT_CHAT_FRAME:AddMessage(event, 1, 0, 0 );
		--DEFAULT_CHAT_FRAME:AddMessage(checkForSpellName, 1, 0, 0 );
		if( checkForSpellFail ) then
			checkForSpellFail = false;
			local name = UnitName("target");
			if( SHT_sfind( checkForSpellName, SHT_STING ) ) then
				SHunterTimers_addDebuff( checkForSpellName, name );
			elseif( SHTvars["skills"][SHT_INTIM]) and ( string.find( checkForSpellName, SHT_INTIM ) ) then
				SHTvars["petIntim"] = true;
				SHunterTimersFrame_add( 15000, SHT_PET_INTIM );
			elseif( SHTvars["skills"][SHT_BW]) and ( string.find( checkForSpellName, SHT_BW ) ) then
				SHunterTimersFrame_add( 15000, checkForSpellName );
			elseif( SHTvars["skills"][SHT_FLARE]) and ( string.find( checkForSpellName, SHT_FLARE ) ) then
				SHunterTimersFrame_add( 30000, checkForSpellName );
			elseif( SHTvars["skills"][SHT_HUNTERS_MARK]) and ( string.find( checkForSpellName, SHT_HUNTERS_MARK ) ) then
				if ( name ~= nil ) then
					SHTvars["huntersmark"] = true;
					SHunterTimers_addDebuff( SHT_HUNTERS_MARK, name );
				end
			elseif( string.find( checkForSpellName, SHT_TRAP ) ) then
				if( SHTvars["skills"][checkForSpellName]) then
					trapTimer = true;
					SHunterTimersFrame_add( 60000, checkForSpellName.." "..SHT_PRIMED );
				end
			elseif( SHTvars["skills"][SHT_SCATTER]) and ( string.find( checkForSpellName, SHT_SCATTER ) ) then
				local duration = 4000;
				if(name) and ( dimin[name] ) and ((GetTime() - dimin[name]["time"]) < 20) then
					for i=1, dimin[name]["times"] do
						duration = duration/2;
					end
				end
				SHTvars["scatter"] = true;
				SHunterTimersFrame_add( duration, checkForSpellName, name );
			elseif( SHTvars["skills"][SHT_FEAR_BEAST]) and ( checkForSpellName == SHT_FEAR_BEAST ) then
				SHTvars["fearbeast"] = true;
			elseif( SHTvars["skills"][SHT_CONC_SHOT]) and ( checkForSpellName == SHT_CONC_SHOT ) then
				SHTvars["concuss"] = true;
				SHunterTimers_addDebuff( checkForSpellName, name );
			elseif( SHTvars["skills"][SHT_AIMED_SHOT] and ( checkForSpellName == SHT_AIMED_SHOT ) ) then
				SHTvars["aimed"] = false;
			else
				SHunterTimers_addDebuff( checkForSpellName, name );
			end
			checkForSpellName = nil;
		elseif( shtautoshot ) and ( not shtcasting ) then
			SHT_AddAutoShot();
		end
		if( shtcasting ) then
			shtcasting = false;
		end
		--[[DEFAULT_CHAT_FRAME:AddMessage(GetTime() - autodelta );
		DEFAULT_CHAT_FRAME:AddMessage("auto: "..GetTime() - shtautotime );
		autodelta = GetTime();
		shtautotime = GetTime();--]]
		--DEFAULT_CHAT_FRAME:AddMessage(checkForSpell, 1, 0, 0 );
		
	elseif( event == "UNIT_AURA" ) then
		if( arg1 == "target" ) then
			--DEFAULT_CHAT_FRAME:AddMessage(event.." "..arg1, 1, 0, 0 );
			local time = GetTime();
			local name = UnitName("target");
			--DEFAULT_CHAT_FRAME:AddMessage(time, 1, 0, 0 );
			local i = 1;
			while( UnitDebuff("target", i ) ) do
				SHuntersTooltip:ClearLines();
				SHuntersTooltip:SetUnitDebuff("target", i );
				targetDebuffs[i] = SHuntersTooltipTextLeft1:GetText();
				--DEFAULT_CHAT_FRAME:AddMessage(i.." "..targetDebuffs[i], 1, 0, 0 );
				
				if( string.find( targetDebuffs[i], SHT_INTIM ) ) and ( not SHTvars["intimidate"] ) then
					SHTvars["intimidate"] = true;
					SHunterTimers_addDebuff( SHT_INTIM, name );
					break;
				elseif( string.find( targetDebuffs[i], SHT_IMP_CONC ) ) and ( not SHTvars["impconc"] ) then
					SHTvars["impconc"] = true;
					SHunterTimers_addDebuff( SHT_IMP_CONC_SHORT, name );
					break;
				elseif( string.find( targetDebuffs[i], SHT_IMP_WC ) ) and ( not SHTvars["impwing"] ) then
					SHTvars["impwing"] = true;
					SHunterTimersFrame_add( 5000, SHT_IMP_WC_SHORT, name );
					break;
				elseif( string.find( targetDebuffs[i], SHT_EXPOSE_WEAKNESS ) ) and ( not SHTvars["exposeweak"] ) then
					SHTvars["exposeweak"] = true;
					SHunterTimers_addDebuff( SHT_EXPOSE_WEAKNESS, name );
					break;
				end
				i = i + 1;
			end
		end
	elseif( event == "CHAT_MSG_SPELL_AURA_GONE_OTHER" ) then
		for effect, target in string.gfind(arg1, SHT_FADE_STRING ) do

			if( SHTvars["freezing"] ) and string.find(effect, SHT_FREEZING_TRAP ) then
				for i=1, SHTvars["numBars"] do
					local barframe = getglobal( "SHunterTimersStatus"..i);
					--local text = getglobal( "SHunterTimersStatus"..i.."BarLeftText"):GetText();
					if( barframe.spell == SHT_FREEZING_TRAP ) and ( barframe.target == target ) then
						--SHunterTimersFrame_add( 20000, "Diminishing Returns" );
						getglobal("SHunterTimersStatus"..i).endTime = 0;
					end
				end
				if( not dimin[target] ) then
					dimin[target] = {};
				end
				dimin[target]["time"] = GetTime();
				if( dimin[target]["times"] == nil ) then
					dimin[target]["times"] = 1;
				else
					dimin[target]["times"] = dimin[target]["times"] + 1;
				end
			elseif( SHTvars["scatter"] ) and string.find( effect, SHT_SCATTER ) then
				for i=1, SHTvars["numBars"] do
					local barframe = getglobal( "SHunterTimersStatus"..i)
					--local text = getglobal("SHunterTimersStatus"..i.."BarLeftText"):GetText();
					if( barframe.spell == SHT_SCATTER ) and ( barframe.target == target ) then
						getglobal("SHunterTimersStatus"..i).endTime = 0;
						
					end
				end
				if( not dimin[target] ) then
					dimin[target] = {};
				end
				dimin[target]["time"] = GetTime();
				if( dimin[target]["times"] == nil ) then
					dimin[target]["times"] = 1;
				else
					dimin[target]["times"] = dimin[target]["times"] + 1;
				end
			elseif( SHTvars["fearbeast"] ) and string.find( effect, SHT_FEAR_BEAST ) then
				for i=1, SHTvars["numBars"] do
					local barframe = getglobal( "SHunterTimersStatus"..i);
					--local text = getglobal("SHunterTimersStatus"..i.."BarLeftText"):GetText();
					if( barframe.spell == SHT_FEAR_BEAST ) and (barframe.target == target ) then
						getglobal("SHunterTimersStatus"..i).endTime = 0;
					end
				end
			elseif( SHTvars["wyvern"] ) and string.find( effect, SHT_WYVERN ) then
				for i=1, SHTvars["numBars"] do
					local barframe = getglobal( "SHunterTimersStatus"..i);
					local text = getglobal("SHunterTimersStatus"..i.."BarLeftText"):GetText();
					if( text == SHT_WYVERN_TEXT ) and (barframe.target == target ) then
						getglobal("SHunterTimersStatus"..i).endTime = 0;
					end
				end
				if( not dimin[target] ) then
					dimin[target] = {};
				end
				dimin[target]["time"] = GetTime();
				if( dimin[target]["times"] == nil ) then
					dimin[target]["times"] = 1;
				else
					dimin[target]["times"] = dimin[target]["times"] + 1;
				end
			elseif( SHTvars["wingclip"] ) and string.find( effect, SHT_WING_CLIP ) and not ( string.find( effect, SHT_IMP_WC ) ) then
				for i=1, SHTvars["numBars"] do
					--local text = getglobal( "SHunterTimersStatus"..i.."BarLeftText"):GetText();
					local barframe = getglobal( "SHunterTimersStatus"..i);
					if( barframe.spell == SHT_WING_CLIP ) and ( barframe.target == target ) then
						getglobal("SHunterTimersStatus"..i).endTime = 0;
					end
				end
			elseif( SHTvars["exposeweak"] ) and string.find( effect, SHT_EXPOSE_WEAKNESS ) then
				for i=1, SHTvars["numBars"] do
					local barframe = getglobal( "SHunterTimersStatus"..i);
					if( barframe.spell == SHT_EXPOSE_WEAKNESS ) and ( barframe.target == target ) then
						getglobal("SHunterTimersStatus"..i).endTime = 0;
					end
				end
			elseif( SHTvars["entrapment"] ) and string.find( effect, SHT_ENTRAPMENT ) then
				for i=1, SHTvars["numBars"] do
					local barframe = getglobal( "SHunterTimersStatus"..i);
					if( barframe.spell == SHT_ENTRAPMENT ) and ( barframe.target == target ) then
						getglobal("SHunterTimersStatus"..i).endTime = 0;
					end
				end
			elseif( SHTvars["huntersmark"] ) and string.find( effect, SHT_HUNTERS_MARK ) then
				for i=1, SHTvars["numBars"] do
					local barframe = getglobal( "SHunterTimersStatus"..i);
					if( barframe.spell == SHT_HUNTERS_MARK ) and ( barframe.target == target ) then
						getglobal("SHunterTimersStatus"..i).endTime = 0;
					end
				end
			end
		end
	elseif( event == "CHAT_MSG_SPELL_AURA_GONE_SELF" ) then
		--DEFAULT_CHAT_FRAME:AddMessage(event.." "..arg1, 1, 0, 0);
		for effect, target in string.gfind(arg1, SHT_FADE_STRING ) do
			if( SHTvars["quick"] ) and string.find( effect, SHT_QUICK_SHOTS ) then
				SHTvars["quick"] = false;
				for i=1, SHTvars["numBars"] do
					local barframe = getglobal( "SHunterTimersStatus"..i);
					if( barframe.spell == SHT_QUICK_SHOTS ) then
						getglobal("SHunterTimersStatus"..i).endTime = 0;
					end
				end
			elseif( SHTvars["rapid"] ) and string.find( effect, SHT_RAPID_FIRE ) then
				SHTvars["rapid"] = false;
				for i=1, SHTvars["numBars"] do
					local barframe = getglobal( "SHunterTimersStatus"..i);
					if( barframe.spell == SHT_RAPID_FIRE ) then
						getglobal("SHunterTimersStatus"..i).endTime = 0;
					end
				end
			elseif( SHTvars["primalblessing"] ) and string.find( effect, SHT_PRIMAL_BLESSING ) then
				for i=1, SHTvars["numBars"] do
					local barframe = getglobal( "SHunterTimersStatus"..i);
					if( barframe.spell == SHT_PRIMAL_BLESSING ) then
						getglobal("SHunterTimersStatus"..i).endTime = 0;
					end
				end
			elseif( SHTvars["berserking"] ) and string.find( effect, SHT_BERSERKING ) then
				SHTvars["berserking"] = false;
				for i=1, SHTvars["numBars"] do
					local barframe = getglobal( "SHunterTimersStatus"..i);
					if( barframe.spell == SHT_BERSERKING ) then
						getglobal("SHunterTimersStatus"..i).endTime = 0;
					end
				end
			elseif( SHTvars["spider"] ) and string.find( effect, SHT_KISS_SPIDER ) then
				SHTvars["spider"] = false;
				for i=1, SHTvars["numBars"] do
					local barframe = getglobal( "SHunterTimersStatus"..i);
					if( barframe.spell == SHT_KISS_SPIDER ) then
						getglobal("SHunterTimersStatus"..i).endTime = 0;
					end
				end
			end
		end
	elseif( event == "START_AUTOREPEAT_SPELL" ) then
		shtautotime = GetTime();
		shtautoshot = true;
		--SHT_AddAutoShot();
	elseif( event == "STOP_AUTOREPEAT_SPELL" ) then
		shtautoshot = false;
	end

end

function SHunterTimers_addDebuff( debuff, mob )
	if (SHTvars["skills"][SHT_SERPENT]) and ( debuff == SHT_SERPENT ) then
		SHunterTimersFrame_add( 15000, SHT_SERPENT, mob );
		--currentSting = "Serpent Sting";
	elseif(SHTvars["skills"][SHT_SCORPID]) and ( debuff == SHT_SCORPID ) then
		SHunterTimersFrame_add( 20000, SHT_SCORPID, mob );
		--currentSting = "Scorpid Sting";
	elseif(SHTvars["skills"][SHT_VIPER]) and ( debuff == SHT_VIPER ) then
		SHunterTimersFrame_add( 8000, SHT_VIPER, mob );
		--currentSting = "Viper Sting";
	elseif(SHTvars["skills"][SHT_WYVERN]) and ( debuff == SHT_WYVERN ) then
		local duration = 12000;
		local name = UnitName("target");
		if( dimin[name] ) and ( ( GetTime() - dimin[name]["time"]) < 20 )then
			for i=1, dimin[name]["times"] do
				duration = duration / 2;
			end
		end
		SHTvars["wyvern"] = true;
		SHunterTimersFrame_add( duration, SHT_WYVERN_TEXT, name );
	elseif(SHTvars["skills"][SHT_CONC_SHOT]) and ( debuff == SHT_IMP_CONC_SHORT ) then
		SHunterTimersFrame_add( 3000, SHT_IMP_CONC_SHORT, mob );
	elseif(SHTvars["skills"][SHT_FEAR_BEAST] ) and ( debuff == SHT_FEAR_BEAST ) then
		SHunterTimersFrame_add( 20000, SHT_FEAR_BEAST, mob );
	elseif(SHTvars["skills"][SHT_CONC_SHOT]) and ( debuff == SHT_CONC_SHOT ) then
		SHunterTimersFrame_add( 4000, SHT_CONC_SHOT, mob );
	elseif(SHTvars["skills"][SHT_HUNTERS_MARK]) and ( debuff == SHT_HUNTERS_MARK ) then
		SHunterTimersFrame_add( 120000, SHT_HUNTERS_MARK, mob );
	elseif(SHTvars["skills"][SHT_INTIM]) and ( debuff == SHT_INTIM ) then
		SHunterTimersFrame_add( 3000, SHT_INTIM, mob );
	elseif(SHTvars["skills"][SHT_EXPOSE_WEAKNESS]) and ( debuff == SHT_EXPOSE_WEAKNESS ) then
		SHunterTimersFrame_add( 7000, SHT_EXPOSE_WEAKNESS, mob );
	elseif(SHTvars["skills"][SHT_ENTRAPMENT]) and ( debuff == SHT_ENTRAPMENT ) then
		SHunterTimersFrame_add( 5000, SHT_ENTRAPMENT, mob );
	elseif( string.find( debuff, SHT_TRAP ) ) then
		if( trapTimer ) then
			trapTimer = false;
			for num = 1, SHTvars["numBars"] do
				local barframe = getglobal( "SHunterTimersStatus"..num);
				local text = getglobal("SHunterTimersStatus"..num.."BarLeftText"):GetText();
				if( string.find( text, SHT_PRIMED ) ) then
					barframe.endTime = 0;
				end
			end
			if(SHTvars["skills"][SHT_FREEZING_TRAP]) and ( string.find( debuff, SHT_FREEZING_TRAP ) ) then
				SHTvars["freezing"] = true;
				local duration = 20000*SHTvars["traptimemult"];
				if(mob) and ( dimin[mob] ) and ( ( GetTime() - dimin[mob]["time"]) < 20 )then
					for i=1, dimin[mob]["times"] do
						duration = duration / 2;
					end
				end
				SHunterTimersFrame_add( duration, SHT_FREEZING_TRAP, mob );
			elseif(SHTvars["skills"][SHT_FROST_TRAP]) and ( string.find( debuff, SHT_FROST_TRAP ) ) then
				SHunterTimersFrame_add( 30000*SHTvars["traptimemult"], SHT_FROST_TRAP.." "..SHT_AURA );
			elseif(SHTvars["skills"][SHT_IMMO_TRAP]) and ( string.find( debuff, SHT_IMMO_TRAP ) ) then
				SHunterTimersFrame_add( 15000, SHT_IMMO_TRAP, mob );
			elseif(SHTvars["skills"][SHT_EXPL_TRAP]) and ( string.find( debuff, SHT_EXPL_TRAP ) ) then
				SHunterTimersFrame_add( 20000, SHT_EXPL_TRAP.." "..SHT_AURA );
			end
		end
	end
end
function SHunterTimers_cascadeBar( id )
	local barframefrom = getglobal("SHunterTimersStatus"..(id+1));
	if( not barframefrom ) or not ( barframefrom:IsVisible() and (barframefrom.channeling or barframefrom.fadeOut) )then
		getglobal("SHunterTimersStatus"..id):Hide();
		SHunterTimers_SetWidths();
		SHT_SetHeight();
		return;
	end
	
	local barframeto = getglobal("SHunterTimersStatus"..id);
	local barto = getglobal("SHunterTimersStatus"..id.."Bar");
	local textLeftto = getglobal("SHunterTimersStatus"..id.."BarLeftText");
	local textRightto = getglobal("SHunterTimersStatus"..id.."BarRightText");
	local iconto = getglobal("SHunterTimersStatus"..id.."Icon");
	
	id = id + 1;
	
	local barfrom = getglobal("SHunterTimersStatus"..id.."Bar");
	local textLeftfrom = getglobal("SHunterTimersStatus"..id.."BarLeftText");
	local textRightfrom = getglobal("SHunterTimersStatus"..id.."BarRightText");
	
	barframeto.texture = barframefrom.texture;
	iconto:SetTexture(barframeto.texture);
	
	barframeto.startTime = barframefrom.startTime;
	barframeto.endTime = barframefrom.endTime;
	barframeto.duration = barframefrom.duration;
	barframeto.channeling = barframefrom.channeling;
	barframeto.fadeOut = barframefrom.fadeOut;
	barframeto.target = barframefrom.target;
	barframeto.spell = barframefrom.spell;
	barto:SetMinMaxValues(barframeto.startTime, barframeto.endTime);
	barto:SetValue(barfrom:GetValue());
	textLeftto:SetText(textLeftfrom:GetText());
	textRightto:SetText(textRightfrom:GetText());
	barframeto:SetAlpha(barframefrom:GetAlpha());
	barframeto:Show();
	SHunterTimers_cascadeBar( id );
end

function SHunterTimers_shift( id, curr )

	if( id > SHTvars["numBars"] ) or ( SHTvars["numBars"] == 11 ) then
		return;
	end
	
	if( not curr ) then
		curr = SHTvars["numBars"] + 1;
	end
	
	if( curr == id ) then
		--DEFAULT_CHAT_FRAME:AddMessage("shiftend");
		return;
	end
	
	SHunterTimers_CopyBar( curr, curr-1 );
	SHunterTimers_shift( id, curr-1 );
	
end

function SHunterTimers_CopyBar(to, from)
	local barframeto = getglobal("SHunterTimersStatus"..to);
	local barto = getglobal("SHunterTimersStatus"..to.."Bar");
	local textLeftto = getglobal("SHunterTimersStatus"..to.."BarLeftText");
	local textRightto = getglobal("SHunterTimersStatus"..to.."BarRightText");
	local iconto = getglobal("SHunterTimersStatus"..to.."Icon");
	
	local barframefrom = getglobal("SHunterTimersStatus"..from);
	local barfrom = getglobal("SHunterTimersStatus"..from.."Bar");
	local textLeftfrom = getglobal("SHunterTimersStatus"..from.."BarLeftText");
	local textRightfrom = getglobal("SHunterTimersStatus"..from.."BarRightText");
	
	barframeto.texture = barframefrom.texture;
	iconto:SetTexture(barframeto.texture);
	
	barframeto.startTime = barframefrom.startTime;
	barframeto.endTime = barframefrom.endTime;
	barframeto.duration = barframefrom.duration;
	barframeto.channeling = barframefrom.channeling;
	barframeto.fadeOut = barframefrom.fadeOut;
	barframeto.target = barframefrom.target;
	barframeto.spell = barframefrom.spell;
	barto:SetMinMaxValues(barframeto.startTime, barframeto.endTime);
	barto:SetValue(barfrom:GetValue());
	textLeftto:SetText(textLeftfrom:GetText());
	textRightto:SetText(textRightfrom:GetText());
	barframeto:SetAlpha(barframefrom:GetAlpha());
	barframeto:Show();
end

function SHunterTimers_AutoCascade(id, last)
	if( id == SHT_NUM_BARS ) then
		return;
	end
	if( id == 0 ) then
		id = 1;
	end
	local barframe = getglobal("SHunterTimersStatus"..id);
	if( barframe:IsVisible() ) then
		SHunterTimers_AutoCascade(id+1, false);
	else
		local barframenext = getglobal("SHunterTimersStatus"..id+1);
		if( barframenext:IsVisible() ) then
			SHunterTimers_cascadeBar(id);
			if( last ) then
				SHunterTimers_AutoCascade( id-1, true );
			else
				SHunterTimers_AutoCascade( id+1, false );
			end
		else
			SHunterTimers_AutoCascade(id+1, true);
		end
	end
end
		
		
		
function SHunterTimers_OnUseAction( slot, checkFlags, checkSelf )
	SHuntersTooltip:ClearLines();
	SHuntersTooltip:SetAction(slot);
	local text = SHuntersTooltipTextLeft1:GetText();
	SHunterTimers_SetStates(text);
	SHunterTimers_Real_UseAction( slot, checkFlags, checkSelf );
end

function SHunterTimers_OnCastSpell(spellID, spellTab)
	SHuntersTooltip:ClearLines();
	SHuntersTooltip:SetSpell(spellID, spellTab);
	local text = SHuntersTooltipTextLeft1:GetText();
	SHunterTimers_SetStates(text);
	SHunterTimers_Real_CastSpell(spellID, spellTab);
end

function SHunterTimers_OnCastSpellByName(spellName)
	SHunterTimers_SetStates(spellName);
	SHunterTimers_Real_CastSpellByName(spellName);
end

function SHunterTimers_SetStates(text)
	if( text ) then
		--DEFAULT_CHAT_FRAME:AddMessage(text);
		for spell in string.gfind( text, SHT_SPELL_RANK_STRIP ) do --strip the (Rank #) portion
			--DEFAULT_CHAT_FRAME:AddMessage(text.." "..spell);
			text = spell;
		end
		if( string.find( text, SHT_AIMED_SHOT ) ) then
			if( SHTvars["skills"][SHT_AIMED_SHOT] and not SHTvars["aimed"]) then
				SHTvars["aimed"] = true;
				local duration = 3;
				if( SHTvars["rapid"] ) then
					duration = duration / 1.4;
				end
				if( SHTvars["quick"] ) then
					duration = duration / 1.3;
				end
				if ( SHTvars["berserking"] ) then
					duration = duration / (1 + berserkValue);
				end
				if( SHTvars["spider"] ) then
					duration = duration / 1.2;
				end

				shtcasting = true;
				local name = UnitName("player");
				local arg1 = SHT_AIMED_SHOT;
				local arg2 = duration * 1000 + SHTvars["aimeddelay"];
				
				if( IsAddOnLoaded("MetaHud") and MetaHudOptions["castingbar"] == 1 ) then
					MetaHud.spellname  = arg1;
					MetaHud_EventFrame.startTime  = GetTime();
					MetaHud_EventFrame.maxValue   = MetaHud_EventFrame.startTime + (arg2 / 1000);
					MetaHud_EventFrame.holdTime   = 0;
					MetaHud_EventFrame.casting    = 1;
					MetaHud_EventFrame.delay      = 0;
					MetaHud_EventFrame.channeling = nil;
					MetaHud_EventFrame.fadeOut    = nil;
					MetaHud_EventFrame.flash      = nil;
					MetaHud_EventFrame.duration   = floor(arg2 / 100) / 10;
					MetaHud.Casting    = true;
					MetaHud:updateAlpha();
					MetaHud_Casttime_Text:SetAlpha(1);
					MetaHud_Castdelay_Text:SetAlpha(1);
					MetaHud_Casting_Bar:Show();
					MetaHud_Flash_Bar:Hide();
					
				elseif( IsAddOnLoaded("Perl_ArcaneBar") and Perl_ArcaneBar_Config[name]["Enabled"] == 1 ) then
					Perl_ArcaneBar:SetStatusBarColor(1.0, 0.7, 0.0, Perl_ArcaneBar_Config[name]["Transparency"]);
					Perl_ArcaneBarSpark:Show();
					Perl_ArcaneBarFrame.startTime = GetTime();
					Perl_ArcaneBarFrame.maxValue = Perl_ArcaneBarFrame.startTime + (arg2 / 1000);
					Perl_ArcaneBar:SetMinMaxValues(Perl_ArcaneBarFrame.startTime, Perl_ArcaneBarFrame.maxValue);
					Perl_ArcaneBar:SetValue(Perl_ArcaneBarFrame.startTime);
					Perl_ArcaneBarFrame:SetAlpha(0.8);
					Perl_ArcaneBarFrame.holdTime = 0;
					Perl_ArcaneBarFrame.casting = 1;
					Perl_ArcaneBarFrame.fadeOut = nil;
					Perl_ArcaneBarFrame:Show();
					Perl_ArcaneBarFrame.delaySum = 0;
					if (Perl_ArcaneBar_Config[name]["ShowTimer"] == 1) then
						Perl_ArcaneBar_CastTime:Show();
					else
						Perl_ArcaneBar_CastTime:Hide();
					end
					Perl_ArcaneBarFrame.mode = "casting";
				end					

				if( IsAddOnLoaded("eCastingBar") and eCastingBar_Saved[eCastingBar_Player].Enabled == 1 ) then
					eCastingBar_SpellcastStart( "", arg1, arg2 );
				elseif ( IsAddOnLoaded("otravi_CastingBar") ) then
					otravi_CastingBar:SpellStart(arg1,arg2);
				elseif ( IsAddOnLoaded("oCB") ) then
					oCB:SpellStart(arg1,arg2);
				end

				if( IsAddOnLoaded("ArcHUD2") and ArcHUD:HasModule("Casting") and ArcHUD:IsModuleActive("Casting") ) then
					ArcHUD:GetModule("Casting").f:UpdateColor({["r"] = 1.0, ["g"] = 0.7, ["b"] = 0});
					ArcHUD:GetModule("Casting").Text:SetText(arg1);
					ArcHUD:GetModule("Casting").startValue = 0;
					ArcHUD:GetModule("Casting").f:SetMax(arg2);
					ArcHUD:GetModule("Casting").channeling = 0;
					ArcHUD:GetModule("Casting").f.casting = 1;
					ArcHUD:GetModule("Casting").spellstart = GetTime();
					ArcHUD:GetModule("Casting").stopSet = false;
					if(ArcHUD.db.profile.FadeIC > ArcHUD.db.profile.FadeOOC) then
						ArcHUD:GetModule("Casting").f:SetRingAlpha(ArcHUD.db.profile.FadeIC);
					else
						ArcHUD:GetModule("Casting").f:SetRingAlpha(ArcHUD.db.profile.FadeOOC);
					end
					
				elseif ( IsAddOnLoaded("Bongos_CastBar") ) then
					BCastBarCastBar:SetStatusBarColor(1.0, 0.7, 0.0);
					BCastBarCastBarSpark:Show();
					BCastBarCastBar.startTime = GetTime();
					BCastBarCastBar.maxValue = BCastBarCastBar.startTime + (arg2 / 1000);
					BCastBarCastBar:SetMinMaxValues(BCastBarCastBar.startTime, BCastBarCastBar.maxValue);
					BCastBarCastBar:SetValue(BCastBarCastBar.startTime);
					BCastBarCastBarText:SetText(arg1);
					BCastBarCastBar:SetAlpha( BCastBarCastBar:GetParent():GetAlpha() );
					BCastBarCastBar.holdTime = 0;
					BCastBarCastBar.casting = 1;
					BCastBarCastBar.fadeOut = nil;
					BCastBarCastBar:Show();
					BCastBarCastBar.mode = "casting";

				elseif ( IsAddOnLoaded("Nurfed_Hud") ) then 
					Nurfed_Hudcastingbar:SetVertexColor(1.0, 1.0, 0.0);
					Nurfed_Hudcastingspell:SetText(arg1);
					Nurfed_Hudcasting.startTime = GetTime();
					Nurfed_Hudcasting.maxValue = Nurfed_Hudcasting.startTime + (arg2 / 1000);
					Nurfed_Hudcasting:SetAlpha(1.0);
					Nurfed_Hudcasting.holdTime = 0;
					Nurfed_Hudcasting.casting = 1;
					Nurfed_Hudcasting.fadeOut = nil;
					Nurfed_Hudcasting:Show();
					Nurfed_Hudcasting.mode = "casting";

				else
					if( IsAddOnLoaded("CastTime") ) then
						CastTime.delaySum = 0;
						CastTime.spellname = arg1;
						CastTime.startTime = GetTime();
						CastTime.maxValue = CastTime.startTime + (arg2 / 1000);
						CastTimeFrame:Show();
					end
					
					if( IsAddOnLoaded("CT_MasterMod") ) then
						CT_CastBarFrame.spellName = arg1;
					end
					
					if ( IsAddOnLoaded("MetaHud") and MetaHudOptions["bcastingbar"] == 0 ) then
					
					elseif ( IsAddOnLoaded("Perl_ArcaneBar") and Perl_ArcaneBar_Config[name]["HideOriginal"] == 1 ) then
					
					elseif ( IsAddOnLoaded("eCastingBar") and eCastingBar_Saved[eCastingBar_Player].Enabled == 1 ) then
					
					elseif ( IsAddOnLoaded("otravi_CastingBar") ) then
					
					elseif ( IsAddOnLoaded("oCB") ) then
					
					else
						CastingBarFrameStatusBar:SetStatusBarColor(1.0, 0.7, 0.0);
						CastingBarSpark:Show();
						CastingBarFrame.startTime = GetTime();
						CastingBarFrame.maxValue = CastingBarFrame.startTime + (arg2 / 1000);
						CastingBarFrameStatusBar:SetMinMaxValues(CastingBarFrame.startTime, CastingBarFrame.maxValue);
						CastingBarFrameStatusBar:SetValue(CastingBarFrame.startTime);
						CastingBarText:SetText(arg1);
						CastingBarFrame:SetAlpha(1.0);
						CastingBarFrame.holdTime = 0;
						CastingBarFrame.casting = 1;
						CastingBarFrame.fadeOut = nil;
						CastingBarFrame:Show();
						CastingBarFrame.mode = "casting";
					end
				end
			end
		end
		if( SHT_sfind( text, SHT_STING ) 
		    or string.find( text, SHT_TRAP ) 
		    or string.find( text, SHT_INTIM ) 
		    or string.find( text, SHT_BW ) 
		    or string.find( text, SHT_FLARE )
		    or string.find( text, SHT_HUNTERS_MARK )
		    or string.find( text, SHT_CONC_SHOT )
		    or string.find( text, SHT_SCATTER ) 
		    or string.find( text, SHT_AIMED_SHOT ) ) then
			checkForSpellFail = true;
			checkForSpellName = text;
		elseif ( string.find( text, SHT_FEIGN_DEATH ) ) then
			-- Do nothing or FD/trap macros break
		elseif( not string.find( text, SHT_AUTO_SHOT ) ) then
			checkForSpellFail = true;
			checkForSpellName = "dummy for autoshot";
			--DEFAULT_CHAT_FRAME:AddMessage("Button pressed: "..text, 1, 1, 0 );
		end
	end
end

function SHunterTimers_ShowOptions()
	for i=1, SHT_NUM_TIMERS do
		if( SHTvars["skills"][SHT_OPTIONS_TIMERS[i]] ) then
			getglobal("SHunterTimersOptionsTimersCheckButton"..i):SetChecked(1);
		else
			getglobal("SHunterTimersOptionsTimersCheckButton"..i):SetChecked(0);
		end
	end
	
	if( SHTvars[SHT_ON] ) then
		SHunterTimersOptionsBarsCheckButtonOn:SetChecked(1);
	else
		SHunterTimersOptionsBarsCheckButtonOn:SetChecked(0);
	end
	
	if( SHTvars["locked"] ) then
		SHunterTimersOptionsBarsCheckButton1:SetChecked(1);
	else
		SHunterTimersOptionsBarsCheckButton1:SetChecked(0);
	end
	
	if( SHTvars["colorchange"] ) then
		SHunterTimersOptionsBarsCheckButton2:SetChecked(1);
	else
		SHunterTimersOptionsBarsCheckButton2:SetChecked(0);
	end
	
	if( SHTvars["showtex"] ) then
		SHunterTimersOptionsBarsCheckButton3:SetChecked(1);
	else
		SHunterTimersOptionsBarsCheckButton3:SetChecked(0);
	end
	
	if( SHTvars["largetex"] ) then
		SHunterTimersOptionsBarsCheckButton4:SetChecked(1);
	else
		SHunterTimersOptionsBarsCheckButton4:SetChecked(0);
	end
	
	if( SHTvars["gap"] ) then
		SHunterTimersOptionsBarsCheckButton5:SetChecked(0);
	else
		SHunterTimersOptionsBarsCheckButton5:SetChecked(1);
	end

	if( SHTvars["append"] ) then
		SHunterTimersOptionsBarsCheckButton6:SetChecked(1);
	else
		SHunterTimersOptionsBarsCheckButton6:SetChecked(0);
	end

	if( SHTvars["padding"] ) then
		SHunterTimersOptionsBarsCheckButton7:SetChecked(0);
	else
		SHunterTimersOptionsBarsCheckButton7:SetChecked(1);
	end
	
	if( SHTvars["hidetext"] ) then
		SHunterTimersOptionsBarsCheckButton8:SetChecked(1);
	else
		SHunterTimersOptionsBarsCheckButton8:SetChecked(0);
	end

	if( SHTvars["hidetime"] ) then
		SHunterTimersOptionsBarsCheckButton9:SetChecked(1);
	else
		SHunterTimersOptionsBarsCheckButton9:SetChecked(0);
	end

	if( SHTvars["sticky"] ) then
		SHunterTimersOptionsBarsCheckButton10:SetChecked(1);
	else
		SHunterTimersOptionsBarsCheckButton10:SetChecked(0);
	end

	if( SHTvars["down"] ) then
		SHunterTimersOptionsBarsCheckButton11:SetChecked(1);
	else
		SHunterTimersOptionsBarsCheckButton11:SetChecked(0);
	end

	SHunterTimersOptionsBarsEditBox1:SetText(SHTvars["aimeddelay"]);
	SHunterTimersOptionsBarsEditBox2:SetText(SHTvars["shotdelay"]);
	
	local r, g, b, a = unpack(SHTvars["barstartcolor"]);
	local rd, gd, bd, ad = unpack( SHTvars["bardelta"] );
	rd = rd + r;
	gd = gd + g;
	bd = bd + b;
	ad = ad + a;
	SHunterTimersOptionsBarsColor1Swatch:SetVertexColor(r, g, b);
	SHunterTimersOptionsBarsColor1Swatch.r = r;
	SHunterTimersOptionsBarsColor1Swatch.g = g;
	SHunterTimersOptionsBarsColor1Swatch.b = b;
	SHunterTimersOptionsBarsColor1Swatch.a = a;
	SHunterTimersOptionsBarsColor2Swatch:SetVertexColor(rd, gd, bd);
	SHunterTimersOptionsBarsColor2Swatch.r = rd;
	SHunterTimersOptionsBarsColor2Swatch.g = gd;
	SHunterTimersOptionsBarsColor2Swatch.b = bd;
	SHunterTimersOptionsBarsColor2Swatch.a = ad;
	SHunterTimersOptionsBarsColor3Swatch:SetVertexColor(SHTvars["bg"].r, SHTvars["bg"].g, SHTvars["bg"].b, SHTvars["bg"].a);
	SHunterTimersOptionsBarsColor3Swatch.r = SHTvars["bg"].r;
	SHunterTimersOptionsBarsColor3Swatch.g = SHTvars["bg"].g;
	SHunterTimersOptionsBarsColor3Swatch.b = SHTvars["bg"].b;
	SHunterTimersOptionsBarsColor3Swatch.a = SHTvars["bg"].a;
	SHunterTimersOptionsBarsColor4Swatch:SetVertexColor( unpack( SHTvars["borderalpha"]) );
	SHunterTimersOptionsBarsColor4Swatch.r, SHunterTimersOptionsBarsColor4Swatch.g, SHunterTimersOptionsBarsColor4Swatch.b, SHunterTimersOptionsBarsColor4Swatch.a = unpack( SHTvars["borderalpha"] );
	SHunterTimersOptionsBarsColor5Swatch:SetVertexColor(unpack(SHTvars["skillcolor"]));
	SHunterTimersOptionsBarsColor5Swatch.r, SHunterTimersOptionsBarsColor5Swatch.g, SHunterTimersOptionsBarsColor5Swatch.b, SHunterTimersOptionsBarsColor5Swatch.a = unpack( SHTvars["skillcolor"] );
	SHunterTimersOptionsBarsColor6Swatch:SetVertexColor(unpack(SHTvars["timecolor"]));
	SHunterTimersOptionsBarsColor6Swatch.r, SHunterTimersOptionsBarsColor6Swatch.g, SHunterTimersOptionsBarsColor6Swatch.b, SHunterTimersOptionsBarsColor6Swatch.a = unpack( SHTvars["timecolor"] );
	SHunterTimersOptionsBarsColor7Swatch:SetVertexColor(unpack(SHTvars["targetcolor"]));
	SHunterTimersOptionsBarsColor7Swatch.r, SHunterTimersOptionsBarsColor7Swatch.g, SHunterTimersOptionsBarsColor7Swatch.b, SHunterTimersOptionsBarsColor7Swatch.a = unpack( SHTvars["targetcolor"] );
	
	SHunterTimersOptionsBarsSlider1Slider:SetValue(SHTvars["bardistance"]);
	SHunterTimersOptionsBarsSlider2Slider:SetValue(SHTvars["scale"]/UIParent:GetScale());
	SHunterTimersOptionsBarsSlider3Slider:SetValue(SHTvars["mili"]);
	SHunterTimersOptionsBarsSlider4Slider:SetValue(SHTvars["flash"]);
	SHunterTimersOptionsBarsSlider5Slider:SetValue(SHTvars["step"]);
	SHunterTimersOptionsBarsSlider6Slider:SetValue(SHTvars["overallalpha"]);
	SHunterTimersOptionsBarsSlider7Slider:SetValue(SHTvars["barheight"]);
	
	SHunterTimersOptions:Show();
end

function SHunterTimers_SaveOptions()

	for i=1, SHT_NUM_TIMERS do
		if( getglobal("SHunterTimersOptionsTimersCheckButton"..i):GetChecked() == 1 ) then
			SHTvars["skills"][SHT_OPTIONS_TIMERS[i]] = true;
		else
			SHTvars["skills"][SHT_OPTIONS_TIMERS[i]] = false;
		end
	end
	
	if( SHunterTimersOptionsBarsCheckButtonOn:GetChecked() == 1 ) then
		SHTvars[SHT_ON] = true;
	else
		SHTvars[SHT_ON] = false;
	end
	
	if( SHunterTimersOptionsBarsCheckButton1:GetChecked() == 1 ) then
		SHTvars["locked"] = true;
		SHunterTimersAnchor:Hide();
	else
		SHTvars["locked"] = false;
		SHunterTimersAnchor:Show();
	end
	
	if( SHunterTimersOptionsBarsCheckButton2:GetChecked() == 1 ) then
		SHTvars["colorchange"] = true;
	else
		SHTvars["colorchange"] = false;
	end
	
	if( SHunterTimersOptionsBarsCheckButton3:GetChecked() == 1 ) then
		SHTvars["showtex"] = true;
	else
		SHTvars["showtex"] = false;
	end

	if( SHunterTimersOptionsBarsCheckButton4:GetChecked() == 1 ) then
		SHTvars["largetex"] = true;
	else
		SHTvars["largetex"] = false;
	end

	if( SHunterTimersOptionsBarsCheckButton5:GetChecked() == 1 ) then
		SHTvars["gap"] = false;
	else
		SHTvars["gap"] = true;
	end

	if( SHunterTimersOptionsBarsCheckButton6:GetChecked() == 1 ) then
		SHTvars["append"] = true;
	else
		SHTvars["append"] = false;
	end

	if( SHunterTimersOptionsBarsCheckButton7:GetChecked() == 1 ) then
		SHTvars["padding"] = false;
	else
		SHTvars["padding"] = true;
	end
	
	if( SHunterTimersOptionsBarsCheckButton8:GetChecked() == 1 ) then
		SHTvars["hidetext"] = true;
	else
		SHTvars["hidetext"] = false;
	end

	if( SHunterTimersOptionsBarsCheckButton9:GetChecked() == 1 ) then
		SHTvars["hidetime"] = true;
	else
		SHTvars["hidetime"] = false;
	end

	if( SHunterTimersOptionsBarsCheckButton10:GetChecked() == 1 ) then
		SHTvars["sticky"] = true;
	else
		SHTvars["sticky"] = false;
	end

	if( SHunterTimersOptionsBarsCheckButton11:GetChecked() == 1 ) then
		SHTvars["down"] = true;
	else
		SHTvars["down"] = false;
	end

	SHTvars["aimeddelay"] = 1*SHunterTimersOptionsBarsEditBox1:GetText();
	SHTvars["shotdelay"] = 1*SHunterTimersOptionsBarsEditBox2:GetText();
	
	SHTvars["barstartcolor"][1] = SHunterTimersOptionsBarsColor1Swatch.r; 
	SHTvars["barstartcolor"][2] = SHunterTimersOptionsBarsColor1Swatch.g; 
	SHTvars["barstartcolor"][3] = SHunterTimersOptionsBarsColor1Swatch.b;
	SHTvars["barstartcolor"][4] = SHunterTimersOptionsBarsColor1Swatch.a;
	SHTvars["bardelta"][1] = SHunterTimersOptionsBarsColor2Swatch.r - SHunterTimersOptionsBarsColor1Swatch.r;
	SHTvars["bardelta"][2] = SHunterTimersOptionsBarsColor2Swatch.g - SHunterTimersOptionsBarsColor1Swatch.g;
	SHTvars["bardelta"][3] = SHunterTimersOptionsBarsColor2Swatch.b - SHunterTimersOptionsBarsColor1Swatch.b;
	SHTvars["bardelta"][4] = SHunterTimersOptionsBarsColor2Swatch.a - SHunterTimersOptionsBarsColor1Swatch.a;
	SHTvars["borderalpha"][1] = SHunterTimersOptionsBarsColor4Swatch.r;
	SHTvars["borderalpha"][2] = SHunterTimersOptionsBarsColor4Swatch.g;
	SHTvars["borderalpha"][3] = SHunterTimersOptionsBarsColor4Swatch.b;
	SHTvars["borderalpha"][4] = SHunterTimersOptionsBarsColor4Swatch.a;
	SHTvars["skillcolor"][1] = SHunterTimersOptionsBarsColor5Swatch.r;
	SHTvars["skillcolor"][2] = SHunterTimersOptionsBarsColor5Swatch.g;
	SHTvars["skillcolor"][3] = SHunterTimersOptionsBarsColor5Swatch.b;
	SHTvars["skillcolor"][4] = SHunterTimersOptionsBarsColor5Swatch.a;
	SHTvars["timecolor"][1] = SHunterTimersOptionsBarsColor6Swatch.r;
	SHTvars["timecolor"][2] = SHunterTimersOptionsBarsColor6Swatch.g;
	SHTvars["timecolor"][3] = SHunterTimersOptionsBarsColor6Swatch.b;
	SHTvars["timecolor"][4] = SHunterTimersOptionsBarsColor6Swatch.a;
	SHTvars["targetcolor"][1] = SHunterTimersOptionsBarsColor7Swatch.r;
	SHTvars["targetcolor"][2] = SHunterTimersOptionsBarsColor7Swatch.g;
	SHTvars["targetcolor"][3] = SHunterTimersOptionsBarsColor7Swatch.b;
	SHTvars["targetcolor"][4] = SHunterTimersOptionsBarsColor7Swatch.a;
	
	SHTvars["bg"].r = SHunterTimersOptionsBarsColor3Swatch.r;
	SHTvars["bg"].g = SHunterTimersOptionsBarsColor3Swatch.g;
	SHTvars["bg"].b = SHunterTimersOptionsBarsColor3Swatch.b;
	SHTvars["bg"].a = SHunterTimersOptionsBarsColor3Swatch.a;
	
	SHTvars["bardistance"] = SHunterTimersOptionsBarsSlider1Slider:GetValue();
	SHTvars["scale"] = SHunterTimersOptionsBarsSlider2Slider:GetValue()*UIParent:GetScale();
	SHTvars["mili"] = SHunterTimersOptionsBarsSlider3Slider:GetValue();
	SHTvars["flash"] = SHunterTimersOptionsBarsSlider4Slider:GetValue();
	SHTvars["step"] = SHunterTimersOptionsBarsSlider5Slider:GetValue();
	SHTvars["overallalpha"] = SHunterTimersOptionsBarsSlider6Slider:GetValue();
	SHTvars["barheight"] = SHunterTimersOptionsBarsSlider7Slider:GetValue();
	
	SHunterTimers_SetSettings();
	
end

function SHunterTimers_SaveCloseOptions()
	
	SHunterTimers_SaveOptions();
	SHunterTimersOptions:Hide();

end

function SHunterTimers_ResetOptions()

	SHTvars = {};
	
	SHTvars["bg"] = { r=0, g=0, b=0, a=7 };

	SHTvars[SHT_ON] = true;

	SHTvars["borderalpha"] = {
		[1] = 1;
		[2] = 1;
		[3] = 1;
		[4] = 1;
	};

	SHunterTimersFrame:SetBackdropColor( SHTvars["bg"].r, SHTvars["bg"].g, SHTvars["bg"].b, SHTvars["bg"].a );
	SHunterTimersFrame:SetBackdropBorderColor( unpack(SHTvars["borderalpha"]) );
	SHTvars["numBars"] = 0;

	SHTvars["skills"] = {};

	for i=1, SHT_NUM_TIMERS do
		if( SHTvars["skills"][SHT_OPTIONS_TIMERS[i]] == nil ) then
			SHTvars["skills"][SHT_OPTIONS_TIMERS[i]] = true;
		end
	end
	
	SHTvars["shotdelay"] = 200;

	SHTvars["aimeddelay"] = 200;

	SHTvars["scale"] = UIParent:GetScale();

	SHTvars["locked"] = false;
	SHunterTimersAnchor:Show();

	SHTvars["down"] = true;
	SHunterTimersFrame:ClearAllPoints();
	SHunterTimersFrame:SetPoint( "TOPLEFT", "SHunterTimersAnchor", "BOTTOMRIGHT" );

	SHTvars["mili"] = 2;

	SHTvars["flash"] = 5;
	
	local r, g, b = SHunterTimersStatus1BarLeftText:GetTextColor();
	SHTvars["skillcolor"] = {
		[1] = r,
		[2] = g,
		[3] = b,
		[4] = 1
	};

	local r, g, b = SHunterTimersStatus1BarRightText:GetTextColor();
	SHTvars["timecolor"] = {
		[1] = r,
		[2] = g,
		[3] = b,
		[4] = 1
	};

	local r, g, b = SHunterTimersStatus1BarLeftText:GetTextColor();
	SHTvars["targetcolor"] = {
		[1] = r,
		[2] = g,
		[3] = b,
		[4] = 1
	};

	SHTvars["barstartcolor"] = {
		[1] = 0,
		[2] = 0.8,
		[3] = 0,
		[4] = 1
	};

	SHTvars["bardelta"] = {
		[1] = 0.8,
		[2] = -0.8,
		[3] = 0,
		[4] = 0};

	SHTvars["step"] = 0.015;

	SHTvars["colorchange"] = false;

	SHTvars["bardistance"] = 10;

	SHTvars["append"] = false;

	SHTvars["overallalpha"] = 1;
	
	SHunterTimers_ClearActiveSpells();
	
	for i=1, SHT_NUM_TIMERS do --Check boxes
		getglobal("SHunterTimersOptionsTimersCheckButton"..i.."Text"):SetText(SHT_OPTIONS_TIMERS[i]);
	end
	
	for i=1, SHT_NUM_OPTIONS do --Check boxes
		getglobal("SHunterTimersOptionsBarsCheckButton"..i.."Text"):SetText(SHT_OPTIONS_BARS[i]);
	end
	
	for i=1, SHT_NUM_SLIDERS do  --Sliders
		getglobal("SHunterTimersOptionsBarsSlider"..i.."SliderTitle"):SetText(SHT_OPTIONS_SLIDER[i]);
		getglobal("SHunterTimersOptionsBarsSlider"..i.."SliderLow"):SetText(SHT_OPTIONS_SLIDER_ENDS[i][1])
		getglobal("SHunterTimersOptionsBarsSlider"..i.."SliderHigh"):SetText(SHT_OPTIONS_SLIDER_ENDS[i][2]);
	end
	
	SHTvars["textures"] = {};
	SHunterTimers_UpdateSpells();
	
	SHTvars["showtex"] = true;

	SHTvars["largetex"] = false;

	SHTvars["hidetext"] = false;

	SHTvars["hidetime"] = false;

	SHTvars["gap"] = true;

	SHTvars["padding"] = true;

	SHTvars["barheight"] = 10;

	SHTvars["sticky"] = true;
	
	local _, _, _, _, rank = GetTalentInfo( 3, 7 ); --Clever traps
	SHTvars["traptimemult"] = 1 + (rank * 0.15);
	
	getglobal("SHunterTimersOptionsTimersLabel1Label"):SetText(SHT_OPTIONS_TIMERS_TEXT);

	for i=1, SHT_NUM_LABELS do
		getglobal("SHunterTimersOptionsBarsLabel"..i.."Label"):SetText(SHT_OPTIONS_LABELS[i]);
	end
	
	getglobal("SHunterTimersOptionsTitleString"):SetText("Sorren's Hunter Timers "..SHT_VERSION);
	
	SHunterTimers_SetSettings();
	
end

function SHunterTimers_SetSettings()
	
	if( SHTvars[SHT_ON] ) then
		UseAction = SHunterTimers_OnUseAction;
		CastSpellByName = SHunterTimers_OnCastSpellByName;
		CastSpell = SHunterTimers_OnCastSpell;
	else
		UseAction = SHunterTimers_Real_UseAction;
		CastSpellByName = SHunterTimers_Real_CastSpellByName;
		CastSpell = SHunterTimers_Real_CastSpell;
	end
	
	SHunterTimersFrame:SetBackdropColor(SHTvars["bg"].r, SHTvars["bg"].g, SHTvars["bg"].b, SHTvars["bg"].a);
	SHunterTimersFrame:SetBackdropBorderColor(unpack(SHTvars["borderalpha"] ) );
	
	if( SHTvars["down"] ) then
		SHunterTimersFrame:ClearAllPoints();
		SHunterTimersFrame:SetPoint( "TOPLEFT", "SHunterTimersAnchor", "BOTTOMRIGHT" );
	else
		SHunterTimersFrame:ClearAllPoints();
		SHunterTimersFrame:SetPoint( "BOTTOMLEFT", "SHunterTimersAnchor", "TOPRIGHT" );
	end

	for i=1, SHT_NUM_BARS do
		local barframe = getglobal("SHunterTimersStatus"..i);
		local bar = getglobal( "SHunterTimersStatus"..i.."Bar");
		local bg = getglobal( "SHunterTimersStatus"..i.."BGBar");
		local barwidth = 220;
		
		barframe:SetHeight( SHTvars["barheight"] );
		bar:SetHeight( SHTvars["barheight"] );
		bg:SetHeight( SHTvars["barheight"] );
		local icon = getglobal("SHunterTimersStatus"..i.."Icon");
		if( SHTvars["showtex"] ) then
			
			icon:Show();
			if( SHTvars["gap"] ) then
				barwidth = barwidth - 5;
			end
			if( SHTvars["largetex"] ) and ( SHTvars["barheight"] < 16) then
				barframe:SetHeight(16);
				icon:SetHeight(16);
				icon:SetWidth(16);
				barwidth = barwidth - 16;
			else
				icon:SetHeight( SHTvars["barheight"] );
				icon:SetWidth( SHTvars["barheight"] );
				barwidth = barwidth - SHTvars["barheight"];
			end
			
			bar:ClearAllPoints();
			if( SHTvars["gap"] ) then
				bar:SetPoint("LEFT", "SHunterTimersStatus"..i.."Icon", "RIGHT", 5, 0 );
			else
				bar:SetPoint("LEFT", "SHunterTimersStatus"..i.."Icon", "RIGHT", 0, 0 );
			end
			bg:ClearAllPoints();
			if( SHTvars["gap"] ) then
				bg:SetPoint("LEFT", "SHunterTimersStatus"..i.."Icon", "RIGHT", 5, 0 );
			else
				bg:SetPoint("LEFT", "SHunterTimersStatus"..i.."Icon", "RIGHT", 0, 0 );
			end
		else
			icon:Hide();
			bar:SetPoint("LEFT", "SHunterTimersStatus"..i, "LEFT", 0, 0 );
			bg:SetPoint("LEFT", "SHunterTimersStatus"..i, "LEFT", 0, 0 );
		end
		barframe:SetWidth(220);
		bar:SetWidth(barwidth);
		bg:SetWidth(barwidth);
		if( SHTvars["hidetext"] ) then
			getglobal("SHunterTimersStatus"..i.."BarLeftText"):Hide();
		else
			getglobal("SHunterTimersStatus"..i.."BarLeftText"):Show();
		end
		if( SHTvars["hidetime"] ) then
			getglobal("SHunterTimersStatus"..i.."BarRightText"):Hide();
		else
			getglobal("SHunterTimersStatus"..i.."BarRightText"):Show();
		end
	end
	
	
	local height; 
	if( not SHTvars["largetex"] ) or ( SHTvars["barheight"] >= 16 ) then
		height = SHTvars["numBars"] * (SHTvars["barheight"] + SHTvars["bardistance"]) - SHTvars["bardistance"] + 10;
	else
		height = SHTvars["numBars"] * (16 + SHTvars["bardistance"]) - SHTvars["bardistance"] + 10;
	end
	
	if( SHTvars["padding"] ) then
		SHunterTimersFrame:SetWidth( 240 );
		SHunterTimersStatus1:SetPoint( "TOPLEFT", "SHunterTimersFrame", "TOPLEFT", 10, -10 );
		height = height + 10;
		
	else
		SHunterTimersFrame:SetWidth( 230 );
		SHunterTimersStatus1:SetPoint( "TOPLEFT", "SHunterTimersFrame", "TOPLEFT", 5, -5 );
	end
	
	SHunterTimersFrame:SetHeight(height);
	
	for i=2, SHT_NUM_BARS do
		getglobal("SHunterTimersStatus"..i):ClearAllPoints();
		getglobal("SHunterTimersStatus"..i):SetPoint("TOP", "SHunterTimersStatus"..(i-1), "BOTTOM", 0, -SHTvars["bardistance"]);
		
	end
	
	SHunterTimersFrame:SetScale( SHTvars["scale"] );
	SHunterTimersFrame:SetAlpha( SHTvars["overallalpha"] );
	for i=1, SHT_NUM_BARS do
		getglobal("SHunterTimersStatus"..i):SetScale( SHTvars["scale"] );
		getglobal("SHunterTimersStatus"..i):SetAlpha( SHTvars["overallalpha"] );
	end

end

function SHT_SetHeight()
	local height; 
	if( not SHTvars["largetex"] ) or ( SHTvars["barheight"] >= 16 ) then
		height = SHTvars["numBars"] * (SHTvars["barheight"] + SHTvars["bardistance"]) - SHTvars["bardistance"] + 10;
	else
		height = SHTvars["numBars"] * (16 + SHTvars["bardistance"]) - SHTvars["bardistance"] + 10;
	end
	
	if( SHTvars["padding"] ) then
		height = height + 10;
	end
	
	SHunterTimersFrame:SetHeight(height);
	SHunterTimers_SetWidths();
end

function SHunterTimers_UpdateSpells()

	for key,val in pairs(SHTvars["skills"]) do
		local i = 1;
		while( GetSpellTexture(i, BOOKTYPE_SPELL) ) do
			local spellName = GetSpellName(i, BOOKTYPE_SPELL);
			if( spellName == key ) then
				SHTvars["textures"][key] = GetSpellTexture(i, BOOKTYPE_SPELL);
				break;
			end
			i = i + 1;
		end
	end

	SHTvars["textures"][SHT_QUICK_SHOTS] = "Interface\\Icons\\Ability_Warrior_InnerRage";
	SHTvars["textures"][SHT_FRENZY] = "Interface\\Icons\\Ability_Druid_ChallangingRoar";
	SHTvars["textures"][SHT_EXPOSE_WEAKNESS] = "Interface\\Icons\\Ability_Hunter_SniperShot";
	SHTvars["textures"][SHT_PRIMAL_BLESSING] = "Interface\\Icons\\Ability_Hunter_Harass";
	SHTvars["textures"][SHT_ENTRAPMENT] = "Interface\\Icons\\Spell_Nature_StrangleVines";
	SHTvars["textures"][SHT_DEVILSAUR] = "Interface\\Icons\\Ability_Hunter_Pet_Raptor";
	SHTvars["textures"][SHT_ZHM] = "Interface\\Icons\\INV_Jewelry_Necklace_13";
	SHTvars["textures"][SHT_EARTHSTRIKE] = "Interface\\Icons\\Spell_Nature_AbolishMagic";
	SHTvars["textures"][SHT_SWARMGUARD] = "INV_Misc_AhnQirajTrinket_04";
	SHTvars["textures"][SHT_JOM_GABBAR] = "Interface\\Icons\\Ability_Poisons";
	SHTvars["textures"][SHT_KISS_SPIDER] = "Interface\\Icons\\INV_Trinket_Naxxramas04";
end

function SHunterTimers_ClearActiveSpells()

	SHTvars["concuss"] = false;
	SHTvars["impconc"] = false;
	SHTvars["rapid"] = false;
	SHTvars["quick"] = false;
	SHTvars["petIntim"] = false;
	SHTvars["intimidate"] = false;
	SHTvars["deterrence"] = false;
	SHTvars["wingclip"] = false;
	SHTvars["impwing"] = false;
	SHTvars["freezing"] = false;
	SHTvars["scatter"] = false;
	SHTvars["wyvern"] = false;
	SHTvars["fearbeast"] = false;
	SHTvars["exposeweak"] = false;
	SHTvars["huntersmark"] = false;
	SHTvars["primalblessing"] = false;
	SHTvars["entrapment"] = false;
	SHTvars["aimed"] = false;
	SHTvars["berserking"] = false;
	SHTvars["devilsaur"] = false;
	SHTvars["zhm"] = false;
	SHTvars["earthstrike"] = false;
	SHTvars["swarmguard"] = false;
	SHTvars["jomgabbar"] = false;
	SHTvars["spider"] = false;
	
end

local SHTSetColorFunc = {
	[1] = function() SHTSetColor(1) end,
	[2] = function() SHTSetColor(2) end,
	[3] = function() SHTSetColor(3) end,
	[4] = function() SHTSetColor(4) end,
	[5] = function() SHTSetColor(5) end,
	[6] = function() SHTSetColor(6) end,
	[7] = function() SHTSetColor(7) end
};

local SHTSetOpacityFunc = {
	[1] = function() SHTSetOpacity(1) end,
	[2] = function() SHTSetOpacity(2) end,
	[3] = function() SHTSetOpacity(3) end,
	[4] = function() SHTSetOpacity(4) end,
	[5] = function() SHTSetOpacity(5) end,
	[6] = function() SHTSetOpacity(6) end,
	[7] = function() SHTSetOpacity(7) end
};

local SHTCancelFunc = {
	[1] = function(x) SHTCancelColor(1, x) end,
	[2] = function(x) SHTCancelColor(2, x) end,
	[3] = function(x) SHTCancelColor(3, x) end,
	[4] = function(x) SHTCancelColor(4, x) end,
	[5] = function(x) SHTCancelColor(5, x) end,
	[6] = function(x) SHTCancelColor(6, x) end,
	[7] = function(x) SHTCancelColor(7, x) end
};

function SHT_ColorPicker(id)
	CloseMenus();
	local texture = getglobal("SHunterTimersOptionsBarsColor"..id.."Swatch");
	ColorPickerFrame.func = SHTSetColorFunc[id];
	ColorPickerFrame:SetColorRGB(texture.r, texture.g, texture.b);
	ColorPickerFrame.previousValues = {r = texture.r, g = texture.g, b = texture.b, opacity =texture.a};
	ColorPickerFrame.cancelFunc = SHTCancelFunc[id];
	if( id < 5 ) then
		ColorPickerFrame.hasOpacity = true;
		ColorPickerFrame.opacity = 1 - texture.a;
		ColorPickerFrame.opacityFunc = SHTSetOpacityFunc[id];
	else
		ColorPickerFrame.hasOpacity = false;
	end
	
	
	--OpacityFrame.opacityFunc = SHTSetOpacityFunc[id];
	
	ColorPickerFrame:Show();
end

function SHTSetOpacity(id)
	local a = 1 - OpacitySliderFrame:GetValue();
	local texture = getglobal("SHunterTimersOptionsBarsColor"..id.."Swatch");
	--DEFAULT_CHAT_FRAME:AddMessage(id);
	texture:SetAlpha(a);
	texture.a = a;
end

function SHTSetColor(id)
	local r, g, b = ColorPickerFrame:GetColorRGB();
	local texture = getglobal("SHunterTimersOptionsBarsColor"..id.."Swatch");
	--SHTSetOpacity(id);
	texture:SetVertexColor(r, g, b);
	texture.r = r;
	texture.g = g;
	texture.b = b;
end

function SHTCancelColor(id, prev)
	local texture = getglobal("SHunterTimersOptionsBarsColor"..id.."Swatch");
	local r = prev.r;
	local g = prev.g;
	local b = prev.b;
	local a = prev.opacity;
	texture:SetVertexColor(r, g, b);
	texture:SetAlpha( a );
	texture.r = r;
	texture.g = g;
	texture.b = b;
	texture.a = a;
end

function SHTColor(r, g, b, a)
	if( not a ) then
		a = 1;
	end
	return string.format("|c%02x%02x%02x%02x", (a*255), (r*255), (g*255), (b*255));
end

function SHunterTimers_Tooltip(barframe)
	--DEFAULT_CHAT_FRAME:AddMessage(barframe:GetName());
	if( barframe.target ) then
		GameTooltip_SetDefaultAnchor(GameTooltip, barframe);
		GameTooltip:ClearLines();
		GameTooltip:AddLine( barframe.target );
		GameTooltip:Show();
	end
end

function SHT_sfind( s, pattern )
	for p in string.gfind( pattern, "([^|]+)" ) do
		if( string.find( s, p ) )then
			return string.find( s, p );
		end
	end
	return false;
end

function SHT_AddAutoShot()
	if( not SHTvars["skills"][SHT_AUTO_SHOT] ) then
		return;
	end
	shttimeleft = UnitRangedDamage("player");
	SHunterTimersFrame_add( shttimeleft*1000, SHT_AUTO_SHOT );
end
