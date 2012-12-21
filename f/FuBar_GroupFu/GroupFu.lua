local dewdrop = DewdropLib:GetInstance('1.0');
local tablet = TabletLib:GetInstance('1.0');
local metrognome = Metrognome:GetInstance("1");
local babble = BabbleLib:GetInstance("1.0");

GroupFu = FuBarPlugin:new({
	name				= GroupFuLocals.NAME,
	description			= GroupFuLocals.DESCRIPTION,
	version				= "1.4.7.4",
	releaseDate			= "2006-07-10",
	aceCompatible		= 103,
	fuCompatible		= 102,
	author				= "Etten",
	email				= "idbrain@gmail.com",
	website				= "http://etten.wowinterface.com",
	category			= "interface",
	db					= AceDatabase:new("GroupFuDB"),
	defaults = {
		RollOnClick = true,
		ShowMLName = false,
		OutputChannel = "PARTY",
		OutputDetail = "SHORT",
		ClearTimer = 30,
		StandardRollsOnly = true,
		ShowRollCount = false,
		AnnounceRollCountdown = false,
		IgnoreDuplicates = true,
		DeleteRolls = true,
		ShowClassLevel = false,
		TextMode = "GROUPFU",
		LootColorTable = {}
	},
	hasIcon				= GroupFuLocals.DEFAULT_ICON,
	clickableTooltip	= true,
	cannotDetachTooltip = false,
	canHideText			= true,
	updateTime			= 1.0,
	
	-- Localization Tags
	loc = GroupFuLocals,

	ENDGROUPFU = true
});
	
function GroupFu:Initialize()
	
    if self.data.version < self.versionNumber then
        self.data.Colors = nil;
		self.data.Rolls = nil;
		self.data.RollCount = nil;
		self.data.Threshold = nil;
		self.data.LootType = nil;
    end

	if not self.tmpdata then
		self.tmpdata = {};
	end

end

function GroupFu:Enable()
	self:RegisterEvent("CHAT_MSG_SYSTEM");
	self:RegisterEvent("PARTY_MEMBERS_CHANGED", "Update");
	self:RegisterEvent("PARTY_LOOT_METHOD_CHANGED", "Update");
	self:RegisterEvent("RAID_ROSTER_UPDATE", "Update");
	
	if not self.data.LootColorTable or table.getn(self.data.LootColorTable) == 0 then
		for i=0,6 do
			local r, g, b, hex = GetItemQualityColor(i);
			self.data.LootColorTable[i] = 
				{ 
					Red = r, 
					Green = g,
					Blue = b,
					Hex = hex,
					Threshold = i,
					Desc = getglobal("ITEM_QUALITY".. i .. "_DESC")
				};
		end
	end

	self:ClearRolls();
	self.tmpdata.TimeSinceLastRoll = 0;
	metrognome:Register("MGtimer", self.CheckRollTimeout, self.updateTime, self);
	metrognome:Start("MGtimer");
end

function GroupFu:Disable()
	self:ClearRolls();
	metrognome:Stop("MGtimer");
end

