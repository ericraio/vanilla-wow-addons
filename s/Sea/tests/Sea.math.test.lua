
require('luaunit')
require('..\\Sea.lua')
require('..\\Sea.math.lua')

TestSeaMath = {} --class

	function TestSeaMath:setUp()
		-- do nothing
	end

	function TestSeaMath:tearDown()
		-- do nothing
	end

	function TestSeaMath:test_rgbaFromHex()
		red, green, blue, alpha = Sea.math.rgbaFromHex("ffffffff");
		assertEquals(1.0, red);
		assertEquals(1.0, green);
		assertEquals(1.0, blue);
		assertEquals(1.0, alpha);
	end
	
	function TestSeaMath:test_intFromHex()
		val = Sea.math.intFromHex("ff");
		assertEquals(255, val);
	end
	
	function TestSeaMath:test_hexFromInt()
		val = Sea.math.hexFromInt(255, 2);
		assertEquals("ff", val );
	end
	
	function TestSeaMath:test_convertBase()
		base = Sea.math.convertBase("255", 10, 16);
		assertEquals("ff", base);
		base = Sea.math.convertBase("ff", 16, 10);
		assertEquals("255", base);
	end

	function TestSeaMath:test_round()
		rounded = Sea.math.round(1.1);
		assertEquals(1, rounded);
		rounded = Sea.math.round(1.9);
		assertEquals(2, rounded);
		rounded = Sea.math.round(1.51);
		assertEquals(2, rounded);
		rounded = Sea.math.round(1.49999);
		assertEquals(1, rounded);
	end
-- class TestSeaMath

luaUnit:run()
