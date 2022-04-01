--Checks when the player gives a Chao a drive
local debound = false
local remote = game.ReplicatedStorage.Remotes.Eat
math.randomseed(tick())


while wait() do
	for i,v in pairs(workspace:GetChildren()) do
		if v:GetAttribute("Class") == "Drive" then
			if debound == false then
				debound = true
				if v.Name == "FlyDrive" then
					v.Touched:Connect(function(hit)
						if hit:FindFirstChild("Held") then
							remote:FireServer("Fly",math.random(3,6),game.Players.LocalPlayer.ChaoData,"Drive",v)
						end
					end)
				end
				if v.Name == "PowerDrive" then
					v.Touched:Connect(function(hit)
						if hit.Parent:FindFirstChild("Held") then
							remote:FireServer("Power",math.random(3,6),game.Players.LocalPlayer.ChaoData,"Drive",v)
						end
					end)
				end
				if v.Name == "RunDrive" then
					v.Touched:Connect(function(hit)
						if hit.Parent:FindFirstChild("Held") then
							remote:FireServer("Run",math.random(3,6),game.Players.LocalPlayer.ChaoData,"Drive",v)
						end
					end)
				end
				if v.Name == "SwimDrive" then
					v.Touched:Connect(function(hit)
						if hit.Parent:FindFirstChild("Held") then
							remote:FireServer("Swim",math.random(3,6),game.Players.LocalPlayer.ChaoData,"Drive",v)
						end
					end)
				end
				debound = false
			end
		end
		if v:GetAttribute("Class") == "Fruit" then
			if debound == false then
				debound = true
				if v.Name == "SkillsFruit" then
					v.Touched:Connect(function(hit)
						if hit.Parent:FindFirstChild("Held") then
							remote:FireServer("Skill",math.random(3,10),game.Players.LocalPlayer.ChaoData,"Fruit",v)
						end
					end)
				end
			end
		end
	end
end