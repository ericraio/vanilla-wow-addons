--[[

	SelfCast: Adds self-targeting, either by use of the alt key or automatically
		copyright 2004 by Telo
	
	- If selfcast is enabled, positive spells cast without a friendly target will
	  automatically target the player
	- Otherwise, if alt-casting is enabled, holding the alt key when activating a
	  button will target the player

]]

--------------------------------------------------------------------------------------------------
-- Localizable strings
--------------------------------------------------------------------------------------------------

SELFCAST_HELP = "help";				-- must be lowercase; displays help
SELFCAST_STATUS = "status";			-- must be lowercase; shows status
SELFCAST_ON = "on";					-- must be lowercase; for historical reasons, turns self-targeting on
SELFCAST_OFF = "off";				-- must be lowercase; for historical reasons, turns self-trageting off
SELFCAST_SELFON = "selfon";			-- must be lowercase; turns self-targeting on
SELFCAST_SELFOFF = "selfoff";		-- must be lowercase; turns self-targeting off
SELFCAST_ALTON = "alton";			-- must be lowercase; turns alt-casting on
SELFCAST_ALTOFF = "altoff";			-- must be lowercase; turns alt-casting off

SELFCAST_STATUS_HEADER = "|cffffff00SelfCast status:|r";
SELFCAST_STATUS_SELFON = "SelfCast: |cff00ff00Auto self casting is -ON-.  Beneficial spells will be cast on yourself if you don't have an ally targeted.|r";
SELFCAST_STATUS_SELFOFF = "SelfCast: |cff00ff00Auto self casting is -OFF-.  Beneficial spells must be explicitly targeted.|r";
SELFCAST_STATUS_ALTON = "SelfCast: Alt-casting is on.  Holding Alt while using an action button will target you, if possible.";
SELFCAST_STATUS_ALTOFF = "SelfCast: Alt-casting is off.";

SELFCAST_HELP_TEXT0 = " ";
SELFCAST_HELP_TEXT1 = "|cffffff00SelfCast command help:|r";
SELFCAST_HELP_TEXT2 = "|cff00ff00Use |r|cffffffff/selfcast <command>|r|cff00ff00 or |r|cffffffff/sc <command>|r|cff00ff00 to perform the following commands:|r";
SELFCAST_HELP_TEXT3 = "|cffffffff"..SELFCAST_HELP.."|r|cff00ff00: displays this message.|r";
SELFCAST_HELP_TEXT4 = "|cffffffff"..SELFCAST_STATUS.."|r|cff00ff00: displays status information about the current option settings.|r";
SELFCAST_HELP_TEXT5 = "|cffffffff"..SELFCAST_SELFON.."|r|cff00ff00: turns on auto self casting.  When on, beneficial spells will be cast on yourself if you don't have an ally targeted.|r";
SELFCAST_HELP_TEXT6 = "|cffffffff"..SELFCAST_SELFOFF.."|r|cff00ff00: turns off auto self casting.|r";
SELFCAST_HELP_TEXT7 = "|cffffffff"..SELFCAST_ALTON.."|r|cff00ff00: turns on Alt-casting.  When on, holding Alt while using an action button will target you, if possible.|r";
SELFCAST_HELP_TEXT8 = "|cffffffff"..SELFCAST_ALTOFF.."|r|cff00ff00: turns off Alt-casting.|r";
SELFCAST_HELP_TEXT9 = " ";
SELFCAST_HELP_TEXT10 = "|cff00ff00For example: |r|cffffffff/selfcast selfon|r|cff00ff00 will turn on auto self casting.|r";
SELFCAST_HELP_TEXT11 = " ";
SELFCAST_HELP_TEXT12 = "|cff00ff00Using just |r|cffffffff/selfcast|r|cff00ff00 or |r|cffffffff/sc|r|cff00ff00 without any options will toggle auto-self casting between on and off.";

--------------------------------------------------------------------------------------------------
-- Local variables
--------------------------------------------------------------------------------------------------

