---------------
-- Variables --
---------------
Perl_Player_Config = {};

-- Default Saved Variables (also set in Perl_Player_GetVars)
local locked = 0;		-- unlocked by default
local xpbarstate = 1;		-- show default xp bar by default
local compactmode = 0;		-- compact mode is disabled by default
local showraidgroup = 1;	-- show the raid group number by default when in raids
local scale = 1;		-- default scale
local healermode = 0;		-- nurfed unit frame style
local transparency = 1;		-- transparency for frames
local showportrait = 0;		-- portrait is hidden by default
local compactpercent = 0;	-- percents are not shown in compact mode by default
local threedportrait = 0;	-- 3d portraits are off by default
local portraitcombattext = 1;	-- Combat text is enabled by default on the portrait frame
local showdruidbar = 1;		-- Druid Bar support is enabled by default

-- Default Local Variables
local InCombat = 0;		-- used to track if the player is in combat and if the icon should be displayed
local Initialized = nil;	-- waiting to be initialized
local mouseoverhealthflag = 0;	-- is the mouse over the health bar for healer mode?
local mouseovermanaflag = 0;	-- is the mouse over the mana bar for healer mode?

-- Variables for position of the class icon texture.
local Perl_Player_ClassPosRight = {};
local Perl_Player_ClassPosLeft = {};
local Perl_Player_ClassPosTop = {};
local Perl_Player_ClassPosBottom = {};


----------------------
-- Loading Function --
----------------------
function Perl_Player_OnLoad()
	-- Combat Text
	CombatFeedback_Initialize(Perl_Player_HitIndicator, 30);

	-- Events
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("PARTY_LEADER_CHANGED");
	this:RegisterEvent("PARTY_LOOT_METHOD_CHANGED");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_UPDATE_RESTING");
	this:RegisterEvent("PLAYER_XP_UPDATE");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("UNIT_COMBAT");
	this:RegisterEvent("UNIT_DISPLAYPOWER");
	this:RegisterEvent("UNIT_ENERGY");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_LEVEL");
	this:RegisterEvent("UNIT_MANA");
	this:RegisterEvent("UNIT_MAXENERGY");
	this:RegisterEvent("UNIT_MAXHEALTH");
	this:RegisterEvent("UNIT_MAXMANA");
	this:RegisterEvent("UNIT_MAXRAGE");
	this:RegisterEvent("UNIT_MODEL_CHANGED");
	this:RegisterEvent("UNIT_PORTRAIT_UPDATE");
	this:RegisterEvent("UNIT_PVP_UPDATE");
	this:RegisterEvent("UNIT_RAGE");
	this:RegisterEvent("UNIT_SPELLMISS");
	this:RegisterEvent("UPDATE_FACTION");
	this:RegisterEvent("VARIABLES_LOADED");

	-- Button Click Overlays (in order of occurrence in XML)
	Perl_Player_Name_CastClickOverlay:SetFrameLevel(Perl_Player_Name:GetFrameLevel() + 2);
	Perl_Player_RaidGroupNumberFrame_CastClickOverlay:SetFrameLevel(Perl_Player_RaidGroupNumberFrame:GetFrameLevel() + 1);
	Perl_Player_LevelFrame_CastClickOverlay:SetFrameLevel(Perl_Player_LevelFrame:GetFrameLevel() + 1);
	Perl_Player_PortraitFrame_CastClickOverlay:SetFrameLevel(Perl_Player_PortraitFrame:GetFrameLevel() + 2);
	Perl_Player_StatsFrame_CastClickOverlay:SetFrameLevel(Perl_Player_StatsFrame:GetFrameLevel() + 1);
	Perl_Player_HealthBar_CastClickOverlay:SetFrameLevel(Perl_Player_StatsFrame:GetFrameLevel() + 2);
	Perl_Player_ManaBar_CastClickOverlay:SetFrameLevel(Perl_Player_StatsFrame:GetFrameLevel() + 2);
	Perl_Player_DruidBar_CastClickOverlay:SetFrameLevel(Perl_Player_StatsFrame:GetFrameLevel() + 2);
	Perl_Player_XPBar_CastClickOverlay:SetFrameLevel(Perl_Player_StatsFrame:GetFrameLevel() + 2);

	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Perl Classic: Player loaded successfully.");
	end
end


-------------------
-- Event Handler --
-------------------
function Perl_Player_OnEvent(event)
	if (event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH") then
		if (arg1 == "player") then
			Perl_Player_Update_Health();		-- Update health values
		end
		return;
	elseif ((event == "UNIT_ENERGY") or (event == "UNIT_MANA") or (event == "UNIT_RAGE") or (event == "UNIT_MAXMANA") or (event == "UNIT_MAXENERGY") or (event == "UNIT_MAXRAGE")) then
		if (arg1 == "player") then
			Perl_Player_Update_Mana();		-- Update energy/mana/rage values
		end
		return;
	elseif (event == "UNIT_DISPLAYPOWER") then
		if (arg1 == "player") then
			Perl_Player_Update_Mana_Bar();		-- What type of energy are we using now?
			Perl_Player_Update_Mana();		-- Update the energy info immediately
		end
		return;
	elseif (event == "UNIT_COMBAT") then
		if (arg1 == "player") then
			CombatFeedback_OnCombatEvent(arg2, arg3, arg4, arg5);
		end
		return;
	elseif (event == "UNIT_SPELLMISS") then
		if (arg1 == "player") then
			CombatFeedback_OnSpellMissEvent(arg2);
		end
		return;
	elseif ((event == "PLAYER_REGEN_DISABLED") or (event == "PLAYER_REGEN_ENABLED") or (event == "PLAYER_UPDATE_RESTING")) then
		Perl_Player_Update_Combat_Status(event);	-- Are we fighting, resting, or none?
		return;
	elseif (event == "PLAYER_XP_UPDATE") then
		if (xpbarstate == 1) then
			Perl_Player_Update_Experience();	-- Set the experience bar info
		end
		return;
	elseif (event == "UPDATE_FACTION") then
		if (xpbarstate == 4) then
			Perl_Player_Update_Reputation();	-- Set faction info
		end
		return;
	elseif (event == "UNIT_PVP_UPDATE") then
		Perl_Player_Update_PvP_Status();		-- Is the character PvP flagged?
		return;
	elseif (event == "UNIT_LEVEL") then
		if (arg1 == "player") then
			Perl_Player_LevelFrame_LevelBarText:SetText(UnitLevel("player"));	-- Set the player's level
		end
		return;
	elseif (event == "RAID_ROSTER_UPDATE") then
		Perl_Player_Update_Raid_Group_Number();		-- What raid group number are we in?
		return;
	elseif (event == "PARTY_LEADER_CHANGED" or event == "PARTY_MEMBERS_CHANGED") then
		Perl_Player_Update_Leader();			-- Are we the party leader?
		return;
	elseif (event == "PARTY_LOOT_METHOD_CHANGED") then
		Perl_Player_Update_Loot_Method();
		return;
	elseif (event == "UNIT_PORTRAIT_UPDATE" or event == "UNIT_MODEL_CHANGED") then
		if (arg1 == "player") then
			Perl_Player_Update_Portrait();
		end
		return;
	elseif (event == "VARIABLES_LOADED") or (event=="PLAYER_ENTERING_WORLD") then
		Perl_Player_Initialize();
		InCombat = 0;					-- You can't be fighting if you're zoning, and no event is sent, force it to no combat.
		Perl_Player_Update_Once();
		return;
	elseif (event == "ADDON_LOADED") then
		if (arg1 == "Perl_Player") then
			Perl_Player_myAddOns_Support();
		end
		return;
	else
		return;
	end
end


-------------------------------
-- Loading Settings Function --
-------------------------------
function Perl_Player_Initialize()
	-- Check if we loaded the mod already.
	if (Initialized) then
		Perl_Player_Set_Scale();
		return;
	end

	-- Check if a previous exists, if not, enable by default.
	if (type(Perl_Player_Config[UnitName("player")]) == "table") then
		Perl_Player_GetVars();
	else
		Perl_Player_UpdateVars();
	end

	-- Major config options.
	Perl_Player_Initialize_Frame_Color();
	Perl_Player_Set_Localized_ClassIcons();

	-- Unregister the Blizzard frames via the 1.8 function
	PlayerFrame:UnregisterAllEvents();
	PlayerFrameHealthBar:UnregisterAllEvents();
	PlayerFrameManaBar:UnregisterAllEvents();

	Perl_Player_Frame:Show();

	Initialized = 1;
end

function Perl_Player_Initialize_Frame_Color()
	Perl_Player_StatsFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Player_StatsFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Player_LevelFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Player_LevelFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Player_NameFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Player_NameFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Player_RaidGroupNumberFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Player_RaidGroupNumberFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Player_PortraitFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Player_PortraitFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);

	Perl_Player_HealthBarText:SetTextColor(1, 1, 1, 1);
	Perl_Player_ManaBarText:SetTextColor(1, 1, 1, 1);
	Perl_Player_RaidGroupNumberBarText:SetTextColor(1, 1, 1);
