local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rocrastinate = require(ReplicatedStorage:WaitForChild("Rocrastinate"))
local InventoryDisplay = Rocrastinate.Component:extend()
local MaterialR = require(ReplicatedStorage:WaitForChild("MaterialR"))

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
        local count = 0
        for i, item in pairs(reducedState.inventory)do
            print("gui!")
            print("Name:" .. i .. "\nAmount: " .. item.Amount .. "\nType: " .. item.Content.ItemClass)
    
            local ItemContainer = Instance.new("Frame")
            ItemContainer.Name = "Item" .. count
            ItemContainer.Parent = self.gui.Frame
            local TextBox = MaterialR:Get("TextButton")
            TextBox.AnchorPoint = Vector2.new(.5, .5)
            TextBox.Size = UDim2.new(0, 100, 0, 100)
            TextBox.Theme = "Light"
            TextBox.Text = "Name:" .. i --.. "\nAmount: " .. item.Amount .. "\nType: " .. item.Content.ItemClass
            TextBox.Parent = self.gui.Frame:WaitForChild("Item" .. count)
            count = count+1
        end
    end

    
end

return InventoryDisplay