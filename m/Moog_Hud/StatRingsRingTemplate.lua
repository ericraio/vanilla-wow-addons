-- StatRings Ring Template
----------------------------------------------------------------------
--
-- Template code for partial ring display
--
-- Divides the ring up into four quadrants:
--   Q1-TopRight Q2-BottomRight Q3-BottomLeft Q4-TopLeft
--
-- Other terminology:
--   self.radius - The outer radius of the ring (Also the texture width)
--   self.ringFactor - The ratio of inner radius/outer radius

---------------------------------------------------------------------------
-- QUADRANT MAPPING FUNCTIONS
--   The subsetting code is all written relative to the first quandrant, but
--   each quadrant has a pair of functions to manage mapping location and
--   texture operations from that 'normalized' coordinate system into the
--   appropriate one for the quadrant in question
--
-- SUBSET FUNCTION
--   This function displays a subset of a quadrant, using a subset of a
--   texture (The texture subsetting is optional, so the same function
--   can be used for slice stretching). Note this does not issue a
--   ClearAllPoints.
--
--   setSubsetFuncs[quadrant](tex, parname, radius, xlo, xhi, ylo, yhi, notex)
--
--   Parameters:
--     tex      - The texture object
--     parname  - The name of the texture's parent (for SetPoint use)
--     radius   - The outer radius of the ring (i.e. texture width & height)
--     xlo, xhi - X Coordinate bounds (from center of the ring)
--     ylo, yhi - Y Coordinate bounds (From center of the ring)
--     notex    - (OPTIONAL) If present and true, do not set texture coords.
--                just change points.
--
-- SLICE FUNCTION
--   This function sets the texture coordinates for a slice texture, so that
--   it's correctly oriented for the quadrant.
--
--   setSliceFuncs[quadrant](tex)
--
--   Parameters:
--     tex      - The slice texture object
--
local setSubsetFuncs = {};
local setSliceFuncs = {};

-- Q3: BOTTOM LEFT
setSubsetFuncs[1] = function(tex, parname, radius, xlo, xhi, ylo, yhi, notex)
   if (not notex) then
     tex:SetTexCoord(xhi, xlo, ylo, yhi);
   end
   tex:SetPoint("BOTTOMRIGHT", parname, "BOTTOMLEFT", -xlo*radius, -yhi*radius);
   tex:SetPoint("TOPLEFT", parname, "BOTTOMLEFT", -xhi*radius, -ylo*radius);
end

-- Q4: TOP LEFT
setSubsetFuncs[2] = function(tex, parname, radius, xlo, xhi, ylo, yhi, notex)
   if (not notex) then
      tex:SetTexCoord(yhi, ylo, xhi, xlo); 
   end
   tex:SetPoint("BOTTOMLEFT", parname, "BOTTOMLEFT", -yhi*radius, xlo*radius);
   tex:SetPoint("TOPRIGHT", parname, "BOTTOMLEFT", -ylo*radius, xhi*radius);
end

-- Q1: TOP RIGHT
setSubsetFuncs[3] = function(tex, parname, radius, xlo, xhi, ylo, yhi, notex)
   if (not notex) then
      tex:SetTexCoord(xlo, xhi, yhi, ylo);
   end
   tex:SetPoint("TOPLEFT", parname, "BOTTOMLEFT", xlo*radius, yhi*radius);
   tex:SetPoint("BOTTOMRIGHT", parname, "BOTTOMLEFT", xhi*radius, ylo*radius);
end

-- Q2: BOTTOM RIGHT
setSubsetFuncs[4] = function(tex, parname, radius, xlo, xhi, ylo, yhi, notex)
   if (not notex) then
      tex:SetTexCoord(ylo, yhi, xlo, xhi);
   end
   tex:SetPoint("TOPRIGHT", parname, "BOTTOMLEFT", yhi*radius, -xlo*radius);
   tex:SetPoint("BOTTOMLEFT", parname, "BOTTOMLEFT", ylo*radius, -xhi*radius);
end

-- Slice text coord setting funcs
setSliceFuncs[1] = function(tex) tex:SetTexCoord(0, 1, 1, 0); end
setSliceFuncs[2] = function(tex) tex:SetTexCoord(1, 0, 1, 0); end
setSliceFuncs[3] = function(tex) tex:SetTexCoord(1, 0, 0, 1); end
setSliceFuncs[4] = function(tex) tex:SetTexCoord(0, 1, 0, 1); end

