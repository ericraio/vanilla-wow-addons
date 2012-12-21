CEBRogueClass = "Rogue";
CEBDruidClass = "Druid";
CEBMsg1 = "ComboEnergyBar available commands:";
CEBMsg2 = "/ceb show -> to show the panel";
CEBMsg3 = "/ceb hide -> to hide the panel";
CEBMsg4 = "/ceb combat -> to show the panel only when you are in combat and hide it otherwise";
if (GetLocale() == "frFR") then
-- Thanks to Morgeagnac e Arkantor for the French translation
	CEBRogueClass = "Voleur";
	CEBDruidClass = "Druide";
	CEBMsg1 = "Commandements disponibles pour la ComboEnergyBar:";
	CEBMsg2 = "/ceb show -> pour montrer la barre combo";
	CEBMsg3 = "/ceb hide -> pour cacher la barre combo";
	CEBMsg4 = "pour cacher la barre combo, mais pour qu'elle apparaisse automatiquement quand vous entrez en combat et se cache quand vous quittez le combat";
elseif (GetLocale() == "deDE") then
-- Thanks to Cherub and Dwain for the German translation
	CEBRogueClass = "Schurke";
	CEBDruidClass = "Druide";
	CEBMsg1 = "Befehle fuer ComboEnergyBar:";
	CEBMsg2 = "/ceb show -> ComboBar anzeigen";
	CEBMsg3 = "/ceb hide -> ComboBar verstecken";
	CEBMsg4 = "/ceb combat -> ComboBar verstecken wird im kampf automatisch angezeigt und nach dem kampf wieder versteckt";
end
local incombat = false;
local incatform = false;
local combobarenabled = true;
local baseBorderY = -1;
local baseBarY = -3;
local ComboEnergyBar_Version = 1.0;
local ComboEnergyBar_DefaultConfig = {
	show = false,
	combat = true,
	version = ComboEnergyBar_Version
};

function ComboEnergyBar_CheckCatForm()
	local cl = UnitClass("player");
	if (cl == CEBRogueClass) then
		return true;
	elseif (cl == CEBDruidClass) then
		local res = false;
		local i = 0;
		while GetPlayerBuffTexture(i) do
			local BuffTexture = GetPlayerBuffTexture(i);
			if (string.find(BuffTexture, "Ability_Druid_CatForm", 1, true)) then
				res = true;
			end
			i = i + 1;
		end
		return res;
	else
		return false;
	end
end

function ComboEnergyBar_MoveTargetBar(state)
    if (ComboEnergyBarFrame:IsVisible()) then
        local targetBorderY = baseBorderY;
        local targetBarY = baseBarY;
        local comboBorderY = baseBorderY;
        local comboBarY = baseBarY;
        
        if (state == "below") then
            targetBorderY = targetBorderY -5;
            targetBarY = targetBarY -5;
        else
            comboBorderY = comboBorderY -5;
            comboBarY = comboBarY -5;
        end
               
        local i = 0;
        local width = 3;
        for i = 1, 5 do
            local obj = getglobal("ComboEnergyBarBorder" .. i);
            obj:SetPoint("TOPLEFT", "ComboEnergyBarFrame", "TOPLEFT", width, comboBorderY);
            
            obj = getglobal("ComboEnergyBarBorder" .. i .. "Texture");
            obj:SetPoint("TOPLEFT", "ComboEnergyBarBorder" .. i, "TOPLEFT", width, comboBorderY);
            
            obj = getglobal("CEB" .. i);
            obj:SetPoint("TOPLEFT", "ComboEnergyBarBorder" .. i, "TOPLEFT", width + 2, comboBarY);
            
            width = width + 10;
        end
    end
end

