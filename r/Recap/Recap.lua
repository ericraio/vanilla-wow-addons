--[[
		Recap 3.32 - Gello

		An AddOn for WoW to track and summarize all damage done around the user.
]]

Recap_Version = 3.32

--[[ local tables ]]

-- colors for the gauges
local gaugecolor = { ["DmgIn"] = { r=.66,g=.25,b=.25 }, ["DmgOut"] = { r=.25,g=.66,b=.35 }, ["Heal"] = { r=.25,g=.5,b=.85 },
					 ["Time"] = { r=.75, g=.75, b=.75 }, ["Kills"] = { r=.75, g=.75, b=.75 }, ["MaxHit"] = { r=.75, g=.75, b=.75 },
					 ["DPS"] = { r=.25, g=.66, b=.35 }, ["Over"] = { r=.25, g=.5, b=.85 } }

-- keys for (det)ails and (inc)oming data sets
local detkey =	{ ["HitsDmg"]="d", ["Hits"]="n", ["HitsMax"]="x", ["CritsDmg"]="D", ["Crits"]="N",
				  ["CritsMax"]="X", ["CritsEvents"]="e", ["Missed"]="m", ["TicksDmg"]="t", ["TicksMax"]="T" }
local inckey = { ["MeleeDamage"]="a", ["MeleeMax"]="b", ["MeleeHits"]="c", ["MeleeCrits"]="d", ["MeleeMissed"]="e",
				 ["MeleeDodged"]="f", ["MeleeParried"]="g", ["MeleeBlocked"]="h", ["NonMeleeDamage"]="i",
				 ["NonMeleeMax"]="j", ["NonMeleeHits"]="k", ["NonMeleeCrits"]="l", ["NonMeleeMissed"]="m" }

-- .Opt.x and its buttons
local recapbuttons = { ["Minimized"] = "RecapMinimizeButton", ["Pinned"] = "RecapPinButton",
					   ["Paused"] = "RecapPauseButton", ["SelfView"] = "RecapSelfViewButton" }


--[[ Saved Variables ]]

recap = {} -- options and current data
recap_set = {} -- fight data sets

--[[ Callback functions ]]

function Recap_OnLoad()

	this:RegisterEvent("VARIABLES_LOADED")
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
	this:RegisterEvent("UNIT_NAME_UPDATE")

	-- function overrides: recap.NormalExit is true on a successful /quit or /logout
	Recap_OldQuit = Quit
	Recap_OldLogout = Logout
	Recap_OldCancelLogout = CancelLogout
	Quit = function() recap.NormalExit = true; Recap_OldQuit(); end
	Logout = function() recap.NormalExit = true; Recap_OldLogout(); end
	CancelLogout = function() recap.NormalExit = nil; Recap_OldCancelLogout(); end

end

function Recap_OnEvent()

	if event=="VARIABLES_LOADED" then

		SlashCmdList["RecapCOMMAND"] = Recap_SlashHandler
		SLASH_RecapCOMMAND1 = "/Recap"

	elseif event=="PLAYER_ENTERING_WORLD" or event=="UNIT_NAME_UPDATE" then
		Recap_Initialize()

	elseif event=="PLAYER_REGEN_DISABLED" then
		if recap.Opt.LimitFights.value then
			Recap_StartFight()
		end

	elseif event=="PLAYER_REGEN_ENABLED" then
		Recap_EndFight()

	elseif event=="PARTY_MEMBERS_CHANGED" or event=="RAID_ROSTER_UPDATE" then
		Recap_MakeFriends()

	elseif event=="CHAT_MSG_CHANNEL_NOTICE" then
		if string.find(arg4,"recaplog"..string.lower(UnitName("player"))) and arg1=="YOU_JOINED" then
			RecapOpt_WriteLogLabel:SetText(RECAP_CHANNEL_JOINED_WRITING)
			ChatFrameLog(1)
			RecapFrame:UnregisterEvent("CHAT_MSG_CHANNEL_NOTICE")
			RecapFrame:RegisterEvent("CHAT_MSG_CHANNEL")
			Recap_WriteLog()
		end
	elseif event=="CHAT_MSG_CHANNEL" then
		if string.find(string.lower(arg4),"recaplog") and arg2==UnitName("player") and arg1=="EOF" then
			ChatFrameLog(0)
			RecapOpt_WriteLogLabel:SetText(RECAP_SAVE_TO_WOWCHATLOG_TXT)
			LeaveChannelByName("recaplog"..UnitName("player"))
			RecapFrame:UnregisterEvent("CHAT_MSG_CHANNEL")
			DEFAULT_CHAT_FRAME:AddMessage(recap_temp.Local.LogWritten)
		end
	end
end

function Recap_Idle_OnUpdate(arg1)

	-- timer to end idle fights if option checked
	if recap_temp.IdleTimer~=-1 and recap_temp.Loaded and recap.Opt.IdleFight.value then
		recap_temp.IdleTimer = recap_temp.IdleTimer + arg1
		if recap_temp.IdleTimer > recap.Opt.IdleFightTimer.value then
			recap_temp.IdleTimer = -1
			Recap_EndFight()
		end
	end

	-- if fighting and a plugin loaded or we're minimized, update min dps every half second
	if recap_temp.Loaded and recap_temp.UpdateTimer~=-1 and recap.Opt.State.value=="Active" and
	  ((IB_Recap_Update or TitanPanelRecap_Update) or recap.Opt.Minimized.value) then
		recap_temp.UpdateTimer = recap_temp.UpdateTimer + arg1
		if recap_temp.UpdateTimer>.5 then
			recap_temp.UpdateTimer = 0
			Recap_UpdateMinimizedDPS()
		end
	end
end

function Recap_OnUpdate(arg1)

	-- update fade timer if option checked
	if recap_temp.Loaded and recap.Opt.AutoFade.value and not recap.Opt.Minimized.value and MouseIsOver(RecapFrame) and recap_temp.FadeTimer<recap.Opt.AutoFadeTimer.value then
		recap_temp.FadeTimer = 0
	elseif recap_temp.Loaded and recap_temp.FadeTimer~=-1 and recap.Opt.AutoFade.value and not recap.Opt.Minimized.value then
		recap_temp.FadeTimer = recap_temp.FadeTimer + arg1
		if recap_temp.FadeTimer > recap.Opt.AutoFadeTimer.value then
			RecapFrame:SetAlpha( max(1-min(2*(recap_temp.FadeTimer-recap.Opt.AutoFadeTimer.value),1),.1))
			if recap_temp.FadeTimer > (recap.Opt.AutoFadeTimer.value+.5) then
				RecapFrame_Hide()
			end
		end
	end

	if recap_temp.Loaded and recap.Opt.AutoMinimize.value and recap_temp.Selected==0 then
		if not recap.Opt.Minimized.value and not MouseIsOver(RecapFrame) and not IsShiftKeyDown() then
			Recap_Minimize()
		elseif recap.Opt.Minimized.value and MouseIsOver(RecapFrame) and not IsShiftKeyDown() then
			Recap_Maximize()
		end
	end

end

function Recap_SlashHandler(arg1)

	Recap_Initialize()

	if arg1 and arg1=="reset" then
		RecapFrame:ClearAllPoints()
		RecapFrame:SetPoint("CENTER","UIParent","CENTER")
		RecapOptFrame:ClearAllPoints()
		RecapOptFrame:SetPoint("CENTER","UIParent","CENTER")
		Recap_SetView()
	elseif arg1=="debug" then
		if recap.debug then
			DEFAULT_CHAT_FRAME:AddMessage("recap.debug is ON. To turn it off: /recap debug off")
			for i=1,150 do
				if recap.debug_Filter[i] then
					DEFAULT_CHAT_FRAME:AddMessage("["..i.."] \""..recap.debug_Filter[i].pattern.."\" hits: "..recap.debug_Filter[i].hits..", total: "..recap.debug_Filter[i].total)
				end
			end
			DEFAULT_CHAT_FRAME:AddMessage("__ Filters not used __")
			Recap_DebugUnusedFilters("Filter")
			Recap_DebugUnusedFilters("HealFilter")
			Recap_DebugUnusedFilters("DeathFilter")
		else
			DEFAULT_CHAT_FRAME:AddMessage("recap.debug is OFF. To turn it on: /recap debug on")
		end
	elseif arg1=="debug on" then
		recap.debug = true
		DEFAULT_CHAT_FRAME:AddMessage("recap.debug is now ON.")
	elseif arg1=="debug off" then
		recap.debug = false
		DEFAULT_CHAT_FRAME:AddMessage("recap.debug is now OFF.")
	elseif arg1=="debug reset" then
		recap.debug_Filter = {}
		DEFAULT_CHAT_FRAME:AddMessage("recap.debug_Filter is RESET.")
	elseif string.find(arg1,"opt") then
		if RecapOptFrame:IsShown() then
			RecapOptFrame:Hide()
		else
			RecapOptFrame:Show()
		end
	elseif RecapFrame:IsShown() then
		RecapFrame_Hide()
		RecapOptFrame:Hide()
	else
		RecapFrame_Show()
		Recap_CheckWindowBounds()
		if recap.Opt.State.value == "Stopped" then
			Recap_SetState("Idle")
			recap.Opt.Paused.value = false
			Recap_SetButtons()
		end
	end
end

--[[ Window appearance functions ]]

function Recap_SetState(arg1)
	if arg1 then
		recap.Opt.State.value = arg1
	end
	if recap.Opt.State.value=="Stopped" then
		RecapStatusTexture:SetVertexColor(1,0,0)
		Recap_Unregister_CombatEvents()
	elseif recap.Opt.State.value=="Active" then
		RecapStatusTexture:SetVertexColor(0,1,0)
		Recap_Register_CombatEvents()
	else
		RecapStatusTexture:SetVertexColor(.5,.5,.5)
		Recap_Register_CombatEvents()
	end
	Recap_UpdatePlugins()
end		

function RecapFrame_Hide()

	if not recap_temp.Loaded then
		Recap_Initialize()
	end
	recap_temp.FadeTimer = -1
	RecapFrame:SetAlpha(1)
	RecapFrame:Hide()
	recap.Opt.Visible.value = false
end

function RecapFrame_Show()

	if not recap_temp.Loaded then
		Recap_Initialize()
	end
	RecapFrame:Show()
	recap.Opt.Visible.value = true
end

function RecapOptFrame_Hide()
--[[
	RecapSetEditBox:SetText("")
	RecapSetEditBox:ClearFocus()
	if RecapOptClipFrame:IsVisible() then
		RecapClipEditBox:ClearFocus()
		RecapOptClipFrame:Hide()
		RecapOptSubFrame4:Show()
	end
]]
	RecapOptFrame:Hide()
end

function RecapFrame_Toggle()
    if RecapFrame:IsShown() then
        RecapFrame_Hide()
        RecapOptFrame:Hide()
    else
        RecapFrame_Show()
    end
end

function Recap_Shutdown()

	recap.Opt.Paused.value = true
	Recap_EndFight()
	Recap_SetState("Stopped")
	Recap_SetButtons()
	RecapOptFrame:Hide()
	RecapFrame_Hide()
	RecapCombatEvents:UnregisterAll()
end
 
function Recap_ToggleView()

	if recap.Opt.View.value=="All" then
		Recap_SetView("Last")
	else
		Recap_SetView("All")
	end
end

-- changes button textures depending on their state
function Recap_SetButtons()

	local i

	for i in recapbuttons do
		if recap.Opt[i].value then
			getglobal(recapbuttons[i]):SetNormalTexture("Interface\\AddOns\\Recap\\RecapButtons-Down")
			getglobal(recapbuttons[i]):SetPushedTexture("Interface\\AddOns\\Recap\\RecapButtons-Up")
		else
			getglobal(recapbuttons[i]):SetNormalTexture("Interface\\AddOns\\Recap\\RecapButtons-Up")
			getglobal(recapbuttons[i]):SetPushedTexture("Interface\\AddOns\\Recap\\RecapButtons-Down")
		end
	end

	if recap.Opt.View.value=="Last" then
		RecapShowAllButton:SetNormalTexture("Interface\\AddOns\\Recap\\RecapButtons-Up")
		RecapShowAllButton:SetPushedTexture("Interface\\AddOns\\Recap\\RecapButtons-Down")
	else
		RecapShowAllButton:SetNormalTexture("Interface\\AddOns\\Recap\\RecapButtons-Down")
		RecapShowAllButton:SetPushedTexture("Interface\\AddOns\\Recap\\RecapButtons-Up")
	end
end

-- this resizes the window width to the columns defined in options
function Recap_SetColumns()

	local cx = 168 -- 8(edge)+120(name)+32(scroll)+8(edge)
	
	local i,j,icx,item

	RecapHeader_Name:Show()
	RecapTotals:Show()

	if recap.Opt.SelfView.value then
		for i in recap.Opt do
			if recap.Opt[i].ewidth then
				if recap.Opt[i].value then
					getglobal("RecapHeader_"..i):SetWidth(recap_temp.DefaultOpt[i].ewidth)
					getglobal("RecapHeader_"..i):Show()
					for j=1,15 do
						getglobal("RecapSelf"..j.."_"..i):SetWidth(recap_temp.DefaultOpt[i].ewidth)
						getglobal("RecapSelf"..j.."_"..i):Show()
					end
					cx = cx + recap_temp.DefaultOpt[i].ewidth
				else
					getglobal("RecapHeader_"..i):SetWidth(1)
					getglobal("RecapHeader_"..i):Hide()
					for j=1,15 do
						getglobal("RecapSelf"..j.."_"..i):SetWidth(1)
						getglobal("RecapSelf"..j.."_"..i):Hide()
					end
					cx = cx + 1
				end
			elseif recap.Opt[i].width then
				getglobal("RecapHeader_"..i):Hide()
			end
		end

		RecapHeader_EName:Show()
		RecapHeader_Name:Hide()
		RecapTotals:Hide()

		for i=1,15 do
			getglobal("RecapList"..i):Hide()
			getglobal("RecapSelf"..i):Show()
			getglobal("RecapSelf"..i):SetWidth(cx-48)
		end
		RecapTotals_DPSIn:Hide()

	else

		for i in recap.Opt do
			if recap.Opt[i].width then
				if recap.Opt[i].value then
					item = getglobal("RecapHeader_"..i)
					item:SetWidth(recap_temp.DefaultOpt[i].width)
					item:Show()
					item = getglobal("RecapTotals_"..i)
					item:SetWidth(recap_temp.DefaultOpt[i].width)
					item:Show()
					for j=1,15 do
						item = getglobal("RecapList"..j.."_"..i)
						item:SetWidth(recap_temp.DefaultOpt[i].width)
						item:Show()
					end
					cx = cx + recap_temp.DefaultOpt[i].width
				else
					item = getglobal("RecapHeader_"..i)
					item:SetWidth(1)
					item:Hide()
					item = getglobal("RecapTotals_"..i)
					item:SetWidth(1)
					item:Hide()
					for j=1,15 do
						item = getglobal("RecapList"..j.."_"..i)
						item:SetWidth(1)
						item:Hide()
					end
					cx = cx + 1
				end
			elseif recap.Opt[i].ewidth then
				getglobal("RecapHeader_"..i):Hide()
			end
		end

		for i=1,15 do
			getglobal("RecapSelf"..i):Hide()
			getglobal("RecapList"..i):Show()
			getglobal("RecapList"..i):SetWidth(cx-48)
		end
		RecapHeader_EName:Hide()

		if recap.Opt.DPSIn.value then
			RecapTotals_DPSIn:Show()
		else
			RecapTotals_DPSIn:Hide()
		end

	end

	RecapTotals:SetWidth(cx-48)

	if recap.Opt.GrowLeftwards.value and RecapFrame then
		i = RecapFrame:GetRight()
		j = RecapFrame:GetTop()
		if i and j then
			RecapFrame:ClearAllPoints()
			RecapFrame:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",i-cx,j) -- *** i not defined sometimes :( **
		end
	end

	RecapTopBar:SetWidth(cx-8)
	RecapBottomBar:SetWidth(cx-16)
	RecapFrame:SetWidth(cx)
	RecapScrollBar:SetWidth(cx-16)

	recap_temp.GaugeWidth = cx-51 - ( (not recap.Opt.SelfView.value) and ((((recap.Opt.Faction.value and recap.Opt.Faction.width) or 1) + ((recap.Opt.Class.value and recap.Opt.Class.width) or 1) + ((recap.Opt.Ranks.value and recap.Opt.Ranks.width) or 1)) or 0) or 0)

	Recap_CheckWindowBounds()
	Recap_SetView()
	RecapScrollBar_Update()

end

-- changes view mode
function Recap_SetView(arg1)

	local text

		if arg1 then
			recap.Opt.View.value = arg1
		end

		Recap_SetButtons()
		Recap_ConstructList()

		cx = RecapFrame:GetWidth()

		-- change titlebar
		if cx and cx>300 and recap.Opt.SelfView.value then
			text = recap_temp.Player.."'s Details"
		elseif cx and cx>230 and recap.Opt.SelfView.value then
			text = recap_temp.Player
		elseif cx and cx<230 or recap.Opt.Minimized.value then
			text = ""
			if cx>180 and not recap.Opt.SelfView.value then
				text = recap.Opt.View.value
			end		
		elseif cx and cx<260 then
			text = recap_temp.Local.LastAll[recap.Opt.View.value]
		else
			text = "Recap of "..recap_temp.Local.LastAll[recap.Opt.View.value]
		end

		RecapTitle:SetText(text)
		RecapHeader_Name:SetText((recap_temp.ListSize-1).." Combatants")
		Recap_ChangeBack()
end

