------------------------------------------------------------------------------------------------------
-- Necrosis LdC
--
-- Créateur initial (US) : Infernal (http://www.revolvus.com/games/interface/necrosis/)
-- Implémentation de base (FR) : Tilienna Thorondor
-- Reprise du projet : Lomig & Nyx des Larmes de Cenarius, Kael'Thas
-- 
-- Skins et voix Françaises : Eliah, Ner'zhul
-- Version Allemande par Arne Meier et Halisstra, Lothar
-- Remerciements spéciaux pour Sadyre (JoL)
-- Version 23.04.2006-1
------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------
-- FONCTIONS D'INSERTION
------------------------------------------------------------------------------------------------------

-- La table des timers est là pour ça !
function Necrosis_InsertTimerParTable(IndexTable, Target, LevelTarget, SpellGroup, SpellTimer, TimerTable)

	-- Insertion de l'entrée dans le tableau
	table.insert(SpellTimer,
		{
			Name = NECROSIS_SPELL_TABLE[IndexTable].Name,
			Time = NECROSIS_SPELL_TABLE[IndexTable].Length,
			TimeMax = floor(GetTime() + NECROSIS_SPELL_TABLE[IndexTable].Length),
			Type = NECROSIS_SPELL_TABLE[IndexTable].Type,
			Target = Target,
			TargetLevel = LevelTarget,
			Group = 0,
			Gtimer = nil
		});

	-- Association d'un timer graphique au timer
	SpellTimer, TimerTable = Necrosis_AddFrame(SpellTimer, TimerTable);

	-- Tri des entrées par type de sort
	Necrosis_Tri(SpellTimer, "Type");
	
	-- Création des groupes (noms des mobs) des timers
	SpellGroup, SpellTimer = Necrosis_Parsing(SpellGroup, SpellTimer);

	return SpellGroup, SpellTimer, TimerTable;
end

-- Et pour insérer le timer de pierres
function Necrosis_InsertTimerStone(Stone, start, duration, SpellGroup, SpellTimer, TimerTable)

	-- Insertion de l'entrée dans le tableau
	if Stone == "Healthstone" then
		table.insert(SpellTimer,
			{
				Name = NECROSIS_COOLDOWN.Healthstone,
				Time = 180,
				TimeMax = floor(GetTime() + 180),
				Type = 2,
				Target = "",
				TargetLevel = "",
				Group = 2,
				Gtimer = nil
			});

		-- Association d'un timer graphique au timer
		SpellTimer, TimerTable = Necrosis_AddFrame(SpellTimer, TimerTable);
		
	elseif Stone == "Spellstone" then
		table.insert(SpellTimer,
			{
				Name = NECROSIS_COOLDOWN.Spellstone,
				Time = 30,
				TimeMax = floor(GetTime() + 30),
				Type = 2,
				Target = "",
				TargetLevel = "",
				Group = 2,
				Gtimer = nil
			});

		-- Association d'un timer graphique au timer
		SpellTimer, TimerTable = Necrosis_AddFrame(SpellTimer, TimerTable);
		
	elseif Stone == "Soulstone" then
		table.insert(SpellTimer,
			{
				Name = NECROSIS_SPELL_TABLE[11].Name,
				Time = floor(duration - GetTime() + start),
				TimeMax = floor(start + duration),
				Type = NECROSIS_SPELL_TABLE[11].Type,
				Target = "???",
				TargetLevel = "",
				Group = 1,
				Gtimer = nil,
			});

		-- Association d'un timer graphique au timer
		SpellTimer, TimerTable = Necrosis_AddFrame(SpellTimer, TimerTable);
	end

	-- Tri des entrées par type de sort	
	Necrosis_Tri(SpellTimer, "Type");

	-- Création des groupes (noms des mobs) des timers
	SpellGroup, SpellTimer = Necrosis_Parsing(SpellGroup, SpellTimer);

	return SpellGroup, SpellTimer, TimerTable;
end

-- Pour la création de timers personnels
function NecrosisTimerX(nom, duree, truc, Target, LevelTarget, SpellGroup, SpellTimer, TimerTable)
	
	table.insert(SpellTimer,
			{
				Name = nom,
				Time = duree,
				TimeMax = floor(GetTime() + duree),
				Type = truc,
				Target = Target,
				TargetLevel = LevelTarget,
				Group = 0,
				Gtimer = nil
			});

	-- Association d'un timer graphique au timer
	SpellTimer, TimerTable = Necrosis_AddFrame(SpellTimer, TimerTable);

	-- Tri des entrées par type de sort
	Necrosis_Tri(SpellTimer, "Type");
	
	-- Création des groupes (noms des mobs) des timers
	SpellGroup, SpellTimer = Necrosis_Parsing(SpellGroup, SpellTimer);

	return SpellGroup, SpellTimer, TimerTable;	
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS DE RETRAIT
------------------------------------------------------------------------------------------------------


-- Connaissant l'index du Timer dans la liste, on le supprime
function Necrosis_RetraitTimerParIndex(index, SpellTimer, TimerTable)

		-- Suppression du timer graphique
		local Gtime = SpellTimer[index].Gtimer;
		TimerTable = Necrosis_RemoveFrame(Gtime, TimerTable);
		
		-- On enlève le timer de la liste
		table.remove(SpellTimer, index);

	return SpellTimer, TimerTable;
end

-- Si on veut supprimer spécifiquement un Timer...
function Necrosis_RetraitTimerParNom(name, SpellTimer, TimerTable)
	for index = 1, table.getn(SpellTimer), 1 do
		if SpellTimer[index].Name == name then
			SpellTimer = Necrosis_RetraitTimerParIndex(index, SpellTimer, TimerTable);
			break;
		end
	end
	return SpellTimer, TimerTable;
end

-- Fonction pour enlever les timers de combat lors de la regen
function Necrosis_RetraitTimerCombat(SpellGroup, SpellTimer, TimerTable)
	for index=1, table.getn(SpellTimer), 1 do
		if SpellTimer[index] then
			-- Si les cooldowns sont nominatifs, on enlève le nom
			if SpellTimer[index].Type == 3 then
				SpellTimer[index].Target = "";
				SpellTimer[index].TargetLevel = "";
			end
			-- Enlevage des timers de combat
			if ((SpellTimer[index].Type == 4) or (SpellTimer[index].Type == 5)) then
				SpellTimer = Necrosis_RetraitTimerParIndex(index, SpellTimer, TimerTable);
			end
		end
	end

	if table.getn(SpellGroup.Name) >= 4 then
		for index = 4, table.getn(SpellGroup.Name), 1 do
			table.remove(SpellGroup.Name);
			table.remove(SpellGroup.SubName);
			table.remove(SpellGroup.Visible);
		end
	end
	return SpellGroup, SpellTimer, TimerTable;
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS BOOLEENNES
------------------------------------------------------------------------------------------------------

function Necrosis_TimerExisteDeja(Nom, SpellTimer)
	for index = 1, table.getn(SpellTimer), 1 do
		if SpellTimer[index].Name == Nom then
			return true;
		end
	end
	return false;
end


------------------------------------------------------------------------------------------------------
-- FONCTIONS DE TRI
------------------------------------------------------------------------------------------------------

-- On définit les groupes de chaque Timer
function Necrosis_Parsing(SpellGroup, SpellTimer)
	local GroupeOK = false;
	for index = 1, table.getn(SpellTimer), 1 do
		local GroupeOK = false;
		for i = 1, table.getn(SpellGroup.Name), 1 do
			if ((SpellTimer[index].Type == i) and (i <= 3)) or 
			   (SpellTimer[index].Target == SpellGroup.Name[i]
				and SpellTimer[index].TargetLevel == SpellGroup.SubName[i])
				then
				GroupeOK = true;
				SpellTimer[index].Group = i;
				break;
			end
		end
		-- Si le groupe n'existe pas, on en crée un nouveau
		if not GroupeOK then
			table.insert(SpellGroup.Name, SpellTimer[index].Target);
			table.insert(SpellGroup.SubName, SpellTimer[index].TargetLevel);
			table.insert(SpellGroup.Visible, false);
			SpellTimer[index].Group = table.getn(SpellGroup.Name);
		end
	end
	
	 Necrosis_Tri(SpellTimer, "Group");
	return SpellGroup, SpellTimer;
end

-- On trie les timers selon leur groupe
function Necrosis_Tri(SpellTimer, clef)
	return table.sort(SpellTimer,
		function (SubTab1, SubTab2)
			return SubTab1[clef] < SubTab2[clef]
		end);
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS D'AFFICHAGE : CREATION DE LA CHAINE DE CARACTERE
------------------------------------------------------------------------------------------------------


function Necrosis_DisplayTimer(display, index, SpellGroup, SpellTimer, GraphicalTimer, TimerTable)
	if not SpellTimer then
		return display, SpellGroup;
	end
	
	local minutes = 0;
	local seconds = 0;
	local affichage;
	
	-- Changement de la couleur suivant le temps restant	
	local percent = (floor(SpellTimer[index].TimeMax - floor(GetTime())) / SpellTimer[index].Time)*100;
	local color = NecrosisTimerColor(percent);
	
	if not SpellGroup.Visible[SpellTimer[index].Group]
		and SpellGroup.SubName[SpellTimer[index].Group] ~= nil
		and SpellGroup.Name[SpellTimer[index].Group] ~= nil then
		display = display.."<purple>-------------------------------\n"..SpellGroup.Name[SpellTimer[index].Group].." "..SpellGroup.SubName[SpellTimer[index].Group].."\n-------------------------------<close>\n";
		-- Crée le tableau qui servira aux timers graphiques
		table.insert(GraphicalTimer.texte, SpellGroup.Name[SpellTimer[index].Group].." "..SpellGroup.SubName[SpellTimer[index].Group]);
		table.insert(GraphicalTimer.TimeMax, 0);
		table.insert(GraphicalTimer.Time, 0);
		table.insert(GraphicalTimer.titre, true);
		table.insert(GraphicalTimer.temps, "");
		table.insert(GraphicalTimer.Gtimer, 0);
		SpellGroup.Visible[SpellTimer[index].Group] = true;
	end

	-- Mise en place d'un Chrono plutôt qu'un Compte à Rebours pour l'asservissement
	if SpellTimer[index].Name == NECROSIS_SPELL_TABLE[10].Name then
		seconds = floor(GetTime()) - (SpellTimer[index].TimeMax - SpellTimer[index].Time);
	else
		seconds = SpellTimer[index].TimeMax - floor(GetTime());
	end
	minutes = floor(seconds/60);
	if (minutes > 0) then
		if (minutes > 9) then
			affichage = tostring(minutes)..":";
		else
			affichage = "0"..minutes..":"
		end
	else
		affichage = "0:";
	end
	seconds = mod(seconds, 60);
	if (seconds > 9) then
		affichage = affichage..seconds
	else
		affichage = affichage.."0"..seconds
	end
	display = display.."<white>"..affichage.." - <close>";

	-- Crée le tableau qui servira aux timers graphiques
	if (SpellTimer[index].Type == 1 or SpellTimer[index].Name == NECROSIS_SPELL_TABLE[16].Name)
	and (SpellTimer[index].Target ~= "") then
		if NecrosisConfig.SpellTimerPos == 1 then
			affichage = affichage.." - "..SpellTimer[index].Target;
		else
			affichage = SpellTimer[index].Target.." - "..affichage;
		end
	end
	table.insert(GraphicalTimer.texte, SpellTimer[index].Name);
	table.insert(GraphicalTimer.TimeMax, SpellTimer[index].TimeMax);
	table.insert(GraphicalTimer.Time, SpellTimer[index].Time);
	table.insert(GraphicalTimer.titre, false);
	table.insert(GraphicalTimer.temps, affichage);
	table.insert(GraphicalTimer.Gtimer, SpellTimer[index].Gtimer);

	if NecrosisConfig.CountType == 3 then
		if SpellTimer[index].Name == NECROSIS_SPELL_TABLE[11].Name then
			if (minutes > 0) then
				NecrosisShardCount:SetText(minutes.." m");
			else
				NecrosisShardCount:SetText(seconds);
			end
		end
	end
	if NecrosisConfig.Circle == 2 then
		if SpellTimer[index].Name == NECROSIS_SPELL_TABLE[11].Name then
			if (minutes >= 16) then
				NecrosisButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Turquoise\\Shard"..minutes - 15);
			elseif minutes >= 1 or seconds >= 33 then
				NecrosisButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Orange\\Shard"..minutes + 1);
			else
				NecrosisButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Rose\\Shard"..seconds);
			end
		end
	end
	display = display..color..SpellTimer[index].Name.."<close><white>";
	if (SpellTimer[index].Type == 1 or SpellTimer[index].Name == NECROSIS_SPELL_TABLE[16].Name)
		and (SpellTimer[index].Target ~= "")
		then
		display = display.." - "..SpellTimer[index].Target.."<close>\n";
	else
		display = display.."<close>\n";
	end
	-- Affichage des timers graphiques (si sélectionnés)
	if NecrosisConfig.Graphical then
		NecrosisAfficheTimer(GraphicalTimer, TimerTable);
	end

	return display, SpellGroup, GraphicalTimer, TimerTable;
end
