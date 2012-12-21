FORMS_EN = {"Bear Form", "Cat Form", "Moonkin Form", "Travel Form", "Aquatic Form"}
PROWL_EN = "Prowl"
CHARG_EN = "Feral Charge"
TRACK_EN = "Track Humanoids"

FORMS_FR = {"Forme d\226\128\153ours", "Forme de f\195\169lin", "Forme de s\195\169l\195\169nien", "Forme de voyage", "Forme aquatique"}
PROWL_FR = "R\195\180der"
CHARG_FR = "Charge farouche"
TRACK_FR = "Humanoide aufsp\195\188ren"

FORMS_DE = {"B\195\164rengestalt", "Katzengestalt", "Moonkingestalt", "Reisegestalt", "Wassergestalt"}
PROWL_DE = "Schleichen"
CHARG_DE = "Wilde Attacke"
TRACK_DE = "Pistage des humano\195\175des"

Human = "human"

PROWL = "\Ability_Ambush"
TRACK = "\Ability_Tracking"

Prowler_Forms = {}

local maxspells
local prowl_id
local charg_id
local track_id
local prev_ab
local locked
local charg_toggle

function SearchForm(form)
	form = string.lower(form)
	local bear = string.lower(Bear)
	if (GetLocale() == 'frFR') then
		if string.find(bear, form) then
			form = bear
		end
	else
		if string.find(form, bear) then
			form = bear
		end
	end
	return Prowler_Forms[form].pos
end

function CurrentForm()
	return Prowler_Forms["current"]
end

local function ActiveForm()
	local i = 1
	while (i <= GetNumShapeshiftForms()) do
		local _, name, active, castable = GetShapeshiftFormInfo(i)
		if active then
			return name
		end
		i = i + 1
	end
	return Human
end

local function Init_Forms_Table()
	for i = 1, getn(FORMS) do
		local form = string.lower(FORMS[i])
		Prowler_Forms[form] = {name = "", pos = 0}
	end
end

local function Create_Forms_Table()
	local i = 1;
	Prowler_Forms["current"] = string.lower(Human)
	while (i <= GetNumShapeshiftForms()) do
		local _, name1, active1 = GetShapeshiftFormInfo(i);
		name1 = string.lower(name1)
		local j = 0
		if (GetLocale() == 'frFR') then
			repeat
				j = j + 1
				form = string.lower(FORMS[j])
			until (string.find(form,name1) or j >= getn(FORMS))
			if (string.find(form,name1)) then 
				Prowler_Forms[form] = {name = form, pos = i}
				if (active1) then
					Prowler_Forms["current"] = form
				end
			end
		else
			repeat
				j = j + 1
				form = string.lower(FORMS[j])
			until (string.find(name1,form) or j >= getn(FORMS))
			if (string.find(name1,form)) then 
				Prowler_Forms[form] = {name = form, pos = i}
				if (active1) then
					Prowler_Forms["current"] = form
				end
			end
		end
		i = i + 1
	end
end

local function Update_Forms_Table()
	form = string.lower(ActiveForm())
	local bear = string.lower(Bear)
	if (GetLocale() == 'frFR') then
		if string.find(bear, form) then
			form = bear
		end
	else
		if string.find(form, bear) then
			form = bear
		end
	end
	Prowler_Forms["current"] = string.lower(form);
end

local function FindProwl()
	local i = 0
	while GetPlayerBuffTexture(i) do
		local icon = GetPlayerBuffTexture(i)
		if (string.find(icon,PROWL) )then 
			return true
		end
		i = i + 1
		if i > 50 then break end
	end
	return false
end

local function FindTrackHumans()
	local track = GetTrackingTexture()
	if string.find(track,TRACK) then
		return true
	end
	return false
end

local function GetNumBuffs()
	local i = 0
	while GetPlayerBuffTexture(i) do
		i = i + 1
	end
	return i
end

local function MaxSpells()
	local i = 1
	local total_spells = 0
	local num_tabs = GetNumSpellTabs()
	while (i <= num_tabs) do
		local _,_,_,numSpells = GetSpellTabInfo(i)
		total_spells = total_spells + numSpells
		i = i + 1;
	end
	return total_spells
