local ActionTypes = require(script.Parent.ActionTypes)

local root = {}

local function deepCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepCopy(orig_key)] = deepCopy(orig_value)
        end
        setmetatable(copy, deepCopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function root.reducer(action,get,set) 
    if action.type == ActionTypes.SET_INVENTORY then
        set(deepCopy(action.inventory))
    end
end

return root