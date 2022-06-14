local debound = false
local wait = task.wait
local garden = workspace.currentGarden
local players = game.Players

--getDoors will return a Gate's CFrame that matches the recieved door nane,
function getDoors(doorName)
	local found = false
	for i,v in pairs(workspace.Doors.Gate:GetChildren()) do
		local temp = v:GetAttribute("DoorName")
		if temp == doorName then
			found = true
			return v.CFrame
		end
	end
	if found == false then
		return false
	end
end

--This is the main loop that detects when the player hits a door
while wait() do
	for i,v in pairs(workspace.Doors:GetChildren()) do
		if v:IsA("Part") then
			v.Touched:Connect(function(hit)
				if debound == false then --Only run if not debound
					debound = true
					local player = game.Players:GetPlayerFromCharacter(hit.Parent)
					if player then
						garden.Value = "loading"
						print("Teleporting...")
						wait(1)
						local doorName = v:GetAttribute("DoorName")
						if doorName then
							local goal = getDoors(doorName)
							if goal then
								hit.Parent.HumanoidRootPart.CFrame = goal
								garden.Value = doorName
								wait(1)
								debound = false
							end
						end
					else
						debound = false
					end
				end
			end)
		end
	end
end