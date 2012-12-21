
local aquaformid, travelformid;

function DruidBar_OnLoad()
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	this:RegisterEvent("UNIT_MANA");
	this:RegisterEvent("UNIT_MAXMANA");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
	this:RegisterEvent("UPDATE_SHAPESHIFT_FORMS");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
	this:RegisterEvent("INSTANCE_BOOT_START");
	this:RegisterEvent("INSTANCE_BOOT_STOP");
	SlashCmdList["DRUIDBARSLASH"] = DruidBar_Enable_ChatCommandHandler;
	SLASH_DRUIDBARSLASH1 = "/dbar";
	SLASH_DRUIDBARSLASH2 = "/druidbar";
	DBarSpellCatch:SetOwner(DruidBarUpdateFrame, "ANCHOR_NONE");
end

local inform, lowregentimer, fullmanatimer, lastshift, inCombat, firstEZ, pre_UseAction, shiftload, isMoving, waitonce, firstshift;
lowregentimer = 0;
fullmanatimer = 0;
function DruidBar_OnEvent(event, arg1, arg2, arg3)
	if event == "PLAYER_ENTERING_WORLD" then
		--Thanks to Tigerheart from Argent Dawn for this little piece of work, as well as fireball and prudence for bringing it up!
		this:RegisterEvent("UNIT_MANA");
		this:RegisterEvent("UNIT_MAXMANA");
		this:RegisterEvent("PLAYER_REGEN_ENABLED");
		this:RegisterEvent("PLAYER_REGEN_DISABLED");
		this:RegisterEvent("UNIT_INVENTORY_CHANGED");
		this:RegisterEvent("PLAYER_AURAS_CHANGED");
		this:RegisterEvent("UPDATE_SHAPESHIFT_FORMS");
		return;
	elseif event == "PLAYER_LEAVING_WORLD" then
		this:UnregisterEvent("UNIT_MANA");
		this:UnregisterEvent("UNIT_MAXMANA");
		this:UnregisterEvent("PLAYER_REGEN_ENABLED");
		this:UnregisterEvent("PLAYER_REGEN_DISABLED");
		this:UnregisterEvent("UNIT_INVENTORY_CHANGED");
		this:UnregisterEvent("PLAYER_AURAS_CHANGED");
		this:RegisterEvent("UPDATE_SHAPESHIFT_FORMS");		
		return;
	end
	if event == "VARIABLES_LOADED" then
		if not DruidBarKey then DruidBarKey = {};
			DruidBarKey.keepthemana = 0;
			DruidBarKey.maxmana = 10;
			DruidBarKey.int = 0;
			DruidBarKey.subtractmana = 0;
			DruidBarKey.extra = 0;
			DruidBarKey.Enabled = true;
			DruidBarKey.EZShift = true;
			DruidBarKey.Graphics = true;
		end
		_, init = UnitClass("player");
		if UnitPowerType("player") ~= 0 then firstshift = true; end
		if not shiftload and init == "DRUID" then
			pre_ShapeshiftBar_ChangeForm = ShapeshiftBar_ChangeForm;
			ShapeshiftBar_ChangeForm = DruidBar_ChangeForm;
			shiftload = true;
		end
		DBarSpellCatch:SetOwner(DruidBarUpdateFrame, "ANCHOR_NONE");
	elseif init and init == "DRUID" and DruidBarKey.Enabled then
		if event == "UNIT_MAXMANA" and arg1 == "player" then
			DruidBar_MaxManaScript();
		elseif event == "UNIT_INVENTORY_CHANGED" and arg1 == "player" then
			DruidBar_MaxManaScript();
		elseif event == "UNIT_MANA" and arg1 == "player" then
			if UnitPowerType(arg1) == 0 then
				DruidBarKey.keepthemana = UnitMana(arg1);
			elseif DruidBarKey.keepthemana < DruidBarKey.maxmana then
				local add = DruidBar_ReflectionCheck();
				DruidBarKey.keepthemana = DruidBarKey.keepthemana + add + DruidBarKey.extra;
				if DruidBarKey.keepthemana > DruidBarKey.maxmana then DruidBarKey.keepthemana = DruidBarKey.maxmana; end
			end
			fullmanatimer = 0;
		elseif event == "PLAYER_AURAS_CHANGED" or event == "UPDATE_SHAPESHIFT_FORMS" then
			if UnitPowerType("player") == 1 and not inform then
				inform = true;
				--Bear
				DruidBar_Subtract();
			elseif UnitPowerType("player") == 3 and not inform then
				inform = true;
				--Cat
				DruidBar_Subtract();
			elseif UnitPowerType("player") == 0 and inform then
				inform = nil;
				DruidBarKey.keepthemana = UnitMana("player");
				if DruidBarKey.maxmana ~= UnitManaMax("player") then
					DruidBarKey.maxmana = UnitManaMax("player");
				end
				--player/aqua/travel
			end
		elseif (event == "SPELLCAST_STOP") then
			if (not firstEZ) then
				if (DruidBarKey.EZShift) then
					pre_UseAction = UseAction;
					UseAction = DruidBar_UseAction;
				end
				firstEZ = true;
			end
			if UnitPowerType("player") == 0 then lowregentimer = 5;
			waitonce = nil; end
		end
	elseif init and init == "DRUID" and not DruidBarKey.Enabled then
		if event == "UNIT_MAXMANA" and arg1 == "player" then
			DruidBar_MaxManaScript();
		end
	end
