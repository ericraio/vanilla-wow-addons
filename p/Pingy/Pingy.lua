PINGY_COLOUR = {r=1,g=1,b=1,a=1};
PINGY_HOLD = .1;
PINGY_SIZE_BIG = 30;
PINGY_SIZE_SMALL = 20;
PINGY_FLAG = "OUTLINE";
PINGY_FONT = "Fonts\\ARIALN.TTF";

function Pingy_OnLoad()
--	DEFAULT_CHAT_FRAME:AddMessage("PINGY LOADED!!!");
	this:RegisterEvent("MINIMAP_PING");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
end
function Pingy_OnEvent()
	if (event == "MINIMAP_PING") then
		PINGY_MSG_Pinger:AddMessage(UnitName(arg1),PINGY_COLOUR.r,PINGY_COLOUR.g,PINGY_COLOUR.b,PINGY_COLOUR.a);
		if (UnitIsPartyLeader(arg1)) then
			PINGY_MSG_Leader:AddMessage("Leader",PINGY_COLOUR.r,PINGY_COLOUR.g,PINGY_COLOUR.b,PINGY_COLOUR.a);
		end
		PINGY_MSG_Class:AddMessage(UnitClass(arg1),PINGY_COLOUR.r,PINGY_COLOUR.g,PINGY_COLOUR.b,PINGY_COLOUR.a);
	end
	if (event == "PLAYER_ENTERING_WORLD") then
		PINGY_MSG_Pinger:SetFont(PINGY_FONT,PINGY_SIZE_BIG,PINGY_FLAG);
		PINGY_MSG_Pinger:SetHeight(PINGY_SIZE_BIG+1);
		PINGY_MSG_Pinger:SetTimeVisible(PINGY_HOLD)
		PINGY_MSG_Leader:SetFont(PINGY_FONT,PINGY_SIZE_SMALL,PINGY_FLAG);
		PINGY_MSG_Leader:SetHeight(PINGY_SIZE_SMALL+2);
		PINGY_MSG_Leader:SetTimeVisible(PINGY_HOLD)
		PINGY_MSG_Class:SetFont(PINGY_FONT,PINGY_SIZE_SMALL,PINGY_FLAG);
		PINGY_MSG_Class:SetHeight(PINGY_SIZE_SMALL+2);
		PINGY_MSG_Class:SetTimeVisible(PINGY_HOLD)
	end
end