# netstring

Encode and decode [netstrings](https://cr.yp.to/proto/netstrings.txt).

## Install
`luarocks install --server=http://luarocks.org/m/ers35 netstring`

## Usage

```lua
local encoded = netstring.encode("hello")
```

```lua
local decoded = netstring.decode("5:hello,")
```

