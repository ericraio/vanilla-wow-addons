ChatCast v1.41 by no quarter (Mediva on Kel'Thuzad)  email: no_quarter@comcast.net


This addon makes buff, invite, heal, rez, healthstone/soulstone, mage water and other requests into clickable links in your chat window.  When you click on the link, it will cast that buff on the person who requested it.

It will work for triggers in any chat channel although I disabled it in the trade channel.  It also makes 'invite' requests clickable to invite that person, and checks for a wide range of invite offers to make a link that sends a tell requesting an invite from that person.

When clicking a request for a healthstone or conjured water, it figures out what the best healthstone/water the person can use is, creates and then trades the item automatically.  Soulstones require one click to create, and a second click to use if you had to create one first.

Using the LastLink keybinding will run the last link displayed.  By default it only considers buff links for the keybinding, but using /cc lastlink will change it to do other links as well (including HitsMode links), but not links that send tells such as LFM, PST and 'ask for invite' links, to prevent accidental spamming.  Alternatively you can create a macro that runs "/script ChatCast_LastLink()" and drag that to a button.

The intent of this addon is to make it easier to buff people who ask in raid chat instead of sending a tell, so now you don't have to bother targeting them to cast the buff.

HitsMode support works with the current Hitsmode and includes links to recast buffs, the next version of Hitsmode will be able to make links to cure afflictions, dispel buffs from enemies, counterspell enemies, and sleep shapeshifters.  HitsMode links can be run by the LastLink keybinding when the keybinding is set to run all links.

This addon is based in part on URL Copy by Noghlin.  The buff triggers and structure are originally from WhisperCast by Sarris.

Future plans: 
UI to change settings more easily and possibly add custom triggers.
Tooltip or right click mini-menu for links to display what will happen if you click the link.
Button/Titan plugin to act as a visual indicator for LastLink (possibly one for buffs and one for counterspells/dispels for pvp purposes).
DoT links for Hitsmode

Please email any bugs or suggestions to me at no_quarter@comcast.net or post them on curse-gaming or ui.worldofwar.net.

Special thanks to Chowdyr for helping test this and to andreasg for Paladin quality assurance.

German translation by turboPasqual.


Usage:
/cc color [reset|RRGGBB] - Opens a color picker to choose link color, allows hex color values. (Default = Yellow)
/cc brackets [on|off] - Toggles brackets '[]' around created links. (Default = off)
/cc sound [on|off] - Toggles sound effect on link clicks. (Default = on)
/cc feedback [on|off] - Toggles success/failure feedback in chat window on link clicks. (Default = off)
/cc invites [on|off] - Toggles creation of 'invite' links (Default = on)
/cc autosend [on|off] - If on, clicking an LFM link will send a whisper immediately, setting to off will bring up a chat edit box with your whisper in it instead.
/cc lfm <message> - Sets the whisper text sent when clicking an LFM link.
/cc lastlink - Switches between being able to run all links (including Invites and HitsMode links) with the LastLink keybinding or only buffs asked for in chat.
/cc hitsmode - Option for ChatCast to process Hitsmode text or leave it untouched.  Unit names will be clickable to target even when off (with latest version of Hitsmode)

v1.41:
-Updated toc for 1.10
-Fixed Blessing of Kings and Divine Spirit triggers, added Prayer of Spirit

v1.4:
-Support for HitsMode: With the current version of Hitsmode, it only supports rebuffing.  The next version of Hitsmode will make unit names in the combat log clickable, and add dispels/counterspells/debuffs for ChatCast to make links out of.
-Fixed a bug preventing the right-click menu on a name from appearing
-Attack doesn't get turned off when casting a buff via link now
-Added oom and healme emotes as links for innervate/heals/mana tide
-Mana Tide, Water Walking added for shaman, Conjured Food for Mages, Druids no longer get Innervate links if they don't have the talent
-Other minor adjustments to keywords

v1.3:
-Fixed bug with keybinding preventing it from working on links other than buffs
-Added referred 'summon' request and 'heal' request, so if someone says 'summon <name>' it will summon the referred character
-Added German translation, need more help with this one
-Prevented possibility of overlapping links when people use lots of keywords
-Added invite keywords for 'inv' as well as 'has joined the battle' (so that you can invite in battlegrounds easier)
-Much less case shifting when scanning links

v1.2:
-Last Link keybinding: Added a keybinding to execute the most recent link.  The default setting will only cast buff links.  Typing /cc lastlink will set it to cast buff links and invite links but not links that send tells such as 'LFM' or 'PST' links.
-Option for 'LFM' links to either autosend a customizable whisper, or bring up the chat edit box for you to type out a whisper
-More aliases for Paladin buffs including new group buffs (bow, bok, bos)
-Improved best buff determination (in some circumstances it could pick a rank you didn't know yet)
-Fixed level 34 Healthstone typo (created Soulstones instead of Healthstones at that level) 
-Paladins will no longer get Blessing of Kings and Blessing of Sacrifice links if they don't have those talents
-Chat time stamps no longer cause ChatCast to allow links in your own outgoing tells or in the trade channel.

v1.1:
-Fixed Paladin initialization bug.
-Fixed bug with target level check during item creation that was creating items at minimum level.
-Minor optimization regarding OnUpdate().  ChatCast no longer registers for OnUpdates except when trading via link.
-Reduced the scope on Invite Offer triggers a bit to reduce some overzealous links.
-Added 'PST' trigger that starts a tell in the editbox when clicked.
-Stopped links from showing up for spells that are too high level for the character to cast yet.
-Added support for ForgottenChat.
-Finished localization support and split autotrade code into a separate lua.

v1.0:
-Initial release.