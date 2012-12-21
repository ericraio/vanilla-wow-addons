-- ZoneLevel.lua
-- Author: The Nerd Wonder (thenerdwonder@yahoo.com)

local zoneLevelShort;
local zoneLevelLow;
local zoneLevelHigh;
local zone;

-- Load/initialization function
function ZoneLevel_OnLoad()
	-- Register for events
	this:RegisterEvent("MINIMAP_ZONE_CHANGED");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	this:RegisterEvent("PLAYER_LEVEL_UP");
	
	SLASH_ZoneLevel1 = "/zonelevel";
	SLASH_ZoneLevel2 = "/zlvl";
	SlashCmdList["ZoneLevel"] = ZoneLevel_SlashHandler;
	SLASH_ZoneLevelInfo1 = "/zonelevelinfo";
	SLASH_ZoneLevelInfo2 = "/zinfo";
	SlashCmdList["ZoneLevelInfo"] = ZoneLevel_InfoHandler;

	if(TitanPanelModMenu_RegisterMenu) then
		zlvlArray = {
			frame = "ZoneLevelBase",
			cat = TITAN_MODMENU_CAT_MAP,
			text = "ZoneLevel",
			submenu = {
				{text = TITAN_MODMENU_TOGGLE..ZONELEVEL_TEXT, cmd = "/zlvl maptext"},
				{text = TITAN_MODMENU_TOGGLE..ZONELEVEL_ICON, cmd = "/zlvl icon"},
				TITAN_MODMENU_SPACER,
				{text = TITAN_MODMENU_HELP, cmd = "/zlvl"}
			}
		};
		
		TitanPanelModMenu_RegisterMenu("ZoneLevel", zlvlArray);
	end

	if(Cosmos_RegisterConfiguration) then
--[[		Sky.registerSlashCommand(
			{
				id="ZoneLevel";
				commands={"/zonelevel", "/zlvl"};
				onExecute=function (msg, cmd, ctype) ZoneLevel_SlashHandler(msg); end;
				helpText="Shows the help for ZoneLevel.";
			}
		);
]]--
		Cosmos_RegisterConfiguration(
			"COS_ZLVLOPTION",
			"SECTION",
			"ZoneLevel",
			ZONELEVEL_DESC
		);
		Cosmos_RegisterConfiguration(
			"COS_ZLVLICON",
			"CHECKBOX",
			ZONELEVEL_HELP_ICON,
			ZONELEVEL_HELP_ICON,
			ZoneLevel_IconHandler,
			1
		);
		Cosmos_RegisterConfiguration(
			"COS_ZLVLTEXT",
			"CHECKBOX",
			"Show text",
			ZONELEVEL_HELP_MINIMAP,
			ZoneLevel_TextHandler,
			0
		);
	end

	zoneLevelOnMap = false;
	zoneLevelShowIcon = true;
	zoneLevelLocked = false;

	-- Construct tables to hold level information for each zone
	zoneLevelLow={};
	zoneLevelHigh={};
	zoneLevelShort={};
	ZoneLevel_MakeTables();
end

function ZoneLevel_ShowTooltip()
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT");
	if(ZoneLevel_ZoneIsValid(GetRealZoneText())) then
		ZoneLevel_SetTooltipText();
	else
		GameTooltip:AddLine(ZONELEVEL_ZONENOTFOUNDTOOLTIP, 1.0, 1.0, 1.0);
	end
	GameTooltip:Show();
end

function ZoneLevel_StartDrag()
end

-- Cosmos handler for the icon
function ZoneLevel_IconHandler(arg1)
	if (arg1 == 1)
	then
		zoneLevelShowIcon = true;
		ZoneLevelBase:Show();
	else
		zoneLevelShowIcon = false;
		ZoneLevelBase:Hide();
	end
end

-- Cosmos handler for the text
function ZoneLevel_TextHandler(arg1)
	zone = string.lower(GetRealZoneText());
	if (arg1 == 1)
	then
		zoneLevelOnMap = true;
		if(ZoneLevel_ZoneIsValid(zone)) then
			if(zoneLevelLow[zone] < 1)
			then
				txt = "";
			else
				txt = "("..zoneLevelLow[GetRealZoneText()].." - "..zoneLevelHigh[GetRealZoneText()]..") ";
			end
		else
			txt = "(???) "
		end
		MinimapZoneText:SetText(txt..GetMinimapZoneText());
	else
		zoneLevelOnMap = false;
		MinimapZoneText:SetText(GetMinimapZoneText());
	end
end

