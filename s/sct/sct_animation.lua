local sct_CRIT_FADEINTIME = 0.3;
local sct_CRIT_HOLDTIME = 2.0;
local sct_CRIT_FADEOUTTIME = 0.5;
local sct_CRIT_X_OFFSET = 100;
local sct_CRIT_Y_OFFSET = 75;
local sct_CRIT_SIZE_PERCENT = 1.25;
local sct_CRIT_FLASH_SIZE_PERCENT = 2;
local sct_MAX_SPEED = .025;
local sct_MIN_UPDATE_SPEED = .01;
local sct_SIDE_POINT = 210;
local sct_MAX_DISTANCE = 150;
local sct_DIRECTION = 1;
local sct_SPRINKLER_START = 18
local sct_SPRINKLER_STEP = -3;
local sct_SPRINKLER_RADIUS = 20;
local sct_SPRINKLER = sct_SPRINKLER_START;

--Animation System variables
local sct_TEXTCOUNT = 30				-- Number of text that can animate
local arrAniData = {};					-- table to hold texts to animate
local arrAniData2 = {};
SCT.ArrayAniData = {arrAniData, arrAniData2};

----------------------
--Display the Text
function SCT:DisplayText(msg, color, iscrit, type, frame, anitype)
	local adat, curDir;
	local startpos, lastpos, textsize;
	
	--Set up  text animation
	adat = self:GetNextAniObj(frame);
	
	--set override animation
	adat.anitype = anitype or adat.anitype;
			
	--If its a crit hit, increase the size
	if (iscrit) then
		adat.textsize = adat.textsize * sct_CRIT_SIZE_PERCENT;
		if (self.db.profile["STICKYCRIT"]) then
			adat.crit = true;
			local critcount = self:CritCount(adat.frame);
			adat.posY = (adat.toppoint + adat.posY)/2;
			--if there are other Crits active, set offset.
			if (critcount > 0) then
				local randomposx = random(-1,1);
				local randomposy = random(-1,1);
				if randomposx == 0 and randomposy == 0 then randomposy = 1 end;
				adat.posX = adat.posX + (randomposx*sct_CRIT_X_OFFSET);
				adat.posY = adat.posY + (randomposy*sct_CRIT_Y_OFFSET);
			end
			--if flash crits are on
			if (self.db.profile["FLASHCRIT"]) then
				adat.critsize = adat.textsize * sct_CRIT_FLASH_SIZE_PERCENT;
				if (adat.textsize > 32) then adat.textsize = 32 end;
			end
		end
	end
		
	--if its not a sticky critm set up normal text start position
	if (adat.crit ~= true) then
		if (adat.anitype == 1) then
			--get the last known point of active items
			lastpos = self:MinPoint(adat.frame)
			if (not adat.direction) then
				--move the position down
				if ((lastpos - adat.posY) <= adat.textsize) then
					adat.posY = adat.posY - (adat.textsize - (lastpos - adat.posY));
				end
				--if its gone too far down, stop
				if (adat.posY < (adat.bottompoint - sct_MAX_DISTANCE)) then
					adat.posY = (adat.bottompoint - sct_MAX_DISTANCE)
					adat.posX = adat.posX + (random(-1,1)*sct_CRIT_X_OFFSET)
				end
				adat.addY = self.db.profile["MOVEMENT"];
			else
				adat.posY = adat.toppoint
				--move the position up
				if ((adat.posY - lastpos) <= adat.textsize) then
					adat.posY = adat.posY + (adat.textsize - (adat.posY - lastpos));
				end
				--if its gone too far up, stop
				if (adat.posY > (adat.toppoint + sct_MAX_DISTANCE)) then
					adat.posY = (adat.toppoint + sct_MAX_DISTANCE)
					adat.posX = adat.posX + (random(-1,1)*sct_CRIT_X_OFFSET)
				end
				adat.addY = -1*self.db.profile["MOVEMENT"];
			end
		else
			--get direction type
			if (adat.sidedir == 1) then
				sct_DIRECTION = sct_DIRECTION * -1;
				curDir = sct_DIRECTION;
			elseif (adat.sidedir == 2) then
				if (type=="event") then curDir = -1 else curDir = 1 end
			elseif (adat.sidedir == 3) then
				if (type=="event") then curDir = 1 else curDir = -1 end
			elseif (adat.sidedir == 4) then
				curDir = 1;
			elseif (adat.sidedir == 5) then
				curDir = -1;
			end
			adat.sidedir = curDir;
			--set animation start pos.
			if (adat.anitype == 2) then
				adat.addY = random(3,6);
				adat.posX = adat.posX - (20 * adat.sidedir);
			elseif (adat.anitype == 3) then
				adat.posX = adat.posX - (55 * adat.sidedir);
				adat.posY = adat.bottompoint + (random(0,200) - 100);
				adat.addX = self.db.profile["MOVEMENT"];
			elseif (adat.anitype == 4) then
				adat.posX = adat.posX - (20 * adat.sidedir);
				adat.addY = random(8,13);
				adat.addX = random(8,13);
			elseif (adat.anitype == 5) then
				adat.posX = adat.posX - (20 * adat.sidedir);
				adat.addY = random(10,15);
				adat.addX = random(10,15);
			elseif (adat.anitype == 6) then
				adat.addX = sct_SPRINKLER;
				adat.addY = math.sqrt((sct_SPRINKLER_RADIUS ^ 2) - math.abs((sct_SPRINKLER ^ 2)))
				if ( adat.direction) then
					adat.addY = adat.addY * -1;
				end
				sct_SPRINKLER = sct_SPRINKLER + sct_SPRINKLER_STEP;
				if (sct_SPRINKLER < (sct_SPRINKLER_START * -1)) then
					sct_SPRINKLER = sct_SPRINKLER_START;
				end
			end
		end
	end

	--set default color if none
	if (not color) then color = {r = 1.0, g = 1.0, b = 1.0} end
	--If they want to tag all self events
	if (self.db.profile["SHOWSELF"]) then
		msg = SCT.LOCALS.SelfFlag..msg..SCT.LOCALS.SelfFlag
	end
	
	--set up text
	self:SetFontSize(adat, adat.font, adat.textsize, adat.fontshadow);
	adat:SetTextColor(color.r, color.g, color.b);
	adat:SetAlpha(adat.alpha);
	adat:SetPoint("CENTER", "UIParent", "CENTER", adat.posX, adat.posY);
	adat:SetText(msg);
	adat:Show();
	tinsert(self.ArrayAniData[adat.frame], adat);
	--Start up onUpdate
	if (not SCT_ANIMATION_FRAME:IsVisible()) then
		SCT_ANIMATION_FRAME:Show();
	end
