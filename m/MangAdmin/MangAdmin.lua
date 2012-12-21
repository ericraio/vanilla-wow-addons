--[[
Mang Admin Notes
Writen by: Athrus of Sandoria
Website: http://mangadmin.thruhere.net
This is an addon i made to help GMs of MangOS servers.
Feel free to distrube this for free. If you paid for this, you got ripped off.
If you edit anything please leave my name as the creator.
That's all :), Enjoy.

PS. This is coded in my own unique style. AKA no comments and variable names that will 
need to be deciphered. Edit this at your own risk of personal health loss and
mental instability. <3 Athrus.

Special Thanks To:
Weedy, for helping me test.
Creators of WoW UI Designer
www.wowwiki.com
wow.mmhell.com
www.wowinterface.com
]]


Xvalue = "-8913.230469"
Yvalue = "554.632996"
Zvalue = "93.794403"
MAPvalue = "0"
Xfor = Xvalue;
Yfor = Yvalue;
Zfor = Zvalue;
Mfor = MAPValue;
options={["Supress"]=0, ["Notes"]=0,["PMGreet"]=0,["PMSystem"]=0, ["PMBye"]=0,["PMSystem"]=0,["PMGreetMSG"]="Greetings. I am currently busy with another player. Please wait and I will address you shortly. This is an automated message.",["PMByeMSG"]="Enjoy your travels in Azeroth.",["NotesChan"]="MangAdminDefaultChannel", ["Mini"]=0,["Maplocal"]=45};
PMMessages={};
PMLang={};
PMNames={};
PMNameColors={};
version="0.10a";
PMcheck=false;
vertext="";
PMListOffset=0;
MessCurUser="";
lastlineno=0;
pname=UnitName("player");
pnamelen=string.len(pname);
pnameoutlen=2+pnamelen;
bypassgps=false;
transfer=false;
allowtrans=true;
TBBarOpen=false;
TB_LocationNames={};
TB_LocationNames[1]={"Darnassus","10037.599609","2496.800049","1318.400024", "1"};
TB_LocationNames[2]={"Booty Bay","-14440.948242","487.123627","28.746725", "0"};
TB_LocationNames[3]={"Dustwallow Marsh","-2840.130859","-3338.907715","31.947880", "1"};
TB_LocationNames[4]={"Gadgetzan","-7160.931152","-3816.634766","8.371173", "1"};
TB_LocationNames[5]={"Ironforge","-4981.250000","-881.541992","501.660004", "0"};
TB_LocationNames[6]={"Orgrimmar","1676.209961","-4315.290039","61.529301", "1"};
TB_LocationNames[7]={"Stormwind","-8913.230469","554.632996","93.794403", "0"};
TB_LocationNames[8]={"Undercity","1586.479980","239.561996","-52.148998", "0"};
TB_LocationNames[9]={"Azshara","2711.686523","-3880.104248","102.469734","1"};
TB_LocationNames[10]={"Southshore","-846.814636","-526.218323","10.981694","0"};
IB_Sets={};
IB_Sets[1]={"Netherwind Regalia","210"};
IB_Sets[2]={"Vestments of Transcendence","211"};
IB_Sets[3]={"Nemesis Raiment","212"};
IB_Sets[4]={"Bloodfang Armor","213"};
IB_Sets[5]={"Stormrage Raiment","214"};
IB_Sets[6]={"Dragonstalker Armor","215"};
IB_Sets[7]={"The Ten Storms","216"};
IB_Sets[8]={"Judgement Armor","217"};
IB_Sets[9]={"Battlegear of Wrath","218"};
IB_Sets[10]={"Frostfire Regalia","526"};
IB_Sets[11]={"Vestments of Faith","525"};
IB_Sets[12]={"Plagueheart Raiment","529"};
IB_Sets[13]={"Bonescythe Armor","524"};
IB_Sets[14]={"Dreamwalker Raiment","521"};
IB_Sets[15]={"Cryptstalker Armor","530"};
IB_Sets[16]={"The Earthshatterer","527"};
IB_Sets[17]={"Redemption Armor","528"};
IB_Sets[18]={"Dreadnaught's Battlegear","523"};
IB_Sets[19]={"5 Onyxia Bags","a1","17966","17966","17966","17966","17966"};
IB_SetsDefault=18;
IB_Items={};
IB_Items[1]={"Onyxia Hide Backpack","17966"};
IB_Items[2]={"Snowball","17202"};
IB_SetCreator={};
IB_SetiNum=1;
IB_MadeNum=0;
newSetNum=0;
pkey=1;
gkey=1;
--Key, Username, Leader, Title, Body, Confirmed, Place Number, PostKey, Type
ANArray={}
ANArray[1]={0,"Athrus","Athrus","Hello","Hello World",0,1,1,"start"};
ANArray[2]={1,"Ziggy","Athrus","RE: Hello","How annoying is this?\nPoop",0,2,1,"reply"};
ANUsers={};
ANUsers["Athrus"]={1,0};
ANUsers["Ziggy"]={1,0};
gkey=3;
pkey=3;
ANOffset=0;
ANSynch=false;
chanNum=0;
active=false;
postKey="`";--DO NOT CHANGE FOR THE LOVE OF GOD
--GM Buddy Stuff
GMArray={}
GMArray["Profs"]={333, 171, 164, 165, 202, 197, 182, 186, 393, 129, 185, 356}
GMArray["Weapons"]={43,44,45,46,54,55,95,118,136,160,162,172,173,176,226,228,229,473}
GMArray["Armor"]={293, 413, 414, 415, 433}
GMArray["Spells"]={674, 2480, 7918, 7919, 5019,7738}
GMArray["ProfSpells"]={13920, 13262,11611,9785,10662,12656,12180,2383, 11993, 10248, 2580, 10768, 10846, 18260, 818, 18248}
GMArray["Pimp"]={23402,6668,11540,11541,11542,11543,11544,21713,26636,31700,25953,26054,26055,26056}
GMArray["Morph"]={}
GMArray["Morph"]["Onyxia"]=8570
GMArray["Morph"]["Sheep"]=856
GMArray["Morph"]["Cow"]=1060
GMArray["Morph"]["Bunny"]=328
--Ticket Buddy Stuff
tCount=0;
tCounter=0;
tOffset=0;
tNum=0;
tInitial=false;
tArray={}--[#]={Name, Number, Message}

StaticPopupDialogs["ALLOW_TRANS"] = {
  text = "A user is trying to send you their Teleport Buddy locations?",
  button1 = "Accept",
  button2 = "Decline",
  OnAccept = function()
      TB_LocAccept("->None<-");
  end,
  timeout = 30,
  whileDead = 1,
  hideOnEscape = 1
};
StaticPopupDialogs["ALLOW_IB_TRANS"] = {
  text = "A user is trying to send you their Item Buddy array(s)?",
  button1 = "Accept",
  button2 = "Decline",
  OnAccept = function()
      IB_ARRAYAccept("->None<-");
  end,
  timeout = 30,
  whileDead = 1,
  hideOnEscape = 1
};
StaticPopupDialogs["TEST_SET"] = {
  text = "Your new set needs to be tested. MangAdmin will now create each of the items. Were all the items created properly?",
  button1 = "Yes",
  button2 = "No",
  OnAccept = function()
      SetCreator_Confirm();
  end,
  OnCancel = function ()
      SetCreator_Fail();
  end,
  timeout = 0,
  whileDead = 1,
  hideOnEscape = 1
};

local lOriginalChatFrame_OnEvent;

function MangAdmin_EventHandler(event)
if ( event == "VARIABLES_LOADED" ) then
       -- if (options)then
            Map_Pos();
            MenuManager("Mini");
            tB_Initialize();
            
      --  else

       -- end
	end
end

function MangAdmin_OnLoad()

  lOriginalChatFrame_OnEvent = ChatFrame_OnEvent;
  ChatFrame_OnEvent = MA_ChatFrame_OnEvent;

  SLASH_MANGADMIN1 = "/mangadmin";
  SLASH_MANGADMIN2 = "/ma";
  
  SlashCmdList["MANGADMIN"] = function(msg)
    MangAdmin_SlashCommandHandler(msg);
  end

   
  this:RegisterEvent("CHAT_MSG_SYSTEM");
  this:RegisterEvent("CHAT_MSG_WHISPER");
  this:RegisterEvent("CHAT_MSG_CHANNEL");
  this:RegisterEvent("VARIABLES_LOADED");
  outSYS("MangAdmin Loaded v"..version);
  out("Type .gps to place a bookmark.");
  

end



function MangReset()
Xvalue = "-8913.230469"
Yvalue = "554.632996"
Zvalue = "93.794403"
MAPvalue = "0"
options={["Supress"]=0, ["Notes"]=0,["PMGreet"]=0,["PMSystem"]=0, ["PMBye"]=0,["PMSystem"]=0,["PMGreetMSG"]="Greetings. I am currently busy with another player. Please wait and I will address you shortly. This is an automated message.",["PMByeMSG"]="Enjoy your travels in Azeroth.",["NotesChan"]="MangAdminDefaultChannel", ["Mini"]=0,["Maplocal"]=45 };
PMMessages={};
PMNames={};
PMNameColors={};
PMcheck=false;
vertext="";
PMListOffset=0;
MessCurUser="";
lastlineno=0;
pname=UnitName("player");
pnamelen=string.len(pname);
pnameoutlen=2+pnamelen;
bypassgps=false;
transfer=false;
allowtrans=true;
TB_LocationNames={};
TB_LocationNames[1]={"Darnassus","10037.599609","2496.800049","1318.400024", "1"};
TB_LocationNames[2]={"Booty Bay","-14440.948242","487.123627","28.746725", "0"};
TB_LocationNames[3]={"Dustwallow Marsh","-2840.130859","-3338.907715","31.947880", "1"};
TB_LocationNames[4]={"Gadgetzan","-7160.931152","-3816.634766","8.371173", "1"};
TB_LocationNames[5]={"Ironforge","-4981.250000","-881.541992","501.660004", "0"};
TB_LocationNames[6]={"Orgrimmar","1676.209961","-4315.290039","61.529301", "1"};
TB_LocationNames[7]={"Stormwind","-8913.230469","554.632996","93.794403", "0"};
TB_LocationNames[8]={"Undercity","1586.479980","239.561996","-52.148998", "0"};
TB_LocationNames[9]={"Azshara","2711.686523","-3880.104248","102.469734","1"};
TB_LocationNames[10]={"Southshore","-846.814636","-526.218323","10.981694","0"};
IB_Sets={};
IB_Sets[1]={"Netherwind Regalia","210"};
IB_Sets[2]={"Vestments of Transcendence","211"};
IB_Sets[3]={"Nemesis Raiment","212"};
IB_Sets[4]={"Bloodfang Armor","213"};
IB_Sets[5]={"Stormrage Raiment","214"};
IB_Sets[6]={"Dragonstalker Armor","215"};
IB_Sets[7]={"The Ten Storms","216"};
IB_Sets[8]={"Judgement Armor","217"};
IB_Sets[9]={"Battlegear of Wrath","218"};
IB_Sets[10]={"Frostfire Regalia","526"};
IB_Sets[11]={"Vestments of Faith","525"};
IB_Sets[12]={"Plagueheart Raiment","529"};
IB_Sets[13]={"Bonescythe Armor","524"};
IB_Sets[14]={"Dreamwalker Raiment","521"};
IB_Sets[15]={"Cryptstalker Armor","530"};
IB_Sets[16]={"The Earthshatterer","527"};
IB_Sets[17]={"Redemption Armor","528"};
IB_Sets[18]={"Dreadnaught's Battlegear","523"};
IB_Sets[19]={"5 Onyxia Bags","a1","17966","17966","17966","17966","17966"};
IB_SetsDefault=18;
IB_Items={};
IB_Items[1]={"Onyxia Hide Backpack","17966"};
IB_Items[2]={"Snowball","17202"};
IB_SetCreator={};
IB_SetiNum=1;
IB_MadeNum=0;
newSetNum=0;
end


function out(text)
 DEFAULT_CHAT_FRAME:AddMessage(text);
end

function outHUD(text)
 UIErrorsFrame:AddMessage(text, 1.0, 1.0, 0, 1,10);
end

function outERROR(text)
 DEFAULT_CHAT_FRAME:AddMessage(text, 1.0, 0.0, 0.0, 1.0);
 UIErrorsFrame:AddMessage(text, 1.0, 1.0, 0, 1,10);
end

function outPM(text,recipient)
 SendChatMessage(text, "WHISPER", nil,recipient);
end

function outPMSET(text,lang, recipient)
 SendChatMessage(text, "WHISPER", lang ,recipient);
end

function outSAY(text)
 SendChatMessage(text, "SAY", nil,nil);
end

function outSYS(text)
 DEFAULT_CHAT_FRAME:AddMessage(text, 1.0, 1.0, 0, 0);
end

function outNotes(text)
 SendChatMessage(text, "CHANNEL", nil, chanNum);
end

function outMESS(text,name)
MessengerMainFrame:AddMessage(text);
end



function MangAdmin_SlashCommandHandler(msg)
        if (msg == "reload") then
         ReloadUI();
        elseif (msg == "mark" or msg=="back") then
         MangAdmin_Mark(msg);
         out("Returning to your bookmarked location.");
        elseif (msg == "pm") then
         MangAdminForm4:Show();
        elseif (msg == "tele" or msg=="teleport") then
         MangAdminForm6:Show();
        elseif (msg == "item") then
         MangAdminForm7:Show();
        elseif (msg == "help") then
         MangHelp();
        elseif (msg == "info") then
         MangAdminForm2:Show();
        elseif (msg == "options") then
         MangAdminForm1:Show();
        elseif (msg == "menu") then
         MangAdminForm:Show();
        elseif (msg == "reset") then
         MangReset();
        elseif (msg == "gm") then
         MangAdminForm11:Show();
        elseif (msg == "easter") then
         Secret();
        out("What have you found???!");
        else
         MangAdminFrames_Toggle(msg);
        end
end

function MangAdminFrames_Toggle(num)
   local frame = getglobal("MangAdminForm" .. num)
   if (frame) then
   if(  frame:IsVisible() ) then
      frame:Hide();
   else
      frame:Show();
   end
   end
end

function MangAdmin_Mark(arg1)
msg=".go "..Xvalue.." "..Yvalue.." "..Zvalue.." "..MAPvalue;
outSAY(msg);
end

function InfoLoad()
local vertext="Version "..version;
local fs = getglobal("LBLVersion".."Label");
fs:SetText(vertext);
end


function Tele_Load(item)
UIDropDownMenu_ClearAll(CBXGo);
UIDropDownMenu_ClearAll(CBXBring);
UIDropDownMenu_Initialize(CBXGo, GoButtons);
UIDropDownMenu_SetButtonWidth(300,CBXGo);
UIDropDownMenu_Initialize(CBXBring, BringButtons); 

end

function GoButtons()
        local i = 0;
        local info = {};
        info.text = "Available Characters";
        info.textHeight = 18;
        info.isTitle = 1;
        UIDropDownMenu_AddButton(info);
        for  i = 1, table.getn(PMNames) do
                info = {};
                info.text = PMNames[i];
                info.textHeight = 18;
                info.func = function()
                    UIDropDownMenu_SetSelectedID(CBXGo, this:GetID(), 0);
                    GoBoxAutoChange();
                end
                UIDropDownMenu_AddButton(info);
        end
         UIDropDownMenu_SetText("Characters",CBXGo);
        
end

function BringButtons()
        local i = 0;
        local info = {};
        info.text = "Available Characters";
        info.textHeight = 18;
        info.isTitle = 1;
        UIDropDownMenu_AddButton(info);
        for  i = 1, table.getn(PMNames) do
                info = {};
                info.text = PMNames[i];
                info.textHeight = 18;
                info.func = function()
                    UIDropDownMenu_SetSelectedID(CBXBring, this:GetID(), 0);
                    BringBoxAutoChange();
                end
                UIDropDownMenu_AddButton(info);
        end
        UIDropDownMenu_SetText("Characters",CBXBring);        
        
end

function GoBoxAutoChange()
if (UIDropDownMenu_GetText(CBXGo)~="Characters")then
BXGo:SetText(UIDropDownMenu_GetText(CBXGo));
end
end

function BringBoxAutoChange()
if (UIDropDownMenu_GetText(CBXBring)~="Characters")then
BXBring:SetText(UIDropDownMenu_GetText(CBXBring));
end
end

function Tele_Event(event)
result="";
if (event=="GO" and (BXGo:GetText() and BXGo:GetText()~="")) then
result=".goname "..BXGo:GetText();    
outSAY(result);
end

if (event=="BRING" and (BXBring:GetText() and BXBring:GetText()~="")) then
result=".namego "..BXBring:GetText();    
outSAY(result);
end

end


function PM_Open(arg1)
if(options["PMSystem"]==1)then
MangAdminForm4:Show();
MangAdminForm:Hide();
else
outERROR("Private Message System is not enabled in the options.");
end
end

function OptionsLoad(item)
    if(item=="CHKNotes") then
        if(options["Notes"]==1) then
        CHKNotes:SetChecked(1);   
        end
    end
    
    if(item=="CHKPMGreet") then
        if(options["PMGreet"]==1) then
        CHKPMGreet:SetChecked(1);   
        end
    end
    
    if(item=="BXPMGreetMSG") then
        --if(options["PMGreet"]==1) then
        BXPMGreetMSG:SetText(options["PMGreetMSG"]);
       -- end
    end
    
    if(item=="BXPMByeMSG") then
        BXPMByeMSG:SetText(options["PMByeMSG"]);
        
    end
    
    if(item=="BXNotesChan") then
       -- if(options["Notes"]==1) then
        BXNotesChan:SetText(options["NotesChan"]);
       -- end
    end    
    
    if(item=="CHKPMSupress") then
        if(options["Supress"]==1) then
        CHKPMSupress:SetChecked(1);   
        end
    end
    if(item=="CHKPMBye") then
        if(options["PMBye"]==1) then
        CHKPMBye:SetChecked(1);   
        end
    end
    
    if(item=="CHKPMSystem") then
        if(options["PMSystem"]==1) then
        CHKPMSystem:SetChecked(1);   
        CHKPMBye:Show();
        CHKPMSupress:Show();
        end
    end    
    
    if(item=="CHKMini") then
        if(options["Mini"]==1) then
        CHKMini:SetChecked(1);   
        end
    end
    local Slider=getglobal("SliderLocalSlider");
    Slider:SetValue(options["Maplocal"]);
    
end

function OptionsSave(arg1)
    if (CHKPMGreet:GetChecked()) then
	    options["PMGreet"]=1;
    else
        options["PMGreet"]=0;
    end
    
    if (CHKPMSystem:GetChecked()) then
	    options["PMSystem"]=1;        
    else
        options["PMSystem"]=0;

    end
    
    if (CHKPMBye:GetChecked()) then

        options["PMBye"]=1;

    else
        options["PMBye"]=0;
    end
    
    if (CHKPMSupress:GetChecked()) then
	    options["Supress"]=1;        
    else
        options["Supress"]=0;

    end
    
    if (CHKNotes:GetChecked()) then
	    options["Notes"]=1;
    else
        options["Notes"]=0;
    end
    
    local Slider=getglobal("SliderLocalSlider");
    options["Maplocal"]=Slider:GetValue();
    
    options["PMGreetMSG"]=BXPMGreetMSG:GetText();
    options["PMByeMSG"]=BXPMByeMSG:GetText();
    options["NotesChan"]=BXNotesChan:GetText();
    
    if (CHKMini:GetChecked()) then
	    options["Mini"]=1;        
    else
        options["Mini"]=0;

    end
    out("Options Saved");
end

function OptionsEvents(event)
    if (event=="SAVE")then
    OptionsSave();
    elseif (event=="SAVE&CLOSE")then
    OptionsSave();
    MangAdminForm1:Hide();
    MangAdminForm:Show();
    elseif (event=="CLOSE")then
    MangAdminForm1:Hide();
    MangAdminForm:Show();
    end
    
    if(event=="PMSYSCLICK")then
    if (CHKPMSystem:GetChecked()) then
    CHKPMBye:Show();
    CHKPMSupress:Show();
    else
    CHKPMBye:Hide();
    CHKPMBye:SetChecked(0);
    CHKPMSupress:Hide();
    CHKPMSupress:SetChecked(0);
    end
    end
end

function PMChecker(arg1,arg2)
    if (PMcheck == true)then
    return true;
    else
        if (PMNames[arg1]==arg2) then
            return true;
        else
            return false;
        end
    end
end

function PM_AutoGreet(name)
outPM(options["PMGreetMSG"],name);
end

function explode(d,p)
	t={}
	ll=0
	while true do
		l=string.find(p,d,ll+1,true) -- find the next d in the string
		if l~=nil then -- if "not not" found then..
			table.insert(t, string.sub(p,ll,l-1)) -- Save it in our array.
			ll=l+1 -- save just after where we found it for searching next time.
		else
			table.insert(t, string.sub(p,ll)) -- Save what's left in our array.
			break -- Break at end, as it should be, according to the lua manual.
		end
	end
	return t
end

function MA_ChatFrame_OnEvent(event)
	CkMsg={}
    PMcheck=false;
    shutty=false;
    local quiet=false;
    
    if strsub(event,1,24) == "CHAT_MSG_WHISPER_INFORM" then
    local msg = arg1;
	local plr = arg2;
    local lang = arg3;
    local num=0;
    local messNum=0;
    quiet=true;
    if ( (msg and msg ~= nil) and (plr and plr ~= nil)  and msg~=options["PMByeMSG"] ) then
    
                for i=1,table.getn(PMNames) do
                    PMcheck=PMChecker(i,plr);
                    num=i;
                end
                num= num +1;
                if (PMcheck == false) then
                    PMNames[num]=plr;
                    PMMessages[plr]={};
                    PMLang[plr]=lang;
                end
                if (strsub(msg,1,11)=="INCLOCATION" or strsub(msg,1,9)=="TRANSDONE" or strsub(msg,1,15)=="ACCEPTTRANSSEND" or strsub(msg,1,14)=="INCTRANSTBLOCS" or strsub(msg,1,11)=="INCIBARRAYS" or strsub(msg,1,10)=="IBACCEPTED" or strsub(msg,1,13)=="TRANSCOMPLETE" or strsub(msg,1,19)=="RETURNTRANSCOMPLETE" or strsub(msg,1,8)=="INDARRAY" or strsub(msg,1,8)=="SETARRAY") then
                    transfer=true;
                end
                
                messNum=table.getn(PMMessages[plr]) + 1;
              
                if (transfer==false)then
                    if (msg~=options["PMByeMSG"])then
                    msg="["..pname.."]: "..msg;
                    PMMessages[plr][messNum]=msg;
                    end
                end
               
            end
    elseif strsub(event,1,16) == "CHAT_MSG_SYSTEM" then
		local msg = arg1;
		local plr = arg2;

		if ( (msg and msg ~= nil) and (plr and plr ~= nil) ) then
			--out("Received: "..msg);
            CkMsg =explode(" ",msg);
            if (CkMsg[1]=="Map:" and bypassgps==false) then
                MAPvalue=CkMsg[2];
            elseif (CkMsg[1]=="Map:" and bypassgps==true) then
                Mfor=CkMsg[2];
            elseif (CkMsg[1]=="X:" and bypassgps==false) then
                Xvalue=CkMsg[2];
                Yvalue=CkMsg[4];
                Zvalue=CkMsg[6];
                outHUD("Bookmark Placed. Type /ma mark to return here.");           
            elseif (CkMsg[1]=="X:" and bypassgps==true) then
                Xfor=CkMsg[2];
                Yfor=CkMsg[4];
                Zfor=CkMsg[6];
                TB_Setter();
            elseif (CkMsg[1]=="Tickets" and CkMsg[2]=="count:") then
                for i=1, 10 do
                    getglobal("BTNTB"..i):Hide();
                end
                tCount=0;
                tCounter=0;
                tArray={};
                tB_LoadTickets(CkMsg[3]);
                shutty=true;
            elseif (CkMsg[1]=="Ticket" and CkMsg[2]=="of") then
                tb_AddTicket(msg,CkMsg[3],strsub(CkMsg[5],1,1) );
                shutty=true;
            elseif (CkMsg[1]=="New" and CkMsg[2]=="ticket") then
                outSAY(".ticket");
            end
            
	    end
	elseif strsub(event,1,16) == "CHAT_MSG_CHANNEL" then
        local msg = arg1;
		local plr = arg2;
        local chanNumber = arg8;
           --out(event);
--            if (chanNumber == chanNum and pname==plr) then
--            --transfer=true;
--            elseif (chanNumber == chanNum and pname~=plr) then
--                local expMsg = explode(postKey,msg);
--                if (expMsg[1]== "CLUSTER UPDATEME")then
--                    if (ANSynch==true and active==false)then
--                        outNotes("CLUSTER UPDATE AVAILABLE");
--                        active=true;
--                    else
--                        outNotes("CLUSTER UPDATE BUSY");
--                    end
--                elseif (expMsg[1]== "CLUSTER UPDATE AVAILABLE" and active==false and ANSynch==false) then
--                    active=true;
--                    outPM("NOTES UPDATEME",plr);
--                elseif (expMsg[1]== "CLUSTER UPDATE BUSY") then
--                
--                elseif (expMsg[1]== "CLUSTER POST " and table.getn(expMsg)==9) then
--                    --out(expMsg[2]);
--                    AN_GET_Post(expMsg[2],expMsg[3],expMsg[4],expMsg[5],expMsg[6],expMsg[7],expMsg[8],expMsg[9]);
--                
--                elseif (expMsg[1]== "YOU_JOINED") then
--                elseif (expMsg[1]== "YOU_LEFT") then
--                else
--                    out("Invalid AdminNotes command recieved from: "..plr..msg);
--                end
--                --transfer=true;
--            
--            
--            end    
    elseif strsub(event,1,17) == "CHAT_MSG_WHISPER" then
        local msg = arg1;
		local plr = arg2;
        local chanNumber = arg7;
        local num=0;
        local messNum=0;
        local post=0;
        local exist=0;
        quiet=true;
       -- out(event);    
            if (strsub(msg,1,14)=="NOTES UPDATEME") then
                local newmsg= explode (",",msg);
                for j=1, j<table.getn(ANArray) do
                    post=0;
                    exist=0;
                    for i=2, i < table.getn(newmsg) do
                        if (newmsg[i]==ANArray[j][2] and newmsg[i+1]>ANArray[8]) then
                            post=1;
                            exist=1;    
                        elseif (newmsg[i]==ANArray[j][2]) then
                            exist=1;
                        end
                        i=i+1;
                    end
                    if ((post==1 or exist==0) and plr~=ANArray[j][2]) then
                    outPM("NOTES POST"..postKey..ANArray[j][2]..postKey..ANArray[j][3]..postKey..ANArray[j][4]..postKey..ANArray[j][5]..postKey..ANArray[j][6]..postKey..ANArray[j][7]..postKey..ANArray[j][8]..postKey..ANArray[j][9],plr);
                    end
                end
            end
            
                        
            if (strsub(msg,1,10)=="NOTES POST") then
                local newmsg= explode (postKey,msg);
                AN_GET_Post(newmsg[2],newmsg[3],newmsg[4],newmsg[5],newmsg[6],newmsg[7],newmsg[8],newmsg[9]);
            end
                        
            if (strsub(msg,1,14)=="INCTRANSTBLOCS") then
              --transfer=true;
                StaticPopupDialogs["ALLOW_TRANS"].text=plr.." is trying to send you Teleport Buddy locations. Do you accept?";
                StaticPopupDialogs["ALLOW_TRANS"].OnAccept= function() TB_LocAccept(plr); end;
                StaticPopup_Show ("ALLOW_TRANS");
             end
            if (strsub(msg,1,15)=="ACCEPTTRANSSEND") then
           -- transfer=true;
            TB_SendLocs(plr);
            end   
            
            if (strsub(msg,1,9)=="TRANSDONE") then
           -- transfer=true;
            out("Transfer Complete");
            outHUD("Transfer Complete");
            outPM("Transfer Done.",plr)
            MangAdminScrollBar_Update2();
            allowtrans=false;
            end 
            
            if (strsub(msg,1,11)=="INCLOCATION") then
            --transfer=true;
            local STOP=false;
                local locals =explode("`",msg);
                local startnum=table.getn(TB_LocationNames)+1;
                for i=9,table.getn(TB_LocationNames) do
                if (locals[2]==TB_LocationNames[i][1]) then
                STOP=true;
                end
                end
                if (STOP==false) then
                TB_LocationNames[startnum]={locals[2],locals[3],locals[4],locals[5],locals[6]};
                end
            end
            
            if (strsub(msg,1,11)=="INCIBARRAYS") then
                StaticPopupDialogs["ALLOW_IB_TRANS"].text=plr.." is trying to send you Item Buddy array(s). Do you accept?";
                StaticPopupDialogs["ALLOW_IB_TRANS"].OnAccept= function() IB_ARRAYAccept(plr); end;
                StaticPopup_Show ("ALLOW_IB_TRANS");
            end
            
            if (strsub(msg,1,10)=="IBACCEPTED") then
             -- transfer=true;
            IB_SendArray(plr);
            end   
            
            if (strsub(msg,1,13)=="TRANSCOMPLETE") then
            out("Transfer Complete");
            outPM("RETURNTRANSCOMPLETE",plr)
            end 
            
            if (strsub(msg,1,19)=="RETURNTRANSCOMPLETE") then
            out("Transfer Complete");
            end 
            
            if (strsub(msg,1,8)=="INDARRAY") then
            --transfer=true;
            local startnum=table.getn(IB_Items)+1;
            local STOP=false
                local locals =explode("`",msg);
                
                for i=1,table.getn(IB_Items) do
                    if (locals[2]==IB_Items[i][1]) then
                        STOP=true;
                    end
                end
                if (STOP==false) then
                    IB_Items[startnum]={locals[2],locals[3]};
                end
                
            end
            
            if (strsub(msg,1,8)=="SETARRAY") then
                local locals =explode("`",msg);
                local IB_MadeNums=0;
                local taken=false;
                local startnum=table.getn(IB_Sets)+1;
                    for i=1,table.getn(IB_Sets) do
                        if(strsub(IB_Sets[i][2],0,1)=="a") then
                            IB_MadeNums=IB_MadeNums+1;
                        end
                        if (locals[2]==IB_Sets[i][1])then
                            taken=true;
                        end
                    end
                    IB_MadeNums=IB_MadeNums+1;
                    if (taken==false) then
                        IB_SetiNum=1;
                        local label = getglobal("LBLiNum".."Label")
                        IB_Sets[startnum]={};
                        IB_Sets[startnum][1]="New"--locals[2];
                        IB_Sets[startnum][2]="a"..IB_MadeNums;
                        for i=3, table.getn(locals) do
                            IB_Sets[startnum][i]=locals[i+1]
                        end

                    end

               --transfer=true;
                
            end
            
            
            if ( (msg and msg ~= nil) and (plr and plr ~= nil) and msg~=options["PMByeMSG"] ) then
                for i=1,table.getn(PMNames) do
                    PMcheck=PMChecker(i,plr);
                    num=i;
                end
                

                
                if (PMcheck == false) then
                    num= num +1;
                    PMNames[num]=plr;
                    PMMessages[plr]={};
                    PMLang[plr]=GetDefaultLanguage("player");
                    if (options["PMGreet"]~=0) then
                        PM_AutoGreet(plr,num);                        
                    end
                end
                messNum=table.getn(PMMessages[plr]);
                messNum=messNum+1;
                if (strsub(msg,1,11)=="INCLOCATION" or strsub(msg,1,9)=="TRANSDONE" or strsub(msg,1,15)=="ACCEPTTRANSSEND" or strsub(msg,1,14)=="INCTRANSTBLOCS" or strsub(msg,1,11)=="INCIBARRAYS" or strsub(msg,1,10)=="IBACCEPTED" or strsub(msg,1,13)=="TRANSCOMPLETE" or strsub(msg,1,19)=="RETURNTRANSCOMPLETE" or strsub(msg,1,8)=="INDARRAY" or strsub(msg,1,8)=="SETARRAY") then
                transfer=true;
                end
                if (transfer==false)then
                PMMessages[plr][messNum]=msg;
                PMNameColors[plr]="green";
                if (MessCurUser~=plr and options["Supress"]==1)then
                PlaySound("MapPing");
                end
                end
            end
           

	
    end
    
    
	--End hook, return event to original function.
    if ((options["Supress"]==1 and quiet==true)or transfer==true or shutty==true)then
        transfer=false;
        return;
    else
	    lOriginalChatFrame_OnEvent(event);
    end

end

function PMList_OnLoad()
this:RegisterForDrag("LeftButton");
this:RegisterEvent("NAME_LIST_UPDATE");
end

function Secret()
BTNPimp:Show();
end

function PMList_OnEvent()
if ( event == "NAME_LIST_UPDATE" ) then
                PMList_Update();
        end
end

function PMList_OnDragStart()
MangAdminForm4:StartMoving()
end

function PMList_OnDragStop()
MangAdminForm4:StopMovingOrSizing()
end

function PMMess_OnDragStart()
MangAdminForm5:StartMoving()
end

function PMMess_OnDragStop()
MangAdminForm5:StopMovingOrSizing()
end

function PMMess_OnLoad()
this:RegisterForDrag("LeftButton");
end

function PMList_Set(i)
  local lable = getglobal ("Name"..i);
  local button= getglobal ("NameButton"..i);
  lable:SetText(PMNames[i + PMListOffset]);
  if (PMNameColors[PMNames[i + PMListOffset]]=="white" or PMNames[i + PMListOffset]==MessCurUser) then
  lable:SetTextColor(1,1,1);
    PMNameColors[PMNames[i + PMListOffset]]="white";
  else
  lable:SetTextColor(0,0.9,0);
  end
  button:Show();
  lable:Show(); 
end

function PMList_Hide(i)
  local lable = getglobal ("Name"..i);
  local button= getglobal ("NameButton"..i);
  button:Hide();
  lable:Hide(); 
end

function PMList_Update()
        if (options["PMSystem"]==0) then
            MangAdminForm4:Hide();
        end
        local name="Test";
        local messageNum=0;
        PMList_Button();
        if ( table.getn(PMNames) == 0 ) then
               NoNamesText:Show();               
        else
               NoNamesText:Hide();
        end
        
      --  if (table.getn(PMNames) < 10) then
            for i=1, 10 do
                PMList_Set(i);
            end        
       -- else
        --    for i=1, 10 do
        ---        PMList_Set(i+PMListOffset);
         --   end
       -- end 
        
        for i=table.getn(PMNames)+1, 10 do
        PMList_Hide(i)
        end
end

function PM_Pressed(lableNum)
    MessengerMainFrame:Clear();
    local plr="";
    local lable= getglobal("Name"..lableNum);
    local uName= getglobal("PMUser".."Label");    
    plr=lable:GetText();   
    PMNameColors[plr]="white";
    uName:SetText(plr);
    MessCurUser=plr;
    MangAdminForm5:Show();
    for i=1, table.getn(PMMessages[plr]) do
    if(strsub(PMMessages[plr][i],1,pnameoutlen)=="["..pname.."]")then
    outMESS(PMMessages[plr][i]);
    lastlineno=i;
    else
    outMESS("["..plr.."]: "..PMMessages[plr][i]);
    lastlineno=i;
    end
    end    
end

function PMMessenger_Update()
    local plr = MessCurUser;
    UIDropDownMenu_SetText(PMLang[plr], LangBox);
    if (lastlineno < table.getn(PMMessages[plr])) then
    lastlineno= lastlineno+1;
    if(strsub(PMMessages[plr][lastlineno],1,pnameoutlen)=="["..pname.."]")then
    outMESS(PMMessages[plr][lastlineno]);
    else
    outMESS("["..plr.."]: "..PMMessages[plr][lastlineno]);
    end  
    end
end

function PMMessenger_Send()
    local PMtext= BXMessengerSend:GetText();
    BXMessengerSend:SetText("");
    if (PMtext and PMtext ~=nil) then
  --      if (PMLang[plr] and PMLang[plr]~="unset")then
        outPMSET(PMtext,PMLang[MessCurUser],MessCurUser);   
        --out(PMLang[MessCurUser]);
--            else
        --out(PMLang[plr]);    
      --  outPM(PMtext,MessCurUser); 
    --    end
    end
end

function PMMessenger_Close()
    MessCurUser="";
end

 function MangAdminScrollBar_Update2()
  local line; -- 1 through 5 of our window to scroll
  local lineplusoffset; -- an index into our data calculated from the scroll offset
  local total= table.getn(TB_LocationNames)-10;

    FauxScrollFrame_Update(MangAdminScrollBar2,total,8,14);

   if (total >10) then
total=10;
end
  for line=1,total do
    lineplusoffset = line + FauxScrollFrame_GetOffset(MangAdminScrollBar2);
    if lineplusoffset < 9 then
      getglobal("Text1"..line):SetText(TB_LocationNames[lineplusoffset+10][1]);
      getglobal("MangAdminEntry1"..line):Show();
    else
          getglobal("Text1"..line):SetText(TB_LocationNames[lineplusoffset+10][1]);
      getglobal("MangAdminEntry1"..line):Show();
    end
  end
 end
 
function MangAdminScrollBar_Update()
  local line; -- 1 through 5 of our window to scroll
  local lineplusoffset; -- an index into our data calculated from the scroll offset
  FauxScrollFrame_Update(MangAdminScrollBar,10,8,14);
  for line=1,8 do
    lineplusoffset = line + FauxScrollFrame_GetOffset(MangAdminScrollBar);
    if lineplusoffset < 11 then
      getglobal("Text"..line):SetText(TB_LocationNames[lineplusoffset][1]);
      getglobal("MangAdminEntry"..line):Show();
    else
      getglobal("MangAdminEntry"..line):Hide();
    end
  end
 end


function TB_Send()
outPM("INCTRANSTBLOCS If you do not have MangAdmin installed, ignore this message and inform the sender.",BXUser:GetText());
end

function TB_SetText(int)
local txt=getglobal("Text"..int):GetText();
lblGoThere:SetText(txt);
end

function TB_GoThere()
local name=lblGoThere:GetText();
x,y,z,m = "";
for i=1, table.getn(TB_LocationNames) do
if (name==TB_LocationNames[i][1]) then
x=TB_LocationNames[i][2];
y=TB_LocationNames[i][3];
z=TB_LocationNames[i][4];
m=TB_LocationNames[i][5];
end
end

local msg=".go "..x.." "..y.." "..z.." "..m;
outSAY(msg);
end

function TB_Make()
bypassgps=true;
outSAY(".gps");
end

function TB_Setter()
local number = table.getn(TB_LocationNames) + 1;
TB_LocationNames[number]={BXLocation:GetText(),Xfor,Yfor,Zfor,Mfor};
bypassgps=false;
MangAdminScrollBar_Update2();
end

function TB_LocAccept(plr)
allowtrans=true;
transfer=true;
outPM("ACCEPTTRANSSEND",plr)
end

function TB_SendLocs(plr)
for i=11, table.getn(TB_LocationNames) do
outPM("INCLOCATION`"..TB_LocationNames[i][1].."`"..TB_LocationNames[i][2].."`"..TB_LocationNames[i][3].."`"..TB_LocationNames[i][4].."`"..TB_LocationNames[i][5], plr)
end
outPM("TRANSDONE",plr);
end

function ItemBuddy_SpawnSet()
local id=0;
if(strsub(BXItemSets:GetText(),0,1)=="a") then
id=strsub(BXItemSets:GetText(),2);
out("Creating the '"..IB_Sets[id+IB_SetsDefault][1].."' set");
for i=3, table.getn(IB_Sets[id+IB_SetsDefault])do
ItemBuddy_CallItem(IB_Sets[id+IB_SetsDefault][i]);
end
else
msg=".additemset "..BXItemSets:GetText();
outSAY(msg);
end
BXItemSets:SetText("");
end


function ItemBuddy_SpawnItem()
ItemBuddy_CallItem(BXIndID:GetText());
BXIndName:SetText("");
BXIndID:SetText("");
end

function ItemBuddy_CallItem(iID)
msg=".additem "..iID;
outSAY(msg);
end

function ItemBuddy_Load(item)
UIDropDownMenu_ClearAll(CBXItemSets);
UIDropDownMenu_Initialize(CBXItemSets, ItemBuddy_Sets);
UIDropDownMenu_ClearAll(CBXIndItems);
UIDropDownMenu_Initialize(CBXIndItems, ItemBuddy_Ind);
end

function ItemBuddy_Sets()
        local i = 0;
        local info = {};
        info.text = "Available Sets";
        info.textHeight = 18;
        info.isTitle = 1;
        UIDropDownMenu_AddButton(info);
        for  i = 1, table.getn(IB_Sets) do
                info = {};
                info.text = IB_Sets[i][1];
                info.textHeight = 18;
                info.func = function()
                    UIDropDownMenu_SetSelectedID(CBXItemSets, this:GetID(), 0);
                    SetBoxAutoChange();
                end
                UIDropDownMenu_AddButton(info);
        end
         UIDropDownMenu_SetText("Item Sets",CBXItemSets);
        
end

function SetBoxAutoChange()
local id;
for  i = 1, table.getn(IB_Sets) do
if (UIDropDownMenu_GetText(CBXItemSets)==IB_Sets[i][1])then
id=IB_Sets[i][2]
end
end

if (UIDropDownMenu_GetText(CBXItemSets)~="Item Sets")then
BXItemSets:SetText(id);
end
end

function ItemBuddy_Ind()
        local i = 0;
        local info = {};
        info.text = "Available Items";
        info.textHeight = 18;
        info.isTitle = 1;
        UIDropDownMenu_AddButton(info);
        for  i = 1, table.getn(IB_Items) do
                info = {};
                info.text = IB_Items[i][1];
                info.textHeight = 18;
                info.func = function()
                    UIDropDownMenu_SetSelectedID(CBXIndItems, this:GetID(), 0);
                    IndBoxAutoChange();
                end
                UIDropDownMenu_AddButton(info);
        end
         UIDropDownMenu_SetText("Individual Items",CBXIndItems);
        
end

function IndBoxAutoChange()
local id;
for  i = 1, table.getn(IB_Items) do
if (UIDropDownMenu_GetText(CBXIndItems)==IB_Items[i][1])then
id=IB_Items[i][2]
end
end

if (UIDropDownMenu_GetText(CBXIndItems)~="Item Sets")then
BXIndName:SetText(UIDropDownMenu_GetText(CBXIndItems));
BXIndID:SetText(id);
end
end

function ItemBuddy_AddInd()
local addnum=1;
local taken=false;
if ((BXIndName:GetText() and BXIndName:GetText()~="") and (BXIndID:GetText() and BXIndID:GetText()~="")) then

for i=1,table.getn(IB_Items) do 
if (BXIndName:GetText()==IB_Items[i][1])then
taken = true;
end
end
if (taken==true)then
outERROR("You have already added this item.")
else
addnum=table.getn(IB_Items) +1;
IB_Items[addnum]={BXIndName:GetText(), BXIndID:GetText()};
BXIndName:SetText("");
BXIndID:SetText("");

end
else
outERROR("There was a problem adding the item.")
end
end

function SetCreator_Step1()
    IB_SetCreator={};
    IB_MadeNum=0;
    local taken=false;
    if (BXSetName:GetText() and BXSetName:GetText()~="") then
        for i=1,table.getn(IB_Sets) do
            if(strsub(IB_Sets[i][2],0,1)=="a") then
                IB_MadeNum=IB_MadeNum+1;
            end
            if (BXSetName:GetText()==IB_Sets[i][1])then
                taken=true;
            end
        end
        IB_MadeNum=IB_MadeNum+1;
            if (taken==false) then
                IB_SetiNum=1;
                local label = getglobal("LBLiNum".."Label")
                label:SetText("Item #"..IB_SetiNum);
                IB_SetCreator[1]=BXSetName:GetText();
                IB_SetCreator[2]="a"..IB_MadeNum;
                BXSetName:SetText("");
                MangAdminForm8:Hide();
                MangAdminForm9:Show();
            end
        else
        outERROR("Error with set name");
    end
end

function SetCreator_Next()
if (BXCreatorID:GetText() and BXCreatorID:GetText()~="") then
IB_SetCreator[IB_SetiNum+2]=BXCreatorID:GetText();
BXCreatorID:SetText("");
IB_SetiNum=IB_SetiNum+1;
local label = getglobal("LBLiNum".."Label")
label:SetText("Item #"..IB_SetiNum);
BTNFinish:Enable();
else
outERROR("There was a problem with the ID you entered")
BXCreatorID:SetText("");
end
end

function SetCreator_Finish()
    if(BXCreatorID:GetText()=="" and IB_SetiNum < 3) then
        outERROR("You have not added enough items to make this a set.");
    else
        if (BXCreatorID:GetText() and BXCreatorID:GetText()~="")then
            IB_SetCreator[IB_SetiNum+2]=BXCreatorID:GetText();
            SetCreator_Finalize();
            IB_SetiNum=IB_SetiNum+1;
        else
            SetCreator_Finalize();
        end
    end
BXCreatorID:SetText("");
end

function SetCreator_Finalize()
local entries = table.getn(IB_SetCreator);
newSetNum = table.getn(IB_Sets)+1;
if (entries >2)then
IB_Sets[newSetNum]={}
for i=1,entries do
IB_Sets[newSetNum][i]=IB_SetCreator[i];
end
MangAdminForm9:Hide();
StaticPopup_Show ("TEST_SET");
out("Set Name: "..IB_Sets[newSetNum][1]);
out("Set ID: "..IB_Sets[newSetNum][2]);
for i=3,entries do
ItemBuddy_CallItem(IB_Sets[newSetNum][i])
end
else
outERROR("There has been a problem with the finalization of the set.")
end
end


function SetCreator_Confirm()
out("Set Created");
end

function SetCreator_Fail()
IB_Sets[newSetNum]=nil;
newSetNum=0;
outERROR("Set Creation Failed");
end

function ItemBuddy_Send()
if (CHKInd:GetChecked()==nil and CHKSet:GetChecked()==nil) then
outERROR("Please select at least 1 of the Item Buddy arrays to send.");
elseif (BXIBUser:GetText()=="" or BXIBUser:GetText()==nil)then
outERROR("Please enter a user to send the Item Buddy array(s) to.");
else
outPM("INCIBARRAYS If you do not have MangAdmin installed, ignore this message and inform the sender.",BXIBUser:GetText())
end
end

function IB_ARRAYAccept(plr)
outPM("IBACCEPTED",plr);
end

function IB_SendArray(plr)
local message="SETARRAY`";
    if (CHKInd:GetChecked()==1) then
        for i=2, table.getn(IB_Items)do
           outPM("INDARRAY`"..IB_Items[i][1].."`"..IB_Items[i][2],plr); 
        end
    end
    
    if (CHKSet:GetChecked()==1)then
        
        for i=19, table.getn(IB_Sets)do
            message="SETARRAY`";
            for ii=1,table.getn(IB_Sets[i]) do
                message=message..IB_Sets[i][ii].."`";
            end
            outPM(message,plr); 
        end
        
    
    end
     outPM("TRANSCOMPLETE",plr);
end

function MangHelp()
outSYS("Welcome to MangAdmin version "..version);
outSYS("Allowed commands are: help, menu, info, options, pm, tele, items, gm and reset");
end

function PMMessenger_End()
    local plr = MessCurUser;
    MangAdminForm5:Hide();
    throughVar=1;
    for i=1,table.getn(PMNames) do
        if (PMNames[i]==plr)then
            outSYS("Your conversation with "..plr.." has been terminated.");
            if (options["PMBye"]==1)then
                outPMSET (options["PMByeMSG"],PMLang[MessCurUser],plr);
            end
            PMMessages[plr]=nil;
            PMNames[i]=nil;
        else
            PMNames[throughVar]=PMNames[i];
            throughVar=throughVar+1;
            
        end
    end
    PMNames[throughVar]=nil;
    PMList_Update();
end

function PMList_Down()
PMListOffset=PMListOffset + 1;
    if (PMListOffset > table.getn(PMNames)-10)then
        PMListOffset = table.getn(PMNames)-10;
    end
end

function PMList_Up()
PMListOffset= PMListOffset - 1;
    if (PMListOffset<0 and table.getn(PMNames) > 10) then
        PMListOffset=0;
    end
end

function PMList_Button()
    if (table.getn(PMNames) <=10)then
    PMDownButton:Hide();
    PMUpButton:Hide();
    else
    PMDownButton:Show();
    PMUpButton:Show();
    end
end

function PMMess_LangEdit()
PMLang[MessCurUser]=UIDropDownMenu_GetText(LangBox);
end
--btnAN3

function AN_LOAD()

  --  if (GetChannelName(options["NotesChan"]) == 0)then
 --      JoinChannelByName(options["NotesChan"], nil, DEFAULT_CHAT_FRAME:GetID());
--    end
  --  chanNum= GetChannelName(options["NotesChan"]);
  --  AN_UPDATE();
end

function AN_UPDATE() 
    if (table.getn(ANArray)<=8) then
        for i=1,table.getn(ANArray) do
            local labelEdit=getglobal("lblTitle"..i.."Label");
            local label=getglobal("lblTitle"..i);
            local button=getglobal("btnAN"..i);
            button:Show();
            labelEdit:SetText(ANArray[i][4]);
            label:Show();
            labelEdit=getglobal("lblUser"..i.."Label");
            label=getglobal("lblUser"..i);
            labelEdit:SetText(ANArray[i][2]);
            label:Show();
        end
    else
        for i=1,8 do
    
        end
    end

end

function AN_Click(num)
    postNum=num+ANOffset;
    local TitleLabel=getglobal("lblANTitle".."Label");
    TitleLabel:SetText(ANArray[postNum][4]);
    local UserLabel=getglobal("lblANUser".."Label");
    UserLabel:SetText(ANArray[postNum][2]);
    local BodyBox=getglobal("mebANBody".."Edit");
    BodyBox:SetText(ANArray[postNum][5]);
end

function AN_Open()    
    if (GetChannelName(options["NotesChan"]) == 0)then
       -- JoinChannelByName(options["NotesChan"], nil, DEFAULT_CHAT_FRAME:GetID());
    end
    --chanNum= GetChannelName(options["NotesChan"]);
    if (ANSynch==false and active==false)then
    --    outNotes("CLUSTER UPDATEME"); 
    end
end
--Key, Username, Leader, Title, Body, Confirmed, Place Number, PostKey, Type
function AN_Post()
    local title=NotesTitle:GetText();
    local body=getglobal("ANMEBBody".."Edit"):GetText();
    ANArray[gkey]={gkey,pname,pname,title,body,0,1,pkey,"Start"};
    outNotes("CLUSTER POST "..postKey..ANArray[gkey][2]..postKey..ANArray[gkey][3]..postKey..ANArray[gkey][4]..postKey..ANArray[gkey][5]..postKey..ANArray[gkey][6]..postKey..ANArray[gkey][7]..postKey..ANArray[gkey][8]..postKey..ANArray[gkey][9]);
    pkey=pkey+1;
    gkey=gkey+1;
    AN_UPDATE();
end

function AN_GET_Post(a1,a2,a3,a4,a5,a6,a7,a8)
    ANArray[gkey]={gkey,a1,a2,a3,a4,a5,a6,a7,a8};
    gkey=gkey+1;
    AN_UPDATE();
    out("New AdminNotes Message");
end

function GMBuddy(fxn)
    if (fxn=="lang")then
        outSAY(".learn all_lang");
    
    elseif (fxn=="armor")then
        for i=1, table.getn(GMArray["Armor"]) do
            outSAY(".learnsk "..GMArray["Armor"][i].. " 300 300");
        end
        
    elseif (fxn=="weap")then
        out(table.getn(GMArray["Weapons"]));
        for i=1, table.getn(GMArray["Weapons"]) do
            outSAY(".learnsk "..GMArray["Weapons"][i].. " 300 300");
        end
        for i=1, 5 do
            outSAY(".learn "..GMArray["Spells"][i]);
        end
        
    elseif (fxn=="pimp")then
        for i=1, table.getn(GMArray["Pimp"]) do
            outSAY(".learn "..GMArray["Pimp"][i]);
        end
        
    elseif (fxn=="skill")then
        outSAY(".learn all_myclass");
    
    elseif (fxn=="max")then
        outSAY(".maxskill");
    
    elseif (fxn=="ench")then
        outSAY(".learnsk "..GMArray["Profs"][1].." 300 300");
        outSAY(".learn "..GMArray["ProfSpells"][1]);
        outSAY(".learn "..GMArray["ProfSpells"][2]);
    elseif (fxn=="alch")then
        outSAY(".learnsk "..GMArray["Profs"][2].." 300 300");
        outSAY(".learn "..GMArray["ProfSpells"][3]);
    elseif (fxn=="blac")then
        outSAY(".learnsk "..GMArray["Profs"][3].." 300 300");
        outSAY(".learn "..GMArray["ProfSpells"][4]);
    elseif (fxn=="leat")then
        outSAY(".learnsk "..GMArray["Profs"][4].." 300 300");
        outSAY(".learn "..GMArray["ProfSpells"][5]);
    elseif (fxn=="engi")then
        outSAY(".learnsk "..GMArray["Profs"][5].." 300 300");
        outSAY(".learn "..GMArray["ProfSpells"][6]);
    elseif (fxn=="tail")then
        outSAY(".learnsk "..GMArray["Profs"][6].." 300 300");
        outSAY(".learn "..GMArray["ProfSpells"][7]);
    elseif (fxn=="herb")then
        outSAY(".learnsk "..GMArray["Profs"][7].." 300 300");
        outSAY(".learn "..GMArray["ProfSpells"][8]);
        outSAY(".learn "..GMArray["ProfSpells"][9]);
    elseif (fxn=="mini")then
        outSAY(".learnsk "..GMArray["Profs"][8].." 300 300");
        outSAY(".learn "..GMArray["ProfSpells"][10]);
        outSAY(".learn "..GMArray["ProfSpells"][11]);
    elseif (fxn=="skin")then
        outSAY(".learnsk "..GMArray["Profs"][9].." 300 300");    
        outSAY(".learn "..GMArray["ProfSpells"][12]);
    elseif (fxn=="firs")then
        outSAY(".learnsk "..GMArray["Profs"][10].." 300 300");   
        outSAY(".learn "..GMArray["ProfSpells"][13]);
    elseif (fxn=="cook")then
        outSAY(".learnsk "..GMArray["Profs"][11].." 300 300");   
        outSAY(".learn "..GMArray["ProfSpells"][14]);
        outSAY(".learn "..GMArray["ProfSpells"][15]);
    elseif (fxn=="fish")then
        outSAY(".learnsk "..GMArray["Profs"][12].." 300 300");  
        outSAY(".learn "..GMArray["ProfSpells"][16]);
    elseif (fxn=="anno")then
        outSAY(".announce "..EBAnn:GetText()); 
    
    elseif (fxn=="morp")then
        outSAY(".morph "..GMArray["Morph"][UIDropDownMenu_GetText(CBXMorph)]);

    elseif (fxn=="demo")then
        outSAY(".demorph"); 
    
    elseif (fxn=="leve")then
        outSAY(".levelup "..EBlvl:GetText()); 
    
    elseif (fxn=="gm")then
        outSAY(".recall gm");
    end
    

end


function tBuddy_OnLoad()
MangAdminForm14:ClearAllPoints();
MangAdminForm14:SetPoint("TOPRIGHT",Minimap,"TOPLEFT",-10,10);
end


function tBuddyUpdate()
--local lbltCount=getglobal("LBLtCount".."Label");
--lbltCount:SetText("0");
end

function Mini_OnLoad()
this:RegisterForDrag("LeftButton");
end

function Mini_OnDragStart()
MangAdminForm13:StartMoving()
end

function Mini_OnDragStop()
MangAdminForm13:StopMovingOrSizing()
end

function MiniMenu(fxn)
    if (fxn=="Admin")then
        GameTooltip:SetOwner(this, "ANCHOR_LEFT",-15,-30);
        GameTooltip:SetText("Admin Notes", 1.0, 0, 0);
    elseif (fxn=="PMB")then
        GameTooltip:SetOwner(this, "ANCHOR_LEFT",-15,-30);
        GameTooltip:SetText("PM Buddy", 1.0, 1.0, 1.0);
    elseif (fxn=="Tele")then
        GameTooltip:SetOwner(this, "ANCHOR_LEFT",-15,-30);
        GameTooltip:SetText("Teleport Buddy", 1.0, 1.0, 1.0);
    elseif (fxn=="Item")then
        GameTooltip:SetOwner(this, "ANCHOR_LEFT",-15,-30);
        GameTooltip:SetText("Item Buddy", 1.0, 1.0, 1.0);
    elseif (fxn=="GM")then
        GameTooltip:SetOwner(this, "ANCHOR_LEFT",-15,-30);
        GameTooltip:SetText("GM Buddy", 1.0, 1.0, 1.0);
    elseif (fxn=="Ticket")then
        GameTooltip:SetOwner(this, "ANCHOR_LEFT",-15,-30);
        GameTooltip:SetText("Ticket Buddy", 1.0, 1.0, 1.0);
    elseif (fxn=="Options")then
        GameTooltip:SetOwner(this, "ANCHOR_LEFT",-15,-30);
        GameTooltip:SetText("Options", 1.0, 1.0, 1.0);
    elseif (fxn=="Map")then
        GameTooltip:SetOwner(this, "ANCHOR_LEFT",-15,-30);
        GameTooltip:SetText("MangAdmin", 1.0, 1.0, 1.0);
    elseif (fxn=="Hide")then
        GameTooltip:Hide();
    end
    
end

function MenuManager(box)
    if (box=="Main" and options["Mini"]==1)then
        MangAdminForm:Hide();
    elseif (box=="Mini" and options["Mini"]==0)then
        MangAdminForm13:Hide();
    end
end

function MiniShowHide()
 if (CHKMini:GetChecked()) then
        options["Mini"]=1;
	    MangAdminForm13:Show();        
    else
        options["Mini"]=0;
        MangAdminForm13:Hide();   

    end
end

function Map_Pos()
	MinimapButton:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-(80*cos(options["Maplocal"])),(80*sin(options["Maplocal"]))-52)
