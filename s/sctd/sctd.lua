--[[
  ****************************************************************
	Scrolling Combat Text - Damage 2.0

	Author: Grayhoof
	****************************************************************

	Official Site:
		http://grayhoof.wowinterface.com 
	
	****************************************************************]]
--embedded libs
local parser = ParserLib:GetInstance("1.1")	

--global name
SCTD = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceHook-2.0");

--Add new frame to SCT
SCT.FRAME3 = 3;
local arrAniData3 = {};
tinsert(SCT.ArrayAniData, arrAniData3);

local MSG_Y_OFFSET = 0;
local arrMsgData = {
		["MSGTEXT1"] = {size=1, xoffset=0, yoffset=0, align="CENTER", height=5, duration=1},
}

local default_config = {
		["SCTD_VERSION"] = SCTD.Version,
		["SCTD_ENABLED"] = 1,
		["SCTD_SHOWMELEE"] = 1,
		["SCTD_SHOWPERIODIC"] = 1,
		["SCTD_SHOWSPELL"] = 1,
		["SCTD_SHOWPET"] = 1,
		["SCTD_SHOWCOLORCRIT"] = false,
		["SCTD_FLAGDMG"] = false,
		["SCTD_SHOWDMGTYPE"] = false,
		["SCTD_SHOWSPELLNAME"] = 1,
		["SCTD_SHOWRESIST"] = 1,
		["SCTD_SHOWTARGETS"] = false,
		["SCTD_DMGFONT"] = 1,
		["SCTD_TARGET"] = false,
		["SCTD_PVPDMG"] = false,
		["SCTD_USESCT"] = 1,
		["SCTD_STICKYCRIT"] = 1,
		["SCTD_SPELLCOLOR"] = false
	};
	
local default_config_colors = {
		["SCTD_SHOWMELEE"] = {r = 1.0, g = 1.0, b = 1.0},
		["SCTD_SHOWPERIODIC"] = {r = 1.0, g =1.0, b = 0.0},
		["SCTD_SHOWSPELL"] = {r = 1.0, g = 1.0, b = 0.0},
		["SCTD_SHOWPET"] = {r = 0.6, g = 0.6, b = 0.0},
		["SCTD_SHOWCOLORCRIT"] = {r = 0.2, g = 0.4, b = 0.6}
}

local default_frame_config = {
		["FONT"] = 1,
		["FONTSHADOW"] = 2,
		["ALPHA"] = 100,
		["ANITYPE"] = 1,
		["ANISIDETYPE"] = 1,
		["XOFFSET"] = 0,
		["YOFFSET"] = 210,
		["DIRECTION"] = false,
		["TEXTSIZE"] = 24,
		["FADE"] = 1.5
}

local arrShadowOutline = {
	[1] = "",
	[2] = "OUTLINE",
	[3] = "THICKOUTLINE"
}

----------------------
--Called on login
function SCTD:OnEnable()
	--check SCT version
	if (not SCT) or (tonumber(SCT.db.profile["VERSION"]) < 5) then
		StaticPopupDialogs["SCTD_VERSION"] = {
								  text = SCTD.LOCALS.Version_Warning,
								  button1 = TEXT(OKAY) ,
								  timeout = 0,
								  whileDead = 1,
								  hideOnEscape = 1,
								  showAlert = 1
								};
		StaticPopup_Show("SCTD_VERSION");
		if (SCTOptionsFrame_Misc103) then
			SCTOptionsFrame_Misc103:Hide();
		end
		self:OnDisable();
		return;
	end
	self:RegisterSelfEvents();
end

----------------------
-- Disable all events, not using AceDB, but may as well name it right.
function SCTD:OnDisable()
	-- no more events to handle
	parser:UnregisterAllEvents("sctd")
	self:UnregisterAllEvents()
end

