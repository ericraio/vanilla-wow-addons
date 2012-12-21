Confab allows the user to do pretty much anything they wish to the chat editbox. It cames with 4 basic styles as well as the ability to undock, move, resize (up to 1024 pixels and down to 256 pixels), lock position and turn off the autohide feature. It also allows the enabling of the cursor keys so you can use them to edit text as well as scroll through your history (instead of using ALT+Arrows). As well as the ability to lock chat channels, change the editbox artwork, or making the editbox totally transparent.
                                                                                                                                                                                                     
Usable commands:
/confab
/confab style1|style2|style3|style4 (default: style1)
/confab autohide on|off (default: on)
/confab undock
/confab dock [frame]
/confab autodock on|off
/confab lock
/confab unlock
/confab chatsticky off|default|confab|party|guild|raid|officer|say|1-10 (default: default)
/confab enableArrowKeys  (default)
/confab disableArrowKeys
/confab texture file
/confab alpha n
                                                                                                                                                                                                     
                                                                                                                                                                                                     
Description of options:
style1 - Default WoW placement of the edit box (very bottom of the docked frame).
style2 - Places the edit box at the bottom (but inside) the docked frame.
style3 - Places the edit box at the top (but inside) the docked frame.
style4 - Places the edit box on top of the docked frame.
                                                                                                                                                                                                     
autohide on - Editbox is hidden when not typing text.
autohide off - Editbox is always shown, yet empty.
                                                                                                                                                                                                     
undock - Allows the editbox to be resized and/or moved anywhere on the screen.
dock - re-docks the editbox to the last frame it was docked to. Optionally a frame name can be given to specify which frame you want it to dock to (careful, your milage my vary using this optional parameter).
                                                                                                                                                                                                     
autodock on|off - The edit box is automatically docked with the ChatFrame the mouse cursor is in. This feature has limited uses and maybe removed in future releases.
                                                                                                                                                                                                     
lock|unlock - lock or unlock the edit box. When locked editbox is not movable. Only usable when editbox is in undocked mode.
                                                                                                                                                                                                     
enableArrowKeys - allows the arrow keys to be used to edit entered text without having to hold down ALT (ALT-ARROWs will still work however).
disableArrowKeys - Default Blizzard setting which allows arrow keys to be used for movement and ALT-ARROWs for editing entered text.
                                                                                                                                                                                                     
texture file - Specify the name of a .tga file that will be used as the editbox artwork.
                                                                                                                                                                                                     
alpha n - Set the alpha of the editbox to n where n is a number between 0 and 1 (0 being fully transparent, 1 being fully opaque (well, as opaque as the texture will allow)).
                                                                                                                                                                                                     
chatsticky [channel] - Used to lock (or not lock) the chatbox to a chat channel. Accepted channel Settings are:
 >  off - turns the chat sticky completely off. This makes it so the edit box will always come up with the last chat type that was used. For example, lets say your currently talking in Guild. The edit box will always come up as Guild until you change it whether its /p, or /s, or /t, /3, etc... it doesn't matter, it will always be the last type used.
 >  default - Default Blizzard sticky settings (Guild, Party, Raid, Say).
 >  confab - My special version that extends the default settings to also include Officer, and /1-10 channels.
 >  party - Locks edit box to always come up as Party.
 >  guild - Locks edit box to always come up as Guild.
 >  raid - Locks edit box to always come up as Raid.
 >  officer - Locks edit box to always come up as Officer.
 >  say - Locks edit box to always come up as Say.
 >  1-10 - Lock the edit box on one of the public channels (i.e, /1, /2, /3..). If you do lock onto a public (like /1 usually the zones General channel) and enter a zone that doesn't have a /1, the chatsticky setting will reset back to default.
                                                                                                                                                                                                     
                                                                                                                                                                                                     
                                                                                                                                                                                                     
Confab also provides the following commands for normal or macro use:
 > /tt - does a tell target, or target tell, depends on whether you have a friendly player targeted or not as to which it does.
 > /retell, /rt - send a /tell to the last person you typed (key word: typed) a tell to regardless of whether they have responded back or not. Any /tells done from macros (using /tt or /telltarget) do not change its value.
 > /targettell - explicit version of /tt. This will attempt to target the person who last sent you a /tell message. Mostly provided for completeness and for macro use (although /tt will work just fine in macros).
 > /telltarget - This is a dumb version of /tt (i.e. it doesn't change the edit box header to reflect your target). Mostly provided for completeness and for macro use (although /tt will work just fine in macros as well).
                                                                                                                                                                                                     
                                                                                                                                                                                                     
In a way the following two really don't belong here since they are more utility then anything else but seeing how I don't have a better place to put them just yet, they will be provided in Confab.
These are specific for macro use.
                                                                                                                                                                                                     
/targetsave, /tsave - Saves your current target for later retrieval.
/targetrestore, /trestore - Restore a previously saved target.
                                                                                                                                                                                                     
Some may wonder at the usefulness of these, but here is an example of their use. Say your a buffing class and get /tells for said buffs. You can make a macro as follows:
                                                                                                                                                                                                     
/tt
/cast <insert spell here>
/trestore
                                                                                                                                                                                                     
This will target the last person that sent you a /tell, cast the spell on them and restore your target to what it was prior to pressing the macro (/tt does the target save for you otherwise you would need /tsave first). Now of course there is potential issues here, like the target being out of range and such. However if the spell is in a targeting state when /trestore is called it will be cancelled (thus no mana spent). If you want to have it do a self cast instead just insert /target <your name> between the /cast and /trestore. Well, hopefully you get the idea.
                                                                                                                                                                                                     
If your a healer you can do something like this to send a message to your target that a heal is incoming:
                                                                                                                                                                                                     
/tt Casting <spell name here> spell
/cast <insert spell here>
