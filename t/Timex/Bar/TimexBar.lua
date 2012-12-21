local EMPTY_TABLE = {};
local TIMEX_BAR = "TimexBar";
local DEFAULT_SCALE = 0.8;
local DEFAULT_RES = 0.1;

local strformat = string.format;

local function ARG_ID(t) return t.timexBar.id; end;
local function ARG_ELAPSED(t) return t.timexBar.elapsed; end;
local function ARG_REMAINING(t) return t.timexBar.v; end;

local timexDebug = nil;

--<< ================================================= >>--
-- Section I: Initialize the AddOn Object.               --
--<< ================================================= >>--

TimexBar = AceModule:new({
--	name          = TimexLocals.TimexBar_Title,
--	author        = "Rowne/facboy",
--	aceCompatible = "100",

	ARG_ID = ARG_ID,
	ARG_ELAPSED = ARG_ELAPSED,
	ARG_REMAINING = ARG_REMAINING,
})

function TimexBar:Enable()
	self.barDB  = {};
	self.barMap = setmetatable({}, Timex.weakV_mt);
	table.setn(self.barDB, 20);
	for id = 1,20,1 do getglobal(TIMEX_BAR..id):SetScale(DEFAULT_SCALE); end
	--for id = 1,20,1 do getglobal(TIMEX_BAR..id):SetFrameStrata("TOOLTIP"); end
end

--<< ================================================= >>--
-- Section II: Private utility functions.                --
--<< ================================================= >>--

--------------------
-- argument stuff
--------------------
local args_switch = {};
args_switch[ARG_ID] = ARG_ID;
args_switch[ARG_ELAPSED] = ARG_ELAPSED;
args_switch[ARG_REMAINING] = ARG_REMAINING;

local function buildArgs(args, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
	local sub = args.sub;
	local f = args_switch[a20]; args[20], sub[20] = not f and a20 or nil, f;
	f = args_switch[a19]; args[19], sub[19] = not f and a19 or nil, f;
	f = args_switch[a18]; args[18], sub[18] = not f and a18 or nil, f;
	f = args_switch[a17]; args[17], sub[17] = not f and a17 or nil, f;
	f = args_switch[a16]; args[16], sub[16] = not f and a16 or nil, f;
	f = args_switch[a15]; args[15], sub[15] = not f and a15 or nil, f;
	f = args_switch[a14]; args[14], sub[14] = not f and a14 or nil, f;
	f = args_switch[a13]; args[13], sub[13] = not f and a13 or nil, f;
	f = args_switch[a12]; args[12], sub[12] = not f and a12 or nil, f;
	f = args_switch[a11]; args[11], sub[11] = not f and a11 or nil, f;
	f = args_switch[a10]; args[10], sub[10] = not f and a10 or nil, f;
	f = args_switch[a9]; args[9], sub[9] = not f and a9 or nil, f;
	f = args_switch[a8]; args[8], sub[8] = not f and a8 or nil, f;
	f = args_switch[a7]; args[7], sub[7] = not f and a7 or nil, f;
	f = args_switch[a6]; args[6], sub[6] = not f and a6 or nil, f;
	f = args_switch[a5]; args[5], sub[5] = not f and a5 or nil, f;
	f = args_switch[a4]; args[4], sub[4] = not f and a4 or nil, f;
	f = args_switch[a3]; args[3], sub[3] = not f and a3 or nil, f;
	f = args_switch[a2]; args[2], sub[2] = not f and a2 or nil, f;
	f = args_switch[a1]; args[1], sub[1] = not f and a1 or nil, f;
end

local args_mt = {
	__index = function(t, k)
		local f = t.sub[k];
		if f then return f(t); end
	end,
}

local function newArgs(timexBar)
	local args = { timexBar = timexBar, sub = {} };
	setmetatable(args, args_mt);
	return args;
end

--<< ================================================= >>--
-- Section III: The Time-Event Handler.                  --
--<< ================================================= >>--

local function timexHandler(self, timexBar, elapsed)
	--self.cmd:msg("timexHandler: timexBar.n = %s", tostring(timexBar.n));
	local v = timexBar.v;
	if v then
		v = v - elapsed;
		if v <= 0 then
			if timexBar.f then
				timexBar.elapsed = elapsed;
				local a = timexBar.a;
				local status, err = pcall(timexBar.f, a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14], a[15], a[16], a[17], a[18], a[19], a[20]);
				if (not status) then
					Timex.cmd:msg("TimexBar function '%s' failed with error: %s", tostring(timexBar.id), tostring(err));
				end
			end
			self:Stop(timexBar.id);
			return;
		elseif timexBar.uf then
			timexBar.elapsed = elapsed;
			local a = timexBar.ua;
			local status, err = pcall(timexBar.uf, a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14], a[15], a[16], a[17], a[18], a[19], a[20]);
			if (not status) then
				Timex.cmd:msg("TimexBar update function '%s' failed with error: %s", tostring(timexBar.id), tostring(err));
			end
		end
		-- Update bar
		local settext = ceil(v);
		settext = settext > 60 and (format("%d", settext / 60)..":"..format("%02d", mod(settext, 60))) or settext;
		timexBar.ttxt:SetText(settext);
		timexBar.sbar:SetValue(v);
		timexBar.v = v;
	end
