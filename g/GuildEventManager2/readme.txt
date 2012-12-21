Guild Event Manager (GEM)
by Kiki from European Cho'gall (Alliance)
Part of the GUI by Alexandre Flament
Home Page : http://christophe.calmejane.free.fr/wow/gem/
----------------------------------------

  ---
  ChangeLog :
  ----------------
  - 2.08 :
   - March, 31th 2006 :
    - Updated TOC for 1.10
    - Fixed 'N' text in minimap icon flashing sometimes, while there is no new event
    - Increased date column width, and added date in the tooltip
    - Added a new color code in Admin list : Blue=Connected but not grouped, Green=Connected and grouped
  - 2.07 :
   - March, 16th 2006 :
    - Fixed lua error in New event if you load a template created before Auto-members additionnal code
    - Finally fixed channels init errors. Password protected channels should work too.
   - March, 15th 2006 :
    - Fixed lua error in Admin list popup if not leader
    - You can now force yourself into replacement queue
    - Fixed force titular button not working, if the player was not in replacement queue before
   - March, 13th 2006 :
    - Handling "Force titular" param in Sorting of members
   - March, 10th 2006 :
    - Added possibility to ignore a closed event (new button)
    - Fixed bug in the ignore option (a previously ignored event might reappear)
   - March, 9th 2006 :
    - Added confirmation dialog for Delete Template (New event tab)
    - Fixed wrong reset instance day, around midnight
    - Added possibility to Auto-add members to an event (NOT FINISHED YET !! NO CHECKS !)
    - Saving Auto-members to templates
    - Added possibility to move a member back and forth Replacement queue
    - Added possibility to force a member in titular list
  - 2.06 :
   - March, 7th 2006 :
    - Fixed : some events not removed from the list, when changing channel
    - Auto-purging players that didn't connect since 1 month
    - Fixed players not sending any data when they first log in the channel
    - Added Events Calendar view (not finished yet)
    - Possibility to show instances reset from the calendar view
   - March, 3rd 2006 :
    - Increased EventsList size (2 more items), needed to incoming new EventView
  - 2.05-2 :
   - March, 2nd 2006 :
    - Fixed lua error line 699... sorry
  - 2.05 :
   - March, 2nd 2006 :
    - Fixed Channel initialization errors
    - Fixed password protected channel errors. Now displaying if there is a join error
    - Added possibility to choose channel to create a new event (from the GUI, in the NewEvent tab)
    - Added possibility to force an hours offset from the server with "/gem offset <hours>" option (ADVANCED players !!!)
   - February, 23th 2006 :
    - Fixed lua error when sorting some events by class or level
   - February, 20th 2006 :
    - Added possibility to set a default value for password, alias and slashcommand (like it was possible for Channel), so guild can build an archive with all values set correctly.
  - 2.04 :
   - February, 17th 2006 :
    - Fixed wrong event.date displayed when editing an event (if you have a timeoffset with the server)
    - Calendar correctly pickup the date matching your options (UseTimeServer option), as well as the Events list
    - Fixed issue with password in config (couldn't change a password with changing the channel name)
   - February, 16th 2006 :
    - Checking for expired events and commands before broadcasting
    - Now even players with a PC clock not correctly set, will correctly purge passed events
    - Removed TimeOffset config option, changed to UseServerTime CheckBox. When checked, the calendar will use ServerTime (instead of your local time) to create an event. Events in the list will be shown using ServerTime too.
  - 2.03 :
   - February, 16th 2006 :
    - Temporary fix for "I'm the leader of..." warning message. More robust fix soon
    - Fixed Crashed->Recover->Close-> Impossible to "unclose" (only "recover" possible)
  - 2.02 :
   - January, 6th 2006 :
    - Hopefully fixed GEM messages sent to wrong channel, when using an AddOn that leave/rejoin GEM channels without notifying GEM.
    - Improved GEM message flow (less messages sent in some situations)
    - Fixed 'Deleted event reappearing' issue.
    - Always uppercasing first char of External player name
  - 2.01 :
   - December, 23th 2005 :
    - Added new commands to configure multiple channels feature (try /gem help)
    - Added possibility to "Ignore" an event (non leader only) from a button in "subscribers" list
    - Added possibility for a leader to completly remove a closed event that is not passed yet (and tell every player to remove it)
   - December, 21th 2005 :
    - Added UI buttons to 'Unclose' and 'Recover' (EXPERIMENTAL !) an event
    - Fixed recover bugs :)
   - December, 19th 2005 :
    - Added 'bip your name' option, when someone calls you in a GEM channel
    - Detecting Drunk status, and delaying GEM commands until you are sober
    - Auto focus 'Name' field when opening AddExternal window
    - Checking channel IDs when you change zone (to prevent sending GEM messages to a wrong channel, like Trade or General)
    - Added possibility to promote subscribers as Assistants. Those promoted players are allowed to use the GroupAll button.
    - Added possibility to ignore events (need GUI or /CMD)
    - First step for 'partial recovering of a lost event'
   - December, 15th 2005 :
    - Added 'min' class limit value in the Subscribers plugin sorting function
   - December, 14th 2005 :
    - Changed the default enEN value for displayed dates, now it uses 12hours clock format with am/pm
    - Changed the configuration tab a little bit
   - December, 8th 2005 :
    - You can now use the 'Tab' key to switch between EditBoxes
    - Now sending your player's info (location/guild...) every 5min, if not sent during this period
   - December, 7th 2005 :
    - Fixed channel reinit bug, when changing alias in config (but not the channel name)
    - Fixed ChatFrame handler, to support GuildAds messages
   - December, 5th 2005 :
    - Auto removing control characters from comment lines, to prevent WoW disconnection
   - November, 23th 2005 :
    - Now purging to-send messages, when leaving a GEM channel
    - Fixed 'unknown' channel error in buffered send queue
   - November, 21th 2005 :
    - No longer closing your own events when you leave channel (fixes bug with alt char in another channel), but disabling admin
   - November, 17th 2005 :
    - If a leader receives an event is does not know, he auto-close it (if he crashed after creating new event, he'll loose it)
    - Fixed few possible lua errors
    - Improved change leader function (more robust)
    - Added debug messages (CHANNEL msg) to track error during ChannelInit
  - 2.00RC93 :
   - November, 15th 2005 :
    - Fixed GEM version not showing for other than me
    - Changed the way closed events are handled (removed GEM_COM_CloseEvent message, replaced by a field in EventUpdate message).
    - Few improvements in protocol, some code cleanup
    - Command line option "/gem events" now display all events for all chans (shows eventIds needed for "purge" and "ev_chan" commands)
    - Added new command line option, to *fix* lost events by changing channel : "/gem ev_chan <ev_id>" : This resets the eventId (must be leader) to the current joined GEM channel
    - Added new command line option, to completly purge a closed event (must be closed before purge) : "/gem purge <ev_id>" : This removes closed eventId from the list (must be leader), even if event date not passed yet
    - Added plugin API to send and receive messages (see GEM_comm.lua or readme file)
    - Now displaying ChannelName (or Alias if set) instead of 'GuildEventManager' when someone joins or leaves the channel
    - Changed tooltip back to how they were displayed (smaller font), but now auto-split long lines
    - Finished Options tab help tooltip (need deDE localization, and a check for usUS one)
  - 2.00RC92 :
   - November, 14th 2005 :
    - You can now choose the default sorting plugin you want to use, per character
    - Added a 'comment' line (in options) you can set, per character (will be shown in members list)
    - Improved members list with tooltips and infos
    - Improved tooltips in Events list
    - Added "/gem events" and "/gem unclose <ev_id>" commands, to list and unclose events (this is tempo, until a UI is made)
   - November, 12th 2005 :
    - Fixed possible receipt of a GEM message, before channels initialization
    - Added new sorting plugin by Nerolabs from Shadowsong Server
    - Added 3 new fields to player's informations (guild rank name/index, and a comment line)
   - November, 10th 2005 :
    - No longer automatically set channels (except default one) for rerolls
    - Added support (OMG so many changes to be made) for multiple channels (but not possible to join multiple channels via GUI for the moment)
    - Events are now locked to a channel
    - Added new bugs to be fixed, thanks to your help ^^
   - November, 9th 2005 :
    - Fixed more lua errors :/
    - Fixed Date showing in grey sometimes, in Events list
  - 2.00RC91 :
   - November, 8th 2005 :
    - Fixed 2 lua errors
  - 2.00RC9 :
   - November, 8th 2005 :
    - Now keeping closed events in the list. They are automatically removed when they expire
    - Now converting short day name in french (possibly in DE, if added to localization file)
    - Fixed few UI refresh issues
    - Added a small blink on minimap icon, when there is a new event
    - Implemented the 'Put in remplacement' button (event admin function)
    - Added ingame help and informations (search for '[?]' buttons)
   - November, 7th 2005 :
    - Reduced cps sent to a very low limit, to see if it improve lag/disco issues
    - Implemented _GEM_CMD_PurgeMultipleCommands function, which will greatly reduce obsolete cmd messages (and msg flow)
    - Recompute my_bcast_offset at each log in
    - Added speculative list of subscribers (tagged as 'NA')
    - In Subscribers list, get Guild name from Members list, if available (instead of the "N/A" tag)
    - Added a 'Invite' button in the popup menu in Subscribers list
   - November, 5th 2005 :
    - Fixed more lua errors
  - 2.00RC8 :
   - November, 4th 2005 :
    - Fixed many lua errors, and init errors
    - Completly removed debug flow, when debug is set to 0
    - Fixed possible lag issue (not sending multiple CloseEvent, when receiving cmd for unknown event I owned)
    - Added a low level flow control to sent messages, to prevent lag and disconnections. If you experience lag or disconnections, please tune the values _GEM_COM_MaxSendPerSchedule and _GEM_COM_ScheduledTaskInterval in GEM_comm.lua.
    - Increased personnal bcast offset range, from 1-30 to 1-90 sec (should reduce even more duplicated messages, at the price of more time to see new events or subscriptions when you log in)
    - Added confirmation dialog when closing an event
    - Removed Kick/Ban buttons in Subscribers tab (need room for new buttons soon), but added a contextual menu
    - Added to contextual menu, the new ChangeLeader function
  - 2.00RC7 :
   - November, 3rd 2005 :
    - Fixed lua error when an event is closed while you inspect list of subscribers
    - Added a new option in config, to show or not members login/logout
    - Added a new option in config, to specify an hour offset, for displayed hours
    - Added a new option in config, to filter events not in your selected character's level range
    - Now saving members, per realm, and per channel
   - November, 2nd 2005 :
    - Fixed localization errors
    - Fixed small channel flood occuring in some rare occasions
    - Added colors in Members list, to show officers and guild leaders
    - Fixed Unban button, showing for non-leader
    - Automatically remove "/" if set in SlashCmd Editbox
   - October, 30th 2005 :
    - Fixed possible error at init
    - Added Member's count, and possibility to see offlines
  - 2.00RC6 :
   - October, 28th 2005 :
    - Correctly duplicating Alias/SlashCmd for rerolls
    - Improved members list populating by saving know players to Savedfile. Will take some time the first few days to populate, but will be instant after. This method will really decrease channel flood.
    - Added debug messages, to track down Alias/Slash issue
    - Added a new UI windows, to see current banned players from an event (and un-ban them)
    - Added print message in config window
  - 2.00RC5 :
   - October, 27th 2005 :
    - Fixed lua error when using GEM2 in same channel than GEM1
    - Renamed GEMv2 to GuildEventManager2
    - If you were added to an event by the leader (Add External player), you will notice it, and set you as having subscribed (you can now unsubscribe)
   - October, 26th 2005 :
    - Added possibility to talk to the GEM channel (only filter GEM commands)
    - Added Channel Alias, slash command, sticky channel.
    - Added a new TAB : Connected members
    - Fixed lua errors when clicking on headers of listviews
    - Added new key bindings to directly open "Create Event", "Event List", "Members" or "Config"
  - 2.00RC4 :
   - October, 21th 2005 :
    - Fixed few bugs
    - Finished LeaderChange function
    - Added a warning message, if receiving GEM commands, but on a different channel than config.
   - October, 20th 2005 :
    - Fixed lua error when changing channel
    - Possibility to configure (via options) the displayed date format
    - Fixed your commands not being sent when you log in
    - Implemented LeaderChange forward protocol (needs more testing)
  - 2.00RC3 :
   - October, 19th 2005 :
    - Now displaying minimap cursor's current position in config
    - Now saving channel config per character
    - Preliminary code to handle change of leader
    - Fixed few GUI bugs
    - Now correctly checking player's level during subscription and event modification
    - Added new color codes
  - 2.00RC2 :
   - October, 18th 2005 :
    - Fixed 'Minor update' bug, and events not showing (because of this)
    - Created plugin system, for subscribers sorting
    - Created default 'By Subscription Date' plugin
    - Now displaying SortingMode, in the Details tab of an Event
    - Increased Event Comment string to 200 chars
    - Fixed issue with Date being changed when editing an event
  - 2.00RC1 :
   - October, 17th 2005 :
    - Added possibility to subscribe to a 'replacement' queue ('Take me, if you don't find someone else')
    - Finished recoding of low level protocol and ACK system for all commands
    - Added new cool debug frame (only in debug mode) with colors for easier debugging (obiously)
    - Fixed wrong level being used when selecting a reroll in the dropdown list
    - Re-enabled AddExternal command, with new 2.0 parameters
    - Added GUI possibility to send the 'Comment' string when subscribing
   - October, 12th 2005 :
    - Added comment string to subscribe/unsubscribe in the protocol.
    - Subscribe/unsubscribe is now working with v2.0
   - October, 7th 2005 :
    - v2.0 Events are now working. Everybody can see the list of subscribers (name, level and position, but not the guild it takes too much place).
    - Increased 'Place' and 'Comment' fields to 40 and 100 characters.
   - October, 6th 2005 :
    - Changed the protocol. Now splitting long messages into pieces. Allow to support long event comments, list of subscribers, and much more to come.
   - September, 28th 2005 :
    - Start of massive rewrite of the code. Files splitted into many other files. More modular.
  - 1.07 :
   - September, 20th 2005 :
    - Fixed player's level using an ALT not always being initialized to the correct value (once again, issue related to 1.7 changes)
    - Fixed issues with player names using special chars
    - Added many warning message to help track the possible class limit overflow (please inform me, if you get a warning)
    - Fixed auto gem users listing at startup
    - Fixed a bug : if you are titular, but leader comes offline, and you unsub, then re-subscribe, you would be considered unsubscribed for ever :p
  - 1.06 :
   - September, 19th 2005 :
    - Fixed my_names init error (again, thanks to blizz for undocumented changes in vars init in 1.7)
    - Changed auto-delete from 24 to 1 hour (10 hours for the leader only)
    - Fixed a big bug I added when I put the auto-delete function in place : no subscribe/unsubscribe was sent to the leader when he logs in
    - Now retrieve GEM channel list when logging in : Leader should see connected subscribers when logging.
  - 1.05 :
   - September, 14th 2005 :
    - Removed RegisterForSave call. Variables are now correctly saved in the new SavedVariables folder
    - Updated toc (#1700)
    - Fixed vars init when disconnect/reconnect and /reloadui (thanks blizz for the undocumented new behaviour changes)
    - Fixed ugly Frame background
  - 1.04 :
   - September, 13th 2005 :
    - Added ButtonHole support
    - Optimized CPU usage when GEM is not visible
    - Added an overlay 'N' letter over minimap icon, when there is new event(s) available
   - September, 12th 2005 :
    - Fixed guild names with spaces
    - Fixed Expired events check for events I don't own
    - Fixed lua error when receiving an expired update for event I'm the leader of
  - 1.03 :
   - September, 9th 2005 :
    - Added minimap icon
    - Localized all remaning texts
    - Fixed auto-purge of old events
    - Added new color code for Admin list of players (green=player connected)
   - September, 6th 2005 :
    - Fixed a bug in join channel retry
  - 1.02 :
   - September, 2nd 2005 :
    - Now correctly switch players to/from titular/substitute queues, after editing an event
    - Optimized channel flow when leader logs in
    - Added 'Group all titulars' option in Admin tab
   - September, 1st 2005 :
    - Fixed issue (lua errors) due to old format data, still in file after 1.01 upgrade.
  - 1.01 :
   - September, 1st 2005 (1.01):
    - Added possibility to choose one of your reroll, to create/subscribe events
    - Added "/gem toggle", to toggle the GUI from command line
    - Added Load/Save templates, in NewEvent tab
    - Enabled "Edit Event" feature (in EventsList, Admin tab)
    - Default channel is now "GEMChannel<YourGuild>"
    - Many fixes
  - 0.10 :
   - August, 31th 2005 (0.10-2):
    - Added possibility for the leader to add an *external player* (player who does not have GEM installed)
    - Fixed Guild not showing in Admin tab
    - Added automatic purge of old events
    - Fixed a bug in calendar, if opening it on the 31th day of a month
    - Added GEM new version detection (major version only - protocol changes)
    - Changed protocol - Not compatible with previous versions
   - August, 30th 2005 (0.10-1):
    - Fixed calendar localization
    - Removed Chronos/Sea dependency
    - Fixed GUI refreshment, and improvments : now using colors instead of '*' (red=banned, yellow='*', blue='**', green='***'), and added colored Leader in events list (green = logged)
  - 0.9 :
   - August, 29th 2005 (0.9-1):
    - Added 'Day of week' in Events date
    - Added '*' in the 'Subscribers' column. One '*' means you have sent subscription for the event. Two '*' means you have subscribed (received by leader), but you are in Substitute queue. Three '*' means you have subscribed, and you are in Titular queue.
    - Fixed bugs in 'kick/ban' protocol
    - Fixed substitute count not showing in Limits tab
    - You can only subscribe to an event not yet subscribe (same for unsubscribe)
    - Other few fixes (all your datas will be reset, sorry about that, but I had to change few structs)
  - 0.8 :
   - August, 26th 2005 (0.8-9):
    - Everybody can see current titulars/substitutes for each class
   - August, 25th 2005 (0.8-8):
    - Finished admin/global GUI tabs.
   - August, 22th 2005 (0.8-7):
    - Many fixes. Added pretty much all the GUI.
   - August, 4th 2005 (0.8-6):
    - Fixed channel init
    - GUI CB function called when creating/updating/closing locally
   - July, 28th 2005 (0.8-5):
    - Finished calendar, with time/date
   - July, 27th 2005 (0.8-4):
    - Now encoding Date/Hour as unique integer (#sec since 1970)
   - July, 27th 2005 (0.8-3):
    - Added calendar to choose event date
    - Realm initialization fix
   - July, 26th 2005 (0.8-2):
    - Added per-realm events
    - Added players Guild
    - Added Callback function for GUI
   - July, 20th 2005 (0.8-1):
    - Added a special tag (<GEMversion>) to messages sent in GEMChannel
    - Sending broadcast messages as blocs (every seconde)
   - July, 19th 2005 :
    - Added support for kick/ban players from an event
   - July, 15th 2005 :
    - Added a list of all my rerolls (needed or ACKs might never go to State2).
    - Added current_count to events (so everybody can see current subscriber count).
    - Added GEM_AddExternalSubscriber and GEM_RemoveExternalSubscriber functions (leader only).
  - 0.7 : July, 11th 2005 : Few fixes
  - 0.6 : July, 9th 2005 : Fixed bugs :p
  - 0.5 : July, 7th 2005 : Added substitute list sorting.
  - 0.4 : July, 6th 2005 : Added titular and substitute list. Fixed bugs :p
  - 0.3 : July, 1st 2005 : Added unsubscribe command. Fixed bugs :p
  - 0.1 : June, 28th 2005 : Module created.


  ---
  Description :
  ----------------
  This AddOn allows you to create/schedule/manage future raid instance directly in-game. Players can register (join) and reserve a room for your instance, or cancel subscription.
  You can setup a maximum players for your event, as well as the min/max per class.
  When a player wants to join and there is no room left for his class, he is put in a *substitute* queue, waiting for someone to cancel his subscription.
  
  The leader of an event does not have to be logged in for a player to subscribe.
  
  This addon has been designed to help guilds to schedule events, and its member to say *I'll be there*, and count the number of players that are ok for an instance.
  It does work for multiple guilds (kind of Alliance of guilds), if you want, or even with your friend list.
  
  All dates are stored in universal time, and displayed in local time, so if someone creates an event in a different timezone than yours, you will see the correct time on your side.
  
  
  ---
  Installation :
  ---------------
  
  1. Extract .zip file to WorldOfWarcraft\Interface\AddOns\
  2. load up WoW check the Addon is enabled ("/gem help" should print infos)
  3. Bind a key to GuildEventManager or type "/gem toggle"
  4. in the options TAB set the channel to whichever you are going to use
  
  
  ---
  Notes :
  --------
  
  COLOR CODE :
   - Events List in Events Tab, Where column :
     - White = Old event (already displayed)
     - Green = New event (never seen)
   - Events List in Events Tab, Leader column :
     - White = Leader not connected
     - Green = Leader connected
   - Events List in Events Tab, Subscribers column :
     - White = Not subscribed
     - Purple = Level of your selected character does not match event's level range
     - DarkGrey = Subscription sent, but not ACKed yet
     - Bleu = Subscription ACKed but you are in Substitute queue
     - Green = Subscription ACKed and you are in Titular list
     - Yellow = Subscription ACKed and you are in Replacement list
     - DarkRed = You have been kicked from event (and thus unsubscribed). You can re-subscribe
     - LightRed = You have been banned from event (and thus unsubscribed). You cannot re-subscribe until you are unbanned
   - Admin List in Events Tab, Name column :
     - White = Player not connected (or external)
     - Blue = Player connected but not grouped
     - Green = Player connected and grouped
   - Members list, Guild column :
     - Green = Guild leader
     - Blue = Guild officer
     - White = Guild member
  

  ---
  FAQ :
  --------
  Q : I don't see events of other people, and others don't see mine
  A : Are you sure you are on the same channel (check GEM options) ? Are you sure you don't have joined more than 9 channels (there is a limit of 9 or 10 channels you can join) ? Are you sure your PC's clock is correctly set ?
      If you still don't see events, try "/gem debug 1", it will show a new TAB, look at the debug log (screenshot it) for warnings or event related messages, then contact me.
  
  Q : I see garbage on my channels, like "<GEM-1>01..."
  A : Check if the channel you see garbage is the same than the one in your GEM config. Maybe you have changed the channel with a character, and changed reroll. Leave the garbaged one with a /leave ChanNum. In v2.0, channel will be saved per char, so you will not have this problem anymore.
  
  Q : I just subscribed to an event, but I don't appear in the list, nor the titulars count has changed.
  A : If the leader of the event is not logged, all commands (subscribe, unsubscribe, ...) are stored and broadcasted to every person in the channel (and each time someone logs in). In order to see your subscription in the list (and titulars count increased/decreased), you must wait until the leader logs. When he does, all commands are flushed and he processes them, in the order they were submitted.
      Look at the color codes above, they help you know in which state you are.
  
  Q : All thoses stored commands don't flood the channel when someone (or the leader) logs in ?
  A : No, there is an algorithm that makes people to sent commands at different time when someone joins, and if a known command has just been sent, the sent from your side is canceled. There is also a  maximum of commands that can be sent per second, so you are not (less) flooded.

  Q : I don't like the subscribers sorting modes available. I want something else, custom.
  A : Well, that's where the Sorting plugin system comes in ! Look at the "GEM_sort_stamp.lua" file, there is all you need to make your own plugin (there is no need for the plugin to be installed on each player's computer, only on the leader's one). Simply make a new addon with a .toc file, that depends on GuildEventManager, and you're done. The plugin will be loaded by GEM, and you'll be able to choose your custom sorting in GEM's "Create new Event" tab.
  
  Q : I have a lua error, but I cannot tell you the file/line it occured
  A : Please install (even temporarily) ImprovedErrorFrame (http://www.curse-gaming.com/mod.php?addid=170), and you'll be able to see the full error text

  Q : When I link an item to the GEM channel, it displays the name only.
  A : For links to be sent, you must use the SlashCmd specified in GEM config. If you speak using /# (# being GEM's channel number), it will not work.
  
  Q : I don't see anybody in the Members list, and the list populates very slowly. Also, I always see "N/A" for people's location.
  A : This is to greatly reduce traffic in the channel. Each player sends his personal informations ONLY when he changes of zone, NOT when someone logs in (otherwise every single player will have to send his current info upon each login, which causes too much traffic).
      Because of this, the first time you come to a channel, we don't see anybody, you must wait for each player to move to another zone. When this happens, the player is saved and stored in your variables, so the next time, only it's current location will show as 'N/A' until he moves.
  
  Q : I'm using SlashCmd and alias, and when I try to send a message, I don't see anything in my chatframe, nor I see messages from others.
  A : Some addons are not hooking chatframe like they should.
      - If you have GuildAds : Get the latest version, it has been fixed
      - If you have flagRSP : Get the latest version, it has been fixed
      - If you have Guilded : Why do you need this one anymore ? oO
      
  Q : I don't like the way Dates are displayed. How can I change that ?
  A : Change the option "Displayed dates format" ingame, in the GEM Configuration tab with the value you want.
      You can find help on the parameters here : http://www.opengroup.org/onlinepubs/007908799/xsh/strftime.html

  Q : I don't understand the 'time offset' option
  A : When someone creates an event, the time/date for the event is (by default, if you don't change the offset in GEM config) relative to it's computer's clock (which uses international time).
      Example :
       My computer's clock is set at GMT+1, I play on a server where time is set to GMT.
       I create an event for tonight 8pm, GEM will flag (create) the event for 8pm GMT+1 (and store it using universal time value), not 8pm GMT (so not the server time).
       BUT the date will be displayed for eveybody, using their local time. For someone playing on a computer with clock set at GMT+2, the event will show for him at 9pm.
       The offset value in GEM config, is for people who want events to be shown using server time (or any other time offset), not local time.
       They can set an offset from local time to match server time. If you don't set anything, it will display/create events based on your computer time (local).

  Q : When are events removed from the list ?
  A : Events are auto removed (not closed, removed completly from GEM) 1 hour after event's date for non-leader players, and 10 hours after event's date for leader.
      Using the previous example, the event will disapear for eveybody at 9pm GMT+1 (so for the guy playing at GMT+2 time, it will disapear when his computer's clock will reachs 10pm).



--------------- Plugin API  ---------------


 function GEM_COM_API_AddDispatchFunction :
  Adds a command dispatch callback function
   opcode : String   -- Unique Opcode you want to use (must represent an Int)
   func   : Function -- Function to be called when you receive this Opcode

  Prototype for command related to an event = function CallbackFunc(channel,from,stamp,ev_id,params) :
   - channel = Channel event is linked to
   - from = Sender of the message
   - stamp = Stamp the command was issued by the author of the cmd (not necessary same person than 'from')
   - ev_id = EventId the command is related to
   - Common Cmd 'params' =
     Params[1] = leader (STRING) -- Leader of the event
     Params[2] = ev_date (INT) -- Date of the event
     Params[3] = ack (STRING) -- 1 or 0, if the packet is an ack to the command or not
     Params[4] = pl_dest (STRING) -- Name of player the command is destinated to
     Params[5] = pl_src (STRING) -- Name of player the command is originating from
     Followed by specific Cmd 'params' you pass to the Send function

  Prototype for global command = function CallbackFunc(channel,from,stamp,ev_id,params) :
   - Same as previously, but ev_id = GEM_GLOBAL_CMD, and no 'common params', only 'specific params'
   
  Global commands are volatile (not stored nor forwarded by other players), while event related commands are stored and broadcasted when a new player arrives.
   
  Returns true on success, false if opcode is already in use

function GEM_COM_API_AddDispatchFunction(opcode,func);

 function GEM_COM_API_SendVolatileCommand :
  Sends a volatile command (not stored nor forwarded by other players)
   channel : String -- Channel to send message to
   opcode  : String -- Unique Opcode you want to use (must represent an Int)
   params  : Table  -- Array of your params (must be Int index based, use table.insert())
  Returns true on success.

function GEM_COM_API_SendVolatileCommand(channel,opcode,params);


 function GEM_COM_API_SendCommand :
  Sends an event related command (stored and broadcasted when a new player arrives)
   channel : String -- Channel to send message to
   opcode  : String -- Unique Opcode you want to use (must represent an Int)
   ev_id   : String -- EventId command is related to
   pl_dest : String -- Recipient player the message is addressed to
   pl_src  : String -- Originator player (often the event.leader)
   params  : Table  -- Array of your params (must be Int index based, use table.insert())
  Returns true on success, false if event is unknown.

function GEM_COM_API_SendCommand(channel,opcode,ev_id,pl_dest,pl_src,params);
