local Moog_HudClass = {
	[MOOGHUD_CLASS_MAGE] =	"00FFFF",
	[MOOGHUD_CLASS_WARLOCK] =	"8D54FB",
	[MOOGHUD_CLASS_PRIEST] =	"FFFFFF",
	[MOOGHUD_CLASS_DRUID] =	"FF8A00",
	[MOOGHUD_CLASS_SHAMAN] =	"FF71A8",
	[MOOGHUD_CLASS_PALADIN] =	"FF71A8",
	[MOOGHUD_CLASS_ROGUE] =	"FFFF00",
	[MOOGHUD_CLASS_HUNTER] =	"00FF00",
	[MOOGHUD_CLASS_WARRIOR] =	"B39442",
};

local Moog_HudRep = { "FF4444", "DD4444", "DD7744", "BB9944", "44DD44", "55EE44", "66FF44"};

function GetArgs(message, separator)

	local args = {};

	local i = 0;

	for value in string.gfind(message, "[^"..separator.."]+") do
		i = i + 1;
		args[i] = value;
	end 

	return args;
end

function sr_pr(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end

-- Seal: Added
local function Moog_UpdateCurrentState(unit)
	local stateicon = getglobal("Moog_Hud_"..unit.."_StatusTexture");
	local inCombat = this.inCombat;
	if (not stateicon) then return; end
	if(unit == "target") then
		inCombat = UnitAffectingCombat(unit);
	end
	if(inCombat == 1) then
		stateicon:Show();
		stateicon:SetTexCoord(.5625, .9375, .0625, .4375);
	elseif(unit == "player" and IsResting()) then
		stateicon:Show();
		stateicon:SetTexCoord(.0625, .4375, .0625, .4375);
	else
		stateicon:Hide();
	end
end

local function Moog_UpdatePvP(unit)
	local pvpicon = getglobal("Moog_Hud_"..unit.."_PvPTexture");
	if (not pvpicon) then return; end
	local factionGroup = UnitFactionGroup(unit);
	if ( UnitIsPVPFreeForAll(unit) ) then
		pvpicon:SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA");
		pvpicon:Show();
	elseif ( factionGroup and UnitIsPVP(unit) ) then
		pvpicon:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..factionGroup);
		pvpicon:Show();
	else
		pvpicon:Hide();
	end
end

local function Moog_UpdatePartyLeader()
	if ( IsPartyLeader() and (GetNumPartyMembers() > 0) ) then
		Moog_Hud_player_LeaderTexture:Show();
	else
		Moog_Hud_player_LeaderTexture:Hide();
	end
end

local function Moog_UpdatePartyLoot()
	local lootMethod, lootMaster = GetLootMethod();
	if ((lootMaster == 0)and (GetNumPartyMembers() > 0)) then
		Moog_Hud_player_LootTexture:Show();
	else
		Moog_Hud_player_LootTexture:Hide();
	end
end

-- Seal: End Add

function Moog_Hud_OnLoad()
	SlashCmdList["MOOGHUD"] = Moog_Hud_SlashHandler;
	SLASH_MOOGHUD1 = "/moog";

	-- Shen: Events which are needed globally
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	this:RegisterEvent("VARIABLES_LOADED");

	Moog_UseMobHealth = false;
	
	Moog_SpellBlinkTime = GetTime();

	table.insert(UnitPopupFrames,"Moog_Player_DropDown");
	table.insert(UnitPopupFrames,"Moog_Target_DropDown");

	--RegisterForSave("MoogHUDInfo");

	sr_pr("Moog HUD v"..MOOGHUD_VERSION.." loaded. Type /moog to bring up options");
end

function Moog_Hud_SlashHandler(msg)
	-- if (msg == nil) then
	-- 	msg = ""; end

	local parsedmsg = GetArgs(msg," ");

	if (parsedmsg[1] == nil) then
		Moogmenu:Show();
	else
		parsedmsg[1] = strlower(parsedmsg[1])

		if strfind(parsedmsg[1], "menu") and Moogmenu then
			Moogmenu:Show();
		elseif Moogmenu then
			Moogmenu:Show();
		end
	end
end

