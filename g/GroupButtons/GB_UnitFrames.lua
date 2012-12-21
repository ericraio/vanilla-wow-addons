function GB_UnitFrames_Initialize()
	if (not GB_INITIALIZED) then return; end 
	GB_UnitFrames_Detect();

	for unit, value in GB_UNITFRAMES do
		for i, frame in value.frames do
			local clickbox = getglobal(GB_CLICKBOXES2[unit][i]);
			unit2 = unit;
			if (unit == "target") then unit2 = "friendlytarget"; end
			local offsets = GB_Settings[GB_INDEX][unit2].Clickbox;
			if (not getglobal(frame)) then
				clickbox:ClearAllPoints();
				clickbox:SetPoint("TOP", "UIParent", "BOTTOM", 100, -100);
				clickbox:Hide();
			else
				local frameheight = getglobal(frame):GetHeight();
				local framewidth = getglobal(frame):GetWidth();
				if ( (offsets.x1 - offsets.x2) > framewidth) then
					offsets.x2 = 0;
				end
				if ( (offsets.y2 - offsets.y1) > frameheight) then
					offsets.y1 = 0;
				end
				clickbox:ClearAllPoints();
				clickbox:SetPoint("TOPLEFT", frame, "TOPLEFT", offsets.x1, offsets.y1);
				clickbox:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", offsets.x2, offsets.y2);
				clickbox:Raise()
			end
		end
	end

	if (not GB_Settings[GB_INDEX].hideClickboxes) then
		if (UnitName("pet")) then
			GB_Pet0Clickbox:Show();
		end
		for i=1,GetNumPartyMembers() do
			getglobal("GB_Party"..i.."Clickbox"):Show();
			if (UnitName("partypet"..i)) then
				getglobal("GB_Pet"..i.."Clickbox"):Show();
			end
		end
	end
end

