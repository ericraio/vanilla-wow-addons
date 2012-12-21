--[[
	BCustomScript
		Allows bar scripts to be executed at runtime.
--]]

local function AddScript(barID, event, action, runNow)
	local funct = assert(loadstring("return function(bar,event)\n" .. action .. "\nend"));
	BScript.AddBarEventAction(barID, event, funct(), runNow);
end

BCustomScript = {	
	Save = function(barID, event, action, runNow)
		if not(barID and barID ~= "" and event and event ~= "") then return; end
		
		if not BongosCustomScripts then
			BongosCustomScripts = {};
		end
		if not BongosCustomScripts[barID] then
			BongosCustomScripts[barID] = {};
		end
		assert(loadstring(action));
		
		BongosCustomScripts[barID][event] = {script = action};

		if runNow then
			BongosCustomScripts[barID][event].runNow = 1;
			AddScript(barID, event, action, runNow)
		end
	end,
	
	Delete = function(barID, event)
		if not(barID and barID ~= "" and event and event ~= "") then return; end
		
		if BongosCustomScripts then
			if BongosCustomScripts[barID] then
				if BongosCustomScripts[barID][event] then
					BScript.RemoveEventForBar(event, barID);
					
					BongosCustomScripts[barID][event] = nil;				
					for i in BongosCustomScripts[barID] do return; end
					BongosCustomScripts[barID] = nil;
					for i in BongosCustomScripts do return; end
					BongosCustomScripts = nil;
				end
			end
		end
	end,
	
	Load = function(barID, event)
		if not(barID and barID ~= "" and event and event ~= "") then return; end
		
		if BongosCustomScripts then
			if BongosCustomScripts[barID] then	
				local data = BongosCustomScripts[barID][event];
				if data then
					AddScript(barID, event, data.script, data.runNow)
				end
			end	
		end
	end,
	
	LoadAll = function()
		if BongosCustomScripts then
			for barID in BongosCustomScripts do
				for event, data in pairs(BongosCustomScripts[barID]) do
					AddScript(barID, event, data.script, data.runNow)
				end
			end
		end
	end,
}