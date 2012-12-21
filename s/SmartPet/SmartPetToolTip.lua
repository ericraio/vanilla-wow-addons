function SmartPet_BuildTooltip(id)
	SmartPet_UpdateActionIcons(true);
	if (SmartPet_Config.ToolTips) then
	if (id == SmartPet_Actions["Taunt"].index) then
		SmartPet_BuildGrowlTooltip();
	elseif (id == SmartPet_Actions["Detaunt"].index) then
		SmartPet_BuildCowerTooltip();
	elseif (id == SmartPet_Actions["Burst"].index) then
		SmartPet_BuildClawTooltip();
	elseif (id == SmartPet_Actions["Sustain"].index) then
		SmartPet_BuildBiteTooltip();
	elseif (id == SmartPet_Actions["Nochase"].index) then
		SmartPet_BuildNoChaseTooltip();
	end
	end
end

function SmartPet_BuildGrowlTooltip()
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetText(COLOR_WHITE .. SMARTPET_ACTIONS_GROWL .. " " .. SMARTPET_TOOLTIP_MANAGEMENT .. COLOR_CLOSE);
	if (SmartPet_Config.TauntMan) then
		if (SmartPet_Config.UseTaunt) then
			GameTooltip:AddLine(SMARTPET_TOOLTIP_GROWL1);
			if (SmartPet_Config.AutoCower) then
				if (SmartPet_Actions["Detaunt"].index < 1) then					
					GameTooltip:AddLine(COLOR_RED .. SMARTPET_TOOLTIP_GROWL2 .. COLOR_CLOSE);
				else
					GameTooltip:AddLine(COLOR_GREEN .. string.gsub(SMARTPET_TOOLTIP_AUTOCOWER, '%%h', SmartPet_Config.CowerHealth) .. COLOR_CLOSE);
				end
			end
		elseif (SmartPet_Config.UseDetaunt) then
			GameTooltip:AddLine(COLOR_RED .. SMARTPET_TOOLTIP_GROWL3 .. COLOR_CLOSE);
		end
	else
		if (SmartPet_Config.AutoCower) then
			GameTooltip:AddLine(COLOR_GREEN .. string.gsub(SMARTPET_TOOLTIP_AUTOCOWER, '%%h', SmartPet_Config.CowerHealth) .. COLOR_CLOSE);
		else
			GameTooltip:AddLine(SMARTPET_TOOLTIP_GROWL4);
		end
	end
	GameTooltip:Show();
end

function SmartPet_BuildCowerTooltip()
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetText(COLOR_WHITE .. SMARTPET_ACTIONS_COWER .. " " .. SMARTPET_TOOLTIP_MANAGEMENT .. COLOR_CLOSE);
	if (SmartPet_Config.TauntMan) then
		if (SmartPet_Config.UseDetaunt) then
			GameTooltip:AddLine(SMARTPET_TOOLTIP_COWER1);
		elseif (SmartPet_Config.UseTaunt) then
			GameTooltip:AddLine(COLOR_RED .. SMARTPET_TOOLTIP_COWER3 .. COLOR_CLOSE);
			if (SmartPet_Config.AutoCower) then
				GameTooltip:AddLine(COLOR_GREEN .. string.gsub(SMARTPET_TOOLTIP_AUTOCOWER, '%%h', SmartPet_Config.CowerHealth) .. COLOR_CLOSE);
			end
		end
	else
		if (SmartPet_Config.AutoCower) then
			GameTooltip:AddLine(COLOR_GREEN .. string.gsub(SMARTPET_TOOLTIP_AUTOCOWER, '%%h', SmartPet_Config.CowerHealth) .. COLOR_CLOSE);
		else
			GameTooltip:AddLine(SMARTPET_TOOLTIP_COWER4);
		end
	end
	GameTooltip:Show();
end

function SmartPet_BuildClawTooltip()
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetText(COLOR_WHITE .. SMARTPET_ACTIONS_CLAW .. " " .. SMARTPET_TOOLTIP_MANAGEMENT .. COLOR_CLOSE);
	if (SmartPet_Config.TauntMan) then
		if (SmartPet_Config.UseBurst) then
			local mainAction;
			if (SmartPet_Config.UseTaunt) then
				mainAction = SmartPet_Actions["Taunt"].name;
			else
				mainAction = SmartPet_Actions["Detaunt"].name;
			end
			GameTooltip:AddLine(string.gsub(SMARTPET_TOOLTIP_CLAW1, '%%a', mainAction));
		else
			GameTooltip:AddLine(COLOR_RED .. SMARTPET_TOOLTIP_CLAW2 .. COLOR_CLOSE);
		end
	end
	if (SmartPet_Config.SmartFocus) then
		if (not SmartPet_Config.UseBurst or not SmartPet_Config.UseSustain) then
			GameTooltip:AddLine(COLOR_RED .. SMARTPET_TOOLTIP_SMARTFOCUS2 .. COLOR_CLOSE);
		else
			GameTooltip:AddLine(COLOR_BLUE .. SMARTPET_TOOLTIP_SMARTFOCUS1 .. COLOR_CLOSE);
		end
	end
	GameTooltip:Show();
