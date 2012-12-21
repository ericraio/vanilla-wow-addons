------------------------------------------------------
-- localization.lua
------------------------------------------------------

FDP_ALWAYS_DIS_TO_FORMAT = "Always disenchants to %s.";
FDP_CAN_DIS_TO = "May disenchant to:";
FDP_CAN_DIS_TO_SHORT = "Disenchants:";

FDP_MOST_LIKELY = "(most likely)";		-- chance of getting dust from any green
FDP_JUST_LIKELY = "(likely)";			-- chance of getting essence from a green weapon
FDP_OCCASIONALLY = "(occasionally)";	-- chance of getting essence from any other green
FDP_RARELY = "(rarely)";				-- chance of getting a shard from any green

FDP_CAN_DIS_FROM_FORMAT = "Can disenchant from level %s items.";
FDP_SHARD_VERBOSE = "Always disenchants from |cff0070ddRare|r items, rarely from |cff1eff00Uncommon|r items.";
FDP_ESSENCE_VERBOSE = "Can disenchant from any |cff1eff00Uncommon|r item, more likely from weapons than from others.";
FDP_DUST_VERBOSE = "Frequently disenchants from any |cff1eff00Uncommon|r items.";
FDP_NEXUS_CAN_DIS_FROM_1 = "Always disenchants from level 51+ |cffa335eeEpic|r items.";
FDP_NEXUS_CAN_DIS_FROM_2 = "Sometimes disenchants from level 51+ |cff0070ddRare|r items.";

FDP_CANT_DIS_EXCEPTION_FORMAT = "%s can't be disenchanted.";
FDP_CANT_DIS_QUALITY_FORMAT = "%s most likely can't be disenchanted (only items of |cff1eff00Uncommon|r, |cff0070ddRare|r, or |cffa335eeEpic|r quality can).";
FDP_CANT_DIS_TYPE_FORMAT = "%s may not be disenchantable. (Generally, only equippable, non-stackable items are.)";

FDP_NOLEVEL_PURPLE_FORMAT = "%s has no level requirement. This is likely a quest reward item, and thus likely to disenchant as would an item whose required level is similar to that of the quest. Level 51+ epic items can disenchant to %s; others will produce shards appropriate to their level.";
FDP_NOLEVEL_BLUE_FORMAT = "%s has no level requirement; it will produce a shard when disenchanted, but I can't predict which kind. (This is likely a quest reward item, and thus likely to disenchant as would an item whose required level is similar to that of the quest.)";
FDP_NOLEVEL_GREEN_FORMAT = "%s has no level requirement; can't predict which kind of dust/essence/shard will be produced when it is disenchanted. (This is likely a quest reward item, and thus likely to disenchant as would an item whose required level is similar to that of the quest.)";
FDP_GENERAL_WEAPON_RULE = "Being a weapon, this item is more likely to disenchant to an essence than other items are. Dust is most likely, and shards are rare.";
FDP_GENERAL_OTHER_RULE = "Dust is most likely, an essence is uncommon, and shards are rare.";

FDP_ITEM_DIS_BY_LEVEL_FORMAT = "An item of level %s may disenchant into:";
FDP_DUST_BY_LEVEL_INFO = "(likely for green items)";
FDP_ESSENCE_BY_LEVEL_INFO = "(likely for green weapons, occasionally for other green items)";
FDP_SHARD_BY_LEVEL_INFO = "(rarely for green items, always for blue or better items)";

-- Slash command errors
FDP_BAIL_FORMAT = "Can't determine disenchant info from %s.";
FDP_ERROR_ITEMLEVEL = "Item levels must be between 1 and 60.";
FDP_ERROR_ITEMID_FORMAT = "Can't determine item ID from %s.";

-- Special slash command components
FDP_CMD_NUMBER = "<number>";
FDP_CMD_LINK = "<item link>";

