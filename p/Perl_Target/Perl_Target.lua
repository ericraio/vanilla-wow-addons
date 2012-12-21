---------------
-- Variables --
---------------
Perl_Target_Config = {};

-- Default Saved Variables (also set in Perl_Target_GetVars)
local locked = 0;		-- unlocked by default
local showcp = 1;		-- combo points displayed by default
local showclassicon = 1;	-- show the class icon
local showclassframe = 1;	-- show the class frame
local showpvpicon = 1;		-- show the pvp icon
local numbuffsshown = 16;	-- buff row is 16 long
local numdebuffsshown = 16;	-- debuff row is 16 long
local mobhealthsupport = 1;	-- mobhealth support is on by default
local scale = 1;		-- default scale
local showpvprank = 0;		-- hide the pvp rank by default
local transparency = 1;		-- transparency for frames
local buffdebuffscale = 1;	-- default scale for buffs and debuffs
local showportrait = 0;		-- portrait is hidden by default
local threedportrait = 0;	-- 3d portraits are off by default
local portraitcombattext = 1;	-- Combat text is enabled by default on the portrait frame
local showrareeliteframe = 0;	-- rare/elite frame is hidden by default
local nameframecombopoints = 0;	-- combo points are not displayed in the name frame by default
local comboframedebuffs = 0;	-- combo point frame will not be used for debuffs by default
local framestyle = 1;		-- default frame style is "classic"
local compactmode = 0;		-- compact mode is disabled by default
local compactpercent = 0;	-- percents are not shown in compact mode by default
local hidebuffbackground = 0;	-- buff and debuff backgrounds are shown by default

-- Default Local Variables
local Initialized = nil;	-- waiting to be initialized

-- Variables for position of the class icon texture.
local Perl_Target_ClassPosRight = {};
local Perl_Target_ClassPosLeft = {};
local Perl_Target_ClassPosTop = {};
local Perl_Target_ClassPosBottom = {};


----------------------
-- Loading Function --
----------------------
function Perl_Target_OnLoad()
	-- Combat Text
	CombatFeedback_Initialize(Perl_Target_HitIndicator, 30);

	-- Events
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("PARTY_LEADER_CHANGED");
	this:RegisterEvent("PARTY_MEMBER_DISABLE");
	this:RegisterEvent("PARTY_MEMBER_ENABLE");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("PLAYER_COMBO_POINTS");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("UNIT_COMBAT");
	this:RegisterEvent("UNIT_DISPLAYPOWER");
	this:RegisterEvent("UNIT_DYNAMIC_FLAGS");
	this:RegisterEvent("UNIT_ENERGY");
	this:RegisterEvent("UNIT_FOCUS");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_LEVEL");
	this:RegisterEvent("UNIT_MANA");
	this:RegisterEvent("UNIT_MAXENERGY");
	this:RegisterEvent("UNIT_MAXFOCUS");
	this:RegisterEvent("UNIT_MAXHEALTH");
	this:RegisterEvent("UNIT_MAXMANA");
	this:RegisterEvent("UNIT_MAXRAGE");
	this:RegisterEvent("UNIT_PORTRAIT_UPDATE");
	this:RegisterEvent("UNIT_PVP_UPDATE");
	this:RegisterEvent("UNIT_RAGE");
	this:RegisterEvent("UNIT_SPELLMISS");
	this:RegisterEvent("VARIABLES_LOADED");

	-- Button Click Overlays (in order of occurrence in XML)
	Perl_Target_NameFrame_CastClickOverlay:SetFrameLevel(Perl_Target_NameFrame:GetFrameLevel() + 2);
	Perl_Target_Name:SetFrameLevel(Perl_Target_NameFrame:GetFrameLevel() + 1);
	Perl_Target_LevelFrame_CastClickOverlay:SetFrameLevel(Perl_Target_LevelFrame:GetFrameLevel() + 1);
	Perl_Target_RareEliteFrame_CastClickOverlay:SetFrameLevel(Perl_Target_RareEliteFrame:GetFrameLevel() + 1);
	Perl_Target_PortraitFrame_CastClickOverlay:SetFrameLevel(Perl_Target_PortraitFrame:GetFrameLevel() + 2);
	Perl_Target_ClassNameFrame_CastClickOverlay:SetFrameLevel(Perl_Target_ClassNameFrame:GetFrameLevel() + 1);
	Perl_Target_CivilianFrame_CastClickOverlay:SetFrameLevel(Perl_Target_CivilianFrame:GetFrameLevel() + 1);
	Perl_Target_CPFrame_CastClickOverlay:SetFrameLevel(Perl_Target_CPFrame:GetFrameLevel() + 1);
	Perl_Target_StatsFrame_CastClickOverlay:SetFrameLevel(Perl_Target_StatsFrame:GetFrameLevel() + 1);

	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Perl Classic: Target loaded successfully.");
	end
end


-------------------
-- Event Handler --
-------------------
function Perl_Target_OnEvent(event)
	if ((event == "PLAYER_TARGET_CHANGED") or (event == "PARTY_MEMBERS_CHANGED") or (event == "PARTY_LEADER_CHANGED") or (event == "PARTY_MEMBER_ENABLE") or (event == "PARTY_MEMBER_DISABLE")) then
		if (UnitExists("target")) then
			Perl_Target_Update_Once();		-- Set the unchanging info for the target
		else
			Perl_Target_Frame:Hide();		-- There is no target, hide the frame
		end
		return;
	elseif (event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH") then
		if (arg1 == "target") then
			Perl_Target_Update_Health();		-- Update health values
		end
		return;
	elseif ((event == "UNIT_ENERGY") or (event == "UNIT_MANA") or (event == "UNIT_RAGE") or (event == "UNIT_FOCUS") or (event == "UNIT_MAXMANA") or (event == "UNIT_MAXENERGY") or (event == "UNIT_MAXRAGE") or (event == "UNIT_MAXFOCUS")) then
		if (arg1 == "target") then
			Perl_Target_Update_Mana();		-- Update energy/mana/rage values
		end
		return;
	elseif (event == "UNIT_AURA") then
		if (arg1 == "target") then
			Perl_Target_Buff_UpdateAll();		-- Update the buffs
		end
		return;
	elseif (event == "UNIT_DYNAMIC_FLAGS") then
		if (arg1 == "target") then
			Perl_Target_Update_Text_Color();	-- Has the target been tapped by someone else?
		end
		return;
	elseif (event == "UNIT_COMBAT") then
		if (arg1 == "target") then
			CombatFeedback_OnCombatEvent(arg2, arg3, arg4, arg5);
		end
		return;
	elseif (event == "UNIT_SPELLMISS") then
		if (arg1 == "target") then
			CombatFeedback_OnSpellMissEvent(arg2);
		end
		return;
	elseif (event == "UNIT_PVP_UPDATE") then
		Perl_Target_Update_Text_Color();		-- Is the character PvP flagged?
		Perl_Target_Update_PvP_Status_Icon();		-- Set pvp status icon
		return;
	elseif (event == "UNIT_PORTRAIT_UPDATE") then
		if (arg1 == "target") then
			Perl_Target_Update_Portrait();
		end
		return;
	elseif (event == "UNIT_LEVEL") then
		if (arg1 == "target") then
			Perl_Target_Frame_Set_Level();		-- What level is it and is it rare/elite/boss
		end
		return;
	elseif (event == "PLAYER_COMBO_POINTS") then
		Perl_Target_Update_Combo_Points();		-- How many combo points are we at?
		return;
	elseif (event == "UNIT_DISPLAYPOWER") then
		if (arg1 == "target") then
			Perl_Target_Update_Mana_Bar();		-- What type of energy are they using now?
			Perl_Target_Update_Mana();		-- Update the energy info immediately
		end
		return;
	elseif (event == "VARIABLES_LOADED") or (event=="PLAYER_ENTERING_WORLD") then
		Perl_Target_Initialize();
		return;
	elseif (event == "ADDON_LOADED") then
		if (arg1 == "Perl_Target") then
			Perl_Target_myAddOns_Support();		-- Attempt to load MyAddOns support
		end
		return;
	else
		return;
	end
end


-------------------------------
-- Loading Settings Function --
-------------------------------
function Perl_Target_Initialize()
	if (Initialized) then
		Perl_Target_Set_Scale();
		return;
	end

	-- Check if a previous exists, if not, enable by default.
	if (type(Perl_Target_Config[UnitName("player")]) == "table") then
		Perl_Target_GetVars();
	else
		Perl_Target_UpdateVars();
	end

	-- Major config options.
	Perl_Target_Initialize_Frame_Color();
	Perl_Target_Frame_Style();
	Perl_Target_Buff_Debuff_Background();
	Perl_Target_Frame:Hide();

	Perl_Target_Set_Localized_ClassIcons();

	-- Unregister the Blizzard frames via the 1.8 function
	TargetFrame:UnregisterAllEvents();
	TargetFrameHealthBar:UnregisterAllEvents();
	TargetFrameManaBar:UnregisterAllEvents();
	ComboFrame:UnregisterAllEvents();

	Initialized = 1;
end

function Perl_Target_Initialize_Frame_Color()
	Perl_Target_StatsFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_StatsFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Target_NameFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_NameFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Target_ClassNameFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_ClassNameFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Target_CivilianFrame:SetBackdropColor(1, 1, 1, 1);
	Perl_Target_CivilianFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Target_LevelFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_LevelFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Target_BuffFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_BuffFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Target_DebuffFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_DebuffFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Target_CPFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_CPFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Target_PortraitFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_PortraitFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	Perl_Target_RareEliteFrame:SetBackdropColor(0, 0, 0, 1);
	Perl_Target_RareEliteFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);

	Perl_Target_HealthBarText:SetTextColor(1, 1, 1, 1);
	Perl_Target_ManaBarText:SetTextColor(1, 1, 1, 1);
	Perl_Target_ClassNameBarText:SetTextColor(1, 1, 1);
