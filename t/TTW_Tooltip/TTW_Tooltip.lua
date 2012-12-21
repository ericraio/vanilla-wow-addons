--[[

	Tooltip Wrangler
	
	- Allows the user to move the tooltips freely about the screen.  
	Works great with most other tooltip mod programs including AF_Tooltip and GypsyMod.
	
]]

--------------------------------------------------------------------------------------------------
-- Localizable strings
--------------------------------------------------------------------------------------------------
TTW_LOCK = "lock";		-- must be lowercase; locks the window in position
TTW_UNLOCK = "unlock";		-- must be lowercase; unlocks the window so that it can be dragged
TTW_HELP = "help";
TTW_FOLLOWMOUSE = "mouse";
TTW_USETARGET = "target";
TTW_RESET = "reset";

TTW_LOCKED = "Tooltip Wrangler: Locked in place.";
TTW_UNLOCKED = "Tooltip Wrangler: Unlocked.  Position at will!";
TTW_INVALID = "Tooltip Wrangler: Invalid command. Type /ttw help for a list of valid commands.";
TTW_TARGET_MSG = "Tooltip Wrangler: Tooltips have been placed at the target.";
TTW_MOUSE_MSG = "Tooltip Wrangler: Tooltips have been placed at the cursor."
TTW_HELP_MSG = "Tooltip Wrangler: Below is a listing of valid commands \(use /ttw <command>\):\nmouse: Attach the tooltip to the mouse cursor.\ntarget: Drag the targeting window to place the tooltip.\nlock: Lock the tooltip in place \(hides the placement window\).\nunlock: Unlock the tooltip placement window \(Shows the placement window\).";

--------------------------------------------------------------------------------------------------
-- Local Variables
--------------------------------------------------------------------------------------------------
TTW_TOPLEFT 	= 0;
TTW_TOPRIGHT 	= 1;
TTW_BOTTOMRIGHT	= 2;
TTW_BOTTOMLEFT 	= 3;
TTW_TOP		= 4;
TTW_BOTTOM	= 5;
TTW_LEFT	= 6;
TTW_RIGHT	= 7;

TTW_MOUSE	= 0;
TTW_TARGET	= 1;

--------------------------------------------------------------------------------------------------
-- Internal functions
--------------------------------------------------------------------------------------------------

function TTW_PositionTooltip(tooltip,parent)
	anchorType = TTWState.AnchorType;
	
	if (anchorType == TTW_MOUSE) then
		tooltip:SetOwner(parent, "ANCHOR_CURSOR");
	else
		local topPos,leftPos,bottomPos,rightPos;
		topPos 		= TTW_RecticleFrame:GetTop();
		leftPos 	= TTW_RecticleFrame:GetLeft();
		bottomPos 	= TTW_RecticleFrame:GetBottom();
		rightPos	= TTW_RecticleFrame:GetRight();

		if (rightPos == nil) then
			rightPos = 0;
		end
		if (leftPos == nil) then
			leftPos = 0;
		end
		if (topPos == nil) then
			topPos = 0;
		end
		if (bottomPos == nil) then
			bottomPos = 0;
		end


		local xPos,yPos;
		xPos = leftPos + ((rightPos-leftPos) / 2);
		yPos = topPos + ((bottomPos - topPos) / 2);

		tooltip:ClearAllPoints();
		tooltip:SetOwner(parent, "ANCHOR_NONE");
	
		anchor = TTWState.Anchor;
	
		if (anchor == TTW_TOPLEFT) then
			anchor = "TOPLEFT";
			xPos = xPos - 3;
			yPos = yPos + 3;
		elseif (anchor == TTW_TOPRIGHT) then
			anchor = "TOPRIGHT";
			xPos = xPos + 3;
			yPos = yPos + 3;
		elseif (anchor == TTW_BOTTOMRIGHT) then
			anchor = "BOTTOMRIGHT";
			xPos = xPos + 3;
			yPos = yPos - 3;
		elseif (anchor == TTW_TOP) then
			anchor = "TOP";
			xPos = xPos - 3;
			yPos = yPos + 3;
		elseif (anchor == TTW_BOTTOM) then
			anchor = "BOTTOM";
			xPos = xPos - 3;
			yPos = yPos - 3;
		elseif (anchor == TTW_LEFT) then
			anchor = "LEFT";
			xPos = xPos - 3;
		elseif (anchor == TTW_RIGHT) then
			anchor = "RIGHT";
			xPos = xPos - 3;
		else
			anchor = "BOTTOMLEFT";
			xPos = xPos - 3;
			yPos = yPos - 3;
		end

		local scale = UIParent:GetScale() / GameTooltip:GetEffectiveScale();
		xPos = scale * xPos;
		yPos = scale * yPos;

		tooltip:SetPoint(anchor, "UIParent", "BOTTOMLEFT", xPos, yPos);
	end
