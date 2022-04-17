local classroomService = require(game.ReplicatedStorage.PublicDependancies.Classroom)
local logTime

game.Players.PlayersAdded:Connect(function(player)
	if player then
		local lastLogTime = player.Leaderstats.lastLogTime
		logTime = lastLogTime
		if os.time() >= lastLogTime.Value + 14400 then
			classroomService:ChangeClass()
		end
		while wait() do
			if os.time() >= logTime then
				logTime = os.time()
				classroomService:ChangeClass()
			end
		end
	end
end)