end


--------------------------
-- The Update Functions --
--------------------------
function Perl_Target_Update_Once()
	if (UnitExists("target")) then
		Perl_Target_Frame:Show();		-- Show frame
		Perl_Target_Set_Scale();		-- Set the scale (easier ways exist, but this is the safest)
		Perl_Target_Set_Transparency();		-- Set the transparency (fix this method along with scale)
		ComboFrame:Hide();			-- Hide default Combo Points
		Perl_Target_Update_Combo_Points();	-- Do we have any combo points (we shouldn't)
		Perl_Target_Frame_Set_Name();		-- Set the target's name
		Perl_Target_Update_Portrait();		-- Set the target's portrait and adjust the combo point frame
		Perl_Target_Update_Text_Color();	-- Has the target been tapped by someone else?
		Perl_Target_Update_Health();		-- Set the target's health
		Perl_Target_Update_Mana_Bar();		-- What type of mana bar is it?
		Perl_Target_Update_Mana();		-- Set the target's mana
		Perl_Target_Update_PvP_Status_Icon();	-- Set pvp status icon
		Perl_Target_Frame_Set_PvPRank();	-- Set the pvp rank icon
		Perl_Target_Frame_Set_Level();		-- What level is it and is it rare/elite/boss
		Perl_Target_Set_Character_Class_Icon();	-- Draw the class icon?
		Perl_Target_Set_Target_Class();		-- Set the target's class in the class frame
		Perl_Target_Buff_UpdateAll();		-- Update the buffs
	end
end

function Perl_Target_Update_Health()
	local targethealth = UnitHealth("target");
	local targethealthmax = UnitHealthMax("target");
	local targethealthpercent = floor(targethealth/targethealthmax*100+0.5);

	if (UnitIsDead("target") or UnitIsGhost("target")) then				-- This prevents negative health
		targethealth = 0;
		targethealthpercent = 0;
	end

	-- Set Dead Icon
	if (UnitIsDead("target") or UnitIsGhost("target")) then
		Perl_Target_DeadStatus:Show();
	else
		Perl_Target_DeadStatus:Hide();
	end

	Perl_Target_HealthBar:SetMinMaxValues(0, targethealthmax);
	Perl_Target_HealthBar:SetValue(targethealth);

	if (PCUF_COLORHEALTH == 1) then
		if ((targethealthpercent <= 100) and (targethealthpercent > 75)) then
			Perl_Target_HealthBar:SetStatusBarColor(0, 0.8, 0);
			Perl_Target_HealthBarBG:SetStatusBarColor(0, 0.8, 0, 0.25);
		elseif ((targethealthpercent <= 75) and (targethealthpercent > 50)) then
			Perl_Target_HealthBar:SetStatusBarColor(1, 1, 0);
			Perl_Target_HealthBarBG:SetStatusBarColor(1, 1, 0, 0.25);
		elseif ((targethealthpercent <= 50) and (targethealthpercent > 25)) then
			Perl_Target_HealthBar:SetStatusBarColor(1, 0.5, 0);
			Perl_Target_HealthBarBG:SetStatusBarColor(1, 0.5, 0, 0.25);
		else
			Perl_Target_HealthBar:SetStatusBarColor(1, 0, 0);
			Perl_Target_HealthBarBG:SetStatusBarColor(1, 0, 0, 0.25);
		end
	else
		Perl_Target_HealthBar:SetStatusBarColor(0, 0.8, 0);
		Perl_Target_HealthBarBG:SetStatusBarColor(0, 0.8, 0, 0.25);
	end

	if (targethealthmax == 100) then
		-- Begin Mobhealth support
		if (mobhealthsupport == 1) then
			if (MobHealthFrame) then
				MobHealthFrame:Hide();

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
							Perl_Target_HealthBarText:SetText(targethealth.."%");
						end
						s, e, pts, pct = string.find(MobHealthDB[index], "^(%d+)/(%d+)$");
					else
						if (type(MobHealthPlayerDB[index]) ~= "string") then
							Perl_Target_HealthBarText:SetText(targethealth.."%");
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
						-- Stored unit info from the DB
						if (framestyle == 1) then
							Perl_Target_HealthBarTextRight:SetText();							-- Hide this text in this frame style
							Perl_Target_HealthBarTextCompactPercent:SetText();						-- Hide this text in this frame style
							Perl_Target_HealthBarText:SetText(string.format("%d", (currentPct * pointsPerPct) + 0.5).."/"..string.format("%d", (100 * pointsPerPct) + 0.5).." | "..targethealth.."%");
						elseif (framestyle == 2) then
							if (compactmode == 0) then
								Perl_Target_HealthBarTextCompactPercent:SetText();					-- Hide this text in this frame style
								if (tonumber(string.format("%d", (100 * pointsPerPct) + 0.5)) > 9999) then
									Perl_Target_HealthBarText:SetText(string.format("%d", (currentPct * pointsPerPct) + 0.5).."/"..string.format("%d", (100 * pointsPerPct) + 0.5));
									Perl_Target_HealthBarTextRight:SetText(targethealth.."%");
								else
									Perl_Target_HealthBarText:SetText(targethealth.."%");
									Perl_Target_HealthBarTextRight:SetText(string.format("%d", (currentPct * pointsPerPct) + 0.5).."/"..string.format("%d", (100 * pointsPerPct) + 0.5));
								end
								
							else
								if (compactpercent == 0) then
									Perl_Target_HealthBarTextRight:SetText();					-- Hide this text in this frame style
									Perl_Target_HealthBarTextCompactPercent:SetText();				-- Hide this text in this frame style
									Perl_Target_HealthBarText:SetText(string.format("%d", (currentPct * pointsPerPct) + 0.5).."/"..string.format("%d", (100 * pointsPerPct) + 0.5));
								else
									Perl_Target_HealthBarTextRight:SetText();					-- Hide this text in this frame style
									Perl_Target_HealthBarText:SetText(string.format("%d", (currentPct * pointsPerPct) + 0.5).."/"..string.format("%d", (100 * pointsPerPct) + 0.5));
									Perl_Target_HealthBarTextCompactPercent:SetText(targethealth.."%");
								end
							end
						end
					end
				else
					-- Unit not in MobHealth DB
					if (framestyle == 1) then	-- This chunk of code is the same as the next two blocks in case you customize this
						Perl_Target_HealthBarTextRight:SetText();							-- Hide this text in this frame style
						Perl_Target_HealthBarTextCompactPercent:SetText();						-- Hide this text in this frame style
						Perl_Target_HealthBarText:SetText(targethealth.."%");
					elseif (framestyle == 2) then
						if (compactmode == 0) then
							Perl_Target_HealthBarTextCompactPercent:SetText();					-- Hide this text in this frame style
							Perl_Target_HealthBarText:SetText(targethealth.."%");
							Perl_Target_HealthBarTextRight:SetText(targethealth.."%");
						else
							if (compactpercent == 0) then
								Perl_Target_HealthBarTextRight:SetText();					-- Hide this text in this frame style
								Perl_Target_HealthBarTextCompactPercent:SetText();				-- Hide this text in this frame style
								Perl_Target_HealthBarText:SetText(targethealth.."%");
							else
								Perl_Target_HealthBarTextRight:SetText();					-- Hide this text in this frame style
								Perl_Target_HealthBarText:SetText(targethealth.."%");
								Perl_Target_HealthBarTextCompactPercent:SetText(targethealth.."%");
							end
						end
					end
				end
			-- End MobHealth Support
			else
				-- MobHealth isn't installed
				if (framestyle == 1) then
					Perl_Target_HealthBarTextRight:SetText();							-- Hide this text in this frame style
					Perl_Target_HealthBarTextCompactPercent:SetText();						-- Hide this text in this frame style
					Perl_Target_HealthBarText:SetText(targethealth.."%");
				elseif (framestyle == 2) then
					if (compactmode == 0) then
						Perl_Target_HealthBarTextCompactPercent:SetText();					-- Hide this text in this frame style
						Perl_Target_HealthBarText:SetText(targethealth.."%");
						Perl_Target_HealthBarTextRight:SetText(targethealth.."%");
					else
						if (compactpercent == 0) then
							Perl_Target_HealthBarTextRight:SetText();					-- Hide this text in this frame style
							Perl_Target_HealthBarTextCompactPercent:SetText();				-- Hide this text in this frame style
							Perl_Target_HealthBarText:SetText(targethealth.."%");
						else
							Perl_Target_HealthBarTextRight:SetText();					-- Hide this text in this frame style
							Perl_Target_HealthBarText:SetText(targethealth.."%");
							Perl_Target_HealthBarTextCompactPercent:SetText(targethealth.."%");
						end
					end
				end
			end
		else	-- mobhealthsupport == 0
			if (MobHealthFrame) then
				MobHealthFrame:Show();
			end

			-- MobHealth support is disabled
			if (framestyle == 1) then
				Perl_Target_HealthBarTextRight:SetText();							-- Hide this text in this frame style
				Perl_Target_HealthBarTextCompactPercent:SetText();						-- Hide this text in this frame style
				Perl_Target_HealthBarText:SetText(targethealth.."%");
			elseif (framestyle == 2) then
				if (compactmode == 0) then
					Perl_Target_HealthBarTextCompactPercent:SetText();					-- Hide this text in this frame style
					Perl_Target_HealthBarText:SetText(targethealth.."%");
					Perl_Target_HealthBarTextRight:SetText(targethealth.."%");
				else
					if (compactpercent == 0) then
						Perl_Target_HealthBarTextRight:SetText();					-- Hide this text in this frame style
						Perl_Target_HealthBarTextCompactPercent:SetText();				-- Hide this text in this frame style
						Perl_Target_HealthBarText:SetText(targethealth.."%");
					else
						Perl_Target_HealthBarTextRight:SetText();					-- Hide this text in this frame style
						Perl_Target_HealthBarText:SetText(targethealth.."%");
						Perl_Target_HealthBarTextCompactPercent:SetText(targethealth.."%");
					end
				end
			end
		end
	else
		-- Self/Party/Raid member
		if (framestyle == 1) then
			Perl_Target_HealthBarTextRight:SetText();							-- Hide this text in this frame style
			Perl_Target_HealthBarTextCompactPercent:SetText();						-- Hide this text in this frame style
			Perl_Target_HealthBarText:SetText(targethealth.."/"..targethealthmax);
		elseif (framestyle == 2) then
			if (compactmode == 0) then
				Perl_Target_HealthBarTextCompactPercent:SetText();					-- Hide this text in this frame style
				Perl_Target_HealthBarText:SetText(targethealthpercent.."%");
				Perl_Target_HealthBarTextRight:SetText(targethealth.."/"..targethealthmax);
			else
				if (compactpercent == 0) then
					Perl_Target_HealthBarTextRight:SetText();					-- Hide this text in this frame style
					Perl_Target_HealthBarTextCompactPercent:SetText();				-- Hide this text in this frame style
					Perl_Target_HealthBarText:SetText(targethealth.."/"..targethealthmax);
				else
					Perl_Target_HealthBarTextRight:SetText();					-- Hide this text in this frame style
					Perl_Target_HealthBarText:SetText(targethealth.."/"..targethealthmax);
					Perl_Target_HealthBarTextCompactPercent:SetText(targethealthpercent.."%");
				end
			end
		end
	end
end

function Perl_Target_Update_Mana()
	local targetmana = UnitMana("target");
	local targetmanamax = UnitManaMax("target");
	local targetpower = UnitPowerType("target");

	if (UnitIsDead("target") or UnitIsGhost("target")) then				-- This prevents negative mana
		targetmana = 0;
	end

	Perl_Target_ManaBar:SetMinMaxValues(0, targetmanamax);
	Perl_Target_ManaBar:SetValue(targetmana);

	if (framestyle == 1) then
		Perl_Target_ManaBarTextRight:SetText();			-- Hide this text in this frame style
		Perl_Target_ManaBarTextCompactPercent:SetText();	-- Hide this text in this frame style

		if (targetpower == 1 or targetpower == 2) then
			Perl_Target_ManaBarText:SetText(targetmana);
		else
			Perl_Target_ManaBarText:SetText(targetmana.."/"..targetmanamax);
		end
	elseif (framestyle == 2) then
		local targetmanapercent = floor(targetmana/targetmanamax*100+0.5);

		if (compactmode == 0) then
			Perl_Target_ManaBarTextCompactPercent:SetText();	-- Hide this text in this frame style

			if (targetpower == 1 or targetpower == 2) then
				Perl_Target_ManaBarText:SetText(targetmana.."%");
				Perl_Target_ManaBarTextRight:SetText(targetmana);
			else
				Perl_Target_ManaBarText:SetText(targetmanapercent.."%");
				Perl_Target_ManaBarTextRight:SetText(targetmana.."/"..targetmanamax);
			end
		else
			if (compactpercent == 0) then
				Perl_Target_ManaBarTextRight:SetText();			-- Hide this text in this frame style
				Perl_Target_ManaBarTextCompactPercent:SetText();	-- Hide this text in this frame style

				if (targetpower == 1 or targetpower == 2) then
					Perl_Target_ManaBarText:SetText(targetmana);
				else
					Perl_Target_ManaBarText:SetText(targetmana.."/"..targetmanamax);
				end
			else
				Perl_Target_ManaBarTextRight:SetText();			-- Hide this text in this frame style

				if (targetpower == 1 or targetpower == 2) then
					Perl_Target_ManaBarText:SetText(targetmana);
					Perl_Target_ManaBarTextCompactPercent:SetText(targetmana.."%");
				else
					Perl_Target_ManaBarText:SetText(targetmana.."/"..targetmanamax);
					Perl_Target_ManaBarTextCompactPercent:SetText(targetmanapercent.."%");
				end
			end
		end
	end
end

function Perl_Target_Update_Mana_Bar()
	local targetmanamax = UnitManaMax("target");
	local targetpower = UnitPowerType("target");

	-- Set mana bar color
	if (targetmanamax == 0) then
		Perl_Target_ManaBar:Hide();
		Perl_Target_ManaBarBG:Hide();
		Perl_Target_StatsFrame:SetHeight(30);
		Perl_Target_StatsFrame_CastClickOverlay:SetHeight(30);
	elseif (targetpower == 1) then
		Perl_Target_ManaBar:SetStatusBarColor(1, 0, 0, 1);
		Perl_Target_ManaBarBG:SetStatusBarColor(1, 0, 0, 0.25);
		Perl_Target_ManaBar:Show();
		Perl_Target_ManaBarBG:Show();
		Perl_Target_StatsFrame:SetHeight(42);
		Perl_Target_StatsFrame_CastClickOverlay:SetHeight(42);
	elseif (targetpower == 2) then
		Perl_Target_ManaBar:SetStatusBarColor(1, 0.5, 0, 1);
		Perl_Target_ManaBarBG:SetStatusBarColor(1, 0.5, 0, 0.25);
		Perl_Target_ManaBar:Show();
		Perl_Target_ManaBarBG:Show();
		Perl_Target_StatsFrame:SetHeight(42);
		Perl_Target_StatsFrame_CastClickOverlay:SetHeight(42);
	elseif (targetpower == 3) then
		Perl_Target_ManaBar:SetStatusBarColor(1, 1, 0, 1);
		Perl_Target_ManaBarBG:SetStatusBarColor(1, 1, 0, 0.25);
		Perl_Target_ManaBar:Show();
		Perl_Target_ManaBarBG:Show();
		Perl_Target_StatsFrame:SetHeight(42);
		Perl_Target_StatsFrame_CastClickOverlay:SetHeight(42);
	else
		Perl_Target_ManaBar:SetStatusBarColor(0, 0, 1, 1);
		Perl_Target_ManaBarBG:SetStatusBarColor(0, 0, 1, 0.25);
		Perl_Target_ManaBar:Show();
		Perl_Target_ManaBarBG:Show();
		Perl_Target_StatsFrame:SetHeight(42);
		Perl_Target_StatsFrame_CastClickOverlay:SetHeight(42);
	end
end

function Perl_Target_Update_Combo_Points()
	local combopoints = GetComboPoints();				-- How many Combo Points does the player have?
	ComboFrame:Hide();						-- Hide default Combo Points

	if (showcp == 1) then
		Perl_Target_CPText:SetText(combopoints);
		Perl_Target_CPText:SetTextHeight(20);
		if (combopoints == 5) then
			Perl_Target_CPFrame:Show();
			Perl_Target_CPText:SetTextColor(1, 0, 0);	-- red text
		elseif (combopoints == 4) then
			Perl_Target_CPFrame:Show();
			Perl_Target_CPText:SetTextColor(1, 0.5, 0);	-- orange text
		elseif (combopoints == 3) then
			Perl_Target_CPFrame:Show();
			Perl_Target_CPText:SetTextColor(1, 1, 0);	-- yellow text
		elseif (combopoints == 2) then
			Perl_Target_CPFrame:Show();
			Perl_Target_CPText:SetTextColor(0.5, 1, 0);	-- yellow-green text
		elseif (combopoints == 1) then
			Perl_Target_CPFrame:Show();
			Perl_Target_CPText:SetTextColor(0, 1, 0);	-- green text
		else
			Perl_Target_CPFrame:Hide();
		end
	else
		Perl_Target_CPFrame:Hide();
	end

	if (nameframecombopoints == 1) then				-- this isn't nested since you can have both combo point styles on at the same time
		Perl_Target_NameFrame_CPMeter:SetMinMaxValues(0, 5);
		Perl_Target_NameFrame_CPMeter:SetValue(combopoints);
		if (combopoints == 5) then
			Perl_Target_NameFrame_CPMeter:Show();
			
		elseif (combopoints == 4) then
			Perl_Target_NameFrame_CPMeter:Show();
		elseif (combopoints == 3) then
			Perl_Target_NameFrame_CPMeter:Show();
		elseif (combopoints == 2) then
			Perl_Target_NameFrame_CPMeter:Show();
		elseif (combopoints == 1) then
			Perl_Target_NameFrame_CPMeter:Show();
		else
			Perl_Target_NameFrame_CPMeter:Hide();
		end
	else
		Perl_Target_NameFrame_CPMeter:Hide();
	end
end

function Perl_Target_Update_PvP_Status_Icon()
	if (showpvpicon == 1) then
		local factionGroup = UnitFactionGroup("target");
		if (UnitIsPVPFreeForAll("target")) then
			Perl_Target_PVPStatus:SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA");
			Perl_Target_PVPStatus:Show();
		elseif (factionGroup and UnitIsPVP("target")) then
			Perl_Target_PVPStatus:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..factionGroup);
			Perl_Target_PVPStatus:Show();
		else
			Perl_Target_PVPStatus:Hide();
		end
	else
		Perl_Target_PVPStatus:Hide();
	end
