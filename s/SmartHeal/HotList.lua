SmartHeal.default['hotlist']={}
SmartHeal.default['hotlist']['enablepet']=false

SmartHeal.BlackListTimeout=5 -- 5 sec timeout
SmartHeal.HotListStatusBarHeight=16

SmartHeal.AutoTargetOptionList={
	['PRIEST']={SH_UNASSIGNED,
				SH_RENEW,SH_FLASH_HEAL,SH_LESSER_GREATER_HEALS,SH_GREATER_HEAL,SH_HEAL,SH_LESSER_HEAL,SH_PRAYER_OF_HEALING,SH_POWERWORD_SHIELD,
			},

	['PALADIN']={SH_UNASSIGNED,
				SH_FLASH_OF_LIGHT,SH_HOLY_LIGHT,
			},

	['DRUID']={SH_UNASSIGNED,
				SH_REJUVENATION,SH_HEALING_TOUCH,SH_REGROWTH,SH_SWIFTMEND,
			},

	['SHAMAN']={SH_UNASSIGNED,
				SH_LESSER_HEALING_WAVE,SH_HEALING_WAVE,SH_CHAIN_HEAL,
		},

}

SmartHeal.HotListDefaultHotkey={
	['PRIEST']={['hotkey1']=3,['hotkey2']=4,['hotkey3']=8,},
	['PALADIN']={['hotkey1']=2,['hotkey2']=3,['hotkey3']=1,},
	['DRUID']={['hotkey1']=2,['hotkey2']=3,['hotkey3']=4,},
	['SHAMAN']={['hotkey1']=2,['hotkey2']=3,['hotkey3']=4,},
}

SmartHeal.HotListClassTypeList={
  ["Alliance"]={"PLAYER","PARTY","WARRIOR","PRIEST","MAGE","WARLOCK","ROGUE","HUNTER","DRUID","PALADIN"},
  ["Horde"]={"PLAYER","PARTY","WARRIOR","PRIEST","MAGE","WARLOCK","ROGUE","HUNTER","DRUID","SHAMAN"},
}

SmartHeal.default['hotlist']={
	["Triggerclasstype1"]=50,
	["Triggerclasstype2"]=50,
	["Triggerclasstype3"]=70,
	["Triggerclasstype4"]=50,
	["Triggerclasstype5"]=50,
	["Triggerclasstype6"]=50,
	["Triggerclasstype7"]=50,
	["Triggerclasstype8"]=40,
	["Triggerclasstype9"]=30,
	["Triggerclasstype10"]=30,
	["Colorclasstype1"]="ff172b",
	["Colorclasstype2"]="ff6b60",
	["Colorclasstype3"]="96410d",
	["Colorclasstype4"]="c3c3c3",
	["Colorclasstype5"]="2846ff",
	["Colorclasstype6"]="a03fff",
	["Colorclasstype7"]="ffe923",
	["Colorclasstype8"]="34b526",
	["Colorclasstype9"]="ff931d",
	["Colorclasstype10"]="ff7bb9",
	['BGColor']="0c0c0c",
	['BGColorOpacity']=0.35,
}

SmartHeal.HotListCastBlackList={}

function SmartHeal:InitHotList()

	SmartHeal.playerFactionGroup=UnitFactionGroup("player")
	SmartHeal.default['hotlist']['enable']=1

	for option,value in SmartHeal.HotListDefaultHotkey[SmartHeal.playerClass] do
		SmartHeal.default['hotlist'][option]=value
	end

	for i=1,table.getn(SmartHeal.HotListClassTypeList[SmartHeal.playerFactionGroup]) do
		SmartHeal.default['hotlist']["classtype"..i]=i
	end

	-- hotlist frame settings
	SmartHeal.default['hotlist']['listlength']=90
	SmartHeal.default['hotlist']['listwidth']=130
	SmartHeal.default['hotlist']['enablepriority']=1

end

function SmartHeal:ReinitializeHotList()
	SmartHeal.HealthRatioList={}
	SmartHeal.HotListData={}
	SmartHeal.AutoTargetBlackList={}
	SmartHeal.HotListProcessing=nil
	SmartHeal.AutotargetName=nil
end

