---------------
-- Variables --
---------------
Perl_Target_Target_Config = {};

-- Default Saved Variables (also set in Perl_Target_Target_GetVars)
local locked = 0;		-- unlocked by default
local mobhealthsupport = 1;	-- mobhealth support is on by default
local scale = 1;		-- default scale
local totsupport = 1;		-- target of target support enabled by default
local tototsupport = 1;		-- target of target of target support enabled by default
local transparency = 1;		-- transparency for frames
local alertsound = 0;		-- audible alert disabled by default
local alertmode = 0;		-- DPS, Tank, Healer modes
local alertsize = 0;		-- Variable which controls the size of the text

-- Default Local Variables
local Initialized = nil;				-- waiting to be initialized
local Perl_Target_Target_Time_Elapsed = 0;		-- set the update timer to 0
local Perl_Target_Target_Time_Update_Rate = 0.2;	-- the update interval
local aggroWarningCount = 0;				-- the check to see if we have alerted the player of a ToT event
local aggroToToTWarningCount = 0;			-- the check to see if we have alerted the player of a ToToT event
local startTime = 0;					-- used to keep track of fading the big alert text
local mouseovertargettargethealthflag = 0;		-- is the mouse over the health bar for healer mode?
local mouseovertargettargetmanaflag = 0;		-- is the mouse over the mana bar for healer mode?
local mouseovertargettargettargethealthflag = 0;	-- is the mouse over the health bar for healer mode?
local mouseovertargettargettargetmanaflag = 0;		-- is the mouse over the mana bar for healer mode?


----------------------
-- Loading Function --
----------------------
function Perl_Target_Target_OnLoad()
	-- Events
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("VARIABLES_LOADED");

	-- Button Click Overlays (in order of occurrence in XML)
	Perl_Target_Target_NameFrame_CastClickOverlay:SetFrameLevel(Perl_Target_Target_NameFrame:GetFrameLevel() + 1);
	Perl_Target_Target_StatsFrame_CastClickOverlay:SetFrameLevel(Perl_Target_Target_StatsFrame:GetFrameLevel() + 1);
	Perl_Target_Target_HealthBar_CastClickOverlay:SetFrameLevel(Perl_Target_Target_StatsFrame:GetFrameLevel() + 2);
	Perl_Target_Target_ManaBar_CastClickOverlay:SetFrameLevel(Perl_Target_Target_StatsFrame:GetFrameLevel() + 2);
	Perl_Target_Target_Target_NameFrame_CastClickOverlay:SetFrameLevel(Perl_Target_Target_Target_NameFrame:GetFrameLevel() + 1);
	Perl_Target_Target_Target_StatsFrame_CastClickOverlay:SetFrameLevel(Perl_Target_Target_Target_StatsFrame:GetFrameLevel() + 1);
	Perl_Target_Target_Target_HealthBar_CastClickOverlay:SetFrameLevel(Perl_Target_Target_Target_StatsFrame:GetFrameLevel() + 2);
	Perl_Target_Target_Target_ManaBar_CastClickOverlay:SetFrameLevel(Perl_Target_Target_Target_StatsFrame:GetFrameLevel() + 2);

	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Perl Classic: Target_Target loaded successfully.");
	end
end