end

function Perl_Target_Update_Text_Color()
	if (UnitIsPlayer("target") or UnitPlayerControlled("target")) then		-- is it a player
		local r, g, b;
		if (UnitCanAttack("target", "player")) then				-- are we in an enemy controlled zone
			-- Hostile players are red
			if (not UnitCanAttack("player", "target")) then			-- enemy is not pvp enabled
				r = 0.5;
				g = 0.5;
				b = 1.0;
			else								-- enemy is pvp enabled
				r = 1.0;
				g = 0.0;
				b = 0.0;
			end
		elseif (UnitCanAttack("player", "target")) then				-- enemy in a zone controlled by friendlies or when we're a ghost
			-- Players we can attack but which are not hostile are yellow
			r = 1.0;
			g = 1.0;
			b = 0.0;
		elseif (UnitIsPVP("target")) then					-- friendly pvp enabled character
			-- Players we can assist but are PvP flagged are green
			r = 0.0;
			g = 1.0;
			b = 0.0;
		else									-- friendly non pvp enabled character
			-- All other players are blue (the usual state on the "blue" server)
			r = 0.5;
			g = 0.5;
			b = 1.0;
		end
		Perl_Target_NameBarText:SetTextColor(r, g, b);
	elseif (UnitIsTapped("target") and not UnitIsTappedByPlayer("target")) then
		Perl_Target_NameBarText:SetTextColor(0.5,0.5,0.5);			-- not our tap
	else
		local reaction = UnitReaction("target", "player");
		if (reaction) then
			local r, g, b;
			r = UnitReactionColor[reaction].r;
			g = UnitReactionColor[reaction].g;
			b = UnitReactionColor[reaction].b;
			Perl_Target_NameBarText:SetTextColor(r, g, b);
		else
			Perl_Target_NameBarText:SetTextColor(0.5, 0.5, 1.0);
		end
	end
