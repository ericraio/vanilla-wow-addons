--[[
	Nurfed_PlayerFrame.lua
	GypsyVersion++2004.11.13++

	Moves the player frame to the bottom
	left corner of the screen.
	Adds health, mana, and experience
	text, as well as hit point percentage
	and rested experience bonus to the right
	and below the default player frame.
	Adds graphical framework to accomodate
	the textual displays.
	Moves the right click player window
	to be viewable with the new player frame
	placement.
]]

-- ** DEFAULT SETTINGS ** --

-- Color player health by default
Nurfed_DefaultColorPlayerHealth = 1;
-- Color player mana by default
Nurfed_DefaultColorPlayerMana = 1;
-- Color player name on attack by default
Nurfed_DefaultColorPlayerName = 1;
-- Color player health bar by default
Nurfed_DefaultColorPlayerHealthBar = 1;

-- ** PLAYER FRAME FUNCTIONS ** --

function Nurfed_PlayerFrameOnLoad ()
	-- Health and mana registrations
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_MANA");
	this:RegisterEvent("UNIT_RAGE");
	this:RegisterEvent("UNIT_FOCUS");
	this:RegisterEvent("UNIT_ENERGY");
	-- If a druid shapeshifts, the bar changes from rage/mana/energy/etc
	this:RegisterEvent("UPDATE_SHAPESHIFT_FORMS");
	-- Experience registrations
	this:RegisterEvent("PLAYER_XP_UPDATE");
	this:RegisterEvent("UPDATE_EXHAUSTION");
	this:RegisterEvent("PLAYER_LEVEL_UP");
	-- Register for variable loading to run our configuration registrations
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("VARIABLES_LOADED");
	-- Combat events for coloring the player name
	this:RegisterEvent("PLAYER_ENTER_COMBAT");
	this:RegisterEvent("PLAYER_LEAVE_COMBAT");
end

