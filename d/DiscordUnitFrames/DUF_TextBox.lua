function DUF_TextBox_OnEvent(event)
	if (not DUF_INITIALIZED) then return; end
	if (event and string.find(event, "UNIT_")) then
		if (arg1 ~= this:GetParent().unit) then return; end
	end

	if (event == "UNIT_COMBAT") then
		this.damagetext = "";
		this.healtext = "";
		if( arg2 == "IMMUNE" ) then
			this.damagetext= "|cFFFFFF00"..CombatFeedbackText["IMMUNE"];
		elseif ( arg2 == "WOUND" ) then
			if ( arg3 == "ABSORB" )then
				this.damagetext= "|cFFFFFFFF"..TEXT(ABSORB);
			elseif ( arg4 ~= 0 ) then
				if ( arg3 == "CRITICAL" ) then
					this.damagetext= "|cFFFF00FF"..DUF_TEXT.Crit.."|cFFFF0000".."-"..arg4;
				end
				this.damagetext= "|cFFFF0000".."-"..arg4;
			else
				this.damagetext= "|cFFFFFF00"..CombatFeedbackText["MISS"];
			end
		elseif ( arg2 == "BLOCK" ) then
			this.damagetext= "|cFFFFFF00"..TEXT(BLOCK);
		elseif ( arg2 == "HEAL" ) then
			this.healtext= "|cFF00FF00".."+"..arg4;
			if ( arg3 == "CRITICAL" ) then
				this.healtext= "|cFFFF00FF"..DUF_TEXT.Crit.."|cFF00FF00".."+"..arg4;
			end
		else
			this.damagetext= CombatFeedbackText[arg2];
		end
		this.combattexttimer = 1.5;
	elseif (event == "UNIT_HEALTH") then
		local health = UnitHealth(this:GetParent().unit);
		if (not this.lasthealth) then
			this.lasthealth = health;
		end
		local gain = health - this.lasthealth;
		if (health == UnitHealthMax(this:GetParent().unit) or (not DL_REGEN)) then
			this.healthregen = 0;
			this.healthregentick = 0;
			this.healthtable = nil;
		elseif (gain > 0) then
			this.healthregentick = gain;
			
			if (not this.healthtable) then
				this.healthtable = {};
				local time = GetTime();
				for i=1,4 do
					this.healthtable[i] = { v=0, t=time };
				end
				this.healthtable[5] = { v=gain, t=time };
			else
				for i=1,4 do
					this.healthtable[i].v = this.healthtable[i + 1].v;
					this.healthtable[i].t = this.healthtable[i + 1].t;
				end
				this.healthtable[5].v = gain;
				this.healthtable[5].t = GetTime();
			end

			local totalhealth = 0;
			for i=1,5 do
				totalhealth = totalhealth + this.healthtable[5].v;
			end
			local seconds = (GetTime() - this.healthtable[1].t);
			if (seconds == 0) then
				this.healthregen = 0;
			else
				this.healthregen = math.floor(totalhealth / seconds * 10) / 10;
			end
		end
		this.lasthealth = health;
	elseif (event == "UNIT_MANA" or event == "UNIT_RAGE" or event == "UNIT_ENERGY" or event == "UNIT_FOCUS") then
		local mana = UnitMana(this:GetParent().unit);
		if (not mana) then mana = 0 end
		if (not this.lastmana) then
			this.lastmana = mana;
		end
		local gain = mana - this.lastmana;
		if (mana == UnitManaMax(this:GetParent().unit)) then
			this.manaregen = 0;
			this.manaregentick = 0;
			this.manatable = nil;
		elseif (gain > 0) then
			this.manaregentick = gain;
			
			if (not this.manatable) then
				this.manatable = {};
				local time = GetTime();
				for i=1,4 do
					this.manatable[i] = { v=0, t=time };
				end
				this.manatable[5] = { v=gain, t=time };
			else
				for i=1,4 do
					this.manatable[i].v = this.manatable[i + 1].v;
					this.manatable[i].t = this.manatable[i + 1].t;
				end
				this.manatable[5].v = gain;
				this.manatable[5].t = GetTime();
			end

			local totalmana = 0;
			for i=1,5 do
				totalmana = totalmana + this.manatable[5].v;
			end
			local seconds = (GetTime() - this.manatable[1].t);
			if (seconds == 0) then
				this.manaregen = 0;
			else
				this.manaregen = math.floor(totalmana / seconds * 10) / 10;
			end
		end
		this.lastmana = mana;
	elseif (event == DUF_UNIT_CHANGED_EVENTS[this:GetParent().unit]) then
		DUF_Element_OnShow()
	end
	
	DUF_TextBox_Update();
