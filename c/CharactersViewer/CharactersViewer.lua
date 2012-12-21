--[[ Characters Viewer: View equipment and inventory of alternate characters.
    Author: Flisher
		Contributor:	Vincent of Blackhand
						Galmok
						Sinaloit
						Legorol
			

    Version: 1.03 (Cosmos Revision : $Rev: 3761 $)
    Last Changed by: $LastChangedBy: Flisher $
    Date: $Date: 2006-07-06 10:52:10 -0400 (jeu., 06 juil. 2006) $

    Official Distribution site: http://www.curse-gaming.com/mod.php?addid=490
    Also packaged in Cosmos: http://www.cosmosui.org

Planned feature for the next version:
	- Adding Bank Timestamping in the GUI
	- Adding HK/DK in the GUI
	 
	Version history:
	1.03 - Fixed the Bank Background, thank to bsmorgan for giving me the fix
	1.02 - Fixed a German Localization, thank's to Maischter from ui.worldofwar.net community
	1.01 - Merged Startust German localization file
	1.00 - Fixed a typo in the merge of the WakyHorse sex fix, note that you might have to reload each char to fix the sex data
	Version under 1.0 change are available in the readme.txt file included in the zip file.

]]--

-- Initialize the variables

local Server = GetRealmName();
CharactersViewerProfile = {};
CharactersViewerProfile[Server] = {};
CharactersViewerConfig = {};

local function print(msg) SELECTED_CHAT_FRAME:AddMessage("CV: "..msg); end

