-- Compiled with https://roblox-ts.github.io v0.3.2
-- May 2, 2020, 11:13 AM British Summer Time

local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"));
local exports = {};
local Roact = TS.import(script, TS.getModule(script, "roact").roact.src);
local InvSlot = TS.import(script, script.Parent, "InvSlotComp").InvSlot;
local InventoryGui;
do
	InventoryGui = Roact.Component:extend("InventoryGui");
	function InventoryGui:init(props)
		self:setState({
			selectedSlot = self.props.activeSlot.Value;
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
										if self.props.activeSlot.Value == i then
											self.props.activeSlot.Value = -1;
										else
											self.props.activeSlot.Value = i;
										end;
										self:setState({
											selectedSlot = self.props.activeSlot.Value;
										});
									end,
									selected = self.props.activeSlot.Value == i,
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
end;
exports.InventoryGui = InventoryGui;
return exports;
