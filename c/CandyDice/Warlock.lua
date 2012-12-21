assert(CandyDice)
assert(CandyDice.defaults)
assert(BabbleSpell)

L=BabbleSpell

CandyDice.defaults["WARLOCK"]  = {
    [L["Howl of Terror"]] = {
        colors = {"757575","ffffff"},
        buff = false,
        cooldown = true
    },
    [L["Death Coil"]] = {
        colors = {"4cff5c"},
        buff = false,
        cooldown = true
    },
    [L["Shadowburn"]] = {
        colors = {"757575"},
        buff = false,
        cooldown = true
    },
    [L["Amplify Curse"]]= {
        colors = {"757575"},
        buff = false,
        cooldown = true
    },
    [L["Shadow Trance"]]= { -- Nightfall
        colors = {"212121"},
        buff = true,
        cooldown = false
    },
}