--[[
-- Traditional  Chinese localization file copyright
-- This file free for everyone who want use this AddOn with zhTW WoW, EXCEPT meidoku.
-- Please just keep my name on it is ok. XD
--
-- 正體中文語系檔版權
-- 本中文語系檔無償授權予所有人, 唯獨不授權給予 meidoku 使用.
-- 請留著我的小名就好. XD
--
-- 伝統的な中国のローカライズファイル著作権
-- meidokuを除いて、欲しい皆にとっての、無料のこのファイルは中国語 WoWとこのAddOnを使用します。
-- ただ私の名前を保ってください。それに、OKがあります。 XD
--
-- KLHThreatMeter Traditional Chinese localization file
-- Maintained by: Kuraki, Suzuna
-- Last updated: 06/25/2006
-- Revision History:
--    06/25/2006  * Update to R16 Test 6
--    06/27/2006  * Update some translation.
--                * Add R16.12 Release support.
--                * Keep check for the "hic!".
--    07/11/2006  * Update to R16.15
--    08/05/2006  * Update to R17 Test 7
--    08/08/2006  * Update to R17.7 RC
--    08/09/2006  * Fixed bug, comment out Fel Stamina
--    08/19/2006  * Update to R17.10 test
--
--]]

klhtm.string.data["zhTW"] =
{
	["binding"] =
	{
		hideshow = "隱藏 / 顯示視窗",
		stop = "緊急停止",
		mastertarget = "設定 / 清除主要目標",
		resetraid = "重置團隊仇恨",
	},
	["spell"] =
	{
		["heroicstrike"] = "英勇打擊",
		["maul"] = "搥擊",
		["swipe"] = "揮擊",
		["shieldslam"] = "盾牌猛擊",
		["revenge"] = "復仇",
		["shieldbash"] = "盾擊",
		["sunder"] = "破甲攻擊",
		["feint"] = "佯攻",
		["cower"] = "畏縮",
		["taunt"] = "嘲諷",
		["growl"] = "低吼",
		["vanish"] = "消失",
		["frostbolt"] = "寒冰箭",
		["fireball"] = "火球術",
		["arcanemissiles"] = "祕法飛彈",
		["scorch"] = "灼燒",
		["cleave"] = "順劈斬",

		-- Items / Buffs:
		["arcaneshroud"] = "秘法環繞",
		["reducethreat"] = "降低威脅",

		-- Leeches: no threat from heal
		["holynova"] = "神聖新星", -- no heal or damage threat
		["siphonlife"] = "生命虹吸", -- no heal threat
		["drainlife"] = "吸取生命", -- no heal threat
		["deathcoil"] = "死亡纏繞",

		-- Fel Stamina and Fel Energy DO cause threat! GRRRRRRR!!!
		--["felstamina"] = "惡魔耐力",
		--["felenergy"] = "惡魔能量",

		["bloodsiphon"] = "血液虹吸", -- poisoned blood vs Hakkar

		["lifetap"] = "生命分流", -- no mana gain threat
		["holyshield"] = "神聖之盾", -- multiplier
		["tranquility"] = "寧靜",
		["distractingshot"] = "擾亂射擊",
		["earthshock"] = "地震術",
		["rockbiter"] = "石化",
		["fade"] = "漸隱術",
		["thunderfury"] = "雷霆之怒",

		-- Spell Sets
		-- warlock descruction
		["shadowbolt"] = "暗影箭",
		["immolate"] = "獻祭",
		["conflagrate"] = "燃燒",
		["searingpain"] = "灼熱之痛", -- 2 threat per damage
		["rainoffire"] = "火焰之雨",
		["soulfire"] = "靈魂之火",
		["shadowburn"] = "暗影灼燒",
		["hellfire"] = "地獄烈焰",

		-- mage offensive arcane
		["arcaneexplosion"] = "魔爆術",
		["counterspell"] = "法術法制",

		-- priest shadow. No longer used (R17).
		["mindblast"] = "心靈震爆",
		--[[
		["mindflay"] = "精神鞭笞",
		["devouringplague"] = "吸血鬼的擁抱",
		["shadowwordpain"] = "暗言術：痛",
		,
		["manaburn"] = "法力燃燒",
		]]
	},
	["power"] =
	{
		["mana"] = "法力",
		["rage"] = "怒氣",
		["energy"] = "能量",
	},
	["threatsource"] = -- these values are for user printout only
	{
		["powergain"] = "能源產生",
		["total"] = "總計",
		["special"] = "特殊",
		["healing"] = "治療",
		["dot"] = "持續傷害",
		["threatwipe"] = "仇恨減免",
		["damageshield"] = "傷害盾",
		["whitedamage"] = "白字傷害",
	},
	["talent"] = -- these values are for user printout only
	{
		["defiance"] = "挑釁",
		["impale"] = "穿刺",
		["silentresolve"] = "無聲消退",
		["frostchanneling"] = "冰霜導能",
		["burningsoul"] = "燃燒之魂",
		["healinggrace"] = "治療之賜",
		["shadowaffinity"] = "精神治療",
		["druidsubtlety"] = "微妙",
		["feralinstinct"] = " 野性本能",
		["ferocity"] = "兇暴",
		["savagefury"] = "野蠻暴怒",
		["tranquility"] = "強化寧靜",
		["masterdemonologist"] = "惡魔學識大師",
		["arcanesubtlety"] = "祕法精妙",
		["righteousfury"] = "強化憤怒聖印",
	},
	["threatmod"] = -- these values are for user printout only
	{
		["tranquilair"] = "寧靜之風圖騰",
		["salvation"] = "拯救祝福",
		["battlestance"] = "戰鬥姿態",
		["defensivestance"] = "防禦姿態",
		["berserkerstance"] = "狂暴姿態",
		["defiance"] = "挑釁",
		["basevalue"] = "基本值",
		["bearform"] = "熊型態",
		["glovethreatenchant"] = "手套附魔增加威脅值",
		["backthreatenchant"] = "披風附魔減少威脅值",
	},

	["sets"] =
	{
		["bloodfang"] = "血牙",    -- Rog, 5件 增加佯攻減少的威脅值 25%
		["nemesis"] = "復仇",      -- Wlk, 8件 降低毀滅系法術所產生的威脅值 20%
		["netherwind"] = "靈風",   -- Mag, 3件 使你的灼燒(-100)、祕法飛彈(每發-20)、火球術(-100)和寒冰箭(-100)所造成的威脅值降低
		["might"] = "力量",        -- War, 8件 增加破甲產生的威脅值 15%
		["arcanist"] = "祕法師",   -- Mag, 8件 使你因攻擊而產生的威脅值減少15%
	},
	["boss"] =
	{
		["speech"] =
		{
			["razorphase2"] = "在寶珠的控制力消失之前逃走。",
			["onyxiaphase3"] = "看起來需要再給你一次教訓",
			["thekalphase2"] = "給我憤怒的力量吧",
			["rajaxxfinal"] = "厚顏無恥的笨蛋！我要親手殺了你！",
			["azuregosport"] = "來吧，小子。面對我！",
			["nefphase2"] = "燃燒吧！你這個不幸的人！燃燒吧！",
		},
		-- Some of these are unused. Also, if none is defined in your localisation, they won't be used,
		-- so don't worry if you don't implement it.
		["name"] =
		{
			["rajaxx"] = "拉賈克斯將軍",
			["onyxia"] = "奧妮克希亞",
			["ebonroc"] = "埃博諾克",
			["razorgore"] = "狂野的拉佐格爾",
			["thekal"] = "古拉巴什食腐者",
			["shazzrah"] = "沙斯拉爾",
			["twinempcaster"] = "維克洛爾大帝",
			["twinempmelee"] = "維克尼拉斯大帝",
			["noth"] = "瘟疫者諾斯",
		},
		["spell"] =
		{
			["shazzrahgate"] = "沙斯拉爾之門", -- "Shazzrah casts Gate of Shazzrah."
			["wrathofragnaros"] = "拉格納羅斯之怒", -- "Ragnaros's Wrath of Ragnaros hits you for 100 Fire damage."
			["timelapse"] = "時間流逝", -- "You are afflicted by Time Lapse."
			["knockaway"] = "擊飛",
			["wingbuffet"] = "龍翼打擊",
			["burningadrenaline"] = "燃燒刺激",
			["twinteleport"] = "雙子傳送",
			["nothblink"] = "閃現術",
			["sandblast"] = "沙塵爆裂",
		}
	},
	["misc"] =
	{
		["imp"] = "小鬼", -- UnitCreatureFamily("pet")
		["spellrank"] = "等級 (%d+)", -- second value of GetSpellName(x, "spell")
		["aggrogain"] = "取得 Aggro",
	},

	-- labels and tooltips for the main window
	["gui"] = {
		["raid"] = {
			["head"] = {
				-- column headers for the raid view
				["name"] = "名稱",
				["threat"] = "仇恨",
				["pc"] = "%Max",			-- your threat as a percentage of the #1 player's threat
			},
			["stringshort"] = {
				-- tooltip titles for the bottom bar strings
				["tdef"] = "仇恨餘額", -- the difference in threat between you and the MT / #1 in the list.
				["targ"] = "主要目標",
			},
			["stringlong"] = {
				-- tooltip descriptions for the bottom bar strings
				["tdef"] = "",
				["targ"] = "整個團隊中, 只有針對 %s 產生的仇恨值會被計算."
			},
		},
		["self"] = {
			["head"] = {
				-- column headers for the self view
				["name"] = "名稱",
				["hits"] = "命中",
				["rage"] = "怒氣",
				["dam"] = "傷害",
				["threat"] = "仇恨",
				["pc"] = "%T",
			},
			-- text on the self threat reset button
			["reset"] = "重置",
		},
		["title"] = {
			["text"] = {
				-- the window titles
				["long"] = "KTM %d.%d",	-- don't need to localise these
				["short"] = "KTM",

			},
			["buttonshort"] = {
				-- the tooltip titles for command buttons
				["close"] = "關閉",
				["min"] = "最小化",
				["max"] = "最大化",
				["self"] = "檢視自我",
				["raid"] = "檢視團隊",
				["pin"] = "鎖定",
				["unpin"] = "解鎖",
				["opt"] = "選項",
				["targ"] = "主要目標",
				["clear"] = "重置",
			},
			["buttonlong"] = {
				-- the tooltip descriptions for command buttons
				["close"] = "只要你還待在隊伍或是團隊中, 仇恨資料仍然會被送出",
				["min"] = "",
				["max"] = "",
				["self"] = "顯示個人仇恨詳細資料",
				["raid"] = "顯示團隊仇恨資料",
				["pin"] = "防止仇恨計量視窗被移動",
				["unpin"] = "允許仇恨計量視窗被移動",
				["opt"] = "",
				["targ"] = "將主要目標設為你現在的目標. 如果你現在沒有目標, 主要目標將被清除. 你必須是團隊助理或是領隊.",
				["clear"] = "將所有玩家的仇恨清空為 0. 你必須是團隊助理或是領隊.",
			},
			["stringshort"] = {
				-- the tooltip titles for titlebar strings
				["threat"] = "仇恨",
				["tdef"] = "仇恨差距",
				["rank"] = "仇恨排名",
				["pc"] = "% 仇恨",
			},
			["stringlong"] = {
				-- the tooltip descriptions for titlebar strings
				["threat"] = "自重設起, 你的個人仇恨值總計",
				["tdef"] = "你和目標的仇恨差數值",
				["rank"] = "你在仇恨列表中的排名",
				["pc"] = "對目標來說, 你的仇恨佔的百分比",
			},
		},
	},
	-- labels and tooltips for the options gui
	["optionsgui"] = {
		["buttons"] = {
			-- the options gui command button labels
			["gen"] = "一般",
			["raid"] = "團隊",
			["self"] = "自己",
			["close"] = "關閉",
		},
		-- the labels for option checkboxes and headers
		["labels"] = {
			-- the title description for each option page
			["titlebar"] = {
				["gen"] = "一般選項",
				["raid"] = "團隊選項",
				["self"] = "個人選項",
			},
			["buttons"] = {
				-- the names of title bar command buttons
				["pin"] = "鎖定",
				["opt"] = "選項",
				["view"] = "檢視變更",
				["targ"] = "主要目標",
				["clear"] = "重置團隊仇恨",
			},
			["columns"] = {
				-- names of columns on the self and raid views
				["hits"] = "命中",
				["rage"] = "怒氣",
				["dam"] = "傷害",
				["threat"] = "仇恨",
				["pc"] = "% 仇恨",
			},
			["options"] = {
				-- miscelaneous option names
				["hide"] = "隱藏無仇恨人員",
				["abbreviate"] = "簡略很大的數值",
				["resize"] = "改變視窗大小",
				["aggro"] = "顯示取得 Aggro",
				["rows"] = "最大可見列",
				["scale"] = "對話框縮放",
				["bottom"] = "隱藏底列",
			},
			["minvis"] = {
				-- the names of minimised strings
				["threat"] = "最小仇恨", -- dodge...
				["rank"] = "仇恨排行",
				["pc"] = "% 仇恨",
				["tdef"] = "仇恨赤字",
			},
			["headers"] = {
				-- headers in the options gui
				["columns"] = "可見的行數",
				["strings"] = "最小化字串顯示",
				["other"] = "其他選項",
				["minvis"] = "最小化按鈕",
				["maxvis"] = "最大化按鈕",
			},
		},
		-- the tooltips for some of the options
		["tooltips"] = {
			-- miscelaneous option descriptions
			["raidhide"] = "如果選取, 沒有仇恨的玩家將不會被顯示在 threat meter 上.",
			["selfhide"] = "不選取此選項將顯示所有的仇恨來源.",
			["abbreviate"] = "如果選取, 大於一萬的數值將會被縮短並加上 'k'. 例如 '15400' 將會變成 '15.4k'.",
			["resize"] = "如果選取, 可見行將會自動縮減以符合實際回報仇恨值得玩家數目.",
			["aggro"] = "如果選取, 增加一個阻隔行顯示預估取得的仇恨值. 當設置主目標時, 這個預估值會更加精準.",
			["rows"] = "最多有多少人會出現在團隊仇恨視窗列表中.",
			["bottom"] = "選取此選項, 底部狀態列將被隱藏. 它顯示你的仇恨差距以及主要目標.",
		},
	},
	["print"] =
	{
		["main"] =
		{
			["startupmessage"] = "KLHThreatMeter Release |cff33ff33%s|r Revision |cff33ff33%s|r 已載入. 輸入 |cffffff00/ktm|r 以取得幫助.",
		},
		["data"] =
		{
			["abilityrank"] = "你的 %s 技能的排名為 %s.",
			["globalthreat"] = "你的整體仇恨倍率為 %s.",
			["globalthreatmod"] = "%s 給予你 %s.",
			["multiplier"] = "作為一個%s, 你的%s仇恨倍率為%s.",
			["damage"] = "傷害",
			["shadowspell"] = "暗影法術",
			["arcanespell"] = "祕法法術",
			["holyspell"] = "神聖法術",
			["setactive"] = "是否正穿著 %s 套裝 %d 件? ... %s.",
			["true"] = "是",
			["false"] = "否",
			["healing"] = "你的治療產生了 %s 仇恨 (在經過整體仇恨修正之前).",
			["talentpoint"] = "你有 %d 點天賦點數在 %s.",
			["talent"] = "發現 %d 點 %s 天賦.",
			["rockbiter"] = "你的等級 %d 石化增加了 %d 點仇恨成功的進行了肉搏戰.",
		},

		-- new in R17.7
		["boss"] = 
		{
			["automt"] = "主要目標已經自動被設定為 %s.",
			["spellsetmob"] = "%$1s 變更了 %$3s 的 %$4s 技能 %$2s 參數設定值, 從 %$6s 變更為 %$5s.", -- "Kenco sets the multiplier parameter of Onyxia's Knock Away ability to 0.7"
			["spellsetall"] = "%$1s 變更了 %$3s 技能的 %$2s 參數設定值, 從 %$5s 變更為 %$4s.",
			["reportmiss"] = "%s 回報 %s 的 %s 未擊中他.",
			["reporttick"] = "%s 回報 %s 的 %s 擊中了他. 他已經受傷害 %s 回, 並且將會受 %s 影響更多的時間.",
			["reportproc"] = "%s 回報 %s 的 %s 改變了他的仇恨值, 從 %s 到 %s.",
			["bosstargetchange"] = "%s 改變了目標, 從 %s (%s 仇恨) 到 %s (%s 仇恨).",
			["autotargetstart"] = "當你下一次選取了一個世界首領, 你將會自動清除主要目標並將他設定為新的主要目標.",
			["autotargetabort"] = "主要目標已經被設定為世界首領 %s.",
		},

		["network"] =
		{
			["newmttargetnil"] = "無法確認主要目標 %s, 因為 %s 沒有目標.",
			["newmttargetmismatch"] = "%s 設定主要目標為 %s, 但是他的目標是 %s. 將使用他的目標替代, 並確認這一點!!",
			["mtpollwarning"] = "已經更新你的主要目標為 %s, 但是無法確認. 如果這個是不正確的, 請 %s 重新廣播一次主要目標.",
			["threatreset"] = "團隊仇恨測量器已被 %s 清除.",
			["newmt"] = "主要目標已更改為 '%s', 由 %s 變更.",
			["mtclear"] = "主要目標已被 %s 清除.",
			["knockbackstart"] = "擊飛偵測在已被 %s 啟用.",
			["knockbackstop"] = "擊飛偵測在已被 %s 停用.",
			["aggrogain"] = "%s 回報, 在產生了 %d 仇恨後取得 aggro.",
			["aggroloss"] = "%s 回報, %d 仇恨失去了 aggro.",
			["knockback"] = "%s 回報受到傷害被擊飛. 他的仇恨值下降到 %d.",
			["knockbackstring"] = "%s 回報這個踢飛的文字: '%s'.",
			["upgraderequest"] = "%s 促使你更新 KLHThreatMeter 到版本 Release %d. 你現在正使用 Release %d.",
			["remoteoldversion"] = "%s 正在使用過期的 KLHThreatMeter Release %d. 請告訴他該更新到 Release %d 了.",
			["knockbackvaluechange"] = "|cffffff00%s|r 設定 %s 的 |cffffff00%s|r 攻擊仇恨減少至 |cffffff00%d%%|r.",
			["raidpermission"] = "你必須是領隊或是隊長才能夠這樣作!",
			["needmastertarget"] = "你必須先設定一個主要目標!",
			["knockbackinactive"] = "擊飛偵測在本團隊中被關閉.",
			["versionrequest"] = "正在向團隊查詢版本資訊, 將在 3 秒內回應.",
			["versionrecent"] = "這些人使用 release %s: { ",
			["versionold"] = "這些人使用舊的版本: { ",
			["versionnone"] = "這些人沒有使用 KLHThreatMeter, 或是他們沒有在正確的 CTRA 頻道: { ",
			["channel"] =
			{
				ctra = "CTRA 頻道",
				ora = "oRA 頻道",
				manual = "手動覆寫",
			},
			needtarget = "請先標記一個怪物並設定成為主要目標.",
			upgradenote = "使用這個插件較舊版本的用戶端已經被通知需要升級.",
			advertisestart = "你現在會偶然地告訴搶到 aggro 的人去下載 KLHThreatMeter.",
			advertisestop = "你已經停止為 KLHThreatMeter 作宣傳了.",
			advertisemessage = "如果你有 KLHThreatMeter, 你就不會失去控制搶到 %s 的 aggro.",
		}
	}
}
