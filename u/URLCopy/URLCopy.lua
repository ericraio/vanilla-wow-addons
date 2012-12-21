-- URL Copy v1.2.10900 by Leuchtturm on Azshara EU

URLCOPY_TITLE = "URL Copy"
URLCOPY_COLOR = "FFFF55"
URLCopy = {}

URLCopy_AddMessage1_Original = nil
URLCopy_AddMessage2_Original = nil
URLCopy_AddMessage3_Original = nil
URLCopy_AddMessage4_Original = nil
URLCopy_AddMessage5_Original = nil
URLCopy_AddMessage6_Original = nil
URLCopy_AddMessage7_Original = nil
URLCopy_SetItemRef_Original = nil

function URLCopy_OnLoad()
	-- UIPanelWindows['URLCopyFrame'] = {area = 'center', pushable = 0};
	URLCopyFrame:RegisterForDrag("LeftButton");

	if DEFAULT_CHAT_FRAME.AddMessage ~= URLCopy_AddMessage1 then
		URLCopy_AddMessage1_Original = DEFAULT_CHAT_FRAME.AddMessage
		DEFAULT_CHAT_FRAME.AddMessage = URLCopy_AddMessage1
	end
	if ChatFrame2 and ChatFrame2.AddMessage ~= URLCopy_AddMessage2 then
		URLCopy_AddMessage2_Original = ChatFrame2.AddMessage
		ChatFrame2.AddMessage = URLCopy_AddMessage2
	end
	if ChatFrame3 and ChatFrame3.AddMessage ~= URLCopy_AddMessage3 then
		URLCopy_AddMessage3_Original = ChatFrame3.AddMessage
		ChatFrame3.AddMessage = URLCopy_AddMessage3
	end
	if ChatFrame4 and ChatFrame4.AddMessage ~= URLCopy_AddMessage4 then
		URLCopy_AddMessage4_Original = ChatFrame4.AddMessage
		ChatFrame4.AddMessage = URLCopy_AddMessage4
	end
	if ChatFrame5 and ChatFrame5.AddMessage ~= URLCopy_AddMessage5 then
		URLCopy_AddMessage5_Original = ChatFrame5.AddMessage
		ChatFrame5.AddMessage = URLCopy_AddMessage5
	end
	if ChatFrame6 and ChatFrame6.AddMessage ~= URLCopy_AddMessage6 then
		URLCopy_AddMessage6_Original = ChatFrame6.AddMessage
		ChatFrame6.AddMessage = URLCopy_AddMessage6
	end
	if ChatFrame7 and ChatFrame7.AddMessage ~= URLCopy_AddMessage7 then
		URLCopy_AddMessage7_Original = ChatFrame7.AddMessage
		ChatFrame7.AddMessage = URLCopy_AddMessage7
	end

	URLCopy_SetItemRef_Original = SetItemRef
	SetItemRef = URLCopy_SetItemRef



	SlashCmdList["URLCOPYBRACKETS"] = URLCopy_SlashBrackets;
	SLASH_URLCOPYBRACKETS1 = "/ucb";
	SlashCmdList["URLCOPYCOLOR"] = URLCopy_SlashColor;
	SLASH_URLCOPYCOLOR1 = "/ucc";

	if not URLCopy.Brackets then
		URLCopy.Brackets = 1
	end
	if not URLCopy.Color then
		URLCopy.Color = URLCOPY_COLOR
	end
end

function URLCopy_SlashBrackets(arg)
	if (arg == "off") then
		URLCopy.Brackets = 0
	else
		URLCopy.Brackets = 1
	end
end
function URLCopy_SlashColor(arg)
	if (arg == "") then
		URLCopy.Color = URLCOPY_COLOR
	else
		URLCopy.Color = arg
	end
end

function URLCopy_Toggle()
	if(URLCopyFrame:IsVisible()) then
		URLCopyFrame:Hide();
	else
		URLCopyFrame:Show();
	end
end

function URLCopy_Decompose (chatstring)
	if chatstring ~= nil then
		chatstring = string.gsub (chatstring, " www%.([_A-Za-z0-9-]+)%.(%S+)%s?", URLCopy_Link("www.%1.%2"))
		chatstring = string.gsub (chatstring, " (%a+)://(%S+)%s?", URLCopy_Link("%1://%2"))
		chatstring = string.gsub (chatstring, " ([_A-Za-z0-9-%.]+)@([_A-Za-z0-9-]+)(%.+)([_A-Za-z0-9-%.]+)%s?", URLCopy_Link("%1@%2%3%4"))
		chatstring = string.gsub (chatstring, " (%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?):(%d%d?%d?%d?%d?)%s?", URLCopy_Link("%1.%2.%3.%4:%5"))
		chatstring = string.gsub (chatstring, " (%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)%s?", URLCopy_Link("%1.%2.%3.%4"))
		
		chatstring = string.gsub (chatstring, " ([_A-Za-z0-9-]+)%.([_A-Za-z0-9-]+)%.(%S+)%s?", URLCopy_Link("%1.%2.%3"))
		chatstring = string.gsub (chatstring, " ([_A-Za-z0-9-]+)%.([_A-Za-z0-9-]+)%.(%S+)%:([_0-9-]+)%s?", URLCopy_Link("%1.%2.%3:%4"))

	end
	return chatstring
end

function URLCopy_Link (link)
	if (URLCopy.Brackets == 1) then
		link = " |cff" .. URLCopy.Color .. "|Hurl:" .. link .. "|h[" .. link .. "]|h|r "
	else
		link = " |cff" .. URLCopy.Color .. "|Hurl:" .. link .. "|h" .. link .. "|h|r "
	end
	return link
end

function URLCopy_AddMessage1(t, s, ...)
	s = URLCopy_Decompose (s)
	URLCopy_AddMessage1_Original (t, s, unpack (arg))
end

function URLCopy_AddMessage2(t, s, ...)
	s = URLCopy_Decompose (s)
	URLCopy_AddMessage2_Original (t, s, unpack (arg))
end

function URLCopy_AddMessage3(t, s, ...)
	s = URLCopy_Decompose (s)
	URLCopy_AddMessage3_Original (t, s, unpack (arg))
end

function URLCopy_AddMessage4(t, s, ...)
	s = URLCopy_Decompose (s)
	URLCopy_AddMessage4_Original (t, s, unpack (arg))
end

function URLCopy_AddMessage5(t, s, ...)
	s = URLCopy_Decompose (s)
	URLCopy_AddMessage5_Original (t, s, unpack (arg))
end

function URLCopy_AddMessage6(t, s, ...)
	s = URLCopy_Decompose (s)
	URLCopy_AddMessage6_Original (t, s, unpack (arg))
end

function URLCopy_AddMessage7(t, s, ...)
	s = URLCopy_Decompose (s)
	URLCopy_AddMessage7_Original (t, s, unpack (arg))
end

function URLCopy_SetItemRef(link, text, button)
if ( strsub(link, 1, 3) == "url" ) then
URLCopy_Toggle();
URLCopyFrameEditBox:SetText( strsub(link, 5) );
URLCopyFrameEditBox:HighlightText();
return;
end

URLCopy_SetItemRef_Original(link, text, button);
end