-- Slash command help
FDP_HELP_HELP = "Print this helplist.";
FDP_HELP_STATUS = "Check current settings.";
FDP_HELP_REAGENTS = "add info to tooltips for enchanting reagents (e.g. Strange Dust) showing what they can disenchant from.";
FDP_HELP_ITEMS = "add info to tooltips for disenchantable items (e.g. green weapons) showing what they can disenchant into.";
FDP_HELP_TOOLTIP = "turns all tooltip modificaitons on and off.";
FDP_HELP_VERBOSE = "add an extra line to tooltips for enchanting reagents further explaining how to get them from disenchanting.";
FDP_HELP_AUTOLOOT = "automatically close (and thus take all items from) the loot window when disenchanting.";
FDP_HELP_NUMBER = "provide an item's level requirement to see what it can disenchant to.";
FDP_HELP_LINK = "shift-click an item to see what it can disenchant to.";

-- Status returned from slash commands
FDP_STATUS_REAGENTS_ON = "Showing disenchant level range on tooltips for enchanting reagents.";
FDP_STATUS_REAGENTS_OFF = "Not adding info to tooltips for enchanting reagents.";
FDP_STATUS_ITEMS_ON = "Showing disenchant predictions on tooltips for disenchantable items.";
FDP_STATUS_ITEMS_OFF = "Not adding info to tooltips for disenchantable items.";
FDP_STATUS_TOOLTIP_ON = "Adding info to tooltips.";
FDP_STATUS_TOOLTIP_OFF = "Not adding any info to tooltips.";
FDP_STATUS_VERBOSE_ON = "Also showing more specific info for certain enchanting reagent tooltips.";
FDP_STATUS_VERBOSE_OFF = "Not showing more specific info for enchanting reagents.";
FDP_STATUS_AUTOLOOT_ON = "Will automatically close (taking all items from) the loot window when disenchanting.";
FDP_STATUS_AUTOLOOT_OFF = "Will always leave the loot window to be manually dealt with.";

-- Dust names
DUST_STRANGE	= "Strange Dust";
DUST_SOUL		= "Soul Dust";
DUST_VISION		= "Vision Dust";
DUST_DREAM		= "Dream Dust";
DUST_ILLUSION	= "Illusion Dust";

-- Essence names
ESSENCE_MAGIC_LESSER	= "Lesser Magic Essence";
ESSENCE_MAGIC_GREATER	= "Greater Magic Essence";
ESSENCE_ASTRAL_LESSER	= "Lesser Astral Essence";
ESSENCE_ASTRAL_GREATER	= "Greater Astral Essence";
ESSENCE_MYSTIC_LESSER	= "Lesser Mystic Essence";
ESSENCE_MYSTIC_GREATER	= "Greater Mystic Essence";
ESSENCE_NETHER_LESSER	= "Lesser Nether Essence";
ESSENCE_NETHER_GREATER	= "Greater Nether Essence";
ESSENCE_ETERNAL_LESSER	= "Lesser Eternal Essence";
ESSENCE_ETERNAL_GREATER	= "Greater Eternal Essence";

-- Shard names
SHARD_GLIMMER_SMALL		= "Small Glimmering Shard";
SHARD_GLIMMER_LARGE		= "Large Glimmering Shard";
SHARD_GLOWING_SMALL		= "Small Glowing Shard";
SHARD_GLOWING_LARGE		= "Large Glowing Shard";
SHARD_RADIANT_SMALL		= "Small Radiant Shard";
SHARD_RADIANT_LARGE		= "Large Radiant Shard";
SHARD_BRILLIANT_SMALL	= "Small Brilliant Shard";
SHARD_BRILLIANT_LARGE	= "Large Brilliant Shard";

NEXUS_CRYSTAL	= "Nexus Crystal";


