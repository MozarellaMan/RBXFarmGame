-- Variables
local uiFramework = {}
local cachedEvents = {}
_G.services = setmetatable({}, {__index = function(cache, serviceName)
	assert(pcall(game.GetService, game, serviceName), "game:GetService(\""..serviceName.."\") failed!")
	local service = game:GetService(serviceName)
	cache[serviceName] = service
	return service
end})

-- Helper Function
local function assertWithWarn(condition, warnMessage)
	if not condition then
		warn("[UIFramework]: "..warnMessage)
	end
	
	return condition
end

local function getSecondToLastIndex(pathStart, pathString)
	local path = pathString:split(".")
	if #path == 1 then return pathStart end
	
	for i = 1, #path do
		if i ~= #path then
			pathStart = pathStart[path[i]]
		end
	end

	return pathStart
end

-- Library
function uiFramework:Get(uiType)
	if not assertWithWarn(typeof(uiType) == "string", script.Name..":Get(string uiType)") then return end
	if not assertWithWarn(script:FindFirstChild(uiType), "There is no uiType named "..uiType) then return end
	
	local newObject = script[uiType]:Clone()
	local showedUI
	
	local objectTable, objectMetatable = {}, {}
	setmetatable(objectTable, objectMetatable)
	
	-- Setting the events
	local function setEvents()
		if not newObject.Modules:FindFirstChild("Events") then return end
		
		for _, eventModule in next, newObject.Modules.Events:GetChildren() do
			if not cachedEvents[eventModule.Name] then
				local bindable = Instance.new("BindableEvent")
				rawset(objectTable, eventModule.Name, bindable.Event)
				cachedEvents[eventModule.Name] = bindable
			end
			
			require(eventModule)(showedUI, cachedEvents[eventModule.Name])
		end
	end
	
	-- Setting the enums
	local function setEnums()
		if not newObject.Modules:FindFirstChild("Enums") then return end
		
		for _, enumModule in next, newObject.Modules.Enums:GetChildren() do
			rawset(objectTable, enumModule.Name, require(enumModule))
		end
	end
	
	-- Setting the functions
	local function setFunctions()
		if not newObject.Modules:FindFirstChild("Functions") then return end
		
		for _, functionModule in next, newObject.Modules.Functions:GetChildren() do
			rawset(objectTable, functionModule.Name, require(functionModule)(showedUI))
		end
	end
	
	-- Updating to properties
	local function updateToProperties()
		for _, propertyModule in next, newObject.Modules.Properties:GetChildren() do
			local propertyInfo = require(propertyModule)
			
			if propertyInfo.Path and not propertyInfo.UseUIDefault then
				local path = propertyInfo.Path:split(".")
				getSecondToLastIndex(showedUI, propertyInfo.Path)[path[#path]] = propertyInfo.CurrentValue or propertyInfo.DefaultValue
			end
		end
	end
	
	-- Setting the metatable
	function objectMetatable.__index(tbl, propertyName)
		assert(newObject.Modules.Properties:FindFirstChild(propertyName), propertyName.." is not a valid member of "..uiType)
		local propertyInfo = require(newObject.Modules.Properties:FindFirstChild(propertyName))
		
		if not propertyInfo.Path and propertyInfo.CurrentValue then
			return propertyInfo.CurrentValue
		else
			local path = propertyInfo.Path:split(".")
			return getSecondToLastIndex(showedUI, propertyInfo.Path)[path[#path]]
		end
	end
	
	function objectMetatable.__newindex(tbl, propertyName, propertyValue)
		assert(newObject.Modules.Properties:FindFirstChild(propertyName), propertyName.." is not a valid member of "..uiType)
		local propertyInfo = require(newObject.Modules.Properties:FindFirstChild(propertyName))
		
		if propertyName == "Theme" then -- Reload the ui
			assert(typeof(propertyValue) == "string" and newObject.UI:FindFirstChild(propertyValue), tostring(propertyValue).." is not a valid theme for "..uiType)
			
			local lastParent
			if showedUI then 
				lastParent = showedUI.Parent
				showedUI:Destroy() 
			end
			
			showedUI = newObject.UI[propertyValue]:Clone()
			updateToProperties()
			showedUI.Parent = lastParent
			setEvents()
			setEnums()
			setFunctions()
		else
			if propertyInfo.Path then
				local path = propertyInfo.Path:split(".")
				getSecondToLastIndex(showedUI, propertyInfo.Path)[path[#path]] = propertyValue
			end
			
			if propertyInfo.CurrentValue then
				propertyInfo.CurrentValue = propertyValue
			
				if propertyInfo.Changed then
					propertyInfo.Changed(propertyValue)
				end
			end
		end
	end

	-- Initializing the object
	showedUI = objectTable.Theme and newObject.UI[objectTable.Theme]:Clone() or newObject.UI:Clone()
	updateToProperties()
	setEvents()
	setEnums()
	setFunctions()
	
	-- Setting ut the properties
	for _, propertyModule in next, newObject.Modules.Properties:GetChildren() do
		local propertyInfo = require(propertyModule)
		
		if not propertyInfo.CurrentValue then
			propertyInfo.CurrentValue = propertyInfo.DefaultValue
			
			if propertyInfo.Path then
				local path = propertyInfo.Path:split(".")
				
				getSecondToLastIndex(showedUI, propertyInfo.Path):GetPropertyChangedSignal(path[#path]):Connect(function()
					propertyInfo.CurrentValue = getSecondToLastIndex(showedUI, propertyInfo.Path)[path[#path]]
				end)
			end
		end
	end

	return objectTable
end

--
return uiFramework