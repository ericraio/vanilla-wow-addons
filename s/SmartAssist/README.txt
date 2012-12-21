--------------------------------------------------------------------------------
                           S M A R T  A S S I S T 
--------------------------------------------------------------------------------

SmartAssist is an addon which improves default assisting and targetting system in groups.

Main features

    * Primary puller.
    * Assist all party members trough single key. No need to bind multiple assist keys!
    * Priorize low health players.
    * Assist from party members emotes (helpme/attacktarget)
    * Visual warning if acquired target is passive (not yet aggroed).
    * List of all available targets. See detailed explanation below.
    * Audio warning if you acquire aggro from known target.
    * Does not offer stunned or polymorphed targets for you
    * Selecting unit while holding shift will assist him. This works from anywhere where you can select unit. Example party icons, ct raidassist and even from player character.
    * Configurable spell slot which will be cast if the acquired target is in combat. For hunters this is Auto Shot by default.
    * SmartActions, See detailed explanation below.
    * Supports CT RaidAssist tanks automaticly.
    * Supports myAddons.
    * Supports Scrolling Combat Text
    * Does not use any chat channels to operate

Installation and configuration?
-------------------------------

Extract SmartAssist folder to <your-wow-install-dir>\Interface\Addons\. Ingame 
go to the key binding options using esc key and bind key for assisting and 
optionally for setting puller.

SmartAssist configuration window can be opened by typing /sa or /smartassist 
command.

How to use it?
--------------

If you are in group you may wish to set a puller. Decide who it is going to 
be and set him as puller by targetting player/pet and either press 'set puller' 
key or select 'set as puller' from player portrait menu.

This is not mandatory and SmartAssist does excellent job even without assigned 
puller. This is because the assist lookup order is based on character class.

If you have not set someone to be a puller, SmartAssist will automatically use 
your pet as one.

When hitting 'SmartAssist'-key it will try to find who to assist starting from 
your assigned puller. If it doesn't have good target it continues to look if 
someone in your group is in need of assistance. If there isn't anyone to assist 
in your group can be configured to fallback to basic target nearest enemy. 
This should select good target in almost any situation.

You can skip current assist by pressing 'SmartAssist'-key again, it should jump 
to next available party memeber. So you can cycle trough all targets of your 
group easily.


Available targets/assists
-------------------------

Display floating list that has all hostile targets listed that your group is 
currently engaging. Displays the name and health of the target and targets 
target. Name of the targets target is color coded: white=normal, green = MT, 
Red = You. Border of box is also color coded: Red = Hunters mark, 
Black = Target is under crowd control (sheep, trap etc). Currently targetted 
unit background is displayed in green and pullers target in yellow. There's 
also small text at the bottom of box that tells who is targetting the mob. 
If theres more than one targetting that enemy you'll see counter.

Once you get used to reading this list you get very good overall idea 
what's going on.

So what exactly are smart actions?
----------------------------------

Consider following situation, you have some ally unit selected and you wish to 
assist him. Normally without any addon you first press assist key and then 
start casting the spells. Smart actions improve this scenario so that you 
don't need to change target manually or press any assist key. With smart 
actions you can just cast the attack on your ally and SmartAssist will detect 
the situation and switch to ally target.

Another scenario which we can make smarter is when you don't have any target 
selected. Instead of getting 'You have no target' SmartActions can do SmartAssist 
and try to acquire some target before casting the spell.

To accomplish these features SmartAssist will need to know what actions are 
considered as attacks. This is done by dragging the spells to configuration 
dialog.

SmartAssist also provides built in spell lists for some classes. Once you 
startup SmartAssist first time it will ask if you wish to use auto configure.

Other
-----

This is my first released addon. As a beginner addon writer I've had to look 
other addons for source of inspiration. There are some bits and pieces from 
various addons and I've done my best effort to comment and credit every one 
of them.


--------------------------------------------------------------------------------
 Problems
--------------------------------------------------------------------------------

KNOWN: 

- Current version works only with english client

AND FOR REST:

- First try to reset addon settings by command /sa reset

- If problem persist you may get more information about what is going on by 
  entering command /sa debug. Additional information will be printed in General. 
  You can turn debug off by typing command again. These messages might be 
  helpfull to determine what's going on. 

You can reach me trough email: paranoidi@gmx.net altough it is not my main email
account.

--------------------------------------------------------------------------------
 Other
--------------------------------------------------------------------------------

This is my first released addon. As a beginner addon writer I've had to look
other addons for source of inspiration. There are some bits and pieces from
various addons and I've done my best effort to comment and credit every one of
them.

--------------------------------------------------------------------------------
 Is this addon against blizzard policy ?
--------------------------------------------------------------------------------

Moderator has stated in interface customization forums that:

"Just so you know, the designers are against mods doing automated spell choosing 
and target choosing for players, there just isn't a good way to prevent it at 
the moment. If you do add such a feature, it's pretty likely to either not work 
or not be allowed at some point in the future.

Note that this does not mean that such mods are illegal at this time, just that 
they are not encouraged."

SmartAssist shouldn't be one of the unwanted addons due following reasons:

- This addon does not do any automated spell choosing.

- Automated target choosing I believe refers to addons that would select target 
  that has least HP or are otherwise ideal targets. SmartAssist doesn't do work 
  this way, it doesn't go trough all available enemies and select the one with 
  lowest health. Instead we assist group / raid members one by one and stop 
  when we have target.

  Only questionable feature that I can even think about is that SmartAssist 
  skips stunned mobs. However that is not the main idea of this addon and if 
  it is ever found to be something that addons should not do I will remove it. 
  Also note that this skipping is not as definite as sheepdefender which is
  somewhat commonly disputed. You CAN still attack stunned mobs accidentally,
  forexample if someone sheeps your target. 
  
--------------------------------------------------------------------------------
 Readme is updated to version 1.2.1
--------------------------------------------------------------------------------