end

function Perl_Target_Frame_Set_Name()
	local targetname = UnitName("target");

	-- Set name
	if (framestyle == 1) then
		if (strlen(targetname) > 19) then
			targetname = strsub(targetname, 1, 18).."...";
		end
	elseif (framestyle == 2) then
		if (compactmode == 0) then
			if (strlen(targetname) > 19) then
				targetname = strsub(targetname, 1, 18).."...";
			end
		else
			if (compactpercent == 1) then
				if (strlen(targetname) > 15) then
					targetname = strsub(targetname, 1, 14).."...";
				end
			else
				if (strlen(targetname) > 11) then
					targetname = strsub(targetname, 1, 10).."...";
				end
			end
		end
	end
	
	Perl_Target_NameBarText:SetText(targetname);
end

function Perl_Target_Frame_Set_PvPRank()
	if (showpvprank == 1) then
		if (UnitIsPlayer("target")) then
			local rankNumber = UnitPVPRank("target");
			if (rankNumber == 0) then
				Perl_Target_PVPRank:Hide();
			elseif (rankNumber < 14) then
				rankNumber = rankNumber - 4;
				Perl_Target_PVPRank:SetTexture("Interface\\PvPRankBadges\\PvPRank0"..rankNumber);
				Perl_Target_PVPRank:Show();
			else
				rankNumber = rankNumber - 4;
				Perl_Target_PVPRank:SetTexture("Interface\\PvPRankBadges\\PvPRank"..rankNumber);
				Perl_Target_PVPRank:Show();
			end
		else
			Perl_Target_PVPRank:Hide();
		end
	else
		Perl_Target_PVPRank:Hide();
	end
end

function Perl_Target_Frame_Set_Level()
	local targetlevel = UnitLevel("target");			-- Get and store the level of the target
	local targetlevelcolor = GetDifficultyColor(targetlevel);	-- Get the "con color" of the target
	local targetclassification = UnitClassification("target");	-- Get the type of character the target is (rare, elite, worldboss)
	local targetclassificationframetext = nil;			-- Variable set to nil so we can easily track if target is a player or not elite

	Perl_Target_LevelBarText:SetVertexColor(targetlevelcolor.r, targetlevelcolor.g, targetlevelcolor.b);
	Perl_Target_RareEliteBarText:SetVertexColor(targetlevelcolor.r, targetlevelcolor.g, targetlevelcolor.b);

	if ((targetclassification == "worldboss") or (targetlevel < 0)) then
		Perl_Target_LevelBarText:SetTextColor(1, 0, 0);
		if (UnitIsPlayer("target")) then
			targetclassificationframetext = nil;
		else
			Perl_Target_RareEliteBarText:SetTextColor(1, 0, 0);
			targetclassificationframetext = "Boss";
		end
		targetlevel = "??";
	end

	if (targetclassification == "rareelite") then
		targetclassificationframetext = "Rare+";
		targetlevel = targetlevel.."r+";
	elseif (targetclassification == "elite") then
		targetclassificationframetext = "Elite";
		targetlevel = targetlevel.."+";
	elseif (targetclassification == "rare") then
		targetclassificationframetext = "Rare";
		targetlevel = targetlevel.."r";
	end

	Perl_Target_LevelBarText:SetText(targetlevel);							-- Set level frame text

	if (showrareeliteframe == 1) then
		if (targetclassificationframetext == nil) then
			Perl_Target_RareEliteFrame:Hide();						-- RareElite is hidden if target is a player
		else
			Perl_Target_RareEliteFrame:Show();						-- RareElite is hidden if shown if target is a npc
			Perl_Target_RareEliteBarText:SetText(targetclassificationframetext);		-- Set the text
		end
	else
		Perl_Target_RareEliteFrame:Hide();							-- RareElite is hidden if disabled
	end
end

function Perl_Target_Set_Character_Class_Icon()
	if (showclassicon == 1) then
		if (UnitIsPlayer("target")) then
			local PlayerClass = UnitClass("target");
			Perl_Target_ClassTexture:SetTexCoord(Perl_Target_ClassPosRight[PlayerClass], Perl_Target_ClassPosLeft[PlayerClass], Perl_Target_ClassPosTop[PlayerClass], Perl_Target_ClassPosBottom[PlayerClass]);
			Perl_Target_ClassTexture:Show();
		else
			Perl_Target_ClassTexture:Hide();
		end
	else
		Perl_Target_ClassTexture:Hide();
	end
end

