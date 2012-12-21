--[[
  ****************************************************************
	Scrolling Combat Text 5.0

	Author: Grayhoof
	****************************************************************
	
	Official Site:
		http://grayhoof.wowinterface.com 
	
	****************************************************************]]
SCT = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0", "AceHook-2.0");
	
--embedded libs
local parser = ParserLib:GetInstance("1.1")
	
--Table Constants
SCT.COLORS_TABLE = "COLORS";
SCT.CRITS_TABLE = "CRITS";
SCT.FRAMES_TABLE = "FRAMES";
SCT.FRAMES_DATA_TABLE = "FRAMESDATA";
SCT.FRAME1 = 1;
SCT.FRAME2 = 2;
SCT.MSG = 10;

-- local constants, use lowercase sct
local sct_LastHPPercent = 0;
local sct_LastTargetHPPercent = 0;
local sct_LastManaPercent = 0;
local sct_LastManaFull = 99999;

local arrPowerStrings = {
		[0] = MANA,
		[1] = RAGE,
		[3] = ENERGY
}

local arrShadowOutline = {
	[1] = "",
	[2] = "OUTLINE",
	[3] = "THICKOUTLINE"
}

local arrSpellColors = {
	[SPELL_SCHOOL0_CAP] = {r=1,g=0,b=0},
	[SPELL_SCHOOL1_CAP] = {r=1,g=1,b=0},
	[SPELL_SCHOOL2_CAP] = {r=1,g=.3,b=0},
	[SPELL_SCHOOL3_CAP] = {r=.5,g=1,b=.2},
	[SPELL_SCHOOL4_CAP] = {r=.4,g=.6,b=.9},
	[SPELL_SCHOOL5_CAP] = {r=.4,g=.4,b=.5},
	[SPELL_SCHOOL6_CAP] = {r=.8,g=.8,b=1},
}

SCT.SpellColors = arrSpellColors;

----------------------
--Called on login
function SCT:OnEnable()
	self:RegisterSelfEvents();
end

----------------------
-- called on standby
function SCT:OnDisable()
	self:DisableAll()
end

----------------------
-- Disable all events
function SCT:DisableAll()
	-- no more events to handle
	parser:UnregisterAllEvents("sct")
	self:UnregisterAllEvents()
end

----------------------
-- Show the Option Menu
function SCT:ShowMenu()
	local loaded, message = LoadAddOn("sct_options");
	if (loaded) then
		PlaySound("igMainMenuOpen");
		ShowUIPanel(SCTOptions);
	else
		PlaySound("TellMessage");
		SCT:Print(SCT.LOCALS.Load_Error.." "..message);
	end
end

----------------------
--Hide the Option Menu
function SCT:HideMenu()
	PlaySound("igMainMenuClose");
	HideUIPanel(SCTOptions);
end

----------------------
--Called when Addon loaded
function SCT:OnInitialize()
	
	--default settings
	local default_config = self:GetDefaultConfig();
		
	--slash command setup
	local main = {
		type="group",
		args = {
			menu = {
				name = "Menu", type = 'execute',
		    desc = "Display SCT Option Menu",
		    func = function()
		        self:ShowMenu();
    		end
			},
			reset = {
				name = "Reset", type = 'execute',
		    desc = "Reset SCT Options to default",
		    func = function()
		        self:Reset();
    		end
			}
		}
	}
	local menu = {
		type = 'execute',
    desc = "Display SCT Option Menu",
    func = function()
        self:ShowMenu();
    end
	}
	local reset = {
		type = 'execute',
    desc = "Reset SCT Options to default",
    func = function()
        self:Reset();
    end
	}
	local cmd = {
		type = 'text',
		name = "Display",
		usage = SCT.LOCALS.DISPLAY_USEAGE,
    desc = "Display a message using SCT",
    get = false,
    set = function(x)
        self:CmdDisplay(x);
    end
	}
	
	--hook chat frame if using event debug
	if SCT.EventDebug then
		for i = 1, 7, 1 do
			self:Hook(getglobal("ChatFrame" .. i), "AddMessage")
		end
	end
	
	self:RegisterDB("SCT_CONFIG")
	self:RegisterDefaults('profile', default_config )
	
	self:RegisterChatCommand({"/sct"}, main) 
	self:RegisterChatCommand({"/sctmenu"}, menu)
	self:RegisterChatCommand({"/sctreset"}, reset) 
	self:RegisterChatCommand({"/sctdisplay"}, cmd) 
	
	--set to profile by char by default
	if not self.db.char.notFirstTime then 
		self.db.char.notFirstTime = true;
		self:SetProfile("char");
	end
	
	--register with other mods
	self:RegisterOtherMods()
	
	-- Add my options frame to the global UI panel list
	UIPanelWindows["SCTOptions"] = {area = "center", pushable = 0};
	
	--setup animations
	self:AniInit();
	
	--Set Enabled State
	if (self.db.profile["ENABLED"]) then
		self:ToggleActive(true);
		self:Print(SCT.LOCALS.STARTUP);
	else
		self:ToggleActive(false);
	end

end

----------------------
--Hook Function to show event
function SCT:AddMessage(frame, text, r, g, b, id)
    self.hooks[frame].AddMessage.orig(frame, text.." |cff00ff00["..tostring(event).."]|r", r, g, b, id)
end

