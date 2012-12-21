-- Create the addon object
ArcHUD = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceHook-2.0", "AceConsole-2.0", "AceDB-2.0", "AceModuleCore-2.0", "AceDebug-2.0", "Metrognome-2.0")

-- Locale object
local L = AceLibrary("AceLocale-2.0"):new("ArcHUD_Core")

-- Debugging levels
--   1 Warning
--   2 Info
--   3 Notice
--   4 Off
local debugLevels = {"warn", "info", "notice", "off"}

-- Set up Dewdrop and core addon options menu
local dewdrop = AceLibrary:GetInstance("Dewdrop-2.0")
local ddframe

-- Set up database
ArcHUD:RegisterDB("ArcHUDDB")
ArcHUD:RegisterDefaults("profile", {
	Debug = nil,
	TargetFrame = true,
	PlayerModel = true,
	MobModel = false,
	ShowGuild = true,
	ShowClass = false,
	Width = 30,
	YLoc = 0,
	FadeFull = 0.1,
	FadeOOC = 0.5,
	FadeIC = 0.75,
	RingVisibility = 3,
	PartyLock = true,
	TargetTarget = true,
	TargetTargetTarget = true,
	NamePlates = true,
	Scale = 1.0,
	AttachTop = false,
	ShowBuffs = true,
	HoverMsg = true,
	HoverDelay = 3,
	BlizzPlayer = true,
	BlizzTarget = true,
})

-- Set up chat commands
ArcHUD:RegisterChatCommand({"/archud", "/ah"}, {
	type = "group",
	name = "ArcHUD",
	args = {
		reset = {
			type 		= "group",
			name		= "reset",
			desc		= L"CMD_RESET",
			args		= {
				confirm = {
					type	= "execute",
					name	= "CONFIRM",
					desc	= L"CMD_RESET_CONFIRM",
					func	= "ResetOptionsConfirm",
				}
			}
		},
		config = {
			type		= "execute",
			name		= "config",
			desc		= L"CMD_OPTS_FRAME",
			func		= function()
				if not ddframe then
					ddframe = CreateFrame("Frame", nil, UIParent)
					ddframe:SetWidth(2)
					ddframe:SetHeight(2)
					ddframe:SetPoint("BOTTOMLEFT", GetCursorPosition())
					ddframe:SetClampedToScreen(true)
					dewdrop:Register(ddframe, 'dontHook', true, 'children', ArcHUD.createDDMenu)
				end
				local x,y = GetCursorPosition()
				ddframe:SetPoint("BOTTOMLEFT", x / UIParent:GetScale(), y / UIParent:GetScale())
				dewdrop:Open(ddframe)
			end,
		},
		debug = {
			type		= "text",
			name		= "debug",
			desc		= L"CMD_OPTS_DEBUG",
			get			= function()
				return debugLevels[ArcHUD:GetDebugLevel() or 4]
			end,
			set			= function(v)
				if(v == "notice") then
					ArcHUD:SetDebugLevel(3)
					ArcHUD.db.profile.Debug = 3
				elseif(v == "info") then
					ArcHUD:SetDebugLevel(2)
					ArcHUD.db.profile.Debug = 2
				elseif(v == "warn") then
					ArcHUD:SetDebugLevel(1)
					ArcHUD.db.profile.Debug = 1
				elseif(v == "off") then
					ArcHUD:SetDebugLevel(nil)
					ArcHUD.db.profile.Debug = nil
				end
			end,
			validate 	= {"off", "warn", "info", "notice"},
			order 		= -2,
		},
	},
}, "ARCHUD")

function ArcHUD.modDB(action, key, namespace, value)
	if(not action or not key) then return end
	if(namespace and not value and not ArcHUD:HasModule(namespace)) then
		value = namespace
		namespace = nil
	end

	if(action == "toggle") then
		ArcHUD:LevelDebug(3, "Toggling key '%s'", key)
		if(namespace) then
			ArcHUD:AcquireDBNamespace(namespace).profile[key] = not ArcHUD:AcquireDBNamespace(namespace).profile[key]
		else
			ArcHUD.db.profile[key] = not ArcHUD.db.profile[key]
		end
	elseif(action == "set") then
		ArcHUD:LevelDebug(3, "Setting new value for key '%s' = '%s'", key, value)
		if(namespace) then
			ArcHUD:AcquireDBNamespace(namespace).profile[key] = tonumber(value)
		else
			ArcHUD.db.profile[key] = tonumber(value)
		end
	end

	if(namespace) then
		ArcHUD:TriggerEvent("ARCHUD_MODULE_UPDATE", namespace)
	else
		ArcHUD:OnProfileDisable()
		ArcHUD:OnProfileEnable()
	end
end

function ArcHUD.createDDMenu(level, menu)
	if(level == 1) then
		for _,v in ipairs(ArcHUD.dewdrop_menu["L1"]) do
			if(type(v) == "table") then
				ArcHUD:LevelDebug(3, "Creating button on level %s", level)
				dewdrop:AddLine(unpack(v))
			else
				ArcHUD:LevelDebug(1, "Error in createDDMenu in level %d (table expected, got %s)", level, type(v))
			end
		end
	else
		if(ArcHUD.dewdrop_menu[menu]) then
			local id
			local val
			local arg3
			local arg4
			local isradio
			for _,v in ipairs(ArcHUD.dewdrop_menu[menu]) do
				if(type(v) == "table") then
					ArcHUD:LevelDebug(3, "Creating button on level %s in menu %s", level, menu)
					id, val, arg3, arg4, isradio = nil, nil, nil, nil, nil
					for a,b in ipairs(v) do
						--ArcHUD:LevelDebug(3, "  ID: %d, Value: %s", a, (type(b) == "function" and "function" or b))
						if(b == "checked" or b == "sliderValue") then
							id = a+1
						elseif(b == "isRadio" and v[a+1]) then
							isradio = true
						elseif(b == "arg2" or b == "sliderArg2") then
							val = v[a+1]
						elseif(b == "arg3" or b == "sliderArg3") then
							arg3 = v[a+1]
						elseif(b == "arg4" or b == "sliderArg4") then
							arg4 = v[a+1]
						end
					end
					if(id) then
						ArcHUD:LevelDebug(3, "  Found value on '%d', setting name '%s'", id, val)
						if(isradio) then
							if(arg4) then
								ArcHUD:LevelDebug(3, "  Using namespace '%s'", arg3)
								v[id] = (ArcHUD:AcquireDBNamespace(arg3).profile[val] == arg4 and true or false)
								ArcHUD:LevelDebug(3, "  Value set to '%s'", v[id])
							else
								v[id] = (ArcHUD.db.profile[val] == arg3 and true or false)
								ArcHUD:LevelDebug(3, "  Value set to '%s'", v[id])
							end
						else
							if(arg3) then
								ArcHUD:LevelDebug(3, "  Using namespace '%s'", arg3)
								v[id] = ArcHUD:AcquireDBNamespace(arg3).profile[val]
								ArcHUD:LevelDebug(3, "  Value set to '%s'", v[id])
							else
								v[id] = ArcHUD.db.profile[val]
								ArcHUD:LevelDebug(3, "  Value set to '%s'", v[id])
							end
						end
					end
					dewdrop:AddLine(unpack(v))
				else
					ArcHUD:LevelDebug(1, "Error in createDDMenu in level %d (table expected, got %s)", level, type(v))
				end
			end
		end
	end
end

