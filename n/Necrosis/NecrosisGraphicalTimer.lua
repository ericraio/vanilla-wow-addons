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
-- Version 07.04.2006-1
------------------------------------------------------------------------------------------------------


-- La fonction d'affichage des timers
-- tableau est de la forme suivante :
-- tableau {
	-- texte = "Nom du mob ou du sort",
	-- TimeMax = "TimeMax du sort",
	-- Time = "Time du sort",
	-- titre = "vrai si titre, faux sinon",
	-- temps = "timer numérique",
	-- Gtimer = "Numéro du timer associé (entre 1 et 65)"
-- }
function NecrosisAfficheTimer(tableau, pointeur)
	-- On définit l'endroit ou apparaitra la première frame
	-- On déclare que la première frame est toujours le premier mob (logique :P)
	
	if tableau ~= nil then
		local TimerTarget = 0;
		local yPosition = NecrosisConfig.SensListe * 5;

		local PositionTitre = {};

		if NecrosisConfig.SensListe > 0 then
			PositionTitre = {11, 13};
		else
			PositionTitre = {-13, -11};
		end
			
	
		for index =  1, table.getn(tableau.texte), 1 do
			-- Si l'entrée est un titre de mob
			if tableau.titre[index] then
				-- On change de groupe de mob
				TimerTarget = TimerTarget + 1;
				if TimerTarget ~= 1 then yPosition = yPosition - PositionTitre[1]; end
				if TimerTarget == 11 then TimerTarget = 1; end
				-- On affiche le titre
				local frameName = "NecrosisTarget"..TimerTarget.."Text";
				local frameItem = getglobal(frameName);
				-- On place le coin gauche de la frame par rapport au centre du bouton des SpellTimers
				frameItem:ClearAllPoints();
				frameItem:SetPoint(NecrosisConfig.SpellTimerJust, "NecrosisSpellTimerButton", "CENTER", NecrosisConfig.SpellTimerPos * 23, yPosition);
				yPosition = yPosition - PositionTitre[2];
				-- On nomme la frame, puis on l'affiche ! :)
				frameItem:SetText(tableau.texte[index]);
				if not frameItem:IsShown() then
					frameItem:Show();
				end
			else
				-- Pareil pour les DoT
				local JustifInverse = "LEFT";
				if NecrosisConfig.SpellTimerJust == "LEFT" then JustifInverse = "RIGHT"; end	
			
				local frameName1 = "NecrosisTimer"..tableau.Gtimer[index].."Text";
				local frameItem1 = getglobal(frameName1);
				local frameName2 = "NecrosisTimer"..tableau.Gtimer[index].."Bar";
				local frameItem2 = getglobal(frameName2);
				local frameName3 = "NecrosisTimer"..tableau.Gtimer[index].."Texture";
				local frameItem3 = getglobal(frameName3);
				local frameName4 = "NecrosisTimer"..tableau.Gtimer[index].."Spark";
				local frameItem4 = getglobal(frameName4);
				local frameName5 = "NecrosisTimer"..tableau.Gtimer[index].."OutText";
				local frameItem5 = getglobal(frameName5);

				frameItem1:ClearAllPoints();
				frameItem1:SetPoint(NecrosisConfig.SpellTimerJust, "NecrosisSpellTimerButton", "CENTER", NecrosisConfig.SpellTimerPos * 23, yPosition + 1);
				if NecrosisConfig.Yellow then
					frameItem1:SetTextColor(1, 0.82, 0);
				else
					frameItem1:SetTextColor(1, 1, 1);
				end
				frameItem1:SetJustifyH("LEFT");
				frameItem1:SetText(tableau.texte[index]);
					frameItem2:ClearAllPoints();
				frameItem2:SetPoint(NecrosisConfig.SpellTimerJust, "NecrosisSpellTimerButton", "CENTER", NecrosisConfig.SpellTimerPos * 23, yPosition);
				frameItem2:SetMinMaxValues(tableau.TimeMax[index] - tableau.Time[index], tableau.TimeMax[index]);
				frameItem2:SetValue(2 * tableau.TimeMax[index] - (tableau.Time[index] + floor(GetTime())));
				local r, g;
				local b = 37/255;
				local PercentColor = (tableau.TimeMax[index] - floor(GetTime())) / tableau.Time[index]
				if PercentColor > 0.5 then
					r = (49/255) + (((1 - PercentColor) * 2) * (1 - (49/255)));
					g = 207/255;
				else
					r = 1.0;
					g = (207/255) - (0.5 - PercentColor) * 2 * (207/255);
				end
				frameItem2:SetStatusBarColor(r, g, b)
					frameItem3:ClearAllPoints();
				frameItem3:SetPoint(NecrosisConfig.SpellTimerJust, "NecrosisSpellTimerButton", "CENTER", NecrosisConfig.SpellTimerPos * 23, yPosition);
				frameItem5:ClearAllPoints();
				frameItem5:SetTextColor(1, 1, 1);
				frameItem5:SetJustifyH(NecrosisConfig.SpellTimerJust);
				frameItem5:SetPoint(NecrosisConfig.SpellTimerJust, frameItem2, JustifInverse, NecrosisConfig.SpellTimerPos * 5, 1);
				frameItem5:SetText(tableau.temps[index]);

				local sparkPosition = 150 - ((floor(GetTime()) - (tableau.TimeMax[index] - tableau.Time[index])) / tableau.Time[index]) * 150;
				if (sparkPosition < 1) then
					sparkPosition = 1;
				end
				frameItem4:SetPoint("CENTER", frameItem2, "LEFT", sparkPosition, 0);
				yPosition = yPosition - NecrosisConfig.SensListe * 11;
			end
		end
		if TimerTarget < 10 then
			for i = TimerTarget + 1, 10, 1 do
				local frameName = "NecrosisTarget"..i.."Text";
				local frameItem = getglobal(frameName);
				if frameItem:IsShown() then
					frameItem:Hide();
				end
			end
		end
	end
end

function Necrosis_AddFrame(SpellTimer, TimerTable)
	for i = 1, table.getn(TimerTable), 1 do
		if not TimerTable[i] then
			TimerTable[i] = true;
			SpellTimer[table.getn(SpellTimer)].Gtimer = i;
			-- Affichage du timer graphique associé
			if NecrosisConfig.Graphical then
				local elements = {"Text", "Bar", "Texture", "OutText"}
				for j = 1, 4, 1 do
					frameName = "NecrosisTimer"..i..elements[j];
					frameItem = getglobal(frameName);
					frameItem:Show();
				end
			end
			break
		end
	end
	return SpellTimer, TimerTable;
end

function Necrosis_RemoveFrame(Gtime, TimerTable)
	-- On cache le timer graphique
	local elements = {"Text", "Bar", "Texture", "OutText"}
	for j = 1, 4, 1 do
		frameName = "NecrosisTimer"..Gtime..elements[j];
		frameItem = getglobal(frameName);
		frameItem:Hide();
	end

	-- On déclare le timer graphique comme réutilisable
	TimerTable[Gtime] = false;
	
	return TimerTable;
end
