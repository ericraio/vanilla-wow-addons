Necronomicon = AceAddonClass:new({
	name          		= NECRONOMICON_CONST.Title,
	description   		= NECRONOMICON_CONST.Desc,
	version       		= NECRONOMICON_CONST.Version,
	releaseDate   		= "",
	aceCompatible 		= 103,
	author        		= "Ammo",
	email         		= "wouter@ctlaltdel.nl",
	website		  	= "http://www.wowace.com",
	category      		= "interface",
	db            		= AceDbClass:new("NecronomiconDB"),
	cmd           		= AceChatCmdClass:new(NECRONOMICON_CONST.ChatCmd,NECRONOMICON_CONST.ChatOpt),
	
	----------------------------
	--			Module Loadup			--
	----------------------------
	
	
	Initialize = function(self)
		self.Compost = CompostLib:GetInstance("compost-1")
		self.Metrognome = Metrognome:GetInstance("1")
		self.Metrognome:Register("Necronomicon", self.Heartbeat, NECRONOMICON_CONST.UpdateInterval, self )
	end,
	
	Enable = function(self)
		if( UnitClass("player") == NECRONOMICON_CONST.Pattern.Warlock ) then
			self.shardcount = 0
			self.healthstone = {}
			self.soulstone = {}
			self.spellstone = {}
			self.firestone = {}
			self.spells = {}

			self.timers = {}
			self.timerstext = "" 
			self.lastupdate = 0
			self.currentspell = {}
			self.mounttype = 0
			self.hasdemons = nil
			self.soulstonetimer = nil
			self.soulstonetarget = nil
			self.soulstonestate = nil			

			if( not self:GetOpt("firsttimedone") ) then
				self:SetOpt("timers", TRUE)
				self:SetOpt("firsttimedone", TRUE)
			end

			self:ScanSpells()
			self:ScanStones()

			self:SetupFrames()
			self.frames.main:Show()
			self:UpdateButtons()

			self:RegisterEvent("BAG_UPDATE")
			self:RegisterEvent("NECRONOMICON_BAG_UPDATE")

			self:RegisterEvent("SPELLS_CHANGED")
			self:RegisterEvent("LEARNED_SPELL_IN_TAB", "SPELLS_CHANGED")

			self:RegisterEvent("SPELLCAST_START")
			self:RegisterEvent("SPELLCAST_FAILED")
			self:RegisterEvent("SPELLCAST_INTERRUPTED")
			self:RegisterEvent("SPELLCAST_CHANNEL_START")
			-- self:RegisterEvent("SPELLCAST_CHANNEL_STOP")
			self:RegisterEvent("SPELLCAST_STOP")
			self:RegisterEvent("PLAYER_REGEN_ENABLED")

			self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS")
			self:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")

			self:Hook("CastSpell", "OnCastSpell", Necronomicon )
			self:Hook("CastSpellByName", "OnCastSpellByName", Necronomicon )
			self:Hook("UseAction", "OnUseAction", Necronomicon )
			-- self:Hook("UseContainerItem", "OnUseContainerItem" )
		
			if( self:GetOpt("timers") ) then
				self.Metrognome:Start("Necronomicon")
				self.frames.timers:Show()
			else
				self.frames.timers:Hide()
			end
		end
	end,
	
	Disable = function(self)
		if( UnitClass("player") == NECRONOMICON_CONST.Pattern.Warlock ) then
			-- Stop the heartbeat and hide our main frame
			self.Metrognome:Stop("Necronomicon")
			self.frames.main:Hide()

			self.UnregisterAllEvents()

			self:Unhook("CastSpell")
			self:Unhook("CastSpellByName")
			self:Unhook("UseAction")
			-- self:Unhook("UseContainerItem")
		end
		
	end,

----------------------------
-- General               --
----------------------------

	GetGradient = function( self, perc )
		local gradient = "|CFF00FF00" -- BrightGreen
		
		if( perc < 10 ) then
			gradient = "|CFFFF0000" -- Red
		elseif( perc < 20 ) then
			gradient = "|CFFFF3300" -- RedOrange
		elseif( perc < 30 ) then
			gradient = "|CFFFF6600" -- DarkOrange
		elseif( perc < 40 ) then
			gradient = "|CFFFF9933" -- DirtyOrange
		elseif( perc < 50 ) then
			gradient = "|CFFFFCC00" -- DarkYellow
		elseif( perc < 60 ) then
			gradient = "|CFFFFFF66" -- LightYellow
		elseif( perc < 70 ) then
			gradient = "|CFFCCFF66" -- YellowGreen
		elseif( perc < 80 ) then
			gradient = "|CFF99FF66" -- LightGreen
		elseif( perc < 90 ) then
			gradient = "|CFF66FF66" -- LighterGreen
		end
		return gradient
	end,

	ScanStones = function( self )
		local bag
		local shards = 0
		local itemLink
		self.Compost:Erase(self.healthstone)
		self.Compost:Erase(self.soulstone)
		self.Compost:Erase(self.spellstone)
		self.Compost:Erase(self.firestone)
		for bag = 4, 0, -1 do
			local size = GetContainerNumSlots(bag)
			if (size > 0) then
				local slot
				for slot=1, size, 1 do
					if (GetContainerItemLink(bag,slot)) then
						itemLink = GetContainerItemLink(bag,slot)
						if( string.find( itemLink, NECRONOMICON_CONST.Pattern.Shard ) and
						not string.find( itemLink, NECRONOMICON_CONST.Pattern.Corrupted ) ) then
							shards = shards + 1
						elseif( string.find( itemLink, NECRONOMICON_CONST.Pattern.Healthstone ) ) then
							self.healthstone[0] = bag
							self.healthstone[1] = slot
						elseif( string.find( itemLink, NECRONOMICON_CONST.Pattern.Soulstone ) ) then
							self.soulstone[0] = bag
							self.soulstone[1] = slot
						elseif( string.find( itemLink, NECRONOMICON_CONST.Pattern.Spellstone ) ) then
							self.spellstone[0] = bag
							self.spellstone[1] = slot
							self.spellstone[2] = FALSE -- not equipped
						elseif( string.find( itemLink, NECRONOMICON_CONST.Pattern.Firestone ) ) then
							self.firestone[0] = bag
							self.firestone[1] = slot
							self.firestone[2] = FALSE -- not equipped
						end
					end
				end
			end
		end
		if( GetInventoryItemLink("player",GetInventorySlotInfo("SecondaryHandSlot") ) ) then
			itemLink = GetInventoryItemLink("player",GetInventorySlotInfo("SecondaryHandSlot") )
			if( string.find( itemLink, NECRONOMICON_CONST.Pattern.Spellstone ) ) then
				self.spellstone[0] = TRUE
				self.spellstone[1] = TRUE
				self.spellstone[2] = TRUE -- equipped
			elseif( string.find( itemLink, NECRONOMICON_CONST.Pattern.Firestone ) ) then
				self.firestone[0] = TRUE
				self.firestone[1] = TRUE
				self.firestone[2] = TRUE -- equipped
			end
		end
		self.shardcount = shards
	end,

	ScanSpells = function( self )

		local spellName, spellRank, spellTotal, id, rank, maxrank, rankedSpell
		local spellLevel = {}

		self.spells.normal = {}
		self.spells.timed = {}
		self.spells.timedid = {}
		self.spells.timedname = {}
		self.spells.timeddisplay = {}

		for id = 1, 180 do
			rankedSpell = nil
			spellName, spellRank = GetSpellName(id, "spell")
			if (spellName) then
				if( spellRank and spellRank ~= "" ) then 
					spellTotal = spellName .. " " .. spellRank
				else 
					spellTotal = spellName
				end

				if( NECRONOMICON_CONST.Spell[spellName] ) then
					self.spells.normal[NECRONOMICON_CONST.Spell[spellName]] = id
					self.hasdemons = 1
				end
				-- self:Msg("Spell: ##"..spellTotal.."##")
				if( NECRONOMICON_CONST.RankedSpell[spellTotal] ) then
					local thistag, thislevel
					thistag = NECRONOMICON_CONST.RankedSpell[spellTotal][1]
					thislevel = NECRONOMICON_CONST.RankedSpell[spellTotal][2]
					if( not spellLevel[thistag] or thislevel > spellLevel[thistag] ) then
						self.spells.normal[thistag] = id
						spellLevel[thistag] = thislevel
						if( thistag == "MOUNT" ) then
							self.mounttype = thislevel
						end
					end
				end

				if( NECRONOMICON_CONST.RankedSpell[spellName] ) then
					rankedSpell = spellName
				end
				if( NECRONOMICON_CONST.RankedSpell[spellTotal] ) then
					rankedSpell = spellTotal
				end

				if( rankedSpell ) then
					local thistag, thislevel
					thistag = NECRONOMICON_CONST.RankedSpell[rankedSpell][1]
					thislevel = NECRONOMICON_CONST.RankedSpell[rankedSpell][2]
					if( not spellLevel[thistag] or thislevel > spellLevel[thistag] ) then
						self.spells.normal[thistag] = id
						spellLevel[thistag] = thislevel
						if( thistag == "MOUNT" ) then
							self.mounttype = thislevel
						end
					end
				end

				if( NECRONOMICON_CONST.TimedSpell[spellName] ) then
					maxrank = 0
					if (string.find(spellRank, NECRONOMICON_CONST.Pattern.Rank )) then
						for rank in string.gfind( spellRank, NECRONOMICON_CONST.Pattern.Rank ) do
							rank = tonumber(rank)
							if( rank > maxrank ) then
								maxrank = rank
							end
						end
					end					
					if( maxrank == 0 ) then
						maxrank = 1
					end
					if( not spellLevel[spellName] or maxrank > spellLevel[spellName] ) then
						self.spells.timedname[strlower(spellName)] = strlower(spellTotal)
					end
					self.spells.timedid[id] = strlower(spellTotal)
					self.spells.timed[strlower(spellTotal)] = NECRONOMICON_CONST.TimedSpell[spellName][maxrank]
					self.spells.timeddisplay[strlower(spellTotal)] = spellName
				end
			end
		end
	end,	


	GetTargetInfo = function( self )

		local targetInfo = { }
	
		if( UnitExists("target") ) then
	
			targetInfo.Name = UnitName("target")
			targetInfo.Sex = UnitSex("target")
			targetInfo.Level = UnitLevel("target")
			if( targetInfo.Level == -1 ) then targetInfo.Level = "??" end

			targetInfo.Classification = UnitClassification("target")
			if( targetInfo.Classification == "worldboss" ) then
				targetInfo.Classification = "b+"
			elseif( targetInfo.Classification == "rareelite" ) then
				targetInfo.Classification = "r+"
			elseif( targetInfo.Classification == "elite" ) then
				targetInfo.Classification = "+"
			elseif( targetInfo.Classification == "rare" ) then
				targetInfo.Classification = "r"
			else 
				targetInfo.Classification = ""
			end

			targetInfo.IsPlayer = UnitIsPlayer("target")
			targetInfo.IsEnemy = UnitCanAttack("player", "target")
			targetInfo.Id = targetInfo.Name..targetInfo.Sex..targetInfo.Level
			targetInfo.Display = "["..targetInfo.Level..targetInfo.Classification.."] "..targetInfo.Name
		
			return targetInfo
		else
			return FALSE
		end
	
	end,

	RegisterSpellCast = function( self, spell )

		if( not self:GetOpt("timers") )	then return end

		if( self.currentspell.state and 
				self.currentspell.state == NECRONOMICON_CONST.State.Start ) then
			-- We do nothing. This happens when you cast a spell with a duration and
			-- after that cast another spell, which attempt to register with the timers.
			-- the state will be > 1 when SPELLCAST_START has fired we are casting atm.
			-- so ignore this cast.
			return
		end
	
		-- We reset the current spellcast whatever happens next.
		self.Compost:Erase( self.currentspell )

		-- Not a valid spell? don't do a thing
		if( not self.spells.timed[spell] ) then return end

		-- If we don't have a target this spell is not worth monitoring for our purposes
		local target = self:GetTargetInfo()
		if( not target ) then return end
			
		-- Valid Spell, Valid target
		self.currentspell.state = NECRONOMICON_CONST.State.Cast
		self.currentspell.target = target
		self.currentspell.spell = spell
		self.currentspell.spelldisplay = self.spells.timeddisplay[spell]
		self.currentspell.duration = self.spells.timed[spell]
		
		-- self:Msg( "Registered t:"..self.currentspell.target.Display.." s: "..self.currentspell.spell.." d: "..self.currentspell.duration )
	end,

	DeleteSoulstoneTimer = function( self )
		self.soulstonetimer = nil
		self.soulstonetarget = nil
		if( self:GetOpt("soulstonesound") ) then
			PlaySoundFile("Interface\\AddOns\\Necronomicon\\Sounds\\Soulstone.mp3")
		end
	end,

	ClearTimers = function( self )
		local i,j
		for i in pairs( self.timers ) do
			for j in pairs( self.timers[i] ) do
				if( j ~= "name" and j ~= "nr" ) then
					Timex:DeleteSchedule("Necronomicon Timers "..i..j)
				end
			end
		end
		self.Compost:Erase( self.timers )
	end,

	TimerDeleteSpell = function( self, mindex, sindex )
		if( self.timers[mindex] ) then
			if( self.timers[mindex][sindex] ) then
				self.timers[mindex][sindex]["duration"] = nil
				self.timers[mindex][sindex] = nil 
				self.timers[mindex]["nr"] = self.timers[mindex]["nr"] - 1
			end
			if( self.timers[mindex]["nr"] < 1 ) then
				self.timers[mindex]["name"] = nil
				self.timers[mindex]["nr"] = nil
				self.timers[mindex] = nil
			end
		end
	end,

	TimerAddSpell = function( self )
		local mindex = self.currentspell.target.Id
		local sindex = self.currentspell.spelldisplay
		if( self.timers[mindex] ) then
			if( self.timers[mindex][sindex] ) then
				-- self:Msg("AddSpell Updating "..mindex..sindex )
				self.currentspell.state = NECRONOMICON_CONST.State.Update
				self.currentspell.oldduration = Timex:ScheduleCheck("Necronomicon Timers "..mindex..sindex, TRUE)
				Timex:DeleteSchedule("Necronomicon Timers "..mindex..sindex )
				Timex:AddSchedule("Necronomicon Timers "..mindex..sindex, self.currentspell.duration, nil, nil, Necronomicon.TimerDeleteSpell, Necronomicon, mindex, sindex )
				self.timers[mindex][sindex]["duration"] = self.currentspell.duration
			else
				-- self:Msg("AddSpell Newspell "..mindex..sindex )
				self.currentspell.state = NECRONOMICON_CONST.State.NewSpell
				self.timers[mindex][sindex] = {}
				self.timers[mindex][sindex]["duration"] = self.currentspell.duration
				self.timers[mindex]["nr"] = self.timers[mindex]["nr"] + 1
				Timex:AddSchedule("Necronomicon Timers "..mindex..sindex, self.currentspell.duration, nil, nil, Necronomicon.TimerDeleteSpell, Necronomicon, mindex, sindex )
			end
		else
			-- self:Msg("AddSpell Newmonster&spell "..mindex..sindex )
			self.currentspell.state = NECRONOMICON_CONST.State.NewMonsterNewSpell
			self.timers[mindex] = {}
			self.timers[mindex]["nr"] = 0
			self.timers[mindex]["name"] = self.currentspell.target.Display
			self.timers[mindex][sindex] = {}
			self.timers[mindex][sindex]["duration"] = self.currentspell.duration
			self.timers[mindex]["nr"] = self.timers[mindex]["nr"] + 1
			Timex:AddSchedule("Necronomicon Timers "..mindex..sindex, self.currentspell.duration, nil, nil, Necronomicon.TimerDeleteSpell, Necronomicon, mindex, sindex )
		end
	end,
	
	TimerRollback = function( self )
		local mindex = self.currentspell.target.Id
		local sindex = self.currentspell.spelldisplay
		local i
		if( not mindex or not sindex ) then return end
		if( self.currentspell.state == NECRONOMICON_CONST.State.NewMonsterNewSpell ) then
			if( self.timers[mindex] and self.timers[mindex][sindex] ) then
				self.timers[mindex][sindex]["duration"] = nil
				self.timers[mindex][sindex] = nil
				self.timers[mindex]["name"] = nil
				self.timers[mindex]["nr"] = nil
				self.timers[mindex] = nil
				Timex:DeleteSchedule( "Necronomicon Timers "..mindex..sindex )
			end
		elseif( self.currentspell.state == NECRONOMICON_CONST.State.NewSpell ) then
			if( self.timers[mindex] and self.timers[mindex][sindex] ) then
				self.timers[mindex][sindex]["duration"] = nil
				self.timers[mindex][sindex] = nil
				self.timers[mindex]["nr"] = self.timers[mindex]["nr"] - 1
				Timex:DeleteSchedule( "Necronomicon Timers "..mindex..sindex )
			end
		elseif( self.currentspell.state == NECRONOMICON_CONST.State.Update ) then
			Timex:DeleteSchedule( "Necronomicon Timers "..mindex..sindex )
			Timex:AddSchedule( "Necronomicon Timers "..mindex..sindex, (self.currentspell.duration - self.currentspell.oldduration), nil, nil, Necronomicon.TimerDeleteSpell, Necronomicon, mindex, sindex )
		end
	end,

	SendChatMessage = function( self, msg )
		if (GetNumRaidMembers() > 0) then
			SendChatMessage(msg, "RAID");
		elseif (GetNumPartyMembers() > 0) then
			SendChatMessage(msg, "PARTY");
		else
			SendChatMessage(msg, "SAY");
		end
	end,
	
	BuildTime = function( self, duration )
		local minute
		if( duration > 59 ) then
			minute = floor( duration / 60 )
			duration = duration - (minute *60)
		else
			minute = 0
		end
		if( minute < 10 ) then minute = "0"..minute end
		if( duration < 10 ) then duration  = "0"..duration end
		return minute..":"..duration	
	end,

	SummonDemon = function( self, spellid )
		local modifier = self:GetOpt("feldommodifier")
		local modused = nil

		if( modifier == "ctrl" and IsControlKeyDown() ) then
			modused = TRUE				
		elseif( modifier == "alt" and IsAltKeyDown() ) then
			modused = TRUE
		elseif( modifier == "shift" and IsShiftKeyDown() ) then
			modused = TRUE
		end
		if( modused and self.spells.normal["FELDOMINATION"] ) then
			local start, dur = GetSpellCooldown( self.spells.normal["FELDOMINATION"], BOOKTYPE_SPELL )
			if( start == 0 and dur == 0 ) then
				CastSpell(self.spells.normal["FELDOMINATION"], BOOKTYPE_SPELL )
				SpellStopCasting()
			end
		end
		CastSpell( spellid, BOOKTYPE_SPELL )
		if( self:GetOpt("closeonclick") ) then
			self:DemonsClicked()
		end
	end,


	CastDemonsMenu = function( self, spellid )
		CastSpell( spellid, BOOKTYPE_SPELL )
		if( self:GetOpt("closeonclick") ) then
			self:DemonsClicked()
		end
	end,

----------------------------
-- GUI Updating Functions --
----------------------------

	SetupFrames = function( self )
		local x, y
		self.frames = {}
		self.frames.main = CreateFrame( "Frame", nil, UIParent )
		self.frames.main.owner = self
		self.frames.main:Hide()
		self.frames.main:EnableMouse(true)
		self.frames.main:SetMovable(true)
		self.frames.main:SetWidth(1)
		self.frames.main:SetHeight(1)
		if( self:GetOpt("mainx") and self:GetOpt("mainy") ) then
			x = self:GetOpt("mainx")
			y = self:GetOpt("mainy")
			self.frames.main:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x, y )
		else
		self.frames.main:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 150, -150)
		end
		
		-- Graphical Shardcounter
		self.frames.shard = CreateFrame( "Button", nil, self.frames.main )
		self.frames.shard.owner = self
		self.frames.shard:SetWidth(64)
		self.frames.shard:SetHeight(64)
		self.frames.shard:SetPoint("CENTER", self.frames.main, "CENTER" )
		self.frames.shard:RegisterForDrag("LeftButton")
		self.frames.shard:SetScript("OnDragStart", function() this.owner.frames.main:StartMoving() end )
		self.frames.shard:SetScript("OnDragStop",
			function() 
				this.owner.frames.main:StopMovingOrSizing()
				local _,_,_,x,y = this.owner.frames.main:GetPoint("CENTER")
				this.owner:SetOpt("mainx", x)
				this.owner:SetOpt("mainy", y)
			end
		)		
		

		-- Text inside the counter		
		self.frames.shardtext = self.frames.shard:CreateFontString(nil, "OVERLAY")
		self.frames.shardtext.owner = self
		self.frames.shardtext:SetFontObject(GameFontNormalSmall)
		self.frames.shardtext:ClearAllPoints()
		self.frames.shardtext:SetTextColor(1, 1, 1, 1) 
		self.frames.shardtext:SetWidth(64)
		self.frames.shardtext:SetHeight(64)
		self.frames.shardtext:SetPoint("TOPLEFT", self.frames.shard, "TOPLEFT")
		self.frames.shardtext:SetJustifyH("CENTER")
		self.frames.shardtext:SetJustifyV("MIDDLE")
	
		-- Healthstone button
		self.frames.healthstone = CreateFrame("Button", nil, self.frames.main )
		self.frames.healthstone.owner = self
		self.frames.healthstone:SetWidth(32)
		self.frames.healthstone:SetHeight(32)
		self.frames.healthstone:SetPoint("CENTER", self.frames.main, "CENTER", -14, -45 )
		self.frames.healthstone:SetNormalTexture( "Interface\\AddOns\\Necronomicon\\Images\\EmptyButton" )
		self.frames.healthstone:SetHighlightTexture( "Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight" )
		self.frames.healthstone:SetScript("OnClick", function() this.owner:HealthstoneClicked() end )

		-- Soulstone button
		self.frames.soulstone = CreateFrame("Button", nil, self.frames.main )
		self.frames.soulstone.owner = self
		self.frames.soulstone:SetWidth(32)
		self.frames.soulstone:SetHeight(32)
		self.frames.soulstone:SetPoint("CENTER", self.frames.main, "CENTER", -40, -33 )
		self.frames.soulstone:SetNormalTexture( "Interface\\AddOns\\Necronomicon\\Images\\EmptyButton" )
		self.frames.soulstone:SetHighlightTexture( "Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight" )
		self.frames.soulstone:SetScript("OnClick", function() this.owner:SoulstoneClicked() end )

		-- Spellstone button
		self.frames.spellstone = CreateFrame("Button", nil, self.frames.main )
		self.frames.spellstone.owner = self
		self.frames.spellstone:SetWidth(32)
		self.frames.spellstone:SetHeight(32)
		self.frames.spellstone:SetPoint("CENTER", self.frames.main, "CENTER", 14, -45 )
		self.frames.spellstone:SetNormalTexture( "Interface\\AddOns\\Necronomicon\\Images\\EmptyButton" )
		self.frames.spellstone:SetHighlightTexture( "Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight" )
		self.frames.spellstone:SetScript("OnClick", function() this.owner:SpellstoneClicked() end )

		-- Firestone button
		self.frames.firestone = CreateFrame("Button", nil, self.frames.main )
		self.frames.firestone.owner = self
		self.frames.firestone:SetWidth(32)
		self.frames.firestone:SetHeight(32)
		self.frames.firestone:SetPoint("CENTER", self.frames.main, "CENTER", 40, -33 )
		self.frames.firestone:SetNormalTexture( "Interface\\AddOns\\Necronomicon\\Images\\EmptyButton" )
		self.frames.firestone:SetHighlightTexture( "Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight" )
		self.frames.firestone:SetScript("OnClick", function() this.owner:FirestoneClicked() end )

		-- Demons button
		self.frames.demons = CreateFrame("Button", nil, self.frames.main )
		self.frames.demons.owner = self
		self.frames.demons:SetWidth(32)
		self.frames.demons:SetHeight(32)
		self.frames.demons:SetPoint("CENTER", self.frames.main, "CENTER", -40, 33 )
		self.frames.demons:SetNormalTexture( "Interface\\AddOns\\Necronomicon\\Images\\EmptyButton" )
		self.frames.demons:SetHighlightTexture( "Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight" )
		self.frames.demons:SetScript("OnClick", function() this.owner:DemonsClicked() end )

		-- Mount button
		self.frames.mount = CreateFrame("Button", nil, self.frames.main )
		self.frames.mount.owner = self
		self.frames.mount:SetWidth(32)
		self.frames.mount:SetHeight(32)
		self.frames.mount:SetPoint("CENTER", self.frames.main, "CENTER", -14, 45 )
		self.frames.mount:SetNormalTexture( "Interface\\AddOns\\Necronomicon\\Images\\EmptyButton" )
		self.frames.mount:SetHighlightTexture( "Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight" )
		self.frames.mount:SetScript("OnClick", function() this.owner:MountClicked() end )

		-- Demon Armor button
		self.frames.armor = CreateFrame("Button", nil, self.frames.main )
		self.frames.armor.owner = self
		self.frames.armor:SetWidth(32)
		self.frames.armor:SetHeight(32)
		self.frames.armor:SetPoint("CENTER", self.frames.main, "CENTER", 14, 45 )
		self.frames.armor:SetNormalTexture( "Interface\\AddOns\\Necronomicon\\Images\\EmptyButton" )
		self.frames.armor:SetHighlightTexture( "Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight" )
		self.frames.armor:SetScript("OnClick", function() this.owner:ArmorClicked() end )

		-- Summon button
		self.frames.summon = CreateFrame("Button", nil, self.frames.main )
		self.frames.summon.owner = self
		self.frames.summon:SetWidth(32)
		self.frames.summon:SetHeight(32)
		self.frames.summon:SetPoint("CENTER", self.frames.main, "CENTER", 40, 33 )
		self.frames.summon:SetNormalTexture( "Interface\\AddOns\\Necronomicon\\Images\\EmptyButton" )
		self.frames.summon:SetHighlightTexture( "Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight" )
		self.frames.summon:SetScript("OnClick", function() this.owner:SummonClicked() end )


		-- Teh Demons
		self.frames.demonmenu = CreateFrame("Frame", nil, self.frames.demons )
		self.frames.demonmenu.owner = self
		self.frames.demonmenu:SetWidth(1)
		self.frames.demonmenu:SetHeight(1)
		self.frames.demonmenu:SetPoint("TOPRIGHT", self.frames.demons, "TOPLEFT" )
		self.frames.demonmenu:Hide()
	
		-- Imp
		self.frames.imp = CreateFrame("Button", nil, self.frames.demonmenu )
		self.frames.imp.owner = self
		self.frames.imp:SetWidth(36)
		self.frames.imp:SetHeight(36)
		self.frames.imp:SetNormalTexture( "Interface\\Icons\\Spell_Shadow_SummonImp")
		self.frames.imp:SetHighlightTexture( "Interface\\Buttons\\ButtonHilight-Square" )
		self.frames.imp:SetPoint("TOPRIGHT", self.frames.demonmenu, "TOPLEFT", 0, 0 )
		self.frames.imp:SetScript("OnClick", function() this.owner:SummonDemon( this.owner.spells.normal["IMP"] ) end )		

		-- Voidwalker
		self.frames.voidwalker = CreateFrame("Button", nil, self.frames.demonmenu )
		self.frames.voidwalker.owner = self
		self.frames.voidwalker:SetWidth(36)
		self.frames.voidwalker:SetHeight(36)
		self.frames.voidwalker:SetNormalTexture( "Interface\\Icons\\Spell_Shadow_SummonVoidwalker")
		self.frames.voidwalker:SetHighlightTexture( "Interface\\Buttons\\ButtonHilight-Square" )
		self.frames.voidwalker:SetPoint("TOPRIGHT", self.frames.demonmenu, "TOPLEFT", -36, 0 )
		self.frames.voidwalker:SetScript("OnClick", function() this.owner:SummonDemon( this.owner.spells.normal["VOIDWALKER"] ) end )		

		-- Succubus
		self.frames.succubus = CreateFrame("Button", nil, self.frames.demonmenu )
		self.frames.succubus.owner = self
		self.frames.succubus:SetWidth(36)
		self.frames.succubus:SetHeight(36)
		self.frames.succubus:SetNormalTexture( "Interface\\Icons\\Spell_Shadow_SummonSuccubus")
		self.frames.succubus:SetHighlightTexture( "Interface\\Buttons\\ButtonHilight-Square" )
		self.frames.succubus:SetPoint("TOPRIGHT", self.frames.demonmenu, "TOPLEFT", -72, 0 )
		self.frames.succubus:SetScript("OnClick", function() this.owner:SummonDemon( this.owner.spells.normal["SUCCUBUS"] ) end )		

		-- Felhunter
		self.frames.felhunter = CreateFrame("Button", nil, self.frames.demonmenu )
		self.frames.felhunter.owner = self
		self.frames.felhunter:SetWidth(36)
		self.frames.felhunter:SetHeight(36)
		self.frames.felhunter:SetNormalTexture( "Interface\\Icons\\Spell_Shadow_SummonFelhunter")
		self.frames.felhunter:SetHighlightTexture( "Interface\\Buttons\\ButtonHilight-Square" )
		self.frames.felhunter:SetPoint("TOPRIGHT", self.frames.demonmenu, "TOPLEFT", -108, 0 )
		self.frames.felhunter:SetScript("OnClick", function() this.owner:SummonDemon( this.owner.spells.normal["FELHUNTER"] ) end )		

		-- Inferno
		self.frames.inferno = CreateFrame("Button", nil, self.frames.demonmenu )
		self.frames.inferno.owner = self
		self.frames.inferno:SetWidth(36)
		self.frames.inferno:SetHeight(36)
		self.frames.inferno:SetNormalTexture( "Interface\\Icons\\Spell_Shadow_SummonInfernal")
		self.frames.inferno:SetHighlightTexture( "Interface\\Buttons\\ButtonHilight-Square" )
		self.frames.inferno:SetPoint("TOPRIGHT", self.frames.demonmenu, "TOPLEFT", -108, -36 )
		self.frames.inferno:SetScript("OnClick", function() this.owner:CastDemonsMenu( this.owner.spells.normal["INFERNO"] ) end )		

		-- Eye of Kilrogg
		self.frames.kilrogg = CreateFrame("Button", nil, self.frames.demonmenu )
		self.frames.kilrogg.owner = self
		self.frames.kilrogg:SetWidth(36)
		self.frames.kilrogg:SetHeight(36)
		self.frames.kilrogg:SetNormalTexture( "Interface\\Icons\\Spell_Shadow_EvilEye")
		self.frames.kilrogg:SetHighlightTexture( "Interface\\Buttons\\ButtonHilight-Square" )
		self.frames.kilrogg:SetPoint("TOPRIGHT", self.frames.demonmenu, "TOPLEFT", -72, -36 )
		self.frames.kilrogg:SetScript("OnClick", function() this.owner:CastDemonsMenu( this.owner.spells.normal["KILROGG"] ) end )		

		-- Health Funnel
		self.frames.healthfunnel = CreateFrame("Button", nil, self.frames.demonmenu )
		self.frames.healthfunnel.owner = self
		self.frames.healthfunnel:SetWidth(36)
		self.frames.healthfunnel:SetHeight(36)
		self.frames.healthfunnel:SetNormalTexture( "Interface\\Icons\\Spell_Shadow_LifeDrain")
		self.frames.healthfunnel:SetHighlightTexture( "Interface\\Buttons\\ButtonHilight-Square" )
		self.frames.healthfunnel:SetPoint("TOPRIGHT", self.frames.demonmenu, "TOPLEFT", -36, -36 )
		self.frames.healthfunnel:SetScript("OnClick", function() this.owner:CastDemonsMenu( this.owner.spells.normal["HEALTHFUNNEL"] ) end )		

		-- Ritual of Doom
		self.frames.doomguard = CreateFrame("Button", nil, self.frames.demonmenu )
		self.frames.doomguard.owner = self
		self.frames.doomguard:SetWidth(36)
		self.frames.doomguard:SetHeight(36)
		self.frames.doomguard:SetNormalTexture( "Interface\\Icons\\Spell_Shadow_AntiMagicShell")
		self.frames.doomguard:SetHighlightTexture( "Interface\\Buttons\\ButtonHilight-Square" )
		self.frames.doomguard:SetPoint("TOPRIGHT", self.frames.demonmenu, "TOPLEFT", -108, -72 )
		self.frames.doomguard:SetScript("OnClick", function() this.owner:CastDemonsMenu( this.owner.spells.normal["DOOMGUARD"] ) end )		

		-- Fel Domination
		self.frames.feldomination = CreateFrame("Button", nil, self.frames.demonmenu )
		self.frames.feldomination.owner = self
		self.frames.feldomination:SetWidth(36)
		self.frames.feldomination:SetHeight(36)
		self.frames.feldomination:SetNormalTexture( "Interface\\Icons\\Spell_Nature_RemoveCurse")
		self.frames.feldomination:SetHighlightTexture( "Interface\\Buttons\\ButtonHilight-Square" )
		self.frames.feldomination:SetPoint("TOPRIGHT", self.frames.demonmenu, "TOPLEFT", -0, -36 )
		self.frames.feldomination:SetScript("OnClick", function() this.owner:CastDemonsMenu( this.owner.spells.normal["FELDOMINATION"] ) end )		

		-- Demonic Sacrifice
		self.frames.demonicsacrifice = CreateFrame("Button", nil, self.frames.demonmenu )
		self.frames.demonicsacrifice.owner = self
		self.frames.demonicsacrifice:SetWidth(36)
		self.frames.demonicsacrifice:SetHeight(36)
		self.frames.demonicsacrifice:SetNormalTexture( "Interface\\Icons\\Spell_Shadow_PsychicScream")
		self.frames.demonicsacrifice:SetHighlightTexture( "Interface\\Buttons\\ButtonHilight-Square" )
		self.frames.demonicsacrifice:SetPoint("TOPRIGHT", self.frames.demonmenu, "TOPLEFT", -0, -72 )
		self.frames.demonicsacrifice:SetScript("OnClick", function() this.owner:CastDemonsMenu( this.owner.spells.normal["DEMONICSACRIFICE"] ) end )		

		-- Soul Link
		self.frames.soullink = CreateFrame("Button", nil, self.frames.demonmenu )
		self.frames.soullink.owner = self
		self.frames.soullink:SetWidth(36)
		self.frames.soullink:SetHeight(36)
		self.frames.soullink:SetNormalTexture( "Interface\\Icons\\Spell_Shadow_GatherShadows")
		self.frames.soullink:SetHighlightTexture( "Interface\\Buttons\\ButtonHilight-Square" )
		self.frames.soullink:SetPoint("TOPRIGHT", self.frames.demonmenu, "TOPLEFT", -36, -72 )
		self.frames.soullink:SetScript("OnClick", function() this.owner:CastDemonsMenu( this.owner.spells.normal["SOULLINK"] ) end )		

		-- Enslave Demon
		self.frames.enslave = CreateFrame("Button", nil, self.frames.demonmenu )
		self.frames.enslave.owner = self
		self.frames.enslave:SetWidth(36)
		self.frames.enslave:SetHeight(36)
		self.frames.enslave:SetNormalTexture( "Interface\\Icons\\Spell_Shadow_EnslaveDemon")
		self.frames.enslave:SetHighlightTexture( "Interface\\Buttons\\ButtonHilight-Square" )
		self.frames.enslave:SetPoint("TOPRIGHT", self.frames.demonmenu, "TOPLEFT", -72, -72 )
		self.frames.enslave:SetScript("OnClick", function() this.owner:CastDemonsMenu( this.owner.spells.normal["ENSLAVE"] ) end )		



		-- Spelltimers
		self.frames.timers = CreateFrame("Button", nil, self.frames.main )
		self.frames.timers.owner = self
		self.frames.timers:SetMovable(true)
		self.frames.timers:EnableMouse(true)
		self.frames.timers:SetWidth(150)
		self.frames.timers:SetHeight(25)
		self.frames.timers:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
                                            edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                                            tile = false, tileSize = 16, edgeSize = 16, 
                                            insets = { left = 5, right =5, top = 5, bottom = 5 }})


		self.frames.timers:SetBackdropColor( 0.7, 0, 0.7, 1 )
		self.frames.timers:SetBackdropBorderColor( 1, 1, 1, 1)
		if( self:GetOpt("timerx") and self:GetOpt("timery") ) then
			x = self:GetOpt("timerx")
			y = self:GetOpt("timery")
			self.frames.timers:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x, y )
		else
			self.frames.timers:SetPoint("TOPLEFT", self.frames.main, "BOTTOM", 60, 40)
		end
		self.frames.timers:RegisterForDrag("LeftButton")
		self.frames.timers:SetScript("OnDragStart", function() this:StartMoving() end )
		self.frames.timers:SetScript("OnDragStop", 
			function() 
				this:StopMovingOrSizing()
				local _,_,_,x,y = this:GetPoint("TOPLEFT")
				this.owner:SetOpt("timerx", x)
				this.owner:SetOpt("timery", y)
			end
		)
		
		self.frames.timersheader = self.frames.timers:CreateFontString(nil, "OVERLAY")
		self.frames.timersheader.owner = self
		self.frames.timersheader:SetFontObject(GameFontNormalSmall)
		self.frames.timersheader:ClearAllPoints()
		self.frames.timersheader:SetTextColor(0.8, 0.8, 1, 1)
		self.frames.timersheader:SetPoint("CENTER", self.frames.timers, "CENTER", 0, 1 )
		self.frames.timersheader:SetJustifyH("CENTER")
		self.frames.timersheader:SetJustifyV("MIDDLE")
		self.frames.timersheader:SetText( NECRONOMICON_CONST.Timerheader )

		
		self.frames.timerstext = self.frames.timers:CreateFontString(nil, "OVERLAY")
		self.frames.timerstext.owner = self
		self.frames.timerstext:SetFontObject(GameFontNormalSmall)
		self.frames.timerstext:ClearAllPoints()
		self.frames.timerstext:SetTextColor(1, 1, 1, 1)
		self.frames.timerstext:SetPoint("TOPLEFT", self.frames.timers, "TOPLEFT", 10, -6 )
		self.frames.timerstext:SetJustifyH("LEFT")
		self.frames.timerstext:SetJustifyV("MIDDLE")
		self.frames.timerstext:SetWidth(200)
		self.frames.timerstext:SetText( "" )

		self:UpdateFrameLocks()
	end,

	UpdateShardCount = function( self )
		local texture = self:GetOpt("texture")

		if(texture) then
			if( self.shardcount < 33 ) then
				self.frames.shard:SetNormalTexture( "Interface\\AddOns\\Necronomicon\\Images\\".. texture .."\\Shard"..self.shardcount )
			else
				self.frames.shard:SetNormalTexture( "Interface\\AddOns\\Necronomicon\\Images\\".. texture .."\\Shard32" )
			end
		else
			if( self.shardcount < 17 ) then
				self.frames.shard:SetNormalTexture( "Interface\\AddOns\\Necronomicon\\Images\\CounterButton-"..self.shardcount )
			else
				self.frames.shard:SetNormalTexture( "Interface\\AddOns\\Necronomicon\\Images\\CounterButton-16" )
			end
		end
		self.frames.shardtext:SetText(""..self.shardcount )
	end,

	UpdateHealthstone = function( self )
		if( not self.spells.normal["HEALTHSTONE"] ) then
			self.frames.healthstone:Hide()
			return
		end
		
		if( self.healthstone[0] ~= nil ) then
			self.frames.healthstone:SetNormalTexture( "Interface\\AddOns\\Necronomicon\\Images\\HealthstoneButton-03" )
		else
			self.frames.healthstone:SetNormalTexture( "Interface\\AddOns\\Necronomicon\\Images\\HealthstoneButton-01" )
		end
		self.frames.healthstone:Show()
	end,

	UpdateSoulstone = function( self )
		if( not self.spells.normal["SOULSTONE"] ) then
			self.frames.soulstone:Hide()
			return
		end
		if( self.soulstone[0] ) then
			self.frames.soulstone:SetNormalTexture( "Interface\\AddOns\\Necronomicon\\Images\\SoulstoneButton-02" )
		else
			self.frames.soulstone:SetNormalTexture( "Interface\\AddOns\\Necronomicon\\Images\\SoulstoneButton-01" )
		end
		self.frames.soulstone:Show()
	end,

	UpdateSpellstone = function( self )
		if( not self.spells.normal["SPELLSTONE"] ) then
			self.frames.spellstone:Hide()
			return
		end
		if( self.spellstone[0] ~= nil ) then
			if( self.spellstone[2] ) then
				self.frames.spellstone:SetNormalTexture( "Interface\\AddOns\\Necronomicon\\Images\\SpellstoneButton-03" )
			else
				self.frames.spellstone:SetNormalTexture( "Interface\\AddOns\\Necronomicon\\Images\\SpellstoneButton-02" )
			end
		else
			self.frames.spellstone:SetNormalTexture( "Interface\\AddOns\\Necronomicon\\Images\\SpellstoneButton-01" )
		end
		self.frames.spellstone:Show()
	end,

	UpdateFirestone = function( self )
		if( not self.spells.normal["FIRESTONE"] ) then
			self.frames.firestone:Hide()
			return
		end
		if( self.firestone[0] ~= nil ) then
			if( self.firestone[2] ) then
				self.frames.firestone:SetNormalTexture( "Interface\\AddOns\\Necronomicon\\Images\\FirestoneButton-03" )
			else
				self.frames.firestone:SetNormalTexture( "Interface\\AddOns\\Necronomicon\\Images\\FirestoneButton-02" )
			end
		else
			self.frames.firestone:SetNormalTexture( "Interface\\AddOns\\Necronomicon\\Images\\FirestoneButton-01" )
		end
		self.frames.firestone:Show()
	end,


	UpdateOtherButtons = function( self ) 
		if( not self.spells.normal["ARMOR"] ) then
			self.frames.armor:Hide()
		else
			self.frames.armor:SetNormalTexture( "Interface\\AddOns\\Necronomicon\\Images\\DemonicArmorButton-01" )
			self.frames.armor:Show()
		end
		if( not self.spells.normal["RITUALOFSUMMONING"] ) then
			self.frames.summon:Hide()
		else
			self.frames.summon:SetNormalTexture( "Interface\\AddOns\\Necronomicon\\Images\\RitualSummonButton-01" )
			self.frames.summon:Show()
		end
		if( not self.spells.normal["MOUNT"] ) then
			self.frames.mount:Hide()
		else
			self.frames.mount:SetNormalTexture( "Interface\\AddOns\\Necronomicon\\Images\\MountButton-0"..self.mounttype )
			self.frames.mount:Show()
		end
		if( not self.hasdemons ) then
			self.frames.demons:Hide()
		else
			self.frames.demons:SetNormalTexture( "Interface\\AddOns\\Necronomicon\\Images\\SummonerButton-00" )
			self.frames.demons:Show()
			if( self.spells.normal["IMP"] ) then
				self.frames.imp:Show()
			else
				self.frames.imp:Hide()
			end
			if( self.spells.normal["VOIDWALKER"] ) then
				self.frames.voidwalker:Show()
			else
				self.frames.voidwalker:Hide()
			end
			if( self.spells.normal["SUCCUBUS"] ) then
				self.frames.succubus:Show()
			else
				self.frames.succubus:Hide()
			end			
			if( self.spells.normal["FELHUNTER"] ) then
				self.frames.felhunter:Show()
			else
				self.frames.felhunter:Hide()
			end			
			
			if( self.spells.normal["INFERNO"] ) then
				self.frames.inferno:Show()
			else
				self.frames.inferno:Hide()
			end			

			if( self.spells.normal["DOOMGUARD"] ) then
				self.frames.doomguard:Show()
			else
				self.frames.doomguard:Hide()
			end			

			if( self.spells.normal["FELDOMINATION"] ) then
				self.frames.feldomination:Show()
			else
				self.frames.feldomination:Hide()
			end			

			if( self.spells.normal["DEMONICSACRIFICE"] ) then
				self.frames.demonicsacrifice:Show()
			else
				self.frames.demonicsacrifice:Hide()
			end			
			if( self.spells.normal["ENSLAVE"] ) then
				self.frames.enslave:Show()
			else
				self.frames.enslave:Hide()
			end			

			if( self.spells.normal["SOULLINK"] ) then
				self.frames.soullink:Show()
			else
				self.frames.soullink:Hide()
			end			
			if( self.spells.normal["KILROGG"] ) then
				self.frames.kilrogg:Show()
			else
				self.frames.kilrogg:Hide()
			end			
			if( self.spells.normal["HEALTHFUNNEL"] ) then
				self.frames.healthfunnel:Show()
			else
				self.frames.healthfunnel:Hide()
			end			

		end
	end,

	UpdateTimers = function( self )
		local mindex, sindex, duration, text, tleft, gradient
		
		self.timerstext = ""

		if( self.soulstonetimer and self.soulstonetimer == 2 ) then
			duration = Timex:ScheduleCheck("Necronomicon Soulstone Timer", TRUE)
			-- tleft = floor(1800 - duration)
			tleft = floor(duration)
			text = self:BuildTime(tleft)
			gradient = self:GetGradient( floor((tleft/1800)*100) )			
			self.timerstext = self.timerstext .. "\n\n|CFF00FF00"..self.soulstonetarget.."|r"
			self.timerstext = self.timerstext .. "\n  "..gradient..NECRONOMICON_CONST.Pattern.SoulstoneResurrection.." "..text.."|r"
		end
		
		for mindex in pairs(self.timers) do
			if( self.timers[mindex]["name"] ) then
				self.timerstext = self.timerstext .. "\n\n".."|CFFFF5555"..self.timers[mindex]["name"].."|r"
				for sindex in pairs(self.timers[mindex]) do
					if( sindex ~= "name" and sindex ~= "nr" ) then
						duration = Timex:ScheduleCheck("Necronomicon Timers "..mindex..sindex, TRUE)
						if( duration ) then
							-- tleft = floor(self.timers[mindex][sindex]["duration"] - duration)
							tleft = floor( duration )
							text = self:BuildTime(tleft)
							gradient = self:GetGradient( floor((tleft/self.timers[mindex][sindex]["duration"])*100) )
							self.timerstext = self.timerstext .. "\n  "..gradient..sindex.." "..text.."|r"
						else
							self.timerstext = self.timerstext .. "\n  "..sindex.." ?? "
						end
					end
				end
			end
		end
		
		self.frames.timerstext:SetText(self.timerstext)
	end,

	UpdateButtons = function( self )
		self:UpdateShardCount()
		self:UpdateHealthstone()
		self:UpdateSoulstone()
		self:UpdateFirestone()
		self:UpdateSpellstone()
		self:UpdateOtherButtons()
	end,

	UpdateFrameLocks = function( self )
		if( self:GetOpt("lock") ) then
			self.frames.timers:SetMovable(false)
			self.frames.timers:SetBackdrop(nil)
			self.frames.timers:SetBackdropColor(0,0,0,0)
			self.frames.timers:SetBackdropBorderColor(0,0,0,0)
			self.frames.main:SetMovable(false)
			self.frames.timers:RegisterForDrag()
			self.frames.shard:RegisterForDrag()
		else
			self.frames.timers:SetMovable(true)
			self.frames.timers:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
	                                            edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
	                                            tile = false, tileSize = 16, edgeSize = 16, 
	                                            insets = { left = 5, right =5, top = 5, bottom = 5 }})
			self.frames.timers:SetBackdropColor( 0.7, 0, 0.7, 1 )
			self.frames.timers:SetBackdropBorderColor( 1, 1, 1, 1)
			self.frames.main:SetMovable(true)
			self.frames.timers:RegisterForDrag("LeftButton")
			self.frames.shard:RegisterForDrag("LeftButton")
		end
	end,
