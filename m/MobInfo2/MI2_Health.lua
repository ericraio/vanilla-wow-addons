--[[

	Name:		MobHealth2
	Author:		Wyv	& Skeeve
	Description:	Displays health	value for mobs.
	Original version by	Telo.
]]


-- remember previous font type and font size
local lOldFontId = 0
local lOldFontSize = 0


--------------------------------------------------------------------------------------------------
-- external	functions for macros / scripts
--------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------
-- MobHealth_GetTargetCurHP()  
--
-- Return current health points	value for the current target as	an integer
-- value. Return nil if	there is no	current	target.
--
-- Example:
--	 local targetCurrentHealth = MobHealth_GetTargetCurHP()
--	 if	 targetCurrentHealth  then
--		.......
--	 end
-----------------------------------------------------------------------------
function MobHealth_GetTargetCurHP()
	if MI2_Target.curHealth then
		return MI2_Target.curHealth
	else
		return nil
	end
end	 --	of MobHealth_GetTargetCurHP()


-----------------------------------------------------------------------------
-- MobHealth_GetTargetMaxHP()  
--
-- Return maximum health points	value for the current target as	an integer
-- value. Return nil if	there is no	current	target.
--
-- Example:
--	 local targetMaxHealth = MobHealth_GetTargetMaxHP()
--	 if	 targetMaxHealth  then
--		.......
--	 end
-----------------------------------------------------------------------------
function MobHealth_GetTargetMaxHP()
	-- for compatibility to MobHealth-2: only return maxHP if there is a curHP
	if MI2_Target.curHealth then
		return MI2_Target.maxHealth
	else
		return nil
	end
end	 --	of MobHealth_GetTargetMaxHP()


-----------------------------------------------------------------------------
-- MobHealth_PPP( index	)  
--
-- Return the Points-Per-Percent (PPP) value for a Mob identified by its index.
-- The index is	the	concatination of the Mob name and the Mob level	(see
-- example below). 0 is	returned if	the	PPP	value is not available for
-- the given index.	The	example	also shows how to calculate	the	actual
-- health points from the health percentage	and	the	PPP	value
--
-- Example:
--	  local	name  =	UnitName("target")
--	  local	level =	UnitLevel("target")
--	  local	index =	name..":"..level
--	  local	ppp	= MobHealth_PPP( index )
--	  local	healthPercent =	UnitHealth("target")
--	  local	curHealth =	math.floor(	healthPercent *	ppp	+ 0.5)
--	  local	maxHealth =	math.floor(	100	* ppp +	0.5)
-----------------------------------------------------------------------------
function MobHealth_PPP(	index )
	if	index and MobHealthDB[index]  then
		local s, e, pts, pct = string.find(MobHealthDB[index], "^(%d+)/(%d+)$")
		if ( pts and pct ) then
			pts	= pts +	0
			pct	= pct +	0
			if ( pct ~=	0 )	then
				return pts / pct
			end
		end
	end
	return 0
end


-----------------------------------------------------------------------------
-- MI2_GetHealthData()
--
-- get health data for a given mob from the given health database
-- (ie. either mob health database or player health database)
-----------------------------------------------------------------------------
function MI2_GetHealthData( database, index )
	local s, e, pts, pct
	if database[index] then
		s, e, pts, pct = string.find(database[index], "^(%d+)/(%d+)$")
	end
	return ((pts or 0) + 0), ((pct or 0) + 0)
end -- MI2_GetHealthData()


-----------------------------------------------------------------------------
-- MobHealth_Set()
--
-- store pct and pts values for a given mob index in the given database
-----------------------------------------------------------------------------
function MobHealth_Set( database, index, pts, pct)
	if pts or pct then
		database[index] = (pts or 0).."/"..(pct or 0)
	else
		database[index] = nil
	end
end  -- MobHealth_Set()


-----------------------------------------------------------------------------
-- MI2_CalculateHealth()
--
-- (re)calculate current health and maximum for current target
-----------------------------------------------------------------------------
function MI2_CalculateHealth( updateMaxHealth )
	if MI2_Target.unitHealth > 0 then
		local curHealthMax = UnitHealthMax("target")  -- have to check because BeastLore changes maxhealth from percent to value
		if curHealthMax ~= 100 then
			if MI2_Target.healthDB then
				MobHealth_Set( MI2_Target.healthDB, MI2_Target.index, curHealthMax * 25, 2500 )
				MI2_Target = { totalPercent = 0, maxHealth=curHealthMax }
				MI2_Target.unitHealth = UnitHealth("target")
			end
			MI2_Target.curHealth = MI2_Target.unitHealth
			MI2_Target.maxHealth = curHealthMax
			MI2_Target.unitHealth = math.floor(100.0 * MI2_Target.unitHealth / MI2_Target.maxHealth + 0.5)
			MI2_Target.showHealth = 1
		elseif MI2_Target.totalPercent > 0 then
			local ppp = MI2_Target.totalDamage / MI2_Target.totalPercent
			MI2_Target.curHealth = math.floor(MI2_Target.unitHealth * ppp + 0.5)
			if updateMaxHealth then
				MI2_Target.maxHealth = math.floor( (100 * ppp) + 0.5 )
			end
			MI2_Target.showHealth = 1
		end
	end
