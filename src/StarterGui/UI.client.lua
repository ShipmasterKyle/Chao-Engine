local UIService = require(game.ReplicatedStorage.PublicDependancies.UIService)

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