--[[---------------------------------------------------------------------------------
  MyACEPercentage - mailto:instant.gmail.com
------------------------------------------------------------------------------------]]
local DEFAULT_OPTIONS = {
    current = FALSE,
    total = TRUE,
    colour = TRUE
}
--[[---------------------------------------------------------------------------------
  Class Setup
------------------------------------------------------------------------------------]]
MyAcePerc = AceAddon:new({
    name          = "MyAcePercentage",
    description   = MYACEPERC.DESCRIPTION,
    version       = "b.1.7.0",
    releaseDate   = "2005-09-27",
    aceCompatible = "102",
    author        = "instant",
    email         = "instant0@gmail.com",
    website       = "http://www.wowace.com",
    category      = ACE_CATEGORY_INTERFACE,
    db            = AceDbClass:new("MyAcePercDB"),
    defaults      = DEFAULT_OPTIONS,
    cmd           = AceChatCmd:new(MYACEPERC.COMMANDS, MYACEPERC.CMD_OPTIONS)
})

function MyAcePerc:Initialize()
	MYACEPERC_C1 = "|cFFFFFF00"
	MYACEPERC_C2 = "|cFF00FF00"

    self.GetOpt = function(var) return self.db:get(self.profilePath,var)    end
    self.SetOpt = function(var,val) self.db:set(self.profilePath,var,val)   end
    self.TogOpt = function(var) return self.db:toggle(self.profilePath,var) end
end

--[[--------------------------------------------------------------------------------
  Addon Enabling/Disabling
-----------------------------------------------------------------------------------]]
function MyAcePerc:Enable()
    self:HookScript(GameTooltip, "OnShow", "ProcessOnShow")
end

-- Disable() is not needed if all you are doing in Enable() is registering events
-- and hooking functions. Ace will automatically unregister and unhook these.
function MyAcePerc:Disable()
end

--[[--------------------------------------------------------------------------------
  Main Processing
-----------------------------------------------------------------------------------]]
function MyAcePerc:ProcessOnShow()
	-- You should always call the hooked script to give other addons a chance to
	-- process it, unless you must prevent further processing.
    if( GameTooltip:IsVisible() ) then
    	local line2cost, line2costd, tipline2, line2number, line2mana
    	local ttext, dttext, ctext, dctext
    	if( GameTooltipTextLeft2:GetText() ) then
    		tipline2 = GameTooltipTextLeft2:GetText() 
    		line2number = string.find(tipline2, '%d+')
    		if ( line2number == 1 ) then 
    			line2mana = string.find(tipline2, MANA)
				if ( line2mana ) then
					line2cost = string.gsub(GameTooltipTextLeft2:GetText(), string.gsub(MANA_COST, "%%d", ""), "")
					line2costd = tonumber(line2cost)
					if ( self.GetOpt("total") ) then
						ttext = string.format( "%.1f" , ( line2costd/( UnitManaMax('player')/100 ) ) )
						if ( self.GetOpt("colour") ) then
							dttext = MYACEPERC_C1.."("..ttext.."%)"			
						else
							dttext = "(t:"..ttext.."%)"
						end
					end
					if ( self.GetOpt("current") ) then
						ctext = string.format ( "%.1f" , ( line2costd/( UnitMana('player')/100 ) ) )
						if ( self.GetOpt("colour") ) then
							dctext = MYACEPERC_C2.."("..ctext.."%)"
						else
							dctext = "(c:"..ctext.."%)"
						end

					end
					if not ( dctext ) then
						dctext = ""
					end
					if not ( dttext ) then
						dttext = ""
					end
					GameTooltipTextLeft2:SetText( format( MANA_COST,line2cost )..dctext..dttext )
				end
    		end
    	end
    end
	self:CallScript(GameTooltip, "OnShow")
end

--[[---------------------------------------------------------------------------------
  Command Handlers
------------------------------------------------------------------------------------]]
function MyAcePerc:TotalMana()
	-- TogOpt will toggle the value of opt2 in the database to TRUE or FALSE, the
	-- opposite of what it was, and return the new value. status() will display a
	-- message showing the On/Off state based on the value returned by TogOpt().
	-- If the status is TRUE then "On" will be displayed, otherwise "Off".
	self.cmd:status(MYACEPERC.TOTAL_MSG, self.TogOpt("total"), ACEG_MAP_ONOFF)
end

function MyAcePerc:CurrentMana()
	self.cmd:status(MYACEPERC.CURNT_MSG, self.TogOpt("current"), ACEG_MAP_ONOFF)
end

function MyAcePerc:Colour()
	self.cmd:status(MYACEPERC.COLOR_MSG, self.TogOpt("colour"), ACEG_MAP_ONOFF)
end

function MyAcePerc:Report()
    self.cmd:report({
        {text=MYACEPERC.TOTAL_MSG, val=self.GetOpt("total"), map=ACEG_MAP_ONOFF},
        {text=MYACEPERC.CURNT_MSG, val=self.GetOpt("current"), map=ACEG_MAP_ONOFF},
        {text=MYACEPERC.COLOR_MSG, val=self.GetOpt("colour"), map=ACEG_MAP_ONOFF}
    })
end

--[[---------------------------------------------------------------------------------
  Register Addon Object
------------------------------------------------------------------------------------]]
MyAcePerc:RegisterForLoad()
