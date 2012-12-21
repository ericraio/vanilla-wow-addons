--[[
Plugin = {
	metaInformations = {
		name = "GuildAdsPlayerTracker",
		guildadsCompatible = 100,
	}

	getCommands = function()
		return {
			[GUILDADSPLAYERTRACKER_CMD_LOC] = {
				[1] = { ["key"]="continent", 
						["fout"]=GuildAdsPlugin.serializeInteger,
						["fin"]=GuildAdsPlugin.unserializeInteger }
					} ...
			}
			};
	end;

	getAdTypes = function()
	end
	
	-- others functions that can be defined
	-- those functions will be called when the event occured
	onChannelJoin();
	onChannelLeave();
	onShowAd(tooltip, adtype, ad)
	onShowContextMenu(adtype, ad)
	onOnline(playerName, status)
	onUpdateInventory(owner, slot)
	onAddGlobal(owner, adtype, ad)
	onRemoveGlobal(owner, adtype, id)
	onAddMy(adtype, ad)
	onRemoveMy(adtype, id)
	onShowAd(tooltip, adtype, ad)
	onShowContextMenu(adtype, ad)
}
]]

local pluginsToRegister = {};

GuildAdsPlugin = {

	debugOn = false;

	PluginsList = {};
	
	addMenuEnabled = false;

	EVENT_ONLINE = GAS_EVENT_ONLINE;
	EVENT_UPDATEINVENTORY = GAS_EVENT_UPDATEINVENTORY;
	EVENT_ADDGLOBAL = GAS_EVENT_ADDGLOBAL;
	EVENT_REMOVEGLOBAL = GAS_EVENT_REMOVEGLOBAL;
	EVENT_ADDMY = GAS_EVENT_ADDMY;
	EVENT_REMOVEMY = GAS_EVENT_REMOVEMY;
	
	EVENT_ONSHOWAD = "ShowAd";
	EVENT_ONSHOWCONTEXTMENU = "ShowContextMenu";
	
	-- currentTime()
	currentTime = currentTime;
	
	-- timeToString(time)
	timeToString = timeToString;
	
	-- isOnline(playername)
	isOnline = GAS_IsOnline;
	
	-- getAccountId()
	getAccountId = GAS_GetAccountId;
	
	-- getInventory(owner)
	getInventory = GAS_ProfileGetInventory;
	
	-- getProfile(owner)
	getProfile = GAS_ProfileGet;
	
	-- getUpdatedDate(owner)
	getUpdatedDate = GAS_ProfileGetUpdatedDate;
	
	-- getPlayersByAccount(accountid)
	getPlayersByAccount = GAS_PlayersByAccount;
	
	-- getMyAds()
	getMyAds = GAS_GetMyAds;
	
	-- getGlobalAds()
	getGlobalAds = GAS_GetAds;
	
	-- addMyAd(adtype, text, color, ref, name, texture, count)
	addMyAd = GAS_AddMyAd;
	
	-- editMyAd(adtype, id, text, color, ref, name, texture, count)
	editMyAd = GAS_EditMyAd;
	
	-- removeMyAd(adtype, id)
	removeMyAd = GAS_RemoveMyAd;
	
	-- enableMyAd(adtype, id)
	enableMyAd = GAS_EnableMyAd;
	
	-- GAS_DisableMyAd
	disableMyAd = GAS_DisableMyAd;
	
	-- GAS_AddAd
	addGlobalAd = GAS_AddAd;
	
	-- removeGlobalAdByOwnerAndId(owner, adtype, id)
	removeGlobalAdByOwnerAndId = GAS_RemoveByOwnerAndId;
	
	-- removeGlobalAdByOwner(owner, adtype)
	removeGlobalAdByOwner = GAS_RemoveByOwner;
	
	-- getSkillText(SkillId)
	getSkillText = GAS_GetSkillText;

	-- getClassText(ClassId)
	getClassText = GAS_GetClassText;
	
	-- getRaceText(RaceId)
	getRaceText = GAS_GetRaceText;
	
	-- getItemInfo
	getItemInfo = GAS_GetItemInfo;
	
	-- SerializeObj
	serializeObj = GAC_SerializeObj;
	unserializeObj = GAC_UnserializeObj;
	
	-- SerializeString
	serializeString = GAC_SerializeString;
	unserializeString = GAC_UnserializeString;
	
	-- SerializeInteger
	serializeInteger = GAC_SerializeInteger;
	unserializeInteger = GAC_UnserializeInteger;
	
	-- SerializeColor
	serializeColor = GAC_SerializeColor;
	unserializeColor = GAC_UnserializeColor;
	
	isPluginValid  = function(plugin)
    	-- Every plugin needs to be a table
        if type(plugin) ~= "table" then
            return false, "Plugin type check failed.";
        end

    	-- Check metainformations
        if type(plugin.metaInformations) == "table" then
			local metainfo = plugin.metaInformations;
			-- check name
			if type(metainfo.name)~="string" then
				return false, "Plugin name check failed.";
			end
			-- check version
			if type(metainfo.guildadsCompatible)~="number" or metainfo.guildadsCompatible>GUILDADS_VERSION then
				return false, "Plugin incompatible with this version of GuildAds";
			end
		else
            return false, "Plugin Metainformations check failed.";
        end

        return true;
	end;
	
	_register = function(plugin)
		local valid, errorMessage = GuildAdsPlugin.isPluginValid (plugin);
		if valid then
			-- register commands
			if type(plugin.getCommands)=="function" then
				local commands = plugin.getCommands();
				for command, spec in commands do
					local status, errorMessage = GuildAdsPlugin.registerCommand(command, spec[1], spec[2]);
					if not status then
						return false, errorMessage;
					end
				end
			end
			
			-- register adtypes
			if type(plugin.getAdTypes)=="function" then
				local adtypes = plugin.getAdTypes();
				for adtype, spec in adtypes do
					local status, errorMessage = GAC_RegisterAdtype(adtype, spec[1], spec[2]);
					if not status then
						return false, errorMessage;
					end
				end
			end
			
			local pluginName = plugin.metaInformations.name;
			
			-- add plugin to GuildAdsPlugin.PluginsList
			GuildAdsPlugin.PluginsList[pluginName] = plugin;
			
			-- set debug function
			plugin.debug = function(message)
				GuildAdsPlugin.debug(pluginName..":"..message);
			end
			
			-- call onChannelJoin() ??
			
			return true;
		else
			return false, errorMessage;
		end
	end;
	
	register = function(plugin)
		if pluginsToRegister then
			tinsert(pluginsToRegister, plugin)
			return true;
		else
			return GuildAdsPlugin._register(plugin);
		end
	end;
	
	UIregister = function(plugin)
		status, errorMessage = GuildAdsPlugin.register(plugin);
		if not status then
			if errorMessage then
				error(errorMessage,2);
			else
				error("error", 2);
			end
		end
	end;
	
	deregister = function(plugin)
		local valid, errorMessage = GuildAdsPlugin.isPluginValid (plugin);
		if valid then
			GuildAdsPlugin.PluginsList[plugin.metaInformations.name] = nil;
			-- call onChannelLeave()
			return true;
		else
			return false, errorMessage;
		end
	end;
	
	registerCommand = function(command, serializeInfo, onMessage)
		return GAC_RegisterCommand(command, serializeInfo, onMessage);
	end;

	deregisterCommand = function(command)
		return GAC_UnregisterCommand(command);
	end;

	registerAdtype = function(adtype, serializeInfo, onMessage)
		return GAC_RegisterAdtype(adtype, serializeInfo, onMessage);
	end;

	deregisterAdtype = function(adtype)
		return GAC_UnregisterAdtype(adtype);
	end;
	
	addContextMenu = function(menu)
		if GuildAdsPlugin.addMenuEnabled and menu and menu.text then
			UIDropDownMenu_AddButton(menu, 1);
			return true;
		else
			return false;
		end	
	end;
	
	-- send(who, obj, delay)
	send = function(who, obj, delay)
		if obj.command and GAC_IsRegisteredCommand(obj.command) then
			SimpleComm_SendMessage(who, obj, delay);
			return true;
		else
			return false;
		end
	end;
	
	-- sendRaw
	sendRaw = function(who, message, delay)
		if type(message) == "string" then
			SimpleComm_SendRawMessage(who, message, delay);
			return true;
		else
			return false;
		end
	end;
	
	-- setDebug
	setDebug = function(status)
		if status then
			GuildAdsPlugin.debugOn = true;
		else
			GuildAdsPlugin.debugOn = false;
		end
	end;
	
	-- debug
	debug = function(message, raw)
		if GuildAdsPlugin.debugOn then
			if raw then
				ChatFrame1:AddMessage(message, 1.0, 0.25, 0.75);
			else
				ChatFrame1:AddMessage("GuildAdsPlugin:"..message, 1.0, 0.25, 0.75);
			end
		end
	end
};

