local MoogMenuArray = { "SelfOn" , "Seperation", "VertPos", "TargetOn", "MobTargetPC", "PlayerTargetPC", "MobClass", "ShowIcons", "BlinkLongCast", "BlinkInstaCast", "SeperateNumbers" };
local MoogMenuTipArray = { "Show Player Info Numerically" , "Horizontal Seperation" , "Vertical Positioning", "Show Target Info Numerically", "Show Mob values as % even when real values known", "Show Player values as % even when real values known", "Show Mob Class Icon", "Show Icons (Used as menu anchors)", "Blink the HUD when spells with a cast time complete", "Blink the HUD when instacast spells complete", "Seperate numbers as well as bars" };
local MoogMenuTextArray = {"Show Self" , "Bar Seperation" , "Vertical Position", "Show Target", "Show Mob values as %", "Show Player values as %", "Show Mob Class", "Show Self/Target Icons", "Blink at end of casting", "Blink when instacasting", "Seperate Numbers"};
local MoogSliderMin = { 0 , 0 , -100 , 0, 0, 0, 0, 0, 0, 0, 0 };
local MoogSliderMax = { 0 , 150 , 200 , 0 , 0 , 0, 0, 0, 0, 0, 0 };

function MoogMenu_Show()
	local dyms = MoogHUDInfo[MoogMenuArray[this:GetID()]]
	if dyms then
		this:SetChecked(1);
	else
		this:SetChecked(0);
	end
	dyms = nil;
	getglobal(this:GetName().."Text"):SetText(MoogMenuTextArray[this:GetID()]);
end

function MoogMenu_Click()
	if this:GetChecked() then
		MoogHUDInfo[MoogMenuArray[this:GetID()]] = true;
	else
		MoogHUDInfo[MoogMenuArray[this:GetID()]] = false;
	end
	Moog_HudUpdateOptions();
end

function MoogMenu_Enter()
	local msg = MoogMenuTipArray[this:GetID()];
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetBackdropColor(0.0, 0.0, 0.0);
	if msg ~= nil then GameTooltip:SetText(msg, 1.0, 1.0, 1.0); end
end

function MoogSliderShow()
	local barmin = MoogSliderMin[this:GetID()];
	local barmax = MoogSliderMax[this:GetID()];
	if (barmin and barmax) then
		this:SetMinMaxValues(barmin,barmax);
	else
		this:SetMinMaxValues(0,1);
	end

	local dyms = MoogHUDInfo[MoogMenuArray[this:GetID()]]
	if dyms then
		this:SetValue(dyms);
	else
		this:SetValue(barmin);
	end
	dyms = nil;
	barmin = nil;
	barmax = nil;
	getglobal(this:GetName().."Text"):SetText(MoogMenuTextArray[this:GetID()]);
end

function MoogSliderOver()
	local msg = MoogMenuTipArray[this:GetID()];
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetBackdropColor(0.0, 0.0, 0.0);
	if msg ~= nil then GameTooltip:SetText(msg, 1.0, 1.0, 1.0); end
end

function MoogSliderChanged()
	MoogHUDInfo[MoogMenuArray[this:GetID()]] = this:GetValue();
	Moog_HudUpdateOptions();
end