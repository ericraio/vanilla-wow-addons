-- ********************************************************
-- *          This is AtlasQuest v 3.15.33! enjoy ;)      *
-- ********************************************************
-- *                                                      *
-- * Author: Asurn                                        *
-- *                                                      *
-- * Translation:                                         *
-- * EN: Asurn                                            *
-- * DE: Asurn                                            *
-- * FR:                                                  *
-- ********************************************************
-- *What does AtlasQuest?                                 *
-- *++++++++++++++++++++++++++++++++++++++++++++++++++++++*
-- *                                                      *
-- *AtlasQuest shows you information about                *
-- *Quests in every Instances.                            *
-- *+ The official Story (taken from www.wow.europe.com)  *
-- *                                                      *
-- * - Shown Information:                                 *
-- *                                                      *
-- * Questname, Questlevel, Attainded level to get        *
-- * the Quest, Where you get the Quest, Questrewards,    *
-- * a note about the Quest, the Quest aftert his quest   *
-- * and the prequest                                     *
-- *                                                      *
-- *                                                      *
-- *                                                      *
-- *                                                      *
-- ********************************************************


--Vesiontext festlegen (als variable)
local VERSION_CORE = "|cffff00003";
local VERSION_INSTANZEN = "15";
local VERSION_REST = "33|r"
ATLASQUEST_VERSION = "|cff1eff00AtlasQuest Version: |r"..VERSION_CORE.."."..VERSION_INSTANZEN.."."..VERSION_REST.."";


-- Farben
local PURPLE = "|cff999999"; -- grey atm -- removed/useless atm
local RED = "|cffff0000";
local REDA = "|cffcc6666";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local GREY = "|cff9F3FFF"; --purple now ^^
local BLUE = "|cff0070dd";
local ORANGE = "|cffff6090"; -- it is rosa now
local YELLOW = "|cffffff00";
local BLACK = "|c0000000f";
local DARKGREEN = "|cff008000";
local BLUB = "|cffd45e19";

-- Quest Color
local Grau = "|cff9d9d9d"
local Gruen = "|cff1eff00"
local Orange = "|cffFF8000"
local Rot = "|cffFF0000"
local Gelb = "|cffFFd200"
local Blau = "|cff0070dd"

--Variablen -> need explaination / register TO DO!

local Initialized = nil; -- Die Variablen sind noch nicht geladen

Allianceorhorde = 1; --variable um festzulegen ob horde oder allianz angezeigt wird

local EnglishFraction = ""; --nötig um festzustellen welcher fraktion man angehört

local LocalizedFraction = ""; -- nötig um festzustellen welcher fraktion man angehört

AQINSTANZ = ""; -- momentan angezeigtes Instanzbild (siehe AtlasQuest_Instanzen.lua)

AQINSTATM = ""; -- variable um zu sehn ob sich AQINSTANZ verändert hat (siehe function AtlasQuestSetTextandButtons())

--AQ_ShownSide = "Left"  -- Legt die seite fest auf der das AQ Panle angezeigt wird

--AQAtlasAuto (option beim atlas öffnen AQpanel automatisch anzeigen 1=Ja 2=Nein)


local AQ_ShownSide = "Left"
local AQAtlasAuto = 1;
Debug = 0;
AtlasQuestHelp = {};
AtlasQuestHelp[1] = "[/aq + availeable command: help, left/right, show/hide, autoshow\ndownload adress:\nhttp://ui.worldofwar.net/ui.php?id=3069, http://www.curse-gaming.com/de/wow/addons-4714-1-atlasquest.html]";

local AtlasQuest_Defaults = {
  [UnitName("player")] = {
    ["ShownSide"] = "Left",
    ["AtlasAutoShow"] = 1,
  },
};

-------------------------------------------------------------------------
---------------------------------- FUNKTIONEN ---------------------------
-------------------------------------------------------------------------

--******************************************
------------------/////Events: OnEvent//////
--******************************************

--------------------------------
-- called when the player starts the game loads the variables
--------------------------------
function AtlasQuest_OnEvent()
   if (event == "VARIABLES_LOADED") then
      VariablesLoaded = 1; -- Daten sind vollständig geladen
   else
      AtlasQuest_Initialize(); -- Spieler betritt die Welt / Initialisiere die Daten
   end
