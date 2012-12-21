-- plein de trucs

PowaSavedBuff = {};
PowaSavedDebuff = {};
PowaSavedDebuffType = {};

CurrentPage = 0;

CurrentPageType ="Buff";

-- -----------------------------------------------------------------------
function Powa_UpdateList()
local j = 0;
	if (CurrentPageType == "Debuff") then -- un debuff
		for i = 1, 10 do
			j = (CurrentPage * 10) + i;
			if (PowaSavedDebuff[j]) then
				getglobal("PowaListLigne"..i.."_text"):SetText(PowaSavedDebuff[j].buffname);
				getglobal("PowaListLigne"..i.."_text"):SetTextColor(1.0, 0.5, 0.5);
				getglobal("PowaListLigne"..i.."_buttondelete"):Show();
				getglobal("PowaListLigne"..i.."_buttondelete").num = j;
				getglobal("PowaListLigne"..i.."_buttonload"):Show();
				getglobal("PowaListLigne"..i.."_buttonload").num = j;
				getglobal("PowaListLigne"..i.."_buttontest"):Show();
				getglobal("PowaListLigne"..i.."_buttontest").num = j;
			else
				getglobal("PowaListLigne"..i.."_text"):SetTextColor(0.5, 0.25, 0.25);
				getglobal("PowaListLigne"..i.."_text"):SetText("-vide-");
				getglobal("PowaListLigne"..i.."_buttondelete"):Hide();
				getglobal("PowaListLigne"..i.."_buttonload"):Hide();
				getglobal("PowaListLigne"..i.."_buttontest"):Hide();
			end
		end
	elseif (CurrentPageType == "DebuffType") then -- un type de debuff
		for i = 1, 10 do
			j = (CurrentPage * 10) + i;
			if (PowaSavedDebuffType[j]) then
				getglobal("PowaListLigne"..i.."_text"):SetText(PowaSavedDebuffType[j].buffname);
				getglobal("PowaListLigne"..i.."_text"):SetTextColor(1.0, 1.0, 0.5);
				getglobal("PowaListLigne"..i.."_buttondelete"):Show();
				getglobal("PowaListLigne"..i.."_buttondelete").num = j;
				getglobal("PowaListLigne"..i.."_buttonload"):Show();
				getglobal("PowaListLigne"..i.."_buttonload").num = j;
				getglobal("PowaListLigne"..i.."_buttontest"):Show();
				getglobal("PowaListLigne"..i.."_buttontest").num = j;
			else
				getglobal("PowaListLigne"..i.."_text"):SetText("-vide-");
				getglobal("PowaListLigne"..i.."_text"):SetTextColor(0.5, 0.5, 0.25);
				getglobal("PowaListLigne"..i.."_buttondelete"):Hide();
				getglobal("PowaListLigne"..i.."_buttonload"):Hide();
				getglobal("PowaListLigne"..i.."_buttontest"):Hide();
			end
		end
	else -- un buff donc
		for i = 1, 10 do
			j = (CurrentPage * 10) + i;
			if (PowaSavedBuff[j]) then
				getglobal("PowaListLigne"..i.."_text"):SetText(PowaSavedBuff[j].buffname);
				getglobal("PowaListLigne"..i.."_text"):SetTextColor(0.5, 1.0, 0.5);
				getglobal("PowaListLigne"..i.."_buttondelete"):Show();
				getglobal("PowaListLigne"..i.."_buttondelete").num = j;
				getglobal("PowaListLigne"..i.."_buttonload"):Show();
				getglobal("PowaListLigne"..i.."_buttonload").num = j;
				getglobal("PowaListLigne"..i.."_buttontest"):Show();
				getglobal("PowaListLigne"..i.."_buttontest").num = j;
			else
				getglobal("PowaListLigne"..i.."_text"):SetText("-vide-");
				getglobal("PowaListLigne"..i.."_text"):SetTextColor(0.25, 0.5, 0.25);
				getglobal("PowaListLigne"..i.."_buttondelete"):Hide();
				getglobal("PowaListLigne"..i.."_buttonload"):Hide();
				getglobal("PowaListLigne"..i.."_buttontest"):Hide();
			end
		end
	end
