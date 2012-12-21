local dewdrop = DewdropLib:GetInstance('1.0')
local tablet = TabletLib:GetInstance('1.0')
local metrognome = Metrognome:GetInstance('1')
local chosenProfession = SkillsPlusFuLocals.FUBAR_LABEL
local toonSaveKey = ''

SkillsPlusFu = FuBarPlugin:GetInstance('1.2'):new({
	name          = SkillsPlusFuLocals.NAME,
	description   = SkillsPlusFuLocals.DESCRIPTION,
	version       = '0.6.'..string.sub('$Revision: 0 $', 12, -3),
	releaseDate   = string.sub('$Date: 2006-08-19 07:00 +0200 (Sat, 19 August 2006) $', 8, 17),
	aceCompatible = 103,
--	fuCompatible  = 102,
	author        = 'Jayhawk',
	email         = 'jaydehawk@gmail.com',
	category      = 'others',
	db            = AceDatabase:new('SkillsPlusFuDB'),
	defaults      = {
                      showSkillLabel = true,
                      showBooleanSkills = false,
                      showPlayerNames = true,
                      showNotification = false,
                      showOtherToonSkills = false,
                      cooldownSave = {},
                      skillsSave = {},
                    },
	charDefaults  = { hidden = {} },
--	cmd           = AceChatCmd:new(SkillsPlusFuLocals.COMMANDS, SkillsPlusFuLocals.CMD_OPTIONS),
	loc           = SkillsPlusFuLocals,
	hasIcon       = 'Interface\\Icons\\Trade_Engineering',
	clickableTooltip = true,
})

-- menu toggles

function SkillsPlusFu:IsShowingSkillLabel()
	return self.data.showSkillLabel
end

function SkillsPlusFu:ToggleShowingSkillLabel()
	self.data.showSkillLabel = not self.data.showSkillLabel
	self:UpdateTooltip()
	return self.data.showSkillLabel
end

function SkillsPlusFu:IsShowingOtherToonSkills()
	return self.data.showOtherToonSkills
end

function SkillsPlusFu:ToggleOtherToonSkills()
	self.data.showOtherToonSkills = not self.data.showOtherToonSkills
    self:UpdateData()
	self:UpdateTooltip()
	return self.data.showOtherToonSkills
end

function SkillsPlusFu:IsShowingBooleanSkills()
	return self.data.showBooleanSkills
end

function SkillsPlusFu:ToggleShowingBooleanSkills()
	self.data.showBooleanSkills = not self.data.showBooleanSkills
	self:UpdateTooltip()
	return self.data.showBooleanSkills
end

function SkillsPlusFu:IsShowingPlayerNames()
	return self.data.showPlayerNames
end

function SkillsPlusFu:ToggleShowingPlayerNames()
	self.data.showPlayerNames = not self.data.showPlayerNames
	self:UpdateTooltip()
	return self.data.showPlayerNames
end

function SkillsPlusFu:IsShowNotification()
	return self.data.showNotification
end

function SkillsPlusFu:ToggleShowNotification()
	self.data.showNotification = not self.data.showNotification
	self:UpdateTooltip()
	return self.data.showNotification
end

-- update

function SkillsPlusFu:OnUpdate(difference)
	if( self:IsShowNotification() ) then
		for k, v in self.data.cooldownSave do
			for itemName, itemTable in v do
				local remaining = ((itemTable.Cooldown + itemTable.LastCheck) - time())
				if (remaining <= self.loc.COOLDOWN_NOTIFYTIME) then
					if (self.data.cooldownSave[k][itemName].IsReady ~= 1) then
        				local _, _, realm, player = string.find(k, '^(.+)\|(.+)$')
        				if (remaining <= 0) then
							DEFAULT_CHAT_FRAME:AddMessage(format(self.loc.COOLDOWN_IS_READY, itemName, realm, player))
						else
							DEFAULT_CHAT_FRAME:AddMessage(format(self.loc.COOLDOWN_WILL_BE_READY, itemName, realm, player, floor(remaining+0.9)))
						end
						PlaySound('AuctionWindowOpen')
						self.data.cooldownSave[k][itemName].IsReady = 1
						self:Update()
					end
				end
			end
		end
	end
