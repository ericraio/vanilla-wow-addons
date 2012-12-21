SmartHeal.default['clickmode']={}

SmartHeal.clickmodeOptionList={
	['PRIEST']={SH_UNASSIGNED,
				SH_RENEW,SH_FLASH_HEAL,SH_LESSER_GREATER_HEALS,SH_PRAYER_OF_HEALING,
				SH_GREATER_HEAL,SH_HEAL,SH_LESSER_HEAL,
				SH_POWERWORD_SHIELD,SH_POWERWORD_FORTITUDE,SH_PRAYER_OF_FORTITUDE,SH_SHADOW_PROTECTION,SH_PRAYER_OF_SHADOW_PROTECTION,
				SH_DIVINE_SPIRIT,SH_DISPEL_MAGIC,SH_ABOLISH_DISEASE,SH_RESURRECTION,
			},

	['PALADIN']={SH_UNASSIGNED,
				SH_FLASH_OF_LIGHT,SH_HOLY_LIGHT,SH_REDEMPTION,SH_LAY_ON_HANDS,
				SH_BLESSING_OF_KINGS,SH_BLESSING_OF_MIGHT,SH_BLESSING_OF_LIGHT,SH_BLESSING_OF_WISDOM,SH_BLESSING_OF_SALVATION,SH_BLESSING_OF_SANCTUARY,SH_BLESSING_OF_PROTECTION,SH_BLESSING_OF_FREEDOM,
				SH_GREATER_BLESSING_OF_KINGS,SH_GREATER_BLESSING_OF_MIGHT,SH_GREATER_BLESSING_OF_LIGHT,SH_GREATER_BLESSING_OF_WISDOM,SH_GREATER_BLESSING_OF_SALVATION,SH_GREATER_BLESSING_OF_SANCTUARY,
			},

	['DRUID']={SH_UNASSIGNED, 
				SH_REJUVENATION,SH_HEALING_TOUCH,SH_REGROWTH,
				SH_MARK_OF_THE_WILD,SH_GIFT_OF_THE_WILD,SH_NATURES_SWIFTNESS,
				SH_REBIRTH,SH_TRANQULITY,SH_INNERVATE,SH_THORNS,SH_SWIFTMEND
			},
	
	['SHAMAN']={SH_UNASSIGNED,
				SH_LESSER_HEALING_WAVE,SH_HEALING_WAVE,SH_CHAIN_HEAL,
				SH_ANCESTRAL_SPIRIT,SH_LIGHTNING_SHIELD,
		},

}

SmartHeal.OverDriveOptionList={SH_DISABLED,"shift","ctrl","alt"}

SmartHeal.defaultClick={
	['PRIEST']={
			['shiftLeftButton']=3,['shiftMiddleButton']=2,['shiftRightButton']=9,
			['ctrlLeftButton']=3,['ctrlMiddleButton']=2,['ctrlRightButton']=9,
			['altLeftButton']=4,['altMiddleButton']=1,['altRightButton']=10,
	},
	['PALADIN']={
			['shiftLeftButton']=2,['shiftMiddleButton']=4,['shiftRightButton']=1,
			['ctrlLeftButton']=2,['ctrlMiddleButton']=4,['ctrlRightButton']=1,
			['altLeftButton']=3,['altMiddleButton']=1,['altRightButton']=1,
	},
	['DRUID']={
			['shiftLeftButton']=2,['shiftMiddleButton']=4,['shiftRightButton']=5,
			['ctrlLeftButton']=2,['ctrlMiddleButton']=4,['ctrlRightButton']=5,
			['altLeftButton']=3,['altMiddleButton']=8,['altRightButton']=6,
	},
	['SHAMAN']={
			['shiftLeftButton']=2,['shiftMiddleButton']=6,['shiftRightButton']=4,
			['ctrlLeftButton']=2,['ctrlMiddleButton']=6,['ctrlRightButton']=4,
			['altLeftButton']=3,['altMiddleButton']=1,['altRightButton']=5,
	},
}

