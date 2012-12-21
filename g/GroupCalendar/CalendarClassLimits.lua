function CalendarClassLimits_Open(pLimits, pTitle, pShowPriority, pSaveFunction)
	CalendarClassLimitsFrame.mSaveFunction = pSaveFunction;
	CalendarClassLimitsFrameTitle:SetText(pTitle);
	
	CalendarClassLimits_UpdateFields(pLimits);
	
	if pShowPriority then
		CalendarClassLimitsFramePriority:Show();
	else
		CalendarClassLimitsFramePriority:Hide();
	end
	
	CalendarClassLimitsFrame:Show();
end

function CalendarClassLimits_Done()
	if CalendarClassLimitsFrame.mSaveFunction then
		CalendarClassLimitsFrame.mSaveFunction(CalendarClassLimits_GetLimits());
	end
	
	CalendarClassLimitsFrame:Hide();
end

function CalendarClassLimits_Cancel()
	CalendarClassLimitsFrame:Hide();
end

function CalendarClassLimits_UpdateFields(pLimits)
	for vClassCode, vClassInfo in gGroupCalendar_ClassInfoByClassCode do
		local	vClassFieldName = "CalendarClassLimitsFrame"..vClassInfo.element;
		local	vClassMin = getglobal(vClassFieldName.."Min");
		local	vClassMax = getglobal(vClassFieldName.."Max");
		local	vClassLimit = nil;
		
		if pLimits
		and pLimits.mClassLimits then
			vClassLimit = pLimits.mClassLimits[vClassCode];
		end
		
		if vClassLimit then
			if vClassLimit.mMin then
				vClassMin:SetText(vClassLimit.mMin);
			else
				vClassMin:SetText("");
			end
			
			if vClassLimit.mMax then
				vClassMax:SetText(vClassLimit.mMax);
			else
				vClassMax:SetText("");
			end
		else
			vClassMin:SetText("");
			vClassMax:SetText("");
		end
	end
	
	if pLimits
	and pLimits.mMaxAttendance then
		CalendarDropDown_SetSelectedValue(CalendarClassLimitsFrameMaxPartySize, pLimits.mMaxAttendance);
	else
		CalendarDropDown_SetSelectedValue(CalendarClassLimitsFrameMaxPartySize, 0);
	end

	if pLimits
	and pLimits.mPriorityOrder then
		CalendarDropDown_SetSelectedValue(CalendarClassLimitsFramePriorityValue, pLimits.mPriorityOrder);
	else
		CalendarDropDown_SetSelectedValue(CalendarClassLimitsFramePriorityValue, "Date");
	end
end

function CalendarClassLimits_GetLimits()
	local	vLimits = {};
	
	for vClassCode, vClassInfo in gGroupCalendar_ClassInfoByClassCode do
		local	vClassFieldName = "CalendarClassLimitsFrame"..vClassInfo.element;
		local	vClassMin = tonumber(getglobal(vClassFieldName.."Min"):GetText());
		local	vClassMax = tonumber(getglobal(vClassFieldName.."Max"):GetText());
		
		if vClassMin or vClassMax then
			if not vLimits.mClassLimits then
				vLimits.mClassLimits = {};
			end
			
			vLimits.mClassLimits[vClassCode] = {mMin = vClassMin, mMax = vClassMax};
		end
	end
	
	vLimits.mMaxAttendance = UIDropDownMenu_GetSelectedValue(CalendarClassLimitsFrameMaxPartySize);
	
	if vLimits.mMaxAttendance == 0 then
		vLimits.mMaxAttendance = nil;
	end
	
	vLimits.mPriorityOrder = UIDropDownMenu_GetSelectedValue(CalendarClassLimitsFramePriorityValue);
	
	if vLimits.mPriorityOrder == "Date" then
		vLimits.mPriorityOrder = nil;
	end
	
	-- See if the mLimits field should just be removed altogether
	
	if Calendar_ArrayIsEmpty(vLimits) then
		vLimits = nil;
	end
	
	-- Done
	
	return vLimits;
end

function CalendarClassLimits_ClassLimitsChanged(pOldLimits, pNewLimits)
	-- If there are no new limits then just see if there were old ones
	
	if not pNewLimits then
		return pOldLimits ~= nil;
	end
	
	-- If there were no limits previous then just notify that there are now
	
	if not pOldLimits then
		return true;
	end
	
	-- See if anything is different between the two
	
	if pNewLimits.mMaxAttendance ~= pOldLimits.mMaxAttendance then
		return true;
	end
	
	-- No differences if neither had class limits
	
	if not pNewLimits.mClassLimits
	and not pOldLimits.mClassLimits then
		return false;
	end
	
	-- New class limits if one has them when the other didn't
	
	if (pNewLimits.mClassLimits == nil)
	~= (pOldLimits.mClassLimits == nil) then
		return true;
	end
	
	-- Compare the limits
	
	for vClassCode, vClassInfo in gGroupCalendar_ClassInfoByClassCode do
		local	vNewClassLimits = pNewLimits.mClassLimits[vClassCode];
		local	vOldClassLimits = pOldLimits.mClassLimits[vClassCode];
		
		if (vNewClassLimits == nil)
		~= (vOldClassLimits == nil) then
			return true;
		end
		
		if vNewClassLimits then
			if vNewClassLimits.mMin ~= vOldClassLimits.mMin
			or vNewClassLimits.mMax ~= vOldClassLimits.mMax then
				return true;
			end
		end
	end
	
	-- Done
	
	return false;
end

function CalendarClassLimits_OnShow(pAutoConfirmFrame)
	local	vFrameName = this:GetName();
	local	vPaladinsFrame = getglobal(vFrameName.."Paladin");
	local	vShamansFrame = getglobal(vFrameName.."Shaman");
	
	if gGroupCalendar_PlayerFactionGroup == "Alliance" then
		vPaladinsFrame:Show();
		vShamansFrame:Hide();
	else
		vPaladinsFrame:Hide();
		vShamansFrame:Show();
	end
	
	CalendarClassLimits_MinTotalChanged(pAutoConfirmFrame);
end

function CalendarClassLimits_MinTotalChanged(pAutoConfirmFrame)
	local	vMinTotal = nil;

	local	vChanged = false;
	
	for vClassCode, vClassInfo in gGroupCalendar_ClassInfoByClassCode do
		local	vClassFieldName = "CalendarClassLimitsFrame"..vClassInfo.element;
		local	vClassMin = tonumber(getglobal(vClassFieldName.."Min"):GetText());
		
		if vClassMin then
			if not vMinTotal then
				vMinTotal = vClassMin;
			else
				vMinTotal = vMinTotal + vClassMin;
			end
		end
	end
	
	local	vMinTotalField = getglobal(pAutoConfirmFrame:GetName().."MaxPartySizeMin");
	
	if vMinTotal then
		vMinTotalField:SetText(vMinTotal);
	else
		vMinTotalField:SetText(GroupCalendar_cNoMinimum);
	end
	
	return vChanged;
end