----------------------
--Reset everything to default
function SCT:Reset()
	self:ResetDB("profile")
	self:HideMenu();
	self:ShowMenu();
	self:ShowExample();
	self:Print(SCT.LOCALS.PROFILE_NEW..AceLibrary("AceDB-2.0").CHAR_ID);
end

----------------------
--Get a value from player config
function SCT:Get(option, table)
	if (table) then
		return self.db.profile[table][option];
	else
		return self.db.profile[option];
	end
end

----------------------
--Set a value in player config
function SCT:Set(option, value, table)
	if (table) then
		self.db.profile[table][option] = value;
	else
		self.db.profile[option] = value;
	end
end

----------------------
--Display for any partial blocks
function SCT:DisplayBlock(blocked)
	SCT:Display_Event("SHOWBLOCK", BLOCK.." ("..blocked..")");
end

----------------------
--Display for any partial absorbs
function SCT:DisplayAbsorb(absorbed)
	SCT:Display_Event("SHOWABSORB", ABSORB.." ("..absorbed..")");
end	

----------------------
-- Event Handler
-- this function parses events that are printed in the combat
-- chat window then displays the health changes
function SCT:OnEvent()				
	--Player Health
	if (event == "UNIT_HEALTH") then
		if (arg1 == "player") then
			local warnlevel = self.db.profile["LOWHP"] / 100;
			local HPPercent = UnitHealth("player") / UnitHealthMax("player");
      if (HPPercent < warnlevel) and (sct_LastHPPercent >= warnlevel) and (not SCT:CheckFD("player")) then
      	if (self.db.profile["PLAYSOUND"] and self.db.profile["SHOWLOWHP"]) then
      		PlaySoundFile("Sound\\Spells\\bind2_Impact_Base.wav")
      	end
      	self:Display_Event("SHOWLOWHP", SCT.LOCALS.LowHP.." ("..UnitHealth("player")..")");
      end
      sct_LastHPPercent = HPPercent;
      return;
		end
		return;
		
	--Player Mana
	elseif (event == "UNIT_MANA") or (event == "UNIT_RAGE") or (event == "UNIT_ENERGY")then
		if (arg1 == "player") and (UnitPowerType("player") == 0)then
			local warnlevel = self.db.profile["LOWMANA"] / 100;
			local ManaPercent = UnitMana("player") / UnitManaMax("player");
      if (ManaPercent < warnlevel) and (sct_LastManaPercent >= warnlevel) and (not SCT:CheckFD("player")) then
      	if (self.db.profile["PLAYSOUND"] and self.db.profile["SHOWLOWMANA"]) then
      		PlaySoundFile("Sound\\Spells\\ShaysBell.wav");
      	end
      	SCT:Display_Event("SHOWLOWMANA", SCT.LOCALS.LowMana.." ("..UnitMana("player")..")");
      end
      sct_LastManaPercent = ManaPercent;
		end
		if (arg1 == "player") and (self.db.profile["SHOWALLPOWER"]) then
			local ManaFull = UnitMana("player");
			if (ManaFull > sct_LastManaFull) then
				self:Display_Event("SHOWPOWER", "+"..ManaFull-sct_LastManaFull.." "..arrPowerStrings[UnitPowerType("player")]);
			end
			sct_LastManaFull = ManaFull;
		end
		return;
		
	--Power Change
	elseif (event == "UNIT_DISPLAYPOWER") then
		sct_LastManaFull = UnitMana("player");
		return;
		
	--Player Combat
	elseif (event =="PLAYER_REGEN_DISABLED") then
		self:Display_Event("SHOWCOMBAT", SCT.LOCALS.Combat);
		return;
		
	--Player NoCombat
	elseif (event =="PLAYER_REGEN_ENABLED") then
		self:Display_Event("SHOWCOMBAT", SCT.LOCALS.NoCombat);
		return;
		
	--Player Combo Points
	elseif (event == "PLAYER_COMBO_POINTS") then
		local sct_CP = GetComboPoints();
		if (sct_CP ~= 0) then
			local sct_CP_Message = sct_CP.." "..SCT.LOCALS.ComboPoint;
			if (sct_CP == 5) then
				sct_CP_Message = sct_CP_Message.." "..SCT.LOCALS.FiveCPMessage;
			end;
			self:Display_Event("SHOWCOMBOPOINTS", sct_CP_Message);
		end
		return;
	
	--All other combat events	
	elseif (arg1) then
		self:ParseCombat(arg1);	
	end
end

