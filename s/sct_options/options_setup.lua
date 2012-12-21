--The Options Page variables 

--Event and Damage option values
SCT.OPTIONS = {};
SCT.OPTIONS.FrameEventFrames = { };
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT1.name] = { index = 1, tooltipText = SCT.LOCALS.OPTION_EVENT1.tooltipText, SCTVar = "SHOWHIT"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT2.name] = { index = 2, tooltipText = SCT.LOCALS.OPTION_EVENT2.tooltipText, SCTVar = "SHOWMISS"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT3.name] = { index = 3, tooltipText = SCT.LOCALS.OPTION_EVENT3.tooltipText, SCTVar = "SHOWDODGE"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT4.name] = { index = 4, tooltipText = SCT.LOCALS.OPTION_EVENT4.tooltipText, SCTVar = "SHOWPARRY"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT5.name] = { index = 5, tooltipText = SCT.LOCALS.OPTION_EVENT5.tooltipText, SCTVar = "SHOWBLOCK"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT6.name] = { index = 6, tooltipText = SCT.LOCALS.OPTION_EVENT6.tooltipText, SCTVar = "SHOWSPELL"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT7.name] = { index = 7, tooltipText = SCT.LOCALS.OPTION_EVENT7.tooltipText, SCTVar = "SHOWHEAL"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT8.name] = { index = 8, tooltipText = SCT.LOCALS.OPTION_EVENT8.tooltipText, SCTVar = "SHOWRESIST"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT9.name] = { index = 9, tooltipText = SCT.LOCALS.OPTION_EVENT9.tooltipText, SCTVar = "SHOWDEBUFF"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT10.name] = { index = 10, tooltipText = SCT.LOCALS.OPTION_EVENT10.tooltipText, SCTVar = "SHOWABSORB"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT11.name] = { index = 11, tooltipText = SCT.LOCALS.OPTION_EVENT11.tooltipText, SCTVar = "SHOWLOWHP"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT12.name] = { index = 12, tooltipText = SCT.LOCALS.OPTION_EVENT12.tooltipText, SCTVar = "SHOWLOWMANA"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT13.name] = { index = 13, tooltipText = SCT.LOCALS.OPTION_EVENT13.tooltipText, SCTVar = "SHOWPOWER"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT14.name] = { index = 14, tooltipText = SCT.LOCALS.OPTION_EVENT14.tooltipText, SCTVar = "SHOWCOMBAT"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT15.name] = { index = 15, tooltipText = SCT.LOCALS.OPTION_EVENT15.tooltipText, SCTVar = "SHOWCOMBOPOINTS"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT16.name] = { index = 16, tooltipText = SCT.LOCALS.OPTION_EVENT16.tooltipText, SCTVar = "SHOWHONOR"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT17.name] = { index = 17, tooltipText = SCT.LOCALS.OPTION_EVENT17.tooltipText, SCTVar = "SHOWBUFF"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT18.name] = { index = 18, tooltipText = SCT.LOCALS.OPTION_EVENT18.tooltipText, SCTVar = "SHOWFADE"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT19.name] = { index = 19, tooltipText = SCT.LOCALS.OPTION_EVENT19.tooltipText, SCTVar = "SHOWEXECUTE"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT20.name] = { index = 20, tooltipText = SCT.LOCALS.OPTION_EVENT20.tooltipText, SCTVar = "SHOWREP"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT21.name] = { index = 21, tooltipText = SCT.LOCALS.OPTION_EVENT21.tooltipText, SCTVar = "SHOWSELFHEAL"};
SCT.OPTIONS.FrameEventFrames [SCT.LOCALS.OPTION_EVENT22.name] = { index = 22, tooltipText = SCT.LOCALS.OPTION_EVENT22.tooltipText, SCTVar = "SHOWSKILL"};

