-- -------------------------------------------
--            << Power Auras >>
--              Par -Sinsthar-
--    [Ziya/Tiven - serveur Fr - Kirin Tor] 
--
--     Effets visuels autour du personnage 
--     en cas de buff ou de debuff.
-- -------------------------------------------

PowaVersion = "v2.01"

CurrentAura = 1;
CurrentSecondeAura = 0;
MaxAuras = 20;
SecondeAura = MaxAuras + 1;
CurrentTestAura = MaxAuras + 2;

PowaEnabled = 0;
PowaModTest = false; -- on test les effets

Powa_FramesVisibleTime = {}; -- visible ou pas

PowaMisc = {
		quickhide = false,
		disabled = false,
		BTimerX = 0,
		BTimerY = 0,
		BTimerA = 1.00,
		BTimerScale = 1.00,
		BCents = true,
		DTimerX = 0,
		DTimerY = 0,
		DTimerA = 1.00,
		DTimerScale = 1.00,
		DCents = true
	   };

PowaGlobal = {maxeffects = 20, maxtextures = 15}

PowaSet = {};
for i = 1, SecondeAura do
	PowaSet[i] = {
		texture = 1,
		anim1 = 1,
		anim2 = 0,
		speed = 1.00,
		begin = 0,
		duration = 0,
		alpha = 0.75,
		size = 0.75,
		torsion = 1,
		symetrie = 0,
		x = 0,
		y = -30,
		buffname = "",
		isdebuff = false,
		isdebufftype = false,
		timer = false,
		inverse = false,
		r = 1.0,
		g = 1.0,
		b = 1.0
	};
end

TabBuff = {};        -- liste des buffs en cours
TabDebuff = {};      -- debuffs
TabDebuffType = {};  -- debuff types

-- ---------------------------------------------------------------------------------------------

function Powa_OnLoad()

	-- Registering Events -- 
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("VARIABLES_LOADED");

	Powa_Frames = {};
	Powa_textures = {};

	-- options init
	SlashCmdList["POWA"] = Powa_SlashHandler;
	SLASH_POWA1 = "/powa";
end

-- ----------------------------------------------------------------------------------------------

function Powa_InitTabs()
	for i = 1, CurrentTestAura do
		if (PowaSet[i]) then -- gere les rajout de variables suivant les versions
			if (PowaSet[i].timer == nil) then PowaSet[i].timer = false; end
			if (PowaSet[i].inverse == nil) then PowaSet[i].inverse = false; end
			if (PowaSet[i].speed == nil) then PowaSet[i].speed = 1.0; end
			if (PowaSet[i].begin == nil) then PowaSet[i].begin = 0; end
			if (PowaSet[i].duration == nil) then PowaSet[i].duration = 0; end
		else    -- pas init
			PowaSet[i] = {
				texture = 1,
				anim1 = 1,
				anim2 = 0,
				speed = 1.00,
				begin = 0,
				duration = 0,
				alpha = 0.75,
				size = 0.75,
				torsion = 1,
				symetrie = 0,
				x = 0,
				y = -30,
				buffname = "",
				isdebuff = false,
				isdebufftype = false,
				timer = false,
				inverse = false,
				r = 1.0,
				g = 1.0,
				b = 1.0	}
			Powa_FramesVisibleTime[i] = 0;
		end		
	end
	if (PowaMisc) then
		if (PowaMisc.BTimerX == nil) then PowaMisc.BTimerX = 0; end
		if (PowaMisc.BTimerY == nil) then PowaMisc.BTimerY = 0; end
		if (PowaMisc.BTimerA == nil) then PowaMisc.BTimerA = 1.00; end
		if (PowaMisc.BTimerScale == nil) then PowaMisc.BTimerScale = 1.00; end
		if (PowaMisc.DTimerX == nil) then PowaMisc.DTimerX = 0; end
		if (PowaMisc.DTimerY == nil) then PowaMisc.DTimerY = 0; end
		if (PowaMisc.DTimerA == nil) then PowaMisc.DTimerA = 1.00; end
		if (PowaMisc.DTimerScale == nil) then PowaMisc.DTimerScale = 1.00; end
		if (PowaMisc.BCents == nil) then PowaMisc.BCents = true; end
		if (PowaMisc.DCents == nil) then PowaMisc.DCents = true; end
	else
		PowaMisc.quickhide = false;
		PowaMisc.disabled = false;
		PowaMisc.BTimerX = 0;
		PowaMisc.BTimerY = 0;
		PowaMisc.BTimerA = 1.00;
		PowaMisc.BTimerScale = 1.00;
		PowaMisc.DTimerX = 0;
		PowaMisc.DTimerY = 0;
		PowaMisc.DTimerA = 1.00;
		PowaMisc.DTimerScale = 1.00;
		PowaMisc.BCents = true;
		PowaMisc.DCents = true;
	end
end

-- -----------------------------------------------------------------------------------------------

function Powa_CreateFrames()

  for i = 1, CurrentTestAura do
    if (Powa_Frames[i]) then
    	-- deja cree, ne fait rien
    else
    	-- Frame -- 
    	Powa_Frames[i] = CreateFrame("Frame","Frame"..i);
    	Powa_Frames[i]:Hide();  

    	-- Texture --
    	Powa_textures[i] = Powa_Frames[i]:CreateTexture(nil,"BACKGROUND");
    	Powa_textures[i]:SetBlendMode("ADD");

    	Powa_textures[i]:SetAllPoints(Powa_Frames[i]); -- attache la texture a la frame
    	Powa_Frames[i].texture = Powa_textures[i];
 	Powa_Frames[i].baseL = 256;
	Powa_Frames[i].baseH = 256;

    	Powa_FramesVisibleTime[i] = 0;
    end
  end
  
end

Powa_Timer = {};
Powa_timertex = {};
Tstep = 0.09765625;

function Powa_CreateTimer()
    for i = 1, 4 do
	if (Powa_Timer[i]) then
	else
		Powa_Timer[i] = CreateFrame("Frame","Timer"..i);
		Powa_Timer[i]:Hide(); 

	    	Powa_timertex[i] = Powa_Timer[i]:CreateTexture(nil,"BACKGROUND");
    		Powa_timertex[i]:SetBlendMode("ADD");

	    	Powa_timertex[i]:SetAllPoints(Powa_Timer[i]); -- attache la texture a la frame
    		Powa_Timer[i].texture = Powa_timertex[i];

		Powa_timertex[i]:SetTexture("Interface\\Addons\\PowerAuras\\timers.tga");
	end
    end
    Powa_UpdateOptionsTimer();
    Powa_UpdateOptionsTimer2();
end

-- ------------------------------------------------------------------------------------ BUFF CHECKS

