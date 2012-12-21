IMBA_BarColorNumber=0;

IMBA_BarTextures={}

IMBA_BarTextures[1]={name="Default";texture="Interface\\AddOns\\IMBA\\textures\\BarTextures\\Normal"}
IMBA_BarTextures[2]={name="Smooth";texture="Interface\\AddOns\\IMBA\\textures\\BarTextures\\Smooth"}
IMBA_BarTextures[3]={name="Striped";texture="Interface\\AddOns\\IMBA\\textures\\BarTextures\\Striped"}
IMBA_BarTextures[4]={name="Gradient";texture="Interface\\AddOns\\IMBA\\textures\\BarTextures\\CandyBar"}
IMBA_BarTextures[5]={name="Blizzard";texture="Interface\\TargetingFrame\\UI-TargetingFrame-BarFill"}


IMBA_BG={};
IMBA_BG[1] = {	
	name="Tooltip";
	close="Interface\\AddOns\\IMBA\\textures\\close";
	table = { 
	  bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
	  edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 0, edgeSize = 16, 
	  insets = { left = 5, right = 5, top = 5, bottom = 5 }
	}
};

IMBA_BG[2] = {	
	name="Plain";
	close="Interface\\AddOns\\IMBA\\textures\\close2";
	table = { 
	  bgFile = "Interface\\AddOns\\IMBA\\textures\\PlainBackdrop", 
	  edgeFile = "Interface\\AddOns\\IMBA\\textures\\PlainBackdrop", tile = true, tileSize = 0, edgeSize = 1, 
	  insets = { left = 0, right = 0, top = 0, bottom = 0 }
	}
};
IMBA_BG[3] = {	
	table = { 
	  bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
	  edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = nil, tileSize = 32, edgeSize = 32,
	  insets = { left = 11, right = 12, top = 12, bottom = 11}
	}
};
IMBA_BG[4] = {	
	table = { 
	  bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
	  edgeFile = "Interface\\Buttons\\UI-SliderBar-Border", tile = nil, tileSize = 8, edgeSize = 8,
	  insets = { left = 3, right = 3, top = 6, bottom = 6 }
	}
};

IMBA_BG[5] = {	
	table = { 
	  bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
	  edgeFile = "Interface\\Glues\\Common\\Glue-Tooltip-Border", tile = true, tileSize = 0, edgeSize = 8, 
	  insets = { left = 5, right = 4, top = 4, bottom = 5 }
	}
};


function IMBA_SetBarTexture()
	if this.BarTextureNum~=IMBA_SavedVariables.BarTextureNum then
		this.BarTextureNum=IMBA_SavedVariables.BarTextureNum;
		this:SetStatusBarTexture(IMBA_BarTextures[IMBA_SavedVariables.BarTextureNum].texture);
	end
end

function IMBA_SetBarColor(val,bar)	
	if bar==nil then
		bar=this;
	end
	val=math.min(math.max(val,0),1);
	if IMBA_SavedVariables.CustomBarColors then
		local r,g,b
		r=(1-val)*IMBA_SavedVariables.Colors["BarEnd"].r+val*IMBA_SavedVariables.Colors["BarStart"].r
		g=(1-val)*IMBA_SavedVariables.Colors["BarEnd"].g+val*IMBA_SavedVariables.Colors["BarStart"].g
		b=(1-val)*IMBA_SavedVariables.Colors["BarEnd"].b+val*IMBA_SavedVariables.Colors["BarStart"].b
		this:SetStatusBarColor(r,g,b,0.9);
	else
		if val<0.6666 then
			this:SetStatusBarColor(1.0,val*3/2,0.0,0.9);
		else
			this:SetStatusBarColor(1.0-(val-0.6666)*3,1.0,0.0,0.9);
		end
	end
end

