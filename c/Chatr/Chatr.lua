-- Constants
Chatr_Version=GetAddOnMetadata("Chatr","Title"); -- 1.11 savvy
Chatr_VerQuote="\"These bloodhounds... they move in a group, they're Bloodhound Gang!\"";
Chatr_Max=15;
BINDING_HEADER_CHATR="Chatr";
BINDING_NAME_CHATR_REPLY="Focus Last Clicked Chat";
BINDING_NAME_CHATR_QUICKTOGGLE="QuickToggle";
BINDING_NAME_CHATR_REPLYDOCK="Dock: Focus Current Tab";
BINDING_NAME_CHATR_NEXTCHAT="Dock: Next Tab";
BINDING_NAME_CHATR_PREVCHAT="Dock: Previous Tab";
BINDING_NAME_CHATR_CLOSETAB="Dock: Close Tab";

-- Saved

Chatr_Options={};

-- Not Saved
Chatr_Ready=0;
Chatr_HookNames={"ContainerFrameItemButton_OnClick","PaperDollItemSlotButton_OnClick","BankFrameItemButtonGeneric_OnClick","SetItemRef"};
Chatr_HookedFuncs={};
Chatr_WhoInfo={};
Chatr_Statuses={};
Chatr_LastPositions={};
Chatr_DockedIds={};
Chatr_DockSelected=0;
Chatr_Debugging=0;
Chatr_FontSize=12;
Chatr_EditFocus=nil;
Chatr_LastFocused=nil;
Chatr_InboundFilters={};
Chatr_OutboundFilters={};
Chatr_Filters={};
Chatr_Whoed=0;
Chatr_QuickToggled=0;
Chatr_LastPluginButton=nil;
Chatr_CallMes={};
-- %a  	Locale's abbreviated weekday name.  	
-- %A 	Locale's full weekday name. 	
-- %b 	Locale's abbreviated month name. 	
-- %B 	Locale's full month name. 	
-- %c 	Locale's appropriate date and time representation. 	
-- %d 	Day of the month as a decimal number [01,31]. 	
-- %H 	Hour (24-hour clock) as a decimal number [00,23]. 	
-- %I 	Hour (12-hour clock) as a decimal number [01,12]. 	
-- %j 	Day of the year as a decimal number [001,366]. 	
-- %m 	Month as a decimal number [01,12]. 	
-- %M 	Minute as a decimal number [00,59]. 	
-- %p 	Locale's equivalent of either AM or PM. 	(1)
-- %S 	Second as a decimal number [00,61]. 	(2)
-- %U 	Week number of the year (Sunday as the first day of the week) as a decimal number [00,53]. All days in a new year preceding the first Sunday are considered to be in week 0. 	(3)
-- %w 	Weekday as a decimal number [0(Sunday),6]. 	
-- %W 	Week number of the year (Monday as the first day of the week) as a decimal number [00,53]. All days in a new year preceding the first Monday are considered to be in week 0. 	(3)
-- %x 	Locale's appropriate date representation. 	
-- %X 	Locale's appropriate time representation. 	
-- %y 	Year without century as a decimal number [00,99]. 	
-- %Y 	Year with century as a decimal number. 	
-- %Z 	Time zone name (no characters if no time zone exists). 	
-- %% 	A literal "%" character.
Chatr_TextFormat="%H:%M <$name> $text";
Chatr_NoteFormat="%H:%M $text";
Chatr_NormalTextColor={1,1,1};
Chatr_AFKTextColor={1,1,0.7};
Chatr_SelfTextColor={0.8,1,0.4};
Chatr_NoteTextColor={0.4,0.8,1};
Chatr_BGColor={0,0,0,1};
Chatr_BorderColor={1,1,1,1};
Chatr_AutoDock=0;
Chatr_AutoWho=0;
Chatr_AllowFade=1;
Chatr_DockMode=0;
Chatr_EntryInside=0;
Chatr_MinInCombat=0;
Chatr_PlaySound=1;
Chatr_DefaultSize={250,150};
Chatr_DefaultPos={0,0};

Chatr_ExecSlash=0;

Chatr_SavePerChar=0;

-- Prints a message.
function Chatr_Print(msg)
	DEFAULT_CHAT_FRAME:AddMessage(tostring(msg),0.2,0.7,0.9);
end
-- Prints a debug.
function Chatr_Debug(msg)
	if Chatr_Debugging==1 then
		DEFAULT_CHAT_FRAME:AddMessage("# "..msg,0.2,0.7,0.9);
	end
end

-- Shows a tooltip.
function Chatr_Tip(text,attach)
	if text==nil then
		GameTooltip:Hide();
	else
		if attach==nil then
			GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
		else
			GameTooltip_SetDefaultAnchor(GameTooltip, attach);
		end
		GameTooltip:SetText(text,1,1,1,1,1);
		GameTooltip:Show();
	end
end

function Chatr_Split(delimiter, text,maxcnt)
  -- Edited from http://lua-users.org/wiki/SplitJoin
  
  local list = {}
  local pos = 1
  local cnt = 0
  if text==nil or delimiter==nil or text=="" or delimiter=="" then
    return 0,list
  end
  while 1 do
    local first, last = strfind(text, delimiter, pos)
    if first and ((maxcnt>0 and cnt<maxcnt) or maxcnt==0) then -- found?
      table.insert(list, strsub(text, pos, first-1))
      pos = last+1
      cnt=cnt+1
    else
      table.insert(list, strsub(text, pos))
      cnt=cnt+1
      break
    end
  end
  return cnt,list
