MAX_TALENT_TABS = 5;
MAX_NUM_TALENTS = 20;
MAX_NUM_TALENT_TIERS = 8;
NUM_TALENT_COLUMNS = 4;
SPECIAL_TALENT_BRANCH_ARRAY = {};
SPECIAL_TALENT_BUTTON_SIZE = 32;
MAX_NUM_BRANCH_TEXTURES = 30;
MAX_NUM_ARROW_TEXTURES = 30;
INITIAL_SPECIAL_TALENT_OFFSET_X = 53;
INITIAL_SPECIAL_TALENT_OFFSET_Y = 45;
TALENT_POINTS_AT_60 = 51;
CYAN_FONT_COLOR_CODE = "|cff00ffff";

TALENT_BRANCH_TEXTURECOORDS = {
	up = {
		[1] = {0.12890625, 0.25390625, 0 , 0.484375},
		[-1] = {0.12890625, 0.25390625, 0.515625 , 1.0}
	},
	down = {
		[1] = {0, 0.125, 0, 0.484375},
		[-1] = {0, 0.125, 0.515625, 1.0}
	},
	left = {
		[1] = {0.2578125, 0.3828125, 0, 0.5},
		[-1] = {0.2578125, 0.3828125, 0.5, 1.0}
	},
	right = {
		[1] = {0.2578125, 0.3828125, 0, 0.5},
		[-1] = {0.2578125, 0.3828125, 0.5, 1.0}
	},
	topright = {
		[1] = {0.515625, 0.640625, 0, 0.5},
		[-1] = {0.515625, 0.640625, 0.5, 1.0}
	},
	topleft = {
		[1] = {0.640625, 0.515625, 0, 0.5},
		[-1] = {0.640625, 0.515625, 0.5, 1.0}
	},
	bottomright = {
		[1] = {0.38671875, 0.51171875, 0, 0.5},
		[-1] = {0.38671875, 0.51171875, 0.5, 1.0}
	},
	bottomleft = {
		[1] = {0.51171875, 0.38671875, 0, 0.5},
		[-1] = {0.51171875, 0.38671875, 0.5, 1.0}
	},
	tdown = {
		[1] = {0.64453125, 0.76953125, 0, 0.5},
		[-1] = {0.64453125, 0.76953125, 0.5, 1.0}
	},
	tup = {
		[1] = {0.7734375, 0.8984375, 0, 0.5},
		[-1] = {0.7734375, 0.8984375, 0.5, 1.0}
	},
};

TALENT_ARROW_TEXTURECOORDS = {
	top = {
		[1] = {0, 0.5, 0, 0.5},
		[-1] = {0, 0.5, 0.5, 1.0}
	},
	right = {
		[1] = {1.0, 0.5, 0, 0.5},
		[-1] = {1.0, 0.5, 0.5, 1.0}
	},
	left = {
		[1] = {0.5, 1.0, 0, 0.5},
		[-1] = {0.5, 1.0, 0.5, 1.0}
	},
};

--UIPanelWindows["SpecialTalentFrame"] = { area = "doublewide", pushable = 6, whileDead = 1 };

function SpecialTalentFrame_ToggleFrame()
	if ( SpecialTalentFrame:IsVisible() ) then
		HideUIPanel(SpecialTalentFrame);
	else
		ShowUIPanel(SpecialTalentFrame);
	end
end

function SpecialTalentFrame_ToggleDragged()
	if ( SpecialTalentFrame:IsVisible() ) then
		SpecialTalentFrame:Hide();
	else
		SpecialTalentFrame:Show();
	end
end

function SpecialTalentFrame_OnLoad()
	this:RegisterEvent("CHARACTER_POINTS_CHANGED");
	this:RegisterEvent("SPELLS_CHANGED");
	this:RegisterEvent("UNIT_PORTRAIT_UPDATE");
	this:RegisterEvent("ADDON_LOADED");
	for tab=1, MAX_TALENT_TABS do
		SPECIAL_TALENT_BRANCH_ARRAY[tab]={};
		for i=1, MAX_NUM_TALENT_TIERS do
			SPECIAL_TALENT_BRANCH_ARRAY[tab][i] = {};
			for j=1, NUM_TALENT_COLUMNS do
				SPECIAL_TALENT_BRANCH_ARRAY[tab][i][j] = {id=nil, up=0, left=0, right=0, down=0, leftArrow=0, rightArrow=0, topArrow=0};
			end
		end
	end
	
	this.learnMode = "learned";
	PlayerOfRealm = UnitName("player").." of "..GetRealmName();
	SpecialTalentFrame_Toggle = SpecialTalentFrame_ToggleFrame;
	
	if ( tp_webdata ) then
		SPECIAL_TALENT_CLASSES = { Druid=1, Hunter=2, Mage=3, Paladin=4, Priest=5, Rogue=6, Shaman=7, Warlock=8, Warrior=9, };
	end
end

function SpecialTalentFrame_OnShow()
	-- Stop buttons from flashing after skill up
	SetButtonPulse(TalentMicroButton, 0, 1);

	PlaySound("TalentScreenOpen");
	UpdateMicroButtons();

	SpecialTalentFrameTitleText:SetText(SPECIAL_TALENT.." - "..UnitClass("player"));
	SetPortraitTexture(SpecialTalentFramePortrait, "player");
	--show total talent points
	local tpoints = max(UnitLevel("player")-9, 0);
	SpecialTalentFrameTalentPointsText:SetText(tpoints);
	--set Planned label blue
	SpecialTalentFramePlannedCheckButtonText:SetTextColor(0,1,1);

	SpecialTalentFrame_Update();
end

function SpecialTalentFrame_OnHide()
	UpdateMicroButtons();
	PlaySound("TalentScreenClose");
end

