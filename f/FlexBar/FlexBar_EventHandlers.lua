local util = Utility_Class:New()

FBEventHandlers["VARIABLES_LOADED"] =
	function(event)
	-- Saved Variables available here
	-- Convert from old individual global options to a table.
		if FBFirstUse 	then FBToggles["firstuse"] = FBFirstUse end
		if FBVerbose 	then FBToggles["verbose"] = FBVerbose end
		if FBNoTooltips	then FBToggles["notooltips"] = FBNoTooltips end
		if FBSafeLoad 	then FBToggles["loadtype"] = "safe" end
		if FBFastLoad	then FBToggles["loadtype"] = "fast" end
		if not FBToggles["loadtype"] then FBToggles["loadtype"] = "std" end
		if not FBToggles["dropdown"] then FBToggles["dropdown"] = 5 end
		if not FBToggles["tooltipinfocolor"] then FBToggles["tooltipinfocolor"] = { r=1, g=1, b=1 } end
		
		if FBToggles["firstuse"]  == 0 then
			FlexBar_LoadDefaults();
		end
		util:Print(format("FlexBar V%.3f loaded.  Type /flexbar for usage", FlexBarVersion));
		FBLoadProfileDialog:Hide()
		if FBToggles["loadtype"] == "safe" then
			LoadProfileButton:Show()
		end
	end

FBEventHandlers["PLAYER_ENTERING_WORLD"] = 
	function()
	-- moved profile load timer here to avoid setting group bounds while GetRight etc return bad values
	-- if profile already loaded, return.
		if FBProfileLoaded then return end
	-- localize strings
		FBLocalize()
		local delay=10
		if FBToggles["loadtype"] == "fast" then
			delay=1
		end
		FBTimers["loadprofile"] = Timer_Class:New(delay, nil, 
		"Flexbar settings loading", nil, FB_LoadProfile)
	end

FBEventHandlers["PLAYER_ENTER_COMBAT"] =
	function(event)
	-- self explanatory - raise event for player initiating auto-attack
		if not FBProfileLoaded then return end
		if FBEventToggles["meleecheck"] == "off" then return end
		FB_RaiseEvent("EnterCombat")
		FBConditionalState["incombat"] = true
	end
	
FBEventHandlers["PLAYER_LEAVE_COMBAT"] = 
	function(event)
	-- raise event for player turning autoattack off
		if not FBProfileLoaded then return end
		if FBEventToggles["meleecheck"] == "off" then return end
		FB_RaiseEvent("LeaveCombat")
		FBConditionalState["incombat"] = nil
	end
	
FBEventHandlers["PLAYER_REGEN_ENABLED"] = 
	function(event)
	-- raise event for lose aggro (which is when regen is re-enabled)
		if not FBProfileLoaded then return end
		if FBEventToggles["aggrocheck"] == "off" then return end
		FB_RaiseEvent("LoseAggro")
		FBConditionalState["hasaggro"] = nil
	end
	
FBEventHandlers["PLAYER_REGEN_DISABLED"] = 
	function(event)
	-- raise event for gain aggro (player regen is disabled when you have aggro)
		if not FBProfileLoaded then return end
		if FBEventToggles["aggrocheck"] == "off" then return end
		FB_RaiseEvent("GainAggro")
		FBConditionalState["hasaggro"] = true
	end

local nonraidunits = {
	["player"] 	= true,
	["party1"] 	= true,
	["party2"] 	= true,
	["party3"] 	= true,
	["party4"] 	= true,
	["pet"]		= true,
	["partypet1"] = true,
	["partypet2"] 	= true,
	["partypet3"] 	= true,
	["partypet4"] 	= true,
	["target"] 		= true,
}
FBEventHandlers["UNIT_AURA"] = 
	function(event)
		-- lost/gain buff - raise event.  Note, losing buffs to dieing doesn't trigger this.
		-- also, some forms do not trigger this when they fade apparently
		if FBToggles["raidsafe"] and not nonraidunits[arg1] then return end
		FB_CheckAllBuffs(arg1)
		if arg1 == "pet" then FB_MimicPetButtons() end
	end
	
FBEventHandlers["CHAT_MSG_COMBAT_SELF_MISSES"] = 
	function(event)
	-- pretty sure all these are right - if anyone has trouble getting the right reactions I'll revisit
		if not FBProfileLoaded then return end
		if FBEventToggles["missevents"] == "off" then return end
		if strfind(arg1, "dodges") then
			FB_RaiseEvent("PlayerMiss", "dodge")
		elseif strfind(arg1, "parries") then
			FB_RaiseEvent("PlayerMiss", "parry")
		elseif strfind(arg1, "blocks") then
			FB_RaiseEvent("PlayerMiss", "block")
		else
			FB_RaiseEvent("PlayerMiss", "miss")
		end
	end
	