end -- MI2_CalculateHealth()


-----------------------------------------------------------------------------
-- MobHealth_Display()
--
-- display the values and percentage for health	/ mana in target frame
-----------------------------------------------------------------------------
function MobHealth_Display( )
	local healthText, manaText

	-- create health and percent text if showing is enabled
	if MI2_Target.showHealth then
		if  MobInfoConfig.TargetHealth == 1 then
			healthText = string.format("%d/%d", MI2_Target.curHealth, MI2_Target.maxHealth )
		end
		if	MobInfoConfig.HealthPercent	== 1 then
			if healthText then
				healthText = healthText..string.format(" (%d%%)", MI2_Target.unitHealth )
			else
				healthText = string.format("%d%%", MI2_Target.unitHealth )
			end
		end
	end

	-- create mana text based on mana show flags
	local maxmana =	UnitManaMax("target")
	if maxmana > 0 then
		local mana = UnitMana("target")
		if MobInfoConfig.TargetMana == 1 then
			manaText = string.format("%d/%d", mana, maxmana )
		end
		if MobInfoConfig.ManaPercent == 1 then
			if manaText then
				manaText = manaText..string.format(" (%d%%)", math.floor(100.0 * mana / maxmana))
			else
				manaText = string.format("%d%%", math.floor(100.0 * mana / maxmana))
			end
		end
	end

	MI2_MobHealthText:SetText( healthText or "" )
	MI2_MobManaText:SetText( manaText or "" )
end	 --	MobHealth_Display()


-----------------------------------------------------------------------------
-- MI2_MobHealth_SetFont()
--
-- set new font	for	display	of health /	mana in	target frame
-----------------------------------------------------------------------------
local function MI2_MobHealth_SetFont( fontId, fontSize )
	local fontName

	if fontId ~= lOldFontId or fontSize ~= lOldFontSize then
		lOldFontId = fontId
		lOldFontSize = fontSize

		-- select font name	to use	
		if	fontId == 1	 then
			fontName = "Fonts\\ARIALN.TTF"  -- NumberFontNormal
		elseif	fontId == 2	 then
			fontName = "Fonts\\FRIZQT__.TTF"	 --	GameFontNormal
		else
			fontName = "Fonts\\MORPHEUS.TTF"	 --	ItemTextFontNormal
		end

		-- set font	for	health and mana	text
		MI2_MobHealthText:SetFont( fontName, fontSize )
		MI2_MobManaText:SetFont( fontName, fontSize )
	end
  
end	 --	of MI2_MobHealth_SetFont()


-----------------------------------------------------------------------------
-- MI2_MobHealth_SetPos()
--
-- set position	and	font for mob health/mana texts
-----------------------------------------------------------------------------
function MI2_MobHealth_SetPos( )
	local font

	-- set poition for health	and	mana text
	MI2_MobHealthText:SetPoint( "TOP", "TargetFrameHealthBar", "BOTTOM", MobInfoConfig.HealthPosX, MobInfoConfig.HealthPosY )
	MI2_MobManaText:SetPoint( "TOP", "TargetFrameManaBar", "BOTTOM", MobInfoConfig.ManaPosX, MobInfoConfig.ManaPosY )

	-- update	font ID	and	font size
	MI2_MobHealth_SetFont( MobInfoConfig.TargetFont, MobInfoConfig.TargetFontSize	)

	-- redisplay health /	mana values
	MobHealth_Display()
end	 --	of MI2_MobHealth_SetPos()


-----------------------------------------------------------------------------
-- MI2_MobHealth_Reset()
-----------------------------------------------------------------------------
function MI2_MobHealth_Reset()
	MI2_MobHealth_ClearTargetData()
	MobHealthDB	= {}
	MobHealthPlayerDB =	{}
end


-----------------------------------------------------------------------------
-- MI2_SaveTargetHealthData()
--
-- Save health data for current target in health database
-----------------------------------------------------------------------------
function MI2_SaveTargetHealthData()
	if MI2_Target.index and MI2_Target.totalPercent > 0 and MI2_Target.totalPercent < 10000 then
		MobHealth_Set( MI2_Target.healthDB, MI2_Target.index, MI2_Target.totalDamage, MI2_Target.totalPercent )
	end
end -- MI2_SaveTargetHealthData()


-----------------------------------------------------------------------------
-- MI2_MobHealth_ClearTargetData()
--
-- Clear mob health data for current target
-----------------------------------------------------------------------------
function MI2_MobHealth_ClearTargetData()
	if MI2_Target.index then
		MI2_Target.healthDB[MI2_Target.index] = nil
		MI2_Target = {}
		MobHealth_Display()
	end
end  -- MI2_MobHealth_ClearTargetData()

