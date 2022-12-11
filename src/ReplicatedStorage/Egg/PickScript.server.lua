--Makes it so you can pick up your chao and throw it
local wait = task.wait

function dprint(text,i)
    if workspace.Debug.Value == true or i then
        print(text)
    end
end

--dependancies
local UIService = require(game.ReplicatedStorage.PublicDependancies.UIService)
UIService:GenerateContextMenu("Pick",script.Parent,Enum.KeyCode.E,Enum.KeyCode.ButtonX,"Pickup",true)
local taps = 0
while wait(1) do
	if workspace.currentGarden.Value == "Garden" then
		UIService:UpdateContextMenu(script.Parent.OpenMenu,"Active",true)
		local pickupStatus = UIService:GetContextMenuProperty(script.Parent.OpenMenu,"Context")
		if script.Parent.Held.Value == false then
			if pickupStatus ~= "Pick" then
				UIService:UpdateContextMenu(script.Parent.OpenMenu,"Context","Pick")
			end
		else
			if script.Parent.Parent.Parent:FindFirstChild("HumanoidRootPart") then
				local velo = script.Parent.Velocity.Magnitude
				dprint("Velocity: "..velo)--Actually print the velocity.
				if velo >= 2 then
					if pickupStatus ~= "Throw" then
						UIService:UpdateContextMenu(script.Parent.OpenMenu,"Context","Throw")			
					end
				else
					if pickupStatus ~= "Drop" then
						UIService:UpdateContextMenu(script.Parent.OpenMenu,"Context","Put")			
					end
				end
			end
		end
	else
		UIService:UpdateContextMenu(script.Parent.OpenMenu,"Active",false)
	end
end