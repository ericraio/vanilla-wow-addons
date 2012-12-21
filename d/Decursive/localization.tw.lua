--[[
 Decursive (v 1.9.7) add-on for World of Warcraft UI
 Copyright (C) 2005 Archarodim ( http://www.2072productions.com/?to=decursive-continued.txt )
 This is the continued work of the original Decursive (v1.9.4) by Quu
 Decursive 1.9.4 is in public domain ( www.quutar.com )
 
 License:
	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
 
	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

 Transform:
	This is an unofficial translation of the GNU General Public License
	into language. It was not published by the Free Software Foundation,
	and does not legally state the distribution terms for software that
	uses the GNU GPL--only the original English text of the GNU GPL does
	that. However, we hope that this translation will help language
	speakers understand the GNU GPL better.(By DDX)

 Tip:
	『腐蝕耐力』、『淹沒』技能發動後會持續性產生作用，沒有解除價值，故忽略。
	『點燃法力』對戰士與盜賊並無影響，故忽略。
	『音爆』對盜賊並無影響，故忽略。
--]]


----------------------------------------------------------------------------------
-- Chinese localization (Default)  By srshyu@seed.net.tw and snowwolf@seed.net.tw
----------------------------------------------------------------------------------
if ( GetLocale() == "zhTW" ) then
--start added in Rc4
DCR_ALLIANCE_NAME = '聯盟';

DCR_LOC_CLASS_DRUID   = '德魯伊';
DCR_LOC_CLASS_HUNTER  = '獵人';
DCR_LOC_CLASS_MAGE    = '法師';
DCR_LOC_CLASS_PALADIN = '聖騎士';
DCR_LOC_CLASS_PRIEST  = '牧師';
DCR_LOC_CLASS_ROGUE   = '盜賊';
DCR_LOC_CLASS_SHAMAN  = '薩滿';
DCR_LOC_CLASS_WARLOCK = '術士';
DCR_LOC_CLASS_WARRIOR = '戰士';

DCR_STR_OTHER	    = '其它';
DCR_STR_ANCHOR	    = '錨點';
DCR_STR_OPTIONS	    = '選項';
DCR_STR_CLOSE	    = '關閉';
DCR_STR_DCR_PRIO    = 'Decursive 優先選單';
DCR_STR_DCR_SKIP    = 'Decursive 忽略選單';
DCR_STR_QUICK_POP   = '快速添加介面';
DCR_STR_POP	    = '快速添加清單';
DCR_STR_GROUP	    = '隊伍';

DCR_STR_NOMANA	    = '法力不足！';
DCR_STR_UNUSABLE    = '無法解除！';
DCR_STR_NEED_CURE_ACTION_IN_BARS = 'Decursive 無法在您的動作條中找到解除法術，Decursive 必須使用其檢查魔法與範圍的監測。';


DCR_UP		    = '上';
DCR_DOWN	    = '下';

DCR_PRIORITY_SHOW   = 'P';
DCR_POPULATE	    = 'P';
DCR_SKIP_SHOW	    = 'S';
DCR_ANCHOR_SHOW	    = 'A';
DCR_OPTION_SHOW	    = 'O';
DCR_CLEAR_PRIO	    = 'C';
DCR_CLEAR_SKIP	    = 'C';


--end added in Rc4

DCR_DISEASE = '疾病';
DCR_MAGIC   = '魔法';
DCR_POISON  = '中毒';
DCR_CURSE   = '詛咒';
DCR_CHARMED = '媚惑';

DCR_PET_FELHUNTER = "地獄獵犬";
DCR_PET_DOOMGUARD = "末日守衛";
DCR_PET_FEL_CAST  = "吞噬魔法";
DCR_PET_DOOM_CAST = "驅散魔法";

DCR_SPELL_CURE_DISEASE        = '祛病術';
DCR_SPELL_ABOLISH_DISEASE     = '驅除疾病';
DCR_SPELL_PURIFY              = '純淨術';
DCR_SPELL_CLEANSE             = '清潔術';
DCR_SPELL_DISPELL_MAGIC       = '驅散魔法';
DCR_SPELL_CURE_POISON         = '消毒術';
DCR_SPELL_ABOLISH_POISON      = '驅毒術';
DCR_SPELL_REMOVE_LESSER_CURSE = '解除次級詛咒';
DCR_SPELL_REMOVE_CURSE        = '解除詛咒';
DCR_SPELL_PURGE               = '淨化術';
DCR_SPELL_NO_RANK             = '';
DCR_SPELL_RANK_1              = '等級 1';
DCR_SPELL_RANK_2              = '等級 2';

BINDING_HEADER_DECURSIVE   = "一鍵除魔";
BINDING_CATEGORY_DECURSIVE = "戰鬥相關";
BINDING_NAME_DCRCLEAN   = "設定淨化隊伍快捷鍵";
BINDING_NAME_DCRSHOW    = "顯示/隱藏Decursive";

BINDING_NAME_DCRPRADD	= "添加目標至優先列表";
BINDING_NAME_DCRPRCLEAR	= "清空優先列表";
BINDING_NAME_DCRPRLIST	= "顯示優先表至聊天視窗";
BINDING_NAME_DCRPRSHOW	= "隱藏優先列表介面";

BINDING_NAME_DCRSKADD   = "添加目標至忽略列表";
BINDING_NAME_DCRSKCLEAR = "清空忽略列表";
BINDING_NAME_DCRSKLIST  = "顯示忽略表至聊天視窗";
BINDING_NAME_DCRSKSHOW  = "隱藏忽略列表介面";

DCR_PRIORITY_LIST  = "Decursive 優先列表";
DCR_SKIP_LIST_STR  = "Decursive 忽略列表";
DCR_SKIP_OPT_STR   = "Decursive 選項";
DCR_POPULATE_LIST  = "Decursive 列表快速添加介面";
DCR_RREMOVE_ID     = "移除此玩家";
DCR_HIDE_MAIN      = "隱藏 Decursive";
DCR_RESHOW_MSG     = "Decursive 已隱藏，輸入 /dcrshow 再次開啟。";
DCR_IS_HERE_MSG	   = "Decursive 已啟用，請核對選項設定";

DCR_PRINT_CHATFRAME = "在聊天視窗顯示訊息";
DCR_PRINT_CUSTOM    = "在畫面中顯示訊息";
DCR_PRINT_ERRORS    = "顯示錯誤訊息";
DCR_AMOUNT_AFFLIC   = "在即時列表中顯示人數:";
DCR_BLACK_LENGTH    = "失敗幾次後加入黑名單:";
DCR_SCAN_LENGTH     = "即時檢測時間間隔(秒):";
DCR_ABOLISH_CHECK   = "施法前檢查是否需要 Debuff";
DCR_BEST_SPELL      = "用最高等級技能進行 Debuff";
DCR_RANDOM_ORDER    = "隨機淨化玩家";
DCR_CURE_PETS       = "檢測並淨化寵物";
DCR_IGNORE_STEALTH  = "忽略潛行的玩家";
DCR_PLAY_SOUND	    = "當有可解除法術時播放音效";
DCR_ANCHOR          = "Decursive 顯示預覽";
DCR_CHECK_RANGE     = "檢測範圍";
DCR_DONOT_BL_PRIO   = "Don't blacklist priority list names";


-- $s is spell name
-- $a is affliction name/type
-- $t is target name
DCR_DISPELL_ENEMY    = "對敵人施展 '$s' !";
DCR_NOT_CLEANED      = "沒有任何效果被驅除";
DCR_CLEAN_STRING     = "對 $t 施展 $s 清除 $a";
DCR_SPELL_FOUND      = "找到 $s 魔法!";
DCR_NO_SPELLS        = "找不到可 DeBuff 的魔法!";
DCR_NO_SPELLS_RDY    = "法術尚未就緒!";
DCR_OUT_OF_RANGE     = "$t 超出施法距離!";
DCR_IGNORE_STRING    = "忽略 $t 身上的 $a 效果...";

DCR_INVISIBLE_LIST = {
	["潛伏"]     = true,
	["潛行"]     = true,
	["影遁"]     = true,
}

-- this causes the target to be ignored!!!!
DCR_IGNORELIST = {
	["放逐術"]   = true,
	["相位變換"] = true,
};

-- ignore this effect
DCR_SKIP_LIST = {
	["昏睡"]     = true,
	["強效昏睡"] = true,
	["心靈視界"] = true,
	["腐蝕耐力"] = true,
	["淹沒"]     = true,
};

-- ignore the effect bassed on the class
DCR_SKIP_BY_CLASS_LIST = {
    [DCR_CLASS_WARRIOR] = {
		["上古狂亂"]   = true,
		["點燃法力"]   = true,
		["污濁之魂"]   = true,
		["法力燃燒"]   = true,
    };
    [DCR_CLASS_ROGUE] = {
		["沉默"]       = true,
		["上古狂亂"]   = true,
		["點燃法力"]   = true,
		["污濁之魂"]   = true,
		["法力燃燒"]   = true,
		["音爆"]       = true,
    };
    [DCR_CLASS_HUNTER] = {
		["熔岩鐐銬"]   = true,
    };
    [DCR_CLASS_MAGE] = {
		["熔岩鐐銬"]   = true,
    };
};
    -- for cut and paste ease
    -- DCR_CLASS_DRUID
    -- DCR_CLASS_HUNTER
    -- DCR_CLASS_MAGE
    -- DCR_CLASS_PALADIN
    -- DCR_CLASS_PRIEST
    -- DCR_CLASS_ROGUE
    -- DCR_CLASS_SHAMAN
    -- DCR_CLASS_WARLOCK
    -- DCR_CLASS_WARRIOR
    --  }}}

end