function ArcHUD:OnInitialize()
	-- Set debug level
	self:SetDebugLevel(self.db.profile.Debug)

	self.ClassColor = {
		["MAGE"] =		"00FFFF",
		["WARLOCK"] =	"8D54FB",
		["PRIEST"] =	"FFFFFF",
		["DRUID"] =		"FF8A00",
		["SHAMAN"] =	"FF71A8",
		["PALADIN"] =	"FF71A8",
		["ROGUE"] =		"FFFF00",
		["HUNTER"] =	"00FF00",
		["WARRIOR"] =	"B39442",
	}

	self:LevelDebug(3, "Creating core addon Dewdrop menu")
	self.dewdrop_menu = {
		["L1"] = {
			{"text", L("TEXT","TITLE"), "isTitle", true},
			{"text", L("Version: ")..self.version,	"notClickable", true},
			{"text", L("Author: ")..self.author, "notClickable", true},
			{},
			{"text", L("TEXT","DISPLAY"), "hasArrow", true, "value", "L2_display"},
			{"text", L("TEXT","FADE"), "hasArrow", true, "value", "L2_fade"},
			{"text", L("TEXT","MISC"), "hasArrow", true, "value", "L2_misc"},
			{},
			{"text", L("TEXT","RINGS"), "isTitle", true},
		},
		["L2_display"] = {
			{
				"text", L("TEXT","TARGETFRAME"),
				"tooltipTitle", L("TEXT","TARGETFRAME"),
				"tooltipText", L("TOOLTIP","TARGETFRAME"),
				"checked", false,
				"func", ArcHUD.modDB,
				"arg1", "toggle",
				"arg2", "TargetFrame"
			},
			{
				"text", L("TEXT","BLIZZPLAYER"),
				"tooltipTitle", L("TEXT","BLIZZPLAYER"),
				"tooltipText", L("TOOLTIP","BLIZZPLAYER"),
				"checked", false,
				"func", ArcHUD.modDB,
				"arg1", "toggle",
				"arg2", "BlizzPlayer"
			},
			{
				"text", L("TEXT","BLIZZTARGET"),
				"tooltipTitle", L("TEXT","BLIZZTARGET"),
				"tooltipText", L("TOOLTIP","BLIZZTARGET"),
				"checked", false,
				"func", ArcHUD.modDB,
				"arg1", "toggle",
				"arg2", "BlizzTarget"
			},
			{
				"text", L("TEXT","PLAYERMODEL"),
				"tooltipTitle", L("TEXT","PLAYERMODEL"),
				"tooltipText", L("TOOLTIP","PLAYERMODEL"),
				"checked", false,
				"func", ArcHUD.modDB,
				"arg1", "toggle",
				"arg2", "PlayerModel"
			},
			{
				"text", L("TEXT","MOBMODEL"),
				"tooltipTitle", L("TEXT","MOBMODEL"),
				"tooltipText", L("TOOLTIP","MOBMODEL"),
				"checked", false,
				"func", ArcHUD.modDB,
				"arg1", "toggle",
				"arg2", "MobModel"
			},
			{
				"text", L("TEXT","SHOWGUILD"),
				"tooltipTitle", L("TEXT","SHOWGUILD"),
				"tooltipText", L("TOOLTIP","SHOWGUILD"),
				"checked", false,
				"func", ArcHUD.modDB,
				"arg1", "toggle",
				"arg2", "ShowGuild"
			},
			{
				"text", L("TEXT","SHOWCLASS"),
				"tooltipTitle", L("TEXT","SHOWCLASS"),
				"tooltipText", L("TOOLTIP","SHOWCLASS"),
				"checked", false,
				"func", ArcHUD.modDB,
				"arg1", "toggle",
				"arg2", "ShowClass"
			},
			{
				"text", L("TEXT","NAMEPLATES"),
				"tooltipTitle", L("TEXT","NAMEPLATES"),
				"tooltipText", L("TOOLTIP","NAMEPLATES"),
				"checked", false,
				"func", ArcHUD.modDB,
				"arg1", "toggle",
				"arg2", "NamePlates"
			},
			{
				"text", L("TEXT","ATTACHTOP"),
				"tooltipTitle", L("TEXT","ATTACHTOP"),
				"tooltipText", L("TOOLTIP","ATTACHTOP"),
				"checked", false,
				"func", ArcHUD.modDB,
				"arg1", "toggle",
				"arg2", "AttachTop"
			},
			{
				"text", L("TEXT","TOT"),
				"tooltipTitle", L("TEXT","TOT"),
				"tooltipText", L("TOOLTIP","TOT"),
				"checked", false,
				"func", ArcHUD.modDB,
				"arg1", "toggle",
				"arg2", "TargetTarget"
			},
			{
				"text", L("TEXT","TOTOT"),
				"tooltipTitle", L("TEXT","TOTOT"),
				"tooltipText", L("TOOLTIP","TOTOT"),
				"checked", false,
				"func", ArcHUD.modDB,
				"arg1", "toggle",
				"arg2", "TargetTargetTarget"
			},
			{
				"text", L("TEXT","HOVERMSG"),
				"tooltipTitle", L("TEXT","HOVERMSG"),
				"tooltipText", L("TOOLTIP","HOVERMSG"),
				"checked", false,
				"func", ArcHUD.modDB,
				"arg1", "toggle",
				"arg2", "HoverMsg"
			},
			{
				"text", L("TEXT","HOVERDELAY"),
				"tooltipTitle", L("TEXT","HOVERDELAY"),
				"tooltipText", L("TOOLTIP","HOVERDELAY"),
				"hasArrow", true,
				"hasSlider", true,
				"sliderMin", 0,
				"sliderMax", 5,
				"sliderMinText", "Instant",
				"sliderMaxText", "5s",
				"sliderStep", 0.5,
				"sliderValue", 0,
				"sliderFunc", ArcHUD.modDB,
				"sliderArg1", "set",
				"sliderArg2", "HoverDelay"
			},
		},
		["L2_fade"] = {
			{
				"text", L("TEXT","FADE_FULL"),
				"tooltipTitle", L("TEXT","FADE_FULL"),
				"tooltipText", L("TOOLTIP","FADE_FULL"),
				"hasArrow", true,
				"hasSlider", true,
				"sliderStep", 0.01,
				"sliderIsPercent", true,
				"sliderValue", 0,
				"sliderFunc", ArcHUD.modDB,
				"sliderArg1", "set",
				"sliderArg2", "FadeFull"
			},
			{
				"text", L("TEXT","FADE_OOC"),
				"tooltipTitle", L("TEXT","FADE_OOC"),
				"tooltipText", L("TOOLTIP","FADE_OOC"),
				"hasArrow", true,
				"hasSlider", true,
				"sliderStep", 0.01,
				"sliderIsPercent", true,
				"sliderValue", 0,
				"sliderFunc", ArcHUD.modDB,
				"sliderArg1", "set",
				"sliderArg2", "FadeOOC"
			},
			{
				"text", L("TEXT","FADE_IC"),
				"tooltipTitle", L("TEXT","FADE_IC"),
				"tooltipText", L("TOOLTIP","FADE_IC"),
				"hasArrow", true,
				"hasSlider", true,
				"sliderStep", 0.01,
				"sliderIsPercent", true,
				"sliderValue", 0,
				"sliderFunc", ArcHUD.modDB,
				"sliderArg1", "set",
				"sliderArg2", "FadeIC"
			},
		},
		["L2_misc"] = {
			{
				"text", L("TEXT","WIDTH"),
				"tooltipTitle", L("TEXT","WIDTH"),
				"tooltipText", L("TOOLTIP","WIDTH"),
				"hasArrow", true,
				"hasSlider", true,
				"sliderMin", 30,
				"sliderMax", 100,
				"sliderStep", 1,
				"sliderValue", 0,
				"sliderFunc", ArcHUD.modDB,
				"sliderArg1", "set",
				"sliderArg2", "Width"
			},
			{
				"text", L("TEXT","YLOC"),
				"tooltipTitle", L("TEXT","YLOC"),
				"tooltipText", L("TOOLTIP","YLOC"),
				"hasArrow", true,
				"hasSlider", true,
				"sliderMin", -50,
				"sliderMax", 200,
				"sliderStep", 1,
				"sliderValue", 0,
				"sliderFunc", ArcHUD.modDB,
				"sliderArg1", "set",
				"sliderArg2", "YLoc"
			},
			{
				"text", L("TEXT","SCALE"),
				"tooltipTitle", L("TEXT","SCALE"),
				"tooltipText", L("TOOLTIP","SCALE"),
				"hasArrow", true,
				"hasSlider", true,
				"sliderStep", 0.01,
				"sliderMax", 2,
				"sliderIsPercent", true,
				"sliderValue", 0,
				"sliderFunc", ArcHUD.modDB,
				"sliderArg1", "set",
				"sliderArg2", "Scale"
			},
			{
				"text", L("TEXT","RINGVIS"),
				"tooltipTitle", L("TEXT","RINGVIS"),
				"tooltipText", L("TOOLTIP","RINGVIS"),
				"hasArrow", true,
				"value", "L3_ringvis"
			},
		},
		["L3_ringvis"] = {
			{
				"text", L("TEXT","RINGVIS_1"),
				"tooltipTitle", L("TEXT","RINGVIS_1"),
				"tooltipText", L("TOOLTIP","RINGVIS_1"),
				"isRadio", true,
				"checked", true,
				"func", ArcHUD.modDB,
				"arg1", "set",
				"arg2", "RingVisibility",
				"arg3", 1
			},
			{
				"text", L("TEXT","RINGVIS_2"),
				"tooltipTitle", L("TEXT","RINGVIS_2"),
				"tooltipText", L("TOOLTIP","RINGVIS_2"),
				"isRadio", true,
				"checked", false,
				"func", ArcHUD.modDB,
				"arg1", "set",
				"arg2", "RingVisibility",
				"arg3", 2
			},
			{
				"text", L("TEXT","RINGVIS_3"),
				"tooltipTitle", L("TEXT","RINGVIS_3"),
				"tooltipText", L("TOOLTIP","RINGVIS_3"),
				"isRadio", true,
				"checked", false,
				"func", ArcHUD.modDB,
				"arg1", "set",
				"arg2", "RingVisibility",
				"arg3", 3
			},
		},
	}

	-- Taken from Moog_Hud
	self.RepColor = { "FF4444", "DD4444", "DD7744", "BB9944", "44DD44", "55EE44", "66FF44"}

	self:LevelDebug(3, "Registering Metrognome timers")
	self:RegisterMetro("UpdatePetNamePlate", self.UpdatePetNamePlate, 2, self)
	self:RegisterMetro("UpdateTargetTarget", self.UpdateTargetTarget, 1, self)
	self:RegisterMetro("CheckNamePlateMouseOver", self.CheckNamePlateMouseOver, 0.1, self)

	self:LevelDebug(3, "Setting up TargetHUD globals")
	self.TargetHUD = getglobal("ArcTargetHUD")
	self.TargetHUD.frame = "ArcTargetHUD"
	self.TargetHUD.Name = getglobal(self.TargetHUD.frame.."Name")
	self.TargetHUD.Level = getglobal(self.TargetHUD.frame.."Level")
	self.TargetHUD.HPText = getglobal(self.TargetHUD.frame.."HPText")
	self.TargetHUD.MPText = getglobal(self.TargetHUD.frame.."MPText")
	self.TargetHUD.PVPIcon = getglobal(self.TargetHUD.frame.."PVPIcon")
	self.TargetHUD.MLIcon = getglobal(self.TargetHUD.frame.."MLIcon")
	self.TargetHUD.LeaderIcon = getglobal(self.TargetHUD.frame.."LeaderIcon")
	self.TargetHUD.RaidTargetIcon = getglobal(self.TargetHUD.frame.."RaidTargetIcon")
	self.TargetHUD.Combo = getglobal("ArcHUDFrameCombo")
	self.TargetHUD.Model = getglobal("ArcPlayerModelFrame")

	self.TargetHUD.Target = getglobal(self.TargetHUD.frame.."Target")
	self.TargetHUD.Target.frame = self.TargetHUD.frame.."Target"
	self.TargetHUD.Target.Name = getglobal(self.TargetHUD.Target.frame.."Name")
	self.TargetHUD.Target.HPText = getglobal(self.TargetHUD.Target.frame.."HPText")
	self.TargetHUD.Target.MPText = getglobal(self.TargetHUD.Target.frame.."MPText")

	self.TargetHUD.TargetTarget = getglobal(self.TargetHUD.frame.."TargetTarget")
	self.TargetHUD.TargetTarget.frame = self.TargetHUD.frame.."TargetTarget"
	self.TargetHUD.TargetTarget.Name = getglobal(self.TargetHUD.TargetTarget.frame.."Name")
	self.TargetHUD.TargetTarget.HPText = getglobal(self.TargetHUD.TargetTarget.frame.."HPText")
	self.TargetHUD.TargetTarget.MPText = getglobal(self.TargetHUD.TargetTarget.frame.."MPText")

	self:LevelDebug(3, "Setting up NamePlate globals")
	self.NamePlates = {}
	-- Player clickable nameplate
	self.NamePlates.Player = getglobal("ArcHUDFramePlayerNamePlate")
	self.NamePlates.Player.frame = "ArcHUDFramePlayerNamePlate"
	self.NamePlates.Player.unit = "player"
	self.NamePlates.Player.Text = getglobal(self.NamePlates.Player.frame.."Text")

	-- Pet clickable nameplate
	self.NamePlates.Pet = getglobal("ArcHUDFramePetNamePlate")
	self.NamePlates.Pet.frame = "ArcHUDFramePetNamePlate"
	self.NamePlates.Pet.unit = "pet"
	self.NamePlates.Pet.Text = getglobal(self.NamePlates.Pet.frame.."Text")

	-- Target clickable nameplate
	self.NamePlates.Target = getglobal(self.TargetHUD.frame.."NamePlate")
	self.NamePlates.Target.frame = self.TargetHUD.frame.."NamePlate"
	self.NamePlates.Target.unit = "target"

	-- Targettarget clickable nameplate
	self.NamePlates.TargetTarget = getglobal(self.TargetHUD.frame.."TargetNamePlate")
	self.NamePlates.TargetTarget.frame = self.TargetHUD.frame.."TargetNamePlate"
	self.NamePlates.TargetTarget.unit = "targettarget"

	-- Targettargettarget clickable nameplate
	self.NamePlates.TargetTargetTarget = getglobal(self.TargetHUD.frame.."TargetTargetNamePlate")
	self.NamePlates.TargetTargetTarget.frame = self.TargetHUD.frame.."TargetTargetNamePlate"
	self.NamePlates.TargetTargetTarget.unit = "targettargettarget"

	self:LevelDebug(3, "Initializing nameplates")
	-- Initialize nameplate dropdowns
	self:InitNamePlate("Target")
	self:InitNamePlate("TargetTarget")
	self:InitNamePlate("TargetTargetTarget")
	self:InitNamePlate("Player")
	self:InitNamePlate("Pet")

	-- Update fonts for locale
	self:LevelDebug(3, "Updating fonts for locale")
	self:UpdateFonts(self.TargetHUD)
	self:UpdateFonts(self.NamePlates)

	self.TargetHUD.PVPIcon:GetParent():SetScale(0.6)
	self.TargetHUD.RaidTargetIcon:GetParent():SetScale(0.75)

	self:TriggerEvent("ARCHUD_LOADED")
	self:LevelDebug(2, "ArcHUD has been initialized.")