-- The list of desired self-cast spells
local localSelfCast = { };
-- Druid
localSelfCast["Abolish Poison"] = 1;
localSelfCast["Cure Poison"] = 1;
localSelfCast["Healing Touch"] = 1;
localSelfCast["Innervate"] = 1;
localSelfCast["Mark of the Wild"] = 1;
localSelfCast["Regrowth"] = 1;
localSelfCast["Rejuvenation"] = 1;
localSelfCast["Remove Curse"] = 1;
localSelfCast["Thorns"] = 1;
-- Mage
localSelfCast["Amplify Magic"] = 1;
localSelfCast["Arcane Intellect"] = 1;
localSelfCast["Dampen Magic"] = 1;
localSelfCast["Remove Lesser Curse"] = 1;
-- Paladin
localSelfCast["Cleanse"] = 1;
localSelfCast["Flash of Light"] = 1;
localSelfCast["Holy Light"] = 1;
localSelfCast["Purify"] = 1;
localSelfCast["Lay on Hands"] = 1;
localSelfCast["Blessing of Freedom"] = 1;
localSelfCast["Blessing of Fury"] = 1;
localSelfCast["Blessing of Kings"] = 1;
localSelfCast["Blessing of Light"] = 1;
localSelfCast["Blessing of Might"] = 1;
localSelfCast["Blessing of Protection"] = 1;
localSelfCast["Blessing of Reckoning"] = 1;
localSelfCast["Blessing of Righteousness"] = 1;
localSelfCast["Blessing of Salvation"] = 1;
localSelfCast["Blessing of Sanctuary"] = 1;
localSelfCast["Blessing of Wisdom"] = 1;
-- Priest
localSelfCast["Abolish Disease"] = 1;
localSelfCast["Cure Disease"] = 1;
localSelfCast["Dispel Magic"] = 2;
localSelfCast["Divine Spirit"] = 1;
localSelfCast["Fear Ward"] = 1;
localSelfCast["Flash Heal"] = 1;
localSelfCast["Greater Heal"] = 1;
localSelfCast["Lesser Heal"] = 1;
localSelfCast["Heal"] = 1;
localSelfCast["Power Word: Fortitude"] = 1;
localSelfCast["Power Word: Shield"] = 1;
localSelfCast["Renew"] = 1;
localSelfCast["Shadow Protection"] = 1;
localSelfCast["Power Infusion"] = 1;
-- Shaman
localSelfCast["Chain Heal"] = 1;
localSelfCast["Cure Disease"] = 1;
localSelfCast["Cure Poison"] = 1;
localSelfCast["Healing Wave"] = 1;
localSelfCast["Lesser Healing Wave"] = 1;
localSelfCast["Water Breathing"] = 1;
localSelfCast["Water Walking"] = 1;
-- Warlock
localSelfCast["Detect Greater Invisibility"] = 1;
localSelfCast["Detect Invisibility"] = 1;
localSelfCast["Detect Lesser Invisibility"] = 1;
localSelfCast["Unending Breath"] = 1;
-- First Aid
localSelfCast["Linen Bandage"] = 1;
localSelfCast["Heavy Linen Bandage"] = 1;
localSelfCast["Wool Bandage"] = 1;
localSelfCast["Heavy Wool Bandage"] = 1;
localSelfCast["Silk Bandage"] = 1;
localSelfCast["Heavy Silk Bandage"] = 1;
localSelfCast["Mageweave Bandage"] = 1;
localSelfCast["Heavy Mageweave Bandage"] = 1;
localSelfCast["Anti-Venom"] = 1;
localSelfCast["Strong Anti-Venom"] = 1;
localSelfCast["Runecloth Bandage"] = 1;
localSelfCast["Heavy Runecloth Bandage"] = 1;
-- Miscellaneous
localSelfCast["Crystal Force"] = 1;
localSelfCast["Crystal Restore"] = 1;
localSelfCast["Crystal Spire"] = 1;
localSelfCast["Crystal Ward"] = 1;

-- Function hooks
local lOriginal_UseAction;
local lOriginal_GameTooltip_ClearMoney;

--------------------------------------------------------------------------------------------------
-- Internal functions
--------------------------------------------------------------------------------------------------

local function SelfCast_MoneyToggle()
	if( lOriginal_GameTooltip_ClearMoney ) then
		GameTooltip_ClearMoney = lOriginal_GameTooltip_ClearMoney;
		lOriginal_GameTooltip_ClearMoney = nil;
	else
		lOriginal_GameTooltip_ClearMoney = GameTooltip_ClearMoney;
		GameTooltip_ClearMoney = SelfCast_GameTooltip_ClearMoney;
	end
end

local function SelfCastStatus()
	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(SELFCAST_STATUS_HEADER);
		if( SelfCastState ) then
			if( SelfCastState.AutoSelfCast ) then
				DEFAULT_CHAT_FRAME:AddMessage(SELFCAST_STATUS_SELFON);
			else
				DEFAULT_CHAT_FRAME:AddMessage(SELFCAST_STATUS_SELFOFF);
			end
			if( SelfCastState.AltOff ) then
				DEFAULT_CHAT_FRAME:AddMessage(SELFCAST_STATUS_ALTOFF);
			else
				DEFAULT_CHAT_FRAME:AddMessage(SELFCAST_STATUS_ALTON);
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage(SELFCAST_STATUS_SELFOFF);
			DEFAULT_CHAT_FRAME:AddMessage(SELFCAST_STATUS_ALTON);
		end
	end
