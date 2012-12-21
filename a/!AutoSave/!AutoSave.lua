-- Addon: !AutoSave (version: 1.12.1)
-- Autor: Platine   (e-mail: platine.wow@gmail.com)

-- Localization
local AS_Messages = {
   loaded  ="loaded.",                              -- loaded.
   saved   ="Saved the form.",						-- Character saved.
   active  ="Enable AutoSave features",             -- Enable AutoSave
   confirme="View your record",						-- Print confirmation
   period  ="Entry in the interval [sec]",          -- Save-interval in [sec]
   combat  ="Save the output from the fight",       -- Run on exit of combat
   skill   ="Sign in skills after promotion",		-- Run on skill-up
   quest   ="Save this post",					    -- Run on quest completed
   close   ="Close",                                -- Close the window

   AFK_on  ="You are now AFK: Away from Keyboard",  -- System message from event CHAT_MSG_SYSTEM
   AFK_off ="You are no longer AFK." };

-- Global Variables
local AutoSave_LastTime    = GetTime();    -- last time made a record
local AutoSave_MinimPeriod = 100;   -- protection against excessively high burden on the server
local AutoSave_PutSave     = false;
local AutoSave_AFKtime     = false;
local AutoSave_InCombat    = false;
local AS_OnDebug = false;


function AS_OnLoad()
  SLASH_AUTOSAVE1 = "/autosave";
  SLASH_AUTOSAVE2 = "/as";
  SlashCmdList["AUTOSAVE"] = AS_OnShow;
  this:RegisterEvent("ADDON_LOADED");
  this:RegisterEvent("PLAYER_REGEN_ENABLED");
  this:RegisterEvent("PLAYER_REGEN_DISABLED");
  this:RegisterEvent("CHAT_MSG_SAY");
  this:RegisterEvent("CHAT_MSG_SKILL");
  this:RegisterEvent("CHAT_MSG_SYSTEM");
  this:RegisterEvent("PLAYER_LEVEL_UP");
  this:RegisterEvent("PLAYER_TARGET_CHANGED");
  this:RegisterEvent("QUEST_COMPLETE");
  this:RegisterEvent("UNIT_AURA");
end
  

