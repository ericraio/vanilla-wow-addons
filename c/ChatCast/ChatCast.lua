-- ChatCast 1.41
CHATCAST_VERSION = 1.41
ChatCast = {{}}
ChatCast_SpellLibrary = {{{{}}}}

ChatCast_AddMessage1_Original = nil
ChatCast_AddMessage2_Original = nil
ChatCast_AddMessage3_Original = nil
ChatCast_AddMessage4_Original = nil
ChatCast_AddMessage5_Original = nil
ChatCast_AddMessage6_Original = nil
ChatCast_AddMessage7_Original = nil
ChatCast_SetItemRef_Original = nil

if CCClass == "PRIEST" then
	ChatCast_SpellLibrary = {
		PRIEST = {
		{
			spell = CCLocale.PRIEST.Prayer_of_Fortitude,
			trigger = CCLocale.PRIEST.Prayer_of_Fortitude_trigger,
			level = 48,
			rank = { 48, 60 }
		},
		{
			spell = CCLocale.PRIEST.Power_Word_Fortitude,
			trigger = CCLocale.PRIEST.Power_Word_Fortitude_trigger,
			level = 1,
			rank = { 1, 12, 24, 36, 48, 60 }
		},
		{
			spell = CCLocale.PRIEST.Shadow_Protection,
			trigger = CCLocale.PRIEST.Shadow_Protection_trigger,
			level = 30,
			rank = { 30, 42, 56 }
		},
		{
			spell = CCLocale.PRIEST.Power_Word_Shield,
			trigger = CCLocale.PRIEST.Power_Word_Shield_trigger,
			level = 6,
			rank = { 6, 12, 18, 24, 30, 36, 42, 48, 54, 60 }
		},
		{
			spell = CCLocale.PRIEST.Dispel_Magic,
			trigger = CCLocale.PRIEST.Dispel_Magic_trigger,
			gains = CCLocale.PRIEST.Dispel_Magic_gains,
			afflicted = CCLocale.PRIEST.Dispel_Magic_afflicted,
			level = 18
		},
		{
			spell = CCLocale.PRIEST.Abolish_Disease,
			trigger = CCLocale.PRIEST.Abolish_Disease_trigger,
			afflicted = CCLocale.PRIEST.Abolish_Disease_afflicted,
			level = 24
		},
		{
			spell = CCLocale.PRIEST.Resurrection,
			trigger = CCLocale.PRIEST.Resurrection_trigger,
			level = 10,
		},
		{
			spell = CCLocale.PRIEST.Heal,
			trigger = CCLocale.PRIEST.Heal_trigger,
			level = 20
		}
		}
	}
	if CCRace == "Dwarf" then
		table.insert(ChatCast_SpellLibrary["PRIEST"],
		{
			spell = CCLocale.PRIEST.Fear_Ward,
			trigger = CCLocale.PRIEST.Fear_Ward_trigger,
			level = 20,
		})
	end
	local _, _, _, _, currentRank = GetTalentInfo(1, 13)
	if currentRank == 1 then
		table.insert(ChatCast_SpellLibrary["PRIEST"],
		{
			spell = CCLocale.PRIEST.Prayer_of_Spirit,
			trigger = CCLocale.PRIEST.Prayer_of_Spirit_trigger,
			level = 60,
		})
		table.insert(ChatCast_SpellLibrary["PRIEST"],
		{
			spell = CCLocale.PRIEST.Divine_Spirit,
			trigger = CCLocale.PRIEST.Divine_Spirit_trigger,
			level = 40,
			rank = { 40, 42, 54 }
		})
	end
	local _, _, _, _, currentRank = GetTalentInfo(3, 12)
	if currentRank == 1 then
		table.insert(ChatCast_SpellLibrary["PRIEST"],
		{
			spell = CCLocale.PRIEST.Silence,
			casting = CCLocale.PRIEST.Silence_casting,
			level = 30,
		})
	end

elseif CCClass == "MAGE" then
	ChatCast_SpellLibrary = {
		MAGE = {
		{
			spell = CCLocale.MAGE.Arcane_Brilliance,
			trigger = CCLocale.MAGE.Arcane_Brilliance_trigger,
			level = 56,
			rank = { 56 }
		},
		{
			spell = CCLocale.MAGE.Arcane_Intellect,
			trigger = CCLocale.MAGE.Arcane_Intellect_trigger,
			level = 1,
			rank = { 1, 14, 28, 42, 56 }
		},
		{
			spell = CCLocale.MAGE.Dampen_Magic,
			trigger = CCLocale.MAGE.Dampen_Magic_trigger,
			level = 12,
			rank = { 12, 24, 36, 48, 60 }
		},
		{
			spell = CCLocale.MAGE.Amplify_Magic,
			trigger = CCLocale.MAGE.Amplify_Magic_trigger,
			level = 18,
			rank = { 18, 30, 42, 54 }
		},
		{
			spell = CCLocale.MAGE.Remove_Lesser_Curse,
			trigger = CCLocale.MAGE.Remove_Lesser_Curse_trigger,
			afflicted = CCLocale.MAGE.Remove_Lesser_Curse_afflicted,
			level = 16
		},
		{
			macro = CCLocale.MAGE.Conjure_Water,
			trigger = CCLocale.MAGE.Conjure_Water_trigger,
			level = 4,
			rank = { 4, 10, 20, 30, 40, 50, 60 },
			rankitem = CCLocale.MAGE.Conjure_Water_rankitem,
			spellname = CCLocale.MAGE.Conjure_Water_spellname
		},
		{
			macro = CCLocale.MAGE.Conjure_Food,
			trigger = CCLocale.MAGE.Conjure_Food_trigger,
			level = 6,
			rank = { 6, 12, 22, 32, 42, 52 },
			rankitem = CCLocale.MAGE.Conjure_Food_rankitem,
			spellname = CCLocale.MAGE.Conjure_Food_spellname
		},
		{
			spell = CCLocale.MAGE.Counterspell,
			casting = CCLocale.MAGE.Counterspell_casting,
			level = 24
		}
		}
	}
