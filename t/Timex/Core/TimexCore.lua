local weakK_mt = {__mode="k"};
local weakV_mt = {__mode="v"};

local TIMEX_UPDATE = 1;
local TIMEX_EVENT = 2;
local FUNCTION = 4;

local TT_UPDATE = "doTimexEvent";

local TT_UPDATE_EVENT = "TIMEX_UPDATE";

local function ARG_ID(t) return t.schedule.id; end;
local function ARG_COUNT(t) return t.schedule.c; end;
local function ARG_ELAPSED(t) return t.schedule.elapsed; end;

local DEBUG_DB = "Debug";
local timexDebug = nil;

local getTime = GetTime;

--<< ================================================= >>--
-- Section I: Initialize the AddOn Object.               --
--<< ================================================= >>--

Timex             = AceAddon:new({
	name          = TimexLocals.Title,
	version       = TimexLocals.Version,
	description   = TimexLocals.Desc,
	author        = "Rowne/facboy",
	aceCompatible = "100",
	category      = ACE_CATEGORY_OTHERS,
	cmd           = AceChatCmd:new(TimexLocals.ChatCmd, (TimexLocals.ChatOpt or {})),
	db            = AceDatabase:new("TimexDB"),

	TT_UPDATE     = TT_UPDATE,
	ARG_ID        = ARG_ID,
	ARG_COUNT     = ARG_COUNT,
	ARG_ELAPSED   = ARG_ELAPSED,

	weakV_mt      = weakV_mt,
})

-- make all this stuff local...there should only be one Timex instance anyway, this will effectively make it a singleton
local scheduleDB = {};
local scheduleMap = setmetatable({}, weakV_mt);

local timerDB = {};
	
local initDB = {};

local onUpdateDB = {};
local onUpdateMap = setmetatable({}, weakV_mt);

--<< ================================================= >>--
-- Section II: Private utility functions.                --
--<< ================================================= >>--

--------------------
-- table management
--------------------

local getn = table.getn;
local setn = table.setn;
local tinsert = table.insert;
local tremove = table.remove;

local unusedTables = setmetatable({}, weakK_mt);

local function newTable()
	local new = next(unusedTables);
	if new then
		unusedTables[new] = nil;
	else
		new = {};
	end
	return new;
end

local function deleteTable(deleteTable)
	unusedTables[deleteTable] = true;
end

--------------------
-- argument stuff
--------------------
local args_switch = {};
args_switch[ARG_ID] = ARG_ID;
args_switch[ARG_COUNT] = ARG_COUNT;
args_switch[ARG_ELAPSED] = ARG_ELAPSED;

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

local function newArgs(schedule)
	local args = newTable();
	args.schedule, args.sub = schedule, newTable();
	setmetatable(args, args_mt);
	return args;
end

--------------------
-- schedule heap management
--------------------

--------------------
-- sifting functions
local function hSiftUp(heap, pos, schedule)
	schedule = schedule or heap[pos];
	local scheduleD = schedule.d;
	
	local curr, i = pos, floor(pos/2);
	local parent = heap[i];
	while i > 0 and scheduleD < parent.d do
		heap[curr], parent.i = parent, curr;
		curr, i = i, floor(i/2);
		parent = heap[i];
	end
	heap[curr], schedule.i = schedule, curr;
	return pos ~= curr;
end

local function hSiftDown(heap, pos, schedule, size)
	schedule, size = schedule or heap[pos], size or getn(heap);
	local scheduleD = schedule.d;
	
	local curr = pos;
	repeat
		local child, childD, c;
		-- determine the child to compare with
		local j = 2 * curr;
		if j > size then
			break;
		end
		local k = j + 1;
		if k > size then
			child = heap[j];
			childD, c = child.d, j;
		else
			local childj, childk = heap[j], heap[k];
			local jD, kD = childj.d, childk.d;
			if jD < kD then
				child, childD, c = childj, jD, j;
			else
				child, childD, c = childk, kD, k;
			end
		end
		-- do the comparison
		if scheduleD <= childD then
			break;
		end
		heap[curr], child.i = child, curr;
		curr = c;
	until false;
	heap[curr], schedule.i = schedule, curr;
	return pos ~= curr;
