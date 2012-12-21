BINDING_HEADER_ZASHIR = "Zashir's Tome of Power";
BINDING_NAME_DEATHESTIMATOR = "Death Estimator";

DeathEstimatorLastHealth = {};
DeathEstimatorLastHealthTable = {};
DeathEstimatorLastTime = {};
DeathEstimatorDisplayLastUpdated = {};
DeathEstimatorUnitTypeList = { "player", "pet", "target", "party1", "party2", "party3", "party4" };
DeathEstimatorDisplayResetDelay = 5;
DeathEstimatorIntervalsToAverage = 10;

function DeathEstimator_OnLoad()
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("PLAYER_PET_CHANGED");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
		
	DeathEstimatorPlayerLabel:SetText("Player ETD:");
	DeathEstimatorPlayerText:SetText("??:??:??");
	DeathEstimatorPetLabel:SetText("Pet ETD:");
	DeathEstimatorTargetLabel:SetText("Target ETD:");
	
	DeathEstimator_OnEvent("PLAYER_PET_CHANGED");
	DeathEstimator_OnEvent("PLAYER_TARGET_CHANGED");
end

function DeathEstimator_PartyOnLoad()
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");	
	
	DeathEstimator_OnEvent("PARTY_MEMBERS_CHANGED");
end

function DeathEstimator_OnEvent(event)
	local DeathEstimatorPartyWindowHeight = 0;
	local DeathEstimatorWindowHeight = 64;

	if ( event == "PLAYER_PET_CHANGED" ) then
		if ( UnitExists("pet") ) then
			DeathEstimatorLastHealth["pet"] = UnitHealth("pet");
			DeathEstimatorPetButton:Show();
			DeathEstimatorTargetButton:SetPoint("TOPLEFT", "DeathEstimatorFrame", "TOPLEFT", 2, -32);
		else
			DeathEstimatorLastHealth["pet"] = nil;
			DeathEstimatorPetButton:Hide();
			DeathEstimatorTargetButton:SetPoint("TOPLEFT", "DeathEstimatorFrame", "TOPLEFT", 2, -16);
		end
		DeathEstimatorLastHealthTable["pet"] = {};
		DeathEstimatorPetText:SetText("??:??:??");
	end

	if ( event == "PLAYER_TARGET_CHANGED" ) then
		if ( UnitExists("target") ) then
			DeathEstimatorLastHealth["target"] = UnitHealth("target");
			DeathEstimatorTargetButton:Show();
		else
			DeathEstimatorLastHealth["target"] = nil;
			DeathEstimatorTargetButton:Hide();
		end
		DeathEstimatorLastHealthTable["target"] = {};
		DeathEstimatorTargetText:SetText("??:??:??");
	end
	
	if ( (event == "PLAYER_TARGET_CHANGED") or (event ==  "PLAYER_PET_CHANGED") ) then
		if ( not UnitExists("pet") ) then
			DeathEstimatorWindowHeight = DeathEstimatorWindowHeight - 16;
		end
		if ( not UnitExists("target") ) then
			DeathEstimatorWindowHeight = DeathEstimatorWindowHeight - 16;
		end
		if ( DeathEstimatorWindowHeight < 32 ) then
			DeathEstimatorWindowHeight = 32;
		end
		DeathEstimatorFrame:SetHeight(DeathEstimatorWindowHeight);
	end
	
	if ( event == "PARTY_MEMBERS_CHANGED" ) then
		if ( UnitInParty("party1") ) then
			DeathEstimatorPartyFrame:Show();
		else
			DeathEstimatorPartyFrame:Hide();
		end
		
		if ( UnitExists("party1") ) then
			DeathEstimatorParty1Label:SetText((UnitName("party1"))..":");
			DeathEstimatorParty1Text:SetText("??:??:??");
			DeathEstimatorParty1Button:Show();
			DeathEstimatorLastHealthTable["party1"] = {};
		else
			DeathEstimatorParty1Button:Hide();
		end
		if ( UnitExists("party2") ) then
			DeathEstimatorParty2Label:SetText((UnitName("party2"))..":");
			DeathEstimatorParty2Text:SetText("??:??:??");
			DeathEstimatorParty2Button:Show();
			DeathEstimatorLastHealthTable["party2"] = {};
		else
			DeathEstimatorParty2Button:Hide();
		end
		if ( UnitExists("party3") ) then
			DeathEstimatorParty3Label:SetText((UnitName("party3"))..":");
			DeathEstimatorParty3Text:SetText("??:??:??");
			DeathEstimatorParty3Button:Show();
			DeathEstimatorLastHealthTable["party3"] = {};
		else
			DeathEstimatorParty3Button:Hide();
		end
		if ( UnitExists("party4") ) then
			DeathEstimatorParty4Label:SetText((UnitName("party4"))..":");
			DeathEstimatorParty4Text:SetText("??:??:??");
			DeathEstimatorParty4Button:Show();
			DeathEstimatorLastHealthTable["party4"] = {};
		else
			DeathEstimatorParty4Button:Hide();
		end
		
		if ( DeathEstimatorPartyFrame:IsVisible() ) then
			for i = 1, 4, 1 do
				if ( UnitExists("party"..i) ) then
					DeathEstimatorPartyWindowHeight = DeathEstimatorPartyWindowHeight + 24;
				end
			end
			if ( DeathEstimatorPartyWindowHeight < 32 ) then
				DeathEstimatorPartyWindowHeight = 32;
			end
			if ( DeathEstimatorPartyWindowHeight == 72 ) then
				DeathEstimatorPartyWindowHeight = 64;
			end
			if ( DeathEstimatorPartyWindowHeight > 80 ) then
				DeathEstimatorPartyWindowHeight = 80;
			end
			DeathEstimatorPartyFrame:SetHeight(DeathEstimatorPartyWindowHeight);
		end
	end
