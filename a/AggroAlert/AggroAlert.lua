--
-- AggroAlert
-- v1.5
-- By Sathanas of Khadgar
--
-- Creates a movable frame that will display the target's target (if any), and allow for 
-- visible warning on player gaining aggro.
--
-- To move the AggroAlert bubble, use Shift+Left Button and drag it to a new position.
--
-- Clicking on the AggroAlert bubble will target the unit named in the bubble
--
-- v1.5 Changes:
--
-- Updated TOC for 1.7 patch.
-- Added an option in the /agg warning command to disable all text warnings.
--
--
-- v1.4 Changes:
--
-- Removed buggy call command. Seeing a pattern here?
-- Background of the AggroAlert bubble is now a healthbar for the named unit in the bubble.
--
--
-- v1.3 Changes:
--
-- Ditched the buggy spell alert that was in 1.3 beta. It sucked.
-- Added Healer Mode, the bubble will display "- Tank" or "- Idle" when targetting an ally, showing
-- whether their target is currently aggrod on them (i.e. the ally is tanking) or not.
-- Also added the new command "/agg call" which turns on automatic announcment of targets target changes
-- in the appropriate channel. When your target changes targets (i.e. the main tank loses aggro) 
-- AggroAlert will broadcast a message to the channel, example "Target Change! Onyxia is now engaged on SomeDumbGuy!", 
-- this alert disables itself when you change targets or exit combat, and must be turned on individually each
-- time with "/agg call", this is done mainly since this is a very situational feature.
--
--
-- v1.2 Changes:
--
-- Slash commands have changed, use "/agg mode" to toggle modes, and "/agg warning" to toggle between
-- the original smaller warning, and a new gigantic one.
-- Hopefully fixed all the errors caused by stun/sap/poly etc
--
--
-- v1.1 Changes:
--
-- AggroAlert now uses the slash command /aggroalert or /agg to toggle between 2 modes:
-- DPS Mode will alert you visibly on screen when the targetted unit targets onto you (You pulled aggro)
-- Tank Mode will alert you when the targeted unit CEASES targetting on you (Someone else pulled aggro)
--
--

local aggroWarningCount = 0;
local PlayerName = UnitName("player");

AggroAlertMode = {};
AggroAlertWarning = {};

function AggroAlert_OnLoad()
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("UNIT_COMBAT");	
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");	
	this:RegisterEvent("VARIABLES_LOADED");	
end

function AggroAlert_Command(cmd)
    if (cmd) then
        if (cmd == "mode") then
            if (AggroAlertMode[PlayerName] == 0) then       -- DPS Mode
                AggroAlertMode[PlayerName] = 1;
                DEFAULT_CHAT_FRAME:AddMessage("AggroAlert is now operating in Tank Mode",1,0,0);    
            elseif (AggroAlertMode[PlayerName] == 1) then   -- Tank Mode
                AggroAlertMode[PlayerName] = 2;
                DEFAULT_CHAT_FRAME:AddMessage("AggroAlert is now operating in Healer Mode",1,0,0);    
            elseif (AggroAlertMode[PlayerName] == 2) then
                AggroAlertMode[PlayerName] = 0;
                DEFAULT_CHAT_FRAME:AddMessage("AggroAlert is now operating in DPS Mode",1,0,0);
            end             
        elseif (cmd == "warning") then
            if (AggroAlertWarning[PlayerName] == 0) then    -- Little Warning
                AggroAlertWarning[PlayerName] = 1;
                DEFAULT_CHAT_FRAME:AddMessage("AggroAlert Warning style set to Giganto Mode",1,0,0);
            elseif (AggroAlertWarning[PlayerName] == 1) then    -- Big Warning
                AggroAlertWarning[PlayerName] = 2;
                DEFAULT_CHAT_FRAME:AddMessage("AggroAlert Warning text disabled",1,0,0);                
            elseif (AggroAlertWarning[PlayerName] == 2) then    -- Warning Off
                AggroAlertWarning[PlayerName] = 0;
                DEFAULT_CHAT_FRAME:AddMessage("AggroAlert Warning style set to Small Mode",1,0,0);                
            end
        else
            DEFAULT_CHAT_FRAME:AddMessage("Valid AggroAlert commands are:",1,0,0);
            DEFAULT_CHAT_FRAME:AddMessage("/agg mode - Toggle operating mode between DPS ,Tank, and Healer modes.",1,0,0);
            DEFAULT_CHAT_FRAME:AddMessage("/agg warning - Toggle between small, large, and no warning text.",1,0,0);       
        end        
    end
end

