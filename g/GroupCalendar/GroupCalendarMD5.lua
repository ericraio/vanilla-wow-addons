-- An MD5 mplementation in Lua, requires bitlib
-- Written by Jean-Claude Wippler
-- 10/02/2001 jcw@equi4.com
-- Original source available at http://www.equi4.com/md5/md5calc.lua

-- Transformed for use in GroupCalendar by John Stephen

gGroupCalendarMD5 =
{
};

function GroupCalendarMD5_Initialize()
	gGroupCalendarMD5.Mask32 = tonumber("ffffffff", 16);
	gGroupCalendarMD5.Consts = {};
	
	local	vConstants =
	{
		"d76aa478", "e8c7b756", "242070db", "c1bdceee",
		"f57c0faf", "4787c62a", "a8304613", "fd469501",
		"698098d8", "8b44f7af", "ffff5bb1", "895cd7be",
		"6b901122", "fd987193", "a679438e", "49b40821",
		
		"f61e2562", "c040b340", "265e5a51", "e9b6c7aa",
		"d62f105d", "02441453", "d8a1e681", "e7d3fbc8",
		"21e1cde6", "c33707d6", "f4d50d87", "455a14ed",
		"a9e3e905", "fcefa3f8", "676f02d9", "8d2a4c8a",
		
		"fffa3942", "8771f681", "6d9d6122", "fde5380c",
		"a4beea44", "4bdecfa9", "f6bb4b60", "bebfbc70",
		"289b7ec6", "eaa127fa", "d4ef3085", "04881d05",
		"d9d4d039", "e6db99e5", "1fa27cf8", "c4ac5665",
		
		"f4292244", "432aff97", "ab9423a7", "fc93a039",
		"655b59c3", "8f0ccc92", "ffeff47d", "85845dd1",
		"6fa87e4f", "fe2ce6e0", "a3014314", "4e0811a1",
		"f7537e82", "bd3af235", "2ad7d2bb", "eb86d391",
		
		"67452301", "efcdab89", "98badcfe", "10325476",
	};
	
	for vIndex, vConstStr in vConstants do
		gGroupCalendarMD5.Consts[vIndex] = tonumber(vConstStr, 16);
	end
end

function GroupCalendarMD5_f(x, y, z)
	return bit.bor(bit.band(x, y), bit.band(-x - 1, z));
end

function GroupCalendarMD5_g(x, y, z)
	return bit.bor(bit.band(x, z), bit.band(y, -z - 1));
end

function GroupCalendarMD5_h(x, y, z)
	return bit.bxor(x, bit.bxor(y, z));
end

function GroupCalendarMD5_i(x, y, z)
	return bit.bxor(y, bit.bor(x, -z - 1));
end

function GroupCalendarMD5_z(f,a,b,c,d,x,s,ac)
	a = bit.band(a + f(b, c, d) + x + ac, gGroupCalendarMD5.Mask32);
	
	-- be *very* careful that left shift does not cause rounding!
	
	return bit.bor(bit.lshift(bit.band(a, bit.rshift(gGroupCalendarMD5.Mask32, s)), s), bit.rshift(a, 32 - s)) + b;
end