function Powa_MemorizeBuffs() -- cree un string contenant tous les noms des buffs en cours
	local buffIndex, untilCancelled;
	for i = 1, 24 do
		TabBuff[i] = "xXx";
		buffIndex, untilCancelled = GetPlayerBuff(i-1, "HELPFUL");
		if (buffIndex >= 0) then
			Powa_Tooltip:SetPlayerBuff(buffIndex);
			if (Powa_TooltipTextLeft1:IsShown()) then
				TabBuff[i] = string.upper(Powa_TooltipTextLeft1:GetText());
			else                                                    
				Powa_Tooltip:SetOwner(UIParent, "ANCHOR_NONE"); -- ERROR !! Ca ne doit jamais arriver ca
			end
		end
	end
	for i = 1, 16 do
		TabDebuff[i] = "xXx";
		TabDebuffType[i] = "xXx";
		buffIndex, untilCancelled = GetPlayerBuff(i-1, "HARMFUL");
		if (buffIndex >= 0) then
			Powa_Tooltip:SetPlayerBuff(buffIndex);
			if (Powa_TooltipTextLeft1:IsShown()) then
				TabDebuff[i] = string.upper(Powa_TooltipTextLeft1:GetText());
				if (Powa_TooltipTextRight1:IsShown()) then
					TabDebuffType[i] = string.upper(Powa_TooltipTextRight1:GetText());
				else
					TabDebuffType[i] = string.upper(PowaText.aucun);
				end
			else                                                    
				Powa_Tooltip:SetOwner(UIParent, "ANCHOR_NONE"); -- ERROR !! Ca ne doit jamais arriver ca
			end
		end
	end
end

