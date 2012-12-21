--[[
	DeuceCommander
		"A graphical interface for my Ace2 mods' /commands!? EGAD!"

    By Neronix of Hellscream EU
--]]

DeuceCommander = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")

DeuceCommander.hasIcon = "Interface\\Icons\\INV_Gizmo_07"
DeuceCommander.defaultPosition = "RIGHT"

local console = AceLibrary("AceConsole-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local tablet = AceLibrary("Tablet-2.0")

--localization need to translate for non-us client
local CATEGORIES = {
	["Action Bars"] = "Action Bars",
	["Auction"] = "Auction",
	["Audio"] = "Audio",
	["Battlegrounds/PvP"] = "Battlegrounds/PvP",
	["Buffs"] = "Buffs",
	["Chat/Communication"] = "Chat/Communication",
	["Druid"] = "Druid",
	["Hunter"] = "Hunter",
	["Mage"] = "Mage",
	["Paladin"] = "Paladin",
	["Priest"] = "Priest",
	["Rogue"] = "Rogue",
	["Shaman"] = "Shaman",
	["Warlock"] = "Warlock",
	["Warrior"] = "Warrior",
	["Healer"] = "Healer",
	["Tank"] = "Tank",
	["Caster"] = "Caster",
	["Combat"] = "Combat",
	["Compilations"] = "Compilations",
	["Data Export"] = "Data Export",
	["Development Tools"] = "Development Tools",
	["Guild"] = "Guild",
	["Frame Modification"] = "Frame Modification",
	["Interface Enhancements"] = "Interface Enhancements",
	["Inventory"] = "Inventory",
	["Library"] = "Library",
	["Map"] = "Map",
	["Mail"] = "Mail",
	["Miscellaneous"] = "Miscellaneous",
	["Quest"] = "Quest",
	["Raid"] = "Raid",
	["Tradeskill"] = "Tradeskill",
	["UnitFrame"] = "UnitFrame",
}
local DC_HINT = "Right-click me to get started!"
local DC_NODESC = "No Description Provided"

if GetLocale() == "zhCN" then
	CATEGORIES = {
		["Action Bars"] = "动作条",
		["Auction"] = "拍卖",
		["Audio"] = "声音",
		["Battlegrounds/PvP"] = "战场/PvP",
		["Buffs"] = "增益法术",
		["Chat/Communication"] = "聊天/交流",
		["Druid"] = "德鲁伊",
		["Hunter"] = "猎人",
		["Mage"] = "法师",
		["Paladin"] = "圣骑士",
		["Priest"] = "牧师",
		["Rogue"] = "盗贼",
		["Shaman"] = "萨满祭司",
		["Warlock"] = "术士",
		["Warrior"] = "战士",
		["Healer"] = "治疗者",
		["Tank"] = "坦克",
		["Caster"] = "施法者",
		["Combat"] = "战斗",
		["Compilations"] = "整合",
		["Data Export"] = "数据导出",
		["Development Tools"] = "开发工具",
		["Guild"] = "公会",
		["Frame Modification"] = "框体修改",
		["Interface Enhancements"] = "界面加强",
		["Inventory"] = "背包",
		["Library"] = "运行库",
		["Map"] = "地图",
		["Mail"] = "邮件",
		["Miscellaneous"] = "杂项",
		["Quest"] = "任务",
		["Raid"] = "团队",
		["Tradeskill"] = "商业技能",
		["UnitFrame"] = "人物框体",
	}
	DC_HINT = "右键点击显示菜单!"
	DC_NODESC = "没有提供描述"
elseif GetLocale() == "koKR" then
	CATEGORIES = {
		["Action Bars"] = "액션바",
		["Auction"] = "경매",
		["Audio"] = "음향",
		["Battlegrounds/PvP"] = "전장/PvP",
		["Buffs"] = "버프",
		["Chat/Communication"] = "대화/의사소통",
		["Druid"] = "드루이드",
		["Hunter"] = "사냥꾼",
		["Mage"] = "마법사",
		["Paladin"] = "성기사",
		["Priest"] = "사제",
		["Rogue"] = "도적",
		["Shaman"] = "주술사",
		["Warlock"] = "흑마법사",
		["Warrior"] = "전사",
		["Healer"] = "힐러",
		["Tank"] = "탱커",
		["Caster"] = "캐스터",
		["Combat"] = "전투",
		["Compilations"] = "복합",
		["Data Export"] = "자료 출력",
		["Development Tools"] = "개발 도구",
		["Guild"] = "길드",
		["Frame Modification"] = "구조 변경",
		["Interface Enhancements"] = "인터페이스 강화",
		["Inventory"] = "인벤토리",
		["Library"] = "라이브러리",
		["Map"] = "지도",
		["Mail"] = "우편",
		["Miscellaneous"] = "기타",
		["Quest"] = "퀘스트",
		["Raid"] = "공격대",
		["Tradeskill"] = "전문기술",
		["UnitFrame"] = "유닛 프레임",
	}
	DC_HINT = "우클릭시 설정창을 엽니다!"
end

DeuceCommander:RegisterDB("DeuceCommanderDB")

function DeuceCommander:OnInitialize()
	self:RegisterChatCommand({"/deucecommander", "/deucecomm"})

	-- Create the root of our AceOptions table, ready for addons' tables to be inserted
	self.theTable = { type = "group", args = {} }
end

function DeuceCommander:OnEnable()
	self:Construct()

	function self:OnMenuRequest(level, value)
		dewdrop:FeedAceOptionsTable(self.theTable)
		if level == 1 then dewdrop:AddLine() end
	end

	-- When another addon's loaded, :Construct again to check if the new addon's got a slash command to be added. It's run 2 seconds after ADDON_LOADED to ensure that its slash command is definitely registered
	self:RegisterEvent("ADDON_LOADED", function() self:ScheduleEvent(self.Construct, 2, self) end)
end

function DeuceCommander:OnTooltipUpdate()
	tablet:SetHint(DC_HINT)
end

function DeuceCommander:Construct()
	for k,v in pairs(console.registry) do -- v will be the current slash command being dealt with. k is almost always 8 randomly generated characters (Why, ckknight!?)

		-- Explanation of the following logic: If there's no handler and name attached to it, it's probably not a command we should deal with
		-- In a slash command we want to deal with, .handler is a link to the addon object that the command belongs to
		-- And if the entry for the mod's already there, no need to do it again
		if type(v) == "table" and v.handler and v.handler.name and not self.theTable.args[v.handler.name] then

			local addonName = v.handler.name
			local category = GetAddOnMetadata(addonName, "X-Category") or "Miscellaneous"
			category = self:stripSpaces(category)
			if not CATEGORIES[category] then
				category = CATEGORIES["Miscellaneous"]
			else
				category = CATEGORIES[category]
			end
			-- remove space, because of a Dewdrop limitation
			category = gsub(category, " ", "_")

			if not self.theTable.args[category] then
				self.theTable.args[category] = {
					name = category,
					desc = string.format("AddOns in category %s.", category),
					type = "group",
					args = {}
				}
			end
			local cattbl = self.theTable.args[category]

			-- remove space, because of a Dewdrop limitation
			addonName = gsub(addonName, " ", "_")

			if (not v.name) or (v.name == "") then
				v.name = addonName
			end

			if (not v.desc) or (v.desc == "") then
				if (not v.handler.notes) or (v.handler.notes == "") then
					v.desc = DC_NODESC
				else
					v.desc = v.handler.notes
				end
			end

			cattbl.args[addonName] = v -- Stick the mod's table in the root group
		end
	end
end

function DeuceCommander:stripSpaces(text)
	if type(text) == "string" then
		return (string.gsub(string.gsub(text, "^%s*(.-)%s*$", "%1"), "%s%s+", " "))
	end
	return text
end