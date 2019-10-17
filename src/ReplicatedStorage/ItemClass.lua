local Item = {}
Item.__index = Item

function Item.new(itemClass, name, value, rarity, maxAmount)
	local newItem = {}
	setmetatable(newItem, Item)
	
	newItem.ItemClass = itemClass
	newItem.Name = name
	newItem.Value = value
	newItem.Rarity = rarity
	newItem.MaxAmount = maxAmount
	
	return newItem
end

local Items = {
	["Pumpkin Seed"] = Item.new("Seed", "Pumpkin Seed", 50, "Uncommon",64),
	["Diamond"] = Item.new("Resource", "Diamond", 5000, "Exotic",64),
	["Hot Dog"] = Item.new("Food", "Hot Dog", 20, "Uncommon",10)
	} 

function Item:__tostring()
	return "Type: " .. self.ItemClass .. ", Name: " .. self.Name .. ", Value: " .. self.Value .. ", Rarity: " .. self.Rarity .. " "
end

function Item:GetItems()
	return Items
end

return Item
