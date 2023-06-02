local btn = script.Parent.Buy
local MarketService = require(game.ReplicatedStorage.PublicDependancies.MarketService)

btn.MouseButton1Click:Connect(function()
    MarketService:PurchaseItem(script.Parent.Parent.SelectedItem.Value,game.Players.LocalPlayer)
    btn.Parent.Visible = false
end)

btn.MouseEnter:Connect(function()
    btn.UIStroke.Enabled = true
    btn.BackgroundColor3 = Color3.fromHex('#ff8000')
end)

btn.MouseEnter:Connect(function()
    btn.UIStroke.Enabled = false
    btn.BackgroundColor3 = Color3.fromHex('#d69f78')
end)