elseif CCClass == "DRUID" then
	ChatCast_SpellLibrary = {
		DRUID = {
		{
			spell = CCLocale.DRUID.Gift_of_the_Wild,
			trigger = CCLocale.DRUID.Gift_of_the_Wild_trigger,
			level = 50,
			rank = { 50, 60 }
		},
		{
			spell = CCLocale.DRUID.Mark_of_the_Wild,
			trigger = CCLocale.DRUID.Mark_of_the_Wild_trigger,
			level = 1,
			rank = { 1, 10, 20, 30, 40, 50, 60 }
		},
		{
			spell = CCLocale.DRUID.Thorns,
			trigger = CCLocale.DRUID.Thorns_trigger,
			level = 6,
			rank = { 6, 14, 24, 34, 44, 54 }
		},
		{
			spell = CCLocale.DRUID.Remove_Curse,
			trigger = CCLocale.DRUID.Remove_Curse_trigger,
			afflicted = CCLocale.DRUID.Remove_Curse_afflicted,
			level = 24
		},
		{
			spell = CCLocale.DRUID.Abolish_Poison,
			trigger = CCLocale.DRUID.Abolish_Poison_trigger,
			afflicted = CCLocale.DRUID.Abolish_Poison_afflicted,
			level = 26
		},
		{
			spell = CCLocale.DRUID.Rebirth,
			trigger = CCLocale.DRUID.Rebirth_trigger,
			level = 20,
		},
		{
			spell = CCLocale.DRUID.Heal,
			trigger = CCLocale.DRUID.Heal_trigger,
			level = 12
		},
		{
			spell = CCLocale.DRUID.Hibernate,
			gains = CCLocale.DRUID.Hibernate_gains,
			level = 18,
			rank = { 18, 38, 58 }
		}
		}
	}

	local _, _, _, _, currentRank = GetTalentInfo(3, 15)
	if  currentRank == 1 then
		table.insert(ChatCast_SpellLibrary["DRUID"],
		{
			spell = CCLocale.DRUID.Innervate,
			trigger = CCLocale.DRUID.Innervate_trigger,
			level = 40
		})
	end

elseif CCClass == "PALADIN" then
	ChatCast_SpellLibrary = {
		PALADIN = {
		{
			spell = CCLocale.PALADIN.Blessing_of_Might,
			trigger = CCLocale.PALADIN.Blessing_of_Might_trigger,
			level = 4,
			rank = { 4, 12, 22, 32, 42, 52 }
		},
		{
			spell = CCLocale.PALADIN.Blessing_of_Wisdom,
			trigger = CCLocale.PALADIN.Blessing_of_Wisdom_trigger,
			level = 14,
			rank = { 14, 24, 34, 44, 54 }
		},
		{
			spell = CCLocale.PALADIN.Blessing_of_Freedom,
			trigger = CCLocale.PALADIN.Blessing_of_Freedom_trigger,
			afflicted = CCLocale.PALADIN.Blessing_of_Freedom_afflicted,
			level = 18
		},
		{
			spell = CCLocale.PALADIN.Blessing_of_Light,
			trigger = CCLocale.PALADIN.Blessing_of_Light_trigger,
			level = 40,
			rank = { 40, 50, 60 }
		},
		{
			spell = CCLocale.PALADIN.Blessing_of_Sacrifice,
			trigger = CCLocale.PALADIN.Blessing_of_Sacrifice_trigger,
			level = 46,
			rank = { 46, 54 }
		},
		{
			spell = CCLocale.PALADIN.Blessing_of_Salvation,
			trigger = CCLocale.PALADIN.Blessing_of_Salvation_trigger,
			level = 26
		},
		{
			spell = CCLocale.PALADIN.Cleanse,
			trigger = CCLocale.PALADIN.Cleanse_trigger,
			afflicted = CCLocale.PALADIN.Cleanse_afflicted,
			level = 32
		},
		{
			spell = CCLocale.PALADIN.Purify,
			trigger = CCLocale.PALADIN.Purify_trigger,
			afflicted = CCLocale.PALADIN.Purify_afflicted,
			level = 18
		},
		{
			spell = CCLocale.PALADIN.Redemption,
			trigger = CCLocale.PALADIN.Redemption_trigger,
			level = 12,
		},
		{
			spell = CCLocale.PALADIN.Heal,
			trigger = CCLocale.PALADIN.Heal_trigger,
			level = 20
		},
		{
			spell = CCLocale.PALADIN.Greater_Blessing_of_Might,
			trigger = CCLocale.PALADIN.Greater_Blessing_of_Might_trigger,
			level = 52,
		},
		{
			spell = CCLocale.PALADIN.Greater_Blessing_of_Wisdom,
			trigger = CCLocale.PALADIN.Greater_Blessing_of_Wisdom_trigger,
			level = 54,
		},
		{
			spell = CCLocale.PALADIN.Greater_Blessing_of_Light,
			trigger = CCLocale.PALADIN.Greater_Blessing_of_Light_trigger,
			level = 60,
		},
		{
			spell = CCLocale.PALADIN.Greater_Blessing_of_Salvation,
			trigger = CCLocale.PALADIN.Greater_Blessing_of_Salvation_trigger,
			level = 60,
		},
		}
	}
	local _, _, _, _, currentRank = GetTalentInfo(2,6)
	if  currentRank == 1 then
		table.insert(ChatCast_SpellLibrary["PALADIN"],
		{
			spell = CCLocale.PALADIN.Blessing_of_Kings,
			trigger = CCLocale.PALADIN.Blessing_of_Kings_trigger,
			level = 40
		})
		table.insert(ChatCast_SpellLibrary["PALADIN"],
		{
			spell = CCLocale.PALADIN.Greater_Blessing_of_Kings,
			trigger = CCLocale.PALADIN.Greater_Blessing_of_Kings_trigger,
			level = 60,
		})
	end
	local _, _, _, _, currentRank = GetTalentInfo(2,12)
	if  currentRank == 1 then
		table.insert(ChatCast_SpellLibrary["PALADIN"],
		{
			spell = CCLocale.PALADIN.Blessing_of_Sanctuary,
			trigger = CCLocale.PALADIN.Blessing_of_Sanctuary_trigger,
			level = 20,
			rank = { 20, 30, 40, 50, 60 }
		})
		table.insert(ChatCast_SpellLibrary["PALADIN"],
		{
			spell = CCLocale.PALADIN.Greater_Blessing_of_Sanctuary,
			trigger = CCLocale.PALADIN.Greater_Blessing_of_Sanctuary_trigger,
			level = 60,
		})
	end