end

function Chatr_tremovebyval(tab, val)
	for k,v in tab do
		if v==val then
			tremove(tab, k);
			return k;
		end
	end
	return false;
end

function Chatr_tidx(tab, val)
	for k,v in tab do
		if v==val then
			return k;
		end
	end
	return nil;
end

function Chatr_Hyperlink(arg1,arg2,arg3)
	if ChatFrame_OnHyperlinkShow~=nil then -- EnhTooltip/Auctioneer hack (not like THAT'd ever be nil, but..)
		ChatFrame_OnHyperlinkShow(arg1,arg2,arg3)
	else
		SetItemRef(arg1,arg2,arg3)
	end
end

function Chatr_ShowOptions()
	if not ChatrOptions:IsShown() then
		ChatrOptionsFmt:SetText(Chatr_TextFormat);
		ChatrOptionsFmt2:SetText(Chatr_NoteFormat);
		ChatrOptionsAutoDock:SetChecked(Chatr_AutoDock);
		ChatrOptionsAllowFade:SetChecked(Chatr_AllowFade);
		ChatrOptionsVertDock:SetChecked(Chatr_DockMode);
		ChatrOptionsAutoWho:SetChecked(Chatr_AutoWho);
		ChatrOptionsSavePer:SetChecked(Chatr_SavePerChar);
		ChatrOptionsMinInCombat:SetChecked(Chatr_MinInCombat);
		ChatrOptionsEntryInside:SetChecked(Chatr_EntryInside);
		ChatrOptionsFontSize:SetValue(Chatr_FontSize);	
		ChatrOptions:Show();
		Chatr_DoCallMe("ShowSettings",nil);
		Chatr_SaveSettings("_backup");
	end
end

function Chatr_Cmd(arg1)
	local cmd,parts,partn,st,i;
	if arg1=="" then
		Chatr_ShowOptions();
		return;
	end
	partn,parts=Chatr_Split(" ",arg1,0);
	cmd=parts[1];
	
	if cmd=="help" then
		Chatr_Print("/chatr debug - toggle debugging mode");
		Chatr_Print("/chatr reset - resets all options for all profiles");
		Chatr_Print("/chatr t - opens testing boxes");
		Chatr_Print("/chatr clear - closes all boxes");
		Chatr_Print("/chatr size <w> <h> - sets default size to <w> x <h>");
		Chatr_Print("/chatr pos <x> <y> - sets default position to <x>,<y> (0,0 is CENTER)");
		return;
	end
	
	if cmd=="debug" then
		Chatr_Debugging=1-Chatr_Debugging;
		Chatr_Print("Debug: "..Chatr_Debugging);
		return;
	end
	if cmd=="reset" then
		Chatr_Options={};
		Chatr_Print("Options have been reset. Reload your UI with /console reloadui before setting new options.");
		return;
	end
	if cmd=="clear" then
		Chatr_Clear();
		return;
	end

	if cmd=="t" then
		for i=1,5 do
			Chatr_OpenFor("Bot"..random(10000,99999));
		end
		return;
	end
	if cmd=="size" then
		local w=tonumber(parts[2]);
		local h=tonumber(parts[3]);
		if w and h then
			Chatr_DefaultSize={w,h};
		end
		Chatr_Print("Default size: ("..Chatr_DefaultSize[1].." x "..Chatr_DefaultSize[2]..")");
		return;
	end
	if cmd=="pos" then
		local x=tonumber(parts[2]);
		local y=tonumber(parts[3]);
		if x and y then
			Chatr_DefaultPos={x,y};
		end
		Chatr_Print("Default position: ("..Chatr_DefaultPos[1]..", "..Chatr_DefaultPos[2]..")");
		return;
	end
	
end

function Chatr_FindFree()
	local i;
	for i = 1,Chatr_Max do
		if getglobal("Chatr"..i).open==0 then return i; end
	end
	return -1;
end

function Chatr_FindByName(name)
	local i,c;
	for i = 1,Chatr_Max do
		c=getglobal("Chatr"..i)
		if c.open==1 and c.target==name then return i; end
	end
	return -1;
end

function Chatr_OnUpdate(elapsed)
	if Chatr_Ready==1 then
	end
end

function Chatr_Clear()
	for i=1,Chatr_Max do
		Chatr_Close(getglobal("Chatr"..i));
	end
end

function Chatr_Close(chatr)
	local a,b,c,d,e,v;
	if chatr.docked==0 then
		a,b,c,d,e=chatr:GetPoint("TOPLEFT");
		Chatr_LastPositions[chatr.target]={a,c,d,e,chatr:GetWidth(),chatr:GetHeight()};
	else
		Chatr_LastPositions[chatr.target]={"CENTER","CENTER",0,0,chatr:GetWidth(),chatr:GetHeight()};
	end
	Chatr_AbandonEntry(chatr);
	if chatr:IsShown() then
		chatr:Hide();
	end
	chatr.docked=0;
	chatr.open=0;
	Chatr_UpdateDock();
	ChatrMenu:Hide();
	Chatr_DoCallMe("CloseChatr",chatr);
end


function Chatr_Minimize(chatr)
	if chatr.docked==1 then
		Chatr_Undock(chatr);
	else
		if chatr.minimized==1 then
			chatr.minimized=0;
			chatr.editBox:Show();
			chatr.chatBox:Show();
			chatr.sizer:Show();
			chatr.menu:Show();
			chatr:SetWidth(chatr.preMinW);
			chatr:SetHeight(chatr.preMinH);
		elseif chatr.docked==0 then
			chatr.minimized=1;
			chatr.editBox:Hide();
			chatr.chatBox:Hide();
			chatr.sizer:Hide();
			chatr.menu:Hide();
			chatr.preMinW=chatr:GetWidth();
			chatr.preMinH=chatr:GetHeight();
			chatr:SetWidth(90);
			chatr:SetHeight(30);
		end
	end
	Chatr_UpdateWin(chatr);
	if Chatr_BGColor~=nil then -- iambio
		chatr:SetBackdropColor(Chatr_BGColor[1],Chatr_BGColor[2],Chatr_BGColor[3],Chatr_BGColor[4]);
	else
		chatr:SetBackdropColor(0,0,0,1);
	end
	
end

function Chatr_CloseOrMinimize(chatr)
	if IsAltKeyDown() then
		if chatr.docked==1 then
			Chatr_Undock(chatr);
		else
			Chatr_Dock(chatr);
		end
	elseif IsShiftKeyDown() or arg1~="LeftButton" or chatr.minimized==1 then
		Chatr_Minimize(chatr);
	else
		Chatr_Close(chatr);
	end
end

function Chatr_Show(chatr)
	chatr:Show();
	chatr.editBox:SetAlpha(0.33);
	chatr:ClearAllPoints();
	chatr:SetBackdropColor(Chatr_BGColor[1],Chatr_BGColor[2],Chatr_BGColor[3],Chatr_BGColor[4]);
	chatr:SetBackdropBorderColor(Chatr_BorderColor[1],Chatr_BorderColor[2],Chatr_BorderColor[3],Chatr_BorderColor[4]);
	if Chatr_LastPositions[chatr.target]~=nil then
		local ap1,ap2,x,y,w,h=unpack(Chatr_LastPositions[chatr.target]);
		chatr:SetPoint(ap1,UIParent,ap2,x,y);
		chatr:SetWidth(w);
		chatr:SetHeight(h);
	else
		chatr:SetPoint("CENTER",UIParent,"CENTER",Chatr_DefaultPos[1]+random(-30,30),Chatr_DefaultPos[2]+random(-30,30));
		chatr:SetWidth(Chatr_DefaultSize[1]);
		chatr:SetHeight(Chatr_DefaultSize[2]);		
	end
end

function Chatr_EBEnter(eb)
	eb:SetAlpha(1);
end

function Chatr_EBLeave(eb)
	if eb.hasFocus==0 then
		eb:SetAlpha(0.33);
	end
end

function Chatr_AbandonEntry(chatr)
	chatr.editBox:ClearFocus();
	chatr.editBox:SetText("");
	Chatr_EBLeave(chatr.editBox);
	Chatr_Leave(chatr);
end

function Chatr_EntryChar()
	local _temp;
	if FLT_ChatEdit_OnChar~=nil then -- GFWL support
		if FLT_Orig_ChatEdit_OnChar then
			_temp=FLT_Orig_ChatEdit_OnChar;
			FLT_Orig_ChatEdit_OnChar=nil;
		end
		FLT_ChatEdit_OnChar();
		if _temp then
			FLT_Orig_ChatEdit_OnChar=_temp;
		end
	end
end

function Chatr_ProcessSlash(chatr,text)
	-- Blatantly stolen from Blizzard. I should play a rogue.
	local command = gsub(text, "/([^%s]+)%s(.*)", "/%1", 1);
	local msg = "";
	if command ~= text then
		msg = strsub(text, strlen(command) + 2);
	end
	command = strupper(gsub(command, "%s+", ""));
	for index, value in SlashCmdList do
		local i = 1;
		local cmdString = getglobal("SLASH_"..index..i);
		while cmdString do
			cmdString = strupper(cmdString);
			if cmdString == command then
				value(msg);
				Chatr_AbandonEntry(chatr);
				return 1;
			end
			i=i+1;
			cmdString = getglobal("SLASH_"..index..i);
		end
	end
	return nil;
end

function Chatr_Send(chatr)
	local target=chatr.target;
	local msg=chatr.editBox:GetText();
	local msgl=strlower(msg);
	if msg~="" then
		chatr.editBox:AddHistoryLine(msg);
		if msgl=="/invite" then
			InviteByName(target);
		elseif msgl=="/who" then
			Chatr_Who(target);
		elseif strsub(msgl,1,1)=="/" and Chatr_ExecSlash==1 then
			if Chatr_ProcessSlash(chatr,msg)~=1 then
				Chatr_Print("Unknown slash command.");
			end
		else
			Chatr_Debug("Sent <"..msg.."> to "..target);
			SendChatMessage(msg, "WHISPER", nil, target);
		end
	end
	Chatr_AbandonEntry(chatr);
end

function Chatr_FocusLast()
	local c;
	if Chatr_LastFocused~=nil then
		c=getglobal("Chatr"..Chatr_LastFocused);
		if c.docked==1 then
			Chatr_DockSelected=Chatr_LastFocused;
			Chatr_UpdateDock(1);
		end		
		if c.open==1 then
			c.editBox:SetFocus();
			c.editBox:SetText("");
		end

	end
end
function Chatr_FocusDock()
	local c;
	if ChatrDock:IsShown() then
		if Chatr_DockSelected~=0 then
			c=getglobal("Chatr"..Chatr_DockSelected);
			if c.open==1 then
				c.editBox:SetFocus();
				c.editBox:SetText("");
			end
		end	
	else
		Chatr_FocusLast();
	end

end


function Chatr_NextTab()
	local t;
	Chatr_UpdateDockIds();
	if Chatr_DockedIds[1]~=nil then
		t=Chatr_tidx(Chatr_DockedIds,Chatr_DockSelected)+1;
		if Chatr_DockedIds[t]==nil then
			Chatr_DockSelected=Chatr_DockedIds[1];
		else
			Chatr_DockSelected=Chatr_DockedIds[t];
		end
	end
	Chatr_UpdateDock();
end

function Chatr_CloseTab()
	if Chatr_DockSelected and Chatr_DockSelected>0 then Chatr_Close(getglobal("Chatr"..Chatr_DockSelected)); end
end

function Chatr_PrevTab()
	local t;
	Chatr_UpdateDockIds();
	if Chatr_DockedIds[1]~=nil then
		t=Chatr_tidx(Chatr_DockedIds,Chatr_DockSelected)-1;
		if Chatr_DockedIds[t]==nil then
			Chatr_DockSelected=Chatr_DockedIds[getn(Chatr_DockedIds)];
		else
			Chatr_DockSelected=Chatr_DockedIds[t];
		end
	end
	Chatr_UpdateDock();
end


function Chatr_Who(s)
	FriendsFrame:UnregisterEvent("WHO_LIST_UPDATE");
	SetWhoToUI(1);
	SendWho(s);
	Chatr_Whoed=1;
end

function Chatr_OpenFor(name)
	local frame,i,fn,fs,ff;
	i=Chatr_FindFree();
	if i<0 then
		Chatr_Print("No free chatrbox for "..name);
		return -1;
	end
	frame=getglobal("Chatr"..i);
	frame.target=name;
	frame.opened=time();
	frame.editBox=getglobal("Chatr"..i.."EditBox");
	frame.chatBox=getglobal("Chatr"..i.."ChatBox");
	frame.title=getglobal("Chatr"..i.."Title");
	frame.close=getglobal("Chatr"..i.."Close");
	frame.sizer=getglobal("Chatr"..i.."Sizer");
	frame.menu=getglobal("Chatr"..i.."MenuButton");
	if Chatr_AutoWho==1 then
		Chatr_Who(name);
	end
	frame.editBox:ClearAllPoints();
	if Chatr_EntryInside==1 then
		frame.editBox:SetPoint("TOPLEFT",frame,"BOTTOMLEFT",2,21);
		frame.editBox:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",-2,1);
		frame.chatBox:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",-5,24);
	else
		frame.editBox:SetPoint("TOPLEFT",frame,"BOTTOMLEFT",2,4);
		frame.editBox:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",-2,-16);
		frame.chatBox:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",-5,7);
	end
	Chatr_UpdateWin(frame);
	frame.editBox:SetMaxLetters(250);
	frame.editBox:SetAltArrowKeyMode(false);
	frame.editBox.hasFocus=0;
	frame.chatBox:Clear();
	frame.editBox:Show();
	frame.chatBox:Show();
	frame.menu:SetAlpha(0.4);
	frame:GetTitleRegion():SetAllPoints();
	frame:SetMovable(true);
	fn,fs,ff=frame.chatBox:GetFont();
	frame.chatBox:SetFont(fn,Chatr_FontSize,ff);
	
	-- Hey, if you happen to be a WoW developer, could you puh-lease
	-- add "EditBox:ClearHistoryLines()"? Pleeeeeease? It'd keep the kittens happy!
	for i=1,frame.editBox:GetHistoryLines() do
		frame.editBox:AddHistoryLine("");	
	end
	frame.minimized=0;
	frame.combatmind=0;
	frame.docked=0;
	frame.open=1;
	Chatr_Debug("Opened for "..name..": "..i);
	Chatr_Show(frame);
	if Chatr_AutoDock==1 then
		Chatr_Dock(frame);
	end
	Chatr_DoCallMe("OpenChatr",frame);
	return i;
end

function Chatr_ChatWheel(chatframe, value)
	if IsShiftKeyDown() then
		if value>0 then chatframe:ScrollToTop(); elseif value<0 then chatframe:ScrollToBottom(); end
	else
		if value>0 then chatframe:ScrollUp(); elseif value<0 then chatframe:ScrollDown(); end
	end
end

function Chatr_MakeTitle(name,minimized,small)
	local s;
	if Chatr_Statuses[name]~=nil and minimized~=1 then
		if small==1 then
			s="<"..strsub(Chatr_Statuses[name],1,3)..">"..name;
		else
			s="<"..Chatr_Statuses[name]..">"..name;
		end
	else
		s=name;
	end 
	if Chatr_WhoInfo[name]~=nil and minimized~=1 then
	
		if small==1 then
			s=s..":"..Chatr_WhoInfo[name][3]..strsub(Chatr_WhoInfo[name][4],1,2)..strsub(Chatr_WhoInfo[name][5],1,4).." "..gsub(Chatr_WhoInfo[name][6]," ","");
		else
			s=s..": "..Chatr_WhoInfo[name][3].." "..Chatr_WhoInfo[name][4].." "..Chatr_WhoInfo[name][5].." - "..Chatr_WhoInfo[name][6];
			if Chatr_WhoInfo[name][2]~="" then s=s.." <"..Chatr_WhoInfo[name][2]..">" end;
		end
		if time()-Chatr_WhoInfo[name][1]>300 then s=s.." (?)"; end
	end
	return s;
end

function Chatr_UpdateWin(chatr)
	if (chatr:GetWidth())<250 then
		chatr.title:SetText(Chatr_MakeTitle(chatr.target,chatr.minimized,1));
	else
		chatr.title:SetText(Chatr_MakeTitle(chatr.target,chatr.minimized));
	end
	chatr:SetAlpha(1);
end

function Chatr_Fmt(fmt,vars)
	s=date(fmt);
	for k,v in vars do
		s=gsub(s,k,v);
	end
	return s;
end

function Chatr_AddWhisper(name,msg,status)
	local i,chatr;
	i=Chatr_FindByName(name);
	if i==-1 then
		Chatr_Debug("Opening window for "..name.." on incoming whisper");
		i=Chatr_OpenFor(name);
		if i==-1 then return false; end
	end
	chatr=getglobal("Chatr"..i);
	if status=="DND" or status=="AFK" then
		if Chatr_Statuses[name]==nil or (Chatr_Statuses[name]~=nil and (strlen(Chatr_Statuses[name])<strlen(status) or status~=strsub(Chatr_Statuses[name],1,3))) then
			Chatr_Statuses[name]=status;
		end
	else
		Chatr_Statuses[name]=nil;
	end
	if strsub(msg,1,3)=="/me" then
		vars={["$text"]=name.." "..strsub(msg,5)};
		fmtd=Chatr_Fmt(Chatr_NoteFormat,vars);
	else
		vars={["$name"]=name,["$text"]=msg};
		fmtd=Chatr_Fmt(Chatr_TextFormat,vars);
	end
	if Chatr_Statuses[name]~=nil then
		chatr.chatBox:AddMessage(fmtd,Chatr_AFKTextColor[1],Chatr_AFKTextColor[2],Chatr_AFKTextColor[3]);
	else
		chatr.chatBox:AddMessage(fmtd,Chatr_NormalTextColor[1],Chatr_NormalTextColor[2],Chatr_NormalTextColor[3]);
	end
	Chatr_UpdateWin(chatr);
	if chatr.minimized==1 then
		chatr:SetBackdropColor(1,0.75,0,1);
	end
	if chatr.docked==1 then
		getglobal("ChatrDockBtn"..(chatr.id)):SetTextColor(1,1,0);
	end
	
	Chatr_UpdateWin(chatr);
	
	if Chatr_AutoWho==1 and (Chatr_WhoInfo[name]==nil or time()-Chatr_WhoInfo[name][1]>450) then
		Chatr_Who(name);
	end
	Chatr_DoCallMe("IncomingWhisper",chatr,name,msg,fmtd);
	return true;
end

function Chatr_AddWhisperTo(name,msg)
	local i,chatr;
	i=Chatr_FindByName(name);
	if i==-1 then
		Chatr_Debug("Opening window for "..name.." on outgoing whisper");
		i=Chatr_OpenFor(name);
		if i==-1 then return false; end
	end
	chatr=getglobal("Chatr"..i);
	uname=UnitName("player");
	if strsub(msg,1,3)=="/me" then
		vars={["$text"]=uname.." "..strsub(msg,5)};
		fmtd=Chatr_Fmt(Chatr_NoteFormat,vars);
	else
		vars={["$name"]=uname,["$text"]=msg};
		fmtd=Chatr_Fmt(Chatr_TextFormat,vars);
	end	
	chatr.chatBox:AddMessage(fmtd,Chatr_SelfTextColor[1],Chatr_SelfTextColor[2],Chatr_SelfTextColor[3]);
	Chatr_UpdateWin(chatr);
	Chatr_DoCallMe("OutgoingWhisper",chatr,name,msg,fmtd);
	return true;
end

function Chatr_AddNote(name,msg,allowOpen)
	local i,chatr,vars,fmtd;
	i=Chatr_FindByName(name);
	if i==-1 then
		if allowOpen==1 then
			Chatr_Debug("Opening window for "..name.." on info");
			i=Chatr_OpenFor(name);
			if i==-1 then return false; end
		else
			return false;
		end
	end
	chatr=getglobal("Chatr"..i);
	vars={["$text"]=msg};
	fmtd=Chatr_Fmt(Chatr_NoteFormat,vars)
	chatr.chatBox:AddMessage(fmtd,Chatr_NoteTextColor[1],Chatr_NoteTextColor[2],Chatr_NoteTextColor[1]);
	Chatr_UpdateWin(chatr);
	Chatr_DoCallMe("Note",chatr,name,msg,fmtd);
	return true;
end

function Chatr_Enter(chatr)
	chatr:SetAlpha(1);
end

function Chatr_Leave(chatr)
	if Chatr_AllowFade==1 then
		chatr:SetAlpha(0.5);
	end
end

function Chatr_UpdateDockIds()
	Chatr_DockedIds={};
	for i=1,Chatr_Max do
		if getglobal("Chatr"..i).docked==1 then
			tinsert(Chatr_DockedIds,i);
		end
	end
end

function Chatr_UpdateDock(noClearColor)
	local last,i,v,b,id,c,n,openTo;
	last=nil;
	Chatr_UpdateDockIds();
	if Chatr_tidx(Chatr_DockedIds,Chatr_DockSelected)==nil then
		Chatr_DockSelected=Chatr_DockedIds[1];
	end
	if ChatrDock:GetLeft()<=GetScreenWidth()/2.0 then openTo=0; else openTo=1; end	
	n=0;
	for i=1,Chatr_Max do
		id="ChatrDockBtn"..i;
		b=getglobal(id)
		c=getglobal("Chatr"..i)
		if c.open==1 and c.docked==1 then
			b:ClearAllPoints();
			if last==nil then
				if openTo==1 then
					b:SetPoint("TOPRIGHT","ChatrDock","TOPLEFT",-5,4);
				else
					b:SetPoint("TOPLEFT","ChatrDock","TOPLEFT",5,4);
				end
			else
				if Chatr_DockMode~=1 then -- normal dock
					if openTo==1 then
						b:SetPoint("TOPRIGHT",last,"TOPLEFT");
					else
						b:SetPoint("TOPLEFT",last,"TOPRIGHT");
					end
				else
					b:SetPoint("TOPLEFT",last,"BOTTOMLEFT",0,4);
				end
			end
			if ChatrDock.minimized==1 then
				b:Hide();
			else
				b:Show();
			end
			b:SetText(strsub(c.target,1,8));
			last=id;
			c:ClearAllPoints();
			if Chatr_DockMode~=1 then -- normal dock
				if openTo==1 then
					c:SetPoint("TOPRIGHT","ChatrDock","BOTTOMLEFT",5,2);
				else
					c:SetPoint("TOPLEFT","ChatrDock","BOTTOMLEFT",5,2);
				end
			else
				if openTo==1 then
					c:SetPoint("TOPRIGHT","ChatrDock","TOPLEFT",-65,0);
				else
					c:SetPoint("TOPLEFT","ChatrDock","TOPLEFT",65,0);
				end
			end
			if ChatrDock.minimized==1 then
				c:Hide();
			else
				if Chatr_DockSelected==i then
					c:Show();
					if noClearColor==nil then b:SetTextColor(1,1,1,1); end
				else
					c:Hide();
					if noClearColor==nil then b:SetTextColor(1,1,1,0.66); end
				end
			end
			n=n+1;
		else
			b:Hide();
		end
	end
	if n>0 then
		ChatrDock:Show()
	else
		ChatrDock:Hide()
	end
end

function Chatr_DockClick(id)
	ChatrMenu:Hide();
	Chatr_DockSelected=id;
	Chatr_UpdateDock();
end

function Chatr_Dock(chatr)
	chatr.docked=1;
	Chatr_DockSelected=chatr.id;
	chatr:GetTitleRegion():ClearAllPoints();
	chatr:SetMovable(false);
	Chatr_DockClick(chatr.id);
end

function Chatr_Undock(chatr)
	chatr.docked=0;
	chatr:ClearAllPoints();
	chatr:SetPoint("CENTER","UIParent");
	chatr:GetTitleRegion():SetAllPoints();
	chatr:SetMovable(true);
	Chatr_UpdateDock();
end

function Chatr_DockClose(st)
	if st~=nil then
		ChatrDock.minimized=st;
	else
		ChatrDock.minimized=1-ChatrDock.minimized;
	end
	if ChatrDock.minimized==1 then
		ChatrDockClose:SetAlpha(1);
	else
		ChatrDockClose:SetAlpha(0.33);
	end
	ChatrDockText:SetText("");
	Chatr_UpdateDock(1);
end

function Chatr_ContainerFrameItemButton_OnClick(button, igm)
	if Chatr_EditFocus~=nil and (IsShiftKeyDown() and not igm) then
		Chatr_EditFocus:Insert(GetContainerItemLink(this:GetParent():GetID(),this:GetID()));
		return
	end
	Chatr_HookedFuncs["ContainerFrameItemButton_OnClick"](button,igm)
end
function Chatr_PaperDollItemSlotButton_OnClick(button, igm)
	if Chatr_EditFocus~=nil and (IsShiftKeyDown() and not igm) then
		Chatr_EditFocus:Insert(GetInventoryItemLink("player", this:GetID()));
		return
	end
	Chatr_HookedFuncs["PaperDollItemSlotButton_OnClick"](button,igm)
end
function Chatr_BankFrameItemButtonGeneric_OnClick(button)
	if Chatr_EditFocus~=nil and IsShiftKeyDown() then
		Chatr_EditFocus:Insert(GetContainerItemLink(BANK_CONTAINER, this:GetID()));
		return
	end
	Chatr_HookedFuncs["BankFrameItemButtonGeneric_OnClick"](button)
end

function Chatr_SetItemRef(arg1,arg2,arg3)
	if Chatr_EditFocus~=nil and IsShiftKeyDown() then
		Chatr_EditFocus:Insert(arg2);
		return
	end
	Chatr_HookedFuncs["SetItemRef"](arg1,arg2,arg3)
end


function Chatr_ColorFunc()
  local R,G,B = ColorPickerFrame:GetColorRGB();
  if ColorPickerFrame.hasOpacity==true then
  	setglobal(Chatr_UpdatingColor,{R,G,B,1.0-OpacitySliderFrame:GetValue()});
  else
  	setglobal(Chatr_UpdatingColor,{R,G,B});
  end
end

function Chatr_ColorCancelFunc(prevvals)
  setglobal(Chatr_UpdatingColor,Chatr_ColorBackup);
end


function Chatr_OptSetColor(name)
	local tab=getglobal(name);
	local R,G,B = tab[1],tab[2],tab[3];
	if tab[4]~=nil then
		ColorPickerFrame.opacity = 1.0-tab[4];
		ColorPickerFrame.hasOpacity = true;
	else
		ColorPickerFrame.hasOpacity = false;
	end
		
	Chatr_UpdatingColor=name;
	Chatr_ColorBackup=getglobal(name);
	ColorPickerFrame.func = Chatr_ColorFunc;
	ColorPickerFrame.cancelFunc = Chatr_ColorCancelFunc;
	ColorPickerFrame:Show();
	ColorPickerFrame:SetColorRGB(R, G, B);
end

function Chatr_Menu(chatr)
	if ChatrMenu:IsShown() then
		ChatrMenu:Hide();
	else
		ChatrMenu.chatr=chatr;
		ChatrMenu:ClearAllPoints();
		if chatr:GetLeft()<=GetScreenWidth()/2.0 then
			ChatrMenu:SetPoint("TOPLEFT",chatr,"TOPRIGHT");
		else
			ChatrMenu:SetPoint("TOPRIGHT",chatr,"TOPLEFT");
		end
		ChatrMenu:Show();
	end
end

function Chatr_CheckFilter(tab,name,msg)
	for _,v in tab do
		name,msg=v(name,msg);
		if name==0 or msg==0 then return nil; end
	end
	return name,msg;
end

function Chatr_QuickToggle()
	if Chatr_QuickToggled==0 then
		for i=1,Chatr_Max do
			chatr=getglobal("Chatr"..i);
			chatr.combatmind=0;
			if chatr.docked==0 and chatr.minimized==0 and chatr.open==1 then
				Chatr_Minimize(chatr);
			end
		end
		Chatr_DockClose(1);
	else
		for i=1,Chatr_Max do
			chatr=getglobal("Chatr"..i);
			if chatr.docked==0 and chatr.minimized==1 and chatr.open==1 then
				Chatr_Minimize(chatr);
			end
		end
		Chatr_DockClose(0);
	end
	Chatr_QuickToggled=1-Chatr_QuickToggled;
end

function Chatr_Event()
	local n,i, charname, guildname, level, race, class, zone, u,chatr;
	if event=="CHAT_MSG_WHISPER" and strsub(arg1,1,4)~="$CH#" then
		name,msg=Chatr_CheckFilter(Chatr_InboundFilters,arg2,arg1);
		if name then
			if Chatr_PlaySound==1 then PlaySound("TellMessage"); end
			Chatr_AddWhisper(name,msg,arg6);
			if ChatrDock.minimized==1 then
				ChatrDockText:SetText("New message: "..name);
			end
		end
		return;
	end
	if event=="CHAT_MSG_WHISPER_INFORM" and strsub(arg1,1,4)~="$CH#" then
		name,msg=Chatr_CheckFilter(Chatr_OutboundFilters,arg2,arg1);
		if name then
			Chatr_AddWhisperTo(name,msg);
		end
		return;
	end
	if event=="CHAT_MSG_DND" or event=="CHAT_MSG_AFK" then
		g=strsub(event,-3);
		newStatus=g..": "..arg1;
		if newStatus~=Chatr_Statuses[arg2] then
			Chatr_Statuses[arg2]=newStatus;
			Chatr_AddNote(arg2,arg2..": "..newStatus,0);	
		end
		return;
	end
	if event=="WHO_LIST_UPDATE" then
		if Chatr_Whoed==1 then
			Chatr_Debug("Reverting who frame");
			FriendsFrame:Hide();
			FriendsFrame:RegisterEvent("WHO_LIST_UPDATE");
			SetWhoToUI(0);
			Chatr_Whoed=0;
		end
		n,_=GetNumWhoResults();
		Chatr_Debug("Updating who info, "..n.." entries");
		for i=1,n do
			charname, guildname, level, race, class, zone = GetWhoInfo(i);
			Chatr_WhoInfo[charname]={time(),guildname, level, race, class, zone};
			u=Chatr_FindByName(charname);
			if u>-1 then Chatr_UpdateWin(getglobal("Chatr"..u)); end
		end
	end
	if event=="VARIABLES_LOADED" then
		Chatr_LoadSettings();
		Chatr_Print(Chatr_Version.." loaded - /chatr for options.");
		Chatr_Ready=1;
	end
	
	if event=="PLAYER_REGEN_DISABLED" and Chatr_MinInCombat==1 then
		for i=1,Chatr_Max do
			chatr=getglobal("Chatr"..i);
			if chatr.docked==0 and chatr.minimized==0 and chatr.open==1 then
				Chatr_Minimize(chatr);
				chatr.combatmind=1;
			end
		end
		Chatr_DockClose(1);
	end
	if event=="PLAYER_REGEN_ENABLED" and Chatr_MinInCombat==1 then
		for i=1,Chatr_Max do
			chatr=getglobal("Chatr"..i);
			if chatr.docked==0 and chatr.minimized==1 and chatr.open==1 and chatr.combatmind==1 then
				Chatr_Minimize(chatr);
				chatr.combatmind=0;
			end
		end
		Chatr_DockClose(0);
	end
	
end

Chatr_SettingNames={
	"TextFormat","NoteFormat",
	"NormalTextColor","AFKTextColor","SelfTextColor",
	"NoteTextColor","BGColor","BorderColor",
	"AutoDock","AllowFade","AutoWho",
	"FontSize","MinInCombat","DockMode","EntryInside",
	"PlaySound","DefaultSize"};

function Chatr_LoadSettings(whom)
	local id,k;
	if whom==nil then
		id=UnitName("player").."@"..GetRealmName();
		Chatr_Debug("trying to load settings "..id);
		Chatr_SavePerChar=1;
		for k,_ in Chatr_Options do
			Chatr_Debug("Key: "..k);
		end
		if Chatr_Options[id]==nil then id="global"; Chatr_SavePerChar=0; end
	else
		id=whom;
	end
	if Chatr_Options[id]~=nil then
		for _,k in Chatr_SettingNames do
			if Chatr_Options[id][k]~=nil then
				setglobal("Chatr_"..k,Chatr_Options[id][k]);
			end
		end
		if getn(Chatr_BGColor)==3 then Chatr_BGColor={Chatr_BGColor[1],Chatr_BGColor[2],Chatr_BGColor[3],1}; end
	else
		Chatr_Print("Chatr loaded default settings - id "..id.." was not found.");
	end
	Chatr_DoCallMe("SettingsLoaded",nil);
end

function Chatr_SaveSettings(as)
	local v;
	if as==nil then
		Chatr_SavePerChar=ChatrOptionsSavePer:GetChecked();
		if Chatr_SavePerChar==nil then Chatr_SavePerChar=0; end
		if Chatr_SavePerChar==1 then
			id=UnitName("player").."@"..GetRealmName();
		else
			id="global";
		end
	else
		id=as;
	end
	Chatr_Options[id]={};
	for _,k in Chatr_SettingNames do
		v=getglobal("Chatr_"..k);
		if v==nil then v=0; end
		Chatr_Options[id][k]=v;
	end
	if as==nil then Chatr_Print("Settings saved ("..id..")"); end
end

function Chatr_AddPluginButton(button)
	button:ClearAllPoints();
	if Chatr_LastPluginButton==nil then
		button:SetPoint("TOPRIGHT",ChatrOptions,"TOPLEFT",-5,0);	
	else
		button:SetPoint("TOPRIGHT",Chatr_LastPluginButton,"BOTTOMRIGHT",0,0);
	end
	Chatr_LastPluginButton=button;
end

function Chatr_SaveThis(...)
	local _,v;
	for _,v in arg do
		tinsert(Chatr_SettingNames,v);
	end
end

function Chatr_CallMe(when,func)
	if Chatr_CallMes[when]==nil then
		Chatr_CallMes[when]={};
	end
	tinsert(Chatr_CallMes[when],func);
end

function Chatr_DontCallMe(when,func)
	if Chatr_CallMes[when]==nil then return; end
	Chatr_tremovebyval(Chatr_CallMes[when],func);
end

function Chatr_DoCallMe(...)
	local _,v;
	if getn(arg)<1 then return; end
	when=arg[1];
	if Chatr_CallMes[when]==nil then return; end
	for _,v in Chatr_CallMes[when] do
		if v(arg)=="break" then return; end
	end
end

function Chatr_Init()
	local chatr,i,k;
	SlashCmdList["CHATRCMD"] = Chatr_Cmd;
	SLASH_CHATRCMD1 = "/chatr";
	for i=1,Chatr_Max do
		chatr=getglobal("Chatr"..i);
		
		if chatr~=nil then
			chatr:Hide();
			chatr.id=i;
			chatr.open=0;
		else
			Chatr_Print("Nil: "..i);
		end
	end
	for _,k in Chatr_HookNames do
		of=getglobal(k);
		nf=getglobal("Chatr_"..k);
		
		if of==nil then
			Chatr_Print("Hooked function "..k.." does not exist");
		elseif nf==nil then
			Chatr_Print("Hook function replacement for "..k.." does not exist");
		else
			Chatr_HookedFuncs[k]=of;
			setglobal(k,nf);
			Chatr_Debug("Hooked "..k);
		end
	end
	ChatrDock.minimized=0;
	ChatrOptionsQuote:SetText(Chatr_Version.." (C) AKX 2006\n"..Chatr_VerQuote.."\nCheck /chatr help for some more options");
	ChatrOptionsQuote:SetFont("Fonts/ARIALN.ttf",11,"");
end