--[[
	Conditionals functions for FlexBar
	Last Modified
		02/09/2005	Initial version
		08/16/2005  Added logic to handle non-visible creatures when determining creature type - Ratbert_CP
--]]

local util = Utility_Class:New()
local precedence = {["or<>"] = 1, ["and<>"] = 2, ["not<>"] = 3, ["begin<>"] = 4, ["end<>"] = 5}
local eval = Stack_Class:New()
local parse = Stack_Class:New()


function FB_CheckConditional(ifstr)
-- Function to evaluate the if= 
	local i
	for i in ipairs(parse) do
		parse[i] = nil
	end
	
	for i in ipairs(eval) do
		eval[i] = nil
	end
	
	ifstr = string.gsub(ifstr,"\"","'")
	local capture
	_,_,capture = string.find(ifstr,"(%a+%b<>)")
	if (ifstr == capture) then
	-- A single condition
		local firsti,lasti,capture2 = string.find(capture,"(%b<>)")
		local target = string.sub(capture2,2,-2)
		local iftarg
		if target ~= "" then
			target="iftarg=" .. target
			iftarg=FBcmd:GetParameters(target)["iftarg"]
		else
			iftarg = nil
		end
		local condition = string.lower(string.sub(capture,1,firsti - 1))
		if FBConditions[condition] then
			local dispatch = FBConditions[condition]
			eval:Push(dispatch(iftarg))
		end
	else
	-- This one needs the parser
		ifstr = string.gsub(ifstr,"not ","not<> ")
		ifstr = string.gsub(ifstr,"and ","and<> ")
		ifstr = string.gsub(ifstr,"or " ,"or<> " )
		ifstr = string.gsub(ifstr,"%(","begin<>")
		ifstr = string.gsub(ifstr,"%)","end<>")
		local capture
		for capture in string.gfind(ifstr,"(%w+%b<>)") do
			if not FB_IsOp(capture) then
				local firsti,lasti,capture2 = string.find(capture,"(%b<>)")
				local target = string.sub(capture2,2,-2)
				local iftarg
				if target ~= "" then
					target="iftarg=" .. target
					iftarg=FBcmd:GetParameters(target)["iftarg"]
				else
					iftarg = nil
				end
				local condition = string.lower(string.sub(capture,1,firsti - 1))
				if FBConditions[condition] then
					local dispatch = FBConditions[condition]
					eval:Push(dispatch(iftarg))
				end
			else
				while not parse:IsEmpty() and ((precedence[parse:Top()] > precedence[capture]) or capture=="end<>")  do
					local temp = parse:Pop()
					if temp ~= "begin<>" then
						if temp == "not<>" then
							local value = eval:Pop()
							eval:Push(not value)
						elseif temp == "and<>" then
							local value1 = eval:Pop()
							local value2 = eval:Pop()
							eval:Push(value1 and value2)
						elseif temp == "or<>" then
							local value1 = eval:Pop()
							local value2 = eval:Pop()
							eval:Push(value1 or value2)
						end
					end
				end
				if capture ~= "end<>" then parse:Push(capture) end
			end
		end
		while not parse:IsEmpty() do
			local temp = parse:Pop()
			if temp ~= "begin<>" then
				if temp == "not<>" then
					local value = eval:Pop()
					eval:Push(not value)
				elseif temp == "and<>" then
					local value1 = eval:Pop()
					local value2 = eval:Pop()
					eval:Push(value1 and value2)
				elseif temp == "or<>" then
					local value1 = eval:Pop()
					local value2 = eval:Pop()
					eval:Push(value1 or value2)
				end
			end
		end
	end
	return eval:Top()
end

function FB_IsOp(text)
-- check for an operator
	if text=="not<>" or text=="or<>" or text=="and<>" or text=="begin<>" or text=="end<>" then
		return true
	else
		return false
	end
end

-- Functions to evaluate conditions

