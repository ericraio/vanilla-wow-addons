--[[ Startup ]]--
local function addFrameToBar(frame, bar)
	frame:ClearAllPoints()
	frame:SetPoint("TOPLEFT", bar);
	frame:SetParent(bar);
	frame:SetAlpha(bar:GetAlpha());
	frame:SetFrameLevel(0);
end

BScript.AddStartupAction(function()
	--create the quest watcher bar
	local bar = BBar.Create("questwatch", "BQWatchBar", "BQWatchBarSets", nil, 1);
	if not bar:IsUserPlaced() then
		local x, y = QuestWatchFrame:GetLeft() / UIParent:GetScale(), QuestWatchFrame:GetTop() / UIParent:GetScale();
		bar:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y);
	end	
	bar:SetWidth(QuestWatchFrame:GetWidth());
	bar:SetHeight(QuestWatchFrame:GetHeight());
	addFrameToBar(QuestWatchFrame, bar);
	
	--create the quest timer bar
	bar = BBar.Create("questtimer", "BQTimerBar", "BQTimerBarSets", nil, 1);
	if not bar:IsUserPlaced() then
		local x, y = QuestTimerFrame:GetLeft() * UIParent:GetScale(), QuestTimerFrame:GetTop() * UIParent:GetScale();
		bar:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y);
	end
	bar:SetWidth(QuestTimerFrame:GetWidth());
	bar:SetHeight(QuestTimerFrame:GetHeight());
	addFrameToBar(QuestTimerFrame, bar);
end)

local oQuestWatch_Update = QuestWatch_Update;
QuestWatch_Update = function()
	oQuestWatch_Update();
	
	BQWatchBar:SetWidth(QuestWatchFrame:GetWidth());
	BQWatchBar:SetHeight(QuestWatchFrame:GetHeight());
end

local oQuestTimerFrame_Update = QuestTimerFrame_Update;
QuestTimerFrame_Update = function()
	oQuestTimerFrame_Update();
	
	BQTimerBar:SetWidth(QuestTimerFrame:GetWidth());
	BQTimerBar:SetHeight(QuestTimerFrame:GetHeight());
end