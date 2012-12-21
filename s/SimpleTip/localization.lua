-- Title, version string, etc
SimpleTip_Name = "SimpleTip (redux)";
SimpleTip_Ver = "v1.7";
SimpleTip_Title = string.format("Skeev's %s %s", SimpleTip_Name, SimpleTip_Ver);

-- English (default)
SimpleTip_Load_Txt = SimpleTip_Title.." loaded.";

-- command words (and equivalents)
SimpleTip_Cmd_Help  = {"help", "usage", "?"};
SimpleTip_Cmd_About = {"about", "credit", "credits"};
SimpleTip_Cmd_MoveTo  = {"moveto", "anchor"};
SimpleTip_Cmd_NoMove = {"nomove", "noanchor"};
SimpleTip_Cmd_Offset = {"offset", "xy"};
SimpleTip_Cmd_Status = {"status", "show", "info"};
SimpleTip_Cmd_PvP = {"pvp"};

-- position words
SimpleTip_Pos_Anchor = {"topleft", "top", "topright", "left", "center", "right", "bottomleft", "bottom", "bottomright"};
SimpleTip_Pos_Pointer = {"pointer", "mouse", "cursor"};

-- display text 
-- NOTE:  <white> <grey> <yellow>  become text color shifts
--                  \n             is a linebreak
--               %s and %.1f       are replaced with values at runtime
SimpleTip_Pointer_Txt = "pointer";
SimpleTip_MoveTo_Txt = "Tooltip position is set to <grey>%s<yellow>.";
SimpleTip_NoMove_Txt = "Tooltip repositioning disabled.";
SimpleTip_Offset_Txt = "Tooltip offset is set to <grey>%.1f<yellow>, <grey>%.1f<yellow>.";
SimpleTip_PointerOffset_Txt = "Offset cannot be changed when tooltips are anchored to the pointer.";

SimpleTip_Help_Txt = "SimpleTip usage:\n   /simpletip {moveto | nomove | offset | pvp | status | help | about }";
SimpleTip_MoveToHelp_Txt = "Set SimpleTip position:\n   /simpletip moveto {topleft | top | topright | left | center | right | bottomleft | bottom | bottomright}";
SimpleTip_NoMoveHelp_Txt = "Use default position:\n   /simpletip nomove";
SimpleTip_OffsetHelp_Txt = "Fine-tune position:\n   /simpletip offset <grey>x<white>, <grey>y";
SimpleTip_OffsetHelp2_Txt = "   (Horizontal: <white>- <grey>left<yellow>, <white>+ <grey>right<yellow>; Vertical: <white>- <grey>down<yellow>, <white>+ <grey>up<yellow>)"

SimpleTip_Credits1_Txt = SimpleTip_Title.." credits:";
SimpleTip_Credits2_Txt = "Coder, English trans --> <grey>Skeev of Proudmoore (North America)";
SimpleTip_Credits3_Txt = "French translation --> <white>(translator needed!)";
SimpleTip_Credits4_Txt = "German translation --> <white>(translator needed!)";
SimpleTip_Credits5_Txt = "Patch 1500 modifications --> Ayradyss";

SimpleTip_PvP_Help = "Show or hide PvP tooltip line:\n   /simpletip pvp {show | hide}";
SimpleTip_PvP_Status = "%s PvP tooltip line."


-- German
if (GetLocale() == "deDE") then

-- French
elseif (GetLocale() == "frFR") then

-- Korean
elseif (GetLocale() == "koKR") then

end
