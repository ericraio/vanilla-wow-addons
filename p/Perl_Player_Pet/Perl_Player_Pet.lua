---------------
-- Variables --
---------------
Perl_Player_Pet_Config = {};

-- Default Saved Variables (also set in Perl_Player_Pet_GetVars)
local locked = 0;			-- unlocked by default
local showxp = 0;			-- xp bar is hidden by default
local scale = 1;			-- default scale
local numpetbuffsshown = 16;		-- buff row is 16 long
local numpetdebuffsshown = 16;		-- debuff row is 16 long
local transparency = 1;			-- transparency for frames
local bufflocation = 1;			-- default buff location
local debufflocation = 2;		-- default debuff location
local buffsize = 12;			-- default buff size is 12
local debuffsize = 12;			-- default debuff size is 12
local showportrait = 0;			-- portrait is hidden by default
local threedportrait = 0;		-- 3d portraits are off by default

-- Default Local Variables
local Initialized = nil;		-- waiting to be initialized


----------------------
-- Loading Function --
----------------------
function Perl_Player_Pet_OnLoad()
	-- Events
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_PET_CHANGED");
	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("UNIT_DISPLAYPOWER");
	this:RegisterEvent("UNIT_FOCUS");
	this:RegisterEvent("UNIT_HAPPINESS");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_LEVEL");
	this:RegisterEvent("UNIT_MANA");
	this:RegisterEvent("UNIT_MAXFOCUS");
	this:RegisterEvent("UNIT_MAXHEALTH");
	this:RegisterEvent("UNIT_MAXMANA");
	this:RegisterEvent("UNIT_MODEL_CHANGED");
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("UNIT_PET");
	this:RegisterEvent("UNIT_PET_EXPERIENCE");
	this:RegisterEvent("UNIT_PORTRAIT_UPDATE");
	this:RegisterEvent("VARIABLES_LOADED");

	-- Button Click Overlays (in order of occurrence in XML)
	Perl_Player_Pet_NameFrame_CastClickOverlay:SetFrameLevel(Perl_Player_Pet_NameFrame:GetFrameLevel() + 1);
	Perl_Player_Pet_LevelFrame_CastClickOverlay:SetFrameLevel(Perl_Player_Pet_LevelFrame:GetFrameLevel() + 2);
	Perl_Player_Pet_StatsFrame_CastClickOverlay:SetFrameLevel(Perl_Player_Pet_StatsFrame:GetFrameLevel() + 2);
	Perl_Player_Pet_PortraitFrame_CastClickOverlay:SetFrameLevel(Perl_Player_Pet_PortraitFrame:GetFrameLevel() + 2);

	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Perl Classic: Player_Pet loaded successfully.");
	end
end


-------------------
-- Event Handler --
-------------------
function Perl_Player_Pet_OnEvent(event)
	if (event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH") then
		if (arg1 == "pet") then
			Perl_Player_Pet_Update_Health();	-- Update health values
		end
		return;
	elseif (event == "UNIT_FOCUS" or event == "UNIT_MANA" or event == "UNIT_MAXFOCUS" or event == "UNIT_MAXMANA") then
		if (arg1 == "pet") then
			Perl_Player_Pet_Update_Mana();		-- Update energy/mana/rage values
		end
		return;
	elseif (event == "UNIT_HAPPINESS") then
		Perl_Player_PetFrame_SetHappiness();
		return;
	elseif (event == "UNIT_NAME_UPDATE") then
		if (arg1 == "pet") then
			Perl_Player_Pet_NameBarText:SetText(UnitName("pet"));	-- Set name
		end
		return;
	elseif (event == "UNIT_AURA") then
		if (arg1 == "pet") then
			Perl_Player_Pet_Buff_UpdateAll();	-- Update the buff/debuff list
		end
		return;
	elseif (event == "UNIT_PET_EXPERIENCE") then
		if (showxp == 1) then
			Perl_Player_Pet_Update_Experience();	-- Set the experience bar info
		end
		return;
	elseif (event == "UNIT_LEVEL") then
		if (arg1 == "pet") then
			Perl_Player_Pet_LevelBarText:SetText(UnitLevel("pet"));		-- Set Level
		end
		return;
	elseif (event == "UNIT_DISPLAYPOWER") then
		if (arg1 == "pet") then
			Perl_Player_Pet_Update_Mana_Bar();	-- What type of energy are we using now?
			Perl_Player_Pet_Update_Mana();		-- Update the energy info immediately
		end
		return;
	elseif (event == "PLAYER_PET_CHANGED") then
		Perl_Player_Pet_Update_Once();
		return;
	elseif (event == "UNIT_PET") then
		if (arg1 == "player") then
			Perl_Player_Pet_Update_Once();
		end
		return;
	elseif (event == "UNIT_PORTRAIT_UPDATE" or event == "UNIT_MODEL_CHANGED") then
		if (arg1 == "pet") then
			Perl_Player_Pet_Update_Portrait();
		end
		return;
	elseif (event == "VARIABLES_LOADED") or (event == "PLAYER_ENTERING_WORLD") then
		Perl_Player_Pet_Initialize();
		Perl_Player_Pet_Set_Window_Layout();		-- Warlocks don't need the happiness frame
		Perl_Player_Pet_Update_Once();
		return;
	elseif (event == "ADDON_LOADED") then
		if (arg1 == "Perl_Player_Pet") then
			Perl_Player_Pet_myAddOns_Support();
		end
		return;
	else
		return;
	end
end


-------------------------------
-- Loading Settings Function --
-------------------------------
function Perl_Player_Pet_Initialize()
	-- Check if we loaded the mod already.
	if (Initialized) then
		Perl_Player_Pet_Set_Scale();
		return;
	end

	-- Check if a previous exists, if not, enable by default.
	if (type(Perl_Player_Pet_Config[UnitName("player")]) == "table") then
		Perl_Player_Pet_GetVars();
	else
		Perl_Player_Pet_UpdateVars();
	end

	-- Major config options.
	Perl_Player_Pet_Initialize_Frame_Color();
	Perl_Player_Pet_Reset_Buffs();			-- Set correct buff sizes

	-- Unregister the Blizzard frames via the 1.8 function
	PetFrame:UnregisterAllEvents();

	Initialized = 1;
end

function Perl_Player_Pet_Initialize_Frame_Color()
	Perl_Player_Pet_StatsFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Player_Pet_StatsFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Player_Pet_LevelFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Player_Pet_LevelFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Player_Pet_NameFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Player_Pet_NameFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Player_Pet_BuffFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Player_Pet_BuffFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Player_Pet_DebuffFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Player_Pet_DebuffFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Player_Pet_PortraitFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Player_Pet_PortraitFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);

	Perl_Player_Pet_HealthBarText:SetTextColor(1, 1, 1, 1);
	Perl_Player_Pet_ManaBarText:SetTextColor(1, 1, 1, 1);
