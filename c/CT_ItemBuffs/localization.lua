CT_ITEMBUFFS_CHARGE = "Charge";
CT_ITEMBUFFS_MINUTE = "min";
CT_ITEMBUFFS_SECOND = "sec";

CT_ITEMBUFFS_MODNAME = "ItemBuffs";
CT_ITEMBUFFS_SUBNAME = "Show short item buffs";
CT_ITEMBUFFS_TOOLTIP = "Toggles showing item buffs shorter than 15 seconds in the buff list.";

CT_ITEMBUFFS_SHORTDURATION_SHOWN = "Short duration buffs are now shown.";
CT_ITEMBUFFS_SHORTDURATION_HIDDEN = "Short duration buffs are now hidden.";

if ( GetLocale() == "frFR" ) then
	CT_ITEMBUFFS_CHARGE = "charge";
elseif ( GetLocale() == "deDE") then
	CT_ITEMBUFFS_MINUTE = "Min.";
	CT_ITEMBUFFS_SECOND = "Sek.";
	CT_ITEMBUFFS_CHARGE = "Aufladungen";
end