end

function ArcHUD:OnEnable()
	self:LevelDebug(3, "Registering events")
	self:RegisterEvent("PLAYER_COMBO_POINTS", 	"EventHandler")
	self:RegisterEvent("PLAYER_ENTERING_WORLD",	"EventHandler")

	self:RegisterEvent("PLAYER_ENTER_COMBAT",	"CombatStatus")
	self:RegisterEvent("PLAYER_LEAVE_COMBAT", 	"CombatStatus")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", 	"CombatStatus")
	self:RegisterEvent("PLAYER_REGEN_DISABLED",	"CombatStatus")
	self:RegisterEvent("PET_ATTACK_START",		"CombatStatus")
	self:RegisterEvent("PET_ATTACK_STOP",		"CombatStatus")

	self:RegisterEvent("UNIT_FACTION",			"UpdateFaction")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED",	"UpdateFaction")

	self:RegisterEvent("RAID_TARGET_UPDATE",	"UpdateRaidTargetIcon")

	self:RegisterEvent("PLAYER_FLAGS_CHANGED")

	self:OnProfileEnable()

	self.Enabled = true

	ArcHUDFrame:Show()
	self:LevelDebug(3, "Triggering ring enable event")
	self:TriggerEvent("ARCHUD_MODULE_ENABLE")
	self:LevelDebug(2, "ArcHUD is now enabled")
