FuBartender2 = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "FuBarPlugin-2.0")

local Tablet = AceLibrary("Tablet-2.0")

FuBartender2.name = "Bartender2"
FuBartender2.version = "2.0." .. string.sub("$Revision: 12402 $", 12, -3)
FuBartender2.date = string.sub("$Date: 2006-09-30 18:58:37 -0400 (Sat, 30 Sep 2006) $", 8, 17)
FuBartender2.hasIcon = "Interface\\Icons\\INV_Drink_05"
FuBartender2.defaultMinimapPosition = 285
FuBartender2.cannotDetachTooltip = true
FuBartender2.hasNoColor = true
FuBartender2.clickableTooltip = false

function FuBartender2:OnInitialize()
	self:RegisterDB("FuBartender2DB")
	Bartender.options.args.fubar = {
			type = "group",
			name = "FuBarPlugin Config",
			desc = "Configure the FuBar Plugin",
			args = {},
		}
		
	AceLibrary("AceConsole-2.0"):InjectAceOptionsTable(self, Bartender.options.args.fubar)
	self.OnMenuRequest = Bartender.options
end

function FuBartender2:OnClick()
	self:LockButtons()
	PlaySoundFile("Sound\\Creature\\Murloc\\mMurlocAggroOld.wav");
end

function FuBartender2:LockButtons()
        if LOCK_ACTIONBAR == "1" then
                LOCK_ACTIONBAR = "0"
                Bartender:Print("ActionBar lock |cffffffcf[|r|cffff0000Off|cffffffcf]|r")
        else
                LOCK_ACTIONBAR = "1"
                Bartender:Print("ActionBar lock |cffffffcf[|r|cff00ff00On|cffffffcf]|r")
        end
end

function FuBartender2:OnTooltipUpdate()
	local cat = Tablet:AddCategory('columns', 2)
	if LOCK_ACTIONBAR == "1" then
		cat:AddLine(	'text', "Buttons:",
								 	'text2', "Locked",
								 	'text2R', 0,
								 	'text2G', 1,
									'text2B', 0)
	else
		cat:AddLine(	'text', "Status:",
								 	'text2', "Unlocked",
								 	'text2R', 1,
								 	'text2G', 0,
									'text2B', 0)
	end
	Tablet:SetHint("Left-click to Lock/Unlock.\nRight-click to configure.")
end
