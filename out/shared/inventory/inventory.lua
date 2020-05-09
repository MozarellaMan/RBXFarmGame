-- Compiled with https://roblox-ts.github.io v0.3.2
-- May 9, 2020, 7:45 PM British Summer Time

local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"));
local exports = {};
local InventorySlot = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "inventory", "invSlot").InventorySlot;
local Inventory;
do
	Inventory = setmetatable({}, {
		__tostring = function() return "Inventory" end;
	});
	Inventory.__index = Inventory;
	function Inventory.new(...)
		local self = setmetatable({}, Inventory);
		self:constructor(...);
		return self;
	end;
	function Inventory:constructor(owner, data)
		self.findItemSlot = function(item)
			return TS.Promise.new(function(resolve, reject)
				local resultIndexes = TS.array_filter(TS.array_map(self.contents, function(slot, i)
					if (slot.currentItem == item) and (not (slot:isEmpty())) then
						return i;
					else
						return -1;
					end;
				end), function(index)
					return index ~= -1;
				end);
				local index = resultIndexes[#resultIndexes - 1 + 1];
				local _0;
				if #resultIndexes < 1 then
					_0 = reject("Item not in inventory!");
				else
					_0 = resolve(index);
				end;
				local _ = _0;
			end);
		end;
		self.owner = owner;
		if data then
			self.maxSize = data.maxSize;
		else
			self.maxSize = 12;
		end;
		if data then
			self.size = data.size;
		else
			self.size = 0;
		end;
		if data then
			self.contents = TS.array_map(data.contents, function(slotData)
				return InventorySlot.new(slotData);
			end);
		else
			self.contents = table.create(self.maxSize, InventorySlot.new());
		end;
	end;
	function Inventory:freeItemSlotExists(item)
		return (table.find(TS.array_map(TS.array_filter(self.contents, function(slot)
			local _0 = not (slot:isEmpty());
			return _0 and not (slot:isFull());
		end), function(slot)
			return slot.currentItem;
		end), item) ~= nil);
	end;
	function Inventory:itemExists(item)
		return (table.find(TS.array_map(TS.array_filter(self.contents, function(slot)
			return not (slot:isEmpty());
		end), function(slot)
			return slot.currentItem;
		end), item) ~= nil);
	end;
	function Inventory:addItem(item, amount)
		if amount == nil then amount = 1; end;
		return TS.Promise.new(function(resolve, reject)
			local itemExists = self:freeItemSlotExists(item);
			local emptySlotIndex = TS.array_findIndex(self.contents, function(slot)
				return slot:isEmpty();
			end);
			if itemExists then
				local existingItemSlot = TS.array_findIndex(self.contents, function(slot)
					local _0 = slot.currentItem == item;
					return _0 and not (slot:isFull());
				end);
				local _0 = existingItemSlot + 1;
				if _0 ~= 0 and _0 == _0 and _0 then
					self.contents = TS.array_map(self.contents, function(slot, index)
						if index ~= existingItemSlot then
							return slot;
						else
							return slot:addItem(item, amount);
						end;
					end);
				else
				end;
				local _1;
				local _2 = existingItemSlot + 1;
				if _2 ~= 0 and _2 == _2 and _2 then
					_1 = resolve(item);
				else
					_1 = reject("Item does not exist!");
				end;
				local _ = _1;
			end;
			if not (itemExists) then
				if emptySlotIndex == -1 then
					reject("No space left in inventory!");
				else
					self.contents = TS.array_map(self.contents, function(slot, index)
						if index ~= emptySlotIndex then
							return slot;
						else
							return slot:addItem(item, amount);
						end;
					end);
					resolve(item);
				end;
			end;
		end);
	end;
	function Inventory:takeItem(item, amount)
		if amount == nil then amount = 1; end;
		return TS.Promise.new(TS.async(function(resolve, reject)
			local itemExists = self:itemExists(item);
			if itemExists then
				local itemSlot = TS.await(self.findItemSlot(item));
				self.contents = TS.array_map(self.contents, function(slot, index)
					if index ~= itemSlot then
						return slot;
					else
						return slot:removeItem(item, amount);
					end;
				end);
				resolve(item);
			else
				reject("Item does not exist!");
			end;
		end));
	end;
	function Inventory:exportData()
		local invData = {
			contents = TS.array_map(self.contents, function(slot)
				return slot:exportData();
			end);
			maxSize = self.maxSize;
			size = self.size;
		};
		return invData;
	end;
end;
exports.Inventory = Inventory;
return exports;