----------------------
-- Displays Parsed info based on type
function SCT:ParseCombat(info)
	--self doesn't work here because of the call from ParserLib
	local self = SCT;
	
	--custom search first
	if (self.db.profile["CUSTOMEVENTS"]) and (not SCT.db.profile["LIGHTMODE"]) and (self:CustomEventSearch(arg1) == true) then
		return;
	end
	
	--Player Skill Gains Here, since its unsupported
	if (event == "CHAT_MSG_SKILL") then
		local target, rank = parser:Deformat(arg1, SKILL_RANK_UP);
		if target then
			self:Display_Event("SHOWSKILL", target..": "..rank);
			return;
		end
		return;
	end
	
	--if its not a ParserLib Event, then end
	if (type(info) ~= "table") then
		return;
	end
	
	--outgoing heals, done first since its only thing blizzard events don't do
	if (info.type == "heal" and info.victim ~= ParserLib_SELF) then
		--heal filter
		if (info.amount < self.db.profile["HEALFILTER"]) then return end;
		--outgoing heals, ignore dots
		if (info.source == ParserLib_SELF and not info.isDOT) then
			if (self.db.profile["SHOWOVERHEAL"]) then
				info.amount = self:GetOverheal(info.victim, info.amount);
			end
			self:Display_Event("SHOWSELFHEAL", info.victim..": +"..info.amount, info.isCrit);
		end
		return;
	end
	
	--if in light mode, end here
	if (self.db.profile["LIGHTMODE"]) then
		return;
	end
	
	-- Environmental
	if (info.type == "environment") then
		if (info.victim == ParserLib_SELF) then
			if( info.damageType == "fire" or info.damageType == "lava" or info.damageType == "slime") then
				self:Display_Event("SHOWSPELL", "-"..info.amount, nil, nil, info.amountResist	);
			else
				self:Display_Event("SHOWHIT", "-"..info.amount);
			end
			if(info.amountAbsorb) then
				self:DisplayAbsorb(info.amountAbsorb);
			end
		end

	--Hits (melee, spell, etc..)
	elseif (info.type == "hit") then
		if (info.victim == ParserLib_SELF) then
			if (info.skill == ParserLib_MELEE) then
				self:Display_Event("SHOWHIT", "-"..info.amount, info.isCrit);
			else
				self:Display_Event("SHOWSPELL", "-"..info.amount, info.isCrit, info.element, info.amountResist);
			end
			if( info.amountAbsorb) then
				self:DisplayAbsorb(info.amountAbsorb);
			end
			if( info.amountBlock) then
				self:DisplayBlock(info.amountBlock);
			end
		end		
	
	--Miss Events
	elseif (info.type == "miss") then
		if (info.victim == ParserLib_SELF) then
			if (info.missType == "miss") then
				self:Display_Event("SHOWMISS", MISS, nil, nil, nil, nil, SCT.LOCALS.TARGET.." "..MISS);
			elseif (info.missType == "dodge") then
				self:Display_Event("SHOWDODGE", DODGE, nil, nil, nil, nil, YOU.." "..DODGE);
			elseif (info.missType == "block") then
				self:Display_Event("SHOWBLOCK", BLOCK, nil, nil, nil, nil, YOU.." "..BLOCK);
			elseif (info.missType == "deflect") then
				self:Display_Event("SHOWABSORB", DEFLECT, nil, nil, nil, nil, YOU.." "..DEFLECT);
			elseif (info.missType == "immune") then
				self:Display_Event("SHOWABSORB", IMMUNE, nil, nil, nil, nil, YOU.." "..IMMUNE);
			elseif (info.missType == "evade") then
				self:Display_Event("SHOWABSORB", EVADAE, nil, nil, nil, nil, YOU.." "..EVADE);
			elseif (info.missType == "parry") then
				self:Display_Event("SHOWPARRY", PARRY, nil, nil, nil, nil, YOU.." "..PARRY);
			elseif (info.missType == "resist") then
				self:Display_Event("SHOWRESIST", RESIST, nil, nil, nil, nil, YOU.." "..RESIST);
			elseif (info.missType == "reflect") then
				self:Display_Event("SHOWABSORB", REFLECT, nil, nil, nil, nil, YOU.." "..REFLECT);
			elseif (info.missType == "absorb") then
				self:Display_Event("SHOWABSORB", ABSORB, nil, nil, nil, nil, YOU.." "..ABSORB);
			end
		end
	
	--Gains
	elseif (info.type == "gain") then
		if (info.victim == ParserLib_SELF) and (not self.db.profile["SHOWALLPOWER"]) then
			self:Display_Event("SHOWPOWER", "+"..info.amount.." "..info.attribute);
		end
			
	--Leech
	elseif (info.type == "leech") and (not self.db.profile["SHOWALLPOWER"]) then
		if (info.sourceGained == ParserLib_SELF) then
			self:Display_Event("SHOWPOWER", "+"..info.amountGained.." "..info.attributeGained);
		end
	
	--buff
	elseif (info.type == "buff") then
		if (info.victim == ParserLib_SELF) then
			self:Display_Event("SHOWBUFF", "["..info.skill.."]", nil, nil, nil, nil, arg1);
		end	
	
	--debuff
	elseif (info.type == "debuff") then
		if (info.victim == ParserLib_SELF) then
			if (info.amountRank) then
				self:Display_Event("SHOWDEBUFF", "("..info.skill.." "..info.amountRank..")", nil, nil, nil, nil, arg1);
			else
				self:Display_Event("SHOWDEBUFF", "("..info.skill..")", nil, nil, nil, nil, arg1);
			end
		end
			
	--healing in/out
	elseif (info.type == "heal") then
		--heal filter
		if (info.amount < self.db.profile["HEALFILTER"]) then return end;
		--self heals
		if (info.victim == ParserLib_SELF and info.source == ParserLib_SELF) then
			if (self.db.profile["SHOWOVERHEAL"]) then
				info.amount = self:GetOverheal("player", info.amount);
			end
			self:Display_Event("SHOWHEAL", "+"..info.amount, info.isCrit, nil, nil, info.skill);
		--incoming heals
		elseif (info.victim == ParserLib_SELF) then
			self:Display_Event("SHOWHEAL", "+"..info.amount, info.isCrit, nil, nil, info.source);
		end
	end
end

