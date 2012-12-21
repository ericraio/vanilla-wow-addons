function Parchment_Tack_OnLoad()
	this:RegisterForDrag("LeftButton");
end

function ParchmentChapterTitleButton_OnLoad()
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp");
end

function ParchmentChapterTitleButton_OnClick(button)
	local temp_id = this:GetID();

	for key, value in Parchment_Data do
		if(Parchment_Data[key].tack_button == temp_id) then
			if(button == "LeftButton") then
				if(IsShiftKeyDown()) then
					Parchment_SlashCommandHandler("untack");
				else
					if(Parchment_Data[key].tack_expand == true) then
						Parchment_Data[key].tack_expand = false;
					else
						Parchment_Data[key].tack_expand = true;
					end
				end

				Parchment_Update_Tack();
			else
				if(ParchmentFrame:IsVisible()) then
					PARCHMENT_PLAYER = key;
					ParchmentSetText();
					Parchment_Update();
				else
					PARCHMENT_PLAYER = key;
					ToggleParchment();
				end
			end
		end
	end
end

function Parchment_Update_Tack()
	Parchment_Tack_Frame:Show();
	Parchment_Tack_Frame:SetWidth(Parchment_Config.TackWidth); -- Set our width here so text can scale height correctly

	-- Is visible and is supposed to be visible, redundant so clean up later
	-- Let's set our alpha
	Parchment_UpdateAlpha();

	if(Parchment_Config.TackBorder == false) then
		Parchment_Tack_Frame:SetBackdropBorderColor(0.0, 0.0, 0.0, 0.0);
	else
		Parchment_Tack_Frame:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 1.0);
	end

	if(Parchment_Config.Minimized == false) then
		-- It's visible, flagged as shown in our variable (redundant really), and not minimized so continue so we can adjust the height accordingly
		local thisRealm = nil;
		local character = nil;
		local button_id = 1;
--		local box_width = Parchment_Tack_Frame:GetWidth() - 35; -- Frame size -10 for wrapping

		for i = 1, PARCHMENT_TACK_BUTTONS do
			getglobal("ParchmentChapterTitleButton" .. i .. "Text"):SetText("");
			getglobal("ParchmentChapterTitleButton" .. i .. "Text"):Show();
			getglobal("ParchmentChapterTitleButton" .. i):Show();

			getglobal("ParchmentChapterTextButton" .. i .. "Text"):SetText("");
			getglobal("ParchmentChapterTextButton" .. i .. "Text"):Show();
			getglobal("ParchmentChapterTextButton" .. i):Show();
		end

		for key, value in Parchment_Data do
			Parchment_Data[key].tack_button = 0;
			character = nil;

			if(button_id <= PARCHMENT_TACK_BUTTONS) then
				if(Parchment_Data[key].tacked) then
					if(Parchment_Data[key].tack_expand == nil) then
						Parchment_Data[key].tack_expand = true; -- For backwards compatibility
					end

					if(Parchment_Data[key].tack_button == nil) then
						Parchment_Data[key].tack_button = 0; -- For backwards compatibility
					end

					thisRealm = Parchment_Split(key, "|")[2];

					if(thisRealm) then
						if(Parchment_Config.AllRealms) then
							character = Parchment_Split(key,"|")[1].." of "..Parchment_Split(key,"|")[2];
						else
							if(thisRealm == GetCVar("realmName")) then
								character = Parchment_Split(key,"|")[1];
							end
						end
					else
						character = key;
					end

					if(character ~= nil) then
						if(Parchment_Data[key].tack_expand == true and Parchment_Data[key].text ~= "") then
							character = "- " .. character;
						elseif(Parchment_Data[key].text ~= "") then
							character = "+ " .. character;
						end

						getglobal("ParchmentChapterTitleButton" .. button_id .. "Text"):SetText("|c00FFFFFF"..character.."|r");
						Parchment_Data[key].tack_button = button_id;
					end

					if(character ~= nil and Parchment_Data[key].text ~= "" and Parchment_Data[key].tack_expand == true) then
						getglobal("ParchmentChapterTextButton" .. button_id .. "Text"):SetText(Parchment_Data[key].text );
					end

					if(character ~= nil) then
						button_id = button_id + 1; -- Increase the button id if we are setting data to a button
					end
				end
			end
		end

		Parchment_Tack_Resize();

	else
		Parchment_Config.Minimized = false; -- change to false so when we pass to the min function it minimzies
		Parchment_Tack_Minimize();
	end
end

function Parchment_Tack_Resize()
	local box_width = 0;
	local title_height = 0;
	local text_height = 0;
	local total_height = 0;

	-- Minimized height is 27, defined in PARCHMENT_TACK_HEIGHT, may have to add that and padding to get the right height
	box_width = Parchment_Tack_Frame:GetWidth() - 35; -- Frame size -10 for wrapping

	for i = 1, PARCHMENT_TACK_BUTTONS do
		title_text = getglobal("ParchmentChapterTitleButton" .. i .. "Text");
		title_button = getglobal("ParchmentChapterTitleButton" .. i);
		text_text = getglobal("ParchmentChapterTextButton" .. i .. "Text");
		text_button = getglobal("ParchmentChapterTextButton" .. i);

		if (title_text:IsVisible()) then
			title_text:SetWidth(box_width);
			
			total_height = total_height + title_text:GetHeight();
		
			title_button:SetWidth(title_text:GetWidth());
			title_button:SetHeight(title_text:GetHeight());
		end
		if (text_text:IsVisible()) then
			text_text:SetWidth(box_width);
			
			total_height = total_height + text_text:GetHeight();
		
			text_button:SetWidth(text_text:GetWidth());
			text_button:SetHeight(text_text:GetHeight());
		end
	end

	Parchment_Tack_Frame:SetHeight(total_height + 50);
end

function Parchment_Tack_Minimize()
	if(Parchment_Config.Minimized == true) then
		Parchment_Config.Minimized = false;
		Parchment_Update_Tack();
	else
		Parchment_Config.Minimized = true;
		Parchment_Tack_Frame:SetHeight(PARCHMENT_TACK_HEIGHT);

		for i = 1, PARCHMENT_TACK_BUTTONS do
			getglobal("ParchmentChapterTitleButton" .. i .. "Text"):Hide();
			getglobal("ParchmentChapterTitleButton" .. i):Hide();
			getglobal("ParchmentChapterTextButton" .. i .. "Text"):Hide();
			getglobal("ParchmentChapterTextButton" .. i):Hide();
		end

	end
end

function ParchmentTack_OnDragStart()
	local par = getglobal("Parchment_Tack_Frame");

	if(Parchment_Config.LockTack == false) then
		par:StartMoving();
	end
end

function ParchmentTack_OnDragStop()
	local par = getglobal("Parchment_Tack_Frame");

	if(Parchment_Config.LockTack == false) then
		par:StopMovingOrSizing();
	end
end