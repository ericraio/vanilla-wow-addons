GUILDADSCOMM_DEBUG = false;		-- Is debug printf enabled?

GUILDADS_MSG_TYPE_ANNONCE = 0;
GUILDADS_MSG_TYPE_REQUEST = 1;
GUILDADS_MSG_TYPE_AVAILABLE = 2;
GUILDADS_MSG_TYPE_SKILL = 3;
GUILDADS_MSG_TYPE_EVENT = 4;
GUILDADS_MSG_TYPE_INVENTORY = 5;
GUILDADS_MSG_TYPE_NOTE = 6;
GUILDADS_MSG_TYPE_EVENT_SUBSCRIPTION = 7;
GUILDADS_MSG_TYPE_IGNORE = "i";

GUILDADS_VERSION_PROTOCOL = "26";

GUILDADS_MSG_PREFIX = "<GA"..GUILDADS_VERSION_PROTOCOL..">";
GUILDADS_MSG_PREFIX_NOVERSION = "<GA";
GUILDADS_MSG_PREFIX_TOKEN = '\29';
GUILDADS_MSG_PREFIX_CHATCOMM = '\29'.."AD"..'\29'..GUILDADS_VERSION_PROTOCOL..'>';

GUILDADS_MSG_ADD = "a";
GUILDADS_MSG_REMOVE = "r";
GUILDADS_MSG_REMOVE_ALL = "R";
GUILDADS_MSG_REQUEST_ADS = "?";
GUILDADS_MSG_REQUEST_INSPECT = "?i";
GUILDADS_MSG_REQUEST_OFFLINES = "?o";
GUILDADS_MSG_SENDING_UPDATE = "U";
GUILDADS_MSG_SENDING_ALL = "S";
GUILDADS_MSG_SENDING_ALL_END = "E";
GUILDADS_MSG_LASTSEEN = "l";
GUILDADS_MSG_LASTSEEN_END = "le";
GUILDADS_MSG_META = "m";
GUILDADS_MSG_CHATFLAG = "chatFlag";

GUILDADS_STATE_UNKNOW       = "unknow";
GUILDADS_STATE_SYNC_ONLINE  = "s_online";
GUILDADS_STATE_SYNC_OFFLINE = "s_offline";
GUILDADS_STATE_OK   	     = "ok";

local playerName = "";
local MonitorAds = {};			-- record updated ads (GUILDADS_MSG_SENDING_ALL)
local MetaPlayers = {};			-- state, onlineSince, version
local MyState = GUILDADS_STATE_UNKNOW;
local LastSeens = {};			-- Players we are listen to give theirs offline players.
local WaitingOfflinesAds = { };	-- Players are we waiting for offlines ads to be GUILDADS_STATE_OK
local StartTime;
local OnMessageCommand = { };
local OnMessageAd = {};
local WatingForUpdate = { };

local function DEBUG_MSG(msg)
	if (GUILDADSCOMM_DEBUG)
	then
		ChatFrame1:AddMessage("GAC: "..msg, 1.0, 1.0, 0.5);
	end
end

local function GAC_GetGuildChatFrame()
	for i=1,NUM_CHAT_WINDOWS,1 do
		local DefaultMessages = { GetChatWindowMessages(i) };
		for k, channel in DefaultMessages do
			if channel == "GUILD" then
				return getglobal("ChatFrame"..i);
			end
		end
	end
	return DEFAULT_CHAT_FRAME;
end

function GAC_GetMeta(player)
	return MetaPlayers[player];
end

function GAC_GetMetas()
	return MetaPlayers;
end

GAC_GetFlag = SimpleComm_GetFlag;

function GAC_AddChatMessage(msg)
	local info = ChatTypeInfo["CHANNEL"..GetChannelName( SimpleComm_Channel )];
	SimpleComm_ChatFrame:AddMessage(msg, info.r, info.g, info.b);
end

function GAC_InitVariablesLoaded()
	SimpleComm_PreInit(GuildAds_FilterText);
end

function GAC_Init(playername, channel, password)
	DEBUG_MSG("GAC_Init("..playername..","..channel..")");
	
	playerName = playername;
	if (not StartTime) then
		StartTime = GAS_currentTime();
	end
	
	SimpleComm_Init(
		channel,
		password,
		GAC_GetGuildChatFrame(),
		GAC_Synchronize,
		GAC_OnChannelLeave,
		GAC_OnMessage,
		GuildAds_Serialize,
		GuildAds_Unserialize,
		GuildAds_FilterText
		);
	
	local command, alias = GuildAdsConfig_GetChannelAlias()
	SimpleComm_InitAlias(command, alias);
	
	SimpleComm_SetFlagListener(GAC_OnChatFlagChange);
	
	-- Init after the channel is joined (GAC_Synchronize called by SimpleComm)
end

function GAC_Reinit(channel, password)
	-- Reset internal variables
	MonitorAds = {};
	LastSeens = {};
	WaitingOfflinesAds = { };
	WatingForUpdate = { };
	MyState = GUILDADS_STATE_UNKNOW;
	GuildAdsSystem.SynchronizeOfflinesTimer = nil;
	GuildAdsSystem.SynchronizeOfflinesTimerEnd = nil;
	
	-- Reinit GuildAdsComm
	SimpleComm_SetChannel(channel, password);
	
	-- Init after the channel is joined (GAC_Synchronize called by SimpleComm)
end

function GAC_OnChannelLeave()
	GuildAdsPlugin_OnChannelLeave();
end

function GAC_Synchronize()
	DEBUG_MSG("GAC_Synchronize");
	
	-- call plugin init
	GuildAdsPlugin_OnChannelJoin();
	
	-- reset local variables
	MonitorAds = {};
	MetaPlayers = {};
	LastSeens = {};
	WaitingOfflinesAds = {};
	WatingForUpdate = { };
	
	-- Send status
	MyState = GUILDADS_STATE_SYNC_ONLINE;
	GAC_SendMeta(nil);
	
	-- Send chat status : detected by SimpleComm
	GAC_SendChatFlag(playerName);
	
	-- Now, send to all my ads
	GAC_SendAllAdsType(nil, nil, nil);
	
	-- Ask everyone to send me their ads
	GAC_SendRequestAds(nil);
	
	-- Wait 30 seconds and synchronize offlines
	GuildAdsSystem.SynchronizeOfflinesCount = 0;
	GuildAdsSystem.SynchronizeOfflinesTimer = 30;
	GuildAdsSystem.SynchronizeOfflinesTimerEnd = false;