end

--<< ================================================= >>--
-- Section IV: The TimexBarClass 'inner' class           --
--<< ================================================= >>--

-- class definition
local TimexBarClass = {
	bR = 0.1, bB = 0.2, bG = 0.8, bA = 1.0,
	tR = 1.0, tB = 1.0, tG = 1.0, tA = 1.0,
	aP = "CENTER", aF = "UIParent", aRP = "CENTER", xO = 0, yO = 0,
};
local TimexBarClass_mt = { __index = TimexBarClass };

do
	local bar = getglobal(TIMEX_BAR.."1");
	TimexBarClass.s, TimexBarClass.bW, TimexBarClass.bH = DEFAULT_SCALE, bar:GetWidth(), bar:GetHeight();
	local ttxt = getglobal(TIMEX_BAR.."1TimerText");
	TimexBarClass.tW = ttxt:GetWidth();
end

-- private constructor
local function newTimexBar(timexBar, b)
	local n = TIMEX_BAR..b;
	local newInst = {
		n = n,
		bar  = getglobal(n),
		sbar = getglobal(n.."StatusBar"),
		txt  = getglobal(n.."Text"),
		ttxt = getglobal(n.."TimerText"),
		btn = getglobal(n.."Button"),
		btnTex = getglobal(n.."ButtonTexture")
	};
	setmetatable(newInst, TimexBarClass_mt);
	return newInst;
end

-- private reset function (only resets the 'functional' attributes, not the formatting ones)
local function resetTimexBar(timexBar)
	-- reset all values to nil
	timexBar.id, timexBar.f, timexBar.uf, timexBar.elapsed, timexBar.v, timexBar.res = nil, nil, nil, nil, nil, nil;
	-- clear arg tables
	local args = timexBar.a;
	if args then
		args[1], args[2], args[3], args[4], args[5] = nil, nil, nil, nil, nil;
		args[6], args[7], args[8], args[9], args[10] = nil, nil, nil, nil, nil;
		args[11], args[12], args[13], args[14], args[15] = nil, nil, nil, nil, nil;
		args[16], args[17], args[18], args[19], args[20] = nil, nil, nil, nil, nil;
	end
	args = timexBar.ua;
	if args then
		args[1], args[2], args[3], args[4], args[5] = nil, nil, nil, nil, nil;
		args[6], args[7], args[8], args[9], args[10] = nil, nil, nil, nil, nil;
		args[11], args[12], args[13], args[14], args[15] = nil, nil, nil, nil, nil;
		args[16], args[17], args[18], args[19], args[20] = nil, nil, nil, nil, nil;
	end
	if timexBar.cf then
		timexBar.cf = nil;
		args = timexBar.ca;
		if args then
			args[1], args[2], args[3], args[4], args[5] = nil, nil, nil, nil, nil;
			args[6], args[7], args[8], args[9], args[10] = nil, nil, nil, nil, nil;
			args[11], args[12], args[13], args[14], args[15] = nil, nil, nil, nil, nil;
			args[16], args[17], args[18], args[19], args[20] = nil, nil, nil, nil, nil;
		end
	end	
end

