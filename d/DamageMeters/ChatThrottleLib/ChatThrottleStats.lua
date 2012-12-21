
if(CTLStats) then
	CTLStats:Hide();
end

CTLStats = CreateFrame("Frame", "UIParent");
CTLStats:SetAllPoints(UIParent);
CTLStats:SetFrameStrata("TOOLTIP");

CTLStatsText = CTLStats:CreateFontString(nil,nil,"GameFontHighlightSmall");
CTLStatsText:SetPoint("TOPLEFT", CTLStats, 0, 0);


local lastsent = 0;
local lastbypass = 0;
local lasttime = GetTime();

CTLStats:SetScript("OnUpdate", function()
	local now = GetTime()
	
	if(now - lasttime > 1) then
		
		ChatThrottleLib:UpdateAvail();		-- NOTE THAT THIS NORMALLY DOES NOT GET CALLED PERIODICALLY. Disable this for final testing!
	
		local sent = 0;
		for _,Prio in ChatThrottleLib.Prio do
			sent = sent + Prio.nTotalSent;
		end
		
		CTLStatsText:SetText(format("%4.0f cps via lib (%4.0f bytes avail), %4.0f cps bypassed lib", 
			(sent-lastsent) / (now-lasttime), 
			ChatThrottleLib.avail,
			(ChatThrottleLib.nBypass-lastbypass) / (now-lasttime)
		));
		
		lasttime=now;
		lastsent=sent;
		lastbypass=ChatThrottleLib.nBypass;
		
	end
	
	if(ChatThrottleLib.bChoking) then
		CTLStatsText:SetTextColor(1,0.2,0.2);
	else	
		CTLStatsText:SetTextColor(0.9,0.9,1);
	end
	
end);