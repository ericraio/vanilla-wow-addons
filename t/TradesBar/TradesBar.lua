--[[

  TradesBar for WoW (World of Warcraft)
    Desc:  A row of buttons for your Trades Skills

  LIST OF AUTHORS and FIXERS
  Author 1:  Ian 'CRiSPy' Floyd  "Iling on Skywall(Nightelf)"
  German Tanslator1: Farook of wowinterface.com forum
  French Tanslator2: Trucifix of ui.worldofwar.net
   
]]--


--[[
 English Tranlation
 Author1: Ian "CRiSPyToWN" Floyd  "Iling on Skywall(Nightelf)"
]]--


--START  

  --trades/skills/professions
  TradesBarData = { };
    TRADES_ALCHEMY = "Alchemy";
    TRADES_BLACKSMITHING = "Blacksmithing";
    TRADES_COOKING = "Cooking";
    TRADES_BASIC_CAMPFIRE = "Basic Campfire";
    TRADES_ENCHANTING = "Enchanting";
    TRADES_DISENCHANT = "Disenchant";
    TRADES_ENGINEERING = "Engineering";
    TRADES_GNOME_ENGINEERING = "Gnome Engineering";
    TRADES_GOBLIN_ENGINEERING = "Goblin Engineering";
    TRADES_FIRST_AID = "First Aid";
    TRADES_FISHING = "Fishing";
    TRADES_HERBALISM = "Herbalism";
    TRADES_FIND_HERBS = "Find Herbs";
    TRADES_FIND_TREASURE = "Find Treasure";
    TRADES_LEATHERWORKING = "Leatherworking";
    TRADES_DRAGONSCALE_LEATHERWORKING = "Dragonscale Leatherworking";
    TRADES_ELEMENTAL_LEATHERWORKING = "Elemental Leatherworking";
    TRADES_TRIBAL_LEATHERWORKING = "Tribal Leatherworking"; 
    TRADES_PICK_LOCK = "Pick Lock"; 
    TRADES_PICK_POCKET = "Pick Pocket";
    TRADES_FIND_MINERALS = "Find Minerals";
    TRADES_SMELTING = "Smelting";
    TRADES_SKINNING = "Skinning";
    TRADES_TAILORING = "Tailoring";
    TRADES_SHADOWEAVE_TAILORING = "Shadoweave Tailoring";
    TRADES_POISONS = "Poisons";
  
--END

--[[
 German Tranlation
 Tanslator1: Farook of wowinterface.com forum
]]--
if (GetLocale() == "deDE") then

--START

  --trades/skills/professions
  TradesBarData = { };
    TRADES_ALCHEMY = "Alchimie";
    TRADES_BLACKSMITHING = "Schmiedekunst";
    TRADES_COOKING = "Kochkunst";
    TRADES_BASIC_CAMPFIRE = "Einfaches Lagerfeuer";
    TRADES_ENCHANTING = "Verzauberkunst";
    TRADES_DISENCHANT = "Entzaubern";
    TRADES_ENGINEERING = "Ingenieurskunst";
    TRADES_GNOME_ENGINEERING = "Gnomen-Ingenieurskunst";
    TRADES_GOBLIN_ENGINEERING = "Goblin-Ingenieurskunst";
    TRADES_FIRST_AID = "Erste Hilfe";
    TRADES_FISHING = "Angeln";
    TRADES_HERBALISM = "Kr\195\164uterkunde";
    TRADES_FIND_HERBS = "Kr\195\164utersuche";
    TRADES_FIND_TREASURE = "Schatzsucher";
    TRADES_LEATHERWORKING = "Lederverarbeitung";
    TRADES_DRAGONSCALE_LEATHERWORKING = "Drachenschuppen-Lederverarbeitung";
    TRADES_ELEMENTAL_LEATHERWORKING = "Elementargeist-Lederverarbeitung";
    TRADES_TRIBAL_LEATHERWORKING = "Stammes-Lederverarbeitung";
    TRADES_PICK_LOCK = "Schloss knacken";
    TRADES_PICK_POCKET = "Taschendiebstahl";
    TRADES_FIND_MINERALS = "Mineraliensuche";
    TRADES_SMELTING = "Verh\195\188ttung";
    TRADES_SKINNING = "K\195\188rschnerei";
    TRADES_TAILORING = "Schneiderei";
    TRADES_SHADOWEAVE_TAILORING = "Schattenweberei";
    TRADES_POISONS = "Gifte";
  
