---------------
-- Variables --
---------------
Perl_CombatDisplay_Config = {};

-- Default Saved Variables (also set in Perl_CombatDisplay_GetVars)
local state = 3;		-- hidden unless in combat by default
local manapersist = 0;		-- mana persist is off by default
local healthpersist = 0;	-- health persist is off by default
local locked = 0;		-- unlocked by default
local scale = 1;		-- default scale
local transparency = 1;		-- transparency for the frame
local showtarget = 0;		-- target frame is disabled by default
local mobhealthsupport = 1;	-- mobhealth is enabled by default
local showdruidbar = 1;		-- Druid Bar support is enabled by default
local showpetbars = 0;		-- Pet info is hidden by default

-- Default Local Variables
local IsAggroed = 0;
local InCombat = 0;
local Initialized = nil;
local healthfull = 0;
local manafull = 0;


----------------------
-- Loading Function --
----------------------
function Perl_CombatDisplay_OnLoad()
	-- Events
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("PLAYER_ENTER_COMBAT");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVE_COMBAT");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("UNIT_DISPLAYPOWER");
	this:RegisterEvent("UNIT_ENERGY");
	this:RegisterEvent("UNIT_FOCUS");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_MANA");
	this:RegisterEvent("UNIT_MAXENERGY");
	this:RegisterEvent("UNIT_MAXFOCUS");
	this:RegisterEvent("UNIT_MAXHEALTH");
	this:RegisterEvent("UNIT_MAXMANA");
	this:RegisterEvent("UNIT_MAXRAGE");
	this:RegisterEvent("UNIT_PET");
	this:RegisterEvent("UNIT_RAGE");
	this:RegisterEvent("VARIABLES_LOADED");

	-- Button Click Overlays (in order of occurrence in XML)
	Perl_CombatDisplay_ManaFrame_CastClickOverlay:SetFrameLevel(Perl_CombatDisplay_ManaFrame:GetFrameLevel() + 2);

	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Perl Classic: CombatDisplay loaded successfully.");
	end
end

function Perl_CombatDisplay_Target_OnLoad()
	-- Button Click Overlays (in order of occurrence in XML)
	Perl_CombatDisplay_Target_ManaFrame_CastClickOverlay:SetFrameLevel(Perl_CombatDisplay_Target_ManaFrame:GetFrameLevel() + 2);
end


