
-- Saved Data

PartySpotterSettings = {};





-- Local Variables

local timeSinceLastUpdate = 0;
local iiInterval = 10;
local timeSinceLastWMUpdate = 0;
local timeSinceLastBFMUpdate = 0;
local timeSinceLastAMUpdate = 0;
local updateInterval;
local highlightedGroup = 0;
local singleOut = "";

local PSTOPC = {};
PSTOPC.r = 0.64;
PSTOPC.g = 0.21;
PSTOPC.b = 0.93;

local groupColours = {
	"Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup1",
	"Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup2",
	"Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup3",
	"Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup4",
	"Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup5",
	"Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup6",
	"Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup7",
	};

local groupNumbers = {
	"Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup1t",
	"Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup2t",
	"Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup3t",
	"Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup4t",
	"Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup5t",
	"Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup6t",
	"Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup7t",
	"Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup8t",
};

local friendA = {};
local numberOfFriends = 0;
local ignoreA = {};
guildA = {};
numberOfGuildMembers = 0;






-- Local Constants

local PSTOP_DEFAULT_INTERVAL = 1;
local MAX_RAID_GROUPINGS = 8;









-- AddOn Functions

function PartySpotter_OnLoad()
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("FRIENDLIST_UPDATE");
	this:RegisterEvent("IGNORELIST_UPDATE");
	this:RegisterEvent("GUILD_ROSTER_UPDATE");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");

	SlashCmdList["PTSPOT"] = function(pList)
		PartySpotter_CmdLine(pList);
	end
	SLASH_PTSPOT1 = "/pspot";

	if ( not PartySpotterSettings.updateInterval ) then
		updateInterval = PSTOP_DEFAULT_INTERVAL;
		PartySpotterSettings.updateInterval = updateInterval;
	else
		updateInterval = PartySpotterSettings.updateInterval;
	end

	DEFAULT_CHAT_FRAME:AddMessage("PartySpotter v2.52.11200", PSTOPC.r, PSTOPC.g, PSTOPC.b);
end

function WorldMapPartySpotterKey_OnLoad()
	WorldMapPartySpotterKeyBttn1IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup1t");
	WorldMapPartySpotterKeyBttn2IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup2t");
	WorldMapPartySpotterKeyBttn3IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup3t");
	WorldMapPartySpotterKeyBttn4IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup4t");
	WorldMapPartySpotterKeyBttn5IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup5t");
	WorldMapPartySpotterKeyBttn6IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup6t");
	WorldMapPartySpotterKeyBttn7IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup7t");
	WorldMapPartySpotterKeyBttn8IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup8t");
end

function AlphaMapPartySpotterKey_OnLoad()
	AlphaMapPartySpotterKeyBttn1IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup1t");
	AlphaMapPartySpotterKeyBttn2IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup2t");
	AlphaMapPartySpotterKeyBttn3IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup3t");
	AlphaMapPartySpotterKeyBttn4IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup4t");
	AlphaMapPartySpotterKeyBttn5IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup5t");
	AlphaMapPartySpotterKeyBttn6IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup6t");
	AlphaMapPartySpotterKeyBttn7IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup7t");
	AlphaMapPartySpotterKeyBttn8IconsNumber:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGroup8t");
end



function PartySpotter_OnEvent()
	if ( event == "ADDON_LOADED" ) then
		if ( ( arg1 ) and ( arg1 == "Blizzard_BattlefieldMinimap" ) ) then
			PartySpotter_LoadBFM();
		end
	elseif ( event == "FRIENDLIST_UPDATE" ) then
		PartySpotter_UpdateFriends();
	elseif ( event == "IGNORELIST_UPDATE" ) then
		PartySpotter_UpdateIgnores();
	elseif ( event == "GUILD_ROSTER_UPDATE" ) then
		PartySpotter_UpdateGuild();
	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
		PartySpotter_UpdateGuild();
		PartySpotter_UpdateIgnores();
		PartySpotter_UpdateFriends();
	end
end



