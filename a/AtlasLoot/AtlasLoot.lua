local VERSION_MAJOR = "1";
local VERSION_MINOR = "17";
local VERSION_BOSSES = "04";
ATLASLOOT_VERSION = "|cff4169e1AtlasLoot Enhanced v"..VERSION_MAJOR.."."..VERSION_MINOR.."."..VERSION_BOSSES.."|r";
ATLASLOOT_CURRENT_ATLAS = "1.7.5";

-- Colours stored for code readability
local GREY = "|cff999999";
local RED = "|cffff0000";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";

local ATLAS_LOOT_BOSS_LINES	= 27;

local AtlasLoot_AnchorFrame = AtlasFrame;		-- Added

local Hooked_Atlas_Refresh;

-- Initialise saved variables
if(AtlasLootOptions == nil) then
    AtlasLootOptions = {};
end

if ( AtlasLootOptions["SafeLinks"] == nil ) then
	AtlasLootOptions["SafeLinks"] = true;
end
if ( AtlasLootOptions["AllLinks"] == nil ) then
	AtlasLootOptions["AllLinks"] = false;
end
if ( AtlasLootOptions["DefaultTT"] == nil ) then
	AtlasLootOptions["DefaultTT"] = true;
end
if ( AtlasLootOptions["LootlinkTT"] == nil ) then
	AtlasLootOptions["LootlinkTT"] = false;
end
if ( AtlasLootOptions["ItemSyncTT"] == nil ) then
	AtlasLootOptions["ItemSyncTT"] = false;
end
if ( AtlasLootOptions["EquipCompare"] == nil ) then
	AtlasLootOptions["EquipCompare"] = false;
end

-- Popup Box for first time users
StaticPopupDialogs["ATLASLOOT_SETUP"] = {
  text = ATLASLOOT_FIRST_TIME_TEXT,
  button1 = ATLASLOOT_FIRST_TIME_BUTTON,
  OnAccept = function()
      AtlasLootOptions_Toggle();
  end,
  timeout = 0,
  whileDead = 1,
  hideOnEscape = 1
};

--Popup Box for an old version of Atlas
StaticPopupDialogs["ATLASLOOT_OLD_ATLAS"] = {
  text = ATLASLOOT_OLD_ATLAS_TEXT_PT1..ATLASLOOT_CURRENT_ATLAS..ATLASLOOT_OLD_ATLAS_TEXT_PT2,
  button1 = ATLASLOOT_OLD_ATLAS_BUTTON,
  OnAccept = function()
      AtlasLootOptions_Toggle();
  end,
  timeout = 0,
  whileDead = 1,
  hideOnEscape = 1
};

--------------------------------------------------------------------------------
-- OnEvent
--------------------------------------------------------------------------------
function AtlasLoot_OnEvent(event)
	if(event == "VARIABLES_LOADED") then
		AtlasLoot_OnVariablesLoaded();
  end
end


--------------------------------------------------------------------------------
-- OnEvent - VariablesLoaded
-- When the game has loaded all variables, initialise the mod
--------------------------------------------------------------------------------
function AtlasLoot_OnVariablesLoaded()
	Hooked_Atlas_Refresh = Atlas_Refresh;
	Atlas_Refresh = AtlasLoot_Refresh;
    AtlasLoot_Refresh();
    --Disable options that don't have the supporting mods
    if( not LootLink_SetTooltip and (AtlasLootOptions.LootlinkTT == true)) then
        AtlasLootOptions.LootlinkTT = false;
        AtlasLootOptions.DefaultTT = true;
    end
    if( not ISYNC_VERSION and (AtlasLootOptions.ItemSyncTT == true)) then
        AtlasLootOptions.ItemSyncTT = false;
        AtlasLootOptions.DefaultTT = true;
    end
    if( not EquipCompare_RegisterTooltip and (AtlasLootOptions.EquipCompare == true)) then
        AtlasLootOptions.EquipCompare = false;
    end
    if((EquipCompare_RegisterTooltip) and (AtlasLootOptions["EquipCompare"] == true)) then
        EquipCompare_RegisterTooltip(AtlasLootTooltip);
    end
    if ( Hooked_Atlas_Refresh ) then
	    AtlasLoot_SetupForAtlas();
        --If a first time user, set up options
        if( (AtlasLootVersion == nil) or (tonumber(AtlasLootVersion) < 11402)) then
            AtlasLootOptions["SafeLinks"] = true;
            AtlasLootOptions["AllLinks"] = false;
            AtlasLootVersion = VERSION_MAJOR..VERSION_MINOR..VERSION_BOSSES;
            StaticPopup_Show ("ATLASLOOT_SETUP");
        end
        --If not the expected Atlas version
        if( ATLAS_VERSION ~= ATLASLOOT_CURRENT_ATLAS ) then
            StaticPopup_Show ("ATLASLOOT_OLD_ATLAS");
        end
    else
        AtlasLootItemsFrame:Hide();
    end        
end

--If someone types /atlasloot, bring up the options box
function AtlasLoot_SlashCommand(msg)
	if(msg == "**") then
		AtlasLootOptions_Toggle();
	else
		AtlasLootOptions_Toggle();
	end
end

--Toggle on/off the options window
function AtlasLootOptions_Toggle()
	if(AtlasLootOptionsFrame:IsVisible()) then
		AtlasLootOptionsFrame:Hide();
	else
		AtlasLootOptionsFrame:Show();
        if(AtlasLootOptions["DefaultTT"] == true) then
            AtlasLootOptions_DefaultTTToggle();
        elseif(AtlasLootOptions["LootlinkTT"] == true) then
            AtlasLootOptions_LootlinkTTToggle();
        elseif(AtlasLootOptions["ItemSyncTT"] == true) then
            AtlasLootOptions_ItemSyncTTToggle();
        end
	end
end

--------------------------------------------------------------------------------
-- OnLoad
-- When the mod loads, register to complete initialisation when
-- everything else is loaded.   
--------------------------------------------------------------------------------
function AtlasLoot_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
    SLASH_ATLASLOOT1 = "/atlasloot";
    SlashCmdList["ATLASLOOT"] = function(msg)
        AtlasLoot_SlashCommand(msg);
    end
end

--------------------------------------------------------------------------------
-- Item OnEnter
-- Called when a loot item is moused over
--------------------------------------------------------------------------------
function AtlasLootItem_OnEnter()
    local yOffset;
    if(this.itemID ~= 0 and this.itemID ~= "" and this.itemID ~= nil) then
        Identifier = "Item"..this.itemID;
        DKP = DKPValues[Identifier];
    else
        DKP = nil;
    end
    --Lootlink tooltips
    if( AtlasLootOptions.LootlinkTT ) then
        --If we have seen the item, use the game tooltip to minimise same name item problems
        if(GetItemInfo(this.itemID) ~= nil) then
            AtlasLootTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
            AtlasLootTooltip:SetHyperlink("item:"..this.itemID..":0:0:0");
            if( this.droprate ~= nil) then
                AtlasLootTooltip:AddLine(ATLASLOOT_DROP_RATE..this.droprate, 1, 1, 0);
            end
            if( DKP ~= nil and DKP ~= "" ) then
                AtlasLootTooltip:AddLine(RED..DKP.." "..ATLASLOOT_DKP, 1, 1, 0);
            end
            AtlasLootTooltip:Show();
        else
            AtlasLootTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
            LootLink_SetTooltip(AtlasLootTooltip, strsub(getglobal("AtlasLootItem_"..this:GetID().."_Name"):GetText(), 11), 1);
            if( this.droprate ~= nil) then
                AtlasLootTooltip:AddLine(ATLASLOOT_DROP_RATE..this.droprate, 1, 1, 0);
            end
            if( DKP ~= nil and DKP ~= "" ) then
                AtlasLootTooltip:AddLine(RED..DKP.." "..ATLASLOOT_DKP, 1, 1, 0);
            end
            AtlasLootTooltip:Show();
        end
    --Item Sync tooltips
    elseif( AtlasLootOptions.ItemSyncTT ) then
        ISync:ButtonEnter();
        if( this.droprate ~= nil) then
            GameTooltip:AddLine(ATLASLOOT_DROP_RATE..this.droprate, 1, 1, 0);
            GameTooltip:Show();
        end
        if( DKP ~= nil and DKP ~= "" ) then
            AtlasLootTooltip:AddLine(RED..DKP.." "..ATLASLOOT_DKP, 1, 1, 0);
        end
    --Default game tooltips
    else
        if(this.itemID ~= nil and GetItemInfo(this.itemID) ~= nil) then
            AtlasLootTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
            AtlasLootTooltip:SetHyperlink("item:"..this.itemID..":0:0:0");
            if( this.droprate ~= nil) then
                AtlasLootTooltip:AddLine(ATLASLOOT_DROP_RATE..this.droprate, 1, 1, 0);
            end
            if( DKP ~= nil and DKP ~= "" ) then
                AtlasLootTooltip:AddLine(RED..DKP.." "..ATLASLOOT_DKP, 1, 1, 0);
            end
            AtlasLootTooltip:Show();
        end
    end
end

--------------------------------------------------------------------------------
-- Item OnLeave
-- Called when the mouse cursor leaves a loot item
--------------------------------------------------------------------------------
function AtlasLootItem_OnLeave()
    --Hide the necessary tooltips
    if( AtlasLootOptions.LootlinkTT ) then
        AtlasLootTooltip:Hide();
    elseif( AtlasLootOptions.ItemSyncTT ) then
        if(GameTooltip:IsVisible()) then
            GameTooltip:Hide();
        end
    else
        if(this.itemID ~= nil) then
		    AtlasLootTooltip:Hide();
            GameTooltip:Hide();
	    end
    end
