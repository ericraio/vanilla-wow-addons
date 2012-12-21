local name = "ToolTip";
local version = "5.8";
--Author's Notes------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--[[
	Description:	Drastically improves the game's tooltip.
	Author:		AquaFlare7 (AquaFlare7@comcast.net)
--]]



--onEvent Routines----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
function aftt_toggleFrames()
	if (aftt_optionFrame:IsVisible()) then
		aftt_optionFrame:Hide();
	else
		aftt_optionFrame:Show();
	end
end

function aftt_buttonToggle(option)
	if (option == "guild") then
		--0, hide	-> toggles to show
		--1, show	-> toggles to showbottom
		--2, showbottom	-> toggles to hide
		if (AF_ToolTip[aftt_localUser]["Guild"] == 0 or AF_ToolTip[aftt_localUser]["Guild"] == nil) then
			AF_ToolTip[aftt_localUser]["Guild"] = 1;
		elseif (AF_ToolTip[aftt_localUser]["Guild"] == 1) then
			AF_ToolTip[aftt_localUser]["Guild"] = 2;
		elseif (AF_ToolTip[aftt_localUser]["Guild"] == 2) then
			AF_ToolTip[aftt_localUser]["Guild"] = 0;
		end
	elseif (option == "reaction") then
		if (AF_ToolTip[aftt_localUser]["ReactionText"] == 1) then
			AF_ToolTip[aftt_localUser]["ReactionText"] = 0;
		else
			AF_ToolTip[aftt_localUser]["ReactionText"] = 1;
		end
	elseif (option == "tapped") then
		if (AF_ToolTip[aftt_localUser]["Tapped"] == 1) then
			AF_ToolTip[aftt_localUser]["Tapped"] = 0;
		else
			AF_ToolTip[aftt_localUser]["Tapped"] = 1;
		end
	elseif (option == "pvp") then
		if (AF_ToolTip[aftt_localUser]["PvP"] == 1) then
			AF_ToolTip[aftt_localUser]["PvP"] = 0;
		else
			AF_ToolTip[aftt_localUser]["PvP"] = 1;
		end
	elseif (option == "fade") then
		if (AF_ToolTip[aftt_localUser]["Fade"] == 1) then
			AF_ToolTip[aftt_localUser]["Fade"] = 0;
		else
			AF_ToolTip[aftt_localUser]["Fade"] = 1;
		end
	elseif (option == "rank") then
		if (AF_ToolTip[aftt_localUser]["Rank"] == 1) then
			AF_ToolTip[aftt_localUser]["Rank"] = 2;
		elseif (AF_ToolTip[aftt_localUser]["Rank"] == 2) then
			AF_ToolTip[aftt_localUser]["Rank"] = 0;
		else
			AF_ToolTip[aftt_localUser]["Rank"] = 1;
		end
	elseif (option == "anchor") then
		--mouse		-> topleft
		--topleft	-> top
		--top		-> topright
		--topright	-> left
		--left		-> center
		--center	-> right
		--right		-> bottomleft
		--bottomleft	-> bottom
		--bottom	-> bottomright
		--bottomright	-> mouse
		if (AF_ToolTip[aftt_localUser]["Anchor"] == "mouse") then
			AF_ToolTip[aftt_localUser]["Anchor"] = "topleft";
			GameTooltip_SetDefaultAnchor = aftt_GameTooltip_SetDefaultAnchor;
		elseif (AF_ToolTip[aftt_localUser]["Anchor"] == "topleft") then
			AF_ToolTip[aftt_localUser]["Anchor"] = "top";
			GameTooltip_SetDefaultAnchor = aftt_GameTooltip_SetDefaultAnchor;
		elseif (AF_ToolTip[aftt_localUser]["Anchor"] == "top") then
			AF_ToolTip[aftt_localUser]["Anchor"] = "topright";
			GameTooltip_SetDefaultAnchor = aftt_GameTooltip_SetDefaultAnchor;
		elseif (AF_ToolTip[aftt_localUser]["Anchor"] == "topright") then
			AF_ToolTip[aftt_localUser]["Anchor"] = "left";
			GameTooltip_SetDefaultAnchor = aftt_GameTooltip_SetDefaultAnchor;
		elseif (AF_ToolTip[aftt_localUser]["Anchor"] == "left") then
			AF_ToolTip[aftt_localUser]["Anchor"] = "center";
			GameTooltip_SetDefaultAnchor = aftt_GameTooltip_SetDefaultAnchor;
		elseif (AF_ToolTip[aftt_localUser]["Anchor"] == "center") then
			AF_ToolTip[aftt_localUser]["Anchor"] = "right";
			GameTooltip_SetDefaultAnchor = aftt_GameTooltip_SetDefaultAnchor;
		elseif (AF_ToolTip[aftt_localUser]["Anchor"] == "right") then
			AF_ToolTip[aftt_localUser]["Anchor"] = "bottomleft";
			GameTooltip_SetDefaultAnchor = aftt_GameTooltip_SetDefaultAnchor;
		elseif (AF_ToolTip[aftt_localUser]["Anchor"] == "bottomleft") then
			AF_ToolTip[aftt_localUser]["Anchor"] = "bottom";
			GameTooltip_SetDefaultAnchor = aftt_GameTooltip_SetDefaultAnchor;
		elseif (AF_ToolTip[aftt_localUser]["Anchor"] == "bottom") then
			AF_ToolTip[aftt_localUser]["Anchor"] = "bottomright";
			GameTooltip_SetDefaultAnchor = aftt_GameTooltip_SetDefaultAnchor;
		elseif (AF_ToolTip[aftt_localUser]["Anchor"] == "bottomright") then
			AF_ToolTip[aftt_localUser]["Anchor"] = "none";
			GameTooltip_SetDefaultAnchor = aftt_GameTooltip_SetDefaultAnchor;
		elseif (AF_ToolTip[aftt_localUser]["Anchor"] == "none") then
			AF_ToolTip[aftt_localUser]["Anchor"] = "mouse";
			GameTooltip_SetDefaultAnchor = aftt_GameTooltip_SetDefaultAnchor;
		end
	elseif (option == "x+") then
		AF_ToolTip[aftt_localUser]["PositionX"] = AF_ToolTip[aftt_localUser]["PositionX"] + 5;
	elseif (option == "y+") then
		AF_ToolTip[aftt_localUser]["PositionY"] = AF_ToolTip[aftt_localUser]["PositionY"] + 5;
	elseif (option == "x-") then
		if (AF_ToolTip[aftt_localUser]["PositionX"] <= 5) then
			AF_ToolTip[aftt_localUser]["PositionX"] = 0;
		else
			AF_ToolTip[aftt_localUser]["PositionX"] = AF_ToolTip[aftt_localUser]["PositionX"] - 5;
		end
	elseif (option == "y-") then
		if (AF_ToolTip[aftt_localUser]["PositionY"] <= 5) then
			AF_ToolTip[aftt_localUser]["PositionY"] = 0;
		else
			AF_ToolTip[aftt_localUser]["PositionY"] = AF_ToolTip[aftt_localUser]["PositionY"] - 5;
		end
	end
