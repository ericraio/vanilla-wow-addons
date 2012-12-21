
assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRALReady")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["ready"] = true,
	["readyleader"] = true,
	["Options for ready checks and votes."] = true,
	["sound"] = true,
	["Sound"] = true,
	["Toggle an audio warning upon a ready check or vote."] = true,
	["Ready"] = true,
	["Not Ready"] = true,
	["Are you Ready?"] = true,
	["Yes"] = true,
	["No"] = true,
	["Ready Check"] = true,
	["check"] = true,
	["Perform a ready check."] = true,
	["Close"] = true,
	["<CTRaid> %s has performed a ready check."] = true,
	["AFK: "] = true,
	["Not Ready: "] = true,
	["Yes: %d No: %d AFK: %d"] = true,
	["Vote Results for: "] = true,
	["<CTRaid> %s has performed a vote: %s"] = true,
	["Vote"] = true,
	["vote"] = true,
	["Perform a vote."] = true,
	["<vote>"] = true,
	["Leader/Ready"] = true,
} end)

L:RegisterTranslations("koKR", function() return {

	["Options for ready checks and votes."] = "준비확인과 투표 설정",
	["Sound"] = "소리",
	["Toggle an audio warning upon a ready check or vote."] = "준비확인시와 투표시에 경고음 재생 기능을 토글합니다.",
	["Ready"] = "준비완료",
	["Not Ready"] = "준비안됨",
	["Are you Ready?"] = "준비 되셨습니까?",
	["Yes"] = "예",
	["No"] = "아니오",
	["Ready Check"] = "준비 확인",
	["Perform a ready check."] = "준비 상태를 확인 합니다.",
	["Close"] = "닫기",
	["<CTRaid> %s has performed a ready check."] = "<공격대 도우미> %s님이 준비 상태를 확인합니다.",
	["AFK: "] = "자리비움: ",
	["Not Ready: "] = "준비안됨: ",
	["Yes: %d No: %d AFK: %d"] = "예: %d 아니오: %d 자리비움: %d",
	["Vote Results for: "] = "투표 결과: ",
	["<CTRaid> %s has performed a vote: %s"] = "<공격대 도우미> %s님이 투표를 실시합니다.: %s",
	["Vote"] = "투표",
	["Perform a vote."] = "투표를 실시합니다.",
	["<vote>"] = "투표",
	["Leader/Ready"] = "공격대장/준비확인",
} end)

L:RegisterTranslations("zhCN", function() return {
	["ready"] = "就位确认",
	["readyleader"] = "就位确认与投票助手",
	["Options for ready checks and votes."] = "就位确认与投票设置",
	["sound"] = "声音",
	["Sound"] = "声音",
	["Toggle an audio warning upon a ready check or vote."] = "就位确认与投票时播放音效",
	["Ready"] = "就位确认",
	["Not Ready"] = "未准备好",
	["Are you Ready?"] = "准备好了么？",
	["Yes"] = "是",
	["No"] = "否",
	["Ready Check"] = "就位确认",
	["check"] = "检查",
	["Perform a ready check."] = "进行检查",
	["Close"] = "关闭",
	["<CTRaid> %s has performed a ready check."] = "<CTRaid>%s正在进行就位检查",
	["AFK: "] = "暂离: ",
	["Not Ready: "] = "未就绪",
	["Yes: %d No: %d AFK: %d"] = "是：%d 否：%d 暂离：%d",
	["Vote Results for: "] = "投票结果：",
	["<CTRaid> %s has performed a vote: %s"] = "<CTRaid>%s开始一场投票：%s",
	["Vote"] = "投票",
	["vote"] = "投票",
	["Perform a vote."] = "进行投票",
	["<vote>"] = "<vote>",
	["Leader/Ready"] = "Leader/Ready",
} end)

L:RegisterTranslations("zhTW", function() return {
	["ready"] = "就位確認",
	["readyleader"] = "readyleader",
	["Options for ready checks and votes."] = "就位確認與投票選項",
	["sound"] = "聲音",
	["Sound"] = "聲音",
	["Toggle an audio warning upon a ready check or vote."] = "就位確認與投票時播放音效",
	["Ready"] = "已就緒",
	["Not Ready"] = "未就緒",
	["Are you Ready?"] = "準備好了嗎？",
	["Yes"] = "是",
	["No"] = "否",
	["Ready Check"] = "就位確認",
	["check"] = "檢查",
	["Perform a ready check."] = "進行就位確認",
	["Close"] = "關閉",
	["<CTRaid> %s has performed a ready check."] = "<CTRaid>%s正在進行就位確認",
	["AFK: "] = "暫離: ",
	["Not Ready: "] = "未就緒",
	["Yes: %d No: %d AFK: %d"] = "是：%d 否：%d 暫離：%d",
	["Vote Results for: "] = "投票結果：",
	["<CTRaid> %s has performed a vote: %s"] = "<CTRaid>%s開始一場投票：%s",
	["Vote"] = "投票",
	["vote"] = "投票",
	["Perform a vote."] = "進行投票",
	["<vote>"] = "<投票>",
	["Leader/Ready"] = "領隊/就位確認",
} end)

