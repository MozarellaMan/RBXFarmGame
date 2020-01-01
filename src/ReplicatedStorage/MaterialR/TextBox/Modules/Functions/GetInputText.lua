return function(ui)
	return function()
		return ui:WaitForChild("InputFrame"):WaitForChild("InputBox").Text
	end
end