function Perl_Target_Set_Target_Class()
	if (showclassframe == 1) then
		if (UnitIsPlayer("target")) then
			local targetClass = UnitClass("target");
			Perl_Target_ClassNameBarText:SetText(targetClass);
			Perl_Target_ClassNameFrame:Show();
			Perl_Target_CivilianFrame:Hide();
		else
			local targetCreatureType = UnitCreatureType("target");
			if (targetCreatureType == PERL_LOCALIZED_NOTSPECIFIED) then
				targetCreatureType = PERL_LOCALIZED_CREATURE;
			end
			Perl_Target_ClassNameBarText:SetText(targetCreatureType);
			Perl_Target_ClassNameFrame:Show();

			if (UnitIsCivilian("target")) then
				Perl_Target_CivilianBarText:SetText(PERL_LOCALIZED_CIVILIAN);
				Perl_Target_CivilianBarText:SetTextColor(1, 0, 0);
				Perl_Target_CivilianFrame:Show();
			else
				Perl_Target_CivilianFrame:Hide();
			end
		end
	else
		Perl_Target_ClassNameFrame:Hide();
		Perl_Target_CivilianFrame:Hide();
	end
end

function Perl_Target_Update_Portrait()
	if (showportrait == 1) then
		local level = Perl_Target_PortraitFrame:GetFrameLevel();					-- Get the frame level of the main portrait frame
		Perl_Target_PortraitTextFrame:SetFrameLevel(level + 1);						-- Put the combat text above it so the portrait graphic doesn't go on top of it

		Perl_Target_CPFrame:SetPoint("TOPLEFT", Perl_Target_PortraitFrame, "TOPRIGHT", -4, -31);	-- Reposition the combo point frame
		Perl_Target_PortraitFrame:Show();								-- Show the main portrait frame

		if (threedportrait == 0) then
			SetPortraitTexture(Perl_Target_Portrait, "target");					-- Load the correct 2d graphic
			Perl_Target_PortraitFrame_TargetModel:Hide();						-- Hide the 3d graphic
			Perl_Target_Portrait:Show();								-- Show the 2d graphic
		else
			if UnitIsVisible("target") then
				Perl_Target_PortraitFrame_TargetModel:SetUnit("target");			-- Load the correct 3d graphic
				Perl_Target_Portrait:Hide();							-- Hide the 2d graphic
				Perl_Target_PortraitFrame_TargetModel:Show();					-- Show the 3d graphic
				Perl_Target_PortraitFrame_TargetModel:SetCamera(0);
			else
				SetPortraitTexture(Perl_Target_Portrait, "target");				-- Load the correct 2d graphic
				Perl_Target_PortraitFrame_TargetModel:Hide();					-- Hide the 3d graphic
				Perl_Target_Portrait:Show();							-- Show the 2d graphic
			end
		end

		Perl_Target_PortraitTextFrame:Show();								-- Show the combat text frame
	else
		Perl_Target_CPFrame:SetPoint("TOPLEFT", Perl_Target_StatsFrame, "TOPRIGHT", -4, 0);		-- Reposition the combo point frame
		Perl_Target_PortraitFrame:Hide();								-- Hide the frame and 2d/3d portion
		Perl_Target_PortraitTextFrame:Hide();								-- Hide the combat text
	end
end

function Perl_Target_Portrait_Combat_Text()
	if (portraitcombattext == 1) then
		CombatFeedback_OnUpdate(arg1);
	end
end

function Perl_Target_Buff_Debuff_Background()
	if (hidebuffbackground == 0) then
		Perl_Target_BuffFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
		Perl_Target_DebuffFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
		Perl_Target_BuffFrame:SetBackdropColor(0, 0, 0, 1);
		Perl_Target_BuffFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
		Perl_Target_DebuffFrame:SetBackdropColor(0, 0, 0, 1);
		Perl_Target_DebuffFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	else
		Perl_Target_BuffFrame:SetBackdrop(nil);
		Perl_Target_DebuffFrame:SetBackdrop(nil);
	end
end

function Perl_Target_Frame_Style()
	Perl_Target_RareEliteFrame:SetPoint("TOPLEFT", "Perl_Target_CivilianFrame", "TOPRIGHT", -5, 0);

	if (framestyle == 1) then
		Perl_Target_HealthBar:SetWidth(200);
		Perl_Target_HealthBarBG:SetWidth(200);
		Perl_Target_ManaBar:SetWidth(200);
		Perl_Target_ManaBarBG:SetWidth(200);
		Perl_Target_HealthBar:SetPoint("TOP", "Perl_Target_StatsFrame", "TOP", 0, -10);
		Perl_Target_ManaBar:SetPoint("TOP", "Perl_Target_HealthBar", "BOTTOM", 0, -2);

		Perl_Target_CivilianFrame:SetWidth(95);
		Perl_Target_ClassNameFrame:SetWidth(90);
		Perl_Target_LevelFrame:SetWidth(46);
		Perl_Target_Name:SetWidth(180);
		Perl_Target_NameFrame:SetWidth(180);
		Perl_Target_RareEliteFrame:SetWidth(46);
		Perl_Target_StatsFrame:SetWidth(221);

		Perl_Target_NameFrame_CPMeter:SetWidth(170);

		Perl_Target_CivilianFrame_CastClickOverlay:SetWidth(95);
		Perl_Target_NameFrame_CastClickOverlay:SetWidth(180);
		Perl_Target_StatsFrame_CastClickOverlay:SetWidth(221);
	elseif (framestyle == 2) then
		Perl_Target_HealthBar:SetWidth(150);
		Perl_Target_HealthBarBG:SetWidth(150);
		Perl_Target_ManaBar:SetWidth(150);
		Perl_Target_ManaBarBG:SetWidth(150);
		Perl_Target_HealthBar:SetPoint("TOPLEFT", "Perl_Target_StatsFrame", "TOPLEFT", 10, -10);
		Perl_Target_ManaBar:SetPoint("TOP", "Perl_Target_HealthBar", "BOTTOM", 0, -2);

		if (compactmode == 0) then
			Perl_Target_CivilianFrame:SetWidth(114);
			Perl_Target_ClassNameFrame:SetWidth(90);
			Perl_Target_LevelFrame:SetWidth(46);
			Perl_Target_Name:SetWidth(199);
			Perl_Target_NameFrame:SetWidth(199);
			Perl_Target_RareEliteFrame:SetWidth(46);
			Perl_Target_StatsFrame:SetWidth(240);

			Perl_Target_NameFrame_CPMeter:SetWidth(189);

			Perl_Target_CivilianFrame_CastClickOverlay:SetWidth(114);
			Perl_Target_NameFrame_CastClickOverlay:SetWidth(199);
			Perl_Target_StatsFrame_CastClickOverlay:SetWidth(240);
		else
			if (compactpercent == 0) then
				Perl_Target_CivilianFrame:SetWidth(85);
				Perl_Target_ClassNameFrame:SetWidth(90);
				Perl_Target_LevelFrame:SetWidth(46);
				Perl_Target_Name:SetWidth(129);
				Perl_Target_NameFrame:SetWidth(129);
				Perl_Target_RareEliteFrame:SetWidth(46);
				Perl_Target_StatsFrame:SetWidth(170);
				Perl_Target_RareEliteFrame:SetPoint("TOPLEFT", "Perl_Target_CivilianFrame", "TOPRIGHT", -46, 0);

				Perl_Target_NameFrame_CPMeter:SetWidth(119);

				Perl_Target_CivilianFrame_CastClickOverlay:SetWidth(85);
				Perl_Target_NameFrame_CastClickOverlay:SetWidth(129);
				Perl_Target_StatsFrame_CastClickOverlay:SetWidth(170);
			else
				Perl_Target_CivilianFrame:SetWidth(79);
				Perl_Target_ClassNameFrame:SetWidth(90);
				Perl_Target_LevelFrame:SetWidth(46);
				Perl_Target_Name:SetWidth(164);
				Perl_Target_NameFrame:SetWidth(164);
				Perl_Target_RareEliteFrame:SetWidth(46);
				Perl_Target_StatsFrame:SetWidth(205);

				Perl_Target_NameFrame_CPMeter:SetWidth(154);

				Perl_Target_CivilianFrame_CastClickOverlay:SetWidth(79);
				Perl_Target_NameFrame_CastClickOverlay:SetWidth(164);
				Perl_Target_StatsFrame_CastClickOverlay:SetWidth(205);
			end
		end
	end
end

