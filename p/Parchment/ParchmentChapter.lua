function ParchmentAddChapterFrame_OnShow()
	-- Tooltips
	ParchmentAddChapterFrame_AllRealms.tooltip = "The Chapter is viewable regardless of what realm you're on";
	ParchmentAddChapterFrame_ThisRealm.tooltip = "The Chapter is set to your current realm";

	-- Text
	--getglobal(ParchmentAddChapterFrame_NewChapter:GetName().."Text"):SetText("|cffcc0000Chapter Name|r");
	getglobal(ParchmentAddChapterFrame_AllRealms:GetName().."Text"):SetText("All Realms");
	getglobal(ParchmentAddChapterFrame_ThisRealm:GetName().."Text"):SetText("This Realm");
	ParchmentAddChapterFrameTitle:SetText("Add a Chapter");
	ParchmentAddChapterFrameInfo:SetText("Just type in the name of the new Chapter below. The option 'All Realms' indicates it will be seen from any realm, or 'This Realm' for it to be a realm based Chapter. |cffffff00NOTE:|r Use only single words for Chapter names");

	-- Checkbox defaults to false
	ParchmentAddChapterFrame_AllRealms:SetChecked(false);
	ParchmentAddChapterFrame_ThisRealm:SetChecked(false);
	ParchmentAddChapterFrame_NewChapter:SetText("");
end

function ParchmentAddChapterOption_OnClick()
	local checked = this:GetChecked();

	if(ParchmentAddChapterFrame_AllRealms:GetChecked()) then
		ParchmentAddChapterFrame_ThisRealm:Disable();
	elseif(ParchmentAddChapterFrame_ThisRealm:GetChecked()) then
		ParchmentAddChapterFrame_AllRealms:Disable();
	else
		ParchmentAddChapterFrame_ThisRealm:Enable();
		ParchmentAddChapterFrame_AllRealms:Enable();
	end

	if(not checked) then
		PlaySound("igMainMenuOptionCheckBoxOff");
	else
		PlaySound("igMainMenuOptionCheckBoxOn");
	end
end

function ParchmentAddChapter()
	local action = "";

	if(ParchmentAddChapterFrame_AllRealms:GetChecked()) then
		action = "add all " .. ParchmentAddChapterFrame_NewChapter:GetText();
	else
		action = "add realm " .. ParchmentAddChapterFrame_NewChapter:GetText();
	end

	Parchment_SlashCommandHandler(action);

	if(ParchmentFrame:IsVisible()) then
		ParchmentTab_OnClick(1)
	end
end