end


-------------------------
-- The Update Function --
-------------------------
function Perl_Player_Pet_Update_Once()
	if (UnitExists("pet")) then
		Perl_Player_Pet_NameBarText:SetText(UnitName("pet"));		-- Set name
		Perl_Player_Pet_LevelBarText:SetText(UnitLevel("pet"));		-- Set Level
		Perl_Player_Pet_Update_Portrait();				-- Set the pet's portrait
		Perl_Player_Pet_Set_Scale();					-- Set the scale
		Perl_Player_Pet_Set_Transparency();				-- Set transparency
		Perl_Player_Pet_Update_Health();				-- Set health
		Perl_Player_Pet_Update_Mana();					-- Set mana values
		Perl_Player_Pet_Update_Mana_Bar();				-- Set the type of mana
		Perl_Player_PetFrame_SetHappiness();				-- Set Happiness
		Perl_Player_Pet_Buff_UpdateAll();				-- Set buff frame
		Perl_Player_Pet_Frame:Show();					-- Display the pet frame
		Perl_Player_Pet_ShowXP();					-- Are we showing the xp bar?
	else
		Perl_Player_Pet_Frame:Hide();
	end
end

function Perl_Player_Pet_Update_Health()
	local pethealth = UnitHealth("pet");
	local pethealthmax = UnitHealthMax("pet");

	if (UnitIsDead("pet") or UnitIsGhost("pet")) then				-- This prevents negative health
		pethealth = 0;
	end

	Perl_Player_Pet_HealthBar:SetMinMaxValues(0, pethealthmax);
	Perl_Player_Pet_HealthBar:SetValue(pethealth);

	if (PCUF_COLORHEALTH == 1) then
		local playerpethealthpercent = floor(pethealth/pethealthmax*100+0.5);
		if ((playerpethealthpercent <= 100) and (playerpethealthpercent > 75)) then
			Perl_Player_Pet_HealthBar:SetStatusBarColor(0, 0.8, 0);
			Perl_Player_Pet_HealthBarBG:SetStatusBarColor(0, 0.8, 0, 0.25);
		elseif ((playerpethealthpercent <= 75) and (playerpethealthpercent > 50)) then
			Perl_Player_Pet_HealthBar:SetStatusBarColor(1, 1, 0);
			Perl_Player_Pet_HealthBarBG:SetStatusBarColor(1, 1, 0, 0.25);
		elseif ((playerpethealthpercent <= 50) and (playerpethealthpercent > 25)) then
			Perl_Player_Pet_HealthBar:SetStatusBarColor(1, 0.5, 0);
			Perl_Player_Pet_HealthBarBG:SetStatusBarColor(1, 0.5, 0, 0.25);
		else
			Perl_Player_Pet_HealthBar:SetStatusBarColor(1, 0, 0);
			Perl_Player_Pet_HealthBarBG:SetStatusBarColor(1, 0, 0, 0.25);
		end
	else
		Perl_Player_Pet_HealthBar:SetStatusBarColor(0, 0.8, 0);
		Perl_Player_Pet_HealthBarBG:SetStatusBarColor(0, 0.8, 0, 0.25);
	end

	if (pethealthmax == 100) then
		Perl_Player_Pet_HealthBarText:SetText(pethealth.."%");
	else
		Perl_Player_Pet_HealthBarText:SetText(pethealth.."/"..pethealthmax);
	end
