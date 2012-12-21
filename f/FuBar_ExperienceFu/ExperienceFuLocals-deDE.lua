if (not ExperienceFuLocals) then
    ExperienceFuLocals = AceLibrary("AceLocale-2.0"):new("ExperienceFu")
end

ExperienceFuLocals:RegisterTranslations("deDE", function() return {
    ["Current XP"] = "Aktuelle XP",
    ["Gained"] = "Erhalten",
    ["Level"] = "Stufe",
    ["Pet XP"] = "Begleiter-XP",
    ["Remaining"] = "Verbleibend",
    ["Reset session"] = "Sitzung zur\195\188cksetzen",
    ["Rest XP"] = "Erholt-XP",
    ["Show XP/hour"] = "XP/Stunde anzeigen",
    ["Show current XP"] = "Aktuelle XP anzeigen",
    ["Show percent"] = "Prozentwert anzeigen",
    ["Show pet XP"] = "Begleiter-XP anzeigen",
    ["Show rest XP"] = "Erholt-Bonus anzeigen",
    ["Show time to level"] = "Zeit bis zur n\195\164chsten Stufe anzeigen",
    ["Show value"] = "Zahlenwert anzeigen",
    ["Time this level"] = "Zeit auf dieser Stufe",
    ["Time this session"] = "Zeit in dieser Sitzung",
    ["Time to level for this level"] = "Zeit bis zur n\195\164chsten Stufe (diese Stufe)",
    ["Time to level for this session"] = "Zeit bis zur n\195\164chsten Stufe (diese Sitzung)",
    ["Total XP this level"] = "Gesamt-XP diese Stufe",
    ["Total XP this session"] = "Gesamt-XP diese Sitzung",
    ["Total time played"] = "Gesamte Spielzeit",
    ["View as Remaining XP"] = "Verbleibende XP anzeigen",
    ["XP/hour this level"] = "XP/Stunde diese Stufe",
    ["XP/hour this session"] = "XP/Stunde diese Sitzung",

    --[[
    ["Display Value as..."] = true,
    ["Display Values"] = true,
    ["Display various XP statistics"] = true,
    ["Hide Text at level 60"] = true,
    ["Show current XP percent"] = true,
    ["Show current XP until level"] = true,
    ["Show current XP value"] = true,
    ["Show in relation to level"] = true,
    ["Show pet XP percent"] = true,
    ["Show pet XP until level"] = true,
    ["Show pet XP value"] = true,
    ["Show rest XP percent"] = true,
    ["Show rest XP value"] = true,
    ["Statistics"] = true,
    ["Toggle between showing experience as an absolute or in relation to time."] = true,
    ]]--
} end)
