assert(CandyDice)
assert(CandyDice.defaults)
assert(BabbleSpell)

L=BabbleSpell

CandyDice.defaults["SHAMAN"]  = {
    [L["Nature's Swiftness"]]= {
        colors = {"40ff50"},
        buff = false,
        cooldown = true
    },
    [L["Earth Shock"]] = {
        colors = {"BBBB00"},
        buff = false,
        cooldown = true
    }
}