function Moog_HudTargetUpdate()
	-- Update Combo Points here just to be sure it catches target deaths, etc
	local points = GetComboPoints();
	if (points > 0) then
		Moog_HudCombo:SetText(points);
	else
		Moog_HudCombo:SetText("");
	end

	if (UnitIsDeadOrGhost("target")) then
		Moog_TargetHudHPText:SetTextColor(0.7, 0.7, 0.7);
	else
		Moog_TargetHudHPText:SetTextColor(1, 0, 0);
	end

	if (MoogHUDInfo.TargetOn and UnitExists("target")) then
		Moog_TargetHud:Show();
		-- Moog_TargetHudHPPerc:SetText(ceil((UnitHealth("target") / UnitHealthMax("target")) * 100).."%");

		if UnitIsDeadOrGhost("target") then
			Moog_TargetHudHPText:SetText("Dead");
		elseif ((UnitInParty("target") or UnitIsUnit("target","pet")) and (MoogHUDInfo.PlayerTargetPC == false)) then
			Moog_TargetHudHPText:SetText(UnitHealth("target").."/"..UnitHealthMax("target"));
		else
			if (Moog_UseMobHealth and (MoogHUDInfo.MobTargetPC == false)) then
				Moog_TargetHudHPText:SetText(Moog_MobHealth_GetTargetCurHP().."/"..Moog_MobHealth_GetTargetMaxHP());
			else
				Moog_TargetHudHPText:SetText(ceil((UnitHealth("target") / UnitHealthMax("target")) * 100).."%");
			end
		end

		if (UnitManaMax("target") > 0) then
			if ((UnitIsPlayer("target") and (MoogHUDInfo.PlayerTargetPC == false)) or ((not UnitIsPlayer("target")) and (MoogHUDInfo.MobTargetPC == false))) then
				Moog_TargetHudMPText:SetText(UnitMana("target").."/"..UnitManaMax("target"));
			else
				Moog_TargetHudMPText:SetText(ceil((UnitMana("target") / UnitManaMax("target")) * 100).."%");
			end
		else
			Moog_TargetHudMPText:SetText(" ");
		end

		if (UnitLevel("target") < 0) then
			if ( UnitClassification("target") == "worldboss" ) then
				Moog_TargetHudLevel:SetText("Boss");
			else
				Moog_TargetHudLevel:SetText("L??");
			end
		else
			if ( string.find(UnitClassification("target"), "elite") == nil ) then
				Moog_TargetHudLevel:SetText("L" .. UnitLevel("target"));
			else
				Moog_TargetHudLevel:SetText("L" .. UnitLevel("target") .. "+");
			end
		end

		local targetfriend = 1;

		if (UnitIsFriend("player","target") == nil) then
			targetfriend = 0; end

		if (targetfriend == 1) then
			Moog_TargetHudLevel:SetTextColor(1, 0.9, 0);
		elseif (UnitIsTrivial("target")) then
			Moog_TargetHudLevel:SetTextColor(0.7, 0.7, 0.7);
		elseif (UnitLevel("target") == -1) then
			Moog_TargetHudLevel:SetTextColor(1, 0, 0);
		elseif (UnitLevel("target") <= (UnitLevel("player")-3)) then
			Moog_TargetHudLevel:SetTextColor(0, 0.9, 0);
		elseif (UnitLevel("target") >= (UnitLevel("player")+5)) then
			Moog_TargetHudLevel:SetTextColor(1, 0, 0);
		elseif (UnitLevel("target") >= (UnitLevel("player")+3)) then
			Moog_TargetHudLevel:SetTextColor(1, 0.5, 0);
		else
			Moog_TargetHudLevel:SetTextColor(1, 0.9, 0);
		end

		local info = {};
		if (UnitPowerType("target") == 0) then
			info = { r = 0.00, g = 0.7, b = 1.00 };
		else
			info = ManaBarColor[UnitPowerType("target")];
		end

		local class = UnitClass("target");
		local color = Moog_HudClass[class];
		if (UnitIsPlayer("target")) then
			if (color) then
				Moog_TargetHudName:SetText("|cff"..color..UnitName("target").."|r");
			else
				Moog_TargetHudName:SetText("|cffb39442"..UnitName("target").."|r");
			end
		else
			local reaction = UnitReaction("target","player");
			local reactioncolour = Moog_HudRep[4];
			if (reaction) then
				reactioncolour = Moog_HudRep[reaction];
			end
			Moog_TargetHudName:SetText("|cff"..reactioncolour..UnitName("target").."|r");
		end

		if ((UnitIsPlayer("target") or (MoogHUDInfo.MobClass == true)) and MoogHUDInfo.ShowIcons) then
			Moog_Target_ClassTexture:SetTexCoord(Moog_ClassPosRight(class), Moog_ClassPosLeft(class), Moog_ClassPosTop(class), Moog_ClassPosBottom(class));
			Moog_Target_Icon:Show();
		else
			Moog_Target_Icon:Hide();
		end

		if (UnitIsTapped("target") and not UnitIsTappedByPlayer("target")) then
			Moog_TargetHudName:SetTextColor(0.5, 0.5, 0.5);
		end

		Moog_TargetHudMPText:SetTextColor(info.r, info.g, info.b);

		Moog_HudTargetAuras();
		--Seal: Added Update status and pvp
		--Moog_UpdatePvP("target");
		--Moog_UpdateCurrentState("target");
		--Seal: End Add
	else
		Moog_TargetHud:Hide();
	end