end

--------------------------------
-- Stellt fest ob die Variablen geladen werden müssen
-- oder legt sie neu fest
--------------------------------
function AtlasQuest_Initialize()
  if (Initialized or (not VariablesLoaded)) then
    return;
  end
  if (not AtlasQuest_Options) then
    AtlasQuest_Options = AtlasQuest_Defaults;
    DEFAULT_CHAT_FRAME:AddMessage("AtlasQuest Options database not found. Generating...");
  elseif (not AtlasQuest_Options[UnitName("player")]) then
    DEFAULT_CHAT_FRAME:AddMessage("Generate default database for this character");
    AtlasQuest_Options[UnitName("player")] = AtlasQuest_Defaults[UnitName("player")]
  end
  if (type(AtlasQuest_Options[UnitName("player")]) == "table") then
    AtlasQuest_LoadData();
  end
  Initialized = 1;
end
--------------------------------
-- Lädt die Variablen
--------------------------------
function AtlasQuest_LoadData()
  -- Which side
  if(AtlasQuest_Options[UnitName("player")]["ShownSide"] ~= nil) then
    AQ_ShownSide = AtlasQuest_Options[UnitName("player")]["ShownSide"];
  end
  -- atlas autoshow
  if(AtlasQuest_Options[UnitName("player")]["AtlasAutoShow"] ~= nil) then
    AQAtlasAuto = AtlasQuest_Options[UnitName("player")]["AtlasAutoShow"];
  end
end

--------------------------------
-- Speichert die Variablen
--------------------------------
function AtlasQuest_SaveData()
  AtlasQuest_Options[UnitName("player")]["ShownSide"] = AQ_ShownSide;  -- side
  AtlasQuest_Options[UnitName("player")]["AtlasAutoShow"] = AQAtlasAuto;
end

------------------ Events: OnEvent -> end

--******************************************
------------------/////Events: Onload//////
--******************************************

--------------------------------
-- Call OnLoad set Variables and hides the panel
--------------------------------
function AQ_OnLoad()
    this:RegisterEvent("PLAYER_ENTERING_WORLD");
    this:RegisterEvent("VARIABLES_LOADED");
    --AQSetFont();
    AQFraktionCheck();
    AQSetButtontext();
    AQTEXTonload();
    AtlasQuestUeberschrift:SetText(ATLASQUEST_VERSION)
    if ( AtlasFrame ) then
    	AQATLASMAP = AtlasMap:GetTexture()
    else
	AQATLASMAP = 36;
    end
    this:RegisterForDrag("LeftButton");
    AQSlashCommandfunction();
	--ersmal nicht anzeigen
    HideUIPanel(AtlasQuestFrame);
    HideUIPanel(AtlasQuestInsideFrame);
    --AQAtlasVersionCheck();
    AQUpdateNOW = true;
end


--------------------------------
-- Possible Font Function
------------------------------
AQ_Font = "Fonts\FRIZQT__.TTF"
function AQSetFont()
     AQFont:SetFont(getglobal(AQ_Font),13,"OUTLINE, MONOCHROME")
end

--------------------------------
-- Slahs command added
------------------------------
function AQSlashCommandfunction()
    SlashCmdList["ATLASQ"]=atlasquest_command;
	SLASH_ATLASQ1="/aq";
	SLASH_ATLASQ2="/atlasquest";
end

-------------------------------
-- Atlas Version Check (deaktiviert)
-------------------------------
function AQAtlasVersionCheck()
   -- if (ATLAS_VERSION == "1.8") then
   --     --do nothing
   --   else
   --       ChatFrame1:AddMessage(ATLAS_VERSIONWARNINGTEXT);
   -- end -- momentan nutzlos und fehleranfällig vll spätere wieder einführung
end

------------------------------
-- check the fraction and set the check button
-------------------------------
function AQFraktionCheck()
    EnglishFraction, LocalizedFraction = UnitFactionGroup("player");
    if ( EnglishFraction == "Horde") then
       Allianceorhorde = 2;
       AQHCB:SetChecked(true);
       AQACB:SetChecked(false);
    end
end

