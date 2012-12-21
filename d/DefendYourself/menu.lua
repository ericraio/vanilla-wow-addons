local DYMenuArray = { "On", "Yellow", "Faction", "Debuff", "Safe", "Assist" };
local DYMenuTipArray = { "Toggle DefendYourself! On/Off", "Ignore yellow creatures", "Ignore opposing faction members", "Ignore debuffed creatures", "Bloodlust: Will attack regardless of if you're in combat", "Smart Assist: Target what your party is working on" };
local DYMenuTextArray = {"Toggle", "Yellow", "Faction", "Debuff", "Bloodlust", "Assist" };
function DYMenu_Show()
	if not DYKey then this:GetParent():Hide(); return; end
	local dyms = DYKey[DYMenuArray[this:GetID()]]
	if dyms then
		this:SetChecked(1);
	else
		this:SetChecked(0);
	end
	dyms = nil;
	getglobal(this:GetName().."Text"):SetText(DYMenuTextArray[this:GetID()]);
end
function DYMenu_Click()
	if not DYKey then this:GetParent():Hide(); return; end
	if this:GetChecked() then
		DYKey[DYMenuArray[this:GetID()]] = true;
	else
		DYKey[DYMenuArray[this:GetID()]] = nil;
	end
end
function DYMenu_Enter()
	if not DYKey then this:GetParent():Hide(); return; end
	local msg = DYMenuTipArray[this:GetID()];
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetBackdropColor(0.0, 0.0, 0.0);
	if msg ~= nil then GameTooltip:SetText(msg, 1.0, 1.0, 1.0); end
end