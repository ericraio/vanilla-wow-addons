--[[ RightClick SelfCast Addon by kritzi ]]--
-- Version 2.10

-- Maintenance by Ozymandius
-- I find this mod invaluable, and can't live without it, which is
-- why I was most upset when it started failing after patch 1.10
-- Never touched the internals of a mod before, but it neded fixing ;)
-- Don't expect any further updates unless it totally breaks again

-- Version History
-- 31/03/06 - 2.10 - Updated to work in patch 1.10
-- TBH, this just involved changing te tooltip defn. in the XML
-- & incrementing the version in the TOC

-- Just right klick a spell and instead of the TargetingCursor
-- you will target yourselfe.

function rSelfCast_OnLoad()
	rSelfCast_Original_UseAction = UseAction;
	UseAction = rSelfCast_UseAction;

	this:RegisterEvent("ADDON_LOADED");
	
	SLASH_rSelfCast1="/rsc";
	SlashCmdList["rSelfCast"] = rSelfCast_Command;

	SLASH_rel1="/rel";
	SlashCmdList["rel"] = rel;
end

function rel()
	ReloadUI();
end

function rSelfCast_Set(type,var,value)
	if(rSelfCast_Array == nil)												then rSelfCast_Array={}; end
	if(rSelfCast_Array[GetLocale()] == nil)									then rSelfCast_Array[GetLocale()]={}; end
	if(rSelfCast_Array[GetLocale()][UnitClass("player")] == nil) 			then rSelfCast_Array[GetLocale()][UnitClass("player")]={}; end
	if(rSelfCast_Array[GetLocale()][UnitClass("player")][type] == nil) 		then rSelfCast_Array[GetLocale()][UnitClass("player")][type]={}; end
	if(rSelfCast_Array[GetLocale()][UnitClass("player")][type][var] == nil) then rSelfCast_Array[GetLocale()][UnitClass("player")][type][var]=value; end
end

function rSelfCast_Get(type,var)
	if    (rSelfCast_Array == nil)												then return nil;
	elseif(rSelfCast_Array[GetLocale()] == nil)									then return nil;
	elseif(rSelfCast_Array[GetLocale()][UnitClass("player")] == nil) 			then return nil;
	elseif(rSelfCast_Array[GetLocale()][UnitClass("player")][type] == nil) 		then return nil;
	else return rSelfCast_Array[GetLocale()][UnitClass("player")][type][var]; end
end

function rSelfCast_OnEvent()
	if(event ~= nil and event == "ADDON_LOADED" and rSelfCast_Disabled == nil) then
		this:RegisterEvent("CHAT_MSG_SPELL_FAILED_LOCALPLAYER");
		if(rSelfCast_Version == nil) then rSelfCast_Version = 200; end
	
	elseif(event ~= nil and event == "CHAT_MSG_SPELL_FAILED_LOCALPLAYER" and arg1 ~= nil and rSelfCast_MouseButton == "RightButton") then
		rSelfCast_Debug(arg1);

		local check_array={
			"Ihr scheitert beim Wirken von (.+): Ung\195\188ltiges Ziel.",
			"Ihr scheitert beim Wirken von (.+): Eure Waffenhand ist leer..",
			"You fail to cast (.+): No target.",
			"You fail to cast (.+): Your weapon hand is empty.",
			"Vous n'avez pas r\195\169ussi \195\160 lancer (.+) : Cible incorrecte.",
			"Vous n'avez pas r\195\169ussi \195\160 lancer (.+) : Vous n'avez pas d'arme en main.."
		}

		for i,check in check_array do
			for action in string.gfind(arg1, check) do
				rSelfCast_Debug("Adding '"..action.."' as a not SelfCast able.");
				rSelfCast_Set("no_selfcast",action,true);
			end
		end
	end
end

