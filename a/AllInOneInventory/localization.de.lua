-- Version : German (by DoctorVanGogh, StarDust)
-- Last Update : 08/16/2005

if (GetLocale()=="deDE") then
	
	BINDING_HEADER_ALLINONEINVENTORYHEADER			= "Komplettinventar";
	BINDING_NAME_ALLINONEINVENTORY				= "Komplettinventar aktivieren/deaktivieren";
	
	ALLINONEINVENTORY_BAG_TITLE_SHORT 			= "Inv.";
	ALLINONEINVENTORY_BAG_TITLE_LONG 			= "Inventar";

	ALLINONEINVENTORY_CONFIG_HEADER				= "Komplettinventar";
	ALLINONEINVENTORY_CONFIG_HEADER_INFO			= "Konfiguriert das AddOn Komplettinventar, welches es erlaubt den Inhalt mehrerer Taschen in einem Fenster anzuzeigen.";
	ALLINONEINVENTORY_CONFIG_HEADER_SHORT_INFO		= "Leichtes Inventar";
	ALLINONEINVENTORY_CONFIG_HEADER_TEXTURE			= "Interface\\Buttons\\Button-Backpack-Up";


	ALLINONEINVENTORY_CHAT_ENABLED				= "Komplettinventar aktiviert.";
	ALLINONEINVENTORY_CHAT_DISABLED				= "Komplettinventar deaktiviert.";
	
	ALLINONEINVENTORY_CHAT_ALPHA_FORMAT			= "Komplettinventar: Sichtbarkeit auf %f (0 bedeutet wie Elternfenster) gesetzt";

	ALLINONEINVENTORY_CHAT_SCALE_FORMAT			= "Komplettinventar: Skalierung auf %f (0 bedeutet wie Standard UI) gesetzt";

	ALLINONEINVENTORY_CHAT_SWAP_BAG_ORDER_ENABLED		= "Komplettinventar: Tauschen der Taschenreihenfolge aktiviert.";
	ALLINONEINVENTORY_CHAT_SWAP_BAG_ORDER_DISABLED		= "Komplettinventar: Tauschen der Taschenreihenfolge deaktiviert.";

	ALLINONEINVENTORY_CHAT_LOCKED_ENABLED			= "Komplettinventar: Momentane Position fixiert.";
	ALLINONEINVENTORY_CHAT_LOCKED_DISABLED			= "Komplettinventar: Fenster kann wieder verschoben werden.";

	ALLINONEINVENTORY_CHAT_COMMAND_INFO			= "Konfiguriert Komplettinventar mittels Kommandozeile - /allinoneinventory f\195\188r Benutzungshinweise und Hilfe eingeben.";
	
	ALLINONEINVENTORY_CHAT_COMMAND_USAGE			= {};
	ALLINONEINVENTORY_CHAT_COMMAND_USAGE[1]			= "Benutzung: /allinoneinventory [toggle/includeshotbags/replacebags/reset/columns]";
	ALLINONEINVENTORY_CHAT_COMMAND_USAGE[2]			= "Befehle:";
	ALLINONEINVENTORY_CHAT_COMMAND_USAGE[3]			= " toggle - blendet das Komplettinventar-Fenster ein bzw. aus";
	ALLINONEINVENTORY_CHAT_COMMAND_USAGE[4]			= " includeshotbags - Inhalt des Munitionsbeutels ebenfalls anzeigen";
	ALLINONEINVENTORY_CHAT_COMMAND_USAGE[5]			= " reset - das Fenster des Komplettinventars an seine Ursprungsposition zur\195\188cksetzen";
	ALLINONEINVENTORY_CHAT_COMMAND_USAGE[6]			= " replacebags - Standardtaschen ersetzen";
	ALLINONEINVENTORY_CHAT_COMMAND_USAGE[7]			= " columns - Anzahl der Spalten im Fenster des Komplettinventars verwenden";
	ALLINONEINVENTORY_CHAT_COMMAND_USAGE[8]			= " togglebags - Taschennummer- oder Rucksack-Anzeige wechseln";
	ALLINONEINVENTORY_CHAT_COMMAND_USAGE[9]			= " toggleslot - Taschen-/Slotnummer Anzeige wechseln (wird ausgeblendet)";
	ALLINONEINVENTORY_CHAT_COMMAND_USAGE[10]		= " swapbagorder - Taschensortierung umkehren (vom Rucksack ausgehend vorw\195\164rts oder umgekehrt)";
	ALLINONEINVENTORY_CHAT_COMMAND_USAGE[11]		= " alpha - Sichtbarkeit des Komplettinventar (0 bedeutet unsichtbar)";
	ALLINONEINVENTORY_CHAT_COMMAND_USAGE[12]		= " scale - Skalierung des Komplettinventar (0 bedeutet aus, 1 normal und 2 doppelte Gr\195\182\195\159e)";
	
	ALLINONEINVENTORY_TOGGLE_SLOT_FAIL			= "Komplettinventar: Fehler beim Wechseln der Taschen/Slots: falsche Angabe.";
	ALLINONEINVENTORY_TOGGLE_SLOT				= "Komplettinventar: Taschen/Slots gewechselt %d/%d %s.";
	ALLINONEINVENTORY_TOGGLE_SLOT_ON			= "ein";
	ALLINONEINVENTORY_TOGGLE_SLOT_OFF			= "aus";

	ALLINONEINVENTORY_CHAT_COLUMNS_FORMAT			= "Spaltenzahl des Komplettinventars auf %s eingestellt.";
	
	ALLINONEINVENTORY_CHAT_REPLACEBAGS_ENABLED		= "Komplettinventar ersetzt jetzt die regul\195\164ren Taschen.";
	ALLINONEINVENTORY_CHAT_REPLACEBAGS_DISABLED		= "Regul\195\164re Taschen ersetzten jetzt das Komplettinventar.";
	
	ALLINONEINVENTORY_CHAT_RESETPOSITION			= "Komplettinventar Fenster zur\195\188ckgesetzt.";
	
	ALLINONEINVENTORY_CHAT_INCLUDE_SHOTBAGS_ENABLED		= "Komplettinventar enh\195\164lt jetzt Munitionsbeutel.";
	ALLINONEINVENTORY_CHAT_INCLUDE_SHOTBAGS_DISABLED	= "Komplettinventar enth\195\164lt jetzt keine Munitionsbeutel mehr.";
	
	ALLINONEINVENTORY_CHAT_INCLUDE_BAGZERO_ENABLED		= "Komplettinventar enh\195\164lt jetzt den Rucksack.";
	ALLINONEINVENTORY_CHAT_INCLUDE_BAGZERO_DISABLED		= "Komplettinventar enth\195\164lt jetzt nicht mehr den Rucksack.";
	
	ALLINONEINVENTORY_CHAT_INCLUDE_BAGONE_ENABLED		= "Komplettinventar enh\195\164lt jetzt die erste Tasche.";
	ALLINONEINVENTORY_CHAT_INCLUDE_BAGONE_DISABLED		= "Komplettinventar enh\195\164lt jetzt nicht mehr die erste Tasche.";
	
	ALLINONEINVENTORY_CHAT_INCLUDE_BAGTWO_ENABLED		= "Komplettinventar enh\195\164lt jetzt die zweite Tasche.";
	ALLINONEINVENTORY_CHAT_INCLUDE_BAGTWO_DISABLED		= "Komplettinventar enh\195\164lt jetzt nicht mehr die zweite Tasche.";
	
	ALLINONEINVENTORY_CHAT_INCLUDE_BAGTHREE_ENABLED		= "Komplettinventar enh\195\164lt jetzt die dritte Tasche.";
	ALLINONEINVENTORY_CHAT_INCLUDE_BAGTHREE_DISABLED	= "Komplettinventar enh\195\164lt jetzt nicht mehr die dritte Tasche.";
	
	ALLINONEINVENTORY_CHAT_INCLUDE_BAGFOUR_ENABLED		= "Komplettinventar enh\195\164lt jetzt die vierte Tasche.";
	ALLINONEINVENTORY_CHAT_INCLUDE_BAGFOUR_DISABLED		= "Komplettinventar enh\195\164lt jetzt nicht mehr die vierte Tasche.";
	
	ALLINONEINVENTORY_CHAT_NO_SUCH_BAGNUMBER		= "Komplettinventar hat die Taschennummer nicht erkannt: 0 steht f\195\188r den Rucksack, 1-4 f\195\188r die entsprechenden Taschen.";

end

