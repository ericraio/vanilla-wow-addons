--[[ RecapOptions.lua ]]

local classabr = { 	["WARRIOR"] = "WAR", ["MAGE"] = "MAG", ["ROGUE"] = "ROG", ["DRUID"] = "DRU",
					["HUNTER"] = "HNT", ["SHAMAN"] = "SHM",	["PRIEST"] = "PRI",	["WARLOCK"] = "WLK",
					["PALADIN"] = "PAL", ["Pet"] = "PET" }


-- knob=nil to use current values
local function set_anchor_buttons(knob)

	RecapAnchorTopLeft:SetNormalTexture("Interface\\AddOns\\Recap\\RecapButtons-Down")
	RecapAnchorTopLeft:UnlockHighlight()
	RecapAnchorTopRight:SetNormalTexture("Interface\\AddOns\\Recap\\RecapButtons-Down")
	RecapAnchorTopRight:UnlockHighlight()
	RecapAnchorBottomLeft:SetNormalTexture("Interface\\AddOns\\Recap\\RecapButtons-Down")
	RecapAnchorBottomLeft:UnlockHighlight()
	RecapAnchorBottomRight:SetNormalTexture("Interface\\AddOns\\Recap\\RecapButtons-Down")
	RecapAnchorBottomRight:UnlockHighlight()

	if knob=="RecapAnchorTopLeft" then
		recap.Opt.GrowUpwards.value = false
		recap.Opt.GrowLeftwards.value = false
	elseif knob=="RecapAnchorTopRight" then
		recap.Opt.GrowUpwards.value = false
		recap.Opt.GrowLeftwards.value = true
	elseif knob=="RecapAnchorBottomLeft" then
		recap.Opt.GrowUpwards.value = true
		recap.Opt.GrowLeftwards.value = false
	elseif knob=="RecapAnchorBottomRight" then
		recap.Opt.GrowUpwards.value = true
		recap.Opt.GrowLeftwards.value = true
	else
		knob = "RecapAnchor"..(recap.Opt.GrowUpwards.value and "Bottom" or "Top")..(recap.Opt.GrowLeftwards.value and "Right" or "Left")
	end
	getglobal(knob):SetNormalTexture("Interface\\AddOns\\Recap\\RecapButtons-Up")
	getglobal(knob):LockHighlight()

	Recap_MoveMinimize()
	if recap.Opt.Minimized.value then
		Recap_Minimize()
	end

end

function Recap_InitializeOptions()

	local chatname,chatid,i

	RecapAutoFadeSlider:SetValue(recap.Opt.AutoFadeTimer.value)
	RecapIdleFightSlider:SetValue(recap.Opt.IdleFightTimer.value)
	RecapMaxRowsSlider:SetValue(recap.Opt.MaxRows.value)
	RecapMaxRankSlider:SetValue(recap.Opt.MaxRank.value)
	RecapOptTab1:LockHighlight()
	RecapOptSubFrame1:Show()
	RecapOpt_StatDropDownText:SetText(recap.Opt.AutoPost.Stat)
	_,_,chatid,chatname = string.find(recap.Opt.AutoPost.Channel,"(%d+)-(%w+)")
	if chatid and chatid~=GetChannelName(chatid) then
		recap.Opt.AutoPost.Channel = "Self"
	end
	RecapOpt_ChannelDropDownText:SetText(recap.Opt.AutoPost.Channel)

	if recap.UseOneSettings then
		RecapOptCheck_UseOneSettings:SetChecked(1)
	else
		RecapOptCheck_UseOneSettings:SetChecked(0)
	end

	-- set check state for all checked options
	for i in recap.Opt do
		if RecapOptFrame and recap.Opt[i].type=="Check" then
			if recap.Opt[i].value==true then
				getglobal("RecapOptCheck_"..i):SetChecked(1)
			else
				getglobal("RecapOptCheck_"..i):SetChecked(0)
			end
		end
	end

	set_anchor_buttons()
end

