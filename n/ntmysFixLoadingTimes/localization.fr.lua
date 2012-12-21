-- french (by RaSk 12/apr/06)
-- Caractères spéciaux : \195\169 = é

if ( GetLocale() == "frFR" ) then

NFLT_TITLEUSAGE	= " charg\195\169 (Utilisez /nFLT pour les options)";

NFLT_SETTING = {};
NFLT_SETTING[1]	= "ntmysFLT off";
NFLT_SETTING[2]	= "ntmysFLT on (Messages affich\195\169s)";
NFLT_SETTING[3]	= "ntmysFLT on (Messages non-affich\195\169s)";
NFLT_SETTING[4]	= "ntmysFLT off (Messages affich\195\169s)";

NFLT_ZONECHANGE	= "Le chargement a dur\195\169 ";
NFLT_PROCEVENTS	= "Chargements effectu\195\169s: ";

end