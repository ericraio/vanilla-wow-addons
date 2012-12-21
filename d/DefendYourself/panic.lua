function DefendYourself_Panic(elapsed)
	if not DYKey.On then DefendYourselfPanicButton:Hide(); else DefendYourselfPanicButton:Show(); end
	DefendYourselfPanicButtonGraphics();
	if not DYKey or not DYKey.PanicTime then return nil; end
	if DYKey.PanicTime <= 0 then DYKey.PanicTime = nil; DefendYourself_Print("Panic Status over. Normality restored.",0,0,1); return nil; else DYKey.PanicTime = DYKey.PanicTime - elapsed; return true; end
end

function DefendYourself_StartPanic(x)
	if not DYKey then return end
	if not DYKey.PanicTimer then DYKey.PanicTimer = 30; end
	if not x then x = DYKey.PanicTimer; end
	DefendYourselfPanicBar.maxtime = x;
	DYKey.PanicTime = x;
	DefendYourself_Print("Panic status enabled! "..x.." seconds to normality!",1,0,0);
	if DYVar.combat then AttackTarget(); end
end

function DefendYourselfPanicButtonClick(button)
	if button == "LeftButton" then
		DefendYourself_StartPanic();
	else
		if not DYKey.PanicState or DYKey.PanicState > 3 then DYKey.PanicState = -1; end
		DYKey.PanicState = DYKey.PanicState + 1;
	end
end

function DefendYourselfPanicButtonGraphics()
		local bu = getglobal("DefendYourselfPanicButton");
		local bu1 = getglobal("DefendYourselfPanicButtonTex");
		bu:SetScale(1);
		if DYKey.PanicState == 0 then 
			bu:SetWidth(25);
			bu:SetHeight(25);
			bu1:SetAlpha(1);
			bu:SetMovable(1);
		elseif DYKey.PanicState == 1 then
			bu:SetWidth(35);
			bu:SetHeight(35);
			bu1:SetAlpha(1);
			bu:SetMovable(1);
		elseif DYKey.PanicState == 2 then
			bu:SetWidth(50);
			bu:SetHeight(50);
			bu1:SetAlpha(1);
			bu:SetMovable(1);
		elseif DYKey.PanicState == 3 then
			bu:SetWidth(15);
			bu:SetHeight(15);
			bu1:SetAlpha(1);
			bu:SetMovable(1);
		elseif DYKey.PanicState == 4 then
			bu:SetWidth(15);
			bu:SetHeight(15);
			bu1:SetAlpha(0.5);
			bu:SetMovable(0);
		else
			bu:Hide();
		end
		local par = getglobal("DefendYourselfPanicBar");
		local bar = getglobal("DefendYourselfBar");
		local text = getglobal("DefendYourselfPanicText");
		bar:SetFrameLevel(1); 
		if not DYKey.Bar then
			par:Hide();
		else
			if DYKey.PanicTime and DYKey.PanicTime > 0 then 
				bar:SetMinMaxValues(0,par.maxtime); 
				bar:SetValue(DYKey.PanicTime);
				bar:SetStatusBarColor(1,0,0);
				text:SetText("Panic Status:"..floor(DYKey.PanicTime).."s");
				if DYKey.Bar then par:Show(); else par:Hide(); end
			else 
				bar:SetMinMaxValues(0,1); 
				bar:SetValue(1);
				bar:SetStatusBarColor(0,1,0);
				text:SetText("Panic Status:Good");
				if DYKey.Bar == 1 then par:Show(); else par:Hide(); end
			end
		end
end