end

-- -----------------------------------------------------------------------
function Powa_GetSavePosition()

	if (PowaSet[CurrentAura].buffname == "" or PowaSet[CurrentAura].buffname == " ") then
		DEFAULT_CHAT_FRAME:AddMessage("|cffB0A0ff<Power Auras>|r|cffff8080 "..PowaText.erreur1.."|r");
		return 0;
	end

	if (PowaSet[CurrentAura].isdebuff) then -- un debuff
		for i=1, 100 do
			if (PowaSavedDebuff[i]) then
				if (PowaSavedDebuff[i].buffname == PowaSet[CurrentAura].buffname) then
					DEFAULT_CHAT_FRAME:AddMessage("|cffB0A0ff<Power Auras>|r|cffff8080 "..PowaText.erreur2.."|r");
					return 0;
				end
			else
				return i;
			end
		end
	elseif (PowaSet[CurrentAura].isdebufftype) then -- un type de debuff
		for i=1, 10 do
			if (PowaSavedDebuffType[i]) then
				if (PowaSavedDebuffType[i].buffname == PowaSet[CurrentAura].buffname) then
					DEFAULT_CHAT_FRAME:AddMessage("|cffB0A0ff<Power Auras>|r|cffff8080 "..PowaText.erreur2.."|r");
					return 0;
				end
			else
				return i;
			end
		end
	else -- un buff donc
		for i=1, 100 do
			if (PowaSavedBuff[i]) then
				if (PowaSavedBuff[i].buffname == PowaSet[CurrentAura].buffname) then
					DEFAULT_CHAT_FRAME:AddMessage("|cffB0A0ff<Power Auras>|r|cffff8080 "..PowaText.erreur2.."|r");
					return 0;
				end
			else
				return i;
			end
		end
	end
	DEFAULT_CHAT_FRAME:AddMessage("|cffB0A0ff<Power Auras>|r|cffff8080 "..PowaText.erreur3.."|r");
	return 0;
end

