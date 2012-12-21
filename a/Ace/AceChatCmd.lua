
-- Class creation
AceChatCmd = AceCoreClass:new()
-- Compatibility reference, deprecated use
AceChatCmdClass = AceChatCmd

-- Object constructor
function AceChatCmd:new(commands,options)
	return ace:new(self,{_cmdList=commands,options=options})
end


--[[---------------------------------------------------------------------------------
  Reporting Methods
------------------------------------------------------------------------------------]]

function AceChatCmd:result(...)
	ace:print(self.app.disabled and ACE_ADDON_STANDBY.." " or "",
			  format(ACE_CMD_RESULT, self.app.name, ace.concat(arg))
			 )
end

function AceChatCmd:msg(...) self:result(format(unpack(arg))) end
function AceChatCmd:error(...) self:result(ACE_CMD_ERROR.." ", format(unpack(arg))) end
function AceChatCmd:status(text, val, map)
	if( map ) then val = map[val or 0] or val end
	self:result(text, " ", ACE_TEXT_NOW_SET_TO, " ",
				format(ACE_DISPLAY_OPTION, val or ACE_CMD_REPORT_NO_VAL)
			   )
end

function AceChatCmd:report(hdr, def)
	if( not def ) then def = hdr; hdr = nil end
	ace:print(hdr or format(ACE_CMD_RESULT,
							self.app.name.." "..ACE_CMD_REPORT_STATUS,
							self.app.disabled and ACE_ADDON_STANDBY or ""
						   )
			 )
	for _, ref in ipairs(def) do
		local val
		if( ref.map ) then val = ref.map[ref.val or 0]
		else val = ref.val
		end
		ace:print(
			(ref.indent
				and (strrep(" ", strlen(ACE_CMD_REPORT_LINE_PRE))..
					 strrep(ACE_CMD_REPORT_LINE_INDENT, ref.indent))
				or  ACE_CMD_REPORT_LINE_PRE
			),
			format(ACE_CMD_REPORT_LINE, ref.text, val or ACE_CMD_REPORT_NO_VAL)
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
									option = ACE_CMD_OPT_REPORT,
									desc   = ACE_CMD_OPT_REPORT_DESC,
									method = "Report"
								 }
			   )
	end

	if( self.app.Enable ) then
		tinsert(self.options, 1, {
									option = ACE_CMD_OPT_STANDBY,
									desc   = format(ACE_CMD_OPT_STANDBY_DESC, self.app.name),
									method = "ToggleStandBy"
								 }
			   )
	end

	tinsert(self.options, 1, {option = ACE_CMD_OPT_HELP, desc = ACE_CMD_OPT_HELP_DESC})

	-- Create a closure for printing option lines, since it's done so much
	self.printOpt	= function(l,t) ace:print(format(ACE_CMD_USAGE_OPT_DESC,l,t)) end
	self.registered = TRUE
end

function AceChatCmd:ProcessCommand(msg)
	msg = ace.trim(msg or "")

	if( strfind(strlower(msg), ACE_CMD_OPT_HELP) == 1 ) then
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

	local i = ace.TableFindByKeyValue(list, "option", cmd, TRUE)
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
				(strlower(args) ~= ACE_CMD_OPT_HELP)
		) then
			handler = opt.handler or handler
			handler[opt.method](handler, args)
			return TRUE
		elseif( opt.input and (args == "") or (opt.args and (not method)) or
				(strlower(args) == ACE_CMD_OPT_HELP)
		) then
			self:OptionHeader(opt, opttext)
			self:DisplayArgUsage(opt)
			return TRUE
		end
	elseif( ((cmd or "") ~= "") and (cmd ~= ACE_CMD_OPT_HELP) and (not method) ) then
		self:result(format(ACE_CMD_OPT_INVALID, cmd))
		return TRUE
	end
end


--[[---------------------------------------------------------------------------------
  Usage Display Methods
------------------------------------------------------------------------------------]]

function AceChatCmd:DisplayAddonInfo()
	self:CommandHeader()
	if( self.commands ) then
		self.printOpt(ACE_TEXT_COMMANDS, ace.concat(self.commands, " | "))
	end
	if( self.app.author ) then  self.printOpt(ACE_TEXT_AUTHOR, self.app.author) end
	if( self.app.releaseDate ) then self.printOpt(ACE_TEXT_RELEASED, self.app.releaseDate) end
	if( self.app.email ) then self.printOpt(ACE_TEXT_EMAIL, self.app.email) end
	if( self.app.website ) then self.printOpt(ACE_TEXT_WEBSITE, self.app.website) end
end

function AceChatCmd:OptionHeader(option, opttext)
	local args
	if( option.args ) then
		args = self:ConcatOptions(option.args, ACE_CMD_USAGE_OPT_SEP)
	end
	if( not args ) then
		args = "- "..(option.desc or ACE_CMD_USAGE_NOINFO)
	end
	ace:print(format(ACE_CMD_USAGE_OPTION,
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

	ace:print(format(ACE_CMD_USAGE_HEADER,
					 self.commands[1],
					 self:ConcatOptions(self.options, ACE_CMD_USAGE_OPT_SEP)
					)
			 )

	-- Have to print the lines one at a time or risk it getting too large for the
	-- print buffer.
	for _, opt in ipairs(self.options) do
		self.printOpt(opt.option, opt.desc)
	end
end

function AceChatCmd:CommandHeader()
	ace:print(self.app.disabled and ACE_ADDON_STANDBY.." " or "",
			  format(ACE_CMD_USAGE_ADDON_DESC,
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