function GroupFu:MenuSettings(level, value, inTooltip)
	if not inTooltip then
		if level == 1 then
		
			dewdrop:AddLine(
				'text', self.loc.MENU_OUTPUT,
				'value', "MENU_OUTPUT",
				'hasArrow', true
			);

			dewdrop:AddLine(
				'text', self.loc.MENU_CLEAR,
				'value', "MENU_CLEAR",
				'hasArrow', true
			);

			dewdrop:AddLine(
				'text', self.loc.MENU_DETAIL,
				'value', "MENU_DETAIL",
				'hasArrow', true
			);

			dewdrop:AddLine(
				'text', self.loc.MENU_MODE,
				'value', "MENU_MODE",
				'hasArrow', true
			);

			dewdrop:AddLine(
				'text', self.loc.MENU_PERFORMROLL,
				'value', self.loc.MENU_PERFORMROLL,
				'func', function() self:ToggleOption("RollOnClick") end,
				'checked', self.data.RollOnClick
			);
						
			dewdrop:AddLine(
				'text', self.loc.MENU_STANDARDROLLSONLY,
				'value', self.loc.MENU_STANDARDROLLSONLY,
				'func', function() self:ToggleOption("StandardRollsOnly") end,
				'checked', self.data.StandardRollsOnly
			);	

			dewdrop:AddLine(
				'text', self.loc.MENU_SHOWROLLCOUNT,
				'value', self.loc.MENU_SHOWROLLCOUNT,
				'func', function() self:ToggleOption("ShowRollCount") end,
				'checked', self.data.ShowRollCount
			);	

			dewdrop:AddLine(
				'text', self.loc.MENU_IGNOREDUPES,
				'value', self.loc.MENU_IGNOREDUPES,
				'func', function() self:ToggleOption("IgnoreDuplicates") end,
				'checked', self.data.IgnoreDuplicates
			);

			dewdrop:AddLine(
				'text', self.loc.MENU_AUTODELETE,
				'value', self.loc.MENU_AUTODELETE,
				'func', function() self:ToggleOption("DeleteRolls") end,
				'checked', self.data.DeleteRolls
			);

			dewdrop:AddLine(
				'text', self.loc.MENU_ANNOUNCEROLLCOUNTDOWN,
				'value', self.loc.MENU_ANNOUNCEROLLCOUNTDOWN,
				'func', function() self:ToggleOption("AnnounceRollCountdown") end,
				'checked', self.data.AnnounceRollCountdown
			);

			dewdrop:AddLine(
				'text', self.loc.MENU_SHOWCLASSLEVEL,
				'value', self.loc.MENU_SHOWCLASSLEVEL,
				'func', function() self:ToggleOption("ShowClassLevel") end,
				'checked', self.data.ShowClassLevel
			);

			dewdrop:AddLine(
				'text', self.loc.MENU_SHOWMLNAME,
				'value', self.loc.MENU_SHOWMLNAME,
				'func', function() self:ToggleOption("ShowMLName") end,
				'checked', self.data.ShowMLName
			);

			dewdrop:AddLine(
				'text', self.loc.MENU_GROUP,
				'value', "MENU_GROUP",
				'hasArrow', true
			);

		elseif level == 2 then
		
			if value == "MENU_OUTPUT" then
			
				dewdrop:AddLine(
					'text', self.loc.MENU_OUTPUT_AUTO,
					'value', "AUTO",
					'func', function() self:ToggleOutputChannel("AUTO") end,
					'isRadio', true,
					'checked', self:IsOutputChannel("AUTO")
				);
				
				dewdrop:AddLine(
					'text', self.loc.MENU_OUTPUT_LOCAL,
					'value', "LOCAL",
					'func', function() self:ToggleOutputChannel("LOCAL") end,
					'isRadio', true,
					'checked', self:IsOutputChannel("LOCAL")
				);
				
				dewdrop:AddLine(
					'text', self.loc.MENU_OUTPUT_SAY,
					'value', "SAY",
					'func', function() self:ToggleOutputChannel("SAY") end,
					'isRadio', true,
					'checked', self:IsOutputChannel("SAY")
				);
				
				dewdrop:AddLine(
					'text', self.loc.MENU_OUTPUT_PARTY,
					'value', "PARTY",
					'func', function() self:ToggleOutputChannel("PARTY") end,
					'isRadio', true,
					'checked', self:IsOutputChannel("PARTY")
				);
				
				dewdrop:AddLine(
					'text', self.loc.MENU_OUTPUT_RAID,
					'value', "RAID",
					'func', function() self:ToggleOutputChannel("RAID") end,
					'isRadio', true,
					'checked', self:IsOutputChannel("RAID")
				);
				
				dewdrop:AddLine(
					'text', self.loc.MENU_OUTPUT_GUILD,
					'value', "GUILD",
					'func', function() self:ToggleOutputChannel("GUILD") end,
					'isRadio', true,
					'checked', self:IsOutputChannel("GUILD")
				);
				
			elseif value == "MENU_CLEAR" then
			
				dewdrop:AddLine(
					'text', self.loc.MENU_CLEAR_NEVER,
					'value', 0,
					'func', function() self:ToggleClearTimer(0) end,
					'isRadio', true,
					'checked', self:IsClearTimer(0)
				);
				
				dewdrop:AddLine(
					'text', self.loc.MENU_CLEAR_15SEC,
					'value', 15,
					'func', function() self:ToggleClearTimer(15) end,
					'isRadio', true,
					'checked', self:IsClearTimer(15)
				);
				
				dewdrop:AddLine(
					'text', self.loc.MENU_CLEAR_30SEC,
					'value', 30,
					'func', function() self:ToggleClearTimer(30) end,
					'isRadio', true,
					'checked', self:IsClearTimer(30)
				);
				
				dewdrop:AddLine(
					'text', self.loc.MENU_CLEAR_45SEC,
					'value', 45,
					'func', function() self:ToggleClearTimer(45) end,
					'isRadio', true,
					'checked', self:IsClearTimer(45)
				);
				
				dewdrop:AddLine(
					'text', self.loc.MENU_CLEAR_60SEC,
					'value', 60,
					'func', function() self:ToggleClearTimer(60) end,
					'isRadio', true,
					'checked', self:IsClearTimer(60)
				);
				
			elseif value == "MENU_DETAIL" then
			
				dewdrop:AddLine(
					'text', self.loc.MENU_DETAIL_SHORT,
					'value', "SHORT",
					'func', function() self:ToggleOutputDetail("SHORT") end,
					'isRadio', true,
					'checked', self:IsOutputDetail("SHORT")
				);
				
				dewdrop:AddLine(
					'text', self.loc.MENU_DETAIL_LONG,
					'value', "LONG",
					'func', function() self:ToggleOutputDetail("LONG") end,
					'isRadio', true,
					'checked', self:IsOutputDetail("LONG")
				);
				
				dewdrop:AddLine(
					'text', self.loc.MENU_DETAIL_FULL,
					'value', "FULL",
					'func', function() self:ToggleOutputDetail("FULL") end,
					'isRadio', true,
					'checked', self:IsOutputDetail("FULL")
				);
				
			elseif value == "MENU_MODE" then
			
				dewdrop:AddLine(
					'text', self.loc.MENU_MODE_GROUPFU,
					'value', "GROUPFU",
					'func', function() self:ToggleTextMode("GROUPFU") end,
					'isRadio', true,
					'checked', self:IsTextMode("GROUPFU")
				);
				
				dewdrop:AddLine(
					'text', self.loc.MENU_MODE_ROLLSFU,
					'value', "ROLLSFU",
					'func', function() self:ToggleTextMode("ROLLSFU") end,
					'isRadio', true,
					'checked', self:IsTextMode("ROLLSFU")
				);
				
				dewdrop:AddLine(
					'text', self.loc.MENU_MODE_LOOTTYFU,
					'value', "LOOTTYFU",
					'func', function() self:ToggleTextMode("LOOTTYFU") end,
					'isRadio', true,
					'checked', self:IsTextMode("LOOTTYFU")
				);
				
			elseif value == "MENU_GROUP" then
			
				dewdrop:AddLine(
					'text', self.loc.MENU_GROUP_LEAVE,
					'value', "MENU_GROUP_LEAVE",
					'func', function() LeaveParty() end,
					'notCheckable', true
				);
				
				if IsPartyLeader() or IsRaidLeader() then
				
					dewdrop:AddLine(
						'text', self.loc.MENU_GROUP_RAID,
						'value', "MENU_GROUP_RAID",
						'func', function() ConvertToRaid() end,
						'notCheckable', true
					);
					
					dewdrop:AddLine(
						'text', self.loc.MENU_GROUP_LOOT,
						'value', "MENU_GROUP_LOOT",
						'hasArrow', true
					);

					dewdrop:AddLine(
						'text', self.loc.MENU_GROUP_THRESHOLD,
						'value', "MENU_GROUP_THRESHOLD",
						'hasArrow', true
					);
					
				end
			end
			
		elseif level == 3 then
		
			if value == "MENU_GROUP_LOOT" then
			
				dewdrop:AddLine(
					'text', self.loc.TEXT_GROUP,
					'value', "TEXT_GROUP",
					'func', function() self:SetLootType("group") end,
					'isRadio', true,
					'checked', self:IsLootType("group")
				);
				
				dewdrop:AddLine(
					'text', self.loc.TEXT_FFA,
					'value', "TEXT_FFA",
					'func', function() self:SetLootType("freeforall") end,
					'isRadio', true,
					'checked', self:IsLootType("freeforall")
				);
				
				dewdrop:AddLine(
					'text', self.loc.TEXT_MASTER,
					'value', "TEXT_MASTER",
					'func', function() self:SetLootType("master") end,
					'isRadio', true,
					'checked', self:IsLootType("master")
				);
				
				dewdrop:AddLine(
					'text', self.loc.TEXT_NBG,
					'value', "TEXT_NBG",
					'func', function() self:SetLootType("needbeforegreed") end,
					'isRadio', true,
					'checked', self:IsLootType("needbeforegreed")
				);
				
				dewdrop:AddLine(
					'text', self.loc.TEXT_RR,
					'value', "TEXT_RR",
					'func', function() self:SetLootType("roundrobin") end,
					'isRadio', true,
					'checked', self:IsLootType("roundrobin")
				);
				
			elseif value == "MENU_GROUP_THRESHOLD" then
				local mnuGroupThrshldDesc, mnuGroupThrshldThrshld, mnuGroupThrshldHex
				for j=0,6 do
					
					mnuGroupThrshldDesc = self.data.LootColorTable[j].Desc;
					mnuGroupThrshldThrshld = self.data.LootColorTable[j].Threshold;
					mnuGroupThrshldHex = self.data.LootColorTable[j].Hex;

					dewdrop:AddLine(
						'text', format("%s%s", mnuGroupThrshldHex, mnuGroupThrshldDesc .. "(" .. mnuGroupThrshldThrshld .. ")"),
						'func', function(val) self:SetLootThreshold(val) end,
						'arg1', mnuGroupThrshldThrshld,
						'isRadio', true,
						'checked', self:IsLootThreshold(mnuGroupThrshldThrshld)
					);

				end
			end
		end
	end
