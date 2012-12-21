
function RecapPanel_Populate(arg1)

	local i,totalmeleemiss,text,found

	if recap.Combatant[arg1] and not recap.Opt.LightData.value then

		--[[ Populate Panel 1: Incoming ]]

		-- melee damage
		RecapPanelMeleeDamageText:SetText(recap.Combatant[arg1].Incoming.MeleeDamage or 0)
		RecapPanelNonMeleeDamageText:SetText(recap.Combatant[arg1].Incoming.NonMeleeDamage or 0)
		i = (recap.Combatant[arg1].Incoming.MeleeDamage or 0) + (recap.Combatant[arg1].Incoming.NonMeleeDamage or 0)
		if i>0 then
			RecapPanelMeleeDamagePText:SetText(string.format("%d%%",100*(recap.Combatant[arg1].Incoming.MeleeDamage or 0)/i))
			RecapPanelNonMeleeDamagePText:SetText(string.format("%d%%",100*(recap.Combatant[arg1].Incoming.NonMeleeDamage or 0)/i))
		else
			RecapPanelMeleeDamagePText:SetText("--")
			RecapPanelNonMeleeDamagePText:SetText("--")
		end

		-- melee misses
		totalmeleemiss = (recap.Combatant[arg1].Incoming.MeleeMissed or 0) + (recap.Combatant[arg1].Incoming.MeleeBlocked or 0) + (recap.Combatant[arg1].Incoming.MeleeDodged or 0) + (recap.Combatant[arg1].Incoming.MeleeParried or 0)
		RecapPanelMeleeHitsText:SetText(recap.Combatant[arg1].Incoming.MeleeHits or 0)
		RecapPanelMeleeMissedText:SetText(totalmeleemiss)
		RecapPanelMeleeCritsText:SetText(recap.Combatant[arg1].Incoming.MeleeCrits or 0)
		i = (recap.Combatant[arg1].Incoming.MeleeHits or 0) + totalmeleemiss + (recap.Combatant[arg1].Incoming.MeleeCrits or 0)
		if i>0 then
			RecapPanelMeleeMissedPText:SetText(string.format("%.1f%%",100*totalmeleemiss/i))
		else
			RecapPanelMeleeMissedPText:SetText("--")
		end

		-- melee hits/crits %
		i = i - totalmeleemiss
		if i>0 then
			RecapPanelMeleeCritsPText:SetText(string.format("%.1f%%",100*(recap.Combatant[arg1].Incoming.MeleeCrits or 0)/i))
		else
			RecapPanelMeleeCritsPText:SetText("--")
		end

		RecapPanelNonMeleeHitsText:SetText(recap.Combatant[arg1].Incoming.NonMeleeHits or 0)
		RecapPanelNonMeleeMissedText:SetText(recap.Combatant[arg1].Incoming.NonMeleeMissed or 0)
		RecapPanelNonMeleeCritsText:SetText(recap.Combatant[arg1].Incoming.NonMeleeCrits or 0)
		i = (recap.Combatant[arg1].Incoming.NonMeleeHits or 0) + (recap.Combatant[arg1].Incoming.NonMeleeMissed or 0) + (recap.Combatant[arg1].Incoming.NonMeleeCrits or 0)
		if i>0 then
			RecapPanelNonMeleeMissedPText:SetText(string.format("%.1f%%",100*(recap.Combatant[arg1].Incoming.NonMeleeMissed or 0)/i))
		else
			RecapPanelNonMeleeMissedPText:SetText("--")
		end

		i = i - (recap.Combatant[arg1].Incoming.NonMeleeMissed or 0)
		if i>0 then
			RecapPanelNonMeleeCritsPText:SetText(string.format("%.1f%%",100*(recap.Combatant[arg1].Incoming.NonMeleeCrits or 0)/i))
		else
			RecapPanelNonMeleeCritsPText:SetText("--")
		end

		RecapPanelMeleeMaxText:SetText(recap.Combatant[arg1].Incoming.MeleeMax or 0)
		RecapPanelNonMeleeMaxText:SetText(recap.Combatant[arg1].Incoming.NonMeleeMax or 0)

		if ((recap.Combatant[arg1].Incoming.MeleeHits or 0)+(recap.Combatant[arg1].Incoming.MeleeCrits or 0))>0 then
			RecapPanelMeleeAvgText:SetText(string.format("%d",(recap.Combatant[arg1].Incoming.MeleeDamage or 0)/((recap.Combatant[arg1].Incoming.MeleeHits or 0)+(recap.Combatant[arg1].Incoming.MeleeCrits or 0))))
		else
			RecapPanelMeleeAvgText:SetText("0")
		end
		if (recap.Combatant[arg1].Incoming.NonMeleeHits or 0)>0 then
			RecapPanelNonMeleeAvgText:SetText(string.format("%d",(recap.Combatant[arg1].Incoming.NonMeleeDamage or 0)/((recap.Combatant[arg1].Incoming.NonMeleeHits or 0)+(recap.Combatant[arg1].Incoming.NonMeleeCrits or 0))))
		else
			RecapPanelNonMeleeAvgText:SetText("0")
		end

		i = totalmeleemiss + (recap.Combatant[arg1].Incoming.MeleeHits or 0) + (recap.Combatant[arg1].Incoming.MeleeCrits or 0)
		if i>0 then
			RecapPanelMissMissedText:SetText(string.format("%d (%.1f%%)",recap.Combatant[arg1].Incoming.MeleeMissed or 0, 100*(recap.Combatant[arg1].Incoming.MeleeMissed or 0)/i))
			RecapPanelMissDodgedText:SetText(string.format("%d (%.1f%%)",recap.Combatant[arg1].Incoming.MeleeDodged or 0, 100*(recap.Combatant[arg1].Incoming.MeleeDodged or 0)/i))
			RecapPanelMissParriedText:SetText(string.format("%d (%.1f%%)",recap.Combatant[arg1].Incoming.MeleeParried or 0, 100*(recap.Combatant[arg1].Incoming.MeleeParried or 0)/i))
			RecapPanelMissBlockedText:SetText(string.format("%d (%.1f%%)",recap.Combatant[arg1].Incoming.MeleeBlocked or 0, 100*(recap.Combatant[arg1].Incoming.MeleeBlocked or 0)/i))
		else
			RecapPanelMissMissedText:SetText("--")
			RecapPanelMissDodgedText:SetText("--")
			RecapPanelMissParriedText:SetText("--")
			RecapPanelMissBlockedText:SetText("--")
		end


		--[[ Populate Panel 2: Outgoing details ]]

		recap_temp.DetailSelected = 0
		RecapPanel_ConstructDetails(arg1)
		if recap_temp.DetailsListSize>1 then
			RecapPanel_PopulateDetails(arg1,1)
		else
			RecapPanel_PopulateDetails(arg1,0)
		end
		RecapPanelOutgoingTotalLabel:SetText(recap.Opt.PanelDetail.value~="Miss" and recap.Opt.PanelDetail.value or "Miss/Over")
		RecapPanelDetailsScrollBar_Update()

	end

	-- populate elements that work in and out of light data mode

	if recap.Combatant[arg1] then

		--[[ Populate common elements ]]
		
		if recap.Combatant[arg1].Faction and recap_temp.FactionIcons[recap.Combatant[arg1].Faction] then
			RecapPanelFaction:SetTexture(recap_temp.FactionIcons[recap.Combatant[arg1].Faction])
		else
			RecapPanelFaction:SetTexture("")
		end

		if recap.Combatant[arg1].Class and recap_temp.ClassIcons[recap.Combatant[arg1].Class] then
			RecapPanelClass:SetTexCoord(recap_temp.ClassIcons[recap.Combatant[arg1].Class].left,recap_temp.ClassIcons[recap.Combatant[arg1].Class].right,recap_temp.ClassIcons[recap.Combatant[arg1].Class].top,recap_temp.ClassIcons[recap.Combatant[arg1].Class].bottom)
		else
			RecapPanelClass:SetTexCoord(.9,1,.9,1)
		end

		if recap.Combatant[arg1].Friend then
			RecapPanelName:SetTextColor(recap_temp.ColorDmgOut.r,recap_temp.ColorDmgOut.g,recap_temp.ColorDmgOut.b)
		else
			RecapPanelName:SetTextColor(1,1,1)
		end
		RecapPanelName:SetText(arg1)

		if recap.Combatant[arg1].Level==-1 then
			RecapPanelLevel:SetText("??")
		elseif tonumber(recap.Combatant[arg1].Level) and tonumber(recap.Combatant[arg1].Level)>0 then
			RecapPanelLevel:SetText(recap.Combatant[arg1].Level)
		else
			RecapPanelLevel:SetText(" ")
		end

		--[[ Populate Panel 3: Summary ]]

		RecapPanelLastTimeText:SetText(Recap_FormatTime(recap.Combatant[arg1].LastTime))
		RecapPanelLastMaxText:SetText(recap.Combatant[arg1].LastMaxHit)
		RecapPanelLastDeathsText:SetText(recap.Combatant[arg1].LastKills)
		RecapPanelLastHealsText:SetText(recap.Combatant[arg1].LastHeal)
		RecapPanelLastDmgInText:SetText(recap.Combatant[arg1].LastDmgIn)
		RecapPanelLastDmgOutText:SetText(recap.Combatant[arg1].LastDmgOut)
		RecapPanelLastDPSText:SetText(string.format("%.1f",recap.Combatant[arg1].LastDPS))

		RecapPanelAllTimeText:SetText(Recap_FormatTime(recap.Combatant[arg1].TotalTime))
		RecapPanelAllMaxText:SetText(recap.Combatant[arg1].TotalMaxHit)
		RecapPanelAllDeathsText:SetText(recap.Combatant[arg1].TotalKills)
		RecapPanelAllHealsText:SetText(recap.Combatant[arg1].TotalHeal)
		RecapPanelAllDmgInText:SetText(recap.Combatant[arg1].TotalDmgIn)
		RecapPanelAllDmgOutText:SetText(recap.Combatant[arg1].TotalDmgOut)
		RecapPanelAllDPSText:SetText(string.format("%.1f",recap.Combatant[arg1].TotalDPS))

		if recap.Combatant[arg1].Friend then
			RecapPanelLastHealsText:SetTextColor(recap_temp.ColorHeal.r,recap_temp.ColorHeal.g,recap_temp.ColorHeal.b)
			RecapPanelAllHealsText:SetTextColor(recap_temp.ColorHeal.r,recap_temp.ColorHeal.g,recap_temp.ColorHeal.b)
			RecapPanelLastDmgInText:SetTextColor(recap_temp.ColorDmgIn.r,recap_temp.ColorDmgIn.g,recap_temp.ColorDmgIn.b)
			RecapPanelAllDmgInText:SetTextColor(recap_temp.ColorDmgIn.r,recap_temp.ColorDmgIn.g,recap_temp.ColorDmgIn.b)
			RecapPanelLastDmgOutText:SetTextColor(recap_temp.ColorDmgOut.r,recap_temp.ColorDmgOut.g,recap_temp.ColorDmgOut.b)
			RecapPanelAllDmgOutText:SetTextColor(recap_temp.ColorDmgOut.r,recap_temp.ColorDmgOut.g,recap_temp.ColorDmgOut.b)
			RecapPanelLastDPSText:SetTextColor(recap_temp.ColorDmgOut.r,recap_temp.ColorDmgOut.g,recap_temp.ColorDmgOut.b)
			RecapPanelAllDPSText:SetTextColor(recap_temp.ColorDmgOut.r,recap_temp.ColorDmgOut.g,recap_temp.ColorDmgOut.b)
		else
			RecapPanelLastHealsText:SetTextColor(1,1,1)
			RecapPanelAllHealsText:SetTextColor(1,1,1)
			RecapPanelLastDmgInText:SetTextColor(1,1,1)
			RecapPanelAllDmgInText:SetTextColor(1,1,1)
			RecapPanelLastDmgOutText:SetTextColor(1,1,1)
			RecapPanelAllDmgOutText:SetTextColor(1,1,1)
			RecapPanelLastDPSText:SetTextColor(1,1,1)
			RecapPanelAllDPSText:SetTextColor(1,1,1)
		end

	end

