--[[
	DiscoDice by Discoepfeand of Sargeras

	The mod is designed to make it easier to manage Slice and Dice

	Many Thanks goes to the creator of stunwatch for great examples

	in his code which I could use in here.
	
	"get Jiggy"
   ]]

-- Constants
DISCODICE_MAX_COMBO_POINTS = MAX_COMBO_POINTS;

function DiscoDice_Initialize()
	this:RegisterEvent("CHAT_MSG_WHISPER");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS")
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
	this:RegisterEvent("PLAYER_COMBO_POINTS");
	this:RegisterEvent("SPELLCAST_STOP")
	this:RegisterEvent("SPELLCAST_START")
	DiscoDice_StartupMessage()
	DiscoDice.SnDEnd = 0;
	DiscoDice.SnDEndRupture = 0;
	DiscoDice.SnDEndEA = 0;
	DiscoDice.itsago = 0;
	DiscoDice.itsagoRupture = 0;
	DiscoDice.itsagoEA = 0;
	DiscoDice.ShowStatus = 3;

	maxtime = GetTime()
	-- oldichi = CastSpellByName
	-- CastSpellByName = MyMod_newCastSpellByName

	if DiscoDice_var == nil then
		DiscoDice_var = 1.0
	end

	if DiscoDice_ShowType == nil then
		DiscoDice_ShowType = "normal"
	end

	if DiscoDice_State == nil then
		DiscoDice_state = "on"
	end

	if DiscoDice_displaytype == nil then
		DiscoDice_Displaytype = 2
	end

	if DiscoDice_Scale == nil then
		DiscoDice_Scale = 1
	end

	if DiscoDice.EndMod == nil then
		DiscoDice.EndMod = 0
	end

	if DiscoDice.EndModRupture == nil then
		DiscoDice.EndModRupture = 0
	end

	if DiscoDice.EndModEA == nil then
		DiscoDice.EndModEA = 0
	end

	if DiscoDice_EAONOFF == nil then
		DiscoDice_EAONOFF = "off"
	end

	if DiscoDice_RuptureONOFF == nil then
		DiscoDice_RuptureONOFF = "off"
	end

	DiscoDice.CurrCombo = 0

	DiscoDice.SnDEnd = GetTime()
	DiscoDice.SnDEndRupture = GetTime()
	DiscoDice.SnDEndEA = GetTime()

	DiscoDice:SetScale(DiscoDice_Scale * UIParent:GetScale());
	DEFAULT_CHAT_FRAME:AddMessage("blah " .. DiscoDice.EndMod .. "DiscoDice is using a ".. DiscoDice_var .. " time multiplier due to talents.  It is currently turned " .. DiscoDice_state .. " and using a " .. DiscoDice_Scale .. " scaling factor.")

	SlashCmdList["DISCODICE"] = DiscoDice_command;
	SLASH_DISCODICE1 = "/discodice";
	SLASH_DISCODICE2 = "/ddice";

end