-- Slash command handler for ZoneLevel
function ZoneLevel_SlashHandler(arg1)
	zone = string.lower(GetRealZoneText());
	
	if(arg1 == "")
	then
		DEFAULT_CHAT_FRAME:AddMessage(ZONELEVEL_HELP_HEADER..ZONELEVEL_HELP_MINIMAP..ZONELEVEL_HELP_MAPCMD..
							ZONELEVEL_HELP_ICON..ZONELEVEL_HELP_ICOCMD..ZONELEVEL_HELP_CMD);
	elseif(arg1 == "maptext")
	then
		if(zoneLevelOnMap)
		then
			MinimapZoneText:SetText(GetMinimapZoneText());
			zoneLevelOnMap = false;
			if (Cosmos_RegisterConfiguration)
			then
				Cosmos_UpdateValue("COS_ZLVLTEXT",CSM_CHECKONOFF,0);
				CosmosMaster_Save();
			end
		else
			if(ZoneLevel_ZoneIsValid(zone)) then
				if(zoneLevelLow[zone] < 1)
				then
					txt = "";
				else
					txt = "("..zoneLevelLow[zone].." - "..zoneLevelHigh[zone]..") ";
				end
			else
				txt = "(???) "
			end
			MinimapZoneText:SetText(txt..GetMinimapZoneText());
			zoneLevelOnMap = true;
			if (Cosmos_RegisterConfiguration)
			then
				Cosmos_UpdateValue("COS_ZLVLTEXT",CSM_CHECKONOFF,1);
				CosmosMaster_Save();
			end
		end
	elseif(arg1 == "icon")
	then
		if(zoneLevelShowIcon)
		then
			ZoneLevelBase:Hide();
			zoneLevelShowIcon = false;
			if (Cosmos_RegisterConfiguration)
			then
				Cosmos_UpdateValue("COS_ZLVLICON",CSM_CHECKONOFF,0);
				CosmosMaster_Save();
			end
		else
			ZoneLevelBase:Show();
			zoneLevelShowIcon = true;
			if (Cosmos_RegisterConfiguration)
			then
				Cosmos_UpdateValue("COS_ZLVLICON",CSM_CHECKONOFF,1);
				CosmosMaster_Save();
			end
		end
	elseif(arg1 == "lock")
	then
		DEFAULT_CHAT_FRAME:AddMessage("Locking");
		DEFAULT_CHAT_FRAME:AddMessage("var: "..tostring(zoneLevelLocked));
		
		zoneLevelLocked = true;
		ZoneLevelBase:GetTitleRegion():ClearAllPoints()
		ZoneLevelBase:GetTitleRegion():SetPoint("TOPLEFT", frame, "TOPLEFT", 0,0 )
		ZoneLevelBase:GetTitleRegion():SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 0,0 )
		
		DEFAULT_CHAT_FRAME:AddMessage("var: "..tostring(zoneLevelLocked));
	elseif(arg1 == "unlock")
	then
		DEFAULT_CHAT_FRAME:AddMessage("Unlocking");
		DEFAULT_CHAT_FRAME:AddMessage("var: "..tostring(zoneLevelLocked));

		zoneLevelLocked = false;
		ZoneLevelBase:GetTitleRegion():SetAllPoints(ZoneLevelBase);
		
		DEFAULT_CHAT_FRAME:AddMessage("var: "..tostring(zoneLevelLocked));
	else

		DEFAULT_CHAT_FRAME:AddMessage(string.format(ZONELEVEL_BADOPT, arg1));
	end

end

function ZoneLevel_InfoHandler(arg1)
	local lower = string.lower(arg1);
	
	capZone = ZoneLevel_TranslateShort(lower);
	if(zoneLevelLow[lower]) then
		zone = lower;
	else
		zone = string.lower(capZone);
	end
	
	if(ZoneLevel_ZoneIsValid(zone)) then
		if(ZoneLevel_ZoneIsTiered(zone))
		then
			low, high = ZoneLevel_HandleTiering(zone);
			txt = capZone.." "..(string.format(ZONELEVEL_ZONETEXT, low, high));
		else
			if(zoneLevelLow[zone] < 1)
			then
				txt = capZone.." "..ZONELEVEL_CITYTEXT;
			else
				txt = capZone.." "..(string.format(ZONELEVEL_ZONETEXT, zoneLevelLow[zone], zoneLevelHigh[zone]));
			end

--[[ Commented out for possible color coding in the future

			local mid = (low+high)/2;
			if(high < level-5) then -- Grey icon
				GameTooltip:AddLine(zone, 2.0, 2.0, 2.0);
			elseif(low > level+5) then -- Red icon
				GameTooltip:AddLine(zone, 1.0, 0.0, 0.0);
			elseif(mid < level) then -- Green icon
				GameTooltip:AddLine(zone, 0.0, 1.0, 0.0);
			else -- Yellow icon
				GameTooltip:AddLine(zone, 1.0, 1.0, 0.0);
			end
]]--
		end
	else -- Zone not found
		txt = ZONELEVEL_ZONENOTFOUNDTOOLTIP;
	end
	
	DEFAULT_CHAT_FRAME:AddMessage(txt);
