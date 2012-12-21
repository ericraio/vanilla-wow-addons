---------------------------------------------------------------------------
-- Iriel's Virtual Frame Driver - Embedded library
--
-- Written by Iriel <iriel@vigilance-committee.org>
---------------------------------------------------------------------------
-- IMPORTANT: Do not **EDIT** and distribute without changing MAJOR_VERSION

IVF_Warnings = false;

local lib = {};

-- Return the library's current version
function lib:GetLibraryVersion()
	-- You MUST update the major version whenever you make an incompatible
	-- change
	local MAJOR_VERSION = "KarlPrototype-2-dev";
	-- You MUST update the minor version whenever you make a compatible
	-- change (And check LibActivate is still valid!)
	local MINOR_VERSION = 618;

	return MAJOR_VERSION, MINOR_VERSION;
end

-- Activate a new instance of this library
function lib:LibActivate(stub, oldLib, oldList)
	local maj, min = self:GetLibraryVersion();

	-- For now there's no migration
	self:_Initialize();

	-- nil return makes stub do object copy
end

---------------------------------------------------------------------------
-- CODE NOTES
--
-- The single letter variable P is used for the 'merged properties' table
-- for a frame, that is the composite table created by stacking the various
-- inherited properties under one another.

---------------------------------------------------------------------------
-- PROPERTY HANDLERS
--
-- Property handlers are invoked by the instantiation engine to configure
-- newly created frames. They're all called with the same set of parameters:
--
-- object -- The frame/region object that's being configured.
-- key	 -- The name of the property that triggered the handler.
-- value  -- The value of the property that triggered the handler.
-- props  -- The 'processing properties' table, which has the following
--			  entries:
--
--	  props.engine	  -- The library instance that's handling instantiation
--	  props.spec		 -- The specification object for the current object
--	  props.name		 -- The name of the current object
--	  props.object	  -- The current object
--	  props.properties -- The merged properties for the current object
--	  props:Error(msg) -- An error reporting function
--	  props.object	  -- A table of any objects created as properties (such
--								 as subtextures or fonts), indexed by their property
--								 name.
--
-- If a property handler is registered for multiple keys, it is called
-- ONCE if any of the keys are defined on the object (or if the registration
-- entry has runAlways = true set on it it's called ONCE regardless).
--
-- Handlers are applied in the order they're registered in the _InitProperties
-- method.

local function PH_SetValue(object, key, value, props)
	local methodName = "Set" .. key;
	local method = object[methodName];
	if (not method) then
		error("Missing method '" .. methodName .. "'");
	end
	method(object, value);
end

local function Create_PH_MethodCaller(methodName)
	return function(object, key, value)
				 local method = object[methodName];
				 if (not method) then
					 error("Missing method '" .. methodName .. "'");
				 end
				 method(object, value);
			 end
end

local function PH_SetSpecialTexture(object, key, value, props)
	local tex = props.objects[key];
	if (not tex) then
		error("Missing texture");
	end
	PH_SetValue(object, key, tex, props);
end

local function PH_SetSpecialFrame(object, key, value, props)
	local frame = props.objects[key];
	if (not frame) then
		error("Missing frame");
	end
	PH_SetValue(object, key, frame, props);
end

local function Create_PH_SpecialFontSetter(methodName)
	return function(object, key, value, props)
				 local font = props.objects[key];
				 PH_SetValue(object, methodName, font, props);
			 end
end

local function Create_PH_HTMLFontSetter(whichFont)
	return function(object, key, value, props)
				 local font = props.objects[key];
				 if (not font) then
					 error("Missing Font");
				 end
				 object:SetFont(whichFont, font);
			 end
end

local function PH_SetAnchors(object, key, value, props)
	if (props.spec.type == "Font") then
		return;
	end
	local parent = props.parent;
	local P = props.properties;
	local anchors = P.Anchors;
	local allPoints = P.SetAllPoints;
	if (anchors) then
		-- If we have explicit anchors, process them all
		object:ClearAllPoints();
		local parname = parent and parent:GetName();
		for _,a in ipairs(anchors) do
			local p,rel,rp,x,y = a[1], a[2], a[3], a[4], a[5];
			if (rel) then
				rel = string.gsub(rel, "%$parent", parname or '');
			end
			if (not rel or rel == '') then rel = parent; end
			object:SetPoint(p, rel, rp, x, y);
		end
	elseif ((allPoints) or (allPoints == nil)) then
		-- Otherwise if we've explicitly been asked to set all points,
		-- or the flag has not been set at all, then try and set all
		-- points to the parent.
		if (parent) then
			object:SetAllPoints(parent);
		else
			-- TODO: Use 'screen' parent code once 1.11 launches
		end
	end
end

local function PH_SetFont(object, key, value, props)
	local P = props.properties;
	local fontPath = P.Font;
	local height = P.FontHeight or 0;
	local outline = P.Outline;
	local monochrome = P.Monochrome;
	local flags = nil;
	if (outline == "NORMAL") then
		flags = "OUTLINE";
	elseif (outline == "THICK") then
		flags = "OUTLINE,THICKOUTLINE";
	end
	if (monochrome) then
		if (flags) then
			flags = flags .. ",MONOCHROME";
		else
			flags = "MONOCHROME";
		end
	end
	object:SetFont(fontPath, height, flags);
end

local function PH_SetShadow(object, key, value, props)
	local C = value.color;
	local O = value.offset;
	if (value.color) then
		object:SetShadowColor(C[1], C[2], C[3], C[4]);
	end
	if (value.offset) then
		object:SetShadowOffset(C[1], C[2]);
	end
end

---------------------------------------------------------------------------
-- LIBRARY METHODS
--
-- These are the actual library methods. Method names beginning with an
-- underscore are intended for internal use only.
--
local VFMETHODS = {};
setmetatable(lib, { __index = VFMETHODS } );

function VFMETHODS:_Initialize()
	self.specs = {};
	self.scriptNames = {};
	self.propertyHandlers = {};
	self.propertyNames = {};
	self.workTables = {};

	self:_InitProperties();
end

function VFMETHODS:_GetWorkTable()
	local tbl = next(self.workTables);
	if (not tbl) then
		return {};
	end
	self.workTables[tbl] = nil;
	return tbl;
end

function VFMETHODS:_ReleaseWorkTable(tbl)
	for k,v in pairs(tbl) do
		tbl[k] = nil;
	end
	table.setn(tbl, 0);
	self.workTables[tbl] = true;
end

-- Setup function for registering a new property handler with the
-- generation code. See PROPERTY HANDLERS section above.
--
-- func - The property handling function to use.
-- ...  - One or more property names that the function handles.
--
-- Returns the property handler entry so that it can have flags set on
-- it if necessary.
function VFMETHODS:_AddPropertyHandler(func, ...)
	local entry = {
		names = arg;
		func = func;
	};
	table.insert(self.propertyHandlers, entry);
	for _, n in ipairs(arg) do
		local curHandler = self.propertyNames[n];
		if (curHandler) then
			self:Warning("Duplicate property handler for '" .. n .. "'");
		else
			self.propertyNames[n] = entry;
		end
	end
	return entry;
end

function VFMETHODS:_InitProperties()
	-- Block special properties
	self.propertyNames["type"]	  = true;
	self.propertyNames["name"]	  = true;
	self.propertyNames["inherits"] = true;
	self.propertyNames["Parent"]	= true;

	---------------------------------------------------------------------------
	-- Group 0, basic properties
	self:_AddPropertyHandler(PH_SetValue, "Alpha");
	self:_AddPropertyHandler(PH_SetValue, "DrawLayer");
	self:_AddPropertyHandler(
									function(object, key, value, props)
										if (value) then
											object:Hide();
										else
											object:Show();
										end
									end, "Hidden");
	self:_AddPropertyHandler(PH_SetValue, "ID");
	self:_AddPropertyHandler(
									function(object, key, value, props)
										if (value == "PARENT") then
											local par = props.parent;
											if (par) then
												value = par:GetFrameStrata();
											else
												value = "MEDIUM";
											end
										end
										object:SetFrameStrata(value);
									end, "FrameStrata");
	self:_AddPropertyHandler(PH_SetValue, "Movable");
	self:_AddPropertyHandler(PH_SetValue, "Resizable");
	self:_AddPropertyHandler(
									function(object, key, value, props)
										if (value[1]) then
											object:SetWidth(value[1]);
										end
										if (value[2]) then
											object:SetHeight(value[2]);
										end
									end, "Size");
	self:_AddPropertyHandler(PH_SetValue, "FrameLevel");
	self:_AddPropertyHandler(PH_SetAnchors,
									"SetAllPoints", "Anchors").runAlways = true;
	self:_AddPropertyHandler(PH_SetValue, "TopLevel");

	---------------------------------------------------------------------------
	-- Group 1, sub-objects
	self:_AddPropertyHandler(PH_SetValue, "Texture");
	self:_AddPropertyHandler(PH_SetFont,
									 "Font", "FontHeight", "Outline", "Monochrome");
	self:_AddPropertyHandler(Create_PH_SpecialFontSetter("FontObject")
									, "FontString");
	self:_AddPropertyHandler(Create_PH_SpecialFontSetter("TextFontObject"),
									"NormalText");
	self:_AddPropertyHandler(PH_SetSpecialTexture, "NormalTexture");
	self:_AddPropertyHandler(PH_SetValue, "Backdrop");
	self:_AddPropertyHandler(PH_SetSpecialTexture, "CheckedTexture");
	self:_AddPropertyHandler(PH_SetSpecialTexture, "DisabledCheckedTexture");
	self:_AddPropertyHandler(Create_PH_SpecialFontSetter("DisabledFontObject"),
									"DisabledText");
	self:_AddPropertyHandler(PH_SetSpecialTexture, "DisabledTexture");
	self:_AddPropertyHandler(Create_PH_HTMLFontSetter("H1"),
									 "FontStringHeader1");
	self:_AddPropertyHandler(Create_PH_HTMLFontSetter("H2"),
									 "FontStringHeader2");
	self:_AddPropertyHandler(Create_PH_HTMLFontSetter("H3"),
									 "FontStringHeader3");
	self:_AddPropertyHandler(Create_PH_SpecialFontSetter("HighlightFontObject"),
									"HighlightText");
	self:_AddPropertyHandler(PH_SetSpecialTexture, "HighlightTexture");
	self:_AddPropertyHandler(PH_SetSpecialTexture, "PushedTexture");
	self:_AddPropertyHandler(PH_SetSpecialFrame, "ScrollChild");
	self:_AddPropertyHandler(
									function(object, key, value, props)
										-- *** UGLY ***
										local tex = props.objects[key];
										object:SetStatusBarTexture(tex:GetTexture());
									end, "StatusBarTexture");
	self:_AddPropertyHandler(PH_SetSpecialTexture, "ThumbTexture");
	--self:_AddPropertyHandler(PH_SetValue, "ArrowModel"); -- Missing (Minimap)
	--self:_AddPropertyHandler(PH_SetValue, "PlayerModel"); -- Missing
	self:_AddPropertyHandler(PH_SetValue, "Model");

	---------------------------------------------------------------------------
	-- Group 2 - Colors
	self:_AddPropertyHandler(
									function(object, key, value, props)
										object:SetHighlightTextColor(value[1], value[2], value[3], value[4]);
									end, "HighlightColor");
	self:_AddPropertyHandler(
									function(object, key, value, props)
										object:SetTexture(value[1], value[2], value[3], value[4]);
									end, "Color");
	self:_AddPropertyHandler(
									function(object, key, value, props)
										object:SetStatusBarColor(value[1], value[2], value[3], value[4]);
									end, "BarColor");

	---------------------------------------------------------------------------
	-- Group 3 - Configuration

	self:_AddPropertyHandler(Create_PH_MethodCaller("SetBlendMode"),
									 "AlphaMode");
	--self:_AddPropertyHandler(PH_SetValue, "AutoFocus"); -- 1.11
	--self:_AddPropertyHandler(PH_SetValue, "BlinkSpeed"); -- Missing (EditBox)
	self:_AddPropertyHandler(Create_PH_MethodCaller("SetTimeVisible"),
									 "DisplayDuration");
	self:_AddPropertyHandler(PH_SetValue, "FogFar");
	self:_AddPropertyHandler(PH_SetValue, "FogNear");
	self:_AddPropertyHandler(PH_SetValue, "HistoryLines");
	self:_AddPropertyHandler(PH_SetValue, "HyperlinkFormat");
	-- IgnoreArrows -- GetAltArrowKeyMode ?
	-- InsertMode  -- 1.11
	self:_AddPropertyHandler(PH_SetValue, "JustifyH");
	self:_AddPropertyHandler(PH_SetValue, "JustifyV");
	self:_AddPropertyHandler(PH_SetValue, "MaxBytes");
	self:_AddPropertyHandler(PH_SetValue, "MaxLetters");
	self:_AddPropertyHandler(PH_SetValue, "MaxLines");
	self:_AddPropertyHandler(function (object, key, value, props)
										local P = props.properties;
										local min, max = P.MinValue, P.MaxValue;
										if ((not min) or (not max)) then
											local omin, omax = object:GetMinMaxValues();
											min = min or omin;
											max = max or omax;
										end
										object:SetMinMaxValues(min, max);
									end, "MinValue", "MaxValue");
	self:_AddPropertyHandler(PH_SetValue, "ModelScale");
	self:_AddPropertyHandler(PH_SetValue, "NonSpaceWrap");
	self:_AddPropertyHandler(PH_SetValue, "Orientation");
	self:_AddPropertyHandler(PH_SetValue, "Spacing");
	self:_AddPropertyHandler(PH_SetValue, "ValueStep");
	self:_AddPropertyHandler(
									function(object, key, value, props)
										local max = value.max;
										if (max) then
											object:SetMaxResize(max[1], max[2]);
										end
										local min = value.min;
										if (min) then
											object:SetMinResize(max[1], max[2]);
										end
									end, "ResizeBounds");
	self:_AddPropertyHandler(PH_SetShadow, "Shadow");
	self:_AddPropertyHandler(
									function(object, key, value, props)
										object:SetTexCoord(value.left, value.right,
																 value.top, value.bottom);
									end, "TexCoords");
	self:_AddPropertyHandler(
									function(object, key, value, props)
										object:SetTextInsets(value.left, value.right,
																	value.top, value.bottom);
									end, "TextInsets");

	---------------------------------------------------------------------------
	-- Group 4 - State

	self:_AddPropertyHandler(PH_SetValue, "Checked");
	self:_AddPropertyHandler(PH_SetValue, "Text");
	self:_AddPropertyHandler(PH_SetValue, "Value");

	-- Others

	-- File -- Missing (SimpleHTML)
	-- MultiLine -- 1.11
	-- Numeric - 1.11
	-- Password -- Missing

	-- ColorValueTexture -- Missing
	-- ColorValueThumbTexture -- Missing
	-- ColorWheelTexture -- Missing
	-- ColorWheelThumbTexture -- Missing
	-- FogColor -- todo
	-- Gradient -- todo
	-- HitRectInsets -- missing
	-- PushedTexOffset -- missing
	-- TitleRegion -- missing
end

function VFMETHODS:_Prepare(spec, path)
	local myName;
	if (spec.name) then
		myName = spec.name .. "<" .. (spec.type or '?') .. ">";
	else
		myName = "<" .. (spec.type or '?') .. ">";
	end

	if (not path) then
		path = myName;
	else
		path = path .. ":" .. myName;
	end

	for k,v in pairs(spec) do
		if ((type(v) == "function") and string.find(k,"^On")) then
			self.scriptNames[k] = true;
		elseif (type(v) == "table" and v.type) then
			self:_Prepare(v, path .. "[" .. k .. "]");
		elseif (not self.propertyNames[k]) then
			self:Warning("Unsupported property '" .. k .. "' used by "
							 .. path);
		end
	end
end

function VFMETHODS:Register(name, spec)
	-- self:Debug("Registering '" .. name .. "'");
	self:_Prepare(spec);
	self.specs[name] = spec;
end

function VFMETHODS:Debug(msg)
	ChatFrame2:AddMessage("[VirtualFrames] " .. msg);
end

function VFMETHODS:Warning(msg)
	if (IVF_Warnings) then
		DEFAULT_CHAT_FRAME:AddMessage("[VirtualFrames] WARNING: " .. msg);
	end
end

function VFMETHODS:Error(msg)
	DEFAULT_CHAT_FRAME:AddMessage("[VirtualFrames] ERROR: " .. msg);
	message(msg);
end

function VFMETHODS:Instantiate(template, name, parent, properties, noOnLoad)
	local spec = self.specs[template];
	if (not spec) then
		self:Error("No template for '" .. template .. "' defined");
		return;
	end

	if (type(parent) == "string") then
		local parentObj = getglobal(parent);
		if (not parentObj) then
			self:Error("Parent '" .. parentObj .. "' not found");
			return;
		end
		parent = parentObj;
	end

	if (properties) then
		for key, value in pairs(properties) do
			if ((type(value) == "function") and string.find(key, "^On")) then
				self.scriptNames[key] = true;
			elseif (not self.propertyNames[key]) then
				self:Warning("Unsupported property '" .. key .. "' in input.");
			end
		end
	end

	local context = self:_GetWorkTable();
	context.specs = self:_GetWorkTable();

	local obj, objname = self:_ObjectCreate(context, spec, name,
														 parent, properties);
	local P = self:_ObjectComplete(context,
											 spec, obj, objname, properties);

	self:_ObjectActivate(context, spec, obj, properties, noOnLoad);

	self:_ReleaseWorkTable(context.specs);
	self:_ReleaseWorkTable(context);
	context = nil;
	if (properties) then
		local meta = getmetatable(properties);
		if (meta) then
			meta.__index = nil;
		end
	end
	return obj, objname;
end

function VFMETHODS:_LayerProperties(spec, P)
	if (P) then
		local meta = getmetatable(P);
		if (not meta) then
			meta = {};
			setmetatable(P, meta);
		end
		if (not meta.__index) then
			meta.__index = spec;
		end
	else
		P = spec;
	end

	return P;
end

-- CREATE: This handles creating an object and building the merged
--			property structure for the remainder of the process.
--
--	  context - The context structure for the instantiation process
--	  spec	 - The spec structure defining the object to create
--	  name	 - The requested object name (nil to use spec)
--	  parent  - The parent object (nil to use spec)
--	  props	- Source properties for the processing run
--
-- Returns the created object, its name, and its parent object
function VFMETHODS:_ObjectCreate(context, spec, name, parent, props)
	--self:Debug("  Create "..spec.type.." (" .. (spec.name or "") ..") "
	--..(name or '?'));

	local P = self:_LayerProperties(spec, props);

	local object, inheritFont;
	local objType = rawget(spec, "type");
	local inherits = rawget(spec, "inherits");
	if (inherits) then
		if ((objType == "FontString") or (objType == "Font")) then
			font = getglobal(inherits);
			if (font and font.IsObjectType and font:IsObjectType("Font")) then
				inheritFont = font;
			end
		end
		if (not inheritFont) then
			-- self:Debug("  Inherits from " .. spec.inherits);
			local ispec = self.specs[inherits];
			if (not ispec) then
				self:Error("No template for '" .. inherits .. "' defined");
			elseif (rawget(ispec, "type") ~= objType) then
				self:Error("Type mismatch with template '" .. inherits .. "'");
			else
				local pmeta = getmetatable(spec);
				if (not pmeta) then
					pmeta = {};
					setmetatable(spec, pmeta);
				end
				pmeta.__index = ispec;
				object = self:_ObjectCreate(context, ispec, name, parent, P);
			end
		end
	end

	if (not object) then
		if (not parent) then
			local PParent = P.Parent;
			if (PParent) then
				parent = getglobal(PParent);
				if (not parent) then
					self:Warning("Unable to find parent frame '" .. PParent .. "'");
				end
			end
		end

		if (objType == "Texture") then
			object = parent:CreateTexture(name);
		elseif (objType == "FontString") then
			object = parent:CreateFontString(name);
			if (inheritFont) then
				object:SetFontObject(inheritFont);
			end
		elseif (objType == "Font") then
			object = CreateFont(name or " unnamed font ");
			if (inheritFont) then
				object:SetFontObject(inheritFont);
			end
		else
			object = CreateFrame(objType, name, parent);
		end

		context.specs[object] = spec;
	end

	return object, name, parent;
end

local function PW_ErrorMethod(self, error)
	local context = self.name;
	local spec = self.spec;
	if (not context and spec.name) then
		context = "[" .. spec.name .. "]";
	end
	if (not context and spec.type) then
		context = "[" .. spec.type .. "]";
	end
	if (not context) then
		context = "?";
	end
	if (self.curName) then
		context = context .. ": " .. self.curName;
	end
	self.engine:Error(context .. ": " .. error);
end

-- COMPLETE: This handles creating child objects, then applying properties
--			  to the object and child objects.
--
--	  context - The context structure for the instantiation process
--	  spec	 - The spec structure defining the object to create
--	  object  - The object to be completed
--	  name	 - The requested object name (nil to use spec)
--	  props	- Source properties for the processing run
--	  noApply - If true, suppress application of properties on the object
--
-- Returns the merged properties of the object.
--
-- Completion works as follows:
--
--	1) If this spec inherits from another one, then call _ObjectComplete
--		for the same object but with the inherited spec, props == the
--		merged properties for the object, and and noApply = true, continue
--		when that returns.
--	2) _ObjectCreate all child objects declared by THIS spec (not including
--		special property objects) with this as parent.
--	3) If noApply is false, then _ObjectCreate all property objects.
--	4) _ObjectComplete all child objects declared by THIS spec.
--	5) if noApply is false, then _ObjectComplete all property objects.
--	6) if noApply is false, then _ObjectActivate all property objects.
--	7) if noApply is false, then apply all relevant property handlers.
--	8) _ObjectActivate all child objects declared by THIS spec.
--	9) return merged properties.
function VFMETHODS:_ObjectComplete(context, spec, object, name, props, noApply)
	--self:Debug("  Complete "..spec.type.." (" .. (spec.name or "") ..") "
	--..(name or '?'));

	local P = self:_LayerProperties(spec, props);
	local baseSpec = context.specs[object];
	local objType = rawget(spec, "type");
	local inherited = false;
	if ((baseSpec ~= spec) and (objType ~= 'Font')) then
		local inherits = rawget(spec, "inherits");
		local ispec = self.specs[inherits];
		if (ispec) then
			inherited = true;
			P = self:_ObjectComplete(context, ispec, object, name, P, true);
		end
	end

	-- Create sub objects
	local childObjects = self:_GetWorkTable();
	local propObjects = self:_GetWorkTable();

	for k, v in ipairs(spec) do
		local cname = v.name;
		if (cname) then
			cname = string.gsub(cname, "%$parent", name or '');
		end
		childObjects[k] = self:_ObjectCreate(context, v, cname, object);
	end

	if (not noApply) then
		for n in pairs(self.propertyNames) do
			local v = P[n];
			if ((type(v) == "table") and (v.type)) then
				local cname = v.name;
				if (cname) then
					cname = string.gsub(cname, "%$parent", name or '');
				end
				propObjects[n] = self:_ObjectCreate(context, v, cname, object);
			end
		end
	end

	-- Now complete child objects
	for k, spec in ipairs(spec) do
		local obj = childObjects[k];
		self:_ObjectComplete(context, spec, obj, obj:GetName());
	end

	if (not noApply) then
		for k, obj in pairs(propObjects) do
			local spec = P[k];
			self:_ObjectComplete(context, spec, obj, obj:GetName());
		end

		-- Populate this frame's properties
		for k, obj in pairs(propObjects) do
			local spec = P[k];
			self:_ObjectActivate(context, spec, obj);
		end

		local propWorker = self:_GetWorkTable();
		propWorker.engine = self;
		propWorker.spec = spec;
		propWorker.name = name;
		propWorker.object = object;
		propWorker.properties = P;
		propWorker.parent = object.GetParent and object:GetParent();
		propWorker.Error = PW_ErrorMethod;
		propWorker.objects = propObjects;

		for _,p in ipairs(self.propertyHandlers) do
			for _,n in ipairs(p.names) do
				local v = P[n];
				if ((v ~= nil) or (p.runAlways)) then
					propWorker.curName = n;
					local ok, err = pcall(p.func,
												 object, n, v,
												 propWorker, p);
					if (not ok) then
						propWorker:Error("Failed: " .. err);
					end
					break;
				end
			end
		end

		self:_ReleaseWorkTable(propWorker);
		propWorker = nil;
	end

	-- Activate child objects
	for k, spec in ipairs(spec) do
		local obj = childObjects[k];
		self:_ObjectActivate(context, spec, obj);
	end

	self:_ReleaseWorkTable(childObjects);
	self:_ReleaseWorkTable(propObjects);
	regionObjects, childObjects, propObjects = nil, nil, nil;

	return P;