function GB_UnitFrames_Detect()
	if (DUF_EventFrame) then
		GB_UNITFRAMES = {
			player = { 
				frames={"DUF_PlayerFrame"},
				onClick =  {name="DUF_UnitFrame_OnClick", params={"mousebutton", "unitID"}},
				onEnter = {name="DUF_UnitFrame_OnEnter", params={"unitID", "frame"}},
				onLeave = {name="DUF_UnitFrame_OnLeave", params={"frame"}},
				onMouseUp = {name="", override="GB_DUF_OnMouseUp"}
				},
			party = {
				frames={"DUF_PartyFrame1", "DUF_PartyFrame2", "DUF_PartyFrame3", "DUF_PartyFrame4"},
				onClick =  {name="DUF_UnitFrame_OnClick", params={"mousebutton", "unitID"}},
				onEnter = {name="DUF_UnitFrame_OnEnter", params={"unitID", "frame"}},
				onLeave = {name="DUF_UnitFrame_OnLeave", params={"frame"}},
				onMouseUp = {name="", override="GB_DUF_OnMouseUp"}
				},
			target = {
				frames={"DUF_TargetFrame"},
				onClick =  {name="DUF_UnitFrame_OnClick", params={"mousebutton", "unitID"}},
				onEnter = {name="DUF_UnitFrame_OnEnter", params={"unitID", "frame"}},
				onLeave = {name="DUF_UnitFrame_OnLeave", params={"frame"}},
				onMouseUp = {name="", override="GB_DUF_OnMouseUp"}
				},
			pet = {
				frames={"DUF_PetFrame"},
				onClick =  {name="DUF_UnitFrame_OnClick", params={"mousebutton", "unitID"}},
				onEnter = {name="DUF_UnitFrame_OnEnter", params={"unitID", "frame"}},
				onLeave = {name="DUF_UnitFrame_OnLeave", params={"frame"}},
				onMouseUp = {name="", override="GB_DUF_OnMouseUp"}
			},
			partypet = {
				frames={"DUF_PartyPetFrame1", "DUF_PartyPetFrame2", "DUF_PartyPetFrame3", "DUF_PartyPetFrame4"},
				onClick =  {name="DUF_UnitFrame_OnClick", params={"mousebutton", "unitID"}},
				onEnter = {name="DUF_UnitFrame_OnEnter", params={"unitID", "frame"}},
				onLeave = {name="DUF_UnitFrame_OnLeave", params={"frame"}},
				onMouseUp = {name="", override="GB_DUF_OnMouseUp"}
			}
		};
	elseif (MGParty_Member0) then
		GB_UNITFRAMES = {
			player = { 
				frames={"MGParty_Member0"},
				onClick= {name="MGParty_Member_OnClick", params={}},
				onEnter = {name="MGParty_Member_OnEnter", params={}},
				onLeave = {name="MGParty_Member_OnLeave", params={}},
				onDrag = {name="PlayerFrame_OnReceiveDrag", params = {}}
				},
			party = {
				frames={"MGParty_Member1", "MGParty_Member2", "MGParty_Member3", "MGParty_Member4"},
				onClick= {name="MGParty_Member_OnClick", params={}},
				onEnter = {name="MGParty_Member_OnEnter", params={}},
				onLeave = {name="MGParty_Member_OnLeave", params={}}
				},
			target = {
				frames={"MGTarget_Frame"},
				onClick =  {name="MGTarget_OnClick", params={"mousebutton"}},
				onEnter = {name="MGTarget_OnEnter", params = {}},
				onLeave = {name="MGTarget_OnLeave", params = {}}
				},
			pet = {
				frames={"PetFrame"},
				onClick =  {name="PetFrame_OnClick", params={"mousebutton"}},
				onEnter = {name="UnitFrame_OnEnter", override="GB_DefaultPartyFrame_OnEnter", params = {}},
				onLeave = {name="UnitFrame_OnLeave", override="GB_DefaultPartyFrame_OnLeave", params = {}}
			},
			partypet = {
				frames={"PartyMemberFrame1PetFrame", "PartyMemberFrame2PetFrame", "PartyMemberFrame3PetFrame", "PartyMemberFrame4PetFrame"},
				onClick =  {name="PartyMemberPetFrame_OnClick", params={}},
				onEnter = {name="UnitFrame_OnEnter", params = {}},
				onLeave = {name="UnitFrame_OnLeave", params = {}}
			}
		};
	elseif (MGplayer) then
		GB_UNITFRAMES = {
		player = { 
			frames={"MGplayer"},
			onClick= {name="MiniGroup_Member_OnClick", params={"mousebutton"}},
			onEnter = {name="", override = "GB_MiniGroup_OnEnter", params={}},
			onLeave = {name="", override = "GB_MiniGroup_OnLeave", params={}},
			onMouseDown = {name="MiniGroup_Member_OnMouseDown", params={"mousebutton"}},
			onMouseUp = {name="MiniGroup_Member_OnMouseUp", params={"mousebutton"}}
			},
		party = {
			frames={"MGparty1", "MGparty2", "MGparty3", "MGparty4"},
			onClick= {name="MiniGroup_Member_OnClick", params={"mousebutton"}},
			onEnter = {name="", override = "GB_MiniGroup_OnEnter", params={}},
			onLeave = {name="", override = "GB_MiniGroup_OnLeave", params={}},
			onMouseDown = {name="MiniGroup_Member_OnMouseDown", params={"mousebutton"}},
			onMouseUp = {name="MiniGroup_Member_OnMouseUp", params={"mousebutton"}}
			},
		target = {
			frames={"MGtarget"},
			onClick= {name="MiniGroup_Member_OnClick", params={"mousebutton"}},
			onEnter = {name="", override = "GB_MiniGroup_OnEnter", params={}},
			onLeave = {name="", override = "GB_MiniGroup_OnLeave", params={}},
			onMouseDown = {name="MiniGroup_Member_OnMouseDown", params={"mousebutton"}},
			onMouseUp = {name="MiniGroup_Member_OnMouseUp", params={"mousebutton"}}
			},
		pet = {
			frames={"MGpet"},
			onClick= {name="MiniGroup_Member_OnClick", params={"mousebutton"}},
			onEnter = {name="", override = "GB_MiniGroup_OnEnter", params={}},
			onLeave = {name="", override = "GB_MiniGroup_OnLeave", params={}},
			onMouseDown = {name="MiniGroup_Member_OnMouseDown", params={"mousebutton"}},
			onMouseUp = {name="MiniGroup_Member_OnMouseUp", params={"mousebutton"}}
			},
		partypet = {
			frames={"MGpartypet1", "MGpartypet2", "MGpartypet3", "MGpartypet4"},
			onClick= {name="MiniGroup_Member_OnClick", params={"mousebutton"}},
			onEnter = {name="", override = "GB_MiniGroup_OnEnter", params={}},
			onLeave = {name="", override = "GB_MiniGroup_OnLeave", params={}},
			onMouseDown = {name="MiniGroup_Member_OnMouseDown", params={"mousebutton"}},
			onMouseUp = {name="MiniGroup_Member_OnMouseUp", params={"mousebutton"}}
			}
		};
	elseif (Nurfed_player) then
		GB_UNITFRAMES = {
			player = { 
				frames={"Nurfed_player"},
				onClick= {name="Nurfed_Unit_OnClick", params={"mousebutton", "nurfed"}}
				},
			party = {
				frames={"Nurfed_party1", "Nurfed_party2", "Nurfed_party3", "Nurfed_party4"},
				onClick= {name="Nurfed_Unit_OnClick", params={"mousebutton", "nurfed"}},
				onEnter = {name="Nurfed_UnitFrame_OnEnter", params={"unitID"}},
				onLeave = {name="Nurfed_UnitFrame_OnLeave", params={}}
				},
			target = {
				frames={"Nurfed_target"},
				onClick= {name="Nurfed_Unit_OnClick", params={"mousebutton", "nurfed"}}
				},
			pet = {
				frames={"Nurfed_pet"},
				onClick= {name="Nurfed_Unit_OnClick", params={"mousebutton", "nurfed"}}
				},
			partypet = {
				frames={"Nurfed_partypet1", "Nurfed_partypet2", "Nurfed_partypet3", "Nurfed_partypet4"},
				onClick= {name="Nurfed_Unit_OnClick", params={"mousebutton", "nurfed"}}
				}
		};
	elseif (Perl_party1) then
		GB_UNITFRAMES = {
			player = { 
				frames={"Perl_Player_Frame"},
				onClick= {name="Perl_Party_MouseDown", params={"mousebutton"}},
				onMouseUp = {name="Perl_Party_MouseUp", params={"mousebutton"}},
				onEnter = {name="Perl_Player_MouseEnter", params={}},
				onLeave = {name="Perl_Player_MouseLeave", params={}}
				},
			party = {
				frames={"Perl_party1", "Perl_party2", "Perl_party3", "Perl_party4"},
				onClick= {name="Perl_Party_MouseDown", params={"mousebutton"}},
				onMouseUp = {name="Perl_Party_MouseUp", params={"mousebutton"}},
				onEnter = {name="Perl_Party_PlayerTip", params={}},
				onLeave = {name="GB_Hide_PlayerTooltip", params={}}
				},
			target = {
				frames={"Perl_Target_Frame"},
				onClick= {name="Perl_Target_MouseDown", params={"mousebutton"}},
				onMouseUp = {name="Perl_Target_MouseUp", params={"mousebutton"}},
				onEnter = {name="Perl_Target_PlayerTip", params={}},
				onLeave = {name="GB_Hide_PlayerTooltip", params={}}
				},
			pet = {
				frames={"Perl_Player_Pet_Frame"},
				onClick =  {name="Perl_Player_Pet_MouseDown", params={"mousebutton"}},
				onMouseUp = {name="Perl_Player_Pet_MouseUp", params={"mousebutton"}},
				onEnter = {name="UnitFrame_OnEnter", override="GB_DefaultPartyFrame_OnEnter", params = {}},
				onLeave = {name="UnitFrame_OnLeave", override="GB_DefaultPartyFrame_OnLeave", params = {}}
				},
			partypet = {
				frames={"Perl_Party_Pet1", "Perl_Party_Pet2", "Perl_Party_Pet3", "Perl_Party_Pet4"},
				onClick =  {name="Perl_Party_Pet_MouseDown", params={"mousebutton"}},
				onMouseUp = {name="Perl_Party_Pet_MouseUp", params={"mousebutton"}},
				onEnter = {name="Perl_Party_Pet_PlayerTip", params = {}},
				onLeave = {name="UnitFrame_OnLeave", params = {}}
				}
		};
	elseif (WatchDogFrame) then
		GB_UNITFRAMES = {
			player = { 
				frames={"WatchDogFrame_player"},
				onClick= {name="WatchDog_OnClick", params={"mousebutton"}},
				onEnter = {name="UnitFrame_OnEnter", params={}},
				onLeave = {name="UnitFrame_OnLeave", params={}}
				},
			party = {
				frames={"WatchDogFrame_party1", "WatchDogFrame_party2", "WatchDogFrame_party3", "WatchDogFrame_party4"},
				onClick= {name="WatchDog_OnClick", params={"mousebutton"}},
				onEnter = {name="UnitFrame_OnEnter", params={}},
				onLeave = {name="UnitFrame_OnLeave", params={}}
				},
			target = {
				frames={"WatchDogFrame_target"},
				onClick= {name="WatchDog_OnClick", params={"mousebutton"}},
				onEnter = {name="UnitFrame_OnEnter", params={}},
				onLeave = {name="UnitFrame_OnLeave", params={}}
				},
			pet = {
				frames={"WatchDogFrame_pet"},
				onClick= {name="WatchDog_OnClick", params={"mousebutton"}},
				onEnter = {name="UnitFrame_OnEnter", params={}},
				onLeave = {name="UnitFrame_OnLeave", params={}}
				},
			partypet = {
				frames={"WatchDogFrame_partypet1", "WatchDogFrame_partypet2", "WatchDogFrame_partypet3", "WatchDogFrame_partypet4"},
				onClick= {name="WatchDog_OnClick", params={"mousebutton"}},
				onEnter = {name="UnitFrame_OnEnter", params={}},
				onLeave = {name="UnitFrame_OnLeave", params={}}
				}
		};
	elseif (Perl_Party_MemberFrame1) then
		GB_UNITFRAMES = {
			player = { 
				frames={"Perl_Player_Frame"},
				onClick= {name="Perl_Player_MouseClick", params={"mousebutton"}},
				onMouseDown = {name="Perl_Player_MouseDown", params={"mousebutton"}},
				onMouseUp = {name="Perl_Player_MouseUp", params={"mousebutton"}}
				},
			party = {
				frames={"Perl_Party_MemberFrame1", "Perl_Party_MemberFrame2", "Perl_Party_MemberFrame3", "Perl_Party_MemberFrame4"},
				onClick= {name="Perl_Party_MouseClick", params={"mousebutton"}},
				onMouseDown = {name="Perl_Party_MouseDown", params={"mousebutton"}},
				onMouseUp = {name="Perl_Party_MouseUp", params={"mousebutton"}},
				onEnter = {name="Perl_Party_Tip", params={}},
				onLeave = {name="UnitFrame_OnLeave", params={}}
				},
			target = {
				frames={"Perl_Target_Frame"},
				onClick= {name="Perl_Target_MouseClick", params={"mousebutton"}},
				onMouseDown = {name="Perl_Target_MouseDown", params={"mousebutton"}},
				onMouseUp = {name="Perl_Target_MouseUp", params={"mousebutton"}},
				onEnter = {name="Perl_Target_Tip", params={}},
				onLeave = {name="UnitFrame_OnLeave", params={}}
				},
			pet = {
				frames={"Perl_Player_Pet_Frame"},
				onClick= {name="Perl_Player_Pet_MouseClick", params={"mousebutton"}},
				onMouseDown =  {name="Perl_Player_Pet_MouseDown", params={"mousebutton"}},
				onMouseUp = {name="Perl_Player_Pet_MouseUp", params={"mousebutton"}}
				},
			partypet = {
				frames={"PartyMemberFrame1PetFrame", "PartyMemberFrame2PetFrame", "PartyMemberFrame3PetFrame", "PartyMemberFrame4PetFrame"},
				onClick =  {name="PartyMemberPetFrame_OnClick", params={}},
				onEnter = {name="UnitFrame_OnEnter", params = {}},
				onLeave = {name="UnitFrame_OnLeave", params = {}}
			}
		};
	end