end

function MapPos_Change()
    local Slider=getglobal("SliderLocalSlider");
    options["Maplocal"]=Slider:GetValue();
    MinimapButton:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-(80*cos(options["Maplocal"])),(80*sin(options["Maplocal"]))-52)
end

function tB_Initialize()
outSAY(".ticket");
tInitial=true;
BTNBBCode:Disable();
BTNDel:Disable();
BTNTBSol:Disable();
prob = getglobal("EBoxProbEdit");
sol = getglobal("EBoxSolEdit");
prob:SetText("No Ticket Selected.");
sol:ClearFocus();
end

function tB_Toggle()
    if (tCounter==0)then
        tB_Initialize();
    end
    
    if (TBBarOpen==true)then
        MangAdminForm14:Hide();
        TBBarOpen=false;
    else
        MangAdminForm14:Show();
        TBBarOpen=true;
    end
end

function tB_LoadTickets(tNum)
    if (tNum ~= "0")then
        TBBarOpen=true;
        MangAdminForm14:Show();
    end
    local lbltCount=getglobal("LBLtCount".."Label");
    
    lbltCount:SetText(tNum);
    for i=1, tNum do
        outSAY(".ticket "..i);
    end
    outSYS("Current ticket count: "..tNum);
end

function tb_AddTicket(fTicket, tName, tCat)
    lblNoTicket:Hide();
    tCounter=tCounter + 1;
    fullString = fTicket
    nulString = "Ticket of "..tName.." (Category: "..tCat.."):";
    newString = strsub(fullString, string.len (nulString)+2, string.len (fullString) )
    tArray[tCounter]={tName, tCat, newString, ""}
    
    if (tCounter < 11) then
        local tBB = getglobal ("BTNTB"..tCounter);
        tBB:SetText(tName.." - Category: "..tCat);
        tBB:Show();
    end    
    if (tCounter > 10)then
        BTNTBDown:Show();
    else
        BTNTBDown:Hide();
        BTNTBUp:Hide();
    end