function IMBA_SetBarBorderAndBG()
	if this.ColorNumber~=IMBA_BarColorNumber then
		if IMBA_SavedVariables.CustomBarColors then
			getglobal(this:GetName().."BG"):SetBackdropBorderColor(IMBA_SavedVariables.Colors["BarBorder"].r,IMBA_SavedVariables.Colors["BarBorder"].g,IMBA_SavedVariables.Colors["BarBorder"].b,IMBA_SavedVariables.Colors["BarBorder"].a);
			getglobal(this:GetName().."BG"):SetBackdropColor(IMBA_SavedVariables.Colors["BarInner"].r,IMBA_SavedVariables.Colors["BarInner"].g,IMBA_SavedVariables.Colors["BarInner"].b,IMBA_SavedVariables.Colors["BarInner"].a);
			this.ColorNumber=IMBA_BarColorNumber;
		else
			getglobal(this:GetName().."BG"):SetBackdropBorderColor(1.0,1.0,1.0,0.6);
			getglobal(this:GetName().."BG"):SetBackdropColor(0.4,0.4,0.4,0.6);
			this.ColorNumber=IMBA_BarColorNumber;
		end
	end
end

function IMBA_InitBarTimer(b)
	local scTarget = b:GetName().."_Texture";
	getglobal(scTarget):SetVertexColor(0,0.8,0,1);
	b:SetMinMaxValues(0,1); 
	b:SetValue(0);
	b.LText = getglobal(b:GetName().."_Text");
	b.RText = getglobal(b:GetName().."_TextVal");
	b.SelfBar = this;
	b.canBeSeen = false;
	function b:SetBarText(text)
		if text == nil then
			self.LText:SetText(" ");
			self.SelfBar:Hide();
		else
			self.LText:SetText(" "..text);
			self.SelfBar:Show();
		end
	end
	function b:SetValText(text)
		self.RText:SetText(text.." ");
	end
	function b:GetFontSize()
		return math.floor(self.LText:GetHeight() + 0.5);
	end
	function b:SetFontSize(h)
		self.LText:SetTextHeight(h);
		self.RText:SetTextHeight(h);
	end

	b.LText:SetTextColor(1.0,1.0,1.0);
	b.RText:SetTextColor(1.0,1.0,1.0);
	b.active=false;
	b.repeating=false;
	b.timeLength=0;
	b.timeEnd=0;
	b.timeUpdate=0;

	function b:UpdateTimer()
		local theTime=GetTime();
		
		if b.timeUpdate>theTime then
			return
		end
		IMBA_SetBarBorderAndBG();
		IMBA_SetBarTexture();
		b.timeUpdate=theTime+0.03;
		if this.active then
			timeDiff=this.timeEnd-theTime;
			this:SetValText(string.format("%.0fs",timeDiff));
			if timeDiff<=0 then
				if this.repeating == true then
					while timeDiff<=0 do 
						timeDiff=timeDiff+this.timeLength;
						this.timeEnd=this.timeEnd+this.timeLength;
						this.warned=false;
						if this.callback then
							this:callback();
						end
					end
				else
					timeDiff=0;
					this.active=false;
					if this.callback then
						this:callback();
					end
				end
				this:SetValText(string.format("%.0fs",timeDiff));				
			end
			val=timeDiff/this.timeLength;
			this:SetValue(val);
			IMBA_SetBarColor(val);

			if (this.warnMsg~=nil) and (this.warned~=true) and (theTime>(this.timeEnd-this.warnOffset)) then
				this.warned=true;
				IMBA_AddRaidAlert(this.warnMsg,b.alertRaid,b.alertSelf);
			end
			
		end
	end

	function b:StartTimer(length,repeatTimer,Callback,offset)
		if offset==nil then
			offset=0;
		end
		if repeatTimer==nil then
			repeatTimer=false;
		end
		b.active=true;
		b.timeEnd=GetTime()+length-offset;
		b.timeLength=length;
		b.repeating=repeatTimer;
		if Callback then
			b.callback=Callback;
		else
			b.callback=nil;
		end
		b.warned=true;
	end
	function b:StartWarningTimer(msg,offset,alertRaid,alertSelf)
		b.warnOffset=offset;
		b.warnMsg=msg;
		b.alertRaid=alertRaid;
		b.alertSelf=alertSelf;
		b.warned=false;
	end
