local awaitEvent = game.Players.LocalPlayer.PlayerGui.AwaitApproval
local nextEvent = game.Players.LocalPlayer.PlayerGui.ApprovalSent

--ourEvent.Event:Connect(function()
--	script.Parent.Visible = true
--	while wait() do
--		for i,v in pairs(script.Parent:GetChildren()) do
--			if v:IsA("TextButton") then
--				v.MouseButton1Click:Connect(function()
--					if v.Name == "Generate" then
--						nextEvent:Fire()
--						script.Parent.Visible = false
--					end
--				end)
--			end
--		end
--	end
--end)

--Connect to the request. We'll need to recieve the quest here since we're gonna send it back
awaitEvent.Event:Connect(function(req,quest)
	if req == "ChaoName" then
		script.Parent.Approve.Text = "I like it!"
		script.Parent.Decline.Text = "I don't like it."
	elseif req ==  "Namei"
	end
	while wait() do
		for i,v in pairs(script.Parent:GetChildren()) do
			if v:IsA("TextButton") then
				v.MouseButton1Click:Connect(function()
					nextEvent:Fire(req,v.Name,quest)
				end)
			end
		end
	end
end)