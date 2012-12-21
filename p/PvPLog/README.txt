PvPLog 
Author:     Josh Estelle
Version:    0.4.6

README


Installation:
    You should have just downloaded PvPLog.zip
    This file will unzip to:
        PvPLog/
        PvPLog/CHANGES.txt
        PvPLog/PvPLog.lua       
        PvPLog/PvPLog.toc       
        PvPLog/PvPLog.xml       
        PvPLog/README.txt
        PvPLog/TODO.txt
    Place the entire PvPLog directory in your 
    WoW/Interface/AddOns directory.

    
Use:
    PvPLog will automatically log your PvP wins and losses
    as well as your duel wins and losses.

    You can enable/disable PvPLog with:
        /pvplog enable
        /pvplog disable
    When disabled PvPLog will *not* track any of your PvP activites.

    
    When you win/lose a PvP battle, or duel, PvPLog will notify you
    as the data is recorded.  You may change the notification
    location from overhead to the chat panel or turn it off all together.
        /pvplog location overhead
        /pvplog location chat
        /pvplog location none

    
    Whenever you mouseover someone for which you have a PvP record
    the mouseover tool tip will contain the number of wins and
    losses you have against that player.  It will also produce an audible
    ding on mouseover to inform you of a player you have a record with.
    At this time a message is also displayed overhead with your record.
    The sound used for this audible ding may be changed with:
        /pvplog dingsound AuctionWindowOpen
        /pvplog dingsound igMainMenuOpen

    If you don't want this ding to pop-up for people you've dueled against
    you can use the following:
        /pvplog ding noduel
        
    Or if you only want the ding to happen when its someone you've killed
    or whos killed you, and not someone who belongs to a guild that's killed
    you or you've killed, then use:
        /pvplog ding noguild

    Or if you don't want notifications for either duels or guilds, rather just
    individuals that you've killed or have killed you, use:
        /pvplog ding noGuildOrDuel

    You may also change the timeout on this ding, the default is to only
    ding every 2 minutes (120 seconds), you may change this with:
        /pvplog dingtimeout seconds


    When targetting a player you have a PvP record with, your record
    will be displayed below the target window.  This text is movable.
        /pvplog targetreset
            May be used to reset the text to its original position.


    You may search for a specific players record against you using:
        /pvplog find <search string>
    The search string can be found in the players name, class, race, or guild.
    Examples include:
        /pvplog find Interrupt
        /pvplog find int
        /pvplog find tauren
        /pvplog find shaman
        /pvplog find syndicate


    You may get some basic statistics using:
        /pvplog stats


    You may get the version of PvPLog with:
        /pvplog version
    

    When you kill or are killed, you may have this information reported via chat
    to your party, guild, raid, or another channel.  To change this setting use:
        /pvplog notifykills none
        /pvplog notifykills party
        /pvplog notifykills guild
        /pvplog notifykills raid
        /pvplog notifykills channelname
            (for your kills)
    or similarly
        /pvplog notifydeath none
        /pvplog notifydeath party
        /pvplog notifydeath guild
        /pvplog notifydeath raid
        /pvplog notifydeath channelname
            (for your deaths)
    
    The text that is used for this nofication can be customized using:
        /pvplog notifykillstext short
        /pvplog notifykillstext medium
        /pvplog notifykillstext long
        /pvplog notifykillstext custom
    
    PvPLog: Custom Chat Noftifications
      Type the following to use a custom chat notification:
        /pvplog notifykillstext "custom string"
        /pvplog notifydeathtext "custom string"
      Where "custom string" is the text you want used, with
      format codes as follows:
        %n - name, %l - level, %r - race, %c - class, %g - guild
        %x - X:coordinate, %y - Y:coordinate, %z - zone
      Example:
        /pvplog notifykillstext "I killed %n (Level %l %r %c) at [%x,%y] in %z."


    You may reset your PvPLog settings using:
        /pvplog reset confirm
    Be careful as this will erase all your records!
    

    In the development versions of PvPLog you can type:
        /pvplog listall
    to see a list of all your PvP records.
   

    If you have any comments, questions, or suggestions, feel free to 
    email me at:
        pvplog@joshestelle.com



Thanks:
    Special Thanks to Whizzer and MasterMike for patches to fix double death bug.
    Thanks to DamageWatch author, early reference
    Thanks to WMD BodyCount author, early reference
    Thanks to TargetLog author, early reference
    Thanks to Michai@Eredar for helping me test
    Thanks to Iriel@Silver Hand for great insights in how to fix variable loss issues
    Thanks to AutoTrade authors, channel code
    Thanks to Cosmos authors, more channel code