-- private formatting function
local function resetTimexBarFormat(timexBar)
	local bar, txt, ttxt  = timexBar.bar, timexBar.txt, timexBar.ttxt;
	
	if not timexBar.sColor and timexBar.rColor then
		timexBar.bR, timexBar.bB, timexBar.bG, timexBar.bA = nil, nil, nil, nil;
		timexBar.sbar:SetStatusBarColor(timexBar.bR, timexBar.bB, timexBar.bG, timexBar.bA);
		timexBar.rColor = nil;
	end
	
	if not timexBar.sTextColor and timexBar.rTextColor then
		timexBar.tR, timexBar.tB, timexBar.tG, timexBar.tA = nil, nil, nil, nil;
		txt:SetTextColor(timexBar.tR, timexBar.tB, timexBar.tG, timexBar.tA);
		ttxt:SetTextColor(timexBar.tR, timexBar.tB, timexBar.tG, timexBar.tA);
		timexBar.rTextColor = nil;
	end
	
	if not timexBar.sPoint and timexBar.rPoint then
		timexBar.aP, timexBar.aF, timexBar.aRP, timexBar.xO, timexBar.yO = nil, nil, nil, nil, nil;
		bar:ClearAllPoints();
		bar:SetPoint(timexBar.aP, timexBar.aF, timexBar.aRP, timexBar.xO, timexBar.yO);
		timexBar.rPoint = nil;
	end
		
	if not timexBar.sWidth and timexBar.rWidth then
		timexBar.bW = nil;
		bar:SetWidth(timexBar.bW);
		timexBar.rWidth = nil;
	end

	if not timexBar.sHeight and timexBar.rHeight then
		timexBar.bH = nil;
		bar:SetHeight(timexBar.bH);
		timexBar.rHeight = nil;
	end
	
	if not timexBar.sScale and timexBar.rScale then
		timexBar.s = nil;
		bar:SetScale(timexBar.s);
		timexBar.rScale = nil;
	end
	
	if not timexBar.sTimeWidth and timexBar.rTimeWidth then
		timexBar.tW = nil;
		ttxt:SetWidth(timexBar.tW);
		txt:SetPoint("TOPLEFT", bar, "LEFT", timexBar.tW, 13);
		timexBar.rTimeWidth = nil;
	end

	if not timexBar.sText and timexBar.rText then
		timexBar.text = nil;
		if timexBar.text then 
			timexBar.txt:SetText("| "..timexBar.text);
		else
			timexBar.txt:SetText("");
		end
		timexBar.rText = nil;
	end

	if not timexBar.sTexture and timexBar.rTexture then
		timexBar.tex = nil;
		if timexBar.tex then
			timexBar.btnTex:SetTexture(timexBar.tex);
			timexBar.btn:Show();
		else
			timexBar.btn:Hide();
		end
		timexBar.rTexture = nil;
	end
end

local function clearSetFlags(timexBar)
	timexBar.sColor, timexBar.sTextColor, timexBar.sPoint, timexBar.sWidth = nil, nil, nil, nil;
	timexBar.sHeight, timexBar.sScale, timexBar.sTimeWidth, timexBar.sText, timexBar.sTexture = nil, nil, nil, nil, nil;
end

--<< ================================================= >>--
-- Section V: The Start and Stop Bar Functions.          --
--<< ================================================= >>--

-- Assigns a bar to id
function TimexBar:Get(id)
	if id and id ~= "" then
		local timexBar = self.barMap[id];
		-- if not found
		if not timexBar then
			-- find first available
			local b = 1;
			timexBar = self.barDB[b];
			while (timexBar) do
				if (not timexBar.v) then
					break;
				end
				b = b + 1;
				timexBar = self.barDB[b];
			end
			if timexBar then
				clearSetFlags(timexBar);
			elseif (b <= 20) then
				timexBar = newTimexBar(self, b);
				self.barDB[b] = timexBar;
			else
				error("No more bars available!");
			end
			-- assign id
			timexBar.id, self.barMap[id] = id, timexBar;
		end
		return timexBar.n;
	end
end

function TimexBar:Start(id, time, res)
	if (time) then
		local timexBar = self.barMap[id];
		if timexBar then
			res = res or DEFAULT_RES;
			timexBar.v = time;
			timexBar.res = res;
			
			-- reset bar format and show
			resetTimexBarFormat(timexBar);

			local settext = ceil(timexBar.v);
			settext = settext > 60 and format("%d:%02d", settext/60, mod(settext, 60)) or settext;
			timexBar.ttxt:SetText(settext);
			local sbar = timexBar.sbar;
			sbar:SetMinMaxValues(0, time);
			sbar:SetValue(timexBar.v);

			if timexBar.cf then
				timexBar.btn:EnableMouse(1);
				timexBar.btn:SetScript("OnClick", timexBar.onClick);
			end
			timexBar.bar:Show();
			
			Timex:AddSchedule(timexBar, res, true, nil, timexHandler, self, timexBar, Timex.ARG_ELAPSED);
			return timexBar.n;
		else
			error(strformat("TimexBar '%s' not found.", tostring(id)));
		end
	end