FBEventHandlers["CHAT_MSG_SPELL_SELF_DAMAGE"] = 
	function(event) 
	-- pretty sure all these are right - if anyone has trouble getting the right reactions I'll revisit 
	if not FBProfileLoaded then return end 
	if FBEventToggles["missevents"] == "off" then return end 
	if strfind(arg1, "was dodged") then 
		FB_RaiseEvent("PlayerMiss", "dodge") 
	elseif strfind(arg1, "parries") then 
		FB_RaiseEvent("PlayerMiss", "parry") 
	elseif strfind(arg1, "blocks") then 
		FB_RaiseEvent("PlayerMiss", "block") 
	else 
		FB_RaiseEvent("PlayerMiss", "miss") 
	end 
end 

FBEventHandlers["CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES"] = 
	function(event)
	-- Same as above
		if not FBProfileLoaded then return end
		if FBEventToggles["missevents"] == "off" then return end
		if strfind(arg1, "dodge") then
			FB_RaiseEvent("TargetMiss", "dodge")
		elseif strfind(arg1, "parry") then
			FB_RaiseEvent("TargetMiss", "parry")
		elseif strfind(arg1, "block") then
			FB_RaiseEvent("TargetMiss", "block")
		else
			FB_RaiseEvent("TargetMiss", "miss")
		end
	end
	
FBEventHandlers["UNIT_HEALTH"] = 
	function(event)
	-- raise events for the health of available unit codes dropping by 10% increments, and
	-- climbing by the same increments.  Available units are player, party1-party4, pet, target, mouseover
		if FBToggles["raidsafe"] and not nonraidunits[arg1] then return end
		if not FBProfileLoaded then return end
		if FBEventToggles["healthevents"] == "off" then return end
		local list = FBEventToggleInfo["healthevents"][FBEventToggles["healthevents"].."list"]
		if FBEventToggles["healthevents"] == "low" and not list[arg1] then return end
		FB_CheckTextSub()
		local hppercent = UnitHealth(arg1)/UnitHealthMax(arg1) * 100
		if FBLastHealth[arg1] then
			local index
			for index = 100, 10, -10 do
				if FBLastHealth[arg1] >= index and hppercent < index then
					FB_RaiseEvent("HealthBelow" .. index, arg1)
				end
			end
			for index = 10, 90, 10 do
				if FBLastHealth[arg1] <= index and hppercent > index then
					FB_RaiseEvent("HealthAbove" .. index, arg1)
				end
			end
			if FBLastHealth[arg1] <=99 and hppercent > 99 then
				FB_RaiseEvent("HealthFull", arg1)
			end
		end
		FBLastHealth[arg1] = hppercent
	end
	
FBEventHandlers["UNIT_MANA"] = 
	function(event)
	-- raise events for the health of available unit codes dropping by 10% increments, and
	-- climbing by the same increments.  Available units are player, party1-party4, pet, target, mouseover
		if FBToggles["raidsafe"] and not nonraidunits[arg1] then return end
		if not FBProfileLoaded then return end
		if FBEventToggles["manaevents"] == "off" then return end
		local list = FBEventToggleInfo["manaevents"][FBEventToggles["manaevents"].."list"]
		if FBEventToggles["manaevents"] == "low" and not list[arg1] then return end
		FB_CheckTextSub()
		local manapercent = UnitMana(arg1)/UnitManaMax(arg1) * 100
		if FBLastMana[arg1] then
			local index
			for index = 100, 10, -10 do
				if FBLastMana[arg1] >= index and manapercent < index then
					FB_RaiseEvent("ManaBelow" .. index, arg1)
				end
			end
			for index = 10, 90, 10 do
				if FBLastMana[arg1] <= index and manapercent > index then
					FB_RaiseEvent("ManaAbove" .. index, arg1)
				end
			end
			if FBLastMana[arg1] <=99 and manapercent > 99 then
				FB_RaiseEvent("ManaFull", arg1)
			end
		end
		FBLastMana[arg1] = manapercent	
	end

FBEventHandlers["UNIT_RAGE"] = FBEventHandlers["UNIT_MANA"]
FBEventHandlers["UNIT_ENERGY"] = FBEventHandlers["UNIT_MANA"]
	
FBEventHandlers["ACTIONBAR_PAGE_CHANGED"] = 
	function(event)
	-- Action bar changed - allows syncing group to action bar
		if not FBProfileLoaded then return end
		if FBEventToggles["actionbarpage"] == "off" then return end
		FB_RaiseEvent("ActionBarPage", CURRENT_ACTIONBAR_PAGE)
	end
	
