--[[
	TODO;
			Get options load probs localized
		allow reset of session data
HonorBar at lvl 60.
	Experience from mob text.
Add second tier text vars
Figure out profile deletion
Element offsets
Start hooking
Vertical bars.
Circular bars.
More time to.... text...
	More text bars.
DAB optional dependencies for frame attachment.
Help tooltips for config
Identify and fix position label wierdness
Custom texture addons
Element defaults
OnMousover for bar/elements
]]
BEB.CurrentVersion = 0.87
BEB.textevents = {}
BEB.TimeThisSession = 1
local VARIABLES_LOADED
local ENTERING_WORLD
BEB.XpThisSession = 0
BEB.RateThisSession = 0
BEB.RestState = -1
BEB.XpMobsTS = 0
BEB.MobsTS = 0
BEB.Flashers = {}
BEB.Flashframes = {}
local UpdateFrequency = 5
local TimeFromLastUpdate = 0
local StringOnUpdate = 0
BEB.LOG_10 = math.log(10)
BEB.Elements ={ "BEBBackground", "BEBBarText", "BEBMarkers", "BEBRestedXpBar", "BEBRestedXpTick",
	"BEBRestedXpTickGlow", "BEBXpBar", "BEBXpTick"}
BEB.XpPerLvl = {400,900,1400,2100,2800,3600,4400,5400,6500,7600,8800,10100,11400,12900,14400,16000,17700,19400,21300,23200,
	25200,27300,29400,31700,34000,36400,38900,41400,44300,47400,50800,54500,58600,62800,67100,71600,76100,80800,85700,90700,
	95800,101000,106300,111800,117500,123200,129100,135100,141200,147500,153900,160400,167100,173900,180800,187900,195000,
	202300,209800,217400}

function BEB.OnLoad()
	SlashCmdList["BEB"] = BEB.Slash_Handler
	SLASH_BEB1 = "/beb"
	SLASH_BEB2 = "/basicexperiencebar"
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
	this:RegisterEvent("VARIABLES_LOADED")
end

function BEB.OnEvent(event)
	if (event == "VARIABLES_LOADED") then
		VARIABLES_LOADED = true
		if ( ENTERING_WORLD ) then
			BEB.Initialize()
		end
	elseif (event == "PLAYER_ENTERING_WORLD") then
		ENTERING_WORLD = true
		if ( VARIABLES_LOADED ) then
			BEB.Initialize()
		end
	elseif (event == "PLAYER_LEVEL_UP") then
		BEB.XpThisSession = BEB.XpThisSession + (UnitXPMax("player") - BEB.OldXp)
		BEB.OldXp = 0
	elseif (event == "PLAYER_UPDATE_RESTING") then
		BEB.UpdateFlashers()
--		BEB.SetColors("force")
		BEB.UpdateElement("BEBRestedXpTickGlow")
	elseif (event == "PLAYER_XP_UPDATE") then
		BEB.XpThisSession = BEB.XpThisSession + (UnitXP("player") - BEB.OldXp)
		BEB.OldXp = UnitXP("player")
		BEB.UpdateElement("BEBXpBar")
		BEB.UpdateElement("BEBRestedXpBar")
		BEB.UpdateElement("BEBRestedXpTick")
	elseif (event == "CHAT_MSG_COMBAT_XP_GAIN") then
		local _,_,xp,_ = string.find(arg1, BEB.LOCALIZED.XpSearchString)
		if (xp) then
			local _,_,rxp = string.find(arg1, BEB.LOCALIZED.RestedSearchString)
			BEB.XpMobsTS = BEB.XpMobsTS + tonumber(xp) - (tonumber(rxp) or 0)
			BEB.MobsTS = BEB.MobsTS + 1;
		end
	elseif (event == "UPDATE_EXHAUSTION") then
		BEB.UpdateElement("BEBRestedXpBar")
		BEB.UpdateElement("BEBRestedXpTick")
		BEB.UpdateElement("BEBRestedXpTickGlow")
		BEB.SetColors()
	elseif (event == "PLAYER_LOGOUT") then
		if (BEBCharSettings.BEBProfile) then
			BEB.SaveProfile(BEBCharSettings.BEBProfile)
		end
	end
end

function BEB.Initialize()
	local INDEX = UnitName("player").." of "..GetCVar("realmName")
	if (BEBCharSettings) then	
		if (BEBCharSettings.BEBMain.BEBProfile) then
			BEB.LoadProfile(BEBCharSettings.BEBProfile)
		end
	end
	if BEBINITIALIZED then
		return
	end
	BEBMain:RegisterEvent("PLAYER_LOGOUT")
	BEBMain:RegisterEvent("PLAYER_LEVEL_UP")
	BEBMain:RegisterEvent("PLAYER_UPDATE_RESTING")
	BEBMain:RegisterEvent("PLAYER_XP_UPDATE")
	BEBMain:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN")
	BEBMain:RegisterEvent("UPDATE_EXHAUSTION")
	BEBMain:RegisterForClicks("LeftButtonUp","RightButtonUp")