function PartySpotter_CmdLine(pList)
	nList = tonumber(pList);
	if ( nList == nil ) then
		nList = -1;
	end
	pList = string.lower(pList);
	local t2 = string.sub(pList, 1, 2);
	local tCap = string.sub(pList, 4, 4);
	local tRest = string.sub(pList, 5);
	if ( ( nList > 0 ) and ( nList < 9.001 ) ) then
		updateInterval = nList;
		PartySpotterSettings.updateInterval = updateInterval;
		DEFAULT_CHAT_FRAME:AddMessage("PartySpotter On : "..updateInterval..PSPOT_DELAY_SUFFIX, PSTOPC.r, PSTOPC.g, PSTOPC.b);

	elseif ( t2 == "-l" ) then
		if ( PartySpotterSettings.showLeader ) then
			PartySpotterSettings.showLeader = nil;
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_LEADER.." "..PSPOT_OFF, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		else
			PartySpotterSettings.showLeader = true;
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_LEADER, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		end

	elseif ( t2 == "-t" ) then
		if ( ( tCap ) and ( tCap ~= "" ) and ( tCap ~= " " ) and ( tRest ) ) then
			tCap = string.upper(tCap);
			singleOut = tCap..tRest;
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_INDI.." "..singleOut, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		else
			singleOut = "";
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_INDI.." "..PSPOT_OFF, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		end

	elseif ( nList == 0 ) then
		updateInterval = 0;
		PartySpotterSettings.updateInterval = 0;
		DEFAULT_CHAT_FRAME:AddMessage("PartySpotter "..PSPOT_OFF, PSTOPC.r, PSTOPC.g, PSTOPC.b);

	elseif ( pList == "reset" ) then
		PartySpotter_Reset();
		DEFAULT_CHAT_FRAME:AddMessage(PSPOT_HELP_TEXT);
		PartySpotter_ReportStatus();

	elseif ( pList == "showgroups icons" ) then
		PartySpotterSettings.showGroups = "Icons";
		DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_COLOUR_GROUPS, PSTOPC.r, PSTOPC.g, PSTOPC.b);

	elseif ( pList == "showgroups numbers" ) then
		PartySpotterSettings.showGroups = "Numbers";
		DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_NUMBER_GROUPS, PSTOPC.r, PSTOPC.g, PSTOPC.b);

	elseif ( pList == "showgroups off" ) then
		PartySpotterSettings.showGroups = nil;
		DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_DFLT_GROUPS, PSTOPC.r, PSTOPC.g, PSTOPC.b);

	elseif ( ( pList == "showfriends" ) or ( pList == "togglefriends" ) ) then
		PartySpotterSettings.showIgnores = nil;
		PartySpotterSettings.showGuild = nil;
		if ( pList == "showfriends" ) then
			if ( PartySpotterSettings.showFriends ) then
				PartySpotterSettings.showFriends = nil;
				DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_SHOW_FRIENDS.." " ..PSPOT_OFF, PSTOPC.r, PSTOPC.g, PSTOPC.b);
			else
				PartySpotterSettings.showFriends = "1";
				DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_SHOW_FRIENDS, PSTOPC.r, PSTOPC.g, PSTOPC.b);
			end
		else
			PartySpotterSettings.showFriends = "1";
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_SHOW_FRIENDS, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		end

	elseif ( ( pList == "showignores" ) or ( pList == "toggleignores" ) ) then
		PartySpotterSettings.showFriends = nil;
		PartySpotterSettings.showGuild = nil;
		if ( pList == "showignores" ) then
			if ( PartySpotterSettings.showIgnores ) then
				PartySpotterSettings.showIgnores = nil;
				DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_SHOW_IGNORES.." " ..PSPOT_OFF, PSTOPC.r, PSTOPC.g, PSTOPC.b);
			else
				PartySpotterSettings.showIgnores = "1";
				DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_SHOW_IGNORES, PSTOPC.r, PSTOPC.g, PSTOPC.b);
			end
		else
			PartySpotterSettings.showIgnores = "1";
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_SHOW_IGNORES, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		end

	elseif ( ( pList == "showguild" ) or ( pList == "toggleguild" ) ) then
		PartySpotterSettings.showFriends = nil;
		PartySpotterSettings.showIgnores = nil;
		if ( pList == "showguild" ) then
			if ( PartySpotterSettings.showGuild ) then
				PartySpotterSettings.showGuild = nil;
				DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_SHOW_GUILD.." " ..PSPOT_OFF, PSTOPC.r, PSTOPC.g, PSTOPC.b);
			else
				PartySpotterSettings.showGuild = "1";
				DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_SHOW_GUILD, PSTOPC.r, PSTOPC.g, PSTOPC.b);
			end
		else
			PartySpotterSettings.showGuild = "1";
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_SHOW_GUILD, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		end

	else
		DEFAULT_CHAT_FRAME:AddMessage(PSPOT_HELP_TEXT);
		PartySpotter_ReportStatus();
		local index = 0;
		local value = getglobal("PSPOT_HELP_TEXT"..index);
		while( value ) do
			DEFAULT_CHAT_FRAME:AddMessage(value);
			index = index + 1;
			value = getglobal("PSPOT_HELP_TEXT"..index);
		end
		DEFAULT_CHAT_FRAME:AddMessage(PSPOT_HELP_TEXT);
	end
end

function PartySpotter_ReportStatus()
	if ( ( PartySpotterSettings.updateInterval > 0 ) and ( PartySpotterSettings.updateInterval < 9 ) ) then
		DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PartySpotterSettings.updateInterval..PSPOT_DELAY_SUFFIX, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		if ( singleOut == "" ) then
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_INDI.." "..PSPOT_OFF, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		else
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_INDI.." "..singleOut, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		end
		if ( PartySpotterSettings.showLeader ) then
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_LEADER, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		else
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_LEADER.." "..PSPOT_OFF, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		end
		if ( PartySpotterSettings.showFriends ) then
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_SHOW_FRIENDS, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		elseif ( PartySpotterSettings.showIgnores ) then
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_SHOW_IGNORES, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		elseif ( PartySpotterSettings.showGuild ) then
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_SHOW_GUILD, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		else
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_NO_HLIGHTS, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		end
		if ( PartySpotterSettings.showGroups == "Icons" ) then
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_COLOUR_GROUPS, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		elseif ( PartySpotterSettings.showGroups == "Numbers" ) then
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_NUMBER_GROUPS, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		else
			DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_DFLT_GROUPS, PSTOPC.r, PSTOPC.g, PSTOPC.b);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("PartySpotter : "..PSPOT_OFF, PSTOPC.r, PSTOPC.g, PSTOPC.b);
	end
