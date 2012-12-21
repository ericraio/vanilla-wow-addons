--[[
	Stuff to track spell casting
	
	Main usage in SW Stats: Track mana efficiency of spells
	Might add more here
	
	Basic idea from:
	http://www.wowwiki.com/HOWTO:_Detecting_Instant_Cast_Spells
	
	approach for cancel, stop is different
	
	for ae we accept the spell at SPELLCAST_CHANNEL_START
	Stop messages for instant casts are never made pending, stop + instant = ok
	
	The idea of the "pending cast" is used because a fail message can come after a stop message for "normal" spells.
	
--]]

-- holds mana / spell info for cast by name
SW_CastByNameLookup = {};
-- holds mana / spell info for cast by name without rank
SW_CastByNameLookupMax = {};

--spells that are instant
SW_InstantLookup = {};

-- holds info until know if a spell failed
SW_PendingCast = {};
-- holds info of the spell to cast
SW_SelectedSpell = {};

local SW_ManaRegEx = string.gsub(MANA_COST, "%%d","(%%d+)");

function SW_GetManaCost(str)
	if str == nil then return nil; end
	local _,_, spellCost = string.find(str, SW_ManaRegEx);
	if spellCost == nil then return nil; end
	return tonumber(spellCost);
end

function SW_CalcManaUsage()
	local who = SW_S_Details[SW_SELF_STRING];
	if who == nil then return; end
	
	local perSpell = SW_S_SpellInfo[SW_SELF_STRING];
	if perSpell == nil then return; end
	
	local manaUsage = {0, 0, 0}; -- dmg, heal, total mana
	local manaUsed = 0;
	
	for k,v in pairs(perSpell) do
		if k ~= SW_DECURSEDUMMY then
			manaUsage[3] = manaUsage[3] + v[2];
			
			if who[k] ~= nil then
				manaUsed = v[2];
				if manaUsed > 0 then
					
					if who[k][1] > 0 then
						manaUsage[1] = manaUsage[1] + manaUsed;						
					end
					if who[k][2] > 0 then
						manaUsage[2] = manaUsage[2] + manaUsed;
					end
				end
			end	
		end
	end
	
	SW_S_ManaUsage[SW_SELF_STRING] = {manaUsage[1],manaUsage[2],manaUsage[3]}; -- dmg, heal, total.
	
	
end
function SW_AcceptPendingCast()
	--SW_printStr("SW_AcceptPendingCast");
	local spN = SW_PendingCast[1];
	if spN == nil then
		SW_PendingCast = {};
		return;
	end
	--SW_printStr(spN);
	--SW_printStr("-SW_AcceptPendingCast-"..spN);
	local updateMana = (SW_PendingCast[2] > 0);
	
	if SW_S_SpellInfo[SW_SELF_STRING] == nil then
		SW_S_SpellInfo[SW_SELF_STRING] = {};
	end
	if SW_S_SpellInfo[SW_SELF_STRING][spN] == nil then
		SW_S_SpellInfo[SW_SELF_STRING][spN] = {0,0};
	end
	spN = SW_S_SpellInfo[SW_SELF_STRING][spN];
	spN[1] = spN[1] + 1;
	spN[2] = spN[2] + SW_PendingCast[2];
	
	SW_PendingCast = {};
	
	-- only update this if mana was really used
	if updateMana then
		SW_CalcManaUsage();
	end
end
-- used in special cases see SPELLCAST_STOP in core.lua
function SW_AcceptSelectedCast()
	--SW_printStr("SW_AcceptSelectedCast");
	local spN = SW_SelectedSpell[1];
	if spN == nil then
		SW_SelectedSpell = {};
		return;
	end
	--SW_printStr(spN);
	--SW_printStr("-SW_AcceptSelectedCast-"..spN);
	local updateMana = (SW_SelectedSpell[2] > 0);
	
	if SW_S_SpellInfo[SW_SELF_STRING] == nil then
		SW_S_SpellInfo[SW_SELF_STRING] = {};
	end
	if SW_S_SpellInfo[SW_SELF_STRING][spN] == nil then
		SW_S_SpellInfo[SW_SELF_STRING][spN] = {0,0};
	end
	spN = SW_S_SpellInfo[SW_SELF_STRING][spN];
	spN[1] = spN[1] + 1;
	spN[2] = spN[2] + SW_SelectedSpell[2];
	
	SW_SelectedSpell = {};
	
	-- only update this if mana was really used
	if updateMana then
		SW_CalcManaUsage();
	end	
end
function SW_UpdateCastByNameLookup()
	local i = 1
	local spellCost;
	--SW_printStr("SW_CastByNameLookup rebuilt");
	SW_CastByNameLookup = {};
	SW_CastByNameLookupMax = {};
	SW_InstantLookup = {};
	SW_SpellHookTT:SetOwner(UIParent, "ANCHOR_NONE");

	while true do
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)
		if not spellName then
			do break end
		end
		SW_SpellHookTT:SetSpell(i, BOOKTYPE_SPELL);
		if ( spellRank and (strlen(spellRank) > 0) ) then
			
			spellCost = SW_GetManaCost(SW_SpellHookTTTextLeft2:GetText());
			if spellCost == nil then
				SW_CastByNameLookup[ spellName .. '(' .. spellRank .. ')' ] = {spellName, spellRank, 0};
			else
				SW_CastByNameLookup[ spellName .. '(' .. spellRank .. ')' ] = {spellName, spellRank, spellCost};
			end
			
		else
			spellCost = SW_GetManaCost(SW_SpellHookTTTextLeft2:GetText());
			if spellCost == nil then
				SW_CastByNameLookup[ spellName ] = {spellName, nil, 0};
			else
				SW_CastByNameLookup[ spellName ] = {spellName, nil, spellCost};
			end
		end
		if SW_CastByNameLookupMax[spellName] == nil or spellCost > SW_CastByNameLookupMax[spellName] then
			SW_CastByNameLookupMax[spellName] = spellCost;
		end
		if (SPELL_CAST_TIME_INSTANT == SW_SpellHookTTTextLeft3:GetText()) then
			SW_InstantLookup[ spellName ] = true;
		end
		
		i = i + 1
	end
