Updating the readme

v .94.4 - [4/30/2006]



Fixed the various bugs mentioned in my thread at wowace.com (I think)

Auction
	Reimplemented BellCurves to limit outliers.  

Bank/Inv 
	Optimized data storage to only run when needed.

LinkView 
	Fixed double search bug
	Switched AdvSearch to being the default search method
	The Base Item Search now reads Search Suffixes.
  

Broker 
	Fixed disable bug.
	Auction color works again.
	Changed SmartSplit to Alt-RightClick,  I think thats untaken.

Common 
	Enhanced a few error messages.

Tooltip 
	Now setsowner on load.

ChatLink 
	Fixed and enhanced a few small features and bugs
	Added the chatlink module.  
	Allows you to type  [Lightforge Bracers] in chat and it will turn it into the appropriate link.
	Will print a list of up to ten other options if an exact match is not found.  
	Does so without increasing memory use, and is fast, around fifty milliseconds.

Linkview
	Working on fixing some of the search issues, not quite finished yet.



v .94.3 - [3/27/2006]

Tooltip
- Added a API to unregister a function.
Broker
- Control Right Click when at the auction house now does a search for that item.
- Shift Right Click will split one off of a stack and then place it in the first open slot in your bag
Common
- Added better error checking in several spots.
ItemInfo
- Will now unregister with Tooltip.
- Hopefully fixed some of the bugs with typing /kci iteminfo
Optimizer
- Fixed issue related to per character profiling.
SellValue
- Will now unregister with Tooltip.
Auction
- Will now unregister with Tooltip.