end

function TimexBar:Stop(id)
	local timexBar = self.barMap[id];
	if timexBar then
		Timex:DeleteSchedule(timexBar);
		if timexBar.cf then
			timexBar.btn:EnableMouse(0);
			timexBar.btn:SetScript("OnClick", nil);
		end
		timexBar.bar:Hide();
		resetTimexBar(timexBar);
		self.barMap[id] = nil;
	end
end

function TimexBar:Pause(id)
	local timexBar = self.barMap[id];
	if timexBar then
		Timex:DeleteSchedule(timexBar);
	end
end
	
function TimexBar:Resume(id)
	local timexBar = self.barMap[id];
	if timexBar then
		if timexBar.res then
			Timex:AddSchedule(timexBar, timexBar.res, true, nil, timexHandler, self, timexBar, Timex.ARG_ELAPSED);
		else
			error(strformat("TimexBar '%s' has not been started yet.", tostring(id)));
		end
	end
end

function TimexBar:Check(id, r)
	local timexBar = self.barMap[id];
	if timexBar then
		return (r and timexBar.n) or TRUE;
	end
end

function TimexBar:ChangeDuration(id, t)
	local timexBar = self.barMap[id];
	if timexBar then
		if timexBar.v then
			timexBar.v    = t;
		end
	end
end

function TimexBar:Debug(debug)
	timexDebug = debug;
end

--<< ================================================= >>--
-- Section VI: The Bar Formatting Functions              --
--<< ================================================= >>--

function TimexBar:SetColor(id, red, blue, green, alpha)
	local timexBar = self.barMap[id];
	if timexBar then
		if timexBar.bR ~= red or timexBar.bB ~= blue or timexBar.bG ~= green or timexBar.bA ~= alpha then
			timexBar.bR, timexBar.bB, timexBar.bG, timexBar.bA = red, blue, green, alpha;
			timexBar.sbar:SetStatusBarColor(timexBar.bR, timexBar.bB, timexBar.bG, timexBar.bA);
			timexBar.rColor = true;
		end
		timexBar.sColor = true;
	else
		error(strformat("TimexBar '%s' not found.", tostring(id)));
	end
end

function TimexBar:SetTextColor(id, red, blue, green, alpha)
	local timexBar = self.barMap[id];
	if timexBar then
		if timexBar.tR ~= red or timexBar.tB ~= blue or timexBar.tG ~= green or timexBar.tA ~= alpha then
			timexBar.tR, timexBar.tB, timexBar.tG, timexBar.tA = red, blue, green, alpha;
			timexBar.txt:SetTextColor(timexBar.tR, timexBar.tB, timexBar.tG, timexBar.tA);
			timexBar.ttxt:SetTextColor(timexBar.tR, timexBar.tB, timexBar.tG, timexBar.tA);
			timexBar.rTextColor = true;
		end
		timexBar.sTextColor = true;
	else
		error(strformat("TimexBar '%s' not found.", tostring(id)));
	end
end

function TimexBar:SetPoint(id, point, relativeFrame, relativePoint, xOffset, yOffset)
	local timexBar = self.barMap[id];
	if timexBar then
		if timexBar.aP ~= point or timexBar.aF ~= relativeFrame or timexBar.aRP ~= relativePoint or timexBar.xO ~= xOffset or timexBar.yO ~= yOffset then
			timexBar.aP, timexBar.aF, timexBar.aRP, timexBar.xO, timexBar.yO = point, relativeFrame, relativePoint, xOffset, yOffset;
			local bar = timexBar.bar;
			bar:ClearAllPoints();
			bar:SetPoint(timexBar.aP, timexBar.aF, timexBar.aRP, timexBar.xO, timexBar.yO);
			timexBar.rPoint = true;
		end
		timexBar.sPoint = true;
	else
		error(strformat("TimexBar '%s' not found.", tostring(id)));
	end
end

