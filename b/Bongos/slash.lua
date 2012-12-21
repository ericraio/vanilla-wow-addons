--[[
	slash
		Slash command handler for Bongos
		All commands start with /bg or /bongos
		
	Valid strings for <bar>:
		<number> - an action bar
		bags - bag bar
		menu - menu bar
		pet - pet bar
		class - class bar
		stats - stat bar
		all - all bars
--]]

local function GetRestofMessage(args)
	if args[2] then
		local name = args[2];
		for i = 3, table.getn(args) do
			name = name .. " " .. args[i];
		end
		return name;
	end
end

local function printMsg(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg or "error", 0, 1, 0.4);
end

--Display commands
local function ShowCommands()
	printMsg("Bongos Commands:");
	printMsg("/bob - Shows the options menu, if present.");
	printMsg("/bob help or /bob ? - Displays list of commands");
	
	--bar commands
	printMsg("/bob lock - Locks the position all bars");
	printMsg("/bob unlock - Unlocks the positions all bars");
	printMsg("/bob show <bar> - Shows the given bar");
	printMsg("/bob hide <bar> - Hides the given bar");
	printMsg("/bob toggle <bar> - Toggles the given bar");
	printMsg("/bob scale <bar> <value> - Set the scale of the given bar. 1 is normal size.");
	printMsg("/bob setalpha <bar> <value> - Set the opacity of a bar to <value>. 0 is translucent, 1 is opaque.");
	printMsg("/bob stickybars  <on | off> - Enable/disable bars automatically \"sticking\" to each other when positioning them");

	--Profile commands
	printMsg("/bob load <profile> - Loads the given layout.");
	printMsg("/bob save <profile> - Saves the current setup as <profile>.");
	printMsg("/bob delete <profile> - Deletes the given saved layout.");
	printMsg("/bob setdefault <profile> - Sets a given saved profile as the default settings for new characters.");
end

--Slash handler
SlashCmdList["BongosCOMMAND"] = function(msg)
	if msg == "" then
		if BOptions then
			BOptions:Show();
		else
			local _, _, _, enabled = GetAddOnInfo("Bongos_Options");
			if enabled then
				LoadAddOn("Bongos_Options");
			else
				ShowCommands();
			end
		end		
	else
		local args = {};
		for word in string.gfind(msg, "[^%s]+") do
			table.insert(args, word);
		end
		local cmd = string.lower(args[1]);
		
		if cmd == "help" or cmd == "?" then
			ShowCommands();
		elseif cmd == "lock" then
			Bongos_SetLock(true);
		elseif cmd == "unlock" then
			Bongos_SetLock(nil);
		elseif cmd == "stickybars" then
			Bongos_SetStickyBars(string.lower(args[2]) == "on");
		elseif cmd == "show" then
			for i = 2, table.getn(args) do
				Bongos_ForBar(string.lower(args[i]), BBar.Show, 1);
			end
		elseif cmd == "hide" then
			for i = 2, table.getn(args) do
				Bongos_ForBar(string.lower(args[i]), BBar.Hide, 1);
			end
		elseif cmd == "toggle" then
			for i = 2, table.getn(args) do
				Bongos_ForBar(string.lower(args[i]), BBar.Toggle, 1);
			end
		elseif cmd == "scale" then
			local size = table.getn(args);
			local scale = tonumber(args[size]);
			for i = 2, size - 1 do
				Bongos_ForBar(string.lower(args[i]), BBar.SetScale, scale, 1);
			end
		elseif cmd == "setalpha" then
			local size = table.getn(args);
			local alpha = tonumber(args[size]);
			for i = 2, size - 1 do
				Bongos_ForBar(string.lower(args[i]), BBar.SetAlpha, alpha, 1);
			end
		elseif cmd == "reset" then
			BBar.ForAllIDs(BBar.Delete);
			BScript.CallStartup();
		elseif cmd == "load" then
			BProfile.Load(GetRestofMessage(args));
		elseif cmd == "save" then
			BProfile.Save(GetRestofMessage(args));
		elseif cmd == "delete" then
			BProfile.Delete(GetRestofMessage(args));
		elseif cmd == "setdefault" then
			BProfile.SetDefault(GetRestofMessage(args));
		elseif cmd == "reuse" then
			if BongosSets.dontReuse then
				BongosSets.dontReuse = nil;
			else
				BongosSets.dontReuse = 1;
			end
			ReloadUI()
		else
			BMsg("'" .. (cmd or "error") .."' is an unknown command.");
		end
	end
end
SLASH_BongosCOMMAND1 = "/bongos";
SLASH_BongosCOMMAND2 = "/bob";