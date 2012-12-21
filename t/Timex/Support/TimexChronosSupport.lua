--<< ================================================= >>--
-- Section I: Chronos Support.                           --
--<< ================================================= >>--

local EMPTY_TABLE = {};
local DEFAULT_TASK_LIMIT = 100;
local RUN_COUNT = 1;
local TIMER_PREFIX = "ChronosTimer_";

local getTime = GetTime;

local function doTask(task, name)
	if (not task[RUN_COUNT]) then
		if (task.before) then
			task.before(unpack(task.beforeArgs));
		end
		task[RUN_COUNT] = 0;
	end
	task.step(unpack(task.stepArgs));
	task[RUN_COUNT] = task[RUN_COUNT] + 1;
	if (task.isDone(unpack(task.doneArgs))) then
		Timex:DeleteSchedule(name);
		task[RUN_COUNT] = nil;
		if task.after then
			task.after(unpack(task.afterArgs));
		end
	elseif (task[RUN_COUNT] > task.limit) then
		Timex:DeleteSchedule(name);
		task[RUN_COUNT] = nil;
	end
end

if not Chronos then
	Chronos = AceAddon:new({
		initTime = getTime(),
		isScheduledByName    = function(n)
			local e = Timex:RemainingScheduleTime(n);
			return e;
		end,
		scheduleByName       = function(n, t, f, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
			Timex:AddSchedule(n, t, nil, nil, f, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20);
		end,
		schedule             = function(t, f, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
			Chronos.scheduleByName(nil, t, f, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20);
		end,
		unscheduleByName     = function(n)
			Timex:DeleteSchedule(n);
		end,
		flushByName          = function(n, w)
			Timex:ChangeScheduleDue(n, w);
		end,

		scheduleRepeating    = function(n, t, f)
			Timex:AddSchedule(n, t, true, nil, f);
		end,

		getTimer             = function(id)
			return Timex:GetTimer(id);
		end,
		startTimer           = function(id)
			Timex:AddTimer(id);
		end,
		endTimer             = function(id)
			return Timex:DeleteTimer(id);
		end,
		isTimerActive        = function(id)
			return Timex:TimerCheck(id);
		end,

		getTime              = function()
			return getTime() - Chronos.initTime;
		end,

		everyFrame           = function(f, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
			Timex:AddOnUpdate(nil, nil, true, f, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20);
		end,
		
		afterInit            = function(f, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
			Timex:AddStartupFunc(f, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20);
		end,
		
		performTask          = function(t, n)
			if not n then
				n = t;
			end
			if not t.step then
				error("step function is required for Chronos.performTask");
			elseif not t.isDone then
				error("isDone function is required for Chronos.performTask");
			end
			t.stepArgs = t.stepArgs or EMPTY_TABLE;
			t.doneArgs = t.doneArgs or EMPTY_TABLE;
			t.beforeArgs = t.beforeArgs or EMPTY_TABLE;
			t.afterArgs = t.afterArgs or EMPTY_TABLE;
			t.limit = t.limit or DEFAULT_TASK_LIMIT;
			Timex:AddSchedule(n, 0, TRUE, nil, doTask, t, n);
		end
	});
	Chronos.unscheduleRepeating  = Chronos.unscheduleByName;
	Chronos.isScheduledRepeating = Chronos.isScheduledByName;

	
	ChronosData = {
		-- Initialize the VariablesLoaded flag
		variablesLoaded = false;

		-- Initialize the EnteredWorld flag
		enteredWorld = false;
	}
	
	function Chronos:Initialize()
		Timex:AddStartupFunc(function()
			ChronosData.variablesLoaded = true;
		end);
	end
	
	function Chronos:Enable()
		Chronos:RegisterEvent("PLAYER_ENTERING_WORLD");
		Chronos:RegisterEvent("PLAYER_LEAVING_WORLD");
	end
	
	function Chronos:PLAYER_ENTERING_WORLD()
		ChronosData.enteredWorld = true;
		ChronosData.online = true;
	end
	
	function Chronos:PLAYER_LEAVING_WORLD()
		ChronosData.online = false;
	end
end;

--<< ================================================= >>--
-- Section Omega: Closure.                               --
--<< ================================================= >>--