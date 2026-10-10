-- @author: lcx3@meitu.com
local config = {}

config.filterChain = {
	{
		key = "faceLight",
		path = "filter/faceLight/faceLight",
		resourcePath = "filter/faceLight"
	},
	{
		key = "shadow",
		path = "filter/faceShadow/faceShadow",
		resourcePath = "filter/faceShadow"
	},
	{
		key = "rim",
		path = "filter/rimLight/rimLight",
		resourcePath = "filter/rimLight"
	},
	{
		key = "depthLight",
		path = "filter/depthLight/depthLight",
		resourcePath = "filter/depthLight"
	},
}


return config