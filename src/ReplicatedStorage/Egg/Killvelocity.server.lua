 script.Parent.Touched:Connect(function(hit)
	if hit.Parent.Name == "Wall" then
		script.Parent.Velocity *= 0
	end
end)