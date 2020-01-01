local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rocrastinate = require(ReplicatedStorage:WaitForChild("Rocrastinate"))
local repr = require(ReplicatedStorage:WaitForChild("Repr"))
local SectionsString = require(ReplicatedStorage.SectionsTextLableModule)

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
		self.indexLabel = keys[(((index - 10) * (3 - 1)) / (12 - 10)) + 1]
	end
	if(next(props.item) ~= nil) then
		local item = props.item[next(props.item)]
		self.isEmpty = false
		self.Amount = item.Amount
		self.ItemName = item.ItemData.Name
		self.Type = item.ItemData.ItemClass
	end
	self.onClick = function() print(self.ItemName .. " clicked!") end
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
		
		print(repr(self.props))
		self.maid:GiveTask(
			self.gui,
			self.slotLabel,
			self.gui.MouseButton1Click:Connect(function() self.onClick() end)	
		)
		
		self.gui.Parent = self.parent
		--print(self.gui.Parent)
	end
	
	if self.isEmpty then
		self.gui.ItemInfo.Text = ""
	else
		local label = self.gui.ItemInfo
		SectionsString.SetTextLable(label)
		label.Text = SectionsString.new(label, {Text = self.ItemName})
			.. SectionsString.new(label, {Text = "x" .. self.Amount, Font = "SourceSansLight"})
			.. SectionsString.new(label, {Text = self.Type, TextColor3 = Color3.fromRGB(255,129,19)})
	end
end



return ItemSlotComp
