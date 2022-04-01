local service = {}

local wait = task.wait
local marketplace = require(game.ReplicatedStorage.MarketPlace.MarketData)

function service:Initialize(plr)
	--Initialize the system
	warn("This system is experimental. It does not save any data at all. Make sure you use everything as you will lose it upon leaving the game.")
	if workspace:FindFirstChild(tostring(plr.Name.." Inventory")) then
		warn("This player's data already exist. Overwriting with a new folder...")
		workspace[plr.Name.." Inventory"]:Destroy()
	else
		print("Writing new folder for player")
	end
	local folder = Instance.new("Folder", workspace)
	folder.Name = tostring(plr.Name.." Inventory")
end

function service:LoadMarket(frame,template)
	if frame and template then
		
	else
		return "Build Error."
	end
end

return service