----------------------------
-- ButtonClicks           --
----------------------------

	HealthstoneClicked = function( self )
		if( self.healthstone[0] ~= nil ) then
			if( UnitExists("target") and UnitIsPlayer("target") and not UnitIsEnemy("target", "player") and UnitName("target") ~= UnitName("player") ) then
				if( not UnitCanCooperate("player", "target")) then
					self:Msg( NECRONOMICON_CONST.Message.Busy )
				elseif (not CheckInteractDistance("target",2)) then
					self:Msg( NECRONOMICON_CONST.Message.TooFarAway )
				else
					PickupContainerItem( self.healthstone[0], self.healthstone[1] )
					if ( CursorHasItem() ) then
						DropItemOnUnit("target")
						Timex:AddSchedule("Necronomicon Healthstone Trade", 3, nil, nil, "AcceptTrade", "" )
					end
				end
			elseif( (UnitHealth("player") < UnitHealthMax("player")) and GetContainerItemCooldown(self.healthstone[0],self.healthstone[1]) == 0) then
				UseContainerItem( self.healthstone[0], self.healthstone[1] )
			end
		else
			CastSpell( self.spells.normal["HEALTHSTONE"], BOOKTYPE_SPELL )
		end
	end,

	SoulstoneClicked = function( self )
		if( self.soulstone[0] ~= nil ) then
			if ( not UnitIsEnemy("player", "target") and UnitExists("target") ) then
				UseContainerItem( self.soulstone[0], self.soulstone[1] )
			end
		else
			CastSpell( self.spells.normal["SOULSTONE"], BOOKTYPE_SPELL )
		end
	end,

	SpellstoneClicked = function( self )
		if( self.spellstone[0] ~= nil ) then
			if( self.spellstone[2] ) then
				UseInventoryItem(GetInventorySlotInfo("SecondaryHandSlot"))
				self:BAG_UPDATE()
			else
				UseContainerItem(self.spellstone[0], self.spellstone[1])
			end
		else
			CastSpell( self.spells.normal["SPELLSTONE"], BOOKTYPE_SPELL )
		end
	end,

	FirestoneClicked = function( self )
		if( self.firestone[0] ~= nil ) then
			if( not self.firestone[2] ) then
				UseContainerItem(self.firestone[0], self.firestone[1])
			end
		else
			CastSpell( self.spells.normal["FIRESTONE"], BOOKTYPE_SPELL )
		end
	end,

	DemonsClicked = function( self )
		if( self.frames.demonmenu.opened ) then
			self.frames.demonmenu:Hide()
			self.frames.demonmenu.opened = FALSE
		else
			self.frames.demonmenu:Show()
			self.frames.demonmenu.opened = TRUE
		end
	end,

	SummonClicked = function( self )
		if( self.spells.normal["RITUALOFSUMMONING"] ) then
			CastSpell( self.spells.normal["RITUALOFSUMMONING"], BOOKTYPE_SPELL )
		end
	end,
	
	ArmorClicked = function( self )
		if( self.spells.normal["ARMOR"] ) then
			CastSpell( self.spells.normal["ARMOR"], BOOKTYPE_SPELL )
		end
	end,
	
	MountClicked = function( self )
		if( self.spells.normal["MOUNT"] ) then
			CastSpell( self.spells.normal["MOUNT"], BOOKTYPE_SPELL )
		end
	end,
	
