function GB_UnitFrames_Initialize()
	GB_UnitFrames_Detect();
end

function GB_UnitFrames_Detect()
	if (DUF_EventFrame) then
		GB_UNITFRAMES = {
			player = { 
				frames={"DUF_PlayerFrame"},
				onClick =  {name="DUF_UnitFrame_OnClick"},
				onEnter = {name="UnitFrame_OnEnter"},
				onLeave = {name="UnitFrame_OnLeave"},
				onDrag = {name="PlayerFrame_OnReceiveDrag"},
				xoffset=5, yoffset=5 },
			party = {
				frames={"DUF_PartyFrame1", "DUF_PartyFrame2", "DUF_PartyFrame3", "DUF_PartyFrame4"},
				onClick= {name="DUF_UnitFrame_OnClick"},
				onEnter = {name="UnitFrame_OnEnter", override=true},
				onLeave = {name="UnitFrame_OnLeave", override=true},
				xoffset=5, yoffset=5 },
			target = {
				frames={"DUF_TargetFrame"},
				onClick =  {name="DUF_UnitFrame_OnClick"},
				onEnter = {name="UnitFrame_OnEnter"},
				onLeave = {name="UnitFrame_OnLeave"},
				xoffset=5, yoffset=5 },
		};
	end
end