end

function aftt_onEvent()
	if (event == "UPDATE_MOUSEOVER_UNIT") then
		if (UnitName("mouseover")) then
			AF_ToolTipRefresh:Show();
		end
	end
end

function aftt_GameTooltip_OnEvent()
	aftt_Old_GameTooltip_OnEvent();
	if (event ~= "CLEAR_TOOLTIP" and UnitExists("mouseover")) then
		aftt_format("mouseover");
	end
end

function aftt_onRefresh()
	--Set our options frame refresh
		if (aftt_optionFrame:IsVisible()) then
			aftt_TextLeft1:SetText("Anchor:");
			aftt_TextRight1:SetText(AF_ToolTip[aftt_localUser]["Anchor"]);
			aftt_TextLeft2:SetText("Offset X:");
			aftt_TextRight2:SetText(AF_ToolTip[aftt_localUser]["PositionX"]);
			aftt_TextLeft3:SetText("Offset Y:");
			aftt_TextRight3:SetText(AF_ToolTip[aftt_localUser]["PositionY"]);
			if (AF_ToolTip[aftt_localUser]["Anchor"] ~= "mouse" and AF_ToolTip[aftt_localUser]["Anchor"] ~= "none") then
				aftt_previous2:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up");
				aftt_previous3:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up");
				aftt_next2:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up");
				aftt_next3:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up");
				aftt_TextLeft2:SetVertexColor(1.0, 0.8, 0.0);
				aftt_TextRight2:SetVertexColor(1.0, 0.8, 0.0);
				aftt_TextLeft3:SetVertexColor(1.0, 0.8, 0.0);
				aftt_TextRight3:SetVertexColor(1.0, 0.8, 0.0);
			else
				aftt_previous2:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled");
				aftt_previous3:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled");
				aftt_next2:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled");
				aftt_next3:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled");
				aftt_TextLeft2:SetVertexColor(0.3, 0.3, 0.3);
				aftt_TextRight2:SetVertexColor(0.3, 0.3, 0.3);
				aftt_TextLeft3:SetVertexColor(0.3, 0.3, 0.3);
				aftt_TextRight3:SetVertexColor(0.3, 0.3, 0.3);
			end
			aftt_TextLeft4:SetText("Fade:");
			if (AF_ToolTip[aftt_localUser]["Fade"] == 1) then
				aftt_TextLeft4:SetVertexColor(1.0, 0.8, 0.0);
				aftt_TextRight4:SetVertexColor(1.0, 0.8, 0.0);
				aftt_TextRight4:SetText("Enabled");
			else
				aftt_TextLeft4:SetVertexColor(0.4, 0.4, 0.0);
				aftt_TextRight4:SetVertexColor(0.4, 0.4, 0.0);
				aftt_TextRight4:SetText("Disabled");
			end

			aftt_TextLeft5:SetText("PvP:");
			if (AF_ToolTip[aftt_localUser]["PvP"] == 1) then
				aftt_TextLeft5:SetVertexColor(1.0, 0.8, 0.0);
				aftt_TextRight5:SetVertexColor(1.0, 0.8, 0.0);
				aftt_TextRight5:SetText("Shown");
			else
				aftt_TextLeft5:SetVertexColor(0.4, 0.4, 0.0);
				aftt_TextRight5:SetVertexColor(0.4, 0.4, 0.0);
				aftt_TextRight5:SetText("Hidden");
			end

			aftt_TextLeft6:SetText("Tapped:");
			if (AF_ToolTip[aftt_localUser]["Tapped"] == 1) then
				aftt_TextLeft6:SetVertexColor(1.0, 0.8, 0.0);
				aftt_TextRight6:SetVertexColor(1.0, 0.8, 0.0);
				aftt_TextRight6:SetText("Shown");
			else
				aftt_TextLeft6:SetVertexColor(0.4, 0.4, 0.0);
				aftt_TextRight6:SetVertexColor(0.4, 0.4, 0.0);
				aftt_TextRight6:SetText("Hidden");
			end

			aftt_TextLeft7:SetText("Reaction:");
			if (AF_ToolTip[aftt_localUser]["ReactionText"] == 1) then
				aftt_TextLeft7:SetVertexColor(1.0, 0.8, 0.0);
				aftt_TextRight7:SetVertexColor(1.0, 0.8, 0.0);
				aftt_TextRight7:SetText("Shown");
			else
				aftt_TextLeft7:SetVertexColor(0.4, 0.4, 0.0);
				aftt_TextRight7:SetVertexColor(0.4, 0.4, 0.0);
				aftt_TextRight7:SetText("Hidden");
			end

			aftt_TextLeft8:SetText("Guild:");
			if (AF_ToolTip[aftt_localUser]["Guild"] == 1) then
				aftt_TextLeft8:SetVertexColor(1.0, 0.8, 0.0);
				aftt_TextRight8:SetVertexColor(1.0, 0.8, 0.0);
				aftt_TextRight8:SetText("Top");
			elseif (AF_ToolTip[aftt_localUser]["Guild"] == 2) then
				aftt_TextLeft8:SetVertexColor(1.0, 0.8, 0.0);
				aftt_TextRight8:SetVertexColor(1.0, 0.8, 0.0);
				aftt_TextRight8:SetText("Bottom");
			else
				aftt_TextLeft8:SetVertexColor(0.4, 0.4, 0.0);
				aftt_TextRight8:SetVertexColor(0.4, 0.4, 0.0);
				aftt_TextRight8:SetText("Hidden");
			end

			aftt_TextLeft9:SetText("Rank:");
			if (AF_ToolTip[aftt_localUser]["Rank"] == 1) then
				aftt_TextLeft9:SetVertexColor(1.0, 0.8, 0.0);
				aftt_TextRight9:SetVertexColor(1.0, 0.8, 0.0);
				aftt_TextRight9:SetText("Text");
			elseif (AF_ToolTip[aftt_localUser]["Rank"] == 2) then
				aftt_TextLeft9:SetVertexColor(1.0, 0.8, 0.0);
				aftt_TextRight9:SetVertexColor(1.0, 0.8, 0.0);
				aftt_TextRight9:SetText("Numeric");
			else
				aftt_TextLeft9:SetVertexColor(0.4, 0.4, 0.0);
				aftt_TextRight9:SetVertexColor(0.4, 0.4, 0.0);
				aftt_TextRight9:SetText("Hidden");
			end

				aftt_TextLeft10:SetText(aftt_color_chart_name);
				aftt_TextLeft11:SetText(aftt_color_chart_author);
		end
	if (UnitExists("mouseover") == nil) then
		aftt_updateFlag = {
			["Previous"] = "none";
			["Current"] = "none";
			["Reaction"] = 0;
			["EasterEgg"] = 0;
			["Guild"] = 0;
			["PvP"] = 0;
			["RankFlag"] = 0;
		}
		if (AF_ToolTip[aftt_localUser]["Fade"] == 0 or AF_ToolTip[aftt_localUser]["Fade"] == nil) then
			GameTooltip:Hide();
		end
		AF_ToolTipRefresh:Hide();
	else
		aftt_format("mouseover");
	end