L:RegisterTranslations("frFR", function() return {
	--["ready"] = true,
	--["readyleader"] = true,
	["Options for ready checks and votes."] = "Options concernant les appels et les votes.",
	--["sound"] = true,
	["Sound"] = "Son",
	["Toggle an audio warning upon a ready check or vote."] = "Joue ou non un avertissement sonore lors d'un appel ou d'un vote.",
	["Ready"] = "Pr\195\170t",
	["Not Ready"] = "Pas pr\195\170t",
	["Are you Ready?"] = "\195\138tes-vous pr\195\170t ?",
	["Yes"] = "Oui",
	["No"] = "Non",
	["Ready Check"] = "Appel",
	--["check"] = true,
	["Perform a ready check."] = "Effectue l'appel.",
	["Close"] = "Fermer",
	["<CTRaid> %s has performed a ready check."] = "<CTRaid> %s a commenc\195\169 l'appel.",
	["AFK: "] = "ABS : ",
	["Not Ready: "] = "Pas pr\195\170t : ",
	["Yes: %d No: %d AFK: %d"] = "Oui : %d Non : %d ABS : %d",
	["Vote Results for: "] = "R\195\169sultat du vote pour : ",
	["<CTRaid> %s has performed a vote: %s"] = "<CTRaid> %s a lanc\195\169 un vote: %s",
	--["Vote"] = true,
	--["vote"] = true,
	["Perform a vote."] = "Soumet un vote au raid.",
	--["<vote>"] = true,
	["Leader/Ready"] = "Chef/Appel",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

oRALReady = oRA:NewModule(L["readyleader"])
oRALReady.defaults = {
	sound = true,
}
oRALReady.leader = true
oRALReady.name = L["Leader/Ready"]
oRALReady.consoleCmd = L["ready"]
oRALReady.consoleOptions = {
	type = "group",
	desc = L["Options for ready checks and votes."],
	name = L["Ready"],
	args = {
		[L["check"]] = {
			name = L["Ready Check"], type = "execute",
			desc = L["Perform a ready check."],
			func = function()
				oRALReady:PerformReadyCheck()
			end,
			disabled = function() return not oRA:IsModuleActive(oRALReady) or not oRALReady:IsValidRequest() end,
		},
		[L["vote"]] = {
			name = L["Vote"], type = "text",
			desc = L["Perform a vote."],
			usage = L["<vote>"],
			get = false,
			set = function(v)
				oRALReady:PerformVote(v)
			end,
			validate = function(v)
				return string.find(v, "^(.+)$")
			end,
			disabled = function() return not oRA:IsModuleActive(oRALReady) or not oRALReady:IsValidRequest() end,
		}
	}
}

------------------------------
--      Initialization      --
------------------------------

function oRALReady:OnEnable()
	self.votes = {}
	self.ready = {}

	self:RegisterCheck("READY", "oRA_Ready")
	self:RegisterCheck("NOTREADY", "oRA_NotReady")
	self:RegisterCheck("VOTEYES", "oRA_VoteYes")
	self:RegisterCheck("VOTENO", "oRA_VoteNo")

	self:RegisterShorthand("raready", function() self:PerformReadyCheck() end )
	self:RegisterShorthand("rar", function() self:PerformReadyCheck() end )
	self:RegisterShorthand("ravote", function(vote) self:PerformVote(vote) end )

	self:SetupFrames()	
end

function oRALReady:OnDisable()

	self:UnregisterAllEvents()

	self:UnregisterCheck("READY")
	self:UnregisterCheck("NOTREADY")
	self:UnregisterCheck("VOTEYES")
	self:UnregisterCheck("VOTENO")

	self:UnregisterShorthand("raready")
	self:UnregisterShorthand("rar")
	self:UnregisterShorthand("ravote")

	self.ready = {}
	self.votes = {}
	
end

-------------------------
--   Command Handlers  --
-------------------------

function oRALReady:PerformReadyCheck()
	if not self:IsPromoted() then return end
	self.ready = {}
	for i = 1, GetNumRaidMembers(), 1 do
		local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i)
		if online then self.ready[name] = "no reply" end		
	end
	
	name = UnitName("player")
	self.ready[name] = "ready"

	self.frames.rheader:SetText(L["Ready Check"])
	self.frames.leftinfo:SetText("")
	self.frames.rightinfo:SetText("")

	self.frames.closebuttontext:SetText(L["Close"])

	self.frames.closebutton:SetScript("OnClick",
		function()
			this.owner:ReportReadyStatus()
			this.owner.frames.report:Hide()
		end )
 
	self.frames.report:Show()
	self:UpdateReport(self.ready, "ready", "not ready")

	SendChatMessage(string.format( L["<CTRaid> %s has performed a ready check."], name), "RAID")
	self:SendMessage("CHECKREADY")	
end

function oRALReady:PerformVote( question )
	if not self:IsPromoted() then return end
	if not question or question == "" then return end
	
	self.question = question
	self.votes = {}
	
	for i = 1, GetNumRaidMembers(), 1 do
		local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i)
		if online and name ~= UnitName("player") then self.votes[name] = "no reply" end
	end

	self.frames.rheader:SetText(L["Vote"])
	self.frames.leftinfo:SetText("")
	self.frames.rightinfo:SetText("")

	self.frames.closebuttontext:SetText(L["Close"])

	self.frames.closebutton:SetScript("OnClick",
		function()
			this.owner:ReportVoteStatus()
			this.owner.frames.report:Hide()
		end )

	self.frames.report:Show()
	self:UpdateReport(self.votes, "yes", "no")
	SendChatMessage(string.format( L["<CTRaid> %s has performed a vote: %s"], UnitName("player"), question), "RAID")
	self:SendMessage("VOTE "..question)
