--[[

ntmysFixLoadingTimes (v13 /apr /06)
-----------------------------------

Improves loading-times between zoning (ie: switching continents, entering/leaving an instance).
This works by preventing numerous events from being processed by the event-handlers during zoning,
events that would otherwise update your interface with information that you simply won't need
when you are starring at a loading-screen. Depending on your system and installed addons, zoning
will be 5-10 times faster (no kidding: for me as an example, MC loads in 6-8s instead of over 1 minute).

use /nFLT to cycle between different modes:

on (with messages) - the default
on (without messages)
off (with messages)
off

With messages, it shows how long zoning took and how many events had been processed.
When using [off (with messages)] you can see how much time passes when all events are being processed,
so you can compare your loading times with and without FLT turned on.

A big Thankyou to Tigerheart for pointing out the events-slowering-loading-times-during-zoning-problem on the
official interface-forum.

Christopher "ntmy" Steglich (dantmy@gmx.net)


Version History
---------------
v13/apr/06
 - working on all frames now and thus blocking a few more events
 - code optimization

 v12/apr/06
 - fixed slashes in french localization
 - french localization by RaSk

 v11/apr/06
 - initial release

]]--
local Title = "ntmysFixLoadingTimes (v13 /apr /06)";

ntmysFLT_isActive = 1; -- default is on with messages

function ntmysFLT_OnLoad()
	DEFAULT_CHAT_FRAME:AddMessage(Title..NFLT_TITLEUSAGE,1,1,0.5);

	SlashCmdList["NFLT"] = function(msg)
		ntmysFLT_isActive = mod(ntmysFLT_isActive+1,4);
		DEFAULT_CHAT_FRAME:AddMessage(NFLT_SETTING[ntmysFLT_isActive+1],1,1,0.5);
		ntmysFLT_setMode();
	end
	SLASH_NFLT1 = "/nFLT";
	
	this:RegisterEvent("VARIABLES_LOADED");
end

local ntmysFLT_PLW_Time = nil;

function ntmysFLT_OnEvent()
	if(event == "VARIABLES_LOADED") then
		ntmysFLT_setMode();
	end
	if(event == "PLAYER_ENTERING_WORLD") then
		if(not ntmysFLT_PLW_Time) then return; end -- first time entering world
		
		if(ntmysFLT_isActive == 1 or ntmysFLT_isActive == 2) then
			ntmysFLT_RestoreOnEvents();
		end
		
		if(ntmysFLT_isActive == 2) then return; end -- no messages
		
		local time = GetTime() - ntmysFLT_PLW_Time;
		DEFAULT_CHAT_FRAME:AddMessage(NFLT_ZONECHANGE..(floor(time*10)/10).."s",1,0.8,0.2);

		if(ntmysFLT_isActive == 3) then return; end -- off, no events counted
				
		DEFAULT_CHAT_FRAME:AddMessage(NFLT_PROCEVENTS..ntmysFLT_PassedEvents.."/"..ntmysFLT_AllEvents,1,0.8,0.2);
	end
	if(event == "PLAYER_LEAVING_WORLD") then
		ntmysFLT_PLW_Time = GetTime();
		if(ntmysFLT_isActive == 3) then return; end -- off 
		
		ntmysFLT_KillOnEvents();
	end
end

function ntmysFLT_setMode()
	if(ntmysFLT_isActive > 0) then
		ntmysFLT_Frame:RegisterEvent("PLAYER_ENTERING_WORLD");
		ntmysFLT_Frame:RegisterEvent("PLAYER_LEAVING_WORLD");
	else
		ntmysFLT_Frame:UnregisterEvent("PLAYER_ENTERING_WORLD");
		ntmysFLT_Frame:UnregisterEvent("PLAYER_LEAVING_WORLD");
	end
end

function ntmysFLT_KillOnEvents()
	ntmysFLT_AllEvents = 0;
	ntmysFLT_PassedEvents = 0;
	local f = EnumerateFrames();
	local OnEvent;
	while f do
		OnEvent = f:GetScript("OnEvent");
		if(OnEvent) then
			f.ntmysFLT_OnEvent = OnEvent;
			-- some events still need to be checked
			f:SetScript("OnEvent", function()
					if(event == "PLAYER_ENTERING_WORLD" or
						event == "PLAYER_TARGET_CHANGED" or
						event == "PLAYER_LOGOUT" or
						string.sub(event,0,4) == "CHAT") then
						this.ntmysFLT_OnEvent();
						ntmysFLT_PassedEvents = ntmysFLT_PassedEvents +1;
					end
					ntmysFLT_AllEvents = ntmysFLT_AllEvents +1;
				end
			);
		end
		f = EnumerateFrames(f);
	end	
end

function ntmysFLT_RestoreOnEvents()
	local f = EnumerateFrames();
	while f do
		if(f.ntmysFLT_OnEvent) then
			f:SetScript("OnEvent",f.ntmysFLT_OnEvent);
			f.ntmysFLT_OnEvent = nil;
		end
		f = EnumerateFrames(f);
	end
end