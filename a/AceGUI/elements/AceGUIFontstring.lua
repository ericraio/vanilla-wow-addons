AceGUIFontString = AceGUIElement:new()

function AceGUIFontString:Setup()
	-- Determine if it's an actual FontString or if it's encapsulated
	-- GetFrameType method not available until 1.9 so relying on a different method until then
	-- if(self.GetFrameType and self:GetFrameType() == "Frame") then
	if(not self.SetText) then
		-- Store the real FontString for later use
		self._text = getglobal(self:GetName().."Text")
	       if(not self._text) then
			error("Invalid Frame used with AceGUIFontString",3)
		end

		-- Set up a metatable to take care of wrapping the methods for the frame
		local index = getmetatable(self).__index
		local text = self._text
		if(type(index) == "function") then
			setmetatable(self,{__index = function(t,k)
                     	if(text[k]) then
                     		t[k] = function(a,b,c,d) return text[k](text,a,b,c,d) end
                     	end
                     	return t[k] or index(t,k)
			end})
		else
			setmetatable(self,{__index = function(t,k)
			       if(text[k]) then
                     		t[k] = function(a,b,c,d) return text[k](text,a,b,c,d) end
                     	end
                     	return t[k] or index[k]
			end})
		end
	end
end

function AceGUIFontString:Configure()

	local def = self._def
	-- GetFont method not available until 1.9.  I will assume the font is set for testing
	--[[if(not self:GetFont()) then
		self:SetFont(def.Font or "Fonts\\FRIZQT__.TTF",def.FontHeight or 12,unpack(def.flags or {}))
	end]]
	def.Color = def.Color or {r = 1,g = 0.82,b = 0}
	self:SetTextColor(def.Color.r,def.Color.g,def.Color.b,def.Color.a)
	-- SetNonSpaceWrap Method not available until 1.9
	-- self:SetNonSpaceWrap(def.NonSpaceWrap)
	if(def.VertexColor) then
		self:SetVertexColor(def.VertexColor.r,def.VertexColor.g,def.VertexColor.b,def.VertexColor.a)
	end
	if(def.AlphaGradient) then
		self:SetAlphaGradient(def.AlphaGradient.start,def.AlphaGradient.length)
	end
	if(def.justifyH) then
		self:SetJustifyH(def.justifyH)
	end
	if(def.justifyV) then
		self:SetJustifyV(def.justfyV)
	end


end

function AceGUIFontString:GetValue()
	return self:GetText()
end

function AceGUIFontString:SetValue(val)
	return self:SetText(val)
end
