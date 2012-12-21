--The Options Page variables and functions

--check SCT version
if (not SCT) or (tonumber(SCT.db.profile["VERSION"]) < 5) then
	StaticPopup_Show("SCTD_VERSION");
	if (SCTOptionsFrame_Misc103) then
		SCTOptionsFrame_Misc103:Hide();
	end
	return;
end

--Event and Damage option values
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT101.name] = { index = 101, tooltipText = SCT.LOCALS.OPTION_EVENT101.tooltipText, SCTVar = "SCTD_SHOWMELEE"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT102.name] = { index = 102, tooltipText = SCT.LOCALS.OPTION_EVENT102.tooltipText, SCTVar = "SCTD_SHOWPERIODIC"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT103.name] = { index = 103, tooltipText = SCT.LOCALS.OPTION_EVENT103.tooltipText, SCTVar = "SCTD_SHOWSPELL"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT104.name] = { index = 104, tooltipText = SCT.LOCALS.OPTION_EVENT104.tooltipText, SCTVar = "SCTD_SHOWPET"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT105.name] = { index = 105, tooltipText = SCT.LOCALS.OPTION_EVENT105.tooltipText, SCTVar = "SCTD_SHOWCOLORCRIT"};

--Check Button option values
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK101.name] = { index = 101, tooltipText = SCT.LOCALS.OPTION_CHECK101.tooltipText, SCTVar = "SCTD_ENABLED"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK102.name] = { index = 102, tooltipText = SCT.LOCALS.OPTION_CHECK102.tooltipText, SCTVar = "SCTD_FLAGDMG"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK103.name] = { index = 103, tooltipText = SCT.LOCALS.OPTION_CHECK103.tooltipText, SCTVar = "SCTD_SHOWDMGTYPE"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK104.name] = { index = 104, tooltipText = SCT.LOCALS.OPTION_CHECK104.tooltipText, SCTVar = "SCTD_SHOWSPELLNAME"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK105.name] = { index = 105, tooltipText = SCT.LOCALS.OPTION_CHECK105.tooltipText, SCTVar = "SCTD_SHOWRESIST"}
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK106.name] = { index = 106, tooltipText = SCT.LOCALS.OPTION_CHECK106.tooltipText, SCTVar = "SCTD_SHOWTARGETS"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK107.name] = { index = 107, tooltipText = SCT.LOCALS.OPTION_CHECK107.tooltipText, SCTVar = "SCTD_DMGFONT"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK108.name] = { index = 108, tooltipText = SCT.LOCALS.OPTION_CHECK108.tooltipText, SCTVar = "SCTD_TARGET"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK109.name] = { index = 109, tooltipText = SCT.LOCALS.OPTION_CHECK109.tooltipText, SCTVar = "SCTD_PVPDMG"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK110.name] = { index = 110, tooltipText = SCT.LOCALS.OPTION_CHECK110.tooltipText, SCTVar = "SCTD_USESCT"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK111.name] = { index = 111, tooltipText = SCT.LOCALS.OPTION_CHECK111.tooltipText, SCTVar = "SCTD_STICKYCRIT"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK112.name] = { index = 112, tooltipText = SCT.LOCALS.OPTION_CHECK112.tooltipText, SCTVar = "SCTD_SPELLCOLOR"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK113.name] = { index = 113, tooltipText = SCT.LOCALS.OPTION_CHECK113.tooltipText, SCTVar = "DIRECTION", SCTTable = SCT.FRAME3};

