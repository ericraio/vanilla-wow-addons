DYKey = nil;
local pre_UseAction;
DYVar = { init, attack, once, combat, hate, shot = true, crazy = true, cast = true, target, dead, friend, yellow, class, mount, buff, debuff, use = true, aiminit, dk = true, invul = true, panic, usetimer = 0; };
function DefendYourself_OnLoad()
	SlashCmdList["DEFENDSLASH"] = DefendYourself_Main_ChatCommandHandler;
	SLASH_DEFENDSLASH1 = "/defendyourself";
	SLASH_DEFENDSLASH2 = "/dy";
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTER_COMBAT");
	this:RegisterEvent("PLAYER_LEAVE_COMBAT");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("START_AUTOREPEAT_SPELL");
	this:RegisterEvent("STOP_AUTOREPEAT_SPELL");
	this:RegisterEvent("PLAYER_CONTROL_LOST");
	this:RegisterEvent("PLAYER_CONTROL_GAINED");
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("INSTANCE_BOOT_START");
	this:RegisterEvent("INSTANCE_BOOT_STOP");
	this:RegisterEvent("UI_ERROR_MESSAGE");
	this:RegisterEvent("CHAT_MSG_COMBAT_PARTY_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_PARTY_MISSES");
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
	
end

function UUIToggleDY()
	if( DYmenu:IsVisible() ) then
		DYmenu:Hide();
	else
		DYmenu:Show();
	end
end

function DY_RegisterUltimateUI()
	if(UltimateUI_RegisterButton) then
		UltimateUI_RegisterButton ( 
			"DefendYourself", 
			"Options", 
			"|cFF00CC00DefendYourself|r\nHelps with automated combat actions such as\nauto-attacking, ignoring enemies with debuffs like\nsheep, etc.", 
			"Interface\\Icons\\Ability_Defend", 
			UUIToggleDY
		);
	end
end