-- ------------------------------------------ Sauve un effet dans la liste
function Powa_SaveEffect()
   local SavePosition = 0;

	if (PowaSet[CurrentAura].isdebuff) then -- un debuff
		SavePosition = Powa_GetSavePosition();
		if (SavePosition == 0) then return; end
		-- copie tout donc
		PowaSavedDebuff[SavePosition] = {
			texture = PowaSet[CurrentAura].texture,
			anim1 = PowaSet[CurrentAura].anim1,
			anim2 = PowaSet[CurrentAura].anim2,
			speed = PowaSet[CurrentAura].speed,
			begin = PowaSet[CurrentAura].begin,
			duration = PowaSet[CurrentAura].duration,
			alpha = PowaSet[CurrentAura].alpha,
			size = PowaSet[CurrentAura].size,
			torsion = PowaSet[CurrentAura].torsion,
			symetrie = PowaSet[CurrentAura].symetrie,
			x = PowaSet[CurrentAura].x,
			y = PowaSet[CurrentAura].y,
			buffname = PowaSet[CurrentAura].buffname,
			isdebuff = PowaSet[CurrentAura].isdebuff,
			isdebufftype = PowaSet[CurrentAura].isdebufftype,
			timer = PowaSet[CurrentAura].timer,
			inverse = PowaSet[CurrentAura].inverse,
			r = PowaSet[CurrentAura].r,
			g = PowaSet[CurrentAura].g,
			b = PowaSet[CurrentAura].b
		}
		CurrentPageType ="Debuff";
		Powa_ChangeCurrentPage( math.ceil(SavePosition / 10) - 1 )
		Powa_UpdateList();

	elseif (PowaSet[CurrentAura].isdebufftype) then -- un type de debuff
		SavePosition = Powa_GetSavePosition();
		if (SavePosition == 0) then return; end		
		-- copie tout donc
		PowaSavedDebuffType[SavePosition] = {
			texture = PowaSet[CurrentAura].texture,
			anim1 = PowaSet[CurrentAura].anim1,
			anim2 = PowaSet[CurrentAura].anim2,
			speed = PowaSet[CurrentAura].speed,
			begin = PowaSet[CurrentAura].begin,
			duration = PowaSet[CurrentAura].duration,
			alpha = PowaSet[CurrentAura].alpha,
			size = PowaSet[CurrentAura].size,
			torsion = PowaSet[CurrentAura].torsion,
			symetrie = PowaSet[CurrentAura].symetrie,
			x = PowaSet[CurrentAura].x,
			y = PowaSet[CurrentAura].y,
			buffname = PowaSet[CurrentAura].buffname,
			isdebuff = PowaSet[CurrentAura].isdebuff,
			isdebufftype = PowaSet[CurrentAura].isdebufftype,
			timer = PowaSet[CurrentAura].timer,
			inverse = PowaSet[CurrentAura].inverse,
			r = PowaSet[CurrentAura].r,
			g = PowaSet[CurrentAura].g,
			b = PowaSet[CurrentAura].b
		}
		CurrentPageType ="DebuffType";
		Powa_ChangeCurrentPage( math.ceil(SavePosition / 10) - 1 )
		Powa_UpdateList();

	else -- un buff donc
		SavePosition = Powa_GetSavePosition();
		if (SavePosition == 0) then return; end
		-- copie tout donc
		PowaSavedBuff[SavePosition] = {
			texture = PowaSet[CurrentAura].texture,
			anim1 = PowaSet[CurrentAura].anim1,
			anim2 = PowaSet[CurrentAura].anim2,
			speed = PowaSet[CurrentAura].speed,
			begin = PowaSet[CurrentAura].begin,
			duration = PowaSet[CurrentAura].duration,
			alpha = PowaSet[CurrentAura].alpha,
			size = PowaSet[CurrentAura].size,
			torsion = PowaSet[CurrentAura].torsion,
			symetrie = PowaSet[CurrentAura].symetrie,
			x = PowaSet[CurrentAura].x,
			y = PowaSet[CurrentAura].y,
			buffname = PowaSet[CurrentAura].buffname,
			isdebuff = PowaSet[CurrentAura].isdebuff,
			isdebufftype = PowaSet[CurrentAura].isdebufftype,
			timer = PowaSet[CurrentAura].timer,
			inverse = PowaSet[CurrentAura].inverse,
			r = PowaSet[CurrentAura].r,
			g = PowaSet[CurrentAura].g,
			b = PowaSet[CurrentAura].b
		}
		CurrentPageType ="Buff";
		Powa_ChangeCurrentPage( math.ceil(SavePosition / 10) - 1 )
		Powa_UpdateList();
	end
end

-- ------------------------------------------------------------------------------

