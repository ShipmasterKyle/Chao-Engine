local UIService = require(game.ReplicatedStorage.PublicDependancies.UIService)
local MarketService = require(game.ReplicatedStorage.PublicDependancies.MarketService)
local ClassroomService = require(game.ReplicatedStorage.PublicDependancies.Classroom)\
local CamService = require(game.ReplicatedStorage.PublicDependancies.CamService)

local ui = script.Parent.ScreenGui.Frame.GardenLogo
local garden = workspace.currentGarden

game.Players.PlayerAdded:Connect(function()
	print("New Player!")
	repeat wait(1) until game.Players.LocalPlayer.CharacterAppearanceLoaded == true
	print("Ready!")
	ui.Visible = true
	ui.Image = "rbxassetid://8596805320"
	wait(3)
	ui.Visible = false
end)

garden.Changed:Connect(function()
	print(garden.Value)
	if garden.Value ~= "loading" then
		ui.Visible = true
		if garden.Value == "Garden" then
			ui.Image = "rbxassetid://8596788034"
		elseif garden.Value == "Kindergarden" then
			ui.Image = "rbxassetid://8596801475"
		else
			ui.Image = "rbxassetid://8596805320"
		end
		wait(3)
		ui.Visible = false
	else
		script.Parent.ScreenGui.Fade.Visible = true
		wait(1.5)
		script.Parent.ScreenGui.Fade.Visible = false
	end
end)

local plr = game.Players.LocalPlayer

workspace.kinder.Doctor.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") then
		local chaoExistence = plr.Character:FindFirstChild("Held", true)
		if chaoExistence then
			script.Parent.Classroom.Start.Visible = true
			local chao = chaoExistence.Parent
			UIService:CreateViewPort(chao,script.Parent.Basic,true)
		end
	end
end)

workspace.kinder.FortuneTeller.Touched:Connect(function()
	local chaoExistence = plr.Character:FindFirstChild("Held", true)
	if chaoExistence then
		script.Parent.Fortune_Teller.Frame.Visible = true
		script.Parent.StartFortune:Fire()
		local chao = chaoExistence.Parent
		CamService:NewCamPos(workspace.fortune.CamObj.Position,workspace.fortune.MainChair.Position)
	end
end)

--Will be added later
--workspace.kinder.Classroom.Touched:Connect(function()
--	local chao
--	local chaoExistence = plr.Character:FindFirstChild("Held", true)
--	if chaoExistence then
--		local chao = chaoExistence.Parent
--	end
--	script.Parent.StartClassroom:Fire(ClassroomService:GetCurrentLesson(),chao)
--end)

game.ReplicatedStorage.Remotes.BulletinBoard.OnClientEvent:Connect(function()
	script.Parent.Bulletin.Board.Visible = true
end)

game.ReplicatedStorage.Remotes.Market.OnClientEvent:Connect(function()
	local ourplate = script.Template
	local ourFram = script.Parent.Market.ImageLabel.ScrollingFrame
	MarketService:LoadMarket(ourFram,ourplate)
	script.Parent.Market.ImageLabel.Visible = true
end)