local playerName = nil;
local lastMana = nil;
local playerClass = nil;

function SCT_ManaGain_OnLoad()

	if ( not SCT_OnLoad ) then
		SCT_ManaGain_AddMessage("not loaded!  Dependancy Scrolling Combat Text not found!");
		return;
	end
	
	if ( not print ) then print = function(x) ChatFrame1:AddMessage(x); end end

	SlashCmdList["SCTMANAGAINCOMMAND"] = SCT_ManaGain_SlashHandler;
	SLASH_SCTMANAGAINCOMMAND1 = "/sctmg";
	SLASH_SCTMANAGAINCOMMAND2 = "/sctmanagain";

	this:RegisterEvent("VARIABLES_LOADED")
	
end

function SCT_ManaGain_OnEvent()

	if ( event == "VARIABLES_LOADED" ) then
		--let's not load if player doesn't have mana
		playerClass = UnitClass("player");
		
		if ( UnitPowerType("player") ~= 0 and playerClass ~= "Druid" ) then return; end
		
		this:RegisterEvent("UNIT_MANA");
		
		lastMana = UnitMana("player");
		
		if ( not SCT_ManaGain_Saved ) then
			SCT_ManaGain_Saved = {};
			
			SCT_ManaGain_AddMessage("loaded -- first use!")
		end
		
		playerName = UnitName("player").." of "..GetCVar("realmName");
		
		if ( not SCT_ManaGain_Saved[playerName] ) then
			SCT_ManaGain_Saved[playerName] = {
				["Drink"] = true,
				["SpiritTap"] = true,
				["Evocation"] = true,
			};
			
			if ( playerClass ~= "Priest" ) then SCT_ManaGain_Saved[playerName].SpiritTap = false; end
			if ( playerClass ~= "Mage" ) then SCT_ManaGain_Saved[playerName].Evocation = false; end
			
			SCT_ManaGain_AddMessage("profile "..playerName.." created!");
		else
			if ( SCT_ManaGain_Saved[playerName].Drink == nil ) then SCT_ManaGain_Saved[playerName].Drink = true; end
			if ( playerClass == "Priest" and SCT_ManaGain_Saved[playerName].SpiritTap == nil ) then SCT_ManaGain_Saved[playerName].SpiritTap = true; end
			if ( playerClass == "Mage" and SCT_ManaGain_Saved[playerName].Evocation == nil ) then SCT_ManaGain_Saved[playerName].Evocation = true; end
			SCT_ManaGain_AddMessage(playerName.." profile loaded.");
		end
		
		SCT_ManaGain_ShowStatus();
	elseif ( event == "UNIT_MANA" ) then
		if ( arg1 and arg1 == "player" ) then
			local manaDiff = UnitMana("player") - lastMana;
			
			if ( manaDiff > 0 and SCT_ManaGain_GetShow() ) then
				SCT_Display_Only("SHOWPOWER", "+"..manaDiff.." mana");
			end
			lastMana = UnitMana("player");
		end
	end
end

function SCT_ManaGain_GetShow()

	SCTManaGainTooltip:SetOwner(UIParent, "ANCHOR_NONE");
	
	local buffName = "";
	local i = 1;
	
	while UnitBuff("player", i) do 
		SCTManaGainTooltip:ClearLines();
		SCTManaGainTooltip:SetUnitBuff("player", i);
		buffName = SCTManaGainTooltipTextLeft1:GetText();
		
		if ( buffName and strfind(buffName, "Spirit Tap") and SCT_ManaGain_Saved[playerName].SpiritTap ) then
			return true;
		elseif ( buffName and strfind(buffName, "Drink") and SCT_ManaGain_Saved[playerName].Drink ) then
			return true;
		elseif ( buffName and strfind(buffName, "Evocation") and SCT_ManaGain_Saved[playerName].Evocation ) then
			return true;
		end
		
		i = i + 1;
	end

	return false;
	
end

