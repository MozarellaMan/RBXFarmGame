-- Compiled with https://roblox-ts.github.io v0.3.2
-- April 30, 2020, 10:18 AM British Summer Time

local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"));
local makeHello = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "inventory", "module").makeHello;
print(makeHello("main.client.ts"));