end

function SmartPet_BuildBiteTooltip()
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetText(COLOR_WHITE .. SMARTPET_ACTIONS_BITE .. " " .. SMARTPET_TOOLTIP_MANAGEMENT .. COLOR_CLOSE);
	if (SmartPet_Config.TauntMan) then
		if (SmartPet_Config.UseSustain) then
			local mainAction;
			if (SmartPet_Config.UseTaunt) then
				mainAction = SmartPet_Actions["Taunt"].name;
			else
				mainAction = SmartPet_Actions["Detaunt"].name;
			end
			GameTooltip:AddLine(string.gsub(SMARTPET_TOOLTIP_BITE1, '%%a', mainAction));
		else
			GameTooltip:AddLine(COLOR_RED .. SMARTPET_TOOLTIP_BITE2 .. COLOR_CLOSE);
		end
	end
	if (SmartPet_Config.SmartFocus) then
		if (not SmartPet_Config.UseBurst or not SmartPet_Config.UseSustain) then
			GameTooltip:AddLine(COLOR_RED .. SMARTPET_TOOLTIP_SMARTFOCUS2 .. COLOR_CLOSE);
		else
			GameTooltip:AddLine(COLOR_BLUE .. SMARTPET_TOOLTIP_SMARTFOCUS1 .. COLOR_CLOSE);
		end
	end
	GameTooltip:Show();
end

function SmartPet_BuildNoChaseTooltip()
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetText(COLOR_WHITE .. SMARTPET_NOCHASE .. " " .. SMARTPET_TOOLTIP_MANAGEMENT .. COLOR_CLOSE);
	if (SmartPet_Config.NoChase) then
		GameTooltip:AddLine(SMARTPET_TOOLTIP_NOCHASE1);
	else 
		GameTooltip:AddLine(SMARTPET_TOOLTIP_NOCHASE2);
	end
	GameTooltip:Show();
end

function SmartPet_DefaultTooltip(tooltipID)
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetText(COLOR_WHITE .. SMARTPET_NOCHASE .. " " .. SMARTPET_TOOLTIP_MANAGEMENT .. COLOR_CLOSE);
	if (SmartPet_Config.NoChase) then
		GameTooltip:AddLine(tooltipID..1);
	else 
		GameTooltip:AddLine(tooltipID..2);
	end
	GameTooltip:Show();
end

-- Adds a formatted informational message
function SmartPet_AddInfoMessage(message)
	DEFAULT_CHAT_FRAME:AddMessage(COLOR_YELLOW..message..COLOR_CLOSE);
end


-- Adds a formatted help message
function SmartPet_AddHelpMessage(command, detail, status, enabled)
	message = COLOR_WHITE..command..": "..COLOR_CLOSE..COLOR_GREEN..detail..COLOR_CLOSE;

	if (enabled == nil) then
		DEFAULT_CHAT_FRAME:AddMessage(message);
		return;
	end
	
	if (status == "" or status == nil) then
		if (enabled) then
			DEFAULT_CHAT_FRAME:AddMessage(message..COLOR_WHITE.." (" .. SMARTPET_USAGE_ENABLED.. ")"..COLOR_CLOSE);
		else
			DEFAULT_CHAT_FRAME:AddMessage(message..COLOR_GREY.." (" .. SMARTPET_USAGE_DISABLED .. ")"..COLOR_CLOSE);
		end
	else
		if (enabled) then
			DEFAULT_CHAT_FRAME:AddMessage(message..COLOR_WHITE..status..COLOR_CLOSE);
		else
			DEFAULT_CHAT_FRAME:AddMessage(message..COLOR_GREY..status..COLOR_CLOSE);
		end		
	end
end

--Prints Messages to help in debuging
function SmartPet_AddDebugMessage(message, style)
	if (not SmartPet_Config.ShowDebug) then
		return;
	end
	
	if (strfind (SmartPet_Config.ShowDebugString, style)) then
		DEFAULT_CHAT_FRAME:AddMessage(COLOR_RED..message..COLOR_CLOSE);
	end
end


