assert(CandyDice)
assert(CandyDice.defaults)
assert(BabbleSpell)

L=BabbleSpell

CandyDice.defaults["PRIEST"]  = {
     ["Aura of the Blue Dragon"] = { -- Blue Dragon darkmoon card
        colors = {"00ff99"},
        cooldown = false,
        buff = true
     }
}