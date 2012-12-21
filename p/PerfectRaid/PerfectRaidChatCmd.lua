if AceChatCmd then
	PerfectRaid.AceChatCmd = AceChatCmd
else
	local AceChatCmd = {}
	PerfectRaid.AceChatCmd = AceChatCmd
	
	local Ace = {}
	
	function Ace:print(...)
		local r,g,b,frame,delay
		if( type(arg[1]) == "table" ) then
			r,g,b,frame,delay = unpack(tremove(arg,1))
		end
		(frame or DEFAULT_CHAT_FRAME):AddMessage(self.concat(arg),r,g,b,1,delay or 5)
	end
	
	function Ace.ParseWords(str, pat)
		if( Ace.tostr(str) == "" ) then return {} end
		local list = {}
		for word in gfind(str, pat or "%S+") do
			tinsert(list, word)
		end
		return list
	end
	
	local ACE_CMD = {}
	ACE_CMD.OPT_HELP			= "?"
	ACE_CMD.OPT_HELP_DESC		= "Display extra information about this addon."
	ACE_CMD.OPT_STANDBY			= "standby"
	ACE_CMD.OPT_STANDBY_DESC	= "Toggle the addon's standby mode."
	ACE_CMD.OPT_REPORT			= "report"
	ACE_CMD.OPT_REPORT_DESC		= "Display the status of all settings."
	ACE_CMD.OPT_INVALID			= "Invalid option '%s' entered."
	ACE_CMD.OPT_LIST_ADDONS		= "Addon List"
	ACE_CMD.OPT_LOAD_IS_LOADED	= "%s is already loaded."
	ACE_CMD.OPT_LOAD_ERROR		= "%s could not be loaded because it is %s."
	ACE_CMD.OPT_LOAD_LOADED		= "%s is now loaded."
	ACE_CMD.OPT_AUTO_OFF_MSG	= "%s will no longer be loaded on demand at game start."
	ACE_CMD.ERROR 				= "|cffff6060[error]|r"
	
	ACE_CMD.ADDON_NOTFOUND		= "No addon named '%s' was found."
	ACE_CMD.ADDON_ENABLED		= "%s has been enabled. You must reload the game to load this addon."
	ACE_CMD.ADDON_ENABLED_ALL	= "All addons have been enabled. You must reload the game to load "..
								  "previously unloaded addons."
	ACE_CMD.ADDON_DISABLED		= "%s has been disabled but will remain loaded until you reload the game."
	ACE_CMD.ADDON_DISABLED_ALL	= "All addons except Ace itself have been disabled but will remain loaded "..
								  "until you reload the game."
	
	ACE_CMD.PROFILE_ADDON_ADDED = "%s has been added. Active profile: %s."
	ACE_CMD.PROFILE_ALL_ADDED	= "All addons have been added. Active profile: %s."
	ACE_CMD.PROFILE_ALL			= "all"
	ACE_CMD.PROFILE_NO_PROFILE	= "%s has no profiling options available."
	
	ACE_CMD.USAGE_ADDON_DESC	= "|cffffff78[%s v%s]|r : %s"
	ACE_CMD.USAGE_HEADER		= "|cffffff78Usage:|r |cffd8c7ff%s|r %s"
	ACE_CMD.USAGE_OPT_DESC		= " - |cffffff78%s:|r %s"
	ACE_CMD.USAGE_OPT_SEP		= " | "
	ACE_CMD.USAGE_OPT_OPEN		= "["
	ACE_CMD.USAGE_OPT_CLOSE		= "]"
	ACE_CMD.USAGE_OPTION		= "|cffd8c7ff%s %s|r %s"
	ACE_CMD.USAGE_NOINFO		= "No further information"
	
	ACE_CMD.RESULT				= "|cffffff78%s:|r %s"
	
	ACE_CMD.REPORT_STATUS		= "Status"
	ACE_CMD.REPORT_LINE			= "%s [|cfff5f530%s|r]"
	ACE_CMD.REPORT_LINE_PRE		= " - "
	ACE_CMD.REPORT_LINE_INDENT	= "   "
	
	ACE_CMD.REPORT_NO_VAL		= "|cffc7c7c7no value|r"
	
	
	-- Recursively iterate through the table and sub-tables until the entire table
	-- structure is copied over. Note: I used to check whether the table was numerically
	-- indexed and use two different for() loops, one with ipairs() and one without. I
	-- did this because there seemed to be problems otherwise, but in rewriting this, I
	-- haven't encountered any problems.
	function Ace.CopyTable(into, from)
		for key, val in from do
			if( type(val) == "table" ) then
				if( not into[key] ) then into[key] = {} end
				Ace.CopyTable(into[key], val)
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
				msg = msg..Ace.tostr(val)
			end
		else
			for key, val in t do
				if( msg ~= "" and sep ) then msg = msg..sep end
				msg = msg..key.."="..Ace.tostr(val)
			end
		end
		return msg
	end
	
	function Ace.round(num)
		return floor(Ace.tonum(num)+.5)
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
	
	-- Object constructor
	function AceChatCmd:new(commands,options)
		self.__index = self
		return setmetatable({_cmdList=commands,options=options}, self)
	end
	
	--[[---------------------------------------------------------------------------------
	  Reporting Methods
	------------------------------------------------------------------------------------]]
	
	function AceChatCmd:result(...)
		Ace:print(self.app.disabled and ACE_ADDON_STANDBY.." " or "",
				  format(ACE_CMD.RESULT, self.app.name, Ace.concat(arg))
				 )
	end
	
	function AceChatCmd:msg(...) self:result(format(unpack(arg))) end
	function AceChatCmd:error(...) self:result(ACE_CMD.ERROR.." ", format(unpack(arg))) end
	function AceChatCmd:status(text, val, map)
		if( map ) then val = map[val or 0] or val end
		self:result(text, " ", ACE_TEXT_NOW_SET_TO, " ",
					format(ACE_DISPLAY_OPTION, val or ACE_CMD.REPORT_NO_VAL)
				   )
	end
	
	function AceChatCmd:report(hdr, def)
		if( not def ) then def = hdr; hdr = nil end
		Ace:print(hdr or format(ACE_CMD.RESULT,
								self.app.name.." "..ACE_CMD.REPORT_STATUS,
								self.app.disabled and ACE_ADDON_STANDBY or ""
							   )
				 )
		for _, ref in ipairs(def) do
			local val
			if( ref.map ) then val = ref.map[ref.val or 0]
			else val = ref.val
			end
			Ace:print(
				(ref.indent
					and (strrep(" ", strlen(ACE_CMD.REPORT_LINE_PRE))..
						 strrep(ACE_CMD.REPORT_LINE_INDENT, ref.indent))
					or  ACE_CMD.REPORT_LINE_PRE
				),
				format(ACE_CMD.REPORT_LINE, ref.text, val or ACE_CMD.REPORT_NO_VAL)
			)
		end
	end
	
	
	--[[---------------------------------------------------------------------------------
	  Command Handling Methods
	------------------------------------------------------------------------------------]]
	
	function AceChatCmd:FindCommand(cmd)
		cmd = strlower(cmd)
		for index in SlashCmdList do
			local i, cmdString = 0
			repeat
				i = i + 1
				cmdString = getglobal("SLASH_"..index..i)
				if( strlower(cmdString or "") == cmd ) then return TRUE end
			until( not cmdString )
		end
	end
	
	function AceChatCmd:Register(handler)
		if( not self._cmdList ) then
			error("Attempt to register command handler without defining commands.", 2)
		end
		if( self.registered ) then return end
	
		local slashID = strupper(self.app.name).."_CMD"
	
		SlashCmdList[slashID] = function(msg) self:ProcessCommand(msg) end
		local i = 0
		for index, cmd in self._cmdList do
			if( not self:FindCommand(cmd) ) then
				if( not self.commands ) then self.commands = {} end
				i = i + 1
				tinsert(self.commands, cmd)
				setglobal("SLASH_"..slashID..i, cmd)
			end
		end
	
		self.handler = handler or self
	
		if( not self.options ) then self.options = {} end
	
		if( self.handler.Report ) then
			tinsert(self.options, 1, {
										option = ACE_CMD.OPT_REPORT,
										desc   = ACE_CMD.OPT_REPORT_DESC,
										method = "Report"
									 }
				   )
		end
	
		if( self.app.Enable ) then
			tinsert(self.options, 1, {
										option = ACE_CMD.OPT_STANDBY,
										desc   = format(ACE_CMD.OPT_STANDBY_DESC, self.app.name),
										method = "ToggleStandBy"
									 }
				   )
		end
	
		tinsert(self.options, 1, {option = ACE_CMD.OPT_HELP, desc = ACE_CMD.OPT_HELP_DESC})
	
		-- Create a closure for printing option lines, since it's done so much
		self.printOpt	= function(l,t) Ace:print(format(ACE_CMD.USAGE_OPT_DESC,l,t)) end
		self.registered = TRUE
	end
	
	function AceChatCmd:ProcessCommand(msg)
		msg = Ace.trim(msg or "")
	
		if( strfind(strlower(msg), ACE_CMD.OPT_HELP) == 1 ) then
			self:DisplayAddonInfo(self.options)
			return
		elseif( msg ~= "" ) then
			return self:ProcessOptions(self.options, msg, self.handler, self.handler.CommandHandler)
		elseif( self.handler.CommandHandler ) then
			self.handler.CommandHandler(self.handler, msg)
			return
		end
	
		self:DisplayUsage()
	end
	
	function AceChatCmd:ProcessOptions(list, msg, handler, method, opttext)
		local _, _, cmd = strfind(strlower(msg), "(%S+)")
		local args = gsub(msg, cmd.."%s*", "")
	
		local i = Ace.TableFindByKeyValue(list, "option", cmd, TRUE)
		if( i ) then
			local opt = list[i]
			if( opt.args and (args ~= "") and
				self:ProcessOptions(opt.args,
									args,
									opt.handler or handler,
									opt.method or method,
									opttext and opttext.." "..opt.option or opt.option
								   )
			) then
				return TRUE
			elseif( opt.method and ((args ~= "") or (not opt.input)) and
					(strlower(args) ~= ACE_CMD.OPT_HELP)
			) then
				handler = opt.handler or handler
				handler[opt.method](handler, args)
				return TRUE
			elseif( opt.input and (args == "") or (opt.args and (not method)) or
					(strlower(args) == ACE_CMD.OPT_HELP)
			) then
				self:OptionHeader(opt, opttext)
				self:DisplayArgUsage(opt)
				return TRUE
			end
		elseif( ((cmd or "") ~= "") and (cmd ~= ACE_CMD.OPT_HELP) and (not method) ) then
			self:result(format(ACE_CMD.OPT_INVALID, cmd))
			return TRUE
		end
	end
	
	
	--[[---------------------------------------------------------------------------------
	  Usage Display Methods
	------------------------------------------------------------------------------------]]
	
	function AceChatCmd:DisplayAddonInfo()
		self:CommandHeader()
		if( self.commands ) then
			self.printOpt(ACE_TEXT_COMMANDS, Ace.concat(self.commands, " | "))
		end
		if( self.app.author ) then  self.printOpt(ACE_TEXT_AUTHOR, self.app.author) end
		if( self.app.releaseDate ) then self.printOpt(ACE_TEXT_RELEASED, self.app.releaseDate) end
		if( self.app.email ) then self.printOpt(ACE_TEXT_EMAIL, self.app.email) end
		if( self.app.website ) then self.printOpt(ACE_TEXT_WEBSITE, self.app.website) end
	end
	
	function AceChatCmd:OptionHeader(option, opttext)
		local args
		if( option.args ) then
			args = self:ConcatOptions(option.args, ACE_CMD.USAGE_OPT_SEP)
		end
		if( not args ) then
			args = "- "..(option.desc or ACE_CMD.USAGE_NOINFO)
		end
		Ace:print(format(ACE_CMD.USAGE_OPTION,
						 self.commands[1],
						 opttext and opttext.." "..option.option or option.option,
						 args
						)
				 )
	end
	
	function AceChatCmd:DisplayArgUsage(option)
		if( not option.args ) then return end
		for _, arg in ipairs(option.args) do
			self.printOpt(arg.option, arg.desc)
		end
	end
	
	function AceChatCmd:DisplayUsage()
		self:CommandHeader()
	
		if( getn(self.options) < 1 ) then return end
	
		Ace:print(format(ACE_CMD.USAGE_HEADER,
						 self.commands[1],
						 self:ConcatOptions(self.options, ACE_CMD.USAGE_OPT_SEP)
						)
				 )
	
		-- Have to print the lines one at a time or risk it getting too large for the
		-- print buffer.
		for _, opt in ipairs(self.options) do
			self.printOpt(opt.option, opt.desc)
		end
	end
	
	function AceChatCmd:CommandHeader()
		Ace:print(self.app.disabled and ACE_ADDON_STANDBY.." " or "",
				  format(ACE_CMD.USAGE_ADDON_DESC,
						 self.app.name,
						 self.app.version,
						 self.app.description
						)
				 )
	end
	
	function AceChatCmd:ConcatOptions(options, sep)
		local str = ""
		for _, opt in options do
			if( (str ~= "") and sep ) then str = str..sep end
			str = str..opt.option
		end
		return str
	end
end