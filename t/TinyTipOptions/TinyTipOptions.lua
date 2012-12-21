--[[
-- Name: TinyTip
-- Author: Thrae of Maelstrom (aka "Matthew Carras")
-- Release Date: 6-25-06
--
-- These functions allow you to change options via a
-- Dewdrop GUI. Loaded on demand by TinyTip.
--
-- This part does NOT need to be localized, look in
-- TinyTipChatLocale_xxXX.lua.
--]]

local _G = getfenv(0)
local dewdrop = _G.AceLibrary:GetInstance("Dewdrop-2.0")
local ddframe
local db

local function ToggleDB(k)
	db[k] = not db[k]
end

local function SetDB(k,v)
	db[k] = v
end

local function SetDBNum(k,v)
	db[k] = tonumber(v)
end

local function SetAnchor(k,v)
	db[k] = v
	if db[k] then 
		_G.TinyTipAnchor_Hook() 
	end
end

local function ToggleExtras(k)
	db[k] = not db[k]
	_G.TinyTip_LoDRun("TinyTipExtras","TinyTipExtras_Init", db, _G.TinyTipEventFrame)
end

local function SetExtras(k,v)
	db[k] = v 
	_G.TinyTip_LoDRun("TinyTipExtras","TinyTipExtras_Init", db, _G.TinyTipEventFrame)
end

local function SetExtrasNum(k,v)
	db[k] = tonumber(v)
	_G.TinyTip_LoDRun("TinyTipExtras","TinyTipExtras_Init", db, _G.TinyTipEventFrame)
end


local function SetTargets(k,v,v2)
	if v and v2 then
		v = tonumber(v2)
	end
	db[k] = v
	if db[k] then 
		_G.TinyTip_LoDRun("TinyTipExtras","TinyTipTargetsExists")
	end
end

local function DDAddArrow(opt)
	dewdrop:AddLine( 'text', _G["TinyTipChatLocale_Opt_" .. opt],
									 'hasArrow', true,
									 'value', opt,
									 'tooltipTitle', "TinyTip",
									 'tooltipText', _G["TinyTipChatLocale_Desc_" .. opt]
								  )
end

local function DDAddChecked(opt, func)
	dewdrop:AddLine( 'text', _G["TinyTipChatLocale_Opt_" .. opt],
									 'checked', db[opt],
									 'func', func or ToggleDB,
									 'arg1', opt,
									 'tooltipTitle', "TinyTip",
									 'tooltipText', _G["TinyTipChatLocale_Desc_" .. opt]
								  )
end

local function DDAddEditBoxNum(opt, func, arg2)
	dewdrop:AddLine( 'text', _G["TinyTipChatLocale_Opt_" .. opt],
									 'hasArrow', true,
									 'hasEditBox', true,
									 'editBoxText', db[ opt ],
									 'editBoxFunc', func or SetDBNum,
									 'editBoxArg1', opt,
									 'editBoxArg2', arg2,
									 'tooltipTitle', "TinyTip",
									 'tooltipText', _G["TinyTipChatLocale_Desc_" .. opt]
								  )
end

local function DDAddRadioBoxes(opt, map, func, default)
			local k,v
			dewdrop:AddLine('text', default or _G.TinyTipChatLocale_GameDefault,
											'isRadio', true,
											'checked', not db[opt],
											'func', func or SetDB,
											'arg1', opt )
			for k,v in map do
				dewdrop:AddLine('text', v,
												'isRadio', true,
												'checked', db[opt] == k,
												'func', func or SetDB,
												'arg1', opt,
												'arg2', k )
			end
end

local function DDAddScale(opt, func, default)
			dewdrop:AddLine( 'text', _G["TinyTipChatLocale_Opt_" .. opt],
									 'hasArrow', true,
									 'hasSlider', true,
									 'sliderMin', 0.01,
									 'sliderMax', 2.0,
									 'sliderIsPercent', true,
									 'sliderValue', db[opt] or default or 1.0,
									 'sliderFunc', func or _G.TinyTip_SetScale,
									 'sliderArg1', opt,
									 'tooltipTitle', "TinyTip",
									 'tooltipText', _G["TinyTipChatLocale_Desc_" .. opt] )
end

