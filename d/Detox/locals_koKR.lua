-- Translated by Gamefaq

local L = AceLibrary("AceLocale-2.0"):new("Detox")

L:RegisterTranslations("koKR", function() return {

	-- menu/options
	["Clean group"] = "디버프 해제",
	["Will attempt to clean a player in your raid/party."] = "공격대/파티의 디버프 해제를 시도할 것입니다.",
	["Play sound if unit needs decursing"] = "디버프 해제의 필요함을 소리로 알림",
	["Show detoxing in scrolling combat frame"] = "전투창으로 해제하는 것을 표시",
	["This will use SCT5 when available, otherwise Blizzards Floating Combat Text."] = "선택 시 SCT5 를 사용할 것입니다, 다른 방법은 블리자드 전투 텍스트 표시로 알립니다.",
	["Seconds to blacklist"] = "블랙리스트 표시 시간",
	["Units that are out of Line of Sight will be blacklisted for the set duration."] = "정해진 존속기간동안 유니트는 블랙리스트에 얼려질 것입니다.",
	["Max debuffs shown"] = "최대 디버프 표시",
	["Defines the max number of debuffs to display in the live list."] = "리스트에 기록을 위하여 디버프의 최대 번호를 규정합니다.",
	["Update speed"] = "업데이트 속도",
	["Defines the speed the live list is updated, in seconds."] = "리스트의 업데이트 속도를 초단위로 규정합니다.",
	["Detaches the live list from the Detox icon."] = "디톡스 아이콘으로 부터 라이브 리스트를 분리합니다.",
	["Show live list"] = "라이브 목록 표시",
	["Options for the live list."] = "라이브 목록에 관한 옵션.",
	["Live list"] = "라이브 리스트",

	-- Filtering
	["Filter"] = "필터(무시)",
	["Options for filtering various debuffs and conditions."] = "필터의 여러가지 디버프와 조건에 관한 옵션",
	["Debuff"] = "디버프",
	["Filter by debuff and class."] = "디버프와 직업에 의한 필터",
	["Classes to filter for: %s."] = "직업 필터: %s.",
	["Toggle filtering %s on %s."] = "토글 필터 %s 직업 %s.",
	["Adds a new debuff to the class submenus."] = "직업 보조메뉴에 디버프를 더합니다.",
	["Add"] = "추가",
	["Removes a debuff from the class submenus."] = "직업 보조메뉴에서 디버프를 삭제합니다.",
	["Remove %s from the class submenus."] = "%s 직업 보조메뉴로 부터 삭제합니다.",
	["Remove"] = "삭제",
	["<debuff name>"] = "<디버프명>",
	["Filter stealthed units"] = "은신 상태의 플레이어 무시",
	["It is recommended not to cure stealthed units."] = "은신 상태의 플레이어를 치료하지 않습니다.",
	["Filter Abolished units"] = "무효 상태의 플레이어 무시",
	["Skip units that have an active Abolish buff."] = "해제 가능한 버프를 가진 플레이어를 무시합니다.",
	["Filter pets"] = "소환수 무시",
	["Pets are also your friends."] = "자신과 파티/공대원의 소환수를 무시합니다.",
	["Filter by type"] = "종류별 무시",
	["Only show debuffs you can cure."] = "자신이 치료할 수 있는 디버프만 표시합니다.",
	["Filter by range"] = "거리별 무시",
	["Only show units in range."] = "치료할수 있는 거리내의 디버프만 표시합니다.",

	-- Priority list
	["Priority"] = "우선 순위",
	["These units will be priorized when curing."] = "해당 플레이어를 우선적으로 치료합니다.",
	["Show priorities"] = "우선 순위 표시",
	["Displays who is prioritized in the live list."] = "누가 우선적 치료 대상인지 라이브 목록에 표시합니다.",
	["Priorities"] = "우선 해제 대상",
	["Can't add/remove current target to priority list, it doesn't exist."] = "우선권 목록에 현재 대상을 추가하거나 옮길 수 없습니다, 대상이 존재하지 않습니다.",
	["Can't add/remove current target to priority list, it's not in your raid."] = "우선권 목록에 현재 대상을 추가하거나 옮길 수 없습니다, 자신의 공격대에 없습니다.",
	["%s was added to the priority list."] = "%s|1이;가; 우선권 목록에 추가 되었습니다.",
	["%s has been removed from the priority list."] = "%s|1이;가; 우선권 목록으로 부터 삭제 되었습니다.",
	["Nothing"] = "없음",
	["Prioritize %s."] = "%s|1을;를; 우선 해제 합니다.",
	["Every %s"] = "모든 %s",
	["Prioritize every %s."] = "모든 %s|1을;를; 우선 해제 합니다.",
	["Groups"] = "파티",
	["Prioritize by group."] = "파티별 우선.",
	["Group %s"] = "파티 %s",
	["Prioritize group %s."] = "%s 파티를 우선 해제 합니다.",
	["Class %s"] = "직업 %s",

	-- bindings
	["Clean group"] = "디버프 해제",
	["Toggle target priority"] = "대상 우선순위 전환",
	["Toggle target class priority"] = "대상 직업 우선순위 전환",
	["Toggle target group priority"] = "대상 파티 우선순위 전환",

	-- spells and potions
	["Dreamless Sleep"] = "숙면",
	["Greater Dreamless Sleep"] = "상급 숙면",
	["Ancient Hysteria"] = "고대의 격분",
	["Ignite Mana"] = "마나 점화",
	["Tainted Mind"] = "부패한 정신",
	["Magma Shackles"] = "용암 족쇄",
	["Cripple"] = "신경 마비",
	["Frost Trap Aura"] = "냉기의 덫",
	["Dust Cloud"] = "먼지 구름",
--	["Widow's Embrace"] = "Widow's Embrace", -- CHECK
	["Curse of Tongues"] = "언어의 저주",

	["Magic"] = "마법",
	["Charm"] = "현혹",
	["Curse"] = "저주",
	["Poison"] = "독",
	["Disease"] = "질병",
	
	["Cleaned %s"] = "%s|1을;를; 치료합니다.",
	
	["Rank (%d+)"] = "(%d+) 레벨"

} end)
