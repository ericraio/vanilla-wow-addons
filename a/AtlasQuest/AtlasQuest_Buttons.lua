-- Farben
local PURPLE = "|cff999999"; -- grey atm -- removed
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
-------------------------------------------------------------------------------------
---------------------------  Buttons   ----------------------------------------------
-------------------------------------------------------------------------------------

---------------------------------
-- Option button (useless atm)
---------------------------------
function AQOPTION1_OnClick()
--blub
end


---------------------------------
-- Oben rechts der button /zum panel show/close
---------------------------------
function AQCLOSE_OnClick()
      AQ_AtlasOrAlphamap();
      if(AtlasQuestFrame:IsVisible()) then
          HideUIPanel(AtlasQuestFrame);
          HideUIPanel(AtlasQuestInsideFrame);
      else
          ShowUIPanel(AtlasQuestFrame);
      end
end

---------------------------------
-- oben links am panel der button zum schließen
---------------------------------
function AQCLOSE1_OnClick()
   HideUIPanel(AtlasQuestFrame);
end

---------------------------------
-- der button inside für schließen der q anzeige
---------------------------------
function AQCLOSE2_OnClick()
    HideUIPanel(AtlasQuestInsideFrame);
    WHICHBUTTON = 0;
end

---------------------------------
-- Checkbox für Allianz
---------------------------------
function Alliance_OnClick()
     Allianceorhorde = 1
     AQHCB:SetChecked(false);
     AQACB:SetChecked(true);
     HideUIPanel(AtlasQuestInsideFrame);
     AQUpdateNOW = true;
end

---------------------------------
-- Checkbox für Horde
---------------------------------
function Horde_OnClick()
     Allianceorhorde = 2
     AQHCB:SetChecked(true);
     AQACB:SetChecked(false);
     HideUIPanel(AtlasQuestInsideFrame);
     AQUpdateNOW = true;
end

---------------------------  Buttons  -> END

--------------------- /////// QUESTBUTTON /////////////

---------------------------------
-- Hide the AL Frame if avaiable
---------------------------------
function AQHideAL()
       if ( AtlasLootItemsFrame ~= nil) then
            AtlasLootItemsFrame:Hide(); -- hide atlasloot
       end
end

---------------------------------
-- Story Button
---------------------------------
function AQSTORY1_OnClick()
       AQHideAL();
       if (AtlasQuestInsideFrame:IsVisible() == nil) then
           ShowUIPanel(AtlasQuestInsideFrame);
           WHICHBUTTON = STORY;
       elseif ( WHICHBUTTON == STORY) then
          HideUIPanel(AtlasQuestInsideFrame);
       else
        WHICHBUTTON = STORY;
       end
   AQButtonSTORY_SetText();
end

---------------------------------
-- Button
---------------------------------
function Quest_OnClick()
   AQHideAL();
   StoryTEXT:SetText("");
   if (AtlasQuestInsideFrame:IsVisible() == nil) then
       ShowUIPanel(AtlasQuestInsideFrame);
       WHICHBUTTON = AQSHOWNQUEST;
   elseif ( WHICHBUTTON == AQSHOWNQUEST) then
       HideUIPanel(AtlasQuestInsideFrame);
       WHICHBUTTON = 0;
   else
     WHICHBUTTON = AQSHOWNQUEST;
   end
   AQButton_SetText();
end


-----------------------QUESTBUTTON -> END

-----------------//////// QUESTBUTTON SET TEXT /////////////

---------------------------------
-- set the Quest text
---------------------------------
function AQButton_SetText()
local AQQuestlevelf
local AQQuestfarbe
   for i=1, 36 do
     if ( Allianceorhorde == 1 and AQINSTANZ == i) then
       AQQuestlevelf = tonumber(getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."_Level"));
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
         Questueberschrift:SetText(AQQuestfarbe..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST));
         QuestLeveltext:SetText(GREEN..AQDiscription_LEVEL..WHITE..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."_Level"));
         QuestAttainLeveltext:SetText(DARKGREEN..AQDiscription_ATTAIN..WHITE..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."_Attain")); Prequesttext:SetText(RED..AQDiscription_PREQUEST..WHITE..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."_Prequest").."\n \n"..BLUB..AQDiscription_FOLGEQUEST..WHITE..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."_Folgequest").."\n \n"..BLUE..AQDiscription_START..WHITE..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."_Location").."\n \n"..ORANGE..AQDiscription_AIM..WHITE..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."_Aim").."\n \n"..GREY..AQDiscription_NOTE..WHITE..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."_Note"));
         for b=1, 6 do
           REWARDstext:SetText(getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."Rewardtext"))
           if ( getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."name"..b) ~= nil) then
             getglobal("AtlasQuestItemframe"..b.."_Icon"):SetTexture("Interface\\Icons\\"..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."textur"..b));
             getglobal("AtlasQuestItemframe"..b.."_Name"):SetText(getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."ITC"..b)..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."name"..b));
             getglobal("AtlasQuestItemframe"..b.."_Extra"):SetText(getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."description"..b));
             getglobal("AtlasQuestItemframe"..b):Enable();
           else
             getglobal("AtlasQuestItemframe"..b.."_Icon"):SetTexture();
             getglobal("AtlasQuestItemframe"..b.."_Name"):SetText();
             getglobal("AtlasQuestItemframe"..b.."_Extra"):SetText();
             getglobal("AtlasQuestItemframe"..b):Disable();
           end
         end
     end