end

function GroupFu:UpdateData()
	if (GetNumPartyMembers() > 0) or (GetNumRaidMembers() > 0) then
		self.tmpdata.LootType = GetLootMethod();
		self.tmpdata.Threshold = GetLootThreshold();
	else
		self.tmpdata.LootType, self.tmpdata.Threshold = nil, nil;
	end
	
	local i, highRoll, rollLink;
	highRoll = 0;
	if(self.tmpdata.RollCount > 0) then
	
		for i = 1, self.tmpdata.RollCount do
		
			if ((self.tmpdata.Rolls[i].Roll > highRoll) and ((not self.data.StandardRollsOnly) or ((self.tmpdata.Rolls[i].Min == 1) and (self.tmpdata.Rolls[i].Max == 100))))  then
			
				highRoll = self.tmpdata.Rolls[i].Roll;
				rollLink = i;
				
			end
		end
		
		self.tmpdata.LastWinner = self.tmpdata.Rolls[rollLink].Player .. " [" .. FuBarUtils.Colorize("00FF00", highRoll) .. "]";
		
		if((self.tmpdata.Rolls[rollLink].Min ~= 1) or (self.tmpdata.Rolls[rollLink].Max ~= 100)) then
		
			self.tmpdata.LastWinner = self.tmpdata.LastWinner .. " (" .. self.tmpdata.Rolls[rollLink].Min .. "-" .. self.tmpdata.Rolls[rollLink].Max .. ")";
			
		end
		
	else
	
		self.tmpdata.LastWinner = nil;
		
	end