function TimexBar:SetWidth(id, width)
	local timexBar = self.barMap[id];
	if timexBar then
		if timexBar.bW ~= width then
			timexBar.bW = width;
			timexBar.bar:SetWidth(timexBar.bW);
			timexBar.rWidth = true;
		end
		timexBar.sWidth = true;
	else
		error(strformat("TimexBar '%s' not found.", tostring(id)));
	end
end

function TimexBar:SetHeight(id, height)
	local timexBar = self.barMap[id];
	if timexBar then
		if timexBar.bH ~= height then
			timexBar.bH = height;
			timexBar.bar:SetHeight(timexBar.bH);
			timexBar.rHeight = true;
		end
		timexBar.sHeight = true;
	else
		error(strformat("TimexBar '%s' not found.", tostring(id)));
	end
end

function TimexBar:SetScale(id, scale)
	local timexBar = self.barMap[id];
	if timexBar then
		if timexBar.s ~= scale then
			timexBar.s = scale;
			timexBar.bar:SetScale(timexBar.s);
			timexBar.rScale = true;
		end
		timexBar.sScale = true;
	else
		error(strformat("TimexBar '%s' not found.", tostring(id)));
	end
end

function TimexBar:SetTimeWidth(id, width)
	local timexBar = self.barMap[id];
	if timexBar then
		if timexBar.tW ~= width then
			timexBar.tW = width;
			timexBar.ttxt:SetWidth(timexBar.tW);
			timexBar.txt:SetPoint("TOPLEFT", timexBar.bar, "LEFT", timexBar.tW, 13);
			timexBar.rTimeWidth = true;
		end
		timexBar.sTimeWidth = true;
	else
		error(strformat("TimexBar '%s' not found.", tostring(id)));
	end
end

function TimexBar:SetText(id, text)
	local timexBar = self.barMap[id];
	if timexBar then
		if timexBar.text ~= text then
			timexBar.text = text;
			if timexBar.text then 
				timexBar.txt:SetText("| "..timexBar.text);
			else
				timexBar.txt:SetText("");
			end
			timexBar.rText = true;
		end
		timexBar.sText = true;
	else
		error(strformat("TimexBar '%s' not found.", tostring(id)));
	end
end

function TimexBar:SetTexture(id, texturePath)
	local timexBar = self.barMap[id];
	if timexBar then
		if timexBar.tex ~= texturePath then
			timexBar.tex = texturePath;
			if timexBar.tex then
				timexBar.btnTex:SetTexture(timexBar.tex);
				timexBar.btn:Show();
			else
				timexBar.btn:Hide();
			end
			timexBar.rTexture = true;
		end
		timexBar.sTexture = true;
	else
		error(strformat("TimexBar '%s' not found.", tostring(id)));
	end
end

function TimexBar:SetFunction(id, f, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
	local timexBar = self.barMap[id];
	if timexBar then
		timexBar.f = f;
		if not timexBar.a then
			timexBar.a = newArgs(timexBar);
		end
		buildArgs(timexBar.a, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20);
	else
		error(strformat("TimexBar '%s' not found.", tostring(id)));
	end
end

function TimexBar:SetUpdateFunction(id, f, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
	local timexBar = self.barMap[id];
	if timexBar then
		timexBar.uf = f;
		if not timexBar.ua then
			timexBar.ua = newArgs(timexBar);
		end
		buildArgs(timexBar.ua, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20);
	else
		error(strformat("TimexBar '%s' not found.", tostring(id)));
	end
end

function TimexBar:SetClickFunction(id, f, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
	local timexBar = self.barMap[id];
	if timexBar then
		-- create the onClick function for this bar.
		if not timexBar.onClick then
			timexBar.onClick = function()
				local a = timexBar.ca;
				local status, err = pcall(timexBar.cf, a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14], a[15], a[16], a[17], a[18], a[19], a[20]);
				if not status then
					Timex.cmd:msg("TimexBar click function '%s' failed with error: %s", tostring(timexBar.id), tostring(err));
				end
			end
		end

		timexBar.cf = f;
		if not timexBar.ca then
			timexBar.ca = newArgs(timexBar);
		end
		buildArgs(timexBar.ca, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20);
	else
		error(strformat("TimexBar '%s' not found.", tostring(id)));
	end
end

--<< ================================================= >>--
-- Section Omega: Register the AddOn Object.             --
--<< ================================================= >>--

--TimexBar:RegisterForLoad()