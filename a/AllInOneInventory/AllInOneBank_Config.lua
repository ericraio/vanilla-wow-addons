-- -----------------------------------------------------------------
-- File: AllInOneBank_Config.lua
--
-- Purpose: Functions for AIOB Config window and options.
-- 
-- Author: Ramble 
-- 
-- Credits: 
--   Starven, for MyInventory
--   Kaitlin, for BankItems
--   Sarf, for the original concept of AllInOneInventory
-- -----------------------------------------------------------------

-- == Slash Handlers == 
-- ChatCommandHandler: Slash commands are in here
function AIOB_ChatCommandHandler(msg)

	if ( ( not msg ) or ( strlen(msg) <= 0 ) ) then
		AIOB_Print(AIOB_CHAT_COMMAND_USAGE);
		AIOBConfigFrame:Show();
		return;
	end
	
	local commandName, params = AIOB_Extract_NextParameter(msg);
	
	if ( ( commandName ) and ( strlen(commandName) > 0 ) ) then
		commandName = string.lower(commandName);
	else
		commandName = "";
	end
	
	if ( (strfind(commandName, "show")) or (strfind(commandName, "toggle")) ) then
		ToggleAIOBFrame();
	elseif ( (strfind(commandName, "freeze")) or (strfind(commandName, "unfreeze")) ) then
		AIOB_Toggle_Option("Freeze");
	elseif ( (strfind(commandName, "replacebank")) or (strfind(commandName, "replace"))) then
		AIOB_Toggle_Option("ReplaceBank");
	elseif strfind(commandName, "highlightbags") then
		AIOB_Toggle_Option("HighlightBags");
	elseif strfind(commandName, "highlightitems") then
		AIOB_Toggle_Option("HighlightItems");
	elseif strfind(commandName, "graphic") then
		AIOB_Toggle_Option("Graphics");
	elseif strfind(commandName, "back") then
		AIOB_Toggle_Option("Background");
	elseif strfind(commandName, "player") then
		AIOB_Toggle_Option("ShowPlayers");
	elseif ( (strfind(commandName, "cols")) or (strfind(commandName, "column")) ) then
		cols, params = AIOB_Extract_NextParameter(params);
		cols = tonumber(cols);
		AIOBFrame_SetColumns(cols);
	elseif ( (strfind(commandName, "reset")) or (strfind(commandName, "init")) ) then
		AIOBProfile[UnitName("player")] = nil;
		AIOB_InitializeProfile();
	elseif (strfind(commandName, "config")) then
		AIOBConfigFrame:Show();
	else
		AIOB_Print(AIOB_CHAT_COMMAND_USAGE);
		return;
	end
end
-- Extract_NextParameter: Used for Slash command handler
function AIOB_Extract_NextParameter(msg)
	local params = msg;
	local command = params;
	local index = strfind(command, " ");
	if ( index ) then
		command = strsub(command, 1, index-1);
		params = strsub(params, index+1);
	else
		params = "";
	end
	return command, params;
end
-- == End Slash Handlers == 


--All Functions that deal directly with AIOBConfig Frame items should go here
function AIOBConfig_OnShow()
	AIOBConfigReplaceCheck:SetChecked(AIOBReplaceBank);
	AIOBConfigFreezeCheck:SetChecked(AIOBFreeze);
	AIOBConfigColumns:SetText(AIOBColumns);
	AIOBConfigHighlightItemsCheck:SetChecked(AIOBHighlightItems);
	AIOBConfigHighlightBagsCheck:SetChecked(AIOBHighlightBags);
	AIOBConfigHighlightItemsCheck:SetChecked(AIOBHighlightItems);
	AIOBConfigGraphicsCheck:SetChecked(AIOBGraphics);
	AIOBConfigBackgroundCheck:SetChecked(AIOBBackground);
end
function AIOBConfig_OnHide()
	if AIOBConfigReplaceCheck:GetChecked() then
		AIOB_Toggle_Option("ReplaceBank", 1,1);
	else
		AIOB_Toggle_Option("ReplaceBank", 0,1);
	end
	if AIOBConfigFreezeCheck:GetChecked() then
		AIOB_Toggle_Option("Freeze", 1,1);
	else
		AIOB_Toggle_Option("Freeze", 0,1);
	end
	local cols =  tonumber(AIOBConfigColumns:GetText());
	if cols and cols > 5 and cols < 19 then
		AIOBFrame_SetColumns(cols);
	end
	if AIOBConfigHighlightItemsCheck:GetChecked() then
		AIOB_Toggle_Option("HighlightItems",1,1);
	else
		AIOB_Toggle_Option("HighlightItems",0,1);
	end
	if AIOBConfigHighlightBagsCheck:GetChecked() then
		AIOB_Toggle_Option("HighlightBags",1,1);
	else
		AIOB_Toggle_Option("HighlightBags",0,1);
	end
	if AIOBConfigGraphicsCheck:GetChecked() then
		AIOB_Toggle_Option("Graphics",1,1);
	else
		AIOB_Toggle_Option("Graphics",0,1);
	end
	if AIOBConfigBackgroundCheck:GetChecked() then
		AIOB_Toggle_Option("Background",1,1);
	else
		AIOB_Toggle_Option("Background",0,1);
	end
end


-- END AIOBConfig Frame stuff


