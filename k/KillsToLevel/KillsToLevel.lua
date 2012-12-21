
--Kills To Level : Titan Enabled
--Craig Willis
--17/05/05

local TITAN_KTL_ID = "KTL";

KTL_Version="0.53";
usingT = 0;        --for Titan check
usingF = 0;		 --for Fubar check
KTL_XP = 0;
KTL_MAXXP = 0;         --Needed to remove calc error when leveling
KTL_LITTLE_R = 0;  --Needed to remove calc error when low rested.
KTL_COMBAT = 0;
KTL_SMALL = 0;

--Loading Functs
function TitanPanelKTLButton_OnLoad()
	this.registry = {
		id = TITAN_KTL_ID,
		menuText = TITAN_KTL_MENU_TEXT,
		buttonTextFunction = "TitanPanelKTLButton_GetButtonText", 
		tooltipTitle = TITAN_KTL_TOOLTIP, 
		savedVariables = {
			ShowLabelText = 1,
		}
	};	
	usingT=1;			--Set to 1 when titan is available, 0 when no titan
end

function TitanPanelKTLButton_OnEvent()
	TitanPanelButton_UpdateButton(TITAN_KTL_ID);		
end

function Fubar_OnLoad()
	
	KillsToLevelFu = FuBarPlugin:new {
		name = "FuBar - KillsToLevelFu",
		desc = "Simple calculation mod that used the xp gained, to calculate kills to level",
		version = KTL_VERSION,
		aceCompatible = 103,
		fuCompatible = 102, 
		author = "Willister",
		email = "willister@hotmail.com",
		website = "http://ui.worldofwar.net/ui.php?id=746",
		category = "others",		
		db= AceDatabase:new("KillsToLevelFu"),
		hasIcon = false,
	    textFrame = "",
	}		

	function KillsToLevelFu:UpdateText(string)
		if (string~=null) then
			 self:SetText(string)
		else
		     local label, text = KTL_TextUpdate();
		     self:SetText(label..text)
		end
	end
	
	function KillsToLevelFu:OnClick()
		 KTL_LabelChange();
		 local label, text = KTL_TextUpdate();
	     KillsToLevelFu:UpdateText(label..text);
	end
	
	KillsToLevelFu:RegisterForLoad()
	usingF = 1;
end

function KillMod_OnLoad()
	KTLOnLoad();
end

function KillMod_OnEvent()
   KTLOnEvent();   
end

--Titan Functs
function TitanPanelKTLButton_GetButtonText(id)
	local labelText, valueText = KTL_TextUpdate();
	return labelText, TitanUtils_GetHighlightText(valueText);
end


function TitanPanelRightClickMenu_PrepareKTLMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_KTL_ID].menuText);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_KTL_ID);
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_KTL_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanPanelKTLButton_OnClick()
	KTL_LabelChange();
    TitanPanelButton_UpdateButton(TITAN_KTL_ID);       
end


--KTL functions
function KTLOnLoad()
   SlashCmdList["KILLCOMMAND"] = KillMod_SlashHandler;
   SLASH_KILLCOMMAND1 = "/Kill";
   SLASH_KILLCOMMAND1 = "/ktl";

	
  this:RegisterEvent("VARIABLES_LOADED");  --Set hook if needed and check chat frame
  this:RegisterEvent("PLAYER_XP_UPDATE");
  this:RegisterEvent("QUEST_FINISHED");
  this:RegisterEvent("PLAYER_LEAVE_COMBAT");
  this:RegisterEvent("PLAYER_LOGIN");
	
  if( DEFAULT_CHAT_FRAME ) then
	  	DEFAULT_CHAT_FRAME:AddMessage(format(KTL_LOADED,KTL_Version));
  end
  if FuBar then                 --Checks on Load for FuBar
      Fubar_OnLoad();
  end
  
  if (not KTL_ARRAY) then KTL_ARRAY = {}; end  --If the array doesnt exist, make it
  
end