------------------------------------------------------------------------------
--        + +   +   +++   ++   +++
--        +++  + +  + +   + +  ++
--        + +   +   +  +  ++   +++
------------------------------------------------------------------------------
     if ( Allianceorhorde == 2 and AQINSTANZ == i) then
       AQQuestlevelf = tonumber(getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."_HORDE_Level"));
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
       Questueberschrift:SetText(AQQuestfarbe..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."_HORDE"));
       QuestLeveltext:SetText(GREEN..AQDiscription_LEVEL..WHITE..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."_HORDE_Level"));
       QuestAttainLeveltext:SetText(DARKGREEN..AQDiscription_ATTAIN..WHITE..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."_HORDE_Attain"));       Prequesttext:SetText(RED..AQDiscription_PREQUEST..WHITE..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."_HORDE_Prequest").."\n \n"..BLUB..AQDiscription_FOLGEQUEST..WHITE..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."_HORDE_Folgequest").."\n \n"..BLUE..AQDiscription_START..WHITE..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."_HORDE_Location").."\n \n"..ORANGE..AQDiscription_AIM..WHITE..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."_HORDE_Aim").."\n \n"..GREY..AQDiscription_NOTE..WHITE..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."_HORDE_Note"));
       for b=1, 6 do
           REWARDstext:SetText(getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."Rewardtext_HORDE"))
           if ( getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."name"..b.."_HORDE") ~= nil) then
             getglobal("AtlasQuestItemframe"..b.."_Icon"):SetTexture("Interface\\Icons\\"..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."textur"..b.."_HORDE"));
             getglobal("AtlasQuestItemframe"..b.."_Name"):SetText(getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."ITC"..b.."_HORDE")..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."name"..b.."_HORDE"));
             getglobal("AtlasQuestItemframe"..b.."_Extra"):SetText(getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."description"..b.."_HORDE"));
             getglobal("AtlasQuestItemframe"..b):Enable();
           else
             getglobal("AtlasQuestItemframe"..b.."_Icon"):SetTexture();
             getglobal("AtlasQuestItemframe"..b.."_Name"):SetText();
             getglobal("AtlasQuestItemframe"..b.."_Extra"):SetText();
             getglobal("AtlasQuestItemframe"..b):Disable();
           end
         end
     end
-------Special case: ZG
     if ( AQINSTANZ == 28 and AQSHOWNQUEST <= 1) then
       StoryTEXT:SetText(WHITE..getglobal("Inst28Story"..AQSHOWNQUEST));
       Questueberschrift:SetText(BLUE..getglobal("Inst28Caption"..AQSHOWNQUEST));
       Prequesttext:SetText();
       QuestAttainLeveltext:SetText();
       QuestLeveltext:SetText();
     end
-------Special case: BWL
     if ( AQINSTANZ == 6 and AQSHOWNQUEST <= 2) then
       StoryTEXT:SetText(WHITE..getglobal("Inst6Story"..AQSHOWNQUEST));
       Questueberschrift:SetText(BLUE..getglobal("Inst6Caption"..AQSHOWNQUEST));
       Prequesttext:SetText();
       QuestAttainLeveltext:SetText();
       QuestLeveltext:SetText();
     end
-------Special case: DRAGONS
     if ( AQINSTANZ == 30 and AQSHOWNQUEST <= 4) then
       StoryTEXT:SetText(WHITE..getglobal("Inst30Story"..AQSHOWNQUEST));
       Questueberschrift:SetText(BLUE..getglobal("Inst30Caption"..AQSHOWNQUEST));
       Prequesttext:SetText();
       QuestAttainLeveltext:SetText();
       QuestLeveltext:SetText();
     end
-------Special case: VC PALA Q
     if ( AQINSTANZ == 1 and AQSHOWNQUEST == 7) then
       StoryTEXT:SetText(WHITE..getglobal("Inst1Quest"..AQSHOWNQUEST.."TEXT"));
       Questueberschrift:SetText(BLUE..getglobal("Inst1Quest"..AQSHOWNQUEST));
       Prequesttext:SetText();
       QuestAttainLeveltext:SetText();
       QuestLeveltext:SetText();
     end
-------Special case: BSF PALA Q
     if ( AQINSTANZ == 21 and AQSHOWNQUEST == 2 and Allianceorhorde == 1) then
       StoryTEXT:SetText(WHITE..getglobal("Inst21Quest"..AQSHOWNQUEST.."TEXT"));
       Questueberschrift:SetText(BLUE..getglobal("Inst21Quest"..AQSHOWNQUEST));
       Prequesttext:SetText();
       QuestAttainLeveltext:SetText();
       QuestLeveltext:SetText();
     end
   end
end


---------------------------------
-- Set Story Text
---------------------------------
function AQButtonSTORY_SetText()
       Questueberschrift:SetText("");
       QuestLeveltext:SetText("");
       Prequesttext:SetText("");
       QuestAttainLeveltext:SetText("");
       for b=1, 6 do
          getglobal("AtlasQuestItemframe"..b.."_Icon"):SetTexture();
          getglobal("AtlasQuestItemframe"..b.."_Name"):SetText();
          getglobal("AtlasQuestItemframe"..b.."_Extra"):SetText();
          getglobal("AtlasQuestItemframe"..b):Disable();
          REWARDstext:SetText()
       end
       for i=1, 36 do
         if (AQINSTANZ == i) then
             StoryTEXT:SetText(WHITE..getglobal("Inst"..i.."Story"));
             Questueberschrift:SetText(BLUE..getglobal("Inst"..i.."Caption"));
         end
       end
end