end

local notyet;
function DruidBar_OnUpdate(elapsed)
	if init and init == "DRUID" and DruidBarKey.Enabled then
		if not notyet then 
			DruidBar_MaxManaScript(); 
			for i = 1, GetNumShapeshiftForms() do
				local icon = GetShapeshiftFormInfo(i);
				if icon == "Interface\\Icons\\Ability_Druid_AquaticForm" then aquaformid = i; end
				if icon == "Interface\\Icons\\Ability_Druid_TravelForm" then travelformid = i; end
			end
			notyet = true; 
		end
		DruidBarMana:SetMinMaxValues(0, DruidBarKey.maxmana);
		DruidBarMana:SetValue(DruidBarKey.keepthemana);
		if lowregentimer > 0 then
			lowregentimer = lowregentimer - elapsed;
			if lowregentimer <= 0 then lowregentimer = 0; end
		end
		if UnitPowerType("player") ~= 0 then
			fullmanatimer = fullmanatimer + elapsed;
			if fullmanatimer > 6 and floor((DruidBarKey.keepthemana*100) / DruidBarKey.maxmana) > 90 then
				DruidBarKey.keepthemana = DruidBarKey.maxmana;
			end
		end
		if DruidBarKey.Graphics then
			if DruidBarKey.kmg then
				dbarhide(DruidBarFrame);
				dbarhide(DruidBarReplaceText);
				DruidBar_KMGraphics(); 
			else
				dbarhide(DruidBarKMG);
				if DruidBarKey.Replace then DruidBar_ReplaceGraphics(); else DruidBar_MainGraphics(); end
			end
		else
			dbarhide(DruidBarFrame);
			dbarhide(DruidBarReplaceText);
			dbarhide(DruidBarKMG);
			if PlayerFrameManaBar:GetWidth() < 100 then PlayerFrameManaBar:SetWidth(120); end
		end
	else
		dbarhide(DruidBarFrame);
		dbarhide(DruidBarKMG);
	end
end

function DruidBar_ReflectionCheck()
	local managain = 0;
	local j = 1;
	while (UnitBuff("player",j)) do
		DBarSpellCatch:SetUnitBuff("player", j);
		local msg = DBarSpellCatchTextLeft1:GetText();
		if msg and (strfind(msg,DRUIDBAR_INNERVATE)) then
			return ((ceil(UnitStat(arg1,5) / 5)+15) * 5);
		end
		j = j + 1;
	end
	if lowregentimer > 0 then 
		if waitonce then
			local name, iconTexture, tier, column, rank, maxRank, isExceptional, meetsPrereq = GetTalentInfo(3, 6);
			if rank == 0 then return 0; else
				managain = ((ceil(UnitStat("player",5) / 5)+15) * (0.05 * rank));
			end
		else
			waitonce = true;
		end
	elseif lowregentimer <= 0 then
		managain = (ceil(UnitStat("player",5) / 5)+15);
	end
	return managain;
end

--Gets the mana cost of your shapeshifting spells.
function DruidBar_GetShapeshiftCost()
	if not DBarSpellCatch:IsOwned(DruidBarUpdateFrame) then DBarSpellCatch:SetOwner(DruidBarUpdateFrame, "ANCHOR_NONE"); end
	DruidBarKey.subtractmana = 0;
	local a, b, c, d = GetSpellTabInfo(4);
	for i = 1, c+d, 1 do
		local spellname = GetSpellName(i, BOOKTYPE_SPELL);
		spellname = strlower(spellname);
		if spellname and (strfind(spellname, DRUIDBAR_CAT_FORM) or strfind(spellname, DRUIDBAR_BEAR_FORM)) then
			DBarSpellCatch:SetSpell(i, 1);
			local msg = DBarSpellCatchTextLeft2:GetText();
			if DruidBarKey.Debug then DEFAULT_CHAT_FRAME:AddMessage(msg); end
			local params;
			if msg then
				local index = strfind(msg, DRUIDBAR_MANA_DELIM);
				if index then
					if GetLocale() == "frFR" then params = strsub(msg, index+1); else params = strsub(msg, 1, index-1); end
					if DruidBarKey.Debug then DEFAULT_CHAT_FRAME:AddMessage(params); end
					DruidBarKey.subtractmana = tonumber(params);
					if DruidBarKey.subtractmana and DruidBarKey.subtractmana > 0 then return; end
				end
			end
		end
	end
end

function DruidBar_Subtract()
	if not firstshift then
		local j = 1;
		while (UnitBuff("player",j)) do
			DBarSpellCatch:SetUnitBuff("player", j);
			local msg = DBarSpellCatchTextLeft1:GetText();
			if msg and (strfind(msg,DRUIDBAR_META)) then
				if DruidBarKey.Debug then DEFAULT_CHAT_FRAME:AddMessage("Rune detected, no mana cost!"); end
				return;
			end
			j = j + 1;
		end
		DruidBarKey.keepthemana = DruidBarKey.keepthemana - DruidBarKey.subtractmana;
		if DruidBarKey.Debug then DEFAULT_CHAT_FRAME:AddMessage("Mana Deduction: "..DruidBarKey.subtractmana); end
	else
		firstshift = nil;
	end
