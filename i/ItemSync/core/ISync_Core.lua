--[[--------------------------------------------------------------------------------
  ItemSyncCore Core Framework

  Author:  Derkyle
  Website: http://www.manaflux.com
-----------------------------------------------------------------------------------]]

BINDING_HEADER_ITEMSYNC_HEADER = "ItemSync";

--Hook chat messages
local ISync_ChatMessageTypes = {
	"CHAT_MSG_SYSTEM",
	"CHAT_MSG_SAY",
	"CHAT_MSG_TEXT_EMOTE",
	"CHAT_MSG_YELL",
	"CHAT_MSG_WHISPER",
	"CHAT_MSG_PARTY",
	"CHAT_MSG_GUILD",
	"CHAT_MSG_OFFICER",
	"CHAT_MSG_CHANNEL",
	"CHAT_MSG_RAID",
	"CHAT_MSG",
	"CHAT_MSG_LOOT",
	"CHAT_MSG_EMOTE",
	"CHAT_MSG_WHISPER_INFORM",	
	"CHAT_MSG_MONSTER_EMOTE",
	"CHAT_MSG_MONSTER_SAY",
	"CHAT_MSG_MONSTER_WHISPER",
	"CHAT_MSG_MONSTER_YELL",

};

local ISync_lOriginal_MerchantFrame_Update;
local ISync_lOriginal_ChatEdit_OnTextChanged;

---------------------------------------------------
-- ISync:OnLoad()
---------------------------------------------------
function ISync:OnLoad()

	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("BANKFRAME_OPENED");
	this:RegisterEvent("AUCTION_ITEM_LIST_UPDATE");
	this:RegisterEvent("MERCHANT_SHOW");
	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
	this:RegisterEvent("ADDON_LOADED");

	--register chat types
	for index, value in ISync_ChatMessageTypes do
		this:RegisterEvent(value);
	end
	
	--Hook ChatEdit_OnTextChanged for type links
	ISync_lOriginal_ChatEdit_OnTextChanged = ChatEdit_OnTextChanged;
	ChatEdit_OnTextChanged = ISyncCore_ChatEdit_OnTextChanged;
	
	--Hook for the Merchant Prices
	ISync_lOriginal_MerchantFrame_Update = MerchantFrame_Update;
	MerchantFrame_Update = ISyncCore_MerchantFrame_Update;

	--load primary
	ISync:PrimaryLoad();

end




-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

---------------------------------------------------
-- ISync:GrabDataProfile()
---------------------------------------------------
function ISync:GrabDataProfile()
	
	--main attributes
	local RlmCount = ISync:SetVar({"REALMS","REALMCOUNT"}, 0); --check if not on
			 ISync:SetVar({"OPT","SERVER_MERGE"}, 1); --check if not on
	
	--first check realm stuff
	if(not GetCVar("realmName")) then return nil; end
	
	--get data
	local sRlm = string.gsub(GetCVar("realmName"), "^%s*(.-)%s*$", "%1");
	if(not sRlm) then return nil; end
	
	sRlm = string.upper(sRlm); --convert to uppercase
	
	if(not ISync:SetVar({"REALMS",sRlm}, RlmCount, "CHK")) then
		ISync:SetVar({"REALMS",sRlm}, RlmCount); --save
		ISync:SetVar({"REALMS","REALMCOUNT"}, RlmCount + 1, "TRUE"); --increment, TRUE = force
	end

	--create database if it doesn't exist
	if(not ISyncDB[RlmCount]) then ISyncDB[RlmCount] = { }; end
	
	--check if merged, if so then use the zero first realm
	if(ISync:SetVar({"OPT","SERVER_MERGE"}, 1) == 1) then return 0; else return tonumber(ISync:SetVar({"REALMS",sRlm}, RlmCount)); end
	
	
end


-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------