---------------------------------
-- set the button text
---------------------------------
function AQSetButtontext()
      STORYbutton:SetText(AQStoryB);
      OPTIONbutton:SetText(AQOptionB);
end

---------------------------------
-- show the loaded text
---------------------------------
function AQTEXTonload()
    ChatFrame1:AddMessage(ATLASQUEST_VERSION..GREY.." = loaded, by ASURN");
    ChatFrame1:AddMessage(GREY.."type /aq or /atlasquest show the version number");
    ChatFrame1:AddMessage(RED.."Attention:"..GREY.."You need Atlas or AlphaMap to use AtlasQuest");
end

---------------------------------
--  Slashcommand!! show/hide panel + Version Message
---------------------------------
function atlasquest_command(param)

  -- Version text (AQ and Atlas(if there) and Alphamap (if there))
  ChatFrame1:AddMessage(ATLASQUEST_VERSION);
  if (AtlasFrame ~= nil) then
    ChatFrame1:AddMessage("Atlasversion: "..ATLAS_VERSION);
  end
  if (AlphaMapFrame ~= nil) then
    ChatFrame1:AddMessage("AlphaMapversion: "..ALPHA_MAP_VERSION);
  end

  --help text
  if (param == "help") then
    ChatFrame1:AddMessage(RED..AQHelpText);
  end
  -- hide show function
  if (param == "show") then
      ShowUIPanel(AtlasQuestFrame);
      ChatFrame1:AddMessage("Shows AtlasQuest");
  end
  if (param == "hide") then
      HideUIPanel(AtlasQuestFrame);
      HideUIPanel(AtlasQuestInsideFrame);
      ChatFrame1:AddMessage("Hides AtlasQuest");
  end
  -- right/left show function
  if (param == "right") then
     AQ_SetPanelRight();
  end
  if (param == "left") then
     AQ_SetPanelLeft();
  end
  -- Options
  if ((param == "option") or (param == "config")) then
     ChatFrame1:AddMessage("Here will the option menu appear. Pls wait until i releas the next version");
     --AQ_OptionPanel();
  end
  --test messages
  if (param == "test") then
     AQTestmessages();
  end
  if (param == "autoshow") then
     if (AQAtlasAuto == 1) then
        AQAtlasAuto = 2;
        AtlasQuest_SaveData();
        ChatFrame1:AddMessage(AQAtlasAutoOFF);
     else
        AQAtlasAuto = 1;
        AtlasQuest_SaveData();
        ChatFrame1:AddMessage(AQAtlasAutoON);
     end
  end
end

---------------------------------
--  testmessages
---------------------------------
function AQTestmessages()
     ChatFrame1:AddMessage("TEST/DEBUG");
     XXX = GamAlphaMapMap.filename;
     ChatFrame1:AddMessage(XXX);
end

---------------------------------
--  Right side shown /command
---------------------------------
function AQ_SetPanelRight()
     if ((AtlasFrame ~= nil) and (AtlasORAlphaMap == "Atlas")) then
       AtlasQuestFrame:ClearAllPoints();
       AtlasQuestFrame:SetPoint("TOP","AtlasFrame", 511, -80);
     elseif (AtlasORAlphaMap == "AlphaMap") then
       AtlasQuestFrame:ClearAllPoints();
       AtlasQuestFrame:SetPoint("TOP","AlphaMapFrame", 400, -107);
     end
     AQ_ShownSide = "Right";
     AtlasQuest_SaveData();
     ChatFrame1:AddMessage(AQShowRight);
end

---------------------------------
--  Left side shown /command
---------------------------------
function AQ_SetPanelLeft()
     if ((AtlasFrame ~= nil) and (AtlasORAlphaMap == "Atlas") and ( AQ_ShownSide == "Right") ) then
       AtlasQuestFrame:ClearAllPoints();
       AtlasQuestFrame:SetPoint("TOP","AtlasFrame", -503, -80);
     elseif ((AtlasORAlphaMap == "AlphaMap") and ( AQ_ShownSide == "Right") ) then
       AtlasQuestFrame:ClearAllPoints();
       AtlasQuestFrame:SetPoint("TOPLEFT","AlphaMapFrame", -195, -107);
     end
     AQ_ShownSide = "Left";
     AtlasQuest_SaveData();
     ChatFrame1:AddMessage(AQShowLeft);
