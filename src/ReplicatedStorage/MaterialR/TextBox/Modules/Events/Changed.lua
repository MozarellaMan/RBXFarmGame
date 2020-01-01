local connection

return function(ui, bindable)
	if connection then connection:Disconnect() end
	
	connection = ui:WaitForChild("InputFrame"):WaitForChild("InputBox"):GetPropertyChangedSignal("Text"):Connect(function()
		bindable:Fire(ui.InputFrame.InputBox.Text)
	end)
end