--END
end

--[[
 French Tranlation
 Tanslator2: Trucifix of ui.worldofwar.net
]]--
if (GetLocale() == "frFR") then

--START

  --trades/skills/professions
  TradesBarData = { };
    TRADES_ALCHEMY = "Alchimie";
    TRADES_BLACKSMITHING = "Forge";
    TRADES_COOKING = "Cuisine";
    TRADES_BASIC_CAMPFIRE = "Feu de camp basique";
    TRADES_ENCHANTING = "Enchantement";
    TRADES_DISENCHANT = "D\195\169senchanter";
    TRADES_ENGINEERING = "Ing\195\169nieur";
    TRADES_GNOME_ENGINEERING = "Ing\195\169nieur gnome";
    TRADES_GOBLIN_ENGINEERING = "Ing\195\169nieur gobelin";
    TRADES_FIRST_AID = "Premiers soins";
    TRADES_FISHING = "P\195\170che";
    TRADES_HERBALISM = "Herboriste";
    TRADES_FIND_HERBS = "D\195\169couverte d'herbes";
    TRADES_FIND_TREASURE = "D\195\169couverte de tr\195\169sors";
    TRADES_LEATHERWORKING = "Travail du cuir";
    TRADES_DRAGONSCALE_LEATHERWORKING = "Travail du cuir de dragon";
    TRADES_ELEMENTAL_LEATHERWORKING = "Travail du cuir \195\169l\195\169mentaire";
    TRADES_TRIBAL_LEATHERWORKING = "Travail du cuir tribal";
    TRADES_PICK_LOCK = "Crochetage";
    TRADES_PICK_POCKET = "Vol \195\160 la Tire";
    TRADES_FIND_MINERALS = "D\195\169couverte de gisements";
    TRADES_SMELTING = "Fondre";
    TRADES_SKINNING = "D\195\169peçage";
    TRADES_TAILORING = "Couture";
    TRADES_SHADOWEAVE_TAILORING = "Tailleur tissu-t\195\169n\195\168bres";
    TRADES_POISONS = "Poisons";
  
--END  
end

local Trades = {
	TRADES_ALCHEMY,
	TRADES_BLACKSMITHING,
	TRADES_COOKING,
  TRADES_BASIC_CAMPFIRE,
	TRADES_ENCHANTING,
	TRADES_DISENCHANT,
	TRADES_ENGINEERING,
	TRADES_GNOME_ENGINEERING,
	TRADES_GOBLIN_ENGINEERING,
	TRADES_FIRST_AID,
	TRADES_FISHING,
	TRADES_HERBALISM,
	TRADES_FIND_HERBS,
  TRADES_FIND_TREASURE,
	TRADES_LEATHERWORKING,
	TRADES_DRAGONSCALE_LEATHERWORKING,
	TRADES_ELEMENTAL_LEATHERWORKING,
	TRADES_TRIBAL_LEATHERWORKING,
	TRADES_PICK_LOCK,
	TRADES_PICK_POCKET,
	TRADES_FIND_MINERALS,
	TRADES_SMELTING,
	TRADES_SKINNING,
	TRADES_TAILORING,
	TRADES_SHADOWEAVE_TAILORING,
	TRADES_POISONS,
	};

local ver = 195;

TRADESBAR_ENABLED = true;

local TradesBar_is_fishingbuddy  = IsAddOnLoaded("FishingBuddy");
local inCombat, playerName, vMounted, button;

function TradesBar_OnLoad()
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("SPELLS_CHANGED");
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
	this:RegisterEvent("SPELL_UPDATE_COOLDOWN");
	
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");

  SLASH_TRADESBAR1 = "/tradesbar";
	SlashCmdList["TRADESBAR"] = function(msg)
		TradesBar_SlashHandler(string.lower(msg));
	end
end

function TradesBar_SlashHandler(msg)
	if (string.find(msg, "config")) then
    if(  TradesBarConfig:IsVisible() ) then
     TradesBarConfig:Hide();
    else
     TradesBarConfig:Show();
    end
	elseif (string.find(msg, "help")) then
		DEFAULT_CHAT_FRAME:AddMessage("To configure bar type '/tradesbar config'");
		DEFAULT_CHAT_FRAME:AddMessage("To move the bar: Hold down the control key and right click the TradesBar");
	else
		DEFAULT_CHAT_FRAME:AddMessage("Type '/tradesbar help' for help and '/tradesbar config' for the config");
	end