if ( GetLocale() == "deDE" ) then

	FDP_ALWAYS_DIS_TO_FORMAT = "Wird immer zu %s entzaubert.";
	FDP_CAN_DIS_TO = "Kann entzaubert werden zu:";

	FDP_MOST_LIKELY = "(sehr wahrscheinlich)";		-- chance of getting dust from any green
	FDP_JUST_LIKELY = "(wahrscheinlich)";			-- chance of getting essence from a green weapon
	FDP_OCCASIONALLY = "(gelegentlich)";	-- chance of getting essence from any other green
	FDP_RARELY = "(kaum)";				-- chance of getting a shard from any green

	FDP_CAN_DIS_FROM_FORMAT = "Kann von Items des Levels %s entzaubert werden.";
	FDP_SHARD_VERBOSE = "Wird immer von blauen oder besseren Items entzaubert, kaum von grünen Items.";
	FDP_ESSENCE_VERBOSE = "Wird öfters von grünen Waffen entzaubert, ab und zu von anderen grünen Items.";
	FDP_DUST_VERBOSE = "Wird häufig von jedem grünen Item entzaubert.";

	FDP_CANT_DIS_QUALITY_FORMAT = "%s meist kann es nicht entzaubert werden (nur in grüner oder besserer Qualität können es).";
	FDP_CANT_DIS_TYPE_FORMAT = "%s möglicherweise nicht entzauberbar. (Hauptsächlich nur anlegbare, nichtstapelbare Items.)";

	FDP_NOLEVEL_BLUE_FORMAT = "%s hat keine Levelerfordernis, es wird ein Splitter beim entzaubern produziert, aber ich kann nicht vorraussagen was. (Das ist wahrscheinlich ein Quest-Reward Item und so ist es wahrscheinlich, dass die Entzauberung das gleiche Level hat wie die Quest.)";
	FDP_NOLEVEL_GREEN_FORMAT = "%s hat keine Levelerfordernis; Ich kann nicht vorraussagen, welche Art von Staub/Essenz/Splitter beim entzaubern produziert wird. (Das ist wahrscheinlich ein Quest-Reward Item und so ist es wahrscheinlich, dass die Entzauberung das gleiche Level hat wie die Quest.)";
	FDP_GENERAL_WEAPON_RULE = "Es ist eine Waffe, dieses Item wird sehr wahrscheinlich zu einer Essenz entzaubert, nicht wie andere Items dieser Art. Staub ist sehr wahrscheinlich und Splitter sind rar.";
	FDP_GENERAL_OTHER_RULE = "Staub ist wahrscheinlich, eine Essenz währe ungewöhnlich und Splitter wären rar.";

	FDP_ITEM_DIS_BY_LEVEL_FORMAT = "Ein Item der Level %s kann entzaubert werden zu:";
	FDP_DUST_BY_LEVEL_INFO = "(wahrscheinlich grüne Items)";
	FDP_ESSENCE_BY_LEVEL_INFO = "(wahrscheinlich grüne Waffen, ab und zu andere grüne Items)";
	FDP_SHARD_BY_LEVEL_INFO = "(kaum grüne Items, immer blaue oder bessere)";

	-- Slash command errors
	FDP_BAIL_FORMAT = "Keine ermittelbaren Infos von %s.";
	FDP_ERROR_ITEMLEVEL = "Item Levels muss zwischen 1 und 60 sein.";
--	FDP_ERROR_ITEMID_FORMAT = "Can't determine item ID from %s.";

	-- Special slash command components
	FDP_CMD_NUMBER = "<nummer>";
--	FDP_CMD_LINK = "<item link>";

	-- Slash command help
	FDP_HELP_HELP = "Diese Hilfeliste ausgeben.";
	FDP_HELP_STATUS = "Aktuelle Einstellungen überprüfen/anzeigen.";
	FDP_HELP_REAGENTS = "fügt eine Info zum Tooltipp der entzauberbaren Items hinzu (z.B. grüne Waffen). Zeigt in was sie entzaubert werden können.";
	FDP_HELP_ITEMS = "fügt eine Info zum Tooltipp der Reagenzien hinzu (z.B. Seltsamer Staub). Zeigt von was sie entzaubert werden können.";
	FDP_HELP_TOOLTIP = "stellt alle Tooltipp-MODS an oder aus.";
	FDP_HELP_VERBOSE = "fügt eine Extrazeile zu den Tooltipps der entzauberten Reagenzien hinzu, zudem eine Erklärung wie man sie vom Entzaubern bekommt.";
	FDP_HELP_NUMBER = "Zeige eine Entzauberungsinfo für Level <nummer> im Chat-Fenster.";