function KTLOnEvent()
	if(event == "VARIABLES_LOADED") then
         KTL_LoadConfig();
		 StatusShow();		 
	elseif(event == "PLAYER_XP_UPDATE") then
		KillMod_XPChange();									
	elseif(event == "QUEST_FINISHED") then
		if(KTL_ARRAY["KTL_QUEST_STATE"]==0) then							--If we are checking for quests, then do the QTL maths
           KillMod_QuestDone();
        else
        end
	elseif(event == "PLAYER_LEAVE_COMBAT") then
		if(KTL_ARRAY["KTL_QUEST_STATE"]==0) then
           KillMod_CombatDone();                            --Idea behind this is that after a quest finished event
        else											    --Stay in quest mode, until the next time combnat is finished
        end
	elseif(event == "PLAYER_LOGIN") then
		KTL_XP = UnitXP("player");
		if (KTL_ARRAY["KTL_STATE"] == 6) then
	         DEFAULT_CHAT_FRAME:AddMessage(format(KTL_DEBUG_STRING, "old xp", KTL_XP));	     
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Unregistered event: "..event);
	end
end

function KTL_LoadConfig()
     if (not KTL_ARRAY["INITIALIZED"]) then  --if init isnt true, there is a problem with the array, clear and reset it
		KTL_ARRAY = {};
		KTL_ARRAY["INITIALIZED"] = true;
		KTL_ARRAY["KTL_FRAME"] = 2;
		KTL_ARRAY["KTL_STATE"] = 1;
		KTL_ARRAY["KTL_LABEL"] = TITAN_KTL_BUTTON_LABEL; 
		KTL_ARRAY["KTL_QUEST_STATE"] =  1; 		
		KTL_ARRAY["KTL_RK"] = 0;        --KTL storage
		KTL_ARRAY["KTL_NK"] = 0;
		KTL_ARRAY["KTL_Q"] = 0;
	 end	
     	 
	 KTL_CHAT_FRAME = getglobal("ChatFrame"..KTL_ARRAY["KTL_FRAME"]);  --Once saved variables loaded, then hook to the correct chat frame
     KTL_XP = UnitXP("player");                           --Load these when all variables are loaded
     KTL_MAXXP = UnitXPMax("player");
	 if (KTL_ARRAY["KTL_STATE"] == 6) then
	     DEFAULT_CHAT_FRAME:AddMessage(format(KTL_DEBUG_STRING, "old xp", KTL_XP));
	     DEFAULT_CHAT_FRAME:AddMessage(format(KTL_DEBUG_STRING, "old ktl",KTL_ARRAY["KTL_NK"]));
		 DEFAULT_CHAT_FRAME:AddMessage(format(KTL_DEBUG_STRING, "old Rktl",KTL_ARRAY["KTL_RK"]));
	 end
	 if (usingT==1) then TitanPanelButton_UpdateButton(TITAN_KTL_ID); end
	 if (usingF==1) then 
	     local label, text = KTL_TextUpdate();
	     KillsToLevelFu:UpdateText(label..text);
	 end
end

function KTL_TextUpdate()
     local count, labelText, valueText;
	 labelText = KTL_ARRAY["KTL_LABEL"];        
     if (KTL_COMBAT == 0) then	
        if (KTL_ARRAY["KTL_RK"] == 0) then
	   --No rested kills
	   if (KTL_ARRAY["KTL_NK"] == 0) then
	    --No Normal Kills, No Rested, Blank Info
	    valueText = "Blank";
	  else
	    --Normal Only
	    valueText = format(TITAN_KTL_BUTTON_TEXT_N,KTL_ARRAY["KTL_NK"]);
	  end
	else
	  --Rested Kills
	  if (KTL_ARRAY["KTL_NK"] == 0) then
	    --No Normal Kills, Rested Only
	    valueText = format(TITAN_KTL_BUTTON_TEXT_R,KTL_ARRAY["KTL_RK"]);
	  else
	    --Normal and Rested Kills
	    valueText = format(TITAN_KTL_BUTTON_TEXT_R_N,KTL_ARRAY["KTL_RK"],KTL_ARRAY["KTL_NK"]);
	  end
	end;
     elseif (KTL_COMBAT == 1) then
        valueText = format(TITAN_KTL_BUTTON_TEXT_Q, KTL_ARRAY["KTL_Q"]);
     end
	if (KTL_ARRAY["KTL_STATE"] == 6) then
		DEFAULT_CHAT_FRAME:AddMessage("Done a Button Text Update");
	end
	return labelText, valueText;
end