local EventIdToMethod = {
	[GuildAdsPlugin.EVENT_ONLINE] = "onOnline";
	[GuildAdsPlugin.EVENT_UPDATEINVENTORY] = "onUpdateInventory";
	[GuildAdsPlugin.EVENT_ADDGLOBAL] = "onAddGlobal";
	[GuildAdsPlugin.EVENT_REMOVEGLOBAL] = "onRemoveGlobal";
	[GuildAdsPlugin.EVENT_ADDMY] = "onAddMy";
	[GuildAdsPlugin.EVENT_REMOVEMY] = "onRemoveMy";
	[GuildAdsPlugin.EVENT_ONSHOWAD] = "onShowAd";
	[GuildAdsPlugin.EVENT_ONSHOWCONTEXTMENU] = "onShowContextMenu";
}

local function pluginToRealCommand(command)
	return "P"..command;
end

local function realToPluginCommand(command)
	local iStart, iEnd, realCommand = string.find(command, "P(.*)");
	if (iStart) then
		return realCommand;
	else
		return false;
	end
end

local function methodToEventId(method)
	for ltype, lmethod in EventIdToMethod do
		if method == lmethod then
			return ltype;
		end
	end
	return nil;
end

function GuildAdsPlugin_RegisterPlugins()
	-- register plugins
	for _, plugin in ipairs(pluginsToRegister) do
		local status, errorMessage = GuildAdsPlugin._register(plugin);
		if not status then
			local pluginName;
			if plugin.metaInformations and plugin.metaInformations.name then
				pluginName = plugin.metaInformations.name..": ";
			else
				pluginName = "GuildAds(unknown plugin):";
			end
			if errorMessage then
				message(pluginName..errorMessage);
			else
				message(pluginName.."error");
			end
		end
	end
	
	-- GuildAdsPlugin.register : register immediatly
	pluginsToRegister = nil;