end

-- tooltips for individual entries
function RecapPanel_Entry_OnEnter()

	id = this:GetID()

	if id and id>0 then
		if this:GetName()=="RecapPanelOutgoingMissP" and RecapPanelOutgoingMissPLabel:GetText()=="Overhealing" then
			Recap_OnTooltip("PanelEntryOverheal",getglobal(this:GetName().."Text"):GetText())
		else
			Recap_OnTooltip("PanelEntry"..id,getglobal(this:GetName().."Text"):GetText())
		end
	end
end

function RecapPanel_Entry_OnClick()

	local id,header,text,sel = this:GetID()

	if id and id>0 and getglobal(this:GetName().."Text"):GetText()~=" " and getglobal(this:GetName().."Text"):GetText()~="--" then
		header = Recap_GetTooltip("PanelEntry"..id)
		if this:GetName()=="RecapPanelOutgoingMissP" and RecapPanelOutgoingMissPLabel:GetText()=="Overhealing" then
			header = "Overhealing"
		end
		if header and IsShiftKeyDown() and ChatFrameEditBox:IsVisible() and recap_temp.Selected~=0 then
			text = recap_temp.List[recap_temp.Selected].Name..recap_temp.Local.Possessive..header
			if id>=45 and id<=56 and recap_temp.DetailsListSize>1 then
				sel = recap_temp.DetailSelected
				if sel==0 then
					sel = 1
				end
				text = text.." for "..string.sub(recap_temp.DetailsList[sel].Effect,2)
			end
			text = text..": "..getglobal(this:GetName().."Text"):GetText()
			Recap_InsertChat(text)
		end
	end
