--Define the player and the chao's Data
local chaoData = script.Parent.Name
local chaoModule = require(game.ReplicatedStorage.PublicDependancies.ChaoModule)

game.Players.PlayerAdded:Connect(function(player)
	repeat
		wait()
	until script.Parent == workspace
	while wait() do
		if workspace.currentGarden.Value == "Garden" then
			if player.Leaderstats:FindFirstChild(chaoData) then
				if not workspace.currentGarden.Value == "Lobby" and player.Leaderstats[chaoData].canAge == true then
					player.Leaderstats[chaoData].Age.Value += 0.00055
					player.Leaderstats[chaoData].Hunger.Value -= 0.001
					if player.Leaderstats[chaoData].Age.Value >= 1 and script.Parent.Held == false and player.Leaderstats[chaoData].Ability == "Child" then
						-- chaoModule
						chaoModule:Evo(player.Leaderstats[chaoData],script.Parent,player)
					elseif player.Leaderstats[chaoData].Age.Value >= 4 and script.Parent.Held == false then
						if player.Leaderstats[chaoData].Happiness.Value >= 50 then
							--Pink Cocoon (Rebirth)
							chaoModule:Rebirth(player.Leaderstats[chaoData],script.Parent,player)
						else
							--White cocoon (death)
							game.ReplicatedStorage.Remotes.RemoveChao:Fire(player.Leaderstats[chaoData],script.Parent,player)
						end
					end
				end
			end
		end
	end
end)