end

function DUF_TextBox_OnUpdate(elapsed)
	if (not DUF_INITIALIZED) then return; end

	if (this.combattexttimer) then
		this.combattexttimer = this.combattexttimer - elapsed;
		if (this.combattexttimer < 0) then
			this.combattexttimer = nil;
			this.damagetext = "";
			this.healtext = "";
			DUF_TextBox_Update();
		end
	end

	if (this.update) then
		this.update = nil;
		local unit = this:GetParent().unit;
		local updateTextBox;
		if (this.checkname) then
			local name = DL_UnitName(unit.."target");
			if (UnitIsUnit(unit.."target", "player")) then
				name = DUF_TEXT.You;
			elseif (UnitIsUnit(unit.."target", "target")) then
				name = DUF_TEXT.YourTarget;
			end
			if (name ~= this.targetname) then
				this.targetname = name;
				updateTextBox = true;
			end
		end
		if (this.checkhealth) then
			local health = DUF_Get_Health(unit.."target");
			if (health ~= this.targethealth) then
				this.targethealth = health;
				updateTextBox = true;
			end
		end
		if (this.checkhealthmax) then
			local health = DUF_Get_MaxHealth(unit.."target");
			if (health ~= this.targethealthmax) then
				this.targethealthmax = health;
				updateTextBox = true;
			end
		end
		if (this.checkmana) then
			local mana = UnitMana(unit.."target");
			if (this.targetmana ~= mana) then
				this.targetmana = mana;
				updateTextBox=true;
			end
		end
		if (this.checkmanamax) then
			local mana = UnitManaMax(unit.."target");
			if (this.targetmanamax ~= mana) then
				this.targetmanamax = mana;
				updateTextBox=true;
			end
		end
		if (this.checklevel) then
			local level = UnitLevel(unit.."target");
			if (this.targetlevel ~= level) then
				this.targetlevel = level;
				updateTextBox = true;
			end
		end
		if (this.checktype) then
			local ctype;
			if (UnitIsPlayer(unit.."target")) then
				ctype = UnitClass(unit.."target");
			else
				ctype = UnitCreatureType(unit.."target");
			end
			if (ctype ~= this.targettype) then
				this.targettype = ctype;
				updateTextBox = true;
			end
		end
		if (this.checkreaction) then
			local reaction = UnitReaction("player", unit);
			if (reaction ~= this.ttreaction) then
				this.ttreaction = reaction;
				updateTextBox = true;
			end
		end
		if (this.checkoffline) then
			local connected = UnitIsConnected(unit);
			if (connected ~= this.connected) then
				this.connected = connected;
				updateTextBox = true;
			end
		end
		if (this.checkcombat) then
			local ic = UnitAffectingCombat(unit);
			if (ic ~= this.incombat) then
				this.incombat = ic;
				updateTextBox = true;
			end
		end
		if (this.checkpetxp) then
			local min,max = GetPetExperience();
			if (min ~= this.minpetxp or max ~= this.maxpetxp) then
				this.minpetxp = min;
				this.maxpetxp = max;
				updateTextBox = true;
			end
		end
		if (this.checkvisibility) then
			local visibility = UnitIsVisible(unit);
			if (this.visibility ~= visibility) then
				this.visibility = visibility;
				updateTextBox = true;
			end
		end
		if (this.checkcolor) then
			updateTextBox = true;
		end
		if (updateTextBox) then
			DUF_TextBox_Update();
		end
	end
end

function DUF_TextBox_Update()
	local unit = this:GetParent().unit;
	local id = this:GetID();
	local text = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].TextBox[id].text;
	local maxchar = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].TextBox[id].maxcharacters;
	local hideifnotext = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].TextBox[id].hideifnotext;
	local vert = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].TextBox[id].verttext;
	if ((not text) or text == "") then return; end

	if (this.variables) then
		for var in this.variables do
			text = DUF_VARIABLE_FUNCTIONS[var].func(text, unit);
		end
	end
	if (not text) then text = ""; end
	if (maxchar) then
		local numchar = string.len(text);
		local count = 0;
		for i in string.gfind(text, "|c") do
			count = count + 1;
		end
		numchar = numchar - count * 10;
		if (numchar > maxchar) then
			text = string.sub(text, 1, maxchar + count * 10);
		end
	end
	if (vert) then
		text = string.gsub(text, "(.)", function(x) return x.."\n" end);
	end
	getglobal(this:GetName().."_Text"):SetText(text);
	if (hideifnotext) then
		if (text == "") then
			getglobal(this:GetName().."_Background"):SetAlpha(0);
		else
			getglobal(this:GetName().."_Background"):SetAlpha(1);
		end
	end
end