end

--------------------------------------------------------------------------------
-- Item OnClick
-- Called when a loot item is clicked on
--------------------------------------------------------------------------------
function AtlasLootItem_OnClick()
	local color = strsub(getglobal("AtlasLootItem_"..this:GetID().."_Name"):GetText(), 1, 10);
	local id = this:GetID();
	local name = strsub(getglobal("AtlasLootItem_"..this:GetID().."_Name"):GetText(), 11);
	local iteminfo = GetItemInfo(this.itemID);
    --If shift-clicked, link in the chat window
	if(ChatFrameEditBox:IsVisible() and IsShiftKeyDown() and iteminfo and (AtlasLootOptions.SafeLinks or AtlasLootOptions.AllLinks)) then
    	ChatFrameEditBox:Insert(color.."|Hitem:"..this.itemID..":0:0:0|h["..name.."]|h|r");
	elseif(ChatFrameEditBox:IsVisible() and IsShiftKeyDown() and AtlasLootOptions.AllLinks) then
		ChatFrameEditBox:Insert(color.."|Hitem:"..this.itemID..":0:0:0|h["..name.."]|h|r");
    elseif(ChatFrameEditBox:IsVisible()) then
		ChatFrameEditBox:Insert(name);
    --If control-clicked, use the dressing room
    elseif(IsControlKeyDown() and iteminfo) then
        DressUpItemLink(this.itemID);
	end
end

