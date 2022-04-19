--Makes it so you can feed your chao Chao Drives
local wait = task.wait
--dependancies
local UIService = require(game.ReplicatedStorage.PublicDependancies.UIService)
UIService:GenerateContextMenu("Pick",script.Parent,Enum.KeyCode.E,Enum.KeyCode.ButtonX,"Pick up your chao.")
UIService.updateContextMenu(script.Parent.Pick,"Name","ChaoDrive")

while wait(1) do
	local pickupStatus = UIService:GetContextMenuProperty(script.Parent.Pickup,"Context")
	if script.Parent.Held.Value == false then
		if pickupStatus ~= "Pick" then
			UIService.updateContextMenu(script.Parent.Pickup,"Context","Pick")
			UIService.updateContextMenu(script.Parent.Pickup,"ObjectText","Pick up the chaos drive.")
		end
	else
		if script.Parent.Parent:FindFirstChild("HumanoidRootPart") then
			if pickupStatus ~= "Drop" then
				UIService.updateContextMenu(script.Parent.Pickup,"Context","Drop")
				UIService.updateContextMenu(script.Parent.Pickup,"ObjectText","Place the chaos drive down.")				
			end
		end
	end
end

