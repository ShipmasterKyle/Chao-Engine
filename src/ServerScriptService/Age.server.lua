--Define the player and the chao's Data
local plr = game.Players.LocalPlayer
local chaoData = script.Parent.Name
local chaoModule = require(game.ReplicatedStorage.PublicDependancies.ChaoModule)

while wait() do
    if plr.Leaderstats:FindFirstChild(chaoData) then
        if not workspace.currentGarden.Value == "Lobby" then
            plr.Leaderstats[chaoData].Age.Value += 0.00055
            if plr.Leaderstats[chaoData].Age.Value >= 1 and script.Parent.Held == false and plr.Leaderstats[chaoData].Ability == "Child" then
                -- chaoModule
            end
        end
    end
end