end

function GAC_SynchronizeOfflines(numberOfTries)
	DEBUG_MSG("GAC_SynchronizeOfflines("..numberOfTries..")");
	
	--[[
		moi à player> envois de GUILDADS_MSG_REQUEST_OFFLINES
		player à moi> envois de GUILDADS_MSG_LASTSEEN pour chacun de ses offlines
		moi> pour chaque GUILDADS_MSG_LASTSEEN reçu : 
			si plus ancien -> envois de mes annonces
			si plus récent -> demande les annonces à player
		player à moi> envois de GUILDADS_MSG_LASTSEEN_END
			envois de ses offlines non mis à jour
	]]

	-- Ask offlines to someone who is online
	local oneOnlinePlayer, canTryLater = GAC_GetRandomOnline();
	if (oneOnlinePlayer) then
		-- Il y au moins un autre joueur
		if (canTryLater) and (numberOfTries<=20) then
			--[[ aucun joueur connecté n'est synchronisé
			attends à nouveau 30 secondes
			sauf s'il y a plus de 20 essais (donc 10 minutes)
			nombre d'essais limité pour éviter  le deadlock si 
			deux joueurs se connectent au même moment
			onelinePlayer = true
			]]
			GuildAdsSystem.SynchronizeOfflinesTimerEnd = false;
			GuildAdsSystem.SynchronizeOfflinesCount = numberOfTries+1;
			GuildAdsSystem.SynchronizeOfflinesTimer = 30;
		else
			-- Changement d'état
			MyState = GUILDADS_STATE_SYNC_OFFLINE;
			GAC_SendMeta(nil);
			
			-- Il y a au moins un autre joueur connecté
			GAC_SendRequestOfflines(oneOnlinePlayer);
			-- 10 minutes avant d'être déclaré synchronisé
			GuildAdsSystem.SynchronizeOfflinesTimer = 60*10;
			GuildAdsSystem.SynchronizeOfflinesCount = 0;
			GuildAdsSystem.SynchronizeOfflinesTimerEnd = true;
		end
	else
		-- Aucun online
		-- Synchronisation terminée
		MyState = GUILDADS_STATE_OK;
		GAC_SendMeta(nil);
	end
end

function GAC_SynchronizeOfflinesEnd()
	MyState = GUILDADS_STATE_OK;
	GAC_SendMeta(nil);
end

function GAC_OnChatFlagChange(flag, message)
	SimpleComm_SendMessage(
		nil,
		{
			command = GUILDADS_MSG_CHATFLAG;
			flag = flag;
			text = message;
		}
	);
end

--[[
	Retourne le nom d'un joueur connecté et synchronisé.
	Si aucun joueur connecté n'est synchronisé, retourne true
	Si aucun joueur n'est connecté, retourne nil
]]
function GAC_GetRandomOnline()
	local canTryLater = false;
	local ready = {};
	for name, metainfo in MetaPlayers do
		if (name ~= playerName) then
			if (metainfo.state == GUILDADS_STATE_OK) then
				tinsert(ready, name);
			elseif (metainfo.state == GUILDADS_STATE_SYNC_OFFLINE) or (metainfo.state == GUILDADS_STATE_SYNC_ONLINE) then
				canTryLater = true;
			end
		end
	end
	local s = table.getn(ready);
	if (s > 0) then
		return ready[math.random(s)], false;
	else
		if (canTryLater) then
			return nil, true;
		else
			return nil, false;
		end
	end
end

function GAC_SendAd(who, ad_type ,ad, delay)
	if (ad.m_Enabled == false) then
		return;
	end
	SimpleComm_SendMessage(
		who,
		{
			command = GUILDADS_MSG_ADD;
			adtype = ad_type;
			id = ad.id;
			text = ad.text;
			texture = ad.texture;
			count = ad.count;
			itemRef = ad.itemRef;
			itemName = ad.itemName;
			itemColor = ad.itemColor;
			skillRank = ad.skillRank;
			skillMaxRank = ad.skillMaxRank;
			creationtime = ad.creationtime;
			owner = ad.owner
		},
		delay
	);
end

function GAC_SendSkill(who, id, skillRank, skillMaxRank, delay)
	SimpleComm_SendMessage(
		who,
		{
			command = GUILDADS_MSG_ADD;
			adtype = GUILDADS_MSG_TYPE_SKILL;
			id = id;
			skillRank = skillRank;
			skillMaxRank = skillMaxRank;
			creationtime = GAS_currentTime()
		},
		delay
	);
end

function GAC_SendSkills(who, delay)
	local grp = "";
	for i = 1, GetNumSkillLines(), 1 do	
		local skillName, header, isExpanded, skillRank, numTempPoints, skillModifier, skillMaxRank, isAbandonable, stepCost, rankCost, minLevel, skillCostType = GetSkillLineInfo(i);
		if (header == 1) then
			grp = skillName;
		else 
			local id = GAS_GetSkillId(skillName);
			if (id > 0) then
				GAC_SendSkill(who, id, skillRank, skillMaxRank, delay)
			end
		end
	end
end

function GAC_SendInventory(who, slot, texture, color, ref, name, count)
	SimpleComm_SendMessage(
			who,
			{
				command = GUILDADS_MSG_ADD;
				adtype = GUILDADS_MSG_TYPE_INVENTORY;
				id = slot;
				itemRef = ref;
				itemName = name;
				itemColor = color;
				count = count;
				texture = texture;
				creationtime = GAS_currentTime()
			}
		);
end

function GAC_SendInspect(who)
	local buffer = {};
	for slot=1, 19, 1 do
		local link = GetInventoryItemLink("player", slot);
		if (link) then
			-- local title = TEXT(getglobal(strupper(SlotIdText[slot])));
			local texture = GetInventoryItemTexture("player", slot);
			local count = GetInventoryItemCount("player", slot);
			local color, ref, name = GAS_UnpackLink(link);	
			tinsert(buffer, {
					slot = slot,
					texture = texture,
					color = color,
					ref = ref,
					name = name,
					count = count
				}
			);
		end
	end
	
	GAC_SendingUpdate(who, table.getn(buffer));
	local index = 1;
	while buffer[index] do
		GAC_SendInventory(who, buffer[index].slot, buffer[index].texture, buffer[index].color, buffer[index].ref, buffer[index].name, buffer[index].count);
		index = index + 1;
	end