function SpecialTalentFrame_Minimize()
	SpecialTalentFrameSaved.frameMinimized=1;
	if ( not SpecialTalentFrameSaved.tabShown ) then
		SpecialTalentFrameSaved.tabShown=1;
	end
	SpecialTalentFrameMinimizeButton:SetText("^");
	UIPanelWindows["SpecialTalentFrame"] = { area = "left", pushable = 6, whileDead = 1 };
	SpecialTalentFrame:SetWidth(345);
	SpecialTalentFrame:SetHeight(586);
	for i=2, 4 do
		getglobal("SpecialTalentFrameBorder_TopLeft"..i):Hide();
		getglobal("SpecialTalentFrameBorder_BottomLeft"..i):Hide();		
	end
	for i=1, MAX_TALENT_TABS do
		local button=getglobal("SpecialTalentFrameTab"..i);
		if ( not button ) then
			break;
		end
		button:Show();
		
		getglobal("SpecialTalentFrameTabFrame"..i):SetPoint("TOPLEFT", SpecialTalentFrame, "TOPLEFT", 0, -80);
	end

	SpecialTalentFrameTalentPointsText:Hide();
	SpecialTalentFrameTalentPoints:Hide();
	SpecialTalentFrameUnspentPointsText:SetPoint("LEFT", SpecialTalentFrame, "TOP", -145, -84);
	--SpecialTalentFrameUnspentPoints:Hide();

	SpecialTalentFrameLearnedPointsText:SetPoint("RIGHT", SpecialTalentFrame, "TOP", 122, -65);
	SpecialTalentFramePlannedPointsText:SetPoint("RIGHT", SpecialTalentFrame, "TOP", 122, -84);
	SpecialTalentFrameLearnedCheckButton:SetPoint("RIGHT", SpecialTalentFrame, "TOP", -19, -65);
	SpecialTalentFramePlannedCheckButton:SetPoint("RIGHT", SpecialTalentFrame, "TOP", -19, -84);

	SpecialTalentFrameForceShiftCheckButton:SetPoint("LEFT", SpecialTalentFrame, "TOPLEFT", 215, -46);
end

function SpecialTalentFrame_Maximize()
	SpecialTalentFrameSaved.frameMinimized=nil;
	SpecialTalentFrameMinimizeButton:SetText("v");
	UIPanelWindows["SpecialTalentFrame"] = { area = "doublewide", pushable = 6, whileDead = 1 };
	SpecialTalentFrame:SetWidth(900);
	SpecialTalentFrame:SetHeight(586);
	for i=2, 4 do
		getglobal("SpecialTalentFrameBorder_TopLeft"..i):Show();
		getglobal("SpecialTalentFrameBorder_BottomLeft"..i):Show();		
	end
	for i=1, MAX_TALENT_TABS do
		local button=getglobal("SpecialTalentFrameTab"..i);
		if ( not button ) then
			break;
		end
		button:Hide();
		
		getglobal("SpecialTalentFrameTabFrame"..i):SetPoint("TOPLEFT", SpecialTalentFrame, "TOPLEFT", (i-1)*278, -80);
	end

	SpecialTalentFrameTalentPointsText:Show();
	SpecialTalentFrameTalentPoints:Show();
	SpecialTalentFrameUnspentPointsText:SetPoint("LEFT", SpecialTalentFrame, "TOP", 25, -81);
	--SpecialTalentFrameUnspentPoints:SetPoint("RIGHT");

	SpecialTalentFrameLearnedPointsText:SetPoint("RIGHT", SpecialTalentFrame, "TOP", -25, -60);
	SpecialTalentFramePlannedPointsText:SetPoint("RIGHT", SpecialTalentFrame, "TOP", -25, -81);
	SpecialTalentFrameLearnedCheckButton:SetPoint("RIGHT", SpecialTalentFrame, "TOP", -165, -60);
	SpecialTalentFramePlannedCheckButton:SetPoint("RIGHT", SpecialTalentFrame, "TOP", -165, -81);

	SpecialTalentFrameForceShiftCheckButton:SetPoint("LEFT", SpecialTalentFrame, "TOPLEFT", 215, -60);
end

function SpecialTalentFrame_OnEvent()
	if ( (event == "CHARACTER_POINTS_CHANGED") or (event == "SPELLS_CHANGED") ) then
		SpecialTalentFrame_Update();
	elseif ( event == "UNIT_PORTRAIT_UPDATE" ) then
		if ( arg1 == "player" ) then
			SetPortraitTexture(SpecialTalentFramePortrait, "player");
		end
	elseif ( event=="ADDON_LOADED" and arg1=="SpecialTalentUI" ) then
		this:UnregisterEvent("ADDON_LOADED");
		if ( not SpecialTalentFrameSaved ) then
			SpecialTalentFrameSaved={};
		end
		SpecialTalent_LoadPlannedSaved();
		SpecialTalentFrame_CheckDragged();
		SpecialTalentFrameTabs_Initialize();
	end
	
end

function SpecialTalentFrameTalent_OnEvent()
	if ( GameTooltip:IsOwned(this) ) then
		GameTooltip:SetTalent(this.tabID, this:GetID());
	end
end

function SpecialTalentFrame_OnDrag()
	if ( not SpecialTalentFrameSaved ) then
		SpecialTalentFrameSaved={};
	end
	SpecialTalentFrameSaved.frameDragged = 1;
	SpecialTalentFrameSaved.frameLeft = SpecialTalentFrame:GetLeft();
	SpecialTalentFrameSaved.frameTop = SpecialTalentFrame:GetTop();
	SpecialTalentFrame:SetUserPlaced(0);
	SpecialTalentFrame_CheckDragged();
end