end

--------------------
-- heap functions
local function hMaintain(heap, pos, schedule, size)
	schedule, size = schedule or heap[pos], size or getn(heap);
	if not hSiftUp(heap, pos, schedule) then
		hSiftDown(heap, pos, schedule, size);
	end
end

local function hPush(heap, schedule)
	tinsert(heap, schedule);
	hSiftUp(heap, getn(heap), schedule);
end

local function hPop(heap)
	local head, tail = heap[1], tremove(heap);
	local size = getn(heap);
	
	if size == 1 then
		heap[1], tail.i = tail, 1;
	elseif size > 1 then
		hSiftDown(heap, 1, tail, size);
	end
	return head;
end

local function hDelete(heap, pos)
	local size = getn(heap);
	local tail = tremove(heap);
	if pos < size then
		local size = size - 1;
		if size == 1 then
			heap[1], tail.i = tail, 1;
		elseif size > 1 then
			heap[pos] = tail;
			hMaintain(heap, pos, tail, size);
		end
	end
end

--------------------
-- schedule management
--------------------

local unusedSchedules = setmetatable({}, weakK_mt);

local function newSchedule()
	local schedule = next(unusedSchedules);
	if schedule then
		unusedSchedules[schedule] = nil;
	else
		schedule = newTable();
		schedule.a = newArgs(schedule);
	end
	return schedule;
end

-- schedule should already have been removed from the heap
local function deleteSchedule(schedule)
	schedule.del = nil;
	scheduleMap[schedule.id] = nil;
	unusedSchedules[schedule] = true;
end

local function deleteOnUpdate(onUpdate)
	onUpdate.del = nil;
	onUpdateMap[onUpdate.id] = nil;
	unusedSchedules[onUpdate] = true;
end

--------------------
-- function callers
--------------------

local function callFunction(schedule)
	local a = schedule.a;
	local status, err = pcall(schedule.f, a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14], a[15], a[16], a[17], a[18], a[19], a[20]);
	if not status then
		Timex.cmd:msg("Scheduled function '%s' failed with error: %s", tostring(schedule.id), tostring(err));
	end
	return err;
end

local function triggerEvent(schedule)
	local a = schedule.a;
	local status, err = pcall(schedule.f, self, schedule.e, a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14], a[15], a[16], a[17], a[18], a[19], a[20]);
	if not status then
		Timex.cmd:msg("Scheduled function '%s' failed with error: %s", tostring(schedule.id), tostring(err));
	end
	return err;
end

local function triggerDeprecatedEvent(schedule)
	local a = schedule.a;
	local status, err = pcall(schedule.f, self, schedule.e, a, schedule.c, schedule.id, schedule.elapsed);
	if not status then
		Timex.cmd:msg("Scheduled function '%s' failed with error: %s", tostring(schedule.id), tostring(err));
	end
	return err;
end

local function runMultiple(schedule, runCount)
	local runFunc = schedule.runF;
	local result = runFunc(schedule);
	if runCount > 1 then
		local autoRemove = schedule.aR;
		schedule.elapsed = 0;
		for i = 2, runCount do
			result = runFunc(schedule);
			if autoRemove and result then break; end
		end
	end
	return result;
end

--------------------
-- other stuff
--------------------

local function handleFrame()
	local runCount = getn(scheduleDB) + getn(onUpdateDB);
	if (runCount == 1) then
		TimexUpdateFrame:Show();
	elseif (runCount == 0) then
		TimexUpdateFrame:Hide();
	end
end