--	FDP_HELP_LINK = "shift-click an item to see what it can disenchant to.";

	-- Status returned from slash commands
	FDP_STATUS_REAGENTS_ON = "Zeige nun die EntzauberungsLevelRange in den Tooltipps der Reagenzien.";
	FDP_STATUS_REAGENTS_OFF = "Füge nun keine Info zu den Tooltipps der Reagenzien hinzu.";
	FDP_STATUS_ITEMS_ON = "Zeige nun die Entzauberungsvorhersage in den Tooltipps der zu entzaubernden Items.";
	FDP_STATUS_ITEMS_OFF = "Füge nun keine Info zu den Tooltipps der zu entzaubernden Items hinzu.";
	FDP_STATUS_TOOLTIP_ON = "Füge nun Infos zu den Tooltipps hinzu.";
	FDP_STATUS_TOOLTIP_OFF = "Füge nun keine Infos zu den Tooltipps hinzu.";
	FDP_STATUS_VERBOSE_ON = "Zeige nun auch mehrere spezifische Infos für bestimmte Reagenzien in den Tooltipps.";
	FDP_STATUS_VERBOSE_OFF = "Zeige nun keine weiteren spezifischen Infos für Reagenzien.";

	-- Dust names
	DUST_STRANGE	= "Seltsamer Staub";
	DUST_SOUL		= "Seelenstaub";
	DUST_VISION		= "Visionenstaub";
	DUST_DREAM		= "Traumstaub";
	DUST_ILLUSION	= "Illusionsstaub";

	-- Essence names
	ESSENCE_MAGIC_LESSER	= "Geringe Magie-Essenz";
	ESSENCE_MAGIC_GREATER	= "Große Magie-Essenz";
	ESSENCE_ASTRAL_LESSER	= "Geringe Astral-Essenz";
	ESSENCE_ASTRAL_GREATER	= "Große Astral-Essenz";
	ESSENCE_MYSTIC_LESSER	= "Geringe Mystikeressenz";
	ESSENCE_MYSTIC_GREATER	= "Große Mystikeressenz";
	ESSENCE_NETHER_LESSER	= "Geringe Nether-Essenz";
	ESSENCE_NETHER_GREATER	= "Große Nether-Essenz";
	ESSENCE_ETERNAL_LESSER	= "Geringe ewige Essenz";
	ESSENCE_ETERNAL_GREATER	= "Große ewige Essenz";

	-- Shard names
	SHARD_GLIMMER_SMALL		= "Kleiner gleißender Splitter";
	SHARD_GLIMMER_LARGE		= "Großer gleißender Splitter";
	SHARD_GLOWING_SMALL		= "Kleiner leuchtender Splitter";
	SHARD_GLOWING_LARGE		= "Großer leuchtender Splitter";
	SHARD_RADIANT_SMALL		= "Kleiner strahlender Splitter";
	SHARD_RADIANT_LARGE		= "Großer strahlender Splitter";
	SHARD_BRILLIANT_SMALL	= "Kleiner glänzender Splitter";
	SHARD_BRILLIANT_LARGE	= "Großer glänzender Splitter";

end

if ( GetLocale() == "frFR" ) then


end

if ( GetLocale() == "koKR" ) then

FDP_ALWAYS_DIS_TO_FORMAT = "항상 %s|1이;가; 추출뙴.";
FDP_CAN_DIS_TO = "예상 마력추출 결과:";
FDP_CAN_DIS_TO_SHORT = "마력추출:";

FDP_MOST_LIKELY = "(대부분)";		-- chance of getting dust from any green
FDP_JUST_LIKELY = "(자주)";			-- chance of getting essence from a green weapon
FDP_OCCASIONALLY = "(때때로)";	-- chance of getting essence from any other green
FDP_RARELY = "(드물게)";				-- chance of getting a shard from any green