SmartHeal.ClickHealFuncMap={
	
}

function SmartHeal:InitClickMode()

	SmartHeal.default['clickmode']['enable']=1
	SmartHeal.default['clickmode']['overdrive']=2
	
	for option,value in SmartHeal.defaultClick[SmartHeal.playerClass] do
		SmartHeal.default['clickmode'][option]=value
	end
	
	-- ctra unit frame click
	if ( type(CT_RA_CustomOnClickFunction) == "function" ) then SH_CT_RA_CustomOnClickFunction=CT_RA_CustomOnClickFunction end
	-- blizz player frame click
	if ( type(PlayerFrame_OnClick) == "function" ) then 
		PlayerFrame:RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up");
		SH_PlayerFrame_OnClick=PlayerFrame_OnClick
	end
	if (type(PetFrame_OnClick)=="function") then
		PetFrame:RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up")
		SH_PetFrame_OnClick=PetFrame_OnClick
	end
	-- blizz party unit and pet frame click
	if ( type(PartyMemberFrame_OnClick) == "function" ) then 
		PartyMemberFrame1:RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up")
		PartyMemberFrame2:RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up")
		PartyMemberFrame3:RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up")
		PartyMemberFrame4:RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up")
		SH_PartyMemberFrame_OnClick=PartyMemberFrame_OnClick
	end
	if ( type(PartyMemberPetFrame_OnClick) == "function" ) then 
		PartyMemberFrame1PetFrame:RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up")
		PartyMemberFrame2PetFrame:RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up")
		PartyMemberFrame3PetFrame:RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up")
		PartyMemberFrame4PetFrame:RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up")
		SH_PartyMemberPetFrame_OnClick=PartyMemberPetFrame_OnClick 
	end
	if ( type(TargetFrame_OnClick) == "function" ) then 
		TargetFrame:RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up")
		SH_TargetFrame_OnClick=TargetFrame_OnClick
	end
	if(type(TargetofTarget_OnClick) == "function" ) then
		TargetofTargetFrame:RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up")
		SH_TargetofTarget_OnClick=TargetofTarget_OnClick
	end
	if ( type(CT_AssistFrame_OnClick) == "function" ) then 
		CT_AssistFrame:RegisterForClicks("LeftButtonUp","MiddleButtonUp","RightButtonUp","Button4Up","Button5Up")
		SH_CT_AssistFrame_OnClick=CT_AssistFrame_OnClick
	end
	
	-- check for Nymbia's Perl
	if(type(Perl_Player_OnClick)=="function") then SH_Perl_Player_OnClick=Perl_Player_OnClick end
	if(type(Perl_Player_Pet_MouseUp)=="function") then SH_Perl_Player_Pet_MouseUp=Perl_Player_Pet_MouseUp end
	if(type(Perl_Party_OnClick)=="function") then SH_Perl_Party_OnClick=Perl_Party_OnClick end
	if(type(Perl_Party_Pet_MouseUp)=="function") then SH_Perl_Party_Pet_MouseUp=Perl_Party_Pet_MouseUp end
	if(type(Perl_Target_MouseUp)=="function") then SH_Perl_Target_MouseUp=Perl_Target_MouseUp end
	if(type(Perl_Raid_OnClick)=="function") then SH_Perl_Raid_OnClick=Perl_Raid_OnClick end
	
	-- discord unit frame click
	if ( type(DUF_UnitFrame_OnClick) == "function" ) then SH_DUF_UnitFrame_OnClick=DUF_UnitFrame_OnClick end
	if ( type(DUF_Element_OnClick) == "function" ) then SH_DUF_Element_OnClick=DUF_Element_OnClick end
	
	-- Sage
	if ( type(SFrame_OnClick) == "function" ) then SH_SFrame_OnClick=SFrame_OnClick end
	
	-- PerfectRaid
	if (PerfectRaid) then SH_PerfectRaidCustomClick=PerfectRaidCustomClick end
	
	-- Nurfed Unitframes
	if(type(NurfedPlayer_OnClick)=="function") then SH_NurfedPlayer_OnClick=NurfedPlayer_OnClick end
	if(type(Nurfed_PetFrame_OnClick)=="function") then SH_Nurfed_PetFrame_OnClick=Nurfed_PetFrame_OnClick end
	if(type(Nurfed_PartyMember_OnClick)=="function") then SH_Nurfed_PartyMember_OnClick=Nurfed_PartyMember_OnClick end
	if(type(Nurfed_TargetFrame_OnClick)=="function") then SH_Nurfed_TargetFrame_OnClick=Nurfed_TargetFrame_OnClick end
	if(type(Nurfed_Unit_OnClick)=="function") then SH_Nurfed_Unit_OnClick=Nurfed_Unit_OnClick end
	
	
	if (SmartHeal:getConfig("enable","clickmode")==nil or SmartHeal:getConfig("enable","clickmode")) then
		SmartHeal:setClickMode(1)
	else
		SmartHeal:setClickMode()
	end
	
