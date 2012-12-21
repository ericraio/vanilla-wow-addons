--[[
	titanSpeed:
	A simple speedometer.
	
	Author: Trentin
	Resurrected by: Quel
	Altered for TitanPanel +general messing with the code by: tainted (aka "Baou" @ Magtherion, EU realm)
	Further altered by: TotalPackage 01/23/2006
--]]

TITAN_SPEED_MENU_TEXT = "TitanSpeed";
TITAN_SPEED_BUTTON_LABEL = "Speed: ";
TITAN_SPEED_BUTTON_TEXT = "%s";
TITAN_SPEED_ID = "Speed";
TITAN_SPEED_FREQUENCY= 0.5;
TITAN_SPEED_NSR = "Set new rate (while running 100%)";
TITAN_SPEED_RSR = "Reset all rates";
TITAN_SPEED_SHOWTENTH = "Show tenths"

local TitanSpeedName = "TitanSpeed";
local TitanSpeedVersion = "1.10.1";

titanSpeedZoneBaseline2 = 
{ 
	{zid=1, rate=0.00375},	-- Alterac Mtns
	{zid=2, rate=0.0029167},	-- Arathi Highlands
	{zid=3, rate=0.0042},	-- Bad Lands
	{zid=4, rate=0.00313},	-- Blasted Lands
	{zid=5, rate=0.0035847},	-- Burning Steppes
	{zid=6, rate=0.00420},	-- Deadwind pass
	{zid=7, rate=0.0021319},	-- Dun Morogh
	{zid=8, rate=0.00388896},	-- Duskwood
	{zid=9, rate=0.00271},	-- Eastern Plaguelands
	{zid=10, rate=0.00302},	-- Elwynn Forest
	{zid=11, rate=0.00328},	-- Hillsbrad
	{zid=12, rate=0.013273},	-- Iron Forge
	{zid=13, rate=0.00381},	-- Loch Modan
	{zid=14, rate=0.00484},	-- Redridge Mnts
	{zid=15, rate=0.00471}, -- Searing Gorge
	{zid=16, rate=0.00250},	-- Rut'Theran Village might be 0.00209 or 0.00250
	{zid=17, rate=0.00781},	-- Stormwind
	{zid=18, rate=0.0016456},	-- Stranglethorn Vale
	{zid=19, rate=0.00458},	-- Swamp of Sorrows
	{zid=20, rate=0.00273},	-- Hinterlands
	{zid=21, rate=0.00232375},	-- Tristfall Glades
	{zid=22, rate=0.01094},	-- Undercity
	{zid=23, rate=0.00244},	-- Western Plaguelands
	{zid=24, rate=0.00300},	-- Westfall
	{zid=25, rate=0.002539}	-- Wetlands
};
titanSpeedZoneBaseline1 = 
{
	{zid=1, rate=0.00182097},	-- Ashenvale
	{zid=2, rate=0.00207},	-- Azshara
	{zid=3, rate=0.00160},	-- Darkshore
	{zid=4, rate=0.00992},	-- Darnassus
	{zid=5, rate=0.002335},	-- Desolace
	{zid=6, rate=0.00199},	-- Durotar
	{zid=7, rate=0.00200},	-- dustwallow marsh
	{zid=8, rate=0.00183},	-- felwood
	{zid=9, rate=0.00151},	-- feralas
	{zid=10, rate=0.00455},	-- Moonglade
	{zid=11, rate=0.00204},	-- Mulgore
	{zid=12, rate=0.00748},	-- Orgrimmar
	{zid=13, rate=0.0030135},	-- Silithus
	{zid=14, rate=0.00215},	-- Stonetalon Mtns
	{zid=15, rate=0.0015216},	-- Tanaris
	{zid=16, rate=0.00206},	-- Teldrassil
	{zid=17, rate=0.001036177},	-- The Barrens
	{zid=18, rate=0.00239},	-- Thousand Needles
	{zid=19, rate=0.01006},	-- Thunderbluff
	{zid=20, rate=0.00284},	-- Un'Goro Crater
	{zid=21, rate=0.00148},	-- Winterspring
	{zid=22, rate=0.0001},
	{zid=23, rate=0.0001},
	{zid=24, rate=0.0001},
	{zid=25, rate=0.0001}	
};	
titanSpeedZoneOthers = 
{
	["Blackrock Mountain"] = {
		["rate"] = 0.00029832,
	},
	["Warsong Gulch"] = {
		["rate"] = 0.00915914,
	},
	["Alterac Valley"] = {
		["rate"] = 0.00247787,
	},
	["Arathi Basin"] = {
		["rate"] = 0.00597869,
	},
};