end

function DeathEstimator_OnUpdate()
	local i
	local DeathEstimatorHealthLost = {};
	local DeathEstimatorHealthLossAverage = 0;

	for index, DeathEstimatorUnitType in DeathEstimatorUnitTypeList do
		if ( UnitExists(DeathEstimatorUnitType) ) then
			if ( not DeathEstimatorLastTime[DeathEstimatorUnitType] ) then
				DeathEstimatorLastTime[DeathEstimatorUnitType] = GetTime();
			end
		
			if ( (GetTime() - DeathEstimatorLastTime[DeathEstimatorUnitType]) >= 1 ) then
				DeathEstimatorLastTime[DeathEstimatorUnitType] = GetTime();
				
				if ( not DeathEstimatorLastHealth[DeathEstimatorUnitType] ) then 
					DeathEstimatorLastHealth[DeathEstimatorUnitType] = UnitHealth(DeathEstimatorUnitType);
				end
			
				if ( not DeathEstimatorLastHealthTable[DeathEstimatorUnitType] ) then
					DeathEstimatorLastHealthTable[DeathEstimatorUnitType] = {};
				end
			
				if ( not (DeathEstimatorLastHealth[DeathEstimatorUnitType] == UnitHealth(DeathEstimatorUnitType)) ) then
					DeathEstimatorHealthLost[DeathEstimatorUnitType] = DeathEstimatorLastHealth[DeathEstimatorUnitType] - UnitHealth(DeathEstimatorUnitType);
					DeathEstimatorLastHealth[DeathEstimatorUnitType] = UnitHealth(DeathEstimatorUnitType);
					table.insert(DeathEstimatorLastHealthTable[DeathEstimatorUnitType], DeathEstimatorHealthLost[DeathEstimatorUnitType]);
					if ( table.getn(DeathEstimatorLastHealthTable[DeathEstimatorUnitType]) >= DeathEstimatorIntervalsToAverage ) then
						for i = table.getn(DeathEstimatorLastHealthTable[DeathEstimatorUnitType]) - DeathEstimatorIntervalsToAverage + 1, table.getn(DeathEstimatorLastHealthTable[DeathEstimatorUnitType]), 1 do
							DeathEstimatorHealthLossAverage = DeathEstimatorHealthLossAverage + DeathEstimatorLastHealthTable[DeathEstimatorUnitType][i];
						end
						DeathEstimatorHealthLossAverage = DeathEstimatorHealthLossAverage / DeathEstimatorIntervalsToAverage;
					else
						for i = 1, table.getn(DeathEstimatorLastHealthTable[DeathEstimatorUnitType]), 1 do
							DeathEstimatorHealthLossAverage = DeathEstimatorHealthLossAverage + DeathEstimatorLastHealthTable[DeathEstimatorUnitType][i];
						end
						DeathEstimatorHealthLossAverage = DeathEstimatorHealthLossAverage / table.getn(DeathEstimatorLastHealthTable[DeathEstimatorUnitType]);
					end
					if ( DeathEstimatorHealthLossAverage > 0 ) then
						DeathEstimator_DisplayETD(DeathEstimatorHealthLossAverage, UnitHealth(DeathEstimatorUnitType), DeathEstimatorUnitType);
					else
						DeathEstimatorLastHealthTable[DeathEstimatorUnitType] = {};
					end
				else
					if ( UnitHealth(DeathEstimatorUnitType) == UnitHealthMax(DeathEstimatorUnitType) ) then
						DeathEstimatorLastHealthTable[DeathEstimatorUnitType] = {};
					else
						table.insert(DeathEstimatorLastHealthTable[DeathEstimatorUnitType], 0);
					end
				end
			end
		end
	end
	
	if ( DeathEstimatorDisplayLastUpdated["player"] and ((GetTime() - DeathEstimatorDisplayLastUpdated["player"]) >= DeathEstimatorDisplayResetDelay) ) then
		DeathEstimatorPlayerText:SetText("??:??:??");
		DeathEstimatorLastHealthTable["player"] = {};
	end
	if ( DeathEstimatorDisplayLastUpdated["pet"] and ((GetTime() - DeathEstimatorDisplayLastUpdated["pet"]) >= DeathEstimatorDisplayResetDelay) ) then
		DeathEstimatorPetText:SetText("??:??:??");
		DeathEstimatorLastHealthTable["pet"] = {};
	end
	if ( DeathEstimatorDisplayLastUpdated["target"] and ((GetTime() - DeathEstimatorDisplayLastUpdated["target"]) >= DeathEstimatorDisplayResetDelay) ) then
		DeathEstimatorTargetText:SetText("??:??:??");
		DeathEstimatorLastHealthTable["target"] = {};
	end
	if ( DeathEstimatorDisplayLastUpdated["party1"] and ((GetTime() - DeathEstimatorDisplayLastUpdated["party1"]) >= DeathEstimatorDisplayResetDelay) ) then
		if ( UnitExists("party1") ) then
			DeathEstimatorParty1Label:SetText((UnitName("party1"))..":"); 
			DeathEstimatorParty1Text:SetText("??:??:??");
		end
		DeathEstimatorLastHealthTable["party1"] = {};
	end
	if ( DeathEstimatorDisplayLastUpdated["party2"] and ((GetTime() - DeathEstimatorDisplayLastUpdated["party2"]) >= DeathEstimatorDisplayResetDelay) ) then
		if ( UnitExists("party2") ) then
			DeathEstimatorParty2Label:SetText((UnitName("party2"))..":"); 
			DeathEstimatorParty2Text:SetText("??:??:??");
		end
		DeathEstimatorLastHealthTable["party2"] = {};
	end
	if ( DeathEstimatorDisplayLastUpdated["party3"] and ((GetTime() - DeathEstimatorDisplayLastUpdated["party3"]) >= DeathEstimatorDisplayResetDelay) ) then
		if ( UnitExists("party3") ) then
			DeathEstimatorParty3Label:SetText((UnitName("party3"))..":"); 
			DeathEstimatorParty3Text:SetText("??:??:??");
		end
		DeathEstimatorLastHealthTable["party3"] = {};
	end
	if ( DeathEstimatorDisplayLastUpdated["party4"] and ((GetTime() - DeathEstimatorDisplayLastUpdated["party4"]) >= DeathEstimatorDisplayResetDelay) ) then
		if ( UnitExists("party4") ) then
			DeathEstimatorParty4Label:SetText((UnitName("party4"))..":"); 
			DeathEstimatorParty4Text:SetText("??:??:??");
		end
		DeathEstimatorLastHealthTable["party4"] = {};
	end