end

function RecapPanel_Show(name)

	if recap.Opt.ShowPanel.value then

		if recap_temp.Selected>0 then
			name = recap_temp.List[recap_temp.Selected].Name
		end

		RecapPanel_Populate(name)
		RecapPanel:Show()
	end
end

function RecapPanel_Hide(arg1)

	if arg1 then
		recap_temp.Selected = 0
		recap_temp.DetailSelected = 0
		RecapScrollBar_Update()		
	end

	if recap_temp.Selected==0 then
		RecapPanel:Hide()
	end
end

function RecapPanelTab_OnEnter()

	local id = this:GetID()

	if id and id>0 then
		if recap.Opt.LightData.value and id<3 then
			Recap_OnTooltip("PanelTabDisabled"..id)
		else
			Recap_OnTooltip("PanelTab"..id)
		end
	end

end

function RecapPanelTab_OnClick()

	local id = this:GetID()
	if recap.Opt.LightData.value then
		id = 3
	end
	recap.Opt.PanelView.value = id
	RecapPanel_SwitchPanels(id)
end

function RecapPanel_SwitchPanels(panel)

	for i=1,3 do
		getglobal("RecapPanelTab"..i):UnlockHighlight()
		getglobal("RecapSubPanel"..i):Hide()
	end
	getglobal("RecapPanelTab"..recap.Opt.PanelView.value):LockHighlight()
	getglobal("RecapSubPanel"..recap.Opt.PanelView.value):Show()