function Nurfed_PlayerFrameOnEvent (event)
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		-- We need to do an initial display of	all our values when the player first logs in.
		Nurfed_ShowPlayerHealth();
		Nurfed_ShowPlayerHealthPercent();
		Nurfed_ShowPlayerMana();
		Nurfed_ShowPlayerExp();
		return;
	end
	-- Added unit exp handles to update the player displayed experience numbers.
	if(event == "PLAYER_XP_UPDATE" or event == "UPDATE_EXHAUSTION" or event == "PLAYER_LEVEL_UP") then
		Nurfed_ShowPlayerExp();
		return;
	end
	-- Added unit_health and unit_mana (ish) event handlers.  Anytime either of these values change, we need to update.
	if( event == "UNIT_HEALTH" ) then
		Nurfed_ShowPlayerHealth();
		Nurfed_ShowPlayerHealthPercent();
		return;
	end
	-- Also keep in mind, "mana" is really mana, energy, focus, or rage, so we need to watch all of those.
	if( event == "UNIT_MANA" or event == "UNIT_RAGE" or event == "UNIT_FOCUS" or event == "UNIT_ENERGY" or event == "UPDATE_SHAPESHIFT_FORMS") then
		Nurfed_ShowPlayerMana();
		return;
	end
	-- Color the player name text red when entering combat
	if (event == "PLAYER_ENTER_COMBAT") then
		Nurfed_UpdateAttackState();
		return;
	end
	-- Reset player name text
	if (event == "PLAYER_LEAVE_COMBAT") then
		Nurfed_UpdateAttackState();
		return;
	end
	-- When variables load, run our options setup
	if (event == "VARIABLES_LOADED") then
		-- Check to see if the player frame is a standalone addon or if the GypsyMod shell is available
		if (Nurfed_SHELL == 1) then
			-- Set defaults if there is no saved value
			if (Nurfed_RetrieveSaved("ColorPlayerHealth") == nil) then
				Nurfed_ColorPlayerHealth = Nurfed_DefaultColorPlayerHealth;
			else
				Nurfed_ColorPlayerHealth = Nurfed_RetrieveSaved("ColorPlayerHealth");
			end
			if (Nurfed_RetrieveSaved("ColorPlayerMana") == nil) then
				Nurfed_ColorPlayerMana = Nurfed_DefaultColorPlayerMana;
			else
				Nurfed_ColorPlayerMana = Nurfed_RetrieveSaved("ColorPlayerMana");
			end
			if (Nurfed_RetrieveSaved("ColorPlayerName") == nil) then
				Nurfed_ColorPlayerName = Nurfed_DefaultColorPlayerName;
			else
				Nurfed_ColorPlayerName = Nurfed_RetrieveSaved("ColorPlayerName");
			end
			if (Nurfed_RetrieveSaved("ColorPlayerHealthBar") == nil) then
				Nurfed_ColorPlayerHealthBar = Nurfed_DefaultColorPlayerHealthBar;
			else
				Nurfed_ColorPlayerHealthBar = Nurfed_RetrieveSaved("ColorPlayerHealthBar");
			end
			--Register with GypsyMod saving
			Nurfed_RegisterOption(210, "header", nil, nil, nil, Nurfed_TEXT_UNITBARS_PLAYERHEADERLABEL, Nurfed_TEXT_UNITBARS_PLAYERHEADERTOOLTIP);
			Nurfed_RegisterOption(211, "check", Nurfed_ColorPlayerHealth, "ColorPlayerHealth", Nurfed_ShowPlayerHealthPercent, Nurfed_TEXT_UNITBARS_COLORPLAYERTEXTLABEL, Nurfed_TEXT_UNITBARS_COLORPLAYERTEXTTOOLTIP);
			Nurfed_RegisterOption(212, "check", Nurfed_ColorPlayerMana, "ColorPlayerMana", Nurfed_ShowPlayerMana, Nurfed_TEXT_UNITBARS_COLORPLAYERMANATEXTLABEL, Nurfed_TEXT_UNITBARS_COLORPLAYERMANATEXTTOOLTIP);
			Nurfed_RegisterOption(213, "check", Nurfed_ColorPlayerName, "ColorPlayerName", nil, Nurfed_TEXT_UNITBARS_COLORNAMELABEL, Nurfed_TEXT_UNITBARS_COLORNAMETOOLTIP);
			Nurfed_RegisterOption(214, "check", Nurfed_ColorPlayerHealthBar, "ColorPlayerHealthBar", Nurfed_ShowPlayerHealthPercent, Nurfed_TEXT_UNITBARS_COLORPLAYERBARLABEL, Nurfed_TEXT_UNITBARS_COLORPLAYERBARTOOLTIP);
		else
			-- If our toggles aren't saved, default to on
			if (Nurfed_ColorPlayerHealth == nil) then
				Nurfed_ColorPlayerHealth = Nurfed_DefaultColorPlayerHealth;
			end
			if (Nurfed_ColorPlayerMana == nil) then
				Nurfed_ColorPlayerMana = Nurfed_DefaultColorPlayerMana;
			end
			if (Nurfed_ColorPlayerName == nil) then
				Nurfed_ColorPlayerName = Nurfed_DefaultColorPlayerName;
			end
			if (Nurfed_ColorPlayerHealthBar == nil) then
				Nurfed_ColorPlayerHealthBar = Nurfed_DefaultColorPlayerHealthBar;
			end
			-- Save manually for standalone options
			--RegisterForSave("Nurfed_ColorPlayerHealth");
			--RegisterForSave("Nurfed_ColorPlayerMana");
			--RegisterForSave("Nurfed_ColorPlayerName");
			--RegisterForSave("Nurfed_ColorPlayerHealthBar");
			-- Register slash commands
			SlashCmdList["Nurfed_COLORPLAYERHEALTH"] = Nurfed_ColorPlayerHealthSlashHandler;
			SLASH_Nurfed_COLORPLAYERHEALTH1 = "/unitbarcolorplayerhealth";
			SLASH_Nurfed_COLORPLAYERHEALTH2 = "/ubcolorplayerhealth";
			SlashCmdList["Nurfed_COLORPLAYERMANA"] = Nurfed_ColorPlayerManaSlashHandlers;
			SLASH_Nurfed_COLORPLAYERMANA1 = "/unitbarcolorplayermana";
			SLASH_Nurfed_COLORPLAYERMANA2 = "/ubcolorplayermana";
			SlashCmdList["Nurfed_COLORPLAYERNAME"] = Nurfed_ColorPlayerNameSlashHandlers;
			SLASH_Nurfed_COLORPLAYERNAME1 = "/unitbarcolorplayername";
			SLASH_Nurfed_COLORPLAYERNAME2 = "/ubcolorplayername";
			SlashCmdList["Nurfed_COLORPLAYERHEALTHBAR"] = Nurfed_ColorPlayerHealthBarSlashHandlers;
			SLASH_Nurfed_COLORPLAYERHEALTHBAR1 = "/unitbarcolorplayerhealthbar";
			SLASH_Nurfed_COLORPLAYERHEALTHBAR2 = "/ubcolorplayerhealthbar";
		end
		return;
	end
