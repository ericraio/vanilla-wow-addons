WizOptions={
	["LLT"]=nil,
	["CLT"]=nil,
	["PD"]=nil,
	["TIS"]=nil,
	["TTP"]=nil,

}
MyCall=nil
LastTime=0
oz=nil
TX=nil
CX=nil
PT=0
function LevelWiz_OnDragStart()
LevelWizFrame:StartMoving()
end

function LevelWiz_OnDragStop()
LevelWizFrame:StopMovingOrSizing()	
end

function LevelWiz_OnLoad()
LevelWizFrame:RegisterForDrag("LeftButton");
LevelWizFrame:RegisterEvent("PLAYER_XP_UPDATE");
LevelWizFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
LevelWizFrame:RegisterEvent("TIME_PLAYED_MSG");
LevelWizFrame:RegisterEvent("PLAYER_LEVEL_UP");
SlashCmdList["LevelWiz"]=LevelWiz;
SLASH_LevelWiz1="/LevelWiz"
tt = GetAddOnMetadata("LevelWiz", "Title") 
vt = GetAddOnMetadata("LevelWiz", "Version") 
DEFAULT_CHAT_FRAME:AddMessage( tt.." "..vt.." Loaded", .3, .5, 1.0,.3 ); 
end

function CloseClick()
DEFAULT_CHAT_FRAME:AddMessage( "Hiding window, Use /LevelWiz to show window.", .5, 1.0, .3 ); 
LevelWizFrame:Hide()
end

function LevelWiz_OnEvent()
if (event == "PLAYER_ENTERING_WORLD") then
Calc()
end

if (event == "PLAYER_XP_UPDATE") then
Calc()
end

if (event == "TIME_PLAYED_MSG") then
event=""
WizOptions.TTP = SecondsToTime(arg1)
WizOptions.CLT = SecondsToTime(arg2)
WizOptions.TIS = arg2
end

if (event == "PLAYER_LEVEL_UP") then
WizOptions.LLT = WizOptions.CLT
SendChatMessage("After "..WizOptions.LLT..UnitName("PLAYER").." has reached Level "..arg1,"Guild") 
end

end


function LevelWiz()
LevelWizFrame:Show()
end

function Calc()
TX=UnitXPMax("PLAYER")
CX=UnitXP("PLAYER")
WizOptions.PD=tonumber(format("%.2f", (CX / TX) * 100))
if WizOptions.PD==nil then WizOptions.PD=0;end
LevelWizText:SetText("|cff7fff4c"..WizOptions.PD.."% of level completed.|r")
end

function LevelWiz_Info()
Calc()
GameTooltip:SetOwner(LevelWizFrame, "ANCHOR_BOTTOMRIGHT");
PL= 100 - WizOptions.PD
TX=UnitXPMax("PLAYER")
CX=UnitXP("PLAYER")
RX = GetXPExhaustion()
if WizOptions.LLT==nil then WizOptions.LLT="Unknown";end
if RX~=nil then RP = format("%.2f", (RX / (TX-CX)) * 100) ; else RP=0;end
if PL<1 then TPL = "<1";else TPL=PL;end
if tonumber(RP)<1 then TRP="<1";else TRP=RP;end
if tonumber(RP)==0 then TRP=0;end
GameTooltip:SetText("|cffffffff"..TPL.."% Remaining of which "..TRP.."% is rested")
if TP==nil then TP="Unknown";end
if WizOptions.TIS~=nil then ET = (WizOptions.TIS / WizOptions.PD) * PL; else ET="Calculating...";end
GameTooltip:AddLine("Time on current level: "..WizOptions.CLT)
GameTooltip:AddLine("Time on last level: "..WizOptions.LLT)
GameTooltip:AddLine("Estimated time to level up: "..SecondsToTime(ET))
GameTooltip:AddLine("|cff7fff4cTotal Time Played "..WizOptions.TTP.."|r")
GameTooltip:Show();
end

function LevelWiz_OnUpdate()
if PT>100 then RequestTimePlayed();PT=0;end
PT = PT +1
end