function SpecialTalentFrame_Update()
	local numTabs = GetNumTalentTabs();
	local learnedText = SpecialTalentFrameLearnedPointsText;
	local plannedText = SpecialTalentFramePlannedPointsText;
	local learned = "";
	local planned = "";
	local player = PlayerOfRealm;
	
	SpecialTalentFrame_UpdateTalentPoints();

	for f=1, MAX_TALENT_TABS do -- for each tab frame

		local talentTabName = GetTalentTabInfo(f);
		if ( not talentTabName ) then
			break;
		end
		getglobal("SpecialTalentFrameTabFrame"..f):Hide();
		local base;
		local name, iconTexture, pointsSpent, fileName = GetTalentTabInfo(f);
		if ( talentTabName ) then
			base = "Interface\\TalentFrame\\"..fileName.."-";
		else
			-- temporary default for classes without talents poor guys
			base = "Interface\\TalentFrame\\MageFire-";
		end
		getglobal("SpecialTalentFrameTabFrame"..f.."BackgroundTopLeft"):SetTexture(base.."TopLeft");
		getglobal("SpecialTalentFrameTabFrame"..f.."BackgroundTopRight"):SetTexture(base.."TopRight");
		getglobal("SpecialTalentFrameTabFrame"..f.."BackgroundBottomLeft"):SetTexture(base.."BottomLeft");
		getglobal("SpecialTalentFrameTabFrame"..f.."BackgroundBottomRight"):SetTexture(base.."BottomRight");

		if ( f > 1 ) then
			learned = learned.."/";
			planned = planned.."/";
		end
		learned = learned..pointsSpent;
		planned = planned..SpecialTalentPlannedSaved[player][f].points;
		getglobal("SpecialTalentFrameTabFrame"..f.."SpentPoints"):SetText(format(MASTERY_POINTS_SPENT, name).." "..NORMAL_FONT_COLOR_CODE..pointsSpent..FONT_COLOR_CODE_CLOSE);
		getglobal("SpecialTalentFrameTabFrame"..f.."SpentPoints"):SetText(CYAN_FONT_COLOR_CODE .. SpecialTalentPlannedSaved[player][f].points .. "|r :"..RED_FONT_COLOR_CODE..talentTabName.."|r: "..NORMAL_FONT_COLOR_CODE..pointsSpent.."|r");
		getglobal("SpecialTalentFrameTabFrame"..f).pointsSpent = pointsSpent;

		local numTalents = GetNumTalents(f);
		-- Just a reminder error if there are more talents than available buttons
		if ( numTalents > MAX_NUM_TALENTS ) then
			message("Too many talents in talent frame!");
		end

		SpecialTalentFrame_ResetBranches(f);
		local tier, column, rank, maxRank, isExceptional, isLearnable;
		local forceDesaturated, tierUnlocked;
		local button;

		getglobal("SpecialTalentFrameTabFrame"..f).greatestTier = 0;
		
		if ( not SpecialTalentFrameSaved.frameMinimized or SpecialTalentFrameSaved.tabShown==f ) then
			getglobal("SpecialTalentFrameTabFrame"..f):Show();
			for i=1, MAX_NUM_TALENTS do
				button = getglobal("SpecialTalentFrameTabFrame"..f.."Talent"..i);
				if ( i <= numTalents ) then
					-- Set the button info
					name, iconTexture, tier, column, rank, maxRank, isExceptional, meetsPrereq = GetTalentInfo(f, i);

					-- Show planned points and border if necessary
					local plannedPoints = SpecialTalentPlannedSaved[player][f][i];
					if ( not plannedPoints or plannedPoints<1 ) then
						getglobal("SpecialTalentFrameTabFrame"..f.."Talent"..i.."Planned"):Hide();
						getglobal("SpecialTalentFrameTabFrame"..f.."Talent"..i.."PlannedBorder"):Hide();
					else
						getglobal("SpecialTalentFrameTabFrame"..f.."Talent"..i.."Planned"):SetText(plannedPoints);
						getglobal("SpecialTalentFrameTabFrame"..f.."Talent"..i.."Planned"):SetTextColor(0,1,1);
						getglobal("SpecialTalentFrameTabFrame"..f.."Talent"..i.."Planned"):Show();
						getglobal("SpecialTalentFrameTabFrame"..f.."Talent"..i.."PlannedBorder"):Show();
					end

					-- Show learned points and border if necessary
					if ( rank > 0 ) then
						if ( rank < maxRank ) then
							getglobal( "SpecialTalentFrameTabFrame"..f.."Talent"..i.."Rank" ):SetTextColor( GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b );
						else
							getglobal( "SpecialTalentFrameTabFrame"..f.."Talent"..i.."Rank" ):SetTextColor( NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b );
						end
						getglobal("SpecialTalentFrameTabFrame"..f.."Talent"..i.."Rank"):SetText(rank);
						getglobal("SpecialTalentFrameTabFrame"..f.."Talent"..i.."RankBorder"):Show();
						getglobal("SpecialTalentFrameTabFrame"..f.."Talent"..i.."Rank"):Show();
					else
						getglobal("SpecialTalentFrameTabFrame"..f.."Talent"..i.."RankBorder"):Hide();
						getglobal("SpecialTalentFrameTabFrame"..f.."Talent"..i.."Rank"):Hide();
					end

					SetSpecialTalentButtonLocation(button, tier, column);
					SPECIAL_TALENT_BRANCH_ARRAY[f][tier][column].id = button:GetID();
					SetItemButtonTexture(button, iconTexture);

					-- Determine learning or planning mode
					local tabPointsSpent, talentPoints, requirementsMet;
					if ( SpecialTalentFrame.learnMode == "learned" ) then
						tabPointsSpent = getglobal("SpecialTalentFrameTabFrame"..f).pointsSpent;
						talentPoints = SpecialTalentFrame.talentPoints;
					elseif ( SpecialTalentFrame.learnMode == "planned" ) then
						tabPointsSpent = SpecialTalentPlannedSaved[player][f].points;
						talentPoints = TALENT_POINTS_AT_60 - SpecialTalentPlannedSaved[player].points;
						rank = SpecialTalentPlannedSaved[player][f][i] or 0;
					end

					-- If player has no talent points then show only talents with points in them
					if ( talentPoints <= 0 and rank == 0  ) then
						forceDesaturated = 1;
					else
						forceDesaturated = nil;
					end

					-- If the player has spent at least 5 talent points in the previous tier
					if ( (tier - 1) * 5 <= tabPointsSpent ) then
						tierUnlocked = 1;
					else
						tierUnlocked = nil;
					end
					-- compare highest tier
					if ( tier > getglobal("SpecialTalentFrameTabFrame"..f).greatestTier and rank>0 ) then
						getglobal("SpecialTalentFrameTabFrame"..f).greatestTier = tier;
					end

					requirementsMet = SpecialTalentFrame_SetPrereqs(tier, column, forceDesaturated, tierUnlocked, f, SpecialTalent_GetTalentPrereqs(f, i)) and meetsPrereq;

					-- Talent must meet prereqs or the player must have no points to spend
					if ( requirementsMet ) then
						--SetItemButtonDesaturated(button, nil);
						getglobal(button:GetName().."IconTexture"):SetAlpha(1);
						button.clickable = 1;

						if ( rank < maxRank ) then
							-- Rank is green if not maxed out
							getglobal("SpecialTalentFrameTabFrame"..f.."Talent"..i.."Slot"):SetVertexColor(0.1, 1.0, 0.1);
						else
							getglobal("SpecialTalentFrameTabFrame"..f.."Talent"..i.."Slot"):SetVertexColor(1.0, 0.82, 0);
						end
					else
						--SetItemButtonDesaturated(button, 2, .65, .65, .65);
						getglobal(button:GetName().."IconTexture"):SetAlpha(.3);
						button.clickable = nil;
						getglobal("SpecialTalentFrameTabFrame"..f.."Talent"..i.."Slot"):SetVertexColor(0.5, 0.5, 0.5);
					end

					button:Show();
				else	
					button:Hide();
				end
			end
		end
	
		-- Draw the prereq branches
		local node;
		local textureIndex = 1;
		local xOffset, yOffset;
		local texCoords;
		-- Variable that decides whether or not to ignore drawing pieces
		local ignoreUp;
		local tempNode;
		SpecialTalentFrame_ResetBranchTextureCount(f);
		SpecialTalentFrame_ResetArrowTextureCount(f);
		for i=1, MAX_NUM_TALENT_TIERS do
			for j=1, NUM_TALENT_COLUMNS do
				node = SPECIAL_TALENT_BRANCH_ARRAY[f][i][j];
			
				-- Setup offsets
				xOffset = ((j - 1) * SPECIAL_TALENT_BUTTON_SIZE * 2) + INITIAL_SPECIAL_TALENT_OFFSET_X ;
				yOffset = -((i - 1) * SPECIAL_TALENT_BUTTON_SIZE * 1.75) - INITIAL_SPECIAL_TALENT_OFFSET_Y + 4;
		
				if ( node.id ) then
					-- Has talent
					if ( node.up ~= 0 ) then
						if ( not ignoreUp ) then
						SpecialTalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["up"][node.up], xOffset, yOffset + SPECIAL_TALENT_BUTTON_SIZE, f);
						else
							ignoreUp = nil;
						end
					end
					if ( node.down ~= 0 ) then
						SpecialTalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["down"][node.down], xOffset, yOffset - SPECIAL_TALENT_BUTTON_SIZE + 1, f);
					end
					if ( node.left ~= 0 ) then
							SpecialTalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["left"][node.left], xOffset - SPECIAL_TALENT_BUTTON_SIZE, yOffset, f);
					end
					if ( node.right ~= 0 ) then
						-- See if any connecting branches are gray and if so color them gray
						tempNode = SPECIAL_TALENT_BRANCH_ARRAY[f][i][j+1];	
						if ( tempNode.left ~= 0 and tempNode.down < 0 ) then
							SpecialTalentFrame_SetBranchTexture(i, j-1, TALENT_BRANCH_TEXTURECOORDS["right"][tempNode.down], xOffset + SPECIAL_TALENT_BUTTON_SIZE, yOffset, f);
						else
							SpecialTalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["right"][node.right], xOffset + SPECIAL_TALENT_BUTTON_SIZE + 1, yOffset, f);
						end
					end
					-- Draw arrows
					if ( node.rightArrow ~= 0 ) then
						SpecialTalentFrame_SetArrowTexture(i, j, TALENT_ARROW_TEXTURECOORDS["right"][node.rightArrow], xOffset + SPECIAL_TALENT_BUTTON_SIZE/2 + 5, yOffset, f);
					end
					if ( node.leftArrow ~= 0 ) then
						SpecialTalentFrame_SetArrowTexture(i, j, TALENT_ARROW_TEXTURECOORDS["left"][node.leftArrow], xOffset - SPECIAL_TALENT_BUTTON_SIZE/2 - 5, yOffset, f);
					end
					if ( node.topArrow ~= 0 ) then
						SpecialTalentFrame_SetArrowTexture(i, j, TALENT_ARROW_TEXTURECOORDS["top"][node.topArrow], xOffset, yOffset + SPECIAL_TALENT_BUTTON_SIZE/2, f);
					end
				else
					-- Doesn't have a talent
					if ( node.up ~= 0 and node.left ~= 0 and node.right ~= 0 ) then
						SpecialTalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["tup"][node.up], xOffset, yOffset, f);
					elseif ( node.down ~= 0 and node.left ~= 0 and node.right ~= 0 ) then
						SpecialTalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["tdown"][node.down], xOffset, yOffset, f);
					elseif ( node.left ~= 0 and node.down ~= 0 ) then
						SpecialTalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["topright"][node.left], xOffset , yOffset, f);
						SpecialTalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["down"][node.down], xOffset , yOffset - 32, f);
					elseif ( node.left ~= 0 and node.up ~= 0 ) then
						SpecialTalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["bottomright"][node.left], xOffset , yOffset, f);
					elseif ( node.left ~= 0 and node.right ~= 0 ) then
						SpecialTalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["right"][node.right], xOffset + SPECIAL_TALENT_BUTTON_SIZE, yOffset, f);
						SpecialTalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["left"][node.left], xOffset + 1, yOffset, f);
					elseif ( node.right ~= 0 and node.down ~= 0 ) then
						SpecialTalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["topleft"][node.right], xOffset , yOffset, f);
						SpecialTalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["down"][node.down], xOffset , yOffset - 32, f);
					elseif ( node.right ~= 0 and node.up ~= 0 ) then
						SpecialTalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["bottomleft"][node.right], xOffset , yOffset, f);
					elseif ( node.up ~= 0 and node.down ~= 0 ) then
						SpecialTalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["up"][node.up], xOffset, yOffset, f);
						SpecialTalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["down"][node.down], xOffset , yOffset - 32, f);
						ignoreUp = 1;
					end
				end
			end -- for
			-- Hide any unused branch textures
			for i=SpecialTalentFrame_GetBranchTextureCount(f), MAX_NUM_BRANCH_TEXTURES do
				getglobal("SpecialTalentFrameTabFrame"..f.."Branch"..i):Hide();
			end
			-- Hide and unused arrow textures
			for i=SpecialTalentFrame_GetArrowTextureCount(f), MAX_NUM_ARROW_TEXTURES do
				getglobal("SpecialTalentFrameTabFrame"..f.."ArrowFrameArrow"..i):Hide();
			end
		end -- if
	end --- for each tab frame
	local maxpoints = max(UnitLevel("player")-9, 0);
	local avail = maxpoints - SpecialTalentFrame.talentPoints;
	learned = learned.." = "..avail.."/"..maxpoints;
	learnedText:SetText(learned);
	planned = planned.." = "..SpecialTalentPlannedSaved[player].points.."/"..TALENT_POINTS_AT_60;
	plannedText:SetText(planned);