function GroupCalendarMD5_Transform(A,B,C,D,X)
	local a, b, c, d = A, B, C, D;
	local t = gGroupCalendarMD5.Consts;
	
	-- Round 1
	
	a=GroupCalendarMD5_z(GroupCalendarMD5_f,a,b,c,d,X[ 1], 7,t[ 1])
	d=GroupCalendarMD5_z(GroupCalendarMD5_f,d,a,b,c,X[ 2],12,t[ 2])
	c=GroupCalendarMD5_z(GroupCalendarMD5_f,c,d,a,b,X[ 3],17,t[ 3])
	b=GroupCalendarMD5_z(GroupCalendarMD5_f,b,c,d,a,X[ 4],22,t[ 4])
	a=GroupCalendarMD5_z(GroupCalendarMD5_f,a,b,c,d,X[ 5], 7,t[ 5])
	d=GroupCalendarMD5_z(GroupCalendarMD5_f,d,a,b,c,X[ 6],12,t[ 6])
	c=GroupCalendarMD5_z(GroupCalendarMD5_f,c,d,a,b,X[ 7],17,t[ 7])
	b=GroupCalendarMD5_z(GroupCalendarMD5_f,b,c,d,a,X[ 8],22,t[ 8])
	a=GroupCalendarMD5_z(GroupCalendarMD5_f,a,b,c,d,X[ 9], 7,t[ 9])
	d=GroupCalendarMD5_z(GroupCalendarMD5_f,d,a,b,c,X[10],12,t[10])
	c=GroupCalendarMD5_z(GroupCalendarMD5_f,c,d,a,b,X[11],17,t[11])
	b=GroupCalendarMD5_z(GroupCalendarMD5_f,b,c,d,a,X[12],22,t[12])
	a=GroupCalendarMD5_z(GroupCalendarMD5_f,a,b,c,d,X[13], 7,t[13])
	d=GroupCalendarMD5_z(GroupCalendarMD5_f,d,a,b,c,X[14],12,t[14])
	c=GroupCalendarMD5_z(GroupCalendarMD5_f,c,d,a,b,X[15],17,t[15])
	b=GroupCalendarMD5_z(GroupCalendarMD5_f,b,c,d,a,X[16],22,t[16])
	
	-- Round 2
	
	a=GroupCalendarMD5_z(GroupCalendarMD5_g,a,b,c,d,X[ 2], 5,t[17])
	d=GroupCalendarMD5_z(GroupCalendarMD5_g,d,a,b,c,X[ 7], 9,t[18])
	c=GroupCalendarMD5_z(GroupCalendarMD5_g,c,d,a,b,X[12],14,t[19])
	b=GroupCalendarMD5_z(GroupCalendarMD5_g,b,c,d,a,X[ 1],20,t[20])
	a=GroupCalendarMD5_z(GroupCalendarMD5_g,a,b,c,d,X[ 6], 5,t[21])
	d=GroupCalendarMD5_z(GroupCalendarMD5_g,d,a,b,c,X[11], 9,t[22])
	c=GroupCalendarMD5_z(GroupCalendarMD5_g,c,d,a,b,X[16],14,t[23])
	b=GroupCalendarMD5_z(GroupCalendarMD5_g,b,c,d,a,X[ 5],20,t[24])
	a=GroupCalendarMD5_z(GroupCalendarMD5_g,a,b,c,d,X[10], 5,t[25])
	d=GroupCalendarMD5_z(GroupCalendarMD5_g,d,a,b,c,X[15], 9,t[26])
	c=GroupCalendarMD5_z(GroupCalendarMD5_g,c,d,a,b,X[ 4],14,t[27])
	b=GroupCalendarMD5_z(GroupCalendarMD5_g,b,c,d,a,X[ 9],20,t[28])
	a=GroupCalendarMD5_z(GroupCalendarMD5_g,a,b,c,d,X[14], 5,t[29])
	d=GroupCalendarMD5_z(GroupCalendarMD5_g,d,a,b,c,X[ 3], 9,t[30])
	c=GroupCalendarMD5_z(GroupCalendarMD5_g,c,d,a,b,X[ 8],14,t[31])
	b=GroupCalendarMD5_z(GroupCalendarMD5_g,b,c,d,a,X[13],20,t[32])
	
	-- Round 3
	
	a=GroupCalendarMD5_z(GroupCalendarMD5_h,a,b,c,d,X[ 6], 4,t[33])
	d=GroupCalendarMD5_z(GroupCalendarMD5_h,d,a,b,c,X[ 9],11,t[34])
	c=GroupCalendarMD5_z(GroupCalendarMD5_h,c,d,a,b,X[12],16,t[35])
	b=GroupCalendarMD5_z(GroupCalendarMD5_h,b,c,d,a,X[15],23,t[36])
	a=GroupCalendarMD5_z(GroupCalendarMD5_h,a,b,c,d,X[ 2], 4,t[37])
	d=GroupCalendarMD5_z(GroupCalendarMD5_h,d,a,b,c,X[ 5],11,t[38])
	c=GroupCalendarMD5_z(GroupCalendarMD5_h,c,d,a,b,X[ 8],16,t[39])
	b=GroupCalendarMD5_z(GroupCalendarMD5_h,b,c,d,a,X[11],23,t[40])
	a=GroupCalendarMD5_z(GroupCalendarMD5_h,a,b,c,d,X[14], 4,t[41])
	d=GroupCalendarMD5_z(GroupCalendarMD5_h,d,a,b,c,X[ 1],11,t[42])
	c=GroupCalendarMD5_z(GroupCalendarMD5_h,c,d,a,b,X[ 4],16,t[43])
	b=GroupCalendarMD5_z(GroupCalendarMD5_h,b,c,d,a,X[ 7],23,t[44])
	a=GroupCalendarMD5_z(GroupCalendarMD5_h,a,b,c,d,X[10], 4,t[45])
	d=GroupCalendarMD5_z(GroupCalendarMD5_h,d,a,b,c,X[13],11,t[46])
	c=GroupCalendarMD5_z(GroupCalendarMD5_h,c,d,a,b,X[16],16,t[47])
	b=GroupCalendarMD5_z(GroupCalendarMD5_h,b,c,d,a,X[ 3],23,t[48])
	
	-- Round 4
	
	a=GroupCalendarMD5_z(GroupCalendarMD5_i,a,b,c,d,X[ 1], 6,t[49])
	d=GroupCalendarMD5_z(GroupCalendarMD5_i,d,a,b,c,X[ 8],10,t[50])
	c=GroupCalendarMD5_z(GroupCalendarMD5_i,c,d,a,b,X[15],15,t[51])
	b=GroupCalendarMD5_z(GroupCalendarMD5_i,b,c,d,a,X[ 6],21,t[52])
	a=GroupCalendarMD5_z(GroupCalendarMD5_i,a,b,c,d,X[13], 6,t[53])
	d=GroupCalendarMD5_z(GroupCalendarMD5_i,d,a,b,c,X[ 4],10,t[54])
	c=GroupCalendarMD5_z(GroupCalendarMD5_i,c,d,a,b,X[11],15,t[55])
	b=GroupCalendarMD5_z(GroupCalendarMD5_i,b,c,d,a,X[ 2],21,t[56])
	a=GroupCalendarMD5_z(GroupCalendarMD5_i,a,b,c,d,X[ 9], 6,t[57])
	d=GroupCalendarMD5_z(GroupCalendarMD5_i,d,a,b,c,X[16],10,t[58])
	c=GroupCalendarMD5_z(GroupCalendarMD5_i,c,d,a,b,X[ 7],15,t[59])
	b=GroupCalendarMD5_z(GroupCalendarMD5_i,b,c,d,a,X[14],21,t[60])
	a=GroupCalendarMD5_z(GroupCalendarMD5_i,a,b,c,d,X[ 5], 6,t[61])
	d=GroupCalendarMD5_z(GroupCalendarMD5_i,d,a,b,c,X[12],10,t[62])
	c=GroupCalendarMD5_z(GroupCalendarMD5_i,c,d,a,b,X[ 3],15,t[63])
	b=GroupCalendarMD5_z(GroupCalendarMD5_i,b,c,d,a,X[10],21,t[64])

	return A+a,B+b,C+c,D+d