----------------------
--Called when addon loaded
function SCTD:OnInitialize()
	
	--slash commands
	local main = {
		type="group",
		args = {
			menu = {
				name = "Menu", type = 'execute',
		    desc = "Display SCT Option Menu",
		    func = function()
		        self:ShowSCTDMenu();
    		end
			},
		}
	}
	local menu = {
		type = 'execute',
    desc = "Display SCTD Option Menu",
    func = function()
        self:ShowSCTDMenu();
    end
	}
	
	self:RegisterChatCommand({"/sctd"}, main);
	self:RegisterChatCommand({"/sctdmenu"}, menu);
	
	--register with other mods
	self:RegisterOtherMods();
	
	--Hook SCT show menu
	self:Hook(SCT, "ShowMenu")
							
	--update old values
	self:UpdateValues();
	
	--setup msgs
	self:MsgInit();

end

----------------------
-- Show the Option Menu
function SCTD:ShowSCTDMenu()
	local loaded, message = LoadAddOn("sct_options");
	if (loaded) then
		--if options page exsists (not disabled)
		if (SCTDOptions) then
			PlaySound("igMainMenuOpen");
			--Hook SCT ShowExample
			if (not SCTD:IsHooked(SCT, "ShowExample")) then
				SCTD:Hook(SCT, "ShowExample");
			end
			--show options
			SCTDOptions:Show();
			--update animation options
			SCTD:UpdateAnimationOptions()
		else
			PlaySound("TellMessage");
			SCTD:Print(SCTD.LOCALS.Load_Error);
		end
	else
		PlaySound("TellMessage");
		SCTD:Print(SCT.LOCALS.Load_Error.." "..message);
	end;
end

----------------------
--Reset everything to default for SCTD
function SCTD:ShowMenu()
	SCTD:UpdateValues();
	--open sct menu
	self.hooks[SCT].ShowMenu.orig();
	--Hook SCT ShowExample
	if (not self:IsHooked(SCT, "ShowExample") and SCT.ShowExample) then
		self:Hook(SCT, "ShowExample");
	end
	--if window is showing, reload it
	if (SCTDOptions) and (SCTDOptions:IsVisible()) then
		SCTDOptions:Hide();
		SCTDOptions:Show();
	end
end

----------------------
-- display ddl or chxbox based on type
function SCTD:UpdateAnimationOptions()
	--get scroll down checkbox
	local chkbox = getglobal("SCTOptionsFrame_CheckButton113");
	--get anime type dropdown
	local ddl1 = getglobal("SCTOptionsFrame_Selection103");
	--get animside type dropdown
	local ddl2 = getglobal("SCTOptionsFrame_Selection104");
	--get item
	local id = UIDropDownMenu_GetSelectedID(ddl1)
	if (id == 1 or id == 6) then
		chkbox:Show();
		ddl2:Hide();
	else
		chkbox:Hide();
		ddl2:Show();
	end
end

----------------------
--Hide the Option Menu
function SCTD:HideMenu()
	PlaySound("igMainMenuClose");
	SCTDOptions:Hide();
	SCTD_EXAMPLEMSG:Hide();
end

---------------------
--Show SCT Example
function SCTD:ShowExample()
	self.hooks[SCT].ShowExample.orig();
	self:MsgInit()
	self:SetDamageFlags();
	
	--animated example for options that may need it
	local option = this.SCTVar or "SCTD_SHOWMELEE";
	if (string.find(option,"SCTD_SHOW")) then
		self:DisplayText(option, self.LOCALS.EXAMPLE);
	end
	
	--show msg frame
	SCTD_EXAMPLEMSG:Show();

	--show example FRAME3
	--get object
	example = getglobal("SCTDMsgExample1");
	--set text size
	SCT:SetFontSize(example,
									SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["FONT"],
									SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["TEXTSIZE"],
									SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["FONTSHADOW"]);
	--set the color
	example:SetTextColor(1, 1, 1);
	--set alpha
	example:SetAlpha(SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["ALPHA"]/100);
	--Position
	example:SetPoint("CENTER", "UIParent", "CENTER", 
									 SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["XOFFSET"], 
									 SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["YOFFSET"]);
	--Set the text to display
	example:SetText(self.LOCALS.EXAMPLE);
	
	--update animation options
	self:UpdateAnimationOptions()
end

