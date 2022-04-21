local ourEvent = game.Players.LocalPlayer.PlayerGui.ShowMainOptions
local nextEvent = game.Players.LocalPlayer.PlayerGui.GenerateName
local finEvent = game.Players.LocalPlayer.PlayerGui.MakeAName

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
						--Shows the make a name UI
						script.MakeAName.Visible = true
					elseif v.Name == "Enter" then
						game.ReplicatedStorage.Remotes.FinishName:FireServer(v.Parent.Text,game.Players.LocalPlayer.Character:FindFirstChild("Held",true).Parent,game.Players.LocalPlayer)
						print("Finalizing Name")
					end
				end)
			end
		end
	end
end)