-------------------
-- Event Handler --
-------------------
function Perl_Target_Target_OnEvent(event)
	if (event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_TARGET_CHANGED") then
		aggroWarningCount = 0;
	elseif (event == "VARIABLES_LOADED") or (event=="PLAYER_ENTERING_WORLD") then
		Perl_Target_Target_Initialize();
		return;
	elseif (event == "ADDON_LOADED") then
		if (arg1 == "Perl_Target_Target") then
			Perl_Target_Target_myAddOns_Support();
		end
		return;
	else
		return;
	end
end


-------------------------------
-- Loading Settings Function --
-------------------------------
function Perl_Target_Target_Initialize()
	if (Initialized) then
		Perl_Target_Target_Set_Scale();		-- Set the scale
		Perl_Target_Target_Set_Transparency();	-- Set the transparency
		return;
	end

	-- Check if a previous exists, if not, enable by default.
	if (type(Perl_Target_Target_Config[UnitName("player")]) == "table") then
		Perl_Target_Target_GetVars();
	else
		Perl_Target_Target_UpdateVars();
	end

	-- Major config options.
	Perl_Target_Target_Initialize_Frame_Color();
	Perl_Target_Target_Frame:Hide();
	Perl_Target_Target_Target_Frame:Hide();

	Initialized = 1;
end

function Perl_Target_Target_Initialize_Frame_Color()
	Perl_Target_Target_StatsFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_Target_StatsFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Target_Target_NameFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_Target_NameFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Target_Target_HealthBarText:SetTextColor(1, 1, 1, 1);
	Perl_Target_Target_ManaBarText:SetTextColor(1, 1, 1, 1);

	Perl_Target_Target_Target_StatsFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_Target_Target_StatsFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Target_Target_Target_NameFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_Target_Target_NameFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Target_Target_Target_HealthBarText:SetTextColor(1, 1, 1, 1);
	Perl_Target_Target_Target_ManaBarText:SetTextColor(1, 1, 1, 1);
end


--------------------------
-- The Update Functions --
--------------------------
function Perl_Target_Target_OnUpdate(arg1)
	Perl_Target_Target_Time_Elapsed = Perl_Target_Target_Time_Elapsed + arg1;
	if (Perl_Target_Target_Time_Elapsed > Perl_Target_Target_Time_Update_Rate) then
		Perl_Target_Target_Time_Elapsed = 0;

		if (UnitExists("targettarget") and totsupport == 1) then
			Perl_Target_Target_Warn();				-- Display any warnings if needed
			Perl_Target_Target_Frame:Show();			-- Show the frame

			-- Begin: Set the name
			local targettargetname = UnitName("targettarget");
			if (strlen(targettargetname) > 11) then
				targettargetname = strsub(targettargetname, 1, 10).."...";
			end
			Perl_Target_Target_NameBarText:SetText(targettargetname);
			-- End: Set the name

			-- Begin: Set the name text color
			if (UnitIsPlayer("targettarget") or UnitPlayerControlled("targettarget")) then		-- is it a player
				local r, g, b;
				if (UnitCanAttack("targettarget", "player")) then				-- are we in an enemy controlled zone
					-- Hostile players are red
					if (not UnitCanAttack("player", "targettarget")) then			-- enemy is not pvp enabled
						r = 0.5;
						g = 0.5;
						b = 1.0;
					else									-- enemy is pvp enabled
						r = 1.0;
						g = 0.0;
						b = 0.0;
					end
				elseif (UnitCanAttack("player", "targettarget")) then				-- enemy in a zone controlled by friendlies or when we're a ghost
					-- Players we can attack but which are not hostile are yellow
					r = 1.0;
					g = 1.0;
					b = 0.0;
				elseif (UnitIsPVP("targettarget")) then						-- friendly pvp enabled character
					-- Players we can assist but are PvP flagged are green
					r = 0.0;
					g = 1.0;
					b = 0.0;
				else										-- friendly non pvp enabled character
					-- All other players are blue (the usual state on the "blue" server)
					r = 0.5;
					g = 0.5;
					b = 1.0;
				end
				Perl_Target_Target_NameBarText:SetTextColor(r, g, b);
			elseif (UnitIsTapped("targettarget") and not UnitIsTappedByPlayer("targettarget")) then
				Perl_Target_Target_NameBarText:SetTextColor(0.5,0.5,0.5);			-- not our tap
			else
				local reaction = UnitReaction("targettarget", "player");
				if (reaction) then
					local r, g, b;
					r = UnitReactionColor[reaction].r;
					g = UnitReactionColor[reaction].g;
					b = UnitReactionColor[reaction].b;
					Perl_Target_Target_NameBarText:SetTextColor(r, g, b);
				else
					Perl_Target_Target_NameBarText:SetTextColor(0.5, 0.5, 1.0);
				end
			end
			-- End: Set the name text color

			-- Begin: Update the health bar
			local targettargethealth = UnitHealth("targettarget");
			local targettargethealthmax = UnitHealthMax("targettarget");
			local targettargethealthpercent = floor(targettargethealth/targettargethealthmax*100+0.5);

			if (UnitIsDead("targettarget") or UnitIsGhost("targettarget")) then				-- This prevents negative health
				targettargethealth = 0;
				targettargethealthpercent = 0;
			end

			Perl_Target_Target_HealthBar:SetMinMaxValues(0, targettargethealthmax);
			Perl_Target_Target_HealthBar:SetValue(targettargethealth);

			if (PCUF_COLORHEALTH == 1) then
				if ((targettargethealthpercent <= 100) and (targettargethealthpercent > 75)) then
					Perl_Target_Target_HealthBar:SetStatusBarColor(0, 0.8, 0);
					Perl_Target_Target_HealthBarBG:SetStatusBarColor(0, 0.8, 0, 0.25);
				elseif ((targettargethealthpercent <= 75) and (targettargethealthpercent > 50)) then
					Perl_Target_Target_HealthBar:SetStatusBarColor(1, 1, 0);
					Perl_Target_Target_HealthBarBG:SetStatusBarColor(1, 1, 0, 0.25);
				elseif ((targettargethealthpercent <= 50) and (targettargethealthpercent > 25)) then
					Perl_Target_Target_HealthBar:SetStatusBarColor(1, 0.5, 0);
					Perl_Target_Target_HealthBarBG:SetStatusBarColor(1, 0.5, 0, 0.25);
				else
					Perl_Target_Target_HealthBar:SetStatusBarColor(1, 0, 0);
					Perl_Target_Target_HealthBarBG:SetStatusBarColor(1, 0, 0, 0.25);
				end
			else
				Perl_Target_Target_HealthBar:SetStatusBarColor(0, 0.8, 0);
				Perl_Target_Target_HealthBarBG:SetStatusBarColor(0, 0.8, 0, 0.25);
			end

			if (mouseovertargettargethealthflag == 1) then
				Perl_Target_Target_HealthShow();
			else
				Perl_Target_Target_HealthBarText:SetText(targettargethealthpercent.."%");
			end
			-- End: Update the health bar

			-- Begin: Update the mana bar
			local targettargetmana = UnitMana("targettarget");
			local targettargetmanamax = UnitManaMax("targettarget");

			if (UnitIsDead("targettarget") or UnitIsGhost("targettarget")) then				-- This prevents negative mana
				targettargetmana = 0;
			end

			Perl_Target_Target_ManaBar:SetMinMaxValues(0, targettargetmanamax);
			Perl_Target_Target_ManaBar:SetValue(targettargetmana);

			if (mouseovertargettargetmanaflag == 1) then
				if (UnitPowerType("targettarget") == 1 or UnitPowerType("targettarget") == 2) then
					Perl_Target_Target_ManaBarText:SetText(targettargetmana);
				else
					Perl_Target_Target_ManaBarText:SetText(targettargetmana.."/"..targettargetmanamax);
				end
			else
				Perl_Target_Target_ManaBarText:Hide();
			end
			-- End: Update the mana bar

			-- Begin: Update the mana bar color
			local targettargetmanamax = UnitManaMax("targettarget");
			local targettargetpower = UnitPowerType("targettarget");

			-- Set mana bar color
			if (targettargetmanamax == 0) then
				Perl_Target_Target_ManaBar:Hide();
				Perl_Target_Target_ManaBarBG:Hide();
				Perl_Target_Target_ManaBar_CastClickOverlay:Hide();
				Perl_Target_Target_StatsFrame:SetHeight(30);
				Perl_Target_Target_StatsFrame_CastClickOverlay:SetHeight(30);
			elseif (targettargetpower == 1) then
				Perl_Target_Target_ManaBar:SetStatusBarColor(1, 0, 0, 1);
				Perl_Target_Target_ManaBarBG:SetStatusBarColor(1, 0, 0, 0.25);
				Perl_Target_Target_ManaBar:Show();
				Perl_Target_Target_ManaBarBG:Show();
				Perl_Target_Target_ManaBar_CastClickOverlay:Show();
				Perl_Target_Target_StatsFrame:SetHeight(42);
				Perl_Target_Target_StatsFrame_CastClickOverlay:SetHeight(42);
			elseif (targettargetpower == 2) then
				Perl_Target_Target_ManaBar:SetStatusBarColor(1, 0.5, 0, 1);
				Perl_Target_Target_ManaBarBG:SetStatusBarColor(1, 0.5, 0, 0.25);
				Perl_Target_Target_ManaBar:Show();
				Perl_Target_Target_ManaBarBG:Show();
				Perl_Target_Target_ManaBar_CastClickOverlay:Show();
				Perl_Target_Target_StatsFrame:SetHeight(42);
				Perl_Target_Target_StatsFrame_CastClickOverlay:SetHeight(42);
			elseif (targettargetpower == 3) then
				Perl_Target_Target_ManaBar:SetStatusBarColor(1, 1, 0, 1);
				Perl_Target_Target_ManaBarBG:SetStatusBarColor(1, 1, 0, 0.25);
				Perl_Target_Target_ManaBar:Show();
				Perl_Target_Target_ManaBarBG:Show();
				Perl_Target_Target_ManaBar_CastClickOverlay:Show();
				Perl_Target_Target_StatsFrame:SetHeight(42);
				Perl_Target_Target_StatsFrame_CastClickOverlay:SetHeight(42);
			else
				Perl_Target_Target_ManaBar:SetStatusBarColor(0, 0, 1, 1);
				Perl_Target_Target_ManaBarBG:SetStatusBarColor(0, 0, 1, 0.25);
				Perl_Target_Target_ManaBar:Show();
				Perl_Target_Target_ManaBarBG:Show();
				Perl_Target_Target_ManaBar_CastClickOverlay:Show();
				Perl_Target_Target_StatsFrame:SetHeight(42);
				Perl_Target_Target_StatsFrame_CastClickOverlay:SetHeight(42);
			end
			-- End: Update the mana bar color
		else
			Perl_Target_Target_Frame:Hide();			-- Hide the frame
		end

		if (UnitExists("targettargettarget") and tototsupport == 1) then
			Perl_Target_Target_Target_Frame:Show();			-- Show the frame

			if (UnitAffectingCombat("targettarget")) then
				if (UnitIsDead("targettargettarget") or UnitIsCorpse("targettargettarget")) then
					-- Im thinking targetting something that is targetting a corpse or dead thing is causing crashes
					-- Hence this safety check. If it is, we do nothing.
				else
					if (UnitName("targettargettarget")) then
						if (UnitIsEnemy("targettarget", "player")) then
							if (UnitName("targettargettarget") == UnitName("player")) then			-- play the warning sound if needed
								if (aggroWarningCount == 0 and aggroToToTWarningCount == 0) then
									-- Its coming right for us!
									if (aggroToToTWarningCount == 0) then
										aggroToToTWarningCount = 1;
										Perl_Target_Target_Play_Sound();
									end
								end
							else
								-- Whew it isnt fighting us
								aggroToToTWarningCount = 0;
							end
						else
							-- Friendly target
							aggroToToTWarningCount = 0;
						end
					end
				end
			end
			

			-- Begin: Set the name
			local targettargettargetname = UnitName("targettargettarget");
			if (strlen(targettargettargetname) > 11) then
				targettargettargetname = strsub(targettargettargetname, 1, 10).."...";
			end
			Perl_Target_Target_Target_NameBarText:SetText(targettargettargetname);
			-- End: Set the name

			-- Begin: Set the name text color
			if (UnitIsPlayer("targettargettarget") or UnitPlayerControlled("targettargettarget")) then	-- is it a player
				local r, g, b;
				if (UnitCanAttack("targettargettarget", "player")) then					-- are we in an enemy controlled zone
					-- Hostile players are red
					if (not UnitCanAttack("player", "targettargettarget")) then			-- enemy is not pvp enabled
						r = 0.5;
						g = 0.5;
						b = 1.0;
					else										-- enemy is pvp enabled
						r = 1.0;
						g = 0.0;
						b = 0.0;
					end
				elseif (UnitCanAttack("player", "targettargettarget")) then				-- enemy in a zone controlled by friendlies or when we're a ghost
					-- Players we can attack but which are not hostile are yellow
					r = 1.0;
					g = 1.0;
					b = 0.0;
				elseif (UnitIsPVP("targettargettarget")) then						-- friendly pvp enabled character
					-- Players we can assist but are PvP flagged are green
					r = 0.0;
					g = 1.0;
					b = 0.0;
				else											-- friendly non pvp enabled character
					-- All other players are blue (the usual state on the "blue" server)
					r = 0.5;
					g = 0.5;
					b = 1.0;
				end
				Perl_Target_Target_Target_NameBarText:SetTextColor(r, g, b);
			elseif (UnitIsTapped("targettargettarget") and not UnitIsTappedByPlayer("targettargettarget")) then
				Perl_Target_Target_Target_NameBarText:SetTextColor(0.5,0.5,0.5);			-- not our tap
			else
				local reaction = UnitReaction("targettargettarget", "player");
				if (reaction) then
					local r, g, b;
					r = UnitReactionColor[reaction].r;
					g = UnitReactionColor[reaction].g;
					b = UnitReactionColor[reaction].b;
					Perl_Target_Target_Target_NameBarText:SetTextColor(r, g, b);
				else
					Perl_Target_Target_Target_NameBarText:SetTextColor(0.5, 0.5, 1.0);
				end
			end
			-- End: Set the name text color

			-- Begin: Update the health bar
			local targettargettargethealth = UnitHealth("targettargettarget");
			local targettargettargethealthmax = UnitHealthMax("targettargettarget");
			local targettargettargethealthpercent = floor(targettargettargethealth/targettargettargethealthmax*100+0.5);

			if (UnitIsDead("targettargettarget") or UnitIsGhost("targettargettarget")) then				-- This prevents negative health
				targettargettargethealth = 0;
				targettargettargethealthpercent = 0;
			end

			Perl_Target_Target_Target_HealthBar:SetMinMaxValues(0, targettargettargethealthmax);
			Perl_Target_Target_Target_HealthBar:SetValue(targettargettargethealth);

			if (PCUF_COLORHEALTH == 1) then
				if ((targettargettargethealthpercent <= 100) and (targettargettargethealthpercent > 75)) then
					Perl_Target_Target_Target_HealthBar:SetStatusBarColor(0, 0.8, 0);
					Perl_Target_Target_Target_HealthBarBG:SetStatusBarColor(0, 0.8, 0, 0.25);
				elseif ((targettargettargethealthpercent <= 75) and (targettargettargethealthpercent > 50)) then
					Perl_Target_Target_Target_HealthBar:SetStatusBarColor(1, 1, 0);
					Perl_Target_Target_Target_HealthBarBG:SetStatusBarColor(1, 1, 0, 0.25);
				elseif ((targettargettargethealthpercent <= 50) and (targettargettargethealthpercent > 25)) then
					Perl_Target_Target_Target_HealthBar:SetStatusBarColor(1, 0.5, 0);
					Perl_Target_Target_Target_HealthBarBG:SetStatusBarColor(1, 0.5, 0, 0.25);
				else
					Perl_Target_Target_Target_HealthBar:SetStatusBarColor(1, 0, 0);
					Perl_Target_Target_Target_HealthBarBG:SetStatusBarColor(1, 0, 0, 0.25);
				end
			else
				Perl_Target_Target_Target_HealthBar:SetStatusBarColor(0, 0.8, 0);
				Perl_Target_Target_Target_HealthBarBG:SetStatusBarColor(0, 0.8, 0, 0.25);
			end

			if (mouseovertargettargettargethealthflag == 1) then
				Perl_Target_Target_Target_HealthShow();
			else
				Perl_Target_Target_Target_HealthBarText:SetText(targettargettargethealthpercent.."%");
			end
			-- End: Update the health bar

			-- Begin: Update the mana bar
			local targettargettargetmana = UnitMana("targettargettarget");
			local targettargettargetmanamax = UnitManaMax("targettargettarget");

			if (UnitIsDead("targettargettarget") or UnitIsGhost("targettargettarget")) then				-- This prevents negative mana
				targettargettargetmana = 0;
			end

			Perl_Target_Target_Target_ManaBar:SetMinMaxValues(0, targettargettargetmanamax);
			Perl_Target_Target_Target_ManaBar:SetValue(targettargettargetmana);

			if (mouseovertargettargettargetmanaflag == 1) then
				if (UnitPowerType("targettargettarget") == 1 or UnitPowerType("targettargettarget") == 2) then
					Perl_Target_Target_Target_ManaBarText:SetText(targettargettargetmana);
				else
					Perl_Target_Target_Target_ManaBarText:SetText(targettargettargetmana.."/"..targettargettargetmanamax);
				end
			else
				Perl_Target_Target_Target_ManaBarText:Hide();
			end
			-- End: Update the mana bar

			-- Begin: Update the mana bar color
			local targettargettargetmanamax = UnitManaMax("targettargettarget");
			local targettargettargetpower = UnitPowerType("targettargettarget");

			-- Set mana bar color
			if (targettargettargetmanamax == 0) then
				Perl_Target_Target_Target_ManaBar:Hide();
				Perl_Target_Target_Target_ManaBarBG:Hide();
				Perl_Target_Target_Target_ManaBar_CastClickOverlay:Hide();
				Perl_Target_Target_Target_StatsFrame:SetHeight(30);
				Perl_Target_Target_Target_StatsFrame_CastClickOverlay:SetHeight(30);
			elseif (targettargettargetpower == 1) then
				Perl_Target_Target_Target_ManaBar:SetStatusBarColor(1, 0, 0, 1);
				Perl_Target_Target_Target_ManaBarBG:SetStatusBarColor(1, 0, 0, 0.25);
				Perl_Target_Target_Target_ManaBar:Show();
				Perl_Target_Target_Target_ManaBarBG:Show();
				Perl_Target_Target_Target_ManaBar_CastClickOverlay:Show();
				Perl_Target_Target_Target_StatsFrame:SetHeight(42);
				Perl_Target_Target_Target_StatsFrame_CastClickOverlay:SetHeight(42);
			elseif (targettargettargetpower == 2) then
				Perl_Target_Target_Target_ManaBar:SetStatusBarColor(1, 0.5, 0, 1);
				Perl_Target_Target_Target_ManaBarBG:SetStatusBarColor(1, 0.5, 0, 0.25);
				Perl_Target_Target_Target_ManaBar:Show();
				Perl_Target_Target_Target_ManaBarBG:Show();
				Perl_Target_Target_Target_ManaBar_CastClickOverlay:Show();
				Perl_Target_Target_Target_StatsFrame:SetHeight(42);
				Perl_Target_Target_Target_StatsFrame_CastClickOverlay:SetHeight(42);
			elseif (targettargettargetpower == 3) then
				Perl_Target_Target_Target_ManaBar:SetStatusBarColor(1, 1, 0, 1);
				Perl_Target_Target_Target_ManaBarBG:SetStatusBarColor(1, 1, 0, 0.25);
				Perl_Target_Target_Target_ManaBar:Show();
				Perl_Target_Target_Target_ManaBarBG:Show();
				Perl_Target_Target_Target_ManaBar_CastClickOverlay:Show();
				Perl_Target_Target_Target_StatsFrame:SetHeight(42);
				Perl_Target_Target_Target_StatsFrame_CastClickOverlay:SetHeight(42);
			else
				Perl_Target_Target_Target_ManaBar:SetStatusBarColor(0, 0, 1, 1);
				Perl_Target_Target_Target_ManaBarBG:SetStatusBarColor(0, 0, 1, 0.25);
				Perl_Target_Target_Target_ManaBar:Show();
				Perl_Target_Target_Target_ManaBarBG:Show();
				Perl_Target_Target_Target_ManaBar_CastClickOverlay:Show();
				Perl_Target_Target_Target_StatsFrame:SetHeight(42);
				Perl_Target_Target_Target_StatsFrame_CastClickOverlay:SetHeight(42);
			end
			-- End: Update the mana bar color
		else
			Perl_Target_Target_Target_Frame:Hide();			-- Hide the frame
		end

	end
end

function Perl_Target_Target_Warn()
	-- Player has something targetted
	if (UnitAffectingCombat("target")) then								-- Target is in an active combat situation
		if (UnitIsDead("targettarget") or UnitIsCorpse("targettarget")) then			-- Target is dead, do nothing
			-- Previous author had this in as a safety check
		else
			if (not UnitIsFriend("target", "player")) then					-- Target isn't dead
				-- Stupid mobs dont have targets when they are trapped/polyd/sapped/stunned, check for this
				if (alertmode == 0) then	-- Disabled but still have audible alert enabled
					if (UnitName("targettarget") == UnitName("player")) then	-- play the warning sound if needed
						-- Its coming right for us!
						if (aggroWarningCount == 0) then
							aggroWarningCount = 1;
							Perl_Target_Target_Play_Sound();
						end
					else
						-- Whew it isnt fighting us
						aggroWarningCount = 0;
					end
				elseif (alertmode == 1) then	-- DPS Mode
					if (UnitName("targettarget") == UnitName("player")) then
						-- Its coming right for us!
						if (aggroWarningCount == 0) then
							if (alertsize == 0) then
								UIErrorsFrame:AddMessage(UnitName("target").." has changed targets to you!",1,0,0,1,3);
							elseif (alertsize == 1) then
								Perl_Target_Target_BigWarning_Show(UnitName("target").." has changed targets to you!");
							elseif (alertsize == 2) then
								-- Warning disabled
							end
							aggroWarningCount = 1;
							Perl_Target_Target_Play_Sound();
						end
					else
						-- Whew it isnt fighting us
						aggroWarningCount = 0;
					end
				elseif (alertmode == 2) then	-- Tank mode
					if (UnitName("targettarget") == UnitName("player")) then
						-- Its coming right for us! (A good thing, im tanking it)
						aggroWarningCount = 0;
					else
						-- Some dumb hunter pulled aggro
						if (aggroWarningCount == 0) then
							if (alertsize == 0) then
								UIErrorsFrame:AddMessage("You have lost aggro to "..UnitName("targettarget").."!",1,0,0,1,3);
							elseif (alertsize == 1) then
								Perl_Target_Target_BigWarning_Show("You have lost aggro to "..UnitName("targettarget").."!");
							elseif (alertsize == 2) then
								-- Warning disabled
							end
							aggroWarningCount = 1;
							Perl_Target_Target_Play_Sound();
						end
					end
				elseif (alertmode == 3) then	-- Healer Mode (Do this check down here for sanity reasons)
					Perl_Target_Target_Warn_Healer_Mode();
				else
					-- Friendly target
					aggroWarningCount = 0;
				end
				--end
			else
				if (alertmode == 3) then	-- Healer Mode (Do this check down here for sanity reasons)
					Perl_Target_Target_Warn_Healer_Mode();
				else
					-- Friendly target
					aggroWarningCount = 0;
				end
			end
		end
	end
end

function Perl_Target_Target_Warn_Healer_Mode()		-- This chunk of code is called in 2 places so may as well place it as it's own function
	if (UnitIsPlayer("target")) then
		if (UnitIsFriend("player", "target")) then
			if (UnitIsUnit("target", "targettargettarget")) then	-- The target and the targets target target (whew) are the same
				if (aggroWarningCount == 0) then
					if (alertsize == 0) then
						UIErrorsFrame:AddMessage(UnitName("target").." is now tanking "..UnitName("targettarget"),1,0,0,1,3);
					elseif (alertsize == 1) then
						if ((UnitName("player") == UnitName("target")) or (UnitName("target") == UnitName("targettarget"))) then
							-- Do nothing
						else
							Perl_Target_Target_BigWarning_Show(UnitName("target").." is now tanking "..UnitName("targettarget"));
						end
					elseif (alertsize == 2) then
						-- Warning disabled
					end
					aggroWarningCount = 1;
				end
			else
				-- Lazy warrior isnt tanking anything!
				aggroWarningCount = 0;
			end
		else
			if (UnitName("targettarget") == UnitName("player")) then
				-- Its coming right for us!
				if (aggroWarningCount == 0) then
					if (alertsize == 0) then
						UIErrorsFrame:AddMessage(UnitName("target").." has changed targets to you!",1,0,0,1,3);
					elseif (alertsize == 1) then
						Perl_Target_Target_BigWarning_Show(UnitName("target").." has changed targets to you!");
					elseif (alertsize == 2) then
						-- Warning disabled
					end
					aggroWarningCount = 1;
					Perl_Target_Target_Play_Sound();
				end
			else
				-- Whew it isnt fighting us
				aggroWarningCount = 0;
			end
		end
	else
		if (UnitName("targettarget") == UnitName("player")) then
			-- Its coming right for us!
			if (aggroWarningCount == 0) then
				if (alertsize == 0) then
					UIErrorsFrame:AddMessage(UnitName("target").." has changed targets to you!",1,0,0,1,3);
				elseif (alertsize == 1) then
					Perl_Target_Target_BigWarning_Show(UnitName("target").." has changed targets to you!");
				elseif (alertsize == 2) then
					-- Warning disabled
				end
				aggroWarningCount = 1;
				Perl_Target_Target_Play_Sound();
			end
		else
			-- Whew it isnt fighting us
			aggroWarningCount = 0;
		end
	end
end

function Perl_Target_Target_Play_Sound()
	if (alertsound == 1) then
		PlaySoundFile("Sound\\Spells\\PVPFlagTakenHorde.wav");
	end
end


-------------------------
-- Mouseover Functions --
-------------------------
-- Target of Target Start
function Perl_Target_Target_HealthShow()
	local targettargethealth = UnitHealth("targettarget");
	local targettargethealthmax = UnitHealthMax("targettarget");

	if (UnitIsDead("targettarget") or UnitIsGhost("targettarget")) then				-- This prevents negative health
		targettargethealth = 0;
		targettargethealthpercent = 0;
	end

	if (targettargethealthmax == 100) then
		-- Begin Mobhealth support
		if (mobhealthsupport == 1) then
			if (MobHealthFrame) then

				local index;
				if UnitIsPlayer("targettarget") then
					index = UnitName("targettarget");
				else
					index = UnitName("targettarget")..":"..UnitLevel("targettarget");
				end

				if ((MobHealthDB and MobHealthDB[index]) or (MobHealthPlayerDB and MobHealthPlayerDB[index])) then
					local s, e;
					local pts;
					local pct;

					if MobHealthDB[index] then
						if (type(MobHealthDB[index]) ~= "string") then
							Perl_Target_Target_HealthBarText:SetText(targettargethealth.."%");
						end
						s, e, pts, pct = string.find(MobHealthDB[index], "^(%d+)/(%d+)$");
					else
						if (type(MobHealthPlayerDB[index]) ~= "string") then
							Perl_Target_Target_HealthBarText:SetText(targettargethealth.."%");
						end
						s, e, pts, pct = string.find(MobHealthPlayerDB[index], "^(%d+)/(%d+)$");
					end

					if (pts and pct) then
						pts = pts + 0;
						pct = pct + 0;
						if (pct ~= 0) then
							pointsPerPct = pts / pct;
						else
							pointsPerPct = 0;
						end
					end

					local currentPct = UnitHealth("targettarget");
					if (pointsPerPct > 0) then
						Perl_Target_Target_HealthBarText:SetText(string.format("%d", (currentPct * pointsPerPct) + 0.5).."/"..string.format("%d", (100 * pointsPerPct) + 0.5));	-- Stored unit info from the DB
					end
				else
					Perl_Target_Target_HealthBarText:SetText(targettargethealth.."%");	-- Unit not in MobHealth DB
				end
			-- End MobHealth Support
			else
				Perl_Target_Target_HealthBarText:SetText(targettargethealth.."%");	-- MobHealth isn't installed
			end
		else	-- mobhealthsupport == 0
			Perl_Target_Target_HealthBarText:SetText(targettargethealth.."%");	-- MobHealth support is disabled
		end
	else
		Perl_Target_Target_HealthBarText:SetText(targettargethealth.."/"..targettargethealthmax);	-- Self/Party/Raid member
	end

	mouseovertargettargethealthflag = 1;
end

function Perl_Target_Target_HealthHide()
	local targettargethealthpercent = floor(UnitHealth("targettarget")/UnitHealthMax("targettarget")*100+0.5);

	if (UnitIsDead("targettarget") or UnitIsGhost("targettarget")) then				-- This prevents negative health
		targettargethealthpercent = 0;
	end

	Perl_Target_Target_HealthBarText:SetText(targettargethealthpercent.."%");
	mouseovertargettargethealthflag = 0;
end

function Perl_Target_Target_ManaShow()
	local targettargetmana = UnitMana("targettarget");
	local targettargetmanamax = UnitManaMax("targettarget");

	if (UnitIsDead("targettarget") or UnitIsGhost("targettarget")) then				-- This prevents negative mana
		targettargetmana = 0;
	end

	if (UnitPowerType("targettarget") == 1) then
		Perl_Target_Target_ManaBarText:SetText(targettargetmana);
	else
		Perl_Target_Target_ManaBarText:SetText(targettargetmana.."/"..targettargetmanamax);
	end
	Perl_Target_Target_ManaBarText:Show();
	mouseovertargettargetmanaflag = 1;
end

function Perl_Target_Target_ManaHide()
	Perl_Target_Target_ManaBarText:Hide();
	mouseovertargettargetmanaflag = 0;
end
-- Target of Target End

-- Target of Target of Target Start
function Perl_Target_Target_Target_HealthShow()
	local targettargettargethealth = UnitHealth("targettargettarget");
	local targettargettargethealthmax = UnitHealthMax("targettargettarget");

	if (UnitIsDead("targettargettarget") or UnitIsGhost("targettargettarget")) then				-- This prevents negative health
		targettargettargethealth = 0;
		targettargettargethealthpercent = 0;
	end

	if (targettargettargethealthmax == 100) then
		-- Begin Mobhealth support
		if (mobhealthsupport == 1) then
			if (MobHealthFrame) then

				local index;
				if UnitIsPlayer("targettargettarget") then
					index = UnitName("targettargettarget");
				else
					index = UnitName("targettargettarget")..":"..UnitLevel("targettargettarget");
				end

				if ((MobHealthDB and MobHealthDB[index]) or (MobHealthPlayerDB and MobHealthPlayerDB[index])) then
					local s, e;
					local pts;
					local pct;

					if MobHealthDB[index] then
						if (type(MobHealthDB[index]) ~= "string") then
							Perl_Target_Target_Target_HealthBarText:SetText(targettargettargethealth.."%");
						end
						s, e, pts, pct = string.find(MobHealthDB[index], "^(%d+)/(%d+)$");
					else
						if (type(MobHealthPlayerDB[index]) ~= "string") then
							Perl_Target_Target_Target_HealthBarText:SetText(targettargettargethealth.."%");
						end
						s, e, pts, pct = string.find(MobHealthPlayerDB[index], "^(%d+)/(%d+)$");
					end

					if (pts and pct) then
						pts = pts + 0;
						pct = pct + 0;
						if (pct ~= 0) then
							pointsPerPct = pts / pct;
						else
							pointsPerPct = 0;
						end
					end

					local currentPct = UnitHealth("targettargettarget");
					if (pointsPerPct > 0) then
						Perl_Target_Target_Target_HealthBarText:SetText(string.format("%d", (currentPct * pointsPerPct) + 0.5).."/"..string.format("%d", (100 * pointsPerPct) + 0.5));	-- Stored unit info from the DB
					end
				else
					Perl_Target_Target_Target_HealthBarText:SetText(targettargettargethealth.."%");	-- Unit not in MobHealth DB
				end
			-- End MobHealth Support
			else
				Perl_Target_Target_Target_HealthBarText:SetText(targettargettargethealth.."%");	-- MobHealth isn't installed
			end
		else	-- mobhealthsupport == 0
			Perl_Target_Target_Target_HealthBarText:SetText(targettargettargethealth.."%");	-- MobHealth support is disabled
		end
	else
		Perl_Target_Target_Target_HealthBarText:SetText(targettargettargethealth.."/"..targettargettargethealthmax);	-- Self/Party/Raid member
	end

	mouseovertargettargettargethealthflag = 1;
end

function Perl_Target_Target_Target_HealthHide()
	local targettargettargethealthpercent = floor(UnitHealth("targettargettarget")/UnitHealthMax("targettargettarget")*100+0.5);

	if (UnitIsDead("targettargettarget") or UnitIsGhost("targettargettarget")) then				-- This prevents negative health
		targettargettargethealthpercent = 0;
	end

	Perl_Target_Target_Target_HealthBarText:SetText(targettargettargethealthpercent.."%");
	mouseovertargettargettargethealthflag = 0;
end

function Perl_Target_Target_Target_ManaShow()
	local targettargettargetmana = UnitMana("targettargettarget");
	local targettargettargetmanamax = UnitManaMax("targettargettarget");

	if (UnitIsDead("targettargettarget") or UnitIsGhost("targettargettarget")) then				-- This prevents negative mana
		targettargettargetmana = 0;
	end

	if (UnitPowerType("targettargettarget") == 1) then
		Perl_Target_Target_Target_ManaBarText:SetText(targettargettargetmana);
	else
		Perl_Target_Target_Target_ManaBarText:SetText(targettargettargetmana.."/"..targettargettargetmanamax);
	end
	Perl_Target_Target_Target_ManaBarText:Show();
	mouseovertargettargettargetmanaflag = 1;
end

function Perl_Target_Target_Target_ManaHide()
	Perl_Target_Target_Target_ManaBarText:Hide();
	mouseovertargettargettargetmanaflag = 0;
end
-- Target of Target of Target End


--------------------------
-- GUI Config Functions --
--------------------------
function Perl_Target_Target_Set_ToT(newvalue)
	totsupport = newvalue;
	Perl_Target_Target_UpdateVars();
end

function Perl_Target_Target_Set_ToToT(newvalue)
	tototsupport = newvalue;
	Perl_Target_Target_UpdateVars();
end

function Perl_Target_Target_Set_Mode(newvalue)
	alertmode = newvalue;
	Perl_Target_Target_UpdateVars();
end

function Perl_Target_Target_Set_Sound_Alert(newvalue)
	alertsound = newvalue;
	Perl_Target_Target_UpdateVars();
end

function Perl_Target_Target_Set_Alert_Size(newvalue)
	alertsize = newvalue;
	Perl_Target_Target_UpdateVars();
end

function Perl_Target_Target_Set_MobHealth(newvalue)
	mobhealthsupport = newvalue;
	Perl_Target_Target_UpdateVars();
end

function Perl_Target_Target_Set_Lock(newvalue)
	locked = newvalue;
	Perl_Target_Target_UpdateVars();
end

function Perl_Target_Target_Set_Scale(number)
	local unsavedscale;
	if (number ~= nil) then
		scale = (number / 100);					-- convert the user input to a wow acceptable value
		--DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Target of Target Display is now scaled to |cffffffff"..floor(scale * 100 + 0.5).."%|cffffff00.");	-- only display if the user gave us a number
	end
	unsavedscale = 1 - UIParent:GetEffectiveScale() + scale;	-- run it through the scaling formula introduced in 1.9
	Perl_Target_Target_Frame:SetScale(unsavedscale);
	Perl_Target_Target_Target_Frame:SetScale(unsavedscale);
	Perl_Target_Target_UpdateVars();
end

function Perl_Target_Target_Set_Transparency(number)
	if (number ~= nil) then
		transparency = (number / 100);				-- convert the user input to a wow acceptable value
	end
	Perl_Target_Target_Frame:SetAlpha(transparency);
	Perl_Target_Target_Target_Frame:SetAlpha(transparency);
	Perl_Target_Target_UpdateVars();
end

function Perl_Target_Target_Allign(button)
	if (Perl_Target_Frame) then
		local vartable = Perl_Target_GetVars();			-- Get the target frame settings

		Perl_Target_Target_Frame:SetUserPlaced(1);		-- This makes wow remember the changes if the frames have never been moved before
		Perl_Target_Target_Target_Frame:SetUserPlaced(1);

		if (button == 1) then
			if (vartable["showportrait"] == 1) then
				if (vartable["showcp"] == 1 or vartable["comboframedebuffs"] == 1) then
					Perl_Target_Target_Frame:SetPoint("TOPLEFT", Perl_Target_PortraitFrame, "TOPRIGHT", 17, 0);
					Perl_Target_Target_Target_Frame:SetPoint("TOPLEFT", Perl_Target_Target_Frame, "TOPRIGHT", -4, 0);
				else
					Perl_Target_Target_Frame:SetPoint("TOPLEFT", Perl_Target_PortraitFrame, "TOPRIGHT", -4, 0);
					Perl_Target_Target_Target_Frame:SetPoint("TOPLEFT", Perl_Target_Target_Frame, "TOPRIGHT", -4, 0);
				end
			else
				if (vartable["showcp"] == 1 or vartable["comboframedebuffs"] == 1) then
					Perl_Target_Target_Frame:SetPoint("TOPLEFT", Perl_Target_LevelFrame, "TOPRIGHT", 17, 0);
					Perl_Target_Target_Target_Frame:SetPoint("TOPLEFT", Perl_Target_Target_Frame, "TOPRIGHT", -4, 0);
				else
					Perl_Target_Target_Frame:SetPoint("TOPLEFT", Perl_Target_LevelFrame, "TOPRIGHT", -4, 0);
					Perl_Target_Target_Target_Frame:SetPoint("TOPLEFT", Perl_Target_Target_Frame, "TOPRIGHT", -4, 0);
				end
			end
		elseif (button == 2) then
			if (vartable["showclassframe"] == 1 or vartable["showrareeliteframe"] == 1) then
				Perl_Target_Target_Frame:SetPoint("TOPLEFT", Perl_Target_NameFrame, "TOPLEFT", 0, 77);
				Perl_Target_Target_Target_Frame:SetPoint("TOPLEFT", Perl_Target_Target_Frame, "TOPRIGHT", 1, 0);
			else
				Perl_Target_Target_Frame:SetPoint("TOPLEFT", Perl_Target_NameFrame, "TOPLEFT", 0, 57);
				Perl_Target_Target_Target_Frame:SetPoint("TOPLEFT", Perl_Target_Target_Frame, "TOPRIGHT", 1, 0);
			end
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("This feature is disabled due to Perl_Target not being installed/enabled.");
	end
end


------------------------------
-- Saved Variable Functions --
------------------------------
function Perl_Target_Target_GetVars()
	locked = Perl_Target_Target_Config[UnitName("player")]["Locked"];
	mobhealthsupport = Perl_Target_Target_Config[UnitName("player")]["MobHealthSupport"];
	scale = Perl_Target_Target_Config[UnitName("player")]["Scale"];
	totsupport = Perl_Target_Target_Config[UnitName("player")]["ToTSupport"];
	tototsupport = Perl_Target_Target_Config[UnitName("player")]["ToToTSupport"];
	transparency = Perl_Target_Target_Config[UnitName("player")]["Transparency"];
	alertsound = Perl_Target_Target_Config[UnitName("player")]["AlertSound"];
	alertmode = Perl_Target_Target_Config[UnitName("player")]["AlertMode"];
	alertsize = Perl_Target_Target_Config[UnitName("player")]["AlertSize"];

	if (locked == nil) then
		locked = 0;
	end
	if (mobhealthsupport == nil) then
		mobhealthsupport = 1;
	end
	if (scale == nil) then
		scale = 1;
	end
	if (totsupport == nil) then
		totsupport = 1;
	end
	if (tototsupport == nil) then
		tototsupport = 1;
	end
	if (transparency == nil) then
		transparency = 1;
	end
	if (alertsound == nil) then
		alertsound = 0;
	end
	if (alertmode == nil) then
		alertmode = 0;
	end
	if (alertsize == nil) then
		alertsize = 0;
	end

	local vars = {
		["locked"] = locked,
		["mobhealthsupport"] = mobhealthsupport,
		["scale"] = scale,
		["totsupport"] = totsupport,
		["tototsupport"] = tototsupport,
		["transparency"] = transparency,
		["alertsound"] = alertsound,
		["alertmode"] = alertmode,
		["alertsize"] = alertsize,
	}
	return vars;
end

function Perl_Target_Target_UpdateVars(vartable)
	if (vartable ~= nil) then
		-- Sanity checks in case you use a load from an old version
		if (vartable["Global Settings"] ~= nil) then
			if (vartable["Global Settings"]["Locked"] ~= nil) then
				locked = vartable["Global Settings"]["Locked"];
			else
				locked = nil;
			end
			if (vartable["Global Settings"]["MobHealthSupport"] ~= nil) then
				mobhealthsupport = vartable["Global Settings"]["MobHealthSupport"];
			else
				mobhealthsupport = nil;
			end
			if (vartable["Global Settings"]["Scale"] ~= nil) then
				scale = vartable["Global Settings"]["Scale"];
			else
				scale = nil;
			end
			if (vartable["Global Settings"]["ToTSupport"] ~= nil) then
				totsupport = vartable["Global Settings"]["ToTSupport"];
			else
				totsupport = nil;
			end
			if (vartable["Global Settings"]["ToToTSupport"] ~= nil) then
				tototsupport = vartable["Global Settings"]["ToToTSupport"];
			else
				tototsupport = nil;
			end
			if (vartable["Global Settings"]["Transparency"] ~= nil) then
				transparency = vartable["Global Settings"]["Transparency"];
			else
				transparency = nil;
			end
			if (vartable["Global Settings"]["AlertSound"] ~= nil) then
				alertsound = vartable["Global Settings"]["AlertSound"];
			else
				alertsound = nil;
			end
			if (vartable["Global Settings"]["AlertMode"] ~= nil) then
				alertmode = vartable["Global Settings"]["AlertMode"];
			else
				alertmode = nil;
			end
			if (vartable["Global Settings"]["AlertSize"] ~= nil) then
				alertsize = vartable["Global Settings"]["AlertSize"];
			else
				alertsize = nil;
			end
		end

		-- Set the new values if any new values were found, same defaults as above
		if (locked == nil) then
			locked = 0;
		end
		if (mobhealthsupport == nil) then
			mobhealthsupport = 1;
		end
		if (scale == nil) then
			scale = 1;
		end
		if (totsupport == nil) then
			totsupport = 1;
		end
		if (tototsupport == nil) then
			tototsupport = 1;
		end
		if (transparency == nil) then
			transparency = 1;
		end
		if (alertsound == nil) then
			alertsound = 0;
		end
		if (alertmode == nil) then
			alertmode = 0;
		end
		if (alertsize == nil) then
			alertsize = 0;
		end

		-- Call any code we need to activate them
		Perl_Target_Target_Set_Scale();
		Perl_Target_Target_Set_Transparency();
	end

	Perl_Target_Target_Config[UnitName("player")] = {
		["Locked"] = locked,
		["MobHealthSupport"] = mobhealthsupport,
		["Scale"] = scale,
		["ToTSupport"] = totsupport,
		["ToToTSupport"] = tototsupport,
		["Transparency"] = transparency,
		["AlertSound"] = alertsound,
		["AlertMode"] = alertmode,
		["AlertSize"] = alertsize,
	};
end


--------------------
-- Click Handlers --
--------------------
-- Target of Target Start
function Perl_TargetTargetDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, Perl_TargetTargetDropDown_Initialize, "MENU");
end

