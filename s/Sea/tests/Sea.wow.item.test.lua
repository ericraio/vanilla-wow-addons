
require('luaunit')
require('..\\Sea.lua')
require('..\\Sea.wow.item.lua')

TestSeaWowItem = {} --class

	function TestSeaWowItem:setUp()
		-- do nothing
	end

	function TestSeaWowItem:tearDown()
		-- do nothing
	end

	function TestSeaWowItem:test_getInventoryItemName()
		assertEquals("fix me", "please");
	end
	
	function TestSeaWowItem:test_classifyInventoryItem()
		assertEquals("fix me", "please");
	end
	
	function TestSeaWowItem:test_getInventoryItemInfoStrings()
		assertEquals("fix me", "please");
	end
	
-- class TestSeaWowItem

luaUnit:run()