--------------------------------------------------------------------------------
-- Text replacement function
--------------------------------------------------------------------------------
local function AtlasLoot_FixText(text)
    --Armour class
    text = gsub(text, "#a1#", ATLASLOOT_CLOTH);
    text = gsub(text, "#a2#", ATLASLOOT_LEATHER);
    text = gsub(text, "#a3#", ATLASLOOT_MAIL);
    text = gsub(text, "#a4#", ATLASLOOT_PLATE);

    --Body slot
    text = gsub(text, "#s1#", ATLASLOOT_HEAD);
    text = gsub(text, "#s2#", ATLASLOOT_NECK);
    text = gsub(text, "#s3#", ATLASLOOT_SHOULDER);
    text = gsub(text, "#s4#", ATLASLOOT_BACK);
    text = gsub(text, "#s5#", ATLASLOOT_CHEST);
    text = gsub(text, "#s6#", ATLASLOOT_SHIRT);
    text = gsub(text, "#s7#", ATLASLOOT_TABARD);
    text = gsub(text, "#s8#", ATLASLOOT_WRIST);
    text = gsub(text, "#s9#", ATLASLOOT_HANDS);
    text = gsub(text, "#s10#", ATLASLOOT_WAIST);
    text = gsub(text, "#s11#", ATLASLOOT_LEGS);
    text = gsub(text, "#s12#", ATLASLOOT_FEET);
    text = gsub(text, "#s13#", ATLASLOOT_RING);
    text = gsub(text, "#s14#", ATLASLOOT_TRINKET);
    text = gsub(text, "#s15#", ATLASLOOT_OFF_HAND);
    text = gsub(text, "#s16#", ATLASLOOT_RELIC);

    --Weapon Weilding
    text = gsub(text, "#h1#", ATLASLOOT_ONE_HAND);
    text = gsub(text, "#h2#", ATLASLOOT_TWO_HAND);
    text = gsub(text, "#h3#", ATLASLOOT_MAIN_HAND);
    text = gsub(text, "#h4#", ATLASLOOT_OFFHAND);

    --Weapon type
    text = gsub(text, "#w1#", ATLASLOOT_AXE);
    text = gsub(text, "#w2#", ATLASLOOT_BOW);
    text = gsub(text, "#w3#", ATLASLOOT_CROSSBOW);
    text = gsub(text, "#w4#", ATLASLOOT_DAGGER);
    text = gsub(text, "#w5#", ATLASLOOT_GUN);
    text = gsub(text, "#w6#", ATLASLOOT_MACE);
    text = gsub(text, "#w7#", ATLASLOOT_POLEARM);
    text = gsub(text, "#w8#", ATLASLOOT_SHIELD);
    text = gsub(text, "#w9#", ATLASLOOT_STAFF);
    text = gsub(text, "#w10#", ATLASLOOT_SWORD);
    text = gsub(text, "#w11#", ATLASLOOT_THROWN);
    text = gsub(text, "#w12#", ATLASLOOT_WAND);
    text = gsub(text, "#w13#", ATLASLOOT_FIST);

    -- Misc. Equipment
    text = gsub(text, "#e1#", ATLASLOOT_POTION);
    text = gsub(text, "#e2#", ATLASLOOT_FOOD);
    text = gsub(text, "#e3#", ATLASLOOT_DRINK);
    text = gsub(text, "#e4#", ATLASLOOT_BANDAGE);
    text = gsub(text, "#e5#", ATLASLOOT_ARROW);
    text = gsub(text, "#e6#", ATLASLOOT_BULLET);
    text = gsub(text, "#e7#", ATLASLOOT_MOUNT);
    text = gsub(text, "#e8#", ATLASLOOT_AMMO);
    text = gsub(text, "#e9#", ATLASLOOT_QUIVER);
    text = gsub(text, "#e10#", ATLASLOOT_BAG);
    text = gsub(text, "#e11#", ATLASLOOT_ENCHANT);
    text = gsub(text, "#e12#", ATLASLOOT_TRADE_GOODS);
    text = gsub(text, "#e13#", ATLASLOOT_SCOPE);
    text = gsub(text, "#e14#", ATLASLOOT_KEY);
    text = gsub(text, "#e15#", ATLASLOOT_PET);
    text = gsub(text, "#e16#", ATLASLOOT_IDOL);
    text = gsub(text, "#e17#", ATLASLOOT_TOTEM);
    text = gsub(text, "#e18#", ATLASLOOT_LIBRAM);
    text = gsub(text, "#e19#", ATLASLOOT_DARKMOON);
    text = gsub(text, "#e20#", ATLASLOOT_BOOK);
    text = gsub(text, "#e21#", ATLASLOOT_BANNER);

    -- Classes
    text = gsub(text, "#c1#", ATLASLOOT_DRUID);
    text = gsub(text, "#c2#", ATLASLOOT_HUNTER);
    text = gsub(text, "#c3#", ATLASLOOT_MAGE);
    text = gsub(text, "#c4#", ATLASLOOT_PALADIN);
    text = gsub(text, "#c5#", ATLASLOOT_PRIEST);
    text = gsub(text, "#c6#", ATLASLOOT_ROGUE);
    text = gsub(text, "#c7#", ATLASLOOT_SHAMAN);
    text = gsub(text, "#c8#", ATLASLOOT_WARLOCK);
    text = gsub(text, "#c9#", ATLASLOOT_WARRIOR);

    --Professions
    text = gsub(text, "#p1#", ATLASLOOT_ALCHEMY);
    text = gsub(text, "#p2#", ATLASLOOT_BLACKSMITHING);
    text = gsub(text, "#p3#", ATLASLOOT_COOKING);
    text = gsub(text, "#p4#", ATLASLOOT_ENCHANTING);
    text = gsub(text, "#p5#", ATLASLOOT_ENGINEERING);
    text = gsub(text, "#p6#", ATLASLOOT_FIRST_AID);
    text = gsub(text, "#p7#", ATLASLOOT_LEATHERWORKING);
    text = gsub(text, "#p8#", ATLASLOOT_TAILORING);
    text = gsub(text, "#p9#", ATLASLOOT_DRAGONSCALE);
    text = gsub(text, "#p10#", ATLASLOOT_TRIBAL);
    text = gsub(text, "#p11#", ATLASLOOT_ELEMENTAL);

    --Reputation
    text = gsub(text, "#r1#", ATLASLOOT_NEUTRAL);
    text = gsub(text, "#r2#", ATLASLOOT_FRIENDLY);
    text = gsub(text, "#r3#", ATLASLOOT_HONORED);
    text = gsub(text, "#r4#", ATLASLOOT_REVERED);
    text = gsub(text, "#r5#", ATLASLOOT_EXALTED);

    --Battleground Factions
    text = gsub(text, "#b1#", ATLASLOOT_BG_STORMPIKE);
    text = gsub(text, "#b2#", ATLASLOOT_BG_FROSTWOLF);
    text = gsub(text, "#b3#", ATLASLOOT_BG_SENTINELS);
    text = gsub(text, "#b4#", ATLASLOOT_BG_OUTRIDERS);
    text = gsub(text, "#b5#", ATLASLOOT_BG_ARATHOR);
    text = gsub(text, "#b6#", ATLASLOOT_BG_DEFILERS);

    -- Misc phrases and mod specific stuff
    text = gsub(text, "#m1#", ATLASLOOT_CLASSES);
    text = gsub(text, "#m2#", ATLASLOOT_QUEST1);
    text = gsub(text, "#m3#", ATLASLOOT_QUEST2);
    text = gsub(text, "#m4#", ATLASLOOT_QUEST3);
    text = gsub(text, "#m5#", ATLASLOOT_SHARED);
    text = gsub(text, "#m6#", ATLASLOOT_HORDE);
    text = gsub(text, "#m7#", ATLASLOOT_ALLIANCE);
    text = gsub(text, "#m8#", ATLASLOOT_UNIQUE);
    text = gsub(text, "#m9#", ATLASLOOT_RIGHTSIDE);
    text = gsub(text, "#m10#", ATLASLOOT_LEFTSIDE);
    text = gsub(text, "#m11#", ATLASLOOT_FELCOREBAG);
    text = gsub(text, "#m12#", ATLASLOOT_ONYBAG);
    text = gsub(text, "#m13#", ATLASLOOT_WCBAG);
    text = gsub(text, "#m14#", ATLASLOOT_FULLSKILL);
    text = gsub(text, "#m15#", ATLASLOOT_295);
    text = gsub(text, "#m16#", ATLASLOOT_275);
    text = gsub(text, "#m17#", ATLASLOOT_265);
    text = gsub(text, "#m18#", ATLASLOOT_290);
    text = gsub(text, "#m19#", ATLASLOOT_SET);
    text = gsub(text, "#m20#", ATLASLOOT_285);
    text = gsub(text, "#m21#", ATLASLOOT_16SLOT);

    text = gsub(text, "#x1#", ATLASLOOT_COBRAHN);
    text = gsub(text, "#x2#", ATLASLOOT_ANACONDRA);
    text = gsub(text, "#x3#", ATLASLOOT_SERPENTIS);
    text = gsub(text, "#x4#", ATLASLOOT_FANGDRUID);
    text = gsub(text, "#x5#", ATLASLOOT_PYTHAS);
    text = gsub(text, "#x6#", ATLASLOOT_VANCLEEF);
    text = gsub(text, "#x7#", ATLASLOOT_GREENSKIN);
    text = gsub(text, "#x8#", ATLASLOOT_DEFIASMINER);
    text = gsub(text, "#x9#", ATLASLOOT_DEFIASOVERSEER);
    text = gsub(text, "#x10#", ATLASLOOT_Primal_Hakkari_Kossack);
    text = gsub(text, "#x11#", ATLASLOOT_Primal_Hakkari_Shawl);
    text = gsub(text, "#x12#", ATLASLOOT_Primal_Hakkari_Bindings);
    text = gsub(text, "#x13#", ATLASLOOT_Primal_Hakkari_Sash);
    text = gsub(text, "#x14#", ATLASLOOT_Primal_Hakkari_Stanchion);
    text = gsub(text, "#x15#", ATLASLOOT_Primal_Hakkari_Aegis);
    text = gsub(text, "#x16#", ATLASLOOT_Primal_Hakkari_Girdle);
    text = gsub(text, "#x17#", ATLASLOOT_Primal_Hakkari_Armsplint);
    text = gsub(text, "#x18#", ATLASLOOT_Primal_Hakkari_Tabard);
    text = gsub(text, "#x19#", ATLASLOOT_Qiraji_Ornate_Hilt);
    text = gsub(text, "#x20#", ATLASLOOT_Qiraji_Martial_Drape);
    text = gsub(text, "#x21#", ATLASLOOT_Qiraji_Magisterial_Ring);
    text = gsub(text, "#x22#", ATLASLOOT_Qiraji_Ceremonial_Ring);
    text = gsub(text, "#x23#", ATLASLOOT_Qiraji_Regal_Drape);
    text = gsub(text, "#x24#", ATLASLOOT_Qiraji_Spiked_Hilt);
    text = gsub(text, "#x25#", ATLASLOOT_Qiraji_Bindings_of_Dominance);
    text = gsub(text, "#x26#", ATLASLOOT_Veknilashs_Circlet);
    text = gsub(text, "#x27#", ATLASLOOT_Ouros_Intact_Hide);
    text = gsub(text, "#x28#", ATLASLOOT_Husk_of_the_Old_God);
    text = gsub(text, "#x29#", ATLASLOOT_Qiraji_Bindings_of_Command);
    text = gsub(text, "#x30#", ATLASLOOT_Veklors_Diadem);
    text = gsub(text, "#x31#", ATLASLOOT_Skin_of_the_Great_Sandworm);
    text = gsub(text, "#x32#", ATLASLOOT_Carapace_of_the_Old_God);
    text = gsub(text, "#x33#", ATLASLOOT_SCARLETDEFENDER);
    text = gsub(text, "#x34#", ATLASLOOT_SCARLETTRASH);
    text = gsub(text, "#x35#", ATLASLOOT_SCARLETCHAMPION);
    text = gsub(text, "#x36#", ATLASLOOT_SCARLETCENTURION);
    text = gsub(text, "#x37#", ATLASLOOT_SCARLETHEROD);
    text = gsub(text, "#x38#", ATLASLOOT_SCARLETPROTECTOR);
    
    --Zg Sets
    text = gsub(text, "#zgs1#", ATLASLOOT_ZG_DRUID);
    text = gsub(text, "#zgs2#", ATLASLOOT_ZG_HUNTER);
    text = gsub(text, "#zgs3#", ATLASLOOT_ZG_MAGE);
    text = gsub(text, "#zgs4#", ATLASLOOT_ZG_PALADIN);
    text = gsub(text, "#zgs5#", ATLASLOOT_ZG_PRIEST);
    text = gsub(text, "#zgs6#", ATLASLOOT_ZG_ROGUE);
    text = gsub(text, "#zgs7#", ATLASLOOT_ZG_SHAMAN);
    text = gsub(text, "#zgs8#", ATLASLOOT_ZG_WARLOCK);
    text = gsub(text, "#zgs9#", ATLASLOOT_ZG_WARRIOR);
    
    --aq20 Sets
    text = gsub(text, "#aq20s1#", ATLASLOOT_AQ20_DRUID);
    text = gsub(text, "#aq20s2#", ATLASLOOT_AQ20_HUNTER);
    text = gsub(text, "#aq20s3#", ATLASLOOT_AQ20_MAGE);
    text = gsub(text, "#aq20s4#", ATLASLOOT_AQ20_PALADIN);
    text = gsub(text, "#aq20s5#", ATLASLOOT_AQ20_PRIEST);
    text = gsub(text, "#aq20s6#", ATLASLOOT_AQ20_ROGUE);
    text = gsub(text, "#aq20s7#", ATLASLOOT_AQ20_SHAMAN);
    text = gsub(text, "#aq20s8#", ATLASLOOT_AQ20_WARLOCK);
    text = gsub(text, "#aq20s9#", ATLASLOOT_AQ20_WARRIOR);
    
    --aq40 Sets
    text = gsub(text, "#aq40s1#", ATLASLOOT_AQ40_DRUID);
    text = gsub(text, "#aq40s2#", ATLASLOOT_AQ40_HUNTER);
    text = gsub(text, "#aq40s3#", ATLASLOOT_AQ40_MAGE);
    text = gsub(text, "#aq40s4#", ATLASLOOT_AQ40_PALADIN);
    text = gsub(text, "#aq40s5#", ATLASLOOT_AQ40_PRIEST);
    text = gsub(text, "#aq40s6#", ATLASLOOT_AQ40_ROGUE);
    text = gsub(text, "#aq40s7#", ATLASLOOT_AQ40_SHAMAN);
    text = gsub(text, "#aq40s8#", ATLASLOOT_AQ40_WARLOCK);
    text = gsub(text, "#aq40s9#", ATLASLOOT_AQ40_WARRIOR);
    
    --T0 Sets
    text = gsub(text, "#t0s1#", ATLASLOOT_T0_DRUID);
    text = gsub(text, "#t0s2#", ATLASLOOT_T0_HUNTER);
    text = gsub(text, "#t0s3#", ATLASLOOT_T0_MAGE);
    text = gsub(text, "#t0s4#", ATLASLOOT_T0_PALADIN);
    text = gsub(text, "#t0s5#", ATLASLOOT_T0_PRIEST);
    text = gsub(text, "#t0s6#", ATLASLOOT_T0_ROGUE);
    text = gsub(text, "#t0s7#", ATLASLOOT_T0_SHAMAN);
    text = gsub(text, "#t0s8#", ATLASLOOT_T0_WARLOCK);
    text = gsub(text, "#t0s9#", ATLASLOOT_T0_WARRIOR);
    
    --T0.5 Sets
    text = gsub(text, "#t05s1#", ATLASLOOT_T05_DRUID);
    text = gsub(text, "#t05s2#", ATLASLOOT_T05_HUNTER);
    text = gsub(text, "#t05s3#", ATLASLOOT_T05_MAGE);
    text = gsub(text, "#t05s4#", ATLASLOOT_T05_PALADIN);
    text = gsub(text, "#t05s5#", ATLASLOOT_T05_PRIEST);
    text = gsub(text, "#t05s6#", ATLASLOOT_T05_ROGUE);
    text = gsub(text, "#t05s7#", ATLASLOOT_T05_SHAMAN);
    text = gsub(text, "#t05s8#", ATLASLOOT_T05_WARLOCK);
    text = gsub(text, "#t05s9#", ATLASLOOT_T05_WARRIOR);
    
    --T1 Sets
    text = gsub(text, "#t1s1#", ATLASLOOT_T1_DRUID);
    text = gsub(text, "#t1s2#", ATLASLOOT_T1_HUNTER);
    text = gsub(text, "#t1s3#", ATLASLOOT_T1_MAGE);
    text = gsub(text, "#t1s4#", ATLASLOOT_T1_PALADIN);
    text = gsub(text, "#t1s5#", ATLASLOOT_T1_PRIEST);
    text = gsub(text, "#t1s6#", ATLASLOOT_T1_ROGUE);
    text = gsub(text, "#t1s7#", ATLASLOOT_T1_SHAMAN);
    text = gsub(text, "#t1s8#", ATLASLOOT_T1_WARLOCK);
    text = gsub(text, "#t1s9#", ATLASLOOT_T1_WARRIOR);
    
    --T2 Sets
    text = gsub(text, "#t2s1#", ATLASLOOT_T2_DRUID);
    text = gsub(text, "#t2s2#", ATLASLOOT_T2_HUNTER);
    text = gsub(text, "#t2s3#", ATLASLOOT_T2_MAGE);
    text = gsub(text, "#t2s4#", ATLASLOOT_T2_PALADIN);
    text = gsub(text, "#t2s5#", ATLASLOOT_T2_PRIEST);
    text = gsub(text, "#t2s6#", ATLASLOOT_T2_ROGUE);
    text = gsub(text, "#t2s7#", ATLASLOOT_T2_SHAMAN);
    text = gsub(text, "#t2s8#", ATLASLOOT_T2_WARLOCK);
    text = gsub(text, "#t2s9#", ATLASLOOT_T2_WARRIOR);
    
    --T3 Sets
    text = gsub(text, "#t3s1#", ATLASLOOT_T3_DRUID);
    text = gsub(text, "#t3s2#", ATLASLOOT_T3_HUNTER);
    text = gsub(text, "#t3s3#", ATLASLOOT_T3_MAGE);
    text = gsub(text, "#t3s4#", ATLASLOOT_T3_PALADIN);
    text = gsub(text, "#t3s5#", ATLASLOOT_T3_PRIEST);
    text = gsub(text, "#t3s6#", ATLASLOOT_T3_ROGUE);
    text = gsub(text, "#t3s7#", ATLASLOOT_T3_SHAMAN);
    text = gsub(text, "#t3s8#", ATLASLOOT_T3_WARLOCK);
    text = gsub(text, "#t3s9#", ATLASLOOT_T3_WARRIOR);
    
    --PvP Epic Horde Sets
    text = gsub(text, "#pvpeh1#", ATLASLOOT_PVP_EPIC_H_DRUID);
    text = gsub(text, "#pvpeh2#", ATLASLOOT_PVP_EPIC_H_HUNTER);
    text = gsub(text, "#pvpeh3#", ATLASLOOT_PVP_EPIC_H_MAGE);
    text = gsub(text, "#pvpeh4#", ATLASLOOT_PVP_EPIC_H_PRIEST);
    text = gsub(text, "#pvpeh5#", ATLASLOOT_PVP_EPIC_H_ROGUE);
    text = gsub(text, "#pvpeh6#", ATLASLOOT_PVP_EPIC_H_SHAMAN);
    text = gsub(text, "#pvpeh7#", ATLASLOOT_PVP_EPIC_H_WARLOCK);
    text = gsub(text, "#pvpeh8#", ATLASLOOT_PVP_EPIC_H_WARRIOR);
    
    --PvP Epic Alliance Sets
    text = gsub(text, "#pvpea1#", ATLASLOOT_PVP_EPIC_A_DRUID);
    text = gsub(text, "#pvpea2#", ATLASLOOT_PVP_EPIC_A_HUNTER);
    text = gsub(text, "#pvpea3#", ATLASLOOT_PVP_EPIC_A_MAGE);
    text = gsub(text, "#pvpea4#", ATLASLOOT_PVP_EPIC_A_PALADIN);
    text = gsub(text, "#pvpea5#", ATLASLOOT_PVP_EPIC_A_PRIEST);
    text = gsub(text, "#pvpea6#", ATLASLOOT_PVP_EPIC_A_ROGUE);
    text = gsub(text, "#pvpea7#", ATLASLOOT_PVP_EPIC_A_WARLOCK);
    text = gsub(text, "#pvpea8#", ATLASLOOT_PVP_EPIC_A_WARRIOR);
    
    --PvP Rare Horde Sets
    text = gsub(text, "#pvprh1#", ATLASLOOT_PVP_RARE_H_DRUID);
    text = gsub(text, "#pvprh2#", ATLASLOOT_PVP_RARE_H_HUNTER);
    text = gsub(text, "#pvprh3#", ATLASLOOT_PVP_RARE_H_MAGE);
    text = gsub(text, "#pvprh4#", ATLASLOOT_PVP_RARE_H_PRIEST);
    text = gsub(text, "#pvprh5#", ATLASLOOT_PVP_RARE_H_ROGUE);
    text = gsub(text, "#pvprh6#", ATLASLOOT_PVP_RARE_H_SHAMAN);
    text = gsub(text, "#pvprh7#", ATLASLOOT_PVP_RARE_H_WARLOCK);
    text = gsub(text, "#pvprh8#", ATLASLOOT_PVP_RARE_H_WARRIOR);
    
    --PvP Rare Alliance Sets
    text = gsub(text, "#pvpra1#", ATLASLOOT_PVP_RARE_A_DRUID);
    text = gsub(text, "#pvpra2#", ATLASLOOT_PVP_RARE_A_HUNTER);
    text = gsub(text, "#pvpra3#", ATLASLOOT_PVP_RARE_A_MAGE);
    text = gsub(text, "#pvpra4#", ATLASLOOT_PVP_RARE_A_PALADIN);
    text = gsub(text, "#pvpra5#", ATLASLOOT_PVP_RARE_A_PRIEST);
    text = gsub(text, "#pvpra6#", ATLASLOOT_PVP_RARE_A_ROGUE);
    text = gsub(text, "#pvpra7#", ATLASLOOT_PVP_RARE_A_WARLOCK);
    text = gsub(text, "#pvpra8#", ATLASLOOT_PVP_RARE_A_WARRIOR);
    
    --Misc PvP Set Text
    text = gsub(text, "#pvps1#", ATLASLOOT_PVP_EPIC_SET);
    text = gsub(text, "#pvps2#", ATLASLOOT_PVP_RARE_SET);
    
    --Text colouring
    text = gsub(text, "=q0=", "|cff9d9d9d");
    text = gsub(text, "=q1=", "|cffFFFFFF");
    text = gsub(text, "=q2=", "|cff1eff00");
    text = gsub(text, "=q3=", "|cff0070dd");
    text = gsub(text, "=q4=", "|cffa335ee");
    text = gsub(text, "=q5=", "|cffFF8000");
    text = gsub(text, "=q6=", "|cffFF0000");
    text = gsub(text, "=ds=", "|cffFFd200");
    return text;