--tinsert(UISpecialFrames,"TradesBarConfig"); 
end

function StartTradesBar()
	if (not TradesBarData) then
		TradesBarData[playerName] = {};
		TradesBarData[playerName] = {
			["hidebar"] = "false",
			["horizontal"] = "true",
			["order"] = "az",
			["scale"] = 1,
			["version"] = ver,
			["Alchemy"] = "true",
			["Blacksmithing"] = "true",
			["Cooking"] = "true",
			["BasicCampfire"] = "true",
			["Enchanting"] = "true",
			["Disenchant"] = "true",
			["Engineering"] = "true",
			["FirstAid"] = "true",
			["Fishing"] = "true",
			["Herbalism"] = "true",
			["FindHerbs"] = "true",
			["FindTreasure"] = "true",
			["leatherworking"] = "true",
			["PickLock"] = "true",
			["PickPocket"] = "true",
			["FindMinerals"] = "true",
			["Smelting"] = "true",
			["Skinning"] = "true",
			["Tailoring"] = "true",
			["Poisons"] = "true",
			["AlphaInCombat"] = 0,
			["AlphaOutCombat"] = 1,
		};
	end
	if (not TradesBarData[playerName]) then
		TradesBarData[playerName] = {};
		TradesBarData[playerName] = {
			["hidebar"] = "false",
			["horizontal"] = "true",
			["order"] = "az",
			["scale"] = 1,
			["version"] = ver,
			["Alchemy"] = "true",
			["Blacksmithing"] = "true",
			["Cooking"] = "true",
			["BasicCampfire"] = "true",
			["Enchanting"] = "true",
			["Disenchant"] = "true",
			["Engineering"] = "true",
			["FirstAid"] = "true",
			["Fishing"] = "true",
			["Herbalism"] = "true",
			["FindHerbs"] = "true",
			["FindTreasure"] = "true",
			["leatherworking"] = "true",
			["PickLock"] = "true",
			["PickPocket"] = "true",
			["FindMinerals"] = "true",
			["Smelting"] = "true",
			["Skinning"] = "true",
			["Tailoring"] = "true",
			["Poisons"] = "true",
			["AlphaInCombat"] = 0,
			["AlphaOutCombat"] = 1,
		};
	end
	if (TradesBarData[playerName]["version"] ~= ver) then
		TradesBarData[playerName]["version"] = ver;
	end
	TradesBar_Update();
	TradesBar_Scale();
end

function FindPattern(text,pattern)
	return string.sub(text, string.find(text, pattern))
end

function TradesBar_OnEvent()
	if (event == "PLAYER_ENTERING_WORLD") then
		if (UnitName("player") ~= UNKNOWNBEING and UnitName("player") ~= UNKNOWNOBJECT and UnitName("player") and not playerName) then
			playerName = UnitName("player").." of "..GetCVar("realmName");
		end
		StartTradesBar();
	end
	if (event == "SPELLS_CHANGED" or event == "PLAYER_AURAS_CHANGED") then
		TradesBar_Update();
	elseif (event == "SPELL_UPDATE_COOLDOWN") then
		TradesBar_UpdateCooldowns();
	elseif (event == "PLAYER_REGEN_ENABLED") then
		inCombat = nil;
		TradesBar_setAlpha();
	elseif (event == "PLAYER_REGEN_DISABLED") then
		inCombat = 1;
		TradesBar_setAlpha();
  end
end

function TradesBar_Scale()
	for i = 1, 15 do
		button = getglobal("TradesBarButton"..i);
		button:SetScale(TradesBarData[playerName]["scale"]);
	end
end

