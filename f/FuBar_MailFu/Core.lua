
------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.0"):new("FuBar_Mail")
local Tablet = AceLibrary("Tablet-2.0")
local Dewdrop = AceLibrary("Dewdrop-2.0")

local pendmail, checked
local files = {
	iconnomail = "Interface\\AddOns\\FuBar_MailFu\\nomail.tga",
	iconnew = "Interface\\AddOns\\FuBar_MailFu\\newmail.tga",
	iconAH = "Interface\\AddOns\\FuBar_MailFu\\auction.tga",
	soundpath = "Interface\\AddOns\\FuBar_MailFu\\mail.wav",
}


----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["No mail"] = true,
	["New Mail"] = true,
	["AH Alert!"] = true,

	["New Mail Received (%d/%d)"] = true,

	ttnew = " new mail items",
	tttotal = " total mail items",

	OUTBID = "Outbid: ",
	WON = "Won: ",
	EXPIRED = "Expired: ",
	REMOVED = "Cancelled: ",
	SOLD = "Sold: ",

	minimap = true,
	["Default Minimap"] = true,
	["Show Blizzard's minimap icon"] = true,

	chat = true,
	["Chat Alert"] = true,
	["Print a chat message when mail is received"] = true,

	sound = true,
	["Use Sound"] = true,
	["Play a sound when mail is received"] = true,

	textformat = true,
	["Text Format"] = true,
	["Bar text formatting"] = true,
	both = true,
	number = true,
	text = true,
} end)


L:RegisterTranslations("frFR", function() return {
	["No mail"] = "Aucun courier",
	["New Mail"] = "Nouveau courier",
	["AH Alert!"] = "Alerte AH!",
} end)


L:RegisterTranslations("deDE", function() return {
	["No mail"] = "Keine Post ",
	["New Mail"] = "Neue Post ",
	["AH Alert!"] = "AH-Alarm! ",

	["New Mail Received (%d/%d)"] = "Neue Post erhalten (%d/%d)",

	ttnew = " neue Nachrichten",
	tttotal = " Nachrichten insgesamt",

	OUTBID = "\195\156berboten: ",
	WON = "Gewonnen: ",
	EXPIRED = "Abgelaufen: ",
	REMOVED = "Abgebrochen: ",
	SOLD = "Verkauft: ",

	["Chat Alert"] = "Chat-Alarm",
	["Use Sound"] = "Sound verwenden",
} end)


-------------------------------------
--      Namespace Declaration      --
-------------------------------------

FuBar_Mail = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0", "AceHook-2.0")
FuBar_Mail.hideWithoutStandby = true
FuBar_Mail.hasIcon = files.iconnomail
FuBar_Mail:RegisterDB("FuBar_MailDB", "FuBar_MailDBPC")
FuBar_Mail:RegisterDefaults("char", {new = 0, total = 0})
FuBar_Mail:RegisterDefaults("profile", {
	playsounds = true,
	showminimap = false,
	chatalerts = true,
	textformat = "both",
	showtext = true,
	showcount = true,
})
local opts = {type = "group", handler = FuBar_Mail, args = {
	[L.minimap] = {
		type = "toggle", name = L["Default Minimap"], desc = L["Show Blizzard's minimap icon"], order = 1,
		get = function() return FuBar_Mail.db.profile.showminimap end, set = function(v) FuBar_Mail.db.profile.showminimap = v end,
	},
	[L.sound] = {
		type = "toggle", name = L["Use Sound"], desc = L["Play a sound when mail is received"], order = 1,
		get = function() return FuBar_Mail.db.profile.playsounds end, set = function(v) FuBar_Mail.db.profile.playsounds = v end,
	},
	[L.chat] = {
		type = "toggle", name = L["Chat Alert"], desc = L["Print a chat message when mail is received"], order = 1,
		get = function() return FuBar_Mail.db.profile.chatalerts end, set = function(v) FuBar_Mail.db.profile.chatalerts = v end,
	},
	[L.textformat] = {
		type = "text",
		name = L["Text Format"],
		desc = L["Bar text formatting"],
		get = function() return FuBar_Mail.db.profile.textformat end,
		set = function(v) FuBar_Mail.db.profile.textformat = v; FuBar_Mail:Update() end,
		validate = {L["text"], L["number"], L["both"]},
		disabled = function() return not FuBar_Mail:IsTextShown() end,
	},

}}
FuBar_Mail:RegisterChatCommand({"/mailfu"}, opts)
FuBar_Mail.OnMenuRequest = opts