end

function Moog_HudTargetAuras()
	local i, icon, buff, debuff, debuffborder, debuffcount;
	for i = 1, 16 do
		buff = UnitBuff("target", i);
		button = getglobal("Moog_TargetHudBuff"..i);
		if (buff) then
			icon = getglobal(button:GetName().."Icon");
			icon:SetTexture(buff);
			button:Show();
			button.unit = "target";
		else
			button:Hide();
		end
	end
	
	for i = 1, 16 do
		debuff, debuffApplications = UnitDebuff("target", i);
		button = getglobal("Moog_TargetHudDeBuff"..i);
		if (debuff) then
			icon = getglobal(button:GetName().."Icon");
			debuffborder = getglobal(button:GetName().."Border");
			debuffcount = getglobal(button:GetName().."Count");
			icon:SetTexture(debuff);
			button:Show();
			debuffborder:Show();
			button.isdebuff = 1;
			button.unit = "target";
			if (debuffApplications > 1) then
				debuffcount:SetText(debuffApplications);
				debuffcount:Show();
			else
				debuffcount:Hide();
			end
		else
			button:Hide();
		end
	end
end

function Moog_HudSetAuraTooltip()
	if (not this:IsVisible()) then return; end
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
	local unit = this.unit;
	if (this.isdebuff == 1) then
		GameTooltip:SetUnitDebuff(unit, this:GetID());
	else
		GameTooltip:SetUnitBuff(unit, this:GetID());
	end
end

function Moog_HudUpdateOptions()
	if (MoogHUDInfo.SelfOn) then
		Moog_SelfHud:Show();
	else
		Moog_SelfHud:Hide();
	end

	if (MoogHUDInfo.ShowIcons) then
		Moog_Player_Icon:Show();
	else
		Moog_Player_Icon:Hide();
	end

	if (MoogHUDInfo.Seperation == nil) then
		MoogHUDInfo.Seperation = 0; end

	Moog_HudLeft:SetPoint("CENTER","Moog_Hud","CENTER", -MoogHUDInfo.Seperation, 0);
	Moog_HudRight:SetPoint("CENTER","Moog_Hud","CENTER", MoogHUDInfo.Seperation, 0);

	if (MoogHUDInfo.SeperateNumbers == nil) then
		MoogHUDInfo.SeperateNumbers = 0; end

	local TextOffset = 0;

	if (MoogHUDInfo.SeperateNumbers) then
		TextOffset=MoogHUDInfo.Seperation; end

	Moog_HudHealthText:SetPoint("BOTTOMRIGHT","Moog_HudCombo","TOPLEFT", -TextOffset, 0);
	Moog_HudManaText:SetPoint("BOTTOMLEFT","Moog_HudCombo","TOPRIGHT", TextOffset, 0);

	--Moog_TargetHudHPText:SetPoint("TOPLEFT","Moog_TargetHudName","BOTTOMLEFT", -TextOffset, -2);
	--Moog_TargetHudMPText:SetPoint("TOPRIGHT","Moog_TargetHudName","BOTTOMRIGHT", TextOffset, -2);

	if (MoogHUDInfo.VertPos == nil) then
		MoogHUDInfo.VertPos = 50; end

	Moog_Hud:SetPoint("CENTER","UIParent","CENTER", 0, MoogHUDInfo.VertPos);

	Moog_HudTargetUpdate();
end