end

function RecapPanel_ConstructDetails(name)

	local dmgtotal, healtotal, subtotal, i = 0,0

	recap_temp.DetailsListSize = 1

	if not recap_temp.DetailsList then
		recap_temp.DetailsList = {}
	end

	for i in recap.Combatant[name].Detail do
		if not recap_temp.DetailsList[recap_temp.DetailsListSize] then
			recap_temp.DetailsList[recap_temp.DetailsListSize] = {}
		end
		recap_temp.DetailsList[recap_temp.DetailsListSize].Effect = i
		recap_temp.DetailsList[recap_temp.DetailsListSize].Total = (recap.Combatant[name].Detail[i].HitsDmg or 0) + (recap.Combatant[name].Detail[i].CritsDmg or 0) + (recap.Combatant[name].Detail[i].TicksDmg or 0)
		recap_temp.DetailsList[recap_temp.DetailsListSize].Max = math.max(recap.Combatant[name].Detail[i].TicksMax or 0,math.max(recap.Combatant[name].Detail[i].HitsMax or 0,recap.Combatant[name].Detail[i].CritsMax or 0))
		subtotal = (recap.Combatant[name].Detail[i].Hits or 0) + (recap.Combatant[name].Detail[i].Crits or 0)
		recap_temp.DetailsList[recap_temp.DetailsListSize].Avg = string.format("%d",(subtotal>0 and (((recap.Combatant[name].Detail[i].HitsDmg or 0)+(recap.Combatant[name].Detail[i].CritsDmg or 0)+(recap.Combatant[name].Detail[i].TicksDmg or 0))/subtotal) or 0))
		subtotal = recap.Combatant[name].Detail[i].CritsEvents or 0
		if subtotal>0 then
			recap_temp.DetailsList[recap_temp.DetailsListSize].Crits = string.format("%.1f%%",100*(recap.Combatant[name].Detail[i].Crits or 0)/subtotal)
		else
			recap_temp.DetailsList[recap_temp.DetailsListSize].Crits = "--"
		end
		
		if tonumber(string.sub(i,1,1))<3 then
			dmgtotal = dmgtotal + recap_temp.DetailsList[recap_temp.DetailsListSize].Total
			subtotal = (recap.Combatant[name].Detail[i].Hits or 0) + (recap.Combatant[name].Detail[i].Crits or 0) + (recap.Combatant[name].Detail[i].Missed or 0)
		else
			healtotal = healtotal + recap_temp.DetailsList[recap_temp.DetailsListSize].Total
			subtotal = (recap.Combatant[name].Detail[i].HitsDmg or 0) + (recap.Combatant[name].Detail[i].CritsDmg or 0) + (recap.Combatant[name].Detail[i].Missed or 0) + (recap.Combatant[name].Detail[i].TicksDmg or 0)
		end
		recap_temp.DetailsList[recap_temp.DetailsListSize].Miss = string.format("%.1f%%",(subtotal>0 and (100*(recap.Combatant[name].Detail[i].Missed or 0)/subtotal) or 0))

		recap_temp.DetailsListSize = recap_temp.DetailsListSize + 1
	end
	recap_temp.DetailsList[recap_temp.DetailsListSize] = nil

	for i=1,recap_temp.DetailsListSize-1 do
		if tonumber(string.sub(recap_temp.DetailsList[i].Effect,1,1))<3 then
			subtotal = dmgtotal
		else
			subtotal = healtotal
		end
		if subtotal>0 then
			recap_temp.DetailsList[i].TotalP = math.floor((100*recap_temp.DetailsList[i].Total)/subtotal+.5)
		else
			recap_temp.DetailsList[i].TotalP = 0
		end			
	end

	table.sort(recap_temp.DetailsList,RecapPanel_DetailsDamageSort)