end

--Change form! whatever you cast, if you're shifted, you'll shift back to caster.
function DruidBar_ChangeForm(id)
	local a, b, c, d;
	a = "Interface\\Icons\\Ability_Druid_AquaticForm";
	b = "Interface\\Icons\\Ability_Racial_BearForm";
	c = "Interface\\Icons\\Ability_Druid_CatForm";
	d = "Interface\\Icons\\Ability_Druid_TravelForm";
	local changingback = nil;
	for i = 1, GetNumShapeshiftForms() do
		local icon, name, active = GetShapeshiftFormInfo(i);
		if active then id = i; changingback = true; end
	end
	if (id) then
		local tex = GetShapeshiftFormInfo(id);
		if DruidBarKey.message and not changingback then
			if not DruidBarKey.BearMessage or not strfind(tostring(DruidBarKey.BearMessage), "table:") then
				DruidBarKey.BearMessage = {};
				DruidBarKey.BearMessage[1] = "ROAR! ROAR I SAY! I guess there's no denyin'...";
				DruidBarKey.BearMessage[2] = "SAY";
			end
			if not DruidBarKey.CatMessage or not strfind(tostring(DruidBarKey.CatMessage), "table:") then
				DruidBarKey.CatMessage = {};
				DruidBarKey.CatMessage[1] = "Nyao.";
				DruidBarKey.CatMessage[2] = "SAY";
			end
			if not DruidBarKey.AquaMessage or not strfind(tostring(DruidBarKey.AquaMessage), "table:") then
				DruidBarKey.AquaMessage = {};
				DruidBarKey.AquaMessage[1] = "Thrust vectoring owns the seas!";
				DruidBarKey.AquaMessage[2] = "SAY";
			end
			if not DruidBarKey.TravMessage or not strfind(tostring(DruidBarKey.TravMessage), "table:") then
				DruidBarKey.TravMessage = {};
				DruidBarKey.TravMessage[1] = "Multi-cat drifting!";
				DruidBarKey.TravMessage[2] = "SAY";
			end
			if tex == b and DruidBarKey.BearMessage then
				SendChatMessage(DruidBarKey.BearMessage[1], DruidBarKey.BearMessage[2]);
			elseif tex == a and DruidBarKey.AquaMessage then
				SendChatMessage(DruidBarKey.AquaMessage[1], DruidBarKey.AquaMessage[2]);
			elseif tex == c and DruidBarKey.CatMessage then
				SendChatMessage(DruidBarKey.CatMessage[1], DruidBarKey.CatMessage[2]);
			elseif tex == d and DruidBarKey.TravMessage then
				SendChatMessage(DruidBarKey.TravMessage[1], DruidBarKey.TravMessage[2]);
			end
		end
		pre_ShapeshiftBar_ChangeForm(id);
		return nil;
	else
		return true;
	end
end

--Hooks into the original UseAction. Passes ChangeForm to shift out of caster.
function DruidBar_UseAction(id, ex, theSelf)
	local texture = GetActionTexture(id);
	local a, b, c, d;
	a = "Interface\\Icons\\Ability_Druid_AquaticForm";
	b = "Interface\\Icons\\Ability_Racial_BearForm";
	c = "Interface\\Icons\\Ability_Druid_CatForm";
	d = "Interface\\Icons\\Ability_Druid_TravelForm";
	e = ".blp";
	if (texture == a or texture == b or texture == c or texture == d or texture == a..e or texture == b..e or texture == c..e or texture == d..e) then
		local fix = DruidBar_ChangeForm(nil);
		if (GetActionText(id) or fix) then
			pre_UseAction(id, ex, theSelf);
		end
	else
		pre_UseAction(id, ex, theSelf);
	end
end

function dbarhide(frame)
	if frame:IsVisible() then
		frame:Hide();
	end
end
function dbarshow(frame)
	if not frame:IsVisible() then
		frame:Show();
	end
end

function dbarlen()
	if not DruidBarKey.xvar then DruidBarKey.xvar = 160; end
	if DruidBarFrame:GetWidth() ~= DruidBarKey.xvar then
		DruidBarFrame:SetWidth(DruidBarKey.xvar);
		DruidBarKey.xvar = DruidBarFrame:GetWidth();
	end
	DruidBarMana:SetWidth(DruidBarKey.xvar*0.9375);
end

function dbarhei()
	if not DruidBarKey.yvar then DruidBarKey.yvar = 18; end
	if DruidBarFrame:GetHeight() ~= DruidBarKey.yvar then
		DruidBarFrame:SetHeight(DruidBarKey.yvar);
		DruidBarKey.yvar = DruidBarFrame:GetHeight();
	end
	DruidBarMana:SetHeight(DruidBarKey.yvar*(2/3));
end
local DruidBar_Anchored = nil

