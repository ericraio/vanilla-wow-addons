assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRALInvite")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["inviteleader"] = true,
	["invite"] = true,
	["Invite"] = true,
	["Leader/Invite"] = true,
	["<oRA> Sorry, the group is full."] = true,
	["Inviting: "] = true,
	["^([^%s]+) has joined the raid group"] = true,
	["Autopromoting: "] = true,
	["Keyword inviting disabled."] = true,
	["Invitation keyword set to: "] = true,
	["To turn off keyword inviting set it to 'off'."] = true,
	["<oRA> Raid disbanding on request by: "] = true,
	["Disabling Auto-Promote for: "] = true,
	["Enabling Auto-Promote for: "] = true,
	["Autopromoting: "] = true,
	["You have no-one in your Auto-Promote list"] = true,
	["Options for invite."] = true,
	["Autopromote"] = true,
	["autopromote"] = true,
	["Set/Unset an autopromotion."] = true,
	["<name>"] = true,
	["keyword"] = true,
	["Keyword"] = true,
	["Set/Unset an invitation keyword."] = true,
	["<keyword>"] = true,	
	["disband"] = true,
	["Disband"] = true,
	["Disband the raid."] = true,
	["list"] = true,
	["List"] = true,
	["List autopromotions."] = true,
	["guild"] = true,
	["Invite Guild"] = true,
	["Invite all level 60 characters in the guild to raid."] = true,
	["You are not in a guild."] = true,
	["You are not in a raid group."] = true,
	["All level 60 characters will be invited to raid in 10 seconds. Please leave your groups."] = true,
	["off"] = true,
} end )

L:RegisterTranslations("deDE", function() return {
	["<oRA> Sorry, the group is full."] = "<oRA> Sorry, die Gruppe ist voll",
	["Inviting: "] = "Einladen: ",
	["^([^%s]+) has joined the raid group"] = "^([^%s]+) hat sich der Schlachtgruppe angeschlossen",
	["Autopromoting: "] = "Autobef\195\182rderung: ",
	["Keyword inviting disabled."] = "Passwort Einladungen deaktiviert.",
	["Invitation keyword set to: "] = "Einladungs-Passwort gesetzt auf: ",
	["To turn off keyword inviting set it to 'off'."] = "Auf 'off' setzen um Passwort Einladungen zu deaktivieren",
	["<oRA> Raid disbanding on request by: "] = "<oRA> Schlachtzugsaufl\195\182sung angefordert von: ",
	["Disabling Auto-Promote for: "] = "Autobef\195\182rdung deaktiviert f\195\188r: ",
	["Enabling Auto-Promote for: "] = "Autobef\195\182rdung aktiviert f\195\188r: ",
	["Autopromoting: "] = "Autobef\195\182rdung: ",
	["You have no-one in your Auto-Promote list"] = "Ihr habt keinen in der Autobef\195\182rderungsliste",
	["Options for invite."] = "Einladungs Optionen",
	["Autopromote"] = "Autobef\195\182rdung",
	["Set/Unset an autopromotion."] = "Autobef\195\182rdung setzen/l\195\182schen",
	["Keyword"] = "Passwort",
	["Set/Unset an invitation keyword."] = "Einladungs-Passwort setzen/l\195\182schen",
	["Disband"] = "Aufl\195\182sen",
	["Disband the raid."] = "Schlachtzug aufl\195\182sen",
	["List"] = "Auflisten",
	["List autopromotions."] = "Autobef\195\182rderungen auflisten",
	["Invite Guild"] = "Gilde einladen",
	["Invite all level 60 characters in the guild to raid."] = "Alle level 60 Charaktere in der Gilde in den Schlachtzug einladen.",
	["You are not in a guild."] = "Ihr seid nicht in einer Gilde.",
	["You are not in a raid group."] = "Ihr seid nicht in einer Schlachtzugs Gruppe.",
	["All level 60 characters will be invited to raid in 10 seconds. Please leave your groups."] = "Alle Charakter der Stufe 60 werde in 10 Sekunden eingeladen. Bitte verlasst eure Gruppen.",
} end )