end

----------------------
-- Upate animations that are being used
function SCT:UpdateAnimation(elapsed)	
	local anyActive = false;
	local i, key, value;
	for i = 1, table.getn(self.ArrayAniData) do
		for key, value in self.ArrayAniData[i] do
			if (value:IsShown()) then
				anyActive = true;
				self:DoAnimation(value, elapsed);
			end
		end
	end
	--if none are active, stop onUpdate;
	if ((anyActive ~= true) and (SCT_ANIMATION_FRAME:IsVisible())) then
		SCT_ANIMATION_FRAME:Hide();
	end
end

----------------------
--Move text to get the animation
function SCT:DoAnimation(aniData, elapsed)
	local speed = self.db.profile["ANIMATIONSPEED"] / 1000;
	--If a crit			
	aniData.lastupdate = aniData.lastupdate + elapsed;
	if (aniData.crit) then		
		self:CritAnimation(aniData,speed);
	--else normal text or event text
	else
		--if its time to update, move the text step positions
		while (aniData.lastupdate > speed) do
			--calculate animation
			if (aniData.anitype == 1) then
				self:VerticalAnimation(aniData);
			elseif (aniData.anitype == 2) then
				self:RainbowAnimation(aniData);
			elseif (aniData.anitype == 3) then
				self:HorizontalAnimation(aniData);
			elseif (aniData.anitype == 4) then
				self:AngledDownAnimation(aniData);
			elseif (aniData.anitype == 5) then
				self:AngledUpAnimation(aniData);
			elseif (aniData.anitype == 6) then
				self:SprinklerAnimation(aniData);
			end
			--set update on FPS mode
			if (self.db.profile["FPSMODE"]) then
				aniData.lastupdate = aniData.lastupdate - speed;
			else
				aniData.lastupdate = 0;
			end
			--move text
			aniData:SetAlpha(aniData.alpha);
			aniData:SetPoint("CENTER", "UIParent", "CENTER", aniData.posX, aniData.posY);
			--reset when alpha is 0
			if (aniData.alpha <= 0) then
				self:AniReset(aniData);
			end
		end
	end
