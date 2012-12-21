--[[
    Druid cooldowns contributed by Herrera

]]--


assert(CandyDice)
assert(CandyDice.defaults)
assert(BabbleSpell)


CandyDice.defaults["DRUID"]  = {
    [L["Nature's Swiftness"]] = {
        colors = {"4cff5c"},
        buff = false,
        cooldown = true
    },
    --- Swiftmend not in BabbleSpell, TOOD: fix
    ["Swiftmend"] = {
        colors = {"7AFF4C"},
        buff = false,
        cooldown = true
    },
    [L["Nature's Grasp"]] = {
        colors = {"4CFF4C"},
        buff = false,
        cooldown = true
    },
    [L["Barkskin"]] = {
        colors = {"FF8F4C"},
        buff = false,
        cooldown = true
    },
    [L["Hurricane"]] = {
        colors = {"79799A"},
        buff = false,
        cooldown = true
    },
    [L["Tranquility"]] = {
        colors = {"6FAFFF"},
        buff = false,
        cooldown = true
    },
    [L["Enrage"]] = {
        colors = {"FF4242"},
        buff = false,
        cooldown = true
    },
    [L["Dash"]] = {
        colors = {"7CFF42"},
        buff = false,
        cooldown = true
    },
    [L["Prowl"]] = {
        colors = {"FFEF42"},
        buff = false,
        cooldown = true
    },
    --- This isn't in BabbleSpell either
    ["Faerie Fire (Feral)"] = {
        colors = {"E24CFD"},
        buff = false,
        cooldown = true
    },
    [L["Growl"]] = {
        colors = {"AC492E"},
        buff = false,
        cooldown = true
    },
    [L["Cower"]] = {
        colors = {"70B0FF"},
        buff = false,
        cooldown = true
    },
    [L["Frenzied Regeneration"]] = {
        colors = {"5DFC55"},
        buff = false,
        cooldown = true
    },
    [L["Challenging Roar"]] = {
        colors = {"FF5420"},
        buff = false,
        cooldown = true
    },
    [L["Innervate"]] = {
        colors = {"4C65FF"},
        buff = false,
        cooldown = true
    }
}