local repr = require(script.Parent)

local t = {
	["Axes"] = Axes.new(Enum.Axis.X, Enum.NormalId.Top);
	["BrickColor"] = BrickColor.new("Really red");
	["CFrame"] = CFrame.new(1, 2, 3);
	["Color3"] = BrickColor.new("Really blue").Color;
	["ColorSequence"] = ColorSequence.new(BrickColor.new("Lime green").Color);
	["ColorSequenceKeypoint"] = ColorSequenceKeypoint.new(0.5, BrickColor.new("New Yeller").Color);
	["DockWidgetPluginGuiInfo"] = DockWidgetPluginGuiInfo.new();
	["Enum"] = Enum.ActionType;
	["EnumItem"] = Enum.ActionType.Draw;
	["Enums"] = Enum;
	["Faces"] = Faces.new(Enum.NormalId.Front, Enum.NormalId.Back);
	["NumberRange"] = NumberRange.new(0, 9001);
	["NumberSequence"] = NumberSequence.new(10);
	["NumberSequenceKeypoint"] = NumberSequenceKeypoint.new(0.5, 1337);
	["PathwayPoint"] = PathWaypoint.new(Vector3.new(1, 1, 1), Enum.PathWaypointAction.Walk);
	["PhysicalProperties"] = PhysicalProperties.new(Enum.Material.Brick);
	["Random"] = Random.new(7331);
	["Ray"] = Ray.new(Vector3.new(0, 0, 0), Vector3.new(0, 1, 0));
	["RBXScriptConnection"] = workspace.ChildAdded:Connect(function () end);
	["RBXScriptSignal"] = workspace.ChildAdded;
	["Rect"] = Rect.new(0, 0, 5, 5);
	["Region3"] = Region3.new(Vector3.new(-2, -2, -2), Vector3.new(2, 2, 2));
	["Region3int16"] = Region3int16.new(Vector3int16.new(-2, -2, -2), Vector3int16.new(2, 2, 2));
	["TweenInfo"] = TweenInfo.new();
	["UDim"] = UDim.new(1, -10);
	["UDim2"] = UDim2.new(1, -10, 1, -10);
	["Vector2"] = Vector2.new(3, 4);
	["Vector2int16"] = Vector2int16.new(3, 4);
	["Vector3"] = Vector3.new(3, 4, 5);
	["Vector3int16"] = Vector3int16.new(3, 4, 5);
}

local s = repr(t, {pretty=true;sortKeys=true})
print(s)
