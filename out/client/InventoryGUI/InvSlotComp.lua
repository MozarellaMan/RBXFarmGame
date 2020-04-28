-- Compiled with https://roblox-ts.github.io v0.3.2
-- April 28, 2020, 8:14 PM British Summer Time

local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"));
local exports = {};
local Roact = TS.import(script, TS.getModule(script, "roact").roact.src);
local InvSlot;
do
	InvSlot = Roact.Component:extend("InvSlot");
	function InvSlot:init(props)
		self:setState({
			active = true;
			selected = false;
		});
	end;
	function InvSlot:render()
		local _0 = self.state;
		local active = _0.active;
		local selected = _0.selected;
		return Roact.createElement(
			"Frame",
			{
				Size = UDim2.new(0, 50, 0, 50),
			},
			{
				["TimeLabel"] = Roact.createElement(
					"TextButton",
					{
						Size = UDim2.new(1, 0, 1, 0),
						Text = self.props.itemName .. " \n " .. tostring(self.props.amount),
					}
				),
			}
		);
	end;
	function InvSlot:didMount()
	end;
	function InvSlot:willUnmount()
	end;
end;
exports.InvSlot = InvSlot;
return exports;