end

function SmartHeal:setClickMode(status)
	
	if (status) then
		
		CT_RA_CustomOnClickFunction= 	function(button,unit) return SmartHeal:CTRA_ClickHeal(button,unit) end
		CT_AssistFrame_OnClick=		function(button) return SmartHeal:CT_AssistFrame_OnClick(button) end
		
		PlayerFrame_OnClick=	 	function(button) return SmartHeal:PlayerFrame_OnClick(button) end
		PetFrame_OnClick=		function(button) return SmartHeal:PetFrame_OnClick(button) end
		PartyMemberFrame_OnClick= 	function(partyFrame) return SmartHeal:PartyMemberFrame_OnClick(partyFrame) end
		PartyMemberPetFrame_OnClick=	function() return SmartHeal:PartyMemberPetFrame_OnClick() end
		TargetFrame_OnClick=		function(button) return SmartHeal:TargetFrame_OnClick(button) end
		TargetofTarget_OnClick=		function(button) return SmartHeal:TargetofTarget_OnClick(button) end
						
		DUF_UnitFrame_OnClick=		function(button) return SmartHeal:DUF_UnitFrame_OnClick(button) end
		DUF_Element_OnClick=		function(button) return SmartHeal:DUF_Element_OnClick(button) end
		
		Perl_Player_OnClick=		function(button) return SmartHeal:Perl_Player_OnClick(button) end
		Perl_Player_Pet_MouseUp=	function(button) return SmartHeal:Perl_Player_Pet_MouseUp(button) end
		Perl_Party_OnClick=		function(button) return SmartHeal:Perl_Party_OnClick(button) end
		Perl_Party_Pet_MouseUp=		function(button) return SmartHeal:Perl_Party_Pet_MouseUp(button) end
		Perl_Target_MouseUp=		function(button) return SmartHeal:Perl_Target_MouseUp(button) end
		Perl_Raid_OnClick=		function(button) return SmartHeal:Perl_Raid_OnClick(button) end
		
		SFrame_OnClick=	 function() return SmartHeal:SFrame_OnClick() end
		PerfectRaidCustomClick = function(button,unit) return SmartHeal:PerfectRaidCustomClick(button, unit) end
		
		NurfedPlayer_OnClick=function(button) return SmartHeal:NurfedPlayer_OnClick(button) end
		Nurfed_PetFrame_OnClick=function(button) return SmartHeal:Nurfed_PetFrame_OnClick(button) end
		Nurfed_PartyMember_OnClick=function(partyFrame) return SmartHeal:Nurfed_PartyMember_OnClick(partyFrame) end
		Nurfed_TargetFrame_OnClick=function(targetFrame) return SmartHeal:Nurfed_TargetFrame_OnClick(targetFrame) end
		Nurfed_Unit_OnClick=function(arg1) return SmartHeal:Nurfed_Unit_OnClick(arg1) end
		
	else
		
		-- reset to original click function
		CT_RA_CustomOnClickFunction=SH_CT_RA_CustomOnClickFunction
		CT_AssistFrame_OnClick=SH_CT_AssistFrame_OnClick
		
		PlayerFrame_OnClick=SH_PlayerFrame_OnClick
		PetFrame_OnClick=SH_PetFrame_OnClick
		PartyMemberFrame_OnClick=SH_PartyMemberFrame_OnClick
		PartyMemberPetFrame_OnClick=SH_PartyMemberPetFrame_OnClick
		TargetFrame_OnClick=SH_TargetFrame_OnClick
		TargetofTarget_OnClick=SH_TargetofTarget_OnClick
		
		DUF_UnitFrame_OnClick=SH_DUF_UnitFrame_OnClick
		DUF_Element_OnClick=SH_DUF_Element_OnClick
		
		Perl_Player_OnClick=SH_Perl_Player_OnClick
		Perl_Player_Pet_MouseUp=SH_Perl_Player_Pet_MouseUp
		Perl_Party_OnClick=SH_Perl_Party_OnClick
		Perl_Party_Pet_MouseUp=SH_Perl_Party_Pet_MouseUp
		Perl_Target_MouseUp=SH_Perl_Target_MouseUp
		Perl_Raid_OnClick=SH_Perl_Raid_OnClick
		
		SFrame_OnClick=SH_SFrame_OnClick
		PerfectRaidCustomClick=SH_PerfectRaidCustomClick
		
		NurfedPlayer_OnClick=SH_NurfedPlayer_OnClick
		Nurfed_PetFrame_OnClick=SH_Nurfed_PetFrame_OnClick
		Nurfed_PartyMember_OnClick=SH_Nurfed_PartyMember_OnClick
		Nurfed_TargetFrame_OnClick=SH_Nurfed_TargetFrame_OnClick
		Nurfed_Unit_OnClick=SH_Nurfed_Unit_OnClick
		
	end