function RecapOpt_OnMouseDown(arg1)

	if recap_temp.Loaded and arg1=="LeftButton" then
		RecapOptFrame:StartMoving()
	end
end

function RecapOpt_OnMouseUp(arg1)

	if recap_temp.Loaded and arg1=="LeftButton" then
		RecapOptFrame:StopMovingOrSizing()
	end
end

function Recap_AutoFadeSlider_OnValueChanged(arg1)

	if recap_temp.Loaded and arg1 then
		RecapAutoFadeSlider_Text:SetText(arg1.." seconds")
		recap.Opt.AutoFadeTimer.value = arg1
	end
end

function Recap_IdleFightSlider_OnValueChanged(arg1)

	if recap_temp.Loaded and arg1 then
		RecapIdleFightSlider_Text:SetText(arg1.." seconds")
		recap.Opt.IdleFightTimer.value = arg1
	end
end

function Recap_MaxRowsSlider_OnValueChanged(arg1)

	if recap_temp.Loaded and arg1 then
		RecapMaxRowsSlider_Text:SetText(arg1.." rows")
		recap.Opt.MaxRows.value = arg1
		RecapScrollBar_Update()
	end
end

function Recap_MaxRankSlider_OnValueChanged(arg1)

	if recap_temp.Loaded and arg1 then
		RecapMaxRankSlider_Text:SetText("Rank top "..arg1)
		recap.Opt.MaxRank.value = arg1
	end
end


function RecapOptCheck_OnEnter()

	local id = this:GetID()
	Recap_Tooltip(recap_temp.OptList[id][2],recap_temp.OptList[id][3])
end

function RecapOptCheck_OnClick()

	local i
	local id = this:GetID()

	RecapSetEditBox:ClearFocus()

	if id>0 and recap_temp.OptList[id][1] then
		i = getglobal("RecapOptCheck_"..recap_temp.OptList[id][1]):GetChecked()
		if i==1 then
			recap.Opt[recap_temp.OptList[id][1]].value = true
			PlaySound("igMainMenuOptionCheckBoxOn")
		else
			recap.Opt[recap_temp.OptList[id][1]].value = false
			PlaySound("igMainMenuOptionCheckBoxOff")
		end
		-- if display list/self checks
		if ((id>=11 and id<=16) or (id>=26 and id<=27) or (id>=30 and id<=34) or (id>=43 and id<=45)) and not recap.Opt.SelfView.value and not recap.Opt.Minimized.value then
			Recap_Maximize()
		elseif (id>=48 and id<=62) and recap.Opt.SelfView.value and not recap.Opt.Minimized.value then
			Recap_Maximize()
		-- if display minimized checks
		elseif ((id>=17 and id<=22) or id==36) and recap.Opt.Minimized.value then
			Recap_Minimize()
		elseif recap_temp.OptList[id][1]=="UseColor" then
			Recap_SetColors()
			if not recap.Opt.Minimized.value then
				Recap_SetView()
			end
		elseif recap_temp.OptList[id][1]=="ShowTooltips" then
			GameTooltip:Hide()
			Recap_OnTooltip("ShowTooltips")
		elseif recap_temp.OptList[id][1]=="HideFoe" then
			Recap_SetView()
		elseif recap_temp.OptList[id][1]=="HideZero" then
			Recap_SetView()
		elseif recap_temp.OptList[id][1]=="HideYardTrash" then
			Recap_SetView()
		elseif recap_temp.OptList[id][1]=="IdleFight" then
			if recap.Opt.IdleFight.value and recap.Opt.State.value=="Active" then
				recap_temp.IdleTimer = 0
			else
				recap_temp.IdleTimer = -1
			end
		elseif recap_temp.OptList[id][1]=="TooltipFollow" then
			Recap_OnTooltip("TooltipFollow")
		elseif recap_temp.OptList[id][1]=="AutoFade" then
			recap_temp.FadeTimer = -1
		elseif recap_temp.OptList[id][1]=="MergePets" and not UnitIsVisible then
			recap.Opt.MergePets.value = false
			RecapOptCheck_MergePets:SetChecked(0)
		elseif recap_temp.OptList[id][1]=="GrowLeftwards" or recap_temp.OptList[id][1]=="GrowUpwards" or recap_temp.OptList[id][1]=="AutoMinimize" then
			Recap_MoveMinimize()
			if recap.Opt.Minimized.value then
				Recap_Minimize()
			end
		elseif recap_temp.OptList[id][1]=="ShowPanel" then
			if RecapPanel:IsVisible() then
				RecapPanel_Hide(1)
			end
		elseif recap_temp.OptList[id][1]=="LightData" then
			if recap.Opt.LightData.value then
				msg = recap_temp.Local.ConfirmLightData
			else
				msg = recap_temp.Local.ConfirmHeavyData
			end
			StaticPopupDialogs["RECAP_CONFIRMLIGHTDATA"] = {
				text = TEXT(msg),
				button1 = TEXT(ACCEPT),
				button2 = TEXT(CANCEL),
				OnAccept = 	function()
					recap.DataVersion = recap.DataVersion - 0.01 -- force rebuild of data
					ReloadUI()
				end,
				OnHide = function()
					RecapOptCheck_LightData:Enable()
				end,
				OnCancel = function()
					recap.Opt.LightData.value = not recap.Opt.LightData.value
					if recap.Opt.LightData.value then
						RecapOptCheck_LightData:SetChecked(1)
					else
						RecapOptCheck_LightData:SetChecked(0)
					end
				end,
				timeout = 0,
				showAlert = 1,
				whileDead = 1
			}

			RecapOptCheck_LightData:Disable()
			StaticPopup_Show("RECAP_CONFIRMLIGHTDATA")

		elseif recap_temp.OptList[id][1]=="ShowGauges" then
			RecapScrollBar_Update()
		end

	end
