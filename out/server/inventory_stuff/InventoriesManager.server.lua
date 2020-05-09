-- Compiled with https://roblox-ts.github.io v0.3.2
-- May 9, 2020, 8:03 PM British Summer Time

local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"));
local Players = TS.import(script, TS.getModule(script, "services")).Players;
local Inventory = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "inventory", "inventory").Inventory;
local Net = TS.import(script, TS.getModule(script, "net").out);
local ItemIndex = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "inventory", "item").ItemIndex;
local t = TS.import(script, TS.getModule(script, "t").lib.ts);
local DataStore2 = TS.import(script, TS.getModule(script, "datastore2").src);
local Inventories = {};
local inventoryChanged = Net.CreateEvent("inventoryChanged");
local addItemToPlayer = Net.ServerEvent.new("addItemToPlayer", t.string, t.number);
local removeItemFromPlayer = Net.ServerEvent.new("removeItemFromPlayer", t.string, t.number);
local getPlayerInventory = Net.ServerAsyncFunction.new("getPlayerInventory");
Players.PlayerAdded:Connect(TS.async(function(player)
	local activeSlotVal = Instance.new("IntValue");
	activeSlotVal.Value = -1;
	activeSlotVal.Name = "activeSlot";
	activeSlotVal.Parent = player;
	local invStore = DataStore2("inventory", player);
	local storeInv = invStore:GetTable(Inventory.new(player):exportData());
	invStore:OnUpdate(function()
		return inventoryChanged:SendToPlayer(player);
	end);
	invStore:AfterSave(function(inv)
		return print("Done saving!", inv);
	end);
	Inventories[player] = Inventory.new(player, storeInv);
	inventoryChanged:SendToPlayer(player);
end));
addItemToPlayer:Connect(function(player, itemID, amount)
	local itemToAdd = ItemIndex[itemID];
	local invStore = DataStore2("inventory", player);
	local inventoryToAffect = Inventories[player];
	if itemToAdd and inventoryToAffect then
		inventoryToAffect:addItem(itemToAdd, amount):andThen(invStore:Set(inventoryToAffect:exportData())):catch(function(excep)
			return print(excep);
		end);
	end;
end);
removeItemFromPlayer:Connect(function(player, itemID, amount)
	local itemToRemove = ItemIndex[itemID];
	local invStore = DataStore2("inventory", player);
	local inventoryToAffect = Inventories[player];
	if itemToRemove and inventoryToAffect then
		inventoryToAffect:takeItem(itemToRemove, amount):andThen(invStore:Set(inventoryToAffect:exportData())):catch(function(excep)
			return print(excep);
		end);
	end;
end);
getPlayerInventory:SetCallback(function(player)
	return TS.Promise.new(function(resolve, reject)
		if Inventories[player] == nil then
			reject("inventory does not exist!");
		else
			resolve(Inventories[player]);
		end;
	end);
end);