-- Set default local vals
	BEB.StartTime = GetTime() - 1
	BEB.OldXp = UnitXP("player") or 0
-- Setup default settings and saved variables
	if (not BEBGlobal) then
		BEBGlobal = {}
		BEBGlobal.profiles = {}
		BEBGlobal.Chars = {}
		BEB.DefaultSettings()
	elseif (not BEBCharSettings) then
		BEB.DefaultSettings()
	elseif (BEBCharSettings.Version < BEB.CurrentVersion) then
		BEB.DefaultSettings()
	end
	if (BEBCharSettings.BEBProfile) then
		BEB.SaveProfile(BEBCharSettings.BEBProfile)
	end
	BEBGlobal.Chars[INDEX] = {Profile = BEBCharSettings.BEBProfile, Version = BEBCharSettings.Version}
--count profiles for the dropdown menu... move to BEBOptions?
	local numprofiles = 0
	for _,_ in BEBGlobal.profiles do
		numprofiles = numprofiles + 1
	end
	table.setn(BEBGlobal.profiles,numprofiles)

	BEB.SetupBars()
	BEBINITIALIZED = true
	BEB.OnEvent("PLAYER_UPDATE_RESTING")
end

function BEB.Slash_Handler(msg)
	local command, param
	local index = string.find(msg, " ")
	if(index) then
		command = string.sub(msg, 1, (index - 1))
		param = string.sub(msg, (index + 1)  )
	else
		command = msg
	end
	if (command == "") then
		if (not IsAddOnLoaded("BEBOptions")) then
			local loaded,reason = LoadAddOn("BEBOptions")
			if (not loaded) then
				if (reason == "DISABLED") then
					BEB.Feedback(BEB.TEXT.optionsdisabled)
				elseif (reason == "MISSING") then
					BEB.Feedback(BEB.TEXT.optionsmissing)
				elseif (reason == "CORRUPT") then
					BEB.Feedback(BEB.TEXT.optionscorrupt)
				elseif (reason == "INTERFACE_VERSION") then
					BEB.Feedback(BEB.TEXT.optionsversion)
				else
					BEB.Feedback(BEB.TEXT.optionsnoload1..reason..BEB.TEXT.optionsnoload2)
				end
				return
			end
		end
		if (BEBConfigFrame:IsVisible()) then
			BEBConfigFrame:Hide()
		else
			BEBConfigFrame:Show()
		end
	else
		if (command == "help") then
			BEB.Feedback(BEB.TEXT.validcommands)
		elseif (command == "defaults") then
			BEB.LoadDefaults()
		else
			BEB.Feedback(BEB.TEXT.invalidcommand)
		end
	end