function DefendYourself_OnEvent(event, arg1, arg2, arg3)
	if (not DYVar.class and UnitClass("player")) then 
		local _, tempclassname = UnitClass("player");
		DYVar.class = strlower(tempclassname);
	end
	if event == "VARIABLES_LOADED" then
		DYVar.init = true;
		DefendYourself_UnitSave();
		DY_RegisterUltimateUI();
		if(myAddOnsList) then
			myAddOnsList.DefendYourself = {name = DEFEND_CONFIG_HEADER, description = DEFEND_CONFIG_HEADER_INFO, version = DEFEND_CONFIG_VERSION, category = MYADDONS_CATEGORY_COMBAT, frame = "DefendYourselfFrame", optionsframe = "DYmenu"};
		end
		if not DYKey.On and DYKey.ReOn then DYKey.On = true; DYKey.ReOn = nil; elseif DYKey.ReOn then DYKey.ReOn = nil; end
	elseif DYKey and DYKey.On then
		if DYturn_Event then DYturn_Event(event, arg1, arg2, arg3); end
		if event == "PLAYER_TARGET_CHANGED" then
			DYVar.once = true;
		elseif event == "PLAYER_ENTER_COMBAT" then
			DYVar.combat = true;
		elseif event == "PLAYER_LEAVE_COMBAT" then
			DYVar.combat = nil;
			if DYVar.attack then DYVar.once = true; end
		elseif event == "PLAYER_REGEN_ENABLED" or event == "INSTANCE_BOOT_START" or event == "INSTANCE_BOOT_STOP" then
			if not DYKey.Safe then DYVar.hate = nil; end
		elseif event == "PLAYER_REGEN_DISABLED" then
			DYVar.hate = true;
		elseif event == "START_AUTOREPEAT_SPELL" then
			DYVar.shot = nil;
		elseif event == "STOP_AUTOREPEAT_SPELL" then
			DYVar.shot = true;
		elseif event == "PLAYER_CONTROL_LOST" then
			DYVar.crazy = nil;
		elseif event == "PLAYER_CONTROL_GAINED" then
			if not DYVar.crazy then
				TargetLastEnemy();
			end
			DYVar.crazy = true;
		elseif event == "SPELLCAST_START" then
			DYVar.spell = nil;
		elseif event == "SPELLCAST_STOP" then
			DYVar.spell = true;
			if not DYVar.aiminit then
				if DYVar.class and strfind(DYVar.class, "hunter") or strfind(DYVar.class, "rogue") then
					pre_UseAction = UseAction;
					UseAction = DefendYourself_checkUse;
				end
				DYVar.aiminit = true;
			end
			if not DYVar.combat and not DYVar.once then DYVar.once = true; end
		elseif event == "UI_ERROR_MESSAGE" then
			if (arg1 == ERR_NO_ATTACK_TARGET or arg1 == ERR_INVALID_ATTACK_TARGET) then
				DYVar.target = nil;
				DYVar.once = nil;
			elseif (arg1 == ERR_WRONG_DIRECTION_FOR_ATTACK or arg1 == ERR_BADATTACKFACING) then
				DYVar.once = nil;
			elseif (arg1 == SPELL_FAILED_TOO_CLOSE) then
				DYVar.use = true;
				DYVar.shot = true;
			end
		elseif event == "CHAT_MSG_COMBAT_PARTY_HITS" or event == "CHAT_MSG_COMBAT_PARTY_MISSES" then
			if DefendYourself_Panic and DefendYourself_Panic(0) then return; end
			if DYKey.Assist then
				local pname;
				for i = 1, GetNumPartyMembers() do
					if (strfind(arg1, UnitName("party"..i))) then
						pname = i;
						break;
					end
				end
				if pname and not UnitExists("target") and DYVar.buff then
					TargetUnit("party"..pname.."target");
				end
			end
		elseif event == "CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS" or event == "CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES" then
			if DefendYourself_Panic and DefendYourself_Panic(0) then return; end
			if DYKey.Assist then
				local index = strfind(arg1, "hits");
				if index and not UnitExists("target") and DYVar.buff then
					local command = strsub(arg1, 1, index-2);
					TargetByName(command);
					if (UnitIsDead("target")) then
						TargetNearestEnemy();
					end
				end
			end
		elseif event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS" and arg1 == "You gain Self Invulnerability." then
			DYVar.invul = nil;
		elseif event == "CHAT_MSG_SPELL_AURA_GONE_SELF" and arg1 == "Self Invulnerability fades from you." then
			DYVar.invul = true;
		end
		DefendYourself_Check();
		DefendYourself_Trip();
	end
end

function DefendYourself_checkUse(arg1, arg2, arg3)
	if (GetActionText(arg1)) then
		local a, b, c = GetMacroInfo(GetMacroIndexByName(GetActionText(arg1)));
		if c and (strfind(strlower(c), "aimed shot")) then
			DYVar.use = nil;
		elseif c and ((strfind(strlower(c), strlower(DefendYourself_noattack[1])) or strfind(strlower(c), strlower(DefendYourself_noattack[2])) or strfind(strlower(c), strlower(DefendYourself_noattack[13])))) then
			DYVar.use = nil;
		end
	end
	local tex = GetActionTexture(arg1);
	if tex == "Interface\\Icons\\INV_Spear_07" or tex == "Interface\\Icons\\Ability_Gouge" or tex == "Interface\\Icons\\Ability_Sap" or tex == "Interface\\Icons\\Spell_Shadow_MindSteal" then
		DYVar.use = nil;
	end
	if not DYVar.use then
		DYVar.attack = nil;
		DYVar.once = nil;
		DYVar.usetimer = 3
	end
	pre_UseAction(arg1,arg2,arg3);
end

function DefendYourself_OnUpdate(elapsed)
	if not DYKey or not DYKey.On then DYStuff:Hide(); DefendYourselfFrame:EnableMouse(0); DefendYourselfFrame:SetBackdropColor(0,0,0,0); DefendYourselfFrame:SetBackdropBorderColor(0,0,0,0); return end
	if DYKey.On then
		if DYturn_Update then DYturn_Update(elapsed); end
		if DefendYourself_Panic and DefendYourself_Panic(elapsed) then return; end
		if DYVar.usetimer > 1 then DYVar.usetimer = DYVar.usetimer - elapsed; return; elseif DYVar.usetimer > 0 and not DYVar.use then DYVar.use = true; DYVar.usetimer = 0 return; end
		DY_MoneyToggle();
		DefendYourself_buff();
		if DYKey.Debuff then DefendYourself_debuff(); else DYVar.debuff = true; end
		DefendYourself_DK();
		DY_MoneyToggle();
		DefendYourself_Check();
		if DYKey.Safe then DefendYourself_GetBloody(); end
		DefendYourself_Trip();
		DefendYourself_Attack();
		DefendYourself_Stuff();
	end
