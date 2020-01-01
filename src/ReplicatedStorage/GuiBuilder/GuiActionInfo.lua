local GuiActionInfo = {
	ShowElement = {
		name = "string", 
		elementToShow = "instance",
		delayTime = "number",
		["func"] = function(args)
			if args.delayTime and args.delayTime > 0 then wait(args.delayTime) end
			args.elementToShow.Visible = true
		end
	},
	HideElement = {
		name = "string",
		delayTime = "number", 
		elementToHide = "instance",
		["func"] = function(args)
			if args.delayTime and args.delayTime > 0 then wait(args.delayTime) end
			args.elementToHide.Visible = false
		end
	},
	ToggleElementVisibility = {
		name = "string",
		delayTime = "number",  
		elementToToggle = "instance",
		["func"] = function(args)
			if args.delayTime and args.delayTime > 0 then wait(args.delayTime) end
			args.elementToToggle.Visible = not args.elementToToggle.Visible
		end
	},
	SetSize = {
		name = "string",
		delayTime = "number", 
		Element = "instance",
		["xScale"] = "number",
		["xOffset"] = "number",
		["yScale"] = "number",
		["yOffset"] = "number",
		["func"] = function(args)
			if args.delayTime and args.delayTime > 0 then wait(args.delayTime) end
			args.Element.Size = UDim2.new(args.xScale, args.xOffset, args.yScale, args.yOffset)
		end
	},
	SetPosition = {
		name = "string",
		delayTime = "number", 
		Element = "instance",
		xScale = "number",
		xOffset = "number",
		yScale = "number",
		yOffset = "number",
		["func"] = function(args)
			if args.delayTime and args.delayTime > 0 then wait(args.delayTime) end
			args.Element.Position = UDim2.new(args.xScale, args.xOffset, args.yScale, args.yOffset)
		end
	},
	SetNumberProperty = {
		name = "string",
		delayTime = "number", 
		Element = "instance",
		property = "string",
		value = "number",
		["func"] = function(args)
			if args.delayTime and args.delayTime > 0 then wait(args.delayTime) end
			args.Element[args.property] = args.value
		end
	},
	SetBooleanProperty = {
		name = "string",
		delayTime = "number", 
		Element = "instance",
		property = "string",
		value = "boolean",
		["func"] = function(args)
			if args.delayTime and args.delayTime > 0 then wait(args.delayTime) end
			args.Element[args.property] = args.value
		end
	},
	TweenSize = {
		name = "string",
		ElementToTween = "instance",
		EasingStyle = "string",
		EasingDirection = "string",
		RepeatCount = "number",
		DelayTime = "number",
		["Time"] = "number",
		["xScale"] = "number",
		["xOffset"] = "number",
		["yScale"] = "number",
		["yOffset"] = "number",
		["func"] = function(args)
			local tween = game:GetService("TweenService"):Create(
				args.ElementToTween, 
				TweenInfo.new(
					args.Time, 
					Enum.EasingStyle[args.EasingStyle], 
					Enum.EasingDirection[args.EasingDirection],
					args.RepeatCount,
					false,
					args.DelayTime
				),
				{Size = UDim2.new(args.xScale, args.xOffset, args.yScale, args.yOffset)}
			)
			tween:Play()
		end
	},
	TweenPosition = {
		name = "string",
		ElementToTween = "instance",
		EasingStyle = "string",
		EasingDirection = "string",
		RepeatCount = "number",
		DelayTime = "number",
		["Time"] = "number",
		["xScale"] = "number",
		["xOffset"] = "number",
		["yScale"] = "number",
		["yOffset"] = "number",
		["func"] = function(args)
			local tween = game:GetService("TweenService"):Create(
				args.ElementToTween, 
				TweenInfo.new(
					args.Time, 
					Enum.EasingStyle[args.EasingStyle], 
					Enum.EasingDirection[args.EasingDirection],
					args.RepeatCount,
					false,
					args.DelayTime
				),
				{Position = UDim2.new(args.xScale, args.xOffset, args.yScale, args.yOffset)}
			)
			tween:Play()
		end
	},
	SetBackgroundColor3 = {
		name = "string",
		Element = "instance",
		delayTime = "number", 
		R = "number",
		G = "number",
		B = "number",
		["func"] = function(args)
			if args.delayTime and args.delayTime > 0 then wait(args.delayTime) end
			args.Element.BackgroundColor3 = Color3.fromRGB(args.R, args.G, args.B)
		end
	},
	SetText = {
		name = "string",
		delayTime = "number", 
		Element = "instance",
		Text = "string",
		["func"] = function(args)
			if args.delayTime and args.delayTime > 0 then wait(args.delayTime) end
			if args.Element.Text then
				args.Element.Text = args.Text
			else
				error("GuiBuilder: SetText 'Element' must be set to a TextLabel, TextButton, or TextBox")
			end
		end
	},
	SetTextColor3 = {
		name = "string",
		Element = "instance",
		delayTime = "number", 
		R = "number",
		G = "number",
		B = "number",
		["func"] = function(args)
			if args.delayTime and args.delayTime > 0 then wait(args.delayTime) end
			if args.Element.Text then
				args.Element.TextColor3 = Color3.fromRGB(args.R, args.G, args.B)
			else
				error("GuiBuilder: SetTextColor3 'Element' must be set to a TextLabel, TextButton, or TextBox")
			end
		end
	},
	SetImage = {
		name = "string",
		Element = "instance",
		delayTime = "number", 
		AssetId = "number",
		["func"] = function(args)
			if args.delayTime and args.delayTime > 0 then wait(args.delayTime) end
			if args.Element.Image then
				args.Element.Image = "rbxassetid://".. tostring(args.AssetId)
			else
				error("GuiBuilder: SetImage 'Element' must be set to an ImageLabel or ImageButton")
			end
		end
	},
	SetImageColor3 = {
		name = "string",
		Element = "instance",
		delayTime = "number", 
		R = "number",
		G = "number",
		B = "number",
		["func"] = function(args)
			if args.delayTime and args.delayTime > 0 then wait(args.delayTime) end
			if args.Element.Image then
				args.Element.ImageColor3 = Color3.fromRGB(args.R, args.G, args.B)
			else
				error("GuiBuilder: SetImageColor3 'Element' must be set to an ImageLabel or ImageButton")
			end
		end
	},
}

return GuiActionInfo