---------------------------------------------------
-- ISync:SetVar()
---------------------------------------------------
function ISync:SetVar(sArgs, nBool, sOpt)

	if(not sArgs or not nBool) then return nil; end
	if(type(sArgs) ~= "table") then return nil; end
	if(getn(sArgs) <= 0) then return nil; end
	if(getn(sArgs) > 2) then return nil; end


	if(sOpt and sOpt == "CHK") then
		if(ISyncOpt and ISyncOpt[sArgs[1]] and ISyncOpt[sArgs[1]][sArgs[2]]) then return 1; else return nil; end
	end
	
	
	if(sOpt and sOpt == "COMPARE") then
	
		if(ISyncOpt and ISyncOpt[sArgs[1]] and ISyncOpt[sArgs[1]][sArgs[2]]) then
		
			if(tostring(ISyncOpt[sArgs[1]][sArgs[2]]) == tostring(nBool)) then
				return 1;
			else
				return nil;
			end
			
		else 
			return nil; 
		end
	end
	
	
	if(not ISyncOpt) then ISyncOpt = {}; end
	if(not ISyncOpt[sArgs[1]]) then ISyncOpt[sArgs[1]] = {}; end
	if(not ISyncOpt[sArgs[1]][sArgs[2]]) then ISyncOpt[sArgs[1]][sArgs[2]] = nBool; end
	
	--force it
	if(sOpt) then
	
		sOpt = tostring(sOpt); --convert to string
	
		if( sOpt == "TRUE" or string.upper(sOpt) == "TRUE") then
	
			--force the change
			ISyncOpt[sArgs[1]][sArgs[2]] = nBool;

			return ISyncOpt[sArgs[1]][sArgs[2]];
		
		end
	end

	return ISyncOpt[sArgs[1]][sArgs[2]];
end



---------------------------------------------------
-- ISync:SetOpt()
---------------------------------------------------
function ISync:SetOpt(sFrame, sType, sArgs, nBool)

	if(not sFrame or not sType or not sArgs or not nBool) then return nil; end
	if(type(sArgs) ~= "table") then return nil; end
	if(getn(sArgs) <= 0) then return nil; end
	if(getn(sArgs) > 2) then return nil; end
	if(not tonumber(nBool)) then return nil; end

	nBool = tonumber(nBool) or 0;
	
	local iChk;
	
	--check if it's created or not, if so then return value
	if(not ISyncOpt or not ISyncOpt[sArgs[1]] or not ISyncOpt[sArgs[1]][sArgs[2]]) then
		iChk = ISync:SetVar(sArgs, nBool);
	else
		iChk = ISync:SetVar(sArgs, nBool, "TRUE");
	end

	if(not iChk) then iChk = 0; else iChk = tonumber(iChk); end
	
	--check types
	if(sType == "checkbutton") then
		sFrame:SetChecked(iChk);
	elseif(sType == "slider") then
		sFrame:SetValue(iChk);
	elseif(sType == "frame") then
		if(iChk == 0) then sFrame:Hide(); end
		if(iChk == 1) then sFrame:Show(); end
	end
		
		
	return iChk;

end



---------------------------------------------------
-- ISync:Chk()
---------------------------------------------------
function ISync:Chk(sName, sGet, sOperator, sNum)

	if(not ISyncDB) then return nil; end
	if(not sName or not sGet) then return nil; end
	
	if(not ISYNC_REALM_NUM) then ISync:GrabDataProfile(); end
	if(not ISYNC_REALM_NUM) then return nil; end
	
	if(not ISyncDB[ISYNC_REALM_NUM]) then return nil; end
	if(not ISyncDB[ISYNC_REALM_NUM][sName]) then return nil; end
	
	--if only sGet
	if(sGet and not sOperator) then
		return ISync:FetchDB(sName, sGet) or nil;
		
	--if get and operator then preform proper action
	elseif(sGet and sOperator) then
	
		local getNum = ISync:FetchDB(sName, sGet) or nil;
		
		if(not tonumber(sNum)) then return nil; end
		if(not getNum) then return nil; end
		if(not tonumber(getNum)) then return nil; end
		
		getNum = tonumber(getNum); --convert
	
		if(sOperator == "==") then
			if(getNum == sNum) then return 1; else return nil; end
			
		elseif(sOperator == "~=") then
			if(getNum ~= sNum) then return 1; else return nil; end
			
		elseif(sOperator == ">") then
			if(getNum > sNum) then return 1; else return nil; end
			
		elseif(sOperator == "<") then
			if(getNum < sNum) then return 1; else return nil; end
			
		elseif(sOperator == ">=") then
			if(getNum >= sNum) then return 1; else return nil; end
		
		elseif(sOperator == "<=") then
			if(getNum <= sNum) then return 1; else return nil; end
		else
			return nil;
		end
	
	
	else
		--we cannot have empty operators or empty values to compare.
		return nil;
	end


	return nil;