function TitanPanelSpeedButton_OnLoad()
	this.registry={
		id=TITAN_SPEED_ID,
		menuText=TITAN_SPEED_MENU_TEXT,
		buttonTextFunction="TitanPanelSpeedButton_GetButtonText",
		tooltipTitle = TITAN_SPEED_ID,
		tooltipTextFunction = "TitanPanelSpeedButton_GetTooltipText",
		frequency=TITAN_SPEED_FREQUENCY,
		icon = "Interface\\Icons\\Ability_Rogue_Sprint.blp",
		iconWidth = 16,
		category = "Information",
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = TITAN_NIL,
			ShowTenth = TITAN_NIL,
		},
	};	
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	this:RegisterEvent("VARIABLES_LOADED");
end


function TitanPanelSpeed_OnShow()
	if (WorldMapFrame:IsVisible()) then
		titanspeedflag = 1;
	end
end


function TitanPanelSpeed_OnEvent()
	if event=="ZONE_CHANGED_NEW_AREA" then
		SetMapToCurrentZone();
	elseif event=="VARIABLES_LOADED" then
		if (not ZoneBaseline2 or not ZoneBaseline1) then
			TitanSpeed_Reset();
		elseif (not ZoneOthers) then
			ZoneOthers = titanSpeedZoneOthers;
		end
	end
end


function TitanPanelSpeedButton_GetButtonText(id)
	if (fSpeed == nil) then
		return;
	elseif (fSpeed < 0) then
		return TITAN_SPEED_BUTTON_LABEL,format(TITAN_SPEED_BUTTON_TEXT,TitanUtils_GetHighlightText("??%"));
	elseif ( TitanGetVar(TITAN_SPEED_ID, "ShowTenth") == 1) then
		return TITAN_SPEED_BUTTON_LABEL,format(TITAN_SPEED_BUTTON_TEXT,TitanUtils_GetHighlightText(format("%0.1f", fSpeed).."%"));
	else
		return TITAN_SPEED_BUTTON_LABEL,format(TITAN_SPEED_BUTTON_TEXT,TitanUtils_GetHighlightText(format("%d", TitanSpeed_Round(fSpeed)).."%"));	
	end
end

function TitanPanelSpeedButton_GetTooltipText()
	return "Displays your current movement\n  speed as a percent relative\n  to your normal running speed.\n"..TitanUtils_GetGreenText("Use: Right-click for options.");
end