end

-- init/exit functions

function SkillsPlusFu:Initialize()
    -- load icons
	self.ICON_ALCHEMY = 'Interface\\Icons\\Trade_Alchemy'
	self.ICON_BLACKSMITHING = 'Interface\\Icons\\Trade_Blacksmithing'
	self.ICON_COOKING = 'Interface\\Icons\\INV_Misc_Food_15'
	self.ICON_DISENCHANTING = 'Interface\\Icons\\Spell_Holy_RemoveCurse'
	self.ICON_ENCHANTING = 'Interface\\Icons\\Trade_Engraving'
	self.ICON_ENGINEERING = 'Interface\\Icons\\Trade_Engineering'
	self.ICON_FIRSTAID = 'Interface\\Icons\\Spell_Holy_SealOfSacrifice'
	self.ICON_FISHING = 'Interface\\Icons\\Trade_Fishing'
	self.ICON_LEATHERWORKING = 'Interface\\Icons\\Trade_Leatherworking'
	self.ICON_LOCKPICKING = 'Interface\\Icons\\INV_Misc_Key_03'
	self.ICON_POISONS = 'Interface\\Icons\\Trade_BrewPoison'
	self.ICON_SMELTING = 'Interface\\Icons\\Trade_Mining'
	self.ICON_TAILORING = 'Interface\\Icons\\Trade_Tailoring'

	self.skillList = {}
end

function SkillsPlusFu:Enable()
    -- skills management
	self:RegisterEvent('SKILL_LINES_CHANGED','Update') 
	self:RegisterEvent('PLAYER_LEVEL_UP','Update')
	
    -- cooldown management
   	metrognome:Register(self.name, self.OnUpdate, self.loc.COOLDOWN_TIMER_FREQUENCY, self)
	metrognome:Start(self.name)
    self:RegisterEvent('TRADE_SKILL_UPDATE')
    self:RegisterEvent('CHAT_MSG_SPELL_TRADESKILLS')
    self:RegisterEvent('CHAT_MSG_LOOT')
    -- variables
    toonSaveKey = GetCVar('realmName')..'|'..UnitName('player')
 end

function SkillsPlusFu:Disable()
	metrognome:Unregister(self.name)
end

-- cooldown management

function SkillsPlusFu:CooldownRemaining(timeStamp)
    local timeRemaining = {}
          timeRemaining.d = 0
          timeRemaining.h = 0
          timeRemaining.m = 0
          timeRemaining.s = 0

    -- 86,400 seconds equals one day
    if (timeStamp >= 86400) then
        timeRemaining.d = floor(timeStamp / 86400)
        timeStamp = (timeStamp - (timeRemaining.d * 86400))
    end
    -- 3,600 seconds equals one hour
    if (timeStamp >= 3600) then
        timeRemaining.h = floor(timeStamp / 3600)
        timeStamp = (timeStamp - (timeRemaining.h * 3600))
    end
    -- 60 seconds equals one minute
    if ( timeStamp >= 60 ) then
        timeRemaining.m = floor(timeStamp / 60)
        timeStamp = (timeStamp - (timeRemaining.m * 60))
    end
    -- add remaining seconds
    timeRemaining.s = timeStamp
    
    return timeRemaining
end

