--<< ================================================= >>--
-- Section I: The Global Functions.	                     --
--<< ================================================= >>--

ace:RegisterFunctions(Timex, {
	version	= 1.0,

    ExecuteChatCommand = function(...)
        if not DEFAULT_CHAT_FRAME then return; end
        DEFAULT_CHAT_FRAME.editBox:SetText(ace.concat(arg));
        ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox);
    end,

	ParseByName41 = function(i, p, s, q)
		local tmpDB = {};
		p, s, q = p or "=", s or " ", q or "\"";
		i = i..s;
		string.gsub(i, "(%a[%a%d_]-)"..p.."("..q.."?)(.-)%2"..s, function(k, _,  v) tmpDB[k] = string.gsub(v, "\\"..s, s) end);
		return tmpDB;
	end
})

--<< ================================================= >>--
-- Section II: The Chat Options.                         --
--<< ================================================= >>--

local function processArgs(args)
	local a = {};
	for word in string.gfind(args, "%S+") do
		tinsert(a, word);
	end
	return a;
end

function Timex:ChatExecute(i)
	local p = self.ParseByName41(i);
	if not p.f or not p.t then
		self.cmd:result(TimexLocals.Chat_BadValues);
		return;
	end
	p.a = "/script "..p.f.."("..(p.a or "")..")";
	p.f = Timex.ExecuteChatCommand;
	self:AddSchedule(p.n, p.t, p.r, p.c, p.f, p.a);
	self.cmd:result(TimexLocals.Chat_Execute);
end

function Timex:ChatDelete(args)
	args = processArgs(args);
	local i = args[2];
	if not Timex:ScheduleCheck(i) then
		self.cmd:result(format(TimexLocals.Chat_BadDelete, i));
		return;
	end
	Timex:DeleteSchedule(i);
	self.cmd:result(format(TimexLocals.Chat_Delete, i));
end

function Timex:ChatAddTimer(args)
	args = processArgs(args);
	local id = args[2];
	self:AddTimer(id);
	self.cmd:msg("Added timer: %s", tostring(id));
end

function Timex:ChatDeleteTimer(args)
	args = processArgs(args);
	local id = args[2];
	local time, start, now = self:DeleteTimer(id);
	self.cmd:msg("%s: time = %s, start = %s, now = %s", tostring(id), tostring(time), tostring(start), tostring(now));
end

function Timex:ChatGetTimer(args)
	args = processArgs(args);
	local id = args[2];
	local time, start, now = self:GetTimer(id);
	self.cmd:msg("%s: time = %s, start = %s, now = %s", tostring(id), tostring(time), tostring(start), tostring(now));
end

function Timex:ChatCheckTimer(args)
	args = processArgs(args);
	local id = args[2];
	local found = self:CheckTimer(id);
	if found then
		self.cmd:msg("%s: found", tostring(id));
	else
		self.cmd:msg("%s: not found", tostring(id));
	end
end

--<< ================================================= >>--
-- Section Omega: Register the AddOn Object.             --
--<< ================================================= >>--
