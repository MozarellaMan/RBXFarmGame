local CommunicationService = {}
local mc = require(script.ModuleComponents)
local Events = Instance.new("Folder")
Events.Name = "RemoteEvents"
Events.Parent = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

function CommunicationService:new(name)
	mc:params({"string"}, {name}, 0)

	local RemoteEvent = Instance.new("RemoteEvent")
	RemoteEvent.Name = name or "RemoteEvent_" .. #Events:GetChildren()
	RemoteEvent.Parent = Events
	
	return RemoteEvent
end

function CommunicationService:connect(name, doWait, func)
	mc:params({"string", "boolean","function"}, {name, doWait, func}, 3)
	local RemoteEvent = doWait and Events:WaitForChild(name) or Events:FindFirstChild(name)
	
	if RemoteEvent then
		if RunService:IsServer() then
			return RemoteEvent.OnServerEvent:Connect(func)
		else
			return RemoteEvent.OnClientEvent:Connect(func)
		end
	else
		return mc:errorf("The event, %s, doesn't exist!", name)
	end
end

function CommunicationService:fire(name, doWait, player, ...)
	mc:params({"string", "boolean"}, {name, doWait}, 2)
	local RemoteEvent = doWait and Events:WaitForChild(name) or Events:FindFirstChild(name)

	if RemoteEvent then
		if RunService:IsServer() then
			if typeof(player) == "Instance" and player:IsA("Player") then
				RemoteEvent:FireClient(player, ...)
			elseif typeof(player) == "string" and string.lower(player) == "all" then
				RemoteEvent:FireAllClients(...)
			else
				mc:errorf("%s needs to be a Player Instance or a string which specifies \"All\"")
			end
		else
			RemoteEvent:FireServer(player, ...)
		end
	else
		return mc:errorf("The event, %s, doesn't exist!", name)
	end
end

return CommunicationService