end

function Recap_UseOneSettings_OnClick()

	i = RecapOptCheck_UseOneSettings:GetChecked()
	if i==1 then
		recap.UseOneSettings = true
		PlaySound("igMainMenuOptionCheckBoxOn")
		msg = recap_temp.Local.ConfirmGlobalSettings
	else
		recap.UseOneSettings = false
		PlaySound("igMainMenuOptionCheckBoxOff")
		msg = recap_temp.Local.ConfirmSeparateSettings
	end

	StaticPopupDialogs["RECAP_CONFIRMLIGHTDATA"] = {
		text = TEXT(msg),
		button1 = TEXT(ACCEPT),
		button2 = TEXT(CANCEL),
		OnAccept = 	function()

			if recap.UseOneSettings then
				local i,user

				for i in recap_set do
					_,_,user = string.find(i,"^UserData:(.+)")
					if user and user~=recap_temp.p then
						recap_set["UserData:"..user] = nil
						recap[user] = nil
					end
				end
			end

			ReloadUI()
		end,
		OnHide = function()
			RecapOptCheck_UseOneSettings:Enable()
		end,
		OnCancel = function()
			recap.UseOneSettings = not recap.UseOneSettings
			if recap.UseOneSettings then
				RecapOptCheck_UseOneSettings:SetChecked(1)
			else
				RecapOptCheck_UseOneSettings:SetChecked(0)
			end
		end,
		timeout = 0,
		showAlert = 1,
		whileDead = 1
	}

	RecapOptCheck_UseOneSettings:Disable()
	StaticPopup_Show("RECAP_CONFIRMLIGHTDATA")

end

--[[ Fight Data Set functions ]]

function Recap_InitDataSets()

	if RecapOptTitle then

		RecapFightDataSetHeader_Name:SetTextColor(recap_temp.ColorNone.r,recap_temp.ColorNone.g,recap_temp.ColorNone.b)
		RecapFightDataSetHeader_Date:SetTextColor(recap_temp.ColorNone.r,recap_temp.ColorNone.g,recap_temp.ColorNone.b)
		RecapFightDataSetHeader_Combatants:SetTextColor(recap_temp.ColorNone.r,recap_temp.ColorNone.g,recap_temp.ColorNone.b)

		RecapSaveButton:Disable()
		RecapLoadButton:Disable()
		RecapDeleteButton:Disable()

		Recap_BuildFightSets()

		RecapOptTitle:SetText("Recap v"..Recap_Version.." for "..recap_temp.Player.." of "..recap_temp.Server)
	end
