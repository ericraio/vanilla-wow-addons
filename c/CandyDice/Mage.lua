assert(CandyDice)
assert(CandyDice.defaults)
assert(BabbleSpell)

L=BabbleSpell

CandyDice.defaults["MAGE"]  = {
     [L["Blink"]] = {
        colors = {"ffffff"},
        cooldown = true,
        buff = false
    },
    [L["Frost Nova"]] = {
        colors = {"0000ff"},
        cooldown = true,
        buff = false
    },
    [L["Counterspell"]] = {
        colors = {"0000ff"},
        cooldown = true,
        buff = false,
    },
    [L["Fire Blast"]] = {
        colors = {"ff0000"},
        cooldown = true,
        buff=false,            
    },
    [L["Cone of Cold"]] = {
        colors = {"0000ff","ffffff"},
        cooldown = true,
        buff = false,
    },
    [L["Clearcasting"]] = {
        colors = {"C0C0FF"},
        cooldown = false,
        buff=true
    }
}