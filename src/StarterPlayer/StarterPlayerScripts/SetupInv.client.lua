local Player = game.Players.LocalPlayer

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Event = ReplicatedStorage:WaitForChild("DataEvent", 30)
local Item = require(game.ReplicatedStorage.ItemClass)
local InvComponent = ReplicatedStorage:WaitForChild("InvComponent", 30)


local Rocrastinate = require(ReplicatedStorage:WaitForChild("Rocrastinate"))
local RootReducer = require(InvComponent.RootReducer)
local Actions = require(InvComponent.Actions)
local inventoryStore = Rocrastinate.createStore(RootReducer.reducer, {}) -- setting intiial inventory store state
local PlayerGui = Player:WaitForChild("PlayerGui")
local inventoryDisplay = require(ReplicatedStorage:WaitForChild("InventoryDisplay"))

local invData

function SetupInv()
	Event:FireServer()
	
	wait(invData)
	
	print(Player.Name .. "'s Items:")
	if invData ~= nil then
		for i, item in pairs(invData)do
			print("Name:" .. i .. "\nAmount: " .. item.Amount .. "\nType: " .. item.Content.ItemClass)
		end
	end
	
end

function UpdateInv(newInv)
	invData = newInv
	inventoryStore.dispatch(Actions.setInventory(ReturnInv()))

end

function ReturnInv()
	return invData
end

Event.OnClientEvent:Connect(UpdateInv)

SetupInv()


local middle  = Rocrastinate.InspectorMiddleware.createInspectorMiddleware()
inventoryStore.applyMiddleware(middle)
inventoryStore.dispatch(Actions.setInventory(ReturnInv()))
inventoryDisplay.new(inventoryStore, PlayerGui)