function SkillsPlusFu:TRADE_SKILL_UPDATE()
	local numSkills = GetNumTradeSkills()
	for i=1, numSkills do
		local itemName = GetTradeSkillInfo(i)
		local cooldown = GetTradeSkillCooldown(i)

		-- check for transmute only, all transmutes share the same cooldown
		if (string.find(itemName, self.loc.COOLDOWN_TRANSMUTE_MATCH)) then
			itemName = self.loc.COOLDOWN_TRANSMUTES
		end
		if (itemName == self.loc.COOLDOWN_TRANSMUTES or
            itemName == self.loc.COOLDOWN_MOONCLOTH) then
			if (cooldown == nil) then
				cooldown = 0
			end
		    if (self.data.cooldownSave[toonSaveKey] == nil) then
    		    self.data.cooldownSave[toonSaveKey] = {}
	        end
            if (self.data.cooldownSave[toonSaveKey][itemName] == nil) then
			    self.data.cooldownSave[toonSaveKey][itemName] = {}
	        end
            self.data.cooldownSave[toonSaveKey][itemName].Cooldown = cooldown
    	    self.data.cooldownSave[toonSaveKey][itemName].LastCheck = time()
    	    self.data.cooldownSave[toonSaveKey][itemName].IsReady = 0
  	    end
	end
	self:Update()
end

function SkillsPlusFu:CHAT_MSG_SPELL_TRADESKILLS()
	local _, _, created
    created = string.find(arg1, self.loc.COOLDOWN_CREATE_ITEM);
    if (created and string.find(arg1, self.loc.COOLDOWN_SNOWBALL)) then
        -- we found a snowball
      	local itemName = self.loc.COOLDOWN_SNOWMASTER
        if (self.data.cooldownSave[toonSaveKey] == nil) then
       	    self.data.cooldownSave[toonSaveKey] = {}
        end
        if (cooldownSave[toonSaveKey][itemName] == nil) then
    	    cooldownSave[toonSaveKey][itemName] = {}
        end
        self.data.cooldownSave[toonSaveKey][itemName].Cooldown = 86400
        self.data.cooldownSave[toonSaveKey][itemName].LastCheck = time()
        self.data.cooldownSave[toonSaveKey][itemName].IsReady = 0
    elseif (created and string.find(arg1, self.loc.COOLDOWN_REFINED_SALT)) then
        -- we found refined salt
		local itemName = self.loc.COOLDOWN_SALT_SHAKER
        if (self.data.cooldownSave[toonSaveKey] == nil) then
         	self.data.cooldownSave[toonSaveKey] = {}
        end
        if (self.data.cooldownSave[toonSaveKey][itemName] == nil) then
        	self.data.cooldownSave[toonSaveKey][itemName] = {}
        end
        self.data.cooldownSave[toonSaveKey][itemName].Cooldown = 259200
        self.data.cooldownSave[toonSaveKey][itemName].LastCheck = time()
        self.data.cooldownSave[toonSaveKey][itemName].IsReady = 0
    end
    self:Update()
end

function SkillsPlusFu:CHAT_MSG_LOOT()
	if (string.find(arg1, self.loc.COOLDOWN_ELUNE_STONE)) then
     	local itemName = self.loc.COOLDOWN_ELUNES_LANTERN
      	if (self.data.cooldownSave[toonSaveKey] == nil) then
          	self.data.cooldownSave[toonSaveKey] = {}
        end
        if (self.data.cooldownSave[toonSaveKey][itemName] == nil) then
        	self.data.cooldownSave[toonSaveKey][itemName] = {}
        end
        self.data.cooldownSave[toonSaveKey][itemName].Cooldown = 86400
        self.data.cooldownSave[toonSaveKey][itemName].LastCheck = time()
        self.data.cooldownSave[toonSaveKey][itemName].IsReady = 0
    end
    self:Update()
end

function SkillsPlusFu:ClearCooldownData()
	self.data.cooldownSave = {}
	self:Update()
end

-- skills management