end

-- Update player name depending on attack state
function Nurfed_UpdateAttackState ()
	if (Nurfed_RetrieveOption ~= nil) then
		if (Nurfed_RetrieveOption(213) ~= nil) then
			Nurfed_ColorPlayerName = Nurfed_RetrieveOption(213)[Nurfed_VALUE];
		end
	end
	if (Nurfed_ColorPlayerName == 1) then
		local playerFrame = getglobal("PlayerFrame");
		if (playerFrame.inCombat and playerFrame.OnHateList or playerFrame.inCombat) then
			PlayerName:SetTextColor(1, 0, 0);
		else
			PlayerName:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		end
	end
end

-- ** EXPERIENCE BAR FUNCTIONS ** --

function Nurfed_PlayerFrameExpBarOnLoad ()
	-- Experience bar registrations
	this:RegisterEvent("PLAYER_XP_UPDATE");
	this:RegisterEvent("PLAYER_LEVEL_UP");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	-- Can not be any higher, should not be lower
	this:SetFrameLevel(0);
end

function Nurfed_PlayerFrameExpBarOnEvent (event)
	-- Setup our experience bar when the player logs in, when experience changes, or when the player levels up
	if (event == "PLAYER_XP_UPDATE" or event == "PLAYER_LEVEL_UP" or event == "PLAYER_ENTERING_WORLD") then
		local currXP = UnitXP("player");
		local nextXP = UnitXPMax("player");
		this:SetMinMaxValues(min(0, currXP), nextXP);
		this:SetValue(currXP);
		return;
	end
end

-- ** CLICK CATCH FUNCTIONS ** --

-- Function to register for clicks for the click catcher when it loads
function Nurfed_PlayerFrameClickCatchOnLoad ()
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp");
end

-- Function pulled from PlayerFrame.lua to handle clicks in our AddOn
function Nurfed_PlayerFrameClickCatch(button)
	if ( SpellIsTargeting() and button == "RightButton" ) then
		SpellStopTargeting();
		return;
	end
	if ( button == "LeftButton" ) then
		if ( SpellIsTargeting() ) then
			SpellTargetUnit("player");
		elseif ( CursorHasItem() ) then
			AutoEquipCursorItem();
		else
			TargetUnit("player");
		end
	else
		-- Right click menu needs to be moved
