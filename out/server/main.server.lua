-- Compiled with https://roblox-ts.github.io v0.3.2
-- April 28, 2020, 3:05 PM British Summer Time

local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"));
local Players = TS.import(script, TS.getModule(script, "services")).Players;
local Inventory = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "inventory").Inventory;
Players.PlayerAdded:Connect(function(player)
	print(player.AccountAge, player.Name, player.CameraMode);
	local newInv = Inventory.new(player);
end);