end

local function SearchBestSpell(msg)
	local i = 0
	local found = false
	while (not found) do
		i = i + 1
		name = GetSpellName(i,'spell')
		if (name == msg) then
			found = true
		end
		if (i > maxspells) then
			break
		end
	end
	if (not found) then
		return -1
	end
	local j = i
	local best_spell = false
	while (not best_spell) do
		local name2,_ = GetSpellName(j+1,'spell')
		if (msg == name2) then
			j = j + 1
		else
			best_spell = true
		end
	end
	return j
end

local function Prowl_Print(msg)
	if (not DEFAULT_CHAT_FRAME) then
		return
	end
	DEFAULT_CHAT_FRAME:AddMessage(msg)
end

function Prowler_OnLoad()
	_,lclass = UnitClass("player")
	if (lclass ~= "DRUID") then
		return
	end
	
	Prowl = PROWL_EN
	Charg = CHARG_EN
	Track = TRACK_EN
	Bear = string.lower(FORMS_EN[1])
	Cat = string.lower(FORMS_EN[2])
	Moon = string.lower(FORMS_EN[3])
	Travel = string.lower(FORMS_EN[4])
	Aqua = string.lower(FORMS_EN[5])
	FORMS = FORMS_EN
	if (GetLocale() == 'frFR') then
		Prowl = PROWL_FR
		Charg = CHARG_FR
		Track = TRACK_FR
		Bear = string.lower(FORMS_FR[1])
		Cat = string.lower(FORMS_FR[2])
		Moon = string.lower(FORMS_FR[3])
		Travel = string.lower(FORMS_FR[4])
		Aqua = string.lower(FORMS_FR[5])
		FORMS = FORMS_FR
	elseif (GetLocale() == 'deDE') then
		Prowl = PROWL_DE
		Charg = CHARG_DE
		Track = TRACK_DE
		Bear = string.lower(FORMS_DE[1])
		Cat = string.lower(FORMS_DE[2])
		Moon = string.lower(FORMS_DE[3])
		Travel = string.lower(FORMS_DE[4])
		Aqua = string.lower(FORMS_DE[5])
		FORMS = FORMS_DE
	end
	
	BINDING_HEADER_Prowler = 'Prowler'
	BINDING_NAME_Prowler_Aquatic = 'Aquatic Form'	
	BINDING_NAME_Prowler_Bear = 'Bear & Charge'
	BINDING_NAME_Prowler_Prowl = 'Cat & Prowl'	
	BINDING_NAME_Prowler_Moon = 'Moonkin Form'
	BINDING_NAME_Prowler_Human = 'Humanoid'
	BINDING_NAME_Prowler_Travel = 'Travel Form'
	BINDING_NAME_Prowler_Best = 'Best From'

	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
	this:RegisterEvent('SPELLS_CHANGED');

	SLASH_PROWLER1 = "/Prowler"
	SlashCmdList["PROWLER"] = function(msg)
		Prowler_Cmd(msg);
	end
	
	maxspells = MaxSpells()
	prowl_id = SearchBestSpell(Prowl);
	charg_id = SearchBestSpell(Charg);
	track_id = SearchBestSpell(Track);
	Init_Forms_Table()
	Create_Forms_Table()
	Update_Forms_Table()
	
	tinsert(UISpecialFrames,"Prowler1");
end

function Prowler_OnClick1(arg1)
	if (Prowler1_CheckButton1:GetChecked()) then
		toggle = true;
		Prowler1_CheckButton1Text:SetText("Prowler Enabled")
		Prowler1_CheckButton1Text:SetTextColor(0,1,0)
	else
		toggle = false;
		Prowler1_CheckButton1Text:SetText("Prowler Disabled")
		Prowler1_CheckButton1Text:SetTextColor(1,0,0)
	end
end