-- The 'Work' function, which handles subset rendering for a single
-- quadrant (normalized to Q1)
--
-- Params:
--  self - The ring template instance
--  A    - The angle within the quadrant (degrees, 0 <= A < 90)
--  T    - The main texture for the quadrant
--  SS   - The texture subset mapping function for the quadrant

function StatRingsRingTemplate_DoQuadrantReversed(self, A, T, SS)
   -- Grab local references to important textures
   local C = self.chip;
   local S = self.slice;

   -- If no part of this quadrant is visible, just hide all the textures
   -- and be done.
   if (A == 0) then
      T:Hide();
      C:Hide();
      S:Hide();
      return;
   end

   -- More local references, grab the ring dimensions, and the frame name.
   local RF = self.ringFactor;
   local OR = self.radius;
   local name = self.name;

   -- Drawing scheme uses three locations
   --   E (Ex,Ey) - The 'End' position (Nx=1, Ny=0)
   --   O (Ox,Oy) - Intersection of angle line with Outer edge
   --   I (Ix,Iy) - Intersection of angle line with Inner edge

   -- Calculated locations:
   --   Arad  - Angle in radians
   --   Ox,Oy - O coordinates
   --   Ix,Iy - I coordinates
   local Arad = math.rad(A);
   local Ox = math.cos(Arad);
   local Oy = math.sin(Arad);
   local Ix = Ox * RF;
   local Iy = Oy * RF;

   -- Treat first and last halves differently to maximize size of main
   -- texture subset.
   if (A <= 45) then
      -- Main subset is from N to I
      SS(T, name, OR, Ix, 1,  0, Iy);
      -- Chip is subset from (Ix,Oy) to (Ox,Ny) (Right edge of main)
      SS(C, name, OR, Ox, 1, Iy, Oy);
   else
      -- Main subset is from N to O
      SS(T, name, OR, Ox, 1,  0, Oy);
      -- Chip is subset from (Nx,Iy) to (Ix,Oy) (Bottom edge of main)
      SS(C, name, OR, Ix, Ox, 0, Iy);
   end
   -- Strech slice between I and O
   SS(S, name, OR, Ix, Ox, Iy, Oy, 1);
   -- All three textures are visible
   T:Show();
   C:Show();
   S:Show();
end

function StatRingsRingTemplate_DoQuadrant(self, A, T, SS)
   -- Grab local references to important textures
   local C = self.chip;
   local S = self.slice;

   -- If no part of this quadrant is visible, just hide all the textures
   -- and be done.
   if (A == 0) then
      T:Hide();
      C:Hide();
      S:Hide();
      return;
   end

   -- More local references, grab the ring dimensions, and the frame name.
   local RF = self.ringFactor;
   local OR = self.radius;
   local name = self.name;

   -- Drawing scheme uses three locations
   --   N (Nx,Ny) - The 'Noon' position (Nx=0, Ny=1)
   --   O (Ox,Oy) - Intersection of angle line with Outer edge
   --   I (Ix,Iy) - Intersection of angle line with Inner edge

   -- Calculated locations:
   --   Arad  - Angle in radians
   --   Ox,Oy - O coordinates
   --   Ix,Iy - I coordinates
   local Arad = math.rad(A);
   local Ox = math.sin(Arad);
   local Oy = math.cos(Arad);
   local Ix = Ox * RF;
   local Iy = Oy * RF;

   -- Treat first and last halves differently to maximize size of main
   -- texture subset.
   if (A <= 45) then
      -- Main subset is from N to I
      SS(T, name, OR, 0, Ix, Iy, 1);
      -- Chip is subset from (Ix,Oy) to (Ox,Ny) (Right edge of main)
      SS(C, name, OR, Ix, Ox, Oy, 1);
   else
      -- Main subset is from N to O
      SS(T, name, OR, 0, Ox, Oy, 1);
      -- Chip is subset from (Nx,Iy) to (Ix,Oy) (Bottom edge of main)
      SS(C, name, OR, 0, Ix, Iy, Oy);
   end
   -- Strech slice between I and O
   SS(S, name, OR, Ix, Ox, Iy, Oy, 1);
   -- All three textures are visible
   T:Show();
   C:Show();
   S:Show();
end

-- Method function to set the angle to display
--
-- Param:
--  self  - The ring template instance
--  angle - The angle in degrees (0 <= angle <= 180)