end
function BEB.DefaultSettings()
	if (not BEBCharSettings) then
		BEBCharSettings = {}
		BEBCharSettings.Version = 0
	end
	if (BEBCharSettings.Version < 0.7) then
		BEBCharSettings = {
			BEBBackground = {
				maxrestcolor = {0, 0, 0, .25},
				restcolor = {0, 0, 0, .25},
				shown = true,
				texture = "PlainBackdrop",
				unrestcolor = {0, 0, 0, .25}
			},
			BEBBarText = {
				clicktext = true,
				location = {
					point = "CENTER",
					relpoint = "CENTER",
					x = 0,
					y = 0
				},
				maxrestcolor = {1, 1, 1, 1},
				mouseover = false,
				restcolor = {1, 1, 1, 1},
				shown = true,
				size = {y=10},
				text = {string = "Lvl $plv, XP $cxp/$mxp, $pdl% , $rxp Rested Xp."},
				unrestcolor = {1, 1, 1, 1}
			},
			BEBMain = {
				dragable = true,
				enabled = true,
				location = {
					point = "CENTER",
					relpoint = "CENTER",
					relto = "UIParent",
					x = 0,
					y = -337
				},
				size = {x=1024,y=12}
			},
			BEBMarkers = {
				maxrestcolor = {1, 1, 1, 1},
				restcolor = {1, 1, 1, 1},
				shown = true,
				texture = "BEB-ExperienceBarMarkers",
				unrestcolor = {1, 1, 1, 1}
			},
			BEBProfile = false,
			BEBRestedXpBar = {
				maxrestcolor = {0.2, 0.3, 0.65, 1},
				restcolor = {0.2, 0.3, 0.65, 1},
				shown = true,
				texture = "BEB-BarFill-RoundedLight"
			},
			BEBRestedXpTick = {
				location = {x=0,y=0},
				maxrestcolor = {1, 0, 0, 1},
				restcolor = {1, 1, 1, 1},
				shown = true,
				size = {x=27,y=26},
				texture = "BEB-ExhaustionTicks"
			},
			BEBRestedXpTickGlow = {
				flashing = true,
				maxrestcolor = {1, 0.8, 0.8, 1},
				restcolor = {1, 1, 1, 1},
				shown = true,
				texture = "BEB-ExhaustionTicksGlow"
			},
			BEBXpBar = {
				maxrestcolor = {0.4, 0, 0.7, 1},
				restcolor = {0.4, 0, 0.7, 1},
				texture = "BEB-BarFill-RoundedLight",
				unrestcolor = {0.6, 0, 0.5, 1}
			},
			BEBXpTick = {
				location = {x=0,y=0},
				maxrestcolor = {1, 1, 1, 1},
				restcolor = {1, 1, 1, 1},
				shown = true,
				size = {x=27,y=26},
				texture = "BEB-ExhaustionTicks",
				unrestcolor = {1, 1, 1, 1}
			},
			Version = 0.7,
		}
	end
	if (BEBCharSettings.Version < 0.71) then
		BEBCharSettings.BEBBackground.flashing = false
		BEBCharSettings.BEBXpBar.flashing = false
		BEBCharSettings.BEBRestedXpBar.flashing = false
		BEBCharSettings.BEBMarkers.flashing = false
		BEBCharSettings.BEBXpTick.flashing = false
		BEBCharSettings.BEBRestedXpTick.flashing = false
		BEBCharSettings.BEBBarText.flashing = false
		BEBCharSettings.Version = 0.71
	end
	if (BEBCharSettings.Version < 0.82) then
		BEBCharSettings.BEBMain.level = 5
		BEBCharSettings.BEBBackground.level = 6
		BEBCharSettings.BEBXpBar.level = 7
		BEBCharSettings.BEBRestedXpBar.level = 7
		BEBCharSettings.BEBMarkers.level = 8
		BEBCharSettings.BEBXpTick.level = 9
		BEBCharSettings.BEBRestedXpTick.level = 9
		BEBCharSettings.BEBRestedXpTickGlow.level = 10
		BEBCharSettings.BEBBarText.level = 10
		BEBCharSettings.Version = 0.82
	end
	if (BEBCharSettings.Version < 0.84) then
		BEBCharSettings.BEBMain.strata = "HIGH"
		BEBCharSettings.BEBBackground.strata = "HIGH"
		BEBCharSettings.BEBXpBar.strata = "HIGH"
		BEBCharSettings.BEBRestedXpBar.strata = "HIGH"
		BEBCharSettings.BEBMarkers.strata = "HIGH"
		BEBCharSettings.BEBXpTick.strata = "HIGH"
		BEBCharSettings.BEBRestedXpTick.strata = "HIGH"
		BEBCharSettings.BEBRestedXpTickGlow.strata = "HIGH"
		BEBCharSettings.BEBBarText.strata = "HIGH"
		BEBCharSettings.Version = 0.84
	end
	if (BEBCharSettings.Version < 0.86) then
		BEBCharSettings.BEBMain.enabled = nil
		BEBCharSettings.Version = 0.86
	end
	if (BEBCharSettings.Version < BEB.CurrentVersion) then
		BEBCharSettings.Version = BEB.CurrentVersion
	end
end



function BEB.OnDragStart()
	if(not BEBCharSettings.BEBMain.dragable) then
		BEB.Feedback(BEB.TEXT.framelocked)
	else
		BEBMain:StartMoving()
	end
end

function BEB.OnDragStop()
	  BEBMain:StopMovingOrSizing()
	  BEB.GetPosition()
	  BEBMain:SetUserPlaced(false)
end

function BEB.OnClick(arg1)
	if (arg1 == "RightButton") then
		BEB.Slash_Handler("")
	elseif (arg1 == "LeftButton") then
		if (BEBCharSettings.BEBBarText.shown and BEBCharSettings.BEBBarText.clicktext) then
			ChatFrameEditBox:Insert(BEBBarText.textframe:GetText())
		end
	end
end

function BEB.OnEnter()
	if (BEBCharSettings.BEBBarText.shown and BEBCharSettings.BEBBarText.mouseover) then
		BEBBarText:Show()
	end
end
function BEB.OnLeave()
	if (BEBCharSettings.BEBBarText.shown and BEBCharSettings.BEBBarText.mouseover) then
		BEBBarText:Hide()
	end
end