end

function RecapPanel_DetailsDamageSort(e1,e2)

	local effect1,effect2 = string.sub(e1.Effect,1,1),string.sub(e2.Effect,1,1)

	if e1 and e2 and ( ((e1.Total>e2.Total) and (effect1==effect2)) or (effect1<effect2) ) then
		return true
	else
		return false
	end
end

function RecapPanelDetailsScrollBar_Update()

	local i, index, item,r,g,b

	if recap_temp.Loaded and recap_temp.DetailsListSize then

		FauxScrollFrame_Update(RecapPanelDetailsScrollBar,recap_temp.DetailsListSize-1,5,5)

		for i=1,5 do
			index = i + FauxScrollFrame_GetOffset(RecapPanelDetailsScrollBar)
			if index < recap_temp.DetailsListSize then
				if string.sub(recap_temp.DetailsList[index].Effect,1,1)=="3" then
					r,g,b = recap_temp.ColorHeal.r, recap_temp.ColorHeal.g, recap_temp.ColorHeal.b
				else
					r,g,b = recap_temp.ColorDmgOut.r, recap_temp.ColorDmgOut.g, recap_temp.ColorDmgOut.b
				end
				getglobal("RecapPanelDetail"..i.."_Name"):SetText(string.sub(recap_temp.DetailsList[index].Effect,2))
				getglobal("RecapPanelDetail"..i.."_Name"):SetTextColor(r,g,b)
				getglobal("RecapPanelDetail"..i.."_Total"):SetText(recap_temp.DetailsList[index][recap.Opt.PanelDetail.value])
				if recap.Opt.PanelDetail.value=="Total" then
					getglobal("RecapPanelDetail"..i.."_Total"):SetTextColor(r,g,b)
				else
					getglobal("RecapPanelDetail"..i.."_Total"):SetTextColor(recap_temp.ColorWhite.r,recap_temp.ColorWhite.g,recap_temp.ColorWhite.b)
				end
				getglobal("RecapPanelDetail"..i.."_TotalP"):SetText(recap_temp.DetailsList[index].TotalP.."%")
				getglobal("RecapPanelDetail"..i.."_TotalP"):SetTextColor(r,g,b)
				item = getglobal("RecapPanelDetail"..i)
				item:Show()
				if recap_temp.DetailSelected == index then
					item:LockHighlight()
				else
					item:UnlockHighlight()
				end
			else
				item = getglobal("RecapPanelDetail"..i)
				item:Hide()
				item:UnlockHighlight()
			end
		end
	end

end