function SmartHeal:HotListGetClassColor(unitClass)
	local index

	-- search ClassType table for index
	for i=1,table.getn(SmartHeal.HotListClassTypeList[SmartHeal.playerFactionGroup]) do

		if (SmartHeal.HotListClassTypeList[SmartHeal.playerFactionGroup][i]==unitClass) then
			index=i break
		end

	end

	-- search config color table for color
	for i=1,table.getn(SmartHeal.HotListClassTypeList[SmartHeal.playerFactionGroup]) do

		if(SmartHeal:getConfig("classtype"..i,"hotlist")==index) then
			return SmartHeal:getConfig("Colorclasstype"..i,"hotlist")
		end

	end
end

SmartHeal.HotListIgnoreList={}

function SmartHeal:HotListGroupIgnore(UnitInfo)

	for i=1,table.getn(SmartHeal.HotListIgnoreList) do
		if (SmartHeal.HotListIgnoreList[i]==UnitInfo.group) then
			return true
		end
	end
	
	return false
	
end

SmartHeal.HotListNamedTargetList={}

SmartHeal.HealthRatioList={}
SmartHeal.HotListData={}

function SmartHeal:UpdateUnitHealth()

	SmartHeal.HealthRatioList={}
	
	if(GetNumRaidMembers()>0) then
		for i=1,40 do
			SmartHeal:UpdateUnitHealthType("raid",i)
			if (SmartHeal:getConfig('enablepet','hotlist')) then
				SmartHeal:UpdateUnitHealthType("raidpet",i)
			end
		end
	elseif(GetNumPartyMembers()>0) then
		for i=1,4 do
			SmartHeal:UpdateUnitHealthType("party",i)
			if (SmartHeal:getConfig('enablepet','hotlist')) then
				SmartHeal:UpdateUnitHealthType("partypet",i)
			end
		end
		SmartHeal:UpdateUnitHealthType("player")
		if (SmartHeal:getConfig('enablepet','hotlist')) then
			SmartHeal:UpdateUnitHealthType("pet")
		end
	else
		-- for testing purposes
		--SmartHeal:UpdateUnitHealthType("player")
	end

end

function SmartHeal:UpdateUnitHealthType(groupType,index)

	local UnitId,group,unitClass,online,isDead,_

	if(groupType=="raid") then
		UnitId=groupType..index
		_,_,group,_,_,unitClass,_,online,isDead=GetRaidRosterInfo(index)
	elseif(groupType=="party") then
		UnitId=groupType..index
		online=UnitIsConnected(UnitId)
		--name,rank,level,classLocale,class,isDead
		_,_,_,_,unitClass,isDead=GetPartyRosterInfo(index)
	elseif(groupType=="player" or groupType=="pet") then
		UnitId=groupType
		online=UnitIsConnected("player")
		_,unitClass=UnitClass("player")
		isDead=UnitIsDeadOrGhost(UnitId)
	elseif(groupType=="partypet") then
		UnitId=groupType..index
		online=UnitIsConnected("party"..index)
		_,unitClass=UnitClass("party"..index)
		isDead=UnitIsDeadOrGhost(UnitId)
	elseif(groupType=="raidpet") then
		UnitId=groupType..index
		online=UnitIsConnected("raid"..index)
		_,unitClass=UnitClass("raid"..index)
		isDead=UnitIsDeadOrGhost(UnitId)
	end
	
	if (UnitIsVisible(UnitId) and UnitExists(UnitId) and not isDead and online) then
	
		local UnitHealth,UnitHealthMax=UnitHealth(UnitId),UnitHealthMax(UnitId)
		local hpRatio=UnitHealth/UnitHealthMax
		local UnitInfo={name=UnitName(UnitId), hpRatio=hpRatio, hp=UnitHealth, hpMax=UnitHealthMax, class=unitClass, UnitId=UnitId, InParty=(UnitPlayerOrPetInParty(UnitId) or UnitIsUnit(UnitId,"player")), group=group}
		
		if (UnitHealth>0 and not SmartHeal:HotListGroupIgnore(UnitInfo) and not (hpRatio==1 and SmartHeal:getConfig('hideHPFull','hotlist')) ) then
			
			local updated=false
			
			for j=1,table.getn(SmartHeal.HealthRatioList) do
				if (hpRatio<SmartHeal.HealthRatioList[j].hpRatio) then
					table.insert(SmartHeal.HealthRatioList,j,UnitInfo)
					updated=true
					break
				end
			end

			if (not updated) then
				table.insert(SmartHeal.HealthRatioList,UnitInfo)
			end

		end -- if (UnitHealth>0)

	end -- if (UnitExists(UnitId))

