--[[
	Slash
		This is the slash command handler for Bagnon
--]]

function BagnonSlash_DisplayHelp()
	BagnonMsg(BAGNON_HELP_TITLE);
	BagnonMsg(BAGNON_HELP_HELP);
	BagnonMsg(BAGNON_HELP_SHOWBAGS);
	BagnonMsg(BAGNON_HELP_SHOWBANK);
	
	if( IsAddOnLoaded("Bagnon_Forever") ) then
		BagnonMsg(BAGNON_FOREVER_HELP_DELETE_CHARACTER);
	end
end

SlashCmdList["BagnonCOMMAND"] = function(msg)
	if(not msg or msg == "") then
		if( Bagnon_IsAddOnEnabled("Bagnon_Options") ) then
			if(not IsAddOnLoaded("Bagnon_Options") ) then
				LoadAddOn("Bagnon_Options");
			end
			BagnonOptions:Show();
		else
			BagnonSlash_DisplayHelp();
		end
	else
		local args = {};
		local word;
		for word in string.gfind(msg, "[^%s]+") do
			table.insert(args, word);
		end
		local cmd = string.lower(args[1]);
		
		if(cmd == BAGNON_COMMAND_HELP) then
			BagnonSlash_DisplayHelp();
		elseif(cmd == BAGNON_COMMAND_SHOWBANK) then
			BagnonFrame_Toggle("Banknon");
		elseif(cmd == BAGNON_COMMAND_SHOWBAGS) then
			BagnonFrame_Toggle("Bagnon");
		elseif(cmd == BAGNON_COMMAND_DEBUG_ON) then
			BagnonSets.noDebug = nil;
			BagnonMsg(BAGNON_DEBUG_ENABLED);
		elseif(cmd == BAGNON_COMMAND_DEBUG_OFF) then
			BagnonSets.noDebug = 1;
			BagnonMsg(BAGNON_DEBUG_DISABLED);
		elseif(cmd == BAGNON_FOREVER_COMMAND_DELETE_CHARACTER and IsAddOnLoaded("Bagnon_Forever") ) then
			BagnonForever_RemovePlayer(args[2], args[3] or GetRealmName());
		end
	end
end

SLASH_BagnonCOMMAND1 = "/bagnon";
SLASH_BagnonCOMMAND2 = "/bgn";