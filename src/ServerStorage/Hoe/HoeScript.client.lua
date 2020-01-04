local hoe = script.Parent
hoe.RequiresHandle = false
local mouse = game.Players.LocalPlayer:GetMouse()
local TweenService = game:GetService("TweenService")
local gridSize = 2
moving = false

function onActivation()
	if mouse.Target and mouse.Target.Parent then
		local part = mouse.Target
		mouse.TargetFilter = part;
		moving = true
        mouse.Move:Connect(function() move(part) end)
		
	end
end

function move(part)
	if(part.Parent and moving) then
		part = part.Parent.PrimaryPart
		local X  = math.floor(mouse.Hit.X / gridSize + 0.5) * gridSize
		local Y = part.position.Y
		local Z = math.floor(mouse.Hit.Z / gridSize + 0.5) * gridSize
		local tweeninf = TweenInfo.new(0.1)
		local goal = {}
		goal.CFrame = CFrame.new(X, Y,Z)
		local tween = TweenService:Create(part, tweeninf, goal)
		tween:play()
	end
end

function onDeactivation()
	
	if mouse.Target and mouse.Target.Parent then
		local part = mouse.Target
		mouse.TargetFilter = part;
		if(part.Parent:isA("Model")) then
			moving = false
		end
	end
end

hoe.Activated:Connect(onActivation)
hoe.Deactivated:Connect(onDeactivation)
hoe.Unequipped:Connect(onDeactivation)