function DruidBar_MainGraphics()
	local str;
	if DruidBarKey.Percent and DruidBarKey.Percent == 1 then
		str = "|CFFFFFFFF"..floor(DruidBarKey.keepthemana / DruidBarKey.maxmana * 100).."%|r";
	elseif DruidBarKey.Percent then
		str = "|CFFFFFFFF"..floor(DruidBarKey.keepthemana).."/"..floor(DruidBarKey.maxmana).."|r";
	else
		str = "|CFFFFFFFF"..floor(DruidBarKey.keepthemana).."/"..floor(DruidBarKey.maxmana).." "..floor(DruidBarKey.keepthemana / DruidBarKey.maxmana * 100).."%|r";
	end
	dbarhide(DruidBarReplaceText);
	if PlayerFrameManaBar:GetWidth() < 100 then PlayerFrameManaBar:SetWidth(120); end
	
	if (DruidBarKey.Hide and UnitPowerType("player") ~= 0 and DruidBar_Full()) or not DruidBarKey.Hide then
		dbarshow(DruidBarFrame);
		dbarshow(DruidBarBorder);
		if (DruidBarKey.Text and DruidBarKey.Text == 1) or (not DruidBarKey.Text and MouseIsOver(DruidBarFrame)) then
			dbarshow(DruidBarText1);
			dbarhide(DruidBarText);
			DruidBarText1:SetText(str);
		elseif DruidBarKey.Text then
			dbarshow(DruidBarText);
			dbarhide(DruidBarText1);
			DruidBarText:SetText(str);
		else
			dbarhide(DruidBarText);
			dbarhide(DruidBarText1);
		end
		dbarlen(); 
		dbarhei();
		if DruidBarKey.XPBar then
			DruidBarFrame:ClearAllPoints();
			DruidBarFrame:SetPoint("TOPLEFT","PlayerFrame","TOPLEFT", 80, -63);
			PlayerFrame:SetFrameLevel("1");
			DruidBarFrame:SetFrameLevel("1");
			DruidBarMana:SetFrameLevel("1");
			DruidBar_Anchored = true;
		elseif DruidBar_Anchored then
			DruidBarFrame:ClearAllPoints();
			DruidBarFrame:SetPoint("CENTER","UIParent","CENTER", 0, 0);
			PlayerFrame:SetFrameLevel("1")
			DruidBarFrame:SetFrameLevel("1");
			DruidBarFrame:SetFrameLevel("1");
			DruidBar_Anchored = nil;
		end
		if DruidBarKey.Lock then
			dbarshow(DruidBarDontMove);
		else
			dbarhide(DruidBarDontMove);
		end
	else
		dbarhide(DruidBarFrame);
		dbarhide(DruidBarDontMove);
	end
end

function DruidBar_ReplaceGraphics()
	if UnitPowerType("player") ~= 0 then
		dbarshow(DruidBarFrame);
		dbarhide(DruidBarDontMove);
		dbarhide(DruidBarBorder);
		dbarhide(DruidBarText);
		dbarhide(DruidBarText1);
		dbarhide(PlayerFrameManaBarText);
		dbarshow(DruidBarReplaceText);
		PlayerFrameManaBar:SetWidth(60);
		DruidBarFrame:ClearAllPoints();
		DruidBarFrame:SetPoint("TOPLEFT","PlayerFrame","TOPLEFT", 116, -50);
		DruidBarMana:SetWidth(60);
		DruidBarMana:SetHeight(10);
		DruidBarMana:SetFrameLevel("1");
		local str, str1;
		str = "|CFFFFFFFF"..UnitMana("player").."|r";
		if DruidBarKey.Percent and DruidBarKey.Percent == 1 then
			str1 = "|CFFFFFFFF"..floor(DruidBarKey.keepthemana / DruidBarKey.maxmana * 100).."%|r";
		elseif DruidBarKey.Percent then
			str1 = "|CFFFFFFFF"..floor(DruidBarKey.keepthemana).."|r";
		else
			str1 = "|CFFFFFFFF"..(floor(DruidBarKey.keepthemana / 100)/10).."k,"..floor(DruidBarKey.keepthemana / DruidBarKey.maxmana * 100).."%|r";
		end
		DruidBarReplaceText:SetFrameLevel("2");
		if (DruidBarKey.Text and DruidBarKey.Text == 1) or (not DruidBarKey.Text and (MouseIsOver(DruidBarFrame) or MouseIsOver(PlayerFrameManaBar)))then
			dbarshow(DEnergyText1);
			dbarshow(DManaText1);
			dbarhide(DManaText);
			dbarhide(DEnergyText);
			DEnergyText1:SetText(str);
			DManaText1:SetText(str1);
		elseif DruidBarKey.Text then
			dbarshow(DEnergyText);
			dbarhide(DEnergyText1);
			dbarshow(DManaText);
			dbarhide(DManaText1);
			DEnergyText:SetText(str);
			DManaText:SetText(str1);
		else
			dbarhide(DEnergyText);
			dbarhide(DEnergyText1);
			dbarhide(DManaText);
			dbarhide(DManaText1);
		end
	else
		dbarhide(DruidBarFrame);
		dbarhide(DEnergyText);
		dbarhide(DEnergyText1);
		dbarhide(DManaText);
		dbarhide(DManaText1);
		dbarhide(DruidBarReplaceText);
		PlayerFrameManaBar:SetWidth(120);
	end
