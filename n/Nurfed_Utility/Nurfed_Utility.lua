
local setpoints = {};

if (not Nurfed_Utility) then

	Nurfed_Utility = {};
	Nurfed_Utility.hooks = {};

	function Nurfed_Utility:New()
		local object = {};
		setmetatable(object, self);
		self.__index = self;
		return object;
	end

	function Nurfed_Utility:Print(msg, out, r, g, b, a)
		if (not msg) then	return;		end
		if (not out) then	out = 1;	end
		if (not r) then		r = 1.0;	end
		if (not g) then		g = 1.0;	end
		if (not b) then		b = 1.0;	end
		if (not a) then		a = 1.0;	end

		if (type(out) ~= "number") then
			UIErrorsFrame:AddMessage(msg, r, g, b, a, UIERRORS_HOLD_TIME);
		else
			local frame = getglobal("ChatFrame"..out);
			if (frame) then
				frame:AddMessage(msg, r, g, b);
			else
				DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b);
			end
		end
	end

	function Nurfed_Utility:TableCopy(t)
		local new = {};
		local i, v = next(t, nil);
		while i do
		if type(v)=="table" then 
			v=self:TableCopy(v);
		end 
		new[i] = v;
		i, v = next(t, i);
		end
		return new;
	end

	function Nurfed_Utility:GetTableIndex(tablename, text)
		for i = 1, table.getn(tablename) do
			if (tablename[i].text == text) then
				return i;
			end
		end
		return nil;
	end
	
	function Nurfed_Utility:FormatGS(globalString, anchor)
		globalString = string.gsub(globalString, "%.", "%%.");
		globalString = string.gsub(globalString, "%(", "%%(");
		globalString = string.gsub(globalString, "%)", "%%)");
		globalString = string.gsub(globalString, "%%[1234567890$]*s", "(.+)");
		globalString = string.gsub(globalString, "%%[1234567890$]*d", "(%%d+)");
		if (anchor) then
			return "^"..globalString;
		end
		return globalString;
	end

	-- Respect to GypsyMod for the Hook Code
	function Nurfed_Utility:Hook (mode, original, new)
		if (not self.hooks[original]) then
			self.hooks[original] = getglobal(original);
			if (mode == "before") then
				setglobal(original, function (...)
					new(unpack(arg));
					self.hooks[original](unpack(arg));
				end);
			elseif (mode == "after") then
				setglobal(original, function (...)
					self.hooks[original](unpack(arg));
					new(unpack(arg));
				end);
			elseif (mode == "replace") then
				setglobal(original, function (...)
					new(unpack(arg));
				end);
			end
		end
	end

	function Nurfed_Utility:UnHook (original)
		if (self.hooks[original]) then
			setglobal(original, self.hooks[original]);
			self.hooks[original] = nil;
		end
	end

	function Nurfed_Utility:FormatBinding(text)
		text = string.gsub(text, "CTRL%-", "C-");
		text = string.gsub(text, "ALT%-", "A-");
		text = string.gsub(text, "SHIFT%-", "S-");
		text = string.gsub(text, "Num Pad", "NP");
		text = string.gsub(text, "Backspace", "Bksp");
		text = string.gsub(text, "Spacebar", "Space");
		text = string.gsub(text, "Page", "Pg");
		text = string.gsub(text, "Down", "Dn");
		text = string.gsub(text, "Arrow", "");
		text = string.gsub(text, "Insert", "Ins");
		text = string.gsub(text, "Delete", "Del");
		return text;
	end

	function Nurfed_Utility:OffScreen(frame)
		if (not frame or not frame:IsVisible()) then
			return;
		end
		local offscreenX, offscreenY;

		if (frame:GetLeft() * frame:GetEffectiveScale() < UIParent:GetLeft() * UIParent:GetEffectiveScale()) then
			offscreenX = -1;
		elseif (frame:GetRight() * frame:GetEffectiveScale() > UIParent:GetRight() * UIParent:GetEffectiveScale()) then
			offscreenX = 1;
		else
			offscreenX = 0;
		end

		if (frame:GetTop() * frame:GetEffectiveScale() > UIParent:GetTop() * UIParent:GetEffectiveScale()) then
			offscreenY = -1;
		elseif (frame:GetBottom() * frame:GetEffectiveScale() < UIParent:GetBottom() * UIParent:GetEffectiveScale()) then
			offscreenY = 1;
		else
			offscreenY = 0;
		end

		return offscreenX, offscreenY;
	end
end