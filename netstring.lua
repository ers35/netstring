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

return netstring