function Powa_CopyEffect(Pfrom, Pto)
	-- utilise la page en cours
	if (CurrentPageType == "Debuff") then -- un debuff
		PowaSet[Pto].texture = PowaSavedDebuff[Pfrom].texture;
		PowaSet[Pto].anim1 = PowaSavedDebuff[Pfrom].anim1;
		PowaSet[Pto].anim2 = PowaSavedDebuff[Pfrom].anim2;
		PowaSet[Pto].speed = PowaSavedDebuff[Pfrom].speed;
		PowaSet[Pto].begin = PowaSavedDebuff[Pfrom].begin;
		PowaSet[Pto].duration = PowaSavedDebuff[Pfrom].duration;
		PowaSet[Pto].alpha = PowaSavedDebuff[Pfrom].alpha;
		PowaSet[Pto].size = PowaSavedDebuff[Pfrom].size;
		PowaSet[Pto].torsion = PowaSavedDebuff[Pfrom].torsion;
		PowaSet[Pto].symetrie = PowaSavedDebuff[Pfrom].symetrie;
		PowaSet[Pto].x = PowaSavedDebuff[Pfrom].x;
		PowaSet[Pto].y = PowaSavedDebuff[Pfrom].y;
		PowaSet[Pto].buffname = PowaSavedDebuff[Pfrom].buffname;
		PowaSet[Pto].isdebuff = PowaSavedDebuff[Pfrom].isdebuff;
		PowaSet[Pto].isdebufftype = PowaSavedDebuff[Pfrom].isdebufftype;
		PowaSet[Pto].timer = PowaSavedDebuff[Pfrom].timer;
		PowaSet[Pto].inverse = PowaSavedDebuff[Pfrom].inverse;
		PowaSet[Pto].r = PowaSavedDebuff[Pfrom].r;
		PowaSet[Pto].g = PowaSavedDebuff[Pfrom].g;
		PowaSet[Pto].b = PowaSavedDebuff[Pfrom].b;
			
	elseif (CurrentPageType == "DebuffType") then -- un debuff
		PowaSet[Pto].texture = PowaSavedDebuffType[Pfrom].texture;
		PowaSet[Pto].anim1 = PowaSavedDebuffType[Pfrom].anim1;
		PowaSet[Pto].anim2 = PowaSavedDebuffType[Pfrom].anim2;
		PowaSet[Pto].speed = PowaSavedDebuffType[Pfrom].speed;
		PowaSet[Pto].begin = PowaSavedDebuffType[Pfrom].begin;
		PowaSet[Pto].duration = PowaSavedDebuffType[Pfrom].duration;
		PowaSet[Pto].alpha = PowaSavedDebuffType[Pfrom].alpha;
		PowaSet[Pto].size = PowaSavedDebuffType[Pfrom].size;
		PowaSet[Pto].torsion = PowaSavedDebuffType[Pfrom].torsion;
		PowaSet[Pto].symetrie = PowaSavedDebuffType[Pfrom].symetrie;
		PowaSet[Pto].x = PowaSavedDebuffType[Pfrom].x;
		PowaSet[Pto].y = PowaSavedDebuffType[Pfrom].y;
		PowaSet[Pto].buffname = PowaSavedDebuffType[Pfrom].buffname;
		PowaSet[Pto].isdebuff = PowaSavedDebuffType[Pfrom].isdebuff;
		PowaSet[Pto].isdebufftype = PowaSavedDebuffType[Pfrom].isdebufftype;
		PowaSet[Pto].timer = PowaSavedDebuffType[Pfrom].timer;
		PowaSet[Pto].inverse = PowaSavedDebuffType[Pfrom].inverse;
		PowaSet[Pto].r = PowaSavedDebuffType[Pfrom].r;
		PowaSet[Pto].g = PowaSavedDebuffType[Pfrom].g;
		PowaSet[Pto].b = PowaSavedDebuffType[Pfrom].b;
	else
		PowaSet[Pto].texture = PowaSavedBuff[Pfrom].texture;
		PowaSet[Pto].anim1 = PowaSavedBuff[Pfrom].anim1;
		PowaSet[Pto].anim2 = PowaSavedBuff[Pfrom].anim2;
		PowaSet[Pto].speed = PowaSavedBuff[Pfrom].speed;
		PowaSet[Pto].begin = PowaSavedBuff[Pfrom].begin;
		PowaSet[Pto].duration = PowaSavedBuff[Pfrom].duration;
		PowaSet[Pto].alpha = PowaSavedBuff[Pfrom].alpha;
		PowaSet[Pto].size = PowaSavedBuff[Pfrom].size;
		PowaSet[Pto].torsion = PowaSavedBuff[Pfrom].torsion;
		PowaSet[Pto].symetrie = PowaSavedBuff[Pfrom].symetrie;
		PowaSet[Pto].x = PowaSavedBuff[Pfrom].x;
		PowaSet[Pto].y = PowaSavedBuff[Pfrom].y;
		PowaSet[Pto].buffname = PowaSavedBuff[Pfrom].buffname;
		PowaSet[Pto].isdebuff = PowaSavedBuff[Pfrom].isdebuff;
		PowaSet[Pto].isdebufftype = PowaSavedBuff[Pfrom].isdebufftype;
		PowaSet[Pto].timer = PowaSavedBuff[Pfrom].timer;
		PowaSet[Pto].inverse = PowaSavedBuff[Pfrom].inverse;
		PowaSet[Pto].r = PowaSavedBuff[Pfrom].r;
		PowaSet[Pto].g = PowaSavedBuff[Pfrom].g;
		PowaSet[Pto].b = PowaSavedBuff[Pfrom].b;	
	end

	-- gere les rajouts :
	if (PowaSet[Pto].duration == nil) then PowaSet[Pto].duration = 0; end
	if (PowaSet[Pto].begin == nil) then PowaSet[Pto].begin = 0; end
	if (PowaSet[Pto].timer == nil) then PowaSet[Pto].timer = false; end
	if (PowaSet[Pto].inverse == nil) then PowaSet[Pto].inverse = false; end
	if (PowaSet[Pto].speed == nil) then PowaSet[Pto].speed = 1.0; end
