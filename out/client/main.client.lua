-- Compiled with https://roblox-ts.github.io v0.3.1
-- April 11, 2020, 7:21 PM British Summer Time

local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"));
local makeHello = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "module").makeHello;
print(makeHello("main.client.ts"));