end

function SpecialTalentFrame_SetArrowTexture(tier, column, texCoords, xOffset, yOffset, tab)
	local arrowTexture = SpecialTalentFrame_GetArrowTexture(tab);
	arrowTexture:SetTexCoord(texCoords[1], texCoords[2], texCoords[3], texCoords[4]);
	arrowTexture:SetPoint("TOPLEFT", "SpecialTalentFrameTabFrame"..tab.."ArrowFrame", "TOPLEFT", xOffset, yOffset);
end

function  SpecialTalentFrame_SetBranchTexture(tier, column, texCoords, xOffset, yOffset, tab)
	local branchTexture =  SpecialTalentFrame_GetBranchTexture(tab);
	branchTexture:SetTexCoord(texCoords[1], texCoords[2], texCoords[3], texCoords[4]);
	branchTexture:SetPoint("TOPLEFT", "SpecialTalentFrameTabFrame"..tab, "TOPLEFT", xOffset, yOffset);
end

function SpecialTalentFrame_GetArrowTexture(tab)
	local tabframe = getglobal("SpecialTalentFrameTabFrame"..tab);
	local index = tabframe.arrowIndex;
	local arrowTexture = getglobal("SpecialTalentFrameTabFrame"..tab.."ArrowFrameArrow".. index);
	getglobal("SpecialTalentFrameTabFrame"..tab).arrowIndex = index + 1;
	if ( not arrowTexture ) then
		message("Not enough arrow textures");
	else
		arrowTexture:Show();
		return arrowTexture;
	end