end

function Perl_Player_Pet_Update_Mana()
	local petmana = UnitMana("pet");
	local petmanamax = UnitManaMax("pet");

	if (UnitIsDead("pet") or UnitIsGhost("pet")) then				-- This prevents negative mana
		petmana = 0;
	end

	Perl_Player_Pet_ManaBar:SetMinMaxValues(0, petmanamax);
	Perl_Player_Pet_ManaBar:SetValue(petmana);

	if (UnitClass("player") == PERL_LOCALIZED_WARLOCK) then
		Perl_Player_Pet_ManaBarText:SetText(petmana.."/"..petmanamax);
	else
		Perl_Player_Pet_ManaBarText:SetText(petmana);
	end
end

function Perl_Player_Pet_Update_Mana_Bar()
	local petpower = UnitPowerType("pet");
	-- Set mana bar color
	if (petpower == 0) then
		Perl_Player_Pet_ManaBar:SetStatusBarColor(0, 0, 1, 1);
		Perl_Player_Pet_ManaBarBG:SetStatusBarColor(0, 0, 1, 0.25);
	elseif (petpower == 2) then
		Perl_Player_Pet_ManaBar:SetStatusBarColor(1, 0.5, 0, 1);
		Perl_Player_Pet_ManaBarBG:SetStatusBarColor(1, 0.5, 0, 0.25);
	end
end

function Perl_Player_PetFrame_SetHappiness()
	local happiness, damagePercentage, loyaltyRate = GetPetHappiness();

	if (happiness == 1) then
		Perl_Player_PetHappinessTexture:SetTexCoord(0.375, 0.5625, 0, 0.359375);
	elseif (happiness == 2) then
		Perl_Player_PetHappinessTexture:SetTexCoord(0.1875, 0.375, 0, 0.359375);
	elseif (happiness == 3) then
		Perl_Player_PetHappinessTexture:SetTexCoord(0, 0.1875, 0, 0.359375);
	end

	if (happiness ~= nil) then
		Perl_Player_PetHappiness.tooltip = getglobal("PET_HAPPINESS"..happiness);
		Perl_Player_PetHappiness.tooltipDamage = format(PET_DAMAGE_PERCENTAGE, damagePercentage);
		if (loyaltyRate < 0) then
			Perl_Player_PetHappiness.tooltipLoyalty = getglobal("LOSING_LOYALTY");
		elseif (loyaltyRate > 0) then
			Perl_Player_PetHappiness.tooltipLoyalty = getglobal("GAINING_LOYALTY");
		else
			Perl_Player_PetHappiness.tooltipLoyalty = nil;
		end
	end
end

function Perl_Player_Pet_ShowXP()
	if (showxp == 0) then
		Perl_Player_Pet_XPBar:Hide();
		Perl_Player_Pet_XPBarBG:Hide();
		Perl_Player_Pet_XPBarText:SetText();
		Perl_Player_Pet_StatsFrame:SetHeight(34);
		Perl_Player_Pet_StatsFrame_CastClickOverlay:SetHeight(34);
	else
		Perl_Player_Pet_XPBar:Show();
		Perl_Player_Pet_XPBarBG:Show();
		Perl_Player_Pet_StatsFrame:SetHeight(47);
		Perl_Player_Pet_StatsFrame_CastClickOverlay:SetHeight(47);
		if (UnitLevel("pet") == UnitLevel("player")) then
			Perl_Player_Pet_XPBar:Hide();
			Perl_Player_Pet_XPBarBG:Hide();
			Perl_Player_Pet_XPBarText:SetText();
			Perl_Player_Pet_StatsFrame:SetHeight(34);
			Perl_Player_Pet_StatsFrame_CastClickOverlay:SetHeight(34);
		else
			Perl_Player_Pet_Update_Experience();
		end
	end
end

function Perl_Player_Pet_Update_Experience()
	-- XP Bar stuff
	local playerpetxp, playerpetxpmax;
	playerpetxp, playerpetxpmax = GetPetExperience();

	Perl_Player_Pet_XPBar:SetMinMaxValues(0, playerpetxpmax);
	Perl_Player_Pet_XPBar:SetValue(playerpetxp);

	-- Set xp text
	local xptext = playerpetxp.."/"..playerpetxpmax;

	Perl_Player_Pet_XPBar:SetStatusBarColor(0, 0.6, 0.6, 1);
	Perl_Player_Pet_XPBarBG:SetStatusBarColor(0, 0.6, 0.6, 0.25);
	Perl_Player_Pet_XPBarText:SetText(xptext);
