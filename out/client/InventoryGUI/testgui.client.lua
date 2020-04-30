-- Compiled with https://roblox-ts.github.io v0.3.2
-- April 30, 2020, 11:22 AM British Summer Time

local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"));
local Roact = TS.import(script, TS.getModule(script, "roact").roact.src);
local InvSlot = TS.import(script, script.Parent, "InvSlotComp").InvSlot;
local Net = TS.import(script, TS.getModule(script, "net").out);
local Players = game:GetService("Players");
local handle;
local InventoryGui;
do
	InventoryGui = Roact.Component:extend("InventoryGui");
	function InventoryGui:init(props)
		self:setState({
			selectedSlot = -1;
		});
	end;
	function InventoryGui:render()
		return Roact.createElement(
			"ScreenGui",
			{},
			{
				Roact.createElement(
					"Frame",
					{
						Position = UDim2.new(0.1, 0, 0.9, -60),
						Size = UDim2.new(0, 1000, 0, 50),
						BackgroundTransparency = 1,
					},
					TS.Roact_combine(
						{
							Roact.createElement(
								"UIGridLayout",
								{
									CellSize = UDim2.new(0, 90, 0, 90),
									CellPadding = UDim2.new(0, 10, 0, 0),
									FillDirection = Enum.FillDirection.Vertical,
									SortOrder = Enum.SortOrder.LayoutOrder,
								}
							),
						},
						TS.array_map(self.props.contents, function(slot, i)
							return Roact.createFragment({ [i] = Roact.createElement(
								InvSlot,
								{
									order = i,
									itemName = slot.currentItem.name,
									amount = slot.size,
									onClick = function()
										local _1 = {};
										local _0;
										if self.state.selectedSlot == i then
											_0 = -1;
										else
											_0 = i;
										end;
										_1.selectedSlot = _0;
										return self:setState(_1);
									end,
									selected = self.state.selectedSlot == i,
								}
							) });
						end)
					)
				),
			}
		);
	end;
	function InventoryGui:didMount()
		self:setState({
			selectedSlot = self.props.activeSlot.Value;
		});
	end;
	function InventoryGui:willUnmount()
		self.props.activeSlot.Value = self.state.selectedSlot;
	end;
end;
local PlayerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui");
local updateInventory = Net.WaitForClientEventAsync("inventoryChanged"):andThen(function(event)
	event:Connect(function()
		local getInventory = Net.WaitForClientFunctionAsync("getPlayerInventory"):andThen(function(result)
			local response = result:CallServerAsync(Players.LocalPlayer):andThen(function(inv)
				local invContents = inv.contents;
				local activeSlot = Players.LocalPlayer:WaitForChild("activeSlot");
				local inventoryElement = Roact.createElement(
					InventoryGui,
					{
						contents = invContents,
						activeSlot = activeSlot,
					}
				);
				if handle then
					Roact.unmount(handle);
				end;
				handle = Roact.mount(inventoryElement, PlayerGui, "Inventory");
			end):catch(function(excep)
				return print(excep);
			end);
		end);
	end);
end);