function DiscoDice_command(myArg1)

	if (myArg1 == "on") then
		DiscoDice_state = "on"
		DEFAULT_CHAT_FRAME:AddMessage("DiscoDice is now on")
	elseif (myArg1 == "off") then
		DiscoDice_state = "off"
		DEFAULT_CHAT_FRAME:AddMessage("DiscoDice is now off.")
	elseif (myArg1 == "hide") then
		DiscoDiceBar1:Hide()
		DiscoDiceBar2:Hide()
		DiscoDiceBar3:Hide()
		DiscoDice.ShowStatus = 3;
		DiscoDice:EnableMouse(0)
	elseif myArg1 == "status" then
		DEFAULT_CHAT_FRAME:AddMessage("DiscoDice is using a ".. DiscoDice_var .. " time multiplier due to talents.  It is currently turned " .. DiscoDice_state .. " and using a " .. DiscoDice_Scale .. " scaling factor.  Expose Armor bar is " .. DiscoDice_EAONOFF .. " and Rupture bar is " .. DiscoDice_RuptureONOFF ..".  SnD Show Type is " .. DiscoDice_ShowType ..".")
	elseif (myArg1 == "show") then
		DiscoDice_ShowBars()
	elseif  strfind(myArg1, "rupture") then
		local DiscoDiceArg = string.find(myArg1, " ");
		DiscoDice_RuptureONOFF = string.sub(myArg1, DiscoDiceArg + 1, string.len(myArg1));
		DEFAULT_CHAT_FRAME:AddMessage("Rupture bar is now" .. DiscoDice_RuptureONOFF .. ".")		
	elseif  strfind(myArg1, "expose") then
		local DiscoDiceArg = string.find(myArg1, " ");
		DiscoDice_EAONOFF = string.sub(myArg1, DiscoDiceArg + 1, string.len(myArg1));
		DEFAULT_CHAT_FRAME:AddMessage("Expose Armor bar is now" .. DiscoDice_EAONOFF .. ".")		
	elseif  strfind(myArg1, "display") then
		local DiscoDiceArg = string.find(myArg1, " ");
		DiscoDice_Displaytype = string.sub(myArg1, DiscoDiceArg + 1, string.len(myArg1));
	elseif  myArg1 == "doRupture" then
		DiscoDiceBar2_Rupture()
	elseif  myArg1 == "doEA" then
		DiscoDiceBar3_EA()
	elseif  strfind(myArg1, "talent") then
		local DiscoDiceArg = string.find(myArg1, " ");
		DiscoDice.Talent = string.sub(myArg1, DiscoDiceArg + 1, string.len(myArg1));
		if DiscoDice.Talent == "1" then
			DiscoDice_var = 1.15
			DEFAULT_CHAT_FRAME:AddMessage("DiscoDice is using 1/3 improved Slice and Dice.")
		elseif DiscoDice.Talent == "2" then
			DiscoDice_var = 1.30
			DEFAULT_CHAT_FRAME:AddMessage("DiscoDice is using 2/3 improved Slice and Dice.")
		elseif DiscoDice.Talent == "3" then
			DiscoDice_var = 1.45
			DEFAULT_CHAT_FRAME:AddMessage("DiscoDice is using 3/3 improved Slice and Dice.")
		else
			DiscoDice_var = 1.00
			DEFAULT_CHAT_FRAME:AddMessage("DiscoDice is using 0/3 improved Slice and Dice.")
		end
	elseif  strfind(myArg1, "scale") then
		local DiscoDiceArg = string.find(myArg1, " ")
		DiscoDice_Scale = string.sub(myArg1, DiscoDiceArg + 1, string.len(myArg1))
		DiscoDice_Scale = DiscoDice_Scale * 1
		if ((DiscoDice_Scale < 3.01) and (DiscoDice_Scale > 0.5)) then
			DiscoDice:ClearAllPoints();
			DiscoDice:SetPoint("CENTER", "UIParent", "CENTER", 0, 0); 
			DiscoDice_ShowBars()
		else
			DEFAULT_CHAT_FRAME:AddMessage("Please choose a number between 0.5 and 3")		
		end
	elseif  strfind(myArg1, "mode") then
		local DiscoDiceArg = string.find(myArg1, " ")
		local DiscoDiceTempShow = string.sub(myArg1, DiscoDiceArg + 1, string.len(myArg1))
		if (DiscoDiceTempShow == "fixed") then
			DiscoDice_ShowType = "fixed";
			DEFAULT_CHAT_FRAME:AddMessage("Now using a fixed bar size for Slice and Dice events")
		else
			DiscoDice_ShowType = "normal"
			DEFAULT_CHAT_FRAME:AddMessage("Now using a full bar for all Slice and Dice events")
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("DiscoDice commands:")		
		DEFAULT_CHAT_FRAME:AddMessage("/discodice and /ddice are interchangeable.")
		DEFAULT_CHAT_FRAME:AddMessage("/ddice on   and /ddice off turn the display on and off.")
		DEFAULT_CHAT_FRAME:AddMessage("/ddice show: shows the bar and lets you move it.")		
		DEFAULT_CHAT_FRAME:AddMessage("/ddice hide: returns the bar to its hidden state until you next use Slice and Dice.")
		DEFAULT_CHAT_FRAME:AddMessage("/ddice display [combo/timer] : toggles between the bar text being combo points or seconds left.")
		DEFAULT_CHAT_FRAME:AddMessage("/ddice talent [0/1/2/3] : registers you as that many points in improved Slice and Dice.")
		DEFAULT_CHAT_FRAME:AddMessage("/ddice scale [put number from 0.5 to 3 here] : scales the size of the bar on your screen.")
		DEFAULT_CHAT_FRAME:AddMessage("/ddice rupture [on/off] : turns the rupture bar on or off")
		DEFAULT_CHAT_FRAME:AddMessage("/ddice expose [on/off] : turns the expose armor bar on or off")
		DEFAULT_CHAT_FRAME:AddMessage(myArg1)

	end
end

