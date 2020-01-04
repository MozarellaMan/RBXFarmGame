local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rocrastinate = require(ReplicatedStorage:WaitForChild("Rocrastinate"))
local repr = require(ReplicatedStorage:WaitForChild("Repr"))
local SectionsString = require(ReplicatedStorage.SectionsTextLableModule)
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local InvSlotClickEvent = ReplicatedStorage.BindableEvents:WaitForChild("InvSlotClicked")
local Player = game.Players.LocalPlayer

local tweenInfo = TweenInfo.new(
	0.1, -- Time
	Enum.EasingStyle.Linear, -- EasingStyle
	Enum.EasingDirection.Out, -- EasingDirection
	0, -- RepeatCount (when less than zero the tween will loop indefinitely)
	false, -- Reverses (tween will reverse once reaching it's goal)
	0 -- DelayTime
)

local ItemSlotComp = Rocrastinate.Component:extend()

function ItemSlotComp:constructor(parent, props)
	self.parent = parent
	self.ItemName = "none"
	self.text =  "empty"
	self.isEmpty = true
	self.index = props.index
	self.indexLabel = props.index
	local keys = {"0","-","="}
	if(self.index >=10 and self.index <= 12) then
		local index = self.index
		self.indexLabel = keys[(((index - 10) * (3 - 1)) / (12 - 10)) + 1] -- show 0 to = sign on hotbar
	end
	if(next(props.item) ~= nil) then
		local item = props.item[next(props.item)]
		self.isEmpty = false
		self.Amount = item.Amount
		self.ItemName = item.ItemData.Name
		self.Type = item.ItemData.ItemClass
	end
	self.selected = false;
	self.onClick = (function() 
		InvSlotClickEvent:Fire(self.indexLabel)
		self.queueRedraw()
	end)
	
	self.hovered = false
	self.onHover = (function() 
			self.hovered = true 
			self.queueRedraw()
	end)
	
	self.onHoverEnd = (function () 
		self.hovered = false
		self.queueRedraw()
	end)
	
end

ItemSlotComp.RedrawBinding = "Heartbeat"

function ItemSlotComp:Redraw()
	if not self.gui then
		self.gui = script.ItemSlotTemplate:Clone()
		self.gui.LayoutOrder = self.index
		
		
	  	self.slotLabel =  Instance.new("TextLabel", self.gui)
        self.slotLabel.Position = UDim2.new(0,0,-0.17,0)
        self.slotLabel.Size = UDim2.new(0,100,0,17)
		self.slotLabel.BackgroundTransparency = 1
		self.slotLabel.TextColor3 = Color3.new(255,255,255)
		self.slotLabel.TextStrokeTransparency = 0
		self.slotLabel.Text = self.indexLabel

		self.maid:GiveTask(
			self.gui,
			self.slotLabel,
			SectionsString.SetTextLable(self.gui.ItemInfo),
			self.gui.MouseButton1Click:Connect(function() self.onClick() end),
			self.gui.MouseEnter:Connect(function () self.onHover() end),
			self.gui.SelectionGained:Connect(function () self.onHover() end),
			self.gui.MouseLeave:Connect(function () self.onHoverEnd() end),
			self.gui.SelectionLost:Connect(function () self.onHoverEnd() end)
		)
		
		self.gui.Parent = self.parent
		--print(self.gui.Parent)
	end
	for k,v in pairs(self.gui.ItemInfo:GetChildren()) do
		if(v:IsA("TextLabel")) then
			self.maid:Cleanup(v)
		end
	end
	
	if self.isEmpty then
		self.gui.ItemInfo.Text = ""
	else
		local label = self.gui.ItemInfo
		label.Text = SectionsString.new(label, {Text = self.ItemName})
			.. SectionsString.new(label, {Text = "x" .. self.Amount, Font = "SourceSansLight"})
			.. SectionsString.new(label, {Text = self.Type, TextColor3 = Color3.fromRGB(255,129,19)})
		
	end
	
	local active = self.selected or self.hovered
	if self.renderActive ~= active then
		self.renderActive = active
		if active then
			TweenService:Create(
				self.gui,
				tweenInfo,
				{BorderColor3 = Color3.fromRGB(255,87,21)}
			):Play()
		else
			TweenService:Create(
				self.gui,
				tweenInfo,
				{BorderColor3 = Color3.fromRGB(131,66,13)}
			):Play()
		end
	end
end

function ItemSlotComp:SetSelected(selected)
	if selected ~= self.selected then
		self.selected = selected
		self.queueRedraw()
	end
end

function ItemSlotComp:GetLabel()
	return self.indexLabel
end

function ItemSlotComp:IsSelected()
	return self.selected
end


return ItemSlotComp
