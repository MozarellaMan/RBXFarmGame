local ActionTypes = require(script.Parent.ActionTypes)

local actions = {}

function actions.setInventory(inventory)
    return {
        type = ActionTypes.SET_INVENTORY,
        inventory = inventory,
    }
end

local initialState = 0

return actions