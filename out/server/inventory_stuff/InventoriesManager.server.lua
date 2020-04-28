-- Compiled with https://roblox-ts.github.io v0.3.2
-- April 28, 2020, 10:29 PM British Summer Time

local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"));
local Players = TS.import(script, TS.getModule(script, "services")).Players;
local Inventory = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "inventory", "inventory").Inventory;
local Net = TS.import(script, TS.getModule(script, "net").out);
local ItemIndex = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "inventory", "item").ItemIndex;
local Inventories = {};
local inventoryChanged = Net.CreateEvent("inventoryChanged");
local addItemToPlayer = Net.CreateEvent("addItemToPlayer");
local getPlayerInventory = Net.CreateFunction("getPlayerInventory");
Players.PlayerAdded:Connect(function(player)
	print(player.AccountAge, player.Name, player.CameraMode);
	local newInv = Inventory.new(player);
	Inventories[player] = newInv;
	inventoryChanged:SendToPlayer(player);
end);
addItemToPlayer:Connect(function(player, ...)
	local args = { ... };
	print(player, TS.array_toString(args));
	local itemID = args[1];
	local amount = args[2];
	local itemToAdd = ItemIndex[itemID];
	local inventoryToAffect = Inventories[player];
	if itemToAdd and inventoryToAffect then
		inventoryToAffect:addItem(itemToAdd, amount);
	end;
	inventoryChanged:SendToPlayer(player);
end);
getPlayerInventory:SetCallback(function(player)
	return Inventories[player];
end);