end

function GB_UnitFrame_OnClick(mousebutton)
	local keys = "";

	if (IsShiftKeyDown()) then
		keys = "s";
	end
	if (IsAltKeyDown()) then
		keys = keys.."a";
	end
	if (IsControlKeyDown()) then
		keys = keys.."c";
	end
	if (mousebutton == "LeftButton") then
		keys = keys.."l";
	elseif (mousebutton == "RightButton") then
		keys = keys.."r";
	elseif (mousebutton == "MiddleButton") then
		keys = keys.."m";
	elseif (mousebutton == "Button4") then
		keys="4";
	elseif (mousebutton == "Button5") then
		keys="5";
	end

	local bar = this.bar;
	if (bar == "target") then
		if (UnitCanAttack("player", "target")) then
			bar = "hostiletarget";
		else
			bar = "friendlytarget";
		end
	end
	if (keys == GB_Settings[GB_INDEX][bar].oldLeftClick or keys == GB_Settings[GB_INDEX][bar].oldRightClick) then
		local func;
		local clickparams;
		if (GB_UNITFRAMES[this.bar].onClick) then
			func = getglobal(GB_UNITFRAMES[this.bar].onClick.name);
			clickparams = GB_UNITFRAMES[this.bar].onClick.params;
		else
			return;
		end
		local params = {};
		for i, v in clickparams do
			if (v == "mousebutton") then
				params[i] = mousebutton;
			elseif (v == "unitID") then
				params[i] = this.unit;
			elseif (v == "nurfed") then
				params[i] = Nurfed_Units[getglobal(GB_UNITFRAMES[this.bar].frames[this:GetID()]):GetName()];
			end
		end
		this = getglobal(GB_UNITFRAMES[this.bar].frames[this:GetID()]);
		func(params[1], params[2], params[3], params[4], params[5]);
		return;
	end

	local buttonNum = GB_Settings[GB_INDEX][bar].clickCast[keys];
	if (buttonNum) then
		local unitBar = GB_Get_UnitBar(this.unit);
		if (this.index == "lowesthealth") then
			unitBar = GB_Get_UnitBar(this.index);
		end
		GB_ActionButton_OnClick(unitBar, buttonNum, 1);
	end