end

function Perl_Player_Pet_Update_Portrait()
	if (showportrait == 1) then
		local level = Perl_Player_Pet_PortraitFrame:GetFrameLevel();					-- Get the frame level of the main portrait frame
		Perl_Player_Pet_PortraitFrame:Show();								-- Show the main portrait frame

		if (threedportrait == 0) then
			SetPortraitTexture(Perl_Player_Pet_Portrait, "pet");					-- Load the correct 2d graphic
			Perl_Player_Pet_PortraitFrame_PetModel:Hide();					-- Hide the 3d graphic
			Perl_Player_Pet_Portrait:Show();							-- Show the 2d graphic
		else
			if UnitIsVisible("pet") then
				Perl_Player_Pet_PortraitFrame_PetModel:SetUnit("pet");			-- Load the correct 3d graphic
				Perl_Player_Pet_Portrait:Hide();						-- Hide the 2d graphic
				Perl_Player_Pet_PortraitFrame_PetModel:Show();				-- Show the 3d graphic
				Perl_Player_Pet_PortraitFrame_PetModel:SetCamera(0);
			else
				SetPortraitTexture(Perl_Player_Pet_Portrait, "pet");				-- Load the correct 2d graphic
				Perl_Player_Pet_PortraitFrame_PetModel:Hide();				-- Hide the 3d graphic
				Perl_Player_Pet_Portrait:Show();						-- Show the 2d graphic
			end
		end

	else
		Perl_Player_Pet_PortraitFrame:Hide();								-- Hide the frame and 2d/3d portion
	end
end

function Perl_Player_Pet_Set_Window_Layout()
	if (UnitClass("player") == PERL_LOCALIZED_WARLOCK) then
		Perl_Player_Pet_LevelFrame:Hide();
		Perl_Player_Pet_StatsFrame:SetPoint("TOPLEFT", "Perl_Player_Pet_NameFrame", "BOTTOMLEFT", 0, 5);
		Perl_Player_Pet_StatsFrame:SetWidth(165);
		Perl_Player_Pet_HealthBar:SetWidth(153);
		Perl_Player_Pet_HealthBarBG:SetWidth(153);
		Perl_Player_Pet_ManaBar:SetWidth(153);
		Perl_Player_Pet_ManaBarBG:SetWidth(153);
		Perl_Player_Pet_XPBar:SetWidth(153);
		Perl_Player_Pet_XPBarBG:SetWidth(153);
	else
		Perl_Player_Pet_LevelFrame:Show();
		Perl_Player_Pet_StatsFrame:SetPoint("TOPLEFT", "Perl_Player_Pet_NameFrame", "BOTTOMLEFT", 25, 5);
		Perl_Player_Pet_StatsFrame:SetWidth(140);
		Perl_Player_Pet_HealthBar:SetWidth(128);
		Perl_Player_Pet_HealthBarBG:SetWidth(128);
		Perl_Player_Pet_ManaBar:SetWidth(128);
		Perl_Player_Pet_ManaBarBG:SetWidth(128);
		Perl_Player_Pet_XPBar:SetWidth(128);
		Perl_Player_Pet_XPBarBG:SetWidth(128);
	end
end


--------------------------
-- GUI Config Functions --
--------------------------
function Perl_Player_Pet_Set_Buffs(newbuffnumber)
	if (newbuffnumber == nil) then
		newbuffnumber = 16;
	end
	numpetbuffsshown = newbuffnumber;
	Perl_Player_Pet_UpdateVars();
	Perl_Player_Pet_Reset_Buffs();		-- Reset the buff icons and set the size
	Perl_Player_Pet_Buff_UpdateAll();	-- Repopulate the buff icons
end

function Perl_Player_Pet_Set_Debuffs(newdebuffnumber)
	if (newdebuffnumber == nil) then
		newdebuffnumber = 16;
	end
	numpetdebuffsshown = newdebuffnumber;
	Perl_Player_Pet_UpdateVars();
	Perl_Player_Pet_Reset_Buffs();		-- Reset the buff icons and set the size
	Perl_Player_Pet_Buff_UpdateAll();	-- Repopulate the buff icons
end

function Perl_Player_Pet_Set_Buff_Location(newvalue)
	if (newvalue ~= nil) then
		bufflocation = newvalue;
	end
	Perl_Player_Pet_UpdateVars();
	Perl_Player_Pet_Reset_Buffs();		-- Reset the buff icons and set the size
	Perl_Player_Pet_Buff_UpdateAll();	-- Repopulate the buff icons
end