function DiscoDice_ShowBars()
		DiscoDice:EnableMouse(1);
		DiscoDice.ShowStatus = 1;

		DiscoDiceBar1:SetAlpha(1);
		DiscoDiceBar1StatusBar:SetMinMaxValues(0, 100);
		DiscoDiceBar1StatusBar:SetValue(100)
		DiscoDiceBar1StatusBarSpark:SetPoint("CENTER", "DiscoDiceBar1", "LEFT", 5, 0);
		DiscoDiceBar1Text:SetText("Slice and Dice");
		DiscoDiceBar1StatusBar:SetStatusBarColor(.5, .5, 1, 1);

		DiscoDiceBar2:SetAlpha(1);
		DiscoDiceBar2StatusBar:SetMinMaxValues(0, 100);
		DiscoDiceBar2StatusBar:SetValue(100)
		DiscoDiceBar2StatusBarSpark:SetPoint("CENTER", "DiscoDiceBar2", "LEFT", 5, 0);
		DiscoDiceBar2Text:SetText("Rupture");
		DiscoDiceBar2StatusBar:SetStatusBarColor(1, .5, .5, 1);

		DiscoDiceBar3:SetAlpha(1);
		DiscoDiceBar3StatusBar:SetMinMaxValues(0, 100);
		DiscoDiceBar3StatusBar:SetValue(100)
		DiscoDiceBar3StatusBarSpark:SetPoint("CENTER", "DiscoDiceBar3", "LEFT", 5, 0);
		DiscoDiceBar3Text:SetText("Expose Armor");
		DiscoDiceBar3StatusBar:SetStatusBarColor(.5, 1, .5, 1);

		DiscoDice:SetScale(DiscoDice_Scale * UIParent:GetScale());
		DiscoDiceBar1:Show();
		DiscoDiceBar2:Show();
		DiscoDiceBar3:Show();
end

