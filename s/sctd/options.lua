--The Options Page variables and functions

--Event and Damage option values
function SCTD_LoadOptions()
	SCTOptionsFrameEventFrames [SCT_OPTION_EVENT101.name] = { index = 101, tooltipText = SCT_OPTION_EVENT101.tooltipText, SCTVar = "SCTD_SHOWMELEE"};
	SCTOptionsFrameEventFrames [SCT_OPTION_EVENT102.name] = { index = 102, tooltipText = SCT_OPTION_EVENT102.tooltipText, SCTVar = "SCTD_SHOWPERIODIC"};
	SCTOptionsFrameEventFrames [SCT_OPTION_EVENT103.name] = { index = 103, tooltipText = SCT_OPTION_EVENT103.tooltipText, SCTVar = "SCTD_SHOWSPELL"};
	SCTOptionsFrameEventFrames [SCT_OPTION_EVENT104.name] = { index = 104, tooltipText = SCT_OPTION_EVENT104.tooltipText, SCTVar = "SCTD_SHOWPET"};
	
	--Check Button option values
	SCTOptionsFrameCheckButtons [SCT_OPTION_CHECK101.name] = { index = 101, tooltipText = SCT_OPTION_CHECK101.tooltipText, SCTVar = "SCTD_ENABLED"};
	SCTOptionsFrameCheckButtons [SCT_OPTION_CHECK102.name] = { index = 102, tooltipText = SCT_OPTION_CHECK102.tooltipText, SCTVar = "SCTD_FLAGDMG"};
	SCTOptionsFrameCheckButtons [SCT_OPTION_CHECK103.name] = { index = 103, tooltipText = SCT_OPTION_CHECK103.tooltipText, SCTVar = "SCTD_SHOWDMGTYPE"};
	SCTOptionsFrameCheckButtons [SCT_OPTION_CHECK104.name] = { index = 104, tooltipText = SCT_OPTION_CHECK104.tooltipText, SCTVar = "SCTD_SHOWSPELLNAME"};
	SCTOptionsFrameCheckButtons [SCT_OPTION_CHECK105.name] = { index = 105, tooltipText = SCT_OPTION_CHECK105.tooltipText, SCTVar = "SCTD_SHOWRESIST"}
	SCTOptionsFrameCheckButtons [SCT_OPTION_CHECK106.name] = { index = 106, tooltipText = SCT_OPTION_CHECK106.tooltipText, SCTVar = "SCTD_SHOWTARGETS"};
	SCTOptionsFrameCheckButtons [SCT_OPTION_CHECK107.name] = { index = 107, tooltipText = SCT_OPTION_CHECK107.tooltipText, SCTVar = "SCTD_DMGFONT"};
	
	--Slider options values
	SCTOptionsFrameSliders [SCT_OPTION_SLIDER101.name] = { index = 101, SCTVar = "SCTD_MSGXOFFSET", minValue = -600, maxValue = 600, valueStep = 10, minText=SCT_OPTION_SLIDER101.minText, maxText=SCT_OPTION_SLIDER101.maxText, tooltipText = SCT_OPTION_SLIDER101.tooltipText};
	SCTOptionsFrameSliders [SCT_OPTION_SLIDER102.name] = { index = 102, SCTVar = "SCTD_MSGYOFFSET", minValue = -600, maxValue = 600, valueStep = 10, minText=SCT_OPTION_SLIDER102.minText, maxText=SCT_OPTION_SLIDER102.maxText, tooltipText = SCT_OPTION_SLIDER102.tooltipText};
	SCTOptionsFrameSliders [SCT_OPTION_SLIDER103.name] = { index = 103, SCTVar = "SCTD_MSGFADE", minValue = 1, maxValue = 3, valueStep = .5, minText=SCT_OPTION_SLIDER103.minText, maxText=SCT_OPTION_SLIDER103.maxText, tooltipText = SCT_OPTION_SLIDER103.tooltipText};
	SCTOptionsFrameSliders [SCT_OPTION_SLIDER104.name] = { index = 104, SCTVar = "SCTD_MSGSIZE", minValue = 12, maxValue = 36, valueStep = 3, minText=SCT_OPTION_SLIDER104.minText, maxText=SCT_OPTION_SLIDER104.maxText, tooltipText = SCT_OPTION_SLIDER104.tooltipText};
	
	--Selection Boxes
	SCTOptionsFrameSelections [SCT_OPTION_SELECTION101.name] = { index = 101, SCTVar = "SCTD_MSGFONT", tooltipText = SCT_OPTION_SELECTION101.tooltipText, table = SCT_OPTION_SELECTION101.table};
	SCTOptionsFrameSelections [SCT_OPTION_SELECTION102.name] = { index = 102, SCTVar = "SCTD_MSGFONTSHADOW", tooltipText = SCT_OPTION_SELECTION102.tooltipText, table = SCT_OPTION_SELECTION102.table};
	
	--Other Options
	SCTOptionsFrameMisc [SCT_OPTION_MISC101.name] = {index = 101, tooltipText = SCT_OPTION_MISC101.tooltipText}
	SCTOptionsFrameMisc [SCT_OPTION_MISC102.name] = {index = 102, tooltipText = SCT_OPTION_MISC102.tooltipText}
	SCTOptionsFrameMisc [SCT_OPTION_MISC103.name] = {index = 103, tooltipText = SCT_OPTION_MISC103.tooltipText}
end
