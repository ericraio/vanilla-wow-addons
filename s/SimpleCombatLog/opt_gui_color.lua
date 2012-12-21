if not SimpleCombatLog then return end

local dewdrop = AceLibrary("Dewdrop-2.0")

local L = SimpleCombatLog.loc.color


SimpleCombatLog.colorList = {
"player", 	"pet", 	"raid", 	"party", 	"target", 	"targettarget", 	"other", "",
"physical", 	"holy", 	"fire", 	"nature", 	"frost", 	"shadow", 	"arcane", "",
"heal", 	"miss", 	"buff", 	"debuff", 	"skill", 		
}

function SimpleCombatLog:GetColorRGB(id, colorType)
	local hexColor, isDefault = self:GetColorHex(id, colorType)
	local r, g, b = string.sub(hexColor,1,2), string.sub(hexColor,3,4), string.sub(hexColor,5,6)
	r = tonumber(r, 16)/255
	g = tonumber(g, 16)/255
	b = tonumber(b, 16)/255
	return r, g, b, isDefault
end


function SimpleCombatLog:SetColorRGB(id, colorType, r, g, b)
	local hexColor = 	string.format('%02x%02x%02x', (r*255), (g*255), (b*255))
	self:SetColorHex(id, colorType, hexColor)
end


function SimpleCombatLog:SetColorHex(id, colorType, hexColor)
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

	if not self.settings[id].colors then
		self.settings[id].colors = {}
	end	
	self.settings[id].colors[colorType] = hexColor
end

function SimpleCombatLog:RestoreDefaultColors(id)
	if self.settings[id] and self.settings[id].colors then
		self.settings[id].colors = nil
	end
end


local function UpdateColorOptionsTable(self, id, level, value)
	if level == 1 then
		dewdrop:AddLine(
			'text', L["Colors"],
			'notCheckable', true,
			'hasArrow', true,
			'value', 'color'
		)
	elseif level == 2 and value == 'color' then
	
		local c, d, title
		for i, v in pairs(self.colorList) do
			if v ~= "" then
				local r, g, b, isDefault = self:GetColorRGB(id, v)
				if not isDefault then title = self:Colorize(L[v], self.defaultColors.dirty) else title = L[v] end
				dewdrop:AddLine(
					'text', title,
					'hasColorSwatch', true,
					'r', r,
					'g', g,
					'b', b,
					'notCheckable', true,
					'colorFunc', function(id, colorType, r, g, b) self:SetColorRGB(id, colorType, r, g, b) end,
					'colorArg1', id,
					'colorArg2', v
				)
			else
				dewdrop:AddLine()
			end
		end
		
		dewdrop:AddLine()
		dewdrop:AddLine(
			'text', L["Restore default colors"],
			'notCheckable', true,
			'func', function() self:RestoreDefaultColors(id) end
		)
			
	end
			
end



if SimpleCombatLog.menuFunc then
	SimpleCombatLog.menuFunc[3] = UpdateColorOptionsTable
end