function DiscoDice_OnUpdate()

	if (DiscoDice.itsago == 0 ) then
	else
		local status = GetTime()
		if DiscoDice_ShowType == "normal" then
			if ( status <= DiscoDice.SnDEnd ) then
				DiscoDiceBar1StatusBar:SetMinMaxValues(DiscoDice.SnDStart, DiscoDice.SnDEnd);
				local sparkPosition = 162 - ((status - DiscoDice.SnDStart) / (DiscoDice.SnDEnd - DiscoDice.SnDStart)) * 162;
				DiscoDiceBar1StatusBar:SetValue(DiscoDice.SnDEnd + DiscoDice.SnDStart - status);
				DiscoDiceBar1StatusBarSpark:SetPoint("CENTER", "DiscoDiceBar1StatusBar", "LEFT", sparkPosition, 0);
				if DiscoDice_Displaytype == "combo" then
					DiscoDice.SnDText = DiscoDice.CurrCombo
				else
					DiscoDice.RoundedTime = floor(DiscoDice.SnDEnd - status)
					DiscoDice.SnDText = DiscoDice.RoundedTime
				end
				DiscoDiceBar1Text:SetText(DiscoDice.SnDText)
			elseif ( DiscoDiceBar1:GetAlpha() > 0 ) then
				local alpha = DiscoDiceBar1:GetAlpha() - 0.05;
				if( alpha > 0 ) then
					DiscoDiceBar1:SetAlpha(alpha);
				else
					DiscoDiceBar1:Hide();
					DiscoDice.itsago = 0
				end
			end
		else
			if ( status <= DiscoDice.SnDEnd ) then
				DiscoDiceBar1StatusBar:SetMinMaxValues(DiscoDice.SnDStart, DiscoDice.SnDEnd);
				DiscoDiceBar1StatusBarB:SetMinMaxValues(DiscoDice.SnDStart, DiscoDice.SnDEnd);
				local sparkPosition = 162 - ((status - DiscoDice.SnDStart) / (DiscoDice.SnDEnd - DiscoDice.SnDStart)) * 162;
				sparkPosition = sparkPosition * DiscoDice.FixedRatio
				DiscoDiceBar1StatusBar:SetValue(DiscoDice.SnDEnd * DiscoDice.FixedRatio + DiscoDice.SnDStart - status * DiscoDice.FixedRatio);
				if DiscoDice.CurrCombo > 0 then
					DiscoDiceBar1StatusBarB:SetValue(((DiscoDice.SnDEnd - DiscoDice.SnDStart)/21)*(6 + DiscoDice.CurrCombo * 3) + DiscoDice.SnDStart);
				else
					DiscoDiceBar1StatusBarB:SetValue(DiscoDice.SnDStart);
				end
				DiscoDiceBar1StatusBarSpark:SetPoint("CENTER", "DiscoDiceBar1StatusBar", "LEFT", sparkPosition, 0);
				if DiscoDice_Displaytype == "combo" then
					DiscoDice.SnDText = DiscoDice.CurrCombo
				else
					DiscoDice.RoundedTime = floor(DiscoDice.SnDEnd - status)
					DiscoDice.SnDText = DiscoDice.RoundedTime
				end
				DiscoDiceBar1Text:SetText(DiscoDice.SnDText)
			elseif ( DiscoDiceBar1:GetAlpha() > 0 ) then
				local alpha = DiscoDiceBar1:GetAlpha() - 0.05;
				if( alpha > 0 ) then
					DiscoDiceBar1:SetAlpha(alpha);
				else
					DiscoDiceBar1:Hide();
					DiscoDice.itsago = 0
				end
			end
		end
	end

	if (DiscoDice.itsagoRupture == 0 ) then
	else
		local statusRupture = GetTime()
		if ( statusRupture <= DiscoDice.SnDEndRupture ) then
			DiscoDiceBar2StatusBar:SetMinMaxValues(DiscoDice.SnDStartRupture, DiscoDice.SnDEndRupture);
			local sparkPositionRupture = 162 - ((statusRupture - DiscoDice.SnDStartRupture) / (DiscoDice.SnDEndRupture - DiscoDice.SnDStartRupture)) * 162;
			DiscoDiceBar2StatusBar:SetValue(DiscoDice.SnDEndRupture + DiscoDice.SnDStartRupture - statusRupture);
			DiscoDiceBar2StatusBarSpark:SetPoint("CENTER", "DiscoDiceBar2StatusBar", "LEFT", sparkPositionRupture, 0);
			if DiscoDice_Displaytype == "combo" then
				DiscoDice.SnDTextRupture = DiscoDice.CurrCombo
			else
				DiscoDice.RoundedTimeRupture = floor(DiscoDice.SnDEndRupture - statusRupture)
				DiscoDice.SnDTextRupture = DiscoDice.RoundedTimeRupture
			end
			DiscoDiceBar2Text:SetText(DiscoDice.SnDTextRupture)
		elseif ( DiscoDiceBar2:GetAlpha() > 0 ) then
			local alphaRupture = DiscoDiceBar2:GetAlpha() - 0.05;
			if( alphaRupture > 0 ) then
				DiscoDiceBar2:SetAlpha(alphaRupture);
			else
				DiscoDiceBar2:Hide();
				DiscoDice.itsagoRupture = 0
			end
		end
	end

	if (DiscoDice.itsagoEA == 0 ) then
	else
		local statusEA = GetTime()
		if ( statusEA <= DiscoDice.SnDEndEA ) then
			DiscoDiceBar3StatusBar:SetMinMaxValues(DiscoDice.SnDStartEA, DiscoDice.SnDEndEA);
			local sparkPositionEA = 162 - ((statusEA - DiscoDice.SnDStartEA) / (DiscoDice.SnDEndEA - DiscoDice.SnDStartEA)) * 162;
			DiscoDiceBar3StatusBar:SetValue(DiscoDice.SnDEndEA + DiscoDice.SnDStartEA - statusEA);
			DiscoDiceBar3StatusBarSpark:SetPoint("CENTER", "DiscoDiceBar3StatusBar", "LEFT", sparkPositionEA, 0);
			if DiscoDice_Displaytype == "combo" then
				DiscoDice.SnDTextEA = DiscoDice.CurrCombo
			else
				DiscoDice.RoundedTimeEA = floor(DiscoDice.SnDEndEA - statusEA)
				DiscoDice.SnDTextEA = DiscoDice.RoundedTimeEA
			end
			DiscoDiceBar3Text:SetText(DiscoDice.SnDTextEA)
		elseif ( DiscoDiceBar3:GetAlpha() > 0 ) then
			local alphaEA = DiscoDiceBar3:GetAlpha() - 0.05;
			if( alphaEA > 0 ) then
				DiscoDiceBar3:SetAlpha(alphaEA);
			else
				DiscoDiceBar3:Hide();
				DiscoDice.itsagoEA = 0
			end
		end
	end



end

function DiscoDice_LockUnlock()
	if (DiscoDice.ShowStatus == 1) then
		DiscoDice.ShowStatus = 2;
	else
		DiscoDice.ShowStatus = 1;
	end
