local connection

return function(ui, bindable)
	if connection then connection:Disconnect() end
	
	connection = ui:WaitForChild("InputFrame"):WaitForChild("InputBox").FocusLost:Connect(function()
		ui:WaitForChild("InputFrame"):WaitForChild("Outline"):WaitForChild("Outline2"):TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Quad", .1)
		bindable:Fire()
	end)
end