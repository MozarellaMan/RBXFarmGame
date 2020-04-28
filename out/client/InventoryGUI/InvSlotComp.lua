-- Compiled with https://roblox-ts.github.io v0.3.2
-- April 28, 2020, 10:44 PM British Summer Time

local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"));
local exports = {};
local Roact = TS.import(script, TS.getModule(script, "roact").roact.src);
local InvSlot;
do
	InvSlot = Roact.PureComponent:extend("InvSlot");
	function InvSlot:init(props)
		self:setState({
			active = true;
			selected = false;
			hovered = false;
		});
	end;
	function InvSlot:render()
		local _0 = self.state;
		local active = _0.active;
		local selected = _0.selected;
		local hovered = _0.hovered;
						local _1;
						if hovered then
							_1 = 5;
						else
							_1 = 1;
						end;
		return Roact.createElement(
			"Frame",
			{
				LayoutOrder = self.props.order,
				Size = UDim2.new(0, 50, 0, 50),
			},
			{
				["TimeLabel"] = Roact.createElement(
					"TextButton",
					{
						Size = UDim2.new(1, 0, 1, 0),
						Text = self.props.itemName .. " \n " .. tostring(self.props.amount),
						[Roact.Event.MouseEnter] = function(rbx)
							return self:setState({
								hovered = true;
							});
						end,
						[Roact.Event.MouseLeave] = function(rbx)
							return self:setState({
								hovered = false;
							});
						end,
						BorderSizePixel = _1,
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