end

function DefendYourself_Check()
	if UnitExists("target") then DYVar.target = true; else DYVar.target = nil; end
	if UnitIsDead("target") then DYVar.dead = nil; else DYVar.dead = true; end
	if UnitCanAttack("player", "target") then DYVar.friend = true; else DYVar.friend = nil; end
	if DYKey.Yellow then DefendYourself_Yellow(); else DYVar.yellow = true; end
	if DYKey.Faction then DefendYourself_Faction(); else DYVar.faction = true; end
end

function DefendYourself_Yellow()
	if UnitIsEnemy("target", "player") then 
		DYVar.yellow = true; 
	elseif not UnitIsFriend("target", "player") and UnitExists("target") then 
		DYVar.yellow = nil; 
	else 
		DYVar.yellow = true; 
	end
end

function DefendYourself_Stuff()
	if DYKey.Debug then 
		DYStuff:Show();
		DefendYourselfFrame:EnableMouse(1);
		DefendYourselfFrame:SetBackdropColor(0,0,0,0.5);
		DefendYourselfFrame:SetBackdropBorderColor(1,1,1,1);
		DYStuff:SetText("Attacking:"..dycol(DYVar.attack).."\nNeed to attack:"..dycol(DYVar.once).."\nIn Combat:"..dycol(DYVar.combat).."\nOn Hate List:"..dycol(DYVar.hate)
		.."\nNot Shooting:"..dycol(DYVar.shot).."\nNot Crazy:"..dycol(DYVar.crazy).."\nNot Casting:"..dycol(DYVar.cast).."\nHave a Target?:"..dycol(DYVar.target)
		.."\nIt's not Dead?:"..dycol(DYVar.dead).."\nNot a Friend?:"..dycol(DYVar.friend).."\nNot Unhostile/Yellow?:"..dycol(DYVar.yellow).."\nOn a Mount?:"..dycol(DYVar.mount)
		.."\nNo special Buffs?:"..dycol(DYVar.buff).."\nNo Debuffs on it?:"..dycol(DYVar.debuff).."\nNot using a certain skill?:"..dycol(DYVar.use));
	else
		DYStuff:Hide();
		DefendYourselfFrame:EnableMouse(0);
		DefendYourselfFrame:SetBackdropColor(0,0,0,0);
		DefendYourselfFrame:SetBackdropBorderColor(0,0,0,0);
	end
end

function DefendYourself_Faction()
	if UnitIsPlayer("target") and UnitFactionGroup("target") ~= UnitFactionGroup("player") then 
		if UnitIsPVP("player") and UnitIsPVP("target") then 
			DYVar.faction = true;
		else 
			DYVar.faction = nil; 
		end
	else 
		DYVar.faction = true; 
	end 
end

function DefendYourself_Trip()
	if DYVar.hate and DYVar.target then
		if DYVar.shot and DYVar.crazy and DYVar.dead and DYVar.friend and DYVar.yellow and DYVar.buff and DYVar.debuff and DYVar.dk and not DYVar.mount and DYVar.invul and DYVar.use then
			DYVar.attack = true;
		else
			DYVar.attack = nil;
		end
	else
		DYVar.attack = nil;
	end
end