function TradesBar_O()
	if (TradesBarData[playerName]) then
		if (not TradesBarData[playerName]["horizontal"]) then
			TradesBarData[playerName]["horizontal"] = "true"
			TradesBarData[playerName]["order"] = "az"			
		end
		if (TradesBarData[playerName]["horizontal"] == "true" and TradesBarData[playerName]["order"] == "az") then
			for i = 2, 15 do
				local button = getglobal("TradesBarButton"..i);
				button:ClearAllPoints();
				button:SetPoint("LEFT", "TradesBarButton"..i - 1, "RIGHT", 1, 0);
			end
		elseif (TradesBarData[playerName]["horizontal"] == "true" and TradesBarData[playerName]["order"] == "za") then
			for i = 2, 15 do
				local button = getglobal("TradesBarButton"..i);
				button:ClearAllPoints();
				button:SetPoint("RIGHT", "TradesBarButton"..i - 1, "LEFT", 1, 0);
			end
		elseif (TradesBarData[playerName]["horizontal"] == "false" and TradesBarData[playerName]["order"] == "az") then
			for i = 2, 15 do
				local button = getglobal("TradesBarButton"..i);
				button:ClearAllPoints();
				button:SetPoint("TOP", "TradesBarButton"..i - 1, "BOTTOM", 0, 1);
			end
		elseif (TradesBarData[playerName]["horizontal"] == "false" and TradesBarData[playerName]["order"] == "za") then
			for i = 2, 15 do
				local button = getglobal("TradesBarButton"..i);
				button:ClearAllPoints();
				button:SetPoint("BOTTOM", "TradesBarButton"..i - 1, "TOP", 0, 1);
			end
		else
			for i = 2, 15 do
				local button = getglobal("TradesBarButton"..i);
				button:ClearAllPoints();
				button:SetPoint("LEFT", "TradesBarButton"..i - 1, "RIGHT", 1, 0);
			end
		end
	end
end

function TradesBar_Hide()
   local frame = getglobal("TradesBar");
   if (frame) then
     if(  frame:IsVisible() ) then
       frame:Hide();
     else
       frame:Show();
     end
   end
end

function TradesBar_FishingBuddy_Over()
   local frame = getglobal("FishingBuddyFrame");
   if (frame) then
     if(  frame:IsVisible() ) then
       frame:Hide();
     else
       frame:Show();
     end
   end
end

function TradesBar_visableCheck(value)
	local hide_button = "yes";
	
	if (TradesBarData[playerName]["Alchemy"] == "true" and value == TRADES_ALCHEMY) then
		local hide_button = "no";
        return hide_button;
	end
	
	if (TradesBarData[playerName]["Blacksmithing"] == "true" and value == TRADES_BLACKSMITHING) then
		local hide_button = "no";
        return hide_button;
	end
	
	if (TradesBarData[playerName]["Cooking"] == "true" and value == TRADES_COOKING) then
		local hide_button = "no";
        return hide_button;
	end	
	
	if (TradesBarData[playerName]["BasicCampfire"] == "true" and value == TRADES_BASIC_CAMPFIRE) then
		local hide_button = "no";
        return hide_button;
	end	
	
	if (TradesBarData[playerName]["Enchanting"] == "true" and value == TRADES_ENCHANTING) then
		local hide_button = "no";
        return hide_button;
	end	
	
	if (TradesBarData[playerName]["Disenchant"] == "true" and value == TRADES_DISENCHANT) then
		local hide_button = "no";
        return hide_button;
	end	
	
	if (TradesBarData[playerName]["Engineering"] == "true" and (value == TRADES_ENGINEERING or value == TRADES_GNOME_ENGINEERING or value == TRADES_GOBLIN_ENGINEERING)) then
		local hide_button = "no";
        return hide_button;
	end	
	
	if (TradesBarData[playerName]["FirstAid"] == "true" and value == TRADES_FIRST_AID) then
		local hide_button = "no";
        return hide_button;
	end	
	
	if (TradesBarData[playerName]["Fishing"] == "true" and value == TRADES_FISHING) then
		local hide_button = "no";
        return hide_button;
	end
	
	if (TradesBarData[playerName]["Herbalism"] == "true" and value == TRADES_HERBALISM) then
		local hide_button = "no";
        return hide_button;
	end
	
	if (TradesBarData[playerName]["FindHerbs"] == "true" and value == TRADES_FIND_HERBS) then
		local hide_button = "no";
        return hide_button;
	end
	
	if (TradesBarData[playerName]["FindTreasure"] == "true" and value == TRADES_FIND_TREASURE) then
		local hide_button = "no";
        return hide_button;
	end
	
	if (TradesBarData[playerName]["leatherworking"] == "true" and (value == TRADES_LEATHERWORKING or value == TRADES_DRAGONSCALE_LEATHERWORKING or value == TRADES_ELEMENTAL_LEATHERWORKING or value == TRADES_TRIBAL_LEATHERWORKING)) then
		local hide_button = "no";
        return hide_button;
	end
	
	if (TradesBarData[playerName]["PickLock"] == "true" and value == TRADES_PICK_LOCK) then
		local hide_button = "no";
        return hide_button;
	end
	
	if (TradesBarData[playerName]["PickPocket"] == "true" and value == TRADES_PICK_POCKET) then
		local hide_button = "no";
        return hide_button;
	end
		
	if (TradesBarData[playerName]["FindMinerals"] == "true" and value == TRADES_FIND_MINERALS) then
		local hide_button = "no";
        return hide_button;
	end
	
	if (TradesBarData[playerName]["Smelting"] == "true" and value == TRADES_SMELTING) then
		local hide_button = "no";
        return hide_button;
	end
	
	if (TradesBarData[playerName]["Skinning"] == "true" and value == TRADES_SKINNING) then
		local hide_button = "no";
        return hide_button;
	end
	
	if (TradesBarData[playerName]["Tailoring"] == "true" and (value == TRADES_TAILORING or value == TRADES_SHADOWEAVE_TAILORING)) then
		local hide_button = "no";
        return hide_button;
	end
	
	if (TradesBarData[playerName]["Poisons"] == "true" and value == TRADES_POISONS) then
		local hide_button = "no";
        return hide_button;
	end
	
    return hide_button;
