--[[
This Lib is made ofr Silvanas Addon it gives some commen functions like print,printf,select,varprint
--i use it so i dont have to redecleare the function so i wont use duoble memory space it u have multiple silvanas addons installed
--it is not a stand along addon jsut a file to include and other ui mods are welkome ot use it aslog as they dont moddify it :P

--well that all
]]--

SilvanasLibVersion = 1.1

if (not Silvanas) or (Silvanas.Version < SilvanasLibVersion) then

	Silvanas = {
	    --Libary version
		Version = SilvanasLibVersion,
		--hold a list of mods and thier info of registred mods
		LoadedMods = {},
		
		--Basic print function
		Print = function(msg)
			if msg and DEFAULT_CHAT_FRAME then
				DEFAULT_CHAT_FRAME:AddMessage(msg)
			end
		end,
		
		--Basic print function to the 2nd chat window
		Print2 = function(msg)
		    if msg and ChatFrame2 then
		        ChatFrame2:AddMessage(msg)
			elseif msg then
			    DEFAULT_CHAT_FRAME:AddMessage(msg)
			end
		end,
		
		--Print whit text formatting
		Printf = function(...)
			Silvanas.Print(string.format(unpack(arg)))
		end,
		
		--Returns a string represention of the variable
		VarPrint = function(variable)
			local vartype = type(variable)
			if vartype == "string" then
				return variable
			elseif vartype == "number" then
				return tostring(variable)
    		elseif vartype == "boolean" then
    			if variable then
        			return "true"
				else
					return "false"
				end
			else
        		return vartype
			end
		end,

        --Argument selector
		Select = function(num,...)
			return arg[num]
		end,

		--Popup message
		Message = function(msg)
		    message("|cFFFFFFFF".. msg .."|r")
		end,
		
		--/ Command addfunction
		AddCmd = function(Name,Function,CmdTable)
		    if (type(CmdTable) == "table") and (type(Function) == "function") and (type(Name) == "string") then
		        local i,max
		        max = table.getn(CmdTable)

		    	if max > 0 then
		    	    SlashCmdList[Name] = Function
		    	
		    	    for i=1,max,1 do
						setglobal("SLASH_".. Name .. i,"/".. CmdTable[i])
					end
				end
			else
			    return
			end
		end,

		--Registers a mod in the libary (removed)
		AddMod = function(modtable)
		end,
	}
end