local function runStartupFunctions()
	for k, v in pairs(initDB) do
		if v.f then
			v.f(v.a1, v.a2, v.a3, v.a4, v.a5, v.a6, v.a7, v.a8, v.a9, v.a10, v.a11, v.a12, v.a13, v.a14, v.a15, v.a16, v.a17, v.a18, v.a19, v.a20);
		end
		-- delete the table
		v.f, v.a = nil, nil;
		v.a1, v.a2, v.a3, v.a4, v.a5 = nil, nil, nil, nil, nil;
		v.a6, v.a7, v.a8, v.a9, v.a10 = nil, nil, nil, nil, nil;
		v.a11, v.a12, v.a13, v.a14, v.a15 = nil, nil, nil, nil, nil;
		v.a16, v.a17, v.a18, v.a19, v.a20 = nil, nil, nil, nil, nil;
		deleteTable(v);
		initDB[k] = nil;
	end
end

local function togOpt(timex, var)
	return timex.db:toggle(timex.profilePath, var)
end

local function getOpt(timex, var)
	return timex.db:get(timex.profilePath, var)
end

local function getNumber(n)
	local num = tonumber(n);
	if not num then
		error("'" .. n .. "' is not a number.");
	end
	return num;
end

--<< ================================================= >>--
-- Section III: The Timex System Functions.              --
--<< ================================================= >>--

function Timex:Enable()
	TimexBar:Enable();
	timexDebug = getOpt(self, DEBUG_DB);
	TimexBar:Debug(timexDebug);
	runStartupFunctions(self);
end

function Timex:AddStartupFunc(f, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
	local init = newTable();
	init.f, init.a = f, arg;
	init.a1, init.a2, init.a3, init.a4, init.a5 = a1, a2, a3, a4, a5;
	init.a6, init.a7, init.a8, init.a9, init.a10 = a6, a7, a8, a9, a10;
	init.a11, init.a12, init.a13, init.a14, init.a15 = a11, a12, a13, a14, a15;
	init.a16, init.a17, init.a18, init.a19, init.a20 = a16, a17, a18, a19, a20;
	tinsert(initDB, init);
end

function Timex:Update(dt)
	local now = getTime();

	for k, onUpdate in pairs(onUpdateDB) do
		onUpdate.del = true;
		local a = onUpdate.a;
		local ret = onUpdate.f(a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14], a[15], a[16], a[17], a[18], a[19], a[20]);
		if ret and onUpdate.aR and onUpdate.del then
			onUpdateDB[k] = nil;
			onUpdateMap[onUpdate.id] = nil;
			unusedSchedules[onUpdate] = true;
		end
		onUpdate.del = nil;
	end

	local schedule = scheduleDB[1];
	while schedule and now >= schedule.d do
		local elapsed = now - schedule.l;
		schedule.elapsed = elapsed;

		local runCount;

		local count, t = schedule.c, schedule.t;
		local runCount;
		if count then
			runCount = t > 0 and floor((now - schedule.s)/t) or 1;
			runCount = runCount < count and runCount or count;
			count = count - runCount;
			schedule.c = count;
			if (count <= 0) then
				-- mark schedule for deletion
				schedule.del = true;
			else
				schedule.l, schedule.s, schedule.d = now, schedule.d, schedule.d + t;
				hSiftDown(scheduleDB, 1, schedule);
			end
		elseif schedule.r then
			schedule.l, schedule.s, schedule.d = now, schedule.d, schedule.d + t;
			hSiftDown(scheduleDB, 1, schedule);
		else
			-- mark schedule for deletion
			schedule.del = true;
		end
		-- run the function
		local run = schedule.run;
		if run then
			local ret = run(schedule, runCount);
			if ret and schedule.aR then
				schedule.del = true;
			end
		end
		if schedule.del then
			-- remove from heap
			hPop(scheduleDB);
			if schedule.u then
				deleteOnUpdate(schedule);
			else
				deleteSchedule(schedule);
			end
		end
		schedule = scheduleDB[1];
	end
	handleFrame();
end

function Timex:Debug()
	togOpt(self, DEBUG_DB);
	timexDebug = getOpt(self, DEBUG_DB);
	TimexBar:Debug(timexDebug);
	if timexDebug then
		self.cmd:msg("Debug: ON");
	else
		self.cmd:msg("Debug: OFF");
	end
end

--<< ================================================= >>--
-- Section IV: The Timex Schedule Functions.             --
--<< ================================================= >>--

