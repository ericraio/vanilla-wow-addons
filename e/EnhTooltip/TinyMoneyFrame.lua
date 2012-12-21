--[[
	TinyMoneyFrame functions
	3.8.0 (Kangaroo)
   
	$Id: TinyMoneyFrame.lua 632 2005-12-18 14:36:34Z norganna $
  
	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GLP.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
]]

function TinyMoneyFrame_Update(frameName, money)
	local frame = getglobal(frameName);
	local info = frame.info;
	if ( not info ) then
		message("Error moneyType not set");
	end

	-- Breakdown the money into denominations
	local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD));
	local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
	local copper = mod(money, COPPER_PER_SILVER);

	local goldButton = getglobal(frameName.."GoldButton");
	local silverButton = getglobal(frameName.."SilverButton");
	local copperButton = getglobal(frameName.."CopperButton");

	local iconWidth = MONEY_ICON_WIDTH;
	local spacing = MONEY_BUTTON_SPACING;
	if ( frame.small ) then
		iconWidth = MONEY_ICON_WIDTH_SMALL;
		spacing = MONEY_BUTTON_SPACING_SMALL;
	end

	-- Set values for each denomination
	goldButton:SetText(gold);
	goldButton:SetWidth(goldButton:GetTextWidth() + iconWidth);
	goldButton:Show();
	
	if (gold > 0) then
		silverButton:SetText(string.format("%."..math.log10(SILVER_PER_GOLD).."d", silver));
	else
		silverButton:SetText(silver);
	end
	silverButton:SetWidth(silverButton:GetTextWidth() + iconWidth);
	silverButton:Show();
	
	if (gold > 0 or silver > 0) then
		copperButton:SetText(string.format("%."..math.log10(COPPER_PER_SILVER).."d", copper));
	else
		copperButton:SetText(copper);
	end
	copperButton:SetWidth(copperButton:GetTextWidth() + iconWidth);
	copperButton:Show();

	-- Store how much money the frame is displaying
	frame.staticMoney = money;

	-- If not collapsable don't need to continue
	if ( not info.collapse ) then
		return;
	end

	local width = iconWidth;
	local showLowerDenominations, truncateCopper;
	if ( gold > 0 ) then
		width = width + goldButton:GetWidth();
		if ( info.showSmallerCoins ) then
			showLowerDenominations = 1;
		end
		if ( info.truncateSmallCoins ) then
			truncateCopper = 1;
		end
	else
		goldButton:Hide();
	end

	if ( silver > 0 or showLowerDenominations ) then
		if ( gold > 0 ) then
			silverButton:SetWidth(25);
		end
		
		width = width + silverButton:GetWidth();
		goldButton:SetPoint("RIGHT", frameName.."SilverButton", "LEFT", spacing, 0);
		if ( goldButton:IsVisible() ) then
			width = width - spacing;
		end
		if ( info.showSmallerCoins ) then
			showLowerDenominations = 1;
		end
	else
		silverButton:Hide();
		goldButton:SetPoint("RIGHT", frameName.."SilverButton",	"RIGHT", 0, 0);
	end

	-- Used if we're not showing lower denominations
	if ( (copper > 0 or showLowerDenominations or info.showSmallerCoins == "Backpack") and not truncateCopper) then
		if ( gold > 0 or silver > 0 ) then
			copperButton:SetWidth(25);
		end
		
		width = width + copperButton:GetWidth();
		silverButton:SetPoint("RIGHT", frameName.."CopperButton", "LEFT", spacing, 0);
		if ( silverButton:IsVisible() ) then
			width = width - spacing;
		end
	else
		copperButton:Hide();
		silverButton:SetPoint("RIGHT", frameName.."CopperButton", "RIGHT", 0, 0);
	end

	frame:SetWidth(width);
end

function TinyMoneyFrame_UpdateMoney()
	if ( this.info ) then
		local money = this.info.UpdateFunc();
		TinyMoneyFrame_Update(this:GetName(), money);
		if ( this.hasPickup == 1 ) then
			UpdateCoinPickupFrame(money);
		end
	else
		message("Error moneyType not set");
	end
end
