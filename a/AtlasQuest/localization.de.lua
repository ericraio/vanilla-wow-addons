if ( GetLocale() == "deDE" ) then

-- Farben
local PURPLE = "|cff999999";
local RED = "|cffff0000";
local REDA = "|cffcc6666";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local GREY = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";
local YELLOW = "|cffffff00";
local BLACK = "|c0000000f";
local DARKGREEN = "|cff008000";
local BLUB = "|cffd45e19";

-- Options translation
AQShowRight = "Das AtlasQuest-Panle wird nun auf der rechten Seite angezeigt";
AQShowLeft = "Das AtlasQuest-Panle wird nun auf der linken Seite angezeigt (Standart)";
AQHelpText = "Gib /aq or atlasquest [command] ein\ncommands: show/hide; left/right; autoshow(nur Atlas)"
AQAtlasAutoON = "Das AtlasQuest-Panle wird jetzt automatisch mit Atlas angezeigt (Standart)"
AQAtlasAutoOFF = "Das AtlasQuest-Panle wird jetzt nicht mehr mit Atlas angezeigt"

AQSERVERASKInformation = " Bitte rechtsklicke so lange auf den Gegenstand, bis er angezeigt wird."
AQSERVERASK = "Fragt den Server nach: "
AQOptionB = "Optionen"
AQStoryB = "Story"
AQNoReward = "Keine Belohnung vorhanden"
AQERRORNOTSHOWN = "Dieses Item ist unsicher!"
AQERRORASKSERVER = "Klick rechts um den Server nach dem\nItem zu fragen, dabei kann es passieren,\ndas die Verbindung unterbrochen wird."
AQDiscription_OR = "|cffff0000 oder "..WHITE..""
AQDiscription_AND = "|cff008000 und "..WHITE..""
AQDiscription_REWARD = "Belohnung: "
AQDiscription_ATTAIN = "Ben\195\182tigtest Level: "
AQDiscription_LEVEL = "Level: "
AQDiscription_START = "Beginnt bei/in: \n"
AQDiscription_AIM = "Ziel: \n"
AQDiscription_NOTE = "Information: \n"
AQDiscription_PREQUEST = "Vorquest: "
AQDiscription_FOLGEQUEST = "Folgequest: "
ATLAS_VERSIONWARNINGTEXT = "Du benutzt eine veraltete Atlasversion!! Bitte lad dir die neuste Version runter um konflikte mit diesem Addon zu vermeiden. (neuste Version ist 1.8.1)"

-- ITEM TRANSLATION
AQITEM_DAGGER = " Dolch"
AQITEM_SWORD = " Schwert"
AQITEM_AXE = " Axt"
AQITEM_WAND = "Zauberstab"
AQITEM_STAFF = "Stab"
AQITEM_SHIELD = "Schild"
AQITEM_MACE = "Streitkolben"
AQITEM_GUN = "Schusswaffe"

AQITEM_WAIST = "Taille,"
AQITEM_SHOULDER = "Schultern,"
AQITEM_CHEST = "Brust,"
AQITEM_LEGS = "Beine,"
AQITEM_HANDS = "H\195\164nde,"
AQITEM_FEET = "F\195\188\195\159e,"
AQITEM_WRIST = "Handgelenk,"
AQITEM_HEAD = "Kopf,"
AQITEM_BACK = "R\195\188cken"

AQITEM_CLOTH = " Stoff"
AQITEM_LEATHER = " Leder"
AQITEM_MAIL = " Schwere R\195\188stung"
AQITEM_PLATE = " Platte"

AQITEM_OFFHAND = "Nebenhand"
AQITEM_MAINHAND = "Waffenhand,"
AQITEM_ONEHAND = "Einh\195\164ndig,"
AQITEM_TWOHAND = "Zweih\195\164ndig,"

AQITEM_TRINKET = "Schmuck"
AQITEM_POTION = "Trank"
AQITEM_OFFHAND = "Nebenhand"
AQITEM_NECK = "Hals"
AQITEM_PATTERN = "Muster"
AQITEM_BAG = "Beh\195\164lter"
AQITEM_KEY = "Schl\195\188ssel"

--------------DEADMINES/Inst1 ( 5 quests)------------
Inst1Story = "Die Todesminen, einst die wichtigste Goldquelle der Menschen, wurden aufgegeben, als die Horde Stormwind w\195\164hrend des Ersten Krieges in Schutt und Asche legte. Nun haben sich die Defias in den verlassenen Minen niedergelassen und die dunklen Sch\195\164chte in ihre eigene unterirdische Festung verwandelt. Ger\195\188chten zufolge sollen die Diebe die gewitzten Goblins angeheuert haben, um tief in den Minen etwas f\195\188rchterliches zu konstruieren – doch welche Teufelei dies konkret sein soll, ist nicht bekannt. Der Zugang zu den Todesminen liegt inmitten des ruhigen, unscheinbaren Dorfes Moonbrook."
Inst1Caption = "Die Todesminen"
Inst1QAA = "5 Quests"
Inst1QAH = "keine Quests"

--QUEST 1 allianz

Inst1Quest1 = "1. Rote Seidenkopft\195\188cher"
Inst1Quest1_Level = "17"
Inst1Quest1_Attain = "12"
Inst1Quest1_Aim = "Sp\195\164herin Riell am Turm auf der Sp\195\164herkuppe m\195\182chte, dass Ihr ihr 10 rote Seidenkopft\195\188cher bringt."
Inst1Quest1_Location = "Sp\195\164herin Riell (Westfall - Sp\195\164herkuppe; "..YELLOW.."56,47 "..WHITE..")"
Inst1Quest1_Note = "Man bekommt die Kopft\195\188cher von den Arbeitern in DM und kurz vor dem Eingang."
Inst1Quest1_Prequest = "Nein"
Inst1Quest1_Folgequest = "Nein"
--
Inst1Quest1name1 = "Robuste Kurzklinge"
Inst1Quest1name2 = "Kunstvoll geschnitzter Dolch"
Inst1Quest1name3 = "Durchstechende Axt"

--Quest 2 allianz

Inst1Quest2 = "2. Die Suche nach Andenken"
Inst1Quest2_Level = "18"
Inst1Quest2_Attain = "?"
Inst1Quest2_Aim = "Beschafft 4 Gewerkschaftsausweise und bringt sie nach Stormwind zu Wilder Thistlenettle."
Inst1Quest2_Location = "Wilder Thistlenettle (Stormwind - Zwergendistrikt; "..YELLOW.."65, 21"..WHITE.." )"
Inst1Quest2_Note = "Die Ausweise gibt es bei den Untoten(Elite) vor der Instanz."
Inst1Quest2_Prequest = "Nein"
Inst1Quest2_Folgequest = "Nein"
--
Inst1Quest2name1 = "Stiefel des Tunnelgr\195\164bers"
Inst1Quest2name2 = "Verstaubte Bergbau-Handschuhe"
--Quest 3 allianz

Inst1Quest3 = "3. Oh Bruder..."
Inst1Quest3_Level = "20"
Inst1Quest3_Attain = "?"
Inst1Quest3_Aim = "Bringt Gro\195\159knecht Thistlenettles Forscherliga-Abzeichen nach Stormwind zu Wilder Thistlenettle."
Inst1Quest3_Location = "Wilder Thistlenettle (Stormwind - Zwergendistrikt; "..YELLOW.."65,21"..WHITE.." )"
Inst1Quest3_Note = "Das Abzeichen gibt es bei den Untoten(Elite) vor der Instanz."
Inst1Quest3_Prequest = "Nein"
Inst1Quest3_Folgequest = "Nein"
--
Inst1Quest2name1 = "R\195\164cher des Minenarbeiters"

--Quest 4 allianz

Inst1Quest4 = "4. Unterirdischer Angriff"
Inst1Quest4_Level = "20"
Inst1Quest4_Attain = "15"
Inst1Quest4_Aim = "Holt das Gnoam-Sprecklesprocket aus den Todesminen und bringt es Shoni der Schtillen in Stormwind."
Inst1Quest4_Location = "Shoni die Schtille (Stormwind - Zwergendistrikt; "..YELLOW.."55,12"..WHITE.." )"
Inst1Quest4_Note = "Die Prequest bekommt man bei Gnoarn (Stormwind; 69,50).\nDas Gnoam-Sprecklesprocket droppt der Schredder [3]"
Inst1Quest4_Prequest = "Ja, Sprecht mit Shoni"
Inst1Quest4_Folgequest = "Nein"
Inst1Quest4PreQuest = "true"
--
Inst1Quest4name1 = "Polarstulpen"
Inst1Quest4name2 = "D\195\188sterer Zauberstab"

--Quest 5 allianz

Inst1Quest5 = "5. Die Bruderschaft der Defias (Questreihe!)"
Inst1Quest5_Level = "22"
Inst1Quest5_Attain = "14"
Inst1Quest5_Aim = "T\195\182tet Edwin van Cleef und bringt seinen Kopf zu Gryan Stoutmantle."
Inst1Quest5_Location = "Gryan Stoutmantle (Westfall - Sp\195\164herkuppe; "..YELLOW.."56,47 "..WHITE..")"
Inst1Quest5_Note = "Diese Questreihe beginnt bei Gryan Stoutmantle (Westfall; 56,47).\nEdwin van Cleef ist der Endboss in den Todesminen. Man findet ihn oben auf dem Schiff [6]."
Inst1Quest5_Prequest = "Ja, Die Bruderschaft der Defias"
Inst1Quest5_Folgequest = "Ja, Der nie verschickte Brief"
Inst1Quest5PreQuest = "true"
--
Inst1Quest5name1 = "Westfall-Galoschen"
Inst1Quest5name2 = "Tunika von Westfall"
Inst1Quest5name3 = "Stab von Westfall"

--Quest 6 allianz

Inst1Quest6 = "6. Die Pr\195\188fung der Rechtschaffenheit (Paladin)"
Inst1Quest6_Level = "22"
Inst1Quest6_Attain = "20"
Inst1Quest6_Aim = "Sucht mit Jordans Waffennotizen etwas Wei\195\159steineichenholz, Bailors aufbereitete Erzlieferung, Jordans Schmiedehammer und einen Kor-Edelstein und bringt alles zusammen zu Jordan Stilwell in Ironforge."
Inst1Quest6_Location = "Jordan Stilwell (Dun Morogh - Ironforge Eingang "..YELLOW.."52,36 "..WHITE..")"
Inst1Quest6_Note = "Um die Notizen zu diesem Quest zu betrachten klick bitte auf [Die Pr\195\188fung der Rechtschaffenheit Informationen]."
Inst1Quest6_Prequest = "Ja, Der Foliant der Ehre -> Die Pr\195\188fung der Rechtschaffenheit"
Inst1Quest6_Folgequest = "Ja, Die Pr\195\188fung der Rechtschaffenheit"
Inst1Quest6PreQuest = "true"
--
Inst1Quest6name1 = "Verigans Faust"

Inst1Quest7 = "Die Pr\195\188fung der Rechtschaffenheit Informationen"
Inst1Quest7TEXT = "Nur Paladine k\195\182nnen diese Quest bekommen!\n1. Das Wei\195\159steineichenholz bekommt man von Goblin-Holzschnitzer in den [Todesminen].\n2. Um Bailors aufbereitete Erzlieferung zu bekommen muss man mit Bailor Stonehand (Loch Modan; 35,44 ) reden.  Er gibt einem die Quest 'Bailors Erzlieferung'. F\195\188r diese Quest muss man Jordans Erzlieferung finden. Sie ist bei 71,21 hinter einem Baum\n3. Jordans Schmiedehammer bekommt man in [Burg Shadowfang] nahe Punkt [B] (in den St\195\164llen).\n4. Den Kor-Edelstein bekommt man von Thundris Windweaver (Darkshore; 37,40) wenn man den Quest 'Suche nach dem Kor-Edelstein' macht. F\195\188r diese Quest muss man for den [Blackfathomtiefen] Blackfathom-Gezeitenpriesterin oder Blackfathom-Orakel t\195\182ten. Diese droppen den Verderbten Kor-Edelstein welchen Thundris Windweaver reinigt."
Inst1Quest7_Level = "100"
Inst1Quest7_Attain = ""
Inst1Quest7_Aim = ""
Inst1Quest7_Location = ""
Inst1Quest7_Note = ""
Inst1Quest7_Prequest = ""
Inst1Quest7_Folgequest = ""

--------------WaillingCaverns/HDW ( 7 quests)------------
Inst2Story = "Vor nicht allzu langer Zeit entdeckte ein nachtelfischer Druide namens Naralex eine Reihe unterirdischer Kavernen im Herzen des Brachlands. Er gab den H\195\182hlen des Wehklagens ihren Namen, da sich dort viele Risse im Boden befinden, durch die in regelm\195\164\195\159igen Abst\195\164nden hei\195\159er Dampf entweicht, wobei ein lang gezogenes, wehleidig klingenendes Heulen ert\195\182nt. Naralex glaubte, die unterirdischen Quellen der Kavernen dazu nutzen zu k\195\182nnen, das Brachland wieder gr\195\188n und fruchtbar zu machen. Um seinen mutigen Plan in die Tat umzusetzen, musste er zuerst die Energien des sagenumwobenen Smaragdgr\195\188nen Traums anzapfen. Sobald er sich in den Traum versetzte, geschah jedoch das Unfassbare: Seine Vision verwandelte sich in einen Alptraum! Kurz darauf fingen auch die H\195\182hlen des Wehklagens an, sich zu ver\195\164ndern. Das einst reine Quellwasser wurde faulig, und die zahmen Kreaturen vollzogen eine perverse Metamorphose, aus der sie als blutr\195\188nstige Monster hervorgingen. Man sagt, Naralex hielte sich immer noch in den H\195\182hlen auf, gefangen in seinem eigenen Smaragdgr\195\188nen Alptraum. Sogar die Gefolgsleute von Naralex wurden durch das Versagen ihres Meisters korrumpiert und in die grausamen Druiden des Fangzahns verwandelt."
Inst2Caption = "H\195\182hlen des Wehklagens"
Inst2QAA = "5 Quests"
Inst2QAH = "7 Quests"

--QUEST 1 Allianz

Inst2Quest1 = "1. Deviatb\195\164lge"
Inst2Quest1_Level = "17"
Inst2Quest1_Attain = "?"
Inst2Quest1_Aim = "Nalpak in den H\195\182hlen des Wehklagens m\195\182chte 20 Deviatb\195\164lge."
Inst2Quest1_Location = "Nalpak (Brachland - Die H\195\182hlen des Wehklagen; "..YELLOW.."47,36 "..WHITE..")"
Inst2Quest1_Note = "Nalpak befindet sich dirket \195\188ber dem Eingang in einer H\195\182hle.\nMan bekommt die B\195\164lge von allen Deviatgegnern vor und in der Instanz."
Inst2Quest1_Prequest = "Nein"
Inst2Quest1_Folgequest = "Nein"
--
Inst2Quest1name1 = "Clevere Deviatgamaschen"
Inst2Quest1name2 = "Deviathautpack"

--QUEST 2 Allianz

Inst2Quest2 = "2. \195\132rger auf den Docks"
Inst2Quest2_Level = "18"
Inst2Quest2_Attain = "14"
Inst2Quest2_Aim = "Kranf\195\188hrer Bigglefuzz in Ratchet m\195\182chte, dass Ihr Zausel dem Verr\195\188ckten, der sich in den H\195\182hlen des Wehklagens versteckt, die Flasche mit 99-j\195\164hrigem Portwein wieder abnehmt."
Inst2Quest2_Location = "Kranf\195\188hrer Bigglefuzz (Brachland - Ratchet; "..YELLOW.."63,37 "..WHITE..")"
Inst2Quest2_Note = "Den Portwein gibt es vor der Instanz von Zausel dem Verr\195\188ckten. Zausel ist schwer zu finden da er recht klein ist und getarnt herum l\195\164uft. Meist befindet er sich vom Eingang aus rechts gesehen in einer Einbuchtung oder links innerhalb der Sackgasse."
Inst2Quest2_Prequest = "Nein"
Inst2Quest2_Folgequest = "Nein"

--QUEST 3 Allianz

Inst2Quest3 = "3. Klugheitstr\195\164nke"
Inst2Quest3_Level = "18"
Inst2Quest3_Attain = "?"
Inst2Quest3_Aim = "Bringt 6 Portionen Klageessenz zu Mebok Mizzyrix in Ratchet."
Inst2Quest3_Location = "Mebok Mizzyrix (Das Brachland - Ratchet; "..YELLOW.."62,37 "..WHITE..")"
Inst2Quest3_Note = "Den Forquest bekomt man auch von Mebok Mizzyrix.\nDie Klageessenz droppen alle Ektoplasmagegener vor und in der Instanz."
Inst2Quest3_Prequest = "Ja, Raptorh\195\182rner"
Inst2Quest3_Folgequest = "Nein"
Inst2Quest3PreQuest = "true"

--QUEST 4 alliance

Inst2Quest4 = "4. Ausrottung der Deviat"
Inst2Quest4_Level = "21"
Inst2Quest4_Attain = "?"
Inst2Quest4_Aim = "Ebru in den H\195\182hlen des Wehklagens m\195\182chte, dass Ihr 7 Deviatverheerer, 7 Deviatvipern, 7 Deviatschlurfer und 7 Deviatschreckensfange t\195\182tet."
Inst2Quest4_Location = "Ebru (Brachland - Die H\194\182hlen des Wehklagen; "..YELLOW.."47,36 "..WHITE..")"
Inst2Quest4_Note = "Die gesuchten Gegner befinden sich alle innerhalb der Instanz. Der Questgeber befindet sich direkt \195\188ber dem Eingang in einer H\195\182hle."
Inst2Quest4_Prequest = "Nein"
Inst2Quest4_Folgequest = "Nein"
--
Inst2Quest4name1 = "Muster: Deviatschuppeng\195\188rtel"
Inst2Quest4name2 = "Schmorstecken"
Inst2Quest4name3 = "Moorlandstulpen"

--QUEST 5 Allianz

Inst2Quest5 = "5. Der leuchtende Splitter"
Inst2Quest5_Level = "25"
Inst2Quest5_Attain = "21"
Inst2Quest5_Aim = "Begebt Euch nach Ratchet, um jemanden zu finden, der Euch mehr \195\188ber den leuchtenden Splitter sagen kann. Liefert dann den Splitter ab, wie Ihr angewiesen wurdet."
Inst2Quest5_Location = "Der leuchtende Splitter(dropp) (Die H\195\182hlen des Wehklagen)"
Inst2Quest5_Note = "Den Splitter bekommt man, wenn man den Endboss Mutanus der Verchlinger t\195\182tet. Dieser erscheint nur, wenn man alle 4 Druiden gekillt und den Druiden am Eingang zu [9] gef\195\188hrt hat.\nSobald man den Splitter hat, muss man ihn nach Ratchet vor die Bank bringen und danach wieder zur\195\188ck zu dem Druiden(Falla Sagewind) oberhalb der H\195\182hlen des Wehklagens auf dem Berg."
Inst2Quest5_Prequest = "Nein"
Inst2Quest5_Folgequest = "Ja, Alptraum"
--
Inst2Quest5name1 = "Talbar-Mantel"
Inst2Quest5name2 = "Morastgaloschen"


--QUEST 1 horde

Inst2Quest1_HORDE = "1. Deviatb\195\164lge"
Inst2Quest1_HORDE_Level = "17"
Inst2Quest1_HORDE_Attain = "?"
Inst2Quest1_HORDE_Aim = "Nalpak in den H\195\182hlen des Wehklagens m\195\182chte 20 Deviatb\195\164lge."
Inst2Quest1_HORDE_Location = "Nalpak (Brachland - Die H\195\182hlen des Wehklagen; "..YELLOW.."47,36 "..WHITE..")"
Inst2Quest1_HORDE_Note = "Nalpak befindet sich dirket \195\188ber dem Eingang in einer H\195\182hle.\nMan bekommt die B\195\164lge von allen Deviatgegnern vor und in der Instanz."
Inst2Quest1_HORDE_Prequest = "Nein"
Inst2Quest1_HORDE_Folgequest = "Nein"
--
Inst2Quest1name1_HORDE = "Clevere Deviatgamaschen"
Inst2Quest1name2_HORDE = "Deviathautpack"

--QUEST 2 horde

Inst2Quest2_HORDE = "2. \195\132rger auf den Docks"
Inst2Quest2_HORDE_Level = "18"
Inst2Quest2_HORDE_Attain = "14"
Inst2Quest2_HORDE_Aim = "Kranf\195\188hrer Bigglefuzz in Ratchet m\195\182chte, dass Ihr Zausel dem Verr\195\188ckten, der sich in den H\195\182hlen des Wehklagens versteckt, die Flasche mit 99-j\195\164hrigem Portwein wieder abnehmt."
Inst2Quest2_HORDE_Location = "Kranf\195\188hrer Bigglefuzz (Brachland - Ratchet; "..YELLOW.."63,37 "..WHITE..")"
Inst2Quest2_HORDE_Note = "Den Portwein gibt es vor der Instanz von Zausel dem Verr\195\188ckten. Zausel ist schwer zu finden da er recht klein ist und getarnt herum l\195\164uft. Meist befindet er sich vom Eingang aus rechts gesehen in einer Einbuchtung oder links innerhalb der Sackgasse."
Inst2Quest2_HORDE_Prequest = "Nein"
Inst2Quest2_HORDE_Folgequest = "Nein"


--QUEST 3 horde

Inst2Quest3_HORDE = "3. Schlangenflaum"
Inst2Quest3_HORDE_Level = "18"
Inst2Quest3_HORDE_Attain = "14"
Inst2Quest3_HORDE_Aim = "Die Apothekerin Zamah in Thunder Bluff m\195\182chte, dass Ihr zehn Schlangenflaum f\195\188r sie sammelt."
Inst2Quest3_HORDE_Location = "Apothekerin Zamah (Thunder Bluff - Anh\195\182he der Geister; "..YELLOW.."22,20 "..WHITE..")"
Inst2Quest3_HORDE_Note = "Die Forquest bekommt man von Apotheker Helbrim (Brachland/Crossroad; 51,30).\nDer Schlangenflaum kann vor und in der Instanz gefunden werden. Characktere, die der Kr\195\164uterkudne m\195\164chtig sind, k\195\182nnen die Pflanzen auf der Minimap sehen."
Inst2Quest3_HORDE_Prequest = "Ja, Pilzsporen -> Apothekerin Zamah"
Inst2Quest3_HORDE_Folgequest = "Nein"
Inst2Quest3PreQuest_HORDE = "true"
--
Inst2Quest3name1_HORDE = "Apotheker-Handschuhe"

--QUEST 4 horde

Inst2Quest4_HORDE = "4. Klugheitstr\195\164nke"
Inst2Quest4_HORDE_Level = "18"
Inst2Quest4_HORDE_Attain = "?"
Inst2Quest4_HORDE_Aim = "Bringt 6 Portionen Klageessenz zu Mebok Mizzyrix in Ratchet."
Inst2Quest4_HORDE_Location = "Mebok Mizzyrix (Das Brachland - Ratchet; "..YELLOW.."62,37 "..WHITE..")"
Inst2Quest4_HORDE_Note = "Den Forquest bekomt man auch von Mebok Mizzyrix.\nDie Klageessenz droppen alle Ektoplasmagegener vor und in der Instanz."
Inst2Quest4_HORDE_Prequest = "Ja, Raptorh\195\182rner"
Inst2Quest4_HORDE_Folgequest = "Nein"
Inst2Quest4PreQuest_HORDE = "true"

--QUEST 5 horde

Inst2Quest5_HORDE = "5. Ausrottung der Deviat"
Inst2Quest5_HORDE_Level = "21"
Inst2Quest5_HORDE_Attain = "?"
Inst2Quest5_HORDE_Aim = "Ebru in den H\195\182hlen des Wehklagens m\195\182chte, dass Ihr 7 Deviatverheerer, 7 Deviatvipern, 7 Deviatschlurfer und 7 Deviatschreckensfange t\195\182tet."
Inst2Quest5_HORDE_Location = "Ebru (Brachland - Die H\195\182hlen des Wehklagen; "..YELLOW.."47,36 "..WHITE..")"
Inst2Quest5_HORDE_Note = "Die gesuchten Gegner befinden sich alle innerhalb der Instanz. Der Questgeber befindet sich direkt \195\188ber dem Eingang in einer H\195\182hle."
Inst2Quest5_HORDE_Prequest = "Nein"
Inst2Quest5_HORDE_Folgequest = "Nein"
--
Inst2Quest5name1_HORDE = "Muster: Deviatschuppeng\195\188rtel"
Inst2Quest5name2_HORDE = "Schmorstecken"
Inst2Quest5name3_HORDE = "Moorlandstulpen"

--QUEST 6 horde

Inst2Quest6_HORDE = "6. Anf\195\188hrer der Giftz\195\164hne (Questreihe)"
Inst2Quest6_HORDE_Level = "22"
Inst2Quest6_HORDE_Attain = "18"
Inst2Quest6_HORDE_Aim = "Bringt die Edelsteine von Kobrahn, Anacondra, Pythas und Serpentis nach Thunder Bluff zu Nara Wildmane."
Inst2Quest6_HORDE_Location = "Nara Wildmane (Thunder Bluff - Die Anh\195\182he der \195\164ltesten; "..YELLOW.."75,31 "..WHITE..")"
Inst2Quest6_HORDE_Note = "Die Questreihe f\195\164ngt bei Erzdruide Hamuul Runetotem (Thunderbluff; 78,28) an.\nDie Edelsteine werden von den 4 Druiden  [2],[3],[5],[7] gedroppt"
Inst2Quest6_HORDE_Prequest = "Ja, Die Oasen des Brachlandes -> Nara Wildmane"
Inst2Quest6_HORDE_Folgequest = "Nein"
Inst2Quest6PreQuest_HORDE = "true"
--
Inst2Quest6name1_HORDE = "Mondsichelstab"
Inst2Quest6name2_HORDE = "Fl\195\188gelklinge"

--QUEST 7 horde

Inst2Quest7_HORDE = "7. Der leuchtende Splitter"
Inst2Quest7_HORDE_Level = "25"
Inst2Quest7_HORDE_Attain = "21"
Inst2Quest7_HORDE_Aim = "Begebt Euch nach Ratchet, um jemanden zu finden, der Euch mehr \195\188ber den leuchtenden Splitter sagen kann. Liefert dann den Splitter ab, wie Ihr angewiesen wurdet."
Inst2Quest7_HORDE_Location = "Der leuchtende Splitter(dropp) (Die H\195\182hlen des Wehklagen)"
Inst2Quest7_HORDE_Note = "Den Splitter bekommt man, wenn man den Endboss Mutanus der Verchlinger t\195\182tet. Dieser erscheint nur, wenn man alle 4 Druiden gekillt und den Druiden am Eingang zu [9] gef\195\188hrt hat.\nSobald man den Splitter hat, muss man ihn nach Ratchet vor die Bank bringen und danach wieder zur\195\188ck zu dem Druiden(Falla Sagewind) oberhalb der H\195\182hlen des Wehklagens auf dem Berg."
Inst2Quest7_HORDE_Prequest = "Nein"
Inst2Quest7_HORDE_Folgequest = "Ja, Alptraum"
--
Inst2Quest7name1_HORDE = "Talbar-Mantel"
Inst2Quest7name2_HORDE = "Morastgaloschen"


--------------Uldaman ( 16 quests)------------
Inst4Story = "Uldaman ist ein uraltes titanisches Verlies, das seit der Zeit der Titanen tief unter der Erde verborgen lag. Vor Kurzem stie\195\159en die Zwerge bei ihren Ausgrabungen auf die vergessene Stadt, wobei sie die missgl\195\188ckten ersten Sch\195\182pfungen der Titanen entfesselten: Die Troggs. Der Legende nach erschufen die Titanen die Troggs aus Stein. Als sie sahen, dass ihre Sch\195\182pfung ein Fehlschlag war, verbannten sie die Troggs nach Uldaman und begannen von vorne. Das Ergebnis dieses zweiten Versuchs waren die Urahnen der heutigen Zwerge. Das Geheimnis der Entstehung der Zwerge ist auf den sagenumwobenen Scheiben von Norgannon festgehalten, gewaltigen titanischen Artefakten, die im Allerheiligsten der vergessenen Stadt Uldaman aufbewahrt werden. Die Zwerge des D\195\188stereisenklans haben damit begonnen, nach Uldaman vorzudringen, um die Scheiben f\195\188r ihren Meister zu stehlen, den Feuerf\195\188rsten Ragnaros. Die Stadt und die Scheiben werden jedoch von mehreren W\195\164chtern besch\195\188tzt, riesigen Gesch\195\182pfen aus lebendem Stein, die jeden ungl\195\188cklichen Eindringling zerquetschen, der ihnen \195\188ber den Weg l\195\164uft. Die Scheiben selbst werden von einem gewaltigen Steinw\195\164chter namens Archaedas bewacht, und einige, die aus Uldaman zur\195\188ckgekehrt sind, berichten von Begegnungen mit seltsamen Wesen, bei denen es sich aller Wahrscheinlichkeit um die steinh\195\164utigen Vorfahren der Zwerge handelt, die lange verloren geglaubten Irdenen."
Inst4Caption = "Uldaman"
Inst4QAA = "16 Quests"
Inst4QAH = "10 Quests"

--QUEST 1 Allianz

Inst4Quest1 = "1. Ein Hoffnungsschimmer"
Inst4Quest1_Level = "35"
Inst4Quest1_Attain = "35"
Inst4Quest1_Aim = "Sucht in Uldaman nach Hammertoe Grez."
Inst4Quest1_Location = "Ausgrabungsleiter Ryedol (Das \195\150dland; "..YELLOW.."53,43 "..WHITE..")"
Inst4Quest1_Note = "Der Vorquest startet bei der zerkn\195\188llten Notiz (Das \195\150dland; 53,33).\nHammertoe Grez befindet sich noch vor der Instanz (N\195\182rdlich des Instanztors; Westlicher Gang(Eingang))."
Inst4Quest1_Prequest = "Ja, Ein Hoffnungsschimmer"
Inst4Quest1_Folgequest = "Ja, Amulett der Geheimnisse"
Inst4Quest1PreQuest = "true"

--QUEST 2 Allianz

Inst4Quest2 = "2. Amulett der Geheimnisse"
Inst4Quest2_Level = "40"
Inst4Quest2_Attain = "?"
Inst4Quest2_Aim = "Sucht Hammertoes Amulett und bringt es ihm nach Uldaman."
Inst4Quest2_Location = "Hammertoe Grez (Uldaman - Vor der Instanz)"
Inst4Quest2_Note = "Das Amulett befindet sich vor der Instanz und zwar n\195\182rdlich des Instanztors, der \195\182stliche Gang gleich in der ersten Kammer."
Inst4Quest2_Prequest = "Ja, Ein Hoffnungsschimmer"
Inst4Quest2_Folgequest = "Ja, Ein Funken Hoffnung"

--QUEST 3 Allianz