L:RegisterTranslations("koKR", function() return {

	["Invite"] = "초대",
	["Leader/Invite"] = "공격대장/초대",
	["<oRA> Sorry, the group is full."] = "<oRA> 죄송합니다. 공격대의 정원이 찼습니다",
	["Inviting: "] = "초대",
	["^([^%s]+) has joined the raid group"] = "^(.+)님이 공격대에 합류했습니다",
	["Autopromoting: "] = "자동승급",
	["Keyword inviting disabled."] = "키워드 초대 기능을 사용하지 않습니다",
	["Invitation keyword set to: "] = "초대 키워드 설정",
	["To turn off keyword inviting set it to 'off'."] = "키워드를 '끔'으로 설정하면 키워드 초대 기능을 사용하지 않습니다.",
	["<oRA> Raid disbanding on request by: "] = "<oRA> 공격대 해산 요청: ",
	["Disabling Auto-Promote for: "] = "자동승급 사용안함: ",
	["Enabling Auto-Promote for: "] = "자동승급 사용: ",
	["Autopromoting: "] = "자동승급: ",
	["You have no-one in your Auto-Promote list"] = "자동승급 목록이 비어 있습니다",
	["Options for invite."] = "초대 설정",
	["Autopromote"] = "자동승급",
	["Set/Unset an autopromotion."] = "자동승급 대상을 설정/설정해지 합니다.",
	["<name>"] = "<이름>",
	["Keyword"] = "키워드",
	["Set/Unset an invitation keyword."] = "초대 키워드를 설정/설정해지 합니다.",
	["<keyword>"] = "<키워드>",	
	["Disband"] = "해산",
	["Disband the raid."] = "공격대를 해산합니다.",
	["List"] = "목록",
	["List autopromotions."] = "자동승급 목록을 출력합니다",
	["Invite Guild"] = "길드원 초대",
	["Invite all level 60 characters in the guild to raid."] = "길드의 60레벨 길드원을 모두 공격대에 초대합니다.",
	["You are not in a guild."] = "길드에 속해 있지 않습니다",
	["You are not in a raid group."] = "공격대에 속해 있지 않습니다",
	["All level 60 characters will be invited to raid in 10 seconds. Please leave your groups."] = "10초 동안 60레벨의 길드원을 공격대에 초대합니다. 파티에서 나와 주세요.",
	["off"] = "끔",
} end )

L:RegisterTranslations("zhCN", function() return {
	["inviteleader"] = "邀请助手",
	["invite"] = "邀请",
	["Invite"] = "邀请",
	["Leader/Invite"] = "Leader/Invite",
	["<oRA> Sorry, the group is full."] = "<oRA>抱歉，团队已满",
	["Inviting: "] = "邀请",
	["^([^%s]+) has joined the raid group"] = "^([^%s]+) 加入了队伍",
	["Autopromoting: "] = "自动提升",
	["Keyword inviting disabled."] = "禁止关键字邀请",
	["Invitation keyword set to: "] = "邀请关键字设置为",
	["To turn off keyword inviting set it to 'off'."] = "要关掉关键词邀请的话，选择'关'",
	["<oRA> Raid disbanding on request by: "] = "<oRA>解散团队请求：",
	["Disabling Auto-Promote for: "] = "禁止自动提升对：",
	["Enabling Auto-Promote for: "] = "允许自动提升对：",
	["Autopromoting: "] = "自动提升",
	["You have no-one in your Auto-Promote list"] = "你的自动提升列表为空",
	["Options for invite."] = "邀请助手选项",
	["Autopromote"] = "自动提升",
	["autopromote"] = "自动提升",
	["Set/Unset an autopromotion."] = "设定/取消自动提升",
	["<name>"] = "<名字>",
	["keyword"] = "关键字",
	["Keyword"] = "关键字",
	["Set/Unset an invitation keyword."] = "设定/取消邀请关键字",
	["<keyword>"] = "关键词",	
	["disband"] = "解散",
	["Disband"] = "解散",
	["Disband the raid."] = "解散团队",
	["list"] = "列表",
	["List"] = "列表",
	["List autopromotions."] = "自动提升列表",
	["guild"] = "公会",
	["Invite Guild"] = "公会邀请",
	["Invite all level 60 characters in the guild to raid."] = "邀请公会中所有的60级玩家",
	["You are not in a guild."] = "你不在一个公会中",
	["You are not in a raid group."] = "你不在一个团队中",
	["All level 60 characters will be invited to raid in 10 seconds. Please leave your groups."] = "所有60级人物都将在10秒后邀请到团队中。请离开你当前队伍。",
	["off"] = "关闭",
} end )