-------------------
-- Event Handler --
-------------------
function Perl_CombatDisplay_OnEvent(event)
	if (event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH") then
		if (arg1 == "player") then
			if (UnitHealth("player") == UnitHealthMax("player")) then
				healthfull = 1;
				if (healthpersist == 1) then
					Perl_CombatDisplay_UpdateDisplay();
				end
			else
				healthfull = 0;
			end
			Perl_CombatDisplay_Update_Health();
		end
		if (arg1 == "pet") then
			if (showpetbars == 1) then
				Perl_CombatDisplay_Update_PetHealth();
			end
		end
		if (arg1 == "target") then
			Perl_CombatDisplay_Target_Update_Health();
		end
		return;
	elseif (event == "UNIT_ENERGY" or event == "UNIT_MAXENERGY") then
		if (arg1 == "player") then
			if (UnitMana("player") == UnitManaMax("player")) then
				manafull = 1;
				if (manapersist == 1) then
					Perl_CombatDisplay_UpdateDisplay();
				end
			else
				manafull = 0;
			end
			Perl_CombatDisplay_Update_Mana();
		end
		if (arg1 == "target") then
			Perl_CombatDisplay_Target_Update_Mana();
		end
		return;
	elseif (event == "UNIT_MANA" or event == "UNIT_MAXMANA") then
		if (arg1 == "player") then
			if (UnitMana("player") == UnitManaMax("player")) then
				manafull = 1;
				if (manapersist == 1) then
					Perl_CombatDisplay_UpdateDisplay();
				end
			else
				manafull = 0;
			end
			Perl_CombatDisplay_Update_Mana();
		end
		if (arg1 == "pet") then
			if (showpetbars == 1) then
				Perl_CombatDisplay_Update_PetMana();
			end
		end
		if (arg1 == "target") then
			Perl_CombatDisplay_Target_Update_Mana();
		end
		return;
	elseif (event == "UNIT_RAGE" or event == "UNIT_MAXRAGE") then
		if (arg1 == "player") then
			if (UnitMana("player") == 0) then
				manafull = 1;
				if (manapersist == 1) then
					Perl_CombatDisplay_UpdateDisplay();
				end
			else
				manafull = 0;
			end
			Perl_CombatDisplay_Update_Mana();
		end
		if (arg1 == "target") then
			Perl_CombatDisplay_Target_Update_Mana();
		end
		return;
	elseif (event == "UNIT_FOCUS" or event == "UNIT_MAXFOCUS") then
		if (arg1 == "pet") then
			if (showpetbars == 1) then
				Perl_CombatDisplay_Update_PetMana();
			end
		end
	elseif (event == "PLAYER_TARGET_CHANGED") then
		Perl_CombatDisplay_UpdateDisplay();
		return;
	elseif (event == "PLAYER_COMBO_POINTS") then
		Perl_CombatDisplay_Update_Combo_Points();
		return;
	elseif (event == "PLAYER_REGEN_ENABLED") then	-- Player no longer in combat (something has agro on you)
		IsAggroed = 0;
		if (state == 3) then
			Perl_CombatDisplay_UpdateDisplay();
		end
		return;
	elseif (event == "PLAYER_REGEN_DISABLED") then	-- Player in combat (something has agro on you)
		IsAggroed = 1;
		if (state == 3) then
			Perl_CombatDisplay_UpdateDisplay();
		end
		return;
	elseif (event == "PLAYER_ENTER_COMBAT") then	-- Player attacking (auto attack)
		InCombat = 1;
		if (state == 2) then
			Perl_CombatDisplay_UpdateDisplay();
		end
		return;
	elseif (event == "PLAYER_LEAVE_COMBAT") then	-- Player not attacking (auto attack)
		InCombat = 0;
		if (state == 2) then
			Perl_CombatDisplay_UpdateDisplay();
		end
		return;
	elseif (event == "UNIT_DISPLAYPOWER") then
		if (arg1 == "player") then
			Perl_CombatDisplay_UpdateBars();
			Perl_CombatDisplay_Update_Mana();
			if (InCombat == 0 and IsAggroed == 0) then
				if (state == 1) then
					Perl_CombatDisplay_Frame:Show();
				else
					Perl_CombatDisplay_Frame:Hide();
				end
			end
		end
		if (arg1 == "pet") then
			if (showpetbars == 1) then
				Perl_CombatDisplay_Update_PetManaBarColor();	-- What type of energy are we using now?
				Perl_CombatDisplay_Update_PetMana();		-- Update the energy info immediately
			end
		end
		return;
	elseif (event == "UNIT_PET") then
		Perl_CombatDisplay_CheckForPets();
		return;
	elseif ((event == "VARIABLES_LOADED") or (event=="PLAYER_ENTERING_WORLD")) then
		local powertype = UnitPowerType("player");
		InCombat = 0;
		IsAggroed = 0;

		if (UnitHealth("player") == UnitHealthMax("player")) then
			healthfull = 1;
		else
			healthfull = 0;
		end
		if (powertype == 0 or powertype == 3) then
			if (UnitMana("player") == UnitManaMax("player")) then
				manafull = 1;
			else
				manafull = 0;
			end
		elseif (powertype == 1) then
			if (UnitMana("player") == 0) then
				manafull = 1;
			else
				manafull = 0;
			end
		end

		-- Check if we loaded the mod already.
		if (Initialized) then
			Perl_CombatDisplay_UpdateBars();	-- what class are we? display the right color bars
			Perl_CombatDisplay_Update_Health();	-- make sure we dont display 0/0 on load
			Perl_CombatDisplay_Update_Mana();	-- make sure we dont display 0/0 on load
			Perl_CombatDisplay_UpdateDisplay();	-- what mode are we in?
			Perl_CombatDisplay_Set_Scale();		-- set the correct scale
			Perl_CombatDisplay_Set_Transparency();	-- set the transparency
			Perl_CombatDisplay_CheckForPets();	-- do we have a pet out?
		else
			Perl_CombatDisplay_Initialize();
		end
		return;
	elseif (event == "ADDON_LOADED") then
		if (arg1 == "Perl_CombatDisplay") then
			Perl_CombatDisplay_myAddOns_Support();
		end
		return;
	else
		return;
	end
end


-------------------------------
-- Loading Settings Function --
-------------------------------
function Perl_CombatDisplay_Initialize()
	-- Check if a previous exists, if not, enable by default.
	if (type(Perl_CombatDisplay_Config[UnitName("player")]) == "table") then
		Perl_CombatDisplay_GetVars();
	else
		Perl_CombatDisplay_UpdateVars();
	end

	-- Major config options.
	Perl_CombatDisplay_Initialize_Frame_Color();
	Perl_CombatDisplay_Target_Frame:Hide();

	Perl_CombatDisplay_UpdateBars();	-- Display the bars appropriate to your class
	Perl_CombatDisplay_UpdateDisplay();	-- Show or hide the window based on whats happening
	Perl_CombatDisplay_CheckForPets();	-- do we have a pet out?

	Initialized = 1;
end

function Perl_CombatDisplay_Initialize_Frame_Color()
	Perl_CombatDisplay_ManaFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_CombatDisplay_ManaFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_CombatDisplay_HealthBarText:SetTextColor(1, 1, 1, 1);
	Perl_CombatDisplay_ManaBarText:SetTextColor(1, 1, 1, 1);
	Perl_CombatDisplay_CPBarText:SetTextColor(1, 1, 1, 1);
	Perl_CombatDisplay_PetHealthBarText:SetTextColor(1, 1, 1, 1);
	Perl_CombatDisplay_PetManaBarText:SetTextColor(1, 1, 1, 1);

	Perl_CombatDisplay_Target_ManaFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_CombatDisplay_Target_ManaFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_CombatDisplay_Target_HealthBarText:SetTextColor(1, 1, 1, 1);
	Perl_CombatDisplay_Target_ManaBarText:SetTextColor(1, 1, 1, 1);
end


----------------------
-- Update Functions --
----------------------
function Perl_CombatDisplay_UpdateDisplay()
	if (state == 0) then
		Perl_CombatDisplay_Frame:Hide();
		Perl_CombatDisplay_Target_Frame:Hide();
		Perl_CombatDisplay_Frame:StopMovingOrSizing();
		Perl_CombatDisplay_Target_Frame:StopMovingOrSizing();
	elseif (state == 1) then
		Perl_CombatDisplay_Frame:Show();
		Perl_CombatDisplay_Target_Show();
	elseif (state == 2) then
		if (InCombat == 1) then
			Perl_CombatDisplay_Frame:Show();
			Perl_CombatDisplay_Target_Show();
		elseif (manapersist == 1 and manafull == 0) then
			Perl_CombatDisplay_Frame:Show();
			Perl_CombatDisplay_Target_Show();
		elseif (healthpersist == 1 and healthfull == 0) then
			Perl_CombatDisplay_Frame:Show();
			Perl_CombatDisplay_Target_Show();
		else
			Perl_CombatDisplay_Frame:Hide();
			Perl_CombatDisplay_Target_Frame:Hide();
			Perl_CombatDisplay_Frame:StopMovingOrSizing();
			Perl_CombatDisplay_Target_Frame:StopMovingOrSizing();
		end
	elseif (state == 3) then
		if (IsAggroed == 1) then
			Perl_CombatDisplay_Frame:Show();
			Perl_CombatDisplay_Target_Show();
		elseif (manapersist == 1 and manafull == 0) then
			Perl_CombatDisplay_Frame:Show();
			Perl_CombatDisplay_Target_Show();
		elseif (healthpersist == 1 and healthfull == 0) then
			Perl_CombatDisplay_Frame:Show();
			Perl_CombatDisplay_Target_Show();
		else
			Perl_CombatDisplay_Frame:Hide();
			Perl_CombatDisplay_Target_Frame:Hide();
			Perl_CombatDisplay_Frame:StopMovingOrSizing();
			Perl_CombatDisplay_Target_Frame:StopMovingOrSizing();
		end
	end
end

function Perl_CombatDisplay_Update_Health()
	local playerhealth = UnitHealth("player");
	local playerhealthmax = UnitHealthMax("player");

	if (UnitIsDead("player") or UnitIsGhost("player")) then				-- This prevents negative health
		playerhealth = 0;
	end

	if (PCUF_COLORHEALTH == 1) then
		local playerhealthpercent = floor(playerhealth/playerhealthmax*100+0.5);
		if ((playerhealthpercent <= 100) and (playerhealthpercent > 75)) then
			Perl_CombatDisplay_HealthBar:SetStatusBarColor(0, 0.8, 0);
			Perl_CombatDisplay_HealthBarBG:SetStatusBarColor(0, 0.8, 0, 0.25);
		elseif ((playerhealthpercent <= 75) and (playerhealthpercent > 50)) then
			Perl_CombatDisplay_HealthBar:SetStatusBarColor(1, 1, 0);
			Perl_CombatDisplay_HealthBarBG:SetStatusBarColor(1, 1, 0, 0.25);
		elseif ((playerhealthpercent <= 50) and (playerhealthpercent > 25)) then
			Perl_CombatDisplay_HealthBar:SetStatusBarColor(1, 0.5, 0);
			Perl_CombatDisplay_HealthBarBG:SetStatusBarColor(1, 0.5, 0, 0.25);
		else
			Perl_CombatDisplay_HealthBar:SetStatusBarColor(1, 0, 0);
			Perl_CombatDisplay_HealthBarBG:SetStatusBarColor(1, 0, 0, 0.25);
		end
	else
		Perl_CombatDisplay_HealthBar:SetStatusBarColor(0, 0.8, 0);
		Perl_CombatDisplay_HealthBarBG:SetStatusBarColor(0, 0.8, 0, 0.25);
	end

	Perl_CombatDisplay_HealthBar:SetMinMaxValues(0, playerhealthmax);
	Perl_CombatDisplay_HealthBar:SetValue(playerhealth);
	Perl_CombatDisplay_HealthBarText:SetText(playerhealth.."/"..playerhealthmax);
end

function Perl_CombatDisplay_Update_Mana()
	local playermana = UnitMana("player");
	local playermanamax = UnitManaMax("player");
	local playerpower = UnitPowerType("player");

	if (UnitIsDead("player") or UnitIsGhost("player")) then				-- This prevents negative mana
		playermana = 0;
	end

	Perl_CombatDisplay_ManaBar:SetMinMaxValues(0, playermanamax);
	Perl_CombatDisplay_ManaBar:SetValue(playermana);

	if (playerpower == 1) then
		Perl_CombatDisplay_ManaBarText:SetText(playermana);
	else
		Perl_CombatDisplay_ManaBarText:SetText(playermana.."/"..playermanamax);
	end

	if (showdruidbar == 1) then
		if (DruidBarKey and (UnitClass("player") == PERL_LOCALIZED_DRUID)) then
			if (playerpower > 0) then
				-- Show the bars and set the text and reposition the original mana bar below the druid bar
				local playerdruidbarmana = floor(DruidBarKey.keepthemana);
				local playerdruidbarmanamax = DruidBarKey.maxmana;
				local playerdruidbarmanapercent = floor(playerdruidbarmana/playerdruidbarmanamax*100+0.5);

				if (playerdruidbarmanapercent == 100) then		-- This is to ensure the value isn't 1 or 2 mana under max when 100%
					playerdruidbarmana = playerdruidbarmanamax;
				end

				Perl_CombatDisplay_DruidBar:SetMinMaxValues(0, playerdruidbarmanamax);
				Perl_CombatDisplay_DruidBar:SetValue(playerdruidbarmana);

				-- Show the bar and adjust the stats frame
				Perl_CombatDisplay_DruidBar:Show();
				Perl_CombatDisplay_DruidBarBG:Show();
				Perl_CombatDisplay_ManaBar:SetPoint("TOP", "Perl_CombatDisplay_DruidBar", "BOTTOM", 0, -2);
				if (playerpower == 3) then
					Perl_CombatDisplay_ManaFrame:SetHeight(66);		-- Energy and Combo Points
					Perl_CombatDisplay_ManaFrame_CastClickOverlay:SetHeight(66);
				else
					Perl_CombatDisplay_ManaFrame:SetHeight(54);		-- Rage
					Perl_CombatDisplay_ManaFrame_CastClickOverlay:SetHeight(54);
				end

				-- Display the needed text
				Perl_CombatDisplay_DruidBarText:SetText(playerdruidbarmana.."/"..playerdruidbarmanamax);
			else
				-- Hide it all (bars and text)
				Perl_CombatDisplay_DruidBarText:SetText();
				Perl_CombatDisplay_DruidBar:Hide();
				Perl_CombatDisplay_DruidBarBG:Hide();
				Perl_CombatDisplay_ManaBar:SetPoint("TOP", "Perl_CombatDisplay_HealthBar", "BOTTOM", 0, -2);
				if (playerpower == 3) then
					Perl_CombatDisplay_ManaFrame:SetHeight(54);		-- Energy and Combo Points
					Perl_CombatDisplay_ManaFrame_CastClickOverlay:SetHeight(54);
				else
					Perl_CombatDisplay_ManaFrame:SetHeight(42);		-- Using mana or rage, use default height
					Perl_CombatDisplay_ManaFrame_CastClickOverlay:SetHeight(42);
				end
			end
		else
			-- Hide it all (bars and text)
			Perl_CombatDisplay_DruidBarText:SetText();
			Perl_CombatDisplay_DruidBar:Hide();
			Perl_CombatDisplay_DruidBarBG:Hide();
			Perl_CombatDisplay_ManaBar:SetPoint("TOP", "Perl_CombatDisplay_HealthBar", "BOTTOM", 0, -2);
			if (playerpower == 3) then
				Perl_CombatDisplay_ManaFrame:SetHeight(54);		-- Energy and Combo Points
				Perl_CombatDisplay_ManaFrame_CastClickOverlay:SetHeight(54);
			else
				Perl_CombatDisplay_ManaFrame:SetHeight(42);		-- Using mana or rage, use default height
				Perl_CombatDisplay_ManaFrame_CastClickOverlay:SetHeight(42);
			end
		end
	else
		-- Hide it all (bars and text)
		Perl_CombatDisplay_DruidBarText:SetText();
		Perl_CombatDisplay_DruidBar:Hide();
		Perl_CombatDisplay_DruidBarBG:Hide();
		Perl_CombatDisplay_ManaBar:SetPoint("TOP", "Perl_CombatDisplay_HealthBar", "BOTTOM", 0, -2);
		if (playerpower == 3) then
			Perl_CombatDisplay_ManaFrame:SetHeight(54);		-- Energy and Combo Points
			Perl_CombatDisplay_ManaFrame_CastClickOverlay:SetHeight(54);
		else
			Perl_CombatDisplay_ManaFrame:SetHeight(42);		-- Using mana or rage, use default height
			Perl_CombatDisplay_ManaFrame_CastClickOverlay:SetHeight(42);
		end
	end

	if (showpetbars == 1) then							-- running this check here since all the previous if's will undo it if i don't
		if (UnitExists("pet")) then
			Perl_CombatDisplay_ManaFrame:SetHeight(66);			-- health and mana/focus bar
			Perl_CombatDisplay_ManaFrame_CastClickOverlay:SetHeight(66);
		end
	end
end

function Perl_CombatDisplay_Update_Combo_Points()
	Perl_CombatDisplay_CPBarText:SetText(GetComboPoints()..'/5');
	Perl_CombatDisplay_CPBar:SetValue(GetComboPoints());
end

function Perl_CombatDisplay_UpdateBars()
	local playerpower = UnitPowerType("player");

	-- Set power type specific events and colors.
	if (playerpower == 0) then		-- mana
		Perl_CombatDisplay_ManaBar:SetStatusBarColor(0, 0, 1, 1);
		Perl_CombatDisplay_ManaBarBG:SetStatusBarColor(0, 0, 1, 0.25);
		-- Hide CP Bar
		Perl_CombatDisplay_CPBar:Hide();
		Perl_CombatDisplay_CPBarBG:Hide();
		Perl_CombatDisplay_CPBarText:Hide();
		Perl_CombatDisplay_ManaFrame:SetHeight(42);
		Perl_CombatDisplay_ManaFrame_CastClickOverlay:SetHeight(42);
		return;
	elseif (playerpower == 1) then		-- rage
		Perl_CombatDisplay_ManaBar:SetStatusBarColor(1, 0, 0, 1);
		Perl_CombatDisplay_ManaBarBG:SetStatusBarColor(1, 0, 0, 0.25);
		-- Hide CP Bar
		Perl_CombatDisplay_CPBar:Hide();
		Perl_CombatDisplay_CPBarBG:Hide();
		Perl_CombatDisplay_CPBarText:Hide();
		Perl_CombatDisplay_ManaFrame:SetHeight(42);
		Perl_CombatDisplay_ManaFrame_CastClickOverlay:SetHeight(42);
		return;
	elseif (playerpower == 3) then		-- energy
		this:RegisterEvent("PLAYER_COMBO_POINTS");
		Perl_CombatDisplay_ManaBar:SetStatusBarColor(1, 1, 0, 1);
		Perl_CombatDisplay_ManaBarBG:SetStatusBarColor(1, 1, 0, 0.25);
		-- Setup CP Bar
		Perl_CombatDisplay_CPBar:Show();
		Perl_CombatDisplay_CPBarBG:Show();
		Perl_CombatDisplay_CPBarText:Show();
		Perl_CombatDisplay_CPBarText:SetText('0/5');
		Perl_CombatDisplay_ManaFrame:SetHeight(54);
		Perl_CombatDisplay_ManaFrame_CastClickOverlay:SetHeight(54);
		Perl_CombatDisplay_CPBar:SetMinMaxValues(0,5);
		Perl_CombatDisplay_CPBar:SetValue(GetComboPoints());
		return;
	end
end

function Perl_CombatDisplay_CheckForPets()
	if (showpetbars == 1 and UnitExists("pet")) then
		Perl_CombatDisplay_PetHealthBar:Show();
		Perl_CombatDisplay_PetHealthBarBG:Show();
		Perl_CombatDisplay_PetManaBar:Show();
		Perl_CombatDisplay_PetManaBarBG:Show();
		Perl_CombatDisplay_ManaFrame:SetHeight(66);			-- health and mana/focus bar
		Perl_CombatDisplay_ManaFrame_CastClickOverlay:SetHeight(66);
		Perl_CombatDisplay_Update_PetManaBarColor();
		Perl_CombatDisplay_Update_PetHealth();
		Perl_CombatDisplay_Update_PetMana();
	else
		Perl_CombatDisplay_PetHealthBar:Hide();
		Perl_CombatDisplay_PetHealthBarBG:Hide();
		Perl_CombatDisplay_PetManaBar:Hide();
		Perl_CombatDisplay_PetManaBarBG:Hide();
		Perl_CombatDisplay_UpdateBars();
	end
end

function Perl_CombatDisplay_Update_PetManaBarColor()
	local petpower = UnitPowerType("pet");
	-- Set mana bar color
	if (petpower == 0) then			-- mana
		Perl_CombatDisplay_PetManaBar:SetStatusBarColor(0, 0, 1, 1);
		Perl_CombatDisplay_PetManaBarBG:SetStatusBarColor(0, 0, 1, 0.25);
	elseif (petpower == 2) then		-- focus
		Perl_CombatDisplay_PetManaBar:SetStatusBarColor(1, 0.5, 0, 1);
		Perl_CombatDisplay_PetManaBarBG:SetStatusBarColor(1, 0.5, 0, 0.25);
	end
end

function Perl_CombatDisplay_Update_PetHealth()
	local pethealth = UnitHealth("pet");
	local pethealthmax = UnitHealthMax("pet");

	if (UnitIsDead("pet") or UnitIsGhost("pet")) then				-- This prevents negative health
		pethealth = 0;
	end

	if (PCUF_COLORHEALTH == 1) then
		local pethealthpercent = floor(pethealth/pethealthmax*100+0.5);
		if ((pethealthpercent <= 100) and (pethealthpercent > 75)) then
			Perl_CombatDisplay_PetHealthBar:SetStatusBarColor(0, 0.8, 0);
			Perl_CombatDisplay_PetHealthBarBG:SetStatusBarColor(0, 0.8, 0, 0.25);
		elseif ((pethealthpercent <= 75) and (pethealthpercent > 50)) then
			Perl_CombatDisplay_PetHealthBar:SetStatusBarColor(1, 1, 0);
			Perl_CombatDisplay_PetHealthBarBG:SetStatusBarColor(1, 1, 0, 0.25);
		elseif ((pethealthpercent <= 50) and (pethealthpercent > 25)) then
			Perl_CombatDisplay_PetHealthBar:SetStatusBarColor(1, 0.5, 0);
			Perl_CombatDisplay_PetHealthBarBG:SetStatusBarColor(1, 0.5, 0, 0.25);
		else
			Perl_CombatDisplay_PetHealthBar:SetStatusBarColor(1, 0, 0);
			Perl_CombatDisplay_PetHealthBarBG:SetStatusBarColor(1, 0, 0, 0.25);
		end
	else
		Perl_CombatDisplay_PetHealthBar:SetStatusBarColor(0, 0.8, 0);
		Perl_CombatDisplay_PetHealthBarBG:SetStatusBarColor(0, 0.8, 0, 0.25);
	end

	Perl_CombatDisplay_PetHealthBar:SetMinMaxValues(0, pethealthmax);
	Perl_CombatDisplay_PetHealthBar:SetValue(pethealth);
	Perl_CombatDisplay_PetHealthBarText:SetText(pethealth.."/"..pethealthmax);
end

function Perl_CombatDisplay_Update_PetMana()
	local petmana = UnitMana("pet");
	local petmanamax = UnitManaMax("pet");
	local petpower = UnitPowerType("pet");

	if (UnitIsDead("pet") or UnitIsGhost("pet")) then				-- This prevents negative mana
		petmana = 0;
	end

	Perl_CombatDisplay_PetManaBar:SetMinMaxValues(0, petmanamax);
	Perl_CombatDisplay_PetManaBar:SetValue(petmana);

	if (petpower == 2) then
		Perl_CombatDisplay_PetManaBarText:SetText(petmana);
	else
		Perl_CombatDisplay_PetManaBarText:SetText(petmana.."/"..petmanamax);
	end
end


-------------------------------
-- Update Functions (Target) --
-------------------------------
function Perl_CombatDisplay_Target_UpdateAll()
	if (UnitExists("target")) then
		Perl_CombatDisplay_Target_Update_Health();
		Perl_CombatDisplay_Target_Update_Mana();
		Perl_CombatDisplay_Target_UpdateBars();
	end
end

function Perl_CombatDisplay_Target_Update_Health()
	local targethealth = UnitHealth("target");
	local targethealthmax = UnitHealthMax("target");

	if (UnitIsDead("target") or UnitIsGhost("target")) then				-- This prevents negative health
		targethealth = 0;
	end

	if (PCUF_COLORHEALTH == 1) then
		local targethealthpercent = floor(targethealth/targethealthmax*100+0.5);
		if ((targethealthpercent <= 100) and (targethealthpercent > 75)) then
			Perl_CombatDisplay_Target_HealthBar:SetStatusBarColor(0, 0.8, 0);
			Perl_CombatDisplay_Target_HealthBarBG:SetStatusBarColor(0, 0.8, 0, 0.25);
		elseif ((targethealthpercent <= 75) and (targethealthpercent > 50)) then
			Perl_CombatDisplay_Target_HealthBar:SetStatusBarColor(1, 1, 0);
			Perl_CombatDisplay_Target_HealthBarBG:SetStatusBarColor(1, 1, 0, 0.25);
		elseif ((targethealthpercent <= 50) and (targethealthpercent > 25)) then
			Perl_CombatDisplay_Target_HealthBar:SetStatusBarColor(1, 0.5, 0);
			Perl_CombatDisplay_Target_HealthBarBG:SetStatusBarColor(1, 0.5, 0, 0.25);
		else
			Perl_CombatDisplay_Target_HealthBar:SetStatusBarColor(1, 0, 0);
			Perl_CombatDisplay_Target_HealthBarBG:SetStatusBarColor(1, 0, 0, 0.25);
		end
	else
		Perl_CombatDisplay_Target_HealthBar:SetStatusBarColor(0, 0.8, 0);
		Perl_CombatDisplay_Target_HealthBarBG:SetStatusBarColor(0, 0.8, 0, 0.25);
	end

	Perl_CombatDisplay_Target_HealthBar:SetMinMaxValues(0, targethealthmax);
	Perl_CombatDisplay_Target_HealthBar:SetValue(targethealth);

	if (targethealthmax == 100) then
		-- Begin Mobhealth support
		if (mobhealthsupport == 1) then
			if (MobHealthFrame) then
				local index;
				if UnitIsPlayer("target") then
					index = UnitName("target");
				else
					index = UnitName("target")..":"..UnitLevel("target");
				end

				if ((MobHealthDB and MobHealthDB[index]) or (MobHealthPlayerDB and MobHealthPlayerDB[index])) then
					local s, e;
					local pts;
					local pct;

					if MobHealthDB[index] then
						if (type(MobHealthDB[index]) ~= "string") then
							Perl_CombatDisplay_Target_HealthBarText:SetText(targethealth.."%");
						end
						s, e, pts, pct = string.find(MobHealthDB[index], "^(%d+)/(%d+)$");
					else
						if (type(MobHealthPlayerDB[index]) ~= "string") then
							Perl_CombatDisplay_Target_HealthBarText:SetText(targethealth.."%");
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

					local currentPct = UnitHealth("target");
					if (pointsPerPct > 0) then
						Perl_CombatDisplay_Target_HealthBarText:SetText(string.format("%d", (currentPct * pointsPerPct) + 0.5).."/"..string.format("%d", (100 * pointsPerPct) + 0.5).." | "..targethealth.."%");	-- Stored unit info from the DB
					end
				else
					Perl_CombatDisplay_Target_HealthBarText:SetText(targethealth.."%");	-- Unit not in MobHealth DB
				end
			-- End MobHealth Support
			else
				Perl_CombatDisplay_Target_HealthBarText:SetText(targethealth.."%");	-- MobHealth isn't installed
			end
		else	-- mobhealthsupport == 0
			Perl_CombatDisplay_Target_HealthBarText:SetText(targethealth.."%");	-- MobHealth support is disabled
		end
	else
		Perl_CombatDisplay_Target_HealthBarText:SetText(targethealth.."/"..targethealthmax);	-- Self/Party/Raid member
	end
end

function Perl_CombatDisplay_Target_Update_Mana()
	local targetmana = UnitMana("target");
	local targetmanamax = UnitManaMax("target");
	local targetpowertype = UnitPowerType("target");

	if (UnitIsDead("target") or UnitIsGhost("target")) then				-- This prevents negative mana
		targetmana = 0;
	end

	Perl_CombatDisplay_Target_ManaBar:SetMinMaxValues(0, targetmanamax);
	Perl_CombatDisplay_Target_ManaBar:SetValue(targetmana);

	if (targetpowertype == 1 or targetpowertype == 2) then
		Perl_CombatDisplay_Target_ManaBarText:SetText(targetmana);
	else
		Perl_CombatDisplay_Target_ManaBarText:SetText(targetmana.."/"..targetmanamax);
	end
end

function Perl_CombatDisplay_Target_UpdateBars()
	local targetmanamax = UnitManaMax("target");
	local targetpowertype = UnitPowerType("target");

	-- Set power type specific events and colors.
	if (targetmanamax == 0) then
		Perl_CombatDisplay_Target_ManaBar:Hide();
		Perl_CombatDisplay_Target_ManaBarBG:Hide();
		Perl_CombatDisplay_Target_ManaFrame:SetHeight(30);
		Perl_CombatDisplay_Target_ManaFrame_CastClickOverlay:SetHeight(30);
	elseif (targetpowertype == 0) then	-- mana
		Perl_CombatDisplay_Target_ManaBar:SetStatusBarColor(0, 0, 1, 1);
		Perl_CombatDisplay_Target_ManaBarBG:SetStatusBarColor(0, 0, 1, 0.25);
		Perl_CombatDisplay_Target_ManaBar:Show();
		Perl_CombatDisplay_Target_ManaBarBG:Show();
		Perl_CombatDisplay_Target_ManaFrame:SetHeight(42);
		Perl_CombatDisplay_Target_ManaFrame_CastClickOverlay:SetHeight(42);
		return;
	elseif (targetpowertype == 1) then	-- rage
		Perl_CombatDisplay_Target_ManaBar:SetStatusBarColor(1, 0, 0, 1);
		Perl_CombatDisplay_Target_ManaBarBG:SetStatusBarColor(1, 0, 0, 0.25);
		Perl_CombatDisplay_Target_ManaBar:Show();
		Perl_CombatDisplay_Target_ManaBarBG:Show();
		Perl_CombatDisplay_Target_ManaFrame:SetHeight(42);
		Perl_CombatDisplay_Target_ManaFrame_CastClickOverlay:SetHeight(42);
		return;
	elseif (targetpowertype == 2) then	-- focus
		Perl_CombatDisplay_Target_ManaBar:SetStatusBarColor(1, 0.5, 0, 1);
		Perl_CombatDisplay_Target_ManaBarBG:SetStatusBarColor(1, 0.5, 0, 0.25);
		Perl_CombatDisplay_Target_ManaBar:Show();
		Perl_CombatDisplay_Target_ManaBarBG:Show();
		Perl_CombatDisplay_Target_ManaFrame:SetHeight(42);
		Perl_CombatDisplay_Target_ManaFrame_CastClickOverlay:SetHeight(42);
		return;
	elseif (targetpowertype == 3) then	-- energy
		Perl_CombatDisplay_Target_ManaBar:SetStatusBarColor(1, 1, 0, 1);
		Perl_CombatDisplay_Target_ManaBarBG:SetStatusBarColor(1, 1, 0, 0.25);
		Perl_CombatDisplay_Target_ManaBar:Show();
		Perl_CombatDisplay_Target_ManaBarBG:Show();
		Perl_CombatDisplay_Target_ManaFrame:SetHeight(42);
		Perl_CombatDisplay_Target_ManaFrame_CastClickOverlay:SetHeight(42);
		return;
	end
end

function Perl_CombatDisplay_Target_Show()
	if (showtarget == 1) then
		if (UnitExists("target")) then
			Perl_CombatDisplay_Target_Frame:Show();
			Perl_CombatDisplay_Target_UpdateAll();
		else
			Perl_CombatDisplay_Target_Frame:Hide();
		end
	end
end


--------------------------
-- GUI Config Functions --
--------------------------
function Perl_CombatDisplay_Set_State(newvalue)
	state = newvalue;
	Perl_CombatDisplay_UpdateVars();
	Perl_CombatDisplay_UpdateDisplay();
end

function Perl_CombatDisplay_Set_Health_Persistance(newvalue)
	healthpersist = newvalue;
	Perl_CombatDisplay_UpdateVars();
	Perl_CombatDisplay_UpdateDisplay();
end

function Perl_CombatDisplay_Set_Mana_Persistance(newvalue)
	manapersist = newvalue;
	Perl_CombatDisplay_UpdateVars();
	Perl_CombatDisplay_UpdateDisplay();
end

function Perl_CombatDisplay_Set_Lock(newvalue)
	locked = newvalue;
	Perl_CombatDisplay_UpdateVars();
end

function Perl_CombatDisplay_Set_Target(newvalue)
	showtarget = newvalue;
	Perl_CombatDisplay_UpdateVars();
	if (showtarget == 0) then
		Perl_CombatDisplay_Target_Frame:Hide();
	end
	Perl_CombatDisplay_UpdateDisplay();
end

function Perl_CombatDisplay_Set_MobHealth(newvalue)
	mobhealthsupport = newvalue;
	Perl_CombatDisplay_UpdateVars();
	Perl_CombatDisplay_Target_Update_Health();
end

function Perl_CombatDisplay_Set_DruidBar(newvalue)
	showdruidbar = newvalue;
	Perl_CombatDisplay_UpdateVars();
	Perl_CombatDisplay_Update_Mana();
end

function Perl_CombatDisplay_Set_PetBars(newvalue)
	showpetbars = newvalue;
	Perl_CombatDisplay_UpdateVars();
	Perl_CombatDisplay_CheckForPets();
end

function Perl_CombatDisplay_Set_Scale(number)
	local unsavedscale;
	if (number ~= nil) then
		scale = (number / 100);					-- convert the user input to a wow acceptable value
	end
	unsavedscale = 1 - UIParent:GetEffectiveScale() + scale;	-- run it through the scaling formula introduced in 1.9
	Perl_CombatDisplay_Frame:SetScale(unsavedscale);
	Perl_CombatDisplay_Target_Frame:SetScale(unsavedscale);
	Perl_CombatDisplay_UpdateVars();
end

function Perl_CombatDisplay_Set_Transparency(number)
	if (number ~= nil) then
		transparency = (number / 100);				-- convert the user input to a wow acceptable value
	end
	Perl_CombatDisplay_Frame:SetAlpha(transparency);
	Perl_CombatDisplay_Target_Frame:SetAlpha(transparency);
	Perl_CombatDisplay_UpdateVars();
end


------------------------------
-- Saved Variable Functions --
------------------------------
function Perl_CombatDisplay_GetVars()
	state = Perl_CombatDisplay_Config[UnitName("player")]["State"];
	locked = Perl_CombatDisplay_Config[UnitName("player")]["Locked"];
	healthpersist = Perl_CombatDisplay_Config[UnitName("player")]["HealthPersist"];
	manapersist = Perl_CombatDisplay_Config[UnitName("player")]["ManaPersist"];
	scale = Perl_CombatDisplay_Config[UnitName("player")]["Scale"];
	transparency = Perl_CombatDisplay_Config[UnitName("player")]["Transparency"];
	showtarget = Perl_CombatDisplay_Config[UnitName("player")]["ShowTarget"];
	mobhealthsupport = Perl_CombatDisplay_Config[UnitName("player")]["MobHealthSupport"];
	showdruidbar = Perl_CombatDisplay_Config[UnitName("player")]["ShowDruidBar"];
	showpetbars = Perl_CombatDisplay_Config[UnitName("player")]["ShowPetBars"];

	if (state == nil) then
		state = 3;
	end
	if (locked == nil) then
		locked = 0;
	end
	if (healthpersist == nil) then
		healthpersist = 0;
	end
	if (manapersist == nil) then
		manapersist = 0;
	end
	if (scale == nil) then
		scale = 1;
	end
	if (transparency == nil) then
		transparency = 1;
	end
	if (showtarget == nil) then
		showtarget = 0;
	end
	if (mobhealthsupport == nil) then
		mobhealthsupport = 1;
	end
	if (showdruidbar == nil) then
		showdruidbar = 1;
	end
	if (showpetbars == nil) then
		showpetbars = 0;
	end

	local vars = {
		["state"] = state,
		["manapersist"] = manapersist,
		["healthpersist"] = healthpersist,
		["locked"] = locked,
		["scale"] = scale,
		["transparency"] = transparency,
		["showtarget"] = showtarget,
		["mobhealthsupport"] = mobhealthsupport,
		["showdruidbar"] = showdruidbar,
		["showpetbars"] = showpetbars,
	}
	return vars;
end

function Perl_CombatDisplay_UpdateVars(vartable)
	if (vartable ~= nil) then
		-- Sanity checks in case you use a load from an old version
		if (vartable["Global Settings"] ~= nil) then
			if (vartable["Global Settings"]["State"] ~= nil) then
				state = vartable["Global Settings"]["State"];
			else
				state = nil;
			end
			if (vartable["Global Settings"]["Locked"] ~= nil) then
				locked = vartable["Global Settings"]["Locked"];
			else
				locked = nil;
			end
			if (vartable["Global Settings"]["HealthPersist"] ~= nil) then
				healthpersist = vartable["Global Settings"]["HealthPersist"];
			else
				healthpersist = nil;
			end
			if (vartable["Global Settings"]["ManaPersist"] ~= nil) then
				manapersist = vartable["Global Settings"]["ManaPersist"];
			else
				manapersist = nil;
			end
			if (vartable["Global Settings"]["Scale"] ~= nil) then
				scale = vartable["Global Settings"]["Scale"];
			else
				scale = nil;
			end
			if (vartable["Global Settings"]["Transparency"] ~= nil) then
				transparency = vartable["Global Settings"]["Transparency"];
			else
				transparency = nil;
			end
			if (vartable["Global Settings"]["ShowTarget"] ~= nil) then
				showtarget = vartable["Global Settings"]["ShowTarget"];
			else
				showtarget = nil;
			end
			if (vartable["Global Settings"]["MobHealthSupport"] ~= nil) then
				mobhealthsupport = vartable["Global Settings"]["MobHealthSupport"];
			else
				mobhealthsupport = nil;
			end
			if (vartable["Global Settings"]["ShowDruidBar"] ~= nil) then
				showdruidbar = vartable["Global Settings"]["ShowDruidBar"];
			else
				showdruidbar = nil;
			end
			if (vartable["Global Settings"]["ShowPetBars"] ~= nil) then
				showpetbars = vartable["Global Settings"]["ShowPetBars"];
			else
				showpetbars = nil;
			end
		end

		-- Set the new values if any new values were found, same defaults as above
		if (state == nil) then
			state = 3;
		end
		if (locked == nil) then
			locked = 0;
		end
		if (healthpersist == nil) then
			healthpersist = 0;
		end
		if (manapersist == nil) then
			manapersist = 0;
		end
		if (scale == nil) then
			scale = 1;
		end
		if (transparency == nil) then
			transparency = 1;
		end
		if (showtarget == nil) then
			showtarget = 0;
		end
		if (mobhealthsupport == nil) then
			mobhealthsupport = 1;
		end
		if (showdruidbar == nil) then
			showdruidbar = 1;
		end
		if (showpetbars == nil) then
			showpetbars = 0;
		end

		-- Call any code we need to activate them
		Perl_CombatDisplay_Set_Target(showtarget)
		Perl_CombatDisplay_Target_Update_Health();
		Perl_CombatDisplay_Set_Scale()
		Perl_CombatDisplay_Set_Transparency()
		Perl_CombatDisplay_UpdateDisplay();
	end

	Perl_CombatDisplay_Config[UnitName("player")] = {
		["State"] = state,
		["Locked"] = locked,
		["HealthPersist"] = healthpersist,
		["ManaPersist"] = manapersist,
		["Scale"] = scale,
		["Transparency"] = transparency,
		["ShowTarget"] = showtarget,
		["MobHealthSupport"] = mobhealthsupport,
		["ShowDruidBar"] = showdruidbar,
		["ShowPetBars"] = showpetbars,
	};
end


-------------------
-- Click Handler --
-------------------
function Perl_CombatDisplayDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, Perl_CombatDisplayDropDown_Initialize, "MENU");
end

