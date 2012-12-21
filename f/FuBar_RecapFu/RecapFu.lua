local loc = RecapFu.locals
local const = RecapFu.constants
local tablet = TabletLib:GetInstance('1.0')
local dewdrop = DewdropLib:GetInstance('1.0')
local compost = CompostLib:GetInstance('compost-1')
local metro = Metrognome:GetInstance('1')

compost:Reclaim(RecapFu)
RecapFu = nil

RecapFu = FuBarPlugin:GetInstance("1.2"):new({
   name          = const.Title,
   description   = loc.Desc,
   version       = "0.5.1",
   releaseDate   = string.sub("$Date: 2006-05-18 19:36:02 -0400 (Thu, 18 May 2006) $", 8, 17),
   author        = "Prandur",
   website       = "http://prandur.wowinterface.com",
   aceCompatible = 103,
   category      = "combat",
   db            = AceDatabase:new("RecapFuDB"),
   defaults      = {
   	showlabel = true,
   	DPS = true,
   },
   cmd           = AceChatCmd:new(const.Cmd, const.Cmd_Opt),
   hasIcon       = "Interface\\AddOns\\Recap\\Recap-Status",
})

function RecapFu:Initialize()
end

function RecapFu:Enable()
	self.text = compost:Acquire()
	metro:Register(self.name, self.Update, 1, self)
	metro:Start(self.name)
end

function RecapFu:Disable()
	self.state = "n/a"
	self.yourdps = "n/a"
	self.dpsin = "n/a"
	self.dpsout = "n/a"
	self.healing = "n/a"
	self.overheal = "n/a"
	self.maxhit = "n/a"
	self.totaldps = "n/a"
	self.totaldpsin = "n/a"
	self.viewtype = "n/a"
	
	metro:Unregister(self.name)
	compost:Reclaim(self.text)
end

function RecapFu:OnClick()
	RecapFrame_Toggle()
end

function RecapFu:UpdateData()
	self:debug("Update Data")
	if recap.Opt then
		if recap.Opt.State then
			self.state = recap.Opt.State.value or "n/a"
		else
			self.state = "n/a"
		end
		if recap.Opt.View and recap_temp.Local.LastAll then
			self.viewtype = recap_temp.Local.LastAll[recap.Opt.View.value] or "n/a"
		else
			self.viewtype = "n/a"
		end
	else
		self.state = "n/a"
		self.viewtype = "n/a"
	end
	self.yourdps = RecapMinYourDPS_Text:GetText() or "n/a"
	self.dpsin = RecapMinDPSIn_Text:GetText() or "n/a"
	self.dpsout = RecapMinDPSOut_Text:GetText() or "n/a"
	self.healing = RecapTotals_Heal:GetText() or 0
	self.overheal = RecapTotals_Over:GetText() or 0
	self.maxhit = RecapTotals_MaxHit:GetText() or "n/a"
	self.totaldps = RecapTotals_DPS:GetText() or "n/a"
	self.totaldpsin = RecapTotals_DPSIn:GetText() or "n/a"
	
	self.text.DPS = FuBarUtils.White(self.yourdps)
	self.text.DPS_IN = FuBarUtils.Red(self.dpsin)
	self.text.DPS_OUT = FuBarUtils.Green(self.dpsout)
	self.text.HEALING = FuBarUtils.Colorize("00ffff", self.healing)
	self.text.OVERHEAL = FuBarUtils.Colorize("00ffff", self.overheal)
	self.text.MAXHIT = FuBarUtils.Orange(self.maxhit)
end

function RecapFu:UpdateText()
	self:debug("Update Text")
	-- format the colored status bubble
	if (self:IsIconShown()) then
		if self.state=="Idle" then
			self.iconFrame:SetVertexColor(.5,.5,.5)
		elseif self.state=="Active" then
			self.iconFrame:SetVertexColor(0,1,0)
		elseif self.state=="Stopped" then
			self.iconFrame:SetVertexColor(1,0,0)
		end
	end

	local t = compost:Acquire()
	table.insert(t, self.data.showlabel and loc.BUTTON.LABEL or "")
	
	for i,e in self:pairsByKeys(const.TYPES) do
		if self.data[e] then
			table.insert(t, self.text[e])
		end
	end
	
	self:SetText(table.concat(t, " "))
	compost:Reclaim(t)
end

function RecapFu:UpdateTooltip()
	self:debug("Update Tooltip")
	local cat = tablet:AddCategory(
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 1
	)
	cat:AddLine('text', loc.TOOLTIP.STATE, 'text2', self.state)
	cat:AddLine('text', loc.TOOLTIP.VIEW_TYPE, 'text2', self.viewtype)
	
	local cat = tablet:AddCategory(
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0
	)
	for i,e in self:pairsByKeys(const.TYPES) do
		cat:AddLine('text', loc.TOOLTIP[e], 'text2', self.text[e])
	end
	tablet:SetHint(loc.BUTTON.HINT_TEXT)
end

function RecapFu:MenuSettings()	
	for i,e in self:pairsByKeys(const.TYPES) do
		local my_e = e
		dewdrop:AddLine(
			'text', loc.BUTTON[my_e],
			'func', function() self:ToggleOption(my_e, true) end,
			'checked', self.data[my_e]
		)
	end
	dewdrop:AddLine()
	if (recap and recap.Opt and recap.Opt.Paused.value == true) then
		dewdrop:AddLine(
			'text', loc.BUTTON.START_TEXT,
			'func', function() 
				Recap_OnClick("Pause")
				self:Update()
			end,
			'closeWhenClicked', true
		)
	else
		dewdrop:AddLine(
			'text', loc.BUTTON.PAUSE_TEXT,
			'func', function()
				Recap_OnClick("Pause")
				self:Update()
			end,
			'closeWhenClicked', true
		)
	end
	dewdrop:AddLine()
	dewdrop:AddLine(
		'text', loc.BUTTON.SHOWLABEL,
		'func', function()
			self:ToggleOption("showlabel", true)
		end,
		'checked', self.data.showlabel
	)
end

function RecapFu:ToggleOption(var, doUpdate)
	self.data[var] = not self.data[var]
	if doUpdate then
		self:Update()
	end
	return self.data[var]
end

function RecapFu:pairsByKeys (t, f)
--taken from an example in the Programming in Lua book
	local a = compost:Acquire()
	for n in pairs(t) do
		table.insert(a, n)
	end
	table.sort(a, f)
	local i = 0      -- iterator variable
	local iter = function ()   -- iterator function
		i = i + 1
		if a[i] == nil then
			return nil
		else
			return a[i], t[a[i]]
		end
	end
	return iter
end

RecapFu:RegisterForLoad()

-- Simulate Titan Panel plugin
-- Necessary or updates to dps data on the plugin
-- may not occur until after combat ends
function TitanPanelRecap_Update()
end