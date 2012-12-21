
--[[ BestBuff 1.7

   Casts the best rank possible of various buffs on caster's target,
   irregardless of caster or target level.

   Configuration: /bestbuff
   It will bring up a window to set options and define buffs.
   Generally you will only need to do this once or very seldom.

   There are now two ways to use BestBuff:

   Old way: /script BestBuff(buff_name)
        ie: /script BestBuff("Power Word: Fortitude")

   New way: Go into /bestbuff config panel and check Enabled.
     Any buff defined there on your action bars will automatically BestBuff.

   This means if you have macros dedicated to casting BestBuff you can get
   rid of them.  Drag the spell from your spellbook to a hotkey and use it
   there.

   Self cast and spam which were previously turned on/off in the BestBuff()
   function are now defined in the BestBuff settings.  By default, buffs
   have no notification and do not self cast.

   To add/change/remove buffs, use the /bestbuff config panel.  For more
   permanent changes (in case you frequently lose SavedVariables.lua),
   instructions are in the BestBuff_Defaults.lua.

   To restore settings to default, use /bestbuff reset.

  -- Gello

	 3/29/06 - 1.10 tooltip changes
	 7/24/05 - changed highest rank to highest rank user knows
     4/11/05 - removed BestBuff from UISpecialFrames
     4/1/05 - added UI config window, ability to auto-BestBuff from action bar,
              saved buffs to SavedVariables.lua so users don't have to re-edit
              for every update.
     3/22/05 - updated toc to 1300
     3/18/05 - fixed a small bug causing excess spam
     3/17/05 - added switch to kill self cast, some cleanup and comments
     2/8/05 - initial release

]]

BestBuff_Original_UseAction = nil; -- for hooking UseAction

--[[ Variables saved to SavedVariables.lua ]]

BB = {};
BB.Buffs = {};
BB.Enabled = 1;
BB.Population = 0;
BB.Selected = 0;