function Perl_CombatDisplayDropDown_Initialize()
	UnitPopup_ShowMenu(Perl_CombatDisplay_DropDown, "SELF", "player");
end

function Perl_CombatDisplay_MouseClick(button)
	if (CastPartyConfig and PCUF_CASTPARTYSUPPORT == 1) then
		CastParty_OnClickByUnit(button, "player");
	elseif (Genesis_data and PCUF_CASTPARTYSUPPORT == 1) then
		Genesis_MouseHeal("player", button);
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

function Perl_CombatDisplay_MouseDown(button)
	if (button == "LeftButton" and locked == 0) then
		Perl_CombatDisplay_Frame:StartMoving();
	end
end

function Perl_CombatDisplay_MouseUp(button)
	if (button == "RightButton") then
		if ((CastPartyConfig or Genesis_MouseHeal) and PCUF_CASTPARTYSUPPORT == 1) then				-- cant open the menu from combatdisplay if castparty or genesis is installed
			-- Do nothing
		else
			if (not (IsAltKeyDown() or IsControlKeyDown() or IsShiftKeyDown())) then
				ToggleDropDownMenu(1, nil, Perl_CombatDisplay_DropDown, "Perl_CombatDisplay_Frame", 40, 0);
			end
		end
	end

	Perl_CombatDisplay_Frame:StopMovingOrSizing();