elseif CCClass == "SHAMAN" then
	ChatCast_SpellLibrary = {
		SHAMAN = {
		{
			spell = CCLocale.SHAMAN.Cure_Poison,
			trigger = CCLocale.SHAMAN.Cure_Poison_trigger,
			afflicted = CCLocale.SHAMAN.Cure_Poison_afflicted,
			level = 16
		},
		{
			spell = CCLocale.SHAMAN.Cure_Disease,
			trigger = CCLocale.SHAMAN.Cure_Disease_trigger,
			afflicted = CCLocale.SHAMAN.Cure_Disease_afflicted,
			level = 22
		},
		{
			spell = CCLocale.SHAMAN.Water_Breathing,
			trigger = CCLocale.SHAMAN.Water_Breathing_trigger,
			level = 22
		},
		{
			spell = CCLocale.SHAMAN.Ancestral_Spirit,
			trigger = CCLocale.SHAMAN.Ancestral_Spirit_trigger,
			level = 12,
		},
		{
			spell = CCLocale.SHAMAN.Heal,
			trigger = CCLocale.SHAMAN.Heal_trigger,
			level = 20
		},
		{
			spell = CCLocale.SHAMAN.Water_Walking,
			trigger = CCLocale.SHAMAN.Water_Walking_trigger,
			level = 28
		},
		{
			spell = CCLocale.SHAMAN.Purge,
			gains = CCLocale.SHAMAN.Purge_gains,
			level =  12
		},
		{
			spell = CCLocale.SHAMAN.Earth_Shock,
			casting = CCLocale.SHAMAN.Earth_Shock_casting,
			level = 4
		}
		}
	}
	local _, _, _, _, currentRank = GetTalentInfo(3, 14)
	if  currentRank == 1 then
		table.insert(ChatCast_SpellLibrary["SHAMAN"],
		{
			spell = CCLocale.SHAMAN.Mana_Tide,
			trigger = CCLocale.SHAMAN.Mana_Tide.trigger,
			level = 40,
			rank = { 40, 48, 58 }
		})
	end

elseif CCClass == "WARLOCK" then
	ChatCast_SpellLibrary = {
		WARLOCK = {
		{
			spell = CCLocale.WARLOCK.Unending_Breath,
			trigger = CCLocale.WARLOCK.Unending_Breath_trigger,
			level = 16
		},
		{
			spell = CCLocale.WARLOCK.Detect_Greater_Invisibility,
			trigger = CCLocale.WARLOCK.Detect_Greater_Invisibility_trigger,
			level = 50
		},
		{
			spell = CCLocale.WARLOCK.Ritual_of_Summoning,
			trigger = CCLocale.WARLOCK.Ritual_of_Summoning_trigger,
			level = 20,
			leavetargeted = true
		},
		{
			macro = CCLocale.WARLOCK.Healthstone,
			trigger = CCLocale.WARLOCK.Healthstone_trigger,
			rank = { 10, 22, 34, 46, 58 },
			rankitem = CCLocale.WARLOCK.Healthstone_rankitem,
			spellname = CCLocale.WARLOCK.Healthstone_spellname
		},
		{
			macro = CCLocale.WARLOCK.Soulstone,
			trigger = CCLocale.WARLOCK.Soulstone_trigger,
			rank = { 18, 30, 40, 50, 60 },
			rankitem = CCLocale.WARLOCK.Soulstone_rankitem,
			spellname = CCLocale.WARLOCK.Soulstone_spellname
		}
		}
	}
end
	table.insert(ChatCast_SpellLibrary, "GENERAL")
	ChatCast_SpellLibrary["GENERAL"] = {
		--invite entries have to be the first 5 entries for toggle invites to work
		{
			macro = CCLocale.GENERAL.AskInvite,
			trigger = CCLocale.GENERAL.AskInvite_trigger
		},
		{
			macro = CCLocale.GENERAL.Invite_Target,
			trigger = CCLocale.GENERAL.Invite_Target_trigger
		},
		{
			macro = CCLocale.GENERAL.Invite,
			trigger = CCLocale.GENERAL.Invite_trigger
		},
		{
			macro = CCLocale.GENERAL.PST,
			trigger = CCLocale.GENERAL.PST_trigger
		},
		{
			macro = CCLocale.GENERAL.LFM,
			macro_alt = CCLocale.GENERAL.LFM_alt,
			trigger = CCLocale.GENERAL.LFM_trigger
		},
		{
			macro = CCLocale.GENERAL.ChatCast,
			trigger = CCLocale.GENERAL.ChatCast_trigger
		}
		}


function ChatCast_OnEvent()
	if (event == "VARIABLES_LOADED") then
		ChatCast_Startup();
	elseif (event == "UI_ERROR_MESSAGE" or event == "SPELLCAST_INTERRUPT") then
		ChatCast_SpellError();
	elseif (event == 	"PLAYER_ENTER_COMBAT") then
		CC_WasAttacking = true
	elseif (event == "PLAYER_LEAVE_COMBAT") then
		CC_WasAttacking = nil
		if CC_AttackTimer and CC_AttackTimer > 0 then ChatCastFrame:Show()	end
	end

	if (ChatCast.Trading) or ChatCastFrame:IsShown() then
		ChatCast_Trade_OnEvent()
	end