end

function DruidBar_KMGraphics()
	if (MGplayer_ManaBar) then
		if UnitPowerType("player") == 0 then
			MGplayer_ManaBar:SetWidth(MGplayer_HealthBar:GetWidth());
			MGplayer_ManaBar:ClearAllPoints();
			MGplayer_ManaBar:SetPoint("TOP","MGplayer_HealthBar","BOTTOM",0,-2);
			DruidBarKMG:Hide();
		else	
			local sub = 0;
			if MG_Get("ShowEndcaps") == 1 then sub = 1; else sub = -1; end
			KMGDruidBar:SetWidth(MGplayer_HealthBar:GetWidth() / 2 - sub);
			KMGDruidBar:SetHeight(MGplayer_ManaBar:GetHeight());
			MGplayer_ManaBar:SetWidth(MGplayer_HealthBar:GetWidth() / 2);
			DruidBarKMG:Show();
			DruidBarKMG:ClearAllPoints();
			MGplayer_ManaBar:ClearAllPoints();
			MGplayer_ManaBar:SetPoint("TOPLEFT","MGplayer_HealthBar","BOTTOMLEFT",0,-2);
			local points = MGplayer_HealthBar:GetWidth() / 4 * 3;
			if MG_Get("ShowEndcaps") == 1 then
				dbarshow(KMGDruidBar_ManaEndcapRight);
			else
				dbarhide(KMGDruidBar_ManaEndcapRight);
				if MGplayer_ManaBar:GetWidth() <= 92 then points = points - 1; else points = points - 1; end
			end
			DruidBarKMG:SetScale(MGplayer_HealthBar:GetScale());
			DruidBarKMG:SetPoint("LEFT","MGplayer_ManaBar","LEFT", points, 0);
			DruidBarKMG:SetFrameLevel("1");
			KMGDruidBar:SetFrameLevel(MGplayer_ManaBar:GetFrameLevel());
			KMGDruidBar:SetMinMaxValues(0, DruidBarKey.maxmana);
			KMGDruidBar:SetValue(DruidBarKey.keepthemana);
			if (DruidBarKey.Percent and MGplayer_HealthBar:GetWidth() <= 92) then
				local curstat = (UnitMana("player") / UnitManaMax("player") * 100);
				local manstat = (floor(DruidBarKey.keepthemana / DruidBarKey.maxmana * 100)).."%";
				MGplayer_ManaText:SetText(curstat.."/"..manstat);
			elseif (MGplayer_HealthBar:GetWidth() <= 92) then
				local curstat = UnitMana("player");
				MGplayer_ManaText:SetText(curstat.."/"..floor(DruidBarKey.keepthemana));
			end
		end
	else
		DruidBarKMG:Hide();
		DruidBarKey.kmg = nil;
	end
end