end


function Perl_CombatDisplayTargetDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, Perl_CombatDisplayTargetDropDown_Initialize, "MENU");
end

function Perl_CombatDisplayTargetDropDown_Initialize()
	local menu = nil;
	if (UnitIsEnemy("target", "player")) then
		return;
	end
	if (UnitIsUnit("target", "player")) then
		menu = "SELF";
	elseif (UnitIsUnit("target", "pet")) then
		menu = "PET";
	elseif (UnitIsPlayer("target")) then
		if (UnitInParty("target")) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	end
	if (menu) then
		UnitPopup_ShowMenu(Perl_CombatDisplay_Target_DropDown, menu, "target");
	end
end

function Perl_CombatDisplay_Target_MouseClick(button)
	if (CastPartyConfig and PCUF_CASTPARTYSUPPORT == 1) then
		CastParty_OnClickByUnit(button, "target");
	elseif (Genesis_data and PCUF_CASTPARTYSUPPORT == 1) then
		Genesis_MouseHeal("target", button);
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

function Perl_CombatDisplay_Target_MouseDown(button)
	if (button == "LeftButton" and locked == 0) then
		Perl_CombatDisplay_Target_Frame:StartMoving();
	end
end

function Perl_CombatDisplay_Target_MouseUp(button)
	if (button == "RightButton") then
		if ((CastPartyConfig or Genesis_data) and PCUF_CASTPARTYSUPPORT == 1) then				-- cant open the menu from combatdisplay if castparty or genesis is installed
			-- Do nothing
		else
			if (not (IsAltKeyDown() or IsControlKeyDown() or IsShiftKeyDown())) then		-- if alt, ctrl, or shift ARE NOT held, show the menu
				ToggleDropDownMenu(1, nil, Perl_CombatDisplay_Target_DropDown, "Perl_CombatDisplay_Target_Frame", 40, 0);
			end
		end
	end

	Perl_CombatDisplay_Target_Frame:StopMovingOrSizing();
end


----------------------
-- myAddOns Support --
----------------------
function Perl_CombatDisplay_myAddOns_Support()
	-- Register the addon in myAddOns
	if(myAddOnsFrame_Register) then
		local Perl_CombatDisplay_myAddOns_Details = {
			name = "Perl_CombatDisplay",
			version = "Version 0.58",
			releaseDate = "April 15, 2006",
			author = "Perl; Maintained by Global",
			email = "global@g-ball.com",
			website = "http://www.curse-gaming.com/mod.php?addid=2257",
			category = MYADDONS_CATEGORY_OTHERS
		};
		Perl_CombatDisplay_myAddOns_Help = {};
		Perl_CombatDisplay_myAddOns_Help[1] = "/perl";
		myAddOnsFrame_Register(Perl_CombatDisplay_myAddOns_Details, Perl_CombatDisplay_myAddOns_Help);
	end
end