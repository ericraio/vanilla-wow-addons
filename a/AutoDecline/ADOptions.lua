local ADOptionsFrameCheckButtons = {}
local allChars = nil

ADOptionsFrameCheckButtons[AD_CHECK_GUILD]   = { index = 1, tooltipText = AD_TIP_GUILD, ADVar = "guildToggle" }
ADOptionsFrameCheckButtons[AD_CHECK_PARTY]   = { index = 2, tooltipText = AD_TIP_PARTY, ADVar = "partyToggle" }
ADOptionsFrameCheckButtons[AD_CHECK_DUEL]    = { index = 3, tooltipText = AD_TIP_DUEL, ADVar = "duelToggle" }
ADOptionsFrameCheckButtons[AD_CHECK_CHARTER] = { index = 4, tooltipText = AD_TIP_CHARTER, ADVar = "charterToggle" }

ADOptionsFrameCheckButtons[AD_CHECK_ALLOWPARTYFRIEND]  = { index = 5, tooltipText = AD_TIP_ALLOWPARTYFRIEND, ADVar = "partyFriends" }
ADOptionsFrameCheckButtons[AD_CHECK_ALLOWPARTYGUILD]   = { index = 6, tooltipText = AD_TIP_ALLOWPARTYGUILD, ADVar = "partyGuild" }
ADOptionsFrameCheckButtons[AD_CHECK_ALLOWPARTYWHISPER] = { index = 7, tooltipText = AD_TIP_ALLOWPARTYWHISPER, ADVar = "partyWhisper" }

ADOptionsFrameCheckButtons[AD_CHECK_ALLCHARS]   = { index = 8, tooltipText = AD_TIP_ALLCHARS, ADVar = "allChars" }
ADOptionsFrameCheckButtons[AD_CHECK_SHOWALERTS] = { index = 9, tooltipText = AD_TIP_SHOWALERT, ADVar = "showAlert" }


--ADOptionsFrameCheckButtons["Guild Invites"] = { index = 1, tooltipText = "Check to automatically decline all guild invites", ADVar = "guildToggle" }
--ADOptionsFrameCheckButtons["Party Invites"] = { index = 2, tooltipText = "Check to automatically decline all party invites", ADVar = "partyToggle" }
--ADOptionsFrameCheckButtons["Duel Requests"] = { index = 3, tooltipText = "Check to automatically decline all duel requests", ADVar = "duelToggle" }
--ADOptionsFrameCheckButtons["Charter Requests"] = { index = 4, tooltipText = "Check to automatically close all guild charter petitions", ADVar = "charterToggle" }

--ADOptionsFrameCheckButtons["Allow Party Invites From Friends"] = { index = 5, tooltipText = "Check to always allow invites from friends on the friends list.", ADVar = "partyFriends" }
--ADOptionsFrameCheckButtons["Allow Party Invites From Last Whisper"] = { index = 6, tooltipText = "Check to always allow invites from the last player to send you a whisper/tell.", ADVar = "partyWhisper" }

--ADOptionsFrameCheckButtons["Show Alerts"] = { index = 7, tooltipText = "Check to show an alert when something is automatically declined", ADVar = "showAlert" }

-- *:***************************************************************
function ADOptionsFrame_OnLoad()
-- nut 'n honey
end

-- *:***************************************************************
function ADOptionsFrame_OnShow()
	local button, string, checked;

	for key, value in ADOptionsFrameCheckButtons do
		button = getglobal("ADOptionsFrame_CheckButton"..value.index);
		string = getglobal("ADOptionsFrame_CheckButton"..value.index.."Text");
		checked = nil;
		button.disabled = nil;

  	if ( AutoDecline_GetValue(value.ADVar) ) then
				checked = 1;
			else
				checked = nil;
		end

		OptionsFrame_EnableCheckBox(button);
		button:SetChecked(checked);
		string:SetText(key);
		button.tooltipText = value.tooltipText;
	end
end

-- *:***************************************************************
function ADOptionsFrame_SaveOptions()
	local button,frame,text
	local allChars = nil

	for index,value in ADOptionsFrameCheckButtons do
		button = getglobal("ADOptionsFrame_CheckButton"..value.index)
		if value.ADVar == "allChars" then
		  allChars = button:GetChecked()
		else
		  if ( button:GetChecked() ) then
  			AutoDecline_SetValue(value.ADVar,true)
		  else
  			AutoDecline_SetValue(value.ADVar,false)
		  end
		end
	end

  if allChars then
     AutoDecline_SetAllChars()
  else
     AutoDecline_SetLocalChars()
  end
end

-- *:***************************************************************
function ADOptionsFrame_OnClick()
-- Future Code here if necessary
end

-- *:***************************************************************
function ADOptionsFrame_GetDefaults()
	local button, string, checked;
	for key, value in ADOptionsFrameCheckButtons do
		button = getglobal("ADOptionsFrame_CheckButton"..value.index);
		string = getglobal("ADOptionsFrame_CheckButton"..value.index.."Text");
		checked = nil;
		button.disabled = nil;
		if value.ADVar then
		if value.ADVar == "guildToggle" then
		   checked = 1
		elseif value.ADVar == "partyToggle" then
		   checked = 1
		elseif value.ADVar == "duelToggle" then
		   checked = 1
		elseif value.ADVar == "charterToggle" then
       checked = 1
    elseif value.ADVar == "showAlert" then
       checked = 1
    elseif value.ADVar == "partyFriends" then
       checked = 1
    elseif value.ADVar == "partyGuild" then
       checked = 1
    elseif value.ADVar == "partyWhisper" then
       checked = nil
    else
       checked = nil
    end
		button:SetChecked(checked);
		end
	end
end

-- *:***************************************************************
function AD_Display(msg)
  if DEFAULT_CHAT_FRAME then
    DEFAULT_CHAT_FRAME:AddMessage("ADOptions: " ..  msg)
  end
end
