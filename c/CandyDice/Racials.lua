assert(CandyDice)
assert(CandyDice.defaults)
assert(BabbleSpell)

L=BabbleSpell

CandyDice.defaults["Scourge"]  = {
     [L["Will of the Forsaken"]] = {
        colors = {"999999"},
        cooldown = true,
        buff = true,
    },
    [L["Cannibalize"]] = {
        colors = {"993300"},
        cooldown = true,
        buff = false
    },
}

CandyDice.defaults["Troll"]  = {
     [L["Berserking"]] = {
        colors = {"ff00ff"},
        cooldown = true,
        buff = true,
    },
}

CandyDice.defaults["Orc"]  = {

}

CandyDice.defaults["Tauren"]  = {
    [L["War Stomp"]] = {
        colors={"212121"},
        cooldown=true,
        buff=false,
    }
}

CandyDice.defaults["Human"]  = {
    [L["Perception"]] = {
        colors={"ffffff"},
        cooldown=true,
        buff=true,
    }
}

CandyDice.defaults["Dwarf"]  = {
    [L["Stoneform"]] = {
        colors = {"C0C0C0"},
        cooldown=true,
        buff=true,
    }
}

CandyDice.defaults["Gnome"]  = {
    [L["Escape Artist"]] = {
        colors={"999999"},
        cooldown=true,
        buff=true,
    }
}