end

function Recap_SetEditValidateButtons()

	local text

	if recap_temp.Loaded then

		text = RecapSetEditBox:GetText()

		if text and text~="" then
			RecapSaveButton:Enable()
		else
			RecapSaveButton:Disable()
			RecapLoadButton:Disable()
			RecapDeleteButton:Disable()
		end

		recap_temp.FightSetSelected = Recap_SetExists(text)
		RecapFightSetsScrollBar_Update()

		if recap_temp.FightSetSelected~=0 then
			RecapLoadButton:Enable()
			RecapDeleteButton:Enable()
		else
			RecapLoadButton:Disable()
			RecapDeleteButton:Disable()
		end
	end
end

-- populates recap_temp.FightSets with a list of existing fight sets
function Recap_BuildFightSets()

	local i,friendly

	recap_temp.FightSetsSize = 1
	for i in recap_set do
		if recap_set[i] and not string.find(i,"^UserData:") then
			if not recap_temp.FightSets[recap_temp.FightSetsSize] then
				recap_temp.FightSets[recap_temp.FightSetsSize] = {}
			end
			recap_temp.FightSets[recap_temp.FightSetsSize].Name = i
			recap_temp.FightSets[recap_temp.FightSetsSize].Date = recap_set[i].TimeStamp
			friendly = 0
			for j in recap_set[i].Combatant do
				if string.find(recap_set[i].Combatant[j],"^true") then
					friendly = friendly + 1
				end
			end
			recap_temp.FightSets[recap_temp.FightSetsSize].Combatants = recap_set[i].ListSize .. " ("..friendly..")"
			recap_temp.FightSetsSize = recap_temp.FightSetsSize + 1
		end
	end
	table.sort(recap_temp.FightSets,Recap_SetSort)
end

function RecapFightSetsScrollBar_Update()

	local i, index, item

  if recap_temp.Loaded then

	FauxScrollFrame_Update(RecapFightSetsScrollBar,recap_temp.FightSetsSize-1,10,5)

	for i=1,10 do
		index = i + FauxScrollFrame_GetOffset(RecapFightSetsScrollBar)
		if index < recap_temp.FightSetsSize then
			getglobal("RecapList"..i.."Back"):Hide()
			getglobal("RecapFightDataList"..i.."_Name"):SetText(recap_temp.FightSets[index].Name)
			getglobal("RecapFightDataList"..i.."_Date"):SetText(recap_temp.FightSets[index].Date)
			getglobal("RecapFightDataList"..i.."_Combatants"):SetText(recap_temp.FightSets[index].Combatants)
			item = getglobal("RecapFightDataList"..i)
			item:Show()
			if recap_temp.FightSetSelected == index then
				item:LockHighlight()
			else
				item:UnlockHighlight()
			end
		else
			item = getglobal("RecapFightDataList"..i)
			item:Hide()
			item:UnlockHighlight()
			getglobal("RecapList"..i.."Back"):Show()
		end
	end

  end
end			

function RecapFightData_OnClick()

	local id = this:GetID()

	RecapSetEditBox:ClearFocus()
   
	index = id + FauxScrollFrame_GetOffset(RecapFightSetsScrollBar)

	if index < recap_temp.FightSetsSize then
		recap_temp.FightSetSelected = index
		RecapSetEditBox:SetText(recap_temp.FightSets[index].Name)
		RecapSaveButton:Enable()
		RecapLoadButton:Enable()
		RecapDeleteButton:Enable()
		RecapFightSetsScrollBar_Update()
	end
end