L:RegisterTranslations("zhTW", function() return {
	["inviteleader"] = "inviteleader",
	["invite"] = "邀請",
	["Invite"] = "邀請",
	["Leader/Invite"] = "領隊/邀請",
	["<oRA> Sorry, the group is full."] = "<oRA>抱歉，團隊已滿。",
	["Inviting: "] = "正邀請：",
	["^([^%s]+) has joined the raid group"] = "^([^%s]+) 已加入團隊",
	["Autopromoting: "] = "自動提升: ",
	["Keyword inviting disabled."] = "禁止關鍵字邀請",
	["Invitation keyword set to: "] = "邀請關鍵字設置為：",
	["To turn off keyword inviting set it to 'off'."] = "要關掉關鍵詞邀請的話，選擇'關閉'",
	["<oRA> Raid disbanding on request by: "] = "<oRA>解散團隊請求：",
	["Disabling Auto-Promote for: "] = "禁止自動提升對：",
	["Enabling Auto-Promote for: "] = "允許自動提升對：",
	["Autopromoting: "] = "自動提升：",
	["You have no-one in your Auto-Promote list"] = "你的自動提升列表為空",
	["Options for invite."] = "邀請助手選項",
	["Autopromote"] = "自動提升",
	["autopromote"] = "自動提升",
	["Set/Unset an autopromotion."] = "設定/取消自動提升",
	["<name>"] = "<名字>",
	["keyword"] = "關鍵字",
	["Keyword"] = "關鍵字",
	["Set/Unset an invitation keyword."] = "設定/取消邀請關鍵字",
	["<keyword>"] = "關鍵詞",	
	["disband"] = "解散",
	["Disband"] = "解散",
	["Disband the raid."] = "解散團隊",
	["list"] = "列表",
	["List"] = "列表",
	["List autopromotions."] = "自動提升列表",
	["guild"] = "公會",
	["Invite Guild"] = "公會邀請",
	["Invite all level 60 characters in the guild to raid."] = "邀請公會中所有的60級玩家",
	["You are not in a guild."] = "你不在一個公會中",
	["You are not in a raid group."] = "你不在一個團隊中",
	["All level 60 characters will be invited to raid in 10 seconds. Please leave your groups."] = "所有60級人物都將在10秒後邀請到團隊中。請離開你當前隊伍。",
	["off"] = "關閉",
} end )