end


----------------------
-- Update Functions --
----------------------
function Perl_Player_Update_Once()
	local PlayerClass = UnitClass("player");

	PlayerFrame:Hide();					-- Hide default frame
	Perl_Player_Set_Scale();				-- Set the scale
	Perl_Player_Set_Transparency();				-- Set the transparency
	Perl_Player_NameBarText:SetText(UnitName("player"));	-- Set the player's name
	Perl_Player_Update_Portrait();				-- Set the player's portrait
	Perl_Player_Update_PvP_Status();			-- Is the character PvP flagged?
	Perl_Player_ClassTexture:SetTexCoord(Perl_Player_ClassPosRight[PlayerClass], Perl_Player_ClassPosLeft[PlayerClass], Perl_Player_ClassPosTop[PlayerClass], Perl_Player_ClassPosBottom[PlayerClass]);	-- Set the player's class icon
	Perl_Player_Set_Text_Positions();			-- Align the text according to compact and healer mode
	Perl_Player_Update_Health();				-- Set the player's health on load or toggle
	Perl_Player_Update_Mana();				-- Set the player's mana/energy on load or toggle
	Perl_Player_Update_Mana_Bar();				-- Set the type of mana used
	Perl_Player_LevelFrame_LevelBarText:SetText(UnitLevel("player"));	-- Set the player's level
	Perl_Player_XPBar_Display(xpbarstate);			-- Set the xp bar mode and update the experience if needed
	Perl_Player_Update_Raid_Group_Number();			-- Are we in a raid at login?
	Perl_Player_Update_Leader();				-- Are we the party leader?
	Perl_Player_Update_Loot_Method();			-- Are we the master looter?
	Perl_Player_Update_Combat_Status();			-- Are we already fighting or resting?
	Perl_Player_Set_CompactMode();				-- Are we using compact mode?
end

function Perl_Player_Update_Health()
	local playerhealth = UnitHealth("player");
	local playerhealthmax = UnitHealthMax("player");
	local playerhealthpercent = floor(playerhealth/playerhealthmax*100+0.5);

	if (UnitIsDead("player") or UnitIsGhost("player")) then				-- This prevents negative health
		playerhealth = 0;
		playerhealthpercent = 0;
	end

	Perl_Player_HealthBar:SetMinMaxValues(0, playerhealthmax);
	Perl_Player_HealthBar:SetValue(playerhealth);

	if (PCUF_COLORHEALTH == 1) then
		if ((playerhealthpercent <= 100) and (playerhealthpercent > 75)) then
			Perl_Player_HealthBar:SetStatusBarColor(0, 0.8, 0);
			Perl_Player_HealthBarBG:SetStatusBarColor(0, 0.8, 0, 0.25);
		elseif ((playerhealthpercent <= 75) and (playerhealthpercent > 50)) then
			Perl_Player_HealthBar:SetStatusBarColor(1, 1, 0);
			Perl_Player_HealthBarBG:SetStatusBarColor(1, 1, 0, 0.25);
		elseif ((playerhealthpercent <= 50) and (playerhealthpercent > 25)) then
			Perl_Player_HealthBar:SetStatusBarColor(1, 0.5, 0);
			Perl_Player_HealthBarBG:SetStatusBarColor(1, 0.5, 0, 0.25);
		else
			Perl_Player_HealthBar:SetStatusBarColor(1, 0, 0);
			Perl_Player_HealthBarBG:SetStatusBarColor(1, 0, 0, 0.25);
		end
	else
		Perl_Player_HealthBar:SetStatusBarColor(0, 0.8, 0);
		Perl_Player_HealthBarBG:SetStatusBarColor(0, 0.8, 0, 0.25);
	end

	if (compactmode == 0) then
		if (healermode == 1) then		-- compact mode off and healer mode on
			Perl_Player_HealthBarText:SetText("-"..playerhealthmax - playerhealth);
			if (mouseoverhealthflag == 0) then
				Perl_Player_HealthBarTextPercent:SetText();
			else
				Perl_Player_HealthBarTextPercent:SetText(playerhealth.."/"..playerhealthmax);
			end
		else					-- compact mode off and healer mode off
			Perl_Player_HealthBarText:SetText(playerhealth.."/"..playerhealthmax);
			Perl_Player_HealthBarTextPercent:SetText(playerhealthpercent .. "%");
		end
		Perl_Player_HealthBarTextCompactPercent:SetText();							-- Hide the compact mode percent text in full mode
	else
		if (healermode == 1) then		-- compact mode on and healer mode on
			Perl_Player_HealthBarText:SetText("-"..playerhealthmax - playerhealth);
			if (mouseoverhealthflag == 0) then
				Perl_Player_HealthBarTextPercent:SetText();
			else
				Perl_Player_HealthBarTextPercent:SetText(playerhealth.."/"..playerhealthmax);
			end
		else					-- compact mode on and healer mode off
			Perl_Player_HealthBarText:SetText();
			Perl_Player_HealthBarTextPercent:SetText(playerhealth.."/"..playerhealthmax);
		end

		if (compactpercent == 1) then
			Perl_Player_HealthBarTextCompactPercent:SetText(playerhealthpercent.."%");
		else
			Perl_Player_HealthBarTextCompactPercent:SetText();
		end
	end
end