function KTL_LabelChange()
	if(KTL_SMALL == 0) then
                --Large Lables
		KTL_SMALL = 1; 
        	if(KTL_COMBAT == 0) then
			--Combat labels  
                    KTL_ARRAY["KTL_LABEL"] = TITAN_KTL_BUTTON_LABEL;          
        	elseif(KTL_COMBAT == 1) then
                	--Quest Labels
                    KTL_ARRAY["KTL_LABEL"] = TITAN_KTL_BUTTON_QUEST_LABEL;  
       		end		
	elseif(KTL_SMALL == 1) then
                --Small Lables
		KTL_SMALL = 2;
        	if(KTL_COMBAT == 0) then
			--Combat labels
                    KTL_ARRAY["KTL_LABEL"] = TITAN_KTL_BUTTON_SMALL_LABEL;             
        	elseif(KTL_COMBAT == 1) then
                	--Quest Labels
                    KTL_ARRAY["KTL_LABEL"] = TITAN_KTL_BUTTON_SMALL_QUEST_LABEL;
       		end
				
	elseif(KTL_SMALL == 2) then
                --No Lables
		KTL_SMALL = 0;
		KTL_ARRAY["KTL_LABEL"] = "";
       					
	end
    if (usingT==1) then TitanPanelButton_UpdateButton(TITAN_KTL_ID); end
	if (usingF==1) then 
	     local label, text = KTL_TextUpdate();
	     KillsToLevelFu:UpdateText(label..text);
	end
end


function KillMod_QuestDone()
   KTL_COMBAT=1;
end

function KillMod_CombatDone()
   KTL_COMBAT=0;
end

