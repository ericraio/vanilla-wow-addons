--------------------------------------------------------
--	Nurfed Dynamic Frame Creation
--------------------------------------------------------

if (not Nurfed_Frames) then

	Nurfed_Frames = {};

	Nurfed_Frames.templates = {};
	Nurfed_Frames.init = {
		size = function(object, value) object:SetWidth(value[1]) object:SetHeight(value[2]) end,
		events = function(object, value) for k, v in value do object:RegisterEvent(v) end end,
		children = function(object, value) for k, v in value do if not object:GetName() then return end Nurfed_Frames:CreateObject(object:GetName()..k, v, object, k) end end,
		events = function(object, value) for k, v in value do object:RegisterEvent(v) end end,
		vars = function(object, value) for k, v in value do object[k] = v end end,
		Hide = function(object, value) object:Hide() end,

		-- Run after creation
		Anchor = function(object, value) table.insert(Nurfed_Frames.complete.Anchors, { object, value }) end,
		BackdropColor = function(object, value) table.insert(Nurfed_Frames.complete.BackdropColor, { object, value }) end,
		BackdropBorderColor = function(object, value) table.insert(Nurfed_Frames.complete.BackdropBorderColor, { object, value }) end,
	};
	Nurfed_Frames.complete = {
		Anchors = {},
		BackdropColor = {},
		BackdropBorderColor = {},
	};

	function Nurfed_Frames:New()
		local object = {};
		setmetatable(object, self);
		self.__index = self;
		return object;
	end

	function Nurfed_Frames:SetProperty(object, value, prop)
		local method;
		if (object["Set"..prop]) then
			method = object["Set"..prop];
			if (type(value) == "table" and prop ~= "Backdrop") then
				method(object, unpack(value));
			else
				method(object, value);
			end
		elseif (object["Enable"..prop]) then
			method = object["Enable"..prop];
			method(object, value);
		end
	end

	function Nurfed_Frames:CreateTemplate(name, spec)
		self.templates[name] = spec;
	end

	function Nurfed_Frames:ObjectInit(name, layout, parent)
		if (not name or not layout) then
			return;
		end
		if (not parent) then
			parent = UIParent;
		end
		local object = self:CreateObject(name, layout, parent);
		self:CompleteObject();
		return object;
	end

	function Nurfed_Frames:CreateObject(name, layout, parent, apply)
		if (type(parent) == "string") then
			parent = getglobal(parent);
		end
		if (type(layout) == "string") then
			layout = self.templates[layout];
		end

		local spec = layout;
		if (layout.template) then
			spec = self.templates[layout.template];
		end
		local object;
		local objtype = rawget(spec, "type");
		if (objtype == "Texture") then
			object = parent:CreateTexture(name, spec.layer);
		elseif (objtype == "FontString") then
			object = parent:CreateFontString(name, spec.layer);
		else
			object = CreateFrame(objtype, name, parent);
		end

		for k, v in pairs(spec) do
			if ((type(v) == "function") and string.find(k,"^On")) then
				object:SetScript(k, v);
			elseif (self.init[k]) then
				local value = v;
				if (type(v) == "table" and v.template) then
					value = self.templates[v.template];
				end
				self.init[k](object, value);
			else
				local value = v;
				if (type(v) == "table" and v.template) then
					value = self.templates[v.template];
				end
				self:SetProperty(object, value, k);
			end
		end

		if (layout.properties) then
			for k, v in pairs(layout.properties) do
				if ((type(v) == "function") and string.find(k,"^On")) then
					object:SetScript(k, v);
				elseif (self.init[k]) then
					local value = v;
					if (type(v) == "table" and v.template) then
						value = self.templates[v.template];
					end
					self.init[k](object, value);
				else
					local value = v;
					if (type(v) == "table" and v.template) then
						value = self.templates[v.template];
					end
					self:SetProperty(object, value, k);
				end
			end
		end

		if (apply and string.find(apply, "Texture", 1, true)) then
			local method = parent["Set"..apply];
			if (method) then
				method(parent, object);
			end
		end

		return object;
	end

	function Nurfed_Frames:CompleteObject()
		for _, v in pairs(self.complete.Anchors) do
			v[1]:ClearAllPoints();
			if (type(v[2]) ~= "table") then
				v[1]:SetAllPoints(v[1]:GetParent());
			else
				local parent = string.gsub(v[2][2], "$parent", v[1]:GetParent():GetName());
				v[1]:SetPoint(v[2][1], parent, v[2][3], v[2][4], v[2][5]);
			end
		end
		self.complete.Anchors = {};

		for _, v in pairs(self.complete.BackdropColor) do
			v[1]:SetBackdropColor(unpack(v[2]));
		end
		self.complete.BackdropColor = {};

		for _, v in pairs(self.complete.BackdropBorderColor) do
			v[1]:SetBackdropBorderColor(unpack(v[2]));
		end
		self.complete.BackdropColor = {};
	end
end