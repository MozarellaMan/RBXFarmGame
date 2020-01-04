local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rocrastinate = require(ReplicatedStorage:WaitForChild("Rocrastinate"))
local InventoryDisplay = Rocrastinate.Component:extend()
local MaterialR = require(ReplicatedStorage:WaitForChild("MaterialR"))
local repr = require(ReplicatedStorage:WaitForChild("Repr"))
local itemSlotGUI = require(ReplicatedStorage:WaitForChild("ItemSlotComp"))

function InventoryDisplay:constructor(store, parent)
    self.store = store
    self.parent = parent
	self.slots = {}
end

InventoryDisplay.Reduction = {
    inventory = ''
}

InventoryDisplay.RedrawBinding = "Heartbeat"

function InventoryDisplay:Redraw( reducedState )
    if not self.gui then
		self.gui = script.InventoryTemplate:Clone()
        self.gui.Frame.BackgroundTransparency = 1
        self.gui.Parent = self.parent
		self.maid:GiveTask(
			self.gui
		)
    end

    if(reducedState.inventory ~= nil) then
        --print(repr(reducedState.inventory, {pretty=true}))
		for i = 0, #self.slots do
			if self.slots[i] then
				self.maid:Cleanup(self.slots[i])
			end
		end

        for i, slot in pairs(reducedState.inventory.Contents) do
			local slot = self.maid:GiveTask(itemSlotGUI.new(self.gui.Frame, {index = i, item = slot}))
			self.slots[i] = slot
        end
    end
end

return InventoryDisplay