function Moog_HudOnEvent(event)
	if (event == "VARIABLES_LOADED" ) then
		if ( not MoogHUDInfo ) then
			MoogHUDInfo = {
				["SelfOn"] = true,
				["Seperation"] = 0,
				["VertPos"] = 50,
				["TargetOn"] = true,
				["MobTargetPC"] = false,
				["PlayerTargetPC"] = false,
				["MobClass"] = false,
				["ShowIcons"] = false,
				["BlinkLongCast"] = true,
				["BlinkInstaCast"] = false,
				["SeperateNumbers"] = false
				};
		end
		if MoogHUDInfo.SelfOn == nil then
			MoogHUDInfo.SelfOn = true; end
		if MoogHUDInfo.TargetOn == nil then
			MoogHUDInfo.TargetOn = true; end
		if MoogHUDInfo.MobTargetPC == nil then
			MoogHUDInfo.MobTargetPC = false; end
		if MoogHUDInfo.PlayerTargetPC == nil then
			MoogHUDInfo.PlayerTargetPC = false; end
		if MoogHUDInfo.MobClass == nil then
			MoogHUDInfo.MobClass = false; end
		if MoogHUDInfo.ShowIcons == nil then
			MoogHUDInfo.ShowIcons = false; end
		if MoogHUDInfo.BlinkLongCast == nil then
			MoogHUDInfo.BlinkLongCast = true; end
		if MoogHUDInfo.BlinkInstaCast == nil then
			MoogHUDInfo.BlinkInstaCast = false; end
		if MoogHUDInfo.SeperateNumbers == nil then
			MoogHUDInfo.SeperateNumbers = false; end
		if  MobHealthFrame  then
			sr_pr("Moog HUD detected MobHealth/MobInfo");
			Moog_UseMobHealth = true; end
		Moog_HudUpdateOptions();
	elseif (event == "PLAYER_ENTERING_WORLD") then
		-- Shen: Event hooks moved from OnLoad
		--Seal: Added
		this:RegisterEvent("PLAYER_ENTER_COMBAT");
		this:RegisterEvent("PLAYER_LEAVE_COMBAT");
		this:RegisterEvent("PLAYER_UPDATE_RESTING");
		this:RegisterEvent("PLAYER_REGEN_DISABLED");
		this:RegisterEvent("PLAYER_REGEN_ENABLED");
		this:RegisterEvent("PARTY_LEADER_CHANGED");
		this:RegisterEvent("PARTY_LOOT_METHOD_CHANGED");
		--Seal: End Add
		this:RegisterEvent("PLAYER_COMBO_POINTS");
		this:RegisterEvent("UNIT_AURA");
		this:RegisterEvent("UNIT_HEALTH");
		this:RegisterEvent("UNIT_MAXHEALTH");
		this:RegisterEvent("UNIT_MANA");
		this:RegisterEvent("UNIT_RAGE");
		this:RegisterEvent("UNIT_FOCUS");
		this:RegisterEvent("UNIT_ENERGY");
		this:RegisterEvent("UNIT_MAXMANA");
		this:RegisterEvent("UNIT_MAXRAGE");
		this:RegisterEvent("UNIT_MAXFOCUS");
		this:RegisterEvent("UNIT_MAXENERGY");
		this:RegisterEvent("UNIT_NAME_UPDATE");
		this:RegisterEvent("UNIT_DISPLAYPOWER");
		this:RegisterEvent("PARTY_MEMBERS_CHANGED");
		--Seal: Added
		this:RegisterEvent("UNIT_PVP_UPDATE");
		--Seal: End Add

		Moog_HealthHud:SetVertexColor(0, 1, 0);
		Moog_HealthHud:SetAlpha(0);
		Moog_ManaHud:SetAlpha(0);
		Moog_ManaHudBG:SetAlpha(0);
		Moog_ManaHudBG:SetTexCoord(0, 1, 0, 1);

		Moog_HealthHudBG:SetAlpha(0);
		Moog_HealthHudBG:SetVertexColor(0, 1, 0);
		Moog_HealthHudBG:SetTexCoord(0, 1, 0, 1);

		
		if (UnitPowerType("player") == 0) then
			info = { r = 0.00, g = 0.7, b = 1.00 };
		else
			info = ManaBarColor[UnitPowerType("player")];
		end
		Moog_ManaHud:SetVertexColor(info.r, info.g, info.b);
		Moog_ManaHudBG:SetVertexColor(info.r, info.g, info.b);
		
		local p=UnitMana("player")/UnitManaMax("player");
		local h = 256 * p;
		Moog_ManaHud:SetHeight(h);
		Moog_ManaHud:SetTexCoord(0, 1, 1-p, 1);
		Moog_HudManaText:SetText(UnitMana("player").."/"..UnitManaMax("player"));
		Moog_HudManaText:SetVertexColor(info.r, info.g, info.b);

		if (GetNumPartyMembers() > 0) then
			Moog_Player_ClassTexture:SetAlpha(1);
			Moog_Player_Icon:EnableMouse(true);
		else
			Moog_Player_ClassTexture:SetAlpha(0.5);
			Moog_Player_Icon:EnableMouse(false);
		end

		p=UnitHealth("player")/UnitHealthMax("player");
		h = 256 * p;
		Moog_HealthHud:SetHeight(h);
		Moog_HealthHud:SetTexCoord(0, 1, 1-p, 1);
		Moog_HudHealthText:SetText(UnitHealth("player").."/"..UnitHealthMax("player"));
		Moog_HudHealthText:SetVertexColor(0, 1, 0);

		local PlayerClass = UnitClass("player");
		Moog_Player_ClassTexture:SetTexCoord(Moog_ClassPosRight(PlayerClass), Moog_ClassPosLeft(PlayerClass), Moog_ClassPosTop(PlayerClass), Moog_ClassPosBottom(PlayerClass));
		--Seal: Added
		Moog_UpdateCurrentState("player");
		Moog_UpdatePvP("player");
		Moog_UpdatePartyLeader();
		Moog_UpdatePartyLoot();
		--Seal: End Add
	-- Shen: Hook added for leaving, unregistering hooks
	elseif (event == "PLAYER_LEAVING_WORLD") then
		this:UnregisterEvent("PLAYER_ENTER_COMBAT");
		this:UnregisterEvent("PLAYER_LEAVE_COMBAT");
		this:UnregisterEvent("PLAYER_UPDATE_RESTING");
		this:UnregisterEvent("PLAYER_REGEN_DISABLED");
		this:UnregisterEvent("PLAYER_REGEN_ENABLED");
		this:UnregisterEvent("PARTY_LEADER_CHANGED");
		this:UnregisterEvent("PARTY_LOOT_METHOD_CHANGED");
		this:UnregisterEvent("PLAYER_COMBO_POINTS");
		this:UnregisterEvent("UNIT_AURA");
		this:UnregisterEvent("UNIT_HEALTH");
		this:UnregisterEvent("UNIT_MAXHEALTH");
		this:UnregisterEvent("UNIT_MANA");
		this:UnregisterEvent("UNIT_RAGE");
		this:UnregisterEvent("UNIT_FOCUS");
		this:UnregisterEvent("UNIT_ENERGY");
		this:UnregisterEvent("UNIT_MAXMANA");
		this:UnregisterEvent("UNIT_MAXRAGE");
		this:UnregisterEvent("UNIT_MAXFOCUS");
		this:UnregisterEvent("UNIT_MAXENERGY");
		this:UnregisterEvent("UNIT_NAME_UPDATE");
		this:UnregisterEvent("UNIT_DISPLAYPOWER");
		this:UnregisterEvent("PARTY_MEMBERS_CHANGED");
		this:UnregisterEvent("UNIT_PVP_UPDATE");
	elseif (event == "UNIT_DISPLAYPOWER") then
		local info = {};
		if (arg1 == "player" or arg1 == "target") then
			if (UnitPowerType(arg1) == 0) then
				info = { r = 0.00, g = 0.7, b = 1.00 };
			else
				info = ManaBarColor[UnitPowerType(arg1)];
			end
			if (arg1 == "player") then
				Moog_ManaHud:SetVertexColor(info.r, info.g, info.b);
				Moog_ManaHudBG:SetVertexColor(info.r, info.g, info.b);
			else
				Moog_TargetHudMPText:SetTextColor(info.r, info.g, info.b);
			end
		end
	elseif (event == "PLAYER_COMBO_POINTS") then
		local points = GetComboPoints();
		if (points > 0) then
			Moog_HudCombo:SetText(points);
		else
			Moog_HudCombo:SetText("");
		end
	elseif (event == "UNIT_AURA" and arg1 == "target") then
		Moog_HudTargetAuras();
	elseif (event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH") then
		if (arg1=="player") then
			if UnitHealthMax("player")==0 then return; end
			local p=UnitHealth("player")/UnitHealthMax("player");
			local h = 256 * p;
			Moog_HealthHud:SetHeight(h);
			Moog_HealthHud:SetTexCoord(0, 1, 1-p, 1);

			if (UnitIsDeadOrGhost("player")) then
				Moog_HudHealthText:SetTextColor(0.7, 0.7, 0.7);
				Moog_HudHealthText:SetText("Dead");
			else
				Moog_HudHealthText:SetTextColor(0, 1, 0);
				Moog_HudHealthText:SetText(UnitHealth("player").."/"..UnitHealthMax("player"));
			end
		elseif (arg1 == "target") then
			if (UnitIsDeadOrGhost("target")) then
				Moog_TargetHudHPText:SetTextColor(0.7, 0.7, 0.7);
			else
				Moog_TargetHudHPText:SetTextColor(1, 0, 0);
			end
			if (UnitIsTapped("target") and not UnitIsTappedByPlayer("target")) then
				Moog_TargetHudName:SetTextColor(0.5, 0.5, 0.5);
			end
			-- Moog_TargetHudHPPerc:SetText(ceil((UnitHealth("target") / UnitHealthMax("target")) * 100).."%");
			if UnitIsDeadOrGhost("target") then
				Moog_TargetHudHPText:SetText("Dead");
			elseif ((UnitInParty("target") or UnitIsUnit("target","pet")) and (MoogHUDInfo.PlayerTargetPC == false)) then
				Moog_TargetHudHPText:SetText(UnitHealth("target").."/"..UnitHealthMax("target"));
			else
				if (Moog_UseMobHealth and (MoogHUDInfo.MobTargetPC == false)) then
					Moog_TargetHudHPText:SetText(Moog_MobHealth_GetTargetCurHP().."/"..Moog_MobHealth_GetTargetMaxHP());
				else
					Moog_TargetHudHPText:SetText(ceil((UnitHealth("target") / UnitHealthMax("target")) * 100).."%");
				end
			end
		end
	elseif (event == "PARTY_MEMBERS_CHANGED") then
		--sr_pr(GetNumPartyMembers());
		if (GetNumPartyMembers() > 0) then
			Moog_Player_ClassTexture:SetAlpha(1);
			Moog_Player_Icon:EnableMouse(true);
		else
			Moog_Player_ClassTexture:SetAlpha(0.5);
			Moog_Player_Icon:EnableMouse(false);
		end
		Moog_UpdatePartyLeader();
		Moog_UpdatePartyLoot();
	elseif (event == "UNIT_NAME_UPDATE") then
		if (arg1=="target") then
			Moog_HudTargetUpdate();
		end
	else
		if (arg1=="player") then
			if UnitManaMax("player")==0 then return; end
			local p=UnitMana("player")/UnitManaMax("player");
			local h = 256 * p;
			Moog_ManaHud:SetHeight(h);
			Moog_ManaHud:SetTexCoord(0, 1, 1-p, 1);
			Moog_HudManaText:SetText(UnitMana("player").."/"..UnitManaMax("player"));
		elseif (arg1 == "target") then
			if ((UnitIsPlayer("target") and (MoogHUDInfo.PlayerTargetPC == false)) or ((not UnitIsPlayer("target")) and (MoogHUDInfo.MobTargetPC == false))) then
				Moog_TargetHudMPText:SetText(UnitMana("target").."/"..UnitManaMax("target"));
			else
				Moog_TargetHudMPText:SetText(ceil((UnitMana("target") / UnitManaMax("target")) * 100).."%");
			end
		end
	end
	--Seal: Added
	if ( event == "PLAYER_ENTER_COMBAT" or event == "PLAYER_REGEN_DISABLED") then
		this.inCombat = 1;
		Moog_UpdateCurrentState("player");
		return;
	end

	if ( event == "PLAYER_UPDATE_RESTING" ) then
		Moog_UpdateCurrentState("player");
		return;
	end

	if ( event == "PLAYER_LEAVE_COMBAT" or event == "PLAYER_REGEN_ENABLED") then
		this.inCombat = 0;
		Moog_UpdateCurrentState("player");
		return;
	end
	
	if (event == "UNIT_PVP_UPDATE") then
		if ((arg1 == "target") or (arg1 == "player")) then
			Moog_UpdatePvP(arg1); end
	end
	
	if (event == "PARTY_LEADER_CHANGED") then
		Moog_UpdatePartyLeader();
		return;
	end
	if (event == "PARTY_LOOT_METHOD_CHANGED") then
		Moog_UpdatePartyLoot();
	end
	--Seal: End Add
end


function Moog_PlayerDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, Moog_PlayerDropDown_Initialize, "MENU");
end
				
