local Inventory = {}

local InventoryClass = {} -- The inventory object
local Inventories = {} -- table that holds all player inventories
local ItemModule = require(game.ReplicatedStorage.ItemClass)
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

-- Constructor that creates a new inventory for a player, with an empty table to hold the inventory contents
function Inventory.New(Player, Table, MaxSize, Size)
	local InventoryMeta = setmetatable({
			Size = Size,
			MaxSize = MaxSize,
			Contents = Table, 
			Ownership = Player.UserId,
		}, {
			__index = InventoryClass
	})
	Inventories[Player] = InventoryMeta -- Add player's inventory to the inventory table
	return InventoryMeta
end

function Inventory:GetInventory(Player)
	local newInv = Inventories
	return Inventories[Player]
end

function Inventory:DeleteInventory(Player)
	Inventories[Player] =  nil
end

function InventoryClass:AddItem(Item, Amount)
	local itemName = Item.Name
	if self.Size >= self.MaxSize then
		return -1
	end
	if not self.Contents[itemName] then -- check if item doesn't already exist in inventory
		self.Size = self.Size + 1
		self.Contents[itemName] = {Slot = self.Size ,Amount = Amount, Content = Item}

	else
		local items = ItemModule:GetItems()
		local newAmount = self.Contents[itemName].Amount + Amount
		if (self.Contents[itemName].Amount >= items[itemName].MaxAmount) or (newAmount >= items[itemName].MaxAmount) then
			print("Max amount of this item reached!")
			self.Contents[itemName].Amount = items[itemName].MaxAmount
			return -1
		end
		self.Contents[itemName].Amount = newAmount -- increment amount of item if it already exists
	end
end

function InventoryClass:GetContents() --get the contents of a given inventory
	return self.Contents
end

function Inventory:GetInventories()
	return Inventories
end

function Inventory:SetInventory(Player, inventory)
	Inventories[Player] = inventory
	local newInv = Inventories
end

function Inventory:Deserialize(inventoryJSON)
	inventoryJSON = HttpService:JSONDecode(inventoryJSON)
	local newInventory = Inventory.New(Players:GetPlayerByUserId(inventoryJSON.Ownership), inventoryJSON.Contents, inventoryJSON.MaxSize, inventoryJSON.Size)
	return newInventory
end

return Inventory