end

function GAC_SendRequestInspect(who)
	SimpleComm_SendMessage(
			who,
			{
				command = GUILDADS_MSG_REQUEST_INSPECT
			}
		);
end

function GAC_SendRequestOfflines(who)
	DEBUG_MSG("GAC_SendRequestOfflines("..NoNil(who)..")");
	LastSeens[who] = {};
	SimpleComm_SendMessage(
			who,
			{
				command = GUILDADS_MSG_REQUEST_OFFLINES
			}
		);
end

function GAC_SendRequestAds(who, owner)
	DEBUG_MSG("GAC_SendRequestAds("..NoNil(who)..")");
	SimpleComm_SendMessage(
			who,
			{
				command = GUILDADS_MSG_REQUEST_ADS;
				owner = owner
			}
		);
end


function GAC_SendAnnonce(who, owner)
	local powner, level, race, class, name, guildName, guildRankName, guildRankIndex, creationtime;
	if (owner) then
		powner = GAS_ProfileGet(owner);
		level = powner.level;
		race = powner.race;
		class = powner.class;
		name = owner;
		guildName = powner.guild;
		creationtime = powner.creationtime;
		accountid = powner.accountid;
	else
		level = UnitLevel("player");
		race = GAS_GetRaceId(UnitRace("player"));
		class = GAS_GetClassId(UnitClass("player"));
		name = playerName;
		guildName, guildRankName, guildRankIndex = GetGuildInfo("player");
		creationtime = GAS_currentTime();
		accountid = GAS_GetAccountId();
	end
	
	SimpleComm_SendMessage(
			who,
			{
				command = GUILDADS_MSG_ADD;
				adtype = GUILDADS_MSG_TYPE_ANNONCE;
				accountId = accountid;
				class = class;
				race = race;
				level = level;
				guild = guildName;
				creationtime = creationtime;
				owner = owner
			}
		);
end

function GAC_SendRemove(who, adtype, id)
	SimpleComm_SendMessage(
			who,
			{
				command = GUILDADS_MSG_REMOVE;
				adtype = adtype;
				id = id
			}
		);
end

function GAC_SendRemoveAll(who)
	SimpleComm_SendMessage(
			who,
			{
				command = GUILDADS_MSG_REMOVE_ALL;
			}
		);
end

function GAC_SendingUpdate(who, count, owner, delay)
	SimpleComm_SendMessage(
		who,
		{ 
			command = GUILDADS_MSG_SENDING_UPDATE,
			owner = owner,
			count = count
		},
		delay
	);
end

function GAC_SendingAll(who, owner)
	SimpleComm_SendMessage(
			who,
			{
				command = GUILDADS_MSG_SENDING_ALL;
				owner = owner
			}
		);
end

function GAC_SendingAllEnd(who, owner, delay)
	local creationtime = 0;
	if (owner) then
	 	creationtime = GAS_ProfileGetUpdatedDate(owner);
	else
		creationtime = GAS_ProfileGetUpdatedDate(playerName);
	end
	SimpleComm_SendMessage(
			who,
			{
				command = GUILDADS_MSG_SENDING_ALL_END;
				creationtime = creationtime;
				owner = owner;
			},
			delay
		);
end

function GAC_SendLastSeen(who, owner, time)
	DEBUG_MSG("GAC_SendLastSeen("..NoNil(who)..")");
	SimpleComm_SendMessage(
			who,
			{
				command = GUILDADS_MSG_LASTSEEN;
				creationtime = time;
				owner = owner
			}
		);
end

function GAC_SendLastSeenEnd(who)
	DEBUG_MSG("GAC_SendLastSeenEnd("..NoNil(who)..")");
	SimpleComm_SendMessage(
			who,
			{
				command = GUILDADS_MSG_LASTSEEN_END;
			}
		);
end

function GAC_SendAllAds(who, owner, adTable, ad_type, delay)
	local size = table.getn(adTable);
	if owner then
		for i = 1, size, 1 do
			if adTable[i].owner == owner then
				GAC_SendAd(who, ad_type, adTable[i], delay);
			end
		end
	else
		for i = 1, size, 1 do
			GAC_SendAd(who, ad_type, adTable[i], delay);
		end
	end
end

function GAC_SendAllAdsType(who, owner, delay)
	DEBUG_MSG("GAC_SendAllAdsType("..NoNil(who)..","..NoNil(owner)..")");
	
	-- On n'envois pas à who ses annonces
	-- sauf si c'est nous même, ou si c'est à tout le monde
	if (who == owner) and (who ~= playerName) and (who ~= nil) then
		return;
	end
	
	-- Ads->Start
	GAC_SendingAll(who, owner);
	
	-- Ads : Guild
	GAC_SendAnnonce(who, owner);
	
	-- Ads : Ask/Have/Event
	local adTables = {};
	if (owner) then
		adTables = GAS_GetAds();
	else
		adTables = GAS_GetMyAds();
	end
	
	GAC_SendAllAds(who, owner, adTables[GUILDADS_MSG_TYPE_REQUEST], GUILDADS_MSG_TYPE_REQUEST, delay);
	GAC_SendAllAds(who, owner, adTables[GUILDADS_MSG_TYPE_AVAILABLE], GUILDADS_MSG_TYPE_AVAILABLE, delay);
	GAC_SendAllAds(who, owner, adTables[GUILDADS_MSG_TYPE_EVENT], GUILDADS_MSG_TYPE_EVENT, delay);
	
	-- Ads : Skills
	if owner then
		GAC_SendAllAds(who, owner, adTables[GUILDADS_MSG_TYPE_SKILL], GUILDADS_MSG_TYPE_SKILL, delay);
	else
		GAC_SendSkills(who, delay);
	end
	
	-- Ads->End
	GAC_SendingAllEnd(who, owner, delay);
end

function GAC_SendMeta(who)
	SimpleComm_SendMessage(
			who,
			{
				command = GUILDADS_MSG_META;
				text = GUILDADS_VERSION;
				creationtime = StartTime;
				id = MyState;
			}
		);