function Recap_SetExists(arg1)

	local result = 0

	for i in recap_temp.FightSets do
		if recap_temp.FightSets[i].Name == arg1 then
			result = i
		end
	end

	return result
end

-- fight data set sort (by date)
function Recap_SetSort(e1,e2)
	if e1 and e2 and ( e1.Date > e2.Date ) then
		return true
	else
		return false
	end
end

--[[ Options tabs ]]

function RecapOptTab_OnEnter()

    id = this:GetID()

	if id and id>0 then
		Recap_OnTooltip("OptTab"..id)
	end
end

function RecapOptTab_OnClick()

	local id,i = this:GetID()
	PlaySound("GAMEGENERICBUTTONPRESS")

	if id and id>0 then
		for i=1,4 do
			getglobal("RecapOptTab"..i):UnlockHighlight()
			getglobal("RecapOptSubFrame"..i):Hide()
		end
		RecapOptClipFrame:Hide()
		getglobal("RecapOptTab"..id):LockHighlight()
		getglobal("RecapOptSubFrame"..id):Show()
	end
end

--[[ drop down lists ]]

function RecapDropMenu_OnClick()

	local id = this:GetID()

	if recap_temp.CurrentDrop==RecapOpt_StatDropDownButton then
		recap.Opt.AutoPost.Stat = getglobal("RecapDropMenu"..id.."_Text"):GetText()
		RecapOpt_StatDropDownText:SetText(recap.Opt.AutoPost.Stat)
	else
		recap.Opt.AutoPost.Channel = getglobal("RecapDropMenu"..id.."_Text"):GetText()
		RecapOpt_ChannelDropDownText:SetText(recap.Opt.AutoPost.Channel)
	end
	Recap_DropMenu:Hide()
	recap_temp.CurrentDrop = nil

end

function RecapDropMenu_OnEnter()

end

function Recap_ToggleDropDown()

	if Recap_DropMenu:IsVisible() and recap_temp.CurrentDrop==this then
		Recap_DropMenu:Hide()
		recap_temp.CurrentDrop = nil
	elseif recap_temp.CurrentDrop~=this and this==RecapOpt_StatDropDownButton then
		Recap_ShowStatDrop()
		recap_temp.CurrentDrop = this
	elseif recap_temp.CurrentDrop~=this then
		Recap_ShowChannelDrop()
		recap_temp.CurrentDrop = this
	end

end

function Recap_ShowStatDrop()

	Recap_DropMenu:ClearAllPoints()
	Recap_DropMenu:SetPoint("TOPLEFT","RecapOpt_StatDropDown","BOTTOMLEFT",16,8)
	Recap_PopulateDrop(recap_temp.StatDropList)
end

function Recap_ShowChannelDrop()
	local new_list = {}

	Recap_DropMenu:ClearAllPoints()
	Recap_DropMenu:SetPoint("TOPLEFT","RecapOpt_ChannelDropDown","BOTTOMLEFT",16,8)

	for i=1,table.getn(recap_temp.ChannelDropList) do
		table.insert(new_list,recap_temp.ChannelDropList[i])
	end
	for i=1,10 do
		c,name = GetChannelName(i)
		if name then
			for i=1,table.getn(recap_temp.Local.SkipChannels) do
				if string.find(name,recap_temp.Local.SkipChannels[i]) then
					name = nil
					i = table.getn(recap_temp.Local.SkipChannels)
				end
			end
		end
		if name then
			table.insert(new_list,c.."-"..name)
		end
	end
	Recap_PopulateDrop(new_list)
end

function Recap_PopulateDrop(arg1)

	local height = 0

	for i=1,math.min(8,table.getn(arg1)) do
		getglobal("RecapDropMenu"..i.."_Text"):SetText(arg1[i])
		getglobal("RecapDropMenu"..i):Show()
		height = height + 16
	end
	for i=table.getn(arg1)+1,8 do
		getglobal("RecapDropMenu"..i):Hide()
	end

	Recap_DropMenu:SetHeight(height+4)
	Recap_DropMenu:Show()
