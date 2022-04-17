--[[
    VisualService
    A service used to changethe visual appearance of chao based on their stats
]]

local service = {}

--A Class Table for Emotion Ball Types
local headTypes = {
	Hero = {
		Name = "Hero",
		ID = ""
	},
	Dark = {
		Name = "Dark",
		ID = ""
	},
	Normal = {
		Name = "Normal",
		ID = ""
	},
}

local monoColors = {
	White = {
		Name = "White",
		ID = ""
	},
	Blue = {
		Name = "Blue",
		ID = ""
	},
	Red = {
		Name = "Red",
		ID = ""
	},
	Yellow = {
		Name = "Yellow",
		ID = ""
	},
	Orange = {
		Name = "Orange",
		ID = ""
	},
	Sky_Blue = {
		Name = "Sky Blue",
		ID = ""
	},
	Pink = {
		Name = "Pink",
		ID = ""
	},
	Green = {
		Name = "Green",
		ID = ""
	},
	Brown = {
		Name = "Brown",
		ID = ""
	},
	Purple = {
		Name = "Purple",
		ID = ""
	},
	Grey = {
		Name = "Grey",
		ID = ""
	},
	Lime = {
		Name = "Lime",
		ID = ""
	},
	Black = {
		Name = "Black",
		ID = ""
	}
}

local twotoneColor = {
	White = {
		Name = "White",
		Head = "",
		LeftArm = "",
		RightArm = "",
		Body = "",
		LLeg = "",
		RLeg = "",
		Tail = ""
	},
	Blue = {
		Name = "Blue",
		Head = "",
		LeftArm = "",
		RightArm = "",
		Body = "",
		LLeg = "",
		RLeg = "",
		Tail = ""
	},
	Red = {
		Name = "Red",
		Head = "",
		LeftArm = "",
		RightArm = "",
		Body = "",
		LLeg = "",
		RLeg = "",
		Tail = ""
	},
	Yellow = {
		Name = "Yellow",
		Head = "",
		LeftArm = "",
		RightArm = "",
		Body = "",
		LLeg = "",
		RLeg = "",
		Tail = ""
	},
	Orange = {
		Name = "Orange",
		Head = "",
		LeftArm = "",
		RightArm = "",
		Body = "",
		LLeg = "",
		RLeg = "",
		Tail = ""
	},
	Sky_Blue = {
		Name = "Sky Blue",
		Head = "",
		LeftArm = "",
		RightArm = "",
		Body = "",
		LLeg = "",
		RLeg = "",
		Tail = ""
	},
	Pink = {
		Name = "Pink",
		Head = "",
		LeftArm = "",
		RightArm = "",
		Body = "",
		LLeg = "",
		RLeg = "",
		Tail = ""
	},
	Green = {
		Name = "Green",
		Head = "",
		LeftArm = "",
		RightArm = "",
		Body = "",
		LLeg = "",
		RLeg = "",
		Tail = ""
	},
	Brown = {
		Name = "Brown",
		Head = "",
		LeftArm = "",
		RightArm = "",
		Body = "",
		LLeg = "",
		RLeg = "",
		Tail = ""
	},
	Purple = {
		Name = "Purple",
		Head = "",
		LeftArm = "",
		RightArm = "",
		Body = "",
		LLeg = "",
		RLeg = "",
		Tail = ""
	},
	Grey = {
		Name = "Grey",
		Head = "",
		LeftArm = "",
		RightArm = "",
		Body = "",
		LLeg = "",
		RLeg = "",
		Tail = ""
	},
	Lime = {
		Name = "Lime",
		Head = "",
		LeftArm = "",
		RightArm = "",
		Body = "",
		LLeg = "",
		RLeg = "",
		Tail = ""
	},
	Black = {
		Name = "Black",
		Head = "",
		LeftArm = "",
		RightArm = "",
		Body = "",
		LLeg = "",
		RLeg = "",
		Tail = ""
	},
}

local jewels = {
	Gold = {
		Name = "Gold",
		ID = ""
	},
	Silver = {
		Name = "Silver",
		ID = ""
	},
	Emerald = {
		Name = "Emerald",
		ID = ""
	},
	Garnet = {
		Name = "Garnet",
		ID = ""
	},
	Amethyst = {
		Name = "Amethyst",
		ID = ""
	},
	Sapphire = {
		Name = "Sapphire",
		ID = ""
	},
	Peridot = {
		Name = "Peridot",
		ID = ""
	},
	Ruby = {
		Name = "Ruby",
		ID = ""
	},
	Topaz = {
		Name = "Topaz",
		ID = ""
	},
	Aquamarine = {
		Name = "Aquamarine",
		ID = ""
	},
	Onyx = {
		Name = "Onyx",
		ID = ""
	},
	Moon = {
		Name = "Moon",
		ID = ""
	}
}

