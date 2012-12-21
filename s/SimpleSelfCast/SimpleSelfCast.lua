local simpleSelfCastOriginalUseAction;
local splashString = "Simple Self Cast by Zugreg.\nUse |cffffff00/ssc help|r to display a command list.";
local helpString = "/ssc - Toggles self casting.\n/ssc help - Displays this message.\n/ssc enable - Enables self casting.\n/ssc disable - Disables self casting.\n/ssc nosplash - Prevents the splash message from being displayed.\n/ssc splash - Displays the splash message at each startup.";

function SimpleSelfCast_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
end

function SimpleSelfCast_OnEvent(event)
	if event == "VARIABLES_LOADED" then
		SlashCmdList["SIMPLESELFCAST"] = SimpleSelfCast_Command;
		SLASH_SIMPLESELFCAST1 = "/ssc";
		SLASH_SIMPLESELFCAST2 = "/simpleselfcast";
		if simpleSelfCastActive == nil then
			simpleSelfCastActive = true;
		end
		if simpleSelfCastSplash == nil then
			simpleSelfCastSplash = true;
		end
		if simpleSelfCastSplash then
			SSCPrint(splashString);
		end
		if simpleSelfCastActive then
			SimpleSelfCast_Enable();
		end
	end
end

function SimpleSelfCast_Command(arg)
	if arg == "enable" then
		SimpleSelfCast_Enable();
	elseif arg == "disable" then
		SimpleSelfCast_Disable();
	elseif arg == "help" then
		SSCPrint(helpString);
	elseif arg == "nosplash" then
		SSCPrint("Splash message on starup will not be displayd.");
		simpleSelfCastSplash = false;
	elseif arg == "splash" then
		SSCPrint("Splash message on starup will be displayd.");
		simpleSelfCastSplash = true;
	else
		if simpleSelfCastActive then
			SimpleSelfCast_Disable();
		else
			SimpleSelfCast_Enable();
		end
	end
end

function SimpleSelfCast_Enable()
	SSCPrint("Simple Self Cast enabled.");
	if simpleSelfCastOriginalUseAction == nil then
		simpleSelfCastOriginalUseAction = UseAction;
		UseAction = SimpleSelfCast_UseAction;
		simpleSelfCastActive = true;
	end
end

function SimpleSelfCast_Disable()
	SSCPrint("Simple Self Cast disabled.");
	if simpleSelfCastOriginalUseAction ~= nil then
		UseAction = simpleSelfCastOriginalUseAction;
		simpleSelfCastOriginalUseAction = nil;
		simpleSelfCastActive = false;
	end

end

function SimpleSelfCast_UseAction(id, type, self)
	if simpleSelfCastOriginalUseAction then
		simpleSelfCastOriginalUseAction(id, type, self);
		if( SpellIsTargeting() ) then
			if (UnitIsFriend("player","target")) then
				SpellTargetUnit("target");
			else
				SpellTargetUnit("player");
			end
		end
	end
end

function SSCPrint(string)
	if Print ~= nil then
		Print(string);
	elseif DEFAULT_CHAT_FRAME then
		DEFAULT_CHAT_FRAME:AddMessage(string);
	end
end