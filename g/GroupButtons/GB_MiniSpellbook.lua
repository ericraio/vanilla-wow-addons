function GB_Spellbook_Initialize()
	if (not GB_INITIALIZED) then return; end
	GB_SpellBookPrevPageButton:Disable();
	GB_SPELLBOOKPAGE = 0;
	GB_SpellBookNextPageButton:Enable();
	GB_Spellbook_UpdatePage(1, 40);	
end

function GB_Spellbook_NextPage()
	GB_SPELLBOOKPAGE = GB_SPELLBOOKPAGE + 1;
	GB_SpellBookPrevPageButton:Enable();
	local start = 40 * GB_SPELLBOOKPAGE + 1;
	local finish = start + 39;
	GB_Spellbook_UpdatePage(start, finish);
end

function GB_Spellbook_PreviousPage()
	GB_SPELLBOOKPAGE = GB_SPELLBOOKPAGE - 1;
	GB_SpellBookNextPageButton:Enable();
	if (GB_SPELLBOOKPAGE == 0) then
		GB_SpellBookPrevPageButton:Disable();
	end
	local start = 40 * GB_SPELLBOOKPAGE + 1;
	local finish = start + 39;
	GB_Spellbook_UpdatePage(start, finish);
end

function GB_Spellbook_UpdatePage(start, finish)
	for x = start, finish do
		local boxnum = x - 40 * GB_SPELLBOOKPAGE;
		local spellbox = "GB_MiniSpellbook_Spell_"..boxnum;
		local spellname, spellrank = GetSpellName(x, "BOOKTYPE_SPELL");
		if (spellname) then
			getglobal(spellbox):Show();
			getglobal(spellbox):SetID(x);
			local texture = GetSpellTexture(x, "BOOKTYPE_SPELL");
			getglobal(spellbox.."_Texture"):SetTexture(texture);
			if (spellrank) then
				local rankstart = string.find(spellrank, " ");
				if (rankstart) then
					local rank = string.sub(spellrank, rankstart + 1);
					if (rank ~= "Passive") then
						getglobal(spellbox.."_Rank"):SetText(rank);
					else
						getglobal(spellbox.."_Rank"):SetText("");
					end
				else
					getglobal(spellbox.."_Rank"):SetText("");
				end
			else
				getglobal(spellbox.."_Rank"):SetText("");
			end
		else
			getglobal(spellbox):Hide();
			GB_SpellBookNextPageButton:Disable();
		end
	end
end