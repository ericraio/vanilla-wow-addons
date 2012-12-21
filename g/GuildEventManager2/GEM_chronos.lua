--[[
  Guild Event Manager by Kiki of European Cho'gall (Alliance)
    Chronos module
]]

--[[
 Schedule code - Taken from Chronos By Alexander Brazie
]]

-- GEMSystem Data 
GEMSystem_Data = {
	-- Initialize the startup time
	elaspedTime = 0;

	-- Last ID
	lastID = nil;
	
	-- Initialize the Timers
	timers = {};

	-- Intialize the anonymous todo list
	anonTodo = {};
};

function GEMSystem_OnLoad()
  GEMSystem_Data.elapsedTime = 0;
end

function GEMSystem_startTimer(id)
  if ( not id ) then 
    id = this:GetName();
  end

  -- Create a table for this id's timers
  if ( not GEMSystem_Data.timers[id] ) then
    GEMSystem_Data.timers[id] = {};
  end

  -- Clear out an entry if the table is too big.
  if ( table.getn(GEMSystem_Data.timers[id]) >= 100) then
    table.remove(GEMSystem_Data.timers[id], 1 );
  end

  -- Add a new timer entry 
  table.insert(GEMSystem_Data.timers[id], GetTime() );		
end

function GEMSystem_endTimer(id) 
  if ( not id ) then 
    id = this:GetName();
  end
  
  -- Create a table for this id's timers
  if ( not GEMSystem_Data.timers[id] ) then
    GEMSystem_Data.timers[id] = {};
  end
  
  -- Check to see if there is any timers started
  if ( table.getn(GEMSystem_Data.timers[id]) == 0 ) then
    return 0, GetTime(), GetTime();
  end
  
  -- Grab the last timer called
  local startTime = table.remove ( GEMSystem_Data.timers[id] );
  local now = GetTime();
  
  return (now - startTime), startTime, now;
end


function GEMSystem_OnUpdate(dt)
  if ( GEMSystem_Data.elapsedTime ) then
    GEMSystem_Data.elapsedTime = GEMSystem_Data.elapsedTime + dt;
  else
    GEMSystem_Data.elapsedTime = dt;
  end

  local timeThisUpdate = 0;
  local largest = 0;
  local largestName = nil;
  
  if ( not GEMSystem_Data.anonTodo ) then 
    GEMSystem_Data.anonTodo = {};
  end

  -- Handle Anonymous Scheduled Tasks
  for k,v in GEMSystem_Data.anonTodo do 
    GEMSystem_Data.lastID = k;
    -- Call all handlers whose time has been exceeded
    while(v[1] and v[1].time <= GetTime()) do
      -- Lets start the timer
      GEMSystem_startTimer();
    
      local todo = table.remove(v,1);
      if(todo.args) then
        if ( todo.handler ) then 
          todo.handler(unpack(todo.args));
        end
      else
        if ( todo.handler ) then 
          todo.handler();
        end
      end
      -- End the timer
      local runTime = GEMSystem_endTimer();
    
      -- Update the elapsed time
      timeThisUpdate = timeThisUpdate + runTime;
    
      -- Check if this was the biggest hog yet
      if ( runTime > largest ) then 
        largest = runTime;
        largestName = k;
      end
    
      -- Check if we've overrun our limit
      if ( timeThisUpdate > .3 ) then
        break;
      end
    end	
  
    -- Clean out the table
    if ( table.getn(v) == 0 ) then 
      GEMSystem_Data.anonTodo[k] = nil;
    end
  end
end

function GEMSystem_Schedule(when,handler,...)
  -- Assign an id
  local id = "";
  if ( not this ) then 
    id = "Keybinding";
  else
    id = this:GetName();
  end
  if ( not id ) then 
    id = "_DEFAULT";
  end
  if ( not when ) then 
    return;
  end

  -- Ensure we're not looping GEMSystemFrame
  if ( id == "GEMSystemFrame" and GEMSystem_Data.lastID ) then 
    id = GEMSystem_Data.lastID;
  end

  -- Create the new task
  local todo = {};
  todo.time = when + GetTime();
  todo.handler = handler;
  todo.args = arg;

  -- Create a new table if one does not exist
  if ( not GEMSystem_Data.anonTodo[id] ) then
    GEMSystem_Data.anonTodo[id] = {};
  end

  -- Find the correct index within the frame's table
  local i = 1;
  while(GEMSystem_Data.anonTodo[id][i] and
    GEMSystem_Data.anonTodo[id][i].time < todo.time) do
    i = i + 1;
  end

  -- Add the new task for the current frame
  table.insert(GEMSystem_Data.anonTodo[id],i,todo);

  --
  -- Ensure we don't have too many events
  --	(For now, we just ignore it and pop a message)
  --	
  if ( table.getn(GEMSystem_Data.anonTodo[id] ) > 100 and not GEMSystem_Data.anonTodo[id].errorSent ) then
    GEMSystem_Data.anonTodo[id].errorSent = true;
  end
end

