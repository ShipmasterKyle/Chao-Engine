--[[
    Class
    A simple class tree for every item in the game.
]]

local classes = {
	WoolHat = {
		Name = "Wool Hat",
		Desc = "A warm hat for your chao.",
		isDecor = true,
		Value = "1000",
		Class = "Chao" --Class Name. It'll help us determine what to do with it at certain times.
	},
	WhiteEgg = {
		Name = "White Egg",
		Desc = "A White Egg",
		isDecor = false,
		Value = "400",
		Class = "Chao"
	},
	RedEgg = {
		Name = "Red Egg",
		Desc = "A Red Egg",
		isDecor = false,
		Price = "500",
		Class = "Chao"
	},
	YellowEgg = {
		Name = "Yellow Egg",
		Desc = "A Yellow Egg",
		isDecor = false,
		Price = "500", 
		Class = "Chao"
	},
	BlueEgg = {
		Name = "Blue Egg",
		Desc = "A Blue Egg",
		isDecor = false,
		Price = "500", 
		Class = "Chao"
	},
	SkyBlueEgg = {
		Name = "Sky Blue Egg",
		Desc = "A Sky Blue Egg",
		isDecor = false,
		Price = "600", Class = "Chao"
	},
	PinkEgg = {
		Name = "Pink Egg",
		Desc = "A Pink Egg",
		isDecor = false,
		Price = "600", 
		Class = "Chao"
	},
	OrangeEgg = {
		Name = "Orange Egg",
		Desc = "A Orange Egg",
		isDecor = false,
		Price = "600", 
		Class = "Chao"
	},
	PurpleEggs = {
		Name = "Purple Egg",
		Desc = "A Purple Egg",
		isDecor = false,
		Price = "600", 
		Class = "Chao"
	},
	BrownEgg = {
		Name = "Brown Egg",
		Desc = "A Brown Egg",
		isDecor = false,
		Price = "800",
		Class = "Chao"
	},
	GreenEgg = {
		Name = "Green Egg",
		Desc = "A Green Egg",
		isDecor = false,
		Price = "800",
		Class = "Chao"
	},
	GreyEgg = {
		Name = "Grey Egg",
		Desc = "A Grey Egg",
		isDecor = false,
		Price = "1000",	
		Class = "Chao"
	},
	LimeGreenEgg = {
		Name = "Lime Green Egg",
		Desc = "A Lime Green Egg",
		isDecor = false,
		Price = "1500",
		Class = "Chao"
	},
	BlackEgg = {
		Name = "Black Egg",
		Desc = "A Black Egg",
		isDecor = false,
		Price = "2000",
		Class = "Chao"
	},
	Fruit = {
		Name = "Chao Fruit",
		Desc = "A regular fruit.",
		isDecor = false,
		Value = "50",
		Class = "Food",
	},
	SFruit = {
		Name = "Square Fruit",
		Desc = "A square shaped fruit. Some chao love this.",
		isDecor = false,
		Value = "100",
		Class = "Food"
	},
	RFruit = {
		Name = "Round Fruit",
		Desc = "A round shaped fruit. Some chao love this.",
		isDecor = false,
		Value = "125",
		Class = "Food"
	},
	TFruit = {
		Name = "Triangle Fruit",
		Desc = "A triangle shaped fruit. Some chao love this.",
		isDecor = false,
		Value = "150",
		Class = "Food"
	},
	StFruit = {
		Name = "Strong Fruit",
		Desc = "Help your chao grow stronger. (Power +4)",
		isDecor = false,
		Value = "200",
		Class = "Food"
	},
	TaFruit = {
		Name = "Tasty Fruit",
		Desc = "A tasty fruit that all chao love. Its great for their health too.",
		isDecor = false,
		Value = "350",
		Class = "Food"
	},
	HFruit = {
		Name = "Heart Fruit",
		Desc = "A sweet tasting fruit that gets chao ready to mate.",
		isDecor = false,
		Value = "500",
		Class = "Food"
	},
	SMFruit = {
		Name = "Smart Fruit",
		Desc = "A fruit with riveting flavor that helps your chao learn.",
		isDecor = false,
		Value = "500",
		Class = "Food"
	},
	Mint = {
		Name = "Mint Candy",
		Desc = "A lucky piece of candy sure to give your chao tons of energy. (Luck +25)",
		isDecor = false,
		Value = "800",
		Class = "Food"
	},
	rDrive = {
		Name = "RunDrive",
		Desc = "A chao drive",
		isDecor = false,
		Value = "1",
		Class = "Drive"
	},
	sDrive = {
		Name = "SwimDrive",
		Desc = "A chao drive",
		isDecor = false,
		Value = "1",
		Class = "Drive"
	},
	pDrive = {
		Name = "PowerDrive",
		Desc = "A chao drive",
		isDecor = false,
		Value = "1",
		Class = "Drive"
	},
	fDrive = {
		Name = "FlyDrive",
		Desc = "A chao drive",
		isDecor = false,
		Value = "1",
		Class = "Drive"
	},
	Car = {
		Name = "Toy Car",
		Desc = "A Toy Car that can be won from Chao Races",
		isDecor = false,
		Value = "-1000",
		Class = "Toys"
	}
}
--[[
local tree = {
	Chao = {
		Name = "Chao",
		
		
		
		
		

	},
	Food = {
		Name = "Food",
		
		
		
	},
	Toys = {
		Name = "Toys",
		
	},
	Animals = {
		Name = "Animal",
		Wisps = {
			Name = "Wisps",
			White = {
				Name = "White Wisp",
				Desc = "The White Wisp. Helps make your chao faster. (Running +3)",
				isDecor = false,
				Value = "250"
			},
			Red = {
				Name = "Red Wisp",
				Desc = "The Red Wisp. Helps make your chao stronger. (Power +3)",
				isDecor = false,
				Value = "250"
			},
			Cyan = {
				Name = "Cyan Wisp",
				Desc = "The Cyan Wisp. Helps your chao swim better. (Swim +3)",
				isDecor = false,
				Value = "250"
			},
			Green = {
				Name = "Green Hover",
				Desc = "The Green",
				isDecor = false,
				Value = "250"
			}
		},
		Animals = {
			Name = "Animals",
			Otter = {
				Name = "Otter",
				Desc = "The Otter Animal. Found thoughout stages. Helps make your chao better at swimming at the cost of its power skill. (Swimming +7) (Power -3)",
				isDecor = false,
				Value = "250"
			},
			Penguin = {
				Name = "Penguin",
				Desc = "The Penguin Animal. Found thoughout stages. Helps make your chao better at swimming at the cost of its power skill. (Swimming +7) (Power -3)",
				isDecor = false,
				Value = "250"
			},
			Seal = {
				Name = "Seal",
				Desc = "The Seal Animal. Found thoughout stages. Helps make your chao better at swimming at the cost of its power skill. (Swimming +7) (Power -3)",
				isDecor = false,
				Value = "250"
			},
			Condor = {
				Name = "Condor",
				Desc = "The Condor Animal. Found thoughout stages. Helps make your chao better at flying at the cost of its power skill. (Flying +7) (Power -3)",
				isDecor = false,
				Value = "250"
			},
			Parrot = {
				Name = "Parrot",
				Desc = "The Parrot Animal. Found thoughout stages. Helps make your chao better at flying at the cost of its power skill. (Flying +7) (Power -3)",
				isDecor = false,
				Value = "250"
			},
			Peacock = {
				Name = "Peacock",
				Desc = "The Peacock Animal. Found thoughout stages. Helps make your chao better at flying at the cost of its power skill. (Flying +7) (Power -3)",
				isDecor = false,
				Value = "250"
			},
			Cheatah = {
				Name = "Cheatah",
				Desc = "The Cheatah Animal. Found thoughout stages. Helps make your chao better at running at the cost of its swimming skill. (Run +7) (Swim -3)",
				isDecor = false,
				Value = "250"
			},
			Boar = {
				Name = "Boar",
				Desc = "The Boar Animal. Found thoughout stages. Helps make your chao better at running at the cost of its swimming skill. (Run +7) (Swim -3)",
				isDecor = false,
				Value = "250"
			},
			Rabbit = {
				Name = "Rabbit",
				Desc = "The Rabbit Animal. Found thoughout stages. Helps make your chao better at running at the cost of its swimming skill. (Run +7) (Swim -3)",
				isDecor = false,
				Value = "250"
			},
			Bear = {
				Name = "Bear",
				Desc = "The Bear Animal. Found thoughout stages. Helps make your chao better at stronger at the cost of its swimming skill. (Power +7) (Flying -3)",
				isDecor = false,
				Value = "250"
			},
			Gorrilla = {
				Name = "Monke",
				Desc = "The Gorrilla Animal. Found thoughout stages. Helps make your chao stronger at the cost of its flying skill. (Power +7) (Flying -3)",
				isDecor = false,
				Value = "250"
			},
			Tiger = {
				Name = "Tiger",
				Desc = "The Tiger Animal. Found thoughout stages. Helps make your chao stronger at the cost of its flying skill. (Power +7) (Flying -3)",
				isDecor = false,
				Value = "250"
			},
		},
		ChaoDrives = {
			Name = "ChaoDrive",
			Run = {
				Name = "RunDrive",
				Desc = "The run chao drive. Increases your chao's running skill. Effectiveness depends on Chao's rank in running.",
				isDecor = false,
				Value = "-1"
			},
			Fly = {
				Name = "FlyDrive",
				Desc = "The fly chao drive. Increases your chao's flying skill. Effectiveness depends on Chao's rank in flying.",
				isDecor = false,
				Value = "-1"
			},
			Swim = {
				Name = "SwimDrive",
				Desc = "The swim chao drive. Increases your chao's swimming skill. Effectiveness depends on Chao's rank in swimming.",
				isDecor = false,
				Value = "-1"
			},
			Power = {
				Name = "PowerDrive",
				Desc = "The power chao drive. Increases your chao's power skill. Effectiveness depends on Chao's rank in power.",
				isDecor = false,
				Value = "-1"
			},
		},
	},
	Medals = {
		Name = "Medals"
	}
}
]]--

return classes