end





function PartySpotter_OnUpdate(arg1)
	timeSinceLastUpdate = timeSinceLastUpdate + arg1;
	if ( timeSinceLastUpdate > iiInterval ) then
		PartySpotter_UpdateIgnores();
		timeSinceLastUpdate = 0;
	end
end

function PartySpotterWM_OnUpdate(arg1)
	timeSinceLastWMUpdate = timeSinceLastWMUpdate + arg1;
	if ( timeSinceLastWMUpdate > updateInterval ) then
		PartySpotter_Update("WorldMap");
		timeSinceLastWMUpdate = 0;
	end
end

function PartySpotterBFM_OnUpdate(arg1)
	timeSinceLastBFMUpdate = timeSinceLastBFMUpdate + arg1;
	if ( timeSinceLastBFMUpdate > updateInterval ) then
		PartySpotter_Update("BattlefieldMinimap");
		timeSinceLastBFMUpdate = 0;
	end
end

function PartySpotterAM_OnUpdate(arg1)
	timeSinceLastAMUpdate = timeSinceLastAMUpdate + arg1;
	if ( timeSinceLastAMUpdate > updateInterval ) then
		PartySpotter_Update("AlphaMap");
		timeSinceLastAMUpdate = 0;
	end
end



function PartySpotter_KeyButton_OnClick(mouseBttn, id)
	if ( highlightedGroup > 0 ) then
		local WMBttn = getglobal("WorldMapPartySpotterKeyBttn"..highlightedGroup);
		if ( WMBttn ) then
			WMBttn:UnlockHighlight();
		end
		local AMBttn = getglobal("AlphaMapPartySpotterKeyBttn"..highlightedGroup);
		if ( AMBttn ) then
			AMBttn:UnlockHighlight();
		end
	end
	if ( id == highlightedGroup ) then
		highlightedGroup = 0;
	else
		highlightedGroup = id;
		local WMBttn = getglobal("WorldMapPartySpotterKeyBttn"..id);
		if ( WMBttn ) then
			WMBttn:LockHighlight();
		end
		local AMBttn = getglobal("AlphaMapPartySpotterKeyBttn"..id);
		if ( AMBttn ) then
			AMBttn:LockHighlight();
		end
	end
end



function PartySpotter_Update(Map)

	PartySpotter_ResetRaidSpots(Map);
	PartySpotter_ResetPartySpots(Map);

	if ( PartySpotterSettings.updateInterval == 0 ) then
		WorldMapPartySpotterKey:Hide();
		AlphaMapPartySpotterKey:Hide();
		return;
	end

	if ( ( not UnitInRaid("player") ) and ( GetNumPartyMembers() < 1 ) ) then
		if ( ( singleOut ~= "" ) or ( PartySpotterSettings.showFriends ) or ( PartySpotterSettings.showIgnores ) or ( PartySpotterSettings.showGuild ) ) then
			WorldMapPartySpotterKey:Hide();
			AlphaMapPartySpotterKey:Hide();
			for i=1, MAX_PARTY_MEMBERS, 1 do
				local partyIcon = getglobal(Map.."Party"..i);
				if ( ( partyIcon ) and ( partyIcon:IsVisible() ) ) then
					PartySpotter_UpdatePartyHighlight(Map, partyIcon, i);
--				else
--					break;
				end

			end
			for i=1, MAX_RAID_MEMBERS, 1 do
				local raidIcon = getglobal(Map.."Raid"..i);
				if ( ( raidIcon ) and ( raidIcon:IsVisible() ) ) then
					PartySpotter_UpdateRaidHighlight(Map, raidIcon, i);
