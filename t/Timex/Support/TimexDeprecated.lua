--<< ================================================= >>--
-- Section I: Timex deprecated methods.                  --
--<< ================================================= >>--
function Timex:AddNamedSchedule(n, t, r, c, f, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
	return self:AddSchedule(n, t, r, c, f, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20);
end

function Timex:NamedScheduleCheck(n, r)
	return self:ScheduleCheck(n, r);
end

function Timex:ScheduleCheck(n, r)
	return self:CheckSchedule(n, r);
end

function Timex:DeleteNamedSchedule(n)
	return self:DeleteSchedule(n);
end

function Timex:ChangeDuration(id, t)
	self:ChangeScheduleDuration(id, t);
end

--<< ================================================= >>--
-- Section II: TimexBar deprecated methods               --
--<< ================================================= >>--

-- legacy support: 
-- R21:  TimexBar:StartBar(i  , c  , tc, a, s  , f, tex)
-- R22:  TimexBar:StartBar(txt, tmr, r , g, blu, x, y  , pr, a1, a2, re, tex)
function TimexBar:StartBar(i  , c  , tc, a, s  , f, tex, pr, a1, a2, re, tex21)
	if i then
		-- R21 support
		if type(i) == "string" or type(i) == "number" then
			if not c or i == "" then return end
			self:Get(i);
			self:SetText(i, i);
			self:SetTexture(i, tex21);
			self:SetColor(i, tc, a, s);
			self:SetPoint(i, a1, pr, a2, f, tex);
			return self:Start(i, c, re);
		-- R22 support
		elseif type(i) == "table" then
			local id = i[1];
			self:Get(id);
			self:SetText(id, i[2]);
			self:SetTexture(id, tex);
			if c then
				self:SetColor(id, c[1], c[2], c[3], c[4]);
			end
			if a then
				self:SetPoint(id, a[4], a[3], a[5], a[1], a[2]);
			end
			if tc then
				self:SetTextColor(id, tc[1], tc[2], tc[3], tc[4]);
			end
			if s then
				self:SetScale(id, s[1]);
				self:SetWidth(id, s[2]);
				self:SetHeight(id, s[3]);
				self:SetTimeWidth(id, s[4]);
			end
			if f then
				self:SetFunction(id, f[1], unpack(f[2] or EMPTY_TABLE));
			end
			return self:Start(id, i[3], i[4]);
		else
			-- if you see this error you should be updating to the new methods
			error("Illegal arguments passed to deprecated TimexBar:StartBar method.");
		end
	end
end

function TimexBar:StopBar(id)
	self:Stop(id);
end

function TimexBar:CheckBar(id, r)
	return self:Check(id, r);
end