end

function GAC_SendChatFlag(who)
	local flag, message = SimpleComm_GetFlag(playerName);
	SimpleComm_SendMessage(
		nil,
		{
			command = GUILDADS_MSG_CHATFLAG;
			flag = flag;
			text = message;
		}
	);
end

--------------------------------------------------------------------------------
--
-- OnMessage
-- 
---------------------------------------------------------------------------------
function GAC_OnMessage(author, message)
	if (GUILDADSCOMM_DEBUG) then
		DEBUG_MSG("[OnMessage,"..author.."]: "..GuildAds_Serialize(message));
	end
	
	-- Ignore this author ?
	if GAS_ProfileIsIgnored(author) then
		return;
	end
	
	-- Set online
	GAS_SetOnlineStatus(author, true);
	
	-- A propos de quelle personne : l'auteur du message (author) ou une autre (message.owner)
	local owner = author;
	if (message.owner) then
		owner = message.owner;
	end
	
	-- Mise à jour du dernier message de author
	if (owner==author) and ((message.command == GUILDADS_MSG_ADD) or (message.command == GUILDADS_MSG_REMOVE)) then
		GAS_ProfileSetUpdatedDate(author, message.creationtime);
	end
	
	--
	-- Process all the messages we know about
	--
	if (message.command == GUILDADS_MSG_ADD) then
		-- Accept only if :
		--      this owner isn't ignored
		--   AND ( this owner has sent GUILDADS_MSG_SENDING_ALL which was accepted.
		--         OR this owner has sent a GUILDADS_MSG_SENDING_UPDATE )
		if not GAS_ProfileIsIgnored(owner) and (MonitorAds[owner] or WatingForUpdate[owner]) then
			-- 
			local adtype = message.adtype;
			
			-- Use this update
			if WatingForUpdate[owner] then
				WatingForUpdate[owner] = WatingForUpdate[owner] - 1;
				if WatingForUpdate[owner]==0 then
					WatingForUpdate[owner] = nil;
				end
				DEBUG_MSG("Count"..NoNil(WatingForUpdate[owner]));
			end
		
			-- Call onMessageAd
			if OnMessageAd[adtype] then
				if not OnMessageAd[adtype](author, message) then
					return;
				end
			end
		
			-- Inventory
			if (adtype == GUILDADS_MSG_TYPE_INVENTORY) then
				GAS_ProfileSetInventorySlot(message.creationtime, owner, message.id, message.itemColor, message.itemRef, message.itemName, message.texture, message.count);
				return false;
			end
		
			-- Mise à jour du profile
			if (adtype == GUILDADS_MSG_TYPE_ANNONCE) then
				GAS_ProfileSetGeneral(message.creationtime, owner, message.race, message.class, message.level, message.guild);
				GAS_ProfileSetAccountId(owner, message.accountId);
				message.guild = nil;
				message.level = nil;
				message.class = nil;
				message.race = nil;
				message.accountId = nil;
				message.id = owner;
			end
		
			-- Monitor : l'annonce a été mise à jour
			-- cf GUILDADS_MSG_SENDING_ALL et GUILDADS_MSG_SENDING_ALL_END
			if adtype and owner and MonitorAds[owner] then
				if (MonitorAds[owner][adtype] == nil) then
					MonitorAds[owner][adtype] = {};
				end
				MonitorAds[owner][adtype][message.id] = true;
			end
		
			-- Scan for dupes
			if ((adtype == GUILDADS_MSG_TYPE_REQUEST) or (adtype == GUILDADS_MSG_TYPE_AVAILABLE) or (adtype == GUILDADS_MSG_TYPE_EVENT)) then
				local ads = GAS_GetAds();
				for k,v in ads[adtype] do
					if ( v.owner == owner and v.id == message.id and v.text == message.text and v.itemName == message.itemName and v.count == message.count ) then
						-- DONT ADD IT AGAIN
						DEBUG_MSG("GuildAds_OnMessage: Already in DB");
						return false;
					end
				end
			end
		
		
			-- Effacer le précédent Id 
			GAS_RemoveByOwnerAndId(owner, adtype, message.id);
		
			-- Efface les donnees inutiles
			message.adtype = nil;
			message.command = nil;
			message.owner = owner;
			message.currenttime = nil;
			
			-- Traduction du nom si necessaire
			if message.itemName and message.itemRef then
				local info = GAS_GetItemInfo(message.itemRef);
				if (info.name) then
					message.itemName = info.name;
				end
			end
		
			-- Ajout de l'annonce
			GAS_AddAd(owner, adtype, message);
		end
		
	elseif (message.command == GUILDADS_MSG_REMOVE) then
		-- Ignore this owner ?
		if not GAS_ProfileIsIgnored(owner) then
			-- A previously placed add is being removed
			GAS_RemoveByOwnerAndId(owner, message.adtype, message.id);
		end
		
	elseif (message.command == GUILDADS_MSG_REQUEST_INSPECT) then	
		if not GAS_ProfileIsIgnored(owner) then
			-- Send inspect to the author
			-- Always my inventory
			GAC_SendInspect(author);
		end
		
	elseif (message.command == GUILDADS_MSG_REQUEST_OFFLINES) then
		if not GAS_ProfileIsIgnored(owner) then
			-- Pour chaque personne offline
			-- -> envois la date du dernier message
			local ads = GAS_GetAds();
			for i, ad in ads[GUILDADS_MSG_TYPE_ANNONCE] do
				if (not GAS_IsOnline(ad.owner)) and (not GAS_ProfileIsIgnored(ad.owner)) then
					GAC_SendLastSeen(author, ad.owner, GAS_ProfileGetUpdatedDate(ad.owner));
				end
			end
			GAC_SendLastSeenEnd(author);
		end
		
	elseif (message.command == GUILDADS_MSG_LASTSEEN) then
		if (owner ~= playerName) and (LastSeens[author]) and (not GAS_ProfileIsIgnored(owner)) then
			LastSeens[author][owner] = true;
			local myUpdate = GAS_ProfileGetUpdatedDate(owner);
			if (message.creationtime ~= myUpdate) then
				if (myUpdate) then
					if (message.creationtime==nil or message.creationtime < myUpdate) then
						DEBUG_MSG("LastSeen("..owner..")="..NoNil(message.creationtime).."<"..NoNil(myUpdate));
						-- on doit faire la mise à jour pour tout le monde
						GAC_SendAllAdsType(nil, owner);
					elseif (message.creationtime > myUpdate) then
						DEBUG_MSG("LastSeen("..owner..")="..NoNil(message.creationtime)..">"..NoNil(myUpdate));
						-- on doit récupérer la mise à jour
						tinsert(WaitingOfflinesAds, owner);
					end
				else
					DEBUG_MSG("LastSeen("..owner..")="..NoNil(message.creationtime).."/"..NoNil(myUpdate));
					-- on doit récupérer la mise à jour
					tinsert(WaitingOfflinesAds, owner);
				end
			end
		end
		
	elseif (message.command == GUILDADS_MSG_LASTSEEN_END) then
		if LastSeens[author] and not GAS_ProfileIsIgnored(author) then
			-- envois les annonces des joueurs non connus.
			local ads = GAS_GetAds();
			for i, ad in ads[GUILDADS_MSG_TYPE_ANNONCE] do
				-- si ad.owner est offline et non connu par author
				-- alors on envois ses informations à propos de ad.owner
				if (not GAS_IsOnline(ad.owner) and LastSeens[author][ad.owner]==nil) then
					GAC_SendAllAdsType(nil, ad.owner);
				end
			end
			
			-- Dernier message de author à propos des offlines
			-- Donc on n'écoute plus les message de author
			LastSeens[author] = nil;
			
			--
			if (table.getn(WaitingOfflinesAds) > 0) then
				-- demande de mise à jour pour soi.
				for _, owner in WaitingOfflinesAds do
					GAC_SendRequestAds(author, owner);
				end
			else
				-- aucune demande de offlines
				-- on est donc synchro : passage a l'etat OK
				GuildAdsSystem.SynchronizeOfflinesTimer = nil;
				MyState = GUILDADS_STATE_OK;
				GAC_SendMeta(nil);
			end
		end
		
	elseif (message.command == GUILDADS_MSG_REQUEST_ADS) then
		-- Someone is requesting ads, probably just arrived in the channel
		-- if message.owner is set : owner's ads
		-- if message.owner is nil : my ads (send my ads in few seconds)
		-- owner is meaningless
		if GuildAds.Config.PublishMyAds and not GAS_ProfileIsIgnored(owner) then
			if (author ~= playerName) then
				if message.owner then
					GAC_SendAllAdsType(author, message.owner);
				else
					GAC_SendMeta(author);
					GAC_SendChatFlag(author);
					GAC_SendAllAdsType(author, nil, math.random(20));
				end
			end
		end
		
	elseif (message.command == GUILDADS_MSG_SENDING_UPDATE) then
	
		WatingForUpdate[owner] = (WatingForUpdate[owner] or 0) + message.count;
		
	elseif (message.command == GUILDADS_MSG_SENDING_ALL) then
		if not GAS_ProfileIsIgnored(owner) then
			-- Start recording each update ads
			if message.owner then
				-- Accept offline ads from owner we need. (see GUILDADS_MSG_LASTSEEN)
				i = 1;
				while WaitingOfflinesAds[i] and WaitingOfflinesAds[i]~=owner do
					i = i+1;
				end
				if  WaitingOfflinesAds[i] and WaitingOfflinesAds[i]==owner then
					MonitorAds[owner] = {};
				end
				
				-- accept new ads from author who are in GUILDADS_STATE_SYNC_OFFLINE state.
				if MetaPlayers[author] and MetaPlayers[author].state==GUILDADS_STATE_SYNC_OFFLINE then
					MonitorAds[owner] = {};
				end
			else
				-- online synchronization : ok
				MonitorAds[owner] = {};
			end
		end
		
	elseif (message.command == GUILDADS_MSG_SENDING_ALL_END) then
		if MonitorAds[owner] and not GAS_ProfileIsIgnored(owner) then
		
			-- Update profile date
			if owner then
				GAS_ProfileSetUpdatedDate(owner, message.creationtime);
			end

			-- for each owner's ads
			-- if not updated (ie in MonitorAds), we delete it
			local ads = GAS_GetAds();
			for adtype, tads in ads do
				if (MonitorAds[owner][adtype] == nil) then
					GAS_RemoveByOwner(owner, adtype);
				else
					for i, ad in tads do
						if (owner==ad.owner and MonitorAds[owner][adtype][ad.id] == nil) then
							GAS_RemoveByOwnerAndId(owner, adtype, ad.id);
						end
					end
				end
			end

			-- stop monitoring
			MonitorAds[owner] = nil;
			
			-- Unstack owner in WatingOfflineAds
			-- if this is the last, we are sync
			-- so set state to GUILDADS_STATE_OK
			i = 1;
			while WaitingOfflinesAds[i] and WaitingOfflinesAds[i]~=owner do
				i = i+1;
			end
			if WaitingOfflinesAds[i] and WaitingOfflinesAds[i]==owner then
				table.remove(WaitingOfflinesAds, i);
				if (table.getn(WaitingOfflinesAds)==0) then
					GuildAdsSystem.SynchronizeOfflinesTimer = nil;
					MyState = GUILDADS_STATE_OK;
					GAC_SendMeta(nil);
				end
			end
			
		end
		
	elseif (message.command == GUILDADS_MSG_REMOVE_ALL) then
	
		if not GAS_ProfileIsIgnored(owner) then
			-- Remove all the ads from the owner
			GAS_RemoveByOwner(owner, GUILDADS_MSG_TYPE_ANNONCE);
			GAS_RemoveByOwner(owner, GUILDADS_MSG_TYPE_REQUEST);
			GAS_RemoveByOwner(owner, GUILDADS_MSG_TYPE_AVAILABLE);
			GAS_RemoveByOwner(owner, GUILDADS_MSG_TYPE_SKILL);
			GAS_RemoveByOwner(owner, GUILDADS_MSG_TYPE_EVENT);
		end
		
	elseif (message.command == GUILDADS_MSG_META) then
	
		if not GAS_ProfileIsIgnored(author) then
			MetaPlayers[author] = {
				state = message.id;
				onlineSince = message.creationtime;
				version = message.text;
			};
		end
		
	elseif (message.command == GUILDADS_MSG_CHATFLAG) then
		
		if author~=playerName then
			SimpleComm_SetFlag(author, message.flag, message.text);
		end
		
	elseif OnMessageCommand[message.command] then
		OnMessageCommand[message.command](author, message);
	else
		-- This message was unknown
	end
