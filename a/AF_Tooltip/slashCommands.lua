--Register Slash Commands---------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
function aftt_slashCommands()
	SlashCmdList["AF_ToolTip"] = aftt_commandResponse;
	SLASH_AF_ToolTip1 = "/aftt";
	SLASH_AF_ToolTip2 = "/aftooltip";

	SlashCmdList["AF_ToolTipX"] = aftt_commandResponseX;
	SLASH_AF_ToolTipX1 = "/afttx";

	SlashCmdList["AF_ToolTipY"] = aftt_commandResponseY;
	SLASH_AF_ToolTipY1 = "/aftty";
end






--Command Events------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
function aftt_commandResponse(msg)



	--Position: Follow Mouse-----------------------------------
	-----------------------------------------------------------
		if (msg == "mouse") then
			AF_ToolTip[aftt_localUser]["Anchor"] = msg;
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: " .. aftt_translate_position .. ": " .. aftt_translate_followingmouse);
			if (AF_ToolTip[aftt_localUser]["AnchorSmart"] == 1) then
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: " .. aftt_translate_position .. ": " .. aftt_translate_smart .. ": off");
				AF_ToolTip[aftt_localUser]["AnchorSmart"] = 0;
			end



	--Position: Top Row----------------------------------------
	-----------------------------------------------------------
		elseif (msg == "topleft") then
			AF_ToolTip[aftt_localUser]["Anchor"] = msg;
			GameTooltip_SetDefaultAnchor = aftt_GameTooltip_SetDefaultAnchor;
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: " .. aftt_translate_position .. ": " .. aftt_translate_topleft);
		elseif (msg == "top") then
			AF_ToolTip[aftt_localUser]["Anchor"] = msg;
			GameTooltip_SetDefaultAnchor = aftt_GameTooltip_SetDefaultAnchor;
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: " .. aftt_translate_position .. ": " .. aftt_translate_top);
		elseif (msg == "topright") then
			AF_ToolTip[aftt_localUser]["Anchor"] = msg;
			GameTooltip_SetDefaultAnchor = aftt_GameTooltip_SetDefaultAnchor;
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: " .. aftt_translate_position .. ": " .. aftt_translate_topright);


	--Position: Center Row-------------------------------------
	-----------------------------------------------------------
		elseif (msg == "left") then
			AF_ToolTip[aftt_localUser]["Anchor"] = msg;
			GameTooltip_SetDefaultAnchor = aftt_GameTooltip_SetDefaultAnchor;
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: " .. aftt_translate_position .. ": " .. aftt_translate_left);
		elseif (msg == "center") then
			AF_ToolTip[aftt_localUser]["Anchor"] = msg;
			GameTooltip_SetDefaultAnchor = aftt_GameTooltip_SetDefaultAnchor;
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: " .. aftt_translate_position .. ": " .. aftt_translate_center);
		elseif (msg == "right") then
			AF_ToolTip[aftt_localUser]["Anchor"] = msg;
			GameTooltip_SetDefaultAnchor = aftt_GameTooltip_SetDefaultAnchor;
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: " .. aftt_translate_position .. ": " .. aftt_translate_right);



	--Position: Bottom Row-------------------------------------
	-----------------------------------------------------------
		elseif (msg == "bottomleft") then
			AF_ToolTip[aftt_localUser]["Anchor"] = msg;
			GameTooltip_SetDefaultAnchor = aftt_GameTooltip_SetDefaultAnchor;
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: " .. aftt_translate_position .. ": " .. aftt_translate_bottomleft);
		elseif (msg == "bottom") then
			AF_ToolTip[aftt_localUser]["Anchor"] = msg;
			GameTooltip_SetDefaultAnchor = aftt_GameTooltip_SetDefaultAnchor;
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: " .. aftt_translate_position .. ": " .. aftt_translate_bottom);
		elseif (msg == "bottomright") then
			AF_ToolTip[aftt_localUser]["Anchor"] = msg;
			GameTooltip_SetDefaultAnchor = aftt_GameTooltip_SetDefaultAnchor;
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: " .. aftt_translate_position .. ": " .. aftt_translate_bottomright);



	--Clear Positioning----------------------------------------
	-----------------------------------------------------------
		elseif (msg == "clear") then
			AF_ToolTip[aftt_localUser]["Anchor"] = "none";
			GameTooltip_SetDefaultAnchor = aftt_GameTooltip_SetDefaultAnchor;
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: " .. aftt_translate_position .. ": " .. aftt_translate_cleared);



	--Toggle Fade Out------------------------------------------
	-----------------------------------------------------------
		elseif (msg == "fade") then
			if (AF_ToolTip[aftt_localUser]["Fade"] == 1) then
				AF_ToolTip[aftt_localUser]["Fade"] = 0;
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: Fade: Hide");
			else
				AF_ToolTip[aftt_localUser]["Fade"] = 1;
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: Fade: Show");
			end



	--Toggle PvP-----------------------------------------------
	-----------------------------------------------------------
		elseif (msg == "pvp") then
			if (AF_ToolTip[aftt_localUser]["PvP"] == 1) then
				AF_ToolTip[aftt_localUser]["PvP"] = 0;
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: PvP: Hide");
			else
				AF_ToolTip[aftt_localUser]["PvP"] = 1;
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: PvP: Show");
			end



	--Toggle Guild---------------------------------------------
	-----------------------------------------------------------
		elseif (msg == "guild") then
			--0, hide	-> toggles to show
			--1, show	-> toggles to showbottom
			--2, showbottom	-> toggles to hide
			if (AF_ToolTip[aftt_localUser]["Guild"] == 0 or AF_ToolTip[aftt_localUser]["Guild"] == nil) then
				AF_ToolTip[aftt_localUser]["Guild"] = 1;
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: Guild: Show");
			elseif (AF_ToolTip[aftt_localUser]["Guild"] == 1) then
				AF_ToolTip[aftt_localUser]["Guild"] = 2;
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: Guild: Show Bottom");
			elseif (AF_ToolTip[aftt_localUser]["Guild"] == 2) then
				AF_ToolTip[aftt_localUser]["Guild"] = 0;
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: Guild: Hide");
			end


	--Toggle Reaction------------------------------------------
	-----------------------------------------------------------
		elseif (msg == "reaction") then
			if (AF_ToolTip[aftt_localUser]["ReactionText"] == 1) then
				AF_ToolTip[aftt_localUser]["ReactionText"] = 0;
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: Reaction: Hide");
			else
				AF_ToolTip[aftt_localUser]["ReactionText"] = 1;
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: Reaction: Show");
			end


	--Toggle Tapped--------------------------------------------
	-----------------------------------------------------------
		elseif (msg == "tapped") then
			if (AF_ToolTip[aftt_localUser]["Tapped"] == 1) then
				AF_ToolTip[aftt_localUser]["Tapped"] = 0;
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: Tapped: Hide");
			else
				AF_ToolTip[aftt_localUser]["Tapped"] = 1;
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: Tapped: Show");
			end



	--Help-----------------------------------------------------
	-----------------------------------------------------------
		elseif (msg == "help") then
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|r/aftt");
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|r/aftt mouse");
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|r/aftt topleft");
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|r/aftt top");
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|r/aftt topright");
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|r/aftt left");
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|r/aftt center");
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|r/aftt right");
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|r/aftt bottomleft");
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|r/aftt bottom");
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|r/aftt bottomright");
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|r/aftt clear");
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|r/afttx <" .. aftt_translate_number .. ">");
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|r/aftty <" .. aftt_translate_number .. ">");
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|r/aftt fade");
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|r/aftt pvp");
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|r/aftt guild");
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|r/aftt reaction");
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|r/aftt tapped");



	--Toggle Frames--------------------------------------------
	-----------------------------------------------------------
		elseif (msg == "") then
			aftt_toggleFrames();


	--Unknown Command------------------------------------------
	-----------------------------------------------------------
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|r" .. aftt_translate_unknowncommand .. ": " .. msg);
		end



end






--Push X Events-------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
function aftt_commandResponseX(msg)
	local msg = tonumber(msg);
	AF_ToolTip[aftt_localUser]["PositionX"] = msg;
	GameTooltip_SetDefaultAnchor = aftt_GameTooltip_SetDefaultAnchor;
	DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: X: " .. AF_ToolTip[aftt_localUser]["PositionX"]);
end






--Push Y Events-------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
function aftt_commandResponseY(msg)
	local msg = tonumber(msg);
	AF_ToolTip[aftt_localUser]["PositionY"] = msg;
	GameTooltip_SetDefaultAnchor = aftt_GameTooltip_SetDefaultAnchor;
	DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<AF>|rToolTip: Y: " .. AF_ToolTip[aftt_localUser]["PositionY"]);
end