---------------------------
--      Ace Methods      --
---------------------------

function FuBar_Mail:OnEnable()
	pendmail = 0

	self:RegisterEvent("SpecialEvents_MailReceived")
	self:RegisterEvent("SpecialEvents_AHAlert")
	self:RegisterEvent("SpecialEvents_MailInit", "Update")
	self:RegisterEvent("AceEvent_FullyInitialized", "Update")

	self:RegisterEvent("MAIL_SHOW")
	self:RegisterEvent("MAIL_INBOX_UPDATE")
	self:Hook(MiniMapMailFrame, "Show", "MMMailShow")
	if not self.db.profile.showminimap and MiniMapMailFrame:IsVisible() then MiniMapMailFrame:Hide() end
end


function FuBar_Mail:MMMailShow(object)
	if self.db.profile.showminimap then return self.hooks[object].Show.orig(object) end
end


function FuBar_Mail:MAIL_SHOW()
	checked = true
	self.db.char.ahalerts = nil
	self:Update()
end


function FuBar_Mail:MAIL_INBOX_UPDATE()
	self.db.char.new = 0
	self.db.char.total = GetInboxNumItems()
	self:Update()
end


function FuBar_Mail:SpecialEvents_MailReceived()
	pendmail = pendmail + 1
	self.db.char.new, self.db.char.total = self.db.char.new + 1, self.db.char.total + 1
	if checked then self.db.char.total = GetInboxNumItems() + self.db.char.new end
	if self.db.profile.playsounds then PlaySoundFile(files.soundpath) end
	if self.db.profile.chatalerts then self:Print(L["New Mail Received (%d/%d)"], self.db.char.new, self.db.char.total) end

	self:Update()
end


function FuBar_Mail:SpecialEvents_AHAlert(ahtype, item)
	if not self.db.char.ahalerts then self.db.char.ahalerts = {} end
	table.insert(self.db.char.ahalerts, {L[ahtype], item})

	self:Update()
end


function FuBar_Mail:OnTextUpdate()
--	self.hasNoText = self:IsIconShown() and not self.db.profile.showtext and not self.db.profile.showcount
	local showt = self.db.profile.textformat == L.both or self.db.profile.textformat == L.text
	local showc = self.db.profile.textformat == L.both or self.db.profile.textformat == L.number
	local hasmail = self.db.char.ahalerts or self.db.char.total > 0 or (HasNewMail() and not checked)
	local numstr = (self.db.char.total > 0) and string.format(showt and "(%u/%u)" or "%u/%u", self.db.char.new, self.db.char.total) or showt and "(0)" or "0"
	local colorstr = self.db.char.ahalerts and "|cffff0000" or hasmail and "|cff00ff00" or ""
	local txtstr = self.db.char.ahalerts and L["AH Alert!"] or hasmail and L["New Mail"] or L["No mail"]

	self:SetText(colorstr.. (showt and txtstr or "").. (showt and showc and " " or "").. (showc and numstr or ""))
	self:SetIcon(self.db.char.ahalerts and files.iconAH or hasmail and files.iconnew or files.iconnomail)
end


function FuBar_Mail:OnTooltipUpdate()
	local hasmail = self.db.char.ahalerts or self.db.char.total > 0 or (HasNewMail() and not checked)
	local colorstr = self.db.char.ahalerts and "|cffff0000" or hasmail and "|cff00ff00" or ""
	local txtstr = self.db.char.ahalerts and L["AH Alert!"] or hasmail and L["New Mail"] or L["No mail"]

	Tablet:SetTitle(colorstr..txtstr)

	local cat = Tablet:AddCategory("columns", 2)
	cat:AddLine("text", "New", "text2", self.db.char.new or "No data", "textR", 0, "textG", 1, "textB", 0, "text2R", 0, "text2G", 1, "text2B", 0)
	cat:AddLine("text", "Total", "text2", self.db.char.total)
	if self.db.char.ahalerts then
		cat = Tablet:AddCategory("text", "Auction Alerts", "isTitle", true, "justify", "CENTER")
		cat = Tablet:AddCategory("hideBlankLine", true, "columns", 2, "child_textR", 1, "child_textG", 0, "child_textB", 0, "child_text2R", 1, "child_text2G", 0, "child_text2B", 0)
		for _,val in ipairs(self.db.char.ahalerts) do cat:AddLine("text", val[1], "text2", val[2]) end
	end
end