function Prowler_OnClick2(arg1)
	local frame = getglobal("Prowler1")
	if (Prowler1_CheckButton2:GetChecked()) then
		frame.isLocked = 1;
		locked = 1;
		Prowler1_CheckButton2Text:SetText("Prowler Locked")
		Prowler1_CheckButton2Text:SetTextColor(0,1,0)
	else
		frame.isLocked = 0;
		locked = 0;
		Prowler1_CheckButton2Text:SetText("Prowler Unlocked")
		Prowler1_CheckButton2Text:SetTextColor(1,0,0)
	end
end

function Prowler_OnClick3(arg1)
	if (Prowler1_CheckButton3:GetChecked()) then
		prev = true
		Prowler1_CheckButton3Text:SetText("Using Last AB")
		Prowler1_CheckButton3Text:SetTextColor(0,1,0)
	else
		prev = false
		Prowler1_CheckButton3Text:SetText("Using Main AB")
		Prowler1_CheckButton3Text:SetTextColor(1,0,0)
	end
end

function Prowler_OnClick4(arg1)
	if (Prowler1_CheckButton4:GetChecked()) then
		MA_toggle = true
		Prowler1_CheckButton4Text:SetText("MoveAnything! Fix on")
		Prowler1_CheckButton4Text:SetTextColor(0,1,0)
	else
		MA_toggle = false
		Prowler1_CheckButton4Text:SetText("MoveAnything! Fix off")
		Prowler1_CheckButton4Text:SetTextColor(1,0,0)
	end
end

function Prowler_OnClick5(arg1)
	if (Prowler1_CheckButton5:GetChecked()) then
		charg_toggle = true
		Prowler1_CheckButton5Text:SetText("Bear & Charge")
		Prowler1_CheckButton5Text:SetTextColor(0,1,0)
	else
		charg_toggle = false
		Prowler1_CheckButton5Text:SetText("Only Bear")
		Prowler1_CheckButton5Text:SetTextColor(1,0,0)
	end
end

function Prowler_InitSlider1(slider,num)
	sl = getglobal(slider)
	if (sl:GetName() == "Prowler1_Slider1") then
		sl.tooltipText = "Set the Main Actionbar";
	elseif (sl:GetName() == "Prowler1_Slider2") then
		sl.tooltipText = "Set the Prowl Actionbar";
	end
	getglobal(slider .. "Low"):SetText("1");
	getglobal(slider .. "High"):SetText("7");
	getglobal(sl:GetName()):SetValue(num);
	getglobal(slider .. "Text"):SetText(sl:GetValue());
end

function Prowler_InitSlider2(slider,num)
	sl = getglobal(slider)
	if (sl:GetName() == "Prowler1_Slider3") then
		sl.tooltipText = "Set how the Cat Keybind will work";
	end
	getglobal(slider .. "Low"):SetText("");
	getglobal(slider .. "High"):SetText("");
	getglobal(sl:GetName()):SetValue(num);
	if (cat_mode == 1) then
		getglobal(sl:GetName().."Text"):SetText("Cat Only");
	elseif (cat_mode == 2) then
		getglobal(sl:GetName().."Text"):SetText("Prowl Only");
	elseif (cat_mode == 3) then
		getglobal(sl:GetName().."Text"):SetText("Prowl and Unprowl");
	end
end
function Prowler_InitSlider3(slider,num)
	sl = getglobal(slider)
	if (sl:GetName() == "Prowler1_Slider4") then
		sl.tooltipText = "Set when Track Humans will be activated (Need to be Prowling)";
	end
	getglobal(slider .. "Low"):SetText("");
	getglobal(slider .. "High"):SetText("");
	getglobal(sl:GetName()):SetValue(num);
	if (track_mode == 1) then
		getglobal(this:GetName().."Text"):SetText("Never Track");
	elseif (track_mode == 2) then
		getglobal(this:GetName().."Text"):SetText("Out of Combat");
	elseif (track_mode == 3) then
		getglobal(this:GetName().."Text"):SetText("Anytime");
	end
end

