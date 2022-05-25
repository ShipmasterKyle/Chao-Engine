--Makes it so you can pick up your chao and throw it
local wait = task.wait
--dependancies
local UIService = require(game.ReplicatedStorage.PublicDependancies.UIService)
UIService:GenerateContextMenu("Pick",script.Parent,Enum.KeyCode.E,Enum.KeyCode.ButtonX,"Pick up your chao.")
UIService:UpdateContextMenu(script.Parent.Pick,"Name","Pickup")
UIService:GenerateContextMenu("Pet",script.Parent.PetAttachment,Enum.KeyCode.Q,Enum.KeyCode.ButtonY, "Pet Your Chao.")

while wait(1) do
	print("Running")
	local pickupStatus = UIService:GetContextMenuProperty(script.Parent.Pickup,"Context")
	if script.Parent.Held.Value == false then
		if pickupStatus ~= "Pick" then
			UIService:UpdateContextMenu(script.Parent.Pickup,"Context","Pick")
			UIService:UpdateContextMenu(script.Parent.Pickup,"ObjectText","Pick up your chao.")
		end
	else
		if script.Parent.Parent.Parent:FindFirstChild("HumanoidRootPart") then
			local velo = script.Parent.Parent.HumanoidRootPart.Velocity.Magnitude
			print("Velocity: "..velo)--Actually print the velocity.
			if velo >= 2 then
				if pickupStatus ~= "Throw" then
					UIService:UpdateContextMenu(script.Parent.Pickup,"Context","Throw")
					UIService:UpdateContextMenu(script.Parent.Pickup,"ObjectText","Throw your chao.")				
				end
			else
				if pickupStatus ~= "Drop" then
					UIService:UpdateContextMenu(script.Parent.Pickup,"Context","Drop")
					UIService:UpdateContextMenu(script.Parent.Pickup,"ObjectText","Place your chao down.")				
				end
			end
		end
	end
end