function KillMod_XPChange()
   
   local cXp;    
   cXp = UnitXP("player");  --cXp Current xp
   if (KTL_ARRAY["KTL_STATE"] == 6) then
        KTL_CHAT_FRAME:AddMessage(format(KTL_DEBUG_STRING, "old xp", KTL_XP));
   end
   if (KTL_ARRAY["KTL_STATE"] == 6) then
        KTL_CHAT_FRAME:AddMessage(format(KTL_DEBUG_STRING, "current xp", cXp));
   end
   if (KTL_ARRAY["KTL_STATE"] > 0) then  --State 0 == off
     local xpDif;
     local xp2level;
     local restedKill;
     local ktl;
     local rested;
     local typestring;

     if (KTL_ARRAY["KTL_STATE"] == 2) then
         typestring = KTL_AVG;
     elseif (KTL_ARRAY["KTL_STATE"] == 6) then
		 typestring = KTL_DEB;
     else
		 typestring = KTL_EXACT;
     end;     --That just told the mod which text to display, depending on the mode your in
     
     xpDif = cXp - KTL_XP;  --Easy to understand, new xp minus old xp.
	 if (KTL_ARRAY["KTL_STATE"] == 6) then
        KTL_CHAT_FRAME:AddMessage(format(KTL_DEBUG_STRING, "xp diff", xpDif));
     end
     if (xpDif == 0) then
	     --Something has called me, and there has been no xp change, dont do anything
		 --xpDif = (KTL_MAXXP - KTL_XP) + cXp; --Should be correct xp change now.
     else
     if (xpDif < 0) then
		 xpDif = (KTL_MAXXP - KTL_XP) + cXp; --Should be correct xp change now.
		 if (KTL_ARRAY["KTL_STATE"] == 6) then
             KTL_CHAT_FRAME:AddMessage(format(KTL_DEBUG_STRING, "new xp difference", xpDif));
         end
     end	 
     if (KTL_LITTLE_R > 0) then
         if (KTL_COMBAT == 0) then
			 xpDif = xpDif - KTL_LITTLE_R;
             KTL_LITTLE_R = 0;
        end
     end

     xp2level = UnitXPMax("player") - cXp;  --Easy again.
     if (KTL_ARRAY["KTL_STATE"] == 6) then
        KTL_CHAT_FRAME:AddMessage(format(KTL_DEBUG_STRING, "xp to level", xp2level));
     end
	 restedKill = xpDif/2;  --Half the change is always rested, even in a group.  Only case where it isn't, is when
	 if (KTL_ARRAY["KTL_STATE"] == 6) then
        KTL_CHAT_FRAME:AddMessage(format(KTL_DEBUG_STRING, "rested xp from this kill", restedKill));
     end	 
     ktl = xp2level/xpDif;  --Simple again
	 if (KTL_ARRAY["KTL_STATE"] == 6) then
        KTL_CHAT_FRAME:AddMessage(format(KTL_DEBUG_STRING, "kills to level", ktl));
     end
     if(KTL_COMBAT == 1) then
         KTL_ARRAY["KTL_Q"] = ktl;
		 --Quests To Level Update
         if (KTL_ARRAY["KTL_STATE"] == 3) then
	       --Titan Bar only, dont update to channel
         else
		 KTL_CHAT_FRAME:AddMessage(format(KTL_QUEST, ktl), 1.0, 1.0, 0.0);
       end;
     else

     rested = GetXPExhaustion();
	 
     if (rested == nil) then rested = 0; 
     end
     if (KTL_ARRAY["KTL_STATE"] == 6) then
        KTL_CHAT_FRAME:AddMessage(format(KTL_DEBUG_STRING, "rested xp", rested));
     end
     if (rested > 0) then
         if (restedKill*ktl > rested) then  --if the rested amount from this kill, times the number of kills to level is greater than the current
                                            --rested amount, there will be normal kills and rested to level		 
	         if (rested < xpDif) then       
		         KTL_LITTLE_R = rested;     --If you have less rested than half the xp, then the game added a different amount of rested- little_r
				     if (KTL_ARRAY["KTL_STATE"] == 6) then
					     KTL_CHAT_FRAME:AddMessage(format(KTL_DEBUG_STRING, "little r", KTL_LITTLE_R));
					 end
	         end
             local normxp = UnitXPMax("player") - (cXp+rested);  --How much normal xp you need to level
			 if (KTL_ARRAY["KTL_STATE"] == 6) then
				 KTL_CHAT_FRAME:AddMessage(format(KTL_DEBUG_STRING, "normal xp to level", normxp));
			 end			 
	         local numrkills = rested/xpDif;
			 
	        KTL_ARRAY["KTL_RK"] = ceil(numrkills);
	        KTL_ARRAY["KTL_NK"] = normxp/restedKill;
	        KTL_ARRAY["KTL_NK"] = ceil(KTL_ARRAY["KTL_NK"]);
			 if (KTL_ARRAY["KTL_STATE"] == 6) then
                KTL_CHAT_FRAME:AddMessage(format(KTL_DEBUG_STRING, "number of rested kills",KTL_ARRAY["KTL_RK"]));
             end
             if (KTL_ARRAY["KTL_STATE"] == 6) then
                KTL_CHAT_FRAME:AddMessage(format(KTL_DEBUG_STRING, "number of normal kills",KTL_ARRAY["KTL_NK"]));
             end
			 --Normal and Rested Kills Update
	         if (KTL_ARRAY["KTL_STATE"] == 3) then
			 --Titan Bar only, dont update to channel
	         else
				 KTL_CHAT_FRAME:AddMessage(format(KTL_REST_NORM, KTL_ARRAY["KTL_RK"], KTL_ARRAY["KTL_NK"], typestring), 1.0, 1.0, 0.0);
	         end;
	         --remainingxp divided by half of the xp you recieved gives you the normal kills
		 else		 
	        KTL_ARRAY["KTL_RK"]=ceil(ktl);
	        KTL_ARRAY["KTL_NK"]=0;
			 if (KTL_ARRAY["KTL_STATE"] == 6) then
                KTL_CHAT_FRAME:AddMessage(format(KTL_DEBUG_STRING, "number of rested kills",KTL_ARRAY["KTL_RK"]));
             end			 
			 --Rested Kills Only Update
	         if (KTL_ARRAY["KTL_STATE"] == 3) then
	         --Titan Bar only, dont update to channel
	         else
				 KTL_CHAT_FRAME:AddMessage(format(KTL_REST, KTL_ARRAY["KTL_RK"], typestring), 1.0, 1.0, 0.0);
	         end
		 end
     
	 else
        KTL_ARRAY["KTL_RK"]=0;
	    KTL_ARRAY["KTL_NK"]=ceil(ktl);
		 if (KTL_ARRAY["KTL_STATE"] == 6) then
             KTL_CHAT_FRAME:AddMessage(format(KTL_DEBUG_STRING, "number of normal kills",KTL_ARRAY["KTL_NK"]));
         end		 
		 --Normal Kills Only Update
		 if (KTL_ARRAY["KTL_STATE"] == 3) then
	       --Titan Bar only, dont update to channel
	     else
             KTL_CHAT_FRAME:AddMessage(format(KTL_NORM,KTL_ARRAY["KTL_NK"], typestring), 1.0, 1.0, 0.0);
	     end
	 end
     end
     end	 
     end 
     if (usingT==1) then TitanPanelButton_UpdateButton(TITAN_KTL_ID); end
	 if (usingF==1) then 
	     local label, text = KTL_TextUpdate();
	     KillsToLevelFu:UpdateText(label..text);
	 end
    KTL_XP = cXp;
    if (KTL_ARRAY["KTL_STATE"] == 6) then
         KTL_CHAT_FRAME:AddMessage(format(KTL_DEBUG_STRING, "current xp", KTL_XP));
    end
    KTL_MAXXP = UnitXPMax("player");
	if (KTL_ARRAY["KTL_STATE"] == 6) then
         KTL_CHAT_FRAME:AddMessage(format(KTL_DEBUG_STRING, "max xp", KTL_MAXXP));
    end
	
