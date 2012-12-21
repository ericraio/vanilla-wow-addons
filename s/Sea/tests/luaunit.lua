--[[ 
		luaunit.lua

Description: A unit testing framework
Initial author: Ryu, Gwang (http://www.gpgstudy.com/gpgiki/LuaUnit)
improvements by Philippe Fremy <phil@freehackers.org>
Version: 1.0 

TODO:
- try to display the failing line
- use xpcall to reveal the calling stack
- isolate output rendering into a separate class ?
- isolate result into a separate class ?
- customised output for the failing line ?
]]--

argv = arg

function assertEquals(expected, actual)
	if  actual ~= expected  then
		local function wrapValue( v )
			if type(v) == 'string' then return "'"..v.."'" end
			return tostring(v)
		end
		errorMsg = "expected: "..wrapValue(expected)..", actual: "..wrapValue(actual)
		error( errorMsg, 2 )
	end
end

function isFunction(aObject)
    if  'function' == type(aObject) then
        return true
    else
        return false
    end
end

luaUnit = {
	FailedCount = 0,
	TestCount = 0,
	Errors = {}
}

	function luaUnit:displayClassName( aClassName )
		print( '>>>>>> '..aClassName )
	end

	function luaUnit:displayTestName( testName )
		print( ">>> "..testName )
	end

	function luaUnit:displayFailure( errorMsg )
		print( errorMsg )
		print( 'Failed' )
	end

	function luaUnit:displaySuccess()
		print ("Ok" )
	end

	function luaUnit:displayResult()
		if self.TestCount == 0 then
			failurePercent = 0
		else
			failurePercent = 100.0 * self.FailedCount / self.TestCount
		end
		successCount = self.TestCount - self.FailedCount
		print( string.format("Success : %d%% - %d / %d",
			100-math.ceil(failurePercent), successCount, self.TestCount) )
    end

	function luaUnit:analyseErrorLine( errorMsg )
		mb, me, filename, line = string.find(errorMsg, "(%w+):(%d+)" )
		if filename and line then
			-- check that file exists
			-- read it, read the line
			-- display the line
		end
	end

    function luaUnit:runTestMethod(aName, aClassInstance, aMethod)
		-- example: runTestMethod( 'TestToto:test1', TestToto, TestToto.testToto(self) )
		luaUnit:displayTestName(aName)
        self.TestCount = self.TestCount + 1

		-- run setUp first(if any)
		if isFunction( aClassInstance.setUp) then
				aClassInstance:setUp()
		end

		-- run testMethod()
        ok, errorMsg = pcall( aMethod )
		if not ok then
            self.FailedCount = self.FailedCount + 1
			table.insert( self.Errors, errorMsg )
			luaUnit:analyseErrorLine( errorMsg )
			luaUnit:displayFailure( errorMsg )
        else
			luaUnit:displaySuccess()
        end

		-- lastly, run tearDown(if any)
		if isFunction(aClassInstance.tearDown) then
				 aClassInstance:tearDown()
		end
    end

	function luaUnit:runTestMethodName( methodName, classInstance )
		-- example: runTestMethodName( 'TestToto:testToto', TestToto )
		methodInstance = loadstring(methodName .. '()')
		luaUnit:runTestMethod(methodName, classInstance, methodInstance)
	end

    function luaUnit:runTestClassByName( aClassName )
		-- example: runTestMethodName( 'TestToto' )
		hasMethod = string.find(aClassName, ':' )
		if hasMethod then
			methodName = string.sub(aClassName, hasMethod+1)
			aClassName = string.sub(aClassName,1,hasMethod-1)
		end
        classInstance = _G[aClassName]
		if not classInstance then
			error( "No such class: "..aClassName )
		end
		luaUnit:displayClassName( aClassName )

		if hasMethod then
			if not classInstance[ methodName ] then
				error( "No such method: "..methodName )
			end
			luaUnit:runTestMethodName( aClassName..':'.. methodName, classInstance )
		else
			-- run all test methods of the class
			for methodName, method in classInstance do
				if isFunction(method) and string.sub(methodName, 1, 4) == "test" then
					luaUnit:runTestMethodName( aClassName..':'.. methodName, classInstance )
				end
			end
		end
		print()
	end

	function luaUnit:run(...)
		-- Run some specific test classes.
		-- If no arguments are passed, run the class names specified on the
		-- command line. If no class name is specified on the command line
		-- run all classes whose name starts with 'Test'
		--
		-- If arguments are passed, they must be strings of the class names 
		-- that you want to run
		if arg.n > 0 then
			table.foreachi( arg, luaUnit.runTestClassByName )
		else 
			if argv.n > 0 then
				table.foreachi(argv, luaUnit.runTestClassByName )
			else
				for var, value in _G do
					if string.sub(var,1,4) == 'Test' then 
						luaUnit:runTestClassByName(var)
					end
				end
			end
		end
		luaUnit:displayResult()
	end
-- class luaUnit

function wrapFunctions(...)
	testClass = {}
	local function storeAsMethod(idx, testName)
		testFunction = _G[testName]
		testClass[testName] = testFunction
	end
	table.foreachi( arg, storeAsMethod )
	return testClass
end
