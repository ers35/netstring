# netstring

Encode and decode [netstrings](https://cr.yp.to/proto/netstrings.txt).

## Install
`luarocks install ers35/netstring`

## Usage

### netstring.encode(decoded)

Encode a netstring.

```lua
local encoded = netstring.encode("hello")
```

### netstring.decode(encoded)

Decode a netstring.

```lua
local decoded, remainder = netstring.decode("5:hello,5:world,")
```

### netstring.gdecode(encoded)

Returns an iterator function that, each time it is called, returns the next decoded 
string from `encoded`.

```lua
local encoded = "5:hello,5:world,"
for decoded in netstring.gdecode(encoded) do
	print(decoded)
end
```