function SkillsPlusFu:AddProfessionMenu(skillName)
    if (skillName == self.loc.SKILL_ALCHEMY) then
    	dewdrop:AddLine(
    	    'text', self.loc.SKILL_ALCHEMY,
	   	    'func', function() CastSpellByName(self.loc.SKILL_ALCHEMY)
                               self:UpdateText(self.loc.SKILL_ALCHEMY,self.ICON_ALCHEMY)
                    end,
            'arg1', self
        )
    end
    if (skillName == self.loc.SKILL_BLACKSMITHING) then
    	dewdrop:AddLine(
    		'text', self.loc.SKILL_BLACKSMITHING,
	    	'func', function() CastSpellByName(self.loc.SKILL_BLACKSMITHING)
                               self:UpdateText(self.loc.SKILL_BLACKSMITHING,self.ICON_BLACKSMITHING)
             end,
   			'arg1', self
        )
    end
    if (skillName == self.loc.SKILL_COOKING) then
    	dewdrop:AddLine(
    		'text', self.loc.SKILL_COOKING,
	    	'func', function() CastSpellByName(self.loc.SKILL_COOKING)
                               self:UpdateText(self.loc.SKILL_COOKING,self.ICON_COOKING)
            end,
    			'arg1', self
        )
    end
    if (skillName == self.loc.SKILL_ENCHANTING) then
    	dewdrop:AddLine(
    		'text', self.loc.SKILL_DISENCHANTING,
	    	'func', function() CastSpellByName(self.loc.SKILL_DISENCHANTING)
                               self:UpdateText(self.loc.SKILL_DISENCHANTING,self.ICON_DISENCHANTING)
            end,
    			'arg1', self
        )
    		dewdrop:AddLine(
    		'text', self.loc.SKILL_ENCHANTING,
	    	'func', function() CastSpellByName(self.loc.SKILL_ENCHANTING)
                               self:UpdateText(self.loc.SKILL_ENCHANTING,self.ICON_ENCHANTING)
            end,
    			'arg1', self
        )
    end
    if (skillName == self.loc.SKILL_ENGINEERING) then
    	dewdrop:AddLine(
    		'text', self.loc.SKILL_ENGINEERING,
	    	'func', function() CastSpellByName(self.loc.SKILL_ENGINEERING)
                               self:UpdateText(self.loc.SKILL_ENGINEERING,self.ICON_ENGINEERING)
            end,
    			'arg1', self
        )
    end
    if (skillName == self.loc.SKILL_FIRSTAID) then
    	dewdrop:AddLine(
    		'text', self.loc.SKILL_FIRSTAID,
	    	'func', function() CastSpellByName(self.loc.SKILL_FIRSTAID)
                               self:UpdateText(self.loc.SKILL_FIRSTAID,self.ICON_FIRSTAID)
            end,
    			'arg1', self
        )
    end
    if (skillName == self.loc.SKILL_FISHING) then
    	dewdrop:AddLine(
    		'text', self.loc.SKILL_FISHING,
	    	'func', function() CastSpellByName(self.loc.SKILL_FISHING)
                               self:UpdateText(self.loc.SKILL_FISHING,self.ICON_FISHING)
             end,
   			'arg1', self
        )
    end
    if (skillName == self.loc.SKILL_LEATHERWORKING) then
    	dewdrop:AddLine(
    		'text', self.loc.SKILL_LEATHERWORKING,
	    	'func', function() CastSpellByName(self.loc.SKILL_LEATHERWORKING)
                               self:UpdateText(self.loc.SKILL_LEATHERWORKING,self.ICON_LEATHERWORKING)
             end,
   			'arg1', self
        )
    end
    if (skillName == self.loc.SKILL_LOCKPICKING) then
    	dewdrop:AddLine(
    		'text', self.loc.SKILL_LOCKPICKING,
	    	'func', function() CastSpellByName(self.loc.SKILL_PICKLOCK)
                               self:UpdateText(self.loc.SKILL_PICKLOCK,self.ICON_LOCKPICKING)
             end,
   	    	'arg1', self
        )
    end
    if (skillName == self.loc.SKILL_MINING) then
    	dewdrop:AddLine(
    		'text', self.loc.SKILL_SMELTING,
	    	'func', function() CastSpellByName(self.loc.SKILL_SMELTING)
                               self:UpdateText(self.loc.SKILL_SMELTING,self.ICON_SMELTING)
            end,
   			'arg1', self
        )
    end
    if (skillName == self.loc.SKILL_POISONS) then
    	dewdrop:AddLine(
    		'text', self.loc.SKILL_POISONS,
	    	'func', function() CastSpellByName(self.loc.SKILL_POISONS)
                               self:UpdateText(self.loc.SKILL_POISONS,self.ICON_POISONS)
            end,
    		'arg1', self
        )
    end
    if (skillName == self.loc.SKILL_TAILORING) then
    	dewdrop:AddLine(
    		'text', self.loc.SKILL_TAILORING,
	    	'func', function() CastSpellByName(self.loc.SKILL_TAILORING)
                               self:UpdateText(self.loc.SKILL_TAILORING,self.ICON_TAILORING)
            end,
    		'arg1', self
        )
    end