end

function SmartHeal:NurfedPlayer_OnClick(button)

	local KeyDownType=SmartHeal:GetClickHealButton()
	
	if KeyDownType=="undetermined" then
		return
	elseif KeyDownType then
		SmartHeal:ClickHeal(KeyDownType..button,"player")
	elseif ( type(SH_NurfedPlayer_OnClick)=="function") then 
		return SH_NurfedPlayer_OnClick(button)
	end

end

function SmartHeal:Nurfed_PetFrame_OnClick(button)

	local KeyDownType=SmartHeal:GetClickHealButton()
	
	if KeyDownType=="undetermined" then
		return
	elseif KeyDownType then
		SmartHeal:ClickHeal(KeyDownType..button,"pet")
	elseif ( type(SH_Nurfed_PetFrame_OnClick)=="function") then 
		return SH_Nurfed_PetFrame_OnClick(button)
	end

end

function SmartHeal:Nurfed_PartyMember_OnClick(partyFrame)

	if ( not partyFrame ) then partyFrame=this end
	local unit = "party"..partyFrame:GetID()

	local KeyDownType=SmartHeal:GetClickHealButton()
	if KeyDownType=="undetermined" then
		return
	elseif KeyDownType then
		SmartHeal:ClickHeal(KeyDownType..arg1,unit)
	elseif ( type(SH_Nurfed_PartyMember_OnClick)=="function") then 
		return SH_Nurfed_PartyMember_OnClick(partyFrame)
	end

end

function SmartHeal:Nurfed_TargetFrame_OnClick(targetFrame)
	local KeyDownType=SmartHeal:GetClickHealButton()
	
	if KeyDownType=="undetermined" then
		return
	elseif KeyDownType then
		SmartHeal:ClickHeal(KeyDownType..arg1,"target")
	elseif ( type(SH_Nurfed_TargetFrame_OnClick)=="function") then 
		return SH_Nurfed_TargetFrame_OnClick(targetFrame)
	end