function Prowler_Prowl()
	if CurrentForm() == string.lower(Cat) then
		if (cat_mode == 2) then
			if (GetSpellCooldown(prowl_id,1) == 0) then
				if (not FindProwl()) then
					CastSpell(prowl_id,1)
				else 
					if (track_mode == 2) then
						if (not FindTrackHumans()) and (not UnitAffectingCombat("player")) then
							CastSpell(track_id,1)
						end
					elseif (track_mode == 3) then
						if (not FindTrackHumans()) then
							CastSpell(track_id,1)
						end
					end
				end
			end
		elseif (cat_mode == 3) then
			if (GetSpellCooldown(prowl_id,1) == 0) then
				if (not FindProwl()) then
					CastSpell(prowl_id,1)
				else
					if (track_mode == 2) and (not FindTrackHumans()) and (not UnitAffectingCombat("player")) then
						CastSpell(track_id,1)
					elseif (track_mode == 3) and (not FindTrackHumans()) then
						CastSpell(track_id,1)
					else
						CastSpell(prowl_id,1)
					end
				end
			end
		end
	else
		Shapeshift(Cat)
	end
end

function Prowler_Bear()
	if CurrentForm() == string.lower(Bear) then
		if (charg_id ~= -1) then
			if (GetSpellCooldown(charg_id,1) == 0) and (charg_toggle == true) then
				CastSpell(charg_id,1)
			end
		end
	else
		Shapeshift(Bear)
	end
end

function Shapeshift(form)
	local i = 1
	local thing
	form = string.lower(form)
	local current = string.lower(CurrentForm())
	if (UnitIsMounted("player")) then
		Dismount()
	else
		if (not string.find(current,form)) then
			if (CurrentForm() == Human) then
				thing = SearchForm(form)
				if (thing ~= 0) then 
					CastShapeshiftForm(thing)
				else
					Prowl_Print(form .. ' not found')
				end
			else
				CastShapeshiftForm(SearchForm(CurrentForm()))
			end
		end
	end
end
		
function Prowler_BestForm()
	if (MirrorTimer1:IsVisible()) then
		if (CurrentForm() ~= Aqua) then
			Shapeshift(Aqua)
		end
	else
		if (CurrentForm() ~= Travel) then
			Shapeshift(Travel)
		end
	end
end

local function Shapeshifted()
	local active = string.lower(ActiveForm())
	local bear = string.lower(Bear)
	local current = string.lower(CurrentForm())
	if (GetLocale() == 'frFR') then
		if string.find(bear, active) then
			active = bear
		end
	else
		if string.find(active, bear) then
			active = bear
		end
	end
	
	if (active ~= current) then
		return true
	else
		return false
	end
end

