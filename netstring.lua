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
	local comma = input:sub(-1)
	if comma ~= "," then
		return nil
	end
	return data
end

return netstring