function Perl_Player_Update_Mana()
	local playermana = UnitMana("player");
	local playermanamax = UnitManaMax("player");
	local playermanapercent = floor(playermana/playermanamax*100+0.5);

	if (UnitIsDead("player") or UnitIsGhost("player")) then				-- This prevents negative mana
		playermana = 0;
		playermanapercent = 0;
	end

	Perl_Player_ManaBar:SetMinMaxValues(0, playermanamax);
	Perl_Player_ManaBar:SetValue(playermana);

	if (compactmode == 0) then
		if (healermode == 1) then
			if (mouseovermanaflag == 0) then
				Perl_Player_ManaBarText:SetText();
				Perl_Player_ManaBarTextPercent:SetText();
			else
				if (UnitPowerType("player") == 1) then
					Perl_Player_ManaBarTextPercent:SetText(playermana);
				else
					Perl_Player_ManaBarTextPercent:SetText(playermana.."/"..playermanamax);
				end
			end
		else
			Perl_Player_ManaBarText:SetText(playermana.."/"..playermanamax);
			if (UnitPowerType("player") == 1) then
				Perl_Player_ManaBarTextPercent:SetText(playermana);
			else
				Perl_Player_ManaBarTextPercent:SetText(playermanapercent.."%");
			end
		end
		Perl_Player_ManaBarTextCompactPercent:SetText();							-- Hide the compact mode percent text in full mode
	else
		if (healermode == 1) then
			if (mouseovermanaflag == 0) then
				Perl_Player_ManaBarText:SetText();
				Perl_Player_ManaBarTextPercent:SetText();
			else
				if (UnitPowerType("player") == 1) then
					Perl_Player_ManaBarTextPercent:SetText(playermana);
				else
					Perl_Player_ManaBarTextPercent:SetText(playermana.."/"..playermanamax);
				end
			end
		else
			Perl_Player_ManaBarText:SetText();
			if (UnitPowerType("player") == 1) then
				Perl_Player_ManaBarTextPercent:SetText(playermana);
			else
				Perl_Player_ManaBarTextPercent:SetText(playermana.."/"..playermanamax);
			end
		end

		if (compactpercent == 1) then
			Perl_Player_ManaBarTextCompactPercent:SetText(playermanapercent.."%");
		else
			Perl_Player_ManaBarTextCompactPercent:SetText();
		end
	end

	if (showdruidbar == 1) then
		if (DruidBarKey and (UnitClass("player") == PERL_LOCALIZED_DRUID)) then
			if (UnitPowerType("player") > 0) then
				-- Show the bars and set the text and reposition the original mana bar below the druid bar
				local playerdruidbarmana = floor(DruidBarKey.keepthemana);
				local playerdruidbarmanamax = DruidBarKey.maxmana;
				local playerdruidbarmanapercent = floor(playerdruidbarmana/playerdruidbarmanamax*100+0.5);

				if (playerdruidbarmanapercent == 100) then		-- This is to ensure the value isn't 1 or 2 mana under max when 100%
					playerdruidbarmana = playerdruidbarmanamax;
				end

				Perl_Player_DruidBar:SetMinMaxValues(0, playerdruidbarmanamax);
				Perl_Player_DruidBar:SetValue(playerdruidbarmana);

				-- Show the bar and adjust the stats frame
				Perl_Player_DruidBar:Show();
				Perl_Player_DruidBarBG:Show();
				Perl_Player_DruidBar_CastClickOverlay:Show();
				Perl_Player_ManaBar:SetPoint("TOP", "Perl_Player_DruidBar", "BOTTOM", 0, -2);
				if (xpbarstate == 3) then
					Perl_Player_StatsFrame:SetHeight(54);		-- Experience Bar is hidden
					Perl_Player_StatsFrame_CastClickOverlay:SetHeight(54);
				else
					Perl_Player_StatsFrame:SetHeight(66);		-- Experience Bar is shown
					Perl_Player_StatsFrame_CastClickOverlay:SetHeight(66);
				end

				-- Display the needed text
				if (compactmode == 0) then
					if (healermode == 1) then
						if (mouseovermanaflag == 0) then
							Perl_Player_DruidBarText:SetText();
							Perl_Player_DruidBarTextPercent:SetText();
						else
							Perl_Player_DruidBarTextPercent:SetText(playerdruidbarmana.."/"..playerdruidbarmanamax);
						end
					else
						Perl_Player_DruidBarText:SetText(playerdruidbarmana.."/"..playerdruidbarmanamax);
						Perl_Player_DruidBarTextPercent:SetText(playerdruidbarmanapercent.."%");
					end
					Perl_Player_DruidBarTextCompactPercent:SetText();							-- Hide the compact mode percent text in full mode
				else
					if (healermode == 1) then
						if (mouseovermanaflag == 0) then
							Perl_Player_DruidBarText:SetText();
							Perl_Player_DruidBarTextPercent:SetText();
						else
							Perl_Player_DruidBarTextPercent:SetText(playerdruidbarmana.."/"..playerdruidbarmanamax);
						end
					else
						Perl_Player_DruidBarText:SetText();
						Perl_Player_DruidBarTextPercent:SetText(playerdruidbarmana.."/"..playerdruidbarmanamax);
					end

					if (compactpercent == 1) then
						Perl_Player_DruidBarTextCompactPercent:SetText(playerdruidbarmanapercent.."%");
					else
						Perl_Player_DruidBarTextCompactPercent:SetText();
					end
				end
			else
				-- Hide it all (bars and text)
				Perl_Player_DruidBarText:SetText();
				Perl_Player_DruidBarTextPercent:SetText();
				Perl_Player_DruidBarTextCompactPercent:SetText();
				Perl_Player_DruidBar:Hide();
				Perl_Player_DruidBarBG:Hide();
				Perl_Player_DruidBar_CastClickOverlay:Hide();
				Perl_Player_ManaBar:SetPoint("TOP", "Perl_Player_HealthBar", "BOTTOM", 0, -2);
				if (xpbarstate == 3) then
					Perl_Player_StatsFrame:SetHeight(42);			-- Experience Bar is hidden
					Perl_Player_StatsFrame_CastClickOverlay:SetHeight(42);
				else
					Perl_Player_StatsFrame:SetHeight(54);			-- Experience Bar is shown
					Perl_Player_StatsFrame_CastClickOverlay:SetHeight(54);
				end
			end
		else
			-- Hide it all (bars and text)
			Perl_Player_DruidBarText:SetText();
			Perl_Player_DruidBarTextPercent:SetText();
			Perl_Player_DruidBarTextCompactPercent:SetText();
			Perl_Player_DruidBar:Hide();
			Perl_Player_DruidBarBG:Hide();
			Perl_Player_DruidBar_CastClickOverlay:Hide();
			Perl_Player_ManaBar:SetPoint("TOP", "Perl_Player_HealthBar", "BOTTOM", 0, -2);
			if (xpbarstate == 3) then
				Perl_Player_StatsFrame:SetHeight(42);			-- Experience Bar is hidden
				Perl_Player_StatsFrame_CastClickOverlay:SetHeight(42);
			else
				Perl_Player_StatsFrame:SetHeight(54);			-- Experience Bar is shown
				Perl_Player_StatsFrame_CastClickOverlay:SetHeight(54);
			end
		end
	else
		-- Hide it all (bars and text)
		Perl_Player_DruidBarText:SetText();
		Perl_Player_DruidBarTextPercent:SetText();
		Perl_Player_DruidBarTextCompactPercent:SetText();
		Perl_Player_DruidBar:Hide();
		Perl_Player_DruidBarBG:Hide();
		Perl_Player_DruidBar_CastClickOverlay:Hide();
		Perl_Player_ManaBar:SetPoint("TOP", "Perl_Player_HealthBar", "BOTTOM", 0, -2);
		if (xpbarstate == 3) then
			Perl_Player_StatsFrame:SetHeight(42);			-- Experience Bar is hidden
			Perl_Player_StatsFrame_CastClickOverlay:SetHeight(42);
		else
			Perl_Player_StatsFrame:SetHeight(54);			-- Experience Bar is shown
			Perl_Player_StatsFrame_CastClickOverlay:SetHeight(54);
		end
	end
