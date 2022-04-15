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
		--Chao are happier when feed
		chaoModule.changeData("Hunger",-value,ChaoData)
		chaoModule.changeData("Happiness",1,ChaoData)
		--Since Shadow isn't in the game, we'll just always change it to positive. So they'll need to buy lots of dark fruit or mean to get a dark chao
		chaoModule.changeData("AbilityDirection",0.33,ChaoData)
	end
	if objClass == "Wisp" then
		chaoModule.changeStat(stat,value,chaoData)
	end
	--Play Anim and Sound
	wait(0.2)
	obj:Destroy()
end)