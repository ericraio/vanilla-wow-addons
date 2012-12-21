
require('luaunit')
require('..\\Sea.lua')
require('..\\Sea.wow.tooltip.lua')

TestSeaWowTooltip = {} --class

	function TestSeaWowTooltip:setUp()
		-- do nothing
	end

	function TestSeaWowTooltip:tearDown()
		-- do nothing
	end

	function TestSeaWowTooltip:test_clear()
		assertEquals("fix me", "please");
	end
	
	function TestSeaWowTooltip:test_scan()
		assertEquals("fix me", "please");
	end
	
	function TestSeaWowTooltip:test_compareTooltipScan()
		assertEquals("fix me", "please");
	end
	
	function TestSeaWowTooltip:test_smartSetOwner()
		assertEquals("fix me", "please");
	end
	
	function TestSeaWowTooltip:test_protectTooltipMoney()
		assertEquals(Sea.wow.tooltip.saved_GameTooltip_ClearMoney, nil);
		Sea.wow.item.protectTooltipMoney();
		assertNotEquals(Sea.wow.tooltip.saved_GameTooltip_ClearMoney, nil);
		Sea.wow.item.unprotectTooltipMoney();
		assertEquals(Sea.wow.tooltip.saved_GameTooltip_ClearMoney, nil);
	end
	
-- class TestSeaWowTooltip

luaUnit:run()
