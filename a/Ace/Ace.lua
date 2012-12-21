--[[--------------------------------------------------------------------------------

  Ace

  Author:  Kaelten (kaelten@gmail.com)
  Website: http://www.wowace.com

-----------------------------------------------------------------------------------]]
local MYADDONS_TABLE = {
	audio			= "MYADDONS_CATEGORY_AUDIO",
	bars			= "MYADDONS_CATEGORY_BARS",
	battlegrounds	= "MYADDONS_CATEGORY_BATTLEGROUNDS",
	chat			= "MYADDONS_CATEGORY_CHAT",
	class			= "MYADDONS_CATEGORY_CLASS",
	combat			= "MYADDONS_CATEGORY_COMBAT",
	compilations	= "MYADDONS_CATEGORY_COMPILATIONS",
	development		= "MYADDONS_CATEGORY_DEVELOPMENT",
	guild			= "MYADDONS_CATEGORY_GUILD",
	interface		= "MYADDONS_CATEGORY_PLUGINS",
	inventory		= "MYADDONS_CATEGORY_INVENTORY",
	map				= "MYADDONS_CATEGORY_MAP",
	others			= "MYADDONS_CATEGORY_OTHERS",
	modules			= "MYADDONS_CATEGORY_PLUGINS",
	professions		= "MYADDONS_CATEGORY_PROFESSIONS",
	quests			= "MYADDONS_CATEGORY_QUESTS",
	raid			= "MYADDONS_CATEGORY_RAID",
};

local MYADDONS_ACE_CROSSCAT = {};
MYADDONS_ACE_CROSSCAT["Audio"]							= "MYADDONS_CATEGORY_AUDIO"
MYADDONS_ACE_CROSSCAT["Interface Bars"]					= "MYADDONS_CATEGORY_BARS"
MYADDONS_ACE_CROSSCAT["Battlegrounds"]					= "MYADDONS_CATEGORY_BATTLEGROUNDS"
MYADDONS_ACE_CROSSCAT["Chat/Communications"]			= "MYADDONS_CATEGORY_CHAT"
MYADDONS_ACE_CROSSCAT["Class Enhancement"]				= "MYADDONS_CATEGORY_CLASS"
MYADDONS_ACE_CROSSCAT["Combat/Casting"]					= "MYADDONS_CATEGORY_COMBAT"
MYADDONS_ACE_CROSSCAT["Compilations"]					= "MYADDONS_CATEGORY_COMPILATIONS"
MYADDONS_ACE_CROSSCAT["Interface Enhancements"]			= "MYADDONS_CATEGORY_OTHERS"
MYADDONS_ACE_CROSSCAT["Development Tools"]				= "MYADDONS_CATEGORY_DEVELOPMENT"
MYADDONS_ACE_CROSSCAT["Guild"]							= "MYADDONS_CATEGORY_GUILD"
MYADDONS_ACE_CROSSCAT["Inventory/Item Enhancements"]	= "MYADDONS_CATEGORY_INVENTORY"
MYADDONS_ACE_CROSSCAT["Map Enhancements"]				= "MYADDONS_CATEGORY_MAP"
MYADDONS_ACE_CROSSCAT["Others"]							= "MYADDONS_CATEGORY_OTHERS"
MYADDONS_ACE_CROSSCAT["Interface Enhancements"]			= "MYADDONS_CATEGORY_PLUGINS"
MYADDONS_ACE_CROSSCAT["Professions"]					= "MYADDONS_CATEGORY_PROFESSIONS"
MYADDONS_ACE_CROSSCAT["Quest Enhancements"]				= "MYADDONS_CATEGORY_QUESTS"
MYADDONS_ACE_CROSSCAT["Raid Assistance"]				= "MYADDONS_CATEGORY_RAID"

local ACE_VERSION		= "1.3"
local ACE_COMP_VERSION	= 103
local ACE_RELEASE		= "1-05-2005"
local ACE_WEBSITE		= "http://www.wowace.com"

TRUE  = 1
FALSE = nil

SlashCmdList["RELOAD"] = ReloadUI


--[[--------------------------------------------------------------------------------
  Class Setup
-----------------------------------------------------------------------------------]]

-- AceCore just provides a debug method for all Ace classes.
AceCore = {}
-- Compatibility reference, deprecated use
AceCoreClass = AceCore


-- Object constructor
function AceCore:new(o)
	self.__index = self
	return setmetatable(o or {}, self)
end

function AceCore:debug(...)
	if( ace.debugger ) then
		ace.debugger:Message((self.app or {}).name or self.name or ACE_NAME, arg)
	end
end