end

function ChatCast_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UI_ERROR_MESSAGE");
	this:RegisterEvent("PLAYER_ENTER_COMBAT");
	this:RegisterEvent("PLAYER_LEAVE_COMBAT");
	if (CCClass == "WARLOCK" or CCClass == "MAGE") then ChatCast_Trade_OnLoad() end
end

function ChatCast_AddMessage1(t, s, ...)
	s = ChatCast_Decompose (s)
	ChatCast_AddMessage1_Original (t, s, unpack (arg))
end

function ChatCast_AddMessage2(t, s, ...)
	s = ChatCast_Decompose (s)
	ChatCast_AddMessage2_Original (t, s, unpack (arg))
end

function ChatCast_AddMessage3(t, s, ...)
	s = ChatCast_Decompose (s)
	ChatCast_AddMessage3_Original (t, s, unpack (arg))
end

function ChatCast_AddMessage4(t, s, ...)
	s = ChatCast_Decompose (s)
	ChatCast_AddMessage4_Original (t, s, unpack (arg))
end

function ChatCast_AddMessage5(t, s, ...)
	s = ChatCast_Decompose (s)
	ChatCast_AddMessage5_Original (t, s, unpack (arg))
end

function ChatCast_AddMessage6(t, s, ...)
	s = ChatCast_Decompose (s)
	ChatCast_AddMessage6_Original (t, s, unpack (arg))
end

function ChatCast_AddMessage7(t, s, ...)
	s = ChatCast_Decompose (s)
	ChatCast_AddMessage7_Original (t, s, unpack (arg))
end

function ChatCast_FC_IncomingMessage(Name, Text)
	Text = ChatCast_BuffSub(Text,Name)
	ChatCast_FC_IncomingMessage_Original(Name, Text)
end

function ChatCast_HM_Output_Multiwindow(OriginatingUnit, TargetUnit, SpecialAttack, VerboseMessage, Option, Message, Crit, ChatMessage, ChatEvent)
	if SpecialAttack then SpecialAttack = ChatCast_HM_Process(OriginatingUnit, SpecialAttack, VerboseMessage, ChatEvent) end
	ChatCast_HM_Output_Multiwindow_Original(OriginatingUnit, TargetUnit, SpecialAttack, VerboseMessage, Option, Message, Crit, ChatMessage, ChatEvent)
end

function ChatCast_Startup()
	if DEFAULT_CHAT_FRAME.AddMessage ~= ChatCast_AddMessage1 then
		ChatCast_AddMessage1_Original = DEFAULT_CHAT_FRAME.AddMessage
		DEFAULT_CHAT_FRAME.AddMessage = ChatCast_AddMessage1
	end
	if ChatFrame2 and ChatFrame2.AddMessage ~= ChatCast_AddMessage2 then
		ChatCast_AddMessage2_Original = ChatFrame2.AddMessage
		ChatFrame2.AddMessage = ChatCast_AddMessage2
	end
	if ChatFrame3 and ChatFrame3.AddMessage ~= ChatCast_AddMessage3 then
		ChatCast_AddMessage3_Original = ChatFrame3.AddMessage
		ChatFrame3.AddMessage = ChatCast_AddMessage3
	end
	if ChatFrame4 and ChatFrame4.AddMessage ~= ChatCast_AddMessage4 then
		ChatCast_AddMessage4_Original = ChatFrame4.AddMessage
		ChatFrame4.AddMessage = ChatCast_AddMessage4
	end
	if ChatFrame5 and ChatFrame5.AddMessage ~= ChatCast_AddMessage5 then
		ChatCast_AddMessage5_Original = ChatFrame5.AddMessage
		ChatFrame5.AddMessage = ChatCast_AddMessage5
	end
	if ChatFrame6 and ChatFrame6.AddMessage ~= ChatCast_AddMessage6 then
		ChatCast_AddMessage6_Original = ChatFrame6.AddMessage
		ChatFrame6.AddMessage = ChatCast_AddMessage6
	end
	if ChatFrame7 and ChatFrame7.AddMessage ~= ChatCast_AddMessage7 then
		ChatCast_AddMessage7_Original = ChatFrame7.AddMessage
		ChatFrame7.AddMessage = ChatCast_AddMessage7
	end
	if FC_IncomingMessage and FC_IncomingMessage ~= ChatCast_FC_IncomingMessage then
		ChatCast_FC_IncomingMessage_Original = FC_IncomingMessage
		FC_IncomingMessage = ChatCast_FC_IncomingMessage
	end
	if HM_Output_Multiwindow and HM_Output_Multiwindow ~= ChatCast_HM_Output_Multiwindow then
		ChatCast_HM_Output_Multiwindow_Original = HM_Output_Multiwindow
		HM_Output_Multiwindow = ChatCast_HM_Output_Multiwindow
	end

	ChatCast_SetItemRef_Original = SetItemRef
	SetItemRef = ChatCast_SetItemRef

	SlashCmdList["CHATCASTOPTIONS"] = ChatCast_Options;
	SLASH_CHATCASTOPTIONS1 = "/cc";
	SLASH_CHATCASTOPTIONS2 = "/chatcast";

	if ChatCast.Brackets == nil then
		ChatCast.Brackets = false
	end
	if ChatCast.Color == nil or ChatCast.Color.rgb == nil then
		ChatCast.Color = { rgb = "FFEE20" }
	end
	if ChatCast.Invites == nil then
		ChatCast.Invites = true		
	end
	if ChatCast.Feedback == nil then
		ChatCast.Feedback = false
	end
	if ChatCast.Sound == nil then
		ChatCast.Sound = true
	end
	if ChatCast.LFM == nil then
		ChatCast.LFM = CCLocale.UI.text.LFM_default
	end
	if ChatCast.LFMAlt == nil then
		ChatCast.LFMAlt = false
	end
	if ChatCast.LastLink == nil then
		ChatCast.LastLink = true
	end
	if ChatCast.HitsMode == nil then
		ChatCast.HitsMode = true
	end

	DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.loaded, ChatCast_CreateLink(6,"ChatCast","ChatCast","GENERAL") .. " " .. CHATCAST_VERSION))
