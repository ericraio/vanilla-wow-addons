CT_RA_DebuffOptions = { };
CT_RADebuff_CureTable = { [1] = { } };
CT_RADebuff_ActionButtons = { };
CT_RADebuff_NamePriorities = { };
CT_RADebuff_CureSpells = {
	[CT_RA_PRIEST] = { [CT_RA_MAGIC] = CT_RA_DISPELMAGIC, [CT_RA_DISEASE] = { CT_RA_CUREDISEASE, CT_RA_ABOLISHDISEASE } },
	[CT_RA_SHAMAN] = { [CT_RA_DISEASE] = CT_RA_CUREDISEASE, [CT_RA_POISON] = CT_RA_CUREPOISON },
	[CT_RA_DRUID] = { [CT_RA_CURSE] = CT_RA_REMOVECURSE, [CT_RA_POISON] = { CT_RA_CUREPOISON, CT_RA_ABOLISHPOISON } },
	[CT_RA_MAGE] = { [CT_RA_CURSE] = CT_RA_REMOVELESSERCURSE },
	[CT_RA_PALADIN] = { [CT_RA_MAGIC] = CT_RA_CLEANSE, [CT_RA_POISON] = { CT_RA_PURIFY, CT_RA_CLEANSE }, [CT_RA_DISEASE] = { CT_RA_PURIFY, CT_RA_CLEANSE } }
};
CT_RADebuff_IgnoreDebuffs = {
	["Dreamless Sleep"] = 1,
	["Greater Dreamless Sleep"] = 1,
--~ 	["Mind Vision"] = 1
};
CT_RA_DebuffTemplates = {
	[1] = {
		["debuffName"] = "Soul Burn",
		["name"] = "Soul Burn",
		["debuffDesc"] = ".*",
		["cureOrder"] = {
			[1] = 1,
			[2] = 8,
			[3] = 15,
			[4] = 16,
			[5] = 17,
			[6] = 10,
			[7] = 11,
			[8] = 12,
			[9] = 14,
			[10] = 9,
			[11] = 13,
			[12] = 5,
			[13] = 6,
			[14] = 7,
		},
		["affectClasses"] = {
			["Warrior"] = 1,
			["Paladin"] = 1,
			["Shaman"] = 1,
			["Rogue"] = 1,
			["Mage"] = 1,
			["Pets"] = 1,
			["Druid"] = 1,
			["Priest"] = 1,
			["Hunter"] = 1,
			["Warlock"] = 1,
		},
		["debuffType"] = ".*",
	},
	[2] = {
		["debuffName"] = "Mark of Kazzak",
		["name"] = "Mark of Kazzak",
		["debuffDesc"] = ".*",
		["cureOrder"] = {
			[1] = 1,
			[2] = 2,
			[3] = 3,
			[4] = 4,
			[5] = 5,
			[6] = 6,
			[7] = 7,
		},
		["affectClasses"] = {
			["Paladin"] = 1,
			["Shaman"] = 1,
			["Mage"] = 1,
			["Pets"] = 1,
			["Druid"] = 1,
			["Priest"] = 1,
			["Hunter"] = 1,
			["Warlock"] = 1,
		},
		["debuffType"] = ".*",
	},
	[3] = {
		["debuffName"] = "Twisted Reflection",
		["name"] = "Twisted Reflection",
		["debuffDesc"] = ".*",
		["cureOrder"] = {
			[1] = 1,
			[2] = 2,
			[3] = 3,
			[4] = 4,
			[5] = 5,
			[6] = 6,
			[7] = 7,
		},
		["affectClasses"] = {
			["Warrior"] = 1,
			["Paladin"] = 1,
			["Shaman"] = 1,
			["Rogue"] = 1,
			["Mage"] = 1,
			["Pets"] = 1,
			["Druid"] = 1,
			["Priest"] = 1,
			["Hunter"] = 1,
			["Warlock"] = 1,
		},
		["debuffType"] = ".*",
	},
	[4] = {
		["debuffName"] = "Dominate Mind",
		["name"] = "Dominate Mind",
		["debuffDesc"] = ".*",
		["cureOrder"] = {
			[1] = 8,
			[2] = 9,
			[3] = 1,
			[4] = 2,
			[5] = 3,
			[6] = 4,
			[7] = 5,
			[8] = 6,
			[9] = 7,
		},
		["affectClasses"] = {
			["Warrior"] = 1,
			["Paladin"] = 1,
			["Shaman"] = 1,
			["Rogue"] = 1,
			["Mage"] = 1,
			["Pets"] = 1,
			["Druid"] = 1,
			["Priest"] = 1,
			["Hunter"] = 1,
			["Warlock"] = 1,
		},
		["debuffType"] = ".*",
	},
	[5] = {
		["debuffName"] = "Ignite Mana",
		["name"] = "Ignite Mana",
		["debuffDesc"] = ".*",
		["cureOrder"] = {
			[1] = 1,
			[2] = 2,
			[3] = 3,
			[4] = 4,
			[5] = 5,
			[6] = 7,
			[7] = 6,
			[8] = 8,
		},
		["affectClasses"] = {
			["Paladin"] = 1,
			["Shaman"] = 1,
			["Mage"] = 1,
			["Pets"] = 1,
			["Druid"] = 1,
			["Priest"] = 1,
			["Hunter"] = 1,
			["Warlock"] = 1,
		},
		["debuffType"] = ".*",
	},
	[6] = {
		["debuffName"] = "Mind Control",
		["name"] = "Mind Control",
		["debuffDesc"] = ".*",
		["cureOrder"] = {
			[1] = 1,
			[2] = 2,
			[3] = 3,
			[4] = 4,
			[5] = 5,
			[6] = 6,
			[7] = 7,
		},
		["affectClasses"] = {
			["Warrior"] = 1,
			["Paladin"] = 1,
			["Shaman"] = 1,
			["Rogue"] = 1,
			["Mage"] = 1,
			["Pets"] = 1,
			["Druid"] = 1,
			["Priest"] = 1,
			["Hunter"] = 1,
			["Warlock"] = 1,
		},
		["debuffType"] = ".*",
	},
	[7] = {
		["debuffName"] = ".*",
		["name"] = "Silencing Spells",
		["debuffDesc"] = ".*Cannot cast spells.*",
		["cureOrder"] = {
			[1] = 1,
			[2] = 2,
			[3] = 3,
			[4] = 4,
			[5] = 5,
			[6] = 6,
			[7] = 7,
		},
		["affectClasses"] = {
			["Warrior"] = 1,
			["Paladin"] = 1,
			["Shaman"] = 1,
			["Mage"] = 1,
			["Pets"] = 1,
			["Druid"] = 1,
			["Priest"] = 1,
			["Hunter"] = 1,
			["Warlock"] = 1,
		},
		["debuffType"] = ".*",
	},
	[8] = {
		["debuffName"] = ".*Polymorph.*",
		["name"] = "Polymorph",
		["debuffDesc"] = ".*",
		["cureOrder"] = {
			[1] = 1,
			[2] = 2,
			[3] = 3,
			[4] = 4,
			[5] = 5,
			[6] = 6,
			[7] = 7,
		},
		["affectClasses"] = {
			["Warrior"] = 1,
			["Paladin"] = 1,
			["Shaman"] = 1,
			["Rogue"] = 1,
			["Mage"] = 1,
			["Pets"] = 1,
			["Druid"] = 1,
			["Priest"] = 1,
			["Hunter"] = 1,
			["Warlock"] = 1,
		},
		["debuffType"] = ".*",
	},
	[9] = {
		["debuffName"] = ".*",
		["name"] = "All Spells",
		["debuffDesc"] = ".*",
		["cureOrder"] = {
			[1] = 1,
			[2] = 2,
			[3] = 3,
			[4] = 8,
			[5] = 4,
			[6] = 5,
			[7] = 6,
			[8] = 7,
		},
		["affectClasses"] = {
			["Warrior"] = 1,
			["Paladin"] = 1,
			["Shaman"] = 1,
			["Rogue"] = 1,
			["Mage"] = 1,
			["Pets"] = 1,
			["Druid"] = 1,
			["Priest"] = 1,
			["Hunter"] = 1,
			["Warlock"] = 1,
		},
		["debuffType"] = ".*",
	},
}
CT_RADebuff_ClassIndexes = {
	[CT_RA_WARRIOR] = 1,
	[CT_RA_DRUID] = 2,
	[CT_RA_MAGE] = 3,
	[CT_RA_WARLOCK] = 4,
	[CT_RA_ROGUE] = 5,
	[CT_RA_HUNTER] = 6,
	[CT_RA_PRIEST] = 7,
	[CT_RA_PALADIN] = 8,
	[CT_RA_SHAMAN] = 9
};
-- Thanks to the author of Decursive for the blacklist idea
CT_RADebuff_Blacklist = { };
CT_RADebuff_BlacklistTime = 3;
CT_RADebuff_Debug = 1;

