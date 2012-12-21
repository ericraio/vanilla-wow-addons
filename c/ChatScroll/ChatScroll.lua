--------------------------------------------------------------------------
-- ChatScroll.lua 
--------------------------------------------------------------------------
--[[
ChatScroll

author: AnduinLothar    <Anduin@cosmosui.org>

Replaces an old Cosmos FrameXML Hack.
-ChatFrame Mouse Wheel Scroll


]]--

Cosmos_UseMouseWheelToScrollChat = true;

function ChatFrame_OnMouseWheel(chatframe, value)
	if ( Cosmos_UseMouseWheelToScrollChat ) and ( not IsShiftKeyDown() ) then
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