end

------------------ Events: Onload -> end





--******************************************
------------------////// Events: OnUpdate//////
--******************************************

---------------------------------
--  On Update function
-- check which programm is used( atlas or am)
-- hide panel if instanze is 36(=nothing)
---------------------------------
function AQ_OnUpdate(arg1)
  local previousValue = AQINSTANZ;

        AQ_AtlasOrAMVISCheck(); -- Show whether atlas or am is shown atm

        ------- SEE AtlasQuest_Instanzen.lua
        if (AtlasORAlphaMap == "Atlas") then
           AtlasQuest_Instanzenchecken();
        elseif (AtlasORAlphaMap == "AlphaMap") then
           AtlasQuest_InstanzencheckAM();
        end

        -- Hides the panel if the map which is shown no quests have (map = 36)
       if ( AQINSTANZ == 36) then
             HideUIPanel(AtlasQuestFrame);
             HideUIPanel(AtlasQuestInsideFrame);
       elseif (( AQINSTANZ ~= previousValue ) or (AQUpdateNOW ~= nil)) then
           AtlasQuestSetTextandButtons();
           AQUpdateNOW = nil
           AQ_SetCaption();
       elseif ((AtlasORAlphaMap == "AlphaMap") and (AlphaMapAlphaMapFrame:IsVisible() == nil)) then
           HideUIPanel(AtlasQuestFrame);
           HideUIPanel(AtlasQuestInsideFrame);
       end
end

---------------------------------
--  Show whether atlas or am is shown atm
---------------------------------
function AQ_AtlasOrAMVISCheck()
        if ((AtlasFrame ~= nil) and (AtlasFrame:IsVisible())) then
           AtlasORAlphaMap = "Atlas";
        elseif (AlphaMapFrame:IsVisible()) then
           AtlasORAlphaMap = "AlphaMap";
        end
end
---------------------------------
--  AlphaMap parent change
---------------------------------
function AQ_AtlasOrAlphamap()
        if ((AtlasFrame ~= nil) and (AtlasFrame:IsVisible())) then
           AtlasORAlphaMap = "Atlas";
           --
           AtlasQuestFrame:SetParent(AtlasFrame);
           if (AQ_ShownSide == "Right" ) then
               AtlasQuestFrame:ClearAllPoints();
               AtlasQuestFrame:SetPoint("TOP","AtlasFrame", 511, -80);
           else
               AtlasQuestFrame:ClearAllPoints();
               AtlasQuestFrame:SetPoint("TOP","AtlasFrame", -503, -80);
           end
           AtlasQuestInsideFrame:SetParent(AtlasFrame);
           AtlasQuestInsideFrame:ClearAllPoints();
           AtlasQuestInsideFrame:SetPoint("TOPLEFT","AtlasFrame", 18, -84);
        elseif ((AlphaMapFrame ~= nil) and (AlphaMapFrame:IsVisible())) then
           AtlasORAlphaMap = "AlphaMap";
           --
           AtlasQuestFrame:SetParent(AlphaMapFrame);
           if (AQ_ShownSide == "Right" ) then
             AtlasQuestFrame:ClearAllPoints();
             AtlasQuestFrame:SetPoint("TOP","AlphaMapFrame", 400, -107);
           else
             AtlasQuestFrame:ClearAllPoints();
             AtlasQuestFrame:SetPoint("TOPLEFT","AlphaMapFrame", -195, -107);
           end
           AtlasQuestInsideFrame:SetParent(AlphaMapFrame);
           AtlasQuestInsideFrame:ClearAllPoints();
           AtlasQuestInsideFrame:SetPoint("TOPLEFT","AlphaMapFrame", 1, -108);
        end
end

---------------------------------
--  Set the ZoneName
---------------------------------
function AQ_SetCaption()
    for i=1, 36 do
       if ( AQINSTANZ == i) then
          Ueberschriftborder:SetText(getglobal("Inst"..i.."Caption"))
       end
       if ( AQINSTANZ == 36) then
          Ueberschriftborder:SetText();
       end
    end
end