end

function GB_UnitFrame_OnEnter()
	local unitBar = getglobal(GB_Get_UnitBar(this.unit));
	if (this.index == "lowesthealth") then
		unitBar = GB_Get_UnitBar(this.index);
	end
	if (GB_Settings[GB_INDEX][unitBar.index].mouseover) then
		unitBar.timer = nil;
		unitBar:Show();
	end
	if (not GB_UNITFRAMES[this.bar].onEnter) then return; end
	if (GB_UNITFRAMES[this.bar].onEnter.override) then
		local func = getglobal(GB_UNITFRAMES[this.bar].onEnter.override);
		func();
		return;
	end
	local func = getglobal(GB_UNITFRAMES[this.bar].onEnter.name);
	local params = {};
	for i, v in GB_UNITFRAMES[this.bar].onEnter.params do
		if (v ==  "frame") then
			params[i] = getglobal(GB_UNITFRAMES[this.bar].frames[this:GetID()]);
		elseif (v == "unitID") then
			params[i] = this.unit;
		end
	end
	this = getglobal(GB_UNITFRAMES[this.bar].frames[this:GetID()]);
	func(params[1], params[2], params[3], params[4], params[5]);
end

function GB_UnitFrame_OnEvent(event)
	if (not GB_INITIALIZED) then return; end
	if (event == "PARTY_MEMBERS_CHANGED") then
		if (not GB_Settings[GB_INDEX].hideClickboxes) then
			local numParty = GetNumPartyMembers();
			for i=1,numParty do
				getglobal("GB_Party"..i.."Clickbox"):Show();
				if (UnitName("partypet"..i)) then
					getglobal("GB_Pet"..i.."Clickbox"):Show();
				end
			end
			numParty = numParty + 1;
			if (numParty < 5) then
				for i=numParty,4 do
					getglobal("GB_Party"..i.."Clickbox"):Hide();
					getglobal("GB_Pet"..i.."Clickbox"):Hide();
				end
			end
		end
	elseif (event == "PLAYER_TARGET_CHANGED") then
		if (UnitName("target")) then
			if (not GB_Get("hideClickboxes")) then
				this:Show();				
			end
		else
			this:Hide();
		end
	elseif (event == "UNIT_PET") then
		if (UnitName(this.unit) and UnitExists(this.unit)) then
			if (not GB_Get("hideClickboxes")) then
				this:Show();				
			end
		else
			this:Hide();
		end
	end
