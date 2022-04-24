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
                    chaoModule.changeData("AbilityDirection",0.33,chaoData)
                    obj.Size -= Vector3.new(1,1,1)
                    if obj.Size = Vector3.new(1,2,1) then
                        chaoModule.changeStat(stat,value+2,chaoData)
                        --Chao are happier when feed
                        chaoModule.changeData("Hunger",-value-2,chaoData)
                        chaoModule.changeData("Energy",-3,chaoData)
                        chaoModule.changeData("Happiness",2,chaoData)
                    end
                wait(1)
                if obj.Size = Vector3.new(1,2,1) then
                    obj:Destroy()
                end
            end
        end
    end
end)