--[[
	I want to go a lot further with voting so this gets it's own file.
	For now (1.5.beta.1) it's just the stuff needed for a SyncReset vote
	Some things might seem like overkill, but as said, i want to go further with this :P
	
	Note to self:
	using meta tables like in SM_CVVote i could easly store "objects" and make them persistant
	just make sure to add metatables again in VARIABLES_LOADED, could be interesting  when making the
	parsing engine its own mod to use for other mods.
	
--]]

SW_VTL = 0;
SW_VTB = 60; -- buffer in secs to avoid people spamming votes

SW_ActiveVotes = {};
	
SW_CVote = 
{
	new = function (self, o)
		o = o or {};
		setmetatable(o, self);
		self.__index = self;
		return o;
	end,
	
	newIVData = function (self, data, from)
		o = {};
		setmetatable(o, self);
		self.__index = self;
		o.issuedBy = from;
		o:InitFromData(data);
		return o;
	end,
	InitFromData = function (self, data)
		self.vID = data[1];
		self.totalRun = tonumber(data[2]);
		self.sID = data[3];
		self.question = SW_SyncQueue:DecStr(data[4]);
		self.answerCount = tonumber(data[5]);
		self.extraData = {};
		self.timeRunning = 0;
		self.onDoneCalled = false;
		self.onHideGUICalled = false;
		
		for i=6, table.getn(data) do 
			table.insert(self.extraData, data[i]);
		end
		self:initSpecial();
	end,
	
	initSpecial = function (self)
		local LIs = SW_SyncGetLIs();
		if self.sID == "SWRV" then
			self.question = string.format(SW_STR_RV, self.issuedBy);
			self.answerCount = 2;
			self.answers = {YES,NO};
			
			local points =0;
			local peers = LIs["SW_PC"];
			local tmp = 0;
			for k,v in pairs(LIs) do
				
				if SW_Friends[k] ~= nil and SW_Friends[k]["Rank"] ~= nil then
					if SW_Friends[k]["Rank"] == 2 then
						v = peers * 100;
					elseif SW_Friends[k]["Rank"] == 1 then
						v = peers * 10;
					else
						v=1;
					end
					LIs[k] = v;
					points = points + v;
				end
			end
			self.availablePoints = points;
			self.pointLookup = LIs;
			self.OnDone = SW_ResetVoteDone;
			self.OnHideGUI = SW_ResetVoteHideGUI;
		else
			self.answers = {};
			self.availablePoints = LIs["SW_PC"];
			self.pointLookup = LIs;
		end
		self.results = {};
		self.hasAnswered = {};
		self.currentPoints = 0;
		
		if self.sID == "SWRV" then
			StaticPopupDialogs["SW_ResetSyncVote"]["text"] = self.question;
			StaticPopupDialogs["SW_ResetSyncVote"]["vID"] = self.vID;
			StaticPopup_Show("SW_ResetSyncVote");
		end
	end,
	addVote = function (self, i, from)
		-- stop double answers
		if self.hasAnswered[from] == nil then
			self.hasAnswered[from] = true;
		else
			return;
		end
		local index = tonumber(i);
		if self.results[index] == nil then
			self.results[index] = 0;
		end
		
		if self.pointLookup[from] ~= nil then
			self.results[index] = self.results[index] + self.pointLookup[from];
			self.currentPoints = self.currentPoints + self.pointLookup[from];
		end
	end,
	
	addAnswer = function (self, i, aStr)
		local index = tonumber(i);
		if index <= self.answerCount then
			self.answers[index] = SW_SyncQueue:DecStr(aStr);
		end
	end,
	--called to see if this vote can safely be deleted
	expired = function (self)
		-- when we delete it isn't to important so just give 
		-- any "stuff" enough time to finish
		if self.timeRunning > 2* self.totalRun then
			return true;
		end
		return false;
	end,
	
	updateTimePassed = function (self, sec)
		self.timeRunning = self.timeRunning + sec;
		
		
		if self.timeRunning > self.totalRun + 5 then -- add a little buffer for the last answers to arrive
			if self.OnDone ~= nil and not self.onDoneCalled then
				self.OnDone(self);
				self.onDoneCalled = true;
			end
		elseif self.timeRunning > self.totalRun then
			if self.OnHideGUI ~= nil and not self.onHideGUICalled then
				self.OnHideGUI(self);
				self.onHideGUICalled = true;
			end
		elseif self.sID == "SWRV" then
			-- we arent interested in the "real" result, just if it is over 50%
			if self.currentPoints * 2 > self.availablePoints then
				if self.OnHideGUI ~= nil and not self.onHideGUICalled then
					self.OnHideGUI(self);
					self.onHideGUICalled = true;
				end
				if self.OnDone ~= nil and not self.onDoneCalled then
					self.OnDone(self);
					self.onDoneCalled = true;
				end
			end
		end
	end,
	AnswerVal = function (self, questionNr)
		if self.results[questionNr] == nil then 
			return 0;
		else
			return self.results[questionNr];
		end
	end,
	dumpData = function (self)
		SW_DumpTable(self);
	end,
	
};