end

function SkillsPlusFu:SaveProfession(skillName,skillRank,skillMaxRank,skillModifier)
    if (skillName == self.loc.SKILL_ALCHEMY) or
       (skillName == self.loc.SKILL_BLACKSMITHING) or
       (skillName == self.loc.SKILL_COOKING) or
       (skillName == self.loc.SKILL_ENCHANTING) or
       (skillName == self.loc.SKILL_ENGINEERING) or
       (skillName == self.loc.SKILL_FIRSTAID) or
       (skillName == self.loc.SKILL_LEATHERWORKING) or
       (skillName == self.loc.SKILL_TAILORING) then
      	if (self.data.skillsSave[toonSaveKey] == nil) then
          	self.data.skillsSave[toonSaveKey] = {}
        end
        if (self.data.skillsSave[toonSaveKey][skillName] == nil) then
        	self.data.skillsSave[toonSaveKey][skillName] = {}
        end
        self.data.skillsSave[toonSaveKey][skillName].Rank = skillRank
        self.data.skillsSave[toonSaveKey][skillName].MaxRank = skillMaxRank
        self.data.skillsSave[toonSaveKey][skillName].Modifier = skillModifier

    end
end

-- general

function SkillsPlusFu:MenuSettings(level, value)
	if level == 1 then
        local cooldownFound = false
    	for _,category in self.skillList do
            -- items are added with other toon skills following cooldown items
            -- just stop adding skill menus when cooldown entry is found to stop
            -- other toon skills showing up in the menu
            if not cooldownFound then
  	    	    if category.nonBooleanSkills > 0 then
    		        for _,skill in category.skills do 
                        self:AddProfessionMenu(skill.name)
                    end
                end
                cooldownFound = category.category == self.loc.COOLDOWN_CATEGORY                
            end
        end
        
       	if (GetNumSkillLines() > 0) then dewdrop:AddLine() end
       	-- add regular menu options
		dewdrop:AddLine(
			'text', self.loc.MENU_SHOW_SKILL_LABEL,       -- toggles skill name in fubar menu
    		'func', 'ToggleShowingSkillLabel',
 			'arg1', self,
			'checked', self:IsShowingSkillLabel()
		)
		dewdrop:AddLine(
			'text', self.loc.MENU_SHOW_BOOLEAN_SKILLS,    -- toggles boolean skill visibility
			'func', 'ToggleShowingBooleanSkills',
			'arg1', self,
			'checked', self:IsShowingBooleanSkills()
		)
		dewdrop:AddLine(
			'text', self.loc.MENU_SHOW_OTHER_TOON_SKILLS, -- toggles other player skills
			'func', 'ToggleOtherToonSkills',
			'arg1', self,
			'checked', self:IsShowingOtherToonSkills()
		)
		dewdrop:AddLine()                                 -- separator
		dewdrop:AddLine(
			'text', self.loc.MENU_SHOW_TOON_NAMES,        -- toggles player names in cooldown items
			'func', 'ToggleShowingPlayerNames',
			'arg1', self,
			'checked', self:IsShowingPlayerNames()
		)
		dewdrop:AddLine(
			'text', self.loc.MENU_SHOW_NOTIFICATION,      -- toggles cooldown notification
			'func', 'ToggleShowNotification',
			'arg1', self,
			'checked', self:IsShowNotification ()
		)
		dewdrop:AddLine(
			'text', self.loc.MENU_CLEAR_COOLDOWN_DATA,    -- clears saved cooldown data
			'func', 'ClearCooldownData',
			'arg1', self
		)
	end