function Recap_SetColors()

	if recap.Opt.UseColor.value then
		recap_temp.ColorDmgIn = recap_temp.ColorRed
		recap_temp.ColorDmgOut = recap_temp.ColorGreen
		recap_temp.ColorHeal = recap_temp.ColorBlue
		recap_temp.ColorHits = recap_temp.ColorCyan
		recap_temp.ColorTicks = recap_temp.ColorYellow
		recap_temp.ColorCrits = recap_temp.ColorLime
		recap_temp.ColorMiss = recap_temp.ColorPink
	else
		recap_temp.ColorDmgIn = recap_temp.ColorWhite
		recap_temp.ColorDmgOut = recap_temp.ColorNone
		recap_temp.ColorHeal = recap_temp.ColorWhite
		recap_temp.ColorHits = recap_temp.ColorWhite
		recap_temp.ColorTicks = recap_temp.ColorWhite
		recap_temp.ColorCrits = recap_temp.ColorWhite
		recap_temp.ColorMiss = recap_temp.ColorWhite
	end

	RecapTotals_DmgIn:SetTextColor(recap_temp.ColorDmgIn.r,recap_temp.ColorDmgIn.g,recap_temp.ColorDmgIn.b)
	RecapTotals_DmgOut:SetTextColor(recap_temp.ColorDmgOut.r,recap_temp.ColorDmgOut.g,recap_temp.ColorDmgOut.b)
	RecapTotals_DPS:SetTextColor(recap_temp.ColorDmgOut.r,recap_temp.ColorDmgOut.g,recap_temp.ColorDmgOut.b)
	RecapTotals_DPSvsAll:SetTextColor(recap_temp.ColorDmgOut.r,recap_temp.ColorDmgOut.g,recap_temp.ColorDmgOut.b)
	RecapTotals_DPSIn:SetTextColor(recap_temp.ColorDmgIn.r,recap_temp.ColorDmgIn.g,recap_temp.ColorDmgIn.b)
	RecapTotals_Heal:SetTextColor(recap_temp.ColorHeal.r,recap_temp.ColorHeal.g,recap_temp.ColorHeal.b)
	RecapTotals_Over:SetTextColor(recap_temp.ColorHeal.r,recap_temp.ColorHeal.g,recap_temp.ColorHeal.b)
	RecapMinDPSIn_Text:SetTextColor(recap_temp.ColorDmgIn.r,recap_temp.ColorDmgIn.g,recap_temp.ColorDmgIn.b)
	RecapMinDPSOut_Text:SetTextColor(recap_temp.ColorDmgOut.r,recap_temp.ColorDmgOut.g,recap_temp.ColorDmgOut.b)
	for i=1,15 do
		getglobal("RecapList"..i.."_HealP"):SetTextColor(recap_temp.ColorHeal.r,recap_temp.ColorHeal.g,recap_temp.ColorHeal.b)
		getglobal("RecapList"..i.."_Over"):SetTextColor(recap_temp.ColorHeal.r,recap_temp.ColorHeal.g,recap_temp.ColorHeal.b)
		getglobal("RecapList"..i.."_DmgInP"):SetTextColor(recap_temp.ColorDmgIn.r,recap_temp.ColorDmgIn.g,recap_temp.ColorDmgIn.b)
		getglobal("RecapList"..i.."_DmgOutP"):SetTextColor(recap_temp.ColorDmgOut.r,recap_temp.ColorDmgOut.g,recap_temp.ColorDmgOut.b)
		getglobal("RecapSelf"..i.."_EHits"):SetTextColor(recap_temp.ColorHits.r,recap_temp.ColorHits.g,recap_temp.ColorHits.b)
		getglobal("RecapSelf"..i.."_EHitsAvg"):SetTextColor(recap_temp.ColorHits.r,recap_temp.ColorHits.g,recap_temp.ColorHits.b)
		getglobal("RecapSelf"..i.."_EHitsMax"):SetTextColor(recap_temp.ColorHits.r,recap_temp.ColorHits.g,recap_temp.ColorHits.b)
		getglobal("RecapSelf"..i.."_ETicks"):SetTextColor(recap_temp.ColorTicks.r,recap_temp.ColorTicks.g,recap_temp.ColorTicks.b)
		getglobal("RecapSelf"..i.."_ETicksAvg"):SetTextColor(recap_temp.ColorTicks.r,recap_temp.ColorTicks.g,recap_temp.ColorTicks.b)
		getglobal("RecapSelf"..i.."_ETicksMax"):SetTextColor(recap_temp.ColorTicks.r,recap_temp.ColorTicks.g,recap_temp.ColorTicks.b)
		getglobal("RecapSelf"..i.."_ECrits"):SetTextColor(recap_temp.ColorCrits.r,recap_temp.ColorCrits.g,recap_temp.ColorCrits.b)
		getglobal("RecapSelf"..i.."_ECritsAvg"):SetTextColor(recap_temp.ColorCrits.r,recap_temp.ColorCrits.g,recap_temp.ColorCrits.b)
		getglobal("RecapSelf"..i.."_ECritsMax"):SetTextColor(recap_temp.ColorCrits.r,recap_temp.ColorCrits.g,recap_temp.ColorCrits.b)
		getglobal("RecapSelf"..i.."_ECritsP"):SetTextColor(recap_temp.ColorCrits.r,recap_temp.ColorCrits.g,recap_temp.ColorCrits.b)
		getglobal("RecapSelf"..i.."_EMiss"):SetTextColor(recap_temp.ColorMiss.r,recap_temp.ColorMiss.g,recap_temp.ColorMiss.b)
		getglobal("RecapSelf"..i.."_EMissP"):SetTextColor(recap_temp.ColorMiss.r,recap_temp.ColorMiss.g,recap_temp.ColorMiss.b)
	end
	Recap_ChangeBack()
end

function Recap_ChangeBack()

	if recap.Opt.UseColor.value and (recap.Opt.MinBack.value or not recap.Opt.Minimized.value) then

		if recap.Opt.SelfView.value and not recap.Opt.Minimized.value then
			RecapTitleBack:SetVertexColor(0,0,.8)
		elseif recap.Opt.View.value=="Last" then
			RecapTitleBack:SetVertexColor(0,.66,0)
		else
			RecapTitleBack:SetVertexColor(.66,0,0)
		end
		RecapTitleBack:Show()
	else
		RecapTitleBack:Hide()
	end
end


--[[ Initialization ]]

-- Can be called often, will immediately dump out if it ran through successfully
function Recap_Initialize()

	local i,x
	local init_time

	if not recap_temp.Loaded then

		if UnitName("player") and UnitName("player")~=UNKNOWNOBJECT and RecapFrame and RecapOptFrame then

			init_time = GetTime()

			recap_temp.Player = UnitName("player")
			recap_temp.Server = GetCVar("realmName")

			-- recap index for this player
			recap_temp.p = recap_temp.Player..recap_temp.Server -- use for stuff that can be made global
			recap_temp.s = recap_temp.Player..recap_temp.Server -- use for stuff that should never be global

			if recap and recap.UseOneSettings and recap.User then
				recap_temp.p = recap.User
			end

			-- sources of damage/heals otherwise not declared in chat spam
			recap_temp.FilterIndex[6] = recap_temp.Player
			recap_temp.FilterIndex[7] = "Melee"
			recap_temp.FilterIndex[8] = "Damage Shields"
			recap_temp.FilterIndex[13] = 0

			Recap_InitializeData()

			if not recap[recap_temp.p].WindowTop and RecapFrame then
				RecapFrame:ClearAllPoints()
				RecapFrame:SetPoint("CENTER","UIParent","CENTER")
				RecapOptFrame:ClearAllPoints()
				RecapOptFrame:SetPoint("CENTER", "UIParent", "CENTER")
			elseif recap[recap_temp.p].WindowTop and RecapFrame then
				RecapFrame:ClearAllPoints()
				RecapFrame:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",recap[recap_temp.p].WindowLeft,recap[recap_temp.p].WindowTop)
				RecapFrame:SetWidth(recap[recap_temp.p].WindowWidth)
				RecapFrame:SetHeight(recap[recap_temp.p].WindowHeight)
			end

			for i in recap.Combatant do
				recap.Combatant[i].WasInLast = false
				recap.Combatant[i].WasInCurrent = false
			end
			recap[recap_temp.p].LastDuration = 0

			Recap_SetColors()

			-- if we loaded out of stopped state, force into idle state
			if recap.Opt.State.value ~= "Stopped" then
				recap.Opt.State.value = "Idle"
			end
			Recap_SetState()

			RecapTotals_Name:SetWidth(82)

			Recap_InitDataSets()

			if recap.Opt.LightData.value then
				recap.Opt.SelfView.value = false
				RecapSelfViewButton:Hide()
			end

			if recap.Opt.Minimized.value then
				Recap_SetButtons()
				Recap_ConstructList()
				Recap_Minimize()
			else
				Recap_Maximize()
			end

			-- we're in the world (in theory), register active events
			this:RegisterEvent("PLAYER_REGEN_DISABLED")
			this:RegisterEvent("PLAYER_REGEN_ENABLED")
			this:RegisterEvent("PARTY_MEMBERS_CHANGED")
			this:RegisterEvent("RAID_ROSTER_UPDATE")

			Recap_Register_CombatEvents()

			recap_temp.Loaded = true

			Recap_InitializeOptions()
			Recap_MoveMinimize()

			-- initialize panel
			recap_temp.Selected = 0
			if recap.Opt.LightData.value then
				recap.Opt.PanelView.value = 3
				RecapPanelTab1:SetAlpha(.5)
				RecapPanelTab2:SetAlpha(.5)
			end
			RecapPanel_SwitchPanels(recap.Opt.PanelView.value)
			if recap.Opt.PanelAnchor.value then
				RecapPanel:ClearAllPoints()
				RecapPanel:SetPoint(recap.Opt.PanelAnchor.Panel,"RecapFrame",recap.Opt.PanelAnchor.Main,Recap_PanelOffset("x"),Recap_PanelOffset("y"))
			end
			RecapPanelFaction:SetAlpha(.75)

			for i=1,15 do
				getglobal("RecapList"..i.."_Faction"):SetAlpha(.75)
			end

			if recap.Opt.Visible.value then
				RecapFrame_Show()
			else
				RecapFrame_Hide()
			end

			if recap.Opt.Paused.value then
				RecapFrame_Hide()
			end

			if recap.debug then
				DEFAULT_CHAT_FRAME:AddMessage("[recap.debug] Time to initialize: "..string.format("%.4f",GetTime()-init_time).." seconds.")
			end

			-- warn if user has a lot of data (over 500 combatants)
			x = 0
			for i in recap.Combatant do
				x = x + 1
			end
			if x>500 and recap.Opt.WarnData.value then
				StaticPopupDialogs["RECAP_LOTS_OF_DATA_WARNING"] = {
					text = TEXT(string.format(recap_temp.Local.LotsOfDataWarning,x)),
					button1 = TEXT(OKAY),
					timeout = 0,
					showAlert = 1,
					whileDead = 1
				}
				StaticPopup_Show("RECAP_LOTS_OF_DATA_WARNING")
			end

			table.insert(UISpecialFrames,"RecapOptFrame")
			table.insert(UISpecialFrames,"RecapPanel")

		end

	end

end

-- arg1==1 to hide buttons, 16 to show
function Recap_ShowButtons(arg1)

	RecapCloseButton:SetWidth(arg1)
	RecapPinButton:SetWidth(arg1)
	RecapPauseButton:SetWidth(arg1)
	RecapOptionsButton:SetWidth(arg1)
	RecapShowAllButton:SetWidth(arg1)

	if arg1==16 then
		RecapCloseButton:Show()
		RecapPinButton:Show()
		RecapPauseButton:Show()
		RecapOptionsButton:Show()
		RecapShowAllButton:Show()
	else
		RecapCloseButton:Hide()
		RecapPinButton:Hide()
		RecapPauseButton:Hide()
		RecapOptionsButton:Hide()
		RecapShowAllButton:Hide()
	end
end
		
function Recap_Minimize()

	local i,j
	local cx = 20 -- 8(edge)+4(space right of status)+8

	recap.Opt.Minimized.value = true

	for i in recap.Opt do
		if recap.Opt[i].minwidth then
			if recap.Opt[i].value then
				item = getglobal("Recap"..i)
				item:SetWidth(recap.Opt[i].minwidth)
				item:Show()
				cx = cx + recap.Opt[i].minwidth
			else
				item = getglobal("Recap"..i)
				item:SetWidth(1)
				item:Hide()
				cx = cx + 1
			end
		elseif recap.Opt[i].width or recap.Opt[i].ewidth then
			getglobal("RecapHeader_"..i):Hide()
		end
	end

	if recap.Opt.MinButtons.value then
		cx = cx + 108
		Recap_ShowButtons(16)
	else
		Recap_ShowButtons(1)
		cx = cx + 23 -- 5 + 18
	end

	RecapTitle:SetText(recap.Opt.View.value)

	RecapTopBar:Hide()
	RecapBottomBar:Hide()
	RecapTotals_DPSIn:Hide()
	RecapResetButton:Hide()
	for i=1,15 do
		getglobal("RecapList"..i):Hide()
		getglobal("RecapSelf"..i):Hide()
	end
	RecapTotals:Hide()
	RecapHeader_EName:Hide()
	RecapHeader_Name:Hide()
	RecapScrollBar:Hide()

	if recap.Opt.AutoMinimize.value then
		cx = cx-15
	end

	if recap.Opt.GrowLeftwards.value and RecapFrame then
		i = RecapFrame:GetRight()
		j = RecapFrame:GetTop()
		if i and j then
			RecapFrame:ClearAllPoints()
			RecapFrame:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",i-cx,j)
		end
	end
	RecapFrame:SetWidth(cx)
	Recap_SetHeight(28)

	if recap.Opt.MinBack.value then
		RecapFrame:SetBackdropColor(1,1,1,1)
		RecapFrame:SetBackdropBorderColor(.5,.5,.5,1)
	else
		RecapFrame:SetBackdropColor(0,0,0,0)
		RecapFrame:SetBackdropBorderColor(0,0,0,0)
	end

	RecapSelfViewButton:Hide()
	RecapPanel_Hide(1)
	Recap_MoveMinimize()
	Recap_ChangeBack()

	RecapMinView:GetLeft()

end

function Recap_Maximize()

	recap.Opt.Minimized.value = false

	for i in recap.Opt do
		if recap.Opt[i].minwidth then
			item = getglobal("Recap"..i)
			item:SetWidth(recap.Opt[i].minwidth)
			item:Hide()
		end
	end
	RecapMinStatus:Show()
	RecapMinView:Show()
	Recap_ShowButtons(16)

	RecapTopBar:Show()
	RecapBottomBar:Show()
	RecapResetButton:Show()

	RecapTotals:Show()
	RecapHeader_Name:Show()

	RecapScrollBar:Show()
	Recap_SetColumns()

	RecapFrame:SetBackdropColor(1,1,1,1)
	RecapFrame:SetBackdropBorderColor(.5,.5,.5,1)
	if not recap.Opt.LightData.value then
		RecapSelfViewButton:Show()
	end
	Recap_MoveMinimize()
end

function Recap_SetHeight(newcy)

	local i,j

	if recap.Opt.GrowUpwards.value and RecapFrame then
		i = RecapFrame:GetBottom()
		j = RecapFrame:GetLeft()
		if i and j then
			RecapFrame:ClearAllPoints()
			RecapFrame:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",j,i+newcy)
		end
	end

	RecapFrame:SetHeight(newcy)
	Recap_CheckWindowBounds()
end