end

function IMBA_InitUnitHealth(b)
	local scTarget = b:GetName().."_Texture";
	getglobal(scTarget):SetVertexColor(0,0.8,0,1);
	b:SetMinMaxValues(0,1); 
	b:SetValue(1);
	b.LText = getglobal(b:GetName().."_Text");
	b.RText = getglobal(b:GetName().."_TextVal");
	b.SelfBar = this;
	b.canBeSeen = false;
	b.unit=nil;
	function b:SetBarText(text)
		if text == nil then
			self.LText:SetText(" ");
			self.SelfBar:Hide();
		else
			self.LText:SetText(" "..text);
			self.SelfBar:Show();
		end
	end
	function b:SetValText(text)
		self.RText:SetText(text.." ");
	end
	function b:GetFontSize()
		return math.floor(self.LText:GetHeight() + 0.5);
	end
	function b:SetFontSize(h)
		self.LText:SetTextHeight(h);
		self.RText:SetTextHeight(h);
	end

	b.LText:SetTextColor(1.0,1.0,1.0);
	b.RText:SetTextColor(1.0,1.0,1.0);
	b.active=false;
	b.repeating=false;
	b.timeLength=0;
	b.timeEnd=0;
	b.timeUpdate=0;


	function b:UpdateUnitHealth()
		local val;
		
		if b.timeUpdate>GetTime() then
			return
		end
		IMBA_SetBarBorderAndBG();
		IMBA_SetBarTexture();
		
		if this.unit~=nil and UnitExists(this.unit) then			
			this:SetBarText(UnitName(this.unit));
			this:SetValText(UnitHealthMax(this.unit)-UnitHealth(this.unit));
			
			val=UnitHealth(this.unit)/UnitHealthMax(this.unit);
			this:SetValue(val);
			IMBA_SetBarColor(val);
			if this.ClassColor then
				local playerClass, englishClass = UnitClass(this.unit);
				local color = RAID_CLASS_COLORS[englishClass];
				if color then
					this:SetStatusBarColor(color.r, color.g, color.b, 0.9);
				end
			end
			b.timeUpdate=GetTime()+0.05;
		else
			this:SetBarText("None");
			this:SetValText("");
			val=0;
			this:SetValue(val);
			IMBA_SetBarColor(val);
			b.timeUpdate=GetTime()+0.1;
		end
	end

	function b:UnitHealthOnClick()
		if b.unit~=nil and UnitExists(b.unit) then
			if ( SpellIsTargeting() ) then
				SpellTargetUnit(b.unit)
			else
				TargetUnit(b.unit)
			end
		end
	end
end

