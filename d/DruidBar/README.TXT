Druid Bar, v3.26
Druid Bar is a movable mana bar that keeps track of your current mana, even in a shapeshifted form like bear or cat. remember that this addon is an estimation of your mana, and it could be slightly higher or lower depending on your level(Lower levels will have more problems since there is much less room for error with their smaller mana pools). 

-------------------------------------------------------
-------------------------------------------------------

If you've used previous versions(<3.0) of DruidBar...

My suggestion to you is this: Completely remove the previous version of DruidBar. Delete it. empty that trash can. Then load up the game once. Then, log out and install DruidBar 3.0. Log back in, and configure to your liking. Why should you do it this way? Well, a few of the Saved Variables stayed the same, but most changed. If you just added the new version, you'd have a ton of variables just junking you up. So might as well start from scratch, eh? Of course, you COULD just try adding it as is....who knows what trouble it could cause? mwuahahahahaha...AHAHAHAHAHAHA!

-------------------------------------------------------
-------------------------------------------------------

Slash Commands: /druidbar or /dbar
parameters: [on/off/toggle/vis/width/height/hide/lock/replace/player/text/message/status]
Explination of the parameters:

On/Off/Toggle: This will toggle running of the addon. toggle switches between on and off.

Vis: This will enable or disable any and all graphical stuff. if you use with other addons like StatusBars or Linoleum, turn it off. If not, leave it on ^^