FBEventHandlers["SPELLS_CHANGED"] = 
	function(event)
	-- Reload spell info on spells changing
		FB_GetSpellInfo()
	end

FBEventHandlers["PLAYER_COMBO_POINTS"] = 
	function(event)
	-- Raise event for a change in combo points
		if not FBProfileLoaded then return end
		FB_CheckTextSub()
		if FBEventToggles["comboevents"] == "off" then return end
		FB_RaiseEvent("ComboPoints",GetComboPoints())
	end

FBEventHandlers["PLAYER_GAINED_CONTROL"] = 
	function(event)
	-- my tester for Gained Control - hopefully can use for fear etc..
		if not FBScripts[event] then FBScripts[event] = "" end
		arg1 = tostring(arg1)
		arg2 = tostring(arg2)
		arg3 = tostring(arg3)
		arg4 = tostring(arg4)
		arg5 = tostring(arg5)
		local text = GetTime () .. ": arg1=%s;arg2=%s;arg3=%s;arg4=%s;arg5=%s\n"
		FBScripts[event] = FBScripts[event] .. text
	end

FBEventHandlers["PLAYER_LOST_CONTROL"] = 
	function(event)
	-- my tester for Lost Control - hopefully can use for fear etc..
		if not FBScripts[event] then FBScripts[event] = "" end
		arg1 = tostring(arg1)
		arg2 = tostring(arg2)
		arg3 = tostring(arg3)
		arg4 = tostring(arg4)
		arg5 = tostring(arg5)
		local text = GetTime () .. ": arg1=%s;arg2=%s;arg3=%s;arg4=%s;arg5=%s\n"
		FBScripts[event] = FBScripts[event] .. text
	end

FBEventHandlers["BAG_UPDATE"] = 
	function(event)
	-- Raise event for bag contents changing
		if not FBProfileLoaded then return end
		FB_CheckAutoItems()
		if FBAutoItemsFrame:IsVisible() then
			FB_DisplayAutoItems()
		end
		FB_CheckTextSub()
	end
	
FBEventHandlers["UNIT_INVENTORY_CHANGED"] = 
	function(event)
		if not FBProfileLoaded then return end
		FB_CheckAutoItems()
		if FBAutoItemsFrame:IsVisible() then
			FB_DisplayAutoItems()
		end
	end

FBEventHandlers["UPDATE_INVENTORY_ALERTS"] = 
	function(event)
		if not FBProfileLoaded then return end
		FB_CheckAutoItems()
		if FBAutoItemsFrame:IsVisible() then
			FB_DisplayAutoItems()
		end
	end

FBEventHandlers["ACTIONBAR_SLOT_CHANGED"] = 
	function(event)
		if not FBProfileLoaded then return end
		FB_CheckAutoItems()
		if FBAutoItemsFrame:IsVisible() then
			FB_DisplayAutoItems()
		end
	end

FBEventHandlers["MERCHANT_CLOSED"] = 
	function(event)
		if not FBProfileLoaded then return end
		FB_CheckAutoItems()
		if FBAutoItemsFrame:IsVisible() then
			FB_DisplayAutoItems()
		end
	end

FBEventHandlers["MERCHANT_UPDATE"] = 
	function(event)
		if not FBProfileLoaded then return end
		FB_CheckAutoItems()
		if FBAutoItemsFrame:IsVisible() then
			FB_DisplayAutoItems()
		end
	end

FBEventHandlers["UNIT_COMBAT"] = 
	function(event)
	-- Combat events - replace miss events
		if FBToggles["raidsafe"] and not nonraidunits[arg1] then return end
		if not FBProfileLoaded then return end
		if FBEventToggles["combatevents"] == "off" then return end
		-- only raise/check player/target
		if arg1 ~= "player" and arg1 ~= "target" then return end
		if arg3 ~= "" then
			FB_RaiseEvent(arg1.."Combat",tostring(arg3))
			FBCombatTypes["'"..string.lower(arg3).."'"] = true
		else
			FB_RaiseEvent(arg1.."Combat",tostring(arg2))
			FBCombatTypes["'"..string.lower(arg2).."'"] = true
		end
	end
	
