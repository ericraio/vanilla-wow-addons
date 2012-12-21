-- contains all selection components
components = {}; 

function Selection_Initialize(component, name, callback)
	components[component:GetName()] = {};
	local c = components[component:GetName()];
	c["values"] = {};
	c["names"] = {};
	c["index"] = 1;
	c["callback"] = callback;
	Selection_SetName(component, name);
end

-- sets component name (visible above control)
function Selection_SetName(component, name)
	local c = components[component:GetName()];
	c["name"] = name;
	getglobal(component:GetName().."Name"):SetText(name);
end

-- updates component selected name to match current index
function Selection_UpdateText(component)
	local c = components[component:GetName()];
	getglobal(component:GetName().."Text"):SetText(c.names[c.index]);
end

function Selection_GetSelectedName(component)
	local c = components[component:GetName()];
	return c.names[c.index];
end

function Selection_GetSelectedValue(component)
	local c = components[component:GetName()];
	return c.values[c.index];
end

function Selection_AddSelection(component, value, name)
	local c = components[component:GetName()];
	table.insert(c.values, value);
	table.insert(c.names, name);
end

function Selection_SetSelectedValue(component, value)
	local c = components[component:GetName()];
	c.index = value;
	Selection_UpdateText(component);
	c.callback(c.index);
end

function Selection_Prev(component)
	local c = components[component:GetName()];
	if (c.index-1 < 1) then
		return;
	end
	c.index = c.index - 1;
	Selection_UpdateText(component);
	c.callback(c.index);
end

function Selection_Next(component)
	local c = components[component:GetName()];
	if (c.index+1 > table.getn(c.values)) then
		return;
	end
	c.index = c.index + 1;
	Selection_UpdateText(component);
	c.callback(c.index);
end