end

function RecapDropMenu_OnUpdate(arg1)

	if not recap_temp.MenuTimer or MouseIsOver(Recap_DropMenu) or 
		(recap_temp.CurrentDrop and MouseIsOver(recap_temp.CurrentDrop)) then
		recap_temp.MenuTimer = 0
	end

	recap_temp.MenuTimer = recap_temp.MenuTimer + arg1
	if recap_temp.MenuTimer > .25 then
		recap_temp.MenuTimer = 0
		Recap_DropMenu:Hide()
		recap_temp.CurrentDrop = nil
	end
end

local function logline(arg1,clip)

	local lineformat = recap_temp.Local.LogFormat
	local str
	local prefix = recap.Opt.HTML.value and "<b>" or ""
	local suffix = recap.Opt.HTML.value and "</b>" or ""
	if recap.Opt.HTML.value then
		lineformat = recap_temp.Local.HTMLFormat
	end

	if arg1=="FirstLine" then
		str = string.format(lineformat,prefix..recap_temp.Local.Log[1]..suffix,
										  prefix..recap_temp.Local.Log[2]..suffix,
										  prefix..recap_temp.Local.Log[3]..suffix,
										  prefix..recap_temp.Local.Log[4]..suffix,
										  prefix..recap_temp.Local.Log[5]..suffix,
										  prefix..recap_temp.Local.Log[6]..suffix,
										  prefix..recap_temp.Local.Log[7]..suffix,
										  prefix..recap_temp.Local.Log[8]..suffix,
										  prefix..recap_temp.Local.Log[9]..suffix,
										  prefix..recap_temp.Local.Log[10]..suffix,
										  prefix..recap_temp.Local.Log[11]..suffix,
										  prefix..recap_temp.Local.Log[12]..suffix)
	elseif arg1=="Spacer" then
		str = recap.Opt.HTML.value and string.format(lineformat," "," "," "," "," "," "," "," "," "," "," "," ") or " "
	else
		str = string.format(lineformat,
							recap_temp.List[arg1].Name,
							Recap_FormatLevel(recap.Combatant[recap_temp.List[arg1].Name].Level),
							Recap_FormatClass(recap.Combatant[recap_temp.List[arg1].Name].Class),
							Recap_FormatTime(recap_temp.List[arg1].Time),
							recap_temp.List[arg1].Heal,
							recap_temp.List[arg1].HealP.."%%",
							recap_temp.List[arg1].DmgIn,
							recap_temp.List[arg1].DmgInP.."%%",
							recap_temp.List[arg1].DmgOut,
							recap_temp.List[arg1].DmgOutP.."%%",
							recap_temp.List[arg1].MaxHit,
							string.format("%.1f",recap_temp.List[arg1].DPS))
	end

	if str then
		str = str .. ((clip and not recap.Opt.HTML.value) and "\n" or "")
		if clip then
			str = string.gsub(str,"%%%%","%%")
		end
		return str
	end
end

function Recap_WriteClip()

	local i,donefriends
	local headerformat = recap_temp.Local.LogHeader

	RecapClipEditBox:SetText("")
	RecapOptSubFrame4:Hide()
	RecapOptClipFrame:Show()
	RecapClipEditBox:SetFocus()

	if recap.Opt.HTML.value then
		headerformat = recap_temp.Local.HTMLHeader
		RecapClipEditBox:Insert(recap_temp.Local.HTMLPrefix)
	end

	RecapClipEditBox:Insert(string.format(headerformat,UnitName("player"),recap_temp.Local.LastAll[recap.Opt.View.value],date(),GetRealZoneText()).."\n")
	RecapClipEditBox:Insert(logline("FirstLine","clip"))

	for i=1,recap_temp.ListSize-1 do

		if not donefriends and not recap.Combatant[recap_temp.List[i].Name].Friend then
			if not recap.Opt.WriteFriends.value then
				RecapClipEditBox:Insert(logline("Spacer","clip"))
			end
			donefriends = true
		end
		
		if not donefriends or not recap.Opt.WriteFriends.value then
			RecapClipEditBox:Insert(logline(i,"clip"))
		end
	end

	if recap.Opt.HTML.value then
		RecapClipEditBox:Insert(recap_temp.Local.HTMLSuffix)
	end

	RecapClipEditBox:HighlightText()