function StatRingsRingTemplate_SetAngle(self, angle)
	
	-- Bounds checking on the angle so that it's between 0 and 180 (inclusive)
	if (angle < 0) then
		angle = 0;
	end
	if (angle > 180) then
		angle = 180;
	end
	
	-- Avoid duplicate work
	if (self.angle == angle and not self.dirty) then
		return;
	end
	
	-- Determine the quadrant, and angle within the quadrant
	-- (Quadrant 5 means 'all quadrants filled')
	local quad = math.floor(angle / 90) + 1;
	local A = math.mod(angle, 90);
	local quadOfs = self.quadOffset or 0;
	   local effQuad;
	   if (self.reversed) then
	      effQuad = math.mod((4-quad)+quadOfs, 4)+1;
	   else
	      effQuad = math.mod(quad+quadOfs-1, 4)+1;
	   end

	-- Check to see if we've changed quandrants since the last time we were
	-- called. Quadrant changes re-configure some textures.
	if (quad ~= self.lastQuad or self.dirty) then
		-- Loop through all quadrants
		for i=1,2 do
			T=self.quadrants[i];
			 if (self.reversed) then
			    qi = math.mod((4-i)+quadOfs, 4)+1;
			 else
			    qi = math.mod(i+quadOfs-1, 4)+1;
			 end
			if (i < quad) then
			   -- If this quadrant is full shown, then show all of the texture
			   T:ClearAllPoints();
			   --if (self.reversed) then
				--setSubsetFuncs[i+2](T, self.name, self.radius, 0.0, 1.0, 0.0, 1.0);
			   --else
				setSubsetFuncs[qi](T, self.name, self.radius, 0.0, 1.0, 0.0, 1.0);
			   --end
			
			   T:Show();
			elseif (i == quad) then
			   -- If this quadrant is partially or fully shown, begin by
			   -- showing all of the texture. Also configure the slice
			   -- texture's orientation.
			   T:ClearAllPoints();
			   setSubsetFuncs[qi](T, self.name, self.radius, 0.0, 0.8, 0.4, 1.0);
			   --[[
			   if (self.reversed) then
				setSubsetFuncs[qi](T, self.name, self.radius, 0.0, 0.8, 0.4, 1.0);
			   else
				setSubsetFuncs[i](T, self.name, self.radius, 0.0, 0.8, 0.4, 1.0);
			   end
			   ]]
			   T:Show();
			    if (self.reversed) then
			       setSliceFuncs[math.mod(qi+1,4)+1](self.slice);
			    else
			       setSliceFuncs[qi](self.slice);
			    end
			   --[[
			   if (self.reversed) then
				setSliceFuncs[i+2](self.slice);
			   else
				setSliceFuncs[i](self.slice);
			   end
			   ]]
			else
			   -- If this quadrant is not shown at all, hide it.
			   T:Hide();
			end
		end

		-- Hide the chip and slice textures, and de-anchor them (They'll be
		-- re-anchored as necessary later).
		self.chip:Hide();
		self.chip:ClearAllPoints();
		self.slice:Hide();
		self.slice:ClearAllPoints();
		
		-- Remember this for next time
		self.lastQuad = quad;
	end
	
	-- Remember the angle for next time
	self.angle = angle;
	
	-- Extra bounds check for paranoia (also handles quad 5 case)
	if ((quad < 1) or (quad > 2)) then
	   return;
	end
	
	-- Get quadrant-specific elements
	local T = self.quadrants[quad];
	--local SS = setSubsetFuncs[quad];
	local SS = setSubsetFuncs[effQuad];
	
	-- Call the quadrant function to do the work
	if SS ~= nil then
		if (self.reversed) then
			StatRingsRingTemplate_DoQuadrantReversed(self, A, T, SS)
		else
			StatRingsRingTemplate_DoQuadrant(self, A, T, SS)
		end
	end
	self.dirty = false;
end



---------------------------------------------------------------------------
-- Some handy method functions

-- StatsRingRingTemplate:CallTextureMethod(method, ...)
--
-- Invokes the named method on all of the textures in the ring,
-- passing in whatever arguments are given.
--
--  e.g. ring:CallTextureMethod("SetVertexColor", 1.0, 0.5, 0.2, 1.0);

local function StatsRingsRingTemplate_CallTextureMethod(self, method, ...)
   self.quadrants[1][method](self.quadrants[1], unpack(arg));
   self.quadrants[2][method](self.quadrants[2], unpack(arg));
   self.chip[method](self.chip, unpack(arg));
   self.slice[method](self.slice, unpack(arg));
end