end

-- Event handler for ZoneLevel
function ZoneLevel_OnEvent()
	if(event == "VARIABLES_LOADED")
	then
		if(zoneLevelShowIcon)
		then
			ZoneLevelBase:Show();
		else
			ZoneLevelBase:Hide();
		end

		if(not zoneLevelOnMap)
		then
			MinimapZoneText:SetText(GetMinimapZoneText());
		end

		if(zoneLevelLocked)
		then
			ZoneLevelBase:GetTitleRegion():ClearAllPoints()
			ZoneLevelBase:GetTitleRegion():SetPoint("TOPLEFT", frame, "TOPLEFT", 0,0 )
			ZoneLevelBase:GetTitleRegion():SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 0,0 )
		else
			ZoneLevelBase:GetTitleRegion():SetAllPoints(ZoneLevelBase);
		end
	else
		zone = string.lower(GetRealZoneText());
		local level = UnitLevel("player");

		if(ZoneLevel_ZoneIsValid(zone)) then
			local low = zoneLevelLow[zone];
			local high = zoneLevelHigh[zone];

			if(zoneLevelOnMap)
			then
				if(zoneLevelLow[zone] < 1)
				then
					txt = "(city) ";
				else
						txt = "("..zoneLevelLow[zone].." - "..zoneLevelHigh[zone]..") ";
				end
				MinimapZoneText:SetText(txt..GetMinimapZoneText());
			end

			local mid = (low+high)/2;
			if(zoneLevelLow[zone] < 1)
			then
				ZoneLevelGrey:Hide();
				ZoneLevelGreen:Hide();
				ZoneLevelYellow:Hide();
				ZoneLevelRed:Hide();
				ZoneLevelCity:Show();
				ZoneLevelBad:Hide();
			elseif(high < level-5) then -- Grey icon
				ZoneLevelGrey:Show();
				ZoneLevelGreen:Hide();
				ZoneLevelYellow:Hide();
				ZoneLevelRed:Hide();
				ZoneLevelCity:Hide();
				ZoneLevelBad:Hide();
			elseif(low > level+5) then -- Red icon
				ZoneLevelGrey:Hide();
				ZoneLevelGreen:Hide();
				ZoneLevelYellow:Hide();
				ZoneLevelRed:Show();
				ZoneLevelCity:Hide();
				ZoneLevelBad:Hide();
			elseif(mid < level) then -- Green icon
				ZoneLevelGrey:Hide();
				ZoneLevelGreen:Show();
				ZoneLevelYellow:Hide();
				ZoneLevelRed:Hide();
				ZoneLevelCity:Hide();
				ZoneLevelBad:Hide();
			else -- Yellow icon
				ZoneLevelGrey:Hide();
				ZoneLevelGreen:Hide();
				ZoneLevelYellow:Show();
				ZoneLevelRed:Hide();
				ZoneLevelCity:Hide();
				ZoneLevelBad:Hide();
			end
		else
			if(event == "ZONE_CHANGED_NEW_AREA")
			then
				DEFAULT_CHAT_FRAME:AddMessage(string.format(ZONELEVEL_ZONENOTFOUND, zone));
				ZoneLevelGrey:Hide();
				ZoneLevelGreen:Hide();
				ZoneLevelYellow:Hide();
				ZoneLevelRed:Hide();
				ZoneLevelCity:Hide();
				ZoneLevelBad:Show();
			end
		end

		if(zoneLevelShowIcon == false)
		then
			ZoneLevelBase:Hide();
		end
	end
end

function ZoneLevel_SetTooltipText()
	local level = UnitLevel("player");
	capZone = GetRealZoneText();
	zone = string.lower(capZone);
	
	local low = zoneLevelLow[zone];
	local high = zoneLevelHigh[zone];
	local txt;
	
	if(ZoneLevel_ZoneIsValid(zone)) then
		if(ZoneLevel_ZoneIsTiered(zone))
		then
			low, high = ZoneLevel_HandleTiering(zone);
		else
			if(zoneLevelLow[zone] < 1)
			then
				txt = ZONELEVEL_CITYTEXT;
			else
				txt = string.format(ZONELEVEL_ZONETEXT, zoneLevelLow[zone], zoneLevelHigh[zone]);
			end

			local mid = (low+high)/2;
			if(high < level-5) then -- Grey text
				GameTooltip:AddLine(capZone, 2.0, 2.0, 2.0);
			elseif(low > level+5) then -- Red text
				GameTooltip:AddLine(capZone, 1.0, 0.0, 0.0);
			elseif(mid < level) then -- Green text
				GameTooltip:AddLine(capZone, 0.0, 1.0, 0.0);
			else -- Yellow icon
				GameTooltip:AddLine(capZone, 1.0, 1.0, 0.0);
			end
		end
	else -- Zone not found
		txt = ZONELEVEL_ZONENOTFOUNDTOOLTIP;
	end

	GameTooltip:AddLine(txt, 1.0, 1.0, 1.0);
