-- Typically this would be put in a separate module called "actionTypes"
local ADD_COINS = 'ADD_COINS'

-- Typically this would be put in a separate module called "actions"
local function addCoins(amount) 
    return {
        type = ADD_COINS,
        amount = amount,
    }
end

-- Typically this would be put in a separate module called "reducer" or "rootReducer"
local function reducer(action, get, set)
    if action.type == ADD_COINS then
        set(get() + action.amount)
    end
end
local initialState = 0

-- Typically this would be put at the entry point for our code
local Rocrastinate = require(game.ReplicatedStorage.Rocrastinate)
local coinsStore = Rocrastinate.createStore(reducer, initialState)

print(coinsStore.getState()) -- 0

coinsStore.dispatch(addCoins(10))
print(coinsStore.getState()) -- 10

coinsStore.dispatch(addCoins(10))
print(coinsStore.getState()) -- 20