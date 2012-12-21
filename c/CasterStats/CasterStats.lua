---------------------------------------------------
-- Caster Stats v0.9.5.1 by RMS 
---------------------------------------------------
--[[

Adds a line to the stat section of the character frame below armor. This line can be
set to either show your total "+Spell Damage" or "+Healing" via the command line. 
Like the other stats in the character screen it provides more information when you 
mouse over it. The tooltip will display the totals for plus healing, spell damage, 
all individual schools of damage, spell crit, spell to hit, mana regen etc...

The information that is displayed is only additional stats provided by your gear. 
If you do not have any of the the listed stats it will not be visible. Caster Stats 
does not currently calculate crit, or mana regen from stats like int, spirit, or 
base crit. It is only mean't to be a quick way of finding the bonuses you are 
getting from your gear. I may implement more features in the future however.

While there are other mods out there that can total these stats for you, I wanted 
something that was more intune with the melee character stats. Something simple 
yet informative.

-Config
"/cstats" - Slash command for Caster Stats
"/cstats [damagetype]" - Allows you to choose the stat visible in the character screen. "damage" or "healing". 

-------------------------------------------------------------------------------------
v0.9.5.1
-- Now totals +damage to individual schools of magic as before

v0.9.5
-- Updated for 1.10
-- Now uses Bonus Scanner (http://www.curse-gaming.com/mod.php?addid=2384) to find bonuses instead of reinventing the wheel each patch/new item stat with my own scanner. This also allows prevents FR DE localizations from needing to be created multiple times. Bonusscanner is included in the download.
-- Added detection for negative spell resist to target (not yet implemented by Bonus Scanner)
-- Relocated the stats to be inside the frame with other stats
-- As before Caster Stats is not visible if you are a Warrior/Rogue, but now in addition healing does not show if you are not a healing class
-- Added FE DE localization. Please report if they are functional as I reformatted previous submissions. Will need modified version for both for the negative resists either way.

v0.9.4
-- Updated for 1.9
-- Change the comand line to /cstats to be compatible with "Combat Stats"
-- Mana regen now works again as wording was changed in 1.9
-- Wizard and Brilliant Oils are now detected

v0.9.3
-- Sets are now correctly identified and set bonuses only counted once.
-- Now also totals health regeneration.
-- Added the Winter's Might enchant.

v0.9.2
-- Updated mana regen and spell crit detection.

v0.9.1
-- Now detects TankPoints and moves CasterStats to a new location if needed.
-- Fixed issues with +spell crit and +spell hit not showing under certain conditions.
-- Fixed issues where values weren't getting reset on rescan.

]]-- 

reportThis = 0;

local casterStats = {
	stats = {};
	statTypes = {
		'HEAL',		-- healing 
		'DMG',		-- spell damage
		'ARCANEDMG',	-- arcane spell damage
		'FIREDMG',	-- fire spell damage
		'FROSTDMG',	-- frost spell damage
		'HOLYDMG',	-- holy spell damage
		'NATUREDMG',	-- nature spell damage
		'SHADOWDMG',	-- shadow spell damage
		'SPELLCRIT',	-- chance to crit with spells
		'HOLYCRIT',	-- chance to crit with holy spells
		'HEALTHREG',	-- health regeneration per 5 sec.
		'MANAREG',	-- mana regeneration per 5 sec.
		'SPELLTOHIT',	-- spell chance to hit
		'NEGRES'		-- target resist decrease
	};
};

function CS_OnLoad()
	-- Register the command prompt command
	SLASH_CSTATS1 = "/cstats";	
	SlashCmdList["CSTATS"] = CS_CommandHandler;

	-- Add negative resist functionality to BONUS SCANNER
	table.insert(BONUSSCANNER_PATTERNS_PASSIVE, CS_BONUSSCANNER_ADD_NEGRES);
	table.insert(BonusScanner.types, "NEGRES");

	-- Hook the Bonus Scanner function
	BonusScanner_Update = UpdateCS;
end


-- Rescan the inventory
function UpdateCS() 
	local class;
	_, class = UnitClass("player");

	-- Only update if the Character Frame is visible to the user
	if (CharacterFrame:IsVisible() and class ~= "ROGUE" and class ~= "WARRIOR") then
		-- Reacquire the stats information
		for i, type in casterStats.statTypes do
			casterStats.stats[type] = BonusScanner:GetBonus(type);
		end

		if (ThereAreStats() or 1) then
			SetFrameValues();
		else
			ClearFrameValues();
		end
	end
end


-- Setup and show the tooltip on mouse over
function CSFrame_OnEnter()
	local class;
	_, class = UnitClass("player");

	if (class ~= "ROGUE" and class ~= "WARRIOR") then
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		GameTooltip:SetText("Caster Stats", 1, 1, 1);

		-- Loop through all the stats and add the ones that exist to the tooltip
		for i, type in casterStats.statTypes do
			if (casterStats.stats[type] ~= 0) then
				if (string.find(type, ".+DMG")) then
					GameTooltip:AddDoubleLine(CS_STAT_NAMES[type] .. ":", "(+" .. casterStats.stats[type] .. ") +" .. (casterStats.stats[type] + casterStats.stats['DMG']), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 0, 1, 0);
				-- Check for NEGRES TYPE.
				elseif (string.find(type, "NEGRES")) then
					GameTooltip:AddDoubleLine(CS_STAT_NAMES[type] .. ":", "-" .. casterStats.stats[type], NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 0, 1, 0);
				-- Check for REGEN TYPE.
				elseif (string.find(type, "REG")) then
					GameTooltip:AddDoubleLine(CS_STAT_NAMES[type] .. ":", casterStats.stats[type] .. "/5s", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 0, 1, 0);
				-- Check for CRIT/HIT TYPE.
				elseif (string.find(type, "CRIT") or string.find(type, "HIT")) then
					GameTooltip:AddDoubleLine(CS_STAT_NAMES[type] .. ":", "+" .. casterStats.stats[type] .. "%", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 0, 1, 0);
				-- No special output
				else
					-- Check if it is the healing stat and only display it if it is a healing class
					if (string.find(type, "HEAL")) then
						if (class == "DRUID" or class == "PRIEST" or class == "PALADIN" or class == "SHAMAN") then
							GameTooltip:AddDoubleLine(CS_STAT_NAMES[type] .. ":", "+" .. casterStats.stats[type], NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 0, 1, 0);
						end
					else
						GameTooltip:AddDoubleLine(CS_STAT_NAMES[type] .. ":", "+" .. casterStats.stats[type], NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 0, 1, 0);
					end
				end
			end
		end

		GameTooltip:Show();
	end
end


-- Populate the frame
function SetFrameValues()
	local unit = "player";
	local label = getglobal("CSFrameLabel");
	local text = getglobal("CSFrameStatText");
	text:SetTextColor(0, 1, 0, 1);

	CharacterAttributesFrame:SetPoint("TOPLEFT", "PaperDollFrame", "TOPLEFT", 67, -279);
	PlayerStatBackgroundMiddle:SetHeight(65);

	if (reportThis == 1) then
		label:SetText(CS_STAT_NAMES['HEAL'] .. ":");
		text:SetText("+" .. casterStats.stats['HEAL']);
	else
		label:SetText(CS_STAT_NAMES['DMG'] .. ":");
		text:SetText("+" .. casterStats.stats['DMG']);
	end
end


-- Empty the frame
function ClearFrameValues()
	local label = getglobal("CSFrameLabel");
	local text = getglobal("CSFrameStatText");

	label:SetText("");
	text:SetText("");
end


-- Returns true if at least 1 stat has been recorded
function ThereAreStats()
	for i, currentStat in casterStats.stats do
		if (currentStat ~= 0) then
			return true;
		end
	end
end


-- Handles the command line
function CS_CommandHandler( msg )
	if (msg == CS_DMG_TOGGLE) then
		reportThis = 0;
		UpdateCS();
		DEFAULT_CHAT_FRAME:AddMessage(CS_FEEDBACK_STATCHANGE.." \""..CS_DMG_TOGGLE.."\"");
	elseif (msg == CS_HEALING_TOGGLE) then
		reportThis = 1;
		UpdateCS();
		DEFAULT_CHAT_FRAME:AddMessage(CS_FEEDBACK_STATCHANGE.." \""..CS_HEALING_TOGGLE.."\"");
	else
		if(reportThis == 0) then
				reportThis = 1;
			else
				reportThis = 0;
			end	
	end
end