function ComboEnergyBar_OnLoad()
	for i = 1, 5, 1 do
		local barname = getglobal("ComboEnergyBarCombo"..i);
		barname:SetStatusBarColor(1, 0, 0);
		barname:SetMinMaxValues(0, 1);
		barname:SetValue(0);
	end
	this:RegisterEvent("PLAYER_COMBO_POINTS");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_MAXHEALTH");
	this:RegisterEvent("UNIT_MAXENERGY");
	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTER_COMBAT");
	this:RegisterEvent("PLAYER_LEAVE_COMBAT");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	SlashCmdList["ComboEnergyBarCOMMAND"] = ComboEnergyBar_SlashHandler;
	SLASH_ComboEnergyBarCOMMAND1 = "/ceb";
end

function ComboEnergyBar_Toggle()
	local mainframe = getglobal("ComboEnergyBarFrame");
	if (not combobarenabled) then
		if (mainframe:IsVisible()) then
			mainframe:Hide();
		end
		return;
	end
	if (ComboEnergyBar_Config.show) then
		if (not mainframe:IsVisible()) then
			mainframe:Show();
		end
		return;
	else
		if (not ComboEnergyBar_Config.combat) then
			if (mainframe:IsVisible()) then
				mainframe:Hide();
			end
			return;
		else
			if (incombat and incatform) then
				if (not mainframe:IsVisible()) then
					mainframe:Show();
					return;
				end
			else
				if mainframe:IsVisible() then
					mainframe:Hide();
					return;
				end
			end
		end
	end
end

function CEB_Toggle(arg)
	if( arg == 1 ) then
		ComboEnergyBar_Config.show = true;
	elseif( arg == 0) then
		ComboEnergyBar_Config.show = false;
	else
		DEFAULT_CHAT_FRAME:AddMessage("CEB_Toggle(arg) returned invalid arg.");
	end
	ComboEnergyBar_Toggle();
end

function CEB_Combat()
		ComboEnergyBar_Config.show = false;
		ComboEnergyBar_Config.combat = true;
		ComboEnergyBar_Toggle();
end

function ComboEnergyBar_SlashHandler(msg)
	local cmd = string.lower(msg);
	if (cmd == "show") then
		ComboEnergyBar_Config.show = true;
		ComboEnergyBar_Config.combat = false;
		ComboEnergyBar_Toggle();
		return;
	elseif (cmd == "hide") then
		ComboEnergyBar_Config.show = false;
		ComboEnergyBar_Config.combat = false;
		ComboEnergyBar_Toggle();
		return;
	elseif (cmd == "combat") then
		ComboEnergyBar_Config.show = false;
		ComboEnergyBar_Config.combat = true;
		ComboEnergyBar_Toggle();
		return;
	end
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(CEBMsg1);
		DEFAULT_CHAT_FRAME:AddMessage(CEBMsg2);
		DEFAULT_CHAT_FRAME:AddMessage(CEBMsg3);
		DEFAULT_CHAT_FRAME:AddMessage(CEBMsg4);
	end
end

function ComboEnergyBarUpdateComboBar()
	local combo = GetComboPoints();
	local combobar = {0, 0, 0, 0, 0};
	local barcolor = {[0] = {1, 0, 0}, {1, 0, 0}, {1, 0, 0}, {1, 1, 0}, {1, 1, 0}, {0, 1, 0}};
	for i = 1, combo, 1 do
		combobar[i] = 1;
	end
	for i = 1, 5, 1 do
		local barname = getglobal("ComboEnergyBarCombo"..i);
		barname:SetStatusBarColor(barcolor[combo][1], barcolor[combo][2], barcolor[combo][3]);
		barname:SetValue(combobar[i]);
	end
end