end

function SmartHeal:GetHealthInfo(class,hpRatioCap)

	local PriorityList={}

	if (string.lower(class)=="player") then

		local _,unitClass=UnitClass("player")
		local UnitHealth,UnitHealthMax=UnitHealth("player"),UnitHealthMax("player")

		if (not hpRatioCap or (UnitHealth/UnitHealthMax*100)<=hpRatioCap) then
		table.insert(PriorityList,{name=UnitName("player"), hpRatio=(UnitHealth/UnitHealthMax) ,hp=UnitHealth, hpMax=UnitHealthMax, class=unitClass, UnitId="player"})
		end

	elseif (string.lower(class)=="party") then

		for i=1,table.getn(SmartHeal.HealthRatioList) do

			if(SmartHeal.HealthRatioList[i].InParty and (not hpRatioCap or SmartHeal.HealthRatioList[i].hpRatio*100<=hpRatioCap)) then

				table.insert(PriorityList,SmartHeal.HealthRatioList[i])

			end

		end
		
	elseif (string.lower(class)=="raid") then

		for i=1,table.getn(SmartHeal.HealthRatioList) do

			if(not hpRatioCap or SmartHeal.HealthRatioList[i].hpRatio*100<=hpRatioCap) then

				table.insert(PriorityList,SmartHeal.HealthRatioList[i])

			end

		end

	else
	
		for i=1,table.getn(SmartHeal.HealthRatioList) do

			if( string.upper(class)==SmartHeal.HealthRatioList[i].class and (not hpRatioCap or SmartHeal.HealthRatioList[i].hpRatio*100<=hpRatioCap) ) then

				table.insert(PriorityList,SmartHeal.HealthRatioList[i])

			end

		end

	end

	return PriorityList
end

function SmartHeal:BuildRaidHealthList(limit)

	local HotListData={}
	local HotListRef={}
	local UnitEntry=SmartHeal:GetHealthInfo("RAID")

	for j=1,table.getn(UnitEntry) do

		if (not HotListRef[UnitEntry[j].name]) then
			UnitEntry[j].matchClass=UnitEntry[j].class
			table.insert(HotListData,UnitEntry[j])
			HotListRef[UnitEntry[j].name]=table.getn(HotListData)
				if (table.getn(HotListData)>=limit) then
					SmartHeal.HotListData=HotListData
				return
			end
		end


	end

	SmartHeal.HotListData=HotListData

end

function SmartHeal:BuildPriorityList(limit)

	local HotListData={}
	local HotListRef={}
	local UnitEntry
	
	---- Get Named Target
	UnitEntry=SmartHeal:GetHealthInfo("RAID")
	for i=1,table.getn(SmartHeal.HotListNamedTargetList) do
		for j=1,table.getn(UnitEntry) do
			if (SmartHeal.HotListNamedTargetList[i]==UnitEntry[j].name) then
				table.insert(HotListData,UnitEntry[j])
				HotListRef[UnitEntry[j].name]=table.getn(HotListData)
				
				if (table.getn(HotListData)>=limit) then
					 SmartHeal.HotListData=HotListData
					 return
				end
			end
		end
	end
	----
	
	for i=1,table.getn(SmartHeal.HotListClassTypeList[SmartHeal.playerFactionGroup]) do

		local class=SmartHeal.HotListClassTypeList[SmartHeal.playerFactionGroup][SmartHeal:getConfig("classtype"..i,"hotlist")]
		UnitEntry=SmartHeal:GetHealthInfo(class,SmartHeal:getConfig("Triggerclasstype"..i,"hotlist"))

		for j=1,table.getn(UnitEntry) do
			if (not HotListRef[UnitEntry[j].name]) then
				UnitEntry[j].matchClass=class
				table.insert(HotListData,UnitEntry[j])
				HotListRef[UnitEntry[j].name]=table.getn(HotListData)

				if (table.getn(HotListData)>=limit) then
					 SmartHeal.HotListData=HotListData
					 return
				end

			end
		end

	end

	SmartHeal.HotListData=HotListData

