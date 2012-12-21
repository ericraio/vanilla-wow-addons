
require('luaunit')
require('..\\Sea.lua')
require('..\\Sea.IO.lua')

TestSeaIO = {} --class

	function TestSeaIO:setUp()
		-- do nothing
	end

	function TestSeaIO:tearDown()
		-- do nothing
	end

	function TestSeaIO:test_print()
		assertEquals("fix me", "please");
	end
	
	function TestSeaIO:test_banner()
		assertEquals("fix me", "please");
	end
	
	function TestSeaIO:test_error()
		assertEquals("fix me", "please");
	end
	
	function TestSeaIO:test_dprint()
		assertEquals("fix me", "please");
	end
	
	function TestSeaIO:test_dprintc()
		assertEquals("fix me", "please");
	end
	
	function TestSeaIO:test_derror()
		assertEquals("fix me", "please");
	end
	
	function TestSeaIO:test_derrorf()
		assertEquals("fix me", "please");
	end
	
	function TestSeaIO:test_derrorc()
		assertEquals("fix me", "please");
	end
	
	function TestSeaIO:test_derrorfc()
		assertEquals("fix me", "please");
	end
	
	function TestSeaIO:test_dbanner()
		assertEquals("fix me", "please");
	end
	
	function TestSeaIO:test_dbannerc()
		assertEquals("fix me", "please");
	end
	
	function TestSeaIO:test_printf()
		assertEquals("fix me", "please");
	end
	
	function TestSeaIO:test_dprintf()
		assertEquals("fix me", "please");
	end
	
	function TestSeaIO:test_dprintfc()
		assertEquals("fix me", "please");
	end
	
	function TestSeaIO:test_errorc()
		assertEquals("fix me", "please");
	end
	
	function TestSeaIO:test_errorf()
		assertEquals("fix me", "please");
	end

	function TestSeaIO:test_errorfc()
		assertEquals("fix me", "please");
	end

	function TestSeaIO:test_printc()
		assertEquals("fix me", "please");
	end

	function TestSeaIO:test_bannerc()
		assertEquals("fix me", "please");
	end

	function TestSeaIO:test_printfc()
		assertEquals("fix me", "please");
	end

	function TestSeaIO:test_printComma()
		assertEquals("fix me", "please");
	end

	function TestSeaIO:test_printTable()
		assertEquals("fix me", "please");
	end


-- class TestSeaIO

luaUnit:run()
