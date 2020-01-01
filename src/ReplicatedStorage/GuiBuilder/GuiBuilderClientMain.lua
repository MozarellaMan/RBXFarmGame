local CollectionService = game:GetService("CollectionService")
local GuiActionInfo = require(game.ReplicatedStorage.GuiBuilder.GuiActionInfo)

function delimitInputActionString(inputActionString)
	local event, action = inputActionString:match("([^,]+),([^,]+)")
	return event, action
end

local function createArgDictionary(inputActionContainerChildren)
	local t = {}
	local c = inputActionContainerChildren
	for i, v in ipairs(c) do
		t[v.Name] = v.Value
	end
	return t
end

local GuiBuilderMain = {}
GuiBuilderMain.__index = GuiBuilderMain

function GuiBuilderMain.new()
	local instance = setmetatable({}, GuiBuilderMain)
	
	repeat wait() until game.Players.LocalPlayer.Character
	
	local assignedElementsOld = CollectionService:GetTagged("ActionAssignedElement")
	for i, v in pairs(assignedElementsOld) do
		if not v:IsDescendantOf(game.Players.LocalPlayer) then
			CollectionService:RemoveTag(v, "ActionAssignedElement")
		end
	end
	
	local assignedElements = CollectionService:GetTagged("ActionAssignedElement")
	for _, element in pairs(assignedElements) do
		for _, inputActionContainer in pairs(element:GetChildren()) do
			if inputActionContainer:IsA("Folder") then
				local event, funcName = delimitInputActionString(inputActionContainer.Name)
				local inputActionContainerChildren = inputActionContainer:GetChildren()
				element[event]:connect(function(...)
					GuiActionInfo[funcName].func(createArgDictionary(inputActionContainerChildren), {...})
				end)
				inputActionContainer:Destroy()
			end
		end
	end
	
	return instance
end

return GuiBuilderMain.new()
