local module = {}

function module:params(types, givenValues, required)
	local required = required or 0
	local values = {}
	for _, v in pairs(givenValues) do
		table.insert(values, typeof(v))
	end
	
	for i = 1, #types do
		if types[i] ~= "skip" then
			if i <= required and values[i] == nil then
				self:errorf("Required parameter %d with type %s wasn't given!", i, types[i])
			elseif values[i] ~= nil then
				self:assertf(types[i] == values[i], "Wrong argument type given on parameter %d!\nExpected types: %s\nGiven types: %s", i, table.concat(types, " | "), table.concat(values, " | "))
			end
		end
	end
end

function module:printf(str, ...)
	print(string.format(str, ...))
end

function module:warnf(str, ...)
	warn(string.format(str, ...))
end

function module:errorf(str, ...)
	error(string.format(str, ...))
end

function module:assertf(condition, str, ...)
	assert(condition, string.format(str, ...))
end

function module:tCount(tbl)
	local Count = 0
	for i, v in pairs(tbl) do
		Count = Count + 1
	end
	
	return Count
end

return module