----------------------
--Handle Blizzard events
function SCT:BlizzardCombatTextEvent()
	--Normal Events
	if (arg1=="SPELL_ACTIVE") then
		self:Display_Event("SHOWEXECUTE", arg2.."!");
	elseif (arg1=="FACTION") then
		if ( tonumber(arg3) < 0 ) then
			self:Display_Event("SHOWREP", "-"..arg3.." "..REPUTATION.." ("..arg2..")");
		else
			self:Display_Event("SHOWREP", "+"..arg3.." "..REPUTATION.." ("..arg2..")");
		end
	elseif (arg1=="HONOR_GAINED") then
		self:Display_Event("SHOWHONOR", "+"..arg2.." "..HONOR);
	elseif (arg1=="AURA_END") then
		self:Display_Event("SHOWFADE", "-["..arg2.."]",nil,nil,nil,nil,format(AURAREMOVEDSELF, arg2));
	elseif (arg1=="AURA_END_HARMFUL") then
		if (self.db.profile["SHOWFADE"]) then
			self:Display_Event("SHOWDEBUFF", "-("..arg2..")",nil,nil,nil,nil,format(AURAREMOVEDSELF, arg2));
		end
	elseif (arg1=="EXTRA_ATTACKS") then
		if ( tonumber(arg2) > 1 ) then
			self:Display_Event("SHOWEXECUTE", self.LOCALS.ExtraAttack.."("..arg2..")");
		else
			self:Display_Event("SHOWEXECUTE", self.LOCALS.ExtraAttack);
		end
	end
	
	--if not in light mode, end here
	if (not self.db.profile["LIGHTMODE"]) then
		return;
	end
	
	--Light Mode Event
	if ( arg1 == "DAMAGE_CRIT" ) then
		self:Display_Event("SHOWHIT", "-"..arg2, 1);
	elseif ( arg1 == "DAMAGE" ) then
		self:Display_Event("SHOWHIT", "-"..arg2);
	elseif ( arg1 == "SPELL_DAMAGE" ) then
		self:Display_Event("SHOWSPELL", "-"..arg2);
	elseif ( arg1 == "AURA_START" ) then
		self:Display_Event("SHOWBUFF", "["..arg2.."]");
	elseif ( arg1 == "AURA_START_HARMFUL" ) then
		self:Display_Event("SHOWDEBUFF", "("..arg2..")");
	elseif ( arg1 == "HEAL" or arg1 == "PERIODIC_HEAL") then
		--heal filter
		if (tonumber(arg3) < tonumber(self.db.profile["HEALFILTER"])) then return end;
		if ( UnitName("player") ~= arg2 ) then
			self:Display_Event("SHOWHEAL", "+"..arg3, nil, nil, nil, arg2);
		else
			self:Display_Event("SHOWHEAL", "+"..arg3);
		end
	elseif ( arg1 == "HEAL_CRIT" ) then
		--heal filter
		if (tonumber(arg3) < tonumber(self.db.profile["HEALFILTER"])) then return end;
		if ( UnitName("player") ~= arg2 ) then
			self:Display_Event("SHOWHEAL", "+"..arg3, 1, nil, nil, arg2);
		else
			self:Display_Event("SHOWHEAL", "+"..arg3, 1);
		end
	elseif ( arg1 == "MANA" or arg1 == "RAGE" or arg1 == "ENERGY") then
		if (not self.db.profile["SHOWALLPOWER"]) then
			self:Display_Event("SHOWPOWER", "+"..arg2.." "..getglobal(arg1));
		end
	elseif ( arg1 == "MISS" or arg1 == "SPELL_MISSED") then
		self:Display_Event("SHOWMISS", MISS, nil, nil, nil, nil, SCT.LOCALS.TARGET.." "..MISS);
	elseif ( arg1 == "EVADE" or arg1 == "SPELL_EVADED") then
		self:Display_Event("SHOWABSORB", EVADAE, nil, nil, nil, nil, YOU.." "..EVADE);
	elseif ( arg1 == "DODGE" or arg1 == "SPELL_DODGED" ) then
		self:Display_Event("SHOWDODGE", DODGE, nil, nil, nil, nil, YOU.." "..DODGE);
	elseif ( arg1 == "PARRY" or arg1 == "SPELL_PARRIED") then
		self:Display_Event("SHOWPARRY", PARRY, nil, nil, nil, nil, YOU.." "..PARRY);
	elseif ( arg1 == "IMMUNE" or arg1 == "SPELL_IMMUNE") then
		self:Display_Event("SHOWABSORB", IMMUNE, nil, nil, nil, nil, YOU.." "..IMMUNE);
	elseif ( arg1 == "DEFLECT" or arg1 == "SPELL_DEFLECTED") then
		self:Display_Event("SHOWABSORB", DEFLECT, nil, nil, nil, nil, YOU.." "..DEFLECT);
	elseif ( arg1 == "SPELL_REFLECTED") then
		self:Display_Event("SHOWABSORB", REFLECT, nil, nil, nil, nil, YOU.." "..REFLECT);
	elseif ( arg1 == "BLOCK" or arg1 == "SPELL_BLOCKED") then
		if ( arg3 ) then
			if (arg1 == "SPELL_BLOCKED") then
				self:Display_Event("SHOWSPELL", "-"..arg2);
			else
				self:Display_Event("SHOWHIT", "-"..arg2);
			end
			self:DisplayBlock(arg3)
		else
			self:Display_Event("SHOWBLOCK", BLOCK, nil, nil, nil, nil, YOU.." "..BLOCK);
		end
	elseif ( arg1 == "ABSORB" or arg1 == "SPELL_ABSORBED" ) then
		if ( arg3 ) then
			if (arg1 == "SPELL_ABSORBED") then
				self:Display_Event("SHOWSPELL", "-"..arg2);
			else
				self:Display_Event("SHOWHIT", "-"..arg2);
			end
			self:DisplayAbsorb(arg3)
		else
			self:Display_Event("SHOWABSORB", ABSORB, nil, nil, nil, nil, YOU.." "..ABSORB);
		end
	elseif ( arg1 == "RESIST" or arg1 == "SPELL_RESISTED" ) then
		if ( arg3 ) then
			if (arg1 == "SPELL_RESISTED") then
				self:Display_Event("SHOWSPELL", "-"..arg2, nil, nil, arg3);
			else
				self:Display_Event("SHOWHIT", "-"..arg2, nil, nil, arg3);
			end
		else
			self:Display_Event("SHOWRESIST", RESIST, nil, nil, nil, nil, YOU.." "..RESIST);
		end
	end