Inst4Quest3 = "3. Die verlorene Tafel des Willens"
Inst4Quest3_Level = "45"
Inst4Quest3_Attain = "38"
Inst4Quest3_Aim = "Sucht die Tafel des Willens und bringt sie zu Berater Belgrum in Ironforge."
Inst4Quest3_Location = "Berater Belgrum (Ironforge; "..YELLOW.."77,10 "..WHITE..")"
Inst4Quest3_Note = "Die Tafel steht bei [8]."
Inst4Quest3_Prequest = "Ja, Amulett der Geheimnisse -> Ein Botschafter des B\195\182sen"
Inst4Quest3_Folgequest = "Nein"
--
Inst4Quest3name1 = "Medaille des Mutes"

--QUEST 4 Allianz

Inst4Quest4 = "4. Kraftsteine"
Inst4Quest4_Level = "36"
Inst4Quest4_Attain = "?"
Inst4Quest4_Aim = "Bringt Rigglefuzz im \195\182dland 8 Kraftsteine aus Dentrium und 8 Kraftsteine aus An'Alleum."
Inst4Quest4_Location = "Rigglefuzz (Das \195\150dland; "..YELLOW.."42:52 "..WHITE..")"
Inst4Quest4_Note = "Die Kraftsteine findet man bei allen Schattenschmiedegegnern vor und innerhalb der Instanz."
Inst4Quest4_Prequest = "Nein"
Inst4Quest4_Folgequest = "Nein"
--
Inst4Quest4name1 = "Energiegeladener Steinkreis"
Inst4Quest4name2 = "Duracin-Armschienen"
Inst4Quest4name3 = "Ewige Stiefel"

--QUEST 5 Allianz

Inst4Quest5 = "5. Agmonds Schicksal"
Inst4Quest5_Level = "38"
Inst4Quest5_Attain = "38"
Inst4Quest5_Aim = "Bringt Ausgrabungsleiter Ironband am Loch Modan 4 verzierte Steinurnen."
Inst4Quest5_Location = "Ausgrabungsleiter Ironband (Loch Modan - Der Loch; "..YELLOW.."65,65 "..WHITE..")"
Inst4Quest5_Note = "Die Forquest startet bei Prospector Stormpike (Ironforge; 74,12).\nDie Urnen findet man \195\188berall in der H\195\182hle vor der Instanz."
Inst4Quest5_Prequest = "Ja, Ironband sucht Euch! -> Murdaloc"
Inst4Quest5_Folgequest = "Nein"
Inst4Quest5PreQuest = "true"
--
Inst4Quest5name1 = "Ausgrabungsleiter-Handschuhe"

--QUEST 6 Allianz

Inst4Quest6 = "6. L\195\182sung der Verdammnis"
Inst4Quest6_Level = "40"
Inst4Quest6_Attain = "31"
Inst4Quest6_Aim = "Bringt Theldurin dem Verirrten die Schrifttafel von Ryun'eh."
Inst4Quest6_Location = "Theldurin dem Verirrten (Das \195\150dland; "..YELLOW.."51,76 "..WHITE..")"
Inst4Quest6_Note = "Die Schrifttafel befindet sich vor der Instanz. Um zu ihr zu gelangen muss man, n\195\182rdlich des Instanztors, dem \195\182stlichen Gang bis zum Ende folgen."
Inst4Quest6_Prequest = "Nein"
Inst4Quest6_Folgequest = "Ja, Auf nach Ironforge zu 'Yagyins Zusammenstellung'"
--
Inst4Quest6name1 = "Verdammnisverk\195\188nder-Robe"

--QUEST 7 Allianz

Inst4Quest7 = "7. Die verschollenen Zwerge"
Inst4Quest7_Level = "40"
Inst4Quest7_Attain = "?"
Inst4Quest7_Aim = "Sucht in Uldaman nach Baelog."
Inst4Quest7_Location = "Ausgrabungsleiter Stormpike (Das \195\150dland; "..YELLOW.."46,12 "..WHITE..")"
Inst4Quest7_Note = "Bealog findet man bei [1]."
Inst4Quest7_Prequest = "Nein"
Inst4Quest7_Folgequest = "Ja, Die geheime Kammer"

--QUEST 8 Allianz

Inst4Quest8 = "8. Die geheime Kammer"
Inst4Quest8_Level = "40"
Inst4Quest8_Attain = "?"
Inst4Quest8_Aim = "Lest Baelogs Tagebuch, erforscht die geheime Kammer und erstattet dann Ausgrabungsleiter Stormpike Bericht."
Inst4Quest8_Location = "Bealog (Uldaman - [1])"
Inst4Quest8_Note = "Die geheime Kammer ist bei [4]."
Inst4Quest8_Prequest = "Ja, Die verschollenen Zwerge"
Inst4Quest8_Folgequest = "Nein"
--
Inst4Quest8name1 = "Zwergenst\195\188rmer"
Inst4Quest8name2 = "Forscherliga-Erzaderstern"

--QUEST 9 Allianz

Inst4Quest9 = "9. Die zerrissene Halskette"
Inst4Quest9_Level = "41"
Inst4Quest9_Attain = "37"
Inst4Quest9_Aim = "Sucht nach dem Erschaffer der zerrissenen Halskette, um etwas \195\188ber ihren m\195\182glichen Wert zu erfahren."
Inst4Quest9_Location = "Zerrissene Halskette(random dropp) (Uldaman)"
Inst4Quest9_Note = "Man muss die Kette zu Talvash del Kissel nach Ironforge bringen(36,3)."
Inst4Quest9_Prequest = "Nein"
Inst4Quest9_Folgequest = "Ja, Lehren haben ihren Preis"

--QUEST 10 Allianz

Inst4Quest10 = "10. R\195\188ckkehr nach Uldaman"
Inst4Quest10_Level = "41"
Inst4Quest10_Attain = "37"
Inst4Quest10_Aim = "Sucht in Uldaman nach Hinweisen auf den momentanen Zustand von Talvashs Halskette. Der get\195\182tete Paladin, den Talvash erw\195\164hnte, hatte die Kette zuletzt."
Inst4Quest10_Location = "Talvash del Kissel (Ironforge; "..YELLOW.."36,3 "..WHITE..")"
Inst4Quest10_Note = "Der Paladin befindet sich bei [2]."
Inst4Quest10_Prequest = "Ja, Lehren haben ihren Preis"
Inst4Quest10_Folgequest = "Ja, Suche nach den Edelsteinen"

--QUEST 11 Allianz

Inst4Quest11 = "11. Suche nach den Edelsteinen"
Inst4Quest11_Level = "43"
Inst4Quest11_Attain = "37"
Inst4Quest11_Aim = "Findet den Rubin, den Saphir und den Topas, die in ganz Uldaman verstreut sind. Wenn Ihr sie habt, wendet Euch aus der Ferne an Talvash del Kissel, indem Ihr die Wahrsagephiole nutzt, die er Euch zuvor gegeben hat."
Inst4Quest11_Location = "Zerrissene Halskette/der tote Paladin (Uldaman)"
Inst4Quest11_Note = "Die Edelsteine befinden sich bei [1], [8], [9]."
Inst4Quest11_Prequest = "Ja, R\195\188ckkehr nach Uldaman"
Inst4Quest11_Folgequest = "Ja, Restaurierung der Halskette"

--QUEST 12 Allianz

Inst4Quest12 = "12. Restaurierung der Halskette"
Inst4Quest12_Level = "44"
Inst4Quest12_Attain = "38"
Inst4Quest12_Aim = "Besorgt Euch eine Kraftquelle vom m\195\164chtigsten Konstrukt, das Ihr in Uldaman finden k\195\182nnt, und liefert sie bei Talvash del Kissel in Ironforge ab"
Inst4Quest12_Location = "Talvashs Wahrsageschale"
Inst4Quest12_Note = "Die Kraftquelle findet man beim Endboss Archaedas [10](Unten)."
Inst4Quest12_Prequest = "Ja, Suche nach den Edelsteinen"
Inst4Quest12_Folgequest = "Nein" -- AUFPASSEN HIER IS EIN FOLGEQUEST ABER ES GIBT NUR BELOHNUNG!
--
Inst4Quest12name1 = "Talvashs verst\195\164rkende Halskette"

--QUEST 13 Allianz

Inst4Quest13 = "13. Reagenzsuche in Uldaman"
Inst4Quest13_Level = "42"
Inst4Quest13_Attain = "38"
Inst4Quest13_Aim = "Bringt zw\195\182lf magenta Funguskappen nach Thelsamar zu Ghak Healtouch."
Inst4Quest13_Location = "Ghak Healtouch (Loch Modan; "..YELLOW.."37,49 "..WHITE..")"
Inst4Quest13_Note = "Die Pilze wachsen \195\188berall in Uldaman."
Inst4Quest13_Prequest = "Nein"
Inst4Quest13_Folgequest = "Nein"
--
Inst4Quest13name1 = "Regenerationstrank"

--QUEST 14 Allianz

Inst4Quest14 = "14. Wiederbeschaffte Sch\195\164tze"
Inst4Quest14_Level = "43"
Inst4Quest14_Attain = "?"
Inst4Quest14_Aim = "Holt Krom Stoutarms wertvollen Besitz aus seiner Truhe in der n\195\182rdlichen Bankenhalle von Uldaman und bringt den Schatz zu ihm nach Ironforge."
Inst4Quest14_Location = "Krom Stoutarms (Ironforge; "..YELLOW.."74,9 "..WHITE..")"
Inst4Quest14_Note = "Der Schatz befindet sich vor der Instanz. Um zu ihm zu gelangen l\195\164uft man n\195\182rdlich des Instanztors in den \195\182stlichen Gang und nimmt die s\195\188d/\195\182stliche Abzweigung."
Inst4Quest14_Prequest = "Nein"
Inst4Quest14_Folgequest = "Nein"


--QUEST 15 Allianz

Inst4Quest15 = "15. Die Platinscheiben"
Inst4Quest15_Level = "45"
Inst4Quest15_Attain = "40"
Inst4Quest15_Aim = "Sprecht mit dem Steinbeh\195\188ter und findet heraus, welche uralten Lehren er aufbewahrt. Sobald Ihr alles erfahren habt, was er wei\195\159, aktiviert die Scheiben von Norgannon. -> Bringt die Miniaturausgabe der Scheiben von Norgannon zur Forscherliga nach Ironforge."
Inst4Quest15_Location = "Die Platinscheibe (Uldaman - [11])"
Inst4Quest15_Note = "Nachdem ihr den Quest erhalten habt, m\195\188sst ihr mit dem Geist links von der Scheibe sprechen. Danach benutzt ihr nochmal die Platinscheibe und bekommt eine Miniaturscheibe die ihr zu Hochforscher Magellas in Ironforge(69,18) bringen sollt."
Inst4Quest15_Prequest = "Nein"
Inst4Quest15_Folgequest = "Nein"
--
Inst4Quest15name1 = "Thawpelt Sack"
Inst4Quest15name2 = "\195\156berragender Heiltrank"
Inst4Quest15name3 = "Gro\195\159er Manatrank"

--QUEST 16 Allianz

Inst4Quest16 = "16. Macht in Uldaman (Magier)"
Inst4Quest16_Level = "40"
Inst4Quest16_Attain = "35"
Inst4Quest16_Aim = "Beschafft Euch eine Obsidiankraftquelle und bringt sie in die Marschen von Dustwallow zu Tabetha."
Inst4Quest16_Location = "Tabetha ( Die Marschen von Dusrwallow; "..YELLOW.."46,57 "..WHITE..")"
Inst4Quest16_Note = "Dieser Quest ist nur f\195\188r Magier verf\195\188gbar. Die Obsidiankraftquelle wird von der  Obsidian-Schildwache bei [5] gedroppt."
Inst4Quest16_Prequest = "Ja, Die Austreibung"
Inst4Quest16_Folgequest = "Ja, Manawogen"
Inst4Quest16PreQuest = "true"

--QUEST 1 Horde

Inst4Quest1_HORDE = "1. Kraftsteine"
Inst4Quest1_HORDE_Level = "36"
Inst4Quest1_HORDE_Attain = "?"
Inst4Quest1_HORDE_Aim = "Bringt Rigglefuzz im \195\182dland 8 Kraftsteine aus Dentrium und 8 Kraftsteine aus An'Alleum."
Inst4Quest1_HORDE_Location = "Rigglefuzz (Das \195\150dland; "..YELLOW.."42:52 "..WHITE..")"
Inst4Quest1_HORDE_Note = "Die Kraftsteine finden sie bei allen Schattenschmiedegegnern vor und innerhalb von Uldaman."
Inst4Quest1_HORDE_Prequest = "Nein"
Inst4Quest1_HORDE_Folgequest = "Nein"
--
Inst4Quest1name1_HORDE = "Energiegeladener Steinkreis"
Inst4Quest1name2_HORDE = "Duracin-Armschienen"
Inst4Quest1name3_HORDE = "Ewige Stiefel"

--QUEST 2 Horde

Inst4Quest2_HORDE = "2. L\195\182sung der Verdammnis"
Inst4Quest2_HORDE_Level = "40"
Inst4Quest2_HORDE_Attain = "31"
Inst4Quest2_HORDE_Aim = "Bringt Theldurin dem Verirrten die Schrifttafel von Ryun'eh."
Inst4Quest2_HORDE_Location = "Theldurin dem Verirrten (Das \195\150dland; "..YELLOW.."51,76 "..WHITE..")"
Inst4Quest2_HORDE_Note = "Die Schrifttafel befindet sich vor der Instanz. Um zu ihr zu gelangen muss man, n\195\182rdlich des Instanztors, den \195\182stlichen Gang bis zum Ende folgen."
Inst4Quest2_HORDE_Prequest = "Nein"
Inst4Quest2_HORDE_Folgequest = "Ja, Auf nach Ironforge zu 'Yagyins Zusammenstellung'"
--
Inst4Quest2name1_HORDE = "Verdammnisverk\195\188nder-Robe"

--QUEST 3 Horde

Inst4Quest3_HORDE = "3. Wiederbeschaffung der Halskette"
Inst4Quest3_HORDE_Level = "41"
Inst4Quest3_HORDE_Attain = "37"
Inst4Quest3_HORDE_Aim = "Sucht in der Grabungsst\195\164tte von Uldaman nach einer wertvollen Halskette und bringt sie nach Orgrimmar zu Dran Droffers. Die Halskette ist vielleicht besch\195\164digt."
Inst4Quest3_HORDE_Location = "Dran Droffers (Orgrimmar; "..YELLOW.."59,36 "..WHITE..")"
Inst4Quest3_HORDE_Note = "Die Halskette ist ein Randomdrop innerhalb der Instanz."
Inst4Quest3_HORDE_Prequest = "Nein"
Inst4Quest3_HORDE_Folgequest = "Ja, Wiederbeschaffung der Halskette, Teil 2"

--QUEST 4 Horde

Inst4Quest4_HORDE = "4. Wiederbeschaffung der Halskette, Teil 2"
Inst4Quest4_HORDE_Level = "41"
Inst4Quest4_HORDE_Attain = "38"
Inst4Quest4_HORDE_Aim = "Sucht in den Tiefen von Uldaman nach einem Hinweis auf den Verbleib der Edelsteine."
Inst4Quest4_HORDE_Location = "Dran Droffers (Orgrimmar; "..YELLOW.."59,36 "..WHITE..")"
Inst4Quest4_HORDE_Note = "Der Paladin befindet sich bei [2]."
Inst4Quest4_HORDE_Prequest = "Ja, Wiederbeschaffung der Halskette"
Inst4Quest4_HORDE_Folgequest = "Ja, \195\156bersetzung des Tagebuchs"

--QUEST 5 Horde

Inst4Quest5_HORDE = "5. \195\156bersetzung des Tagebuchs"
Inst4Quest5_HORDE_Level = "42"
Inst4Quest5_HORDE_Attain = "40"
Inst4Quest5_HORDE_Aim = "Sucht jemanden, der das Tagebuch des Paladins \195\188bersetzen kann. Der n\195\164chstgelegene Ort, wo Ihr so jemanden finden k\195\182nntet, ist Kargath im \195\182dland."
Inst4Quest5_HORDE_Location = "Der tote Paladin (Uldaman - [2])"
Inst4Quest5_HORDE_Note = "Der \195\188bersetzer(Jarkal Mossmeld) befindet sich in Kargath(2, 46)."
Inst4Quest5_HORDE_Prequest = "Ja, Wiederbeschaffung der Halskette, Teil 2"
Inst4Quest5_HORDE_Folgequest = "Ja, Findet die Edelsteine und die Kraftquelle"

--QUEST 6 Horde

Inst4Quest6_HORDE = "6. Findet die Edelsteine und die Kraftquelle"
Inst4Quest6_HORDE_Level = "44"
Inst4Quest6_HORDE_Attain = "37"
Inst4Quest6_HORDE_Aim = "Beschafft in Uldaman alle drei Edelsteine sowie eine Kraftquelle f\195\188r die Halskette und bringt sie anschlie\195\159end zu Jarkal Mossmeld nach Kargath. Jarkal glaubt, dass sich eine Kraftquelle vielleicht im st\195\164rksten Konstrukt in Uldaman findet."
Inst4Quest6_HORDE_Location = "Jarkal Mossmeld (Das \195\150dland - Kargath; "..YELLOW.."2, 46"..WHITE..")"
Inst4Quest6_HORDE_Note = "Die Edelsteine befinden sich bei [1], [8] und [9]. Die Kraftquelle ist beim Endboss Archaedas [10](Unten)."
Inst4Quest6_HORDE_Prequest = "Ja, \195\156bersetzung des Tagebuchs"
Inst4Quest6_HORDE_Folgequest = "Ja, Ablieferung der Edelsteine"
--
Inst4Quest6name1_HORDE = "Jarkals intensivierende Halskette"

--QUEST 7 Horde

Inst4Quest7_HORDE = "7. Reagenzsuche in Uldaman"
Inst4Quest7_HORDE_Level = "42"
Inst4Quest7_HORDE_Attain = "38"
Inst4Quest7_HORDE_Aim = "Bringt 12 magenta Funguskappen nach Kargath zu Jarkal Mossmeld."
Inst4Quest7_HORDE_Location = "Jarkal Mossmeld (Das \195\150dland - Kargath; "..YELLOW.."2,69 "..WHITE..")"
Inst4Quest7_HORDE_Note = "Die Forquest bekommt man auch von Jarkal Mossmel\nDie Pilze wachsen \195\188berall in Uldaman."
Inst4Quest7_HORDE_Prequest = "Ja, Reagenzien-Suche im \195\150dland"
Inst4Quest7_HORDE_Folgequest = "Ja, Reagenzien-Suche im \195\150dland II"
Inst4Quest7PreQuest_HORDE = "true"
--
Inst4Quest7name1_HORDE = "Regenerationstrank"

--QUEST 8 Horde

Inst4Quest8_HORDE = "8. Wiederbeschaffte Sch\195\164tze"
Inst4Quest8_HORDE_Level = "43"
Inst4Quest8_HORDE_Attain = "?"
Inst4Quest8_HORDE_Aim = "Holt Patrick Garretts Familienschatz aus der Truhe der Familie in der s\195\188dlichen Bankenhalle von Uldaman und bringt diesen zu ihm nach Undercity."
Inst4Quest8_HORDE_Location = "Patrick Garrett (Undercity; "..YELLOW.."72,48 "..WHITE..")"
Inst4Quest8_HORDE_Note = "Der Schatz befindet sich vor der Instanz. Um zu ihm zu gelangen muss man dem Gang s\195\188dlich des Instanztors, bis zum Ende folgen."
Inst4Quest8_HORDE_Prequest = "Nein"
Inst4Quest8_HORDE_Folgequest = "Nein"


--QUEST 9 Horde

Inst4Quest9_HORDE = "9. Die Platinscheiben"
Inst4Quest9_HORDE_Level = "45"
Inst4Quest9_HORDE_Attain = "40"
Inst4Quest9_HORDE_Aim = "Sprecht mit dem Steinbeh\195\188ter und findet heraus, welche uralten Lehren er aufbewahrt. Sobald Ihr alles erfahren habt, was er wei\195\159, aktiviert die Scheiben von Norgannon. -> Bringt die Miniaturausgabe der Scheiben von Norgannon zu einem der Weisen von Thunder Bluff."
Inst4Quest9_HORDE_Location = "Die Platinscheibe (Uldaman - [11])"
Inst4Quest9_HORDE_Note = "Nachdem ihr den Quest erhalten habt m\195\188sst ihr mit dem Geist links von der Scheibe sprechen. Danach benutzt ihr nochmal die Platinscheibe und bekommt eine Miniaturscheibe die ihr zu Sage Truthseeker in Thunderbluff (34,46) bringen sollt."
Inst4Quest9_HORDE_Prequest = "Nein"
Inst4Quest9_HORDE_Folgequest = "Nein"
--
Inst4Quest9name1_HORDE = "Thawpelt Sack"
Inst4Quest9name2_HORDE = "\195\156berragender Heiltrank"
Inst4Quest9name3_HORDE = "Gro\195\159er Manatrank"

--QUEST 10 Horde

Inst4Quest10_HORDE = "10. Macht in Uldaman (Magier)"
Inst4Quest10_HORDE_Level = "40"
Inst4Quest10_HORDE_Attain = "35"
Inst4Quest10_HORDE_Aim = "Beschafft Euch eine Obsidiankraftquelle und bringt sie in die Marschen von Dustwallow zu Tabetha."
Inst4Quest10_HORDE_Location = "Tabetha ( Die Marschen von Dusrwallow; "..YELLOW.."46,57 "..WHITE..")"
Inst4Quest10_HORDE_Note = "Dieser Quest ist nur f\195\188r Magier verf\195\188gbar!\nDie Obsidiankraftquelle wird von der  Obsidian-Schildwache bei [5] gedroppt."
Inst4Quest10_HORDE_Prequest = "Ja, Die Austreibung"
Inst4Quest10_HORDE_Folgequest = "Ja, Manawogen"
Inst4Quest10PreQuest_HORDE = "true"

--------------------------Ragfire ( 5 Quests)
Inst3Story = "Der Ragefireabgrund besteht aus einer Reihe vulkanischer H\195\182hlen, die unter Orgrimmar verlaufen, der neuen Hauptstadt der Orcs. Vor nicht allzulanger Zeit soll sich in den feurigen Tiefen ein Kult eingenistet haben, der dem d\195\164monischen Schattenrat nahe steht. Dieser Kult, der sich selbst die Burning Blade nennt, stellt eine direkte Bedrohung der Unabh\195\164ngigkeit von Orgrimmar dar. Viele glauben, dass Kriegsh\195\164uptling Thrall die Burning Blade nur deshalb nicht sofort ausl\195\182scht, weil er sich erhofft, dass sie ihn direkt zu seinem wahren Feind f\195\188hren werden, dem mysteri\195\182sen Schattenrat selbst. Dennoch k\195\182nnten die dunklen M\195\164chte, die sich im Ragefireabgrund sammeln, alles zerst\195\182ren, was die Orcs mit so viel Blut und Leid erk\195\164mpft haben."
Inst3Caption = "Der Ragefireabgrund"
Inst3QAA = "keine Quests"
Inst3QAH = "5 Quests"

--QUEST 1 Horde

Inst3Quest1_HORDE = "1. Die Kraft des Feindes wird auf die Probe gestellt"
Inst3Quest1_HORDE_Level = "15"
Inst3Quest1_HORDE_Attain = "?"
Inst3Quest1_HORDE_Aim = "Sucht in Orgrimmar nach dem Ragefireabgrund, t\195\182tet dann 8 Ragefire-Troggs und 8 Ragefire-Schamanen und kehrt anschlie\195\159end zu Rahauro in Thunder Bluff zur\195\188ck."
Inst3Quest1_HORDE_Location = "Rahauro ( Thunder Bluff - Anh\195\182he der \195\132ltesten; "..YELLOW.."70,29 "..WHITE..")"
Inst3Quest1_HORDE_Note = "Die Troggs findet man am Anfang der Instanz."
Inst3Quest1_HORDE_Prequest = "Nein"
Inst3Quest1_HORDE_Folgequest = "Nein"

--QUEST 2 Horde

Inst3Quest2_HORDE = "2. Die Macht der Zerst\195\182rung..."
Inst3Quest2_HORDE_Level = "16"
Inst3Quest2_HORDE_Attain = "?"
Inst3Quest2_HORDE_Aim = "Bringt die B\195\188cher 'Schattenzauber' und 'Zauberformeln aus dem Nether' zu Varimathras nach Undercity."
Inst3Quest2_HORDE_Location = "Varimathras ( Undercity; "..YELLOW.."56,92 "..WHITE..")"
Inst3Quest2_HORDE_Note = "Die Searingbalde-Kultisten und Hexenmeister droppen die B\195\188cher"
Inst3Quest2_HORDE_Prequest = "Nein"
Inst3Quest2_HORDE_Folgequest = "Nein"
--
Inst3Quest2name1_HORDE = "Garstige Beinkleider"
Inst3Quest2name2_HORDE = "Gamaschen des Sumpfgr\195\164bers"
Inst3Quest2name3_HORDE = "Gargoylegamaschen"

--QUEST 3 Horde

Inst3Quest3_HORDE = "3. Die Suche nach dem verloren gegangenen Ranzen"
Inst3Quest3_HORDE_Level = "16"
Inst3Quest3_HORDE_Attain = "?"
Inst3Quest3_HORDE_Aim = "Sucht im Ragefireabgrund nach Maur Grimmtotems Leiche und durchsucht sie nach interessanten Gegenst\195\164nden."
Inst3Quest3_HORDE_Location = "Rahauro ( Thunder Bluff - Anh\195\182he der \195\132ltesten; "..YELLOW.."70,29 "..WHITE..")"
Inst3Quest3_HORDE_Note = "Maur Grimmtotem kann man bei [1] finden. Danach muss man den Ranzen zur\195\188ck zu Rahauro in Thunder Bluff bringen."
Inst3Quest3_HORDE_Prequest = "Nein"
Inst3Quest3_HORDE_Folgequest = "Ja, Wiederbeschaffung des verloren gegangenen Ranzens"
--
Inst3Quest3name1_HORDE = "Federleichte Armschienen"
Inst3Quest3name2_HORDE = "Savannenarmschienen"

--QUEST 4 Horde

Inst3Quest4_HORDE = "4. Verborgene Feinde"
Inst3Quest4_HORDE_Level = "16"
Inst3Quest4_HORDE_Attain = "?"
Inst3Quest4_HORDE_Aim = "T\195\182tet Bazzalan und Jergosh den Herbeirufer, bevor Ihr zu Thrall nach Orgrimmar zur\195\188ckkehrt."
Inst3Quest4_HORDE_Location = "Thrall ( Orgrimmar; "..YELLOW.."31,37 "..WHITE..")"
Inst3Quest4_HORDE_Note = "Bazzalan findet man bei [4] und Jergosh bei [3]."
Inst3Quest4_HORDE_Prequest = "Ja, Verborgene Feinde"
Inst3Quest4_HORDE_Folgequest = "Ja, Verborgene Feinde"
Inst3Quest4PreQuest_HORDE = "true"
--
Inst3Quest4name1_HORDE = "Kris von Orgrimmar"
Inst3Quest4name2_HORDE = "Hammer von Orgrimmar"
Inst3Quest4name3_HORDE = "Axt von Orgrimmar"
Inst3Quest4name4_HORDE = "Stab von Orgrimmar"

--QUEST 5 Horde

Inst3Quest5_HORDE = "5. Vernichtung der Bestie"
Inst3Quest5_HORDE_Level = "16"
Inst3Quest5_HORDE_Attain = "?"
Inst3Quest5_HORDE_Aim = "Begebt Euch in den Ragefireabgrund und erschlagt Taragaman den Hungerleider. Bringt anschlie\195\159end dessen Herz zu Neeru Fireblade nach Orgrimmar."
Inst3Quest5_HORDE_Location = "Neeru Fireblade ( Orgrimmar - Kluft der Schatten; "..YELLOW.."49,50 "..WHITE..")"
Inst3Quest5_HORDE_Note = "Taragaman findet man bei [2]."
Inst3Quest5_HORDE_Prequest = "Nein"
Inst3Quest5_HORDE_Folgequest = "Nein"

--------------------------Inst27 / Zul'Farak /ZUL (7 quest)
Inst27Story = "Unter der brennenden Sonne von Tanaris liegt die Hauptstadt der Trolle des Sandfuryclans, die wegen ihrer Ruchlosigkeit und Grausamkeit gef\195\188rchtet sind. Die Legenden der Trolle erz\195\164hlen von einem m\195\164chtigen Schwert namens Sul'thraze dem Peitscher, einer Waffe, die selbst den gef\195\164hrlichsten Gegner mit Angst und Schrecken erf\195\188llen kann. Vor langer Zeit wurde die Waffe in zwei Teile gespalten, doch es halten sich hartn\195\164ckige Ger\195\188chte, dass sich beide H\195\164lften irgendwo in Zul'Farrak befinden. Es gibt Berichte, dass eine Gruppe von S\195\182ldnern, die aus Gadgetzan fliehen mussten, die Stadt betraten und pl\195\182tzlich dort gefangen waren. \195\156ber ihr Schicksal ist nichts weiter bekannt. Doch noch viel bedenkniserregender erscheinen die nur unter vorgehaltener Hand \195\188berlieferten Erz\195\164hlungen von einer uralten Kreatur, die in den heiligen Wassern im Herzen der Stadt schlummern soll – ein m\195\164chtiger Halbgott, der jeden vernichten wird, der t\195\182richt genug ist, ihn aus seinem Schlaf zu wecken."
Inst27Caption = "Zul'Farrak"
Inst27QAA = "7 Quests"
Inst27QAH = "7 Quests"



--QUEST 1 Allianz

Inst27Quest1 = "1. Trollaush\195\164rter"
Inst27Quest1_Level = "45"
Inst27Quest1_Attain = "?"
Inst27Quest1_Aim = "Bringt 20 Phiolen Trollaush\195\164rter zu Trenton Lighthammer in Gadgetzan."
Inst27Quest1_Location = "Trenton Lighthammer (Tanaris - Gadgetzan; "..YELLOW.."51,28 "..WHITE..")"
Inst27Quest1_Note = "Alle Trolle droppen Trollaush\195\164rter"
Inst27Quest1_Prequest = "Nein"
Inst27Quest1_Folgequest = "Nein"

--QUEST 2 Allianz

Inst27Quest2 = "2. Skarab\195\164uspanzerschalen"
Inst27Quest2_Level = "45"
Inst27Quest2_Attain = "?"
Inst27Quest2_Aim = "Bringt Tran'rek in Gadgetzan 5 unbesch\195\164digte Skarab\195\164uspanzerschalen."
Inst27Quest2_Location = "Tran'rek (Tanaris - Gadgetzan; "..YELLOW.."51,26 "..WHITE..")"
Inst27Quest2_Note = "Die Vorquest startet bei Krazek (Schlingendorntal(Booty Bay); 25,77 ).\nAlle Skarab\195\164usk\195\164fer droppen die Schalen. Besonders viele findet man bei [2]."
Inst27Quest2_Prequest = "Ja, Tran'rek"
Inst27Quest2_Folgequest = "Nein"


