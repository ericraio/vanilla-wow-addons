
	ClosetGnome
A gnome helper that keeps your wardrobe organized. At least tries to.
rabbit.magtheridon@gmail.com

This software is BETA quality.


	Description

ClosetGnome was written because I was tired of AceWardrobe and its "I will never
be Ace2" status. It is, as you might have guessed, a wardrobe addon.

ClosetGnome tries to be small and efficient and does not do any processing
outside of when you actually add/delete or switch sets. There are some tradeoffs
for this, like you won't have advanced features like what sets you're wearing
currently in a list and stuff, it just shows you the set you last equipped in
the tooltip.


	Sets

There's no way to modify a set. It's as simple as: 1. equip set, 2. add a new
set with the same name, and it will be overwrited.

There are no autosets in the ClosetGnome addon, but there's nothing stopping you
from making one. ClosetGnome_BigWigs can be used to equip sets per boss.

When you add a set, the character frame will pop up and all the slots will be
green. Clicking a slot will make it red, which means that slot will be *ignored*
for that set. If you want a slot to be empty, make sure it's empty when creating
the set and keep it enabled (green). Control+Clicking a slot will snatch the
icon of the current item there and use as the set icon, which makes the tooltip
list a bit nicer.

Equipping a set in combat is obviously not possible, so the set will be queued
automatically and switched to when you get out of combat. If the set contains
any weapons, the weapons will be switched immediately if that option is on.


	Macro

You can easily equip a ClosetGnome set in a macro like so:
/script ClosetGnome:WearSet(MySetName)


	Etc

ClosetGnome fires some Ace2 events when it creates, deletes or equips sets, if
that's interesting to you.

 - Rabbit