end

function SmartHeal:Nurfed_Unit_OnClick(arg1)

	local KeyDownType=SmartHeal:GetClickHealButton()
	if KeyDownType=="undetermined" then
		return
	elseif KeyDownType then
		SmartHeal:ClickHeal(KeyDownType..arg1,this.unit)
	elseif ( type(SH_Nurfed_Unit_OnClick)=="function") then 
		return SH_Nurfed_Unit_OnClick(arg1)
	end

end

function SmartHeal:PerfectRaidCustomClick(button, unit)

	local KeyDownType=SmartHeal:GetClickHealButton()

	if KeyDownType=="undetermined" then
		return
	elseif KeyDownType then
		SmartHeal:ClickHeal(KeyDownType..button,unit)
	elseif ( type(SH_PerfectRaidCustomClick)=="function") then
		return SH_PerfectRaidCustomClick(button,unit)
	else
		SmartHeal:DefaultClick(button,unit)
	end

end

function SmartHeal:SFrame_OnClick()
	
	local unit = SFrame_FrameToID(this)
	local KeyDownType=SmartHeal:GetClickHealButton()
	
	if KeyDownType=="undetermined" then
		return
	elseif KeyDownType then
		SmartHeal:ClickHeal(KeyDownType..arg1,unit)
	elseif ( type(SH_SFrame_OnClick)=="function") then 
		return SH_SFrame_OnClick()
	end
end

function SmartHeal:TargetofTarget_OnClick(button)

	local unit="targettarget"
	if(UnitCanAttack("player","targettarget")) then
		unit="targettargettarget"
	end
	
	local KeyDownType=SmartHeal:GetClickHealButton()
	
	if KeyDownType=="undetermined" then
		return
	elseif KeyDownType then
		SmartHeal:ClickHeal(KeyDownType..button,unit)
	elseif ( type(SH_TargetofTarget_OnClick)=="function") then 
		return SH_TargetofTarget_OnClick(button)
	end

end

function SmartHeal:Perl_Player_OnClick(button)
	local KeyDownType=SmartHeal:GetClickHealButton()
	
	if KeyDownType=="undetermined" then
		return
	elseif KeyDownType then
		SmartHeal:ClickHeal(KeyDownType..button,"player")
	elseif ( type(SH_Perl_Player_OnClick)=="function") then 
		return SH_Perl_Player_OnClick(button)
	end
end

function SmartHeal:Perl_Player_Pet_MouseUp(button)
	local KeyDownType=SmartHeal:GetClickHealButton()
	
	if KeyDownType=="undetermined" then
		return
	elseif KeyDownType then
		SmartHeal:ClickHeal(KeyDownType..button,"pet")
	elseif ( type(SH_Perl_Player_Pet_MouseUp)=="function") then 
		return SH_Perl_Player_Pet_MouseUp(button)
	end
end

function SmartHeal:Perl_Party_OnClick(button)
	local id=Perl_Party_FindID(this);
	this:SetID(id);
	local KeyDownType=SmartHeal:GetClickHealButton()
	if KeyDownType=="undetermined" then
		return
	elseif KeyDownType then
		SmartHeal:ClickHeal(KeyDownType..arg1,"party"..id)
	elseif ( type(SH_Perl_Party_OnClick)=="function") then 
		return SH_Perl_Party_OnClick(button)
	end
end

function SmartHeal:Perl_Party_Pet_MouseUp(button)

	local id=Perl_Party_Pet_FindID(this);
	this:SetID(id);
	local KeyDownType=SmartHeal:GetClickHealButton()
	
	if KeyDownType=="undetermined" then
		return
	elseif KeyDownType then
		SmartHeal:ClickHeal(KeyDownType..arg1,"partypet"..id)
	elseif ( type(SH_Perl_Party_Pet_MouseUp)=="function") then 
		return SH_Perl_Party_Pet_MouseUp(button)
	end