----------------------------------------------------------------
--                 CT_RADebuff_DebugMsg(msg)                  --
--        Prints a message if the debug flag is enabled.      --
----------------------------------------------------------------

function CT_RADebuff_DebugMsg(msg)
	if ( CT_RADebuff_Debug ) then
		CT_Print(msg);
	end
end

----------------------------------------------------------------
--           CT_RADebuff_ProcessBlacklist(elapsed)            --
--        Processes the blacklist, removing people when       --
--          they have been in there for three seconds.        --
----------------------------------------------------------------

function CT_RADebuff_ProcessBlacklist(elapsed)
	for k, v in CT_RADebuff_Blacklist do
		CT_RADebuff_Blacklist[k] = v - elapsed;
		if ( CT_RADebuff_Blacklist[k] <= 0 ) then
			CT_RADebuff_Blacklist[k] = nil;
		end
	end
	if ( CT_RADebuff_ResetCombat ) then
		CT_RADebuff_ResetCombat = CT_RADebuff_ResetCombat - elapsed;
		if ( CT_RADebuff_ResetCombat <= 0 ) then
			CT_RADebuff_ResetCombat = nil;
			if ( not CT_RADebuff_InCombat ) then
				AttackTarget();
			end
		end
	end
end

----------------------------------------------------------------
--                CT_RADebuff_UpdateCureTable()                --
--          Updates the table holding all the debuffs.         --
----------------------------------------------------------------