end

-- Returns true if zone is in table, false otherwise
function ZoneLevel_ZoneIsValid(zone)
	if(zone == nil or zoneLevelLow[string.lower(zone)] == nil)
	then
		retVal = false;
	else
		retVal = true;
	end

	return retVal;
end

function ZoneLevel_TranslateShort(zone)
	if(zone == nil)
	then
		return nil;
	end
	
	if(zoneLevelShort[zone] == nil)
	then
		return zone;
	else
		return zoneLevelShort[zone];
	end
end

-- Returns true is the zone is segregated by level ranges
function ZoneLevel_ZoneIsTiered(zone)
	if (zone == nil)
	then
		DEFAULT_CHAT_FRAME:AddMessage(ZONELEVEL_NOZONE);
		retVal = false;
	else
		if(zone == string.lower(WGch) or zone == string.lower(ABsn))
		then
			retVal = true;
		else
			retVal = false;
		end
	end
	
	return retVal;
end

-- Handles the level stuff for tiered zones
function ZoneLevel_HandleTiering(zone)
	local level = UnitLevel("player");
	local low;
	local high;
	if(level == 60)
	then
		low = 60;
		high = 60;
	elseif(level >= 50)
	then
		low = 50
		high = 59
	elseif(level >= 40)
	then
		low = 40
		high = 49
	elseif(level >= 30)
	then
		low = 30;
		high = 39
	elseif(level >= 20)
	then
		low = 20;
		high = 29
	elseif(level >= 10)
	then
		low = 10;
		high = 19
	end

	return low, high;
end