function IMBA_InitRaidIconHealth(b)
	local scTarget = b:GetName().."_Texture";
	getglobal(scTarget):SetVertexColor(0,0.8,0,1);
	b:SetMinMaxValues(0,1); 
	b:SetValue(1);
	b.LText = getglobal(b:GetName().."_Text");
	b.RText = getglobal(b:GetName().."_TextVal");
	b.SelfBar = this;
	b.canBeSeen = false;
	b.RaidIcon=nil
	b.unit=nil;
	function b:SetBarText(text)
		if text == nil then
			self.LText:SetText(" ");
			self.SelfBar:Hide();
		else
			self.LText:SetText(" "..text);
			self.SelfBar:Show();
		end
	end
	function b:SetValText(text)
		self.RText:SetText(text.." ");
	end
	function b:GetFontSize()
		return math.floor(self.LText:GetHeight() + 0.5);
	end
	function b:SetFontSize(h)
		self.LText:SetTextHeight(h);
		self.RText:SetTextHeight(h);
	end

	b.LText:SetTextColor(1.0,1.0,1.0);
	b.RText:SetTextColor(1.0,1.0,1.0);
	b.active=false;
	b.repeating=false;
	b.timeLength=0;
	b.timeEnd=0;
	b.UnitName="";
	b.LockoutTime=0;
	b.timeUpdate=0;

	function b:UpdateRaidIconHealth()
		local val;
		
		if b.timeUpdate>GetTime() then
			return
		end
		IMBA_SetBarBorderAndBG();
		IMBA_SetBarTexture();

		if this.RaidIcon~=nil then			
			if ((this.unit==nil) or (not UnitExists(this.unit)) or (GetRaidTargetIndex(this.unit)~=this.RaidIcon)) and (b.LockoutTime<GetTime()) then
				this.unit=IMBA_GetRaidIconUnitID(this.RaidIcon);
				b.LockoutTime=GetTime()+0.2;
			end
			if (this.unit~=nil) and UnitExists(this.unit) then
				this.UnitName=UnitName(this.unit)
				if string.len(this.UnitName)>=15 then
					this.UnitName=string.sub(this.UnitName,1,14).."...";
				end
				this:SetBarText(this.UnitName);
				
				
				val=UnitHealth(this.unit)/UnitHealthMax(this.unit);

				this:SetValText(floor(val*100).."%");
				this:SetValue(val);
				IMBA_SetBarColor(val);
			else
				if this.UnitName=="" then
					this:SetBarText("(Can't Find)");
				end

				this:SetStatusBarColor(0.5,0.5,0.5,0.9);
			end
			b.timeUpdate=GetTime()+0.05;
		else
			this:SetBarText("None");
			this:SetValText("");
			val=0;
			this:SetValue(val);
			IMBA_SetBarColor(val);
			b.timeUpdate=GetTime()+0.1;
		end
	end

	function b:RaidIconHealthOnClick()
		if b.RaidIcon~=nil then			
			if (b.unit==nil) or (not UnitExists(b.unit)) or (GetRaidTargetIndex(b.unit)~=b.RaidIcon) then
				b.unit=IMBA_GetRaidIconUnitID(b.RaidIcon);
			end
			if b.unit~=nil and UnitExists(b.unit) then
				if ( SpellIsTargeting() ) then
					SpellTargetUnit(b.unit)
				else
					TargetUnit(b.unit)
				end
			end
		end
	end
end