end

--------------------------------------------------------------------------------
-- Hooked AtlasRefresh
-- Called if any change to the Atlas Frame
--------------------------------------------------------------------------------
function AtlasLoot_Refresh()
    if(Hooked_Atlas_Refresh) then
	    Hooked_Atlas_Refresh();
	    --If we are dealing with instances
	    if ( AtlasOptions.AtlasType == 1 ) then
		    local zoneID = ATLAS_DROPDOWN_LIST[AtlasOptions.AtlasZone];
		    local text;
		    --If we have atlasloot data
		    if(AtlasLootBossButtons[zoneID] ~= nil) then
			    for i = 1, 27, 1 do
                    --If we have items in the atlasloot data
				    if(AtlasLootBossButtons[zoneID][i] ~= nil and AtlasLootBossButtons[zoneID][i] ~= "") then
					    getglobal("AtlasText_"..i):Hide();
					    getglobal("AtlasBossLine_"..i):Show();
                        --Ridiculous number of special cases, need to to something to clean this up
					    if(getglobal("AtlasText_"..i):GetText() == nil and getglobal("AtlasText_"..i-1):GetText() == nil and getglobal("AtlasText_"..i-2):GetText() ~= nil) then
                            if(zoneID == "TheRuinsofAhnQiraj") then
                                getglobal("AtlasBossLine_"..i.."_Text"):SetText(GREY..ATLASLOOT_CLASS_BOOKS);
                            elseif(zoneID == "DireMaulNorth") then
                                getglobal("AtlasBossLine_"..i.."_Text"):SetText(GREY..ATLASLOOT_TRIBUTE_RUN);
                            elseif(zoneID == "WailingCaverns") then
                                getglobal("AtlasBossLine_"..i.."_Text"):SetText(GREY..ATLASLOOT_VIPERSET);
                            elseif(zoneID == "TheDeadmines") then
                                getglobal("AtlasBossLine_"..i.."_Text"):SetText(GREY..ATLASLOOT_DEFIASSET);
                            elseif(zoneID == "ScarletMonastery") then
                                getglobal("AtlasBossLine_"..i.."_Text"):SetText(GREY..ATLASLOOT_SCARLETSET);
                            elseif((zoneID == "DireMaulEast") or (zoneID == "DireMaulWest")) then
                                getglobal("AtlasBossLine_"..i.."_Text"):SetText(GREY..ATLASLOOT_DM_BOOKS);
                            elseif((zoneID == "BlackrockSpireUpper") or (zoneID == "BlackrockSpireLower") or (zoneID == "Scholomance")) then
                                getglobal("AtlasBossLine_"..i.."_Text"):SetText(GREY..ATLASLOOT_T0_SET_PIECES);
                            else
						        getglobal("AtlasBossLine_"..i.."_Text"):SetText(GREY..ATLASLOOT_TRASH_MOBS);
                            end
					    elseif(zoneID == "MoltenCore" and getglobal("AtlasBossLine_"..(i-1).."_Text"):GetText() == GREY..ATLASLOOT_TRASH_MOBS) then
                            getglobal("AtlasBossLine_"..i.."_Text"):SetText(GREY..ATLASLOOT_RANDOM_LOOT);
                        elseif(zoneID == "MoltenCore" and getglobal("AtlasBossLine_"..(i-1).."_Text"):GetText() == GREY..ATLASLOOT_RANDOM_LOOT and AtlasLootBossButtons[zoneID][i] == "T1SET") then
                            getglobal("AtlasBossLine_"..i.."_Text"):SetText(GREY..ATLASLOOT_MC_SET_PIECES);
                        elseif(zoneID == "BlackwingLair" and getglobal("AtlasBossLine_"..(i-1).."_Text"):GetText() == GREY..ATLASLOOT_TRASH_MOBS and AtlasLootBossButtons[zoneID][i] == "T2SET") then
                            getglobal("AtlasBossLine_"..i.."_Text"):SetText(GREY..ATLASLOOT_BWL_SET_PIECES);
                        elseif(zoneID == "TheTempleofAhnQiraj" and getglobal("AtlasBossLine_"..(i-1).."_Text"):GetText() == GREY..ATLASLOOT_TRASH_MOBS) then
                            getglobal("AtlasBossLine_"..i.."_Text"):SetText(GREY..ATLASLOOT_AQ_ENCHANTS);
                        elseif(zoneID == "TheTempleofAhnQiraj" and getglobal("AtlasBossLine_"..(i-1).."_Text"):GetText() == GREY..ATLASLOOT_AQ_ENCHANTS) then
                            getglobal("AtlasBossLine_"..i.."_Text"):SetText(GREY..ATLASLOOT_AQ40_CLASS_SET_PIECES_1);
                        elseif(zoneID == "TheRuinsofAhnQiraj" and getglobal("AtlasBossLine_"..(i-1).."_Text"):GetText() == GREY..ATLASLOOT_CLASS_BOOKS) then
                            getglobal("AtlasBossLine_"..i.."_Text"):SetText(GREY..ATLASLOOT_AQ_ENCHANTS);
                        elseif(zoneID == "TheRuinsofAhnQiraj" and getglobal("AtlasBossLine_"..(i-1).."_Text"):GetText() == GREY..ATLASLOOT_AQ_ENCHANTS) then
                            getglobal("AtlasBossLine_"..i.."_Text"):SetText(GREY..ATLASLOOT_AQ20_CLASS_SET_PIECES_1);
                        elseif((zoneID == "ZulGurub") and getglobal("AtlasBossLine_"..(i-1).."_Text"):GetText() == GREY..ATLASLOOT_TRASH_MOBS) then
                            getglobal("AtlasBossLine_"..i.."_Text"):SetText(GREY..ATLASLOOT_RANDOM_LOOT);
                        elseif((zoneID == "ZulGurub") and getglobal("AtlasBossLine_"..(i-1).."_Text"):GetText() == GREY..ATLASLOOT_RANDOM_LOOT) then
                            getglobal("AtlasBossLine_"..i.."_Text"):SetText(GREY..ATLASLOOT_ZG_CLASS_SET_PIECES_1);
                        elseif((zoneID == "ZulGurub") and getglobal("AtlasBossLine_"..(i-1).."_Text"):GetText() == GREY..ATLASLOOT_ZG_CLASS_SET_PIECES_1) then
                            getglobal("AtlasBossLine_"..i.."_Text"):SetText(GREY..ATLASLOOT_ZG_ENCHANTS);
                        elseif(zoneID == "DireMaulNorth" and getglobal("AtlasBossLine_"..(i-1).."_Text"):GetText() == GREY..ATLASLOOT_TRIBUTE_RUN) then
                            getglobal("AtlasBossLine_"..i.."_Text"):SetText(GREY..ATLASLOOT_DM_BOOKS);
                        elseif(zoneID == "Naxxramas" and getglobal("AtlasBossLine_"..(i-1).."_Text"):GetText() == GREY..ATLASLOOT_TRASH_MOBS and AtlasLootBossButtons[zoneID][i] == "T3SET") then
                            getglobal("AtlasBossLine_"..i.."_Text"):SetText(GREY..ATLASLOOT_NAXX_SET_PIECES);
                        else
						    getglobal("AtlasBossLine_"..i.."_Text"):SetText(getglobal("AtlasText_"..i):GetText());
					    end
                        getglobal("AtlasBossLine_"..i.."_Loot"):Show();
                        getglobal("AtlasBossLine_"..i.."_Selected"):Hide();
				    else
					    getglobal("AtlasText_"..i):Show();
					    getglobal("AtlasBossLine_"..i):Hide();
				    end
			    end
			    getglobal("AtlasLootInfo"):Show();
		    else
			    for i = 1, 27, 1 do
				    getglobal("AtlasText_"..i):Show();
				    getglobal("AtlasBossLine_"..i):Hide();
			    end
			    getglobal("AtlasLootInfo"):Hide();
		    end
        --If we are dealing with battlegrounds
        elseif ( AtlasOptions.AtlasType == 2 ) then
            zoneID = ATLAS_DROPDOWN_LIST_BG[AtlasOptions.AtlasZone];
            local text;
            if(AtlasLootBattlegrounds[zoneID] ~= nil) then
                --If we have data, just show the rep rewards where we set them.
                for i = 1, 27, 1 do
                    if(AtlasLootBattlegrounds[zoneID][i] ~= nil and AtlasLootBattlegrounds[zoneID][i] ~= "") then
                        if(getglobal("AtlasBossLine_"..(i-1).."_Text"):GetText() == GREEN..ATLASLOOT_BG_FRIENDLY) then
                            getglobal("AtlasBossLine_"..i.."_Text"):SetText(GREEN..ATLASLOOT_BG_HONORED);
                        elseif(getglobal("AtlasBossLine_"..(i-1).."_Text"):GetText() == GREEN..ATLASLOOT_BG_HONORED) then
                            getglobal("AtlasBossLine_"..i.."_Text"):SetText(GREEN..ATLASLOOT_BG_REVERED);
                        elseif(getglobal("AtlasBossLine_"..(i-1).."_Text"):GetText() == GREEN..ATLASLOOT_BG_REVERED) then
                            getglobal("AtlasBossLine_"..i.."_Text"):SetText(GREEN..ATLASLOOT_BG_EXALTED);
                        elseif(getglobal("AtlasBossLine_"..(i-1).."_Text"):GetText() == GREEN..ATLASLOOT_BG_EXALTED) then
                            getglobal("AtlasBossLine_"..i.."_Text"):SetText(GREEN..ATLASLOOT_PVP_SET_PIECES);
                        elseif(getglobal("AtlasText_"..i):GetText() == nil) then
                            getglobal("AtlasBossLine_"..i.."_Text"):SetText(GREEN..ATLASLOOT_BG_FRIENDLY);
                        end
                        getglobal("AtlasBossLine_"..i.."_Loot"):Show();
                        getglobal("AtlasBossLine_"..i.."_Selected"):Hide();
                        getglobal("AtlasText_"..i):Hide();
                        getglobal("AtlasBossLine_"..i):Show();
                    else
                        getglobal("AtlasText_"..i):Show();
					    getglobal("AtlasBossLine_"..i):Hide();
                    end
                end
                getglobal("AtlasLootInfo"):Show();
            else
                for i = 1, 27, 1 do
                    getglobal("AtlasText_"..i):Show();
				    getglobal("AtlasBossLine_"..i):Hide();
			    end
			    getglobal("AtlasLootInfo"):Hide();
            end
	    else
		    for i = 1, 27, 1 do
			    getglobal("AtlasText_"..i):Show();
			    getglobal("AtlasBossLine_"..i):Hide();
		    end
		    getglobal("AtlasLootInfo"):Hide();
	    end
	    AtlasLootItemsFrame:Hide();
    end
