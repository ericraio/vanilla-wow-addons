-- hook API functions

local oldPickupMacro=PickupMacro;
local oldPickupContainerItem=PickupContainerItem;
local oldPickupInventoryItem=PickupInventoryItem;
local oldPickupSpell=PickupSpell;
local oldPickupAction=PickupAction;
local oldPlaceAction=PlaceAction;
local oldUseAction=UseAction;
local oldGetActionText=GetActionText;
local oldGetActionTexture=GetActionTexture;

function PickupMacro(macroid, supername)
	if ( supername ) then
		SM_CURSOR=supername;
		local tempicon=SM_MACRO_ICON[GetSuperMacroInfo(supername,"texture")];
		local macroname, macroicon=GetMacroInfo(1);
		macroicon=SM_MACRO_ICON[macroicon];
		EditMacro(1,macroname, tempicon);
		oldPickupMacro(1);
		EditMacro(1,macroname, macroicon);
	else
		SM_CURSOR=nil;
		oldPickupMacro(macroid);
	end
end

function PickupContainerItem(index, slot)
	SM_CURSOR=nil;
	oldPickupContainerItem(index, slot);
end

function PickupInventoryItem(index)
	SM_CURSOR=nil;
	oldPickupInventoryItem(index);
end

function PickupSpell(index, book)
	SM_CURSOR=nil;
	oldPickupSpell(index, book);
end

function PickupAction(id)
	if ( SM_ACTION[id] ) then
		SM_CURSOR=SM_ACTION[id];
		local tempicon=SM_MACRO_ICON[GetSuperMacroInfo(SM_CURSOR,"texture")];
		local macroname, macroicon=GetMacroInfo(1);
		macroicon=SM_MACRO_ICON[macroicon];
		EditMacro(1,macroname, tempicon);
		SM_ACTION[id]=nil;
		oldPickupAction(id);
		EditMacro(1,macroname, macroicon);
	else
		SM_CURSOR=nil;
		SM_ACTION[id]=nil;
		oldPickupAction(id);
	end
end


function PlaceAction(id)
	-- place and pickup super
	local cursor;
	if ( SM_ACTION[id] ) then
		cursor=SM_ACTION[id];
	end
	SM_ACTION[id]=SM_CURSOR;
	SM_CURSOR=cursor;
	oldPlaceAction(id);
end

function UseAction( id, click, selfcast)
	lastActionUsed = id;
	if ( SuperMacroFrame_SaveMacro and SuperMacroFrame:IsVisible() ) then
		SuperMacroFrame_SaveMacro();
	end
	if ( SM_ACTION[id] ) then
		RunSuperMacro(SM_ACTION[id]);
	elseif ( GetActionText(id) ) then
		RunMacro(GetActionText(id));
	else
		oldUseAction( id, click, selfcast );
	end
end

function GetActionText(id)
	if ( SM_ACTION[id] ) then
		return SM_ACTION[id];
	else
		return oldGetActionText(id);
	end
end

function GetActionTexture(id)
	if ( SM_ACTION[id] ) then
		local texture=GetSuperMacroInfo(SM_ACTION[id], "texture");
		return texture;
	else
		return oldGetActionTexture(id);
	end
end

function SuperMacro_UpdateAction(oldsuper, newsuper)
	for k,v in SM_ACTION do
		if v==oldsuper then
			SM_ACTION[k]=newsuper;
		end
	end
end

function SetActionSuperMacro(actionid, supername)
	if ( supername and actionid > 0 and actionid <= 120 ) then
		PickupAction( actionid );
		PickupMacro(1, supername );
		PlaceAction ( actionid );
	end
end

function SM_ActionButton_OnClick()
	if ( SM_CURSOR ) then
		PlaceAction(ActionButton_GetPagedID(this));
		ActionButton_UpdateState();
		return 1;
	end
end