end


--------------------------------------------------------------------------------
--
-- Serialize/Unserialize 
-- 
---------------------------------------------------------------------------------
function SerializeId(obj)
	if (type(obj) == "nil" ) then
		return "";
	else
		return obj
	end
end

function UnserializeId(str)
	return str;
end

function SerializeString(obj)
	if (type(obj) == "nil" ) then
		return "";
	else
		return obj
	end
end

function UnserializeString(str)
	if (str == "") then
		return nil;
	else
		return str
	end
end

function SerializeTexture(obj)
	if (type(obj) == "nil" ) then
		return "";
	else
		return string.gsub(obj, "Interface\\Icons\\", "\@");
	end
end

function UnserializeTexture(str)
	if (str == "") then
		return nil;
	else
		return string.gsub(str, "\@", "Interface\\Icons\\");
	end
end

function SerializeItemRef(obj)
	if (type(obj) == "nil" ) then
		return "";
	else
		return string.gsub(string.gsub(obj, "item\:", "\@"), ":0:0:0", "\*");
	end
end

function UnserializeItemRef(str)
	if (str == "") then
		return nil;
	else
		return string.gsub(string.gsub(str, "\@", "item\:"), "\*", ":0:0:0");
	end
end

function SerializeColor(obj)
	if obj==nil then
		return "";
	elseif obj=="ffa335ee" then
		return "E"; -- epic
	elseif obj=="ff0070dd" then
		return "R"; -- rare
	elseif obj=="ff1eff00" then
		return "U" -- uncommun
	elseif obj=="ffffffff" then
		return "C" -- common
	elseif obj=="ff9d9d9d" then
		return "P" -- poor
	else
		return obj;
	end
