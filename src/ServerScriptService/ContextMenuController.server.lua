local PromptService = game:GetService("ProximityPromptService")
local UIService = require(game.ReplicatedStorage.PublicDependancies.UIService)
local chaoModule = require(game.ReplicatedStorage.PublicDependancies.ChaoModule)
local VisualService = require(game.ReplicatedStorage.PublicDependancies.VisualService)

function dprint(text,i)
    if workspace.Debug.Value == true or i then
        print(text)
    end
end

PromptService.PromptTriggered:Connect(function(prompt, player)
	if prompt and player then
		dprint("Prompt Fired")
		local promptStatus = UIService:GetContextMenuProperty(prompt,"Context")
		local promptState = UIService:GetContextMenuProperty(prompt,"ObjectText")
		dprint("Status "..promptStatus)
		dprint("State "..promptState)
		if promptStatus == "Pet" then
			local chao = prompt.Parent.Parent
			chao.Held.Value = true
			--Play petting anim and sound
			wait(1)
			chaoModule.changeData("ChaoColor",VisualService:returnColor(chao.Parent.Parent),player.Leaderstats[chao.Name])
			chaoModule.changeData("isTwoTone",VisualService:returnTone(chao.Parent.Parent),player.Leaderstats[chao.Name])
			chaoModule.changeData("Happiness",1,player.Leaderstats[chao.Name])
			chaoModule.changeData("AbilityDirection",0.033,player.Leaderstats[chao.Name])
			chao.Held.Value = false
		end
		if promptState == "Pickup" then
			if promptStatus == "Pick" then
				local chao = prompt.Parent.Parent
				chao.HumanoidRootPart.Held.Value = true
				chao.Parent = player.Character
				dprint(prompt.Parent.Parent)
				--Load Carry Animation
				--Weld to the player
				local humroot = player.Character:FindFirstChild("HumanoidRootPart")
				chao:SetPrimaryPartCFrame(humroot.CFrame * CFrame.new(0,0,-1))
				local weld = Instance.new("WeldConstraint")
				weld.Part0 = humroot
				weld.Part1 = chao.PrimaryPart
				weld.Name = "Weld"
				weld.Parent = chao
			end
			if promptStatus == "Put" then
				local chao = prompt.Parent.Parent
				if chao:FindFirstChild("Weld") then
					chao.HumanoidRootPart.Held.Value = false
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
					chaoModule.changeData("Happiness",-1,player.Leaderstats[chao.Name])
					chaoModule.changeData("AbilityDirection",-0.033,player.Leaderstats[chao.Name])
					if not chao:GetAttribute("ChaoState") then
						chaoModule.newChao()
						chaoModule.Hatch(chao)
					end
				end
			end
		end
		if promptState == "ChaoDrive" then
			local promptStatus = UIService:GetContextMenuProperty(prompt,"Context")
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
		if promptStatus == "Fortune Teller" then
			game.ReplicatedStorage.Remotes.StartFortune:FireClient(player)
		end
		if promptStatus == "Bulletin Board" then
			game.ReplicatedStorage.Remotes.BulletinBoard:FireClient(player)
		end
		if promptStatus == "Black Market" then
			game.ReplicatedStorage.Remotes.Market:FireClient(player)
		end
	end
end)