function AggroAlert_OnEvent(event)
	if( event == "PLAYER_TARGET_CHANGED" or event == "UNIT_COMBAT" or event == "PLAYER_REGEN_DISABLED") then		
	   AggroAlert_Go();		
    end    
    if (event == "PLAYER_REGEN_ENABLED") then
        aggroWarningCount = 0;
        AggroAlert_Call = 0;
        CallTime = 0;
        AggroAlert_Go();
    end
    if (event == "VARIABLES_LOADED") then
    
        if (AggroAlertMode == nil) then
            AggroAlertMode = {};
        end
        if (AggroAlertWarning == nil) then
            AggroAlertWarning = {};
        end
        
        if (AggroAlertMode[PlayerName] == nil) then
            AggroAlertMode[PlayerName] = {};
            AggroAlertMode[PlayerName] = 0;
            DEFAULT_CHAT_FRAME:AddMessage("AggroAlert is setting initial mode...");
        end
        if (AggroAlertWarning[PlayerName] == nil) then
            AggroAlertWarning[PlayerName] = {};
            AggroAlertWarning[PlayerName] = 0;
            DEFAULT_CHAT_FRAME:AddMessage("AggroAlert is setting initial warning style...");
        end
                    
        SLASH_AGGROALERT1 = "/aggroalert";
	    SLASH_AGGROALERT2 = "/agg";
	    SlashCmdList["AGGROALERT"] = AggroAlert_Command;
    end  
end

function AggroAlert_Go()
    if (UnitName("target")) then
    -- Player has something targetted
        if (UnitIsCorpse("target")) then AggroAlert();
        elseif (UnitIsDead("target")) then AggroAlert();
        else AggroAlert("Idle");
        end        
            if (UnitAffectingCombat("target")) then        
            -- Target is in an active combat situation
                if (UnitIsDead("targettarget") or UnitIsCorpse("targettarget")) then
                    -- Im thinking targetting something that is targetting a corpse or dead thing is causing crashes
                    -- Hence this safety check. If it is, we do nothing and hide the bubble.
                    AggroAlert();
                else
                    if (UnitName("targettarget")) then
                    -- Stupid mobs dont have targets when they are trapped/polyd/sapped/stunned, check for this 
                           
                        if (AggroAlertMode[PlayerName] == 0) then  -- DPS Mode           
                            if (UnitName("targettarget") == UnitName("player")) then
                            -- Its coming right for us!
                                AggroAlert("*** YOU ***",0,1);
                                if (aggroWarningCount == 0) then
                                    if (AggroAlertWarning[PlayerName] == 0) then
                                        UIErrorsFrame:AddMessage(UnitName("target").." has changed targets to you!",1,0,0,1,3);
                                    elseif (AggroAlertWarning[PlayerName] == 1) then
                                        AggroAlertFadingFrame_Show(UnitName("target").." has changed targets to you!");
                                    elseif (AggroAlertWarning[PlayerName] == 2) then
                                        -- Warning disabled, left in for future additions that may require this condition
                                    end
                                    aggroWarningCount = 1;
                                end
                            else
                            -- Whew it isnt fighting us
                                    AggroAlert(UnitName("targettarget"),1,0);
                                    aggroWarningCount = 0;                  
                            end           
                        elseif (AggroAlertMode[PlayerName] == 1) then  -- Tank mode          
                            if (UnitName("targettarget") == UnitName("player")) then
                            -- Its coming right for us! (A good thing, im tanking it)
                                AggroAlert("*** YOU ***",1,0);
                                aggroWarningCount = 0;
                            else
                            -- Some dumb hunter pulled aggro
                                    AggroAlert(UnitName("targettarget"),0,1);
                                    if (aggroWarningCount == 0) then
                                        if (AggroAlertWarning[PlayerName] == 0) then                    
                                            UIErrorsFrame:AddMessage("You have lost aggro to "..UnitName("targettarget").."!",1,0,0,1,3);
                                        elseif (AggroAlertWarning[PlayerName] == 1) then
                                            AggroAlertFadingFrame_Show("You have lost aggro to "..UnitName("targettarget").."!");
                                        elseif (AggroAlertWarning[PlayerName] == 2) then
                                            -- Warning disabled, left in for future additions that may require this condition
                                        end
                                        aggroWarningCount = 1;
                                    end                           
                            end           
                        elseif (AggroAlertMode[PlayerName] == 2) then   -- Healer Mode
                            if (UnitIsPlayer("target")) then
                                if (UnitIsFriend("player", "target")) then
                                    if (UnitIsUnit("target", "targettargettarget")) then    -- The target and the targets target target (whew) are the same
                                        AggroAlert(UnitName("targettarget").." - Tank",1,0);
                                            if (aggroWarningCount == 0) then
                                            if (AggroAlertWarning[PlayerName] == 0) then
                                                UIErrorsFrame:AddMessage(UnitName("target").." is now tanking "..UnitName("targettarget"),1,0,0,1,3);
                                            elseif (AggroAlertWarning[PlayerName] == 1) then
                                                AggroAlertFadingFrame_Show(UnitName("target").." is now tanking "..UnitName("targettarget"));
                                            elseif (AggroAlertWarning[PlayerName] == 2) then
                                                -- Warning disabled, left in for future additions that may require this condition
                                            end
                                            aggroWarningCount = 1;
                                        end
                                    else                                                    -- Lazy warrior isnt tanking anything!
                                        AggroAlert(UnitName("targettarget").." - Idle",1,0);
                                        aggroWarningCount = 0;
                                    end
                                else
                                    if (UnitName("targettarget") == UnitName("player")) then
                                    -- Its coming right for us!
                                        AggroAlert("*** YOU ***",0,1);
                                        if (aggroWarningCount == 0) then
                                            if (AggroAlertWarning[PlayerName] == 0) then
                                                UIErrorsFrame:AddMessage(UnitName("target").." has changed targets to you!",1,0,0,1,3);
                                            elseif (AggroAlertWarning[PlayerName] == 1) then
                                                AggroAlertFadingFrame_Show(UnitName("target").." has changed targets to you!");
                                            elseif (AggroAlertWarning[PlayerName] == 2) then
                                                -- Warning disabled, left in for future additions that may require this condition
                                            end
                                            aggroWarningCount = 1;
                                        end
                                    else
                                    -- Whew it isnt fighting us
                                        AggroAlert(UnitName("targettarget"),1,0);
                                        aggroWarningCount = 0;                  
                                    end                                
                                end
                            else
                                if (UnitName("targettarget") == UnitName("player")) then
                                -- Its coming right for us!
                                    AggroAlert("*** YOU ***",0,1);
                                    if (aggroWarningCount == 0) then
                                        if (AggroAlertWarning[PlayerName] == 0) then
                                            UIErrorsFrame:AddMessage(UnitName("target").." has changed targets to you!",1,0,0,1,3);
                                        elseif (AggroAlertWarning[PlayerName] == 1) then
                                            AggroAlertFadingFrame_Show(UnitName("target").." has changed targets to you!");
                                        elseif (AggroAlertWarning[PlayerName] == 2) then
                                            -- Warning disabled, left in for future additions that may require this condition
                                        end
                                        aggroWarningCount = 1;
                                    end
                                else
                                -- Whew it isnt fighting us
                                    AggroAlert(UnitName("targettarget"),1,0);
                                    aggroWarningCount = 0;                  
                                end                             
                            end                      
                        end                        
                    end                
                end            
            end
     else
     -- Player has nothing targetted
        AggroAlert();
    end    
