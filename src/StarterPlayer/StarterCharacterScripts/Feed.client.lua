--Checks when the player gives a Chao a drive

--Prevents the same even from firing forever.
local debound = false
--The remote event that the chao drive handler uses.
local remote = game.ReplicatedStorage.Remotes.Eat
--Get ClassService
local classService = require(game.ReplicatedStorage.PublicDependancies.ClassService)
math.randomseed(tick())
local wait = task.wait

--run the function forever without crashing.
while wait() do
	for i,v in pairs(workspace:GetChildren()) do
		local myClass = classService:GetItemsClass(v.ChaoClass)
		if myClass == "Drive" then
			if debound == false then
				debound = true
				if v.Name == "FlyDrive" then
					v.Touched:Connect(function(hit)
						if hit:FindFirstChild("Held") then
							remote:FireServer("Fly",math.random(3,6),v.Name,"Drive",v)
						end
					end)
				end
				if v.Name == "PowerDrive" then
					v.Touched:Connect(function(hit)
						if hit.Parent:FindFirstChild("Held") then
							remote:FireServer("Power",math.random(3,6),v.Name,"Drive",v)
						end
					end)
				end
				if v.Name == "RunDrive" then
					v.Touched:Connect(function(hit)
						if hit.Parent:FindFirstChild("Held") then
							remote:FireServer("Run",math.random(3,6),v.Name,"Drive",v)
						end
					end)
				end
				if v.Name == "SwimDrive" then
					v.Touched:Connect(function(hit)
						if hit.Parent:FindFirstChild("Held") then
							remote:FireServer("Swim",math.random(3,6),v.Name,"Drive",v)
						end
					end)
				end
				debound = false
			end
		end
		if myClass == "Fruit" then
			if debound == false then
				debound = true
				if v.Name == "SkillsFruit" then
					v.Touched:Connect(function(hit)
						if hit.Parent:FindFirstChild("Held") then
							remote:FireServer("Skill",math.random(3,10),v.Name,"Fruit",v)
						end
					end)
				end
			end
		end
	end
end