-- changed to support max of 20 arguments (to prevent table creation)
function Timex:AddSchedule(id, t, r, c, f, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
	if id or t then
		local now = getTime();
		-- look for named schedule
		local schedule;
		if id then
			schedule = scheduleMap[id];
		end
		
		if not schedule then
			-- create
			schedule = newSchedule();
			if id then
				scheduleMap[id] = schedule;
			end
			tinsert(scheduleDB, schedule);
			schedule.i = getn(scheduleDB);
		end
		schedule.id = id or this:GetName() or scheduleDB;
		t = t and getNumber(t) or 0;
		t = t >= 0 and t or 0;
		schedule.t, schedule.r, schedule.c = t, r, c and getNumber(c) or nil;
		if f then
			local fType = type(f);
			if fType == "function" then
				schedule.f, schedule.run = f, callFunction;
			elseif fType == "string" then
				schedule.f = self.TriggerEvent;
				if f == TT_UPDATE then
					schedule.e, schedule.run = TT_UPDATE_EVENT, triggerDeprecatedEvent;
				else
					schedule.e, schedule.run = f, triggerEvent;
				end
			else
				error("Timex:AddSchedule: param f is not a function or an event name");
			end
			
			-- check for multi
			if c then
				schedule.runF, schedule.run = schedule.run, runMultiple;
			end
		else
			schedule.run = nil;
		end
		buildArgs(schedule.a, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20);
		-- last update, start time, due time
		schedule.l, schedule.s, schedule.d = now, now, now + t;
		
		-- clear deletion, auto-remove (for onUpdate) flag
		schedule.del = nil;
		schedule.aR = nil;
		
		-- onupdate flag;
		schedule.u = nil;
		
		-- place in scheduleDB
		hMaintain(scheduleDB, schedule.i, schedule);

		handleFrame();
	end
end

function Timex:DeleteSchedule(id)
	local schedule = scheduleMap[id];
	if schedule then
		hDelete(scheduleDB, schedule.i);
		deleteSchedule(schedule);
		handleFrame();
	end
end

function Timex:CheckSchedule(id, r)
	local schedule = scheduleMap[id];
	if schedule then
		if r then
			-- shows the time remaining
			return schedule.d - getTime();
		else
			return true;
		end
	end
end

function Timex:ElapsedScheduleTime(id)
	local now = getTime();
	local schedule = scheduleMap[id];
	if schedule then
		-- show the time elapsed
		return now - schedule.s, schedule.s, now;
	else
		return 0, 0, now;
	end
end

function Timex:RemainingScheduleTime(id)
	local now = getTime();
	local schedule = scheduleMap[id];
	if schedule then
		-- show the time remaining
		return schedule.d - now, schedule.d, now;
	else
		return 0, 0, now;
	end
end

function Timex:ChangeScheduleDuration(id, t)
	local schedule = scheduleMap[id];
	if schedule and t then
		schedule.t, schedule.d = t, schedule.s + t;
		hMaintain(scheduleDB, schedule.i, schedule);
	end
end

function Timex:ChangeScheduleDue(id, d)
	local schedule = scheduleMap[id];
	if schedule then
		schedule.d = d or getTime();
		hMaintain(scheduleDB, schedule.i, schedule);
	end
end

--<< ================================================= >>--
-- Section V: The Timex Timer Functions.                 --
--<< ================================================= >>--
-- largely for Chronos compatibility - plus it's a pretty cool idea!

function Timex:AddTimer(id)
	local now = getTime();
	id = id or this:GetName();
	local timer = timerDB[id];
	if not timer then
		timer = newTable();
		timerDB[id] = timer;
	end
	tinsert(timer, now);
end

function Timex:DeleteTimer(id)
	local now = getTime();
	id = id or this:GetName();
	local timer = timerDB[id];
	local start;
	if timer then
		local start = tremove(timer);
		-- delete timer if it is empt
		if getn(timer) == 0 then
			deleteTable(timer);
			timerDB[id] = nil;
		end
		return now - start, start, now;
	else
		return 0, 0, now;
	end
end

function Timex:GetTimer(id)
	local now = getTime();
	id = id or this:GetName();
	local timer = timerDB[id];
	local start;
	if timer then
		local start = timer[getn(timer)];
		return now - start, start, now;
	else
		return 0, 0, now;
	end
end

function Timex:CheckTimer(id)
	id = id or this:GetName();
	if timerDB[id] then
		return true;
	else
		return false;
	end
end

--<< ================================================= >>--
-- Section VI: The Timex OnUpdate Functions.             --
--<< ================================================= >>--

local function insertOnUpdate(onUpdate)
	-- find first empty spot
	local i, v = 1, onUpdateDB[1];
	while v ~= nil do
		i = i + 1;
		v = onUpdateDB[i];
	end
	onUpdateDB[i], onUpdate.i = onUpdate, i;
end

-- moves the onUpdate to the correct table based on the new rate
local function maintainOnUpdate(onUpdate, rate)
	if rate then
		if not onUpdate.t then
			-- remove from onUpdateDB
			onUpdateDB[onUpdate.i] = nil;
			-- add to scheduleDB
			tinsert(scheduleDB, onUpdate);
			onUpdate.i = getn(scheduleDB);
		end
	elseif onUpdate.t then
		-- remove from scheduleDB and add to onUpdateDB
		hDelete(scheduleDB, onUpdate.i, onUpdate);
		insertOnUpdate(onUpdate);
	end
end

local function setOnUpdateRate(onUpdate, rate, now)
	if rate then
		-- last update, start time, due time
		onUpdate.t, onUpdate.l, onUpdate.s, onUpdate.d = rate, now, now, now + rate;
	
		-- place in scheduleDB
		hMaintain(scheduleDB, onUpdate.i, onUpdate);
	else
		onUpdate.t, onUpdate.l, onUpdate.s, onUpdate.d = nil, nil, nil, nil;
	end
end

function Timex:AddOnUpdate(id, rate, autoRemove, f, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
	if f then
		local now = getTime();
		-- look for named onUpdate
		local onUpdate;
		if id then
			onUpdate = onUpdateMap[id];
		end
		
		if rate then
			rate = getNumber(rate);
			rate = rate > 0 and rate or nil;
		end
		
		if not onUpdate then
			-- create
			onUpdate = newSchedule();
			if id then
				onUpdateMap[id] = onUpdate;
			end
			
			-- insert into scheduleDB or onUpdateDB, depending on whether a rate is specced or not
			if rate then
				tinsert(scheduleDB, onUpdate);
				onUpdate.i = getn(scheduleDB);
			else
				insertOnUpdate(onUpdate);
			end
		else
			maintainOnUpdate(onUpdate, rate);
		end
		onUpdate.id = id or this:GetName() or onUpdateDB;
		onUpdate.aR, onUpdate.f, onUpdate.r, onUpdate.del = autoRemove, f, true, nil;
		
		-- maintain scheduleDB if necessary
		setOnUpdateRate(onUpdate, rate, now);
		
		-- flag as an update schedule
		onUpdate.u = true;

		buildArgs(onUpdate.a, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20);
		handleFrame();
	end
end

function Timex:DeleteOnUpdate(id)
	local onUpdate = onUpdateMap[id];
	if onUpdate then
		if onUpdate.t then
			hDelete(scheduleDB, onUpdate.i);
			deleteOnUpdate(onUpdate);
		else
			onUpdate.del = nil;
			onUpdateDB[onUpdate.i] = nil;
			onUpdateMap[id] = nil;
			unusedSchedules[onUpdate] = true;
		end
		handleFrame();
	end
end

function Timex:ChangeOnUpdateRate(id, rate)
	local onUpdate = onUpdateMap[id];
	if onUpdate then
		local now = getTime();
		if rate then
			rate = getNumber(rate);
			rate = rate > 0 and rate or nil;
		end

		maintainOnUpdate(onUpdate, rate);

		setOnUpdateRate(onUpdate, rate, now);
	end
end

--<< ================================================= >>--
-- Section Omega: Register the AddOn Object.             --
--<< ================================================= >>--

Timex:RegisterForLoad()
