# netstring

Encode and decode [netstrings](https://cr.yp.to/proto/netstrings.txt).

## Install
`luarocks install ers35/netstring`

## Usage

```lua
local encoded = netstring.encode("hello")
```

### netstring.decode(encoded)

Decode a netstring.

```lua
local decoded, remainder = netstring.decode("5:hello,5:world,")
```