end

function UnserializeColor(str)
	if str==nil then
		return nil
	elseif str=="E" then
		return "ffa335ee";
	elseif str=="R" then
		return "ff0070dd";
	elseif str=="U" then
		return "ff1eff00";
	elseif str=="C" then
		return "ffffffff";
	elseif str=="P" then
		return "ff9d9d9d";
	else
		return str;
	end
end

function SerializeInteger(obj)
	if (type(obj) == "nil" ) then
		return "";
	else
		return obj;
	end
end

function UnserializeInteger(str)
	return tonumber(str);
end

function SerializeTime(obj)
	if (type(obj) == "nil" ) then
		return "";
	else
		-- convertion en base 52
		value = "";
		while (obj ~= 0) do
			i = floor(obj / 52);
			j = obj - i*52;
			if (j>=26) then
				value = string.char(65+j-26)..value;
			else
				value = string.char(96+j)..value;
			end
			obj = i;
		end
		return value;
	end
end

function UnserializeTime(str)
	if (str == "") then
		return nil;
	else
		number = 0;
		for i=1, string.len(str),1  do
			o = string.byte(str, i);
			if (o> 95) then
				j = o-96;
			else
				j = o-65+26;
			end
			number = number*52 + j;
		end
		return number;
	end
end

function SerializeObj(obj)
	if (type(obj) == "nil" ) then 
		return "";
	elseif ( type(obj) == "string" ) then
		return "s"..string.gsub(string.gsub(string.gsub(obj, ">", "&gt;"), "|([cHhr])", "&%1;"), "|", "&p;");
	elseif ( type(obj) == "number" ) then
		return "n"..obj;
	elseif ( type(obj) == "boolean" ) then
		if  (value) then
			return "1";
		else
			return "0";
		end
	elseif ( type(obj) == "function" ) then
		return ""; -- nil
	elseif ( type(obj) == "table" ) then
		return ""; -- nil
	end
	return "";
end

function UnserializeObj(str)
	if (str == "") then
		return nil;
	else
		typeString = string.sub(str, 0, 1);
		valueString = string.sub(str, 2);
		if (typeString == "s") then
			return string.gsub(string.gsub(string.gsub(valueString, "&gt;", ">"), "&(%w);", "|%1"), "&p;", "|");
		elseif (typeString == "n") then
			return tonumber(valueString);
		elseif (typeString == "1") then
			return true;
		elseif (typeString == "0") then
			return false;
		else
			DEBUG_MSG("GuildAds_Unserialize: Type non reconnu:"..str);
			return nil;
		end
	end
end

local SerializeMeta = {
		[1]  = { ["key"] ="command", 	["fout"]=SerializeId, 		["fin"]=UnserializeId }
	};
	