function SCT_ManaGain_AddMessage(msg)
	
	if ( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("SCT_ManaGain: "..msg);
	end
	
end

function SCT_ManaGain_ShowStatus()

	if ( SCT_ManaGain_Saved[playerName].Drink ) then
		SCT_ManaGain_AddMessage("mana-gain display while drinking is enabled.");
	else
		SCT_ManaGain_AddMessage("mana-gain display while drinking is disabled.");
	end
	
	if ( playerClass == "Mage" ) then
		if ( SCT_ManaGain_Saved[playerName].Evocation ) then
			SCT_ManaGain_AddMessage("mana-gain display while casting Evocation is enabled.");
		else
			SCT_ManaGain_AddMessage("mana-gain display while casting Evocation is enabled.");
		end
	end
	
	if ( playerClass == "Priest" ) then
		if ( SCT_ManaGain_Saved[playerName].SpiritTap  ) then
			SCT_ManaGain_AddMessage("mana-gain display while Spirit Tapped is enabled.");
		else
			SCT_ManaGain_AddMessage("mana-gain display while Spirit Tapped is disabled.");
		end
	end

end

function SCT_ManaGain_ShowUsage()
	
	if ( DEFAULT_CHAT_FRAME ) then
		SCT_ManaGain_AddMessage(" -- Usage:");
		DEFAULT_CHAT_FRAME:AddMessage("    -Use \"/sctmanagain\" or \"/sctmg\"");
		DEFAULT_CHAT_FRAME:AddMessage("    -\"/sctmanagain help\" -- shows these usage tips.");
		DEFAULT_CHAT_FRAME:AddMessage("    -\"/sctmanagain drink [on/off]\" -- enables or disables mana-gain display while drinking.");
		if ( playerClass == "Priest" ) then
			DEFAULT_CHAT_FRAME:AddMessage("    -\"/sctmanagain spirittap [on/off]\" -- enables or disables mana-gain display while spirit tapped.");
		end
		if ( playerClass == "Mage" ) then
			DEFAULT_CHAT_FRAME:AddMessage("    -\"/sctmanagain evocation [on/off\" -- enables or disables mana-gain display while casting Evocation.");
		end
	end
	
end

function SCT_ManaGain_NextParameter(msg)

	local params = nil;
	local command = nil;
	local index = strfind(msg, " ");
	
	if ( index ) then
		command = strsub(msg, 1, index - 1);
		params = strsub(msg, index + 1);
	else
		command = msg;
	end
	
	return command, params;
	
end

function SCT_ManaGain_SlashHandler(msg)
	
	if ( not msg or strlen(msg) <= 0 ) then
		SCT_ManaGain_ShowStatus();
		return;
	end
	
	local command, params = SCT_ManaGain_NextParameter(string.lower(msg));
	
	if ( command == "drink" ) then
		if ( not params ) then
			if ( SCT_ManaGain_Saved[playerName].Drink ) then
				SCT_ManaGain_AddMessage("mana-gain display while drinking is enabled.");
			else
				SCT_ManaGain_AddMessage("mana-gain display  while drinking is disabled.");
			end
		else
			if ( params == "on" ) then
				SCT_ManaGain_AddMessage("mana-gain display while drinking is now enabled.");
				SCT_ManaGain_Saved[playerName].Drink = true;
			elseif ( params == "off" ) then
				SCT_ManaGain_AddMessage("mana-gain display while drinking is now enabled.");
				SCT_ManaGain_Saved[playerName].Drink = false;
			else
				SCT_ManaGain_ShowUsage();
			end
		end
		return;
	elseif ( command == "spirittap" ) then
		if ( playerClass ~= "Priest" ) then	
			SCT_ManaGain_AddMessage("you are not a priest.")
			return;
		end
		
		if ( not params ) then
			if ( SCT_ManaGain_Saved[playerName].SpiritTap  ) then
				SCT_ManaGain_AddMessage("mana-gain display while Spirit Tapped is enabled.");
			else
				SCT_ManaGain_AddMessage("mana-gain display while Spirit Tapped is disabled.");
			end
		else
			if ( params == "on" ) then
				SCT_ManaGain_Saved[playerName].SpiritTap = true;
				SCT_ManaGain_AddMessage("mana-gain display while Spirit Tapped is now enabled.");
			elseif ( params == "off" ) then
				SCT_ManaGain_Saved[playerName].SpiritTap = false;
				SCT_ManaGain_AddMessage("mana-gain display while Spirit Tapped is now disabled.");
			else
				SCT_ManaGain_ShowUsage();
			end
		end
		return;
	elseif ( command == "evocation" ) then
		if ( playerClass ~= "Mage" ) then
			SCT_ManaGain_AddMessage("you are not a mage.")
			return;
		end
		
		if ( not params ) then
			if ( SCT_ManaGain_Saved[playerName].Evocation ) then
				SCT_ManaGain_AddMessage("mana-gain display while casting Evocation is enabled.");
			else
				SCT_ManaGain_AddMessage("mana-gain display while casting Evocation is enabled.");
			end
		else
			if ( params == "on" ) then
				SCT_ManaGain_Saved[playerName].Evocation = true;
				SCT_ManaGain_AddMessage("mana-gain display while casting Evocation is now enabled.");
			elseif ( params == "off" ) then
				SCT_ManaGain_Saved[playerName].Evocation = false;
				SCT_ManaGain_AddMessage("mana-gain display while casting Evocation is now disabled.");
			else
				SCT_ManaGain_ShowUsage();
			end
		end
		return;
	else
		SCT_ManaGain_ShowUsage();
	end
end