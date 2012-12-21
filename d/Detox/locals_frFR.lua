local L = AceLibrary("AceLocale-2.0"):new("Detox")

L:RegisterTranslations("frFR", function() return {

	-- menu/options
	["Clean group"] = "Nettoyer",
	["Will attempt to clean a player in your raid/party."] = "Va tenter de nettoyer un membre du raid/groupe",
	["Play sound if unit needs decursing"] = "Jouer un son",
	["Show detoxing in scrolling combat frame"] = "Montrer dans SCT",
	["This will use SCT5 when available, otherwise Blizzards Floating Combat Text."] = "Utilisera SCT5 si disponible, ou le syst\195\168me blizzard par d\195\169faut",
	["Seconds to blacklist"] = "Temps en Blacklist",
	["Units that are out of Line of Sight will be blacklisted for the set duration."] = "Les unit\195\169s Hors de Port\195\169e seront blacklist\195\169es pour cette dur\195\169e",
	["Max debuffs shown"] = "Max d\195\169buffs affich\195\169s",
	["Defines the max number of debuffs to display in the live list."] = "D\195\169finit le nombre de D\195\169buffs a afficher dans la liste",
	["Update speed"] = "Fr\195\169quence",
	["Defines the speed the live list is updated, in seconds."] = "D\195\169finit la dur\195\169e entre deux mises \195\160 jour de la liste",
	["Detaches the live list from the Detox icon."] = "D\195\169tacher la liste de l'icone Detox",
	["Show live list"] = "Montrer la Liste",
	["Options for the live list."] = "Options de la Liste",
	["Live list"] = "Liste",

	-- Filtering
	["Filter"] = "Filtres",
	["Options for filtering various debuffs and conditions."] = "R\195\168gles de filtrage",
	["Debuff"] = "Debuff",
	["Filter by debuff and class."] = "Filtres par Debuff et par Classe",
	["Toggle filtering %s on %s."] = "Active le filtrage de %s sur %s.",
	["Adds a new debuff to the class submenus."] = "Ajouter un nouveau debuff a la liste de classe",
	["Add"] = "Ajouter",
	["Removes a debuff from the class submenus."] = "Enlever un debuff de la liste de classe",
	["Remove %s from the class submenus."] = "Enl\195\168ve %s de la liste de classe",
	["Remove"] = "Enlever",
--	["<debuff name>"] = true,
	["Filter stealthed units"] = "Ignorer les unit\195\169s camoufl\195\169es",
	["It is recommended not to cure stealthed units."] = "A votre place, j'\195\169iterais de gu\195\169rir un voleur dans l'ombre...",
	["Filter Abolished units"] = "Ignorer les unit\195\169s 'Abolies'",
	["Skip units that have an active Abolish buff."] = "Permet d'ignorer les unit\195\169s d\195\169j\195\160 sous un effet de gu\195\169rison",
	["Filter pets"] = "Ignorer les Familiers",
	["Pets are also your friends."] = "Bah les diff\195\169rents familiers sont quand m\195\170me vos amis?",
	["Filter by type"] = "Filtrer par type",
	["Only show debuffs you can cure."] = "N'afficher que les debuffs que vous pouvez soigner",
	["Filter by range"] = "Filtre de port\195\169e",
	["Only show units in range."] = "Ne scan que les unit\195\169s a port\195\169e",

	-- Priority list
	["Priority"] = "Priorit\195\169s",
	["These units will be priorized when curing."] = "Ces unit\195\169s seront trait\195\169es en priorit\195\169!",
	["Show priorities"] = "Afficher les priorit\195\169s",
	["Displays who is prioritized in the live list."] = "Rajoute la liste des priorit\195\169s a la Liste",
	["Priorities"] = "Priorit\195\169s",
	["Can't add/remove current target to priority list, it doesn't exist."] = "Impossible d'ajouter/enlever cette personne de la liste de priorit\195\169s, elle n'existe pas",
	["Can't add/remove current target to priority list, it's not in your raid."] = "Impossible d'ajouter/enlever cette personne de la liste de priorit\195\169s, elle n'est pas dans votre raid",
	["%s was added to the priority list."] = "< %s a \195\169t\195\169 ajout\195\169 >",
	["%s has been removed from the priority list."] = "< %s a \195\169t\195\169 enlev\195\169 >",
	["Nothing"] = "Rien",                   -- A verifier
	["Prioritize %s."] = "Ajouter %s",
	["Every %s"] = "Tous les %s",
	["Prioritize every %s."] = "Ajouter tous les %s",
	["Groups"] = "Groupes",
	["Prioritize by group."] = "Ajouter des groupes",
	["Group %s"] = "Groupe %s",
	["Prioritize group %s."] = "Ajouter le groupe %s",
	["Class %s"] = "Classe %s",             -- A verifier

	-- bindings
--	["Clean group"] = true,
--	["Toggle target priority"] = true,
--	["Toggle target class priority"] = true,
--	["Toggle target group priority"] = true,

	-- spells and potions
	["Dreamless Sleep"] = "Sommeil sans r\195\170ve",
	["Greater Dreamless Sleep"] = "Sommeil sans r\195\170ve sup\195\169rieur",
	["Ancient Hysteria"] = "Hyst\195\169rie ancienne",
	["Ignite Mana"] = "Enflammer le mana",
	["Tainted Mind"] = "Esprit corrompu",
	["Magma Shackles"] = "Entraves de magma",
	["Cripple"] = "Faiblesse",
	["Frost Trap Aura"] = "Aura Pi\195\168ge de givre",
	["Dust Cloud"] = "Nuage de poussi\195\168re",
--	["Widow's Embrace"] = true,
	["Curse of Tongues"] = "Mal\195\169diction des langages",

	["Magic"] = "Magie",
	["Charm"] = "Charme",
	["Curse"] = "Mal\195\169diction",
	["Poison"] = "Poison",
	["Disease"] = "Maladie",

	["Cleaned %s"] = "%s nettoy\195\169",

	["Rank (%d+)"] = "Rang (%d+)"
        
} end)