end

function SmartHeal:Perl_Target_MouseUp(button)

	local KeyDownType=SmartHeal:GetClickHealButton()
	
	if KeyDownType=="undetermined" then
		return
	elseif KeyDownType then
		SmartHeal:ClickHeal(KeyDownType..button,"target")
	elseif ( type(SH_Perl_Target_MouseUp)=="function") then 
		return SH_Perl_Target_MouseUp(button)
	end

end

function SmartHeal:Perl_Raid_OnClick(button)
	local id=Perl_Raid_FindID(this);
	this:SetID(id);
	if (this:GetID()<=40) then
		partyid = ("raid"..this:GetID());
	else
		if Warriors[this:GetID()-40] then
			partyid = ("raid"..Warriors[this:GetID()-40].."target");
		else
			return
		end
	end
	local KeyDownType=SmartHeal:GetClickHealButton()
	
	if KeyDownType=="undetermined" then
		return
	elseif KeyDownType then
		SmartHeal:ClickHeal(KeyDownType..button,partyid)
	elseif ( type(SH_Perl_Raid_OnClick)=="function") then 
		return SH_Perl_Raid_OnClick(button)
	end

end

function SmartHeal:DUF_Element_OnClick(button)
	
	local unit = this.unit;
	if (not unit) then
		unit = this:GetParent().unit;
	end

	local KeyDownType=SmartHeal:GetClickHealButton()
	
	if KeyDownType=="undetermined" then
		return
	elseif KeyDownType then
		SmartHeal:ClickHeal(KeyDownType..button,unit)
	elseif ( type(SH_DUF_UnitFrame_OnClick)=="function") then 
		return SH_DUF_Element_OnClick(button)
	end
	
end

function SmartHeal:DUF_UnitFrame_OnClick(button)
	
	local KeyDownType=SmartHeal:GetClickHealButton()
	
	if KeyDownType=="undetermined" then
		return
	elseif KeyDownType then
		SmartHeal:ClickHeal(KeyDownType..button,this.unit)
	elseif ( type(SH_DUF_UnitFrame_OnClick)=="function") then 
		return SH_DUF_UnitFrame_OnClick(button)
	end
	
end

function SmartHeal:PartyMemberFrame_OnClick(partyFrame)
	if ( not partyFrame ) then
		partyFrame = this;
	end
	local unit = "party"..partyFrame:GetID();
	local KeyDownType=SmartHeal:GetClickHealButton()
	
	if KeyDownType=="undetermined" then
		return
	elseif KeyDownType then
		SmartHeal:ClickHeal(KeyDownType..arg1,unit)
	elseif ( type(SH_PartyMemberFrame_OnClick)=="function") then 
		return SH_PartyMemberFrame_OnClick(partyFrame)
	end
end

function SmartHeal:PartyMemberPetFrame_OnClick()
	
	local unit = "partypet"..this:GetParent():GetID();
	local KeyDownType=SmartHeal:GetClickHealButton()
	
	if KeyDownType=="undetermined" then
		return
	elseif KeyDownType then
		SmartHeal:ClickHeal(KeyDownType..arg1,unit)
	elseif ( type(SH_PartyMemberPetFrame_OnClick)=="function") then 
		return SH_PartyMemberPetFrame_OnClick()
	end
	
end

function SmartHeal:TargetFrame_OnClick(button)
	local KeyDownType=SmartHeal:GetClickHealButton()
	
	if KeyDownType=="undetermined" then
		return
	elseif KeyDownType then
		SmartHeal:ClickHeal(KeyDownType..button,"target")
	elseif ( type(SH_TargetFrame_OnClick)=="function") then 
		return SH_TargetFrame_OnClick(button)
	end
