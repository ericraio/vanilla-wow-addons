WIM_Options_CurrentSwatch = nil;
WIM_Options_AlreadyShown = false;

WIM_Alias_Selected = "";
WIM_Filter_Selected = "";
WIM_History_Selected = "";

function WIM_Options_OnShow()
	local tRGB;
	
	WIM_OptionsEnableWIM:SetChecked(WIM_Data.enableWIM);
	
	--[ Initialize Minimap Icon Frame 
		WIM_OptionsMiniMapIconPosition:SetValue(WIM_Data.iconPosition);
		WIM_OptionsMiniMapIconPositionTitle:SetText("Icon Position");
		WIM_OptionsMiniMapEnabled:SetChecked(WIM_Data.showMiniMap);
		WIM_OptionsMiniMapFreeMoving:SetChecked(WIM_Data.miniFreeMoving.enabled);
	
	--[ Initialize Display Settings Frame 
		--[Swatches
		WIM_Options_CurrentSwatch = "WIM_OptionsDisplayIncomingWisp";
		tRGB = WIM_Data.displayColors.wispIn;
		WIM_Options_UpdateSwatchColor(tRGB.r, tRGB.g, tRGB.b);
		WIM_Options_CurrentSwatch = "WIM_OptionsDisplayOutgoingWisp";
		tRGB = WIM_Data.displayColors.wispOut;
		WIM_Options_UpdateSwatchColor(tRGB.r, tRGB.g, tRGB.b);
		WIM_Options_CurrentSwatch = "WIM_OptionsDisplaySystemMessage";
		tRGB = WIM_Data.displayColors.sysMsg;
		WIM_Options_UpdateSwatchColor(tRGB.r, tRGB.g, tRGB.b);
		WIM_Options_CurrentSwatch = "WIM_OptionsDisplayErrorMessage";
		tRGB = WIM_Data.displayColors.errorMsg;
		WIM_Options_UpdateSwatchColor(tRGB.r, tRGB.g, tRGB.b);
		WIM_Options_CurrentSwatch = "WIM_OptionsDisplayWebAddress";
		tRGB = WIM_Data.displayColors.webAddress;
		WIM_Options_UpdateSwatchColor(tRGB.r, tRGB.g, tRGB.b);
		WIM_OptionsDisplayShowTimeStamps:SetChecked(WIM_Data.showTimeStamps);
		WIM_OptionsDisplayShowShortcutBar:SetChecked(WIM_Data.showShortcutBar);
		--[Character Info
		WIM_OptionsDisplayShowCharacterInfo:SetChecked(WIM_Data.characterInfo.show);
		WIM_OptionsDisplayShowCharacterInfoClassIcon:SetChecked(WIM_Data.characterInfo.classIcon);
		WIM_OptionsDisplayShowCharacterInfoClassColor:SetChecked(WIM_Data.characterInfo.classColor);
		WIM_OptionsDisplayShowCharacterInfoDetails:SetChecked(WIM_Data.characterInfo.details);
		
		--[Sliders
		WIM_OptionsDisplayFontSize:SetValue(WIM_Data.fontSize);
		WIM_OptionsDisplayFontSizeTitle:SetText("Font Size");
		WIM_OptionsDisplayWindowSize:SetValue(WIM_Data.windowSize * 100);
		WIM_OptionsDisplayWindowSizeTitle:SetText("Window Size (Percent)");
		WIM_OptionsDisplayWindowAlpha:SetValue(WIM_Data.windowAlpha * 100);
		WIM_OptionsDisplayWindowAlphaTitle:SetText("Transparency (Percent)");
	--[ Initialize General Settings
		WIM_OptionsTabbedFrameGeneralKeepFocus:SetChecked(WIM_Data.keepFocus);
		WIM_OptionsTabbedFrameGeneralAutoFocus:SetChecked(WIM_Data.autoFocus);
		WIM_OptionsTabbedFrameGeneralShowToolTips:SetChecked(WIM_Data.showToolTips);
		WIM_OptionsTabbedFrameGeneralSupress:SetChecked(WIM_Data.supressWisps);
		WIM_OptionsTabbedFrameGeneralPopNew:SetChecked(WIM_Data.popNew);
		WIM_OptionsTabbedFrameGeneralPopUpdate:SetChecked(WIM_Data.popUpdate);
		WIM_Options_PopNewClicked();
		WIM_OptionsTabbedFrameGeneralPlaySoundWisp:SetChecked(WIM_Data.playSoundWisp);
		WIM_OptionsTabbedFrameGeneralSortOrderAlpha:SetChecked(WIM_Data.sortAlpha);
		WIM_OptionsTabbedFrameGeneralPopCombat:SetChecked(WIM_Data.popCombat);
		WIM_OptionsTabbedFrameGeneralPopOnSend:SetChecked(WIM_Data.popOnSend);
		
	--[ Window Settings
		WIM_OptionsTabbedFrameWindowWindowWidthTitle:SetText("Window Width");
		WIM_OptionsTabbedFrameWindowWindowWidth:SetValue(WIM_Data.winSize.width);
		WIM_OptionsTabbedFrameWindowWindowHeightTitle:SetText("Window Height");
		WIM_OptionsTabbedFrameWindowWindowHeight:SetValue(WIM_Data.winSize.height);
		WIM_OptionsTabbedFrameWindowWindowCascade:SetChecked(WIM_Data.winCascade.enabled);
		
	--[ Filter Settings
		WIM_OptionsTabbedFrameFilterAliasEnabled:SetChecked(WIM_Data.enableAlias);
		WIM_OptionsTabbedFrameFilterFilteringEnabled:SetChecked(WIM_Data.enableFilter);
		WIM_OptionsTabbedFrameFilterAliasShowAsComment:SetChecked(WIM_Data.aliasAsComment);
		
	--[ History
		WIM_OptionsTabbedFrameHistoryEnabled:SetChecked(WIM_Data.enableHistory);
		WIM_OptionsTabbedFrameHistoryRecordEveryone:SetChecked(WIM_Data.historySettings.recordEveryone);
		WIM_OptionsTabbedFrameHistoryRecordFriends:SetChecked(WIM_Data.historySettings.recordFriends);
		WIM_OptionsTabbedFrameHistoryRecordGuild:SetChecked(WIM_Data.historySettings.recordGuild);
		WIM_Options_HistoryRecordEveryoneClicked();
		WIM_Options_CurrentSwatch = "WIM_OptionsTabbedFrameHistoryColorIn";
		tRGB = WIM_Data.historySettings.colorIn;
		WIM_Options_UpdateSwatchColor(tRGB.r, tRGB.g, tRGB.b);
		WIM_Options_CurrentSwatch = "WIM_OptionsTabbedFrameHistoryColorOut";
		tRGB = WIM_Data.historySettings.colorOut;
		WIM_Options_UpdateSwatchColor(tRGB.r, tRGB.g, tRGB.b);
		WIM_OptionsTabbedFrameHistoryShowInMessage:SetChecked(WIM_Data.historySettings.popWin.enabled);
		WIM_OptionsTabbedFrameHistorySetMaxToStore:SetChecked(WIM_Data.historySettings.maxMsg.enabled);
		WIM_OptionsTabbedFrameHistorySetAutoDelete:SetChecked(WIM_Data.historySettings.autoDelete.enabled);
	--[ Other
		
		WIM_Options_ShowShortcutBarClicked();
		WIM_HistoryScrollBar_Update();
		
	if(not WIM_Options_AlreadyShown) then
		WIM_Options_General_Click();
		WIM_Options_AlreadyShown = true;
	end
end


function WIM_Options_ShowMiniMapClick()
	if(WIM_OptionsMiniMapEnabled:GetChecked()) then
		WIM_Data.showMiniMap = true;
		if(WIM_Data.miniFreeMoving.enabled) then
			WIM_IconFrame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT",WIM_Data.miniFreeMoving.left,WIM_Data.miniFreeMoving.top);
			WIM_IconFrame:Show();
			return;
		end
	else
		WIM_Data.showMiniMap = false;
	end
	WIM_Icon_UpdatePosition();
end

function WIM_Options_OpenColorPicker(button)
	CloseMenus();
	WIM_Options_CurrentSwatch = button:GetName();
	ColorPickerFrame.hasOpacity = false;
	ColorPickerFrame.func = WIM_Options_ColorPickerChanged;
	ColorPickerFrame:SetColorRGB(button.r, button.g, button.b);
	ColorPickerFrame.previousValues = {button.r, button.g, button.b};
	ColorPickerFrame.cancelFunc = WIM_Options_ColorPickerCanceled;
	ColorPickerFrame:SetFrameStrata("DIALOG");
	ColorPickerFrame:Show();
end

function WIM_Options_ColorPickerChanged()
	local r,g,b = ColorPickerFrame:GetColorRGB();
	WIM_Options_UpdateSwatchColor(r,g,b);
end

function WIM_Options_ColorPickerCanceled(prevvals)
	local r,g,b = unpack(prevvals)
	WIM_Options_UpdateSwatchColor(r,g,b);
end


function WIM_Options_UpdateSwatchColor(r,g,b)
	if(WIM_Options_CurrentSwatch == "WIM_OptionsDisplayIncomingWisp") then
		WIM_Data.displayColors.wispIn.r = r;
		WIM_Data.displayColors.wispIn.g = g;
		WIM_Data.displayColors.wispIn.b = b;
	elseif(WIM_Options_CurrentSwatch == "WIM_OptionsDisplayOutgoingWisp") then
		WIM_Data.displayColors.wispOut.r = r;
		WIM_Data.displayColors.wispOut.g = g;
		WIM_Data.displayColors.wispOut.b = b;
	elseif(WIM_Options_CurrentSwatch == "WIM_OptionsDisplaySystemMessage") then
		WIM_Data.displayColors.sysMsg.r = r;
		WIM_Data.displayColors.sysMsg.g = g;
		WIM_Data.displayColors.sysMsg.b = b;
	elseif(WIM_Options_CurrentSwatch == "WIM_OptionsDisplayErrorMessage") then
		WIM_Data.displayColors.errorMsg.r = r;
		WIM_Data.displayColors.errorMsg.g = g;
		WIM_Data.displayColors.errorMsg.b = b;
	elseif(WIM_Options_CurrentSwatch == "WIM_OptionsDisplayWebAddress") then
		WIM_Data.displayColors.webAddress.r = r;
		WIM_Data.displayColors.webAddress.g = g;
		WIM_Data.displayColors.webAddress.b = b;
	elseif(WIM_Options_CurrentSwatch == "WIM_OptionsTabbedFrameHistoryColorIn") then
		WIM_Data.historySettings.colorIn.r = r;
		WIM_Data.historySettings.colorIn.g = g;
		WIM_Data.historySettings.colorIn.b = b;
	elseif(WIM_Options_CurrentSwatch == "WIM_OptionsTabbedFrameHistoryColorOut") then
		WIM_Data.historySettings.colorOut.r = r;
		WIM_Data.historySettings.colorOut.g = g;
		WIM_Data.historySettings.colorOut.b = b;
	end

	getglobal(WIM_Options_CurrentSwatch).r = r;
	getglobal(WIM_Options_CurrentSwatch).g = g;
	getglobal(WIM_Options_CurrentSwatch).b = b;
	getglobal(WIM_Options_CurrentSwatch.."_ColorSwatchNormalTexture"):SetVertexColor(r,g,b);
end

function WIM_Options_General_Click()
	PanelTemplates_SelectTab(WIM_OptionsOptionTab1);
	PanelTemplates_DeselectTab(WIM_OptionsOptionTab2);
	PanelTemplates_DeselectTab(WIM_OptionsOptionTab3);
	PanelTemplates_DeselectTab(WIM_OptionsOptionTab4);
	WIM_OptionsTabbedFrameGeneral:Show();
	WIM_OptionsTabbedFrameWindow:Hide();
	WIM_OptionsTabbedFrameFilter:Hide();
	WIM_OptionsTabbedFrameHistory:Hide();
end

function WIM_Options_Windows_Click()
	PanelTemplates_SelectTab(WIM_OptionsOptionTab2);
	PanelTemplates_DeselectTab(WIM_OptionsOptionTab1);
	PanelTemplates_DeselectTab(WIM_OptionsOptionTab3);
	PanelTemplates_DeselectTab(WIM_OptionsOptionTab4);
	WIM_OptionsTabbedFrameGeneral:Hide();
	WIM_OptionsTabbedFrameFilter:Hide();
	WIM_OptionsTabbedFrameHistory:Hide();
	WIM_OptionsTabbedFrameWindow:Show();
end

function WIM_Options_Filter_Click()
	PanelTemplates_SelectTab(WIM_OptionsOptionTab3);
	PanelTemplates_DeselectTab(WIM_OptionsOptionTab1);
	PanelTemplates_DeselectTab(WIM_OptionsOptionTab2);
	PanelTemplates_DeselectTab(WIM_OptionsOptionTab4);
	WIM_OptionsTabbedFrameGeneral:Hide();
	WIM_OptionsTabbedFrameWindow:Hide();
	WIM_OptionsTabbedFrameHistory:Hide();
	WIM_OptionsTabbedFrameFilter:Show();
end

function WIM_Options_History_Click()
	PanelTemplates_SelectTab(WIM_OptionsOptionTab4);
	PanelTemplates_DeselectTab(WIM_OptionsOptionTab1);
	PanelTemplates_DeselectTab(WIM_OptionsOptionTab2);
	PanelTemplates_DeselectTab(WIM_OptionsOptionTab3);
	WIM_OptionsTabbedFrameGeneral:Hide();
	WIM_OptionsTabbedFrameWindow:Hide();
	WIM_OptionsTabbedFrameFilter:Hide();
	WIM_OptionsTabbedFrameHistory:Show();
end

function WIM_Options_SupressWispsClicked()
	if(WIM_OptionsTabbedFrameGeneralSupress:GetChecked()) then
		WIM_Data.supressWisps = true;
	else
		WIM_Data.supressWisps = false;
	end
end

function WIM_Options_KeepFocusClicked()
	if(WIM_OptionsTabbedFrameGeneralKeepFocus:GetChecked()) then
		WIM_Data.keepFocus = true;
	else
		WIM_Data.keepFocus = false;
	end
end

function WIM_Options_AutoFocusClicked()
	if(WIM_OptionsTabbedFrameGeneralAutoFocus:GetChecked()) then
		WIM_Data.autoFocus = true;
	else
		WIM_Data.autoFocus = false;
	end
end

function WIM_Options_PopNewClicked()
	if(WIM_OptionsTabbedFrameGeneralPopNew:GetChecked()) then
		WIM_Data.popNew = true;
		WIM_OptionsTabbedFrameGeneralPopUpdate:Enable();
		WIM_OptionsTabbedFrameGeneralPopCombat:Enable();
	else
		WIM_Data.popNew = false;
		WIM_OptionsTabbedFrameGeneralPopUpdate:Disable();
		WIM_OptionsTabbedFrameGeneralPopCombat:Disable();
	end
end

function WIM_Options_PopUpdateClicked()
	if(WIM_OptionsTabbedFrameGeneralPopUpdate:GetChecked()) then
		WIM_Data.popUpdate = true;
	else
		WIM_Data.popUpdate = false;
	end
end

function WIM_Options_PopOnSendClicked()
	if(WIM_OptionsTabbedFrameGeneralPopOnSend:GetChecked()) then
		WIM_Data.popOnSend = true;
	else
		WIM_Data.popOnSend = false;
	end
end

function WIM_Options_PlaySoundWispClicked()
	if(WIM_OptionsTabbedFrameGeneralPlaySoundWisp:GetChecked()) then
		WIM_Data.playSoundWisp = true;
	else
		WIM_Data.playSoundWisp = false;
	end
end

function WIM_Options_ShowToolTipsClicked()
	if(WIM_OptionsTabbedFrameGeneralShowToolTips:GetChecked()) then
		WIM_Data.showToolTips = true;
	else
		WIM_Data.showToolTips = false;
	end
end

function WIM_Options_SortOrderAlphaClicked()
	if(WIM_OptionsTabbedFrameGeneralSortOrderAlpha:GetChecked()) then
		WIM_Data.sortAlpha = true;
	else
		WIM_Data.sortAlpha = false;
	end
	WIM_Icon_DropDown_Update();
end

function WIM_Options_FreeMoving_Clicked()
	if(WIM_OptionsMiniMapFreeMoving:GetChecked()) then
		WIM_Data.miniFreeMoving.enabled = true;
		WIM_Data.miniFreeMoving.left = WIM_IconFrame:GetLeft();
		WIM_Data.miniFreeMoving.top = WIM_IconFrame:GetTop();
		WIM_IconFrame:ClearAllPoints();
		WIM_IconFrame:SetFrameStrata("HIGH");
		WIM_IconFrame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", WIM_Data.miniFreeMoving.left, WIM_Data.miniFreeMoving.top);
	else
		WIM_IconFrame:SetFrameStrata("LOW");
		WIM_Data.miniFreeMoving.enabled = false;
		WIM_Icon_UpdatePosition();
	end
end

function WIM_Options_PopCombatClicked()
	if(WIM_OptionsTabbedFrameGeneralPopCombat:GetChecked()) then
		WIM_Data.popCombat = true;
	else
		WIM_Data.popCombat = false;
	end
end

function WIM_Options_CharacerInfoClicked()
	if(WIM_OptionsDisplayShowCharacterInfo:GetChecked()) then
		WIM_Data.characterInfo.show = true;
		WIM_OptionsDisplayShowCharacterInfoClassIcon:Enable();
		WIM_OptionsDisplayShowCharacterInfoClassColor:Enable();
	else
		WIM_Data.characterInfo.show = false;
		WIM_OptionsDisplayShowCharacterInfoClassIcon:Disable();
		WIM_OptionsDisplayShowCharacterInfoClassColor:Disable();
	end
end

function WIM_Options_CharacerInfoClassIconClicked()
	if(WIM_OptionsDisplayShowCharacterInfoClassIcon:GetChecked()) then
		WIM_Data.characterInfo.classIcon = true;
	else
		WIM_Data.characterInfo.classIcon = false;
	end
end

function WIM_Options_CharacerInfoClassColorClicked()
	if(WIM_OptionsDisplayShowCharacterInfoClassColor:GetChecked()) then
		WIM_Data.characterInfo.classColor = true;
	else
		WIM_Data.characterInfo.classColor = false;
	end
end

function WIM_Options_CharacerInfoDetailsClicked()
	if(WIM_OptionsDisplayShowCharacterInfoDetails:GetChecked()) then
		WIM_Data.characterInfo.details = true;
	else
		WIM_Data.characterInfo.details = false;
	end
end

function WIM_Options_ShowTimeStampsClicked()
	if(WIM_OptionsDisplayShowTimeStamps:GetChecked()) then
		WIM_Data.showTimeStamps = true;
	else
		WIM_Data.showTimeStamps = false;
	end
end

function WIM_Options_EnableWIMClicked()
	if(WIM_OptionsEnableWIM:GetChecked()) then
		WIM_Data.enableWIM = true;
	else
		WIM_Data.enableWIM = false;
	end
	WIM_SetWIM_Enabled(WIM_Data.enableWIM);
end

function WIM_Options_ShowShortcutBarClicked()
	if(WIM_OptionsDisplayShowShortcutBar:GetChecked()) then
		WIM_Data.showShortcutBar = true;
		WIM_OptionsTabbedFrameWindowWindowHeightTitle:SetText("Window Height |cffffffff(Limited by shortcut bar)|r");
	else
		WIM_Data.showShortcutBar = false;
		WIM_OptionsTabbedFrameWindowWindowHeightTitle:SetText("Window Height");
	end
	WIM_SetAllWindowProps();
end

function WIM_AliasScrollBar_Update()
	local line;
	local lineplusoffset;
	local AliasNames = {};
	
	for key in WIM_Alias do
		table.insert(AliasNames, key);
	end
	
	FauxScrollFrame_Update(WIM_OptionsTabbedFrameFilterAliasPanelScrollBar,table.getn(AliasNames),5,16);
	for line=1,5 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(WIM_OptionsTabbedFrameFilterAliasPanelScrollBar);
		if (lineplusoffset <= table.getn(AliasNames)) then
			getglobal("WIM_OptionsTabbedFrameFilterAliasPanelButton"..line.."Name"):SetText(AliasNames[lineplusoffset]);
			getglobal("WIM_OptionsTabbedFrameFilterAliasPanelButton"..line.."Alias"):SetText(WIM_Alias[AliasNames[lineplusoffset]]);
			getglobal("WIM_OptionsTabbedFrameFilterAliasPanelButton"..line).theAliasName = AliasNames[lineplusoffset];
			if ( WIM_Alias_Selected == AliasNames[lineplusoffset] ) then
				getglobal("WIM_OptionsTabbedFrameFilterAliasPanelButton"..line):LockHighlight();
			else
				getglobal("WIM_OptionsTabbedFrameFilterAliasPanelButton"..line):UnlockHighlight();
			end
			getglobal("WIM_OptionsTabbedFrameFilterAliasPanelButton"..line):Show();
		else
			getglobal("WIM_OptionsTabbedFrameFilterAliasPanelButton"..line):Hide();
		end
	end

end

function WIM_Options_AliasWindow_Click()
	local name = WIM_Options_AliasWindow_Name:GetText();
	local alias = WIM_Options_AliasWindow_Alias:GetText();
	
	name = string.gsub(name, " ", "");
	name = string.gsub(name, "^%l", string.upper)
	alias = string.gsub(alias, " ", "");
	
	if(name == "") then
		WIM_Options_AliasWindow_Error:SetText("ERROR: Invalid name!");
		return;
	end
	if(alias == "") then
		WIM_Options_AliasWindow_Error:SetText("ERROR: Invalid alias!");
		return;
	end
	if(WIM_Options_AliasWindow.theMode == "add" and WIM_Alias[name] ~= nil) then
		WIM_Options_AliasWindow_Error:SetText("ERROR: Name is already used!");
		return;
	end
	
	WIM_Alias[name] = alias;
	
	if(WIM_Options_AliasWindow.theMode == "edit" and name ~= WIM_Options_AliasWindow.prevName)then
		WIM_Alias[WIM_Options_AliasWindow.prevName] = nil;
	end

	
	WIM_AliasScrollBar_Update();
	PlaySound("igMainMenuClose");
	WIM_Options_AliasWindow:Hide();
end


function WIM_Options_AliasEnabledClicked()
	if(WIM_OptionsTabbedFrameFilterAliasEnabled:GetChecked()) then
		WIM_Data.enableAlias = true;
	else
		WIM_Data.enableAlias = false;
	end
end

function WIM_Options_FilteringEnabledClicked()
	if(WIM_OptionsTabbedFrameFilterFilteringEnabled:GetChecked()) then
		WIM_Data.enableFilter = true;
	else
		WIM_Data.enableFilter = false;
	end
end

function WIM_FilteringScrollBar_Update()
	local line;
	local lineplusoffset;
	local FilteringNames = {};
	
	for key in WIM_Filters do
		table.insert(FilteringNames, key);
	end
	
	FauxScrollFrame_Update(WIM_OptionsTabbedFrameFilterFilteringPanelScrollBar,table.getn(FilteringNames),5,16);
	for line=1,5 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(WIM_OptionsTabbedFrameFilterFilteringPanelScrollBar);
		if lineplusoffset <= table.getn(FilteringNames) then
			getglobal("WIM_OptionsTabbedFrameFilterFilteringPanelButton"..line.."Name"):SetText(FilteringNames[lineplusoffset]);
			getglobal("WIM_OptionsTabbedFrameFilterFilteringPanelButton"..line.."Action"):SetText(WIM_Filters[FilteringNames[lineplusoffset]]);
			getglobal("WIM_OptionsTabbedFrameFilterFilteringPanelButton"..line).theFilterName = FilteringNames[lineplusoffset];
			if ( WIM_Filter_Selected == FilteringNames[lineplusoffset] ) then
				getglobal("WIM_OptionsTabbedFrameFilterFilteringPanelButton"..line):LockHighlight();
			else
				getglobal("WIM_OptionsTabbedFrameFilterFilteringPanelButton"..line):UnlockHighlight();
			end
			getglobal("WIM_OptionsTabbedFrameFilterFilteringPanelButton"..line):Show();
		else
			getglobal("WIM_OptionsTabbedFrameFilterFilteringPanelButton"..line):Hide();
		end
	end

end


function WIM_Options_FilteringIgnoreClicked()
	if(WIM_Options_FilterWindow_ActionIgnore:GetChecked()) then
		WIM_Options_FilterWindow.theAction = "Ignore";
		WIM_Options_FilterWindow_ActionBlock:SetChecked(false);
	else
		WIM_Options_FilterWindow_ActionBlock:SetChecked(true);
	end
end

function WIM_Options_FilteringBlockClicked()
	if(WIM_Options_FilterWindow_ActionBlock:GetChecked()) then
		WIM_Options_FilterWindow.theAction = "Block";
		WIM_Options_FilterWindow_ActionIgnore:SetChecked(false);
	else
		WIM_Options_FilterWindow_ActionIgnore:SetChecked(true);
	end
end

function WIM_Options_FilterWindow_Click()
	local name = WIM_Options_FilterWindow_Name:GetText();
	local action = WIM_Options_FilterWindow.theAction;
	
	local tname = string.gsub(name, " ", "");
	
	if(tname == "") then
		WIM_Options_FilterWindow_Error:SetText("ERROR: Invalid Keyword/Phrase!");
		return;
	end
	if(WIM_Options_FilterWindow.theMode == "add" and WIM_Filters[name] ~= nil) then
		WIM_Options_FilterWindow_Error:SetText("ERROR: Keyword/Phrase is already used!");
		return;
	end
	
	WIM_Filters[name] = action;
	
	if(WIM_Options_FilterWindow.theMode == "edit" and name ~= WIM_Options_FilterWindow.prevName)then
		WIM_Filters[WIM_Options_FilterWindow.prevName] = nil;
	end
	
	WIM_FilteringScrollBar_Update();
	PlaySound("igMainMenuClose");
	WIM_Options_FilterWindow:Hide();
end

function WIM_Options_AliasShowAsCommentClicked()
	if(WIM_OptionsTabbedFrameFilterAliasShowAsComment:GetChecked()) then
		WIM_Data.aliasAsComment = true;
	else
		WIM_Data.aliasAsComment = false;
	end
end

function WIM_Options_HistoryEnabledClicked()
	if(WIM_OptionsTabbedFrameHistoryEnabled:GetChecked()) then
		WIM_Data.enableHistory = true;
	else
		WIM_Data.enableHistory = false;
	end
end

function WIM_Options_HistoryRecordEveryoneClicked()
	if(WIM_OptionsTabbedFrameHistoryRecordEveryone:GetChecked()) then
		WIM_Data.historySettings.recordEveryone = true;
		WIM_OptionsTabbedFrameHistoryRecordFriends:Disable();
		WIM_OptionsTabbedFrameHistoryRecordGuild:Disable();
	else
		WIM_Data.historySettings.recordEveryone = false;
		WIM_OptionsTabbedFrameHistoryRecordFriends:Enable();
		WIM_OptionsTabbedFrameHistoryRecordGuild:Enable();
	end
end

function WIM_Options_HistoryRecordFriendsClicked()
	if(WIM_OptionsTabbedFrameHistoryRecordFriends:GetChecked()) then
		WIM_Data.historySettings.recordFriends = true;
	else
		WIM_Data.historySettings.recordFriends = false;
	end
end

function WIM_Options_HistoryRecordGuildClicked()
	if(WIM_OptionsTabbedFrameHistoryRecordGuild:GetChecked()) then
		WIM_Data.historySettings.recordGuild = true;
	else
		WIM_Data.historySettings.recordGuild = false;
	end
end

function WIM_Options_HistoryShowInMessageClicked()
	if(WIM_OptionsTabbedFrameHistoryShowInMessage:GetChecked()) then
		WIM_Data.historySettings.popWin.enabled = true;
	else
		WIM_Data.historySettings.popWin.enabled = false;
	end
end

function WIM_Options_HistorySetMaxToStoreClicked()
	if(WIM_OptionsTabbedFrameHistorySetMaxToStore:GetChecked()) then
		WIM_Data.historySettings.maxMsg.enabled = true;
	else
		WIM_Data.historySettings.maxMsg.enabled = false;
	end
end

function WIM_Options_HistorySetAutoDeleteClicked()
	if(WIM_OptionsTabbedFrameHistorySetAutoDelete:GetChecked()) then
		WIM_Data.historySettings.autoDelete.enabled = true;
	else
		WIM_Data.historySettings.autoDelete.enabled = false;
	end
end

function WIM_Options_HistoryMessageCount_OnShow()
	UIDropDownMenu_Initialize(this, WIM_Options_HistoryMessageCount_Initialize);
	UIDropDownMenu_SetSelectedValue(this, WIM_Data.historySettings.popWin.count);
	UIDropDownMenu_SetWidth(60, WIM_OptionsTabbedFrameHistoryMessageCount);
end

function WIM_Options_HistoryMessageCount_Initialize()
	local info = {};
	info = { };
	info.text = "1";--.."           "; --[spaces for quick width fix
	info.value = 1;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryMessageClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "5";
	info.value = 5;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryMessageClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "10";
	info.value = 10;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryMessageClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "25";
	info.value = 25;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryMessageClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "50";
	info.value = 50;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryMessageClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
end

function WIM_Options_HistoryMessageClick()
	WIM_Data.historySettings.popWin.count = this.value;
	UIDropDownMenu_SetSelectedValue(WIM_OptionsTabbedFrameHistoryMessageCount, WIM_Data.historySettings.popWin.count);
end

function WIM_Options_HistoryMaxCount_OnShow()
	UIDropDownMenu_Initialize(this, WIM_Options_HistoryMaxCount_Initialize);
	UIDropDownMenu_SetSelectedValue(this, WIM_Data.historySettings.maxMsg.count);
	UIDropDownMenu_SetWidth(60, WIM_OptionsTabbedFrameHistoryMaxCount);
end

function WIM_Options_HistoryMaxCount_Initialize()
	local info = {};
	info = { };
	info.text = "50";--.."           "; --[spaces for quick width fix
	info.value = 50;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryMaxClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "100";
	info.value = 100;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryMaxClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "200";
	info.value = 200;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryMaxClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "300";
	info.value = 300;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryMaxClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "400";
	info.value = 400;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryMaxClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "500";
	info.value = 500;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryMaxClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
end

function WIM_Options_HistoryMaxClick()
	WIM_Data.historySettings.maxMsg.count = this.value;
	UIDropDownMenu_SetSelectedValue(WIM_OptionsTabbedFrameHistoryMaxCount, WIM_Data.historySettings.maxMsg.count);
end

function WIM_Options_HistoryAutoDeleteTime_OnShow()
	UIDropDownMenu_Initialize(this, WIM_Options_HistoryAutoDeleteTime_Initialize);
	UIDropDownMenu_SetSelectedValue(this, WIM_Data.historySettings.autoDelete.days);
	UIDropDownMenu_SetWidth(75, WIM_OptionsTabbedFrameHistoryAutoDeleteTime);
end

function WIM_Options_HistoryAutoDeleteTime_Initialize()
	local info = {};
	info = { };
	info.text = "Day";--.."           "; --[spaces for quick width fix
	info.value = 1;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryAutoDeleteTimeClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "Week";
	info.value = 7;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryAutoDeleteTimeClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "Month";
	info.value = 30;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryAutoDeleteTimeClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
end

function WIM_Options_HistoryAutoDeleteTimeClick()
	WIM_Data.historySettings.autoDelete.days = this.value;
	UIDropDownMenu_SetSelectedValue(WIM_OptionsTabbedFrameHistoryAutoDeleteTime, WIM_Data.historySettings.autoDelete.days);
end

function WIM_HistoryScrollBar_Update()
	local line;
	local lineplusoffset;
	local HistoryNames = {};
	
	for key in WIM_History do
		table.insert(HistoryNames, key);
	end
	table.sort(HistoryNames);
	
	FauxScrollFrame_Update(WIM_OptionsTabbedFrameHistoryPanelScrollBar,table.getn(HistoryNames),5,16);
	for line=1,5 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(WIM_OptionsTabbedFrameHistoryPanelScrollBar);
		if lineplusoffset <= table.getn(HistoryNames) then
			getglobal("WIM_OptionsTabbedFrameHistoryPanelButton"..line.."Name"):SetText(HistoryNames[lineplusoffset]);
			getglobal("WIM_OptionsTabbedFrameHistoryPanelButton"..line.."MessageCount"):SetText(table.getn(WIM_History[HistoryNames[lineplusoffset]]));
			getglobal("WIM_OptionsTabbedFrameHistoryPanelButton"..line).theName = HistoryNames[lineplusoffset];
			if ( WIM_History_Selected == HistoryNames[lineplusoffset] ) then
				getglobal("WIM_OptionsTabbedFrameHistoryPanelButton"..line):LockHighlight();
			else
				getglobal("WIM_OptionsTabbedFrameHistoryPanelButton"..line):UnlockHighlight();
			end
			getglobal("WIM_OptionsTabbedFrameHistoryPanelButton"..line):Show();
		else
			getglobal("WIM_OptionsTabbedFrameHistoryPanelButton"..line):Hide();
		end
	end
end

function WIM_Options_WindowAnchorToggle_Click()
	if(WIM_WindowAnchor:IsVisible()) then
		WIM_WindowAnchor:Hide();
		GameTooltip:Hide();
	else
		WIM_WindowAnchor:SetPoint(
			"TOPLEFT",
			"UIParent",
			"BOTTOMLEFT",
			WIM_Data.winLoc.left, 
			WIM_Data.winLoc.top
		);
		WIM_WindowAnchor:Show();
		GameTooltip:SetOwner(WIM_WindowAnchor, "ANCHOR_RIGHT");
		GameTooltip:SetText("Drag to set default spawn\nposition for message windows.");
	end
end

function WIM_Options_WindowCascadeClicked()
	if(WIM_OptionsTabbedFrameWindowWindowCascade:GetChecked()) then
		WIM_Data.winCascade.enabled = true;
	else
		WIM_Data.winCascade.enabled = false;
	end
end

function WIM_Options_CascadeDirection_OnShow()
	UIDropDownMenu_Initialize(this, WIM_Options_CascadeDirection_Initialize);
	UIDropDownMenu_SetSelectedValue(this, WIM_Data.winCascade.direction);
	UIDropDownMenu_SetWidth(100, WIM_OptionsTabbedFrameWindowCascadeDirection);
end

function WIM_Options_CascadeDirection_Initialize()
	local info = {};
	info = { };
	info.text = "Up";
	info.value = "up";
	info.justifyH = "LEFT";
	info.func = WIM_Options_CascadeDirectionClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "Down";
	info.value = "down";
	info.justifyH = "LEFT";
	info.func = WIM_Options_CascadeDirectionClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "Left";
	info.value = "left";
	info.justifyH = "LEFT";
	info.func = WIM_Options_CascadeDirectionClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "Right";
	info.value = "right";
	info.justifyH = "LEFT";
	info.func = WIM_Options_CascadeDirectionClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "Up & Left";
	info.value = "upleft";
	info.justifyH = "LEFT";
	info.func = WIM_Options_CascadeDirectionClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "Up & Right";
	info.value = "upright";
	info.justifyH = "LEFT";
	info.func = WIM_Options_CascadeDirectionClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "Down & Left";
	info.value = "downleft";
	info.justifyH = "LEFT";
	info.func = WIM_Options_CascadeDirectionClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "Down & Right";
	info.value = "downright";
	info.justifyH = "LEFT";
	info.func = WIM_Options_CascadeDirectionClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
end

function WIM_Options_CascadeDirectionClick()
	WIM_Data.winCascade.direction = this.value;
	WIM_CascadeStep = 0;
	UIDropDownMenu_SetSelectedValue(WIM_OptionsTabbedFrameWindowCascadeDirection, WIM_Data.winCascade.direction);
end

function WIM_Help_Description_Click()
	PanelTemplates_SelectTab(WIM_HelpTab1);
	PanelTemplates_DeselectTab(WIM_HelpTab2);
	
	WIM_HelpScrollFrameScrollChildText:SetText(WIM_DESCRIPTION);
	WIM_HelpScrollFrameScrollBar:SetValue(0);
	WIM_HelpScrollFrame:UpdateScrollChildRect();
end

function WIM_Help_ChangeLog_Click()
	PanelTemplates_SelectTab(WIM_HelpTab2);
	PanelTemplates_DeselectTab(WIM_HelpTab1);
	
	WIM_HelpScrollFrameScrollChildText:SetText(WIM_CHANGE_LOG);
	WIM_HelpScrollFrameScrollBar:SetValue(0);
	WIM_HelpScrollFrame:UpdateScrollChildRect();
end