function RecapScrollBar_Update()

	local i, index, item
	local listsize = recap.Opt.SelfView.value and recap_temp.SelfListSize or recap_temp.ListSize


	if not recap.Opt.Minimized.value then

		i = 72 + ( math.max( math.min(listsize-1,recap.Opt.MaxRows.value),1 )*14 ) 
		Recap_SetHeight(i)
		RecapScrollBar:SetHeight(i-63)
		FauxScrollFrame_Update(RecapScrollBar,listsize-1,recap.Opt.MaxRows.value,10)

		for i=1,recap.Opt.MaxRows.value do
			index = i + FauxScrollFrame_GetOffset(RecapScrollBar)

			if not recap.Opt.SelfView.value then

				if index < listsize then

					getglobal("RecapList"..i.."_Ranks"):SetText(index..".")

					Recap_SetFactionIcon(i,recap.Combatant[recap_temp.List[index].Name].Faction)
					Recap_SetClassIcon(i,recap.Combatant[recap_temp.List[index].Name].Class)
					if recap.Opt.Faction.value and recap.Combatant[recap_temp.List[index].Name].Level==-1 then
						getglobal("RecapList"..i.."_Level"):SetText("??")
					elseif recap.Opt.Faction.value and recap.Combatant[recap_temp.List[index].Name].Level and tonumber(recap.Combatant[recap_temp.List[index].Name].Level)>0 then
						getglobal("RecapList"..i.."_Level"):SetText(recap.Combatant[recap_temp.List[index].Name].Level)
					else
						getglobal("RecapList"..i.."_Level"):SetText(" ")
					end

					item = getglobal("RecapList"..i.."_Name")
					item:SetText(recap_temp.List[index].Name)
					if recap.Combatant[recap_temp.List[index].Name].Friend then
						item:SetTextColor(recap_temp.ColorDmgOut.r,recap_temp.ColorDmgOut.g,recap_temp.ColorDmgOut.b)
					else
						item:SetTextColor(recap_temp.ColorWhite.r,recap_temp.ColorWhite.g,recap_temp.ColorWhite.b)
					end

					item = getglobal("RecapList"..i.."_Gauge")
					if recap.Opt.ShowGauges.value and recap_temp.GaugeMax>0 and recap.Combatant[recap_temp.List[index].Name].Friend and recap_temp.GaugeBy then
						item:SetWidth(1+recap_temp.GaugeWidth*recap_temp.List[index][recap_temp.GaugeBy]/recap_temp.GaugeMax)
						item:Show()
					else
						item:Hide()
					end

					getglobal("RecapList"..i.."_Kills"):SetText(recap_temp.List[index].Kills)

					getglobal("RecapList"..i.."_Time"):SetText(Recap_FormatTime(recap_temp.List[index].Time))

					item = getglobal("RecapList"..i.."_Heal")
					item:SetText(recap_temp.List[index].Heal)
					if recap.Combatant[recap_temp.List[index].Name].Friend then
						item:SetTextColor(recap_temp.ColorHeal.r,recap_temp.ColorHeal.g,recap_temp.ColorHeal.b)
					else
						item:SetTextColor(recap_temp.ColorWhite.r,recap_temp.ColorWhite.g,recap_temp.ColorWhite.b)
					end

					getglobal("RecapList"..i.."_HealP"):SetText(recap.Combatant[recap_temp.List[index].Name].Friend and recap_temp.List[index].HealP.."%" or "")
					getglobal("RecapList"..i.."_Over"):SetText(recap.Combatant[recap_temp.List[index].Name].Friend and recap_temp.List[index].Over.."%" or "")

					getglobal("RecapList"..i.."_MaxHit"):SetText(recap_temp.List[index].MaxHit)

					item = getglobal("RecapList"..i.."_DmgIn")
					item:SetText(recap_temp.List[index].DmgIn)
					if recap.Combatant[recap_temp.List[index].Name].Friend then
						item:SetTextColor(recap_temp.ColorDmgIn.r,recap_temp.ColorDmgIn.g,recap_temp.ColorDmgIn.b)
					else
						item:SetTextColor(recap_temp.ColorWhite.r,recap_temp.ColorWhite.g,recap_temp.ColorWhite.b)
					end

					getglobal("RecapList"..i.."_DmgInP"):SetText(recap.Combatant[recap_temp.List[index].Name].Friend and recap_temp.List[index].DmgInP.."%" or "")

					item = getglobal("RecapList"..i.."_DmgOut")
					item:SetText(recap_temp.List[index].DmgOut)
					if recap.Combatant[recap_temp.List[index].Name].Friend then
						item:SetTextColor(recap_temp.ColorDmgOut.r,recap_temp.ColorDmgOut.g,recap_temp.ColorDmgOut.b)
					else
						item:SetTextColor(recap_temp.ColorWhite.r,recap_temp.ColorWhite.g,recap_temp.ColorWhite.b)
					end

					getglobal("RecapList"..i.."_DmgOutP"):SetText(recap.Combatant[recap_temp.List[index].Name].Friend and recap_temp.List[index].DmgOutP.."%" or "")

					item = getglobal("RecapList"..i.."_DPS")
					item:SetText(format(recap_temp.List[index].DPS<1000 and "%.1f" or "%d",recap_temp.List[index].DPS))
					if recap.Combatant[recap_temp.List[index].Name].Friend then
						item:SetTextColor(recap_temp.ColorDmgOut.r,recap_temp.ColorDmgOut.g,recap_temp.ColorDmgOut.b)
					else
						item:SetTextColor(recap_temp.ColorWhite.r,recap_temp.ColorWhite.g,recap_temp.ColorWhite.b)
					end
					item = getglobal("RecapList"..i.."_DPSvsAll")
					item:SetText(format(recap_temp.List[index].DPSvsAll<1000 and "%.1f" or "%d",recap_temp.List[index].DPSvsAll))
					if recap.Combatant[recap_temp.List[index].Name].Friend then
						item:SetTextColor(recap_temp.ColorDmgOut.r,recap_temp.ColorDmgOut.g,recap_temp.ColorDmgOut.b)
					else
						item:SetTextColor(recap_temp.ColorWhite.r,recap_temp.ColorWhite.g,recap_temp.ColorWhite.b)
					end

					item = getglobal("RecapList"..i)
					item:Show()
					if recap_temp.Selected == index then
						item:LockHighlight()
					else
						item:UnlockHighlight()
					end

				else
					getglobal("RecapList"..i):Hide()
					getglobal("RecapList"..i):UnlockHighlight()
				end

				for i=recap.Opt.MaxRows.value+1,15 do
					getglobal("RecapList"..i):Hide()
				end

			elseif recap.Opt.SelfView.value then

				if index < listsize then

					getglobal("RecapSelf"..i.."_EName"):SetText(string.sub(recap_temp.SelfList[index].EName,2))
					getglobal("RecapSelf"..i.."_ETotal"):SetText(recap_temp.SelfList[index].ETotal)
					getglobal("RecapSelf"..i.."_EHits"):SetText(recap_temp.SelfList[index].EHits)
					getglobal("RecapSelf"..i.."_ETicks"):SetText(recap_temp.SelfList[index].ETicks)
					getglobal("RecapSelf"..i.."_ECrits"):SetText(recap_temp.SelfList[index].ECrits)
					getglobal("RecapSelf"..i.."_EHitsAvg"):SetText(recap_temp.SelfList[index].EHitsAvg)
					getglobal("RecapSelf"..i.."_ETicksAvg"):SetText(recap_temp.SelfList[index].ETicksAvg)
					getglobal("RecapSelf"..i.."_ECritsAvg"):SetText(recap_temp.SelfList[index].ECritsAvg)
					getglobal("RecapSelf"..i.."_EHitsMax"):SetText(recap_temp.SelfList[index].EHitsMax)
					getglobal("RecapSelf"..i.."_ETicksMax"):SetText(recap_temp.SelfList[index].ETicksMax)
					getglobal("RecapSelf"..i.."_ECritsMax"):SetText(recap_temp.SelfList[index].ECritsMax)
					getglobal("RecapSelf"..i.."_ECritsP"):SetText(recap_temp.SelfList[index].ECritsP)
					getglobal("RecapSelf"..i.."_EMiss"):SetText(recap_temp.SelfList[index].EMiss)
					getglobal("RecapSelf"..i.."_EMissP"):SetText(recap_temp.SelfList[index].EMissP)
					getglobal("RecapSelf"..i.."_EMaxAll"):SetText(recap_temp.SelfList[index].EMaxAll)
					getglobal("RecapSelf"..i.."_ETotalP"):SetText(recap_temp.SelfList[index].ETotalP)
					if string.sub(recap_temp.SelfList[index].EName,1,1)<"3" then
						getglobal("RecapSelf"..i.."_EName"):SetTextColor(recap_temp.ColorDmgOut.r,recap_temp.ColorDmgOut.g,recap_temp.ColorDmgOut.b)
						getglobal("RecapSelf"..i.."_ETotal"):SetTextColor(recap_temp.ColorDmgOut.r,recap_temp.ColorDmgOut.g,recap_temp.ColorDmgOut.b)
						getglobal("RecapSelf"..i.."_ETotalP"):SetTextColor(recap_temp.ColorDmgOut.r,recap_temp.ColorDmgOut.g,recap_temp.ColorDmgOut.b)
					else
						getglobal("RecapSelf"..i.."_EName"):SetTextColor(recap_temp.ColorHeal.r,recap_temp.ColorHeal.g,recap_temp.ColorHeal.b)
						getglobal("RecapSelf"..i.."_ETotal"):SetTextColor(recap_temp.ColorHeal.r,recap_temp.ColorHeal.g,recap_temp.ColorHeal.b)
						getglobal("RecapSelf"..i.."_ETotalP"):SetTextColor(recap_temp.ColorHeal.r,recap_temp.ColorHeal.g,recap_temp.ColorHeal.b)
					end						
					getglobal("RecapSelf"..i):Show()
				else
					getglobal("RecapSelf"..i):Hide()
				end

				for i=recap.Opt.MaxRows.value+1,15 do
					getglobal("RecapSelf"..i):Hide()
				end

			end

		end

	end
end

--[[ Fight functions ]]

function Recap_CreateCombatant(arg1,is_source)

	if not arg1 then
		return
	end

	-- if arg1 not a .Combatant, add an entry for them
	if not recap.Combatant[arg1] then
		Recap_CreateBlankCombatant(arg1)
	end
	-- if they haven't fought this session, add a .Last entry for them
	if not recap_temp.Last[arg1] then
		recap_temp.Last[arg1] = { Start = 0, End = 0, DmgIn = 0, DmgOut = 0, MaxHit = 0, Kills = 0, Heal = 0 }
	end
	-- if arg1 is hitting others, update their start or end time
	if is_source then

		if recap_temp.FightStart==0 then
			recap_temp.FightStart = GetTime()
			recap_temp.FightEnd = recap_temp.FightStart
		else
			recap_temp.FightEnd = GetTime()
		end

		if recap_temp.Last[arg1].Start==0 then
			recap_temp.Last[arg1].Start = GetTime()
			recap_temp.Last[arg1].End = recap_temp.Last[arg1].Start
		else
			recap_temp.Last[arg1].End = GetTime()
		end
	end

	recap.Combatant[arg1].WasInCurrent = true
end

function Recap_StartFight()

	local i

	if recap.Opt.State.value=="Idle" then
		if recap.Opt.AutoHide.value and not recap.Opt.Minimized.value then
			RecapFrame_Hide()
		end
		for i in recap.Combatant do
			recap.Combatant[i].WasInCurrent = false
		end
		if not recap.Opt.LimitFights.value and recap.Opt.IdleFight.value then
			recap_temp.IdleTimer = 0
		end
		RecapIdleFrame:Show() -- start idle OnUpdates
		Recap_SetState("Active")
	end
end

-- returns the current DPS of combatant named arg1 if it exists. UpdateDuration/DamageOut reused to save allocations
function Recap_GetCurrentDPS(arg1)

	if arg1 and recap_temp.Last[arg1] and recap_temp.Last[arg1].DmgOut>0 then
		recap_temp.UpdateDuration = recap_temp.Last[arg1].End - recap_temp.Last[arg1].Start
		if recap.Opt.View.value=="All" then
			recap_temp.UpdateDuration = recap_temp.UpdateDuration + recap.Combatant[arg1].TotalTime
		end
		recap_temp.UpdateDamageOut = recap_temp.Last[arg1].DmgOut
		if recap.Opt.View.value=="All" then
			recap_temp.UpdateDamageOut = recap_temp.UpdateDamageOut + recap.Combatant[arg1].TotalDmgOut
		end

		if recap_temp.UpdateDuration > recap_temp.MinTime then
			return (recap_temp.UpdateDamageOut / recap_temp.UpdateDuration)
		end
	end

	return 0
end

function Recap_UpdateMinimizedDPS()

	if recap.Opt.State.value=="Active" then

		if recap_temp.Last[recap_temp.Player] and recap_temp.Last[recap_temp.Player].DmgOut>0 then
			i = Recap_GetCurrentDPS(recap_temp.Player)+Recap_GetCurrentDPS(UnitName("pet"))
			RecapMinYourDPS_Text:SetText(string.format("%.1f",i))
		end

		-- calculate running total DPS In and Out
		recap_temp.UpdateDuration = 0
		if recap_temp.FightEnd>0 and recap_temp.FightStart>0 then
			recap_temp.UpdateDuration = recap_temp.FightEnd - recap_temp.FightStart
		end
		if recap.Opt.View.value=="All" then
			recap_temp.UpdateDuration = recap_temp.UpdateDuration + recap[recap_temp.p].TotalDuration
		end

		if recap_temp.UpdateDuration>recap_temp.MinTime then

			recap_temp.UpdateDmgIn = 0
			recap_temp.UpdateDmgOut = 0
			for i in recap_temp.Last do
				if recap.Combatant[i].Friend then
					recap_temp.UpdateDmgIn = recap_temp.UpdateDmgIn + recap_temp.Last[i].DmgIn
					recap_temp.UpdateDmgOut = recap_temp.UpdateDmgOut + recap_temp.Last[i].DmgOut
				end
			end

			if recap.Opt.View.value=="All" then
				for i in recap.Combatant do
					if recap.Combatant[i].Friend then
						recap_temp.UpdateDmgIn = recap_temp.UpdateDmgIn + recap.Combatant[i].TotalDmgIn
						recap_temp.UpdateDmgOut = recap_temp.UpdateDmgOut + recap.Combatant[i].TotalDmgOut
					end
				end
			end

			RecapMinDPSIn_Text:SetText(string.format("%.1f",recap_temp.UpdateDmgIn/recap_temp.UpdateDuration))
			RecapMinDPSOut_Text:SetText(string.format("%.1f",recap_temp.UpdateDmgOut/recap_temp.UpdateDuration))

		end

		Recap_UpdatePlugins()
	end
end

function Recap_AddPetToOwner(pet,owner)

	local earliest,latest
	local peteffect

	-- times are only for DAMAGE
	if (recap.Combatant[pet].WasInCurrent and recap_temp.Last[pet].DmgOut>0) and (recap.Combatant[owner].WasInCurrent and recap_temp.Last[owner].DmgOut>0) then
		-- both pet and owner were in fight
		earliest = math.min(recap_temp.Last[pet].Start,recap_temp.Last[owner].Start)
		latest = math.max(recap_temp.Last[pet].End,recap_temp.Last[owner].End)
		recap_temp.Last[owner].Start = earliest
		recap_temp.Last[owner].End = latest
	elseif (recap.Combatant[pet].WasInCurrent and recap_temp.Last[pet].DmgOut>0) and (not recap.Combatant[owner].WasInCurrent or recap_temp.Last[owner].DmgOut==0) then
		-- just the pet was in fight
		recap_temp.Last[owner].Start = recap_temp.Last[pet].Start
		recap_temp.Last[owner].End = recap_temp.Last[pet].End
	else
		return -- temp fix for attempt to index field ? (a nil value) in line below ***
	end

	recap_temp.Last[owner].DmgIn = recap_temp.Last[owner].DmgIn + recap_temp.Last[pet].DmgIn
	recap_temp.Last[owner].DmgOut = recap_temp.Last[owner].DmgOut + recap_temp.Last[pet].DmgOut
	recap_temp.Last[owner].MaxHit = math.max(recap_temp.Last[owner].MaxHit,recap_temp.Last[pet].MaxHit)

	Recap_AccumulateCombatant(owner)

	recap_temp.Last[pet].Start = 0
	recap_temp.Last[pet].End = 0
	recap_temp.Last[pet].DmgIn = 0
	recap_temp.Last[pet].DmgOut = 0
	recap_temp.Last[pet].MaxHit = 0
	recap_temp.Last[pet].Kills = 0
	recap_temp.Last[pet].Heal = 0
	recap.Combatant[pet].WasInLast = false
	recap.Combatant[owner].WasInLast = true
	recap.Combatant[pet].WasInCurrent = false
	recap.Combatant[owner].WasInCurrent = false

	if not recap.Opt.LightData.value then
		for i in recap.Combatant[pet].Detail do
			if string.sub(i,1,1)=="1" then
				peteffect = "2"..pet.."'s "..string.sub(i,2)
			else
				peteffect = "4"..pet.."'s "..string.sub(i,2)
			end
			recap.Combatant[owner].Detail[peteffect] = {
				Hits = recap.Combatant[pet].Detail[i].Hits, HitsDmg = recap.Combatant[pet].Detail[i].HitsDmg,
				HitsMax = recap.Combatant[pet].Detail[i].HitsMax, Crits = recap.Combatant[pet].Detail[i].Crits,
				CritsEvents = recap.Combatant[pet].Detail[i].CritsEvents, CritsDmg = recap.Combatant[pet].Detail[i].CritsDmg,
				CritsMax = recap.Combatant[pet].Detail[i].CritsMax, Missed = recap.Combatant[pet].Detail[i].Missed,
				TicksDmg = recap.Combatant[pet].Detail[i].TicksDmg, TicksMax = recap.Combatant[pet].Detail[i].TicksMax }
			if owner==recap_temp.Player then
				recap.Self[recap_temp.s][peteffect] = {
					Hits = recap.Combatant[pet].Detail[i].Hits, HitsDmg = recap.Combatant[pet].Detail[i].HitsDmg,
					HitsMax = recap.Combatant[pet].Detail[i].HitsMax, Crits = recap.Combatant[pet].Detail[i].Crits,
					CritsEvents = recap.Combatant[pet].Detail[i].CritsEvents, CritsDmg = recap.Combatant[pet].Detail[i].CritsDmg,
					CritsMax = recap.Combatant[pet].Detail[i].CritsMax, Missed = recap.Combatant[pet].Detail[i].Missed,
					TicksDmg = recap.Combatant[pet].Detail[i].TicksDmg, TicksMax = recap.Combatant[pet].Detail[i].TicksMax }
			end
		end
	end

end

function Recap_AccumulateCombatant(i)

	recap.Combatant[i].LastDmgIn = recap_temp.Last[i].DmgIn
	recap.Combatant[i].LastDmgOut = recap_temp.Last[i].DmgOut
	recap.Combatant[i].LastTime = recap_temp.Last[i].End-recap_temp.Last[i].Start
	recap.Combatant[i].LastMaxHit = recap_temp.Last[i].MaxHit
	recap.Combatant[i].LastKills = recap_temp.Last[i].Kills
	recap.Combatant[i].LastHeal = recap_temp.Last[i].Heal

	recap_temp.Last[i].Start = 0
	recap_temp.Last[i].End = 0
	recap_temp.Last[i].DmgIn = 0
	recap_temp.Last[i].DmgOut = 0
	recap_temp.Last[i].MaxHit = 0
	recap_temp.Last[i].Kills = 0
	recap_temp.Last[i].Heal = 0

	recap.Combatant[i].TotalDmgIn = recap.Combatant[i].TotalDmgIn + recap.Combatant[i].LastDmgIn
	recap.Combatant[i].TotalDmgOut = recap.Combatant[i].TotalDmgOut + recap.Combatant[i].LastDmgOut
	recap.Combatant[i].TotalTime = recap.Combatant[i].TotalTime + recap.Combatant[i].LastTime
	recap.Combatant[i].TotalKills = recap.Combatant[i].TotalKills + recap.Combatant[i].LastKills
	recap.Combatant[i].TotalHeal = recap.Combatant[i].TotalHeal + recap.Combatant[i].LastHeal

	if recap.Combatant[i].LastTime > recap_temp.MinTime then
		recap.Combatant[i].LastDPS = recap.Combatant[i].LastDmgOut/recap.Combatant[i].LastTime
	else
		recap.Combatant[i].LastDPS = 0
	end
	if recap.Combatant[i].TotalTime > recap_temp.MinTime then
		recap.Combatant[i].TotalDPS = recap.Combatant[i].TotalDmgOut/recap.Combatant[i].TotalTime
	else
		recap.Combatant[i].TotalDPS = 0
	end

	recap.Combatant[i].TotalMaxHit = math.max(recap.Combatant[i].LastMaxHit,recap.Combatant[i].TotalMaxHit)

	recap.Combatant[i].WasInLast = true
end

function Recap_EndFight()

	recap_temp.IdleTimer = -1

	RecapIdleFrame:Hide()

	if recap.Opt.State.value=="Active" then

		recap.Opt.State.value = "Stopped" -- suspend logging to calculate

		local debug_time = GetTime()

		Recap_MakeFriends()

		if recap_temp.FightEnd>recap_temp.FightStart then
			recap[recap_temp.p].LastDuration = recap_temp.FightEnd-recap_temp.FightStart
		else
			recap[recap_temp.p].LastDuration = 0
		end
		recap[recap_temp.p].TotalDuration = recap[recap_temp.p].TotalDuration + recap[recap_temp.p].LastDuration
		recap_temp.FightStart = 0
		recap_temp.FightEnd = 0

		recap_temp.ListSize = 1
		for i in recap_temp.Last do

			if recap.Combatant[i].WasInCurrent then
				if recap.Combatant[i].OwnedBy and recap.Opt.MergePets.value then
					Recap_AddPetToOwner(i,recap.Combatant[i].OwnedBy)
				elseif recap.Combatant[i].OwnsPet and recap.Opt.MergePets.value then
					Recap_AddPetToOwner(recap.Combatant[i].OwnsPet,i)
				else
					Recap_AccumulateCombatant(i)
				end
			else
				recap.Combatant[i].WasInLast = false
			end

		end

		if recap.Opt.AutoPost.value then
			recap.Opt.SortBy.value = Recap_AutoPostGetStatID(recap.Opt.AutoPost.Stat)
			recap.Opt.SortDir.value = false
		end

		Recap_ConstructList()
		Recap_SetState("Idle")

		if not recap.Opt.Minimized.value and recap.Opt.AutoHide.value then
			RecapFrame_Show()
			if recap.Opt.AutoFade.value then
				recap_temp.FadeTimer = 0
			end
		end

		if recap.Opt.AutoPost.value then
			Recap_PostFight()
		end

		if recap.Opt.AutoLeader.value then
			Recap_PostLeader()
		end

		if recap.debug then
			DEFAULT_CHAT_FRAME:AddMessage("[recap.debug] Fight processed in "..string.format("%.4f",GetTime()-debug_time).." seconds for "..(recap_temp.ListSize-1).." combatants.")
		end

	end
