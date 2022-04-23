local awaitEvent = game.Players.LocalPlayer.PlayerGui.AwaitApproval
local nextEvent = game.Players.LocalPlayer.PlayerGui.ApprovalSent

--Connect to the request. We'll need to recieve the quest here since we're gonna send it back
awaitEvent.Event:Connect(function(req,quest)
	if req == "ChaoName" then
		script.Parent.Approve.Text = "I like it!"
		script.Parent.Decline.Text = "I don't like it."
	elseif req ==  "NameIt" then
		script.Parent.Approve.Text = "Make a name for my chao"
		script.Parent.Decline.Text = "Let me name my chao"
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