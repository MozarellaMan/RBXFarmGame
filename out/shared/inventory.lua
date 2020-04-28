-- Compiled with https://roblox-ts.github.io v0.3.2
-- April 28, 2020, 2:29 PM British Summer Time

local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"));
local exports = {};
local InventorySlot = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "invSlot").InventorySlot;
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
	function Inventory:constructor(owner)
		self.owner = owner;
		self.maxSize = 12;
		self.size = 0;
		self.contents = table.create(self.maxSize, InventorySlot.new());
	end;
	function Inventory:addItem(item)
		local itemExists = (table.find(TS.array_map(TS.array_filter(self.contents, function(slot)
			return not (slot:isEmpty());
		end), function(slot)
			return slot.currentItem;
		end), item) ~= nil);
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
						return slot:addItem(item);
					end;
				end);
			else
			end;
		end;
		if not (itemExists) then
			self.contents = TS.array_map(self.contents, function(slot, index)
				if index ~= emptySlotIndex then
					return slot;
				else
					return slot:addItem(item);
				end;
			end);
		end;
	end;
end;
exports.Inventory = Inventory;
return exports;