end



-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

---------------------------------------------------
-- ISync:Print()
---------------------------------------------------
function ISync:Print(sMsg)
	if(DEFAULT_CHAT_FRAME) then DEFAULT_CHAT_FRAME:AddMessage(sMsg); end
end


---------------------------------------------------
-- ISync:NameFromLink
---------------------------------------------------
function ISync:NameFromLink(sLink)

	local item, name;
	
	--check for link first
	if(not sLink) then return nil; end
	
	
	for item, name in string.gfind(sLink, "|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h") do

		if(name) then return name; end

	end--end for
	
	
	--try a different way
        for name in string.gfind(link, "|h%[(.-)%]|h") do
        
                if(name) then return name; end
        end

	
	return nil;
	
end


---------------------------------------------------
-- ISync:ReturnHexColor()
---------------------------------------------------
function ISync:ReturnHexColor(sNumQuality)

	sNumQuality = tonumber(sNumQuality);
	
	local QL_Colors = { "ff9d9d9d", "ffffffff", "ff1eff00", "ff0070dd", "ffa335ee", "ffff8000", "ffffcc9d"};
	
	local color = QL_Colors[sNumQuality + 1];
	
	return color;
end


---------------------------------------------------
-- ISync:ReturnHexColor()
---------------------------------------------------
function ISync:HexReturnQuality(sHexColor)
	
	local QL_Colors = {};
	QL_Colors["ff9d9d9d"] = 0;
	QL_Colors["ffffffff"] = 1;
	QL_Colors["ff1eff00"] = 2;
	QL_Colors["ff0070dd"] = 3;
	QL_Colors["ffa335ee"] = 4;
	QL_Colors["ffff8000"] = 5;
	QL_Colors["ffffcc9d"] = 6;
	
	local color = QL_Colors[sHexColor];
	
	if(not color) then color = 0; end
	
	return color;
end


---------------------------------------------------
-- ISync:GetItemID
---------------------------------------------------
function ISync:GetItemID(sLink)
	
	--check for link first
	if(not sLink) then return nil; end
	
	local item, name;

	if(string.find(sLink, "Hitem:")) then
	
		for item in string.gfind(sLink, "|Hitem:(%d+:%d+:%d+:%d+)|") do
			
			local item = string.gsub(item, "^(%d+):(%d+):(%d+):(%d+)$", "%1:0:%3:0");
			
			if(item) then
				return item;
			end

		end--end for
	end
	
	if(string.find(sLink, "item:")) then
		--try another way "item:0:0:0:0"
		item = string.gsub(sLink, "item:(%d+):(%d+):(%d+):(%d+)$", "%1:0:%3:0")
		if(item) then return item; end
	end
	
	--try another way "0:0:0:0"
	item = string.gsub(sLink, "(%d+):(%d+):(%d+):(%d+)$", "%1:0:%3:0")
	if(item) then return item; end
	
	--everything has failed so just ignore
	return nil;
	
end