end

function GB_UnitFrame_OnLeave()
	local unitBar = getglobal(GB_Get_UnitBar(this.unit));
	if (this.index == "lowesthealth") then
		unitBar = GB_Get_UnitBar(this.index);
	end
	if (not unitBar) then return; end
	if (GB_Settings[GB_INDEX][unitBar.index].mouseover) then
		unitBar.timer = GB_MOUSEOUT_TIME;
	end
	if (not GB_UNITFRAMES[this.bar].onLeave) then return; end
	if (GB_UNITFRAMES[this.bar].onLeave.override) then
		local func = getglobal(GB_UNITFRAMES[this.bar].onLeave.override);
		func();
		return;
	end
	local func = getglobal(GB_UNITFRAMES[this.bar].onLeave.name);
	local params = {};
	for i, v in GB_UNITFRAMES[this.bar].onLeave.params do
		if (v ==  "frame") then
			params[i] = getglobal(GB_UNITFRAMES[this.bar].frames[this:GetID()]);
		elseif (v == "unitID") then
			params[i] = this.unit;
		end
	end
	this = getglobal(GB_UNITFRAMES[this.bar].frames[this:GetID()]);
	func(params[1], params[2], params[3], params[4], params[5]);
end

function GB_UnitFrame_OnMouseDown(mousebutton)
	if (not GB_UNITFRAMES[this.bar].onMouseDown) then return; end
	if (DUF_EventFrame) then
		if (IsShiftKeyDown() or IsAltKeyDown() or IsControlKeyDown() or mousebutton == "MiddleButton") then
			return;
		end
	end
	local func = getglobal(GB_UNITFRAMES[this.bar].onMouseDown.name);
	local params = {};
	for i, v in GB_UNITFRAMES[this.bar].onMouseDown.params do
		if (v == "mousebutton") then
			params[i] = mousebutton;
		elseif (v == "unitID") then
			params[i] = this.unit;
		end
	end
	this = getglobal(GB_UNITFRAMES[this.bar].frames[this:GetID()]);
	func(params[1], params[2], params[3], params[4], params[5]);
end

function GB_UnitFrame_OnMouseUp(mousebutton)
	if (not GB_UNITFRAMES[this.bar].onMouseUp) then return; end
	if (GB_UNITFRAMES[this.bar].onMouseUp.override) then
		local func = getglobal(GB_UNITFRAMES[this.bar].onMouseUp.override);
		func();
		return;
	end
	local func = getglobal(GB_UNITFRAMES[this.bar].onMouseUp.name);
	local params = {};
	for i, v in GB_UNITFRAMES[this.bar].onMouseUp.params do
		if (v == "mousebutton") then
			params[i] = mousebutton;
		elseif (v == "unitID") then
			params[i] = this.unit;
		end
	end
	this = getglobal(GB_UNITFRAMES[this.bar].frames[this:GetID()]);
	func(params[1], params[2], params[3], params[4], params[5]);
end

function GB_UnitFrame_OnReceiveDrag()
	if (not GB_UNITFRAMES[this.bar]["onDrag"]) then return; end
	local func = getglobal(GB_UNITFRAMES[this.bar].onDrag.name);
	local params = {};
	for i, v in GB_UNITFRAMES[this.bar].onDrag.params do
		if (v ==  "frame") then
			params[i] = getglobal(GB_UNITFRAMES[this.bar].frames[this:GetID()]);
		elseif (v == "unitID") then
			params[i] = this.unit;
		end
	end
	this = getglobal(GB_UNITFRAMES[this.bar].frames[this:GetID()]);
	func(params[1], params[2], params[3], params[4], params[5]);
end