end

-- ------------------------------------------------------------------------------

function Powa_ListeLoadEffect(PBouton)
	if (PBouton.num) then
		Powa_CopyEffect(PBouton.num, CurrentAura);
		Powa_InitPage(); -- change la page des options d'effet en cours
	end
end

-- ------------------------------------------------------------------------------

function Powa_ListeTestEffect(PBouton)

	if (PBouton.num) then
		-- copie les infos enregistrees dans l'effet de test
		Powa_CopyEffect(PBouton.num, CurrentTestAura);

		-- supprime le nom du buff ceci dit
		PowaSet[CurrentTestAura].buffname = "";
		
		-- affiche
		if (Powa_Frames[CurrentTestAura]:IsVisible()) then -- deja visible, on la cache
			Powa_FramesVisibleTime[CurrentTestAura] = 0;
			Powa_FramesVisibleTime[SecondeAura] = 0;
		else                                           -- pas visible alors on affiche
			Powa_DisplayAura(CurrentTestAura);
		end	
	end
end

-- ------------------------------------------------------------------------------

function Powa_NoSpacesInList()
local a;
	
	a = 1;
	if (CurrentPageType == "Debuff") then -- un debuff
		for i = 1, 100 do
			if (PowaSavedDebuff[i]) then
				PowaSavedDebuff[a] = PowaSavedDebuff[i];
				if (i>a) then
					PowaSavedDebuff[i] = nil;
				end
				a = a+1;
			end
		end
	elseif (CurrentPageType == "DebuffType") then -- un debuff
		for i = 1, 10 do
			if (PowaSavedDebuffType[i]) then
				PowaSavedDebuffType[a] = PowaSavedDebuffType[i];
				if (i>a) then
					PowaSavedDebuffType[i] = nil;
				end
				a = a+1;
			end
		end
	else
		for i = 1, 100 do
			if (PowaSavedBuff[i]) then
				PowaSavedBuff[a] = PowaSavedBuff[i];
				if (i>a) then
					PowaSavedBuff[i] = nil;
				end
				a = a+1;
			end
		end
	end
end

-- ------------------------------------------------------------------------------

function Powa_ListeDeleteEffect(PBouton)

	if (PBouton.num) then
		if (CurrentPageType == "Debuff") then -- un debuff
			PowaSavedDebuff[PBouton.num] = nil;
		elseif (CurrentPageType == "DebuffType") then -- un debuff
			PowaSavedDebuffType[PBouton.num] = nil;
		else
			PowaSavedBuff[PBouton.num] = nil;
		end
		Powa_NoSpacesInList();
		Powa_UpdateList();
	end
end

-- ------------------------------------------------------------------------------

function Powa_ChangeCurrentPage(Pnum, Pname)
	CurrentPage = Pnum;
	getglobal("PowaListPage"):SetText("Page "..(CurrentPage+1).."/10");
	-- si un type de debuff, y'a qu'une page
	if (Pname == "DebuffType") then
		getglobal("PowaListPage"):Hide();
		getglobal("powa_listprevious"):Hide();
		getglobal("powa_listnext"):Hide();
	else
		getglobal("PowaListPage"):Show();
		getglobal("powa_listprevious"):Show();
		getglobal("powa_listnext"):Show();
	end
