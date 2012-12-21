if (not Nurfed_CombatLog) then

	local utility = Nurfed_Utility:New();
	local unitlib = Nurfed_Units:New();
	local options = Nurfed_Options:New();

	Nurfed_CombatLog = {};

	Nurfed_CombatLog.index = {
		Heal = 2,
		Hit = 3,
		Spell = 4,
		Dot = 5,
		SpellMiss = 6,
		Environment = 7,
		PowerGain = 8,
		Debuff = 9,
		Buff = 10,
		AuraFade = 11,
		MeleeMiss = 12,
		Resist = 13,
		SpellFail = 14,
		Cast = 15,
		Perform = 16,
	};

	Nurfed_CombatLog.events = {
		["AURA"] = { "Aura" },
		["BUFF"] = { "Heal", "Hot", "Dot", "Aura", "Cast", "Perform", "SpellMiss", "SpellFail", "Resists" },
		["HITS"] = { "Hit", "Env" },
		["MISSES"] = { "Miss" },
		["DAMAGE"] = { "Spell", "Dot", "Aura", "Resists", "SpellMiss", "SpellFail", "Cast", "Perform" },
		["DEATH"] = { "Death" },
	};

	function Nurfed_CombatLog:New()
		local object = {};
		setmetatable(object, self);
		self.__index = self;
		return object;
	end

	function Nurfed_CombatLog:Init()
		for _, event in Nurfed_CombatLog_Strings do
			for _, v in event do
				v.s = utility:FormatGS(v.s, true);
			end
		end

		for _, v in Nurfed_CombatLog_Trailers do
			v.s = utility:FormatGS(v.s);
		end
	end

	function Nurfed_CombatLog:ParseEvent(event, arg1)
		local eventtable, result, out, outtype;

		for e, t in self.events do
			if (string.find(event, e, 1, true)) then
				eventtable = t;
				break;
			end
		end

		if (eventtable) then
			local found;
			for _, v in eventtable do
				for _, text in Nurfed_CombatLog_Strings[v] do
					if (string.find(arg1, text.s)) then
						result = {string.find(arg1, text.s)};
						out = text.o;
						outtype = text.t;
						found = true;
						break;
					end
				end
				if (found) then
					break;
				end
			end
		end

		if (result and out) then
			local args = {};
			for k, v in out do
				if (type(v) == "number") then
					args[k] = string.gsub(result[v + 2], "^%l", string.upper);
				else
					args[k] = v;
				end
			end
			self:Output(args, outtype, arg1);
		end
	end

	function Nurfed_CombatLog:ParseTrailer(text, damage)
		damage = tonumber(damage);
		local totaldamage = damage;
		local totalreduction = 0;
		local i, start, value, reduced, trailer;
		for i = 1, 3 do
			start, _, value = string.find(text, Nurfed_CombatLog_Trailers[i].s);
			if (start ~= nil) then
				reduced = tonumber(value);
				totaldamage = totaldamage + reduced;
				totalreduction = totalreduction + reduced;
				value = self:FormatRGB(MISS)..value.."|r";
				if (trailer) then
					trailer = trailer..", "..Nurfed_CombatLog_Trailers[i].o..value.."|r";
				else
					trailer = Nurfed_CombatLog_Trailers[i].o..value.."|r";
				end
			end
		end

		if (totalreduction > 0) then
			totalreduction = self:FormatRGB(MISS)..tostring(totalreduction).."|r";
			totaldamage = self:FormatRGB("damage")..tostring(totaldamage).."|r";
			trailer = "("..trailer.."; "..totalreduction.."|r/"..totaldamage.."|r)";
		end

		if (string.find(text, CRUSHING_TRAILER, 1, true)) then
			if (trailer) then
				trailer = trailer.."|cffff0000"..CRUSHING_TRAILER.."|r";
			else
				trailer = "|cffff0000"..CRUSHING_TRAILER.."|r";
			end
		end

		if (string.find(text, GLANCING_TRAILER, 1, true)) then
			if (trailer) then
				trailer = trailer.."|cffffff00"..GLANCING_TRAILER.."|r";
			else
				trailer = "|cffffff00"..GLANCING_TRAILER.."|r";
			end
		end
		return trailer;
	end

	function Nurfed_CombatLog:FormatRGB(option, crit)
		local info = options:GetOption("combatlog", option);
		if (not info) then
			return "|cffffffff";
		end
		local r, g, b;
		if (crit) then
			local overlay = options:GetOption("combatlog", "overlay");
			r = (info[1]/2) + (overlay[1]/2);
			g = (info[2]/2) + (overlay[2]/2);
			b = (info[3]/2) + (overlay[3]/2);
		else
			r = info[1];
			g = info[2];
			b = info[3];
		end
		return string.format("|cff%02x%02x%02x", (r*255), (g*255), (b*255));
	end

	function Nurfed_CombatLog:FormatName(name, option, t, noformat)
		if (not name) then
			return nil;
		end

		local unit;
		local out = {};
		local format = options:GetOption("combatlog", option);
		local watches = options:GetOption("combatlog", "watches");

		if (name == YOU) then
			unit = "You";
		elseif (UnitExists("pet") and name == UnitName("pet")) then
			unit = "Pet";
		else
			local info = unitlib:GetUnit(name);
			if (info) then
				unit = info.t;
			else
				unit = "Enemy";
			end
		end

		local index = self.index[t];

		if (t ~= "Death") then
			if (watches[name] and watches[name][index] == 1) then
				table.insert(out, watches[name][1]);
			end
			if (watches[unit] and watches[unit][index] == 1) then
				table.insert(out, watches[unit][1]);
			end
			if (UnitExists("target") and name == UnitName("target") and watches["Target"] and watches["Target"][index] == 1) then
				table.insert(out, watches["Target"][1]);
			end
		end
		name = self:FormatRGB(unit)..name.."|r";
		if (not noformat) then
			name = string.gsub(format, "$n", name);
		end
		return name, out;
	end

	function Nurfed_CombatLog:Output(vars, t, text)
		local source, spell, target, amount, damagetype, trailer, out1, out2, format;
		local out = {};
		local sent = {};
		if (t == "Heal" or t == "Hit" or t == "Spell" or t == "Dot" or t == "SpellMiss") then
			source, out1 = self:FormatName(vars[1], "source", t);
			target, out2 = self:FormatName(vars[3], "target", t);

			if (not out1 and not out2) then
				return;
			end

			spell = self:FormatRGB(vars[5])..vars[2].."|r";
			if (vars[5] == "Heal") then
				amount = self:FormatRGB("Heal", vars[6]).."+"..vars[4].."|r";
			else
				amount = self:FormatRGB("damage", vars[6])..vars[4].."|r";
			end

			if (string.find(vars[4], "[1-9]") and t ~= "Heal") then
				trailer = self:ParseTrailer(text, vars[4]);
			end

			if (vars[6]) then
				format = options:GetOption("combatlog", "crit");
				amount = string.gsub(format, "$d", amount);
				spell = spell.." Crit";
			end

			table.insert(out, source);
			table.insert(out, spell);
			table.insert(out, target);
			table.insert(out, amount);
			if (trailer) then
				table.insert(out, trailer);
			end
		elseif (t == "Environment") then
			target, out1 = self:FormatName(vars[1], "target", t);

			if (not out1) then
				return;
			end

			spell = self:FormatRGB(vars[4])..vars[2].."|r";
			amount = self:FormatRGB("damage")..vars[3].."|r";

			if (string.find(vars[3], "[1-9]")) then
				trailer = self:ParseTrailer(text, vars[3]);
			end

			table.insert(out, target);
			table.insert(out, spell);
			table.insert(out, amount);
			if (trailer) then
				table.insert(out, trailer);
			end
		elseif (t == "Death" or t == "Destroyed") then
			local deathout = options:GetOption("combatlog", "deathout");
			if (deathout == 0) then
				return;
			end
			target = self:FormatName(vars[1], "target", t, true);
			source = self:FormatName(vars[3], "source", t, true);

			if (t == "Destroyed") then
				local destroyed = options:GetOption("combatlog", "destroyed");
				if (destroyed ~= 1) then
					return;
				end
			end
			out1 = { deathout };
			spell = vars[2];

			format = options:GetOption("combatlog", "death");
			target = string.gsub(format, "$n", target);

			table.insert(out, target);
			table.insert(out, spell);
			if (source) then
				table.insert(out, "("..source..")");
			end
		elseif (t == "PowerGain") then
			target, out1 = self:FormatName(vars[1], "target", t);
			if (not out1) then
				return;
			end
			local color = self:FormatRGB(vars[3]);
			amount = color..vars[2].." "..vars[3].."|r".." ("..color..vars[4].."|r)";


			table.insert(out, target);
			table.insert(out, amount);
		elseif (t == "Debuff") then
			target, out1 = self:FormatName(vars[1], "target", t);
			if (not out1) then
				return;
			end
			spell = vars[2].." "..self:FormatRGB("debuff")..vars[3].."|r";

			table.insert(out, target);
			table.insert(out, spell);
		elseif (t == "Buff") then
			target, out1 = self:FormatName(vars[1], "target", t);
			if (not out1) then
				return;
			end
			spell = vars[2].." "..self:FormatRGB("buff")..vars[3].."|r";

			table.insert(out, target);
			table.insert(out, spell);
		elseif (t == "AuraFade") then
			target, out1 = self:FormatName(vars[1], "target", t);
			if (not out1) then
				return;
			end
			spell = self:FormatRGB("buff")..vars[2].."|r "..vars[3];

			table.insert(out, target);
			table.insert(out, spell);
		elseif (t == "MeleeMiss") then
			source, out1 = self:FormatName(vars[1], "source", t);
			target, out2 = self:FormatName(vars[3], "target", t);

			if (not out1 and not out2) then
				return;
			end
			spell = self:FormatRGB(MISS)..vars[2].."|r";

			table.insert(out, source);
			table.insert(out, spell);
			table.insert(out, target);
		elseif (t == "Resist" or t == "SpellFail") then
			source, out1 = self:FormatName(vars[1], "source", t);
			target, out2 = self:FormatName(vars[3], "target", t);

			if (not out1 and not out2) then
				return;
			end
			spell = vars[2];
			amount = self:FormatRGB(MISS)..vars[4].."|r";

			table.insert(out, source);
			table.insert(out, spell);
			table.insert(out, target);
			table.insert(out, amount);
		elseif (t == "Cast" or t == "Perform") then
			local casted;
			if (t == "Cast") then
				casted = true;
			end
			source, out1 = self:FormatName(vars[1], "source", t, casted);
			target, out2 = self:FormatName(vars[3], "target", t, casted);

			if (not out1 and not out2) then
				return;
			end

			spell = self:FormatRGB("cast")..vars[2].."|r";
			if (casted) then
				format = options:GetOption("combatlog", "spellalert");
				spell = string.gsub(format, "$s", spell);
			end

			table.insert(out, source);
			table.insert(out, spell);
			if (target) then
				table.insert(out, target);
			end
		end

		if (out1) then
			for k, v in out1 do
				if (not sent[v]) then
					utility:Print(table.concat(out, " "), v);
					sent[v] = true;
				end
			end
		end
		if (out2) then
			for k, v in out2 do
				if (not sent[v]) then
					utility:Print(table.concat(out, " "), v);
					sent[v] = true;
				end
			end
		end
	end
end