end


function TradesBar_SpecialCheck(value)
  local i_am_special = "no";
  if (value == "Leatherworking") then
    local if_Dragonscale = TradesBar_GetSpellID(TRADES_DRAGONSCALE_LEATHERWORKING);
    local if_Elemental = TradesBar_GetSpellID(TRADES_ELEMENTAL_LEATHERWORKING);
    local if_Tribal = TradesBar_GetSpellID(TRADES_TRIBAL_LEATHERWORKING);
    if (if_Dragonscale or if_Elemental or if_Tribal) then
      local i_am_special = "yes";
      return i_am_special;
    end
    return i_am_special;
  elseif (value == "Engineering") then
    local if_Gnome = TradesBar_GetSpellID(TRADES_GNOME_ENGINEERING);
    local if_Goblin = TradesBar_GetSpellID(TRADES_GOBLIN_ENGINEERING);
    if (if_Gnome or if_Goblin) then
      local i_am_special = "yes";
      return i_am_special;
    end
    return i_am_special;
  elseif (value == "Tailoring") then
    local if_Shadoweave = TradesBar_GetSpellID(TRADES_SHADOWEAVE_TAILORING);
    if (if_Shadoweave) then
      local i_am_special = "yes";
      return i_am_special;
    end
    return i_am_special;
  end
  return i_am_special;
end

function TradesBar_Update()
	if (TradesBarData[playerName]) then
    if (TradesBarData[playerName]["hidebar"] == "false") then
  		TradesBar_O();
  		i = 0;
  		for key in Trades do
  			getglobal("TradesBarButton"..key):Hide();
  		end
  		TradesBar:Show();
  		for key, value in Trades do
  			local id = TradesBar_GetSpellID(value);
  			local i_am_special2 = TradesBar_SpecialCheck(value);
  			local i_am_hidden = TradesBar_visableCheck(value);
  		    if (i_am_special2 == "no" and i_am_hidden == "no") then
  			  if (id) then
  				  i = i + 1;
    				button = getglobal("TradesBarButton"..i);
    				local texture = GetSpellTexture(id, BOOKTYPE_SPELL);
    				getglobal("TradesBarButton"..i.."Icon"):SetTexture(texture);
    				button.id = id;
    				button.texture = texture;
    				button:Show();
  			  end
  			end
  		end
  		if (i == 0) then
  			TradesBar:Hide();
  		end
    end
  end
end

function TradesBar_UpdateCooldowns()
	for i = 1, 15 do
		button = getglobal("TradesBarButton"..i);
		if (button.id) then
			local cooldown = getglobal(button:GetName().."Cooldown");
			local start, duration, enable = GetSpellCooldown(button.id, SpellBookFrame.bookType);
			if (start > 0 and duration > 0) then
				CooldownFrame_SetTimer(cooldown, start, duration, enable);
			end
		end
	end
end