end

function ChatCast_Decompose (chatstring)
	if chatstring ~= nil then
		local _, premsg, name, postname, msg
		if not (string.find(chatstring, CCLocale.UI.text.trade_channel) or string.find(chatstring, CCLocale.UI.text.tell_prefix)) then
			if string.find(chatstring, "player:%a+") then
				_, _, premsg, name, postname, msg = string.find(chatstring, "(.*player:)(%a+)(.- )(.+)")
			elseif string.find(chatstring, CCLocale.emote_heal) or string.find(chatstring, CCLocale.emote_mana) then
				_, _, name = string.find(chatstring, "^(%a+)")
			end
			if name then
				if premsg then
					chatstring = premsg..name..postname..ChatCast_BuffSub(msg, name)
				else
					chatstring = ChatCast_BuffSub(chatstring, name)
				end
			end
		end
	end
	return chatstring
end

function ChatCast_BuffSub(msg, name, mode)
	local posA,posB,ccvar,trigger_set, trim
	if not mode then mode = "CHAT" end
	if string.sub(msg, 1, 1) ~= " " then msg = " "..msg; trim = 1 end
	if name and (CCtest == nil and name ~= UnitName("player") or CCtest == 1)then
		local lower_msg = string.lower(msg)
		for _, section in { "GENERAL", ChatCast_SpellLibrary[CCClass] and CCClass } do
			for i, entry in ChatCast_SpellLibrary[section] do

--				if mode ~= "CHAT" and section == "GENERAL" then break end
				if mode == "CHAT" and entry.trigger then trigger_set = entry.trigger
				elseif mode == "FADES" and entry.spell then trigger_set = { string.lower(entry.spell) }
				elseif mode == "GAINS" and entry.gains then trigger_set = entry.gains
				elseif mode == "AFFLICTED" and entry.afflicted then trigger_set = entry.afflicted
				elseif mode == "CASTING" and entry.casting then trigger_set = entry.casting
				else trigger_set = { "" } end
				for j, trigger in trigger_set do
					if trigger_set[1] == "" then break end
					if (ChatCast.Invites == false and section == "GENERAL" and i < 6) then break
					elseif (entry.level and UnitLevel("player") < entry.level) then break else
						trigger = string.gsub(trigger, "%$w", "(%%a+)")
						--Scan for triggers in the middle of a line
						--Check the end of line for trigger
						posA,posB,ccvar = string.find(lower_msg, "[%s%p]"..trigger.."%s*$")
						if posA ~= nil then
							local _,linkopen = string.gsub(msg, "|H", "|H")
							local _,linkclose = string.gsub(msg, "|h", "|h")
							if linkopen * 2 == linkclose and not string.find(string.sub(msg,posA+1),"|H") then
								if not ccvar then
									msg = string.sub(msg, 1, posA) .. ChatCast_CreateLink(i,string.sub(msg,posA+1),name,section,mode)
									lower_msg = string.lower(msg)
								elseif string.len(ccvar) > 3 and not string.find(CCLocale.DoNotAllow, ccvar..",") then
									msg = string.sub(msg, 1, posA) .. ChatCast_CreateLink(i,string.sub(msg,posA+1),name .."#"..string.gsub(ccvar, "^%a", string.upper),section,mode)
									lower_msg = string.lower(msg)
								end
							end
						end
						for posB = 1, 255, 1 do
							posA,posB,ccvar = string.find(lower_msg, "[^%a%d%[|\"']"..trigger.."[^%a%d%]|]", posB)
							if posA ~= nil then
								local _,linkopen = string.gsub(string.sub(msg,1,posA+1), "|H", "|H")
								local _,linkclose = string.gsub(string.sub(msg,1,posA+1), "|h", "|h")
								if linkopen * 2 == linkclose and not string.find(string.sub(msg,posA+1,posB-1), "|H") then
									if not ccvar then
										local templink = ChatCast_CreateLink(i,string.sub(msg,posA+1,posB-1),name,section,mode)
										msg = string.sub(msg, 1, posA) .. templink .. string.sub(msg,posB)
										lower_msg = string.lower(msg)
										posB = posB + string.len(templink) - string.len(trigger) - 1
									elseif string.len(ccvar) > 3 and not string.find(CCLocale.DoNotAllow, ccvar..",") then
										local templink = ChatCast_CreateLink(i,string.sub(msg,posA+1,posB-1),name .."#"..string.gsub(ccvar, "^%a", string.upper),section,mode)
										msg = string.sub(msg, 1, posA) .. templink .. string.sub(msg,posB)
										lower_msg = string.lower(msg)
										posB = posB + string.len(templink) - string.len(trigger..ccvar) - 1
									else
										posB = posB + string.len(trigger) - 1
									end
								else
									posB = posB + string.len(trigger) - 1
								end
							else break
							end
						end
					end
				end
			end
		end
	end
	if trim then msg = string.sub(msg, 2) end
	return msg
end

function ChatCast_CreateLink(buff,link,name,section,mode)
	if not mode then mode = "CHAT" end
	section = (section == "GENERAL" and "macro" or "buff")
	link = (mode == "CHAT" and "|CFF" .. ChatCast.Color.rgb or "" ) .. "|H" .. section .. buff .. ":" .. name .. "|h" .. (ChatCast.Brackets and "[" .. link .. "]|h|r" or link .. "|h|r")
	if (section == "buff") or (section == "macro" and buff ~= 1 and buff ~= 4 and buff ~= 5) then
		lastlink = section .. buff..":"..name
	end
	if section == "buff" and mode == "CHAT" then
		lastbuff = lastlink
	end
	return link
end