function IMBA_InitNameHealth(b)
	local scTarget = b:GetName().."_Texture";
	getglobal(scTarget):SetVertexColor(0,0.8,0,1);
	b:SetMinMaxValues(0,1); 
	b:SetValue(1);
	b.LText = getglobal(b:GetName().."_Text");
	b.RText = getglobal(b:GetName().."_TextVal");
	b.SelfBar = this;
	b.canBeSeen = false;
	b.unit=nil;
	function b:SetBarText(text)
		if text == nil then
			self.LText:SetText(" ");
			self.SelfBar:Hide();
		else
			self.LText:SetText(" "..text);
			self.SelfBar:Show();
		end
	end
	function b:SetValText(text)
		self.RText:SetText(text.." ");
	end
	function b:GetFontSize()
		return math.floor(self.LText:GetHeight() + 0.5);
	end
	function b:SetFontSize(h)
		self.LText:SetTextHeight(h);
		self.RText:SetTextHeight(h);
	end

	b.LText:SetTextColor(1.0,1.0,1.0);
	b.RText:SetTextColor(1.0,1.0,1.0);
	b.active=false;
	b.repeating=false;
	b.timeLength=0;
	b.timeEnd=0;
	this.UnitName=nil;
	b.LockoutTime=0;
	b.timeUpdate=0;

	function b:UpdateNameHealth()
		local val;
		
		if b.timeUpdate>GetTime() then
			return
		end
		IMBA_SetBarBorderAndBG();
		IMBA_SetBarTexture();

		if this.UnitName~=nil then		
			local TargetChanged;
			local TargetName;

			if ((this.unit==nil) or (not UnitExists(this.unit)) or (UnitName(this.unit)~=this.UnitName)) and (b.LockoutTime<GetTime()) then
				this.unit=IMBA_FindUnitByName(this.UnitName);
				b.LockoutTime=GetTime()+0.2;
			end

			TargetChanged=false;
			if (b.unit==nil) then 
				TargetName=UnitName("target");

				ERR_UNIT_NOT_FOUND = "";
				TargetByName(b.UnitName,true);
				ERR_UNIT_NOT_FOUND = "Unknown unit.";

				if UnitExists("target") and (UnitName("target")==b.UnitName) then
					TargetChanged=true;
					b.unit="target"
				end
			end

			this.UName=this.UnitName;
			if (this.unit~=nil) and UnitExists(this.unit) then
				if string.len(this.UName)>=15 then
					this.UName=string.sub(this.UName,1,14).."...";
				end
				this:SetBarText(this.UName);
				
				
				val=UnitHealth(this.unit)/UnitHealthMax(this.unit);

				this:SetValText(floor(val*100).."%");
				this:SetValue(val);
				IMBA_SetBarColor(val);
			else
				if string.len(this.UName)>=15 then
					this.UName=string.sub(this.UName,1,14).."...";
				end
				this:SetBarText(this.UName);
				this:SetStatusBarColor(0.5,0.5,0.5,0.9);
			end

			if TargetChanged then
				if TargetName then
					TargetLastTarget();
				else
					ClearTarget();					
				end
			end
			if this.unit==nil or TargetChanged then
				b.timeUpdate=GetTime()+0.3;
			else
				b.timeUpdate=GetTime()+0.05;
			end
		else
			this:SetBarText("None");
			this:SetValText("");
			val=0;
			this:SetValue(val);
			if val<0.6666 then
				this:SetStatusBarColor(1.0,val*3/2,0.0,0.9);
			else
				this:SetStatusBarColor(1.0-(val-0.6666)*3,1.0,0.0,0.9);
			end
			b.timeUpdate=GetTime()+0.1;
		end
	end

	function b:NameHealthOnClick()
		if b.UnitName~=nil then			
			local TargetChanged
			local TargetName

			if (b.unit==nil) or (not UnitExists(b.unit)) or (UnitName(b.unit)~=b.UnitName) then
				b.unit=IMBA_FindUnitByName(b.UnitName,true);
			end

			TargetChanged=false;
			if (b.unit==nil) then 
				TargetName=UnitName("target");

				ERR_UNIT_NOT_FOUND = "";
				TargetByName(b.UnitName,true);
				ERR_UNIT_NOT_FOUND = "Unknown unit.";

				if UnitExists("target") and (UnitName("target")==b.UnitName) then
					TargetChanged=true;
					b.unit="target"
				end
			end

			if b.unit~=nil and UnitExists(b.unit) then
				if ( SpellIsTargeting() ) then
					SpellTargetUnit(b.unit)
					if TargetChanged then
						if TargetName then
							TargetLastTarget();
						else
							ClearTarget();					
						end
					end
				elseif not TargetChanged then 
					TargetUnit(b.unit)
				end
			end
		end
	end
end