function CT_RADebuff_UpdateCureTable()
	CT_RADebuff_CureTable = { };
	if ( UnitExists("target") and ( UnitCanAttack("player", "target") or ( not UnitInRaid("target") and not UnitInParty("target") ) ) ) then
		local useBuffs = UnitDebuff;
		if ( UnitCanAttack("player", "target") and ( not UnitIsCharmed("target") or not UnitIsFriend("player", "target") ) ) then
			useBuffs = UnitBuff;
		end
		if ( not CT_RADebuff_Blacklist[UnitName("target")] ) then
			local iIndex = 1;
			-- Loop through the debuffs
			while ( useBuffs("target", iIndex) ) do
				-- Clear and set the tooltip
				CT_RATooltipTextLeft1:SetText("");
				CT_RATooltipTextRight1:SetText("");
				if ( useBuffs == UnitBuff ) then
					CT_RATooltip:SetUnitBuff("target", iIndex);
				else
					CT_RATooltip:SetUnitDebuff("target", iIndex);
				end
				-- Control to make sure we have a new debuff
				if ( CT_RATooltipTextLeft1:GetText() ~= "" ) then
				
					-- Fetch the data
					local sName, sType, sDesc, iTblIndex = CT_RATooltipTextLeft1:GetText() or "", CT_RATooltipTextRight1:GetText() or "", CT_RATooltipTextLeft2:GetText() or "", -1;
					if ( sType ~= "" and CT_RADebuff_CanCure(sType) and not CT_RADebuff_IgnoreDebuffs[(sName or "")] ) then
						-- See if we can find the CT_RA_DebuffTemplates index
						for k, v in CT_RA_DebuffTemplates do
						
							-- See if we have a match
							if ( string.find(strlower(sName), strlower(v["debuffName"])) and string.find(strlower(sType), strlower(v["debuffType"])) and string.find(strlower(sDesc), strlower(v["debuffDesc"])) ) then
								iTblIndex = k;
								break;
							end
						end
						
						if ( iTblIndex > 0 and ( not CT_RADebuff_CureTable[2] or CT_RADebuff_CureTable[2] > iTblIndex ) ) then
							-- Clean the table
							CT_RADebuff_CureTable = {
								[1] = {
									{ sName, sType, sDesc, "target", CT_RADebuff_ClassIndexes[UnitClass("target")], UnitHealth("target") }
								},
								[2] = iTblIndex
							};
							
						elseif ( iTblIndex > 0 and iTblIndex == CT_RADebuff_CureTable[2] ) then
							-- Add the data to the table, as well as class, health percentage, if the player is in your party or if the player is you
							tinsert(CT_RADebuff_CureTable[1], { sName, sType, sDesc, "target", CT_RADebuff_ClassIndexes[UnitClass("target")], UnitHealth("target") });
							
						end
					end
				end
				
				iIndex = iIndex + 1;
				
			end
		end
	end
	if ( GetNumRaidMembers() == 0 ) then
		if ( not CT_RADebuff_Blacklist[UnitName("player")] ) then
			local iIndex = 1;
			
			-- Loop through the debuffs
			while ( UnitDebuff("player", iIndex) ) do
				-- Clear and set the tooltip
				CT_RATooltipTextLeft1:SetText("");
				CT_RATooltipTextRight1:SetText("");
				CT_RATooltip:SetUnitDebuff("player", iIndex);
				
				-- Control to make sure we have a new debuff
				if ( CT_RATooltipTextLeft1:GetText() ~= "" ) then
					-- Fetch the data
					local sName, sType, sDesc, iTblIndex = CT_RATooltipTextLeft1:GetText() or "", CT_RATooltipTextRight1:GetText() or "", CT_RATooltipTextLeft2:GetText() or "", -1;
					if ( sType ~= "" and CT_RADebuff_CanCure(sType) and not CT_RADebuff_IgnoreDebuffs[(sName or "")] ) then
						-- See if we can find the CT_RA_DebuffTemplates index
						for k, v in CT_RA_DebuffTemplates do
							
							-- See if we have a match
							if ( string.find(strlower(sName), strlower(v["debuffName"])) and string.find(strlower(sType), strlower(v["debuffType"])) and string.find(strlower(sDesc), strlower(v["debuffDesc"])) ) then
								iTblIndex = k;
								break;
							end
						end
						
						if ( iTblIndex > 0 and ( not CT_RADebuff_CureTable[2] or CT_RADebuff_CureTable[2] > iTblIndex ) ) then
							-- Clean the table
							CT_RADebuff_CureTable = {
								[1] = {
									{ sName, sType, sDesc, "player", CT_RADebuff_ClassIndexes[UnitClass("player")], UnitHealth("player") }
								},
								[2] = iTblIndex
							};
							
						elseif ( iTblIndex > 0 and iTblIndex == CT_RADebuff_CureTable[2] ) then
							-- Add the data to the table, as well as class, health percentage, if the player is in your party or if the player is you
							tinsert(CT_RADebuff_CureTable[1], { sName, sType, sDesc, "player", CT_RADebuff_ClassIndexes[UnitClass("player")], UnitHealth("player") });
							
						end
					end
				end
				
				iIndex = iIndex + 1;
				
			end
		end
		if ( UnitExists("pet") and not CT_RADebuff_Blacklist[UnitName("pet")] ) then
			local iIndex = 1;
			
			-- Loop through the debuffs
			while ( UnitDebuff("pet", iIndex) ) do
				-- Clear and set the tooltip
				CT_RATooltipTextLeft1:SetText("");
				CT_RATooltipTextRight1:SetText("");
				CT_RATooltip:SetUnitDebuff("pet", iIndex);
				
				-- Control to make sure we have a new debuff
				if ( CT_RATooltipTextLeft1:GetText() ~= "" ) then
				
					-- Fetch the data
					local sName, sType, sDesc, iTblIndex = CT_RATooltipTextLeft1:GetText() or "", CT_RATooltipTextRight1:GetText() or "", CT_RATooltipTextLeft2:GetText() or "", -1;
					if ( sType ~= "" and CT_RADebuff_CanCure(sType) and not CT_RADebuff_IgnoreDebuffs[(sName or "")] ) then
						-- See if we can find the CT_RA_DebuffTemplates index
						for k, v in CT_RA_DebuffTemplates do
							
							-- See if we have a match
							if ( string.find(strlower(sName), strlower(v["debuffName"])) and string.find(strlower(sType), strlower(v["debuffType"])) and string.find(strlower(sDesc), strlower(v["debuffDesc"])) ) then
								iTblIndex = k;
								break;
							end
						end
						
						if ( iTblIndex > 0 and ( not CT_RADebuff_CureTable[2] or CT_RADebuff_CureTable[2] > iTblIndex ) ) then
							-- Clean the table
							CT_RADebuff_CureTable = {
								[1] = {
									{ sName, sType, sDesc, "pet", CT_RADebuff_ClassIndexes[UnitClass("pet")], UnitHealth("pet") }
								},
								[2] = iTblIndex
							};
							
						elseif ( iTblIndex > 0 and iTblIndex == CT_RADebuff_CureTable[2] ) then
							-- Add the data to the table, as well as class, health percentage, if the player is in your party or if the player is you
							tinsert(CT_RADebuff_CureTable[1], { sName, sType, sDesc, "pet", CT_RADebuff_ClassIndexes[UnitClass("pet")], UnitHealth("pet") });
							
						end
					end
				end
				
				iIndex = iIndex + 1;
				
			end
		end
	end
	local prefix, func = "raid", GetNumRaidMembers;
	if ( GetNumRaidMembers() == 0 and GetNumPartyMembers() > 0 ) then
		prefix, func = "party", GetNumPartyMembers;
	end
	-- Loop through the players in the raid
	for i = 1, func(), 1 do
		if ( not CT_RADebuff_Blacklist[UnitName(prefix .. i)] and ( not UnitCanAttack("player", prefix .. i) or ( UnitIsCharmed(prefix .. i) and UnitIsFriend("player", prefix .. i) ) ) ) then
			local iIndex = 1;
			
			-- Loop through the debuffs
			while ( UnitDebuff(prefix .. i, iIndex) ) do
				-- Clear and set the tooltip
				CT_RATooltipTextLeft1:SetText("");
				CT_RATooltipTextRight1:SetText("");
				CT_RATooltip:SetUnitDebuff(prefix .. i, iIndex);
				
				-- Control to make sure we have a new debuff
				if ( CT_RATooltipTextLeft1:GetText() ~= "" ) then

					-- Fetch the data
					local sName, sType, sDesc, iTblIndex = CT_RATooltipTextLeft1:GetText() or "", CT_RATooltipTextRight1:GetText() or "", CT_RATooltipTextLeft2:GetText() or "", -1;
					if ( sType ~= "" and CT_RADebuff_CanCure(sType) and not CT_RADebuff_IgnoreDebuffs[(sName or "")] ) then
						-- See if we can find the CT_RA_DebuffTemplates index
						for k, v in CT_RA_DebuffTemplates do
							
							-- See if we have a match
							if ( string.find(strlower(sName), strlower(v["debuffName"])) and string.find(strlower(sType), strlower(v["debuffType"])) and string.find(strlower(sDesc), strlower(v["debuffDesc"])) ) then
								iTblIndex = k;
								break;
							end
						end
						
						if ( iTblIndex > 0 and ( not CT_RADebuff_CureTable[2] or CT_RADebuff_CureTable[2] > iTblIndex ) ) then
							-- Clean the table
							CT_RADebuff_CureTable = {
								[1] = {
									{ sName, sType, sDesc, prefix .. i, CT_RADebuff_ClassIndexes[UnitClass(prefix .. i)], UnitHealth(prefix .. i) }
								},
								[2] = iTblIndex
							};
							
						elseif ( iTblIndex > 0 and iTblIndex == CT_RADebuff_CureTable[2] ) then
							-- Add the data to the table, as well as class, health percentage, if the player is in your party or if the player is you
							tinsert(CT_RADebuff_CureTable[1], { sName, sType, sDesc, prefix .. i, CT_RADebuff_ClassIndexes[UnitClass(prefix .. i)], UnitHealth(prefix .. i) });
							
						end
					end
				end
				
				iIndex = iIndex + 1;
				
			end
		end
		if ( UnitExists(prefix .. "pet" .. i) and not CT_RADebuff_Blacklist[UnitName(prefix .. "pet" .. i)] and ( not UnitCanAttack("player", prefix .. "pet" .. i) or ( UnitIsCharmed(prefix .. "pet" .. i) and UnitIsFriend("player", prefix .. "pet" .. i) ) ) ) then
			local iIndex = 1;
			-- Loop through the debuffs
			while ( UnitDebuff(prefix .. "pet" .. i, iIndex) ) do
				-- Clear and set the tooltip
				CT_RATooltipTextLeft1:SetText("");
				CT_RATooltipTextRight1:SetText("");
				CT_RATooltip:SetUnitDebuff(prefix .. "pet" .. i, iIndex);
				
				-- Control to make sure we have a new debuff
				if ( CT_RATooltipTextLeft1:GetText() ~= "" ) then
				
					-- Fetch the data
					local sName, sType, sDesc, iTblIndex = CT_RATooltipTextLeft1:GetText() or "", CT_RATooltipTextRight1:GetText() or "", CT_RATooltipTextLeft2:GetText() or "", -1;
					if ( sType ~= "" and CT_RADebuff_CanCure(sType) and not CT_RADebuff_IgnoreDebuffs[(sName or "")] ) then
						-- See if we can find the CT_RA_DebuffTemplates index
						for k, v in CT_RA_DebuffTemplates do
							
							-- See if we have a match
							if ( string.find(strlower(sName), strlower(v["debuffName"])) and string.find(strlower(sType), strlower(v["debuffType"])) and string.find(strlower(sDesc), strlower(v["debuffDesc"])) ) then
								iTblIndex = k;
								break;
							end
						end
						
						if ( iTblIndex > 0 and ( not CT_RADebuff_CureTable[2] or CT_RADebuff_CureTable[2] > iTblIndex ) ) then
							-- Clean the table
							CT_RADebuff_CureTable = {
								[1] = {
									{ sName, sType, sDesc, prefix .. "pet" .. i, CT_RADebuff_ClassIndexes[UnitClass(prefix .. "pet" .. i)], UnitHealth(prefix .. "pet" .. i) }
								},
								[2] = iTblIndex
							};
							
						elseif ( iTblIndex > 0 and iTblIndex == CT_RADebuff_CureTable[2] ) then
							-- Add the data to the table, as well as class, health percentage, if the player is in your party or if the player is you
							tinsert(CT_RADebuff_CureTable[1], { sName, sType, sDesc, prefix .. "pet" .. i, CT_RADebuff_ClassIndexes[UnitClass(prefix .. "pet" .. i)], UnitHealth(prefix .. "pet" .. i) });
							
						end
					end
				end
				
				iIndex = iIndex + 1;
				
			end
		end
	end
