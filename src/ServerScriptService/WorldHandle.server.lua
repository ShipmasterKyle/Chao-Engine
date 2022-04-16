--[[
	WorldHandle
	Handles Changeing the garden
]]

local theme = workspace.Theme --No need for AudioAttempt for now.
local garden = workspace.currentGarden
local chaoWorld = "rbxassetid://397169354" --Temporary
local neutGarden = "rbxassetid://186088305"
local Kinder = ""
local loading = ""

wait(4)
print("Ready!")
garden.Value = "none"

garden.Changed:Connect(function()
	if garden.Value == "Garden" then
		theme.SoundId = neutGarden
	elseif garden.Value == "Kindergarden" then
		theme.SoundId = Kinder
	else
		theme.SoundId = chaoWorld
	end
end)