--				else
--					break;
				end

			end
			return;
		end
	elseif ( UnitInRaid("player") ) then
		local pName = UnitName("player");
		local localGroup = 0;
		for i=1, MAX_RAID_MEMBERS, 1 do
			local rName, rDiscard, rSubGroup = GetRaidRosterInfo(i);
			if ( rName == pName ) then
				localGroup = rSubGroup;
			end
		end

		local mapKey = getglobal(Map.."PartySpotterKey");
		if ( ( PartySpotterSettings.showGroups ) and ( ( Map == "WorldMap" ) or ( Map == "AlphaMap" ) ) ) then
			if ( mapKey ) then
				for i = 1, MAX_RAID_GROUPINGS, 1 do
					local KeyOther = getglobal(Map.."PartySpotterKeyBttn"..i.."IconsOther");
					local KeyNumber = getglobal(Map.."PartySpotterKeyBttn"..i.."IconsNumber");
					local KeyParty = getglobal(Map.."PartySpotterKeyBttn"..i.."IconsParty");
					if ( i < localGroup ) then
						if ( PartySpotterSettings.showGroups == "Icons" ) then
							KeyOther:SetTexture(groupColours[i]);
							KeyOther:Show();
						else
							KeyOther:Hide();
						end
						KeyParty:Hide();
					elseif ( i > localGroup ) then
						if ( PartySpotterSettings.showGroups == "Icons" ) then
							KeyOther:SetTexture(groupColours[i-1]);
							KeyOther:Show();
						else
							KeyOther:Hide();
						end
						KeyParty:Hide();
					else
						KeyOther:Hide();
						KeyParty:Show();
					end
					mapKey:Show();
				end
			end
		else
			if ( mapKey ) then
				mapKey:Hide();
			end
		end

		-- Set Map Icons accordingly
		for i=1, MAX_RAID_MEMBERS, 1 do
			local raidIcon = getglobal(Map.."Raid"..i);
			if ( raidIcon ) then
				local unitHighlighted = nil;
				if ( ( singleOut ~= "" ) or ( PartySpotterSettings.showFriends ) or ( PartySpotterSettings.showIgnores ) or ( PartySpotterSettings.showGuild ) ) then
					unitHighlighted = PartySpotter_UpdateRaidHighlight(Map, raidIcon, i);
				end
				if ( not unitHighlighted ) then
					local spotRaid = getglobal(Map.."SpotRaid"..i);
					if ( raidIcon.name ) then
						spotRaid:Hide();
					else
						local rName, rRank, rSubGroup = GetRaidRosterInfo(i);
						local spotRaidTextureParty = getglobal(Map.."SpotRaid"..i.."PartySpot");
						local spotRaidTextureRaid = getglobal(Map.."SpotRaid"..i.."RaidSpot");
						local gIndex = rSubGroup;
						local raidUnitName;
						local uType = raidIcon.unit;
						if ( ( not uType ) or ( uType == "" ) or ( uType == "unit" ) ) then
							raidUnitName = "~";
						else
							raidUnitName = UnitName(uType);
						end
						if ( ( PartySpotterSettings.showLeader ) and ( rRank == 2 ) ) then
							spotRaidTextureRaid:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotLeader");
							spotRaid:SetFrameLevel( raidIcon:GetFrameLevel() + 3 );
							spotRaidTextureParty:Hide();
							spotRaidTextureRaid:Show();
							spotRaid:Show();
						elseif ( rSubGroup == localGroup ) then
							spotRaid:SetFrameLevel( raidIcon:GetFrameLevel() + 2 );
							spotRaidTextureRaid:Hide();
							spotRaidTextureParty:Show();
							spotRaid:Show();
						else
							if ( PartySpotterSettings.showGroups == "Icons" ) then
								if ( rSubGroup > localGroup ) then
									rSubGroup = rSubGroup - 1;
								end
								spotRaidTextureRaid:SetTexture(groupColours[rSubGroup]);
							elseif ( PartySpotterSettings.showGroups == "Numbers" ) then
								spotRaidTextureRaid:SetTexture(groupNumbers[rSubGroup]);
							else
								spotRaidTextureRaid:SetTexture(groupColours[1]);
							end
							if ( gIndex == highlightedGroup ) then
								spotRaid:SetFrameLevel( raidIcon:GetFrameLevel() + 3 );
							else
								spotRaid:SetFrameLevel( raidIcon:GetFrameLevel() );
							end
							spotRaidTextureParty:Hide();
							spotRaidTextureRaid:Show();
							spotRaid:Show();
						end
					end
				end
--			else
--				return;
			end
		end
	else
		for i = 1, MAX_PARTY_MEMBERS, 1 do
			local partyIcon = getglobal(Map.."Party"..i);
			if ( ( partyIcon ) and ( partyIcon:IsVisible() ) ) then
				local unitHighlighted = nil;
				if ( ( singleOut ~= "" ) or ( PartySpotterSettings.showFriends ) or ( PartySpotterSettings.showIgnores ) or ( PartySpotterSettings.showGuild ) ) then
					unitHighlighted = PartySpotter_UpdatePartyHighlight(Map, partyIcon, i);
				end
				if ( not unitHighlighted ) then
					local spotParty = getglobal(Map.."SpotParty"..i);
					local spotPartyIcon = getglobal(Map.."SpotParty"..i.."PartySpot");
					spotPartyIcon:Show();
					spotParty:Show();
				end
--			else
--				return;
			end
		end
	end
end



function PartySpotter_ResetRaidSpots(Map)
	for i=1, MAX_RAID_MEMBERS, 1 do
		local raidIcon = getglobal(Map.."Raid"..i);
		if ( ( raidIcon ) and ( raidIcon:IsVisible() ) ) then
			local spotRaid = getglobal(Map.."SpotRaid"..i);
			if ( spotRaid ) then
				spotRaid:Hide();
			end
		else
			return;
		end
	end
end

function PartySpotter_ResetPartySpots(Map)
	for i=1, MAX_PARTY_MEMBERS, 1 do
		local partyIcon = getglobal(Map.."Party"..i);
		if ( ( partyIcon ) and ( partyIcon:IsVisible() ) ) then
			local spotParty = getglobal(Map.."SpotParty"..i);
			local spotPartyTexture = getglobal(Map.."SpotParty"..i.."PartySpot");
			if ( spotParty ) then
				spotPartyTexture:SetTexture("Interface\\AddOns\\PartySpotter\\Artwork\\SpotPartyIcon");
				spotParty:Hide();
			end
		else
			return;
		end
	end
end