end

-- parses CHAT_MSG_SPELL/COMBAT messages to .Last running totals
function Recap_DamageEvent(arg1)

	local i, source, dest, damage, miss, effect
	local found = false
	local blocked = false

	if recap.Opt.State.value~="Stopped" then

		blocked = string.find(arg1,string.gsub(BLOCK_TRAILER,"%%d","%%d+")) -- true if (%d blocked)
		arg1 = string.gsub(arg1," %(.+%)","") -- strip trailing ()'s we don't use
		arg1 = string.gsub(arg1,"%.$","") -- strip trailing .'s

		for i=1,recap_temp.FilterSize do
			found,_,recap_temp.FilterIndex[1],recap_temp.FilterIndex[2],recap_temp.FilterIndex[3],recap_temp.FilterIndex[4],recap_temp.FilterIndex[5] = string.find(arg1,recap_temp.Filter[i].pattern)
			if found then

				source=recap_temp.FilterIndex[recap_temp.Filter[i].source]
				dest=recap_temp.FilterIndex[recap_temp.Filter[i].dest]
				if recap_temp.Local.SelfPronouns[string.lower(dest)] then
					dest = recap_temp.Player
				end
				if recap_temp.Filter[i].damage then
					damage=tonumber(recap_temp.FilterIndex[recap_temp.Filter[i].damage])
				end
				if recap_temp.Filter[i].effect then
					effect = recap_temp.FilterIndex[recap_temp.Filter[i].effect]
				end

				if (recap.Combatant[source] and recap.Combatant[source].Ignore) or (recap.Combatant[dest] and recap.Combatant[dest].Ignore) then
					return -- this is an ignored combatant, pretend the hit didn't happen at all
				end

				if not recap.Opt.LimitFights.value then
					if recap.Opt.IdleFight.value then
						recap_temp.IdleTimer = 0
					end
					if recap.Opt.State.value=="Idle" then
						Recap_StartFight()
					end
				end

				if recap.debug then
					if not recap.debug_Filter then
						recap.debug_Filter = {}
					end
					if not recap.debug_Filter[i] then
						recap.debug_Filter[i] = { hits=1, total=(damage or 1), pattern=recap_temp.Filter[i].pattern }
					else
						recap.debug_Filter[i].hits = recap.debug_Filter[i].hits + 1
						recap.debug_Filter[i].total = recap.debug_Filter[i].total + (damage or 1)
					end
					if recap_temp.Filter[i].watch then
						DEFAULT_CHAT_FRAME:AddMessage("["..i.."] \""..recap_temp.Filter[i].pattern.."\" triggered!")
						DEFAULT_CHAT_FRAME:AddMessage("source="..tostring(source)..", dest="..tostring(dest)..", damage="..tostring(damage)..", miss="..tostring(miss))
					end
				end

				if damage~=0 then -- if this wasn't just a cast
					Recap_CreateCombatant(source,1)
					Recap_CreateCombatant(dest)
					-- remove friend flag from hostiles no longer charmed
					if recap.Combatant[source].Friend and recap.Combatant[dest].Friend then
						recap.Combatant[source].Friend = false
					end
				else
					if (not recap.Opt.LightData.value) and recap.Combatant[source] and recap.Combatant[source].Detail["1"..effect] then
						Recap_CreateCombatant(source,1) -- if this was a cast that's done damage before, start timer
					end
				end

				if damage and damage>0 then
					-- process totals
					recap_temp.Last[source].DmgOut = recap_temp.Last[source].DmgOut + damage
					if damage > recap_temp.Last[source].MaxHit then
						recap_temp.Last[source].MaxHit = damage
					end
					recap_temp.Last[dest].DmgIn = recap_temp.Last[dest].DmgIn + damage

					if recap_temp.Last[dest].HP then
						recap_temp.Last[dest].HP = recap_temp.Last[dest].HP - damage
					end

					if not recap.Opt.LightData.value then
						if recap_temp.Filter[i].effect==7 then -- melee damage
							recap.Combatant[dest].Incoming.MeleeDamage = (recap.Combatant[dest].Incoming.MeleeDamage or 0) + damage
							if recap_temp.Filter[i].crit==1 then
								recap.Combatant[dest].Incoming.MeleeCrits = (recap.Combatant[dest].Incoming.MeleeCrits or 0) + 1
							else
								recap.Combatant[dest].Incoming.MeleeHits = (recap.Combatant[dest].Incoming.MeleeHits or 0) + 1
							end
							recap.Combatant[dest].Incoming.MeleeMax = math.max(damage,recap.Combatant[dest].Incoming.MeleeMax or 0)
							if blocked then
								recap.Combatant[dest].Incoming.MeleeBlocked = (recap.Combatant[dest].Incoming.MeleeBlocked or 0)+ 1
							end
						else
							recap.Combatant[dest].Incoming.NonMeleeDamage = (recap.Combatant[dest].Incoming.NonMeleeDamage or 0) + damage
							if recap_temp.Filter[i].crit==1 then
								recap.Combatant[dest].Incoming.NonMeleeCrits = (recap.Combatant[dest].Incoming.NonMeleeCrits or 0) + 1
							else
								recap.Combatant[dest].Incoming.NonMeleeHits = (recap.Combatant[dest].Incoming.NonMeleeHits or 0) + 1
							end
							recap.Combatant[dest].Incoming.NonMeleeMax = math.max(damage,recap.Combatant[dest].Incoming.NonMeleeMax or 0)
						end
						Recap_CreateEffect(source,effect,1,damage,recap_temp.Filter[i].crit)
					end

				elseif recap_temp.Filter[i].miss and not recap.Opt.LightData.value then
					if recap_temp.Filter[i].miss==9 and recap_temp.Filter[i].effect==7 then -- melee normal miss
						recap.Combatant[dest].Incoming.MeleeMissed = (recap.Combatant[dest].Incoming.MeleeMissed or 0) + 1
					elseif recap_temp.Filter[i].miss==9 then -- non-melee miss
						recap.Combatant[dest].Incoming.NonMeleeMissed = (recap.Combatant[dest].Incoming.NonMeleeMissed or 0) + 1
					elseif recap_temp.Filter[i].miss==10 then -- melee dodge
						recap.Combatant[dest].Incoming.MeleeDodged = (recap.Combatant[dest].Incoming.MeleeDodged or 0) + 1
					elseif recap_temp.Filter[i].miss==11 then -- melee parry
						recap.Combatant[dest].Incoming.MeleeParried = (recap.Combatant[dest].Incoming.MeleeParried or 0) + 1
					elseif recap_temp.Filter[i].miss==12 then -- melee block
						recap.Combatant[dest].Incoming.MeleeBlocked = (recap.Combatant[dest].Incoming.MeleeBlocked or 0) + 1
					end
					Recap_CreateEffect(source,effect,1,0)
				end

				i=recap_temp.FilterSize+1
			end
		end
	end
end

-- did_crit=1 for a crit, =0 for a normal hit but it could crit
-- total = amount of hit/heal, 0 for a miss
function Recap_CreateEffect(source,effect,type,total,did_crit)

	effect = type..effect

	-- skip misses that aren't a stored effect yet, to prevent logging debuff resists
	if not (total==0 and not recap.Combatant[source].Detail[effect]) then

--		ChatFrame2:AddMessage("effect: "..effect..", source: "..source..", total: "..total..", did_crit: "..tostring(did_crit))

		if not recap.Combatant[source].Detail[effect] then
			recap.Combatant[source].Detail[effect] = {} -- Hits=0, HitsDmg=0, HitsMax=0, Crits=0, CritsEvents=0, CritsDmg=0, CritsMax=0, Missed=0, TicksDmg, TicksMax }
		end

		if source==recap_temp.Player and not recap.Self[recap_temp.s][effect] then
			recap.Self[recap_temp.s][effect] = {}
		end

		if did_crit==1 then
			recap.Combatant[source].Detail[effect].CritsEvents = (recap.Combatant[source].Detail[effect].CritsEvents or 0) + 1
			recap.Combatant[source].Detail[effect].Crits = (recap.Combatant[source].Detail[effect].Crits or 0) + did_crit
			recap.Combatant[source].Detail[effect].CritsDmg = (recap.Combatant[source].Detail[effect].CritsDmg or 0) + total
			recap.Combatant[source].Detail[effect].CritsMax = math.max(total,recap.Combatant[source].Detail[effect].CritsMax or 0)
			if source==recap_temp.Player then
				recap.Self[recap_temp.s][effect].CritsEvents = (recap.Self[recap_temp.s][effect].CritsEvents or 0) + 1
				recap.Self[recap_temp.s][effect].Crits = (recap.Self[recap_temp.s][effect].Crits or 0) + did_crit
				recap.Self[recap_temp.s][effect].CritsDmg = (recap.Self[recap_temp.s][effect].CritsDmg or 0) + total
				recap.Self[recap_temp.s][effect].CritsMax = math.max(total,recap.Self[recap_temp.s][effect].CritsMax or 0)
			end
		elseif did_crit==0 then
			recap.Combatant[source].Detail[effect].CritsEvents = (recap.Combatant[source].Detail[effect].CritsEvents or 0) + 1
			recap.Combatant[source].Detail[effect].Hits = (recap.Combatant[source].Detail[effect].Hits or 0) + 1
			recap.Combatant[source].Detail[effect].HitsDmg = (recap.Combatant[source].Detail[effect].HitsDmg or 0) + total
			recap.Combatant[source].Detail[effect].HitsMax = math.max(total,recap.Combatant[source].Detail[effect].HitsMax or 0)
			if source==recap_temp.Player then
				recap.Self[recap_temp.s][effect].CritsEvents = (recap.Self[recap_temp.s][effect].CritsEvents or 0) + 1
				recap.Self[recap_temp.s][effect].Hits = (recap.Self[recap_temp.s][effect].Hits or 0) + 1
				recap.Self[recap_temp.s][effect].HitsDmg = (recap.Self[recap_temp.s][effect].HitsDmg or 0) + total
				recap.Self[recap_temp.s][effect].HitsMax = math.max(total,recap.Self[recap_temp.s][effect].HitsMax or 0)
			end
		elseif total==0 then
			recap.Combatant[source].Detail[effect].Missed = (recap.Combatant[source].Detail[effect].Missed or 0) + 1
			if source==recap_temp.Player then
				recap.Self[recap_temp.s][effect].Missed = (recap.Self[recap_temp.s][effect].Missed or 0) + 1
			end
		else
			recap.Combatant[source].Detail[effect].Hits = (recap.Combatant[source].Detail[effect].Hits or 0) + 1
			recap.Combatant[source].Detail[effect].TicksDmg = (recap.Combatant[source].Detail[effect].TicksDmg or 0) + total
			recap.Combatant[source].Detail[effect].TicksMax = math.max(total,recap.Combatant[source].Detail[effect].TicksMax or 0)
			if source==recap_temp.Player then
				recap.Self[recap_temp.s][effect].Hits = (recap.Self[recap_temp.s][effect].Hits or 0) + 1
				recap.Self[recap_temp.s][effect].TicksDmg = (recap.Self[recap_temp.s][effect].TicksDmg or 0) + total
				recap.Self[recap_temp.s][effect].TicksMax = math.max(total,recap.Self[recap_temp.s][effect].TicksMax or 0)
			end
		end
	end
end

function Recap_DeathEvent(arg1)

	local i, victim, spot
	local found = false

	if recap.Opt.State.value~="Stopped" then

		for i=1,recap_temp.DeathFilterSize do
			found,_,recap_temp.FilterIndex[1] = string.find(arg1,recap_temp.DeathFilter[i].pattern)

			if found then

				victim = recap_temp.FilterIndex[recap_temp.DeathFilter[i].victim]

				-- check for FD
				if recap.Combatant[victim] and recap.Combatant[victim].Class=="Hunter" then
					if UnitName("player")==victim then
						spot = "player"
					end
					for j=1,4 do
						if UnitName("party"..j)==victim then
							spot = "party"..j
						end
					end
					for j=1,40 do
						if UnitName("raid"..j)==victim then
							spot = "raid"..j
						end
					end
					if spot then
						for j=1,16 do
							if UnitBuff(spot,j)=="Interface\\Icons\\Ability_Rogue_FeignDeath" then
								victim = nil
							end
						end
					end
				end
					
				if victim and recap_temp.Last[victim] then
					recap_temp.Last[victim].Kills = recap_temp.Last[victim].Kills + 1
				end

				if recap.debug then
					if not recap.debug_Filter then
						recap.debug_Filter = {}
					end
					if not recap.debug_Filter[i+60] then
						recap.debug_Filter[i+60] = { hits=1, total=1, pattern=recap_temp.DeathFilter[i].pattern }
					else
						recap.debug_Filter[i+60].hits = recap.debug_Filter[i+60].hits + 1
						recap.debug_Filter[i+60].total = recap.debug_Filter[i+60].total + 1
					end
					if recap_temp.Filter[i].watch then
						DEFAULT_CHAT_FRAME:AddMessage("["..i.."] \""..recap_temp.DeathFilter[i].pattern.."\" triggered!")
						DEFAULT_CHAT_FRAME:AddMessage("victim="..tostring(victim))
					end
				end

				i = recap_temp.DeathFilterSize+1

			end
		end
	end
end

function Recap_HealEvent(arg1)

	local i, source, dest, heal, effect, fullheal
	local found = false

	if recap.Opt.State.value~="Stopped" then

		-- strip out period at end of chat line, if one exists
		arg1 = string.gsub(arg1,"%.$","")

		for i=1,recap_temp.HealFilterSize do
			found,_,recap_temp.FilterIndex[1],recap_temp.FilterIndex[2],recap_temp.FilterIndex[3],recap_temp.FilterIndex[4],recap_temp.FilterIndex[5] = string.find(arg1,recap_temp.HealFilter[i].pattern)

			if found then

				if not recap.Opt.LimitFights.value then
					if recap.Opt.IdleFight.value then
						recap_temp.IdleTimer = 0
					end
					if recap.Opt.State.value=="Idle" then
						Recap_StartFight()
					end
				end

				source=recap_temp.FilterIndex[recap_temp.HealFilter[i].source]
				dest=recap_temp.FilterIndex[recap_temp.HealFilter[i].dest]
				if recap_temp.Local.SelfPronouns[string.lower(dest)] then
					dest = recap_temp.Player
				end
				heal=tonumber(recap_temp.FilterIndex[recap_temp.HealFilter[i].heal])
				if recap_temp.HealFilter[i].effect then
					effect = recap_temp.FilterIndex[recap_temp.HealFilter[i].effect]
				end

				Recap_CreateCombatant(source)

				if recap_temp.Last[dest] and recap_temp.Last[dest].HP then
					fullheal = heal
					heal = math.min(recap_temp.Last[dest].MaxHP-recap_temp.Last[dest].HP,heal)
					recap_temp.Last[dest].HP = recap_temp.Last[dest].HP + heal
					if recap.debug and heal~=fullheal then
						ChatFrame2:AddMessage("|cff3fbfff"..source.."'s "..effect.." actually healed "..dest.." for "..heal..". ("..fullheal.." reported)")
					end
				end
				recap_temp.Last[source].Heal = recap_temp.Last[source].Heal + heal

				if recap.debug then
					if not recap.debug_Filter then
						recap.debug_Filter = {}
					end
					if not recap.debug_Filter[i+75] then
						recap.debug_Filter[i+75] = { hits=1, total=heal, pattern=recap_temp.HealFilter[i].pattern }
					else
						recap.debug_Filter[i+75].hits = recap.debug_Filter[i+75].hits + 1
						recap.debug_Filter[i+75].total = recap.debug_Filter[i+75].total + heal
					end
					if recap_temp.Filter[i].watch then
						DEFAULT_CHAT_FRAME:AddMessage("["..i.."] \""..recap_temp.HealFilter[i].pattern.."\" triggered!")
						DEFAULT_CHAT_FRAME:AddMessage("source="..tostring(source)..", dest="..tostring(dest)..", heal="..tostring(heal))
					end
				end

				if not recap.Opt.LightData.value then
					Recap_CreateEffect(source,effect,3,heal,recap_temp.HealFilter[i].crit)

					if fullheal and heal~=fullheal and recap.Combatant[source].Detail["3"..effect] then
						-- reuse .Missed detail to store overhealing since heals never miss
						recap.Combatant[source].Detail["3"..effect].Missed = (recap.Combatant[source].Detail["3"..effect].Missed or 0) + math.max(0,fullheal-heal)
					end
				end

				i = recap_temp.HealFilterSize+1

			end
		end
	end
end

local function Recap_SelfDamageSort(e1,e2)

	local effect1,effect2 = string.sub(e1.EName,1,1),string.sub(e2.EName,1,1)

	if e1 and e2 and ( ((e1.ETotal>e2.ETotal) and (effect1==effect2)) or (effect1<effect2) ) then
		return true
	else
		return false
	end
end

