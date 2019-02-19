default: test readme.md
	luarocks make --local

test:
	TEST=1 lua5.1 netstring.lua
	TEST=1 lua5.2 netstring.lua
	TEST=1 lua5.3 netstring.lua
	TEST=1 luajit netstring.lua
	
readme.md: netstring.lua Makefile
	lua -e 'for match in io.read("*all"):gmatch("--%[%[%=%s?(.-)--%]%]") do print(match) end' < "$<" > "$@"
