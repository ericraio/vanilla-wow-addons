Moog HUD by Moog
Modification of Nurfed HUD by Tivoli (www.nurfed.com)
Use /moog to bring up options menu
---------------------------------------------------------------------------

v1.11.1 - 20 June 2006
  * Stopped registering events during zoning (Probably now redundant under 1.11)
  * Added option to seperate player health/mana values with the bars

v1.10.1 - 30 Mar 2006
  * Updated channelling code to use new SPELLCAST_CHANNEL_STOP event.
  * Made long spell casting pulse happen for channelled spells as well

v1.9.4 - 22 Mar 2006
  * Added the option to have the HUD pulse when casting is complete. Seperate options exist for duration casts and instacasts.
  * Made combo points update on more events, preventing combo points seeming to linger after mob deaths, etc.
  * Fixed a bug that would only occur when a mob changed name (eg. shrinking the giants in Feralas)

v1.9.3 - 11 Feb 2006
  * Made the icons default to off. They can be re-enabled in the options menu for those who hide their normal player portraits.

v1.9.2b - 11 Jan 2006
  * Fixed problem with hiding target stats
  * Changed saved variables method after someone pointed out the correct way

v1.9.2 - 11 Jan 2006
  * Tidied up some localization use
  * Increased the max and min vertical positions
  * Added extra checking to prevent attitude checks between players, since this can cause errors across zones

v1.9.1b - 8 Jan 2006
  * Properly fixed the bug which occured when a nearby player changed pvp state

v1.9.1 - 4 Jan 2006
  * Changed version numbering to make more sense (at least to me)
  * Made own class icon fade out when not in a team (and hence no menu available)
  * Stopped showing mob class icon unless selected in options
  * Mob name is now in reaction colour (ie. unfriendly/neutral/friendly)

v1.18b - 3 Jan 2006
  * Fixed a bug which occured when a nearby player changed pvp state

v1.18 - 28 Dec 2005
  * Added state/party icons around player and target icons (Thanks to Sael for most of the code)
  * Fixed bug with mana/energy/rage bar caused by Druid shapeshifting (Again thanks to Sael)
  * Added options to use percentages for target values, even when real values are known. Please note that some values are
    always percentages even with this unticked due to the information that Blizzard allows UIs access to.

v1.17 - 25 Dec 2005
  * Added MobHealth/MobInfo compatibility
  * Added seperate options for disabling self and target information instead of a global text on/off

v1.16 - 21 Dec 2005
  * Made options menu draggable
  * Added class icons for self and target. These double up as clickable buttons for self/target menus.

v1.15 - 20 Dec 2005
  * Fixed bug with target model returning after turning it off in options
  * Caught nil strings error when typing /moog on it's own

v1.14 - 17 Dec 2005
  * Fixed texture distortion during first spell cast of a session
  * Added extra options to options menu

v1.13 - 17 Dec 2005
  * Now has options menu available by typing '/moog menu' or just '/moog'. Will populate with more options later
  * Made target healthbar and name turn grey if tagged by another player/team (ie no xp or loot)
  * Fixed bug where own health would turn red under some circumstances

v1.12 - 16 Dec 2005
  * Changed mana numbers and bar to be a matching blue. Doesn't match the normal mana blue, but works better imo
  * Fixed a bug where target health seemed to spike as you deselected or lost view of a target
  * Own health now says 'Dead' in grey when you're dead or a ghost

v1.11 - 13 Dec 2005
  * Reduced the Cast Time to one decimal place, more was just distracting
  * Removed seperate % health display since all non team targets only show a % anyway.
  * Upgraded the target level readout to include target con colour and target classification (eg Boss or Elite)
  * Delayed spells were actually showing as finishing faster rather than slower, this has been fixed
  * Dead targets now simply say 'Dead' in grey, rather than 0% in the normal red
  
v1.1 - 12 Dec 2005
  * Removed deliberate smoothing from Cast Bar as it caused a constant lag from the real timer
  * Added Cast Time remaining value to remove all need for a traditional Cast Bar and Cast Timer

v1.0 - 12 Dec 2005
  * First release
  * Fixed Cast Bar functionality of Nurfed HUD

Known Issues:

  * None

---------------------------------------------------------------------------
The intention for this UI mod is to replace as many of the traditional panels with a single clean central display.

With many classes the need for many extra buttons and mod displays means that the original
panels can end up taking up needed UI real estate, and this is an attempt to clean up some space
and remove the need to look away from the screen center any more than absolutely necessary.