end

function SelfCast(msg)
	if( msg ) then
		local command = string.lower(msg);
		if( command == "" ) then
			if( SelfCastState.AutoSelfCast ) then
				SelfCastState.AutoSelfCast = nil;
			else
				SelfCastState.AutoSelfCast = 1;
			end
			SelfCastStatus();
		elseif( command == SELFCAST_HELP ) then
			local index = 0;
			local value = getglobal("SELFCAST_HELP_TEXT"..index);
			while( value ) do
				DEFAULT_CHAT_FRAME:AddMessage(value);
				index = index + 1;
				value = getglobal("SELFCAST_HELP_TEXT"..index);
			end
		elseif( command == SELFCAST_STATUS ) then
			SelfCastStatus();
		elseif( command == SELFCAST_SELFON or command == SELFCAST_ON ) then
			SelfCastState.AutoSelfCast = 1;
			SelfCastStatus();
		elseif( command == SELFCAST_SELFOFF or command == SELFCAST_OFF ) then
			SelfCastState.AutoSelfCast = nil;
			SelfCastStatus();
		elseif( command == SELFCAST_ALTON ) then
			SelfCastState.AltOff = nil;
			SelfCastStatus();
		elseif( command == SELFCAST_ALTOFF ) then
			SelfCastState.AltOff = 1;
			SelfCastStatus();
		end
	end
end

--------------------------------------------------------------------------------------------------
-- OnFoo functions
--------------------------------------------------------------------------------------------------

function SelfCast_OnLoad()
	-- Register our slash command
	SLASH_SELFCAST1 = "/selfcast";
	SLASH_SELFCAST2 = "/sc";
	SlashCmdList["SELFCAST"] = function(msg)
		SelfCast(msg);
	end

	-- Hook UseAction
	lOriginal_UseAction = UseAction;
	UseAction = SelfCast_UseAction;
	
	this:RegisterEvent("VARIABLES_LOADED");

	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("Telo's SelfCast AddOn loaded");
	end
	UIErrorsFrame:AddMessage("Telo's SelfCast AddOn loaded", 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
end

function SelfCast_OnEvent()
	if( event == "VARIABLES_LOADED" ) then
		if( not SelfCastState ) then
			SelfCastState = { };
		end
		if( AutoSelfCast ) then
			SelfCastState.AutoSelfCast = 1;
		end
		SelfCastStatus();
	end
end

function SelfCast_UseAction(id, type, self)
	local fSelfCast;
	local fSelfCastable;

	if( not SelfCastState.AltOff and IsAltKeyDown() ) then
		fSelfCast = 1;
	elseif( SelfCastState.AutoSelfCast ) then
		-- protect money frame while we set hidden tooltip
		SelfCast_MoneyToggle();
		SelfCastTooltip:SetOwner(UIParent, "ANCHOR_NONE");
		SelfCastTooltip:SetAction(id);
		SelfCast_MoneyToggle();
		
		local name = getglobal("SelfCastTooltipTextLeft1"):GetText();
		if( name and localSelfCast[name] ) then
			-- This spell is self-castable
			fSelfCastable = 1;
			
			if( not UnitExists("target") or UnitCanAttack("player", "target") or
				(not UnitIsPVP("target") and (not UnitPlayerControlled("target") or UnitLevel("target") == 1)) ) then
				fSelfCast = 1;
			end
			
			-- Don't self-cast certain spells if you have any target at all
			if( localSelfCast[name] == 2 and UnitExists("target") ) then
				fSelfCast = nil;
			end
		end
	end
	
	if( fSelfCast ) then
		lOriginal_UseAction(id, type, 1);
	else
		lOriginal_UseAction(id, type, self);
	end
	
	if( fSelfCast or fSelfCastable ) then
		if( SpellIsTargeting() ) then
			SpellTargetUnit("player");
		end
		if( SpellIsTargeting() ) then
			TargetUnit("player");
		end
	end
end

--------------------------------------------------------------------------------------------------
-- Hooked functions
--------------------------------------------------------------------------------------------------

function SelfCast_GameTooltip_ClearMoney()
	-- Intentionally empty; don't clear money while we use hidden tooltips
end