---------------------------------------------------
-- ISync:GetCoreID
---------------------------------------------------
function ISync:GetCoreID(sLink)
	
	--check for link first
	if(not sLink) then return nil; end
	
	local item, name;
	
	if(string.find(sLink, "Hitem:")) then
	
		for item in string.gfind(sLink, "|Hitem:(%d+:%d+:%d+:%d+)|") do

			local item = string.gsub(item, "^(%d+):(%d+):(%d+):(%d+)$", "%1");
			
			if(item) then
				return tonumber(item);
			end

		end--end for
		
	end
	
	if(string.find(sLink, "item:")) then
		--try another way "item:0:0:0:0"
		item = string.gsub(sLink, "item:(%d+):(%d+):(%d+):(%d+)$", "%1")
		if(item) then return tonumber(item); end
	end
	
	--try another way "0:0:0:0"
	item = string.gsub(sLink, "(%d+):(%d+):(%d+):(%d+)$", "%1")
	if(item) then return tonumber(item); end
	
	--everything has failed so just ignore
	return nil;
	
end



-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

---------------------------------------------------
-- ISyncCore_MerchantFrame_Update
---------------------------------------------------
function ISyncCore_MerchantFrame_Update()
	ISync_lOriginal_MerchantFrame_Update(); --do original

	ISync:VendorScan(); --do a vendor scan
end



---------------------------------------------------
-- ISync:OnEvent()
---------------------------------------------------
function ISync:OnEvent()

	if( event == "PLAYER_LEAVING_WORLD" ) then
		ISync_CoreFrame:UnregisterEvent("UNIT_INVENTORY_CHANGED");
		ISync_CoreFrame:UnregisterEvent("BAG_UPDATE");
	end
	if( event == "PLAYER_ENTERING_WORLD" ) then
		ISync_CoreFrame:RegisterEvent("UNIT_INVENTORY_CHANGED");
		ISync_CoreFrame:RegisterEvent("BAG_UPDATE");
	end
	
	--pass to main framework
	ISync:OnPrimaryEvent(event,arg1,arg2,arg3,arg4,arg5);
	
end


---------------------------------------------------
-- ISync:OnUpdate()
---------------------------------------------------
function ISync:OnUpdate(elapsed)

	if(ISync and ISync.OnUpdateTriggered) then ISync:OnUpdateTriggered(elapsed); end

end

-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------


--TYPELINKS FUNCTIONS
--Inspired by Gazmik Fizzwidget

---------------------------------------------------
-- ISyncCore_ChatEdit_OnTextChanged()
---------------------------------------------------
function ISyncCore_ChatEdit_OnTextChanged()

	--check for options
	if(ISync:SetVar({"OPT","LINKFETCH"}, 1, "COMPARE")) then--show the tooltip icon
	
		local text = this:GetText();
		text = ISync:FetchLink_ParseChatMSG(text);    
		this:SetText(text);
		
	end

	return ISync_lOriginal_ChatEdit_OnTextChanged();
end



---------------------------------------------------
-- ISync:FetchLink_ParseChatMSG
---------------------------------------------------
function ISync:FetchLink_ParseChatMSG(text)
	return string.gsub(text, "([|]?[h]?)%[(.-)%]([|]?[h]?)", ISync_FetchLink_SetTextLink);
end



---------------------------------------------------
-- ISync_FetchLink_SetTextLink
---------------------------------------------------
function ISync_FetchLink_SetTextLink(head, text, tail)
	if (head ~= "|h" and tail ~= "|h") then
		local link = ISync:FetchLink_ReturnLink(text);
		if (link) then return link; end
	end
	return head.."["..text.."]"..tail;
end




---------------------------------------------------
-- ISync:FetchLink_ReturnLink
---------------------------------------------------
function ISync:FetchLink_ReturnLink(text)

	if(not ISyncDB_Names) then return nil; end

	--check
	for index, value in ISyncDB_Names do
	
		if(string.lower(value) == string.lower(text)) then
		
			local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X, equipType_X, iconTexture_X  = GetItemInfo("item:"..index..":0:0:0");
				
			if(name_X and link_X) then
			
				return "|c"..ISync:ReturnHexColor(quality_X).."|H"..link_X.."|h["..name_X.."]|h|r";
			
			end
			
		end--if(string.lower(value) == string.lower(text)) then
		
	end

	return nil;

end