end

----------------------------------------------------------------
--                     CT_RADebuff_Cure()                     --
-- Cures the next person in the list, using the chosen order. --
--      This is where most of the curing stuff is done.       --
----------------------------------------------------------------

function CT_RADebuff_Cure()
	if ( not CT_RADebuff_CureSpells[UnitClass("player")] ) then
		return;
	end
	local cannotCast, cooldownStart, cooldownDuration;
	for k, v in CT_RADebuff_CureSpells[UnitClass("player")] do
		if ( type(v) == "table" ) then
			for key, val in v do
				if ( CT_RA_ClassSpells[val] ) then
					cooldownStart, cooldownDuration = GetSpellCooldown(CT_RA_ClassSpells[val]["spell"], SpellBookFrame.bookType);
					if ( cooldownStart > 0 and cooldownDuration > 0 ) then
						cannotCast = true;
						break;
					end
				end
			end
		else
			if ( CT_RA_ClassSpells[v] ) then
				cooldownStart, cooldownDuration = GetSpellCooldown(CT_RA_ClassSpells[v]["spell"], SpellBookFrame.bookType);
				if ( cooldownStart > 0 and cooldownDuration > 0 ) then
					cannotCast = true;
					break;
				end
			end
		end
	end
	if ( cannotCast ) then
		return;
	end
	CT_RADebuff_UpdateCureTable();
	
	-- Make sure we have an index
	if ( CT_RADebuff_CureTable[2] ) then
		
		-- Process if we have a target to cure
		local uId, tblIndex = CT_RADebuff_PriorityCure(CT_RA_DebuffTemplates[CT_RADebuff_CureTable[2]]["cureOrder"], CT_RADebuff_CureTable[1], CT_RA_DebuffTemplates[CT_RADebuff_CureTable[2]]["affectClasses"]);
		
		while ( uId ) do
			if ( UnitIsVisible(uId) ) then
				local switchTarget, resetCombat;
				if ( not UnitIsUnit("target", uId) ) then
					TargetUnit(uId);
					switchTarget = 1;
					if ( CT_RADebuff_InCombat ) then
						resetCombat = 1;
					end
				end
				-- Make sure the target and the unit we're trying to cure are the same
				if ( UnitIsUnit(uId, "target") ) then
					-- Shall we perform a range check?
					
					if ( CT_RADebuff_ActionButtons[CT_RADebuff_CureTable[1][tblIndex][2]] ) then
						-- Make sure the spell is in range
						if ( IsActionInRange(CT_RADebuff_ActionButtons[CT_RADebuff_CureTable[1][tblIndex][2]][2]) == 1 ) then
							local shallReturn = CT_RADebuff_CureTarget(CT_RADebuff_CureTable[1][tblIndex][2], CT_RADebuff_CureTable[1][tblIndex][1], "target");
							if ( switchTarget ) then
								TargetLastTarget();
								switchTarget = nil;
								if ( resetCombat ) then
									CT_RADebuff_ResetCombat = 1;
								end
							end
							if ( shallReturn ) then
								return;
							end
						end
					else
						-- If not, just try to target and cure
						local shallReturn = CT_RADebuff_CureTarget(CT_RADebuff_CureTable[1][tblIndex][2], CT_RADebuff_CureTable[1][tblIndex][1], "target");
						if ( switchTarget ) then
							TargetLastTarget();
							switchTarget = nil;
							if ( resetCombat ) then
								CT_RADebuff_ResetCombat = 1;
							end
						end
						if ( shallReturn ) then
							return;
						end
					end
					
					-- Target the previous target
					if ( switchTarget ) then
						TargetLastTarget();
						if ( resetCombat ) then
							CT_RADebuff_ResetCombat = 1;
						end
					end
					
				elseif ( switchTarget and UnitIsUnit("target", uId) ) then
					TargetLastTarget();
					if ( resetCombat ) then
						CT_RADebuff_ResetCombat = 1;
					end
				end
			end
			-- Remove the previous one, and check again
			table.remove(CT_RADebuff_CureTable[1], tblIndex);
			uId, tblIndex = CT_RADebuff_PriorityCure(CT_RA_DebuffTemplates[CT_RADebuff_CureTable[2]]["cureOrder"], CT_RADebuff_CureTable[1], CT_RA_DebuffTemplates[CT_RADebuff_CureTable[2]]["affectClasses"]);
		end
	end
