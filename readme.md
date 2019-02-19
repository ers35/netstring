# netstring

Encode and decode [netstrings](https://cr.yp.to/proto/netstrings.txt).

## Install
`luarocks install --server=https://luarocks.org/manifests/ers35 netstring`

## Usage

```lua
local encoded = netstring.encode("hello")
```

```lua
local decoded = netstring.decode("5:hello,")
```

