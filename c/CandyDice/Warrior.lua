assert(CandyDice)
assert(CandyDice.defaults)
assert(BabbleSpell)

L=BabbleSpell

CandyDice.defaults["WARRIOR"]  = {
	[L["Taunt"]] = {
        colors = {"FF8247"},
        cooldown = true,
        buff = false
    },
	[L["Bloodrage"]] = {
        colors = {"660000"},
        cooldown = true,
        buff = true
    },
}