end

function aftt_UnitFrame_OnEnter()
	aftt_Old_UnitFrame_OnEnter();
	aftt_updateFlag["Previous"] = "none";
	if (SHOW_NEWBIE_TIPS ~= "1") then
		aftt_format(this.unit);
	end
	aftt_updateFlag["Previous"] = "none";
end

function aftt_UnitFrame_OnLeave()
	if ( SpellIsTargeting() ) then
		SetCursor("CAST_ERROR_CURSOR");
	end
	this.updateTooltip = nil;
	if (SHOW_NEWBIE_TIPS == "1" or AF_ToolTip[aftt_localUser]["Fade"] == 0) then
		GameTooltip:Hide();
	else
		GameTooltip:FadeOut();	
	end
end

function aftt_TargetFrame_OnEnter()
	aftt_Old_TargetFrame_OnEnter();
	aftt_updateFlag["Previous"] = "none";
	aftt_format("mouseover");
	aftt_updateFlag["Previous"] = "none";
end

--preLoad Timer Setup-------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
function aftt_unitInit()
	local playerName = UnitName("player");
	local realmName = GetCVar("realmName");
	if (playerName == nil or playerName == UNKNOWNBEING or playerName == UKNOWNBEING or playerName == UNKNOWNOBJECT) then
		return;
	end
	aftt_playerName = playerName;
	aftt_realmName = realmName;
	aftt_timerDone = 1;
	AF_ToolTipFrame:Hide();