end

function TTW_Reset()
	TTW_RecticleFrame:SetPoint("TOPLEFT","UIParent","TOPLEFT",200,-200);
end

function TTW_SlashCommandHandler(msg)
	if( msg ) then
		local command = string.lower(msg);
		if( command == TTW_LOCK ) then
			if ( TTWState.AnchorType ~= TTW_MOUSE ) then
				TTWState.Lock = 1;
				TTW_RecticleFrame:Hide();
				GameTooltip:Hide();
				DEFAULT_CHAT_FRAME:AddMessage(TTW_LOCKED);
			end
		elseif( command == TTW_UNLOCK ) then
			if ( TTWState.AnchorType ~= TTW_MOUSE ) then
				TTWState.Lock = nil;
				TTW_RecticleFrame:Show();
				DEFAULT_CHAT_FRAME:AddMessage(TTW_UNLOCKED);
			end
		elseif( command == TTW_FOLLOWMOUSE ) then
			TTWState.AnchorType = TTW_MOUSE;
			TTW_RecticleFrame:Hide();
			GameTooltip:Hide();
			DEFAULT_CHAT_FRAME:AddMessage(TTW_MOUSE_MSG);
		elseif ( command == TTW_USETARGET ) then
			TTWState.AnchorType = TTW_TARGET;
			TTW_RecticleFrame:Show();
			DEFAULT_CHAT_FRAME:AddMessage(TTW_TARGET_MSG);
			TTWState.Lock = nil;
			DEFAULT_CHAT_FRAME:AddMessage(TTW_UNLOCKED);
		elseif ( command == TTW_HELP  or command=="" ) then
			DEFAULT_CHAT_FRAME:AddMessage(TTW_HELP_MSG);
		elseif ( command == TTW_RESET ) then
			TTW_Reset();
		else
			DEFAULT_CHAT_FRAME:AddMessage(TTW_INVALID);
		end
	end
end

