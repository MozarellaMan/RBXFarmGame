local connection

return function(ui, bindable)
	if connection then connection:Disconnect() end
	
	local origSize = ui:WaitForChild("TextButton"):WaitForChild("TextLabel").TextSize
	
	
	connection = ui.TextButton.MouseButton1Click:Connect(function()
		--[[_G.services.TweenService:Create(
			ui.TextButton.TextLabel,
			TweenInfo.new(1/30, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true),
			{TextSize = origSize + 3}
		):Play()]]
		
		spawn(function()
			local clone = ui.TextButton.Popout:Clone()
			clone.Parent = ui.TextButton
			
			local tween = _G.services.TweenService:Create(
				clone,
				TweenInfo.new(1/10),
				{Size = clone.Size + UDim2.new(0, 3, 0, 3)}
			)
			tween:Play()
			tween.Completed:Wait()
			clone:Destroy()
		end)
		
		bindable:Fire()
	end)
end