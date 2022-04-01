local module = require(game.ReplicatedStorage.PublicDependancies.ChaoModule)
local garden = workspace.currentGarden

game.Players.PlayerAdded:Connect(function(player)
	garden.Value = "none"
	wait(2)
	if module then
		wait(2)
		local chaodata = player:WaitForChild("ChaoData")
		module.spawnChao(chaodata)
	end
end)