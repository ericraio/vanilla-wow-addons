local VERSION_MAJOR = "1";
local VERSION_MINOR = "18";
local VERSION_BOSSES = "02";
ATLASLOOT_VERSION = "|cff4169e1AtlasLoot Enhanced v"..VERSION_MAJOR.."."..VERSION_MINOR.."."..VERSION_BOSSES.."|r";
ATLASLOOT_CURRENT_ATLAS = "1.8.1";

-- Colours stored for code readability
local GREY = "|cff999999";
local RED = "|cffff0000";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";

local ATLAS_LOOT_BOSS_LINES	= 27;

AtlasLoot_AnchorFrame = AtlasFrame;	

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
        --World Bosses
        elseif ( AtlasOptions.AtlasType == 5 ) then
            zoneID = ATLAS_DROPDOWN_LIST_RE[AtlasOptions.AtlasZone];
            local text;
            if(AtlasLootWBBossButtons[zoneID] ~= nil) then
                --If we have data, just show the rep rewards where we set them.
                for i = 1, 27, 1 do
                    if(AtlasLootWBBossButtons[zoneID][i] ~= nil and AtlasLootWBBossButtons[zoneID][i] ~= "") then
                        getglobal("AtlasBossLine_"..i.."_Text"):SetText(getglobal("AtlasText_"..i):GetText());
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
            
        elseif( AtlasOptions.AtlasType == 5 ) then
			zoneID = ATLAS_DROPDOWN_LIST_RE[AtlasOptions.AtlasZone];
			local dataID = AtlasLootWBBossButtons[zoneID][id];
			AtlasLoot_ShowItemsFrame(dataID, AtlasLootWBItems, "|cffFFd200Boss: |cffFFFFFF"..boss);
            
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
    
    getglobal("AtlasLoot_Tier0Button"):Hide();
    getglobal("AtlasLoot_Tier1Button"):Hide();
    getglobal("AtlasLoot_Tier2Button"):Hide();
    getglobal("AtlasLoot_Tier3Button"):Hide();
    getglobal("AtlasLoot_ZGButton"):Hide();
    getglobal("AtlasLoot_AQ20Button"):Hide();
    getglobal("AtlasLoot_AQ40Button"):Hide();
    getglobal("AtlasLoot_PVPButton"):Hide();

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
        getglobal("AtlasLootItemsFrame_Weapons"):Hide();
        getglobal("AtlasLootItemsFrame_BACK"):Hide();
        getglobal("AtlasLootItemsFrame_NEXT"):Hide();
        getglobal("AtlasLootItemsFrame_PREV"):Hide();
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
        elseif ( AtlasLootWBItems[dataID] ) then    -- NEW 'ELSEIF'
            dataSource = AtlasLootWBItems;
        elseif ( AtlasLootSetItems[dataID] ) then    -- NEW 'ELSEIF'
            dataSource = AtlasLootSetItems;

-- ------------ elseif ( item exists in any new arrays added in the future such as External Raid Bosses ) then ......

		end

		AtlasLoot_AnchorFrame = pFrame;		-- Added
		AtlasLootItemsFrame.externalBoss = dataID;
		AtlasLoot_ShowItemsFrame(dataID, dataSource, boss, pFrame);
	end

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
    
    AtlasLootPanel:ClearAllPoints();
    AtlasLootPanel:SetParent(AtlasFrame);
    AtlasLootPanel:SetPoint("TOP", "AtlasFrame", "BOTTOM", 0, 9);

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