end

function AtlasLoot_SetMenu(setname)
    if(setname=="AQ40SET") then
        getglobal("AtlasLootItemsFrame_Druid"):Show();
        getglobal("AtlasLootItemsFrame_Druid").lootpage="AQ40Druid";
        getglobal("AtlasLootItemsFrame_Hunter"):Show();
        getglobal("AtlasLootItemsFrame_Hunter").lootpage="AQ40Hunter";
        getglobal("AtlasLootItemsFrame_Mage"):Show();
        getglobal("AtlasLootItemsFrame_Mage").lootpage="AQ40Mage";
        getglobal("AtlasLootItemsFrame_Paladin"):Show();
        getglobal("AtlasLootItemsFrame_Paladin").lootpage="AQ40Paladin";
        getglobal("AtlasLootItemsFrame_Priest"):Show();
        getglobal("AtlasLootItemsFrame_Priest").lootpage="AQ40Priest";
        getglobal("AtlasLootItemsFrame_Rogue"):Show();
        getglobal("AtlasLootItemsFrame_Rogue").lootpage="AQ40Rogue";
        getglobal("AtlasLootItemsFrame_Shaman"):Show();
        getglobal("AtlasLootItemsFrame_Shaman").lootpage="AQ40Shaman";
        getglobal("AtlasLootItemsFrame_Warlock"):Show();
        getglobal("AtlasLootItemsFrame_Warlock").lootpage="AQ40Warlock";
        getglobal("AtlasLootItemsFrame_Warrior"):Show();
        getglobal("AtlasLootItemsFrame_Warrior").lootpage="AQ40Warrior";
        getglobal("AtlasLootItemsFrame_BACK"):Hide();
        getglobal("AtlasLootItemsFrame_BACK").setname="AQ40SET";
        AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_AQ40_SETS);
        AtlasLootItemsFrame:Show();
    elseif(setname=="AQ20SET") then
        getglobal("AtlasLootItemsFrame_Druid"):Show();
        getglobal("AtlasLootItemsFrame_Druid").lootpage="AQ20Druid";
        getglobal("AtlasLootItemsFrame_Hunter"):Show();
        getglobal("AtlasLootItemsFrame_Hunter").lootpage="AQ20Hunter";
        getglobal("AtlasLootItemsFrame_Mage"):Show();
        getglobal("AtlasLootItemsFrame_Mage").lootpage="AQ20Mage";
        getglobal("AtlasLootItemsFrame_Paladin"):Show();
        getglobal("AtlasLootItemsFrame_Paladin").lootpage="AQ20Paladin";
        getglobal("AtlasLootItemsFrame_Priest"):Show();
        getglobal("AtlasLootItemsFrame_Priest").lootpage="AQ20Priest";
        getglobal("AtlasLootItemsFrame_Rogue"):Show();
        getglobal("AtlasLootItemsFrame_Rogue").lootpage="AQ20Rogue";
        getglobal("AtlasLootItemsFrame_Shaman"):Show();
        getglobal("AtlasLootItemsFrame_Shaman").lootpage="AQ20Shaman";
        getglobal("AtlasLootItemsFrame_Warlock"):Show();
        getglobal("AtlasLootItemsFrame_Warlock").lootpage="AQ20Warlock";
        getglobal("AtlasLootItemsFrame_Warrior"):Show();
        getglobal("AtlasLootItemsFrame_Warrior").lootpage="AQ20Warrior";
        getglobal("AtlasLootItemsFrame_BACK"):Hide();
        getglobal("AtlasLootItemsFrame_BACK").setname="AQ20SET";
        AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_AQ20_SETS);
        AtlasLootItemsFrame:Show();
    elseif(setname=="ZGSET") then
        getglobal("AtlasLootItemsFrame_Druid"):Show();
        getglobal("AtlasLootItemsFrame_Druid").lootpage="ZGDruid";
        getglobal("AtlasLootItemsFrame_Hunter"):Show();
        getglobal("AtlasLootItemsFrame_Hunter").lootpage="ZGHunter";
        getglobal("AtlasLootItemsFrame_Mage"):Show();
        getglobal("AtlasLootItemsFrame_Mage").lootpage="ZGMage";
        getglobal("AtlasLootItemsFrame_Paladin"):Show();
        getglobal("AtlasLootItemsFrame_Paladin").lootpage="ZGPaladin";
        getglobal("AtlasLootItemsFrame_Priest"):Show();
        getglobal("AtlasLootItemsFrame_Priest").lootpage="ZGPriest";
        getglobal("AtlasLootItemsFrame_Rogue"):Show();
        getglobal("AtlasLootItemsFrame_Rogue").lootpage="ZGRogue";
        getglobal("AtlasLootItemsFrame_Shaman"):Show();
        getglobal("AtlasLootItemsFrame_Shaman").lootpage="ZGShaman";
        getglobal("AtlasLootItemsFrame_Warlock"):Show();
        getglobal("AtlasLootItemsFrame_Warlock").lootpage="ZGWarlock";
        getglobal("AtlasLootItemsFrame_Warrior"):Show();
        getglobal("AtlasLootItemsFrame_Warrior").lootpage="ZGWarrior";
        getglobal("AtlasLootItemsFrame_BACK"):Hide();
        getglobal("AtlasLootItemsFrame_BACK").setname="ZGSET";
        AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_ZG_SETS);
        AtlasLootItemsFrame:Show();
    elseif(setname=="T3SET") then
        getglobal("AtlasLootItemsFrame_Druid"):Show();
        getglobal("AtlasLootItemsFrame_Druid").lootpage="T3Druid";
        getglobal("AtlasLootItemsFrame_Hunter"):Show();
        getglobal("AtlasLootItemsFrame_Hunter").lootpage="T3Hunter";
        getglobal("AtlasLootItemsFrame_Mage"):Show();
        getglobal("AtlasLootItemsFrame_Mage").lootpage="T3Mage";
        getglobal("AtlasLootItemsFrame_Paladin"):Show();
        getglobal("AtlasLootItemsFrame_Paladin").lootpage="T3Paladin";
        getglobal("AtlasLootItemsFrame_Priest"):Show();
        getglobal("AtlasLootItemsFrame_Priest").lootpage="T3Priest";
        getglobal("AtlasLootItemsFrame_Rogue"):Show();
        getglobal("AtlasLootItemsFrame_Rogue").lootpage="T3Rogue";
        getglobal("AtlasLootItemsFrame_Shaman"):Show();
        getglobal("AtlasLootItemsFrame_Shaman").lootpage="T3Shaman";
        getglobal("AtlasLootItemsFrame_Warlock"):Show();
        getglobal("AtlasLootItemsFrame_Warlock").lootpage="T3Warlock";
        getglobal("AtlasLootItemsFrame_Warrior"):Show();
        getglobal("AtlasLootItemsFrame_Warrior").lootpage="T3Warrior";
        getglobal("AtlasLootItemsFrame_BACK"):Hide();
        getglobal("AtlasLootItemsFrame_BACK").setname="T3SET";
        AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_TIER3_SETS);
        AtlasLootItemsFrame:Show();
    elseif(setname=="T2SET") then
        getglobal("AtlasLootItemsFrame_Druid"):Show();
        getglobal("AtlasLootItemsFrame_Druid").lootpage="T2Druid";
        getglobal("AtlasLootItemsFrame_Hunter"):Show();
        getglobal("AtlasLootItemsFrame_Hunter").lootpage="T2Hunter";
        getglobal("AtlasLootItemsFrame_Mage"):Show();
        getglobal("AtlasLootItemsFrame_Mage").lootpage="T2Mage";
        getglobal("AtlasLootItemsFrame_Paladin"):Show();
        getglobal("AtlasLootItemsFrame_Paladin").lootpage="T2Paladin";
        getglobal("AtlasLootItemsFrame_Priest"):Show();
        getglobal("AtlasLootItemsFrame_Priest").lootpage="T2Priest";
        getglobal("AtlasLootItemsFrame_Rogue"):Show();
        getglobal("AtlasLootItemsFrame_Rogue").lootpage="T2Rogue";
        getglobal("AtlasLootItemsFrame_Shaman"):Show();
        getglobal("AtlasLootItemsFrame_Shaman").lootpage="T2Shaman";
        getglobal("AtlasLootItemsFrame_Warlock"):Show();
        getglobal("AtlasLootItemsFrame_Warlock").lootpage="T2Warlock";
        getglobal("AtlasLootItemsFrame_Warrior"):Show();
        getglobal("AtlasLootItemsFrame_Warrior").lootpage="T2Warrior";
        getglobal("AtlasLootItemsFrame_BACK"):Hide();
        getglobal("AtlasLootItemsFrame_BACK").setname="T2SET";
        AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_TIER2_SETS);
        AtlasLootItemsFrame:Show();
    elseif(setname=="T1SET") then
        getglobal("AtlasLootItemsFrame_Druid"):Show();
        getglobal("AtlasLootItemsFrame_Druid").lootpage="T1Druid";
        getglobal("AtlasLootItemsFrame_Hunter"):Show();
        getglobal("AtlasLootItemsFrame_Hunter").lootpage="T1Hunter";
        getglobal("AtlasLootItemsFrame_Mage"):Show();
        getglobal("AtlasLootItemsFrame_Mage").lootpage="T1Mage";
        getglobal("AtlasLootItemsFrame_Paladin"):Show();
        getglobal("AtlasLootItemsFrame_Paladin").lootpage="T1Paladin";
        getglobal("AtlasLootItemsFrame_Priest"):Show();
        getglobal("AtlasLootItemsFrame_Priest").lootpage="T1Priest";
        getglobal("AtlasLootItemsFrame_Rogue"):Show();
        getglobal("AtlasLootItemsFrame_Rogue").lootpage="T1Rogue";
        getglobal("AtlasLootItemsFrame_Shaman"):Show();
        getglobal("AtlasLootItemsFrame_Shaman").lootpage="T1Shaman";
        getglobal("AtlasLootItemsFrame_Warlock"):Show();
        getglobal("AtlasLootItemsFrame_Warlock").lootpage="T1Warlock";
        getglobal("AtlasLootItemsFrame_Warrior"):Show();
        getglobal("AtlasLootItemsFrame_Warrior").lootpage="T1Warrior";
        getglobal("AtlasLootItemsFrame_BACK"):Hide();
        getglobal("AtlasLootItemsFrame_BACK").setname="T1SET";
        AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_TIER1_SETS);
        AtlasLootItemsFrame:Show();
    elseif(setname=="T0SET") then
        getglobal("AtlasLootItemsFrame_Druid"):Show();
        getglobal("AtlasLootItemsFrame_Druid").lootpage="T0Druid";
        getglobal("AtlasLootItemsFrame_Hunter"):Show();
        getglobal("AtlasLootItemsFrame_Hunter").lootpage="T0Hunter";
        getglobal("AtlasLootItemsFrame_Mage"):Show();
        getglobal("AtlasLootItemsFrame_Mage").lootpage="T0Mage";
        getglobal("AtlasLootItemsFrame_Paladin"):Show();
        getglobal("AtlasLootItemsFrame_Paladin").lootpage="T0Paladin";
        getglobal("AtlasLootItemsFrame_Priest"):Show();
        getglobal("AtlasLootItemsFrame_Priest").lootpage="T0Priest";
        getglobal("AtlasLootItemsFrame_Rogue"):Show();
        getglobal("AtlasLootItemsFrame_Rogue").lootpage="T0Rogue";
        getglobal("AtlasLootItemsFrame_Shaman"):Show();
        getglobal("AtlasLootItemsFrame_Shaman").lootpage="T0Shaman";
        getglobal("AtlasLootItemsFrame_Warlock"):Show();
        getglobal("AtlasLootItemsFrame_Warlock").lootpage="T0Warlock";
        getglobal("AtlasLootItemsFrame_Warrior"):Show();
        getglobal("AtlasLootItemsFrame_Warrior").lootpage="T0Warrior";
        getglobal("AtlasLootItemsFrame_BACK"):Hide();
        getglobal("AtlasLootItemsFrame_BACK").setname="T0SET";
        AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_TIER0_SETS);
        AtlasLootItemsFrame:Show();
    elseif(setname=="PVPSET") then
        getglobal("AtlasLootItemsFrame_Druid"):Show();
        getglobal("AtlasLootItemsFrame_Druid").lootpage="PVPDruid";
        getglobal("AtlasLootItemsFrame_Hunter"):Show();
        getglobal("AtlasLootItemsFrame_Hunter").lootpage="PVPHunter";
        getglobal("AtlasLootItemsFrame_Mage"):Show();
        getglobal("AtlasLootItemsFrame_Mage").lootpage="PVPMage";
        getglobal("AtlasLootItemsFrame_Paladin"):Show();
        getglobal("AtlasLootItemsFrame_Paladin").lootpage="PVPPaladin";
        getglobal("AtlasLootItemsFrame_Priest"):Show();
        getglobal("AtlasLootItemsFrame_Priest").lootpage="PVPPriest";
        getglobal("AtlasLootItemsFrame_Rogue"):Show();
        getglobal("AtlasLootItemsFrame_Rogue").lootpage="PVPRogue";
        getglobal("AtlasLootItemsFrame_Shaman"):Show();
        getglobal("AtlasLootItemsFrame_Shaman").lootpage="PVPShaman";
        getglobal("AtlasLootItemsFrame_Warlock"):Show();
        getglobal("AtlasLootItemsFrame_Warlock").lootpage="PVPWarlock";
        getglobal("AtlasLootItemsFrame_Warrior"):Show();
        getglobal("AtlasLootItemsFrame_Warrior").lootpage="PVPWarrior";
        getglobal("AtlasLootItemsFrame_BACK"):Hide();
        getglobal("AtlasLootItemsFrame_BACK").setname="PVPSET";
        AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_PVP_SET_PIECES_HEADER);
        AtlasLootItemsFrame:Show();
    end
    for i=1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
