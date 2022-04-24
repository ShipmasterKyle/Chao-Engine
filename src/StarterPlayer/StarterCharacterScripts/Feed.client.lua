--Checks when the player gives a Chao a drive

--Prevents the same even from firing forever.
local debound = false
--The remote event that the chao drive handler uses.
local remote = game.ReplicatedStorage.Remotes.Eat
--Get ClassService
local classService = require(game.ReplicatedStorage.PublicDependancies.ClassService)
math.randomseed(tick())
--Get the player
local plr = game.Players.LocalPlayer
local wait = task.wait

--run the function forever without crashing.
while wait() do
	for i,v in pairs(workspace:GetChildren()) do
		local myClass = classService:GetItemsClass(v.Name)
		if myClass == "Drive" then
			if debound == false then
				debound = true
				if v.Name == "FlyDrive" then
					v.Touched:Connect(function(hit)
						if hit:FindFirstChild("Held") then
							remote:FireServer("Fly",math.random(3,6),plr.Leaderstats[hit.Parent.Name],"Drive",v)
						end
					end)
				end
				if v.Name == "PowerDrive" then
					v.Touched:Connect(function(hit)
						if hit.Parent:FindFirstChild("Held") then
							remote:FireServer("Power",math.random(3,6),plr.Leaderstats[hit.Parent.Name],"Drive",v)
						end
					end)
				end
				if v.Name == "RunDrive" then
					v.Touched:Connect(function(hit)
						if hit.Parent:FindFirstChild("Held") then
							remote:FireServer("Run",math.random(3,6),plr.Leaderstats[hit.Parent.Name],"Drive",v)
						end
					end)
				end
				if v.Name == "SwimDrive" then
					v.Touched:Connect(function(hit)
						if hit.Parent:FindFirstChild("Held") then
							remote:FireServer("Swim",math.random(3,6),plr.Leaderstats[hit.Parent.Name],"Drive",v)
						end
					end)
				end
				debound = false
			end
		end
		if myClass == "Food" then
			if debound == false then
				debound = true
				if v.Name == "Garden Fruit" then
					v.Touched:Connect(function(hit)
						if hit.Parent:FindFirstChild("Held") then
							remote:FireServer("Stamina",math.random(3,10),plr.Leaderstats[hit.Parent.Name],"Fruit",v)
						end
					end)
				elseif v.Name == "Square Fruit" then
					v.Touched:Connect(function(hit)
						if hit.Parent:FindFirstChild("Held") then
							remote:FireServer("Stamina",math.random(3,10),plr.Leaderstats[hit.Parent.Name],"Fruit",v)
						end
					end)
				end
			end
		end
	end
end