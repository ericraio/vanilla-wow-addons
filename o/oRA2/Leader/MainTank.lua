assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRALMainTank")
local tablet = AceLibrary("Tablet-2.0")
local paintchips = AceLibrary("PaintChips-2.0")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["maintank"] = true,
	["MainTank"] = true,
	["maintankleader"] = true,
	["mt"] = true,
	["Options for the maintanks."] = true,
	["set"] = true,
	["Set Maintank"] = true,
	["Set a maintank."]= true,
	["<nr> <name>"] = true,
	["<nr>"] = true,
	["<name>"] = true,
	["Remove Maintank"] = true,
	["remove"] = true,
	["Remove a maintank."] = true,
	["Removed maintank: "] = true,
	["Set maintank: "] = true,
	["Leader/MainTank"] = true,
	["Broadcast"] = true,
	["Broadcast Maintanks"] = true,
	["Send the raid your maintanks."] = true,

	["(%S+)%s*(.*)"] = true,

	["free"] = true,
	["Set target on a free mt-slot"] = true,
	["All"] = true,
	["Delete all Maintanks"] = true,
	
	["<Not Assigned>"] = true,

} end )

L:RegisterTranslations("koKR", function() return {

	["MainTank"] = "메인탱커",
	["Options for the maintanks."] = "메인탱커 설정",
	["Set Maintank"] = "메인탱커 지정",
	["Set a maintank."]= "메인탱커로 지정합니다",
	["<nr> <name>"] = "<번호> <이름>",
	["<nr>"] = "<번호>",
	["<name>"] = "<이름>",
	["Remove Maintank"] = "메인탱커 삭제",
	["Remove a maintank."] = "메인탱커에서 삭제합니다.",
	["Removed maintank: "] = "메인탱커 삭제: ",
	["Set maintank: "] = "메인탱커 설정: ",
	["Leader/MainTank"] = "공격대장/메인탱커",
	["Broadcast"] = "알림",
	["Broadcast Maintanks"] = "메인탱커 알림",
	["Send the raid your maintanks."] = "메인탱커를 공격대에 알립니다.",

	["(%S+)%s*(.*)"] = "(%d+)%s*(.*)",

	["free"] = "공란",
	["Set target on a free mt-slot"] = "대상을 공란에 지정합니다",
	["All"] = "모두",
	["Delete all Maintanks"] = "모든 메인탱커를 삭제합니다",

	
	["<Not Assigned>"] = "<미정의됨>",

} end )

L:RegisterTranslations("zhCN", function() return {
	["maintank"] = "MT目标",
	["MainTank"] = "MT目标",
	["maintankleader"] = "maintankleader",
	["mt"] = "MT目标",
	["Options for the maintanks."] = "MT目标选项",
	["set"] = "设置",
	["Set Maintank"] = "设定MT",
	["Set a maintank."]= "设定MT",
	["<nr> <name>"] = "<数量> <名字>",
	["<nr>"] = "<数量>",
	["<name>"] = "<名字>",
	["Remove Maintank"] = "移除MT",
	["remove"] = "移除",
	["Remove a maintank."] = "移除MT",
	["Removed maintank: "] = "移除MT：",
	["Set maintank: "] = "设定MT",
	["Leader/MainTank"] = "Leader/MainTank",
	["Broadcast"] = "广播",
	["Broadcast Maintanks"] = "广播MT",
	["Send the raid your maintanks."] = "向团队广播MT",

	["(%S+)%s*(.*)"] = "(%d+)%s*(.*)",

	["free"] = "空位",
	["Set target on a free mt-slot"] = "设定当前目标为下一个MT位置",
	["All"] = "全部",
	["Delete all Maintanks"] = "移除所有MT",

	["<Not Assigned>"] = "<还未设定>",

} end )

L:RegisterTranslations("zhTW", function() return {
	["maintank"] = "主坦",
	["MainTank"] = "主坦",
	["maintankleader"] = "maintankleader",
	["mt"] = "MT",
	["Options for the maintanks."] = "主坦選項",
	["set"] = "設定",
	["Set Maintank"] = "設定主坦",
	["Set a maintank."]= "設定一位主坦",
	["<nr> <name>"] = "<數量> <名字>",
	["<nr>"] = "<數量>",
	["<name>"] = "<名字>",
	["Remove Maintank"] = "移除主坦",
	["remove"] = "移除",
	["Remove a maintank."] = "移除一位主坦",
	["Removed maintank: "] = "移除主坦",
	["Set maintank: "] = "設定主坦: ",
	["Leader/MainTank"] = "領隊/主坦",
	["Broadcast"] = "廣播",
	["Broadcast Maintanks"] = "廣播主坦",
	["Send the raid your maintanks."] = "向團隊廣播主坦",

	["(%S+)%s*(.*)"] = "(%d+)%s*(.*)",

	["free"] = "空閒",
	["Set target on a free mt-slot"] = "設定目標至空閒主坦位置",
	["All"] = "全部",
	["Delete all Maintanks"] = "移除所有主坦",
	
	["<Not Assigned>"] = "<未設定>",

} end )