end

----------------------
--Do Crit Animation
function SCT:CritAnimation(aniData,speed)	
	local elapsedTime = aniData.lastupdate;
	local fadeInTime = sct_CRIT_FADEINTIME;
	if ( elapsedTime < fadeInTime ) then
		local alpha = (elapsedTime / fadeInTime);
		alpha = alpha * aniData.alpha;
		aniData:SetAlpha(alpha);
		--if flash crits are on
		if (aniData.critsize) then
			local critsize = floor(aniData.critsize - ((aniData.critsize - aniData.textsize)*(elapsedTime/sct_CRIT_FADEINTIME)));
			aniData:SetTextHeight(critsize);
		end;
		return;
	end
	--if flash crits are on, reset size to make sure its clean for display
	if (aniData.critsize) then
		aniData:SetTextHeight(aniData.textsize);
		aniData.critsize = nil;
	end
	local holdTime = (sct_CRIT_HOLDTIME * (speed/sct_MAX_SPEED));
	if ( elapsedTime < (fadeInTime + holdTime) ) then
		aniData:SetAlpha(aniData.alpha);
		return;
	end
	local fadeOutTime = sct_CRIT_FADEOUTTIME;
	if ( elapsedTime < (fadeInTime + holdTime + fadeOutTime) ) then
		local alpha = 1 - ((elapsedTime - holdTime - fadeInTime) / fadeOutTime);
		alpha = alpha * aniData.alpha;
		aniData:SetAlpha(alpha);
		return;
	end
	--reset crit
	self:AniReset(aniData);
end

----------------------
--Do Vertical Animation
function SCT:VerticalAnimation(aniData)
	local step = math.abs(aniData.addY);
	local alphastep = 0.01 * step;
	local max = sct_MAX_DISTANCE*.66
	aniData.delay = aniData.delay + 1;
	if (aniData.delay > (max/step)) then
	  aniData.alpha = aniData.alpha - alphastep;
	end
	aniData.posY = aniData.posY + aniData.addY;
end

----------------------
--Do Rainbow Animation
function SCT:RainbowAnimation(aniData)		
	if (aniData.addY > 0) then
			aniData.addY = aniData.addY - 0.22 
	else
			aniData.addY = aniData.addY - (0.18 * (self.db.profile["MOVEMENT"]/2));
	end
	if aniData.addY < -7 then aniData.addY = -7 end	;
	aniData.posY = aniData.posY + aniData.addY;
	aniData.posX = aniData.posX - 2.2 * aniData.sidedir;
	if ( aniData.posY < (aniData.bottompoint - sct_MAX_DISTANCE) ) then			
		aniData.alpha = aniData.alpha - 0.05;
	end
end

----------------------
--Do Horizontal Animation
function SCT:HorizontalAnimation(aniData)
	local step = math.abs(aniData.addX);
	local alphastep = 0.01 * step;
	local max = sct_SIDE_POINT*.5
	aniData.delay = aniData.delay + 1;
	if (aniData.delay > (max/step)) then
	  aniData.alpha = aniData.alpha - alphastep;
	end
	aniData.posX = aniData.posX - (aniData.addX * aniData.sidedir);
