local IMBA_Msgs={}
local IMBA_MsgQueueTime=0

function IMBA_ProcessMsgQueue()
	if IMBA_MsgQueueTime<GetTime() and getn(IMBA_Msgs)>0 then
		SendAddonMessage(IMBA_Msgs[1][1],IMBA_Msgs[1][2],IMBA_Msgs[1][3])
		tremove(IMBA_Msgs,1);
		IMBA_MsgQueueTime=GetTime()+0.05;
	end
end

function IMBA_AddMsg(addon, msg, channel)
	tinsert(IMBA_Msgs,{addon, msg, channel});
end