function rSelfCast_UseAction(id, type, self)
	rSelfCast_MouseButton = arg1;
	
	if(rSelfCast_MouseButton == "RightButton" and rSelfCast_Disabled == nil) then
		rSelfCast_Debug("Performing right-click");
		rSelfCast_Tooltip:SetAction(id);
		if(rSelfCast_TooltipTextLeft1 ~= nil) then
			local action=rSelfCast_TooltipTextLeft1:GetText();
			rSelfCast_Debug("ToolTipTextLeft1 = '"..action.."'.");
			
			if(rSelfCast_Get("no_selfcast",action) == nil) then
				self = 1;
				if(rSelfCast_Get("selfcast_bug",action) == true) then
					rSelfCast_Debug("Change Target to Player because '"..action.."' is buggy.");
					TargetUnit("player");
				end
			end
			
			rSelfCast_Original_UseAction(id, type, self);
			
			if(SpellIsTargeting() and self == 1) then
				rSelfCast_Debug("Adding '"..action.."' as buggy.");
				rSelfCast_Set("selfcast_bug",action,true);
				SpellTargetUnit("player");
			elseif(rSelfCast_Get("selfcast_bug",action) == true) then
				rSelfCast_Debug("Switch back to the last Target.");
				TargetLastTarget();
			end
		end
	else
		rSelfCast_Original_UseAction(id, type, self);
	end
end

function rSelfCast_Command(cmd)
	if(cmd ~= nil and cmd == "enable") then
		rSelfCast_Disabled=nil;
		if(rSelfCast_Original_UseAction == nil) then
			rSelfCast_Original_UseAction = UseAction;
			UseAction = rSelfCast_UseAction;
		end
		this:RegisterEvent("CHAT_MSG_SPELL_FAILED_LOCALPLAYER");
		
		DEFAULT_CHAT_FRAME:AddMessage("rSelfCast is now enabled.");
	
	elseif(cmd ~= nil and cmd == "disable") then
		rSelfCast_Disabled=true;
		this:UnregisterEvent("CHAT_MSG_SPELL_FAILED_LOCALPLAYER");
		
		DEFAULT_CHAT_FRAME:AddMessage("rSelfCast is now disabled.");
	
	elseif(cmd ~= nil and cmd == "debug enable" and rSelfCast_Disabled == nil) then
		rSelfCast_DebugMode=true;
		DEFAULT_CHAT_FRAME:AddMessage("rSelfCast debug mode is now enabled.");

	elseif(cmd ~= nil and cmd == "debug disable" and rSelfCast_Disabled == nil) then
		rSelfCast_DebugMode=nil;
		DEFAULT_CHAT_FRAME:AddMessage("rSelfCast debug mode is now disabled.");

	elseif(cmd ~= nil and cmd == "reset" and rSelfCast_Disabled == nil and rSelfCast_DebugMode == true) then
		rSelfCast_Array=nil;
		DEFAULT_CHAT_FRAME:AddMessage("All collected rSelfCast data were reseted.");
		rSelfCast_Debug("TEST 1");

	else
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff78rSelfCast Help:|r");
		if(rSelfCast_Disabled == true) then
			DEFAULT_CHAT_FRAME:AddMessage("The AddOn is disabled for this profile.");
			DEFAULT_CHAT_FRAME:AddMessage(" |cffffff78/rsc enable|r - activates the AddOn");
		else
			if(rSelfCast_DebugMode == true) then
				DEFAULT_CHAT_FRAME:AddMessage("The debug mode is enabled.");
				DEFAULT_CHAT_FRAME:AddMessage(" |cffffff78/rsc debug disable|r - deactivates the debug mode.");
				DEFAULT_CHAT_FRAME:AddMessage(" |cffffff78/rsc reset|r - deletes all collected data.");
			else
				DEFAULT_CHAT_FRAME:AddMessage(" |cffffff78/rsc debug enable|r - activates the debug mode.");
			end
			DEFAULT_CHAT_FRAME:AddMessage(" |cffffff78/rsc disable|r - deactivates the AddOn for this profile.");
		end
	end
end

function rSelfCast_Debug(string)
	if(rSelfCast_DebugMode == true and string ~= nil) then
		DEFAULT_CHAT_FRAME:AddMessage("|cffff6666rSC debug|r - "..string);
	end
end