end

function GroupFu:UpdateText()
	if self.data.TextMode == "ROLLSFU" then
	
		if self.tmpdata.LastWinner ~= nil then
		
			if self.data.ShowRollCount then
			
				if GetNumRaidMembers() > 0 then
				
					self:SetText( string.format(self.loc.FORMAT_TEXT_ROLLCOUNT, self.tmpdata.LastWinner, self.tmpdata.RollCount, GetNumRaidMembers()) );
				
				elseif GetNumPartyMembers() > 0 then
				
					self:SetText( string.format(self.loc.FORMAT_TEXT_ROLLCOUNT, self.tmpdata.LastWinner, self.tmpdata.RollCount, GetNumPartyMembers()+1) );
				
				else
				
					self:SetText(self.tmpdata.LastWinner);
				
				end
			
			else
				
				self:SetText(self.tmpdata.LastWinner);
				
			end
			
		else
		
			self:SetText(self.loc.TEXT_NOROLLS);
			
		end	
		
	elseif self.data.TextMode == "LOOTTYFU" then
	
			if self.tmpdata.LootType == solo then
				self:SetText(string.format("%s%s", "|cff888888", self:GetLootTypeText()));
			else
				if not self.tmpdata.Threshold then
					self:UpdateData();
				end
				self:SetText(string.format("%s%s", self.data.LootColorTable[self.tmpdata.Threshold].Hex, self:GetLootTypeText()));
			end
		
	else
	
		if self.tmpdata.LastWinner ~= nil then
		
			if self.data.ShowRollCount then
			
				if GetNumRaidMembers() > 0 then
				
					self:SetText( string.format(self.loc.FORMAT_TEXT_ROLLCOUNT, self.tmpdata.LastWinner, self.tmpdata.RollCount, GetNumRaidMembers()) );
				
				elseif GetNumPartyMembers() > 0 then
				
					self:SetText( string.format(self.loc.FORMAT_TEXT_ROLLCOUNT, self.tmpdata.LastWinner, self.tmpdata.RollCount, GetNumPartyMembers()+1) );
				
				else
				
					self:SetText(self.tmpdata.LastWinner);
				
				end
			
			else
				
				self:SetText(self.tmpdata.LastWinner);
				
			end
			
		else
		
			if self.tmpdata.LootType == solo then
				self:SetText(string.format("%s%s", "|cff888888", self:GetLootTypeText()));
			else
				if not self.tmpdata.Threshold then
					self:UpdateData();
				end
				self:SetText(string.format("%s%s", self.data.LootColorTable[self.tmpdata.Threshold].Hex, self:GetLootTypeText()));
			end
			
		end
	end
