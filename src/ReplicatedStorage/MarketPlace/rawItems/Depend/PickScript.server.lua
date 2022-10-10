--Makes it so you can feed your chao Chao Drives
local wait = task.wait
--dependancies
local UIService = require(game.ReplicatedStorage.PublicDependancies.UIService)
UIService:GenerateContextMenu("Pick",script.Parent,Enum.KeyCode.E,Enum.KeyCode.ButtonX,script.Parent:GetAttribute("Type"),true)

while wait(1) do
	local pickupStatus = UIService:GetContextMenuProperty(script.Parent.Pickup,"Context")
	if script.Parent.Held.Value == false then
		if pickupStatus ~= "Pick" then
			UIService.updateContextMenu(script.Parent.Pickup,"Context","Pick")
		end
	else
		if script.Parent.Parent:FindFirstChild("HumanoidRootPart") then
			if pickupStatus ~= "Drop" then
				UIService.updateContextMenu(script.Parent.Pickup,"Context","Put")				
			end
		end
	end
end

