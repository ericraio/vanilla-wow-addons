AUTODING_CONFIG_TITLE = "AutoDing Options";
AUTODING_EDIT_TITLE = "AutoDing Message:";
AUTODING_EDIT_HELP = "Type the message you want to export on dinging.\nUse \"$L\" where you want your level to appear.";

function AutoDingConfig_OnLoad()
	UIPanelWindows["AutoDingConfigFrame"] = {area = "center", pushable = 0};
end

function AutoDingConfig_SetValues()
	cbxADEnable:SetChecked(UniAutoDingSaved[AutoDing_Player].AutoDing == 1);
	cbxADPartyDing:SetChecked(UniAutoDingSaved[AutoDing_Player].PartyDing == 1);
	cbxADScreenshot:SetChecked(UniAutoDingSaved[AutoDing_Player].Screenie == 1);
	butADChannel:SetText(UniAutoDingSaved[AutoDing_Player].Channel);
	AutoDing_EditBox:SetText(UniAutoDingSaved[AutoDing_Player].DingString);
	txtADEditHeader:SetText(AUTODING_EDIT_TITLE);
	txtADEditTips:SetText(AUTODING_EDIT_HELP);
end

function AutoDingConfig_OnShow()
	txtADConfigTitle:SetText(AUTODING_CONFIG_TITLE);
	txtADConfigTitle:SetTextColor(0.5, 0.5, 0.5);
	txtADConfigTitle:Show();

	UniAutoDing_ChatPrint(txtADConfigTitle:GetText());

	AutoDingConfig_SetValues();
end

function AutoDingConfig_OnHide()
	if (MYADDONS_ACTIVE_OPTIONSFRAME == this) then
		ShowUIPanel(myAddOnsFrame);
	end
end

function AutoDingConfig_OnMouseDown(arg1)
	if (arg1 == "LeftButton") then
		AutoDingConfigFrame:StartMoving();
	end
end

function AutoDingConfig_OnMouseUp(arg1)
	if (arg1 == "LeftButton") then
		AutoDingConfigFrame:StopMovingOrSizing();
	end
end

function AutoDingConfig_btnUTDone_OnClick()
	HideUIPanel(AutoDingConfigFrame);
end

function AutoDing_UpdateString()
	UniAutoDingSaved[AutoDing_Player].DingString = this:GetText();
end