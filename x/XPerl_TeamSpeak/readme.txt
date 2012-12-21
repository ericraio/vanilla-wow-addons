X-Perl Teamspeak Monitor

This monitor provides a somewhat limited, but potentially useful keyboard
monitor to indicate when you are pressing a key. So, define the key the same as
your TeamSpeak push-to-talk key and you'll see in-game who's talking. Magic!

There are obviously some limitations to this. Notably it will only work when
WoW is the focussed application, so if you're browsing some web page and press
your push-to-talk button, WoW won't see it. It will obviously also not work if
you use voice activation. Also, due to the way WoW key bindings work, it is
not possible at this time to monitor Control, Alt, Shift (or other similar
modifier keys). And finally, you would want to run TeamSpeak/Ventrilo on the
same PC that WoW is on, unless you fancy pressing 2 keys at once :)

NO, it will not work with voice activation. We are strictly bound by the very
proper limitations of the WoW API.

This is a standalone module that will work without X-Perl proper, and will be
available to download seperately. It is also easy to incorporate the same
functionality into other UnitFrame addons.

Command line: /ts /teamspeak /vent /ventrilo

All of these will open the TeamSpeak monitor icon. Right clicking this will
show options menu for anchor direction. X-Perl UnitFrames user won't need to
use this as the Speaking icon is indicated on the player's frames.

This can be done for any UnitFrame mod quite easily also.

Support already in place for:

        X-Perl UnitFrames
        Perl Classic UnitFrames
        Nymbia's Perl UnitFrames
        Nurfed UnitFrames       - Although the placement was somewhat tricky. If someone with more knowledge than me of Nurfed (ie, none) would like to look over this and improve the icon placement, then please do so.
        NUF
        CT_RaidAssist raid frames
        Blizzard Player and Party frames

To add support for another unit frame:

        XPerl_TeamSpeak_Register("player", myPlayerFunc)
        XPerl_TeamSpeak_Register("party", myPartyFunc)
        XPerl_TeamSpeak_Register("raid", myRaidFunc)

        function myPlayerFunc(speaking)
                XPerl_ActivateSpeaker(myAnchorFrame, anchor)
        end

        function myPartyFunc(name, speaking)
                local id = XPerl_GetPartyPosition(name)
                if (id) then
                        local frame = getglobal("myPartyUnitFrame"..id)
                        XPerl_ActivateSpeaker(frame, anchor)
                end
        end

        function myRaidFunc(name, speaking)
                local id = XPerl_GetRaidPosition(name)
                if (id) then
                        local frame = getglobal("myRaidUnitFrame"..id)
                        XPerl_ActivateSpeaker(frame, anchor)
                end
        end

For XPerl_ActivateSpeaker(frame, anchor). If anchor is not specificed it will
default to "LEFT"


--
X-Perl Teamspeak Monitor by Zek <Blood Cult> - Bloodhoof-EU