--QUEST 3 Allianz

Inst27Quest3 = "3. Tiara der Tiefen"
Inst27Quest3_Level = "46"
Inst27Quest3_Attain = "40"
Inst27Quest3_Aim = "Bringt die Tiara der Tiefen zu Tabetha in den Marschen von Dustwallow."
Inst27Quest3_Location = "Tabetha (Die Marschen von Dustwallow; "..YELLOW.."46,57 "..WHITE..")"
Inst27Quest3_Note = "Du bekommst die Vorquest von Bink (Ironforge; 25,8).\nWasserbeschw\195\182rerin Velratha droppt Die Tiara der Tiefen. Man findet sie bei [6]."
Inst27Quest3_Prequest = "Ja, Tabethas Aufgabe"
Inst27Quest3_Folgequest = "Nein"
--
Inst27Quest3name1 = "Zauberformerrute"
Inst27Quest3name2 = "Edelsteinschiefer-Schulterst\195\188cke"

--QUEST 4 Allianz

Inst27Quest4 = "4. Nekrums Medaillon (Questreihe)"
Inst27Quest4_Level = "47"
Inst27Quest4_Attain = "40"
Inst27Quest4_Aim = "Bringt Thadius Grimshade in den verw\195\188steten Landen Nekrums Medaillon."
Inst27Quest4_Location = "Thadius Grimshade (Die Verw\195\188steten Landen; "..YELLOW.."66,19 "..WHITE..")"
Inst27Quest4_Note = "Die Questreihe startet bei Gryphon Master Talonaxe (The Hinterlands; 9,44).\nMan findet Nekrum bei [4] nachdem das Tempelevent zu Ende ist."
Inst27Quest4_Prequest = "Ja, K\195\164fige der Witherbark -> Thadius Grimshade"
Inst27Quest4_Folgequest = "Ja, Der Rutengang"

--QUEST 5 Allianz

Inst27Quest5 = "5. Die Prophezeiung von Mosh'aru (Questreihe)"
Inst27Quest5_Level = "47"
Inst27Quest5_Attain = "40"
Inst27Quest5_Aim = "Bringt die erste und die zweite Mosh'aru-Schrifttafel zu Yeh'kinya nach Tanaris."
Inst27Quest5_Location = "Yeh'kinya (Tanaris; "..YELLOW.."66,22 "..WHITE..")"
Inst27Quest5_Note = "Man findet die Schrifttafeln bei [2] und [6]."
Inst27Quest5_Prequest = "Ja, Kreischergeister"
Inst27Quest5_Folgequest = "Ja, Das uralte Ei"

--QUEST 6 Allianz

Inst27Quest6 = "6. W\195\188nschel-mato-Rute"
Inst27Quest6_Level = "46"
Inst27Quest6_Attain = "?"
Inst27Quest6_Aim = "Bringt die W\195\188nschel-mato-Rute nach Gadgetzan zu Chefingenieur Bilgewhizzle."
Inst27Quest6_Location = "Chefingenieur Bilgewhizzle (Tanaris - Gadgetzan; "..YELLOW.."52,28 "..WHITE..")"
Inst27Quest6_Note = "Man findet die Rute bei Seargent Bly der sich nach dem Tempelevent bei [4] aufh\195\164llt."
Inst27Quest6_Prequest = "Nein"
Inst27Quest6_Folgequest = "Nein"
--
Inst27Quest6name1 = "Maurer-Bruderschaftsring"
Inst27Quest6name2 = "Ingenieursgildenkopfst\195\188ck"


--QUEST 7 Allianz

Inst27Quest7 = "7. Gahz'rilla"
Inst27Quest7_Level = "50"
Inst27Quest7_Attain = "40"
Inst27Quest7_Aim = "Bringt Wizzle Brassbolts in der schimmernden Ebene Gahz'rillas energiegeladene Schuppe."
Inst27Quest7_Location = "Wizzle Brassbolts (Thousands Needles; "..YELLOW.."78,77 "..WHITE..")"
Inst27Quest7_Note = "Man bekommt die Vorquest von Klockmort Spannerspan(Ironforge; 68,46).\nGahz'rilla kann man bei [6] beschw\195\182ren. Dazu ben\195\182tigt man den Schlaghammer von Zul'Farrak, den man im Hinterland herstellen kann."
Inst27Quest7_Prequest = "Ja, Die Br\195\188der Brassbolt"
Inst27Quest7_Folgequest = "Nein"
--
Inst27Quest7name1 = "Karotte am Stiel"


--QUEST 1 Horde

Inst27Quest1_HORDE = "1. Der Spinnengott (Questreihe)"
Inst27Quest1_HORDE_Level = "45"
Inst27Quest1_HORDE_Attain = "42"
Inst27Quest1_HORDE_Aim = "Lest von der Schrifttafel des Theka, um den Namen des Spinnengottes der Witherbark zu erfahren, und kehrt dann zu Meister Gadrin zur\195\188ck."
Inst27Quest1_HORDE_Location = "Meister Gadrin ( Durotar; "..YELLOW.."55,74 "..WHITE..")"
Inst27Quest1_HORDE_Note = "Die Questreihe beginnt bei einer Giftflaschen (Hinterland, in den Trolld\195\182rfern zu finden).\nDie Schrifttaffel findet man bei [2]."
Inst27Quest1_HORDE_Prequest = "Ja, Giftflaschen -> Konsultiert Meister Gadrin"
Inst27Quest1_HORDE_Folgequest = "Ja, Die Beschw\195\182rung von Shadra"

--QUEST 2 Horde

Inst27Quest2_HORDE = "2. Trollaush\195\164rter"
Inst27Quest2_HORDE_Level = "45"
Inst27Quest2_HORDE_Attain = "?"
Inst27Quest2_HORDE_Aim = "Bringt 20 Phiolen Trollaush\195\164rter zu Trenton Lighthammer in Gadgetzan."
Inst27Quest2_HORDE_Location = "Trenton Lighthammer (Tanaris - Gadgetzan; "..YELLOW.."52,28 "..WHITE..")"
Inst27Quest2_HORDE_Note = "Alle Trolle droppen Trollaush\195\164rter"
Inst27Quest2_HORDE_Prequest = "Nein"
Inst27Quest2_HORDE_Folgequest = "Nein"

--QUEST 3 Horde

Inst27Quest3_HORDE = "3. Skarab\195\164uspanzerschalen"
Inst27Quest3_HORDE_Level = "45"
Inst27Quest3_HORDE_Attain = "?"
Inst27Quest3_HORDE_Aim = "Bringt Tran'rek in Gadgetzan 5 unbesch\195\164digte Skarab\195\164uspanzerschalen."
Inst27Quest3_HORDE_Location = "Tran'rek (Tanaris - Gadgetzan; "..YELLOW.."51,36 "..WHITE..")"
Inst27Quest3_HORDE_Note = "Die Vorquest startet bei Krazek (Schlingendorntal(Booty Bay); 25,77 ).\nAlle Skarab\195\164usk\195\164fer droppen die Schalen. Besonders viele findet man bei [2]."
Inst27Quest3_HORDE_Prequest = "Ja, Tran'rek"
Inst27Quest3_HORDE_Folgequest = "Nein"

--QUEST 4 Horde

Inst27Quest4_HORDE = "4. Tiara der Tiefen"
Inst27Quest4_HORDE_Level = "46"
Inst27Quest4_HORDE_Attain = "40"
Inst27Quest4_HORDE_Aim = "Bringt die Tiara der Tiefen zu Tabetha in den Marschen von Dustwallow."
Inst27Quest4_HORDE_Location = "Tabetha (Die Marschen von Dustwallow; "..YELLOW.."46,57 "..WHITE..")"
Inst27Quest4_HORDE_Note = "Man bekommt die Vorquest von Deino (Orgrimmar; 38,85).\nWasserbeschw\195\182rerin Velratha droppt Die Tiara der Tiefen. Man findet sie bei [6]."
Inst27Quest4_HORDE_Prequest = "Ja, Tabethas Aufgabe"
Inst27Quest4_HORDE_Folgequest = "Nein"
--
Inst27Quest4name1_HORDE = "Zauberformerrute"
Inst27Quest4name2_HORDE = "Edelsteinschiefer-Schulterst\195\188cke"

--QUEST 5 Horde

Inst27Quest5_HORDE = "5. Die Prophezeiung von Mosh'aru (Questreihe)"
Inst27Quest5_HORDE_Level = "47"
Inst27Quest5_HORDE_Attain = "40"
Inst27Quest5_HORDE_Aim = "Bringt die erste und die zweite Mosh'aru-Schrifttafel zu Yeh'kinya nach Tanaris."
Inst27Quest5_HORDE_Location = "Yeh'kinya (Tanaris; "..YELLOW.."66,22 "..WHITE..")"
Inst27Quest5_HORDE_Note = "Die Vorquest bekommt man auch von Yeh'kinya.\nMan findet die Schrifttafeln bei [2] und [6]."
Inst27Quest5_HORDE_Prequest = "Ja, Kreischergeister"
Inst27Quest5_HORDE_Folgequest = "Ja, Das uralte Ei"

--QUEST 6 Horde

Inst27Quest6_HORDE = "6. W\195\188nschel-mato-Rute"
Inst27Quest6_HORDE_Level = "46"
Inst27Quest6_HORDE_Attain = "?"
Inst27Quest6_HORDE_Aim = "Bringt die W\195\188nschel-mato-Rute nach Gadgetzan zu Chefingenieur Bilgewhizzle."
Inst27Quest6_HORDE_Location = "Chefingenieur Bilgewhizzle (Tanaris - Gadgetzan; "..YELLOW.."52,28 "..WHITE..")"
Inst27Quest6_HORDE_Note = "Man findet die Rute bei Seargent Bly der sich nach dem Tempelevent bei [4] aufh\195\164llt."
Inst27Quest6_HORDE_Prequest = "Nein"
Inst27Quest6_HORDE_Folgequest = "Nein"
--
Inst27Quest6name1_HORDE = "Maurer-Bruderschaftsring"
Inst27Quest6name2_HORDE = "Ingenieursgildenkopfst\195\188ck"

--QUEST 7 Horde

Inst27Quest7_HORDE = "7. Gahz'rilla"
Inst27Quest7_HORDE_Level = "50"
Inst27Quest7_HORDE_Attain = "40"
Inst27Quest7_HORDE_Aim = "Bringt Wizzle Brassbolts in der schimmernden Ebene Gahz'rillas energiegeladene Schuppe."
Inst27Quest7_HORDE_Location = "Wizzle Brassbolts (Thousands Needles; "..YELLOW.."78,77 "..WHITE..")"
Inst27Quest7_HORDE_Note = " Gahz'rilla kann man bei [6] beschw\195\182ren. Dazu ben\195\182tigt man den Schlaghammer von Zul'Farrak, den man im Hinterland herstellen kann."
Inst27Quest7_HORDE_Prequest = "Nein"
Inst27Quest7_HORDE_Folgequest = "Nein"
--
Inst27Quest7name1_HORDE = "Karotte am Stiel"

--------------------------Stockade/verlies (6 quests) Inst24
Inst24Story = "Das Verlies ist ein Hoch-sicherheits-gef\195\164ngnis, das unter dem Kanalbezirk von Stormwind verborgen liegt. Unter der F\195\188hrung von W\195\164rter Thelwater sammelten sich im Verlies mit der Zeit ein bunter Haufen simpler Gauner, politischer Aufr\195\188hrer, M\195\182rder, Diebe, Halsabschneider und einiger der gef\195\164hrlichsten Kriminellen des Landes an. Vor kurzem gab es einen Aufstand der Gefangenen, der im Verlies f\195\188r Chaos sorgte – die Wachen sind geflohen und die Gefangenen haben das Gef\195\164ngnis \195\188bernommen. Thelwater konnte knapp entkommen und sucht momentan nach tapferen Abenteurern, um den Anf\195\188hrer der Revolte auszuschalten, den gerissenen Meisterverbrecher Bazil Thredd."
Inst24Caption = "Das Verlies"
Inst24QAA = "6 Quests"
Inst24QAH = "keine Quests"



--QUEST 1 Allianz

Inst24Quest1 = "1. Verbrechen lohnt sich nicht"
Inst24Quest1_Level = "25"
Inst24Quest1_Attain = "22"
Inst24Quest1_Aim = "Bringt Wache Berton in Lakeshire den Kopf von Targorr dem Schrecklichen."
Inst24Quest1_Location = "Wache Berton (Redridgegebirge; "..YELLOW.."26,46 "..WHITE..")"
Inst24Quest1_Note = "Targorr findet man bei [1]."
Inst24Quest1_Prequest = "Nein"
Inst24Quest1_Folgequest = "Nein"
--
Inst24Quest1name1 = "Lucinen-Langschwert"
Inst24Quest1name2 = "Geh\195\164rteter Wurzelstab"

--QUEST 2 Allianz

Inst24Quest2 = "2. Verbrechen und Strafe"
Inst24Quest2_Level = "26"
Inst24Quest2_Attain = "22"
Inst24Quest2_Aim = "Ratsherr Millstipe von Darkshire will, dass Ihr ihm die Hand von Dextren Ward bringt."
Inst24Quest2_Location = "Ratsherr Millstipe (D\195\164mmerwald - Darkshire; "..YELLOW.."72,47 "..WHITE..")"
Inst24Quest2_Note = "Dextren findet man bei [5]."
Inst24Quest2_Prequest = "Nein"
Inst24Quest2_Folgequest = "Nein"
--
Inst24Quest2name1 = "Botschafter-Stiefel"
Inst24Quest2name2 = "Panzergamaschen von Dunkelhain"

--QUEST 3 Allianz

Inst24Quest3 = "3. Niederschlagung des Aufstandes"
Inst24Quest3_Level = "26"
Inst24Quest3_Attain = "22"
Inst24Quest3_Aim = "Aufseher Thelwater aus Stormwind will, dass Ihr im Verlies 10 gefangene Defias, 8 eingekerkerte Defias und 8 Aufr\195\188hrer der Defias t\195\182tet."
Inst24Quest3_Location = "Aufseher Thelwater (Stormwind; "..YELLOW.."41,58 "..WHITE..")"
Inst24Quest3_Note = ""
Inst24Quest3_Prequest = "Nein"
Inst24Quest3_Folgequest = "Nein"

--QUEST 4 Allianz

Inst24Quest4 = "4. Die Farbe von Blut"
Inst24Quest4_Level = "26"
Inst24Quest4_Attain = "?"
Inst24Quest4_Aim = "Nikova Raskol von Stormwind will, dass Ihr 10 rote Wollkopft\195\188cher f\195\188r sie sammelt."
Inst24Quest4_Location = "Nikova Raskol (Stormwind; "..YELLOW.."73,46 "..WHITE..")"
Inst24Quest4_Note = "Alle Gegner droppen die Kopft\195\188cher."
Inst24Quest4_Prequest = "Nein"
Inst24Quest4_Folgequest = "Nein"

--QUEST 5 Allianz

Inst24Quest5 = "5. Tief empfundener Zorn"
Inst24Quest5_Level = "27"
Inst24Quest5_Attain = "25"
Inst24Quest5_Aim = "Motley Garmason in Dun Modr verlangt Kam Deepfurys Kopf."
Inst24Quest5_Location = "Motley Garmason (Das Sumpfland; "..YELLOW.."49,18 "..WHITE..")"
Inst24Quest5_Note = "Den Prequest bekommt man auch von Motley.\nMan findet Kam Deepfury bei [2]."
Inst24Quest5_Prequest = "Ja, Der Dunkeleisenkrieg"
Inst24Quest5_Folgequest = "Nein"
--
Inst24Quest5name1 = "G\195\188rtel der Rechtfertigung"
Inst24Quest5name2 = "Kopfberster"


--QUEST 6 Allianz

Inst24Quest6 = "6. Aufstand im Verlies (Questline)"
Inst24Quest6_Level = "29"
Inst24Quest6_Attain = "16"
Inst24Quest6_Aim = "T\195\182tet Bazil Thredd und bringt seinen Kopf mit zur\195\188ck zu Aufseher Thelwater im Verlies."
Inst24Quest6_Location = "Aufseher Thelwater (Stormwind; "..YELLOW.."41,58 "..WHITE..")"
Inst24Quest6_Note = "Bei [Todesminen, Die Bruderschaft der Defias] findet man genauer Informationen \195\188ber die Forquest.\nMan findet Bazil Thredd bei [4]."
Inst24Quest6_Prequest = "Ja, Die Bruderschaft der Defias -> Bazil Thredd"
Inst24Quest6_Folgequest = "Ja, Der seltsame Besucher"



--------------Razorfen Downs/Inst17 /HUEGEL( 4 quests)------------
Inst17Story = "Die H\195\188gel von Razorfen, die von den selben dornigen Ranken wie der Kral von Razorfen dominiert werden, beherbergen seit jeher die Hauptstadt des Volks der Stacheleber. In dem weitl\195\164ufigen, dornenverseuchten Labyrinth h\195\164lt sich eine riesige Armee wilder Stacheleberkrieger auf, die ihr Leben darauf geschworen haben, ihre Hohepriester – die Mitglieder des Totenkopfstammes – um jeden Preis zu besch\195\188tzen. Vor Kurzem hat sich jedoch ein unheilbringender Schatten \195\188ber den kruden Bau gelegt. Abgesandte der untoten Gei\195\159el unter der F\195\188hrung des Lichs Amnennar der K\195\164ltebringer haben die Kontrolle \195\188ber das Volk der Stacheleber \195\188bernommen und das Labyrinth der Dornen in eine vorgeschobene Bastion untoter Macht verwandelt. Nun k\195\164mpfen die Stacheleber einen verzweifelten Kampf gegen die Zeit, denn Amnennars Einfluss dehnt sich jeden Tag weiter aus. Wenn er nicht aufgehalten wird, ist es nur eine Frage der Zeit, bis das Banner der Gei\195\159el \195\188ber dem Brachland wehen wird."
Inst17Caption = "Die H\195\188gel von Razorfen"
Inst17QAA = "3 Quests"
Inst17QAH = "4 Quests"

--QUEST 1 Allianz

Inst17Quest1 = "1. Ein Hort des B\195\182sen"
Inst17Quest1_Level = "35"
Inst17Quest1_Attain = "30"
Inst17Quest1_Aim = "T\195\182tet 8 Schlachtwachen von Razorfen, 8 Dornenwirker von Razorfen und 8 Kultistinnen der Totenk\195\182pfe und kehrt dann zu Myriam Moonsinger nahe dem Eingang zu den H\195\188geln von Razorfen zur\195\188ck."
Inst17Quest1_Location = "Myriam Moonsinger (Das Brachland; "..YELLOW.."49,94 "..WHITE..")"
Inst17Quest1_Note = "Die Mobs befinden sich au\195\159erhalb der Instanz."
Inst17Quest1_Prequest = "Nein"
Inst17Quest1_Folgequest = "Nein"

--QUEST 2 Allianz

Inst17Quest2 = "2. Ausschalten des G\195\182tzes"
Inst17Quest2_Level = "37"
Inst17Quest2_Attain = "34"
Inst17Quest2_Aim = "Begleitet Belnistrasz zum G\195\182tzen der Stacheleber in den H\195\188geln von Razorfen. Besch\195\188tzt Belnistrasz, w\195\164hrend er das Ritual durchf\195\188hrt, um den G\195\182tzen auszuschalten."
Inst17Quest2_Location = "Belnistrasz (Die H\195\188gel von Razorfen;); "..YELLOW.."[2] "..WHITE..")"
Inst17Quest2_Note = "Um die Vorquest zu meistern, muss man Belnistrasz ansprechen und seinen Quest annehmen. Dadurch bekommt man einen Gegenstand, mit dem man dann nochmal Belnistrasz ansprechen kann, um diesen Quest zu starten."
Inst17Quest2_Prequest = "Ja (Bei Belnistrasz zu bekommen)"
Inst17Quest2_Folgequest = "Nein"
--
Inst17Quest2name1 = "Drachenklauenring"


--QUEST 3 Allianz

Inst17Quest3 = "3. Das Licht bringen"
Inst17Quest3_Attain = "39"
Inst17Quest3_Level = "42"
Inst17Quest3_Aim = "Erzbischof Benedictus will, dass Ihr Amnennar den K\195\164ltebringer in den H\195\188geln von Razorfen t\195\182tet."
Inst17Quest3_Location = "Erzbischof Benedictus (Stormwind; "..YELLOW.."39,27 "..WHITE..")"
Inst17Quest3_Note = "Amnennar den K\195\164ltebringer ist der Endboss von den H\195\188geln von Razorfen und befindet sich bei [6]. W\195\164hrend des Kampfes beschw\195\182rt er regelm\195\164\195\159ig 3 Gegner."
Inst17Quest3_Prequest = "Nein"
Inst17Quest3_Folgequest = "Nein"
--
Inst17Quest3name1 = "Bezwingerschwert"
Inst17Quest3name2 = "Bernsteinglut-Talisman"

--QUEST 1 Horde

Inst17Quest1_HORDE = "1. Ein Hort des B\195\182sen"
Inst17Quest1_HORDE_Level = "35"
Inst17Quest1_HORDE_Attain = "30"
Inst17Quest1_HORDE_Aim = "T\195\182tet 8 Schlachtwachen von Razorfen, 8 Dornenwirker von Razorfen und 8 Kultistinnen der Totenk\195\182pfe und kehrt dann zu Myriam Moonsinger nahe dem Eingang zu den H\195\188geln von Razorfen zur\195\188ck."
Inst17Quest1_HORDE_Location = "Myriam Moonsinger (Das Brachland; "..YELLOW.."49,94 "..WHITE..")"
Inst17Quest1_HORDE_Note = "Die Gegner befinden sich au\195\159erhalb der Instanz."
Inst17Quest1_HORDE_Prequest = "Nein"
Inst17Quest1_HORDE_Folgequest = "Nein"

--Quest 2 Horde

Inst17Quest2_HORDE = "2. Eine unheilige Allianz"
Inst17Quest2_HORDE_Level = "36"
Inst17Quest2_HORDE_Attain = "?"
Inst17Quest2_HORDE_Aim = "Bringt den Kopf von Botschafter Malcin zu Varimathras nach Undercity."
Inst17Quest2_HORDE_Location = "Varimathras  (Undercity; "..YELLOW.."56,92 "..WHITE..")"
Inst17Quest2_HORDE_Note = "Die Prequest droppt der Endboss der Instanz der Kral von Razorfen.\n Der Botschafter Malcin selbst ist au\195\159erhalb der Instanz (Brachland, 48,92)."
Inst17Quest2_HORDE_Prequest = "Ja, Eine unheilige Allianz"
Inst17Quest2_HORDE_Folgequest = "Nein"
--
Inst17Quest2name1_HORDE = "Sch\195\164delbrecher"
Inst17Quest2name2_HORDE = "Nagelspeier"
Inst17Quest2name3_HORDE = "Zelotenrobe"

-- Quest 3 Horde

Inst17Quest3_HORDE = "3. Ausschalten des G\195\182tzes"
Inst17Quest3_HORDE_Level = "37"
Inst17Quest3_HORDE_Attain = "34"
Inst17Quest3_HORDE_Aim = "Begleitet Belnistrasz zum G\195\182tzen der Stacheleber in den H\195\188geln von Razorfen. Besch\195\188tzt Belnistrasz, w\195\164hrend er das Ritual durchf\195\188hrt, um den G\195\182tzen auszuschalten."
Inst17Quest3_HORDE_Location = "Belnistrasz (Die H\195\188gel von Razorfen (Atlas-Nr.); "..YELLOW.."2 "..WHITE..")"
Inst17Quest3_HORDE_Note = " Um die Vorquest zu meistern, muss man Belnistrasz ansprechen und seinen Quest annehmen. Dadurch bekommt man einen Gegenstand, mit dem man dann nochmal Belnistrasz ansprechen kann, um diesen Quest zu starten. "
Inst17Quest3_HORDE_Prequest = "Ja (Bei Belnistrasz zu bekommen)"
Inst17Quest3_HORDE_Folgequest = "Nein"
--
Inst17Quest3name1_HORDE = "Drachenklauenring"

--QUEST 4 Horde

Inst17Quest4_HORDE = "4. Das Ende bringen"
Inst17Quest4_HORDE_Attain = "37"
Inst17Quest4_HORDE_Level = "42"
Inst17Quest4_HORDE_Aim = "Andrew Brownell will, dass Ihr Amnennar den K\195\164ltebringer t\195\182tet und ihm dessen Sch\195\164del bringt."
Inst17Quest4_HORDE_Location = "Andrew Brownell (Untercity; "..YELLOW.."72,32 "..WHITE..")"
Inst17Quest4_HORDE_Note = "Amnennar den K\195\164ltebringer ist der Endboss von den H\195\188geln von Razorfen und befindet sich bei [6]. W\195\164hrend des Kampfes beschw\195\182rt er regelm\195\164\195\159ig 3 Gegner."
Inst17Quest4_HORDE_Prequest = "Nein"
Inst17Quest4_HORDE_Rewards = "itemid=10823,10824"
Inst17Quest4_HORDE_Folgequest = "Nein"
--
Inst17Quest4name1_HORDE = "Bezwingerschwert"
Inst17Quest4name2_HORDE = "Bernsteinglut-Talisman"


--------------Kloster/SM ( 6 quests)------------
Inst19Story = "Das Kloster war einst der ganze Stolz der Priesterschaft von Lordaeron, ein Ort der Studien und der Erleuchtung. Doch seit dem Auftauchen der untoten Gei\195\159el w\195\164hrend des Dritten Krieges wurde das friedliche Kloster in eine Festung des fanatischen Scharlachroten Kreuzzuges verwandelt. Die Kreuzritter zeigen gegen\195\188ber allen nichtmenschlichen V\195\182lkern nicht den geringsten Funken von Toleranz oder Achtung, egal auf welcher Seite sie stehen m\195\182gen. Sie glauben, dass alle Au\195\159enseiter potentielle \195\156bertr\195\164ger der Seuche des Untodes sind und deswegen vernichtet werden m\195\188ssen. Berichten \195\156berlebender zufolge m\195\188ssen sich Eindringlinge darauf gefasst machen, dem Scharlachroten Kommandanten Mograine entgegenzutreten, der zudem \195\188ber eine gro\195\159e Streitmacht ihm fanatisch ergebener Krieger gebietet. Der wahre Herr \195\188ber das Scharlachrote Kloster ist jedoch Hochinquisitor Whitemane – eine furchteinfl\195\182\195\159ende Priesterin, die \195\188ber die einzigartige Gabe verf\195\188gt, gefallene K\195\164mpfer in ihrem Namen ins Kampfgeschehen zur\195\188ckholen zu k\195\182nnen."
Inst19Caption = "Das Scharlachrote Kloster"
Inst19QAA = "3 Quests"
Inst19QAH = "6 Quests"

--QUEST 1 Allianz

Inst19Quest1 = "1. Mythologie der Titanen"
Inst19Quest1_Level = "38"
Inst19Quest1_Attain = "?"
Inst19Quest1_Aim = "Holt die 'Mythologie der Titanen' aus dem Kloster und bringt die der Bibliothekarin Mae Paledust in Ironforge."
Inst19Quest1_Location = "Bilbliothekarin Mae Paledust (Ironforge; "..YELLOW.."74,12 "..WHITE..")"
Inst19Quest1_Note = "Das Buch findet man im Bibliotheksteil der Instanz."
Inst19Quest1_Prequest = "Nein"
Inst19Quest1_Folgequest = "Nein"
--
Inst19Quest1name1 = "Forscherliga-Empfehlung"

--QUEST 2 Allianz

Inst19Quest2 = "2. Im Namen des Lichts"
Inst19Quest2_Level = "40"
Inst19Quest2_Attain = "39"
Inst19Quest2_Aim = "T\195\182tet Hochinquisitor Whitemane, den Scharlachroten Kommandant Mograine, Herod, den Scharlachroten Helden sowie den Hundemeister Loksey und meldet Euch dann wieder bei Raleigh dem And\195\164chtigen in Southshore."
Inst19Quest2_Location = "Raleigh der And\195\164chtige (Vorgebirge von Hillsbrad, Southshore; "..YELLOW.."51,58 "..WHITE..")"
Inst19Quest2_Note = "Die Questreihe f\195\164ngt bei Bruder Crowley (42,24 in Stormwind) an.\nHochinquisitor Whitemane und Kommandant Mograinebei findet man bei [5], Herod bei [3] und Hundemeister Loksey bei [1]."
Inst19Quest2_Prequest = "Ja, Bruder Anton -> Auf dem Scharlachroten Pfad"
Inst19Quest2_Folgequest = "Nein"
--
Inst19Quest2name1 = "Schwert der Beschaulichkeit"
Inst19Quest2name2 = "Knochenbei\195\159er"
Inst19Quest2name3 = "Schwarze Bedrohung"
Inst19Quest2name4 = "Kugel von Lorica"


--QUEST 3 Allianz MAGIER

Inst19Quest3 = "3. Rituale der Macht (Magier)"
Inst19Quest3_Level = "40"
Inst19Quest3_Attain = "31"
Inst19Quest3_Aim = "Bringt das Buch 'Rituale der Macht' zu Tabetha in den Marschen von Dustwallow."
Inst19Quest3_Location = "Tabetha (Marschen von Dustwallow; "..YELLOW.."43,57 "..WHITE..")"
Inst19Quest3_Note = "Dieser Quest kann nur von Magiern angenommen werden!\nDas Buch findet man im Bibliotheksteil der Instanz."
Inst19Quest3_Prequest = "Ja, Der Kn\195\188ller schlechthin"
Inst19Quest3_Folgequest = "Ja, Der Zauberstab des Magiers"

--QUEST 1 Horde

Inst19Quest1_HORDE = "1. Vorrels Rache"
Inst19Quest1_HORDE_Level = "33"
Inst19Quest1_HORDE_Attain = "?"
Inst19Quest1_HORDE_Aim = "Bringt Monika Sengutz in Tarrens M\195\188hle den Ehering von Vorrel Sengutz."
Inst19Quest1_HORDE_Location = "Vorrel Sengutz (Das Scharlachrote Kloster, Friedhof)"
Inst19Quest1_HORDE_Note = "Vorrel Sengutz findet man gleich am Anfang vom Friedhofsteil. Den Ring bekommt man bei Nancy Vishas, die sich in einem Haus im Alteracgebirge(31,32) befindet."
Inst19Quest1_HORDE_Prequest = "Nein"
Inst19Quest1_HORDE_Folgequest = "Nein"
--
Inst19Quest1name1_HORDE = "Vorrels Stiefel"
Inst19Quest1name2_HORDE = "Mantel des Jammers"
Inst19Quest1name3_HORDE = "Grimmstahlcape"

--Quest 2 Horde

