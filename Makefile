default: test readme.md
	luarocks make --local

test:
	lua5.1 test.lua
	lua5.2 test.lua
	lua5.3 test.lua
	luajit test.lua
	
readme.md: netstring.lua Makefile
	lua -e 'for match in io.read("*all"):gmatch("--%[%[%=%s?(.-)--%]%]") do print(match) end' < "$<" > "$@"
