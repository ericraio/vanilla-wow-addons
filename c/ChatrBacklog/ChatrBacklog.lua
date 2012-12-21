ChatrBacklog_Log={};
ChatrBacklog_Count=5;
ChatrBacklog_Color={0.6,0.6,0.6};

function ChatrBacklog_Init()
	Chatr_CallMe("IncomingWhisper",ChatrBacklog_Record);
	Chatr_CallMe("OutgoingWhisper",ChatrBacklog_Record);
	Chatr_CallMe("Note",ChatrBacklog_Record);
	Chatr_CallMe("OpenChatr",ChatrBacklog_Populate);
	Chatr_Print(GetAddOnMetadata("ChatrBacklog","Title").." loaded.");
	ChatrBacklogOptionsTitle:SetText(GetAddOnMetadata("ChatrBacklog","Title"));
	Chatr_AddPluginButton(ChatrBacklogToggle);

end

function ChatrBacklog_Record(tab)
	local event,chatr,name,msg,fmtd=unpack(tab);
	if ChatrBacklog_Log[name]==nil then
		ChatrBacklog_Log[name]={};
	end
	
	tinsert(ChatrBacklog_Log[name],fmtd);
	if getn(ChatrBacklog_Log[name])>ChatrBacklog_Count then
		tremove(ChatrBacklog_Log[name],1);
	end
end

function ChatrBacklog_Populate(tab)
	local _,v;
	if ChatrBacklog_Log[tab[2].target]~=nil then
		for _,v in ChatrBacklog_Log[tab[2].target] do
			tab[2].chatBox:AddMessage(v,ChatrBacklog_Color[1],ChatrBacklog_Color[2],ChatrBacklog_Color[3]);
		end
	end
end