ToggleDropDownMenu(1, nil, PlayerFrameDropDown, "PlayerFrame", 106, 27);
--		UnitPopup_ShowMenu(Nurfed_PlayerFrame, "SELF", "player");
--		UnitPopup:ClearAllPoints();
DropDownList1:ClearAllPoints();
		-- Check for inverted frame status and position the menu accordingly
		if (Nurfed_InvertUnitFrames == 1) then
			DropDownList1:SetPoint("BOTTOMLEFT", "PlayerFrame", "TOPLEFT", 20, -10);
		else
			DropDownList1:SetPoint("TOPLEFT", "PlayerFrame", "BOTTOMLEFT", 20, 10);
		end
	end
end

-- ** TEXT DISPLAY FUNCTIONS ** --

function Nurfed_ShowPlayerHealth()
	-- This gets the whole status text "Health xxxx / yyyy" - we need to parse it to remove the "Health" part
--[[	local text = PlayerFrameHealthBarText:GetText();
	if( text == nil ) then
		Nurfed_PlayerHealthText:SetText("Failure #1");
	else
		-- It always says "Health " first, so just remove the first 7 characters off the string
		local health = strsub(text, 7);
		if(health == nil) then
			Nurfed_PlayerHealthText:SetText("Failure #2");
		else
			Nurfed_PlayerHealthText:SetText(health);
		end
	end]]
	if (UnitHealth("player") and UnitHealthMax("player")) then
		Nurfed_PlayerHealthText:SetText(UnitHealth("player").." / "..UnitHealthMax("player"));
	end
end

function Nurfed_ShowPlayerHealthPercent()
	-- This gets the whole status text "Health xxxx / yyyy" - we need to parse it to remove the "Health" part