end

function SkillsPlusFu:UpdateData()
	local skillIndex = 0
	local skillList = {}
	local headerIndex = 0
	
	local numSkills = GetNumSkillLines()
	
	for skillIndex=1, numSkills do
		local skillName, isHeader, isExpanded, skillRank, numTempPoints, skillModifier, skillMaxRank,
              isAbandonable, stepCost, rankCost, minLevel, skillCostType,
              skillDesc = GetSkillLineInfo(skillIndex)
		
		if isHeader then
			headerIndex = headerIndex + 1
			table.insert(skillList, {category=skillName, skills={}, nonBooleanSkills = 0})
		else
			if skillMaxRank > 1 then
              skillList[headerIndex].nonBooleanSkills = skillList[headerIndex].nonBooleanSkills + 1
            end
			table.insert(skillList[headerIndex].skills, {name = skillName,  rank = skillRank,
                         maxrank = skillMaxRank, rankbonus = skillModifier})
            self:SaveProfession(skillName,skillRank,skillMaxRank,skillModifier)
 		end
	end
	
	-- add cooldown header and items
	local toonName = ''
	headerIndex = headerIndex + 1
	table.insert(skillList, {category=self.loc.COOLDOWN_CATEGORY, skills={}, nonBooleanSkills = 0})
    for k, v in self.data.cooldownSave do
        if self:IsShowingPlayerNames() then
          toonName = string.sub(k,string.find(k,'|')+1)..': '
        end
        for itemName, itemTable in v do
            skillList[headerIndex].nonBooleanSkills = skillList[headerIndex].nonBooleanSkills + 1
            table.insert(skillList[headerIndex].skills, {name = toonName..itemName,
                         rank = itemTable.Cooldown,
                         maxrank = itemTable.LastCheck,
                         rankbonus = itemTable.IsReady}
                        )
        end
    end
    
    -- add other toon skills
    if self.data.showOtherToonSkills then
        for k, v in self.data.skillsSave do
            toonName = string.sub(k,string.find(k,'|')+1)
            local realmName = string.sub(k,1,string.find(k,'|')-1)
            if (toonName ~= UnitName('player')) and
               (realmName == GetCVar('realmName')) 
                then
  	            headerIndex = headerIndex + 1
	            table.insert(skillList, {category=toonName, skills={}, nonBooleanSkills = 0})
	            for skillName, skillTable in v do
                    skillList[headerIndex].nonBooleanSkills = skillList[headerIndex].nonBooleanSkills + 1
    			    table.insert(skillList[headerIndex].skills, {name = skillName,
                                 rank = skillTable.Rank,
                                 maxrank = skillTable.MaxRank,
                                 rankbonus = skillTable.Modifier}
                                )
    	        end
	        end
        end
    end
    
	self.skillList = skillList
end

function SkillsPlusFu:UpdateText(newProfession,newIcon)
    if newProfession ~= nil then chosenProfession = newProfession end
    if newIcon ~= nil then self:SetIcon(newIcon) end

    -- add cooldown information
	local cooldownInfo = ''
    local totalItems = 0
    local readyItems = 0
    
    -- loop and add items and ready items
    for k, v in self.data.cooldownSave do
  	    for itemName, itemTable in v do
	        local remaining = ((itemTable.Cooldown + itemTable.LastCheck) - time())
    	        totalItems = totalItems + 1
	        if (remaining <= 0) then
  	  	        readyItems = readyItems + 1
    	    end
  	    end
    end
    
    -- set label text count colours
    local colorCode = self.loc.COOLDOWN_COLOR_READY
    if ( readyItems == 0 ) then
  	    colorCode = self.loc.COOLDOWN_COLOR_NOTREADY
    end
    cooldownInfo = format(colorCode..self.loc.COOLDOWN_FORMAT..FONT_COLOR_CODE_CLOSE, readyItems, totalItems)
    
    -- add skill label is toggle is true
    if self:IsShowingSkillLabel() then
        self.labelName = chosenProfession..' '..cooldownInfo
	else
	    self.labelName = cooldownInfo
    end
    
    -- set the actual label
	self:SetText(self.labelName)
	
	dewdrop:Close()

