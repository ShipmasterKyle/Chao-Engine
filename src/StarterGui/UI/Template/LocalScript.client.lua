local MarketService = require(game.ReplicatedStorage.PublicDependancies.MarketService)

script.Parent.MouseButton1Click:Connect(function()
	script.Parent.Parent.Parent.DescBox.MainBox.MoneyBox.PriceTag.Text = MarketService:getItemValue(script.Parent.Name)
	script.Parent.Parent.Parent.DescBox.MainBox.DescBox.DescLabel.Text = script.Parent.Desc.Value
	script.Parent.Parent.Parent.SelectedItem.Value = script.Parent.Name
end)