local dewdrop = DewdropLib:GetInstance('1.0')
local tablet = TabletLib:GetInstance('1.0')
local metro = Metrognome:GetInstance('1')

GuildFu = FuBarPlugin:GetInstance("1.2"):new({
	name          = GuildFULocals.NAME,
	description   = GuildFULocals.DESCRIPTION,
	version       = "1.52",
	releaseDate   = "2006-05-15",
	aceCompatible = "102",
	author        = "Garfield",
	email         = "f6_garfield@hotmail.com",
	website       = "",
	category      = "interface",
	db            = AceDatabase:new("GuildFUDB"),
	defaults      = DEFAULT_OPTIONS,
	cmd           = AceChatCmd:new(	GuildFULocals.COMMANDS, GuildFULocals.CMD_OPTIONS),
	hasIcon       = TRUE,
	colorRank	  = "|cffff9933",
	colorPublicNotes	  = "|cffff9933",
	colorOfficerNotes	  = "|cffffcc66",	
	colorLevel	  = "|cff33ff00",
	-- Methods
	
	loc = GuildFULocals,
	
	ToggleHideLocation = function(self)
		self.data.hideLocation = not self.data.hideLocation
		self:Update()
		return self.data.hideLocation
	end,
	
	ToggleHideLevel = function(self)
		self.data.hideLevel = not self.data.hideLevel
		self:Update()
		return self.data.hideLevel
	end,

	ToggleColorNames = function(self)
		self.data.colornames = not self.data.colornames
		self:Update()
		return self.data.colornames
	end,
	
	ToggleHideLabel = function(self)
		self.data.hideLabel = not self.data.hideLabel
		self:Update()
		return self.data.hideLabel
	end,

	ToggleHideTotal = function(self)
		self.data.hideTotal = not self.data.hideTotal
		self:Update()
		return self.data.hideTotal
	end,
	
	ToggleHideClass = function(self)
		self.data.hideClass = not self.data.hideClass
		self:Update()
		return self.data.hideClass
	end,
	
	ToggleHideRace = function(self)
		self.data.hideRace = not self.data.hideRace
		self:Update()
		return self.data.hideRace
	end,
	
	ToggleHideRank = function(self)
		self.data.hideRank = not self.data.hideRank
		self:Update()
		return self.data.hideClass
	end,
	
	ToggleHidePublicNotes = function(self)
		self.data.hidePublicNotes = not self.data.hidePublicNotes
		self:Update()
		return self.data.hidePublicNotes
	end,
	
	ToggleHideOfficerNotes = function(self)
		self.data.hideOfficerNotes = not self.data.hideOfficerNotes
		self:Update()
		return self.data.hideOfficerNotes
	end,

	ToggleOrder = function(self,selectorder)
		self.data.SortOrder = selectorder
		self:Update()
		return true
	end,

	SetLeadText = function(self, txt)
		txt = self:trim(txt)
		if ( txt == "nil" ) then self.data.LeadText = nil else self.data.LeadText = text end 
		self:Update()
	end,	
	
	trim = function(self,s)
      return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
    end,
	
	SetLevelRange = function(self, txt)
	  txt = tonumber(txt)
	  if ((txt < 0) or (txt > 10) )then self.data.levelrange = nil else self.data.levelrange = txt end
	end,
	
	SetRefreshRate = function(self, txt)
		txt = tonumber(txt)
		if ((txt < 1) or (txt > 300) )then self.data.refreshrate = nil else self.data.refreshrate = txt end
		metro:Stop(self.loc.NAME)
		metro:Unregister(self.loc.NAME)
		metro:Register(self.loc.NAME, prepare_data, self.data.refreshrate or self.loc.REFRESHINTERVAL,self)
		metro:Start(self.loc.NAME)
	end,
	
	Report = function(self)
		self.cmd:report({
			})
	end,
	
	MenuSettings = function(self,level,value)

	local pagingRemainder, numPages, pagemenu, info
	if ( level == 3 ) then
		if (value == self.loc.MENU_FILTER_CLASS) then
			local classindex, classListValues
			local playerFaction = ""
			playerFaction = UnitFactionGroup("player")
			if (playerFaction == "Horde") then
				classListValues = self.loc.hordeClassValues
			else
				classListValues = self.loc.allianceClassValues
			end
			for classindex=1,table.getn(classListValues) do
				checked = false
				if ( classindex==1 and not self.data.filterclass ) then checked = true end
				if ( self.data.filterclass and self.data.filterclass[classListValues[classindex]] ) then checked = true end
				dewdrop:AddLine (
					'text' , classListValues[classindex],
					'value' ,  classListValues[classindex],
					'func' , function(myclass) self:FilterClass(myclass) end,
					'arg1', classListValues[classindex],
					'checked' , checked)
			end
		end
		if (value == self.loc.MENU_FILTER_LEVEL) then
			checked = false
			if ( self.data.filterlevel == self.loc.allianceClassValues[1] or not self.data.filterclass ) then checked = true end
			dewdrop:AddLine(
				'text', self.loc.allianceClassValues[1],
				'value' , self.loc.allianceClassValues[1],
				'func', function() self:FilterLevel(self.loc.allianceClassValues[1]) end,
				'checked',checked)

				checked = false
			if ( self.data.filterlevel == "levelrange" ) then checked = true end
			dewdrop:AddLine(
				'text',string.format("+/- %i from your level", self.data.levelrange or self.loc.MENU_FILTER_LEVELRANGE),
				'value', "levelrange",
				'func', function() self:FilterLevel("levelrange") end,
				'checked',checked)

			local index, minlvl,maxlvl
			for index=0,5 do
				info = {}
				minlvl = index *10
				maxlvl = index *10 + 9
				if (minlvl == 0) then minlvl = 1 end
				checked = false
				myvalue = string.format("level%i",index)
				if ( self.data.filterlevel == myvalue ) then checked = true end
				dewdrop:AddLine(
				'text', string.format("From level %i to %i", minlvl , maxlvl),
				'value', myvalue,
				'func', function(myarg) self:FilterLevel(myarg) end,
				'arg1', myvalue,
				'checked',checked)
			end
			checked = false
			if ( self.data.filterlevel == "level6" ) then checked = true end
			dewdrop:AddLine(
				'text', string.format("Level %i", self.loc.WowMaxLevel),
				'value', "level6",
				'func', function() self:FilterLevel("level6") end,
				'checked',checked)
		end
		if (value == self.loc.MENU_FILTER_ZONE) then
			for i=1,table.getn(self.loc.MENU_FILTERS_ZONE) do
				local checked = false
				if self.data.filterzone and self.data.filterzone[self.loc.MENU_FILTERS_ZONE[i]] then checked = true end
				dewdrop:AddLine(
					'text', self.loc.MENU_FILTERS_ZONE[i],
					'value', self.loc.MENU_FILTERS_ZONE[i],
					'func', function(myzone) self:FilterZone(myzone) end,
					'arg1', self.loc.MENU_FILTERS_ZONE[i],
					'checked',checked)
			end	
		end
	end
	
	if ( level == 2 ) then

		if ( value == self.loc.MENU_INVITE or value == self.loc.MENU_WHISPER) then
			local friendIndex

			for friendIndex=1 , table.getn(self.data.FriendTable) do
					if ( value == self.loc.MENU_INVITE ) then
						myfunc = function(myfriend) self:friendInvite(myfriend) end
					else
						myfunc = function(myfriend) self:friendWhisper(myfriend) end
					end
					dewdrop:AddLine(
						'text',self.data.FriendTable[friendIndex][1],
						'value',  self.data.FriendTable[friendIndex][1],
						'func', myfunc,
						'arg1', self.data.FriendTable[friendIndex][1]
						)

			end
		end
		if ( value == self.loc.MENU_DISPLAY ) then
			dewdrop:AddLine(
				'text', self.loc.MENU_SHOW_LOCATION,
				'value', self.loc.MENU_SHOW_LOCATION,
				'func', function() self:ToggleHideLocation() end,
				'checked', not self.data.hideLocation,
				'closeWhenClicked', false)
	
			dewdrop:AddLine(
				'text', self.loc.MENU_SHOW_LEVEL,
				'value', self.loc.MENU_SHOW_LEVEL,
				'func', function() self:ToggleHideLevel() end,
				'checked', not self.data.hideLevel,
				'closeWhenClicked', false)
	
			dewdrop:AddLine(
				'text', self.loc.MENU_SHOW_CLASS,
				'value', self.loc.MENU_SHOW_CLASS,
				'func', function() self:ToggleHideClass() end,
				'checked', not self.data.hideClass,
				'closeWhenClicked', false)

			dewdrop:AddLine(
				'text', self.loc.MENU_SHOW_PUBLICNOTES,
				'value', self.loc.MENU_SHOW_PUBLICNOTES,
				'func', function() self:ToggleHidePublicNotes() end,
				'checked', not self.data.hidePublicNotes,
				'closeWhenClicked', false)
			
			dewdrop:AddLine(
				'text', self.loc.MENU_SHOW_OFFICERNOTES,
				'value', self.loc.MENU_SHOW_OFFICERNOTES,
				'func', function() self:ToggleHideOfficerNotes() end,
				'checked', not self.data.hideOfficerNotes,
				'closeWhenClicked', false)
				
			dewdrop:AddLine(
				'text', self.loc.MENU_SHOW_RANK,
				'value', self.loc.MENU_SHOW_RANK,
				'func', function() self:ToggleHideRank() end,
				'checked', not self.data.hideRank,
				'closeWhenClicked', false)
				
			dewdrop:AddLine(
				'text', self.loc.MENU_SHOW_LABEL,
				'value', self.loc.MENU_SHOW_LABEL,
				'func', function() self:ToggleHideLabel() end,
				'checked', not self.data.hideLabel,
				'closeWhenClicked', false)
			
			dewdrop:AddLine(
				'text', self.loc.MENU_SHOW_TOTAL,
				'value', self.loc.MENU_SHOW_TOTAL,
				'func', function() self:ToggleHideTotal() end,
				'checked', not self.data.hideTotal,
				'closeWhenClicked', false)

			dewdrop:AddLine(
				'text', self.loc.MENU_COLORNAMES,
				'value', self.loc.MENU_COLORNAMES,
				'func', function() self:ToggleColorNames() end,
				'checked', self.data.colornames,
				'closeWhenClicked', false)
				
		end
		if ( value == self.loc.MENU_ORDER ) then
			checked = false
			if ( self.data.SortOrder == self.loc.MENU_ORDER_LOCATION) then checked = true end
			dewdrop:AddLine(
				'text', self.loc.MENU_ORDER_LOCATION,
				'value', self.loc.MENU_ORDER_LOCATION,
				'func', function() self:ToggleOrder(self.loc.MENU_ORDER_LOCATION) end,
				'checked', checked)			

			checked = false
			if ( self.data.SortOrder == self.loc.MENU_ORDER_LEVEL) then checked = true end
			dewdrop:AddLine(
				'text', self.loc.MENU_ORDER_LEVEL,
				'value', self.loc.MENU_ORDER_LEVEL,
				'func', function() self:ToggleOrder(self.loc.MENU_ORDER_LEVEL) end,
				'checked', checked)	

			checked = false
			if ( self.data.SortOrder == self.loc.MENU_ORDER_CLASS) then checked = true end
			dewdrop:AddLine(
				'text', self.loc.MENU_ORDER_CLASS,
				'value', self.loc.MENU_ORDER_CLASS,
				'func', function() self:ToggleOrder(self.loc.MENU_ORDER_CLASS) end,
				'checked', checked)	
	
			checked = false
			if ( self.data.SortOrder == self.loc.MENU_ORDER_NAME) then checked = true end
			dewdrop:AddLine(
				'text', self.loc.MENU_ORDER_NAME,
				'value', self.loc.MENU_ORDER_NAME,
				'func', function() self:ToggleOrder(self.loc.MENU_ORDER_NAME) end,
				'checked', checked)	

		end

		if ( value == self.loc.MENU_FILTER ) then
			dewdrop:AddLine(
				'text', self.loc.MENU_FILTER_CLASS,
				'value',self.loc.MENU_FILTER_CLASS,
				'hasArrow', true)
				
			dewdrop:AddLine(
				'text', self.loc.MENU_FILTER_LEVEL,
				'value',self.loc.MENU_FILTER_LEVEL,
				'hasArrow', true)

			dewdrop:AddLine(
				'text', self.loc.MENU_FILTER_ZONE,
				'value',self.loc.MENU_FILTER_ZONE,
				'hasArrow', true)
		end
	end	
	if ( level == 1 ) then
		dewdrop:AddLine(
				'text', self.loc.MENU_INVITE,
				'value',self.loc.MENU_INVITE,
				'hasArrow', true)	
		
		dewdrop:AddLine(
				'text', self.loc.MENU_WHISPER,
				'value',self.loc.MENU_WHISPER,
				'hasArrow', true)	


		dewdrop:AddLine()

		dewdrop:AddLine(
				'text', self.loc.MENU_DISPLAY,
				'value',self.loc.MENU_DISPLAY,
				'hasArrow', true)	

		dewdrop:AddLine(
				'text', self.loc.MENU_ORDER,
				'value',self.loc.MENU_ORDER,
				'hasArrow', true)	

		dewdrop:AddLine(
			'text', self.loc.MENU_FILTER,
			'value',self.loc.MENU_FILTER,
			'hasArrow', true)	
		
	end	
	end,
	
	Initialize = function(self)
		self.data.Page = 0
		self:Show()
		if not IsInGuild() then self:Hide() end
	end,
	
	Enable = function(self) 
		self:RegisterEvent("GUILD_ROSTER_SHOW","Update") 
		self:RegisterEvent("GUILD_ROSTER_UPDATE","Update")
		self:RegisterEvent("GUILD_REGISTRAR_SHOW","Update")
		self:RegisterEvent("GUILD_REGISTRAR_CLOSED","Update")
		self:RegisterEvent("PLAYER_ENTERING_WORLD","Update")
		self:RegisterEvent("CHAT_MSG_SYSTEM","SystemMessage")
		metro:Register(self.loc.NAME, self.prepare_data, self.data.refreshrate or self.loc.REFRESHINTERVAL,self)
		metro:Start(self.loc.NAME)
   end,
   
   Disable = function(self)
		metro:Unregister(self.loc.NAME)
   end,
   
    prepare_data = function(self)
		self:UpdateData()
		self:UpdateText()
	end,
	
	SystemMessage = function(self)
		if ( string.find(arg1, self.loc.SYSMSG_ONLINE) or string.find(arg1, self.loc.SYSMSG_OFFLINE) ) then
			self:Update()
		end
	end,
	
	friendInvite = function(self,name)
	InviteByName( name )
	end,

	FilterClass = function(self, selectclass)
		if selectclass == self.loc.allianceClassValues[1] then
			self.data.filterclass = nil
		else
			if not self.data.filterclass then self.data.filterclass={} end
			if self.data.filterclass[selectclass] then self.data.filterclass[selectclass]=nil else self.data.filterclass[selectclass]=TRUE end
		end
		self:Update()
	end,
	
	FilterLevel = function(self,selectlevel)
		self.data.filterlevel=selectlevel
		self:Update()
	end,
	
	FilterZone = function(self, selectzone)
		if not self.data.filterzone then self.data.filterzone={} end
		if self.data.filterzone[selectzone] then self.data.filterzone[selectzone]=nil else self.data.filterzone[selectzone]=TRUE end
		self:Update()
	end,
	
	passfilter = function(self,info)
		local filterclass,filterlevel,filterzone
		
		
		if ( self.data.filterclass ) then
			if ( self.data.filterclass[info[3]] ) then filterclass = true end
		else
			filterclass = true
		end
		
		if ( self.data.filterlevel and self.data.filterlevel ~= self.loc.allianceClassValues[1] ) then
			local minlvl, maxlvl
			local wowmaxlvl

			if ( self.data.filterlevel == "levelrange" ) then
				local mylvl = UnitLevel("player")
				minlvl = mylvl - ( self.data.levelrange or self.loc.MENU_FILTER_LEVELRANGE)
				maxlvl = mylvl + ( self.data.levelrange or self.loc.MENU_FILTER_LEVELRANGE )
			else
				local lvl
				lvl = tonumber(string.sub(self.data.filterlevel,-1,-1))
				minlvl = lvl * 10
				maxlvl = lvl * 10 + 9
			end
			wowmaxlvl = self.loc.WowMaxLevel
			if ( minlvl < 1 ) then minlvl = 1 end
			if ( maxlvl < 1 ) then maxlvl = 1 end
			if ( minlvl > wowmaxlvl ) then minlvl = wowmaxlvl end
			if ( maxlvl > wowmaxlvl ) then maxlvl = wowmaxlvl end
			if ( minlvl <= info[2] and maxlvl >= info[2] ) then filterlevel = true end
		else
			filterlevel = true
		end
		
		if ( self.data.filterzone ) then
			filterzone = true
			if self.data.filterzone[self.loc.MENU_FILTERS_ZONE[1]] then
				if (info[4] ~= GetZoneText() ) then	filterzone = nil end
			end
			if self.data.filterzone[self.loc.MENU_FILTERS_ZONE[2]] then
				if (self.loc.dungeonlist[info[4]] ) then filterzone = nil end
			end
			if self.data.filterzone[self.loc.MENU_FILTERS_ZONE[3]] then
				if (self.loc.battlegroundlist[info[4]] ) then filterzone = nil end
			end
		else
			filterzone = true
		end
		return filterclass and filterlevel and filterzone
	end,
	
	friendWhisper= function(self,name)
		if ( not ChatFrameEditBox:IsVisible() ) then
			ChatFrame_OpenChat(string.format("/w %s ",name))
		else
			ChatFrameEditBox:SetText(string.format("/w %s ",name))
		end
	end	,
	
	
	UpdateData = function(self)
		
		local NumFriends = GetNumGuildMembers(true)
		local NumFriendsOnline = 0
		local friend_name, friend_level, friend_class, friend_area, friend_connected, friend_rank, rankIndex, note, officernote, status 
		local friendIndex
		local friendtable={}
		
		if (IsInGuild()) then
		GuildRoster()
		for friendIndex=1, NumFriends do
			friend_name, friend_rank, rankIndex, friend_level, friend_class, friend_area, note, officernote, friend_connected, status = GetGuildRosterInfo(friendIndex)
			if (not friend_area) then friend_area = " . " end
			if ( friend_connected ) then
				if ( self:passfilter({friend_name, friend_level,friend_class, friend_area} ) )then
					NumFriendsOnline = NumFriendsOnline + 1
					table.insert(friendtable,{friend_name, friend_level,friend_class, friend_area,friend_rank,rankIndex,note,officernote})
				end
			end	
		end
		if ( self.data.SortOrder == self.loc.MENU_ORDER_LOCATION ) then table.sort(friendtable, function(a,b) return a[4]<b[4] end) end
		if ( self.data.SortOrder == self.loc.MENU_ORDER_LEVEL ) then table.sort(friendtable, function(a,b) return a[2]>b[2] end) end
		if ( self.data.SortOrder == self.loc.MENU_ORDER_CLASS ) then table.sort(friendtable, function(a,b) return a[3]<b[3] end) end
		if ( self.data.SortOrder == self.loc.MENU_ORDER_NAME ) then table.sort(friendtable, function(a,b) return a[1]<b[1] end) end

		self.data.NumOnline = NumFriendsOnline
		self.data.NumMaximum = NumFriends
		self.data.FriendTable = friendtable
		else
			self.data.NumOnline = 0
			self.data.NumMaximum = 0
			self.data.FriendTable = {}
		end
	end,	
	
	UpdateText = function(self)
		local tekst
		if ( self.data.hideTotal ) then
			tekst =self.data.NumOnline
		else
			tekst = string.format("%i/%i",self.data.NumOnline, self.data.NumMaximum )
		end
		if (not self.data.hideLabel ) then
			if self.data.LeadText then tekst = string.format("%s %s",self.data.LeadText or "",tekst) end
		end
		self:SetText(tekst)
	end,

	UpdateTooltip = function(self)
	local lijn1, lijn2
	local friendIndex, friend_name,friend_class,friend_level,friend_area
		if ( IsInGuild() ) then
		local cat = tablet:AddCategory('columns', 4)	
		for friendIndex=1, table.getn(self.data.FriendTable) do
			friend_name = self.data.FriendTable[friendIndex][1]
			friend_level = string.format("%s%s|r",self.colorLevel,self.data.FriendTable[friendIndex][2])
			friend_color = self.loc.colorclasses[self.data.FriendTable[friendIndex][3]]
			friend_class = string.format("%s%s|r",friend_color,self.data.FriendTable[friendIndex][3])
			friend_area = self.data.FriendTable[friendIndex][4]
			if ( self.data.colornames ) then friend_name = string.format("%s%s|r",friend_color,friend_name) end
			
			friend_rank = string.format("%s[%s]|r",self.colorRank,self.data.FriendTable[friendIndex][5])
			if (self.data.FriendTable[friendIndex][7] == "" ) then
				friend_publicnotes = ""
			else
				friend_publicnotes = string.format("%s[%s]|r",self.colorPublicNotes,self.data.FriendTable[friendIndex][7])
			end
			if (self.data.FriendTable[friendIndex][8] == "" ) then
				friend_officernotes = ""
			else
				friend_officernotes = string.format("%s[%s]|r",self.colorOfficerNotes,self.data.FriendTable[friendIndex][8])
			end 

				if ( self.data.hidePublicNotes ) then
					friend_publicnotes = ""
				end
				if ( self.data.hideOfficerNotes ) then
					friend_officernotes = ""
				end
				if ( self.data.hideLocation ) then
					friend_area = ""
				end	
				if ( self.data.hideLevel ) then
					friend_level = ""
				end
				if ( self.data.hideClass ) then
					friend_class = ""
				end	
				if (self.data.hideRank ) then
					friend_rank = ""
				end
				cat:AddLine(
					'text', string.format("%s %s%s",friend_name,friend_publicnotes,friend_officernotes),
					'text2',friend_area,
					'text3',friend_level,
					'text4',string.format("%s %s",friend_class,friend_rank),
					'justify', "LEFT",
					'justify2', "LEFT",
					'justify3', "RIGHT",
					'justify4', "RIGHT"
					)
		end
		else
			cat:AddLine('text',self.loc.TOOLTIP_NOTINGUILD)
		end
	end,

	
	OnClick = function(self) 
      ToggleFriendsFrame(3) 
      FriendsFrame_Update() 
   end, 

})

GuildFu:RegisterForLoad()