end

function Perl_Player_Update_Mana_Bar()
	local playerpower = UnitPowerType("player");

	-- Set mana bar color
	if (playerpower == 0) then
		Perl_Player_ManaBar:SetStatusBarColor(0, 0, 1, 1);
		Perl_Player_ManaBarBG:SetStatusBarColor(0, 0, 1, 0.25);
	elseif (playerpower == 1) then
		Perl_Player_ManaBar:SetStatusBarColor(1, 0, 0, 1);
		Perl_Player_ManaBarBG:SetStatusBarColor(1, 0, 0, 0.25);
	elseif (playerpower == 3) then
		Perl_Player_ManaBar:SetStatusBarColor(1, 1, 0, 1);
		Perl_Player_ManaBarBG:SetStatusBarColor(1, 1, 0, 0.25);
	end
end

function Perl_Player_Update_Experience()
	if (UnitLevel("player") ~= 70) then
		-- XP Bar stuff
		local playerxp = UnitXP("player");
		local playerxpmax = UnitXPMax("player");
		local playerxprest = GetXPExhaustion();

		Perl_Player_XPBar:SetMinMaxValues(0, playerxpmax);
		Perl_Player_XPRestBar:SetMinMaxValues(0, playerxpmax);
		Perl_Player_XPBar:SetValue(playerxp);

		-- Set xp text
		local xptext = playerxp.."/"..playerxpmax;
		local xptextpercent = floor(playerxp/playerxpmax*100+0.5);

		if (playerxprest) then
			xptext = xptext .."(+"..(playerxprest)..")";
			Perl_Player_XPBar:SetStatusBarColor(0, 0.6, 0.6, 1);
			Perl_Player_XPRestBar:SetStatusBarColor(0, 0.6, 0.6, 0.5);
			Perl_Player_XPBarBG:SetStatusBarColor(0, 0.6, 0.6, 0.25);
			Perl_Player_XPRestBar:SetValue(playerxp + playerxprest);
		else
			Perl_Player_XPBar:SetStatusBarColor(0, 0.6, 0.6, 1);
			Perl_Player_XPRestBar:SetStatusBarColor(0, 0.6, 0.6, 0.5);
			Perl_Player_XPBarBG:SetStatusBarColor(0, 0.6, 0.6, 0.25);
			Perl_Player_XPRestBar:SetValue(playerxp);
		end

		Perl_Player_XPBarText:SetText(xptextpercent.."%");
	else
		Perl_Player_XPBar:SetMinMaxValues(0, 1);
		Perl_Player_XPRestBar:SetMinMaxValues(0, 1);
		Perl_Player_XPBar:SetValue(1);
		Perl_Player_XPRestBar:SetValue(1);

		Perl_Player_XPBar:SetStatusBarColor(0, 0.6, 0.6, 1);
		Perl_Player_XPRestBar:SetStatusBarColor(0, 0.6, 0.6, 0.5);
		Perl_Player_XPBarBG:SetStatusBarColor(0, 0.6, 0.6, 0.25);

		Perl_Player_XPBarText:SetText("Level 70");
	end
	
end

function Perl_Player_Update_Reputation()
	local name, reaction, min, max, value = GetWatchedFactionInfo();
	if (name) then
		value = value - min;
		max = max - min;
		min = 0;
		
		Perl_Player_XPBar:SetMinMaxValues(min, max);
		Perl_Player_XPRestBar:SetMinMaxValues(min, max);
		Perl_Player_XPBar:SetValue(value);
		Perl_Player_XPRestBar:SetValue(value);

		local color = FACTION_BAR_COLORS[reaction];
		Perl_Player_XPBar:SetStatusBarColor(color.r, color.g, color.b, 1);
		Perl_Player_XPRestBar:SetStatusBarColor(color.r, color.g, color.b, 0.5);
		Perl_Player_XPBarBG:SetStatusBarColor(color.r, color.g, color.b, 0.25);

		Perl_Player_XPBarText:SetText(name);
	else
		Perl_Player_XPBar:SetMinMaxValues(0, 1);
		Perl_Player_XPRestBar:SetMinMaxValues(0, 1);
		Perl_Player_XPBar:SetValue(1);
		Perl_Player_XPRestBar:SetValue(1);

		Perl_Player_XPBar:SetStatusBarColor(0.9, 0.7, 0, 1);
		Perl_Player_XPRestBar:SetStatusBarColor(0.9, 0.7, 0, 0.5);
		Perl_Player_XPBarBG:SetStatusBarColor(0.9, 0.7, 0, 0.25);

		Perl_Player_XPBarText:SetText("Select a Reputation");
	end
end

function Perl_Player_Update_Combat_Status(event)
	-- Rest/Combat Status Icon
	if (event == "PLAYER_REGEN_DISABLED") then
		InCombat = 1;
		Perl_Player_ActivityStatus:SetTexCoord(0.5, 1.0, 0.0, 0.5);
		Perl_Player_ActivityStatus:Show();
	elseif (event == "PLAYER_REGEN_ENABLED") then
		InCombat = 0;
		Perl_Player_ActivityStatus:Hide();
	elseif (IsResting()) then
		if (InCombat == 1) then
			return;
		else
			Perl_Player_ActivityStatus:SetTexCoord(0, 0.5, 0.0, 0.5);
			Perl_Player_ActivityStatus:Show();
		end
	else
		if (InCombat == 1) then
			return;
		else
			Perl_Player_ActivityStatus:Hide();
		end
	end
end

function Perl_Player_Update_Raid_Group_Number()		-- taken from 1.8
	if (showraidgroup == 1) then
		Perl_Player_RaidGroupNumberFrame:Hide();
		local name, rank, subgroup;
		if (GetNumRaidMembers() == 0) then
			Perl_Player_RaidGroupNumberFrame:Hide();
			Perl_Player_MasterIcon:Hide();				-- This was added to correctly hide the master loot icon after leaving a party/raid
			return;
		end
		local numRaidMembers = GetNumRaidMembers();
		for i=1, MAX_RAID_MEMBERS do
			if (i <= numRaidMembers) then
				name, rank, subgroup = GetRaidRosterInfo(i);
				-- Set the player's group number indicator
				if (name == UnitName("player")) then
					Perl_Player_RaidGroupNumberBarText:SetText("Group "..subgroup);
					Perl_Player_RaidGroupNumberFrame:Show();
					return;
				end
			end
		end
	else
		Perl_Player_RaidGroupNumberFrame:Hide();
	end
end

function Perl_Player_Update_Leader()
	if (IsPartyLeader()) then
		Perl_Player_LeaderIcon:Show();
	else
		Perl_Player_LeaderIcon:Hide();
	end
end

function Perl_Player_Update_Loot_Method()
	local lootMethod, lootMaster;
	lootMethod, lootMaster = GetLootMethod();
	if (lootMaster == 0) then
		Perl_Player_MasterIcon:Show();
	else
		Perl_Player_MasterIcon:Hide();
	end
end

