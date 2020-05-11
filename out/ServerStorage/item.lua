-- Compiled with https://roblox-ts.github.io v0.3.2
-- May 11, 2020, 2:03 PM British Summer Time

local exports = {};
local ItemClass;
do
	local _0 = {};
	ItemClass = setmetatable({}, { __index = _0 });
	ItemClass.Resource = 0;
	_0[0] = "Resource";
	ItemClass.Food = 1;
	_0[1] = "Food";
	ItemClass.Tool = 2;
	_0[2] = "Tool";
	ItemClass.Seed = 3;
	_0[3] = "Seed";
	ItemClass.Furniture = 4;
	_0[4] = "Furniture";
	ItemClass.Empty = 5;
	_0[5] = "Empty";
end;
local ItemRarity;
do
	local _0 = {};
	ItemRarity = setmetatable({}, { __index = _0 });
	ItemRarity.Common = 0;
	_0[0] = "Common";
	ItemRarity.Uncommon = 1;
	_0[1] = "Uncommon";
	ItemRarity.Rare = 2;
	_0[2] = "Rare";
	ItemRarity.Legendary = 3;
	_0[3] = "Legendary";
	ItemRarity.Exotic = 4;
	_0[4] = "Exotic";
	ItemRarity.None = 5;
	_0[5] = "None";
end;
local ItemIndex = {
	["rck"] = {
		id = "rck";
		name = "Rock";
		maxAmount = 100;
		rarity = ItemRarity.Common;
		class = ItemClass.Resource;
		cost = 10;
	};
	["dia"] = {
		id = "dia";
		name = "Diamond";
		maxAmount = 30;
		rarity = ItemRarity.Legendary;
		class = ItemClass.Resource;
		cost = 3000;
	};
	["brd"] = {
		id = "brd";
		name = "Bread";
		maxAmount = 10;
		rarity = ItemRarity.Uncommon;
		class = ItemClass.Food;
		cost = 100;
	};
	["waxe"] = {
		id = "waxe";
		name = "Wooden Axe";
		maxAmount = 1;
		rarity = ItemRarity.Common;
		class = ItemClass.Tool;
		cost = 20;
	};
	["wlog"] = {
		id = "wlog";
		name = "Wood";
		maxAmount = 100;
		rarity = ItemRarity.Common;
		class = ItemClass.Resource;
		cost = 10;
	};
};
local Empty = {
	id = "emp";
	name = "Empty";
	maxAmount = 1;
	rarity = ItemRarity.None;
	class = ItemClass.Empty;
	cost = 0;
};
exports.ItemIndex = ItemIndex;
exports.Empty = Empty;
return exports;
