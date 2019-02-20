-- The author disclaims copyright to this source code.

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
### netstring.encode(decoded)

Encode a netstring.

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
### netstring.decode(encoded)

Decode a netstring.

```lua
local decoded, remainder = netstring.decode("5:hello,5:world,")
```
--]]
function netstring.decode(input)
	local start, stop, length = input:find("^(%d+):")
	if not length then
		return nil, "invalid length"
	end
	length = tonumber(length)
	local index = stop + length
	
	local output = input:sub(stop + 1, index)
	if #output < length then
		return nil, "input too short"
	end
	index = index + 1
	
	local comma = input:sub(index, index)
	if comma ~= "," then
		return nil, "missing trailing ','"
	end
	index = index + 1
	
	local remainder = input:sub(index)
	return output, remainder
end

--[[=
### netstring.gdecode(encoded)

Returns an iterator function that, each time it is called, returns the next decoded 
string from `encoded`.

```lua
local encoded = "5:hello,5:world,"
for decoded in netstring.gdecode(encoded) do
	print(decoded)
end
```
--]]
function netstring.gdecode(input)
	local decoded
	return function()
		decoded, input = netstring.decode(input)
		return decoded
	end
end

return netstring
