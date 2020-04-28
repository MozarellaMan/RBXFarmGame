-- Compiled with https://roblox-ts.github.io v0.3.2
-- April 28, 2020, 5:46 PM British Summer Time

local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"));
local Net = TS.import(script, TS.getModule(script, "net").out);
local _0 = TS.import(script, TS.getModule(script, "services"));
local Workspace, Players = _0.Workspace, _0.Players;
local button = Workspace:WaitForChild("ItemGiverPart");
button.ClickDetector.MouseClick:Connect(function()
	local addItemToPlayer = Net.WaitForClientEventAsync("addItemToPlayer"):andThen(function(event)
		local localPlayer = Players.LocalPlayer;
		event:SendToServer("brd", 3);
	end):catch(function(excep)
		return print(excep);
	end);
end);
