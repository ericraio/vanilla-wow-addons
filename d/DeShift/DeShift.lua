--DeShift AddON by Leleth--

-- Basically tries to react to some errors
-- For example: Trying to Starfire, while sitting around in Cat-Form, having no target selected will
-- Stand you up on first press
-- Shifting to humanoid form on second
-- Selecting the nearest target on third
-- Cast Starfire

--Trying to Bash while in CatForm will
--Bring you to Humanoid Form
--Bring you to Bear Form
--Bash

local current_argument = "";

function DeShift_OnLoad()
	DEFAULT_CHAT_FRAME:AddMessage("You gain DeShift AddOn by Leleth")
	_,lclass = UnitClass("player")
	if (lclass == "DRUID") then
		isDruid = true
	end
	this:RegisterEvent("UI_ERROR_MESSAGE")
end

function DeShift_OnEvent()
	DeShift_Loop()
end

function DeShift_Loop() 
	local i = 1;
	while(getglobal("arg"..i) ~= nil) do
		current_argument = getglobal("arg"..i);
		if _CheckFor( Wantstandup) then 
			SitOrStand()
			return
		end
		if _CheckFor( Wanttarget) then 
			TargetNearestEnemy()	
			return 
		end				
		if _CheckFor( Wantspeak) then 
			if isDruid then
				Shapeshift(humanoid_form)	
				return
			end
		end
		if _CheckFor( WantHumanoidSkill) then 
			if isDruid then
				Shapeshift(humanoid_form)	
				return
			end
		end	
		if _CheckFor( WantHumanoidSkillTwo)	then 
			if isDruid then
				Shapeshift(humanoid_form)	
				return
			end
		end	
		if _CheckFor( WantBearSkillOne) then 
			if isDruid then
				Shapeshift(bear_form)	
				return
			end
		end
		if _CheckFor( WantBearSkillTwo) then 
			if isDruid then
				Shapeshift(bear_form)	
				return
			end
		end
		if _CheckFor( WantCatSkillOne) then 
			if isDruid then
				Shapeshift(cat_form)	
				return
			end
		end
		if _CheckFor( WantCatSkillTwo) then 
			if isDruid then
				Shapeshift(cat_form)	
				return
			end
		end
        i = i+1;
	end
end


function _CheckFor(TheString)
	if (TheString ~= nil) then 
		if ((string.find(current_argument, TheString) ~= nil)) then 
			return true
		else 
			return false 
		end
	else 
		DEFAULT_CHAT_FRAME:AddMessage("DeShift Error: Compare String is Nil value. Check the localisation.lua for errors!") 
		return false;
	end
end 