function BEB.GetPosition()
	local BEBPoint = {}
	local BEBRelPoint = {}
	local point = BEBCharSettings.BEBMain.location.point
	local relpoint = BEBCharSettings.BEBMain.location.relpoint
	local relto = getglobal(BEBCharSettings.BEBMain.location.relto)
	if (point == "CENTER") then
		BEBPoint.x, BEBPoint.y = BEBMain:GetCenter()
	elseif (point == "TOPRIGHT") then
		BEBPoint.x, BEBPoint.y = BEBMain:GetRight(), BEBMain:GetTop()
	elseif (point == "TOPLEFT") then
		BEBPoint.x, BEBPoint.y = BEBMain:GetLeft(), BEBMain:GetTop()
	elseif (point == "BOTTOMRIGHT") then
		BEBPoint.x, BEBPoint.y = BEBMain:GetRight(), BEBMain:GetBottom()
	elseif (point == "BOTTOMLEFT") then
		BEBPoint.x, BEBPoint.y = BEBMain:GetLeft(), BEBMain:GetBottom()
	elseif (point == "TOP") then
		BEBPoint.x, _, BEBPoint.y = BEBMain:GetCenter(), BEBMain:GetTop()
	elseif (point == "BOTTOM") then
		BEBPoint.x, _, BEBPoint.y = BEBMain:GetCenter(), BEBMain:GetBottom()
	elseif (point == "LEFT") then
		BEBPoint.x, _, BEBPoint.y = BEBMain:GetLeft(), BEBMain:GetCenter()
	elseif (point == "RIGHT") then
		BEBPoint.x, _, BEBPoint.y = BEBMain:GetRight(), BEBMain:GetCenter()
	end
	if (relpoint == "CENTER") then
		BEBRelPoint.x, BEBRelPoint.y = relto:GetCenter()
	elseif (relpoint == "TOPRIGHT") then
		BEBRelPoint.x, BEBRelPoint.y = relto:GetRight(), relto:GetTop()
	elseif (relpoint == "TOPLEFT") then
		BEBRelPoint.x, BEBRelPoint.y = relto:GetLeft(), relto:GetTop()
	elseif (relpoint == "BOTTOMRIGHT") then
		BEBRelPoint.x, BEBRelPoint.y = relto:GetRight(), relto:GetBottom()
	elseif (relpoint == "BOTTOMLEFT") then
		BEBRelPoint.x, BEBRelPoint.y = relto:GetLeft(), relto:GetBottom()
	elseif (relpoint == "TOP") then
		BEBRelPoint.x, _, BEBRelPoint.y = relto:GetCenter(), relto:GetTop()
	elseif (relpoint == "BOTTOM") then
		BEBRelPoint.x, _, BEBRelPoint.y = relto:GetCenter(), relto:GetBottom()
	elseif (relpoint == "LEFT") then
		BEBRelPoint.x, _, BEBRelPoint.y = relto:GetLeft(), relto:GetCenter()
	elseif (relpoint == "RIGHT") then
		BEBRelPoint.x, _, BEBRelPoint.y = relto:GetRight(), relto:GetCenter()
	end
	BEBCharSettings.BEBMain.location.x, BEBCharSettings.BEBMain.location.y = BEBPoint.x - BEBRelPoint.x, BEBPoint.y - BEBRelPoint.y
end

function BEB.IsFrame(frameName)
	if (getglobal(frameName)) then
			local var = getglobal(frameName)
		return ((type(var) == "table") and (type(var[0]) == "userdata") and (type(var.GetName) == "function") and (var:GetName() == frameName))
	else
		return false
	end
end

function BEB.CompileString(instring, Frame)
	for k,_ in BEB.textevents do
		BEBTextEventFrame:UnregisterEvent(k)
	end
	local frame = Frame:GetName()
	local outstring = {}
	local i = 1
	local length = string.len(instring)
	local count = 0
	while (i<=length) do
		count = count +1
		outstring[count] = {}
		local start,_ = string.find(instring,"%$",i)
		if (start == i) then
			local substring = string.sub(instring, i, i+3)
			outstring[count].string = substring
			if (BEB.VARIABLE_FUNCTIONS[substring]) then
				outstring[count].func = BEB.VARIABLE_FUNCTIONS[substring].func
				outstring[count].text = outstring[count].func()
				for _,event in BEB.VARIABLE_FUNCTIONS[substring].events do
					if (BEB.textevents[event]) then
						if (BEB.textevents[event][frame]) then
							table.insert(BEB.textevents[event][frame],count)
						else
							BEB.textevents[event][frame] = {count}
						end
					else
						BEB.textevents[event] = {[frame] = {count}}
					end
				end
			end
			i = i+4
		elseif (not start) then
			outstring[count].string = string.sub(instring, i, length)
			outstring[count].text = outstring[count].string
			i = length +1
		else
			outstring[count].string = string.sub(instring, i, start-1)
			outstring[count].text = outstring[count].string
			i = start
		end
	end
	outstring.count = count
	Frame.texttable = outstring
	for k,_ in BEB.textevents do
		BEBTextEventFrame:RegisterEvent(k)
	end
end

function BEB.TexturePath(var)
	if (string.find(var, "Interface\\")) then
		return var
	else
		return "Interface\\AddOns\\BEB\\Textures\\"..var
	end
end

function BEB.LoadProfile(bebprofile)
	if (BEBGlobal.profiles[bebprofile]) then
		if (BEBCharSettings.BEBProfile == bebprofile) then
			BEBCharSettings = BEB.TableCopy(BEBGlobal.profiles[bebprofile])
			BEBCharSettings.BEBProfile = bebprofile
		else
			BEBCharSettings = BEB.TableCopy(BEBGlobal.profiles[bebprofile])
		end
	else
		BEB.FeedBack(BEB.TEXT.profilemissing)
		BEBCharSettings.BEBProfile = false
	end
end

function BEB.SaveProfile(bebprofile)
	BEBGlobal.profiles[bebprofile] = BEB.TableCopy(BEBCharSettings)
	BEBGlobal.profiles[bebprofile].BEBProfile = false