Inst19Quest2_HORDE = "2. Herzen des Eifers"
Inst19Quest2_HORDE_Level = "33"
Inst19Quest2_HORDE_Attain = "?"
Inst19Quest2_HORDE_Aim = "Apothekermeister Faranell in Undercity m\195\182chte 20 Herzen des Eifers."
Inst19Quest2_HORDE_Location = "Apothekermeister Faranell  (Undercity; "..YELLOW.."48,69 "..WHITE..")"
Inst19Quest2_HORDE_Note = "Siehe [Kral von Razorfen] f\195\188r mehr Deatils \195\188ber den Vorquest.\nDie Herzen werden von allen Gegnern im Kloster gedroppt."
Inst19Quest2_HORDE_Prequest = "Ja, Go, Go, Guano!"
Inst19Quest2_HORDE_Folgequest = "Nein"


-- Quest 3 Horde

Inst19Quest3_HORDE = "3. Test der Lehre (Questreihe)"
Inst19Quest3_HORDE_Level = "36"
Inst19Quest3_HORDE_Attain = "32"
Inst19Quest3_HORDE_Aim = "Sucht Die Anf\195\164nge der Bedrohung durch die Untoten und bringt es zu Parqual Fintallas in Undercity."
Inst19Quest3_HORDE_Location = "Parqual Fintallas (Undercity; "..YELLOW.."57,65 "..WHITE..")"
Inst19Quest3_HORDE_Note = "Die Questreihe beginnt bei Dorn Plainstalker (Tausend Nadeln (53,41).\nDas Buch findet man im Bibliotheksteil der Instanz."
Inst19Quest3_HORDE_Prequest = "Ja, Test der Glaubens -> Test der Lehre"
Inst19Quest3_HORDE_Folgequest = "Ja, Test der Lehre"

--QUEST 4 Horde

Inst19Quest4_HORDE = "4. Kompendium der Gefallenen"
Inst19Quest4_HORDE_Level = "38"
Inst19Quest4_HORDE_Attain = "?"
Inst19Quest4_HORDE_Aim = "Holt das 'Kompendium der Gefallenen' aus dem Kloster in Tirisfal und bringt es zu Sage Truthseeker in Thunder Bluff."
Inst19Quest4_HORDE_Location = "Sage Truthseeker (Thunderbluff; "..YELLOW.."34,47 "..WHITE..")"
Inst19Quest4_HORDE_Note = "Das Buch findet man im Bibliotheksteil der Instanz."
Inst19Quest4_HORDE_Prequest = "Nein"
Inst19Quest4_HORDE_Folgequest = "Nein"
--
Inst19Quest4name1_HORDE = "Gr\195\164sslicher Besch\195\188tzer"
Inst19Quest4name2_HORDE = "Zwingstein-Rundschild"
Inst19Quest4name3_HORDE = "Omegakugel"

--QUEST 5 Horde

Inst19Quest5_HORDE = "5. In das Scharlachrote Kloster"
Inst19Quest5_HORDE_Level = "42"
Inst19Quest5_HORDE_Attain = "33"
Inst19Quest5_HORDE_Aim = "T\195\182tet Hochinquisitor Whitemane, den Scharlachroten Kommandant Mograine, Herod, den Scharlachroten Helden sowie den Hundemeister Loksey und meldet Euch dann wieder bei Varimathras in Undercity."
Inst19Quest5_HORDE_Location = "Varimathras  (Undercity; "..YELLOW.."56,92 "..WHITE..")"
Inst19Quest5_HORDE_Note = "Hochinquisitor Whitemane und Kommandant Mograinebei findet man bei [5], Herod bei [3] und Hundemeister Loksey bei [1]."
Inst19Quest5_HORDE_Prequest = "Nein"
Inst19Quest5_HORDE_Folgequest = "Nein"
--
Inst19Quest5name1_HORDE = "Schwert des Omens"
Inst19Quest5name2_HORDE = "Prophetenkr\195\188ckstock"
Inst19Quest5name3_HORDE = "Drachenblut-Halskette"

--QUEST 6 Horde

Inst19Quest6_HORDE = "6. Rituale der Macht (Magier)"
Inst19Quest6_HORDE_Level = "40"
Inst19Quest6_HORDE_Attain = "31"
Inst19Quest6_HORDE_Aim = "Bringt das Buch 'Rituale der Macht' zu Tabetha in den Marschen von Dustwallow."
Inst19Quest6_HORDE_Location = "Tabetha (Marschen von Dustwallow; "..YELLOW.."46,57 "..WHITE..")"
Inst19Quest6_HORDE_Note = "Dieser Quest kann nur von Magiern angenommen werden!\nDas Buch findet man im Bibliotheksteil der Instanz."
Inst19Quest6_HORDE_Prequest = "Ja, Der Kn\195\188ller schlechthin"
Inst19Quest6_HORDE_Folgequest = "Ja, Der Zauberstab des Magiers"


--------------Kral ( 5 quests)------------
Inst18Story = "Vor zehntausend Jahren, zum H\195\182hepunkt des Kriegs der Uralten, betrat der m\195\164chtige Halbgott Agamaggan das Schlachtfeld, um sich der Brennenden Legion entgegenzustellen. Seinen Beitrag zur Rettung Azeroths vor dem sicheren Untergang musste der stolze Eber jedoch mit seinem Leben bezahlen. Im Lauf der Zeit sprossen dort, wo die Tropfen seines Blutes auf die Erde gefallen waren, gewaltige Dornenranken. Die Stacheleber, die sterblichen Nachkommen des m\195\164chtigen Gottes, siedelten sich dort an und betrachten den Kral bis zum heutigen Tag als ihr h\195\182chstes Heiligtum, dessen Herz der Razorfen (Klingenbusch) genannt wird. Heute wird der gr\195\182\195\159te Teil des Krals von Razorfen von der alten Stammesf\195\188rstin Charlga Razorflank und ihrem Stamm kontrolliert. Unter ihrer F\195\188hrung greifen die schamanistischen Stacheleber regelm\195\164\195\159ig sowohl die feindlichen St\195\164mme als auch nahegelegene Siedlungen der Orcs und Tauren an. In j\195\188ngster Zeit gab es Hinweise, die auf einen m\195\182glichen Pakt zwischen Charlga und den Agenten der untoten Gei\195\159el hindeuten. Kann es tats\195\164chlich sein, dass die Uralte ihren nichtsahnenden Stamm zu irgendeinem finsteren Zweck direkt in die Arme der Untoten treibt?"
Inst18Caption = "Der Kral von Razorfen"
Inst18QAA = "5 Quests"
Inst18QAH = "5 Quests"

--QUEST 1 Allianz

Inst18Quest1 = "1. Blaulaubknollen"
Inst18Quest1_Level = "26"
Inst18Quest1_Attain = "20"
Inst18Quest1_Aim = "Benutzt im Kral von Razorfen die Kiste mit L\195\182chern, um ein Schn\195\188ffelnasenziesel zu beschw\195\182ren, und benutzt den Leitstecken bei dem Ziesel, damit es nach Knollen sucht. Bringt 6 Blaulaubknollen, den Schn\195\188ffelnasenleitstecken und die Kiste mit L\195\182chern zu Mebok Mizzyrix in Ratchet."
Inst18Quest1_Location = "Mebok Mizzyrix (Brachland - Ratchet; "..YELLOW.."62,37"..WHITE..")"
Inst18Quest1_Note = "Die Kiste, der Leitstecken und das Handbuch liegen gleich neben dem Questgeber."
Inst18Quest1_Prequest = "Nein"
Inst18Quest1_Folgequest = "Nein"
--
Inst18Quest1name1 = "Ein kleiner Beh\195\164lter mit Edelsteinen"

--QUEST 2 Allianz

Inst18Quest2 = "2. Die Sterblichkeit schwindet"
Inst18Quest2_Level = "30"
Inst18Quest2_Attain = "?"
Inst18Quest2_Aim = "Sucht und bringt Treshalas Anh\195\164nger zu Treshala Fallowbrook in Darnassus."
Inst18Quest2_Location = "Heraltha Treshala Fallowbrook (Kral von Razorfen; "..YELLOW.." [8]"..WHITE..")"
Inst18Quest2_Note = "Die Kette ist ein random Drop von den Stachelebern. Sobald du sie bekommen hast, musst du sie nach Darnassus zu Treshala Fallowbrook (69,67) bringen."
Inst18Quest2_Prequest = "Nein"
Inst18Quest2_Folgequest = "Nein"
--
Inst18Quest2name1 = "Trauerschal"
Inst18Quest2name2 = "Lanzer-Stiefel"

--QUEST 3 Allianz

Inst18Quest3 = "3. Willix der Importeur"
Inst18Quest3_Level = "30"
Inst18Quest3_Attain = "?"
Inst18Quest3_Aim = "F\195\188hrt Willix den Importeur aus dem Kral von Razorfen hinaus."
Inst18Quest3_Location = "Willix der Importeur (Kral von Razorfen; "..YELLOW.." [8]"..WHITE..")"
Inst18Quest3_Note = "Willix findt man bei [8]. Man muss ihn zum Eingang geleiten."
Inst18Quest3_Prequest = "Nein"
Inst18Quest3_Folgequest = "Nein"
--
Inst18Quest3name1 = "Affenring"
Inst18Quest3name2 = "Natternreifen"
Inst18Quest3name3 = "Tigerband"

--QUEST 4 Allianz

Inst18Quest4 = "4. Die Greisin des Krals"
Inst18Quest4_Level = "34"
Inst18Quest4_Attain = "30"
Inst18Quest4_Aim = "Bringt Falfindel Waywarder in Thalanaar Razorflanks Medaillon."
Inst18Quest4_Location = "Falfindel Waywarder (Feralas; "..YELLOW.."89,46"..WHITE..")"
Inst18Quest4_Note = "Das Medaillon wird von Charlga Razorflank bei [7] gedropt."
Inst18Quest4_Prequest = "Ja, Lonebrows Tagebuch"
Inst18Quest4_Folgequest = "Ja, Die Greisin des Krals"
--
Inst18Quest4name1 = "Donnerb\195\188chse 'Magierauge'"
Inst18Quest4name2 = "Beryllpolster"
Inst18Quest4name3 = "Steinfaustgurt"
Inst18Quest4name4 = "Marmorierter Rundschild"

--QUEST 5 Allianz KRIEGER

Inst18Quest5 = "5. Feuergeh\195\164rteter Panzer (Krieger)"
Inst18Quest5_Level = "28"
Inst18Quest5_Attain = "20"
Inst18Quest5_Aim = "Sammelt die Materialien, die Furen Longbeard ben\195\182tigt, und bringt sie zu ihm nach Stormwind."
Inst18Quest5_Location = "Furen Longbeard (Stormwind; "..YELLOW.."57,16"..WHITE..")"
Inst18Quest5_Note = "Dieser Quest kann nur von Kriegern angenommen werden!\nDie Phiole mit Phlogiston bekommt man von Roogug bei [1]."
Inst18Quest5_Prequest = "Ja, Der Schildschmied"
Inst18Quest5_Folgequest = "Ja"

--QUEST 1 Horde

Inst18Quest1_HORDE = "1. Blaulaubknollen"
Inst18Quest1_HORDE_Level = "26"
Inst18Quest1_HORDE_Attain = "20"
Inst18Quest1_HORDE_Aim = "Benutzt im Kral von Razorfen die Kiste mit L\195\182chern, um ein Schn\195\188ffelnasenziesel zu beschw\195\182ren, und benutzt den Leitstecken bei dem Ziesel, damit es nach Knollen sucht. Bringt 6 Blaulaubknollen, den Schn\195\188ffelnasenleitstecken und die Kiste mit L\195\182chern zu Mebok Mizzyrix in Ratchet."
Inst18Quest1_HORDE_Location = "Mebok Mizzyrix (Brachland - Ratchet; "..YELLOW.."62,37"..WHITE..")"
Inst18Quest1_HORDE_Note = "Die Kiste, der Leitstecken und das Handbuch liegen gleich neben dem Questgeber."
Inst18Quest1_HORDE_Prequest = "Nein"
Inst18Quest1_HORDE_Folgequest = "Nein"
--
Inst18Quest1name1_HORDE = "Ein kleiner Beh\195\164lter mit Edelsteinen"

--Quest 2 Horde

Inst18Quest2_HORDE = "2. Willix der Importeur"
Inst18Quest2_HORDE_Level = "30"
Inst18Quest2_HORDE_Attain = "?"
Inst18Quest2_HORDE_Aim = "F\195\188hrt Willix den Importeur aus dem Kral von Razorfen hinaus."
Inst18Quest2_HORDE_Location = "Willix der Importeur (Kral von Razorfen; "..YELLOW.." [8]"..WHITE..")"
Inst18Quest2_HORDE_Note = "Willix findt man bei [8]. Man muss ihn zum Eingang geleiten."
Inst18Quest2_HORDE_Prequest = "Nein"
Inst18Quest2_HORDE_Folgequest = "Nein"
--
Inst18Quest2name1_HORDE = "Affenring"
Inst18Quest2name2_HORDE = "Natternreifen"
Inst18Quest2name3_HORDE = "Tigerband"

-- Quest 3 Horde

Inst18Quest3_HORDE = "3. Go, Go, Guano!"
Inst18Quest3_HORDE_Level = "33"
Inst18Quest3_HORDE_Attain = "?"
Inst18Quest3_HORDE_Aim = "Bringt dem Apothekermeister Faranell in Undercity 1 H\195\164ufchen Kral-Guano."
Inst18Quest3_HORDE_Location = "Apothekermeister Faranell (Undercity; "..YELLOW.."48,69 "..WHITE..")"
Inst18Quest3_HORDE_Note = "Das Kral-Guano droppen alle Flederm\195\164use im Kral."
Inst18Quest3_HORDE_Prequest = "Nein"
Inst18Quest3_HORDE_Folgequest = "Ja, Herzen des Eifers (Siehe: [H\195\188gel von Razorfen])"

--QUEST 4 Horde

Inst18Quest4_HORDE = "4. Ein schreckliches Schicksal"
Inst18Quest4_HORDE_Level = "34"
Inst18Quest4_HORDE_Attain = "29"
Inst18Quest4_HORDE_Aim = "Bringt Auld Stonespire in Thunder Bluff Razorflanks Herz."
Inst18Quest4_HORDE_Location = "Auld Stonespire (Thunderbluff; "..YELLOW.."36,59 "..WHITE..")"
Inst18Quest4_HORDE_Note = "Charlga Razorflank findet man bei [7]"
Inst18Quest4_HORDE_Prequest = "Nein"
Inst18Quest4_HORDE_Folgequest = "Nein"
--
Inst18Quest4name1_HORDE = "Beryllpolster"
Inst18Quest4name2_HORDE = "Steinfaustgurt"
Inst18Quest4name3_HORDE = "Marmorierter Rundschild"

--QUEST 5 Horde

Inst18Quest5_HORDE = "5. Brutale R\195\188stung (Krieger)"
Inst18Quest5_HORDE_Level = "30"
Inst18Quest5_HORDE_Attain = "20"
Inst18Quest5_HORDE_Aim = "Bringt Thun'grim Firegaze 15 rauchige Eisenbl\195\182cke, 10 pulverisierte Azurite, 10 Eisenbarren und 1 Phiole Phlogiston."
Inst18Quest5_HORDE_Location = "Thun'grim Firegaze (Brachland; "..YELLOW.."57,30 "..WHITE..")"
Inst18Quest5_HORDE_Note = "Dieses Quest kann nur von Kriegern angenommen werden!\nDie Phiole mit Phlogiston bekommt man von Roogug bei [1]."
Inst18Quest5_HORDE_Prequest = "Ja, Gespr\195\164ch mit Ruga"

--------------Scholo ( 9 quests)/Inst20/SCHOLO------------
Inst20Story = "Die Scholomance ist ein weitl\195\164ufiges Netzwerk unterirdischer Krypten, das sich unter der verfallenen Burg Caer Darrow erstreckt. Caer Darrow war fr\195\188her im Besitz der Barovs, einer alten Adelsfamilie, doch w\195\164hrend des Zweiten Krieges verfiel die Burg und wurde zu einer Ruine. Eine g\195\164ngige Methode, mit der Kel'thuzad neue Anh\195\164nger f\195\188r seinen Kult der Verdammten warb, war es, potentiellen Neuzug\195\164ngen im Austausch gegen ihre Dienste f\195\188r den Lichk\195\182nig die Unsterblichkeit zu versprechen. Die Barovs fielen auf Kel'thuzads charismatischen Schwindel herein und \195\188berlie\195\159en die Burg und die dazugeh\195\182rigen Krypten der Gei\195\159el. Im Gegenzug t\195\182teten die Kultisten die Barovs und machten aus den uralten Gew\195\182lben eine Schule der Nekromantie, die sie die Scholomance tauften. Auch wenn Kel'thuzad schon lange nicht mehr in den Krypten weilt, verbleiben dennoch viele Kultisten und Lehrmeister in der Scholomance. Der m\195\164chtige Lich Ras Frostwhisper verteidigt die Scholomance im Namen der Gei\195\159el gegen alle, die unbefugterweise einen Fu\195\159 \195\188ber ihre Schwelle setzen, w\195\164hrend Dunkelmeister Gandling als der hinterh\195\164ltige Direktor der Schule f\195\188r Ordnung unter den Lernenden sorgt."
Inst20Caption = "Die Scholomance"
Inst20QAA = "9 Quests"
Inst20QAH = "9 Quests"

--QUEST 1 Allianz

Inst20Quest1 = "1. Verseuchte Jungtiere"
Inst20Quest1_Attain = "55"
Inst20Quest1_Level = "58"
Inst20Quest1_Aim = "T\195\182tet 20 verseuchte Jungtiere und kehrt dann zu Betina Bigglezink bei der Kapelle des hoffnungsvollen Lichts zur\195\188ck."
Inst20Quest1_Location = "Betina Bigglezink (\195\150stliche Pestl\195\164nder - Kapelle des hoffnungsvollen Lichts; "..YELLOW.."81,59"..WHITE..")"
Inst20Quest1_Note = ""
Inst20Quest1_Prequest = "Nein"
Inst20Quest1_Folgequest = "Ja, Gesunde Gro\195\159drachenschuppe"

--QUEST 2 Allianz

Inst20Quest2 = "2. Gesunde Gro\195\159drachenschuppe"
Inst20Quest2_Attain = ""
Inst20Quest2_Level = "58"
Inst20Quest2_Aim = "Bringt die gesunde Gro\195\159drachenschuppe zu Betina Bigglezink bei der Kapelle des hoffnungsvollen Lichts in den \195\150stlichen Pestl\195\164ndern."
Inst20Quest2_Location = "Gesunde Gro\195\159drachenschuppe (Drop) (Scholomance)"
Inst20Quest2_Note = "Die Gesunde Gro\195\159drachenschuppe dropt bei den Verseuchte Jungtiere(8% Dropchance). Betina Bigglezink ist bei 81,59."
Inst20Quest2_Prequest = "Ja, Verseuchte Jungtiere"
Inst20Quest2_Folgequest = "Nein"

--QUEST 3 Allianz

Inst20Quest3 = "3. Doktor Theolen Krastinov, der Schl\195\164chter"
Inst20Quest3_Attain = "55"
Inst20Quest3_Level = "60"
Inst20Quest3_Aim = "Sucht Doktor Theolen Krastinov in der Scholomance. Vernichtet ihn, verbrennt dann die \195\156berreste von Eva Sarkhoff und die \195\156berreste von Lucien Sarkhoff. Kehrt zu Eva Sarkhoff zur\195\188ck, sobald Ihr die Aufgabe erf\195\188llt habt."
Inst20Quest3_Location = "Eva Sarkhoff (Westliche Pestl\195\164nder; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest3_Note = "Doktor Theolen Krastinov ist bei [9]."
Inst20Quest3_Prequest = "Nein"
Inst20Quest3_Folgequest = "Ja, Krastinovs Tasche der Schrecken"

--QUEST 4 Allianz

Inst20Quest4 = "4. Krastinovs Tasche der Schrecken"
Inst20Quest4_Attain = "55"
Inst20Quest4_Level = "60"
Inst20Quest4_Aim = "Sucht nach Jandice Barov in der Scholomance und vernichtet sie. Entnehmt ihrer Leiche Krastinovs Tasche der Schrecken. Bringt die Tasche zu Eva Sarkhoff."
Inst20Quest4_Location = "Eva Sarkhoff (Westliche Pestl\195\164nder; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest4_Note = "Man findet Jandice Barov bei [3]."
Inst20Quest4_Prequest = "Ja, Doktor Theolen Krastinov, der Schl\195\164chter"
Inst20Quest4_Folgequest = "Ja, Kirtonos der Herold"

--QUEST 5 Allianz

Inst20Quest5 = "5. Kirtonos der Herold"
Inst20Quest5_Attain = "56"
Inst20Quest5_Level = "60"
Inst20Quest5_Aim = "Kehrt mit dem Blut Unschuldiger zur Scholomance zur\195\188ck. Sucht die Veranda und legt das Blut der Unschuldigen in die Kohlenpfanne. Kirtonos wird kommen, um sich von Eurer Seele zu n\195\164hren. K\195\164mpft tapfer, gebt keinen Fu\195\159breit nach! Vernichtet Kirtonos und kehrt zu Eva Sarkhoff zur\195\188ck."
Inst20Quest5_Location = "Eva Sarkhoff (Westliche Pestl\195\164nder; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest5_Note = "Die Kohlepfanne findet man bei [2]."
Inst20Quest5_Prequest = "Ja, Krastinovs Tasche der Schrecken"
Inst20Quest5_Folgequest = "Ja, Der Mensch Ras Frostraunen"
--
Inst20Quest5name1 = "Spektrale Essenz"
Inst20Quest5name2 = "Penelopes Rose"
Inst20Quest5name3 = "Mirahs Lied"


--QUEST 6 Allianz

Inst20Quest6 = "6. Der Lich Ras Frostraunen"
Inst20Quest6_Attain = "60"
Inst20Quest6_Level = "60"
Inst20Quest6_Aim = "Sucht Ras Frostraunen in der Scholomance. Wenn Ihr ihn gefunden habt, wendet das seelengebundene Andenken auf sein untotes Antlitz an. Solltet Ihr ihn erfolgreich in einen Sterblichen zur\195\188ckverwandeln k\195\182nnen, dann schlagt ihn nieder und nehmt den menschlichen Kopf von Ras Frostraunen an Euch. Bringt den Kopf zu Magistrat Marduke."
Inst20Quest6_Location = "Magistrat Marduke (Westliche Pestl\195\164nder; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest6_Note = "Ras Frostraunen findet man bei [7]."
Inst20Quest6_Prequest = "Ja, Der Mensch Ras Frostraunen -> Seelengebundenes Andenken"
Inst20Quest6_Folgequest = "Nein"
--
Inst20Quest6name1 = "Starkwache von Darrowshire"
Inst20Quest6name2 = "Kriegsklinge von Caer Darrow"
Inst20Quest6name3 = "Krone von Caer Darrow"
Inst20Quest6name4 = "Froststachel"

--QUEST 7 Allianz

Inst20Quest7 = "7. Das Familienverm\195\182gen der Barovs"
Inst20Quest7_Attain = "60"
Inst20Quest7_Level = "60"
Inst20Quest7_Aim = "Begebt Euch zur Scholomance und holt das Familienverm\195\182gen der Barovs zur\195\188ck. Dieses Verm\195\182gen besteht aus vier Besitzurkunden: Es sind die Besitzurkunde f\195\188r Caer Darrow, die Besitzurkunde f\195\188r Brill, die Besitzurkunde f\195\188r Tarrens M\195\188hle und die Besitzurkunde f\195\188r Southshore. Kehrt zu Weldon Barov zur\195\188ck, sobald die Aufgabe erledigt ist."
Inst20Quest7_Location = "Weldon Barov (Westliche Pestl\195\164nder; "..YELLOW.."43,83"..WHITE..")"
Inst20Quest7_Note = "Die Besitzurkunde f\195\188r Caer Darrow findet man bei [12], die Besitzurkunde f\195\188r Brill bei [7], Besitzurkunde f\195\188r Tarrens M\195\188hle bei [4] und die Besitzurkunde f\195\188r Southshore bei [1]."
Inst20Quest7_Prequest = "Nein"
Inst20Quest7_Folgequest = "Ja, Der letzte Barov"

--QUEST 8 Allianz

Inst20Quest8 = "8. D\195\164mmerungstrickfalle"
Inst20Quest8_Attain = "59"
Inst20Quest8_Level = "60"
Inst20Quest8_Aim = "Legt die D\195\164mmerungstrickfalle in den Vorf\195\188hrraum von Scholomance. Besiegt Vectus und kehrt dann zu Betina Bigglezink zur\195\188ck."
Inst20Quest8_Location = "Betina Bigglezink (\195\150stliche Pestl\195\164nder - Kapelle des hoffnungsvollen Lichts; "..YELLOW.."81,59"..WHITE..")"
Inst20Quest8_Note = "Die Questreihe beginnt mit Brutlingessenz bei Tinkee Steamboil(Brennende Steppe, 65,23). Der Vorf\195\188hrraum ist bei [6]."
Inst20Quest8_Prequest = "Ja, Brutlingessenz -> Betina Bigglezink"
Inst20Quest8_Folgequest = "Nein"
--
Inst20Quest8name1 = "Windschnitter"
Inst20Quest8name2 = "Tanzender Span"

--QUEST 9 Allianz

Inst20Quest9 = "9. Wichtellieferung (Hexenmeister)"
Inst20Quest9_Attain = "60"
Inst20Quest9_Level = "60"
Inst20Quest9_Aim = "Bringt den Wichtel im Gef\195\164\195\159 in das Alchimielabor in der Scholomance. Bringt nach der Herstellung des Pergaments, dass Gef\195\164\195\159 zur\195\188ck zu Gorzeeki Wildeyes."
Inst20Quest9_Location = "Gorzeeki Wildeyes (Brennende Steppe; "..YELLOW.."12,31"..WHITE..")"
Inst20Quest9_Note = "Dieses Quest kann nur von Hexenmeistern angenommen werden! Das Alchimielabor ist bei [3']."
Inst20Quest9_Prequest = "Ja, Lord Banehollow -> Xorothianischer Sternenstaub"
Inst20Quest9_Folgequest = "Ja,  Schreckensross von Xoroth"

--QUEST 1 Horde

Inst20Quest1_HORDE = "1. Verseuchte Jungtiere "
Inst20Quest1_HORDE_Attain = "55"
Inst20Quest1_HORDE_Level = "58"
Inst20Quest1_HORDE_Aim = "T\195\182tet 20 verseuchte Jungtiere und kehrt dann zu Betina Bigglezink bei der Kapelle des hoffnungsvollen Lichts zur\195\188ck."
Inst20Quest1_HORDE_Location = "Betina Bigglezink (\195\150stliche Pestl\195\164nder - Kapelle des hoffnungsvollen Lichts; "..YELLOW.."81,59"..WHITE..")"
Inst20Quest1_HORDE_Note = ""
Inst20Quest1_HORDE_Prequest = "Nein"
Inst20Quest1_HORDE_Folgequest = "Nein"

--QUEST 2 Horde

Inst20Quest2_HORDE = "2. Gesunde Gro\195\159drachenschuppe"
Inst20Quest2_HORDE_Attain = ""
Inst20Quest2_HORDE_Level = "58"
Inst20Quest2_HORDE_Aim = "Bringt die gesunde Gro\195\159drachenschuppe zu Betina Bigglezink bei der Kapelle des hoffnungsvollen Lichts in den \195\150stlichen Pestl\195\164ndern."
Inst20Quest2_HORDE_Location = "Gesunde Gro\195\159drachenschuppe (Drop) (Scholomance)"
Inst20Quest2_HORDE_Note = "Die Gesunde Gro\195\159drachenschuppe dropt bei den Verseuchte Jungtiere(8% Dropchance). Betina Bigglezink ist bei 81,59."
Inst20Quest2_HORDE_Prequest = "Ja, Verseuchte Jungtiere"
Inst20Quest2_HORDE_Folgequest = "Nein"

--Quest 3 Horde

Inst20Quest3_HORDE = "3. Doktor Theolen Krastinov, der Schl\195\164chter"
Inst20Quest3_HORDE_Attain = "55"
Inst20Quest3_HORDE_Level = "60"
Inst20Quest3_HORDE_Aim = "Sucht Doktor Theolen Krastinov in der Scholomance. Vernichtet ihn, verbrennt dann die \195\156berreste von Eva Sarkhoff und die \195\156berreste von Lucien Sarkhoff. Kehrt zu Eva Sarkhoff zur\195\188ck, sobald Ihr die Aufgabe erf\195\188llt habt."
Inst20Quest3_HORDE_Location = "Eva Sarkhoff (Westliche Pestl\195\164nder; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest3_HORDE_Note = "Doktor Theolen Krastinov ist bei [9]."
Inst20Quest3_HORDE_Prequest = "Nein"
Inst20Quest3_HORDE_Folgequest = "Ja, Krastinovs Tasche der Schrecken"

--QUEST 4 Horde

Inst20Quest4_HORDE = "4. Krastinovs Tasche der Schrecken"
Inst20Quest4_HORDE_Attain = "55"
Inst20Quest4_HORDE_Level = "60"
Inst20Quest4_HORDE_Aim = "Sucht nach Jandice Barov in der Scholomance und vernichtet sie. Entnehmt ihrer Leiche Krastinovs Tasche der Schrecken. Bringt die Tasche zu Eva Sarkhoff."
Inst20Quest4_HORDE_Location = "Eva Sarkhoff (Westliche Pestl\195\164nder; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest4_HORDE_Note = "Man findet Jandice Barov bei [3]."
Inst20Quest4_HORDE_Prequest = "Ja, Doktor Theolen Krastinov, der Schl\195\164chter"
Inst20Quest4_HORDE_Folgequest = "Ja, Kirtonos der Herold"

--QUEST 5 Horde

Inst20Quest5_HORDE = "5. Kirtonos der Herold"
Inst20Quest5_HORDE_Attain = "56"
Inst20Quest5_HORDE_Level = "60"
Inst20Quest5_HORDE_Aim = "Kehrt mit dem Blut Unschuldiger zur Scholomance zur\195\188ck. Sucht die Veranda und legt das Blut der Unschuldigen in die Kohlenpfanne. Kirtonos wird kommen, um sich von Eurer Seele zu n\195\164hren. K\195\164mpft tapfer, gebt keinen Fu\195\159breit nach! Vernichtet Kirtonos und kehrt zu Eva Sarkhoff zur\195\188ck."
Inst20Quest5_HORDE_Location = "Eva Sarkhoff (Westliche Pestl\195\164nder; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest5_HORDE_Note = "Die Kohlepfanne findet man bei [2]."
Inst20Quest5_HORDE_Prequest = "Ja, Krastinovs Tasche der Schrecken"
Inst20Quest5_HORDE_Folgequest = "Ja, Der Mensch Ras Frostraunen"
--
Inst20Quest5name1_HORDE = "Spektrale Essenz"
Inst20Quest5name2_HORDE = "Penelopes Rose"
Inst20Quest5name3_HORDE = "Mirahs Lied"

