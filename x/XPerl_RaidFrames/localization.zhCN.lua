

-- Chinese Localizations

if (GetLocale() == "zhCN") then

	XPERL_RAID_GROUP		= "小队 %d"
	XPERL_RAID_TOOLTIP_NOCTRA	= "没有发现CTRA"
	XPERL_RAID_TOOLTIP_OFFLINE	= "离线计时： %s"
	XPERL_RAID_TOOLTIP_AFK		= "暂离计时： %s"
	XPERL_RAID_TOOLTIP_DND		= "勿扰计时： %s"
	XPERL_RAID_TOOLTIP_DYING	= "死亡倒计时： %s"
	XPERL_RAID_TOOLTIP_REBIRTH	= "重生倒计时： %s"
	XPERL_RAID_TOOLTIP_ANKH		= "十字章失效： %s"
	XPERL_RAID_TOOLTIP_SOULSTONE	= "灵魂石失效： %s"

	XPERL_RAID_TOOLTIP_REMAINING	= "后消失"
	XPERL_RAID_TOOLTIP_WITHBUFF	= "有该buff的成员： (%s)"
	XPERL_RAID_TOOLTIP_WITHOUTBUFF	= "无该buff的成员： (%s)"

	if (not CT_RA_POWERWORDFORTITUDE) then

		CT_RA_POWERWORDFORTITUDE = { "真言术：韧", "坚韧祷言" }
		CT_RA_MARKOFTHEWILD = { "野性印记", "野性赐福" }
		CT_RA_ARCANEINTELLECT = { "奥术智慧", "奥术光辉" }
		CT_RA_ADMIRALSHAT = "将军之帽"
		CT_RA_POWERWORDSHIELD = "真言术：盾"
		CT_RA_SOULSTONERESURRECTION = "灵魂石复活"
		CT_RA_DIVINESPIRIT = { "神圣之灵", "精神祷言" }
		CT_RA_THORNS = "荆棘术"
		CT_RA_FEARWARD = "防护恐惧结界"
		CT_RA_SHADOWPROTECTION = { "防护暗影", "暗影防护祷言" }
		CT_RA_BLESSINGOFMIGHT = { "力量祝福", "强效力量祝福" }
		CT_RA_BLESSINGOFWISDOM = { "智慧祝福", "强效智慧祝福" }
		CT_RA_BLESSINGOFKINGS = { "王者祝福", "强效王者祝福" }
		CT_RA_BLESSINGOFSALVATION = { "拯救祝福", "强效拯救祝福" }
		CT_RA_BLESSINGOFLIGHT = { "光明祝福", "强效光明祝福" }
		CT_RA_BLESSINGOFSANCTUARY = { "庇护祝福", "强效庇护祝福" }
		CT_RA_RENEW = "恢复"
		CT_RA_REGROWTH = "愈合"
		CT_RA_REJUVENATION = "回春术"
		CT_RA_FEIGNDEATH = { ["en"] = "假死" }
		CT_RA_FIRESHIELD = "火焰之盾"
		CT_RA_DAMPENMAGIC = "魔法抑制"
		CT_RA_AMPLIFYMAGIC = "魔法增效"
	end

end
