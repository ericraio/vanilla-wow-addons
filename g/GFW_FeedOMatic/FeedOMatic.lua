------------------------------------------------------
-- FeedOMatic.lua
------------------------------------------------------
FOM_VERSION = "11200.1";
------------------------------------------------------

-- TODO: if you don't auto-feed, have an option to make the need to feed more noticeable (e.g., pulsing halo around the pet-happiness icon).

-- constants
FOM_WARNING_INTERVAL = 10; -- don't warn more than once per this many seconds
MAX_QUALITY = 35 * 60 + 1; -- We store a notion of a food's "quality": its best happiness-per-tick multiplied by the pet's level as of when that tick occurred. We use "best" because a pet that's closer to "sated" (maximum happiness) will receive less happiness per tick than he would from the same food if he were hungrier. (So, a food that gives 35 happiness per tick to a level 60 pet is "better" than a food that's worth 35 happiness per tick to a level 30 pet.) Foods whose quality hasn't been observed yet are given this value when sorting, so we can prioritize the discovery of new foods' quality ratings.
MAX_KEEPOPEN_SLOTS = 150;

-- Configuration
FOM_Config_Default = {
	Enabled = false;
	Alert = "emote";
	Level = "content";
	KeepOpenSlots = 8;
	AvoidUsefulFood = true;
	AvoidQuestFood = true;
	AvoidBonusFood = true;
	Fallback = false;
	SaveForCookingLevel = 1;
	PreferHigherQuality = true;
	Tooltip = true;
};
FOM_Config = FOM_Config_Default;

-- FOM_Cooking = { };
-- Has the following internal structure:
--		REALM_PLAYER = {
--			FOODNAME = SKILL_DIFFICULTY,
--		}

-- FOM_QuestFood = { };
-- Has the following internal structure:
--		REALM_PLAYER = {
--			FOODNAME = QUANTITY_REQUIRED,
--		}

-- FOM_FoodQuality = { };
-- Has the following internal structure:
--		REALM_PLAYER = {
--			PETNAME = {
--				FOODNAME = HAPPINESS,
--			}
--		}

-- Variables
FOM_State = { };
FOM_State.InCombat = false;
FOM_State.IsAFK = false;
FOM_State.ShouldFeed = false;
FOM_LastWarning = 0;

FOM_LastFood = nil;
FOM_RealmPlayer = nil;
FOM_LastPetName = nil;

-- Anti-freeze code borrowed from ReagentInfo (in turn, from Quest-I-On):
-- keeps WoW from locking up if we try to scan the tradeskill window too fast.
FOM_TradeSkillLock = { };
FOM_TradeSkillLock.Locked = false;
FOM_TradeSkillLock.EventTimer = 0;
FOM_TradeSkillLock.EventCooldown = 0;
FOM_TradeSkillLock.EventCooldownTime = 1;


-- State variable used to track required quantities of quest food when it's in more than one stack
FOM_Quantity = { };

-- Remember how item IDs map to food names at runtime, but don't bloat long-term memory with it...
FOM_FoodIDsToNames = {};

function FOM_FeedButton_OnClick()
	if (arg1 == "RightButton") then
		if FOM_OptionsFrame:IsVisible() then
			HideUIPanel(FOM_OptionsFrame);
		else
			ShowUIPanel(FOM_OptionsFrame);
		end
	else
		FOM_Feed();
	end
end

function FOM_FeedButton_OnEnter()
	if ( PetFrameHappiness.tooltip ) then
		GameTooltip:SetOwner(PetFrameHappiness, "ANCHOR_RIGHT");
		GameTooltip:SetText(PetFrameHappiness.tooltip);
		if ( PetFrameHappiness.tooltipDamage ) then
			GameTooltip:AddLine(PetFrameHappiness.tooltipDamage, "", 1, 1, 1);
		end
		if ( PetFrameHappiness.tooltipLoyalty ) then
			GameTooltip:AddLine(PetFrameHappiness.tooltipLoyalty, "", 1, 1, 1);
		end
		GameTooltip:Show();
	end
end

function FOM_FeedButton_OnLeave()
	GameTooltip:Hide();
end

function FOM_OnLoad()

	-- Register for Events
	this:RegisterEvent("VARIABLES_LOADED");

	-- Register Slash Commands
	SLASH_FEEDOMATIC1 = "/feedomatic";
	SLASH_FEEDOMATIC2 = "/fom";
	SLASH_FEEDOMATIC3 = "/feed";
	SLASH_FEEDOMATIC4 = "/petfeed"; -- Rauen's PetFeed compatibility
	SLASH_FEEDOMATIC5 = "/pf";
	SlashCmdList["FEEDOMATIC"] = function(msg)
		FOM_ChatCommandHandler(msg);
	end
	
	-- hook functions so we can manage per-pet saved food quality data
	FOM_Original_PetRename = PetRename;
	PetRename = FOM_PetRename;
	FOM_Original_PetAbandon = PetAbandon;
	PetAbandon = FOM_PetAbandon;
	
	--GFWUtils.Debug = true;

	GFWUtils.Print("Fizzwidget Feed-O-Matic "..FOM_VERSION.." initialized!");

end

function FOM_CheckSetup()

	_, realClass = UnitClass("player");
	if (realClass ~= "HUNTER") then return; end

	if (FOM_RealmPlayer == nil) then
		FOM_RealmPlayer = GetCVar("realmName") .. "." .. UnitName("player");
	end
	local currentPetName = UnitName("pet");
	if (currentPetName and currentPetName ~= "" and currentPetName ~= UNKNOWNOBJECT) then
		FOM_LastPetName = currentPetName;
	end
	
	if (FOM_FoodQuality == nil) then
		FOM_FoodQuality = { };
	end	
	if (FOM_FoodQuality[FOM_RealmPlayer] == nil) then
		FOM_FoodQuality[FOM_RealmPlayer] = { };
	end
	if (FOM_LastPetName) then
		if (FOM_FoodQuality[FOM_RealmPlayer][FOM_LastPetName] == nil) then
			FOM_FoodQuality[FOM_RealmPlayer][FOM_LastPetName] = { };
		end
	end
			
end

function FOM_Tooltip(frame, name, link, source)
	if (FOM_Config.Tooltip and name ~= nil and UnitExists("pet")) then
		FOM_CheckSetup();
				
		local itemID = FOM_IDFromLink(link);
		if (not FOM_IsInDiet(itemID)) then
			return false;
		end
		
		local color;
		local absoluteQuality = FOM_FoodQuality[FOM_RealmPlayer][FOM_LastPetName][itemID];
		if (absoluteQuality == nil) then
			color = HIGHLIGHT_FONT_COLOR;
			frame:AddLine(string.format(FOM_QUALITY_UNKNOWN, FOM_LastPetName), color.r, color.g, color.b);
			return true;
		else
			local currentQuality = absoluteQuality / UnitLevel("pet");
			if (currentQuality < 0) then
				color = QuestDifficultyColor["trivial"];
				frame:AddLine(string.format(FOM_QUALITY_UNDER, FOM_LastPetName), color.r, color.g, color.b);
				return true;
			elseif (currentQuality == 0) then
				color = QuestDifficultyColor["trivial"];
				frame:AddLine(string.format(FOM_QUALITY_MIGHT, FOM_LastPetName), color.r, color.g, color.b);
				return true;
			elseif (currentQuality <= 8) then
				color = QuestDifficultyColor["standard"];
				frame:AddLine(string.format(FOM_QUALITY_WILL, FOM_LastPetName), color.r, color.g, color.b);
				return true;
			elseif (currentQuality <= 17) then
				color = QuestDifficultyColor["difficult"];
				frame:AddLine(string.format(FOM_QUALITY_LIKE, FOM_LastPetName), color.r, color.g, color.b);
				return true;
			elseif (currentQuality <= 35) then
				color = QuestDifficultyColor["verydifficult"];
				frame:AddLine(string.format(FOM_QUALITY_LOVE, FOM_LastPetName), color.r, color.g, color.b);
				return true;
			else
				GFWUtils.DebugLog("Unexpected food quality level "..currentQuality);
				return false;
			end
		end
	end
end

function FOM_OnEvent(event, arg1)

	-- Save Variables
	if ( event == "VARIABLES_LOADED" ) then
				
		_, realClass = UnitClass("player");
		if (realClass == "HUNTER") then
			-- monitor status for whether we're able to feed
			this:RegisterEvent("PET_ATTACK_START");
			this:RegisterEvent("PET_ATTACK_STOP");
