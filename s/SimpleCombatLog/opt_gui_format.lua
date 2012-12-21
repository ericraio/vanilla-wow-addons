if not SimpleCombatLog then return end		

local dewdrop = AceLibrary("Dewdrop-2.0")
local defaultFormats = SimpleCombatLog.loc.defaultFormats

local L = SimpleCombatLog.loc.format



SimpleCombatLog.formatList = {
	Combat = {
		"hit", 	"hitCrit", 	"hitDOT", 	"heal", 	"healCrit", 	"healDOT", 	"miss", 	"gain", 	"drain", 	"leech", "environment"
	},
	Spell = {
		"buff", 	"debuff", 	"fade", 	"dispel", 	"dispelFailed", 	"extraattack", 	"cast", 	"castBegin", 	"castTargeted", "interrupt",
	},
	Misc = {	
		"create", 	"death", 	"deathSource", "deathSkill", "honor", 	"honorKill", "dishonor", "experience", 	"reputation",  "reputationRank", "reputationMinus", "enchant", 	"feedpet", 	"fail",
	},
	Trailer = {
		"crushing", "glancing", "absorb", "resist", "block", "vulnerable", "",
		"expSource", "expBonus", "expGroup", "expRaid"
	},
}

function SimpleCombatLog:SetFormat(id, msgType, newFormat)
	if not self.settings[id] then
		self.settings[id] = {}
		self.settingDB[id] = self.settings[id]
	else
		if self.settings[id].theme then
			self.settings[id] = SimpleCombatLog.CopyTable({}, self.settings[id])
			self.settings[id].theme = nil
			self.settingDB[id] = self.settings[id]
		end
	end

	
	if not self.settings[id].formats then
		self.settings[id].formats = {}
	end
	
	self.settings[id].formats[msgType] = newFormat	
end

function SimpleCombatLog:RestoreDefaultFormats(id)
	if self.settings[id] and self.settings[id].formats then
		self.settings[id].formats = nil
	end
end

-- arg1: the format string
-- arg2, arg3, ...  : the tokens to replace with.
function SimpleCombatLog:ConvertFormat(...)
	local msg = string.gsub(table.remove(arg, 1), "|", "||") -- "add slash" so that users can see color codes.	
	for i in pairs(arg) do
		arg[i] = string.format("#%s#", arg[i])
	end
	return string.format(msg, unpack(arg) )
end

-- arg1: the format string
-- arg2, arg3, ...  : the tokens to replace with.
function SimpleCombatLog:UnconvertFormat(...)
	local msg = string.gsub(table.remove(arg, 1), "||", "|") -- "strip slash" to convert back to actual color codes.
	local n = table.getn(arg)
	for i in ipairs(arg) do
		arg[i] = string.format("#%s#", arg[i])
		msg = string.gsub(msg, arg[i], string.format("%%%%%d$s", i) )
	end
	return msg
end

local function UpdateFormatOptionsTable(self, id, level, value)
	if level == 1 then
		dewdrop:AddLine(
			'text', L["Formats"],
			'notCheckable', true,
			'hasArrow', true,
			'value', 'format'
		)		
		
	elseif level == 2 and value == 'format' then
	
		self.currMenuType = 'format'
		
		for i, group in { "Combat", "Spell", "Misc", "Trailer" } do
			dewdrop:AddLine(
				'text', L[group],
				'hasArrow', true,
				'value', group
			)
		end
		
		dewdrop:AddLine()
		dewdrop:AddLine(
			'text', L["Restore default formats"],
			'notCheckable', true,
			'func', function() self:RestoreDefaultFormats(id) end
		)
	
	elseif level == 3 and self.currMenuType == 'format' then
		
		local msgType, formats, isDefault

		for i, v in self.formatList[value] do
			if v ~= "" then
				msgType = v
				formats, isDefault = self:GetFormat(id, v)
				if not isDefault then msgType = self:Colorize(msgType, self.defaultColors.dirty) end
				dewdrop:AddLine(
					'text', msgType,
					'notCheckable', true,
					'hasArrow', true,
					'hasEditBox', true,
					'editBoxText', self:ConvertFormat(formats, unpack(defaultFormats[v][2])),
					'editBoxFunc', function(id, msgType, msgFormat) self:SetFormat(id, msgType, self:UnconvertFormat(msgFormat, unpack(defaultFormats[msgType][2]))) end,
					'editBoxArg1', id,
					'editBoxArg2', v
				)
			else
				dewdrop:AddLine()
			end
		end
	
	end
	
end

if SimpleCombatLog.menuFunc then
	SimpleCombatLog.menuFunc[4] = UpdateFormatOptionsTable
end