function GB_DefaultPartyFrame_OnEnter()
	this = getglobal(GB_UNITFRAMES[this.bar].frames[this:GetID()]);
	UnitFrame_OnEnter();
	PartyMemberBuffTooltip:SetPoint("TOPLEFT", this:GetName(), "TOPLEFT", 60, -25);
	PartyMemberBuffTooltip_Update();
end

function GB_DefaultPartyFrame_OnLeave()
	this = getglobal(GB_UNITFRAMES[this.bar].frames[this:GetID()]);
	UnitFrame_OnLeave();
	PartyMemberBuffTooltip:Hide();
end

function GB_MiniGroup_OnEnter()
	this = getglobal(GB_UNITFRAMES[this.bar].frames[this:GetID()]);
	MiniGroup_Member_OnEnter();
	UnitFrame_OnEnter();
end

function GB_MiniGroup_OnLeave()
	this = getglobal(GB_UNITFRAMES[this.bar].frames[this:GetID()]);
	MiniGroup_Member_OnLeave();
	UnitFrame_OnLeave();
end

function GB_DUF_OnMouseUp()
	this = getglobal(GB_UNITFRAMES[this.bar].frames[this:GetID()]);
	if (not DUF_Settings[DUF_INDEX].FramesLocked) then
		DUF_UnitFrame_StopMoving(this.unit);
	end
end

function GB_CT_RA_MemberFrame_OnClick(mousebutton)
	local keys = "";

	if (IsShiftKeyDown()) then
		keys = "s";
	end
	if (IsAltKeyDown()) then
		keys = keys.."a";
	end
	if (IsControlKeyDown()) then
		keys = keys.."c";
	end
	if (mousebutton == "LeftButton") then
		keys = keys.."l";
	elseif (mousebutton == "RightButton") then
		keys = keys.."r";
	elseif (mousebutton == "MiddleButton") then
		keys = keys.."m";
	elseif (mousebutton == "Button4") then
		keys="4";
	elseif (mousebutton == "Button5") then
		keys="5";
	end

	local bar = "raid";

	if (keys == GB_Settings[GB_INDEX][bar].oldLeftClick or keys == GB_Settings[GB_INDEX][bar].oldRightClick) then
		GB_Old_CT_RA_MemberFrame_OnClick(mousebutton);
		return;
	end

	local buttonNum = GB_Settings[GB_INDEX][bar].clickCast[keys];
	local id = this:GetParent():GetParent():GetID();
	if (buttonNum) then
		GB_ActionButton_OnClick(GB_Get_UnitBar("raid"..id), buttonNum, 1);
	end
end

function GB_CT_RA_MemberFrame_OnEnter()
	GB_Old_CT_RA_MemberFrame_OnEnter();
	local id = this:GetParent():GetParent():GetID();
	local unitBar = getglobal(GB_Get_UnitBar("raid"..id));
	if (GB_Settings[GB_INDEX][unitBar.index].mouseover) then
		unitBar.timer = nil;
		unitBar:Show();
	end
end

function GB_CT_RA_MemberFrame_OnLeave()
	GB_Old_CT_RA_MemberFrame_OnLeave();
	local id = this:GetParent():GetParent():GetID();
	local unitBar = getglobal(GB_Get_UnitBar("raid"..id));
	if (GB_Settings[GB_INDEX][unitBar.index].mouseover) then
		unitBar.timer = GB_MOUSEOUT_TIME;
	end
end

function GB_Hide_PlayerTooltip()
	GameTooltip:Hide();
end

function GB_Perl_Raid_MouseUp(mousebutton)
		local keys = "";

	if (IsShiftKeyDown()) then
		keys = "s";
	end
	if (IsAltKeyDown()) then
		keys = keys.."a";
	end
	if (IsControlKeyDown()) then
		keys = keys.."c";
	end
	if (mousebutton == "LeftButton") then
		keys = keys.."l";
	elseif (mousebutton == "RightButton") then
		keys = keys.."r";
	elseif (mousebutton == "MiddleButton") then
		keys = keys.."m";
	elseif (mousebutton == "Button4") then
		keys="4";
	elseif (mousebutton == "Button5") then
		keys="5";
	end

	local bar = "raid";

	if (keys == GB_Settings[GB_INDEX][bar].oldLeftClick or keys == GB_Settings[GB_INDEX][bar].oldRightClick) then
		GB_Old_Perl_Raid_MouseUp(mousebutton);
		return;
	end

	local buttonNum = GB_Settings[GB_INDEX][bar].clickCast[keys];
	local id = this:GetParent():GetParent():GetID();
	if (buttonNum) then
		GB_ActionButton_OnClick(GB_Get_UnitBar("raid"..id), buttonNum, 1);
	end
end

