assert(CandyDice)
assert(CandyDice.defaults)
assert(BabbleSpell)

L=BabbleSpell


CandyDice.defaults["ROGUE"]  = {
    [L["Slice and Dice"]] = {
        colors = {"0000ff"}, --fgcolor, bgcolor as hex strings. No names because these get registered with PaintChip
        cooldown = false,   -- scan this ability for a cooldown?
        buff = true,   -- scan buffs for this?
            -- TODO: add a debuff scanner?
            -- TODO: Item CDs
    },
    [L["Blind"]] = {
        colors={"212121"},
        cooldown=true,
        buff=false,
    },
    [L["Stealth"]] = {
        colors = {"000000"},
        cooldown = true,
        buff = false,
    },
    [L["Kidney Shot"]] = {
        colors = {"magenta"},
        cooldown = true,
        buff = false
    },
    [L["Vanish"]] = {
        colors = {"ffffff"},
        cooldown = true,
        buff = true
    },
    [L["Kick"]] = {
        colors = {"000000"},
        cooldown = true,
        buff = false
    },
    [L["Adrenaline Rush"]] = {
        colors = {"ff0000"},
        cooldown = true,
        buff = true
    },
    [L["Blade Flurry"]] = {
        colors = {"ffff00"},
        cooldown = true,
        buff = true
    },
    [L["Evasion"]] = {
        colors = {"aa00ff"},
        cooldown = true,
        buff = true
    },
    [L["Sprint"]] = {
        colors = {"00ff00"},
        cooldown = true,
        buff = true
    },
    [L["Feint"]] = {
        colors = {"c0c0c0"},
        cooldown = true,
        buff = false,
    },
    [L["Gouge"]] = {
        colors = {"FFCC66"},
        cooldown = true,
        buff = false
    },
    [L["Distract"]] = {
        colors = {"FFCC66"},
        cooldown = true,
        buff = false
    },
    [L["Premeditation"]] = {
        colors = {"FFCC66"},
        cooldown = true,
        buff = false
    },
    [L["Preparation"]] = {
        colors = {"FFCC66"},
        cooldown = true,
        buff = false
    },
    [L["Cold Blood"]]= {
        colors = {"87CEFA"},
        cooldown = true,
        buff = true,
    },
    -- Crusader - not in Babble spell, needs to be localized manually some day
    ["Holy Strength"] = {
        colors = {"ffff00"},
        cooldown = false,
        buff = true
    },
}