end


function DiscoDice_OnEvent(event)
	if DiscoDice_state ~= "on" then
		return
	end
	if event == "CHAT_MSG_SPELL_SELF_DAMAGE" then
		if arg1 == "You perform Slice and Dice." then
			DiscoDiceBar1_Slice()
		end
	elseif event == "PLAYER_COMBO_POINTS" then
		DiscoDice.CurrCombo = GetComboPoints()
	end
end


function DiscoDiceBar1_Slice()	
	if DiscoDice.EndMod ~= 0 then
		DiscoDice.SnDPoss = GetTime() + DiscoDice_var * (6 + (3*DiscoDice.CurrCombo))
		if DiscoDice.SnDPoss < DiscoDice.SnDEnd then
			return
		end
	end
	DiscoDice:EnableMouse(0)
	DiscoDice.itsago = 1;
	DiscoDice:SetScale(DiscoDice_Scale * UIParent:GetScale());
	DiscoDiceBar1Text:SetText("");
	DiscoDiceBar1:SetBackdropColor(0, 0, 0, 0.3);
	DiscoDiceBar1StatusBar:SetStatusBarColor(.5, .5, 1, 1);
	DiscoDiceBar1:SetAlpha(1)
	DiscoDiceBar1StatusBar:SetAlpha(.75)
	DiscoDiceBar1:Show()
	DiscoDice.EndMod = DiscoDice_var * (6 + (3*DiscoDice.CurrCombo))
	DiscoDice.SnDStart = GetTime();
	DiscoDice.SnDEnd = GetTime() + DiscoDice.EndMod;
	DiscoDice.FixedRatio = (6 + (3*DiscoDice.CurrCombo))/21;
	-- DiscoDiceBar1StatusBarB:SetValue(DiscoDice.SnDEnd);
	DiscoDiceBar1StatusBarB:SetValue(0);
	DiscoDiceBar1StatusBarB:SetStatusBarColor(1, 1, 0, .9);
end

function DiscoDiceBar2_Rupture()
	CastSpellByName("Rupture")
	if ((DiscoDice_RuptureONOFF ~= "on")  or (DiscoDice.CurrCombo == 0) or (UnitMana("player") < 25)) then
		return
	end
	DiscoDice.itsagoRupture = 1;
	if DiscoDice.EndModRupture ~= 0 then
		DiscoDice.SnDPossRupture = GetTime() + DiscoDice_var * (2 + (4*DiscoDice.CurrCombo))
		if DiscoDice.SnDPossRupture < DiscoDice.SnDEndRupture then
			return
		end
	end
	DiscoDice:EnableMouse(0)
	DiscoDiceBar2Text:SetText("");
	DiscoDice:SetScale(DiscoDice_Scale * UIParent:GetScale());
	DiscoDiceBar2:SetBackdropColor(0, 0, 0, 0.3);
	DiscoDiceBar2StatusBar:SetStatusBarColor(1, .5, .5, 1);
	DiscoDiceBar2:SetAlpha(0.75)
	DiscoDiceBar2:Show()
	DiscoDice.EndModRupture = 2 + 4*DiscoDice.CurrCombo
	DiscoDice.SnDStartRupture = GetTime();
	DiscoDice.SnDEndRupture = GetTime() + DiscoDice.EndModRupture;
end

function DiscoDiceBar3_EA()
	CastSpellByName("Expose Armor")
	if ((DiscoDice_EAONOFF ~= "on")  or (DiscoDice.CurrCombo == 0) or (UnitMana("player") < 25)) then
		return
	end
	DiscoDice:EnableMouse(0)
	DiscoDice.itsagoEA = 1;
	DiscoDiceBar3Text:SetText("");
	DiscoDice:SetScale(DiscoDice_Scale * UIParent:GetScale());
	DiscoDiceBar3:SetBackdropColor(0, 0, 0, 0.3);
	DiscoDiceBar3StatusBar:SetStatusBarColor(.5, 1, .5, 1);
	DiscoDiceBar3:SetAlpha(0.75)
	DiscoDiceBar3:Show()
	DiscoDice.EndModEA = 30
	DiscoDice.SnDStartEA = GetTime();
	DiscoDice.SnDEndEA = GetTime() + DiscoDice.EndModEA;
end

function DiscoDice_StartupMessage()
	DEFAULT_CHAT_FRAME:AddMessage("DiscoDice is loaded.  Type /ddice to show commands.")
end

