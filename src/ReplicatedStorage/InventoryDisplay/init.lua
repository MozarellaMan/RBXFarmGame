local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rocrastinate = require(ReplicatedStorage:WaitForChild("Rocrastinate"))
local InventoryDisplay = Rocrastinate.Component:extend()
local repr = require(ReplicatedStorage:WaitForChild("Repr"))
local itemSlotGUI = require(ReplicatedStorage:WaitForChild("ItemSlotComp"))
local UserInputService = game:GetService("UserInputService")
local CommunicationService = require(ReplicatedStorage:WaitForChild("CommunicationService"))
local InvSlotClickEvent = ReplicatedStorage.BindableEvents:WaitForChild("InvSlotClicked")


function InventoryDisplay:constructor(store, parent)
    self.store = store
    self.parent = parent
	self.slots = {}
	self.handleClick = (function(data)
		for i, slot in pairs(self.slots) do
			if(slot:IsSelected()) then
				slot:SetSelected(false)
			end
			if data == slot:GetLabel() then
				slot:SetSelected(true)
			end 
		end	
	end)
	self.handleInput = (function(input)
		if input.UserInputType == Enum.UserInputType.Keyboard and #self.slots > 0 and self.gui.Frame.Visible then
			local keyPressed = input.KeyCode.Value
			local isNumeric = keyPressed >= 48 and keyPressed <= 57
			local isEqualsAndMinus = keyPressed == 61 or keyPressed == 45
			if (isNumeric or isEqualsAndMinus) then
				for i, slot in pairs(self.slots) do
					if(slot:IsSelected()) then
						slot:SetSelected(false)
					end
					if keyPressed == string.byte(slot:GetLabel()) then
						slot:SetSelected(true)
					end 
				end	
			end
		end
	end)
	
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
			self.gui,
			UserInputService.InputBegan:Connect(function(input) self.handleInput(input) end),
			InvSlotClickEvent.Event:Connect(function(input) self.handleClick(input) end)
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