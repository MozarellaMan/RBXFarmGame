local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rocrastinate = require(ReplicatedStorage:WaitForChild("Rocrastinate"))
local InventoryDisplay = Rocrastinate.Component:extend()
local MaterialR = require(ReplicatedStorage:WaitForChild("MaterialR"))
local repr = require(ReplicatedStorage:WaitForChild("Repr"))

function InventoryDisplay:constructor(store, parent)
    self.store = store
    self.parent = parent
end

InventoryDisplay.Reduction = {
    inventory = ''
}

InventoryDisplay.RedrawBinding = "Heartbeat"

function InventoryDisplay:Redraw( reducedState )
    if not self.gui then
        self.gui = self.maid:GiveTask(script.InventoryTemplate:Clone())
        self.gui.Parent = self.parent
    end

    if(reducedState.inventory ~= nil) then
        --print(repr(reducedState.inventory, {pretty=true}))
        for _, instance in pairs(self.gui.Frame:GetDescendants()) do
            if instance:IsA("Frame") then
                instance:Destroy()
            end
        end
        local count = 0
        
        --print(reducedState.inventory.MaxSize)
        for i = 1, reducedState.inventory.MaxSize do
            local ItemContainer = Instance.new("Frame")
            ItemContainer.Parent = self.gui.Frame
            ItemContainer.Name = "Slot" .. i
            local SlotLabel =  Instance.new("TextLabel")
            SlotLabel.Position = UDim2.new(0,0,-0.17,0)
            SlotLabel.Text = "Slot" .. i
            SlotLabel.Size = UDim2.new(0,100,0,17)
            SlotLabel.Parent = ItemContainer
            count = count+1
        end

        for i, item in pairs(reducedState.inventory.Contents) do
            if(i ~= "" or i ~=  nil) then 
                local TextBox = MaterialR:Get("TextButton")
                TextBox.AnchorPoint = Vector2.new(.5, .5)
                TextBox.Size = UDim2.new(0, 100, 0, 100)
                TextBox.Theme = "Light"
                TextBox.Text =  i .. "\nx" .. item.Amount .. "\n" .. item.Content.ItemClass
                TextBox.Parent = self.gui.Frame:WaitForChild("Slot" .. item.Slot)
            end
        end
    end
end

return InventoryDisplay