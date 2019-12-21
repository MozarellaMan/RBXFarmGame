local InventoryModule = require(game.ServerStorage.InvData)
local players = game:GetService("Players")
local Item = require(game.ReplicatedStorage.ItemClass)

local clickDetect = script.Parent:WaitForChild("ClickDetector", 30)
local inventory = {}
local exampleItem = Item:GetItems()["Diamond"]
function giveItem(player)
	InventoryModule:GetInventory(player):AddItem(exampleItem, 3)
end

clickDetect.MouseClick:Connect(giveItem)