function Perl_Player_Update_PvP_Status()
	if (UnitIsPVP("player")) then
		local factionGroup = UnitFactionGroup("player");
		Perl_Player_NameBarText:SetTextColor(0,1,0);
		Perl_Player_PVPStatus:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..factionGroup);
		Perl_Player_PVPStatus:Show();
	else
		Perl_Player_NameBarText:SetTextColor(0.5,0.5,1);
		Perl_Player_PVPStatus:Hide();
	end
end

function Perl_Player_Set_CompactMode()
	if (compactmode == 0) then
		Perl_Player_Update_Health();
		Perl_Player_Update_Mana();
		Perl_Player_XPBar:SetWidth(220);
		Perl_Player_XPRestBar:SetWidth(220);
		Perl_Player_XPBarBG:SetWidth(220);
		Perl_Player_XPBar_CastClickOverlay:SetWidth(220);
		Perl_Player_StatsFrame:SetWidth(240);
		Perl_Player_StatsFrame_CastClickOverlay:SetWidth(240);
	else
		if (compactpercent == 0) then
			Perl_Player_Update_Health();
			Perl_Player_Update_Mana();
			Perl_Player_XPBar:SetWidth(150);
			Perl_Player_XPRestBar:SetWidth(150);
			Perl_Player_XPBarBG:SetWidth(150);
			Perl_Player_XPBar_CastClickOverlay:SetWidth(150);
			Perl_Player_StatsFrame:SetWidth(170);
			Perl_Player_StatsFrame_CastClickOverlay:SetWidth(170);
		else
			Perl_Player_Update_Health();
			Perl_Player_Update_Mana();
			Perl_Player_XPBar:SetWidth(185);
			Perl_Player_XPRestBar:SetWidth(185);
			Perl_Player_XPBarBG:SetWidth(185);
			Perl_Player_XPBar_CastClickOverlay:SetWidth(185);
			Perl_Player_StatsFrame:SetWidth(205);
			Perl_Player_StatsFrame_CastClickOverlay:SetWidth(205);
		end
		
	end
end

function Perl_Player_Set_Text_Positions()
	if (compactmode == 0) then
		Perl_Player_HealthBarText:SetPoint("RIGHT", 70, 0);
		Perl_Player_HealthBarTextPercent:SetPoint("TOP", 0, 1);
		Perl_Player_ManaBarText:SetPoint("RIGHT", 70, 0);
		Perl_Player_ManaBarTextPercent:SetPoint("TOP", 0, 1);
		Perl_Player_DruidBarText:SetPoint("RIGHT", 70, 0);
		Perl_Player_DruidBarTextPercent:SetPoint("TOP", 0, 1);
	else
		if (healermode == 1) then
			Perl_Player_HealthBarText:SetPoint("RIGHT", -10, 0);
			Perl_Player_HealthBarTextPercent:SetPoint("TOP", -40, 1);
			Perl_Player_ManaBarText:SetPoint("RIGHT", -10, 0);
			Perl_Player_ManaBarTextPercent:SetPoint("TOP", -40, 1);
			Perl_Player_DruidBarText:SetPoint("RIGHT", -10, 0);
			Perl_Player_DruidBarTextPercent:SetPoint("TOP", -40, 1);
		else
			Perl_Player_HealthBarText:SetPoint("RIGHT", 70, 0);
			Perl_Player_HealthBarTextPercent:SetPoint("TOP", 0, 1);
			Perl_Player_ManaBarText:SetPoint("RIGHT", 70, 0);
			Perl_Player_ManaBarTextPercent:SetPoint("TOP", 0, 1);
			Perl_Player_DruidBarText:SetPoint("RIGHT", 70, 0);
			Perl_Player_DruidBarTextPercent:SetPoint("TOP", 0, 1);
		end
	end
end

function Perl_Player_HealthShow()
	if (healermode == 1) then
		local playerhealth = UnitHealth("player");
		local playerhealthmax = UnitHealthMax("player");

		if (UnitIsDead("player") or UnitIsGhost("player")) then				-- This prevents negative health
			playerhealth = 0;
		end

		Perl_Player_HealthBarTextPercent:SetText(playerhealth.."/"..playerhealthmax);
		mouseoverhealthflag = 1;
	end
end

function Perl_Player_HealthHide()
	if (healermode == 1) then
		Perl_Player_HealthBarTextPercent:SetText();
		mouseoverhealthflag = 0;
	end
end

function Perl_Player_ManaShow()
	if (healermode == 1) then
		local playermana = UnitMana("player");
		local playermanamax = UnitManaMax("player");

		if (UnitIsDead("player") or UnitIsGhost("player")) then				-- This prevents negative mana
			playermana = 0;
		end

		if (UnitPowerType("player") == 1) then
			Perl_Player_ManaBarTextPercent:SetText(playermana);
		else
			Perl_Player_ManaBarTextPercent:SetText(playermana.."/"..playermanamax);
		end
		mouseovermanaflag = 1;
	end
end

function Perl_Player_ManaHide()
	if (healermode == 1) then
		Perl_Player_ManaBarTextPercent:SetText();
		mouseovermanaflag = 0;
	end
end

function Perl_Player_DruidBarManaShow()
	if (DruidBarKey and (UnitClass("player") == PERL_LOCALIZED_DRUID)) then
		if (healermode == 1) then
			local playerdruidbarmana = floor(DruidBarKey.keepthemana);
			local playerdruidbarmanamax = DruidBarKey.maxmana;
			local playerdruidbarmanapercent = floor(playerdruidbarmana/playerdruidbarmanamax*100+0.5);

			if (playerdruidbarmanapercent == 100) then			-- This is to ensure the value isn't 1 or 2 mana under max when 100%
				playerdruidbarmana = playerdruidbarmanamax;
			end

			if (UnitIsDead("player") or UnitIsGhost("player")) then		-- This prevents negative mana
				playerdruidbarmana = 0;
			end

			Perl_Player_DruidBarTextPercent:SetText(playerdruidbarmana.."/"..playerdruidbarmanamax);

			mouseovermanaflag = 1;
		end
	end
end

function Perl_Player_DruidBarManaHide()
	if (healermode == 1) then
		Perl_Player_DruidBarTextPercent:SetText();
		mouseovermanaflag = 0;
	end
end

function Perl_Player_Update_Portrait()
	if (showportrait == 1) then
		Perl_Player_PortraitTextFrame:SetFrameLevel(Perl_Player_PortraitFrame:GetFrameLevel() + 1);	-- Put the combat text above it so the portrait graphic doesn't go on top of it
		Perl_Player_PortraitFrame:Show();								-- Show the main portrait frame

		if (threedportrait == 0) then
			SetPortraitTexture(Perl_Player_Portrait, "player");					-- Load the correct 2d graphic
			Perl_Player_PortraitFrame_PlayerModel:Hide();						-- Hide the 3d graphic
			Perl_Player_Portrait:Show();								-- Show the 2d graphic
		else
			Perl_Player_PortraitFrame_PlayerModel:SetUnit("player");				-- Load the correct 3d graphic
			Perl_Player_Portrait:Hide();								-- Hide the 2d graphic
			Perl_Player_PortraitFrame_PlayerModel:Show();						-- Show the 3d graphic
			Perl_Player_PortraitFrame_PlayerModel:SetCamera(0);
		end

		Perl_Player_PortraitTextFrame:Show();								-- Show the combat text frame
	else
		Perl_Player_PortraitFrame:Hide();								-- Hide the frame and 2d/3d portion
		Perl_Player_PortraitTextFrame:Hide();								-- Hide the combat text
	end