end

----------------------
--Do Angled Down Animation
function SCT:AngledDownAnimation(aniData)
	if (aniData.delay <= 13) then	
			aniData.delay = aniData.delay + 1;		
			aniData.posY = aniData.posY - aniData.addY;				
			aniData.posX = aniData.posX - aniData.addX * aniData.sidedir;			
	elseif (aniData.delay <= 35) then
			aniData.delay = aniData.delay + 1;
			aniData.posY = aniData.posY + (random(0,70) - 35) * 0.02;
			aniData.posX = aniData.posX + (random(0,70) - 35) * 0.02;
	elseif (aniData.delay <= 50) then
			aniData.delay = aniData.delay + 1;
	else
			aniData.posY = aniData.posY + self.db.profile["MOVEMENT"];
			aniData.posX = aniData.posX - self.db.profile["MOVEMENT"] * aniData.sidedir;
			aniData.alpha = aniData.alpha - 0.02;
	end
end

----------------------
--Do Angled Up Animation
function SCT:AngledUpAnimation(aniData)
	if (aniData.delay <= 13) then	
			aniData.delay = aniData.delay + 1;		
			aniData.posY = aniData.posY + aniData.addY;				
			aniData.posX = aniData.posX - aniData.addX * aniData.sidedir;			
	elseif (aniData.delay <= 35) then
			aniData.delay = aniData.delay + 1;
			aniData.posY = aniData.posY + (random(0,70) - 35) * 0.02;
			aniData.posX = aniData.posX + (random(0,70) - 35) * 0.02;
	elseif (aniData.delay <= 50) then
			aniData.delay = aniData.delay + 1;
	else
			aniData.posY = aniData.posY + self.db.profile["MOVEMENT"];
			aniData.alpha = aniData.alpha - 0.02;
	end
end

----------------------
--Do Sprinkler Animation
function SCT:SprinklerAnimation(aniData)
	if (aniData.delay <= (self.db.profile["MOVEMENT"] + 10)) then	
			aniData.delay = aniData.delay + 1;		
			aniData.posY = aniData.posY + aniData.addY;				
			aniData.posX = aniData.posX + aniData.addX;			
	elseif (aniData.delay <= 35) then
			aniData.delay = aniData.delay + 1;
			aniData.posY = aniData.posY + (random(0,70) - 35) * 0.02;
			aniData.posX = aniData.posX + (random(0,70) - 35) * 0.02;
	elseif (aniData.delay <= 55) then
			aniData.delay = aniData.delay + 1;
	else
			aniData.posY = aniData.posY + (aniData.addY * .1);				
			aniData.posX = aniData.posX + (aniData.addX * .1);
			aniData.alpha = aniData.alpha - 0.02;
	end
end

----------------------
--count the number of crits active
function SCT:CritCount(frame)
	local count = 0;
	local key, value;
	for key, value in self.ArrayAniData[frame] do
		if (value.crit) and (value.source == "sct") then
			count = count + 1;
		end
	end
	return count;
end

----------------------
--get the min current min point
function SCT:MinPoint(frame)	
	local posY, key, value;
	if (not self.db.profile[self.FRAMES_DATA_TABLE][frame]["DIRECTION"]) then
		posY = self.db.profile[self.FRAMES_DATA_TABLE][frame]["YOFFSET"] + sct_MAX_DISTANCE;
		for key, value in self.ArrayAniData[frame] do
			if ((value:IsShown()) and (value.posY < posY) and (value.anitype == 1) and (not value.crit)) then
				posY = value.posY;
			end
		end
	else
		posY = self.db.profile[self.FRAMES_DATA_TABLE][frame]["YOFFSET"];
		for key, value in self.ArrayAniData[frame] do
			if ((value:IsShown()) and (value.posY > posY) and (value.anitype == 1) and (not value.crit)) then
				posY = value.posY;
			end
		end
	end
	return posY;
