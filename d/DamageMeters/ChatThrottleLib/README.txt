
== ChatThrottleLib Intro ==

ChatThrottleLib is a small, embeddable library by Mikk of Bloodhoof-EU that 
keeps outbound chat and addon communication from exceeding the output rate 
limit in WoW that otherwise causes players to disconnect from the server. 

It also has a number of features that will help you make your addon 
communication run smoother!


Benefits of using ChatThrottleLib:

 * Players do not get disconnected when your addon sends too much data
 
 * You can easily prioritize your traffic in three priorities
 
 * Communication to different peers is handled as individual flows. A long data
   stream to "Alice" doesn't interrupt short bursts of traffic to "Bob".
 
 * All AddOns using ChatThrottleLib use the same queues, so multiple addons 
   can't cause an overload. Priorities ensure that real-time traffic is still
   real-time. 


ChatThrottleLib does:

 * Round-robin traffic shaping of different communication paths
 * Prioritization of messages according to three predefined priorities: 
   "BULK", "NORMAL" and "ALERT"
 * NO queueing of traffic needlessly. No lag introduced until it needs to be.
 * Adaptive throttling according to traffic bypassing the library
 * Adaptive throttling according to frame rate


== APIs ==

 * ChatThrottleLib:SendChatMessage("prio", "prefix",   "text", "chattype", "language", "destination");

 * ChatThrottleLib:SendAddonMessage("prio",    "prefix", "text", "chattype");
 
"prio" is one of "BULK", "NORMAL" and "ALERT".
"prefix" in :SendChatMessage() is only used for traffic shaping purposes



== How to embed ChatThrottleLib ==

Method 1:
 * Copy ChatThrottleLib.lua into your addon directory 
 * Add "ChatThrottleLib.lua" to your .toc file 
 
Method 2:
 * Copy the entire ChatThrottleLib folder to your addon
 * Add "ChatThrottleLib/ChatThrottleLib.xml" to your .toc file

You're done, and can now use ChatThrottleLib:SendChatMessage and ChatThrottleLib:SendAddonMessage to send your messages!

The library has built-in checks for if it has already been loaded, and avoids loading again if so.
If your addon has a newer version of the library than one that has already been loaded, it will replace the old version. 


== More Information ==

 * Download: http://www.wowinterface.com/downloads/info5207-ChatThrottleLib.html

 * Docs: http://www.wowwiki.com/ChatThrottleLib
 
 * SVN: http://svn.wowace.com/root/trunk/ChatThrottleLib
 

[Documentation for ChatThrottleLib v11, 2006-08-25]
