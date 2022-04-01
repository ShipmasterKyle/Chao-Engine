local UIService = require(game.ReplicatedStorage.PublicDependancies.UIService)
local chaoModule = require(game.ReplicatedStorage.PublicDependancies.ChaoModule)
local wait = task.wait

while wait(1) do
	if script.Parent.Held.Value == false then
		if script.Parent.HatchTime.Value <= 0 then
			chaoModule.Hatch(script.Parent)
		else
			script.Parent.HatchTime.Value -= 1
		end
	end
end