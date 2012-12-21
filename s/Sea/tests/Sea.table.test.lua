
require('luaunit')
require('WoW.test')
require('..\\Sea.lua')
require('..\\Sea.io.lua')
require('..\\Sea.table.lua')
require('..\\Sea.util.lua')

TestSeaTable = {} --class

	function TestSeaTable:setUp()
		-- do nothing
	end

	function TestSeaTable:tearDown()
		-- do nothing
	end

	function TestSeaTable:test_getValueIndex()
		assertEquals("fix me", "please");
	end
	
	function TestSeaTable:test_isInTable()
		assertEquals("fix me", "please");
	end
	
	function TestSeaTable:test_isStringInTableValue()
		assertEquals("fix me", "please");
	end

	function TestSeaTable:test_push()
		assertEquals("fix me", "please");
	end

	function TestSeaTable:test_pop()
		assertEquals("fix me", "please");
	end
	
	function TestSeaTable:test_getKeyList()
		local expectedResult = {"hello", "my", "name", "is", "karl"};
		local actualResult = Sea.table.getKeyList( { hello = "", my = "", name = "", is = "", karl = "", } );
		local tempTable = expectedResult;
		
		for k,v in pairs(actualResult) do
			tempTable[v] = nil;
		end
		assertEquals( table.getn(tempTable), 0 );
		
		tempTable = actualResult;
		for k,v in pairs(expectedResult) do
			tempTable[v] = nil;
		end
		assertEquals( table.getn(tempTable), 0 );
		
		assertEquals(nil, Sea.table.getKeyList( { } ) );
	end

	function TestSeaTable:test_isEquivalent()
		local a = {a=1,b=2,c=3};	
		local b = {a=1,c=3,b=2};

		assertEquals(true, Sea.table.isEquivalent(a,b) );
		
		local c = {a=1,b=2,c=3};	
		local d = c;

		assertEquals(true, Sea.table.isEquivalent(c,d) );
		
		local e = {a=3,b=2,c=1};	
		assertEquals(false, Sea.table.isEquivalent(a,e) );
		
		local f = {a=3,b=2,c=1};	
		local g = {a=3,b=2,c=1};	

		g.c = f;
		f.c = g;
		
		assertEquals(false, Sea.table.isEquivalent(f,g) );
	end

	function TestSeaTable:test_copy()
		local a = {a=1,b=2,c={d=2,e=4,asdf="gg"}};	
		local copy = Sea.table.copy(a);

		assertEquals(true, Sea.table.isEquivalent(a,copy) );
	end

-- class TestSeaTable

luaUnit:run()