function IMBA_InitCounter(b)
	local scTarget = b:GetName().."_Texture";
	getglobal(scTarget):SetVertexColor(0,0.8,0,1);
	b:SetMinMaxValues(0,1); 
	b:SetValue(0);
	b.LText = getglobal(b:GetName().."_Text");
	b.RText = getglobal(b:GetName().."_TextVal");
	b.SelfBar = this;
	b.canBeSeen = false;
	function b:SetBarText(text)
		if text == nil then
			self.LText:SetText(" ");
			self.SelfBar:Hide();
		else
			self.LText:SetText(" "..text);
			self.SelfBar:Show();
		end
	end
	function b:SetValText(text)
		self.RText:SetText(text.." ");
	end
	function b:GetFontSize()
		return math.floor(self.LText:GetHeight() + 0.5);
	end
	function b:SetFontSize(h)
		self.LText:SetTextHeight(h);
		self.RText:SetTextHeight(h);
	end

	b.LText:SetTextColor(1.0,1.0,1.0);
	b.RText:SetTextColor(1.0,1.0,1.0);
	b.active=false;
	b.repeating=false;
	b.timeLength=0;
	b.timeEnd=0;
	b.timeUpdate=0;
	b.val=0;
	b.number=0;
	b.maxNumber=1;

	function b:UpdateCounter()
		local theTime=GetTime();
		
		if b.timeUpdate>theTime then
			return
		end
		IMBA_SetBarBorderAndBG();
		IMBA_SetBarTexture();
		b.timeUpdate=theTime+0.03;
		IMBA_SetBarColor(b.val);
	end

	function b:Increment()
		b.number=b.number+1;
		if b.number>b.maxNumber then
			b.number=b.maxNumber;
		end
		b.val=b.number/b.maxNumber;
		b:SetValue(b.val);

		b:SetValText(b.number);
	end

	function b:Decrement()
		b.number=b.number-1;
		if b.number<0 then
			b.number=0;
		end
		b.val=b.number/b.maxNumber;
		b:SetValue(b.val);

		b:SetValText(b.number);
	end

	function b:SetNum(num)
		b.number=num;

		b.val=b.number/b.maxNumber;
		b:SetValue(b.val);

		b:SetValText(b.number);
	end
end

function IMBA_InitTitleTemplate(b)
	b.LText = getglobal(b:GetName().."_Text");
	
	function b:SetText(text)
		if text == nil then
			self.LText:SetText(" ");
		else
			self.LText:SetText(" "..text);
		end
	end
	function b:GetFontSize()
		return math.floor(self.LText:GetHeight() + 0.5);
	end
	function b:SetFontSize(h)
		self.LText:SetTextHeight(h);
		self.RText:SetTextHeight(h);
	end

	b.LText:SetTextColor(1.0,1.0,1.0);
end


function IMBA_InitTextTemplate(b)
	b.LText = getglobal(b:GetName().."_Text");
	b.RText = getglobal(b:GetName().."_TextVal");
	
	function b:SetBarText(text)
		if text == nil then
			self.LText:SetText(" ");
		else
			self.LText:SetText(" "..text);
		end
	end
	function b:SetValText(text)
		self.RText:SetText(text.." ");
	end
	function b:GetFontSize()
		return math.floor(self.LText:GetHeight() + 0.5);
	end
	function b:SetFontSize(h)
		self.LText:SetTextHeight(h);
		self.RText:SetTextHeight(h);
	end

	b.LText:SetTextColor(1.0,1.0,1.0);
	b.RText:SetTextColor(1.0,1.0,1.0);	
end

function IMBA_InitTextIconTemplate(b)
	b.LText = getglobal(b:GetName().."_Text");
	b.RIcon = getglobal(b:GetName().."_Icon");
	
	function b:SetBarText(text)
		if text == nil then
			self.LText:SetText(" ");
		else
			self.LText:SetText(" "..text);
		end
	end
	function b:SetIcon(file)
		if file==nil or file=="" then
			self.RIcon:Hide();
		else
			self.RIcon:SetTexture(file);
			self.RIcon:Show();
		end
	end
	function b:SetIconTargetIndex(num)
		if num>0 and num<9 then
			local icon = UnitPopupButtons["RAID_TARGET_"..num];
			self.RIcon:SetTexture(icon.icon);
			self.Icon:SetTexCoord(icon.tCoordLeft,icon.tCoordRight,icon.tCoordTop,icon.tCoordBottom);
			self.RIcon:Show();
		else
			self.RIcon:Hide();
		end
	end
	function b:GetFontSize()
		return math.floor(self.LText:GetHeight() + 0.5);
	end
	function b:SetFontSize(h)
		self.LText:SetTextHeight(h);
	end

	b.LText:SetTextColor(1.0,1.0,1.0);
	b.RIcon:Hide();