end

function tB_ShowTicket(tNumber)
    tB_Reset()
    tCount=tNumber + tOffset;
    local tbName=getglobal("lblTBNameLabel");
   local  tbCat=getglobal("lblTBCatLabel");
    tbName:SetText(tArray[tNumber + tOffset][1]);
    tbCat:SetText(tB_Cat(tArray[tNumber + tOffset][2]));
    prob:SetText(tArray[tNumber + tOffset][3]);
    sol:SetText(tArray[tNumber + tOffset][4]);
end

function tB_Cat(cNumber)
    local strCat="";
    if (cNumber == "0") then
        strCat="Item Issue";
    elseif (cNumber == "1") then
        strCat="Harassment";
    elseif (cNumber == "2") then
        strCat="Guild Issue";
    elseif (cNumber == "3") then
        strCat="Character Issue";
    elseif (cNumber == "4") then
        strCat="Non-Quest/Creep Issue";
    elseif (cNumber == "5") then
        strCat="Stuck";
    elseif (cNumber == "6") then
        strCat="Environmental Issue";
    elseif (cNumber == "7") then
        strCat="Quest/Quest NPC Issue";
    else
        strCat="Unknown Issue";
    end

    return strCat;
end

function tB_BBCode()
    compiledCode="";
    BTNTBSol:Enable();
    BTNDel:Enable();
    tbSolCode=getglobal("lblSolCodeLabel");
    tbSolCode:SetText("BBCode:");
    tArray[tCount][4]=sol:GetText();
    compiledCode="User: [color=red]"..tArray[tCount][1].."[/color]\nCatagory: [color=red]"..tB_Cat(tArray[tCount][2]).."[/color]\nProblem: "..tArray[tCount][3].."Solution: "..tArray[tCount][4];
    sol:SetText(compiledCode);