function Prowler_OnEvent(arg1)
	if (event == 'VARIABLES_LOADED') then
		if (not main_ab) then
			main_ab = 1
		end
		if (not prowl_ab) then
			prowl_ab = 2
		end
		if (not locked) then
			locked = 1
		end
		if (not prev) then
			prev = false;
		end
		if (not MA_toggle) then
			MA_toggle = false
		end
		if (not charg_toggle) then
			charg_toggle = true
		end
		if (not cat_mode) then
			cat_mode = 3
		end
		if (not track_mode) then
			track_mode = 1
		end
		prev_ab = main_ab
		Prowler_InitSlider1("Prowler1_Slider1",main_ab);
		Prowler_InitSlider1("Prowler1_Slider2",prowl_ab);
		Prowler_InitSlider2("Prowler1_Slider3",cat_mode);
		Prowler_InitSlider3("Prowler1_Slider4",track_mode);
		if (locked == 1) then
			Prowler1.isLocked = 1;
			Prowler1_CheckButton2Text:SetText("Prowler Locked")
			Prowler1_CheckButton2Text:SetTextColor(0,1,0)
		else
			Prowler1.isLocked = 0;
			Prowler1_CheckButton2Text:SetText("Prowler Unlocked")
			Prowler1_CheckButton2Text:SetTextColor(1,0,0)
		end
		if (prev == true) then
			Prowler1_CheckButton3Text:SetText("Using Last AB")
			Prowler1_CheckButton3Text:SetTextColor(0,1,0)
		else
			Prowler1_CheckButton3Text:SetText("Using Main AB")
			Prowler1_CheckButton3Text:SetTextColor(1,0,0)
		end
		if (toggle == true) then
			Prowler1_CheckButton1Text:SetText("Prowler Enabled")
			Prowler1_CheckButton1Text:SetTextColor(0,1,0)
		else
			Prowler1_CheckButton1Text:SetText("Prowler Disabled")
			Prowler1_CheckButton1Text:SetTextColor(1,0,0)
		end
		if (MA_toggle == true) then
			Prowler1_CheckButton4Text:SetText("MoveAnything! Fix on")
			Prowler1_CheckButton4Text:SetTextColor(0,1,0)
		else
			Prowler1_CheckButton4Text:SetText("MoveAnything! Fix off")
			Prowler1_CheckButton4Text:SetTextColor(1,0,0)
		end
		if (charg_toggle == true) then
			Prowler1_CheckButton5Text:SetText("Bear & Charge")
			Prowler1_CheckButton5Text:SetTextColor(0,1,0)
		else
			Prowler1_CheckButton5Text:SetText("Bear Only")
			Prowler1_CheckButton5Text:SetTextColor(1,0,0)
		end

		Prowler1_CheckButton1:SetChecked(toggle);
		Prowler1_CheckButton2:SetChecked(locked);
		Prowler1_CheckButton3:SetChecked(prev);
		Prowler1_CheckButton4:SetChecked(MA_toggle);
		Prowler1_CheckButton5:SetChecked(charg_toggle);
		Prowl_Print('Prowler Loaded. Main bar = ' .. main_ab .. ' Prowling bar = ' .. prowl_ab)
	end
	if (event == 'PLAYER_AURAS_CHANGED') then
		num_buff_1 = GetNumBuffs()
		if (num_buff_1 == num_buff_2) then
			buffed = true
		end
		if (Shapeshifted() == true) then
			Update_Forms_Table()
			shifted = true
			if (CurrentForm() == string.lower(Cat)) or (CurrentForm() == string.lower(Bear)) then
				prev_ab = CURRENT_ACTIONBAR_PAGE
			end
		end
		if (toggle == true) then
			if (CurrentForm() == string.lower(Cat)) then
				if (FindProwl()) then
					if (CURRENT_ACTIONBAR_PAGE ~= prowl_ab) then
						CURRENT_ACTIONBAR_PAGE = prowl_ab;
						ChangeActionBarPage();
					end
				else
					if (CURRENT_ACTIONBAR_PAGE ~= 1) then
						CURRENT_ACTIONBAR_PAGE = 1;
						ChangeActionBarPage();
					end
				end
			elseif (CurrentForm() == Human) then
				if (prev == true) then
					if (CURRENT_ACTIONBAR_PAGE ~= prev_ab) and (shifted) then
						CURRENT_ACTIONBAR_PAGE = prev_ab;
						ChangeActionBarPage();
					end
				else
					if (CURRENT_ACTIONBAR_PAGE ~= main_ab) and (shifted) then
						CURRENT_ACTIONBAR_PAGE = main_ab;
						ChangeActionBarPage();
					end
				end
				if (MA_toggle == true) and buffed then
					ChangeActionBarPage()
				end
				shifted = false
			elseif (CurrentForm() == string.lower(Bear)) then
				if (CURRENT_ACTIONBAR_PAGE ~= 1) then
					CURRENT_ACTIONBAR_PAGE = 1;
					ChangeActionBarPage();
				end
			end
		end
		num_buff_2 = GetNumBuffs()
		buffed = false
	end
	if (event == 'SPELLS_CHANGED') then
		maxspells = MaxSpells();
		prowl_id = SearchBestSpell(Prowl);
		charg_id = SearchBestSpell(Charg);
		track_id = SearchBestSpell(Track);
		Create_Forms_Table()
		Update_Forms_Table()
	end
end

function Prowler_Cmd(msg)
	local frame = getglobal("Prowler1")
	if (frame) then
		if(  frame:IsVisible() ) then
			frame:Hide();
		else
			frame:Show();
		end
	end
end