--Handles all the lovely person-related saves. Yeah, saved by player name and server. T.T thx rowne!
function DefendYourself_UnitSave(x)
	if (DYVar.init) then
		local info = UnitName("player").." of "..GetCVar("realmName"); 
	--[[	if (x == 1) then 
			info = Fetch_PlayerInfo; 
		end]]
		local _, tempclassname = UnitClass("player");
		DYVar.class = strlower(tempclassname);
		if not DefendYourselfKey or not DefendYourselfKey.Version then
			DefendYourselfKey = {};
			DefendYourselfKey.Version = DEFEND_CONFIG_VERSION;
		elseif DefendYourselfKey.Version ~= DEFEND_CONFIG_VERSION then
			DefendYourselfKey.Version = DEFEND_CONFIG_VERSION;
		end
		if DefendYourselfKey.default then
			info = "Default Class";
		end
		if (not DefendYourselfKey[info]) then
			DefendYourselfKey[info] = {
			["On"] = true,
			["ReOn"] = nil,
			["Yellow"] = true,
			["Faction"] = true,
			["Debuff"] = true,
			["HP"] = nil,
			["Safe"] = nil,
			["Assist"] = true,
			["Civilian"] = true,
			["Debug"] = nil,
			["PanicTimer"] = 30,
			["PanicTime"] = 0,
			["Bar"] = 1,
			["blvl"] = 1
			};
		end
		DYKey = DefendYourselfKey[info];
		-- DefendYourself_Fetch_Frame:Hide();
		-- DefendYourself_Print("Defend Yourself! v."..DEFEND_CONFIG_VERSION.." is Loaded and "..dycol(DYKey.On));
	end
end

function DefendYourself_Print(msg,r,g,b,frame,id)
	if ( Print ) then
		Print(msg, r, g, b, frame, id);
		return;
	end
				
	if (not r) then r = 1.0; end
	if (not g) then g = 1.0; end
	if (not b) then b = 0.0; end
	if ( frame ) then 
		frame:AddMessage(msg,r,g,b,id);
	else
		if ( DEFAULT_CHAT_FRAME ) then 
			DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b,id);
		end
	end
end

function DefendYourself_Toggle(tog, str)
		if tog then
			DefendYourself_Print(str.." |CFFFF0000Off|r");
			return nil;
		else
			DefendYourself_Print(str.." |CFF00FF00On|r");
			return true;
		end
end