--Slider options values
SCT.OPTIONS.FrameSliders [SCT.LOCALS.OPTION_SLIDER101.name] = { index = 101, SCTVar = "XOFFSET", minValue = -600, maxValue = 600, valueStep = 10, minText=SCT.LOCALS.OPTION_SLIDER101.minText, maxText=SCT.LOCALS.OPTION_SLIDER101.maxText, tooltipText = SCT.LOCALS.OPTION_SLIDER101.tooltipText, SCTTable = SCT.FRAME3};
SCT.OPTIONS.FrameSliders [SCT.LOCALS.OPTION_SLIDER102.name] = { index = 102, SCTVar = "YOFFSET", minValue = -400, maxValue = 400, valueStep = 10, minText=SCT.LOCALS.OPTION_SLIDER102.minText, maxText=SCT.LOCALS.OPTION_SLIDER102.maxText, tooltipText = SCT.LOCALS.OPTION_SLIDER102.tooltipText, SCTTable = SCT.FRAME3};
SCT.OPTIONS.FrameSliders [SCT.LOCALS.OPTION_SLIDER103.name] = { index = 103, SCTVar = "FADE", minValue = 1, maxValue = 3, valueStep = .5, minText=SCT.LOCALS.OPTION_SLIDER103.minText, maxText=SCT.LOCALS.OPTION_SLIDER103.maxText, tooltipText = SCT.LOCALS.OPTION_SLIDER103.tooltipText, SCTTable = SCT.FRAME3};
SCT.OPTIONS.FrameSliders [SCT.LOCALS.OPTION_SLIDER104.name] = { index = 104, SCTVar = "TEXTSIZE", minValue = 12, maxValue = 36, valueStep = 3, minText=SCT.LOCALS.OPTION_SLIDER104.minText, maxText=SCT.LOCALS.OPTION_SLIDER104.maxText, tooltipText = SCT.LOCALS.OPTION_SLIDER104.tooltipText, SCTTable = SCT.FRAME3};
SCT.OPTIONS.FrameSliders [SCT.LOCALS.OPTION_SLIDER105.name] = { index = 105, SCTVar = "ALPHA", minValue = 10, maxValue = 100, valueStep = 10, minText=SCT.LOCALS.OPTION_SLIDER105.minText, maxText=SCT.LOCALS.OPTION_SLIDER105.maxText, tooltipText = SCT.LOCALS.OPTION_SLIDER105.tooltipText, SCTTable = SCT.FRAME3};

--Selection Boxes
SCT.OPTIONS.FrameSelections [SCT.LOCALS.OPTION_SELECTION101.name] = { index = 101, SCTVar = "FONT", tooltipText = SCT.LOCALS.OPTION_SELECTION101.tooltipText, table = SCT.LOCALS.OPTION_SELECTION101.table, SCTTable = SCT.FRAME3};
SCT.OPTIONS.FrameSelections [SCT.LOCALS.OPTION_SELECTION102.name] = { index = 102, SCTVar = "FONTSHADOW", tooltipText = SCT.LOCALS.OPTION_SELECTION102.tooltipText, table = SCT.LOCALS.OPTION_SELECTION102.table, SCTTable = SCT.FRAME3};
SCT.OPTIONS.FrameSelections [SCT.LOCALS.OPTION_SELECTION103.name] = { index = 103, SCTVar = "ANITYPE", tooltipText = SCT.LOCALS.OPTION_SELECTION103.tooltipText, table = SCT.LOCALS.OPTION_SELECTION103.table, SCTTable = SCT.FRAME3};
SCT.OPTIONS.FrameSelections [SCT.LOCALS.OPTION_SELECTION104.name] = { index = 104, SCTVar = "ANISIDETYPE", tooltipText = SCT.LOCALS.OPTION_SELECTION104.tooltipText, table = SCT.LOCALS.OPTION_SELECTION104.table, SCTTable = SCT.FRAME3};

--Other Options
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC101.name] = {index = 101, tooltipText = SCT.LOCALS.OPTION_MISC101.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC102.name] = {index = 102, tooltipText = SCT.LOCALS.OPTION_MISC102.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC103.name] = {index = 103, tooltipText = SCT.LOCALS.OPTION_MISC103.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC104.name] = {index = 104, tooltipText = SCT.LOCALS.OPTION_MISC104.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC105.name] = {index = 105, tooltipText = SCT.LOCALS.OPTION_MISC105.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC106.name] = {index = 106, tooltipText = SCT.LOCALS.OPTION_MISC106.tooltipText}

----------------------
--Set animation Options
function SCTD:SetAnimationOptions(objItem)
	if (objItem:GetChecked()) then
		SCTOptionsFrame_Slider103:Hide();
		SCTOptionsFrame_Slider105:Show();
		OptionsFrame_EnableDropDown(SCTOptionsFrame_Selection103);
		OptionsFrame_EnableDropDown(SCTOptionsFrame_Selection104);
		OptionsFrame_EnableCheckBox(SCTOptionsFrame_CheckButton113, SCTOptionsFrame_CheckButton113:GetChecked());
	else
		SCTOptionsFrame_Slider105:Hide();
		SCTOptionsFrame_Slider103:Show();
		OptionsFrame_DisableDropDown(SCTOptionsFrame_Selection103);
		OptionsFrame_DisableDropDown(SCTOptionsFrame_Selection104);
		OptionsFrame_DisableCheckBox(SCTOptionsFrame_CheckButton113);
	end
end