function TinyTipOptions_CreateDDMenu(level,value)
	if not db then return end
	if level == 1 then
		dewdrop:AddLine( 'text', _G.TinyTipChatLocale_MenuTitle,
										 'isTitle', true
									 )
		if _G.TinyTipAnchorExists then 
			DDAddArrow("Main_Anchor") 
		end
		DDAddArrow("Main_Text")
		DDAddArrow("Main_Appearance")
		if _G.GetAddOnMetadata("TinyTipExtras", "Title") then
			DDAddArrow("Main_Targets") 
			DDAddArrow("Main_Extras")
		end
		
		dewdrop:AddLine()
		if _G.TinyTipDB then
			dewdrop:AddLine('text', _G.TinyTipChatLocale_Opt_Profiles,
										 	'checked', _G.TinyTipDB["_profile"],
										 	'func', function() 
											 				_G.TinyTipDB["_profile"] = not _G.TinyTipDB["_profile"] 
															_G.TinyTip_UpdateProfiles()
														 end,
											'tooltipTitle', "TinyTip",
											'tooltipText', _G.TinyTipChatLocale_Desc_Profiles
									 	 )
		end
		dewdrop:AddLine()

		dewdrop:AddLine('text', _G.TinyTipChatLocale_Opt_Main_Default,
										'textR', 1, 'textG', 0.4, 'textB', 0.4,
										'func', _G.TinyTip_DefaultDB,
										'tooltipTitle', "TinyTip",
										'tooltipText', _G.TinyTipChatLocale_Desc_Main_Default)

	elseif level == 2 then
		if value == "Main_Anchor" then
			DDAddArrow("MAnchor")
			DDAddEditBoxNum("MOffX")
			DDAddEditBoxNum("MOffY")

			dewdrop:AddLine()

			DDAddArrow("FAnchor")
			DDAddEditBoxNum("FOffX")
			DDAddEditBoxNum("FOffY")

			dewdrop:AddLine()
			DDAddChecked("AnchorAll")
			DDAddChecked("AlwaysAnchor")
			if db["ExtraTooltip"] then
				dewdrop:AddLine()

				DDAddArrow("ETAnchor")
				DDAddEditBoxNum("ETOffX")
				DDAddEditBoxNum("ETOffY")
			end
			if db["PvPIcon"] then
				dewdrop:AddLine()

				DDAddArrow("PvPIconAnchor1")
				DDAddArrow("PvPIconAnchor2")
				DDAddEditBoxNum("PvPIconOffX")
				DDAddEditBoxNum("PvPIconOffY")
			end
			if db["RTIcon"] then
				dewdrop:AddLine()

				DDAddArrow("RTIconAnchor1")
				DDAddArrow("RTIconAnchor2")
				DDAddEditBoxNum("RTIconOffX")
				DDAddEditBoxNum("RTIconOffY")
			end
			if db["Buffs"] then
				dewdrop:AddLine()

				DDAddArrow("BuffAnchor1")
				DDAddArrow("BuffAnchor2")
				DDAddEditBoxNum("BuffOffX")
				DDAddEditBoxNum("BuffOffY")
			end
			if db["Debuffs"] then
				dewdrop:AddLine()

				DDAddArrow("DebuffAnchor1")
				DDAddArrow("DebuffAnchor2")
				DDAddEditBoxNum("DebuffOffX")
				DDAddEditBoxNum("DebuffOffY")
			end

		elseif value == "Main_Text" then
			DDAddArrow("PvPRank")

			dewdrop:AddLine()

			DDAddChecked("HideLevelText")
			DDAddChecked("HideRace")
			DDAddChecked("KeyElite")
			DDAddChecked("HideGuild")
			DDAddChecked("ReactionText")
			DDAddChecked("LevelGuess")
		elseif value == "Main_Appearance" then
			DDAddScale("Scale")
			DDAddArrow("BGColor")
			DDAddArrow("Border")
			DDAddArrow("Fade")
			DDAddArrow("Friends")

			dewdrop:AddLine()

			DDAddChecked("SmoothBorder", TinyTip_SmoothBorder)
			DDAddChecked("Compact")
			DDAddChecked("HideInFrames")
			DDAddChecked("FormatDisabled")

			if db["PvPIcon"] or db["RTIcon"] or db["Buffs"] or db["Debuffs"] then
				dewdrop:AddLine()
			end
			if db["PvPIcon"] then
				DDAddScale("PvPIconScale", SetExtrasNum, 0.7)
			end
			if db["RTIcon"] then
				DDAddScale("RTIconScale", SetExtrasNum, 0.1)
			end
			if db["Buffs"] or db["Debuffs"] then
				DDAddScale("BuffScale", SetExtrasNum, 0.2)
			end
		elseif value == "Main_Targets" then
			DDAddArrow("ToT")
			DDAddArrow("ToP")
			DDAddArrow("ToR")
		elseif value == "Main_Extras" then
			DDAddArrow("ExtraTooltip")
			DDAddArrow("Buffs")
			DDAddArrow("Debuffs")

			dewdrop:AddLine()

			DDAddChecked("PvPIcon", ToggleExtras)
			DDAddChecked("RTIcon", ToggleExtras)
			DDAddChecked("ManaBar", ToggleExtras)
		end
	elseif level == 3 then
		local k,v
		if value == "MAnchor" then
			dewdrop:AddLine('text', _G.TinyTipChatLocale_GameDefault,
					'isRadio', true,
					'checked', db["MAnchor"] == "GAMEDEFAULT",
					'func', SetDB,
					'arg1', "MAnchor",
					'arg2', "GAMEDEFAULT")

			dewdrop:AddLine('text', _G.TinyTipChatLocale_Anchor_Cursor,
					'isRadio', true,
					'checked', not db["MAnchor"],
					'func', SetAnchor,
					'arg1', "MAnchor")

			for k,v in _G.TinyTipChatLocale_ChatMap_Anchor do
					dewdrop:AddLine('text', v,
							'isRadio', true,
							'checked', db["MAnchor"] == k,
							'func', SetAnchor,
							'arg1', "MAnchor",
							'arg2', k )
			end
		elseif value == "FAnchor" then
			dewdrop:AddLine('text', _G.TinyTipChatLocale_GameDefault,
											'isRadio', true,
											'checked', not db["FAnchor"],
											'func', SetDB,
											'arg1', "FAnchor" )

			dewdrop:AddLine('text', _G.TinyTipChatLocale_Anchor_Sticky,
											'isRadio', true,
											'checked', db["FAnchor"] == "STICKY",
											'func', SetAnchor,
											'arg1', "FAnchor",
											'arg2', "STICKY" )

			dewdrop:AddLine('text', _G.TinyTipChatLocale_Anchor_Cursor,
											'isRadio', true,
											'checked', db["FAnchor"] == "CURSOR",
											'func', SetAnchor,
											'arg1', "FAnchor",
											'arg2', "CURSOR" )

			for k,v in _G.TinyTipChatLocale_ChatMap_Anchor do
				dewdrop:AddLine('text', v,
												'isRadio', true,
												'checked', db["FAnchor"] == k,
												'func', SetAnchor,
												'arg1', "FAnchor",
												'arg2', k )
			end
		elseif value == "PvPIconAnchor1" then
			DDAddRadioBoxes(value,
											_G.TinyTipChatLocale_ChatMap_Anchor,
											SetExtras,
											_G.TinyTipChatLocale_TinyTipDefault)
		elseif value == "PvPIconAnchor2" then
			DDAddRadioBoxes(value,
											_G.TinyTipChatLocale_ChatMap_Anchor,
											SetExtras,
											_G.TinyTipChatLocale_TinyTipDefault)
		elseif value == "RTIconAnchor1" then
			DDAddRadioBoxes(value,
											_G.TinyTipChatLocale_ChatMap_Anchor,
											SetExtras,
											_G.TinyTipChatLocale_TinyTipDefault)
		elseif value == "RTIconAnchor2" then
			DDAddRadioBoxes(value,
											_G.TinyTipChatLocale_ChatMap_Anchor,
											SetExtras,
											_G.TinyTipChatLocale_TinyTipDefault)
		elseif value == "BuffAnchor1" then
			DDAddRadioBoxes(value,
											_G.TinyTipChatLocale_ChatMap_Anchor,
											SetExtras,
											_G.TinyTipChatLocale_TinyTipDefault)	
		elseif value == "BuffAnchor2" then
			DDAddRadioBoxes(value,
											_G.TinyTipChatLocale_ChatMap_Anchor,
											SetExtras,
											_G.TinyTipChatLocale_TinyTipDefault)	
		elseif value == "DebuffAnchor1" then
			DDAddRadioBoxes(value,
											_G.TinyTipChatLocale_ChatMap_Anchor,
											SetExtras,
											_G.TinyTipChatLocale_TinyTipDefault)	
		elseif value == "DebuffAnchor2" then
			DDAddRadioBoxes(value,
											_G.TinyTipChatLocale_ChatMap_Anchor,
											SetExtras,
											_G.TinyTipChatLocale_TinyTipDefault)	
		elseif value == "PvPRank" then
			DDAddRadioBoxes(value, 
										 _G.TinyTipChatLocale_ChatIndex_PvPRank, 
										 nil,  
										 _G.TinyTipChatLocale_TinyTipDefault)
		elseif value == "BGColor" then
			DDAddRadioBoxes(value, 
										 _G.TinyTipChatLocale_ChatIndex_BGColor,
										 nil,
										 _G.TinyTipChatLocale_TinyTipDefault)
		elseif value == "Border" then
			DDAddRadioBoxes(value, 
										 _G.TinyTipChatLocale_ChatIndex_Border,
										 nil,
										 _G.TinyTipChatLocale_TinyTipDefault)
		elseif value == "Fade" then
			DDAddRadioBoxes(value, 
										 _G.TinyTipChatLocale_ChatIndex_Fade )
		elseif value == "Friends" then
			DDAddRadioBoxes(value, 
										 _G.TinyTipChatLocale_ChatIndex_Friends,
										 nil,
										 _G.TinyTipChatLocale_TinyTipDefault)
		elseif value == "ToT" then
			DDAddRadioBoxes(value, 
										 _G.TinyTipChatLocale_ChatIndex_ToT,
										 SetTargets,
										 _G.TinyTipChatLocale_Off)
		elseif value == "ToP" then
			DDAddRadioBoxes(value, 
										 _G.TinyTipChatLocale_ChatIndex_ToP,
										 SetTargets,
										 _G.TinyTipChatLocale_Off)
		elseif value == "ToR" then
			DDAddRadioBoxes(value, 
										 _G.TinyTipChatLocale_ChatIndex_ToR,
										 SetTargets,
										 _G.TinyTipChatLocale_Off)
		elseif value == "ExtraTooltip" then
			DDAddRadioBoxes(value,
										_G.TinyTipChatLocale_ChatIndex_ExtraTooltip,
										SetExtras,
										_G.TinyTipChatLocale_Off)
		elseif value == "ETAnchor" then
			dewdrop:AddLine('text', _G.TinyTipChatLocale_GameDefault,
											'isRadio', true,
											'checked', not db["ETAnchor"],
											'func', SetDB,
											'arg1', "ETAnchor" )

			for k,v in _G.TinyTipChatLocale_ChatMap_Anchor do
					dewdrop:AddLine('text', v,
													'isRadio', true,
													'checked', db["ETAnchor"] == k,
													'func', SetAnchor,
													'arg1', "ETAnchor",
													'arg2', k )
			end
		elseif value == "Buffs" then
			DDAddRadioBoxes(value,
										_G.TinyTipChatLocale_ChatIndex_Buffs,
										SetExtras,
										_G.TinyTipChatLocale_Off)
		elseif value == "Debuffs" then
			DDAddRadioBoxes(value,
										_G.TinyTipChatLocale_ChatIndex_Debuffs,
										SetExtras,
										_G.TinyTipChatLocale_Off)
		end
	end