--Text Parsing. Yay!
function TextParse(InputString)
--[[ By FERNANDO!
	This function should take a string and return a table with each word from the string in
	each entry. IE, "Linoleum is teh awesome" returns {"Linoleum", "is", "teh", "awesome"}
	Some good should come of this, I've been avoiding writing a text parser for a while, and
	I need one I understand completely. ^_^

	If you want to gank this function and use it for whatever, feel free. Just give me props
	somewhere. This function, as far as I can tell, is fairly foolproof. It's hard to get it
	to screw up. It's also completely self-contained. Just cut and paste.]]
   local Text = InputString;
   local TextLength = 1;
   local OutputTable = {};
   local OTIndex = 1;
   local StartAt = 1;
   local StopAt = 1;
   local TextStart = 1;
   local TextStop = 1;
   local TextRemaining = 1;
   local NextSpace = 1;
   local Chunk = "";
   local Iterations = 1;
   local EarlyError = false;

   if ((Text ~= nil) and (Text ~= "")) then
   -- ... Yeah. I'm not even going to begin without checking to make sure Im not getting
   -- invalid data. The big ol crashes I got with my color functions taught me that. ^_^

      -- First, it's time to strip out any extra spaces, ie any more than ONE space at a time.
      while (string.find(Text, "  ") ~= nil) do
         Text = string.gsub(Text, "  ", " ");
      end

      -- Now, what if text consisted of only spaces, for some ungodly reason? Well...
      if (string.len(Text) <= 1) then
         EarlyError = true;
      end

      -- Now, if there is a leading or trailing space, we nix them.
      if EarlyError ~= true then
        TextStart = 1;
        TextStop = string.len(Text);

        if (string.sub(Text, TextStart, TextStart) == " ") then
           TextStart = TextStart+1;
        end

        if (string.sub(Text, TextStop, TextStop) == " ") then
           TextStop = TextStop-1;
        end

        Text = string.sub(Text, TextStart, TextStop);
      end

      -- Finally, on to breaking up the goddamn string.

      OTIndex = 1;
      TextRemaining = string.len(Text);

      while (StartAt <= TextRemaining) and (EarlyError ~= true) do

         -- NextSpace is the index of the next space in the string...
         NextSpace = string.find(Text, " ",StartAt);
         -- if there isn't another space, then StopAt is the length of the rest of the
         -- string, otherwise it's just before the next space...
         if (NextSpace ~= nil) then
            StopAt = (NextSpace - 1);
         else
            StopAt = string.len(Text);
            LetsEnd = true;
         end

         Chunk = string.sub(Text, StartAt, StopAt);
         OutputTable[OTIndex] = Chunk;
         OTIndex = OTIndex + 1;

         StartAt = StopAt + 2;

      end
   else
      OutputTable[1] = "Error: Bad value passed to TextParse!";
   end

   if (EarlyError ~= true) then
      return OutputTable;
   else
      return {"Error: Bad value passed to TextParse!"};
   end
end

--Normal print job.
function DruidBar_Print(msg,r,g,b,frame,id,unknown4th)
	if(unknown4th) then
		local temp = id;
		id = unknown4th;
		unknown4th = id;
	end
				
	if (not r) then r = 1.0; end
	if (not g) then g = 1.0; end
	if (not b) then b = 1.0; end
	if ( frame ) then 
		frame:AddMessage(msg,r,g,b,id,unknown4th);
	else
		if ( DEFAULT_CHAT_FRAME ) then 
			DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b,id,unknown4th);
		end
	end
end

function DruidBar_Toggle(tog, str) if tog then DruidBar_Print(str.." off"); return nil; else DruidBar_Print(str.." on"); return true; end end

function DruidBar_Enable_ChatCommandHandler(text)
	local msg = TextParse(text);
	msg[1] = strlower(msg[1]);
	if msg[1] == "on" then
		DruidBarKey.Enabled = true;
		DruidBar_Print("DruidBar is Enabled!",1,1,0);
	elseif msg[1] == "off" then
		DruidBarKey.Enabled = nil;
		DruidBar_Print("DruidBar is Disabled!",1,1,0);
	elseif msg[1] == "toggle" then
		DruidBarKey.Enabled = DruidBar_Toggle(DruidBarKey.Enabled, "DruidBar is");
	elseif msg[1] == "vis" then
		DruidBarKey.Graphics = DruidBar_Toggle(DruidBarKey.Graphics, "DruidBar's visual data is");
	elseif msg[1] == "message" then
		if msg[2] and msg[2] == "toggle" then
			DruidBarKey.message = DruidBar_Toggle(DruidBarKey.message, "Shapeshifting messages are");
		elseif msg[2] then
			msg[2] = strlower(msg[2]);
			if msg[3] then msg[3] = strlower(msg[3]); end
			if msg[3] and (msg[3] == "say" or msg[3] == "party" or msg[3] == "raid" or msg[3] == "emote") then
				--ookay...
			else
				DruidBar_Print("Invalid chat type. message format is: /dbar message [toggle/bear/cat/aqua/travel] [say/party/raid/emote] [message]");
				return;
			end
			if msg[2] == "bear" then
				DruidBarKey.BearMessage = {};
				local x = string.gsub(text, msg[1].." "..msg[2].." "..msg[3].." ", "");
				DruidBarKey.BearMessage[1] = x;
				DruidBarKey.BearMessage[2] = msg[3];
				DruidBar_Print("Current Bear message is now:"..x);
			elseif msg[2] == "cat" then
				DruidBarKey.CatMessage = {};
				local x = string.gsub(text, msg[1].." "..msg[2].." "..msg[3].." ", "");
				DruidBarKey.CatMessage[1] = x;
				DruidBarKey.CatMessage[2] = msg[3];
				DruidBar_Print("Current Cat message is now:"..x);
			elseif msg[2] == "aqua" then
				DruidBarKey.AquaMessage = {};
				local x = string.gsub(text, msg[1].." "..msg[2].." "..msg[3].." ", "");
				DruidBarKey.AquaMessage[1] = x;
				DruidBarKey.AquaMessage[2] = msg[3];
				DruidBar_Print("Current Aquatic message is now:"..x);
			elseif msg[2] == "travel" then
				DruidBarKey.TravMessage = {};
				local x = string.gsub(text, msg[1].." "..msg[2].." "..msg[3].." ", "");
				DruidBarKey.TravMessage[1] = x;
				DruidBarKey.TravMessage[2] = msg[3];
				DruidBar_Print("Current Travel message is now:"..x);
			else
				DruidBar_Print("Invalid message type. message takes 5 parameters: Toggle, Bear, Cat, Aqua, or Travel.");
			end
		else
			DruidBar_Print("Invalid chat type. message format is: /dbar message [toggle/bear/cat/aqua/travel] [say/party/raid/emote] [message]");
		end
	elseif msg[1] == "width" and msg[2] and tonumber(msg[2]) then
		DruidBarKey.xvar = tonumber(msg[2]);
		DruidBar_Print("Width is now set to "..msg[2]);
	elseif msg[1] == "height" and msg[2] and tonumber(msg[2]) then
		DruidBarKey.yvar = tonumber(msg[2]);
		DruidBar_Print("Height is now set to "..msg[2]);
	elseif msg[1] == "hide" then
		DruidBarKey.Hide = DruidBar_Toggle(DruidBarKey.Hide, "Hiding bar when in caster form is");
	elseif msg[1] == "full" then
		DruidBarKey.Full = DruidBar_Toggle(DruidBarKey.Full, "Hiding bar when mana is full is");
	elseif msg[1] == "lock" then
		DruidBarKey.Lock = DruidBar_Toggle(DruidBarKey.Lock, "Lock feature is");
	elseif msg[1] == "replace" then
		DruidBarKey.Replace = DruidBar_Toggle(DruidBarKey.Replace, "Replacing the player frame's mana bar is");
	elseif msg[1] == "player" then
		DruidBarKey.XPBar = DruidBar_Toggle(DruidBarKey.XPBar, "Showing the bar below the Player Frame is");
		if DruidBarKey.XPBar then DruidBarKey.xvar = 150; DruidBarKey.yvar = 18; else DruidBarKey.xvar = 160; DruidBarKey.yvar = 18; end
	elseif msg[1] == "text" then
		if not DruidBarKey.Text then DruidBarKey.Text = 0; DruidBar_Print("Original-Style text on!"); elseif DruidBarKey.Text == 0 then DruidBarKey.Text = 1; DruidBar_Print("New-Style text on!"); elseif DruidBarKey.Text == 1 then DruidBarKey.Text = nil; DruidBar_Print("Text removed."); end
	elseif msg[1] == "percent" then
		if not DruidBarKey.Percent then DruidBarKey.Percent = 0; DruidBar_Print("DruidBar will show Raw numbers"); elseif DruidBarKey.Percent == 0 then DruidBarKey.Percent = 1; DruidBar_Print("DruidBar will now show Percentages"); elseif DruidBarKey.Percent == 1 then DruidBarKey.Percent = nil; DruidBar_Print("DruidBar will show both Percentages and Raw numbers"); end
	elseif msg[1] == "status" then
		DruidBar_Status();
	elseif msg[1] == "best" then
		DruidBar_ChangeBestForm();
	elseif msg[1] == "ez" then
		DruidBarKey.EZShift = DruidBar_Toggle(DruidBarKey.EZShift, "Easy Shifting is now");
	elseif msg[1] == "kmg" then
		if (MGplayer_ManaBar) then
			DruidBarKey.kmg = DruidBar_Toggle(DruidBarKey.kmg, "Replacing the MiniGroup mana bar is");
		else
			DruidBarKey.kmg = nil;
			DruidBar_Print("Can't replace MiniGroup if it don't exist, YO!");
		end
	elseif msg[1] == "debug" then
		DruidBarKey.Debug = DruidBar_Toggle(DruidBarKey.Debug, "Debug options");
	else
		DruidBar_Print("Invalid option. Options are: [on/off/toggle/vis/message/width/height/percent/hide/full/lock/replace/kmg/best/player/text/status]");
	end
end

function DruidBar_Status()
	DruidBar_Print("DruidBar Toggle Status:");
	DruidBar_Print("DruidBar's enabled status is "..DruidBar_On(DruidBarKey.Enabled));
	DruidBar_Print("Graphics are "..DruidBar_On(DruidBarKey.Graphics));
	DruidBar_Print("Shapeshift messages are "..DruidBar_On(DruidBarKey.message));
	DruidBar_Print("Hiding when in caster is "..DruidBar_On(DruidBarKey.Hide));
	DruidBar_Print("Hiding when mana is full is "..DruidBar_On(DruidBarKey.Full));
	DruidBar_Print("Replacing the Player Frame's mana bar is "..DruidBar_On(DruidBarKey.Replace));
	DruidBar_Print("Showing under the Player Frame is "..DruidBar_On(DruidBarKey.XPBar));
	local str;
	if not DruidBarKey.Text then str = "|CFF888888Off|r"; elseif DruidBarKey.Text == 1 then str = "|CFFFFFFFFModern|r"; else str = "|CFF00FF00Classic|r"; end
	DruidBar_Print("The current style of text is "..str);
	if not DruidBarKey.Percent then str = "|CFF00FF00Percent and Raw|r"; elseif DruidBarKey.Percent == 1 then str = "|CFFFF00FFRaw|r"; else str = "|CFF0000FFPercent|r"; end
	DruidBar_Print("The current display of text is "..str);
	DruidBar_Print("Debugging is "..DruidBar_On(DruidBarKey.Debug));
end

function DruidBar_On(tog)
	if tog then
		return "|CFF00FF00On.|r";
	else
		return "|CFFFF0000Off.|r";
	end
end

function DruidBar_MaxManaScript()
			local _, int = UnitStat("player", 4);
			DruidBar_GetShapeshiftCost();
			if UnitPowerType("player") == 0 then
				if UnitManaMax("player") > 0 then
					DruidBarKey.maxmana = UnitManaMax("player");
					DruidBarKey.keepthemana = UnitMana("player");
					DruidBarKey.int = int;
				end
			elseif UnitPowerType("player") ~= 0 then
				if DruidBarKey.int ~= int then
					if int > DruidBarKey.int then
						local dif = int - DruidBarKey.int;
						DruidBarKey.maxmana = DruidBarKey.maxmana + (dif * 15);
						DruidBarKey.int = int;
					elseif int < DruidBarKey.int then
						local dif = DruidBarKey.int - int;
						DruidBarKey.maxmana = DruidBarKey.maxmana - (dif * 15);
						DruidBarKey.int = int;
					end
				end
				if DruidBarKey.keepthemana > DruidBarKey.maxmana then
					DruidBarKey.keepthemana = DruidBarKey.maxmana;
				end
			end
			DruidBarKey.extra = 0;
			for i = 1, 18 do
				DBarSpellCatch:ClearLines();
				DBarSpellCatch:SetInventoryItem("player", i);
				for j = 1, DBarSpellCatch:NumLines() do
					local strchek = getglobal("DBarSpellCatchTextLeft"..j):GetText();
					if strchek then
						
						if strfind(strchek, DRUIDBAR_REGEN1) then
							DruidBarKey.extra = DruidBarKey.extra + string.gsub(strchek, DRUIDBAR_REGEN3, "%1")
						end
						if strfind(strchek, DRUIDBAR_REGEN2) then
							DruidBarKey.extra = DruidBarKey.extra + string.gsub(strchek, DRUIDBAR_REGEN4, "%1");
						end
					end
				end
			end
			DruidBarKey.extra = (DruidBarKey.extra * 2) / 5;
end

function DruidBar_Full()
	if DruidBarKey.Full then
		if DruidBarKey.keepthemana < DruidBarKey.maxmana then
			return true;
		else
			return nil;
		end
	else
		return true;
	end
end


function UIErrorsFrame:realEcho()

end



function UIErrorsFrame:fakeEcho(str, a1, a2, a3, a4, a5, a6)
    --DruidBar_Print(str, a1, a2, a3)
    --The outdoors message is normally delayed by lag so that it doesn't actually come until after the function is re-enabled.  However, on occasion when the latency is very low and the interface lags, it will come while the function is still disabled.  Allow the message through if this is the case.
    if(str == "Can only use outside") then
        UIErrorsFrame:realEcho(str, a1, a2, a3, a4, a5, a6)
    end

end


--[[              Shapeshifting Code                    ]]--
--Thanks to mib for this code! it's awesome!
--also thanks to Zevzabich for a bit of help since the pure rapeage of both my character and my lua that is know as 0.10
function DruidBar_ChangeBestForm()
	local m_bag = -1;
	local m_pos = -1;
	local aq_bag = -1;
	local aq_pos = -1;
	-- search position of mount         
	for bag = 0,4 do
		for i = 1,16 do
			local t = GetContainerItemInfo(bag, i)
			if (t) then
				if (strfind(t,"\Ability_Mount_")) then
					m_bag = bag;
					m_pos = i;
				end
				if strfind(t, "\INV_Misc_Horn_01") and strfind(strlower(GetContainerItemLink(bag,i)), "frostwolf") then
					m_bag = bag;
					m_pos = i;
				end
				if (strfind(t, "INV_Misc_QirajiCrystal")) then
					aq_bag = bag;
					aq_pos = i;
				end
			end
		end
	end
	local _, pqrs = UnitClass("player");
	if pqrs == "DRUID" then
		--first hide the error messages
		--we try to do all 3 at once!

		UIErrorsFrame.realEcho = UIErrorsFrame.AddMessage;
		UIErrorsFrame.AddMessage = UIErrorsFrame.fakeEcho;
		if strfind(GetRealZoneText(), "Ahn'Qiraj") and not strfind(GetRealZoneText(), "Gates of Ahn'Qiraj") and not strfind(GetRealZoneText(), "Ruins of Ahn'Qiraj") then
			UseContainerItem(aq_bag, aq_pos);
		else
			UseContainerItem(m_bag, m_pos);
		end
		ShapeshiftBar_ChangeForm(travelformid);
		ShapeshiftBar_ChangeForm(aquaformid);
		--then we allow error messages again
		UIErrorsFrame.AddMessage = UIErrorsFrame.realEcho;
	else
		local i = 1;
		--check for high-speed castable mounts.
		while true do
			local spellName = GetSpellName(i, BOOKTYPE_SPELL);
			if not spellName then
				do break end
			end
			if spellName == "Summon Charger" or spellName == "Summon Dreadsteed" then
				CastSpell(i, BOOKTYPE_SPELL);
				return;
			end
			i = i + 1;
		end
		i = 1;
		--check for lv40 castable mounts, or ghost wolf.
		while true do
			local spellName = GetSpellName(i, BOOKTYPE_SPELL);
			if not spellName then
				do break end
			end
			if spellName == "Summon Felsteed" or spellName == "Ghost Wolf" or spellName == "Summon Warhorse" then
				CastSpell(i, BOOKTYPE_SPELL);
				return;
			end
			i = i + 1;
		end
		--nothing yet? let's try to mount normally.
		UIErrorsFrame.realEcho = UIErrorsFrame.AddMessage;
		UIErrorsFrame.AddMessage = UIErrorsFrame.fakeEcho;
		--and trying...
		if strfind(GetRealZoneText(), "Ahn'Qiraj") and not strfind(GetRealZoneText(), "Gates of Ahn'Qiraj") and not strfind(GetRealZoneText(), "Ruins of Ahn'Qiraj") then
			UseContainerItem(aq_bag, aq_pos);
		else
			UseContainerItem(m_bag, m_pos);
		end
		--then we allow error messages again
		UIErrorsFrame.AddMessage = UIErrorsFrame.realEcho;
	end
end