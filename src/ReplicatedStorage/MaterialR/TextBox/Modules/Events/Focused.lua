local connection

return function(ui, bindable)
	if connection then connection:Disconnect() end
	
	connection = ui:WaitForChild("InputFrame"):WaitForChild("InputBox").Focused:Connect(function()
		ui:WaitForChild("InputFrame"):WaitForChild("Outline"):WaitForChild("Outline2"):TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Quad", .1)
		ui:WaitForChild("InputFrame"):WaitForChild("PlaceholderLabel"):TweenSizeAndPosition(UDim2.new(0.978, 0, 0.347, 0), UDim2.new(0.512, 0, 0.273, 0), "Out", "Quad", .24)
		ui:WaitForChild("InputFrame"):WaitForChild("PlaceholderLabel").TextSize = 11
		ui:WaitForChild("InputFrame"):WaitForChild("PlaceholderLabel").TextYAlignment = "Top"
		bindable:Fire()
	end)
end