end

function ArcHUD:OnDisable()
	self:LevelDebug(3, "Triggering ring disable event")
	self:TriggerEvent("ARCHUD_MODULE_DISABLE")

	-- Hide frame
	ArcHUDFrame:Hide()

	self.Enabled = false
	self:LevelDebug(2, "ArcHUD is now disabled")
end

function ArcHUD:OnProfileEnable()
	if(self.db.profile.BlizzPlayer and self.BlizzPlayerHidden or not self.db.profile.BlizzPlayer and not self.BlizzPlayerHidden) then
		self:HideBlizzardPlayer(self.db.profile.BlizzPlayer)
	end
	if(self.db.profile.BlizzTarget and self.BlizzTargetHidden or not self.db.profile.BlizzTarget and not self.BlizzTargetHidden) then
		self:HideBlizzardTarget(self.db.profile.BlizzTarget)
	end

	if(self.db.profile.TargetFrame) then
		self:LevelDebug(3, "Targetframe enabled. Registering unit events")
		self:RegisterEvent("UNIT_HEALTH", 			"EventHandler")
		self:RegisterEvent("UNIT_MAXHEALTH", 		"EventHandler")
		self:RegisterEvent("UNIT_MANA", 			"EventHandler")
		self:RegisterEvent("UNIT_RAGE", 			"EventHandler")
		self:RegisterEvent("UNIT_FOCUS", 			"EventHandler")
		self:RegisterEvent("UNIT_ENERGY", 			"EventHandler")
		self:RegisterEvent("UNIT_MAXMANA", 			"EventHandler")
		self:RegisterEvent("UNIT_MAXRAGE", 			"EventHandler")
		self:RegisterEvent("UNIT_MAXFOCUS", 		"EventHandler")
		self:RegisterEvent("UNIT_MAXENERGY", 		"EventHandler")
		self:RegisterEvent("UNIT_DISPLAYPOWER", 	"EventHandler")
		if(self.db.profile.ShowBuffs) then
			self:RegisterEvent("UNIT_AURA", 			"TargetAuras")
		else
			for i=1,16 do
				getglobal(self.TargetHUD.frame.."Buff"..i):Hide()
				getglobal(self.TargetHUD.frame.."DeBuff"..i):Hide()
			end
		end
		self:RegisterEvent("PLAYER_TARGET_CHANGED",	"TargetUpdate")

		-- Show target frame if we have a target
		if(UnitExists("target")) then
			self:TargetUpdate()
		end

		self:LevelDebug(3, "Enabling TargetTarget updates")
		-- Enable Target's Target('s Target) updates
		self:StartMetro("UpdateTargetTarget")


		if(self.db.profile.AttachTop) then
			self:LevelDebug(3, "Attaching targetframe to top")
			self.TargetHUD:ClearAllPoints()
			self.TargetHUD:SetPoint("BOTTOM", self.TargetHUD:GetParent(), "TOP", 0, -100)
		else
			self:LevelDebug(3, "Attaching targetframe to bottom")
			self.TargetHUD:ClearAllPoints()
			self.TargetHUD:SetPoint("TOP", self.TargetHUD:GetParent(), "BOTTOM", 0, -50)
		end
	else
		self:StopMetro("UpdateTargetTarget")
		self.TargetHUD:Hide()
	end

	self:LevelDebug(3, "Positioning ring anchors. Width: "..self.db.profile.Width)
	-- Position the HUD according to user settings
	if(self:HasModule("Anchors")) then
		self:GetModule("Anchors").Left:ClearAllPoints()
		self:GetModule("Anchors").Left:SetPoint("TOPLEFT", ArcHUDFrame, "TOPLEFT", 0-self.db.profile.Width, 0)
		self:GetModule("Anchors").Right:ClearAllPoints()
		self:GetModule("Anchors").Right:SetPoint("TOPLEFT", ArcHUDFrame, "TOPRIGHT", self.db.profile.Width, 0)
	end

	self:LevelDebug(3, "Position frame. YLoc: "..self.db.profile.YLoc)
	ArcHUDFrame:ClearAllPoints()
	ArcHUDFrame:SetPoint("CENTER", WorldFrame, "CENTER", 0, self.db.profile.YLoc)

	self:LevelDebug(3, "Setting scale. Scale: "..self.db.profile.Scale)
	-- Scale the HUD according to user settings.
	ArcHUDFrame:SetScale(self.db.profile.Scale)

	-- Set initial combat flags
	self.PlayerIsInCombat = false
	self.PlayerIsRegenOn = true
	self.PetIsInCombat = false

	self:LevelDebug(3, "Setting player name to nameplate")
	-- Set playername
	self:UpdateFaction()

	-- Enable nameplate updates
	if(self.db.profile.NamePlates) then
		self:LevelDebug(3, "Nameplates enabled. Showing frames and starting update timers")
		self:UnregisterMetro("Enable_player")
		self:UnregisterMetro("Enable_pet")
		self:RegisterMetro("Enable_player", self.EnableDisableNameplate, self.db.profile.HoverDelay, self, "Player")
		self:RegisterMetro("Enable_pet", self.EnableDisableNameplate, self.db.profile.HoverDelay, self, "Pet")
		self.NamePlates.Player:Show()
		self.NamePlates.Pet:Show()
		self:StartMetro("UpdatePetNamePlate")
		self:StartMetro("CheckNamePlateMouseOver")
	else
		self:LevelDebug(3, "Nameplates not enabled.")
		self:UnregisterMetro("Enable_player")
		self:UnregisterMetro("Enable_pet")
		self.NamePlates.Player:Hide()
		self.NamePlates.Pet:Hide()
	end
end

function ArcHUD:OnProfileDisable()
	self:LevelDebug(3, "Unregistering events")
	if(self:IsEventRegistered("UNIT_HEALTH")) then
		self:UnregisterEvent("UNIT_HEALTH")
		self:UnregisterEvent("UNIT_MAXHEALTH")
		self:UnregisterEvent("UNIT_MANA")
		self:UnregisterEvent("UNIT_RAGE")
		self:UnregisterEvent("UNIT_FOCUS")
		self:UnregisterEvent("UNIT_ENERGY")
		self:UnregisterEvent("UNIT_MAXMANA")
		self:UnregisterEvent("UNIT_MAXRAGE")
		self:UnregisterEvent("UNIT_MAXFOCUS")
		self:UnregisterEvent("UNIT_MAXENERGY")
		self:UnregisterEvent("UNIT_DISPLAYPOWER")
	end
	if(self:IsEventRegistered("UNIT_AURA")) then self:UnregisterEvent("UNIT_AURA") end
	if(self:IsEventRegistered("UNIT_FACTION")) then self:UnregisterEvent("UNIT_FACTION") end
	if(self:IsEventRegistered("PLAYER_TARGET_CHANGED")) then self:UnregisterEvent("PLAYER_TARGET_CHANGED") end

	self:LevelDebug(3, "Disabling timers")
	self:StopMetro("UpdateTargetTarget")
	self:StopMetro("UpdatePetNamePlate")
	self:StopMetro("CheckNamePlateMouseOver")
	self:UnregisterMetro("Enable_player")
	self:UnregisterMetro("Enable_pet")

	self:LevelDebug(3, "Hiding frames")
	for i=1,16 do
		getglobal(self.TargetHUD.frame.."Buff"..i):Hide()
		getglobal(self.TargetHUD.frame.."DeBuff"..i):Hide()
	end
	self.TargetHUD:Hide()
	self.NamePlates.Player:Hide()
	self.NamePlates.Pet:Hide()
end