--Check Button option values
SCT.OPTIONS.FrameCheckButtons = { };
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK1.name] = { index = 1, tooltipText = SCT.LOCALS.OPTION_CHECK1.tooltipText, SCTVar = "ENABLED"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK2.name] = { index = 2, tooltipText = SCT.LOCALS.OPTION_CHECK2.tooltipText, SCTVar = "SHOWSELF"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK3.name] = { index = 3, tooltipText = SCT.LOCALS.OPTION_CHECK3.tooltipText, SCTVar = "SHOWTARGETS"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK4.name] = { index = 4, tooltipText = SCT.LOCALS.OPTION_CHECK4.tooltipText, SCTVar = "DIRECTION", SCTTable = SCT.FRAME1};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK5.name] = { index = 5, tooltipText = SCT.LOCALS.OPTION_CHECK5.tooltipText, SCTVar = "STICKYCRIT"}
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK6.name] = { index = 6, tooltipText = SCT.LOCALS.OPTION_CHECK6.tooltipText, SCTVar = "SPELLTYPE"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK7.name] = { index = 7, tooltipText = SCT.LOCALS.OPTION_CHECK7.tooltipText, SCTVar = "DMGFONT"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK8.name] = { index = 8, tooltipText = SCT.LOCALS.OPTION_CHECK8.tooltipText, SCTVar = "SHOWALLPOWER"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK9.name] = { index = 9, tooltipText = SCT.LOCALS.OPTION_CHECK9.tooltipText, SCTVar = "FPSMODE"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK10.name] = { index = 10, tooltipText = SCT.LOCALS.OPTION_CHECK10.tooltipText, SCTVar = "SHOWOVERHEAL"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK11.name] = { index = 11, tooltipText = SCT.LOCALS.OPTION_CHECK11.tooltipText, SCTVar = "PLAYSOUND"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK12.name] = { index = 12, tooltipText = SCT.LOCALS.OPTION_CHECK12.tooltipText, SCTVar = "SPELLCOLOR"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK13.name] = { index = 13, tooltipText = SCT.LOCALS.OPTION_CHECK13.tooltipText, SCTVar = "CUSTOMEVENTS"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK14.name] = { index = 14, tooltipText = SCT.LOCALS.OPTION_CHECK14.tooltipText, SCTVar = "LIGHTMODE"};
SCT.OPTIONS.FrameCheckButtons [SCT.LOCALS.OPTION_CHECK15.name] = { index = 15, tooltipText = SCT.LOCALS.OPTION_CHECK15.tooltipText, SCTVar = "FLASHCRIT"};