function Perl_Player_Pet_Set_Debuff_Location(newvalue)
	if (newvalue ~= nil) then
		debufflocation = newvalue;
	end
	Perl_Player_Pet_UpdateVars();
	Perl_Player_Pet_Reset_Buffs();		-- Reset the buff icons and set the size
	Perl_Player_Pet_Buff_UpdateAll();	-- Repopulate the buff icons
end

function Perl_Player_Pet_Set_Buff_Size(newvalue)
	if (newvalue ~= nil) then
		buffsize = newvalue;
	end
	Perl_Player_Pet_UpdateVars();
	Perl_Player_Pet_Reset_Buffs();		-- Reset the buff icons and set the size
	Perl_Player_Pet_Buff_UpdateAll();	-- Repopulate the buff icons
end

function Perl_Player_Pet_Set_Debuff_Size(newvalue)
	if (newvalue ~= nil) then
		debuffsize = newvalue;
	end
	Perl_Player_Pet_UpdateVars();
	Perl_Player_Pet_Reset_Buffs();		-- Reset the buff icons and set the size
	Perl_Player_Pet_Buff_UpdateAll();	-- Repopulate the buff icons
end

function Perl_Player_Pet_Set_ShowXP(newvalue)
	showxp = newvalue;
	Perl_Player_Pet_UpdateVars();
	Perl_Player_Pet_ShowXP();
end

function Perl_Player_Pet_Set_Lock(newvalue)
	locked = newvalue;
	Perl_Player_Pet_UpdateVars();
end

function Perl_Player_Pet_Set_Portrait(newvalue)
	showportrait = newvalue;
	Perl_Player_Pet_UpdateVars();
	Perl_Player_Pet_Update_Portrait();
end

function Perl_Player_Pet_Set_3D_Portrait(newvalue)
	threedportrait = newvalue;
	Perl_Player_Pet_UpdateVars();
	Perl_Player_Pet_Update_Portrait();
end

function Perl_Player_Pet_Set_Scale(number)
	local unsavedscale;
	if (number ~= nil) then
		scale = (number / 100);					-- convert the user input to a wow acceptable value
	end
	unsavedscale = 1 - UIParent:GetEffectiveScale() + scale;	-- run it through the scaling formula introduced in 1.9
	Perl_Player_Pet_Frame:SetScale(unsavedscale);
	Perl_Player_Pet_UpdateVars();
end

function Perl_Player_Pet_Set_Transparency(number)
	if (number ~= nil) then
		transparency = (number / 100);				-- convert the user input to a wow acceptable value
	end
	Perl_Player_Pet_Frame:SetAlpha(transparency);
	Perl_Player_Pet_UpdateVars();
end


------------------------------
-- Saved Variable Functions --
------------------------------
function Perl_Player_Pet_GetVars()
	locked = Perl_Player_Pet_Config[UnitName("player")]["Locked"];
	showxp = Perl_Player_Pet_Config[UnitName("player")]["ShowXP"];
	scale = Perl_Player_Pet_Config[UnitName("player")]["Scale"];
	numpetbuffsshown = Perl_Player_Pet_Config[UnitName("player")]["Buffs"];
	numpetdebuffsshown = Perl_Player_Pet_Config[UnitName("player")]["Debuffs"];
	transparency = Perl_Player_Pet_Config[UnitName("player")]["Transparency"];
	bufflocation = Perl_Player_Pet_Config[UnitName("player")]["BuffLocation"];
	debufflocation = Perl_Player_Pet_Config[UnitName("player")]["DebuffLocation"];
	buffsize = Perl_Player_Pet_Config[UnitName("player")]["BuffSize"];
	debuffsize = Perl_Player_Pet_Config[UnitName("player")]["DebuffSize"];
	showportrait = Perl_Player_Pet_Config[UnitName("player")]["ShowPortrait"];
	threedportrait = Perl_Player_Pet_Config[UnitName("player")]["ThreeDPortrait"];

	if (locked == nil) then
		locked = 0;
	end
	if (showxp == nil) then
		showxp = 0;
	end
	if (scale == nil) then
		scale = 1;
	end
	if (numpetbuffsshown == nil) then
		numpetbuffsshown = 16;
	end
	if (numpetdebuffsshown == nil) then
		numpetdebuffsshown = 16;
	end
	if (transparency == nil) then
		transparency = 1;
	end
	if (bufflocation == nil) then
		bufflocation = 1;
	end
	if (debufflocation == nil) then
		debufflocation = 2;
	end
	if (buffsize == nil) then
		buffsize = 12;
	end
	if (debuffsize == nil) then
		debuffsize = 12;
	end
	if (showportrait == nil) then
		showportrait = 0;
	end
	if (threedportrait == nil) then
		threedportrait = 0;
	end

	local vars = {
		["locked"] = locked,
		["showxp"] = showxp,
		["scale"] = scale,
		["numpetbuffsshown"] = numpetbuffsshown,
		["numpetdebuffsshown"] = numpetdebuffsshown,
		["transparency"] = transparency,
		["bufflocation"] = bufflocation,
		["debufflocation"] = debufflocation,
		["buffsize"] = buffsize,
		["debuffsize"] = debuffsize,
		["showportrait"] = showportrait,
		["threedportrait"] = threedportrait,
	}
	return vars;
