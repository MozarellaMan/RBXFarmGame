-- Compiled with https://roblox-ts.github.io v0.3.2
-- April 28, 2020, 5:46 PM British Summer Time

local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"));
local Players = TS.import(script, TS.getModule(script, "services")).Players;
local Inventory = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "inventory", "inventory").Inventory;
local Net = TS.import(script, TS.getModule(script, "net").out);
local ItemIndex = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "inventory", "item").ItemIndex;
local Inventories = {};
Players.PlayerAdded:Connect(function(player)
	print(player.AccountAge, player.Name, player.CameraMode);
	local newInv = Inventory.new(player);
	Inventories[player] = newInv;
end);
local addItemToPlayer = Net.CreateEvent("addItemToPlayer");
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
	print(TS.map_toString(Inventories));
end);