end

function DeathEstimator_DisplayETD(HealthLossAverage, TargetHealthLeft, TargetType)
	local MinutesToLive = "00";
	local HoursToLive = "00";
	local SecondsToLive = ceil(TargetHealthLeft / HealthLossAverage);
	
	if ( SecondsToLive >= 3600 ) then
		HoursToLive = floor(SecondsToLive / 3600);
		SecondsToLive = SecondsToLive - (HoursToLive * 3600);
		if ( HoursToLive < 10 ) then
			HoursToLive = "0"..(HoursToLive);
		end		
	end
	if ( SecondsToLive >= 60 ) then
		MinutesToLive = floor(SecondsToLive / 60);
		SecondsToLive = SecondsToLive - (MinutesToLive * 60);
		if ( MinutesToLive < 10 ) then
			MinutesToLive = "0"..(MinutesToLive);
		end
	end
	if ( SecondsToLive < 10 ) then
		SecondsToLive = "0"..(SecondsToLive);
	end
	
	if ( TargetType == "player" ) then
		DeathEstimatorPlayerText:SetText((HoursToLive)..":"..(MinutesToLive)..":"..(SecondsToLive));
	end
	if ( TargetType == "pet") then
		DeathEstimatorPetText:SetText((HoursToLive)..":"..(MinutesToLive)..":"..(SecondsToLive));
	end
	if ( TargetType == "target" ) then
		DeathEstimatorTargetText:SetText((HoursToLive)..":"..(MinutesToLive)..":"..(SecondsToLive));
	end
	
	if ( TargetType == "party1" ) then
		DeathEstimatorParty1Text:SetText((HoursToLive)..":"..(MinutesToLive)..":"..(SecondsToLive));
	end
	if ( TargetType == "party2" ) then
		DeathEstimatorParty2Text:SetText((HoursToLive)..":"..(MinutesToLive)..":"..(SecondsToLive));
	end
	if ( TargetType == "party3" ) then
		DeathEstimatorParty3Text:SetText((HoursToLive)..":"..(MinutesToLive)..":"..(SecondsToLive));
	end
	if ( TargetType == "party4" ) then
		DeathEstimatorParty4Text:SetText((HoursToLive)..":"..(MinutesToLive)..":"..(SecondsToLive));
	end
	
	DeathEstimatorDisplayLastUpdated[TargetType] = GetTime();
end

function ToggleDeathEstimator()
	if ( DeathEstimatorFrame:IsVisible() ) then
		DeathEstimatorFrame:Hide();
	else
		DeathEstimatorFrame:Show();
	end
end