local animalParts = {
	Otter = {
		Name = "Otter",
		Head = "",
		LeftArm = "",
		RightArm = "",
		Body = "",
		LLeg = "",
		RLeg = "",
		Tail = ""
	},
	Penguin = {
		Name = "Penguin",
		Head = "",
		LeftArm = "",
		RightArm = "",
		Body = "",
		LLeg = "",
		RLeg = "",
		Tail = ""
	},
	Seal = {
		Name = "Seal",
		Head = "",
		LeftArm = "",
		RightArm = "",
		Body = "",
		LLeg = "",
		RLeg = "",
		Tail = ""
	},
	Condor = {
		Name = "Condor",
		Head = "",
		LeftArm = "",
		RightArm = "",
		Body = "",
		LLeg = "",
		RLeg = "",
		Tail = ""
	},
	Parrot = {
		Name = "Parrot",
		Head = "",
		LeftArm = "",
		RightArm = "",
		Body = "",
		LLeg = "",
		RLeg = "",
		Tail = ""
	},
	Peacock = {
		Name = "Peacock",
		Head = "",
		LeftArm = "",
		RightArm = "",
		Body = "",
		LLeg = "",
		RLeg = "",
		Tail = ""
	},
	Cheetah = {
		Name = "Cheatah",
		Head = "",
		LeftArm = "",
		RightArm = "",
		Body = "",
		LLeg = "",
		RLeg = "",
		Tail = ""
	},
	Boar = {
		Name = "Boar",
		Head = "",
		LeftArm = "",
		RightArm = "",
		Body = "",
		LLeg = "",
		RLeg = "",
		Tail = ""
	},
	Rabbit = {
		Name = "Rabbit",
		Head = "",
		LeftArm = "",
		RightArm = "",
		Body = "",
		LLeg = "",
		RLeg = "",
		Tail = ""
	},
	Bear = {
		Name = "Bear",
		Head = "",
		LeftArm = "",
		RightArm = "",
		Body = "",
		LLeg = "",
		RLeg = "",
		Tail = ""
	},
	Gorilla = {
		Name = "Gorilla",
		Head = "",
		LeftArm = "",
		RightArm = "",
		Body = "",
		LLeg = "",
		RLeg = "",
		Tail = ""
	},
	Tiger = {
		Name = "Tiger",
		Head = "",
		LeftArm = "",
		RightArm = "",
		Body = "",
		LLeg = "",
		RLeg = "",
		Tail = ""
	}
}

--Alternative table.find
function service.GetArrayItem(item,array)
	for i,v in pairs(array) do
		if v.Name == item then
			return v
		else end
		return false
	end
end

--Changes the emotion ball
function service:ChangeHeadType(chao,headType)
	if service.GetArrayItem(headTypes,headType)  then
		chao.Emotion.MeshPart.Mesh = service.GetArrayItem(headTypes,headType).ID
		print("HeadType Changed")
	else
		warn("Invalid HeadType")
	end
end

function service:returnTone(chao)
	local item = chao.Head.HeadMesh.Id
	for i,v in pairs(monoColors) do
		if v.Id == item then
			return "mono"
		end
	end
	for i,v in pairs(twotoneColor) do
		if v.Head == item then
			return "two"
		end
	end
end

function service:returnColor(chao)
	local item = chao.Head.HeadMesh.Id
	for i,v in pairs(monoColors) do
		if v.Id == item then
			return v.Name
		end
	end
	for i,v in pairs(twotoneColor) do
		if v.Head == item then
			return v.Name
		end
	end
end
--Changes parts of the chao to animal parts
function service:ChangeBodyPart(chao,part)
	if service.GetArrayItem(chao,part) then
	end
end

--Changes chao color
function service:ColorChao(chao,color,isTwoTone)
	if isTwoTone == false then
		if service.GetArrayItem(monoColors,color) then
			for i,v in pairs(chao:GetDescendants()) do
				if v:IsA("SpecialMesh") then
					if not v.Name == "Eyes" then
						v.TextureId = service.GetArrayItem(monoColors,color).ID
						print("Changed Chao Part")
					end
				end
			end
		end
	else
		if service.GetArrayItem(monoColors,color) then
			for i,v in pairs(chao:GetDescendants()) do
				if v:IsA("SpecialMesh") then
					if not v.Name == "Eyes" then
						if service.GetArrayItem(monoColors[color],v.Name) then
							v.TextureId = service.GetArrayItem(monoColors,color)[v.Name]
							print("Changed Chao Part")
						end
					end
				end
			end
		end
	end
end

--Colors Shiny or Jewel Chao
function service:ShineChao(chao,color,class)
	if class == "Jewel" then
		if service.GetArrayItem(jewels,color) then
			for i,v in pairs(chao:GetDescendants()) do
				if v:IsA("SpecialMesh") then
					if not v.Name == "Eyes" then
						v.TextureId = service.GetArrayItem(jewels,color).ID
					end
				end
			end
		end
	elseif class == "Shiny" then
		if service.GetArrayItem(monoColors,color) then
			for i,v in pairs(chao:GetDescendants()) do
				if v:IsA("SpecialMesh") then
					if not v.Name == "Eyes" then
						v.TextureId = service.GetArrayItem(monoColors,color)[v.Name]
						v.Material = Enum.Material.SmoothPlastic
						v.Reflectance = 1
						print("Shiny Chao Made")
					end
				end
			end
		end
	end
end

return service