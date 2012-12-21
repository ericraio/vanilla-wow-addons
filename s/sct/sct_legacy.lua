--------------------------------
--Legacy Function for older mods
function SCT_Display(msg, color, iscrit, type, anitype)
	SCT:DisplayText(msg, color, iscrit, type, 1, anitype);
end
--------------------------------
--Legacy Function for older mods
function SCT_Display_Toggle(option, msg1, crit, msg2)
	SCT:Display_Event(option, msg1, crit, nil, nil, nil, msg2);
end
--------------------------------
--Legacy Function for older mods
function SCT_Display_Only(option, msg1, crit, damagetype, resisted, target)
	SCT:Display_Event(option, msg1, crit, damagetype, resisted, target);
end
--------------------------------
--Legacy Function for older mods
function SCT_Display_Message(msg, color)
	SCT:DisplayMessage(msg, color);
end
--------------------------------
--Legacy Function for older mods
function SCT_Display_Custom_Toggle(msg1, color, iscrit, ismsg, anitype)
	SCT:DisplayCustomEvent(msg1, color, iscrit, ismsg, anitype)
end