function ComboEnergyBar_OnEvent(event)
	if (event == "PLAYER_COMBO_POINTS") then
		ComboEnergyBarUpdateComboBar();
	elseif (event == "PLAYER_ENTER_COMBAT") then
		incombat = true;
		ComboEnergyBar_Toggle();
	elseif (event == "PLAYER_LEAVE_COMBAT") then
		incombat = false;
		ComboEnergyBar_Toggle();
	elseif ((event == "UNIT_AURA") and (arg1 == "player")) then
		incatform = ComboEnergyBar_CheckCatForm();
		ComboEnergyBar_Toggle();
	elseif (event == "PLAYER_TARGET_CHANGED") then

	elseif (event == "VARIABLES_LOADED") then
		if ((not ComboEnergyBar_Config) or (not ComboEnergyBar_Config.version) or (ComboEnergyBar_Config.version ~= ComboEnergyBar_Version)) then
			ComboEnergyBar_Config = ComboEnergyBar_DefaultConfig;
		end
		if (UltimateUI_RegisterConfiguration) then
			CEB_RegisterUltimateUI();
		end
		ComboEnergyBar_Toggle();
	elseif (event == "PLAYER_ENTERING_WORLD") then
		local cl = UnitClass("player");
		if ((cl ~= CEBRogueClass) and (cl ~= CEBDruidClass)) then
			this:UnregisterEvent("PLAYER_COMBO_POINTS");
			this:UnregisterEvent("UNIT_HEALTH");
			this:UnregisterEvent("UNIT_MAXHEALTH");
			this:UnregisterEvent("UNIT_ENERGY");
			this:UnregisterEvent("UNIT_MAXENERGY");
			this:UnregisterEvent("UNIT_AURA");
			this:UnregisterEvent("VARIABLES_LOADED");
			this:UnregisterEvent("PLAYER_ENTER_COMBAT");
			this:UnregisterEvent("PLAYER_LEAVE_COMBAT");
			this:UnregisterEvent("PLAYER_TARGET_CHANGED");
			this:UnregisterEvent("PLAYER_ENTERING_WORLD");
			combobarenabled = false;
			ComboEnergyBar_Toggle();
		else
			incatform = ComboEnergyBar_CheckCatForm();
			ComboEnergyBarUpdateComboBar();
		end
	end
end

function CEB_RegisterUltimateUI()
	UltimateUI_RegisterConfiguration(
		"UUI_CEB",
		"SECTION",
		"Combo Energy Bar",
		"Options to configure Combo Energy Bar."
	);
	UltimateUI_RegisterConfiguration(
		"UUI_CEB_SEPARATOR",
		"SEPARATOR",
		"ComboEnergyBar",
		"Options to configure Combo Energy Bar."
	);
	UltimateUI_RegisterConfiguration(
		"UUI_CEB_ENABLE",
		"CHECKBOX",
		"Enable / Disable",
		"Check or uncheck this box to enable or disable ComboEnergyBar.",
		CEB_Toggle,
		1
	);
	UltimateUI_RegisterConfiguration(
		"UUI_CEB_COMBAT",
		"CHECKBOX",
		"Show only in combat",
		"Check or uncheck this box to show CEB while in combat.",
		CEB_Combat,
		0
	);
end

function ComboEnergyBarboolean()
	if combobarenabled then
		DEFAULT_CHAT_FRAME:AddMessage("combobar enabled");
	else
		DEFAULT_CHAT_FRAME:AddMessage("combobar not enabled");
	end
	if incombat then
		DEFAULT_CHAT_FRAME:AddMessage("in combat");
	else
		DEFAULT_CHAT_FRAME:AddMessage("not in combat");
	end
	if incatform then
		DEFAULT_CHAT_FRAME:AddMessage("in cat form");
	else
		DEFAULT_CHAT_FRAME:AddMessage("not in cat form");
	end
	local cl = UnitClass("player");
	if cl == CEBRogueClass then
		DEFAULT_CHAT_FRAME:AddMessage(CEBRogueClass);
	elseif cl == CEBDruidClass then
		DEFAULT_CHAT_FRAME:AddMessage(CEBDruidClass);
	else
		DEFAULT_CHAT_FRAME:AddMessage("classe non supportata");
	end
	DEFAULT_CHAT_FRAME:AddMessage(cl);
end