end

function StatusShow()
	DEFAULT_CHAT_FRAME:AddMessage(format(KTL_VERSION..".",KTL_Version));
	local frametype;
	if (KTL_ARRAY["KTL_FRAME"] == 2) then
	  frametype = KTL_COMBAT_FRAME;
        elseif (KTL_ARRAY["KTL_FRAME"] == 1) then
          frametype = KTL_GENERAL_FRAME;
        end
        DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_FRAME,frametype));
	if (KTL_ARRAY["KTL_STATE"] == 0) then
		DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_OFF));
	elseif (KTL_ARRAY["KTL_STATE"] == 1) then
		DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_ON));
	elseif (KTL_ARRAY["KTL_STATE"] == 2) then
		DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_AVERAGE));
	elseif (KTL_ARRAY["KTL_STATE"] == 3) then
		DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_TITAN));
	elseif (KTL_ARRAY["KTL_STATE"] == 6) then
		DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_DEBUG));
	end
        if (KTL_ARRAY["KTL_QUEST_STATE"] == 0) then
                DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_QUEST_ON));
        else
                DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_QUEST_OFF));
        end
                
end

function KillMod_SlashHandler(msg)
	local index, value;
	if (not msg or msg == "") then --Show Help
		for index, value in KTL_HELP_TEXT do
			DEFAULT_CHAT_FRAME:AddMessage(value);
		end		
	else
		local command=strlower(msg);
		if (command == KTL_STATUS) then
			StatusShow();
		elseif (command == KTL_ON) then
			KTL_ARRAY["KTL_STATE"] = 1;
			DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_ON));
		elseif (command == KTL_OFF) then
			KTL_ARRAY["KTL_STATE"] = 0;
			DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_OFF));
		elseif (command == KTL_HELP) then  --Show Help, again
			for index, value in KTL_HELP_TEXT do
			    DEFAULT_CHAT_FRAME:AddMessage(value);
			end
		elseif (command == KTL_SLASH_FRAME) then  --Change KTl Frame
			--Dunno how to yet, so just toggling
			if (KTL_ARRAY["KTL_FRAME"] == 2) then
				KTL_ARRAY["KTL_FRAME"] = 1;
				KTL_CHAT_FRAME = getglobal("ChatFrame"..KTL_ARRAY["KTL_FRAME"]);
				DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_FRAME,KTL_GENERAL_FRAME));
			else
				KTL_CHAT_FRAME = getglobal("ChatFrame"..KTL_ARRAY["KTL_FRAME"]);
				KTL_ARRAY["KTL_FRAME"] = 2;
				DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_FRAME,KTL_COMBATL_FRAME));
			end
		elseif (command == KTL_DEBUG) then  --toggle debug
			if (KTL_ARRAY["KTL_STATE"] == 6) then
				KTL_ARRAY["KTL_STATE"] = 1;
				DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_ON));
			else
				KTL_ARRAY["KTL_STATE"] = 6;
				DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_DEBUG));
			end
		elseif (command == KTL_AVERAGE) then --toggle average
			if (KTL_ARRAY["KTL_STATE"] == 2) then
				KTL_ARRAY["KTL_STATE"] = 1;
				DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_ON));
			else
				KTL_ARRAY["KTL_STATE"] = 2;
				DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_AVERAGE));
			end
		elseif (command == KTL_TITAN) then --toggle Titan only mode
			if (KTL_ARRAY["KTL_STATE"] == 3) then
				KTL_ARRAY["KTL_STATE"] = 1;
				DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_ON));
			else
				KTL_ARRAY["KTL_STATE"] = 3;
				DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_TITAN));
			end
		elseif (command == KTL_QUEST_O) then --toggle Titan Quest mode
			if (KTL_ARRAY["KTL_QUEST_STATE"] == 1) then
				KTL_ARRAY["KTL_QUEST_STATE"] = 0;
				DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_QUEST_ON));
			else
				KTL_ARRAY["KTL_QUEST_STATE"] = 1;
				DEFAULT_CHAT_FRAME:AddMessage(format(KTL_HELP_QUEST_OFF));
			end
		end			
	end
end