end

function TinyTipOptions_SetLocals(_db)
	if _db then db = _db end
end

function TinyTipChat_SlashHandler(msg, _db)
	if _db then db = _db 
	elseif not db then return end

	msg = string.lower(msg)
	-- non saved variable options
	if msg == _G.TinyTipChatLocale_Opt_Slash_Default then
		_G.TinyTip_Msg( string.format("%s %s %s.", _G.TinyTipChatLocale_DefaultWarning, 
							    _G.SLASH_TINYTIP2, 
							    _G.TinyTipChatLocale_Confirm ) )
	elseif msg == _G.TinyTipChatLocale_Confirm then -- "hidden option"
		_G.TinyTip_DefaultDB()
	elseif msg == _G.TinyTipChatLocale_Opt_Slash_Report then
		local reportmap = _G.TinyTip_GetAllOptions()
		local k,v
		for _,v in reportmap do
			_G.TinyTip_Msg( string.format("%s %s [|cFFFFCC00%s|r]", v,
						 _G.TinyTipChatLocale_IsSetTo,
						 ( db[v] and type(db[v]) == "boolean" 
						    and _G.TinyTipChatLocale_On ) or 
						 (db[v] and type(db[v]) == "string" and 
						 string.format('"%s"', db[v])) or
						 (type(db[v]) == "number" and db[v]) or 
						 _G.TinyTipChatLocale_Off ) )
		end
	elseif msg and string.len(msg) > 0 then
		_G.TinyTip_Msg( string.format('"|cFFFF2222%s|r" %s', msg, _G.TinyTipChatLocale_NotValidCommand) )
	else -- open up options window

		if not ddframe then
				ddframe = _G.CreateFrame("Frame", nil, _G.UIParent)
				ddframe:SetWidth(2)
				ddframe:SetHeight(2)
				ddframe:SetPoint("BOTTOMLEFT", _G.GetCursorPosition())
				ddframe:SetClampedToScreen(true)
				dewdrop:Register(ddframe, 'dontHook', true, 'children', _G.TinyTipOptions_CreateDDMenu )
		end
		local x,y = _G.GetCursorPosition()
		ddframe:SetPoint("BOTTOMLEFT", x / UIParent:GetScale(), y / UIParent:GetScale())
		dewdrop:Open(ddframe)

	end

end

