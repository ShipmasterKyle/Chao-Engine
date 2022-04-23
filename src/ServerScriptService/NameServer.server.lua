local event = game.ReplicatedStorage.Remotes.FinishName
local namespace = require(game.ReplicatedStorage.PublicDependancies.NameSpaceService)

--Just pickup the event since we're already
event.OnServerEvent:Connect(function(name,chao,player)
    print("Request Caught")
     namespace:FinalizeName(name,chao,player)
end)