function Moog_PlayerDropDown_Initialize()
	UnitPopup_ShowMenu(Moog_Player_DropDown, "SELF", "player");
end

function Moog_Player_MouseUp(button)
	if (button == "RightButton") then
		ToggleDropDownMenu(1, nil, Moog_Player_DropDown, "Moog_Player_ClassTexture", 0, 0); end
end

function Moog_Player_MouseDown(button)
end

function Moog_TargetDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, Moog_TargetDropDown_Initialize, "MENU");
end

function Moog_TargetDropDown_Initialize()
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
		UnitPopup_ShowMenu(Moog_Target_DropDown, menu, "target");
	end
end

function Moog_Target_MouseUp(button)
	if (button == "RightButton") then
		ToggleDropDownMenu(1, nil, Moog_Target_DropDown, "Moog_Target_ClassTexture", 0, 0); end
end

function Moog_Target_MouseDown(button)
end

---------------------------------
--Class Icon Location Functions--
---------------------------------

function Moog_ClassPosRight (class)

	if(class==MOOGHUD_CLASS_WARRIOR) then return 0; end
	if(class==MOOGHUD_CLASS_MAGE) then return 0.25; end
	if(class==MOOGHUD_CLASS_ROGUE) then return 0.5; end
	if(class==MOOGHUD_CLASS_DRUID) then return 0.75; end
	if(class==MOOGHUD_CLASS_HUNTER) then return 0; end
	if(class==MOOGHUD_CLASS_SHAMAN) then return 0.25; end
	if(class==MOOGHUD_CLASS_PRIEST) then return 0.5; end
	if(class==MOOGHUD_CLASS_WARLOCK) then return 0.75; end
	if(class==MOOGHUD_CLASS_PALADIN) then return 0; end
	return nil;