end

function GroupFu:UpdateTooltip()
	
	local cat;
	
	cat = tablet:AddCategory(
		'text', self.loc.TOOLTIP_CAT_LOOTING,
		'columns', 2
	);
	
	if self.tmpdata.LootType == "group" then
	
		if not self.tmpdata.Threshold then
			self:UpdateData();
		end
		cat:AddLine(
			'text', self.loc.TOOLTIP_METHOD .. ":",
			'text2', string.format("%s%s", self.data.LootColorTable[self.tmpdata.Threshold].Hex, self.loc.TEXT_GROUP)
		);
		
	elseif self.tmpdata.LootType == "master" then 
	
		if self.data.ShowMLName and self.tmpdata.MLName then
		
			if not self.tmpdata.Threshold then
				self:UpdateData();
			end
			cat:AddLine(
				'text', self.loc.TOOLTIP_METHOD .. ":",
				'text2', string.format("%s%s", self.data.LootColorTable[self.tmpdata.Threshold].Hex, self.loc.TEXT_MASTER .. "(" .. self.tmpdata.MLName .. ")")
			);
			
		else
		
			if not self.tmpdata.Threshold then
				self:UpdateData();
			end
			cat:AddLine(
				'text', self.loc.TOOLTIP_METHOD .. ":",
				'text2', string.format("%s%s", self.data.LootColorTable[self.tmpdata.Threshold].Hex, self.loc.TEXT_MASTER)
			);
			
		end
		
	elseif self.tmpdata.LootType == "freeforall" then
	
		if not self.tmpdata.Threshold then
			self:UpdateData();
		end
		cat:AddLine(
			'text', self.loc.TOOLTIP_METHOD .. ":",
			'text2', string.format("%s%s", self.data.LootColorTable[self.tmpdata.Threshold].Hex, self.loc.TEXT_FFA)
		);
		
	elseif self.tmpdata.LootType == "roundrobin" then
	
		if not self.tmpdata.Threshold then
			self:UpdateData();
		end
		cat:AddLine(
			'text', self.loc.TOOLTIP_METHOD .. ":",
			'text2', string.format("%s%s", self.data.LootColorTable[self.tmpdata.Threshold].Hex, self.loc.TEXT_RR)
		);
		
	elseif self.tmpdata.LootType == "needbeforegreed" then
	
		if not self.tmpdata.Threshold then
			self:UpdateData();
		end
		cat:AddLine(
			'text', self.loc.TOOLTIP_METHOD .. ":",
			'text2', string.format("%s%s", self.data.LootColorTable[self.tmpdata.Threshold].Hex, self.loc.TEXT_NBG)
		);
		
	else 
	
		if not self.tmpdata.Threshold then
			self:UpdateData();
		end
		cat:AddLine(
			'text', self.loc.TOOLTIP_METHOD .. ":",
			'text2', string.format("%s%s", "|cff888888", self.loc.TEXT_SOLO)
		);
		
	end

	cat = tablet:AddCategory(
		'text', self.loc.TOOLTIP_CAT_ROLLS,
		'columns', 2
	);
	
	if(self.tmpdata.RollCount > 0) then
	
		local a, b, highRoll, rollLink, tallied, color, l, r;

		if self.data.ShowRollCount then
		
			if GetNumRaidMembers() > 0 then
			
				cat:AddLine(
					'text', string.format(self.loc.FORMAT_TOOLTIP_ROLLCOUNT, self.tmpdata.RollCount, GetNumRaidMembers() )
				);
			
			elseif GetNumPartyMembers() > 0 then
			
				cat:AddLine(
					'text', string.format(self.loc.FORMAT_TOOLTIP_ROLLCOUNT, self.tmpdata.RollCount, GetNumPartyMembers()+1 )
				);
			
			end
		
		end

		tallied = {};
		for a=1,self.tmpdata.RollCount do
			tallied[a] = 0;
		end
		
		for a=1,self.tmpdata.RollCount do
		
			highRoll = 0;
			rollLink = 0;
			for b=1,self.tmpdata.RollCount do
			
				if((self.data.StandardRollsOnly) and ((self.tmpdata.Rolls[b].Min ~= 1) or (self.tmpdata.Rolls[b].Max ~= 100))) then
					
					tallied[b] = 1;
					
				end
				
				if((self.tmpdata.Rolls[b].Roll > highRoll) and (tallied[b] == 0)) then
					
					highRoll = self.tmpdata.Rolls[b].Roll;
					rollLink = b;
					
				end
				
			end
			
			if(rollLink ~= 0) then
			
				r = self.tmpdata.Rolls[rollLink].Player;
				if(self.data.ShowClassLevel) then
				
					local hexcolor = babble.GetClassHexColor(self.tmpdata.Rolls[rollLink].Class);
					r = string.format("|cff%s%s %d %s%s", hexcolor, r, self.tmpdata.Rolls[rollLink].Level, string.sub(self.tmpdata.Rolls[rollLink].Class,1,1), string.lower(string.sub(self.tmpdata.Rolls[rollLink].Class,2)));
					
				end
				
				l = self.tmpdata.Rolls[rollLink].Roll;	
				if((self.tmpdata.Rolls[rollLink].Min ~= 1) or (self.tmpdata.Rolls[rollLink].Max ~= 100)) then
				
					l = l .. " (" .. self.tmpdata.Rolls[rollLink].Min .. "-" .. self.tmpdata.Rolls[rollLink].Max .. ")";
					
				end
				
				cat:AddLine(
					'text', r,
					'text2', l
				);
				
				tallied[rollLink] = 1;
				
			end
		end
		
	else
	
		cat:AddLine (
			'text', self.loc.TEXT_NOROLLS,
			'text2', ""
		);
		
	end
	
	if(self.data.RollOnClick) then
	
		tablet:SetHint(self.loc.TOOLTIP_HINT_ROLLS);
		
	else
	
		tablet:SetHint(self.loc.TOOLTIP_HINT_NOROLLS);
		
	end
