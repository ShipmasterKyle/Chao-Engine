local eve = game.ReplicatedStorage.Remotes.Eat

eve.OnServerEvent:Connect(function(stat,value,chaoData,objClass,obj)
    if obj == script.Parent then
        if obj.Parent:FindFirstChild("Held") then
            obj.Parent:SetAttribute("ChaoState","Eating") -->Set the chao state to eating.
            for count = 1,4 do
                if obj.Parent:FindFirstChild("Held") then
                    --For fruit this is recieved from Feed once.
                    chaoModule.changeStat(stat,value,chaoData)
                    --Chao are happier when feed
                    chaoModule.changeData("Hunger",-value,chaoData)
                    chaoModule.changeData("Energy",-3,chaoData)
                    chaoModule.changeData("Happiness",1,chaoData)
                    --Since Shadow isn't in the game, we'll just always change it to positive. So they'll need to buy lots of dark fruit or mean to get a dark chao
                    chaoModule.changeData("AbilityDirection",0.033,chaoData)
                    obj.Size -= Vector3.new(1,1,1)
                    if obj.Size = Vector3.new(1,2,1) then
                        chaoModule.changeStat(stat,value+2,chaoData)
                        --Chao are happier when feed
                        chaoModule.changeData("Hunger",-value-2,chaoData)
                        chaoModule.changeData("Energy",-3,chaoData)
                        chaoModule.changeData("Happiness",2,chaoData)
                    end
                --Make eating speed depenant on hunger
                if chaoData.Hunger.Value <= 10 then
                    wait(0.1)
                elseif chaoData.Hunger.Value <= 20 then
                    wait(0.15)
                elseif chaoData.Hunger.Value <= 30 then
                    wait(0.2)
                elseif chaoData.Hunger.Value <= 40 then
                    wait(0.4)
                elseif chaoData.Hunger.Value <= 50 then
                    wait(0.6)
                elseif chaoData.Hunger.Value <= 60 then
                    wait(0.75)
                elseif chaoData.Hunger.Value <= 70 then
                    wait(0.8)
                elseif chaoData.Hunger.Value <= 80 then
                    wait(1)
                elseif chaoData.Hunger.Value <= 90 then
                    wait(1.5)
                elseif chaoData.Hunger.Value <= 100 then
                    wait(2)     
                end
                if obj.Size = Vector3.new(1,2,1) then
                    obj:Destroy()
                    --Change state to sitting so that the chao 
                    obj.Parent:SetAttribute("ChaoState","Sitting")
                end
            end
        end
    end
end)