--[[ Original BestBuff() left mostly unchanged ]]
--[[ no squelch or self cast disable flags, they're in config options now ]]

function BestBuff(intended_buff)

  local best_rank = 1;
  local target_rank = 1;
  local cast_rank = 1;
  local which_buff = 0;
  local x = 1;
  local text = nil;

  which_buff = nil;

  -- intended_buff is the string passed to us by user, see if this is in the buffnames list
  for x=1, table.getn(BB.Buffs), 1 do
      if (BB.Buffs[x].Name == intended_buff) then
          which_buff = x;
      end
  end

  -- if it is in the list...
  if which_buff then

      -- see which is the player's best castable rank due to player's level
      for x=1, table.getn(BB.Buffs[which_buff].Levels), 1 do
          if (UnitLevel("player")>=tonumber(BB.Buffs[which_buff].Levels[x])) then
              best_rank = x;
          end
      end

      -- see which is the target's best rank due to target's level
      if (UnitLevel("target")>0) then
          for x=1, table.getn(BB.Buffs[which_buff].Levels), 1 do
              if (UnitLevel("target")>=(tonumber(BB.Buffs[which_buff].Levels[x])-10)) then
                  target_rank = x;
              end
          end
      else
          target_rank = best_rank
      end

      -- if the target's best rank is greater than the caster's best rank,
      -- (ie, target is much higher level) then the actual rank will be
      -- the caster's best rank.
      if best_rank < target_rank then
          cast_rank = best_rank;
      else
          -- otherwise, choose the best rank for the target.
          cast_rank = target_rank;
      end

      -- attempt the spell
      BestBuff_CastSpellByName(intended_buff,"Rank "..cast_rank);

      -- if spam is on and we have a friendly target, spam away
      if BB.Buffs[which_buff].Notify==1 and UnitExists("target") then
          text = "Casting "..intended_buff.."(Rank "..cast_rank..") on "..UnitName("target")..".";
      end

      -- If the spell didn't actually cast, and selfcasting not disabled, self cast it
      if BB.Buffs[which_buff].SelfCast==1 and SpellIsTargeting() then
          cast_rank = best_rank;
          SpellTargetUnit("player");
          if BB.Buffs[which_buff].Notify==1 then
	      text = "Casting "..intended_buff.."(Rank "..cast_rank..") on yourself.";
          end
      end

  else
      -- if we're here it means the user asked for a buff not in the buffnames list
      text = "Unable to cast "..intended_buff..".";
  end    

  -- if we gained a message to spam at some point, spam it
  if text and DEFAULT_CHAT_FRAME then
      DEFAULT_CHAT_FRAME:AddMessage(text);
  end

end


--[[ BestBuff callback functions ]]


function BestBuff_OnLoad()
    BestBuff_Original_UseAction = UseAction;
    UseAction = BestBuff_New_UseAction;
    this:RegisterEvent("VARIABLES_LOADED");
end

function BestBuff_OnEvent()

    if event=="VARIABLES_LOADED" then
	BestBuffFrame:Hide();
	if BB.Population<1 then
	    BestBuff_PopulateBuffs()
	end
	if BB.Enabled then
	    BestBuffEnableCheckButton:SetChecked(1);
	else
	    BestBuffEnableCheckButton:SetChecked(0);
	end
	SlashCmdList["BestBuffCOMMAND"] = BestBuff_SlashHandler;
	SLASH_BestBuffCOMMAND1 = "/bestbuff";
    end

end

function BestBuff_SlashHandler(arg1)

    if string.find(arg1,"reset") then
	BestBuff_PopulateBuffs();
    end

    BestBuff_Startup();
    BestBuff_ClearEntry();
end


function BestBuff_New_UseAction(slot,arg2,onself)

    local intended_buff;
    local which_buff = nil;
    local i;

    if not BB.Enabled then
	BestBuff_Original_UseAction(slot,arg2,onself);
    else
	BestBuffTooltip:SetOwner(UIParent,"ANCHOR_NONE")
	BestBuffTooltip:SetAction(slot);
	intended_buff = getglobal("BestBuffTooltipTextLeft1"):GetText();
	
	for i=1,table.getn(BB.Buffs) do
	    if BB.Buffs[i].Name == intended_buff then
		which_buff = intended_buff;
	    end
	end

	if which_buff then
	    BestBuff(intended_buff);
	else
	    BestBuff_Original_UseAction(slot,arg2,onself);
	end
    end
end


--[[ Helper functions ]]

-- CastSpellByName() won't work from within UseAction, use CastSpell instead
function BestBuff_CastSpellByName(spell_name,spell_rank) --intended_buff,"Rank "..cast_rank);

	local id;
	local i = 1;
	local done = nil;
	local name;
	local rank;
	local id = nil;
	local intended_rank;

	_,_,intended_rank = string.find(spell_rank,"(%d+)")

	while not done do
		name,rank = GetSpellName(i,BOOKTYPE_SPELL);
		if not name then
			done = true;
		else
			if name==spell_name then
				_,_,rank = string.find(rank,"(%d+)")		
				if tonumber(rank)<=tonumber(intended_rank) then
					id = i;
				end
			end
		end
		i = i+1;
	end

    if id then
	CastSpell(id,BOOKTYPE_SPELL);
    end
end



-- restore or initialize Buff to defaults
function BestBuff_PopulateBuffs()

    BestBuffEnableCheckButton:SetChecked(0);
    BB = {};
    BB.Buffs = {};
    BB.Enabled = false;
    BB.Selected = 0;
    BB.Population = 1;
    foreach(BBDefaultBuffs,BestBuff_AddDefaultBuffs);
    BestBuff_SortBuffs();
end
function BestBuff_AddDefaultBuffs(arg1)

    local i;

    if arg1 then
	BB.Buffs[BB.Population] = {};
	BB.Buffs[BB.Population].Name = arg1;
	BB.Buffs[BB.Population].Notify = BBDefault_Notify;
	BB.Buffs[BB.Population].SelfCast = BBDefault_SelfCast;
	BB.Buffs[BB.Population].Levels = {};
	for i=1,table.getn(BBDefaultBuffs[arg1]) do
	    BB.Buffs[BB.Population].Levels[i] = BBDefaultBuffs[arg1][i];
	end
    end
    BB.Population = BB.Population + 1;
end

-- always sort buffs alphabetically by .Name
function BestBuff_SortBuffs()

    local temp_buff = {};
    local changed = true;

    if BB.Population>2 then
	while changed do
	    changed = false;
	    for i=1,BB.Population-2 do
		if BB.Buffs[i].Name > BB.Buffs[i+1].Name then
		    temp_buff = BB.Buffs[i];
		    BB.Buffs[i] = BB.Buffs[i+1];
		    BB.Buffs[i+1] = temp_buff;
		    changed = true;
		end
	    end
	end
    end
end


function BestBuff_Debug()

    local i;
    local j;
    local text;

    DEFAULT_CHAT_FRAME:AddMessage("Population: "..BB.Population);
    for i=1,table.getn(BB.Buffs) do
	text = "Buff #"..i..": "..BB.Buffs[i].Name..": ";
	for j=1,table.getn(BB.Buffs[i].Levels) do
	    text = text .. BB.Buffs[i].Levels[j] .. " ";
	end
	DEFAULT_CHAT_FRAME:AddMessage(text);
    end
end

-- reset the lower "edit" area of the window
function BestBuff_ClearEntry()

    BestBuffEditBox_OnEscapePressed();
    BestBuff_SortBuffs()
    BB.Selected = 0;
    BestBuffEditNameBox:SetText("");
    BestBuffEditLevelsBox:SetText("");
    BestBuffNotifyCheckButton:SetChecked(0);
    BestBuffSelfCastCheckButton:SetChecked(0);
    BestBuffList_Update();
end

-- returns a string as levels separated by spaces
function BestBuff_LevelString(arg1)

    local text = "";

    if BB.Buffs[arg1].Levels then
	for i=1,table.getn(BB.Buffs[arg1].Levels) do
	    if i>1 then
		text = text .. " ";
	    end
	    text = text .. BB.Buffs[arg1].Levels[i];
	end
    end

    return text;
end		

function BestBuff_Startup()
    BestBuffFrame:StopMovingOrSizing();
    BestBuffFrame:Show();
end


--[[ Dialog control functions ]]

function BestBuff_OnMouseDown(arg1)
    if arg1=="LeftButton" then
	BestBuffFrame:StartMoving();
    end
end

function BestBuff_OnMouseUp(arg1)
    if arg1=="LeftButton" then
	BestBuffFrame:StopMovingOrSizing();
    end
end

function BestBuffCloseButton_OnClick()

    BestBuff_ClearEntry();
    BestBuffFrame:Hide();
end

function BestBuffNameButton_OnClick(arg1)

    local index;
    local item;

    BestBuffEditBox_OnEscapePressed();

    index = arg1 + FauxScrollFrame_GetOffset(BestBuffScrollFrame)

    if index==BB.Selected then
	index = BB.Population;
	BB.Selected = 0;
    end

    if index < BB.Population then
	BB.Selected = index;
	BestBuffEditNameBox:SetText(BB.Buffs[index].Name);
	BestBuffEditLevelsBox:SetText(BestBuff_LevelString(index));
	BestBuffNotifyCheckButton:SetChecked(BB.Buffs[index].Notify);
	BestBuffSelfCastCheckButton:SetChecked(BB.Buffs[index].SelfCast);
	BestBuffList_Update();
    else
	BestBuff_ClearEntry();
    end
end

function BestBuffEnableCheckButton_OnClick()

    if BestBuffEnableCheckButton:GetChecked()==1 then
	BB.Enabled = true;
    else
	BB.Enabled = false;
    end
end

function BestBuffSelfCastCheckButton_OnClick()

    if BB.Selected>0 then
	BB.Buffs[BB.Selected].SelfCast = BestBuffSelfCastCheckButton:GetChecked();
    end
end

function BestBuffNotifyCheckButton_OnClick()

    if BB.Selected>0 then
	BB.Buffs[BB.Selected].Notify = BestBuffNotifyCheckButton:GetChecked();
    end
end

function BestBuffAddButton_OnClick()

    local i;
    local j;
    local text;
    local err_msg = "";

    text = BestBuffEditNameBox:GetText();

    for i=1,BB.Population-1 do
	if text=="" or BB.Buffs[i].Name==text then
	    err_msg = "Can't add this buff.\nNew buffs must have a unique name.";
	end
    end

    if err_msg~="" then
	message(err_msg);
    else

	BB.Buffs[BB.Population] = {};
	BB.Buffs[BB.Population].Name = BestBuffEditNameBox:GetText();

	text = BestBuffEditLevelsBox:GetText();
	-- populate .Levels with numbers in text
	BB.Buffs[BB.Population].Levels = {};
	j = 1;
	for i in string.gfind(text,"(%d+)") do
	    BB.Buffs[BB.Population].Levels[j] = i;
	    j = j+1;
	end
	if j==1 then
	    BB.Buffs[BB.Population].Levels[1] = 1;
	end

	BB.Buffs[BB.Population].Notify = BestBuffNotifyCheckButton:GetChecked();

	BB.Buffs[BB.Population].SelfCast = BestBuffSelfCastCheckButton:GetChecked();

	table.setn(BB.Buffs,BB.Population);
	BB.Population = BB.Population + 1;

	BestBuff_ClearEntry();

    end
end

function BestBuffChangeButton_OnClick()

    local item;
    local i;
    local j;
    local text;

    if BB.Selected>0 then
	BB.Buffs[BB.Selected].Name = BestBuffEditNameBox:GetText();
	text = BestBuffEditLevelsBox:GetText();
	-- populate .Levels with numbers in text
	BB.Buffs[BB.Selected].Levels = {};
	j = 1;
	for i in string.gfind(text,"(%d+)") do
	    BB.Buffs[BB.Selected].Levels[j] = i;
	    j = j+1;
	end
	if j==1 then
	    BB.Buffs[BB.Selected].Levels[1] = 1;
	end
	BB.Buffs[BB.Selected].Notify = BestBuffNotifyCheckButton:GetChecked();
	BB.Buffs[BB.Selected].SelfCast = BestBuffSelfCastCheckButton:GetChecked();
	BestBuff_ClearEntry();
    end
end

function BestBuffDeleteButton_OnClick()

   if BB.Selected>0 then
	table.remove(BB.Buffs,BB.Selected);
	BB.Population = BB.Population - 1;
	BB.Selected = 0;
	BestBuff_ClearEntry();
   end
end

function BestBuffEditBox_OnEscapePressed()

    BestBuffEditNameBox:ClearFocus();
    BestBuffEditLevelsBox:ClearFocus();

    if BB.Selected>0 then
	BestBuffEditNameBox:SetText(BB.Buffs[BB.Selected].Name);
	BestBuffEditLevelsBox:SetText(BestBuff_LevelString(BB.Selected));
    end
end

function BestBuffList_Update()

    local index;
    local i;
    local itemText;
    local itemButton;

    FauxScrollFrame_Update(BestBuffScrollFrame, BB.Population-1, 8, 8);

    for i=1,8 do
	index = i + FauxScrollFrame_GetOffset(BestBuffScrollFrame);
        itemButton = getglobal("BestBuffName"..i);
	itemText = getglobal("BestBuffName"..i.."_Text");
	if (index<BB.Population) then
	    itemText:SetText(BB.Buffs[index].Name);
	    itemText:Show();
	    if index==BB.Selected then
		itemButton:LockHighlight();
	    else
		itemButton:UnlockHighlight();
	    end
	else
	    itemText:Hide();
	    itemButton:UnlockHighlight();
	end
    end
end


--[[ BestBuff Tooltip/OnEnter functions ]]

function BestBuff_Tooltip(arg1,arg2)

    GameTooltip_SetDefaultAnchor(GameTooltip,this);
    GameTooltip:SetText(arg1);
    GameTooltip:AddLine(arg2, .75, .75, .75, 1);
    GameTooltip:Show();
end

function BestBuffEnableCheckButton_OnEnter()
    BestBuff_Tooltip("Enable Auto BestBuff","Checking this will allow BestBuff to alter the ranks of buffs cast directly from an action bar.  This will not affect the /script BestBuff() macro command at all.\n\nThe buffs below will still be used for /script BestBuff().");
end

function BestBuffSelfCastCheckButton_OnEnter()
    BestBuff_Tooltip("Self cast this buff","Checking this will cause this buff to cast on you if it cannot cast on the current target.");
end

function BestBuffNotifyCheckButton_OnEnter()
    BestBuff_Tooltip("Notify on casting this buff","Checking this will send a notification of the spell, rank and target to your main chat window when you cast this buff.");
end

function BestBuffAddButton_OnEnter()
    BestBuff_Tooltip("Add this buff","Click here to add this buff to the potential buffs list.");
end

function BestBuffChangeButton_OnEnter()
    BestBuff_Tooltip("Change this buff", "Click here to change the selected buff to the values entered above.");
end

function BestBuffDeleteButton_OnEnter()
    BestBuff_Tooltip("Delete this buff", "Click here to delete the selected buff from the potential buffs list.");
end

function BestBuffEditNameBox_OnEnter()
    BestBuff_Tooltip("Buff name", "This field is the exact cast-sensitive name of the buff as used by WoW. ie, Power Word: Fortitude");
end

function BestBuffEditLevelsBox_OnEnter()
    BestBuff_Tooltip("Buff levels", "This field is a list of the levels each rank of a buff is learned, separated by spaces.  Each number corresponds to a rank.\n\nie, 1 12 24 means:\n(Rank 1) is learned at level 1\n(Rank 2) is learned at level 12\n(Rank 3) is learned at level 24");
end

function HighestRank(spellname)

	local rank = 0;
	local foundspell,foundrank="";
	local i=1;

	while foundspell do
		foundspell, foundrank = GetSpellName(i,BOOKTYPE_SPELL);
		i = i + 1;
		_,_,foundrank=string.find(tostring(foundrank),"Rank (%d+)");
		foundrank = tonumber(foundrank);
		if foundspell==spellname and foundrank and foundrank>rank then
			rank = foundrank;
		end
	end
	
	return rank;
end
