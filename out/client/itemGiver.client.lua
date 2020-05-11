-- Compiled with https://roblox-ts.github.io v0.3.2
-- May 11, 2020, 2:03 PM British Summer Time

local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"));
local Net = TS.import(script, TS.getModule(script, "net").out);
local Workspace = TS.import(script, TS.getModule(script, "services")).Workspace;
local buttons = { Workspace:WaitForChild("ItemGiverPart"), Workspace:WaitForChild("ItemGiverPart2"), Workspace:WaitForChild("ItemGiverPart3") };
TS.array_forEach(buttons, function(button, i)
	button.ClickDetector.MouseClick:Connect(function()
		local addItemToPlayer = Net.WaitForClientEventAsync("addItemToPlayer"):andThen(function(event)
			local _0 = i;
			repeat
				if _0 == 0 then
					event:SendToServer("brd", 3);
					break;
				end;
				if _0 == 1 then
					event:SendToServer("dia", 2);
					break;
				end;
				if _0 == 2 then
					event:SendToServer("rck", 8);
					break;
				end;
			until true;
		end):catch(function(excep)
			return print(excep);
		end);
	end);
	button.ClickDetector.RightMouseClick:Connect(function()
		local removeItemFromPlayer = Net.WaitForClientEventAsync("removeItemFromPlayer"):andThen(function(event)
			local _0 = i;
			repeat
				if _0 == 0 then
					event:SendToServer("brd", 9);
					break;
				end;
				if _0 == 1 then
					event:SendToServer("dia", 5);
					break;
				end;
				if _0 == 2 then
					event:SendToServer("rck", 1);
					break;
				end;
			until true;
		end):catch(function(excep)
			return print(excep);
		end);
	end);
end);