----------------------
--Update old values for new versions
function SCTD:UpdateValues()
	local i, var;
	--set defaults
	for i in default_config do
		if(SCT.db.profile[i] == nil) then
			SCT.db.profile[i] = default_config[i];
		end
	end
	--set colors
	for i in default_config_colors do
		var = SCT.db.profile[SCT.COLORS_TABLE][i] or default_config_colors[i];
		SCT.db.profile[SCT.COLORS_TABLE][i] = var;
	end
	--set frame data
	if (not SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]) then
		SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME3] = {};
	end
	for i in default_frame_config do
		if (SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME3][i] == nil) then
			SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME3][i] = default_frame_config[i];
		end
	end
end

----------------------
-- Event Handler
function SCTD:OnEvent()		
	--Player PvP status changed
	SCTD:SetDamageFlags();
end

----------------------
--Determine if its a "melee" ranged evet
function SCTD:IsMeleeRanged(skill)
	if (skill == ParserLib_MELEE or
			skill == self.LOCALS.AUTO_SHOT or
			--skill == self.LOCALS.SHOOT or
			skill == self.LOCALS.SHOOT_BOW or
			skill == self.LOCALS.SHOOT_CROSSBOW or
			skill == self.LOCALS.SHOOT_GUN) then
		return true;
	else
		return false;
	end
end

----------------------
-- Parses all combat events using paserlib
function SCTD:ParseCombat(info)
	--self doesn't work here because of the call from ParserLib
	local self = SCTD;
	
	--exit if not enabled
	if (not SCT.db.profile["SCTD_ENABLED"]) then
		return;
	end
	
	--Hits (melee, spell, etc..)
	if (info.type == "hit") then
		if (info.source == ParserLib_SELF) then
			if (self:IsMeleeRanged(info.skill)) then
				self:DisplayText("SCTD_SHOWMELEE", info.amount, info.isCrit, nil, nil, info.victim);
			else
				if (info.isDOT) then
					self:DisplayText("SCTD_SHOWPERIODIC", info.amount, nil, info.element, info.amountResist, info.victim, info.skill);
				else
					self:DisplayText("SCTD_SHOWSPELL", info.amount, info.isCrit, info.element, info.amountResist, info.victim, info.skill);
				end
			end
		elseif (SCT:GetTargetUnit(info.source) == "pet") then
			if (info.skill == ParserLib_MELEE) then
				self:DisplayText("SCTD_SHOWPET", info.amount, info.isCrit, info.element, info.amountResist, info.victim, PET);
			else
				self:DisplayText("SCTD_SHOWPET", info.amount, info.isCrit, info.element, info.amountResist, info.victim, info.skill);
			end
		end	
	
	--Miss Events
	elseif (info.type == "miss") then
		local source;
		--if its self, player, else see if its pet
		if (info.source == ParserLib_SELF) then
			source = "player";
		else
			source = SCT:GetTargetUnit(info.source);
		end;
		--remove skill if melee or ranged non-skill
		if (self:IsMeleeRanged(info.skill)) then
			info.skill = nil;
		end
		--if pet or player
		if (source == "player") or (source == "pet")then
			local type = "SCTD_SHOWMELEE";
			if (info.skill) then
				type="SCTD_SHOWSPELL";
			end
			if (source == "pet") then
				type="SCTD_SHOWPET";
			end
			if (info.missType == "miss") then
				self:DisplayText(type, MISS, nil, nil, nil, info.victim, info.skill);
			elseif (info.missType == "dodge") then
				self:DisplayText(type, DODGE, nil, nil, nil, info.victim, info.skill);
			elseif (info.missType == "block") then
				self:DisplayText(type, BLOCK, nil, nil, nil, info.victim, info.skill);
			elseif (info.missType == "deflect") then
				self:DisplayText(type, DEFLECT, nil, nil, nil, info.victim, info.skill);
			elseif (info.missType == "immune") then
				self:DisplayText(type, IMMUNE, nil, nil, nil, info.victim, info.skill);
			elseif (info.missType == "evade") then
				self:DisplayText(type, EVADE, nil, nil, nil, info.victim, info.skill);
			elseif (info.missType == "parry") then
				self:DisplayText(type, PARRY, nil, nil, nil, info.victim, info.skill);
			elseif (info.missType == "resist") then
				self:DisplayText(type, RESIST, nil, nil, nil, info.victim, info.skill);
			elseif (info.missType == "reflect") then
				self:DisplayText(type, REFLECT, nil, nil, nil, info.victim, info.skill);
			elseif (info.missType == "absorb") then
				self:DisplayText(type, ABSORB, nil, nil, nil, info.victim, info.skill);
			end
		end
	end
