
SMARTHEAL_HEALTABLE = {
	['PRIEST'] = {
		[SH_FLASH_HEAL] = {value={215,286,360,439,567,704,885}, level={20,26,32,38,44,50,56}, castTime={1.5,1.5,1.5,1.5,1.5,1.5,1.5}, group=0},
		[SH_LESSER_HEAL] = {value={56,78,146}, level={1,4,10}, castTime={1.5,2,2.5}, group=0},
		[SH_HEAL]={value={318,460,604,758}, level={16,22,28,34}, castTime={3,3,3,3}, group=0},
		[SH_GREATER_HEAL]={value={1277,1624,2033,2535,2770}, level={40,46,52,58,60}, castTime={3,3,3,3,3}, group=0},
		[SH_PRAYER_OF_HEALING]={value={311,458,676,965,1070}, level={30,40,50,60,60}, castTime={3,3,3,3,3}, group=1},
		[SH_RENEW]={	value={45,100,175,245,315,400,510,650,810,970},
				level={8,14,20,26,32,38,44,50,56,60}, castTime={15,15,15,15,15,15,15,15,15,15}, group=0,HoT=1},
		[SH_LESSER_GREATER_HEALS]={value={56,78,146,318,460,604,758,1277,1624,2033,2535,2770}, level={1,4,10,16,22,28,34,40,46,52,58,60}, castTime={1.5,2,2.5,3,3,3,3,3,3,3,3,3}, group=0},
	},
	['PALADIN'] =  {
		[SH_FLASH_OF_LIGHT] = {value={67,103,154,209,283,363}, level={20,26,34,42,50,58}, castTime={1.5,1.5,1.5,1.5,1.5,1.5}, group=0},
		[SH_HOLY_LIGHT] ={value={43,83,173,333,522,739,999,1317,1680}, level={1,6,14,22,30,38,46,54,60}, castTime={2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5}, group=0},
	},
	['DRUID'] ={
		[SH_REJUVENATION]={value={32,56,116,180,244,304,388,488,608,756,888}, level={4,10,16,22,28,34,40,46,52,58,60,}, castTime={12,12,12,12,12,12,12,12,12,12,12}, group=0,HoT=1},
		[SH_HEALING_TOUCH]={value={44,100,219,404,633,818,1028,1313,1656,2060,2472}, level={1,8,14,20,26,32,38,44,50,56,60}, castTime={1.5,2,2.5,3,3.5,3.5,3.5,3.5,3.5,3.5,3.5}, group=0},
		[SH_REGROWTH]={	value={91,176,257,339,431,543,685,857,1061},
						HoTvalue={98,175,259,343,427,546,686,861,1064},
						level={12,18,24,30,36,42,48,54,60}, castTime={2,2,2,2,2,2,2,2,2,}, group=0},
	},
	['SHAMAN'] ={
		[SH_LESSER_HEALING_WAVE]={value={174,264,359,486,668,880},level={20,28,36,44,52,60}, castTime={1.5,1.5,1.5,1.5,1.5,1.5}, group=0},
		[SH_HEALING_WAVE]={value={39,71,142,292,408,579,797,1092,1464,1735},level={1,6,12,18,24,32,40,48,56,60}, castTime={2.5,2.5,2.5,3,3,3,3,3,3,3}, group=0},
		[SH_CHAIN_HEAL]={value={344,435,590}, level={40,46,54}, castTime={2.5,2.5,2.5}, group=0},
	},
}

SMARTHEAL_BUFFTABLE= {
	['PRIEST'] = {
		[SH_POWERWORD_SHIELD] = {level={6,12,18,24,30,36,42,48,54,60}, group=0},
		[SH_POWERWORD_FORTITUDE] = {level={1,12,24,36,48,60}, group=0},
		[SH_DIVINE_SPIRIT] = {level={30,40,50,60,60}, group=0},
		[SH_DISPEL_MAGIC] = {level={18,36}, group=0},
		[SH_RESURRECTION] = {level={10,22,34,36,58}, group=0},
		[SH_PRAYER_OF_FORTITUDE] = {level={48,60}, group=1},
		[SH_SHADOW_PROTECTION]={level={30,42,56,}, group=0},
	},
	['PALADIN'] =  {
		[SH_REDEMPTION] = {level={12,24,36,48,60}, group=0},
		[SH_LAY_ON_HANDS] = {level={10,30,50}, group=0},
		[SH_BLESSING_OF_MIGHT] = {level={4,12,22,32,42,52,60}, group=0},
		[SH_BLESSING_OF_LIGHT] = {level={40,50,60}, group=0},
		[SH_BLESSING_OF_PROTECTION] = {level={10,24,38}, group=0},
		[SH_BLESSING_OF_WISDOM] = {level={14,24,34,44,54,60}, group=0},
		[SH_BLESSING_OF_SANCTUARY] = {level={30,40,50,60}, group=0},
		[SH_GREATER_BLESSING_OF_MIGHT] = {level={52,60}, group=2},
		[SH_GREATER_BLESSING_OF_LIGHT] = {level={60}, group=2},
		[SH_GREATER_BLESSING_OF_WISDOM] = {level={54,60}, group=2},
		[SH_GREATER_BLESSING_OF_SANCTUARY] = {level={60}, group=2},
	},
	['DRUID'] ={
		[SH_REBIRTH]={level={20,30,40,50,60}, group=0},
		[SH_TRANQULITY]={level={20,30,40,50}, group=1},
		[SH_MARK_OF_THE_WILD]={level={1,10,20,30,40,50,60}, group=0},
		[SH_GIFT_OF_THE_WILD]={level={50,60}, group=1},
		[SH_THORNS]={level={6,14,24,34,44,54}, group=0},
	},
	['SHAMAN'] ={
		[SH_ANCESTRAL_SPIRIT]={level={12,24,36,48,60}, group=0},
	},
}