L:RegisterTranslations("frFR", function() return {
	--["maintank"] = true,
	["MainTank"] = "MainTank",
	--["maintankleader"] = true,
	--["mt"] = true,
	["Options for the maintanks."] = "Options concernant les maintanks.",
	--["set"] = true,
	["Set Maintank"] = "Ajouter un maintank",
	["Set a maintank."]= "Ajoute un maintank.",
	["<nr> <name>"] = "<n\194\176> <nom>",
	["<nr>"] = "<n\194\176>",
	["<name>"] = "<nom>",
	["Remove Maintank"] = "Enlever un maintank",
	--["remove"] = true,
	["Remove a maintank."] = "Enl\195\168ve un maintank.",
	["Removed maintank: "] = "Maintank enlev\195\169 : ",
	["Set maintank: "] = "Maintank ajout\195\169 : ",
	["Leader/MainTank"] = "Chef/MainTank",
	["Broadcast"] = "Diffuser",
	["Broadcast Maintanks"] = "Diffuser les maintanks",
	["Send the raid your maintanks."] = "Envoye vos maintanks au raid.",

	--["(%S+)%s*(.*)"] = true,

	--["free"] = true,
	["Set target on a free mt-slot"] = "Ajouter la cible \195\160 un emplacement libre des MTs",
	["All"] = "Tous",
	["Delete all Maintanks"] = "Supprime tous les maintanks.",

	["<Not Assigned>"] = "<Non assign\195\169>",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

oRALMainTank = oRA:NewModule(L["maintankleader"])
oRALMainTank.defaults = {
}
oRALMainTank.leader = true
oRALMainTank.name = L["Leader/MainTank"]
oRALMainTank.consoleCmd = L["mt"]
oRALMainTank.consoleOptions = {
	type = "group",
	desc = L["Options for the maintanks."],
	name = L["MainTank"],
	args = {
		[L["Broadcast"]] = {
			name = L["Broadcast Maintanks"], type = "execute",
			desc = L["Send the raid your maintanks."],
			func = function() oRALMainTank:Broadcast() end,
			disabled = function() return not oRA:IsModuleActive(oRALMainTank) or not oRALMainTank:IsValidRequest() end,
		},
		[L["set"]] = {
			name = L["Set Maintank"], type = "group",
			desc = L["Set a maintank."],
			disabled = function() return not oRA:IsModuleActive(oRALMainTank) or not oRALMainTank:IsValidRequest() end,
			args = {
				["1"] = {
					name = "1.", type = "text", desc = L["Set Maintank"].." 1",
					get = function() 
						if oRALMainTank.core.maintanktable[1] then return oRALMainTank.core.maintanktable[1]
						else return "" end
					end,
					set = function(v) oRALMainTank:Set("1 "..v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 1,
				},
				["2"] = {
					name = "2.", type = "text", desc = L["Set Maintank"].." 2",
					get = function() 
						if oRALMainTank.core.maintanktable[2] then return oRALMainTank.core.maintanktable[2]
						else return "" end
					end,
					set = function(v) oRALMainTank:Set("2 "..v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 2,
				},
				["3"] = {
					name = "3.", type = "text", desc = L["Set Maintank"].." 3",
					get = function() 
						if oRALMainTank.core.maintanktable[3] then return oRALMainTank.core.maintanktable[3]
						else return "" end
					end,
					set = function(v) oRALMainTank:Set("3 "..v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 3,
				},
				["4"] = {
					name = "4.", type = "text", desc = L["Set Maintank"].." 4",
					get = function() 
						if oRALMainTank.core.maintanktable[4] then return oRALMainTank.core.maintanktable[4]
						else return "" end
					end,
					set = function(v) oRALMainTank:Set("4 "..v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 4,
				},
				["5"] = {
					name = "5.", type = "text", desc = L["Set Maintank"].." 5",
					get = function() 
						if oRALMainTank.core.maintanktable[5] then return oRALMainTank.core.maintanktable[5]
						else return "" end
					end,
					set = function(v) oRALMainTank:Set("5 "..v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 5,
				},
				["6"] = {
					name = "6.", type = "text", desc = L["Set Maintank"].." 6",
					get = function() 
						if oRALMainTank.core.maintanktable[6] then return oRALMainTank.core.maintanktable[6]
						else return "" end
					end,
					set = function(v) oRALMainTank:Set("6 "..v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 6,
				},
				["7"] = {
					name = "7.", type = "text", desc = L["Set Maintank"].." 7",
					get = function() 
						if oRALMainTank.core.maintanktable[7] then return oRALMainTank.core.maintanktable[7]
						else return "" end
					end,
					set = function(v) oRALMainTank:Set("7 "..v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 7,
				},
				["8"] = {
					name = "8.", type = "text", desc = L["Set Maintank"].." 8",
					get = function() 
						if oRALMainTank.core.maintanktable[8] then return oRALMainTank.core.maintanktable[8]
						else return "" end
					end,
					set = function(v) oRALMainTank:Set("8 "..v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 8,
				},
				["9"] = {
					name = "9.", type = "text", desc = L["Set Maintank"].." 9",
					get = function() 
						if oRALMainTank.core.maintanktable[9] then return oRALMainTank.core.maintanktable[9]
						else return "" end
					end,
					set = function(v) oRALMainTank:Set("9 "..v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 9,
				},
				["10"] = {
					name = "10.", type = "text", desc = L["Set Maintank"].." 10",
					get = function() 
						if oRALMainTank.core.maintanktable[10] then return oRALMainTank.core.maintanktable[10]
						else return "" end
					end,
					set = function(v) oRALMainTank:Set("10 "..v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 10,
				},
				["free"] = {
					name = L["free"], type = "execute", desc = L["Set target on a free mt-slot"],
					func = function()
						if not UnitExists("target") then
							return
						end
						if not UnitInRaid("target") then
							return
						end
						name = UnitName("target")
						for i=1, 10 do
							if not oRALMainTank.core.maintanktable[i] then
								oRALMainTank:Set(i.." "..name)
								break
							end
						end
					end,
					order = 11,
				}
			}
		},
		[L["remove"]] = {
			name = L["Remove Maintank"], type = "group",
			desc = L["Remove a maintank."],
			disabled = function() return not oRA:IsModuleActive(oRALMainTank) or not oRALMainTank:IsValidRequest() end,
			args = {
				["1"] = {
					name = "1.", type = "execute", desc = L["Remove Maintank"].." 1",
					func = function() oRALMainTank:Remove("1") end,
					disabled = function() return not oRALMainTank.core.maintanktable[1] end,
					order = 1,
				},				
				["2"] = {
					name = "2.", type = "execute", desc = L["Remove Maintank"].." 2",
					func = function() oRALMainTank:Remove("2") end,
					disabled = function() return not oRALMainTank.core.maintanktable[2] end,
					order = 2,
				},
				["3"] = {
					name = "3.", type = "execute", desc = L["Remove Maintank"].." 3",
					func = function() oRALMainTank:Remove("3") end,
					disabled = function() return not oRALMainTank.core.maintanktable[3] end,
					order = 3,
				},
				["4"] = {
					name = "4.", type = "execute", desc = L["Remove Maintank"].." 4",
					func = function() oRALMainTank:Remove("4") end,
					disabled = function() return not oRALMainTank.core.maintanktable[4] end,
					order = 4,
				},
				["5"] = {
					name = "5.", type = "execute", desc = L["Remove Maintank"].." 5",
					func = function() oRALMainTank:Remove("5") end,
					disabled = function() return not oRALMainTank.core.maintanktable[5] end,
					order = 5,
				},
				["6"] = {
					name = "6.", type = "execute", desc = L["Remove Maintank"].." 6",
					func = function() oRALMainTank:Remove("6") end,
					disabled = function() return not oRALMainTank.core.maintanktable[6] end,
					order = 6,
				},
				["7"] = {
					name = "7.", type = "execute", desc = L["Remove Maintank"].." 7",
					func = function() oRALMainTank:Remove("7") end,
					disabled = function() return not oRALMainTank.core.maintanktable[7] end,
					order = 7,
				},
				["8"] = {
					name = "8.", type = "execute", desc = L["Remove Maintank"].." 8",
					func = function() oRALMainTank:Remove("8") end,
					disabled = function() return not oRALMainTank.core.maintanktable[8] end,
					order = 8,
				},
				["9"] = {
					name = "9.", type = "execute", desc = L["Remove Maintank"].." 9",
					func = function() oRALMainTank:Remove("9") end,
					disabled = function() return not oRALMainTank.core.maintanktable[9] end,
					order = 9,
				},
				["10"] = {
					name = "10.", type = "execute", desc = L["Remove Maintank"].." 10",
					func = function() oRALMainTank:Remove("10") end,
					disabled = function() return not oRALMainTank.core.maintanktable[10] end,
					order = 10,
				},
				["all"] = {
					name = L["All"], type="execute", desc = L["Delete all Maintanks"],
					func = function()
						for i=1, 10 do
							oRALMainTank:Remove(i)
						end
					end,
					order = 10,
				}
			}
		}
	}
}


------------------------------
--      Initialization      --
------------------------------

function oRALMainTank:OnEnable()
	if not self.core.maintanktable then 
		self.core.maintanktable = self.core.db.profile.maintanktable or {}
	end
	self:RegisterEvent("oRA_SendVersion")
	self:RegisterEvent("oRA_MainTankUpdate")
	self:RegisterEvent("oRA_JoinedRaid", "oRA_MainTankUpdate")
	self:RegisterEvent("RosterLib_RosterChanged", function() self:oRA_MainTankUpdate() end)	
end

function oRALMainTank:OnDisable()
	self:UnregisterAllEvents()
end

-------------------------------
--       Event Handlers      --
-------------------------------

function oRALMainTank:oRA_SendVersion()
	if (not IsRaidLeader()) then return end
	self:Broadcast()
end

function oRALMainTank:oRA_MainTankUpdate( maintanktable )
	if not maintanktable then maintanktable = self.core.maintanktable end
	for k = 1, 10, 1 do
				self.core.consoleOptions.args[L["mt"]].args[L["remove"]].args[tostring(k)].name = tostring(k).."."
				self.core.consoleOptions.args[L["mt"]].args[L["set"]].args[tostring(k)].name = tostring(k).."."
	end
	for k,v in pairs(maintanktable) do
		if self:IsValidRequest(v,true) then
				self.core.consoleOptions.args[L["mt"]].args[L["remove"]].args[tostring(k)].name = tostring(k)..". "..v
				self.core.consoleOptions.args[L["mt"]].args[L["set"]].args[tostring(k)].name = tostring(k)..". "..v
		end
	end
end

-------------------------------
--      Command Handlers     --
-------------------------------

function oRALMainTank:Set( text )
	if not self:IsPromoted() then return end
	if not text or text == "" then return end
	local _, _, num, name = string.find(text, L["(%S+)%s*(.*)"]) -- split locals
	if not num then return end

	num = tonumber(num)
	if not name or name == "" then name = UnitName("target") end
	
	-- lower the name and upper the first letter, not for chinese and korean though
	if GetLocale() ~= "zhTW" and GetLocale() ~= "zhCN" and GetLocale() ~= "koKR" then
		local _, len = string.find(name, "[%z\1-\127\194-\244][\128-\191]*")
		name = string.upper(string.sub(name, 1, len)) .. string.lower(string.sub(name, len + 1))
	end

	if not self:IsValidRequest(name, true) then return end
	
	self:SendMessage( "SET " .. num .. " " .. name )
	self:Print(L["Set maintank: "] .. "[".. num .. "] [" .. name .."]")
end

function oRALMainTank:Remove( num )
	if not self:IsPromoted() then return end
	if not num then return end
	num = tonumber(num)
	local name = self.core.maintanktable[num]
	if not name then return end
	self:SendMessage( "R "..name )
	self:Print(L["Removed maintank: "] .. num .." "..name )
end


function oRALMainTank:Broadcast()
	for k,v in pairs(self.core.maintanktable) do
		if self:IsValidRequest(v,true) then self:SendMessage("SET "..k.." "..v) end
	end
end

function oRALMainTank:TooltipClick( num )
	if not num then return end
	num = tonumber(num)
	local name = UnitName("target")
	if self.core.maintanktable[num] then
		if not name then self:Remove(num)
		else self:Set( num .." ".. name ) end	
	else
		if name then self:Set( num .." ".. name ) end
	end
end

------------------------------
--      Tooltip Updating    --
------------------------------

function oRALMainTank:OnTooltipUpdate()
	if not self:IsPromoted() then return end
	local cat = tablet:AddCategory("columns", 2, "text", "#", "justify", "LEFT", "text2", L["MainTank"], "justify2", "LEFT", "child_justify", "LEFT", "child_justify2", "LEFT" )
	local p 
	for k = 1, 10, 1 do
		p = self.core.maintanktable[k]
		if p then
			if self:IsValidRequest( p, true ) then
				local unit = self.core.roster:GetUnitIDFromName(p)
				local _, class = UnitClass( unit )
				cat:AddLine( "text", tostring(k)..". ", "text2", "|cff"..paintchips:GetHex(class) .. p.."|r", "func", self.TooltipClick, "arg1", self, "arg2", k)
			else
				cat:AddLine( "text", tostring(k)..". ", "text2", "|cffcccccc<"..p..">|r", "func", self.TooltipClick, "arg1", self, "arg2", k)
			end
		else
			cat:AddLine( "text", tostring(k)..". ", "text2", "|cffcccccc"..L["<Not Assigned>"].."|r", "func", self.TooltipClick, "arg1", self, "arg2", k)
		end
	end
end