end

function BEB.TableCopy(a)
	local b={}
	for k,v in a do
		if type(v) == "table" then
			b[k] = BEB.TableCopy(v)
		else
			b[k]=v
		end
	end 
	return b
end

function BEB.SetupBars()
	local elements = {"BEBMain","BEBBackground","BEBXpBar","BEBRestedXpBar","BEBMarkers","BEBXpTick","BEBRestedXpTick","BEBRestedXpTickGlow","BEBBarText"}
	for _,v in ipairs(elements) do
		BEB.SetupElement(v)
	end
	BEB.SetColors(nil, true)
end
function BEB.SetupElement(element)
	if (element == "BEBProfile") then
		return
	end
	local Element = getglobal(element)
	if (BEBCharSettings[element].flashing) then
		BEB.Flashframes[element] = true
		if ((IsResting() == 1) and (not Element.flashing)) then
			BEB.StartFlashing(element,0.7,0.2,1)
		end
	else
		BEB.Flashframes[element] = nil
		if ((IsResting() == 1) and  Element.flashing) then
			BEB.StopFlashing(element)
		end
	end
	Element:SetFrameLevel(BEBCharSettings[element].level)
	Element:SetFrameStrata(BEBCharSettings[element].strata)
	if (element == "BEBMain") then
		if (BEB.IsFrame(BEBCharSettings.BEBMain.location.relto)) then
			BEBMain:ClearAllPoints()
			local Location = BEBCharSettings.BEBMain.location
			BEBMain:SetPoint(Location.point, Location.relto, Location.relpoint, Location.x, Location.y)
		else
			BEB.Feedback(BEB.TEXT.framewasinvalid)
			BEBMain:SetPoint("CENTER","UIParent","CENTER",0,0)
		end
		BEBMain:SetWidth(BEBCharSettings.BEBMain.size.x)
		BEBMain:SetHeight(BEBCharSettings.BEBMain.size.y)
		if (BEBCharSettings.BEBMain.dragable == true) then
			BEBMain:RegisterForDrag("LeftButton")
		else
			BEBMain:RegisterForDrag()
		end
		BEBBarText:SetHeight(BEBCharSettings.BEBMain.size.y)
		BEBXpBar:SetHeight(BEBCharSettings.BEBMain.size.y)
		BEBRestedXpBar:SetHeight(BEBCharSettings.BEBMain.size.y)
		BEB.BEBMainWidth = BEBMain:GetWidth()
	elseif (element == "BEBBackground") then
		if (BEBCharSettings.BEBBackground.shown) then
			BEBBackground:ClearAllPoints()
			BEBBackground:SetPoint("TOPLEFT", BEBMain, "TOPLEFT", 0, 0)
			BEBBackground:SetPoint("BOTTOMRIGHT", BEBMain, "BOTTOMRIGHT", 0, 0)
			BEBBackground.texture:SetTexture(BEB.TexturePath(BEBCharSettings.BEBBackground.texture))
			BEBBackground:Show()
		else
			BEBBackground:Hide()
		end
	elseif (element == "BEBXpBar") then
		BEBXpBar:ClearAllPoints()
		BEBXpBar:SetPoint("LEFT", BEBMain, "LEFT", 0, 0)
		BEBXpBar.texture:SetTexture(BEB.TexturePath(BEBCharSettings.BEBXpBar.texture))
	elseif (element == "BEBRestedXpBar") then
		if (BEBCharSettings.BEBRestedXpBar.shown) then
			BEBRestedXpBar:ClearAllPoints()
			BEBRestedXpBar:SetPoint("LEFT", BEBXpBar, "RIGHT", 0, 0)
			BEBRestedXpBar.texture:SetTexture(BEB.TexturePath(BEBCharSettings.BEBRestedXpBar.texture))
			BEBRestedXpBar:Show()
		else
			BEBRestedXpBar:Hide()
		end
	elseif (element == "BEBMarkers") then
		if (BEBCharSettings.BEBMarkers.shown) then
			BEBMarkers:ClearAllPoints()
			BEBMarkers:SetPoint("TOPLEFT", BEBMain, "TOPLEFT", 0, 0)
			BEBMarkers:SetPoint("BOTTOMRIGHT", BEBMain, "BOTTOMRIGHT", 0, 0)
			BEBMarkers.texture:SetTexture(BEB.TexturePath(BEBCharSettings.BEBMarkers.texture))
			BEBMarkers:Show()
		else
			BEBMarkers:Hide()
		end
	elseif (element == "BEBXpTick") then
		if (BEBCharSettings.BEBXpTick.shown) then
			BEBXpTick:ClearAllPoints()
			BEBXpTick:SetPoint("CENTER", "BEBXpBar", "RIGHT", BEBCharSettings.BEBXpTick.location.x, BEBCharSettings.BEBXpTick.location.y)
			BEBXpTick.texture:SetTexture(BEB.TexturePath(BEBCharSettings.BEBXpTick.texture))
			BEBXpTick.texture:SetTexCoord(0,0.5,0,0.5)
			BEBXpTick:Show()
		else
			BEBXpTick:Hide()
		end
		BEBXpTick:SetWidth(BEBCharSettings.BEBXpTick.size.x)
		BEBXpTick:SetHeight(BEBCharSettings.BEBXpTick.size.y)
	elseif (element == "BEBRestedXpTick") then
		if (BEBCharSettings.BEBRestedXpTick.shown) then
			BEBRestedXpTick.texture:SetTexture(BEB.TexturePath(BEBCharSettings.BEBRestedXpTick.texture))
			BEBRestedXpTick:SetWidth(BEBCharSettings.BEBRestedXpTick.size.x)
			BEBRestedXpTick:SetHeight(BEBCharSettings.BEBRestedXpTick.size.y)
			BEBRestedXpTick:Show()
		else
			BEBRestedXpTick:Hide()
		end
	elseif (element == "BEBRestedXpTickGlow") then
		if (BEBCharSettings.BEBRestedXpTickGlow.shown) then
			BEBRestedXpTickGlow.texture:SetTexture(BEB.TexturePath(BEBCharSettings.BEBRestedXpTickGlow.texture))
			BEBRestedXpTickGlow:ClearAllPoints()
			BEBRestedXpTickGlow:SetPoint("TOPLEFT", "BEBRestedXpTick", "TOPLEFT", 0, 0)
			BEBRestedXpTickGlow:SetPoint("BOTTOMRIGHT", "BEBRestedXpTick", "BOTTOMRIGHT", 0, 0)
		end
	elseif (element == "BEBBarText") then
		if (BEBCharSettings.BEBBarText.shown) then
			BEB.CompileString(BEBCharSettings.BEBBarText.text.string, BEBBarText)
			BEBBarText:ClearAllPoints()
			BEBBarText:SetPoint(BEBCharSettings.BEBBarText.location.point, "BEBMain", BEBCharSettings.BEBBarText.location.relpoint, BEBCharSettings.BEBBarText.location.x, BEBCharSettings.BEBBarText.location.y)
			BEB.StringEvent("WRITE_ALL", element)
			if (BEBCharSettings.BEBBarText.mouseover) then
				BEBBarText:Hide()
			else
				BEBBarText:Show()
			end
		else
			BEBBarText:Hide()
		end
		BEBBarText.textframe:SetTextHeight(BEBCharSettings.BEBBarText.size.y)
		local scale = BEBMain:GetScale()
		BEBMain:SetScale(scale + 0.1)
		BEBMain:SetScale(scale)
	end
	BEB.UpdateElement(element)
