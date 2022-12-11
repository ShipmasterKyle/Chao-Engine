local event = game.ReplicatedStorage.Remotes.FinishName
local nameve = game.ReplicatedStorage.Remotes.NameChao
local namespace = require(game.ReplicatedStorage.PublicDependancies.NameSpaceService)

function dprint(text,i)
    if workspace.Debug.Value == true or i then
        print(text)
    end
end

--Just pickup the event
event.OnServerEvent:Connect(function(name,chao,player)
    dprint("Request Caught")
	namespace:FinalizeName(name,chao,player)
	event:FireClient(name)
end)

nameve.OnServerEvent:Connect(function(name,chao,player)
	dprint("Request Caught")
	namespace:FinalizeName(name,chao,player)
	event:FireClient(name)
end)