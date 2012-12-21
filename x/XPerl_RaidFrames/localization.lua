-- Localizations

if (CT_RA_BuffTextures) then
	XPerl_CTBuffTextures = CT_RA_BuffTextures
elseif (oRA_BuffTextures) then
	XPerl_CTBuffTextures = oRA_BuffTextures
else
	XPerl_CTBuffTextures = {
		[CT_RA_POWERWORDFORTITUDE[1]] = { "Spell_Holy_WordFortitude", 30*60 },
		[CT_RA_POWERWORDFORTITUDE[2]] = { "Spell_Holy_PrayerOfFortitude", 60*60 },
		[CT_RA_MARKOFTHEWILD[1]] = { "Spell_Nature_Regeneration", 30*60 },
		[CT_RA_MARKOFTHEWILD[2]] = { "Spell_Nature_Regeneration", 60*60 },
		[CT_RA_ARCANEINTELLECT[1]] = { "Spell_Holy_MagicalSentry", 30*60 },
		[CT_RA_ARCANEINTELLECT[2]] = { "Spell_Holy_ArcaneIntellect", 60*60 },
		[CT_RA_SHADOWPROTECTION[1]] = { "Spell_Shadow_AntiShadow", 10*60 },
		[CT_RA_SHADOWPROTECTION[2]] = { "Spell_Holy_PrayerofShadowProtection", 20*60 },
		[CT_RA_POWERWORDSHIELD] = { "Spell_Holy_PowerWordShield", 30 },
		[CT_RA_SOULSTONERESURRECTION] = { "Spell_Shadow_SoulGem", 30*60 },
		[CT_RA_DIVINESPIRIT[1]] = { "Spell_Holy_DivineSpirit", 30*60 },
		[CT_RA_DIVINESPIRIT[2]] = { "Spell_Holy_PrayerofSpirit", 60*60 },
		[CT_RA_THORNS] = { "Spell_Nature_Thorns", 10*60 },
		[CT_RA_FEARWARD] = { "Spell_Holy_Excorcism", 10*60 },
		[CT_RA_BLESSINGOFMIGHT[1]] = { "Spell_Holy_FistOfJustice", 5*60},
		[CT_RA_BLESSINGOFMIGHT[2]] = { "Spell_Holy_GreaterBlessingofKings", 5*60},
		[CT_RA_BLESSINGOFWISDOM[1]] = { "Spell_Holy_SealOfWisdom", 5*60},
		[CT_RA_BLESSINGOFWISDOM[2]] = { "Spell_Holy_GreaterBlessingofWisdom", 5*60},
		[CT_RA_BLESSINGOFKINGS[1]] = { "Spell_Magic_MageArmor", 5*60},
		[CT_RA_BLESSINGOFKINGS[2]] = { "Spell_Magic_GreaterBlessingofKings", 5*60},
		[CT_RA_BLESSINGOFSALVATION[1]] = { "Spell_Holy_SealOfSalvation", 5*60},
		[CT_RA_BLESSINGOFSALVATION[2]] = { "Spell_Holy_GreaterBlessingofSalvation", 5*60},
		[CT_RA_BLESSINGOFLIGHT[1]] = { "Spell_Holy_PrayerOfHealing02", 5*60},
		[CT_RA_BLESSINGOFLIGHT[2]] = { "Spell_Holy_GreaterBlessingofLight", 5*60},
		[CT_RA_BLESSINGOFSANCTUARY[1]] = { "Spell_Nature_LightningShield", 5*60},
		[CT_RA_BLESSINGOFSANCTUARY[2]] = { "Spell_Holy_GreaterBlessingofSanctuary", 5*60},
		[CT_RA_RENEW] = { "Spell_Holy_Renew", 15 },
		[CT_RA_REJUVENATION] = { "Spell_Nature_Rejuvenation", 12 },
		[CT_RA_REGROWTH] = { "Spell_Nature_ResistNature", 21 },
		[CT_RA_AMPLIFYMAGIC] = { "Spell_Holy_FlashHeal", 10*60 },
		[CT_RA_DAMPENMAGIC] = { "Spell_Nature_AbolishMagic", 10*60 },
	}
end

if (CT_RAMenu_Options and CT_RAMenu_Options.temp.BuffArray) then
	XPerl_CTBuffArray = CT_RAMenu_Options.temp.BuffArray
elseif (oRA_CTBuffArray) then
	XPerl_CTBuffArray = oRA_CTBuffArray
else
	XPerl_CTBuffArray = {
		{ show = 1, name = CT_RA_POWERWORDFORTITUDE, index = 1 },
		{ show = 1, name = CT_RA_MARKOFTHEWILD, index = 2 },
		{ show = 1, name = CT_RA_ARCANEINTELLECT, index = 3 },
		{ show = 1, name = CT_RA_SHADOWPROTECTION, index = 5 },
		{ show = 1, name = CT_RA_POWERWORDSHIELD, index = 6 },
		{ show = 1, name = CT_RA_SOULSTONERESURRECTION, index = 7 },
		{ show = 1, name = CT_RA_DIVINESPIRIT, index = 8 },
		{ show = 1, name = CT_RA_THORNS, index = 9 },
		{ show = 1, name = CT_RA_FEARWARD, index = 10 },
		{ show = 1, name = CT_RA_BLESSINGOFMIGHT, index = 11 },
		{ show = 1, name = CT_RA_BLESSINGOFWISDOM, index = 12 },
		{ show = 1, name = CT_RA_BLESSINGOFKINGS, index = 13 },
		{ show = 1, name = CT_RA_BLESSINGOFSALVATION, index = 14 },
		{ show = 1, name = CT_RA_BLESSINGOFLIGHT, index = 15 },
		{ show = 1, name = CT_RA_BLESSINGOFSANCTUARY, index = 16 },
		{ show = 1, name = CT_RA_RENEW, index = 17 },
		{ show = 1, name = CT_RA_REJUVENATION, index = 18 },
		{ show = 1, name = CT_RA_REGROWTH, index = 19 }
	}
end