end

function IMBA_InitIconTemplate(b)
	b.Icon = getglobal(b:GetName().."_Icon");
	
	function b:SetIcon(file)
		if file==nil or file=="" then
			self.Icon:Hide();
		else
			self.Icon:SetTexture(file);
			self.Icon:Show();
		end
	end
	function b:SetBlipIcon()
		self.Icon:SetTexture("Interface\\Minimap\\ObjectIcons.blp");
		self.Icon:SetTexCoord(0.5,0.75,0,0.25);
		self.Icon:Show();
	end
	function b:SetIconTargetIndex(num)
		if num>0 and num<9 then
			local icon = UnitPopupButtons["RAID_TARGET_"..num];
			self.Icon:SetTexture(icon.icon);
			self.Icon:SetTexCoord(icon.tCoordLeft,icon.tCoordRight,icon.tCoordTop,icon.tCoordBottom);
			self.Icon:Show();
		else
			self.Icon:Hide();
		end
	end
	b.Icon:Hide();
end


function IMBA_InitTextFade(b)
	b.Text = getglobal(b:GetName().."_Text");
	function b:SetText(text,fade)
		if text == nil then
			self:Hide();
			self.Text:SetText(" ");
			self.TheText=" ";
			self.TextFade=0;
			self.Text:Hide();
		else
			self:Show();
			self.Text:SetText(text);
			self.TheText=text;
			self.TextFade=fade;
			self.Text:Show();
		end
	end
	function b:GetFontSize()
		return math.floor(self.Text:GetHeight() + 0.5);
	end
	function b:SetFontSize(h)
		self.Text:SetFont("Fonts\\FRIZQT__.TTF",h);
		--self.Text:SetTextHeight(h);
	end

	b.Text:SetTextColor(1.0,1.0,1.0);
	b.TextFade=0;

	function b:UpdateText()
		local TheTime,Diff;
		TheTime=GetTime();
		if self.TextFade>TheTime then
			Diff=self.TextFade-TheTime;
			if Diff>1.0 then
				self.Text:SetTextColor(1.0,1.0,1.0,1.0);
			else
				self.Text:SetTextColor(1.0,1.0,1.0,Diff);
			end
		else
			self:Hide();
			self.Text:Hide();
		end
	end
end

IMBA_Minimap_Zoom={};
IMBA_Minimap_Zoom[0]={}
IMBA_Minimap_Zoom[1]={}
--For Outside of WMO's
IMBA_Minimap_Zoom[0][0]=1;
IMBA_Minimap_Zoom[0][1]=6/7;
IMBA_Minimap_Zoom[0][2]=5/7;
IMBA_Minimap_Zoom[0][3]=4/7;
IMBA_Minimap_Zoom[0][4]=3/7;
IMBA_Minimap_Zoom[0][5]=2/7;

--For Inside of WMO's
IMBA_Minimap_Zoom[1][0]=1*0.643;
IMBA_Minimap_Zoom[1][1]=4/5*0.643;
IMBA_Minimap_Zoom[1][2]=3/5*0.643;
IMBA_Minimap_Zoom[1][3]=2/5*0.643;
IMBA_Minimap_Zoom[1][4]=4/15*0.643;
IMBA_Minimap_Zoom[1][5]=1/6*0.643;

