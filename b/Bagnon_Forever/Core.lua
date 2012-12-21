--[[
	BagnonForever
		Adds offline and bank viewing to Bagnon
--]]

function BagnonForever_OnLoad()
	BagnonFrame_OnDoubleClick = function(frame)
		if(arg1 == "LeftButton") then
			BagnonForeverMenu_Show(frame);
		end
	end;
	this:RegisterEvent("BANKFRAME_OPENED");
end

function BagnonForever_OnEvent(event)
	if(event == "BANKFRAME_OPENED") then
		--switch to the current character at the bank
		if(Banknon) then
			BagnonForever_ChangeCharacter(Banknon, UnitName("player"));
		end
	end
end

--switch to view a different character
function BagnonForever_ChangeCharacter(frame, character)
	local frameTitle = getglobal(frame:GetName() .. "Title");
	
	frameTitle:SetText( string.format(frame.title, character ) );
	frame.player = character
	
	BagnonFrame_UnhighlightAll(frame);
	BagnonFrame_GenerateFrame(frame);
	
	local bags = { getglobal(frame:GetName() .. "Bags"):GetChildren() };
	for bag in bags do
		BagnonBag_UpdateTexture(frame, bags[bag]:GetID());
	end
	
	if(frame == Banknon) then
		Banknon_UpdatePurchaseButtonVis();
	end
end

--money frame tooltips, overriden from BagnonFrame
--Displays the total funds for all characters
function BagnonFrameMoney_OnEnter()	
	local realm = GetRealmName();
	local money = 0;
	
	if( this:GetLeft() > ( UIParent:GetRight() / 2) ) then
		GameTooltip:SetOwner(this, "ANCHOR_LEFT");
	else
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	end
	
	GameTooltip:SetText( string.format(BAGNON_FOREVER_MONEY_ON_REALM, realm) );
	
	for player in BagnonDB[realm] do
		if( BagnonDB[realm][player].g ) then
			money = money + BagnonDB[realm][player].g;
		end
	end
	
	SetTooltipMoney(GameTooltip, money);
	GameTooltip:Show();
end