---------------------------------
--  Set the Buttontext and the buttons if availeable
--  and check whether its a other inst or not -> works fine
--  added: Check vor Questline arrows
--  Questline arrows are shown if InstXQuestYFQuest = "true"
--  QuestStart icon are shown if InstXQuestYPreQuest = "true"
---------------------------------
function AtlasQuestSetTextandButtons()
local AQQuestlevelf
local AQQuestfarbe
local AQQuestfarbe2
   if (AQINSTATM ~= AQINSTANZ) then
      HideUIPanel(AtlasQuestInsideFrame);
   end
   for i=1, 36 do
       if (Allianceorhorde == 1 and AQINSTANZ == i) then
           AQINSTATM = AQINSTANZ;
           if (getglobal("Inst"..i.."QAA") ~= nil) then
               AtlasQuestAnzahl:SetText(getglobal("Inst"..i.."QAA"));
           else
               AtlasQuestAnzahl:SetText("");
           end
           for b=1, 18 do
             if (getglobal("Inst"..i.."Quest"..b.."FQuest")) then
                ShowUIPanel(getglobal("AQQuestlineArrow_"..b));
             else
                HideUIPanel(getglobal("AQQuestlineArrow_"..b));
             end
             if (getglobal("Inst"..i.."Quest"..b.."PreQuest")) then
                ShowUIPanel(getglobal("AQQuesstart_"..b));
             else
                HideUIPanel(getglobal("AQQuesstart_"..b));
             end
             AQQuestlevelf = tonumber(getglobal("Inst"..i.."Quest"..b.."_Level"));
             if (getglobal("Inst"..i.."Quest"..b) ~= nil) then
                if ( AQQuestlevelf ~= nil or AQQuestlevelf ~= 0 or AQQuestlevelf ~= "") then
                   if ( AQQuestlevelf == UnitLevel("player") or AQQuestlevelf == UnitLevel("player") + 2 or AQQuestlevelf  == UnitLevel("player") - 2 or AQQuestlevelf == UnitLevel("player") + 1 or AQQuestlevelf  == UnitLevel("player") - 1) then
                     AQQuestfarbe = Gelb;
                   elseif ( AQQuestlevelf > UnitLevel("player") + 2 and AQQuestlevelf <= UnitLevel("player") + 4) then
                     AQQuestfarbe = Orange;
                   elseif ( AQQuestlevelf >= UnitLevel("player") + 5 and AQQuestlevelf ~= 100) then
                     AQQuestfarbe = Rot;
                   elseif ( AQQuestlevelf < UnitLevel("player") - 7) then
                     AQQuestfarbe = Grau;
                   elseif ( AQQuestlevelf >= UnitLevel("player") - 7 and AQQuestlevelf < UnitLevel("player") - 2) then
                     AQQuestfarbe = Gruen;
                   elseif ( AQQuestlevelf == 100) then
                     AQQuestfarbe = Blau;
                   end
                end
                getglobal("AQQuestbutton"..b):Enable();
                getglobal("AQBUTTONTEXT"..b):SetText(AQQuestfarbe..getglobal("Inst"..i.."Quest"..b));
             else
                getglobal("AQQuestbutton"..b):Disable();
                getglobal("AQBUTTONTEXT"..b):SetText();
             end
           end
       end
       if (Allianceorhorde == 2 and AQINSTANZ == i) then
           AQINSTATM = AQINSTANZ;
           if (getglobal("Inst"..i.."QAH") ~= nil) then
               AtlasQuestAnzahl:SetText(getglobal("Inst"..i.."QAH"));
           else
               AtlasQuestAnzahl:SetText("");
           end
           for b=1, 18 do
             if (getglobal("Inst"..i.."Quest"..b.."FQuest_HORDE")) then
                ShowUIPanel(getglobal("AQQuestlineArrow_"..b));
             else
                HideUIPanel(getglobal("AQQuestlineArrow_"..b));
             end
             if (getglobal("Inst"..i.."Quest"..b.."PreQuest_HORDE")) then
                ShowUIPanel(getglobal("AQQuesstart_"..b));
             else
                HideUIPanel(getglobal("AQQuesstart_"..b));
             end
             if (getglobal("Inst"..i.."Quest"..b.."_HORDE") ~= nil) then
                AQQuestlevelf = tonumber(getglobal("Inst"..i.."Quest"..b.."_HORDE_Level"));
                if ( AQQuestlevelf ~= nil or AQQuestlevelf ~= 0 or AQQuestlevelf ~= "") then
                   if ( AQQuestlevelf == UnitLevel("player") or AQQuestlevelf == UnitLevel("player") + 2 or AQQuestlevelf  == UnitLevel("player") - 2 or AQQuestlevelf == UnitLevel("player") + 1 or AQQuestlevelf  == UnitLevel("player") - 1) then
                     AQQuestfarbe = Gelb;
                   elseif ( AQQuestlevelf > UnitLevel("player") + 2 and AQQuestlevelf <= UnitLevel("player") + 4) then
                     AQQuestfarbe = Orange;
                   elseif ( AQQuestlevelf >= UnitLevel("player") + 5 and AQQuestlevelf ~= 100) then
                     AQQuestfarbe = Rot;
                   elseif ( AQQuestlevelf < UnitLevel("player") - 7) then
                     AQQuestfarbe = Grau;
                   elseif ( AQQuestlevelf >= UnitLevel("player") - 7 and AQQuestlevelf < UnitLevel("player") - 2) then
                     AQQuestfarbe = Gruen;
                   elseif ( AQQuestlevelf == 100) then
                     AQQuestfarbe = Blau;
                   end
                end
                getglobal("AQQuestbutton"..b):Enable();
                getglobal("AQBUTTONTEXT"..b):SetText(AQQuestfarbe..getglobal("Inst"..i.."Quest"..b.."_HORDE"));
             else
                getglobal("AQQuestbutton"..b):Disable();
                getglobal("AQBUTTONTEXT"..b):SetText();
             end
           end
       end