----------------------------
-- WoW Event Handlers     --
----------------------------

	BAG_UPDATE = function( self )		
		local bag = arg1
		Timex:AddSchedule("Necronomicon Bag Update", 0.5, nil, nil, "NECRONOMICON_BAG_UPDATE", Necronomicon )
	end,

	SPELLS_CHANGED = function( self )
		self:ScanSpells()
		self:UpdateButtons()
	end,

	SPELLCAST_START = function( self )
		-- self:Msg("SPELLCAST_START: "..arg1 )
		if( self.currentspell.state ) then
			if( self.currentspell.state == NECRONOMICON_CONST.State.Cast ) then
				self.currentspell.state = NECRONOMICON_CONST.State.Start
				-- we have started casting
			else
				-- I want nothing do do with this cast
				self.Compost:Erase(self.currentspell)
			end
		end
		self.soulstonestate = nil
		if( arg1 == NECRONOMICON_CONST.Pattern.SoulstoneResurrection ) then
			if( UnitName("target") ) then
				self.soulstonetimer = 1
				self.soulstonetarget = "["..UnitLevel("target").."] "..UnitName("target")
				self.soulstonename = UnitName("target")
				self:SendChatMessage(string.format( NECRONOMICON_CONST.Message.PreSoulstone, UnitName("target") ) )
				
			end
		elseif( arg1 == NECRONOMICON_CONST.Pattern.RitualOfSummoning ) then
			if( UnitName("target") ) then
				self:SendChatMessage(string.format( NECRONOMICON_CONST.Message.PreSummon, UnitName("target") ) )
				self.presummoncount = self.shardcount
				self.summoning = true
				self.summonvictim = UnitName("target")
			end
		end
	end,

	SPELLCAST_FAILED = function( self )
		-- self:Msg("SPELLCAST_FAILED" )
		if( self.currentspell.state ) then
			self.currentspell.state = NECRONOMICON_CONST.State.Failed
		end
	end,

	SPELLCAST_STOP = function( self )
		-- self:Msg("SPELLCAST_STOP" )
		if( self.currentspell.state and self.currentspell.state < NECRONOMICON_CONST.State.Stop ) then
			self.currentspell.state = NECRONOMICON_CONST.State.Stop
			self:TimerAddSpell()
		end
		if( self.soulstonetimer and self.soulstonetimer == 1 ) then
			self.soulstonetimer = 2
			self.soulstonestate = 1
			Timex:AddSchedule("Necronomicon Soulstone Timer", 1800, nil, nil, Necronomicon.DeleteSoulstoneTimer, Necronomicon )
			self:SendChatMessage(string.format( NECRONOMICON_CONST.Message.Soulstone, self.soulstonename ) )		
		end
	end,

	SPELLCAST_INTERRUPTED = function( self )
		-- self:Msg("SPELLCAST_INTERRUPTED" )
		if( self.currentspell.state and self.currentspell.state > NECRONOMICON_CONST.State.Stop ) then
			self:TimerRollback()
		end
		if( self.soulstonetimer and self.soulstonestate ) then
			self.soulstonetimer = nil
			self.soulstonestate = nil
			Timex:DeleteSchedule("Necronomicon Soulstone Timer")
			self:SendChatMessage( NECRONOMICON_CONST.Message.SoulstoneAborted )
		end
	end,

	SPELLCAST_CHANNEL_START = function( self )
		-- self:Msg("SPELLCAST_CHANNEL_START: "..arg1)
		if( self.currentspell.state ) then
			if( self.currentspell.state == NECRONOMICON_CONST.State.Cast ) then
				self.currentspell.state = NECRONOMICON_CONST.State.Start
				-- we have started casting
			end
		end
	end,

	SPELLCAST_CHANNEL_STOP = function( self )
		-- self:Msg("SPELLCAST_CHANNEL_STOP")
		if( self.summoning ) then
			self:ScanStones()
			if( self.shardcount >= self.summoncount ) then
				-- failed summoning
				self:SendChatMessage( string.format( NECRONOMICON_CONST.Message.FailedSummon, self.summonvictim) )
			end
			self.summoning = nil
		end
	end,

	PLAYER_REGEN_ENABLED = function( self )
		self:ClearTimers()
	end,

	CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS = function( self )
		if( self:GetOpt("shadowtrancesound") and string.find( arg1, NECRONOMICON_CONST.Pattern.ShadowTrance ) ) then
			PlaySoundFile("Interface\\AddOns\\Necronomicon\\Sounds\\ShadowTrance.mp3")
		end
	end,

	CHAT_MSG_SPELL_SELF_DAMAGE = function( self )
		if( self.currentspell.state and self.currentspell.state > NECRONOMICON_CONST.State.Stop ) then
			if( string.find( arg1, NECRONOMICON_CONST.Pattern.Resisted ) or 
				string.find( arg1, NECRONOMICON_CONST.Pattern.Immune ) ) then
				self:TimerRollback()
			end
		end		
	end,