Width (#): This will let you set the width of the bar. Default is 160px. 

height (#): This will let you set the height of the bar. Default is 18px.

percent: This toggles between 3 options: Showing Raw mana, showing %Mana, and showing both. Works for both the normal bar and Replace.

hide: This will toggle on/off the hiding of the bar when in caster form.

full: This will toggle on/off the hiding of the bar in animal forms when your mana is at 100%

lock: This will toggle on/off locking the position of the bar.

replace: This will replace the Player Frame's mana bar, splitting it into two when shifted.

player: This will make the bar show up directly under the Player Frame. You know, where a lot of other addons like to place your Experience Bar.

Text: This will toggle between 3 options: No text, "Classic" text, or "Modern" Text. (Modern having a border, Classic having no border). This option carries over for both the normal bar and the replaced bar.

Message (toggle/bear/cat/aqua/travel) (say/party/raid/emote) (message): Message allows you to customize saying when you shift into/out of a form. More of a novelty item I did for a guildie, it's here in case you want it too. More in-depth info about the message parameter:

	/dbar message toggle: This will toggle messages on and off. Default off.

	/dbar (bear/cat/aqua/travel) (say/party/raid/emote) (message): This will set the 
	message for the feral form you choose, in the channel you choose. for example, 	
	choosing /dbar bear say "rawr, imma bear!" will make you say that when you shift 
	into it. make sure ya get the format right, 'else it'll yell at you!

Status: This will list the status of all the toggles in your chat window. Simple, Easy, Effective.

Best: This will try to determine which is the best travel form for you to be in; Mounted, Cheetah, or Aquatic.

kmg: This will try to replace the MiniGroup window's mana bar with a split-screen bar like with replace.

Debug: dumps some junk into the chat frame to help me(and you) figure out why the bar is not subtracting the proper amount of mana.

ez: turns off ezshift. lame.

-------------------------------------------------------
-------------------------------------------------------

Contact info:
In-game: Velora(Silver Hand)
Aim: Ska Demon X
Email: skademon@catsonmars.com
Or catch me on www.curse-gaming.com or www.worldofwarcraft.com UI forums. (SkaDemon on former, Velora on latter)

-------------------------------------------------------
-------------------------------------------------------
Version History
3.23:
Ok, this one i've playtested a hell of a lot to make sure i got absolutely perfect.
Tooltip scanning is working fine and not having any problems or creating too much lag.
Fixed a bug with the french version and the addon somehow not catching that the french version displays the mana differently.
(Note to self - HOW THE HELL DID THAT BUG GET IN  ????)
cleaned up the code just a smidge, as well as redid some variables to actually make sense for people reading the code.
Added that nifty zoning trick to speed up load times, thx fireball/prudence/tigerheart!
Added Metamorphosis Rune support for EN. i hope. (need translationskthx!)

3.22:
Tried to update for the patch and the broken tooltips. I don't think it worked too well
Redid the best option to work with the whole no-binding-hooking thing, thanks to Zevzabich for that.

3.21:
Fixed the TOC. i hate blizzard sometimes.
You'll notice /dbar hide no longer hides the bar in feral form when your mana is full. This is because it has been split into a new function
/dbar full - Hides the mana bar in feral when your mana is full. Enjoy.
Tampered with the mana regeneration formula to properly account for mana/5sec now.(mana regen * 2 / 5, so it's distributed evenly over each tick.)
Tampered with the Best option to allow most other castable mounts to work with best. Just for people that want to keep one button as their mount button(since keybindings were shared and thusly sucky.)
Other random code changes that shouldn't be noticeable

3.2:
1.9 changed how druids work. we now get the benefits of mana/5sec in feral forms.
DruidBar now reflects these changes.
Fixed a bug with the german code. oops!
Tampered with /dbar best to work with frostwolf mounts(EN Only), will add to this as i get this system worked out right.
everything else should be golden!

3.14:
Trying to fix all of the errors i recently created.
lifted and separated the shapeshift cost function to see if i could get it to work right.
fixed the best bug where you couldn't shift to travel until after a reload. i hope.

You know what? I doubt i fixed anything. just ignore this.

3.13:
added /dbar debug. It doesn't actually show debug data, it just dumps into the chat frame how much mana it should be taking away when you shift, as well as how much your shapeshifting spell should cost.
redid /dbar best a little bit. in fact, quite a bit. thanks for all the help guys.
If you hold down the shift button while doing /dbar best, it will always put you into travel form. this is for places like zul'gurub/zul'farrak where it can't detect if you're moving.

3.11/3.12:
Trying to fix bugs in other clients. failing.

3.11:
Played with the code a lil to make it work for everyone i hope.
Nothing changed on the outside, just changed how it does stuff a lil on the inside.

3.1:
Updated for 1800
Swiftshifting doesn't exist; hence, the sound prompt no longer exists.
changed the addon to work with the new reflection talent.
I -might- have fixed the bug with it not reporting shifting changes. but probably not. so don't expect anything.
3.05:
Okay, the addon should be working as good as the old one now!
Fixed a bug that would make the bar never show up if you weren't using some interesting other option.

3.02:
Added MiniGroup support back in. Start your worship....now. /dbar kmg to get it to work.
Re-added the best form option. use /dbar best.
Fixed a bug where it would play the swiftshift noise when you had 0 points invested in it.
Fixed a bug where hide was not working with the Player option.


3.0:
Totally remade from pseudo-scratch.
Streamlined the code(for the most part).
Made it more accurately report shapeshifting and casting costs at all times.
fixed a bug where it'd consider you shifting when you log in/reloadui in a form.
Temporarily removed Textcolor, barcolor, EZShift(it's still in there, just set to always on) and MiniGroup support(until i redl it and redo it). expect these later!
Added /vis, to remove all graphics for support, with other addons that plugin to druidbar.
changed /changex and changey to /width and /height to reflect their job better.
shortened /playerframe to simply /player. Made it behave a bit better and do its job right.
changed /texttype to /text, and integrated ShowText into it.



2.57:
Added non-druid support, so you wouldn't have to unload the addon every time you swapped to an alt.
(Cause we all know your druid's your main =D)

2.561:
So silly. I added what channel message broadcasts to.
format's now: /dbar message (bear/cat/travel/aquatic) (say/emote/party/raid/whatever) (message)

2.56:
changed message to pick what channel you want to speak to. sorry, no futabachan.

2.55:
Fixed a bug that broke other addons ^^;
Hopefully fixed the bug about the mana bar not being docked to the player frame properly when using that option.
Swiftshifting now reports when you shift into travel or aquatic.
added an option to say a phrase when you shift into a certain form.
use /dbar message toggle to turn it on/off.
use /dbar message (bear/cat/aquatic/travel) [message] to change the message for each one.
You're welcome, Aniril! Go make some druid PvP movies.

2.51:
Fixed a bug with /dbar best and AutoRun. Should work fine
NOTE: best does not work properly when using the numpad or the mouse to move. O_o Not sure if i'll ever get this fixed either.
Removed the mana drain script for now, until i get it to be more accurate.

2.5:
added /dbar best - will shift you into the best and most applicable form.
Standing still - Mount(if applicable). Moving - Travel. Swimming - Aquatic form.
Note: For aquatic to work, the breath frame has to show, so dive down a lil and get it to pop up before you cast.
Note2: This command won't work if used as a slash command. You have to put it in a macro for it to work properly. I'm not entirely sure why, Spells can only be fired off button presses i guess, but this is what you have to deal with. It's not that bad, there's a keybinding for it as well if you don't want to use a macro.
Thanks to mib for putting this code together =D
Added Swiftshift support. Should remove the proper amount of mana now depending on your swiftshift skill.
Added Swiftshift Notification! Yeah, that's right, when you successfully swiftshift, you'll know! A blue "Swiftshifted!" message will be shown in the error frame, and you'll hear an audio cue. ^^; Thanks to ChibiFS for helping me out with that section of it, as well as supplying the sound file.
Note: These will only fire for Bear/Cat form. This is partly by design and partly because you can see your mana in travel/aquatic form anyway.

2.4.1:
Fixes yon new minigroup bar to hide when not using a druid. silly oversight, but ah well.

2.4:
Background? BACKGROUND?! Why, blizzard? Why?! Why did you have to move your PlayerFrame to the completely obscene "Background" frame, and not keep it in the "Low" framestrata?! Yeah, this was the problem with /playerframe, and it's been fixed.
It also means I had to add a new bar to account for kmg's Low framestrata.
There is also something very interesting written in the lua. VEEEEERY interesting. Find it and have fun with it. Because it's not light red, it's PINK. (rvb ftw)

2.3:
Changed the TOC.
Um. i added experimental mana drain support. it doesn't distinguish from any form that might not drain while shifted. O_o Just something fun to play around with and see if it works.
Fixed a bug with MiniGroup and scaling the druid bar for kmg.
Also fixed a bug with the druid bar and toggling off kmg. now the bar won't appear in front of the move frame. >.<

2.2:
Made the /dbar PlayerFrame work a bit better, though not much.
Fixed the whole "aquatic/voyage" thing for FR clients.
Not much else I did. If i added anything else, I don't remember what.

2.16:
Bugfix update.
1) Should make sure when using replace that you never see the mana bar text. 
2) EZShift wasn't loading properly with SelfCast every once in a while. Now it should load right. ^^

2.1:
Ok, this one's an official update.
First of all, Alt-Casting =SHOULD= be fixed. or at least I can't find any more problems...
I also added EZShift, which toggles on this function for the action bars. Toggle it off if you're having problems with alt-casting on yourself. Otherwise, enjoy.
Changed how Percent works with the main draggable bar. Percent on: Shows the full raw # and %. Percent off: Only the raw #.
Added BarColor: For people that don't like their mana bar to change colors as it goes down.
Finally added kmg to the command list. It's still experimental so use at your own risk please.

2.01:
Grrr. I fail at life. it makes me ANGRY.
Or hungry. Buttons shouldn't be broke anymore.
I know this is just a bugfix version, but there's also something experimental in there with kaitlin's MiniGroup that i was working on when i found out about the bug. Read the txt file for more info, or ignore it ^^

2.0:
Wow. Redid a lot of the code dealing with displaying things.
Cleaned up a lot of the wasteful code.
Added a lot of wasteful code.
"Fixed" the problem with action bars. Sorry Jeff. =P
Added new functionality(that actually works this time): Casting any shapeshift spell from the action bar
will shift you out of whatever form you're in, same as it would hitting the shapeshift bar. This also works with any macros that have the same picture as shapeshift spells. Use it for macros where you would shift out of whatever form you were in ;)
Added ChangeX and ChangeY: That way you can make the bar smaller or larger than it is. For those that like to nitpick sizes ^^
Added PlayerFrame: This toggle will basically move it under the player frame, similar to those EXP bars that show up under the player frame. I don't know why I added this, someone asked. Use if you feel like it.
Added TextType: For people that felt the unoutlined text was annoying, or wanted to make the text match the Player Frame's outlined text...well, there you go.
Added TextColor: This is more for fun than anything else. Customize your look. Go ahead, make it pink. And don't bother TRYING to call it light red. It's pink. PINK!! Can use Textcolor r # to set a single color, or TextColor Set # # # to set all 3 colors at once.
Should be working for DE and FR, yay! thanks for the help everyone!
Should be working perfect for US. Unless you guys find any bugs or make suggestions for new stuff for me to work on, i'd have to say this is -the- version to have, or fall back on if anything ever goes wrong. ^^

1.925:
I'm not going to say I need to contact Jeff, but Jeff? Where are you?
I need to contact you, by pistol-whipping you with a railgun! hehe ^^
The error 500 people have been getting -should- be fixed.
Let me know how it works for you.

1.9:
Expanded the functionality of the Shapeshift bar to any action bar. No more need for Shapeshift macros! Just drag and drop the Shapeshift spell from your spellbook to your action bar, and go. You will get messages about "Cannot use in shapeshift form" but it's a small price to pay. (There's currently no way I know of to prevent them from showing up)
Fixed a couple of typos about how to use the slash command.
Should be perfectly useable in EN, FR, DE now. If anyone wants to localize the rest, you're welcome to send it to me ^^;

1.875:
Just a fix to my fix. Seemed to work well.

1.85:
Fixed a bug where it wouldn't get the shapeshift mana cost in Fr/De clients. Thanks to Iguane for pointing this out, and a solution!

1.8:
Added Percent - So you can swap between % and #.
Played around with ShowText to be compatible with the built-in interface toggle, so you can use that to show hp all the time, and showtext to show the mana on replace. Shouldn't be a problem using the draggable bar.
(Goodness knows how it works with cosmos --; let me know)
Fixed a bug with Innervate never turning off. Yay for accidentally making the mod useless!
moved around bits of code to hopefully make it work better.

1.7:
Fixed the bug about money not showing up properly. hooraj.
Added Health support to the ShowText option.

1.6:
Fixed the SetFrame bug. I hope that means it's bug-free now O_o pending Innervate.
Added preliminary Innervate support. Let me know how it works.

1.5.1:
Another bug fix version, though this time nothing too serious.
2 minor updates, both with /replace.
First is fixing the Rage/Energy bar updating properly.
Second is fixing the % updating properly. Should be AOK now. hopefully. ^^;
If you plan on using Replace, please update to 1.5.1. If not, 1.5 is fine.

1.5:
Fixed a small calculation bug with hiding the large mana bar.
Added Replace...Well, look at the screenshot.

1.4:
Fixed a lot of bugs. I couldn't tell you specifically what,
Though the main fix was the crash when shapeshifted and your mana hit 100%,
As well as running your regen rate off of your Spirit.
Everything else should just generally run better.
+/-1% accuracy.
BIG thank you to Smithboy for all his help!


1.3:
Fixed lock not properly locking.
fixed a bug with lock and not showing the mana text on mouseover.
Modified how the program checks if you've shifted and subtracting the mana accordingly.
Fixed Regen rate getting reset when you log off and on.
If you have Hide enabled, the mana bar should now hide in shapeshift form when it gets to 100%
The mana bar will now change colors depending on how full the mana bar is.

1.2:
Even more accuracy. Saves Regen rate over sessions, and ignores really high or low regen rates.
(Give it about +/-50 margin of error usually)
Ignores when you're drinking to restore mana.
Added Lock: Will lock the mana bar in place. So you can't move it.
Added Hide: Will hide the mana bar unless you're in a shapeshifted form.
Added a bit better reflection support.
Tried to make my code a lil bit easier to read. Should have commented it. Doh!

1.1:
Made the bar more accurate. Still give it the +/-100 range, but lately it's been within 20mp for me.
Added an extra feature: If you're in one form, and you try to shift to another, you'll instead shift back to caster.
This way you can just press the shapeshift button you want twice, rather than push one, then the other.
Added a percent display to the mana bar, in case you like to read % rather than #.

1.05: 
All that stuff in v1.0? It should actually WORK this time. ^^ 

1.0: 
Movable mana bar that persists even while shapeshifted. Slash commands and junk. Probably filled with bugs, er, i mean, HIDDEN COOL FEATURES! 