end

-- hexcolor to rgb
function RGB_hextodec(hex)

	local HextoDecTable = {["0"]=0,["1"]=1,["2"]=2,["3"]=3,["4"]=4,["5"]=5,["6"]=6,["7"]=7,["8"]=8,["9"]=9,a=10,b=11,c=12,d=13,e=14,f=15}

	local r1 = HextoDecTable[string.lower(string.sub(hex,1,1))] * 16;
	local r2 = HextoDecTable[string.lower(string.sub(hex,2,2))];
	local r  = (r1 + r2) / 255;

	local g1 = HextoDecTable[string.lower(string.sub(hex,3,3))] * 16;
	local g2 = HextoDecTable[string.lower(string.sub(hex,4,4))];
	local g  = (g1 + g2) / 255;

	local b1 = HextoDecTable[string.lower(string.sub(hex,5,5))] * 16;
	local b2 = HextoDecTable[string.lower(string.sub(hex,6,6))];
	local b  = (b1 + b2) / 255;

	return r,g,b
end

-- decimal to hex
function RGB_dectohex(red,green,blue)
	if ( not red or not green or not blue ) then
		return "ffffff"
	end

	red = floor(red * 255)
	green = floor(green * 255)
	blue = floor(blue * 255)

	local a,b,c,d,e,f

	local DecToHexTable = {["0"]=0,["1"]=1,["2"]=2,["3"]=3,["4"]=4,["5"]=5,["6"]=6,["7"]=7,["8"]=8,["9"]=9,
				["10"]="a",["11"]="b",["12"]="c",["13"]="d",["14"]="e",["15"]="f"}

	a = ""..DecToHexTable[tostring(floor(red / 16))]
	b = ""..DecToHexTable[tostring(math.mod(red,16))]
	c = ""..DecToHexTable[tostring(floor(green / 16))]
	d = ""..DecToHexTable[tostring(math.mod(green,16))]
	e = ""..DecToHexTable[tostring(floor(blue / 16))]
	f = ""..DecToHexTable[tostring(math.mod(blue,16))]

	return a..b..c..d..e..f
end

function SmartHeal:ColorPicker_OnClick(frameName,Id,opacity)
	local r, g, b = RGB_hextodec(SmartHeal:getConfig(Id,"hotlist"))
	ColorPickerFrame.cancelFunc = SH_ColorPickerCancelled
	ColorPickerFrame.func = SH_ColorPickerColorChanged
	ColorPickerFrame.RefId = Id
	ColorPickerFrame.RefFrameName = frameName
	local a
	if (opacity==1) then
		a= SmartHeal:getConfig(Id.."Opacity","hotlist") or 1
		ColorPickerFrame.opacityFunc = SH_ColorPickerColorChanged
		ColorPickerFrame.opacity = a
		OpacitySliderFrame:SetValue(a)
		ColorPickerFrame.hasOpacity = true
	else
		ColorPickerFrame.hasOpacity = false
	end
	ColorPickerFrame.previousValues = {r, g, b, a}

	ColorPickerFrame:SetColorRGB(r,g,b)
	ColorPickerFrame:ClearAllPoints()
	ColorPickerFrame:SetPoint("TOPLEFT", getglobal(frameName), "TOPRIGHT", 0, 0)
	ColorPickerFrame:SetFrameStrata("DIALOG")
	ColorPickerFrame:Show()
end

function SH_ColorPickerColorChanged()
	local r, g, b = ColorPickerFrame:GetColorRGB()
	if (ColorPickerFrame.hasOpacity) then
		a = OpacitySliderFrame:GetValue()
		SmartHeal:setConfig(ColorPickerFrame.RefId.."Opacity",a,"hotlist")
	end

	SmartHeal:setConfig(ColorPickerFrame.RefId,RGB_dectohex(r,g,b),"hotlist")

	getglobal(ColorPickerFrame.RefFrameName):SetTexture(r,g,b,a or 1)

end

function SH_ColorPickerCancelled(color)
	local r,g,b,a = unpack(color)

	if (ColorPickerFrame.hasOpacity) then
		SmartHeal:setConfig(ColorPickerFrame.RefId.."Opacity",a,"hotlist")
	end

	SmartHeal:setConfig(ColorPickerFrame.RefId,RGB_dectohex(r,g,b),"hotlist");

	getglobal(ColorPickerFrame.RefFrameName):SetTexture(r,g,b,a or 1) -- SetTexture SetBackdropColor SetTextColor