function TradesBar_GetSpellID(spell, rank, debug)
	local i = 1;
	local spellID;
	local highestRank;
	while true do
		local spellName, spellRank = GetSpellName(i, SpellBookFrame.bookType);
		if (not spellName) then
			break;
		end
		if (spellName == spell) then
			if (rank) then
				if (spellRank == rank) then
					if (debug) then
						DEFAULT_CHAT_FRAME:AddMessage("Found |cffffffff'"..spell.." ("..rank..")'|r at slot |cffffffff'"..i.."'", 0.1, 1.0, 0.0);
					end
					return i;
				end
			else
				spellID = i;
				highestRank = spellRank;
			end
		end
		i = i + 1;
		if (i > 200) then
			break;
		end
	end			
	if (debug) then
		DEFAULT_CHAT_FRAME:AddMessage("Could not find |cffffffff'"..spell.." ("..rank..")'", 1.0, 0.1, 0.0);
	end
	return spellID, highestRank;
end

function TradesBar_SetTooltip()
	if (this.id) then
		GameTooltip_SetDefaultAnchor(GameTooltip, this);
		GameTooltip:SetSpell(this.id, SpellBookFrame.bookType);
		GameTooltip:Show();
	end
end

function TradesBar_OnClick()
	if (this.id and arg1 == "LeftButton") then
  local Fishing_spellID = TradesBar_GetSpellID(TRADES_FISHING);
    if (TradesBar_is_fishingbuddy and this.id == Fishing_spellID) then
	    --DEFAULT_CHAT_FRAME:AddMessage("TradesBar DEBUG:  Fishingbuddy found ~ "..this.id);
	    TradesBar_FishingBuddy_Over();
    else
	    --DEFAULT_CHAT_FRAME:AddMessage("TradesBar DEBUG:  Fishingbuddy NOT FOUND ~ "..this.id);
      CastSpell(this.id, BOOKTYPE_SPELL);
    end
	end
end

function TradesBar_OnBind(that_spell)
  local spellID = TradesBar_GetSpellID(that_spell);
	  if (TradesBar_is_fishingbuddy and that_spell == TRADES_FISHING) then
	    --DEFAULT_CHAT_FRAME:AddMessage("[TradesBar DEBUG:]  FishingBuddy found ~ "..that_spell.." - "..TRADES_FISHING);
	    TradesBar_FishingBuddy_Over();
    else
	    --DEFAULT_CHAT_FRAME:AddMessage("[TradesBar DEBUG:]  FishingBuddy NOT FOUND ~ "..that_spell.." - "..TRADES_FISHING);
      CastSpell(spellID, BOOKTYPE_SPELL);
    end
end

function TradesBarGetPoint()
	local vLeft = TradesBar:GetLeft();
	local vTop = TradesBar:GetTop();
	TradesBarData[playerName]["left"] = vLeft;
	TradesBarData[playerName]["top"] = vTop;
	-- DEFAULT_CHAT_FRAME:AddMessage(vLeft.." "..vTop);
end

function TradesBar_setAlpha()
  local frame = getglobal("TradesBar");
  if (event == "PLAYER_REGEN_DISABLED") then
       frame:SetAlpha(TradesBarData[playerName]["AlphaInCombat"]);
  else
       frame:SetAlpha(TradesBarData[playerName]["AlphaOutCombat"]);
	end
end

-- CONFIG