function ArcHUD:ResetOptionsConfirm()
	self:ResetDB("profile")
	self:OnProfileDisable()
	self:OnProfileEnable()
	self:TriggerEvent("ARCHUD_MODULE_UPDATE")
	self:Print(L"TEXT_RESET_CONFIRM")
end

function ArcHUD:InitNamePlate(frame)
	local this = self.NamePlates[frame]

	this:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up")

	this.OnClick = function(self)
		if(ArcHUD_CustomClick) then
			ArcHUD_CustomClick(arg1, self.unit)
		else
			if(SpellIsTargeting()) then
				SpellStopTargeting()
				return
			end
			if(arg1 == "LeftButton") then
				TargetUnit(self.unit)
			elseif(arg1 == "RightButton") then
				ToggleDropDownMenu(1, nil, getglobal(ArcHUD:strcap(self.unit).."FrameDropDown"), "cursor", 0, 0)
			end
		end
	end
	this.OnEnter = function(self)
		if(SpellIsTargeting()) then
			if (SpellCanTargetUnit(self.unit)) then
				SetCursor("CAST_CURSOR")
			else
				SetCursor("CAST_ERROR_CURSOR")
			end
		end
		GameTooltip:SetOwner(self, ANCHOR_BOTTOMRIGHT)
		GameTooltip:SetUnit(self.unit)
		GameTooltip:Show()
	end
	this.OnLeave = function(self)
		if(SpellIsTargeting()) then
			SetCursor("CAST_ERROR_CURSOR")
		end
		if(GameTooltip:IsOwned(self)) then
			GameTooltip:Hide()
		end
	end

	if(frame ~= "Target" and frame ~= "TargetTarget" and frame ~= "TargetTargetTarget") then
		self:RegisterMetro(frame.."Alpha", ArcHUDRingTemplate.AlphaUpdate, 0.01, this)
		self:StartMetro(frame.."Alpha")

		this.fadeIn = 0.25
		this.fadeOut = 0.25

		ArcHUDRingTemplate.SetRingAlpha(this, self.db.profile.FadeFull)
	else
		this.Enabled = TRUE
	end
end

function ArcHUD:CheckNamePlateMouseOver()
	if(MouseIsOver(self.NamePlates.Player)) then
		if(not self.NamePlates.Player.Started) then
			ArcHUDRingTemplate.SetRingAlpha(self.NamePlates.Player, 1.0)
			self.NamePlates.Player.Started = true
			self:StartMetro("Enable_player")
		end
	else
		if(self.NamePlates.Player.Started) then
			ArcHUDRingTemplate.SetRingAlpha(self.NamePlates.Player, self.db.profile.FadeFull)
			self:StopMetro("Enable_player")
			self.NamePlates.Player.Started = false
			self.NamePlates.Player:EnableMouse(false)
			self.NamePlates.Player:SetToplevel(false)
		end
	end

	-- Check pet nameplate
	if(not UnitExists("pet")) then
		return
	end
	if(MouseIsOver(self.NamePlates.Pet)) then
		if(not self.NamePlates.Pet.Started) then
			ArcHUDRingTemplate.SetRingAlpha(self.NamePlates.Pet, 1.0)
			self.NamePlates.Pet.Started = true
			self:StartMetro("Enable_pet")
		end
	else
		if(self.NamePlates.Pet.Started) then
			ArcHUDRingTemplate.SetRingAlpha(self.NamePlates.Pet, self.db.profile.FadeFull)
			self:StopMetro("Enable_pet")
			self.NamePlates.Pet.Started = false
			self.NamePlates.Pet:EnableMouse(false)
			self.NamePlates.Pet:SetToplevel(false)
		end
	end
end

function ArcHUD:EnableDisableNameplate(unit)
	self.NamePlates[unit]:EnableMouse(true)
	self.NamePlates[unit]:SetToplevel(true)
	self:StopMetro("Enable_"..string.lower(unit))
	if(self.db.profile.HoverMsg) then
		self:Print("Enabling mouse input for "..unit)
	end
end

function ArcHUD:TargetUpdate()
	-- Make sure we are targeting someone and that ArcHUD is enabled
	if (UnitExists("target") and self.db.profile.TargetFrame) then
		-- 3D target model
		if((self.db.profile.PlayerModel and UnitIsPlayer("target")) or (self.db.profile.MobModel and not UnitIsPlayer("target"))) then
			self.TargetHUD.Model:Show()
			self.TargetHUD.Model:SetUnit("target")
		else
			self.TargetHUD.Model:Hide()
		end
		self.TargetHUD:Show()

		if(UnitIsDead("target") or UnitIsGhost("target")) then
			self.TargetHUD.HPText:SetText("Dead")
		else
			-- Support for MobHealth3
			if(MobHealth3) then
				local cur, max, found = MobHealth3:GetUnitHealth("target", UnitHealth("target"), UnitHealthMax("target"))
				self.TargetHUD.HPText:SetText(cur.."/"..max)
			-- Support for MobHealth2 / MobInfo-2
			elseif(self:MobHealth_GetTargetCurHP()) then
				self.TargetHUD.HPText:SetText(self:MobHealth_GetTargetCurHP().."/"..self:MobHealth_GetTargetMaxHP())
			else
				self.TargetHUD.HPText:SetText(UnitHealth("target").."/"..UnitHealthMax("target"))
			end
		end

		-- Does the unit have mana? If so we want to show it
		if (UnitManaMax("target") > 0) then
			self.TargetHUD.MPText:SetText(UnitMana("target").."/"..UnitManaMax("target"))
		else
			self.TargetHUD.MPText:SetText(" ")
		end

		local addtolevel = ""
		if(self.db.profile.ShowClass) then
			addtolevel = " " .. (UnitIsPlayer("target") and UnitClass("target") or UnitCreatureFamily("target") or UnitCreatureType("target"))
			self.TargetHUD.Level:SetJustifyH("CENTER")
		else
			self.TargetHUD.Level:SetJustifyH("LEFT")
		end
		-- What kind of target is it? If UnitLevel returns negative we have a target whose
		--   level are too high to show or a boss
		if (UnitLevel("target") < 0) then
			if ( UnitClassification("target") == "worldboss" ) then
				self.TargetHUD.Level:SetText("Boss" .. addtolevel)
			else
				self.TargetHUD.Level:SetText("L??" .. addtolevel)
			end
		else
			-- Make sure we mark elites with a + after the level
			if(not string.find(UnitClassification("target"), "elite")) then
				self.TargetHUD.Level:SetText("L" .. UnitLevel("target") .. addtolevel)
			else
				self.TargetHUD.Level:SetText("L" .. UnitLevel("target") .. "+" .. addtolevel)
			end
		end

		-- Check if the target is friendly to the player
		targetfriend = UnitIsFriend("player","target")

		-- Color the level display based on the targets level in relation
		--  to player level
		if (targetfriend) then
			self.TargetHUD.Level:SetTextColor(1, 0.9, 0)
		elseif (UnitIsTrivial("target")) then
			self.TargetHUD.Level:SetTextColor(0.7, 0.7, 0.7)
		elseif (UnitLevel("target") == -1) then
			self.TargetHUD.Level:SetTextColor(1, 0, 0)
		elseif (UnitLevel("target") <= (UnitLevel("player")-3)) then
			self.TargetHUD.Level:SetTextColor(0, 0.9, 0)
		elseif (UnitLevel("target") >= (UnitLevel("player")+5)) then
			self.TargetHUD.Level:SetTextColor(1, 0, 0)
		elseif (UnitLevel("target") >= (UnitLevel("player")+3)) then
			self.TargetHUD.Level:SetTextColor(1, 0.5, 0)
		else
			self.TargetHUD.Level:SetTextColor(1, 0.9, 0)
		end

		-- Color the targets hp and mana text correctly
		local info = {}
		if (UnitPowerType("target") == 0) then
			info = { r = 0.00, g = 1.00, b = 1.00 }
		else
			info = ManaBarColor[UnitPowerType("target")]
		end
		self.TargetHUD.MPText:SetTextColor(info.r, info.g, info.b)

		if(targetfriend) then
			self.TargetHUD.HPText:SetTextColor(0, 1, 0)
		else
			self.TargetHUD.HPText:SetTextColor(1, 0, 0)
		end

		-- The name of the target should be colored differently if it's a player or if
		--   it's a mob
		local _, class = UnitClass("target")
		local color = self.ClassColor[class]
		if (color and UnitIsPlayer("target")) then
			-- Is target in a guild?
			local guild, _, _ = GetGuildInfo("target")

			-- Color the target name based on class since we have a player targeted
			if(guild and ArcHUD.db.profile.ShowGuild) then
				self.TargetHUD.Name:SetText("|cff"..color..UnitName("target").." <"..guild..">".."|r")
			else
				self.TargetHUD.Name:SetText("|cff"..color..UnitName("target").."|r")
			end
		else
			-- Color the target name based on reaction (red to green) since we have a
			--   mob targeted
			local reaction = self.RepColor[UnitReaction("target","player")]
			if(reaction) then
				self.TargetHUD.Name:SetText("|cff"..reaction..UnitName("target").."|r")
			else
				self.TargetHUD.Name:SetText(UnitName("target"))
			end
		end

		-- Show clickable nameplate only if the target is a friendly player and not self
		--[[if(UnitIsPlayer("target") and targetfriend and not UnitIsUnit("player", "target")) then
			self.NamePlates.Target:Show()
		else
			self.NamePlates.Target:Hide()
		end]]

		if(self.db.profile.ShowBuffs) then
			-- Update buffs and debuffs for the target
			self:TargetAuras()
		end

		self:UpdateFaction("target")
		self:UpdateRaidTargetIcon()
		self:PLAYER_FLAGS_CHANGED("target")

		if(self.BlizzTargetHidden) then
			if(UnitIsEnemy("target", "player")) then
				PlaySound("igCreatureAggroSelect")
			elseif(UnitIsFriend("player", "target")) then
				PlaySound("igCharacterNPCSelect")
			else
				PlaySound("igCreatureNeutralSelect")
			end
		end
	else
		-- We didn't have anything targeted or ArcHUD is disabled so lets hide the
		--   target frame again
		if(self.BlizzTargetHidden) then
			PlaySound("INTERFACESOUND_LOSTTARGETUNIT")
		end
		self.TargetHUD:Hide()
	end