--[[	local text = PlayerFrameHealthBarText:GetText();
	if( text == nil ) then
		Nurfed_PlayerHealthPercent:SetText("Failure #1");
	else
		-- It always says "Health " first, so just remove the first 7 characters off the string
		local health = strsub(text, 7);
		-- We now have "617 / 1234".  We need to parse that to 2 variables:  cur = "617" and total = "1234"
		local find = strfind(health, "/");
		if( find == nil ) then
			Nurfed_PlayerHealthPercent:SetText(health);
		else
			local cur = strsub(health, 0, strlen(health)-find);
			if( cur == nil) then
				Nurfed_PlayerHealthPercent:SetText("Failure #2b");
			else
				local total = strsub(health, strlen(cur)+2);
				if(strfind(total, "/") ~= nil) then
					total = strsub(total, 2);
				end

				if ( total == nil ) then
					Nurfed_PlayerHealthPercent:SetText("Failure #2c");
				else
					if( tonumber(cur) == 0 or tonumber(cur) == nil ) then
						-- This can happen if you are dead
						Nurfed_PlayerHealthPercent:SetText("0%");
						return;
					end
					if(tonumber(total) == 0 or tonumber(total) == nil) then
						-- This REALLY should be impossible
						Nurfed_PlayerHealthPercent:SetText("Failure #2d");
						return;
					end
					local percent = (tonumber(cur) / tonumber(total)) * 100;
					Nurfed_PlayerHealthPercent:SetText(ceil(percent) .. "%");
					
					if (Nurfed_RetrieveOption ~= nil) then
						if (Nurfed_RetrieveOption(211) ~= nil) then
							Nurfed_ColorPlayerHealth = Nurfed_RetrieveOption(211)[Nurfed_VALUE];
						end	
						if (Nurfed_RetrieveOption(214) ~= nil) then
							Nurfed_ColorPlayerHealthBar = Nurfed_RetrieveOption(214)[Nurfed_VALUE];
						end
					end
					if (Nurfed_ColorPlayerHealth == 1) then
						if ((percent <= 100) and (percent > 75)) then
							Nurfed_PlayerHealthPercent:SetTextColor(0, 1, 0);
							Nurfed_PlayerHealthText:SetTextColor(0, 1, 0);
						elseif ((percent <= 75) and (percent > 50)) then
							Nurfed_PlayerHealthPercent:SetTextColor(1, 1, 0);
							Nurfed_PlayerHealthText:SetTextColor(1, 1, 0);
						elseif ((percent <= 50) and (percent > 25)) then
							Nurfed_PlayerHealthPercent:SetTextColor(1, 0.5, 0);
							Nurfed_PlayerHealthText:SetTextColor(1, 0.5, 0);
						else
							Nurfed_PlayerHealthPercent:SetTextColor(1, 0, 0);
							Nurfed_PlayerHealthText:SetTextColor(1, 0, 0);
						end
					else
						Nurfed_PlayerHealthPercent:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
						Nurfed_PlayerHealthText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
					end
					if (Nurfed_ColorPlayerHealthBar == 1) then
						if ((percent <= 100) and (percent > 75)) then
							PlayerFrameHealthBar:SetStatusBarColor(0, 1, 0);
						elseif ((percent <= 75) and (percent > 50)) then
							PlayerFrameHealthBar:SetStatusBarColor(1, 1, 0);
						elseif ((percent <= 50) and (percent > 25)) then
							PlayerFrameHealthBar:SetStatusBarColor(1, 0.5, 0);
						else
							PlayerFrameHealthBar:SetStatusBarColor(1, 0, 0);
						end
					else
						PlayerFrameHealthBar:SetStatusBarColor(0, 1, 0);
					end
				end
			end
		end
	end]]
	if (UnitHealth("player") and UnitHealthMax("player")) then
		local health = UnitHealth("player");
		local max = UnitHealthMax("player");
		local percent = (health/max) * 100;
		
		Nurfed_PlayerHealthPercent:SetText(ceil(percent).."%");
		
		if (Nurfed_RetrieveOption ~= nil) then
			if (Nurfed_RetrieveOption(211) ~= nil) then
				Nurfed_ColorPlayerHealth = Nurfed_RetrieveOption(211)[Nurfed_VALUE];
			end
			if (Nurfed_RetrieveOption(214) ~= nil) then
				Nurfed_ColorPlayerHealthBar = Nurfed_RetrieveOption(214)[Nurfed_VALUE];
			end
		end
		if (Nurfed_ColorPlayerHealth == 1) then
			if ((percent <= 100) and (percent > 75)) then
				Nurfed_PlayerHealthPercent:SetTextColor(0, 1, 0);
				Nurfed_PlayerHealthText:SetTextColor(0, 1, 0);
			elseif ((percent <= 75) and (percent > 50)) then
				Nurfed_PlayerHealthPercent:SetTextColor(1, 1, 0);
				Nurfed_PlayerHealthText:SetTextColor(1, 1, 0);
			elseif ((percent <= 50) and (percent > 25)) then
				Nurfed_PlayerHealthPercent:SetTextColor(1, 0.5, 0);
				Nurfed_PlayerHealthText:SetTextColor(1, 0.5, 0);
			else
				Nurfed_PlayerHealthPercent:SetTextColor(1, 0, 0);
				Nurfed_PlayerHealthText:SetTextColor(1, 0, 0);
			end
		else
			Nurfed_PlayerHealthPercent:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
			Nurfed_PlayerHealthText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		end
		if (Nurfed_ColorPlayerHealthBar == 1) then
			if ((percent <= 100) and (percent > 75)) then
				PlayerFrameHealthBar:SetStatusBarColor(0, 1, 0);
			elseif ((percent <= 75) and (percent > 50)) then
				PlayerFrameHealthBar:SetStatusBarColor(1, 1, 0);
			elseif ((percent <= 50) and (percent > 25)) then
				PlayerFrameHealthBar:SetStatusBarColor(1, 0.5, 0);
			else
				PlayerFrameHealthBar:SetStatusBarColor(1, 0, 0);
			end
		else
			PlayerFrameHealthBar:SetStatusBarColor(0, 1, 0);
		end
	end
end

function Nurfed_ShowPlayerMana()
	-- This gets the whole status text "Mana xxxx / yyyy" - we need to parse it to remove the "Mana " part