-- OnShow
function TradesBarConfig_OnShow()
	if (not TradesBarData) then
		this:Hide();
		return;
	end
	if (not TradesBarData[playerName]) then
		this:Hide();
		return;
	end
	TradesBarConfigPanel1CheckButton2:SetChecked( TradesBarData[playerName]["horizontal"] );
	TradesBarConfigPanel1CheckButton1:SetChecked( TradesBarData[playerName]["hidebar"] );
	TradesBarConfigPanel4CheckButton14:SetChecked( TradesBarData[playerName]["leatherworking"] );
	TradesBarConfigPanel4CheckButton4:SetChecked( TradesBarData[playerName]["Alchemy"] );
	TradesBarConfigPanel4CheckButton5:SetChecked( TradesBarData[playerName]["Blacksmithing"] );
	TradesBarConfigPanel4CheckButton6:SetChecked( TradesBarData[playerName]["Cooking"] );
	TradesBarConfigPanel5CheckButton10:SetChecked( TradesBarData[playerName]["BasicCampfire"] );
	TradesBarConfigPanel4CheckButton7:SetChecked( TradesBarData[playerName]["Enchanting"] );
	TradesBarConfigPanel5CheckButton20:SetChecked( TradesBarData[playerName]["Disenchant"] );
	TradesBarConfigPanel4CheckButton8:SetChecked( TradesBarData[playerName]["Engineering"] );
	TradesBarConfigPanel4CheckButton11:SetChecked( TradesBarData[playerName]["FirstAid"] );
	TradesBarConfigPanel4CheckButton12:SetChecked( TradesBarData[playerName]["Fishing"] );
	TradesBarConfigPanel4CheckButton9:SetChecked( TradesBarData[playerName]["Herbalism"] );
	TradesBarConfigPanel5CheckButton19:SetChecked( TradesBarData[playerName]["FindHerbs"] );
	TradesBarConfigPanel5CheckButton23:SetChecked( TradesBarData[playerName]["FindTreasure"] );
	TradesBarConfigPanel5CheckButton21:SetChecked( TradesBarData[playerName]["PickLock"] );
	TradesBarConfigPanel5CheckButton22:SetChecked( TradesBarData[playerName]["PickPocket"] );
	TradesBarConfigPanel5CheckButton18:SetChecked( TradesBarData[playerName]["FindMinerals"] );
	TradesBarConfigPanel4CheckButton16:SetChecked( TradesBarData[playerName]["Smelting"] );
	TradesBarConfigPanel4CheckButton15:SetChecked( TradesBarData[playerName]["Skinning"] );
	TradesBarConfigPanel4CheckButton13:SetChecked( TradesBarData[playerName]["Tailoring"] );
	TradesBarConfigPanel5CheckButton17:SetChecked( TradesBarData[playerName]["Poisons"] );		
	TradesBarConfigPanel1SliderScale:SetValue( TradesBarData[playerName]["scale"] );
end

function TradesBarConfigScale_OnClick()
	TradesBarData[playerName]["scale"] = this:GetValue();
	TradesBar_Scale();
end

function TradesBarConfigCheckBoxHide_OnClick()
	if (TradesBarData[playerName]["hidebar"] == "true") then
		TradesBarData[playerName]["hidebar"] = "false";
	else
		TradesBarData[playerName]["hidebar"] = "true";
	end
	TradesBar_Hide();
	TradesBar_Update();
end

function TradesBarConfigCheckBox_OnClick()
	if (TradesBarData[playerName]["horizontal"] == "true") then
		TradesBarData[playerName]["horizontal"] = "false";
	else
		TradesBarData[playerName]["horizontal"] = "true"
	end
	TradesBar_O();
end

function TradesBarConfigCheckBoxOrder_OnClick()
	if (TradesBarData[playerName]["order"] == "az") then
		TradesBarData[playerName]["order"] = "za";
	else
		TradesBarData[playerName]["order"] = "az"
	end
	TradesBar_O();
end

function TradesBarConfigCheckBox_Alchemy_OnClick()
	if (TradesBarData[playerName]["Alchemy"] == "true") then
		TradesBarData[playerName]["Alchemy"] = "false";
	else
		TradesBarData[playerName]["Alchemy"] = "true"
	end
	TradesBar_Update();
end

function TradesBarConfigCheckBox_Blacksmithing_OnClick()
	if (TradesBarData[playerName]["Blacksmithing"] == "true") then
		TradesBarData[playerName]["Blacksmithing"] = "false";
	else
		TradesBarData[playerName]["Blacksmithing"] = "true"
	end
	TradesBar_Update();
end

function TradesBarConfigCheckBox_Cooking_OnClick()
	if (TradesBarData[playerName]["Cooking"] == "true") then
		TradesBarData[playerName]["Cooking"] = "false";
	else
		TradesBarData[playerName]["Cooking"] = "true"
	end
	TradesBar_Update();
end

function TradesBarConfigCheckBox_BasicCampfire_OnClick()
	if (TradesBarData[playerName]["BasicCampfire"] == "true") then
		TradesBarData[playerName]["BasicCampfire"] = "false";
	else
		TradesBarData[playerName]["BasicCampfire"] = "true"
	end
	TradesBar_Update();
end

function TradesBarConfigCheckBox_Enchanting_OnClick()
	if (TradesBarData[playerName]["Enchanting"] == "true") then
		TradesBarData[playerName]["Enchanting"] = "false";
	else
		TradesBarData[playerName]["Enchanting"] = "true"
	end
	TradesBar_Update();
end

function TradesBarConfigCheckBox_Disenchant_OnClick()
	if (TradesBarData[playerName]["Disenchant"] == "true") then
		TradesBarData[playerName]["Disenchant"] = "false";
	else
		TradesBarData[playerName]["Disenchant"] = "true"
	end
	TradesBar_Update();
