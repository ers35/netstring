--[[=
# netstring

Encode and decode [netstrings](https://cr.yp.to/proto/netstrings.txt).

## Install
`luarocks install ers35/netstring`
--]]

local netstring = {}

--[[=
## Usage
--]]

--[[=
```lua
local encoded = netstring.encode("hello")
```
--]]
function netstring.encode(input)
	input = tostring(input)
	local output = #input .. ":" .. input .. ","
	return output
end

--[[=
```lua
local decoded = netstring.decode("5:hello,")
```
--]]
function netstring.decode(input)
	local lengthStart, lengthEnd, length = input:find("^(%d+):")
	if not length then
		return nil
	end
	length = tonumber(length)
	local data = input:sub(lengthEnd + 1, -2)
	if #data ~= length then
		return nil
	end
	return data
end

if os.getenv("TEST") then
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
end

return netstring