-- StatsRingRingTemplate:SetRingTextures(ringFactor,ringTexFile,sliceTexFile)
--
-- Sets the textures to use for this ring
--
-- Param:
--   ringFactor   - The ring factor (Inner Radius / Outer Radius)
--   ringTexFile  - The ring texture filename
--   sliceTexFile - The slice texture filename

local function StatsRingsRingTemplate_SetRingTextures(self, ringFactor,
						      ringTexture,
						      sliceTexture)
	DEFAULT_CHAT_FRAME:AddMessage("called setringtextures");
   local savedAngle = self.angle;
   self.angle = nil;
   self.lastQuad = nil;

   self.ringFactor = ringFactor;

   for i=1,2 do
      self.quadrants[i]:SetTexture(ringTexture);
   end
   self.chip:SetTexture(ringTexture);
   self.slice:SetTexture(sliceTexture);

   if (savedAngle) then
      self:SetAngle(savedAngle);
   end
end

-- Method function to set whether or not ring growth is reversed.
--
-- Param:
--  self       - The ring template instance
--  isReversed - Whether to reverse or not
function StatRingsRingTemplate_SetReversed(self, isReversed)
   if (isReversed) then
      isReversed = true;
   else
      isReversed = nil;
   end
   if (isReversed == self.reversed) then
      return;
   end
   self.reversed = isReversed;
end

-- The OnLoad method, call this for each template object to set it up and
-- get things going
function StatRingsRingTemplate_OnLoad()
	--  Just do global this resolution once.
	local this = this;
	
	-- Grab texture references and frame name
	this.name = this:GetName();
	this.quadrants = {};
	this.quadrants[1] = getglobal(this.name .. "TQ1");
	this.quadrants[2] = getglobal(this.name .. "TQ2");
	this.chip         = getglobal(this.name .. "TC");
	this.slice        = getglobal(this.name .. "TS");
	
	-- Initialize size and default texture ringFactor
	this.radius = (this:GetWidth() * 0.5);
	this.ringFactor = 0.94;
	
	-- Add ring methods
	this.SetAngle          		= StatRingsRingTemplate_SetAngle;
	this.CallTextureMethod 		= StatsRingsRingTemplate_CallTextureMethod;
	this.SetRingTextures   		= StatsRingsRingTemplate_SetRingTextures;
	this.Init			= StatRings_Init;
	this.SetMax			= StatRings_SetMax;
	this.SetValue			= StatRings_SetValue;
	this.Update			= StatRings_Update;
	this.AddUpdateFunction		= StatRings_AddUpdateFunction;
	this.RemoveUpdateFunction	= StatRings_RemoveUpdateFunction;
	this.UpdateColor		= StatRings_UpdateColor;
	this.SetReversed		= StatRingsRingTemplate_SetReversed;

	this.startValue = 0;
	this.endValue = 0;
	this.maxValue = 0;
	this.fadeTime = 0;
	this.maxFadeTime = 1;
	this.alphaState = -1;
	this.PI = 3.14159265;
	this.casting = 0;
	this.channeling = 0;
	this.spellstart = GetTime();
	this.baseColor = {["r"] = 1, ["g"] = 0.6, ["b"] = 0.1};
	this.baseAlpha = 0.5;
	this.destAlpha = 0.5;
	
	this.updateFuncs = {};

	this:SetScript("OnUpdate", StatRings_Update);
	-- Set angle to zero (initializes texture visibility)
	this:AddUpdateFunction(StatRings_DoFadeUpdate);
	this:AddUpdateFunction(StatRingsTest_AlphaUpdate);
	this:AddUpdateFunction(StatRings_Casting);
	
	this:SetAngle(0);
end

function StatRings_SetMax(self, max)
	if max == nil then max = 1; end
	this.maxValue = max;
	-- sr_pr(this.name .. "ring Max set to " .. this.maxValue);
end

function StatRings_SetValue(self, value)
	if value == nil then value = 0; end
	if value == 0 then
		value = this.maxValue / 10000; end
	if this.casting == 1 then
		this.startValue = value; end
	this.endValue = value
	this.fadeTime = 0;
end

function StatRings_Update()
	for idx, func in this.updateFuncs do
		func(this, arg1);
	end
end

function StatRings_AddUpdateFunction(self, arg1)
	local found = false;
	for idx, f in this.updateFuncs do
		if arg1 == f then
			found = true;
			break;
		end
	end
	if not found then
		table.insert(this.updateFuncs, arg1);
	end
end

function StatRings_RemoveUpdateFunction(self, func)
	for idx, f in this.updateFuncs do
		if func == f then
			table.remove(this.updateFuncs, idx);
			break;
		end
	end