end

function Perl_Player_Pet_UpdateVars(vartable)
	if (vartable ~= nil) then
		-- Sanity checks in case you use a load from an old version
		if (vartable["Global Settings"] ~= nil) then
			if (vartable["Global Settings"]["Locked"] ~= nil) then
				locked = vartable["Global Settings"]["Locked"];
			else
				locked = nil;
			end
			if (vartable["Global Settings"]["ShowXP"] ~= nil) then
				showxp = vartable["Global Settings"]["ShowXP"];
			else
				showxp = nil;
			end
			if (vartable["Global Settings"]["Scale"] ~= nil) then
				scale = vartable["Global Settings"]["Scale"];
			else
				scale = nil;
			end
			if (vartable["Global Settings"]["Buffs"] ~= nil) then
				numpetbuffsshown = vartable["Global Settings"]["Buffs"];
			else
				numpetbuffsshown = nil;
			end
			if (vartable["Global Settings"]["Debuffs"] ~= nil) then
				numpetdebuffsshown = vartable["Global Settings"]["Debuffs"];
			else
				numpetdebuffsshown = nil;
			end
			if (vartable["Global Settings"]["Transparency"] ~= nil) then
				transparency = vartable["Global Settings"]["Transparency"];
			else
				transparency = nil;
			end
			if (vartable["Global Settings"]["BuffLocation"] ~= nil) then
				bufflocation = vartable["Global Settings"]["BuffLocation"];
			else
				bufflocation = nil;
			end
			if (vartable["Global Settings"]["DebuffLocation"] ~= nil) then
				debufflocation = vartable["Global Settings"]["DebuffLocation"];
			else
				debufflocation = nil;
			end
			if (vartable["Global Settings"]["BuffSize"] ~= nil) then
				buffsize = vartable["Global Settings"]["BuffSize"];
			else
				buffsize = nil;
			end
			if (vartable["Global Settings"]["DebuffSize"] ~= nil) then
				debuffsize = vartable["Global Settings"]["DebuffSize"];
			else
				debuffsize = nil;
			end
			if (vartable["Global Settings"]["ShowPortrait"] ~= nil) then
				showportrait = vartable["Global Settings"]["ShowPortrait"];
			else
				showportrait = nil;
			end
			if (vartable["Global Settings"]["ThreeDPortrait"] ~= nil) then
				threedportrait = vartable["Global Settings"]["ThreeDPortrait"];
			else
				threedportrait = nil;
			end
		end

		-- Set the new values if any new values were found, same defaults as above
		if (locked == nil) then
			locked = 0;
		end
		if (showxp == nil) then
			showxp = 0;
		end
		if (scale == nil) then
			scale = 1;
		end
		if (numpetbuffsshown == nil) then
			numpetbuffsshown = 16;
		end
		if (numpetdebuffsshown == nil) then
			numpetdebuffsshown = 16;
		end
		if (transparency == nil) then
			transparency = 1;
		end
		if (bufflocation == nil) then
			bufflocation = 1;
		end
		if (debufflocation == nil) then
			debufflocation = 2;
		end
		if (buffsize == nil) then
			buffsize = 12;
		end
		if (debuffsize == nil) then
			debuffsize = 12;
		end
		if (showportrait == nil) then
			showportrait = 0;
		end
		if (threedportrait == nil) then
			threedportrait = 0;
		end

		-- Call any code we need to activate them
		Perl_Player_Pet_Reset_Buffs();		-- Reset the buff icons
		Perl_Player_Pet_Buff_UpdateAll();	-- Repopulate the buff icons
		Perl_Player_Pet_Update_Health();	-- Update the health in case progrssive health color was set
		Perl_Player_Pet_Update_Portrait();
		Perl_Player_Pet_Set_Scale();		-- Set the scale
		Perl_Player_Pet_Set_Transparency();	-- Set the transparency
	end

	Perl_Player_Pet_Config[UnitName("player")] = {
		["Locked"] = locked,
		["ShowXP"] = showxp,
		["Scale"] = scale,
		["Buffs"] = numpetbuffsshown,
		["Debuffs"] = numpetdebuffsshown,
		["Transparency"] = transparency,
		["BuffLocation"] = bufflocation,
		["DebuffLocation"] = debufflocation,
		["BuffSize"] = buffsize,
		["DebuffSize"] = debuffsize,
		["ShowPortrait"] = showportrait,
		["ThreeDPortrait"] = threedportrait,
	};