end

function SpecialTalentFrame_GetBranchTexture(tab)
	local tabframe = getglobal("SpecialTalentFrameTabFrame"..tab);
	local index = tabframe.textureIndex;
	local branchTexture = getglobal("SpecialTalentFrameTabFrame"..tab.."Branch"..index);
	 tabframe.textureIndex = index + 1;
	if ( not branchTexture ) then
		message("Not enough branch textures");
	else
		branchTexture:Show();
		return branchTexture;
	end
end

function SpecialTalentFrame_ResetArrowTextureCount(tab)
	 getglobal("SpecialTalentFrameTabFrame"..tab).arrowIndex = 1;
end

function SpecialTalentFrame_ResetBranchTextureCount(tab)
	 getglobal("SpecialTalentFrameTabFrame"..tab).textureIndex = 1;
end

function SpecialTalentFrame_GetArrowTextureCount(tab)
	return  getglobal("SpecialTalentFrameTabFrame"..tab).arrowIndex;
end

function SpecialTalentFrame_GetBranchTextureCount(tab)
	return getglobal("SpecialTalentFrameTabFrame"..tab).textureIndex;
end

function SpecialTalentFrame_SetPrereqs(...)
	local buttonTier = arg[1];
	local buttonColumn = arg[2];
	local forceDesaturated = arg[3];
	local tierUnlocked = arg[4];
	local tab = arg[5];
	local tier, column, isLearnable;
	local requirementsMet;
	if ( tierUnlocked and not forceDesaturated ) then
		requirementsMet = 1;
	else
		requirementsMet = nil;
	end
	for i=6, arg.n, 3 do
		tier = arg[i];
		column = arg[i+1];
		isLearnable = arg[i+2];
		if ( not isLearnable or forceDesaturated ) then
			requirementsMet = nil;
		end
		SpecialTalentFrame_DrawLines(buttonTier, buttonColumn, tier, column, requirementsMet, tab);
	end
	return requirementsMet;
end