function Perl_TargetTargetDropDown_Initialize()
	local menu = nil;
	if (UnitIsEnemy("targettarget", "player")) then
		return;
	end
	if (UnitIsUnit("targettarget", "player")) then
		menu = "SELF";
	elseif (UnitIsUnit("targettarget", "pet")) then
		menu = "PET";
	elseif (UnitIsPlayer("targettarget")) then
		if (UnitInParty("targettarget")) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	end
	if (menu) then
		UnitPopup_ShowMenu(Perl_Target_Target_DropDown, menu, "targettarget");
	end
end

function Perl_Target_Target_MouseClick(button)
	if (SpellIsTargeting() and button == "RightButton") then
		SpellStopTargeting();
		return;
	end

	if (button == "LeftButton") then
		if (SpellIsTargeting()) then
			SpellTargetUnit("targettarget");
		elseif (CursorHasItem()) then
			DropItemOnUnit("targettarget");
		else
			TargetUnit("targettarget");
		end
	end
end

function Perl_Target_Target_MouseDown(button)
	if (button == "LeftButton" and locked == 0) then
		Perl_Target_Target_Frame:StartMoving();
	end
end

function Perl_Target_Target_MouseUp(button)
	if (button == "RightButton") then
		if (not (IsAltKeyDown() or IsControlKeyDown() or IsShiftKeyDown())) then		-- if alt, ctrl, or shift ARE NOT held, show the menu
			ToggleDropDownMenu(1, nil, Perl_Target_Target_DropDown, "Perl_Target_Target_NameFrame", 40, 0);
		end
	end

	Perl_Target_Target_Frame:StopMovingOrSizing();