function TTW_SetClickState(state)
	if (state == TTW_TOPLEFT) then
		TTW_AnchorTopLeftButton:SetButtonState("PUSHED",1);
		TTW_AnchorTopRightButton:SetButtonState("NORMAL",0);
		TTW_AnchorBottomRightButton:SetButtonState("NORMAL",0);
		TTW_AnchorBottomLeftButton:SetButtonState("NORMAL",0);
		TTW_AnchorTopButton:SetButtonState("NORMAL",0);
		TTW_AnchorBottomButton:SetButtonState("NORMAL",0);
		TTW_AnchorLeftButton:SetButtonState("NORMAL",0);
		TTW_AnchorRightButton:SetButtonState("NORMAL",0);
	elseif (state == TTW_TOPRIGHT) then
		TTW_AnchorTopLeftButton:SetButtonState("NORMAL",0);
		TTW_AnchorTopRightButton:SetButtonState("PUSHED",1);
		TTW_AnchorBottomRightButton:SetButtonState("NORMAL",0);
		TTW_AnchorBottomLeftButton:SetButtonState("NORMAL",0);
		TTW_AnchorTopButton:SetButtonState("NORMAL",0);	
		TTW_AnchorBottomButton:SetButtonState("NORMAL",0);
		TTW_AnchorLeftButton:SetButtonState("NORMAL",0);
		TTW_AnchorRightButton:SetButtonState("NORMAL",0);
	elseif (state == TTW_BOTTOMRIGHT) then
		TTW_AnchorTopLeftButton:SetButtonState("NORMAL",0);
		TTW_AnchorTopRightButton:SetButtonState("NORMAL",0);
		TTW_AnchorBottomRightButton:SetButtonState("PUSHED",1);
		TTW_AnchorBottomLeftButton:SetButtonState("NORMAL",0);
		TTW_AnchorTopButton:SetButtonState("NORMAL",0);
		TTW_AnchorBottomButton:SetButtonState("NORMAL",0);
		TTW_AnchorLeftButton:SetButtonState("NORMAL",0);
		TTW_AnchorRightButton:SetButtonState("NORMAL",0);
	elseif (state == TTW_BOTTOMLEFT) then 
		TTW_AnchorTopLeftButton:SetButtonState("NORMAL",0);
		TTW_AnchorTopRightButton:SetButtonState("NORMAL",0);
		TTW_AnchorBottomRightButton:SetButtonState("NORMAL",0);
		TTW_AnchorBottomLeftButton:SetButtonState("PUSHED",1);
		TTW_AnchorTopButton:SetButtonState("NORMAL",0);
		TTW_AnchorBottomButton:SetButtonState("NORMAL",0);
		TTW_AnchorLeftButton:SetButtonState("NORMAL",0);
		TTW_AnchorRightButton:SetButtonState("NORMAL",0);
	elseif (state == TTW_TOP) then 
		TTW_AnchorTopLeftButton:SetButtonState("NORMAL",0);
		TTW_AnchorTopRightButton:SetButtonState("NORMAL",0);
		TTW_AnchorBottomRightButton:SetButtonState("NORMAL",0);
		TTW_AnchorBottomLeftButton:SetButtonState("NORMAL",0);
		TTW_AnchorTopButton:SetButtonState("PUSHED",1);
		TTW_AnchorBottomButton:SetButtonState("NORMAL",0);
		TTW_AnchorLeftButton:SetButtonState("NORMAL",0);
		TTW_AnchorRightButton:SetButtonState("NORMAL",0);
	elseif (state == TTW_BOTTOM) then 
		TTW_AnchorTopLeftButton:SetButtonState("NORMAL",0);
		TTW_AnchorTopRightButton:SetButtonState("NORMAL",0);
		TTW_AnchorBottomRightButton:SetButtonState("NORMAL",0);
		TTW_AnchorBottomLeftButton:SetButtonState("NORMAL",0);
		TTW_AnchorTopButton:SetButtonState("NORMAL",0);
		TTW_AnchorBottomButton:SetButtonState("PUSHED",1);
		TTW_AnchorLeftButton:SetButtonState("NORMAL",0);
		TTW_AnchorRightButton:SetButtonState("NORMAL",0);
	elseif (state == TTW_LEFT) then 
		TTW_AnchorTopLeftButton:SetButtonState("NORMAL",0);
		TTW_AnchorTopRightButton:SetButtonState("NORMAL",0);
		TTW_AnchorBottomRightButton:SetButtonState("NORMAL",0);
		TTW_AnchorBottomLeftButton:SetButtonState("NORMAL",0);
		TTW_AnchorTopButton:SetButtonState("NORMAL",0);
		TTW_AnchorBottomButton:SetButtonState("NORMAL",0);
		TTW_AnchorLeftButton:SetButtonState("PUSHED",1);
		TTW_AnchorRightButton:SetButtonState("NORMAL",0);
	elseif (state == TTW_RIGHT) then 
		TTW_AnchorTopLeftButton:SetButtonState("NORMAL",0);
		TTW_AnchorTopRightButton:SetButtonState("NORMAL",0);
		TTW_AnchorBottomRightButton:SetButtonState("NORMAL",0);
		TTW_AnchorBottomLeftButton:SetButtonState("NORMAL",0);
		TTW_AnchorTopButton:SetButtonState("NORMAL",0);
		TTW_AnchorBottomButton:SetButtonState("NORMAL",0);
		TTW_AnchorLeftButton:SetButtonState("NORMAL",0);
		TTW_AnchorRightButton:SetButtonState("PUSHED",1);
	end
end


--------------------------------------------------------------------------------------------------
-- Handler functions
--------------------------------------------------------------------------------------------------