function SpecialTalentFrame_DrawLines(buttonTier, buttonColumn, tier, column, requirementsMet, tab)
	if ( requirementsMet ) then
		requirementsMet = 1;
	else
		requirementsMet = -1;
	end
	
	-- Check to see if are in the same column
	if ( buttonColumn == column ) then
		-- Check for blocking talents
		if ( (buttonTier - tier) > 1 ) then
			-- If more than one tier difference
			for i=tier + 1, buttonTier - 1 do
				if ( SPECIAL_TALENT_BRANCH_ARRAY[tab][i][buttonColumn].id ) then
					-- If there's an id, there's a blocker
					message("Error this layout is blocked vertically "..SPECIAL_TALENT_BRANCH_ARRAY[tab][buttonTier][i].id);
					return;
				end
			end
		end
		
		-- Draw the lines
		for i=tier, buttonTier - 1 do
			SPECIAL_TALENT_BRANCH_ARRAY[tab][i][buttonColumn].down = requirementsMet;
			if ( (i + 1) <= (buttonTier - 1) ) then
				SPECIAL_TALENT_BRANCH_ARRAY[tab][i + 1][buttonColumn].up = requirementsMet;
			end
		end
		
		-- Set the arrow
		SPECIAL_TALENT_BRANCH_ARRAY[tab][buttonTier][buttonColumn].topArrow = requirementsMet;
		return;
	end
	-- Check to see if they're in the same tier
	if ( buttonTier == tier ) then
		local left = min(buttonColumn, column);
		local right = max(buttonColumn, column);
		
		-- See if the distance is greater than one space
		if ( (right - left) > 1 ) then
			-- Check for blocking talents
			for i=left + 1, right - 1 do
				if ( SPECIAL_TALENT_BRANCH_ARRAY[tab][tier][i].id ) then
					-- If there's an id, there's a blocker
					message("there's a blocker");
					return;
				end
			end
		end
		-- If we get here then we're in the clear
		for i=left, right - 1 do
			SPECIAL_TALENT_BRANCH_ARRAY[tab][tier][i].right = requirementsMet;
			SPECIAL_TALENT_BRANCH_ARRAY[tab][tier][i+1].left = requirementsMet;
		end
		-- Determine where the arrow goes
		if ( buttonColumn < column ) then
			SPECIAL_TALENT_BRANCH_ARRAY[tab][buttonTier][buttonColumn].rightArrow = requirementsMet;
		else
			SPECIAL_TALENT_BRANCH_ARRAY[tab][buttonTier][buttonColumn].leftArrow = requirementsMet;
		end
		return;
	end
	-- Now we know the prereq is diagonal from us
	local left = min(buttonColumn, column);
	local right = max(buttonColumn, column);
	-- Don't check the location of the current button
	if ( left == column ) then
		left = left + 1;
	else
		right = right - 1;
	end
	-- Check for blocking talents
	local blocked = nil;
	for i=left, right do
		if ( SPECIAL_TALENT_BRANCH_ARRAY[tab][tier][i].id ) then
			-- If there's an id, there's a blocker
			blocked = 1;
		end
	end
	left = min(buttonColumn, column);
	right = max(buttonColumn, column);
	if ( not blocked ) then
		SPECIAL_TALENT_BRANCH_ARRAY[tab][tier][buttonColumn].down = requirementsMet;
		SPECIAL_TALENT_BRANCH_ARRAY[tab][buttonTier][buttonColumn].up = requirementsMet;
		
		for i=tier, buttonTier - 1 do
			SPECIAL_TALENT_BRANCH_ARRAY[tab][i][buttonColumn].down = requirementsMet;
			SPECIAL_TALENT_BRANCH_ARRAY[tab][i + 1][buttonColumn].up = requirementsMet;
		end

		for i=left, right - 1 do
			SPECIAL_TALENT_BRANCH_ARRAY[tab][tier][i].right = requirementsMet;
			SPECIAL_TALENT_BRANCH_ARRAY[tab][tier][i+1].left = requirementsMet;
		end
		-- Place the arrow
		SPECIAL_TALENT_BRANCH_ARRAY[tab][buttonTier][buttonColumn].topArrow = requirementsMet;
		return;
	end
	-- If we're here then we were blocked trying to go vertically first so we have to go over first, then up
	if ( left == buttonColumn ) then
		left = left + 1;
	else
		right = right - 1;
	end
	-- Check for blocking talents
	for i=left, right do
		if ( SPECIAL_TALENT_BRANCH_ARRAY[tab][buttonTier][i].id ) then
			-- If there's an id, then throw an error
			message("Error, this layout is undrawable "..SPECIAL_TALENT_BRANCH_ARRAY[tab][buttonTier][i].id);
			return;
		end
	end
	-- If we're here we can draw the line
	left = min(buttonColumn, column);
	right = max(buttonColumn, column);
	--SPECIAL_TALENT_BRANCH_ARRAY[tab][tier][column].down = requirementsMet;
	--SPECIAL_TALENT_BRANCH_ARRAY[tab][buttonTier][column].up = requirementsMet;

	for i=tier, buttonTier-1 do
		SPECIAL_TALENT_BRANCH_ARRAY[tab][i][column].up = requirementsMet;
		SPECIAL_TALENT_BRANCH_ARRAY[tab][i+1][column].down = requirementsMet;
	end

	-- Determine where the arrow goes
	if ( buttonColumn < column ) then
		SPECIAL_TALENT_BRANCH_ARRAY[tab][buttonTier][buttonColumn].rightArrow =  requirementsMet;
	else
		SPECIAL_TALENT_BRANCH_ARRAY[tab][buttonTier][buttonColumn].leftArrow =  requirementsMet;
	end
end

function SpecialTalent_PlanTalent( tabID, talentID )
	--local tabID, talentID = this.tabID, this:GetID();
	
	-- Get talent info
	local name, iconTexture, tier, column, rank, maxRank, isExceptional, meetsPrereq = GetTalentInfo(tabID, talentID);
	local saved = SpecialTalentPlannedSaved[PlayerOfRealm];
	local tab = saved[tabID];
	local plannedPoints = tab[talentID];
	local tabPoints = tab.points;
	local talentPoints = saved.points;
	
	if ( talentPoints<TALENT_POINTS_AT_60 ) then
		if ( not plannedPoints ) then
			tab[talentID] = 1;
			tab.points = tabPoints + 1;
			saved.points = talentPoints + 1;
		elseif ( plannedPoints < maxRank ) then
			plannedPoints = plannedPoints + 1;
			tab[talentID] = plannedPoints;
			tab.points = tabPoints + 1;
			saved.points = talentPoints + 1;
		end
	end
	SpecialTalentFrame_Update();
