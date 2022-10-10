--Makes it so you can pick up your chao and throw it
local wait = task.wait
--dependancies
local UIService = require(game.ReplicatedStorage.PublicDependancies.UIService)
UIService:GenerateContextMenu("Pick",script.Parent,Enum.KeyCode.E,Enum.KeyCode.ButtonX,"Pickup",true)
local taps = 0
while wait(1) do
	if workspace.currentGarden.Value == "Garden" then
		UIService:UpdateContextMenu(script.Parent.OpenMenu,"Active",true)
		local OpenMenuStatus = UIService:GetContextMenuProperty(script.Parent.OpenMenu,"Context")
		if script.Parent.Held.Value == false then
			if OpenMenuStatus ~= "Pick" or OpenMenuStatus ~= "Pet" then --We'll be able to update this with the help of UserInputService soonish
				UIService:UpdateContextMenu(script.Parent.OpenMenu,"Context","Pick")
				--Here we'll use the ObjectText to tell if the Menu is in Pick or Pet Mode. Its In pick mode by defualt.
				UIService:UpdateContextMenu(script.Parent.OpenMenu,"ObjectText","Pickup")
			end
		else
			if script.Parent.Parent.Parent:FindFirstChild("HumanoidRootPart") then
				local velo = script.Parent.Parent.HumanoidRootPart.Velocity.Magnitude
				print("Velocity: "..velo)--Actually print the velocity.
				--Note that we can't really pet our chao if we're holding them. as such "Throw" and "Put" will ignore status updates.
				if velo >= 2 then
					if OpenMenuStatus ~= "Throw" then
						UIService:UpdateContextMenu(script.Parent.OpenMenu,"Context","Throw")
						UIService:UpdateContextMenu(script.Parent.OpenMenu,"ObjectText","Pickup")				
					end
				else
					if OpenMenuStatus ~= "Drop" then
						UIService:UpdateContextMenu(script.Parent.OpenMenu,"Context","Put")
						UIService:UpdateContextMenu(script.Parent.OpenMenu,"ObjectText","Pickup")				
					end
				end
			end
		end
	else
		UIService:UpdateContextMenu(script.Parent.OpenMenu,"Active",false)
	end
end