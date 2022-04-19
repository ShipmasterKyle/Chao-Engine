local ourEvent = game.Players.LocalPlayer.PlayerGui.ShowMainOptions
local nextEvent = game.Players.LocalPlayer.PlayerGui.GenerateName

ourEvent.Event:Connect(function()
	script.Parent.Visible = true
	while wait() do
		for i,v in pairs(script.Parent:GetChildren()) do
			if v:IsA("TextButton") then
				v.MouseButton1Click:Connect(function()
					if v.Name == "Generate" then
						nextEvent:Fire()
						script.Parent.Visible = false
					end
				end)
			end
		end
	end
end)