L:RegisterTranslations("frFR", function() return {
	--["inviteleader"] = true,
	--["invite"] = true,
	["Invite"] = "Invitation",
	["Leader/Invite"] = "Chef/Invitation",
	["<oRA> Sorry, the group is full."] = "<oRA> D\195\169sol\195\169, le groupe est complet.",
	["Inviting: "] = "Invitation : ",
	["^([^%s]+) has joined the raid group"] = "^([^%s]+) a rejoint le groupe de raid",
	["Autopromoting: "] = "Promotion automatique : ",
	["Keyword inviting disabled."] = "Invitation par mot-cl\195\169 d\195\169sactiv\195\169e.",
	["Invitation keyword set to: "] = "Invitation par mot-cl\195\169 d\195\169finie à : ",
	["To turn off keyword inviting set it to 'off'."] = "Pour d\195\169sactiver l'invitation par mot-cl\195\169, d\195\169finissez-le \195\160 'off'.",
	["<oRA> Raid disbanding on request by: "] = "<oRA> Dissolution du raid \195\160 la demande de : ",
	["Disabling Auto-Promote for: "] = "Retrait de la promotion automatique pour : ",
	["Enabling Auto-Promote for: "] = "Ajout de la promotion automatique de : ",
	["You have no-one in your Auto-Promote list"] = "Vous n'avez personne dans votre liste des personnes promues automatiquement.",
	["Options for invite."] = "Options concernant les invitations.",
	["Autopromote"] = "Promotion automatique",
	["Set/Unset an autopromotion."] = "Ajoute/Enl\195\168ve une personne de la liste des personnes promues automatiquement.",
	["<name>"] = "<nom>",
	--["keyword"] = true,
	["Keyword"] = "Mot-cl\195\169",
	["Set/Unset an invitation keyword."] = "D\195\169termine/Enl\195\168ve le mot-cl\195\169 d'invitation.",
	["<keyword>"] = "<mot-cl\195\169>",
	--["disband"] = true,
	["Disband"] = "Dissoudre",
	["Disband the raid."] = "Dissous le raid.",
	--["list"] = true,
	["List"] = "Liste",
	["List autopromotions."] = "Affiche la liste des personnes promues automatiquement.",
	--["guild"] = true,
	["Invite Guild"] = "Inviter la guilde",
	["Invite all level 60 characters in the guild to raid."] = "Invite tous les personnages de niveau 60 de la guilde dans le raid.",
	["You are not in a guild."] = "Vous n'\195\170tes pas dans une guilde.",
	["You are not in a raid group."] = "Vous n'\195\170tes pas dans un groupe de raid.",
	["All level 60 characters will be invited to raid in 10 seconds. Please leave your groups."] = "Tous les personnages de niveau 60 seront invit\195\169s dans le raid dans 10 secondes. Veuillez quitter vos groupes.",
	--["off"] = true,
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

oRALInvite = oRA:NewModule(L["inviteleader"])
oRALInvite.defaults = {
}
oRALInvite.leader = true
oRALInvite.name = L["Leader/Invite"]
oRALInvite.shouldEnable = true -- Prevents the module from disabling when out of raids.
oRALInvite.consoleCmd = L["invite"]
oRALInvite.consoleOptions = {
	type = "group",
	desc = L["Options for invite."],
	name = L["Invite"],
	args = {
		[L["autopromote"]] = {
			name = L["Autopromote"], type = "text",
			desc = L["Set/Unset an autopromotion."],
			usage = L["<name>"],
			get = function() return "" end,
			set = function(v)
				oRALInvite:SetAutoPromote(v)
			end,
			get = false,
			validate = function(v)
				return string.find(v, "(.*)")
			end,
		},
		[L["list"]] = {
			name = L["List"], type = "execute",
			desc = L["List autopromotions."],
			func = function() oRALInvite:ShowPromoteList() end,
		},
		[L["disband"]] = {
			name = L["Disband"], type = "execute",
			desc = L["Disband the raid."],
			func = function() oRALInvite:DisbandRaid() end,
			disabled = function() return not oRALInvite:IsValidRequest() end,
		},
		[L["keyword"]] = {
			name = L["Keyword"], type = "text",
			desc = L["Set/Unset an invitation keyword."],
			usage = L["<keyword>"],
			get = function() return oRALInvite.db.profile.keyword or "" end,
			set = function(v)
				oRALInvite:SetKeyword(v)
			end,
			validate = function(v)
				return string.find(v, "(.*)")
			end,
			disabled = function() return not oRA:IsModuleActive(oRALInvite) end,
		},
		[L["guild"]] = {
			name = L["Invite Guild"], type = "execute",
			desc = L["Invite all level 60 characters in the guild to raid."],
			func = function() oRALInvite:InviteGuild() end,
		},
	}
}

------------------------------
--      Initialization      --
------------------------------

function oRALInvite:OnEnable()
	if not self.db.profile.promotes then self.db.profile.promotes = {} end

	self:RegisterEvent("CHAT_MSG_WHISPER")
	self:RegisterEvent("CHAT_MSG_SYSTEM")

	self:RegisterShorthand("rakw", function(k) self:SetKeyword(k) end)
	self:RegisterShorthand("rakeyword", function(k) self:SetKeyword(k) end)
	self:RegisterShorthand("radisband", function() self:DisbandRaid() end)
	self:RegisterShorthand("rainvite", function() self:InviteGuild() end)
end


function oRALInvite:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterShorthand("rakw")
	self:UnregisterShorthand("rakeyword")
	self:UnregisterShorthand("radisband")
	self:UnregisterShorthand("rainvite")
end

----------------------
--  Event Handlers  --
----------------------

function oRALInvite:CHAT_MSG_WHISPER( msg, author )
	if self.db.profile.keyword and strlower(msg) == strlower(self.db.profile.keyword) then
		if GetNumPartyMembers() == 4 and GetNumRaidMembers() == 0 then ConvertToRaid() end
		if GetNumRaidMembers() == 40 then
			SendChatMessage( L["<oRA> Sorry, the group is full."], "WHISPER", nil, author)
		else
			self:Print( L["Inviting: "] .. author )
			InviteByName(author)
		end
	end
end
	
function oRALInvite:CHAT_MSG_SYSTEM( msg )
	if UnitInRaid("player") and IsRaidLeader() then
		local _,_,name = string.find( msg, L["^([^%s]+) has joined the raid group"])
		if name then
			name = strlower(name)
			if self.db.profile.promotes[name] then
				self:Print( L["Autopromoting: "] .. name )
				self:ScheduleEvent( PromoteToAssistant, 2, name )
			end
		end
	end
end

----------------------
-- Command Handlers --
----------------------

function oRALInvite:InviteGuild()
	if not IsInGuild() then
		self:Print(L["You are not in a guild."])
		return
	end
	if GetNumRaidMembers() == 0 then
		self:Print(L["You are not in a raid group."])
		return
	end

	SendChatMessage(L["All level 60 characters will be invited to raid in 10 seconds. Please leave your groups."], "GUILD")
	self:ScheduleEvent(self.DoGuildInvites, 10, self)
end

function oRALInvite:DoGuildInvites()
	local offline = GetGuildRosterShowOffline()
	local selection = GetGuildRosterSelection()
	SetGuildRosterShowOffline(0)
	SetGuildRosterSelection(0)
	GetGuildRosterInfo(0)

	local numGuildMembers = GetNumGuildMembers()
	for i = 1, numGuildMembers, 1 do
		local name, _, _, level, _, _, _, _, online, status = GetGuildRosterInfo(i)
		if level == 60 and name ~= UnitName("player") and online then
			InviteByName(name)
		end
	end

	SetGuildRosterShowOffline(offline)
	SetGuildRosterSelection(selection)
end

function oRALInvite:SetKeyword( keyword ) 
	if keyword == nil or keyword == "" or strlower( keyword ) == L["off"] then
		self.db.profile.keyword = nil
		self:Print( L["Keyword inviting disabled."] )
	else
		self.db.profile.keyword = keyword
		self:Print( L["Invitation keyword set to: "] .. keyword )
		self:Print( L["To turn off keyword inviting set it to 'off'."])
	end
end


function oRALInvite:DisbandRaid()
	if not self:IsPromoted() then return end
	SendChatMessage( L["<oRA> Raid disbanding on request by: "] .. UnitName("player"), "RAID")
	for i = 1, GetNumRaidMembers(), 1 do
		local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i)
		if online and name ~= UnitName("player") then
			UninviteByName(name)
		end
	end
	self:SendMessage("DB")
	LeaveParty()
end

function oRALInvite:SetAutoPromote(pname)
	if( pname ~= nil and pname ~= "" ) then
		pname = strlower( pname )
		if( self.db.profile.promotes[pname] ) then
			self.db.profile.promotes[pname] = nil
			self:Print( L["Disabling Auto-Promote for: "] .. pname )
		else
			self.db.profile.promotes[pname] = 1
			self:Print( L["Enabling Auto-Promote for: "] .. pname )
			if( IsRaidLeader() ) then
				for i = 1, GetNumRaidMembers(), 1 do
					local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i)
					name = strlower(name)
					if( pname == name ) then
						self:Print( L["Autopromoting: "] .. name )
						PromoteToAssistant( name )
					end
				end
			end
		end
	end
end

function oRALInvite:ShowPromoteList()
	if(not self:IsEmpty(self.db.profile.promotes) ) then
		local i = 0
		local list = ""
		self:Print( L["Autopromoting: "] )
		for name, yesno in pairs(self.db.profile.promotes) do
			i = i + 1
			list = list .. name .. " "
			if( i == 5 ) then
				self:Print( list )
				i = 0
				list = ""
			end
		end
		if( list ~= "" ) then
			self:Print( list )	
		end
	else
		self:Print( L["You have no-one in your Auto-Promote list"] )
	end
end

-----------------------
-- Utility Functions --
-----------------------

function oRALInvite:IsEmpty( t ) 
	for _ in pairs(t) do 
		return false 
	end
	return true
end
