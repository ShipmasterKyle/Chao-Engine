--[[
	AutoHatch
	Handles hatching the egg without shaking it.
]]

--Get Dependancies
local UIService = require(game.ReplicatedStorage.PublicDependancies.UIService)
local chaoModule = require(game.ReplicatedStorage.PublicDependancies.ChaoModule)
local wait = task.wait

--Runs every second
while wait(1) do
	if script.Parent.Held.Value == false then
		if script.Parent.HatchTime.Value <= 0 then
			if script.Parent:FindFirstChild("Identifier") then
				chaoModule.Hatch(script.Parent,true)
			else
				chaoModule.Hatch(script.Parent)
			end
		else
			script.Parent.HatchTime.Value -= 1
		end
	end
end