function AS_OnEvent()
   if ((event == "ADDON_LOADED") and (arg1 == "!AutoSave")) then
      -- dodatek zaladowano
      AS_CheckVars();
      if (DEFAULT_CHAT_FRAME) then
          DEFAULT_CHAT_FRAME:AddMessage("|cffffff00!AutoSave ver. 1.12.1 - "..AS_Messages.loaded);
      else
          UIErrorsFrame:AddMessage("!AutoSave ver. 1.12.1 - "..AS_Messages.loaded, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
      end
   end
   if (AutoSave_PC["check1"]=="on") then
      -- działanie dodatku jest zezwolone
      if (GetTime()<AutoSave_LastTime) then    
         -- zegar systemowy wyzerował się
         if (AS_OnDebug) then
            DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Wyzerowany licznik czasu: "..AutoSave_LastTime.." "..GetTime());
         end
         AutoSave_LastTime=GetTime();
      end   
      if (AutoSave_LastTime+AutoSave_PC["okres"]<=GetTime()) then
         -- minąl czas - trzeba zapisać postać
         AutoSave_PutSave=true;
      end
      if (event=="PLAYER_REGEN_DISABLED") then
         -- poczatek walki, nie zapisuj!
         AutoSave_InCombat=true;
         if (AS_OnDebug) then
            DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Zdarzenie: PLAYER_REGEN_DISABLED.");
         end
      end
      if (event=="PLAYER_REGEN_ENABLED") then
         -- walka skonczona
         AutoSave_InCombat=false;
         if (AS_OnDebug) then
            DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Zdarzenie: PLAYER_REGEN_ENABLED.");
         end
         if (AutoSave_PC["check3"]=="on") then
            AutoSave_PutSave=true;
         end
      end
      if (event=="PLAYER_LEVEL_UP") then
         -- zmiana levela gracza
         if (AS_OnDebug) then
            DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Zdarzenie: PLAYER_LEVEL_UP "..arg1.." lvl");
         end
         if (AutoSave_PC["check4"]=="on") then
            AutoSave_PutSave=true;
         end
      end
      if (event=="CHAT_MSG_SKILL") then
         -- zmiana poziomu umiejętnosci
         if (AS_OnDebug) then
            DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Zdarzenie: CHAT_MSG_SKILL "..arg1.." "..arg2.." "..arg6);
         end
         if (strsub(arg1,1,10)=="Your skill") then
            if (AutoSave_PC["check4"]=="on") then
               AutoSave_PutSave=true;
            end   
         end
      end
      if (event=="QUEST_COMPLETE") then
         -- quest skompletowany, zakończony
         if (AS_OnDebug) then
            DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Zdarzenie: QUEST_COMPLETE");
         end
         if (AutoSave_PC["check5"]=="on") then
            AutoSave_PutSave=true;
         end
      end
      if (event=="CHAT_MSG_SYSTEM") then
         -- zabezpieczenie: podczas AFK - licznik zegara stoi
         if (arg1==AS_Messages.AFK_on) then
            AutoSave_AFKtime=true;
            AutoSave_PutSave=false;
         end
         if (arg1==AS_Messages.AFK_off) then
            AutoSave_AFKtime=false;
            AutoSave_PutSave=false;
            AutoSave_LastTime=GetTime();
         end
      end
   end
   if ((AutoSave_PutSave) and (not AutoSave_InCombat) and (not AutoSave_AFKtime)) then
      -- trzeba zapisać
      if (AutoSave_LastTime+AutoSave_MinimPeriod<GetTime()) then
         -- zachowany jest bezpieczny okres zapisu
         AutoSave_PutSave=false;
         SendChatMessage(".save", "SAY", nil);
         AutoSave_LastTime=GetTime();
         if (AutoSave_PC["check2"]=="on") then
            -- jest pozwolenie na komunikat
            if (DEFAULT_CHAT_FRAME) then
               DEFAULT_CHAT_FRAME:AddMessage("|cffffff00"..AS_Messages.saved);
            else
               UIErrorsFrame:AddMessage(AS_Messages.saved, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
            end
         end   
      end
   end   
end

      
function AS_CheckVars()
  if (not AutoSave_PC) then
     AutoSave_PC = {};
  end
  -- zainicjuj przelaczniki
  if (not AutoSave_PC["okres"] ) then
     AutoSave_PC["okres"] = "400";
  end
  if (not AutoSave_PC["check1"] ) then
     AutoSave_PC["check1"] = "on";
  end
  if (not AutoSave_PC["check2"] ) then
     AutoSave_PC["check2"] = "off";
  end
  if (not AutoSave_PC["check3"] ) then
     AutoSave_PC["check3"] = "off";
  end
  if (not AutoSave_PC["check4"] ) then
     AutoSave_PC["check4"] = "off";
  end
  if (not AutoSave_PC["check5"] ) then
     AutoSave_PC["check5"] = "off";
  end
  -- Ustaw przelaczniki wg. zapisanych zmiennych
  if (AutoSave_PC["check1"] == "on") then
     AS_CheckButton1:SetChecked(1);
  else 
      AS_CheckButton1:SetChecked(0);
  end
  if (AutoSave_PC["check2"] == "on") then
     AS_CheckButton2:SetChecked(1);
  else 
     AS_CheckButton2:SetChecked(0);
  end
  if (AutoSave_PC["check3"] == "on") then
     AS_CheckButton3:SetChecked(1);
  else 
     AS_CheckButton3:SetChecked(0);
  end
  if (AutoSave_PC["check4"] == "on") then
     AS_CheckButton4:SetChecked(1);
  else 
     AS_CheckButton4:SetChecked(0);
  end
  if (AutoSave_PC["check5"] == "on") then
     AS_CheckButton5:SetChecked(1);
  else 
     AS_CheckButton5:SetChecked(0);
  end
end


function AS_OnShow()
  AS_CheckLabel1:SetText(AS_Messages.active);
  AS_CheckLabel2:SetText(AS_Messages.confirme);
  AS_CheckLabel3:SetText(AS_Messages.combat);
  AS_CheckLabel4:SetText(AS_Messages.skill);
  AS_CheckLabel5:SetText(AS_Messages.quest);
  AS_PeriodLabel:SetText(AS_Messages.period);
  AS_Button1:SetText(AS_Messages.close);
  AS_EditBox1:SetText(AutoSave_PC["okres"]);
  if (AS_OnDebug) then
     AS_Button1:SetText(tonumber(GetTime()));
  end
  AutoSaveForm:Show();
end
  

function AS_OnMouseDown()
  if (arg1 == "LeftButton") then
      this:StartMoving();
  end
end
  

function AS_OnMouseUp()
  if (arg1 == "LeftButton") then
      this:StopMovingOrSizing();
  end
end


function AS_CheckButton_OnClick(par1)
  if (AutoSave_PC[par1] == "off") then
      AutoSave_PC[par1] = "on";
  else 
      AutoSave_PC[par1] = "off";
  end
end    


function AS_EditBox1_OnEnterPressed()
  local zm1=AS_EditBox1:GetText();
  if ((zm1==nil) or (zm1=="")) then
     zm1="0";
  end   
  if (tonumber(zm1)<AutoSave_MinimPeriod) then
     AS_EditBox1:SetText(tostring(AutoSave_MinimPeriod));
  else   
     AutoSave_PC["okres"]=zm1;
  end  
end


function AS_Button1_OnClick()
  AS_EditBox1_OnEnterPressed();
  AutoSaveForm:Hide();
end