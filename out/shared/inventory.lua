-- Compiled with https://roblox-ts.github.io v0.3.1
-- April 11, 2020, 10:51 PM British Summer Time

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
		self.contents = TS.array_map(self.contents, function(slot, index)
			if index ~= emptySlotIndex then
				return slot;
			else
				return slot:addItem(item);
			end;
		end);
	end;
end;
exports.Inventory = Inventory;
return exports;
