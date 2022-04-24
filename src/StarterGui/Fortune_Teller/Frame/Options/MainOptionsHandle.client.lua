local camService = require(game.ReplicatedStorage.PublicDependancies.CamService)
local NameSpaceService = require(game.ReplicatedStorage.PublicDependancies.NameSpaceService)
local ourEvent = game.Players.LocalPlayer.PlayerGui:WaitForChild("ShowMainOptions")
local nextEvent = game.Players.LocalPlayer.PlayerGui:WaitForChild("GenerateName")
local finEvent = game.Players.LocalPlayer.PlayerGui:WaitForChild("MakeName")

ourEvent.Event:Connect(function()
	script.Parent.Visible = true
	while wait() do
		for i,v in pairs(script.Parent:GetChildren()) do
			if v:IsA("TextButton") then
				v.MouseButton1Click:Connect(function()
					if v.Name == "Generate" then
						nextEvent:Fire()
						script.Parent.Visible = false
					elseif v.Name == "Solo" then
						finEvent:Fire()
						script.Parent.Visible = false
						script.Parent.Parent.Solo.Visible = true
						script.Parent.TextBox.Visible = true
						script.Parent.Enter.Visible = true
						--Shows the make a name UI
						script.MakeAName.Visible = true
					elseif v.Name == "Exit" then
						camService:StopCam()
						script.Parent.Parent.Visible = false
					elseif v.Name == "Enter" then
						script.Parent.TextBox.Text = NameSpaceService:ModerateName(script.Parent.TextBox.Text)
						game.ReplicatedStorage.Remotes.FinishName:FireServer(script.Parent.TextBox.Text,game.Players.LocalPlayer.Character:FindFirstChild("Held",true).Parent,game.Players.LocalPlayer)
						print("Finalizing Name")
						script.Parent.Parent.Solo.Visible = false
						script.Parent.TextBox.Visible = false
						script.Parent.Enter.Visible = false
					end
				end)
			end
		end
	end
end)