local remote = game.ReplicatedStorage.Remotes.Eat
local chaoModule = require(game.ReplicatedStorage.PublicDependancies.ChaoModule)

remote.OnServerEvent:Connect(function(stat,value,chaoData,objClass,obj)
	print("fired!")
	print(objClass)
	if objClass == "Drive" then
		chaoModule.changeStat(stat,value,chaoData)
	end
	if objClass == "Fruit" then
		chaoModule.changeStat(stat,value,chaoData)
	end
	if objClass == "Wisp" then
		chaoModule.changeStat(stat,value,chaoData)
	end
	--Play Anim and Sound
	wait(0.2)
	obj:Destroy()
end)