function ChatCast_FindUnit(realname)
	realname = string.lower(realname)
	if realname == "you" or realname == string.lower(UnitName("player")) then
		return "player"
	end
	for i, trialUnit in { "party1", "party2", "party3", "party4" } do
		if ( UnitName(trialUnit) and realname == string.lower(UnitName(trialUnit))) then
			return trialUnit
		end
	end
	for i=1,40,1 do
		local trialUnit = "raid"..i;
		if ( UnitName(trialUnit) and realname == string.lower(UnitName(trialUnit))) then
			return trialUnit
		end
	end
	return false
end

function ChatCast_Target(realname)
	if not realname then return false
	else
		realname = string.lower(realname)
		if UnitExists("target") and realname == string.lower(UnitName("target")) then return true end
	end
	local targetid = ChatCast_FindUnit(realname)
	if targetid then
		TargetUnit(targetid)
		return true
	end
	TargetByName(realname);
	if ( UnitName("target") and realname == string.lower(UnitName("target"))) then
		return true
	end
	return false
end

function ChatCast_SpellError()
	CCSpellError = arg1
end

function ChatCast_FindSpell(target_spell,target_rank)
	local i, spell_name, spell_rank, tempid = 1
	target_rank = string.format(CCLocale.UI.rank, target_rank)
	while true do
		spell_name, spell_rank = GetSpellName(i, 1)
		if not spell_name then
			break
		elseif spell_name == target_spell then
			if "("..spell_rank..")" == target_rank then
				return i, spell_rank
			else
				tempid = i
				temprank = spell_rank
			end
		end
		i = i + 1
	end
	return tempid, temprank
end

function ChatCast_Cast(buffnumber, realname, targetname)
	local oldtarget, targetisenemy, target_rank, spell_name, spell_rank, unitID
	if targetname then realname = targetname end
	if (ChatCast_SpellLibrary[CCClass][buffnumber].gains and UnitCanAttack("player", "target")) or (UnitIsFriend("player", "target") and string.lower(UnitName("target")) ~= string.lower(realname)) then
	else
		unitID = ChatCast_FindUnit(realname)
	end
	oldtarget = UnitName("target")
	if (unitID or ChatCast_Target(realname)) then
		CCSpellError = nil
		if (ChatCast_SpellLibrary[CCClass][buffnumber].rank) and UnitLevel("player") - 10 > UnitLevel(unitID or "target") then
			for x=1, table.getn(ChatCast_SpellLibrary[CCClass][buffnumber].rank), 1 do
				if (UnitLevel(unitID or "target") >= (ChatCast_SpellLibrary[CCClass][buffnumber].rank[x]-10)) then
					target_rank = x;
				end
			end
			local tempid = ChatCast_FindSpell(ChatCast_SpellLibrary[CCClass][buffnumber].spell, target_rank)
			if tempid then
				CastSpell(tempid, 1)
				--CastSpellByName(ChatCast_SpellLibrary[CCClass][buffnumber].spell .. "("..temprank..")")
			elseif ChatCast.Feedback then DEFAULT_CHAT_FRAME:AddMessage(CCLocale.UI.fb_unknownspell) end
		else
			CastSpellByName(ChatCast_SpellLibrary[CCClass][buffnumber].spell);
		end
		if ChatCast.Feedback == true then
			if CCSpellError then
				DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.fb_castfail, ChatCast_SpellLibrary[CCClass][buffnumber].spell, realname, CCSpellError))
			else
				DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.fb_casting, ChatCast_SpellLibrary[CCClass][buffnumber].spell, realname))
			end
		end
	elseif ChatCast.Feedback then DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.fb_targetfail, realname))
	end;
	if SpellIsTargeting() then 
		if unitID then SpellTargetUnit(unitID) else SpellStopTargeting() end;
	end
	if not ChatCast_SpellLibrary[CCClass][buffnumber].leavetargeted and UnitName("target") ~= oldtarget then
		if oldtarget then	TargetLastTarget(); if CC_WasAttacking then CC_AttackTimer = 0.5 end
		else ClearTarget() end;
	end
end

function ChatCast_LastLink()
	if lastlink then
		if ChatCast.LastLink then
			ChatCast_SetItemRef(lastbuff)
		else
			ChatCast_SetItemRef(lastlink)
		end
	end
end

function ChatCast_SetItemRef(link, text, button)
	local entry = nil
	if ( strsub(link, 1, 4) == "buff" ) then
		entry = CCClass
	elseif (strsub(link,1,5) == "macro") then
		entry = "GENERAL"
	end
	if entry then
		local entrynumber, realname, targetname, macro
		if string.find(link,"#") then _,_,entrynumber,realname,targetname = string.find(link,"(%d+):([%a%s]+)#([%a%s]+)")
		else _,_,entrynumber,realname = string.find(link,"(%d+):([%a%s]+)");end
		entrynumber = tonumber(entrynumber)
		if(ChatCast.Sound) then PlaySound("igMainMenuOption");end
		if ChatCast_SpellLibrary[entry][entrynumber].spell then
			ChatCast_Cast(entrynumber,realname,targetname)
		elseif ChatCast_SpellLibrary[entry][entrynumber].macro then
			if (ChatCast_SpellLibrary[entry][entrynumber].macro_alt and ChatCast.LFMAlt) then
				macro = tostring(ChatCast_SpellLibrary[entry][entrynumber].macro_alt)
			else
				macro = tostring(ChatCast_SpellLibrary[entry][entrynumber].macro)
			end
			macro = gsub(macro, "$p", realname)
			if targetname then macro = gsub(macro, "$w", targetname) end
			RunScript(macro)
		end
		return;
	end
	ChatCast_SetItemRef_Original(link, text, button);
