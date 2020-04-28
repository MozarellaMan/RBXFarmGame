-- Compiled with https://roblox-ts.github.io v0.3.2
-- April 28, 2020, 8:02 PM British Summer Time

local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"));
local Roact = TS.import(script, TS.getModule(script, "roact").roact.src);
local InvSlot = TS.import(script, script.Parent, "InvSlotComp").InvSlot;
local Net = TS.import(script, TS.getModule(script, "net").out);
local Players = game:GetService("Players");
local InventoryGui = function(props)
	local contents = props.contents;
	return Roact.createElement(
		"ScreenGui",
		{},
		{
			Roact.createElement(
				"Frame",
				{
					Position = UDim2.new(0.1, 0, 0.9, -60),
					Size = UDim2.new(0, 1000, 0, 0),
				},
				{
					Roact.createElement("UIGridLayout"),
					Roact.createElement(
						InvSlot,
						{
							itemName = "Bread",
							amount = 0,
						}
					),
				}
			),
		}
	);
end;
local PlayerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui");
local getInventory = Net.WaitForClientFunctionAsync("getPlayerInventory"):andThen(function(result)
	local response = result:CallServerAsync(Players.LocalPlayer):andThen(function(inv)
		print(TS.array_toString(inv.contents));
	end):catch(function(excep)
		return print(excep);
	end);
end);