FDP_CAN_DIS_FROM_FORMAT = "%s레벨의 아이템에서 추출가능.";
FDP_SHARD_VERBOSE = "|cff0070dd희귀|r 아이템에서 항상 추출가능|n드물게 |cff1eff00고급|r 아이템에서 추출가능.";
FDP_ESSENCE_VERBOSE = "어떤 |cff1eff00고급|r 아이템에서도 추출가능|n다른 종류보다 무기에서 추출가능성이 높음.";
FDP_DUST_VERBOSE = "|cff1eff00고급|r 아이템에서 빈번하게 추출가능.";
FDP_NEXUS_CAN_DIS_FROM_1 = "51레벨 이상의 |cffa335ee영웅|r 아이템에서 항상 추출가능";
FDP_NEXUS_CAN_DIS_FROM_2 = "드물게 같은 레벨의 |cff0070dd희귀|r 아이템에서 추출가능";

FDP_CANT_DIS_EXCEPTION_FORMAT = "%s|1은;는; 마력추출 할수 없음.";
FDP_CANT_DIS_QUALITY_FORMAT = "%s|1은;는; 대부분 마력추출 할수 없음 (|cff1eff00고급|r, |cff0070dd희귀|r, or |cffa335ee영웅|r 품질의 아이템만 가능).";
FDP_CANT_DIS_TYPE_FORMAT = "%s|1은;는; 마력추출이 불가능 할수 있음. (일반적으로, 착용가능하거나, 겹치지 않는 아이템만 가능.)";

FDP_NOLEVEL_PURPLE_FORMAT = "%s|1은;는; 레벨 제한이 없음; 퀘스트 보상 아이템 일수 있음, 이 아이템은 퀘스트 레벨과 유사한 레벨의 마법부여 재료가 추출됨. 51+ |cffa335ee영웅|r 아이템은 %s|1이;가 추출됨; 다른것들은 해당하는 레벨에 적절한 결정이 추출됨.";
FDP_NOLEVEL_BLUE_FORMAT = "%s|1은;는; 레벨 제한이 없음; 마력추출시 결정이 나옴. 그러나 어떤 종류가 나올지 알수 없음 (퀘스트 보상 아이템 일수 있음, 이 아이템은 퀘스트 레벨과 유사한 레벨의 마법부여 재료가 추출됨.)";
FDP_NOLEVEL_GREEN_FORMAT = "%s|1은;는; 레벨 제한이 없음; 어떤 종류의 가루/정수/결정이 추출될지 알수 없음. (퀘스트 보상 아이템 일수 있음, 이 아이템은 퀘스트 레벨과 유사한 레벨의 마법부여 재료가 추출됨.)";
FDP_GENERAL_WEAPON_RULE = "무기입니다, 다른 아이템보다 정수가 추출될 가능성이 높음. 대부분 가루가 추출되고, 드물게 결정이 추출됨";
FDP_GENERAL_OTHER_RULE = "가루가 추출될 가능성이 높음, 때때로 정수도 추출되고, 드물게 결정도 추출됨";

FDP_ITEM_DIS_BY_LEVEL_FORMAT = "%s레벨 아이템의 마력추출정보: ";
FDP_DUST_BY_LEVEL_INFO = "(|cff1eff00고급|r아이템에서 추출)";
FDP_ESSENCE_BY_LEVEL_INFO = "(|cff1eff00고급|r 무기, 때때로 |cff1eff00고급|r 방어구에서 추출)";
FDP_SHARD_BY_LEVEL_INFO = "(드물게 |cff1eff00고급|r, 항상 |cff0070dd희귀|r 혹은 그이상에서 추출)";

-- Slash command errors
FDP_BAIL_FORMAT = "%s의 마력추출 정보를 결정할수 없음.";
FDP_ERROR_ITEMLEVEL = "아이템의 레벨은 1에서 60 이어야합니다.";
FDP_ERROR_ITEMID_FORMAT = "%s의 아이템 ID를 결정할수 없음.";

-- Special slash command components
FDP_CMD_NUMBER = "<아이템 레벨>";
FDP_CMD_LINK = "<아이템 링크>";

