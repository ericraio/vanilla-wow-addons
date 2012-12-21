
local ACE_DB_TIMESTAMP_FMT = "%Y%m%d%H%M%S"

-- Class Setup
AceDatabase = AceCore:new()
-- Compatibility reference, deprecated use
AceDbClass  = AceDatabase

-- Object constructor
function AceDatabase:new(val, seed)
	o = ace:new(self, {seed=seed})
	if( type(val)=="string" ) then
		o.name = val
	else
		o._table = val or {}
		o.initialized = TRUE
	end
	return o
end

function AceDatabase:Initialize()
	if( self.initialized ) then return end
	self.initialized = TRUE

	self._table = getglobal(self.name)
	if( self._table ) then return end

	self._table = {}
	setglobal(self.name, self._table)
	if( self.seed ) then
		ace.CopyTable(self._table, self.seed)
	end
	self.created = TRUE

	return self.created
end

function AceDatabase:_DelvePath(node, path)
	local key, parent
	for _, val in ipairs(path) do
		parent = node
		key    = val
		if( type(val)=="table" ) then
			node, parent, key = self:_DelvePath(node, val)
			if( not node ) then return end
		elseif( not node[val] ) then
			-- If we're not creating the path and the node doesn't exist, we're done.
			if( not self.create ) then return end
			node[val] = {}
			node = node[val]
		else
			node = node[val]
		end
	end
	return node, parent, key
end

function AceDatabase:_GetNode(path, create)
	if( not path ) then return self._table end
	self.create = create
	local node, parent, key = self:_DelvePath(self._table, path)
	self.create = FALSE
	return node, parent, key
end

function AceDatabase:_GetArgs(arg)
	if( type(arg[1]) == "table" ) then
		return arg[1], arg[2], arg[3], arg[4]
	end
	return nil, arg[1], arg[2], arg[3]
end

function AceDatabase:get(...)
	if( getn(arg) < 1 ) then return self._table end
	local path, key = self:_GetArgs(arg)
	if (type(self:_GetNode(path) or {}) == "string") then
		error("Bad Path", 2);
	end
	return (self:_GetNode(path) or {})[key]
end

function AceDatabase:set(...)
	local path, key, val = self:_GetArgs(arg)
	local node = self:_GetNode(path, TRUE)
	if( not key ) then error("No key supplied to AceDatabase:set.", 2) end
	node[key] = val
	return node[key]
end

function AceDatabase:toggle(...)
	local path, key = self:_GetArgs(arg)
	local node = self:_GetNode(path, TRUE)
	if( not key ) then error("No key supplied to AceDatabase:toggle.", 2) end
	node[key]  = ace.toggle(node[key])
	return node[key]
end

function AceDatabase:insert(...)
	local path, key, val, pos = self:_GetArgs(arg)
	local node = self:_GetNode(path, TRUE)
	if( not key ) then error("No key supplied to AceDatabase:insert.", 2) end
	if( not node[key] ) then node[key] = {} end
	if( pos ) then tinsert(node[key], pos, val)
	else tinsert(node[key], val)
	end
end

function AceDatabase:remove(...)
	local path, key, pos = self:_GetArgs(arg)
	local node = self:_GetNode(path, TRUE)
	if( not key ) then error("No key supplied to AceDatabase:remove.", 2) end
	return tremove(node[key], pos)
end

function AceDatabase:reset(path, seed)
	if( path ) then
		local _, parent, key = self:_GetNode(path)
		if( (not parent) or (not key) ) then return end
		parent[key] = {}
		if( seed ) then ace.CopyTable(parent[key], seed) end
		return parent[key]
	else
		self._table = {}
		if( self.name ) then setglobal(self.name, self._table) end
		if( seed or self.seed ) then
			ace.CopyTable(self._table, seed or self.seed)
		end
		return self._table
	end
end

function AceDatabase:timestamp()
	return date(ACE_DB_TIMESTAMP_FMT)
end