end

-------------------------
--   Event Handlers    --
-------------------------

function oRALReady:oRA_Ready(msg, author)
	if not self:IsPromoted() then return end
	self.ready[author] = "ready"
	self:UpdateReport(self.ready, "ready", "not ready")
end

function oRALReady:oRA_NotReady(msg, author)
	if not self:IsPromoted() then return end
	self.ready[author] = "not ready"
	self:UpdateReport(self.ready, "ready", "not ready")
end

function oRALReady:oRA_VoteYes(msg, author)
	if not self:IsPromoted() then return end
	self.votes[author] = "yes"
	self:UpdateReport(self.votes, "yes", "no")	
end

function oRALReady:oRA_VoteNo(msg, author)
	if not self:IsPromoted() then return end
	self.votes[author] = "no"
	self:UpdateReport(self.votes, "yes", "no")
end

--------------------------
--     Core function    --
--------------------------

function oRALReady:ReportReadyStatus()
	local noreply, notready = "", ""
	for name, ready in pairs(self.ready) do
		if ready == "no reply" then noreply = noreply..name.." "
		elseif ready == "not ready" then notready = notready..name.." "
		end
	end
	if noreply ~= "" then self:Print(L["AFK: "]..noreply) end
	if notready ~= "" then self:Print(L["Not Ready: "]..notready) end
end

function oRALReady:ReportVoteStatus()
	local noreply, yes, no = 0,0,0
	for name, vote in pairs(self.votes) do
		if vote == "no reply" then noreply = noreply + 1
		elseif vote == "no" then no = no + 1
		else yes = yes + 1
		end
	end
	SendChatMessage( L["Vote Results for: "]..self.question, "RAID")
	SendChatMessage( string.format(L["Yes: %d No: %d AFK: %d"], yes, no, noreply), "RAID")
end


------------------------------------
--     Frame Setup and Handling   --
------------------------------------


function oRALReady:UpdateReport(t, green, red)
	local text = ""
	local i = 0
	for name, state in pairs(t) do
		i = i + 1
		if i == 21 then text = "" end
		
		if state == "no reply" then
			text = text .. "|c00CCCCCC" .. name .. "|r\n"		
		elseif state == red then
			text = text .. "|c00FF0000" .. name .. "|r\n"
		else
			text = text .. "|c0000FF00" .. name .. "|r\n"
		end
		
		if i <= 20 then self.frames.leftinfo:SetText(text)
		else self.frames.rightinfo:SetText(text) end
	end               
end