end

----------------------
--Find a custom capture event message
function SCT:CustomEventSearch(arg1)
	local strTempMessage, currentcolor, table, classfound, key, key2, class, value, i;
	local carg1, carg2, carg3, carg4, carg5;
	--cache it index order
	if (SCT.CustomEvents == nil) then
		SCT.CustomEvents = {};
		for key, value in self:PairsByKeys(SCT.EventConfig) do
			tinsert(SCT.CustomEvents, value);
		end
	end
	for key, value in SCT.CustomEvents do
		--default class found to true
		classfound = true;
		--check if they want to see it for this class
		if (value.class) then
			--if want to filter by class, default to false
			classfound = false;
			for key2, class in value.class do
				if (strlower(UnitClass("player")) == strlower(class)) then
					classfound = true;
					break;
				end
			end
		end
		--if ok
		if (classfound) then
			for carg1, carg2, carg3, carg4, carg5 in string.gfind(arg1, value.search) do
				strTempMessage = value.name;
				--if there are capture args
				if ((value.argcount) and (value.argcount > 0) and (value.argcount < 6)) then
					table = {carg1, carg2, carg3, carg4, carg5}
					--loop though each capture arg. if it exists replace the display position with it
					for i = 1, value.argcount do
						if (table[i]) then
							strTempMessage, _ = string.gsub(strTempMessage, "*"..i, table[i]);
						end
					end
				end
				--get color
				currentcolor = {r = 1.0, g = 1.0, b = 1.0};
				if (value.r and value.g and value.b) then
					currentcolor.r,currentcolor.g,currentcolor.b = value.r,value.g,value.b;
				end
				--set msg
				if (value.ismsg) then value.ismsg = SCT.MSG end;
				--play sound
				if (value.sound) then PlaySound(value.sound) end;
				--play soundwave
				if (value.soundwave) then PlaySoundFile(value.soundwave) end;
				--display
				self:DisplayCustomEvent(strTempMessage, currentcolor, value.iscrit, value.ismsg, value.anitype);
				return true;				
			end
		end
	end
	return false;
end

----------------------
--Display for mainly combat events
--Mainly used for short messages
function SCT:Display_Event(option, msg1, crit, damagetype, resisted, target, msg2)
	local rbgcolor, showcrit, showmsg, event;
	--if option is on
	if (self.db.profile[option]) then
		--get options
		rbgcolor = self.db.profile[self.COLORS_TABLE][option];
		showcrit = self.db.profile[self.CRITS_TABLE][option];
		showmsg = self.db.profile[self.FRAMES_TABLE][option] or 1;
		--if damage type
		if ((damagetype) and (self.db.profile["SPELLTYPE"])) then
			msg1 = msg1.." ("..damagetype..")";
		end
		--if spell color
		if ((damagetype) and (self.db.profile["SPELLCOLOR"])) then
			rbgcolor = self.SpellColors[damagetype] or rbgcolor;
		end
		--if resisted
		if ((resisted) and (self.db.profile["SHOWRESIST"])) then
			msg1 = msg1.." ("..resisted.." "..ERR_FEIGN_DEATH_RESISTED..")";
		end
		--if target label
		if ((target) and (self.db.profile["SHOWTARGETS"])) then
			msg1 = msg1.." ("..target..")";
		end
		--if messages
		if (showmsg == SCT.MSG) then
			--if 2nd msg
			if (msg2) then msg1 = msg2 end;
			--display message
			self:DisplayMessage( msg1, rbgcolor );
		else
			event = "event";
			--set event type
			if (option == "SHOWHIT" or option == "SHOWSPELL" or option == "SHOWHEAL" or option == "SHOWSELFHEAL") then
				event = "damage";
			end
			--see if crit override
			if (showcrit) then crit = 1 end;
			--display
			self:DisplayText(msg1, rbgcolor, crit, event, showmsg);
		end
	end
end

----------------------
--Display the Text based on message flag for custom events
function SCT:DisplayCustomEvent(msg1, color, iscrit, ismsg, anitype)
	if (ismsg) then
		self:DisplayMessage( msg1, color );
	else
		self:DisplayText(msg1 , color, iscrit, "event", 1, anitype);
	end	
end