local SerializeCommand = {
		[GUILDADS_MSG_ADD] = {
				[1] = { ["key"]="owner", 			["fout"]=SerializeString,	["fin"]=UnserializeString },
				[2] = { ["key"]="adtype",			["fout"]=SerializeInteger,	["fin"]=UnserializeInteger },
				[3] = { ["key"]="id", 				["fout"]=SerializeObj,		["fin"]=UnserializeObj },
				[4] = { ["key"]="currenttime",		["fout"]=SerializeTime,		["fin"]=UnserializeTime},
				[5] = { ["key"]="creationtime", 	["fout"]=SerializeTime,		["fin"]=UnserializeTime},
			},
		[GUILDADS_MSG_REMOVE] = {
				[1] = { ["key"] ="owner", 			["fout"]=SerializeString,	["fin"]=UnserializeString },
				[2] = { ["key"] ="adtype",			["fout"]=SerializeInteger,	["fin"]=UnserializeInteger },
				[3] = { ["key"] ="id", 				["fout"]=SerializeObj,		["fin"]=UnserializeObj },
			},
		[GUILDADS_MSG_REMOVE_ALL] = {
				[1]  = { ["key"] ="owner", 			["fout"]=SerializeString,	["fin"]=UnserializeString },
			},
		[GUILDADS_MSG_REQUEST_ADS] = {
				[1]  = { ["key"] ="owner", 			["fout"]=SerializeString,	["fin"]=UnserializeString },
			},
		[GUILDADS_MSG_REQUEST_OFFLINES] = {},
		[GUILDADS_MSG_REQUEST_INSPECT] = {},
		[GUILDADS_MSG_SENDING_UPDATE] = {
				[1] = { ["key"] ="owner", 			["fout"]=SerializeString,	["fin"]=UnserializeString },
				[2] = { ["key"] ="count", 			["fout"]=SerializeInteger, 	["fin"]=UnserializeInteger },
			},
		[GUILDADS_MSG_SENDING_ALL] = {
				[1] = { ["key"] ="owner", 			["fout"]=SerializeString,	["fin"]=UnserializeString },
			},
		[GUILDADS_MSG_SENDING_ALL_END] = { -- currenttime, profiletime
				[1] = { ["key"] ="owner", 			["fout"]=SerializeString,	["fin"]=UnserializeString },
				[2] = { ["key"] ="currenttime",		["fout"]=SerializeTime,		["fin"]=UnserializeTime},
				[3] = { ["key"] ="creationtime", 	["fout"]=SerializeTime,		["fin"]=UnserializeTime },
			},
		[GUILDADS_MSG_LASTSEEN] = {  -- currenttime, profiletime
				[1] = { ["key"] ="owner", 			["fout"]=SerializeString,	["fin"]=UnserializeString },
				[2] = { ["key"] ="currenttime",		["fout"]=SerializeTime,		["fin"]=UnserializeTime},
				[3] = { ["key"] ="creationtime",	["fout"]=SerializeTime,		["fin"]=UnserializeTime },
			},
		[GUILDADS_MSG_LASTSEEN_END] = {},
		[GUILDADS_MSG_META] = { -- currenttime, version, starttime, id
				[1] = { ["key"] ="currenttime",		["fout"]=SerializeTime,		["fin"]=UnserializeTime},
				[2] = { ["key"] ="text", 			["fout"]=SerializeString,	["fin"]=UnserializeString },
				[3] = { ["key"] ="creationtime", 	["fout"]=SerializeTime,		["fin"]=UnserializeTime },
				[4] = { ["key"] ="id", 				["fout"]=SerializeId,		["fin"]=UnserializeId },
			},
		[GUILDADS_MSG_CHATFLAG] = { -- flag, text
				[1] = { ["key"] ="flag",		    ["fout"]=SerializeString,   ["fin"]=UnserializeString},
				[2] = { ["key"] ="text", 			["fout"]=SerializeString,	["fin"]=UnserializeString },
			},
	};


local SerializeAd = {
		[GUILDADS_MSG_TYPE_ANNONCE] = { -- accountId, class, race, level, guild
				[1]  = { ["key"] ="accountId", 		["fout"]=SerializeObj,		["fin"]=UnserializeObj },
				[2]  = { ["key"] ="class", 			["fout"]=SerializeInteger,	["fin"]=UnserializeInteger },
				[3]  = { ["key"] ="race", 			["fout"]=SerializeInteger,	["fin"]=UnserializeInteger },
				[4]  = { ["key"] ="level",			["fout"]=SerializeInteger,	["fin"]=UnserializeInteger },
				[5]  = { ["key"] ="guild",			["fout"]=SerializeString,	["fin"]=UnserializeString },
			},
		[GUILDADS_MSG_TYPE_INVENTORY] = { -- itemRef, itemName, itemColor, count, texture
				[1] = { ["key"] ="itemColor", 		["fout"]=SerializeColor,	["fin"]=UnserializeColor },
				[2] = { ["key"] ="itemRef", 		["fout"]=SerializeItemRef,	["fin"]=UnserializeItemRef },
				[3] = { ["key"] ="itemName", 		["fout"]=SerializeString,	["fin"]=UnserializeString },
				[4] = { ["key"] ="count", 			["fout"]=SerializeInteger, 	["fin"]=UnserializeInteger },
				[5] = { ["key"] ="texture", 		["fout"]=SerializeTexture, 	["fin"]=UnserializeTexture },				
			},
		[GUILDADS_MSG_TYPE_SKILL] = { -- skillRank , skillMaxRank
				[1] = { ["key"] ="skillRank", 		["fout"]=SerializeInteger, 	["fin"]=UnserializeInteger },
				[2] = { ["key"] ="skillMaxRank", 	["fout"]=SerializeInteger, 	["fin"]=UnserializeInteger },				
			},
		[GUILDADS_MSG_TYPE_REQUEST] = { -- text, itemRef, itemName, itemColor, count, texture
				[1] = { ["key"] ="text", 			["fout"]=SerializeObj,		["fin"]=UnserializeObj },
				[2] = { ["key"] ="itemColor", 		["fout"]=SerializeColor,	["fin"]=UnserializeColor },
				[3] = { ["key"] ="itemRef", 		["fout"]=SerializeItemRef,	["fin"]=UnserializeItemRef },
				[4] = { ["key"] ="itemName", 		["fout"]=SerializeString,	["fin"]=UnserializeString },
				[5] = { ["key"] ="count", 			["fout"]=SerializeInteger, 	["fin"]=UnserializeInteger },
				[6] = { ["key"] ="texture", 		["fout"]=SerializeTexture, 	["fin"]=UnserializeTexture },
			},
		[GUILDADS_MSG_TYPE_AVAILABLE] ={ -- text, itemRef, itemName, itemColor, count, texture
				[1] = { ["key"] ="text", 			["fout"]=SerializeObj,		["fin"]=UnserializeObj },
				[2] = { ["key"] ="itemColor", 		["fout"]=SerializeColor,	["fin"]=UnserializeColor },
				[3] = { ["key"] ="itemRef", 		["fout"]=SerializeItemRef,	["fin"]=UnserializeItemRef },
				[4] = { ["key"] ="itemName", 		["fout"]=SerializeString,	["fin"]=UnserializeString },
				[5] = { ["key"] ="count", 			["fout"]=SerializeInteger, 	["fin"]=UnserializeInteger },
				[6] = { ["key"] ="texture", 		["fout"]=SerializeTexture, 	["fin"]=UnserializeTexture },
			},
		[GUILDADS_MSG_TYPE_EVENT] = { -- text
				[1] = { ["key"] ="text", 			["fout"]=SerializeObj,		["fin"]=UnserializeObj },
				[2] = { ["key"] ="eventtime", 		["fout"]=SerializeTime,		["fin"]=UnserializeTime },
				[3] = { ["key"] ="note", 			["fout"]=SerializeString,	["fin"]=UnserializeString },
				[4] = { ["key"] ="count", 			["fout"]=SerializeInteger,	["fin"]=UnserializeInteger },
				[5] = { ["key"] ="minlevel", 		["fout"]=SerializeInteger,	["fin"]=UnserializeInteger },
				[6] = { ["key"] ="maxlevel", 		["fout"]=SerializeInteger,	["fin"]=UnserializeInteger },
			},
		[GUILDADS_MSG_TYPE_EVENT_SUBSCRIPTION] = {
				[1] = { ["key"] ="eventid", 		["fout"]=SerializeInteger,	["fin"]=UnserializeInteger },
		}
	};

						