function TTW_TooltipOnLoad()
	--RegisterForSave("TTWState");
	
	this:RegisterEvent("VARIABLES_LOADED");

	-- Register our slash command
	SLASH_TTW1 = "/tooltipwrangler";
	SLASH_TTW2 = "/ttw";
	SlashCmdList["TTW"] = function(msg)
		TTW_SlashCommandHandler(msg);
	end
	
	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("Tootip Wrangler: AddOn loaded");
	end

	UIErrorsFrame:AddMessage("Tooltip Wrangler: AddOn loaded", 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
end


function TTW_TooltipOnEvent(event)
	if( event == "VARIABLES_LOADED" ) then
		if( not TTWState ) then
			TTWState = { };
		end

		if(TTWState.Lock==1) then
			TTW_RecticleFrame:Hide();
			GameTooltip:Hide();
			DEFAULT_CHAT_FRAME:AddMessage(TTW_LOCKED);
		else
			TTW_RecticleFrame:Show();
			DEFAULT_CHAT_FRAME:AddMessage(TTW_UNLOCKED);
		end

		TTW_SetClickState(TTWState.Anchor);

		if (TTWState.AnchorType == TTW_MOUSE) then
			TTW_RecticleFrame:Hide();
		end

		GameTooltip_SetDefaultAnchor = TTW_PositionTooltip;
	end
end

function TTW_TooltipOnMouseDown()
	GameTooltip:Hide();
	TTW_RecticleFrame:StartMoving()
end

function TTW_TooltipOnMouseUp()
	TTW_RecticleFrame:StopMovingOrSizing()
end

function TTW_AnchorTopLeftOnClick()
	PlaySound("igMainMenuClose");
	TTW_SetClickState(TTW_TOPLEFT);
	TTWState.Anchor = TTW_TOPLEFT;
end

function TTW_AnchorTopRightOnClick()
	PlaySound("igMainMenuClose");
	TTW_SetClickState(TTW_TOPRIGHT);
	TTWState.Anchor = TTW_TOPRIGHT;
end

function TTW_AnchorBottomRightOnClick()
	PlaySound("igMainMenuClose");
	TTW_SetClickState(TTW_BOTTOMRIGHT);
	TTWState.Anchor = TTW_BOTTOMRIGHT;
end

function TTW_AnchorBottomLeftOnClick()
	PlaySound("igMainMenuClose");
	TTW_SetClickState(TTW_BOTTOMLEFT);
	TTWState.Anchor = TTW_BOTTOMLEFT;
end

function TTW_AnchorTopOnClick()
	PlaySound("igMainMenuClose");
	TTW_SetClickState(TTW_TOP);
	TTWState.Anchor = TTW_TOP;
end

function TTW_AnchorBottomOnClick()
	PlaySound("igMainMenuClose");
	TTW_SetClickState(TTW_BOTTOM);
	TTWState.Anchor = TTW_BOTTOM;
end

function TTW_AnchorLeftOnClick()
	PlaySound("igMainMenuClose");
	TTW_SetClickState(TTW_LEFT);
	TTWState.Anchor = TTW_LEFT;
end

function TTW_AnchorRightOnClick()
	PlaySound("igMainMenuClose");
	TTW_SetClickState(TTW_RIGHT);
	TTWState.Anchor = TTW_RIGHT;
end

function TTW_ButtonTooltip()
	if( this:GetCenter() < GetScreenWidth() / 2 ) then
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	else
		GameTooltip:SetOwner(this, "ANCHOR_LEFT");
	end	

	if (this == TTW_AnchorTopLeftButton) then
		GameTooltip:SetText("Anchor the \"Top Left\" corner of the\ntooltip to the center of the target.\n\(Right and Bottom edges will grow\)");
	elseif (this == TTW_AnchorTopRightButton) then
		GameTooltip:SetText("Anchor the \"Top Right\" corner of the\ntooltip to the center of the target.\n\(Left and Bottom edges will grow\)");
	elseif (this == TTW_AnchorBottomRightButton) then
		GameTooltip:SetText("Anchor the \"Bottom Right\" corner of the\ntooltip to the center of the target.\n\(Left and Top edges will grow\)");
	elseif (this == TTW_AnchorBottomLeftButton) then
		GameTooltip:SetText("Anchor the \"Bottom Left\" corner of the\ntooltip to the center of the target.\n\(Right and Top edges will grow\)");	
	elseif (this == TTW_AnchorTopButton) then
		GameTooltip:SetText("Anchor the \"Top Center\" side of the\ntooltip to the center of the target.\n\(Bottom, Left and Right edges will grow\)");	
	elseif (this == TTW_AnchorBottomButton) then
		GameTooltip:SetText("Anchor the \"Bottom Center\" side of the\ntooltip to the center of the target.\n\(Top, Left and Right edges will grow\)");	
	elseif (this == TTW_AnchorLeftButton) then
		GameTooltip:SetText("Anchor the \"Left Center\" side of the\ntooltip to the center of the target.\n\(Top, Bottom and Right edges will grow\)");	
	elseif (this == TTW_AnchorRightButton) then
		GameTooltip:SetText("Anchor the \"Right Center\" side of the\ntooltip to the center of the target.\n\(Top, Bottom and Left edges will grow\)");	
	end
end