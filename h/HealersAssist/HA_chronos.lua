--[[
  Healers Assist by Kiki - European Cho'gall
    Chronos module
]]

-- Shared variables
HA_CurrentTime = 0;


--[[
 Schedule code - Taken from Chronos By Alexander Brazie
]]

-- HASystem Data 
HASystem_Data = {
	-- Initialize the startup time
	elaspedTime = 0;

	-- Last ID
	lastID = nil;
	
	-- Initialize the Timers
	timers = {};

	-- Intialize the anonymous todo list
	anonTodo = {};
};

function HASystem_OnLoad()
  HASystem_Data.elapsedTime = 0;
end

function HASystem_startTimer(id)
  if ( not id ) then 
    id = this:GetName();
  end

  -- Create a table for this id's timers
  if ( not HASystem_Data.timers[id] ) then
    HASystem_Data.timers[id] = {};
  end

  -- Clear out an entry if the table is too big.
  if ( table.getn(HASystem_Data.timers[id]) >= 100) then
    table.remove(HASystem_Data.timers[id], 1 );
  end

  -- Add a new timer entry 
  table.insert(HASystem_Data.timers[id], GetTime() );		
end

function HASystem_endTimer(id) 
  if ( not id ) then 
    id = this:GetName();
  end
  
  -- Create a table for this id's timers
  if ( not HASystem_Data.timers[id] ) then
    HASystem_Data.timers[id] = {};
  end
  
  -- Check to see if there is any timers started
  if ( table.getn(HASystem_Data.timers[id]) == 0 ) then
    return 0, GetTime(), GetTime();
  end
  
  -- Grab the last timer called
  local startTime = table.remove ( HASystem_Data.timers[id] );
  local now = GetTime();
  
  return (now - startTime), startTime, now;
end


function HASystem_OnUpdate(dt)
  HA_CurrentTime = HA_CurrentTime + dt; -- Added
  -- Check raider infos
  HA_CheckGetCurrentInfos();

  if ( HASystem_Data.elapsedTime ) then
    HASystem_Data.elapsedTime = HASystem_Data.elapsedTime + dt;
  else
    HASystem_Data.elapsedTime = dt;
  end

  local timeThisUpdate = 0;
  local largest = 0;
  local largestName = nil;
  
  if ( not HASystem_Data.anonTodo ) then 
    HASystem_Data.anonTodo = {};
  end

  -- Handle Anonymous Scheduled Tasks
  for k,v in HASystem_Data.anonTodo do 
    HASystem_Data.lastID = k;
    -- Call all handlers whose time has been exceeded
    while(v[1] and v[1].time <= GetTime()) do
      -- Lets start the timer
      HASystem_startTimer();
    
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
      local runTime = HASystem_endTimer();
    
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
      HASystem_Data.anonTodo[k] = nil;
    end
  end
end

function HASystem_Schedule(when,handler,...)
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

  -- Ensure we're not looping HASystemFrame
  if ( id == "HASystemFrame" and HASystem_Data.lastID ) then 
    id = HASystem_Data.lastID;
  end

  -- Create the new task
  local todo = {};
  todo.time = when + GetTime();
  todo.handler = handler;
  todo.args = arg;

  -- Create a new table if one does not exist
  if ( not HASystem_Data.anonTodo[id] ) then
    HASystem_Data.anonTodo[id] = {};
  end

  -- Find the correct index within the frame's table
  local i = 1;
  while(HASystem_Data.anonTodo[id][i] and
    HASystem_Data.anonTodo[id][i].time < todo.time) do
    i = i + 1;
  end

  -- Add the new task for the current frame
  table.insert(HASystem_Data.anonTodo[id],i,todo);

  --
  -- Ensure we don't have too many events
  --	(For now, we just ignore it and pop a message)
  --	
  if ( table.getn(HASystem_Data.anonTodo[id] ) > 100 and not HASystem_Data.anonTodo[id].errorSent ) then
    HASystem_Data.anonTodo[id].errorSent = true;
  end
end