function GB_DUF_Element_OnClick(mousebutton)
	local keys = "";

	if (IsShiftKeyDown()) then
		keys = "s";
	end
	if (IsAltKeyDown()) then
		keys = keys.."a";
	end
	if (IsControlKeyDown()) then
		keys = keys.."c";
	end
	if (mousebutton == "LeftButton") then
		keys = keys.."l";
	elseif (mousebutton == "RightButton") then
		keys = keys.."r";
	elseif (mousebutton == "MiddleButton") then
		keys = keys.."m";
	elseif (mousebutton == "Button4") then
		keys="4";
	elseif (mousebutton == "Button5") then
		keys="5";
	end

	local unit = this.unit;
	if (not this.unit) then
		unit = this:GetParent().unit;
	end

	local bar;
	local frame = this:GetName();
	if (string.find(frame, "DUF_PlayerFrame")) then
		bar = "player";
	elseif (string.find(frame, "DUF_PartyFrame")) then
		bar = "party";
	elseif (string.find(frame, "DUF_PartyPetFrame")) then
		bar = "partypet";
	elseif (string.find(frame, "DUF_TargetFrame") or string.find(frame, "DUF_TargetOfTargetFrame")) then
		bar = "target";
	elseif (string.find(frame, "DUF_PetFrame")) then
		bar = "pet";
	end
	if (bar == "target") then
		if (UnitCanAttack("player", unit)) then
			bar = "hostiletarget";
		else
			bar = "friendlytarget";
		end
	end
	if (keys == GB_Settings[GB_INDEX][bar].oldLeftClick or keys == GB_Settings[GB_INDEX][bar].oldRightClick) then
		GB_Old_DUF_Element_OnClick(mousebutton);
		return;
	end

	local buttonNum = GB_Settings[GB_INDEX][bar].clickCast[keys];
	if (buttonNum) then
		local unitBar = GB_Get_UnitBar(unit);
		if (not unitBar) then
			unitBar = GB_Get_UnitBar(bar);
		end
		GB_ActionButton_OnClick(unitBar, buttonNum, 1, unit);
	else
		GB_Old_DUF_Element_OnClick(mousebutton);
	end
end

function GB_DUF_UnitFrame_OnClick(mousebutton)
	local keys = "";

	if (IsShiftKeyDown()) then
		keys = "s";
	end
	if (IsAltKeyDown()) then
		keys = keys.."a";
	end
	if (IsControlKeyDown()) then
		keys = keys.."c";
	end
	if (mousebutton == "LeftButton") then
		keys = keys.."l";
	elseif (mousebutton == "RightButton") then
		keys = keys.."r";
	elseif (mousebutton == "MiddleButton") then
		keys = keys.."m";
	elseif (mousebutton == "Button4") then
		keys="4";
	elseif (mousebutton == "Button5") then
		keys="5";
	end

	local unit = this.unit;

	local bar;
	local frame = this:GetName();
	if (frame == "DUF_PlayerFrame") then
		bar = "player";
	elseif (string.find(frame, "DUF_PartyFrame")) then
		bar = "party";
	elseif (string.find(frame, "DUF_PartyPetFrame")) then
		bar = "partypet";
	elseif (frame == "DUF_TargetFrame" or frame == "DUF_TargetOfTargetFrame") then
		bar = "target";
	elseif (frame == "DUF_PetFrame") then
		bar = "pet";
	end
	if (bar == "target") then
		if (UnitCanAttack("player", this.unit)) then
			bar = "hostiletarget";
		else
			bar = "friendlytarget";
		end
	end
	if (keys == GB_Settings[GB_INDEX][bar].oldLeftClick or keys == GB_Settings[GB_INDEX][bar].oldRightClick) then
		GB_Old_DUF_UnitFrame_OnClick(mousebutton);
		return;
	end

	local buttonNum = GB_Settings[GB_INDEX][bar].clickCast[keys];
	if (buttonNum) then
		local unitBar = GB_Get_UnitBar(this.unit);
		if (not unitBar) then
			unitBar = GB_Get_UnitBar(bar);
		end
		GB_ActionButton_OnClick(unitBar, buttonNum, 1, this.unit);
	else
		GB_Old_DUF_UnitFrame_OnClick(mousebutton);
	end
end

function GB_DUF_Element_OnEnter()
	GB_Old_DUF_Element_OnEnter();
	local unitBar = getglobal(GB_Get_UnitBar(this:GetParent().unit));
	if (unitBar and GB_Settings[GB_INDEX][unitBar.index].mouseover) then
		unitBar.timer = nil;
		unitBar:Show();
	end
end

function GB_DUF_UnitFrame_OnEnter()
	GB_Old_DUF_UnitFrame_OnEnter();
	local unitBar = getglobal(GB_Get_UnitBar(this.unit));
	if (unitBar and GB_Settings[GB_INDEX][unitBar.index].mouseover) then
		unitBar.timer = nil;
		unitBar:Show();
	end
end

function GB_DUF_Element_OnLeave()
	GB_Old_DUF_Element_OnLeave();
	local unitBar = getglobal(GB_Get_UnitBar(this:GetParent().unit));
	if (unitBar and GB_Settings[GB_INDEX][unitBar.index].mouseover) then
		unitBar.timer = GB_MOUSEOUT_TIME;
	end
end