end

function GroupFu:OnClick()

	if(IsControlKeyDown()) then
	
		if(self.tmpdata.RollCount > 0) then
		
			local i, highRoll, highRoller;
	
			highRoll = 0;
			highRoller = "";
			for i = 1, self.tmpdata.RollCount do
			
				if ((self.tmpdata.Rolls[i].Roll > highRoll) and ((not self.data.StandardRollsOnly) or ((self.tmpdata.Rolls[i].Min == 1) and (self.tmpdata.Rolls[i].Max == 100)))) then
					
					highRoll = self.tmpdata.Rolls[i].Roll;
					highRoller = self.tmpdata.Rolls[i].Player;
					
				end
			end
			
			-- Output the winner to the specified output channel
			self:AnnounceOutput(format(self.loc.FORMAT_ANNOUNCE_WIN, highRoller, highRoll, self.tmpdata.RollCount));
			
			if((self.data.OutputDetail == "LONG") or (self.data.OutputDetail == "FULL")) then
				local a, b, rollLink, tallied, message, count;
	
				tallied = {};
				count = 0;
				message = "";
				
				for a=1,self.tmpdata.RollCount do
					tallied[a] = 0;
				end
				
				for a=1,self.tmpdata.RollCount do
					highRoll = 0;
					rollLink = 0;
					
					for b=1,self.tmpdata.RollCount do
					
						if((self.data.StandardRollsOnly) and ((self.tmpdata.Rolls[b].min ~= 1) or (self.tmpdata.Rolls[b].max ~= 100))) then
						
							tallied[b] = 1;
							
						end
						
						if((self.tmpdata.Rolls[b].Roll > highRoll) and (tallied[b] == 0)) then
						
							highRoll = self.tmpdata.Rolls[b].Roll;
							rollLink = b;
							
						end
					end
					
					if(rollLink ~= 0) then
					
						message = message .. "#" .. a .. " " .. self.tmpdata.Rolls[rollLink].Player .. " [" .. self.tmpdata.Rolls[rollLink].Roll .. "]";
						if((self.data.OutputDetail == "FULL") and ((self.tmpdata.Rolls[rollLink].Min ~= 1) or (self.tmpdata.Rolls[rollLink].Max ~= 100))) then
						
							message = message .. " (" .. self.tmpdata.Rolls[rollLink].Min .. "-" .. self.tmpdata.Rolls[rollLink].Max .. ")";
							
						end
						message = message .. ", ";
						count = count + 1;
						tallied[rollLink] = 1;
						
					end
					
					if((count == 10) or (a == self.tmpdata.RollCount)) then
					
						message = string.sub(message, 1, -3);
						self:AnnounceOutput(message);
						message = "";
						count = 0;
						
					end
				end
			end
			
			if(self.data.DeleteRolls) then
			
				self:ClearRolls();
				
			end
		end
		
	elseif(IsShiftKeyDown()) then
	
		self:ClearRolls();
		
	else
	
		if(self.data.RollOnClick) then
		
			RandomRoll("1", "100");
			
		end
	end
end

