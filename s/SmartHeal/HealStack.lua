SmartHeal.default['healstack']=1
SmartHeal.StackValue=0
SmartHeal.HealStack={}
SmartHeal.AddOnMessagePrefix="SMH"

function SmartHeal:HealStackOnLoad()
	this:RegisterEvent("VARIABLES_LOADED")
end

function SmartHeal:HealStackOnEvent(event)

	if (event=="VARIABLES_LOADED") then

		this:RegisterEvent("SPELLCAST_START")
		this:RegisterEvent("SPELLCAST_STOP")
		this:RegisterEvent("SPELLCAST_FAILED")
		this:RegisterEvent("SPELLCAST_INTERRUPTED")
		this:RegisterEvent("CHAT_MSG_ADDON")
	
	elseif(event=="SPELLCAST_START") then

		SmartHeal.CastedSpell=arg1
		SmartHeal.StackUnitId=SmartHeal.CacheUnitId
		SmartHeal.StackValue=SmartHeal.HealedValue or 0
		SmartHeal:HealStack_OnCast(1)
		
	elseif(event=="SPELLCAST_STOP" or event=="SPELLCAST_INTERRUPTED") then
		
		SmartHeal:HealStack_OnCast(-1)
		SmartHeal.CastedSpell=nil
		SmartHeal.StackUnitId=nil
		SmartHeal.StackValue=0
	
	elseif (event=="CHAT_MSG_ADDON" and arg1==SmartHeal.AddOnMessagePrefix) then
		
		SmartHeal:HealStack_ParseMsg()
	
	end

end

function SmartHeal:HealStack_OnCast(stacktype)

	
	if (	not SmartHeal.CastedSpell 
		or not SmartHeal.StackUnitId  
		or not SmartHeal.spellList 
		or GetNumRaidMembers()==0
	
	) then return end
	
	local TargetName=UnitName(SmartHeal.StackUnitId)
	
	if (	SmartHeal:getConfig("healstack") 
		and (SmartHeal.spellList[SmartHeal.CastedSpell] and not SmartHeal.spellList[SmartHeal.CastedSpell].HoT)
		and TargetName
	) then
		
		if(not stacktype) then stacktype=1 end
		local msg="STACK "..TargetName.." "..floor(SmartHeal.StackValue*stacktype)
		SendAddonMessage(SmartHeal.AddOnMessagePrefix,msg,"RAID")
	end
	
end

function SmartHeal:HealStack_ParseMsg()

	local _,_,cmd,msg=string.find(arg2,"^(%w+) (.*)")
	if(cmd=="STACK") then
		SmartHeal:HealStackUpdate(msg)
		--SmartHeal:ErrorMsg(msg)
	end


end

function SmartHeal:HealStackUpdate(msg)

	local _,_,TargetName,StackValue=string.find(msg,"^(%w+) (%-?%d+)$")
		
	if (not TargetName or not StackValue) then return end
	
	if (SmartHeal.HealStack[TargetName]) then
		SmartHeal.HealStack[TargetName]=SmartHeal.HealStack[TargetName]+tonumber(StackValue)
	else
		SmartHeal.HealStack[TargetName]=tonumber(StackValue)
	end
	
	if (SmartHeal.HealStack[TargetName]<0) then
		SmartHeal.HealStack[TargetName]=0
	end

end

function SmartHeal:HealStackOnUpdate()

	if (GetNumRaidMembers()==0 or SmartHeal.HealStackUpdating) then return end

	SmartHeal.HealStackUpdating=true
	
	local BarTables={	["CT_RAMember"]={count=40},
				["CT_RA_EmergencyFrameFrame"]={count=5},
				["CT_RAMTGroupMember"]={count=10},
				["CT_RAPTGroupMember"]={count=10},
			}

	for ParentFrame, properties in BarTables do

		for i=1,properties.count do
		
			local UnitId,unitName,CTRA_FrameName
			
			if (ParentFrame=="CT_RAMember") then
				CTRA_FrameName=ParentFrame..i
				UnitId="raid"..i
				unitName=UnitName("raid"..i)
			elseif(ParentFrame=="CT_RAMTGroupMember") then
				CTRA_FrameName=ParentFrame..i.."MTTT"
				unitName=getglobal(CTRA_FrameName).Name
				UnitId=GetUnitIdFromName(unitName)
			elseif (ParentFrame=="CT_RA_EmergencyFrameFrame" or ParentFrame=="CT_RAPTGroupMember") then
				CTRA_FrameName=ParentFrame..i
				unitName=getglobal(CTRA_FrameName).Name
				UnitId=GetUnitIdFromName(unitName)
			end
			
			local HPBarFrameName=CTRA_FrameName.."HPBar"
			local HPBarObj=getglobal(HPBarFrameName)
			local StackValue=0
			
			if(UnitId and SmartHeal.HealStack[unitName] and SmartHeal.HealStack[unitName]>0) then 
				StackValue=min((UnitHealthMax(UnitId)-UnitHealth(UnitId)),SmartHeal.HealStack[unitName])
			end
			
			if(UnitId and UnitExists(UnitId) and not UnitIsDeadOrGhost(UnitId) and UnitIsConnected(UnitId) and UnitIsVisible(UnitId) 
				and StackValue>0 and HPBarObj and HPBarObj:IsShown()) then
				
				getglobal(HPBarFrameName.."_SMHStack"):SetHeight(HPBarObj:GetHeight())
				getglobal(HPBarFrameName.."_SMHStack"):SetPoint("TOPLEFT","$parent","TOPLEFT",UnitHealth(UnitId)/UnitHealthMax(UnitId)*HPBarObj:GetWidth(),0)
				getglobal(HPBarFrameName.."_SMHStack"):SetWidth(StackValue/UnitHealthMax(UnitId)*HPBarObj:GetWidth())
				getglobal(HPBarFrameName.."_SMHStack"):Show()
				
			else
				getglobal(HPBarFrameName.."_SMHStack"):Hide()
			end

		end
	end
	
	SmartHeal.HealStackUpdating=nil

end

function GetUnitIdFromName(name1)

	for i=1,40 do
		local name2, rank, _, _, _, _, _, _, _ = GetRaidRosterInfo(i)
		if (name1 == name2 and rank) then
		 	return "raid"..i
		end
	end

	return nil

end
