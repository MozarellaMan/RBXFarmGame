-- Compiled with https://roblox-ts.github.io v0.3.1
-- April 11, 2020, 10:51 PM British Summer Time

local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"));
local Players = TS.import(script, TS.getModule(script, "services")).Players;
local Inventory = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "inventory").Inventory;
local Items = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "item").Items;
Players.PlayerAdded:Connect(function(player)
	print(player.AccountAge, player.Name, player.CameraMode);
	local newInv = Inventory.new(player);
	newInv:addItem(Items[3]);
	print(newInv.owner.Name, TS.array_toString(newInv.contents));
end);