end

function SmartHeal.HotList_MoveClassTypePriority(Id,status)

	local AffectedId=tonumber(Id)+status

	local tempClassType=SmartHeal:getConfig("classtype"..Id,"hotlist")
	local tempTriggerClassType=SmartHeal:getConfig("Triggerclasstype"..Id,"hotlist")
	local tempColorClassType=SmartHeal:getConfig("Colorclasstype"..Id,"hotlist")

	SmartHeal:setConfig("classtype"..Id,SmartHeal:getConfig("classtype"..AffectedId,"hotlist"),"hotlist")
	SmartHeal:setConfig("Triggerclasstype"..Id,SmartHeal:getConfig("Triggerclasstype"..AffectedId,"hotlist"),"hotlist")
	SmartHeal:setConfig("Colorclasstype"..Id,SmartHeal:getConfig("Colorclasstype"..AffectedId,"hotlist"),"hotlist")

	SmartHeal:setConfig("classtype"..AffectedId,tempClassType,"hotlist")
	SmartHeal:setConfig("Triggerclasstype"..AffectedId,tempTriggerClassType,"hotlist")
	SmartHeal:setConfig("Colorclasstype"..AffectedId,tempColorClassType,"hotlist")

end

function SmartHeal:HotListClickHeal(button,unit)

	local KeyDownType=SmartHeal:GetClickHealButton()

	if KeyDownType=="undetermined" then
		return
	elseif KeyDownType then
		SmartHeal:ClickHeal(KeyDownType..button,unit)
	else
		TargetUnit(unit)
	end

end

SmartHeal.AutoTargetBlackList={}

function SmartHeal:AutoTargetAddToBlackList()

	if (SmartHeal.AutotargetName) then

		SmartHeal.AutoTargetBlackList[SmartHeal.AutotargetName]=0

	end

	SmartHeal.AutotargetName=nil

end

function SmartHeal:AutoTargetUpdateBlackList(arg1)

	local current_timelapse

	for name,timelapse in SmartHeal.AutoTargetBlackList do

		current_timelapse=timelapse+arg1
		if(current_timelapse>SmartHeal.BlackListTimeout) then
			SmartHeal.AutoTargetBlackList[name]=nil
		else
			SmartHeal.AutoTargetBlackList[name]=current_timelapse
		end

	end

end

function SmartHeal:HotListCast(hotkeyNum)

	if (SmartHeal.AutoTargetOptionList[SmartHeal.playerClass]) then
		local spell=SmartHeal.AutoTargetOptionList[SmartHeal.playerClass][hotkeyNum]
		SmartHeal:AutoTargetCast(spell)
	end

end

function SmartHeal:AutoTargetCast(spell)
	local unit
	local clearTarget,Attacking
	SmartHeal.AttackingBeforeCast=nil
	
	for i=1,table.getn(SmartHeal.HotListData) do
		if (not SmartHeal.AutoTargetBlackList[UnitName(SmartHeal.HotListData[i].UnitId)]) then
			unit=SmartHeal.HotListData[i].UnitId
			SmartHeal.AutotargetName=UnitName(unit)
			break
		end
	end

	if(GetNumRaidMembers()==0 and GetNumPartyMembers()==0) then unit="player" end

	if not unit then return end
	
	if (UnitIsUnit("player",unit)) then
		SmartHeal.selfCast=1
	else
		SmartHeal.selfCast=0
	end
	
	if (UnitIsUnit("player",unit) or UnitIsUnit("target",unit)) then
		SmartHeal:Cast(spell)

	else
	
		if(not UnitExists("target")) then clearTarget=1
		elseif (SmartHeal.Attacking) then Attacking=1 end
	
		TargetUnit(unit)
		
		SmartHeal:Cast(spell)
		
		if (SpellIsTargeting() and not SpellCanTargetUnit(unit)) then	
			SpellStopTargeting()
			
			if(clearTarget) then
				ClearTarget()
			else
				TargetLastTarget()
			end
		
			if(Attacking) then
				SmartHeal.ResumeAttack=1
			end
		else
		
			if(clearTarget) then
				ClearTarget()
			else
				TargetLastTarget()
			end
			
			if(Attacking) then
				SmartHeal.AttackingBeforeCast=1
			end
		end
			
	end