-- The class for the main Ace object
Ace = AceCore:new({
	name		= ACE_NAME,
	description = ACE_DESCRIPTION,
	version		= ACE_VERSION,
	website		= ACE_WEBSITE,
	addons		= {numLoaded=0,numAceAddons=0,numAceApps=0,list={}},
	gVersion	= 0,
	tVersion	= 0,
	fVersion	= 0,
	langs 		= {"deDE", "frFR", "koKR", "usEN", "zhCN"},
	_load		= {},
	category	= "development",
})
-- Compatibility reference, deprecated use
AceClass = Ace

function Ace:new(c,t)
	return AceCore.new(c or self,t)
end


--[[--------------------------------------------------------------------------------
  Core Ace Methods
-----------------------------------------------------------------------------------]]

function Ace:call(obj, meth, ...)
	return function(...) return obj[meth](obj, unpack(arg)) end
end

function Ace:print(...)
	local r,g,b,frame,delay
	if( type(arg[1]) == "table" ) then
		r,g,b,frame,delay = unpack(tremove(arg,1))
	end
	(frame or DEFAULT_CHAT_FRAME):AddMessage(self.concat(arg),r,g,b,1,delay or 5)
end


--[[--------------------------------------------------------------------------------
  Addon Registering
-----------------------------------------------------------------------------------]]

function Ace:LoadTranslation(id)
	local loader = getglobal(id.."_Locals_"..GetLocale())
	if( loader ) then loader() loader = TRUE end
	for _, lang in self.langs do
		setglobal(id.."_Locals_"..lang, nil)
	end
	return loader
end

function Ace:RegisterFunctions(class, utils)
	if( not utils ) then utils = class; class = nil end
	local ver = self.tonum(utils.version)
	-- Clear the version so it doesn't get registered.
	utils.version = nil
	for name, val in utils do
		if( (not Ace[name]) and ((ver >= self.fVersion) or (not self[name])) ) then
			self[name] = nil
			self[name] = val
		end
		if( class ) then class[name] = self[name] end
	end
	if( ver > self.fVersion ) then self.fVersion = ver end
	utils = nil
end

function Ace:RegisterGlobals(globals)
	local ver, trans = self.tonum(globals.version), globals.translation
	-- Clear the version and translation so they don't get registered.
	globals.version		= nil
	globals.translation = nil
	-- A specific translation takes precedence over the default. If the translation matches
	-- the current locale, it will get used no matter what the default global version is.
	for name, val in globals do
		if( (ver >= self.gVersion) or ((trans == GetLocale()) and (ver >= self.tVersion)) or
			(not getglobal(name))
		) then
			setglobal(name,val)
		end
	end
	if( ver > self.gVersion ) then self.gVersion = ver end
	if( (trans == GetLocale()) and (ver > self.tVersion) ) then self.tVersion = ver end
	globals = nil
end

function Ace:RegisterForLoad(app)
	self.registry:set(app.name, app)
	tinsert(self._load, app)
end


--[[--------------------------------------------------------------------------------
  Dynamic Loading of Ace Addons
-----------------------------------------------------------------------------------]]

function Ace:LoadAddon()
	local id = strlower(arg1)

	if( not self.addons.list[id] ) then
		local _, title, _, _, loadable = GetAddOnInfo(arg1)
		self.addons.list[id] = {
			name	 = name,
			title	 = title or name,
			loadable = TRUE
		}
	end

	self.addons.list[id].name	= arg1
	self.addons.list[id].loaded = TRUE
	self.addons.numLoaded = self.addons.numLoaded + 1

	for _, dep in {GetAddOnDependencies(arg1)} do
		if( strlower(dep) == "ace" ) then
			self.addons.list[id].ace = TRUE
			self.addons.numAceAddons = self.addons.numAceAddons + 1
			break
		end
	end

	if( getn(self._load) < 1 ) then	return end

	local _, _, notes = GetAddOnInfo(arg1)
	local apps = {unpack(self._load)}
	self.addons.list[id].apps = self._load
	self.addons.numAceApps	 = self.addons.numAceApps + getn(self._load)
	self._load = {}

	for _, app in self.addons.list[id].apps do
		if( not app.description ) then app.description = notes end
		if( self.initialized ) then self:InitializeApp(app) end
	end
end

function Ace:InitializeAppDB(app)
	if( app.db ) then
		app.db.app	 = app
		-- Deprecated 'addon' variable
		app.db.addon = app
		app.db:Initialize()
	end
end

