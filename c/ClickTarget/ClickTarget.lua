local Original_ChatFrame_SendTell;
local CTrg_Function_Hooked = nil;
local CTrg_Status_On = true;

function ClickTarget_HookFunction()
--[[	Original_ChatFrame_SendTell = ChatFrame_SendTell;
	ChatFrame_SendTell = ClickTarget_ChatFrame_SendTell; ]]
	oldSetItemRef = SetItemRef;
	SetItemRef = ClickTarget_SetItemRef;
	CTrg_Function_Hooked = true;
end

function ClickTarget_UnhookFunction()
	if (ChatFrame_SendTell==ClickTarget_ChatFrame_SendTell) then
		ChatFrame_SendTell = Original_ChatFrame_SendTell;
		CTrg_Function_Hooked = nil;
	end;
end

function ClickTarget_OnLoad()
	ClickTarget_HookFunction();
	if (CTrg_invite==nil) then
		local CTrg_invite = true;
	end;

	SlashCmdList["CLICKTARGETSLASH"] = ClickTarget_Slash;
	SLASH_CLICKTARGETSLASH1 = "/clicktarget";
	SLASH_CLICKTARGETSLASH2 = "/ctrg";
end

function ClickTarget_Slash(msg)
	msg = string.lower(msg);
	if (msg == "invite") then
		if (CTrg_invite) then
			CTrg_invite = false;
			DEFAULT_CHAT_FRAME:AddMessage("ClickTarget alt-inviting disabled");
		elseif (not CTrg_invite) then
			CTrg_invite = true;
			DEFAULT_CHAT_FRAME:AddMessage("ClickTarget alt-inviting enabled");
		end;
	else
		DEFAULT_CHAT_FRAME:AddMessage("/clicktaget invite - toggle alt-clicking for invite");
		DEFAULT_CHAT_FRAME:AddMessage("/ctrg can be used instead of /clicktarget");
	end;
end

function ClickTarget_OnEvent(event)
	if (event=="UNIT_FOCUS") then
		ClickTarget_Focus();
	elseif (event=="VARIABLES_LOADED") then
		ClickTarget_OnLoad();
	end;
end

function ClickTarget_Focus()
	if (IsAltKeyDown() and UnitIsPlayer("target") and CTrg_invite) then
		InviteByName(UnitName("target"));
	end;
end

function ClickTarget_SetItemRef(link)
	local frameName = this:GetName();
	if (strsub(strlower(link), 1, 6) == "player") then
		name = strsub(link, 8);
		if (name and (strlen(name) > 0)) then
			local _,_,realname = string.find(name,'([^%s]+)$');
			if (IsControlKeyDown() and arg3 == "RightButton") then
				if (TargetLogHistoryFrame) then
					TargetLog_AddGrudge(realname, "false");
				end
			elseif (IsControlKeyDown()) then
				TargetByName(realname);
			elseif (IsAltKeyDown() and arg3 == "RightButton") then
				AddFriend(realname);
			elseif (IsAltKeyDown() and CTrg_invite) then
				InviteByName(realname);
			elseif (IsShiftKeyDown()) then
				SendWho("n-"..realname);
			elseif (arg3 == "RightButton" and ChatFrameEditBox:IsVisible()) then
				ChatFrameEditBox:Insert(realname .. " ");
			else
				DEFAULT_CHAT_FRAME.editBox.chatType = "WHISPER";
				DEFAULT_CHAT_FRAME.editBox.tellTarget = realname;
				ChatEdit_UpdateHeader(DEFAULT_CHAT_FRAME.editBox);
				if (not DEFAULT_CHAT_FRAME.editBox:IsVisible()) then
					ChatFrame_OpenChat("", DEFAULT_CHAT_FRAME);
				end
			end
		end
		return;
	end
	oldSetItemRef(link);
end