end

function tB_SolCheck()
    local tbName=getglobal("lblTBNameLabel");
    if (sol:GetText() ~="" and tbName:GetText()~="Name") then
    BTNBBCode:Enable();
    end
end

function tB_Reset()
if (tCount~=0)then
    tArray[tCount][4]=sol:GetText();
end
tOffset=0;
tCount=0;
BTNBBCode:Disable();
BTNDel:Disable();
BTNTBSol:Disable();
prob:SetText("No Ticket Selected.");
sol:SetText("");
tbSolCode=getglobal("lblSolCodeLabel");
tbSolCode:SetText("Solution:");
end

function tB_ShowSol()
tbSolCode=getglobal("lblSolCodeLabel");
tbSolCode:SetText("Solution:");
sol:SetText(tArray[tCount][4]);
end

function tb_Del()
outSAY(".delticket "..tArray[tCount][1]);
outSAY(".ticket");
end

function tB_Up()
    if (tOffset==0 or tCounter < 11) then
    
    else
        tOffset=tOffset-1;
        if (tOffset==0)then
            BTNTBUp:Hide();
        end
    end
    tB_Redraw();
end
function tB_Down()
    if (tOffset==tCounter-10 or tCounter < 11) then
    
    else
        tOffset=tOffset+1;
        if (tOffset==tCounter-10) then
            BTNTBDown:Hide();
        end
    end
    tB_Redraw();
end

function tB_Redraw()
if (tOffset~=tCounter-10 and tCounter > 10) then
    BTNTBDown:Show();
elseif (tOffset~=0 and tCounter > 10) then
    BTNTBUp:Show();
end


for i=1, 10 do
    if (i <= tCounter)then
        local tBB = getglobal ("BTNTB"..i);
        tBB:SetText(tArray[i+tOffset][1].." - Category: "..tArray[i+tOffset][2]);
        tBB:Show();
    else
        local tBB = getglobal ("BTNTB"..i);
        tBB:Hide();
    end
end


end