end

function BEB.SetColors(element, force) -- do not use the numbers 0, 1 or 2 for force
	BEB.OldRestState = force or BEB.RestState
	if (GetRestState() == 1) then
		if (GetXPExhaustion() == (UnitXPMax("player")*1.5)) then
			BEB.RestState = 2
		else
			BEB.RestState = 1
		end
	else
		BEB.RestState = 0
	end
	if (BEB.RestState ~= BEB.OldRestState) then
		if (element) then
			BEB.SetElementColor(element)
		else
			for _,v in BEB.Elements do
				BEB.SetElementColor(v)
			end
		end
	end
end

function BEB.SetElementColor(element)
	local Element = getglobal(element)
	if ((BEB.RestState == 0) and BEBCharSettings[element].unrestcolor) then
		(Element.texture or Element.textframe):SetVertexColor(unpack(BEBCharSettings[element].unrestcolor))
	elseif ((BEB.RestState == 1) and BEBCharSettings[element].restcolor) then
		(Element.texture or Element.textframe):SetVertexColor(unpack(BEBCharSettings[element].restcolor))
	elseif ((BEB.RestState == 2) and BEBCharSettings[element].maxrestcolor) then
		(Element.texture or Element.textframe):SetVertexColor(unpack(BEBCharSettings[element].maxrestcolor))
	end
end