end

-- ACTIVATE: Apply scripts and invoke OnLoad if necessary.
--
--	  context  - The context structure for the instantiation process
--	  spec	  - The spec structure defining the object to create
--	  object	- The object to activate
--	  props	 - Source properties for the processing run
--	  noOnLoad - If true, don't call OnLoad method if it exists
function VFMETHODS:_ObjectActivate(context, spec, object, props, noOnLoad)
	--self:Debug("  Activate "..spec.type.." (" .. (spec.name or "") ..") "
	--..(object:GetName() or '?'));
	local P = self:_LayerProperties(spec, props);

	local HS = object.HasScript;
	local OnLoad;
	for scriptName in pairs(self.scriptNames) do
		local script = P[scriptName];
		if (type(script) == "function") then
			if (HS and HS(object, scriptName)) then
				object:SetScript(scriptName, script);
				if (scriptName == "OnLoad") then
					OnLoad = script;
				end
			else
				self:Error("Attempted to set " .. k .. " script on a "
							  .. spec.type);
			end
		end
	end

	if (OnLoad and (not noOnLoad)) then
		-- self:Debug("Firing OnLoad " .. tostring(object:GetName() or object));
		local oldthis = this;
		this = object;
		local ok,err = pcall(OnLoad);
		if (not ok) then
			self:Error("OnLoad failed for " .. spec.type );
			self:Error(tostring(err));
		end
		this = oldthis;
	end
end

-- Register this instance with the stub
IrielVirtualFrames:Register(lib);
lib = nil; -- Let GC clean it up later