end

function Perl_Player_Portrait_Combat_Text()
	if (portraitcombattext == 1) then
		CombatFeedback_OnUpdate(arg1);
	end
end

function Perl_Player_Set_Localized_ClassIcons()
	Perl_Player_ClassPosRight = {
		[PERL_LOCALIZED_DRUID] = 0.75,
		[PERL_LOCALIZED_HUNTER] = 0,
		[PERL_LOCALIZED_MAGE] = 0.25,
		[PERL_LOCALIZED_PALADIN] = 0,
		[PERL_LOCALIZED_PRIEST] = 0.5,
		[PERL_LOCALIZED_ROGUE] = 0.5,
		[PERL_LOCALIZED_SHAMAN] = 0.25,
		[PERL_LOCALIZED_WARLOCK] = 0.75,
		[PERL_LOCALIZED_WARRIOR] = 0,
	};
	Perl_Player_ClassPosLeft = {
		[PERL_LOCALIZED_DRUID] = 1,
		[PERL_LOCALIZED_HUNTER] = 0.25,
		[PERL_LOCALIZED_MAGE] = 0.5,
		[PERL_LOCALIZED_PALADIN] = 0.25,
		[PERL_LOCALIZED_PRIEST] = 0.75,
		[PERL_LOCALIZED_ROGUE] = 0.75,
		[PERL_LOCALIZED_SHAMAN] = 0.5,
		[PERL_LOCALIZED_WARLOCK] = 1,
		[PERL_LOCALIZED_WARRIOR] = 0.25,
	};
	Perl_Player_ClassPosTop = {
		[PERL_LOCALIZED_DRUID] = 0,
		[PERL_LOCALIZED_HUNTER] = 0.25,
		[PERL_LOCALIZED_MAGE] = 0,
		[PERL_LOCALIZED_PALADIN] = 0.5,
		[PERL_LOCALIZED_PRIEST] = 0.25,
		[PERL_LOCALIZED_ROGUE] = 0,
		[PERL_LOCALIZED_SHAMAN] = 0.25,
		[PERL_LOCALIZED_WARLOCK] = 0.25,
		[PERL_LOCALIZED_WARRIOR] = 0,
		
	};
	Perl_Player_ClassPosBottom = {
		[PERL_LOCALIZED_DRUID] = 0.25,
		[PERL_LOCALIZED_HUNTER] = 0.5,
		[PERL_LOCALIZED_MAGE] = 0.25,
		[PERL_LOCALIZED_PALADIN] = 0.75,
		[PERL_LOCALIZED_PRIEST] = 0.5,
		[PERL_LOCALIZED_ROGUE] = 0.25,
		[PERL_LOCALIZED_SHAMAN] = 0.5,
		[PERL_LOCALIZED_WARLOCK] = 0.5,
		[PERL_LOCALIZED_WARRIOR] = 0.25,
	};
end


--------------------------
-- GUI Config Functions --
--------------------------
function Perl_Player_XPBar_Display(state)
	if (state == 1) then							-- Experience
		Perl_Player_StatsFrame:SetHeight(54);
		Perl_Player_StatsFrame_CastClickOverlay:SetHeight(54);
		Perl_Player_XPBar:Show();
		Perl_Player_XPBarBG:Show();
		Perl_Player_XPRestBar:Show();
		Perl_Player_XPBar_CastClickOverlay:Show();
		Perl_Player_Update_Experience();
	elseif (state == 2) then						-- PvP
		Perl_Player_StatsFrame:SetHeight(54);
		Perl_Player_StatsFrame_CastClickOverlay:SetHeight(54);
		Perl_Player_XPBar:Show();
		Perl_Player_XPBarBG:Show();
		Perl_Player_XPRestBar:Show();
		Perl_Player_XPBar_CastClickOverlay:Show();
		local rankNumber, rankName, rankProgress;
		rankNumber = UnitPVPRank("player")
		if (rankNumber < 1) then
			rankName = "Unranked"
		else
			rankName = GetPVPRankInfo(rankNumber, "player");
		end
		rankProgress = GetPVPRankProgress();
		Perl_Player_XPBar:SetMinMaxValues(0, 1);
		Perl_Player_XPRestBar:SetMinMaxValues(0, 1);
		Perl_Player_XPBar:SetValue(rankProgress);
		Perl_Player_XPRestBar:SetValue(rankProgress);
		Perl_Player_XPBarText:SetText(rankName);
	elseif (state == 3) then						-- Hidden
		Perl_Player_XPBar:Hide();
		Perl_Player_XPBarBG:Hide();
		Perl_Player_XPRestBar:Hide();
		Perl_Player_XPBar_CastClickOverlay:Hide();
		Perl_Player_StatsFrame:SetHeight(42);
		Perl_Player_StatsFrame_CastClickOverlay:SetHeight(42);
	elseif (state == 4) then						-- Reputation
		Perl_Player_StatsFrame:SetHeight(54);
		Perl_Player_StatsFrame_CastClickOverlay:SetHeight(54);
		Perl_Player_XPBar:Show();
		Perl_Player_XPBarBG:Show();
		Perl_Player_XPRestBar:Show();
		Perl_Player_XPBar_CastClickOverlay:Show();
		Perl_Player_Update_Reputation();
	end
	if (DruidBarKey and (UnitClass("player") == PERL_LOCALIZED_DRUID) and (UnitPowerType("player") > 0)) then		-- Only change the size if the player has Druid Bar, is a Druid, and is morphed currently
		if (state == 3) then
			Perl_Player_StatsFrame:SetHeight(54);			-- Experience Bar is hidden
			Perl_Player_StatsFrame_CastClickOverlay:SetHeight(54);
		else
			Perl_Player_StatsFrame:SetHeight(66);			-- Experience Bar is shown
			Perl_Player_StatsFrame_CastClickOverlay:SetHeight(66);
		end
	end
	xpbarstate = state;
	Perl_Player_UpdateVars();
end

function Perl_Player_Set_Compact(newvalue)
	compactmode = newvalue;
	Perl_Player_UpdateVars();
	Perl_Player_Set_Text_Positions();
	Perl_Player_Set_CompactMode();
end

function Perl_Player_Set_Healer(newvalue)
	healermode = newvalue;
	Perl_Player_UpdateVars();
	Perl_Player_Set_Text_Positions();
	Perl_Player_Update_Health();
	Perl_Player_Update_Mana();
end

function Perl_Player_Set_RaidGroupNumber(newvalue)
	showraidgroup = newvalue;
	Perl_Player_UpdateVars();
	Perl_Player_Update_Raid_Group_Number();
end

function Perl_Player_Set_Lock(newvalue)
	locked = newvalue;
	Perl_Player_UpdateVars();
end

function Perl_Player_Set_Portrait(newvalue)
	showportrait = newvalue;
	Perl_Player_UpdateVars();
	Perl_Player_Update_Portrait();
end

function Perl_Player_Set_3D_Portrait(newvalue)
	threedportrait = newvalue;
	Perl_Player_UpdateVars();
	Perl_Player_Update_Portrait();
end

function Perl_Player_Set_Portrait_Combat_Text(newvalue)
	portraitcombattext = newvalue;
	Perl_Player_UpdateVars();
end