function GroupFu:CHAT_MSG_SYSTEM()
	local player, roll, min_roll, max_roll, mlname;
	
	-- Trap name of master looter if it has changed
	_, _, mlname = string.find(arg1, self.loc.SEARCH_MASTERLOOTER);
	if mlname then
	
		self.tmpdata.MLName = mlname;
		self:Update();
		
	end
	
	-- Trap rolls
	_, _, player, roll, min_roll, max_roll = string.find(arg1, self.loc.SEARCH_ROLLS);
	if(player) then
	
		if((self.data.StandardRollsOnly) and ((tonumber(min_roll) ~= 1) or (tonumber(max_roll) ~= 100))) then
		
			return;
			
		end
		
		if((self.tmpdata.RollCount > 0) and (self.data.IgnoreDuplicates)) then
			local i;
	
			for i=1,self.tmpdata.RollCount do
			
				if(self.tmpdata.Rolls[i].Player == player) then
					return;
				end
				
			end
		end
		
		self.tmpdata.RollCount = self.tmpdata.RollCount + 1;
		self.tmpdata.Rolls[self.tmpdata.RollCount] = {};
		self.tmpdata.Rolls[self.tmpdata.RollCount].Roll = tonumber(roll);
		self.tmpdata.Rolls[self.tmpdata.RollCount].Player = player;
		self.tmpdata.Rolls[self.tmpdata.RollCount].Min = tonumber(min_roll);
		self.tmpdata.Rolls[self.tmpdata.RollCount].Max = tonumber(max_roll);
		
		if(player == UnitName("player")) then
		
			_, self.tmpdata.Rolls[self.tmpdata.RollCount].Class = UnitClass("player");
			self.tmpdata.Rolls[self.tmpdata.RollCount].Level = UnitLevel("player");
			
		elseif(GetNumRaidMembers() > 0) then
			local i, z;
	
			z = GetNumRaidMembers();
			for i=1,z do
			
				if(player == UnitName("raid"..i)) then
				
					_, self.tmpdata.Rolls[self.tmpdata.RollCount].Class = UnitClass("raid"..i);
					self.tmpdata.Rolls[self.tmpdata.RollCount].Level = UnitLevel("raid"..i);
					break;
					
				end
			end
			
		elseif(GetNumPartyMembers() > 0) then
			local i, z;
	
			z = GetNumPartyMembers();
			for i=1,z do
			
				if(player == UnitName("party"..i)) then
				
					_, self.tmpdata.Rolls[self.tmpdata.RollCount].Class = UnitClass("party"..i);
					self.tmpdata.Rolls[self.tmpdata.RollCount].Level = UnitLevel("party"..i);
					
				end
			end
			
		else
		
			self.tmpdata.Rolls[self.tmpdata.RollCount].Class = "";
			self.tmpdata.Rolls[self.tmpdata.RollCount].Level = 0;
			
		end
		
		if (self.data.ClearTimer > 0) and not self.data.AnnounceRollCountdown then
			self.tmpdata.TimeSinceLastRoll = 0;
		end	
		
		self:Update();
		
	end
end

function GroupFu:ToggleOption(opt)

	self.data[opt] = not self.data[opt];
	self:Update();
	return self.data[opt];
	
end

function GroupFu:ToggleOutputChannel(channel)

	self.data.OutputChannel = channel;
	self:Update();
	return self.data.OutputChannel;
	
end

function GroupFu:IsOutputChannel(channel)

	if self.data.OutputChannel == channel then
		return true;
	else
		return false;
	end
	
end

function GroupFu:ToggleOutputDetail(detail)

	self.data.OutputDetail = detail;
	self:Update();
	return self.data.OutputDetail;
	
end

function GroupFu:IsOutputDetail(detail)

	if self.data.OutputDetail == detail then
		return true;
	else
		return false;
	end
	
end

function GroupFu:ToggleTextMode(mode)

	self.data.TextMode = mode;
	self:Update();
	return self.data.TextMode;
	
end

function GroupFu:IsTextMode(mode)

	if self.data.TextMode == mode then
		return true;
	else
		return false;
	end
	
end

function GroupFu:ToggleClearTimer(timeout)

	self.data.ClearTimer = timeout;
	self:Update();
	return self.data.ClearTimer;
	
end

function GroupFu:IsClearTimer(timeout)

	if self.data.ClearTimer == timeout then
		return true;
	else
		return false;
	end
	
end

function GroupFu:ClearRolls()

	self.tmpdata.Rolls = {};
	self.tmpdata.RollCount = 0;
	self.tmpdata.TimeSinceLastRoll = 0;
	self:Update();
	
end

function GroupFu:IsLootType(loottype)

	if GetLootMethod() == loottype then
		return true;
	else 
		return false;
	end
	
end

function GroupFu:SetLootType(loottype)

	if loottype == "master" then
		SetLootMethod(loottype,UnitName("player"),2);
	else
		SetLootMethod(loottype);
	end
	
	self:Update();
	dewdrop:Close(3);