end

function SpecialTalent_UnplanTalent( tabID, talentID )
	--local tabID, talentID = this.tabID, this:GetID();
	
	-- Get talent info
	local name, iconTexture, tier, column, rank, maxRank, isExceptional, meetsPrereq = GetTalentInfo(tabID, talentID);
	local saved = SpecialTalentPlannedSaved[PlayerOfRealm];
	local tab = saved[tabID];
	local plannedPoints = tab[talentID];
	local tabPoints = tab.points;
	local talentPoints = saved.points;
	
	if ( plannedPoints and plannedPoints > 0 ) then
		-- check if tiers below and enough talentPoints to spare
		local hiTier = getglobal("SpecialTalentFrameTabFrame"..tabID).greatestTier;
		local tierPoints, tierFine, tierTotal = 0, 1, {};
		for i=1, hiTier do
			tierTotal[i]=0;
		end
		for i=1, GetNumTalents(tabID) do
			local _,_,t,_,r = SpecialTalent_GetTalentInfo(tabID, i);
			if ( t > hiTier  ) then break; end
			tierTotal[t]=tierTotal[t]+r;
			-- check dependent talents
			local rt, rc = SpecialTalent_GetTalentPrereqs(tabID, i);
			if ( rt ) then
				if ( r>0 and (rt==tier and rc==column) ) then
					tierFine=nil;
				end
			end
		end
		if ( tierFine ) then
			for i=tier+1, hiTier do
				tierPoints=0;
				for j=1, i-1 do
					tierPoints=tierPoints + tierTotal[j];
				end
				if ( tierPoints <= (i-1)*5 ) then
					tierFine=nil;
				end
			end
		end
		if ( tier==hiTier or tierFine ) then
			plannedPoints = plannedPoints > 1 and plannedPoints-1 or nil;
			tab[talentID] = plannedPoints;
			tab.points = tabPoints-1;
			saved.points = talentPoints-1;
		end
	end
	SpecialTalentFrame_Update();
end

function SpecialTalentFrameTalent_OnClick()
	local tabID, talentID = this.tabID, this:GetID();
	local force = SpecialTalentFrameSaved and SpecialTalentFrameSaved.forceShift;
	if ( SpecialTalentFrame.learnMode=="learned" ) then
		if ( not force or IsShiftKeyDown() ) then
			LearnTalent(tabID, talentID);
			SpecialTalentFrame_Update();
		end
	elseif ( SpecialTalentFrame.learnMode=="planned" ) then
		if ( IsShiftKeyDown() and force ) then
			LearnTalent(tabID, talentID);
			SpecialTalentFrame_Update();
			return;
		end
		-- check if requirements met
		if ( not this.clickable ) then
			return;
		end
		
		if ( arg1=="LeftButton" ) then
			SpecialTalent_PlanTalent( tabID, talentID );
		elseif ( arg1=="RightButton" ) then
			SpecialTalent_UnplanTalent( tabID, talentID );
		end
	end
	SpecialTalentButton_OnEnter();
end

function SpecialTalentFrameTalent_OnMouseWheel(value)
	-- check if requirements met
	if ( SpecialTalentFrame.learnMode=="planned" and this.clickable ) then
		if ( value > 0 ) then
			SpecialTalent_PlanTalent( this.tabID, this:GetID() );
		elseif ( value < 0 ) then
			SpecialTalent_UnplanTalent( this.tabID, this:GetID() );
		end
		SpecialTalentButton_OnEnter();
	end
end

-- Helper functions
function SpecialTalentFrame_UpdateTalentPoints()
	local cp1, cp2 = UnitCharacterPoints("player");
	SpecialTalentFrameUnspentPointsText:SetText(cp1);
	SpecialTalentFrame.talentPoints = cp1;
end

function SetSpecialTalentButtonLocation(button, tier, column)
	column = ((column - 1) * SPECIAL_TALENT_BUTTON_SIZE * 2) + INITIAL_SPECIAL_TALENT_OFFSET_X;
	tier = -((tier - 1) * SPECIAL_TALENT_BUTTON_SIZE * 1.75) - INITIAL_SPECIAL_TALENT_OFFSET_Y ;
	button:SetPoint("TOPLEFT", button:GetParent(), "TOPLEFT", column, tier);
end

function SpecialTalentFrame_ResetBranches(tab)
	for i=1, MAX_NUM_TALENT_TIERS do
		for j=1, NUM_TALENT_COLUMNS do
			SPECIAL_TALENT_BRANCH_ARRAY[tab][i][j].id = nil;
			SPECIAL_TALENT_BRANCH_ARRAY[tab][i][j].up = 0;
			SPECIAL_TALENT_BRANCH_ARRAY[tab][i][j].down = 0;
			SPECIAL_TALENT_BRANCH_ARRAY[tab][i][j].left = 0;
			SPECIAL_TALENT_BRANCH_ARRAY[tab][i][j].right = 0;
			SPECIAL_TALENT_BRANCH_ARRAY[tab][i][j].rightArrow = 0;
			SPECIAL_TALENT_BRANCH_ARRAY[tab][i][j].leftArrow = 0;
			SPECIAL_TALENT_BRANCH_ARRAY[tab][i][j].topArrow = 0;
		end
	end
end

function SpecialTalent_LoadPlannedSaved()
	local player= PlayerOfRealm;
	if ( not SpecialTalentPlannedSaved ) then
		SpecialTalentPlannedSaved={};
	end
	if ( not SpecialTalentPlannedSaved[player] ) then
		SpecialTalentPlannedSaved[player]={};
	end
	for t=1, MAX_TALENT_TABS do
		if ( GetTalentTabInfo(t) and not SpecialTalentPlannedSaved[player][t] ) then
			SpecialTalentPlannedSaved[player].points = 0;
			SpecialTalentPlannedSaved[player][t]={points=0};
		end
	end