function Ace:InitializeApp(app)
	if( ace.tonum(app.aceCompatible) > ACE_COMP_VERSION ) then
		app.aceMismatch = TRUE
		return
	end

	self:InitializeAppDB(app)
	self.db:LoadAddonProfile(app)

	if( app.db ) then
		app.disabled = app.db:get(app.profilePath, "disabled")
	end

	if( app.cmd ) then
		app.cmd.app	  = app
		-- Deprecated 'addon' variable
		app.cmd.addon = app
	end
	if( app.Initialize ) then app.Initialize(app) end
	if( app.cmd and app.cmd._cmdList and (not app.cmd.registered) ) then
		app.cmd:Register(app)
	end
	self:RegisterAddon(app)
	app.initialized = TRUE
	self.event:TriggerEvent(strupper(app.name).."_LOADED")

	if( (not app.disabled) and app.Enable ) then app.Enable(app) end
	if( not app.disabled ) then
		self.event:TriggerEvent(strupper(app.name).."_ENABLED")
	end
end

-- Register the application configuration with myAddOns so that it will be listed
-- in the myAddOns menu.
function Ace:RegisterAddon(app)
	if (myAddOnsFrame_Register) then
		local appdata = {
			name = app.name,
			version = app.version,
			releaseDate = app.releaseDate,
			author = app.author,
			email = app.email,
			website = app.website,
			category = getglobal(MYADDONS_TABLE[strlower(app.category or app.catagory or "")] or MYADDONS_ACE_CROSSCAT[app.category] or "MYADDONS_CATEGORY_OTHERS"),
			optionsframe = app.optionsFrame
		};
		myAddOnsFrame_Register(appdata);
	end
end


--[[--------------------------------------------------------------------------------
  Core Utilities Used by Ace
-----------------------------------------------------------------------------------]]

function Ace.ParseWords(str, pat)
	if( ace.tostr(str) == "" ) then return {} end
	local list = {}
	for word in gfind(str, pat or "%S+") do
		tinsert(list, word)
	end
	return list
end

-- Recursively iterate through the table and sub-tables until the entire table
-- structure is copied over. Note: I used to check whether the table was numerically
-- indexed and use two different for() loops, one with ipairs() and one without. I
-- did this because there seemed to be problems otherwise, but in rewriting this, I
-- haven't encountered any problems.
function Ace.CopyTable(into, from)
	for key, val in from do
		if( type(val) == "table" ) then
			if( not into[key] ) then into[key] = {} end
			ace.CopyTable(into[key], val)
		else
			into[key] = val
		end
	end
	
	if (getn(from)) then
		table.setn(into, getn(from))		
	end

	return into
end

function Ace.GetTableKeys(tbl)
	local t = {}
	for key, val in pairs(tbl) do
		tinsert(t, key)
	end
	return(t)
end

function Ace.TableFindKeyCaseless(tbl, key)
	key = strlower(key)
	for i, val in tbl do
		if( strlower(i) == key ) then return i, val end
	end
end

function Ace.TableFindByKeyValue(tbl, key, val, caseless)
	if( not tbl ) then error("No table supplied to TableFindByKeyValue.", 2) end
	for i, t in ipairs(tbl) do
		if( (caseless and (strlower(t[key]) == strlower(val))) or (t[key] == val) ) then
			return i, t
		end
	end
end

function Ace.concat(t,sep)
	local msg = ""
	if( getn(t) > 0 ) then
		for key, val in ipairs(t) do
			if( msg ~= "" and sep ) then msg = msg..sep end
			msg = msg..ace.tostr(val)
		end
	else
		for key, val in t do
			if( msg ~= "" and sep ) then msg = msg..sep end
			msg = msg..key.."="..ace.tostr(val)
		end
	end
	return msg
end

function Ace.round(num)
	return floor(ace.tonum(num)+.5)
end

function Ace.sort(tbl, comp)
	sort(tbl, comp)
	return tbl
end

function Ace.strlen(str)
	return strlen(str or "")
end

function Ace.tonum(val, base)
	return tonumber((val or 0), base) or 0
end

function Ace.tostr(val)
	return tostring(val or "")
end

function Ace.toggle(val)
	if( val ) then return FALSE end
	return TRUE
end

function Ace.trim(str, opt)
	if( (not opt) or (opt=="left" ) ) then str = gsub(str, "^%s*", "") end
	if( (not opt) or (opt=="right") ) then str = gsub(str, "%s*$", "") end
	return str
end


--[[--------------------------------------------------------------------------------
  Helpful References
-----------------------------------------------------------------------------------]]

-- Pointer to maintain backwards reference compatibility
ace = Ace

-- Functions left unmapped in the UI. Mapped here for consistency.
concat	 = table.concat
gfind	 = string.gfind
strrep	 = string.rep