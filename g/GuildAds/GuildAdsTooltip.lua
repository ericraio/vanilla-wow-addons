local playerName;
local playerAccount;

function GuildAdsTooltip_OnLoad()
	playerName = UnitName("player");
end

function GuildAdsTooltip_Format(adtype, data)
	if data then
		local r, g, b;
		local ownerAccount = GAS_ProfileGet(data.owner).accountid or true;
		if data.owner==playerName or ownerAccount==playerAccount then
			if adtype==GUILDADS_MSG_TYPE_REQUEST then
				r, g, b = 1,0.75,0;
			else
				r, g, b = 1,0,0.75;
			end
		else
			if adtype==GUILDADS_MSG_TYPE_REQUEST then
				r, g, b = 1,1,0.5;
			else
				r, g, b = 1,0.5,1;
			end
		end
		if data.inf then
			if data.count>0 then
				return data.owner .. " (" .. data.count .. "+)", r, g, b;
			else
				return data.owner, r, g, b;
			end
		else
			return data.owner .. " (" .. data.count .. ")", r, g, b;
		end	
	else
		return " ", 1, 1, 1;
	end
end

function GuildAdsTooltip_OnShow()
	GuildAdsTooltip_AddInformations(GameTooltip);
end

function GuildAdsTooltip_AddInformations(tooltip)
	local lbl = getglobal(tooltip:GetName().."TextLeft1");
	if lbl then
		local itemName = lbl:GetText();
		local infosR, infosA = GAS_GetItemAdsInfo(itemName); 
		if infosR or infosA then
			
			playerAccount = GAS_ProfileGet(playerName).accountid;
			
			local i=1;
			while (infosR[i] or infosA[i]) and i<5 do
				local msgR, msgRr, msgRg, msgRb = GuildAdsTooltip_Format(GUILDADS_MSG_TYPE_REQUEST, infosR[i]);
				local msgA, msgAr, msgAg, msgAb = GuildAdsTooltip_Format(GUILDADS_MSG_TYPE_AVAILABLE, infosA[i]);
				GameTooltip:AddDoubleLine(msgR, msgA, msgRr, msgRg, msgRb, msgAr, msgAg, msgAb);
				i= i+1;
			end
			tooltip:Show();
		end
	end
end

