
require('luaunit')
require('..\\Sea.lua')
require('..\\Sea.lang.lua')

TestSeaLang = {} --class

	function TestSeaLang:setUp()
		-- do nothing
	end

	function TestSeaLang:tearDown()
		-- do nothing
	end

	function TestSeaLang:test_makeLocalizedString()
		assertEquals("fix me", "please");
	end
	
	function TestSeaLang:test_parseLocalizedString()
		assertEquals("fix me", "please");
	end
	

-- class TestSeaLang

luaUnit:run()
