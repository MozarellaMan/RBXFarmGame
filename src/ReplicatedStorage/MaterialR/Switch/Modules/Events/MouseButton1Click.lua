local connection

local Disabled, dColor = UDim2.new(0, 3, 0.5, 0), Color3.fromRGB(129, 129, 129)
local Enabled, eColor = UDim2.new(0.64, -3, 0.5, 0), Color3.fromRGB(143, 63, 193)

local function toggle(ui)
	if ui:WaitForChild("Switch").ImageColor3 == dColor then
		ui:WaitForChild("Switch"):WaitForChild("Circle"):TweenPosition(Enabled, "Out", "Quint", .3, true)
		ui:WaitForChild("Switch").ImageColor3 = eColor
	else
		ui:WaitForChild("Switch").ImageColor3 = dColor
		ui:WaitForChild("Switch"):WaitForChild("Circle"):TweenPosition(Disabled, "In", "Quint", .3, true)
	end
end

return function(ui, bindable)
	if connection then connection:Disconnect() end
	
	connection = ui:WaitForChild("Switch"):WaitForChild("Circle").MouseButton1Click:Connect(function()
		toggle(ui)
		bindable:Fire()
	end)
	connection = ui:WaitForChild("Switch").MouseButton1Click:Connect(function()
		toggle(ui)
		bindable:Fire()
	end)
end