end

function GroupFu:IsLootThreshold(threshold)

	if GetLootThreshold() == threshold then
		return true;
	else 
		return false;
	end
	
end

function GroupFu:SetLootThreshold(threshold)

	SetLootThreshold(threshold)	
	self:Update();
	dewdrop:Close(3);

end

function GroupFu:GetLootTypeText()

	if self.tmpdata.LootType == "group" then
	
		return self.loc.TEXT_GROUP;
		
	elseif self.tmpdata.LootType == "master" then
	
		if self.data.ShowMLName and self.tmpdata.MLName then
			return self.loc.TEXT_MASTER .. "(" .. self.tmpdata.MLName .. ")";
		else
			return self.loc.TEXT_MASTER;
		end
		
	elseif self.tmpdata.LootType == "freeforall" then
	
		return self.loc.TEXT_FFA;
		
	elseif self.tmpdata.LootType == "roundrobin" then
	
		return self.loc.TEXT_RR;
		
	elseif self.tmpdata.LootType == "needbeforegreed" then
	
		return self.loc.TEXT_NBG;
		
	else
	
		return self.loc.TEXT_SOLO;
		
	end
end

function GroupFu:CheckRollTimeout()

	if ((self.tmpdata.RollCount > 0) and (self.data.ClearTimer > 0)) then
	
		self.tmpdata.TimeSinceLastRoll = self.tmpdata.TimeSinceLastRoll + self.updateTime;

		if (self.data.AnnounceRollCountdown) then

			if( self.tmpdata.TimeSinceLastRoll == (self.data.ClearTimer-10) ) then
				
				self:AnnounceOutput( self.loc.TEXT_ENDING10 );
				
			elseif( self.tmpdata.TimeSinceLastRoll == (self.data.ClearTimer-5) ) then
				
				self:AnnounceOutput( self.loc.TEXT_ENDING5 );
				
			elseif( self.tmpdata.TimeSinceLastRoll == (self.data.ClearTimer-4) ) then
				
				self:AnnounceOutput( self.loc.TEXT_ENDING4 );
				
			elseif( self.tmpdata.TimeSinceLastRoll == (self.data.ClearTimer-3) ) then
				
				self:AnnounceOutput( self.loc.TEXT_ENDING3 );
				
			elseif( self.tmpdata.TimeSinceLastRoll == (self.data.ClearTimer-2) ) then
				
				self:AnnounceOutput( self.loc.TEXT_ENDING2 );
				
			elseif( self.tmpdata.TimeSinceLastRoll == (self.data.ClearTimer-1) ) then
				
				self:AnnounceOutput( self.loc.TEXT_ENDING1 );
				
			elseif( self.tmpdata.TimeSinceLastRoll == self.data.ClearTimer ) then
				
				self:AnnounceOutput( self.loc.TEXT_ENDED );
				
				if(self.tmpdata.RollCount > 0) then
				
					local i, highRoll, highRoller;
			
					highRoll = 0;
					highRoller = "";
					for i = 1, self.tmpdata.RollCount do
					
						if ((self.tmpdata.Rolls[i].Roll > highRoll) and ((not self.data.StandardRollsOnly) or ((self.tmpdata.Rolls[i].Min == 1) and (self.tmpdata.Rolls[i].Max == 100)))) then
							
							highRoll = self.tmpdata.Rolls[i].Roll;
							highRoller = self.tmpdata.Rolls[i].Player;
							
						end
					end
			
					self:AnnounceOutput(format(self.loc.FORMAT_ANNOUNCE_WIN, highRoller, highRoll, self.tmpdata.RollCount));
				end
				
				self:ClearRolls();
				
			end
			
		elseif( self.tmpdata.TimeSinceLastRoll == self.data.ClearTimer ) then 
		
			self:ClearRolls();
			
		end
	end
	
end

function GroupFu:AnnounceOutput( mymessage )

	if( self.data.OutputChannel == "LOCAL" ) then
	
		DEFAULT_CHAT_FRAME:AddMessage(mymessage);
		
	elseif ( self.data.OutputChannel == "AUTO" ) then
	
		if ( GetNumRaidMembers() > 0 ) then

			SendChatMessage(mymessage, "RAID");
		
		elseif ( GetNumPartyMembers() > 0 ) then
		
			SendChatMessage(mymessage, "PARTY");
		
		else
			
			DEFAULT_CHAT_FRAME:AddMessage(mymessage);
			
		end
	
	else
	
		SendChatMessage(mymessage, self.data.OutputChannel);
		
	end

end

GroupFu:RegisterForLoad();