end

function Powa_ChangeListNext()

	if (CurrentPage < 9) then
		Powa_ChangeCurrentPage(CurrentPage+1);
		Powa_UpdateList();
	end
end

function Powa_ChangeListPrev()

	if (CurrentPage > 0) then
		Powa_ChangeCurrentPage(CurrentPage-1);
		Powa_UpdateList();
	end
end

function Powa_ListChangeType(Pname)
	CurrentPageType = Pname;
	Powa_ChangeCurrentPage(0,Pname);
	Powa_UpdateList();
end

-- ------------------------------------------------------------------------------

function Powa_ShowList()
	if (getglobal("PowaListFrame"):IsVisible()) then
		getglobal("PowaListFrame"):Hide();
	else
		getglobal("PowaListFrame"):Show();
		getglobal("PowaHelpList"):SetText(PowaText.aideListe);
		Powa_UpdateList();
	end
end

-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

function Powa_UpdateOptionsTimer()

	if (PowaEnabled == 0) then return; end   -- desactived

	Powa_Timer[1]:SetAlpha(PowaMisc.BTimerA);
	Powa_Timer[1]:SetWidth(20 * PowaMisc.BTimerScale);
	Powa_Timer[1]:SetHeight(20 * PowaMisc.BTimerScale);
	Powa_Timer[1]:SetPoint("Center", PowaMisc.BTimerX, PowaMisc.BTimerY);

	Powa_Timer[2]:SetAlpha(PowaMisc.BTimerA);
	Powa_Timer[2]:SetWidth(14 * PowaMisc.BTimerScale);
	Powa_Timer[2]:SetHeight(14 * PowaMisc.BTimerScale);
	Powa_Timer[2]:SetPoint("LEFT", Powa_Timer[1], "RIGHT", 1, -1.5);
	Powa_Timer[2]:SetAlpha(PowaMisc.BTimerA * 0.75);
end

function Powa_UpdateOptions()
	getglobal("PowaTimerAlphaSlider"):SetValue(PowaMisc.BTimerA);
	getglobal("PowaTimerSizeSlider"):SetValue(PowaMisc.BTimerScale);
	getglobal("PowaTimerCoordSlider"):SetValue(PowaMisc.BTimerY);
	getglobal("PowaTimerCoordXSlider"):SetValue(PowaMisc.BTimerX);

	getglobal("PowaTimer2AlphaSlider"):SetValue(PowaMisc.DTimerA);
	getglobal("PowaTimer2SizeSlider"):SetValue(PowaMisc.DTimerScale);
	getglobal("PowaTimer2CoordSlider"):SetValue(PowaMisc.DTimerY);
	getglobal("PowaTimer2CoordXSlider"):SetValue(PowaMisc.DTimerX);

	getglobal("PowaBuffTimerCentsButton"):SetChecked(PowaMisc.BCents);
	getglobal("PowaDebuffTimerCentsButton"):SetChecked(PowaMisc.DCents);
	getglobal("PowaDisableButton"):SetChecked(PowaMisc.disabled);
	getglobal("PowaMaxTexSlider"):SetValue(PowaGlobal.maxtextures);
end

function PowaTimerAlphaSliderChanged()
	local SliderValue = getglobal("PowaTimerAlphaSlider"):GetValue();

	getglobal("PowaTimerAlphaSliderText"):SetText(PowaText.nomAlpha.." : "..format("%.2f", SliderValue) );

	PowaMisc.BTimerA = SliderValue;
	Powa_UpdateOptionsTimer()
end

function PowaTimerSizeSliderChanged()
	local SliderValue = getglobal("PowaTimerSizeSlider"):GetValue();

	getglobal("PowaTimerSizeSliderText"):SetText(PowaText.nomTaille.." : "..format("%.2f", SliderValue) );

	PowaMisc.BTimerScale = SliderValue;
	Powa_UpdateOptionsTimer()