end

function SmartHeal:CT_AssistFrame_OnClick(button)
	
	local unit="targettarget"
	if(UnitCanAttack("player","targettarget")) then
		unit="targettargettarget"
	end
	
	local KeyDownType=SmartHeal:GetClickHealButton()
	
	if KeyDownType=="undetermined" then
		return
	elseif KeyDownType then
		SmartHeal:ClickHeal(KeyDownType..button,unit)
	elseif ( type(SH_CT_AssistFrame_OnClick)=="function") then 
		return SH_CT_AssistFrame_OnClick(button)
	end
end

function SmartHeal:PlayerFrame_OnClick(button)
	local KeyDownType=SmartHeal:GetClickHealButton()
	
	if KeyDownType=="undetermined" then
		return
	elseif KeyDownType then
		SmartHeal:ClickHeal(KeyDownType..button,"player")
	elseif ( type(SH_PlayerFrame_OnClick)=="function") then 
		return SH_PlayerFrame_OnClick(button)
	end
end

function SmartHeal:PetFrame_OnClick(button)
	local KeyDownType=SmartHeal:GetClickHealButton()
	
	if KeyDownType=="undetermined" then
		return
	elseif KeyDownType then
		SmartHeal:ClickHeal(KeyDownType..button,"pet")
	elseif ( type(SH_PetFrame_OnClick)=="function") then 
		return SH_PetFrame_OnClick(button)
	end
end

function SmartHeal:CTRA_ClickHeal(button,unit)

	local KeyDownType=SmartHeal:GetClickHealButton()
	
	if KeyDownType=="undetermined" then
		return true
	elseif KeyDownType then
		SmartHeal:ClickHeal(KeyDownType..button,unit)
		return true
	elseif ( type(SH_CT_RA_CustomOnClickFunction)=="function") then 
		return SH_CT_RA_CustomOnClickFunction(button,unit)
	else
		return false
	end

end

function SmartHeal:GetKeyDownType()
	
	local keydowntype={}

	if IsControlKeyDown() then keydowntype["ctrl"]=1 end
	if IsAltKeyDown() then keydowntype["alt"]=1 end
	if IsShiftKeyDown() then keydowntype["shift"]=1 end
	
	return keydowntype

end

function SmartHeal:GetClickHealButton()

	local keydowntype=SmartHeal:GetKeyDownType()
	keydowntype[SmartHeal.OverDriveOptionList[SmartHeal:getConfig("overdrive","clickmode")]]=nil
	
	local clickhealButton={}
	
	local i=1
	for key,status in keydowntype do
		clickhealButton[i]=key
		i=i+1
	end
	
	if(clickhealButton[2]) then 
		return "undetermined"
	else
		return clickhealButton[1]
	end 

end

function SmartHeal:DefaultClick(button,unit)
	if (button == "LeftButton") then
		if (SpellIsTargeting()) then
			SpellTargetUnit(unit)
			return true
		elseif (CursorHasItem()) then
      			if (UnitIsUnit("player", unit)) then
         			AutoEquipCursorItem()
			else
				DropItemOnUnit(unit)
			end
			return true
		else
			TargetUnit(unit)
			return true
		end
	elseif (button == "RightButton") then
		if (SpellIsTargeting()) then
			SpellStopTargeting()
			return true
		elseif (CursorHasItem()) then
			if (ClearCursor) then
				ClearCursor()
				return true
			end
		end
	end
end

