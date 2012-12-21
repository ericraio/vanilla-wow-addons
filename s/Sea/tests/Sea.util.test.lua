
require('luaunit')
require('..\\Sea.lua')
require('..\\Sea.util.lua')

TestSeaUtil = {} --class

	function TestSeaUtil:setUp()
		-- do nothing
	end

	function TestSeaUtil:tearDown()
		-- do nothing
	end

	function TestSeaUtil:test_hook()
		assertEquals("fix me", "please");
	end
	
	function TestSeaUtil:test_unhook()
		assertEquals("fix me", "please");
	end
	
	function TestSeaUtil:test_makeHyperlink()
		assertEquals("fix me", "please");
	end
	
	function TestSeaUtil:test_join()
		assertEquals("fix me", "please");
	end
	
	function TestSeaUtil:test_split()
		assertEquals("fix me", "please");
	end

	function TestSeaUtil:test_fixnil()
		assertEquals("fix me", "please");
	end
	
	function TestSeaUtil:test_fixnilEmptyString()
		assertEquals("fix me", "please");
	end

	function TestSeaUtil:test_fixnilZero()
		assertEquals("fix me", "please");
	end
	
	function TestSeaUtil:test_fixnilSub()
		assertEquals("fix me", "please");
	end

-- class TestSeaUtil

luaUnit:run()
