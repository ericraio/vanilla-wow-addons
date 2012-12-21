--[[
--
--	Chronos
--		Keeper of Time
--
--	By Alexander Brazie, Thott and AnduinLothar
--
--	Chronos manages time. You can schedule a function to be called
--	in X seconds, with or without an id. You can request a timer, 
--	which tracks the elapsed duration since the timer was started. 
--	
--	You can also create Tasks - functions which will perform a
--	complex operation over time, reducing system lag if used properly.
--
--	Please see below or see http://www.wowwiki.com/Chronos for details.
--
--	$LastChangedBy: karlkfi $
--	$Date: 2005-11-14 09:01:30 -0800 (Mon, 14 Nov 2005) $
--	$Rev: 2789 $
--	
--]]

CHRONOS_REV = "$Rev: 2789 $";
CHRONOS_DEBUG = false;
CH_DEBUG = "CHRONOS_DEBUG";
CHRONOS_DEBUG_WARNINGS = false;
CH_DEBUG_T = "CHRONOS_DEBUG_WARNINGS";

-- Chronos Data 
ChronosData = {
	-- Initialize the startup time
	elaspedTime = 0;

	-- Initialize the VariablesLoaded flag
	variablesLoaded = false;

	-- Initialize the EnteredWorld flag
	enteredWorld = false;

	-- Last ID
	lastID = nil;
	
	-- Initialize the Timers
	timers = {};

	-- Initialize the perform-over-time task list
	tasks = {};
};
-- Prototype Chronos
Chronos = {
	-- Online or off
	online = true;
	
	-- Maximum items per frame
	MAX_TASKS_PER_FRAME = 100;
	
	-- Maximum steps per task
	MAX_STEPS_PER_TASK = 300;

	-- Maximum time delay per frame
	MAX_TIME_PER_STEP = .3;
	
	emptyTable = {};
	
	getArgTable = function(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
		if (( a1 == nil ) and ( a2 == nil ) and ( a3 == nil ) and ( a4 == nil ) and ( a5 == nil ) and ( a6 == nil ) and ( a7 == nil ) and ( a8 == nil ) and ( a9 == nil ) and ( a10 == nil ) and ( a11 == nil ) and ( a12 == nil ) and ( a13 == nil ) and ( a14 == nil ) and ( a15 == nil ) and ( a16 == nil ) and ( a17 == nil ) and ( a18 == nil ) and ( a19 == nil ) and ( a20 == nil )) then
			return Chronos.emptyTable;
		else
			local args = {};
			table.setn(args, 0);
			table.insert(args, a1);
			table.insert(args, a2);
			table.insert(args, a3);
			table.insert(args, a4);
			table.insert(args, a5);
			table.insert(args, a6);
			table.insert(args, a7);
			table.insert(args, a8);
			table.insert(args, a9);
			table.insert(args, a10);
			table.insert(args, a11);
			table.insert(args, a12);
			table.insert(args, a13);
			table.insert(args, a14);
			table.insert(args, a15);
			table.insert(args, a16);
			table.insert(args, a17);
			table.insert(args, a18);
			table.insert(args, a19);
			table.insert(args, a20);
			return args;
		end
	end;
	
	--
	-- pop ( table )
	--
	-- 	Removes a value and returns it from the table
	-- Arg:
	-- 	table - the table
	--
	--	duplicated from Sea
	pop = function (table1)
		if(not table1) then
			Chronos.printDebugError(nil, "Bad table passed to pop");
			return nil;
		end
		local n = table.getn(table1);
		if(not n) then
			Chronos.printDebugError(nil, "Bad table.getn() passed to pop");
			return nil;
		end
		if ( n == 0 ) then 
			return nil;
		end

		local v = table1[n];
		table.setn(table1, n-1)
		--Doesn't nil the entry like table.remove, so it's never garbace collected and can be replaced
		--v = table.remove(table1);
		return v;		
	end;
	
	printError = function (text)
		ChatFrame1:AddMessage(text, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, 1.0, UIERRORS_HOLD_TIME);
	end;
	
	printDebugError = function (var, text)
		if (var) and (getglobal(var)) then
			Chronos.printError(text);
		end
	end;
	
	debug = function (enable)
		if (enable) then
			Chronos_OnUpdate = Chronos_OnUpdate_Debug;
			CHRONOS_DEBUG = true;
			CHRONOS_DEBUG_WARNINGS = true;
		else
			Chronos_OnUpdate = Chronos_OnUpdate_Quick;
			CHRONOS_DEBUG = false;
			CHRONOS_DEBUG_WARNINGS = false;
		end
	end;
	
	--[[
	-- Scheduling functions
	-- Parts rewritten by AnduinLothar for efficiency
	-- Parts rewritten by Thott for speed
	-- Written by Alexander
	-- Original by Thott
	--
	-- Usage: Chronos.schedule(when,handler,arg1,arg2,etc)
	--
	-- After <when> seconds pass (values less than one and fractional values are
	-- fine), handler is called with the specified arguments, i.e.:
	--	 handler(arg1,arg2,etc)
	--
	-- If you'd like to have something done every X seconds, reschedule
	-- it each time in the handler or preferably use scheduleRepeating.
	--
	-- Also, please note that there is a limit to the number of
	-- scheduled tasks that can be performed per xml object at the
	-- same time. 
	--]]
	schedule = function (when,handler,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
		if ( not Chronos.online ) then 
			return;
		end
		if ( not handler) then
			Chronos.printError("ERROR: nil handler passed to Chronos.schedule()");
			return;
		end
				
		--local memstart = gcinfo();
		-- -- Assign an id
		-- local id = "";
		-- if ( not this ) then 
		-- 	id = "Keybinding";
		-- else
		-- 	id = this:GetName();
		-- end
		-- if ( not id ) then 
		-- 	id = "_DEFAULT";
		-- end
		-- if ( not when ) then 
		-- 	Chronos.printDebugError(CH_DEBUG_T, "Chronos Error Detection: ", id , " has sent no interval for this function. ", when );
		-- 	return;
		-- end

		-- -- Ensure we're not looping ChronosFrame
		-- if ( id == "ChronosFrame" and ChronosData.lastID ) then 
		-- 	id = ChronosData.lastID;
		-- end

		local task;
		-- reuse task memory if possible to avoid excessive garbage collection --Thott
		if(not ChronosData.sched[ChronosData.sched.n+1]) then
			ChronosData.sched[ChronosData.sched.n+1] = {};
		end
		ChronosData.sched.n = ChronosData.sched.n+1;
		local i = ChronosData.sched.n;
		-- ChronosData.sched[i].id = id;
		ChronosData.sched[i].time = when + GetTime();
		ChronosData.sched[i].handler = handler;
		ChronosData.sched[i].args = Chronos.getArgTable(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);

		-- task list is a heap, add new --Thott
		while(i > 1) do
			parent = floor(i/2);
			if(ChronosData.sched[parent].time > ChronosData.sched[i].time) then
				Chronos_Swap(i,parent);
			else
				break;
			end
			i = parent;
		end
		
		-- Debug print
		--Chronos.printDebugError(CH_DEBUG, "Scheduled ", handler," in ",when," seconds from ", id );
		--Chronos.printError("Memory change in schedule: ",memstart,"->",memend," = ",memend-memstart);
	end;
	

	--[[
	--	Chronos.scheduleByName(name, delay, function, arg1, ... );
	--
	-- Same as Chronos.schedule, except it takes a schedule name argument.
	-- Only one event can be scheduled with a given name at any one time.
	-- Thus if one exists, and another one is scheduled, the first one
	-- is deleted, then the second one added.
	--
	--]]
	scheduleByName = function (name,when,handler,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
		if ( not name ) then 
			Chronos.printDebugError(CH_DEBUG_T,"Chronos Error Detection: No name specified to Chronos.scheduleByName");
			return;
		end
		if(ChronosData.byName[name] and handler) then
			Chronos.printDebugError(CH_DEBUG_T,"Chronos Error Detection: scheduleByName is reasigning '".. name.."'.");
			ChronosData.byName[name] = { time = when+GetTime(), handler = handler, arg = Chronos.getArgTable(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20); };
		else
			if ( not handler ) then
				if ( not ChronosData.byName[name] ) then
					Chronos.printDebugError(CH_DEBUG_T,"Chronos Error Detection: No handler specified to Chronos.scheduleByName, no previous entry found for scheduled entry '".. name.."'.");
					return;
				end
				if ( not ChronosData.byName[name].handler ) then
					Chronos.printDebugError(CH_DEBUG_T,"Chronos Error Detection: No handler specified to Chronos.scheduleByName, no handler could be found in previous entry of '".. name.."' either.");
					return;
				end
				handler = ChronosData.byName[name].handler;
				Chronos.printDebugError(CH_DEBUG_T,"Chronos: scheduleByName is updating '".. name.."' to time: ".. when);
			else
				Chronos.printDebugError(CH_DEBUG_T,"Chronos: scheduleByName is asigning '".. name.."'.");
			end
			ChronosData.byName[name] = { time = when+GetTime(), handler = handler, arg = Chronos.getArgTable(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20); };
		end
	end;



	--[[
	--	unscheduleByName(name);
	--
	--		Removes an entry that was created with scheduleByName()
	--
	--	Args:
	--		name - the name used
	--
	--]]
	unscheduleByName = function(name)
		if ( not Chronos.online ) then 
			return;
		end
		if ( not name ) then 
			Chronos.printError("No name specified to Chronos.unscheduleByName");
			return;
		end
		if(ChronosData.byName[name]) then
			ChronosData.byName[name] = nil;
		end
		
		-- Debug print
		--Chronos.printDebugError(CH_DEBUG, "Cancelled scheduled timer of name ",name);
	end;

	--[[
	--	isScheduledByName(name)
	--		Returns the amount of time left if it is indeed scheduled by name!
	--
	--	returns:
	--		number - time remaining
	--		nil - not scheduled
	--
	--]]
	isScheduledByName = function (name)
		if ( not Chronos.online ) then 
			return;
		end
		if ( not name ) then 
			Chronos.printError("No name specified to Chronos.isScheduledByName ", this:GetName());
			return;
		end
		if(ChronosData.byName[name]) then
			return ChronosData.byName[name].time - GetTime();
		end
		
		-- Debug print
		--Chronos.printDebugError(CH_DEBUG, "Did not find timer of name ",name);
		return nil;
	end;
	
	--[[
	--	Chronos.scheduleRepeating(name, delay, function);
	--
	-- Same as Chronos.scheduleByName, except it repeats without recalling and takes no arguments.
	--
	--]]
	scheduleRepeating = function (name,when,handler)
		if ( not name ) then 
			Chronos.printDebugError(CH_DEBUG_T,"Chronos Error Detection: No name specified to Chronos.scheduleRepeating");
			return;
		end
		if(ChronosData.byName[name] and handler) then
			Chronos.printDebugError(CH_DEBUG_T,"Chronos Error Detection: scheduleRepeating is reasigning ".. name);
			ChronosData.byName[name] = { time = when+GetTime(), period = when, handler = handler, repeating = true };
		else
			if ( not handler ) then
				if ( not ChronosData.byName[name] ) then
					Chronos.printDebugError(CH_DEBUG_T,"Chronos Error Detection: No handler specified to Chronos.scheduleRepeating, no previous entry found for scheduled entry '".. name.."'.");
					return;
				end
				if ( not ChronosData.byName[name].handler ) then
					Chronos.printDebugError(CH_DEBUG_T,"Chronos Error Detection: No handler specified to Chronos.scheduleRepeating, no handler could be found in previous entry '".. name.."' either.");
					return;
				end
				handler = ChronosData.byName[name].handler;
				Chronos.printDebugError(CH_DEBUG_T,"Chronos: scheduleRepeating is updating '".. name.."' to time: ".. when);
			else
				Chronos.printDebugError(CH_DEBUG_T,"Chronos: scheduleRepeating is asigning '".. name.."'.");
			end
			ChronosData.byName[name] = { time = when+GetTime(), period = when, handler = handler, repeating = true };
		end
	end;
	
	--[[
	--	Chronos.flushByName(name, when);
	--
	-- Updates the ByName or Repeating event to flush at the time specified.  If no time is specified flush will be immediate. If it is a Repeating event the timer will be reset.
	--
	--]]
	flushByName = function (name,when)
		if ( not name ) then 
			Chronos.printDebugError(CH_DEBUG_T,"Chronos Error Detection: No name specified to Chronos.flushByName");
			return;
		elseif ( not ChronosData.byName[name] ) then
			Chronos.printDebugError(CH_DEBUG_T,"Chronos Error Detection: no previous entry found for Chronos.flushByName entry '".. name.."'.");
			return;
		end
		if (not when) then
			Chronos.printDebugError(CH_DEBUG_T,"Chronos: flushing '".. name.."'.");
			when = GetTime();
		else
			Chronos.printDebugError(CH_DEBUG_T,"Chronos: flushing '".. name.."' in "..when.." seconds.");
			when = when+GetTime();
		end
		ChronosData.byName[name].time = when;
	end;

	--[[
	--	Chronos.startTimer([ID]);
	--		Starts a timer on a particular
	--
	--	Args
	--		ID - optional parameter to identify who is asking for a timer.
	--		
	--		If ID does not exist, this:GetName() is used. 
	--
	--	When you want to get the amount of time passed since startTimer(ID) is called, 
	--	call getTimer(ID) and it will return the number in seconds. 
	--
	--]]
	startTimer = function ( id ) 
		if ( not Chronos.online ) then 
			return;
		end

		if ( not id ) then 
			id = this:GetName();
		end

		-- Create a table for this id's timers
		if ( not ChronosData.timers[id] ) then
			ChronosData.timers[id] = {};
			ChronosData.timers[id].n = 0;
		end

		-- Clear out an entry if the table is too big.
		if (ChronosData.timers[id].n > Chronos.MAX_TASKS_PER_FRAME) then
			Chronos.printError("Too many Chronos timers created for id ",id);
			return;
		end

		-- Add a new timer entry 
		table.insert(ChronosData.timers[id],GetTime());
	end;


	--[[
	--	endTimer([id]);
	-- 
	--		Ends the timer and returns the amount of time passed.
	--
	--	args:
	--		id - ID for the timer. If not specified, then ID will
	--		be this:GetName()
	--
	--	returns:
	--		(Number delta, Number start, Number end)
	--
	--		delta - the amount of time passed in seconds.
	--		start - the starting time 
	--		now - the time the endTimer was called.
	--]]

	endTimer = function( id ) 
		if ( not Chronos.online ) then 
			return;
		end

		if ( not id ) then 
			id = this:GetName();
		end

		if ( not ChronosData.timers[id] or ChronosData.timers[id].n == 0) then
			return nil;
		end
	
		local now = GetTime();

		-- Grab the last timer called
		local startTime = Chronos.pop(ChronosData.timers[id]);

		return (now - startTime), startTime, now;
	end;


	--[[
	--	getTimer([id]);
	-- 
	--		Gets the timer and returns the amount of time passed.
	--		Does not terminate the timer.
	--
	--	args:
	--		id - ID for the timer. If not specified, then ID will
	--		be this:GetName()
	--
	--	returns:
	--		(Number delta, Number start, Number end)
	--
	--		delta - the amount of time passed in seconds.
	--		start - the starting time 
	--		now - the time the endTimer was called.
	--]]

	getTimer = function( id ) 
		if ( not Chronos.online ) then 
			return;
		end

		if ( not id ) then 
			id = this:GetName();
		end

		local now = GetTime();
		if ( not ChronosData.timers[id] or ChronosData.timers[id].n == 0) then
			return 0,0,now;
		end
	
		-- Grab the last timer called
		local startTime = ChronosData.timers[id][ChronosData.timers[id].n];

		return (now - startTime), startTime, now;
	end;
	
	--[[
	--	isTimerActive([id])
	--		returns true if the timer exists. 
	--		
	--	args:
	--		id - ID for the timer. If not specified, then ID will
	--		be this:GetName()
	--
	--	returns:
	--		true - exists
	--		false - does not
	--]]
	isTimerActive = function ( id ) 
		if ( not Chronos.online ) then 
			return;
		end

		if ( not id ) then 
			id = this:GetName();
		end

		-- Create a table for this id's timers
		if ( not ChronosData.timers[id] ) then
			return false;
		end

		return true;
	end;

	--[[
	--	getTime()
	--
	--		returns the Chronos internal elapsed time.
	--
	--	returns:
	--		(elaspedTime)
	--		
	--		elapsedTime - time in seconds since Chronos initialized
	--]]
	
	getTime = function() 
		return ChronosData.elapsedTime;
	end;

	--[[
	--	Chronos.everyFrame(func,arg1,...)
	--
	--		runs func(arg1,...) every frame until func returns true.
	--		This is the most effecient way to have something run 
	--		every frame, either forever, or until some job is done.
	--
	--	By Thott
	--]]
	everyFrame = function(func,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
		table.insert(ChronosData.everyFrame,{func=func,arg=Chronos.getArgTable(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)});
	end;

	--[[
	--	performTask( TaskObject );
	--		
	--		Queues up a task to be completed over time. 
	--		Contains a before and after function 
	--		to be called when the task is started and
	--		completed.
	--		
	--	Args:
	--		TaskObject - a table containing:
	--		{
	--		 (Required:)
	--		  step - function to be performed, must be fast
	--
	--		  isDone - function which determines if the 
	--		  	task is completed. 
	--		  	Returns true when done
	--		  	Returns false if the task should continue
	--		  	 to call step() each frame. 
	--		  
	--
	--		 (Optional:)
	--		  stepArgs - arguments to be passed to step
	--		  doneArgs - arguments to be passed to isDone
	--
	--		  before - function called before the first step
	--		  beforeArgs - arguments passed to Before
	--
	--		  after - function called when isDone returns true
	--		  afterArgs - arguments passed
	--
	--		  limit - a number defining the maximum number
	--		  	of steps that will be peformed before
	--		  	the task is removed to prevent lag.
	--		  	(Defaults to 100)
	--		}
	--]]

	performTask = function (taskTable, name) 
		if ( not Chronos.online ) then 
			return;
		end

		-- Valid table?
		if ( not taskTable ) then
			Chronos.printError("Chronos Error Detection: Invalid table to Chronos.peformTask", this:GetName());
			return nil;
		end

		-- Must contain a step function
		if ( not taskTable.step or type(taskTable.step) ~= "function" ) then 
			Chronos.printDebugError(CH_DEBUG_T,"Chronos Error Detection: You must specify a step function to be called to perform the task. (",this:GetName(),")");
			return nil;
		end
		
		-- Must contain a completion function
		if ( not taskTable.isDone or type(taskTable.isDone) ~= "function" ) then 
			Chronos.printDebugError(CH_DEBUG_T,"Chronos Error Detection: You must specify an isDone function to be called to indicate if the task is complete. (",this:GetName(),")");
			return nil;
		end

		-- Get an ID
		if ( not name ) then 
			name = this:GetName();
		end

		-- Set the limit
		if ( not taskTable.limit ) then 
			taskTable.limit = Chronos.MAX_STEPS_PER_TASK;
		end
		
		local foundId = nil;

		for i=1,table.getn(ChronosData.tasks) do 
			if ( ChronosData.tasks[i].name == id ) then 
				foundId = i;
			end
		end
		
		-- Add it to the task list
		if ( not foundId ) then 
			taskTable.name = name;
			table.insert(ChronosData.tasks, taskTable);
			return true;
		elseif ( not ChronosData.tasks[foundId].errorSent ) then
			ChronosData.tasks[foundId].errorSent = true;
			Chronos.printError("Chronos Error Detection: There's already a task with the ID: ", name );
			return nil;
		end
	end;

	--[[
	--	Chronos.afterInit(func, ...)
	--		Performs func after the game has truely started.
	--	By Thott
	--]]
	afterInit = function (func, a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
		local id;
		if(this) then
			id = this:GetName();
		else
			id = "unknown";
		end
		--if(id == "SkyFrame") then
		--	Chronos.printError("Ignoring Sky init");
		--	return;
		--end
		if(ChronosData.initialized) then
			func(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);
		else
			if(not ChronosData.afterInit) then
				ChronosData.afterInit = {};
				ChronosData.afterInit.n = 0;
				Chronos.schedule(0.2,Chronos_InitCheck);
			end
			local n = ChronosData.afterInit.n+1;
			ChronosData.afterInit[n] = {};
			ChronosData.afterInit[n].func = func;
			ChronosData.afterInit[n].args = Chronos.getArgTable(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);
			ChronosData.afterInit[n].id = id;
			ChronosData.afterInit.n = n;
		end
	end;
};

--[[
--	unscheduleRepeating(name);
--		Mirrors unscheduleByName for backwards compatibility
--]]
Chronos.unscheduleRepeating = Chronos.unscheduleByName;

--[[
--	isScheduledRepeating(name)	
--		Mirrors isScheduledByName for backwards compatibility
--]]
Chronos.isScheduledRepeating = Chronos.isScheduledByName;

--[[ Event Handlers ]]--
function Chronos_OnLoad()
	Chronos.framecount = 0;

	ChronosData.byName = {};
	ChronosData.repeating = {};
	ChronosData.tasks = {};
	ChronosData.tasks.n = 0;
	ChronosData.sched = {};
	ChronosData.sched.n = 0;
	ChronosData.elapsedTime = 0;
	ChronosData.variablesLoaded = false;
	ChronosData.everyFrame = {};
	ChronosData.everyFrame.n = 0;

	--[[ Convert Revision to Numeric ]]--
	if (convertRev) then
		convertRev("CHRONOS_REV");
	end

	Chronos.afterInit(Chronos_SkyRegister);
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
end

function Chronos_OnEvent(event)
	if(event == "VARIABLES_LOADED") then
		ChronosData.variablesLoaded = true;
		ChronosFrame:Show();
	elseif (event == "PLAYER_ENTERING_WORLD") then
		ChronosData.enteredWorld = true;
		ChronosData.online = true;
	elseif (event == "PLAYER_LEAVING_WORLD") then
		ChronosData.online = false;
	end	
end

function Chronos_InitCheck()
	if(not ChronosData.initialized) then
		if(UnitName("player") and UnitName("player")~=UKNOWNBEING and UnitName("player")~=UNKNOWNBEING and UnitName("player")~=UNKNOWNOBJECT and ChronosData.variablesLoaded and ChronosData.enteredWorld) then
			ChronosData.initialized = true;
			Chronos.schedule(1,Chronos_InitCheck); 
			return;
		else
			Chronos.schedule(0.2,Chronos_InitCheck); 
			return;
		end
	end
	if(ChronosData.afterInit) then
		local i = ChronosData.afterInit_i;
		if(not i) then
			i = 1;
		end
		ChronosData.afterInit_i = i+1;
		--Chronos.printError("afterInit: processing ",i," of ",ChronosData.afterInit.n," initialization functions, id: ",ChronosData.afterInit[i].id);
		Chronos_Run(ChronosData.afterInit[i].func,ChronosData.afterInit[i].args);
		if(i == ChronosData.afterInit.n) then
			ChronosData.afterInit = nil;
			ChronosData.afterInit_i = nil;
		else
			Chronos.schedule(0.1,Chronos_InitCheck);
			return;
		end
	end
end;
function Chronos_Run(func,arg)
	if(func) then
		if(arg) then
			return func(unpack(arg));
		else
			return func();
		end
	end
end
function Chronos_Swap(i,j)
	local t = ChronosData.sched[i];
	ChronosData.sched[i] = ChronosData.sched[j];
	ChronosData.sched[j] = t;
end
function Chronos_PopTask()
	if(ChronosData.sched.n == 1) then
		ChronosData.sched.n = 0;
		return 1;
	end
	Chronos_Swap(1,ChronosData.sched.n);
	ChronosData.sched.n = ChronosData.sched.n - 1;
	local i = 1;
	local new;
	while(ChronosData.sched[i] and i <= ChronosData.sched.n) do
		new = i*2;
		if(new > ChronosData.sched.n) then
			break;
		elseif(new < ChronosData.sched.n) then
			if(ChronosData.sched[new+1].time < ChronosData.sched[new].time) then
				new = new + 1;
			end
		end
		if(ChronosData.sched[new].time < ChronosData.sched[i].time) then
			Chronos_Swap(i,new);
			i = new;
		else
			break;
		end
	end
	return ChronosData.sched.n+1;
end

function Chronos_OnUpdate_Quick(dt)
	--local memstart = gcinfo();
	if ( not Chronos.online ) then 
		return;
	end
	if ( ChronosData.variablesLoaded == false ) then 
		return;
	end
	
	if ( ChronosData.elapsedTime ) then
		ChronosData.elapsedTime = ChronosData.elapsedTime + dt;
	else
		ChronosData.elapsedTime = dt;
	end

	-- execute all the everyFrame tasks, deleting any that return true.
	for i=1,ChronosData.everyFrame.n do
		if(Chronos_Run(ChronosData.everyFrame[i].func,ChronosData.everyFrame[i].arg)) then
			-- delete
			ChronosData.everyFrame[i] = Chronos.pop(ChronosData.everyFrame);
		end
	end

	local now = GetTime();
	local i;
	-- Execute scheduled tasks that are ready, popping them off the heap.
	while(ChronosData.sched.n > 0) do
		if(ChronosData.sched[1].time <= now) then
			i = Chronos_PopTask();
			Chronos_Run(ChronosData.sched[i].handler,ChronosData.sched[i].args);
		else
			break;
		end
	end
	
	-- Execute named scheduled tasks that are ready.
	local k,v = next(ChronosData.byName);
	local newK, newV;
	while (k ~= nil) do
		newK,newV = next(ChronosData.byName, k);
		if(v.time <= now) then
			if (v.repeating) then
				ChronosData.byName[k].time = now + v.period;
				v.handler();
			else
				local y = v;
				ChronosData.byName[k] = nil;
				Chronos_Run(y.handler,y.arg);
			end
		end
		k,v = newK,newV;
	end
	
	local timeThisUpdate = 0;
	local largest = 0;
	local largestName = nil;

	-- Perform tasks if the time limit is not exceeded
	-- Only perform each task once at most per update
	-- 
	for i=1, table.getn(ChronosData.tasks) do
		-- Perform a task
		runTime = Chronos_OnUpdate_Tasks(timeThisUpdate);
		timeThisUpdate = timeThisUpdate + runTime;

		-- Check if this was the biggest hog yet
		if ( runTime > largest ) then 
			largest = runTime;
			largestName = i;
		end

		-- Check if we've overrun our limit
		if ( timeThisUpdate > Chronos.MAX_TIME_PER_STEP ) then
			Chronos.printDebugError(CH_DEBUG_T,"Chronos Warning: Maximum cpu usage time exceeded on task. Largest task was: ", largestName );
			break;
		end
	end
end

Chronos_OnUpdate = Chronos_OnUpdate_Quick;

function memcheck(memstart,where)
	local memend = gcinfo();
	if(memstart ~= memend) then
		Chronos.printError("Memory change in ",where,": ",memstart,"->",memend," = ",memend-memstart);
	end
	return gcinfo();
end

function Chronos_OnUpdate_Debug(dt)
	local memstart = gcinfo();
	if ( not Chronos.online ) then 
		return;
	end
	if ( ChronosData.variablesLoaded == false ) then 
		return;
	end
	
	if ( ChronosData.elapsedTime ) then
		ChronosData.elapsedTime = ChronosData.elapsedTime + dt;
	else
		ChronosData.elapsedTime = dt;
	end

	local timeThisUpdate = 0;
	local largest = 0;
	local largestName = nil;

	-- execute all the everyFrame tasks, deleting any that return true.
	for i=1,ChronosData.everyFrame.n do
		if(Chronos_Run(ChronosData.everyFrame[i].func,ChronosData.everyFrame[i].arg)) then
			-- delete
			ChronosData.everyFrame[i] = Chronos.pop(ChronosData.everyFrame);
		end
	end

	local now = GetTime();
	local i;
	-- Execute scheduled tasks that are ready, popping them off the heap.
	while(ChronosData.sched.n > 0) do
		if(ChronosData.sched[1].time <= now) then
			i = Chronos_PopTask();
			Chronos_Run(ChronosData.sched[i].handler,ChronosData.sched[i].args);
		else
			break;
		end
	end
	
	-- Execute named scheduled tasks that are ready.
	local memstart = gcinfo();
	local k,v = next(ChronosData.byName);
	local newK, newV;
	while (k ~= nil) do
		newK,newV = next(ChronosData.byName, k);
		if(v.time <= now) then
			local m = gcinfo();
			if (v.repeating) then
				ChronosData.byName[k].time = now + v.period;
				v.handler();
			else
				local y = v;
				ChronosData.byName[k] = nil;
				Chronos_Run(y.handler,y.arg);
			end
			local mm = gcinfo();
			memstart = memstart + mm - m;
		end
		k,v = newK,newV;
	end
	local memend = gcinfo();
	if(memend - memstart > 0) then
		Sea.io.print("gcmemleak from ChronosData.byName in OnUpdate: ",memend - memstart);
	end

	local largest = 0;
	local largestName = nil;

	-- Perform tasks if the time limit is not exceeded
	-- Only perform each task once at most per update
	-- 
	memstart = memcheck(memstart,"OnUpdate, after all scheduled tasks, before Chronos tasks");
	local ctn = table.getn(ChronosData.tasks);
	for i=1, ctn do
		-- Perform a task
		runTime = Chronos_OnUpdate_Tasks(timeThisUpdate);
		timeThisUpdate = timeThisUpdate + runTime;

		-- Check if this was the biggest hog yet
		if ( runTime > largest ) then 
			largest = runTime;
			largestName = i;
		end

		-- Check if we've overrun our limit
		if ( timeThisUpdate > Chronos.MAX_TIME_PER_STEP ) then
			Chronos.printDebugError(CH_DEBUG_T,"Chronos Warning: Maximum cpu usage time exceeded on task. Largest task was: ", largestName );
			break;
		end

		if ( largestName ) then
			-- ### Remove later for efficiency
			--Chronos.printDebugError(CH_DEBUG, " Largest named task: ", largestName );
		end
	end
	memstart = memcheck(memstart,"OnUpdate, end");
end

-- Updates a single task
function Chronos_OnUpdate_Tasks(timeThisUpdate)
	if ( not Chronos.online ) then 
		return;
	end

	-- Lets start the timer
	Chronos.startTimer();

	-- Execute the first task
	if ( ChronosData.tasks[1] ) then
		-- Obtains the first task
		local task = table.remove(ChronosData.tasks, 1);

		-- Start the task if not yet started
		if ( not task.started ) then 
			Chronos_Run(task.before,task.beforeArgs);

			-- Mark the task as started
			task.started = true;
		end

		-- Perform a step in the task
		Chronos_Run(task.step,task.stepArgs);
			
		-- Check if the task is completed.
		if ( task.isDone() ) then
			-- Call the after-task
			if ( task.after ) then
				if ( task.afterArgs ) then 
					task.after(unpack(task.afterArgs) );
				else
					task.after();
				end
			end
		else
			if ( not task.count ) then 
				task.count = 1; 
			else
				task.count = task.count + 1; 				
			end

			if ( task.count < task.limit ) then 
				-- Move them to the back of the list
				table.insert(ChronosData.tasks, task);
			else
				Chronos.printDebugError(CH_DEBUG_T, "Task killed due to limit-break: ", task.name ); 
			end
		end
	end

	-- End the timer
	return Chronos.endTimer();		
end

-- Command Registration
-- Notes to self: 
-- 	* Relocate to its own module?
-- 	

function Chronos_SkyRegister()
	local chronosFunc = function(msg)
		local _,_,seconds,command = string.find(msg,"([%d\.]+)%s+(.*)");
		if(seconds and command) then
			Chronos.schedule(seconds,Chronos_SendChatCommand,command);
		else
			Chronos.printError(SCHEDULE_USAGE1);
			Chronos.printError(SCHEDULE_USAGE2);
		end
	end
	if(Sky) then
		Sky.registerSlashCommand(
			{
				id = "Schedule";
				commands = SCHEDULE_COMM;
				onExecute = chronosFunc;
				helpText = SCHEDULE_DESC;
			}
		);
	else
		SlashCmdList["CHRONOS_SCHEDULE"] = chronosFunc;
		for i = 1, table.getn(SCHEDULE_COMM) do setglobal("SLASH_CHRONOS_SCHEDULE"..i, SCHEDULE_COMM[i]); end
	end
end

--[[
--	Sends a chat command through the standard 
--]]
function Chronos_SendChatCommand(command)
	local text = ChatFrameEditBox:GetText();
	ChatFrameEditBox:SetText(command);
	ChatEdit_SendText(ChatFrameEditBox);
	ChatFrameEditBox:SetText(text);
end

