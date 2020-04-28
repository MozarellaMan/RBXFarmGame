-- Compiled with https://roblox-ts.github.io v0.3.2
-- April 28, 2020, 8:17 PM British Summer Time

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
				TS.Roact_combine(
					{
						Roact.createElement(
							"UIGridLayout",
							{
								FillDirection = Enum.FillDirection.Vertical,
							}
						),
					},
					TS.array_map(contents, function(slot, i)
						return Roact.createFragment({ [i] = Roact.createElement(
							InvSlot,
							{
								itemName = slot.currentItem.name,
								amount = slot.size,
							}
						) });
					end)
				)
			),
		}
	);
end;
local PlayerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui");
local getInventory = Net.WaitForClientFunctionAsync("getPlayerInventory"):andThen(function(result)
	local response = result:CallServerAsync(Players.LocalPlayer):andThen(function(inv)
		local invContents = inv.contents;
		local inventoryElement = Roact.createElement(
			InventoryGui,
			{
				contents = invContents,
			}
		);
		local handle = Roact.mount(inventoryElement, PlayerGui, "Inventory");
	end):catch(function(excep)
		return print(excep);
	end);
end);
