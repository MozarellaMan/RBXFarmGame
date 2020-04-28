-- Compiled with https://roblox-ts.github.io v0.3.2
-- April 28, 2020, 2:29 PM British Summer Time

local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"));
local Players = TS.import(script, TS.getModule(script, "services")).Players;
local Inventory = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "inventory").Inventory;
local Items = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "item").Items;
Players.PlayerAdded:Connect(function(player)
	print(player.AccountAge, player.Name, player.CameraMode);
	local newInv = Inventory.new(player);
	newInv:addItem(Items[3]);
	print(newInv.owner.Name, TS.array_toString(newInv.contents));
	newInv:addItem(Items[2]);
	print(newInv.owner.Name, TS.array_toString(newInv.contents));
	newInv:addItem(Items[1]);
	print(newInv.owner.Name, TS.array_toString(newInv.contents));
	newInv:addItem(Items[3]);
	newInv:addItem(Items[3]);
	do
		local i = 0;
		while i < 20 do
			newInv:addItem(Items[3]);
			i = i + 1;
		end;
	end;
	print(newInv.owner.Name, TS.array_toString(newInv.contents));
end);