----------------------
--Displays a message at the top of the screen
function SCT:DisplayMessage(msg, color)
		SCT_MSG_FRAME:AddMessage(msg, color.r, color.g, color.b, 1);
end

----------------------
--Display text from a command line
function SCT:CmdDisplay(msg)	
	local message = nil;
	local colors = nil;
	--If there are not parameters, display useage
	if string.len(msg) == 0 then
		self:DisplayUseage();
	--Get message anf colors if quotes used
	elseif string.sub(msg,1,1) == "'" then
		local location = string.find(string.sub(msg,2),"'")
		if location and (location>1) then
			message = string.sub(msg,2,location)
			colors = string.sub(msg,location+1);
		end
	--Get message anf colors if single word used
	else
		local idx = string.find(msg," ");
		if (idx) then
			message = string.sub(msg,1,idx-1);
			colors = string.sub(msg,idx+1);
		else
			message = msg;
		end
	end
	--if they sent colors, grab them
	local firsti, lasti, red, green, blue = nil;
	if (colors ~= nil) then
		firsti, lasti, red, green, blue = string.find (colors, "(%w+) (%w+) (%w+)");
	end
  local color = {r = 1.0, g = 1.0, b = 1.0};
	--if they sent 3 colors use them, else use default white
  if (red) and (green) and (blue) then	 
  	color.r,color.g,color.b = (tonumber(red)/10),(tonumber(green)/10),(tonumber(blue)/10);
  end
  self:DisplayText(message, color, nil, "event", 1);
end

-------------------------
--Set the font of an object using msg vars
function SCT:SetMsgFont(object)
	--set font
	object:SetFont(SCT.LOCALS.FONTS[self.db.profile[self.FRAMES_DATA_TABLE][SCT.MSG]["MSGFONT"]].path,
								 self.db.profile[self.FRAMES_DATA_TABLE][SCT.MSG]["MSGSIZE"], 
								 arrShadowOutline[self.db.profile[self.FRAMES_DATA_TABLE][SCT.MSG]["MSGFONTSHADOW"]]);
	--reset size of allow 3 messages
	object:SetHeight(self.db.profile[self.FRAMES_DATA_TABLE][SCT.MSG]["MSGSIZE"] * 4) 
	--Set Fade Duration
	if (object.SetFadeDuration) then
		object:SetFadeDuration(1);
	end
end

-------------------------
--Set the font of the built in damage font
function SCT:SetDmgFont()
	if (SCT.db.profile["DMGFONT"]) then
		DAMAGE_TEXT_FONT = SCT.LOCALS.FONTS[SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME1]["FONT"]].path;
	end
end

-------------------------
--Set the font of an object
function SCT:SetFontSize(object, font, textsize, fontshadow)
	object:SetFont(SCT.LOCALS.FONTS[font].path, textsize, arrShadowOutline[fontshadow]);
end

-------------------------
--Determine if a hunter is FD'ing
--Code taken from CTRA
function SCT:CheckFD(unit)
	if ( UnitClass(unit) ~= SCT.LOCALS.HUNTER ) then
		return;
	end
	local hasFD;
	local num, buff = 0, UnitBuff(unit, 1);
	while ( buff ) do
		if ( buff == "Interface\\Icons\\Ability_Rogue_FeignDeath" ) then
			hasFD = 1;
			break;
		end
		num = num + 1;
		buff = UnitBuff(unit, num+1);
	end
	if ( hasFD ) then
		return true;
	else
		return false;
	end
end

-------------------------
--Return the unit if for a given  target
function SCT:GetTargetUnit(target)
	local unit;
	if (target == "player") then
		return "player";
	end
	if (target == UnitName('pet'))then
	  return "pet";
	end
	for i = 1, GetNumRaidMembers(), 1 do
		if ( UnitName("raid" .. i) and UnitName("raid" .. i) == target ) then
			return "raid"..i;
		end
	end
	for i = 1, GetNumPartyMembers(), 1 do
		if ( UnitName("party" .. i) and UnitName("party" .. i) == target ) then
			return "party"..i;
		end
	end
end

-------------------------
--Return the amount the target is overhealed
function SCT:GetOverheal(target, damage)
	local unit = self:GetTargetUnit(target);
	if unit then
		local lost = UnitHealthMax(unit)-UnitHealth(unit);
  	local overheal = damage - lost;
  	if (overheal > 0) then
  		damage = lost.." {"..overheal.."}";
  	end
  end
  return damage;
end

-------------------------
--Regsiter SCT with other mods
function SCT:RegisterOtherMods()
	-- myAddOns support
	if(myAddOnsFrame_Register) then
		local SCTDetails = {
			name = "sct",
			version = SCT.Version,
			optionsframe = "SCTOptions",
			category = MYADDONS_CATEGORY_COMBAT
		};
		myAddOnsFrame_Register(SCTDetails);
	end
	
	--Cosmos support
	if ( EarthFeature_AddButton ) then
		EarthFeature_AddButton(
		   {
		      id="SCT";
		      name=SCT.LOCALS.SCT_CB_NAME;
		      text=SCT.LOCALS.SCT_CB_NAME;
		      subtext=SCT.LOCALS.SCT_CB_SHORT_DESC;
		      helptext=SCT.LOCALS.SCT_CB_LONG_DESC;
		      icon=SCT.LOCALS.SCT_CB_ICON;
		      callback=SCT.ShowMenu;
		   }
		);
	elseif (Cosmos_RegisterButton) then
		Cosmos_RegisterButton (
		   SCT.LOCALS.SCT_CB_NAME,
		   SCT.LOCALS.SCT_CB_SHORT_DESC,
		   SCT.LOCALS.SCT_CB_LONG_DESC,
		   SCT.LOCALS.SCT_CB_ICON,
		   SCT.ShowMenu,
		   function()
		      return true;
		   end
		);
		default_config.ENABLED = 0;
	end

	-- Add to CTMod Control panel if available
	if ( CT_RegisterMod ) then
		CT_RegisterMod(SCT.LOCALS.CB_NAME, nil, 5, SCT.LOCALS.CB_ICON, SCT.LOCALS.CB_LONG_DESC, "switch", nil, SCT.ShowMenu);
	end
	