end

function GroupCalendarMD5_Calc(s)
	local msgLen=strlen(s)
	local padLen=56-bit.mod(msgLen,64)

	if bit.mod(msgLen,64)>56 then padLen=padLen+64 end

	if padLen==0 then padLen=64 end

	s = s..strchar(128)..strrep(strchar(0),padLen-1)
	s = s..GroupCalendar_LEToString(8*msgLen)..GroupCalendar_LEToString(0)
	
	local a, b, c, d = gGroupCalendarMD5.Consts[65], gGroupCalendarMD5.Consts[66], gGroupCalendarMD5.Consts[67], gGroupCalendarMD5.Consts[68];
 
	for i = 1, strlen(s), 64 do
		local X = GroupCalendar_SliceStringToLEs(strsub(s, i, i + 63));
		a, b, c, d = GroupCalendarMD5_Transform(a, b, c, d, X);
	end
	
	local swap = function (w) return GroupCalendar_StringToBE4(GroupCalendar_LEToString(w)) end
	
	return format("%08x%08x%08x%08x", swap(a), swap(b), swap(c), swap(d));
end

-- convert little-endian 32-bit int to a 4-char string

function GroupCalendar_LEToString(i)
	i = math.floor(i);
	
	local f = function (s) return strchar(bit.band(bit.rshift(i,s),255)) end
	
	return f(0)..f(8)..f(16)..f(24)