end

--------------------------------------------------------------------------------
-- Deal with items sets
--------------------------------------------------------------------------------
function AtlasLoot_Set(setname)
    if(setname~=nil) then
        AtlasLoot_SetMenu(setname);
    elseif(this:GetName()=="AtlasLootItemsFrame_BACK") then
        AtlasLoot_SetMenu(this.setname);
    else
        getglobal("AtlasLootItemsFrame_Druid"):Hide();
        getglobal("AtlasLootItemsFrame_Hunter"):Hide();
        getglobal("AtlasLootItemsFrame_Mage"):Hide();
        getglobal("AtlasLootItemsFrame_Paladin"):Hide();
        getglobal("AtlasLootItemsFrame_Priest"):Hide();
        getglobal("AtlasLootItemsFrame_Rogue"):Hide();
        getglobal("AtlasLootItemsFrame_Shaman"):Hide();
        getglobal("AtlasLootItemsFrame_Warlock"):Hide();
        getglobal("AtlasLootItemsFrame_Warrior"):Hide();
        if(getglobal("AtlasLootItemsFrame_BACK").setname=="AQ40SET") then
            AtlasLoot_ShowItemsFrame(this.lootpage, AtlasLootItems, this:GetText(), AtlasLoot_AnchorFrame);
        elseif(getglobal("AtlasLootItemsFrame_BACK").setname=="AQ20SET") then
            AtlasLoot_ShowItemsFrame(this.lootpage, AtlasLootItems, this:GetText(), AtlasLoot_AnchorFrame);
        elseif(getglobal("AtlasLootItemsFrame_BACK").setname=="ZGSET") then
            AtlasLoot_ShowItemsFrame(this.lootpage, AtlasLootItems, this:GetText(), AtlasLoot_AnchorFrame);
        elseif(getglobal("AtlasLootItemsFrame_BACK").setname=="T3SET") then
            AtlasLoot_ShowItemsFrame(this.lootpage, AtlasLootItems, this:GetText(), AtlasLoot_AnchorFrame);
        elseif(getglobal("AtlasLootItemsFrame_BACK").setname=="T2SET") then
            AtlasLoot_ShowItemsFrame(this.lootpage, AtlasLootItems, this:GetText(), AtlasLoot_AnchorFrame);
        elseif(getglobal("AtlasLootItemsFrame_BACK").setname=="T1SET") then
            AtlasLoot_ShowItemsFrame(this.lootpage, AtlasLootItems, this:GetText(), AtlasLoot_AnchorFrame);
        elseif(getglobal("AtlasLootItemsFrame_BACK").setname=="T0SET") then
            AtlasLoot_ShowItemsFrame(this.lootpage, AtlasLootItems, this:GetText(), AtlasLoot_AnchorFrame);
        elseif(getglobal("AtlasLootItemsFrame_BACK").setname=="PVPSET") then
            AtlasLoot_ShowItemsFrame(this.lootpage, AtlasLootBGItems, this:GetText(), AtlasLoot_AnchorFrame);
        end
        getglobal("AtlasLootItemsFrame_BACK"):Show();
    end