--Slider options values
SCT.OPTIONS.FrameSliders = { };
SCT.OPTIONS.FrameSliders [SCT.LOCALS.OPTION_SLIDER1.name] = { index = 1, SCTVar = "ANIMATIONSPEED", minValue = 5, maxValue = 25, valueStep = 5, minText=SCT.LOCALS.OPTION_SLIDER1.minText, maxText=SCT.LOCALS.OPTION_SLIDER1.maxText, tooltipText = SCT.LOCALS.OPTION_SLIDER1.tooltipText};
SCT.OPTIONS.FrameSliders [SCT.LOCALS.OPTION_SLIDER2.name] = { index = 2, SCTVar = "TEXTSIZE", minValue = 12, maxValue = 32, valueStep = 2, minText=SCT.LOCALS.OPTION_SLIDER2.minText, maxText=SCT.LOCALS.OPTION_SLIDER2.maxText, tooltipText = SCT.LOCALS.OPTION_SLIDER2.tooltipText, SCTTable = SCT.FRAME1};
SCT.OPTIONS.FrameSliders [SCT.LOCALS.OPTION_SLIDER3.name] = { index = 3, SCTVar = "LOWHP", minValue = 10, maxValue = 90, valueStep = 10, minText=SCT.LOCALS.OPTION_SLIDER3.minText, maxText=SCT.LOCALS.OPTION_SLIDER3.maxText, tooltipText = SCT.LOCALS.OPTION_SLIDER3.tooltipText};
SCT.OPTIONS.FrameSliders [SCT.LOCALS.OPTION_SLIDER4.name] = { index = 4, SCTVar = "LOWMANA", minValue = 10, maxValue = 90, valueStep = 10, minText=SCT.LOCALS.OPTION_SLIDER4.minText, maxText=SCT.LOCALS.OPTION_SLIDER4.maxText, tooltipText = SCT.LOCALS.OPTION_SLIDER4.tooltipText};
SCT.OPTIONS.FrameSliders [SCT.LOCALS.OPTION_SLIDER5.name] = { index = 5, SCTVar = "ALPHA", minValue = 10, maxValue = 100, valueStep = 10, minText=SCT.LOCALS.OPTION_SLIDER5.minText, maxText=SCT.LOCALS.OPTION_SLIDER5.maxText, tooltipText = SCT.LOCALS.OPTION_SLIDER5.tooltipText, SCTTable = SCT.FRAME1};
SCT.OPTIONS.FrameSliders [SCT.LOCALS.OPTION_SLIDER6.name] = { index = 6, SCTVar = "MOVEMENT", minValue = 1, maxValue = 5, valueStep = 1, minText=SCT.LOCALS.OPTION_SLIDER6.minText, maxText=SCT.LOCALS.OPTION_SLIDER6.maxText, tooltipText = SCT.LOCALS.OPTION_SLIDER6.tooltipText};
SCT.OPTIONS.FrameSliders [SCT.LOCALS.OPTION_SLIDER7.name] = { index = 7, SCTVar = "XOFFSET", minValue = -600, maxValue = 600, valueStep = 10, minText=SCT.LOCALS.OPTION_SLIDER7.minText, maxText=SCT.LOCALS.OPTION_SLIDER7.maxText, tooltipText = SCT.LOCALS.OPTION_SLIDER7.tooltipText, SCTTable = SCT.FRAME1};
SCT.OPTIONS.FrameSliders [SCT.LOCALS.OPTION_SLIDER8.name] = { index = 8, SCTVar = "YOFFSET", minValue = -400, maxValue = 400, valueStep = 10, minText=SCT.LOCALS.OPTION_SLIDER8.minText, maxText=SCT.LOCALS.OPTION_SLIDER8.maxText, tooltipText = SCT.LOCALS.OPTION_SLIDER8.tooltipText, SCTTable = SCT.FRAME1};
SCT.OPTIONS.FrameSliders [SCT.LOCALS.OPTION_SLIDER9.name] = { index = 9, SCTVar = "MSGXOFFSET", minValue = -600, maxValue = 600, valueStep = 10, minText=SCT.LOCALS.OPTION_SLIDER9.minText, maxText=SCT.LOCALS.OPTION_SLIDER9.maxText, tooltipText = SCT.LOCALS.OPTION_SLIDER9.tooltipText, SCTTable = SCT.MSG};
SCT.OPTIONS.FrameSliders [SCT.LOCALS.OPTION_SLIDER10.name] = { index = 10, SCTVar = "MSGYOFFSET", minValue = -400, maxValue = 400, valueStep = 10, minText=SCT.LOCALS.OPTION_SLIDER10.minText, maxText=SCT.LOCALS.OPTION_SLIDER10.maxText, tooltipText = SCT.LOCALS.OPTION_SLIDER10.tooltipText, SCTTable = SCT.MSG};
SCT.OPTIONS.FrameSliders [SCT.LOCALS.OPTION_SLIDER11.name] = { index = 11, SCTVar = "MSGFADE", minValue = 1, maxValue = 3, valueStep = .5, minText=SCT.LOCALS.OPTION_SLIDER11.minText, maxText=SCT.LOCALS.OPTION_SLIDER11.maxText, tooltipText = SCT.LOCALS.OPTION_SLIDER11.tooltipText, SCTTable = SCT.MSG};
SCT.OPTIONS.FrameSliders [SCT.LOCALS.OPTION_SLIDER12.name] = { index = 12, SCTVar = "MSGSIZE", minValue = 12, maxValue = 36, valueStep = 3, minText=SCT.LOCALS.OPTION_SLIDER12.minText, maxText=SCT.LOCALS.OPTION_SLIDER12.maxText, tooltipText = SCT.LOCALS.OPTION_SLIDER12.tooltipText, SCTTable = SCT.MSG};
SCT.OPTIONS.FrameSliders [SCT.LOCALS.OPTION_SLIDER13.name] = { index = 13, SCTVar = "HEALFILTER", minValue = 0, maxValue = 500, valueStep = 25, minText=SCT.LOCALS.OPTION_SLIDER13.minText, maxText=SCT.LOCALS.OPTION_SLIDER13.maxText, tooltipText = SCT.LOCALS.OPTION_SLIDER13.tooltipText};