-- Slash command help
FDP_HELP_HELP = "도움말 출력.";
FDP_HELP_STATUS = "현재 설정 확인.";
-- FDP_HELP_REAGENTS = "add info to tooltips for enchanting reagents (e.g. Strange Dust) showing what they can disenchant from.";
FDP_HELP_REAGENTS = "마법부여 재료의 툴팁에 재료가 추출되는 아이템의 정보 추가 (e.g. 이상한 가루).";
-- FDP_HELP_ITEMS = "add info to tooltips for disenchantable items (e.g. green weapons) showing what they can disenchant into.";
FDP_HELP_ITEMS = "마력추출 가능한 아이템의 툴팁에 추출되는 재료의 정보 추가 (e.g. |cff1eff00고급|r아이템)";
FDP_HELP_TOOLTIP = "모든 툴팁 정보 켬/끔.";
-- FDP_HELP_VERBOSE = "add an extra line to tooltips for enchanting reagents further explaining how to get them from disenchanting.";
FDP_HELP_VERBOSE = "마법부여 재료의 툴팁에 추출 방법 설명.";
FDP_HELP_AUTOLOOT = "마력추출시 자동으로 루팅창 닫기.";
-- FDP_HELP_NUMBER = "provide an item's level requirement to see what it can disenchant to.";
FDP_HELP_NUMBER = "입력한 레벨에 해당하는 아이템의 마력추출 정보 표시";
FDP_HELP_LINK = "링크된 아이템에 대한 마력추출 정보 표시.";

-- Status returned from slash commands
FDP_STATUS_REAGENTS_ON = "마법부여 재료의 툴팁에 추출가능 레벨 범위 표시.";
FDP_STATUS_REAGENTS_OFF = "마법부여 재료의 툴팁에 정보 표시하지 않음.";
FDP_STATUS_ITEMS_ON = "마력추출 가능한 아이템의 툴팁에 예상 추출정보 표시.";
FDP_STATUS_ITEMS_OFF = "마력추출 가능한 아이템의 툴팁에 정보 표시하지 않음.";
FDP_STATUS_TOOLTIP_ON = "툴팁에 정보 표시.";
FDP_STATUS_TOOLTIP_OFF = "툴팁에 정보 표시하지 않음.";
FDP_STATUS_VERBOSE_ON = "마법부여 재료의 툴팁에 추출 방법 설명.";
FDP_STATUS_VERBOSE_OFF = "마법부여 재료의 툴팁에 추출 방법 설명 하지 않음.";
FDP_STATUS_AUTOLOOT_ON = "마력추출시 자동으로 루팅창 닫기.";
FDP_STATUS_AUTOLOOT_OFF = "마력추출시 자동으로 루팅창 닫지 않음.";

-- Dust names
DUST_STRANGE	= "이상한 가루";
DUST_SOUL		= "영혼 가루";
DUST_VISION		= "환상 가루";
DUST_DREAM		= "꿈가루";
DUST_ILLUSION	= "환영 가루";

-- Essence names
ESSENCE_MAGIC_LESSER	= "하급 마법의 정수";
ESSENCE_MAGIC_GREATER	= "상급 마법의 정수";
ESSENCE_ASTRAL_LESSER	= "하급 별의 정수";
ESSENCE_ASTRAL_GREATER	= "상급 별의 정수";
ESSENCE_MYSTIC_LESSER	= "하급 신비의 정수";
ESSENCE_MYSTIC_GREATER	= "상급 신비의 정수";
ESSENCE_NETHER_LESSER	= "하급 황천의 정수";
ESSENCE_NETHER_GREATER	= "상급 황천의 정수";
ESSENCE_ETERNAL_LESSER	= "하급 영원의 정수";
ESSENCE_ETERNAL_GREATER	= "상급 영원의 정수";

-- Shard names
SHARD_GLIMMER_SMALL		= "희미하게 빛나는 작은 결정";
SHARD_GLIMMER_LARGE		= "희미하게 빛나는 큰 결정";
SHARD_GLOWING_SMALL		= "붉게 빛나는 큰 결정";
SHARD_GLOWING_LARGE		= "붉게 빛나는 작은 결정";
SHARD_RADIANT_SMALL		= "찬란하게 빛나는 작은 결정";
SHARD_RADIANT_LARGE		= "찬란하게 빛나는 큰 결정";
SHARD_BRILLIANT_SMALL	= "눈부신 작은 결정";
SHARD_BRILLIANT_LARGE	= "눈부신 큰 결정";

NEXUS_CRYSTAL	= "마력의 결정체";

end