end


function AggroAlert(text, swords, skull)
    AggroAlert_Skull:Hide();
    AggroAlert_Swords:Hide();
    AggroAlert_Bubble:Hide();
    AggroAlert_Frame:Show();
	AggroAlert_Text:Show();
	
    if (text == nil) then
        AggroAlert_Skull:Hide();
        AggroAlert_Swords:Hide();
        AggroAlert_Bubble:Hide();
        AggroAlert_Frame:Hide();
	   AggroAlert_Text:Hide();
	else
        AggroAlert_Text:SetText(text);
        AggroAlert_Frame:SetWidth(AggroAlert_Text:GetWidth() + 30);
        AggroAlert_Bar:SetWidth(AggroAlert_Frame:GetWidth() - 6);
        if (UnitIsFriend("targettarget","player") or UnitInParty("targettarget") or UnitInRaid("targettarget")) then
            AggroAlert_Bar:SetAlpha(.5);
        elseif (UnitIsUnit("targettarget","player")) then
            AggroAlert_Bar:SetAlpha(.6);
        else
            AggroAlert_Bar:SetAlpha(.4);
        end
        if (UnitHealthMax("targettarget") > 100) then
            local thingy = UnitHealth("targettarget") / UnitHealthMax("targettarget");
            thingy = thingy * 100;
            AggroAlert_Bar:SetValue(thingy);                
        else
            AggroAlert_Bar:SetValue(UnitHealth("targettarget"));
        end        	   
        if (swords == 1) then
	       AggroAlert_Bubble:Show();
	       AggroAlert_Swords:Show();
        end    
        if (skull == 1) then
	       AggroAlert_Bubble:Show();
            AggroAlert_Skull:Show();
        end    
    end
end

function AggroAlert_TargetUnit()
    AssistUnit("target");
    aggroWarningCount = 0;
end

--
-- Fade in/out frame stuff
-- Ripped/modified from FadingFrame from Blizzard
--

function AggroAlertFadingFrame_OnLoad()
	AggroAlert_BigWarning:Hide();
end

function AggroAlertFadingFrame_Show(message)
	AggroAlertstartTime = GetTime();
	if (message) then
	   AggroAlert_BigWarning_Text:SetText(message);
    end
	AggroAlert_BigWarning:Show();
end


function AggroAlertFadingFrame_OnUpdate()
	local elapsed = GetTime() - AggroAlertstartTime;
	local fadeInTime = 0.2;
	if ( elapsed < fadeInTime ) then
		local alpha = (elapsed / fadeInTime);
		AggroAlert_BigWarning:SetAlpha(alpha);
		return;
	end
	local holdTime = 2.5;
	if ( elapsed < (fadeInTime + holdTime) ) then
		AggroAlert_BigWarning:SetAlpha(1.0);
		return;
	end
	local fadeOutTime = 2;
	if ( elapsed < (fadeInTime + holdTime + fadeOutTime) ) then
		local alpha = 1.0 - ((elapsed - holdTime - fadeInTime) / fadeOutTime);
		AggroAlert_BigWarning:SetAlpha(alpha);
		return;
	end
	AggroAlert_BigWarning:Hide();
end   
