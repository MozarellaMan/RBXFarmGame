-- Compiled with https://roblox-ts.github.io v0.3.2
-- May 2, 2020, 11:13 AM British Summer Time

local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"));
local exports = {};
local InventorySlot;
local Empty = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "inventory", "item").Empty;
do
	InventorySlot = setmetatable({}, {
		__tostring = function() return "InventorySlot" end;
	});
	InventorySlot.__index = InventorySlot;
	function InventorySlot.new(...)
		local self = setmetatable({}, InventorySlot);
		self:constructor(...);
		return self;
	end;
	function InventorySlot:constructor(item, size, state)
		if item == nil then item = Empty; end;
		if size == nil then size = 0; end;
		if state == nil then state = "empty"; end;
		self.currentItem = item;
		self.size = size;
		self.state = state;
	end;
	function InventorySlot:addItem(item, amount)
		if amount == nil then amount = 1; end;
		local _0 = self.state;
		repeat
			if _0 == "empty" then
				local changedSize;
				if self.size + amount < item.maxAmount then
					changedSize = self.size + amount;
				else
					changedSize = item.maxAmount;
				end;
				return InventorySlot.new(item, changedSize, "occupied");
			end;
			local _1 = false;
			if _0 == "occupied" then
				local maxItemAmount = self.currentItem.maxAmount;
				local sumSize = self.size + amount;
				local itemsMatch = item == self.currentItem;
				if itemsMatch then
					local newSize;
					if sumSize < self.currentItem.maxAmount then
						newSize = sumSize;
					else
						newSize = maxItemAmount;
					end;
					if newSize >= maxItemAmount then
						return InventorySlot.new(item, maxItemAmount, "full");
					else
						return InventorySlot.new(item, newSize, "occupied");
					end;
				else
					return TS.Object_copy(self);
				end;
				_1 = true;
			end;
			if _1 or _0 == "full" then
				return TS.Object_copy(self);
			end;
		until true;
	end;
	function InventorySlot:removeItem(item, amount)
		if amount == nil then amount = 1; end;
		local _0 = self.state;
		repeat
			if _0 == "empty" then
				return self:makeEmpty();
			end;
			if _0 == "full" or _0 == "occupied" then
				local changedSize;
				if self.size - amount > 0 then
					changedSize = self.size - amount;
				else
					changedSize = 0;
				end;
				if changedSize > 0 then
					return InventorySlot.new(item, changedSize, "occupied");
				else
					return self:makeEmpty();
				end;
			end;
		until true;
	end;
	function InventorySlot:isEmpty()
		return self.state == "empty";
	end;
	function InventorySlot:isFull()
		return self.state == "full";
	end;
	function InventorySlot:makeEmpty()
		return InventorySlot.new(Empty, 0, "empty");
	end;
end;
exports.InventorySlot = InventorySlot;
return exports;
