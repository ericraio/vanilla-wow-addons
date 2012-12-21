BuyEmAll - v1.12

By Cogwheel

BuyEmAll enhances the shift-click interface at vendors.

---------- FEATURES ----------

** Type in the amount you want to buy **

This is actually part of the default UI. Enough people don't know about it due to the fact that there is no cursor and clicking in the box gives no feedback, that I decided to list it here.

** Buy more than the stack size of the item at once **

For instance, if you want to buy 80 pieces of silk thread, you currently have to shift-click the thread, enter 20, hit ok, shift-click the thread, enter 20, hit ok, shift-click the thread, enter 20, hit ok, shift-click the thread, enter 20, and hit ok.

With BuyEmAll, you shift-click the thread, enter 80, hit OK, and confirm that you want to buy more than a stack. This confirmation appears so you don't accidentally buy 1000 of something when you meant to buy 100.

** Shift-click items that come in preset stacks **

The default UI doesn't allow you to shift-click items like Refreshing Spring Water which come in preset stacks. If you want to buy 50 of them, you have to right-click the item 10 times. BuyEmAll allows you to shift-click the item and enter the amount you want. See below for more information on preset stacks.

** Know how much you will be spending **

Below the box where you enter the amount is a money display. This updates as you change the amount you are going to buy, showing you exactly how much your purchase will cost.

** Quickly buy a stack or the maximum amount you can buy **

The BuyEmAll window has Stack and Max buttons which allow you to buy a full stack or as much as you can afford/fit. Hovering over the buttons shows a tooltip with the number of items you will be buying and updates the cost display so you will know how much you're spending. See NOTES below for information on the maximum you can buy.

** Quickly refill your ammo pouch **

If you are buying ammo and have free spots in your ammo pouch/quiver, the amount that appears when you first shift-click the item will be however many stacks it takes to refill your bag. Just hit enter, and you bag will be filled.


---------- NOTES ----------

The amount you can enter is limited by:

- The amount of free space in your bags. Partial stacks are included in this calculation, as are specialty bags (e.g. free slots in enchanting bags will be only be counted towards your free space if you are buying an essence, dust, or shard)

- The amount you can afford.

- The number available from the vendor (for limited stock items).

A breakdown of these numbers is included in the tooltip when you mouse over the Max button.

If you can only buy one item for any of these reasons, shift-click behaves just like a left click, picking up one of the item onto your cursor. If you can't buy any, then shift-click does nothing.

When you are choosing the amount for items that come prestacked, the amount you enter is the total amount you want to buy, not the number of stacks you want to buy. If you use the arrow buttons, this number will increase or decrease to multiples of the preset stack size.

The confirmation window will only show up if you buy more than the maximum stack size in your inventory, not the stack size that you can buy at once.

Example: [Refreshing Spring Water] - Stack Size: 20, Purchase Unit: 5

If you enter 18, it will automatically buy 20 with no confirmation. If you enter 23, a confirmation will pop up asking, "Are you sure you want to buy 25 of this item?"


---------- FEATURES/BUGS ----------

There are no known bugs at this time, though any help with localization would be appreciated.

Please visit Cogwheel's Workshop at http://wowinterface.com/portal.php?&uid=17646 if you have any suggestions or bug reports, and to see what is in store for the future.


---------- CHANGES ----------

v1.12

- Stack and Max buttons display a confirmation regardless of purchase size to alleviate accidental clicks.
- The BuyEmAll frame will not hide until you accept the confirmation or if there is no confirmation.
- Fixed a bug where you could attempt to buy an item a vendor no longer has.
- German translation courtesy of JokerGermany.
- Changed the text on Max and Stack tooltips.
- Corrected a few typos in this readme.

v1.11.1

- Remembered to turn off debugging mode. :P
- Changed the way the window is rendered such that I don't have to include a texture file.

v1.11

- Changed cost display for better visual integration with WoW.
- Removed display of maximum purchase from the frame.
- Added "Max" button.
- Max and Stack buttons update the cost display when you mouse over them.
- Added tooltips to the Stack and Max buttons.
- The Stack button is disabled if you cannot buy a stack.

v1.10

- Added display of total purchase cost.
- Added "Stack" button.
- The confirmation box no longer appears when filling an ammo pouch.
- Fixed bug where default stack for ammo could be more than you could afford. 
- Added a line break in the confirmation window to make it easier to read.

v1.9

- Free space calculation now takes into account special bag types.
- Added quick-fill feature for ammo pouches/quivers.

v1.8

- The Stack Split frame now shows you the maximum amount you will be able to purchase.
- For preset stack items, the left and right arrows increase or decrease to multiples of the preset - stack size.

v1.5

- Added support for items that come in preset stacks and items that don't stack at all.
- Limited the maximum you can attempt to buy as described above.

v1.0

- Initial Release