-- Makes tables containing level ranges for each zone
function ZoneLevel_MakeTables()
	-- Eastern Kingdom zones
	zoneLevelLow[string.lower(BtyB)]=-6;
	zoneLevelHigh[string.lower(BtyB)]=-6;
	zoneLevelLow[string.lower(Tram)]=-6;
	zoneLevelHigh[string.lower(Tram)]=-6;
	zoneLevelLow[string.lower(Irfg)]=-6;
	zoneLevelHigh[string.lower(Irfg)]=-6;
	zoneLevelLow[string.lower(StwC)]=-6;
	zoneLevelHigh[string.lower(StwC)]=-6;
	zoneLevelLow[string.lower(EwnF)]=1;
	zoneLevelHigh[string.lower(EwnF)]=10;
	zoneLevelLow[string.lower(DunM)]=1;
	zoneLevelHigh[string.lower(DunM)]=10;
	zoneLevelLow[string.lower(Tfal)]=1;
	zoneLevelHigh[string.lower(Tfal)]=10;
	zoneLevelLow[string.lower(LMod)]=10;
	zoneLevelHigh[string.lower(LMod)]=20;
	zoneLevelLow[string.lower(SvpF)]=10;
	zoneLevelHigh[string.lower(SvpF)]=20;
	zoneLevelLow[string.lower(Wtfl)]=10;
	zoneLevelHigh[string.lower(Wtfl)]=20;
	zoneLevelLow[string.lower(RrMt)]=15;
	zoneLevelHigh[string.lower(RrMt)]=25;
	zoneLevelLow[string.lower(Dkwd)]=18;
	zoneLevelHigh[string.lower(Dkwd)]=30;
	zoneLevelLow[string.lower(HdFt)]=20;
	zoneLevelHigh[string.lower(HdFt)]=30;
	zoneLevelLow[string.lower(Wtld)]=20;
	zoneLevelHigh[string.lower(Wtld)]=30;
	zoneLevelLow[string.lower(AcMt)]=30;
	zoneLevelHigh[string.lower(AcMt)]=40;
	zoneLevelLow[string.lower(AHld)]=30;
	zoneLevelHigh[string.lower(AHld)]=40;
	zoneLevelLow[string.lower(StrV)]=30;
	zoneLevelHigh[string.lower(StrV)]=50;
	zoneLevelLow[string.lower(Bdld)]=35;
	zoneLevelHigh[string.lower(Bdld)]=45;
	zoneLevelLow[string.lower(SoSs)]=35;
	zoneLevelHigh[string.lower(SoSs)]=45;
	zoneLevelLow[string.lower(DwPs)]=37;
	zoneLevelHigh[string.lower(DwPs)]=60;
	zoneLevelLow[string.lower(Htld)]=40;
	zoneLevelHigh[string.lower(Htld)]=50;
	zoneLevelLow[string.lower(SgGg)]=43;
	zoneLevelHigh[string.lower(SgGg)]=50;
	zoneLevelLow[string.lower(BlLd)]=45;
	zoneLevelHigh[string.lower(BlLd)]=55;
	zoneLevelLow[string.lower(BgSt)]=50;
	zoneLevelHigh[string.lower(BgSt)]=58;
	zoneLevelLow[string.lower(WPlg)]=51;
	zoneLevelHigh[string.lower(WPlg)]=58;
	zoneLevelLow[string.lower(EPlg)]=53;
	zoneLevelHigh[string.lower(EPlg)]=60;

	-- Kalimdor Zones
	zoneLevelLow[string.lower(Rcht)]=-6;
	zoneLevelHigh[string.lower(Rcht)]=-6;
	zoneLevelLow[string.lower(Gtzn)]=-6;
	zoneLevelHigh[string.lower(Gtzn)]=-6;
	zoneLevelLow[string.lower(Orgr)]=-6;
	zoneLevelHigh[string.lower(Orgr)]=-6;
	zoneLevelLow[string.lower(TdrB)]=-6;
	zoneLevelHigh[string.lower(TdrB)]=-6;
	zoneLevelLow[string.lower(Ucty)]=-6;
	zoneLevelHigh[string.lower(Ucty)]=-6;
	zoneLevelLow[string.lower(Drtr)]=1;
	zoneLevelHigh[string.lower(Drtr)]=10;
	zoneLevelLow[string.lower(Mlgr)]=1;
	zoneLevelHigh[string.lower(Mlgr)]=10;
	zoneLevelLow[string.lower(Dksr)]=10;
	zoneLevelHigh[string.lower(Dksr)]=20;
	zoneLevelLow[string.lower(Brns)]=10;
	zoneLevelHigh[string.lower(Brns)]=25;
	zoneLevelLow[string.lower(StMt)]=15;
	zoneLevelHigh[string.lower(StMt)]=27;
	zoneLevelLow[string.lower(Ashv)]=18;
	zoneLevelHigh[string.lower(Ashv)]=30;
	zoneLevelLow[string.lower(KNdl)]=25;
	zoneLevelHigh[string.lower(KNdl)]=35;
	zoneLevelLow[string.lower(Dslc)]=30;
	zoneLevelHigh[string.lower(Dslc)]=40;
	zoneLevelLow[string.lower(DtwM)]=35;
	zoneLevelHigh[string.lower(DtwM)]=45;
	zoneLevelLow[string.lower(Frls)]=40;
	zoneLevelHigh[string.lower(Frls)]=50;
	zoneLevelLow[string.lower(Tnrs)]=40;
	zoneLevelHigh[string.lower(Tnrs)]=50;
	zoneLevelLow[string.lower(Azsr)]=45;
	zoneLevelHigh[string.lower(Azsr)]=55;
	zoneLevelLow[string.lower(Flwd)]=48;
	zoneLevelHigh[string.lower(Flwd)]=55;
	zoneLevelLow[string.lower(Goro)]=48;
	zoneLevelHigh[string.lower(Goro)]=55;
	zoneLevelLow[string.lower(Slts)]=55;
	zoneLevelHigh[string.lower(Slts)]=60;
	zoneLevelLow[string.lower(Wtsg)]=55;
	zoneLevelHigh[string.lower(Wtsg)]=60;
	zoneLevelLow[string.lower(Hyal)]=60;
	zoneLevelHigh[string.lower(Hyal)]=60;
	zoneLevelLow[string.lower(AnQG)]=60;
	zoneLevelHigh[string.lower(AnQG)]=65;

	-- Elf zones & Moonglade
	zoneLevelLow[string.lower(Mngd)]=-6;
	zoneLevelHigh[string.lower(Mngd)]=-6;
	zoneLevelLow[string.lower(Darn)]=-6;
	zoneLevelHigh[string.lower(Darn)]=-6;
	zoneLevelLow[string.lower(Tldr)]=1;
	zoneLevelHigh[string.lower(Tldr)]=10;

	-- Battlegrounds
	zoneLevelLow[string.lower(AVal)]=60;
	zoneLevelHigh[string.lower(AVal)]=61;
	zoneLevelLow[string.lower(WGch)]=-6;
	zoneLevelHigh[string.lower(WGch)]=-6;
	zoneLevelLow[string.lower(ABsn)]=-6;
	zoneLevelHigh[string.lower(ABsn)]=-6;

	zoneLevelLow[string.lower(Outl)]=60;
	zoneLevelHigh[string.lower(Outl)]=75;

	-- Instances
	if(GetLocale() == "enUS") then
		zoneLevelLow[string.lower(Stck)]=24;
		zoneLevelHigh[string.lower(Stck)]=32;
		zoneLevelLow[string.lower(RfCm)]=13;
		zoneLevelHigh[string.lower(RfCm)]=18;
		zoneLevelLow[string.lower(ZlFk)]=44;
		zoneLevelHigh[string.lower(ZlFk)]=54;
		zoneLevelLow[string.lower(Ddmn)]=17;
		zoneLevelHigh[string.lower(Ddmn)]=26;
		zoneLevelLow[string.lower(WCvn)]=17;
		zoneLevelHigh[string.lower(WCvn)]=24;
		zoneLevelLow[string.lower(Grgn)]=29;
		zoneLevelHigh[string.lower(Grgn)]=38;
		zoneLevelLow[string.lower(RfKr)]=29;
		zoneLevelHigh[string.lower(RfKr)]=38;
		zoneLevelLow[string.lower(BlfD)]=24;
		zoneLevelHigh[string.lower(BlfD)]=32;
		zoneLevelLow[string.lower(SfKp)]=22;
		zoneLevelHigh[string.lower(SfKp)]=30;
		zoneLevelLow[string.lower(StMn)]=34;
		zoneLevelHigh[string.lower(StMn)]=45;
		zoneLevelLow[string.lower(Uldm)]=41;
		zoneLevelHigh[string.lower(Uldm)]=51;
		zoneLevelLow[string.lower(RfDn)]=37;
		zoneLevelHigh[string.lower(RfDn)]=46;
		zoneLevelLow[string.lower(Mrdn)]=46;
		zoneLevelHigh[string.lower(Mrdn)]=55;
		zoneLevelLow[string.lower(Onyx)]=60;
		zoneLevelHigh[string.lower(Onyx)]=62;
		zoneLevelLow[string.lower(BlMt)]=42;
		zoneLevelHigh[string.lower(BlMt)]=54;
		zoneLevelLow[string.lower(CvTm)]=43;
		zoneLevelHigh[string.lower(CvTm)]=61;
		zoneLevelLow[string.lower(Tmpl)]=50;
		zoneLevelHigh[string.lower(Tmpl)]=60;
		zoneLevelLow[string.lower(DrMl)]=56;
		zoneLevelHigh[string.lower(DrMl)]=60;
		zoneLevelLow[string.lower(BlrD)]=52;
		zoneLevelHigh[string.lower(BlrD)]=60;
		zoneLevelLow[string.lower(BlrS)]=55;
		zoneLevelHigh[string.lower(BlrS)]=60;
		zoneLevelLow[string.lower(Sthm)]=58;
		zoneLevelHigh[string.lower(Sthm)]=60;
		zoneLevelLow[string.lower(MCor)]=60;
		zoneLevelHigh[string.lower(MCor)]=62;
		zoneLevelLow[string.lower(Slmc)]=58;
		zoneLevelHigh[string.lower(Slmc)]=60;
		zoneLevelLow[string.lower(BlwL)]=60;
		zoneLevelHigh[string.lower(BlwL)]=62;
		zoneLevelLow[string.lower(ZlGb)]=60;
		zoneLevelHigh[string.lower(ZlGb)]=62;
		zoneLevelLow[string.lower(AnQR)]=60;
		zoneLevelHigh[string.lower(AnQR)]=65;
		zoneLevelLow[string.lower(AnQT)]=60;
		zoneLevelHigh[string.lower(AnQT)]=65;
		zoneLevelLow[string.lower(Naxx)]=60;
		zoneLevelHigh[string.lower(Naxx)]=65;
	else
		zoneLevelLow[string.lower(Stck)]=23;
		zoneLevelHigh[string.lower(Stck)]=26;
		zoneLevelLow[string.lower(RfCm)]=13;
		zoneLevelHigh[string.lower(RfCm)]=15;
		zoneLevelLow[string.lower(ZlFk)]=43;
		zoneLevelHigh[string.lower(ZlFk)]=47;
		zoneLevelLow[string.lower(Ddmn)]=15;
		zoneLevelHigh[string.lower(Ddmn)]=20;
		zoneLevelLow[string.lower(WCvn)]=15;
		zoneLevelHigh[string.lower(WCvn)]=21;
		zoneLevelLow[string.lower(Grgn)]=24;
		zoneLevelHigh[string.lower(Grgn)]=33;
		zoneLevelLow[string.lower(RfKr)]=25;
		zoneLevelHigh[string.lower(RfKr)]=35;
		zoneLevelLow[string.lower(BlfD)]=20;
		zoneLevelHigh[string.lower(BlfD)]=27;
		zoneLevelLow[string.lower(SfKp)]=18;
		zoneLevelHigh[string.lower(SfKp)]=25;
		zoneLevelLow[string.lower(StMn)]=30;
		zoneLevelHigh[string.lower(StMn)]=40;
		zoneLevelLow[string.lower(Uldm)]=35;
		zoneLevelHigh[string.lower(Uldm)]=45;
		zoneLevelLow[string.lower(RfDn)]=35;
		zoneLevelHigh[string.lower(RfDn)]=40;
		zoneLevelLow[string.lower(Mrdn)]=40;
		zoneLevelHigh[string.lower(Mrdn)]=49;
		zoneLevelLow[string.lower(Onyx)]=60;
		zoneLevelHigh[string.lower(Onyx)]=62;
		zoneLevelLow[string.lower(BlMt)]=42;
		zoneLevelHigh[string.lower(BlMt)]=54;
		zoneLevelLow[string.lower(CvTm)]=-6;
		zoneLevelHigh[string.lower(CvTm)]=-6;
		zoneLevelLow[string.lower(Tmpl)]=44;
		zoneLevelHigh[string.lower(Tmpl)]=50;
		zoneLevelLow[string.lower(DrMl)]=56;
		zoneLevelHigh[string.lower(DrMl)]=60;
		zoneLevelLow[string.lower(BlrD)]=48;
		zoneLevelHigh[string.lower(BlrD)]=56;
		zoneLevelLow[string.lower(BlrS)]=53;
		zoneLevelHigh[string.lower(BlrS)]=60;
		zoneLevelLow[string.lower(Sthm)]=55;
		zoneLevelHigh[string.lower(Sthm)]=60;
		zoneLevelLow[string.lower(MCor)]=60;
		zoneLevelHigh[string.lower(MCor)]=62;
		zoneLevelLow[string.lower(Slmc)]=56;
		zoneLevelHigh[string.lower(Slmc)]=60;
		zoneLevelLow[string.lower(BlwL)]=60;
		zoneLevelHigh[string.lower(BlwL)]=62;
		zoneLevelLow[string.lower(ZlGb)]=60;
		zoneLevelHigh[string.lower(ZlGb)]=62;
		zoneLevelLow[string.lower(AnQR)]=60;
		zoneLevelHigh[string.lower(AnQR)]=65;
		zoneLevelLow[string.lower(AnQT)]=60;
		zoneLevelHigh[string.lower(AnQT)]=65;
		zoneLevelLow[string.lower(Naxx)]=60;
		zoneLevelHigh[string.lower(Naxx)]=65;
	end
	
	-- Abbreviation table
	zoneLevelShort["alterac"] = AcMt;
	zoneLevelShort["alterac mountains"] = AcMt;
	zoneLevelShort["ab"] = ABsn;
	zoneLevelShort["aq"] = AnQG;
	zoneLevelShort["arathi basin"] = ABsn;
	zoneLevelShort["arathi"] = AHld;
	zoneLevelShort["arathi highlands"] = AHld;
	zoneLevelShort["av"] = AVal;
	zoneLevelShort["alterac valley"] = AVal;
	zoneLevelShort["ashenvale"] = Ashv;
	zoneLevelShort["azshara"] = Azsr;
	zoneLevelShort["badlands"] = Bdld;
	zoneLevelShort["bs"] = BgSt;
	zoneLevelShort["burning steppes"] = BgSt;
	zoneLevelShort["bfd"] = BlfD;
	zoneLevelShort["blackfathom deeps"] = BlfD;
	zoneLevelShort["bl"] = BlLd;
	zoneLevelShort["blasted lands"] = BlLd;
	zoneLevelShort["brm"] = BlMt;
	zoneLevelShort["blackrock mountain"] = BlMt;
	zoneLevelShort["brd"] = BlrD;
	zoneLevelShort["blackrock depths"] = BlrD;
	zoneLevelShort["brs"] = BlrS;
	zoneLevelShort["blackrock spire"] = BlrS;
	zoneLevelShort["barrens"] = Brns;
	zoneLevelShort["bwl"] = BlwL;
	zoneLevelShort["blackwing lair"] = BlwL;
	zoneLevelShort["bb"] = BtyB;
	zoneLevelShort["booty bay"] = BtyB;
	zoneLevelShort["cot"] = CvTm;
	zoneLevelShort["caverns of time"] = CvTm;
	zoneLevelShort["darkshore"] = Dksr;
	zoneLevelShort["darn"] = Darn;
	zoneLevelShort["darnassus"] = Darn;
	zoneLevelShort["deadmines"] = Ddmn;
	zoneLevelShort["deadwind"] = DwPs;
	zoneLevelShort["deadwind pass"] = DwPs;
	zoneLevelShort["desolace"] = Dslc;
	zoneLevelShort["dm"] = DrMl;
	zoneLevelShort["dire maul"] = DrMl;
	zoneLevelShort["dun morogh"] = DunM;
	zoneLevelShort["durotar"] = Drtr;
	zoneLevelShort["duskwood"] = Dkwd;
	zoneLevelShort["dustwallow"] = DtwM;
	zoneLevelShort["dwm"] = DtwM;
	zoneLevelShort["dustwallow marsh"] = DtwM;
	zoneLevelShort["epl"] = EPlg;
	zoneLevelShort["eastern plaguelands"] = EPlg;
	zoneLevelShort["elwynn"] = EwnF;
	zoneLevelShort["elwynn forest"] = EwnF;
	zoneLevelShort["felwood"] = Flwd;
	zoneLevelShort["feralas"] = Frls;
	zoneLevelShort["loch"] = LMod;
	zoneLevelShort["loch modan"] = LMod;
	zoneLevelShort["mulgore"] = Mlgr;
	zoneLevelShort["moonglade"] = Mngd;
	zoneLevelShort["silithus"] = Slts;
	zoneLevelShort["ungoro"] = Goro;
	zoneLevelShort["ungoro crater"] = Goro;
	zoneLevelShort["gnomer"] = Grgn;
	zoneLevelShort["gnomeregon"] = Grgn;
	zoneLevelShort["gadget"] = Gtzn;
	zoneLevelShort["gadgetzan"] = Gtzn;
	zoneLevelShort["hillsbrad"] = HdFt;
	zoneLevelShort["hillsbrad foothills"] = HdFt;
	zoneLevelShort["hinterlands"] = Htld;
	zoneLevelShort["1kn"] = KNdl;
	zoneLevelShort["thousand needles"] = KNdl;
	zoneLevelShort["mc"] = MCor;
	zoneLevelShort["molten core"] = MCor;
	zoneLevelShort["md"] = Mrdn;
	zoneLevelShort["maur"] = Mrdn;
	zoneLevelShort["mauradon"] = Mrdn;
	zoneLevelShort["nax"] = Naxx;
	zoneLevelShort["naxx"] = Naxx;
	zoneLevelShort["naxxramas"] = Naxx;
	zoneLevelShort["onyxia"] = Onyx;
	zoneLevelShort["onyx"] = Onyx;
	zoneLevelShort["onyxias lair"] = Onyx;
	zoneLevelShort["rfc"] = RfCm;
	zoneLevelShort["ragefire chasm"] = RfCm;
	zoneLevelShort["rfd"] = RfDn;
	zoneLevelShort["razorfen downs"] = RfDn;
	zoneLevelShort["rfk"] = RfKr;
	zoneLevelShort["razorfen kraul"] = RfKr;
	zoneLevelShort["redridge"] = RrMt;
	zoneLevelShort["redridge mts"] = RrMt;
	zoneLevelShort["redridge mountains"] = RrMt;
	zoneLevelShort["sfk"] = SfKp;
	zoneLevelShort["shadowfang keep"] = SfKp;
	zoneLevelShort["scholo"] = Slmc;
	zoneLevelShort["scholomance"] = Slmc;
	zoneLevelShort["stratholme"] = Sthm;
	zoneLevelShort["sos"] = SoSs;
	zoneLevelShort["swamp of sorrows"] = SoSs;
	zoneLevelShort["stockade"] = Stck;
	zoneLevelShort["sm"] = StMn;
	zoneLevelShort["scarlet monastery"] = StMn;
	zoneLevelShort["stonetalon"] = StMt;
	zoneLevelShort["stonetalon mts"] = StMt;
	zoneLevelShort["stonetalon mountains"] = StMt;
	zoneLevelShort["stv"] = StrV;
	zoneLevelShort["stranglethorn vale"] = StrV;
	zoneLevelShort["silverpine"] = SvpF;
	zoneLevelShort["silverpine forest"] = SvpF;
	zoneLevelShort["tb"] = TdrB;
	zoneLevelShort["thunder bluff"] = TdrB;
	zoneLevelShort["tirisfal"] = Tfal;
	zoneLevelShort["tirisfal glades"] = Tfal;
	zoneLevelShort["teldrassil"] = Trdl;
	zoneLevelShort["tanaris"] = Tnrs;
	zoneLevelShort["uldaman"] = Uldm;
	zoneLevelShort["westfall"] = Wtfl;
	zoneLevelShort["wetlands"] = Wtld;
	zoneLevelShort["ws"] = Wtsg;
	zoneLevelShort["winterspring"] = Wtsg;
	zoneLevelShort["st"] = Tmpl;
	zoneLevelShort["sunken temple"] = Tmpl;
	zoneLevelShort["wc"] = WCvn;
	zoneLevelShort["wailing caverns"] = WCvn;
	zoneLevelShort["wsg"] = WGch;
	zoneLevelShort["warsong gulch"] = WGch;
	zoneLevelShort["wpl"] = WPlg;
	zoneLevelShort["western plaguelands"] = WPlg;
	zoneLevelShort["zf"] = ZlFk;
	zoneLevelShort["zulfarrak"] = ZlFk;
	zoneLevelShort["zul farrak"] = ZlFk;
	zoneLevelShort["zg"] = ZlGb;
	zoneLevelShort["zulgurub"] = ZlGb;
	zoneLevelShort["zul gurub"] = ZlGb;
end