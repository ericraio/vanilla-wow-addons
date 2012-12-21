CT_RA_ClassSpells = { };
CT_RA_HMark = nil;

function CT_RA_GetClassSpells()
	local noRankSpells = {
		["Blessing of Kings"] = 1,
		["Blessing of Freedom"] = 1,
		["Blessing of Salvation"] = 1
	};
	CT_RA_ClassSpells = { };
	CT_RA_HMark = nil;
	for i = 1, GetNumSpellTabs(), 1 do
		local name, texture, offset, numSpells = GetSpellTabInfo(i);
		for y = 1, numSpells, 1 do
			local spellName, rankName = GetSpellName(offset+y, BOOKTYPE_SPELL);
			local useless, useless, rank = string.find(rankName, "(%d+)");
			if ( not CT_RA_ClassSpells[spellName] or ( CT_RA_ClassSpells[spellName]["rank"] and tonumber(rank) and CT_RA_ClassSpells[spellName]["rank"] < tonumber(rank) ) or noRankSpells[spellName] ) then
				CT_RA_ClassSpells[spellName] = { ["rank"] = tonumber(rank), ["tab"] = i, ["spell"] = y+offset };
			end
			if ( not CT_RA_HMark and spellName == CT_RA_HUNTERSMARK ) then
				CT_RA_HMark = { y+offset, i+1 };
			end
		end
	end
end

function CT_RA_ClassSpells_OnEvent(event)
	if ( event == "SPELLS_CHANGED" ) then
		CT_RA_GetClassSpells();
	end
end