local function Recap_ConstructSelf()

	local idx,i,j = 1
	local damage, heal = 0,0

	recap_temp.SelfListSize = 1
	
	for i in recap.Self[recap_temp.s] do
		if not recap_temp.SelfList[idx] then
			recap_temp.SelfList[idx] = {}
		end
		recap_temp.SelfList[idx].EName = i
		recap_temp.SelfList[idx].ETotal = (recap.Self[recap_temp.s][i].HitsDmg or 0) + (recap.Self[recap_temp.s][i].TicksDmg or 0) + (recap.Self[recap_temp.s][i].CritsDmg or 0)
		recap_temp.SelfList[idx].EHits = (recap.Self[recap_temp.s][i].CritsEvents or 0)-(recap.Self[recap_temp.s][i].Crits or 0)
		recap_temp.SelfList[idx].ETicks = (recap.Self[recap_temp.s][i].Hits or 0) - recap_temp.SelfList[idx].EHits
		recap_temp.SelfList[idx].ECrits = recap.Self[recap_temp.s][i].Crits or 0
		recap_temp.SelfList[idx].EHitsMax = recap.Self[recap_temp.s][i].HitsMax or 0
		recap_temp.SelfList[idx].ETicksMax = recap.Self[recap_temp.s][i].TicksMax or 0
		recap_temp.SelfList[idx].ECritsMax = recap.Self[recap_temp.s][i].CritsMax or 0
		recap_temp.SelfList[idx].EHitsAvg = string.format("%d",((recap_temp.SelfList[idx].EHits>0) and ((recap.Self[recap_temp.s][i].HitsDmg or 0)/recap_temp.SelfList[idx].EHits) or 0))
		recap_temp.SelfList[idx].ETicksAvg = string.format("%d",((recap_temp.SelfList[idx].ETicks>0) and ((recap.Self[recap_temp.s][i].TicksDmg or 0)/recap_temp.SelfList[idx].ETicks) or 0))
		recap_temp.SelfList[idx].ECritsAvg = string.format("%d",((recap_temp.SelfList[idx].ECrits>0) and ((recap.Self[recap_temp.s][i].CritsDmg or 0)/recap_temp.SelfList[idx].ECrits) or 0))
		recap_temp.SelfList[idx].ECritsP = string.format("%.1f%%",((recap.Self[recap_temp.s][i].CritsEvents or 0)>0) and (100*recap_temp.SelfList[idx].ECrits/recap.Self[recap_temp.s][i].CritsEvents) or 0)
		recap_temp.SelfList[idx].EMaxAll = math.max( recap_temp.SelfList[idx].EHitsMax, math.max(recap_temp.SelfList[idx].ETicksMax,recap_temp.SelfList[idx].ECritsMax) )
		if tonumber(string.sub(i,1,1))<3 then -- damage event
			recap_temp.SelfList[idx].EMiss = recap.Self[recap_temp.s][i].Missed or 0
			j = recap_temp.SelfList[idx].EHits + recap_temp.SelfList[idx].ECrits + recap_temp.SelfList[idx].EMiss
			recap_temp.SelfList[idx].EMissP = string.format("%.1f%%",(j>0) and (100*(recap_temp.SelfList[idx].EMiss/j)) or 0)
			damage = damage + recap_temp.SelfList[idx].ETotal
		else
			recap_temp.SelfList[idx].EMiss = "--"
			recap_temp.SelfList[idx].EMissP = "--"
			heal = heal + recap_temp.SelfList[idx].ETotal
		end

		if recap_temp.SelfList[idx].ETicks==0 then
			recap_temp.SelfList[idx].ETicks = "--"
			recap_temp.SelfList[idx].ETicksAvg = "--"
			recap_temp.SelfList[idx].ETicksMax = "--"
		end
		if not recap.Self[recap_temp.s][i].CritsEvents then
			recap_temp.SelfList[idx].ECrits = "--"
			recap_temp.SelfList[idx].ECritsAvg = "--"
			recap_temp.SelfList[idx].ECritsMax = "--"
			recap_temp.SelfList[idx].ECritsP = "--"
			recap_temp.SelfList[idx].EHits = "--"
			recap_temp.SelfList[idx].EHitsAvg = "--"
			recap_temp.SelfList[idx].EHitsMax = "--"
		end

		idx = idx + 1
	end

	recap_temp.SelfListSize = idx

	if recap_temp.SelfListSize>1 then
		for i=1,recap_temp.SelfListSize-1 do
			if string.sub(recap_temp.SelfList[i].EName,1,1)<"3" and damage>0 then
				recap_temp.SelfList[i].ETotalP = string.format("%d%%",100*recap_temp.SelfList[i].ETotal/damage)
			elseif string.sub(recap_temp.SelfList[i].EName,1,1)>"2" and heal>0 then
				recap_temp.SelfList[i].ETotalP = string.format("%d%%",100*recap_temp.SelfList[i].ETotal/heal)
			else
				recap_temp.SelfList[i].ETotalP = "--"
			end
		end
	end

	table.sort(recap_temp.SelfList,Recap_SelfDamageSort)

end

function Recap_ConstructList()

	local i, j, dpsin, dpsout, entry, duration, tempname, over
	local maxhit = 0
	local dmgin = 0
	local dmgout = 0
	local kills = 0
	local heal = 0
	local allover = 0


	if recap.Opt.SelfView.value then
		Recap_ConstructSelf()
	end

	recap_temp.ListSize = 1
	if recap_temp.Selected~=0 then
		tempname = recap_temp.List[recap_temp.Selected].Name
	end

	if recap.Opt.View.value=="Last" then
		duration = recap[recap_temp.p].LastDuration
	else
		duration = recap[recap_temp.p].TotalDuration
	end
	
	for i in recap.Combatant do
		if not recap_temp.List[recap_temp.ListSize] then
			recap_temp.List[recap_temp.ListSize] = {}
		end
		entry = false
		if (recap.Combatant[i].LastDmgIn==0 and recap.Combatant[i].LastDmgOut==0 and
			recap.Combatant[i].TotalDmgOut==0 and recap.Combatant[i].TotalDmgIn==0) or
		   (recap.Opt.HideFoe.value and not recap.Combatant[i].Friend) or
		   (recap.Opt.HideYardTrash.value and (not recap.Combatant[i].Friend and recap.Combatant[i].TotalKills~=1)) or
		   (recap.Combatant[i].Ignore) then
			entry = false -- strip out unwanted combatants
		elseif recap.Opt.View.value=="Last" and recap.Combatant[i].WasInLast then
			if not recap.Opt.HideZero.value or recap.Combatant[i].LastTime>recap_temp.MinTime then
				recap_temp.List[recap_temp.ListSize].Name = i
				recap_temp.List[recap_temp.ListSize].Time = recap.Combatant[i].LastTime
				recap_temp.List[recap_temp.ListSize].MaxHit = recap.Combatant[i].LastMaxHit
				recap_temp.List[recap_temp.ListSize].DmgIn = recap.Combatant[i].LastDmgIn
				recap_temp.List[recap_temp.ListSize].DmgOut = recap.Combatant[i].LastDmgOut
				recap_temp.List[recap_temp.ListSize].DPS = recap.Combatant[i].LastDPS
				recap_temp.List[recap_temp.ListSize].DPSvsAll = duration>recap_temp.MinTime and recap.Combatant[i].LastDmgOut/duration or 0
				recap_temp.List[recap_temp.ListSize].Kills = recap.Combatant[i].LastKills
				recap_temp.List[recap_temp.ListSize].Heal = recap.Combatant[i].LastHeal
				entry = true
			end
		elseif recap.Opt.View.value=="All" then
			if not recap.Opt.HideZero.value or recap.Combatant[i].TotalTime>recap_temp.MinTime then
				recap_temp.List[recap_temp.ListSize].Name = i
				recap_temp.List[recap_temp.ListSize].Time = recap.Combatant[i].TotalTime
				recap_temp.List[recap_temp.ListSize].MaxHit = recap.Combatant[i].TotalMaxHit
				recap_temp.List[recap_temp.ListSize].DmgIn = recap.Combatant[i].TotalDmgIn
				recap_temp.List[recap_temp.ListSize].DmgOut = recap.Combatant[i].TotalDmgOut
				recap_temp.List[recap_temp.ListSize].DPS = recap.Combatant[i].TotalDPS
				recap_temp.List[recap_temp.ListSize].DPSvsAll = duration>recap_temp.MinTime and recap.Combatant[i].TotalDmgOut/duration or 0
				recap_temp.List[recap_temp.ListSize].Kills = recap.Combatant[i].TotalKills
				recap_temp.List[recap_temp.ListSize].Heal = recap.Combatant[i].TotalHeal
				entry = true
			end
		end
		if entry then
			recap_temp.List[recap_temp.ListSize].Over = 0 -- overhealing
			if recap.Combatant[recap_temp.List[recap_temp.ListSize].Name].Friend then
				if recap_temp.List[recap_temp.ListSize].MaxHit > maxhit then
					maxhit = recap_temp.List[recap_temp.ListSize].MaxHit
				end
				dmgin = dmgin + recap_temp.List[recap_temp.ListSize].DmgIn
				dmgout = dmgout + recap_temp.List[recap_temp.ListSize].DmgOut
				kills = kills + recap_temp.List[recap_temp.ListSize].Kills
				heal = heal + recap_temp.List[recap_temp.ListSize].Heal
				if (recap_temp.List[recap_temp.ListSize].Heal>0) and not recap.Opt.LightData.value then
					over = 0
					for j in recap.Combatant[i].Detail do
						if string.sub(j,1,1)=="3" then -- a heal
							over = over + (recap.Combatant[i].Detail[j].Missed or 0)
						end
					end
					recap_temp.List[recap_temp.ListSize].Over = math.floor(((100*over)/(over+recap.Combatant[i].TotalHeal))+.5)
					allover = allover + over
				end
			end
			recap_temp.ListSize = recap_temp.ListSize + 1
		end
	end

	if not recap_temp.List[recap_temp.ListSize] then
		recap_temp.List[recap_temp.ListSize] = {}
	end
	-- the final entry is the totals
	recap_temp.List[recap_temp.ListSize].Name = "Totals"
	recap_temp.List[recap_temp.ListSize].Time = duration
	RecapTotals_Time:SetText(Recap_FormatTime(duration))
	recap_temp.List[recap_temp.ListSize].MaxHit = maxhit
	RecapTotals_MaxHit:SetText(maxhit)
	recap_temp.List[recap_temp.ListSize].DmgIn = dmgin
	RecapTotals_DmgIn:SetText(dmgin)
	recap_temp.List[recap_temp.ListSize].DmgOut = dmgout
	RecapTotals_DmgOut:SetText(dmgout)
	recap_temp.List[recap_temp.ListSize].Kills = kills
	RecapTotals_Kills:SetText(kills)
	recap_temp.List[recap_temp.ListSize].Heal = heal
	RecapTotals_Heal:SetText(heal)
	recap_temp.List[recap_temp.ListSize].Over = recap.Opt.View.value=="All" and ((100*allover)/(allover+heal)) or 0
	RecapTotals_Over:SetText(string.format("%d%%",recap_temp.List[recap_temp.ListSize].Over))
	if duration > recap_temp.MinTime then
		recap_temp.List[recap_temp.ListSize].DPSIn = dmgin/duration
		recap_temp.List[recap_temp.ListSize].DPSOut = dmgout/duration
	else
		recap_temp.List[recap_temp.ListSize].DPSIn = 0
		recap_temp.List[recap_temp.ListSize].DPSOut = 0
	end
	RecapTotals_DPS:SetText(string.format("%.1f",recap_temp.List[recap_temp.ListSize].DPSOut))
	RecapTotals_DPSvsAll:SetText(string.format("%.1f",recap_temp.List[recap_temp.ListSize].DPSOut))
	RecapTotals_DPSIn:SetText(string.format("%.1f",recap_temp.List[recap_temp.ListSize].DPSIn))

	RecapMinDPSIn_Text:SetText(string.format("%.1f",recap_temp.List[recap_temp.ListSize].DPSIn))
	RecapMinDPSOut_Text:SetText(string.format("%.1f",recap_temp.List[recap_temp.ListSize].DPSOut))
	if recap.Combatant[recap_temp.Player] and recap.Opt.View.value=="Last" then
		i = recap.Combatant[recap_temp.Player].LastDPS
		if UnitName("pet") and UnitName("pet")~=UNKNOWNOBJECT and recap.Combatant[UnitName("pet")] then
			i = i + recap.Combatant[UnitName("pet")].LastDPS
		end
		RecapMinYourDPS_Text:SetText(string.format("%.1f",i))
	elseif recap.Combatant[recap_temp.Player] and recap.Opt.View.value=="All" then
		i = recap.Combatant[recap_temp.Player].TotalDPS
		if UnitName("pet") and UnitName("pet")~=UNKNOWNOBJECT and recap.Combatant[UnitName("pet")] then
			i = i + recap.Combatant[UnitName("pet")].TotalDPS
		end
		RecapMinYourDPS_Text:SetText(string.format("%.1f",i))
	else
		RecapMinYourDPS_Text:SetText("n/a")
	end

	-- calculate percentages
	for i=1,recap_temp.ListSize-1 do
		recap_temp.List[i].HealP = 0
		recap_temp.List[i].DmgInP = 0
		recap_temp.List[i].DmgOutP = 0
		if recap.Combatant[recap_temp.List[i].Name].Friend then
			if recap_temp.List[recap_temp.ListSize].Heal>0 then
				recap_temp.List[i].HealP = math.floor(.5+100*recap_temp.List[i].Heal/recap_temp.List[recap_temp.ListSize].Heal)
			end
			if recap_temp.List[recap_temp.ListSize].DmgIn>0 then
				recap_temp.List[i].DmgInP = math.floor(.5+100*recap_temp.List[i].DmgIn/recap_temp.List[recap_temp.ListSize].DmgIn)
			end
			if recap_temp.List[recap_temp.ListSize].DmgOut>0 then
				recap_temp.List[i].DmgOutP = math.floor(.5+100*recap_temp.List[i].DmgOut/recap_temp.List[recap_temp.ListSize].DmgOut)
			end
		end
	end

	Recap_SortList()

	if tempname then -- follow name to pre-sort selected
		recap_temp.Selected = Recap_GetSelectedByName(tempname)
		if recap_temp.Selected~=0 then
			RecapPanel_Show(tempname)
		else
			RecapPanel_Hide()
		end
	end

	RecapScrollBar_Update()
	Recap_UpdatePlugins()

end

function Recap_DefineGauges()

	local i

	recap_temp.GaugeMax = 0

	if recap_temp.ListSize>1 then

		recap_temp.GaugeBy = string.gsub(recap.Opt.SortBy.value,"P$","")
		recap_temp.GaugeBy = recap_temp.GaugeBy=="DPSvsAll" and "DmgOut" or recap_temp.GaugeBy
		if not gaugecolor[recap_temp.GaugeBy] then
			recap_temp.GaugeBy = nil
		else
			for i=1,recap_temp.ListSize-1 do
				recap_temp.GaugeMax = math.max(recap.Combatant[recap_temp.List[i].Name].Friend and recap_temp.List[i][recap_temp.GaugeBy] or 0,recap_temp.GaugeMax)
			end
			for i=1,15 do
				getglobal("RecapList"..i.."_Gauge"):SetVertexColor(gaugecolor[recap_temp.GaugeBy].r,gaugecolor[recap_temp.GaugeBy].g,gaugecolor[recap_temp.GaugeBy].b)
			end
		end
	end
end


function Recap_GetSelectedByName(arg1)

	local sel,i = 0

	if arg1 and recap_temp.ListSize>1 then
		for i=1,recap_temp.ListSize-1 do
			if recap_temp.List[i].Name==arg1 then
				sel = i
			end
		end
	end

	return sel
end

--[[ Sorting functions ]]

-- initial sort by field done with table.sort for speed, then
-- friends shifted to top with an insertion sort for "stable" list
function Recap_SortList()

	local temp,tempname

	if recap_temp.Selected~=0 then
		tempname = recap_temp.List[recap_temp.Selected].Name
	end

	temp = recap_temp.List[recap_temp.ListSize]
	recap_temp.List[recap_temp.ListSize] = nil

	if recap.Opt.SortDir.value then
		table.sort(recap_temp.List,function(e1,e2) if e1 and e2 and ( e1[recap.Opt.SortBy.value] < e2[recap.Opt.SortBy.value] ) then return true else return false end end)
	else
		table.sort(recap_temp.List,function(e1,e2) if e1 and e2 and ( e1[recap.Opt.SortBy.value] > e2[recap.Opt.SortBy.value] ) then return true else return false end end)
	end
 	Recap_SortFriends()

	recap_temp.List[recap_temp.ListSize] = temp

	Recap_DefineGauges()
	recap_temp.Selected = Recap_GetSelectedByName(tempname)

end

function Recap_SortDown(e1,e2)

	if e1 and e2 and ( e1[recap.Opt.SortBy.value] < e2[recap.Opt.SortBy.value] ) then
		return true
	else
		return false
	end
end

function Recap_SortUp(e1,e2)

	if e1 and e2 and ( e1[recap.Opt.SortBy.value] > e2[recap.Opt.SortBy.value] ) then
		return true
	else
		return false
	end
end

-- perform stable insertion sort on the list
function Recap_SortFriends()

	local i,j
	local changed = true
	local temp = {}

	if recap_temp.ListSize>2 then

		for i=2,(recap_temp.ListSize-1) do
			temp = recap_temp.List[i]
			j=i
			while (j>1) and (not recap.Combatant[recap_temp.List[j-1].Name].Friend and recap.Combatant[temp.Name].Friend) do
				recap_temp.List[j] = recap_temp.List[j-1]
				j = j - 1
			end
			recap_temp.List[j] = temp
		end

	end
end

--[[ Window movement functions ]]

function Recap_OnMouseDown(arg1)

	if recap_temp.Loaded and arg1=="LeftButton" and not recap.Opt.Pinned.value then
		RecapFrame:StartMoving()
	end
end

function Recap_OnMouseUp(arg1)

	if recap_temp.Loaded and arg1=="LeftButton" and not recap.Opt.Pinned.value then
		RecapFrame:StopMovingOrSizing()
		Recap_CheckWindowBounds()
	elseif arg1=="RightButton" and recap.Opt.Minimized.value then
		RecapCreateMenu(recap_temp.MinMenu)
	end		
end

-- repositions RecapFrame if any part of it goes off the screen
function Recap_CheckWindowBounds()

	local x1, y1, x2, y2, cx, cy
	local needs_moved = false

	if recap_temp.Loaded and RecapFrame then

		x1 = RecapFrame:GetLeft()
		y1 = RecapFrame:GetTop()
		cx = RecapFrame:GetWidth()
		cy = RecapFrame:GetHeight()

		if x1 and y1 and cx and cy then

			x2 = RecapFrame:GetRight()
			y2 = RecapFrame:GetBottom()
			uix2 = UIParent:GetRight()
			uix1 = UIParent:GetLeft()
			uiy1 = UIParent:GetTop()
			uiy2 = UIParent:GetBottom()

			if x2 and uix2 and x2 > uix2 then
				x1 = x1 + uix2 - x2
				needs_moved = true
			elseif uix1 and uix1 > x1 then
				x1 = x1 + uix1 - x1
				needs_moved = true
			end

			if y1 and y1 > uiy1 then
				y1 = y1 + uiy1 - y1
				needs_moved = true
			elseif uiy2 and uiy2 > y2 then
				y1 = y1 + uiy2 - y2
				needs_moved = true
			end

			if needs_moved then
				RecapFrame:ClearAllPoints()
				RecapFrame:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",x1,y1)
			end

			recap[recap_temp.p].WindowTop = RecapFrame:GetTop()
			recap[recap_temp.p].WindowLeft = RecapFrame:GetLeft()
			recap[recap_temp.p].WindowHeight = RecapFrame:GetHeight()
			recap[recap_temp.p].WindowWidth = RecapFrame:GetWidth()

		end

	end
end

--[[ Dialog control functions ]]

