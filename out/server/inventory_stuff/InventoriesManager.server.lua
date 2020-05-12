-- Compiled with https://roblox-ts.github.io v0.3.2
-- May 12, 2020, 10:13 AM British Summer Time

local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"));
local _0 = TS.import(script, TS.getModule(script, "services"));
local Players, ServerStorage = _0.Players, _0.ServerStorage;
local Inventory = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "inventory", "inventory").Inventory;
local Net = TS.import(script, TS.getModule(script, "net").out);
local ItemIndex = TS.import(script, game:GetService("ServerStorage"), "TS", "item").ItemIndex;
local t = TS.import(script, TS.getModule(script, "t").lib.ts);
local DataStore2 = TS.import(script, TS.getModule(script, "datastore2").src);
local Inventories = {};
local inventoryChanged = Net.CreateEvent("inventoryChanged");
local addItemToPlayer = Net.ServerEvent.new("addItemToPlayer", t.string, t.number);
local equipItemToPlayer = Net.ServerEvent.new("equipItemToPlayer", t.number);
local dequipItemsFromPlayer = Net.ServerEvent.new("dequipItemsFromPlayer");
local removeItemFromPlayer = Net.ServerEvent.new("removeItemFromPlayer", t.string, t.number);
local getPlayerInventory = Net.ServerAsyncFunction.new("getPlayerInventory");
local toolFolder = ServerStorage:WaitForChild("tools");
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
		return print("Done saving inventory!");
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
equipItemToPlayer:Connect(function(player, invSlotNum)
	if not (Inventories[player].contents[invSlotNum + 1]:isEmpty()) then
		local itemId = Inventories[player].contents[invSlotNum + 1].currentItem.id;
		print(player.Name .. " wants to equip " .. Inventories[player].contents[invSlotNum + 1].currentItem.name .. "!");
		local humanoid = player.Character:FindFirstChildOfClass("Humanoid");
		local toolToEquip = toolFolder:FindFirstChild(itemId);
		if humanoid and toolToEquip then
			print("humanoid " .. tostring(humanoid) .. " and tool " .. toolToEquip.Name .. " exists!");
			local tool = toolToEquip:Clone();
			tool.Parent = player.Character;
			humanoid:EquipTool(tool);
		end;
	elseif Inventories[player].contents[invSlotNum + 1]:isEmpty() then
		local backpack = player:WaitForChild("Backpack");
		local humanoid = player.Character:FindFirstChildOfClass("Humanoid");
		if backpack and humanoid then
			humanoid:UnequipTools();
			backpack:ClearAllChildren();
		end;
	end;
end);
dequipItemsFromPlayer:Connect(function(player)
	local backpack = player:WaitForChild("Backpack");
	local humanoid = player.Character:FindFirstChildOfClass("Humanoid");
	if backpack and humanoid then
		humanoid:UnequipTools();
		backpack:ClearAllChildren();
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
