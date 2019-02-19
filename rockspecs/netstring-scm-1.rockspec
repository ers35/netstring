package = "netstring"
version = "scm-1"
source = {
	url = "git://github.com/ers35/netstring"
}
description = {
	summary = "Encode and decode netstrings.",
	homepage = "https://github.com/ers35/netstring",
	license = "CC0"
}
dependencies = {
	"lua >= 5.1",
}
build = {
	type = "builtin",
	modules = {
		netstring = "netstring.lua",
	},
}
