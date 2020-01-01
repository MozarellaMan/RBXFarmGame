local connection

return function(ui, bindable)
	if connection then connection:Disconnect() end
	
	connection = ui:WaitForChild("Switch"):WaitForChild("Circle"):GetPropertyChangedSignal("Position"):Connect(function()
		bindable:Fire()
	end)
end