-- [ constants ] ---------------------------------------------
local KALENTED_TALENT_OFFSET_X    = 16;
local KALENTED_TALENT_OFFSET_Y    = 20;


-- [ variables ] ---------------------------------------------
-- Saved Variables
XKalented_TabData                 = {};

-- Local Variables
local fnTalentFrame_Update        = nil;
local iTalentPoints               = 0;
local iPointsSpent                = 0;
local strName                     = "";


-- [ XML Functions ] -----------------------------------------
-- OnLoad
function Kalented_OnLoad()
  -- [ register slash commands ]
  SlashCmdList["KALENTED"] = Kalented_SlashCommand;
  SLASH_KALENTED1 = "/kalented";

  -- Set Tab Texture and Username
  Kalented_Texture:SetTexture("Interface\\AddOns\\Kalented\\images\\calculator-" .. GetLocale());
  strName = UnitName("player");

  -- Load AddOn
  LoadAddOn("Blizzard_TalentUI");

  -- Register Events
  this:RegisterEvent("VARIABLES_LOADED");
end

-- OnEvents
function Kalented_OnEvent(event, arg1)
  if ( event == "VARIABLES_LOADED" ) then
    -- If First Time, create tables
    if ( not XKalented_TabData[strName] ) then
        Kalented_SlashCommand("clear");
    end

    -- Subclass Talent Window
    fnTalentFrame_Update = TalentFrame_Update;
    TalentFrame_Update = NewTalentFrame_Update;

    -- Show Success Load Message
    Kalented_Debug_Message("Loaded! More Info: /kalented help");
  end
end

-- OnUnload
function Kalented_OnUnload()
  if ( fnTalentFrame_Update ) then
      TalentFrame_Update = fnTalentFrame_Update;
      fnTalentFrame_Update = nil;
  end
end


-- [ WoW Subclassing ] ---------------------------------------
function NewTalentFrame_Update()
  fnTalentFrame_Update();
  Kalented_Update();
end


-- [ WoW commands ] ------------------------------------------
function Kalented_SlashCommand(msg)
local _, _, cmd, arg1 = string.find(msg, "%s*(%S*)%s*(.*)");
  cmd = string.lower(cmd);

  -- List of Commands
  if ( cmd == "help" ) then
      Kalented_Debug_Message("Created by Kaluriel <kaluriel@gmail.com>");
      Kalented_Debug_Message("Translations by Filougarou, J.W and sy2451.");
      Kalented_Debug_Message("Configure: /kalented config");
      Kalented_Debug_Message("Join Channel: /kalented join");
      Kalented_Debug_Message("Leave Channel: /kalented leave");
      Kalented_Debug_Message("Clear db: /kalented clear");

  -- Configure Kalented
  elseif ( cmd == "config" ) then

  -- Join Kalented Channel
  elseif ( cmd == "join" ) then

  -- Leave Kalented Channel
  elseif ( cmd == "leave" ) then

  -- Clear Database
  elseif ( cmd == "clear" ) then
      XKalented_TabData = {};
      Kalented_ResetPoints_OnClick(false);
      Kalented_Debug_Message("Database cleared.");
    
  -- No Command
  else
      Kalented_Debug_Message("Invalid command entered.");
  end
end


-- [ WoW events ] --------------------------------------------
-- Reset Points
function Kalented_Reset_OnClick(bTransfer)
  XKalented_TabData[strName] = {};

  for i=1, MAX_TALENT_TABS, 1 do
      XKalented_TabData[strName][i] = {};
      for j=1, MAX_NUM_TALENTS, 1 do
          if ( bTransfer ) then
              local _, _, _, _, rank, _, _, _ = GetTalentInfo(i, j);
              XKalented_TabData[strName][i][j] = rank;
          else
              XKalented_TabData[strName][i][j] = 0;
          end
      end
  end
  
  Kalented_Update();
end

-- Learn Talent
function Kalented_Button_OnClick(arg1)
  if ( arg1 == "LeftButton" ) then
    if ( Kalented_CanIncrease(this:GetID()) ) then
      XKalented_TabData[strName][PanelTemplates_GetSelectedTab(TalentFrame)][this:GetID()] = XKalented_TabData[strName][PanelTemplates_GetSelectedTab(TalentFrame)][this:GetID()] + 1;
    end
  elseif ( arg1 == "RightButton" ) then
    if ( Kalented_CanDecrease(this:GetID()) ) then
      XKalented_TabData[strName][PanelTemplates_GetSelectedTab(TalentFrame)][this:GetID()] = XKalented_TabData[strName][PanelTemplates_GetSelectedTab(TalentFrame)][this:GetID()] - 1;
    end
  end
  Kalented_Update();

   if ( GameTooltip:IsOwned(this) ) then
    Kalented_SetTalentTip();
  end
