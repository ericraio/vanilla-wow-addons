
function AceTimer:AddModule(cmdopt)
	local module = {}
	setmetatable(module, { __index = self })
	if cmdopt then 
		table.insert(self.cmd.options, cmdopt)
		self[cmdopt.method] = function (_, ...) 
			return module[cmdopt.method](module, unpack(arg))
		end
	end
	self.modules[module] = true
	return module
end
function AceTimer:DelModule(module)
	self.modules[module] = nil
end

function AceTimer:InitModules()
	for k, v in self.modules do
		if rawget (k, "Initialize") then k:Initialize() end
	end
end

function AceTimer:EnableModules()
	for k, v in self.modules do 
		if rawget (k, "Enable") then k:Enable() end
	end
end

function AceTimer:DisableModules()
	for k, v in self.modules do 
		if rawget (k, "Disable") then k:Disable() end
	end
end

function AceTimer:ReportModules()
	for k, v in self.modules do 
		if rawget (k, "Report") then k:Report() end
	end
end
