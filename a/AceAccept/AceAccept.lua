
local ACEACCEPT_DEFAULT_OPTIONS = {
    autoRes		= TRUE,
    autoSummon	= TRUE
}


--[[--------------------------------------------------------------------------------
  Class Setup
-----------------------------------------------------------------------------------]]

AceAccept = AceAddon:new({
    name          = ACEACCEPT.NAME,
    description   = ACEACCEPT.DESCRIPTION,
    version       = "1.0",
    releaseDate   = "22-09-2005",
    aceCompatible = "102",
    author        = "Skyboat",
    email         = "robnadin@blueyonder.co.uk",
    website       = "http://www.skyboat.me.uk",
    category      = ACE_CATEGORY_OTHERS,
    db            = AceDatabase:new("AceAcceptDB"),
    defaults      = ACEACCEPT_DEFAULT_OPTIONS,
    cmd           = AceChatCmd:new(ACEACCEPT.COMMANDS, ACEACCEPT.CMD_OPTIONS)
})

function AceAccept:Initialize()
    self.Get = function(var) return self.db:get(self.profilePath,var)    end
    self.Tog = function(var) return self.db:toggle(self.profilePath,var) end
end


--[[--------------------------------------------------------------------------------
  Addon Enabling/Disabling
-----------------------------------------------------------------------------------]]

function AceAccept:Enable()
	if( self.Get("autoRes") ) then
		self:RegisterEvent("RESURRECT_REQUEST", "Resurrect")
	end
	if( self.Get("autoSummon") ) then
		self:RegisterEvent("CONFIRM_SUMMON", "Summon")
	end
end


--[[--------------------------------------------------------------------------------
  Main Processing
-----------------------------------------------------------------------------------]]

function AceAccept:Resurrect()
    if (GetCorpseRecoveryDelay() == 0) then
		getglobal("StaticPopup1"):Hide()
		AcceptResurrect()
	end
end

function AceAccept:Summon()
	if (UnitAffectingCombat("player") == NIL) then
		getglobal("StaticPopup1"):Hide()
		ConfirmSummon()
	end
end


--[[--------------------------------------------------------------------------------
  Command Handlers
-----------------------------------------------------------------------------------]]

function AceAccept:TogRes()
	if( self.Tog("autoRes") ) then
		self:RegisterEvent("RESURRECT_REQUEST", "Resurrect")
	else
		self:UnregisterEvent("RESURRECT_REQUEST")
	end
	self.cmd:status(ACEACCEPT.AUTORES_TEXT, self.Get("autoRes"), ACEG_MAP_ONOFF)
end

function AceAccept:TogSum()
	if( self.Tog("autoSummon") ) then
		self:RegisterEvent("CONFIRM_SUMMON", "Summon")
	else
		self:UnregisterEvent("CONFIRM_SUMMON")
	end
	self.cmd:status(ACEACCEPT.AUTOSUMMON_TEXT, self.Get("autoSummon"), ACEG_MAP_ONOFF)
end

function AceAccept:Report()
    self.cmd:report({
        {text=ACEACCEPT.AUTORES_TEXT, val=self.Get("autoRes"), map=ACEG_MAP_ONOFF},
        {text=ACEACCEPT.AUTOSUMMON_TEXT, val=self.Get("autoSummon"), map=ACEG_MAP_ONOFF}
    })
end


--[[--------------------------------------------------------------------------------
  Register the Addon
-----------------------------------------------------------------------------------]]

AceAccept:RegisterForLoad()