function IMBA_InitMinimapMarker(b)
	b.active=false;
	b.Icon=getglobal(b:GetName().."_Icon");
	b.dx=0;
	b.dy=0;
	b.lastX=0;
	b.lastY=0;
	b:RegisterEvent("MINIMAP_PING");
	b.Icon:SetFrameLevel(MiniMapPing:GetFrameLevel()-1);

	function b:SetMarker(deltaX,deltaY, Icon)
		
		local zoom = IMBA_Minimap_Zoom[IMBA_isMinimapInsideWMO()][Minimap:GetZoom()];
		b.active=true;
		b.dx=deltaX*zoom;
		b.dy=deltaY*zoom;
		if Icon==nil then
			b.Icon:SetBlipIcon();
		else
			b.Icon:SetIcon(Icon);
		end
		b.Icon:Show();
	end
	function b:SetRaidMarker(deltaX,deltaY, Num)
		if Num==nil then
			Num=1;
		end
		local zoom = IMBA_Minimap_Zoom[IMBA_isMinimapInsideWMO()][Minimap:GetZoom()];
		b.active=true;
		b.dx=deltaX*zoom;
		b.dy=deltaY*zoom;
		b.Icon:SetIconTargetIndex(Num);
		b.Icon:Show();
	end
	function b:HideMarker()
		b.active=false;
		b.Icon:Hide();
	end
	function b:MarkerOnEvent(event)
		if b.active and (event=="MINIMAP_PING") then
			local zoom = IMBA_Minimap_Zoom[IMBA_isMinimapInsideWMO()][Minimap:GetZoom()];
			b.dx=b.dx+(b.lastX-arg2*zoom);
			b.dy=b.dy+(b.lastY-arg3*zoom);
			b.lastX=arg2*zoom;
			b.lastY=arg3*zoom;
		end
	end
	function b:UpdateMarker()
		if b.active then
			local mx, my = Minimap:GetPingPosition()
			local x, y;
			local zoom = IMBA_Minimap_Zoom[IMBA_isMinimapInsideWMO()][Minimap:GetZoom()];
			x = (mx+b.dx/zoom) * Minimap:GetWidth()-CURSOR_OFFSET_X;
			y = (my+b.dy/zoom) * Minimap:GetHeight()-CURSOR_OFFSET_Y;
			b.lastX=mx*zoom;
			b.lastY=my*zoom;
			if ( sqrt(x * x + y * y) < 0.95*(Minimap:GetWidth() / 2) ) then
				b.Icon:ClearAllPoints();
				b.Icon:SetPoint("CENTER", "Minimap", "CENTER", x, y);

				b.Icon:SetAlpha(255);
				b.Icon:Show();
			else
				b.Icon:Hide();
			end
		end
	end
end


function IMBA_ColorButton_Change()
	local r, g, b = ColorPickerFrame:GetColorRGB();

	if ColorPickerFrame.callFrame then
		ColorPickerFrame.callFrame.color.r=r;
		ColorPickerFrame.callFrame.color.g=g;
		ColorPickerFrame.callFrame.color.b=b;
		
		if ColorPickerFrame.callFrame.callback then
			ColorPickerFrame.callFrame:callback();
		end

		getglobal(ColorPickerFrame.callFrame:GetName().."_BG"):SetVertexColor(ColorPickerFrame.callFrame.color.r,ColorPickerFrame.callFrame.color.g,ColorPickerFrame.callFrame.color.b);
	end
end

function IMBA_ColorButton_Opacity_Change()
	if ColorPickerFrame.callFrame then
		ColorPickerFrame.callFrame.color.a=1.0-OpacitySliderFrame:GetValue();
		if ColorPickerFrame.callFrame.callback then
			ColorPickerFrame.callFrame:callback();
		end
	end
end

function IMBA_ColorButton_Cancel()
	if ColorPickerFrame.callFrame then
		ColorPickerFrame.callFrame.color=ColorPickerFrame.previousValues;
		if ColorPickerFrame.callFrame.callback then
			ColorPickerFrame.callFrame:callback();
		end
		getglobal(ColorPickerFrame.callFrame:GetName().."_BG"):SetVertexColor(ColorPickerFrame.callFrame.color.r,ColorPickerFrame.callFrame.color.g,ColorPickerFrame.callFrame.color.b);
	end
end
