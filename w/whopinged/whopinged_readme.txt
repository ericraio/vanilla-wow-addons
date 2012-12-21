WhoPinged version 0.3 by usea
a very minimal and simple addon to help identify players who ping the minimap

-features-
multiple methods to display the person who has pinged, or is pinging the minimap.
the ability to ignore certain players' pings. for those times the raid leaders are afk or apathetic


/wp - toggles "ping identifying". while enabled, whenever a new player pings the minimap you will see their name in the chat frame. this can potentially cause a large amount of spam so I recommend you only enable this for short periods. note: if a player pings the map twice in a row, no message is shown. assume unreported pings came from the player last reported to have pinged.
/wp last - prints to your chat frame the last two players to ping the minimap. keep in mind that these values don't expire, so the second-to-last player who pinged the map may have done so many hours in the past.
/wp ignore <player> - adds a player to your minimap ping ignore list. you will not receive their minimap pings until you unignore them.
/wp unignore <player> - removes a player from your minimap ping ignore list.
/wp list - lists the players whose minimap pings you're currently ignoring.
/wp zone - toggles display of the last person to ping the minimap in the zone field located above the minimap. enabled by default.
/wp help - shows a list of slash commands


0.3
- major rewrite.
- added slash command handler (type /wp help)
- added pinger's name in the zone field above the minimap (optionally, enabled by default)
- added the ability to ignore individual players' pings

0.2
- first release!

0.1
- pre-release