end


SWHook_oldCastSpell = CastSpell;
function SWHook_newCastSpell(spellId, spellbookTabNum)
	--SW_printStr("CastSpell");
	-- if we are casting something already, do normal stuff
	-- don't need to check .channeling a new cast abborts channeling
	if getglobal("CastingBarFrame").casting then
		SWHook_oldCastSpell(spellId, spellbookTabNum);
		return;
	end
	SW_SpellHookTT:SetOwner(UIParent, "ANCHOR_NONE");
	-- Load the tooltip with the spell information
	SW_SpellHookTT:SetSpell(spellId, spellbookTabNum);
	local spellName = SW_SpellHookTTTextLeft1:GetText();
	if spellName == nil then
		SWHook_oldCastSpell(spellId, spellbookTabNum);
		return;
	end
	
	local spellCost = SW_GetManaCost(SW_SpellHookTTTextLeft2:GetText());
	local instant = SW_InstantLookup[spellName];
	
	if spellCost == nil then
		SW_SelectedSpell = {spellName, 0, instant};
	else
		SW_SelectedSpell = {spellName, spellCost, instant};
	end
	SWHook_oldCastSpell(spellId, spellbookTabNum);
end
CastSpell = SWHook_newCastSpell;

--1.3.2 changed this to be wow 1.10 ready (onSelf will be added)
SWHook_oldCastSpellByName = CastSpellByName;
function SWHook_newCastSpellByName(spellName, onSelf)
	if getglobal("CastingBarFrame").casting then
		SWHook_oldCastSpellByName(spellName, onSelf)
		return;
	end
	
	local spell, spellCost;
	
	if SW_CastByNameLookup[spellName] ~= nil then
		spell = SW_CastByNameLookup[spellName][1];
		spellCost = SW_CastByNameLookup[spellName][3];
	elseif SW_CastByNameLookupMax[spellName] ~= nil then
		spell = spellName;
		spellCost = SW_CastByNameLookupMax[spellName];
	end
	local instant = SW_InstantLookup[spellName];
	-- can happen if we are using a macro of a spell we dont have
	if spell ~= nil and spellCost~= nil and spellCost > 0 then
		SW_SelectedSpell = {spell, spellCost, instant};
	end
	
	-- Call the original function
	SWHook_oldCastSpellByName(spellName, onSelf)

end
CastSpellByName = SWHook_newCastSpellByName;


SWHook_oldUseAction = UseAction

function SWHook_newUseAction(a1, a2, a3)
	--SW_printStr("Action");
	if getglobal("CastingBarFrame").casting then
		SWHook_oldUseAction(a1, a2, a3);
		return;
	end
	
	-- Call the original function
	SWHook_oldUseAction(a1, a2, a3);
	
	-- Test to see if this is a macro
	if GetActionText(a1) then 
		return ;
	end
	SW_SpellHookTT:SetOwner(UIParent, "ANCHOR_NONE");
	
	SW_SpellHookTT:SetAction(a1)
	
	-- need to lookup the info this way because the "enhanced tooltip" could be turned off.
	-- name and rank are always displayed. 
	local spellNRank = "";
	local spellCost;
	local spell = SW_SpellHookTTTextLeft1:GetText();
	if spell == nil then 
		return;
	end
	local instant = SW_InstantLookup[spell];
	local spellRank = SW_SpellHookTTTextRight1:GetText();
	if ( spellRank and (strlen(spellRank) > 0) ) then
		spellNRank = spell.."("..spellRank..")";
	else
		spellNRank = spell;
	end
	if SW_CastByNameLookup[spellNRank] ~= nil then
		spellCost = SW_CastByNameLookup[spellNRank][3];
	end
	
	if spellCost == nil then
		--SW_printStr(spellName);
		SW_SelectedSpell = {spell, 0, instant};
	else
		SW_SelectedSpell = {spell, spellCost, instant};
	end
end
UseAction = SWHook_newUseAction

--[[ usless same event order
SWHook_oldCastingBarFrame_OnEvent = CastingBarFrame_OnEvent
function SWHook_newCastingBarFrame_OnEvent()
	if ( event == "SPELLCAST_START" ) then
		SW_printStr("CBE_SPELLCAST_START");
	elseif ( event == "SPELLCAST_STOP" ) then
		SW_printStr("CBE_SPELLCAST_STOP");
	elseif ( event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED" ) then
		SW_printStr("CBE_SPELLCAST_FAILED");
	elseif ( event == "SPELLCAST_DELAYED" ) then
		SW_printStr("CBE_SPELLCAST_DELAYED");
	elseif ( event == "SPELLCAST_CHANNEL_START" ) then
		SW_printStr("CBE_SPELLCAST_CHANNEL_START");
	elseif ( event == "SPELLCAST_CHANNEL_UPDATE" ) then
		SW_printStr("CBE_SPELLCAST_CHANNEL_UPDATE");
	end
	SWHook_oldCastingBarFrame_OnEvent();
end
CastingBarFrame_OnEvent = SWHook_newCastingBarFrame_OnEvent;
--]]