function RecapPanel_PopulateDetails(arg1,sel)

	local effect,i
	RecapPanelOutgoingDamageText:SetText(" ")
	RecapPanelOutgoingHitsText:SetText("--")
	RecapPanelOutgoingCritsText:SetText("--")
	RecapPanelOutgoingHitsAvgText:SetText("--")
	RecapPanelOutgoingCritsAvgText:SetText("--")
	RecapPanelOutgoingHitsMaxText:SetText("--")
	RecapPanelOutgoingCritsMaxText:SetText("--")
	RecapPanelOutgoingTicksText:SetText("--")
	RecapPanelOutgoingTicksAvgText:SetText("--")
	RecapPanelOutgoingTicksMaxText:SetText("--")
	RecapPanelOutgoingMissPText:SetText(" ")
	RecapPanelOutgoingCritPText:SetText("--")

	if sel>0 and recap_temp.DetailsList[sel].Effect and recap.Combatant[arg1] then
		effect = recap_temp.DetailsList[sel].Effect
		if string.sub(effect,1,1)=="3" then
			RecapPanelOutgoingDamageLabel:SetText("Heal")
			RecapPanelOutgoingMissPLabel:SetText("Overhealing")
		else
			RecapPanelOutgoingDamageLabel:SetText("Damage")
			RecapPanelOutgoingMissPLabel:SetText("Misses")
		end
		RecapPanelOutgoingDamageText:SetText((recap.Combatant[arg1].Detail[effect].HitsDmg or 0)+(recap.Combatant[arg1].Detail[effect].CritsDmg or 0)+(recap.Combatant[arg1].Detail[effect].TicksDmg or 0))

		-- hits: critsevents-crits
		i = (recap.Combatant[arg1].Detail[effect].CritsEvents or 0)-(recap.Combatant[arg1].Detail[effect].Crits or 0)
		if i>0 then
			RecapPanelOutgoingHitsText:SetText(i)
			RecapPanelOutgoingHitsMaxText:SetText(recap.Combatant[arg1].Detail[effect].HitsMax or 0)
			RecapPanelOutgoingHitsAvgText:SetText(string.format("%d",(recap.Combatant[arg1].Detail[effect].HitsDmg or 0)/i))
		elseif recap.Combatant[arg1].Detail[effect].CritsEvents then
			RecapPanelOutgoingHitsText:SetText("0")
		end

		-- crits
		if (recap.Combatant[arg1].Detail[effect].Crits or 0)>0 then
			RecapPanelOutgoingCritsText:SetText(recap.Combatant[arg1].Detail[effect].Crits or 0)
			RecapPanelOutgoingCritsMaxText:SetText(recap.Combatant[arg1].Detail[effect].CritsMax or 0)
			RecapPanelOutgoingCritsAvgText:SetText(string.format("%d",(recap.Combatant[arg1].Detail[effect].CritsDmg or 0)/recap.Combatant[arg1].Detail[effect].Crits))
		elseif recap.Combatant[arg1].Detail[effect].CritsEvents then
			RecapPanelOutgoingCritsText:SetText("0")
		end

		-- ticks
		i = (recap.Combatant[arg1].Detail[effect].Hits or 0)-(recap.Combatant[arg1].Detail[effect].CritsEvents or 0)
		if i>0 then
			RecapPanelOutgoingTicksText:SetText(i)
			RecapPanelOutgoingTicksMaxText:SetText(recap.Combatant[arg1].Detail[effect].TicksMax or 0)
			RecapPanelOutgoingTicksAvgText:SetText(string.format("%d",(recap.Combatant[arg1].Detail[effect].TicksDmg or 0)/i))
		elseif recap.Combatant[arg1].Detail[effect].TicksMax then
			RecapPanelOutgoingTicksText:SetText("0")
		end

		-- miss/overheal %
		if string.sub(effect,1,1)~="3" then
			i = (recap.Combatant[arg1].Detail[effect].Hits or 0)+(recap.Combatant[arg1].Detail[effect].Crits or 0)+(recap.Combatant[arg1].Detail[effect].Missed or 0)
			if i>0 then
				RecapPanelOutgoingMissPText:SetText(((recap.Combatant[arg1].Detail[effect].Missed==i) and (i.." (100%)")) or string.format("%d (%.1f%%)",recap.Combatant[arg1].Detail[effect].Missed or 0,100*(recap.Combatant[arg1].Detail[effect].Missed or 0)/i))
			end
		else
			i = (recap.Combatant[arg1].Detail[effect].HitsDmg or 0)+(recap.Combatant[arg1].Detail[effect].CritsDmg or 0)+(recap.Combatant[arg1].Detail[effect].Missed or 0)+(recap.Combatant[arg1].Detail[effect].TicksDmg or 0)
			if i>0 then
				RecapPanelOutgoingMissPText:SetText(string.format("%d (%d%%)",recap.Combatant[arg1].Detail[effect].Missed or 0,100*(recap.Combatant[arg1].Detail[effect].Missed or 0)/i))
			end
		end

		-- crit %
		if (recap.Combatant[arg1].Detail[effect].CritsEvents or 0)>0 then
			RecapPanelOutgoingCritPText:SetText(((recap.Combatant[arg1].Detail[effect].CritsEvents==recap.Combatant[arg1].Detail[effect].Crits) and "100%") or string.format("%.1f%%",100*(recap.Combatant[arg1].Detail[effect].Crits or 0)/recap.Combatant[arg1].Detail[effect].CritsEvents))
		end

	end

end

function RecapPanel_Detail_OnEnter()

	local id = this:GetID()
	local index = id + FauxScrollFrame_GetOffset(RecapPanelDetailsScrollBar)

	if (index<recap_temp.DetailsListSize) and recap_temp.DetailSelected==0 then
		RecapPanel_PopulateDetails(RecapPanelName:GetText(),index)
	end
end

function RecapPanel_Detail_OnLeave()

	if recap_temp.DetailSelected==0 then
		RecapPanel_PopulateDetails(nil,0)
	end
end

