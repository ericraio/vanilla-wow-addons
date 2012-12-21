function CT_RATest_OnHealth()
		local _, _, id = string.find(arg1, "^raid(%d+)$");
		if ( id ) then
			local name, hCurr, hMax = UnitName(arg1), UnitHealth(arg1), UnitHealthMax(arg1);
			if ( name ) then
				if ( UnitIsDead(arg1) or UnitIsGhost(arg1) ) then
					if ( not CT_RA_Stats[name] ) then
						CT_RA_Stats[name] = {
							["Buffs"] = { },
							["Debuffs"] = { },
							["Position"] = { }
						};
					end
					CT_RA_Stats[name]["Dead"] = 1;
					CT_RA_UpdateUnitStatus(getglobal("CT_RAMember" .. tonumber(id)));
				elseif ( CT_RA_Stats[name] and CT_RA_Stats[name]["Dead"] ) then
					if ( hCurr > 0 and not UnitIsGhost("raid" .. id) and CT_RA_Stats[name] ) then
						CT_RA_Stats[name]["Dead"] = nil;
					end
					CT_RA_UpdateUnitStatus(getglobal("CT_RAMember" .. tonumber(id)));
				else
					if ( CT_RA_Stats[name] ) then
						CT_RA_Stats[name]["Dead"] = nil;
					end
					CT_RA_UpdateUnitHealth(getglobal("CT_RAMember" .. tonumber(id)));
				end
				if ( CT_RA_Emergency_Units[name] or ( not CT_RA_EmergencyFrame.maxPercent or hCurr/hMax < CT_RA_EmergencyFrame.maxPercent ) ) then
					CT_RA_Emergency_UpdateHealth();
				end
			end
		elseif ( ( GetNumRaidMembers() == 0 and ( arg1 == "player" or string.find(arg1, "^party%d+$") ) ) ) then
			if ( CT_RA_Emergency_Units[UnitName(arg1)] or ( not CT_RA_EmergencyFrame.maxPercent or UnitHealth(arg1)/UnitHealthMax(arg1) < CT_RA_EmergencyFrame.maxPercent ) ) then
				CT_RA_Emergency_UpdateHealth();
			end
		end
end

function CT_RATest_OnAura()
		local useless, useless, id = string.find(arg1, "^raid(%d+)$");
		if ( id and not UnitIsUnit(arg1, "player") ) then
			local name = UnitName(arg1);
			if ( name ) then
				CT_RA_ScanPartyAuras(arg1, 1);
				if ( CT_RA_Stats[name] ) then
					CT_RA_UpdateUnitBuffs(CT_RA_Stats[name]["Buffs"], getglobal("CT_RAMember" .. id), name);
				end
--~ 				CT_RA_UpdateUnitStatus(getglobal("CT_RAMember" .. id));
			end
		elseif ( string.find(arg1, "^party%d+$") and CT_RA_Channel ) then
			local debuffs = CT_RA_ScanPartyAuras(arg1);
			local name = UnitName(arg1);
			if ( CT_RA_IsReportingForParty() and ( not CT_RA_Stats[name] or not CT_RA_Stats[name]["Reporting"] ) ) then
				if ( debuffs and type(debuffs) == "table" ) then
					for k, v in debuffs do
						CT_RA_AddMessage(v);
					end
				end
			end
		end
end

function CT_RATest_OnMana()
		local _, _, id = string.find(arg1, "^raid(%d+)$");
		if ( id ) then
			CT_RA_UpdateUnitMana(getglobal("CT_RAMember" .. tonumber(id)));
		end
end

function CT_RATest_OnRaid()
		if ( event == "RAID_ROSTER_UPDATE" ) then
			if ( GetNumRaidMembers() == 0 ) then
				CT_RA_MainTanks = { };
				CT_RA_Stats = { };
				CT_RA_ButtonIndexes = { };
			end
			if ( CT_RA_NumRaidMembers == 0 and GetNumRaidMembers() > 0 ) then
				CT_RA_UpdateFrame.SS = 10;
				if ( CT_RA_UpdateFrame.time ) then
					CT_RA_UpdateFrame.time = nil;
				end
				if ( not CT_RA_HasJoinedRaid ) then
					if ( CT_RA_Channel and GetChannelName(CT_RA_Channel) == 0 ) then
						CT_RA_Print("<CTRaid> First raid detected. To join the current RaidAssist channel (|c00FFFFFF" .. CT_RA_Channel .. "|r), use |c00FFFFFF/rajoin|r.", 1, 0.5, 0);
					elseif ( not CT_RA_Channel ) then
						CT_RA_Print("<CTRaid> First raid detected. There is currently no RaidAssist channel set. To set and join one, type |c00FFFFFF/rajoin [channel]|r, where |c00FFFFFF[channel]|r is the name of the channel to use.", 1, 0.5, 0);
					end
				end
				CT_RA_PartyMembers = { };
				CT_RA_HasJoinedRaid = 1;
			end
			CT_RA_CheckGroups();
		end
		if ( CT_RAMenu_Options["temp"]["ShowMonitor"] and GetNumRaidMembers() > 0 ) then
			CT_RA_ResFrame:Show();
		else
			CT_RA_ResFrame:Hide();
		end
		CT_RA_NumRaidMembers = GetNumRaidMembers();
		CT_RAOptions_Update();
		CT_RA_UpdateRaidGroup();
		CT_RA_UpdateMTs();
		if ( not CT_RA_Channel and GetGuildInfo("player") ) then
			CT_RA_Channel = "CT" .. string.gsub(GetGuildInfo("player"), "[^%w]", "");
		end
end