--[[
ChatScroll

original author: AnduinLothar    <Anduin@cosmosui.org>
modified by : Aaike Van Roekeghem - a.k.a [LoSt]Madness
]]--

LSChatConfig.Mousewheel = false;

function ChatFrame_OnMouseWheel(chatframe, value)
	if ( LSChatConfig.Mousewheel ) and ( not IsShiftKeyDown() ) then
		if ( value > 0 ) then
			chatframe:ScrollUp();
		elseif ( value < 0 ) then
			chatframe:ScrollDown();
		end
	else
		if ( value > 0 ) then
			ActionBar_PageUp();
		elseif ( value < 0 ) then
			ActionBar_PageDown();
		end
	end
end
