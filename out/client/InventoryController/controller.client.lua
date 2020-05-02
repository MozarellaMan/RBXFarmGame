-- Compiled with https://roblox-ts.github.io v0.3.2
-- May 2, 2020, 11:13 AM British Summer Time

local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"));
local _0 = TS.import(script, TS.getModule(script, "services"));
local Players, UserInputService = _0.Players, _0.UserInputService;
local hotbarSelectEvent = TS.import(script, script.Parent, "hotbarSelectEvent").hotbarSelectEvent;
local activeSlot = Players.LocalPlayer:WaitForChild("activeSlot");
local hotbarInputCodes = TS.array_concat(TS.array_map(table.create(9, 0), function(_, indx)
	return 49 + indx;
end), { 48, 45, 61 });
local changeActiveSlot = function(input)
	if input.UserInputType == Enum.UserInputType.Keyboard then
		local keyPressed = input.KeyCode.Value;
		if table.find(hotbarInputCodes, keyPressed) ~= nil then
			local hotbarNum = (table.find(hotbarInputCodes, keyPressed) or 0) - 1;
			if hotbarNum == activeSlot.Value then
				activeSlot.Value = -1;
			else
				activeSlot.Value = hotbarNum;
			end;
			hotbarSelectEvent:go();
		end;
	end;
end;
UserInputService.InputBegan:Connect(function(input)
	changeActiveSlot(input);
end);