--			this:RegisterEvent("CHAT_MSG_SYSTEM");
						
			-- check your pet roster when at the stables so we don't bloat SavedVariables
			this:RegisterEvent("PET_STABLE_SHOW");
			this:RegisterEvent("PET_STABLE_UPDATE");

			-- track whether foods are useful for Cooking 
			this:RegisterEvent("TRADE_SKILL_SHOW");
			this:RegisterEvent("TRADE_SKILL_UPDATE");

			-- figure out what happens when we try to feed pet (gain happiness, didn't like, etc)
			this:RegisterEvent("CHAT_MSG_SPELL_TRADESKILLS");
			this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
			this:RegisterEvent("UI_ERROR_MESSAGE");
			
			-- Events for trying to catch when the pet needs feeding
			this:RegisterEvent("PET_BAR_SHOWGRID");
			this:RegisterEvent("PET_BAR_UPDATE");
			this:RegisterEvent("PET_UI_UPDATE");
			this:RegisterEvent("UNIT_HAPPINESS");

			FOM_FeedButton = CreateFrame("Button", "FOM_FeedButton", PetFrameHappiness);
			FOM_FeedButton:SetAllPoints(PetFrameHappiness);
			FOM_FeedButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
			FOM_FeedButton:SetScript("OnClick", FOM_FeedButton_OnClick);
			FOM_FeedButton:SetScript("OnEnter", FOM_FeedButton_OnEnter);
			FOM_FeedButton:SetScript("OnLeave", FOM_FeedButton_OnLeave);

			table.insert(UISpecialFrames,"FOM_OptionsFrame");	
					
			if (FOM_Config.Level == "happy") then
				-- we've redefined the Level option and this setting is no loger available
				FOM_Config.Level = "content";
			end
			
			if (FOM_Config.Tooltip) then
				GFWTooltip_AddCallback("GFW_FeedOMatic", FOM_Tooltip);
			end
		end
		return;

	elseif ( event == "PET_ATTACK_START" ) then
	
		-- Set Flag
		FOM_State.InCombat = true;
		return;
		
	elseif ( event == "PET_ATTACK_STOP" ) then
	
		-- Remove Flag
		FOM_State.InCombat = false;
		
	elseif ( event == "CHAT_MSG_SPELL_TRADESKILLS" ) then
	
		if (FOM_FEEDPET_LOG_FIRSTPERSON == nil) then
			FOM_FEEDPET_LOG_FIRSTPERSON = GFWUtils.FormatToPattern(FEEDPET_LOG_FIRSTPERSON);
		end
		_, _, foodName = string.find(arg1, FOM_FEEDPET_LOG_FIRSTPERSON);
		if (foodName and foodName ~= "") then
			local foodID = GFWTable.KeyOf(FOM_FoodIDsToNames, foodName);
			if (foodID == nil) then
				local bag, slot = FOM_FindSpecificFood(foodName);
				local foodLink = GetContainerItemLink(bag, slot);
				foodID = FOM_IDFromLink(foodLink);
			end
			if (foodID) then
				FOM_LastFood = GFWUtils.ItemLink(foodID);
				GFWUtils.DebugLog("Manually fed "..FOM_LastFood);
			end
		end
		return;

	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS" ) then
		
		if (arg1 and FOM_HasFeedEffect()) then
			if (FOM_POWERGAIN_OTHER == nil and POWERGAINSELFOTHER) then
				FOM_POWERGAIN_OTHER = GFWUtils.FormatToPattern(POWERGAINSELFOTHER);
			end
			if (FOM_POWERGAIN_OTHER == nil and POWERGAIN_OTHER) then
				FOM_POWERGAIN_OTHER = GFWUtils.FormatToPattern(POWERGAIN_OTHER);
			end
			if (FOM_POWERGAIN_OTHER == nil) then
				GFWUtils.PrintOnce(GFWUtils.Red("Feed-O-Matic Error: ").. "Can't find parse pattern for pet happiness.");
				return;
			end	
			_, _, name, amount, powerType = string.find(arg1, FOM_POWERGAIN_OTHER);
			local happiness;
			if (name == UnitName("pet") and powerType == HAPPINESS_POINTS) then
				happiness = tonumber(amount);
			else
				return;
			end
						
			if (FOM_LastFood and happiness > 0) then
				FOM_CheckSetup();
				local itemID = FOM_IDFromLink(FOM_LastFood);
				local knownQuality = FOM_FoodQuality[FOM_RealmPlayer][FOM_LastPetName][itemID];
				local quality = happiness * UnitLevel("pet");
				FOM_FoodQuality[FOM_RealmPlayer][FOM_LastPetName][itemID] = math.max((knownQuality or 0), quality);
				FOM_LastFood = nil;
			end
		end
		return;
	
	elseif ( event == "UI_ERROR_MESSAGE" ) then

		if (arg1 and string.find(arg1, SPELL_FAILED_FOOD_LOWLEVEL)) then
			
			FOM_CheckSetup();

			if not (FOM_LastFood == nil) then
				local itemID = FOM_IDFromLink(FOM_LastFood);
				FOM_FoodQuality[FOM_RealmPlayer][FOM_LastPetName][itemID] = -1;
				FOM_LastFood = nil;
				if ( FOM_Config.Alert == "chat") then
					GFWUtils.Print(string.format(FOM_FEEDING_EAT_ANOTHER, UnitName("pet")));
				elseif ( FOM_Config.Alert == "emote") then
					SendChatMessage(string.format(FOM_FEEDING_FEED_ANOTHER, UnitName("pet")), "EMOTE");
				end
				return;
			end
		
		elseif (arg1 and string.find(arg1, SPELL_FAILED_WRONG_PET_FOOD)) then
			
			FOM_CheckSetup();

			if (FOM_LastFood) then

				if ( FOM_Config.Alert == "chat") then
					GFWUtils.Print(string.format(FOM_FEEDING_EAT_ANOTHER, UnitName("pet")));
				elseif ( FOM_Config.Alert == "emote") then
					SendChatMessage(string.format(FOM_FEEDING_FEED_ANOTHER, UnitName("pet")), "EMOTE");
				end
				-- remove from quality tracking
				local itemID = FOM_IDFromLink(FOM_LastFood);
				FOM_FoodQuality[FOM_RealmPlayer][FOM_LastPetName][itemID] = nil;
				
				-- remove from diet
				local dietList = {GetPetFoodTypes()};
				for _, diet in dietList do 
					if ( FOM_RemoveFood(string.lower(diet), itemID) ) then
						local capDiet = string.upper(string.sub(diet, 1, 1)) .. string.sub(diet, 2); -- print a nicely capitalized version
						GFWUtils.Print("Removed "..FOM_LastFood.." from "..GFWUtils.Hilite(capDiet).." list.");
					end
				end
				FOM_LastFood = nil;
				return;
			end
		end
		return;
		
	elseif (event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_UPDATE") then
		if (GetTradeSkillLine() ~= nil and GetTradeSkillLine() == FOM_CookingSpellName()) then
			if (FOM_Config.SaveForCookingLevel >= 0 and FOM_Config.SaveForCookingLevel <= 3) then
				-- Update Cooking reagents list so we can avoid consuming food we could skillup from.
				if (FOM_RealmPlayer == nil) then
					FOM_RealmPlayer = GetCVar("realmName") .. "." .. UnitName("player");
				end
				if (FOM_Cooking == nil) then
					FOM_Cooking = { };
				end
				if (FOM_Cooking[FOM_RealmPlayer] == nil) then
					FOM_Cooking[FOM_RealmPlayer] = { };
				end
				if (FOM_Cooking ~= nil and FOM_Cooking[FOM_RealmPlayer] ~= nil and TradeSkillFrame and TradeSkillFrame:IsVisible() and not FOM_TradeSkillLock.Locked) then
					-- This prevents further update events from being handled if we're already processing one.
					-- This is done to prevent the game from freezing under certain conditions.
					FOM_TradeSkillLock.Locked = true;

					for i=1, GetNumTradeSkills() do
						local itemName, type, _, _ = GetTradeSkillInfo(i);
						if (type ~= "header") then
							for j=1, GetTradeSkillNumReagents(i) do
								local reagentLink = GetTradeSkillReagentItemLink(i, j);
								local itemID = FOM_IDFromLink(reagentLink);
								
								if (itemID and FOM_IsKnownFood(itemID)) then
									if (FOM_Cooking[FOM_RealmPlayer][itemID] == nil) then
										FOM_Cooking[FOM_RealmPlayer][itemID] = FOM_DifficultyToNum(type);
									else
										FOM_Cooking[FOM_RealmPlayer][itemID] = max(FOM_Cooking[FOM_RealmPlayer][itemID], FOM_DifficultyToNum(type));
									end
								end
							end
						end
					end
				end
			end
		end
		return;
		
	elseif (event == "PET_STABLE_SHOW" or event == "PET_STABLE_UPDATE") then
	
		-- clean up the FOM_FoodQuality sub-tables in case we missed you abandoning a pet
		FOM_CheckSetup();
		local stabledPetNames = {};
		for petIndex = 0, 2 do
			local _, petName, _, _, _ = GetStablePetInfo(petIndex);
			if (petName) then
				table.insert(stabledPetNames, petName);
			end
		end
		local orphanedPetNames = {};
		for savedPetName in FOM_FoodQuality[FOM_RealmPlayer] do
			if (stabledPetNames == nil) then
				GFWUtils.DebugLog("stabledPetNames == nil");
			end
			if (stabledPetNames ~= nil and GFWTable.IndexOf(stabledPetNames, savedPetName) == 0) then
				table.insert(orphanedPetNames, savedPetName);
			end
		end
		for _, orphanedPet in orphanedPetNames do
			FOM_FoodQuality[FOM_RealmPlayer][orphanedPet] = nil;
		end
		return;

	elseif (FOM_Config.Level) then
		FOM_CheckHappiness();
	end
	
end

-- Update our list of quest objectives so we can avoid consuming food we want to accumulate for a quest.
function FOM_ScanQuests()
	FOM_QuestFood = nil;
	for questNum=1, GetNumQuestLogEntries() do
		local QText, level, questTag, isHeader, isCollapsed, isComplete  = GetQuestLogTitle(questNum);
		if (not isHeader) then
			for objectiveNum=1, GetNumQuestLeaderBoards(questNum) do
				local text, type, finished = GetQuestLogLeaderBoard(objectiveNum, questNum);
				if (text ~= nil and strlen(text) > 0) then
					local _, _, objectiveName, numCurrent, numRequired = string.find(text, "(.*): (%d+)/(%d+)");
					if (FOM_IsKnownFood(objectiveName)) then
						if (FOM_QuestFood == nil) then
							FOM_QuestFood = { };
						end
						if (FOM_QuestFood[FOM_RealmPlayer] == nil) then
							FOM_QuestFood[FOM_RealmPlayer] = { };
						end

						if (FOM_QuestFood[FOM_RealmPlayer][objectiveName] == nil) then
							FOM_QuestFood[FOM_RealmPlayer][objectiveName] = tonumber(numRequired);
						else
							FOM_QuestFood[FOM_RealmPlayer][objectiveName] = max(FOM_QuestFood[FOM_RealmPlayer][objectiveName], tonumber(numRequired));
						end
					end
				end
			end
		end
	end
end

function FOM_DifficultyToNum(level)
	if (level == "optimal" or level == "orange") then
		return 3;
	elseif (level == "medium" or level == "yellow") then
		return 2;
	elseif (level == "easy" or level == "green") then
		return 1;
	elseif (level == "trivial" or level == "gray" or level == "grey") then
		return 1;
	else -- bad input
		return nil;
	end
end

function FOM_OnUpdate(elapsed)
	
	_, realClass = UnitClass("player");
	if (realClass ~= "HUNTER") then return; end

	-- If it's been more than a second since our last tradeskill update,
	-- we can allow the event to process again.
	FOM_TradeSkillLock.EventTimer = FOM_TradeSkillLock.EventTimer + elapsed;
	if (FOM_TradeSkillLock.Locked) then
		FOM_TradeSkillLock.EventCooldown = FOM_TradeSkillLock.EventCooldown + elapsed;
		if (FOM_TradeSkillLock.EventCooldown > FOM_TradeSkillLock.EventCooldownTime) then

			FOM_TradeSkillLock.EventCooldown = 0;
			FOM_TradeSkillLock.Locked = false;
		end
	end
		
	--GFWUtils.Debug = true;

	if (FOM_State.ShouldFeed and FOM_Config.IconWarning and PetFrameHappiness) then
		if (PetFrameHappiness:IsVisible() and PetFrameHappiness:GetAlpha() == 1) then
			FOM_FadeOut();
		end
	end
end

function FOM_FadeOut()
    local fadeInfo = {};
    fadeInfo.mode = "OUT";
    fadeInfo.timeToFade = 0.5;
    fadeInfo.finishedFunc = FOM_FadeIn;
    UIFrameFade(PetFrameHappiness, fadeInfo);
end

--hack since a frame can't have a reference to itself in it
function FOM_FadeIn()
    UIFrameFadeIn(PetFrameHappiness, 0.5);
end

function FOM_CanFeed()
	if ( not UnitExists("pet") ) then
		GFWUtils.DebugLog("Can't feed; pet doesn't exist.");
		return false;
	end
	if ( UnitHealth("pet") <= 0 ) then
		GFWUtils.DebugLog("Can't feed; pet is dead.");
		return false;
	end
	if ( UnitHealth("player") <= 0 ) then
		GFWUtils.DebugLog("Can't feed; I'm dead.");
		return false;
	end
	if ( CastingBarFrameStatusBar:IsVisible() ) then
		GFWUtils.DebugLog("Can't feed; casting a spell / tradeksill.");
		return false;
	end
	if ( UnitOnTaxi("player") ) then
		GFWUtils.DebugLog("Can't feed; flying.");
		return false;
	end
	if ( FOM_State.InCombat ) or ( PlayerFrame.inCombat ) then
		GFWUtils.DebugLog("Can't feed; in combat.");
		return false;
	end
	if ( LootFrame:IsVisible() ) then
		GFWUtils.DebugLog("Shouldn't feed; loot window is open.");
		return false;
	end
	
	
	local buff, buffIndex;
	local dontFeedBuffTextures = { 
		"Interface\\Icons\\Ability_Ambush",				-- NE Shadowmeld (maybe not unique buff icon?)
		"Interface\\Icons\\Ability_Rogue_FeignDeath",	-- Feign Death
		"Interface\\Icons\\INV_Drink_07",				-- drinking
		"Interface\\Icons\\INV_Misc_Fork&Knife",		-- eating
	};
	local mountTextureSubStrings = { 
		"Ability_Mount",
		"INV_Misc_Foot_Kodo",
	};
	for buffIndex=0, 15 do
		local buff = GetPlayerBuffTexture(buffIndex);
		if ( buff ~= nil) then
			for _, buffTexture in dontFeedBuffTextures do
				if ( buff == buffTexture ) then
					GFWUtils.DebugLog("Can't feed; currently, eating, drinking, or feigning death.");
					return false;
				end
			end
			if ( UnitLevel("player") >= 40 ) then
				for _, buffTexture in mountTextureSubStrings do
					if ( string.find(buff, buffTexture) ) then
						FOMTooltip:SetUnitBuff("player", buffIndex+1);
						local msg = FOMTooltipTextLeft1:GetText();
						if (msg ~= nil) then
							msg = string.lower(msg);
							for _, mountName in FOM_MOUNT_NAME_SUBSTRINGS do
								if (string.find(msg, mountName)) then
									GFWUtils.DebugLog("Can't feed; mounted.");
									return false;
								end
							end
						end
					end
				end
			end
		end
	end

	return true;
end

function FOM_ChatCommandHandler(msg)

	if ( msg == "" ) then
		if FOM_OptionsFrame:IsVisible() then
			HideUIPanel(FOM_OptionsFrame);
		else
			ShowUIPanel(FOM_OptionsFrame);
		end
		return;
	end
	
	-- Check for Pet (we don't really need one for most of our chat commands, but we conveniently use its name.)
	if ( UnitExists("pet") ) then
		petName = UnitName("pet");
		if (GetLocale() ~= "enUS") then
			if (FOM_LocaleInfo == nil) then
				FOM_LocaleInfo = {};
			end
			FOM_LocaleInfo[UnitCreatureFamily("pet")] = {GetPetFoodTypes()};
		end
	else
		petName = "Your pet";
	end
	
	-- Print Help
	if ( msg == "help" ) or ( msg == "" ) then
		GFWUtils.Print("Fizzwidget Feed-O-Matic "..FOM_VERSION..":");
		GFWUtils.Print("/feedomatic /fom <command>");
		GFWUtils.Print("- "..GFWUtils.Hilite("help").." - Print this helplist.");
		GFWUtils.Print("- "..GFWUtils.Hilite("status").." - Check current settings.");
		GFWUtils.Print("- "..GFWUtils.Hilite("reset").." - Reset to default settings.");
		GFWUtils.Print("- "..GFWUtils.Hilite("alert chat").." | "..GFWUtils.Hilite("emote").." | "..GFWUtils.Hilite("off").." - Alert via chat window or emote channel when feeding.");
		GFWUtils.Print("- "..GFWUtils.Hilite("level content").." | "..GFWUtils.Hilite("happy").." | "..GFWUtils.Hilite("off").." - Provide an extra reminder to feed your pet when happiness is below this level.");
		GFWUtils.Print("- "..GFWUtils.Hilite("saveforcook orange").." | "..GFWUtils.Hilite("yellow").." | "..GFWUtils.Hilite("green").." | "..GFWUtils.Hilite("gray").." | "..GFWUtils.Hilite("off").." - Avoid foods used in cooking recipes (based on their difficulty).");
		GFWUtils.Print("- "..GFWUtils.Hilite("savequest on").." | "..GFWUtils.Hilite("off").." - Avoid foods you need to collect for a quest.");
		GFWUtils.Print("- "..GFWUtils.Hilite("savebonus on").." | "..GFWUtils.Hilite("off").." - Avoid foods which have bonus effects.");
		GFWUtils.Print("- "..GFWUtils.Hilite("fallback on").." | "..GFWUtils.Hilite("off").." - Fall back to foods we'd normally avoid if no other food is available.");
		GFWUtils.Print("- "..GFWUtils.Hilite("keepopen <number>").." - Set when to prefer smaller stacks of food versus evaluating food based on quality. Specify "..GFWUtils.Hilite("off").." instead of a number to always select foods by quality, or "..GFWUtils.Hilite("max").." to always prefer smaller stacks.");
		GFWUtils.Print("- "..GFWUtils.Hilite("quality high").." | "..GFWUtils.Hilite("low").." - Set whether to prefer foods that give your pet more happiness faster or less happiness more slowly.");
		GFWUtils.Print("- "..GFWUtils.Hilite("tooltip on").." | "..GFWUtils.Hilite("off").." - Identifies and rates pet foods in their tooltips.");
		GFWUtils.Print("- "..GFWUtils.Hilite("feed").." - Feed your pet (automatically finds an appropriate food).");
		GFWUtils.Print("- "..GFWUtils.Hilite("feed <name>").." - Feed your pet a specific food.");
		GFWUtils.Print("- "..GFWUtils.Hilite("add <diet> <name>").." - Add food to list.");
		GFWUtils.Print("- "..GFWUtils.Hilite("remove <diet> <name>").." - Remove food from list.");
		GFWUtils.Print("- "..GFWUtils.Hilite("show <diet>").." - Show food list.");
		return;
	end

	if ( msg == "version" ) then
		GFWUtils.Print("Fizzwidget Feed-O-Matic "..FOM_VERSION..":");
		return;
	end
		
	-- Check Status
	if ( msg == "status" ) then
		if (FOM_Config.Level) then
			GFWUtils.Print("Feed-O-Matic will help remind you to feed your pet when he's "..GFWUtils.Hilite(FOM_Config.Level)..".");
		else
			GFWUtils.Print("Feed-O-Matic will "..GFWUtils.Hilite("not").." help remind you when to feed your pet.");
		end

		if (FOM_Config.KeepOpenSlots < MAX_KEEPOPEN_SLOTS) then
		
			if (FOM_Config.PreferHigherQuality) then
				GFWUtils.Print("Feed-O-Matic will prefer to use higher quality foods first.");
			else
				GFWUtils.Print("Feed-O-Matic will prefer to use lower quality foods first.");
			end
			
			if (FOM_Config.KeepOpenSlots == 0) then
				GFWUtils.Print("Feed-O-Matic will look first at food quality when determining what to feed to your pet.");
			else
				GFWUtils.Print("If fewer than "..GFWUtils.Hilite(FOM_Config.KeepOpenSlots).." spaces are open in your inventory, Feed-O-Matic will prefer smaller stacks of food regardless of quality.");
			end
			
		else
			GFWUtils.Print("Feed-O-Matic will always prefer smaller stacks of food regardless of quality.");
		end
		
		if (FOM_Config.Alert == "emote") then
			GFWUtils.Print("You will automatically emote when feeding "..petName..".");
		elseif (FOM_Config.Alert == "chat") then
			GFWUtils.Print("Feed-O-Matic will notify you in chat when feeding "..petName..".");
		else
			GFWUtils.Print("There will be no alert when feeding "..petName..".");
		end
				
		if (FOM_Config.SaveForCookingLevel >= 0 and FOM_Config.SaveForCookingLevel <= 3) then
			if (FOM_Config.SaveForCookingLevel == 3) then
				level = "orange";
			elseif (FOM_Config.SaveForCookingLevel == 2) then
				level = "yellow";
			elseif (FOM_Config.SaveForCookingLevel == 1) then
				level = "green";
			elseif (FOM_Config.SaveForCookingLevel == 0) then
				level = "gray";
			end
			GFWUtils.Print("Feed-O-Matic will avoid foods used in "..GFWUtils.Hilite(level).." or higher Cooking recipes.");
		else
			GFWUtils.Print("Feed-O-Matic will choose foods without regard to whether they're used in Cooking.");
		end
		
		if (FOM_Config.AvoidQuestFood) then
			GFWUtils.Print("Feed-O-Matic will avoid foods you need to collect for quests.");
		else
			GFWUtils.Print("Feed-O-Matic will choose foods without regard to whether they're needed for quests.");
		end
		if (FOM_Config.AvoidBonusFood) then
			GFWUtils.Print("Feed-O-Matic will avoid foods that have an additional bonus effect when eaten by a player.");
		else
			GFWUtils.Print("Feed-O-Matic will choose foods without regard to whether they have bonus effects.");
		end
		if (FOM_Config.Fallback) then
			GFWUtils.Print("Feed-O-Matic will fall back to food it would otherwise avoid if no other food is available.");
		else
			GFWUtils.Print("Feed-O-Matic will not feed your pet if the only foods available are foods you'd prefer to avoid feeding.");
		end
		if (FOM_Config.Tooltip) then
			GFWUtils.Print("Adding food quality information to tooltips for foods your current pet can eat.");
		else
			GFWUtils.Print("Not adding information to item tooltips.");
		end
		return;
	end

	-- Reset Variables
	if ( msg == "reset" ) then
		FOM_Config = FOM_Config_Default;
		FOM_Cooking = nil;
		FOM_FoodQuality = nil;
		FOM_AddedFoods = nil;
		FOM_RemovedFoods = nil;
		FOM_QuestFood = nil;
		GFWUtils.Print("Feed-O-Matic configuration reset.");
		FOM_ChatCommandHandler("status");
		return;
	end
	
	-- Turn automatic feeding On
	if ( msg == "on" ) then
		GFWUtils.Print("Automatic feeding is no longer available due to changes in the WoW client as of Patch 1.10.");		
		return;
	end

	local _, _, cmd, option = string.find(msg, "(%w+) (%w+)");

	-- Toggle Alert
	if ( cmd == "alert" ) then
		
		if (option == "emote") then
			FOM_Config.Alert = "emote";
			GFWUtils.Print("You will automatically emote when feeding "..petName..".");
		elseif (option == "chat") then
			FOM_Config.Alert = "chat";
			GFWUtils.Print("Feed-O-Matic will notify you in chat when feeding "..petName..".");
		elseif (option == "off") then
			FOM_Config.Alert = nil;
			GFWUtils.Print("There will be no alert when feeding "..petName..".");
		else
			GFWUtils.Print("Usage: "..GFWUtils.Hilite("/feedomatic alert chat").." | "..GFWUtils.Hilite("emote").." | "..GFWUtils.Hilite("off"));
		end
		return;
	end
	
	-- Set Happiness Level
	if ( cmd == "level" ) then
		if ( option == "content" ) then
			FOM_Config.Level = "content";
		elseif ( option == "happy" ) then
			FOM_Config.Level = "happy";
		elseif ( option == "debug" ) then
			FOM_Config.Level = "debug";
		else
			FOM_Config.Level = nil;
		end
		if (FOM_Config.Level) then
			GFWUtils.Print("Feed-O-Matic will help remind you to feed your pet when he's less than "..GFWUtils.Hilite(FOM_Config.Level)..".");
			FOM_CheckHappiness();
		else
			GFWUtils.Print("Feed-O-Matic will "..GFWUtils.Hilite("not").." help remind you when to feed your pet.");
			FOM_Status.ShouldFeed = nil;
		end
		return;
	end
	
	-- Set Cooking recipe level
	if ( cmd == "saveforcook" ) then
		local level = option;
		if (level ~= nil) then
			local levelNum = FOM_DifficultyToNum(level);
			if (levelNum ~= nil) then 
				FOM_Config.SaveForCookingLevel = levelNum;
				FOM_Config.AvoidUsefulFood = true;
				GFWUtils.Print("Feed-O-Matic will avoid foods used in "..GFWUtils.Hilite(level).." or higher Cooking recipes. You'll need to open your Cooking window for Feed-O-Matic to cache information about what recipes you know.");
				return;
			elseif (level == "off") then
				FOM_Config.SaveForCookingLevel = 4; 
				if (not FOM_Config.AvoidQuestFood and not FOM_Config.Avoid9) then
					FOM_Config.AvoidUsefulFood = false;
				end
				GFWUtils.Print("Feed-O-Matic will choose foods without regard to whether they're used in Cooking.");
				return;
			end
		end
		GFWUtils.Print("Usage: "..GFWUtils.Hilite("/feedomatic saveforcook orange").." | "..GFWUtils.Hilite("yellow").." | "..GFWUtils.Hilite("green").." | "..GFWUtils.Hilite("gray").." | "..GFWUtils.Hilite("off"));
		return;
	end
	
	-- Set avoiding food with bonuses
	if ( cmd == "savequest" ) then
		if (option == "on") then
			FOM_Config.AvoidQuestFood = true;
			FOM_Config.AvoidUsefulFood = true;
			FOM_ScanQuests();
			GFWUtils.Print("Feed-O-Matic will avoid foods you need to collect for quests.");
		elseif (option == "off") then
			FOM_Config.AvoidQuestFood = true;
			if not (FOM_Config.SaveForCookingLevel >= 0 and FOM_Config.SaveForCookingLevel <= 3 and not FOM_Config.AvoidBonusFood) then
				FOM_Config.AvoidUsefulFood = false;
			end
			GFWUtils.Print("Feed-O-Matic will choose foods without regard to whether they're needed for quests.");
		else
			GFWUtils.Print("Usage: "..GFWUtils.Hilite("/feedomatic savequest on").." | "..GFWUtils.Hilite("off"));
		end
		return;
	end
	
	-- Set avoiding quest-objective food
	if ( cmd == "savebonus" ) then
		if (option == "on") then
			FOM_Config.AvoidBonusFood = true;
			FOM_Config.AvoidUsefulFood = true;
			GFWUtils.Print("Feed-O-Matic will avoid foods that have an additional bonus effect when eaten by a player.");
		elseif (option == "off") then
			FOM_Config.AvoidBonusFood = true;
			if not (FOM_Config.SaveForCookingLevel >= 0 and FOM_Config.SaveForCookingLevel <= 3 and not FOM_Config.AvoidQuestFood) then
				FOM_Config.AvoidUsefulFood = false;
			end
			GFWUtils.Print("Feed-O-Matic will choose foods without regard to whether they have bonus effects.");
		else
			GFWUtils.Print("Usage: "..GFWUtils.Hilite("/feedomatic savebonus on").." | "..GFWUtils.Hilite("off"));
		end
		return;
	end
	
	if ( cmd == "fallback" ) then
		if (option == "on") then
			FOM_Config.Fallback = true;
			GFWUtils.Print("Feed-O-Matic will fall back to food it would otherwise avoid if no other food is available.");
		elseif (option == "off") then
			FOM_Config.Fallback = false;
			GFWUtils.Print("Feed-O-Matic will not feed your pet if the only foods available are foods you'd prefer to avoid feeding.");
		else
			GFWUtils.Print("Usage: "..GFWUtils.Hilite("/feedomatic fallback on").." | "..GFWUtils.Hilite("off"));
		end
		return;
	end
	
	if ( cmd == "tooltip" ) then
		if (option == "on") then
			FOM_Config.Tooltip = true;
			GFWTooltip_AddCallback("GFW_FeedOMatic", FOM_Tooltip);
			GFWUtils.Print("Adding food quality information to tooltips for foods your current pet can eat.");
		elseif (option == "off") then
			FOM_Config.Tooltip = false;
			GFWUtils.Print("Not adding information to item tooltips.");
		else
			GFWUtils.Print("Usage: "..GFWUtils.Hilite("/feedomatic tooltip on").." | "..GFWUtils.Hilite("off"));
		end
		return;
	end
	
	-- Set quality sorting direction
	if ( cmd == "quality" ) then
		if (option == "high") then
			FOM_Config.PreferHigherQuality = true;
			GFWUtils.Print("Feed-O-Matic will prefer to use higher quality foods first.");
		elseif (option == "low") then
			FOM_Config.PreferHigherQuality = false;
			GFWUtils.Print("Feed-O-Matic will prefer to use lower quality foods first.");
		else
			GFWUtils.Print("Usage: "..GFWUtils.Hilite("/feedomatic quality high").." | "..GFWUtils.Hilite("low"));
		end
		return;
	end

	-- Set inventory management threshold
	if ( cmd == "keepopen" ) then
		if (option == "off" or option == "none") then
			newNum = 0;
		elseif (option == "max") then
			newNum = MAX_KEEPOPEN_SLOTS;
		else
			newNum = tonumber(option);
		end
		if (newNum == nil) then
			GFWUtils.Print("Usage: "..GFWUtils.Hilite("/feedomatic keepopen <number>"));
			return;
		end
		FOM_Config.KeepOpenSlots = newNum;
		GFWUtils.Print("Feed-O-Matic will try to keep at least "..GFWUtils.Hilite(FOM_Config.KeepOpenSlots).." spaces open in your inventory when looking for food.");
		return;
	end
	
	-- Feed Pet
	local _, _, cmd, foodString = string.find(msg, "(%w+) *(.*)");
	if ( cmd == "feed" ) then
		if (foodString == "") then
			FOM_Feed(nil); -- automatically find a food and feed it
		else
			local inputFoods = { };
			for itemLink in string.gfind(foodString, "%[[%w%s:()\"'-]+%]") do
				local _, _, foodName = string.find(itemLink, "^%[([%w%s:()\"'-]+)%]$"); 
				table.insert(inputFoods, foodName);
			end
			if (table.getn(inputFoods) == 0) then
				table.insert(inputFoods, foodString); -- if no item links, treat whole input line as one food's name
			end
			
			for _, food in inputFoods do
				FOM_Feed(food);
			end
		end
		return;
	end
	
	local _, _, cmd, diet, foodString = string.find(msg, "(%w+) (%w+) *(.*)");
	if ( cmd == "add" or cmd == "remove" or cmd == "show" or cmd == "list" ) then
	
		diet = string.lower(diet); -- let's be case insensitive
		if ( FOM_Foods[diet] == nil and diet ~= FOM_DIET_ALL) then
			local usageString = "Usage: "..GFWUtils.Hilite("/feedomatic "..cmd..FOM_DIET_MEAT).." | "..GFWUtils.Hilite(FOM_DIET_FISH).." | "..GFWUtils.Hilite(FOM_DIET_BREAD).." | "..GFWUtils.Hilite(FOM_DIET_CHEESE).." | "..GFWUtils.Hilite(FOM_DIET_FRUIT).." | "..GFWUtils.Hilite(FOM_DIET_FUNGUS).." | "..GFWUtils.Hilite(FOM_DIET_BONUS)
			if (cmd ~= "show" and cmd ~= "list") then
				usageString = usageString.." <item link>.";
			end
			GFWUtils.Print(usageString);
			return;
		end

		if (cmd == "show" or cmd == "list") then
			if ( diet == FOM_DIET_ALL ) then
				diets = {FOM_DIET_MEAT, FOM_DIET_FISH, FOM_DIET_BREAD, FOM_DIET_CHEESE, FOM_DIET_FRUIT, FOM_DIET_FUNGUS, FOM_DIET_BONUS};
			else
				diets = {diet};
			end
			
			for _, aDiet in diets do
				local capDiet = string.upper(string.sub(aDiet, 1, 1)) .. string.sub(aDiet, 2); -- print a nicely capitalized version
				GFWUtils.Print("Feed-O-Matic "..GFWUtils.Hilite(capDiet).." List:");
				local dietFoods = FOM_Foods[aDiet];
				if (FOM_AddedFoods ~= nil and FOM_AddedFoods[aDiet] ~= nil) then
					dietFoods = GFWTable.Merge(dietFoods, FOM_AddedFoods[aDiet]);
				end
				if (FOM_RemovedFoods ~= nil and FOM_RemovedFoods[aDiet] ~= nil) then
					dietFoods = GFWTable.Subtract(dietFoods, FOM_RemovedFoods[aDiet]);
				end
				table.sort(dietFoods);
				for _, food in dietFoods do
					local foodName = GetItemInfo(food);
					if (foodName) then
						if (FOM_FoodIDsToNames == nil) then
							FOM_FoodIDsToNames = {};
						end
						FOM_FoodIDsToNames[food] = foodName;
						GFWUtils.Print(GFWUtils.Hilite(" - ")..foodName);
					else
						GFWUtils.Print(GFWUtils.Hilite(" - ").."item id "..food.." (name not available)");
					end
				end
			end
			return;
		else
		
			local inputFoods = { };
			for itemLink in string.gfind(foodString, "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[.-%]|h|r") do
				table.insert(inputFoods, itemLink);
				local foodID = FOM_IDFromLink(itemLink);
				if (foodID) then
					local foodName = FOM_NameFromLink(itemLink);
					if (FOM_FoodIDsToNames == nil) then
						FOM_FoodIDsToNames = {};
					end
					FOM_FoodIDsToNames[foodID] = foodName;
				end
			end
			if (table.getn(inputFoods) == 0) then
				GFWUtils.Print("The "..GFWUtils.Hilite("/fom "..cmd).." command requires an item link; shift-click an item to insert a link.");
				return;
			end

			local capDiet = string.upper(string.sub(diet, 1, 1)) .. string.sub(diet, 2); -- print a nicely capitalized version
			if ( cmd == "add" ) then
				for _, food in inputFoods do
					local foodID = FOM_IDFromLink(food);
					if ( FOM_AddFood(diet, tonumber(foodID)) ) then
						GFWUtils.Print("Added "..food.." to "..GFWUtils.Hilite(capDiet).." list.");
					else
						GFWUtils.Print(food.." already in "..GFWUtils.Hilite(capDiet).." list.");
					end
				end
				if (FOM_Config.AvoidQuestFood) then
					FOM_ScanQuests(); -- in case any of the newly added foods are quest objectives
				end
				return;
			elseif (cmd == "remove" ) then
				for _, food in inputFoods do
					local foodID = FOM_IDFromLink(food);
					if ( FOM_RemoveFood(diet, tonumber(foodID)) ) then
						GFWUtils.Print("Removed "..food.." from "..GFWUtils.Hilite(capDiet).." list.");
					else
						GFWUtils.Print("Could not find "..food.." in "..GFWUtils.Hilite(capDiet).." list.");
					end
				end
				return;
			end
		end
	end
	
	-- if we got down to here, we got bad input
	FOM_ChatCommandHandler("help");
end

-- Add a food to a list
function FOM_AddFood(diet, food)

	if (FOM_Foods[diet] == nil) then
		GFWUtils.DebugLog("FOM_Foods[diet] == nil");
	end
	if (FOM_AddedFoods == nil or FOM_AddedFoods[diet] == nil) then
		GFWUtils.DebugLog("FOM_AddedFoods == nil or FOM_AddedFoods[diet] == nil");
	end
	if (FOM_RemovedFoods == nil or FOM_RemovedFoods[diet] == nil) then
		GFWUtils.DebugLog("FOM_RemovedFoods == nil or FOM_RemovedFoods[diet] == nil");
	end
	if ( GFWTable.IndexOf(FOM_Foods[diet], food) == 0 ) then
		if (FOM_AddedFoods == nil) then
			FOM_AddedFoods = {};
		end
		if (FOM_AddedFoods[diet] == nil) then
			FOM_AddedFoods[diet] = {};
		end
		if ( GFWTable.IndexOf(FOM_AddedFoods[diet], food) == 0 ) then
			table.insert( FOM_AddedFoods[diet], food );
			table.sort( FOM_AddedFoods[diet] );
			if (FOM_RemovedFoods and FOM_RemovedFoods[diet] and GFWTable.IndexOf(FOM_RemovedFoods[diet], food) ~= 0) then
				table.remove( FOM_RemovedFoods[diet], GFWTable.IndexOf(FOM_RemovedFoods[diet], food) );
				table.sort( FOM_RemovedFoods[diet] );
			end
			return true;
		else
			return false;
		end
	else
		return false;
	end

end

-- Remove a food from a list
function FOM_RemoveFood(diet, food)
	
	if (FOM_Foods[diet] == nil) then
		GFWUtils.DebugLog("FOM_Foods[diet] == nil");
	end
	if (FOM_AddedFoods == nil or FOM_AddedFoods[diet] == nil) then
		GFWUtils.DebugLog("FOM_AddedFoods == nil or FOM_AddedFoods[diet] == nil");
	end
	if (FOM_RemovedFoods == nil or FOM_RemovedFoods[diet] == nil) then
		GFWUtils.DebugLog("FOM_RemovedFoods == nil or FOM_RemovedFoods[diet] == nil");
	end
	if ( GFWTable.IndexOf(FOM_Foods[diet], food) ~= 0 ) then
		if (FOM_RemovedFoods == nil) then
			FOM_RemovedFoods = {};
		end
		if (FOM_RemovedFoods[diet] == nil) then
			FOM_RemovedFoods[diet] = {};
		end
		if ( GFWTable.IndexOf(FOM_RemovedFoods[diet], food) == 0 ) then
			table.insert( FOM_RemovedFoods[diet], food );
			table.sort( FOM_RemovedFoods[diet] );
			if (FOM_AddedFoods and FOM_AddedFoods[diet] and GFWTable.IndexOf(FOM_AddedFoods[diet], food) ~= 0) then
				table.remove( FOM_AddedFoods[diet], GFWTable.IndexOf(FOM_AddedFoods[diet], food) );
				table.sort( FOM_AddedFoods[diet] );
			end
			return true;
		else
			return false;
		end
	else
		if (FOM_AddedFoods and FOM_AddedFoods[diet] and GFWTable.IndexOf(FOM_AddedFoods[diet], food) ~= 0) then
			table.remove( FOM_AddedFoods[diet], GFWTable.IndexOf(FOM_AddedFoods[diet], food) );
			table.sort( FOM_AddedFoods[diet] );
			return true;
		end
		return false;
	end

end

function FOM_IsBGActive()
	local bgNum = 1;
	local status;
	repeat
		status = GetBattlefieldStatus(bgNum);
		if (status == "active") then 
			return true;
		end
		bgNum = bgNum + 1;
	until (status == nil)
	return false;
end
-- Check Happiness
function FOM_CheckHappiness()

	-- Check for pet
	if not ( UnitExists("pet") ) then 
		FOM_State.ShouldFeed = nil;		
		return;
	end
		
	-- Get Pet Info
	local pet = UnitName("pet");
	local happiness, damage, loyalty = GetPetHappiness();
	
	-- Check No Happiness
	if ( happiness == 0 ) or ( happiness == nil ) then return; end
	
	local level;
	if ( FOM_Config.Level == "unhappy" ) then
		level = 1;
	elseif ( FOM_Config.Level == "content" ) then
		level = 2;
	elseif ( FOM_Config.Level == "happy" ) then
		level = 3;
	elseif ( FOM_Config.Level == "debug" ) then
		level = 4;
	else
		level = 0;
	end
	
	-- Check if Need Feeding
	if ( happiness < level + 1 ) then
		FOM_State.ShouldFeed = true;
		if (not FOM_HasFeedEffect() and GetTime() - FOM_LastWarning > FOM_WARNING_INTERVAL) then
			if (FOM_Config.TextWarning) then
				local msg;
				if (level - happiness == 0) then
					msg = FOM_PET_HUNGRY;
				else
					msg = FOM_PET_VERY_HUNGRY;
				end
				GFWUtils.Print(string.format(msg, pet));
				GFWUtils.Note(string.format(msg, pet));
			end
			FOM_PlayHungrySound();
			FOM_LastWarning = GetTime();
		end
	else
		FOM_State.ShouldFeed = nil;
	end
	
end

FOM_HungrySounds = {
  	[BAT]		    = "Sound\\Creature\\FelBat\\FelBatDeath.wav",
  	[BEAR]		    = "Sound\\Creature\\Bear\\mBearDeathA.wav",
  	[BOAR]		    = "Sound\\Creature\\Boar\\mWildBoarAggro2.wav",
  	[CAT]		    = "Sound\\Creature\\Tiger\\mTigerStand2A.wav",
  	[CARRION_BIRD]	= "Sound\\Creature\\Carrion\\mCarrionWoundCriticalA.wav",
  	[CRAB]		    = "Sound\\Creature\\Crab\\CrabDeathA.wav",
  	[CROCOLISK]	    = "Sound\\Creature\\Basilisk\\mBasiliskSpellCastA.wav",
  	[GORILLA]	    = "Sound\\Creature\\Gorilla\\GorillaDeathA.wav",
  	[HYENA]		    = "Sound\\Creature\\Hyena\\HyenaPreAggroA.wav",
  	[OWL]		    = "Sound\\Creature\\OWl\\OwlPreAggro.wav",
  	[RAPTOR]	    = "Sound\\Creature\\Raptor\\mRaptorWoundCriticalA.wav",
  	[SCORPID]	    = "Sound\\Creature\\SilithidWasp\\mSilithidWaspStand2A.wav",
  	[SPIDER]	    = "Sound\\Creature\\Tarantula\\mTarantulaFidget2a.wav",
  	[TALLSTRIDER]   = "Sound\\Creature\\TallStrider\\tallStriderPreAggroA.wav",
  	[TURTLE]	    = "Sound\\Creature\\SeaTurtle\\SeaTurtleWoundCritA.wav",
  	[WIND_SERPENT]	= "Sound\\Creature\\WindSerpant\\mWindSerpantDeathA.wav",
  	[WOLF]		    = "Sound\\Creature\\Wolf\\mWolfFidget2c.wav",
};
function FOM_PlayHungrySound()
	if (FOM_Config.AudioWarning) then
		local type = UnitCreatureFamily("pet");
		local sound = FOM_HungrySounds[type];
		if (sound == nil or FOM_Config.AudioWarning == "bell") then
			PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
		else
			PlaySoundFile(sound);
		end
	end
end

-- Check Feed Effect
function FOM_HasFeedEffect()

	local i = 1;
	local buff;
	buff = UnitBuff("pet", i);
	while buff do
		if ( string.find(buff, "Ability_Hunter_BeastTraining") ) then
			return true;
		end
		i = i + 1;
		buff = UnitBuff("pet", i);
	end
	return false;

end

-- Feed Pet
function FOM_Feed(aFood)
	
	FOM_State.ShouldFeed = false;
	
	-- Make sure we have a feedable pet
	if not (UnitExists("pet")) then 
		GFWUtils.Note(FOM_ERROR_NO_PET); 
		return;
	end
	if (UnitIsDead("pet")) then
		GFWUtils.Note(FOM_ERROR_PET_DEAD); 
		return;
	end
	if (GetPetFoodTypes() == nil) then
		GFWUtils.Note(FOM_ERROR_NO_FEEDABLE_PET); 
		return;
	end
	
	-- Assign Variable
	local pet = UnitName("pet");
	
	FOM_CheckSetup();
	if (FOM_LastPetName == nil or FOM_LastPetName == "") then
		GFWUtils.DebugLog("Can't get pet info.");
		return;
	end

	if (GetLocale() ~= "enUS") then
		if (FOM_LocaleInfo == nil) then
			FOM_LocaleInfo = {};
		end
		FOM_LocaleInfo[UnitCreatureFamily("pet")] = {GetPetFoodTypes()};
	end
	
	-- Look for Food
	local foodBag, foodItem;
	if (aFood ~= nil) then
		-- if told to feed a specific food, do so
		foodBag, foodItem = FOM_FindSpecificFood(aFood);
		if ( foodBag == nil) then
			-- No Food Could be Found
			GFWUtils.Print(string.format(FOM_ERROR_FOOD_NOT_FOUND, pet, aFood));
			return;
		end
	else
		foodBag, foodItem = FOM_NewFindFood();
	end
	
	if ( foodBag == nil) then
		-- No Food Could be Found
		GFWUtils.Print(string.format(FOM_ERROR_NO_FOOD, pet));
		return;
	end
		
	FOM_LastFood = GetContainerItemLink(foodBag, foodItem);
	
	GFWUtils.DebugLog("Picked "..FOM_LastFood.." (bag "..foodBag..", slot "..foodItem..") for feeding.");
	if (FOM_Config.Debug) then
		-- don't actually feed anything, just show what we would choose
		return;
	end
	
	-- Actually feed the item to the pet
	PickupContainerItem(foodBag, foodItem);
	if ( CursorHasItem() ) then
		DropItemOnUnit("pet");
	end
	if ( CursorHasItem() ) then
		PickupContainerItem(foodBag, foodItem);
	else
		FOM_State.ShouldFeed = nil;
		-- Alert
		if ( FOM_Config.Alert == "chat") then
			GFWUtils.Print(string.format(FOM_FEEDING_EAT, pet, GFWUtils.Hilite(FOM_LastFood)));
		elseif ( FOM_Config.Alert == "emote") then
			SendChatMessage(string.format(FOM_FEEDING_FEED, pet, FOM_LastFood).. FOM_RandomEmote(), "EMOTE");
		end
	end
		
end

function FOM_RandomEmote()
	
	local randomEmotes = {};
	if (UnitSex("pet") == 2) then
		randomEmotes = GFWTable.Merge(randomEmotes, FOM_Emotes["male"]);
	elseif (UnitSex("pet") == 3) then
		randomEmotes = GFWTable.Merge(randomEmotes, FOM_Emotes["female"]);
	end
	
	randomEmotes = GFWTable.Merge(randomEmotes, FOM_Emotes[UnitCreatureFamily("pet")]);
	randomEmotes = GFWTable.Merge(randomEmotes, FOM_Emotes[FOM_NameFromLink(FOM_LastFood)]);
	randomEmotes = GFWTable.Merge(randomEmotes, FOM_Emotes["any"]);
	
	return randomEmotes[math.random(table.getn(randomEmotes))];

end

function FOM_FindSpecificFood(foodName)
	for bagNum = 0, 4 do
		if (not FOM_BagIsQuiver(bagNum) ) then
		-- skip bags that can't contain food
		
			local bagSize = GetContainerNumSlots(bagNum);
			for itemNum = 1, bagSize do
		
				itemName = FOM_GetItemName(bagNum, itemNum);
				if ( itemName == foodName ) then
					return bagNum, itemNum;
				end
			
			end
		end
	end
	return nil;
end

function FOM_IsTemporaryFood(itemLink)
	
	local _, _, link = string.find(itemLink, "(item:%d+:%d+:%d+:%d+)");
	if (link == nil or link == "") then 
		return false; 
	end
	FOMTooltip:ClearLines();
	FOMTooltip:SetHyperlink(link);
	if (FOMTooltipTextLeft2:GetText() == ITEM_CONJURED) then
		return true;
	else
		return false;
	end	

end

function FOM_FlatFoodList()
	local foodList = {};
	FOM_Quantity = { };
	for bagNum = 0, 4 do
		if (not FOM_BagIsQuiver(bagNum) ) then
		-- skip bags that can't contain food
			for itemNum = 1, GetContainerNumSlots(bagNum) do
				local itemLink = GetContainerItemLink(bagNum, itemNum);
				if (itemLink) then
					local itemID = FOM_IDFromLink(itemLink);
					local _, itemCount = GetContainerItemInfo(bagNum, itemNum);
					if ( FOM_IsInDiet(itemID) ) then
						if (FOM_FoodIDsToNames == nil) then
							FOM_FoodIDsToNames = {};
						end
						local name = FOM_NameFromLink(itemLink);
						FOM_FoodIDsToNames[itemID] = name;
						local isUseful = FOM_IsUsefulFood(itemID, itemCount);
						foodQuality = (FOM_FoodQuality[FOM_RealmPlayer][FOM_LastPetName][itemID] or MAX_QUALITY);
						if (foodQuality > 0) then
							table.insert(foodList, {bag=bagNum, slot=itemNum, link=itemLink, count=itemCount, quality=foodQuality, useful=isUseful, temp=FOM_IsTemporaryFood(itemLink)});
						end
					end
				end
			end
		end
	end
	return foodList;
end

function FOM_NewFindFood()
	FlatFoodList = FOM_FlatFoodList();
	
	table.sort(FlatFoodList, FOM_SortCount); -- small stacks first
	if (FOM_NumOpenBagSlots() > FOM_Config.KeepOpenSlots) then
		if (FOM_Config.PreferHigherQuality) then
			table.sort(FlatFoodList, FOM_SortQualityDescending); -- higher quality first
		else
			table.sort(FlatFoodList, FOM_SortQualityAscending); -- lower quality first
		end
	end
	table.sort(FlatFoodList, FOM_SortTemporary); -- temporary foods first
	if (FOM_Config.AvoidUsefulFood) then
		table.sort(FlatFoodList, FOM_SortUseful); -- non-useful foods first
	end
		
	for _, foodInfo in FlatFoodList do
		if (foodInfo.useful and FOM_Config.AvoidUsefulFood and not FOM_Config.Fallback) then
			GFWUtils.DebugLog("Skipping "..foodInfo.count.."x "..foodInfo.link.."; no falling back to avoided foods.");
		else
			return foodInfo.bag, foodInfo.slot;
		end
	end
	
	return nil;
end

function FOM_SortTemporary(a, b)
	if (a.temp) then
		aTemp = 1;
	else
		aTemp = 0;
	end
	if (b.temp) then
		bTemp = 1;
	else
		bTemp = 0;
	end
	return aTemp > bTemp;
end

function FOM_SortCount(a, b)
	return a.count < b.count;
end

function FOM_SortUseful(a, b)
	if (a.useful) then
		aUseful = 1;
	else
		aUseful = 0;
	end
	if (b.useful) then
		bUseful = 1;
	else
		bUseful = 0;
	end
	return aUseful < bUseful;
end

function FOM_SortQualityDescending(a, b)
	return a.quality > b.quality;
end

function FOM_SortQualityAscending(a, b)
	return a.quality < b.quality;
end

function FOM_IsUsefulFood(itemID, quantity)
	local foodName = GetItemInfo(itemID);
	if (foodName == nil) then
		GFWUtils.DebugLog("Can't get info for item ID "..itemID..", assuming it's OK to eat.");
		return false;
	end
	if (FOM_Cooking and FOM_Cooking[FOM_RealmPlayer] and FOM_Cooking[FOM_RealmPlayer][itemID]) then
		if (FOM_Cooking[FOM_RealmPlayer][itemID] >= FOM_Config.SaveForCookingLevel) then
			GFWUtils.DebugLog("Skipping "..quantity.."x "..foodName.."; is good for cooking.");
			return true;
		end
	end
	if (FOM_Config.AvoidQuestFood) then
		FOM_ScanQuests();
		if (FOM_QuestFood ~= nil and FOM_QuestFood[FOM_RealmPlayer] ~= nil and FOM_QuestFood[FOM_RealmPlayer][foodName]) then
			if (FOM_Quantity[foodName] == nil) then
				FOM_Quantity[foodName] = quantity;
			else
				FOM_Quantity[foodName] = FOM_Quantity[foodName] + quantity;
			end
			if (FOM_Quantity[foodName] > FOM_QuestFood[FOM_RealmPlayer][foodName]) then
				GFWUtils.DebugLog("Not skipping "..quantity.."x "..foodName.."; is needed for quest, but we have more than enough.");
				return false;
			else
				GFWUtils.DebugLog("Skipping "..quantity.."x "..foodName.."; is needed for quest.");
				return true;
			end
		end
	end
	if (FOM_Config.AvoidBonusFood and FOM_IsInDiet(itemID, FOM_DIET_BONUS)) then
		GFWUtils.DebugLog("Skipping "..quantity.."x "..foodName.."; has bonus effect when eaten by player.");
		return true;
	end
	--GFWUtils.DebugLog("Not skipping "..quantity.."x "..foodName.."; doesn't have other uses.");
	return false;
end

function FOM_NumOpenBagSlots()
	local openSlots = 0;
	for bagNum = 0, 4 do
		if (not FOM_BagIsQuiver(bagNum) ) then
		-- skip bags that can't contain food

			local bagSize = GetContainerNumSlots(bagNum);
			for itemNum = 1, bagSize do
				if (GetContainerItemInfo(bagNum, itemNum) == nil) then
					openSlots = openSlots + 1;
				end
			end
		end
	end
	return openSlots;
end

function FOM_IsInDiet(food, dietList)

	if ( dietList == nil ) then
		dietList = {GetPetFoodTypes()};
	end
	if ( dietList == nil ) then
		return false;
	end
	if (type(dietList) ~= "table") then
		dietList = {dietList};
	end
	for _, diet in dietList do 
		diet = string.lower(diet); -- let's be case insensitive
		if (FOM_Foods[diet] == nil) then
			GFWUtils.DebugLog("FOM_Foods[diet] == nil");
		end
		if (FOM_RemovedFoods ~= nil and FOM_RemovedFoods[diet] ~= nil and GFWTable.IndexOf(FOM_RemovedFoods[diet], food) ~= 0) then
			return false;
		end
		if (FOM_AddedFoods ~= nil and FOM_AddedFoods[diet] ~= nil and GFWTable.IndexOf(FOM_AddedFoods[diet], food) ~= 0) then
			return true;
		end
		if (GFWTable.IndexOf(FOM_Foods[diet], food) ~= 0) then
			return true;
		end
	end
	
	return false;

end

function FOM_IsKnownFood(food)
	return FOM_IsInDiet(food, {FOM_DIET_MEAT, FOM_DIET_FISH, FOM_DIET_BREAD, FOM_DIET_CHEESE, FOM_DIET_FUNGUS, FOM_DIET_FRUIT});
end

-- Get Item Name
function FOM_GetItemName(bag, slot)

	local itemLink = GetContainerItemLink(bag, slot);
	if (itemLink) then
		return FOM_NameFromLink(itemLink);
	else
		return "";
	end
end

function FOM_PetRename(newName)

	FOM_CheckSetup();

	-- move our saved food quality data to be indexed under the new name
	FOM_FoodQuality[FOM_RealmPlayer][newName] = FOM_FoodQuality[FOM_RealmPlayer][FOM_LastPetName];
	FOM_FoodQuality[FOM_RealmPlayer][FOM_LastPetName] = nil;

	FOM_Original_PetRename(newName);
	
end

function FOM_PetAbandon()
	
	FOM_CheckSetup();

	-- delete saved food-quality data for this pet so we don't bloat SavedVariables
	FOM_FoodQuality[FOM_RealmPlayer][FOM_LastPetName] = nil;

	FOM_Original_PetAbandon();
	
end

-- The icon for the cooking spell is unique and the same in all languages; use that to determine the localized name.
function FOM_CookingSpellName()
	FOM_COOKING_ICON = "Interface\\Icons\\INV_Misc_Food_15"; 
	if (FOM_COOKING_NAME == nil) then
		local spellName;
		local i = 0;
		repeat
			i = i + 1;
			spellName = GetSpellName(i, BOOKTYPE_SPELL);
			if (spellName ~= nil and GetSpellTexture(i, BOOKTYPE_SPELL) == FOM_COOKING_ICON) then
				FOM_COOKING_NAME = spellName;
				return FOM_COOKING_NAME;
			end
		until (spellName == nil);
	end
	return FOM_COOKING_NAME;	
end

function FOM_BagIsQuiver(bagNum)
	local invSlotID = ContainerIDToInventoryID(bagNum);
	local bagLink = GetInventoryItemLink("player", invSlotID);
	if (bagLink == nil) then
		return false;	
	end
	local _, _, itemID  = string.find(bagLink, "item:(%d+):%d+:%d+:%d+");
	if (tonumber(itemID)) then
		itemID = tonumber(itemID);
		local name, link, rarity, minLevel, type, subType, stackCount, equipLoc = GetItemInfo(itemID);
		if (type == "Ammo Pouch" or type == "Quiver" or subType == "Ammo Pouch" or subType == "Quiver") then
			return true;
		end
		if (type == FOM_AMMO_POUCH or type == FOM_QUIVER or subType == FOM_AMMO_POUCH or subType == FOM_QUIVER) then
			return true;
		end
	end	
	return false;
end

function FOM_IDFromLink(itemLink)
	if (itemLink == nil) then return nil; end
	local _, _, itemID  = string.find(itemLink, "item:(%d+):%d+:%d+:%d+");
	if (tonumber(itemID)) then
		return tonumber(itemID);
	else
		return nil;
	end
end

function FOM_NameFromLink(itemLink)
	if (itemLink == nil) then return nil; end
	local _, _, name = string.find(itemLink, "%[(.+)%]"); 
	return name;
end

function FOM_OptionsShow()
	FOM_VersionText:SetText("v. "..FOM_VERSION);
	FOM_KeepOpenSlots:SetText(FOM_Config.KeepOpenSlots);
	for option, text in FOM_OptionsButtonText do
		local button = getglobal("FOM_OptionsButton_"..option);
		local buttonText = getglobal("FOM_OptionsButton_"..option.."Text");
		if (button and buttonText) then
			if (FOM_Config[option]) then
				button:SetChecked(true);
			elseif (option == "SaveForCook_All" and FOM_Config.SaveForCookingLevel <= 0) then
				button:SetChecked(true);
			elseif (option == "SaveForCook_Green" and FOM_Config.SaveForCookingLevel == 1) then
				button:SetChecked(true);
			elseif (option == "SaveForCook_Yellow" and FOM_Config.SaveForCookingLevel == 2) then
				button:SetChecked(true);
			elseif (option == "SaveForCook_Orange" and FOM_Config.SaveForCookingLevel == 3) then
				button:SetChecked(true);
			elseif (option == "SaveForCook_None" and FOM_Config.SaveForCookingLevel >= 4) then
				button:SetChecked(true);
			elseif (option == "AudioWarningBell" and FOM_Config.AudioWarning == "bell") then
				button:SetChecked(true);
			elseif (option == "AlertEmote" and FOM_Config.Alert == "emote") then
				button:SetChecked(true);
			elseif (option == "AlertChat" and FOM_Config.Alert == "chat") then
				button:SetChecked(true);
			elseif (option == "AlertNone" and not FOM_Config.Alert) then
				button:SetChecked(true);
			elseif (option == "LevelContent" and FOM_Config.Level == "content") then
				button:SetChecked(true);
			elseif (option == "LevelUnhappy" and FOM_Config.Level == "unhappy") then
				button:SetChecked(true);
			elseif (option == "LevelOff" and not FOM_Config.Level) then
				button:SetChecked(true);
			else
				button:SetChecked(false);
			end
			buttonText:SetText(text);
		end
	end
end

function FOM_OptionsClick()
	local button = this:GetName();
	local option = string.gsub(button, "FOM_OptionsButton_", "");

	if (option == "SaveForCook_All" and this:GetChecked()) then
		FOM_Config.SaveForCookingLevel = 0;
	elseif (option == "SaveForCook_Green" and this:GetChecked()) then
		FOM_Config.SaveForCookingLevel = 1;
	elseif (option == "SaveForCook_Yellow" and this:GetChecked()) then
		FOM_Config.SaveForCookingLevel = 2;
	elseif (option == "SaveForCook_Orange" and this:GetChecked()) then
		FOM_Config.SaveForCookingLevel = 3;
	elseif (option == "SaveForCook_None" and this:GetChecked()) then
		FOM_Config.SaveForCookingLevel = 4;
	elseif (option == "AudioWarningBell") then
		if (this:GetChecked()) then
			FOM_Config.AudioWarning = "bell";
		else
			FOM_Config.AudioWarning = 1;
		end
	elseif (option == "AlertEmote" and this:GetChecked()) then
		FOM_Config.Alert = "emote";
	elseif (option == "AlertChat" and this:GetChecked()) then
		FOM_Config.Alert = "chat";
	elseif (option == "AlertNone" and this:GetChecked()) then
		FOM_Config.Alert = nil;
	elseif (option == "LevelContent" and this:GetChecked()) then
		FOM_Config.Level = "content";
	elseif (option == "LevelUnhappy" and this:GetChecked()) then
		FOM_Config.Level = "unhappy";
	elseif (option == "LevelOff" and this:GetChecked()) then
		FOM_Config.Level = nil;
	else
		FOM_Config[option] = this:GetChecked();
	end
	FOM_OptionsShow();
end

function FOM_KeepOpenSlots_TextChanged()
	FOM_Config.KeepOpenSlots = tonumber(this:GetText()) or 0;
end