end
-- Target of Target End

-- Target of Target of Target Start
function Perl_TargetTargetTargetDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, Perl_TargetTargetTargetDropDown_Initialize, "MENU");
end

function Perl_TargetTargetTargetDropDown_Initialize()
	local menu = nil;
	if (UnitIsEnemy("targettargettarget", "player")) then
		return;
	end
	if (UnitIsUnit("targettargettarget", "player")) then
		menu = "SELF";
	elseif (UnitIsUnit("targettargettarget", "pet")) then
		menu = "PET";
	elseif (UnitIsPlayer("targettargettarget")) then
		if (UnitInParty("targettargettarget")) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	end
	if (menu) then
		UnitPopup_ShowMenu(Perl_Target_Target_Target_DropDown, menu, "targettargettarget");
	end
end

function Perl_Target_Target_Target_MouseClick(button)
	if (SpellIsTargeting() and button == "RightButton") then
		SpellStopTargeting();
		return;
	end

	if (button == "LeftButton") then
		if (SpellIsTargeting()) then
			SpellTargetUnit("targettargettarget");
		elseif (CursorHasItem()) then
			DropItemOnUnit("targettargettarget");
		else
			TargetUnit("targettargettarget");
		end
	end
end

function Perl_Target_Target_Target_MouseDown(button)
	if (button == "LeftButton" and locked == 0) then
		Perl_Target_Target_Target_Frame:StartMoving();
	end