end

function ArcHUD:UpdateFaction(unit)
	self:LevelDebug(2, "UpdateFaction: arg1 = %s, unit = %s", arg1 or "nil", unit or "nil")

	if(not unit and arg1 and arg1 ~= "player") then return end
	if(arg1 and not unit) then unit = arg1 end

	if(unit and unit == "target") then
		local factionGroup = UnitFactionGroup("target")
		if(UnitIsPVPFreeForAll("target")) then
			self.TargetHUD.PVPIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA")
			self.TargetHUD.PVPIcon:Show()
		elseif(factionGroup and UnitIsPVP("target")) then
			self.TargetHUD.PVPIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..factionGroup)
			self.TargetHUD.PVPIcon:Show()
		else
			self.TargetHUD.PVPIcon:Hide()
		end
	else
		local factionGroup, factionName = UnitFactionGroup("player");
		local _, class = UnitClass("player")
		local color = self.ClassColor[class]
		if(UnitIsPVPFreeForAll("player")) then
			self.NamePlates.Player.Text:SetText("|cffffff00[FFA] |cff"..(color or "ffffff")..(UnitName("player") or "Unknown Entity").."|r")
		elseif(factionGroup and UnitIsPVP("player")) then
			self.NamePlates.Player.Text:SetText("|cffff0000[PVP] |cff"..(color or "ffffff")..(UnitName("player") or "Unknown Entity").."|r")
		else
			self.NamePlates.Player.Text:SetText("|cff"..(color or "ffffff")..(UnitName("player") or "Unknown Entity").."|r")
		end
	end
end

function ArcHUD:UpdateRaidTargetIcon()
	if(not UnitExists("target")) then self.TargetHUD.RaidTargetIcon:Hide() return end

	local index = GetRaidTargetIndex("target")
	if(index) then
		SetRaidTargetIconTexture(self.TargetHUD.RaidTargetIcon, index)
		self.TargetHUD.RaidTargetIcon:Show()
	else
		self.TargetHUD.RaidTargetIcon:Hide()
	end
end

function ArcHUD:PLAYER_FLAGS_CHANGED(unit)
	if(arg1 and not unit) then unit = arg1 end
	if(not UnitExists("target")) then self.TargetHUD.LeaderIcon:Hide() return end

	if(unit == "target") then
		if(UnitIsPartyLeader("target")) then
			self.TargetHUD.LeaderIcon:Show()
		else
			self.TargetHUD.LeaderIcon:Hide()
		end
	end
end

function ArcHUD:TargetAuras()
	if(not arg1 == "target") then return end
	local frame = self.TargetHUD.frame
	local unit = "target"
	local i, icon, buff, debuff, debuffborder, debuffcount, debuffType, color
	for i = 1, 16 do
		buff = UnitBuff(unit, i)
		button = getglobal(frame.."Buff"..i)
		if (buff) then
			icon = getglobal(button:GetName().."Icon")
			icon:SetTexture(buff)
			button:Show()
			button.unit = unit
		else
			button:Hide()
		end
	end

	for i = 1, 16 do
		debuff, debuffApplications, debuffType = UnitDebuff(unit, i)
		button = getglobal(frame.."DeBuff"..i)
		if (debuff) then
			icon = getglobal(button:GetName().."Icon")
			debuffborder = getglobal(button:GetName().."Border")
			debuffcount = getglobal(button:GetName().."Count")
			icon:SetTexture(debuff)
			button:Show()
			debuffborder:Show()
			button.isdebuff = 1
			button.unit = unit
			if ( debuffType ) then
				color = DebuffTypeColor[debuffType]
			else
				color = DebuffTypeColor["none"]
			end
			debuffborder:SetVertexColor(color.r, color.g, color.b)
			if (debuffApplications > 1) then
				debuffcount:SetText(debuffApplications)
				debuffcount:Show()
			else
				debuffcount:Hide()
			end
		else
			button:Hide()
		end
	end
end

function ArcHUD:SetAuraTooltip(this)
	if (not this:IsVisible()) then return end
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT")
	local unit = this.unit
	if (this.isdebuff == 1) then
		GameTooltip:SetUnitDebuff(unit, this:GetID())
	else
		GameTooltip:SetUnitBuff(unit, this:GetID())
	end
end

