local netstring = require("netstring")

local tests = {
	{"", "0:,"},
	{"hello", "5:hello,"},
	{"hello world", "11:hello world,"},
	{",", "1:,,"},
	{":", "1::,"},
	{"\0", "1:\0,"},
}
for _, test in ipairs(tests) do
	assert(netstring.encode(test[1]) == test[2])
	assert(netstring.decode(test[2]) == test[1])
end

-- Invalid input.
assert(netstring.decode("") == nil)
assert(netstring.decode("1") == nil)
assert(netstring.decode(":") == nil)
assert(netstring.decode(",") == nil)
assert(netstring.decode("3hello") == nil)
assert(netstring.decode("3:hello") == nil)
assert(netstring.decode("5:hello-") == nil)