end
aftt_Timer = 0;
aftt_timerDone = nil;
function aftt_onUpdate(arg1)
	aftt_Timer = aftt_Timer + arg1
	if not aftt_timerDone and aftt_Timer>0.2 then
		aftt_unitInit();
		aftt_Timer = 0;
	end
	if (aftt_timerDone == 1) then
		aftt_onLoad();
	end
end



--onLoad Routine------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
function aftt_onLoad()

	--Set our frame with the name and version
		aftt_TextHeader:SetText("AF_" .. name .. " v" .. version);
		aftt_TextHeader2:SetText("Color Chart Details");
		aftt_TextHeader:SetVertexColor(1.0, 1.0, 1.0);
		aftt_TextHeader2:SetVertexColor(1.0, 1.0, 1.0);
		aftt_TextLeft9:SetVertexColor(1.0, 0.8, 0.0);
		aftt_TextLeft10:SetVertexColor(0.0, 0.6, 1.0);
	--Create update table
		aftt_updateFlag = {
			["Previous"] = "none";
			["Current"] = "none";
			["Reaction"] = 0;
			["EasterEgg"] = 0;
			["Guild"] = 0;
			["PvP"] = 0;
			["RankFlag"] = 0;
		}

	--Create user table if it doesnt exist
		aftt_localUser = (aftt_playerName .. "|" .. aftt_realmName);
		if (AF_ToolTip == nil) then
			AF_ToolTip = {};
		end
		if (AF_ToolTip[aftt_localUser] == nil) then
			AF_ToolTip[aftt_localUser] = {
				["Anchor"] = "none";
				["PositionX"] = 0;
				["PositionY"] = 15;
				["Fade"] = 1;
				["PvP"] = 0;
				["ReactionText"] = 0;
				["Guild"] = 1;
				["Rank"] = 1;
				["Tapped"] = 1;
			}
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: User Table for " .. aftt_playerName .. " created successfully!");
		end

	--Register our slash commands for use
		aftt_slashCommands();

	--Swap Blizzard's unit frame mouseover function out for our own (making sure to backup the old function)
		aftt_Old_UnitFrame_OnEnter = UnitFrame_OnEnter;
		UnitFrame_OnEnter = aftt_UnitFrame_OnEnter;
		aftt_Old_UnitFrame_OnLeave = UnitFrame_OnLeave;
		UnitFrame_OnLeave = aftt_UnitFrame_OnLeave;

	--Swap Blizzard's target frame mouseover function out for our own (making sure to backup the old function)
		aftt_Old_TargetFrame_OnEnter = TargetFrame_OnEnter;
		TargetFrame_OnEnter = aftt_TargetFrame_OnEnter;

	--Swap Blizzard's tooltip anchor function out for our own (making sure to backup the old function)
		aftt_OriginalGameTooltip_SetDefaultAnchor = GameTooltip_SetDefaultAnchor;
		GameTooltip_SetDefaultAnchor = aftt_GameTooltip_SetDefaultAnchor;

	--Swap Blizzard's tooltip event function out for our own (making sure to backup the old function)
		aftt_Old_GameTooltip_OnEvent = GameTooltip_OnEvent;
		GameTooltip_OnEvent = aftt_GameTooltip_OnEvent;

	--Set colors
		--loaded from colorChart.lua

	--Output message to let player know AF_ToolTip has loaded, and if there were any missing colors
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: v" .. version .. " " .. aftt_translate_loaded .. " for " .. aftt_playerName .. " of " .. aftt_realmName);
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: Theme: |cff0099FF" .. aftt_color_chart_name .. "|r by |cff0099FF" .. aftt_color_chart_author .. "|r applied");
		if (aftt_variableChecker_Flag == 1) then
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: |cffFF0000[WARNING]|r: some colors are missing from current color chart, defaulting them to white");
		end