function SmartHeal:ClickHeal(button,unit)
	
	local optionID=SmartHeal:getConfig(button,'clickmode')
	local spell=SmartHeal.clickmodeOptionList[SmartHeal.playerClass][optionID]
	local clearTarget,Attacking
	SmartHeal.AttackingBeforeCast=nil
	
	if (not spell or not UnitExists(unit)) then return end
	
	if (UnitIsUnit("player",unit)) then
		SmartHeal.selfCast=1
	else
		SmartHeal.selfCast=0
	end
	
	if (UnitIsUnit("player",unit) or UnitIsUnit("target",unit)) then
		SmartHeal:Cast(spell)
		
	else
	
		if(not UnitExists("target")) then clearTarget=1
		elseif (SmartHeal.Attacking) then Attacking=1 end
	
		TargetUnit(unit)
		
		SmartHeal:Cast(spell)
		
		if (SpellIsTargeting() and not SpellCanTargetUnit(unit)) then	
			SpellStopTargeting()
			
			if(clearTarget) then
				ClearTarget()
			else
				TargetLastTarget()
			end
		
			if(Attacking) then
				SmartHeal.ResumeAttack=1
			end
		else
		
			if(clearTarget) then
				ClearTarget()
			else
				TargetLastTarget()
			end
			
			if(Attacking) then
				SmartHeal.AttackingBeforeCast=1
			end
		end
			
	end

end

SmartHeal.ResumeAttackDelay=1 -- 1 sec delay to resume attack current target
SmartHeal.ResumeAttackTimer=0

function SmartHeal:ResumeAttack_OnUpdate(arg1)
	
	if(SmartHeal.ResumeAttack) then
		SmartHeal.ResumeAttackTimer=SmartHeal.ResumeAttackTimer+arg1
		if(SmartHeal.ResumeAttackTimer>SmartHeal.ResumeAttackDelay) then
			if (not SmartHeal.Attacking) then AttackTarget() end
			SmartHeal.ResumeAttack=nil
			SmartHeal.ResumeAttackTimer=0
		end
	end
	
end

function SmartHeal:ClickHeal_IsOverdrive()

	local keydowntype=SmartHeal:GetKeyDownType()

	if (keydowntype[SmartHeal.OverDriveOptionList[SmartHeal:getConfig("overdrive","clickmode")]]) then
		return true
	else
		return nil
	end
end

function SmartHeal:ClickHeal_DropDown_OnShow()
	local OverdriveHotkey=SmartHeal.OverDriveOptionList[SmartHeal:getConfig("overdrive","clickmode")]
	local parentName="SH_OptionsFrame2"
	
	for i=2,table.getn(SmartHeal.OverDriveOptionList) do
		
		if(SmartHeal.OverDriveOptionList[i]==OverdriveHotkey) then
			getglobal(parentName.."_DropDown_"..OverdriveHotkey.."LeftButton_clickmode"):Hide()
			getglobal(parentName.."_DropDown_"..OverdriveHotkey.."MiddleButton_clickmode"):Hide()
			getglobal(parentName.."_DropDown_"..OverdriveHotkey.."RightButton_clickmode"):Hide()
			getglobal(parentName.."_Disabled_"..OverdriveHotkey.."LeftButton_clickmode"):Show()
			getglobal(parentName.."_Disabled_"..OverdriveHotkey.."MiddleButton_clickmode"):Show()
			getglobal(parentName.."_Disabled_"..OverdriveHotkey.."RightButton_clickmode"):Show()
		else
		
			getglobal(parentName.."_DropDown_"..SmartHeal.OverDriveOptionList[i].."LeftButton_clickmode"):Show()
			getglobal(parentName.."_DropDown_"..SmartHeal.OverDriveOptionList[i].."MiddleButton_clickmode"):Show()
			getglobal(parentName.."_DropDown_"..SmartHeal.OverDriveOptionList[i].."RightButton_clickmode"):Show()
			getglobal(parentName.."_Disabled_"..SmartHeal.OverDriveOptionList[i].."LeftButton_clickmode"):Hide()
			getglobal(parentName.."_Disabled_"..SmartHeal.OverDriveOptionList[i].."MiddleButton_clickmode"):Hide()
			getglobal(parentName.."_Disabled_"..SmartHeal.OverDriveOptionList[i].."RightButton_clickmode"):Hide()
		
		end
	
	end
	
end
