-- Compiled with https://roblox-ts.github.io v0.3.2
-- May 11, 2020, 6:10 PM British Summer Time

local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"));
local Roact = TS.import(script, TS.getModule(script, "roact").roact.src);
local Net = TS.import(script, TS.getModule(script, "net").out);
local InventoryGui = TS.import(script, script.Parent, "Components", "InventoryHotbarComp").InventoryGui;
local hotbarSelectEvent = TS.import(script, script.Parent.Parent, "InventoryController", "hotbarSelectEvent").hotbarSelectEvent;
local Players = game:GetService("Players");
local handle;
local ActiveSlot = Players.LocalPlayer:WaitForChild("activeSlot");
local InventoryCache;
local PlayerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui");
local getInventory = function()
	return TS.Promise.new(function(resolve, reject)
		local getInventory = Net.ClientAsyncFunction.new("getPlayerInventory");
		getInventory:CallServerAsync(Players.LocalPlayer):andThen(function(result)
			InventoryCache = result;
			resolve(result);
		end):catch(function(err)
			return reject(err);
		end);
	end);
end;
local mountInventoryGUI = TS.async(function()
	local playerinventory = TS.await(getInventory():catch(function()
		return InventoryCache;
	end));
	local inventoryElement = Roact.createElement(
		InventoryGui,
		{
			contents = playerinventory.contents,
			activeSlot = ActiveSlot,
		}
	);
	if handle then
		Roact.unmount(handle);
	end;
	handle = Roact.mount(inventoryElement, PlayerGui, "Inventory");
end);
local updateInventoryGUI = TS.async(function()
	local playerinventory = TS.await(getInventory():catch(function()
		return InventoryCache;
	end));
	local inventoryElement = Roact.createElement(
		InventoryGui,
		{
			contents = playerinventory.contents,
			activeSlot = ActiveSlot,
		}
	);
	handle = Roact.update(handle, inventoryElement);
end);
local updateInventory = Net.WaitForClientEventAsync("inventoryChanged"):andThen(function(event)
	event:Connect(function()
		mountInventoryGUI();
	end);
end);
hotbarSelectEvent:bind(function()
	updateInventoryGUI();
end);