end

function Perl_Target_Target_Target_MouseUp(button)
	if (button == "RightButton") then
		if (not (IsAltKeyDown() or IsControlKeyDown() or IsShiftKeyDown())) then		-- if alt, ctrl, or shift ARE NOT held, show the menu
			ToggleDropDownMenu(1, nil, Perl_Target_Target_Target_DropDown, "Perl_Target_Target_Target_NameFrame", 40, 0);
		end
	end

	Perl_Target_Target_Target_Frame:StopMovingOrSizing();
end
-- Target of Target of Target End


----------------------------
-- Big Warning Text Frame --
----------------------------
-- Fade in/out frame stuff
-- Ripped/modified from FadingFrame from Blizzard
-- Ripped from AggroAlert 1.5

function Perl_Target_Target_BigWarning_OnLoad()
	Perl_Target_Target_BigWarning:Hide();
end

function Perl_Target_Target_BigWarning_Show(message)
	startTime = GetTime();
	if (message) then
		Perl_Target_Target_BigWarning_Text:SetText(message);
	end
	Perl_Target_Target_BigWarning:Show();
end


function Perl_Target_Target_BigWarning_OnUpdate()
	local elapsed = GetTime() - startTime;
	local fadeInTime = 0.2;
	if (elapsed < fadeInTime) then
		local alpha = (elapsed / fadeInTime);
		Perl_Target_Target_BigWarning:SetAlpha(alpha);
		return;
	end
	local holdTime = 2.5;
	if (elapsed < (fadeInTime + holdTime)) then
		Perl_Target_Target_BigWarning:SetAlpha(1.0);
		return;
	end
	local fadeOutTime = 2;
	if (elapsed < (fadeInTime + holdTime + fadeOutTime)) then
		local alpha = 1.0 - ((elapsed - holdTime - fadeInTime) / fadeOutTime);
		Perl_Target_Target_BigWarning:SetAlpha(alpha);
		return;
	end
	Perl_Target_Target_BigWarning:Hide();
end


-------------
-- Tooltip --
-------------
function Perl_Target_Target_Tip()
	UnitFrame_Initialize("targettarget")
end

function Perl_Target_Target_Target_Tip()
	UnitFrame_Initialize("targettargettarget")
end

function UnitFrame_Initialize(unit)	-- Hopefully this doesn't break any mods
	this.unit = unit;
end


----------------------
-- myAddOns Support --
----------------------
function Perl_Target_Target_myAddOns_Support()
	-- Register the addon in myAddOns
	if (myAddOnsFrame_Register) then
		local Perl_Target_Target_myAddOns_Details = {
			name = "Perl_Target_Target",
			version = "Version 0.58",
			releaseDate = "April 15, 2006",
			author = "Global",
			email = "global@g-ball.com",
			website = "http://www.curse-gaming.com/mod.php?addid=2257",
			category = MYADDONS_CATEGORY_OTHERS
		};
		Perl_Target_Target_myAddOns_Help = {};
		Perl_Target_Target_myAddOns_Help[1] = "/perl";
		myAddOnsFrame_Register(Perl_Target_Target_myAddOns_Details, Perl_Target_Target_myAddOns_Help);
	end
end