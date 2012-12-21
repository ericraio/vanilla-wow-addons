SmartHeal.OptionTab = {
	["SH_OptionsFrameTab1"] = SH_GENEARL,    
	["SH_OptionsFrameTab2"] = SH_CLICKHEAL,
	["SH_OptionsFrameTab3"] = SH_HOTLIST,
}

SmartHeal.TabDefault={

	["SH_OptionsFrameTab1"] = {"enable","overheal","override","altselfcast","autoselfcast","alert","minimapbutton","excesshealalert","excesshealalerttrigger","healstack","RClickHotKeySelfCast"},
	["SH_OptionsFrameTab2"] = {"clickmode"},
	["SH_OptionsFrameTab3"] = {"hotlist"},
}

function SmartHeal:OptionTabClick(tabName)

	for currentName,desc in SmartHeal.OptionTab do
	
		local _,_,number=string.find(currentName,"SH_OptionsFrameTab(%d+)");
		local optionPage=getglobal("SH_OptionsFrame"..number)
		
		if currentName==tabName then
			SmartHeal.CurrentTab=tabName
			optionPage:Show()
		else
			optionPage:Hide()
		end
	
	end
	
end

function SmartHeal:ClickCheckBox(frameName,status)
	
	local _,_,option,module=string.find(frameName,".*_CheckButton_([^_]*)_?(.*)");
	if (status==nil) then 
		status=false
		--SmartHeal:ErrorMsg("false")
	end
	SmartHeal:setConfig(option,status,module)

end

function SmartHeal:DropDownMenuOnLoad(frame,dropList,selectedID,callback,width)
	UIDropDownMenu_Initialize(this, function() 
						for index,value in dropList do
							local info={}
							info.text = value;
							info.func= 	function()
										
										SmartHeal.DropDownSelectedId=this:GetID()
										SmartHeal.DropDownFrame=frame
										UIDropDownMenu_SetSelectedID(frame, SmartHeal.DropDownSelectedId)	
										if (type(callback)=="function") then 
											callback() 
										end
									end
							UIDropDownMenu_AddButton(info);
						end
					end
				);
	if(width) then 
		UIDropDownMenu_SetWidth(width)
	end
	
	if(not selectedID) then selectedID=1 end
	
	UIDropDownMenu_SetSelectedID(this,selectedID);
end

function SH_ClickHealOnSelect()
	
	local frameName=SmartHeal.DropDownFrame:GetName();
	local _,_,option,module=string.find(frameName,".*_DropDown_([^_]*)_?(.*)")
	SmartHeal:setConfig(option,SmartHeal.DropDownSelectedId,module)
	
end

function SH_OverDriveOnSelect()
	
	local frameName=SmartHeal.DropDownFrame:GetName();
	local _,_,option,module=string.find(frameName,".*_DropDown_([^_]*)_?(.*)")
	SmartHeal:setConfig(option,SmartHeal.DropDownSelectedId,module)
	--SmartHeal:ClickHeal_DropDown_OnShow()
	SmartHeal.DropDownFrame:GetParent():Hide()
	SmartHeal.DropDownFrame:GetParent():Show()
end

function SH_AutotargetHotkeyOnSelect()
	
	local frameName=SmartHeal.DropDownFrame:GetName();
	local _,_,option,module=string.find(frameName,".*_DropDown_([^_]*)_?(.*)")
	SmartHeal:setConfig(option,SmartHeal.DropDownSelectedId,module)
	
end