end

function SkillsPlusFu:ToggleCategory(id, button)
	if self.charData.hidden[id] then
		self.charData.hidden[id] = false
	else
		self.charData.hidden[id] = true
	end
	-- refresh in place
	self:UpdateTooltip()
end

function SkillsPlusFu:UpdateTooltip()
	tablet:SetHint(self.loc.TOOLTIP_HINT)
	-- skills
	for _,category in self.skillList do
		if category.nonBooleanSkills > 0 or self:IsShowingBooleanSkills() then
			local tooltipLine = tablet:AddCategory('id', category.category, 'columns', 2,
				    		       'text', category.category,
							       'func', 'ToggleCategory', 'arg1', self, 'arg2', category.category,
							       'child_textR', 1, 'child_textG', 1, 'child_textB', 0,
							       'showWithoutChildren', true,
							       'checked', true, 'hasCheck', true, 'checkIcon',
                                   self.charData.hidden[category.category] and 'Interface\\Buttons\\UI-PlusButton-Up' or 'Interface\\Buttons\\UI-MinusButton-Up'
			)
			if not self.charData.hidden[category.category] then
				for _,skill in category.skills do
                    if category.category ~= self.loc.COOLDOWN_CATEGORY then
                        -- is either current toon skill or other toon skill
					    if skill.maxrank > 1 then
					    	local rank = skill.rank
						    if skill.rankbonus > 0  then
							    rank = rank..'(+'..skill.rankbonus..')'
						    end
						    rank = rank..'/'..skill.maxrank
						    local r,g,b = FuBarUtils.GetThresholdColor((skill.rank+(skill.rankbonus or 0)) / skill.maxrank)
						    tooltipLine:AddLine('text', skill.name, 'text2', rank,
							                    'text2R', r, 'text2G', g, 'text2B', b)
					    elseif self:IsShowingBooleanSkills() then
						    tooltipLine:AddLine('text', skill.name)
                        end
                    else  -- is cooldown item
                        -- rank contains itemTable.Cooldown, max rank contains itemTable.LastCheck
    	       	       	local timeRemaining = ((skill.rank + skill.maxrank) - time())
    	       	       	local timeRemainingText = ''

    	       	       	if (timeRemaining <= 0) then
            	    	    timeRemainingText = self.loc.COOLDOWN_COLOR_READY..self.loc.COOLDOWN_READY
         	       	    else
      	                    local timeTable = self:CooldownRemaining(timeRemaining)
                            local timeString = string.format('%dD %02d:%02d', timeTable.d, timeTable.h, timeTable.m)
                            if ((timeTable.d == 0) and (timeTable.h == 0)) then
    	                       timeRemainingText = self.loc.COOLDOWN_COLOR_ALMOSTREADY..timeString
                            else
    	                        timeRemainingText = self.loc.COOLDOWN_COLOR_NOTREADY..timeString
                            end
                        end
					    tooltipLine:AddLine('text', skill.name, 'text2', timeRemainingText)
					end
				end
			end
		end
	end
end

function SkillsPlusFu:OnClick()
    if self.chosenProfession == self.loc.FUBAR_LABEL then
        ToggleCharacter('SkillFrame')
    else
    	CastSpellByName(chosenProfession)
    end

end

SkillsPlusFu:RegisterForLoad()
