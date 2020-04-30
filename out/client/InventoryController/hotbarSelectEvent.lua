-- Compiled with https://roblox-ts.github.io v0.3.2
-- April 30, 2020, 8:31 PM British Summer Time

local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"));
local exports = {};
local Cue = TS.import(script, TS.getModule(script, "cue"));
local hotbarSelectEvent = Cue.new();
exports.hotbarSelectEvent = hotbarSelectEvent;
return exports;
