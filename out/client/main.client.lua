-- Compiled with https://roblox-ts.github.io v0.3.2
-- April 28, 2020, 2:29 PM British Summer Time

local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"));
local makeHello = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "module").makeHello;
print(makeHello("main.client.ts"));