end

function PowaTimerCoordSliderChanged()
	local SliderValue = getglobal("PowaTimerCoordSlider"):GetValue();

	getglobal("PowaTimerCoordSliderText"):SetText(PowaText.nomPos.." Y : "..SliderValue);

	PowaMisc.BTimerY = SliderValue;
	Powa_UpdateOptionsTimer()
end

function PowaTimerCoordXSliderChanged()
	local SliderValue = getglobal("PowaTimerCoordXSlider"):GetValue();

	getglobal("PowaTimerCoordXSliderText"):SetText(PowaText.nomPos.." X : "..SliderValue);

	PowaMisc.BTimerX = SliderValue;
	Powa_UpdateOptionsTimer()
end
-- -------------------------------------------------- timer 2
function Powa_UpdateOptionsTimer2()

	if (PowaEnabled == 0) then return; end   -- desactived

	Powa_Timer[3]:SetAlpha(PowaMisc.DTimerA);
	Powa_Timer[3]:SetWidth(20 * PowaMisc.DTimerScale);
	Powa_Timer[3]:SetHeight(20 * PowaMisc.DTimerScale);
	Powa_Timer[3]:SetPoint("Center", PowaMisc.DTimerX, PowaMisc.DTimerY);

	Powa_Timer[4]:SetAlpha(PowaMisc.DTimerA);
	Powa_Timer[4]:SetWidth(14 * PowaMisc.DTimerScale);
	Powa_Timer[4]:SetHeight(14 * PowaMisc.DTimerScale);
	Powa_Timer[4]:SetPoint("LEFT", Powa_Timer[3], "RIGHT", 1, -1.5);
	Powa_Timer[4]:SetAlpha(PowaMisc.DTimerA * 0.75);
end

function PowaTimer2AlphaSliderChanged()
	local SliderValue = getglobal("PowaTimer2AlphaSlider"):GetValue();

	getglobal("PowaTimer2AlphaSliderText"):SetText(PowaText.nomAlpha.." : "..format("%.2f", SliderValue) );

	PowaMisc.DTimerA = SliderValue;
	Powa_UpdateOptionsTimer2()
end

function PowaTimer2SizeSliderChanged()
	local SliderValue = getglobal("PowaTimer2SizeSlider"):GetValue();

	getglobal("PowaTimer2SizeSliderText"):SetText(PowaText.nomTaille.." : "..format("%.2f", SliderValue) );

	PowaMisc.DTimerScale = SliderValue;
	Powa_UpdateOptionsTimer2()
end

function PowaTimer2CoordSliderChanged()
	local SliderValue = getglobal("PowaTimer2CoordSlider"):GetValue();

	getglobal("PowaTimer2CoordSliderText"):SetText(PowaText.nomPos.." Y : "..SliderValue);

	PowaMisc.DTimerY = SliderValue;
	Powa_UpdateOptionsTimer2()
end

function PowaTimer2CoordXSliderChanged()
	local SliderValue = getglobal("PowaTimer2CoordXSlider"):GetValue();

	getglobal("PowaTimer2CoordXSliderText"):SetText(PowaText.nomPos.." X : "..SliderValue);

	PowaMisc.DTimerX = SliderValue;
	Powa_UpdateOptionsTimer2()
end

function PowaBuffTimerCentsChecked()
	if (getglobal("PowaBuffTimerCentsButton"):GetChecked()) then
		PowaMisc.BCents = true;
	else
		PowaMisc.BCents = false;
	end
end

function PowaDebuffTimerCentsChecked()
	if (getglobal("PowaDebuffTimerCentsButton"):GetChecked()) then
		PowaMisc.DCents = true;
	else
		PowaMisc.DCents = false;
	end
end

function PowaDisableChecked()
	if (getglobal("PowaDisableButton"):GetChecked()) then
		PowaMisc.disabled = true;
	else
		PowaMisc.disabled = false;
	end
end