local InventoryModule = require(game.ServerStorage.InvData)
local players = game:GetService("Players")
local Item = require(game.ReplicatedStorage.ItemClass)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Event = ReplicatedStorage:WaitForChild("DataEvent", 30)
local DataStoreService = game:GetService("DataStoreService")
local inventoryDataStore = DataStoreService:GetDataStore("inventoryDataStore")
local HttpService = game:GetService("HttpService")

function PlayerJoined(player)
	local data
	local success, errorMessage = pcall(function()
		data = inventoryDataStore:GetAsync(player.UserId.."-inventory")
		print("wow!")
	end)
	
	if success and data ~= nil then
		InventoryModule:SetInventory(player, InventoryModule:Deserialize(data))
		print("Player inventory succcesfully retrieved!")
		print(data)
	else
		local inventory = {}
		InventoryModule.New(player, inventory, 12, 0)
		print("There was an error while retrieving your inventory")
		warn(errorMessage)
	end
end

function PlayerLeft(player)
	local success, errorMessage = pcall(function()
		print(InventoryModule:GetInventory(player))
		inventoryDataStore:SetAsync(player.UserId.."-inventory", HttpService:JSONEncode(InventoryModule:GetInventory(player)))
	end)
	
	if success then
		print("Player inventory successfully saved")
		InventoryModule:DeleteInventory(player)
	else
		print("There was an error while saving data")
		warn(errorMessage)
	end
end

function RetrieveInv(player)
	wait(InventoryModule:GetInventory(player):GetContents())
	Event:FireClient(player, InventoryModule:GetInventory(player):GetContents())
end

players.PlayerAdded:Connect(PlayerJoined)
players.PlayerRemoving:Connect(PlayerLeft)

Event.OnServerEvent:Connect(RetrieveInv)