end

function SpecialTalentFrameTabs_Initialize()
	for i=1, MAX_TALENT_TABS do
		local button = getglobal("SpecialTalentFrameTab"..i);
		if ( not button ) then
			break;
		end
		local name, texture = GetTalentTabInfo(i);
		button.tooltip = name;
		button:SetNormalTexture(texture);
		if ( button:GetID() == SpecialTalentFrameSaved.tabShown ) then
			button:SetChecked(1);
		end
	end
end

function SpecialTalentFrameTab_OnClick()
	for i=1, MAX_TALENT_TABS do
		local button = getglobal("SpecialTalentFrameTab"..i);
		if ( not button ) then
			break;
		end
		button:SetChecked(0);
	end
	this:SetChecked(1);
	
	SpecialTalentFrameSaved.tabShown = this:GetID();
	SpecialTalentFrame_Update();
end

function SpecialTalentFrame_CheckDragged()
	if ( SpecialTalentFrameSaved and SpecialTalentFrameSaved.frameDragged == 1 ) then
		local left = SpecialTalentFrameSaved.frameLeft;
		local top = SpecialTalentFrameSaved.frameTop;
		SpecialTalentFrame:ClearAllPoints();
		SpecialTalentFrame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top);
		UIPanelWindows["SpecialTalentFrame"] = nil;
		SpecialTalentFrame_Toggle = SpecialTalentFrame_ToggleDragged;
		if ( SpecialTalentFrameSaved.frameMinimized ) then
			SpecialTalentFrame_Minimize();
		else
			SpecialTalentFrame_Maximize();
		end
	else
		SpecialTalentFrame_ResetDrag();
	end
end

function SpecialTalentFrame_ResetDrag()
	if ( SpecialTalentFrameSaved and SpecialTalentFrameSaved.frameDragged ) then
		SpecialTalentFrameSaved.frameDragged = nil;
		SpecialTalentFrameSaved.frameLeft = nil;
		SpecialTalentFrameSaved.frameTop = nil;
	end
	if ( SpecialTalentFrameSaved.frameMinimized ) then
		SpecialTalentFrame_Minimize();
	else
		SpecialTalentFrame_Maximize();
	end
	SpecialTalentFrame_Toggle = SpecialTalentFrame_ToggleFrame;
	SpecialTalentFrame_Toggle();
	SpecialTalentFrame_Toggle();
	--SpecialTalentFrame:Hide();
	--ShowUIPanel(SpecialTalentFrame);
end

function SpecialTalentFrame_SetForceShift( force )
	if ( force ) then
		if ( not SpecialTalentFrameSaved ) then
			SpecialTalentFrameSaved = {};
		end
		SpecialTalentFrameSaved.forceShift = 1;
		SpecialTalentFrameForceShiftCheckButton:SetChecked(1);
	else
		if ( SpecialTalentFrameSaved and SpecialTalentFrameSaved.forceShift ) then
			SpecialTalentFrameSaved.forceShift = nil;
		end
		SpecialTalentFrameForceShiftCheckButton:SetChecked(0);
	end
end

function SpecialTalent_GetTalentInfo(tabID, talentID, planned)
	-- Set the button info
	local name, iconTexture, tier, column, rank, maxRank, isExceptional, meetsPrereq = GetTalentInfo(tabID, talentID);
	if ( SpecialTalentFrame.learnMode == "planned" or planned ) then
		rank = SpecialTalentPlannedSaved[PlayerOfRealm][tabID][talentID] or 0;
	end
	return name, iconTexture, tier, column, rank, maxRank, isExceptional, meetsPrereq;
end

function SpecialTalent_GetTalentPrereqs(tabID, talentID, planned)
	local prereqs = {GetTalentPrereqs(tabID, talentID)};
	local i=1;
	while prereqs[i] do
		local tier, column, isLearnable = prereqs[i], prereqs[i+1], prereqs[i+2];
		local _, _, _, _, rank, maxRank = SpecialTalent_GetTalentInfo(tabID, SPECIAL_TALENT_BRANCH_ARRAY[tabID][tier][column].id, (SpecialTalentFrame.learnMode == "planned" or planned) );
		if ( rank==maxRank ) then
			prereqs[i+2]=1;
		else
			prereqs[i+2]=nil;
		end
		i=i+3;
	end
	return unpack(prereqs);
end

function SpecialTalentButton_OnEnter()
	local tabID, talentID = this.tabID, this:GetID()
	GameTooltip:Hide();
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetTalent(tabID, talentID);
	if ( tp_webdata ) then -- requires either Talent Planner addon or WebData.lua in SpecialTalentUI folder
		local name, texture, row, col, rank, maxRank = GetTalentInfo( tabID, talentID );
		local class = SPECIAL_TALENT_CLASSES[UnitClass("player")];
		local goalRank = SpecialTalentPlannedSaved[PlayerOfRealm][tabID][talentID];
		if ( not goalRank or not class ) then return; end
		if ( (goalRank==1 and rank==0) or (goalRank==rank) ) then
			local text=GameTooltipTextLeft2:GetText();
			GameTooltipTextLeft2:SetText( text.."\n"..CYAN_FONT_COLOR_CODE..format(PLANNED_RANK, goalRank, maxRank).."|r" );
		elseif ( goalRank==rank+1 ) then
			GameTooltipTextLeft5:SetText( format(PLANNED_RANK, goalRank, maxRank));
			GameTooltipTextLeft5:SetTextColor(0, 1.0, 1.0);
		else
			GameTooltip:AddLine( " " );
			GameTooltip:AddLine( format(PLANNED_RANK, goalRank, maxRank), 0, 1.0, 1.0 );
			GameTooltip:AddLine( tp_webdata[class][tabID][talentID][goalRank], 1.0, 0.82, 0.0, 1.0, 1 );
		end
		GameTooltip:Show();
	end
end