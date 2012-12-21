--[[
Changelog:

	Version 1.2.0
		fixed compeltely disapaering messages by a big moddification in the hook
		updated toc
		updated silvanaslib

	Version 1.1.8
		fixed a small scanning bug that would some unEquipable items show up as useable

	Version 1.1.7
		fixed 2 overflown bugs but in a bad way so the might be new probs atleast i tryed to fix it :p

	Version 1.1.5
		Fixed a small version number witch i forgot to update 

	Version 1.1.4
		now only works on chat messages or loot message

	Version 1.1.1
		small bug fix for iems whitout a level got shown whit a () level witch is now gone again

	Version 1.1.0
	    basic sepport added for customiseable colors for some items witch can be set in the "CustomRecolor.lua"
        Money coloring now default to off becase of the many unforseen problems... :(
        added a new comand to get  he number of an item
        actioneer sepport fixed for actionneer version 3.6.1
        Setting now get saved and loaded back instead of jsut saved

	Version 1.0.8
		Fixed money coloring inside color strings
		Hopefully fixed the german stack overflow
		Fixed money enable or disable cmds

	Version 1.0.5
		Fixed money coloring system trigering on g2g
		Fixed error when a nil message was send
		Fixed compatibiltie whit Nerfed Combatlog (but not the actual prob that was casing the bug)

	Version 1.0.3
	    Fixed bug where some item strings where nolonger localised
	    Fixed a bug where multiple item links in 1 chat message all would link to the first item
	    Money / itemlink coloing can now be turned on / off seperately

	Version 1.0.0
		First working version, after lots of debugging :p

Known Bugs:

Todo:
	Code Cleanup (it was nice but after the latest fixed its pure crap again..
--]]

--main global var
ItemLinkRecolor = {
	AddonName   	= "ItemLinkRecolor",
	["NAME"] 		= "|cFF33CC66Item Link Recolor|r",
	["VERSION"] 	= "(|cFF9900001|cFFFFFFFF.|cFF9900002|cFFFFFFFF.|cFF9900000|cFFFFFFFF)|r",
	["AUTHOR"]  	= "|cff993366Silvanas|r",
	["ENABLED"]		= true,
	["ILENABLED"]	= true,
	["MLENABLED"]	= false,
}
--

--event that we will color
local ItemLinkRecolor_AllowedEvents = {
	["CHAT_MSG_CHANNEL"] 	= true,
	["CHAT_MSG_LOOT"] 		= true,
	["CHAT_MSG_OFFICER"] 	= true,
	["CHAT_MSG_PARTY"] 		= true,
	["CHAT_MSG_RAID"] 		= true,
	["CHAT_MSG_RAID_LEADER"]= true,
	["CHAT_MSG_SAY"] 		= true,
	["CHAT_MSG_WHISPER"] 	= true,
	["CHAT_MSG_YELL"] 		= true,
	["CHAT_MSG_GUILD"] 		= true,
}
--

--local hook pointer
local ILR_ItemLinkRecolor_OnEvent_Hook	--hooks chatframe events (needed to know the "this:")
--

--events array
local ItemLinkRecolorEventArray = {}
function ItemLinkRecolor_Event() ItemLinkRecolorEventArray[event]() end
--

-------------------
--event triggered--
-------------------
--onload
function ItemLinkRecolor_Load()
	--load up the custom coloring var
	--[[if not ItemLinkRecolor_Custom then
	    --Silvanas.Print("|cFFFF0000Warning:|r No Costum database detected")
		ItemLinkRecolor_Custom = {} --it has tobe a table to prevent errors further down
	else
	    Silvanas.Print("Costum table loaded")
	
	end
	--]]
	
	--register events
	ItemLinkRecolorEventArray = {
		["VARIABLES_LOADED"] 	= ItemLinkRecolor_Event_Variables_Loaded,
		["ADDON_LOADED"] 		= ItemLinkRecolor_Event_Addon_Loaded
	}
	this:RegisterEvent("VARIABLES_LOADED")
	this:RegisterEvent("ADDON_LOADED")

 	--set up commands
    Silvanas.AddCmd("ITEMLINKRECOLOR_CMD",ItemLinkRecolor_Cmd_ItemLinkRecolor,{"ilr","ItemLinkRecolor"})
end

---on event
--this is after ll saved variabled ar laoded back in mem
function ItemLinkRecolor_Event_Variables_Loaded()
    --function to reset saved variables
	local ItemLinkRecolorReset = function()
		ItemLinkRecolorSavedVars = {
		    ["VERSION"] = ItemLinkRecolor["VERSION"],
			["ENABLED"] = ItemLinkRecolor["ENABLED"],
			["ILENABLED"] = ItemLinkRecolor["ILENABLED"],
			["MLENABLED"] = ItemLinkRecolor["MLENABLED"],
		}
	end

	--basic chatframe event hook
	ILR_ItemLinkRecolor_OnEvent_Hook = ChatFrame_OnEvent
	ChatFrame_OnEvent = ItemLinkRecolor_ChatFrame_OnEvent

   	--load up saved variables
	if not ItemLinkRecolorSavedVars then
		--if there are no saved vars thne well relaod the default
		ItemLinkRecolorReset()
	else
	    if ItemLinkRecolorSavedVars["VERSION"] and ItemLinkRecolorSavedVars["VERSION"] == ItemLinkRecolor["VERSION"] then
	    	--if there are saved vars and they are saved under the good version then load em up
	    	ItemLinkRecolor["ENABLED"] = ItemLinkRecolorSavedVars["ENABLED"]
			ItemLinkRecolor["ILENABLED"] = ItemLinkRecolorSavedVars["ILENABLED"]
			ItemLinkRecolor["MLENABLED"] = ItemLinkRecolorSavedVars["MLENABLED"]	    	
		else
			--if there are saved vars but under the wrong version then reload the default
			ItemLinkRecolorReset()
		end
	end
	
	--loaded message
	Silvanas.Print(ItemLinkRecolor["NAME"] .." |cFFFFFFFFversion: ".. ItemLinkRecolor["VERSION"] .." |cFFFFFFFFloaded.|r")
end

--this is whenever an addon gets loaded, oO so quite a lot :(
function ItemLinkRecolor_Event_Addon_Loaded()
	--auctoineer doesnt like our moddified item names :( so we build deffierent string jsut for auctioneer
	if arg1 == "EnhTooltip" then
		ItemLinkRecolor_Auctioneer = true
	end
end	
-------------------
-------------------
-------------------

-----------------------
--chat hook functions--
-----------------------
--this function takes over the real "ChatFrame_OnEvent" and calls the real one afterwards
function ItemLinkRecolor_ChatFrame_OnEvent(event)
    --if we got this addon enabled
	if ItemLinkRecolor["ENABLED"] then
 		--if we allow this event
		if ItemLinkRecolor_AllowedEvents[event] then
			--if we got money coloring enabled
			if ItemLinkRecolor["MLENABLED"] then
  				--Parse money strings and return them in color
    			arg1 = string.gsub(arg1,"([|]-[c]-%x-[%.,gG]-%d+%s-[gGsScC]%a*)",ItemLinkRecolor_Moneyrize)
			end
			--if we got itemlink coloring enabled
			if ItemLinkRecolor["ILENABLED"] then
				--find an item links and return new colored ones
    			arg1 = string.gsub(arg1,"(|Hitem:%d+:%d+:%d+:%d+|h.-|h)",ItemLinkRecolor_Colorize)
    		end
		end
	end
	--Call the orriginal function
	ILR_ItemLinkRecolor_OnEvent_Hook(event)
end
-----------------------
-----------------------
-----------------------

----------------------
--coloring functions--
----------------------
function ItemLinkRecolor_Colorize(texty)
	--dont call print functions here else u overflow the stack use a text hook instead
	--text = string.format("|cFFFF0000H|cFFFFFFFF:|r %s",text)
	
	--parse elements of the link
	local _,_,link,itemnum = string.find(texty,"^|H(item:(%d+):%d+:%d+:%d+)|h")
	
	--Silvanas.Print(itemnum ..", ".. Silvanas.VarPrint(ItemLinkRecolor_Custom[itemnum]))
	
	--get the item atributes
	local itemnamereal,_,itemquality,itemlevel = GetItemInfo(link)
	local itemname = itemnamereal
	
	--if something went wrong ignore this chat link and return wutever text we recieved
	if type(itemquality) == "nil" then --cant just check if its tru since it can also be 0
		return texty
	end

	--get the quality color
	local itemqualitycolor = Silvanas.Select(4,GetItemQualityColor(itemquality))

	--custom stuff
	--[[if ItemLinkRecolor_Custom[itemnum] or ItemLinkRecolor_Custom[itemnamereal] then
	    Silvanas.print("Customizing")
		itemname = ItemLinkRecolor_Custom[itemnum].custom_itemname or ItemLinkRecolor_Custom[itemnamereal].custom_itemname or itemname
		itemqualitycolor = ItemLinkRecolor_Custom[itemnum].custom_itemcolor or ItemLinkRecolor_Custom[itemnamereal].custom_itemcolor or itemqualitycolor
	end
	--]]

	--build the level display
	local playerlevel = UnitLevel("player")
	local itemlevelcolor = nil

	--custom levelname
	--[[if (ItemLinkRecolor_Custom[itemnum] and ItemLinkRecolor_Custom[itemnum].custom_levelname) or (ItemLinkRecolor_Custom[itemnamereal] and ItemLinkRecolor_Custom[itemnamereal].custom_levelname) then
		itemlevel = ItemLinkRecolor_Custom[itemnum].custom_levelname or ItemLinkRecolor_Custom[itemnamereal].custom_levelname
	end
	--]]

    if itemlevel == 0 then
	    --items that dont have a min level
	    itemlevel = ""
	    itemlevelcolor = ""
	else
		--if it isnt a costum string
	    if type(itemlevel) == "number" then
			if itemlevel > (playerlevel + 5) then
				itemlevelcolor = "FF0000"
			elseif itemlevel > playerlevel then
	    		itemlevelcolor = "FF9933"
			elseif itemlevel == playerlevel then
	    		itemlevelcolor = "FFFF00"
			elseif itemlevel > (playerlevel - 5) then
	    		itemlevelcolor = "00FF00"
			else
	    		itemlevelcolor = "999999"
			end
		else
		    --default color for text type levlenames
			itemlevelcolor = "FFFFFF"
		end
		
		--custom level color
		--[[if (ItemLinkRecolor_Custom[itemnum] and ItemLinkRecolor_Custom[itemnum].custom_levelcolor) or (ItemLinkRecolor_Custom[itemnamereal] and ItemLinkRecolor_Custom[itemnamereal].custom_levelcolor) then
			itemlevelcolor = ItemLinkRecolor_Custom[itemnum].custom_levelcolor or ItemLinkRecolor_Custom[itemnamereal].custom_levelcolor
		end
		--]]
		
		--finish the itemlevelcolor
		itemlevelcolor = "|cFF".. itemlevelcolor
	end
	
	--check if we can use it or not
	local bracketcolor = nil
	
	--custom bracket colors
	--[[if ItemLinkRecolor_Custom[itemnum] or ItemLinkRecolor_Custom[itemnamereal] then
	    if type(ItemLinkRecolor_Custom[itemnum].custom_Equipable) == "nil" and type(ItemLinkRecolor_Custom[itemnamereal].custom_Equipable) == "nil" then
		elseif ItemLinkRecolor_Custom[itemnum].custom_Equipable or ItemLinkRecolor_Custom[itemnamereal].custom_Equipable then
		    bracketcolor = itemqualitycolor
		else
		    bracketcolor = "|cFFFF0000"
		end
	end
	--]]

	--if it isnt already se by the customiseable part
	if not bracketcolor then
    	if type(itemlevel) == "number" and itemlevel > playerlevel then
	    	--if the level is already to high then make the brackets red
    		bracketcolor = "|cFFFF0000"
		else
	    	--see if its Equipable
			if ItemLinkRecolor_CanEquip(link) then
				bracketcolor = itemqualitycolor
			else
	    		bracketcolor = "|cFFFF0000"
			end
		end
	end
	
	--build and return the return value
	if ItemLinkRecolor_Auctioneer then
		--auctoineer doesnt like our moddified item names :( so we build deffierent string jsut for auctioneer
		--so we leave the actual link as it is
		if type(itemlevel) == "string" and itemlevel == "" then
			--dont dispaly he level for item whitout a minuim level
			return "|r".. bracketcolor .."(|r".. itemqualitycolor .. texty .."|r".. bracketcolor ..")|r"
		else
			return "|r".. bracketcolor .."(|r".. itemlevelcolor .. itemlevel .."|r".. itemqualitycolor .. texty .."|r".. bracketcolor ..")|r"
		end
	else
		--else orriginal nicer way
		if type(itemlevel) == "string" and itemlevel == "" then
			--dont dispaly he level for item whitout a minuim level
			return "|r|H".. link .."|h".. bracketcolor .."[|r".. itemqualitycolor .. itemname .."|r".. bracketcolor .."]|r|h"
		else
			return "|r|H".. link .."|h".. bracketcolor .."[|r".. itemlevelcolor .."(".. itemlevel ..")|r" .. itemqualitycolor .. itemname .."|r".. bracketcolor .."]|r|h"
		end
	end
end

--the coloring fuction of money
function ItemLinkRecolor_Moneyrize(texty)
    --dont call print functions here else u overflow the stack use a text hook instead
	--text = string.format("|cFFFF0000H|cFFFFFFFF:|r %s",text)

	--if it isnt a g2g message
	if string.find(texty,"[gG]2[gG]") then
		return texty
	end
	
	--if its contains a color code
	local colorcode,returntext
	colorcode = Silvanas.Select(3,string.find(texty,"^|c(%x+)"))
	
	--if we are trying to color inside the colorcode then ignore this money and return wutever txt we had
	if colorcode then
		if string.len(colorcode) < 8 then
			return texty
		else
			--cut off the color code but still and it in the end
			colorcode = string.sub(texty,1,10)
			returntext = string.sub(texty,11)
		end
	else
	    returntext = texty
	    colorcode = ""
	end

    --parse money
    local _,_,money1,money2,moneytype,moneystr = string.find(texty,"^(%d-)[%.,]-(%d+)%s-([gGsScC])(%a*)$")
    
    --if something went wrong ignore this chat link and return wutever text we recieved
    if moneytype then
    	moneytype = string.upper(moneytype)
    else
    	--if something went wrong ignore this chat link and return wutever text we recieved
        return texty
    end
    
    --see if moneystr is part of an other word
    if moneystr ~= "" then
    	moneystr = string.lower(moneystr)
    	--see if our moneytype and moneystr are valid
    	if moneytype == "G" then
    		if moneystr ~= "old" then
				return texty
			end
		elseif moneytype == "S" then
		 	if moneystr ~= "ilver" then
				return texty
			end
		else
			if moneystr ~= "opper" then
				return texty
			end
		end
	end 
    
    --if there is no comma or dot but only 1 number
    if money1 == "" then
       	--if something went wrong ignore this chat link and return wutever text we recieved
		if money2 == "" then
            return texty
		end
		
		--if there is only 1 number then store it in money1 and make money2 0
        money1 = money2
        money2 = 0
	end
	
    --if something went wrong ignore this chat link and return wutever text we recieved
	if (money2 ~= 0) and (moneytype == "C") then
		--cant hace a comma when the moneytype is "C"'opper'
        return texty
	end

	--calc the money in copper
	local mcalc = {	["G"] = 10000,
        			["S"] = 100,
        			["C"] = 1,	}
        			
	local moneycopper = (tonumber(money1)*mcalc[moneytype]) + (tonumber(money2)*(mcalc[moneytype] / 100))

    --[[--TEMP FIX FOR NUFED COMBAT LOG
	--if money is 0 then ignore it
	if moneycopper == 0 then
	    return texty
	end--]]
	
    --get the player his money
	local playermoney = GetMoney()

	--do the money compare
	local quartplayermoney = playermoney / 4
	
 	if moneycopper > (playermoney*2) then
		local moneycoler = "FF0000"
	elseif moneycopper > playermoney then
	    local moneycoler = "FF9933"
	elseif (moneycopper <= playermoney) and (moneycopper > (quartplayermoney*3)) then
		local moneycoler = "FFFF00"
	elseif (moneycopper <= (quartplayermoney*3)) and (moneycopper > quartplayermoney) then
	    local moneycoler = "00FF00"
	else
	    local moneycoler = "999999"
	end

	--return the new text
	return "|cFF".. moneycoler .. returntext .."|r".. colorcode
end
----------------------
----------------------
----------------------

---------------------
--Checkup Functions--
---------------------
function ItemLinkRecolor_CanEquip(link)
   	--dont call print functions here else u overflow the stack use a text hook instead
	--text = string.format("|cFFFF0000H|cFFFFFFFF:|r %s",text)
	
	--tooltip scan function
	local ItemLinkRecolor_ToolTipTextIsRed = function(TooltipFrame)
		if TooltipFrame and TooltipFrame:IsVisible() then --dont scan colors of invisable frames
			--gets its colors
			local ttca,ttcr,ttcg,ttcb
			ttcr,ttcg,ttcb,ttca = TooltipFrame:GetTextColor()
			
      		--if its red then we assume we cant use this item (yes its not a clean and save way but it saves cpu usage)
			--if (ttcr == 0.99999780301005) and (ttcg == 0.12548992037773) and (ttcb == 0.12548992037773) and (ttca == 0.99999779462814) then
			if ttcr > 0.99999 and (ttcg > 0.125 and ttcg < 0.126) and (ttcb > 0.125 and ttcb < 0.126) and (ttca > 0.99999) then
				return true
			end
		end
		return false
	end 
	
	--first clear the tooltip
	ItemLinkRecolorScanningTooltip:ClearLines()
	
    --set the link
 	ItemLinkRecolorScanningTooltip:SetHyperlink(link)
  	
  	--oke we search in a hidden tooltip to find if there are any red lines so we cant use it :p
	local TooltipText
	local i
  	
	for i=1,ItemLinkRecolorScanningTooltip:NumLines(),1 do --go over each line
	    --get one left text object
		TooltipTextFrame = getglobal("ItemLinkRecolorScanningTooltipTextLeft".. i)
		
		--if the text is red we return false since we assume we cant Equip it
		if ItemLinkRecolor_ToolTipTextIsRed(TooltipTextFrame) then
			return false
		end
		
		if (i == 2) or (i == 3) then --2,3 RIGHT is the armor type
			--get the right text object
		    TooltipTextFrame = getglobal("ItemLinkRecolorScanningTooltipTextRight".. i)
			
			--if the text is red we return false since we assume we cant Equip it
 			if ItemLinkRecolor_ToolTipTextIsRed(TooltipTextFrame) then
				return false
			end	
		end
	end

	--if nothing in red was found we assume we can use use it
	return true
end

------------
--commands--
------------
function ItemLinkRecolor_Cmd_ItemLinkRecolor(msg)
	--if there is any parameter given to the command
	if msg ~= "" then
	    --to lower case so its nolonger case sensetive
		msg = string.lower(msg)
		
		--stringsub it so we only extract the part we need espacilay hand if u have multiple parameters
		if string.sub(msg,1,6) == "enable" then
			--set the vars
		    ItemLinkRecolor["ENABLED"] = true
		    ItemLinkRecolorSavedVars["ENABLED"] = true
		    
			--update mod intoo the silvanasaddonlib
    		Silvanas.AddMod(ItemLinkRecolor)
    		
    		--print the messsage
    		Silvanas.Print(ItemLinkRecolor["NAME"] .." Enabled")
    		return
				
        elseif string.sub(msg,1,7) == "disable" then
        	--set the vars
		    ItemLinkRecolor["ENABLED"] = false
		    ItemLinkRecolorSavedVars["ENABLED"] = false
		    
		    --update mod intoo the silvanasaddonlib
    		Silvanas.AddMod(ItemLinkRecolor)
    		
    		--print the messsage
    		Silvanas.Print(ItemLinkRecolor["NAME"] .." Disabled")
    		return
   	    	
		elseif string.sub(msg,1,8) == "itemlink" then
			if string.sub(msg,10,15) == "enable" then
				--set the vars
				ItemLinkRecolor["ILENABLED"] = true
				ItemLinkRecolorSavedVars["ILENABLED"] = true
				
		    	--update mod intoo the silvanasaddonlib
    			Silvanas.AddMod(ItemLinkRecolor)

				--print the messsage
    			Silvanas.Print(ItemLinkRecolor["NAME"] .." ItemLink Colering Enabled")
    			return
				
			elseif string.sub(msg,10,16) == "disable" then
				--set the vars
				ItemLinkRecolor["ILENABLED"] = false
				ItemLinkRecolorSavedVars["ILENABLED"] = false

		    	--update mod intoo the silvanasaddonlib
    			Silvanas.AddMod(ItemLinkRecolor)
    			
				--print the messsage
    			Silvanas.Print(ItemLinkRecolor["NAME"] .." ItemLink Colering Disabled")
    		    return
    		    
			end
		elseif string.sub(msg,1,5) == "money" then
			if string.sub(msg,7,13) == "enable" then
			    --set the vars
			    ItemLinkRecolor["MLENABLED"] = true
				ItemLinkRecolorSavedVars["MLENABLED"] = true

		    	--update mod intoo the silvanasaddonlib
    			Silvanas.AddMod(ItemLinkRecolor)
    			
				--print the messsage
    			Silvanas.Print(ItemLinkRecolor["NAME"] .." Money Colering Enabled")
    			return
    			
			elseif string.sub(msg,7,14) == "disable" then
		        --set the vars
		        ItemLinkRecolor["MLENABLED"] = false
				ItemLinkRecolorSavedVars["MLENABLED"] = false
				
		    	--update mod intoo the silvanasaddonlib
    			Silvanas.AddMod(ItemLinkRecolor)
    			
				--print the messsage
    			Silvanas.Print(ItemLinkRecolor["NAME"] .." Money Colering Disabled")
    			return
    			
			end
		elseif string.sub(msg,1,6) == "getnum" then
		    Silvanas.Print(string.gsub(msg,"|","!"))
		
			--get the number and name
			local x,inum,iname
			x,x,inum,iname = string.find(msg,"|hitem:(%d+):%d+:%d+:%d+|h(.-)|h",8)
			
			Silvanas.Print(Silvanas.VarPrint(inum) ..", ".. Silvanas.VarPrint(iname))
			
			--if we could find it
			if inum and iname then
				Silvanas.Print(ItemLinkRecolor["NAME"] ..": The ItemNumber of ".. iname .." is: ".. inum)						
			else
				Silvanas.Print(ItemLinkRecolor["NAME"] ..": Invalid itemlink")	
			end
			return
						
		end
	end
	--basic help display for unknown commands
	Silvanas.Print(ItemLinkRecolor["NAME"] .." |cFFFFFFFFversion: ".. ItemLinkRecolor["VERSION"] .." |cFF999999ItemLinkRecolor Options:")
   	Silvanas.Print("|cFF999999/ItemLinkRecolor (/ilr) |cFFFFFF99[option]|cFFFFFFFF: |cFF999999Sets |cFFFFFF99[option]")
    Silvanas.Print("|cFFFFFF99Enabled |cFFFFFFFF:Turns ".. ItemLinkRecolor["NAME"] .." |cFF9999FF[on]")
    Silvanas.Print("|cFFFFFF99Disabled |cFFFFFFFF:Turns ".. ItemLinkRecolor["NAME"] .." |cFF9999FF[off]")
	Silvanas.Print("|cFFFFFF99ItemLink Enabled|cFFFFFFFF:Turns ItemLink Coloring |cFF9999FF[on]")
	Silvanas.Print("|cFFFFFF99ItemLink Disabled|cFFFFFFFF:Turns ItemLink Coloring |cFF9999FF[off]")
	Silvanas.Print("|cFFFFFF99Money Enabled|cFFFFFFFF:Turns ItemLink Coloring |cFF9999FF[on]")
	Silvanas.Print("|cFFFFFF99Money Disabled|cFFFFFFFF:Turns Money Coloring |cFF9999FF[off]")
	Silvanas.Print("|cFFFFFF99GetNum <ItemLink>|cFFFFFFFF:Gets the ItemNumber out of the ItemLink")
end
------------
------------
------------