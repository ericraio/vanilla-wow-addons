--[Functions: GUI Interface for WIM_History.xml

WIM_HistoryView_Name_Selected = "";
WIM_HistoryView_Filter_Selected = "";

function WIM_HistoryView_NameClick()
	if(WIM_HistoryView_Name_Selected ~= this.Name) then
		WIM_HistoryView_Filter_Selected = "";
	end
	WIM_HistoryView_Name_Selected = this.theName;
	WIM_HistoryViewFiltersScrollBar_Update();
end

function WIM_HistoryView_FilterClick()
	WIM_HistoryView_Filter_Selected = this.theName;
end

function WIM_HistoryViewNameScrollBar_Update()
	local line;
	local lineplusoffset;
	local HistoryNames = {};
	
	for key in WIM_History do
		table.insert(HistoryNames, key);
	end
	table.sort(HistoryNames);
	
	FauxScrollFrame_Update(WIM_HistoryFrameNameListScrollBar,table.getn(HistoryNames),15,16);
	for line=1,15 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(WIM_HistoryFrameNameListScrollBar);
		if lineplusoffset <= table.getn(HistoryNames) then
			getglobal("WIM_HistoryFrameNameListButton"..line.."Name"):SetText(HistoryNames[lineplusoffset]);
			getglobal("WIM_HistoryFrameNameListButton"..line).theName = HistoryNames[lineplusoffset];
			if ( WIM_HistoryView_Name_Selected == HistoryNames[lineplusoffset] ) then
				getglobal("WIM_HistoryFrameNameListButton"..line):LockHighlight();
			else
				getglobal("WIM_HistoryFrameNameListButton"..line):UnlockHighlight();
			end
			getglobal("WIM_HistoryFrameNameListButton"..line):Show();
		else
			getglobal("WIM_HistoryFrameNameListButton"..line):Hide();
		end
	end
end




function WIM_HistoryViewFiltersScrollBar_Update()
	local line;
	local lineplusoffset;
	local Filters = {};
	
	local tDate = "";
	local lDate = "";
	if(WIM_History[WIM_HistoryView_Name_Selected]) then
		for i=1,table.getn(WIM_History[WIM_HistoryView_Name_Selected]) do
			tDate = WIM_History[WIM_HistoryView_Name_Selected][i].date;
			if(tDate ~= lDate) then
				table.insert(Filters, tDate);
				lDate = tDate;
			end
		end
	end
	table.sort(Filters);
	table.insert(Filters, 1, "None (Show All)");
	if(WIM_HistoryView_Filter_Selected == "") then
		--[WIM_HistoryView_Filter_Selected = Filters[1];
	end
	
	FauxScrollFrame_Update(WIM_HistoryFrameFilterListScrollBar,table.getn(Filters),7,16);
	for line=1,7 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(WIM_HistoryFrameFilterListScrollBar);
		if lineplusoffset <= table.getn(Filters) then
			getglobal("WIM_HistoryFrameFilterListButton"..line.."Name"):SetText(Filters[lineplusoffset]);
			if(lineplusoffset == 1) then
				getglobal("WIM_HistoryFrameFilterListButton"..line).theName = "";
			else
				getglobal("WIM_HistoryFrameFilterListButton"..line).theName = Filters[lineplusoffset];
			end
			if ( WIM_HistoryView_Filter_Selected == Filters[lineplusoffset] ) then
				getglobal("WIM_HistoryFrameFilterListButton"..line):LockHighlight();
			else
				getglobal("WIM_HistoryFrameFilterListButton"..line):UnlockHighlight();
			end
			getglobal("WIM_HistoryFrameFilterListButton"..line):Show();
		else
			getglobal("WIM_HistoryFrameFilterListButton"..line):Hide();
		end
	end
	WIM_HistoryView_ShowMessages();
end


function WIM_HistoryView_ShowMessages()
	local tStamp = "";
	local tFrom = "";
	local tMsg = "";
	local prevDate = "";

	WIM_HistoryFrameMessageListScrollingMessageFrame:Clear();
	if(WIM_History[WIM_HistoryView_Name_Selected]) then
		for i = 1, table.getn(WIM_History[WIM_HistoryView_Name_Selected]) do
			if(WIM_HistoryView_Filter_Selected == "" or WIM_HistoryView_Filter_Selected == WIM_History[WIM_HistoryView_Name_Selected][i].date) then
				if(WIM_HistoryView_Filter_Selected == "") then
					if(prevDate ~= WIM_History[WIM_HistoryView_Name_Selected][i].date) then
						prevDate = WIM_History[WIM_HistoryView_Name_Selected][i].date
						WIM_HistoryFrameMessageListScrollingMessageFrame:AddMessage(" ");
						WIM_HistoryFrameMessageListScrollingMessageFrame:AddMessage("|cffffffff["..prevDate.."]|r");
					end
				end
				tStamp = "|cff"..WIM_RGBtoHex(WIM_Data.displayColors.sysMsg.r, WIM_Data.displayColors.sysMsg.g, WIM_Data.displayColors.sysMsg.b)..WIM_History[WIM_HistoryView_Name_Selected][i].time.."|r ";
				tFrom = "[|Hplayer:"..WIM_History[WIM_HistoryView_Name_Selected][i].from.."|h"..WIM_GetAlias(WIM_History[WIM_HistoryView_Name_Selected][i].from, true).."|h]: ";
				tMsg = tStamp..tFrom..WIM_History[WIM_HistoryView_Name_Selected][i].msg;
				if(WIM_History[WIM_HistoryView_Name_Selected][i].type == 1) then
					WIM_HistoryFrameMessageListScrollingMessageFrame:AddMessage(tMsg, WIM_Data.displayColors.wispIn.r, WIM_Data.displayColors.wispIn.g, WIM_Data.displayColors.wispIn.b);
				elseif(WIM_History[WIM_HistoryView_Name_Selected][i].type == 2) then
					WIM_HistoryFrameMessageListScrollingMessageFrame:AddMessage(tMsg, WIM_Data.displayColors.wispOut.r, WIM_Data.displayColors.wispOut.g, WIM_Data.displayColors.wispOut.b);
				end
			end
		end
	end
	WIM_UpdateScrollBars(WIM_HistoryFrameMessageListScrollingMessageFrame);
end