end
-- Color functions
function ChatCast_ColorPicker()
	if (ColorPickerFrame:IsShown()) then
		ChatCast_ColorPicker_Cancelled(ColorPickerFrame.previousValues)
		ColorPickerFrame:Hide()
	else
		ChatCast.Color.Changed = false
		local r,g,b = string.sub(ChatCast.Color.rgb,1,2), string.sub(ChatCast.Color.rgb,3,4), string.sub(ChatCast.Color.rgb,5,6)
		r = tonumber(r, 16)/255
		g = tonumber(g,16)/255
		b = tonumber(b,16)/255
		ColorPickerFrame.previousValues = {r, g, b};
		ColorPickerFrame.hasOpacity = false;
		ColorPickerFrame:SetColorRGB(r, g, b);
		ColorPickerFrame.cancelFunc = ChatCast_ColorPicker_Cancelled;
		ColorPickerFrame.func = ChatCast_ColorPicker_ColorChanged;
		ColorPickerFrame:Show();
	end
end

function ChatCast_ColorPicker_Cancelled(color)
	ChatCast_MakeColor(color[1],color[2],color[3])
end

function ChatCast_ColorPicker_ColorChanged()
	local r, g, b = ColorPickerFrame:GetColorRGB()
	if (not ColorPickerFrame:IsShown() and ChatCast.Color.Changed == true) then
		ChatCast.Color.Changed = nil
		ChatCast_MakeColor(r,g,b)
		DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.color_changed, ChatCast_CreateLink(6,"ChatCast","ChatCast","GENERAL"), "|CFF" .. ChatCast.Color.rgb .. "" .. ChatCast.Color.rgb))
	else ChatCast.Color.Changed = true
	end
end

function ChatCast_round(n)
	return (ceil(n) - n <= n - floor(n)) and ceil(n) or floor(n)
end

function ChatCast_MakeColor(r,g,b)
	r,g,b = ChatCast_round(r*255),ChatCast_round(g*255),ChatCast_round(b*255)
	r = string.format("%X",r)
	g = string.format("%X",g)
	b = string.format("%X",b)
	if string.len(r) == 1 then r = "0"..r;end
	if string.len(g) == 1 then g = "0"..g;end
	if string.len(b) == 1 then b = "0"..b;end
	ChatCast.Color.rgb = r..g..b
end

-- Options functions
function ChatCast_Options(arg1)
	if (arg1 == "" or arg1 == nil) then
		DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.options_list, ChatCast_CreateLink(6,"ChatCast","ChatCast","GENERAL") .. " " .. CHATCAST_VERSION))
		DEFAULT_CHAT_FRAME:AddMessage(CCLocale.UI.text.options_color)
		DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.options_brackets, (ChatCast.Brackets and CCLocale.UI.text.options_on or CCLocale.UI.text.options_off))) 
		DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.options_sound, (ChatCast.Sound and CCLocale.UI.text.options_on or CCLocale.UI.text.options_off)))
		DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.options_feedback, (ChatCast.Feedback and CCLocale.UI.text.options_on or CCLocale.UI.text.options_off)))
		DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.options_invites, (ChatCast.Invites and CCLocale.UI.text.options_on or CCLocale.UI.text.options_off)))
		DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.options_autosend, (ChatCast.LFMAlt and CCLocale.UI.text.options_off or CCLocale.UI.text.options_on)))
		DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.options_LFM, ChatCast.LFM))
		DEFAULT_CHAT_FRAME:AddMessage(CCLocale.UI.text.options_lastlink)
		DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.options_hitsmode, (ChatCast.HitsMode and CCLocale.UI.text.options_on or CCLocale.UI.text.options_off)))
	elseif string.find(string.lower(arg1),CCLocale.UI.text.slash_color) then
		ChatCast_ToggleColor(ChatCast_OpArg(arg1))
	elseif string.find(string.lower(arg1),CCLocale.UI.text.slash_brackets) then
		ChatCast_ToggleBrackets(ChatCast_OpArg(arg1))
	elseif string.find(string.lower(arg1),CCLocale.UI.text.slash_invites) then
		ChatCast_ToggleInvites(ChatCast_OpArg(arg1))
	elseif string.find(string.lower(arg1),CCLocale.UI.text.slash_feedback) then
		ChatCast_ToggleFeedback(ChatCast_OpArg(arg1))
	elseif string.find(string.lower(arg1),CCLocale.UI.text.slash_sound) then
		ChatCast_ToggleSound(ChatCast_OpArg(arg1))
	elseif string.find(string.lower(arg1),CCLocale.UI.text.slash_lfmtext) then
		ChatCast_SetLFM(ChatCast_OpArg(arg1))
	elseif string.find(string.lower(arg1),CCLocale.UI.text.slash_lfm) then
		ChatCast_ToggleLFM(ChatCast_OpArg(arg1))
	elseif string.find(string.lower(arg1),CCLocale.UI.text.slash_lastlink) then
		ChatCast_ToggleLastLink(ChatCast_OpArg(arg1))
	elseif string.find(string.lower(arg1),CCLocale.UI.text.slash_hitsmode) then
		ChatCast_ToggleHitsMode(ChatCast_OpArg(arg1))
	end
end

function ChatCast_OpArg(arg1)
	local posA,posB=string.find(arg1, "%s");
	if posB then return string.sub(arg1,posB+1);end
	return nil
end

function ChatCast_SetLFM(arg)
	if arg == nil or arg == "" then ChatCast.LFM = ""
	elseif arg == "reset" or arg == "default" then ChatCast.LFM = CCLocale.UI.text.LFM_default
	else ChatCast.LFM = arg
	end
	DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.LFM_set, ChatCast_CreateLink(6,"ChatCast","ChatCast","GENERAL"), ChatCast.LFM))
end

function ChatCast_ToggleLFM(arg)
	if arg == nil or arg == "" then arg = ChatCast.LFMAlt end
	if (type(arg) == "string" and string.lower(arg) == CCLocale.UI.text.slash_arg_on) or arg == false then
		ChatCast.LFMAlt = true
		DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.LFMalt_on, ChatCast_CreateLink(6,"ChatCast","ChatCast","GENERAL")))
	elseif (type(arg) == "string" and string.lower(arg) == CCLocale.UI.text.slash_arg_off) or arg == true then
		ChatCast.LFMAlt = false
		DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.LFMalt_off, ChatCast_CreateLink(6,"ChatCast","ChatCast","GENERAL")))
	end