function Perl_Target_Set_Localized_ClassIcons()
	Perl_Target_ClassPosRight = {
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
	Perl_Target_ClassPosLeft = {
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
	Perl_Target_ClassPosTop = {
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
	Perl_Target_ClassPosBottom = {
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
function Perl_Target_Set_Buffs(newbuffnumber)
	if (newbuffnumber == nil) then
		newbuffnumber = 16;
	end
	numbuffsshown = newbuffnumber;
	Perl_Target_UpdateVars();
	Perl_Target_Reset_Buffs();	-- Reset the buff icons
	Perl_Target_Buff_UpdateAll();	-- Repopulate the buff icons
end

function Perl_Target_Set_Debuffs(newdebuffnumber)
	if (newdebuffnumber == nil) then
		newdebuffnumber = 16;
	end
	numdebuffsshown = newdebuffnumber;
	Perl_Target_UpdateVars();
	Perl_Target_Reset_Buffs();	-- Reset the buff icons
	Perl_Target_Buff_UpdateAll();	-- Repopulate the buff icons
end

function Perl_Target_Set_Class_Icon(newvalue)
	showclassicon = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_PvP_Rank_Icon(newvalue)
	showpvprank = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_PvP_Status_Icon(newvalue)
	showpvpicon = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_Class_Frame(newvalue)
	showclassframe = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_Combo_Points(newvalue)
	showcp = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_MobHealth(newvalue)
	mobhealthsupport = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_Lock(newvalue)
	locked = newvalue;
	Perl_Target_UpdateVars();
end

function Perl_Target_Set_Portrait(newvalue)
	showportrait = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_3D_Portrait(newvalue)
	threedportrait = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_Rare_Elite(newvalue)
	showrareeliteframe = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_Portrait_Combat_Text(newvalue)
	portraitcombattext = newvalue;
	Perl_Target_UpdateVars();
end

function Perl_Target_Set_Combo_Name_Frame(newvalue)
	nameframecombopoints = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_Combo_Frame_Debuffs(newvalue)
	comboframedebuffs = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_Frame_Style(newvalue)
	framestyle = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Frame_Style();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_Compact_Mode(newvalue)
	compactmode = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Frame_Style();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_Compact_Percents(newvalue)
	compactpercent = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Frame_Style();
	Perl_Target_Update_Once();
end

function Perl_Target_Set_Buff_Debuff_Background(newvalue)
	hidebuffbackground = newvalue;
	Perl_Target_UpdateVars();
	Perl_Target_Buff_Debuff_Background();
end

function Perl_Target_Set_Scale(number)
	local unsavedscale;
	if (number ~= nil) then
		scale = (number / 100);					-- convert the user input to a wow acceptable value
	end
	unsavedscale = 1 - UIParent:GetEffectiveScale() + scale;	-- run it through the scaling formula introduced in 1.9
	Perl_Target_Frame:SetScale(unsavedscale);
	Perl_Target_Set_BuffDebuff_Scale(buffdebuffscale*100);		-- maintain the buff/debuff scale
	Perl_Target_UpdateVars();
end

function Perl_Target_Set_BuffDebuff_Scale(number)
	local unsavedscale;
	if (number ~= nil) then
		buffdebuffscale = (number / 100);				-- convert the user input to a wow acceptable value
	end
	unsavedscale = 1 - UIParent:GetEffectiveScale() + buffdebuffscale;	-- run it through the scaling formula introduced in 1.9
	Perl_Target_BuffFrame:SetScale(buffdebuffscale);
	Perl_Target_DebuffFrame:SetScale(buffdebuffscale);
	Perl_Target_UpdateVars();
end

function Perl_Target_Set_Transparency(number)
	if (number ~= nil) then
		transparency = (number / 100);				-- convert the user input to a wow acceptable value
	end
	Perl_Target_Frame:SetAlpha(transparency);
	Perl_Target_UpdateVars();
end


------------------------------
-- Saved Variable Functions --
------------------------------
function Perl_Target_GetVars()
	locked = Perl_Target_Config[UnitName("player")]["Locked"];
	showcp = Perl_Target_Config[UnitName("player")]["ComboPoints"];
	showclassicon = Perl_Target_Config[UnitName("player")]["ClassIcon"];
	showclassframe = Perl_Target_Config[UnitName("player")]["ClassFrame"];
	showpvpicon = Perl_Target_Config[UnitName("player")]["PvPIcon"]; 
	numbuffsshown = Perl_Target_Config[UnitName("player")]["Buffs"];
	numdebuffsshown = Perl_Target_Config[UnitName("player")]["Debuffs"];
	mobhealthsupport = Perl_Target_Config[UnitName("player")]["MobHealthSupport"];
	scale = Perl_Target_Config[UnitName("player")]["Scale"];
	showpvprank = Perl_Target_Config[UnitName("player")]["ShowPvPRank"];
	transparency = Perl_Target_Config[UnitName("player")]["Transparency"];
	buffdebuffscale = Perl_Target_Config[UnitName("player")]["BuffDebuffScale"];
	showportrait = Perl_Target_Config[UnitName("player")]["ShowPortrait"];
	threedportrait = Perl_Target_Config[UnitName("player")]["ThreeDPortrait"];
	portraitcombattext = Perl_Target_Config[UnitName("player")]["PortraitCombatText"];
	showrareeliteframe = Perl_Target_Config[UnitName("player")]["ShowRareEliteFrame"];
	nameframecombopoints = Perl_Target_Config[UnitName("player")]["NameFrameComboPoints"];
	comboframedebuffs = Perl_Target_Config[UnitName("player")]["ComboFrameDebuffs"];
	framestyle = Perl_Target_Config[UnitName("player")]["FrameStyle"];
	compactmode = Perl_Target_Config[UnitName("player")]["CompactMode"];
	compactpercent = Perl_Target_Config[UnitName("player")]["CompactPercent"];
	hidebuffbackground = Perl_Target_Config[UnitName("player")]["HideBuffBackground"];

	if (locked == nil) then
		locked = 0;
	end
	if (showcp == nil) then
		showcp = 1;
	end
	if (showclassicon == nil) then
		showclassicon = 1;
	end
	if (showclassframe == nil) then
		showclassframe = 1;
	end
	if (showpvpicon == nil) then
		showpvpicon = 1;
	end
	if (numbuffsshown == nil) then
		numbuffsshown = 16;
	end
	if (numdebuffsshown == nil) then
		numdebuffsshown = 16;
	end
	if (mobhealthsupport == nil) then
		mobhealthsupport = 1;
	end
	if (scale == nil) then
		scale = 1;
	end
	if (showpvprank == nil) then
		showpvprank = 0;
	end
	if (transparency == nil) then
		transparency = 1;
	end
	if (buffdebuffscale == nil) then
		buffdebuffscale = 1;
	end
	if (showportrait == nil) then
		showportrait = 0;
	end
	if (threedportrait == nil) then
		threedportrait = 0;
	end
	if (portraitcombattext == nil) then
		portraitcombattext = 1;
	end
	if (showrareeliteframe == nil) then
		showrareeliteframe = 0;
	end
	if (nameframecombopoints == nil) then
		nameframecombopoints = 0;
	end
	if (comboframedebuffs == nil) then
		comboframedebuffs = 0;
	end
	if (framestyle == nil) then
		framestyle = 1;
	end
	if (compactmode == nil) then
		compactmode = 0;
	end
	if (compactpercent == nil) then
		compactpercent = 0;
	end
	if (hidebuffbackground == nil) then
		hidebuffbackground = 0;
	end

	local vars = {
		["locked"] = locked,
		["showcp"] = showcp,
		["showclassicon"] = showclassicon,
		["showclassframe"] = showclassframe,
		["showpvpicon"] = showpvpicon,
		["numbuffsshown"] = numbuffsshown,
		["numdebuffsshown"] = numdebuffsshown,
		["mobhealthsupport"] = mobhealthsupport,
		["scale"] = scale,
		["showpvprank"] = showpvprank,
		["transparency"] = transparency,
		["buffdebuffscale"] = buffdebuffscale,
		["showportrait"] = showportrait,
		["threedportrait"] = threedportrait,
		["portraitcombattext"] = portraitcombattext,
		["showrareeliteframe"] = showrareeliteframe,
		["nameframecombopoints"] = nameframecombopoints,
		["comboframedebuffs"] = comboframedebuffs,
		["framestyle"] = framestyle,
		["compactmode"] = compactmode,
		["compactpercent"] = compactpercent,
		["hidebuffbackground"] = hidebuffbackground,
	}
	return vars;
end

function Perl_Target_UpdateVars(vartable)
	if (vartable ~= nil) then
		-- Sanity checks in case you use a load from an old version
		if (vartable["Global Settings"] ~= nil) then
			if (vartable["Global Settings"]["Locked"] ~= nil) then
				locked = vartable["Global Settings"]["Locked"];
			else
				locked = nil;
			end
			if (vartable["Global Settings"]["ComboPoints"] ~= nil) then
				showcp = vartable["Global Settings"]["ComboPoints"];
			else
				showcp = nil;
			end
			if (vartable["Global Settings"]["ClassIcon"] ~= nil) then
				showclassicon = vartable["Global Settings"]["ClassIcon"];
			else
				showclassicon = nil;
			end
			if (vartable["Global Settings"]["ClassFrame"] ~= nil) then
				showclassframe = vartable["Global Settings"]["ClassFrame"];
			else
				showclassframe = nil;
			end
			if (vartable["Global Settings"]["PvPIcon"] ~= nil) then
				showpvpicon = vartable["Global Settings"]["PvPIcon"];
			else
				showpvpicon = nil;
			end
			if (vartable["Global Settings"]["Buffs"] ~= nil) then
				numbuffsshown = vartable["Global Settings"]["Buffs"];
			else
				numbuffsshown = nil;
			end
			if (vartable["Global Settings"]["Debuffs"] ~= nil) then
				numdebuffsshown = vartable["Global Settings"]["Debuffs"];
			else
				numdebuffsshown = nil;
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
			if (vartable["Global Settings"]["ShowPvPRank"] ~= nil) then
				showpvprank = vartable["Global Settings"]["ShowPvPRank"];
			else
				showpvprank = nil;
			end
			if (vartable["Global Settings"]["Transparency"] ~= nil) then
				transparency = vartable["Global Settings"]["Transparency"];
			else
				transparency = nil;
			end
			if (vartable["Global Settings"]["BuffDebuffScale"] ~= nil) then
				buffdebuffscale = vartable["Global Settings"]["BuffDebuffScale"];
			else
				buffdebuffscale = nil;
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
			if (vartable["Global Settings"]["PortraitCombatText"] ~= nil) then
				portraitcombattext = vartable["Global Settings"]["PortraitCombatText"];
			else
				portraitcombattext = nil;
			end
			if (vartable["Global Settings"]["ShowRareEliteFrame"] ~= nil) then
				showrareeliteframe = vartable["Global Settings"]["ShowRareEliteFrame"];
			else
				showrareeliteframe = nil;
			end
			if (vartable["Global Settings"]["NameFrameComboPoints"] ~= nil) then
				nameframecombopoints = vartable["Global Settings"]["NameFrameComboPoints"];
			else
				nameframecombopoints = nil;
			end
			if (vartable["Global Settings"]["ComboFrameDebuffs"] ~= nil) then
				comboframedebuffs = vartable["Global Settings"]["ComboFrameDebuffs"];
			else
				comboframedebuffs = nil;
			end
			if (vartable["Global Settings"]["FrameStyle"] ~= nil) then
				framestyle = vartable["Global Settings"]["FrameStyle"];
			else
				framestyle = nil;
			end
			if (vartable["Global Settings"]["CompactMode"] ~= nil) then
				compactmode = vartable["Global Settings"]["CompactMode"];
			else
				compactmode = nil;
			end
			if (vartable["Global Settings"]["CompactPercent"] ~= nil) then
				compactpercent = vartable["Global Settings"]["CompactPercent"];
			else
				compactpercent = nil;
			end
			if (vartable["Global Settings"]["HideBuffBackground"] ~= nil) then
				hidebuffbackground = vartable["Global Settings"]["HideBuffBackground"];
			else
				hidebuffbackground = nil;
			end
		end

		-- Set the new values if any new values were found, same defaults as above
		if (locked == nil) then
			locked = 0;
		end
		if (showcp == nil) then
			showcp = 1;
		end
		if (showclassicon == nil) then
			showclassicon = 1;
		end
		if (showclassframe == nil) then
			showclassframe = 1;
		end
		if (showpvpicon == nil) then
			showpvpicon = 1;
		end
		if (numbuffsshown == nil) then
			numbuffsshown = 16;
		end
		if (numdebuffsshown == nil) then
			numdebuffsshown = 16;
		end
		if (mobhealthsupport == nil) then
			mobhealthsupport = 1;
		end
		if (scale == nil) then
			scale = 1;
		end
		if (showpvprank == nil) then
			showpvprank = 0;
		end
		if (transparency == nil) then
			transparency = 1;
		end
		if (buffdebuffscale == nil) then
			buffdebuffscale = 1;
		end
		if (showportrait == nil) then
			showportrait = 0;
		end
		if (threedportrait == nil) then
			threedportrait = 0;
		end
		if (portraitcombattext == nil) then
			portraitcombattext = 1;
		end
		if (showrareeliteframe == nil) then
			showrareeliteframe = 0;
		end
		if (nameframecombopoints == nil) then
			nameframecombopoints = 0;
		end
		if (comboframedebuffs == nil) then
			comboframedebuffs = 0;
		end
		if (framestyle == nil) then
			framestyle = 1;
		end
		if (compactmode == nil) then
			compactmode = 0;
		end
		if (compactpercent == nil) then
			compactpercent = 0;
		end
		if (hidebuffbackground == nil) then
			hidebuffbackground = 0;
		end

		-- Call any code we need to activate them
		Perl_Target_Reset_Buffs();		-- Reset the buff icons
		Perl_Target_Frame_Style();		-- Reposition the frames
		Perl_Target_Buff_Debuff_Background();	-- Hide/Show the background frame
		Perl_Target_Update_Once();
	end

	Perl_Target_Config[UnitName("player")] = {
		["Locked"] = locked,
		["ComboPoints"] = showcp,
		["ClassIcon"] = showclassicon,
		["ClassFrame"] = showclassframe,
		["PvPIcon"] = showpvpicon,
		["Buffs"] = numbuffsshown,
		["Debuffs"] = numdebuffsshown,
		["MobHealthSupport"] = mobhealthsupport,
		["Scale"] = scale,
		["ShowPvPRank"] = showpvprank,
		["Transparency"] = transparency,
		["BuffDebuffScale"] = buffdebuffscale,
		["ShowPortrait"] = showportrait,
		["ThreeDPortrait"] = threedportrait,
		["PortraitCombatText"] = portraitcombattext,
		["ShowRareEliteFrame"] = showrareeliteframe,
		["NameFrameComboPoints"] = nameframecombopoints,
		["ComboFrameDebuffs"] = comboframedebuffs,
		["FrameStyle"] = framestyle,
		["CompactMode"] = compactmode,
		["CompactPercent"] = compactpercent,
		["HideBuffBackground"] = hidebuffbackground,
	};
end


--------------------
-- Buff Functions --
--------------------
function Perl_Target_Buff_UpdateAll()
	local friendly;
	if (UnitName("target")) then
		if (nameframecombopoints == 1 or comboframedebuffs == 1) then
			Perl_Target_Buff_UpdateCPMeter();
		end

		if (UnitIsFriend("player", "target")) then
			friendly = 1;
		else
			friendly = 0;
		end

		local buffmax = 0;
		for buffnum=1,numbuffsshown do
			local button = getglobal("Perl_Target_Buff"..buffnum);
			local icon = getglobal(button:GetName().."Icon");
			local debuff = getglobal(button:GetName().."DebuffBorder");

			if (UnitBuff("target", buffnum)) then
				icon:SetTexture(UnitBuff("target", buffnum));
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
		for debuffnum=1,numdebuffsshown do
			debuffTexture, debuffApplications = UnitDebuff("target", debuffnum);
			local button = getglobal("Perl_Target_Debuff"..debuffnum);
			local icon = getglobal(button:GetName().."Icon");
			local debuff = getglobal(button:GetName().."DebuffBorder");

			if (UnitDebuff("target", debuffnum)) then
				icon:SetTexture(debuffTexture);
				button.isdebuff = 1;
				debuff:Show();
				button:Show();
				debuffCount = getglobal("Perl_Target_Debuff"..debuffnum.."Count");
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
			Perl_Target_BuffFrame:Hide();
		else
			if (friendly == 1) then
				Perl_Target_BuffFrame:SetPoint("TOPLEFT", "Perl_Target_StatsFrame", "BOTTOMLEFT", 0, 5);
			else
				if (debuffmax > 8) then
					Perl_Target_BuffFrame:SetPoint("TOPLEFT", "Perl_Target_StatsFrame", "BOTTOMLEFT", 0, -51);
				else
					Perl_Target_BuffFrame:SetPoint("TOPLEFT", "Perl_Target_StatsFrame", "BOTTOMLEFT", 0, -25);
				end
			end
			Perl_Target_BuffFrame:Show();
			if (buffmax > 8) then
				Perl_Target_BuffFrame:SetWidth(221);	-- 5 + 8 * (24 + 3)	5 = border gap, 8 buffs across, 24 = icon size + 3 for pixel alignment, only holds true for default size
				Perl_Target_BuffFrame:SetHeight(61);
			else
				Perl_Target_BuffFrame:SetWidth(5 + buffmax * 27);
				Perl_Target_BuffFrame:SetHeight(34);
			end
		end

		if (debuffmax == 0) then
			Perl_Target_DebuffFrame:Hide();
		else
			if (friendly == 1) then
				if (buffmax > 8) then
					Perl_Target_DebuffFrame:SetPoint("TOPLEFT", "Perl_Target_StatsFrame", "BOTTOMLEFT", 0, -51);
				else
					Perl_Target_DebuffFrame:SetPoint("TOPLEFT", "Perl_Target_StatsFrame", "BOTTOMLEFT", 0, -25);
				end
			else
				Perl_Target_DebuffFrame:SetPoint("TOPLEFT", "Perl_Target_StatsFrame", "BOTTOMLEFT", 0, 5);
			end
			Perl_Target_DebuffFrame:Show();
			if (debuffmax > 8) then
				Perl_Target_DebuffFrame:SetWidth(221);	-- 5 + 8 * 27
				Perl_Target_DebuffFrame:SetHeight(61);
			else
				Perl_Target_DebuffFrame:SetWidth(5 + debuffmax * 27);
				Perl_Target_DebuffFrame:SetHeight(34);
			end
		end
	end
end

function Perl_Target_Buff_UpdateCPMeter()
	local debuffapplications;
	local playerclass = UnitClass("player");

	if (playerclass == PERL_LOCALIZED_MAGE) then
		debuffapplications = Perl_Target_Buff_GetApplications("Fire Vulnerability");
	elseif (playerclass == PERL_LOCALIZED_PRIEST) then
		debuffapplications = Perl_Target_Buff_GetApplications("Shadow Vulnerability");
	elseif (playerclass == PERL_LOCALIZED_WARRIOR) then
		debuffapplications = Perl_Target_Buff_GetApplications("Sunder Armor");
	elseif ((playerclass == PERL_LOCALIZED_ROGUE) or (playerclass == PERL_LOCALIZED_DRUID)) then
		return;
	else
		Perl_Target_NameFrame_CPMeter:Hide();
		return;
	end

	if (debuffapplications == 0) then
		Perl_Target_CPFrame:Hide();
		Perl_Target_NameFrame_CPMeter:Hide();
	else
		if (comboframedebuffs == 1) then
			Perl_Target_CPText:SetText(debuffapplications);
			Perl_Target_CPText:SetTextHeight(20);
			if (debuffapplications == 5) then
				Perl_Target_CPFrame:Show();
				Perl_Target_CPText:SetTextColor(1, 0, 0);	-- red text
			elseif (debuffapplications == 4) then
				Perl_Target_CPFrame:Show();
				Perl_Target_CPText:SetTextColor(1, 0.5, 0);	-- orange text
			elseif (debuffapplications == 3) then
				Perl_Target_CPFrame:Show();
				Perl_Target_CPText:SetTextColor(1, 1, 0);	-- yellow text
			elseif (debuffapplications == 2) then
				Perl_Target_CPFrame:Show();
				Perl_Target_CPText:SetTextColor(0.5, 1, 0);	-- yellow-green text
			elseif (debuffapplications == 1) then
				Perl_Target_CPFrame:Show();
				Perl_Target_CPText:SetTextColor(0, 1, 0);	-- green text
			else
				Perl_Target_CPFrame:Hide();
			end
		else
			Perl_Target_CPFrame:Hide();
		end

		if (nameframecombopoints == 1) then				-- this isn't nested since you can have both combo point styles on at the same time
			Perl_Target_NameFrame_CPMeter:SetMinMaxValues(0, 5);
			Perl_Target_NameFrame_CPMeter:SetValue(debuffapplications);
			if (debuffapplications == 5) then
				Perl_Target_NameFrame_CPMeter:Show();
			elseif (debuffapplications == 4) then
				Perl_Target_NameFrame_CPMeter:Show();
			elseif (debuffapplications == 3) then
				Perl_Target_NameFrame_CPMeter:Show();
			elseif (debuffapplications == 2) then
				Perl_Target_NameFrame_CPMeter:Show();
			elseif (debuffapplications == 1) then
				Perl_Target_NameFrame_CPMeter:Show();
			else
				Perl_Target_NameFrame_CPMeter:Hide();
			end
		else
			Perl_Target_NameFrame_CPMeter:Hide();
		end
	end
end

function Perl_Target_Buff_GetApplications(debuffname)
	local debuffApplications;
	local i = 1;

	while UnitDebuff("target", i) do
		Perl_Target_Tooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
		Perl_Target_Tooltip:SetUnitDebuff("target", i);
		if (Perl_Target_TooltipTextLeft1:GetText() == debuffname) then
			_, debuffApplications = UnitDebuff("target", i);
			Perl_Target_Tooltip:Hide();
			return debuffApplications;
		end

		i = i + 1;
	end

	Perl_Target_Tooltip:Hide();
	return 0;
end

function Perl_Target_Reset_Buffs()
	local button;
	for buffnum=1,16 do
		button = getglobal("Perl_Target_Buff"..buffnum);
		button:Hide();
		button = getglobal("Perl_Target_Debuff"..buffnum);
		button:Hide();
	end
end

function Perl_Target_SetBuffTooltip()
	local buffmapping = 0;
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
	if (this.isdebuff == 1) then
		GameTooltip:SetUnitDebuff("target", this:GetID()-buffmapping);
	else
		GameTooltip:SetUnitBuff("target", this:GetID());
	end
end


--------------------
-- Click Handlers --
--------------------
function Perl_TargetDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, Perl_TargetDropDown_Initialize, "MENU");
end

function Perl_TargetDropDown_Initialize()
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
		UnitPopup_ShowMenu(Perl_Target_DropDown, menu, "target");
	end
end

function Perl_Target_MouseClick(button)
	if (CastPartyConfig and PCUF_CASTPARTYSUPPORT == 1) then
		if (not string.find(GetMouseFocus():GetName(), "Name")) then
			CastParty_OnClickByUnit(button, "target");
		end
	elseif (Genesis_data and PCUF_CASTPARTYSUPPORT == 1) then
		if (not string.find(GetMouseFocus():GetName(), "Name")) then
			Genesis_MouseHeal("target", button);
		end
	else
		if (SpellIsTargeting() and button == "RightButton") then
			SpellStopTargeting();
			return;
		end

		if (button == "LeftButton") then
			if (SpellIsTargeting()) then
				SpellTargetUnit("target");
			elseif (CursorHasItem()) then
				DropItemOnUnit("target");
			end
		end
	end
end

function Perl_Target_MouseDown(button)
	if (button == "LeftButton" and locked == 0) then
		Perl_Target_Frame:StartMoving();
	end
end

function Perl_Target_MouseUp(button)
	if (button == "RightButton") then
		if ((CastPartyConfig or Genesis_data) and PCUF_CASTPARTYSUPPORT == 1) then
			if (not (IsAltKeyDown() or IsControlKeyDown() or IsShiftKeyDown()) and string.find(GetMouseFocus():GetName(), "Name")) then		-- if alt, ctrl, or shift ARE NOT held AND we are clicking the name frame, show the menu
				ToggleDropDownMenu(1, nil, Perl_Target_DropDown, "Perl_Target_NameFrame", 40, 0);
			end
		else
			if (not (IsAltKeyDown() or IsControlKeyDown() or IsShiftKeyDown())) then		-- if alt, ctrl, or shift ARE NOT held, show the menu
				ToggleDropDownMenu(1, nil, Perl_Target_DropDown, "Perl_Target_NameFrame", 40, 0);
			end
		end
	end

	Perl_Target_Frame:StopMovingOrSizing();
end

function Perl_Target_OnShow()
	if ( UnitIsEnemy("target", "player") ) then
		PlaySound("igCreatureAggroSelect");
	elseif ( UnitIsFriend("player", "target") ) then
		PlaySound("igCharacterNPCSelect");
	else
		PlaySound("igCreatureNeutralSelect");
	end
end


-------------
-- Tooltip --
-------------
function Perl_Target_Tip()
	UnitFrame_Initialize("target")
end

function UnitFrame_Initialize(unit)	-- Hopefully this doesn't break any mods
	this.unit = unit;
end


----------------------
-- myAddOns Support --
----------------------
function Perl_Target_myAddOns_Support()
	-- Register the addon in myAddOns
	if (myAddOnsFrame_Register) then
		local Perl_Target_myAddOns_Details = {
			name = "Perl_Target",
			version = "Version 0.58",
			releaseDate = "April 15, 2006",
			author = "Perl; Maintained by Global",
			email = "global@g-ball.com",
			website = "http://www.curse-gaming.com/mod.php?addid=2257",
			category = MYADDONS_CATEGORY_OTHERS
		};
		Perl_Target_myAddOns_Help = {};
		Perl_Target_myAddOns_Help[1] = "/perl";
		myAddOnsFrame_Register(Perl_Target_myAddOns_Details, Perl_Target_myAddOns_Help);
	end
end