CharactersViewer = {
    -- Functions

    unregister =
        {
            Event = function ()
                for index, event in CharactersViewer.constant.event do
                    this:UnregisterEvent(event);    -- Event that will be called for initialisation of the addon
                end
				for index, event in CharactersViewer.constant.toggleEvents do
					this:UnregisterEvent(event);
				end
            end;
        };

    register =
        {  
			Event = function ()
                for index, event in CharactersViewer.constant.event do
                    this:RegisterEvent(event);      -- Event that will be called for initialisation of the addon
                end
                CharactersViewer.status.register.event = true;
            end;

            hook = function ()
                if(Sea) then
                    Sea.util.hook("Logout", "CharactersViewer.collect.all");
                    Sea.util.hook("Quit", "CharactersViewer.collect.all");
                    Sea.util.hook("GuildPlayerStatus_Update", "CharactersViewer.Note.Guild_OnUpdate");
                else
                    CharactersViewer_ORIG_Logout = Logout;
                    CharactersViewer_ORIG_Quit = Quit;
                    CharactersViewer_ORIG_GuildPlayerStatus_Update = GuildStatus_Update;

                    function Quit()
                        CharactersViewer.collect.all();
                        return CharactersViewer_ORIG_Quit();
                    end
                    function Logout()
                        CharactersViewer.collect.all();
                        return CharactersViewer_ORIG_Logout();
                    end

                    function GuildStatus_Update()
                        CharactersViewer.Note.Guild_OnUpdate();
                        CharactersViewer_ORIG_GuildPlayerStatus_Update();
                    end

                end
                CharactersViewer.status.register.hook = true;
            end;

            cosmos = function ()                                        -- Cosmos Button Support --
                if( EarthFeature_AddButton ) then
                    EarthFeature_AddButton (
                        {
                            id = "CharactersViewer";
                            name = BINDING_HEADER_CHARACTERSVIEWER;
                            subtext = CHARACTERSVIEWER_SHORT_DESC;
                            tooltip = CHARACTERSVIEWER_DESCRIPTION;
                            icon = CHARACTERSVIEWER_ICON;
                            callback = CharactersViewer.Toggle;
                            test = nil;
                        }
                    );
                    CharactersViewer.status.register.earth = true;
                elseif(Cosmos_RegisterButton) then
                    Cosmos_RegisterButton (
                        BINDING_HEADER_CHARACTERSVIEWER,
                        CHARACTERSVIEWER_SHORT_DESC,
                        CHARACTERSVIEWER_DESCRIPTION,
                        CHARACTERSVIEWER_ICON,
                        CharactersViewer.Toggle
                    );
                    CharactersViewer.status.register.cosmos = true;
                end
            end;

            myaddon = function ()                                       -- Interoperability MyAddOns --
                if(myAddOnsFrame_Register) then
                    temp =
                        {   name = 'CharactersViewer',
                            version = CharactersViewer.version.number,
                            releaseDate = CharactersViewer.version.date,
                            author = 'Flisher',
                            email = 'flisher@gmail.com',
                            website = 'http://www.curse-gaming.com/mod.php?addid=490',
                            category = MYADDONS_CATEGORY_INVENTORY,
                            optionsframe = ''
                        };
                    myAddOnsFrame_Register(temp, CHARACTERSVIEWER_USAGE_SUBCMD);
                    CharactersViewer.status.register.myaddon = true;
                end
            end;

            counselor = function ()                                     -- Counselor tip --
                if(Counselor and Counselor.registerTip) then
                    Counselor.registerTip (
                        {  id = "CharactersViewer_013";
                            addOn = "CharactersViewer";
                            type = COUNSELOR_STARTUP;
                            title = "CharactersViewer Description";
                            text = "CharactersViewer is an addons created with the purpose of displaying information about your other characters on the same server,\nYou can call the addons by typing /cv.\n\n  If the addons already know information about yout other characters, a dropdown menu will appear in your character paperdoll soo you can compare with your other character.";
                            tooltip = "What CharactersViewer can do for you!";
                        }
                    );
                    CharactersViewer.status.register.counselor = true;
                end
            end;

            ctmod = function()
                if(CT_RegisterMod) then
                    CT_RegisterMod(BINDING_HEADER_CHARACTERSVIEWER, CHARACTERSVIEWER_SHORT_DESC, 4, "Interface\\Buttons\\Button-Backpack-Up", CHARACTERSVIEWER_DESCRIPTION, "switch", "", CharactersViewer.Toggle);
                    CharactersViewer.status.register.ctmod = true;

                end
            end;

            titanmodmenu = function ()
                if(TitanModMenu_MenuItems) then
                    TitanModMenu_MenuItems["CharactersViewer"] = {
                        frame = "CharactersViewer_Frame",
                        cat = TITAN_MODMENU_CAT_INVENTORY,
                        text = BINDING_HEADER_CHARACTERSVIEWER,
                        func = "CharactersViewer_Toggle"
                        };
                    CharactersViewer.status.register.titanmodmenu = true;
                end
            end;

            slashcmd = function ()
                -- Register the SlashCommand in the system
                --! todo: Regster thing with cosmos slashcmd
                SlashCmdList["CHARACTERSVIEWER"] = function(msg)
                    CharactersViewer.SlashCmd(msg);
                end
                CharactersViewer.status.register.slashcmd = true;
            end;

        };

    onLoad = function ()
        -- Registering Event
        CharactersViewer.register.Event();

        ---- Todo: Register slashcommand with sky
        CharactersViewer.register.slashcmd();

        -- Registering with other addons --
        CharactersViewer.register.cosmos();
        CharactersViewer.register.myaddon();
        CharactersViewer.register.counselor();
        CharactersViewer.register.ctmod();
        CharactersViewer.register.titanmodmenu();
	  
    end;

    SlashCmd = function(msg)    -- CharactersViewer.SlashCmd()
        -- get the parameter from the ShashCmd
        param = CharactersViewer.library.splitstring(msg);

        if( param[0] and strlen(param[0]) > 0 ) then
            param[0] = strlower(param[0]);
        end
        if( msg and strlen(msg) > 0 ) then
            msg = strlower(msg);
        end

        if(msg == CHARACTERSVIEWER_SUBCMD_SHOW) then
            CharactersViewer_Show();

        elseif(param[0] == CHARACTERSVIEWER_SUBCMD_CLEAR) then
            -- if no param[1] (character), then assign the current one.
            if(not param[1] ) then
                param[1] = UnitName("player");  --! todo: use the new blizzard function
            end

            -- Make the first character upper, all the other lowercase.
            param[1] = string.upper(string.sub(param[1], 1,1)) .. string.lower(string.sub(param[1] , 2));

            -- Check if the data exist,
            if(CharactersViewerProfile[Server][param[1]] ~= nil) then
                -- The data is confirmed existing, we can wipe it.
                CharactersViewerProfile[Server][param[1]] = nil;

                --! Make it Sea compatible
                print(CHARACTERSVIEWER_PROFILECLEARED .. param[1]);

                -- If we cleared ourself, we will collect data
                if( param[1] == UnitName("player") ) then
                    CharactersViewer.collect.all();

                elseif( param[1] == CharactersViewer.index ) then
                    CharactersViewer.Switch();
                    CharactersViewer_PaperDoll_Dropdown2_Toggle();
                else
                    CharactersViewer_PaperDoll_Dropdown2_Toggle();
                end

            else
                -- The data isn't existing for that character
                --! Make it Sea compatible
                print(CHARACTERSVIEWER_NOT_FOUND .. param[1]);
            end

        elseif(msg == CHARACTERSVIEWER_SUBCMD_CLEARALL) then
            CharactersViewerProfile = {};
            --! todo: make it sea compliant
            print(CHARACTERSVIEWER_ALLPROFILECLEARED);
            CharactersViewer.collect.all();
            CharactersViewer.Switch();
            CharactersViewer_PaperDoll_Dropdown2_Toggle();

        elseif(msg == "") then
            CharactersViewer.Toggle();

        elseif(msg == CHARACTERSVIEWER_SUBCMD_PREVIOUS) then
            CharactersViewer.Switch(-1);

        elseif(msg == CHARACTERSVIEWER_SUBCMD_NEXT) then
            CharactersViewer.Switch(1);

        elseif(param[0] == CHARACTERSVIEWER_SUBCMD_SWITCH) then
            if(not param[1] ) then
                param[1] = UnitName("player");  --! todo: use the new blizzard function
            end
            CharactersViewer.Switch(param[1]);
        elseif(msg == CHARACTERSVIEWER_SUBCMD_LIST) then
            CharactersViewer.List();
        elseif(msg == CHARACTERSVIEWER_SUBCMD_BANK) then
            CharactersViewer.Bank.Toggle();
        elseif(msg == CHARACTERSVIEWER_SUBCMD_RESETLOC ) then
            CharactersViewer.ResetLoc();
        elseif(msg == CHARACTERSVIEWER_SUBCMD_BAGS) then
            CharactersViewer_Bags();
        elseif(msg == CHARACTERSVIEWER_SUBCMD_BAGUSE) then
            CharactersViewer_Bags('use');
        else
            print(CHARACTERSVIEWER_USAGE);
            local index, subcmdUsage;
            for index, subcmdUsage in CHARACTERSVIEWER_USAGE_SUBCMD do
                if(subcmdUsage) then
                    print(subcmdUsage);
                end
            end
        end
    end;

    Toggle = function ()                             -- Changed by Flisher 2005-06-12
        if(CharactersViewer_Frame:IsVisible()) then
            CharactersViewer.Hide();
        else
            CharactersViewer_Show();
        end
    end;

    Hide = function()
        HideUIPanel(CharactersViewer_Frame);
        CharactersViewerBankFrame:Hide();
        PlaySound("igMainMenuClose");
    end;

    ResetLoc = function()
        UIPanelWindows["CharactersViewer_Frame"] = { area = "up", pushable = 6 };
        HideUIPanel(CharactersViewer_Frame);
        ShowUIPanel(CharactersViewer_Frame);
        UIPanelWindows["CharactersViewer_Frame"] = nil;
        HideUIPanel(CharactersViewer_Frame);
        ShowUIPanel(CharactersViewer_Frame);
        CharactersViewer_Frame:SetUserPlaced();
    end;

    List = function ()
        if(CharactersViewerProfile and CharactersViewerProfile[Server]) then
            for index, item in CharactersViewerProfile[Server] do
                if(  CharactersViewerProfile[Server][index]["Type"] and CharactersViewerProfile[Server][index]["Type"] == "Self") then
                    if( CharactersViewerProfile[Server][index] and CharactersViewerProfile[Server][index]["Data"]) then
                        local output = index;
                        if(CharactersViewerProfile[Server][index]["Data"]["Id"] and CharactersViewerProfile[Server][index]["Data"]["Id"]["Class"]) then
                            output = output .. ", " .. CharactersViewerProfile[Server][index]["Data"]["Id"]["Class"];
                        end
                        if(CharactersViewerProfile[Server][index]["Data"]["Id"] and CharactersViewerProfile[Server][index]["Data"]["Id"]["Level"]) then
                            output = output .. ", " .. CharactersViewerProfile[Server][index]["Data"]["Id"]["Level"];
                        end
                        if(CharactersViewerProfile[Server][index]["Data"]["Location"] and CharactersViewerProfile[Server][index]["Data"]["Location"]["Zone"]) then
                            output = output .. ", " .. CharactersViewerProfile[Server][index]["Data"]["Location"]["Zone"];
                        end
                        if( CharactersViewerProfile[Server][index]["Data"]["Mail"] and CharactersViewerProfile[Server][index]["Data"]["Mail"]["HasNewMail"]) then
                            output = output .. ", " .. HAVE_MAIL;
                        end
                        if( CharactersViewerProfile[Server][index]["Data"]["xp"] ) then
                            local temp = CharactersViewer.library.CalcRestedXP( CharactersViewerProfile[Server][index]["Data"]["xp"] );
                            if( temp and temp.estimated > 0 ) then
                                output = output .. ", " .. temp.levelratio .. " " .. LEVEL .. " " .. CHARACTERSVIEWER_RESTED;
                            end
                            if( CharactersViewerProfile[Server][index]["Data"]["xp"]["resting"] and temp.levelratio < 1.5 ) then
                                output = output .. ", " .. CHARACTERSVIEWER_RESTING;
                            end
                        end
                        print(output);
                    end
                end
            end
        end
    end;

    Switch = function (choice)
        if(choice == nil) then
            choice = UnitName("player"); --! todo: improve
        end

        if(choice == -1 or choice == 1) then
            local current = 0;
            local i = 0;
            local temp = {};
            for j, name in CharactersViewerProfile[Server] do
                if(name["Type"] == "Self") then
                    i = i + 1;
                    temp[i] = j;
                    if(j == CharactersViewer.index ) then
                        current = i;
                    end
                end
            end
            current = current + choice;
            if(current <= 0) then
                choice = temp[i];
            elseif(current > i) then
                choice = temp[1];
            else
                choice = temp[current];
            end
        end

        -- Switch the current characterviwer character
        choice2 = string.upper(string.sub(choice, 1,1)) .. string.lower(string.sub(choice , 2));  -- Make the first character upper, all the other lowercase.
        if(CharactersViewerProfile[Server][choice] ~= nil) then
            CharactersViewer.index = choice;
            CharactersViewerCurrentIndex = CharactersViewer.index;        -- Backward compatibility
        elseif(CharactersViewerProfile[Server][choice2] ~= nil) then
            CharactersViewer.index = choice2;
            CharactersViewerCurrentIndex = CharactersViewer.index;        -- Backward compatibility
        else
            print(CHARACTERSVIEWER_NOT_FOUND .. choice);
            CharactersViewer.Hide();
        end

        if(CharactersViewer_Frame:IsVisible()) then
            CharactersViewer_Show();
        end

        if( AC_Target and AC_Target:IsVisible()) then
            AC_CV_DropDown_OnClick(name);
        end
    end;

    collect =
        {
            basic = function (target)
                local temp = {};

                -- Set the mana pool if it's a mana user
                if( UnitPowerType(target) and UnitPowerType(target) == 0 ) then
                    if( UnitManaMax(target) and UnitManaMax(target) > 0) then
                        temp["Mana"] = UnitManaMax(target);
                    else
                        temp["Mana"] = "??";
                    end
                end

                if(UnitHealthMax(target) and (UnitHealthMax(target) > 100 or target == "player") ) then
                    temp["Health"] = UnitHealthMax(target);
                else
                    temp["Health"] = "??";
                end

                if(target == "player") then
                    temp["Defense"] = UnitDefense(target);
                    -- Set the armor value
                    local baseArm, effectiveArmor, armor, positiveArm, negativeArm = UnitArmor(target);
                    temp["Armor"] = baseArm .. ":" .. (baseArm + positiveArm) .. ":" .. positiveArm; -- if they have a debuf on, don't save it
                end
                return temp;
            end;

            id = function (target)                        -- Flisher 2005-07-29
                local Race, RaceEn = UnitRace(target);
                local Class, ClassEn = UnitClass(target);
                local temp = {
                    Sex = CharactersViewer.collect.sex(target, 0),
                    SexId = CharactersViewer.collect.sex(target, 1),
                    Race = Race,
                    RaceEn = RaceEn,
                    Class = Class,
                    ClassEn = ClassEn,
                    Level = UnitLevel(target),
                    Server = Server,
                    Name = UnitName(target),              -- Added 2005-07-28 for easyness of access, by Flisher
                };
                return temp;
            end;

            location = function ()                        -- Flisher 2005-07-29
                return {
                    Zone = GetZoneText(),
                    SubZone = GetSubZoneText(),
                }

            end;

            xp = function()                                 -- Flisher 2005-07-29
                return {
                    max = UnitXPMax("player");
                    current = UnitXP("player");
                    resting = IsResting() == 1 or false;
                    bonus = GetXPExhaustion();
                    timestamp = time();
                }
            end;

            mail = function ()                              -- Flisher 2005-07-28
                local temp = {};
                temp["HasNewMail"] = HasNewMail() == 1 or false;
                --temp["nb"] = GetInboxNumItems();
                return temp;
            end;

            sex = function (target, num)                                 -- Flisher 2006-07-01, CharactersViewer.collect.sex
                local temp = "";
                temp = mod(UnitSex(target),2);
                if( (not num) or num == 0) then
                    if(temp and temp == 0) then
                        temp = MALE;
                    else
                        temp = FEMALE;
                    end
                end
                return temp;
            end;

            guild = function (target)                             -- Flisher 2005-07-28
                local temp = {};
                temp["GuildName"], temp["Title"], temp["Rank"] = GetGuildInfo(target);
                return temp;
            end;

            stats = function ()                           -- Flisher 2005-07-28
                -- "stat" is the same as effectiveStat...
                -- problem here is if they have a debuff spell on, the values saved will be wrong
                local temp = {};
                for index = 1, 5 do
                    local stat, effectiveStat, posBuff, negBuff = UnitStat("player", index);
                    temp[index] = (stat - posBuff - negBuff) .. ":" .. effectiveStat .. ":" .. posBuff .. ":" .. negBuff;
                end
                return temp;
            end;

            resistance = function ()                        -- Flisher 2005-06-28
                local temp = {};
                for index = 2, 6 do
                    local base, resistance, positive, negative = UnitResistance("player", index);
                    temp[index] = resistance;
                end
                return temp;
            end;

            combatstats = function ()                     -- Flisher 2005-06-12
                local temp = {};
                temp["D"] = GetDodgeChance();
                if( GetBlockChance() > 0) then
                    temp["B"] = GetBlockChance();
                end

                -- Get Parry Chance
                local _, class = UnitClass('player');
                if( class=="MAGE" or class=="WARLOCK" or class=="DRUID" or class=="PRIEST" ) then
                    temp["P"] = 0;
                else
                    temp["P"] = GetParryChance();
                end

                -- Get Crit Chance
                local i=0;
                repeat
                    i=i+1;
                    spellName, subSpellName = GetSpellName(i,BOOKTYPE_SPELL);
                until (spellName == ATTACK) or (not spellName)
                if(not spellName) then
                    return temp;
                end
                CharactersVTooltip:SetOwner(UIParent, "ANCHOR_NONE");
                CharactersVTooltip:SetSpell(i, BOOKTYPE_SPELL);
                local _, _, tmpStr = string.find(CharactersVTooltipTextLeft2:GetText(), '(%d+\.%d+)');
                CharactersVTooltip:Hide();
                tmpStr = string.gsub(tmpStr, ",", ".");
                temp["C"] = tmpStr;

                return temp;
            end;

            honor = function (target)                         -- Flisher 2005-06-12
                local temp = {};
                if(UnitPVPRank(target) and GetPVPRankInfo(UnitPVPRank(target)) and UnitPVPRank(target) >= 1) then
                    temp["rankName"], temp["rankNumber"] = GetPVPRankInfo(UnitPVPRank(target));
                end
						  temp["HK"],temp["DK"] = GetPVPLifetimeStats(); -- Wakyhorse HK's           
                return temp;
            end;

            Equipment = function(target)                      -- Changed by Flisher 2005-06-12
                local link, texture ;
                temp = {}
                -- Initialise the equipments
                for index = 1, 19 do
                    link = GetInventoryItemLink(target, index);
                    texture = GetInventoryItemTexture(target, index);
                    if( link ) then
                        for color, item, name in string.gfind(link, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r") do
                            if( color ~= nil and item ~= nil and name ~= nil ) then
                                temp[index] = { };
                                temp[index]["T"] = texture;
                                temp[index]["L"] = CharactersViewer.library.DeLink(link);
                                if( GetInventoryItemCount(target, index) > 1 ) then
                                    temp[index]["C"] = GetInventoryItemCount(target, index);
                                end
                            end
                        end
                    end
                end
                return temp;
            end;

            Inventory = function ()              -- Changed by Flisher 2005-06-12
                local bag, bagname, link, texture, color, item, strings, str;
                -- Reset/Initialize
                CharactersViewerProfile[Server][UnitName("player")]["Bag"] = {}

                for bag = 0,4 do
                    if(bag == 0) then
                        bagname = "Backpack";
                        CharactersViewerProfile[Server][UnitName("player")]["Bag"][bag] = { };
                        CharactersViewerProfile[Server][UnitName("player")]["Bag"][bag]["name"] = GetBagName(bag);
                        --CharactersViewerProfile[Server][UnitName("player")]["Bag"][bag]["Item"] = "Backpack";
                        CharactersViewerProfile[Server][UnitName("player")]["Bag"][bag]["Color"] = "ffffffff";
                        CharactersViewerProfile[Server][UnitName("player")]["Bag"][bag]["size"] = GetContainerNumSlots(bag);
                        -- End of warlock workaround
                        CharactersViewerProfile[Server][UnitName("player")]["Bag"][bag]["T"] = "Interface\\Buttons\\Button-Backpack-Up";
                        CharactersViewer.collect.Bag(bag);
                    else
                        link = GetInventoryItemLink("player", (bag+19));
                        texture = GetInventoryItemTexture("player", (bag+19));
                        if( link ) then
                            CharactersViewerProfile[Server][UnitName("player")]["Bag"][bag] = { };
                            CharactersViewerProfile[Server][UnitName("player")]["Bag"][bag]["name"] = GetBagName(bag);
                            CharactersViewerProfile[Server][UnitName("player")]["Bag"][bag]["size"] = GetContainerNumSlots(bag);
                            CharactersViewerProfile[Server][UnitName("player")]["Bag"][bag]["L"] = CharactersViewer.library.DeLink(link);
                            CharactersViewerProfile[Server][UnitName("player")]["Bag"][bag]["T"] = texture;
                            CharactersViewer.collect.Bag(bag);
                        end
                    end
                end
					 
					 --Kerying Gathering
						bag = KEYRING_CONTAINER;
						CharactersViewerProfile[Server][UnitName("player")]["Bag"][bag] = { };
						CharactersViewerProfile[Server][UnitName("player")]["Bag"][bag]["name"] = "Keyring";
						CharactersViewerProfile[Server][UnitName("player")]["Bag"][bag]["Color"] = "ffffffff";
						CharactersViewerProfile[Server][UnitName("player")]["Bag"][bag]["size"] = GetKeyRingSize(bag);
						CharactersViewerProfile[Server][UnitName("player")]["Bag"][bag]["T"] = "Interface\\ContainerFrame\\KeyRing-Bag-Icon";
						CharactersViewer.collect.Bag(bag);
            end;

            Bag = function (bag)                 -- CharactersViewer.collect.Bag	Changed by Flisher 2006-07-01
               local slot, strings, str, texture, itemCount, locked, quality, link, color, item, name;
					if (bag ~= KEYRING_CONTAINER) then
						totalslot = GetContainerNumSlots(bag);
					else
						totalslot = GetKeyRingSize();
					end 
					for slot = 1, totalslot do   -- loop through all slots in this bag and get items
					  CharactersViewerProfile[Server][UnitName("player")]["Bag"][bag][slot] = {};
					  texture, itemCount, locked, quality = GetContainerItemInfo(bag,slot);
					  link = GetContainerItemLink(bag, slot);
					  if( link ) then
							CharactersViewerProfile[Server][UnitName("player")]["Bag"][bag][slot]["T"] = texture;
							CharactersViewerProfile[Server][UnitName("player")]["Bag"][bag][slot]["L"] = CharactersViewer.library.DeLink(link);
							if(itemCount > 1) then
								 CharactersViewerProfile[Server][UnitName("player")]["Bag"][bag][slot]["C"] = itemCount;
							end
					  end
					end
            end;

            all = function ()                            -- Changed Flisher 2005-06-12
                local bank;
                -- Properly initialize the SavedVariable if it do not exist
                if( not CharactersViewerProfile ) then
                    CharactersViewerProfile = {};
                end
                -- Properly initialize the current realm if it do not exist
                if( not CharactersViewerProfile[Server] ) then
                    CharactersViewerProfile[Server] = {};
                end

                -- Properly initialise the current character data
                -- Bank Data protection
                if( CharactersViewerProfile[Server][UnitName("player")] and CharactersViewerProfile[Server][UnitName("player")]["Bank"]) then
                    bank = CharactersViewerProfile[Server][UnitName("player")]["Bank"];
                end

                -- GCV Data protection, requested by LordRod
                if( CharactersViewerProfile[Server][UnitName("player")] and CharactersViewerProfile[Server][UnitName("player")]["GCV"]) then
                    gcv = CharactersViewerProfile[Server][UnitName("player")]["GCV"];
                end

                -- Data Reinitialisation
                CharactersViewerProfile[Server][UnitName("player")] = {};


                -- Bank restore
                CharactersViewerProfile[Server][UnitName("player")] = {};
                if( bank ) then
                    CharactersViewerProfile[Server][UnitName("player")]["Bank"] = bank;
                end

                -- GCV restore
                if( gcv ) then
                CharactersViewerProfile[Server][UnitName("player")]["GCV"] = gcv;
                end

                -- Initialise the type
                CharactersViewerProfile[Server][UnitName("player")]["Type"] = "Self";
                CharactersViewerProfile[Server][UnitName("player")]["Timestamp"] = time();

                CharactersViewerProfile[Server][UnitName("player")]["Data"] = {
                        Type = CharactersViewerProfile[Server][UnitName("player")]["Type"];
                        Timestamp = CharactersViewerProfile[Server][UnitName("player")]["Timestamp"];
                        Money = GetMoney(),
                        Guild = CharactersViewer.collect.guild("player");
                        Resists = CharactersViewer.collect.resistance();
                        Stats = CharactersViewer.collect.stats();
                        CombatStats = CharactersViewer.collect.combatstats();
                        Mail = CharactersViewer.collect.mail(false);
                        Id = CharactersViewer.collect.id("player");
                        Location = CharactersViewer.collect.location();
                        xp = CharactersViewer.collect.xp();
                        Honor = CharactersViewer.collect.honor("player");
                        Basic = CharactersViewer.collect.basic("player");
                    }

                CharactersViewerProfile[Server][UnitName("player")]["Equipment"] = CharactersViewer.collect.Equipment("player");
                CharactersViewer.collect.Inventory();

                -- Set the status flag if data was collected at least once sicne the addon loaded
                if(not CharactersViewer.status.collected) then
                    CharactersViewer.status.collected = true;
                    CharactersViewer.Switch();
                    CharactersViewer_PaperDoll_Dropdown2_Toggle();
                end
            end;

            inspect = function ()                            -- Created by Flisher 2005-08-10
                if( UnitIsPlayer("target") and not UnitIsUnit("player", "target") and UnitName("target") ~= nil and UnitName("target") ~= UNKNOWNOBJECT and UnitName("target") ~= UKNOWNBEING ) then
                    -- Properly initialize the SavedVariable if it do not exist
                    if( not CharactersViewerProfile ) then
                        CharactersViewerProfile = {};
                    end
                    -- Properly initialize the current realm if it do not exist
                    if( not CharactersViewerProfile[Server] ) then
                        CharactersViewerProfile[Server] = {};
                    end
                    -- Properly initialise the current character data
                    CharactersViewerProfile[Server][UnitName("target")] = {};

                    -- Initialise the type
                    CharactersViewerProfile[Server][UnitName("target")]["Type"] = "Inspect";
                    CharactersViewerProfile[Server][UnitName("target")]["Timestamp"] = time();

                    CharactersViewerProfile[Server][UnitName("target")]["Data"] = {
                            Type = CharactersViewerProfile[Server][UnitName("target")]["Type"];
                            Timestamp = CharactersViewerProfile[Server][UnitName("target")]["Timestamp"];
                            Guild = CharactersViewer.collect.guild("target");
                            Id = CharactersViewer.collect.id("target");
                            Honor = CharactersViewer.collect.honor("target");
                            Basic = CharactersViewer.collect.basic("target");

                            --Money = GetMoney(),
                            --Resists = CharactersViewer.collect.resistance();
                            --Stats = CharactersViewer.collect.stats();
                            --CombatStats = CharactersViewer.collect.combatstats();
                            --Mail = CharactersViewer.collect.mail(false);
                            --Location = CharactersViewer.collect.location();
                            --xp = CharactersViewer.collect.xp();
                        }
                    CharactersViewerProfile[Server][UnitName("target")]["Equipment"] = CharactersViewer.collect.Equipment("target");
                    --CharactersViewer.collect.Inventory();

                    CharactersViewer_PaperDoll_Dropdown2_Toggle();
                end
            end;

            bank = -- CharactersViewer.collect.bank
                {   SaveItems = function ()                         -- CharactersViewer.collect.bank.SaveItems
                        local itemLink,icon,quantity,bagNum_Slots;
                        CharactersViewerProfile[Server][UnitName("player")]["Bank"] = {};
						CharactersViewerProfile[Server][UnitName("player")]["Bank"]["timestamp"] = time();  -- WakyHorse Bank Timestamp
                        CharactersViewerProfile[Server][UnitName("player")]["Bank"]["Main"] = {};
                        for num = 1, 24 do
                            itemLink = CharactersViewer.library.DeLink( GetContainerItemLink(BANK_CONTAINER, num) );
                            icon, quantity = GetContainerItemInfo(BANK_CONTAINER, num);
                            if( itemLink ) then
                                CharactersViewerProfile[Server][UnitName("player")]["Bank"]["Main"][num] =
                                {
                                    ["T"] = icon,
                                    ["L"] = itemLink
                                }
                            end
                            if(quantity and quantity > 1) then
                                CharactersViewerProfile[Server][UnitName("player")]["Bank"]["Main"][num]["C"] = quantity;
                            end
                        end
                        for bagNum = 5, 10 do
                            local bagNum_ID = BankButtonIDToInvSlotID(bagNum, 1);
                            link = GetInventoryItemLink("player", bagNum_ID);
                            texture = GetInventoryItemTexture("player", bagNum_ID);

                            if( link ) then
                                CharactersViewerProfile[Server][UnitName("player")]["Bank"][bagNum] = { };
                                CharactersViewerProfile[Server][UnitName("player")]["Bank"][bagNum]["name"] = GetBagName(bagNum);
                                CharactersViewerProfile[Server][UnitName("player")]["Bank"][bagNum]["size"] = GetContainerNumSlots(bagNum);
                                CharactersViewerProfile[Server][UnitName("player")]["Bank"][bagNum]["L"] = CharactersViewer.library.DeLink(link);
                                CharactersViewerProfile[Server][UnitName("player")]["Bank"][bagNum]["T"] = texture;
                                --CharactersViewer.collect.Bag(bag);
                            end

                            --itemLink = nil;

                            for bagItem = 1, GetContainerNumSlots(bagNum) do
                                itemLink = CharactersViewer.library.DeLink( GetContainerItemLink(bagNum, bagItem) );
                                icon, quantity = GetContainerItemInfo(bagNum, bagItem);
                                if( itemLink ) then
                                    CharactersViewerProfile[Server][UnitName("player")]["Bank"][bagNum][bagItem] =
                                    {
                                        ["L"] = itemLink,
                                        ["T"] = icon,
                                    };
                                    if(quantity and quantity > 1) then
                                        CharactersViewerProfile[Server][UnitName("player")]["Bank"][bagNum][bagItem]["C"] = quantity;
                                    end
                                end
                            end
                        end
                    end
            }
        };

    db = {
            validate = function ()
                if(CharactersViewerConfig and CharactersViewerConfig["version"] and CharactersViewerConfig["version"] == CharactersViewer.version.db ) then
                    return true;
                else
                    return false;
                end
            end;

            init = function ()					--CharactersViewer.db.init()
              CharactersViewerConfig = {};
              CharactersViewerProfile = {};
              ---- Todo: Make the display Sea Compatible
              -- Display a warning
              print(CHARACTERSVIEWER_ALLPROFILECLEARED);

              -- Update the version of the Database
              CharactersViewerConfig["version"] = CharactersViewer.version.db;

              -- Initialise the Bag Display Status, true by default
              CharactersViewerConfig["Bag_Display"] = true;
              CharactersViewerConfig["Bag_Location"] = 0;
              CharactersViewerConfig["BankBag_Display"] = true;
				  
            end;

        };

    library =                                                           -- CharactersViewer.library
        {   GetRaceFaction = function( raceEn) -- Wakyhorse Added GetRaceFaction Function Starts here
				if (raceEn == "Human" or raceEn == "Dwarf" or raceEn == "Gnome" or raceEn == "NightElf") 
					then return 1;
				end

				if (raceEn == "Orc" or raceEn == "Troll" or raceEn == "Scourge" or raceEn == "Tauren") then 
					return 2;
				end
				--print("Unknown Race "..race);
				return 3;
			end;                               -- Wakyhorse Added GetRaceFaction Function Ends here


			splitstring = function (input)                      -- CharactersViewer.library.splitstring
                local list = {};
                local i = 0;
                for w in string.gfind(input, "([^ ]+)") do
                    list[i] = w;
                    i = i + 1;
                end
                return list;
            end;

            returnColor = function (quality)                        -- CharactersViewer.library.returnColor
                color = {
                    [0] = "ff9d9d9d",    -- poor, gray
                    [1] = "ffffffff",    -- common, white
                    [2] = "ff1eff00",    -- uncommon, green
                    [3] = "ff0070dd",    -- rare, blue
                    [4] = "ffa335ee",    -- epic, purple
                    [5] = "ffff8000",    -- legendary, orange
                }
                return color[quality];
            end;

            MakeLink = function(link)                               -- CharactersViewer.library.MakeLink
                local temp = link;
                if( link and string.sub(link,1,5) == "item:") then
                    local name,_,quality = GetItemInfo(link);
                    local color = CharactersViewer.library.returnColor(quality);
                    if(name) then
                        temp = "|c"..color.."|H"..link.."|h["..name.."]|h|r";
                    else
                        temp = false;
                    end
                end
                return temp;
            end;

            DeLink = function(link)                             -- CharactersViewer.library.DeLink
                local temp = link;
                if( link and string.sub(link,1,2) == "|c") then
                    _,_,temp = strfind(link,"|H(item:%d+:%d+:%d+:%d+)|");
                end
                return temp;
            end;

            CalcRestedXP = function (data)                      -- CharactersViewer.library.CalcRestedXP
                local temp = {
                    estimated = 0;
                    levelratio = 0;
                    percentrested = 0;
                }
                if(data and data["bonus"] and data["resting"] ~= nil and data["max"] and data["timestamp"]) then
                    local speed = data.resting and 4 or 1;
                    local estimated = data.bonus;
                    if(data.timestamp < time()) then
                        estimated = data.bonus + floor((time()-data.timestamp) * data.max * 1.5 / 864000 / 4 * speed);
                        if(estimated  > (data.max * 1.5) ) then
                            estimated = (data.max * 1.5);
                        end
                    end
                    temp = {
                        estimated = estimated;
                        levelratio = floor(estimated/data.max *10)/10;
                        percentrested = floor(estimated / (data.max  *1.5) *100)/100;
                    }
                end
                return temp;
            end;

            MoneyTotal = function(faction)                             -- CharactersViewer.library.MoneyTotal
                local total = 0;
                if( CharactersViewerProfile and CharactersViewerProfile[Server] ) then
                    for index in CharactersViewerProfile[Server] do
                        if( CharactersViewerProfile[Server][index]["Data"] and CharactersViewerProfile[Server][index]["Data"]["Money"] ) then
									if (CharactersViewerProfile[Server][index]["Data"]["Id"]["RaceEn"]) then
										if ( CharactersViewer.library.GetRaceFaction(CharactersViewerProfile[Server][index]["Data"]["Id"]["RaceEn"]) == faction) then
											total = total + CharactersViewerProfile[Server][index]["Data"]["Money"];
										end
									end
                        end
                    end
                end
                return total;
            end;
        };

        Mail = {
            OnEnter = function()                -- CharactersViewer.Mail.OnEnter
                local count = "";
                GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
                if(MailTo_InFrame and MailTo_Mail and MailTo_Mail[Server][CharactersViewer.index]) then
                    count = 0;
                    for anything in MailTo_Mail[Server][CharactersViewer.index] do
                        count = count + 1;
                    end
                    count = " (" .. count ..")";
                end
                GameTooltip:SetText(HAVE_MAIL .. count .. "\n\n" .. CHARACTERSVIEWER_TOOLTIP_MAIL);
            end;

            OnClick = function(button)      -- CharactersViewer.Mail.OnClick
                if(MailTo_InFrame) then
                    if(arg1 == "LeftButton") then
                        if(MailTo_InFrame:IsVisible() ) then
                            HideUIPanel(MailTo_InFrame);
                        else
                            MailTo_inbox(CharactersViewer.index);
                        end
                    elseif(arg1 == "RightButton") then
                        --CharactersViewer.Bag.Relocate(true);
                    end
                end
            end
        };

        Bag = {                                                                     -- CharactersViewer.Bag
            Display = function()                                                -- CharactersViewer.Bag.Display
					local index2 = 0;
					for index = 0,4 do
					  getglobal("CharactersViewer_ContainerFrame" ..index ):Hide();
					  if(CharactersViewerProfile[Server][CharactersViewer.index]["Bag"][index]) then
							CharactersViewer.Bag.Draw(index, index2, "bag");
							index2 = index2 + 1;
					  end
					end

					--keyring
					getglobal("CharactersViewer_KeyringContainerFrame"):Hide();
					if(CharactersViewerProfile[Server][CharactersViewer.index]["Bag"][KEYRING_CONTAINER]) then
						CharactersViewer.Bag.Draw(KEYRING_CONTAINER, "", "keyring");
						index2 = index2 + 1;
					end			 
            end;

            Hide = function()                       -- CharactersViewer.Bag.Hide
                for index = 0,4 do
                    bagFrame = getglobal("CharactersViewer_ContainerFrame" ..index ):Hide();
                end
					 --keyring
					 bagFrame = getglobal("CharactersViewer_KeyringContainerFrame"):Hide();
            end;

            Draw = function(bagID, FrameID, option)         -- CharactersViewer.Bag.Draw
					local theBag, frame, name, bagTextureSuffix;
					if( option == "bag" ) then
					  theBag = CharactersViewerProfile[Server][CharactersViewer.index]["Bag"][bagID];
					  frame = getglobal("CharactersViewer_ContainerFrame"..(FrameID));
					  name = frame:GetName();
					  bagTextureSuffix = "";

					elseif( option == "bankbag") then
					  theBag = CharactersViewerProfile[Server][CharactersViewer.index]["Bank"][bagID];
					  frame = getglobal("CharactersViewer_BankItemsContainerFrame"..(FrameID));
					  name = frame:GetName();
					  bagTextureSuffix = "-Bank";
					elseif ( option == "keyring" ) then
					  theBag = CharactersViewerProfile[Server][CharactersViewer.index]["Bag"][KEYRING_CONTAINER];
					  frame = getglobal("CharactersViewer_KeyringContainerFrame");
					  name = frame:GetName();
					  bagTextureSuffix = "-Keyring";
					end
					frame.size = theBag.size;
					size = theBag.size;
					id = bagID;
					frame:Hide();

					local bgTextureTop = getglobal(name.."BackgroundTop");
					local bgTextureMiddle = getglobal(name.."BackgroundMiddle1");
					local bgTextureBottom = getglobal(name.."BackgroundBottom");
					local columns = NUM_CONTAINER_COLUMNS;
					local rows = ceil(size / columns);
					-- if size = 0 then its the backpack
					if ( id == 0 ) then
						--getglobal(name.."MoneyFrame"):Show();	-- not used in CV
						-- Set Backpack texture
						bgTextureTop:SetTexture("Interface\\ContainerFrame\\UI-BackpackBackground");
						bgTextureTop:SetHeight(256);
						bgTextureTop:SetTexCoord(0, 1, 0, 1);
						
						-- Hide unused textures
						for i=1, MAX_BG_TEXTURES do
							getglobal(name.."BackgroundMiddle"..i):Hide();
						end
						bgTextureBottom:Hide();
						frame:SetHeight(240);
					else
						-- Not the backpack
						-- Set whether or not its a bank bag
						local bagTextureSuffix = "";
						if ( id > NUM_BAG_FRAMES ) then
							bagTextureSuffix = "-Bank";
						elseif ( id == KEYRING_CONTAINER ) then
							bagTextureSuffix = "-Keyring";
						end
					-- Set textures
					bgTextureTop:SetTexture("Interface\\ContainerFrame\\UI-Bag-Components"..bagTextureSuffix);
					for i=1, MAX_BG_TEXTURES do
						getglobal(name.."BackgroundMiddle"..i):SetTexture("Interface\\ContainerFrame\\UI-Bag-Components"..bagTextureSuffix);
						getglobal(name.."BackgroundMiddle"..i):Hide();
					end
					bgTextureBottom:SetTexture("Interface\\ContainerFrame\\UI-Bag-Components"..bagTextureSuffix);
					-- Hide the moneyframe since its not the backpack
					--getglobal(name.."MoneyFrame"):Hide();			-- not used in CV

					local bgTextureCount, height;
					local rowHeight = 41;
					-- Subtract one, since the top texture contains one row already
					local remainingRows = rows-1;

					-- See if the bag needs the texture with two slots at the top
					local isPlusTwoBag;
					if ( mod(size,columns) == 2 ) then
						isPlusTwoBag = 1;
					end

					-- Bag background display stuff
					if ( isPlusTwoBag ) then
						bgTextureTop:SetTexCoord(0, 1, 0.189453125, 0.330078125);
						bgTextureTop:SetHeight(72);
					else
						if ( rows == 1 ) then
							-- If only one row chop off the bottom of the texture
							bgTextureTop:SetTexCoord(0, 1, 0.00390625, 0.16796875);
							bgTextureTop:SetHeight(86);
						else
							bgTextureTop:SetTexCoord(0, 1, 0.00390625, 0.18359375);
							bgTextureTop:SetHeight(94);
						end
					end
					-- Calculate the number of background textures we're going to need
					bgTextureCount = ceil(remainingRows/ROWS_IN_BG_TEXTURE);

					local middleBgHeight = 0;
					-- If one row only special case
					if ( rows == 1 ) then
						bgTextureBottom:SetPoint("TOP", bgTextureMiddle:GetName(), "TOP", 0, 0);
						bgTextureBottom:Show();
						-- Hide middle bg textures
						for i=1, MAX_BG_TEXTURES do
							getglobal(name.."BackgroundMiddle"..i):Hide();
						end
					else
						-- Try to cycle all the middle bg textures
						local firstRowPixelOffset = 9;
						local firstRowTexCoordOffset = 0.353515625;
						for i=1, bgTextureCount do
							bgTextureMiddle = getglobal(name.."BackgroundMiddle"..i);
							if ( remainingRows > ROWS_IN_BG_TEXTURE ) then
								-- If more rows left to draw than can fit in a texture then draw the max possible
								height = ( ROWS_IN_BG_TEXTURE*rowHeight ) + firstRowTexCoordOffset;
								bgTextureMiddle:SetHeight(height);
								bgTextureMiddle:SetTexCoord(0, 1, firstRowTexCoordOffset, ( height/BG_TEXTURE_HEIGHT + firstRowTexCoordOffset) );
								bgTextureMiddle:Show();
								remainingRows = remainingRows - ROWS_IN_BG_TEXTURE;
								middleBgHeight = middleBgHeight + height;
							else
								-- If not its a huge bag
								bgTextureMiddle:Show();
								height = remainingRows*rowHeight-firstRowPixelOffset;
								bgTextureMiddle:SetHeight(height);
								bgTextureMiddle:SetTexCoord(0, 1, firstRowTexCoordOffset, ( height/BG_TEXTURE_HEIGHT + firstRowTexCoordOffset) );
								middleBgHeight = middleBgHeight + height;
							end
						end
						-- Position bottom texture
						bgTextureBottom:SetPoint("TOP", bgTextureMiddle:GetName(), "BOTTOM", 0, 0);
						bgTextureBottom:Show();
					end
					-- Set the frame height
					frame:SetHeight(bgTextureTop:GetHeight()+bgTextureBottom:GetHeight()+middleBgHeight);
		        end       
                frame:SetWidth(CONTAINER_WIDTH);
                getglobal(name.."Name"):SetText(theBag.name );
                getglobal(name.."Portrait"):SetTexture(theBag.T);

--[[			
				--Special case code for keyrings
				if ( id == KEYRING_CONTAINER ) then
					getglobal(frame:GetName().."Name"):SetText(KEYRING);
					SetPortraitToTexture(frame:GetName().."Portrait", "Interface\\ContainerFrame\\KeyRing-Bag-Icon");
				else
					getglobal(frame:GetName().."Name"):SetText(GetBagName(id));
					SetBagPortaitTexture(getglobal(frame:GetName().."Portrait"), id);
				end
]]--

               for j=1, size, 1 do
						local index = size - j + 1;
						item = theBag[index];
						itemButton = getglobal(name.."Item"..j);
						-- Set first button
                  if( j == 1 ) then
						-- Anchor the first item differently if its the backpack frame
							if ( id == 0 ) then
								itemButton:SetPoint("BOTTOMRIGHT", name, "BOTTOMRIGHT", -12, 30);
							else
								itemButton:SetPoint("BOTTOMRIGHT", name, "BOTTOMRIGHT", -12, 9);
							end
						else
							if ( mod((j-1), columns) == 0 ) then
								itemButton:SetPoint("BOTTOMRIGHT", name.."Item"..(j - columns), "TOPRIGHT", 0, 4);	
							else
								itemButton:SetPoint("BOTTOMRIGHT", name.."Item"..(j - 1), "BOTTOMLEFT", -5, 0);	
							end
						end                    
					end
 
                for j = 1, size do
                    index = size - (j - 1);
                    getglobal(name.."Item"..j):SetID(100 * id + index + 100 );
                    item = theBag[index];
                    itemButton = getglobal(name.."Item"..j);
                    if( item ) then
                        SetItemButtonTexture(itemButton, item.T);
                        SetItemButtonCount(itemButton, item.C);
                    else
                        SetItemButtonTexture(itemButton,"");
                        SetItemButtonCount(itemButton, nil);
                    end
						  itemButton:Show();
                end
					for j=size + 1, 36, 1 do
						getglobal(name.."Item"..j):Hide();
					end
               frame:Show();
                --PlaySound("igBackPackOpen");
            end;

            Toggle = function ()                                                -- CharactersViewer.Bag.Toggle
                if(CharactersViewerConfig["Bag_Display"] == true) then
                    CharactersViewerConfig["Bag_Display"] = false;
                    CharactersViewer.Bag.Hide();
                else
                    CharactersViewerConfig["Bag_Display"] = true;
                    CharactersViewer.Bag.Display();
                end
            end;

            ToggleButton_OnClick = function(arg1)                       -- CharactersViewer.Bag.ToggleButton_OnClick
                if(arg1 == "LeftButton") then
                    CharactersViewer.Bag.Toggle();
                elseif(arg1 == "RightButton") then
                    --CharactersViewer_ResetBag();
                    CharactersViewer.Bag.Relocate(true);
                end
            end;

            Relocate = function(change)                                         -- CharactersViewer.Bag.Relocate
                if( change ) then
                    if( CharactersViewerConfig["Bag_Location"] == nil ) then
                        CharactersViewerConfig["Bag_Location"] = 0;
                    else
                        CharactersViewerConfig["Bag_Location"] = CharactersViewerConfig["Bag_Location"]  +1;
                        if( CharactersViewerConfig["Bag_Location"] >= 2) then
                            CharactersViewerConfig["Bag_Location"] = 0;
                        end
                    end
                end
                if( CharactersViewerConfig["Bag_Location"] == 1) then
                    -- Bag
                    CharactersViewer_ContainerFrame0:SetPoint("TOPLEFT", "CharactersViewer_Frame", "TOPRIGHT");
                    CharactersViewer_ContainerFrame1:SetPoint("TOPLEFT", "CharactersViewer_ContainerFrame0", "BOTTOMLEFT" );
                    CharactersViewer_ContainerFrame2:SetPoint("TOPLEFT", "CharactersViewer_ContainerFrame1", "BOTTOMLEFT" );
                    CharactersViewer_ContainerFrame3:SetPoint("TOPLEFT", "CharactersViewer_ContainerFrame0", "TOPRIGHT");
                    CharactersViewer_ContainerFrame4:SetPoint("TOPLEFT", "CharactersViewer_ContainerFrame3", "BOTTOMLEFT" );
                    CharactersViewer_KeyringContainerFrame:SetPoint("TOPLEFT", "CharactersViewer_ContainerFrame4", "BOTTOMLEFT" );
                    CharactersViewer_ContainerFrame0:SetUserPlaced();
                    CharactersViewer_ContainerFrame1:SetUserPlaced();
                    CharactersViewer_ContainerFrame2:SetUserPlaced();
                    CharactersViewer_ContainerFrame3:SetUserPlaced();
                    CharactersViewer_ContainerFrame4:SetUserPlaced();
                    CharactersViewer_KeyringContainerFrame:SetUserPlaced();
                else
						-- Bag
                    CharactersViewer_ContainerFrame0:SetPoint("TOPLEFT", "CharactersViewer_Frame", "TOPRIGHT");
                    CharactersViewer_ContainerFrame1:SetPoint("TOPLEFT", "CharactersViewer_ContainerFrame0", "TOPRIGHT" );
                    CharactersViewer_ContainerFrame2:SetPoint("TOPLEFT", "CharactersViewer_ContainerFrame1", "TOPRIGHT" );
                    CharactersViewer_ContainerFrame3:SetPoint("TOPLEFT", "CharactersViewer_ContainerFrame0", "BOTTOMLEFT");
                    CharactersViewer_ContainerFrame4:SetPoint("TOPLEFT", "CharactersViewer_ContainerFrame3", "TOPRIGHT" );
                    CharactersViewer_KeyringContainerFrame:SetPoint("TOPLEFT", "CharactersViewer_ContainerFrame4", "TOPRIGHT");
                    CharactersViewer_ContainerFrame0:SetUserPlaced();
                    CharactersViewer_ContainerFrame1:SetUserPlaced();
                    CharactersViewer_ContainerFrame2:SetUserPlaced();
                    CharactersViewer_ContainerFrame3:SetUserPlaced();
                    CharactersViewer_ContainerFrame4:SetUserPlaced();
                    CharactersViewer_KeyringContainerFrame:SetUserPlaced();
						  end
            end;

            Toggle_Button_OnEnter = function()                          -- CharactersViewer.Bag.ToggleButton_OnEnter
                ShowUIPanel(GameTooltip);
                GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
                GameTooltip:SetText(CHARACTERSVIEWER_TOOLTIP_BAGRESET);
            end;
        };

        Bank = {                                                                -- CharactersViewer.Bank
            Toggle = function()                                             -- CharactersViewer.Bank.Toggle
                if(CharactersViewerBankFrame:IsVisible() ) then
                    CharactersViewerConfig["Bank_Display"] = false;
                    CharactersViewer.Bank.Close()
                else
                    CharactersViewerConfig["Bank_Display"] = true;
                    CharactersViewer.Bank.Show();
                end
            end;

            Toggle_Button_OnEnter = function()                          -- CharactersViewer.Bag.ToggleButton_OnEnter
                ShowUIPanel(GameTooltip);
                GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
                GameTooltip:SetText(CHARACTERSVIEWER_TOOLTIP_BANKBAG);
            end;

            ToggleButton_OnClick = function(arg1)                       -- CharactersViewer.Bank.ToggleButton_OnClick
                if(arg1 == "LeftButton") then
                    CharactersViewer.Bank.BagToggle();
                elseif(arg1 == "RightButton") then
                    -----
                    CharactersViewer.Bank.BagRelocate(true);
                end
            end;

            BagToggle = function ()                                             -- CharactersViewer.Bag.Toggle
                if(CharactersViewerConfig["BankBag_Display"] == true) then
                    CharactersViewerConfig["BankBag_Display"] = false;
                    CharactersViewer.Bank.BagHide();
                else
                    CharactersViewerConfig["BankBag_Display"] = true;
                    CharactersViewer.Bank.BagDisplay();
                end
            end;

            BagDisplay = function ()                                            -- CharactersViewer.Bank.BagDisplay
                if( not CharactersViewer_BankItemsContainerFrame6:IsUserPlaced()
                    and not CharactersViewer_BankItemsContainerFrame6:IsUserPlaced()
                    and not CharactersViewer_BankItemsContainerFrame7:IsUserPlaced()
                    and not CharactersViewer_BankItemsContainerFrame8:IsUserPlaced()
                    and not CharactersViewer_BankItemsContainerFrame9:IsUserPlaced()
                    and not CharactersViewer_BankItemsContainerFrame10:IsUserPlaced()) then
                        CharactersViewer.Bank.BagRelocate(false)
                end

                if( CharactersViewerProfile[Server][CharactersViewer.index]["Bank"] ~= nil) then
                    local index2 = 5;
                    for index = 5,10 do
                        getglobal("CharactersViewer_BankItemsContainerFrame" ..index ):Hide();
                        --- Removed Flisher 2005-05-29 bagFrame:Hide();
                        if(CharactersViewerProfile[Server][CharactersViewer.index]["Bank"][index]) then
                            CharactersViewer.Bag.Draw(index, index2, "bankbag");
                            index2 = index2 + 1;
                        end
                    end
                end
            end;

            BagHide = function()                                                -- CharactersViewer.Bank.BagHide
                for index = 5,10 do
                    bagFrame = getglobal("CharactersViewer_BankItemsContainerFrame" ..index ):Hide();
                end
            end;

            Close = function()                                              -- CharactersViewer.Bank.Close
                CharactersViewerBankFrame:Hide();
            end;

            Show = function ()                                              -- CharactersViewer.Bank.Show
                CharactersViewerBankFrame:Hide();
                if( CharactersViewerProfile and CharactersViewerProfile[Server] and CharactersViewerProfile[Server][CharactersViewer.index] ) then
						  if( CharactersViewerProfile[Server][CharactersViewer.index]["Data"] and CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Money"] ) then
                        --MoneyFrame_Update("CharactersViewerBankItems_MoneyFrame", CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Money"]);
								temp1 = CharactersViewer.library.MoneyTotal(1);
								temp2 = CharactersViewer.library.MoneyTotal(2);
                        MoneyFrame_Update("CharactersViewerBankItems_MoneyFrameTotal1", temp1);
                        MoneyFrame_Update("CharactersViewerBankItems_MoneyFrameTotal2", temp2);
                        MoneyFrame_Update("CharactersViewerBankItems_MoneyFrameTotal3", temp1 + temp2);
								if ( temp1 <= 0 ) then
									CharactersViewerBankMoney1:Hide();
								else
									CharactersViewerBankMoney1:Show();
								end
								
								if ( temp2 <= 0 ) then
									CharactersViewerBankMoney2:Hide();
								else
									CharactersViewerBankMoney2:Show();
								end
								
								
                    end
                    if( CharactersViewerProfile[Server][CharactersViewer.index]["Bank"] ) then
                        for slot = 1, 24 do
                            button = getglobal("CharactersViewerBankItem_Item" .. slot);
                            if( CharactersViewerProfile[Server][CharactersViewer.index]["Bank"]["Main"] and CharactersViewerProfile[Server][CharactersViewer.index]["Bank"]["Main"][slot] ) then
                                SetItemButtonTexture(button, CharactersViewerProfile[Server][CharactersViewer.index]["Bank"]["Main"][slot].T);
                                SetItemButtonCount(button, CharactersViewerProfile[Server][CharactersViewer.index]["Bank"]["Main"][slot].C);
                                button:Show();
                            else
                                button:Hide();
                            end
                        end
                        for bagId = 5, 10 do
                            button = getglobal("CharactersViewerBankItems_Bag" .. bagId);
                            if( CharactersViewerProfile[Server][CharactersViewer.index]["Bank"][bagId] and CharactersViewerProfile[Server][CharactersViewer.index]["Bank"][bagId]["T"] and CharactersViewerProfile[Server][CharactersViewer.index]["Bank"][bagId]["size"]) then
                                SetItemButtonTexture(button, CharactersViewerProfile[Server][CharactersViewer.index]["Bank"][bagId].T);
                                button:Show();
                            else
                                button:Hide();
                            end

                        end

                    end
                end
                ShowUIPanel(CharactersViewerBankFrame);
            end;

            OnEnter = function()                                            -- CharactersViewer.Bank.OnEnter
                local count = "";
                GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
                GameTooltip:SetText(CHARACTERSVIEWER_TOOLTIP_BANK);
            end;

            OnClick = function(button)                                  -- CharactersViewer.Bank.OnClick
                if(arg1 == "LeftButton") then
                    CharactersViewer.Bank.Toggle();
                elseif(arg1 == "RightButton") then
                    CharactersViewer.Bank.Relocate(true);
                end
            end;

            Relocate = function ( change)                               -- CharactersViewer.Bank.Relocate
                if( CharactersViewerConfig["Bank_Location"] == 1) then
                    -- Bag
                    CharactersViewerBankFrame:SetPoint("TOPLEFT", "CharactersViewer_Frame", "TOPRIGHT");
                    CharactersViewerBankFrame:SetUserPlaced(0);
                    if( change) then
                            CharactersViewerConfig["Bank_Location"] = 0;
                    end
                else
                -- Bag
                    CharactersViewerBankFrame:SetPoint("TOPLEFT", "CharactersViewer_Frame", "BOTTOMLEFT", 0 , 64);
                    CharactersViewerBankFrame:SetUserPlaced(0);
                    if( change ) then
                        CharactersViewerConfig["Bank_Location"] = 1;
                    end
                end
            end;

            BagRelocate = function ( change, bagID )                                -- CharactersViewer.Bank.BagRelocate
                if( change ) then
                    if( CharactersViewerConfig["BankBag_Location"] == nil ) then
                        CharactersViewerConfig["BankBag_Location"] = 0;
                    else
                        CharactersViewerConfig["BankBag_Location"] = CharactersViewerConfig["BankBag_Location"]  +1;
                        if( CharactersViewerConfig["BankBag_Location"] >= 2) then
                            CharactersViewerConfig["BankBag_Location"] = 0;
                        end
                    end
                end

                if( CharactersViewerConfig["BankBag_Location"] == 1) then
                    -- Bag
                    CharactersViewer_BankItemsContainerFrame5:SetPoint("TOPLEFT", "CharactersViewerBankFrame", "TOPRIGHT" );
                    CharactersViewer_BankItemsContainerFrame6:SetPoint("TOPLEFT", "CharactersViewer_BankItemsContainerFrame5", "BOTTOMLEFT" );
                    CharactersViewer_BankItemsContainerFrame7:SetPoint("TOPLEFT", "CharactersViewer_BankItemsContainerFrame6", "BOTTOMLEFT" );
                    CharactersViewer_BankItemsContainerFrame8:SetPoint("TOPLEFT", "CharactersViewer_BankItemsContainerFrame5", "TOPRIGHT" );
                    CharactersViewer_BankItemsContainerFrame9:SetPoint("TOPLEFT", "CharactersViewer_BankItemsContainerFrame8", "BOTTOMLEFT" );
                    CharactersViewer_BankItemsContainerFrame10:SetPoint("TOPLEFT", "CharactersViewer_BankItemsContainerFrame9", "BOTTOMLEFT" );
                    CharactersViewer_BankItemsContainerFrame5:SetUserPlaced();
                    CharactersViewer_BankItemsContainerFrame6:SetUserPlaced();
                    CharactersViewer_BankItemsContainerFrame7:SetUserPlaced();
                    CharactersViewer_BankItemsContainerFrame8:SetUserPlaced();
                    CharactersViewer_BankItemsContainerFrame9:SetUserPlaced();
                    CharactersViewer_BankItemsContainerFrame10:SetUserPlaced();
                else
                -- Bag
                    CharactersViewer_BankItemsContainerFrame5:SetPoint("TOPLEFT", "CharactersViewerBankFrame", "TOPRIGHT" );
                    CharactersViewer_BankItemsContainerFrame6:SetPoint("TOPLEFT", "CharactersViewer_BankItemsContainerFrame5", "TOPRIGHT" );
                    CharactersViewer_BankItemsContainerFrame7:SetPoint("TOPLEFT", "CharactersViewer_BankItemsContainerFrame6", "TOPRIGHT" );
                    CharactersViewer_BankItemsContainerFrame8:SetPoint("TOPLEFT", "CharactersViewer_BankItemsContainerFrame5", "BOTTOMLEFT" );
                    CharactersViewer_BankItemsContainerFrame9:SetPoint("TOPLEFT", "CharactersViewer_BankItemsContainerFrame8", "TOPRIGHT" );
                    CharactersViewer_BankItemsContainerFrame10:SetPoint("TOPLEFT", "CharactersViewer_BankItemsContainerFrame9", "TOPRIGHT" );
                    CharactersViewer_BankItemsContainerFrame5:SetUserPlaced();
                    CharactersViewer_BankItemsContainerFrame6:SetUserPlaced();
                    CharactersViewer_BankItemsContainerFrame7:SetUserPlaced();
                    CharactersViewer_BankItemsContainerFrame8:SetUserPlaced();
                    CharactersViewer_BankItemsContainerFrame9:SetUserPlaced();
                    CharactersViewer_BankItemsContainerFrame10:SetUserPlaced();
                end
            end;
        };

        Note = {
            Guild_OnUpdate = function ()
                local guildOffset = FauxScrollFrame_GetOffset(GuildListScrollFrame);
                if(GuildFrameButton1:IsVisible()) then
                    for i=1, GUILDMEMBERS_TO_DISPLAY, 1 do
                        local button = getglobal("CharactersViewerGuildFrameNoteButton"..i);
                        local name = GetGuildRosterInfo(i + guildOffset);
                        if( CharactersViewerProfile and CharactersViewerProfile[Server] and CharactersViewerProfile[Server][name]) then
                            button:Show();
                        else
                            button:Hide();
                        end
                    end
                end
            end;

            Guild_OnClick = function (arg1)
                local name = GetGuildRosterInfo(this:GetID() + FauxScrollFrame_GetOffset(GuildListScrollFrame));
                if( CharactersViewer.index ~= name ) then
                    CharactersViewer.Switch(name);
                    CharactersViewer_Show();
                else
                    CharactersViewer_Toggle();
                end
            end;

            Guild_OnEnter = function ()
                ShowUIPanel(GameTooltip);
                GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
                if( CharactersViewerProfile ~= nil and CharactersViewerProfile[Server] ~= nil and CharactersViewerProfile[Server][CharactersViewer.index] ~= nil and CharactersViewerProfile[Server][CharactersViewer.index]["Timestamp"] ~= nil ) then
                    GameTooltip:SetText(BINDING_NAME_CHARACTERSVIEWER_TOGGLE .. "\n" .. CHARACTERSVIEWER_SAVEDON ..  date(nil, CharactersViewerProfile[Server][CharactersViewer.index]["Timestamp"] ) );
                else
                    GameTooltip:SetText(BINDING_NAME_CHARACTERSVIEWER_TOGGLE)
                end
            end;
        };

    -- Variables
    index = nil;    			-- is now initialised via the first data collect, which should happen before any possible call
    loaded = nil;               -- Successful load of the script
    version =
        {  db = 62;
            text = "1.03";
            number = 103;
            date = "July 6th, 2006";
        };

    constant =
        {   event = -- CharactersViewer.constant.event
                {
                    "VARIABLES_LOADED";
                    "UNIT_NAME_UPDATE";
                    "PLAYER_GUILD_UPDATE";
                    "UNIT_INVENTORY_CHANGED";
                    "PLAYER_LEVEL_UP";
                    "PLAYER_PVP_RANK_CHANGED";
                    "CHARACTER_POINTS_CHANGED";

                    "MAIL_SHOW";                    -- Mail
                    "MAIL_CLOSED";                  -- Mail

                    "BANKFRAME_OPENED";                 -- Bank
                    --"BANKFRAME_CLOSED";                   -- Bank
                    "PLAYERBANKSLOTS_CHANGED";          -- Bank
                    "PLAYERBANKBAGSLOTS_CHANGED";       -- Bank
                    "BAG_UPDATE";                           -- Bank

                    --"PLAYER_MONEY";                       -- Money
                };

            inventorySlot =
                {
                    Name =
                        {  	
							[0] = AMMOSLOT,                        -- 0
                            [1] = HEADSLOT,                       -- 1
                            [2] = NECKSLOT,                       -- 2
                            [3] = SHOULDERSLOT,                  -- 3
                            [4] = SHIRTSLOT,                         -- 4
                            [5] = CHESTSLOT,                         -- 5
                            [6] = WAISTSLOT,                         -- 6
                            [7] = LEGSSLOT,                       -- 7
                            [8] = FEETSLOT,                       -- 8
                            [9] = WRISTSLOT,                         -- 9
                            [10] = HANDSSLOT,                       -- 10
                            [11] = FINGER0SLOT,                  -- 11
                            [12] = FINGER1SLOT,                  -- 12
                            [13] = TRINKET0SLOT,                    -- 13
                            [14] = TRINKET1SLOT,                    -- 14
                            [15] = BACKSLOT,                         -- 15
                            [16] = MAINHANDSLOT,                    -- 16
                            [17] = SECONDARYHANDSLOT,            -- 17
                            [18] = RANGEDSLOT,                    -- 18
                            [19] = TABARDSLOT,                    -- 19
                        };

                    Texture =
                        {  
							[0] = ({GetInventorySlotInfo("AMMOSLOT")})[2],             -- 0
                            [1] = ({GetInventorySlotInfo("HEADSLOT")})[2],            -- 1
                            [2] = ({GetInventorySlotInfo("NECKSLOT")})[2],            -- 2
                            [3] = ({GetInventorySlotInfo("SHOULDERSLOT")})[2],       -- 3
                            [4] = ({GetInventorySlotInfo("SHIRTSLOT")})[2],          -- 4
                            [5] = ({GetInventorySlotInfo("CHESTSLOT")})[2],          -- 5
                            [6] = ({GetInventorySlotInfo("WAISTSLOT")})[2],          -- 6
                            [7] = ({GetInventorySlotInfo("LEGSSLOT")})[2],            -- 7
                            [8] = ({GetInventorySlotInfo("FEETSLOT")})[2],            -- 8
                            [9] = ({GetInventorySlotInfo("WRISTSLOT")})[2],          -- 9
                            [10] = ({GetInventorySlotInfo("HANDSSLOT")})[2],             -- 10
                            [11] = ({GetInventorySlotInfo("FINGER0SLOT")})[2],        -- 11
                            [12] = ({GetInventorySlotInfo("FINGER1SLOT")})[2],        -- 12
                            [13] = ({GetInventorySlotInfo("TRINKET0SLOT")})[2],      -- 13
                            [14] = ({GetInventorySlotInfo("TRINKET1SLOT")})[2],      -- 14
                            [15] = ({GetInventorySlotInfo("BACKSLOT")})[2],           -- 15
                            [16] = ({GetInventorySlotInfo("MAINHANDSLOT")})[2],      -- 16
                            [17] = ({GetInventorySlotInfo("SECONDARYHANDSLOT")})[2],  -- 17
                            [18] = ({GetInventorySlotInfo("RANGEDSLOT")})[2],           -- 18
                            [19] = ({GetInventorySlotInfo("TABARDSLOT")})[2],           -- 19
                        }
                    };
        };

        config = { };

        status = {
            register = {};
            -- Known status to be inserted by the code lather
            -- loaded (meaning the initial load/initialisation is done)
            -- collected (true = that the system collected data at least once
        };

        debug = {      -- Added as I can use many debug flag for developpement - Flisher 2006-06-16

        };

};   -- End of CharactersViewer Object

-- OnFoo functions

function CharactersViewer_OnEvent(event, arg1)            -- Cleaned by Flisher 2005-05-31
    if(event == "VARIABLES_LOADED" and not CharactersViewer.status.loaded) then
        -- Set the Loaded Status to true, to ensure it's not runned twice, we never know with blizzard...
        CharactersViewer.status.loaded = true;

        -- Configure the panel display and title
        tinsert(UISpecialFrames, "CharactersViewer_Frame");
        UIPanelWindows["CharactersViewer_Frame"] = nil;
        CharactersViewer_Frame:RegisterForDrag("LeftButton");

        tinsert(UISpecialFrames, "CharactersViewerBankFrame");
        UIPanelWindows["CharactersViewerBankFrame"] = nil;
        --CharactersViewer_Frame:RegisterForDrag("LeftButton");

        --UIPanelWindows["CharactersViewerBankFrame"] = { area = "up", pushable = 6 };
        CharactersViewer_FrameTitleText:SetText("CharactersViewer " .. CharactersViewer.version.text .. " by Flisher");

        -- Hooked function
        CharactersViewer.register.hook();

        -- Database version checkup, clean the data if the database version is obsolete
        if(CharactersViewer.db.validate() == false) then
            CharactersViewer.db.init();
        end
    end


    -- Escape if we can't properly initialize, gotta be checked after 1.5.0 patch, not trigered on loading, but sometime trigered on mail retrieval
    if( ( event == "UNIT_INVENTORY_CHANGED" and arg1 ~= "player" ) or not UnitName("player") or UnitName("player") == UNKNOWNOBJECT or UnitName("player") == UKNOWNBEING or not Server) then
        return;
    end

    if(event == "MAIL_SHOW" or event == "MAIL_CLOSED") then
        if(CharactersViewerProfile and CharactersViewerProfile[Server]and CharactersViewerProfile[Server][UnitName("player")]and
            CharactersViewerProfile[Server][UnitName("player")]["Data"] ) then
                CharactersViewerProfile[Server][UnitName("player")]["Data"]["Mail"] = CharactersViewer.collect.mail(true);
        end
    elseif( event == "BANKFRAME_OPENED" or event == "BANKFRAME_CLOSED" or event == "PLAYERBANKSLOTS_CHANGED" or event == "PLAYERBANKBAGSLOTS_CHANGED" ) then
        CharactersViewer.collect.bank.SaveItems();
        return;
    elseif( event == "BAG_UPDATE" and BankFrame:IsVisible() ) then
        if( tonumber(arg1) and tonumber(arg1) > 4 and tonumber(arg1) <= 10 ) then
            CharactersViewer.collect.bank.SaveItems();                -- Populate all bank / bank bags...
        end
        return;
    else
        CharactersViewer.collect.all();
    end

    return;
end

function CharactersViewerItemButton_OnEnter()                        -- Cleaned by Flisher 2005-05-31
    local link, text, itemCount;
    -- Detecting if it's from the inventory or equipment
    if(this:GetID() < 100 and this:GetID() > 0) then
        -- Equiped item link
        if(CharactersViewerProfile[Server][CharactersViewer.index]["Equipment"][this:GetID()]) then
            link = CharactersViewerProfile[Server][CharactersViewer.index]["Equipment"][this:GetID()].L ;
            if(CharactersViewerProfile[Server][CharactersViewer.index]["Equipment"][this:GetID()].C) then
                itemCount = CharactersViewerProfile[Server][CharactersViewer.index]["Equipment"][this:GetID()].C;
            end
        else
            text = CharactersViewer.constant.inventorySlot.Name[this:GetID()];
        end
    elseif(this:GetID() > 2000 and this:GetID() < 2100) then
        local slot = this:GetID() - 2000;
        if( CharactersViewerProfile and CharactersViewerProfile[Server] and CharactersViewerProfile[Server][CharactersViewer.index] and CharactersViewerProfile[Server][CharactersViewer.index]["Bank"] and CharactersViewerProfile[Server][CharactersViewer.index]["Bank"]["Main"] and CharactersViewerProfile[Server][CharactersViewer.index]["Bank"]["Main"][slot] ) then
            if( CharactersViewerProfile[Server][CharactersViewer.index]["Bank"]["Main"][slot].L ) then
                link = CharactersViewerProfile[Server][CharactersViewer.index]["Bank"]["Main"][slot].L;
                if( CharactersViewerProfile[Server][CharactersViewer.index]["Bank"]["Main"][slot].C ) then
                    itemCount =  CharactersViewerProfile[Server][CharactersViewer.index]["Bank"]["Main"][slot].C;
                end
            end
        else
            text = EMPTY;
        end
    elseif ( (this:GetID() >= 100 and this:GetID() < 600) or (this:GetID() >= -100 and this:GetID() < -80 ) ) then
		-- Inventory item link
		local slot = math.mod( abs(this:GetID() +100), 100); 
		local bag  = (this:GetID() - slot - 100) / 100;
		if(CharactersViewerProfile[Server][CharactersViewer.index]["Bag"] and CharactersViewerProfile[Server][CharactersViewer.index]["Bag"][bag] and CharactersViewerProfile[Server][CharactersViewer.index]["Bag"][bag][slot] and CharactersViewerProfile[Server][CharactersViewer.index]["Bag"][bag][slot].L) then
			link = CharactersViewerProfile[Server][CharactersViewer.index]["Bag"][bag][slot].L;
			if(CharactersViewerProfile[Server][CharactersViewer.index]["Bag"][bag][slot].C) then
				 itemCount = CharactersViewerProfile[Server][CharactersViewer.index]["Bag"][bag][slot].C;
			end
		else
			text = EMPTY;
		end
    elseif(this:GetID() >= 600 and this:GetID() < 1200) then
        -- Inventory item link
        local slot = math.mod(this:GetID(), 100);
        local bag  = (this:GetID() - slot - 100) / 100;
        if(CharactersViewerProfile[Server][CharactersViewer.index]["Bank"] and CharactersViewerProfile[Server][CharactersViewer.index]["Bank"][bag] and CharactersViewerProfile[Server][CharactersViewer.index]["Bank"][bag][slot] and CharactersViewerProfile[Server][CharactersViewer.index]["Bank"][bag][slot].L) then
            link = CharactersViewerProfile[Server][CharactersViewer.index]["Bank"][bag][slot].L;
            if(CharactersViewerProfile[Server][CharactersViewer.index]["Bank"][bag][slot].C) then
                itemCount = CharactersViewerProfile[Server][CharactersViewer.index]["Bank"][bag][slot].C;
            end
        else
            text = EMPTY;
        end
    end
    ShowUIPanel(GameTooltip);
    GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
    if(link) then
        if( GetItemInfo(link) ) then
            GameTooltip:SetHyperlink(link);
        else
            GameTooltip:SetText(CHARACTERSVIEWER_NOT_CACHED);
        end
    else
        GameTooltip:SetText(text);
    end

    -- Book of Crafts inter-operability (http://www.curse-gaming.com/mod.php?addid=1397)
    if(BookOfCrafts_UpdateGameToolTips and link) then
        BookOfCrafts_UpdateGameToolTips();
    end

    -- Receipe Book inter-operability (http://www.curse-gaming.com/mod.php?addid=914)
    if( RecipeBook_DoHookedFunction and link) then
        RecipeBook_DoHookedFunction();
    end



    --Auctioneer inter-operability (http://www.curse-gaming.com/mod.php?addid=146)
    if(TT_TooltipCall and link) then
        local name,_,quality = GetItemInfo(link);
        if(name) then
            if(not itemCount) then
                itemCount = 1;
            end
            TT_Clear();
            TT_TooltipCall(GameTooltip, name, CharactersViewer.library.MakeLink(link), quality, itemCount);
            TT_Show(GameTooltip);
        end
    end

end

function CharactersViewer_Tooltip_SetInventoryItem(tooltip, slotid)   -- Cleaned by Flisher 2005-05-31
    local link, text;
--! if(not CharactersViewer.index) then
--!     CharactersViewer.Switch();
--! end

    if( CharactersViewer.index ~= UnitName("player") ) then
        -- Detecting if it's from the inventory or equipment
        if( slotid < 100 and slotid > 0) then
            -- Equiped item link
            if( CharactersViewerProfile[Server][CharactersViewer.index]["Equipment"][slotid] ) then
                link = CharactersViewerProfile[Server][CharactersViewer.index]["Equipment"][slotid].L ;
            else
                text = CharactersViewer.constant.inventorySlot.Name[slotid];
            end
        elseif(slotid > 2000 and slotid < 2100) then
            local slot = slotid - 2000;
            if( CharactersViewerProfile and CharactersViewerProfile[Server] and CharactersViewerProfile[Server][CharactersViewer.index] and CharactersViewerProfile[Server][CharactersViewer.index]["Bank"] and CharactersViewerProfile[Server][CharactersViewer.index]["Bank"]["Main"] and CharactersViewerProfile[Server][CharactersViewer.index]["Bank"]["Main"][slot] ) then
                if( CharactersViewerProfile[Server][CharactersViewer.index]["Bank"]["Main"][slot].L ) then
                    link = CharactersViewerProfile[Server][CharactersViewer.index]["Bank"]["Main"][slot].L;
                end
            else
                text = EMPTY;
            end
        elseif ( ( slotid >= 100 and slotid < 600) or (slotid >= -100 and slotid < -80 ) ) then
            -- Inventory item link
            local slot = math.mod( abs(slotid+100), 100); 
            local bag  = (slotid - slot - 100) / 100;
            if(CharactersViewerProfile[Server][CharactersViewer.index]["Bag"] and CharactersViewerProfile[Server][CharactersViewer.index]["Bag"][bag] and CharactersViewerProfile[Server][CharactersViewer.index]["Bag"][bag][slot] and CharactersViewerProfile[Server][CharactersViewer.index]["Bag"][bag][slot].L) then
                link = CharactersViewerProfile[Server][CharactersViewer.index]["Bag"][bag][slot].L;
            else
                text = EMPTY;
            end
        elseif( slotid >= 600 and slotid < 1200) then
            -- Inventory item link
            local slot = math.mod(slotid, 100);
            local bag  = (slotid - slot - 100) / 100;
            if(CharactersViewerProfile[Server][CharactersViewer.index]["Bank"] and CharactersViewerProfile[Server][CharactersViewer.index]["Bank"][bag] and CharactersViewerProfile[Server][CharactersViewer.index]["Bank"][bag][slot]and CharactersViewerProfile[Server][CharactersViewer.index]["Bank"][bag][slot].L) then
                link = CharactersViewerProfile[Server][CharactersViewer.index]["Bank"][bag][slot].L;
            else
                text = EMPTY;
            end
        end

        if(link) then
            if( GetItemInfo(link) ) then
                tooltip:SetHyperlink(link);
                if(UnitName("player") ~= CharactersViewer.index) then
                    tooltip:AddLine(CharactersViewer.index .. " " .. INVENTORY_TOOLTIP);
                    tooltip:Show();
                else
                    tooltip:Show();
                end
            else
                tooltip:SetText(CHARACTERSVIEWER_NOT_CACHED);
            end
        end
    else
        -- if the player requested is the logged one, use the original game tooltip
        tooltip:SetInventoryItem("player", slotid);
        tooltip:Show();
    end

end

function CharactersViewerItemButton_OnClick(arg1)                             -- Cleaned by Flisher 2005-05-31
	local link, item;
	-- Detecting if it's from the inventory or equipment
	if(this:GetID() < 100 and this:GetID() > 0 ) then
		-- Equiped item link
		if(CharactersViewerProfile[Server][CharactersViewer.index]["Equipment"][this:GetID()]) then
			link = CharactersViewerProfile[Server][CharactersViewer.index]["Equipment"][this:GetID()].L;
		end
	elseif(this:GetID() > 2000 and this:GetID() < 2100) then
		local slot = this:GetID() - 2000;
		if( CharactersViewerProfile and CharactersViewerProfile[Server] and CharactersViewerProfile[Server][CharactersViewer.index] and CharactersViewerProfile[Server][CharactersViewer.index]["Bank"] and CharactersViewerProfile[Server][CharactersViewer.index]["Bank"]["Main"] and CharactersViewerProfile[Server][CharactersViewer.index]["Bank"]["Main"][slot] ) then
			if( CharactersViewerProfile[Server][CharactersViewer.index]["Bank"]["Main"][slot].L ) then
				 link = CharactersViewerProfile[Server][CharactersViewer.index]["Bank"]["Main"][slot].L;
			end
		end
	elseif ( ( this:GetID() >= 100 and this:GetID() < 600) or (this:GetID() >= -100 and this:GetID() < -80 ) ) then
		-- Inventory item link
		local slot = math.mod( abs(this:GetID()+100), 100); 
		local bag  = (this:GetID() - slot - 100) / 100;
		if(CharactersViewerProfile[Server][CharactersViewer.index]["Bag"] and CharactersViewerProfile[Server][CharactersViewer.index]["Bag"][bag] and CharactersViewerProfile[Server][CharactersViewer.index]["Bag"][bag][slot] and CharactersViewerProfile[Server][CharactersViewer.index]["Bag"][bag][slot].L) then
			 link = CharactersViewerProfile[Server][CharactersViewer.index]["Bag"][bag][slot].L;
		end
	elseif( this:GetID() >= 600 and this:GetID() < 1200) then
		-- Inventory item link
		local slot = math.mod(this:GetID(), 100);
		local bag  = (this:GetID() - slot - 100) / 100;
		if ( CharactersViewerProfile and CharactersViewerProfile[Server] and CharactersViewerProfile[Server][CharactersViewer.index] and CharactersViewerProfile[Server][CharactersViewer.index]["Bank"] and CharactersViewerProfile[Server][CharactersViewer.index]["Bank"][bag] and CharactersViewerProfile[Server][CharactersViewer.index]["Bank"][bag][slot] and CharactersViewerProfile[Server][CharactersViewer.index]["Bank"][bag][slot].L ) then
			link = CharactersViewerProfile[Server][CharactersViewer.index]["Bank"][bag][slot].L;
		end
	end
	link = CharactersViewer.library.MakeLink(link);
	if(IsShiftKeyDown() and ChatFrameEditBox:IsVisible() and link and arg1 == "LeftButton") then
		ChatFrameEditBox:Insert(link);
	end
	if( arg1 == "LeftButton" and IsControlKeyDown() ) then
		DressUpItemLink(link);
	end

	-- Component interaction, http://www.curse-gaming.com/mod.php?addid=1256, added by Flisher 2005-06-16
	--! CharactersViewerItemButton_OnClick must be kept in backtracking ability CharactersViewer.button.onclick();
	if(Comp_TestOnClick and Comp_TestOnClick() and link) then
		return Comp_OnClick(arg1, link);
	end
end

function CharactersViewerMagicResistanceFrame_OnEnter()                   -- Checked by Flisher 2005-05-31
    ShowUIPanel(GameTooltip);
    GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
    GameTooltip:SetText(TEXT(getglobal("RESISTANCE"..this:GetID().."_NAME")));
end

function CharactersViewerDropDown_OnEnter()                                  -- Checked by Flisher 2005-05-31
    ShowUIPanel(GameTooltip);
    GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
    GameTooltip:SetText(CHARACTERSVIEWER_TOOLTIP_DROPDOWN2);
end

function CharactersViewer_Show()
    CharactersViewer.Hide();
    local temp;
    if(CharactersViewer.index == UnitName("player")) then
        CharactersViewer.collect.all();
    end

    -- Character Name and location
    if(CharactersViewerProfile[Server][CharactersViewer.index]["Data"]) then

        -- "Name (Zone / SubZone)"
        temp = CharactersViewer.index;
        if( CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Location"] ~= nil
         and CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Location"]["Zone"] ~= nil
         and CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Location"]["SubZone"] ~= nil ) then
            temp = temp .. " (" .. CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Location"]["Zone"] .. " - " .. CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Location"]["SubZone"] .. ")";
        end
        CharactersViewer_FrameTopText1:SetText(temp);

        -- Character Honor Rank, Level, Race and Class
        temp = "";
        if( CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Id"] ~= nil
         and CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Id"]["Level"] ~= nil
         and CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Id"]["Class"] ~= nil ) then
            temp = temp .. "Level " .. CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Id"]["Level"] ..  " " .. CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Id"]["Class"];
        end
        if( CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Honor"] ~= nil
         and CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Honor"]["rankNumber"] ~= nil
         and CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Honor"]["rankName"] ~= nil) then
            temp  = temp .. " (Rank " .. CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Honor"]["rankNumber"] .. ", " .. CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Honor"]["rankName"] .. ")";
        end
        CharactersViewer_FrameTopText2:SetText(temp);

        -- Guild Rank and Name display initialisation
        temp = "";
        if( CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Guild"]
         and CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Guild"]["GuildName"]
         and CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Guild"]["Title"] ) then
            temp = CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Guild"]["Title"] .. " of " .. CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Guild"]["GuildName"];
        end
        CharactersViewer_FrameTopText3:SetText(temp);

        -- Characters stats (str agi spirit intel stam...)
        temp = { "", "", "", "", ""};
        if(CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Stats"]) then
            for index = 1, 5 do
                if(CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Stats"][index]) then
                    local j = 0, stat, effectiveStat, posBuff, negBuff;
                    for w in string.gfind(CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Stats"][index], "%d+") do
                        j = j + 1;
                        if(j == 1) then stat = w;
                        elseif(j == 2) then effectiveStat = w;
                        elseif(j == 3) then posBuff = w;
                        elseif(j == 4) then negBuff = w;

                        end
                    end
                end
                temp[index] = effectiveStat;
            end
        end
        for index = 1, 5 do
            getglobal("CharactersViewer_FrameStatsTitle"..index):SetText(TEXT(getglobal("SPELL_STAT"..(index-1).."_NAME"))..":");
            getglobal("CharactersViewer_FrameStatsText"..index):SetText(temp[index]);
        end


        if(CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Basic"]) then
            -- Initialise the armor display
            temp = "";
            if(CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Basic"]["Armor"]) then
                local j =0, stat, effectiveStat, posBuff, negBuff;
                for w in string.gfind(CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Basic"]["Armor"], "%d+") do
                    j = j + 1;
                    if(j == 1) then stat = w;
                    elseif(j == 2) then effectiveStat = w;
                    elseif(j == 3) then posBuff = w;
                    elseif(j == 4) then negBuff = w;
                    end
                    temp = effectiveStat;
                end
            end
            CharactersViewer_FrameStatsTitle6:SetText(ARMOR_COLON);
            CharactersViewer_FrameStatsText6:SetText(temp);

            -- Initialise the Health display
            temp = "";
            if(CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Basic"]["Health"]) then
                temp = CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Basic"]["Health"];
            end
            CharactersViewer_FrameDetailTitle1:SetText(HEALTH_COLON);
            CharactersViewer_FrameDetailText1:SetText(temp);

            -- Initialise the mana display
            temp = "";
            if(CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Basic"]["Mana"]) then
                temp = CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Basic"]["Mana"];
            end
            CharactersViewer_FrameDetailTitle2:SetText(MANA_COLON);
            CharactersViewer_FrameDetailText2:SetText(temp);
        end


        -- Initialize the combats stats (crit, parry, dodge, block...)
        if(CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["CombatStats"]) then
            temp = "";
            if( CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["CombatStats"]["C"] ) then
                temp = string.format("%01.2f%%", CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["CombatStats"]["C"] );
            end
            CharactersViewer_FrameDetailTitle3:SetText(CHARACTERSVIEWER_CRIT ..":");
            CharactersViewer_FrameDetailText3:SetText(temp);

            temp = "";
            if( CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["CombatStats"]["D"] ) then
                temp = string.format("%01.2f%%", CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["CombatStats"]["D"] );
            end
            CharactersViewer_FrameDetailTitle4:SetText(DODGE ..":");
            CharactersViewer_FrameDetailText4:SetText(temp);

            if( CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["CombatStats"]["B"] ) then
                CharactersViewer_FrameDetailTitle5:SetText(BLOCK ..":");
                CharactersViewer_FrameDetailText5:SetText( string.format("%01.2f%%", CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["CombatStats"]["B"] ));
            end
            CharactersViewer_FrameDetailTitle5:SetText("");
            CharactersViewer_FrameDetailText5:SetText("");

            if( CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["CombatStats"]["P"] ) then
                CharactersViewer_FrameDetailTitle6:SetText(PARRY ..":");
                CharactersViewer_FrameDetailText6:SetText( string.format("%01.2f%%", CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["CombatStats"]["P"] ));
            else
                CharactersViewer_FrameDetailTitle6:SetText("");
                CharactersViewer_FrameDetailText6:SetText("");
            end
            if( CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["xp"] ) then
                temp = CharactersViewer.library.CalcRestedXP( CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["xp"] );
                if( temp and temp.levelratio ~= nil) then
                    temp = temp.levelratio .. " " .. LEVEL .. " " .. CHARACTERSVIEWER_RESTED;
                else
                    temp = "";
                end
                CharactersViewer_FrameDetailTitle7:SetText(XP .. ":");
                CharactersViewer_FrameDetailText7:SetText(temp);

                temp = "";
                if( CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["xp"]["current"] ) then
                    temp = CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["xp"]["current"];
                else
                    temp = "??";
                end
                if( CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["xp"]["max"] ) then
                    temp = temp .. "/" .. CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["xp"]["max"];
                else
                    temp = temp .. "/??";
                end
                CharactersViewer_FrameDetailTitle8:SetText("");
                CharactersViewer_FrameDetailText8:SetText(temp);

                if( CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["xp"]["resting"] ) then
                    CharactersViewer_RestedFrame:Show();
                else
                    CharactersViewer_RestedFrame:Hide();
                end
            end
            if( CharactersViewerProfile[Server][CharactersViewer.index]["Timestamp"] ~= nil) then
                CharactersViewer_FrameDetailTitle0:SetText(CHARACTERSVIEWER_SAVEDON);
                CharactersViewer_FrameDetailText0:SetText( date(nil, CharactersViewerProfile[Server][CharactersViewer.index]["Timestamp"]) );
            end
        else
            CharactersViewer_FrameDetailTitle3:SetText("");
            CharactersViewer_FrameDetailText3:SetText("");
            CharactersViewer_FrameDetailTitle4:SetText("");
            CharactersViewer_FrameDetailText4:SetText("");
            CharactersViewer_FrameDetailTitle5:SetText("");
            CharactersViewer_FrameDetailText5:SetText("");
            CharactersViewer_FrameDetailTitle6:SetText("");
            CharactersViewer_FrameDetailText6:SetText("");
            CharactersViewer_FrameDetailTitle7:SetText("");
            CharactersViewer_FrameDetailText7:SetText("");
            CharactersViewer_FrameDetailTitle8:SetText("");
            CharactersViewer_FrameDetailText8:SetText("");
            CharactersViewer_FrameDetailTitle0:SetText("");
            CharactersViewer_FrameDetailText0:SetText("");
            CharactersViewer_RestedFrame:Hide();
            CharactersViewer_MailFrame:Hide();
            CharactersViewer_MoneyFrame:Hide();
        end

        if( CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Resists"]) then
            -- Initialise the various resistance display
            for index = 2, 6 do
                temp = "";
                if( CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Resists"][index] ) then
                    temp = CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Resists"][index];
                end
                getglobal("CharactersViewerMagicResText"..index):SetText(temp);
            end
        else
            for index = 2, 6 do
                getglobal("CharactersViewerMagicResText"..index):SetText("x");
            end
        end

        if(CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Money"]) then
            MoneyFrame_Update("CharactersViewer_MoneyFrame", CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Money"]);
        else
            MoneyFrame_Update("CharactersViewer_MoneyFrame", 0 );
            CharactersViewer_MoneyFrame:Hide();
        end

        if(MailTo_InFrame and MailTo_Mail and MailTo_Mail[Server][CharactersViewer.index] and CharactersViewerProfile[Server][CharactersViewer.index] and CharactersViewerProfile[Server][CharactersViewer.index]["Type"] == "Self") then
            --if Inbox is already open, switch inbox to the current character
            if(MailTo_InFrame:IsVisible() ) then
                MailTo_inbox(CharactersViewer.index);
            end

            -- Count current know mail in the inbox
            local count = 0;
            for anything in MailTo_Mail[Server][CharactersViewer.index] do
                count = count + 1;
            end

            -- If there is 1 or more mail in inbox, or if mailflag is true, then display the icon with knwon mail.
            if( count > 1 or (CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Mail"] and CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Mail"]["HasNewMail"])) then
                SetItemButtonCount(getglobal("CharactersViewer_MailFrame"), count);
                CharactersViewer_MailFrame:Show();
            else
                CharactersViewer_MailFrame:Hide();
            end
        elseif( CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Mail"] and CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Mail"]["HasNewMail"]) then
                SetItemButtonCount(getglobal("CharactersViewer_MailFrame"), 0);
            CharactersViewer_MailFrame:Show();
        else
            CharactersViewer_MailFrame:Hide();
        end
    end

    local index, item, button, texture;
    for index = 1, 19 do
        button = getglobal("CharactersViewer_FrameItem"..index);
        texture = getglobal("CharactersViewer_FrameItem"..index.."IconTexture");
        texture2 = CharactersViewer.constant.inventorySlot.Texture[index];
        texture:SetTexture(texture2);
        SetItemButtonCount(button, 0);
    end
    for index, item in CharactersViewerProfile[Server][CharactersViewer.index]["Equipment"] do
         button = getglobal("CharactersViewer_FrameItem"..index);
         texture = getglobal("CharactersViewer_FrameItem"..index.."IconTexture");
         texture:SetTexture(item.T);
         SetItemButtonCount(button, item.C);
    end

    if( CharactersViewerProfile[Server][CharactersViewer.index]["Data"] and CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Id"] and CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Id"]["SexId"] and CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Id"]["RaceEn"]) then
        local temprace, tempsex;
        if(CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Id"]["RaceEn"] == "Night Elf") then
            temprace = "NightElf";
        else
            temprace = CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Id"]["RaceEn"];
        end
        if( CharactersViewerProfile[Server][CharactersViewer.index]["Data"]["Id"]["SexId"] == 0) then
            tempsex = "Male";
        else
            tempsex = "Female";
        end
        temp = "Interface\\CharacterFrame\\TemporaryPortrait-" .. tempsex .. "-" .. temprace;
    else
        temp = "Interface\\CharacterFrame\\TempPortrait";
    end
    CharactersViewer_PortraitTexure:SetTexture(temp);

    if( CharactersViewerProfile and CharactersViewerProfile[Server] and CharactersViewerProfile[Server][CharactersViewer.index] and CharactersViewerProfile[Server][CharactersViewer.index]["Bag"] ) then
        CharactersViewer_Bag_Toggle_Button:Enable();
    else
        CharactersViewer_Bag_Toggle_Button:Disable();
    end

    if( CharactersViewerProfile and CharactersViewerProfile[Server] and CharactersViewerProfile[Server][CharactersViewer.index] and CharactersViewerProfile[Server][CharactersViewer.index]["Bank"] ) then
        CharactersViewer_BankToggle:Show();
        if( CharactersViewerConfig["Bank_Display"] ) then
            CharactersViewer.Bank.Show();
        else
            CharactersViewer.Bank.Close();
        end
    else
        CharactersViewer_BankToggle:Hide();
        CharactersViewer.Bank.Close();
    end
    ShowUIPanel(CharactersViewer_Frame);

    -- bag
    if( not CharactersViewer_ContainerFrame0:IsUserPlaced()
        and not CharactersViewer_ContainerFrame1:IsUserPlaced()
        and not CharactersViewer_ContainerFrame2:IsUserPlaced()
        and not CharactersViewer_ContainerFrame3:IsUserPlaced()
        and not CharactersViewer_ContainerFrame4:IsUserPlaced()
        and not CharactersViewer_KeyringContainerFrame:IsUserPlaced()) then
        CharactersViewer.Bag.Relocate(false)
    end
    if( CharactersViewerProfile[Server][CharactersViewer.index]["Bag"] ) then
        if(CharactersViewerConfig["Bag_Display"] == true) then
            CharactersViewer.Bag.Display();
        else
            CharactersViewer.Bag.Hide();
        end
    else
        CharactersViewer.Bag.Hide();
    end

    if( CharactersViewerProfile[Server][CharactersViewer.index]["Bank"] ) then
        if(CharactersViewerConfig["BankBag_Display"] == true ) then
            CharactersViewer.Bank.BagDisplay();
        else
            CharactersViewer.Bank.BagHide();
        end
    else
        CharactersViewer.Bank.BagHide();
    end

end

function CharactersViewerDropDown_OnLoad()                      -- Checked by Flisher 2005-05-31
    --! enable/disable checkup on this
    UIDropDownMenu_Initialize(this, CharactersViewerDropDown_Initialize);
    UIDropDownMenu_SetText(CHARACTERSVIEWER_SELPLAYER, this);
    UIDropDownMenu_SetWidth(80, this);
end

function CharactersViewerDropDown_OnClick()
    CharactersViewer.Switch(this.value);
    CharactersViewer_Show();

end

function CharactersViewerDropDown_Initialize()
    local info = {};
    for index, item in CharactersViewerProfile[Server] do
        if(CharactersViewerProfile[Server][index]["Type"] == "Self") then
            local realm, player;
            info.text = index;
            info.value = index;
            info.func = CharactersViewerDropDown_OnClick;
            info.notCheckable = nil;
            info.keepShownOnClick = nil;
            UIDropDownMenu_AddButton(info);
        end
    end;
end

function CharactersViewer_PaperDoll_Dropdown2_Toggle()
        --! enable button on/off
        local count = 0;
            for anything in CharactersViewerProfile[Server] do
        count = count + 1;
        end
        if( count > 1 ) then
            getglobal("CharactersViewerDropDown2"):Show();
            getglobal("CharactersViewerDropDown3"):Show();
        else
            getglobal("CharactersViewerDropDown2"):Hide();
            getglobal("CharactersViewerDropDown3"):Hide();
        end
end

-- Backward / inter-addons compatibility

-- Called By EquipCompare, soon to be removed, modified to fit with my new code - Flisher 2005-05-16

function CharactersViewerGetBSIIndex(forceRecreate)
    if(forceRecreate or not CharactersViewerCurrentIndex) then
        CharactersViewer.Switch();
    end
    return CharactersViewer.index ;       -- same as returning CharactersViewerCurrentIndex
end


-- this one is also for Equipcompare interoperability:
CHARACTERSVIEWER_VERSION = CharactersViewer.version.number;
CharactersViewerCurrentIndex = nil -- Not local so someone can hook to it

function CharactersViewer_Toggle()                    -- Changed by Flisher 2005-06-12
    CharactersViewer.Toggle();
end

local function Used(bag,nr)
    used = 0;
    for i = 1,nr do
      if(bag[i] and bag[i].L) then used = used+1; end
    end
    return used
end

function CharactersViewer_Bags(arg)
    if(not CharactersViewerProfile) then return; end
    local CV = CharactersViewerProfile[Server]
    if(not CV) then return; end
    local use = arg=='use'
    print(CHARACTERSVIEWER_BAG_USE..Server)
    local text,list,total,bag,tused,used
    for name,data in CV do
      if(data.Type=='Self') then
        list,total,tused = '',0,0
		  for ix,bag in data.Bag do
          if(list~='') then list = list..'+'; end
          if(use) then
            used = Used(bag,bag.size)
            list = list..used..'/'
            tused = tused+used
          end
          list = list..bag.size
          total = total+bag.size
        end
        tused = use and tused..'/' or ''
        text = format("%s: %s=%s%d",name,list,tused,total)
        list,total,tused = '24',24,0;
        if(data.Bank) then
          if(use) then
            used = Used(data.Bank.Main,24)
            list = used..'/24'
            tused = used
          end
          for ix,bag in data.Bank do
				if type(bag)=='table' then
					if(ix~='Main') then
	              if(use) then
	                used = Used(bag,bag.size)
	                list = format("%s+%d/%d",list,used,bag.size)
	                tused = tused+used
	              else list = list..'+'..bag.size; end
	              total = total+bag.size
	            end
				end
          end
          tused = use and tused..'/' or ''
          text = format("%s,   Bank: %s=%s%d",text,list,tused,total)
        end
        print(text)
      end
    end
end
