--[[ Get Settings ]]--

--show tooltips
function BActionSets_SetTooltips(enable)
	if enable then
		BActionSets.g.tooltips = 1;
	else
		BActionSets.g.tooltips = nil;
	end
end

function BActionSets_TooltipsShown()
	return BActionSets.g.tooltips;
end

--lock button positions
function BActionSets_SetButtonsLocked(enable)
	if enable then
		BActionSets.g.buttonsLocked = 1;
	else
		BActionSets.g.buttonsLocked = nil;
	end
end

function BActionSets_ButtonsLocked()
	return BActionSets.g.buttonsLocked;
end

--show empty buttons
function BActionSets_SetShowGrid(enable)
	if enable then
		BActionSets.g.showGrid = 1;
		if PetHasActionBar() then
			BPetBar_ForAllButtons(BPetButton.ShowGrid);
		end
		BActionMain_ForAllButtons(BActionButton.ShowGrid);
	else
		BActionSets.g.showGrid = nil;
		if PetHasActionBar() then
			BPetBar_ForAllButtons(BPetButton.HideGrid);
		end
		BActionMain_ForAllButtons(BActionButton.HideGrid);
	end
end

function BActionSets_ShowGrid()
	return BActionSets.g.showGrid;
end

--show hotkeys
function BActionSets_SetHotkeys(enable)
	if enable then
		BActionSets.g.hideHotkeys = nil;
	else
		BActionSets.g.hideHotkeys = 1;
	end
	BActionMain_ForAllButtons(BBasicActionButton.ShowHotkey, enable);
	BPetBar_ForAllButtons(BBasicActionButton.ShowHotkey, enable);
	BClassBar_ForAllButtons(BBasicActionButton.ShowHotkey, enable);
end

function BActionSets_HotkeysShown()
	return not BActionSets.g.hideHotkeys;
end

--show macro text
function BActionSets_SetMacroText(enable)
	if enable then
		BActionSets.g.hideMacroText = nil;
	else
		BActionSets.g.hideMacroText = 1;
	end
	BActionMain_ForAllButtons(BActionButton.ShowMacroText, enable)
end

function BActionSets_MacrosShown()
	return not BActionSets.g.hideMacroText;
end

--[[ Actionbar Specific Settings ]]--

--set the key to pick up buttons
function BActionSets_SetQuickMoveMode(mode)
	BActionSets.g.quickMove = mode;
end

function BActionSets_GetQuickMoveMode()
	return BActionSets.g.quickMove;
end

function BActionSets_IsQuickMoveKeyDown()
	local quickMoveKey = BActionSets.g.quickMove;
	
	if quickMoveKey then
		if quickMoveKey == 1 and IsShiftKeyDown() then
			return true;
		end
		if quickMoveKey == 2 and IsControlKeyDown() then
			return true;
		end
		return quickMoveKey == 3 and IsAltKeyDown();
	end
	return false;
end

--set a key to use for altcast
function BActionSets_SetSelfCastMode(mode)
	BActionSets.g.altCast = mode;
end

function BActionSets_IsSelfCastHotkeyDown()
	local altCastKey = BActionSets.g.altCast;
	
	if altCastKey then
		if altCastKey == 1 and IsAltKeyDown() then
			return true;
		end
		if altCastKey == 2 and IsControlKeyDown() then
			return true;
		end
		return altCastKey == 3 and IsShiftKeyDown();
	end
	return false;
end

function BActionSets_GetSelfCastMode()
	return BActionSets.g.altCast;
end

--set range color
function BActionSets_SetColorOutOfRange(enable)
	if enable then
		BActionSets.g.colorOutOfRange = 1;
	else
		BActionSets.g.colorOutOfRange = nil;
	end
	BActionMain_ForAllShownButtons(BActionButton.UpdateUsable);
end

function BActionSets_ColorOutOfRange()
	return BActionSets.g.colorOutOfRange;
end

function BActionSets_SetRangeColor(red, green, blue)
	if red and green and blue then
		BActionSets.g.rangeColor = { r = red, g = green, b = blue};
	end
end

function BActionSets_GetRangeColor()
	return BActionSets.g.rangeColor;
end