function TitanPanelSpeedButton_OnUpdate(arg1)
	if (UnitName("player") == nil) then
		return;
	end
	if titanspeedflag and not WorldMapFrame:IsVisible() then
		SetMapToCurrentZone();
		titanspeedflag = nil;
	end
	if (lastPos == nil) then
		setRate = false;
		iDeltaTime = 0;
		fSpeed = 0.0;
		fSpeedDist = 0.0;
		CurrPos = {};
		lastPos = {};
		lastPos.x, lastPos.y = GetPlayerMapPosition("player");	
	end
	iDeltaTime = iDeltaTime + arg1;
	CurrPos.x, CurrPos.y = GetPlayerMapPosition("player");
	local dist = math.sqrt(
			((lastPos.x - CurrPos.x) * (lastPos.x - CurrPos.x) * 2.25 ) +
			((lastPos.y - CurrPos.y) * (lastPos.y - CurrPos.y))
			);	
	fSpeedDist = fSpeedDist + dist;
	if (iDeltaTime >= .4) then	
		local zonenum = GetCurrentMapZone();
		local zonename = GetZoneText();
		local contnum;
		local baserate; 
		if (zonenum ~= 0) then
			contnum = GetCurrentMapContinent();
			if (setRate == true) then
				local rate;
				rate = (fSpeedDist / iDeltaTime);
				if (contnum == 2) then
					ZoneBaseline2[zonenum].rate = rate;
				else
					ZoneBaseline1[zonenum].rate = rate;
				end
				DEFAULT_CHAT_FRAME:AddMessage("TitanSpeed :: Base-rate for zone "..zonenum.." set to "..rate);
				setRate = false;
			end			
			if (contnum == 2) then
				baserate = ZoneBaseline2[zonenum].rate;
			else
				baserate = ZoneBaseline1[zonenum].rate;
			end		
			fSpeed = ((fSpeedDist / iDeltaTime) / baserate) * 100;	
			fSpeedDist = 0.0;
			iDeltaTime = 0.0;				
			TitanPanelButton_UpdateButton(TITAN_SPEED_ID);
			
		else
			if (setRate == true) then
				local rate = (fSpeedDist / iDeltaTime);
				if ( ZoneOthers[zonename] == nil ) then
					ZoneOthers[zonename] = {};
				end
				ZoneOthers[zonename].rate = rate;
					
				DEFAULT_CHAT_FRAME:AddMessage("TitanSpeed :: Base-rate for zone "..zonename.." set to "..rate);
				setRate = false;
			end
			if( ZoneOthers[zonename] ~= nil ) then
				baserate = ZoneOthers[zonename].rate;
				if( baserate ~= 0 ) then
					fSpeed = ((fSpeedDist / iDeltaTime) / baserate) * 100;
				else
					fSpeed = -1.0;
				end
			else
				fSpeed = -1.0;
			end
			fSpeedDist = 0.0;
			iDeltaTime = 0.0;				
			TitanPanelButton_UpdateButton(TITAN_SPEED_ID);
		end
	end
	lastPos.x = CurrPos.x;
	lastPos.y = CurrPos.y;
end


function TitanSpeed_Round(x)
	if(x - floor(x) >= 0.5) then
		x = floor(x + 0.5);
	else
		x = floor(x);
	end
	return x;
end


function TitanSpeed_ToggleRate()
	setRate = true;
end


function TitanSpeed_ToggleReset()
	StaticPopupDialogs["TITANSPEED_RESET"] = {
		text = TEXT("Are you sure you want to reset all base-rates for TitanSpeed?"),
		button1 = TEXT(OKAY),
		button2 = TEXT(CANCEL),
		OnAccept = function()
			TitanSpeed_Reset();
		end,
		timeout = 0,
		exclusive = 1
	};
	StaticPopup_Show("TITANSPEED_RESET");
end

function TitanSpeed_ToggleShowTenth()
	TitanToggleVar(TITAN_SPEED_ID, "ShowTenth");
	TitanPanelButton_UpdateButton(TITAN_SPEED_ID);
end

function TitanSpeed_Reset()
	ZoneBaseline2 = titanSpeedZoneBaseline2;
	ZoneBaseline1 = titanSpeedZoneBaseline1;
	ZoneOthers = titanSpeedZoneOthers;

	DEFAULT_CHAT_FRAME:AddMessage("TitanSpeed :: Base-rates initialize/reset for all zones.");
end


function TitanPanelRightClickMenu_PrepareSpeedMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_SPEED_ID].menuText);
	
	info = {};
	info.text = TITAN_SPEED_NSR;
	info.func = TitanSpeed_ToggleRate;
	info.checked = nil;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = TITAN_SPEED_RSR;
	info.func = TitanSpeed_ToggleReset;
	info.checked = nil;
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();
	
	info = {};
	info.text = TITAN_SPEED_SHOWTENTH;
	info.func = TitanSpeed_ToggleShowTenth;
	info.checked = TitanGetVar(TITAN_SPEED_ID, "ShowTenth");
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);
	
	TitanPanelRightClickMenu_AddSpacer();
	
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_SPEED_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_SPEED_ID);
	
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_SPEED_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end