end

--------------------------------------------------------------------------------
-- Click on boss line
--------------------------------------------------------------------------------
function AtlasLootBoss_OnClick(id)
	AtlasLootItemsFrame:Hide();
	AtlasLootItemsFrame.externalBoss = nil;
	AtlasLoot_AnchorFrame = AtlasFrame;		-- Added
	
	if ( ( AtlasLootItemsFrame.activeBoss ) and ( AtlasLootItemsFrame.activeBoss == id ) ) then
		AtlasLootItemsFrame.activeBoss = nil;
		getglobal("AtlasBossLine_"..id.."_Loot"):Show();
		getglobal("AtlasBossLine_"..id.."_Selected"):Hide();
	else
		AtlasLootItemsFrame.activeBoss = id;

		for i = 1, 27, 1 do
			getglobal("AtlasBossLine_"..i.."_Loot"):Show();
			getglobal("AtlasBossLine_"..i.."_Selected"):Hide();
		end

		local _,_,boss = string.find(getglobal("AtlasBossLine_"..id.."_Text"):GetText(), "|c%x%x%x%x%x%x%x%x%s*[%dX]*[%) ]*(.*[^%,])[%,]?$");

		if ( AtlasOptions.AtlasType == 1 ) then
			local zoneID = ATLAS_DROPDOWN_LIST[AtlasOptions.AtlasZone];
			local dataID = AtlasLootBossButtons[zoneID][id];
			AtlasLoot_ShowItemsFrame(dataID, AtlasLootItems, "|cffFFd200Boss: |cffFFFFFF"..boss);

		elseif( AtlasOptions.AtlasType == 2 ) then
			zoneID = ATLAS_DROPDOWN_LIST_BG[AtlasOptions.AtlasZone];
			local dataID = AtlasLootBattlegrounds[zoneID][id];
			AtlasLoot_ShowItemsFrame(dataID, AtlasLootBGItems, "|cffFFFFFF"..boss);
		end

		getglobal("AtlasBossLine_"..id.."_Loot"):Hide();
		getglobal("AtlasBossLine_"..id.."_Selected"):Show();

		AtlasLoot_SetItemInfoFrame();
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Code below placed in own function to allow calls from external sources as well as from AtlasLootBoss_OnClick(id)
-- The function now accepts :
--    1.) the internal lootid that is basically the key for a 'Boss'
--    2.) the AtlasLoot data array that should be examined for information on the 'Boss'
--    3.) the name of the 'Boss' to be displayed at the top of the AtlasLootItemsFrame
--    4.) a data structure detailing the frame to which the AtlasLootItemsFrame should be attached, and how it should
--          be anchored.  This argument can be ommitted, and the default AtlasFrame will be used.
-- This approach is currently dependant on the data structures being identical for BattleGrounds and Instances, and whatever
-- new data stores are added in the future.  If new or different data structures are added in any new categories
-- such as Exteranl Raid Bosses, then the code below should be changed to make sure it can handle that data also.
-------------------------------------------------------------------------------------------------------------------
function AtlasLoot_ShowItemsFrame(dataID, dataSource, boss, pFrame)

	local itemName, itemLink, itemQuality, itemLevel, itemType, itemSubType, itemCount, itemEquipLoc, itemTexture, itemColor;
	local iconFrame, nameFrame, extraFrame;
	local text, extra;

    if(dataID=="AQ40SET") then
        AtlasLoot_Set("AQ40SET");
    elseif(dataID=="AQ20SET") then
        AtlasLoot_Set("AQ20SET");
    elseif(dataID=="ZGSET") then
        AtlasLoot_Set("ZGSET");
    elseif(dataID=="T3SET") then
        AtlasLoot_Set("T3SET");
    elseif(dataID=="T2SET") then
        AtlasLoot_Set("T2SET");
    elseif(dataID=="T1SET") then
        AtlasLoot_Set("T1SET");
    elseif(dataID=="T0SET") then
        AtlasLoot_Set("T0SET");
    elseif(dataID=="PVPSET") then
        AtlasLoot_Set("PVPSET");
    else
	    for i = 1, 30, 1 do
		    if(dataSource[dataID][i] ~= nil and dataSource[dataID][i][3] ~= "") then
			    itemName, itemLink, itemQuality, itemLevel, itemType, itemSubType, itemCount, itemEquipLoc, itemTexture = GetItemInfo(dataSource[dataID][i][1]);
			    if(GetItemInfo(dataSource[dataID][i][1])) then
				    _, _, _, itemColor = GetItemQualityColor(itemQuality);
				    text = itemColor..itemName;
			    else
				    text = dataSource[dataID][i][3];
                    text = AtlasLoot_FixText(text);
                end

			    extra = dataSource[dataID][i][4];
                extra = AtlasLoot_FixText(extra);
                if((not GetItemInfo(dataSource[dataID][i][1])) and (dataSource[dataID][i][1] ~= 0)) then
                    extra = extra..ATLASLOOT_NO_ITEMINFO;
                end
		
			    iconFrame  = getglobal("AtlasLootItem_"..i.."_Icon");
			    nameFrame  = getglobal("AtlasLootItem_"..i.."_Name");
			    extraFrame = getglobal("AtlasLootItem_"..i.."_Extra");
			
			    iconFrame:SetTexture("Interface\\Icons\\"..dataSource[dataID][i][2]);
			    nameFrame:SetText(text);
			    extraFrame:SetText(extra);
	
			    getglobal("AtlasLootItem_"..i).itemID = dataSource[dataID][i][1];
			    getglobal("AtlasLootItem_"..i).storeID = dataSource[dataID][i][1];
			    getglobal("AtlasLootItem_"..i).droprate = dataSource[dataID][i][5];
			    getglobal("AtlasLootItem_"..i).i = 1;
			    getglobal("AtlasLootItem_"..i):Show();
		    else
			    getglobal("AtlasLootItem_"..i):Hide();
		    end
	    end
    getglobal("AtlasLootItemsFrame_Druid"):Hide();
    getglobal("AtlasLootItemsFrame_Hunter"):Hide();
    getglobal("AtlasLootItemsFrame_Mage"):Hide();
    getglobal("AtlasLootItemsFrame_Paladin"):Hide();
    getglobal("AtlasLootItemsFrame_Priest"):Hide();
    getglobal("AtlasLootItemsFrame_Rogue"):Hide();
    getglobal("AtlasLootItemsFrame_Shaman"):Hide();
    getglobal("AtlasLootItemsFrame_Warlock"):Hide();
    getglobal("AtlasLootItemsFrame_Warrior"):Hide();
    getglobal("AtlasLootItemsFrame_BACK"):Hide();
	AtlasLoot_BossName:SetText(boss);
    end
	AtlasLoot_SetItemInfoFrame(pFrame);	-- New function to Show the frame, dependant on which frame you want to attach it to
	    -- pFrame can be a 'nil' value, and the AtlasFrame will be used by default