function SW_DumpVotes()
	for k,v in pairs(SW_ActiveVotes) do
		v:dumpData();
	end
end
function SW_UpdateVoteTimers(elapsed)
	local expIDs = {};
	for k,v in pairs(SW_ActiveVotes) do
		v:updateTimePassed(elapsed);
		if v:expired() then
			table.insert(expIDs, v.vID);
		end
	end
	for i,v in ipairs(expIDs) do
		SW_ActiveVotes[v] = nil;
	end
end
function SW_SyncVoteAnswer(data, from)
	local vID = data[1];
	
	if SW_ActiveVotes[vID] ~= nil then
		SW_ActiveVotes[vID]:addVote(data[2], from);
	else
		SW_printStr("SW_SyncVoteAnswer vID not defined, can't add vote");
	end
end

function SW_SyncIssuedVote(data, from)
	local vID = data[1];
	
	if SW_ActiveVotes[vID] == nil then
		SW_ActiveVotes[vID] = SW_CVote:newIVData(data, from);
	else
		SW_printStr("SW_SyncIssuedVote vID in use?!?.");
	end
end
function SW_SyncIssuedVoteAnswer(data, from)
	local vID = data[1];
	
	if SW_ActiveVotes[vID] ~= nil then
		SW_ActiveVotes[vID]:addAnswer(data[2], data[3]);
	else
		SW_printStr("SW_SyncIssuedVoteAnswer vID not defined, can't add answer");
	end
end
function SW_SendVote(question, runS, answers, data, specialID)
	if  (time() - SW_VTL) < SW_VTB then
		DEFAULT_CHAT_FRAME:AddMessage(SW_STR_VOTE_WARN);
		return;
	end
	SW_VTL = time();
	
	local vID = date("%H%M%S"..SW_SELF_STRING);
	local ID = "N";
	if specialID ~= nil then
		ID = specialID;
	end
	local seconds;
	if runS == nil then
		seconds = 30;
	else
		seconds = tonumber(runS);
		if seconds < 15 then
			seconds = 15;
		end
	end
	local request = {};
	table.insert(request, vID);
	table.insert(request, seconds);
	table.insert(request, ID);
	if question == nil or type(question) ~= "string" then
		table.insert(request, "Q");
	else
		table.insert(request, SW_SyncQueue:EncStr(question));
	end
	if type(answers) == "table" then
		table.insert(request, table.getn(answers));
	else
		table.insert(request, 0);
	end
	
	if type(data) == "table" then
		for i,v in ipairs(data) do
			table.insert(request, SW_SyncQueue:EncStr(v));
		end
	end
	
	-- hmm 255 char limit, ok for now but dont forget later on
	SW_SyncQueue:PushSWInfo("IV", request);
	
	if type(answers) == "table" then
		for i,v in ipairs(answers) do
			-- hmm 255 char limit, ok for now but dont forget later on
			SW_SyncQueue:PushSWInfo("IVA", {vID,i,SW_SyncQueue:EncStr(v),math.random(100)});
		end
	end
end

function SW_ResetVote()
	SW_RebuildFriendList();
	SW_SendVote(nil, nil, nil,nil,"SWRV");
	--SW_SendVote("My question~%+??",43,{'answer"1"', "answer~2"},{"data1",2},"N");
end
function SW_ResetVoteHideGUI(vote)
	StaticPopup_Hide("SW_ResetSyncVote");
end
function SW_ResetVoteDone(vote)
	StaticPopup_Hide("SW_ResetSyncVote");
	if vote:AnswerVal(1) > vote:AnswerVal(2) then
		--SW_SyncReset(newSessID, issuedBy, selfForce)
		SW_SyncReset(nil, nil, true);
		DEFAULT_CHAT_FRAME:AddMessage(SW_STR_RV_PASSED);
	else
		DEFAULT_CHAT_FRAME:AddMessage(SW_STR_RV_FAILED);
	end
	
end
	