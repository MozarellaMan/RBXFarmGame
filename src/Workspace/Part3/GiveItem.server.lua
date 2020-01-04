local InventoryModule = require(game.ServerStorage.InvData)
local players = game:GetService("Players")
local Item = require(game.ReplicatedStorage.ItemClass)
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Event = ReplicatedStorage:WaitForChild("DataEvent", 30)

local clickDetect = script.Parent:WaitForChild("ClickDetector", 30)
local exampleItem = Item:GetItems()["Pumpkin Seed"]
function giveItem(player)
	print("clicked!")
	InventoryModule:GetInventory(player):AddItem(exampleItem, 3)

	Event:FireClient(player, InventoryModule:GetInventory(player))
end

clickDetect.MouseClick:Connect(giveItem) --