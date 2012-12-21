if ( GetLocale() == "deDE" ) then

	XPERL_RAID_GROUP                 = "Gruppe %d"
	XPERL_RAID_TOOLTIP_NOCTRA        = "Kein CTRA gefunden"
	XPERL_RAID_TOOLTIP_OFFLINE       = "Offline seit %s"
	XPERL_RAID_TOOLTIP_AFK           = "AFK seit %s"
	XPERL_RAID_TOOLTIP_DND           = "DND seit %s"
	XPERL_RAID_TOOLTIP_DYING         = "Tot seit %s"
	XPERL_RAID_TOOLTIP_REBIRTH       = "Wiedergeburt verf\195\188gbar in: %s"
	XPERL_RAID_TOOLTIP_ANKH          = "Ankh verf\195\188gbar in: %s"
	XPERL_RAID_TOOLTIP_SOULSTONE     = "Seelenstein verf\195\188gbar in: %s"

	XPERL_RAID_TOOLTIP_REMAINING     = "verbleibend"
	XPERL_RAID_TOOLTIP_WITHBUFF      = "Mit Buff: (%s)"
	XPERL_RAID_TOOLTIP_WITHOUTBUFF   = "Ohne Buff: (%s)"

	XPERL_RAID_DROPDOWN_SHOWPET	= "Zeige die Begleiter"
	XPERL_RAID_DROPDOWN_SHOWOWNER	= "Zeige das Inhaber"

	XPERL_RAID_DROPDOWN_MAINTANKS	= "Main Tanks"
	XPERL_RAID_DROPDOWN_SETMT	= "MT Festlegen #%d"
	XPERL_RAID_DROPDOWN_REMOVEMT	= "MT Entfernen #%d"

	if (not CT_RA_POWERWORDFORTITUDE) then

		CT_RA_POWERWORDFORTITUDE = {  "Machtwort: Seelenst\195\164rke", "Gebet der Seelenst\195\164rke" }
		CT_RA_MARKOFTHEWILD = { "Mal der Wildnis", "Gabe der Wildnis" }
		CT_RA_ARCANEINTELLECT = { "Arkane Intelligenz", "Arkane Brillanz" }
		CT_RA_ADMIRALSHAT = "Admiralshut"
		CT_RA_SHADOWPROTECTION = { "Schattenschutz", "Gebet des Schattenschutz" }
		CT_RA_POWERWORDSHIELD = "Machtwort: Schild"
		CT_RA_SOULSTONERESURRECTION = "Seelenstein-Auferstehung"
		CT_RA_DIVINESPIRIT =  { "G\195\182ttlicher Willen", "Gebet der Willenskraft" }
		CT_RA_THORNS = "Dornen"
		CT_RA_FEARWARD = "Furchtbarriere"
		CT_RA_BLESSINGOFMIGHT = { "Segen der Macht", "Gro\195\159er Segen der Macht" }
		CT_RA_BLESSINGOFWISDOM= { "Segen der Weisheit", "Gro\195\159er Segen der Weisheit" }
		CT_RA_BLESSINGOFKINGS = { "Segen der K\195\182nige", "Gro\195\159er Segen der K\195\182nige" }
		CT_RA_BLESSINGOFSALVATION = { "Segen der Rettung", "Gro\195\159er Segen der Rettung" }
		CT_RA_BLESSINGOFLIGHT = { "Segen des Lichts", "Gro\195\159er Segen der Lichts" }
		CT_RA_BLESSINGOFSANCTUARY = { "Segen des Refugiums", "Gro\195\159er Segen der Refugiums" }
		CT_RA_REGROWTH = "Nachwachsen"
		CT_RA_REJUVENATION = "Verj\195\188ngung"
		CT_RA_RENEW = "Erneuerung"
		CT_RA_AMPLIFYMAGIC = "Magie verst\195\164rken"
		CT_RA_DAMPENMAGIC = "Magied\195\164mpfer"
	end
end
