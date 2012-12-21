	Titan Panel [Guild]: A simple guild list for the Titan Panel AddOn.
		copyright 2005 by chicogrande (jluzier@gmail.com)
		
	- Lists online guild members in a tooltip, green rank text indicating an officer
	- Menu shows names of online members, with click to /whisper functionality. Green text = officer
	- Menu has options to /guild chat and /officer chat
	- Menu has option to toggle Show offline members, which changes this setting in your Social frame, Guild tab
	- Advanced menus to /w, /invite, /friend or /who guild members
	- Shows default messages if the player is not a member of a guild
	- Updates the guild listing every 5 minutes to accomodate the GuildRoster() delay. The update only takes place if
	  the player is 'idle' and not accessing conflicting UI frames or Titan elements
	- Tooltip and right-click menu content is sortable using the Sort menu option, works like the guild frame
	- Colors rank names (Advanced) or player names (Simple) based on rank index
	- To save space, player can turn off menu options
	- Filtering on a level range and zone, as it relates to the player
	- Filtering on a single class in the player's faction
	- Paging of simple and advanced right-click menu contents to deal with large-guild issues
	
	Changelog:
	
	.02
	- changed chat options to be /g = guild chat, and /o = officer chat for locale reasons
	- implemented GuildRoster() to update the listing on button load and when hovering over button
	- added display of guild name player belongs to in the tooltip title area
	- added advanced secondary menus to send whisper or group invites
	
	.03
	- corrected guild_zone nil (typically on first game load) concat issue in tooltip
	- implemented FriendsFrame_onShow, onHide() hooked functions to prevent open/close sound
	- refreshing guild roster every 15 seconds to accomodate the GuildRoster() delay
	
	.031
	- corrected issue where AuctionFrame would close when the guild roster was being updated
	- having issues calling TitanPanelGuildButton_GetGuildRoster on game load during a GUILD_ROSTER_UPDATE event; 
	  removing call for now
	- added additional frames to check for IsVisible() before running the GuildRoster() call
	
	.032
	- added additional frames to check for IsVisible() before running the GuildRoster() call
	- added left-click to open the Friends fame, guild tab
	
	.04
	- added rank-based submenus to create a 3 lvl messaging environment.
	- user can select to use advanced, rank-sorted or simple mode for right-click menu

	.041
	- fixed the richRankText being nil issue, initializing
	- guild_rankIndex may be zero based, changed logic to detect when creating richRankText string		

	1.0
	- solid version release, 1.0
	- formatted tooltip with tab between name and other data
	- added some German translation strings
	- added additional frames to the "do not update" list
	- added a sorting function which sorts the simple and advanced menu items and tooltip content
	
	1.1
	- updated .toc to 1500
	- added /who and add to friends list functions in advanced submenus
	- cleaned up function names
	- properly detecting the Guild Master and displaying their rank in tooltip
	- coloring used in submenus for rank ( green = officer level, red = guild master)
	
	1.2
	- removed coloration for officers/leader; there is no clear indicator from guild to guild on what the officer rank is
	- French localization now available

	1.3
	- added coloration based on rank index using color gradient
	- checking CanViewOfficerNote() to determine if "/o" chat is available
	- added option to hide right-click menu options to recover space in the list

	1.4
	- Fixed German and French localization, please test and let me know if errors remain
	- localized the sort option strings
	
	1.5
	- Added TalentTrainerFrame and BattlefieldFrame to the list of frames to check for prior to running a GuildRoster() update
	- Fixed Show offline French string
	
	1.6
	- Tooltip contents are now configurable. Can show any combo of Name, Zone, Note, Level, Class, and Rank
	
	1.7
	- Some localization fixes
	- Filtering on player's level range (+5/-5 of player's level) and player's zone
	- Filtering on a single class in the player's faction	

	1.8
	- updated interface to version 1600
	- regenerating the advanced menus on player login
	- added interaction menus to simple player list
	- bug fix for advanced menus not populating on initial load
	- removed show offline option due to issues with 1.6
	
	2.0
	- Paging of simple and advanced right-click menu contents to deal with large-guild issues
	- No longer showing non-online members in the ranked advanced menus (bug)
	- Added missing class to Horde filters (Druid)
	- Tooltip warning message displayed if total contents exceeds 26 items
	
	2.1
	- Filters and paging had issues, implemented a flat table to manage the simplified right-click listing (bugfix)
	
	2.2
	- Missing variable for showing offline members in button text (bugfix)
	
	2.3
	- Tooltip showing incorrect contents when "Show offline" checked in Guild pane (bugfix)
	- Persisting the user's sort selection in SavedVariables
	
	2.31
	- Updated to interface version 1700 (9/13/2005 release)
	
	2.4
	- Added menu option to disable auto-roster updates
	- Increased update time to 5 min; GuildRoster() call always returns ALL guild members regardless of show offline setting
	
	2.5
	- Updated for version 1800 (Dsanai)
	- Fixed frame detection issues with 1800 (Dsanai)
	- Added coloration to the tooltip information (Dsanai)
	
	2.6
	- Updated for version 10900
	- GetGuildRosterInfo() api update (KarrionTerenas)
	
	2.7
	- Re-merged code from KarrionTerenas to correct init issues
	
	2.8
	- Upated .toc to 11000
	- NEW: Configurable update times (1 min, 3 min, 5 min, Disable)
	- NEW: Color coded class names in tooltip based on raid class colors
	
	2.81
	- Removed dependency on modern version of Titan Panel for class coloration functionality in tooltip.
	
	2.9
	- Completely revamped the GuildRoster() call and event trapping. Should correct guild tab issues.
	
	3.0
	- Added functionality to disable/enable update of the guild roster on mouse-over
	- Changed label text to display the name of the player's guild in button text
	
	3.1
	- Coloring player names based on raid colors
	- Reordered tooltip display to show level first

	3.2
	- Upated toc (11100)

	3.3
	- Minor fix: Added IsInGuild() checks to GuildRoster() calls as needed to prevent non-guilded players from getting the 'Not in guild' message.	
	
	3.4
	- Updated toc to 11200
	
	3.41
	- Added status for <AFK> and <DND> display to tooltip
						