--[[	local text = PlayerFrameManaBarText:GetText();
	if( text == nil ) then
		Nurfed_PlayerManaText:SetText("Failure #1");
	else
		-- Determine mana type and set a globally accessible variable
		if (strfind(text, "Rage")) then
			Nurfed_PlayerManaType = "Rage";
		elseif (strfind(text, "Energy")) then
			Nurfed_PlayerManaType = "Energy";
		else
			Nurfed_PlayerManaType = "Mana";
		end
		-- Initialize local mana text variable
		local mana = nil;
		-- Remove the first 5 or 7 characters, depending on mana type
		if (Nurfed_PlayerManaType == "Energy") then
			mana = strsub(text, 7);
		else
			mana = strsub(text, 5);
		end
		-- Make sure mana contains text, then color our text accordingly
		if(mana == nil) then
			Nurfed_PlayerManaText:SetText("Failure #2");
		else
			Nurfed_PlayerManaText:SetText(mana);
			
			if (Nurfed_RetrieveOption ~= nil) then
				if (Nurfed_RetrieveOption(212) ~= nil) then
					Nurfed_ColorPlayerMana = Nurfed_RetrieveOption(212)[Nurfed_VALUE];
				end
			end
			if (Nurfed_ColorPlayerMana == 1) then
				if (Nurfed_PlayerManaType == "Rage") then
					Nurfed_PlayerManaText:SetTextColor(1, 0.50, 0.50);
				elseif (Nurfed_PlayerManaType == "Energy") then
					Nurfed_PlayerManaText:SetTextColor(1, 1, 0);
				else
					Nurfed_PlayerManaText:SetTextColor(0.75, 0.75, 1);
				end
			else
				Nurfed_PlayerManaText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
			end
		end
	end]]
	if (UnitMana("player") and UnitManaMax("player") and UnitPowerType("player")) then
		Nurfed_PlayerManaText:SetText(UnitMana("player").." / "..UnitManaMax("player"));
		local type = UnitPowerType("player");
		if (Nurfed_RetrieveOption ~= nil) then
			if (Nurfed_RetrieveOption(212) ~= nil) then
				Nurfed_ColorPlayerMana = Nurfed_RetrieveOption(212)[Nurfed_VALUE];
			end
		end
		if (Nurfed_ColorPlayerMana == 1) then
			if (type == 0) then
				Nurfed_PlayerManaText:SetTextColor(0.75, 0.75, 1);
			elseif (type == 1) then
				Nurfed_PlayerManaText:SetTextColor(1, 0.50, 0.50);
			elseif (type == 3) then
				Nurfed_PlayerManaText:SetTextColor(1, 1, 0);
			end
		else
			Nurfed_PlayerManaText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		end
	end		
end

function Nurfed_ShowPlayerExp()
	local currXP = UnitXP("player");
	local nextXP = UnitXPMax("player");
	local restXP = GetXPExhaustion();

	if(restXP == nil) then
		local str = format("%s / %s", currXP, nextXP);
		Nurfed_ExpAmount:SetText(str);
	else
		-- Divide the rested # in half because
		-- (a) that's the exp you really end up getting
		-- (b) it isn't such an absurdly huge number taking up a lot of space on the UI.

		local str = format("%s / %s (+%s)", currXP, nextXP, (tonumber(restXP) / 2));
		Nurfed_ExpAmount:SetText(str);
	end
end

-- ** SLASH HANDLER FUNCTIONS ** --