function PartySpotter_UpdateRaidHighlight(Map, raidIcon, raidIndex)
	local unitHighlighted = nil;
	local rName, spotRaid, spotRaidTextureParty, spotRaidTextureRaid;
	if ( raidIcon.name ) then
		rName = raidIcon.name;
	else
		local uType = raidIcon.unit;
		if ( ( uType == nil ) or ( uType == "" ) or ( uType == "unit" ) ) then
			return;
		end
		rName = UnitName(uType);
	end
	if ( rName == singleOut ) then
		spotRaid = getglobal(Map.."SpotRaid"..raidIndex);
		spotRaidTextureParty = getglobal(Map.."SpotRaid"..raidIndex.."PartySpot");
		spotRaidTextureRaid = getglobal(Map.."SpotRaid"..raidIndex.."RaidSpot");
		spotRaidTextureParty:Hide();
		spotRaidTextureRaid:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotTarget");
		spotRaid:SetFrameLevel( raidIcon:GetFrameLevel() + 3 );
		spotRaidTextureRaid:Show();
		spotRaid:Show();
		unitHighlighted = true;
	elseif ( PartySpotterSettings.showFriends ) then
		if ( numberOfFriends == 0 ) then
			PartySpotter_UpdateFriends();
		end
		if ( friendA[rName] ) then
			spotRaid = getglobal(Map.."SpotRaid"..raidIndex);
			spotRaidTextureParty = getglobal(Map.."SpotRaid"..raidIndex.."PartySpot");
			spotRaidTextureRaid = getglobal(Map.."SpotRaid"..raidIndex.."RaidSpot");
			spotRaidTextureParty:Hide();
			spotRaidTextureRaid:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotFriend");
			spotRaidTextureRaid:Show();
			spotRaid:Show();
			unitHighlighted = true;
		end
	elseif ( PartySpotterSettings.showIgnores ) then
		if ( ignoreA[rName] ) then
			spotRaid = getglobal(Map.."SpotRaid"..raidIndex);
			spotRaidTextureParty = getglobal(Map.."SpotRaid"..raidIndex.."PartySpot");
			spotRaidTextureRaid = getglobal(Map.."SpotRaid"..raidIndex.."RaidSpot");
			spotRaidTextureParty:Hide();
			spotRaidTextureRaid:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotIgnore");
			spotRaidTextureRaid:Show();
			spotRaid:Show();
			unitHighlighted = true;
		end
	elseif ( PartySpotterSettings.showGuild ) then
		if ( numberOfGuildMembers == 0 ) then
			PartySpotter_UpdateGuild();
		end
		if ( guildA[rName] ) then
			spotRaid = getglobal(Map.."SpotRaid"..raidIndex);
			spotRaidTextureParty = getglobal(Map.."SpotRaid"..raidIndex.."PartySpot");
			spotRaidTextureRaid = getglobal(Map.."SpotRaid"..raidIndex.."RaidSpot");
			spotRaidTextureParty:Hide();
			spotRaidTextureRaid:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGuild");
			spotRaidTextureRaid:Show();
			spotRaid:Show();
			unitHighlighted = true;
		end
	end
	return unitHighlighted;
end

function PartySpotter_UpdatePartyHighlight(Map, partyIcon, partyIndex)
	local unitHighlighted = nil;
	local spotParty, spotPartyTextureParty, spotPartyTextureRaid;
	local rName = UnitName(partyIcon.unit);
	if ( rName == singleOut ) then
		spotParty = getglobal(Map.."SpotParty"..partyIndex);
		spotPartyTextureParty = getglobal(Map.."SpotParty"..partyIndex.."PartySpot");
		spotPartyTextureRaid = getglobal(Map.."SpotParty"..partyIndex.."RaidSpot");
		spotPartyTextureRaid:Hide();
		spotPartyTextureParty:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotTarget");
		spotParty:SetFrameLevel( partyIcon:GetFrameLevel() + 3 );
		spotPartyTextureParty:Show();
		spotParty:Show();
		unitHighlighted = true;
	elseif ( PartySpotterSettings.showFriends ) then
		if ( numberOfFriends == 0 ) then
			PartySpotter_UpdateFriends();
		end
		if ( friendA[rName] ) then
			spotParty = getglobal(Map.."SpotParty"..partyIndex);
			spotPartyTextureParty = getglobal(Map.."SpotParty"..partyIndex.."PartySpot");
			spotPartyTextureRaid = getglobal(Map.."SpotParty"..partyIndex.."RaidSpot");
			spotPartyTextureRaid:Hide();
			spotPartyTextureParty:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotFriend");
			spotPartyTextureParty:Show();
			spotParty:Show();
			unitHighlighted = true;
		end
	elseif ( PartySpotterSettings.showIgnores ) then
		if ( ignoreA[rName] ) then
			spotParty = getglobal(Map.."SpotParty"..partyIndex);
			spotPartyTextureParty = getglobal(Map.."SpotParty"..partyIndex.."PartySpot");
			spotPartyTextureRaid = getglobal(Map.."SpotParty"..partyIndex.."RaidSpot");
			spotPartyTextureRaid:Hide();
			spotPartyTextureParty:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotIgnore");
			spotPartyTextureParty:Show();
			spotParty:Show();
			unitHighlighted = true;
		end
	elseif ( PartySpotterSettings.showGuild ) then
		if ( numberOfGuildMembers == 0 ) then
			PartySpotter_UpdateGuild();
		end
		if ( guildA[rName] ) then
			spotParty = getglobal(Map.."SpotParty"..partyIndex);
			spotPartyTextureParty = getglobal(Map.."SpotParty"..partyIndex.."PartySpot");
			spotPartyTextureRaid = getglobal(Map.."SpotParty"..partyIndex.."RaidSpot");
			spotPartyTextureRaid:Hide();
			spotPartyTextureParty:SetTexture("Interface\\Addons\\PartySpotter\\Artwork\\SpotGuild");
			spotPartyTextureParty:Show();
			spotParty:Show();
			unitHighlighted = true;
		end
	end
	return unitHighlighted;