function BEB.UpdateElement(element)
	if (element == "BEBXpBar") then
		BEB.BEBScale = BEB.BEBMainWidth / UnitXPMax("player")
		if ((not UnitXP("player")) or (UnitXP("player") == 0)) then
			BEB.BEBXpWidth = 1
		else
			BEB.BEBXpWidth = BEB.BEBScale * UnitXP("player")
		end
		BEBXpBar:SetWidth(BEB.BEBXpWidth)
		BEBXpBar.texture:SetTexCoord(0,(BEB.BEBXpWidth/BEB.BEBMainWidth),0,1)
	elseif (element == "BEBRestedXpBar") then
		if ((GetRestState() == 1) and BEBCharSettings.BEBRestedXpBar.shown) then
			if ((UnitXP("player")+GetXPExhaustion()) > UnitXPMax("player")) then
				BEBRestedXpBar:SetWidth(BEB.BEBMainWidth - BEB.BEBXpWidth)
				BEBRestedXpBar.texture:SetTexCoord((BEB.BEBXpWidth/BEB.BEBMainWidth),1,0,1)
			else
				local BEBRestedXpWidth = (UnitXP("player")+GetXPExhaustion())*BEB.BEBScale
				BEBRestedXpBar:SetWidth(BEBRestedXpWidth - BEB.BEBXpWidth)
				BEBRestedXpBar.texture:SetTexCoord((BEB.BEBXpWidth/BEB.BEBMainWidth),(BEBRestedXpWidth/BEB.BEBMainWidth),0,1)
			end
		else
			BEBRestedXpBar:Hide()
		end
	elseif (element == "BEBRestedXpTick") then
		if ((GetRestState() == 1) and BEBCharSettings.BEBRestedXpTick.shown) then
			local position
			local xp, rest, xpmax, level = UnitXP("player"), GetXPExhaustion(), UnitXPMax("player"), UnitLevel("player")
			if (level < 59) then
				if ((xp + rest - xpmax) > BEB.XpPerLvl[level+1]) then
					position = ((xp + rest - xpmax - BEB.XpPerLvl[level+1])/BEB.XpPerLvl[level+2]) * BEB.BEBMainWidth
					BEBRestedXpTick.texture:SetTexCoord(0, 0.5, 0.5, 1)
					BEB.BEBRestState = 3
				elseif ((xp + rest) > xpmax) then
					position = ((xp + rest - xpmax)/BEB.XpPerLvl[level+1]) * BEB.BEBMainWidth
					BEBRestedXpTick.texture:SetTexCoord(0.5, 1, 0, 0.5)
					BEB.BEBRestState = 2
				else
					position = (xp + rest)*BEB.BEBScale
					BEBRestedXpTick.texture:SetTexCoord(0, 0.5, 0, 0.5)
					BEB.BEBRestState = 1
				end
			elseif (level == 59) then
				if ((xp + rest - xpmax) > BEB.XpPerLvl[level+1]) then
					position = BEB.BEBMainWidth
					BEBRestedXpTick.texture:SetTexCoord(0, 0.5, 0.5, 1)
					BEB.BEBRestState = 3
				elseif ((xp + rest) > xpmax) then
					position = ((xp + rest - xpmax)/BEB.XpPerLvl[level+1]) * BEB.BEBMainWidth
					BEBRestedXpTick.texture:SetTexCoord(0.5, 1, 0, 0.5)
					BEB.BEBRestState = 2
				else
					position = (xp + rest)*BEB.BEBScale
					BEBRestedXpTick.texture:SetTexCoord(0, 0.5, 0, 0.5)
					BEB.BEBRestState = 1
				end
			elseif (level == 60) then
				if ((xp + rest) > xpmax) then
					position = BEB.BEBMainWidth
					BEBRestedXpTick.texture:SetTexCoord(0.5, 1, 0, 0.5)
					BEB.BEBRestState = 2
				else
					position = (xp + rest)*BEB.BEBScale
					BEBRestedXpTick.texture:SetTexCoord(0, 0.5, 0, 0.5)
					BEB.BEBRestState = 1
				end
			end
			local offsets = BEBCharSettings.BEBRestedXpTick.location
			BEBRestedXpTick:SetPoint("CENTER" ,"BEBMain" ,"LEFT", (position + offsets.x), offsets.y)
			BEBRestedXpTick:Show()
		else
			BEBRestedXpTick:Hide()
			BEB.BEBRestState = 0
		end
	elseif (element == "BEBRestedXpTickGlow") then
		if (BEBCharSettings.BEBRestedXpTickGlow.shown and (BEB.BEBRestState ~= 0) and (IsResting() == 1)) then
			if (BEB.BEBRestState == 1) then
				BEBRestedXpTickGlow.texture:SetTexCoord(0, 0.5, 0, 0.5)
				BEBRestedXpTickGlow:Show()
			elseif (BEB.BEBRestState == 2) then
				BEBRestedXpTickGlow.texture:SetTexCoord(0.5, 1, 0, 0.5)
				BEBRestedXpTickGlow:Show()
			elseif (BEB.BEBRestState == 3) then
				BEBRestedXpTickGlow.texture:SetTexCoord(0, 0.5, 0.5, 1)
				BEBRestedXpTickGlow:Show()
			end
		else
			BEBRestedXpTickGlow:Hide()
		end
	end
end

function BEB.OnUpdate(elapsed)
	if (BEBINITIALIZED) then
		if (BEB.TextTimeToHide) then
			if (BEB.TextTimeToHide > 0) then
				BEB.TextTimeToHide = BEB.TextTimeToHide - elapsed
			else
				BEB.TextTimeToHide = nil
				BEBBarText:Hide()
			end
		end
		BEB.TimeThisSession = GetTime() - BEB.StartTime
		BEB.RateThisSession = BEB.XpThisSession/BEB.TimeThisSession
		TimeFromLastUpdate = TimeFromLastUpdate + elapsed
		if (TimeFromLastUpdate > UpdateFrequency) then
			BEB.UpdateElement("BEBXpBar")
			BEB.UpdateElement("BEBRestedXpBar")
			BEB.UpdateElement("BEBRestedXpTick")
			BEB.UpdateElement("BEBRestedXpTickGlow")
			BEB.SetColors()
			TimeFromLastUpdate = 0
		end
		if (BEB.textevents["ON_UPDATE"]) then
			StringOnUpdate = StringOnUpdate +elapsed
			if (StringOnUpdate > 0.5) then
				BEB.StringEvent("ON_UPDATE")
				StringOnUpdate = 0
			end
		end
		BEB.Flashing(elapsed)
	end