function ArcHUD:EventHandler()
	if (event == "UNIT_DISPLAYPOWER") then
		local info = {}
		if (arg1 == "target") then
			if (UnitPowerType(arg1) == 0) then
				info = { r = 0.00, g = 1.00, b = 1.00 }
			else
				info = ManaBarColor[UnitPowerType(arg1)]
			end
			self.TargetHUD.MPText:SetTextColor(info.r, info.g, info.b)
		end
	elseif (event == "PLAYER_COMBO_POINTS") then
		local points = GetComboPoints()
		if (points > 0) then
			self.TargetHUD.Combo:SetText(points)
		else
			self.TargetHUD.Combo:SetText("")
		end
	elseif (event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH") then
		if (arg1 == "target") then
			-- Support for MobHealth3
			if(MobHealth3) then
				local cur, max, found = MobHealth3:GetUnitHealth(arg1, UnitHealth(arg1), UnitHealthMax(arg1))
				self.TargetHUD.HPText:SetText(cur.."/"..max)
			-- Support for MobHealth2 / MobInfo-2
			elseif(self:MobHealth_GetTargetCurHP()) then
				self.TargetHUD.HPText:SetText(self:MobHealth_GetTargetCurHP().."/"..self:MobHealth_GetTargetMaxHP())
			else
				self.TargetHUD.HPText:SetText(UnitHealth(arg1).."/"..UnitHealthMax(arg1))
			end
		end
	elseif(event == "PLAYER_ENTERING_WORLD") then
		self.PlayerIsInCombat = false
		self.PlayerIsRegenOn = true
	else
		if (arg1 == "target") then
			self.TargetHUD.MPText:SetText(UnitMana(arg1).."/"..UnitManaMax(arg1))
		end
	end
end

function ArcHUD:CombatStatus()
	self:LevelDebug(2, "CombatStatus: event = " .. event)
	if(event == "PLAYER_ENTER_COMBAT" or event == "PLAYER_REGEN_DISABLED") then
		self.PlayerIsInCombat = true
		if(event == "PLAYER_REGEN_DISABLED") then
			self.PlayerIsRegenOn = false
		end
	elseif(event == "PLAYER_LEAVE_COMBAT" or event == "PLAYER_REGEN_ENABLED") then
		if(event == "PLAYER_LEAVE_COMBAT" and self.PlayerIsRegenOn) then
			self.PlayerIsInCombat = false
		elseif(event == "PLAYER_REGEN_ENABLED") then
			self.PlayerIsInCombat = false
			self.PlayerIsRegenOn = true
		end
	elseif(event == "PET_ATTACK_START") then
		self.PetIsInCombat = true
	elseif(event == "PET_ATTACK_STOP") then
		self.PetIsInCombat = false
	end
end

function ArcHUD:UpdatePetNamePlate()
	if(UnitExists("pet")) then
		local happiness, _, _ = GetPetHappiness()
		local color
		if(happiness) then
			if(happiness == 1) then
				color = "ff0000"
				happiness = " :("
			elseif(happiness == 2) then
				color = "ffff00"
				happiness = " :||"
			elseif(happiness == 3) then
				color = "00ff00"
				happiness = " :)"
			end
		else
			color = "ffffff"
			happiness = ""
		end
		self.NamePlates.Pet.Text:SetText("|cff"..color..UnitName("pet").." "..happiness.."|r")
		self.NamePlates.Pet:Show()
	else
		self.NamePlates.Pet:Hide()
	end
end

function ArcHUD:UpdateTargetTarget()
	-- Handle Target's Target
	if(UnitExists("targettarget") and self.db.profile.TargetTarget) then
		local _, class = UnitClass("targettarget")
		local color = self.ClassColor[class]
		if (color and UnitIsPlayer("targettarget")) then
				self.TargetHUD.Target.Name:SetText("|cff"..color..UnitName("targettarget").."|r")
		else
			local reaction = self.RepColor[UnitReaction("targettarget","player")]
			if(reaction) then
				self.TargetHUD.Target.Name:SetText("|cff"..reaction..UnitName("targettarget").."|r")
			else
				self.TargetHUD.Target.Name:SetText(UnitName("targettarget"))
			end
		end

		local info = {}
		if (UnitPowerType("targettarget") == 0) then
			info = { r = 0.00, g = 1.00, b = 1.00 }
		else
			info = ManaBarColor[UnitPowerType("targettarget")]
		end
		self.TargetHUD.Target.MPText:SetTextColor(info.r, info.g, info.b)

		if(UnitIsFriend("player","targettarget")) then
			self.TargetHUD.Target.HPText:SetTextColor(0, 1, 0)
		else
			self.TargetHUD.Target.HPText:SetTextColor(1, 0, 0)
		end
		if(UnitIsDead("targettarget") or UnitIsGhost("targettarget")) then
			self.TargetHUD.Target.HPText:SetText("Dead")
		else
			self.TargetHUD.Target.HPText:SetText(math.floor(UnitHealth("targettarget")/UnitHealthMax("targettarget")*100).."%")
		end

		if (UnitManaMax("targettarget") > 0) then
			self.TargetHUD.Target.MPText:SetText(math.floor(UnitMana("targettarget")/UnitManaMax("targettarget")*100).."%")
		else
			self.TargetHUD.Target.MPText:SetText(" ")
		end
		self.TargetHUD.Target:Show()
	else
		self.TargetHUD.Target:Hide()
	end

	-- Handle Target's Target's Target
	if(UnitExists("targettargettarget") and self.db.profile.TargetTargetTarget) then
		local _, class = UnitClass("targettargettarget")
		local color = self.ClassColor[class]
		if (color and UnitIsPlayer("targettargettarget")) then
				self.TargetHUD.TargetTarget.Name:SetText("|cff"..color..UnitName("targettargettarget").."|r")
		else
			local reaction = self.RepColor[UnitReaction("targettargettarget","player")]
			if(reaction) then
				self.TargetHUD.TargetTarget.Name:SetText("|cff"..reaction..UnitName("targettargettarget").."|r")
			else
				self.TargetHUD.TargetTarget.Name:SetText(UnitName("targettargettarget"))
			end
		end

		local info = {}
		if (UnitPowerType("targettargettarget") == 0) then
			info = { r = 0.00, g = 1.00, b = 1.00 }
		else
			info = ManaBarColor[UnitPowerType("targettargettarget")]
		end
		self.TargetHUD.TargetTarget.MPText:SetTextColor(info.r, info.g, info.b)

		if(UnitIsFriend("player","targettargettarget")) then
			self.TargetHUD.TargetTarget.HPText:SetTextColor(0, 1, 0)
		else
			self.TargetHUD.TargetTarget.HPText:SetTextColor(1, 0, 0)
		end
		if(UnitIsDead("targettargettarget") or UnitIsGhost("targettargettarget")) then
			self.TargetHUD.TargetTarget.HPText:SetText("Dead")
		else
			self.TargetHUD.TargetTarget.HPText:SetText(math.floor(UnitHealth("targettargettarget")/UnitHealthMax("targettargettarget")*100).."%")
		end

		if (UnitManaMax("targettargettarget") > 0) then
			self.TargetHUD.TargetTarget.MPText:SetText(math.floor(UnitMana("targettargettarget")/UnitManaMax("targettargettarget")*100).."%")
		else
			self.TargetHUD.TargetTarget.MPText:SetText(" ")
		end
		self.TargetHUD.TargetTarget:Show()
	else
		self.TargetHUD.TargetTarget:Hide()
	end
end

function ArcHUD:UpdateFonts(tbl)
	local update = false
    for k,v in pairs(tbl) do
        if(type(v) == "table") then
			if(v.GetFont) then
				local fontName, fontSize, fontFlags = v:GetFont()
				if(fontName) then
					self:LevelDebug(2, "UpdateFonts: fontName = %s, localeFont = %s", fontName, L"FONT")
				end
				if(fontName and not string.find(fontName, L"FONT")) then
					v:SetFont("Fonts\\"..L"FONT", fontSize, fontFlags)
					update = true
				end
			end
            self:UpdateFonts(v)
        end
    end
	if(update) then
		self:LevelDebug(3, "Fonts updated")
	end
end


-- MobInfo-2 mob health code
--------------------------------
function ArcHUD:MobHealth_PPP(index)
  if(MobHealth_PPP) then
    return MobHealth_PPP( index );
  else
	if( index and MobHealthDB[index] ) then
		local s, e, pts, pct = string.find(MobHealthDB[index], "^(%d+)/(%d+)$");
		if( pts and pct ) then
			pts = pts + 0;
			pct = pct + 0;
			if( pct ~= 0 ) then
				return pts / pct;
			end
		end
	end
	return 0;
  end
end  -- of My_MobHealth_PPP

function ArcHUD:MobHealth_GetTargetCurHP()
	if(MobHealthFrame) then
		if(MobHealth_GetTargetCurHP) then
			return MobHealth_GetTargetCurHP();
		else
			local name  = UnitName("target");
			local level = UnitLevel("target");
			local healthPercent = UnitHealth("target");
			if  name  and  level  and  healthPercent  then
				local index = name..":"..level;
				local ppp = self:MobHealth_PPP( index );
				return math.floor( healthPercent * ppp + 0.5);
			end
		end
	end
	return nil;
end  -- of MobHealth_GetTargetCurHP()

function ArcHUD:MobHealth_GetTargetMaxHP()
	if(MobHealthFrame) then
		if(MobHealth_GetTargetMaxHP) then
			return MobHealth_GetTargetMaxHP();
		else
			local name  = UnitName("target");
			local level = UnitLevel("target");
			if  name  and  level  then
				local index = name..":"..level;
				local ppp = self:MobHealth_PPP( index );
				return math.floor( 100 * ppp + 0.5);
			end
		end
	end
	return nil;
end  -- of MobHealth_GetTargetMaxHP()


-- Blizzard Frame functions
-- Taken from AceUnitFrames
function ArcHUD:HideBlizzardPlayer(hide)
	self.BlizzPlayerHidden = not hide
	if not hide then
		PlayerFrame:UnregisterAllEvents()
		PlayerFrameHealthBar:UnregisterAllEvents()
		PlayerFrameManaBar:UnregisterAllEvents()
		PlayerFrame:Hide()

		PetFrame:UnregisterAllEvents()
		PetFrameHealthBar:UnregisterAllEvents()
		PetFrameManaBar:UnregisterAllEvents()
		PetFrame:Hide()
	else
		PlayerFrame:RegisterEvent("UNIT_LEVEL")
		PlayerFrame:RegisterEvent("UNIT_COMBAT")
		PlayerFrame:RegisterEvent("UNIT_PVP_UPDATE")
		PlayerFrame:RegisterEvent("UNIT_MAXMANA")
		PlayerFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
		PlayerFrame:RegisterEvent("PLAYER_ENTER_COMBAT")
		PlayerFrame:RegisterEvent("PLAYER_LEAVE_COMBAT")
		PlayerFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
		PlayerFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
		PlayerFrame:RegisterEvent("PLAYER_UPDATE_RESTING")
		PlayerFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
		PlayerFrame:RegisterEvent("PARTY_LEADER_CHANGED")
		PlayerFrame:RegisterEvent("PARTY_LOOT_METHOD_CHANGED")
		PlayerFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
		PlayerFrame:RegisterEvent("RAID_ROSTER_UPDATE")
		PlayerFrame:RegisterEvent("PLAYTIME_CHANGED")
		PlayerFrame:RegisterEvent("UNIT_NAME_UPDATE")
		PlayerFrame:RegisterEvent("UNIT_PORTRAIT_UPDATE")
		PlayerFrame:RegisterEvent("UNIT_DISPLAYPOWER")
		PlayerFrameHealthBar:RegisterEvent("CVAR_UPDATE")
		PlayerFrameHealthBar:RegisterEvent("UNIT_HEALTH")
		PlayerFrameHealthBar:RegisterEvent("UNIT_MAXHEALTH")
		PlayerFrameManaBar:RegisterEvent("CVAR_UPDATE")
		PlayerFrameManaBar:RegisterEvent("UNIT_MANA")
		PlayerFrameManaBar:RegisterEvent("UNIT_RAGE")
		PlayerFrameManaBar:RegisterEvent("UNIT_FOCUS")
		PlayerFrameManaBar:RegisterEvent("UNIT_ENERGY")
		PlayerFrameManaBar:RegisterEvent("UNIT_HAPPINESS")
		PlayerFrameManaBar:RegisterEvent("UNIT_MAXMANA")
		PlayerFrameManaBar:RegisterEvent("UNIT_MAXRAGE")
		PlayerFrameManaBar:RegisterEvent("UNIT_MAXFOCUS")
		PlayerFrameManaBar:RegisterEvent("UNIT_MAXENERGY")
		PlayerFrameManaBar:RegisterEvent("UNIT_MAXHAPPINESS")
		PlayerFrameManaBar:RegisterEvent("UNIT_DISPLAYPOWER")
		PlayerFrame:Show()

		PetFrame:RegisterEvent("UNIT_PET")
		PetFrame:RegisterEvent("UNIT_COMBAT")
		PetFrame:RegisterEvent("UNIT_AURA")
		PetFrame:RegisterEvent("PET_ATTACK_START")
		PetFrame:RegisterEvent("PET_ATTACK_STOP")
		PetFrame:RegisterEvent("UNIT_HAPPINESS")
		PetFrame:RegisterEvent("UNIT_NAME_UPDATE")
		PetFrame:RegisterEvent("UNIT_PORTRAIT_UPDATE")
		PetFrame:RegisterEvent("UNIT_DISPLAYPOWER")
		PetFrameHealthBar:RegisterEvent("CVAR_UPDATE")
		PetFrameHealthBar:RegisterEvent("UNIT_HEALTH")
		PetFrameHealthBar:RegisterEvent("UNIT_MAXHEALTH")
		PetFrameManaBar:RegisterEvent("CVAR_UPDATE")
		PetFrameManaBar:RegisterEvent("UNIT_MANA")
		PetFrameManaBar:RegisterEvent("UNIT_RAGE")
		PetFrameManaBar:RegisterEvent("UNIT_FOCUS")
		PetFrameManaBar:RegisterEvent("UNIT_ENERGY")
		PetFrameManaBar:RegisterEvent("UNIT_HAPPINESS")
		PetFrameManaBar:RegisterEvent("UNIT_MAXMANA")
		PetFrameManaBar:RegisterEvent("UNIT_MAXRAGE")
		PetFrameManaBar:RegisterEvent("UNIT_MAXFOCUS")
		PetFrameManaBar:RegisterEvent("UNIT_MAXENERGY")
		PetFrameManaBar:RegisterEvent("UNIT_MAXHAPPINESS")
		PetFrameManaBar:RegisterEvent("UNIT_DISPLAYPOWER")
	end
end

function ArcHUD:HideBlizzardTarget(hide)
	self.BlizzTargetHidden = not hide
	if not hide then
		TargetFrame:UnregisterAllEvents()
		TargetFrameHealthBar:UnregisterAllEvents()
		TargetFrameManaBar:UnregisterAllEvents()
		TargetFrame:Hide()

		ComboFrame:UnregisterAllEvents()
	else
		TargetFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
		TargetFrame:RegisterEvent("UNIT_HEALTH")
		TargetFrame:RegisterEvent("UNIT_LEVEL")
		TargetFrame:RegisterEvent("UNIT_FACTION")
		TargetFrame:RegisterEvent("UNIT_CLASSIFICATION_CHANGED")
		TargetFrame:RegisterEvent("UNIT_AURA")
		TargetFrame:RegisterEvent("PLAYER_FLAGS_CHANGED")
		TargetFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
		TargetFrame:RegisterEvent("UNIT_NAME_UPDATE")
		TargetFrame:RegisterEvent("UNIT_PORTRAIT_UPDATE")
		TargetFrame:RegisterEvent("UNIT_DISPLAYPOWER")
		TargetFrameHealthBar:RegisterEvent("CVAR_UPDATE")
		TargetFrameHealthBar:RegisterEvent("UNIT_HEALTH")
		TargetFrameHealthBar:RegisterEvent("UNIT_MAXHEALTH")
		TargetFrameManaBar:RegisterEvent("CVAR_UPDATE")
		TargetFrameManaBar:RegisterEvent("UNIT_MANA")
		TargetFrameManaBar:RegisterEvent("UNIT_RAGE")
		TargetFrameManaBar:RegisterEvent("UNIT_FOCUS")
		TargetFrameManaBar:RegisterEvent("UNIT_ENERGY")
		TargetFrameManaBar:RegisterEvent("UNIT_HAPPINESS")
		TargetFrameManaBar:RegisterEvent("UNIT_MAXMANA")
		TargetFrameManaBar:RegisterEvent("UNIT_MAXRAGE")
		TargetFrameManaBar:RegisterEvent("UNIT_MAXFOCUS")
		TargetFrameManaBar:RegisterEvent("UNIT_MAXENERGY")
		TargetFrameManaBar:RegisterEvent("UNIT_MAXHAPPINESS")
		TargetFrameManaBar:RegisterEvent("UNIT_DISPLAYPOWER")
		--if(UnitExists("target")) then
			--TargetFrame:Show()
		--end
		this = TargetFrame
		TargetFrame_Update()

		ComboFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
		ComboFrame:RegisterEvent("PLAYER_COMBO_POINTS")
	end
end