end

-------------------------
--gets the next available animation object
--can be used by SCT addons since public
function SCT:GetNextAniObj(frame)
	local adat, i;
	local anyAvail = false;
	--get first now shown
	for i=1, sct_TEXTCOUNT do
		adat = getglobal("SCTaniData"..i);
		if ( not adat:IsShown() ) then
			anyAvail = true;
			break;
		end 
	end
	--if none availble, get oldest
	if (not anyAvail) then
		for i = 1, table.getn(self.ArrayAniData) do
			adat = self.ArrayAniData[i][1];
			if (adat) then break end;
		end
		self:AniReset(adat);
	end
	--set defaults based on frame
	adat.frame = frame;
	adat.posY = self.db.profile[self.FRAMES_DATA_TABLE][frame]["YOFFSET"];
	adat.posX = self.db.profile[self.FRAMES_DATA_TABLE][frame]["XOFFSET"];
	adat.bottompoint = adat.posY;
	adat.toppoint = adat.posY + sct_MAX_DISTANCE;
	adat.font = self.db.profile[self.FRAMES_DATA_TABLE][frame]["FONT"];
	adat.fontshadow = self.db.profile[self.FRAMES_DATA_TABLE][frame]["FONTSHADOW"];
	adat.textsize = self.db.profile[self.FRAMES_DATA_TABLE][frame]["TEXTSIZE"];
	adat.alpha = self.db.profile[self.FRAMES_DATA_TABLE][frame]["ALPHA"]/100;
	adat.anitype = self.db.profile[self.FRAMES_DATA_TABLE][frame]["ANITYPE"];
	adat.anisidetype = self.db.profile[self.FRAMES_DATA_TABLE][frame]["ANISIDETYPE"];
	adat.direction = self.db.profile[self.FRAMES_DATA_TABLE][frame]["DIRECTION"];
	adat.sidedir = self.db.profile[self.FRAMES_DATA_TABLE][frame]["ANISIDETYPE"];
	return adat
end

----------------------
--Rest the text animation
function SCT:AniReset(aniData)
	local i, key, value
	--remove it from display table
	for i = 1, table.getn(self.ArrayAniData) do
		for key, value in self.ArrayAniData[i] do
			if ( value == aniData ) then
				tremove(self.ArrayAniData[i], key);
				break;
			end
		end
	end
	--reset all setings
	aniData.crit = false;
	aniData.critsize = nil;
	aniData.posY = 0;
	aniData.posX = 0;
	aniData.addY = 0;
	aniData.addX = 0;
	aniData.alpha = 0;
	aniData.lastupdate = 0;
	aniData.delay = 0;
	aniData.source = "sct";
	aniData:SetAlpha(aniData.alpha);
	aniData:Hide();
	aniData:SetPoint("CENTER", "UIParent", "CENTER", aniData.posX, aniData.posY);
end

----------------------
--Rest all the text animations
function SCT:AniResetAll()
	for i=1, sct_TEXTCOUNT do
		local aniData = getglobal("SCTaniData"..i);
		self:AniReset(aniData);
	end
end

------------------------
--Initial animation settings
function SCT:AniInit()
	self:AniResetAll();
	self:SetMsgFont(SCT_MSG_FRAME);
	SCT_MSG_FRAME:SetPoint("CENTER", "UIParent", "CENTER", 
												 self.db.profile[self.FRAMES_DATA_TABLE][SCT.MSG]["MSGXOFFSET"],
												 self.db.profile[self.FRAMES_DATA_TABLE][SCT.MSG]["MSGYOFFSET"]);
	SCT_MSG_FRAME:SetTimeVisible(self.db.profile[self.FRAMES_DATA_TABLE][SCT.MSG]["MSGFADE"]);
	self:SetDmgFont();
end