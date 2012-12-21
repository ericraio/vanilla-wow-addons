ArcHUDRing_Party = ArcHUDRing:new({
	name = "Party",
	unit = {"party1", "party2", "party3", "party4", "partypet1", "partypet2", "partypet3", "partypet4"},
	defaults = {
		Enabled = TRUE,
		Outline = TRUE,
		ShowText = TRUE,
		ShowPerc = TRUE,
		ColorFade = TRUE,
		ShowBuffs = TRUE,
	},
	def_positions = {
		{"BOTTOMRIGHT", ArcHUD.Rings.Anchors.Left, "BOTTOMLEFT", -450, 96},
		{"BOTTOMRIGHT", ArcHUD.Rings.Anchors.Left, "TOPLEFT", -20, -230},
		{"BOTTOMLEFT", ArcHUD.Rings.Anchors.Right, "TOPLEFT", 20, -230},
		{"BOTTOMLEFT", ArcHUD.Rings.Anchors.Right, "BOTTOMLEFT", 450, 96},
	},
	options = {
		{name = "ShowText", text = ARCHUDOPTIONS.TEXT.SHOWTEXT, tooltip = ARCHUDOPTIONS.TOOLTIPS.SHOWTEXT},
		{name = "ShowPerc", text = ARCHUDOPTIONS.TEXT.SHOWPERC, tooltip = ARCHUDOPTIONS.TOOLTIPS.SHOWPERC},
		{name = "ColorFade", text = ARCHUDOPTIONS.TEXT.COLORFADE, tooltip = ARCHUDOPTIONS.TOOLTIPS.COLORFADE},
		{name = "ShowBuffs", text = ARCHUDOPTIONS.TEXT.SHOWBUFFS, tooltip = ARCHUDOPTIONS.TOOLTIPS.SHOWBUFFS},
		{name = "HideBlizzFrame", text = ARCHUDOPTIONS.TEXT.HIDEBLIZZ, tooltip = ARCHUDOPTIONS.TOOLTIPS.HIDEBLIZZ},
		{name = "EnableMenu", text = ARCHUDOPTIONS.TEXT.ENABLEMENU, tooltip = ARCHUDOPTIONS.TOOLTIPS.ENABLEMENU},
	},
	disableEvents = {
		option = "HideBlizzFrame",
	},

	Initialize = function(self)
		for i=1,4 do
			self[self.unit[i]] = self:CreatePartyFrame(i);

			self[self.unit[i]].fadeIn = 0.5;
			self[self.unit[i]].fadeOut = 0.5;

			-- Don't do updates from start
			self[self.unit[i]].DoCompleteUpdate = false;
			self[self.unit[i]].DoPetUpdate = false;

			-- Make nameplates register clicks
			self[self.unit[i]].NamePlate:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up");
			self[self.unit[i]].pet.NamePlate:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up");

			-- Enable dragging of the party rings
			self[self.unit[i]].NamePlate:RegisterForDrag("LeftButton");

			-- Set default positions
			self[self.unit[i]]:SetPoint(unpack(self.def_positions[i]));

			self[self.unit[i]]:Hide();

			-- Add disableEvents entries
			self.disableEvents[i] = {
				frame = "PartyMemberFrame"..i,
				hide = TRUE,
				events = {"PARTY_MEMBERS_CHANGED", "PARTY_LEADER_CHANGED", "PARTY_MEMBER_ENABLE",
						  "PARTY_MEMBER_DISABLE", "PARTY_LOOT_METHOD_CHANGED", "UNIT_FACTION",
						  "UNIT_AURA", "UNIT_PET", "UNIT_PVP_UPDATE", "VARIABLES_LOADED",
						  "UNIT_NAME_UPDATE", "UNIT_PORTRAIT_UPDATE", "UNIT_DISPLAYPOWER"},
			};
			self.disableEvents[i+4] = {
				frame = "PartyMemberFrame"..i.."HealthBar",
				events = {"CVAR_UPDATE"},
			};
			self.disableEvents[i+8] = {
				frame = "PartyMemberFrame"..i.."ManaBar",
				events = {"CVAR_UPDATE"},
			};
			self.disableEvents[i+12] = {
				frame = "PartyMemberFrame"..i.."PetFrame",
				events = {"UNIT_NAME_UPDATE", "UNIT_PORTRAIT_UPDATE", "UNIT_DISPLAYPOWER"},
			};
			self.disableEvents[i+16] = {
				frame = "PartyMemberFrame"..i.."PetFrameHealthBar",
				events = {"CVAR_UPDATE"},
			};
		end

	end,

	Enable = function(self)
		-- If we're in a raid and the user has set to hide party interface while in raid we
		-- will make sure to disable ourselves
		if(self.hide or HIDE_PARTY_INTERFACE == "1" and GetNumRaidMembers() > 0) then
			self.hide = TRUE;
			self:Disable();
			return;
		end

		for i=1,4 do
			if(self:Get("ShowText")) then
				self[self.unit[i]].Health.Text:Show();
				self[self.unit[i]].Mana.Text:Show();
			else
				self[self.unit[i]].Health.Text:Hide();
				self[self.unit[i]].Mana.Text:Hide();
			end

			if(self:Get("ShowPerc")) then
				self[self.unit[i]].Health.Perc:Show();
				self[self.unit[i]].Mana.Perc:Show();
			else
				self[self.unit[i]].Health.Perc:Hide();
				self[self.unit[i]].Mana.Perc:Hide();
			end

			if(self:Get("Outline")) then
				self[self.unit[i]].Health.BG:Show();
				self[self.unit[i]].Mana.BG:Show();
			else
				self[self.unit[i]].Health.BG:Hide();
				self[self.unit[i]].Mana.BG:Hide();
			end


			self[self.unit[i]].ColorFade = self:Get("ColorFade");

			-- If ring has been moved, position accordingly
			local loc = self:Get(self.unit[i]);
			if(loc) then
				local x, y = self.app.SplitString(loc, ",");
				--self:Msg("%s has been moved. Now location: %d, %d", self.unit[i], x, y);
				self[self.unit[i]]:ClearAllPoints();
				self[self.unit[i]]:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", x, y);
			end

			-- Hook nameplate scripts
			self:HookScript(self[self.unit[i]].NamePlate, "OnEnter", self.NamePlate_Enter);
			self:HookScript(self[self.unit[i]].NamePlate, "OnLeave", self.NamePlate_Leave);
			self:HookScript(self[self.unit[i]].NamePlate, "OnClick", self.NamePlate_Click);
			self:HookScript(self[self.unit[i]].NamePlate, "OnDragStart", self.NamePlate_DragStart);
			self:HookScript(self[self.unit[i]].NamePlate, "OnDragStop", self.NamePlate_DragStop);

			self:HookScript(self[self.unit[i]].pet.NamePlate, "OnEnter", self.NamePlate_Enter);
			self:HookScript(self[self.unit[i]].pet.NamePlate, "OnLeave", self.NamePlate_Leave);
			self:HookScript(self[self.unit[i]].pet.NamePlate, "OnClick", self.NamePlate_Click);

			-- Update partymember data
			self:UpdateMember(self.unit[i]);

			-- Prepare timers
			self.app.Metro:Register(self.unit[i] .. "Health_Fade", ArcHUDRingTemplate.DoFadeUpdate, 0.01, self[self.unit[i]].Health);
			self.app.Metro:Register(self.unit[i] .. "Mana_Fade", ArcHUDRingTemplate.DoFadeUpdate, 0.01, self[self.unit[i]].Mana);
			self.app.Metro:Register(self.unit[i] .. "PetHealth_Fade", ArcHUDRingTemplate.DoFadeUpdate, 0.01, self[self.unit[i]].pet.Health);
			self.app.Metro:Register(self.unit[i] .. "PetMana_Fade", ArcHUDRingTemplate.DoFadeUpdate, 0.01, self[self.unit[i]].pet.Mana);

			self.app.Metro:Register(self.unit[i] .. "Alpha", ArcHUDRingTemplate.AlphaUpdate, 0.01, self[self.unit[i]]);

			-- Activate timers
			self.app.Metro:Start(self.unit[i] .. "Health_Fade");
			self.app.Metro:Start(self.unit[i] .. "Mana_Fade");
			self.app.Metro:Start(self.unit[i] .. "PetHealth_Fade");
			self.app.Metro:Start(self.unit[i] .. "PetMana_Fade");

			self.app.Metro:Start(self.unit[i] .. "Alpha");

		end

		-- Set up events
		if(self:Get("ShowBuffs")) then
			self:RegisterEvent("UNIT_AURA");
		end
		self:RegisterEvent("UNIT_PVP_UPDATE");
		self:RegisterEvent("UNIT_PET");
		self:RegisterEvent("PARTY_LEADER_CHANGED");
		self:RegisterEvent("PARTY_MEMBER_DISABLE");
		self:RegisterEvent("PARTY_LOOT_METHOD_CHANGED");

		self:RegisterEvent("ARCHUD_PARTY_LOCKED");
		self:RegisterEvent("ARCHUD_PARTY_UNLOCKED");
		self:RegisterEvent("ARCHUD_PARTY_RESET");

		self:RegisterEvent("UNIT_HEALTH", 				"EventHandler");
		self:RegisterEvent("UNIT_MAXHEALTH", 			"EventHandler");
		self:RegisterEvent("UNIT_MANA", 				"EventHandler");
		self:RegisterEvent("UNIT_MAXMANA", 				"EventHandler");
		self:RegisterEvent("UNIT_ENERGY", 				"EventHandler");
		self:RegisterEvent("UNIT_MAXENERGY", 			"EventHandler");
		self:RegisterEvent("UNIT_RAGE", 				"EventHandler");
		self:RegisterEvent("UNIT_MAXRAGE", 				"EventHandler");
		self:RegisterEvent("UNIT_FOCUS", 				"EventHandler");
		self:RegisterEvent("UNIT_MAXFOCUS", 			"EventHandler");
		self:RegisterEvent("UNIT_DISPLAYPOWER", 		"EventHandler");

		self:RegisterEvent("UNIT_COMBAT", 				"EventHandler");
		self:RegisterEvent("UNIT_LEVEL", 				"EventHandler");

		self:RegisterEvent("PARTY_MEMBERS_CHANGED", 	"EventHandler");
		self:RegisterEvent("PARTY_MEMBER_ENABLE", 		"EventHandler");
		self:RegisterEvent("RAID_ROSTER_UPDATE", 		"EventHandler");

		self:RegisterEvent("CVAR_UPDATE", 				"EventHandler");

		-- Prepare timers
		self.app.Metro:Register(self.name .. "UpdateAlpha", self.UpdateAlpha, 0.05, self);
		self.app.Metro:Register(self.name .. "DoUpdate", self.DoUpdate, 1, self);

		-- Activate timers
		self.app.Metro:Start(self.name .. "UpdateAlpha");
		self.app.Metro:Start(self.name .. "DoUpdate");

		-- Show/Hide Blizzard party frames
--[[		if(self:Get("Enabled") and self:Get("HideBlizzFrame")) then
			if(GetNumPartyMembers() > 0 and PartyMemberFrame1:IsVisible()) then
				self.PartyHidden = TRUE;
			end
			HidePartyFrame();
		else
			ShowPartyFrame();
		end]]

		-- Check if partyrings are locked
		if(self.app:Get("PartyLock")) then
			self:TriggerEvent("ARCHUD_PARTY_LOCKED");
		else
			self:TriggerEvent("ARCHUD_PARTY_UNLOCKED");
		end

	end,

	Disable = function(self)
		for i=1,4 do
			self.app.Metro:Stop(self.unit[i] .. "Health_Fade");
			self.app.Metro:Stop(self.unit[i] .. "Mana_Fade");
			self.app.Metro:Stop(self.unit[i] .. "PetHealth_Fade");
			self.app.Metro:Stop(self.unit[i] .. "PetMana_Fade");
			self.app.Metro:Stop(self.unit[i] .. "Alpha");
			self[self.unit[i]]:Hide();
		end

		if(self:Get("Enabled") and self:Get("HideBlizzFrame") and self.PartyHidden and
		  (HIDE_PARTY_INTERFACE == "1" and GetNumRaidMembers() == 0) or
		  (HIDE_PARTY_INTERFACE == "0" and GetNumRaidMembers() > 0)) then
			self.PartyHidden = FALSE;
			ShowPartyFrame();
		end

		self.app.Metro:Stop(self.name .. "UpdateAlpha");
		self.app.Metro:Stop(self.name .. "DoUpdate");

		ArcHUDRing.Disable(self);

		UnitFrame_OnEvent("PARTY_MEMBERS_CHANGED")

		if(self.hide) then
			self:RegisterEvent("PARTY_MEMBERS_CHANGED", 	"EventHandler");
			self:RegisterEvent("RAID_ROSTER_UPDATE", 		"EventHandler");
			self:RegisterEvent("CVAR_UPDATE", 				"EventHandler");
		end
	end,

	UpdateAlpha = function(self)
		if(not self.locked) then return; end
		for i=1,4 do
			local frame = self[self.unit[i]];
			if(frame.isInCombat) then
				ArcHUDRingTemplate.SetRingAlpha(frame, ArcHUD.FadeIC);
			else
				if((frame.Health.startValue < frame.Health.maxValue) or
				   (UnitPowerType(frame.unit) == 1 and floor(frame.Mana.startValue) > 0) or
				   (not UnitPowerType(frame.unit) == 1 and frame.Mana.startValue < frame.Mana.maxValue)) then
					ArcHUDRingTemplate.SetRingAlpha(frame, ArcHUD.FadeOOC);
				else
					ArcHUDRingTemplate.SetRingAlpha(frame, ArcHUD.FadeFull);
				end
			end
		end
	end,

	DoUpdate = function(self)
		for i=1,4 do
			-- If we require a complete update, do so now
			if(self[self.unit[i]].DoCompleteUpdate) then
				self:UpdateMember(self.unit[i]);
			end
			if(self[self.unit[i]].DoPetUpdate) then
				self:UpdatePet(self.unit[i]);
			end
		end
	end,

	UpdateMember = function(self, unit)
		if(not self[unit]) then return; end
		if(not self.locked) then return; end
		local frame = self[unit];

		if(UnitInParty(unit)) then
			-- Set up rings
			frame.Health:SetMax(UnitHealthMax(unit));
			frame.Health:SetValue(UnitHealth(unit));

			frame.Mana:SetMax(UnitManaMax(unit));
			frame.Mana:SetValue(UnitMana(unit));

			local p=UnitHealth(unit)/UnitHealthMax(unit);
			local r, g = 1, 1;
			if ( p > 0.5 ) then
				r = (1.0 - p) * 2;
				g = 1.0;
			else
				r = 1.0;
				g = p * 2;
			end
			if ( r < 0 ) then r = 0; elseif ( r > 1 ) then r = 1; end
			if ( g < 0 ) then g = 0; elseif ( g > 1 ) then g = 1; end

			if(UnitIsDead(unit)) then
				frame.Health.Text:SetText("Dead");
				frame.Health.Perc:SetText("");

				frame.Mana.Text:SetText("");
				frame.Mana.Perc:SetText("");
			else
				if(frame.ColorFade) then
					frame.Health:UpdateColor({["r"] = r, ["g"] = g, ["b"] = 0.0});
					frame.Health.Text:SetTextColor(r, g, 0);
				else
					frame.Health.Text:SetTextColor(0, 1, 0);
					frame.Health:UpdateColor({["r"] = 0, ["g"] = 1, ["b"] = 0.0});
				end
				frame.Health.Text:SetText(UnitHealth(unit).."/"..UnitHealthMax(unit));
				frame.Health.Perc:SetText(floor((UnitHealth(unit)/UnitHealthMax(unit))*100).."%");

				if(UnitPowerType(unit) == 0) then
					info = { r = 0.00, g = 1.00, b = 1.00 };
				else
					info = ManaBarColor[UnitPowerType(unit)];
				end
				frame.Mana:UpdateColor(ManaBarColor[UnitPowerType(unit)]);
				frame.Mana.Text:SetVertexColor(info.r, info.g, info.b);
				frame.Mana.Text:SetText(UnitMana(unit).."/"..UnitManaMax(unit));
				frame.Mana.Perc:SetText(floor((UnitMana(unit)/UnitManaMax(unit))*100).."%");
			end


			-- Set name and level
			local tmp, class = UnitClass(unit);
			local color = ArcHUD.ClassColor[class];
			if(color and UnitName(unit) ~= UNKNOWNOBJECT) then
				frame.DoCompleteUpdate = false;
				frame.Name:SetText("|cff"..color..UnitName(unit).."|r");
			else
				frame.DoCompleteUpdate = true;
				frame.Name:SetText(UnitName(unit));
			end

			frame.Level:SetText(UnitLevel(unit));

			self:UpdateGhostMode(unit);
			self:PARTY_LOOT_METHOD_CHANGED(unit);
			if(self:Get("ShowBuffs")) then
				self:UNIT_AURA(unit);
			end
			self:UNIT_PVP_UPDATE(unit);
			self:PARTY_LEADER_CHANGED(unit);
			self:UNIT_PET(unit);
			frame:Show();
		else
			frame:Hide();
		end
	end,

	UpdateGhostMode = function(self, unit)
		if(not self[unit]) then return; end

		local color = {["r"] = 0.75, ["g"] = 0.75, ["b"] = 0.75};
		local frame = self[unit];
		if(UnitIsGhost(unit)) then
			if(not frame.pulse) then
				frame.pulse = true;
				frame.alphaPulse = 0;

				frame.Health:SetValue(UnitHealthMax(unit));
				frame.Health:UpdateColor(color);
				frame.Health.Text:SetText("Dead");
				frame.Health.Text:SetTextColor(1, 0, 0);
				frame.Health.Perc:SetText("");

				frame.Mana:SetValue(UnitManaMax(unit));
				frame.Mana:UpdateColor(color);
				frame.Mana.Text:SetText("");
				frame.Mana.Text:SetTextColor(1, 0, 0);
				frame.Mana.Perc:SetText("");
			end
		end
	end,

	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	--------  EVENT HANDLER FUNCTIONS
	-----------------------------------

	ARCHUD_PARTY_LOCKED = function(self)
		self.locked = true;
		for i=1,4 do
			self[self.unit[i]].locked = true;
			self[self.unit[i]].pet.locked = true;
			if(self:Get("Enabled")) then
				if(self:Get("EnableMenu")) then
					self[self.unit[i]].NamePlate:Show();
					self[self.unit[i]].pet.NamePlate:Show();
				else
					self[self.unit[i]].NamePlate:Hide();
					self[self.unit[i]].pet.NamePlate:Hide();
				end
				for j=1,16 do
					self[self.unit[i]]["Buff"..j]:Hide();
					self[self.unit[i]]["DeBuff"..j]:Hide();
				end
				self:UpdateMember(self.unit[i]);
			else
				self[self.unit[i]]:Hide();
			end
			if(self[self.unit[i]].moved) then
				self:Set(self.unit[i], self[self.unit[i]]:GetLeft() .. "," .. self[self.unit[i]]:GetBottom());
				self[self.unit[i]].moved = FALSE;
			end
		end
	end,

	ARCHUD_PARTY_UNLOCKED = function(self)
		self.locked = false;
		for i=1,4 do
			self[self.unit[i]].locked = false;
			self[self.unit[i]].pet.locked = false;
			self[self.unit[i]].Name:SetText(self.unit[i]);
			self[self.unit[i]].pet.Name:SetText(self.unit[i+4]);
			if(self:Get("Enabled")) then
				self[self.unit[i]]:Show();
				self[self.unit[i]].NamePlate:Show();
				for j=1,16 do
					self[self.unit[i]]["Buff"..j]:Show();
					self[self.unit[i]]["DeBuff"..j]:Show();
				end
				self[self.unit[i]].pet:Show();
				ArcHUDRingTemplate.SetRingAlpha(self[self.unit[i]], 1.0);
			else
				self[self.unit[i]]:Hide();
			end
		end
	end,

	ARCHUD_PARTY_RESET = function(self)
		for i=1,4 do
			self[self.unit[i]]:ClearAllPoints();
			self[self.unit[i]]:SetPoint(unpack(self.def_positions[i]));
			self[self.unit[i]].moved = FALSE;
			if(self:Get(self.unit[i])) then
				self:Set(self.unit[i], nil);
			end
		end
	end,

	PARTY_LOOT_METHOD_CHANGED = function(self, unit)
		if(not unit) then
			unit = arg1;
		end

		-- Check loot settings
		local lootmethod, master = GetLootMethod();
		if(not self[unit]) then
			for i=1,4 do
				if(lootmethod == "master" and master == self[self.unit[i]]:GetID()) then
					self[self.unit[i]].MasterIcon:Show();
				else
					self[self.unit[i]].MasterIcon:Hide();
				end
			end
		else
			local frame = self[unit];
			if(lootmethod == "master" and master == frame:GetID()) then
				frame.MasterIcon:Show();
			else
				frame.MasterIcon:Hide();
			end
		end
	end,

	UNIT_PET = function(self, unit)
		if(not unit) then
			unit = arg1;
		end
		if(not self[unit]) then return; end
		local frame = self[unit].pet;

		if(UnitExists(frame.unit)) then
			frame.Name:SetText(UnitName(frame.unit));

			frame.Health:UpdateColor({["r"] = 0, ["g"] = 1, ["b"] = 0});
			frame.Health:SetMax(UnitHealthMax(frame.unit));
			frame.Health:SetValue(UnitHealth(frame.unit));
			frame.Health.Perc:SetText(floor((UnitHealth(frame.unit)/UnitHealthMax(frame.unit))*100).."%");

			frame.Mana:UpdateColor(ManaBarColor[UnitPowerType(frame.unit)]);
			frame.Mana:SetMax(UnitManaMax(frame.unit));
			frame.Mana:SetValue(UnitMana(frame.unit));
			frame.Mana.Perc:SetText(floor((UnitMana(frame.unit)/UnitManaMax(frame.unit))*100).."%");

			if(UnitName(frame.unit) == UNKNOWNOBJECT) then
				frame.DoPetUpdate = true;
			else
				frame.DoPetUpdate = false;
			end
			frame:Show();
		else
			frame:Hide();
		end
	end,

	UNIT_PVP_UPDATE = function(self, unit)
		if(not unit) then
			unit = arg1;
		end
		if(not self[unit]) then return; end

		local icon = self[unit].PVPIcon;
		local factionGroup = UnitFactionGroup(unit);
		if (UnitIsPVPFreeForAll(unit)) then
			icon:SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA");
			icon:ClearAllPoints();
			icon:SetPoint("CENTER", self[unit], "BOTTOMLEFT", 136, 0);
			icon:Show();
		elseif(factionGroup and UnitIsPVP(unit)) then
			icon:SetTexture("Interface\\GroupFrame\\UI-Group-PVP-"..factionGroup);
			icon:ClearAllPoints();
			icon:SetPoint("CENTER", self[unit], "BOTTOMLEFT", 128, 0);
			icon:Show();
		else
			icon:Hide();
		end
	end,

	PARTY_LEADER_CHANGED = function(self, unit)
		if(not unit) then
			unit = arg1;
		end
		if(not self[unit]) then
			for i=1,4 do
				-- Check party leader status
				if(UnitIsPartyLeader(self.unit[i])) then
					self[self.unit[i]].LeaderIcon:Show();
				else
					self[self.unit[i]].LeaderIcon:Hide();
				end
			end
		else
			-- Check party leader status
			if(UnitIsPartyLeader(unit)) then
				self[unit].LeaderIcon:Show();
			else
				self[unit].LeaderIcon:Hide();
			end
		end
	end,

	PARTY_MEMBER_DISABLE = function(self, unit)
		if(not unit) then
			unit = arg1;
		end
		if(not self[unit]) then return; end
		if(UnitIsConnected(unit)) then return; end
		local frame = self[unit];

		frame.pulse = false;

		frame.Health:SetMax(1);
		frame.Health:SetValue(1);
		frame.Mana:SetMax(1);
		frame.Mana:SetValue(1);

		frame.Health:UpdateColor({ ["r"] = 0.5, ["g"] = 0.5, ["b"] = 0.5});
		frame.Mana:UpdateColor({ ["r"] = 0.5, ["g"] = 0.5, ["b"] = 0.5});

		frame.Health.Text:SetText("Offline");
		frame.Health.Text:SetTextColor(1, 1, 0);
		frame.Health.Perc:SetText("");

		frame.Mana.Text:SetText("");
		frame.Mana.Perc:SetText("");
	end,

	UNIT_AURA = function(self, unit)
		if(not unit) then
			unit = arg1;
		end
		if(not self[unit]) then return; end
		local frame = self[unit];

		-- Don't update frames if they're not locked
		if(not frame.locked) then return; end

		local i, icon, buff, debuff, debuffborder, debuffcount, color;
		for i = 1, 16 do
			buff = UnitBuff(unit, i);
			button = frame["Buff"..i];
			if (buff) then
				button.Icon:SetTexture(buff);
				button:Show();
				button.unit = unit;
			else
				button:Hide();
			end
		end

		for i = 1, 16 do
			debuff, debuffApplications, debuffType = UnitDebuff(unit, i);
			button = frame["DeBuff"..i];
			if (debuff) then
				button.Icon:SetTexture(debuff);
				button:Show();
				button.Border:Show();
				button.isdebuff = 1;
				button.unit = unit;
				if ( debuffType ) then
					color = DebuffTypeColor[debuffType];
				else
					color = DebuffTypeColor["none"];
				end
				debuffborder:SetVertexColor(color.r, color.g, color.b);
				if (debuffApplications > 1) then
					button.Count:SetText(debuffApplications);
					button.Count:Show();
				else
					button.Count:Hide();
				end
			else
				button:Hide();
			end
		end
	end,

	EventHandler = function(self)
		local unit = arg1;
		local frame, pet;
		if(unit and string.find(unit, "partypet")) then
			frame = self[string.gsub(unit,"pet","")];
			pet = 1;
		elseif(unit and string.find(unit, "party")) then
			frame = self[unit];
		end

		-- No unit information passed along
		if(not frame) then
			-- Handle party events first
			if(event == "PARTY_MEMBERS_CHANGED" or event == "RAID_ROSTER_UPDATE" or event == "CVAR_UPDATE") then
				if(self:Get("Enabled")) then
					if(HIDE_PARTY_INTERFACE == "1" and GetNumRaidMembers() > 0 and self.disabled == FALSE) then
						self.hide = TRUE;
						self:Disable();
						return;
					elseif(HIDE_PARTY_INTERFACE == "1" and GetNumRaidMembers() == 0 and self.disabled == TRUE) then
						self.hide = FALSE;
						self.disabled = FALSE;
						self:Enable();
						return;
					else
						if(not self.hide) then
							for i=1,4 do
								self:UpdateMember(self.unit[i]);
							end
						end
					end
				end
			end
		else
			if(string.find(event, "PARTY")) then
				self:UpdateMember(unit);
			end

			-- We got unit information, process it based on if it's a pet or not
			if(UnitAffectingCombat(unit)) then
				frame.isInCombat = TRUE;
			else
				frame.isInCombat = FALSE;
			end
			if(not pet) then
				if(event == "UNIT_LEVEL") then
					frame.Level:SetText(UnitLevel(unit));
				elseif(event == "UNIT_NAME_UPDATE") then
					local _, class = UnitClass(unit);
					local color = ArcHUD.ClassColor[class];
					frame.Name:SetText("|cff"..color..UnitName(unit).."|r");
				elseif(event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH") then
					local p=UnitHealth(unit)/UnitHealthMax(unit);
					local r, g = 1, 1;
					if ( p > 0.5 ) then
						r = (1.0 - p) * 2;
						g = 1.0;
					else
						r = 1.0;
						g = p * 2;
					end
					if ( r < 0 ) then r = 0; elseif ( r > 1 ) then r = 1; end
					if ( g < 0 ) then g = 0; elseif ( g > 1 ) then g = 1; end

					if(UnitIsDead(unit)) then
						frame.Health:SetValue(0);
						frame.Health.Text:SetText("Dead");
						frame.Health.Perc:SetText("");
					elseif(UnitIsGhost(unit)) then
						self:UpdateGhostMode(unit);
					else
						self.pulse = false;
						if(frame.ColorFade) then
							frame.Health:UpdateColor({["r"] = r, ["g"] = g, ["b"] = 0.0});
							frame.Health.Text:SetTextColor(r, g, 0);
						else
							frame.Health.Text:SetTextColor(0, 1, 0);
							frame.Health:UpdateColor({["r"] = 0, ["g"] = 1, ["b"] = 0.0});
						end
						frame.Health.Text:SetText(UnitHealth(unit).."/"..UnitHealthMax(unit));
						frame.Health.Perc:SetText(floor((UnitHealth(unit) / UnitHealthMax(unit)) * 100).."%");
						if (event == "UNIT_MAXHEALTH") then
							frame.Health:SetMax(UnitHealthMax(unit));
						else
							frame.Health:SetValue(UnitHealth(unit));
						end
					end
				else
					if(UnitIsGhost(unit)) then
						self:UpdateGhostMode(unit);
					else
						self.pulse = false;

						if(UnitPowerType(unit) == 0) then
							info = { r = 0.00, g = 1.00, b = 1.00 };
						else
							info = ManaBarColor[UnitPowerType(unit)];
						end
						frame.Mana:UpdateColor(ManaBarColor[UnitPowerType(unit)]);

						if(UnitIsDead(unit)) then
							frame.Mana.Text:SetText("");
							frame.Mana.Perc:SetText("");
						else
							frame.Mana.Text:SetText(UnitMana(unit).."/"..UnitManaMax(unit));
							frame.Mana.Text:SetVertexColor(info.r, info.g, info.b);
							frame.Mana.Perc:SetText(floor((UnitMana(unit)/UnitManaMax(unit))*100).."%");
						end

						if(event == "UNIT_MAXMANA" or event == "UNIT_MAXENERGY" or event == "UNIT_MAXRAGE") then
							frame.Mana:SetMax(UnitManaMax(unit));
						else
							frame.Mana:SetValue(UnitMana(unit));
						end
					end
				end
			else
				if(event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH") then
					if(UnitIsDead(unit)) then
						frame.pet.Health.Perc:SetText("Dead");
					else
						frame.pet.Health.Perc:SetText(floor((UnitHealth(unit)/UnitHealthMax(unit))*100).."%");
					end
					if (event == "UNIT_MAXHEALTH") then
						frame.pet.Health:SetMax(UnitHealthMax(unit));
					else
						frame.pet.Health:SetValue(UnitHealth(unit));
					end
				else
					if(UnitIsDead(unit)) then
						frame.pet.Mana.Perc:SetText("");
					else
						frame.pet.Mana.Perc:SetText(floor((UnitMana(unit)/UnitManaMax(unit))*100).."%");
					end
					frame.pet.Mana:UpdateColor(ManaBarColor[UnitPowerType(unit)]);

					if(event == "UNIT_MAXMANA" or event == "UNIT_MAXENERGY" or event == "UNIT_MAXRAGE" or event == "UNIT_MAXFOCUS") then
						frame.pet.Mana:SetMax(UnitManaMax(unit));
					else
						frame.pet.Mana:SetValue(UnitMana(unit));
					end
				end
			end
		end
	end;

	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	--------  NAMEPLATE EVENT FUNCTIONS
	-----------------------------------

	NamePlate_Enter = function()
		if(this:GetParent().locked) then
			if(SpellIsTargeting()) then
				if (SpellCanTargetUnit(this:GetParent().unit)) then
					SetCursor("CAST_CURSOR");
				else
					SetCursor("CAST_ERROR_CURSOR");
				end
			end
			--GameTooltip_SetDefaultAnchor(GameTooltip, this);
			GameTooltip:SetOwner(this, ANCHOR_CURSOR);
			GameTooltip:SetUnit(this:GetParent().unit);
			GameTooltip:Show();
		end
	end,
	NamePlate_Leave = function()
		if(this:GetParent().locked) then
			if(SpellIsTargeting()) then
				SetCursor("CAST_ERROR_CURSOR");
			end
			if(GameTooltip:IsOwned(this)) then
				GameTooltip:Hide();
			end
		end
	end,
	NamePlate_Click = function()
		if(this:GetParent().locked) then
			if((ArcHUD_CustomClick and type(ArcHUD_CustomClick) == "function" and not ArcHUD_CustomClick(arg1, this:GetParent().unit)) or
			   not ArcHUD_CustomClick) then
				if(SpellIsTargeting() and arg1 == "RightButton") then
					SpellStopTargeting();
					return;
				end
				if(arg1 == "LeftButton") then
					if (SpellIsTargeting()) then
						SpellTargetUnit(this:GetParent().unit);
					elseif(CursorHasItem()) then
						DropItemOnUnit(this:GetParent().unit);
					else
						TargetUnit(this:GetParent().unit);
					end
				elseif(arg1 == "RightButton" and not string.find(this:GetParent().unit, "pet")) then
					ToggleDropDownMenu(1, nil, getglobal("PartyMemberFrame"..this:GetParent():GetID().."DropDown"), "cursor", 0, 0);
				end
			end
		else
			ArcHUD.cmd:msg("Party rings currently unlocked, lock party rings to enable clicking");
		end
	end,
	NamePlate_DragStart = function()
		if(not this:GetParent().locked) then
			this:GetParent():ClearAllPoints();
			this:GetParent():StartMoving();
		end
	end,
	NamePlate_DragStop = function()
		if(not this:GetParent().locked) then
			this:GetParent():StopMovingOrSizing();
			this:GetParent().moved = TRUE;
		end
	end,

	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	--------  FRAME CREATION FUNCTIONS
	-----------------------------------

	CreatePartyFrame = function(self, unitid, parent)
		-----------------------------------------------------------------------
		------ PARTY
		----
		-- Frame: Party unit
		local frame = CreateFrame("Frame", nil, parent);

		frame.unit = self.unit[unitid];
		frame:SetID(unitid);

		frame:SetWidth(256);
		frame:SetHeight(256);
		frame:SetScale(0.3);
		frame:SetFrameStrata("LOW");
		frame:SetMovable(true);

		local t, fs;

		-- FontString: Name
		frame.Name = self:CreateFontString(frame, "BACKGROUND", {256, 28}, 28, "CENTER", {1.0, 1.0, 1.0}, {"TOPLEFT", frame, "TOPLEFT", 0, 35});
		frame.Name:SetText("party"..unitid);

		-- FontString: Level
		frame.Level = self:CreateFontString(frame, "BACKGROUND", {256, 26}, 26, "CENTER", {1.0, 1.0, 0.0}, {"TOP", frame.Name, "BOTTOM", 0, -10});

		-- Texture: Leader Icon
		frame.LeaderIcon = self:CreateTexture(frame, "BACKGROUND", {32, 32}, "Interface\\GroupFrame\\UI-Group-LeaderIcon", {"TOPLEFT", frame.Level, "BOTTOMLEFT", 76, 5});

		-- Texture: Master Looter Icon
		frame.MasterIcon = self:CreateTexture(frame, "BACKGROUND", {32, 32}, "Interface\\GroupFrame\\UI-Group-MasterLooter", {"TOPLEFT", frame.Level, "BOTTOMLEFT", 150, 9});

		-- Texture: PvP Icon
		frame.PVPIcon = self:CreateTexture(frame, "BACKGROUND", {64, 64}, nil, {"CENTER", frame, "BOTTOMLEFT", 128, 0});

		local y;
		-- 1-16 Buff icons
		frame.Buff1 = self:CreatePartyBuffIcon(frame, unitid, 1, 36, 36);
		frame.Buff1:SetPoint("TOPRIGHT", frame, "TOPLEFT", -8, 35);
		for i=2,16 do
			frame["Buff"..i] = self:CreatePartyBuffIcon(frame, unitid, i, 36, 36);
			if(i == 6 or i == 14) then y = -2 else y = -3 end
			frame["Buff"..i]:SetPoint("TOP", frame["Buff"..(i-1)], "BOTTOM", 0, y);
		end
		frame.Buff9:ClearAllPoints();
		frame.Buff9:SetPoint("TOPRIGHT", frame.Buff1, "TOPLEFT", -3, 0);

		-- 1-16 DeBuff icons
		frame.DeBuff1 = self:CreatePartyBuffIcon(frame, unitid, 1, 36, 36);
		frame.DeBuff1:SetPoint("TOPLEFT", frame, "TOPRIGHT", 8, 35);
		for i=2,16 do
			frame["DeBuff"..i] = self:CreatePartyBuffIcon(frame, unitid, i, 36, 36);
			if(i == 6 or i == 14) then y = -2 else y = -3 end
			frame["DeBuff"..i]:SetPoint("TOP", frame["DeBuff"..(i-1)], "BOTTOM", 0, y);
		end
		frame.DeBuff9:ClearAllPoints();
		frame.DeBuff9:SetPoint("TOPLEFT", frame.DeBuff1, "TOPRIGHT", 3, 0);

		-- Ring: Party unit health
		frame.Health = self:CreateRing(true, frame);
		frame.Health.BG:SetAlpha(0.4);
		frame.Health:SetPoint("TOPLEFT", frame, "TOPLEFT", 128, 128);

		-- FontString: Health text
		frame.Health.Text = self:CreateFontString(frame.Health, "ARTWORK", {256, 24}, 24, "CENTER", nil, {"TOPLEFT", frame.Health, "BOTTOMLEFT", -128, 68});

		-- FontString: Health percentage
		frame.Health.Perc = self:CreateFontString(frame.Health, "ARTWORK", {128, 20}, 20, "LEFT", {1.0, 1.0, 1.0}, {"TOPRIGHT", frame.Health, "BOTTOMLEFT", 0, -112});

		-- Ring: Party unit mana
		frame.Mana = self:CreateRing(true, frame);
		frame.Mana:SetReversed(true);
		frame.Mana.BG:SetReversed(true);
		frame.Mana.BG:SetAlpha(0.4);
		frame.Mana.BG:SetAngle(180);
		frame.Mana:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 128, 128);

		-- FontString: Mana text
		frame.Mana.Text = self:CreateFontString(frame.Mana, "ARTWORK", {256, 24}, 24, "CENTER", nil, {"TOPLEFT", frame.Mana, "BOTTOMLEFT", -128, 40});

		-- FontString: Mana percentage
		frame.Mana.Perc = self:CreateFontString(frame.Mana, "ARTWORK", {128, 20}, 20, "RIGHT", {1.0, 1.0, 1.0}, {"TOPLEFT", frame.Mana, "BOTTOMLEFT", 0, -112});

		-----------------------------------------------------------------------
		------ PARTYPET
		----
		-- Frame: Party unit pet
		frame.pet = CreateFrame("Frame", nil, frame);
		frame.pet.unit = self.unit[unitid+4];

		frame.pet:SetWidth(180);
		frame.pet:SetHeight(128);
		frame.pet:SetPoint("CENTER", frame, "BOTTOMLEFT", 128, 32);

		-- FontString: Partypet name
		frame.pet.Name = self:CreateFontString(frame.pet, "BACKGROUND", {180, 24}, 24, "CENTER", {1.0, 1.0, 0.0}, {"TOPLEFT", frame.pet, "TOPLEFT", 0, 35});

		-- Ring: Partypet health
		frame.pet.Health = self:CreateRing(true, frame.pet);
		frame.pet.Health.BG:SetAlpha(0.4);
		frame.pet.Health:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 128+18, 128);

		-- FontString: Partypet health percentage
		frame.pet.Health.Perc = self:CreateFontString(frame.pet.Health, "BACKGROUND", {128, 20}, 20, "RIGHT", {1.0, 1.0, 1.0}, {"BOTTOMLEFT", frame.pet.Health, "BOTTOMLEFT", -160, -64});

		-- Ring: Partypet mana
		frame.pet.Mana = self:CreateRing(true, frame.pet);
		frame.pet.Mana:SetReversed(true);
		frame.pet.Mana.BG:SetReversed(true);
		frame.pet.Mana.BG:SetAlpha(0.4);
		frame.pet.Mana.BG:SetAngle(180);
		frame.pet.Mana:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 128-18, 128);

		-- FontString: Partypet health percentage
		frame.pet.Mana.Perc = self:CreateFontString(frame.pet.Mana, "BACKGROUND", {128, 20}, 20, "RIGHT", {1.0, 1.0, 1.0}, {"BOTTOMLEFT", frame.pet.Mana, "BOTTOMLEFT", -36, -64});

		-----------------------------------------------------------------------
		------ NAMEPLATES
		----
		-- Party unit
		frame.NamePlate = CreateFrame("Button", nil, frame);
		frame.NamePlate:SetID(unitid);
		frame.NamePlate:SetWidth(256);
		frame.NamePlate:SetHeight(28);
		frame.NamePlate:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 35);
		frame.NamePlate:SetToplevel(true);
		frame.NamePlate:EnableMouse(true);

		-- Partypet
		frame.pet.NamePlate = CreateFrame("Button", nil, frame.pet);
		frame.pet.NamePlate:SetWidth(180);
		frame.pet.NamePlate:SetHeight(24);
		frame.pet.NamePlate:SetPoint("TOPLEFT", frame.pet, "TOPLEFT", 0, 35);
		frame.pet.NamePlate:SetToplevel(true);
		frame.pet.NamePlate:EnableMouse(true);

		return frame;
	end,

	CreatePartyBuffIcon = function(self, parent, unitid, buffid, width, height)
		local icon = CreateFrame("Button", nil, parent);

		icon:SetWidth(width);
		icon:SetHeight(height);
		icon:SetID(buffid);

		icon.Icon = icon:CreateTexture(nil, "ARTWORK");
		icon.Icon:SetAllPoints(icon);

		icon.Border = icon:CreateTexture(nil, "OVERLAY");
		icon.Border:SetTexture("Interface\\Buttons\\UI-Debuff-Overlays");
		icon.Border:SetWidth(width);
		icon.Border:SetHeight(height);
		icon.Border:SetPoint("CENTER", icon, "CENTER", 0, 0);

		icon.Count = icon:CreateFontString(nil, "OVERLAY");
		icon.Count:SetFont("Fonts\\ARIALN.TTF", 12, "THICKOUTLINE, MONOCHROME");
		icon.Count:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", -1, 0);

		icon.Icon:SetTexture("Interface\\Icons\\INV_Misc_Ear_Human_02");
		icon:SetScript("OnEnter", function() if(this:GetParent().locked) then ArcHUD:SetAuraTooltip(this); end end);
		icon:SetScript("OnLeave", function() GameTooltip:Hide(); end);

		return icon;
	end,
});

ArcHUD:Register(ArcHUDRing_Party);