function PowaCompareBuffDebuff(xnum)
	if (PowaMisc.disabled == true) then return false; end

	if (PowaSet[xnum].isdebuff) then -- un debuff
		for i = 1, 16 do
			Powa_Frames[xnum].buffindex = 0;
			for pword in string.gfind(PowaSet[xnum].buffname, "[%w%s%-%'\195\130-\195\190]+") do
				if (string.find(TabDebuff[i], string.upper(pword), 1, true)) then
					Powa_Frames[xnum].buffindex = i-1; -- point vers le debuff qui a le timer
					return true;
				end
			end
		end
	elseif (PowaSet[xnum].isdebufftype) then -- type de debuff (cherche a l'inverse)
		for i = 1, 16 do
			if (string.find(string.upper(PowaSet[xnum].buffname), TabDebuffType[i], 1, true)) then
				Powa_Frames[xnum].buffindex = i-1; -- point vers le debuff type qui a le timer
				return true; 
			end
		end
	else                                    -- un buff
		for i = 1, 24 do
			Powa_Frames[xnum].buffindex = 0;
			for pword in string.gfind(PowaSet[xnum].buffname, "[%w%s%-%'\195\130-\195\190]+") do
				if (string.find(TabBuff[i], string.upper(pword), 1, true)) then
					Powa_Frames[xnum].buffindex = i-1; -- point vers le buff qui a le timer
					return true;
				end
			end
		end
	end
	return false;
end

function Powa_NewCheckBuffs() -- compare chaque nom de buff d'activation avec l'ensemble des buffs memorises
     local LastAura;

     Powa_MemorizeBuffs();

     LastAura = 0;
     for j = 1, MaxAuras do
	if (PowaSet[j].buffname == "" or PowaSet[j].buffname == " ") then -- ne fait rien si vide
		PowaSet[j].buffname = "";
	elseif (PowaCompareBuffDebuff(j)) then -- buff actif
	    if (PowaSet[j].inverse == true) then
		if (Powa_Frames[j]:IsVisible() ) then
			Powa_FramesVisibleTime[j] = 0;
			if (j == CurrentSecondeAura) then
				Powa_FramesVisibleTime[SecondeAura] = 0;
				if (LastAura > 0) then -- cet effet n'est plus actif mais on affiche l'aura 2 sur le dernier effet
					CurrentSecondeAura = LastAura;
					Powa_DisplayAura(LastAura);
				end
			end
		end
	    else
		Powa_DisplayAura(j);
		LastAura = j;
	    end
	else -- -- perte d'aura, s'il est visible on le cache
	    if (PowaSet[j].inverse == false) then
		if (Powa_Frames[j]:IsVisible() ) then
			Powa_FramesVisibleTime[j] = 0;
			if (j == CurrentSecondeAura) then
				Powa_FramesVisibleTime[SecondeAura] = 0;
				if (LastAura > 0) then -- cet effet n'est plus actif mais on affiche l'aura 2 sur le dernier effet
					CurrentSecondeAura = LastAura;
					Powa_DisplayAura(LastAura);
				end
			end
		end
	    else
		Powa_DisplayAura(j);
		LastAura = j;
	    end
	end
     end -- end for

end

-- ----------------------------------------------------------------------------------------- EVENT

function Powa_OnEvent()  

   if event == "PLAYER_ENTERING_WORLD" then

	Powa_Tooltip:SetOwner(UIParent, "ANCHOR_NONE");

   elseif event == "VARIABLES_LOADED" then
	DEFAULT_CHAT_FRAME:AddMessage("|cffB0A0ff<Power Auras>|r |cffffff00"..PowaVersion.."|r - "..PowaText.welcome);
	-- defini le nombre max d'effets
	MaxAuras = PowaGlobal.maxeffects;
	SecondeAura = MaxAuras + 1;
	CurrentTestAura = MaxAuras + 2;
	-- verifie en cas de rajout d'effets que tous sont initialises (sinon ca bug :P)
	Powa_InitTabs();
	Powa_CreateFrames();
	-- defini le nombre max de textures
	if (PowaGlobal.maxtextures > 50) then PowaGlobal.maxtextures = 50; 
	elseif (PowaGlobal.maxtextures < 20) then PowaGlobal.maxtextures = 20; end
	getglobal("PowaBarAuraTextureSlider"):SetMinMaxValues(1,PowaGlobal.maxtextures);
	getglobal("PowaBarAuraTextureSliderHigh"):SetText(PowaGlobal.maxtextures);
	PowaEnabled = 1;
	Powa_CreateTimer();

   elseif event == "PLAYER_AURAS_CHANGED" then -- passe les buffs en revue
	if (PowaModTest == false) then
		Powa_NewCheckBuffs();
	end
   end
end

-- -----------------------------------------------------------------------------------------------

function Powa_DisplayAura(FNum)

    if (PowaEnabled == 0) then return; end   -- desactived

    if (Powa_FramesVisibleTime[FNum] == 0) then  -- si pas en cours

	Powa_textures[FNum]:SetTexture("Interface\\Addons\\PowerAuras\\aura"..PowaSet[FNum].texture..".tga");
	Powa_textures[FNum]:SetVertexColor(PowaSet[FNum].r,PowaSet[FNum].g,PowaSet[FNum].b);

	    if (PowaSet[FNum].symetrie == 1) then Powa_textures[FNum]:SetTexCoord(1, 0, 0, 1); -- inverse X
	elseif (PowaSet[FNum].symetrie == 2) then Powa_textures[FNum]:SetTexCoord(0, 1, 1, 0); -- inverse Y
	elseif (PowaSet[FNum].symetrie == 3) then Powa_textures[FNum]:SetTexCoord(1, 0, 1, 0); -- inverse XY
	else Powa_textures[FNum]:SetTexCoord(0, 1, 0, 1); end	

	if (PowaSet[FNum].begin > 0) then Powa_Frames[FNum].beginAnim = 1;
	else				  Powa_Frames[FNum].beginAnim = 0; end

	Powa_Frames[FNum].baseL = 256 * PowaSet[FNum].size * PowaSet[FNum].torsion;
	Powa_Frames[FNum].baseH = 256 * PowaSet[FNum].size * (2-PowaSet[FNum].torsion);
	Powa_Frames[FNum]:SetAlpha(PowaSet[FNum].alpha);
	Powa_Frames[FNum]:SetPoint("Center",PowaSet[FNum].x, PowaSet[FNum].y);
	Powa_Frames[FNum]:SetWidth(Powa_Frames[FNum].baseL);
	Powa_Frames[FNum]:SetHeight(Powa_Frames[FNum].baseH);
	Powa_Frames[FNum].statut = 0;
	Powa_Frames[FNum].duree = 0;
	Powa_Frames[FNum]:Show();

	Powa_FramesVisibleTime[FNum] = 1;        -- affiche anim1
	Powa_FramesVisibleTime[SecondeAura] = 0; -- init anim2
    end

    if (Powa_FramesVisibleTime[SecondeAura] == 0) then  -- si pas en cours (Anim 2)
	
	CurrentSecondeAura = FNum; -- 2eme aura en cours
	
	if (PowaSet[FNum].anim2 == 0) then -- pas d'anim
		Powa_Frames[SecondeAura]:Hide();
		return;
	end

	if (PowaSet[FNum].begin > 0) then Powa_Frames[FNum].beginAnim = 2;
	else				  Powa_Frames[FNum].beginAnim = 0; end

	PowaSet[SecondeAura].size = PowaSet[FNum].size;
	PowaSet[SecondeAura].torsion = PowaSet[FNum].torsion;
	PowaSet[SecondeAura].alpha = PowaSet[FNum].alpha * 0.5;
	PowaSet[SecondeAura].anim1 = PowaSet[FNum].anim2;
	PowaSet[SecondeAura].speed = PowaSet[FNum].speed;
	PowaSet[SecondeAura].duration = PowaSet[FNum].duration;
	PowaSet[SecondeAura].x = PowaSet[FNum].x;
	PowaSet[SecondeAura].y = PowaSet[FNum].y;

	Powa_textures[SecondeAura]:SetTexture("Interface\\Addons\\PowerAuras\\aura"..PowaSet[FNum].texture..".tga");
	Powa_textures[SecondeAura]:SetVertexColor(PowaSet[FNum].r,PowaSet[FNum].g,PowaSet[FNum].b);

	    if (PowaSet[FNum].symetrie == 1) then Powa_textures[SecondeAura]:SetTexCoord(1, 0, 0, 1); -- inverse X
	elseif (PowaSet[FNum].symetrie == 2) then Powa_textures[SecondeAura]:SetTexCoord(0, 1, 1, 0); -- inverse Y
	elseif (PowaSet[FNum].symetrie == 3) then Powa_textures[SecondeAura]:SetTexCoord(1, 0, 1, 0); -- inverse XY
	else Powa_textures[SecondeAura]:SetTexCoord(0, 1, 0, 1); end

	Powa_Frames[SecondeAura].baseL = Powa_Frames[FNum].baseL;
	Powa_Frames[SecondeAura].baseH = Powa_Frames[FNum].baseH;
	Powa_Frames[SecondeAura]:SetAlpha(PowaSet[SecondeAura].alpha);
	Powa_Frames[SecondeAura]:SetPoint("Center",PowaSet[FNum].x, PowaSet[FNum].y);
	Powa_Frames[SecondeAura]:SetWidth(Powa_Frames[SecondeAura].baseL);
	Powa_Frames[SecondeAura]:SetHeight(Powa_Frames[SecondeAura].baseH);
	Powa_Frames[SecondeAura].statut = 1;
	Powa_Frames[SecondeAura].duree = Powa_Frames[FNum].duree;
	Powa_Frames[SecondeAura]:Show();

	Powa_FramesVisibleTime[SecondeAura] = 1;
    end
end

-- -------------------------------------------------------------------------------------- TIMERS
PowaActiveTimer = 0;  -- le timer en cours
PowaActiveTimerValue = 0;
PowaActiveTimerSup = 0;  -- le 2eme timer en cours
PowaActiveTimerSupValue = 0;
PowaActiveTimer2 = 0;  -- le timer en cours (debuffs)
PowaActiveTimer2Value = 0;
PowaActiveTimer2Sup = 0;  -- le 2eme timer en cours
PowaActiveTimer2SupValue = 0;

function Powa_UpdateTimer(numi)
	local newvalue;
	
	if (numi > MaxAuras) then -- fin du cycle on arrete
		return;
	elseif (PowaSet[numi].timer == false) then -- cet effet n'affiche pas de timer
		return;
	end

	-- prend le timer
	if (getglobal("PowaBarConfigFrameOptions"):IsVisible()) then -- options des timers, affiche
		PowaActiveTimer2 = numi;
		PowaActiveTimer2Value = random(1,9) + (random(1, 99) / 100);
		PowaActiveTimer = numi;
		PowaActiveTimerValue = random(1,9) + (random(1, 99) / 100);

	elseif (PowaSet[numi].isdebuff or PowaSet[numi].isdebufftype) then
		if (PowaModTest) then
			newvalue = random(1,9) + (random(1, 99) / 100);
		else
			newvalue = GetPlayerBuffTimeLeft( GetPlayerBuff(Powa_Frames[numi].buffindex, "HARMFUL") );
		end
		
		if (newvalue > 0) then -- ok on a un timer a afficher...
			if ((PowaActiveTimer2Value > 0) and (newvalue > PowaActiveTimer2Value)) then
				-- y'a deja un timer dont le nombre est plus petit, domage
				return;
			end
			PowaActiveTimer2 = numi;          -- lien vers l'effet
			PowaActiveTimer2Value = newvalue; -- retiens la valeur
		end
	else
		if (PowaModTest) then
			newvalue = random(1,9) + (random(1, 99) / 100);
		else
			newvalue = GetPlayerBuffTimeLeft( GetPlayerBuff(Powa_Frames[numi].buffindex, "HELPFUL") );
		end

		if (newvalue > 0) then -- ok on a un timer a afficher...
			if ((PowaActiveTimerValue > 0) and (newvalue > PowaActiveTimerValue)) then
				-- y'a deja un timer dont le nombre est plus petit, domage
				return;
			end
			PowaActiveTimer = numi;          -- lien vers l'effet
			PowaActiveTimerValue = newvalue; -- retiens la valeur
		end
	end
end

function Powa_ResetTimers()
	local deci, uni, newvalue;

	if (PowaActiveTimer > 0) then -- timer a un lien
		if (Powa_Frames[PowaActiveTimer]:IsVisible()) then -- l'effet est visible, affiche
			-- timer 1, le gros (secondes)
			Powa_timertex[1]:SetVertexColor(PowaSet[PowaActiveTimer].r,PowaSet[PowaActiveTimer].g,PowaSet[PowaActiveTimer].b);
			-- si le timer est > 60, le transforme en minutes
			newvalue = PowaActiveTimerValue;
			if (newvalue > 60.00) then newvalue = newvalue / 60; end
			newvalue = math.min (99.00, newvalue);
			
			deci = math.floor(newvalue / 10);
			uni  = math.floor(newvalue - (deci*10));
			Powa_timertex[1]:SetTexCoord(Tstep * uni, Tstep * (uni+1), Tstep * deci, Tstep * (deci+1));
			Powa_Timer[1]:Show();
			-- timer 2, le petit (centieme de secondes)
			Powa_timertex[2]:SetVertexColor(PowaSet[PowaActiveTimer].r,PowaSet[PowaActiveTimer].g,PowaSet[PowaActiveTimer].b);

			newvalue = PowaActiveTimerValue;
			if (newvalue > 60.00) then 
				newvalue = math.mod(newvalue,60); 
			else
				newvalue = (newvalue - math.floor(newvalue)) * 100;
			end
			deci = math.floor(newvalue / 10);
			uni  = math.floor(newvalue - (deci*10));
			Powa_timertex[2]:SetTexCoord(Tstep * uni, Tstep * (uni+1), Tstep * deci, Tstep * (deci+1));
			if (PowaMisc.BCents == true) then
				Powa_Timer[2]:Show();
			else
				Powa_Timer[2]:Hide();
			end
		else
			Powa_Timer[1]:Hide(); -- cache les timer
			Powa_Timer[2]:Hide(); -- cache les timer
		end
	else
		Powa_Timer[1]:Hide();
		Powa_Timer[2]:Hide(); -- cache les timer
	end
	PowaActiveTimer = 0;
	PowaActiveTimerValue = 0;

	-- idem pour les debuffs
	if (PowaActiveTimer2 > 0) then -- timer a un lien
		if (Powa_Frames[PowaActiveTimer2]:IsVisible()) then -- l'effet est visible, affiche
			-- timer 1, le gros (secondes)
			Powa_timertex[3]:SetVertexColor(PowaSet[PowaActiveTimer2].r,PowaSet[PowaActiveTimer2].g,PowaSet[PowaActiveTimer2].b);
			-- si le timer est > 60, le transforme en minutes
			newvalue = PowaActiveTimer2Value;
			if (newvalue > 60.00) then newvalue = newvalue / 60; end
			newvalue = math.min (99.00, newvalue);
			
			deci = math.floor(newvalue / 10);
			uni  = math.floor(newvalue - (deci*10));
			Powa_timertex[3]:SetTexCoord(Tstep * uni, Tstep * (uni+1), Tstep * deci, Tstep * (deci+1));
			Powa_Timer[3]:Show();
			-- timer 2, le petit (centieme de secondes)
			Powa_timertex[4]:SetVertexColor(PowaSet[PowaActiveTimer2].r,PowaSet[PowaActiveTimer2].g,PowaSet[PowaActiveTimer2].b);

			newvalue = PowaActiveTimer2Value;
			if (newvalue > 60.00) then 
				newvalue = math.mod(newvalue,60); 
			else
				newvalue = (newvalue - math.floor(newvalue)) * 100;
			end
			deci = math.floor(newvalue / 10);
			uni  = math.floor(newvalue - (deci*10));
			Powa_timertex[4]:SetTexCoord(Tstep * uni, Tstep * (uni+1), Tstep * deci, Tstep * (deci+1));
			if (PowaMisc.DCents == true) then
				Powa_Timer[4]:Show();
			else
				Powa_Timer[4]:Hide();
			end
		else
			Powa_Timer[3]:Hide(); -- cache les timer
			Powa_Timer[4]:Hide(); -- cache les timer
		end
	else
		Powa_Timer[3]:Hide();
		Powa_Timer[4]:Hide(); -- cache les timer
	end
	PowaActiveTimer2 = 0;
	PowaActiveTimer2Value = 0;
end

-- -------------------------------------------------------------------------------------- ON UPDATE
minScale = {a=0, w=0, h=0};
maxScale = {a=0, w=0, h=0};
curScale = {a=0, w=0, h=0};
speedScale = 0;

function Powa_OnUpdate(elapsed)

    for i = 1, CurrentTestAura do
    
    	if (PowaEnabled == 0) then return; end   -- desactived

	if (Powa_FramesVisibleTime[i] > 0) then -- si visible seulement

		Powa_UpdateTimer(i); -- met a jour les Timers

		curScale.w = Powa_Frames[i].baseL; -- regle la taille de l'image en pixel
		curScale.h = Powa_Frames[i].baseH;

		-- pas d'anim si l'effet va disparaitre avec duree
		if ((PowaSet[i].duration > 0) and (Powa_Frames[i].duree > PowaSet[i].duration)) then
			-- si visible, baisse l'alpha
			if (Powa_Frames[i]:GetAlpha() > 0) then
				curScale.a = Powa_Frames[i]:GetAlpha() - (elapsed / 2);
				-- si alpha 0, cache
				if (curScale.a <= 0) then
					Powa_Frames[i]:SetAlpha(0);
				else
					Powa_Frames[i]:SetAlpha(curScale.a);
				end
			end
		-- Animation 1 : aucune
		elseif (PowaSet[i].anim1 == 1) then

		-- Animation 2 : max alpha <-> mi-alpha
		elseif (PowaSet[i].anim1 == 2) then
			minScale.a = PowaSet[i].alpha * 0.5 * PowaSet[i].speed;
			maxScale.a = PowaSet[i].alpha;

			if (Powa_Frames[i].statut == 0) then
				curScale.a = Powa_Frames[i]:GetAlpha() - (elapsed / 2);
				Powa_Frames[i]:SetAlpha( curScale.a )
				if (Powa_Frames[i]:GetAlpha() < minScale.a) then
					Powa_Frames[i]:SetAlpha(minScale.a);
					Powa_Frames[i].statut = 1;
				end
			else
				curScale.a = Powa_Frames[i]:GetAlpha() + (elapsed / 2);
				if (curScale.a > 1.0) then curScale.a = 1.0; end -- pas trop haut non plus
				Powa_Frames[i]:SetAlpha( curScale.a )
				if (Powa_Frames[i]:GetAlpha() >= maxScale.a) then 
					Powa_Frames[i]:SetAlpha(maxScale.a);
					Powa_Frames[i].statut = 0;
				end
			end
		-- Animation 3 : mini-zoom in repetitif + fading
		elseif (PowaSet[i].anim1 == 3) then
			minScale.w = curScale.w * 0.90;
			minScale.h = curScale.h * 0.90;
			maxScale.w = curScale.w * 1.20;
			maxScale.h = curScale.h * 1.20;
			speedScale = (25 * PowaSet[i].speed) * PowaSet[i].size;

			if (Powa_Frames[i].statut == 1) then  -- decale anim 2
				Powa_Frames[i]:SetWidth(curScale.w * 1.15);
				Powa_Frames[i]:SetHeight(curScale.h * 1.15);
				Powa_Frames[i].statut = 0;
			end

			Powa_Frames[i]:SetWidth( Powa_Frames[i]:GetWidth() + (elapsed * speedScale) )
			Powa_Frames[i]:SetHeight( Powa_Frames[i]:GetHeight() + (elapsed * speedScale) )

			Powa_Frames[i]:SetAlpha( ((maxScale.w - Powa_Frames[i]:GetWidth()) / (maxScale.w - minScale.w)) * PowaSet[i].alpha );

			if (Powa_Frames[i]:GetWidth() > maxScale.w) then
				Powa_Frames[i]:SetWidth(minScale.w);
				Powa_Frames[i]:SetHeight(minScale.h);
			end
		-- Animation 4 : mini-zoom in/out
		elseif (PowaSet[i].anim1 == 4) then
			minScale.w = curScale.w * 0.95;
			minScale.h = curScale.h * 0.95;
			maxScale.w = curScale.w * 1.05;
			maxScale.h = curScale.h * 1.05;
			speedScale = (50 * PowaSet[i].speed) * PowaSet[i].size;

			if (Powa_Frames[i].statut == 0) then
				Powa_Frames[i]:SetWidth( Powa_Frames[i]:GetWidth() + (elapsed * speedScale * PowaSet[i].torsion) )
				Powa_Frames[i]:SetHeight( Powa_Frames[i]:GetHeight() + (elapsed * speedScale * (2-PowaSet[i].torsion) ) )				
				if (Powa_Frames[i]:GetWidth() > maxScale.w) then	
					Powa_Frames[i]:SetWidth(maxScale.w);
					Powa_Frames[i]:SetHeight(maxScale.h);
					Powa_Frames[i].statut = 1;
				end
			else
				Powa_Frames[i]:SetWidth( Powa_Frames[i]:GetWidth() - (elapsed * speedScale * PowaSet[i].torsion) )
				Powa_Frames[i]:SetHeight( Powa_Frames[i]:GetHeight() - (elapsed * speedScale * (2-PowaSet[i].torsion) ) )				
				if (Powa_Frames[i]:GetWidth() < minScale.w) then 
					Powa_Frames[i]:SetWidth(minScale.w);
					Powa_Frames[i]:SetHeight(minScale.h);
					Powa_Frames[i].statut = 0;
				end
			end
		-- Animation 5 : effet bulle
		elseif (PowaSet[i].anim1 == 5) then
			minScale.w = curScale.w * 0.95;
			minScale.h = curScale.h * 0.95;
			maxScale.w = curScale.w * 1.05;
			maxScale.h = curScale.h * 1.05;
			speedScale = (50 * PowaSet[i].speed) * PowaSet[i].size;

			if (Powa_Frames[i].statut == 0) then	
				Powa_Frames[i]:SetWidth( Powa_Frames[i]:GetWidth() + (elapsed * speedScale * PowaSet[i].torsion) )
				Powa_Frames[i]:SetHeight( Powa_Frames[i]:GetHeight() - (elapsed * speedScale * (2-PowaSet[i].torsion) ) )
				if (Powa_Frames[i]:GetWidth() > maxScale.w) then
					Powa_Frames[i]:SetWidth(maxScale.w);
					Powa_Frames[i]:SetHeight(minScale.h);
					Powa_Frames[i].statut = 1;
				end
			else
				Powa_Frames[i]:SetWidth( Powa_Frames[i]:GetWidth() - (elapsed * speedScale * PowaSet[i].torsion) )
				Powa_Frames[i]:SetHeight( Powa_Frames[i]:GetHeight() + (elapsed * speedScale * (2-PowaSet[i].torsion) ) )
				if (Powa_Frames[i]:GetHeight() > maxScale.h) then 
					Powa_Frames[i]:SetWidth(minScale.w);
					Powa_Frames[i]:SetHeight(maxScale.h);
					Powa_Frames[i].statut = 0;
				end
			end
		-- position au hasard + zoom in + fade
		elseif (PowaSet[i].anim1 == 6) then
			if (Powa_Frames[i]:GetAlpha() > 0) then
				curScale.a = Powa_Frames[i]:GetAlpha() - (elapsed * PowaSet[i].alpha * 0.5);
				if (curScale.a < 0) then Powa_Frames[i]:SetAlpha(0.0);
				else Powa_Frames[i]:SetAlpha(curScale.a); end
				maxScale.w = Powa_Frames[i]:GetWidth() + (elapsed * 100 * PowaSet[i].speed * PowaSet[i].size);
				maxScale.h = Powa_Frames[i]:GetHeight() + (elapsed * 100 * PowaSet[i].speed * PowaSet[i].size);
				if ( (maxScale.w * 1.5) > Powa_Frames[i]:GetWidth()) then -- evite les lags
					Powa_Frames[i]:SetWidth(maxScale.w)
					Powa_Frames[i]:SetHeight(maxScale.h)
				end
			else
				maxScale.w = random(0,10) - 5;
				maxScale.h = random(0,10) - 5;
				Powa_Frames[i]:SetAlpha(PowaSet[i].alpha);
				Powa_Frames[i]:SetWidth(curScale.w * 0.85);
				Powa_Frames[i]:SetHeight(curScale.h * 0.85);
				Powa_Frames[i]:SetPoint("Center",PowaSet[i].x + maxScale.w, PowaSet[i].y + maxScale.h);
			end
		-- static sauf parfois ou la texture est decalee + opaque (type electrique)
		elseif (PowaSet[i].anim1 == 7) then
			if (Powa_Frames[i].statut < 2) then
				Powa_Frames[i]:SetAlpha(PowaSet[i].alpha / 2); -- mi-alpha
				if (random( 210-(PowaSet[i].speed*100) ) == 1) then
					Powa_Frames[i].statut = 2;
					maxScale.w = random(0,10) - 5;
					maxScale.h = random(0,10) - 5;
					Powa_Frames[i]:SetPoint("Center",PowaSet[i].x + maxScale.w, PowaSet[i].y + maxScale.h);
					Powa_Frames[i]:SetAlpha(PowaSet[i].alpha);
				end
			else
				Powa_Frames[i]:SetPoint("Center",PowaSet[i].x, PowaSet[i].y);
				Powa_Frames[i].statut = 0;
			end
		-- zoom out + stop + fade
		elseif (PowaSet[i].anim1 == 8) then
			minScale.w = curScale.w;
			minScale.h = curScale.h;
			maxScale.w = curScale.w * 1.30;
			maxScale.h = curScale.h * 1.30;
			speedScale = (50 * PowaSet[i].speed) * PowaSet[i].size;
			
			if (Powa_Frames[i].statut == 0) then -- demarre le zoom out (max size)
				Powa_Frames[i]:SetWidth(maxScale.w);
				Powa_Frames[i]:SetHeight(maxScale.h);
				Powa_Frames[i]:SetAlpha(0.0);
				Powa_Frames[i].statut = 2;
			elseif (Powa_Frames[i].statut == 2) then -- zoom out + fade in
				Powa_Frames[i]:SetWidth( Powa_Frames[i]:GetWidth() - (elapsed * speedScale * PowaSet[i].torsion) )
				Powa_Frames[i]:SetHeight( Powa_Frames[i]:GetHeight() - (elapsed * speedScale * (2-PowaSet[i].torsion) ) )

				Powa_Frames[i]:SetAlpha( ((maxScale.w - Powa_Frames[i]:GetWidth()) / (maxScale.w - minScale.w)) * PowaSet[i].alpha );

				if (Powa_Frames[i]:GetWidth() < curScale.w) then
					Powa_Frames[i]:SetWidth(curScale.w);
					Powa_Frames[i]:SetHeight(curScale.h);	
					Powa_Frames[i].statut = 1;
				end
			elseif (Powa_Frames[i].statut == 1) then -- demarre le fade-out
				Powa_Frames[i]:SetWidth(curScale.w);
				Powa_Frames[i]:SetHeight(curScale.h);
				Powa_Frames[i]:SetAlpha(PowaSet[i].alpha);
				Powa_Frames[i].statut = 3;

			elseif (Powa_Frames[i].statut == 3) then -- fade-out
				curScale.a = Powa_Frames[i]:GetAlpha() - (elapsed / random(1,2));

				if (curScale.a < 0.0) then
					Powa_Frames[i]:SetAlpha(0.0);
					Powa_Frames[i].statut = 0;
				else
					Powa_Frames[i]:SetAlpha(curScale.a);
				end
			end

		-- deplacement vers le haut + fade-out + reduction
		elseif (PowaSet[i].anim1 == 9) then
			speedScale = (50 * PowaSet[i].speed) * PowaSet[i].size;
			
			if (Powa_Frames[i].statut < 2) then -- debut
				Powa_Frames[i]:SetWidth(curScale.w);
				Powa_Frames[i]:SetHeight(curScale.h);
				Powa_Frames[i]:SetPoint("Center",PowaSet[i].x, PowaSet[i].y);
				Powa_Frames[i]:SetAlpha(PowaSet[i].alpha);
				Powa_Frames[i].statut = 2;
			else
				_,_,_,xOfs,yOfs = Powa_Frames[i]:GetPoint();
				Powa_Frames[i]:SetPoint("Center",xOfs + (random(1,3)-2), yOfs + (elapsed * random(10,20)));
				curScale.a = Powa_Frames[i]:GetAlpha() - ( (elapsed / random(2,4)) * PowaSet[i].alpha);

				Powa_Frames[i]:SetWidth( Powa_Frames[i]:GetWidth() - (elapsed * speedScale * PowaSet[i].torsion) )
				Powa_Frames[i]:SetHeight( Powa_Frames[i]:GetHeight() - (elapsed * speedScale * (2-PowaSet[i].torsion) ) )

				if (curScale.a < 0.0) then
					Powa_Frames[i]:SetAlpha(0.0);
					Powa_Frames[i].statut = 1;
				else
					Powa_Frames[i]:SetAlpha(curScale.a);
				end
			end

		end

		-- si duration
		if (PowaSet[i].duration > 0) then
			-- ajoute le temps passe
			Powa_Frames[i].duree = Powa_Frames[i].duree + elapsed;
		end

	-- FADE OUT
	elseif Powa_Frames[i]:IsVisible() then

	    if (PowaMisc.quickhide == false) then
		curScale.a = Powa_Frames[i]:GetAlpha() - (elapsed * 2);

		if (curScale.a <= 0) then
			Powa_Frames[i]:Hide();
		else
			Powa_Frames[i]:SetAlpha(curScale.a);
			Powa_Frames[i]:SetWidth(Powa_Frames[i]:GetWidth() + (elapsed * 200) );
			Powa_Frames[i]:SetHeight(Powa_Frames[i]:GetHeight() + (elapsed * 200) );
		end
	    else
		Powa_Frames[i]:Hide();
	    end
	end

     end

     Powa_ResetTimers(); -- reset Timers

end

-- ----------------------------------------------------------------------------- LIGNE DE COMMANDE

function Powa_SlashHandler(msg)
	msgNumber = 0;
	if (msg == "") then
		-- aucun parametre, on ouvre/ferme les options
		if (PowaBarConfigFrame:IsVisible()) then
			Powa_OptionClose();
		else
			Powa_OptionHideAll();
			Powa_InitPage();
			PowaModTest = true;
			PowaBarConfigFrame:Show();
		end
	else    -- y'a des parametres, on y travaille
		for a in string.gfind( msg, "maxtex (%d+)" ) do
			msgNumber = tonumber(a);
			if (msgNumber > 50) then msgNumber = 50; elseif (msgNumber < 20) then msgNumber = 2; end
			PowaGlobal.maxtextures = msgNumber;
			getglobal("PowaBarAuraTextureSlider"):SetMinMaxValues(1,msgNumber);
			getglobal("PowaBarAuraTextureSliderHigh"):SetText(msgNumber);
			DEFAULT_CHAT_FRAME:AddMessage("|cffB0A0ff<Power Auras>|r "..PowaText.aideCommande2a.." "..a);
			return;
		end
		for a in string.gfind( msg, "maxeffect (%d+)" ) do
			msgNumber = tonumber(a);
			if (msgNumber > 100) then msgNumber = 100; elseif (msgNumber < 10) then msgNumber = 10; end
			PowaEnabled = 0;          -- desactive temporairement les effets
			Powa_OptionHideAll();       -- cache tout les effets en cours
			MaxAuras = msgNumber;         -- definie le max d'aura
			SecondeAura = MaxAuras + 1;     -- definie la derniere aura
			CurrentTestAura = MaxAuras + 2;  
			PowaGlobal.maxeffects = MaxAuras; -- sauve le nombre max d'effet
			Powa_InitTabs();                -- initialise les pages d'effets en plus
			Powa_CreateFrames();          -- cree les textures des effets en plus
			PowaEnabled = 1;            -- reactive les effets
			CurrentAura = 1;          -- defini l'effet en cours 1
			Powa_InitPage();        -- initalise les pages des options
			DEFAULT_CHAT_FRAME:AddMessage("|cffB0A0ff<Power Auras>|r "..PowaText.aideCommande3a.." "..a);
			return;
		end
		DEFAULT_CHAT_FRAME:AddMessage("|cffB0A0ff<Power Auras>|r "..PowaText.aideCommande1);
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff50  /powa maxtex ##|r : "..PowaText.aideCommande2);
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff50  /powa maxeffect ##|r : "..PowaText.aideCommande3);
	end
end

-- --------------------------------------------------------------------------- GESTION DES OPTIONS

function Powa_InitPage()
	getglobal("PowaBarAuraTextureSlider"):SetValue(PowaSet[CurrentAura].texture);
	getglobal("PowaBarAuraAlphaSlider"):SetValue(PowaSet[CurrentAura].alpha);
	getglobal("PowaBarAuraSizeSlider"):SetValue(PowaSet[CurrentAura].size);
	getglobal("PowaBarAuraCoordSlider"):SetValue(PowaSet[CurrentAura].y);
	getglobal("PowaBarAuraCoordXSlider"):SetValue(PowaSet[CurrentAura].x);
	getglobal("PowaBarAuraAnim2Slider"):SetValue(PowaSet[CurrentAura].anim2);
	getglobal("PowaBarAuraAnim1Slider"):SetValue(PowaSet[CurrentAura].anim1);
	getglobal("PowaBarAuraAnimSpeedSlider"):SetValue(PowaSet[CurrentAura].speed);
	getglobal("PowaBarAuraDurationSlider"):SetValue(PowaSet[CurrentAura].duration);
	getglobal("PowaBarAuraSymSlider"):SetValue(PowaSet[CurrentAura].symetrie);
	getglobal("PowaBarAuraDeformSlider"):SetValue(PowaSet[CurrentAura].torsion);
	getglobal("PowaBarBuffName"):SetText(PowaSet[CurrentAura].buffname);

	getglobal("AuraTexture"):SetTexture("Interface\\Addons\\PowerAuras\\Aura"..PowaSet[CurrentAura].texture..".tga");

	getglobal("PowaColorNormalTexture"):SetVertexColor(PowaSet[CurrentAura].r,PowaSet[CurrentAura].g,PowaSet[CurrentAura].b);
	getglobal("AuraTexture"):SetVertexColor(PowaSet[CurrentAura].r,PowaSet[CurrentAura].g,PowaSet[CurrentAura].b);

	getglobal("PowaColor_SwatchBg").r = PowaSet[CurrentAura].r;
	getglobal("PowaColor_SwatchBg").g = PowaSet[CurrentAura].g;
	getglobal("PowaColor_SwatchBg").b = PowaSet[CurrentAura].b;

	getglobal("PowaHeader"):SetText("POWER AURAS "..PowaVersion);
	getglobal("powa_Text"):SetText(PowaText.nomTitre.." "..CurrentAura.."/"..MaxAuras);
	getglobal("PowaHideAllButton"):SetText(PowaText.nomHide);
	getglobal("PowaTestButton"):SetText(PowaText.nomTest);
	getglobal("PowaCloseButton"):SetText(PowaText.nomClose);
	getglobal("PowaListButton"):SetText(PowaText.nomListe);

	if (PowaSet[CurrentAura].isdebuff) then 
		getglobal("PowaDebuffButton"):SetChecked(true);
		getglobal("PowaDebuffTypeButton"):SetChecked(false);
		getglobal("PowaBarBuffNameText"):SetText(PowaText.nomDebuff);
		getglobal("PowaBarBuffName").aide = PowaText.aideBuff2;
		
	elseif (PowaSet[CurrentAura].isdebufftype) then 
		getglobal("PowaDebuffTypeButton"):SetChecked(true);
		getglobal("PowaDebuffButton"):SetChecked(false);
		getglobal("PowaBarBuffNameText"):SetText(PowaText.nomDebuffType);
		getglobal("PowaBarBuffName").aide = PowaText.aideBuff3;
	else
		getglobal("PowaDebuffButton"):SetChecked(false);
		getglobal("PowaDebuffTypeButton"):SetChecked(false);
		getglobal("PowaBarBuffNameText"):SetText(PowaText.nomBuff);
		getglobal("PowaBarBuffName").aide = PowaText.aideBuff;
	end

	getglobal("PowaShowTimerButton"):SetChecked(PowaSet[CurrentAura].timer);
	getglobal("PowaInverseButton"):SetChecked(PowaSet[CurrentAura].inverse);
	if (PowaSet[CurrentAura].inverse) then
		PowaSet[CurrentAura].timer = false;
		getglobal("PowaShowTimerButton"):SetChecked(PowaSet[CurrentAura].timer);
		Powa_DisableCheckBox("PowaShowTimerButton");
	else
		Powa_EnableCheckBox("PowaShowTimerButton");
	end
end

function Powa_ChangePagePrev() -- page precedente
	if (CurrentAura == 1) then 
		CurrentAura = MaxAuras;
	else
		CurrentAura = CurrentAura - 1;
	end
	Powa_InitPage();
end

function Powa_ChangePageNext() -- page suivante
	if (CurrentAura == MaxAuras) then 
		CurrentAura = 1;
	else
		CurrentAura = CurrentAura + 1;
	end
	Powa_InitPage();
end

function Powa_UpdateAura() -- met a jour l'effet apres modification d'options

	if (PowaEnabled == 0) then return; end   -- desactived

	Powa_FramesVisibleTime[CurrentAura] = 0;
	Powa_FramesVisibleTime[SecondeAura] = 0;

	if (Powa_Frames[CurrentAura]:IsVisible()) then -- sinon on affiche seulement si deja visible
		Powa_DisplayAura(CurrentAura);
	end
end

function Powa_OptionClose() -- ferme la fenetre d'option
	PowaModTest = false;
	getglobal("PowaBarConfigFrame"):Hide();
	getglobal("PowaListFrame"):Hide();
	-- cache tous les effets en test
	for i = 1, MaxAuras+2 do
		if (PowaSet[i].duration > 0) then
			Powa_Frames[i].duree = 31; -- force affiche et mode transparent
			Powa_Frames[i]:Show();
			Powa_Frames[i]:SetAlpha(0.0);
			Powa_FramesVisibleTime[i] = 1;
		else
			Powa_FramesVisibleTime[i] = 0;
		end
	end
	Powa_NewCheckBuffs(); -- detect les effets en cours
end

function Powa_OptionTest() -- teste ou masque l'effet choisi
	if (Powa_Frames[CurrentAura]:IsVisible()) then -- deja visible, on la cache
		Powa_FramesVisibleTime[CurrentAura] = 0;
		Powa_FramesVisibleTime[SecondeAura] = 0;
	else                                           -- pas visible alors on affiche
		Powa_DisplayAura(CurrentAura);
	end
end

function Powa_OptionHideAll() -- cache tous les effets
	-- cache tous les effets en test
	for i = 1, MaxAuras+2 do
		Powa_FramesVisibleTime[i] = 0;
	end
end

-- ---------------------------------------------------------------------------------- FENETRE D'OPTION

function PowaBarAuraTextureSliderChanged()
	local SliderValue = getglobal("PowaBarAuraTextureSlider"):GetValue();

	getglobal("PowaBarAuraTextureSliderText"):SetText(PowaText.nomTexture.." : "..SliderValue);
	getglobal("AuraTexture"):SetTexture("Interface\\Addons\\PowerAuras\\Aura"..SliderValue..".tga");

	PowaSet[CurrentAura].texture = SliderValue;
	Powa_UpdateAura();
end

function PowaBarAuraAlphaSliderChanged()
	local SliderValue = getglobal("PowaBarAuraAlphaSlider"):GetValue();

	getglobal("PowaBarAuraAlphaSliderText"):SetText(PowaText.nomAlpha.." : "..format("%.2f", SliderValue) );

	PowaSet[CurrentAura].alpha = SliderValue;
	Powa_UpdateAura();
end

function PowaBarAuraSizeSliderChanged()
	local SliderValue = getglobal("PowaBarAuraSizeSlider"):GetValue();

	getglobal("PowaBarAuraSizeSliderText"):SetText(PowaText.nomTaille.." : "..format("%.2f", SliderValue) );

	PowaSet[CurrentAura].size = SliderValue;
	Powa_UpdateAura();
end

function PowaBarAuraCoordSliderChanged()
	local SliderValue = getglobal("PowaBarAuraCoordSlider"):GetValue();

	getglobal("PowaBarAuraCoordSliderText"):SetText(PowaText.nomPos.." Y : "..SliderValue);

	PowaSet[CurrentAura].y = SliderValue;
	Powa_UpdateAura();
end

function PowaBarAuraCoordXSliderChanged()
	local SliderValue = getglobal("PowaBarAuraCoordXSlider"):GetValue();

	getglobal("PowaBarAuraCoordXSliderText"):SetText(PowaText.nomPos.." X : "..SliderValue);

	PowaSet[CurrentAura].x = SliderValue;
	Powa_UpdateAura();
end

function PowaBarAuraAnim2SliderChanged()
	local SliderValue = getglobal("PowaBarAuraAnim2Slider"):GetValue();

	getglobal("PowaBarAuraAnim2SliderText"):SetText(PowaText.nomAnim2.." : "..SliderValue);

	PowaSet[CurrentAura].anim2 = SliderValue;
	Powa_UpdateAura();
end

function PowaBarAuraAnim1SliderChanged()
	local SliderValue = getglobal("PowaBarAuraAnim1Slider"):GetValue();

	getglobal("PowaBarAuraAnim1SliderText"):SetText(PowaText.nomAnim1.." : "..SliderValue);

	PowaSet[CurrentAura].anim1 = SliderValue;
	Powa_UpdateAura();
end

function PowaBarAuraAnimSpeedSliderChanged()
	local SliderValue = getglobal("PowaBarAuraAnimSpeedSlider"):GetValue();

	getglobal("PowaBarAuraAnimSpeedSliderText"):SetText(PowaText.nomSpeed.." : "..format("%.0f",SliderValue*100).."%");

	PowaSet[CurrentAura].speed = SliderValue;
	Powa_UpdateAura();
end

function PowaBarAuraAnimDurationSliderChanged()
	local SliderValue = getglobal("PowaBarAuraDurationSlider"):GetValue();

	getglobal("PowaBarAuraDurationSliderText"):SetText(PowaText.nomDuration.." : "..SliderValue.." sec");

	PowaSet[CurrentAura].duration = SliderValue;
	Powa_UpdateAura();
end

function PowaBarAuraSymSliderChanged()
	local SliderValue = getglobal("PowaBarAuraSymSlider"):GetValue();

	if (SliderValue == 0) then
		getglobal("PowaBarAuraSymSliderText"):SetText(PowaText.nomSymetrie.." : "..PowaText.aucune);
	elseif (SliderValue == 1) then
		getglobal("PowaBarAuraSymSliderText"):SetText(PowaText.nomSymetrie.." : X");
	elseif (SliderValue == 2) then
		getglobal("PowaBarAuraSymSliderText"):SetText(PowaText.nomSymetrie.." : Y");
	elseif (SliderValue == 3) then
		getglobal("PowaBarAuraSymSliderText"):SetText(PowaText.nomSymetrie.." : XY");
	end

	PowaSet[CurrentAura].symetrie = SliderValue;
	Powa_UpdateAura();
end

function PowaBarAuraDeformSliderChanged()
	local SliderValue = getglobal("PowaBarAuraDeformSlider"):GetValue();

	getglobal("PowaBarAuraDeformSliderText"):SetText(PowaText.nomDeform.." : "..format("%.2f", SliderValue));

	PowaSet[CurrentAura].torsion = SliderValue;
	Powa_UpdateAura();
end

function PowaMaxTexSliderChanged()
	local SliderValue = getglobal("PowaMaxTexSlider"):GetValue();

	getglobal("PowaMaxTexSliderText"):SetText(PowaText.nomMaxTex.." : "..SliderValue);

	getglobal("PowaBarAuraTextureSlider"):SetMinMaxValues(1,SliderValue);
	getglobal("PowaBarAuraTextureSliderHigh"):SetText(SliderValue);

	PowaGlobal.maxtextures = SliderValue;
end

function PowaTextChanged()
	PowaSet[CurrentAura].buffname = getglobal("PowaBarBuffName"):GetText();
end

function PowaDebuffChecked()
	if (getglobal("PowaDebuffButton"):GetChecked()) then
		PowaSet[CurrentAura].isdebuff = true;
		PowaSet[CurrentAura].isdebufftype = false;
		getglobal("PowaDebuffTypeButton"):SetChecked(false);		
		getglobal("PowaBarBuffNameText"):SetText(PowaText.nomDebuff);
		getglobal("PowaBarBuffName").aide = PowaText.aideBuff2;
	else
		PowaSet[CurrentAura].isdebuff = false;
		getglobal("PowaBarBuffNameText"):SetText(PowaText.nomBuff);
		getglobal("PowaBarBuffName").aide = PowaText.aideBuff;
	end
	Powa_UpdateList();
end

function PowaDebuffTypeChecked()
	if (getglobal("PowaDebuffTypeButton"):GetChecked()) then
		PowaSet[CurrentAura].isdebufftype = true;
		PowaSet[CurrentAura].isdebuff = false;
		getglobal("PowaDebuffButton"):SetChecked(false);
		getglobal("PowaBarBuffNameText"):SetText(PowaText.nomDebuffType);
		getglobal("PowaBarBuffName").aide = PowaText.aideBuff3;
	else
		PowaSet[CurrentAura].isdebufftype = false;
		getglobal("PowaBarBuffNameText"):SetText(PowaText.nomBuff);
		getglobal("PowaBarBuffName").aide = PowaText.aideBuff;
	end
	Powa_UpdateList();
end

function PowaQuickHideChecked()
	if (getglobal("PowaQuickHideButton"):GetChecked()) then
		PowaMisc.quickhide = true;
	else
		PowaMisc.quickhide = false;
	end
end

function PowaShowTimerChecked()
	if (getglobal("PowaShowTimerButton"):GetChecked()) then
		PowaSet[CurrentAura].timer = true;
	else
		PowaSet[CurrentAura].timer = false;
	end
end

function PowaInverseChecked()
	if (getglobal("PowaInverseButton"):GetChecked()) then
		PowaSet[CurrentAura].inverse = true;
		PowaSet[CurrentAura].timer = false;
		getglobal("PowaShowTimerButton"):SetChecked(false);
		Powa_DisableCheckBox("PowaShowTimerButton");
	else
		PowaSet[CurrentAura].inverse = false;
		Powa_EnableCheckBox("PowaShowTimerButton");
	end
end

function Powa_DisableCheckBox(checkBox)
	getglobal(checkBox):Disable();
	getglobal(checkBox.."Text"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
end

function Powa_EnableCheckBox(checkBox, checked)
	getglobal(checkBox):Enable();
	getglobal(checkBox.."Text"):SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);	
end

-- ---------------------------------------------------------------------------- OPTIONS DEPLACEMENT

function PowaBar_MouseDown( strButton, frmFrame)
	if( strButton == "LeftButton") then
		getglobal( frmFrame ):StartMoving( );
	end
end

function PowaBar_MouseUp( strButton, frmFrame)
	getglobal( frmFrame ):StopMovingOrSizing( );
end

-- ----------------------------------------------------------------------------------- COLOR PICKER

function PowaOptionsFrame_SetColor()
	local r,g,b = ColorPickerFrame:GetColorRGB();
	local swatch,frame;
	swatch = getglobal("PowaColorNormalTexture"); -- juste le visuel
	frame = getglobal("PowaColor_SwatchBg");      -- enregistre la couleur
	swatch:SetVertexColor(r,g,b);
	frame.r = r;
	frame.g = g;
	frame.b = b;

	PowaSet[CurrentAura].r = r;
	PowaSet[CurrentAura].g = g;
	PowaSet[CurrentAura].b = b;

	getglobal("AuraTexture"):SetVertexColor(r,g,b);
	Powa_UpdateAura();
end

function PowaOptionsFrame_CancelColor()
	local r = ColorPickerFrame.previousValues.r;
	local g = ColorPickerFrame.previousValues.g;
	local b = ColorPickerFrame.previousValues.b;
	local swatch,frame;
	swatch = getglobal("PowaColorNormalTexture"); -- juste le visuel
	frame = getglobal("PowaColor_SwatchBg");      -- enregistre la couleur
	swatch:SetVertexColor(r,g,b);
	frame.r = r;
	frame.g = g;
	frame.b = b;

	getglobal("AuraTexture"):SetVertexColor(r,g,b);
end

function Powa_OpenColorPicker()
	CloseMenus();
	
	button = getglobal("PowaColor_SwatchBg");

	ColorPickerFrame.func = PowaOptionsFrame_SetColor -- button.swatchFunc;
	ColorPickerFrame:SetColorRGB(button.r, button.g, button.b);
	ColorPickerFrame.previousValues = {r = button.r, g = button.g, b = button.b, opacity = button.opacity};
	ColorPickerFrame.cancelFunc = PowaOptionsFrame_CancelColor

	ColorPickerFrame:SetPoint("TOPLEFT", "PowaBarConfigFrame", "TOPRIGHT", 0, 0)

	ColorPickerFrame:Show();
end