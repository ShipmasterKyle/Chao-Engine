local eve = game.ReplicatedStorage.SaveData

function sleep(plr,chao)
	plr.Leaderstats[chao].isSleeping.Value = true
	repeat
		--Process takes about 15 minutes
		wait(9)
		plr.Leaderstats[chao].Energy.Value += 1
	until plr.Leaderstats[chao].Energy.Value == 100
    plr.Leaderstats[chao].isSleeping.Value = false
end

local chargeChao = coroutine.wrap(sleep)

local function sick(plr,chao,sickness)
	plr.Leaderstats[chao].Condition.Value = sickness
end

eve.OnServerEvent:Connect(function(plr,task,chao,data)
    if task == "Sleep" then
        chargeChao(plr,chao.Name)
    end
	if task == "Sick" then 
		sick(plr,chao.Name,data)
	end
end)