end

------------------------------------------------------------------
--           CT_RADebuff_PriorityCure(order, tbl)               --
-- Gets the person out of a table that contains the people that --
--           need it most based on the order given              --
------------------------------------------------------------------

function CT_RADebuff_PriorityCure(order, tbl, classes)
	local currLow, currIndex, currNamePriority, currLowHealth = 99, 99, 99, 99999;
	
	local classTbl = {
		[9] = CT_RA_WARRIOR, 
		[10] = CT_RA_DRUID,
		[11] = CT_RA_MAGE,
		[12] = CT_RA_WARLOCK,
		[13] = CT_RA_ROGUE,
		[14] = CT_RA_HUNTER,
		[15] = CT_RA_PRIEST,
		[16] = CT_RA_PALADIN,
		[17] = CT_RA_SHAMAN
	};
	
	for k, v in tbl do
		if ( CT_RADebuff_NamePriorities[v[1]] ) then
			v[8] = CT_RADebuff_NamePriorities[v[1]];
		end
		for key, val in order do
			if ( ( UnitPowerType(v[4]) ~= 2 and classes[UnitClass(v[4])] ) or ( ( UnitPowerType(v[4]) == 2 or UnitCreatureFamily(v[4]) == CT_RA_IMP or UnitCreatureFamily(v[4]) == CT_RA_VOIDWALKER or UnitCreatureFamily(v[4]) == CT_RA_SUCCUBUS or UnitCreatureFamily(v[4]) == CT_RA_FELHUNTER or UnitCreatureFamily(v[4]) == CT_RA_DOOMGUARD or UnitCreatureFamily(v[4]) == CT_RA_INFERNAL ) and classes[CT_RA_PETS] ) ) then
				-- Target
				if ( val == 1 and UnitIsUnit(v[4], "target") ) then
					v[7] = key;
					break;
					
				-- Self
				elseif ( val == 2 and UnitIsUnit(v[4], "player") ) then
					v[7] = key;
					break;
					
				-- Party
				elseif ( val == 3 and UnitInParty(v[4]) ) then
					v[7] = key;
					break;
				
				-- Pet
				elseif ( val == 5 and UnitIsUnit(v[4], "pet") ) then
					v[7] = key;
					break;
					
				-- Party pets
				elseif ( val == 6 and string.find(v[4], "^party%d+pet%$") ) then
					v[7] = key;
					break;
				
				-- Raid pets
				elseif ( val == 7 and string.find(v[5], "^raid%d+pet$") ) then
					v[7] = key;
					break;
				
				-- Main Tanks
				elseif ( val == 8 and CT_RADebuff_MainTankExists(UnitName(v[4])) ) then
					v[7] = key;
					break;
		
				-- Classes
				elseif ( val >= 9 and val <= 17 and classes[classTbl[val]] ) then
					v[7] = key;
					break;
					
				-- Raid
				elseif ( val == 4 and UnitInRaid(v[4]) ) then
					v[7] = key;
					break;
				end
			end
		end
		
		if ( 
			( 
				( v[7] and v[7] < currLow ) or 
				( v[7] and currLow and v[6] and currLowHealth and v[7] <= currLow and v[6] < currLowHealth )
			) and 
			( ( v[8] or 99 ) <= currNamePriority )
		) then
			currLow = v[7];
			currLowHealth = v[6];
			currIndex = k;
			currNamePriority = ( v[8] or 99 );
		end
	end
	
	if ( currLow < 99 ) then
		return tbl[currIndex][4], currIndex;
	end