end	

function ChatCast_ToggleInvites(arg)
	if arg == nil or arg == "" then arg = ChatCast.Invites end
	if (type(arg) == "string" and string.lower(arg) == CCLocale.UI.text.slash_arg_on) or arg == false then
		ChatCast.Invites = true
		DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.invites_on, ChatCast_CreateLink(6,"ChatCast","ChatCast","GENERAL")))
	elseif (type(arg) == "string" and string.lower(arg) == CCLocale.UI.text.slash_arg_off) or arg == true then
		ChatCast.Invites = false
		DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.invites_off, ChatCast_CreateLink(6,"ChatCast","ChatCast","GENERAL")))
	end
end

function ChatCast_ToggleHitsMode(arg)
	if arg == nil or arg == "" then arg = ChatCast.HitsMode end
	if (type(arg) == "string" and string.lower(arg) == CCLocale.UI.text.slash_arg_on) or arg == false then
		ChatCast.HitsMode = true
		DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.hitsmode_on, ChatCast_CreateLink(6,"ChatCast","ChatCast","GENERAL")))
	elseif (type(arg) == "string" and string.lower(arg) == CCLocale.UI.text.slash_arg_off) or arg == true then
		ChatCast.HitsMode = false
		DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.hitsmode_off, ChatCast_CreateLink(6,"ChatCast","ChatCast","GENERAL")))
	end
end

function ChatCast_ToggleLastLink(arg)
	if arg == nil or arg == "" then arg = ChatCast.LastLink end
	if (type(arg) == "string" and string.lower(arg) == CCLocale.UI.text.slash_arg_on) or arg == false then
		ChatCast.LastLink = true
		DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.lastlink_on, ChatCast_CreateLink(6,"ChatCast","ChatCast","GENERAL")))
	elseif (type(arg) == "string" and string.lower(arg) == CCLocale.UI.text.slash_arg_off) or arg == true then
		ChatCast.LastLink = false
		DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.lastlink_off, ChatCast_CreateLink(6,"ChatCast","ChatCast","GENERAL")))
	end
end

function ChatCast_ToggleFeedback(arg)
	if arg == nil or arg == "" then arg = ChatCast.Feedback end
	if (type(arg) == "string" and string.lower(arg) == CCLocale.UI.text.slash_arg_on) or arg == false then
		ChatCast.Feedback = true
		DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.feedback_on, ChatCast_CreateLink(6,"ChatCast","ChatCast","GENERAL")))
	elseif (type(arg) == "string" and string.lower(arg) == CCLocale.UI.text.slash_arg_off) or arg == true then
		ChatCast.Feedback = false
		DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.feedback_off, ChatCast_CreateLink(6,"ChatCast","ChatCast","GENERAL")))
	end
end

function ChatCast_ToggleSound(arg)
	if arg == nil or arg == "" then arg = ChatCast.Sound end
	if (type(arg) == "string" and string.lower(arg) == CCLocale.UI.text.slash_arg_on) or arg == false then
		ChatCast.Sound = true
		DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.sound_on, ChatCast_CreateLink(6,"ChatCast","ChatCast","GENERAL")))
	elseif (type(arg) == "string" and string.lower(arg) == CCLocale.UI.text.slash_arg_off) or arg == true then
		ChatCast.Sound = false
		DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.sound_off, ChatCast_CreateLink(6,"ChatCast","ChatCast","GENERAL")))
	end
end

function ChatCast_ToggleBrackets(arg)
	if arg == nil or arg == "" then arg = ChatCast.Brackets end
	if (type(arg) == "string" and string.lower(arg) == CCLocale.UI.text.slash_arg_on) or arg == false then
		ChatCast.Brackets = true
		DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.brackets_on, ChatCast_CreateLink(6,"ChatCast","ChatCast","GENERAL")))
	elseif (type(arg) == "string" and string.lower(arg) == CCLocale.UI.text.slash_arg_off) or arg == true then
		ChatCast.Brackets = false
		DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.brackets_off, ChatCast_CreateLink(6,"ChatCast","ChatCast","GENERAL")))
	end
end

function ChatCast_ToggleColor(arg)
	if (arg == nil or arg == "") then
		DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.color_current, ChatCast_CreateLink(6,"ChatCast","ChatCast","GENERAL"), "|CFF" .. ChatCast.Color.rgb .. "" .. ChatCast.Color.rgb))
		ChatCast_ColorPicker()
	elseif (string.lower(arg) == CCLocale.UI.text.slash_arg_reset or string.lower(arg) == CCLocale.UI.text.slash_arg_reset2) then
		ChatCast.Color = { rgb = "FFEE20" }
		DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.color_reset, ChatCast_CreateLink(6,"ChatCast","ChatCast","GENERAL"), "|CFF" .. ChatCast.Color.rgb .. "" .. ChatCast.Color.rgb))
	else
		if string.find(arg, "%x%x%x%x%x%x") then
			ChatCast.Color.rgb = arg
			DEFAULT_CHAT_FRAME:AddMessage(string.format(CCLocale.UI.text.color_changed, ChatCast_CreateLink(6,"ChatCast","ChatCast","GENERAL"), "|CFF" .. ChatCast.Color.rgb .. "" .. ChatCast.Color.rgb))
		end
	end
end

--HitsMode stuff
function ChatCast_HM_Process(realname, spell, VerboseMessage, event)
	if ChatCast.HitsMode == true then
		if (VerboseMessage == "FADES" and not string.find(event, "HOSTILE"))
		or VerboseMessage == "GAINS" or VerboseMessage == "AFFLICTED"
		or (VerboseMessage == "CASTING" and realname ~= "You") then
			spell = ChatCast_BuffSub(spell, realname, VerboseMessage)
		end
	end
	return spell
end