-------Special case: ZG
       if (AQINSTANZ == 28) then
         AQQuestfarbe2 = Blau;
         AQQuestbutton1:Enable();
         AQBUTTONTEXT1:SetText(AQQuestfarbe2..Inst28Caption1);
       end
-------Special case: BWl
       if (AQINSTANZ == 6) then
         AQQuestfarbe2 = Blau;
         AQQuestbutton1:Enable();
         AQBUTTONTEXT1:SetText(AQQuestfarbe2..Inst6Caption1);
         AQQuestbutton2:Enable();
         AQBUTTONTEXT2:SetText(AQQuestfarbe2..Inst6Caption2);
       end
-------Special case: DRAGONS
       if (AQINSTANZ == 30) then
         AQQuestfarbe2 = Blau;
         AQQuestbutton1:Enable();
         AQBUTTONTEXT1:SetText(AQQuestfarbe2..Inst30Caption1);
         AQQuestbutton2:Enable();
         AQBUTTONTEXT2:SetText(AQQuestfarbe2..Inst30Caption2);
         AQQuestbutton3:Enable();
         AQBUTTONTEXT3:SetText(AQQuestfarbe2..Inst30Caption3);
         AQQuestbutton4:Enable();
         AQBUTTONTEXT4:SetText(AQQuestfarbe2..Inst30Caption4);
       end
   end
end


------------------ Events: OnUpdate -> End

--******************************************
------------------ /////Events: Atlas_OnShow //////
--******************************************

---------------------------------
-- Shows the AQ panel with atlas (option adden!)
---------------------------------
function Atlas_OnShow()
    if ( AQAtlasAuto == 1) then
     ShowUIPanel(AtlasQuestFrame);
    else
     HideUIPanel(AtlasQuestFrame);
    end
    HideUIPanel(AtlasQuestInsideFrame);
   -- AQ_AtlasOrAlphamap();
   if (AQ_ShownSide == "Right") then
    AtlasQuestFrame:ClearAllPoints();
       AtlasQuestFrame:SetPoint("TOP","AtlasFrame", 511, -80);
  end
end

------------------ Events: Atlas_OnShow -> End

--******************************************
------------------//// OnEnter/OnLeave ITEM ANZEIGEN ///////
--******************************************

---------------------------------
-- hide tooltip
---------------------------------
function AtlasQuestItem_OnLeave()
        if(GameTooltip:IsVisible()) then
            GameTooltip:Hide();
        end
        if(AtlasQuestTooltip:IsVisible()) then
            AtlasQuestTooltip:Hide();
        end