end

------------------------------------------------------------------
--              CT_RADebuff_MainTankExists(name)                --
--   Returns if the name is one of the main tanks in the raid.  --
------------------------------------------------------------------

function CT_RADebuff_MainTankExists(name)
	for k, v in CT_RA_MainTanks do
		if ( v == name ) then
			return 1;
		end
	end
	return nil;
end

------------------------------------------------------------------
--             CT_RADebuff_GetActionButtonCures()               --
--    Gets the action buttons that correspond to cure spells.   --
------------------------------------------------------------------

function CT_RADebuff_GetActionButtonCures()
	CT_RADebuff_ActionButtons = { };
	local iIndex = 0;
	local arr = {
		[CT_RA_PRIEST] = { [CT_RA_DISPELMAGIC] = { CT_RA_MAGIC, 1 }, [CT_RA_CUREDISEASE] = { CT_RA_DISEASE, 2 }, [CT_RA_ABOLISHDISEASE] = { CT_RA_DISEASE, 1 } },
		[CT_RA_SHAMAN] = { [CT_RA_CUREDISEASE] = { CT_RA_DISEASE, 1 },  [CT_RA_CUREPOISON] = { CT_RA_POISON, 1 } },
		[CT_RA_DRUID] = { [CT_RA_REMOVECURSE] = { CT_RA_CURSE, 1 }, [CT_RA_CUREPOISON] = { CT_RA_POISON, 2 }, [CT_RA_ABOLISHPOISON] = { CT_RA_POISON, 1 } },
		[CT_RA_MAGE] = { [CT_RA_REMOVELESSERCURSE] = { CT_RA_CURSE, 1 } },
		[CT_RA_PALADIN] = { [CT_RA_CLEANSE] = { CT_RA_MAGIC, 1 }, [CT_RA_PURIFY] = { CT_RA_DISEASE, 2 }, [CT_RA_CLEANSE] = { CT_RA_DISEASE, 1 }, [CT_RA_PURIFY] = { CT_RA_POISON, 2 }, [CT_RA_CLEANSE] = { CT_RA_POISON, 1 } }
	};
	if ( not arr[UnitClass("player")] ) then
		return;
	end
	
	-- Loop through the action buttons
	for i = 1, 120, 1 do
		if ( HasAction(i) ) then
			CT_RATooltipTextLeft1:SetText("");
			CT_RATooltipTextRight1:SetText("");
			CT_RATooltip:SetAction(i);
			-- Make sure we have a new spell
			local sName = CT_RATooltipTextLeft1:GetText();
			if ( strlen(sName or "") > 0 and strlen(CT_RATooltipTextRight1:GetText() or "") > 0 ) then
				for key, val in arr[UnitClass("player")] do
					if ( key == sName and ( not CT_RADebuff_ActionButtons[val[1]] or CT_RADebuff_ActionButtons[val[1]][1] > val[2] ) ) then
						CT_RADebuff_ActionButtons[val[1]] = { val[2], i, key };
					end
				end
			end
		end
	end