end



--Unit MouseOver Routine----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
function aftt_format(unit)


	--Data Collection------------------------------------------
	-----------------------------------------------------------
		--detect if on same unit from previous refresh
			aftt_updateFlag["Current"] = UnitName(unit);
			if (aftt_updateFlag["Current"] == aftt_updateFlag["Previous"] and aftt_updateFlag["Previous"] ~= "none") then
				--do not reset flags, we're on the same unit
			else
				aftt_updateFlag = {
					["EasterEgg"] = 0;
					["Guild"] = 0;
					["PvP"] = 0;
					["RankFlag"] = 0;
				}
			end

		--[[
		--detect Blizzard's tooltip bug that shows bogus data instead of a unit
		--currently disabled due to issues with non enUS client
			local firstLine = GameTooltipTextLeft1:GetText();
			local nameLine, matched;
			if (firstLine) then
				nameLine, matched = string.gsub(GameTooltipTextLeft1:GetText(), (UnitName(unit) .. ".*"), "");
				if (matched == 1) then
					--not bugged
				else
					--bugged, lets hide it
					GameTooltip:Hide();
					--DEFAULT_CHAT_FRAME:AddMessage("Found item bug: " .. firstLine);				
				end
			end
		--]]

		--unit race
			if (UnitRace(unit) and UnitIsPlayer(unit)) then
				--race, it is a player
					aftt_text_race = UnitRace(unit);
			elseif (UnitPlayerControlled(unit)) then
				--creature family, its is a pet
					aftt_text_race = UnitCreatureFamily(unit);
					aftt_color_race = aftt_color_race_mob;
			else
				--creature type, it is a mob
					if (UnitCreatureType(unit) == aftt_translate_notspecified) then
						aftt_text_race = ""
						aftt_color_race = aftt_color_race_mob;
					else
						aftt_text_race = UnitCreatureType(unit);
						aftt_color_race = aftt_color_race_mob;
					end
			end
			if (aftt_text_race == nil) then
				aftt_text_race = ("");
			else
				aftt_text_race = (aftt_text_race .. " ");
			end
				aftt_color_race = "FFFFFF";

		--unit class
			if (UnitClass(unit) and UnitIsPlayer(unit)) then
				aftt_text_class = (UnitClass(unit) .. " ");
				if (UnitClass(unit) == aftt_translate_mage) then
					aftt_color_class = aftt_color_class_mage;
				elseif (UnitClass(unit) == aftt_translate_warlock) then
					aftt_color_class = aftt_color_class_warlock;
				elseif (UnitClass(unit) == aftt_translate_priest) then
					aftt_color_class = aftt_color_class_priest;
				elseif (UnitClass(unit) == aftt_translate_druid) then
					aftt_color_class = aftt_color_class_druid;
				elseif (UnitClass(unit) == aftt_translate_shaman) then
					aftt_color_class = aftt_color_class_shaman;
				elseif (UnitClass(unit) == aftt_translate_paladin) then
					aftt_color_class = aftt_color_class_paladin;
				elseif (UnitClass(unit) == aftt_translate_rogue) then
					aftt_color_class = aftt_color_class_rogue;
				elseif (UnitClass(unit) == aftt_translate_hunter) then
					aftt_color_class = aftt_color_class_hunter;
				elseif (UnitClass(unit) == aftt_translate_warrior) then
					aftt_color_class = aftt_color_class_warrior;
				else
					aftt_color_class = aftt_color_unknown;
				end
			else
				aftt_text_class = "";
				aftt_color_class = aftt_color_unknown;
			end

		--unit elite
			if (UnitClassification(unit) and UnitClassification(unit) ~= "normal" and UnitHealth(unit) > 0) then
				if (UnitClassification(unit) == "elite") then
					aftt_text_elite = ("(" .. aftt_translate_elite .. ")");
					aftt_color_elite = aftt_color_elite_elite;
				elseif (UnitClassification(unit) == "worldboss") then
					aftt_text_elite = ("(" .. aftt_translate_worldboss .. ")");
					aftt_color_elite = aftt_color_elite_worldboss;
				elseif (UnitClassification(unit) == "rare") then
					aftt_text_elite = ("(" .. aftt_translate_rare .. ")");
					aftt_color_elite = aftt_color_elite_rare;
				elseif (UnitClassification(unit) == "rareelite") then
					aftt_text_elite = ("(" .. aftt_translate_rareelite .. ")");
					aftt_color_elite = aftt_color_elite_rareelite;
				else
					aftt_text_elite = ("(" .. UnitClassification(unit) .. ")");
					aftt_color_elite = aftt_color_unknown;
				end
			else
				aftt_text_elite = "";
				aftt_color_elite = aftt_color_unknown;
			end

		--unit name, description and bg color
			if (UnitPlayerControlled(unit)) then
				if (UnitCanAttack(unit, "player") and UnitCanAttack ("player",unit)) then
					--red, hostile, both can attack
						GameTooltip:SetBackdropColor(aftt_background_color["Player_Hostile"]["red"], aftt_background_color["Player_Hostile"]["green"], aftt_background_color["Player_Hostile"]["blue"]);
						aftt_color_name = aftt_color_name_hostile;
						aftt_color_description = aftt_color_description_hostile;
						aftt_text_reaction = aftt_translate_hostile;
				elseif (not UnitCanAttack(unit, "player") and UnitCanAttack("player",unit)) then
					--yellow, neutral, only I can attack
						GameTooltip:SetBackdropColor(aftt_background_color["Player_Neutral"]["red"], aftt_background_color["Player_Neutral"]["green"], aftt_background_color["Player_Neutral"]["blue"]);
						aftt_color_name = aftt_color_name_neutral;
						aftt_color_description = aftt_color_description_neutral;
						aftt_text_reaction = aftt_translate_neutral;
				elseif (UnitCanAttack(unit, "player") and not UnitCanAttack("player",unit)) then
					--purple, caution, only they can attack
						GameTooltip:SetBackdropColor(aftt_background_color["Player_Caution"]["red"], aftt_background_color["Player_Caution"]["green"], aftt_background_color["Player_Caution"]["blue"]);
						aftt_color_name = aftt_color_name_caution;
						aftt_color_description = aftt_color_description_caution;
						aftt_text_reaction = aftt_translate_caution;
				elseif (not UnitCanAttack(unit, "player") and not UnitCanAttack("player",unit)) then
					if (UnitIsPVP(unit)) then
						--green, friendly pvp, neither can attack
							GameTooltip:SetBackdropColor(aftt_background_color["Player_Friendly_PvP"]["red"], aftt_background_color["Player_Friendly_PvP"]["green"], aftt_background_color["Player_Friendly_PvP"]["blue"]);
							aftt_color_name = aftt_color_name_pvp;
							aftt_color_description = aftt_color_description_pvp;
							aftt_text_reaction = aftt_translate_friendly;
					else
						--blue, friendly, neither can attack
							GameTooltip:SetBackdropColor(aftt_background_color["Player_Friendly"]["red"], aftt_background_color["Player_Friendly"]["green"], aftt_background_color["Player_Friendly"]["blue"]);
							aftt_color_name = aftt_color_name_friendly;
							aftt_color_description = aftt_color_description_friendly;
							aftt_text_reaction = aftt_translate_friendly;
					end
				end
			elseif (UnitReaction(unit,"player") and UnitReaction(unit,"player") <= 3) then
				--red, they are hostile
					GameTooltip:SetBackdropColor(aftt_background_color["Mob_Hostile"]["red"], aftt_background_color["Mob_Hostile"]["green"], aftt_background_color["Mob_Hostile"]["blue"]);
					aftt_color_name = aftt_color_name_hostile;
					aftt_text_reaction = aftt_translate_hostile;
					aftt_color_description = aftt_color_description_hostile
			elseif (UnitReaction(unit,"player") and UnitReaction(unit,"player") == 4) then
				--yellow, they are neutral
					GameTooltip:SetBackdropColor(aftt_background_color["Mob_Neutral"]["red"], aftt_background_color["Mob_Neutral"]["green"], aftt_background_color["Mob_Neutral"]["blue"]);
					aftt_color_name = aftt_color_name_neutral;
					aftt_text_reaction = aftt_translate_neutral;
					aftt_color_description = aftt_color_description_neutral
			else
				if (UnitIsPVP(unit)) then
					--green, pvp enabled friend
						GameTooltip:SetBackdropColor(aftt_background_color["Mob_Friendly_PvP"]["red"], aftt_background_color["Mob_Friendly_PvP"]["green"], aftt_background_color["Mob_Friendly_PvP"]["blue"]);
						aftt_color_name = aftt_color_name_pvp;
						aftt_color_description = aftt_color_description_pvp
				else
					--blue, they are friendly
						GameTooltip:SetBackdropColor(aftt_background_color["Mob_Friendly"]["red"], aftt_background_color["Mob_Friendly"]["green"], aftt_background_color["Mob_Friendly"]["blue"]);
						aftt_color_name = aftt_color_name_friendly;
						aftt_color_description = aftt_color_description_friendly;
				end
				aftt_text_reaction = aftt_translate_friendly;
			end
		--unit tapped?
			if (AF_ToolTip[aftt_localUser]["Tapped"] == 1) then
				if (UnitIsTapped(unit)and (not UnitIsTappedByPlayer(unit))) then
					aftt_color_name = aftt_color_name_tapped_by_other;
					aftt_color_description = aftt_color_description_tapped_by_other;
					aftt_text_reaction = aftt_translate_tapped;
				elseif (UnitIsTappedByPlayer(unit)) then
					GameTooltip:SetBackdropColor(aftt_background_color["Mob_Hostile"]["red"], aftt_background_color["Mob_Hostile"]["green"], aftt_background_color["Mob_Hostile"]["blue"]);
					aftt_color_name = aftt_color_name_tapped_by_me;
					aftt_color_description = aftt_color_description_tapped_by_me;
					aftt_text_reaction = aftt_translate_hostile;
				end
			end

		--unit level and level difference color
			if (UnitLevel(unit) and UnitLevel(unit) >= 1) then
				aftt_text_level = UnitLevel(unit);
			else
				aftt_text_level = "??";
			end
			aftt_text_level = (aftt_translate_level .. " " .. aftt_text_level .. " ");
			local levelDiff = UnitLevel(unit) - UnitLevel("player");
			if (UnitFactionGroup(unit) ~= UnitFactionGroup("player")) then
				if ( levelDiff >= 5 or UnitLevel(unit) == -1) then
					aftt_color_level = aftt_color_level_impossible
				elseif ( levelDiff >= 3 ) then
					aftt_color_level = aftt_color_level_hard;
				elseif ( levelDiff >= -2 ) then
					aftt_color_level = aftt_color_level_normal;
				elseif ( -levelDiff <= GetQuestGreenRange() ) then
					aftt_color_level = aftt_color_level_easy;
				else
					aftt_color_level = aftt_color_level_trivial;
				end
			else
					aftt_color_level = aftt_color_level_same_faction;			
			end

		--pvp honor rank
			if (aftt_updateFlag["RankFlag"] == 0) then
				if (UnitPVPRank(unit)) then
				    aftt_rankName, aftt_rankNumber = GetPVPRankInfo(UnitPVPRank("mouseover"), "mouseover");
				end
				if (aftt_rankName == nil) then
				    aftt_rankName = "";			
				else
					aftt_rankName = ("[" .. aftt_rankName .. "] ");
				end
				if (aftt_rankNumber == nil or aftt_rankNumber < 1) then
				    aftt_rankNumber = "";
				else
					aftt_rankNumber = ("[" .. aftt_rankNumber .. "] ");				
				end

				if (AF_ToolTip[aftt_localUser]["Rank"] == 1) then
					aftt_rank = aftt_rankName;
				elseif (AF_ToolTip[aftt_localUser]["Rank"] == 2) then
					aftt_rank = aftt_rankNumber;
				else
					aftt_rank = "";
				end

				aftt_updateFlag["RankFlag"] = 1;
			else
				if (aftt_rank == nil) then
					aftt_rank = "";
				end
			end

		--unit is corpse
			if (UnitHealth(unit) == 0) then
				aftt_text_corpse = aftt_translate_corpse;
				aftt_color_class = aftt_color_corpse;
				aftt_color_race = aftt_color_corpse;
				aftt_color_elite = aftt_color_corpse;
				aftt_color_name = aftt_color_corpse;
				aftt_color_description = aftt_color_corpse;
				aftt_color_level = aftt_color_corpse;
			else
				aftt_text_corpse = "";
			end

	--Output Name Data-----------------------------------------
	-----------------------------------------------------------
		if (AF_ToolTip[aftt_localUser]["ReactionText"] == 1) then
			GameTooltipTextLeft1:SetText("|cff" .. aftt_color_name .. aftt_rank .. UnitName(unit) .. " (" .. aftt_text_reaction .. ")|r")
		else
			GameTooltipTextLeft1:SetText("|cff" .. aftt_color_name .. aftt_rank .. UnitName(unit) .. "|r");
		end

	--Output Level Line Data-----------------------------------
	-----------------------------------------------------------
		local levelLine, matched;
		if (GameTooltipTextLeft2:GetText() == nil) then
			GameTooltip:Hide();
		else
			levelLine, matched = string.gsub(GameTooltipTextLeft2:GetText(), (aftt_translate_level .. ".*"), "");
			if (matched == 1) then
				levelLine = 2;
			else
				if (GameTooltipTextLeft3:GetText()) then
					levelLine, matched = string.gsub(GameTooltipTextLeft3:GetText(), (aftt_translate_level .. ".*"), "");
					if (matched == 1) then
						levelLine = 3;
					else
						levelLine = nil;
					end
				else
					levelLine = nil;
				end
			end
		end
		if (levelLine) then
			getglobal("GameTooltipTextLeft" .. levelLine):SetText("|cff" .. aftt_color_level .. aftt_text_level .. "|r" .. "|cff" .. aftt_color_race .. aftt_text_race .. "|r" .. "|cff" .. aftt_color_class .. aftt_text_class .. "|r" .. "|cff" .. aftt_color_elite .. aftt_text_elite .. "|r" .. "|cff" .. aftt_color_corpse .. aftt_text_corpse .. "|r");
			if (levelLine == 3) then
				GameTooltipTextLeft2:SetText("|cff" .. aftt_color_description .. GameTooltipTextLeft2:GetText() .. "|r")
			end
		end

	--Append Easter Eggs---------------------------------------
	-----------------------------------------------------------
		if (aftt_updateFlag["EasterEgg"] == 0 and UnitName(unit) == "Iniko" and (GetCVar("realmName") == "Chromaggus")) then
			GameTooltip:AddLine("|cff" .. aftt_color_name .. "The Author of AF_ToolTip|r");
			aftt_updateFlag["EasterEgg"] = 1;
		end

	--Show/Hide Guild------------------------------------------
	-----------------------------------------------------------
		if (aftt_updateFlag["Guild"] == 0 and GetGuildInfo(unit)) then
			--Are they guildmates?
			if (GetGuildInfo(unit) == GetGuildInfo("player")) then
				aftt_color_guild = aftt_color_guildmate;
			else
				aftt_color_guild = aftt_color_description;
			end
			if (AF_ToolTip[aftt_localUser]["Guild"] == 0 or AF_ToolTip[aftt_localUser]["Guild"] == nil) then
				--do nothing
			elseif (AF_ToolTip[aftt_localUser]["Guild"] == 1) then
				--Show
				aftt_old_line2 = GameTooltipTextLeft2:GetText();
				aftt_old_line3 = GameTooltipTextLeft3:GetText();
				if (GameTooltipTextLeft3:GetText() ~= nil) then
					GameTooltipTextLeft3:SetText(aftt_old_line2);
				else
					GameTooltip:AddLine(aftt_old_line2);
				end
				if (GameTooltipTextLeft4:GetText() ~= nil) then
					GameTooltipTextLeft3:SetText(aftt_old_line3);
				else
					GameTooltip:AddLine(aftt_old_line3);
				end
				GameTooltipTextLeft2:SetText("|cff" .. aftt_color_guild .. GetGuildInfo(unit) .. "|r");
			elseif (AF_ToolTip[aftt_localUser]["Guild"] == 2) then
				--Show at Bottom
				GameTooltip:AddLine("|cff" .. aftt_color_guild .. GetGuildInfo(unit) .. "|r");
			end
			aftt_updateFlag["Guild"] = 1;
		end

	--Show/Hide PvP--------------------------------------------
	-----------------------------------------------------------
		aftt_lineCount = 1;
		for i = 1, 10 do
			aftt_getLine = getglobal("GameTooltipTextLeft" .. aftt_lineCount);
			if (aftt_getLine:GetText()) then
				local pvpLine, matchPVP;
				pvpLine, matchPVP = string.gsub(aftt_getLine:GetText(), (aftt_translate_pvp .. ".*"), "");
				if (matchPVP == 1) then
					aftt_getLine:SetText("");
					break;
				else
					aftt_lineCount = aftt_lineCount + 1;
				end
			end
		end
		if (AF_ToolTip[aftt_localUser]["PvP"] ~= 1) then

		else
			if (UnitIsPVP(unit)) then
				if (aftt_updateFlag["PvP"] == 0) then
					GameTooltip:AddLine("|cffFFFFFFPvP|r");
					aftt_updateFlag["PvP"] = 1;
				end
			end
		end

	--Show Tooltip---------------------------------------------
	-----------------------------------------------------------
		GameTooltip:Show();
		aftt_updateFlag["Previous"] = UnitName(unit);
end



--Frame Mouseover Routines--------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
