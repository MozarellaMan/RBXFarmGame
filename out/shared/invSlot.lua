-- Compiled with https://roblox-ts.github.io v0.3.2
-- April 28, 2020, 2:29 PM British Summer Time

local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"));
local exports = {};
local InventorySlot;
local Empty = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "item").Empty;
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
		if item ~= Empty then
			self:checkState();
		end;
	end;
	function InventorySlot:addItem(item, amount)
		if amount == nil then amount = 1; end;
		local newState;
		if (item.maxAmount >= self.size) and (self.state == "occupied") then
			newState = "full";
		else
			if self.currentItem == item then
				newState = "occupied";
			else
				newState = "empty";
			end;
		end;
		local _0 = self.state;
		repeat
			if _0 == "empty" then
				local changedSize;
				if (self.size + amount) < item.maxAmount then
					changedSize = self.size + amount;
				else
					changedSize = item.maxAmount;
				end;
				return InventorySlot.new(item, changedSize);
			end;
			if _0 == "occupied" then
				local maxItemAmount = self.currentItem.maxAmount;
				local sumSize = self.size + amount;
				local itemsMatch = item == self.currentItem;
				local newSize;
				if itemsMatch and (sumSize < self.currentItem.maxAmount) then
					newSize = sumSize;
				else
					newSize = maxItemAmount;
				end;
				local _2 = self.currentItem;
				local _1;
				if self.size == maxItemAmount then
					_1 = 'full';
				else
					_1 = 'occupied';
				end;
				return InventorySlot.new(_2, newSize, _1);
			end;
			if _0 == "full" then
				return TS.Object_copy(self);
			end;
		until true;
	end;
	function InventorySlot:checkState()
		if (self.currentItem ~= Empty) and ((self.currentItem.maxAmount >= self.size) and (self.state == 'occupied')) then
			self.state = 'full';
		else
			if self.size <= 0 then
				self.state = 'empty';
			else
				self.state = 'occupied';
			end;
		end;
	end;
	function InventorySlot:isEmpty()
		return self.state == 'empty';
	end;
	function InventorySlot:isFull()
		return self.state == 'full';
	end;
end;
exports.InventorySlot = InventorySlot;
return exports;
