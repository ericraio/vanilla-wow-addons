Advanced Weapon Stats 0.85 by Greeg (Based on Stalkyr's InstantDamage Addon)

============================
DESCRIPTION:
============================

This addon calculates weapon damage (white damage, instant skills, on next melee skills using different formulas) adjusted by character's stats, armor class reduction (few presets), custom attack power buffs, and damage buffs. It can help you determine certain weapon's worthness before you equip it (so you can check weapon damage before you spend your dkp). Advanced Weapon Stats is mainly for 60 lvl warriors, rogues and (partially) shamans (more in 1.12 patch). It displays Mortal Strike, Bloodthirst, Overpower, Whirlwind, Heroic Strike stats (if character is a warrior) and Sinister Strike, Riposte, Ghostly Strike, Eviscerate, Hemorrhage stats (for rogues) and Ambush, Backstab (if character is rogue and weapon is dagger), Rockbiter, Windfury Weapon stats (for Shamans).

Advanced Weapon Stats also shows some additional info like:
- weapon flurry speed (warrior)
- weapon blade flurry + slice & dice speed (rogue)
- amount of attack power needed for +10 dmg
- +damage bonus received from 10 ap 
- average seconds needed for sword spec to proc (warrior)

============================
FAQ:
============================

1. Do i need to unequip my mainhand, secondaryhand slot to check some linked (via chat for example) weapon stats ?

Nope. For example, if you want to check some 2hander weapon stats and you have equiped 2x 1hand weapons, addon will first recalculate your attack power by removing from it +ap, +str (warrior x2), +agi (rogue) stats added by those one handers and second - it'll add +ap, +str, +agi to your attack power from 2hander stats. So it's fully automatic.

2. What about formulas ? Backstab crit will be bigger with Lethality talent. What about warriors Impale ?

You can set your "+damage talents" in Advanced Weapon Stats config (/adws) and then formulas will calculate damage suited to your build. You can even set some fake values ie. 1.7 (+70 %) to Improved Eviscerate and have some fun with Eviscerate ;)

Advanced Weapon Stats 1.0 formulas support:
a) Rogue Talents / Skills
- Lethality
- Imp Eviscerate
- Aggression
- Opportunity
- Dual Wield Spec
- Hemorrhage
b) Warrior Talents / Skills
- Impale
- Dual Wield Spec
- 2Hander Spec
c) Shaman Talents / Skills
- Rockbiter
- Windfury Weapon
d) General
- enemy Armor Class reduction (assumption: enemy is same level as you)
- custom damage bonus (ie. 1.2 = Deathwish, 1.25 = Enrage, 1.30 = WsG buff)
- custom attack power bonus (Wanna see how's your damage improving with +1000 AP. Well, go ahead ;) )

3. What about skills ranks ? +Dmg bonus is different for Heroic Strike Rank9 skill than Rank5.

Every formula uses highest possible skill rank. Wanna change it ? Edit AdWS.lua (bottom part) :)

4. Weapon tooltip shows some values formatted in three columns. What is their meaning ?

I Column - shows average hit for each skill
II Column - shows average crititical for each skill
III Column - shows average crititical with damage bonus multiplier for each skill (for example you can set third columns to display average crit with enrage and deathwish buff (1.25 x 1.2 = 1.5))

5. I don't see any Advanced Stats in weapon tooltip.
- make sure your class is supported.
- Advanced Weapon Stats currently works on english wow client.

============================
COMMANDS:
============================

1. General Commands:
/adws - Advanced Weapon Stats Help
/adws settings - Your current settings ("talent" settings, damage bonus etc.)

/adws damagebonus - Set custom Damage Bonus multiplier
/adws cap - Set Custom Attack Power Bonus
/adws ac - Set enemy Armor Class reduction preset (currently only 5 presets)

2. Warrior Commands:
/adws warriorbuild - Set warrior build to "fury" (shows Bloodthirst stats), "arms" (shows Mortal Strike stats)
/adws warriorcrit - Set Impale talent On / Off
/adws 2hspec - Set 2Hander Specialization talent bonus
/adws warrioroffhand - Set Offhand weapon handicap
/adws swordspec - Turn on / off Sword Spec proc rate stats

3. Rogue Commands:
/adws lethality - Set Lethality talent bonus
/adws opportunity - Set Opportunity talent bonus
/adws aggression - Set Aggression talent bonus
/adws impevi - Set Improved Eviscerate talent bonus
/adws rogueoffhand - Set Offhand weapon handicap

============================
DEFAULT SETTINGS:
============================

General: Custom Damage Bonus = 1.3 (+30 %), Custom Attack Power Bonus = 0, Armor Class Reduction Preset = No Reduction
Warrior: Build = Arms, Impale = Yes (Crit value = 220 %), Offhand handicap = 0.5 (50 % - 0 talents), 2H Spec = 1 (0 talents), Display Sword Spec stats = on
Rogue: Lethality = 2.3 (Crit Value = 230 %), Improved Eviscerate = 1.15 (+15 %), Aggression = 1.06 (+6 %), Opportunity = 1.20 (+20 %), Offhand handicap = 0.75 (75 % - 5 talents)

============================
TO DO
============================
Random order :)
- Support for more classes (ie. Druids, Hunters, Paladins)
- GUI
- Localizations
- Calculating +Str, +Agi enchants (they should work but i couldn't tested it)
- Speed calculating for +3 % (Iron Counterweight) blacksmith "enchant"
- More armor reduction presets
- Compact mode
- HTK (Hits to kill) amount of hits needed to kill the target (based on armor reduction and hitpoints) 

============================
IF THINGS GO WRONG:
============================
a) Some strange values (if you switched from 0.8 -> 0.85 version)
- reset your armor reduction preset. /adws ac nored, then again use any preset you like
b) everything is f%^&* up
- delete AdWS Settings - file "AdWS.lua" from you Wow ... \ Saved Variables \ folder

============================
PATCH NOTES
============================
Version 0.85
- rogue formulas changed (backstab, ambush, ghostly strike, riposte)
- hemmorhage stats added (without debuff) 
- ac reduction formula changes (now correctly calculates damage after reduction)
- new armor reduction presets added
- shaman (partially) support: white damage, rockbiter, windfury proc (2 extra hits calculated) - full suppport for shaman will be in 1.12 patch.

Version 0.8
- calculating Weapon Damage +x enchant
- fixed tooltip for SecondaryHand Slot
- fixed calculations for weapons like: Thunderfury, Iceblade Hacker (additional +spell damage, ie. + 15-30 Nature Damage)
- new stat (warrior): average seconds per sword specialization proc
- new talent support (warrior): 2hander specialization
 