end

function TradesBarConfigCheckBox_Engineering_OnClick()
	if (TradesBarData[playerName]["Engineering"] == "true") then
		TradesBarData[playerName]["Engineering"] = "false";
	else
		TradesBarData[playerName]["Engineering"] = "true"
	end
	TradesBar_Update();
end

function TradesBarConfigCheckBox_FirstAid_OnClick()
	if (TradesBarData[playerName]["FirstAid"] == "true") then
		TradesBarData[playerName]["FirstAid"] = "false";
	else
		TradesBarData[playerName]["FirstAid"] = "true"
	end
	TradesBar_Update();
end

function TradesBarConfigCheckBox_Fishing_OnClick()
	if (TradesBarData[playerName]["Fishing"] == "true") then
		TradesBarData[playerName]["Fishing"] = "false";
	else
		TradesBarData[playerName]["Fishing"] = "true"
	end
	TradesBar_Update();
end

function TradesBarConfigCheckBox_Herbalism_OnClick()
	if (TradesBarData[playerName]["Herbalism"] == "true") then
		TradesBarData[playerName]["Herbalism"] = "false";
	else
		TradesBarData[playerName]["Herbalism"] = "true"
	end
	TradesBar_Update();
end

function TradesBarConfigCheckBox_FindHerbs_OnClick()
	if (TradesBarData[playerName]["FindHerbs"] == "true") then
		TradesBarData[playerName]["FindHerbs"] = "false";
	else
		TradesBarData[playerName]["FindHerbs"] = "true"
	end
	TradesBar_Update();
end

function TradesBarConfigCheckBox_FindTreasure_OnClick()
	if (TradesBarData[playerName]["FindTreasure"] == "true") then
		TradesBarData[playerName]["FindTreasure"] = "false";
	else
		TradesBarData[playerName]["FindTreasure"] = "true"
	end
	TradesBar_Update();
end

function TradesBarConfigCheckBox_leatherworking_OnClick()
	if (TradesBarData[playerName]["leatherworking"] == "true") then
		TradesBarData[playerName]["leatherworking"] = "false";
	else
		TradesBarData[playerName]["leatherworking"] = "true"
	end
	TradesBar_Update();
end

function TradesBarConfigCheckBox_PickLock_OnClick()
	if (TradesBarData[playerName]["PickLock"] == "true") then
		TradesBarData[playerName]["PickLock"] = "false";
	else
		TradesBarData[playerName]["PickLock"] = "true"
	end
	TradesBar_Update();
end

function TradesBarConfigCheckBox_PickPocket_OnClick()
	if (TradesBarData[playerName]["PickPocket"] == "true") then
		TradesBarData[playerName]["PickPocket"] = "false";
	else
		TradesBarData[playerName]["PickPocket"] = "true"
	end
	TradesBar_Update();
end

function TradesBarConfigCheckBox_FindMinerals_OnClick()
	if (TradesBarData[playerName]["FindMinerals"] == "true") then
		TradesBarData[playerName]["FindMinerals"] = "false";
	else
		TradesBarData[playerName]["FindMinerals"] = "true"
	end
	TradesBar_Update();
end

function TradesBarConfigCheckBox_Smelting_OnClick()
	if (TradesBarData[playerName]["Smelting"] == "true") then
		TradesBarData[playerName]["Smelting"] = "false";
	else
		TradesBarData[playerName]["Smelting"] = "true"
	end
	TradesBar_Update();
end

function TradesBarConfigCheckBox_Skinning_OnClick()
	if (TradesBarData[playerName]["Skinning"] == "true") then
		TradesBarData[playerName]["Skinning"] = "false";
	else
		TradesBarData[playerName]["Skinning"] = "true"
	end
	TradesBar_Update();
end

function TradesBarConfigCheckBox_Tailoring_OnClick()
	if (TradesBarData[playerName]["Tailoring"] == "true") then
		TradesBarData[playerName]["Tailoring"] = "false";
	else
		TradesBarData[playerName]["Tailoring"] = "true"
	end
	TradesBar_Update();
end

function TradesBarConfigCheckBox_Poisons_OnClick()
	if (TradesBarData[playerName]["Poisons"] == "true") then
		TradesBarData[playerName]["Poisons"] = "false";
	else
		TradesBarData[playerName]["Poisons"] = "true"
	end
	TradesBar_Update();
end