--QUEST 6 Horde

Inst20Quest6_HORDE = "6. Der Lich Ras Frostraunen"
Inst20Quest6_HORDE_Attain = "60"
Inst20Quest6_HORDE_Level = "60"
Inst20Quest6_HORDE_Aim = "Sucht Ras Frostraunen in der Scholomance. Wenn Ihr ihn gefunden habt, wendet das seelengebundene Andenken auf sein untotes Antlitz an. Solltet Ihr ihn erfolgreich in einen Sterblichen zur\195\188ckverwandeln k\195\182nnen, dann schlagt ihn nieder und nehmt den menschlichen Kopf von Ras Frostraunen an Euch. Bringt den Kopf zu Magistrat Marduke."
Inst20Quest6_HORDE_Location = "Magistrat Marduke (Westliche Pestl\195\164nder; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest6_HORDE_Note = "Ras Frostraunen findet man bei [7]."
Inst20Quest6_HORDE_Prequest = "Ja, Der Mensch Ras Frostraunen -> Seelengebundenes Andenken"
Inst20Quest6_HORDE_Folgequest = "Nein"
--
Inst20Quest6name1_HORDE = "Starkwache von Darrowshire"
Inst20Quest6name2_HORDE = "Kriegsklinge von Caer Darrow"
Inst20Quest6name3_HORDE = "Krone von Caer Darrow"
Inst20Quest6name4_HORDE = "Froststachel"

--QUEST 7 Horde

Inst20Quest7_HORDE = "7. Das Familienverm\195\182gen der Barovs"
Inst20Quest7_HORDE_Attain = "60"
Inst20Quest7_HORDE_Level = "60"
Inst20Quest7_HORDE_Aim = "Begebt Euch zur Scholomance und holt das Familienverm\195\182gen der Barovs zur\195\188ck. Dieses Verm\195\182gen besteht aus vier Besitzurkunden: Es sind die Besitzurkunde f\195\188r Caer Darrow, die Besitzurkunde f\195\188r Brill, die Besitzurkunde f\195\188r Tarrens M\195\188hle und die Besitzurkunde f\195\188r Southshore. Kehrt zu Alexi Barov zur\195\188ck, sobald die Aufgabe erledigt ist."
Inst20Quest7_HORDE_Location = "Alexi Barov (Westliche Pestl\195\164nder; "..YELLOW.."28,57"..WHITE..")"
Inst20Quest7_HORDE_Note = "Die Besitzurkunde f\195\188r Caer Darrow findet man bei [12], die Besitzurkunde f\195\188r Brill bei [7], Besitzurkunde f\195\188r Tarrens M\195\188hle bei [4] und die Besitzurkunde f\195\188r Southshore bei [1]."
Inst20Quest7_HORDE_Prequest = "Nein"
Inst20Quest7_HORDE_Folgequest = "Ja, Der letzte Barov"

--QUEST 8 Horde

Inst20Quest8_HORDE = "8. D\195\164mmerungstrickfalle"
Inst20Quest8_HORDE_Attain = "59"
Inst20Quest8_HORDE_Level = "60"
Inst20Quest8_HORDE_Aim = "Legt die D\195\164mmerungstrickfalle in den Vorf\195\188hrraum von Scholomance. Besiegt Vectus und kehrt dann zu Betina Bigglezink zur\195\188ck."
Inst20Quest8_HORDE_Location = "Betina Bigglezink (\195\150stliche Pestl\195\164nder - Kapelle des hoffnungsvollen Lichts; "..YELLOW.."81,59"..WHITE..")"
Inst20Quest8_HORDE_Note = "Die Questreihe beginnt mit Brutlingessenz bei Tinkee Steamboil(Brennende Steppe, 65,23). Der Vorf\195\188hrraum ist bei [6]."
Inst20Quest8_HORDE_Prequest = "Ja, Brutlingessenz -> Betina Bigglezink"
Inst20Quest8_HORDE_Folgequest = "Nein"
--
Inst20Quest8name1_HORDE = "Windschnitter"
Inst20Quest8name2_HORDE = "Tanzender Span"

--QUEST 9 Horde

Inst20Quest9_HORDE = "9. Wichtellieferung (Hexenmeister)"
Inst20Quest9_HORDE_Attain = "60"
Inst20Quest9_HORDE_Level = "60"
Inst20Quest9_HORDE_Aim = "Bringt den Wichtel im Gef\195\164\195\159 in das Alchimielabor in der Scholomance. Bringt nach der Herstellung des Pergaments, dass Gef\195\164\195\159 zur\195\188ck zu Gorzeeki Wildeyes."
Inst20Quest9_HORDE_Location = "Gorzeeki Wildeyes (Brennende Steppe; "..YELLOW.."12,31"..WHITE..")"
Inst20Quest9_HORDE_Note = "Dieses Quest kann nur von Hexenmeistern angenommen werden! Das Alchimielabor ist bei [3']."
Inst20Quest9_HORDE_Prequest = "Ja, Lord Banehollow -> Xorothianischer Sternenstaub"
Inst20Quest9_HORDE_Folgequest = "Ja,  Schreckensross von Xoroth"

--------------Inst7 (6  quests) /BFD------------
Inst7Story = "Die Blackfathom-Tiefen in der N\195\164he des Zoramstrandes in Ashenvale waren vor langer Zeit ein Tempel, den die Nachtelfen zu Ehren ihrer Mondg\195\182ttin Elune erbaut hatten. Doch als die Welt gespalten wurde versank der Tempel in den Fluten des verh\195\188llten Meeres. Dort ruhte er lange Zeit ungest\195\182rt, bis eines Tages die Naga und Satyrn auftauchten, angezogen von seiner uralten Kraft, um die Geheimnisse des Tempels zu ergr\195\188nden. Legenden zufolge soll das uralte Wesen Aku'mai sich ebenfalls in den Ruinen niedergelassen haben. Das liebste Scho\195\159tier der urzeitlichen G\195\182tter ist schon oft auf Beutez\195\188gen in der Gegend gesichtet worden. Die Gegenwart von Aku'mai hat auch einen Kult mit Namen Twilight's Hammer angezogen, der sich die b\195\182sen M\195\164chte der Alten G\195\182tter zunutze machen will."
Inst7Caption = "Die Blackfathom-Tiefen"
Inst7QAA = "6 Quests"
Inst7QAH = "5 Quests"

--QUEST 1 Allianz

Inst7Quest1 = "1. Wissen in der Tiefe"
Inst7Quest1_Attain = "18"
Inst7Quest1_Level = "23"
Inst7Quest1_Aim = "Bringt das 'Lorgalis-Manuskript' zu Gerrig Bonegrip in Ironforge."
Inst7Quest1_Location = "Gerrig Bonegrip (Ironforge; "..YELLOW.."50,5"..WHITE..")"
Inst7Quest1_Note = "Das Manuskript befindet sich bei [2] im Wasser."
Inst7Quest1_Prequest = "Nein"
Inst7Quest1_Folgequest = "Nein"
--
Inst7Quest1name1 = "Erhaltender Ring"

--QUEST 2 Allianz

Inst7Quest2 = "2. Erforschung der Verderbnis"
Inst7Quest2_Attain = "19"
Inst7Quest2_Level = "24"
Inst7Quest2_Aim = "Gershala Nightwhisper in Auberdine m\195\182chte 8 verderbte Hirnst\195\164mme."
Inst7Quest2_Location = "Gershala Nightwhisper (Darkshore - Auberdine; "..YELLOW.."38,43"..WHITE..")"
Inst7Quest2_Note = "Den Vorquest gibt es bei Argos Nightwhisper (Stormwind; 21,55). Die Gehirnst\195\164mme werden von den Nagas vor und in der Instanz gedroppt."
Inst7Quest2_Prequest = "Ja, Verderbnis in der Fremde"
Inst7Quest2_Folgequest = "Nein"
--
Inst7Quest2name1 = "K\195\164ferschnallen"
Inst7Quest2name2 = "Pr\195\164laturen-Cape"

--QUEST 3 Allianz

Inst7Quest3 = "3. Auf der Suche nach Thaelrid"
Inst7Quest3_Attain = "19"
Inst7Quest3_Level = "24"
Inst7Quest3_Aim = "Sucht Argentumwache Thaelrid in der Blackfathom-Tiefe auf."
Inst7Quest3_Location = "D\195\164mmerungsbeh\195\188ter Shaedlass (Darnassus; "..YELLOW.."55,24"..WHITE..")"
Inst7Quest3_Note = "Argentumwache Thaelrid findet man bei [3]."
Inst7Quest3_Prequest = "Nein"
Inst7Quest3_Folgequest = "Ja, Schurkerei in Blackfathom"

--QUEST 4 Alliance

Inst7Quest4 = "4. Schurkerei in Blackfathom"
Inst7Quest4_Attain = "-"
Inst7Quest4_Level = "27"
Inst7Quest4_Aim = "Bringt den Kopf des Twilight-Lords Kelris zu D\195\164mmerungsbeh\195\188ter Selgorm in Darnassus."
Inst7Quest4_Location = "Argentumwache Thaelrid (Blackfathomtiefen; "..YELLOW.."[4]"..WHITE..")"
Inst7Quest4_Note = "Den Quest bekommt man von Thaelrid bei [4]. Kelris findet man bei [8]. VORSICHT! Wenn sie die Feuerschalen bei Lord Kelris anz\195\188nden erscheinen mehrere Gegner(Krabben). Immer nur ein Feuer anzuz\195\188nden und dann die Krabben ausschalten, sonst wiped man hier sehr schnell. D\195\164mmerungsbeh\195\188ter Shaedlass findet man in Darnassus (55,24)"
Inst7Quest4_Prequest = "Ja, Auf der Suche nach Thaelrid"
Inst7Quest4_Folgequest = "Nein"
--
Inst7Quest4name1 = "Grabsteinszepter"
Inst7Quest4name2 = "Arktischer Rundschild"

--QUEST 5 Alliance

Inst7Quest5 = "5. Die Twilight fallen"
Inst7Quest5_Attain = "20"
Inst7Quest5_Level = "25"
Inst7Quest5_Aim = "Bringt 10 Twilight-Anh\195\164nger zu Argentumwache Manados in Darnassus"
Inst7Quest5_Location = "Argentumwache Manados (Darnassus; "..YELLOW.."55,23"..WHITE..")"
Inst7Quest5_Note = "Alle Twilightgegner droppen die Anh\195\164nger."
Inst7Quest5_Prequest = "Nein"
Inst7Quest5_Folgequest = "Nein"
--
Inst7Quest5name1 = "Nimbus-Stiefel"
Inst7Quest5name2 = "Herzholzgurt"

--QUEST 6 Alliance (hexenmeister)

Inst7Quest6 = "6. Die Kugel von Soran'ruk (Hexenmeister)"
Inst7Quest6_Attain = "21"
Inst7Quest6_Level = "26"
Inst7Quest6_Aim = "Sucht 3 Soran'ruk-Fragmente und 1 gro\195\159es Soran'ruk-Fragment und bringt sie zu Doan Karhan im Brachland."
Inst7Quest6_Location = "Doan Karhan (Brachland; "..YELLOW.."49,67"..WHITE..")"
Inst7Quest6_Note = "Diese Quest kann nur von Hexenmeistern angenommen werden! Die Soran'ruk-Fragmente werden von den Twilight-Akolyt in den [Blackfothamtiefen] gedroppt. Das gro\195\159e Soran'ruk-Fragment bekommt man in [Burg Shadowfang] bei Shadowfang-Dunkelseele."
Inst7Quest6_Prequest = "Nein"
Inst7Quest6_Folgequest = "Nein"
--
Inst7Quest6name1 = "Kugel von Soran'ruk"
Inst7Quest6name2 = "Stab von Soran'ruk"


--QUEST 1 Horde

Inst7Quest1_HORDE = "1. Die Essenz von Aku'mai"
Inst7Quest1_HORDE_Attain = "17"
Inst7Quest1_HORDE_Level = "22"
Inst7Quest1_HORDE_Aim = "Bringt 20 Saphire von Aku'mai zu Je'neu Sancrea nach Ashenvale."
Inst7Quest1_HORDE_Location = "Je'neu Sancrea (Ashenvale - Zoramstrand; "..YELLOW.."11,33"..WHITE..")"
Inst7Quest1_HORDE_Note = "Die Vorquest \195\132rger in der Tiefe bekommt man bei Tsunaman (Steinkrallengebirge, 47,64). Die Sapphire findet man vor der Instanz in den G\195\164ngen."
Inst7Quest1_HORDE_Prequest = "Ja, \195\132rger in der Tiefe"
Inst7Quest1_HORDE_Folgequest = "Nein"


--QUEST 2 Horde

Inst7Quest2_HORDE = "2. Treue zu den Alten G\195\182ttern"
Inst7Quest2_HORDE_Attain = "-"
Inst7Quest2_HORDE_Level = "26"
Inst7Quest2_HORDE_Aim = "Bringt die durchfeuchtete Notiz zu Je'neu Sancrea nach Ashenvale. -> T\195\182tet Lorgus Jett in der Blackfathom-Tiefe und kehrt dann zu Je'neu Sancrea nach Ashenvale zur\195\188ck."
Inst7Quest2_HORDE_Location = "Feuchte Notiz (drop) (Blackfathomtiefen; "..YELLOW..""..WHITE..")"
Inst7Quest2_HORDE_Note = "Die feuchte Notiz findet man bei Blackfathom-Gezeitenpriesterinen (5% dropchance). Lorgus Jett findet man bei [6]."
Inst7Quest2_HORDE_Prequest = "Nein"
Inst7Quest2_HORDE_Folgequest = "Nein"
--
Inst7Quest2name1_HORDE = "Band der Faust"
Inst7Quest2name2_HORDE = "Kastanienbrauner Mantel"

--QUEST 3 Horde

Inst7Quest3_HORDE = "3. Inmitten der Ruinen"
Inst7Quest3_HORDE_Attain = "-"
Inst7Quest3_HORDE_Level = "27"
Inst7Quest3_HORDE_Aim = "Bringt den Fathom-Kern zu Je'neu Sancrea im Zoram'gar-Au\195\159enposten in Ashenvale."
Inst7Quest3_HORDE_Location = "Je'neu Sancrea (Ashenvale - Zoramstrand; "..YELLOW.."11,33"..WHITE..")"
Inst7Quest3_HORDE_Note = "Den Fathom-Kern findet man bei [7] im Wasser. Sobald man ihn aufnimmt erscheint Lord Aquanis. Lord Aquanis dropt einen Questgegenstand diesen muss man zu Je'neu Sancrea (Ashenvale - Zoramstrand; 11,33) bringen"
Inst7Quest3_HORDE_Prequest = "Nein"
Inst7Quest3_HORDE_Folgequest = "Nein"

--QUEST 4 Horde

Inst7Quest4_HORDE = "4. Blackfathom-Schurkerei"
Inst7Quest4_HORDE_Attain = "-"
Inst7Quest4_HORDE_Level = "27"
Inst7Quest4_HORDE_Aim = "Bringt den Kopf des Twilight-Lords Kelris zu Bashana Runetotem in Thunder Bluff."
Inst7Quest4_HORDE_Location = "Argentumwache Thaelrid (Blackfathomtiefen; "..YELLOW.."[4]"..WHITE..")"
Inst7Quest4_HORDE_Note = "Den Quest bekommt man von Thaelrid bei [4]. Kelris findet man bei [8]. VORSICHT! Wenn sie die Feuerschalen bei Lord Kelris anz\195\188nden erscheinen mehrere Gegner(Krabben). Immer nur ein Feuer anzuz\195\188nden und dann die Krabben ausschalten, sonst wiped man hier sehr schnell. Bashana Runetotem findet man in Thunderbluff (70, 33)."
Inst7Quest4_HORDE_Prequest = "Nein"
Inst7Quest4_HORDE_Folgequest = "Nein"
--
Inst7Quest4name1_HORDE = "Grabsteinszepter"
Inst7Quest4name2_HORDE = "Arktischer Rundschild"

--QUEST 5 Horde (hexenmeister)

Inst7Quest5_HORDE = "5. Die Kugel von Soran'ruk (Hexenmeister)"
Inst7Quest5_HORDE_Attain = "20"
Inst7Quest5_HORDE_Level = "25"
Inst7Quest5_HORDE_Aim = "Sucht 3 Soran'ruk-Fragmente und 1 gro\195\159es Soran'ruk-Fragment und bringt sie zu Doan Karhan im Brachland."
Inst7Quest5_HORDE_Location = "Doan Karhan (Brachland; "..YELLOW.."49,57"..WHITE..")"
Inst7Quest5_HORDE_Note = "Diese Quest kann nur von Hexenmeistern angenommen werden! Die Soran'ruk-Fragmente werden von den Twilight-Akolyt in den [Blackfothamtiefen] gedroppt. Das gro\195\159e Soran'ruk-Fragment bekommt man in [Burg Shadowfang] bei Shadowfang-Dunkelseele."
Inst7Quest5_HORDE_Prequest = "Nein"
Inst7Quest5_HORDE_Folgequest = "Nein"
--
Inst7Quest5name1_HORDE = "Kugel von Soran'ruk"
Inst7Quest5name2_HORDE = "Stab von Soran'ruk"

--------------Inst25 /TEMPLE( 8 quests)------------
Inst25Story = "Vor mehr als tausend Jahren wurde das m\195\164chtige Reich der Gurubashi von einem gewaltigen B\195\188rgerkrieg auseinandergerissen. Eine einflussreiche Gruppe trollischer Priester, die als die Atal'ai bekannt waren, wagten den Versuch, einen uralten Blutgott namens Hakkar der Seelenschinder zu beschw\195\182ren. Obwohl ihr Plan vereitelt und die Priester letztenendes verbannt wurden zerbrach das Reich und kollabierte, da der Krieg s\195\164mtlichen inneren Zusammenhalt zwischen den Klans zerst\195\182rt hatte. Die verbannten Priester flohen weit in den Norden zu den S\195\188mpfen des Elends. Dort bauten sie Hakkar einen gro\195\159en Tempel, wo sie erneut seine R\195\188ckkehr in die Welt vorbereiten wollten. Als der gro\195\159e Drachenaspekt Ysera von den Pl\195\164nen der Atal'ai erfuhr gab es nichts, was den Zorn des Drachen zur\195\188ckhalten konnte, und so zerschmetterte sie den Tempel und lie\195\159 ihn in den Marschen versinken. Bis zum heutigen Tag werden die Ruinen des Tempels von gr\195\188nen Drachen bewacht, so dass niemand hinein oder hinaus kann. Allerdings sollen einige der verfluchten Atal'ai \195\188berlebt haben und immer noch an der Vollendung ihrer finsteren Pl\195\164ne arbeiten."
Inst25Caption = "Der versunkene Tempel"
--classq missing
Inst25QAA = "8 Quests"
Inst25QAH = "8 Quests"

--QUEST 1 Allianz

Inst25Quest1 = "1. Im Tempel von Atal'Hakkar"
Inst25Quest1_Attain = "46"
Inst25Quest1_Level = "50"
Inst25Quest1_Aim = "Sammelt 10 Schrifttafeln der Atal'ai f\195\188r Brohann Caskbelly in Stormwind."
Inst25Quest1_Location = "Brohann Caskbelly (Stormwind; "..YELLOW.."64,20"..WHITE..")"
Inst25Quest1_Note = "Man findet die Tafeln \195\188berall im Tempel."
Inst25Quest1_Prequest = "Ja, Auf der Suche nach dem Tempel(selber NPC) -> Rhapsodys Geschichte"
Inst25Quest1_Folgequest = "Nein"
--
Inst25Quest1name1 = "W\195\164chtertalisman"

--QUEST 2 Allianz

Inst25Quest2 = "2. Der versunkene Tempel"
Inst25Quest2_Attain = "-"
Inst25Quest2_Level = "51"
Inst25Quest2_Aim = "Sucht Marvon Rivetseeker in Tanaris."
Inst25Quest2_Location = "Angelas Moonbreeze (Feralas; "..YELLOW.."31,45"..WHITE..")"
Inst25Quest2_Note = "Marvon Rivetseeker findet man bei 52,45"
Inst25Quest2_Prequest = "Nein"
Inst25Quest2_Folgequest = "Ja, Der runde Stein"

--QUEST 3 Allianz

Inst25Quest3 = "3. In die Tiefen"
Inst25Quest3_Attain = "-"
Inst25Quest3_Level = "51"
Inst25Quest3_Aim = "Sucht den Altar von Hakkar im Versunkenen Tempel in den S\195\188mpfen des Elends."
Inst25Quest3_Location = "Marvon Rivetseeker (Tanaris; "..YELLOW.."52,45"..WHITE..")"
Inst25Quest3_Note = "Der Altar ist bei [1]."
Inst25Quest3_Prequest = "Ja, Der runde Stein"
Inst25Quest3_Folgequest = "Ja, Das Geheimnis des Kreises"

--QUEST 4 Alliance

Inst25Quest4 = "4. Das Geheimnis des Kreises"
Inst25Quest4_Attain = "-"
Inst25Quest4_Level = "51"
Inst25Quest4_Aim = "Reist zum Versunkenen Tempel und enth\195\188llt das Geheimnis, das sich in dem Kreis der Statuen verbirgt."
Inst25Quest4_Location = "Marvon Rivetseeker (Tanaris; "..YELLOW.."52,45"..WHITE..")"
Inst25Quest4_Note = "Man findet die Statuen bei [1]. \195\150ffnen muss man sie in der Reihenfolge:1-6"
Inst25Quest4_Prequest = "Ja, In die Tiefen"
Inst25Quest4_Folgequest = "Nein"
--
Inst25Quest4name1 = "Urne der Hakkari"

--QUEST 5 Alliance

Inst25Quest5 = "5. Der Dunst des B\195\182sen"
Inst25Quest5_Attain = "50"
Inst25Quest5_Level = "52"
Inst25Quest5_Aim = "Sammelt 5 Proben Dunst der Atal'ai und bringt sie Muigin im Un'Goro Krater."
Inst25Quest5_Location = "Gregan Brewspewer (Feralas; "..YELLOW.."45,25"..WHITE..")"
Inst25Quest5_Note = "Den Vorquest 'Muigin und Larion' bekommt man von Muigin (Un'Goro Crater 42,9). Den Dunst bekommt man von Tieflauerern, D\195\188sterw\195\188rmern oder Br\195\188hschlammern im Tempel."
Inst25Quest5_Prequest = "Ja, Muigin und Larion -> Ein Besuch bei Gregan"
Inst25Quest5_Folgequest = "Nein"


--QUEST 6 Alliance

Inst25Quest6 = "6. Der Gott Hakkar (Questreihe)"
Inst25Quest6_Attain = "43"
Inst25Quest6_Level = "53"
Inst25Quest6_Aim = "Bringt das gef\195\188llte Ei von Hakkar zu Yeh'kinya nach Tanaris."
Inst25Quest6_Location = "Yeh'kinya (Tanaris; "..YELLOW.."66,22"..WHITE..")"
Inst25Quest6_Note = "Die Questreihe beginnt mit 'Kreischergeister' beim selbem NPC(Siehe [Zul'Farrak]).\nDas Ei muss man bei [3] benutzen. Sobald man es aktiviert, spawnen Wellen von Mobs, die man besiegen muss. Einige der Mobs droppen das Blut von Hakkar, mit dem man eine der 4 brennenden Schalen in den Ecken l\195\182schen kann. Sobald alle 4 Schalen gel\195\182scht sind muss man den Avatar von Hakkar besiegen."
Inst25Quest6_Prequest = "Ja, Kreischergeister -> Das uralte Ei"
Inst25Quest6_Folgequest = "Nein"
--
Inst25Quest6name1 = "Avenwach-Helm"
Inst25Quest6name2 = "Langdolch der Lebenskraft"
Inst25Quest6name3 = "Edelsteinbesetzter Reif"

--QUEST 7 Allianz

Inst25Quest7 = "7. Jammal'an der Prophet"
Inst25Quest7_Attain = "43"
Inst25Quest7_Level = "53"
Inst25Quest7_Aim = "Der Verbannte der Atal'ai im Hinterland m\195\182chte den Kopf von Jammal'an."
Inst25Quest7_Location = "Der Verbannte der Atal'ai (Das Hinterland; "..YELLOW.."33,75"..WHITE..")"
Inst25Quest7_Note = "Jammal'an findet man bei [4]."
Inst25Quest7_Prequest = "Nein"
Inst25Quest7_Folgequest = "Nein"
--
Inst25Quest7name1 = "Regenschreiter-Gamaschen"
Inst25Quest7name2 = "Helm des Banns"

--QUEST 8 Allianz

Inst25Quest8 = "8. Die Essenz des Eranikus"
Inst25Quest8_Attain = "-"
Inst25Quest8_Level = "55"
Inst25Quest8_Aim = "Legt die Essenz von Eranikus in den Essenzborn, der sich in dem Versunkenen Tempel in seinem Unterschlupf befindet."
Inst25Quest8_Location = "Essenz des Eranikus (drop) (Der Versunkene Tempel)"
Inst25Quest8_Note = "Die Essenz des Eranikus wird von Eranikus gedroppt. Der Essenzborn befindet sich gleich bei ihm [6]."
Inst25Quest8_Prequest = "Nein"
Inst25Quest8_Folgequest = "Nein"
--
Inst25Quest8name1 = "Angekettete Essenz des Eranikus"


--QUEST 1 Horde

Inst25Quest1_HORDE = "1. Der Tempel von Atal'Hakkar"
Inst25Quest1_HORDE_Attain = "46"
Inst25Quest1_HORDE_Level = "50"
Inst25Quest1_HORDE_Aim = "Sammelt 20 Fetische von Hakkar und bringt sie zu Fel'Zerul in Stonard."
Inst25Quest1_HORDE_Location = "Fel'Zerul (S\195\188mpfe des Elends - Stonard; "..YELLOW.."47,54"..WHITE..")"
Inst25Quest1_HORDE_Note = "Alle Gegner im Tempel droppen die Fetische"
Inst25Quest1_HORDE_Prequest = "Ja, Tr\195\164nenteich -> R\195\188ckkehr zu Fel'Zerul"
Inst25Quest1_HORDE_Folgequest = "Nein"
--
Inst25Quest1name1_HORDE = "W\195\164chtertalisman"

--QUEST 2 Horde

Inst25Quest2_HORDE = "2. Der versunkene Tempel"
Inst25Quest2_HORDE_Attain = "-"
Inst25Quest2_HORDE_Level = "51"
Inst25Quest2_HORDE_Aim = "Sucht Marvon Rivetseeker in Tanaris."
Inst25Quest2_HORDE_Location = "Hexendoktor Uzer'i (Feralas; "..YELLOW.."74,43"..WHITE..")"
Inst25Quest2_HORDE_Note = "Marvon Rivetseeker findet man bei 52,45"
Inst25Quest2_HORDE_Prequest = "Nein"
Inst25Quest2_HORDE_Folgequest = "Ja, Der runde Stein"

--QUEST 3 Horde

Inst25Quest3_HORDE = "3. In die Tiefen"
Inst25Quest3_HORDE_Attain = "-"
Inst25Quest3_HORDE_Level = "51"
Inst25Quest3_HORDE_Aim = "Sucht den Altar von Hakkar im Versunkenen Tempel in den S\195\188mpfen des Elends."
Inst25Quest3_HORDE_Location = "Marvon Rivetseeker (Tanaris; "..YELLOW.."52,45"..WHITE..")"
Inst25Quest3_HORDE_Note = "Der Altar ist bei [1]."
Inst25Quest3_HORDE_Prequest = "Ja, Der runde Stein"
Inst25Quest3_HORDE_Folgequest = "Ja, Das Geheimnis des Kreises"

--QUEST 4 Horde

Inst25Quest4_HORDE = "4. Das Geheimnis des Kreises"
Inst25Quest4_HORDE_Attain = "-"
Inst25Quest4_HORDE_Level = "51"
Inst25Quest4_HORDE_Aim = "Reist zum Versunkenen Tempel und enth\195\188llt das Geheimnis, das sich in dem Kreis der Statuen verbirgt."
Inst25Quest4_HORDE_Location = "Marvon Rivetseeker (Tanaris; "..YELLOW.."52,45"..WHITE..")"
Inst25Quest4_HORDE_Note = "Man findet die Statuen bei [1]. \195\150ffnen muss man sie in der Reihenfolge:1-6"
Inst25Quest4_HORDE_Prequest = "Ja, In die Tiefen"
Inst25Quest4_HORDE_Folgequest = "Nein"
--
Inst25Quest4name1_HORDE = "Urne der Hakkari"

--QUEST 5 Horde

Inst25Quest5_HORDE = "5. Schrumpf-Treibstoff"
Inst25Quest5_HORDE_Attain = "50"
Inst25Quest5_HORDE_Level = "52"
Inst25Quest5_HORDE_Aim = "Bringt Larion in Marshals Zuflucht den ungeladenen Schrumpfer und 5 Proben Dunst der Atal'ai."
Inst25Quest5_HORDE_Location = "Liv Rizzlefix (Bachland; "..YELLOW.."62,38"..WHITE..")"
Inst25Quest5_HORDE_Note = "Den Vorquest 'Larion und Muigin' gibt es bei Larion (Un'Goro Crater 45,8). Man bekommt den Treibstoff von Tieflauerern, D\195\188sterw\195\188rmern oder Br\195\188hschlammern im Tempel."
Inst25Quest5_HORDE_Prequest = "Ja, Larion und Muigin -> Marvons Werkstatt"
Inst25Quest5_HORDE_Folgequest = "Nein"

--QUEST 6 Horde

Inst25Quest6_HORDE = "6. Der Gott Hakkar (Questreihe)"
Inst25Quest6_HORDE_Attain = "43"
Inst25Quest6_HORDE_Level = "53"
Inst25Quest6_HORDE_Aim = "Bringt das gef\195\188llte Ei von Hakkar zu Yeh'kinya nach Tanaris."
Inst25Quest6_HORDE_Location = "Yeh'kinya (Tanaris; "..YELLOW.."66,22"..WHITE..")"
Inst25Quest6_HORDE_Note = "Die Questreihe beginnt mit 'Kreischergeister' beim selbem NPC(Siehe [Zul'Farrak]).\nDas Ei muss man bei [3] benutzen. Sobald man es aktiviert, spawnen Wellen von Mobs, die man besiegen muss. Einige der Mobs droppen das Blut von Hakkar, mit dem man eine der 4 brennenden Schalen in den Ecken l\195\182schen kann. Sobald alle 4 Schalen gel\195\182scht sind muss man den Avatar von Hakkar besiegen."
Inst25Quest6_HORDE_Prequest = "Ja, Kreischergeister -> Das uralte Ei"
Inst25Quest6_HORDE_Folgequest = "Nein"
--
Inst25Quest6name1_HORDE = "Avenwach-Helm"
Inst25Quest6name2_HORDE = "Langdolch der Lebenskraft"
Inst25Quest6name3_HORDE = "Edelsteinbesetzter Reif"

