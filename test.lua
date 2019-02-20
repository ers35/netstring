local netstring = require("netstring")

local tests = {
	{"", "0:,"},
	{"hello", "5:hello,"},
	{"hello world", "11:hello world,"},
	{",", "1:,,"},
	{":", "1::,"},
	{"\0", "1:\0,"},
	{0, "1:0,"},
	{123, "3:123,"},
	{1.5, "3:1.5,"},
	{false, "5:false,"},
}
for i, test in ipairs(tests) do
	assert(netstring.encode(test[1]) == tostring(test[2]), "test " .. i)
	assert(netstring.decode(test[2]) == tostring(test[1]), "test " .. i)
end

local decoded, remainder = netstring.decode("5:hello,5:world,")
assert(decoded == "hello")
assert(remainder == "5:world,")
local iter = netstring.gdecode("5:hello,5:world,")
assert(iter() == "hello")
assert(iter() == "world")
local encoded = netstring.encode(0.0)
assert(encoded == "1:0," or encoded == "3:0.0,")

-- Invalid input.
assert(netstring.decode("") == nil)
assert(netstring.decode("1") == nil)
assert(netstring.decode("1:") == nil)
assert(netstring.decode(":") == nil)
assert(netstring.decode(",") == nil)
assert(netstring.decode("3hello") == nil)
assert(netstring.decode("3:hello") == nil)
assert(netstring.decode("5:hello-") == nil)
local iter = netstring.gdecode("")
assert(iter() == nil)