end

function StatRings_Casting(this)
	if ( this.casting == nil ) then
		this.casting = 0; end
	if ( this.channeling == nil ) then
		this.channeling = 0; end
	if ( this.spellstart == nil ) then
		this.spellstart = GetTime(); end

	if ( this.casting == 1) then
		local status = (GetTime() - this.spellstart)*1000;
		local time_remaining = this.maxValue - status;

		if ( this.channeling == 1) then
			status = time_remaining;
		end
		
		if ( status > this.maxValue ) then
			status = this.maxValue
		end
		
		this:SetValue(status);

		if ( time_remaining < 0 ) then
			time_remaining = 0;
		end

		local intlength = string.len(string.format("%u",time_remaining/1000));
		local texttime = strsub(string.format("%f",time_remaining/1000),1,intlength+2) .. "s";
		Moog_HudCastTime:SetText(texttime);
	end
end

function StatRings_DoFadeUpdate(this, tdelta)
	tdelta = arg1;
	if this.fadeTime < this.maxFadeTime then
		this.fadeTime = this.fadeTime + tdelta;
		if this.fadeTime > this.maxFadeTime then
			this.fadeTime = this.maxFadeTime;
		end
		local delta = this.endValue - this.startValue;
		local diff = delta * (this.fadeTime / this.maxFadeTime);
		this.startValue = this.startValue + diff;
		local angle = this.startValue / this.maxValue * 180;
		if angle <= 90 then
			this.ringFactor = 0.9 + ((90 - angle) / (90/0.1));
		elseif angle <= 180 then
			this.ringFactor = 0.9 + ((angle - 90) / (90/0.1));
		--[[
		elseif angle <= 270 then
			this.ringFactor = 0.9 + ((270 - angle) / (90/0.1));
		elseif angle > 270 then
			this.ringFactor = 0.9 + ((angle - 270) / (90/0.1));
		]]
		end
		this:SetAngle((this.startValue / this.maxValue) * 180);
	end
end

function StatRingsTest_AlphaUpdate(this)
--[[
	if getglobal(this:GetName() .. "MoveAnchor"):IsVisible() then
		this:SetAlpha(0.8);
		this:SetAngle(180);
		return;
	end
]]
   local destAlpha = this.destAlpha;

   local nowAlpha = this.baseAlpha;

   if (nowAlpha < destAlpha) then
      nowAlpha = nowAlpha + (arg1/2);
      if (nowAlpha > destAlpha) then
	 nowAlpha = destAlpha;
      end
   elseif (nowAlpha > destAlpha) then
      nowAlpha = nowAlpha - (arg1/2);
      if (nowAlpha < destAlpha) then
	 nowAlpha = destAlpha;
      end
   end

   this.baseAlpha = nowAlpha;

   -- New white blink code
   -- blinkstate is amount remaining of 1 second blink
   local blinkstate = 1-(GetTime() - Moog_SpellBlinkTime);

   if (blinkstate <= 0) then
      this:CallTextureMethod("SetVertexColor",this.baseColor.r, this.baseColor.g, this.baseColor.b,1);
	this:SetAlpha(nowAlpha);
   else
	local blinkcolor = {["r"] = ((1-this.baseColor.r)*blinkstate)+this.baseColor.r,
 				["g"] = ((1-this.baseColor.g)*blinkstate)+this.baseColor.g,
 				["b"] = ((1-this.baseColor.b)*blinkstate)+this.baseColor.b};
	this:CallTextureMethod("SetVertexColor",blinkcolor.r, blinkcolor.g, blinkcolor.b,1);
	this:SetAlpha(((0.9-this.baseAlpha)*blinkstate)+this.baseAlpha);
   end

end

function StatRingsTest_SetAlpha(this, destAlpha, instant)
   if (destAlpha < 0) then
      destAlpha = 0.0;
   elseif (destAlpha > 1) then
      destAlpha = 1.0;
   end

   if (this.baseAlpha == destAlpha) then
      return;
   end

   if (instant) then
      this.baseAlpha = destAlpha;
   end

   this.destAlpha = destAlpha;
end

function StatRings_UpdateColor(self, color)
	if color == nil then
		color = {["r"] = 1, ["g"] = 0.6, ["b"] = 0.1};
	end
  	if (color) then
		self.baseColor = color;
    	-- self:CallTextureMethod("SetVertexColor",color.r, color.g, color.b,1);
  	end
end