function GB_DUF_UnitFrame_OnLeave()
	GB_Old_DUF_UnitFrame_OnLeave();
	local unitBar = getglobal(GB_Get_UnitBar(this.unit));
	if (unitBar and GB_Settings[GB_INDEX][unitBar.index].mouseover) then
		unitBar.timer = GB_MOUSEOUT_TIME;
	end
end

function GB_RaidPulloutButton_OnClick()
	local mousebutton = arg1;
	local keys = "";

	if (IsShiftKeyDown()) then
		keys = "s";
	end
	if (IsAltKeyDown()) then
		keys = keys.."a";
	end
	if (IsControlKeyDown()) then
		keys = keys.."c";
	end
	if (mousebutton == "LeftButton") then
		keys = keys.."l";
	elseif (mousebutton == "RightButton") then
		keys = keys.."r";
	elseif (mousebutton == "MiddleButton") then
		keys = keys.."m";
	elseif (mousebutton == "Button4") then
		keys="4";
	elseif (mousebutton == "Button5") then
		keys="5";
	end

	local unit = this.unit;
	if (not unit) then
		unit = this:GetParent().unit;
	end

	local bar = "raid";

	if (keys == GB_Settings[GB_INDEX][bar].oldLeftClick or keys == GB_Settings[GB_INDEX][bar].oldRightClick) then
		arg1 = mousebutton;
		GB_Old_RaidPulloutButton_OnClick();
		return;
	end

	local buttonNum = GB_Settings[GB_INDEX][bar].clickCast[keys];
	if (buttonNum) then
		local unitBar = GB_Get_UnitBar(unit);
		GB_ActionButton_OnClick(unitBar, buttonNum, 1);
	else
		arg1 = mousebutton;
		GB_Old_RaidPulloutButton_OnClick();
	end
end

function GB_beyondRaidUnitOnClick(mousebutton)
	local keys = "";

	if (IsShiftKeyDown()) then
		keys = "s";
	end
	if (IsAltKeyDown()) then
		keys = keys.."a";
	end
	if (IsControlKeyDown()) then
		keys = keys.."c";
	end
	if (mousebutton == "LeftButton") then
		keys = keys.."l";
	elseif (mousebutton == "RightButton") then
		keys = keys.."r";
	elseif (mousebutton == "MiddleButton") then
		keys = keys.."m";
	elseif (mousebutton == "Button4") then
		keys="4";
	elseif (mousebutton == "Button5") then
		keys="5";
	end

	local unit = this:GetParent().unitID;

	local bar = "raid";

	if (keys == GB_Settings[GB_INDEX][bar].oldLeftClick or keys == GB_Settings[GB_INDEX][bar].oldRightClick) then
		GB_Old_beyondRaidUnitOnClick(mousebutton)
		return;
	end

	local buttonNum = GB_Settings[GB_INDEX][bar].clickCast[keys];
	if (buttonNum) then
		local unitBar = GB_Get_UnitBar(unit);
		GB_ActionButton_OnClick(unitBar, buttonNum, 1);
	else
		GB_Old_beyondRaidUnitOnClick(mousebutton);
	end
end

function GB_MarsRaidFrame_OnClick()
	local mousebutton = arg1;
		local keys = "";

	if (IsShiftKeyDown()) then
		keys = "s";
	end
	if (IsAltKeyDown()) then
		keys = keys.."a";
	end
	if (IsControlKeyDown()) then
		keys = keys.."c";
	end
	if (mousebutton == "LeftButton") then
		keys = keys.."l";
	elseif (mousebutton == "RightButton") then
		keys = keys.."r";
	elseif (mousebutton == "MiddleButton") then
		keys = keys.."m";
	elseif (mousebutton == "Button4") then
		keys="4";
	elseif (mousebutton == "Button5") then
		keys="5";
	end

	local unit = this.unit;

	local bar = "raid";

	if (keys == GB_Settings[GB_INDEX][bar].oldLeftClick or keys == GB_Settings[GB_INDEX][bar].oldRightClick) then
		arg1 = mousebutton;
		GB_Old_MarsRaidFrame_OnClick();
		return;
	end

	local buttonNum = GB_Settings[GB_INDEX][bar].clickCast[keys];
	if (buttonNum) then
		local unitBar = GB_Get_UnitBar(unit);
		GB_ActionButton_OnClick(unitBar, buttonNum, 1);
	else
		arg1 = mousebutton;
		GB_Old_MarsRaidFrame_OnClick();
	end
end

function GB_MarsRaidFrame_OnEnter()
	GB_Old_MarsRaidFrame_OnEnter();
	local unitBar = getglobal(GB_Get_UnitBar(this.unit));
	if (unitBar and GB_Settings[GB_INDEX][unitBar.index].mouseover) then
		unitBar.timer = nil;
		unitBar:Show();
	end
end

function GB_MarsRaidFrame_OnLeave()
	GB_Old_MarsRaidFrame_OnLeave();
	local unitBar = getglobal(GB_Get_UnitBar(this.unit));
	if (unitBar and GB_Settings[GB_INDEX][unitBar.index].mouseover) then
		unitBar.timer = GB_MOUSEOUT_TIME;
	end
end