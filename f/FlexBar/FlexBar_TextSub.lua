--[[
	Text Sub functions for FlexBar
	Last Modified
		02/09/2005	Initial version
		08/12/2005  Added Text3 Stuff			- Sherkhan
--]]
local util = Utility_Class:New()

function FB_TextSub(buttonnum)
-- for the given button number, determine if the hotkey or text2 attributes are dynamic and set the text
	local text = getglobal("FlexBarButton"..buttonnum.."HotKey")
	local text2 = getglobal("FlexBarButton"..buttonnum.."Text2")
	local text3 = getglobal("FlexBarButton"..buttonnum.."Text3")

	if FBTextSubstitutions[FBState[buttonnum]["hotkeytext"]] then
		text:SetText(FBTextSubstitutions[FBState[buttonnum]["hotkeytext"]]())
	elseif FBState[buttonnum]["hotkeytext"] ~= "%d" and FBState[buttonnum]["hotkeytext"] ~= "%c" and FBState[buttonnum]["hotkeytext"] ~= "%b" then
		text:SetText(FBState[buttonnum]["hotkeytext"])
	end
	
	if FBTextSubstitutions[FBState[buttonnum]["text2"]] then
		text2:SetText(FBTextSubstitutions[FBState[buttonnum]["text2"]]())
	elseif FBState[buttonnum]["text2"] ~= "%d" and FBState[buttonnum]["text2"] ~= "%c" and FBState[buttonnum]["text2"] ~= "%b" then
		text2:SetText(FBState[buttonnum]["text2"])
	end
	
	if FBTextSubstitutions[FBState[buttonnum]["text3"]] then
		text3:SetText(FBTextSubstitutions[FBState[buttonnum]["text3"]]())
	elseif FBState[buttonnum]["text3"] ~= "%d" and FBState[buttonnum]["text3"] ~= "%c" and FBState[buttonnum]["text3"] ~= "%b" then
		text3:SetText(FBState[buttonnum]["text3"])
	end
	
	if FBState[buttonnum]["hotkeycolor"] then
		text:SetVertexColor(FBState[buttonnum]["hotkeycolor"][1],
							FBState[buttonnum]["hotkeycolor"][2],
							FBState[buttonnum]["hotkeycolor"][3])
	end

	if FBState[buttonnum]["text2color"] then
		text2:SetVertexColor(FBState[buttonnum]["text2color"][1],
							FBState[buttonnum]["text2color"][2],
							FBState[buttonnum]["text2color"][3])
	end

	if FBState[buttonnum]["text3color"] then
		text3:SetVertexColor(FBState[buttonnum]["text3color"][1],
							FBState[buttonnum]["text3color"][2],
							FBState[buttonnum]["text3color"][3])
	end
end

FBTextSubstitutions["%playerhealth"] = function()
	return math.floor(UnitHealth("player")/UnitHealthMax("player") * 100)
end
FBTextSubstitutions["%party1health"] = function()
	return math.floor(UnitHealth("party1")/UnitHealthMax("party1") * 100)
end
FBTextSubstitutions["%party2health"] = function()
	return math.floor(UnitHealth("party2")/UnitHealthMax("party2") * 100)
end
FBTextSubstitutions["%party3health"] = function()
	return math.floor(UnitHealth("party3")/UnitHealthMax("party3") * 100)
end
FBTextSubstitutions["%party4health"] = function()
	return math.floor(UnitHealth("party4")/UnitHealthMax("party4") * 100)
end
FBTextSubstitutions["%pethealth"] = function()
	return math.floor(UnitHealth("pet")/UnitHealthMax("pet") * 100)
end
FBTextSubstitutions["%targethealth"] = function()
	return math.floor(UnitHealth("target")/UnitHealthMax("target") * 100)
end
FBTextSubstitutions["%playermana"] = function()
	return math.floor(UnitMana("player")/UnitManaMax("player") * 100)
end
FBTextSubstitutions["%party1mana"] = function()
	return math.floor(UnitMana("party1")/UnitManaMax("party1") * 100)
end
FBTextSubstitutions["%party2mana"] = function()
	return math.floor(UnitMana("party2")/UnitManaMax("party2") * 100)
end
FBTextSubstitutions["%party3mana"] = function()
	return math.floor(UnitMana("party3")/UnitManaMax("party3") * 100)
end
FBTextSubstitutions["%party4mana"] = function()
	return math.floor(UnitMana("party4")/UnitManaMax("party4") * 100)
end
FBTextSubstitutions["%petmana"] = function()
	return math.floor(UnitMana("pet")/UnitManaMax("pet") * 100)
end
FBTextSubstitutions["%targetmana"] = function()
	return math.floor(UnitMana("target")/UnitManaMax("target") * 100)
end
FBTextSubstitutions["%combopts"] = function()
	return GetComboPoints()
end
FBTextSubstitutions["%allbagsnumslots"] = function()
	return FBBagContents["allbagsnumslots"]
end
FBTextSubstitutions["%allbagsnumslotsused"] = function()
	return FBBagContents["allbagsnumslotsused"]
end
FBTextSubstitutions["%allbagsnumslotsleft"] = function()
	return FBBagContents["allbagsnumslotsleft"]
end
FBTextSubstitutions["%backpacknumslots"] = function()
	return FBBagContents["backpacknumslots"]
end
FBTextSubstitutions["%backpacknumslotsused"] = function()
	return FBBagContents["backpacknumslotsused"]
end
FBTextSubstitutions["%backpacknumslotsleft"] = function()
	return FBBagContents["backpacknumslotsleft"]
end
FBTextSubstitutions["%bag1numslots"] = function()
	return FBBagContents["bag1numslots"]
end
FBTextSubstitutions["%bag1numslotsused"] = function()
	return FBBagContents["bag1numslotsused"]
end
FBTextSubstitutions["%bag1numslotsleft"] = function()
	return FBBagContents["bag1numslotsleft"]
end
FBTextSubstitutions["%bag2numslots"] = function()
	return FBBagContents["bag2numslots"]
end
FBTextSubstitutions["%bag2numslotsused"] = function()
	return FBBagContents["bag2numslotsused"]
end
FBTextSubstitutions["%bag2numslotsleft"] = function()
	return FBBagContents["bag2numslotsleft"]
end
FBTextSubstitutions["%bag3numslots"] = function()
	return FBBagContents["bag3numslots"]
end
FBTextSubstitutions["%bag3numslotsused"] = function()
	return FBBagContents["bag3numslotsused"]
end
FBTextSubstitutions["%bag3numslotsleft"] = function()
	return FBBagContents["bag3numslotsleft"]
end
FBTextSubstitutions["%bag4numslots"] = function()
	return FBBagContents["bag4numslots"]
end
FBTextSubstitutions["%bag4numslotsused"] = function()
	return FBBagContents["bag4numslotsused"]
end
FBTextSubstitutions["%bag4numslotsleft"] = function()
	return FBBagContents["bag4numslotsleft"]
end
FBTextSubstitutions["%fbs"] = function()
	-- Replace %fbs with the source of the last event
	if FBLastSource then	
		return FBLastSource
	else
		return ""
	end
end
FBTextSubstitutions["%fbe"] = function()
	-- Replace %fbe with the last event
	return FBLastEvent
end