end

---------------------------------
-- show tooltip
-- update: function added to check whether there is a ID or not
-- update perhaps useless if hide function works -> but will stay
---------------------------------
function AtlasQuestItem_OnEnter()
        for i=1, 36 do
           if ( Allianceorhorde == 1) then
              if (AQINSTANZ == i) then
               if (getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN) ~= nil) then
                 SHOWNID = getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN);
                 if (getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN) ~= nil) then
                  if(GetItemInfo(getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN)) ~= nil) then
                        AtlasQuestTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                         AtlasQuestTooltip:SetHyperlink("item:"..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN)..":0:0:0");
                        AtlasQuestTooltip:Show();
                  else
                        AtlasQuestTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                        AtlasQuestTooltip:ClearLines();
                        AtlasQuestTooltip:AddLine(RED..AQERRORNOTSHOWN);
                        AtlasQuestTooltip:AddLine(AQERRORASKSERVER);
                        AtlasQuestTooltip:Show();
                  end
                 end
               end
              end
           else
              if (AQINSTANZ == i) then
               if (getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN.."_HORDE") ~= nil) then
                 SHOWNID = getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN.."_HORDE");
                 if (getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN.."_HORDE") ~= nil) then
                  if(GetItemInfo(getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN.."_HORDE")) ~= nil) then
                        AtlasQuestTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                         AtlasQuestTooltip:SetHyperlink("item:"..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN.."_HORDE")..":0:0:0");
                        AtlasQuestTooltip:Show();
                  else
                        AtlasQuestTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                        AtlasQuestTooltip:ClearLines();
                        AtlasQuestTooltip:AddLine(RED..AQERRORNOTSHOWN);
                        AtlasQuestTooltip:AddLine(AQERRORASKSERVER);
                        AtlasQuestTooltip:Show();
                  end
                 end
               end
              end
           end
        end
end

---------------------------------
-- ask Server right-click
---------------------------------
function AtlasQuestItem_OnClick(arg1)
        if(arg1=="RightButton") then
          for i=1, 36 do
              if ( Allianceorhorde == 1) then
                if (AQINSTANZ == i) then
                   AtlasQuestTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                   AtlasQuestTooltip:SetHyperlink("item:"..SHOWNID..":0:0:0");
                   AtlasQuestTooltip:Show();                    DEFAULT_CHAT_FRAME:AddMessage(AQSERVERASK.."["..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."ITC"..AQTHISISSHOWN)..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."name"..AQTHISISSHOWN)..WHITE.."]"..AQSERVERASKInformation);
                end
              else
                if (AQINSTANZ == i) then
                   AtlasQuestTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                   AtlasQuestTooltip:SetHyperlink("item:"..SHOWNID..":0:0:0");
                   AtlasQuestTooltip:Show();                    DEFAULT_CHAT_FRAME:AddMessage(AQSERVERASK.."["..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."ITC"..AQTHISISSHOWN.."_HORDE")..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."name"..AQTHISISSHOWN.."_HORDE")..WHITE.."]"..AQSERVERASKInformation);
                end
               end
          end
        end
end

------------------ OnEnter/OnLeave ITEM ANZEIGEN -> END

-------------------------------------------------------------------------------------------------------------------

--|cffff0000 - Spieler 1 (Rot)
--|cff0000ff - Spieler 2 (Blau)
--|cff00ffff - Spieler 3 (Blaugrau)
--|cff6f2583 - Spieler 4 (Lila)
--|cffffff00 - Spieler 5 (Gelb)
--|cffd45e19 - Spieler 6 (Orange)
--|cff00ff00 - Spieler 7 (Grün)
--|cffff8080 - Spieler 8 (Rosa)
--|cff808080 - Spieler 9 (Grau)
--|cff8080ff - Spieler 10 (Hellblau)
--|cff008000 - Spieler 11 (Dunkelgrün)
--|cff4d2903 - Spieler 12 (Braun)




--Chatframe1:AddMessage("text") fügt eine nachricht ins allgemeine chatfenster ein
--message("Text") gibt eine fehelrmeldung mit dem text wieder