--[[

	Config file for FlexBar.
	
	Basic usage - 
	decide on a nae for the loadable config: EG MyConfig
	place the line:
	MyConfig = {}
	
	then, each line you want executed follows the form:
	MyConfig[i] = "flexbar command"
	
	example:
	
	MyConfig[1] = "hide button=1 on='LoseAggro'
	MyConfig[2]= "show button=1 on='GainAggro'
--]]

-- Example configs:
-- Right click circular menu from a single button.
-- First, declare our circle menu config
FB_C_Menu = {}
-- then set the buttons up in their group and pattern
FB_C_Menu[1]  = "Group Button=14-20 Anchor=14"
FB_C_Menu[2]  = "CircleGroup Group=14 Padding=1"
FB_C_Menu[3]  = "MoveRel Button=14 Trgbtn=13 dX=-38 dY=19"
FB_C_Menu[4]  = "Ungroup group=14"
FB_C_Menu[5]  = "Group Button=13-20 Anchor=13"
FB_C_Menu[6]  = "Hide Button=14-20"
FB_C_Menu[7]  = "Show Button=13"
-- Next create the behavior
-- Set button 20 to only do its normal thing on left clicks and make right-clicks available
FB_C_Menu[8]  = "Advanced Button=13 State='on'"
-- Then, set buttons 13-19 to show on r-clicking 20
FB_C_Menu[9]  = "Show Button=14-20 On='RightButtonClick' Target=13"
-- Set the circle to hide on click and mouse leaving
FB_C_Menu[10] = "Hide Button=14-20 On='MouseLeaveGroup' Target=13"
FB_C_Menu[11] = "Hide Button=14-20 on='LeftButtonClick' Target=14-20"
FB_C_Menu[12] = "Hide Button=14-20 on='RightButtonClick' Target=14-20"

-- To implement these use /FlexBar LoadConfig Config='FB_C_Menu' in game
-- If you're already using those buttons, choose any range of 8 buttons and adjust accordingly.

-- one of the things someone was trying to do a while back was have a small row of buttons 
-- (think he had 4) that would pop up 'totem poles' when the mouse went over them. The idea is 
-- that he would have one for fire, earth, water and fire and put his totems in the popups. 
-- for this we will use a group that is 4 buttons wide, and 3 high.
-- TotemPole 1 is buttons 1-3, with 3 being the button they pop up on
-- TotemPole 2 is buttons 4-6 with 6 being the trigger button
-- TotemPole 3 is buttons 7-9 with 9 being the trigger button
-- TotemPole 4 is buttons 10-12 with 12 being the trigger button

-- Name your config
FB_C_TotemPole = {}
-- Set the group up
FB_C_TotemPole[1]  = "show button=1-12"
FB_C_TotemPole[2]  = "group button=1-12 anchor=3"
-- (note the anchor - this will make your life easier) 
FB_C_TotemPole[3]  = "horizontalgroup group=3 height=3 padding=1"

-- set up events to hide all the popups when the mouse leaves the group or when a button is clicked
FB_C_TotemPole[4]  = "hide button=[1 2 4 5 7 8 10 11] on='MouseLeaveGroup' target=3 "
FB_C_TotemPole[5]  = "hide button=[1 2 4 5 7 8 10 11] on='LeftButtonClick' target=[1 2 4 5 7 8 10 11]"
FB_C_TotemPole[6]  = "hide button=[1 2 4 5 7 8 10 11] on='RightButtonClick' target=[1 2 4 5 7 8 10 11]" 
-- popup one goes up when mouse is over button 3, all others hide
FB_C_TotemPole[7]  = "show button=[1 2] on='MouseEnterButton' target=3"
FB_C_TotemPole[8]  = "hide button=[4 5 7 8 10 11] on='MouseEnterButton' target=3"
-- popup two goes up when mouse is over button 6, all others hide
FB_C_TotemPole[9]  = "show button=[4 5] on='MouseEnterButton' target=6"
FB_C_TotemPole[10] = "hide button=[1 2 7 8 10 11] on='MouseEnterButton' target=6"
-- popup three goes up when mouse is over button 9, all others hide
FB_C_TotemPole[11] = "show button=[7 8] on='MouseEnterButton' target=9"
FB_C_TotemPole[12] = "hide button=[1 2 4 5 10 11] on='MouseEnterButton' target=9" 
-- popup four goes up when mouse is over button 12, all others hide
FB_C_TotemPole[13] = "show button=[10 11] on='MouseEnterButton' target=12"
FB_C_TotemPole[14] = "hide button=[1 2 4 5 7 8 ] on='MouseEnterButton' target=12" 
FB_C_TotemPole[15] = "hide button=[1 2 4 5 7 8 10 11]"

-- Another question I had was how to set up a bar that mimiced the regular action bar
FB_C_ActionBar = {}
-- Show the bar
FB_C_ActionBar[1] = "show button=85-96"
-- Set them up in a horizontal bar
FB_C_ActionBar[1] = "group button=85-96 anchor=85"
FB_C_ActionBar[2] = "horizontalgroup group=85 height=1 padding=1"
-- Make them mimic the action bar.  ActionBarPage is thrown when the action bar changes 
-- (although there appears to be a problem with that in EU Beta).  The second argument is
-- the page to which it changed.
FB_C_ActionBar[3] = "remap button=85-96 base=1 on='ActionBarPage' target=1"
FB_C_ActionBar[4] = "remap button=85-96 base=13 on='ActionBarPage' target=2"
FB_C_ActionBar[5] = "remap button=85-96 base=25 on='ActionBarPage' target=3"
FB_C_ActionBar[6] = "remap button=85-96 base=37 on='ActionBarPage' target=4"
FB_C_ActionBar[7] = "remap button=85-96 base=49 on='ActionBarPage' target=5"
FB_C_ActionBar[8] = "remap button=85-96 base=61 on='ActionBarPage' target=6"
FB_C_ActionBar[9] = "Show group=85"


-- For the 3x3 matrix, do the following:
-- bind the 1 key to button 10, 2 key to button 11, 3 key to button 12 
-- make sure buttons 10-12 are empty 
-- type /flexbar loadconfig config='Nine_Matrix' to set this up 
Nine_Matrix={
"show button=1-9",
"group button=1-9 anchor=1",
"verticalgroup group=1 width=3 padding=1",
"remap button=10-12 base=1 toggle='true' on='LeftButtonClick' target=10",
"remap button=10-12 base=4 toggle='true' on='LeftButtonClick' target=11",
"remap button=10-12 base=7 toggle='true' on='LeftButtonClick' target=12",
"raise name='reverttimer' event='revertmatrix' source=1 in=4 on='LeftButtonClick' target=10-12",
"remap button=10-12 base=1 reset='true' on='revertmatrix' target=1",
"text button=1 text='1-1'",
"text button=2 text='1-2'",
"text button=3 text='1-3'",
"text button=4 text='2-1'",
"text button=5 text='2-2'",
"text button=6 text='2-3'",
"text button=7 text='3-1'",
"text button=8 text='3-2'",
"text button=9 text='3-3'"
}