function SerializeTable(spec, obj)
	local tmp = "";
	local index = table.getn(spec);
	while (index > 0) do
		local info = spec[index];
		local result = info.fout(obj[info.key]);
		
		if (tmp ~= "") or (result ~= "") then
			tmp = result..">"..tmp;
		end;
		
		index = index -1;
	end
	return tmp;
end

function GuildAds_SerializeCommand(obj)
	local result = SerializeTable(SerializeMeta, obj)
	if SerializeCommand[obj.command] then
		result = result .. SerializeTable(SerializeCommand[obj.command], obj);
		if obj.command == GUILDADS_MSG_ADD then
			result = result .. SerializeTable(SerializeAd[obj.adtype], obj);
		end
	end
	return result;
end

function GuildAds_UnserializeCommand(text)
	local obj= { };
	
	local spec=SerializeMeta;
	local index=1;
	local size= table.getn(spec);
	local step=1;
	
	for str in string.gfind(text, "([^\>]*)>") do
		info = spec[index];
		obj[info.key] = info.fin(str);
		
		index = index + 1;
		if index>size then
			
			step=step+1;
			
			if step==2 then
				if obj.command and SerializeCommand[obj.command] then
					spec=SerializeCommand[obj.command];
				else
					spec=nil;
				end
			elseif step==3 then
				if obj.adtype and SerializeAd[obj.adtype] then
					spec=SerializeAd[obj.adtype];
				else
					spec=nil;
				end
			else
				return obj;
			end
			
			if spec then
				index=1;
				size=table.getn(spec);
			else
				return obj
			end
		end
	end
	
	return obj;
end

function GuildAds_Serialize(obj)
	obj["currenttime"] = GAS_currentTime();
	return GUILDADS_MSG_PREFIX..GuildAds_SerializeCommand(obj);
end

function GuildAds_Unserialize(str)
	local iStart, iEnd, msg, params;
	iStart, iEnd, params = string.find(str, GUILDADS_MSG_PREFIX.."(.*)");
	if (iStart) then
		return GuildAds_UnserializeCommand(params);
	else
		iStart, iEnd, params = string.find(str, GUILDADS_MSG_PREFIX_CHATCOMM.."(.*)");
		if (iStart) then
			return GuildAds_UnserializeCommand(params);
		else
			return nil
		end
	end
end

function GuildAds_FilterText(text)
	return string.sub(text, 1, string.len(GUILDADS_MSG_PREFIX_NOVERSION)) == GUILDADS_MSG_PREFIX_NOVERSION 
		or string.sub(text, 1, string.len(GUILDADS_MSG_PREFIX_TOKEN)) == GUILDADS_MSG_PREFIX_TOKEN;
end


--------------------------------------------------------------------------------
--
-- Register/Unregister new command
-- 
---------------------------------------------------------------------------------
function GAC_RegisterCommand(command, serializeInfo, onMessage)
	if SerializeCommand[command] then
		return false, "command("..command..") already registered";
	else
		if  type(onMessage) == "function" then
			if type(serializeInfo) == "table" then
				for _, spec in serializeInfo do
					if type(spec.key)~="string" or type(spec.fin)~="function" or type(spec.fout)~="function" then
						if type(spec.key)=="string" then
							return false, "serializeInfo["..spec.key.."]="..type(spec.fin)..","..type(spec.fout);
						else
							return false, "serializeInfo[??]="..type(spec.fin)..","..type(spec.fout);
						end
					end
				end
				SerializeCommand[command] = serializeInfo;
				OnMessageCommand[command] = onMessage;
				return true;
			else
				return false, "type(serializeInfo)="..type(serializeInfo);
			end
		else
			return false, "type(onMessage)="..type(onMessage);
		end
	end
end

function GAC_UnregisterCommand(command)
	SerializeCommand[command] = nil;
	OnMessageCommand[command] = nil;
end

function GAC_IsRegisteredCommand(command)
	if SerializeCommand[command] then
		return true, SerializeCommand[command], OnMessageCommand[command];
	else
		return false;
	end
end

--------------------------------------------------------------------------------
--
-- Register/Unregister new ad type
-- 
---------------------------------------------------------------------------------
function GAC_RegisterAdtype(adtype, serializeInfo, onMessage)
	if SerializeAd[adtype] then
		return false, "adtype("..command..") already registered";
	else
		if type(onMessage) == "function" then
			if type(serializeInfo) == "table" then
				for _, spec in serializeInfo do
					if type(spec.key)~="string" or type(spec.fin)~="function" or type(spec.fout)~="function" then
						return false, "serializeInfo["..spec.key.."]="..type(spec.fin)..","..type(spec.fout);
					end
				end
				SerializeAd[adtype] = serializeInfo;
				OnMessageAd[adtype] = onMessage;
				return true;
			else
				return false, "type(serializeInfo)="..type(serializeInfo);
			end
		else
			return false, "type(onMessage)="..type(onMessage);
		end
	end
end

function GAC_UnregisterAdtype(adtype)
	SerializeAd[adtype] = nil;
	OnMessageAd[adtype] = nil;
end

function GAC_IsRegisteredAdtype(adtype)
	if SerializeCommand[adtype] then
		return true, SerializeAd[adtype], OnMessageAd[adtype];
	else
		return false;
	end
end

-- export
GAC_SerializeObj = SerializeObj;
GAC_UnserializeObj = UnserializeObj;

GAC_SerializeString = SerializeString;
GAC_UnserializeString = UnserializeString;

GAC_SerializeInteger = SerializeInteger;
GAC_UnserializeInteger = UnserializeInteger;

GAC_SerializeColor = SerializeColor;
GAC_UnserializeColor = UnserializeColor;