function DefendYourself_Main_ChatCommandHandler(msg)
	local msg = TextParse(msg);
	msg[1] = strlower(msg[1])
	if strfind(msg[1], "toggle") then
		DYKey.On = DefendYourself_Toggle(DYKey.On, "DefendYourself! is");
	elseif strfind(msg[1], "defaultprofile") then
		DefendYourselfKey.default = DefendYourself_Toggle(DefendYourselfKey.default, "Using an overall profile is");
	elseif strfind(msg[1], "yellow") then
		DYKey.Yellow = DefendYourself_Toggle(DYKey.Yellow, "Ignoring Yellow Creatures is");
	elseif strfind(msg[1], "faction") then
		DYKey.Faction = DefendYourself_Toggle(DYKey.Faction, "Ignoring Faction Members is");
	elseif strfind(msg[1], "debuff") then
		DYKey.Debuff = DefendYourself_Toggle(DYKey.Debuff, "Ignoring debuffed creatures is");
	elseif strfind(msg[1], "tlhp") then
		DefendYourself_tlhp();
		DefendYourself_Print("Aquiring target with lowest hp...",1,1,1);
	elseif strfind(msg[1], "blood") then
		DYKey.Safe = DefendYourself_Toggle(DYKey.Safe, "Bloodlust is");
		DYVar.hate = nil;
	elseif strfind(msg[1], "blvl") then
		local x = tonumber(msg[2])
		if x and x >= 0 and x <= 3 then DYKey.blvl = x; else DefendYourself_Print("What level is that?"); end
		if x == 0 then
			DefendYourself_Print("|CFFFFFFFFCurrent level is 0. As good as having the toggle off. Snore!|r");
		elseif x == 1 then
			DefendYourself_Print("|CFFFFFF00Current level is 1. Standard. You'll autoattack stuff you target, only if it meets the right criteria. Kinda bloody.|r");
		elseif x == 2 then
			DefendYourself_Print("|CFFFF8800Current level is 2. Yeep. You'll find and attack anything that comes across your path, but only if it meets your high standards. Only dining on virgin blood tonight, sir?|r");
		elseif x == 3 then
			DefendYourself_Print("|CFFFF0000OH CRAP CURRENT LEVEL IS 3!! RIP AND TEAR AND RIP AND TEAR YOUR GUTS! YOU ARE HUGE! THAT MEANS YOU HAVE HUGE GUTS! HERE IT COMES! BLOODY RAGE!!|r (Sanity: You'll target anything in your range if you have no target, and you'll beat on it indiscriminantly!! careful of faction and DK's!)",1,1,1);
		end
	elseif strfind(msg[1], "assist") then
		DYKey.Assist = DefendYourself_Toggle(DYKey.Assist, "Smart Assist is");
	elseif strfind(msg[1], "debug") then
		DYKey.Debug = DefendYourself_Toggle(DYKey.Debug, "Debug options are");
	elseif strfind(msg[1], "dk") then
		DYKey.Civilian = DefendYourself_Toggle(DYKey.Civilian, "Dishonorable Kill Prevention is");
	elseif strfind(msg[1], "help") then
		DefendYourself_Help();
	elseif strfind(msg[1], "menu") and DYmenu then
		DYmenu:Show();
	elseif strfind(msg[1], "button") then
		if DefendYourselfPanicButtonClick then 
			if msg[2] == "off" then DYKey.PanicState = 5 else DefendYourselfPanicButtonClick(); end
		end
	elseif strfind(msg[1], "bar") then
		if DefendYourselfBar then
			if msg[2] == "off" then DYKey.Bar = nil; elseif not DYKey.Bar then DYKey.Bar = 1; elseif DYKey.Bar == 1 then DYKey.Bar = 2; elseif DYKey.Bar == 2 then DYKey.Bar = nil; end
		end
	elseif strfind(msg[1], "defaultpanic") then
		DYKey.PanicTimer = tonumber(msg[2]);
	elseif strfind(msg[1], "panic") then
		if DefendYourself_StartPanic then DefendYourself_StartPanic(tonumber(msg[2])); end
	elseif strfind(msg[1], "turn") then
		if DefendYourself_Turn then DYKey.Turn = DefendYourself_Toggle(DYKey.Turn, "Turn functionability is"); end
	elseif strfind(msg[1], "on") then
		DefendYourself_Print("DefendYourself! is on"); DYKey.On = true; DYKey.ReOn = nil;
	elseif strfind(msg[1], "off") then
		local output = "DefendYourself! is off"
		if msg[2] and strfind(msg[2], "s") then
			output = output.." and will be restarted on your next reload";
			DYKey.ReOn = true;
		end
		DefendYourself_Print(output); 
		DYKey.On = nil;
	else
		if DYmenu then DYmenu:Show(); else
		DefendYourself_Print(DEFEND_CHAT_COMMAND_USAGE,1,1,0);
		DefendYourself_Help();
		end
	end
	msg = nil;
end

function DefendYourself_Help()
		DefendYourself_Print("Defend Yourself! v."..DEFEND_CONFIG_VERSION.." Parameters and their states");
		DefendYourself_Print("Toggle is:"..dycol(DYKey.On));
		DefendYourself_Print("Yellow is:"..dycol(DYKey.Yellow));
		DefendYourself_Print("Faction is:"..dycol(DYKey.Faction));
		DefendYourself_Print("Debuff is:"..dycol(DYKey.Debuff));
		DefendYourself_Print("Bloodlust is:"..dycol(DYKey.Safe));
		DefendYourself_Print("DK Prevention is:"..dycol(DYKey.Civilian));
		DefendYourself_Print("Assist is:"..dycol(DYKey.Assist));
		DefendYourself_Print("Using Default profiles is:"..dycol(DefendYourselfKey.default));
		DefendYourself_Print("Use /dy help to see this, /dy on turns it on, /dy off turns it off, and /dy toggle turns it between the two. /dy menu handles the menu! /dy defaultprofile toggles using an overall profile or a per-character-per-server profile.");
end

function dycol(tog)
	if tog then
		return "|CFF00FF00Yes|r";
	else
		return "|CFFFF0000No|r";
	end
end