end


----------------------
--Display for mainly combat events
--Mainly used for short messages
function SCTD:DisplayText(option, msg1, crit, damagetype, resisted, target, spell)
	local rbgcolor, showcrit, showmsg, adat;
	--if option is on
	if (SCT.db.profile[option]) then
		--if show only target
		if (SCT.db.profile["SCTD_TARGET"]) then
			if (target ~= UnitName("target")) then
				return;
			end
		end
		--get options
		rbgcolor = SCT.db.profile[SCT.COLORS_TABLE][option];
		--if damage type
		if ((damagetype) and (SCT.db.profile["SCTD_SHOWDMGTYPE"])) then
			msg1 = msg1.." "..damagetype.."";
		end
		--if spell color
		if ((damagetype) and (SCT.db.profile["SCTD_SPELLCOLOR"])) then
			rbgcolor = SCT.SpellColors[damagetype] or rbgcolor;
		end
		--if resisted
		if ((resisted) and (SCT.db.profile["SCTD_SHOWRESIST"])) then
			msg1 = msg1.." {"..resisted.."}";
		end
		--if target label
		if ((target) and (SCT.db.profile["SCTD_SHOWTARGETS"])) then
			msg1 = target..": "..msg1;
		end
		--if spell 
		if ((spell) and (SCT.db.profile["SCTD_SHOWSPELLNAME"])) then
			msg1 = msg1.." ("..spell..")";
		end
		--if flag
		if (SCT.db.profile["SCTD_FLAGDMG"]) then
			msg1 = self.LOCALS.SelfFlag..msg1..self.LOCALS.SelfFlag;
		end
		--if crit
		if (crit) then
			if (SCT.db.profile["SCTD_SHOWCOLORCRIT"]) then
				rbgcolor = SCT.db.profile[SCT.COLORS_TABLE]["SCTD_SHOWCOLORCRIT"];
			end
			self:Display_Crit_Damage( msg1, rbgcolor );
		else
			self:Display_Damage( msg1, rbgcolor );
		end

	end
end


----------------------
--Displays a message at the top of the screen
function SCTD:Display_Damage(msg, color)
	if (SCT.db.profile["SCTD_USESCT"]) then
			SCT:DisplayText(msg, color, nil, "damage", SCT.FRAME3);
	else
		SCTD_MSGTEXT1:SetPoint("CENTER", "UIParent", "CENTER",
													 SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["XOFFSET"],
													 SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["YOFFSET"] + MSG_Y_OFFSET);
		SCTD_MSGTEXT1:SetTimeVisible(SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["FADE"]);
		SCTD_MSGTEXT1:AddMessage(msg, color.r, color.g, color.b, 1);
	end
end

----------------------
--Displays a message at the top of the screen
function SCTD:Display_Crit_Damage(msg, color)
	if (SCT.db.profile["SCTD_STICKYCRIT"]) then
		SCT:DisplayText(msg, color, 1, "damage", SCT.FRAME3);
	elseif (SCT.db.profile["SCTD_USESCT"]) then
		SCT:DisplayText("+"..msg.."+", color, nil, "damage", SCT.FRAME3);
	else
		SCTD_MSGTEXT1:SetPoint("CENTER", "UIParent", "CENTER",
													 SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["XOFFSET"],
													 SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["YOFFSET"] + MSG_Y_OFFSET);
		SCTD_MSGTEXT1:SetTimeVisible(SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["FADE"] or 1.5);
		SCTD_MSGTEXT1:AddMessage("+"..msg.."+", color.r, color.g, color.b, 1);
	end
end

------------------------
--Setup msg arrays
function SCTD:MsgInit()
	for key, value in arrMsgData do
		value.FObject = getglobal("SCTD_"..key);
		self:SetMsgFont(value.FObject);
	end
	self:SetDamageFlags()
end