--QUEST 7 Horde

Inst25Quest7_HORDE = "7. Jammal'an der Prophet"
Inst25Quest7_HORDE_Attain = "43"
Inst25Quest7_HORDE_Level = "53"
Inst25Quest7_HORDE_Aim = "Der Verbannte der Atal'ai im Hinterland m\195\182chte den Kopf von Jammal'an."
Inst25Quest7_HORDE_Location = "Der Verbannte der Atal'ai (Das Hinterland; "..YELLOW.."33,75"..WHITE..")"
Inst25Quest7_HORDE_Note = "Jammal'an findet man bei [4]."
Inst25Quest7_HORDE_Prequest = "Nein"
Inst25Quest7_HORDE_Folgequest = "Nein"
--
Inst25Quest7name1_HORDE = "Regenschreiter-Gamaschen"
Inst25Quest7name2_HORDE = "Helm des Banns"

--QUEST 8 Horde

Inst25Quest8_HORDE = "8. Die Essenz des Eranikus"
Inst25Quest8_HORDE_Attain = "-"
Inst25Quest8_HORDE_Level = "55"
Inst25Quest8_HORDE_Aim = "Legt die Essenz von Eranikus in den Essenzborn, der sich in dem Versunkenen Tempel in seinem Unterschlupf befindet."
Inst25Quest8_HORDE_Location = "Essenz des Eranikus (drop) (Der Versunkene Tempel)"
Inst25Quest8_HORDE_Note = "Die Essenz des Eranikus wird von Eranikus gedroppt. Der Essenzborn befindet sich gleich bei ihm (links) [6]."
Inst25Quest8_HORDE_Prequest = "Nein"
Inst25Quest8_HORDE_Folgequest = "Nein"
--
Inst25Quest8name1_HORDE = "Angekettete Essenz des Eranikus"

--------------Burg Shadowfang/Inst21/BSF ------------
Inst21Story = "W\195\164hrend des Dritten Krieges k\195\164mpften die Hexer der Kirin Tor gegen die untoten Armeen der Gei\195\159el. Mit jedem Hexer, der im Kampf fiel, stand kurze Zeit sp\195\164ter bereits ein weiterer Untoter auf Seiten der Gei\195\159el seinen einstmaligen Mitstreitern als Feind gegen\195\188ber. Frustriert \195\188ber den aussichtslosen Kampf beschloss der Erzmagier Arugal gegen den Willen seiner Kollegen, Wesen aus einer fremden Dimension zu Hilfe zu rufen um die schwindenden Reihen der Hexer zu st\195\164rken. Arugals Beschw\195\182rung brachte die gefr\195\164\195\159igen Worgen nach Azeroth. Zwar machten die unaufhaltsamen Werw\195\182lfe kurzen Prozess mit allem, was die Gei\195\159el ihnen entgegenstellte, doch nach kurzer Zeit wandten sie sich auch gegen die Magier, denen sie eigentlich dienen sollten. So kam es, dass die Worgen die Burg des adligen Barons Silverlaine jenseits des unscheinbaren D\195\182rfchens Pyrewood angriffen. Von Schuldgef\195\188hlen halb wahnsinnig adoptierte Arugal die Worgen als seine Kinder und zog sich in die inzwischen verfallene Burgruine zur\195\188ck. Dort soll er immer noch hausen, unter dem immer wachsamen Auge seines gewaltigen Scho\195\159hundes Fenrus, heimgesucht von dem rastlosen Geist von Baron Silverlaine."
Inst21Caption = "Burg Shadowfang"
Inst21QAA = "2 Quests"
Inst21QAH = "4 Quests"

--Quest 1 allianz

Inst21Quest1 = "1. Die Pr\195\188fung der Rechtschaffenheit (Paladin)"
Inst21Quest1_Level = "22"
Inst21Quest1_Attain = "20"
Inst21Quest1_Aim = "Sucht mit Jordans Waffennotizen etwas Wei\195\159steineichenholz, Bailors aufbereitete Erzlieferung, Jordans Schmiedehammer und einen Kor-Edelstein und bringt alles zusammen zu Jordan Stilwell in Ironforge."
Inst21Quest1_Location = "Jordan Stilwell (Dun Morogh - Ironforge Eingang "..YELLOW.."52,36 "..WHITE..")"
Inst21Quest1_Note = "Um die Notizen zu diesem Quest zu betrachten klick bitte auf [Die Pr\195\188fung der Rechtschaffenheit Informationen]."
Inst21Quest1_Prequest = "Ja, Der Foliant der Ehre -> Die Pr\195\188fung der Rechtschaffenheit"
Inst21Quest1_Folgequest = "Ja, Die Pr\195\188fung der Rechtschaffenheit"
--
Inst21Quest1name1 = "Verigans Faust"

Inst21Quest2 = "Die Pr\195\188fung der Rechtschaffenheit Informationen"
Inst21Quest2TEXT = "Nur Paladine k\195\182nnen diese Quest bekommen!\n1. Das Wei\195\159steineichenholz bekommt man von Goblin-Holzschnitzer in den [Todesminen].\n2. Um Bailors aufbereitete Erzlieferung zu bekommen muss man mit Bailor Stonehand (Loch Modan; 35,44 ) reden.  Er gibt einem die Quest 'Bailors Erzlieferung'. F\195\188r diese Quest muss man Jordans Erzlieferung finden. Sie ist bei 71,21 hinter einem Baum\n3. Jordans Schmiedehammer bekommt man in [Burg Shadowfang] nahe Punkt [B] (in den St\195\164llen).\n4. Den Kor-Edelstein bekommt man von Thundris Windweaver (Darkshore; 37,40) wenn man den Quest 'Suche nach dem Kor-Edelstein' macht. F\195\188r diese Quest muss man for den [Blackfathomtiefen] Blackfathom-Gezeitenpriesterin oder Blackfathom-Orakel t\195\182ten. Diese droppen den Verderbten Kor-Edelstein welchen Thundris Windweaver reinigt."
Inst21Quest2_Level = "100"
Inst21Quest2_Attain = ""
Inst21Quest2_Aim = ""
Inst21Quest2_Location = ""
Inst21Quest2_Note = ""
Inst21Quest2_Prequest = ""
Inst21Quest2_Folgequest = ""

--QUEST 2 allaince (hexenmeister)

Inst21Quest3 = "2. Die Kugel von Soran'ruk (Hexenmeister)"
Inst21Quest3_Attain = "20"
Inst21Quest3_Level = "25"
Inst21Quest3_Aim = "Sucht 3 Soran'ruk-Fragmente und 1 gro\195\159es Soran'ruk-Fragment und bringt sie zu Doan Karhan im Brachland."
Inst21Quest3_Location = "Doan Karhan (Brachland; "..YELLOW.."49,57"..WHITE..")"
Inst21Quest3_Note = "Diese Quest kann nur von Hexenmeistern angenommen werden! Die Soran'ruk-Fragmente werden von den Twilight-Akolyt in den [Blackfothamtiefen] gedroppt. Das gro\195\159e Soran'ruk-Fragment bekommt man in [Burg Shadowfang] bei Shadowfang-Dunkelseele."
Inst21Quest3_Prequest = "Nein"
Inst21Quest3_Folgequest = "Nein"
--
Inst21Quest3name1 = "Kugel von Soran'ruk"
Inst21Quest3name2 = "Stab von Soran'ruk"

--QUEST 1 Horde

Inst21Quest1_HORDE = "1. Todespirscher in Shadowfang"
Inst21Quest1_HORDE_Attain = "-"
Inst21Quest1_HORDE_Level = "25"
Inst21Quest1_HORDE_Aim = "Sucht die Todespirscher Adamant und Vincent."
Inst21Quest1_HORDE_Location = "Hochexekutor Hadrec (Silberwald; "..YELLOW.."43,40"..WHITE..")"
Inst21Quest1_HORDE_Note = "Man findet Adamant bei [1]. Vincet ist auf der rechten Seite, wenn man den Innenhof betritt."
Inst21Quest1_HORDE_Prequest = "Nein"
Inst21Quest1_HORDE_Folgequest = "Nein"
--
Inst21Quest1name1_HORDE = "Geisterhafter Mantel"

--QUEST 2 Horde

Inst21Quest2_HORDE = "2. Das Buch von Ur"
Inst21Quest2_HORDE_Attain = "16"
Inst21Quest2_HORDE_Level = "26"
Inst21Quest2_HORDE_Aim = "Bringt dem Bewahrer Bel'dugur im Apothekarium in Undercity das Buch von Ur."
Inst21Quest2_HORDE_Location = "Bewahrer Bel'dugur (Undercity; "..YELLOW.."53,54"..WHITE..")"
Inst21Quest2_HORDE_Note = "Man findet das Buch bei [6](auf der linken Seite, wenn man den Raum betritt)."
Inst21Quest2_HORDE_Prequest = "Nein"
Inst21Quest2_HORDE_Folgequest = "Nein"
--
Inst21Quest2name1_HORDE = "Ergraute Stiefel"
Inst21Quest2name2_HORDE = "Stahlschnallenarmschienen"

--QUEST 3 Horde

Inst21Quest3_HORDE = "3. Arugal muss sterben"
Inst21Quest3_HORDE_Attain = "?"
Inst21Quest3_HORDE_Level = "27"
Inst21Quest3_HORDE_Aim = "T\195\182tet Arugal und bringt Dalar Dawnweaver in dem Grabmal seinen Kopf."
Inst21Quest3_HORDE_Location = "Dalar Dawnweaver (Silberwald; "..YELLOW.."44,39"..WHITE..")"
Inst21Quest3_HORDE_Note = "Man findet Argual bei [8]."
Inst21Quest3_HORDE_Prequest = "Nein"
Inst21Quest3_HORDE_Folgequest = "Nein"
--
Inst21Quest3name1_HORDE = "Siegel von Sylvanas"

--QUEST 4 Horde (hexenmeister)

Inst21Quest4_HORDE = "4. Die Kugel von Soran'ruk (Hexenmeister)"
Inst21Quest4_HORDE_Attain = "20"
Inst21Quest4_HORDE_Level = "25"
Inst21Quest4_HORDE_Aim = "Sucht 3 Soran'ruk-Fragmente und 1 gro\195\159es Soran'ruk-Fragment und bringt sie zu Doan Karhan im Brachland."
Inst21Quest4_HORDE_Location = "Doan Karhan (Brachland; "..YELLOW.."49,57"..WHITE..")"
Inst21Quest4_HORDE_Note = "Diese Quest kann nur von Hexenmeistern angenommen werden! Die Soran'ruk-Fragmente werden von den Twilight-Akolyt in den [Blackfothamtiefen] gedroppt. Das gro\195\159e Soran'ruk-Fragment bekommt man in [Burg Shadowfang] bei Shadowfang-Dunkelseele."
Inst21Quest4_HORDE_Prequest = "Nein"
Inst21Quest4_HORDE_Folgequest = "Nein"
--
Inst21Quest4name1_HORDE = "Kugel von Soran'ruk"
Inst21Quest4name2_HORDE = "Stab von Soran'ruk"

--------------Inst5/Blackrocktiefen/BRD ------------
Inst5Story = "In dem vulkanischen Labyrinth, das von der einstigen Hauptstadt der Zwerge des D\195\188stereisenklans \195\188briggeblieben ist, herrscht nun Ragnaros der Feuerf\195\188rst \195\188ber die Abgr\195\188nde des Blackrock. Ragnaros ist es gelungen, das Geheimnis zu l\195\188ften, wie Leben aus Stein erschaffen werden kann. Nun plant er, sein neu gewonnenes Wissen dazu einzusetzen, eine Armee unaufhaltsamer Golems zu schaffen, die ihm bei der Eroberung des Blackrock helfen sollen. Vollkommen besessen von dem Gedanken daran, Nefarian endlich zu vernichten, wird Ragnaros alles tun, um seinen Konkurrenten aus dem Weg zu r\195\164umen."
Inst5Caption = "Die Blackrocktiefen"
Inst5QAA = "14 Quests"
Inst5QAH = "14 Quests"

--QUEST1 Allianz

Inst5Quest1 = "1. Dunkeleisenerbe"
Inst5Quest1_Attain = "48"
Inst5Quest1_Level = "52"
Inst5Quest1_Aim = "Erschlagt Fineous Darkvire und bergt den gro\195\159en Hammer Ironfel. Bringt Ironfel zum Schrein von Thaurissan und legt ihn auf die Statue von Franclorn Forgewright."
Inst5Quest1_Location = "Franclorn Forgewright (Blackrock)"
Inst5Quest1_Note = "Franclorn findet man in der Mitte des Blackrocks, auf einem(seinem) Steinsarg. Man kann ihn nur sehen, wenn man tot ist! Um die Quest zu starten m\195\188sst ihr 2 mal mit ihm sprechen.\nFineous Darkvire findet man bei [9]. Der Schrein ist rechts neben der Arena[7]."
Inst5Quest1_Prequest = "Nein"
Inst5Quest1_Folgequest = "Nein"
--
Inst5Quest1name1 = "Schl\195\188ssel zur Schattenschmiede"

--QUEST2 Allianz

Inst5Quest2 = "2. Ribbly Screwspigot"
Inst5Quest2_Attain = "50"
Inst5Quest2_Level = "53"
Inst5Quest2_Aim = "Bringt Yuka Screwspigot in der brennenden Steppe Ribblys Kopf."
Inst5Quest2_Location = "Yuka Screwspigot (Brennende Steppe "..YELLOW.."65,22"..WHITE..")"
Inst5Quest2_Note = "Die Vorquest bekommt man von Yorba Screwspigot (Tanaris; 67,23).\nRibbly findet man bei [15]."
Inst5Quest2_Prequest = "Ja, Yuka Screwspigot"
Inst5Quest2_Folgequest = "Nein"
--
Inst5Quest2name1 = "Groll-Stiefel"
Inst5Quest2name2 = "Bu\195\159werk-Schiftung"
Inst5Quest2name3 = "Stahlschienenr\195\188stung"

--QUEST3 Allianz

Inst5Quest3 = "3. Der Liebestrank"
Inst5Quest3_Attain = "50"
Inst5Quest3_Level = "54"
Inst5Quest3_Aim = "Bringt 4 Gromsblut-Kr\195\164uter, 10 Riesensilbervenen und Nagmaras gef\195\188llte Phiole zu Herrin Nagmara in den Blackrocktiefen."
Inst5Quest3_Location = "Nagmara (Blackrocktiefen, Schenke)"
Inst5Quest3_Note = "Die Riesensilbervenen bekommt man von Riesen in Azshara, Gromsblut kann man als Kr\195\164uterkundigner finden und die Phiole kann man beim Go-Lakka Krater (Un'Goro Krater; 31,50) f\195\188llen.\n Wenn man die Quest abschlie\195\159t brauch man den Phalanx nicht mehr t\195\182ten, man kann dann durch die Hintert\195\188r verschwinden."
Inst5Quest3_Prequest = "Nein"
Inst5Quest3_Folgequest = "Nein"
--
Inst5Quest3name1 = "Handfessel-Manschetten"
Inst5Quest3name2 = "Nagmaras Peitschen-G\195\188rtel"

--QUEST4 Allianz

Inst5Quest4 = "4. Hurley Pestatem"
Inst5Quest4_Attain = "?"
Inst5Quest4_Level = "55"
Inst5Quest4_Aim = "Bringt Ragnar Donnerbr\195\164u in Kharanos das gestohlene Donnerbr\195\164urezept."
Inst5Quest4_Location = "Ragnar Thunderbrew  (Dun Morogh "..YELLOW.."46,52"..WHITE..")"
Inst5Quest4_Note = "Die Vorquest gibt es bei Enohar Donnerbr\195\164u (Verw\195\188stete Lande; 61,18).\nDas Rezept gibt es bei einem der Wachen die erscheinen, wenn ihr F\195\164sser in der Taverne [15] zerst\195\182rt."
Inst5Quest4_Prequest = "Ja, Ragnar Donnerbr\195\164u"
Inst5Quest4_Folgequest = "Nein"
--
Inst5Quest4name1 = "Dunkles zwergisches Lagerbier "
Inst5Quest4name2 = "Hurtigschlagkn\195\188ppel"
Inst5Quest4name3 = "Gliedma\195\159enspaltbeil"

--QUEST5 Allianz

Inst5Quest5 = "5. Incendius!"
Inst5Quest5_Attain = "?"
Inst5Quest5_Level = "56"
Inst5Quest5_Aim = "Sucht Lord Incendius in den Blackrocktiefen und vernichtet ihn!"
Inst5Quest5_Location = "Jalinda Sprig (Brennende Steppe "..YELLOW.."85,69"..WHITE..")"
Inst5Quest5_Note = "Die Vorquest bekommt man auch von Jalinda Sprig. Pyron ist genau vor dem Instanztor.\nLord Incendius ist bei [10]."
Inst5Quest5_Prequest = "Ja, \195\156bermeister Pyron"
Inst5Quest5_Folgequest = "Nein"
--
Inst5Quest5name1 = "Sonnentuchcape"
Inst5Quest5name2 = "Nachtlauerhandschuhe"
Inst5Quest5name3 = "Gruftd\195\164monen-Armschienen"
Inst5Quest5name4 = "Wackere Umklammerung"

--QUEST6 Allianz

Inst5Quest6 = "6. Das Herz des Berges"
Inst5Quest6_Attain = "50"
Inst5Quest6_Level = "55"
Inst5Quest6_Aim = "Bringt das 'Herz des Berges' zu Maxwort Uberglint in der brennenden Steppe."
Inst5Quest6_Location = "Maxwort Uberglint (Brennende Steppe "..YELLOW.."65,23"..WHITE..")"
Inst5Quest6_Note = "Das Herz des Berges ist bei [10] in einem Safe."
Inst5Quest6_Prequest = "Nein"
Inst5Quest6_Folgequest = "Nein"

--QUEST7 Allianz

Inst5Quest7 = "7. Feine Sachen"
Inst5Quest7_Attain = "?"
Inst5Quest7_Level = "56"
Inst5Quest7_Aim = "Reist in die Blackrocktiefen und holt 20 Dunkeleiseng\195\188rteltaschen. Kehrt zu Oralius zur\195\188ck, sobald die Aufgabe erledigt ist. Ihr nehmt an, dass die Dunkeleisenzwerge in den Blackrocktiefen diese 'G\195\188rteltaschen'-Dinger tragen."
Inst5Quest7_Location = "Oralius (Brennende Steppe "..YELLOW.."84,68"..WHITE..")"
Inst5Quest7_Note = "Alle Zwergen k\195\182nnen die Taschen droppen."
Inst5Quest7_Prequest = "Nein"
Inst5Quest7_Folgequest = "Nein"
--
Inst5Quest7name1 = "Eine schmuddelige G\195\188rteltasche"

--QUEST8 Allianz

Inst5Quest8 = "8. Marshal Windsor (Onyxia-Questreihe)"
Inst5Quest8_Attain = "48"
Inst5Quest8_Level = "54"
Inst5Quest8_Aim = "Reist zum Blackrock im Nordwesten und dann weiter zu den Blackrocktiefen. Findet heraus, was aus Marshal Windsor geworden ist. Ihr erinnert Euch daran, dass der struppige John sagte, man h\195\164tte Windsor in ein Gef\195\164ngnis verschleppt."
Inst5Quest8_Location = "Marshal Maxwell (Brennende Steppe "..YELLOW.."84,68"..WHITE..")"
Inst5Quest8_Note = "Die Questreihe beginnt bei Helendis Riverhorn (Brennende Steppe "..YELLOW.."85,68"..WHITE..").\nMarshal Windsor ist bei [4]. Als Folgequest m\195\188sst ihr zu Maxwell zur\195\188ckkehren."
Inst5Quest8_Prequest = "Ja, Drachkin-Bedrohung -> Die wahren Meister"
Inst5Quest8_Folgequest = "Ja, Verlorene Hoffnung -> Eine zusammengekn\195\188llte Notiz"
--
Inst5Quest8name1 = "Konservator-Helm"
Inst5Quest8name2 = "Schildplattensabatons"
Inst5Quest8name3 = "Scherwindgamaschen"

--QUEST9 Allianz

Inst5Quest9 = "8. Eine zusammengekn\195\188llte Notiz (Onyxia-Questreihe)"
Inst5Quest9_Attain = "51"
Inst5Quest9_Level = "54"
Inst5Quest9_Aim = "Soeben seid Ihr auf etwas gesto\195\159en, das Marshal Windsor mit Sicherheit sehr interessiert. Vielleicht besteht ja doch noch Hoffnung."
Inst5Quest9_Location = "Eine zusammengekn\195\188llte Notiz(drop) (Die Blackrocktiefen)"
Inst5Quest9_Note = "Marshal Windsor ist bei [4]."
Inst5Quest9_Prequest = "Ja, Marshal Windsor"
Inst5Quest9_Folgequest = "Ja, Ein Funken Hoffnung"

--QUEST10 Allianz

Inst5Quest10 = "10. Ein Funken Hoffnung (Onyxia-Questreihe)"
Inst5Quest10_Attain = "51"
Inst5Quest10_Level = "58"
Inst5Quest10_Aim = "Holt Marshal Windsors verloren gegangene Informationen zur\195\188ck.\nMarshal Windsor glaubt, dass sich die Informationen in den H\195\164nden des Golemlords Argelmach und des Generals Zornesschmied befinden."
Inst5Quest10_Location = "Marshal Windsors (Die Blackrocktiefen "..YELLOW.."[4]"..WHITE..")"
Inst5Quest10_Note = "Marshal Windsor ist bei [4].\nGolemlord Argelmach ist bei [14], General Zornesschmied bei [13]."
Inst5Quest10_Prequest = "Ja, Eine zusammengekn\195\188llte Notiz"
Inst5Quest10_Folgequest = "Ja, Gef\195\164ngnisausbruch!"

--QUEST11 Allianz

Inst5Quest11 = "11. Gef\195\164ngnisausbruch! (Onyxia-Questreihe)"
Inst5Quest11_Attain = "54"
Inst5Quest11_Level = "58"
Inst5Quest11_Aim = "Helft Marshal Windsor, seine Ausr\195\188stung zur\195\188ckzuholen und seine Freunde zu befreien. Kehrt zu Marshal Windsor zur\195\188ck, wenn Ihr Erfolg hattet."
Inst5Quest11_Location = "Marshal Windsors (Die Blackrocktiefen "..YELLOW.."[4]"..WHITE..")"
Inst5Quest11_Note = "Marshal Windsor ist bei [4].\nDer Eskort ist wesentlich leichter, wenn der Ring des Gesetzes bzw der Weg auf dem Windsor langl\195\164uft vorher gereinigt wurde. Man findet Marshal Maxwell in der Brennende Steppe( "..YELLOW.."84,68"..WHITE..")"
Inst5Quest11_Prequest = "Ja, Ein Funken Hoffnung"
Inst5Quest11_Folgequest = "Ja, Treffen in Stormwind"
--
Inst5Quest11name1 = "Barriere der Elemente"
Inst5Quest11name2 = "Klinge der Abrechnung"
Inst5Quest11name3 = "Geschickte Kampfklinge"

--QUEST12 Allianz

Inst5Quest12 = "12. Eine Kostprobe der Flamme (Questreihe)"
Inst5Quest12_Attain = "52"
Inst5Quest12_Level = "58"
Inst5Quest12_Aim = "Begebt Euch in die Blackrocktiefen und t\195\182tet Bael'Gar. [...] Bringt die eingeschlossene feurige Essenz zu Cyrus Therepentous zur\195\188ck."
Inst5Quest12_Location = "Cyrus Therepentous (Brennende Steppe "..YELLOW.."94,31"..WHITE..")"
Inst5Quest12_Note = "Die Questreihe startet bei Kalaran Windblade (Sengende Schlucht; 39,38).\nBael'Gar findet man bei [11]."
Inst5Quest12_Prequest = "Ja, Die fehlerlose Flamme -> Eine Kostprobe der Flamme"
Inst5Quest12_Folgequest = "Nein"
--
Inst5Quest12name1 = "Schieferhautcape"
Inst5Quest12name2 = "Wyrmbalg-Schiftung"
Inst5Quest12name3 = "Valconische Sch\195\164rpe"

--QUEST13 Allianz

Inst5Quest13 = "13. Kharan Mighthammer"
Inst5Quest13_Attain = "?"
Inst5Quest13_Level = "59"
Inst5Quest13_Aim = "Begebt Euch in die Blackrocktiefen und findet Kharan Mighthammer.\nDer K\195\182nig erw\195\164hnte, dass Kharan dort gefangen sei - vielleicht solltet Ihr nach einem Gef\195\164ngnis Ausschau halten."
Inst5Quest13_Location = "K\195\182nig Magni Bronzebeard (Ironforge "..YELLOW.."39,55"..WHITE..")"
Inst5Quest13_Note = "Die Vorquest startet bei K\195\182nigliche Historikerin Archesonus (Ironforge; 38,55).\nKharan Mighthammer ist bei [2]."
Inst5Quest13_Prequest = "Ja, Die glimmenden Ruinen von Thaurissan"
Inst5Quest13_Folgequest = "Ja, Der \195\156berbringer schlechter Botschaften"

--QUEST14 Allianz

Inst5Quest14 = "14. Das Schicksal des K\195\182nigreichs"
Inst5Quest14_Attain = "?"
Inst5Quest14_Level = "59"
Inst5Quest14_Aim = "Kehrt in die Blackrocktiefen zur\195\188ck und rettet Prinzessin Moira Bronzebeard aus den F\195\164ngen des b\195\182sen Imperators Dagran Thaurissan."
Inst5Quest14_Location = "K\195\182nig Magni Bronzebeard (Ironforge "..YELLOW.."39,55"..WHITE..")"
Inst5Quest14_Note = "Prinzessin Moira Bronzebeard ist bei [21]. W\195\164hrend des Kampfs versucht sie Dagran zu heilen. Versucht ihre Zauber so oft wie m\195\182glich zu unterbrechen. Sie darf aber auf keinen Fall sterben, sonst k\195\182nnt ihr den Quest nicht abschlie\195\159en! Sobald ihr mit ihr geredet habt kehrt zu Magni Bronzebeard zur\195\188ck."
Inst5Quest14_Prequest = "Ja, Der \195\156berbringer schlechter Botschaften"
Inst5Quest14_Folgequest = "Ja, Die \195\156berraschung der Prinzessin"
--
Inst5Quest14name1 = "Magnis Wille"
Inst5Quest14name2 = "Liedstein von Ironforge"


--QUEST1 Horde

Inst5Quest1_HORDE = "1. Dunkeleisenerbe"
Inst5Quest1_HORDE_Attain = "48"
Inst5Quest1_HORDE_Level = "52"
Inst5Quest1_HORDE_Aim = "Erschlagt Fineous Darkvire und bergt den gro\195\159en Hammer Ironfel. Bringt Ironfel zum Schrein von Thaurissan und legt ihn auf die Statue von Franclorn Forgewright."
Inst5Quest1_HORDE_Location = "Franclorn Forgewright (Blackrock)"
Inst5Quest1_HORDE_Note = "Franclorn findet man in der Mitte des Blackrocks, auf einem(seinem) Steinsarg. Man kann ihn nur sehen, wenn man tot ist! Um die Quest zu starten m\195\188sst ihr 2 mal mit ihm sprechen.\nFineous Darkvire findet man bei [9]. Der Schrein ist rechts neben der Arena[7]."
Inst5Quest1_HORDE_Prequest = "Nein"
Inst5Quest1_HORDE_Folgequest = "Nein"
--
Inst5Quest1name1_HORDE = "Schl\195\188ssel zur Schattenschmiede"

--QUEST2 Horde

Inst5Quest2_HORDE = "2. Ribbly Screwspigot"
Inst5Quest2_HORDE_Attain = "50"
Inst5Quest2_HORDE_Level = "53"
Inst5Quest2_HORDE_Aim = "Bringt Yuka Screwspigot in der brennenden Steppe Ribblys Kopf."
Inst5Quest2_HORDE_Location = "Yuka Screwspigot (Brennende Steppe "..YELLOW.."65,22"..WHITE..")"
Inst5Quest2_HORDE_Note = "Die Vorquest bekommt man von Yorba Screwspigot (Tanaris; 67,23).\nRibbly findet man bei [15]."
Inst5Quest2_HORDE_Prequest = "Ja, Yuka Screwspigot"
Inst5Quest2_HORDE_Folgequest = "Nein"
--
Inst5Quest2name1_HORDE = "Groll-Stiefel"
Inst5Quest2name2_HORDE = "Bu\195\159werk-Schiftung"
Inst5Quest2name3_HORDE = "Stahlschienenr\195\188stung"

--QUEST3 Horde

Inst5Quest3_HORDE = "3. Der Liebestrank"
Inst5Quest3_HORDE_Attain = "50"
Inst5Quest3_HORDE_Level = "54"
Inst5Quest3_HORDE_Aim = "Bringt 4 Gromsblut-Kr\195\164uter, 10 Riesensilbervenen und Nagmaras gef\195\188llte Phiole zu Herrin Nagmara in den Blackrocktiefen."
Inst5Quest3_HORDE_Location = "Nagmara (Blackrocktiefen, Schenke)"
Inst5Quest3_HORDE_Note = "Die Riesensilbervenen bekommt man von Riesen in Azshara, Gromsblut kann man als Kr\195\164uterkundigner finden und die Phiole kann man beim Go-Lakka Krater (Un'Goro Krater; 31,50) f\195\188llen.\n Wenn man die Quest abschlie\195\159t brauch man den Phalanx nicht mehr t\195\182ten, man kann dann durch die Hintert\195\188r verschwinden."
Inst5Quest3_HORDE_Prequest = "Nein"
Inst5Quest3_HORDE_Folgequest = "Nein"
--
Inst5Quest3name1_HORDE = "Handfessel-Manschetten"
Inst5Quest3name2_HORDE = "Nagmaras Peitschen-G\195\188rtel"

--QUEST 4 Horde

Inst5Quest4_HORDE = "4. Verlorenes Donnerbr\195\164urezept"
Inst5Quest4_HORDE_Attain = "50"
Inst5Quest4_HORDE_Level = "55"
Inst5Quest4_HORDE_Aim = "Bringt Vivian Lagrave in Kargath das gestohlene Donnerbr\195\164urezept."
Inst5Quest4_HORDE_Location = "Schattenmagierin Vivian Lagrave (\195\150dland - Kargath; "..YELLOW.."2,47"..WHITE..")"
Inst5Quest4_HORDE_Note = "Den Vorquest bekommt man bei Apotheker Zinge in Undercity(50,68).\nDas Rezept gibt es bei einem der Wachen die erscheinen, wenn ihr F\195\164sser in der Taverne [15] zerst\195\182rt."
Inst5Quest4_HORDE_Prequest = "Ja, Vivian Lagrave"
Inst5Quest4_HORDE_Folgequest = "Nein"
--
Inst5Quest4name1_HORDE = "\195\156berragender Heiltrank"
Inst5Quest4name2_HORDE = "Gro\195\159er Manatrank"
Inst5Quest4name3_HORDE = "Hurtigschlagkn\195\188ppel"
Inst5Quest4name4_HORDE = "Gliedma\195\159enspaltbeil"