end

function SmartHeal:GetHotListUnitId(index)

	if (SmartHeal.HotListData[index]) then
		return SmartHeal.HotListData[index].UnitId
	end

end


---- Mouse Dragging/Clicking on Frame

function SmartHeal:HotListTitleButton_OnMouseDown()

	local button = arg1;
	if ( button  == "LeftButton" ) then
		if ( this:GetButtonState() == "PUSHED" ) then
			SH_HotListFrame:StartMoving()
		else
			SH_HotListFrame:StopMovingOrSizing()
		end
	end

end

function SmartHeal:HotListOnEvent(event)

	if (this:IsShown() and SmartHeal.Loaded) then

		if ((event=="UNIT_HEALTH" or event=="UNIT_MAXHEALTH") and not SmartHeal.HotListProcessing) then
	
			SmartHeal.HotListProcessing=true
			SmartHeal:UpdateUnitHealth()
			if(SmartHeal:getConfig("enablepriority","hotlist")) then
				SmartHeal:BuildPriorityList(15)
			else
				SmartHeal:BuildRaidHealthList(15)
			end
			SmartHeal:HotListStatusBarOnEvent()
			SmartHeal.HotListProcessing=nil
	
		end
	
		if (event=="SPELLCAST_FAILED") then
			SmartHeal:AutoTargetAddToBlackList()
		end
	
	end

end

function SmartHeal:HotListStatusBarOnEvent()

	local width=this:GetWidth()
	local StatusBarPrefix="SH_HotListFrameCanvas_Unit"

	local i=1
	while(getglobal(StatusBarPrefix..i)) do
		local StatusBarFrame=getglobal(StatusBarPrefix..i)
		local UnitButton=getglobal(StatusBarPrefix..i.."_UnitButton")
		local UnitButtonLabel=getglobal(StatusBarPrefix..i.."_UnitButtonLabel")
		local StatusBar=getglobal(StatusBarPrefix..i.."_StatusBar")

		if (SmartHeal.HotListData[i]) then
		
			-- status bar frame settings
			StatusBarFrame:SetHeight(SmartHeal.HotListStatusBarHeight)
			StatusBarFrame:SetPoint("TOPLEFT","$parent","TOPLEFT",0,-SmartHeal.HotListStatusBarHeight*(i-1));

			-- status bar settings
			local hpRatio=floor(SmartHeal.HotListData[i].hpRatio*100)
			local label=SmartHeal.HotListData[i].hp.."("..hpRatio.."%) "..UnitName(SmartHeal.HotListData[i].UnitId)
			StatusBar:SetValue(SmartHeal.HotListData[i].hpRatio)
			StatusBar:SetStatusBarColor(RGB_hextodec(SmartHeal:HotListGetClassColor(SmartHeal.HotListData[i].matchClass)))

			-- Set Text to Hidden Text layer
			UnitButtonLabel.HiddenText=label

			-- status bar button settings
			local UnitId=SmartHeal.HotListData[i].UnitId
			UnitButton:SetScript("OnClick", function() SmartHeal:HotListClickHeal(arg1,UnitId) end)

		else

			UnitButtonLabel.HiddenText=""
			StatusBar:SetValue(0)

		end
		
		i=i+1
	end -- end of while loop

end

function SmartHeal:HotListVisualOnUpdate()

	local StatusBarPrefix="SH_HotListFrameCanvas_Unit"
	local barCount=floor((this:GetParent():GetHeight()-30)/SmartHeal.HotListStatusBarHeight)
	local width=this:GetParent():GetWidth()-10
	
	local i=1
	while(getglobal(StatusBarPrefix..i)) do
		local StatusBarFrame=getglobal(StatusBarPrefix..i)
		local UnitButton=getglobal(StatusBarPrefix..i.."_UnitButton")
		local UnitButtonLabel=getglobal(StatusBarPrefix..i.."_UnitButtonLabel")

		if (i<=barCount and UnitButtonLabel.HiddenText~="") then

			-- Set Hidden Text to Button
			UnitButtonLabel:SetText(UnitButtonLabel.HiddenText)
			
			-- Truncate StatusBar Text
			SmartHeal:TruncateText(width,UnitButtonLabel.HiddenText,UnitButton,UnitButtonLabel)

			StatusBarFrame:Show()
		else

			StatusBarFrame:Hide()

		end
		
		i=i+1
	end -- end of while loop

