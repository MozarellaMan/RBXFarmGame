local Inventory = {}

local InventoryClass = {} -- The inventory object
local Inventories = {} -- table that holds all player inventories
local ItemModule = require(game.ReplicatedStorage.ItemClass)
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local repr = require(ReplicatedStorage:WaitForChild("Repr"))


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

	local count = 1
	InventoryMeta.Size = 0
	while count <= InventoryMeta.MaxSize do
		InventoryMeta.Contents[count] = {}
		count = count+1

	end
	
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

	local targetSlot -- slot for item to be added into
	local itemExists = false -- flag for if the item exists in the inventory

	-- checks every inventory slot for space
	for key, value in ipairs(self.Contents) do
		if value[itemName] then
			targetSlot = value --set pointer to slot that contains the same item
			itemExists = true

			if(value[itemName].Amount == Item.MaxAmount) then -- skip slot if full
				itemExists = false
			end
		end
	end

	if not itemExists then -- insert into first free slot
		for key, value in ipairs(self.Contents) do
			if next(value) == nil then
				targetSlot = value
				itemExists = true
				break
			end
		end
	end

	if targetSlot ~= nil then
		if not targetSlot[itemName] then -- if item does not exist
			self.Size = self.Size + 1
			targetSlot[itemName] = {Amount = Amount, ItemData = Item}
		else
			-- update item amount
			local newAmount = targetSlot[itemName].Amount + Amount
			if newAmount >= targetSlot[itemName].ItemData.MaxAmount then
				targetSlot[itemName].Amount = Item.MaxAmount
				return -1
			end 
			targetSlot[itemName].Amount = newAmount
		end
		print(repr(self.Contents, {pretty=true}))
	end

	-- check if inventory is full
	if self.Size >= self.MaxSize then
		local lastSlot = self.Contents[self.MaxSize]
		if(next(lastSlot) ~= nil) then
			local item = lastSlot[next(lastSlot)]
			if(item.Amount == item.ItemData.MaxAmount) then
				return -1
			end
		else
			return -1
		end
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