--QUEST5 Horde

Inst5Quest5_HORDE = "5. Das Herz des Berges"
Inst5Quest5_HORDE_Attain = "50"
Inst5Quest5_HORDE_Level = "55"
Inst5Quest5_HORDE_Aim = "Bringt das 'Herz des Berges' zu Maxwort Uberglint in der brennenden Steppe."
Inst5Quest5_HORDE_Location = "Maxwort Uberglint (Brennende Steppe "..YELLOW.."65,23"..WHITE..")"
Inst5Quest5_HORDE_Note = "Das Herz des Berges ist bei [10] in einem Safe."
Inst5Quest5_HORDE_Prequest = "Nein"
Inst5Quest5_HORDE_Folgequest = "Nein"

--QUEST 6 Horde

Inst5Quest6_HORDE = "6. SOFORT T\195\150TEN: Dunkeleisenzwerge"
Inst5Quest6_HORDE_Attain = "48"
Inst5Quest6_HORDE_Level = "52"
Inst5Quest6_HORDE_Aim = "Kriegsherr Goretooth m\195\182chte, dass Ihr 15 Gardisten der Zornesh\195\164mmer, 10 Aufseher der Zornesh\195\164mmer und 5 Fu\195\159soldaten der Zornesh\195\164mmer t\195\182tet. Kehrt zu ihm zur\195\188ck, sobald Ihr die Aufgabe erf\195\188llt habt."
Inst5Quest6_HORDE_Location = "Gesucht-Schild (\195\150dland - Kargath; "..YELLOW.."3,47"..WHITE..")"
Inst5Quest6_HORDE_Note = "Man findet die Zwerge im ersten Abschnitt der Blackrocktiefen.\nKriegsherr Goretooth ist in Kargath auf dem Turm(\195\150dland, 5,47)."
Inst5Quest6_HORDE_Prequest = "Nein"
Inst5Quest6_HORDE_Folgequest = "Ja, Sofort T\195\182ten : Wichtige Dunkeleisen Offiziere"

--QUEST 7 Horde

Inst5Quest7_HORDE = "7. Sofort T\195\182ten : Wichtige Dunkeleisen Offiziere"
Inst5Quest7_HORDE_Attain = "50"
Inst5Quest7_HORDE_Level = "54"
Inst5Quest7_HORDE_Aim = "Kriegsherr Goretooth m\195\182chte, dass Ihr 10 Sanit\195\164ter der Zornesh\195\164mmer, 10 Soldaten der Zornesh\195\164mmer und 10 Offiziere der Zornesh\195\164mmer t\195\182tet. Kehrt zu ihm zur\195\188ck, sobald Ihr die Aufgabe erf\195\188llt habt."
Inst5Quest7_HORDE_Location = "Gesucht-Schild (\195\150dland - Kargath; "..YELLOW.."3,47"..WHITE..")"
Inst5Quest7_HORDE_Note = "Man findet die Zwerge in der N\195\164he von Bael´Gar [11]. Kriegsherr Goretooth ist in Kargath auf dem Turm(\195\150dland; 5,47).\nDer Folgquest beginnt bei Lexlort(Kargath; 5,47). Gark Lorkrub findet man in der Brennenden Steppe(38,35). Nachdem man ihn besiegt hat startet er einen Eskortquest."
Inst5Quest7_HORDE_Prequest = "Ja, SOFORT T\195\150TEN: Dunkeleisenzwerge"
Inst5Quest7_HORDE_Folgequest = "Ja, Grark Lorkrub -> Gef\195\164hrliche Zwickm\195\188hle(Eskortquest)"

--Quest8 Horde

Inst5Quest8_HORDE = "8. Operation: Tod dem Zornesschmied"
Inst5Quest8_HORDE_Attain = "55"
Inst5Quest8_HORDE_Level = "58"
Inst5Quest8_HORDE_Aim = "Begebt Euch zu den Blackrocktiefen und eliminiert General Zornesschmied! Kehrt zum Kriegsherrn Goretooth zur\195\188ck, sobald Ihr diese Aufgabe erledigt habt."
Inst5Quest8_HORDE_Location = "Kriegsherrn Goretooth (\195\150dland - Kargath; "..YELLOW.."5,47"..WHITE..")"
Inst5Quest8_HORDE_Note = "Man findet General Zornesschmied bei [13]. Wenn er auf ca 30% ist ruft er Verst\195\164rkung!"
Inst5Quest8_HORDE_Prequest = "Ja, Gef\195\164hrliche Zwickm\195\188hle"
Inst5Quest8_HORDE_Folgequest = "Nein"
--
Inst5Quest8name1_HORDE = "Medaillon des Eroberers"

--Quest9 Horde

Inst5Quest9_HORDE = "9. Aufstieg der Maschinen"
Inst5Quest9_HORDE_Attain = "?"
Inst5Quest9_HORDE_Level = "58"
Inst5Quest9_HORDE_Aim = "Sucht und t\195\182tet Golemlord Argelmach. Bringt Lotwil seinen Kopf. Au\195\159erdem m\195\188sst Ihr 10 intakte Elementarkerne von den Wuth\195\164schergolems und Kriegshetzerkonstrukten, die Argelmach besch\195\188tzen, beschaffen."
Inst5Quest9_HORDE_Location = "Lotwil Veriatus (\195\150dland; "..YELLOW.."25,44"..WHITE..")"
Inst5Quest9_HORDE_Note = "Den Vorquest bekommt man bei Hierophantin Theodora Mulvadania(Kargath - \195\150dland; 3,47).\nMan findet Argelmach bei [14]."
Inst5Quest9_HORDE_Prequest = "Ja, Aufstieg der Maschinen"
Inst5Quest9_HORDE_Folgequest = "Nein"
--
Inst5Quest9name1_HORDE = "Azurblaue Mondamicia"
Inst5Quest9name2_HORDE = "Regenzauberer-Tuch"
Inst5Quest9name3_HORDE = "Basaltschuppenr\195\188stung"
Inst5Quest9name4_HORDE = "Lavaplattenstulpen"

--QUEST13 Horde

Inst5Quest10_HORDE = "10. Eine Kostprobe der Flamme (Questreihe)"
Inst5Quest10_HORDE_Attain = "52"
Inst5Quest10_HORDE_Level = "58"
Inst5Quest10_HORDE_Aim = "Begebt Euch in die Blackrocktiefen und t\195\182tet Bael'Gar. [...] Bringt die eingeschlossene feurige Essenz zu Cyrus Therepentous zur\195\188ck."
Inst5Quest10_HORDE_Location = "Cyrus Therepentous (Brennende Steppe "..YELLOW.."94,31"..WHITE..")"
Inst5Quest10_HORDE_Note = "Die Questreihe startet bei Kalaran Windblade (Sengende Schlucht; 39,38).\nBael'Gar findet man bei [11]."
Inst5Quest10_HORDE_Prequest = "Ja, Die fehlerlose Flamme -> Eine Kostprobe der Flamme"
Inst5Quest10_HORDE_Folgequest = "Nein"
--
Inst5Quest10name1_HORDE = "Schieferhautcape"
Inst5Quest10name2_HORDE = "Wyrmbalg-Schiftung"
Inst5Quest10name3_HORDE = "Valconische Sch\195\164rpe"

--QUEST 6 Horde

Inst5Quest11_HORDE = "11. Disharmonie des Feuers"
Inst5Quest11_HORDE_Attain = "?"
Inst5Quest11_HORDE_Level = "56"
Inst5Quest11_HORDE_Aim = "Betretet die Blackrocktiefen und sp\195\188rt Lord Incendius auf. T\195\182tet ihn und bringt jegliche Informationsquelle, die Ihr finden k\195\182nnt, zu Thunderheart."
Inst5Quest11_HORDE_Location = "Thunderheart (\195\150dland - Kargath; "..YELLOW.."3,48"..WHITE..")"
Inst5Quest11_HORDE_Note = "Die Vorquest bekommt man auch von Thunderheart. Pyron ist genau vor dem Instanztor.\nLord Incendius ist bei [10]."
Inst5Quest11_HORDE_Prequest = "Ja, Disharmonie der Flamme"
Inst5Quest11_HORDE_Folgequest = "Nein"
--
Inst5Quest11name1_HORDE = "Sonnentuchcape"
Inst5Quest11name2_HORDE = "Nachtlauerhandschuhe"
Inst5Quest11name3_HORDE = "Gruftd\195\164monen-Armschienen"
Inst5Quest11name4_HORDE = "Wackere Umklammerung"

--QUEST 12 Horde

Inst5Quest12_HORDE = "12. Das letzte Element"
Inst5Quest12_HORDE_Attain = "?"
Inst5Quest12_HORDE_Level = "54"
Inst5Quest12_HORDE_Aim = "Begebt Euch in die Blackrocktiefen und beschafft 10 Essenzen der Elemente. Euer erster Gedanke ist, die Golems und die Sch\195\182pfer der Golems zu suchen. Doch Ihr erinnert Euch, dass Vivian Lagrave auch etwas von Elementaren vor sich hingemurmelt hat."
Inst5Quest12_HORDE_Location = "Schattenmagierin Vivian Lagrave (\195\150dland - Kargath; "..YELLOW.."2,47"..WHITE..")"
Inst5Quest12_HORDE_Note = "Die Vorquest bekommt man von Thunderheart (\195\150dland - Kargath; "..YELLOW.."3,48"..WHITE.."). Pyron ist genau vor dem Instanztor.\n Alle Elementare droppen die Essenzen."
Inst5Quest12_HORDE_Prequest = "Ja, Disharmonie der Flamme"
Inst5Quest12_HORDE_Folgequest = "Nein"
--
Inst5Quest12name1_HORDE = "Lagraves Siegel"

--QUEST 13 Horde

Inst5Quest13_HORDE = "13. Kommandant Gor'shak"
Inst5Quest13_HORDE_Attain = "?"
Inst5Quest13_HORDE_Level = "52"
Inst5Quest13_HORDE_Aim = "Sucht Kommandant Gor'shak in den Blackrocktiefen.\nIhr erinnert Euch, dass auf dem primitiv gezeichneten Bild des Orcs auch Gitter vor dem Gesicht zu sehen waren. Vielleicht solltet Ihr nach einer Art Gef\195\164ngnis suchen."
Inst5Quest13_HORDE_Location = "Galamav der Sch\195\188tze (\195\150dland - Kargath; "..YELLOW.."5,47"..WHITE..")"
Inst5Quest13_HORDE_Note = "Die Vorquest bekommt man von Thunderheart (\195\150dland - Kargath; "..YELLOW.."3,48"..WHITE.."). Pyron ist genau vor dem Instanztor.\nKommandant Gor'shak ist bei [3]. Den Schl\195\188ssel um die Zelle zu \195\182ffnen dropt Gerstahn[5]. Wenn man den Folgequest startet spawnen mehrere Gegner."
Inst5Quest13_HORDE_Prequest = "Ja, Disharmonie der Flamme"
Inst5Quest13_HORDE_Folgequest = "Ja, Was ist los?(Event)"

--QUEST14 Horde

Inst5Quest14_HORDE = "14. Die k\195\182nigliche Rettung"
Inst5Quest14_HORDE_Attain = "51"
Inst5Quest14_HORDE_Level = "59"
Inst5Quest14_HORDE_Aim = "T\195\182tet Imperator Dagran Thaurissan und befreit Prinzessin Moira Bronzebeard von seinem b\195\182sen Zauber."
Inst5Quest14_HORDE_Location = "Thrall (Orgrimmar; "..YELLOW.."31,37"..WHITE..")"
Inst5Quest14_HORDE_Note = "Nachdem man mit Kharan Mighthammer und Thrall geredet hat bekommt man diese Quest.\nMan findet Imperator Dagran Thaurissan bei [21]. Die Prinzessin heilt Dagran w\195\164hrend des Kampfs, sie darf aber auf keinen Fall sterben sonst ist kann man den Quest nicht abschlie\195\159en! Versucht ihre Heilungzauber zu unterbrechen. (Die Belohung sind f\195\188r Ist die Prinzessin gerettet?)"
Inst5Quest14_HORDE_Prequest = "Ja, Kommandant Gor'shak"
Inst5Quest14_HORDE_Folgequest = "Ja, Ist die Prinzessin gerettet?"
--
Inst5Quest14name1_HORDE = "Thralls Entschlossenheit"
Inst5Quest14name2_HORDE = "Auge von Orgrimmar"


--------------Inst8 / lower blackrock spier ------------
Inst8Story = "Die m\195\164chtige Festung, die aus der feurigen Flanke des Blackrock herausgeschnitten wurde, geht auf Entw\195\188rfe des zwergischen Meistersteinmetzes Franclorn Forgewright zur\195\188ck. Jahrhunderte lang war die Zitadelle ein Symbol der Macht des D\195\188stereisenklans, das von den Zwergen mit \195\164u\195\159erstem Ingrimm verteidigt wurde. Allerdings gab es jemanden, der andere Pl\195\164ne f\195\188r die Zitadelle hatte: Nefarian, der listige Sohn des Drachen Deathwing, stieg eines Tages mit Flamme und Klaue auf den oberen Teil der Zitadelle hinab und trug zusammen mit seinen drachischen Untergebenen den Kampf bis zu den Stellungen der Zwerge tief unten, bei den vulkanischen Abgr\195\188nden unter dem Berg. Dort erkannte der Drache, dass der Anf\195\188hrer der Zwerge kein geringerer als der Feuerf\195\188rst Ragnaros h\195\182chstpers\195\182nlich war. Nachdem sein Vordringen gestoppt worden war, schwor sich Nefarian, seine Feinde endg\195\188ltig zu vernichten und somit die Herrschaft \195\188ber den Blackrock an sich zu rei\195\159en."
Inst8Caption = "Die Zitadelle des Blackrocks"

--------------Inst9 / upper blackrock spier ------------
Inst9Story = "Die m\195\164chtige Festung, die aus der feurigen Flanke des Blackrock herausgeschnitten wurde, geht auf Entw\195\188rfe des zwergischen Meistersteinmetzes Franclorn Forgewright zur\195\188ck. Jahrhunderte lang war die Zitadelle ein Symbol der Macht des D\195\188stereisenklans, das von den Zwergen mit \195\164u\195\159erstem Ingrimm verteidigt wurde. Allerdings gab es jemanden, der andere Pl\195\164ne f\195\188r die Zitadelle hatte: Nefarian, der listige Sohn des Drachen Deathwing, stieg eines Tages mit Flamme und Klaue auf den oberen Teil der Zitadelle hinab und trug zusammen mit seinen drachischen Untergebenen den Kampf bis zu den Stellungen der Zwerge tief unten, bei den vulkanischen Abgr\195\188nden unter dem Berg. Dort erkannte der Drache, dass der Anf\195\188hrer der Zwerge kein geringerer als der Feuerf\195\188rst Ragnaros h\195\182chstpers\195\182nlich war. Nachdem sein Vordringen gestoppt worden war, schwor sich Nefarian, seine Feinde endg\195\188ltig zu vernichten und somit die Herrschaft \195\188ber den Blackrock an sich zu rei\195\159en."
Inst9Caption = "Die Zitadelle des Blackrocks"

--------------Dire Maul East/ Inst10------------
Inst10Story = "Vor fast zw\195\182lftausend Jahren errichtete eine geheime Sekte nachtelfischer Zauberer die uralte Stadt Eldre'Thalas, um die wertvollsten Geheimnisse von K\195\182nigin Azshara zu sch\195\188tzen. Selbst die Ruinen der Stadt, die w\195\164hrend der Spaltung der Welt verw\195\188stet wurde, sind immer noch \195\164u\195\159erst beeindruckend und ehrfurchtgebietend. In den drei Fl\195\188geln der Stadt, die heute nur noch als der D\195\188sterbruch bekannt ist, haben sich inzwischen die seltsamsten Kreaturen niedergelassen – besonders die spektralen Hochgeborenen, die hinterh\195\164ltigen Satyrn und die brutalen Oger. Nur die mutigsten Abenteurer sollten sich dieser verfluchten Ruine n\195\164hern und die unglaublichen Schrecken herausfordern, die hinter den verfallenen Mauern lauern."
Inst10Caption = "Der D\195\188sterbruch"

--------------Dire Maul North/ Inst11------------
Inst11Story = "Vor fast zw\195\182lftausend Jahren errichtete eine geheime Sekte nachtelfischer Zauberer die uralte Stadt Eldre'Thalas, um die wertvollsten Geheimnisse von K\195\182nigin Azshara zu sch\195\188tzen. Selbst die Ruinen der Stadt, die w\195\164hrend der Spaltung der Welt verw\195\188stet wurde, sind immer noch \195\164u\195\159erst beeindruckend und ehrfurchtgebietend. In den drei Fl\195\188geln der Stadt, die heute nur noch als der D\195\188sterbruch bekannt ist, haben sich inzwischen die seltsamsten Kreaturen niedergelassen – besonders die spektralen Hochgeborenen, die hinterh\195\164ltigen Satyrn und die brutalen Oger. Nur die mutigsten Abenteurer sollten sich dieser verfluchten Ruine n\195\164hern und die unglaublichen Schrecken herausfordern, die hinter den verfallenen Mauern lauern."
Inst11Caption = "Der D\195\188sterbruch"

--------------Dire Maul West/ Inst12------------
Inst12Story = "Vor fast zw\195\182lftausend Jahren errichtete eine geheime Sekte nachtelfischer Zauberer die uralte Stadt Eldre'Thalas, um die wertvollsten Geheimnisse von K\195\182nigin Azshara zu sch\195\188tzen. Selbst die Ruinen der Stadt, die w\195\164hrend der Spaltung der Welt verw\195\188stet wurde, sind immer noch \195\164u\195\159erst beeindruckend und ehrfurchtgebietend. In den drei Fl\195\188geln der Stadt, die heute nur noch als der D\195\188sterbruch bekannt ist, haben sich inzwischen die seltsamsten Kreaturen niedergelassen – besonders die spektralen Hochgeborenen, die hinterh\195\164ltigen Satyrn und die brutalen Oger. Nur die mutigsten Abenteurer sollten sich dieser verfluchten Ruine n\195\164hern und die unglaublichen Schrecken herausfordern, die hinter den verfallenen Mauern lauern."
Inst12Caption = "Der D\195\188sterbruch"

--------------Inst13/Maraudon------------
Inst13Story = "Maraudon, eine der heiligsten St\195\164tten in Desolace, wird von den wilden Maraudinezentauren besch\195\188tzt. Der gro\195\159e Tempel ist die letzte Ruhest\195\164tte von Zaetar, einem der zwei unsterblichen S\195\182hne des Halbgottes Cenarius. Die Legende besagt, dass Zaetar zusammen mit Theradras, der Prinzessin der Erdelementare, das missgestaltete Volk der Zentauren in die Welt setzte. Man sagt, dass die barbarischen Zentauren, als sie sich ihrer abscheulichen Gestalt gewahr wurden, sich von wildem Zorn beseelt auf ihren Vater st\195\188rzten und ihn ermordeten. Einige glauben, dass Theradras in ihrer Trauer den Geist von Zaetar in den gewundenen H\195\182hlen von Maraudon einfing und seine Energien f\195\188r einen b\195\182sartigen Zweck missbrauchte. Die Tunnels des Heligtums sind nun das Zuhause der finsteren Geister l\195\164ngst verstorbener Zentauren und Theradras eigener elementarer Diener."
Inst13Caption = "Maraudon"

--------------Inst22/Stratholme------------
Inst22Story = "Einst war Stratholme das Juwel von Lordaeron, aber es ist schon lange her, dass jemand die Stadt bei diesem Namen genannt hat. Hier, an genau diesem Ort, vollzog sich der Anfang des Untergangs von Lordaeron, als sich Arthas gegen seinen Mentor Uther Lightbringer wandte und hunderte treu ergebener Untertanen, die angeblich mit der Seuche des Untodes in Ber\195\188hrung gekommen waren, ohne jegliches Erbarmen zur Schlachtbank f\195\188hrte. Dies war der erste Schritt auf Arthas langer Reise abw\195\164rts in die finstersten Abgr\195\188nde der menschlichen Seele, die ihn schlie\195\159lich in die offenen Arme des Lichk\195\182nigs trieb. Stratholme ist nun unter der Verwaltung des m\195\164chtigen Lichs Kel'thuzad eine Festung der untoten Gei\195\159el. Ein Teil der Ruinen wird mit dem Mut der Verzweiflung von einem Kontingent Scharlachroter Kreuzritter gehalten, die von dem Obersten Kreuzritter Dathrohan angef\195\188hrt werden. Beide Seiten sind in einem erbitterten Stra\195\159enkampf gefangen. Abenteurer, die mutig (oder t\195\182richt) genug sind, Stratholme zu betreten, werden sich fr\195\188her oder sp\195\164ter mit beiden Seiten auseinandersetzen m\195\188ssen. Man sagt, die Stadt werde von drei gewaltigen Wacht\195\188rmen, m\195\164chtigen Totenbeschw\195\182rern, Banshees und Monstrosit\195\164ten bewacht. Es gibt auch Berichte von einem unheimlichen Todesritter, der auf seinem untoten Ross durch die Stra\195\159en reitet, und jeden heimsucht, der es wagt, in das Reich der Gei\195\159el vorzudringen."
Inst22Caption = "Stratholme"

--------------Inst29/Gnomeregan------------
Inst29Story = "Gnomeregan war seit ungez\195\164hlten Generationen die Hauptstadt der Gnome, eine Stadt, wie es sie davor noch nie in Azeroth gegeben hatte, wo selbst die k\195\188hnsten Tr\195\164ume der gnomischen T\195\188ftler wahr wurden. Die Wellen der j\195\188ngsten Invasion der mutierten Troggs in Dun Morogh erreichten schlie\195\159lich auch die Wunderwelt der Gnome. In einem Akt der Verzweiflung befahl Hocht\195\188ftler Mekkatorque, die Tanks f\195\188r den radioaktiven Abfall der Stadt nach Gnomeregan zu entleeren und so die Troggs zu vernichten. Viele Gnome brachten sich vor den radioaktiven D\195\164mpfen und dem Giftm\195\188ll in Sicherheit und warteten darauf, dass die Troggs entweder starben oder flohen. Doch statt zu sterben oder zu fliehen, verwandelten sich die mutierten, brutalen Troggs in mutierte, brutale und radioaktive Troggs, die nun obendrein noch w\195\188tender waren als zuvor (sofern das \195\188berhaupt m\195\182glich war). Die Gnome, die nicht von der Radioaktivit\195\164t oder den Toxinen get\195\182tet wurden, mussten fliehen und in der nahegelegenen Stadt Ironforge Schutz suchen. Dort ist Hocht\195\188ftler Mekkatorque momentan dabei, tapfere Helden f\195\188r die Zur\195\188ckeroberung der gnomischen Hauptstadt zu suchen. Ger\195\188chten zufolge soll Mekkatorques ehemaliger Berater, der Robogenieur Thermaplug, sein Volk verraten haben, indem er die Invasion geschehen liess. Der wahnsinnige Gnom ist in Gnomeregan zur\195\188ckgeblieben, wo der Technof\195\188rst nun neue sinistre Pl\195\164ne aust\195\188ftelt."
Inst29Caption = "Gnomeregan"
Inst29QAA = "8 Quests"
Inst29QAH = "3 Quests"

--QUEST1 Allianz

Inst29Quest1 = "1. Rettet Techbots Hirn! "
Inst29Quest1_Attain = "?"
Inst29Quest1_Level = "26"
Inst29Quest1_Aim = "Bringt Techbots Speicherkern zu T\195\188ftlermeister Overspark nach Ironforge."
Inst29Quest1_Location = "T\195\188ftlermeister Overspark (Ironforge; "..YELLOW.."69,50 "..WHITE..")"
Inst29Quest1_Note = "Die Vorquest gibt es bei Bruder Sarno "..YELLOW.."(Stormwind; 40,30)"..WHITE..".\nTechbot findet man vor der Instanz nahe dem Hintereingang."
Inst29Quest1_Prequest = "Ja, T\195\188ftlermeister Overspark"
Inst29Quest1_Folgequest = "Nein"

--Quest2 Allianz

Inst29Quest2 = "2. Gnogaine"
Inst29Quest2_Attain = "?"
Inst29Quest2_Level = "27"
Inst29Quest2_Aim = "Sammelt mit der leeren bleiernen Sammelphiole radioaktiven Fallout bestrahlter Eindringlinge oder Pl\195\188nderer. Sobald sie voll ist, bringt Ihr sie zu Ozzie Togglevolt nach Kharanos zur\195\188ck."
Inst29Quest2_Location = "Ozzie Togglevolt (Dun Morogh; "..YELLOW.."45,49 "..WHITE..")"
Inst29Quest2_Note = "Die Vorquest gibt es bei Gnoarn "..YELLOW.."(Ironforge; 69,50)"..WHITE..".\nUm Fallout zu bekommen muss man die Phiole auf "..RED.."lebende"..WHITE.." bestrahlter Eindringlinge oder Pl\195\188nderer anwenden."
Inst29Quest2_Prequest = "Ja, Der Tag danach"
Inst29Quest2_Folgequest = "Ja, Das einzige Heilmittel ist mehr gr\195\188nes Leuchten"

--Quest3 Allianz

Inst29Quest3 = "3. Das einzige Heilmittel ist mehr gr\195\188nes Leuchten"
Inst29Quest3_Attain = "27"
Inst29Quest3_Level = "30"
Inst29Quest3_Aim = "Reist nach Gnomeregan und bringt hoch konzentrierten radioaktiven Fallout zur\195\188ck. Seid gewarnt, der Fallout ist instabil und wird ziemlich schnell zerfallen.\nOzzie wird au\195\159erdem Eure schwere bleierne Phiole ben\195\182tigen, nachdem die Aufgabe erledigt ist."
Inst29Quest3_Location = "Ozzie Togglevolt (Dun Morogh; "..YELLOW.."45,49 "..WHITE..")"
Inst29Quest3_Note = "Um Fallout zu bekommen muss man die Phiole auf "..RED.."lebende"..WHITE.." bestrahlten Br\195\188hschleimern, Lauerern und Schrecken anwenden."
Inst29Quest3_Prequest = "Ja, Gnogaine"
Inst29Quest3_Folgequest = "Nein"

--Quest4 Allianz

Inst29Quest4 = "4. Gyrobohrmatische Exkavation"
Inst29Quest4_Attain = "?"
Inst29Quest4_Level = "30"
Inst29Quest4_Aim = "Bringt 24 robomechanische Innereien zu Shoni nach Stormwind."
Inst29Quest4_Location = "Shoni die Schtille (Stormwind; "..YELLOW.."55,12 "..WHITE..")"
Inst29Quest4_Note = "Alle Roboter hinterlassen die Teile."
Inst29Quest4_Prequest = "Nein"
Inst29Quest4_Folgequest = "Nein"
--
Inst29Quest4name1 = "Shonis Entwaffnungs-Werkzeug"
Inst29Quest4name2 = "F\195\164ustlinge der Entschlossenheit"

--Quest5 Allianz

Inst29Quest5 = "5. Grundlegende Artifixe"
Inst29Quest5_Attain = "?"
Inst29Quest5_Level = "30"
Inst29Quest5_Aim = "Bringt Klockmort Spannerspan in Ironforge 12 grundlegende Artifixe."
Inst29Quest5_Location = "Klockmort Spannerspan (Ironforge; "..YELLOW.."68,46 "..WHITE..")"
Inst29Quest5_Note = "Die Vorquest gib es bei Mathiel "..YELLOW.."(Darnassus; 59,45)"..WHITE..".\n Alle Gegner droppen die Artifixe."
Inst29Quest5_Prequest = "Ja, Klockmorts Grundlagen"
Inst29Quest5_Folgequest = "Nein"

--Quest6 Allianz

Inst29Quest6 = "6. Datenrettung"
Inst29Quest6_Attain = "25"
Inst29Quest6_Level = "30"
Inst29Quest6_Aim = "Bringt Mechanikermeister Castpipe in Ironforge eine Prismalochkarte."
Inst29Quest6_Location = "Mechanikermeister Castpipe (Ironforge; "..YELLOW.."69,48 "..WHITE..")"
Inst29Quest6_Note = "Die Vorquest gib es bei Gaxim Rustfizzle "..YELLOW.."(Steinkrallengebirge; 59,67)"..WHITE..".\nDie wei\195\159e Lochkarte ist ein random Dropp. Das erste Terminal ist vor der Instanz nahe des Nebeneingangs. Das 2te Terminal ist bei [3], dass 3 bei [5] und das 4 bei [8]."
Inst29Quest6_Prequest = "Ja, Castpipes Auftrag"
Inst29Quest6_Folgequest = "Nein"
--
Inst29Quest6name1 = "Schlosser-Cape"
Inst29Quest6name2 = "Mechanikerrohrhammer"

--Quest7 Allianz

Inst29Quest7 = "7. Eine sch\195\182ne Bescherung"
Inst29Quest7_Attain = "22"
Inst29Quest7_Level = "30"
Inst29Quest7_Aim = "Begleitet Kernobee zur Uhrwerkgasse und meldet Euch dann wieder bei Scooty in Booty Bay."
Inst29Quest7_Location = "Kernobee (Gnomeregan "..YELLOW.."Nahe der sauberen Zone, in einer Nische"..WHITE..")"
Inst29Quest7_Note = "Eskort Quest! Scooty findet man im "..YELLOW.."Schlingendorntal (Booty Bay; 27,77)."..WHITE..""
Inst29Quest7_Prequest = "Nein"
Inst29Quest7_Folgequest = "Nein"
--
Inst29Quest7name1 = "Feuergeschmiedete Armschienen"
Inst29Quest7name2 = "Feenfl\195\188gel-Mantel"

--Quest8 Allianz

Inst29Quest8 = "8. Der gro\195\159e Verrat"
Inst29Quest8_Attain = "?"
Inst29Quest8_Level = "35"
Inst29Quest8_Aim = "Reist nach Gnomeregan und t\195\182tet Robogenieur Thermaplugg. Kehrt zu Hocht\195\188ftler Mekkatorque zur\195\188ck, wenn der Auftrag ausgef\195\188hrt ist."
Inst29Quest8_Location = "Hocht\195\188ftler Mekkatorque (Ironforge "..YELLOW.."68,48"..WHITE..")"
Inst29Quest8_Note = "Thermaplugg findet man bei [6]. Er ist der Endboss von Gnomeregan.\nW\195\164hrend des Kampfs m\195\188ssen die S\195\164ulen an der Seite durch bet\195\164tigen des Knopfs an ihrer Seite deaktiviert werden."
Inst29Quest8_Prequest = "Nein"
Inst29Quest8_Folgequest = "Nein"
--
Inst29Quest8name1 = "Civinad-Roben"
Inst29Quest8name2 = "Stolperl\195\164ufer-Latzhose"
Inst29Quest8name3 = "Zweifach verst\195\164rkte Gamaschen"