end

function BEB.StringEvent(event,writeframe)
	if (BEB.textevents[event]) then
		for frame,table in BEB.textevents[event] do
			local Frame = getglobal(frame)
			local text = ""
			for _,n in table do
				Frame.texttable[n].text = Frame.texttable[n].func()
			end
			for i=1,Frame.texttable.count do
				text = text..Frame.texttable[i].text
			end
			if (Frame.textframe) then
				Frame.textframe:SetText(text)
				Frame:SetWidth(Frame.textframe:GetWidth())
			else
				Frame.text = text
			end
		end
	elseif (event == "WRITE_ALL") then
		local Frame = getglobal(writeframe)
		local text = ""
		for i=1,Frame.texttable.count do
			text = text..Frame.texttable[i].text
		end
		if (Frame.textframe) then
			Frame.textframe:SetText(text)
			Frame:SetWidth(Frame.textframe:GetWidth())
		else
			Frame.text = text
		end
	end
end

function BEB.Feedback(msg)
	DEFAULT_CHAT_FRAME:AddMessage( msg, 1.0, 1.0, 0.0 );
end

function BEB.StartFlashing(element,rate,min,max)
	local Element = getglobal(element)
	if (not BEB.Flashers[element]) then
		BEB.Flashers[element] = Element
		Element.rate = rate
		Element.min = min
		Element.max = max
		Element.scale = (max-min)/rate
		Element.time = rate
		if (Element.textframe) then
			Element.textframe:SetAlpha(max)
		elseif (Element.texture) then
			Element.texture:SetAlpha(max)
		end
	end
end

function BEB.StopFlashing(element)
	local Element = getglobal(element)
	BEB.Flashers[element] = nil
	Element.rate = nil
	Element.min = nil
	Element.max = nil
	Element.scale = nil
	Element.time = nil
--	SetElementAlpha(element)
end

function BEB.Flashing(elapsed)
	for k,v in BEB.Flashers do
		BEB.doFlash(k,v,elapsed)
	end
end
function BEB.doFlash(element,Element,elapsed)
	if (Element.shown) then
		Element.time = Element.time - elapsed
		while (Element.time < 0) do
			Element.time = Element.rate + Element.time
			Element.reversed = not Element.reversed
--			if (Element.cycles) then
--				Element.cycles = Element.cycles - 0.5
--				if (Element.cycles == 0) then
--					BEB.StopFlashing(element)
--					Element.cycles = nil
--					return
--				end
--			end
		end
		if (Element.reversed) then
			if (Element.textframe) then
				Element.textframe:SetAlpha(Element.max-(Element.scale*Element.time))
			elseif (Element.texture) then
				Element.texture:SetAlpha(Element.max-(Element.scale*Element.time))
			end
		else
			if (Element.textframe) then
				Element.textframe:SetAlpha(Element.min+(Element.scale*Element.time))
			elseif (Element.texture) then
				Element.texture:SetAlpha(Element.min+(Element.scale*Element.time))
			end
		end
	end
end

function BEB.UpdateFlashers()
	if (IsResting() == 1) then
		for v,_ in BEB.Flashframes do
			BEB.StartFlashing(v,0.7,0.2,1)
		end
	else
		for v,_ in BEB.Flashframes do
			BEB.StopFlashing(v)
			BEB.SetColors(v, true)
		end
	end
end

function BEB.SecondsToTime(seconds)
	if (seconds < 60) then
		return math.floor(seconds).."s"
	elseif (seconds < 3600) then
		return math.floor(seconds/60).."m"..math.floor(math.mod(seconds,60)).."s"
	elseif (seconds < 86400) then
		return math.floor(seconds/3600).."h"..math.floor(math.mod(seconds,3600)/60).."m"
	else
		return math.floor(seconds/86400).."d"..math.floor(math.mod(seconds,86400)/3600).."h"
	end
end

function BEB.round(num, idp)
	local mult = 10^(idp or 0)
	return math.ceil((num*mult)-0.5) / mult
end

function BEB.sigfigs(num, figs)
	if (num == 0) then
		return 0
	else
		local expo = math.floor(math.log(math.abs(num))/BEB.LOG_10)
		return BEB.round(num, (figs-expo)-1)
	end
end

function BEB.LoadDefaults()
	if ( not BEBINITIALIZED ) then
		BEBConfigFrame:Hide()
		return
	end
	BEBCharSettings = nil
	BEB.DefaultSettings()
	BEB.SetupBars()
	BEB.Feedback(BEB.TEXT.defaultsloaded)
	BEBOPTIONS.OnShow()
end