end


--------------------
-- Buff Functions --
--------------------
function Perl_Player_Pet_Buff_UpdateAll()
	if (UnitName("pet")) then
		local buffmax = 0;
		for buffnum=1,numpetbuffsshown do
			local button = getglobal("Perl_Player_Pet_Buff"..buffnum);
			local icon = getglobal(button:GetName().."Icon");
			local debuff = getglobal(button:GetName().."DebuffBorder");

			if (UnitBuff("pet", buffnum)) then
				icon:SetTexture(UnitBuff("pet", buffnum));
				button.isdebuff = 0;
				debuff:Hide();
				button:Show();
				buffmax = buffnum;
			else
				button:Hide();
			end
		end

		local debuffmax = 0;
		local debuffCount, debuffTexture, debuffApplications;
		for debuffnum=1,numpetdebuffsshown do
			debuffTexture, debuffApplications = UnitDebuff("pet", debuffnum);
			local button = getglobal("Perl_Player_Pet_Debuff"..debuffnum);
			local icon = getglobal(button:GetName().."Icon");
			local debuff = getglobal(button:GetName().."DebuffBorder");
			
			if (UnitDebuff("pet", debuffnum)) then
				icon:SetTexture(UnitDebuff("pet", debuffnum));
				button.isdebuff = 1;
				debuff:Show();
				button:Show();
				debuffCount = getglobal("Perl_Player_Pet_Debuff"..debuffnum.."Count");
				if (debuffApplications > 1) then
					debuffCount:SetText(debuffApplications);
					debuffCount:Show();
				else
					debuffCount:Hide();
				end
				debuffmax = debuffnum;
			else
				button:Hide();
			end
		end

		if (buffmax == 0) then
			Perl_Player_Pet_BuffFrame:Hide();
		else
			Perl_Player_Pet_BuffFrame:Show();
			Perl_Player_Pet_BuffFrame:SetWidth(5 + buffmax * 17);
		end

		if (debuffmax == 0) then
			Perl_Player_Pet_DebuffFrame:Hide();
		else
			Perl_Player_Pet_DebuffFrame:Show();
			Perl_Player_Pet_DebuffFrame:SetWidth(5 + debuffmax * 17);
		end

		if (bufflocation == 1) then
			Perl_Player_Pet_Buff1:SetPoint("TOPLEFT", "Perl_Player_Pet_StatsFrame", "TOPRIGHT", 0, -5);
		elseif (bufflocation == 2) then
			Perl_Player_Pet_Buff1:SetPoint("TOPLEFT", "Perl_Player_Pet_StatsFrame", "TOPRIGHT", 0, -20);
		elseif (bufflocation == 3) then
			if (UnitClass("player") == PERL_LOCALIZED_HUNTER) then
				Perl_Player_Pet_Buff1:SetPoint("TOPLEFT", "Perl_Player_Pet_StatsFrame", "BOTTOMLEFT", -20, 0);
			else
				Perl_Player_Pet_Buff1:SetPoint("TOPLEFT", "Perl_Player_Pet_LevelFrame", "BOTTOMLEFT", 5, 0);
			end
		else
			if (UnitClass("player") == PERL_LOCALIZED_HUNTER) then
				Perl_Player_Pet_Buff1:SetPoint("TOPLEFT", "Perl_Player_Pet_StatsFrame", "BOTTOMLEFT", -20, -15);
			else
				Perl_Player_Pet_Buff1:SetPoint("TOPLEFT", "Perl_Player_Pet_LevelFrame", "BOTTOMLEFT", 5, -15);
			end
		end

		if (debufflocation == 1) then
			Perl_Player_Pet_Debuff1:SetPoint("TOPLEFT", "Perl_Player_Pet_StatsFrame", "TOPRIGHT", 0, -5);
		elseif (debufflocation == 2) then
			Perl_Player_Pet_Debuff1:SetPoint("TOPLEFT", "Perl_Player_Pet_StatsFrame", "TOPRIGHT", 0, -20);
		elseif (debufflocation == 3) then
			if (UnitClass("player") == PERL_LOCALIZED_HUNTER) then
				Perl_Player_Pet_Debuff1:SetPoint("TOPLEFT", "Perl_Player_Pet_StatsFrame", "BOTTOMLEFT", -20, 0);
			else
				Perl_Player_Pet_Debuff1:SetPoint("TOPLEFT", "Perl_Player_Pet_LevelFrame", "BOTTOMLEFT", 5, 0);
			end
		else
			if (UnitClass("player") == PERL_LOCALIZED_HUNTER) then
				Perl_Player_Pet_Debuff1:SetPoint("TOPLEFT", "Perl_Player_Pet_StatsFrame", "BOTTOMLEFT", -20, 15);
			else
				Perl_Player_Pet_Debuff1:SetPoint("TOPLEFT", "Perl_Player_Pet_LevelFrame", "BOTTOMLEFT", 5, -15);
			end
		end
	end
