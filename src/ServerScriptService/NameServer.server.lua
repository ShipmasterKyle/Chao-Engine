local event = game.ReplicatedStorage.Remotes.FinishName
local nameve = game.ReplicatedStorage.Remotes.NameChao
local namespace = require(game.ReplicatedStorage.PublicDependancies.NameSpaceService)

--Just pickup the event
event.OnServerEvent:Connect(function(name,chao,player)
    print("Request Caught")
	namespace:FinalizeName(name,chao,player)
	event:FireClient(name)
end)

nameve.OnServerEvent:Connect(function(name,chao,player)
	print("Request Caught")
	namespace:FinalizeName(name,chao,player)
	event:FireClient(name)
end)