assert(CandyDice)
assert(CandyDice.defaults)
assert(BabbleSpell)

L=BabbleSpell

CandyDice.defaults["PALADIN"]  = {
    -- TODO: Make the pattern a regexp so you can have 1 seal entry instead of 10
    [L["Seal of Righteousness"]] = {
        buff = true,
        cooldown = false,
        colors = {"FFB90F"}
    },
    [L["Seal of the Crusader"]] = {
        buff = true,
        cooldown = false,
        colors = {"FFB90F"}
    },
    [L["Judgement"]] = {
        buff = false,
        cooldown = true,
        colors = {"FFB90F"}
    },
    [L["Divine Protection"]] = {
        buff = false,
        cooldown = true,
        colors = {"FFD700"}
    },
    [L["Hammer of Justice"]] = {
        buff = false,
        cooldown = true,
        colors = {"9400D3"}
    },
}