end

-------------------------
--Get the default Config
function SCT:GetDefaultConfig()
	local default = {
		["VERSION"] = SCT.Version,
		["ENABLED"] = true,
		["SHOWHIT"] = 1,
		["SHOWMISS"] = 1,
		["SHOWDODGE"] = 1,
		["SHOWPARRY"] = 1,
		["SHOWBLOCK"] = 1,
		["SHOWSPELL"] = 1,
		["SHOWHEAL"] = 1,
		["SHOWRESIST"] = 1,
		["SHOWDEBUFF"] = 1,
		["SHOWBUFF"] = 1,
		["SHOWFADE"] = false,
		["SHOWABSORB"] = 1,
		["SHOWLOWHP"] = 1,
		["SHOWLOWMANA"] = 1,
		["SHOWPOWER"] = 1,
		["SHOWCOMBAT"] = false,
		["SHOWCOMBOPOINTS"] = false,
		["SHOWHONOR"] = 1,
		["SHOWEXECUTE"] = 1,
		["SHOWREP"] = 1,
		["SHOWSELFHEAL"] = 1,
		["SHOWSKILL"] = 1,
		["SHOWTARGETS"] = 1,
		["SHOWSELF"] = false,
		["SHOWOVERHEAL"] = 1,
		["STICKYCRIT"] = 1,
		["FLASHCRIT"] = 1,
		["SPELLTYPE"] = false,
		["SPELLCOLOR"] = false,
		["DMGFONT"] = false,
		["SHOWALLPOWER"] = false,
		["FPSMODE"] = false,
		["ANIMATIONSPEED"] = 15,
		["MOVEMENT"] = 2,
		["LOWHP"] = 40,
		["LOWMANA"] = 40,
		["HEALFILTER"] = 50,
		["PLAYSOUND"] = 1,
		["CUSTOMEVENTS"] = 1,
		["LIGHTMODE"] = false,
		[SCT.FRAMES_DATA_TABLE] = {
			[SCT.FRAME1] = {
				["FONT"] = 1,
				["FONTSHADOW"] = 2,
				["ALPHA"] = 100,
				["ANITYPE"] = 1,
				["ANISIDETYPE"] = 1,
				["XOFFSET"] = 0,
				["YOFFSET"] = 0,
				["DIRECTION"] = false,
				["TEXTSIZE"] = 24,
			},
			[SCT.FRAME2] = {
				["FONT"] = 1,
				["FONTSHADOW"] = 2,
				["ALPHA"] = 100,
				["ANITYPE"] = 1,
				["ANISIDETYPE"] = 1,
				["XOFFSET"] = 0,
				["YOFFSET"] = -150,
				["DIRECTION"] = true,
				["TEXTSIZE"] = 24,
			},
			[SCT.MSG] = {
				["MSGFADE"] = 1.5,
				["MSGFONT"] = 1,
				["MSGFONTSHADOW"] = 2,
				["MSGSIZE"] = 24,
				["MSGYOFFSET"] = -280,
				["MSGXOFFSET"] = 0,
			}
		},
		[SCT.COLORS_TABLE] = {
			["SHOWHIT"] =  {r = 1.0, g = 0.0, b = 0.0},
			["SHOWMISS"] =  {r = 0.0, g = 0.0, b = 1.0},
			["SHOWDODGE"] =  {r = 0.0, g = 0.0, b = 1.0},
			["SHOWPARRY"] =  {r = 0.0, g = 0.0, b = 1.0},
			["SHOWBLOCK"] =  {r = 0.0, g = 0.0, b = 1.0},
			["SHOWSPELL"] =  {r = 0.5, g = 0.0, b = 0.5},
			["SHOWHEAL"] =  {r = 0.0, g = 1.0, b = 0.0},
			["SHOWRESIST"] =  {r = 0.5, g = 0.0, b = 0.5},
			["SHOWDEBUFF"] =  {r = 0.0, g = 0.5, b = 0.5},
			["SHOWABSORB"] =  {r = 1.0, g = 1.0, b = 0.0},
			["SHOWLOWHP"] =  {r = 1.0, g = 0.5, b = 0.5},
			["SHOWLOWMANA"] =  {r = 0.5, g = 0.5, b = 1.0},
			["SHOWPOWER"] =  {r = 1.0, g = 1.0, b = 0.0},
			["SHOWCOMBAT"] =  {r = 1.0, g = 1.0, b = 1.0},
			["SHOWCOMBOPOINTS"] =  {r = 1.0, g = 0.5, b = 0.0},
			["SHOWHONOR"] =  {r = 0.5, g = 0.5, b = 0.7},
			["SHOWBUFF"] =  {r = 0.7, g = 0.7, b = 0.0},
			["SHOWFADE"] =  {r = 0.7, g = 0.7, b = 0.0},
			["SHOWEXECUTE"] =  {r = 0.7, g = 0.7, b = 0.7},
			["SHOWREP"] =  {r = 0.5, g = 0.5, b = 1},
			["SHOWSELFHEAL"] = {r = 0, g = 0.7, b = 0},
			["SHOWSKILL"] = {r = 0, g = 0, b = 0.7}
		},
		[SCT.CRITS_TABLE] = {
			["SHOWEXECUTE"] = 1,
			["SHOWLOWHP"] = 1,
			["SHOWLOWMANA"] = 1,
		},
		[SCT.FRAMES_TABLE] = {
			["SHOWHIT"] = SCT.FRAME1,
			["SHOWMISS"] = SCT.FRAME1,
			["SHOWDODGE"] = SCT.FRAME1,
			["SHOWPARRY"] = SCT.FRAME1,
			["SHOWBLOCK"] = SCT.FRAME1,
			["SHOWSPELL"] = SCT.FRAME1,
			["SHOWHEAL"] = SCT.FRAME2,
			["SHOWRESIST"] = SCT.FRAME1,
			["SHOWDEBUFF"] = SCT.FRAME1,
			["SHOWABSORB"] = SCT.FRAME1,
			["SHOWLOWHP"] = SCT.FRAME1,
			["SHOWLOWMANA"] = SCT.FRAME1,
			["SHOWPOWER"] = SCT.FRAME2,
			["SHOWCOMBAT"] = SCT.FRAME2,
			["SHOWCOMBOPOINTS"] = SCT.FRAME1,
			["SHOWHONOR"] = SCT.MSG,
			["SHOWBUFF"] = SCT.MSG,
			["SHOWFADE"] = SCT.FRAME1,
			["SHOWEXECUTE"] = SCT.FRAME1,
			["SHOWREP"] = SCT.MSG,
			["SHOWSELFHEAL"] = SCT.FRAME2	,
			["SHOWSKILL"] = SCT.FRAME2
		}
	};
	return default;
