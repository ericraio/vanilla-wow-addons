FILTERFIX_VERSION = "4216a";

function FilterFix_OnLoad()
	this:RegisterEvent("TRAINER_SHOW");
	this:RegisterEvent("VARIABLES_LOADED");
	
	SLASH_FILTERFIX1 = "/filterfix";
	SLASH_FILTERFIX2 = "/ff";
	SlashCmdList["FILTERFIX"] = function(msg)
		FilterFix_OnSlashCommand(msg);
	end
	if ( DEFAULT_CHAT_FRAME ) then 
		DEFAULT_CHAT_FRAME:AddMessage("FilterFix "..FILTERFIX_VERSION.." Loaded! /filterfix or /ff for usage");
	end	
end

function FilterFix_OnEvent(event)

	if ( event == "VARIABLES_LOADED" ) then
		if ( not FilterFixEnable ) then
			FilterFixEnable = 1;	
		end		
	elseif ( event == "TRAINER_SHOW" and FilterFixEnable == 1 ) then
		SetTrainerServiceTypeFilter("unavailable", 0);
	elseif ( event == "TRAINER_SHOW" and FilterFixEnable == 0 ) then
		SetTrainerServiceTypeFilter("unavailable", 1);
	end
end

function FilterFix_OnSlashCommand(msg)
	if ( msg == "" ) then
		DEFAULT_CHAT_FRAME:AddMessage("Usage:  /filterfix [option] or /ff [option]");
		DEFAULT_CHAT_FRAME:AddMessage("Options:\n    toggle - toggles FilterFix on/off.  Note: this state is used across all characters.");
		DEFAULT_CHAT_FRAME:AddMessage("    state - tells FilterFix's current state.");
	elseif ( string.find(msg, "toggle") ) then
		if ( FilterFixEnable == 0 ) then
			FilterFixEnable = 1;
			DEFAULT_CHAT_FRAME:AddMessage("FilterFix has been enabled!");
		else
			FilterFixEnable = 0;
			DEFAULT_CHAT_FRAME:AddMessage("FilterFix has been disabled!");
		end
	elseif ( string.find(msg, "state") ) then
		if ( FilterFixEnable == 1) then
			DEFAULT_CHAT_FRAME:AddMessage("FilterFix is currently enabled.");
		else
			DEFAULT_CHAT_FRAME:AddMessage("FilterFix if currently disabled.");
		end
	end
end