function Perl_Player_Set_Compact_Percent(newvalue)
	compactpercent = newvalue;
	Perl_Player_UpdateVars();
	Perl_Player_Set_Text_Positions();
	Perl_Player_Set_CompactMode();
	Perl_Player_Update_Health();
	Perl_Player_Update_Mana();
end

function Perl_Player_Set_DruidBar(newvalue)
	showdruidbar = newvalue;
	Perl_Player_UpdateVars();
	Perl_Player_Set_Text_Positions();
	Perl_Player_Set_CompactMode();		-- Perl_Player_Update_Mana() called here
end

function Perl_Player_Set_Scale(number)
	local unsavedscale;
	if (number ~= nil) then
		scale = (number / 100);					-- convert the user input to a wow acceptable value
	end
	unsavedscale = 1 - UIParent:GetEffectiveScale() + scale;	-- run it through the scaling formula introduced in 1.9
	Perl_Player_Frame:SetScale(unsavedscale);
	Perl_Player_UpdateVars();
end

function Perl_Player_Set_Transparency(number)
	if (number ~= nil) then
		transparency = (number / 100);				-- convert the user input to a wow acceptable value
	end
	Perl_Player_Frame:SetAlpha(transparency);
	Perl_Player_UpdateVars();
end


------------------------------
-- Saved Variable Functions --
------------------------------
function Perl_Player_GetVars()
	locked = Perl_Player_Config[UnitName("player")]["Locked"];
	xpbarstate = Perl_Player_Config[UnitName("player")]["XPBarState"];
	compactmode = Perl_Player_Config[UnitName("player")]["CompactMode"];
	showraidgroup = Perl_Player_Config[UnitName("player")]["ShowRaidGroup"];
	scale = Perl_Player_Config[UnitName("player")]["Scale"];
	healermode = Perl_Player_Config[UnitName("player")]["HealerMode"];
	transparency = Perl_Player_Config[UnitName("player")]["Transparency"];
	showportrait = Perl_Player_Config[UnitName("player")]["ShowPortrait"];
	compactpercent = Perl_Player_Config[UnitName("player")]["CompactPercent"];
	threedportrait = Perl_Player_Config[UnitName("player")]["ThreeDPortrait"];
	portraitcombattext = Perl_Player_Config[UnitName("player")]["PortraitCombatText"];
	showdruidbar = Perl_Player_Config[UnitName("player")]["ShowDruidBar"];

	if (locked == nil) then
		locked = 0;
	end
	if (xpbarstate == nil) then
		xpbarstate = 1;
	end
	if (compactmode == nil) then
		compactmode = 0;
	end
	if (showraidgroup == nil) then
		showraidgroup = 1;
	end
	if (scale == nil) then
		scale = 1;
	end
	if (healermode == nil) then
		healermode = 0;
	end
	if (transparency == nil) then
		transparency = 1;
	end
	if (showportrait == nil) then
		showportrait = 0;
	end
	if (compactpercent == nil) then
		compactpercent = 0;
	end
	if (threedportrait == nil) then
		threedportrait = 0;
	end
	if (portraitcombattext == nil) then
		portraitcombattext = 1;
	end
	if (showdruidbar == nil) then
		showdruidbar = 1;
	end

	local vars = {
		["locked"] = locked,
		["xpbarstate"] = xpbarstate,
		["compactmode"] = compactmode,
		["showraidgroup"] = showraidgroup,
		["scale"] = scale,
		["healermode"] = healermode,
		["transparency"] = transparency,
		["showportrait"] = showportrait,
		["compactpercent"] = compactpercent,
		["threedportrait"] = threedportrait,
		["portraitcombattext"] = portraitcombattext,
		["showdruidbar"] = showdruidbar,
	}
	return vars;
end

function Perl_Player_UpdateVars(vartable)
	if (vartable ~= nil) then
		-- Sanity checks in case you use a load from an old version
		if (vartable["Global Settings"] ~= nil) then
			if (vartable["Global Settings"]["Locked"] ~= nil) then
				locked = vartable["Global Settings"]["Locked"];
			else
				locked = nil;
			end
			if (vartable["Global Settings"]["XPBarState"] ~= nil) then
				xpbarstate = vartable["Global Settings"]["XPBarState"];
			else
				xpbarstate = nil;
			end
			if (vartable["Global Settings"]["CompactMode"] ~= nil) then
				compactmode = vartable["Global Settings"]["CompactMode"];
			else
				compactmode = nil;
			end
			if (vartable["Global Settings"]["ShowRaidGroup"] ~= nil) then
				showraidgroup = vartable["Global Settings"]["ShowRaidGroup"];
			else
				showraidgroup = nil;
			end
			if (vartable["Global Settings"]["Scale"] ~= nil) then
				scale = vartable["Global Settings"]["Scale"];
			else
				scale = nil;
			end
			if (vartable["Global Settings"]["HealerMode"] ~= nil) then
				healermode = vartable["Global Settings"]["HealerMode"];
			else
				healermode = nil;
			end
			if (vartable["Global Settings"]["Transparency"] ~= nil) then
				transparency = vartable["Global Settings"]["Transparency"];
			else
				transparency = nil;
			end
			if (vartable["Global Settings"]["ShowPortrait"] ~= nil) then
				showportrait = vartable["Global Settings"]["ShowPortrait"];
			else
				showportrait = nil;
			end
			if (vartable["Global Settings"]["CompactPercent"] ~= nil) then
				compactpercent = vartable["Global Settings"]["CompactPercent"];
			else
				compactpercent = nil;
			end
			if (vartable["Global Settings"]["ThreeDPortrait"] ~= nil) then
				threedportrait = vartable["Global Settings"]["ThreeDPortrait"];
			else
				threedportrait = nil;
			end
			if (vartable["Global Settings"]["PortraitCombatText"] ~= nil) then
				portraitcombattext = vartable["Global Settings"]["PortraitCombatText"];
			else
				portraitcombattext = nil;
			end
			if (vartable["Global Settings"]["ShowDruidBar"] ~= nil) then
				showdruidbar = vartable["Global Settings"]["ShowDruidBar"];
			else
				showdruidbar = nil;
			end
		end

		-- Set the new values if any new values were found, same defaults as above
		if (locked == nil) then
			locked = 0;
		end
		if (xpbarstate == nil) then
			xpbarstate = 1;
		end
		if (compactmode == nil) then
			compactmode = 0;
		end
		if (showraidgroup == nil) then
			showraidgroup = 1;
		end
		if (scale == nil) then
			scale = 1;
		end
		if (healermode == nil) then
			healermode = 0;
		end
		if (transparency == nil) then
			transparency = 1;
		end
		if (showportrait == nil) then
			showportrait = 0;
		end
		if (compactpercent == nil) then
			compactpercent = 0;
		end
		if (threedportrait == nil) then
			threedportrait = 0;
		end
		if (portraitcombattext == nil) then
			portraitcombattext = 1;
		end
		if (showdruidbar == nil) then
			showdruidbar = 1;
		end

		-- Call any code we need to activate them
		Perl_Player_XPBar_Display(xpbarstate);
		Perl_Player_Set_Compact(compactmode);
		Perl_Player_Set_Healer(healermode);
		Perl_Player_Update_Raid_Group_Number();
		Perl_Player_Update_Health();
		Perl_Player_Update_Mana();
		Perl_Player_Update_Portrait();
		Perl_Player_Set_Scale();
		Perl_Player_Set_Transparency();
	end

	Perl_Player_Config[UnitName("player")] = {
		["Locked"] = locked,
		["XPBarState"] = xpbarstate,
		["CompactMode"] = compactmode,
		["ShowRaidGroup"] = showraidgroup,
		["Scale"] = scale,
		["HealerMode"] = healermode,
		["Transparency"] = transparency,
		["ShowPortrait"] = showportrait,
		["CompactPercent"] = compactpercent,
		["ThreeDPortrait"] = threedportrait,
		["PortraitCombatText"] = portraitcombattext,
		["ShowDruidBar"] = showdruidbar,
	};