function Recap_OnClick(arg1)

	if not recap_temp.Loaded then
		return
	end

	local fight_count = 0
	local total_fight_count = 0
	local filen = RecapSetEditBox:GetText()
	local set_friend, set_dmgin, set_dmgout, set_maxhit, set_kills, set_heal, set_time

	PlaySound("GAMEGENERICBUTTONPRESS")

	if arg1=="Close" then
		RecapFrame_Hide()
	elseif arg1=="Minimize" then

		if recap.Opt.Minimized.value then
			Recap_Maximize()
		else
			Recap_Minimize()
		end
		RecapFrame:SetAlpha(1)
		recap_temp.FadeTimer = -1
		Recap_SetButtons()
		Recap_OnTooltip("Minimize")
	elseif arg1=="Pin" then
		recap.Opt.Pinned.value = not recap.Opt.Pinned.value
		Recap_SetButtons()
		Recap_OnTooltip("Pin")
	elseif arg1=="Pause" then
		if recap.Opt.Paused.value then
			recap.Opt.Paused.value = false
			Recap_SetState("Idle")
		else
			recap.Opt.Paused.value = true
			Recap_EndFight()
			Recap_SetState("Stopped")
		end
		Recap_SetButtons()
		Recap_OnTooltip("Pause")
	elseif arg1=="ShowAll" then
		if recap.Opt.SelfView.value then
			recap.Opt.SelfView.value = false
			if not recap.Opt.Minimized.value then
				Recap_SetColumns()
			end
		end
		if recap.Opt.View.value=="Last" then
			Recap_SetView("All")
		else
			Recap_SetView("Last")
		end
		Recap_OnTooltip("ShowAll")
	elseif arg1=="Options" then
		if RecapOptFrame:IsShown() then
			RecapOptFrame:Hide()
		else
			RecapOptFrame:Show()
		end
	elseif arg1=="Reset" then

		if recap.Opt.SelfView.value then
			recap.Self[recap_temp.s] = {}
			Recap_SetView()
		elseif recap.Opt.View.value=="All" then
			-- wipe everything --
			Recap_ResetAllCombatants()
			Recap_SetView()
			Recap_MakeFriends()
		elseif recap.Opt.View.value=="Last" then
			-- remove just the last fight --
			for i in recap.Combatant do
				if recap.Combatant[i].WasInLast then
					Recap_ResetLastFight(i)				
				end
			end
			recap[recap_temp.p].TotalDuration = recap[recap_temp.p].TotalDuration - recap[recap_temp.p].LastDuration
			recap[recap_temp.p].LastDuration = 0
			Recap_SetView()
		end

	elseif arg1=="SaveSet" then
		RecapSetEditBox:ClearFocus()
		if filen and filen~="" then
			filen = string.gsub(filen,"\"","'") -- convert "s to 's
			filen = string.gsub(filen,"%[","(") -- convert [s to (s
			filen = string.gsub(filen,"%]",")") -- convert ]s to )s
		end
		RecapSetEditBox:SetText("")
		Recap_SaveCombatants(filen,recap.Opt.ReplaceSet.value)
		Recap_BuildFightSets()
		recap_temp.FightSetSelected = 0
		RecapFightSetsScrollBar_Update()

	elseif arg1=="LoadSet" then
		RecapSetEditBox:SetText("")
		RecapSetEditBox:ClearFocus()
		Recap_LoadCombatants(filen,recap.Opt.ReplaceSet.value)
		Recap_MakeFriends()
		Recap_SetView("All")

	elseif arg1=="DeleteSet" then
		RecapSetEditBox:SetText("")
		RecapSetEditBox:ClearFocus()
		recap_set[filen] = nil
		Recap_BuildFightSets()

	elseif arg1=="SelfView" then
		recap.Opt.SelfView.value = not recap.Opt.SelfView.value
		RecapPanel_Hide(1)
		Recap_SetColumns()
		Recap_OnTooltip("SelfView")
	end
end

-- removes combatant i from last fight
function Recap_ResetLastFight(i)
	recap.Combatant[i].TotalTime = recap.Combatant[i].TotalTime - recap.Combatant[i].LastTime
	recap.Combatant[i].TotalDmgIn = recap.Combatant[i].TotalDmgIn - recap.Combatant[i].LastDmgIn
	recap.Combatant[i].TotalDmgOut = recap.Combatant[i].TotalDmgOut - recap.Combatant[i].LastDmgOut
	recap.Combatant[i].TotalHeal = recap.Combatant[i].TotalHeal - recap.Combatant[i].LastHeal
	recap.Combatant[i].TotalKills = recap.Combatant[i].TotalKills - recap.Combatant[i].LastKills
	if recap.Combatant[i].TotalTime> recap_temp.MinTime then
		recap.Combatant[i].TotalDPS = recap.Combatant[i].TotalDmgOut/recap.Combatant[i].TotalTime
	else
		recap.Combatant[i].TotalDPS = 0
	end
	recap.Combatant[i].WasInLast = false
	recap.Combatant[i].LastTime = 0
	recap.Combatant[i].LastDmgIn = 0
	recap.Combatant[i].LastDmgOut = 0
	recap.Combatant[i].LastDPS = 0
	recap.Combatant[i].LastMaxHit = 0
	recap.Combatant[i].LastKills = 0
	recap.Combatant[i].LastHeal = 0
end

function RecapHeader_OnEnter()

	local msg=string.gsub(this:GetName(),"RecapHeader_","Header")
	Recap_OnTooltip(msg)
end

function RecapHeader_OnMouseUp(arg1)

	if arg1=="RightButton" then
		RecapCreateMenu(recap_temp.ColumnMenu)
	end
end

-- sort column, toggle dir for new headers, name=ascending, rest=descending
function RecapHeader_OnClick()

	local text=""
	local channel = "" -- "Guild" "Say" etc or "Channel"
	local chatnumber = 0 -- if channel is "Channel", this is the channel numbers
	local arg1= string.gsub(this:GetName(),"RecapHeader_","")

	if not IsShiftKeyDown() then
		if recap.Opt.SortBy.value==string.gsub(arg1,"P$","") then
			recap.Opt.SortDir.value = not recap.Opt.SortDir.value
		else
			recap.Opt.SortBy.value = string.gsub(arg1,"P$","")

			if arg1=="Name" then
				recap.Opt.SortDir.value = true
			else
				recap.Opt.SortDir.value = false
			end
		end
		Recap_SortList()
		RecapScrollBar_Update()
	elseif ChatFrameEditBox:IsVisible() and recap_temp.ListSize>1 and arg1~="Name" then

		recap.Opt.SortBy.value = arg1
		recap.Opt.SortDir.value = false
		Recap_SortList()
		RecapScrollBar_Update()

		if recap.Opt.SpamRows.value then

			channel = ChatFrameEditBox.chatType
			chatnumber = nil

			if channel=="WHISPER" then
				chatnumber = ChatFrameEditBox.tellTarget
			elseif channel=="CHANNEL" then
				chatnumber = ChatFrameEditBox.channelTarget
			end

			Recap_PostSpamRows(arg1,channel,chatnumber)

		else
			Recap_InsertChat(Recap_PostSpamLine(arg1))
		end

	elseif not ChatFrameEditBox:IsVisible() then
		DEFAULT_CHAT_FRAME:AddMessage(recap_temp.Local.RankUsage)
	end

end

function Recap_List_OnClick(arg1)

	local id, index
	local text = ""

	id = this:GetID()
	index = id + FauxScrollFrame_GetOffset(RecapScrollBar)

	if index<recap_temp.ListSize then
		recap_temp.DetailSelected = 0
		if recap_temp.Selected==index and arg1=="LeftButton" then
			recap_temp.Selected = 0
			getglobal("RecapList"..id):UnlockHighlight()
			RecapPanel_Hide()
		else
			recap_temp.Selected = index
			RecapScrollBar_Update()
			RecapPanel_Show(recap_temp.List[index].Name)
		end
	end

	if arg1=="RightButton" and index<recap_temp.ListSize and IsShiftKeyDown() and ChatFrameEditBox:IsVisible() then
		ChatFrameEditBox:Insert(recap_temp.List[index].Name.." "..getglobal("RecapList"..id.."_DPS"):GetText().." DPS ")
	elseif arg1=="LeftButton" and index<recap_temp.ListSize and IsShiftKeyDown() and ChatFrameEditBox:IsVisible() then
		ChatFrameEditBox:Insert(string.format(recap_temp.Local.VerboseLinkStart,		
								recap_temp.List[index].Name,
								getglobal("RecapList"..id.."_DmgIn"):GetText(),
								getglobal("RecapList"..id.."_DmgOut"):GetText(),
								getglobal("RecapList"..id.."_Time"):GetText(),
								getglobal("RecapList"..id.."_DPS"):GetText(),
								getglobal("RecapList"..id.."_MaxHit"):GetText() ).." for "..
								recap_temp.Local.LastAll[recap.Opt.View.value])
	elseif arg1=="RightButton" and index<recap_temp.ListSize and not IsShiftKeyDown() then
		if recap.Combatant[recap_temp.List[index].Name].Friend then
			RecapCreateMenu(recap_temp.DropMenu,1)
		else
			RecapCreateMenu(recap_temp.AddMenu,1)
		end
	end
end

--[[ Tooltip functions ]]

function Recap_Tooltip(arg1,arg2)

	if recap_temp.Loaded and recap.Opt.ShowTooltips.value then
		if not recap.Opt.TooltipFollow.value then
			GameTooltip_SetDefaultAnchor(GameTooltip,this)
		else
			GameTooltip:SetOwner(this,Recap_TooltipAnchor())
		end
		GameTooltip:SetText(arg1)
		GameTooltip:AddLine(arg2, .75, .75, .75, 1)
		GameTooltip:Show()
	end
end

-- returns line1,line2 of a tooltip for arg1 in OptList (for generic static tooltips)
function Recap_GetTooltip(arg1)

	local i

	if arg1 then
		for i in recap_temp.OptList do
			if recap_temp.OptList[i][1]==arg1 then
				return recap_temp.OptList[i][2],recap_temp.OptList[i][3]
			end
		end
	end
end

-- arg1=tooltip index, arg2=optional addition to header
function Recap_OnTooltip(arg1,arg2)

	local line1, line2

	if arg1=="Status" then
		Recap_Tooltip("Recap Status: "..recap.Opt.State.value,recap_temp.Local.StatusTooltip)
	elseif arg1=="Close" then
		if recap.Opt.State.value=="Stopped" then
			Recap_OnTooltip("ExitRecap")
		else
			Recap_OnTooltip("HideWindow")
		end
	elseif arg1=="Minimize" then
		if recap.Opt.Minimized.value then
			Recap_OnTooltip("ExpandWindow")
		else
			Recap_OnTooltip("MinimizeWindow")
		end
	elseif arg1=="Pin" then
		if recap.Opt.Pinned.value then
			Recap_OnTooltip("UnPinWindow")
		else
			Recap_OnTooltip("PinWindow")
		end
	elseif arg1=="Pause" then
		if recap.Opt.State.value=="Stopped" then
			Recap_OnTooltip("Resume")
		else
			Recap_OnTooltip("PauseMonitoring")
		end
	elseif arg1=="ShowAll" then
		if recap.Opt.View.value=="Last" then
			Recap_OnTooltip("ShowAllFights")
		else
			Recap_OnTooltip("ShowLastFight")
		end
	elseif arg1=="HeaderName" then
		if recap.Opt.View.value=="Last" then
			Recap_OnTooltip("CombatLast")
		else
			Recap_OnTooltip("CombatAll")
		end
	elseif arg1=="Reset" then
		if recap.Opt.SelfView.value then
			Recap_OnTooltip("ResetSelfView")
		elseif recap.Opt.View.value=="Last" then
			Recap_OnTooltip("ResetLastFight")
		else
			Recap_OnTooltip("ResetAllTotals")
		end
	elseif arg1=="SelfView" then
		if recap.Opt.SelfView.value then
			Recap_OnTooltip("HideSelfView")
		else
			Recap_OnTooltip("ShowSelfView")
		end
	else
		line1,line2 = Recap_GetTooltip(arg1)
		if line1 and line2 then
			if arg2 then
				Recap_Tooltip(line1..": "..arg2,line2)
			else
				Recap_Tooltip(line1, line2)
			end
		end
		
	end
end

function Recap_List_OnEnter()

	local index, id

	id = this:GetID()
	index = id + FauxScrollFrame_GetOffset(RecapScrollBar)

	if getglobal("RecapList"..id.."_Name"):GetStringWidth()>110 then
		Recap_Tooltip(recap_temp.List[index].Name)
	end

	if (index<recap_temp.ListSize) and recap_temp.Selected==0 then
		RecapPanel_Show(recap_temp.List[index].Name)
	end
end

function Recap_Totals_OnEnter()

	local r = recap_temp.ColorWhite.r
	local g = recap_temp.ColorWhite.g
	local b = recap_temp.ColorWhite.b
	local other_kills = 0

	if recap.Opt.ShowTooltips.value then

		if recap.Opt.TooltipFollow.value then
			GameTooltip:SetOwner(this,Recap_TooltipAnchor())
		else
			GameTooltip_SetDefaultAnchor(GameTooltip,this)
		end

		GameTooltip:AddLine("Totals for "..recap_temp.Local.LastAll[recap.Opt.View.value])

		if recap_temp.ListSize>1 then

			for i=1,(recap_temp.ListSize-1) do
				if not recap.Combatant[recap_temp.List[i].Name].Friend then
					other_kills = other_kills + recap_temp.List[i].Kills
				end
			end
			GameTooltip:AddDoubleLine("Combatants:",recap_temp.ListSize-1,r,g,b,r,g,b)
			GameTooltip:AddDoubleLine("Time Fighting:",Recap_FormatTime(recap_temp.List[recap_temp.ListSize].Time),r,g,b,r,g,b)
			GameTooltip:AddDoubleLine("Max Hit:",recap_temp.List[recap_temp.ListSize].MaxHit,r,g,b,r,g,b)
			GameTooltip:AddDoubleLine("Deaths:",recap_temp.List[recap_temp.ListSize].Kills,r,g,b,r,g,b)
			GameTooltip:AddDoubleLine("Kills:",other_kills,r,g,b,r,g,b)
			GameTooltip:AddDoubleLine("Heals:",recap_temp.List[recap_temp.ListSize].Heal,r,g,b,r,g,b)
			GameTooltip:AddDoubleLine("Damage In:",recap_temp.List[recap_temp.ListSize].DmgIn,recap_temp.ColorDmgIn.r,recap_temp.ColorDmgIn.g,recap_temp.ColorDmgIn.b,recap_temp.ColorDmgIn.r,recap_temp.ColorDmgIn.g,recap_temp.ColorDmgIn.b)
			GameTooltip:AddDoubleLine("DPS In:",string.format("%.1f",recap_temp.List[recap_temp.ListSize].DPSIn),recap_temp.ColorDmgIn.r,recap_temp.ColorDmgIn.g,recap_temp.ColorDmgIn.b,recap_temp.ColorDmgIn.r,recap_temp.ColorDmgIn.g,recap_temp.ColorDmgIn.b)
			GameTooltip:AddDoubleLine("Damage Out:",recap_temp.List[recap_temp.ListSize].DmgOut,recap_temp.ColorDmgOut.r,recap_temp.ColorDmgOut.g,recap_temp.ColorDmgOut.b,recap_temp.ColorDmgOut.r,recap_temp.ColorDmgOut.g,recap_temp.ColorDmgOut.b)
			GameTooltip:AddDoubleLine("DPS Out:",string.format("%.1f",recap_temp.List[recap_temp.ListSize].DPSOut),recap_temp.ColorDmgOut.r,recap_temp.ColorDmgOut.g,recap_temp.ColorDmgOut.b,recap_temp.ColorDmgOut.r,recap_temp.ColorDmgOut.g,recap_temp.ColorDmgOut.b)
		else
			GameTooltip:AddLine("Combatants: none",r,g,b)
		end

		GameTooltip:Show()
	end
end

function Recap_TooltipAnchor()

	local anchor = "ANCHOR_LEFT"

	if GetCursorPosition("UIParent")<(UIParent:GetWidth()/2) then
		anchor = "ANCHOR_RIGHT"
	end
	return anchor
end

--[[ Plug-in functions ]]

function Recap_GetIB_Tooltip()
	return recap_temp.Local.LastAll[recap.Opt.View.value]..":\nYour DPS: "..RecapMinYourDPS_Text:GetText().."\nMax hit: "..RecapTotals_MaxHit:GetText().."\nTotal DPS Out: "..RecapTotals_DPS:GetText().."\nTotal DPS In: "..RecapTotals_DPSIn:GetText()
end

function Recap_UpdatePlugins()

	local yourdps = RecapMinYourDPS_Text:GetText()
	local dpsin = RecapMinDPSIn_Text:GetText()
	local dpsout = RecapMinDPSOut_Text:GetText()
	
	if IB_Recap_Update then
		IB_Recap_Update("DPS: "..yourdps)
	end

	if TitanPanelRecap_Update then
		TitanPanelRecap_Update(recap.Opt.State.value,yourdps,dpsin,dpsout)
	end
end

--[[ Misc functions ]]

-- if this is a pet, pass owner's name to ownedby
function Recap_AddFriend(arg1,ownedby)

	if arg1 and arg~=UNKNOWNOBJECT and recap.Combatant[arg1] then
		recap.Combatant[arg1].Friend = true
		if recap.Combatant[arg1] and ownedby then
			-- pet could potentially do damage without owner, add owner if so
			if not recap.Combatant[ownedby] then
				Recap_CreateBlankCombatant(ownedby)
				recap.Combatant[ownedby].Friend = true
			end
			if not recap_temp.Last[ownedby] then
				recap_temp.Last[ownedby] = { Start = 0, End = 0, DmgIn = 0, DmgOut = 0, MaxHit = 0, Kills = 0, Heal = 0 }
			end
			recap.Combatant[arg1].OwnedBy = ownedby
			recap.Combatant[ownedby].OwnsPet = arg1
		end
	end
end

function Recap_MakeFriends()

	local i,item,u

	Recap_GetUnitInfo("player")
	Recap_AddFriend(recap_temp.Player)
	if UnitExists("pet") then
		Recap_GetUnitInfo("pet")
		Recap_AddFriend(UnitName("pet"),UnitName("player"))
	end
	for i=1,4 do
		if UnitExists("party"..i) then
			Recap_GetUnitInfo("party"..i)
			Recap_AddFriend(UnitName("party"..i))
			if UnitExists("partypet"..i) then
				Recap_GetUnitInfo("partypet"..i)
				Recap_AddFriend(UnitName("partypet"..i),UnitName("party"..i))
			end
		end
	end

	if (GetNumRaidMembers()>0) then
		for i=1,40 do
			if UnitExists("raid"..i) then
				Recap_GetUnitInfo("raid"..i)
				Recap_AddFriend(UnitName("raid"..i))
				if UnitExists("raidpet"..i) then
					Recap_GetUnitInfo("raidpet"..i)
					Recap_AddFriend(UnitName("raidpet"..i),UnitName("raid"..i))
				end
			end
		end
	end
end

-- returns a string of seconds converted to 0:00:00 format
function Recap_FormatTime(arg1)

	local hours, minutes, seconds
	local text

	seconds = math.floor(arg1+.5)
	hours = math.floor(seconds/3600)
	seconds = seconds - hours*3600
	minutes = math.floor(seconds/60)
	seconds = seconds - minutes*60

	return ((hours>0) and (hours..":") or "") .. string.format("%02d:",minutes) .. string.format("%02d",seconds)
