local Rodux = require(game.ReplicatedStorage.Rodux)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)

local function reducer(state, action)
	state = state or {
		value = 0,
	}
	
	if action.type == "increment" then
		return {
			value = state.value + 1
		}
	end
	
	return state
end

local store = Rodux.Store.new(reducer)

local function MyComponent(props)
	local value = props.value
	local onClick = props.onClick
	
	return Roact.createElement("ScreenGui",nil,{
		Label = Roact.createElement("TextButton",{
			Text = "Current value: " .. value,
			Size = UDim2.new(0.2,0,0.2,0),
			
			[Roact.Event.Activated] = onClick,
		})
	})
end

MyComponent = RoactRodux.connect(
	function(state, props)
		return {
			value = state.value
		}
	end,
	function(dispatch)
		return {
			onClick = function()
				dispatch({
					type = "increment",
				})
			end,	
		}
	end
)(MyComponent)

local app = Roact.createElement(RoactRodux.StoreProvider, {
	store = store,
}, {
	Main = Roact.createElement(MyComponent)
})

Roact.mount(app, Players.LocalPlayer.PlayerGui)