-- conditional for hidden
-- if the target is a number - check for the button being hidden
-- if the target is a string, see if there is a global frame of that
-- name and return its hidden state
FBConditions["hidden"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "number" then
				local frame, button = FB_GetWidgets(value)
				if not frame:IsVisible() then
					return true
				end
			elseif type(value) == "string" then
				local frame = getglobal(value)
				if frame and not frame:IsVisible() then
					return true
				end
			end
		end
		return false
	end
	
-- conditional for visible - put in because doing:
-- not hidden<[]> indicates that they are all visible
-- visible<[]> means one of the items is visible
-- if the target is a number - check for the button being visible
-- if the target is a string, see if there is a global frame of that
-- name and return its visible state
FBConditions["visible"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "number" then
				local frame, button = FB_GetWidgets(value)
				if frame:IsVisible() then
					return true
				end
			elseif type(value) == "string" then
				local frame = getglobal(value)
				if frame and frame:IsVisible() then
					return true
				end
			end
		end
		return false
	end
	
-- conditional for remaped
FBConditions["remapped"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "number" then
				if FBState[value]["remap"] then
					return true
				end
			end
		end
		return false
	end

-- conditional for shaded
FBConditions["shaded"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "number" then
				if FBState[value]["icon"] then
					return true
				end
			end
		end
		return false
	end

-- conditional for faded
FBConditions["faded"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "number" then
				if FBState[value]["alpha"] and FBState[value]["alpha"] ~= 10 then
					return true
				end
			end
		end
		return false
	end

-- conditional for scale
FBConditions["scaled"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "number" then
				if FBState[value]["scale"] and FBState[value]["scale"] ~= 10 then
					return true
				end
			end
		end
		return false
	end

-- conditional for enoughmana
FBConditions["enoughmana"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "number" then
				local button = FB_GetWidgets(value)
				local isUsable, notEnoughMana = IsUsableAction(button:GetID());
				if not notEnoughMana then
					return true
				end
			end
		end
		return false
	end

-- conditional for usable
FBConditions["usable"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "number" then
				local button = FB_GetWidgets(value)
				local isUsable, enoughMana = IsUsableAction(button:GetID());
				if isUsable then
					return true
				end
			end
		end
		return false
	end

-- conditional for inrange
FBConditions["inrange"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "number" then
				local button = FB_GetWidgets(value)
				local inRange = IsActionInRange(button:GetID());
				if inRange ~= 0 then
					return true
				end
			end
		end
		return false
	end

-- conditional for incooldown
FBConditions["incooldown"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "number" then
				local button = FB_GetWidgets(value)
				local start = GetActionCooldown(button:GetID());
				if start ~= 0 then
					return true
				end
			end
		end
		return false
	end

-- conditional for isadvanced
FBConditions["isadvanced"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "number" then
				if FBState[value]["advanced"] then
					return true
				end
			end
		end
		return false
	end

-- conditional for isdisabled
FBConditions["isdisabled"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "number" then
				if FBState[value]["disabled"] then
					return true
				end
			end
		end
		return false
	end

-- conditional for unitexists
FBConditions["unitexists"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitExists(value) then
					return true
				end
			end
		end
		return false
	end

-- conditional for unitalive
FBConditions["unitisalive"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitExists(value) and not UnitIsDeadOrGhost(value) then
					return true
				end
			end
		end
		return false
	end

-- conditional for unitishostile
FBConditions["unitishostile"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitExists(value) and UnitIsEnemy("player",value) then
					return true
				end
			end
		end
		return false
	end

-- conditional for unitisfriendly
FBConditions["unitisfriendly"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitExists(value) and UnitIsFriend("player",value) then
					return true
				end
			end
		end
		return false
	end

-- conditional for unitisneutral
FBConditions["unitisneutral"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitExists(value) and not UnitIsEnemy("player",value) and not UnitIsFriend("player",value) then
					return true
				end
			end
		end
		return false
	end


-- conditional for unitiscorpse
FBConditions["unitiscorpse"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitExists(value) and UnitIsDeadOrGhost(value) then
					return true
				end
			end
		end
		return false
	end

-- conditional for unitistapped
FBConditions["unitistapped"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitExists(value) and UnitIsTapped(value) then
					return true
				end
			end
		end
		return false
	end

-- conditional for hasaura
FBConditions["hasaura"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				if string.lower(FBLastform) == string.lower(value) then
					return true
				end
			end
		end
		return false
	end

-- health conditionals
-- below 10%
FBConditions["healthbelow10"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitHealth(value)/UnitHealthMax(value) < .1 then
					return true
				end
			end
		end
		return false
	end

-- below 20%
FBConditions["healthbelow20"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitHealth(value)/UnitHealthMax(value) < .2 then
					return true
				end
			end
		end
		return false
	end

-- below 30%
FBConditions["healthbelow30"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitHealth(value)/UnitHealthMax(value) < .3 then
					return true
				end
			end
		end
		return false
	end

-- below 40%
FBConditions["healthbelow40"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitHealth(value)/UnitHealthMax(value) < .4 then
					return true
				end
			end
		end
		return false
	end

-- below 50%
FBConditions["healthbelow50"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitHealth(value)/UnitHealthMax(value) < .5 then
					return true
				end
			end
		end
		return false
	end

-- below 60%
FBConditions["healthbelow60"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitHealth(value)/UnitHealthMax(value) < .6 then
					return true
				end
			end
		end
		return false
	end

-- below 70%
FBConditions["healthbelow70"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitHealth(value)/UnitHealthMax(value) < .7 then
					return true
				end
			end
		end
		return false
	end

-- below 80%
FBConditions["healthbelow80"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitHealth(value)/UnitHealthMax(value) < .8 then
					return true
				end
			end
		end
		return false
	end

-- below 90%
FBConditions["healthbelow90"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitHealth(value)/UnitHealthMax(value) < .9 then
					return true
				end
			end
		end
		return false
	end

-- below 100%
FBConditions["healthbelow100"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitHealth(value)/UnitHealthMax(value) < 1 then
					return true
				end
			end
		end
		return false
	end

-- above 10%
FBConditions["healthabove10"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitHealth(value)/UnitHealthMax(value) > .1 then
					return true
				end
			end
		end
		return false
	end

-- above 20%
FBConditions["healthabove20"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitHealth(value)/UnitHealthMax(value) > .2 then
					return true
				end
			end
		end
		return false
	end

-- above 30%
FBConditions["healthabove30"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitHealth(value)/UnitHealthMax(value) > .3 then
					return true
				end
			end
		end
		return false
	end

-- above 40%
FBConditions["healthabove40"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitHealth(value)/UnitHealthMax(value) > .4 then
					return true
				end
			end
		end
		return false
	end

-- above 50%
FBConditions["healthabove50"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitHealth(value)/UnitHealthMax(value) > .5 then
					return true
				end
			end
		end
		return false
	end

-- above 60%
FBConditions["healthabove60"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				if UnitHealth(value)/UnitHealthMax(value) > .6 then
					return true
				end
			end
		end
		return false
	end

-- above 70%
FBConditions["healthabove70"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitHealth(value)/UnitHealthMax(value) > .7 then
					return true
				end
			end
		end
		return false
	end

-- above 80%
FBConditions["healthabove80"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitHealth(value)/UnitHealthMax(value) > .8 then
					return true
				end
			end
		end
		return false
	end

-- above 90%
FBConditions["healthabove90"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitHealth(value)/UnitHealthMax(value) > .9 then
					return true
				end
			end
		end
		return false
	end

-- full
FBConditions["healthfull"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitHealth(value)/UnitHealthMax(value) > .99 then
					return true
				end
			end
		end
		return false
	end


-- mana conditionals
-- below 10%
FBConditions["manabelow10"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitMana(value)/UnitManaMax(value) < .1 then
					return true
				end
			end
		end
		return false
	end

-- below 20%
FBConditions["manabelow20"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitMana(value)/UnitManaMax(value) < .2 then
					return true
				end
			end
		end
		return false
	end

-- below 30%
FBConditions["manabelow30"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitMana(value)/UnitManaMax(value) < .3 then
					return true
				end
			end
		end
		return false
	end

-- below 40%
FBConditions["manabelow40"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitMana(value)/UnitManaMax(value) < .4 then
					return true
				end
			end
		end
		return false
	end

-- below 50%
FBConditions["manabelow50"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitMana(value)/UnitManaMax(value) < .5 then
					return true
				end
			end
		end
		return false
	end

-- below 60%
FBConditions["manabelow60"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitMana(value)/UnitManaMax(value) < .6 then
					return true
				end
			end
		end
		return false
	end

-- below 70%
FBConditions["manabelow70"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitMana(value)/UnitManaMax(value) < .7 then
					return true
				end
			end
		end
		return false
	end

-- below 80%
FBConditions["manabelow80"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitMana(value)/UnitManaMax(value) < .8 then
					return true
				end
			end
		end
		return false
	end

-- below 90%
FBConditions["manabelow90"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitMana(value)/UnitManaMax(value) < .9 then
					return true
				end
			end
		end
		return false
	end

-- below 100%
FBConditions["manabelow100"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitMana(value)/UnitManaMax(value) < 1 then
					return true
				end
			end
		end
		return false
	end

-- above 10%
FBConditions["manaabove10"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitMana(value)/UnitManaMax(value) > .1 then
					return true
				end
			end
		end
		return false
	end

-- above 20%
FBConditions["manaabove20"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitMana(value)/UnitManaMax(value) > .2 then
					return true
				end
			end
		end
		return false
	end

-- above 30%
FBConditions["manaabove30"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitMana(value)/UnitManaMax(value) > .3 then
					return true
				end
			end
		end
		return false
	end

-- above 40%
FBConditions["manaabove40"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitMana(value)/UnitManaMax(value) > .4 then
					return true
				end
			end
		end
		return false
	end

-- above 50%
FBConditions["manaabove50"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitMana(value)/UnitManaMax(value) > .5 then
					return true
				end
			end
		end
		return false
	end

-- above 60%
FBConditions["manaabove60"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitMana(value)/UnitManaMax(value) > .6 then
					return true
				end
			end
		end
		return false
	end

-- above 70%
FBConditions["manaabove70"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitMana(value)/UnitManaMax(value) > .7 then
					return true
				end
			end
		end
		return false
	end

-- above 80%
FBConditions["manaabove80"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitMana(value)/UnitManaMax(value) > .8 then
					return true
				end
			end
		end
		return false
	end

-- above 90%
FBConditions["manaabove90"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitMana(value)/UnitManaMax(value) > .9 then
					return true
				end
			end
		end
		return false
	end

-- full
FBConditions["manafull"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				value = string.lower(value)
				if UnitMana(value)/UnitManaMax(value) > .99 then
					return true
				end
			end
		end
		return false
	end

-- in combat
FBConditions["incombat"] = 
	function()
		if FBConditionalState["incombat"] then return true else return false end
	end

-- has aggro
FBConditions["hasaggro"] = 
	function()
		if FBConditionalState["hasaggro"] then return true else return false end
	end

-- shift down
FBConditions["shiftdown"] = 
	function()
		if IsShiftKeyDown() then return true else return false end
	end

-- control down
FBConditions["controldown"] = 
	function()
		if IsControlKeyDown() then return true else return false end
	end

-- alt down
FBConditions["altdown"] = 
	function()
		if IsAltKeyDown() then return true else return false end
	end

-- Is running (for timers such as on raise)
FBConditions["isrunning"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "string" then
				if FBTimers[value]:GetRunning() then
					return true
				end
			end
		end
		return false
	end

-- In group - is cursor in group bounds
FBConditions["ingroup"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if type(value) == "number" then
				local x,y = GetCursorPosition()
				if FB_InGroupBounds(value, x, y) then
					return true
				end
			end
		end
		return false
	end

-- check for custom condition - no target
FBConditions["custom"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			if FBCustom[value] then return true end
		end
		return false
	end

-- check for buff existing
FBConditions["hasbuff"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		if not FBLastBuffs["buffs"]["player"] then return false end
		
		local index, value
		for index, value in pairs(target) do
			value = string.lower(value)
			if FBLastBuffs["buffs"]["player"][value] then 
				return true 
			end
		end
		return false
	end

-- check for debuff existing
FBConditions["hasdebuff"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		
		if not FBLastBuffs["debuffs"]["player"] then return false end
		
		local index, value
		for index, value in pairs(target) do
			value = string.lower(value)
			if FBLastBuffs["debuffs"]["player"][value] then 
				return true 
			end
		end
		return false
	end

-- check for debufftype existing
FBConditions["hasdebufftype"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		
		if not FBLastBuffs["buffs"]["player"] then return false end
		
		local index, value
		for index, value in pairs(target) do
			value = string.lower(value)
			if FBLastBuffs["debufftypes"]["player"][value] then 
				return true 
			end
		end
		return false
	end

-- unit version takes unit, buff list 
FBConditions["unitbuff"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			return false
		end

		local i=1
		while target[i] do
			target[i] = string.lower(target[i])
			i=i+1
		end

		if not FBLastBuffs["buffs"][target[1]] then return false end

		local index = 2
		while target[index] do
			if FBLastBuffs["buffs"][target[1]][target[index]] then 
				return true 
			end
			index = index+1
		end
		return false
	end

-- unit version takes unit, debuff list 
FBConditions["unitdebuff"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			return false
		end
		
		local i=1
		while target[i] do
			target[i] = string.lower(target[i])
			i=i+1
		end

		if not FBLastBuffs["debuffs"][target[1]] then return false end
		
		local index = 2
		while target[index] do
			if FBLastBuffs["debuffs"][target[1]][target[index]] then 
				return true 
			end
			index = index+1
		end
		return false
	end

-- unit version takes unit, debufftype list 
FBConditions["unitdebufftype"] = 
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			return false
		end

		local i=1
		while target[i] do
			target[i] = string.lower(target[i])
			i=i+1
		end

		if not FBLastBuffs["debufftypes"][target[1]] then return false end

		local index = 2
		while target[index] do
			if FBLastBuffs["debufftypes"][target[1]][target[index]] then 
				return true 
			end
			index = index+1
		end

		return false
	end

FBConditions["unitcreaturetype"] = 
    function(target)
        if not target then return false end
        if type(target) ~= "table" then
            return false
        end

		local i=1
		while target[i] do
			target[i] = string.lower(target[i])
			i=i+1
		end
		
		-- Validate UnitCreatureType and UnitExists
		-- If you target a non-visible creature, the unitcreaturetype conditional will fail
		-- I think (untested as of 8/16/2005) that when the target becomes visible, another PLAYER_TARGET_CHANGED
		-- event will fire, causing a new GainTarget event, thereby updating the creature type.
		local targetType
        if not UnitExists(target[1]) then 
			return false
		else
			targetType = UnitCreatureType(target[1])
			if targetType == nil then return false end
			targetType = string.lower(targetType)
		end
		
        local index = 2
        while target[index] do
            if targetType == target[index] then return true end
            index = index+1
        end
        return false
    end

FBConditions["unitclass"] = 
    function(target)
		-- returns true if the first element in target is any of the classes specified in the following elements
        if not target then return false end
        if type(target) ~= "table" then
            return false
        end

		local i=1
		while target[i] do
			target[i] = string.lower(target[i])
			i=i+1
		end

        if not UnitExists(target[1]) then return false end
        
        local index = 2
        while target[index] do
            if string.lower(UnitClass(target[1])) == target[index] then return true end
            index = index+1
        end
        return false
    end

local list = { "player","pet","party1","party2","party3","party4","partypet1","partypet2","partypet3","partypet4" }
FBConditions["partydebufftype"] = 
    function(target)
	-- returns true if any of the party have one of the specified debufftypes
        if not target then return false end
        if type(target) ~= "table" then
            return false
        end

		local i=1
		while target[i] do
			target[i] = string.lower(target[i])
			i=i+1
		end

        local index = 1
        while target[index] do
			for i, unit in ipairs(list) do
				if UnitExists(unit) and FBLastBuffs["debufftypes"][unit][target[index]] then 
					return true
				end
			end
            index = index+1
        end
        return false
    end

-- Check for having an main hand item enchantment
FBConditions["mainhandenchant"] = 
	function(target)
		local 	hasMainHandEnchant, mainHandExpiration, mainHandCharges,
				hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo() 
		if hasMainHandEnchant then return true else return false end
	end

-- Check for Main hand charges equal to target
FBConditions["mainhandchargeseq"] =
	function(target)
		if not target then return false end
		if type(target) ~= "number" then return false end
		local 	hasMainHandEnchant, mainHandExpiration, mainHandCharges,
				hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo() 
		if not hasMainHandEnchant or mainHandCharges ~= target then return false else return true end
	end

-- Check for Main hand charges greater than target
FBConditions["mainhandchargesgt"] =
	function(target)
		if not target then return false end
		if type(target) ~= "number" then return false end
		local 	hasMainHandEnchant, mainHandExpiration, mainHandCharges,
				hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo() 
		if not hasMainHandEnchant or mainHandCharges <= target then return false else return true end
	end

-- Check for Main hand charges less than target
FBConditions["mainhandchargeslt"] =
	function(target)
		if not target then return false end
		if type(target) ~= "number" then return false end
		local 	hasMainHandEnchant, mainHandExpiration, mainHandCharges,
				hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo() 
		if not hasMainHandEnchant or mainHandCharges >= target then return false else return true end
	end

-- Check for having an off hand item enchantment
FBConditions["offhandenchant"] = 
	function(target)
		local 	hasMainHandEnchant, mainHandExpiration, mainHandCharges,
				hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo() 
		if hasOffHandEnchant then return true else return false end
	end

-- Check for Off hand charges equal to target
FBConditions["offhandchargeseq"] =
	function(target)
		if not target then return false end
		if type(target) ~= "number" then return false end
		local 	hasMainHandEnchant, mainHandExpiration, mainHandCharges,
				hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo() 
		if not hasOffHandEnchant or OffHandCharges ~= target then return false else return true end
	end

-- Check for Off hand charges greater than target
FBConditions["offhandchargesgt"] =
	function(target)
		if not target then return false end
		if type(target) ~= "number" then return false end
		local 	hasMainHandEnchant, mainHandExpiration, mainHandCharges,
				hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo() 
		if not hasOffHandEnchant or offHandCharges <= target then return false else return true end
	end

-- Check for Off hand charges less than target
FBConditions["offhandchargeslt"] =
	function(target)
		if not target then return false end
		if type(target) ~= "number" then return false end
		local 	hasMainHandEnchant, mainHandExpiration, mainHandCharges,
				hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo() 
		if not hasOffHandEnchant or offHandCharges >= target then return false else return true end
	end

-- Check for Main hand charges equal to target
FBConditions["mainhandchargeseq"] =
	function(target)
		if not target then return false end
		if type(target) ~= "number" then return false end
		local 	hasMainHandEnchant, mainHandExpiration, mainHandCharges,
				hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo() 
		if not hasMainHandEnchant or mainHandCharges ~= target then return false else return true end
	end

-- Check for Main hand charges greater than target
FBConditions["mainhandchargesgt"] =
	function(target)
		if not target then return false end
		if type(target) ~= "number" then return false end
		local 	hasMainHandEnchant, mainHandExpiration, mainHandCharges,
				hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo() 
		if not hasMainHandEnchant or mainHandCharges <= target then return false else return true end
	end

-- Check for having item
FBConditions["hasitem"] =
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			value = string.lower(value)
			if FBBagContents[value] then return true end
		end
		return false
	end

-- Check for Affecting Combat
FBConditions["affectingcombat"] =
	function(target)
		if not target then return false end
		if type(target) ~= "table" then
			target = { target }
		end
		
		local index, value
		for index, value in pairs(target) do
			value = string.lower(value)
			if UnitAffectingCombat(value) then return true end
		end
		return false
	end

-- Check for Combo Point equal to target
FBConditions["comboptseq"] =
	function(target)
		if not target then return false end
		if type(target) ~= "number" then return false end
		
		if GetComboPoints() == target then return true else return false end
	end

-- Check for Combo Point lessthan to target
FBConditions["comboptslt"] =
	function(target)
		if not target then return false end
		if type(target) ~= "number" then return false end
		
		if GetComboPoints() < target then return true else return false end
	end

-- Check for Combo Point greater than to target
FBConditions["comboptsgt"] =
	function(target)
		if not target then return false end
		if type(target) ~= "number" then return false end
		
		if GetComboPoints() > target then return true else return false end
	end

FBConditions["true"] = function() return true end
FBConditions["false"] = function() return false end 
