--[[
--
--	Sea.wow.tooltip
--
--
--	Tooltip related functions
--
--	$LastChangedBy: mugendai $
--	$Rev: 2919 $
--	$Date: 2006-01-04 15:34:41 -0600 (Wed, 04 Jan 2006) $
--]]

Sea.wow.tooltip = {

	-- 
	-- clear( tooltipNameBase )
	--
	-- 	Clears out a tooltip
	--
	-- args
	--	(String tooltipNamebase)
	-- 	tooltipNameBase - the base name of the tooltip, like "GameTooltip"
	-- 
	clear = function ( tooltipBase )
		for i=1, 15, 1 do
			getglobal(tooltipBase.."TextLeft"..i):SetText("");
			getglobal(tooltipBase.."TextRight"..i):SetText("");
		end		
	end;

	-- 
	-- scan (tooltipName, strings)
	--
	-- 	Returns an associated table of the strings in a tooltip
	--
	-- args
	--	(String tooltipName)
	-- 	tooltipName - the name of the tooltip frame, like "GameTooltip"
	--	strings -	the table to store the strings in, use this to avoid continuously
	--						recreating and deleting tables
	--
	-- Returns:
	-- 	(table[id][.left .right .leftColor .rightColor] strings)
	--
	-- 	strings - all of the strings and colors in the tooltip
	--	
	scan = function ( tooltipName, strings )
		if ( tooltipName == nil ) then 
			tooltipName = "GameTooltip";
		end

		if (not strings) then
			strings = {};
		end
		local textLeft, textRight, ttextLeft, ttextRight, textLeftColorR, textLeftColorG, textLeftColorB, textLeftColorA, textRightColorR, textRightColorG, textRightColorB, textRightColorA;
		
		for idx = 1, 10 do
			textLeftColor = nil;
			textRightColor = nil;
			ttextLeft = getglobal(tooltipName.."TextLeft"..idx);
			if(ttextLeft and ttextLeft:IsShown()) then
				textLeft = ttextLeft:GetText();
				if (textLeft) then
					textLeftColorR, textLeftColorG, textLeftColorB, textLeftColorA = ttextLeft:GetTextColor();
					textLeftColor = {r=r, g=g, b=b, a=a};
				end
			else
				textLeft = nil;
			end
				
			ttextRight = getglobal(tooltipName.."TextRight"..idx);
			if(ttextRight and ttextRight:IsShown()) then
				textRight = ttextRight:GetText();
				if (textRight) then
					textRightColorR, textRightColorG, textRightColorB, textRightColorA = ttextRight:GetTextColor();
				end
			else
				textRight = nil;
			end
			
			--If there is text here, and the table doesn't exist for this row, then make it
			if ( ( textLeft or textRight ) and ( type( strings[idx] ) ~= "table" ) ) then
				strings[idx] = {};
			end
			--If we have a row to work with, then clear it
			if ( type( strings[idx] ) == "table" ) then
				if ( type( strings[idx].leftColor ) ~= "table" ) then
					strings[idx].leftColor = {};
				end
				if ( type( strings[idx].rightColor ) ~= "table" ) then
					strings[idx].rightColor = {};
				end
				--Clear the data for this row
				strings[idx].left = nil;
				strings[idx].right = nil;
				strings[idx].leftColor.r = nil;
				strings[idx].leftColor.g = nil;
				strings[idx].leftColor.b = nil;
				strings[idx].leftColor.a = nil;
				strings[idx].rightColor.r = nil;
				strings[idx].rightColor.g = nil;
				strings[idx].rightColor.b = nil;
				strings[idx].rightColor.a = nil;
			end

			if (textLeft or textRight) then
				strings[idx].left = textLeft;
				strings[idx].right = textRight;
				strings[idx].leftColor.r = textLeftColorR;
				strings[idx].leftColor.g = textLeftColorG;
				strings[idx].leftColor.b = textLeftColorB;
				strings[idx].leftColor.a = textLeftColorA;
				strings[idx].rightColor.r = textRightColorR;
				strings[idx].rightColor.g = textRightColorG;
				strings[idx].rightColor.b = textRightColorB;
				strings[idx].rightColor.a = textRightColorA;
			end	
		end

		return strings;
	end;

	-- 
	-- get (tooltip, row, value)
	--
	-- 	Returns text and/or color data from a single row in a tooltip.
	--	Unlike scan, it gets only the data requested, not the entire tooltip.
	--  This function will not generate any garbage collections.
	--
	-- args
	--	(String tooltip)
	-- 	tooltip - the name of the tooltip frame, defaults to "GameTooltip"
	--	(Integer row)
	-- 	row - the row to retreive from the tooltip, defaults to 1
	--	(String value)
	-- 	value -	which value you want to get, can be any of "left", "right", "leftColor", or "rightColor"
	--
	-- Returns:
	--	Based on value:
	--		nil - left, right, leftRed, leftGreen, leftBlue, leftAlpha, rightRed, rightGreen, rightBlue, rightAlpha
	-- 		"left" - String - left
	-- 		"right" - String - right
	-- 		"leftColor" - Integers - leftRed, leftGreen, leftBlue, leftAlpha
	-- 		"rightColor" - Integers - lrightRed, rightGreen, rightBlue, rightAlpha
	--		
	--
	-- 	strings - all of the strings and colors in the tooltip
	--	
	get = function ( tooltip, row, value )
		--Default to GameTooltip
		if (not tooltip) then
			tooltip = "GameTooltip";
		end
		--Default to first row
		if (not row) then
			row = 1;
		end

		local text, left, right, leftRed, leftGreen, leftBlue, leftAlpha, rightRed, rightGreen, rightBlue, rightAlpha;

		--Get the left tooltip
		if ( ( value == nil ) or ( value == "left" ) or ( value == "leftColor" ) ) then
			text = getglobal(tooltip.."TextLeft"..row);

			--Get the left tooltip text
			if ( ( value == nil ) or ( value == "left" ) ) then
				if ( text and text:IsShown() ) then
					left = text:GetText();
				end
				--If this is all they want, then return it now
				if ( value == "left" ) then
					return left;
				end
			end
			--Get the left tooltip color
			if ( ( value == nil ) or ( value == "leftColor" ) ) then
				if ( text and text:IsShown() ) then
					leftRed, leftGreen, leftBlue, leftAlpha = text:GetTextColor();
				end
				--If this is all they want, then return it now
				if ( value == "leftColor" ) then
					return leftRed, leftGreen, leftBlue, leftAlpha;
				end
			end
		end
		
		--Get the right tooltip
		if ( ( value == nil ) or ( value == "right" ) or ( value == "rightColor" ) ) then
			text = getglobal(tooltip.."TextRight"..row);

			--Get the right tooltip text
			if ( ( value == nil ) or ( value == "right" ) ) then
				if ( text and text:IsShown() ) then
					right = text:GetText();
				end
				--If this is all they want, then return it now
				if ( value == "right" ) then
					return right;
				end
			end
			--Get the right tooltip color
			if ( ( value == nil ) or ( value == "rightColor" ) ) then

				if ( text and text:IsShown() ) then
					rightRed, rightGreen, rightBlue, rightAlpha = text:GetTextColor();
				end
				--If this is all they want, then return it now
				if ( value == "rightColor" ) then
					return rightRed, rightGreen, rightBlue, rightAlpha;
				end
			end
		end

		--If no individual value was specified, return the entire row
		return left, right, leftRed, leftGreen, leftBlue, leftAlpha, rightRed, rightGreen, rightBlue, rightAlpha;
	end;

	-- 
	-- compareTooltipScan(scanTable left, scanTable right)
	--
	-- 	compares the results of two tooltip scans (by string only, not color)
	--
	-- Args:
	-- 	left - the result of a scan or string (implies tooltip base to scan)
	-- 	right - the result of a scan or string (implies tooltip base to scan)
	-- 	      or nil (implies gametooltip)
	--
	-- Returns:
	-- 	(boolean, number)
	-- 	true if equal
	-- 	0 if equals, -1 if left is less, 1 if right is less
	--
	-- 	
	compareTooltipScan = function ( leftScan, rightScan ) 
		if ( type(leftScan) == "string" ) then
			leftScan = Sea.wow.tooltip.scan(leftScan);
		end
		if ( type(rightScan) == "string" ) then
			rightScan = Sea.wow.tooltip.scan(rightScan);
		end
		if ( type(leftScan) == "nil" ) then 
			leftScan = Sea.wow.tooltip.scan();
		end
		if ( type(rightScan) == "nil" ) then 
			rightScan = Sea.wow.tooltip.scan();
		end
			
		
		local result = 0;
		
		for i=1,10,1 do
			if ( leftScan[i] ) then
				if ( leftScan[i].left ~= nil ) then
					if ( rightScan[i] and (rightScan[i].left ~= nil) ) then
						if ( leftScan[i].left < rightScan[i].left ) then 
							result = -1;
							break;
						elseif ( leftScan[i].left > rightScan[i].left ) then 
							result = 1;
							break;
						end
					else
						result = 1;
						break;
					end
				end
				if ( leftScan[i].right ~= nil ) then
					if ( rightScan[i].right and (rightScan[i].right ~= nil) ) then
						if ( leftScan[i].right < rightScan[i].right ) then 
							result = -1;
							break;
						elseif ( leftScan[i].right > rightScan[i].right ) then 
							result = 1;
							break;
						end
					else
						result = 1;
						break;
					end
				end
			end
		end	

		return (result==0), result;
	end;
	
	-- 
	-- create (tooltipTable, tooltipName)
	--
	--	Returns nil if failed, true if successful.
	--	Dont forget to set ownership of the Tooltip before creation:
	--	Use ToolTip:SetOwner, Sea.wow.tooltip.smartSetOwner, or GameTooltip_SetDefaultAnchor 
	--	*Currently ignores line size, font*
	--
	-- args
	--	(table tooltipTable, String tooltipName)
	--	tooltipTable - associated table of the strings for the tooltip
	-- 	tooltipName (Optional) - the name of the tooltip frame, uses "GameTooltip" as default
	--
	-- Returns:
	-- 	true (success) or nil (failure)
	--
	--	
	create = function ( tooltipTable, tooltipName )
		if ( tooltipName == nil ) then 
			tooltipName = "GameTooltip";
		end
		local tooltip = getglobal(tooltipName);
		local ttext;
		for idx, line in tooltipTable do
			if (idx == 1) and ((line.left) or (line.right)) then
				tooltip:SetText(line.left);
				--SetText will clear tooltip
				if (line.right) then
					ttext = getglobal(tooltipName.."TextRight"..idx);
					if (ttext) then
						ttext:SetText(line.right);
						if (line.rightColor) then
							ttext:SetTextColor(line.rightColor.r, line.rightColor.g, line.rightColor.b, line.rightColor.a);
						end
						ttext:Show();
					end
				end
			else
				if (line.right) then
					tooltip:AddDoubleLine(line.left, line.right);
					if (line.rightColor) then
						ttext = getglobal(tooltipName.."TextRight"..idx);
						if (ttext) and (line.rightColor) then
							ttext:SetTextColor(line.rightColor.r, line.rightColor.g, line.rightColor.b, line.rightColor.a);
							--Would just use AddDoubleLine to set the color but it has no way to set alpha
						end
					end
				else
					tooltip:AddLine(line.left);
				end
			end
			
			if (line.leftColor) then
				ttext = getglobal(tooltipName.."TextLeft"..idx);
				if (ttext) and (line.leftColor)then
					ttext:SetTextColor(line.leftColor.r, line.leftColor.g, line.leftColor.b, line.leftColor.a);
				end
			end
		end
		
		tooltip:Show()	-- Dynamicly Update Size (in the OnShow)
		return true;
	end;
	
	--
	-- smartSetOwner (owner, tooltip, x, y)
	--
	-- Sets the tooltip relative to the owner in a position
	-- appropriate for where the owner is on the screen.
	-- owner - optional, the owner object, defaults to this
	-- tooltip, optional, the tooltip to set, defaults to GameTooltip
	-- setX, optional, sets the x offset(flipped based on screen corner)
	-- setY, optional, sets the y offset(flipped based on screen corner)
	--
	-- Args:
	-- 	(Frame owner, Tooltip tooltip, float x, float y)
	--
	-- 	owner - the new parent frame
	-- 	tooltip - the tooltip to relocate
	-- 	x - new x
	-- 	y - new y
	--
	smartSetOwner = function (owner, tooltip, setX, setY)
	 	if (not owner) then
 			owner = this;
	 	end
	 	if (not tooltip) then
 			tooltip = GameTooltip;
	 	end
 		if (not setX) then
	 		setX = 0;
 		end
	 	if (not setY) then
	 		setY = 0;
 		end
	 	if (owner) then
			local x,y = owner:GetCenter();
			local left = owner:GetLeft();
			local right = owner:GetRight();
			local top = owner:GetTop();
			local bottom = owner:GetBottom();
			local screenWidth = UIParent:GetWidth();
			local screenHeight = UIParent:GetHeight();
			local scale = owner:GetScale();
			if (x~=nil and y~=nil and left~=nil and right~=nil and top~=nil and bottom~=nil and screenWidth>0 and screenHeight>0) then
				setX = setX * scale;
				setY = setY * scale;
				x = x * scale;
				y = y * scale;
				left = left * scale;
				right = right * scale;
				width = right - left;
				top = top * scale;
				bottom = bottom * scale;
				local anchorPoint = "";
				if (y <= (screenHeight * (1/2))) then
					top = top + setY;
					anchorPoint = "TOP";
					if (top < 0) then
						setY = setY - top;
					end
				else
					setY = -setY;
					bottom = bottom + setY;
					anchorPoint = "BOTTOM";
					if (bottom > screenHeight) then
						setY = setY + (screenHeight - bottom);
					end
				end			
				if (x <= (screenWidth * (1/2))) then
					left = left + setX;
					if (anchorPoint == "BOTTOM") then
						anchorPoint = anchorPoint.."RIGHT";
						setX = setX - width;
						if (left < 0) then
							setX = setX - left;
						end
					else
						anchorPoint = anchorPoint.."LEFT";
						if (left < 0) then
							setX = setX - left;
						end
					end
				else
					setX = -setX;
					right = right + setX;
					if (anchorPoint == "BOTTOM") then
						anchorPoint = anchorPoint.."LEFT";
						setX = setX + width;
						if (right > screenWidth) then
							setX = setX - (right - screenWidth);
						end
					else
						anchorPoint = anchorPoint.."RIGHT";
						if (right > screenWidth) then
							setX = setX + (screenWidth - right);
						end
					end
				end
				
				if (anchorPoint == "") then
					anchorPoint = "TOPLEFT";
				end
				scale = tooltip:GetScale();
				if (scale) then
					setX = setX / scale;
					setY = setY / scale;
				end
				tooltip:SetOwner(owner, "ANCHOR_"..anchorPoint, setX, setY);
			end
		else
			tooltip:SetOwner(owner, "ANCHOR_TOPLEFT");
		end
	end;


	--
	-- protectTooltipMoney ()
	--
	-- Args:
	--  None.
	--
	-- Returns:
	--  Nothing.
	--
	--  Thanks to Telo for providing this solution!
	--  Prevents the clearing of money from tooltips. Changes GameTooltip_ClearMoney.
	--  USE WITH CAUTION! ALWAYS CALL unprotectMoneyTooltip() AFTER SETTING THE TOOLTIP!
	--
	protectTooltipMoney = function()
		if ( not Sea.wow.tooltip.saved_GameTooltip_ClearMoney ) then
			Sea.wow.tooltip.saved_GameTooltip_ClearMoney = GameTooltip_ClearMoney;
			GameTooltip_ClearMoney = Sea.wow.tooltip.doNothingTooltipMoney;
		end
	end;

	--
	-- unprotectTooltipMoney ()
	--
	-- Args:
	--  None.
	--
	-- Returns:
	--  Nothing.
	--
	--  Thanks to Telo for providing this solution!
	--  Allows the clearing of money from tooltips. Changes GameTooltip_ClearMoney.
	--
	unprotectTooltipMoney = function()
		if ( Sea.wow.tooltip.saved_GameTooltip_ClearMoney ) then
			GameTooltip_ClearMoney = Sea.wow.tooltip.saved_GameTooltip_ClearMoney;
			Sea.wow.tooltip.saved_GameTooltip_ClearMoney = nil;
		end
	end;
	
	--
	-- unprotectTooltipMoney ()
	--
	-- Args:
	--  None.
	--
	-- Returns:
	--  Nothing.
	--
	--  Does nothing.
	--
	doNothingTooltipMoney = function()
	end;
	
	saved_GameTooltip_ClearMoney = nil;
};
