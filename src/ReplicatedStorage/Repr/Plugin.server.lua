assert(plugin, "This should be run as a plugin!")
if plugin and game:GetService("RunService"):IsServer() then
	local repr = require(script.Parent)
	_G.repr = repr
	_G.print_repr = function (...)
		local retVals = {repr(...)}
		print(unpack(retVals))
		return unpack(retVals)
	end
end