function TextParse(InputString)
--[[ By FERNANDO!
	This function should take a string and return a table with each word from the string in
	each entry. IE, "Linoleum is teh awesome" returns {"Linoleum", "is", "teh", "awesome"}
	Some good should come of this, I've been avoiding writing a text parser for a while, and
	I need one I understand completely. ^_^

	If you want to gank this function and use it for whatever, feel free. Just give me props
	somewhere. This function, as far as I can tell, is fairly foolproof. It's hard to get it
	to screw up. It's also completely self-contained. Just cut and paste.]]
   local Text = InputString;
   local TextLength = 1;
   local OutputTable = {};
   local OTIndex = 1;
   local StartAt = 1;
   local StopAt = 1;
   local TextStart = 1;
   local TextStop = 1;
   local TextRemaining = 1;
   local NextSpace = 1;
   local Chunk = "";
   local Iterations = 1;
   local EarlyError = false;

   if ((Text ~= nil) and (Text ~= "")) then
   -- ... Yeah. I'm not even going to begin without checking to make sure Im not getting
   -- invalid data. The big ol crashes I got with my color functions taught me that. ^_^

      -- First, it's time to strip out any extra spaces, ie any more than ONE space at a time.
      while (string.find(Text, "  ") ~= nil) do
         Text = string.gsub(Text, "  ", " ");
      end

      -- Now, what if text consisted of only spaces, for some ungodly reason? Well...
      if (string.len(Text) <= 1) then
         EarlyError = true;
      end

      -- Now, if there is a leading or trailing space, we nix them.
      if EarlyError ~= true then
        TextStart = 1;
        TextStop = string.len(Text);

        if (string.sub(Text, TextStart, TextStart) == " ") then
           TextStart = TextStart+1;
        end

        if (string.sub(Text, TextStop, TextStop) == " ") then
           TextStop = TextStop-1;
        end

        Text = string.sub(Text, TextStart, TextStop);
      end

      -- Finally, on to breaking up the goddamn string.

      OTIndex = 1;
      TextRemaining = string.len(Text);

      while (StartAt <= TextRemaining) and (EarlyError ~= true) do

         -- NextSpace is the index of the next space in the string...
         NextSpace = string.find(Text, " ",StartAt);
         -- if there isn't another space, then StopAt is the length of the rest of the
         -- string, otherwise it's just before the next space...
         if (NextSpace ~= nil) then
            StopAt = (NextSpace - 1);
         else
            StopAt = string.len(Text);
            LetsEnd = true;
         end

         Chunk = string.sub(Text, StartAt, StopAt);
         OutputTable[OTIndex] = Chunk;
         OTIndex = OTIndex + 1;

         StartAt = StopAt + 2;

      end
   else
      OutputTable[1] = "Error: Bad value passed to TextParse!";
   end

   if (EarlyError ~= true) then
      return OutputTable;
   else
      return {"Error: Bad value passed to TextParse!"};
   end
end


local lOriginal_GameTooltip_ClearMoney;
function DY_MoneyToggle()
	if( lOriginal_GameTooltip_ClearMoney ) then
		GameTooltip_ClearMoney = lOriginal_GameTooltip_ClearMoney;
		lOriginal_GameTooltip_ClearMoney = nil;
	else
		lOriginal_GameTooltip_ClearMoney = GameTooltip_ClearMoney;
		GameTooltip_ClearMoney = DY_GameTooltip_ClearMoney;
	end
end

function DY_GameTooltip_ClearMoney() 
end

--[[This is similar to the above, but it checks your current buffs.
(List:DefendYourself_selfbuff)
returns true if it finds a buff that will get removed if you attack something(like stealth)
For reference, this one is run all the time, the previous one only runs if you have
debuff support toggled on.]]
function DefendYourself_buff()
	local pow = 0;
	DYVar.mount = nil;
	DefendYourselfTip:ClearLines();
	for i = 1, getn(DefendYourself_selfbuff), 1 do
		if pow == 1 then break; end
		local j = 1;
		while UnitBuff("player", j) do
			DefendYourselfTip:SetUnitBuff("player", j);
			local msg = DefendYourselfTipTextLeft1:GetText();
			local texture = UnitBuff("player", j);
			if (string.find(texture,"Spell_Nature_Swiftness") or -- Summon Felsteed, Summon Warhorse
				string.find(texture,"Ability_Mount") or string.find(texture,"INV_Misc_Foot_Kodo")) then
					DYVar.mount = true;
			end
			if (msg == DefendYourself_selfbuff[i]) then
				pow = 1;
				break;
			end
			j = j + 1;
		end
	end
	if pow == 0 then
		if (not DYVar.buff) then
			DYVar.buff = true;
			DYVar.once = true;
		end
	elseif pow == 1 then
		if DYVar.buff then
			DYVar.buff = nil;
			DYVar.once = nil;
		end
	end
end

function DefendYourself_debuff()
	local pow = 0;
	DefendYourselfTip:ClearLines();
	for i = 1, getn(DefendYourself_noattack), 1 do
		if pow == 1 then break; end
		local j = 1;
		while UnitDebuff("target", j) do
			DefendYourselfTip:SetUnitDebuff("target", j);
			local msg = DefendYourselfTipTextLeft1:GetText();
			if (msg == DefendYourself_noattack[i]) then
				pow = 1;
				break;
			end
			j = j + 1;
		end
	end
	if pow == 0 then
		if (not DYVar.debuff) then
			DYVar.debuff = true;
			DYVar.once = true;
			DYVar.use = true;
		end
	elseif pow == 1 then
		if DYVar.debuff then
			DYVar.debuff = nil;
			DYVar.once = nil;
		end
	end
end

function DefendYourself_DK()
	DefendYourselfTip:ClearLines();
	DefendYourselfTip:SetUnit("target");
	DYVar.dk = true;
	for i = 1, 6 do
		local msg = tostring(getglobal("DefendYourselfTipTextLeft"..i):GetText());
		if strfind(msg, "Civilian") then
			DYVar.dk = nil;
			break;
		end
	end
end

local escapetlhp = nil;
function DefendYourself_tlhp()
	if escapetlhp and escapetlhp > GetTime() then return; end
	escapetlhp = GetTime()+5;
	local maxHP, curHP, retry;
	maxHP = 101;
	retry = 0;
	if UnitExists("target") then maxHP = UnitHealth("target"); end
	TargetNearestEnemy();
	curHP = UnitHealth("target");
	while (curHP ~= maxHP and UnitExists("target") and retry <= 10) do
		if (curHP < maxHP) then
				maxHP = curHP;
				retry = 0;
		else
			retry = retry + 1;
		end
		TargetNearestEnemy();
		if UnitExists("target") then curHP = UnitHealth("target"); end
	end
	DY_MoneyToggle();
	DefendYourself_debuff();
	DY_MoneyToggle();
	DefendYourself_Check();
	DefendYourself_Trip();
	if not DYVar.attack or (UnitIsTapped("target") and not UnitIsTappedByPlayer("target")) then ClearTarget(); end
	escapetlhp = nil;
end

function DefendYourself_Attack()
	if DYKey.On then
		if DYVar.attack then 
			DYBattle();
		else
			DYEscape();
		end
	end
end

function DYBattle()
	if DYVar.once then
		if DYVar.combat then
			DYVar.once = nil;
		else
			AttackTarget();
			DYVar.once = nil;
		end
	end
end

function DYEscape()
	if not DYVar.crazy and not UnitOnTaxi("player") then return; end
	if DYVar.combat and (not DYVar.buff or not DYVar.debuff) then AttackTarget(); DYVar.once = nil; return; end
end

function DefendYourself_GetBloody()
	--I apologize in advance. I couldn't help myself. lol!
	--(rage3 level indicator stolen from the doom comic. HERE COMES THE NIGHT TRAIN!)
	if not DYKey.blvl then DYKey.blvl = 1; end
	if DYKey.blvl == 0 then
		return;
	elseif DYKey.blvl == 1 then
		DYVar.hate = true;
	elseif DYKey.blvl == 2 then
		DYVar.hate = true;
		if not UnitExists("target") then TargetNearestEnemy(); end
	elseif DYKey.blvl == 3 then
		DYVar.hate = true;
		DYVar.yellow = true;
		DYVar.debuff = true;
		DYVar.faction = true;
		if not UnitExists("target") then TargetNearestEnemy(); end
	end
end