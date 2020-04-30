-- Compiled with https://roblox-ts.github.io v0.3.2
-- April 30, 2020, 8:31 PM British Summer Time

local exports = {};
local Items = { {
	name = "Rock";
	maxAmount = 100;
	rarity = "common";
	class = "material";
	cost = 10;
}, {
	name = "Diamond";
	maxAmount = 30;
	rarity = "rare";
	class = "material";
	cost = 3000;
}, {
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