end

------------------------------------------------------------------
--    CT_RADebuff_CureTarget(debuffType, debuffName, uId)       --
--            Cures the unit id of the debuff type.             --
------------------------------------------------------------------

function CT_RADebuff_CureTarget(debuffType, debuffName, uId)
	if ( CT_RADebuff_CureSpells[UnitClass("player")] and CT_RADebuff_CureSpells[UnitClass("player")][debuffType] ) then
		local tmp = CT_RADebuff_CureSpells[UnitClass("player")][debuffType];
		if ( type(tmp) == "table" ) then
			for i = getn(tmp), 1, -1 do
				if ( CT_RA_ClassSpells[tmp[i]] ) then
					if ( tmp[i] == CT_RA_ABOLISHDISEASE or tmp[i] == CT_RA_ABOLISHPOISON ) then
						if ( CT_RADebuff_HasBuff(uId, tmp[i]) ) then
							return nil;
						end
					end
					CT_RADebuff_CastingSpell = UnitName(uId);
					CastSpell(CT_RA_ClassSpells[tmp[i]]["spell"], CT_RA_ClassSpells[tmp[i]]["tab"]+1);
					CT_RA_Print("<CTRaid> Dispelling |c00FFFFFF" .. UnitName(uId) .. "|r of |c00FFFFFF" .. debuffType .. "|r (|c00FFFFFF" .. debuffName .. "|r).", 1, 0.5, 0);
					return 1;
				end
			end
		else
			if ( CT_RA_ClassSpells[tmp] ) then
				if ( tmp == CT_RA_ABOLISHDISEASE or tmp == CT_RA_ABOLISHPOISON ) then
					if ( CT_RADebuff_HasBuff(uId, tmp) ) then
						return nil;
					end
				end
				CT_RADebuff_CastingSpell = UnitName(uId);
				CastSpell(CT_RA_ClassSpells[tmp]["spell"], CT_RA_ClassSpells[tmp]["tab"]+1);
				CT_RA_Print("<CTRaid> Dispelling |c00FFFFFF" .. UnitName(uId) .. "|r of |c00FFFFFF" .. debuffType .. "|r (|c00FFFFFF" .. debuffName .. "|r).", 1, 0.5, 0);
				return 1;
			end
		end
	end
	return nil;