--QUEST1 Horde

Inst29Quest1_HORDE = "1. Gnomer-weeeeg!"
Inst29Quest1_HORDE_Attain = "23"
Inst29Quest1_HORDE_Level = "35"
Inst29Quest1_HORDE_Aim = "Wartet, bis Scooty den Goblin-Transponder kalibriert hat."
Inst29Quest1_HORDE_Location = "Scooty (Schlingendorntal - Booty Bay; "..YELLOW.."27,77 "..WHITE..")"
Inst29Quest1_HORDE_Note = "Die Vorquest bekommt man bei Sovik "..YELLOW.."(Orgrimmar; 75,25)"..WHITE..".\nWenn man diesen Quest abgeschlo\195\159en hat kann man den Teleporter in Booty Bay benutzen."
Inst29Quest1_HORDE_Prequest = "Ja, Chefingenieur Scooty"
Inst29Quest1_HORDE_Folgequest = "Nein"

--Quest2 Horde

Inst29Quest2_HORDE = "2. Eine sch\195\182ne Bescherung"
Inst29Quest2_HORDE_Attain = "22"
Inst29Quest2_HORDE_Level = "30"
Inst29Quest2_HORDE_Aim = "Begleitet Kernobee zur Uhrwerkgasse und meldet Euch dann wieder bei Scooty in Booty Bay."
Inst29Quest2_HORDE_Location = "Kernobee (Gnomeregan "..YELLOW.."Nahe der sauberen Zone, in einer Nische"..WHITE..")"
Inst29Quest2_HORDE_Note = "Eskort Quest! Scooty findet man im "..YELLOW.."Schlingendorntal (Booty Bay; 27,77)."..WHITE..""
Inst29Quest2_HORDE_Prequest = "Nein"
Inst29Quest2_HORDE_Folgequest = "Nein"
--
Inst29Quest2name1_HORDE = "Feuergeschmiedete Armschienen"
Inst29Quest2name2_HORDE = "Feenfl\195\188gel-Mantel"

--Quest3 Horde

Inst29Quest3_HORDE = "3. Maschinenkriege"
Inst29Quest3_HORDE_Attain = "?"
Inst29Quest3_HORDE_Level = "35"
Inst29Quest3_HORDE_Aim = "Besorgt die Maschinenblaupausen und Thermapluggs Safekombination aus Gnomeregan und bringt sie zu Nogg nach Orgrimmar."
Inst29Quest3_HORDE_Location = "Nogg (Orgrimmar; "..YELLOW.."75,25 "..WHITE..")"
Inst29Quest3_HORDE_Note = "Thermaplugg findet man bei [6]. Er ist der Endboss von Gnomeregan.\nW\195\164hrend des Kampfs m\195\188ssen die S\195\164ulen an der Seite durch bet\195\164tigen des Knopfs an ihrer Seite deaktiviert werden."
Inst29Quest3_HORDE_Prequest = "Nein"
Inst29Quest3_HORDE_Folgequest = "Nein"
--
Inst29Quest3name1_HORDE = "Civinad-Roben"
Inst29Quest3name2_HORDE = "Stolperl\195\164ufer-Latzhose"
Inst29Quest3name3_HORDE = "Zweifach verst\195\164rkte Gamaschen"
------------------------------------------------------------------------------------------------------
------------------------------------------------- RAID -----------------------------------------------
------------------------------------------------------------------------------------------------------

--------------Inst30/Alptraumdrachen------------
Inst30Story = "Ein rauer Wind weht durch die Kronen der Gro\195\159en B\195\164ume. Etwas Unheimliches hat sich fernab der wachsamen Augen der Besch\195\188tzer Azeroths eingeschlichen und bedroht nun Ashenvale, den D\195\164mmerwald, Feralas und das Hinterland. Vier der m\195\164chtigen W\195\164chter des gr\195\188nen Drachenschwarms sind aus dem smaragdgr\195\188nen Traum zur\195\188ckgekehrt, doch die einstmals stolzen Besch\195\188tzer verbreiten nun nichts als Tod und Zerst\195\182rung. Azeroth braucht tapfere Abenteurer mehr denn je, die das Land gegen diese d\195\188steren Vorboten verteidigen."
Inst30Caption = "Die Drachen des Alptraums"
Inst30Caption1 = "Ysera und der gr\195\188ne Drachenschwarm"
Inst30Caption2 = "Lethon"
Inst30Caption3 = "Emeriss"
Inst30Caption4 = "Taerar"
Inst30Caption5 = "Ysondre"

Inst30Story1 = "Ysera, der gro\195\159e Drachenaspekt der Tr\195\164ume, f\195\188hrt den geheimnisvollen gr\195\188nen Drachenschwarm an. Ihr Reich sind die fantastischen, mystischen Weiten des smaragdgr\195\188nen Traums, und man erz\195\164hlt sich, dass sie von dort aus die Evolution allen Lebens beeinflusst. Sie ist die Besch\195\188tzerin der Natur und der Phantasie; ihr und ihrem Drachenschwarm wurde die Ehre zuteil, die Gro\195\159en B\195\164ume zu bewachen, durch die allein die Druiden in den Traum hin\195\188berwechseln k\195\182nnen.Vor kurzem wurden Yseras treueste Diener von einer dunklen neuen Macht besudelt, die sich im smaragdgr\195\188nen Traum ausbreitet. Nun sind die abtr\195\188nnigen W\195\164chter durch die Gro\195\159en B\195\164ume nach Azeroth zur\195\188ckgekehrt, um Angst und Schrecken in den L\195\164ndern der Sterblichen zu verbreiten. Selbst die m\195\164chtigsten Abenteurer sollten sich den Drachen nicht alleine entgegenstellen, um nicht die volle Gewalt ihres entfesselten Zornes zu sp\195\188ren zu bekommen. "
Inst30Story2 = "Als Lethon der Anomalie innerhalb des smaragdgr\195\188nen Traums ausgesetzt wurde, verdunkelte sich nicht nur die T\195\182nung seiner Schuppen... der Drache erhielt auch die F\195\164higkeit, b\195\182sartige Schemen aus seinen Feinden aufzusaugen. Sobald diese mit ihrem Meister verschmelzen, heilt ihn die Energie der Schemen. So ist es keine \195\156berraschung, das Lethon einer der Furcht erregendsten Abtr\195\188nnigen ist."
Inst30Story3 = "Eine mysteri\195\182se, dunkle Macht innerhalb des smaragdgr\195\188nen Traums hat die einst majest\195\164tische Emeriss in eine verwesende, faulige Monstrosit\195\164t verwandelt. Die wenigen, die eine Begegnung mit dem Drachen \195\188berlebt haben, erz\195\164hlen Ekel erregende Geschichten von eitrigen Pilzen, die aus den Leichen gefallener K\195\164mpfer sprie\195\159en. Ob diese Geschichten wahr oder nur die Ausgeburten geistig Verst\195\182rter sind, l\195\164sst sich wohl nur herausfinden, indem man der scheu\195\159lichen Bestie entgegentritt."
Inst30Story4 = "Von all jenen, die mit der Anomalie in Kontakt gekommen sind, hat Taerar wohl am meisten gelitten. Sie hat nicht blo\195\159 seinen Verstand, sondern auch seine k\195\182rperliche Gestalt gespalten. Der Drache existiert nun als Phantom, das sich in mehrere Splittergestalten aufteilen kann, die \195\188ber vernichtende magische Kr\195\164fte verf\195\188gen. Taerar ist ein gerissener und erbarmungsloser Gegner, der den Wahnsinn seiner eigenen Existenz f\195\188r die Bewohner Azeroths zu einer grausamen Wirklichkeit machen will."
Inst30Story5 = "Ysondre, einst eine von Yseras vertrautesten Anh\195\164ngerinnen, hat sich den Abtr\195\188nnigen angeschlossen und verbreitet nun Chaos und Terror in Azeroth. Ihre ehemals segensreichen Heilkr\195\164fte haben sich zu dunkler Magie gewandelt, mit der sie sengende Blitze verschleudern und fehlgeleitete Druiden zu Hilfe rufen kann. Ysondre und die ihren k\195\182nnen ihre Gegner auch einschlafen lassen, wodurch ihre hilflosen Opfer in das Reich der schrecklichsten Alptr\195\164ume geschickt werden."

Inst30Quest1 = ""
Inst30Quest1_Attain = ""
Inst30Quest1_Level = "100"
Inst30Quest1_Aim = ""
Inst30Quest1_Location = ""
Inst30Quest1_Note = ""
Inst30Quest1_Prequest = ""
Inst30Quest1_Folgequest = ""

--QUEST 1 Horde

Inst30Quest1_HORDE = ""
Inst30Quest1_HORDE_Attain = ""
Inst30Quest1_HORDE_Level = "100"
Inst30Quest1_HORDE_Aim = ""
Inst30Quest1_HORDE_Location = ""
Inst30Quest1_HORDE_Note = ""
Inst30Quest1_HORDE_Prequest = ""
Inst30Quest1_HORDE_Folgequest = ""

Inst30Quest2 = ""
Inst30Quest2_Attain = ""
Inst30Quest2_Level = "100"
Inst30Quest2_Aim = ""
Inst30Quest2_Location = ""
Inst30Quest2_Note = ""
Inst30Quest2_Prequest = ""
Inst30Quest2_Folgequest = ""

--QUEST 2 Horde

Inst30Quest2_HORDE = ""
Inst30Quest2_HORDE_Attain = ""
Inst30Quest2_HORDE_Level = "100"
Inst30Quest2_HORDE_Aim = ""
Inst30Quest2_HORDE_Location = ""
Inst30Quest2_HORDE_Note = ""
Inst30Quest2_HORDE_Prequest = ""
Inst30Quest2_HORDE_Folgequest = ""

Inst30Quest3 = ""
Inst30Quest3_Attain = ""
Inst30Quest3_Level = "100"
Inst30Quest3_Aim = ""
Inst30Quest3_Location = ""
Inst30Quest3_Note = ""
Inst30Quest3_Prequest = ""
Inst30Quest3_Folgequest = ""

--QUEST 3 Horde

Inst30Quest3_HORDE = ""
Inst30Quest3_HORDE_Attain = ""
Inst30Quest3_HORDE_Level = "100"
Inst30Quest3_HORDE_Aim = ""
Inst30Quest3_HORDE_Location = ""
Inst30Quest3_HORDE_Note = ""
Inst30Quest3_HORDE_Prequest = ""
Inst30Quest3_HORDE_Folgequest = ""

Inst30Quest4 = ""
Inst30Quest4_Attain = ""
Inst30Quest4_Level = "100"
Inst30Quest4_Aim = ""
Inst30Quest4_Location = ""
Inst30Quest4_Note = ""
Inst30Quest4_Prequest = ""
Inst30Quest4_Folgequest = ""

--QUEST 4 Horde

Inst30Quest4_HORDE = ""
Inst30Quest4_HORDE_Attain = ""
Inst30Quest4_HORDE_Level = "100"
Inst30Quest4_HORDE_Aim = ""
Inst30Quest4_HORDE_Location = ""
Inst30Quest4_HORDE_Note = ""
Inst30Quest4_HORDE_Prequest = ""
Inst30Quest4_HORDE_Folgequest = ""


--------------Azuregos------------
Inst31Story = "Vor der Spaltung der Welt bl\195\188hte die elfische Stadt Eldarath in den Landen, die nunmehr Azshara genannt werden. Manche sagen, dass unter den Ruinen der Stadt immer noch zahllose Artefakte der Hochgeborenen schlummern. Seit ungez\195\164hlten Generationen wacht der blaue Drachenschwarm \195\188ber m\195\164chtige Artefakte und magisches Wissen, damit nichts davon in die falschen H\195\164nde f\195\164llt. Die Anwesenheit von Azuregos, dem blauen Drachen, scheint darauf hinzuweisen, dass in der Wildnis von Azshara extrem seltene Gegenst\195\164nde schlummern, vielleicht sogar die Phiolen der Ewigkeit. Doch egal was der Drache sucht, eins ist sicher – er wird bis zum letzten K\195\164mpfen, um diese Sch\195\164tze zu verteidigen!"
Inst31Caption = "Azuregos"

--------------Kazzak------------
Inst32Story = "Nach der Niederlage der Brennenden Legion am Ende des Dritten Krieges zog sich der Rest der d\195\164monischen Streitmacht unter der F\195\188hrung des gigantischen F\195\188rsten Kazzak in die verw\195\188steten Lande zur\195\188ck. Dort, in dem Gebiet, das als die faulende Narbe bekannt ist, warten sie bis heute darauf, dass sich das Dunkle Portal erneut \195\182ffnet. Man sagt, dass Kazzak mit seiner Armee in die Scherbenwelt vordringen will, die einstige Heimatwelt der Orcs, die von den Portalen des verderbten Schamanen Ner'zhul in St\195\188cke gerissen wurde. Die Scherbenwelt ist inzwischen das Zuhause von Illidan, dem Verr\195\164ter, und seinen d\195\164monischen Untergebenen."
Inst32Caption = "F\195\188rst Kazzak"

--------------Inst14/geschmolzener Kern------------
Inst14Story = "Der geschmolzene Kern befindet sich am tiefsten Punkt des Blackrock. Genau hier, im Herzen des Berges, beschwor Imperator Thaurissan vor langer Zeit in einem Akt der Verzweiflung den elementaren Feuerf\195\188rsten Ragnaros, um seinen gescheiterten Putsch gegen die Zwerge von Ironforge doch noch in einen Sieg zu verwandeln. Obwohl der Feuerf\195\188rst immer in der N\195\164he des feurigen Kerns bleiben muss, treiben seine Offiziere die Dunkeleisenzwerge gnadenlos dazu an, ihm eine Armee aus lebendem Gestein zu erschaffen. Der See aus Magma, in dem Ragnaros schl\195\164ft, ist in Wirklichkeit ein interplanarer Riss, durch den b\195\182sartige Feuerelementare von der Ebene des Feuers nach Azeroth gelangen. Der h\195\182chstrangige von Ragnaros' Untergebenen ist Majordomo Executus, der als einziger in der Lage ist, den schlafenden Feuerf\195\188rsten zu wecken."
Inst14Caption = "Der geschmolzene Kern"

--------------Inst16/Onyxia------------
Inst16Story = "Onyxia ist die Tochter des m\195\164chtigen Drachen Deathwing und die Schwester des gerissenen Nefarian, dem F\195\188rsten des Blackrock. Selbst f\195\188r einen Drachen ist Onyxia \195\164u\195\159erst intelligent, und sie nimmt gerne die Form einer Sterblichen an, um sich heimlich in die politischen Angelegenheiten der sterblichen V\195\182lker einzumischen. Obwohl sie f\195\188r einen schwarzen Drachen ihres Alters recht klein ist, verf\195\188gt sie dennoch \195\188ber die gleichen Kr\195\164fte und F\195\164higkeiten wie der Rest ihres f\195\188rchterlichen Schwarms. Manche sagen, Onyxia habe sogar eine Tarnidentit\195\164t ihres Vaters \195\188bernommen - den Titel des k\195\182niglichen Hauses Prestor. Wenn sie sich nicht in den Angelegenheiten der Sterblichen einmischt, ruht Onyxia in einer feurigen H\195\182hle unterhalb des Drachensumpfes, einer unwirtlichen Gegend der Marschen von Dustwallow. Dort wird sie von ihren Gefolgsleuten bewacht, den verbleibenden Mitgliedern des grausamen schwarzen Drachenschwarms"
Inst16Caption = "Onyxias Hort"

--------------Inst6------------
Inst6Story = "Nefarians Heiligtum, der Pechschwingenhort, befindet sich am h\195\182chsten Punkt der Zitadelle des Blackrock. Dort, in den finsteren Nischen der zerkl\195\188fteten Bergspitze, setzt Nefarian nun die letzten Schritte seines teuflischen Plans in Gang, um Ragnaros ein f\195\188r allemal zu vernichten und mit seiner Armee die Herrschaft \195\188ber alle V\195\182lker Azeroths an sich zu rei\195\159en."
Inst6Caption = "Der Pechschwingenhort"
Inst6Caption1 = "Der Pechschwingenhort (Geschichte Teil 1)"
Inst6Caption2 = "Der Pechschwingenhort (Geschichte Teil 2)"

Inst6Story1 = "Die m\195\164chtige Festung, die aus der feurigen Flanke des Blackrock herausgeschnitten wurde, geht auf Entw\195\188rfe des zwergischen Meistersteinmetzes Franclorn Forgewright zur\195\188ck. Jahrhunderte lang war die Zitadelle das Symbol der Macht des Dunkeleisen-Clans, das von den Zwergen mit \195\164u\195\159erstem Ingrimm verteidigt wurde. Allerdings gab es jemanden, der andere Ziele verfolgte: Nefarian, der listige Sohn des Drachen Deathwing, stieg eines Tages mit Flamme und Klaue auf den oberen Teil der Zitadelle hinab und trug zusammen mit seinen drachischen Untergebenen den Kampf bis zu den Stellungen der Zwerge tief unten, bei den vulkanischen Abgr\195\188nden unter dem Berg, wo Ragnaros der Feuerf\195\188rst herrscht. Ragnaros ist es gelungen, das Geheimnis zu l\195\188ften, wie Leben aus Stein erschaffen werden kann. Nun plant er, sein neu gewonnenes Wissen dazu einzusetzen, eine Armee unaufhaltsamer Golems zu schaffen, die ihm bei der Eroberung des Blackrock helfen sollen."
Inst6Story2 = "Nefarian will Ragnaros um jeden Preis vernichten. Zu diesem Zweck hat er vor kurzem damit begonnen, seine Macht auszuweiten, so wie sein Vater Deathwing es bereits vor langer Zeit versucht hat. Der berechnende Nefarian scheint allerdings dort Erfolg zu haben, wo sein Vater einst versagte. Nefarians krankes D\195\188rsten nach \195\156berlegenheit hat inzwischen auch den Zorn des roten Drachenschwarms auf sich gezogen, der gef\195\164hrlichsten Feinde des schwarzen Drachenschwarms. Obwohl Nefarians Absichten bekannt sind, bleibt seine Vorgehensweise jedoch ein Geheimnis. Man sagt, dass Nefarian mit dem Blut aller Drachenschw\195\164rme experimentiert, um unaufhaltsame Krieger zu erschaffen.\n \nNefarians Heiligtum, der Pechschwingenhort, befindet sich am h\195\182chsten Punkt der Zitadelle des Blackrock. Dort, in den finsteren Nischen der zerkl\195\188fteten Bergspitze, setzt Nefarian nun die letzten Schritte seines teuflischen Plans in Gang, um Ragnaros ein f\195\188r allemal zu vernichten und mit seiner Armee die Herrschaft \195\188ber alle V\195\182lker Azeroths an sich zu rei\195\159en."

Inst6Quest1 = ""
Inst6Quest1_Attain = ""
Inst6Quest1_Level = "100"
Inst6Quest1_Aim = ""
Inst6Quest1_Location = ""
Inst6Quest1_Note = ""
Inst6Quest1_Prequest = ""
Inst6Quest1_Folgequest = ""

Inst6Quest1_HORDE = ""
Inst6Quest1_HORDE_Attain = ""
Inst6Quest1_HORDE_Level = "100"
Inst6Quest1_HORDE_Aim = ""
Inst6Quest1_HORDE_Location = ""
Inst6Quest1_HORDE_Note = ""
Inst6Quest1_HORDE_Prequest = ""
Inst6Quest1_HORDE_Folgequest = ""

Inst6Quest2 = ""
Inst6Quest2_Attain = ""
Inst6Quest2_Level = "100"
Inst6Quest2_Aim = ""
Inst6Quest2_Location = ""
Inst6Quest2_Note = ""
Inst6Quest2_Prequest = ""
Inst6Quest2_Folgequest = ""

Inst6Quest2_HORDE = ""
Inst6Quest2_HORDE_Attain = ""
Inst6Quest2_HORDE_Level = "100"
Inst6Quest2_HORDE_Aim = ""
Inst6Quest2_HORDE_Location = ""
Inst6Quest2_HORDE_Note = ""
Inst6Quest2_HORDE_Prequest = ""
Inst6Quest2_HORDE_Folgequest = ""


--------------Inst23------------
Inst23Story = "In den letzten Stunden des Krieges gegen die Silithiden trugen die Nachtelfen und die vier Drachenschw\195\164rme die Schlacht in das Herz des Qiraji Reichs zur\195\188ck: in die Festung von Ahn'Qiraj. An den Toren der Stadt stie\195\159en sie auf ein Aufgebot von Kriegsdrohnen, gewaltiger als es je zuvor gesehen wurde. Die Silithiden und ihre Qiraji Herren konnten nicht besiegt werden und wurden stattdessen innerhalb einer magischen Barriere eingeschlossen; der Krieg hinterlie\195\159 die verfluchte Stadt in Ruinen. Tausend Jahre sind seitdem vergangen – Jahre, in denen die Qiraji nicht unt\195\164tig waren. Eine neue und schreckliche Streitmacht ist in den St\195\182cken ausgebr\195\188tet worden und die Ruinen von Ahn'Qiraj wurden erneut von Silithidenschw\195\164rmen und Qiraji bev\195\182lkert. Diese Bedrohung gilt es zu meistern, ansonsten wird Azeroth der schrecklichen Macht dieser neuen Qiraji Streitkraft zum Opfer fallen."
Inst23Caption = "Ruinen von Ahn'Qiraj"

--------------Inst26------------
Inst26Story = "Im Herzen Ahn'Qirajs liegt ein uralter Tempelkomplex. Vor Beginn der Zeitrechnung erbaut, ist es ein Monument scheu\195\159licher Gottheiten und die gewaltige Brutst\195\164tte der Qiraji Streitmacht. Seit der Krieg der wehenden Sande vor tausend Jahren endete, waren die Zwilingsimperatoren von Ahn'Qiraj, Vek'nilash und Vek'lor, in ihrem Tempel gefangen. Die magische Barriere des bronzenen Drachen Anachronos und der Nachtelfen hielt sie in ihrem Bann. Doch nun, da das Szepter der Sandst\195\188rme wieder vereint und das Siegel gebrochen ist, steht der Weg in das Heiligtum Ahn'Qirajs erneut offen. Hinter dem krabbelnden Wahnsinn des Schwarmbaus, unter dem Tempel von Ahn'Qiraj, bereiten sich Heerscharen der Qiraji auf den Einmarsch vor. Nun gilt es, sie um jeden Preis aufzuhalten bevor sie ihre uners\195\164ttlichen, insektenartigen Armeen erneut auf auf Kalimdor loslassen und ein zweiter Krieg der Silithiden beginnt!"
Inst26Caption = "Tempel von Ahn'Qiraj"

--------------Inst28------------
Inst28Story = "Vor mehr als tausend Jahren wurde das m\195\164chtige Reich der Gurubashi von einem gewaltigen B\195\188rgerkrieg in St\195\188cke gerissen. Eine einflussreiche Gruppe trollischer Priester, die als die Atal'ai bekannt waren, beschworen damals den Avatar des uralten und f\195\188rchterlichen Blutgottes, Hakkar, der Seelenschinder. Obwohl die Priester besiegt und ins Exil geschickt wurden, brach das ehemals glorreiche Reich der Trolle zusammen. Die Reise ins Exil f\195\188hrte die verbannten Priester weit nach Norden, bis in die S\195\188mpfe des Elends, wo sie ihrem Gott Hakkar einen Tempel errichteten, um seine R\195\188ckkehr in die Welt der Sterblichen vorzubereiten."

Inst28Story1= "Im Lauf der Zeit erkannten die Atal'ai, dass Hakkars physische Gestalt nur in Zul'Gurub, der uralten Tempelstadt, der Hauptstadt des Reichs der Gurubashi, beschworen werden konnte. Erschreckenderweise hatten die Priester vor Kurzem einen Durchbruch bei ihren Bem\195\188hungen, Hakkar herbeizurufen – Berichten zufolge thront der Seelenschinder erneut \195\188ber den lang verlorenen Ruinen der Gurubaschi.\n \nUm den Blutgott zu stoppen, haben sich die Trolle des Landes zusammengeschlossen und eine Gruppe trollischer Hohepriester in die uralte Stadt entsandt, jeder Priester ein m\195\164chtiger Diener der urspr\195\188nglichen G\195\182tter – Fledermaus, Panther, Tiger, Spinne und Schlange. Doch trotz ihrer M\195\188hen wurden auch die Hohepriester von Hakkar verf\195\188hrt. Nun n\195\164hren die Hohepriester und die Aspekte ihrer urspr\195\188nglichen G\195\182tter die ohnehin schon \195\188berw\195\164ltigende Kraft des Seelenschinders. Abenteurer, die mutig genug sind, sich in die unheilsvollen Ruinen vorzuwagen, muss sich zuerst den Hohepriestern stellen, wenn sie auch nur die geringste Chance gegen den m\195\164chtigen Blutgott selbst haben wollen."
Inst28Caption = "Zul'Gurub"
Inst28Caption1 = "Zul'Gurub (Geschichte)"

Inst28Quest1 = ""
Inst28Quest1_Attain = ""
Inst28Quest1_Level = "100"
Inst28Quest1_Aim = ""
Inst28Quest1_Location = ""
Inst28Quest1_Note = ""
Inst28Quest1_Prequest = ""
Inst28Quest1_Folgequest = ""

--QUEST 1 Horde

Inst28Quest1_HORDE = ""
Inst28Quest1_HORDE_Attain = ""
Inst28Quest1_HORDE_Level = "100"
Inst28Quest1_HORDE_Aim = ""
Inst28Quest1_HORDE_Location = ""
Inst28Quest1_HORDE_Note = ""
Inst28Quest1_HORDE_Prequest = ""
Inst28Quest1_HORDE_Folgequest = ""


--------------Inst15------------
Inst15Story = "Hoch \195\188ber den Pestl\195\164ndern schwebt die Nekropole Naxxramas, die Kel'Thuzad, einem der m\195\164chtigsten Offiziere des Lichk\195\182nigs, als Heimstatt dient. Schrecken der Vergangenheit und noch unbekannte Grauen warten darauf, auf die Welt losgelassen zu werden, w\195\164hrend sich die Diener der Gei\195\159el auf ihren Ansturm vorbereiten. Bald wird die Gei\195\159el erneut marschieren…"
Inst15Caption = "Naxxramas"

--------------Inst33 / Alterac Vally------------
Inst33Story = "Vor langer Zeit schickte der Hexenmeister Gul’dan einen Klan der Orcs ins Exil, weil es dieser Klan gewagt hatte, sich der schleichenden Korruption der Orcs durch die Brennende Legion entgegenzustellen. Der Frostwolfklan zog sich in ein abgelegenes Tal des Alteracgebirges zur\195\188ck, wo sie sich vor Gul’dans Rache versteckten. Im unwirtlichen Alteractal fristeten die Orcs ein von der Welt abgeschiedenes, karges Dasein... bis Thrall kam.\nNach Thralls triumphaler Vereinigung der Klans entschlossen sich die Frostw\195\182lfe unter der F\195\188hrung des Schamanen Drek’Thar, in dem Tal zu bleiben, das so lange ihre Heimat gewesen war. In j\195\188ngster Zeit wurde der Frieden des Frostwolfklans jedoch durch die Ankunft der zwergischen Stormpike-Expedition gest\195\182rt.\nDie Stormpikes haben sich auf der Suche nach Rohstoffen und Relikten aus der zwergischen Vorgeschichte im Tal angesiedelt. Trotz ihrer friedlichen Absichten hat die Ankunft der Zwerge einen erbitterten Streit mit dem Frostwolfklan entfacht, in dem inzwischen beide Seiten um die alleinige Kontrolle \195\188ber das Tal k\195\164mpfen. "
Inst33Caption = "Das Alteractal"

--------------Inst34 / Arathi Basin------------
Inst34Story = "Das Arathibecken im Arathihochland ist ein dynamisches und spannendes Schlachtfeld. Das Talbecken selbst verf\195\188gt \195\188ber wertvolle Rohstoffe, um die die Allianz und die Horde erbitterte Schlachten austragen. Die Verlassenen Entweihten und der Bund von Arathor sind im Talbecken, um die Rohstoffe des Talbeckens f\195\188r ihre Seite zu sichern und ihrem Gegner eine empfindliche Niederlage beizubringen."
Inst34Caption = "Das Arathibecken"

--------------Inst35 / Warsong Gulch------------
Inst35Story = "Eingebetted in das s\195\188dliche Ashenvale ist die Warsongschlucht nahe dem Gebiet wo Grom Hellscream und seine Orks w\195\164hrend des 3. Krieges gro\195\159e Teile des Waldes rodeten. Einige Orks blieben in der N\195\164he und setzten die Arbeit fort um bei der Erweiterung der Gebiete der Horde zu helfen. Sie nennen sich selber Warsong-Vorhut.\nDie Nachtelfen, die eine starke Offensive begonnen haben um den Ashenvalewald zur\195\188ck zuerobern, konzentrieren sich jetzt darauf die Warsong-Vorhut f\195\188r immer zu vertreiben. Die Silverwing-Schildwache haben geschworen, dass sie nicht aufh\195\182ren werden bis der letzte Ork besiegt ist und aus der Warsongschlucht entfernt wurde."
Inst35Caption = "Die Warsongschlucht"


----
end
----
----------------------------------------------------------------------------------
--   à : \195\160    è : \195\168    ì : \195\172    ò : \195\178    ù : \195\185
--   á : \195\161    é : \195\169    í : \195\173    ó : \195\179    ú : \195\186
--   â : \195\162    ê : \195\170    î : \195\174    ô : \195\180    û : \195\187
--   ã : \195\163    ë : \195\171    ï : \195\175    õ : \195\181    ü : \195\188
--   ä : \195\164                    ñ : \195\177    ö : \195\182
--   æ : \195\166                                    ø : \195\184
--   ç : \195\167
--
--   Ä : \195\132
--   Ö : \195\150
--   Ü : \195\156
--   ß : \195\159

--    AQINSTANZ :
-- 1  = VC     21 = BSF
-- 2  = WC     22 = STRAT
-- 3  = RFA    23 = AQ20
-- 4  = ULD    24 = STOCKADE
-- 5  = BRD    25 = TEMPLE
-- 6  = BWl    26 = AQ40
-- 7  = BFD    27 = ZUL
-- 8  = LBRS   28 = ZG
-- 9  = UBRS   29 = GNOMERE
-- 10 = DME    30 = DRAGONS
-- 11 = DMN    31 = AZUREGOS
-- 12 = DMW    32 = KAZZAK
-- 13 = MARA   33 = AV
-- 14 = MC     34 = AB
-- 15 = NAXX   35 = WS
-- 16 = ONY    36 = REST
-- 17 = HUEGEL
-- 18 = KRAL
-- 19 = KLOSTER
-- 20 = SCHOLO