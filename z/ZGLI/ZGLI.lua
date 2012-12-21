local Orig_ChatFrame_OnHyperlinkClick;

function ZGLOnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
end

function ZGLOnEvent()
	if event == "VARIABLES_LOADED" then
		Orig_ChatFrame_OnHyperlinkClick = ChatFrame1:GetScript("OnHyperlinkClick");
		ChatFrame1:SetScript("OnHyperlinkClick", ZGLUpdate);
		for i = 2, 10 do
			if (getglobal("ChatFrame"..i)) then
				local cf = getglobal("ChatFrame"..i);
				cf:SetScript("OnHyperlinkClick", ZGLUpdate);
			end			
		end
		DEFAULT_CHAT_FRAME:AddMessage("ZGLoot geladen", 1.0, 0.0, 0.0);
	end	
end

function ZGLUpdate()
	Orig_ChatFrame_OnHyperlinkClick();
	zglootitem = ItemRefTooltipTextLeft1:GetText();
	zglootwidth = 0;
	if (ZGL[zglootitem]) then
		for i = 1, 10 do
			local zglootlayer = getglobal("ZGLootInfoPanelText"..i);
			zglootlayer:Hide();
		end
		zglootlines = getn(ZGL[zglootitem]);
		for i = 1, zglootlines do
			zglootline = getglobal("ZGLootInfoPanelText"..i);
			zglootline:SetText(ZGL[zglootitem][i][1]);
			zglootline:SetTextColor(ZGL[zglootitem][i][2].r, ZGL[zglootitem][i][2].g, ZGL[zglootitem][i][2].b);	--zglicolor[r], zglicolor[g], zglicolor[b]);
			zglootline:Show();
			if (zglootwidth < zglootline:GetStringWidth()) then
				zglootwidth = zglootline:GetStringWidth()
			end
		end
		ZGLootInfoPanel:SetHeight(14 * zglootlines + 18);
		ZGLootInfoPanel:SetWidth(zglootwidth +20);
		ZGLootInfoPanel:Show();

	elseif (ZGLootInfoPanel:IsShown()) then
		ZGLootInfoPanel:Hide();
	end
end