function RecapPanel_Detail_OnClick()

	local id = this:GetID()
	local index = id + FauxScrollFrame_GetOffset(RecapPanelDetailsScrollBar)
	local linkformat = recap_temp.Local.DamageDetailLink

	if IsShiftKeyDown() and index<recap_temp.DetailsListSize and ChatFrameEditBox:IsVisible() then

		if string.sub(recap_temp.DetailsList[index].Effect,1,1)=="3" then
			linkformat = recap_temp.Local.HealDetailLink
		end
		ChatFrameEditBox:Insert(string.format(linkformat,RecapPanelName:GetText(),
												getglobal("RecapPanelDetail"..id.."_Name"):GetText(),
												recap_temp.DetailsList[index].Total,
												getglobal("RecapPanelDetail"..id.."_TotalP"):GetText() ))
    elseif recap_temp.DetailSelected==index then
		recap_temp.DetailSelected = 0
		RecapPanelDetailsScrollBar_Update()
		RecapPanel_PopulateDetails(nil,0)
	else
		recap_temp.DetailSelected = index
		RecapPanel_PopulateDetails(RecapPanelName:GetText(),index)
		RecapPanelDetailsScrollBar_Update()
	end
end

function RecapPanel_OnMouseDown(arg1)

	if recap_temp.Loaded and not recap.Opt.Pinned.value and arg1=="LeftButton" then
		RecapPanel:StartMoving()
	end
end

function RecapPanel_OnMouseUp(arg1)

	if recap_temp.Loaded and not recap.Opt.Pinned.value and arg1=="LeftButton" then
		RecapPanel:StopMovingOrSizing()

		-- check for docking
		recap.Opt.PanelAnchor.value = false

		if Recap_Near(RecapFrame:GetRight(),RecapPanel:GetLeft()) then
		    if Recap_Near(RecapFrame:GetTop(),RecapPanel:GetTop()) then
				recap.Opt.PanelAnchor = { type="Flag", value=true, Main="TOPRIGHT", Panel="TOPLEFT" }
		    elseif Recap_Near(RecapFrame:GetBottom(),RecapPanel:GetBottom()) then
				recap.Opt.PanelAnchor = { type="Flag", value=true, Main="BOTTOMRIGHT", Panel="BOTTOMLEFT"}
		    end
		elseif Recap_Near(RecapFrame:GetLeft(),RecapPanel:GetRight()) then
		    if Recap_Near(RecapFrame:GetTop(),RecapPanel:GetTop()) then
				recap.Opt.PanelAnchor = { type="Flag", value=true, Main="TOPLEFT", Panel="TOPRIGHT" }
		    elseif Recap_Near(RecapFrame:GetBottom(),RecapPanel:GetBottom()) then
				recap.Opt.PanelAnchor = { type="Flag", value=true, Main="BOTTOMLEFT", Panel="BOTTOMRIGHT" }
		    end
		elseif Recap_Near(RecapFrame:GetRight(),RecapPanel:GetRight()) then
		    if Recap_Near(RecapFrame:GetTop(),RecapPanel:GetBottom()) then
				recap.Opt.PanelAnchor = { type="Flag", value=true, Main="TOPRIGHT", Panel="BOTTOMRIGHT" }
		    elseif Recap_Near(RecapFrame:GetBottom(),RecapPanel:GetTop()) then
				recap.Opt.PanelAnchor = { type="Flag", value=true, Main="BOTTOMRIGHT", Panel="TOPRIGHT" }
		    end
		elseif Recap_Near(RecapFrame:GetLeft(),RecapPanel:GetLeft()) then
		    if Recap_Near(RecapFrame:GetTop(),RecapPanel:GetBottom()) then
				recap.Opt.PanelAnchor = { type="Flag", value=true, Main="TOPLEFT", Panel="BOTTOMLEFT" }
		    elseif Recap_Near(RecapFrame:GetBottom(),RecapPanel:GetTop()) then
				recap.Opt.PanelAnchor = { type="Flag", value=true, Main="BOTTOMLEFT", Panel="TOPLEFT" }
		    end
		end

		if recap.Opt.PanelAnchor.value then
			RecapPanel:ClearAllPoints()
			RecapPanel:SetPoint(recap.Opt.PanelAnchor.Panel,"RecapFrame",recap.Opt.PanelAnchor.Main,Recap_PanelOffset("x"),Recap_PanelOffset("y"))
		end

	end
end