end

--------------------------------------------------------------------------------
-- Code to deal with External Requests to display the Loot Info frame
--------------------------------------------------------------------------------

function AtlasLoot_ShowBossLoot(dataID, boss, pFrame)

	AtlasLootItemsFrame:Hide();
	if ( AtlasLootItemsFrame.activeBoss ) then
		getglobal("AtlasBossLine_"..AtlasLootItemsFrame.activeBoss.."_Loot"):Show();
		getglobal("AtlasBossLine_"..AtlasLootItemsFrame.activeBoss.."_Selected"):Hide();
		AtlasLootItemsFrame.activeBoss = nil;
	end

	if ( dataID == AtlasLootItemsFrame.externalBoss ) then
		AtlasLootItemsFrame.externalBoss = nil;

	else

		-- The approach below is dependant on 'boss' IDs being Globally Unique
		-- i.e. the same 'boss' ID can not be used in both the Instance data and the BG data
		--      if it is, then this code will only ever fetch the BG data
	
		local dataSource = AtlasLootItems;	-- Instance data used as default

		if ( AtlasLootBGItems[dataID] ) then	-- but replace with BG data if 'boss' found there
			dataSource = AtlasLootBGItems;

-- ------------ elseif ( item exists in any new arrays added in the future such as External Raid Bosses ) then ......

		end

		AtlasLoot_AnchorFrame = pFrame;		-- Added
		AtlasLootItemsFrame.externalBoss = dataID;
		AtlasLoot_ShowItemsFrame(dataID, dataSource, boss, pFrame);
	end

end

--------------------------------------------------------------------------------
-- Options
--------------------------------------------------------------------------------
function AtlasLootOptions_Init()
    --Initialise all the check boxes on the options frame
	AtlasLootOptionsFrameSafeLinks:SetChecked(AtlasLootOptions.SafeLinks);
	AtlasLootOptionsFrameAllLinks:SetChecked(AtlasLootOptions.AllLinks);
	AtlasLootOptionsFrameDefaultTT:SetChecked(AtlasLootOptions.DefaultTT);
	AtlasLootOptionsFrameLootlinkTT:SetChecked(AtlasLootOptions.LootlinkTT);
	AtlasLootOptionsFrameItemSyncTT:SetChecked(AtlasLootOptions.ItemSyncTT);
    AtlasLootOptionsFrameEquipCompare:SetChecked(AtlasLootOptions.EquipCompare);
end

function AtlasLootOptions_OnLoad()
    --Disable checkboxes of missing addons
    if( not LootLink_SetTooltip ) then
        AtlasLootOptionsFrameLootlinkTT:Disable();
        AtlasLootOptionsFrameLootlinkTTText:SetText(ATLASLOOT_OPTIONS_LOOTLINK_TOOLTIPS_DISABLED);
    end
    if( not ISYNC_VERSION ) then
        AtlasLootOptionsFrameItemSyncTT:Disable();
        AtlasLootOptionsFrameItemSyncTTText:SetText(ATLASLOOT_OPTIONS_ITEMSYNC_TOOLTIPS_DISABLED);
    end
    if( not EquipCompare_RegisterTooltip ) then
        AtlasLootOptionsFrameEquipCompare:Disable();
        AtlasLootOptionsFrameEquipCompareText:SetText(ATLASLOOT_OPTIONS_EQUIPCOMPARE_DISABLED);
    end
    AtlasLootOptions_Init();
    temp=AtlasLootOptions.SafeLinks;
    UIPanelWindows['AtlasLootOptionsFrame'] = {area = 'center', pushable = 0};
end

--Functions for toggling options check boxes.
function AtlasLootOptions_SafeLinksToggle()
	if(AtlasLootOptions.SafeLinks) then
		AtlasLootOptions.SafeLinks = false;
	else
		AtlasLootOptions.SafeLinks = true;
        AtlasLootOptions.AllLinks = false;
	end
	AtlasLootOptions_Init();
end

function AtlasLootOptions_AllLinksToggle()
	if(AtlasLootOptions.AllLinks) then
		AtlasLootOptions.AllLinks = false;
	else
		AtlasLootOptions.AllLinks = true;
        AtlasLootOptions.SafeLinks = false;
	end
	AtlasLootOptions_Init();
end

function AtlasLootOptions_DefaultTTToggle()
	AtlasLootOptions.DefaultTT = true;
    AtlasLootOptions.LootlinkTT = false;
    AtlasLootOptions.ItemSyncTT = false;
	AtlasLootOptions_Init();
end

function AtlasLootOptions_LootlinkTTToggle()
	AtlasLootOptions.DefaultTT = false;
    AtlasLootOptions.LootlinkTT = true;
    AtlasLootOptions.ItemSyncTT = false;
	AtlasLootOptions_Init();
end

function AtlasLootOptions_ItemSyncTTToggle()
    AtlasLootOptions.DefaultTT = false;
    AtlasLootOptions.LootlinkTT = false;
    AtlasLootOptions.ItemSyncTT = true;
	AtlasLootOptions_Init();
end

function AtlasLootOptions_EquipCompareToggle()
    if(AtlasLootOptions.EquipCompare) then
        AtlasLootOptions.EquipCompare = false;
        EquipCompare_UnregisterTooltip(AtlasLootTooltip);
    else
        AtlasLootOptions.EquipCompare = true;
        EquipCompare_RegisterTooltip(AtlasLootTooltip);
    end
	AtlasLootOptions_Init();
end

--------------------------------------------------------------------------------
-- Setup Atlas Dependant XML Components
--------------------------------------------------------------------------------

function AtlasLoot_SetupForAtlas()

	AtlasLootBossLinesFrame:ClearAllPoints();
	AtlasLootBossLinesFrame:SetParent(AtlasFrame);
	AtlasLootBossLinesFrame:SetPoint("TOPLEFT", "AtlasText_ZoneName", "TOPLEFT", 0, -80);

	for i=1, ATLAS_LOOT_BOSS_LINES, 1 do
		getglobal("AtlasBossLine_"..i):ClearAllPoints();
		local anchorTo = "AtlasText_"..i;
		getglobal("AtlasBossLine_"..i):SetPoint("TOPLEFT", anchorTo, "TOPLEFT", 0, 0);
	end

	AtlasLootInfo:ClearAllPoints();
	AtlasLootInfo:SetParent(AtlasFrame);
	AtlasLootInfo:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 546, -50);

	AtlasLoot_SetItemInfoFrame();
	AtlasLootItemsFrame:Hide();

end

function AtlasLoot_SetItemInfoFrame(pFrame)
	if ( pFrame ) then
        if(pFrame==AtlasFrame and AtlasFrame) then
            AtlasLootItemsFrame:ClearAllPoints();
		    AtlasLootItemsFrame:SetParent(AtlasFrame);
		    AtlasLootItemsFrame:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 18, -84);
        else
		    AtlasLootItemsFrame:ClearAllPoints();
		    AtlasLootItemsFrame:SetParent(pFrame[2]);
		    AtlasLootItemsFrame:ClearAllPoints();
		    AtlasLootItemsFrame:SetPoint(pFrame[1], pFrame[2], pFrame[3], pFrame[4], pFrame[5]);
        end
	elseif ( AtlasFrame ) then
		AtlasLootItemsFrame:ClearAllPoints();
		AtlasLootItemsFrame:SetParent(AtlasFrame);
		AtlasLootItemsFrame:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 18, -84);
	else
		AtlasLootItemsFrame:ClearAllPoints();
		AtlasLootItemsFrame:SetParent(UIParent);
		AtlasLootItemsFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
	end
	AtlasLootItemsFrame:Show();
end