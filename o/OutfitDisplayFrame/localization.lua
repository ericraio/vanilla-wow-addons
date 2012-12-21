-- Magic strings

-- English
OUTFITDISPLAYFRAME_NOTENOUGHFREESPACE = "Not enough free space in bags.";
OUTFITDISPLAYFRAME_ITEMSNOTFOUND = "Outfit contains missing items.";
OUTFITDISPLAYFRAME_INVALIDOUTFIT = "Invalid outfit format.";
OUTFITDISPLAYFRAME_ITEMSINBANK = "Outfit contains banked items.";
OUTFITDISPLAYFRAME_TOOFASTMSG = "Can't switch outfits that quickly.";
OUTFITDISPLAYFRAME_ALTCLICK = "Alt-click will reset to an empty slot.";

OUTFITDISPLAYFRAME_USECHECKBOX = "When checked, this slot is forced empty on switch.";
OUTFITDISPLAYFRAME_OVERRIDEHELM = "When checked, override the value of \"Show Helm\" when this outfit is worn.";
OUTFITDISPLAYFRAME_OVERRIDECLOAK = "When checked, override the value of \"Show Cloak\" when this outfit is worn.";

-- German
if ( GetLocale() == "deDE" ) then
	OUTFITDISPLAYFRAME_NOTENOUGHFREESPACE = "Nicht genug Platz in den Taschen";
	OUTFITDISPLAYFRAME_ITEMSNOTFOUND = "Ausr\195\188stung enth\195\164lt fehlende Gegenst\195\164nde";
	OUTFITDISPLAYFRAME_INVALIDOUTFIT = "Ung\195\188ltiges Ausr\195\188stungsformat";
	OUTFITDISPLAYFRAME_ITEMSINBANK = "Ausstattung enth\195\164lt Gegenst\195\164nde, die auf der Bank sind.";
	OUTFITDISPLAYFRAME_TOOFASTMSG = "Sie k\195\182nnen nicht Ausstattungen schalten, die schnell.";

	OUTFITDISPLAYFRAME_USECHECKBOX = "Wenn H\195\164ckchen gesetzt, wird der Taschenplatz wird bim Ausr\195\188stungswechsel geleert.";
end

if ( GetLocale() == "frFR" ) then
 -- OUTFITDISPLAYFRAME_TWOHANDED = "Deux-mains";
    OUTFITDISPLAYFRAME_NOTENOUGHFREESPACE = "Pas assez d'espace libre dans les sacs";
    OUTFITDISPLAYFRAME_ITEMSNOTFOUND = "Articles manquants pour l'\195\169quipement choisi.";
    OUTFITDISPLAYFRAME_INVALIDOUTFIT = "Format d'\195\169quipement incorrect.";
    OUTFITDISPLAYFRAME_ITEMSINBANK = "L'\195\169quipement contient les articles en banque.";
    OUTFITDISPLAYFRAME_TOOFASTMSG = "On ne peut pas commuter les \195\169quipements aussi rapidement.";

    OUTFITDISPLAYFRAME_USECHECKBOX = "Si coch\195\169, ce slot est vid\195\169 lors de la commutation."; 
    OUTFITDISPLAYFRAME_OVERRIDEHELM = "Si coch\195\169, force le \"Afficher le casque\" quand cette tenue est port\195\169e.";
    OUTFITDISPLAYFRAME_OVERRIDECLOAK = "Si coch\195\169, force le \"Afficher la cape\" quand cette tenue est port\195\169e.";
end
