--Makes it so you can pick up your chao and throw it
local wait = task.wait
--dependancies
local UIService = require(game.ReplicatedStorage.PublicDependancies.UIService)
UIService:GenerateContextMenu("Pick",script.Parent,Enum.KeyCode.E,Enum.KeyCode.ButtonX,"Pick up your chao egg.")
UIService:UpdateContextMenu(script.Parent.Pick,"Name","Pickup")
local taps = 0
while wait(1) do
	if workspace.currentGarden.Value == "Garden" then
		UIService:UpdateContextMenu(script.Parent.Pickup,"Active",true)
		local pickupStatus = UIService:GetContextMenuProperty(script.Parent.Pickup,"Context")
		if script.Parent.Held.Value == false then
			if pickupStatus ~= "Pick" then
				UIService:UpdateContextMenu(script.Parent.Pickup,"Context","Pick")
				UIService:UpdateContextMenu(script.Parent.Pickup,"ObjectText","Pick up your chao egg.")
				taps += 1
				if taps >= 3 then
					script.Parent.Pickup.RequiresLineOfSight = true
				end
			end
		else
			if script.Parent.Parent.Parent:FindFirstChild("HumanoidRootPart") then
				taps = 0
				script.Parent.Pickup.RequiresLineOfSight = false
				local velo = script.Parent.Parent.HumanoidRootPart.Velocity.Magnitude
				print("Velocity: "..velo)--Actually print the velocity.
				if velo >= 2 then
					if pickupStatus ~= "Throw" then
						UIService:UpdateContextMenu(script.Parent.Pickup,"Context","Throw")
						UIService:UpdateContextMenu(script.Parent.Pickup,"ObjectText","Throw your chao egg.")				
					end
				else
					if pickupStatus ~= "Drop" then
						UIService:UpdateContextMenu(script.Parent.Pickup,"Context","Drop")
						UIService:UpdateContextMenu(script.Parent.Pickup,"ObjectText","Place your chao egg down.")				
					end
				end
			end
		end
	else
		UIService:UpdateContextMenu(script.Parent.Pickup,"Active",false)
	end
end