end

function Recap_SetClassIcon(id,class)
	if class and recap_temp.ClassIcons[class] then
		getglobal("RecapList"..id.."_Class"):SetTexCoord(recap_temp.ClassIcons[class].left,recap_temp.ClassIcons[class].right,recap_temp.ClassIcons[class].top,recap_temp.ClassIcons[class].bottom)
	else
		getglobal("RecapList"..id.."_Class"):SetTexCoord(.9,1,.9,1)
	end
end

function Recap_SetFactionIcon(id,faction)

	item = getglobal("RecapList"..id.."_Faction")

	if faction and recap_temp.FactionIcons[faction] then
		item:SetTexture(recap_temp.FactionIcons[faction])
	else
		item:SetTexture("")
	end

end

function Recap_GetUnitInfo(unit)

	local u=UnitName(unit)

	if u then
		if recap.Combatant[u] then
			_,recap.Combatant[u].Class = UnitClass(unit)
			_,recap.Combatant[u].Faction = UnitFactionGroup(unit)
			if UnitCreatureFamily(unit) and recap.Combatant[u].Faction then
				recap.Combatant[u].Class = "Pet"
			end
			recap.Combatant[u].Level = UnitLevel(unit)
		end
	end

	if unit~="target" and unit~="mouseover" and recap_temp.Last[u] then
		if UnitIsVisible(unit) then
			recap_temp.Last[u].HP = UnitHealth(unit)
			recap_temp.Last[u].MaxHP = UnitHealthMax(unit)
		else
			recap_temp.Last[u].HP = nil -- discredit
		end
	end

end

-- creates a new .Combatant[arg1] that is a copy of DefaultCombatant
function Recap_CreateBlankCombatant(arg1)

	if not recap.Combatant[arg1] then

		recap.Combatant[arg1] = {
			TotalTime = 0,
			TotalDmgIn = 0,
			TotalDmgOut = 0,
			TotalDPS = 0,
			TotalMaxHit = 0,
			TotalKills = 0,
			TotalHeal = 0,
			LastTime = 0,
			LastDmgIn = 0,
			LastDmgOut = 0,
			LastDPS = 0,
			LastMaxHit = 0,
			LastKills = 0,
			LastHeal = 0,
			WasInLast = false,
			Friend = false,
			Ignore = nil,
			Owner = nil,
			Incoming = {},
			Detail = {}
		}

	end

end

-- populates .Opt with a copy of DefaultOpt
function Recap_LoadDefaultOpt()

	recap.Opt = {}
	for i in recap_temp.DefaultOpt do
		recap.Opt[i] = {}
		for j in recap_temp.DefaultOpt[i] do
			recap.Opt[i][j] = recap_temp.DefaultOpt[i][j]
		end
	end
end

function Recap_SaveOpt(user)

	if user and string.len(user)>0 then
		recap[user].Opt = {}
    	for i in recap.Opt do
			text = ""
			for j in recap.Opt[i] do
				text = text..tostring(j).."="..tostring(recap.Opt[i][j]).." "
			end
			recap[user].Opt[i] = text
		end
	end
end

function Recap_LoadOpt(user)

    if user and recap[user] and recap[user].Opt then
		for i in recap[user].Opt do
			if recap_temp.DefaultOpt[i] then
				for t,v in string.gfind(recap[user].Opt[i],"(%w+)=(%d-%--%w+) ") do
					if v=="true" then
						v = true
					elseif v=="false" then
						v = false
					elseif tonumber(v) then
						v = tonumber(v)
					end
					if t=="type" and recap_temp.DefaultOpt[i][t] then
						v = recap_temp.DefaultOpt[i][t]
					end
					if recap.Opt[i] then
						recap.Opt[i][t] = v
					end
				end
			end
		end
	end
end

-- saves current data to data set "filen", overwrite~=nil to overwrite existing data
function Recap_SaveCombatants(filen,overwrite)

	local sd = {}

	if not filen or string.len(filen)<1 then
		return
	end

	if not recap_set[filen] then
		recap_set[filen] = {}
		recap_set[filen].TimeStamp = date()
		recap_set[filen].TotalDuration = 0
		recap_set[filen].Combatant = {}
	end

	recap_set[filen] = {}
	recap_set[filen].TimeStamp = date()
	recap_set[filen].TotalDuration = recap[recap_temp.p].TotalDuration
	recap_set[filen].Combatant = {}
	for i in recap.Combatant do
		if (not recap.Opt.SaveFriends.value or recap.Combatant[i].Friend) then
			recap_set[filen].Combatant[i] = string.format("%s %d %d %d %d %d %.3f ~%d %d %d",
											tostring(recap.Combatant[i].Friend),
											recap.Combatant[i].TotalDmgIn,
											recap.Combatant[i].TotalDmgOut,
											recap.Combatant[i].TotalMaxHit,
											recap.Combatant[i].TotalHeal,
											recap.Combatant[i].TotalKills,
											recap.Combatant[i].TotalTime,
											Recap_MakeKey(recap.Combatant[i].Faction),
											Recap_MakeKey(recap.Combatant[i].Class),
											recap.Combatant[i].Level or 0)
			if recap.Opt.LightData and not recap.Opt.LightData.value then
				-- save .Incoming
				recap_set[filen].Combatant[i] = recap_set[filen].Combatant[i].."^"
				for k in recap.Combatant[i].Incoming do
					if recap.Combatant[i].Incoming[k]>0 then
						recap_set[filen].Combatant[i] = recap_set[filen].Combatant[i]..inckey[k]..recap.Combatant[i].Incoming[k]
					end
				end
				recap_set[filen].Combatant[i] = recap_set[filen].Combatant[i].."^"

				for j in recap.Combatant[i].Detail do
					recap_set[filen].Combatant[i] = recap_set[filen].Combatant[i].."["..j..">"
					for k in recap.Combatant[i].Detail[j] do
						recap_set[filen].Combatant[i] = recap_set[filen].Combatant[i]..detkey[k]..recap.Combatant[i].Detail[j][k]
					end
					recap_set[filen].Combatant[i] = recap_set[filen].Combatant[i].."]"
				end

			end				
		end
	end

	fight_count = 0
	for i in recap_set[filen].Combatant do
		fight_count = fight_count + 1
	end
	recap_set[filen].ListSize = fight_count
end

function Recap_MakeKey(arg1)

	local key = 0

	for i in recap_temp.Keys do
		if arg1==recap_temp.Keys[i] then
			key = i
		end
	end
	return key
end

function Recap_GetKey(arg1)

	local key = nil

	if not arg1 or not tonumber(arg1) or arg1==0 then
		key=nil
	else
		key=recap_temp.Keys[tonumber(arg1)]
	end
	return key
end

function Recap_LoadCombatants(filen,overwrite)

	local sd = {} -- temp holding place for fields that may not exist
	local found,set_friend,set_dmgin,set_dmgout,set_maxhit,set_heal,set_kills,set_time,set_faction,set_class,set_level

	if not filen or string.len(filen)<1 or not recap_set[filen] then
		return
	end

	Recap_ResetAllCombatants()
	
	recap[recap_temp.p].TotalDuration = recap[recap_temp.p].TotalDuration + recap_set[filen].TotalDuration
	
	for i in recap_set[filen].Combatant do
		if not recap.Combatant[i] then
			Recap_CreateBlankCombatant(i)
		end
		found,_,set_friend,set_dmgin,set_dmgout,set_maxhit,set_heal,set_kills,set_time = string.find(recap_set[filen].Combatant[i],"(%w+) (%d+) (%d+) (%d+) (%d+) (%d+) (%d+%.?%d+)")
		if found then
			if set_friend == "true" then
				recap.Combatant[i].Friend = true
			end
			if tonumber(set_maxhit) > recap.Combatant[i].TotalMaxHit then
				recap.Combatant[i].TotalMaxHit = tonumber(set_maxhit)
			end
			recap.Combatant[i].TotalDmgIn = recap.Combatant[i].TotalDmgIn + tonumber(set_dmgin)
			recap.Combatant[i].TotalDmgOut = recap.Combatant[i].TotalDmgOut + tonumber(set_dmgout)
			recap.Combatant[i].TotalKills = recap.Combatant[i].TotalKills + tonumber(set_kills)
			recap.Combatant[i].TotalHeal = recap.Combatant[i].TotalHeal + tonumber(set_heal)
			recap.Combatant[i].TotalTime = recap.Combatant[i].TotalTime + tonumber(set_time)
			if recap.Combatant[i].TotalTime > recap_temp.MinTime then
				recap.Combatant[i].TotalDPS = recap.Combatant[i].TotalDmgOut/recap.Combatant[i].TotalTime
			else
				recap.Combatant[i].TotalDPS = 0
			end
		end
		found,_,set_faction,set_class,set_level = string.find(recap_set[filen].Combatant[i],"~(%d+) (%d+) (%d+)")
		if not found then
			found,_,set_faction,set_class = string.find(recap_set[filen].Combatant[i],"~(%d+) (%d+)")
		end
		if found then
			recap.Combatant[i].Faction = Recap_GetKey(set_faction)
			recap.Combatant[i].Class = Recap_GetKey(set_class)
			recap.Combatant[i].Level = recap.Combatant[i].Level or set_level or 0
		end
		
		if not recap.Opt.LightData.value then

			-- process incoming: ^a000b000c000^
			for k in sd do sd[k] = nil end -- wipe temp buffer
			found,_,j = string.find(recap_set[filen].Combatant[i],"%^(.-)%^")
			if found then
				for k in inckey do
					_,_,sd[k] = string.find(j,inckey[k].."(%d+)")
				end
			elseif string.find(recap_set[filen].Combatant[i],"%^%d+ %d+ %d+ %d+ %d+ %d+ %d+ %d+ %d+ %d+ %d+ %d+ %d+") then
				found,_,sd.MeleeDamage,sd.MeleeMax,sd.MeleeHits,sd.MeleeCrits,sd.MeleeMissed,sd.MeleeDodged,sd.MeleeParried,sd.MeleeBlocked,
					sd.NonMeleeDamage,sd.NonMeleeMax,sd.NonMeleeHits,sd.NonMeleeCrits,sd.NonMeleeMissed =
						string.find(recap_set[filen].Combatant[i],"%^(%d+) (%d+) (%d+) (%d+) (%d+) (%d+) (%d+) (%d+) (%d+) (%d+) (%d+) (%d+) (%d+)")
			end
			if found then
				for k in sd do
					if sd[k] and tonumber(sd[k])>0 then
						recap.Combatant[i].Incoming[k] = tonumber(sd[k])
					end
				end
			end

			-- process details: [name:a000b000c000]
			for j in string.gfind(recap_set[filen].Combatant[i],"%[.-%]") do
				for k in sd do sd[k] = nil end -- wipe temp buffer
				found,_,set_name = string.find(j,"%[(.-)%>")
				if found then -- new saved method
					recap.Combatant[i].Detail[set_name] = {}
					for k in detkey do
						_,_,sd[k] = string.find(j,detkey[k].."(%d+)")
					end
				else
					found,_,set_name = string.find(j,"%[(.-) %d")
					if found then -- old saved method
						recap.Combatant[i].Detail[set_name] = {}
						_,_,sd.HitsDmg,sd.Hits,sd.HitsMax,sd.CritsDmg,sd.Crits,sd.CritsMax,sd.CritsEvents,sd.Missed =
							string.find(j,"%[.+ (%d+) (%d+) (%d+) (%d+) (%d+) (%d+) (%d+) (%d+)") -- old method
					end
				end
				if found then 
					for k in sd do
						if sd[k] and tonumber(sd[k])>0 then
							recap.Combatant[i].Detail[set_name][k] = tonumber(sd[k])
						end
					end
				end

			end
		end

	end

end

function Recap_ResetAllCombatants()

    local current_state = recap.Opt.State.value
	recap.Opt.State.value = "Stopped"

	recap.Combatant = {}
	recap_temp.IdleTimer = -1
	recap_temp.Last = {}
	recap[recap_temp.p].LastDuration = 0
	recap[recap_temp.p].TotalDuration = 0
	recap_temp.FightStart = 0
	recap_temp.FightEnd = 0
	recap_temp.ListSize = 0
	
	recap.Opt.State.value = current_state
end

local function Recap_LoadSelf()

	recap.Self = recap.Self or {}
	recap.Self[recap_temp.s] = recap.Self[recap_temp.s] or {}

	recap_temp.SelfList = {}
	recap_temp.SelfListSize = 1
end

function Recap_InitializeData()

	local i,j,k,l,m
	local temp_user = recap_temp.p
	local oldkeys = { ["Krieger"]="WARRIOR", ["Magier"]="MAGE", ["Schurke"]="ROGUE", ["Druide"]="DRUID",
					  ["J\195\164ger"]="HUNTER", ["Schamane"]="SHAMAN", ["Priester"]="PRIEST", ["Hexenmeister"]="WARLOCK",
					  ["Guerrier"]="WARRIOR", ["Voleur"]="ROGUE", ["Chasseur"]="HUNTER", ["Chaman"]="SHAMAN",
					  ["Prêtre"]="PRIEST", ["Démoniste"]="WARLOCK", ["Familier"]="Pet" }


	if not recap.DataVersion then
		-- wipe all pre-2.6 data
		recap = {}
		recap.DataVersion = 3.2
	elseif recap.DataVersion < 3.0 then
		-- convert 2.6 to 3.0, make classes uppercase
		for i in recap.Combatant do

			if recap.Combatant[i].Faction=="Allianz" then
				recap.Combatant[i].Faction = "Alliance"
			end

			if recap.Combatant[i].Class then
				-- convert classes to english, which all locales will use for icon reference
				if oldkeys[recap.Combatant[i].Class] then
					recap.Combatant[i].Class = oldkeys[recap.Combatant[i].Class]
				end
				recap.Combatant[i].Class = string.upper(recap.Combatant[i].Class)
			end
		end
		recap.DataVersion = 3.0
	end

	-- if this user hasn't been made before
	if not recap[recap_temp.p] then
		recap[recap_temp.p] = {}
		recap[recap_temp.p].TotalDuration = 0
		recap[recap_temp.p].LastDuration = 0
	end

	-- if this is a different/first-time user, or if this is first run of a new version,
	-- save the current combatants and options and then load them based on default.
	-- any changes in combatant or option format must come with a version change
	if (recap.User ~= recap_temp.p) or recap.DataVersion<Recap_Version then

		-- if we have data from previous user, save them
		if recap.User then
			recap_temp.p = recap.User
			Recap_SaveCombatants("UserData:"..recap.User,1)
			Recap_SaveOpt(recap.User)
			recap_temp.p = temp_user
		end
		recap.User = recap_temp.p

		-- wipe slate, load defaults and overlay saved data ontop
		Recap_LoadDefaultOpt()
		Recap_ResetAllCombatants()

		-- convert data sets to new format (see readme)
		if recap.DataVersion < 3.2 then
			for i in recap_set do
				if recap_set[i].Combatant then
					j = recap_set[i].TimeStamp
					Recap_LoadCombatants(i,1)
					for k in recap_set[i].Combatant do
						l = (l or 0) + string.len(recap_set[i].Combatant[k])
					end
					Recap_SaveCombatants(i,1)
					for k in recap_set[i].Combatant do
						m = (m or 0) + string.len(recap_set[i].Combatant[k])
					end
					recap_set[i].TimeStamp = j
				end
			end
			recap.DataVersion = 3.2
		end

		Recap_LoadCombatants("UserData:"..recap_temp.p,1)
		Recap_LoadOpt(recap_temp.p)

		recap.DataVersion = Recap_Version

	else
		for i in recap.Combatant do
			recap_temp.Last[i] = { Start = 0, End = 0, DmgIn = 0, DmgOut = 0, MaxHit = 0, Kills = 0, Heal = 0 }
		end
	end

	-- remove current UserData: - it's now "live" in recap.Combatant
	if recap_set and recap_set["UserData:"..recap_temp.p] then
		recap_set["UserData:"..recap_temp.p] = nil
	end

	Recap_LoadSelf()

end

--[[ Context menu functions ]]

function RecapMenu_OnUpdate(arg1)

	local i

	if not recap_temp.MenuTimer or MouseIsOver(RecapMenu) then
		recap_temp.MenuTimer = 0
	end

	recap_temp.MenuTimer = recap_temp.MenuTimer + arg1
	if recap_temp.MenuTimer > .2 then
		recap_temp.MenuTimer = 0
		RecapMenu:Hide()
		if recap_temp.SelectedEffect then
			for i=1,15 do
				getglobal("RecapSelf"..i):UnlockHighlight()
			end
		end
	end
end


--[[ Fight report functions ]]

function Recap_AutoPostGetStatID(arg1)

	if arg1=="Damage" then
		return "DmgOut"
	elseif arg1=="Tanking" then
		return "DmgIn"
	elseif arg1=="Healing" then
		return "Heal"
	end
	return "DPS"
end

function Recap_PostFight()

	local print_chat = SendChatMessage
	local chatchan, chatnum, text

	if recap.Opt.SpamRows.value then
		Recap_PostSpamRows(Recap_AutoPostGetStatID(recap.Opt.AutoPost.Stat),"recap auto")
	else
		chatchan = recap.Opt.AutoPost.Channel
		_,_,chatnum = string.find(chatchan,"(%d+)")
		if chatnum then
			chatchan = "CHANNEL"
		end
		if chatchan=="Self" then
			print_chat = Recap_Print
		end
		text = Recap_PostSpamLine(Recap_AutoPostGetStatID(recap.Opt.AutoPost.Stat))
		if string.find(text,"%d") then
			print_chat(Recap_PostSpamLine(Recap_AutoPostGetStatID(recap.Opt.AutoPost.Stat)),chatchan,nil,chatnum)
		end
	end

end

function Recap_PostLeader()

	local print_chat = SendChatMessage
	local chatchan, chatnum, leader, statid, i

	if recap_temp.ListSize>2 then
		chatchan = recap.Opt.AutoPost.Channel
		_,_,chatnum = string.find(chatchan,"(%d+)")
		if chatnum then
			chatchan = "CHANNEL"
		end
		if chatchan=="Self" then
			print_chat = Recap_Print
		end
		statid = Recap_AutoPostGetStatID(recap.Opt.AutoPost.Stat)

		if not recap.Combatant[recap_temp.Leader] then -- in case leader reset
			recap_temp.Leader = nil
		end

		if not recap_temp.Leader and recap.Combatant[recap_temp.List[1].Name].Friend then
			recap_temp.Leader = recap_temp.List[1].Name
			leader = recap_temp.Leader -- spam initial leader
		end

		if recap_temp.Leader then
			for i in recap.Combatant do
				if (recap.Combatant[i]["Total"..statid] > recap.Combatant[recap_temp.Leader]["Total"..statid]) and recap.Combatant[i].Friend then
					leader = i
				end
			end
			if leader then
				recap_temp.Leader = leader
				print_chat(string.format("New leader for %s: %s with %s",recap.Opt.AutoPost.Stat,leader,Recap_FormatStat(statid,leader)),chatchan,nil,chatnum) 
			end
		end
	end