function Nurfed_ColorPlayerHealthSlashHandler (msg)
	msg = string.lower(msg);
	if (msg == "yes" or msg == "1" or msg == "true") then
		Nurfed_ColorPlayerHealth = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Setting player health display text to color according to health percentage.", 1, 1, 1);
	elseif (msg == "no" or msg == "0" or msg == "false") then
		Nurfed_ColorPlayerHealth = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Setting player health display text color to default.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Nurfed_ColorPlayerHealth = Nurfed_DefaultColorPlayerHealth;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting player health color state to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbarcolorplayerhealth /ubcolorplayerhealth", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Color player health.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Do not color player health.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Nurfed_ColorPlayerHealth == 1) then 
			Nurfed_ColorPlayerHealth = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Setting player health display text color to default.", 1, 1, 1);
		else 
			Nurfed_ColorPlayerHealth = 1; 
			DEFAULT_CHAT_FRAME:AddMessage("Setting player health display text to color according to health percentage.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbarcolorplayerhealth /ubcolorplayerhealth", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Color player health.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Do not color player health.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end
end

function Nurfed_ColorPlayerManaSlashHanlder (msg)
	msg = string.lower(msg);
	if (msg == "yes" or msg == "1" or msg == "true") then
		Nurfed_ColorPlayerMana = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Setting player mana display text to color according to mana type.", 1, 1, 1);
	elseif (msg == "no" or msg == "0" or msg == "false") then
		Nurfed_ColorPlayerMana = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Setting player mana display text color to default.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Nurfed_ColorPlayerMana = Nurfed_DefaultColorPlayerMana;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting player mana text display state to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbarcolorplayermana /ubcolorplayermana", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Color player mana.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Do not color player mana.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Nurfed_ColorPlayerMana == 1) then 
			Nurfed_ColorPlayerMana = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Setting player mana display text color to default.", 1, 1, 1);
		else 
			Nurfed_ColorPlayerMana = 1; 
			DEFAULT_CHAT_FRAME:AddMessage("Setting player mana display text to color according to mana type.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbarcolorplayermana /ubcolorplayermana", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Color player mana.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Do not color player mana.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end
end

function Nurfed_ColorPlayerNameSlashHanlder (msg)
	msg = string.lower(msg);
	if (msg == "yes" or msg == "1" or msg == "true") then
		Nurfed_ColorPlayerName = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Setting player name text to color red when attack is on.", 1, 1, 1);
	elseif (msg == "no" or msg == "0" or msg == "false") then
		Nurfed_ColorPlayerName = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Setting player name text to stay default.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Nurfed_ColorPlayerName = Nurfed_DefaultColorPlayerName;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting player name text display state to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbarcolorplayername /ubcolorplayername", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Color player name on attack.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Do not color player name on attack.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Nurfed_ColorPlayerName == 1) then 
			Nurfed_ColorPlayerName = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Setting player name text to stay default.", 1, 1, 1);
		else 
			Nurfed_ColorPlayerName = 1; 
			DEFAULT_CHAT_FRAME:AddMessage("Setting player name text to color red when attack is on.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbarcolorplayername /ubcolorplayername", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Color player name on attack.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Do not color player name on attack.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end
end

function Nurfed_ColorPlayerHealthBarSlashHanlder (msg)
	msg = string.lower(msg);
	if (msg == "yes" or msg == "1" or msg == "true") then
		Nurfed_ColorPlayerHealthBar = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Coloring player health bar progressively.", 1, 1, 1);
	elseif (msg == "no" or msg == "0" or msg == "false") then
		Nurfed_ColorPlayerHealthBar = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Coloring player health bar normally.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Nurfed_ColorPlayerHealthBar = Nurfed_DefaultColorPlayerHealthBar;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting player health bar option state to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbarcolorplayerhealthbar /ubcolorplayerhealthbar", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Color player health bar progressively.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Do not color player health bar progressively.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Nurfed_ColorPlayerHealthBar == 1) then 
			Nurfed_ColorPlayerHealthBar = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Coloring player health bar normally.", 1, 1, 1);
		else 
			Nurfed_ColorPlayerHealthBar = 1; 
			DEFAULT_CHAT_FRAME:AddMessage("Coloring player health bar progressively.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbarcolorplayerhealthbar /ubcolorplayerhealthbar", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Color player health bar progressively.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Do not color player health bar progressively.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end
end