----------------------------
-- My Event Handlers      --
----------------------------

	NECRONOMICON_BAG_UPDATE = function( self )
		self:ScanStones()
		self:UpdateShardCount()
		self:UpdateHealthstone()
		self:UpdateSoulstone()
		self:UpdateSpellstone()
		self:UpdateFirestone()
	end,


	Heartbeat = function( self)
		self:UpdateTimers()
	end,

----------------------------
-- My Hooks               --
----------------------------
	
	OnCastSpell = function( self, spellid, spellbooktab )
		-- self:Msg( "OnCastSpell: "..spellid..", "..spellbooktab)

		self:CallHook("CastSpell", spellid, spellbooktab )

		if( self.spells.timedid[spellid] ) then
			self:RegisterSpellCast( self.spells.timedid[spellid] )
		end

	end,

	OnCastSpellByName = function( self, spellname )
		-- self:Msg("OnCastSpellByName: "..spellname )

		self:CallHook("CastSpellByName", spellname )

		if( self.spells.timed[strlower(spellname)] ) then
			self:RegisterSpellCast( strlower(spellname) )
		elseif( self.spells.timedname[strlower(spellname)] ) then
			self:RegisterSpellCast( self.spells.timedname[strlower(spellname)] )
		end

	end,

	OnUseAction = function( self, actionid, a2, a3)
		-- self:Msg("OnUseAction: "..actionid )

		self:CallHook("UseAction", actionid, a2, a3 )

		NecronomiconTooltip:SetAction(actionid)

		local lefttext = NecronomiconTooltipTextLeft1:GetText()
		local righttext = NecronomiconTooltipTextRight1:GetText()

		if( lefttext ) then

			if( righttext ) then
				righttext = lefttext.." "..righttext
			else
				righttext = lefttext
			end
			
			lefttext = strlower( lefttext )
			righttext = strlower( righttext )

			if( self.spells.timed[lefttext] ) then
				self:RegisterSpellCast( lefttext )
			elseif( self.spells.timed[righttext] ) then
				self:RegisterSpellCast( righttext ) 
			end
		end


	end,

	-- Not using this for now
	OnUseContainerItem = function( self, index, slot )
		self:Msg("OnUseContainerItem: "..index..", "..slot )
		return self:CallHook("UseContainerItem", index, slot )
	end,