end

function SmartHeal:TruncateText(width,text,button,buttonlabel)

	-- Truncate StatusBar Text if text width > frame width
	if (button:GetTextWidth()>width) then

		local j=0
		while (button:GetTextWidth()>(width-5) and string.len(buttonlabel:GetText())>1) do
			buttonlabel:SetText(string.sub(text,1, -2-j))
			j=j+1
		end

		buttonlabel:SetText(buttonlabel:GetText().."...")
	end

end

function GetPartyRosterInfo(index)

	local unitId="party"..index
	local name=UnitName(unitId)
	
	local rank=0
	if(index==GetPartyLeaderIndex()) then rank=1 end
	
	local level=UnitLevel(unitId)
	local classLocale,class=UnitClass(unitId)
	local isDead=UnitIsDeadOrGhost(unitId)

	--name,rank,level,classLocale,class,isDead	
	return name,rank,level,classLocale,class,isDead

end

function SH_HotList_PrepareMenu()

	local info
	
	-- Title
	info = {}
	info.isTitle =  true
	info.text = "SMH HotList"
	UIDropDownMenu_AddButton(info);
	
	-- Enable Priority
	info = {}
	info.text = SH_ENABLE_PRIORITY
	if (SmartHeal:getConfig('enablepriority','hotlist')) then
		info.checked = 1
	end
	info.func = SH_HotListPriority_Toggle
	UIDropDownMenu_AddButton(info)
	
	-- Enable Pet
	info = {}
	info.text = SH_PET
	if (SmartHeal:getConfig('enablepet','hotlist')) then
		info.checked = 1
	end
	info.func = SH_HotListPet_Toggle
	UIDropDownMenu_AddButton(info)
	
	-- Hide HP>100%
	info = {}
	info.text = SH_HIDE_HP_AT_100
	if (SmartHeal:getConfig('hideHPFull','hotlist')) then
		info.checked = 1
	end
	info.func = SH_HideHPFull
	UIDropDownMenu_AddButton(info)
	
	-- Reset HealStack(CTRA)
	info = {}
	info.text = SH_RESET_HEALSTACK
	info.notCheckable = 1
	info.value = "ResetHealStack"
	info.func = SH_ResetHealStack
	UIDropDownMenu_AddButton(info)
	
	-- Ignore List
	info = {}
	info.text = SH_GROUP_IGNORE_LIST
	info.notCheckable = 1
	info.value = "IgnoreList"
	info.func = SH_GroupIgnoreList_Show
	UIDropDownMenu_AddButton(info)

	-- Named Target
	info = {}
	info.text = SH_NAMED_TARGET_LIST
	info.notCheckable = 1
	info.value = "NamedList"
	info.func = SH_NamedTargetList_Show
	UIDropDownMenu_AddButton(info)
	
	-- Spacer
	--info = {};
	--info.disabled = 1;
	--UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
end


function SH_HideHPFull()
	if(SmartHeal:getConfig('hideHPFull','hotlist')) then
		SmartHeal:setConfig('hideHPFull',false,'hotlist')
	else
		SmartHeal:setConfig('hideHPFull',true,'hotlist')
	end
end

function SH_ResetHealStack()
	SmartHeal.HealStack={}
end

function SH_HotListPet_Toggle()
	if(SmartHeal:getConfig('enablepet','hotlist')) then
		SmartHeal:setConfig('enablepet',false,'hotlist')
	else
		SmartHeal:setConfig('enablepet',true,'hotlist')
	end
end

function SH_HotListPriority_Toggle()
	if(SmartHeal:getConfig('enablepriority','hotlist')) then
		SmartHeal:setConfig('enablepriority',false,'hotlist')
	else
		SmartHeal:setConfig('enablepriority',true,'hotlist')
	end
end

function SH_GroupIgnoreList_Show()
	SH_GroupIgnoreList:Show()
end

function SH_NamedTargetList_Show()
	SH_NamedTargetList:Show()
end