end



function PartySpotter_LoadBFM()
	PartySpotterBFM:SetParent(BattlefieldMinimap);
	BattlefieldMinimapSpotParty1:SetParent(BattlefieldMinimapParty1);
	BattlefieldMinimapSpotParty2:SetParent(BattlefieldMinimapParty2);
	BattlefieldMinimapSpotParty3:SetParent(BattlefieldMinimapParty3);
	BattlefieldMinimapSpotParty4:SetParent(BattlefieldMinimapParty4);
	BattlefieldMinimapSpotRaid1:SetParent(BattlefieldMinimapRaid1);
	BattlefieldMinimapSpotRaid2:SetParent(BattlefieldMinimapRaid2);
	BattlefieldMinimapSpotRaid3:SetParent(BattlefieldMinimapRaid3);
	BattlefieldMinimapSpotRaid4:SetParent(BattlefieldMinimapRaid4);
	BattlefieldMinimapSpotRaid5:SetParent(BattlefieldMinimapRaid5);
	BattlefieldMinimapSpotRaid6:SetParent(BattlefieldMinimapRaid6);
	BattlefieldMinimapSpotRaid7:SetParent(BattlefieldMinimapRaid7);
	BattlefieldMinimapSpotRaid8:SetParent(BattlefieldMinimapRaid8);
	BattlefieldMinimapSpotRaid9:SetParent(BattlefieldMinimapRaid9);
	BattlefieldMinimapSpotRaid10:SetParent(BattlefieldMinimapRaid10);
	BattlefieldMinimapSpotRaid11:SetParent(BattlefieldMinimapRaid11);
	BattlefieldMinimapSpotRaid12:SetParent(BattlefieldMinimapRaid12);
	BattlefieldMinimapSpotRaid13:SetParent(BattlefieldMinimapRaid13);
	BattlefieldMinimapSpotRaid14:SetParent(BattlefieldMinimapRaid14);
	BattlefieldMinimapSpotRaid15:SetParent(BattlefieldMinimapRaid15);
	BattlefieldMinimapSpotRaid16:SetParent(BattlefieldMinimapRaid16);
	BattlefieldMinimapSpotRaid17:SetParent(BattlefieldMinimapRaid17);
	BattlefieldMinimapSpotRaid18:SetParent(BattlefieldMinimapRaid18);
	BattlefieldMinimapSpotRaid19:SetParent(BattlefieldMinimapRaid19);
	BattlefieldMinimapSpotRaid20:SetParent(BattlefieldMinimapRaid20);
	BattlefieldMinimapSpotRaid21:SetParent(BattlefieldMinimapRaid21);
	BattlefieldMinimapSpotRaid22:SetParent(BattlefieldMinimapRaid22);
	BattlefieldMinimapSpotRaid23:SetParent(BattlefieldMinimapRaid23);
	BattlefieldMinimapSpotRaid24:SetParent(BattlefieldMinimapRaid24);
	BattlefieldMinimapSpotRaid25:SetParent(BattlefieldMinimapRaid25);
	BattlefieldMinimapSpotRaid26:SetParent(BattlefieldMinimapRaid26);
	BattlefieldMinimapSpotRaid27:SetParent(BattlefieldMinimapRaid27);
	BattlefieldMinimapSpotRaid28:SetParent(BattlefieldMinimapRaid28);
	BattlefieldMinimapSpotRaid29:SetParent(BattlefieldMinimapRaid29);
	BattlefieldMinimapSpotRaid30:SetParent(BattlefieldMinimapRaid30);
	BattlefieldMinimapSpotRaid31:SetParent(BattlefieldMinimapRaid31);
	BattlefieldMinimapSpotRaid32:SetParent(BattlefieldMinimapRaid32);
	BattlefieldMinimapSpotRaid33:SetParent(BattlefieldMinimapRaid33);
	BattlefieldMinimapSpotRaid34:SetParent(BattlefieldMinimapRaid34);
	BattlefieldMinimapSpotRaid35:SetParent(BattlefieldMinimapRaid35);
	BattlefieldMinimapSpotRaid36:SetParent(BattlefieldMinimapRaid36);
	BattlefieldMinimapSpotRaid37:SetParent(BattlefieldMinimapRaid37);
	BattlefieldMinimapSpotRaid38:SetParent(BattlefieldMinimapRaid38);
	BattlefieldMinimapSpotRaid39:SetParent(BattlefieldMinimapRaid39);
	BattlefieldMinimapSpotRaid40:SetParent(BattlefieldMinimapRaid40);
	BattlefieldMinimapSpotParty1:SetPoint("CENTER", "BattlefieldMinimapParty1", "CENTER", 0, 0);
	BattlefieldMinimapSpotParty2:SetPoint("CENTER", "BattlefieldMinimapParty2", "CENTER", 0, 0);
	BattlefieldMinimapSpotParty3:SetPoint("CENTER", "BattlefieldMinimapParty3", "CENTER", 0, 0);
	BattlefieldMinimapSpotParty4:SetPoint("CENTER", "BattlefieldMinimapParty4", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid1:SetPoint("CENTER", "BattlefieldMinimapRaid1", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid2:SetPoint("CENTER", "BattlefieldMinimapRaid2", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid3:SetPoint("CENTER", "BattlefieldMinimapRaid3", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid4:SetPoint("CENTER", "BattlefieldMinimapRaid4", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid5:SetPoint("CENTER", "BattlefieldMinimapRaid5", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid6:SetPoint("CENTER", "BattlefieldMinimapRaid6", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid7:SetPoint("CENTER", "BattlefieldMinimapRaid7", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid8:SetPoint("CENTER", "BattlefieldMinimapRaid8", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid9:SetPoint("CENTER", "BattlefieldMinimapRaid9", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid10:SetPoint("CENTER", "BattlefieldMinimapRaid10", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid11:SetPoint("CENTER", "BattlefieldMinimapRaid11", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid12:SetPoint("CENTER", "BattlefieldMinimapRaid12", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid13:SetPoint("CENTER", "BattlefieldMinimapRaid13", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid14:SetPoint("CENTER", "BattlefieldMinimapRaid14", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid15:SetPoint("CENTER", "BattlefieldMinimapRaid15", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid16:SetPoint("CENTER", "BattlefieldMinimapRaid16", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid17:SetPoint("CENTER", "BattlefieldMinimapRaid17", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid18:SetPoint("CENTER", "BattlefieldMinimapRaid18", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid19:SetPoint("CENTER", "BattlefieldMinimapRaid19", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid20:SetPoint("CENTER", "BattlefieldMinimapRaid20", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid21:SetPoint("CENTER", "BattlefieldMinimapRaid21", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid22:SetPoint("CENTER", "BattlefieldMinimapRaid22", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid23:SetPoint("CENTER", "BattlefieldMinimapRaid23", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid24:SetPoint("CENTER", "BattlefieldMinimapRaid24", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid25:SetPoint("CENTER", "BattlefieldMinimapRaid25", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid26:SetPoint("CENTER", "BattlefieldMinimapRaid26", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid27:SetPoint("CENTER", "BattlefieldMinimapRaid27", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid28:SetPoint("CENTER", "BattlefieldMinimapRaid28", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid29:SetPoint("CENTER", "BattlefieldMinimapRaid29", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid30:SetPoint("CENTER", "BattlefieldMinimapRaid30", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid31:SetPoint("CENTER", "BattlefieldMinimapRaid31", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid32:SetPoint("CENTER", "BattlefieldMinimapRaid32", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid33:SetPoint("CENTER", "BattlefieldMinimapRaid33", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid34:SetPoint("CENTER", "BattlefieldMinimapRaid34", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid35:SetPoint("CENTER", "BattlefieldMinimapRaid35", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid36:SetPoint("CENTER", "BattlefieldMinimapRaid36", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid37:SetPoint("CENTER", "BattlefieldMinimapRaid37", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid38:SetPoint("CENTER", "BattlefieldMinimapRaid38", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid39:SetPoint("CENTER", "BattlefieldMinimapRaid39", "CENTER", 0, 0);
	BattlefieldMinimapSpotRaid40:SetPoint("CENTER", "BattlefieldMinimapRaid40", "CENTER", 0, 0);
	BattlefieldMinimapSpotParty1:SetFrameLevel( BattlefieldMinimapParty1:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotParty2:SetFrameLevel( BattlefieldMinimapParty2:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotParty3:SetFrameLevel( BattlefieldMinimapParty3:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotParty4:SetFrameLevel( BattlefieldMinimapParty4:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid1:SetFrameLevel( BattlefieldMinimapRaid1:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid2:SetFrameLevel( BattlefieldMinimapRaid2:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid3:SetFrameLevel( BattlefieldMinimapRaid3:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid4:SetFrameLevel( BattlefieldMinimapRaid4:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid5:SetFrameLevel( BattlefieldMinimapRaid5:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid6:SetFrameLevel( BattlefieldMinimapRaid6:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid7:SetFrameLevel( BattlefieldMinimapRaid7:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid8:SetFrameLevel( BattlefieldMinimapRaid8:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid9:SetFrameLevel( BattlefieldMinimapRaid9:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid10:SetFrameLevel( BattlefieldMinimapRaid10:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid11:SetFrameLevel( BattlefieldMinimapRaid11:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid12:SetFrameLevel( BattlefieldMinimapRaid12:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid13:SetFrameLevel( BattlefieldMinimapRaid13:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid14:SetFrameLevel( BattlefieldMinimapRaid14:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid15:SetFrameLevel( BattlefieldMinimapRaid15:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid16:SetFrameLevel( BattlefieldMinimapRaid16:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid17:SetFrameLevel( BattlefieldMinimapRaid17:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid18:SetFrameLevel( BattlefieldMinimapRaid18:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid19:SetFrameLevel( BattlefieldMinimapRaid19:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid20:SetFrameLevel( BattlefieldMinimapRaid20:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid21:SetFrameLevel( BattlefieldMinimapRaid21:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid22:SetFrameLevel( BattlefieldMinimapRaid22:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid23:SetFrameLevel( BattlefieldMinimapRaid23:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid24:SetFrameLevel( BattlefieldMinimapRaid24:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid25:SetFrameLevel( BattlefieldMinimapRaid25:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid26:SetFrameLevel( BattlefieldMinimapRaid26:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid27:SetFrameLevel( BattlefieldMinimapRaid27:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid28:SetFrameLevel( BattlefieldMinimapRaid28:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid29:SetFrameLevel( BattlefieldMinimapRaid29:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid30:SetFrameLevel( BattlefieldMinimapRaid30:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid31:SetFrameLevel( BattlefieldMinimapRaid31:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid32:SetFrameLevel( BattlefieldMinimapRaid32:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid33:SetFrameLevel( BattlefieldMinimapRaid33:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid34:SetFrameLevel( BattlefieldMinimapRaid34:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid35:SetFrameLevel( BattlefieldMinimapRaid35:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid36:SetFrameLevel( BattlefieldMinimapRaid36:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid37:SetFrameLevel( BattlefieldMinimapRaid37:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid38:SetFrameLevel( BattlefieldMinimapRaid38:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid39:SetFrameLevel( BattlefieldMinimapRaid39:GetFrameLevel() + 1 );
	BattlefieldMinimapSpotRaid40:SetFrameLevel( BattlefieldMinimapRaid40:GetFrameLevel() + 1 );
	PartySpotterBFM:Show();
end



function PartySpotter_UpdateFriends()
	friendA = {};
	numberOfFriends = 0;
	for i = 1, GetNumFriends(), 1 do
		local fName = GetFriendInfo(i);
		if ( ( fName ) and ( fName ~= "" ) ) then
			friendA[fName] = "1";
			numberOfFriends = numberOfFriends + 1;
		end
	end
end

function PartySpotter_UpdateIgnores()
	ignoreA = {};
	for i = 1, GetNumIgnores(), 1 do
		local iName = GetIgnoreName(i);
		if ( ( iName ) and ( iName ~= "" ) ) then
			ignoreA[iName] = "1";
		end
	end
	local pKey = GetCVar("realmName");
	if ( ( InfinateIgnore_Config ) and ( InfinateIgnore_Config[pKey] ) and ( InfinateIgnore_Config[pKey].Ignoring ) ) then
		local index, value;
		for index, value in InfinateIgnore_Config[pKey].Ignoring do
			local formattedCap = string.upper( string.sub(index, 1, 1) );
			local formattedRest = string.sub(index, 2, -1);
			local formattedName = formattedCap..formattedRest;
			ignoreA[formattedName] = "1";
		end
	end
end

function PartySpotter_UpdateGuild()
	GuildRoster();
	guildA = {};
	numberOfGuildMembers = 0;
	for i = 1, GetNumGuildMembers(), 1 do
		local gName = GetGuildRosterInfo(i);
		if ( ( gName ) and ( gName ~= "" ) ) then
			guildA[gName] = "1";
			numberOfGuildMembers = numberOfGuildMembers + 1;
		end
	end
end



function PartySpotter_Cycle_Mode()
	if ( ( PartySpotterSettings.showGroups ) and ( PartySpotterSettings.showGroups == "Icons" ) ) then
		PartySpotter_CmdLine("showgroups numbers");
	elseif ( ( PartySpotterSettings.showGroups ) and ( PartySpotterSettings.showGroups == "Numbers" ) ) then
		PartySpotter_CmdLine("showgroups off");
	else
		PartySpotter_CmdLine("showgroups icons");
	end
end

function PartySpotter_Cycle_Highlight()
	if ( PartySpotterSettings.showFriends ) then
		PartySpotter_CmdLine("toggleignores");
	elseif ( PartySpotterSettings.showIgnores ) then
		PartySpotter_CmdLine("toggleguild");
	elseif ( PartySpotterSettings.showGuild ) then
		PartySpotter_CmdLine("showguild");
	else
		PartySpotter_CmdLine("togglefriends");
	end
end





function PartySpotter_Reset()
	PartySpotterSettings.updateInterval = PSTOP_DEFAULT_INTERVAL;
	PartySpotterSettings.showGroups = nil;
	PartySpotterSettings.showFriends = nil;
	PartySpotterSettings.showIgnores = nil;
	PartySpotterSettings.showGuild = nil;
	PartySpotterSettings.showLeader = nil;
	singleOut = "";
	if ( highlightedGroup > 0 ) then
		local dummyBttn = "nil";
		PartySpotter_KeyButton_OnClick(dummyBttn, highlightedGroup);
	end
	WorldMapPartySpotterKey:SetUserPlaced(0);
	WorldMapPartySpotterKey:ClearAllPoints();
	WorldMapPartySpotterKey:SetPoint("BOTTOMRIGHT", WorldMapButton, "BOTTOMRIGHT", 0, 0);

	if ( AlphaMapFrame ) then
		AlphaMapPartySpotterKey:SetUserPlaced(0);
		AlphaMapPartySpotterKey:ClearAllPoints();
		AlphaMapPartySpotterKey:SetPoint("BOTTOMRIGHT", AlphaMapFrame, "BOTTOMRIGHT", 0, 0);
	end
end