end

function GuildAdsPlugin_OnInit()
	-- call onInit
	for pluginName, plugin in GuildAdsPlugin.PluginsList do
		if type(plugin.onInit) == "function" then
			plugin.onInit();
		end
	end
end

function GuildAdsPlugin_OnChannelJoin()
	for pluginName, plugin in GuildAdsPlugin.PluginsList do
		if type(plugin.onChannelJoin) == "function" then
			plugin.onChannelJoin();
		end
	end
end

function GuildAdsPlugin_OnChannelLeave()
	for pluginName, plugin in GuildAdsPlugin.PluginsList do
		if type(plugin.onChannelJoin) == "function" then
			plugin.onChannelLeave();
		end
	end
end

function GuildAdsPlugin_OnShowAd(tooltip, adtype, ad)
	for pluginName, plugin in GuildAdsPlugin.PluginsList do
		if type(plugin.onShowAd) == "function" then
			plugin.onShowAd(tooltip, adtype, ad);
		end
	end
end

function GuildAdsPlugin_OnShowContextMenu(adtype, ad)
	for listenerName, plugin in GuildAdsPlugin.PluginsList do
		if type(plugin.onShowContextMenu) == "function" then
			--[[
			info = { };
			info.text = listenerName;
			UIDropDownMenu_AddButton(menu, 1);
			]]
			GuildAdsPlugin.addMenuEnabled = true;
			plugin.onShowContextMenu(adtype, ad);
			GuildAdsPlugin.addMenuEnabled = nil;
		end
	end	
end

function GuildAdsPlugin_OnEvent(ltype, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
	local method = EventIdToMethod[ltype];
	for pluginName, plugin in GuildAdsPlugin.PluginsList do
		if type(plugin[method]) == "function" then
			plugin[method](arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
		end
	end
end