end

-- Update Talents
function Kalented_Update()
  -- Calculate Remaining Points and display
  iTalentPoints = 51;
  iPointsSpent = 0;

  for i=1, MAX_TALENT_TABS, 1 do
      for j=1, MAX_NUM_TALENTS, 1 do
          if ( PanelTemplates_GetSelectedTab(TalentFrame) == i ) then
              iPointsSpent = iPointsSpent + XKalented_TabData[strName][i][j];
          end
          iTalentPoints = iTalentPoints - XKalented_TabData[strName][i][j];
      end
  end
  Kalented_Text_Points:SetText(KALENTED_TEXT_POINTS .. " |cffffffff" .. iTalentPoints);
  Kalented_Text_Spent:SetText(KALENTED_TEXT_SPENT .. " |cffffffff" .. iPointsSpent);
  

  -- Setup Background Image
  local _, _, _, strFilename = GetTalentTabInfo(PanelTemplates_GetSelectedTab(TalentFrame));
  local base = "Interface\\TalentFrame\\";
  if ( GetTalentTabInfo(PanelTemplates_GetSelectedTab(TalentFrame)) ) then
    base = base .. strFilename;
  else
    base = base .. "MageFire";
  end
  
  Kalented_Background_TopLeft:SetTexture(base .. "-TopLeft");
  Kalented_Background_TopRight:SetTexture(base .. "-TopRight");
  Kalented_Background_BottomLeft:SetTexture(base .. "-BottomLeft");
  Kalented_Background_BottomRight:SetTexture(base .. "-BottomRight");


  -- Setup Talent Buttons
  for i=1, MAX_NUM_TALENTS, 1 do
      pButton = getglobal("Kalented_Scroll_Talent" .. i);

      if ( i <= GetNumTalents(PanelTemplates_GetSelectedTab(TalentFrame)) ) then
          -- Get Talent Info
          local _, iconTexture, tier, column, _, maxRank, _, _ = GetTalentInfo(PanelTemplates_GetSelectedTab(TalentFrame), i);
          local rank = XKalented_TabData[strName][PanelTemplates_GetSelectedTab(TalentFrame)][i];
          local bForceDesaturated, bTierUnlocked = false, false;
 
          -- Set Rank and Position Button
          getglobal("Kalented_Scroll_Talent" .. i .. "Rank"):SetText(rank);
          pButton:SetPoint("TOPLEFT", pButton:GetParent():GetName(), "TOPLEFT", 63 * (column - 1) + KALENTED_TALENT_OFFSET_X, -63 * (tier - 1) - KALENTED_TALENT_OFFSET_Y);


          -- If no talent points left and rank 0, grey out button
          if ( ( iTalentPoints + rank ) == 0 ) then
              bForceDesaturated = true;
          end

          -- If 5+ points were spent in the previous tier, highlight button
          if ( iPointsSpent >= (tier - 1) * 5 ) then
              bTierUnlocked = true;
          end
          SetItemButtonTexture(pButton, iconTexture);


          -- Check if Talent meets prereqs
          if ( Kalented_SetPrereqs(tier, column, bForceDesaturated, bTierUnlocked, GetTalentPrereqs(PanelTemplates_GetSelectedTab(TalentFrame), i)) ) then
              if ( rank < maxRank ) then
                  -- Rank is green
                  getglobal("Kalented_Scroll_Talent" .. i .. "Slot"):SetVertexColor(0.1, 1.0, 0.1);
                  getglobal("Kalented_Scroll_Talent" .. i .. "Rank"):SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
              else
                  -- Rank if yellow (max)
                  getglobal("Kalented_Scroll_Talent" .. i .. "Slot"):SetVertexColor(1.0, 0.82, 0);
                  getglobal("Kalented_Scroll_Talent" .. i .. "Rank"):SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
              end
              getglobal("Kalented_Scroll_Talent" .. i .. "RankBorder"):Show();
              getglobal("Kalented_Scroll_Talent" .. i .. "Rank"):Show();

              SetItemButtonDesaturated(pButton, nil);
          else
              if ( rank == 0 ) then
                  -- Talent not available
                  getglobal("Kalented_Scroll_Talent" .. i .. "RankBorder"):Hide();
                  getglobal("Kalented_Scroll_Talent" .. i .. "Rank"):Hide();
              else
                  -- Rank is grey
                  getglobal("Kalented_Scroll_Talent" .. i .. "RankBorder"):SetVertexColor(0.5, 0.5, 0.5);
                  getglobal("Kalented_Scroll_Talent" .. i .. "Rank"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
              end
              getglobal("Kalented_Scroll_Talent" .. i .. "Slot"):SetVertexColor(0.5, 0.5, 0.5);

              SetItemButtonDesaturated(pButton, 1, 0.65, 0.65, 0.65);
          end
      
          pButton:Show();

      else
          -- Button is unused so hide
          pButton:Hide();
      end
  end


  -- Draw the prerq branches and Variable that decides whether or not to ignore drawing pieces
  local ignoreUp;

  TalentFrame_ResetBranchTextureCount();
  TalentFrame_ResetArrowTextureCount();

  for i=1, MAX_NUM_TALENT_TIERS do
    for j=1, NUM_TALENT_COLUMNS do
      local node = TALENT_BRANCH_ARRAY[i][j];
      
      -- Setup offsets
      local xOffset = 63 * (j - 1) + KALENTED_TALENT_OFFSET_X + 2;
      local yOffset = -63 * (i - 1) - KALENTED_TALENT_OFFSET_Y - 2;
    
      if ( node.id ) then
        -- Has talent
        if ( node.up ~= 0 ) then
          if ( not ignoreUp ) then
            Kalented_SetBranchTexture(TALENT_BRANCH_TEXTURECOORDS["up"][node.up], xOffset, yOffset + TALENT_BUTTON_SIZE);
          else
            ignoreUp = nil;
          end
        end

        if ( node.down ~= 0 ) then
          Kalented_SetBranchTexture(TALENT_BRANCH_TEXTURECOORDS["down"][node.down], xOffset, yOffset - TALENT_BUTTON_SIZE + 1);
        end

        if ( node.left ~= 0 ) then
          Kalented_SetBranchTexture(TALENT_BRANCH_TEXTURECOORDS["left"][node.left], xOffset - TALENT_BUTTON_SIZE, yOffset);
        end

        if ( node.right ~= 0 ) then
          -- See if any connecting branches are gray and if so color them gray
          local tempNode = TALENT_BRANCH_ARRAY[i][j+1];  
          if ( tempNode.left ~= 0 and tempNode.down < 0 ) then
            Kalented_SetBranchTexture(TALENT_BRANCH_TEXTURECOORDS["right"][tempNode.down], xOffset + TALENT_BUTTON_SIZE, yOffset);
          else
            Kalented_SetBranchTexture(TALENT_BRANCH_TEXTURECOORDS["right"][node.right], xOffset + TALENT_BUTTON_SIZE + 1, yOffset);
          end
        end

        -- Draw arrows
        if ( node.rightArrow ~= 0 ) then
          Kalented_SetArrowTexture(TALENT_ARROW_TEXTURECOORDS["right"][node.rightArrow], xOffset + TALENT_BUTTON_SIZE/2 + 5, yOffset);
        end

        if ( node.leftArrow ~= 0 ) then
          Kalented_SetArrowTexture(TALENT_ARROW_TEXTURECOORDS["left"][node.leftArrow], xOffset - TALENT_BUTTON_SIZE/2 - 5, yOffset);
        end

        if ( node.topArrow ~= 0 ) then
          Kalented_SetArrowTexture(TALENT_ARROW_TEXTURECOORDS["top"][node.topArrow], xOffset, yOffset + TALENT_BUTTON_SIZE/2 + 5);
        end
      else
        -- Doesn't have a talent
        if ( node.up ~= 0 and node.left ~= 0 and node.right ~= 0 ) then
          Kalented_SetBranchTexture(TALENT_BRANCH_TEXTURECOORDS["tup"][node.up], xOffset , yOffset);
        elseif ( node.down ~= 0 and node.left ~= 0 and node.right ~= 0 ) then
          Kalented_SetBranchTexture(TALENT_BRANCH_TEXTURECOORDS["tdown"][node.down], xOffset , yOffset);
        elseif ( node.left ~= 0 and node.down ~= 0 ) then
          Kalented_SetBranchTexture(TALENT_BRANCH_TEXTURECOORDS["topright"][node.left], xOffset , yOffset);
          Kalented_SetBranchTexture(TALENT_BRANCH_TEXTURECOORDS["down"][node.down], xOffset , yOffset - 32);
        elseif ( node.left ~= 0 and node.up ~= 0 ) then
          Kalented_SetBranchTexture(TALENT_BRANCH_TEXTURECOORDS["bottomright"][node.left], xOffset , yOffset);
        elseif ( node.left ~= 0 and node.right ~= 0 ) then
          Kalented_SetBranchTexture(TALENT_BRANCH_TEXTURECOORDS["right"][node.right], xOffset + TALENT_BUTTON_SIZE, yOffset);
          Kalented_SetBranchTexture(TALENT_BRANCH_TEXTURECOORDS["left"][node.left], xOffset + 1, yOffset);
        elseif ( node.right ~= 0 and node.down ~= 0 ) then
          Kalented_SetBranchTexture(TALENT_BRANCH_TEXTURECOORDS["topleft"][node.right], xOffset , yOffset);
          Kalented_SetBranchTexture(TALENT_BRANCH_TEXTURECOORDS["down"][node.down], xOffset , yOffset - 32);
        elseif ( node.right ~= 0 and node.up ~= 0 ) then
          Kalented_SetBranchTexture(TALENT_BRANCH_TEXTURECOORDS["bottomleft"][node.right], xOffset , yOffset);
        elseif ( node.up ~= 0 and node.down ~= 0 ) then
          Kalented_SetBranchTexture(TALENT_BRANCH_TEXTURECOORDS["up"][node.up], xOffset , yOffset);
          Kalented_SetBranchTexture(TALENT_BRANCH_TEXTURECOORDS["down"][node.down], xOffset , yOffset - 32);
          ignoreUp = 1;
        end
      end
    end

    Kalented_Scroll_Frame:UpdateScrollChildRect();
  end

  -- Hide any unused branch textures
  for i=TalentFrame_GetBranchTextureCount(), MAX_NUM_BRANCH_TEXTURES, 1 do
    getglobal("Kalented_Scroll_Branch" .. i):Hide();
  end

  -- Hide and unused arrowl textures
  for i=TalentFrame_GetArrowTextureCount(), MAX_NUM_ARROW_TEXTURES, 1 do
    getglobal("Kalented_Scroll_Arrow" .. i):Hide();
  end
end


-- [ WoW functions ] -----------------------------------------
function Kalented_SetPrereqs(iTier, iColumn, bForceDesaturated, bTierUnlocked, ...)
local bLearnable, bPrereqsMet = false, false;

  if ( bTierUnlocked and not bForceDesaturated ) then
    bPrereqsMet = true;
  end

  for i=1, arg.n, 3 do
    local x, y = arg[i + 1], arg[i];

    bLearnable = false;
    for j=1, MAX_NUM_TALENTS, 1 do
      local _, _, tier, column, _, maxRank, _, _ = GetTalentInfo(PanelTemplates_GetSelectedTab(TalentFrame), j);
      if ( column == x and tier == y ) then
        if ( XKalented_TabData[strName][PanelTemplates_GetSelectedTab(TalentFrame)][j] == maxRank ) then
          bLearnable = true;
        end
      end
    end

    if ( not bLearnable or bForceDesaturated ) then
      bPrereqsMet = false;
    end

    TalentFrame_DrawLines(iTier, iColumn, y, x, bPrereqsMet);
  end

  return bPrereqsMet;
end

function Kalented_SetTalentTip()
  local _, _, _, _, _, maxRank, _, _ = GetTalentInfo(PanelTemplates_GetSelectedTab(TalentFrame), this:GetID());
  GameTooltip:SetTalent(PanelTemplates_GetSelectedTab(TalentFrame), this:GetID());
  GameTooltipTextLeft2:SetText("Rank " .. XKalented_TabData[strName][PanelTemplates_GetSelectedTab(TalentFrame)][this:GetID()] .. "/" .. maxRank);
end

function Kalented_CanIncrease(id)
local _, _, tier, column, _, maxRank, _, _ = GetTalentInfo(PanelTemplates_GetSelectedTab(TalentFrame), id);

  -- Check there is enough talents, and the talent isn't at max, and there is enough points to active this field
  if( iTalentPoints > 0 and XKalented_TabData[strName][PanelTemplates_GetSelectedTab(TalentFrame)][id] < maxRank and iPointsSpent >= (tier - 1) * 5 ) then
    -- If there are prereqs, check they are filled
    if ( GetTalentPrereqs(PanelTemplates_GetSelectedTab(TalentFrame), id) ) then
      local arg = {GetTalentPrereqs(PanelTemplates_GetSelectedTab(TalentFrame), id)};
      for i=1, table.getn(arg), 3 do
        for j=1, MAX_NUM_TALENTS, 1 do
          local _, _, pTier, pColumn, _, pMaxRank, _, _ = GetTalentInfo(PanelTemplates_GetSelectedTab(TalentFrame), j);
          if ( pColumn == arg[i + 1] and pTier == arg[i] ) then
            if ( XKalented_TabData[strName][PanelTemplates_GetSelectedTab(TalentFrame)][j] == pMaxRank ) then
              return true;
            else
              return false;
            end
          end
        end
      end

      return false;
    end

    return true;
  end

  return false;
end

function Kalented_CanDecrease(id)
  -- Check to see if it has 0 points left in talent
  if ( XKalented_TabData[strName][PanelTemplates_GetSelectedTab(TalentFrame)][id] == 0 ) then
    return false;
  end

  -- Check to see if there are any talents in the next tier
  local _, _, tier, _, _, _, _, _ = GetTalentInfo(PanelTemplates_GetSelectedTab(TalentFrame), id);
  for i=id, GetNumTalents(PanelTemplates_GetSelectedTab(TalentFrame)), 1 do
    local _, _, pTier, _, _, _, _, _ = GetTalentInfo(PanelTemplates_GetSelectedTab(TalentFrame), i);
    if ( pTier > tier and XKalented_TabData[strName][PanelTemplates_GetSelectedTab(TalentFrame)][i] > 0 ) then
      return false;
    end
  end

  -- Check for Prereqs
  local _, _, pTier, pColumn, _, pMaxRank, _, _ = GetTalentInfo(PanelTemplates_GetSelectedTab(TalentFrame), id);
  if ( GetTalentPrereqs(PanelTemplates_GetSelectedTab(TalentFrame), id + 1) and XKalented_TabData[strName][PanelTemplates_GetSelectedTab(TalentFrame)][id] == pMaxRank ) then
    local arg = {GetTalentPrereqs(PanelTemplates_GetSelectedTab(TalentFrame), id + 1)};

    for i=1, table.getn(arg), 3 do
      if ( pColumn == arg[i + 1] and pTier == arg[i] ) then
        if ( XKalented_TabData[strName][PanelTemplates_GetSelectedTab(TalentFrame)][id + 1] > 0 ) then
          return false;
        end
      end
    end
  end

  return true;
end

function Kalented_SetArrowTexture(texCoords, xOffset, yOffset)
local pArrow = getglobal("Kalented_Scroll_Arrow" .. TalentFrame.arrowIndex);
  if ( pArrow ) then
    pArrow:SetTexCoord(texCoords[1], texCoords[2], texCoords[3], texCoords[4]);
    pArrow:SetPoint("TOPLEFT", "Kalented_Scroll_ArrowFrame", "TOPLEFT", xOffset, yOffset);
    pArrow:Show();
  end

  TalentFrame.arrowIndex = TalentFrame.arrowIndex + 1;
end

function Kalented_SetBranchTexture(texCoords, xOffset, yOffset)
local pBranch = getglobal("Kalented_Scroll_Branch" .. TalentFrame.textureIndex);
  if ( pBranch ) then
    pBranch:SetTexCoord(texCoords[1], texCoords[2], texCoords[3], texCoords[4]);
    pBranch:SetPoint("TOPLEFT", "Kalented_Scroll_ChildFrame", "TOPLEFT", xOffset, yOffset);
    pBranch:Show();
  end

  TalentFrame.textureIndex = TalentFrame.textureIndex + 1;
end


-- [ Debug functions ] ---------------------------------------
function Kalented_Debug_Message(strMessage)
  DEFAULT_CHAT_FRAME:AddMessage("::Kalented:: " .. strMessage, 1.0, 0.25, 0.25);
end