function Recap_PanelOffset(arg1)

	local anchor
	local dockoffset = { ["TOPRIGHTTOPLEFT"] = { x=-4,y=0 },
						 ["BOTTOMRIGHTBOTTOMLEFT"] = { x=-4,y=0 },
						 ["TOPLEFTTOPRIGHT"] = { x=4,y=0 },
						 ["BOTTOMLEFTBOTTOMRIGHT"] = { x=4,y=0 },
						 ["TOPRIGHTBOTTOMRIGHT"] = { x=0,y=-4 },
						 ["BOTTOMRIGHTTOPRIGHT"] = { x=0,y=4 },
						 ["TOPLEFTBOTTOMLEFT"] = { x=0,y=-4 },
						 ["BOTTOMLEFTTOPLEFT"] = { x=0,y=4 } }

	anchor = recap.Opt.PanelAnchor.Main..recap.Opt.PanelAnchor.Panel
	if dockoffset[anchor] and arg1 then
		return dockoffset[anchor][arg1]
	else
		return 0
	end
end

-- returns true if the two values are close to each other
function Recap_Near(arg1,arg2)

    local isnear = false

    if (math.max(arg1,arg2)-math.min(arg1,arg2)) < 15 then
	isnear = true
    end

    return isnear
end

function RecapDetailHeader_OnMouseUp(arg1)

	if arg1=="RightButton" then
		RecapCreateMenu(recap_temp.DetailMenu)
	end
end

-- this substitutes ChatFrameEditBox:Insert.  If 'msg' will fit in the current editbox,
-- it will :Insert.  If not, it will automatically send 'msg' over the current chatType
-- across as many lines as needed, breaking lines by 'delimiter', a single-character
-- string.  (if no delimiter is given it will use "]").  If a delimeter isn't found, it
-- will hard-break every 255 characters.
function Recap_InsertChat(msg,delimiter)

	local channel,chatnumber = ChatFrameEditBox.chatType
	local cx,i,m_start,m_end,done

	delimiter = string.sub(delimiter or "]",1,1)

	if channel=="WHISPER" then
		chatnumber = ChatFrameEditBox.tellTarget
	elseif channel=="CHANNEL" then
		chatnumber = ChatFrameEditBox.channelTarget
	end

	cx = string.len(ChatFrameEditBox:GetText())

	if cx+string.len(msg)<255 then
		ChatFrameEditBox:Insert(msg)
	else
		if cx>0 then
			SendChatMessage(ChatFrameEditBox:GetText(),channel,nil,chatnumber)
			ChatFrameEditBox:SetText("")
		end
				
		cx = string.len(msg)
		m_start = 1

		while not done do
			m_end = nil
			for i=m_start,cx do
				if ((string.sub(msg,i,i)==delimiter and (i-m_start)<255)) or ((i-m_start<255) and i==cx) then
					m_end = i
				end
				if (i-m_start)>254 and not m_end then
					m_end = i
				end
			end
			SendChatMessage(string.sub(msg,m_start,m_end),channel,nil,chatnumber)
			m_start = m_end+1
			if m_start>cx then
				done = true
			end
		end
	end

end


function RecapDetailHeader_OnClick()

	local text,alltext = "",""
	local channel,chatnumber = ChatFrameEditBox.chatType

	if IsShiftKeyDown() and ChatFrameEditBox:IsVisible() and recap_temp.Selected~=0 then

		if channel=="WHISPER" then
			chatnumber = ChatFrameEditBox.tellTarget
		elseif channel=="CHANNEL" then
			chatnumber = ChatFrameEditBox.channelTarget
		end

		alltext = (recap.Opt.SpamRows.value and "__ " or "")..recap_temp.List[recap_temp.Selected].Name.."'s "..Recap_GetTooltip(recap.Opt.PanelDetail.value)..(recap.Opt.SpamRows.value and " __" or ":")
		if recap.Opt.SpamRows.value then
			SendChatMessage(alltext,channel,nil,chatnumber)
		end
		for i=1,recap_temp.DetailsListSize-1 do
			if recap_temp.DetailsList[i][recap.Opt.PanelDetail.value]~="0.0%" and recap_temp.DetailsList[i][recap.Opt.PanelDetail.value]~="--" then
				text = string.sub(recap_temp.DetailsList[i].Effect,2)..(string.sub(recap_temp.DetailsList[i].Effect,1,1)=="3" and "*" or "")..(recap.Opt.SpamRows.value and ": " or " ")..recap_temp.DetailsList[i][recap.Opt.PanelDetail.value]..(recap.Opt.PanelDetail.value=="Total" and (" ("..recap_temp.DetailsList[i].TotalP.."%)") or "")
				if not recap.Opt.SpamRows.value then
					alltext = alltext.." ["..text.."]"
				else
					SendChatMessage(text,channel,nil,chatnumber)
				end
			end
		end
		if not recap.Opt.SpamRows.value then
			Recap_InsertChat(alltext)
		end
	end
end