end


function Recap_WriteLog()

	local i,chatnum,chatname,freeslot,donefriends,alreadyin
	local lines = 0
	local logchat = "recaplog"..string.lower(UnitName("player"))
	local headerformat = recap_temp.Local.LogHeader
	local prefix,suffix = "", ""

	for i=1,10 do
		_,chatname = GetChannelName(i)
		if not chatname then
			freeslot = true
		elseif string.lower(chatname)==logchat then
			freeslot = true
			alreadyin = true
		end
	end

	if freeslot then

		if not alreadyin then
			RecapFrame:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE")
			JoinChannelByName(logchat)
			RecapOpt_WriteLogLabel:SetText(RECAP_ACQUIRING_CHANNEL)
		end

		chatnum = nil
		for i=1,10 do
			j,chatname = GetChannelName(i)
			if chatname and string.lower(chatname)==logchat then
				chatnum=j
			end
		end

		if chatnum then

			if recap.Opt.HTML.value then
				headerformat = recap_temp.Local.HTMLHeader
				prefix = "-->"
				suffix = "<!--"
				SendChatMessage(recap_temp.Local.HTMLPrefix..prefix,"CHANNEL",nil,chatnum)
			end

			-- we're in a channel
			SendChatMessage(prefix..string.format(headerformat,UnitName("player"),recap_temp.Local.LastAll[recap.Opt.View.value],date(),GetRealZoneText())..suffix,"CHANNEL",nil,chatnum)
			SendChatMessage(prefix..logline("FirstLine")..suffix,"CHANNEL",nil,chatnum)

			for i=1,recap_temp.ListSize-1 do

				if lines<(recap_temp.MaxLogLines/(recap.Opt.HTML.value and 2 or 1)) then
					-- MaxLogLines defined in localization.lua. When writing in HTML, halve the limit to prevent disconnect
					if not donefriends and not recap.Combatant[recap_temp.List[i].Name].Friend then
						if not recap.Opt.WriteFriends.value then
							SendChatMessage(prefix..logline("Spacer")..suffix,"CHANNEL",nil,chatnum)
						end
						donefriends = true
					end

					if not donefriends or not recap.Opt.WriteFriends.value then
						SendChatMessage(prefix..logline(i)..suffix,"CHANNEL",nil,chatnum)
					end

					lines = lines + 1
				end
			end

			if recap.Opt.HTML.value then
				SendChatMessage(prefix..recap_temp.Local.HTMLSuffix,"CHANNEL",nil,chatnum)
			end
			SendChatMessage("EOF","CHANNEL",nil,chatnum)

		end

	else
		DEFAULT_CHAT_FRAME:AddMessage(recap_temp.Local.NoFreeChannels)
		RecapWriteLogButton:Enable()
	end

end

function Recap_FormatLevel(arg1)

    if arg1 and arg==-1 then
		return "??"
	elseif arg1 and tonumber(arg1) and tonumber(arg1)>0 then
		return arg1
	else
		return ""
	end
end

function Recap_FormatClass(arg1)

	if classabr[arg1] then
		return classabr[arg1]
	else
		return ""
	end
end

-- removes character-specific 
function Recap_UseOneSettings()

	for i in recap_set do
		_,_,user = string.find(i,"^UserData:(.+)")
		if user and user~=recap_temp.p then
			recap_set["UserData:"..user] = nil
			recap[user] = nil
		end
	end
	recap.UseOneSettings = true

end

function RecapAnchor_OnEnter()
	Recap_OnTooltip(this:GetName())
end


function RecapAnchor_OnClick()

	set_anchor_buttons(this:GetName())

end