end

------------------------------------------------------------------
--             CT_RADebuff_HasBuff(uId, buffName)               --
--     Returns true if the unit has a buff named buffName.      --
------------------------------------------------------------------
function CT_RADebuff_HasBuff(uId, buffName)
	if ( UnitExists(uId) and buffName ~= "" ) then
		local iIndex = 1;
		
		-- Loop through the debuffs
		while ( UnitBuff(uId, iIndex) ) do
			-- Clear and set the tooltip
			CT_RATooltipTextLeft1:SetText("");
			CT_RATooltip:SetUnitBuff(uId, iIndex);
			
			-- Control to see if we have the buff we're looking for
			if ( CT_RATooltipTextLeft1:GetText() == buffName ) then
				return 1;
			end
			
			iIndex = iIndex + 1;
			
		end
	end
	return nil;
end

------------------------------------------------------------------
--               CT_RADebuff_CanCure(debuffType)                --
--       Returns if the player can cure the debuff type.        --
------------------------------------------------------------------

function CT_RADebuff_CanCure(debuffType)
	local arr = {
		[CT_RA_PRIEST] = { [CT_RA_MAGIC] = CT_RA_DISPELMAGIC, [CT_RA_DISEASE] = { CT_RA_CUREDISEASE, CT_RA_ABOLISHDISEASE } },
		[CT_RA_SHAMAN] = { [CT_RA_DISEASE] = CT_RA_CUREDISEASE, [CT_RA_POISON] = CT_RA_CUREPOISON },
		[CT_RA_DRUID] = { [CT_RA_CURSE] = CT_RA_REMOVECURSE, [CT_RA_POISON] = { CT_RA_CUREPOISON, CT_RA_ABOLISHPOISON } },
		[CT_RA_MAGE] = { [CT_RA_CURSE] = CT_RA_REMOVELESSERCURSE },
		[CT_RA_PALADIN] = { [CT_RA_MAGIC] = CT_RA_CLEANSE, [CT_RA_POISON] = { CT_RA_PURIFY, CT_RA_CLEANSE }, [CT_RA_DISEASE] = { CT_RA_PURIFY, CT_RA_CLEANSE } }
	};
	
	if ( arr[UnitClass("player")] and arr[UnitClass("player")][debuffType] ) then
		if ( type(arr[UnitClass("player")][debuffType]) == "table" ) then
			for k, v in arr[UnitClass("player")][debuffType] do
				if ( CT_RA_ClassSpells[v] ) then
					return 1;
				end
			end
		elseif ( CT_RA_ClassSpells[arr[UnitClass("player")][debuffType]] ) then
			return 1;
		end
	end
	return nil;
end

-- Slash command to cure
CT_RA_RegisterSlashCmd("/racure", "Cures a debuff using the debuff curing system. Must be used in a macro.", 15, "RACURE", CT_RADebuff_Cure, "/racure");

-- Hook functions to call CT_RADebuff_GetActionButtonCures
CT_RADebuff_oldPlaceAction = PlaceAction;
function CT_RADebuff_newPlaceAction(id)
	CT_RADebuff_oldPlaceAction(id);
	CT_RADebuff_GetActionButtonCures();
end
PlaceAction = CT_RADebuff_newPlaceAction;

CT_RADebuff_oldPickupAction = PickupAction;
function CT_RADebuff_newPickupAction(id)
	CT_RADebuff_oldPickupAction(id);
	CT_RADebuff_GetActionButtonCures();
end
PickupAction = CT_RADebuff_newPickupAction;

CT_RADebuff_oldUseAction = UseAction;
function CT_RADebuff_newUseAction(id, check, self)
	local rebuild;
	if ( CursorHasSpell() and not IsShiftKeyDown() ) then
		rebuild = 1;
	end
	CT_RADebuff_oldUseAction(id, check, self);
	if ( rebuild ) then
		CT_RADebuff_GetActionButtonCures();
	end
end
UseAction = CT_RADebuff_newUseAction;