----------------------------
-- Chat       	          --
----------------------------

	chatReset = function( self )
		self.frames.main:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 150, -150)
		self.frames.timers:SetPoint("TOPLEFT", self.frames.main, "BOTTOM", 60, 40)
	end,

	chatFelDom = function( self, modifier ) 
		if( modifier == "ctrl" ) then
			self:SetOpt("feldommodifier", "ctrl")
		elseif( modifier == "alt" ) then
			self:SetOpt("feldommodifier", "alt") 
		elseif( modifier == "shift" ) then
			self:SetOpt("feldommodifier", "shift") 
		elseif( modifier == "none" ) then
			self:SetOpt("feldommodifier", nil )
		else
			self:Msg( NECRONOMICON_CONST.Chat.FelDomValid )
		end
		if( self:GetOpt("feldommodifier") ) then
			self:Msg( NECRONOMICON_CONST.Chat.FelDomModifier .. self:GetOpt("feldommodifier") )
		else
			self:Msg( NECRONOMICON_CONST.Chat.FelDomModifier .. "none" )
		end
	end,


	chatCloseClick = function( self )
		self:TogOpt("closeonclick")
		self:Msg(NECRONOMICON_CONST.Chat.CloseOnClick, ACEG_MAP_ONOFF[self:GetOpt("closeonclick") or 0])		
	end,


	chatShadowTranceSound = function( self )
		self:TogOpt("shadowtrancesound")
		self:Msg(NECRONOMICON_CONST.Chat.ShadowTranceSound, ACEG_MAP_ONOFF[self:GetOpt("shadowtrancesound") or 0])
	end,
	
	chatSoulstoneSound = function( self )
		self:TogOpt("soulstonesound")
		self:Msg(NECRONOMICON_CONST.Chat.SoulstoneSound, ACEG_MAP_ONOFF[self:GetOpt("soulstonesound") or 0])
	end,

	chatTimers = function( self )
		self:TogOpt("timers")
		self:Msg(NECRONOMICON_CONST.Chat.Timers, ACEG_MAP_ONOFF[self:GetOpt("timers") or 0])
		if( self:GetOpt("timers") ) then
			self.Metrognome:Start("Necronomicon")
			self.frames.timers:Show()
		else
			self.Metrognome:Stop("Necronomicon")
			self.frames.timers:Hide()
		end
	end,


	chatLock = function( self )
		self:TogOpt("lock")
		self:Msg(NECRONOMICON_CONST.Chat.Lock, ACEG_MAP_ONOFF[self:GetOpt("lock") or 0])
		self:UpdateFrameLocks()
	end,

	chatTexture = function( self, texture )
		if( texture == "default" ) then
			self:SetOpt("texture", nil)
		elseif( texture == "blue" ) then
			self:SetOpt("texture", "Blue")
		elseif( texture == "orange" ) then
			self:SetOpt("texture", "Orange")
		elseif( texture == "rose" ) then
			self:SetOpt("texture", "Rose")
		elseif( texture == "turquoise" ) then
			self:SetOpt("texture", "Turquoise")
		elseif( texture == "violet" ) then
			self:SetOpt("texture", "Violet")
		elseif( texture == "x" ) then
			self:SetOpt("texture", "X")
		else
			self:Msg( NECRONOMICON_CONST.Chat.TextureValid )
		end
		if( self:GetOpt("texture") ) then
			self:Msg( NECRONOMICON_CONST.Chat.Texture .. self:GetOpt("texture") )
		else
			self:Msg( NECRONOMICON_CONST.Chat.Texture .. "default" )
		end
		self:UpdateShardCount()
	end,




	Report = function( self )
		if( self:GetOpt("texture") ) then
			self:Msg( NECRONOMICON_CONST.Chat.Texture .. self:GetOpt("texture") )
		else
			self:Msg( NECRONOMICON_CONST.Chat.Texture .. "default" )
		end
		if( self:GetOpt("feldommodifier") ) then
			self:Msg( NECRONOMICON_CONST.Chat.FelDomModifier .. self:GetOpt("feldommodifier") )
		else
			self:Msg( NECRONOMICON_CONST.Chat.FelDomModifier .. "none" )
		end
		self:Msg(NECRONOMICON_CONST.Chat.CloseOnClick, ACEG_MAP_ONOFF[self:GetOpt("closeonclick") or 0])
		self:Msg(NECRONOMICON_CONST.Chat.SoulstoneSound, ACEG_MAP_ONOFF[self:GetOpt("soulstonesound") or 0])
		self:Msg(NECRONOMICON_CONST.Chat.ShadowTranceSound, ACEG_MAP_ONOFF[self:GetOpt("shadowtrancesound") or 0])
		self:Msg(NECRONOMICON_CONST.Chat.Lock, ACEG_MAP_ONOFF[self:GetOpt("lock") or 0])
	end,

	-- Command Reporting Closures

	GetOpt = function(self, path, var)
		if (not var) then var = path; path = nil; end
		local profilePath = path and {self.profilePath, path} or self.profilePath;
	   
		return self.db:get(profilePath, var)
	end,
	
	SetOpt = function(self, path, var, val)
		if (not val) then val = var; var = path; path = nil; end
		local profilePath = path and {self.profilePath, path} or self.profilePath;
	
		return self.db:set(profilePath, var, val)
	end,
	
	TogOpt = function(self, path, var)
		if (not var) then var = path; path = nil; end
		local profilePath = path and {self.profilePath, path} or self.profilePath;
	
		return self.db:toggle(profilePath, var)
	end,

	Msg = function(self, ...)
	   self.cmd:result(NECRONOMICON_MSG_COLOR, unpack(arg))
	end,
	
	Result = function(self, text, val, map)
	   if( map ) then val = map[val or 0] or val end
	   self.cmd:result(NECRONOMICON_MSG_COLOR, text, " ", ACEG_TEXT_NOW_SET_TO, " ",
		       format(NECRONOMICON_DISPLAY_OPTION, val or ACE_CMD_REPORT_NO_VAL)
		       )
	end,

	
	TogMsg = function(self, var, text)
	   local val = self:TogOpt(var)
	   self:Result(text, val, ACEG_MAP_ONOFF)
	   return val
	end,
	
	Error = function(self, ...)
	   local text = "";
	   for i=1,getn(arg) do
	      text = text .. arg[i]
	   end
	   error(NECRONOMICON_MSG_COLOR .. text, 2)
	end,
	
	
})

----------------------------------
--			Load this bitch up!			--
----------------------------------
Necronomicon:RegisterForLoad()