end


--------------------
-- Click Handlers --
--------------------
function Perl_PlayerDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, Perl_PlayerDropDown_Initialize, "MENU");
end

function Perl_PlayerDropDown_Initialize()
	UnitPopup_ShowMenu(Perl_Player_DropDown, "SELF", "player");
end

function Perl_Player_MouseClick(button)
	if (CastPartyConfig and PCUF_CASTPARTYSUPPORT == 1) then
		if (not string.find(GetMouseFocus():GetName(), "Name")) then
			CastParty_OnClickByUnit(button, "player");
		end
	elseif (Genesis_data and PCUF_CASTPARTYSUPPORT == 1) then
		if (not string.find(GetMouseFocus():GetName(), "Name")) then
			Genesis_MouseHeal("player", button);
		end
	else
		if (SpellIsTargeting() and button == "RightButton") then
			SpellStopTargeting();
			return;
		end

		if (button == "LeftButton") then
			if (SpellIsTargeting()) then
				SpellTargetUnit("player");
			elseif (CursorHasItem()) then
				DropItemOnUnit("player");
			else
				TargetUnit("player");
			end
		end
	end
end

function Perl_Player_MouseDown(button)
	if (button == "LeftButton" and locked == 0) then
		Perl_Player_Frame:StartMoving();
	end
end

function Perl_Player_MouseUp(button)
	if (button == "RightButton") then
		if ((CastPartyConfig or Genesis_data) and PCUF_CASTPARTYSUPPORT == 1) then
			if (not (IsAltKeyDown() or IsControlKeyDown() or IsShiftKeyDown()) and string.find(GetMouseFocus():GetName(), "Name")) then		-- if alt, ctrl, or shift ARE NOT held AND we are clicking the name frame, show the menu
				ToggleDropDownMenu(1, nil, Perl_Player_DropDown, "Perl_Player_NameFrame", 40, 0);
			end
		else
			if (not (IsAltKeyDown() or IsControlKeyDown() or IsShiftKeyDown())) then		-- if alt, ctrl, or shift ARE NOT held, show the menu
				ToggleDropDownMenu(1, nil, Perl_Player_DropDown, "Perl_Player_NameFrame", 40, 0);
			end
		end
	end

	Perl_Player_Frame:StopMovingOrSizing();
end


------------------------
-- Experience Tooltip --
------------------------
function Perl_Player_XPTooltip()
	local playerxp, playerxpmax, xptext
	GameTooltip_SetDefaultAnchor(GameTooltip, this);
	if (xpbarstate == 1) then
		local playerlevel = UnitLevel("player");			-- Player's next level
		if (playerlevel < 70) then
			playerxp = UnitXP("player");				-- Player's current XP
			playerxpmax = UnitXPMax("player");			-- Experience for the current level
			local playerxprest = GetXPExhaustion();			-- Amount of bonus xp we have
			local xptolevel = playerxpmax - playerxp		-- XP till level

			if (playerxprest) then
				xptext = playerxp.."/"..playerxpmax .." (+"..(playerxprest)..")";	-- Create the experience string w/ rest xp
			else
				xptext = playerxp.."/"..playerxpmax;		-- Create the experience string w/ no rest xp
			end

			GameTooltip:SetText(xptext, 255/255, 209/255, 0/255);
			GameTooltip:AddLine(xptolevel.." until level "..(playerlevel + 1), 255/255, 209/255, 0/255);
		else
			GameTooltip:SetText("You can't gain anymore experience!", 255/255, 209/255, 0/255);
		end
		
	elseif (xpbarstate == 2) then
		local rankNumber, rankName, rankProgress;			-- Some variables
		rankNumber = UnitPVPRank("player")
		if (rankNumber < 1) then
			rankName = "Unranked"
			GameTooltip:SetText("You are Unranked.", 255/255, 209/255, 0/255);
		else
			rankName = GetPVPRankInfo(rankNumber, "player");
			rankProgress = floor(GetPVPRankProgress() * 100);
			GameTooltip:SetText(rankProgress.."% into Rank "..(rankNumber - 4).." ("..rankName..")", 255/255, 209/255, 0/255);
			if (rankNumber < 18) then
				rankNumber = rankNumber + 1;
				rankName = GetPVPRankInfo(rankNumber, "player");
				GameTooltip:AddLine((100 - rankProgress).."% until Rank "..(rankNumber - 4).." ("..rankName..")", 255/255, 209/255, 0/255);
			end
		end
	elseif (xpbarstate == 4) then
		local name, reaction, min, max, value = GetWatchedFactionInfo();
		if (name) then
			value = value - min;
			max = max - min;
			min = 0;
			GameTooltip:SetText(floor(value/max*100+0.5).."% into "..Perl_Player_Get_Reaction_Name(reaction), 255/255, 209/255, 0/255);
			GameTooltip:AddLine(value.."/"..max, 255/255, 209/255, 0/255);
			if (reaction ~= 8) then
				GameTooltip:AddLine((max - value).." until "..Perl_Player_Get_Reaction_Name(reaction + 1), 255/255, 209/255, 0/255);
			end
		else
			GameTooltip:SetText("There is no reputation being tracked.", 255/255, 209/255, 0/255);
		end
	end
	GameTooltip:Show();
end

function Perl_Player_Get_Reaction_Name(reaction)
	local reactionname;
	if (reaction == 1) then
		reactionname = "Hated";
	elseif (reaction == 2) then
		reactionname = "Hostile";
	elseif (reaction == 3) then
		reactionname = "Unfriendly";
	elseif (reaction == 4) then
		reactionname = "Neutral";
	elseif (reaction == 5) then
		reactionname = "Friendly";
	elseif (reaction == 6) then
		reactionname = "Honored";
	elseif (reaction == 7) then
		reactionname = "Revered";
	elseif (reaction == 8) then
		reactionname = "Exalted";
	end
	return reactionname;
end


-----------------------
-- Scripting Support --
-----------------------
function Perl_Player_InCombat()
	if (InCombat == 1) then
		return 1;
	else
		return nil;
	end
end


----------------------
-- myAddOns Support --
----------------------
function Perl_Player_myAddOns_Support()
	-- Register the addon in myAddOns
	if (myAddOnsFrame_Register) then
		local Perl_Player_myAddOns_Details = {
			name = "Perl_Player",
			version = "Version 0.58",
			releaseDate = "April 15, 2006",
			author = "Perl; Maintained by Global",
			email = "global@g-ball.com",
			website = "http://www.curse-gaming.com/mod.php?addid=2257",
			category = MYADDONS_CATEGORY_OTHERS
		};
		Perl_Player_myAddOns_Help = {};
		Perl_Player_myAddOns_Help[1] = "/perl";
		myAddOnsFrame_Register(Perl_Player_myAddOns_Details, Perl_Player_myAddOns_Help);
	end
end