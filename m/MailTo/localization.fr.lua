-- French text strings

-- Thanks to Assutourix, Sasmira and Mrtijo for the translations.

if(GetLocale()=="frFR") then

MAILTO_OPTION = { alert=  {flag='noalert', name="Alerte de diffusion"},
                  auction={flag='noauction', name="Clic enchv®re"},
                  chat=   {flag='nochat',  name="Clic dialogue"},
                  coin=   {flag='nocoin',  name="Mandat"},
                  ding=   {flag='noding',  name="Alerte sonore"},
                  click=  {flag='noclick', name="Inventaire"},
                  login=  {flag='nologin', name="Message d'activation"},
                  shift=  {flag='noshift', name="Shift-clic"},
                  trade=  {flag='notrade', name="Clic v©change"},
                }

MAILTO_ON =         "%s a été activé."
MAILTO_OFF =        "%s a été désactivé."
MAILTO_TIME =       "Le délai d'expiration de '%s' est défini à %s"
MAILTO_TOOLTIP =    "Cliquer pour choisir le destinataire."
MAILTO_CLEARED =    "La liste de MailTo a étée vidée!"
MAILTO_LISTEMPTY =  "Liste vide."
MAILTO_LISTFULL =   "Attention: la liste de MailTo est pleine!"
MAILTO_ADDED =      " a été ajouté à la liste.";
MAILTO_REMOVED =    " a été retiré de la liste.";
MAILTO_F_ADD =      "(Ajouter %s)";
MAILTO_F_REMOVE =   "(Retirer %s)";
MAILTO_YOU =        "vous"
MAILTO_DELIVERED =  "délivré."
MAILTO_DUE =        "attendu dans %d min."
MAILTO_SENT =       "%s envoyé à %s par %s est %s"
MAILTO_NEW =        "%s%s de %s délivré à %s"
MAILTO_NONEW =      "Pas de nouveau message trouvé."
MAILTO_NEWMAIL =    "(nouveau message possible)"
MAILTO_LOGEMPTY =   "Le log de mail est vide."
MAILTO_NODATA =     "Pas de données dans inbox."
MAILTO_NOITEMS =    "Aucun élément dans inbox."
MAILTO_NOTFOUND =   "Aucun élément trouvé."
MAILTO_INBOX =      "#%d, %s, de %s"
MAILTO_EXPIRES =    " expire dans "
MAILTO_EXPIRED =    " a expiré!"
MAILTO_UNDEFINED =  "Commande indéfinie, "
MAILTO_RECEIVED =   "Reçu %s de %s, %s"
MAILTO_SOLD =       "%s a acheté %s pour %s (net=%s)."
MAILTO_NONAME =     "Nom manquant."
MAILTO_NODESC =     "Description manquante."
MAILTO_MAILOPEN =   "La boite à lettres est ouverte."
MAILTO_MAILCHECK =  "La boite à lettres non vérifiée."
MAILTO_TITLE =      "MailTo  Inbox"
MAILTO_SELECT =     "Sélectionner:"
MAILTO_SERVER =     "Serveur"
MAILTO_SERVERTIP =  "Cocher pour sélectionner les personnage sur d'autres serveurs"
MAILTO_FROM =       "De: "
MAILTO_EXPIRES2 =   "Expire dans "
MAILTO_EXPIRED2 =   "A expiré!"
MAILTO_LOCATE =     "Recherche des éléments correspondant à '%s':"
MAILTO_REMOVE2 =    "Supprimé %s de %s."
MAILTO_BACKPACK =   "Plus de place dans l'inventaire."
MAILTO_EMPTYNEW =   "Vous avec un nouveau message..."
MAILTO_MAIL =       "Mail"
MAILTO_INV =        "Inv"
MAILTO_BANK =       "Bank"
MAILTO_SOLD =       "Enchère réussie"
MAILTO_OUTBID =     "Enchère perdue"
MAILTO_CANCEL =     "Enchère annulée"
MAILTO_CASH =       "Cash encaissé: Total=%s, Ventes=%s, Remboursements=%s, Autres=%s"
end