end
function Moog_ClassPosLeft (class)

	if(class==MOOGHUD_CLASS_WARRIOR) then return 0.25; end
	if(class==MOOGHUD_CLASS_MAGE) then return 0.5; end
	if(class==MOOGHUD_CLASS_ROGUE) then return 0.75; end
	if(class==MOOGHUD_CLASS_DRUID) then return 1; end
	if(class==MOOGHUD_CLASS_HUNTER) then return 0.25; end
	if(class==MOOGHUD_CLASS_SHAMAN) then return 0.5; end
	if(class==MOOGHUD_CLASS_PRIEST) then return 0.75; end
	if(class==MOOGHUD_CLASS_WARLOCK) then return 1; end
	if(class==MOOGHUD_CLASS_PALADIN) then return 0.25; end
	return nil;
end
function Moog_ClassPosTop (class)
	if(class==MOOGHUD_CLASS_WARRIOR) then return 0; end
	if(class==MOOGHUD_CLASS_MAGE) then return 0; end
	if(class==MOOGHUD_CLASS_ROGUE) then return 0; end
	if(class==MOOGHUD_CLASS_DRUID) then return 0; end
	if(class==MOOGHUD_CLASS_HUNTER) then return 0.25; end
	if(class==MOOGHUD_CLASS_SHAMAN) then return 0.25; end
	if(class==MOOGHUD_CLASS_PRIEST) then return 0.25; end
	if(class==MOOGHUD_CLASS_WARLOCK) then return 0.25; end
	if(class==MOOGHUD_CLASS_PALADIN) then return 0.5; end
	return nil;
end
function Moog_ClassPosBottom (class)

	if(class==MOOGHUD_CLASS_WARRIOR) then return 0.25; end
	if(class==MOOGHUD_CLASS_MAGE) then return 0.25; end
	if(class==MOOGHUD_CLASS_ROGUE) then return 0.25; end
	if(class==MOOGHUD_CLASS_DRUID) then return 0.25; end
	if(class==MOOGHUD_CLASS_HUNTER) then return 0.5; end
	if(class==MOOGHUD_CLASS_SHAMAN) then return 0.5; end
	if(class==MOOGHUD_CLASS_PRIEST) then return 0.5; end
	if(class==MOOGHUD_CLASS_WARLOCK) then return 0.5; end
	if(class==MOOGHUD_CLASS_PALADIN) then return 0.75; end
	return nil;
end