end


-- returns 'text' to be spammed in autopost or linked in chat
function Recap_PostSpamLine(arg1)

	local text,i

	text = recap_temp.Local.LinkRank[arg1].." for "..recap_temp.Local.LastAll[recap.Opt.View.value]..":"
	for i=1,recap.Opt.MaxRank.value do
		if i<recap_temp.ListSize and recap.Combatant[recap_temp.List[i].Name].Friend then
			if recap_temp.List[i][arg1]>0 then
				text = text.." ["..i.."."..recap_temp.List[i].Name.." "..Recap_FormatStat(arg1,i).."]"
			end
		end
	end
	return text
end

-- arg1 = stat to report by (DPS, DmgOut, etc)
function Recap_PostSpamRows(arg1,chatchan,chatnum)

	local headertext = nil
	local print_chat = SendChatMessage

	if chatchan=="recap auto" then
		chatchan = recap.Opt.AutoPost.Channel
	end

	arg1 = string.gsub(arg1,"P$","") -- strip trailing P from % id's

	if not chatnum then
		_,_,chatnum = string.find(chatchan,"(%d+)")
		if chatnum then
			chatchan = "CHANNEL"
		end
	end
	if chatchan=="Self" then
		print_chat = Recap_Print
	end
	headertext = "__ "..recap_temp.Local.LinkRank[arg1].." for "..recap_temp.Local.LastAll[recap.Opt.View.value].." __"
	for i=1,recap.Opt.MaxRank.value do
		if i<recap_temp.ListSize and recap.Combatant[recap_temp.List[i].Name].Friend then
			text = i..". "..recap_temp.List[i].Name..": "..Recap_FormatStat(arg1,i)
			if recap_temp.List[i][arg1] > 0 then
				if headertext then
					print_chat(headertext,chatchan,nil,chatnum)
					headertext = nil
				end
				print_chat(text,chatchan,nil,chatnum)
			end
		end
	end
end

-- returns a formatted string for arg1 stat ("DPS" "Time" etc) for combatant arg2 (number is .List[], non-number is name)
function Recap_FormatStat(arg1,arg2)

	local i

    arg1 = string.gsub(arg1,"P$","")

	if not tonumber(arg2) then

		for i=1,(recap_temp.ListSize-1) do
			if recap_temp.List[i].Name==arg2 then
				arg2 = i
				i = recap_temp.ListSize
			end
		end
	end

	if tonumber(arg2) then

		if arg1=="DPS" then
			return string.format("%.1f",recap_temp.List[arg2].DPS)
		elseif arg1=="DPSvsAll" then
			return string.format("%.1f",recap_temp.List[arg2].DPSvsAll)
		elseif arg1=="Time" then
			return Recap_FormatTime(recap_temp.List[arg2].Time)
		elseif arg1=="DmgOut" then
			return recap_temp.List[arg2].DmgOut.." ("..recap_temp.List[arg2].DmgOutP.."%)"
		elseif arg1=="DmgIn" then
			return recap_temp.List[arg2].DmgIn.." ("..recap_temp.List[arg2].DmgInP.."%)"
		elseif arg1=="Heal" then
			return recap_temp.List[arg2].Heal.." ("..recap_temp.List[arg2].HealP.."%)"
		elseif arg1=="Over" then
			return recap_temp.List[arg2].Over.."%"
		else
			return recap_temp.List[arg2][arg1]
		end
	end

	return ""
end


function Recap_Print(arg1)
	DEFAULT_CHAT_FRAME:AddMessage(tostring(arg1))
end

--[[ Debug ]]

function Recap_DebugUnusedFilters(filter)

	local i,j,found

	for i in recap_temp[filter] do
		found = false
		for j in recap.debug_Filter do
			if recap_temp[filter][i].pattern==recap.debug_Filter[j].pattern then
				found = true
			end
		end
		if not found then
			DEFAULT_CHAT_FRAME:AddMessage(filter..": "..recap_temp[filter][i].pattern)
		end
	end

end

function Recap_MoveMinimize()

	RecapCloseButton:ClearAllPoints()
	RecapCloseButton:SetPoint("TOPRIGHT","RecapFrame","TOPRIGHT",-6,-6)
	RecapMinStatus:ClearAllPoints()
	RecapMinStatus:SetPoint("TOPLEFT", "RecapFrame", "TOPLEFT", 6,-7)
	RecapResetButton:ClearAllPoints()
	RecapResetButton:SetPoint("BOTTOMLEFT", "RecapFrame", "BOTTOMLEFT", 5,4)
	RecapMinimizeButton:ClearAllPoints()

	if recap.Opt.GrowLeftwards.value and not recap.Opt.GrowUpwards.value then -- topright
		RecapMinimizeButton:SetPoint("TOPRIGHT", "RecapFrame", "TOPRIGHT", -6, -6)
		RecapCloseButton:SetPoint("TOPRIGHT", "RecapMinimizeButton", "TOPLEFT", -2, 0)
	elseif recap.Opt.GrowLeftwards.value and recap.Opt.GrowUpwards.value then -- bottomright
		RecapMinimizeButton:SetPoint("BOTTOMRIGHT", "RecapFrame", "BOTTOMRIGHT", -6, 6)
		if recap.Opt.Minimized.value then
			RecapCloseButton:SetPoint("TOPRIGHT", "RecapMinimizeButton", "TOPLEFT", -2, 0)
		end
	elseif not recap.Opt.GrowLeftwards.value and not recap.Opt.GrowUpwards.value then -- topleft
		RecapMinimizeButton:SetPoint("TOPLEFT", "RecapFrame", "TOPLEFT", 6, -6)
		RecapMinStatus:SetPoint("TOPLEFT", "RecapMinimizeButton", "TOPRIGHT", 2, -1)
	else -- bottomleft
		RecapMinimizeButton:SetPoint("BOTTOMLEFT", "RecapFrame", "BOTTOMLEFT", 6, 6)
		RecapResetButton:SetPoint("BOTTOMLEFT", "RecapFrame", "BOTTOMLEFT", 23, 4)
	end

	if recap.Opt.Minimized.value and not recap.Opt.GrowLeftwards.value then
		RecapMinStatus:SetPoint("TOPLEFT", "RecapMinimizeButton", "TOPRIGHT", 2, -1)
	end

	if recap.Opt.AutoMinimize.value then
		RecapMinimizeButton:SetWidth(1)
		RecapMinimizeButton:Hide()
	else
		RecapMinimizeButton:SetWidth(16)
		RecapMinimizeButton:Show()
	end

end

function RecapMenu_SetCheck(id,arg1)

	if arg1 then
		getglobal("RecapMenu"..id.."_Check"):Show()
	else
		getglobal("RecapMenu"..id.."_Check"):Hide()
	end
end

function RecapMenu_OnClick()

	local id,index = this:GetID()

	if recap_temp.Menu==recap_temp.ColumnMenu or recap_temp.Menu==recap_temp.MinMenu or recap_temp.Menu==recap_temp.EffectOptMenu then
		index = recap_temp.Menu[id].Info -- .Info of menu item selected
		if recap.Opt[index] then
			recap.Opt[index].value = not recap.Opt[index].value
			getglobal("RecapOptCheck_"..recap_temp.Menu[id].Info):SetChecked(0)
			if recap.Opt[index].value then
				getglobal("RecapOptCheck_"..recap_temp.Menu[id].Info):SetChecked(1)
			end
			RecapMenu_SetCheck(id,recap.Opt[index].value)
			if recap.Opt.Minimized.value then
				Recap_Minimize()
			else
				Recap_Maximize()
			end
		elseif index=="Pin" then
			recap.Opt.Pinned.value = not recap.Opt.Pinned.value
			Recap_SetButtons()
			RecapMenu:Hide()
		end
	end


	if recap_temp.Menu==recap_temp.AddMenu or recap_temp.Menu==recap_temp.DropMenu then
		RecapMenu:Hide()
		index = recap_temp.List[recap_temp.Selected].Name -- name selected

		if id==1 and recap_temp.Menu==recap_temp.DropMenu and index~=recap_temp.Player then
			recap.Combatant[index].Friend = false
		elseif id==1 and index~=recap_temp.Player then
			recap.Combatant[index].Friend = not recap.Combatant[index].Friend
		elseif id==2 and recap.Opt.View.value=="All" then -- reset
			recap.Combatant[index] = nil
			Recap_CreateBlankCombatant(index)
		elseif id==2 and recap.Opt.View.value=="Last" then
			if recap.Combatant[index].WasInLast then
				Recap_ResetLastFight(index)
			end
		elseif id==3 and index~=recap_temp.Player then
			recap.Combatant[index] = nil
			Recap_CreateBlankCombatant(index)
			recap.Combatant[index].Ignore = true
		end
	
		Recap_SetView()
	end

	if recap_temp.Menu==recap_temp.EffectMenu then
		RecapMenu:Hide()
		for i=1,15 do
			getglobal("RecapSelf"..i):UnlockHighlight()
		end
		if recap_temp.SelectedEffect and recap.Self[recap_temp.s][recap_temp.SelectedEffect] then
			recap.Self[recap_temp.s][recap_temp.SelectedEffect] = nil
			recap_temp.SelectedEffect = nil
			Recap_SetView()
		end
	end

	if recap_temp.Menu==recap_temp.DetailMenu then
		if recap_temp.DetailsList and recap_temp.DetailsList[1][recap_temp.Menu[id].Info] then
			recap.Opt.PanelDetail.value = recap_temp.Menu[id].Info
			RecapPanel_Populate(recap_temp.List[recap_temp.Selected].Name)
		end
		RecapMenu:Hide()
	end
end

-- offset=1 to move window so it's under pointer
function RecapCreateMenu(menu,offset)

	local i,cy,x,y,lines

	recap_temp.Menu = menu

	if recap_temp.Menu==recap_temp.ColumnMenu or recap_temp.Menu==recap_temp.MinMenu or recap_temp.Menu==recap_temp.EffectOptMenu then
		for i in recap_temp.Menu do
			if recap.Opt[recap_temp.Menu[i].Info] then
				recap_temp.Menu[i].Check = recap.Opt[recap_temp.Menu[i].Info].value
			end
		end
	end

	if recap_temp.Menu==recap_temp.MinMenu then
		recap_temp.Menu[1].Check = recap.Opt.Pinned.value
	end

	if recap_temp.Menu==recap_temp.DetailMenu then
		for i in recap_temp.Menu do
			recap_temp.Menu[i].Check = recap.Opt.PanelDetail.value==recap_temp.Menu[i].Info
		end
	end

	lines = min(table.getn(recap_temp.Menu),16)

	cy = 44 -- 12+32
	for i=1,lines do
		getglobal("RecapMenu"..i.."_Text"):SetText(recap_temp.Menu[i].Text)
		RecapMenu_SetCheck(i,recap_temp.Menu[i].Check)
		getglobal("RecapMenu"..i):Show()
		cy = cy + 14
	end
	for i=(lines+1),16 do
		getglobal("RecapMenu"..i):Hide()
	end

	RecapMenu:SetHeight(cy)
	RecapDropSubFrame:SetHeight(cy-32)
	RecapMenu:ClearAllPoints()
	x,y = GetCursorPosition()
	if recap.Opt.GrowUpwards.value and not offset then
		y = this:GetBottom()*UIParent:GetScale()
		RecapMenu:SetPoint("BOTTOMRIGHT","UIParent","BOTTOMLEFT",(x/UIParent:GetScale())+20,(y/UIParent:GetScale())-4)
	else
		y = this:GetTop()*UIParent:GetScale()
		RecapMenu:SetPoint("TOPRIGHT","UIParent","BOTTOMLEFT",(x/UIParent:GetScale())+20,(y/UIParent:GetScale())+(offset and 16 or 4))
	end
	RecapMenu:Show()

end

function RecapMenu_OnEnter()
	id = this:GetID()
	if recap_temp.Menu[id] and recap_temp.Menu[id].Info then
		if recap_temp.Menu==recap_temp.AddMenu or recap_temp.Menu==recap_temp.DropMenu then
			Recap_OnTooltip(recap_temp.Menu[id].Info,recap_temp.List[recap_temp.Selected].Name)
		elseif recap_temp.Menu==recap_temp.EffectMenu and recap_temp.SelectedEffect then
			Recap_OnTooltip(recap_temp.Menu[id].Info,string.sub(recap_temp.SelectedEffect,2))
		else
			Recap_OnTooltip(recap_temp.Menu[id].Info)
		end
	end
end

function RecapEffectsHeader_OnEnter()
	local s

	_,_,s = string.find(this:GetName(),"RecapHeader_(.+)")
	if s then
		Recap_OnTooltip("Header"..s)
	end
end

function RecapSelf_OnMouseUp(arg1)

	local index,i 
	
	recap_temp.SelectedEffect = nil

	Recap_OnMouseUp(arg1)
	if arg1=="RightButton" then
		_,_,i = string.find(this:GetName(),"(%d+)")
		if i and tonumber(i) then
			i = tonumber(i)
			index = i + FauxScrollFrame_GetOffset(RecapScrollBar)
			if index < recap_temp.SelfListSize then
				this:LockHighlight()
				recap_temp.SelectedEffect = recap_temp.SelfList[index].EName
			end
		end
		
		RecapCreateMenu(recap_temp.EffectMenu,1)
	end
end

function RecapEffectsHeader_OnMouseUp(arg1)

	if arg1=="RightButton" then
		RecapCreateMenu(recap_temp.EffectOptMenu)
	end
end

function RecapEffectsHeader_OnClick()

	local idx,i
	local alltext,text = ""
	local channel,chatnumber = ChatFrameEditBox.chatType
	local hasdata

	if IsShiftKeyDown() and ChatFrameEditBox:IsVisible() then

		if channel=="WHISPER" then
			chatnumber = ChatFrameEditBox.tellTarget
		elseif channel=="CHANNEL" then
			chatnumber = ChatFrameEditBox.channelTarget
		end
		
		_,_,idx = string.find(tostring(this:GetName()),"RecapHeader_(.+)")
		if idx and idx~="EName" then

			alltext = (recap.Opt.SpamRows.value and "__ " or "")..recap_temp.Player.."'s "..Recap_GetTooltip("Header"..idx)..(recap.Opt.SpamRows.value and " __" or ":")
			for i=1,recap_temp.SelfListSize-1 do
				if recap_temp.SelfList[i][idx]~="0.0%" and recap_temp.SelfList[i][idx]~="--" and tostring(recap_temp.SelfList[i][idx])~="0" then
					if not hasdata and recap.Opt.SpamRows.value then
						SendChatMessage(alltext,channel,nil,chatnumber)
					end
					hasdata = true
					text = string.sub(recap_temp.SelfList[i].EName,2)..(string.sub(recap_temp.SelfList[i].EName,1,1)=="3" and "*" or "")..(recap.Opt.SpamRows.value and ": " or " ")..recap_temp.SelfList[i][idx]..(idx=="ETotal" and (" ("..recap_temp.SelfList[i].ETotalP..")") or "")
					if not recap.Opt.SpamRows.value then
						alltext = alltext.." ["..text.."]"
					else
						SendChatMessage(text,channel,nil,chatnumber)
					end
				end
			end
			if not recap.Opt.SpamRows.value and hasdata then
				Recap_InsertChat(alltext)
			end
		end
	end
end


function RecapSelf_OnClick()

	local id = this:GetID()
	local index = id + FauxScrollFrame_GetOffset(RecapScrollBar)
	local linkformat = recap_temp.Local.DamageDetailLink
	local text = ""

	if IsShiftKeyDown() and index<recap_temp.SelfListSize and ChatFrameEditBox:IsVisible() then

		if string.sub(recap_temp.SelfList[index].EName,1,1)=="3" then
			linkformat = recap_temp.Local.HealDetailLink
		end
		text = string.format(linkformat,recap_temp.Player,string.sub(recap_temp.SelfList[index].EName,2),recap_temp.SelfList[index].ETotal,recap_temp.SelfList[index].ETotalP )..", Max: "..recap_temp.SelfList[index].EMaxAll..((recap_temp.SelfList[index].ECritsP~="--") and (", Crit Rate: "..recap_temp.SelfList[index].ECritsP) or "")
		Recap_InsertChat(text," ")
	end
end


function Recap_Combat_OnEvent()

	if event=="CHAT_MSG_COMBAT_FRIENDLY_DEATH" or event=="CHAT_MSG_COMBAT_HOSTILE_DEATH" then
		Recap_DeathEvent(arg1)
	elseif event=="UPDATE_MOUSEOVER_UNIT" then
		Recap_GetUnitInfo("mouseover")
	elseif event=="PLAYER_TARGET_CHANGED" then
		Recap_GetUnitInfo("target")
	elseif event=="SPELLCAST_START" then
		if (not recap.Opt.LightData.value) and recap.Combatant[recap_temp.Player] and recap.Combatant[recap_temp.Player].Detail["1"..arg1] then
			if not recap.Opt.LimitFights.value then
				if recap.Opt.IdleFight.value then
					recap_temp.IdleTimer = 0
				end
				if recap.Opt.State.value=="Idle" then
					Recap_StartFight()
				end
			end
			Recap_CreateCombatant(recap_temp.Player,1) -- if this was a cast that's done damage before, start timer
		end
	elseif string.find(event,"BUFF") then
		Recap_HealEvent(arg1)
	else
		Recap_DamageEvent(arg1)
	end
end

function Recap_Register_CombatEvents()

	if not recap_temp.CombatEventsRegistered then
	-- register damage events
		RecapCombatEvents:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_MISSES")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLYPLAYER_MISSES")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_COMBAT_PARTY_HITS")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_COMBAT_PARTY_MISSES")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_COMBAT_PET_HITS")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_COMBAT_PET_MISSES")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_COMBAT_SELF_MISSES")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_PARTY_DAMAGE")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_PET_DAMAGE")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")

		-- register death events
		RecapCombatEvents:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLY_DEATH")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH")

		-- register healing events
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_BUFF")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_BUFF")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_PARTY_BUFF")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_PET_BUFF")
		RecapCombatEvents:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF")

		RecapCombatEvents:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
		RecapCombatEvents:RegisterEvent("PLAYER_TARGET_CHANGED")
		RecapCombatEvents:RegisterEvent("SPELLCAST_START")
		recap_temp.CombatEventsRegistered = 1
	end
end

function Recap_Unregister_CombatEvents()
	if recap_temp.CombatEventsRegistered then
		RecapCombatEvents:UnregisterAllEvents()
		recap_temp.CombatEventsRegistered = nil
	end
end