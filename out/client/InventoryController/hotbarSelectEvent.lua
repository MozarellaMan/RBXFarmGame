-- Compiled with https://roblox-ts.github.io v0.3.2
-- May 11, 2020, 2:03 PM British Summer Time

local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"));
local exports = {};
local Cue = TS.import(script, TS.getModule(script, "cue"));
local hotbarSelectEvent = Cue.new();
exports.hotbarSelectEvent = hotbarSelectEvent;
return exports;