end

-------------------------
--Regsiter SCT with all events
function SCT:RegisterSelfEvents()

	-- Register Main Events
	self:RegisterEvent("UNIT_HEALTH", "OnEvent");
	self:RegisterEvent("UNIT_MANA", "OnEvent");
	self:RegisterEvent("UNIT_ENERGY", "OnEvent");
	self:RegisterEvent("UNIT_RAGE", "OnEvent");
	self:RegisterEvent("UNIT_DISPLAYPOWER", "OnEvent");
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnEvent");
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "OnEvent");
	self:RegisterEvent("PLAYER_COMBO_POINTS", "OnEvent");
	self:RegisterEvent("COMBAT_TEXT_UPDATE", "BlizzardCombatTextEvent");
	
	--unsupported chat events:
	self:RegisterEvent("CHAT_MSG_SKILL", "OnEvent");
	
	--events need for light and normal mode for Parserlib
	parser:RegisterEvent("sct", "CHAT_MSG_SPELL_SELF_BUFF", SCT.ParseCombat) ;
	
	--if in light mode, end here
	if (self.db.profile["LIGHTMODE"]) then
		return;
	end
	
	--events only needed in normal mode for Parserlib
	parser:RegisterEvent("sct", "CHAT_MSG_COMBAT_SELF_HITS", SCT.ParseCombat) ;
	parser:RegisterEvent("sct", "CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS", SCT.ParseCombat) ;
	parser:RegisterEvent("sct", "CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES", SCT.ParseCombat) ;
	parser:RegisterEvent("sct", "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS", SCT.ParseCombat) ;
	parser:RegisterEvent("sct", "CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES", SCT.ParseCombat) ;
	parser:RegisterEvent("sct", "CHAT_MSG_SPELL_SELF_DAMAGE", SCT.ParseCombat) ;
	parser:RegisterEvent("sct", "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE", SCT.ParseCombat) ;
	parser:RegisterEvent("sct", "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF", SCT.ParseCombat) ;
  parser:RegisterEvent("sct", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE", SCT.ParseCombat) ;
	parser:RegisterEvent("sct", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", SCT.ParseCombat) ;
	parser:RegisterEvent("sct", "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS", SCT.ParseCombat) ;
	parser:RegisterEvent("sct", "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE", SCT.ParseCombat) ;
	parser:RegisterEvent("sct", "CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS", SCT.ParseCombat) ;
	parser:RegisterEvent("sct", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS", SCT.ParseCombat) ;
	
	--searchable added events
	local key, value
	for key, value in SCT.EventList do
		self:RegisterEvent(value, "OnEvent");
	end
end

------------------------------
---Sort a table by its keys.
---stolen from http://www.lua.org/pil/19.3.html
function SCT:PairsByKeys (t, f)
  local a = {}
  for n in pairs(t) do table.insert(a, n) end
  table.sort(a, f)
  local i = 0      -- iterator variable
  local iter = function ()   -- iterator function
    i = i + 1
    if a[i] == nil then return nil
    else return a[i], t[a[i]]
    end
  end
  return iter
end

------------------------------
--Create event to load up correct font
--when another mod loads. Incase they try to change
--the font (super inspect, etc...)
SCT:RegisterEvent("ADDON_LOADED", SCT.SetDmgFont);