end

function Perl_Player_Pet_Reset_Buffs()
	local button, debuff, icon;
	for buffnum=1,16 do
		button = getglobal("Perl_Player_Pet_Buff"..buffnum);
		icon = getglobal(button:GetName().."Icon");
		debuff = getglobal(button:GetName().."DebuffBorder");
		button:SetHeight(buffsize);
		button:SetWidth(buffsize);
		icon:SetHeight(buffsize);
		icon:SetWidth(buffsize);
		debuff:SetHeight(buffsize);
		debuff:SetWidth(buffsize);
		button:Hide();

		button = getglobal("Perl_Player_Pet_Debuff"..buffnum);
		icon = getglobal(button:GetName().."Icon");
		debuff = getglobal(button:GetName().."DebuffBorder");
		button:SetHeight(debuffsize);
		button:SetWidth(debuffsize);
		icon:SetHeight(debuffsize);
		icon:SetWidth(debuffsize);
		debuff:SetHeight(debuffsize);
		debuff:SetWidth(debuffsize);
		button:Hide();
	end
end

function Perl_Player_Pet_SetBuffTooltip()
	local buffmapping = 0;
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
	if (this.isdebuff == 1) then
		GameTooltip:SetUnitDebuff("pet", this:GetID()-buffmapping);
	else
		GameTooltip:SetUnitBuff("pet", this:GetID());
	end
end


--------------------
-- Click Handlers --
--------------------
function Perl_Player_Pet_DropDown_OnLoad()
	UIDropDownMenu_Initialize(this, Perl_Player_Pet_DropDown_Initialize, "MENU");
end

function Perl_Player_Pet_DropDown_Initialize()
	UnitPopup_ShowMenu(Perl_Player_Pet_DropDown, "PET", "pet");
end

function Perl_Player_Pet_MouseClick(button)
	if (CastPartyConfig and PCUF_CASTPARTYSUPPORT == 1) then
		if (not string.find(GetMouseFocus():GetName(), "Name")) then
			CastParty_OnClickByUnit(button, "pet");
		end
	elseif (Genesis_data and PCUF_CASTPARTYSUPPORT == 1) then
		if (not string.find(GetMouseFocus():GetName(), "Name")) then
			Genesis_MouseHeal("pet", button);
		end
	else
		if (SpellIsTargeting() and button == "RightButton") then
			SpellStopTargeting();
			return;
		end

		if (button == "LeftButton") then
			if (SpellIsTargeting()) then
				SpellTargetUnit("pet");
			elseif (CursorHasItem()) then
				DropItemOnUnit("pet");
			else
				TargetUnit("pet");
			end
		end
	end
end

function Perl_Player_Pet_MouseDown(button)
	if (button == "LeftButton" and locked == 0) then
		Perl_Player_Pet_Frame:StartMoving();
	end
end

function Perl_Player_Pet_MouseUp(button)
	if (button == "RightButton") then
		if ((CastPartyConfig or Genesis_data) and PCUF_CASTPARTYSUPPORT == 1) then
			if (not (IsAltKeyDown() or IsControlKeyDown() or IsShiftKeyDown()) and string.find(GetMouseFocus():GetName(), "Name")) then		-- if alt, ctrl, or shift ARE NOT held AND we are clicking the name frame, show the menu
				ToggleDropDownMenu(1, nil, Perl_Player_Pet_DropDown, "Perl_Player_Pet_NameFrame", 40, 0);
			end
		else
			if (not (IsAltKeyDown() or IsControlKeyDown() or IsShiftKeyDown())) then		-- if alt, ctrl, or shift ARE NOT held, show the menu
				ToggleDropDownMenu(1, nil, Perl_Player_Pet_DropDown, "Perl_Player_Pet_NameFrame", 40, 0);
			end
		end
	end

	Perl_Player_Pet_Frame:StopMovingOrSizing();
end


----------------------
-- myAddOns Support --
----------------------
function Perl_Player_Pet_myAddOns_Support()
	-- Register the addon in myAddOns
	if(myAddOnsFrame_Register) then
		local Perl_Player_Pet_myAddOns_Details = {
			name = "Perl_Player_Pet",
			version = "Version 0.58",
			releaseDate = "April 15, 2006",
			author = "Perl; Maintained by Global",
			email = "global@g-ball.com",
			website = "http://www.curse-gaming.com/mod.php?addid=2257",
			category = MYADDONS_CATEGORY_OTHERS
		};
		Perl_Player_Pet_myAddOns_Help = {};
		Perl_Player_Pet_myAddOns_Help[1] = "/perl";
		myAddOnsFrame_Register(Perl_Player_Pet_myAddOns_Details, Perl_Player_Pet_myAddOns_Help);
	end
end