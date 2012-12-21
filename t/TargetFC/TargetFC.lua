local playerfaction = "";
local enemycarrier = "-";
local allycarrier = "-";

function TargetFC_OnLoad()
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_HORDE");
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE");
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL");

	SlashCmdList["TargetFC"] = TargetFC_SlashCommandHandler;
	SLASH_TargetFC1 = "/targetfc";
	SLASH_TargetFC2 = "/tf";

	DEFAULT_CHAT_FRAME:AddMessage("TargetFC enabled. /targetfc for more info.");
end

function TargetFC_OnEvent( event )
	if (event == "PLAYER_ENTERING_WORLD") then
		playerfaction = UnitFactionGroup("player");
		DEFAULT_CHAT_FRAME:AddMessage("Faction: " .. playerfaction);

		getglobal("TargetFCAllianceButton"):Hide();
		getglobal("TargetFCHordeButton"):Hide();

	elseif ((event == "CHAT_MSG_BG_SYSTEM_HORDE") or (event == "CHAT_MSG_BG_SYSTEM_ALLIANCE")) then

		DEFAULT_CHAT_FRAME:AddMessage("Faction Check: " .. playerfaction);

		if (string.find(arg1, "The %w+ %w+ was picked up by %w+")) then
			local _,_,team,player = string.find(arg1, "The (%w+) %w+ was picked up by (%w+)!");

			if (playerfaction == team) then
				enemycarrier = player;
			else
				allycarrier = player;
			end

			if (team == "Horde") then
				getglobal("TargetFCAlliance"):SetText(player);
				getglobal("TargetFCAllianceButton"):Show();
			else
				getglobal("TargetFCHorde"):SetText(player);
				getglobal("TargetFCHordeButton"):Show();
			end

		elseif (string.find(arg1, "The %w+ %w+ was taken by %w+")) then
			local _,_,team,player = string.find(arg1, "The (%w+) %w+ was taken by (%w+)!");

			if (playerfaction == team) then
				enemycarrier = player;
			else
				allycarrier = player;
			end

			if (team == "Horde") then
				getglobal("TargetFCAlliance"):SetText(player);
				getglobal("TargetFCAllianceButton"):Show();
			else
				getglobal("TargetFCHorde"):SetText(player);
				getglobal("TargetFCHordeButton"):Show();
			end

		elseif (string.find(arg1, "The %w+ %w+ was dropped")) then
			local _,_,team = string.find(arg1, "The (%w+)");

			if (playerfaction == team) then
				enemycarrier = "-";
			else
				allycarrier = "-";
			end

			if (team == "Horde") then
				getglobal("TargetFCAllianceButton"):Hide();
			else
				getglobal("TargetFCHordeButton"):Hide();
			end
		end

	elseif (event == "CHAT_MSG_BG_SYSTEM_NEUTRAL") then
		if (string.find(arg1, "The flags are now placed at their bases.")) then
			allycarrier = "-";
			enemycarrier = "-";

			getglobal("TargetFCAllianceButton"):Hide();
			getglobal("TargetFCHordeButton"):Hide();
		end
	end
end


function TargetFC_SlashCommandHandler(msg)
	if (string.lower(msg) == "enemy") then
		if (enemycarrier ~= "-") then
			DEFAULT_CHAT_FRAME:AddMessage("Attempting to target <" .. enemycarrier .. ">.");
			TargetByName(enemycarrier);
			if (UnitName("target") ~= enemycarrier) then
				TargetLastTarget();
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("No enemy flag carrier.");
		end

	elseif (string.lower(msg) == "friendly") then
		if (allycarrier ~= "-") then
			DEFAULT_CHAT_FRAME:AddMessage("Attempting to target <" .. allycarrier .. ">.");
			TargetByName(allycarrier);
			if (UnitName("target") ~= allycarrier) then
				TargetLastTarget();
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("No friendly flag carrier.");
		end

	elseif (string.lower(msg) == "horde") then
		if (playerfaction == "Horde") then
			TargetFC_SlashCommandHandler("friendly");
		else
			TargetFC_SlashCommandHandler("enemy");
		end

	elseif (string.lower(msg) == "alliance") then
		if (playerfaction == "Horde") then
			TargetFC_SlashCommandHandler("enemy");
		else
			TargetFC_SlashCommandHandler("friendly");
		end

	elseif (string.lower(msg) == "fix") then
		playerfaction = UnitFactionGroup("player");

	elseif (string.lower(msg) == "check") then
		DEFAULT_CHAT_FRAME:AddMessage("Faction: " .. playerfaction);


	else
		DEFAULT_CHAT_FRAME:AddMessage("To target the enemy flag carrier: /tf enemy");
		DEFAULT_CHAT_FRAME:AddMessage("To target the friendly flag carrier: /tf friendly");
		DEFAULT_CHAT_FRAME:AddMessage("To check to see if the faction was obtained correctly: /tf check");
		DEFAULT_CHAT_FRAME:AddMessage("To automatically detect the faction: /tf fix");
	end
end