function oRALReady:SetupFrames()
	local f, t	

	f, _, _ = GameFontNormal:GetFont()

	self.frames = {}

	self.frames.report = CreateFrame("Frame", nil, UIParent)
	self.frames.report:Hide()
	self.frames.report:SetWidth(325)
	self.frames.report:SetHeight(325)
	self.frames.report:EnableMouse(true)
	self.frames.report:SetMovable(true)
	self.frames.report:RegisterForDrag("LeftButton")
	self.frames.report:SetScript("OnDragStart", function() this:StartMoving() end)
	self.frames.report:SetScript("OnDragStop", function() this:StopMovingOrSizing() end)
	self.frames.report:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 16,
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
		insets = {left = 4, right = 4, top = 4, bottom = 4},
		})
	self.frames.report:SetBackdropBorderColor(.5, .5, .5)
	self.frames.report:SetBackdropColor(0,0,0)
	self.frames.report:ClearAllPoints()
	self.frames.report:SetPoint("CENTER", WorldFrame, "CENTER", 0, 0)

	self.frames.rfade = self.frames.report:CreateTexture(nil, "BORDER")
	self.frames.rfade:SetWidth(319)
	self.frames.rfade:SetHeight(25)
	self.frames.rfade:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	self.frames.rfade:SetPoint("TOP", self.frames.report, "TOP", 0, -4)
	self.frames.rfade:SetBlendMode("ADD")
	self.frames.rfade:SetGradientAlpha("VERTICAL", .1, .1, .1, 0, .25, .25, .25, 1)
	self.frames.report.Fade = self.frames.fade

	self.frames.rheader = self.frames.report:CreateFontString(nil,"OVERLAY")
	self.frames.rheader:SetFont(f, 14)
	self.frames.rheader:SetWidth(300)
	self.frames.rheader:SetText("header")
	self.frames.rheader:SetTextColor(1, .8, 0)
	self.frames.rheader:ClearAllPoints()
	self.frames.rheader:SetPoint("TOP", self.frames.report, "TOP", 0, -10)
	
	self.frames.leftinfo = self.frames.report:CreateFontString(nil,"OVERLAY")
	self.frames.leftinfo:SetFont(f, 12)
	self.frames.leftinfo:SetWidth(175)
	self.frames.leftinfo:SetHeight(300)
	self.frames.leftinfo:SetJustifyV("TOP")
	self.frames.leftinfo:SetText("leftinfo")
	self.frames.leftinfo:ClearAllPoints()
	self.frames.leftinfo:SetPoint("TOPLEFT", self.frames.report, "TOPLEFT", 0, -30)

	self.frames.rightinfo = self.frames.report:CreateFontString(nil,"OVERLAY")
	self.frames.rightinfo:SetFont(f, 12)
	self.frames.rightinfo:SetWidth(175)
	self.frames.rightinfo:SetHeight(300)
	self.frames.rightinfo:SetJustifyV("TOP")
	self.frames.rightinfo:SetText("rightinfo")
	self.frames.rightinfo:ClearAllPoints()
	self.frames.rightinfo:SetPoint("TOPRIGHT", self.frames.report, "TOPRIGHT", 0, -30)

	self.frames.closebutton = CreateFrame("Button", nil, self.frames.report)
	self.frames.closebutton.owner = self
	self.frames.closebutton:SetWidth(125)
	self.frames.closebutton:SetHeight(32)
	self.frames.closebutton:SetPoint("BOTTOM", self.frames.report, "BOTTOM", 0, 10)
	
	t = self.frames.closebutton:CreateTexture()
	t:SetWidth(125)
	t:SetHeight(32)
	t:SetPoint("CENTER", self.frames.closebutton, "CENTER")
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Up")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	self.frames.closebutton:SetNormalTexture(t)

	t = self.frames.closebutton:CreateTexture(nil, "BACKGROUND")
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Down")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	t:SetAllPoints(self.frames.closebutton)
	self.frames.closebutton:SetPushedTexture(t)
	
	t = self.frames.closebutton:CreateTexture()
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Highlight")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	t:SetAllPoints(self.frames.closebutton)
	t:SetBlendMode("ADD")
	self.frames.closebutton:SetHighlightTexture(t)
	self.frames.closebuttontext = self.frames.closebutton:CreateFontString(nil,"OVERLAY")
	self.frames.closebuttontext:SetFontObject(GameFontHighlight)
	self.frames.closebuttontext:SetText("left")
	self.frames.closebuttontext:SetAllPoints(self.frames.closebutton)
end
