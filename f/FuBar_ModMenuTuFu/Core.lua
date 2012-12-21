
local dewdrop = AceLibrary("Dewdrop-2.0")
local compost = AceLibrary("Compost-2.0")
local console = AceLibrary("AceConsole-2.0")

local curraddon
local reasons, sortauthors, sortcategories, sorttags = {}, {}, {}, {}
local deps, tagstrings = {"Ace", "FuBar", "oRA"}, {
	Ace2 = "cff7fff7f.*Ace2",
	FuBar = "FuBar",
}


FuBar_ModMenuTuFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")
FuBar_ModMenuTuFu:RegisterDB("ModMenuTuFuDB")
FuBar_ModMenuTuFu.hasIcon = "Interface\\Icons\\Trade_Engineering"
FuBar_ModMenuTuFu.overrideMenu = true
FuBar_ModMenuTuFu.hasNoText = true


local function ValidateAuthor(i, auth)
	return auth == GetAddOnMetadata(i, "Author")
end


local function ValidateCategory(i, cat)
	if cat == "Unknown" then cat = nil end
	return cat == "All Mods" or cat == GetAddOnMetadata(i, "X-Category")
end


local function ValidateDependant(i, dep)
	local _, title = GetAddOnInfo(i)
	if tagstrings[dep] and string.find(title, tagstrings[dep]) then return true end

	local d = compost:Acquire(GetAddOnDependencies(i))
	local found
	for _,v in pairs(d) do if v == dep then found = true end end
	compost:Reclaim(d)
	return found
end


function FuBar_ModMenuTuFu:OnInitialize()
	local authors, categories, tags = compost:Acquire(), compost:Acquire(), compost:Acquire()

	for i=1,GetNumAddOns() do
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i)
		local isondemand = IsAddOnLoadOnDemand(i)
		local author = GetAddOnMetadata(i, "Author")
		local category = GetAddOnMetadata(i, "X-Category")
		local addname = self:GetOnDemandText(i)

		if author then authors[author] = true end
		if category then categories[category] = true end

		for dep in pairs(tagstrings) do if ValidateDependant(i, dep) then tags[dep] = true end end
		for _,dep in pairs(deps) do if ValidateDependant(i, dep) then tags[dep] = true end end
	end

	for i in pairs(authors) do table.insert(sortauthors, i) end
	for i in pairs(categories) do table.insert(sortcategories, i) end
	for i in pairs(tags) do table.insert(sorttags, i) end
	table.sort(sortauthors)
	table.sort(sortcategories)
	table.sort(sorttags)

	compost:ReclaimMulti(authors, categories, tags)
end


function FuBar_ModMenuTuFu:OnMenuRequest(level, v1, intip, v2, v3, v4)
	if level == 1 then
		dewdrop:AddLine("text", "By Category", "value", "By Category", "hasArrow", true)
		dewdrop:AddLine("text", "By Author", "value", "By Author", "hasArrow", true)
		dewdrop:AddLine("text", "By Dependancy", "value", "By Dependancy", "hasArrow", true)
		dewdrop:AddLine("text", "FuBar Options", "value", "FuBar Options", "hasArrow", true)
	elseif level == 2 then
		if v1 == "By Category" then
			for _,i in ipairs(sortcategories) do dewdrop:AddLine("text", i, "value", i, "hasArrow", true) end
			dewdrop:AddLine()
			dewdrop:AddLine("text", "Unknown", "value", "Unknown", "hasArrow", true)
			dewdrop:AddLine()
			dewdrop:AddLine("text", "All Mods", "value", "All Mods", "hasArrow", true)
		elseif v1 == "By Author" then
			for _,i in ipairs(sortauthors) do dewdrop:AddLine("text", i, "value", i, "hasArrow", true) end
		elseif v1 == "By Dependancy" then
			for _,i in ipairs(sorttags) do dewdrop:AddLine("text", i, "value", i, "hasArrow", true) end
		elseif v1 == "FuBar Options" then self:AddImpliedMenuOptions(2) end
	elseif self:AddImpliedMenuOptions(2) then
	elseif level == 3 then
		if v2 == "By Category" then self:BuildAddonMenu(v1, ValidateCategory)
		elseif v2 == "By Author" then self:BuildAddonMenu(v1, ValidateAuthor)
		elseif v2 == "By Dependancy" then self:BuildAddonMenu(v1, ValidateDependant) end
	else
		if level == 4 then curraddon = v1 end
		dewdrop:FeedAceOptionsTable(curraddon, 3)
	end
end


function FuBar_ModMenuTuFu:BuildAddonMenu(value, validator)
	for i=1,GetNumAddOns() do
		if validator(i, value) then
			local name, title, notes = GetAddOnInfo(i)
			local cmds = self:GetAddonCommandTable(name)
			dewdrop:AddLine("text", self:GetOnDemandText(i), "func", self.HandleModClick, "arg1", self, "arg2", name,
				"tooltipTitle", title, "tooltipText", notes, "hasArrow", cmds, "value", cmds)
		end
	end
end


function FuBar_ModMenuTuFu:GetAddonCommandTable(addon)
	for k,v in pairs(console.registry) do
		if type(v) == "table" and v.handler and v.handler.name == addon then
			return v
		end
	end
end


function FuBar_ModMenuTuFu:HandleModClick(addon)
	local name, _, _, enabled = GetAddOnInfo(addon)

	if enabled then DisableAddOn(name)
	else EnableAddOn(name) end
end


local function getreason(r)
	if not reasons[r] then reasons[r] = TEXT(getglobal("ADDON_"..r)) end
	return reasons[r]
end


function FuBar_ModMenuTuFu:GetOnDemandText(i)
	local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i)
	local loaded  = IsAddOnLoaded(i)
	local isondemand = IsAddOnLoadOnDemand(i)
	local color, note

	if reason == "DISABLED" then color, note = "|cff9d9d9d", getreason(reason) -- Grey
	elseif reason == "NOT_DEMAND_LOADED" then color, note = "|cff0070dd", getreason(reason) -- Blue
	elseif reason then color, note = "|cffff8000", getreason(reason) -- Orange
	elseif loadable and isondemand and not loaded and enabled then color, note = "|cff1eff00", "Loadable OnDemand" -- Green
	elseif loaded and not enabled then color, note = "|cffa335ee", "Disabled on reloadUI" -- Purple
	else return title end  -- White

	return string.format("%s%s %s(%s)|r", color, title, color, note)
end



