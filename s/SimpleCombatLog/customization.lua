SimpleCombatLog.patterns = {
	
	hit = "[%s] %s %s [%s] %s",	-- source, skill, hit/crit/dot, victim, amount.
	heal = "[%s] %s heal [%s] %s", -- source, skill, victim, amount.
	miss = "[%s] %s %s [%s]", -- source, skill, missType, victim.

	buff = "[%s] %s %s", -- victim, gainSign, skill.
	debuff = "[%s] %s %s", -- victim, gainSign, skill.
	fade = "[%s] -- %s", -- victim, skill.
	
	failDispel = "[%s] -- [%s] %s failed", -- source, victim, skill
	
	gain = "[%s] %s : [%s] + %s %s", -- source, skill, victim, victim, amount, attribute.
	extraattack = "[%s] + %s attacks (%s)", -- victim, amount, skill.
	
	beginCast = "[%s] begins %s", -- source, skill.
	cast = "[%s] %s", -- source, skill.
	castTargetted = "[%s] %s [%s]",
	interrupt = "[%s] int [%s] %s", -- source, victim, skill.
	death = "Death: [%s]", -- victim.
	environment = "[%s] %s %s", -- victim, environmentType, amount.
	create = "[%s] create %s", -- source, item.
	fail = "%s fail: %s", -- skill, reason.
	drain = "[%s] %s : [%s] - %s %s", -- source, skill, victim, amount, attribute.
	leech = "[%s] %s : [%s] - %s %s, [%s] + %s %s", -- source, skill, victim, amount, attribute, sourceGained, amountGained, attributeGained.
	
	honor = "Honor: %s", -- amount
	dishonor = "|cffff0000Dishonor|r: %s", -- source.
	experience = "Exp: %s", -- amount.
	reputation = "Rep: %s %s", -- faction,  amount or new standing.
	enchant = "Enchant: [%s] %s to [%s] %s", -- source, skill, victim, item.

	feedpet = "[%s] pet eat %s", -- owner, food.


	gainSign = "++", -- used in buff and debuff, this will be colored differently for buff and debuff.
	
	-- Trailers
	crushing = "(C)",
	glancing = "(G)",
	absorb = "(A%s)", -- amountAbsorbed.
	resist = "(R%s)", -- amountResisted
	block = "(B%s)", -- amountBlocked
	vulnerable = "(V%s)", -- amountVulnerable
	
	
	








}


SimpleCombatLog.defaultColors = {
	player = { r=0.5, g=0.5, b=1 },
	pet = { r=0.5, g=0.3, b=0.15 },
	raid = { r=1, g=0.5, b=0.2 },
	party = { r=0.65, g=0.65, b=1 },
	target = { r=1, g=0.5, b=1 },
	other = { r=1, g=1, b=1 },
	
	physical = { r=1, g=1, b=1 },
	holy = { r=1, g=1, b=0.3 },
	fire = { r=1, g=0.15, b=0.18 },
	nature = { r=0.4, g=1, b=0.4 },
	frost = { r=0.3, g=0.3, b=0.9 },
	shadow = { r=1, g=0.7, b=1 },
	arcane = { r=0.75, g=0.75, b=0.75 },
	
	heal = { r=1, g=1, b=0.3 },
	miss = { r=1, g=0.5, b=0.5 },
	buff = { r=0.2, g=1, b=0.2 },
	debuff = { r=1, g=0.2, b=0.2 },
	skill = { r=1, g=1, b=0.4 },
}


