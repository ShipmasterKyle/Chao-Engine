local PromptService = game:GetService("ProximityPromptService")
local UIService = require(game.ReplicatedStorage.PublicDependancies.UIService)
local chaoModule = require(game.ReplicatedStorage.PublicDependancies.ChaoModule)

PromptService.PromptTriggered:Connect(function(prompt, player)
	if prompt and player then
		local promptStatus = UIService.getContextMenuProperty(prompt,"Context")
		if prompt.Name == "Pickup" then
			if promptStatus == "Pick" then
				prompt.Parent.Held.Value = true
				prompt.Parent.Parent = player.Character
				--Load Carry Animation
				--Weld to the player
				local humroot = player.Character:FindFirstChild("HumanoidRootPart")
				local chao = prompt.Parent
				chao.CFrame = humroot.CFrame * CFrame.new(0,0,-1)
				local weld = Instance.new("WeldConstraint")
				weld.Part0 = humroot
				weld.Part1 = chao
				weld.Name = "Weld"
				weld.Parent = chao
			end
			if promptStatus == "Drop" then
				local chao = prompt.Parent
				if chao:FindFirstChild("Weld") then
					chao.Held.Value = false
					chao.Weld:Destroy()
					chao.Parent = workspace
				end
			end
			if promptStatus == "Throw" then
				local chao = prompt.Parent
				if chao:FindFirstChild("Weld") then
					chao.Held.Value = false
					local lookVector = chao.Parent.HumanoidRootPart.CFrame.LookVector
					chao.Weld:Destroy()
					chao.Parent = workspace
					chao.Velocity = chao.CFrame:VectorToWorldSpace(Vector3.new(0, 0, -300))
					chaoModule.changeData("Happiness",-10,player.ChaoData)
					if chao.Name == "Egg" then
						chaoModule.newChao()
						chaoModule.Hatch(chao)
					end
				end
			end
		end
		if prompt.Name == "ChaoDrive" then
			local promptStatus = UIService.getContextMenuProperty(prompt,"Context")
			if promptStatus == "Pickup" then
				prompt.Parent.Held.Value = true
				prompt.Parent.Parent = player.Character
				local humroot = player.Character:FindFirstChild("HumanoidRootPart")
				local chao = prompt.Parent
				chao.CFrame = humroot.CFrame * CFrame.new(0,0,-1)
				local weld = Instance.new("WeldConstraint")
				weld.Part0 = humroot
				weld.Part1 = chao
				weld.Name = "Weld"
				weld.Parent = chao
			end
			if promptStatus == "Drop" then
				local chao = prompt.Parent
				if chao:FindFirstChild("Weld") then
					chao.Held.Value = false
					chao.Weld:Destroy()
					chao.Parent = workspace
				end
			end
		end
	end
end)