--Selection Boxes
SCT.OPTIONS.FrameSelections = {};
SCT.OPTIONS.FrameSelections [SCT.LOCALS.OPTION_SELECTION1.name] = { index = 1, SCTVar = "ANITYPE", tooltipText = SCT.LOCALS.OPTION_SELECTION1.tooltipText, table = SCT.LOCALS.OPTION_SELECTION1.table, SCTTable = SCT.FRAME1};
SCT.OPTIONS.FrameSelections [SCT.LOCALS.OPTION_SELECTION2.name] = { index = 2, SCTVar = "ANISIDETYPE", tooltipText = SCT.LOCALS.OPTION_SELECTION2.tooltipText, table = SCT.LOCALS.OPTION_SELECTION2.table, SCTTable = SCT.FRAME1};
SCT.OPTIONS.FrameSelections [SCT.LOCALS.OPTION_SELECTION3.name] = { index = 3, SCTVar = "FONT", tooltipText = SCT.LOCALS.OPTION_SELECTION3.tooltipText, table = SCT.LOCALS.OPTION_SELECTION3.table, SCTTable = SCT.FRAME1};
SCT.OPTIONS.FrameSelections [SCT.LOCALS.OPTION_SELECTION4.name] = { index = 4, SCTVar = "FONTSHADOW", tooltipText = SCT.LOCALS.OPTION_SELECTION4.tooltipText, table = SCT.LOCALS.OPTION_SELECTION4.table, SCTTable = SCT.FRAME1};
SCT.OPTIONS.FrameSelections [SCT.LOCALS.OPTION_SELECTION5.name] = { index = 5, SCTVar = "MSGFONT", tooltipText = SCT.LOCALS.OPTION_SELECTION5.tooltipText, table = SCT.LOCALS.OPTION_SELECTION5.table, SCTTable = SCT.MSG};
SCT.OPTIONS.FrameSelections [SCT.LOCALS.OPTION_SELECTION6.name] = { index = 6, SCTVar = "MSGFONTSHADOW", tooltipText = SCT.LOCALS.OPTION_SELECTION6.tooltipText, table = SCT.LOCALS.OPTION_SELECTION6.table, SCTTable = SCT.MSG};

--Other Options
SCT.OPTIONS.FrameMisc = {};
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC1.name] = {index = 1, tooltipText = SCT.LOCALS.OPTION_MISC1.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC2.name] = {index = 2, tooltipText = SCT.LOCALS.OPTION_MISC2.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC3.name] = {index = 3, tooltipText = SCT.LOCALS.OPTION_MISC3.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC4.name] = {index = 4, tooltipText = SCT.LOCALS.OPTION_MISC4.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC5.name] = {index = 5, tooltipText = SCT.LOCALS.OPTION_MISC5.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC6.name] = {index = 6, tooltipText = SCT.LOCALS.OPTION_MISC6.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC7.name] = {index = 7, tooltipText = SCT.LOCALS.OPTION_MISC7.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC8.name] = {index = 8, tooltipText = SCT.LOCALS.OPTION_MISC8.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC9.name] = {index = 9, tooltipText = SCT.LOCALS.OPTION_MISC9.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC10.name] = {index = 10, tooltipText = SCT.LOCALS.OPTION_MISC10.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC11.name] = {index = 11, tooltipText = SCT.LOCALS.OPTION_MISC11.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC12.name] = {index = 12, tooltipText = SCT.LOCALS.OPTION_MISC12.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC13.name] = {index = 13, tooltipText = SCT.LOCALS.OPTION_MISC13.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC14.name] = {index = 14, tooltipText = SCT.LOCALS.OPTION_MISC14.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC15.name] = {index = 15, tooltipText = SCT.LOCALS.OPTION_MISC15.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC16.name] = {index = 16, tooltipText = SCT.LOCALS.OPTION_MISC16.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC17.name] = {index = 17, tooltipText = SCT.LOCALS.OPTION_MISC17.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC18.name] = {index = 18, tooltipText = SCT.LOCALS.OPTION_MISC18.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC19.name] = {index = 19, tooltipText = SCT.LOCALS.OPTION_MISC19.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC20.name] = {index = 20, tooltipText = SCT.LOCALS.OPTION_MISC20.tooltipText}
--21 skipped
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC22.name] = {index = 22, tooltipText = SCT.LOCALS.OPTION_MISC22.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC23.name] = {index = 23, tooltipText = SCT.LOCALS.OPTION_MISC23.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC24.name] = {index = 24, tooltipText = SCT.LOCALS.OPTION_MISC24.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC25.name] = {index = 25, tooltipText = SCT.LOCALS.OPTION_MISC25.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC26.name] = {index = 26, tooltipText = SCT.LOCALS.OPTION_MISC26.tooltipText}
SCT.OPTIONS.FrameMisc [SCT.LOCALS.OPTION_MISC27.name] = {index = 27, tooltipText = SCT.LOCALS.OPTION_MISC27.tooltipText}
