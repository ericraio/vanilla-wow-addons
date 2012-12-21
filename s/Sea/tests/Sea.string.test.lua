
require('luaunit')
require('..\\Sea.lua')
require('..\\Sea.io.lua')
require('..\\Sea.util.lua')
require('..\\Sea.string.lua')

TestSeaString = {} --class

	function TestSeaString:setUp()
		-- do nothing
	end

	function TestSeaString:tearDown()
		-- do nothing
	end

	function TestSeaString:test_byte()
		local b = Sea.string.byte("b");
		assertEquals("<62>", b);
	end
	
	function TestSeaString:test_toInt()
		local inta = Sea.string.toInt("11");
		assertEquals(11, inta);
	end
	
	function TestSeaString:test_fromTime()
		local time = Sea.string.fromTime(1344321.12,2);
		assertEquals("373:25:21.12", time);
	end

	function TestSeaString:test_capitalizeWords()
		local phrase = Sea.string.capitalizeWords("hello world you great world.");
		assertEquals("Hello World You Great World.", phrase);
	end

	function TestSeaString:test_ObjectToString()
		local str = Sea.string.objectToString({a=1,b=2,c="3"});
		print(str);
		assertEquals("<table: a<number:1> c<string:3> b<number:2>>", str);
	end

	function TestSeaString:test_StringToObject()
		local obj = 3;
		local str = Sea.string.objectToString(obj);
		local obj2 = Sea.string.stringToObject(str);

		print(str);
		assertEquals(obj, obj2);
		
		obj = "a";
		str = Sea.string.objectToString(obj);
		obj2 = Sea.string.stringToObject(str);

		print(str);
		assertEquals(obj, obj2);

		obj = {2,4,"A",asdf={44}};
		str = Sea.string.objectToString(obj);
		obj2 = Sea.string.stringToObject(str);

		print(str);
		for k,v in obj do
			print( "k: ", k, " v: ", v); 
		end
		for k,v in obj2 do
			print( "k: ", k, " v: ", v); 
		end
		for k,v in obj do
			assertEquals(obj[k], obj2[k]);
		end
	end

-- class TestSeaString

luaUnit:run()
