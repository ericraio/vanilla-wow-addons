-- Form Edit Box
lazyr.lreb = {}

lazyr.lreb.currentForm = nil
lazyr.lreb.cancelEdit = false

function lazyr.lreb.OnShow()
   if (not lazyr.lreb.currentForm) then
      lazyr.lreb.currentForm = ""
   end

   --LazyRogueFormEditFrameTitle:SetText("LazyRogue v"..lazyr.version)
   LazyRogueFormEditFrameFormName:SetText(lazyr.lreb.currentForm)
   if (lazyr.lreb.currentForm == "") then
      LazyRogueFormEditFrameFormName:SetFocus()
   end

   local actions = lrConf.forms[lazyr.lreb.currentForm]
   local text
   if (actions) then
      text = table.concat(actions, "\n")
   else
      text = ""
   end
   LazyRogueFormEditFrameForm:SetText(text)
end

function lazyr.lreb.OnHide()
   if (lazyr.lreb.cancelEdit) then
      lazyr.lreb.cancelEdit = false
      return
   end

   local name = LazyRogueFormEditFrameFormName:GetText()
   -- convert spaces to underscores
   name = string.gsub(name, "%s+", "_")

   local oldName = lazyr.lreb.currentForm
   local text  = LazyRogueFormEditFrameForm:GetText()

   if (not name or name == "" or not text or text == "") then
      return
   end

   --lazyr.SlashCommand("set "..name.." "..text)
   -- doing this manually (dup code alert! :-( ) so we can
   -- preserve comments or other goodies
   if (lrConf.forms[name]) then
      verb = "updated"
   else
      verb = "created"
   end
   local args = {}
   for arg in string.gfind(text, "[^\r\n]+") do
      table.insert(args, arg)
   end
   lrConf.forms[name] = args
   lazyr.ClearParsedForm(name)
   lazyr.p("Form "..name.." "..verb..".")
   lazyr.ParseForm(args)

   if (oldName and oldName ~= "" and name ~= oldName) then
      -- user changed the name
      if (lazyr.perPlayerConf.defaultForm == oldName) then
         lazyr.SlashCommand("default "..name)
      end
      lazyr.SlashCommand("clear "..oldName)
   end

   lazyr.lreb.currentForm = nil
end


-- Help frame
function lazyr.PopulateHelpText()
   local text = "This is LazyRogue v"..lazyr.version.."."

   text = text.."\n\n"
   text = text..[[
Actions/Attacks:
adrenaline, ambush, berserking, bladeFlurry, blind, bs, cbEvisc, coldBlood, cs, dismount, evasion, evisc, expose, feint, garrote, ghostly, gouge, hemo, kick, ks, premeditation, preparation, riposte, rupture, sap, snd, sprint, ss, stealth, stop, stopAll, tea, use=<item>, useEquipped=<item>, vanish

New Actions/Attacks:
* perception,cannibalize,stoneForm,escapeArtist,bloodFury,forsaken,warStomp
* pickPocket,throw,gun,crossbow,bow
* cbAmbush
* equipMainHand=<itemid/item name>
* equipOffHand=<itemid/item name>
* use=<itemid/item name>
* setForm=<FormName>
* ping (Use for testing criteria)
* action=<action/macro name> Action/Macro must reside on a button.
* targetAssist (Use /lr assist <player name> or select the player and type /lr assist to set!)
* targetNearest (Use with -if[Not]TargetCCd to select the closest available target)
* autoAttack (Will target and enter melee for you, if you dont have a target)
* sayIn{Guild,Party,Raid,Say,Emote,RAID_WARNING}=<message>(eg sayInParty=Sapping %t...-ifStealthed-ifShiftDown-every10s)(%t will get swapped with your current target)

Append zero or more criteria to these attacks.  All criteria must be true for that attack to be used.  List your attacks one after another.  The first attack that matches all criteria is used.

In the following, multiple values within curly braces ({}) means choose one, and square brackets ([]) mean the value is optional.  Do NOT leave the curly braces or square brackets in your form.

Criteria Fuctions:
-if{Player,Target}{>,=,<}XX[%]{hp,mana/energy}
-if[<=>]Xcp
-ifKillShot[=XX%] (evisc only)
-ifCbKillShot (evisc or cbevisc only)
-if[Not]History{>,=,<}XX=<action>
-if[Not]InCombat
-if[Not]InGroup
-if[Not]LastChance
-if[Not]Mounted
-if[Not]Stealthed
-if[Not]TargetAlive
-if[Not]TargetCCd
-if[Not]TargetClass={Druid,Hunter,Mage,Paladin,
  Priest,Rogue,Shaman,Warlock,Warrior} (, can be used for multiples ie -ifTargetClass=Druid,Mage )
-if[Not]TargetElite
-if[Not]TargetHostile
-if[Not]TargetIsCasting[=<regex>] (use with: kick, cs, ks, gouge, blind)(, can be used for multiples ie -ifTargetIsCasting=Renew,Heal )
-if[Not]TargetInCombat
-if[Not]TargetInMeleeRange (Within 5.5 yards)
-if[Not]TargetInBlindRange (Within 10 yards)
-ifTargetLevel{>,=,<}XX
-if[Not]TargetNPC
-if[Not]TargetNamed=regex
-if[Not]TargetOfTarget
-if[Not]TargetType={Beast,Critter,Demon,Elemental
  Humanoid,Undead} (, can be used for multiples ie -ifTargetType=Demon,Elemental )
-if[Not]Zone=<zonename>
-if[Not]{Adrenaline,Berserking,BladeFlurry,Blind,
  ColdBlood,Cs,Evasion,Expose,FirstAid (Eg Bandages),
  Garrote,Ghostly,Gouge,Hemo,Ks,RecentlyBandaged,
  Remorseless,Rupture,Sap,Snd,Vanish}Active
-if[Not]{Ctrl,Alt,Shift}Down  (see Note 1)
-everyXXs

Note 1: To use -if{Ctrl,Alt,Shift}Down, you MUST remove any existing 
   Ctrl/Alt/Shift key bindings from the Main Menu, Key Bindings.
   Otherwise the game will intercept the key and LR will not see it.

New Criteria Fuctions:
* -if[Not]FirstAidActive
* -if[Not]BehindAttackJustFailed
* -if[Not]InFrontAttackJustFailed
* -if[Not]Feared
* -if[Not]Immobile
* -if[Not][Target]Slowed
* -if[Not][Target]Stunned
* -if[Not]TargetOfTargetClass={Druid,Hunter,Mage,Paladin,Priest,Rogue,Shaman,Warlock,Warrior} (, can be used for multiples ie -ifTargetOfTargetClass=Druid,Mage )
* -if[Not]InCooldown=<action>
* -if[Not]Dotted
* -if[Not]Bleeding
* -if[Not]Ganked
* -if[Not]FlagRunner
* -if[Target]FlaggedPVP
* -if[<=>]Xattackers
* -if[Not]Dueling
* -if[Not]Instance
* -if[Not]Battleground
* -if[Not]TargetMyLevel[<=>]{plus,minus}XX
* -if[Not]Timer={adrenaline,berserking,bladeFlurry,blind,
  coldBlood,cs,evasion,expose,firstAid (Eg Bandages),
  garrote,ghostly,gouge,hemo,ks,recentlyBandaged,
  remorseless,rupture,sap,snd,vanish}>XXs
* -if[Not]Equipped=<item>
* -if[Not]GlobalCooldown
* -if[Not]CanDebuff (Checks less than 16 debuffs on target)
* -if[Not]HuntersMark
* -if[Not]Polymorphed
* -if[Not]TargetImmune[={blind,cs,expose,garrote,gouge,hemo,ks,rupture,sap}] (The match list for this function (weaponORspell and Mob) is self building through combat and can be cleared using /lr clearImmunitiesList)
* -if[Not]InRaid

Any line may be commented out by placing '--' at the front of the line.
   ]]

   LazyRogueFormHelpScrollFrameScrollChildText:SetText(text)
end

