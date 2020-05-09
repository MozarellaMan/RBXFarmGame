-- Compiled with https://roblox-ts.github.io v0.3.2
-- May 9, 2020, 7:32 PM British Summer Time

local exports = {};
local Items = { {
	id = "rck";
	name = "Rock";
	maxAmount = 100;
	rarity = "common";
	class = "material";
	cost = 10;
}, {
	id = "dia";
	name = "Diamond";
	maxAmount = 30;
	rarity = "rare";
	class = "material";
	cost = 3000;
}, {
	id = "brd";
	name = "Bread";
	maxAmount = 10;
	rarity = "common";
	class = "food";
	cost = 100;
} };
local ItemIndex = {
	["rck"] = Items[1];
	["dia"] = Items[2];
	["brd"] = Items[3];
};
local Empty = {
	id = "emp";
	name = "Empty";
	maxAmount = 1;
	rarity = "";
	class = "";
	cost = 0;
};
exports.Items = Items;
exports.ItemIndex = ItemIndex;
exports.Empty = Empty;
return exports;