FBEventHandlers["PLAYER_TARGET_CHANGED"] = 
	function(event)
	-- Raise target changed events
	-- When UnitName("target") is nil we lost the old target
	-- when UnitName("target") is not nil we gained a new target
	-- arg1 contains the GetTime() * 1000 when we gain a target, nil otherwise
	--(DJE 8/16/05) Function altered to fix Duel targets being concidered friendly
	--(DJE 8/16/05) It would apear that WoW conciders Duel targets BOTH friendly and hostile
	--(DJE 8/16/05) I think that in every case hostility would be more of a concern than friendliness
	--(DJE 8/16/05) So the order of the checks were swaped
		FBLastTargetTarget = nil
		FBLastTargetTargetName = nil
		if not FBProfileLoaded then return end
		if FBEventToggles["targetcheck"] == "off" then return end

		local name = UnitName("target")
		local reaction
		if name then
			--Order of checking hostile and friendly switched (DJE 8/16/05)
			if UnitIsEnemy("player","target") then
				reaction = "hostile"
			elseif UnitIsFriend("player","target") then
				reaction = "friendly"
			else
				reaction = "neutral"
			end
			FB_RaiseEvent("GainTarget", reaction)
--			FBTimers["targettarget"]:Start()
		else
			FB_RaiseEvent("LostTarget", reaction)
--			FBTimers["targettarget"]:Pause()
		end
	end

FBEventHandlers["UNIT_PET"] = 
	function(event)
	-- raise events for party/raid members getting pets
		if FBToggles["raidsafe"] and not nonraidunits[arg1] then return end
		if not FBProfileLoaded then return end
		if arg1 == "target" or arg1 == "mouseover" or arg1 == "npc" or arg1 == "NPC" then return end
		if FBEventToggles["petcheck"] == "off" then return end
		if not strfind(arg1,"pet") then -- this event fires 3 times on a pet summon, 2 times with pet and once with player
			local _,_,base,num = string.find(arg1,"(%a+)(%d+)")
			local pet
			if arg1 == "player" then 
				pet = "pet" 
			else
				pet = base .. "pet" .. num
			end
			-- raise the event after a small delay to let UnitCreatureFamily return right info
			FBTimers["petcheck"..GetTime()] = 
				Timer_Class:New(.5,false,nil,nil,function() FB_CheckPets(pet) end)
		end
	end

FBEventHandlers["UNIT_FLAGS"] = 
	function(event)
	-- change pet buttons
		if arg1 ~= "pet" then return end
		FB_MimicPetButtons()
	end

FBEventHandlers["PET_BAR_UPDATE"] = 
	function(event)
	-- change pet buttons
		FB_MimicPetButtons()
	end

FBEventHandlers["PET_BAR_UPDATE_COOLDOWN"] = 
	function(event)
	-- change pet buttons
		FB_MimicPetButtons()
	end

FBEventHandlers["PARTY_MEMBERS_CHANGED"] = 
	function(event)
	-- Check for different party members
		if not FBProfileLoaded then return end
		if FBEventToggles["groupcheck"] == "off" then return end
		local index, value, list
		list = FBEventToggleInfo["groupcheck"][FBEventToggles["groupcheck"] .."list"]
		if not list then return end
		for index, value in pairs(list) do
			local name = UnitName(index)
			if name and not FBGroupmates[index] then
				FB_RaiseEvent("GainPartymate", index)
			end
			if not name and FBGroupmates[index] then
				FB_RaiseEvent("LosePartyMate", index)
			end
			
			FBGroupmates[index] = name
		end
	end

FBEventHandlers["PLAYER_AURAS_CHANGED"] = 
	function(event)
	-- check new aura
		local form = "none"
		if FBLastform then
			local index
			for index = 1, GetNumShapeshiftForms() do
				local _, name, active = GetShapeshiftFormInfo(index)
				if active then
					form = name
					break
				end
			end
		end
		if FBLastform ~= form then
			if FBLastform ~= "none" then
				FB_RaiseEvent("LoseAura", FBLastform)
			end
			if form ~= "none" then
				FB_RaiseEvent("GainAura", form)
				FBBuffs["auras"]["'"..form.."'"] = true
			end
		end
		FBLastform = form
		-- Shirtan doing tracking events.....
		if not (GetTrackingTexture() == nil) then 
			tracking = GetTrackingTexture()
			if not (tracking == FBLastTracking) then
				FBLastTracking=tracking
				for k,v in pairs (FBTrackingList) do
					if ( tracking == v) then
						FB_RaiseEvent("trackingchanged", k)
						break
					end
				end
			end
		else
			if not (tracking == FBLastTracking) then
				FBLastTracking=tracking
				FB_RaiseEvent("trackingchanged", "none")
			end	
		end		
		-- /Tracking events.	
	end
	
FBEventHandlers["some event"] = 
	function(event)
	-- my tester for new events to see what I have to work with.
		util:Print(event)
		util:Print(arg1)
		util:Print(arg2)
		util:Print(arg3)
		util:Print(arg4)
		util:Print(arg5)
	end

