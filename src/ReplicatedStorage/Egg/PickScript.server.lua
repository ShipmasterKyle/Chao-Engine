--Makes it so you can pick up the egg and throw it
local wait = task.wait
--dependancies
local UIService = require(game.ReplicatedStorage.PublicDependancies.UIService)
UIService.generateContextMenu("Pick",script.Parent,Enum.KeyCode.E,Enum.KeyCode.ButtonX,"Pick up your chao.")
UIService.updateContextMenu(script.Parent.Pick,"Name","Pickup")

while wait(1) do
	local pickupStatus = UIService.getContextMenuProperty(script.Parent.Pickup,"Context")
	if script.Parent.Held.Value == false then
		if pickupStatus ~= "Pick" then
			UIService.updateContextMenu(script.Parent.Pickup,"Context","Pick")
			UIService.updateContextMenu(script.Parent.Pickup,"ObjectText","Pick up your chao.")
		end
	else
		if script.Parent.Parent:FindFirstChild("HumanoidRootPart") then
			local velo = script.Parent.Parent.HumanoidRootPart.Velocity.Magnitude
			print("Velo")
			if velo >= 2 then
				if pickupStatus ~= "Throw" then
					UIService.updateContextMenu(script.Parent.Pickup,"Context","Throw")
					UIService.updateContextMenu(script.Parent.Pickup,"ObjectText","Throw your chao.")				
				end
			else
				if pickupStatus ~= "Drop" then
					UIService.updateContextMenu(script.Parent.Pickup,"Context","Drop")
					UIService.updateContextMenu(script.Parent.Pickup,"ObjectText","Place your chao down.")				
				end
			end
		end
	end
end