------------------------
--Setup Damage Flags based on Options
function SCTD:SetDamageFlags()
	--set WoW Damage Flags
	if (SCT.db.profile["SCTD_DMGFONT"]) then
		SetCVar("CombatDamage", 0);
		self:SetPvPDamageFlags();
	else
		SetCVar("CombatDamage", 1);
	end
end

------------------------
--Setup Damage Flags based on Options and PvP status
function SCTD:SetPvPDamageFlags()
	--set WoW Damage Flags
	if (SCT.db.profile["SCTD_PVPDMG"]) then
		if (UnitIsPVP("player")) then
			SetCVar("CombatDamage", 1);
			SCT.db.profile["SCTD_ENABLED"] = false;
		else
			SetCVar("CombatDamage", 0);
			SCT.db.profile["SCTD_ENABLED"] = 1;
		end
	end
end

-------------------------
--Set the font of an object using msg vars
function SCTD:SetMsgFont(object)
	--set font
	object:SetFont(SCT.LOCALS.FONTS[SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["FONT"]].path,
								 SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["TEXTSIZE"], 
								 arrShadowOutline[SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["FONTSHADOW"]]);
	--reset size of allow 5 messages
	object:SetHeight(SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME3]["TEXTSIZE"] * 6)
	--Set Fade Duration
	object:SetFadeDuration(1);
	--set offset to center
	MSG_Y_OFFSET = object:GetHeight()/2;
end

----------------------
--Register All Events
function SCTD:RegisterSelfEvents()
	--core events	
	self:RegisterEvent("UNIT_FACTION", "OnEvent");
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnEvent");
	
	--core chat events for Parserlib
	parser:RegisterEvent("sctd", "CHAT_MSG_COMBAT_SELF_HITS", SCTD.ParseCombat) ;
	parser:RegisterEvent("sctd", "CHAT_MSG_COMBAT_SELF_MISSES", SCTD.ParseCombat) ;
	parser:RegisterEvent("sctd", "CHAT_MSG_SPELL_SELF_DAMAGE", SCTD.ParseCombat) ;
	parser:RegisterEvent("sctd", "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE", SCTD.ParseCombat) ;
	parser:RegisterEvent("sctd", "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE", SCTD.ParseCombat) ;
	parser:RegisterEvent("sctd", "CHAT_MSG_COMBAT_PET_HITS", SCTD.ParseCombat) ;
	parser:RegisterEvent("sctd", "CHAT_MSG_COMBAT_PET_MISSES", SCTD.ParseCombat) ;
	parser:RegisterEvent("sctd", "CHAT_MSG_SPELL_PET_DAMAGE", SCTD.ParseCombat) ;
end

-------------------------
--Regsiter SCTD with other mods
function SCTD:RegisterOtherMods()
	-- myAddOns support
	if(myAddOnsFrame_Register) then
		local SCTDDetails = {
			name = "sctd",
			version = SCTD.Version,
			optionsframe = "SCTDOptions",
			category = MYADDONS_CATEGORY_COMBAT
		};
		myAddOnsFrame_Register(SCTDDetails);
	end
	
	--Cosmos support
	if ( EarthFeature_AddButton ) then
		EarthFeature_AddButton(
		   {
		      id="SCT";
		      name=self.LOCALS.CB_NAME;
		      text=self.LOCALS.CB_NAME;
		      subtext=self.LOCALS.CB_SHORT_DESC;
		      helptext=self.LOCALS.CB_LONG_DESC;
		      icon=self.LOCALS.CB_ICON;
		      callback=SCTD.ShowSCTDMenu;
		   }
		);
	elseif (Cosmos_RegisterButton) then
		Cosmos_RegisterButton (
		   self.LOCALS.CB_NAME,
		   self.LOCALS.CB_SHORT_DESC,
		   self.LOCALS.CB_LONG_DESC,
		   self.LOCALS.CB_ICON,
		   SCTD.ShowSCTDMenu,
		   function()
		      return true;
		   end
		);
		default_config.ENABLED = 0;
	end
	
	-- Add to CTMod Control panel if available
	if ( CT_RegisterMod ) then
		CT_RegisterMod(self.LOCALS.CB_NAME, nil, 5, self.LOCALS.CB_ICON, self.LOCALS.CB_LONG_DESC, "switch", nil, SCTD.ShowSCTDMenu);
	end
end