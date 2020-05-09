-- Compiled with https://roblox-ts.github.io v0.3.2
-- May 9, 2020, 7:43 PM British Summer Time

local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"));
local exports = {};
local InventorySlot;
local _0 = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "inventory", "item");
local EmptyItem, ItemIndex = _0.Empty, _0.ItemIndex;
local State;
do
	local _1 = {};
	State = setmetatable({}, { __index = _1 });
	State.Empty = 0;
	_1[0] = "Empty";
	State.Occupied = 1;
	_1[1] = "Occupied";
	State.Full = 2;
	_1[2] = "Full";
end;
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
	function InventorySlot:constructor(data, item, size, state)
		if item == nil then item = EmptyItem; end;
		if size == nil then size = 0; end;
		if state == nil then state = State.Empty; end;
		if data then
			if ItemIndex[data.item] then
				self.currentItem = ItemIndex[data.item];
			else
				self.currentItem = item;
			end;
		else
			self.currentItem = item;
		end;
		if data then
			self.size = data.size;
		else
			self.size = size;
		end;
		if data then
			self.state = data.state;
		else
			self.state = state;
		end;
	end;
	function InventorySlot:addItem(item, amount)
		if amount == nil then amount = 1; end;
		local _1 = self.state;
		repeat
			if _1 == State.Empty then
				local changedSize;
				if self.size + amount < item.maxAmount then
					changedSize = self.size + amount;
				else
					changedSize = item.maxAmount;
				end;
				return InventorySlot.new(nil, item, changedSize, State.Occupied);
			end;
			local _2 = false;
			if _1 == State.Occupied then
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
						return InventorySlot.new(nil, item, maxItemAmount, State.Full);
					else
						return InventorySlot.new(nil, item, newSize, State.Occupied);
					end;
				else
					return TS.Object_copy(self);
				end;
				_2 = true;
			end;
			if _2 or _1 == State.Full then
				return TS.Object_copy(self);
			end;
		until true;
	end;
	function InventorySlot:removeItem(item, amount)
		if amount == nil then amount = 1; end;
		local _1 = self.state;
		repeat
			if _1 == State.Empty then
				return self:makeEmpty();
			end;
			if _1 == State.Full or _1 == State.Occupied then
				local changedSize;
				if self.size - amount > 0 then
					changedSize = self.size - amount;
				else
					changedSize = 0;
				end;
				if changedSize > 0 then
					return InventorySlot.new(nil, item, changedSize, State.Occupied);
				else
					return self:makeEmpty();
				end;
			end;
		until true;
	end;
	function InventorySlot:isEmpty()
		return self.state == State.Empty;
	end;
	function InventorySlot:isFull()
		return self.state == State.Full;
	end;
	function InventorySlot:makeEmpty()
		return InventorySlot.new(nil, EmptyItem, 0, State.Empty);
	end;
	function InventorySlot:exportData()
		local slotData = {
			state = self.state;
			item = self.currentItem.id;
			size = self.size;
		};
		return slotData;
	end;
end;
exports.InventorySlot = InventorySlot;
return exports;