end

-- convert raw string to big-endian int

function GroupCalendar_StringToBE4(str)
	return 256 * (256 * (256 * strbyte(str, 1) + strbyte(str, 2)) + strbyte(str, 3)) + strbyte(str, 4);
end

-- cut up a string in little-endian ints of given size

function GroupCalendar_SliceStringToLEs(s)
	local r = {};
	local o = 1;
	
	for i = 1, 16 do
		local	str = strsub(s, o, o + 3);
		r[i] = 256 * (256 * (256 * strbyte(str, 4) + strbyte(str, 3)) + strbyte(str, 2)) + strbyte(str, 1);
		o = o + 4;
	end
	
	return r;
end

function GroupCalendarMD5_Verify()
	s0 = 'message digest'
	s1 = 'abcdefghijklmnopqrstuvwxyz'
	s2 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
	s3 = '12345678901234567890123456789012345678901234567890123456789012345678901234567890'
	
	if GroupCalendarMD5_Calc('') ~= 'd41d8cd98f00b204e9800998ecf8427e' then
		Calendar_ErrorMessage("GroupCalendarMD5: Test 1 failed");
		return;
	end
	
	if GroupCalendarMD5_Calc('a') ~= '0cc175b9c0f1b6a831c399e269772661' then
		Calendar_ErrorMessage("GroupCalendarMD5: Test 2 failed");
		return;
	end
	
	if GroupCalendarMD5_Calc('abc') ~= '900150983cd24fb0d6963f7d28e17f72' then
		Calendar_ErrorMessage("GroupCalendarMD5: Test 3 failed");
		return;
	end
	
	if GroupCalendarMD5_Calc(s0) ~= 'f96b697d7cb7938d525a2f31aaf161d0' then
		Calendar_ErrorMessage("GroupCalendarMD5: Test 4 failed");
		return;
	end
	
	if GroupCalendarMD5_Calc(s1) ~= 'c3fcd3d76192e4007dfb496cca67e13b' then
		Calendar_ErrorMessage("GroupCalendarMD5: Test 5 failed");
		return;
	end
	
	if GroupCalendarMD5_Calc(s2) ~= 'd174ab98d277d9f5a5611c2c9f419d9f' then
		Calendar_ErrorMessage("GroupCalendarMD5: Test 6 failed");
		return;
	end
	
	if GroupCalendarMD5_Calc(s3) ~= '57edf4a22be3c955ac49da2e2107b67a' then
		Calendar_ErrorMessage("GroupCalendarMD5: Test 7 failed");
		return;
	end
	
	Calendar_DebugMessage("GroupCalendarMD5: All tests passed");
end

function GroupCalendarMD5_CheckPerformance()
	if 1 then 
		sizes={10,50,100,500,1000,5000,10000}
		
		for i=1,getn(sizes) do
			local s=strrep(' ',sizes[i])
			debugprofilestart();
			
			for j=1,10 do
				GroupCalendarMD5_Calc(s)
			end
			
			local elapsed = math.floor(debugprofilestop() / 10);
			
			Calendar_DebugMessage(format('%6d bytes: %4d ms', sizes[i], elapsed))
		end
	end
end
